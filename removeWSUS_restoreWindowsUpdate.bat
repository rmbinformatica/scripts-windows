@echo off
cls
REM Script de Correcao do windows update apos a remocao do WSUS
REM (C) 2016 - RMB Informatica
echo Parando os servicos de windows update....
net stop wuauserv
net stop bits
net stop cryptsvc
echo Removendo catalogo antigo de atualizacoes...
ren %systemroot%\System32\Catroot2 Catroot2.old
ren %systemroot%\SoftwareDistribution SoftwareDistribution.old
echo Registrando DLLs...
regsvr32 c:\windows\system32\vbscript.dll /s
regsvr32 c:\windows\system32\mshtml.dll /s
regsvr32 c:\windows\system32\msjava.dll /s
regsvr32 c:\windows\system32\jscript.dll /s
regsvr32 c:\windows\system32\msxml.dll /s
regsvr32 c:\windows\system32\actxprxy.dll /s
regsvr32 c:\windows\system32\shdocvw.dll /s
regsvr32 wuapi.dll /s
regsvr32 wuaueng1.dll /s
regsvr32 wuaueng.dll /s
regsvr32 wucltui.dll /s
regsvr32 wups2.dll /s
regsvr32 wups.dll /s
regsvr32 wuweb.dll /s
regsvr32 Softpub.dll /s
regsvr32 Mssip32.dll /s
regsvr32 Initpki.dll /s
regsvr32 softpub.dll /s
regsvr32 wintrust.dll /s
regsvr32 initpki.dll /s
regsvr32 dssenh.dll /s
regsvr32 rsaenh.dll /s
regsvr32 gpkcsp.dll /s
regsvr32 sccbase.dll /s
regsvr32 slbcsp.dll /s
regsvr32 cryptdlg.dll /s
regsvr32 Urlmon.dll /s
regsvr32 Shdocvw.dll /s
regsvr32 Msjava.dll /s
regsvr32 Actxprxy.dll /s
regsvr32 Oleaut32.dll /s
regsvr32 Mshtml.dll /s
regsvr32 msxml.dll /s
regsvr32 msxml2.dll /s
regsvr32 msxml3.dll /s
regsvr32 Browseui.dll /s
regsvr32 shell32.dll /s
regsvr32 wuapi.dll /s
regsvr32 wuaueng.dll /s
regsvr32 wuaueng1.dll /s
regsvr32 wucltui.dll /s
regsvr32 wups.dll /s
regsvr32 wuweb.dll /s
regsvr32 jscript.dll /s
regsvr32 atl.dll /s
regsvr32 Mssip32.dll /s
echo Reiniciando servico windows update...
net start wuauserv
net start bits
net start cryptsvc
echo Modificacoes concluidas
exit
