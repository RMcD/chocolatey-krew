$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$configUrl  = 'https://github.com/kubernetes-sigs/krew/releases/download/v0.3.0/krew.yaml'
$url        = 'https://github.com/kubernetes-sigs/krew/releases/download/v0.3.0/krew.exe'

Get-ChocolateyWebFile -PackageName $env:ChocolateyPackageName -FileFullPath "$toolsDir\krew.yaml" -Url '$configUrl'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'krew*'

  #From: https://github.com/kubernetes-sigs/krew/releases/download/v0.3.0/krew.exe.sha256
  checksum      = '81b7ed1fba0fabe2b9afd948ccdf4054ae87ea4c4add4bfbde91a3dc5cf538ea'
  checksumType  = 'sha256'

  silentArgs    = "install --manifest=krew.yaml"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs