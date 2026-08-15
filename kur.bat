@echo off
title GoodbyeDPI Kesin Kurulum
color 0B

:: 1. Yonetici izni kontrolu ve otomatik isteme (Islem burada takiliyordu)
net session >nul 2>&1
if %errorLevel% == 0 (
    echo Yonetici yetkisi aktif. Islemlere baslaniyor...
) else (
    echo Yonetici izni gerekiyor. Lutfen ekrana gelen uyariya EVET de...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

echo.
echo [1/4] Belgeler klasorune gecis yapiliyor...
cd /d "%USERPROFILE%\Documents"

:: Hata vermemesi icin onceki bozuk inen veya yarim kalan dosyalari siliyoruz
echo [2/4] Baglanti kuruluyor ve dosya indiriliyor...
if exist "goodbyedpi-v1.1.zip" del /f /q "goodbyedpi-v1.1.zip"
if exist "goodbyedpi-v1.1" rmdir /s /q "goodbyedpi-v1.1"
curl -Lo goodbyedpi-v1.1.zip https://github.com/keift/goodbyedpi/archive/refs/tags/v1.1.zip

echo [3/4] Zip dosyasindan cikariliyor (Biraz surebilir bekleyin)...
powershell -Command "Expand-Archive -Path '.\goodbyedpi-v1.1.zip' -DestinationPath '.\goodbyedpi-v1.1' -Force"
del "goodbyedpi-v1.1.zip"

echo [4/4] Kurulum baslatiliyor...
cd "goodbyedpi-v1.1\goodbyedpi-1.1"
call install.bat

echo.
echo =======================================================================
echo ISLEM TAMAM AGA! 
echo Yukarida "Service started" veya "Success" tarzi bir yazi gorduysen
echo kurulum puruzsuz bitmistir. Pencereyi kapatabilirsin.
echo =======================================================================
pause
exit