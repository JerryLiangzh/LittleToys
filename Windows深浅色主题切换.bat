@echo off
chcp 65001 >nul

:: Getting the current theme status...
echo Getting the current theme
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme | find "0x1" >nul
if %errorlevel%==0 (
    :: From light theme to dark theme
    echo Changing to the dark theme...
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 0 /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 0 /f
) else (
    :: From dark theme to light theme
    echo Changing to the light theme...
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 1 /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 1 /f
)

:: Refresh taskbar
echo Refreshing taskbar...
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

:: pause or exit
echo Complete!
pause