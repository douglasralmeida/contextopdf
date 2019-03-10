; Script para o instalador do ContextoPDF
; requer InnoSetup

#include "ambiente.iss"

#define AppName "ContextoPDF beta 2"
#define AppVersion "1.0.0"
#define AppPublisher "Douglas R. Almeida"
#define AppPublisherURL "https://github.com/douglasralmeida"
#define AppURL "https://github.com/douglasralmeida/contextopdf"

[Setup]
AppId={{99335ABF-8E8D-4836-B64D-F0984A662096}
AppName={#AppName}
AppVersion={#AppVersion}
;AppVerName={#AppName} {#MppVersion}
AppPublisher={#AppPublisher}
AppPublisherURL={#AppPublisherURL}
AppSupportURL={#AppURL}
AppUpdatesURL={#AppURL}
AllowNoIcons=yes
ArchitecturesInstallIn64BitMode=x64
ChangesEnvironment=true
Compression=lzma
DefaultDirName={pf}\ContextoPDF
DefaultGroupName=ContextoPDF
DisableWelcomePage=False
MinVersion=0,6.1
OutputBaseFilename=cpdfsetup
SetupIconFile=..\res\setup.ico
SolidCompression=yes
ShowLanguageDialog=yes
UninstallDisplayName=ContextoPDF
UninstallDisplayIcon=..\res\uninstall.ico
VersionInfoVersion=1.0.0
VersionInfoProductVersion=1.0
WizardImageFile=..\res\setupgrande.bmp
WizardSmallImageFile=..\res\setuppequeno.bmp
OutputDir=.\..\dist
UsePreviousLanguage=False
PrivilegesRequired=admin

[Languages]
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"
Name: "en"; MessagesFile: "compiler:Default.isl"

[Files]
; NOTE: Don't use "Flags: ignoreversion" on any shared system files
Source: "..\bin\x64\qpdf21.dll"; DestDir: "{app}"; DestName: "qpdf21.dll"; Flags: ignoreversion 64bit; Check: IsWin64
Source: "..\bin\x64\pdfhandler.dll"; DestDir: "{app}"; DestName: "pdfhandler.dll"; Flags: ignoreversion 64bit; Check: IsWin64
Source: "..\bin\x64\pdfc.exe"; DestDir: "{app}"; DestName: "pdfc.exe"; Flags: ignoreversion 64bit; Check: IsWin64
Source: "..\bin\x64\libwinpthread-1.dll"; DestDir: "{app}"; DestName: "libwinpthread-1.dll"; Flags: ignoreversion 64bit; Check: IsWin64
Source: "..\bin\x64\libstdc++-6.dll"; DestDir: "{app}"; DestName: "libstdc++-6.dll"; Flags: ignoreversion 64bit; Check: IsWin64
Source: "..\bin\x64\libgcc_s_seh-1.dll"; DestDir: "{app}"; DestName: "libgcc_s_seh-1.dll"; Flags: ignoreversion 64bit; Check: IsWin64
Source: "..\bin\x64\ContextoPDF.dll"; DestDir: "{app}"; DestName: "ContextoPDF.dll"; Flags: ignoreversion 64bit regserver noregerror restartreplace uninsrestartdelete; Check: IsWin64; BeforeInstall: DesregistrarDll(true)
Source: "..\bin\x86\qpdf21.dll"; DestDir: "{app}"; DestName: "qpdf21.dll"; Flags: ignoreversion 32bit; Check: not IsWin64;
Source: "..\bin\x86\pdfhandler.dll"; DestDir: "{app}"; DestName: "pdfhandler.dll"; Flags: ignoreversion 32bit; Check: not IsWin64;
Source: "..\bin\x86\pdfc.exe"; DestDir: "{app}"; DestName: "pdfc.exe"; Flags: ignoreversion 32bit; Check: not IsWin64;
Source: "..\bin\x86\libwinpthread-1.dll"; DestDir: "{app}"; DestName: "libwinpthread-1.dll"; Flags: ignoreversion 32bit; Check: not IsWin64;
Source: "..\bin\x86\libstdc++-6.dll"; DestDir: "{app}"; DestName: "libstdc++-6.dll"; Flags: ignoreversion 32bit; Check: not IsWin64;
Source: "..\bin\x86\libgcc_s_dw2-1.dll"; DestDir: "{app}"; DestName: "libgcc_s_dw2-1.dll"; Flags: ignoreversion 32bit; Check: not IsWin64;
Source: "..\bin\x86\ContextoPDF.dll"; DestDir: "{app}"; DestName: "ContextoPDF.dll"; Flags: ignoreversion 32bit regserver noregerror restartreplace uninsrestartdelete; Check: not IsWin64; BeforeInstall: DesregistrarDll(false)

[LangOptions]
DialogFontName=Segoe UI
DialogFontSize=9
WelcomeFontName=Segoe UI
TitleFontName=Segoe UI
CopyrightFontName=Segoe UI

[Code]
procedure DesregistrarDll(Is64: boolean);
begin
  if FileExists(CurrentFileName) then
  begin
    UnregisterServer(Is64, CurrentFileName, False);
    DeleteFile(CurrentFileName);
  end;
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then
    EnvAddPath(ExpandConstant('{app}'));
end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
  if CurUninstallStep = usPostUninstall then
    EnvRemovePath(ExpandConstant('{app}'));
end;