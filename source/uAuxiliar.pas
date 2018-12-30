unit uAuxiliar;

interface

procedure ExibirMensagemErro(conteudo: string; ajudaid: integer);

implementation

uses
  Dialogs, UITypes;

procedure ExibirMensagemErro(conteudo: string; ajudaid: integer);
begin
  MessageDlg(conteudo, mtError, [mbOK], ajudaid);
end;

end.
