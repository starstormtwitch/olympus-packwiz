param(
    [string]$Version = "1.0.0",
    [string]$OutputDir = "deploy/packwiz",
    [switch]$SkipMrpack
)

$ErrorActionPreference = "Stop"
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Split-Path -Parent $scriptDir
$packwizExe = Join-Path $repoRoot "packwiz.exe"
if (-not (Test-Path $packwizExe)) {
    throw "packwiz.exe not found at $packwizExe"
}

$distDir = Join-Path $repoRoot "dist"
if (-not (Test-Path $distDir)) {
    New-Item -ItemType Directory -Path $distDir | Out-Null
}

Write-Host "[1/4] Refreshing Packwiz index..."
& $packwizExe refresh --build | Write-Output

if (-not $SkipMrpack) {
    $mrpackPath = Join-Path $distDir ("Olympus-{0}.mrpack" -f $Version)
    Write-Host "[2/4] Exporting Modrinth bundle to $mrpackPath"
    & $packwizExe modrinth export -o $mrpackPath | Write-Output
    if (-not (Test-Path $mrpackPath)) {
        throw "Modrinth export failed; $mrpackPath not found"
    }
} else {
    Write-Host "[2/4] Skipping Modrinth export per flag"
}

$deployPath = Join-Path $repoRoot $OutputDir
Write-Host "[3/4] Preparing Packwiz web manifest at $deployPath"
if (Test-Path $deployPath) {
    Remove-Item $deployPath -Recurse -Force
}
New-Item -ItemType Directory -Force -Path $deployPath | Out-Null

$filesToCopy = @("pack.toml","index.toml","packwiz.lock.toml")
foreach ($file in $filesToCopy) {
    $full = Join-Path $repoRoot $file
    if (Test-Path $full) {
        Copy-Item $full -Destination $deployPath -Force
    }
}

Get-ChildItem -Path $repoRoot -Recurse -Filter "*.pw.toml" | ForEach-Object {
    $relative = $_.FullName.Substring($repoRoot.Length).TrimStart('\','/')
    $target = Join-Path $deployPath $relative
    $targetDir = Split-Path $target -Parent
    if (-not (Test-Path $targetDir)) {
        New-Item -ItemType Directory -Force -Path $targetDir | Out-Null
    }
    Copy-Item $_.FullName -Destination $target -Force
}

Write-Host "[4/4] Packwiz manifest ready; host $OutputDir/pack.toml at https://play.<domain>/packwiz/pack.toml"

