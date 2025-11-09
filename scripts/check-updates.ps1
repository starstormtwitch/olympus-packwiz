param(
    [switch]$ApplyUpdates,
    [string]$TargetMinecraftVersion = "1.20.4",
    [string]$TargetLoader = "fabric"
)

$ErrorActionPreference = "Stop"
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Split-Path $scriptDir -Parent
Set-Location $repoRoot

function Ensure-CleanWorkingTree {
    $status = git status --porcelain
    if ($status) {
        Write-Error "Working tree has uncommitted changes. Commit or stash before running this script."
        exit 1
    }
}

Ensure-CleanWorkingTree

$packwizExe = Join-Path $repoRoot "packwiz.exe"
if (-not (Test-Path $packwizExe)) {
    Write-Error "packwiz.exe not found in $repoRoot"
    exit 1
}

$reportDir = Join-Path $repoRoot "reports"
if (-not (Test-Path $reportDir)) {
    New-Item -ItemType Directory -Path $reportDir | Out-Null
}
$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$reportPath = Join-Path $reportDir "update-report-$timestamp.md"

Write-Host "Refreshing Packwiz index..."
& $packwizExe refresh --build | Out-Host

Write-Host "Checking for mod updates via packwiz update -a..."
$updateOutput = & $packwizExe update -a 2>&1

$changes = git status --porcelain
$diffText = ''
if ($changes) {
    $diffText = git diff
    if (-not $ApplyUpdates) {
        git checkout -- . | Out-Null
    }
}
else {
    Write-Host "All mods already on the pinned versions."
}

$compatReport = @()
$modsDir = Join-Path $repoRoot 'mods'
foreach ($metaFile in Get-ChildItem -Path $modsDir -Filter '*.pw.toml') {
    $text = Get-Content -Raw $metaFile.FullName
    $modName = [System.IO.Path]::GetFileNameWithoutExtension($metaFile.Name)
    if ($text -match '\[update\.modrinth][^[]*mod-id\s*=\s*"(?<id>[^"]+)"') {
        $modId = $Matches['id']
        $encoded = "https://api.modrinth.com/v2/project/$modId/version?game_versions=%5B%22$TargetMinecraftVersion%22%5D&loaders=%5B%22$TargetLoader%22%5D"
        try {
            $response = Invoke-WebRequest -UseBasicParsing -Uri $encoded -Headers @{"User-Agent"="olympus-packwiz"}
            $versions = @()
            if ($response.Content) {
                $versions = $response.Content | ConvertFrom-Json
            }
            if ($versions -and $versions.Count -gt 0) {
                $compatReport += [pscustomobject]@{ Mod = $modName; Source = "Modrinth"; ModId = $modId; TargetSupport = "Available"; Note = "Found $($versions[0].version_number)" }
            }
            else {
                $compatReport += [pscustomobject]@{ Mod = $modName; Source = "Modrinth"; ModId = $modId; TargetSupport = "Missing"; Note = "No $TargetMinecraftVersion release" }
            }
        }
        catch {
            $compatReport += [pscustomobject]@{ Mod = $modName; Source = "Modrinth"; ModId = $modId; TargetSupport = "Error"; Note = $_.Exception.Message }
        }
    }
    else {
        $compatReport += [pscustomobject]@{ Mod = $modName; Source = "Manual"; ModId = "-"; TargetSupport = "Unknown"; Note = "No Modrinth metadata" }
    }
}

$reportBuilder = [System.Text.StringBuilder]::new()
$null = $reportBuilder.AppendLine("# Olympus Pack Update Report ($timestamp)")
$null = $reportBuilder.AppendLine()
$null = $reportBuilder.AppendLine("## Packwiz update output")
$null = $reportBuilder.AppendLine('```')
$null = $reportBuilder.AppendLine(($updateOutput -join [Environment]::NewLine))
$null = $reportBuilder.AppendLine('```')

if ($changes) {
    $null = $reportBuilder.AppendLine()
    $null = $reportBuilder.AppendLine("## Pending changes after packwiz update")
    $null = $reportBuilder.AppendLine('```')
    $null = $reportBuilder.AppendLine(($changes -join [Environment]::NewLine))
    $null = $reportBuilder.AppendLine('```')
    $null = $reportBuilder.AppendLine()
    $null = $reportBuilder.AppendLine("### Diff")
    $null = $reportBuilder.AppendLine('```')
    $null = $reportBuilder.AppendLine($diffText)
    $null = $reportBuilder.AppendLine('```')
}
else {
    $null = $reportBuilder.AppendLine()
    $null = $reportBuilder.AppendLine("No files changed by packwiz update - mods already match the locked versions.")
}

$null = $reportBuilder.AppendLine()
$null = $reportBuilder.AppendLine("## Modrinth support for Minecraft $TargetMinecraftVersion ($TargetLoader)")
$compatReport | Sort-Object TargetSupport, Mod | ForEach-Object {
    $null = $reportBuilder.AppendLine("- $($_.Mod): $($_.TargetSupport) ($($_.Note))")
}

Set-Content -Path $reportPath -Value $reportBuilder.ToString()

Write-Host "Report written to $reportPath"
if ($changes -and -not $ApplyUpdates) {
    Write-Host "Pack files were restored to the committed state. Re-run with -ApplyUpdates if you want to keep the changes."
}
