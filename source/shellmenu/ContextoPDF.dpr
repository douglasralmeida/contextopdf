library ContextoPDF;



uses
  System.Win.ComServ,
  Vcl.Forms,
  uShellMenu in 'uShellMenu.pas',
  uShellMenu_TLB in 'uShellMenu_TLB.pas';

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer,
  DllInstall;

{$R *.RES}

begin
end.
