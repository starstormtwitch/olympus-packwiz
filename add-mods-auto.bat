@echo off
echo ========================================
echo Adding Mods from Modrinth (Auto Mode)
echo ========================================
echo.

REM Check if packwiz.exe exists
if not exist "packwiz.exe" (
    echo ERROR: packwiz.exe not found!
    pause
    exit /b 1
)

echo Adding mods automatically...
echo This may take several minutes...
echo.

REM Core mods
echo [1/25] Adding Fabric API...
.\packwiz.exe modrinth install fabric-api -y
echo.

echo [2/25] Adding Fabric Language Kotlin...
.\packwiz.exe modrinth install fabric-language-kotlin -y
echo.

echo [3/25] Adding Architectury API...
.\packwiz.exe modrinth install architectury-api -y
echo.

echo [4/25] Adding Create...
.\packwiz.exe modrinth install create-fabric -y
echo.

echo [5/25] Adding JEI...
.\packwiz.exe modrinth install jei -y
echo.

echo [6/25] Adding FTB Library...
.\packwiz.exe modrinth install ftb-library-fabric -y
echo.

echo [7/25] Adding FTB Teams...
.\packwiz.exe modrinth install ftb-teams-fabric -y
echo.

echo [8/25] Adding FTB Chunks...
.\packwiz.exe modrinth install ftb-chunks-fabric -y
echo.

echo [9/25] Adding Farmers Delight...
.\packwiz.exe modrinth install farmers-delight-fabric -y
echo.

echo [10/25] Adding Immersive Aircraft...
.\packwiz.exe modrinth install immersive-aircraft -y
echo.

echo [11/25] Adding Polymorph...
.\packwiz.exe modrinth install polymorph -y
echo.

echo [12/25] Adding Distant Horizons...
.\packwiz.exe modrinth install distant-horizons -y
echo.

echo [13/25] Adding Structory...
.\packwiz.exe modrinth install structory -y
echo.

echo [14/25] Adding Structory Towers...
.\packwiz.exe modrinth install structory-towers -y
echo.

echo [15/25] Adding Dungeons Arise...
.\packwiz.exe modrinth install dungeons-arise -y
echo.

echo [16/25] Adding Steam Rails...
.\packwiz.exe modrinth install steam-rails -y
echo.

echo [17/25] Adding Goblin Traders...
.\packwiz.exe modrinth install goblin-traders -y
echo.

echo [18/25] Adding Universal Shops...
.\packwiz.exe modrinth install universal-shops -y
echo.

echo [19/25] Adding AppleSkin...
.\packwiz.exe modrinth install appleskin -y
echo.

echo [20/25] Adding Clumps...
.\packwiz.exe modrinth install clumps -y
echo.

echo [21/25] Adding Inventory Sorter...
.\packwiz.exe modrinth install inventory-sorter -y
echo.

echo [22/25] Adding Mod Menu...
.\packwiz.exe modrinth install modmenu -y
echo.

echo [23/25] Adding Sodium...
.\packwiz.exe modrinth install sodium -y
echo.

echo [24/25] Adding Indium...
.\packwiz.exe modrinth install indium -y
echo.

echo [25/25] Adding Bookshelf...
.\packwiz.exe modrinth install bookshelf -y
echo.

echo.
echo ========================================
echo Mod Addition Complete!
echo ========================================
echo.
echo All mods have been added to the mod pack.
echo Next step: Run export-modpack.bat to create the .mrpack file
echo.
pause

