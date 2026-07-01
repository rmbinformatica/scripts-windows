# Scripts Windows

Nesta seção você encontrará alguns scripts batch desenvolvidos pela nossa empresa e disponibilizados para uso gratuito.

## Conteúdo deste repositório

### Scripts PowerShell

#### `definir_rede_privada.ps1`

Reconfigura as categorias das conexões de rede existentes de público para privado.

#### `ntfy.ps1`

Função para envio de notificações dentro de qualquer script com o uso do ntfy.sh.

Requer o arquivo `ntfy.txt` no diretório do USERPROFILE, sintaxe:

```text
NTFY_URL=https://meuhost.example.com
NTFY_TOPIC=meutopic
```

Depois você pode carregar o script com o comando:

```powershell
. C:\Scripts\ntfy.ps1
```

Exemplo de uso:

```powershell
ntfy "Servidor reiniciado"
ntfy "Backup concluído"
```

Para carrega-lo automaticamente para o prompt do powershell, verifique o caminho do seu perfil atual:

```powershell
$PROFILE
```

Normalmente:
* PowerShell 5.1: `C:\Users\SeuUsuario\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1`
* PowerShell 7+: `C:\Users\SeuUsuario\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`

Se o perfil ainda não existir, crie-o:

```powershell
# Cria a pasta se não existir
New-Item -ItemType Directory -Path (Split-Path $PROFILE) -Force

# Cria o arquivo de perfil vazio
New-Item -ItemType File -Path $PROFILE -Force
```

Adicione o carregamento da função ntfy:

```powershell
notepad $PROFILE
```

Acrescente ao final do arquivo:
```powershell
# Carrega a função ntfy automaticamente
. "$env:USERPROFILE\Scripts\ntfy.ps1"

# Ou se estiver em outro caminho
. "C:\Scripts\ntfy.ps1"
```

Salve, **feche e reabra o powershell** e teste:

```powershell
ntfy "Teste automático"
```



### Scripts Batch

#### `removeWSUS_restoreWindowsUpdate.bat`

Reconfigura o windows update da estação de trabalho para não utilizar o servidor WSUS e passar a usar o servidor oficial do Windows Update.

#### `remoteExec.bat`

Executa scripts .bat remotamente em computadores windows dentro de um range de ip especificado.

#### `infoCollector.bat`

Coleta informações relevantes sobre a estação de trabalho, e salva dados do hardware no arquivo .txt e softwares instalados no arquivo .csv.

#### `testeping.bat`

Realiza teste de conectividade para um endereço especificado como parâmetro, utilizando o comando ping. Em caso de perda de pacotes, o horário da falha é registrado no arquivo `falhas.txt`.

#### [`instalador_RMB.bat`](instaladorRMB.md)

Realiza instalação e configuração de programas básicos em um Windows 10 recém instalado.

## Licença de uso
Todo o conteúdo deste pacote pode ser usado, modificado e redistribuído para fins não comerciais.

## Autor

© 2019-2020 [Renato Monteiro Batista](www.renato.ovh) - [RMB Informatica](www.rmbinformatica.com)
