$ErrorActionPreference = 'Stop'

Write-Output My environment variables:
ls env:

Write-Output Installing packer + Hyper-V
iwr -useb https://chocolatey.org/install.ps1 | iex
choco install -y packer -version 1.1.3
Install-WindowsFeature Hyper-V-PowerShell

"dummy" | Out-File path-to.vmx
$env:PACKER_AZURE_AD_TENANT_ID="dummy"
$env:PACKER_AZURE_SUBSCRIPTION_ID="dummy"
$env:PACKER_AZURE_OBJECT_ID="dummy"
$env:PACKER_AZURE_APP_ID="dummy"
$env:PACKER_AZURE_CLIENT_SECRET="dummy"
$env:PACKER_AZURE_RESOURCE_GROUP="dummy"
$env:PACKER_AZURE_STORAGE_ACCOUNT="dummy"

$files = @(Get-ChildItem *.json)

foreach ($file in $files) {
  Write-Host "`n`nValidate $file"
  packer.exe validate $file
  if (-not $?)
  {
     throw "Packer validate found errors in $file!"
  }
}
