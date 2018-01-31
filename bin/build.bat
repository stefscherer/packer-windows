@setlocal
@set JSON=%1
@set spec=%2
set builder=%spec%-iso

@if "%JSON:~-5%" == ".json" (
  set boxname=%JSON:~0,-5%
  set template=%JSON:~0,-5%
)

@if "%spec:~-6%" == "vcloud" (
  set builder=vmware-iso
)

@if "%spec%x"=="x" (
  echo Wrong build parameter!
  goto :EOF
)

@echo.
@echo boxname = %boxname%
@echo template = %template%
@echo builder = %builder%
@echo spec = %spec%
@echo.

if exist output-%builder% (
  rmdir /S /Q output-%builder%
)
if exist "C:\Windows\system32\config\systemprofile\VirtualBox VMs\packer-%builder%" (
  rmdir /S /Q "C:\Windows\system32\config\systemprofile\VirtualBox VMs\packer-%builder%"
)
if exist "C:\Windows\system32\config\systemprofile\VirtualBox VMs\%template%" (
  rmdir /S /Q "C:\Windows\system32\config\systemprofile\VirtualBox VMs\%template%"
)

packer build --only=%builder% %template%.json
if ERRORLEVEL 1 goto :EOF

if exist %~dp0\test-box-%spec%.bat (
  call %~dp0\test-box-%spec%.bat %boxname%_%spec%.box %boxname%
) 
