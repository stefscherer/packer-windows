$ErrorActionPreference = 'Stop'

# Write-Output My environment variables:
# ls env:

Write-Output Installing packer + Hyper-V
iwr -useb https://chocolatey.org/install.ps1 | iex
choco feature disable --name showDownloadProgress
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

#Write-Host "Adding NAT"
#New-VMSwitch -SwitchName "packer-hyperv-iso" -SwitchType Internal
#New-NetIPAddress -IPAddress 192.168.0.1 -PrefixLength 24 -InterfaceIndex (Get-NetAdapter -name "vEthernet (packer-hyperv-iso)").ifIndex
#New-NetNat -Name MyNATnetwork -InternalIPInterfaceAddressPrefix 192.168.0.0/24

#Write-Host "Adding DHCP scope"
#Install-WindowsFeature DHCP -IncludeManagementTools
#Add-DhcpServerv4Scope -Name "Internal" -StartRange 192.168.0.10 -EndRange 192.168.0.250 -SubnetMask 255.255.255.0 -Description "Internal Network"
#Set-DhcpServerv4OptionValue -ScopeID 192.168.0 -DNSServer 8.8.8.8 -Router 192.168.0.1

Write-Host "Allow Packer http server"
New-NetFirewallRule -DisplayName "Allow Packer" -Direction Inbound -Program "C:\ProgramData\chocolatey\lib\packer\tools\packer.exe" -RemoteAddress LocalSubnet -Action Allow

Write-Output "Packer Build"
$env:PACKER_LOG="1"
# Use Azure temporary data disk for ISO cache
$env:PACKER_CACHE_DIR="D:/packer_cache"
If (!(Test-Path $env:PACKER_CACHE_DIR)) {
  mkdir $env:PACKER_CACHE_DIR
}
$env:TMPDIR="D:/packer_temp"
If (!(Test-Path $env:TMPDIR)) {
  mkdir $env:TMPDIR
}
packer.exe build --only=hyperv-iso --var enable_mac_spoofing=true windows_2016.json
