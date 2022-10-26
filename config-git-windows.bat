REM Configuracoes do git para sistemas windows
git config --global core.fileMode false
git config --global core.autocrlf input

REM Executar nos diretórios git que apresentarem arquivos não modificados como se houvessem sido modificados na fila do git depois da sincronizacao entre sistemas diferentes (linux/windows/mac)
git config core.fileMode false