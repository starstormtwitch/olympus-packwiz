param(
    [string]$ConfigPath = "config/cloudflare-ddns.json"
)

$ErrorActionPreference = "Stop"
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Split-Path $scriptDir -Parent
Set-Location $repoRoot

if (-not (Test-Path $ConfigPath)) {
    Write-Error "Config file '$ConfigPath' not found. Copy config-samples/cloudflare-ddns.sample.json and fill in your values."
    exit 1
}

try {
    $config = Get-Content -Raw $ConfigPath | ConvertFrom-Json
}
catch {
    Write-Error "Unable to parse $ConfigPath: $($_.Exception.Message)"
    exit 1
}

foreach ($key in @('zone_id','record_name','api_token')) {
    if (-not $config.$key) {
        Write-Error "Config missing required field '$key'."
        exit 1
    }
}

$ttl = if ($config.ttl) { [int]$config.ttl } else { 300 }
$proxied = if ($null -ne $config.proxied) { [bool]$config.proxied } else { $false }

Write-Host "Fetching current public IP..."
$publicIp = (Invoke-RestMethod -UseBasicParsing https://api.ipify.org).ToString().Trim()
if (-not [System.Net.IPAddress]::TryParse($publicIp, [ref]([System.Net.IPAddress]$null))) {
    Write-Error "ipify returned invalid IP: $publicIp"
    exit 1
}

$headers = @{ "Authorization" = "Bearer $($config.api_token)"; "Content-Type" = "application/json" }
$zoneId = $config.zone_id
$recordName = $config.record_name.Trim().ToLower()
$recordId = $config.record_id

if (-not $recordId) {
    Write-Host "Looking up DNS record for $recordName..."
    $lookupUrl = "https://api.cloudflare.com/client/v4/zones/$zoneId/dns_records?type=A&name=$recordName"
    $lookupResponse = Invoke-RestMethod -Method Get -Uri $lookupUrl -Headers $headers
    if (-not $lookupResponse.success -or $lookupResponse.result.Count -eq 0) {
        Write-Error "Could not find existing A record for $recordName. Create it manually in Cloudflare first."
        exit 1
    }
    $recordId = $lookupResponse.result[0].id
}
else {
    Write-Host "Using record id $recordId"
}

$recordUrl = "https://api.cloudflare.com/client/v4/zones/$zoneId/dns_records/$recordId"
$currentRecord = Invoke-RestMethod -Method Get -Uri $recordUrl -Headers $headers
if (-not $currentRecord.success) {
    Write-Error "Failed to fetch existing record: $($currentRecord.errors | ConvertTo-Json -Compress)"
    exit 1
}
$currentIp = $currentRecord.result.content
if ($currentIp -eq $publicIp -and $currentRecord.result.proxied -eq $proxied) {
    Write-Host "Record already points to $publicIp (proxied=$proxied). No update needed." -ForegroundColor Green
    exit 0
}

Write-Host "Updating $recordName from $currentIp to $publicIp (proxied=$proxied)..."
$body = @{ type = "A"; name = $recordName; content = $publicIp; ttl = $ttl; proxied = $proxied } | ConvertTo-Json
$response = Invoke-RestMethod -Method Put -Uri $recordUrl -Headers $headers -Body $body
if ($response.success) {
    Write-Host "Updated successfully." -ForegroundColor Green
} else {
    Write-Error "Cloudflare API error: $($response.errors | ConvertTo-Json -Compress)"
    exit 1
}