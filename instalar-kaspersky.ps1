cd "C:\instalar"
# Download do instalador do kaspersky, obtenha o link no site https://doc.rmbinformatica.com.br/ajuda/seguranca/antivirus-kaspersky
Invoke-WebRequest -Uri "https://pdc4.trt.pdc.kaspersky.com/DownloadManagers/ee/eeb8c4d6-ff2c-40f7-9b77-a0c8760651f9/kav21.3.10.391pt_30829.exe" -OutFile kav21.3.10.391pt_30829.exe
# Download do arquivo de configuracao padrao
Invoke-WebRequest -Uri "https://rmbinformatica.com.br/pub/kasper.cfg" -OutFile install.cfg
kav21.3.10.391pt_30829.exe /pEULA=1 /pPRIVACYPOLICY=1 /pKSN=1 /pALLOWREBOOT=0 /pSKIPPRODUCTCHECK=1 /pSKIPPRODUCTUNINSTALL=1 /s