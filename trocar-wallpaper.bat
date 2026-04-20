@echo off
cls
echo Aguarde a troca do papel de parede...
REM obter data e hora atual no formato aaaa-mm-dd-hh-mm-ss
set timestamp=%date:~-4,4%-%date:~-10,2%-%date:~-7,2%-%time:~-11,2%-%time:~-8,2%-%time:~-5,2%
c:
cd\instalar
powershell -ExecutionPolicy Bypass -File .\trocar-wallpaper.ps1 > C:\instalar\wallpaper-out25_log_%timestamp%.txt