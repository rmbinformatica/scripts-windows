# Obtém a lista de arquivos no diretório atual
$listaArquivos = Get-ChildItem -Path .

# Calcula os hashes MD5 para cada arquivo e formata a saída
$hashes = $listaArquivos | ForEach-Object {
    $hash = (Get-FileHash -Algorithm MD5 -LiteralPath $_.FullName).Hash.ToLower()
    $unixPath = $_.FullName -replace '\\','/'  # Substitui as barras invertidas por barras normais
    "$hash $unixPath"
}

# Salva a lista de hashes em um arquivo de texto
$hashes -join "`n" | Set-Content -NoNewline -Encoding ascii md5checksums.txt