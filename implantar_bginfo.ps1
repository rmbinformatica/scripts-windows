$atalho = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\Bginfo64.lnk"
$url_atalho = "http://192.168.123.222/Bginfo64.lnk"
if (-not (Test-Path $atalho)) {
   Write-Host "Atalho inexistente."
   $bginfo = "C:\SysinternalsSuite\Bginfo64.exe"
   if (-not (Test-Path $bginfo)) {
      Write-Host "Bginfo64 inexistente."
      $url_sysinternals = "https://download.sysinternals.com/files/SysinternalsSuite.zip"
      Invoke-WebRequest -Uri  $url_sysinternals -OutFile "c:\instalar\SysinternalsSuite.zip"
      if (Test-Path "c:\instalar\SysinternalsSuite.zip") {
         Write-Host "Download SysinternalsSuite concluido com sucesso."
         Expand-Archive -Path "c:\instalar\SysinternalsSuite.zip" -DestinationPath "C:\SysinternalsSuite"
      }
      else {
         Write-Host "ERRO no Download do SysinternalsSuite."
      }
   }
   else {
      Write-Host "Bginfo64 já existe :)"
   }
   $configuracao = "C:\instalar\info.bgi"
   if (-not (Test-Path $configuracao)) {
      Write-Host "Arquivo de configuração inexistente."
      $url_config = "http://192.168.123.222/info.bgi"
      Invoke-WebRequest -Uri  $url_config -OutFile $configuracao
      if (Test-Path  $configuracao) {
         Write-Host "Download do arquivo de configuração concluido com sucesso."
      }
      else {
         Write-Host "ERRO no Download do arquivo de configuração."
      }
   }
   else {
      Write-Host "Arquivo de configuração já existe :)"
   }
   Invoke-WebRequest -Uri $url_atalho -OutFile $atalho
   if (Test-Path $atalho) {
      Write-Host "Download concluído com sucesso."
   }
   else {
      Write-Host "Ocorreu um erro no download."
   }
} 
else {
   Write-Host "O atalho já existe."
}