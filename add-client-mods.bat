@echo off
echo ========================================
echo Adding Client-Side Mods to Packwiz
echo ========================================
echo.

REM Check if packwiz.exe exists
if not exist "packwiz.exe" (
    echo ERROR: packwiz.exe not found! Please run setup-packwiz.bat first.
    pause
    exit /b 1
)

REM Check if pack.toml exists
if not exist "pack.toml" (
    echo ERROR: pack.toml not found! Please run setup-packwiz.bat first.
    pause
    exit /b 1
)

echo This script will scan your mods folder and add client-side mods.
echo Server-only mods will be automatically excluded.
echo.
pause

REM Server-only mods to skip (case-insensitive matching)
set SERVER_ONLY=anti-xray atlas biomespawnpoint ftbbackups2 PlanFabric ledger lithium krypton Neruina global_packs

echo Scanning mods folder...
echo.

setlocal enabledelayedexpansion
set added=0
set skipped=0

for %%f in (mods\*.jar) do (
    set "modfile=%%~nxf"
    set "modname=%%~nf"
    set "skip=0"
    
    REM Check if this is a server-only mod
    for %%s in (%SERVER_ONLY%) do (
        echo !modname! | findstr /i "%%s" >nul
        if !ERRORLEVEL! EQU 0 (
            echo [SKIP] Server-only mod: !modfile!
            set /a skipped+=1
            set "skip=1"
            goto :nextmod
        )
    )
    
    if !skip! EQU 0 (
        echo [ADD] !modfile!
        REM Try to add as local file first (for custom mods)
        .\packwiz.exe file add "%%f" --name "!modname!" >nul 2>&1
        if !ERRORLEVEL! EQU 0 (
            set /a added+=1
        ) else (
            echo   Warning: Could not add !modfile! automatically.
            echo   You may need to add it manually using: packwiz modrinth install
        )
    )
    
    :nextmod
)

echo.
echo ========================================
echo Summary
echo ========================================
echo Mods added: !added!
echo Mods skipped (server-only): !skipped!
echo.
echo Note: Some mods may need to be added manually from Modrinth.
echo Run add-mods-manual.bat to add mods from Modrinth repositories.
echo.
pause

