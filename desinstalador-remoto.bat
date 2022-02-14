@ECHO OFF
title Remotely Uninstall Software
::http://community.spiceworks.com/how_to/show/179
::Only Tested on XP/Vista/7

:MENU1
cls
echo Enter computer name, IP address, or Q to quit.
echo.
set PC=Z
Set /P PC=
if /I %PC% EQU Q goto END
if /I %PC% EQU Z goto MENU1
goto LIST

:LIST
cls
echo Gathering software installed on %PC%. . .
wmic /node:"%PC%" product get name
echo.

:MENU2
echo Enter Software to Uninstall, P for previous screen, R to refresh, or Q to quit
echo.
set SOFTWARE=R
Set /P SOFTWARE=
if /I "%SOFTWARE%" EQU "Q" goto END
if /I "%SOFTWARE%" EQU "P" goto MENU1
if /I "%SOFTWARE%" EQU "R" goto LIST
cls
echo Uninstalling "%SOFTWARE%" from %PC%. . .
wmic /node:"%PC%" product where name="%SOFTWARE%" call uninstall /nointeractive
pause
goto LIST

:END
EXIT