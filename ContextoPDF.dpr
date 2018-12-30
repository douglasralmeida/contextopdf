library ContextoPDF;

uses
  ComServ,
  Forms,
  uShellMenu_TLB in 'source\uShellMenu_TLB.pas',
  uShellMenu in 'source\uShellMenu.pas',
  frmDividir in 'source\frmDividir.pas' {FormDividir},
  uProcessador in 'source\uProcessador.pas',
  uAuxiliar in 'source\uAuxiliar.pas';

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer,
  DllInstall;

{$R *.RES}

begin
end.
