# Define os trechos que você quer procurar e substituir
$TrechoA = 'https://downloads.openrport.io/tacoscript/$( $release )/?arch=Windows_x86_64&gt=$tacoVersion'
$TrechoB = "https://github.com/realvnc-labs/tacoscript/releases/download/0.3.0/tacoscript_0.3.0_windows_x86_64.zip"

# Especifique o caminho do arquivo de texto que você quer modificar
$Arquivo = ".\rport-installer.ps1"

# Leia o conteúdo do arquivo de texto em uma variável
$Conteudo = Get-Content $Arquivo

# Substitua todas as ocorrências de TrechoA por TrechoB no conteúdo
$Conteudo = $Conteudo -replace [regex]::Escape($TrechoA), $TrechoB
# Escreva o conteúdo modificado de volta no arquivo de texto
Set-Content $Arquivo $Conteudo

$TrechoA = 'https://download.openrport.io/tacoscript/$( $release )/?arch=Windows_x86_64'
$TrechoB = "https://github.com/realvnc-labs/tacoscript/releases/download/0.3.0/tacoscript_0.3.0_windows_x86_64.zip"
$Conteudo = Get-Content $Arquivo
$Conteudo = $Conteudo -replace [regex]::Escape($TrechoA), $TrechoB
Set-Content $Arquivo $Conteudo

$TrechoA = 'https://downloads.openrport.io/rport/$( $release )/latest.php?filter=Windows_x86_64.msi&gt=$( $gt )'
$TrechoB = "https://github.com/openrport/openrport/releases/download/0.9.14/rport_0.9.14_windows_x86_64.msi"
$Conteudo = Get-Content $Arquivo
$Conteudo = $Conteudo -replace [regex]::Escape($TrechoA), $TrechoB
Set-Content $Arquivo $Conteudo

$TrechoA = 'https://pairing.openrport.io/update'
$TrechoB = "https://pairing.rmbinformatica.net/update"
$Conteudo = Get-Content $Arquivo
$Conteudo = $Conteudo -replace [regex]::Escape($TrechoA), $TrechoB
Set-Content $Arquivo $Conteudo
