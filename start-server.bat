@echo off
setlocal enabledelayedexpansion
REM Set the maximum and initial memory allocation to 4GB
set MAX_RAM=4G
set MIN_RAM=4G

REM Prefer bundled Java 17 if present
set "JAVA_BIN=%~dp0runtime\jdk-17.0.17+10-jre\bin\java.exe"
if exist "%JAVA_BIN%" (
    set "JAVA_CMD=%JAVA_BIN%"
) else (
    echo [WARN] Bundled Java not found, falling back to system java on PATH.
    set "JAVA_CMD=java"
)

"%JAVA_CMD%" -Xmx%MAX_RAM% -Xms%MIN_RAM% -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -jar fabric-server-launch.jar

pause
