@echo off
echo ========================================
echo Exporting Mod Pack to Modrinth Format
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

echo Exporting mod pack to .mrpack format...
echo This may take a few moments...
echo.

REM Export to .mrpack format
.\packwiz.exe modrinth export

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo Mod Pack Exported Successfully!
    echo ========================================
    echo.
    
    REM Check for the exported file
    if exist "Olympus-Server.mrpack" (
        echo The mod pack file has been created: Olympus-Server.mrpack
        echo.
        echo File location: %CD%\Olympus-Server.mrpack
        echo.
    ) else (
        REM Check for any .mrpack file
        for %%f in (*.mrpack) do (
            echo The mod pack file has been created: %%~nxf
            echo.
            echo File location: %CD%\%%~nxf
            echo.
            goto :found
        )
        echo Warning: Could not find the exported .mrpack file.
        echo It may have been created with a different name.
        :found
    )
    
    echo ========================================
    echo Next Steps:
    echo ========================================
    echo.
    echo 1. Upload the .mrpack file to Modrinth:
    echo    - Go to https://modrinth.com
    echo    - Create a mod pack project
    echo    - Upload the .mrpack file
    echo    - Share the link with players
    echo.
    echo 2. Or share the .mrpack file directly:
    echo    - Players can download it
    echo    - Install it using Modrinth App
    echo    - Or import it manually
    echo.
    echo 3. Update SERVER_INFO.txt with your server IP
    echo    - Players will need this to connect
    echo.
) else (
    echo.
    echo ========================================
    echo ERROR: Failed to Export Mod Pack!
    echo ========================================
    echo.
    echo Possible issues:
    echo - Missing mods or dependencies
    echo - Invalid pack.toml configuration
    echo - Network issues connecting to Modrinth
    echo.
    echo Please check the error messages above and try again.
    echo.
)

pause

