@echo off
cls
echo .
echo ██████  ███    ███ ██████      ██ ███    ██ ███████  ██████  ██████  ███    ███  █████  ████████ ██  ██████  █████  
echo ██   ██ ████  ████ ██   ██     ██ ████   ██ ██      ██    ██ ██   ██ ████  ████ ██   ██    ██    ██ ██      ██   ██ 
echo ██████  ██ ████ ██ ██████      ██ ██ ██  ██ █████   ██    ██ ██████  ██ ████ ██ ███████    ██    ██ ██      ███████ 
echo ██   ██ ██  ██  ██ ██   ██     ██ ██  ██ ██ ██      ██    ██ ██   ██ ██  ██  ██ ██   ██    ██    ██ ██      ██   ██ 
echo ██   ██ ██      ██ ██████      ██ ██   ████ ██       ██████  ██   ██ ██      ██ ██   ██    ██    ██  ██████ ██   ██ 
echo .
echo ============================================================
echo Configurador do Windows 10 - Versao 1.0
echo (C) 2021-2022 RMB Informatica - www.rmbinformatica.com
echo Desenvolvido por Renato Monteiro Batista
echo Atualizado em 29/01/2022
echo ============================================================
echo Verificando permissoes...
NET SESSION
IF %ERRORLEVEL% NEQ 0 GOTO ELEVATE
GOTO ADMINTASKS

:ELEVATE
echo Permissoes insuficientes, esse instalador deve ser executado
echo com permissoes de administrador local...
CD /d %~dp0
MSHTA "javascript: var shell = new ActiveXObject('shell.application'); shell.ShellExecute('%~nx0', '', '', 'runas', 1);close();"
EXIT

:ADMINTASKS
CD\instalar
REM ########## WINRAR ##########
echo Instalando o winrar...
start /b winrar-x64-602br.exe /S

REM ########## ANYDESK ##########
echo Instalando o anydesk...
AnyDesk5-3-3.exe --install "C:\Program Files (x86)\AnyDesk" --start-with-win --remove-first --create-shortcuts --create-desktop-icon --silent --update-manually

REM ########## NAVEGADORES ##########
echo Instalando o Google Chrome...
ChromeStandaloneSetup64.exe /silent /install

echo Instalando o firefox...
Firefox_Setup_96.0.3.exe /S

REM ########## UTILITARIOS ##########
echo Instalando o NAPS Scanner
naps2-6.1.2-setup.exe /SILENT

echo Instalando o filezilla
FileZilla_3.57.0_win64-setup /user=all /S

REM ########## CONFIGURACOES DO WINDOWS ##########
echo Definindo plano de energia para Alto Desempenho
powercfg.exe /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

echo Retirando o botão pessoas da barra de tarefas
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People /f /t REG_DWORD /v PeopleBand /d 0

echo Retirando o botão visão da barra de tarefas
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced /f /t REG_DWORD /v ShowTaskViewButton /d 0

REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced /f /t REG_DWORD /v ShowCortanaButton /d 0

echo Definindo a senha do anydesk...
set /P SenhaAnydesk="Informe qual sera a senha do anydesk: "
echo %SenhaAnydesk% | "C:\Program Files (x86)\AnyDesk\AnyDesk.exe" --set-password

echo Extraindo SysinternalsSuite...
MD c:\SysinternalsSuite
CD\SysinternalsSuite
"c:\Program Files\WinRAR\winrar.exe" E c:\instalar\SysinternalsSuite.zip

CD\Instalar
echo Instalando o teamviewer
if exist TeamViewer_Setup11Lexos.exe (
    TeamViewer_Setup11Lexos.exe /S
)
if exist TeamViewer_Setup14.rar (
    "c:\Program Files\WinRAR\WinRAR.exe" E TeamViewer_Setup14.rar
)
if exist TeamViewer_Setup15.exe (
    TeamViewer_Setup15.exe /S
)
REG ADD HKEY_CURRENT_USER\Software\TeamViewer\MsgBoxDontShow /f /t REG_DWORD /v NoConnectionAvailable /d 1
REG ADD HKEY_CURRENT_USER\Software\TeamViewer\MsgBoxDontShow /f /t REG_DWORD /v QuitWithAutostart /d 1
REG ADD HKEY_CURRENT_USER\Software\TeamViewer /f /t REG_DWORD /v MinimizeToTray /d 1

REM ###########################
REM # INSTALAÇÃO DO ANTIVIRUS #
REM ###########################

if exist KAV19.0.0.1088_pt-BR_full.exe (
    echo Instalando versao COMPLETA do antivirus Kaspersky
    KAV19.0.0.1088_pt-BR_full.exe /pEULA=1 /pPRIVACYPOLICY=1 /pKSN=0 /pALLOWREBOOT=0 /s
) else (
   if exist kfa18.0.0.405pt-BR_full.exe (
      echo Instalando versao GRATUITA do antivirus Kaspersky
      kfa18.0.0.405pt-BR_full.exe /pEULA=1 /pPRIVACYPOLICY=1 /pKSN=0 /pALLOWREBOOT=0 /s
   ) else (
      echo Não encontrado instalador do kaspersky!
      pause
   )
)

if exist AcroRdrDC1900820071_pt_BR.exe (
    echo Instalando o adobe reader...
    AcroRdrDC1900820071_pt_BR.exe /sAll /rs /msi EULA_ACCEPT=YES
)

if exist Dropbox_140.4.1951_Offline_Installer.exe (
    echo Instalando DropBox
    Dropbox_140.4.1951_Offline_Installer.exe /S
) 

if exist WhatsAppSetup.exe (
    echo Instalando Whatsapp
    WhatsAppSetup.exe --silent
)

if exist tsetup-x64.3.4.8.exe (
    echo Instalando Telegram
    tsetup-x64.3.4.8.exe /VERYSILENT /NORESTART
)