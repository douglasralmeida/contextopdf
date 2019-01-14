library ContextoPDF;

{$R *.dres}

uses
  ComServ,
  Forms,
  frmDividir in 'frmDividir.pas' {FormDividir},
  uAuxiliar in 'uAuxiliar.pas',
  uProcessador in 'uProcessador.pas',
  uShellMenu in 'uShellMenu.pas',
  uShellMenu_TLB in 'uShellMenu_TLB.pas',
  uConfig in 'uConfig.pas';

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer,
  DllInstall;

{$R *.RES}

begin
end.
