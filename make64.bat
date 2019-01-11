SET "TOOLCHAINDIR=D:\mingw64\bin"
SET "MAKEEXE=%TOOLCHAINDIR%\mingw32-make.exe"

%MAKEEXE% CXX=x86_64-w64-mingw32-g++ WRES="%TOOLCHAINDIR%\windres.exe -Iinclude/"