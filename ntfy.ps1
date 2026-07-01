function ntfy {
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Message
    )

    # Lê as configurações
    $config = Get-Content "$env:USERPROFILE\ntfy.txt" | ConvertFrom-StringData

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
            Add-Content -Path "$env:USERPROFILE\ntfy_error.log" -Value "$(Get-Date) - Erro: $_"
        }
    } -ArgumentList $url, $fullMessage | Out-Null
}