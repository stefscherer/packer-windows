set PACKER_CACHE_DIR=D:/packer_cache
mkdir %PACKER_CACHE_DIR%

set TMPDIR=D:/packer_temp
mkdir %TMPDIR%
set TEMP=%TMPDIR%

cd
dir
set

echo Building
packer.exe build --only=hyperv-iso %*
