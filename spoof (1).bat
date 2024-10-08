@echo off
setlocal enabledelayedexpansion

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Set UAC=CreateObject^("Shell.Application"^)>"%temp%\getadmin.vbs"
    echo UAC.ShellExecute "cmd.exe","/c ""%~s0""","","runas",1>>"%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit /B
)

whoami /groups | find "Administrators" > nul
if %errorLevel% neq 0 (
    exit /b 1
)

if exist "%~dp0RegistrationDomains.reg" (
    "%SystemRoot%\System32\reg.exe" import "%~dp0RegistrationDomains.reg"
)
if exist "%~dp0Vimeo.reg" (
    "%SystemRoot%\System32\reg.exe" import "%~dp0Vimeo.reg"
)

reg add "HKEY_CURRENT_USER\Software\Sysinternals\VolumeID" /v EulaAccepted /t REG_DWORD /d 1 /f

if exist "%~dp0macc.exe" (
    copy /y "%~dp0macc.exe" "%SystemRoot%\System32\macc.exe"
)
if exist "%~dp0volumeid.exe" (
    copy /y "%~dp0volumeid.exe" "%SystemRoot%\System32\volumeid.exe"
)
if exist "%~dp0reg.vbs" (
    copy /y "%~dp0reg.vbs" "%SystemRoot%\System32\reg.vbs"
)
if exist "%~dp0disk.vbs" (
    copy /y "%~dp0disk.vbs" "%SystemRoot%\System32\disk.vbs"
)
if exist "%~dp0c.vbs" (
    copy /y "%~dp0c.vbs" "%SystemRoot%\System32\c.vbs"
)
if exist "%~dp0b.vbs" (
    copy /y "%~dp0b.vbs" "%SystemRoot%\System32\b.vbs"
)
if exist "%~dp0adamsatmayiz.bat" (
    copy /y "%~dp0adamsatmayiz.bat" "%SystemRoot%\System32\adamsatmayiz.bat"
)

mkdir "%SystemDrive%\dl\spoof" 2>nul

if exist "%~dp0reg.vbs" (
    copy /y "%~dp0reg.vbs" "%SystemDrive%\dl\spoof\reg.vbs"
)
if exist "%~dp0disk.vbs" (
    copy /y "%~dp0disk.vbs" "%SystemDrive%\dl\spoof\disk.vbs"
)

if exist "%SystemDrive%\dl\spoof\reg.vbs" (
    cscript "%SystemDrive%\dl\spoof\reg.vbs"
)
if exist "%SystemDrive%\dl\spoof\disk.vbs" (
    cscript "%SystemDrive%\dl\spoof\disk.vbs"
)

mountvol X: /S

if exist "X:\EFI\Microsoft\Boot\bootmgfw.efi" (
    move X:\EFI\Microsoft\Boot\bootmgfw.efi X:\EFI\Microsoft\Boot\boot.efi
)
if exist "X:\EFI\Boot\bootx64.efi" (
    move X:\EFI\Boot\bootx64.efi X:\EFI\Boot\bootx64.efi.backup
)

if exist "%~dp0svckutils.exe" (
    copy /y "%~dp0svckutils.exe" "C:\Windows\System32\svckutils.exe"
)
if exist "%~dp0mp.efi" (
    copy /y "%~dp0mp.efi" "X:\EFI\Boot\mp.efi"
)
if exist "%~dp0bootx64.efi" (
    copy /y "%~dp0bootx64.efi" "X:\EFI\Boot\bootx64.efi"
)
if exist "%~dp0startup.nsh" (
    copy /y "%~dp0startup.nsh" "X:\EFI\Boot\startup.nsh"
)

if exist "%~dp0secsvc.dll" (
    copy /y "%~dp0secsvc.dll" "%SystemRoot%\System32\secsvc.dll"
)

mountvol X: /D

sc create sechost binPath= "C:\u.exe" DisplayName= "sechost" start= auto obj= LocalSystem
schtasks /create /tn "svckutils" /tr "C:\Windows\system32\svckutils.exe" /sc ONLOGON /rl HIGHEST /f
schtasks /create /tn "cvbs" /tr "C:\Windows\system32\c.vbs" /sc ONLOGON /rl HIGHEST /f

if exist "%SystemRoot%\System32\macc.exe" (
    start "" "%SystemRoot%\System32\macc.exe"
)

if exist "%SystemRoot%\System32\macc.exe" (
    start "" "%SystemRoot%\System32\macc.exe"
)

if exist "%SystemRoot%\System32\macc.exe" (
    start "" "%SystemRoot%\System32\macc.exe"
)

if exist "%SystemRoot%\System32\b.vbs" (
    cscript "%SystemRoot%\System32\b.vbs"
)

if exist "%SystemDrive%\reg" (
    rmdir /s /q "%SystemDrive%\reg"
)
if exist "%SystemDrive%\dl" (
    rmdir /s /q "%SystemDrive%\dl"
)

del /q /f "%temp%\*" 2>nul
for /d %%i in ("%temp%\*") do rmdir /s /q "%%i"

exit
