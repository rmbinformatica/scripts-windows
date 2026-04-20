<#
.SYNOPSIS
    Script para atualizar o RustDesk para a versão mais recente em sistemas Windows.
.DESCRIPTION
	Este script atualiza o RustDesk para a versão mais recente (1.4.6) em sistemas Windows. Ele baixa o instalador, para o serviço do RustDesk, executa a instalação silenciosa com a string de configuração predefinida pelo usuário e reinicia o serviço.
.EXAMPLE
	powershell -ExecutionPolicy Bypass -File .\atualizar-rustdesk.ps1
.LINK
	https://github.com/rmbinformatica/scripts-windows/blob/master/atualizar-rustdesk.ps1
.NOTES
	Author: Renato Monteiro Batista | rmbinformatica.com | r3n4t0.cyou
#>

$url="https://github.com/rustdesk/rustdesk/releases/download/1.4.6/rustdesk-1.4.6-x86_64.exe"
$arquivo="c:\instalar\rustdesk-1.4.6-x86_64.exe"
if (-not (Test-Path $arquivo)) {
   Write-Host "Arquivo inexistente, tentando download."
   Invoke-WebRequest -Uri $url -OutFile $arquivo
   Stop-Service Rustdesk
   Start-Process -FilePath $arquivo -ArgumentList "--silent-install --config <defina_aqui_sua_string_de_configuracao>" -Wait
   Write-Host "RustDesk instalado com sucesso!"
}
else {
   Write-Host "RustDesk já existe :)"
}
