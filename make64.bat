SET "TOOLCHAINDIR=D:\mingw64\bin"
SET "BINDIR=../../bin/x64"
SET "CXX=x86_64-w64-mingw32-g++"
SET "LIBDIR=../../lib/x64"
SET "MAKEEXE=%TOOLCHAINDIR%\mingw32-make.exe"
SET "OBJDIR=../../obj/x64"
SET "WRES=%TOOLCHAINDIR%\windres.exe -Iinclude/"

%MAKEEXE% CXX=%CXX% WRES="%WRES%" BINDIR=%BINDIR% LIBDIR=%LIBDIR% OBJDIR=%OBJDIR%