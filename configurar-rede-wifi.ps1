# Defina o nome e a senha da rede wifi que você quer se conectar
$SSID = "MinhaRede"
$Senha = "MinhaSenha"

# Crie um arquivo XML com as configurações da rede wifi
$ArquivoXML = "$env:TEMP\PerfilWiFi.xml"
$ConteudoXML = @"
<?xml version="1.0"?>
<WLANProfile xmlns="http://www.microsoft.com/networking/WLAN/profile/v1">
  <name>$SSID</name>
  <SSIDConfig>
    <SSID>
      <hex>$([System.BitConverter]::ToString([System.Text.Encoding]::ASCII.GetBytes($SSID)) -replace '-','')</hex>
      <name>$SSID</name>
    </SSID>
  </SSIDConfig>
  <connectionType>ESS</connectionType>
  <connectionMode>auto</connectionMode>
  <MSM>
    <security>
      <authEncryption>
        <authentication>WPA2PSK</authentication>
        <encryption>AES</encryption>
        <useOneX>false</useOneX>
      </authEncryption>
      <sharedKey>
        <keyType>passPhrase</keyType>
        <protected>false</protected>
        <keyMaterial>$Senha</keyMaterial>
      </sharedKey>
    </security>
  </MSM>
</WLANProfile>
"@

# Salve o conteúdo XML no arquivo
Set-Content -Path $ArquivoXML -Value $ConteudoXML

# Adicione o perfil da rede wifi ao computador
netsh wlan add profile filename=$ArquivoXML

# Remova o arquivo XML
Remove-Item -Path $ArquivoXML
