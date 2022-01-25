$ErrorActionPreference = "Stop"

echo "starting mingw64 installation"

Invoke-WebRequest -UseBasicParsing -uri "https://github.com/msys2/msys2-installer/releases/download/nightly-x86_64/msys2-base-x86_64-latest.sfx.exe" -OutFile msys2.exe ; 
if (!$?) { throw 'cmdfail' }

.\msys2.exe -y -oC:\ ;
Remove-Item msys2.exe ;


function msys() { C:\msys64\usr\bin\bash.exe @('-lc') + @Args; } ; `
msys ' ' ; `
msys 'pacman --noconfirm -Syuu' ; `
msys 'pacman --noconfirm -Scc' ; `
echo 'installing packages' ; `
msys 'pacman --noconfirm --needed -S mingw-w64-x86_64-toolchain base-devel' ; `
echo 'export PATH=$PATH:/c/msys64/mingw64/bin' >> C:\msys64\etc\profile ; `
msys 'source /etc/profile' `

# adding pexports for mingw since it's not included in msys
msys 'curl.exe -sSL -o pexports.tar.xz  https://netcologne.dl.sourceforge.net/project/mingw/MinGW/Extension/pexports/pexports-0.47/pexports-0.47-mingw32-bin.tar.xz' `
msys 'tar xJvf pexports.tar.xz' `
msys 'cp ./bin/pexports.exe /c/msys64/mingw64/bin/pexports.exe'
