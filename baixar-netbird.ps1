<#
.SYNOPSIS
    Script para download da versão mais atual do cliente Netbiord para Windows.
.DESCRIPTION
	Este script baixa o instalador do Netbird para a versão mais recente em sistemas Windows.
.EXAMPLE
	powershell -ExecutionPolicy Bypass -File .\baixar-netbird.ps1
.LINK
	https://github.com/rmbinformatica/scripts-windows/blob/master/baixar-netbird.ps1
.NOTES
	Author: Renato Monteiro Batista | rmbinformatica.com | r3n4t0.cyou
#>
$url="https://pkgs.netbird.io/windows/x64"
$arquivo="c:\instalar\netbird_installer_0.66.4_windows_amd64.exe"
if (-not (Test-Path $arquivo)) {
   Write-Host "Arquivo netbird inexistente, tentando download."
   Invoke-WebRequest -Uri $url -OutFile $arquivo
   Stop-Service Netbird
   Start-Process -FilePath $arquivo -ArgumentList "/S" -Wait
   Write-Host "Netbird instalado com sucesso!"
}
else {
   Write-Host "Netbird já existe :)"
}


