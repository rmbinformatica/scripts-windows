@echo off
REM Script para execução de comandos remotos em máquinas na mesma rede
REM usando o utilitario psexec do pacote pstools
REM (C) 2017 - RMB Informatica - www.rmbinformatica.net
REM Sintaxe de uso remoteExec [faixaRede] [ipInicial] [ipFinal] [arquivo.bat]
REM
REM Exemplo:
REM Executar arquivo.bat nas maquinas 192.168.0.1 ate 192.168.0.10
REM remoteExec 192.168.0 1 10 arquivo.bat
REM
REM Para download do pstools visite:
REM https://docs.microsoft.com/en-us/sysinternals/downloads/pstools
cls
SET faixaip=%1
SET inicio=%2
SET final=%3
SET arquivo=%4
IF "%1" == "" set /p faixaip="Informe a faixa de IP (ex.: 192.168.0): "
IF "%2" == "" set /p inicio="Informe a terminacao inicial de IP: "
IF "%3" == "" set /p final="Informe a terminacao final de IP: "
IF "%4" == "" set /p arquivo="Informe o nome do script (.bat) para executar nas estacoes: "
echo Executando %arquivo% nas maquinas de %faixaip%.%inicio% ate %faixaip%.%final%
FOR /L %%G IN (%inicio%,1,%final%) DO CALL psexec \\%faixaip%.%%G -c %arquivo%
PAUSE
