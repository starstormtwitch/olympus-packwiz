@echo off
echo ========================================
echo Updating Mod Pack
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

echo This will update all mods in the mod pack to their latest versions.
echo.
echo Warning: Updating mods may cause compatibility issues!
echo Make sure to test the updated mod pack before distributing it.
echo.
pause

echo.
echo Updating all mods...
echo.

REM Update all mods
.\packwiz.exe update --all

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo Mods Updated Successfully!
    echo ========================================
    echo.
    echo Next steps:
    echo 1. Test the updated mod pack locally
    echo 2. Make sure all mods are compatible
    echo 3. Update the version number in pack.toml if needed
    echo 4. Run export-modpack.bat to create the updated .mrpack file
    echo.
) else (
    echo.
    echo ========================================
    echo Warning: Some Mods May Not Have Updated
    echo ========================================
    echo.
    echo Some mods may have failed to update.
    echo Check the output above for any errors.
    echo.
    echo You can try updating individual mods using:
    echo packwiz update <mod-name>
    echo.
)

pause

