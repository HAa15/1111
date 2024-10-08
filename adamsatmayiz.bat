@echo off
:: Yönetici izni kontrolü
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Yönetici yetkisi gerekiyor, yetkiler yükseltiliyor...
    echo Set UAC=CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0""", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /b
)

:: Yönetici yetkisi alındıktan sonra Masaüstünde adamsatmayiz.exe dosyasını bul ve sil
echo Yönetici yetkisi alındı...
setlocal enabledelayedexpansion

for /r "%userprofile%\Desktop" %%i in (adamsatmayiz.exe) do (
    echo Bulundu: %%i
    del /f /q "%%i"
)

:: İşlem tamamlandığında bilgi ver
echo Tüm adamsatmayiz.exe dosyaları silindi.
pause
exit
