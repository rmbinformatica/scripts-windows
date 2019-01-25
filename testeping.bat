@echo off
REM ----------------------------------------------
REM SCRIPT PARA TESTE DE CONECTIVIDADE USANDO PING
REM (C) 2019 - rmbinformatica.com
REM ----------------------------------------------
REM Registra o horario em que houve perda de paco-
REM tes no arquivo falhas.txt
REM Uso: testeping.bat [ip]
REM ----------------------------------------------
echo Realizando teste de ping para: %1...
echo Para interromper a execucao a qualquer momento pressione CTRL+C
:INICIO
ping -n 2 %1 | find /I "Perdidos = 0"  
if errorlevel 1 GOTO FALHA
GOTO INICIO
:FALHA
echo %date% %time% erro de ping para %1 >> falhas.txt
echo Erro de conexão no dia %date% as %time%
GOTO INICIO