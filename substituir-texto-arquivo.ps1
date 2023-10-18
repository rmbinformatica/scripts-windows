# Define os trechos que você quer procurar e substituir
$TrechoA = "Olá, mundo!"
$TrechoB = "Adeus, mundo!"

# Especifique o caminho do arquivo de texto que você quer modificar
$Arquivo = "C:\Users\MeuNome\Documents\MeuArquivo.txt"

# Leia o conteúdo do arquivo de texto em uma variável
$Conteudo = Get-Content $Arquivo

# Substitua todas as ocorrências de TrechoA por TrechoB no conteúdo
$Conteudo = $Conteudo -replace $TrechoA, $TrechoB

# Escreva o conteúdo modificado de volta no arquivo de texto
Set-Content $Arquivo $Conteudo
