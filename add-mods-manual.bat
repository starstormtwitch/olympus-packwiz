@echo off
echo ========================================
echo Manual Mod Addition from Modrinth
echo ========================================
echo.

REM Check if packwiz.exe exists
if not exist "packwiz.exe" (
    echo ERROR: packwiz.exe not found! Please run setup-packwiz.bat first.
    pause
    exit /b 1
)

echo This script will add mods from Modrinth by their project IDs.
echo.
echo Note: Some mods may have different names on Modrinth.
echo If a mod fails to install, you may need to add it manually.
echo.
pause

echo.
echo Adding essential mods...
echo.

REM Fabric API (required base mod)
echo [1/25] Adding Fabric API...
.\packwiz.exe modrinth install fabric-api --version "0.92.5+1.20.1"
if %ERRORLEVEL% NEQ 0 echo   Warning: Failed to add Fabric API

REM Fabric Language Kotlin
echo [2/25] Adding Fabric Language Kotlin...
.\packwiz.exe modrinth install fabric-language-kotlin --version "1.13.2+kotlin.2.1.20"
if %ERRORLEVEL% NEQ 0 echo   Warning: Failed to add Fabric Language Kotlin

REM Architectury
echo [3/25] Adding Architectury API...
.\packwiz.exe modrinth install architectury-api --version "9.2.14"
if %ERRORLEVEL% NEQ 0 echo   Warning: Failed to add Architectury API

REM Create
echo [4/25] Adding Create...
.\packwiz.exe modrinth install create-fabric --version "0.5.1"
if %ERRORLEVEL% NEQ 0 echo   Warning: Failed to add Create

REM JEI
echo [5/25] Adding JEI...
.\packwiz.exe modrinth install jei --version "15.20.0.106"
if %ERRORLEVEL% NEQ 0 echo   Warning: Failed to add JEI

REM FTB Library
echo [6/25] Adding FTB Library...
.\packwiz.exe modrinth install ftb-library-fabric --version "2001.2.9"
if %ERRORLEVEL% NEQ 0 echo   Warning: Failed to add FTB Library

REM FTB Teams
echo [7/25] Adding FTB Teams...
.\packwiz.exe modrinth install ftb-teams-fabric --version "2001.3.1"
if %ERRORLEVEL% NEQ 0 echo   Warning: Failed to add FTB Teams

REM FTB Chunks
echo [8/25] Adding FTB Chunks...
.\packwiz.exe modrinth install ftb-chunks-fabric --version "2001.3.5"
if %ERRORLEVEL% NEQ 0 echo   Warning: Failed to add FTB Chunks

REM Farmers Delight
echo [9/25] Adding Farmers Delight...
.\packwiz.exe modrinth install farmers-delight-fabric --version "2.3.0"
if %ERRORLEVEL% NEQ 0 echo   Warning: Failed to add Farmers Delight

REM Immersive Aircraft
echo [10/25] Adding Immersive Aircraft...
.\packwiz.exe modrinth install immersive-aircraft --version "1.2.2"
if %ERRORLEVEL% NEQ 0 echo   Warning: Failed to add Immersive Aircraft

REM Polymorph
echo [11/25] Adding Polymorph...
.\packwiz.exe modrinth install polymorph --version "0.49.9"
if %ERRORLEVEL% NEQ 0 echo   Warning: Failed to add Polymorph

REM Distant Horizons
echo [12/25] Adding Distant Horizons...
.\packwiz.exe modrinth install distant-horizons --version "2.3.2-b"
if %ERRORLEVEL% NEQ 0 echo   Warning: Failed to add Distant Horizons

REM Structory
echo [13/25] Adding Structory...
.\packwiz.exe modrinth install structory --version "1.3.5"
if %ERRORLEVEL% NEQ 0 echo   Warning: Failed to add Structory

REM Structory Towers
echo [14/25] Adding Structory Towers...
.\packwiz.exe modrinth install structory-towers --version "1.0.7"
if %ERRORLEVEL% NEQ 0 echo   Warning: Failed to add Structory Towers

REM Dungeons Arise
echo [15/25] Adding Dungeons Arise...
.\packwiz.exe modrinth install dungeons-arise --version "2.1.58"
if %ERRORLEVEL% NEQ 0 echo   Warning: Failed to add Dungeons Arise

REM Steam Rails
echo [16/25] Adding Steam Rails...
.\packwiz.exe modrinth install steam-rails --version "1.6.9"
if %ERRORLEVEL% NEQ 0 echo   Warning: Failed to add Steam Rails

REM Goblin Traders
echo [17/25] Adding Goblin Traders...
.\packwiz.exe modrinth install goblin-traders --version "1.9.3"
if %ERRORLEVEL% NEQ 0 echo   Warning: Failed to add Goblin Traders

REM Universal Shops
echo [18/25] Adding Universal Shops...
.\packwiz.exe modrinth install universal-shops --version "1.3.2"
if %ERRORLEVEL% NEQ 0 echo   Warning: Failed to add Universal Shops

REM AppleSkin
echo [19/25] Adding AppleSkin...
.\packwiz.exe modrinth install appleskin --version "2.5.1"
if %ERRORLEVEL% NEQ 0 echo   Warning: Failed to add AppleSkin

REM Clumps
echo [20/25] Adding Clumps...
.\packwiz.exe modrinth install clumps --version "12.0.0.4"
if %ERRORLEVEL% NEQ 0 echo   Warning: Failed to add Clumps

REM Inventory Sorter
echo [21/25] Adding Inventory Sorter...
.\packwiz.exe modrinth install inventory-sorter --version "1.9.0"
if %ERRORLEVEL% NEQ 0 echo   Warning: Failed to add Inventory Sorter

REM Mod Menu
echo [22/25] Adding Mod Menu...
.\packwiz.exe modrinth install modmenu --version "7.2.2"
if %ERRORLEVEL% NEQ 0 echo   Warning: Failed to add Mod Menu

REM Sodium (client performance)
echo [23/25] Adding Sodium...
.\packwiz.exe modrinth install sodium --version "0.5.13"
if %ERRORLEVEL% NEQ 0 echo   Warning: Failed to add Sodium

REM Indium (for Sodium compatibility)
echo [24/25] Adding Indium...
.\packwiz.exe modrinth install indium --version "1.0.36"
if %ERRORLEVEL% NEQ 0 echo   Warning: Failed to add Indium

REM Bookshelf
echo [25/25] Adding Bookshelf...
.\packwiz.exe modrinth install bookshelf --version "20.2.13"
if %ERRORLEVEL% NEQ 0 echo   Warning: Failed to add Bookshelf

echo.
echo ========================================
echo Mod Addition Complete!
echo ========================================
echo.
echo Note: Some mods may have failed to install automatically.
echo Check the output above for any warnings.
echo.
echo If mods failed to install, you can:
echo 1. Try adding them manually using: .\packwiz.exe modrinth install <mod-name>
echo 2. Or add them as local files using: packwiz file add <path-to-mod.jar>
echo.
echo Next step: Run export-modpack.bat to create the .mrpack file
echo.
pause

