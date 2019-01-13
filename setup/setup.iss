; Script para o instalador do ContextoPDF
; requer InnoSetup

#define MyAppName "ContextoPDF"
#define MyAppVersion "1.0.0"
#define MyAppPublisher "Douglas R. Almeida"
#define MyAppURL "https://github.com/douglasralmeida"

[Setup]
AppId={{99335ABF-8E8D-4836-B64D-F0984A662096}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
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
UninstallDisplayIcon={uninstallexe}
VersionInfoVersion=1.0.0
VersionInfoProductVersion=1.0
WizardImageFile=..\res\setupgrande.bmp
WizardSmallImageFile=..\res\setuppequeno.bmp
OutputDir=.\..\dist

[Languages]
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"

[Files]
Source: "..\bin\qpdf21.dll"; DestDir: "{app}"; DestName: "qpdf21.dll"; Flags: ignoreversion
Source: "..\bin\pdfhandler.dll"; DestDir: "{app}"; DestName: "pdfhandler.dll"; Flags: ignoreversion 64bit
Source: "..\bin\pdfc.exe"; DestDir: "{app}"; DestName: "pdfc.exe"; Flags: ignoreversion 64bit
Source: "..\bin\libwinpthread-1.dll"; DestDir: "{app}"; DestName: "libwinpthread-1.dll"; Flags: ignoreversion
Source: "..\bin\libstdc++-6.dll"; DestDir: "{app}"; DestName: "libstdc++-6.dll"; Flags: ignoreversion
Source: "..\bin\libgcc_s_seh-1.dll"; DestDir: "{app}"; DestName: "libgcc_s_seh-1.dll"; Flags: ignoreversion
Source: "..\bin\ContextoPDF.dll"; DestDir: "{app}"; DestName: "ContextoPDF.dll"; Flags: ignoreversion 64bit regserver
; NOTE: Don't use "Flags: ignoreversion" on any shared system files
