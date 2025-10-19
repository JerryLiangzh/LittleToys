@echo off
chcp 65001 >nul

:: We know that in Windows 11, the right-click menu is not so popular, with many options locked in the button 'Show more options'. After clicking it, the menu will automatically turns to a Windows 10 style right-click menu, a 'complete-body' for right-click menu. Though you can right-click with pressing 'Shift' at the same time to directly open that Windows 10 style right-click menu, but it is not so convinient by the way.

:: Obtaining administrator privileges
>nul 2>&1 reg query "HKU\S-1-5-19" || (
    echo Obtaining administrator privileges...
    powershell -Command "Start-Process cmd -ArgumentList '/c %0' -Verb RunAs"
    exit /b
)

:: Getting the current right-click menu status
echo Getting the current right-click menu status...
reg query "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" >nul 2>&1
if errorlevel 1 (
    :: From Windows 11 style to Windows 10 style
    echo Changing to Windows 10 style right-click menu...
    reg.exe add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
) else (
    :: From Windows 10 style to Windows 11 style
    echo Changing to Windows 11 style right-click menu...
    reg.exe delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f
)

:: Refresh taskbar
echo Refreshing taskbar...
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 1 >nul
start explorer.exe

:: pause or exit
echo Complete!
pause