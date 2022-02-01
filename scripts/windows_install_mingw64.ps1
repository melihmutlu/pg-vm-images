$ErrorActionPreference = "Stop"

echo "starting mingw64 installation"

curl.exe -L "https://github.com/msys2/msys2-installer/releases/download/nightly-x86_64/msys2-base-x86_64-latest.sfx.exe" -o msys2.exe
if (!$?) { throw 'cmdfail' }

.\msys2.exe -y -oC:\ ;
Remove-Item msys2.exe ;


function msys() { C:\msys64\usr\bin\bash.exe @('-lc') + @Args; } ; 
if (!$?) { throw 'cmdfail' }

msys ' ' ; 
msys 'pacman --noconfirm -Syuu' ; 
msys 'pacman --noconfirm -Scc' ; 

echo 'installing packages' ; 
msys 'pacman -S git bison flex make diffutils\
    ucrt64/mingw-w64-ucrt-x86_64-perl \
    ucrt64/mingw-w64-ucrt-x86_64-gcc \
    ucrt64/mingw-w64-ucrt-x86_64-ccache \
    ucrt64/mingw-w64-ucrt-x86_64-zlib \
    ucrt64/mingw-w64-ucrt-x86_64-icu \
    ucrt64/mingw-w64-ucrt-x86_64-openldap \
    ucrt64/mingw-w64-ucrt-x86_64-libxml2 \
    ucrt64/mingw-w64-ucrt-x86_64-libxslt \
    ucrt64/mingw-w64-ucrt-x86_64-lz4 \
    ucrt64/mingw-w64-ucrt-x86_64-pkg-config' ; 
echo 'export PATH=$PATH:/c/msys64/ucrt64/bin:/c/msys64/mingw64/bin' >> C:\msys64\etc\profile ; 
msys 'source /etc/profile' 