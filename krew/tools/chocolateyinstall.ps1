$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$configUrl  = 'https://github.com/kubernetes-sigs/krew/releases/download/v0.3.0/krew.yaml'
$url        = 'https://github.com/kubernetes-sigs/krew/releases/download/v0.3.0/krew.exe'

#Pull this from Install-ChocolateyPackage.ps1 so that the config yaml can live next to the exe since it didn't like passing a full path.
$chocTempDir = $env:TEMP
$tempDir = Join-Path $chocTempDir "$($env:chocolateyPackageName)"
if ($env:chocolateyPackageVersion -ne $null) { $tempDir = Join-Path $tempDir "$($env:chocolateyPackageVersion)"; }
$tempDir = $tempDir -replace '\\chocolatey\\chocolatey\\', '\chocolatey\'
if (![System.IO.Directory]::Exists($tempDir)) { [System.IO.Directory]::CreateDirectory($tempDir) | Out-Null }

Get-ChocolateyWebFile -PackageName $env:ChocolateyPackageName -FileFullPath "$tempDir\krew.yaml" -Url $configUrl

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
Install-ChocolateyPath -PathToInstall (Join-Path $env:USERPROFILE '\.krew\bin') -PathType User
refreshenv