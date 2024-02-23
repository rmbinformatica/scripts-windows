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
echo (C) 2021-2023 RMB Informatica - www.rmbinformatica.com
echo Desenvolvido por Renato Monteiro Batista
echo Atualizado em 16/06/2023
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
start /b winrar-x64-624br.exe /S

REM ########## RUSTDESK ##########
echo Instalando o RustDesk...
"rustdesk-host=servidor.rmbinformatica.net,key=AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=.exe" --silent-install

REM ########## ANYDESK ##########
echo Instalando o anydesk...
AnyDesk5-3-3.exe --install "C:\Program Files (x86)\AnyDesk" --start-with-win --remove-first --create-shortcuts --create-desktop-icon --silent --update-manually

REM ########## NAVEGADORES ##########
echo Instalando o Google Chrome...
ChromeStandaloneSetup64.exe /silent /install

echo Instalando o firefox...
FirefoxSetup123.0.exe /S

REM ########## UTILITARIOS ##########
echo Instalando o NAPS Scanner
naps2-7.3.1-win.exe /SILENT

echo Instalando o filezilla
FileZilla_3.66.5_win64-setup.exe /user=all /S

REM ########## CONFIGURACOES DO WINDOWS ##########
echo Definindo plano de energia para Alto Desempenho
powercfg.exe /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

echo Retirando o botão pessoas da barra de tarefas
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People /f /t REG_DWORD /v PeopleBand /d 0

echo Retirando o botão visão da barra de tarefas
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced /f /t REG_DWORD /v ShowTaskViewButton /d 0
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced /f /t REG_DWORD /v ShowCortanaButton /d 0

echo Exibindo icone do meu computador na area de trabalho...
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel /f /t REG_DWORD /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /d 0

echo Definindo a senha do anydesk...
set /P SenhaAnydesk="Informe qual sera a senha do anydesk: "
echo %SenhaAnydesk% | "C:\Program Files (x86)\AnyDesk\AnyDesk.exe" --set-password

echo Extraindo SysinternalsSuite...
MD c:\SysinternalsSuite
CD\SysinternalsSuite
"c:\Program Files\WinRAR\winrar.exe" E c:\instalar\SysinternalsSuite.zip

echo Aceitando eula do SysinternalsSuite...
REG ADD HKEY_CURRENT_USER\SOFTWARE\Sysinternals\BGInfo /f /t REG_DWORD /v EulaAccepted /d 1
REG ADD HKEY_CURRENT_USER\SOFTWARE\Sysinternals\Disk2Vhd /f /t REG_DWORD /v EulaAccepted /d 1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Sysinternals\Process Explorer" /f /t REG_DWORD /v EulaAccepted /d 1
REG ADD HKEY_CURRENT_USER\SOFTWARE\Sysinternals\PsExec /f /t REG_DWORD /v EulaAccepted /d 1
REG ADD HKEY_CURRENT_USER\SOFTWARE\Sysinternals\PsInfo /f /t REG_DWORD /v EulaAccepted /d 1
REG ADD HKEY_CURRENT_USER\SOFTWARE\Sysinternals\PsKill /f /t REG_DWORD /v EulaAccepted /d 1
REG ADD HKEY_CURRENT_USER\SOFTWARE\Sysinternals\TcpView /f /t REG_DWORD /v EulaAccepted /d 1
REG ADD HKEY_CURRENT_USER\SOFTWARE\Sysinternals\VolumeID /f /t REG_DWORD /v EulaAccepted /d 1

echo Reparando o compartilhamento de impressoras
REG ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print /f /t REG_DWORD /v RpcAuthnLevelPrivacyEnabled /d 0

echo Configurando a exibicao de extensao dos arquivos
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f

if exist excecao_defender.ps1 (
    echo Incluindo excecoes no windows defender
    powershell -ExecutionPolicy Bypass -File .\excecao_defender.ps1
)

if exist bloquear_upgrade_windows11.ps1 (
    echo Bloqueando upgrade para o windows 11
    powershell -ExecutionPolicy Bypass -File .\bloquear_upgrade_windows11.ps1
)

REM echo Habilitar o Subsistema do Windows para Linux
REM dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

REM echo Habilitar o recurso de Máquina Virtual
REM dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

CD\Instalar
if exist TeamViewer_Setup11Lexos.exe (
    echo Instalando o teamviewer versao 11
    TeamViewer_Setup11Lexos.exe /S
    GOTO CONFIGTV
)

if exist TeamViewer_Setup15.50.5_x64.exe (
    echo Instalando o teamviewer versao 15
    TeamViewer_Setup15.50.5_x64.exe /S
    GOTO CONFIGTV
)
GOTO ANTIVIRUS

:CONFIGTV
REG ADD HKEY_CURRENT_USER\Software\TeamViewer\MsgBoxDontShow /f /t REG_DWORD /v NoConnectionAvailable /d 1
REG ADD HKEY_CURRENT_USER\Software\TeamViewer\MsgBoxDontShow /f /t REG_DWORD /v QuitWithAutostart /d 1
REG ADD HKEY_CURRENT_USER\Software\TeamViewer /f /t REG_DWORD /v MinimizeToTray /d 1

:ANTIVIRUS
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
      echo Não encontrado instalador offline do kaspersky!
      GOTO KASPERONLINE
   )
)
GOTO ADOBE

:KASPERONLINE
if exist kav21.3.10.391pt_30829.exe (
    echo Instalador ONLINE do Kasper COMPLETO detectado, conecte-se a internet para continuar...
    pause
    if exist install.cfg (
        echo Arquivo de configuracao padrao detectado.
    ) else (
        echo Baixando arquivo de configuracao padrao do site da RMB Informatica...
        powershell Invoke-WebRequest -Uri "https://rmbinformatica.com.br/pub/kasper.cfg" -OutFile install.cfg
    )
    kav21.3.10.391pt_30829.exe /pEULA=1 /pPRIVACYPOLICY=1 /pKSN=1 /pALLOWREBOOT=0 /pSKIPPRODUCTCHECK=1 /pSKIPPRODUCTUNINSTALL=1 /s
) else (
    if exist KasperskyFree.exe (
        echo Instalador ONLINE do Kasper GRATUITO detectado, conecte-se a internet para continuar...
        pause
        if exist install.cfg (
            echo Arquivo de configuracao padrao detectado.
        ) else (
            echo Baixando arquivo de configuracao padrao do site da RMB Informatica...
            powershell Invoke-WebRequest -Uri "https://rmbinformatica.com.br/pub/kasper.cfg" -OutFile install.cfg
        )
        KasperskyFree.exe /pEULA=1 /pPRIVACYPOLICY=1 /pKSN=1 /pALLOWREBOOT=0 /pSKIPPRODUCTCHECK=1 /pSKIPPRODUCTUNINSTALL=1 /s
    ) else (
        echo Não encontrado instalador online do kaspersky!
        pause
    )
)

:ADOBE
if exist AcroRdrDC1900820071_pt_BR.exe (
    echo Instalando o adobe reader...
    AcroRdrDC1900820071_pt_BR.exe /sAll /rs /msi EULA_ACCEPT=YES
)

if exist Dropbox_193.4.5594_Offline_Installer.x64.exe (
    echo Instalando DropBox
    Dropbox_193.4.5594_Offline_Installer.x64.exe /S
) 

if exist tsetup-x64.4.15.0.exe (
    echo Instalando Telegram
    tsetup-x64.4.15.0.exe /VERYSILENT /NORESTART
)

if exist vlc-3.0.20-win64.exe (
    echo Instalando VLC Media Player
    vlc-3.0.20-win64.exe
)

:WINGET
echo Conecte-se a internet para instalacao dos softwares via Winget
pause
winget install WhatsApp.WhatsApp --accept-source-agreements --accept-package-agreements
