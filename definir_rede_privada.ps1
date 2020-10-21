# (C) 2020 RMB Informatica - www.rmbinformatica.com
# Engenheiro responsavel: RENATO MONTEIRO BATISTA
#
# Este script configura as conexões de rede de um sistema windows com a categoria privado.
#
# Para maiores informações acesse https://github.com/rmbinformatica/bash-scripts
#
Get-NetConnectionProfile
Set-NetConnectionProfile -NetworkCategory Private
Get-NetConnectionProfile