$NomeDoUsuario = "NomeDoUsuario"
$NovaSenha = ConvertTo-SecureString "senha" -AsPlainText -Force
Set-LocalUser -Name $NomeDoUsuario -Password $NovaSenha