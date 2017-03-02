@echo off

set rar="%ProgramFiles%\WinRAR\Rar.exe"
set unrar="%programFiles%\WinRAR\UnRAR.exe"
set winrar="%programFiles%\WinRAR\WinRAR.exe"

set DEX2JAR=dex2jar-2.0\
set JDGUI="jd-gui-windows-1.4.0\jd-gui.exe"

set SRC=classes.dex
set BAT=d2j-dex2jar.bat
set DESTJAR=classes-dex2jar.jar

del %~dp0*.jar

setlocal enabledelayedexpansion
for %%f in (*.apk) do (
    REM unrar apk and %~dp0 is the dir which batch exist
    rename %%~nf.apk %%~nf.rar
    %winrar% x "%~dp0%%~nf.rar" "%~dp0%%~nf\"
    rename %%~nf.rar %%~nf.apk
    REM move src to target dir
    move %~dp0%%~nf\%SRC%  %~dp0%DEX2JAR%
    REM remove src dir
    @RD /S /Q "%~dp0%%~nf\"
    REM call d2j-dex2jar.bat, use --force option to overwrite
    call %~dp0%DEX2JAR%%BAT% %~dp0%DEX2JAR%%SRC% --force
    REM rename DESTJAR
    echo %~dp0%DESTJAR%
    echo %~dp0%%~nf.jar
   
    ren %~dp0%DESTJAR% %%~nf.jar
    REM remove SRC
    del %~dp0%DEX2JAR%%SRC%
    REM call jd-gui
    %JDGUI% %~dp0%%~nf.jar
)

