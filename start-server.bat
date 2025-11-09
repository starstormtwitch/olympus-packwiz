@echo off
REM Set the maximum and initial memory allocation to 4GB
set MAX_RAM=4G
set MIN_RAM=4G

REM Run the Fabric server with optimized JVM flags for better performance
java -Xmx%MAX_RAM% -Xms%MIN_RAM% -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -jar fabric-server-launch.jar

REM Pause the script to keep the command prompt open
pause
