<#
.SYNOPSIS
    Script para enviar notificações usando o serviço ntfy.
.DESCRIPTION
	Este script envia mensagens para um tópico específico no serviço ntfy.
.EXAMPLE
	ntfy "Mensagem de teste"
.LINK
	https://github.com/rmbinformatica/scripts-windows/blob/master/ntfy.ps1
.NOTES
	Author: Renato Monteiro Batista | rmbinformatica.com | r3n4t0.cyou
#>
function ntfy {
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Message
    )

    $caminho="$env:USERPROFILE"
    # Para utilizar um outro caminho altere a variável $caminho para o caminho desejado, por exemplo: $caminho="C:\ntfy"
    # $caminho="c:\ntfy"

    # Lê as configurações
    $config = Get-Content "$caminho\ntfy.txt" | ConvertFrom-StringData

    $url = "$($config.NTFY_URL)/$($config.NTFY_TOPIC)"
    $hostname = $env:COMPUTERNAME
    $fullMessage = "[$hostname] $Message"

    # Executa em background
    Start-Job -ScriptBlock {
        param($url, $fullMessage)

        try {
            Invoke-RestMethod -Uri $url `
                              -Method Post `
                              -Body $fullMessage `
                              -TimeoutSec 15 `
                              -ErrorAction Stop | Out-Null
        }
        catch {
            # Opcional: grava erro em log
            Add-Content -Path "$caminho\ntfy_error.log" -Value "$(Get-Date) - Erro: $_"
        }
    } -ArgumentList $url, $fullMessage | Out-Null
}