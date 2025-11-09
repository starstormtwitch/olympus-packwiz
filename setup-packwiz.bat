@echo off
echo ========================================
echo Packwiz Setup for Olympus Server
echo ========================================
echo.

REM Check if packwiz.exe exists in current directory
if not exist "packwiz.exe" (
    echo ERROR: packwiz.exe not found in current directory!
    echo.
    echo Please download packwiz from:
    echo https://github.com/packwiz/packwiz/releases
    echo.
    echo Download packwiz.exe and place it in this directory.
    echo After installing packwiz, run this script again.
    echo.
    pause
    exit /b 1
)

echo Packwiz found! Initializing mod pack...
echo.

REM Initialize Packwiz - this will create pack.toml and index.toml
echo Creating pack.toml configuration...
.\packwiz.exe init --name "Olympus Server" --author "StarStorm" --version "1.0.0" --mc-version "1.20.1" --modloader "fabric" --fabric-latest -y

if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to initialize Packwiz!
    echo.
    echo Please make sure packwiz is properly installed.
    echo If pack.toml already exists, you may need to delete it first.
    pause
    exit /b 1
)

echo.
echo ========================================
echo Setup Complete!
echo ========================================
echo.
echo Next steps:
echo 1. Run add-mods-manual.bat to add mods from Modrinth
echo 2. Or run add-client-mods.bat to add mods from your mods folder
echo 3. Run export-modpack.bat to create the .mrpack file
echo.
echo Note: Server-only mods will be automatically excluded.
echo.
pause

