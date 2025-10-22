Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Install-Module -Name PSWindowsUpdate -Force -SkipPublisherCheck
Set-ExecutionPolicy –ExecutionPolicy RemoteSigned -force
Import-Module PSWindowsUpdate
