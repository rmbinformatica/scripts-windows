# Crie uma lista vazia para armazenar as informações das redes wifi
$Redes = @()

# Para cada interface, obtenha os perfis de rede wifi associados
$Perfis = netsh wlan show profiles
$Perfis = $Perfis | Select-String "Todos os Perfis de Usuários\: (.+)"
# Para cada perfil, obtenha o nome e a senha da rede wifi
foreach ($Perfil in $Perfis) {
    $Nome = $Perfil.Matches.Groups[1].Value.Trim()
    $Senha = (netsh wlan show profile name="$Nome" key=clear | Select-String "Conteúdo da Chave").ToString().Split(":")[1]
    # Crie um objeto personalizado com o nome e a senha da rede wifi
    $Rede = [PSCustomObject]@{
        Nome = $Nome
        Senha = $Senha
    }
    # Adicione o objeto à lista de redes wifi
    $Redes += $Rede
}

# Exiba a lista de redes wifi em uma tabela formatada
$Redes | Format-Table -AutoSize
