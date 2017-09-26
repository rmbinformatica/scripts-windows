@echo off
REM Script para coletar dados da estacao de trabalho e salvar
REM no arquivo [nomedocomputador].txt e softwares instalados
REM no arquivo [nomedocomputador].csv
REM (C) 2017 - RMB Informatica - www.rmbinformatica.net
REM
cls
REG QUERY HKEY_LOCAL_MACHINE\HARDWARE\DESCRIPTION\System\BIOS /v SystemManufacturer > %COMPUTERNAME%.TXT
REG QUERY HKEY_LOCAL_MACHINE\HARDWARE\DESCRIPTION\System\BIOS /v SystemProductName >> %COMPUTERNAME%.TXT
REG QUERY HKEY_LOCAL_MACHINE\HARDWARE\DESCRIPTION\System\CentralProcessor\0 /v ProcessorNameString >> %COMPUTERNAME%.TXT
echo LIST DISK > tmp.tmp
diskpart /s tmp.tmp >> %COMPUTERNAME%.TXT
del tmp.tmp
net use >> %COMPUTERNAME%.TXT
systeminfo >> %COMPUTERNAME%.TXT
call wmic /output:APLICACOESTEMP.csv product get name, version
ren APLICACOESTEMP.csv %COMPUTERNAME%.csv
