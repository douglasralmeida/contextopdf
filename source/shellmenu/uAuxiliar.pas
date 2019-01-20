unit uAuxiliar;

interface

procedure ExibirMensagemErro(conteudo: string; ajudaid: integer);
function ExtrairArquivoPrefixo(const FileName: string): string;

implementation

uses
  Vcl.Dialogs, System.SysUtils, System.UITypes;

procedure ExibirMensagemErro(conteudo: string; ajudaid: integer);
begin
  MessageDlg(conteudo, mtError, [mbOK], ajudaid);
end;

function ExtrairArquivoPrefixo(const FileName: string): string;
var
  I: Integer;
begin
  I := FileName.LastDelimiter('.' + PathDelim + DriveDelim);
  if (I < 0) or (FileName.Chars[I] <> '.') then
    I := MaxInt;
  Result := FileName.SubString(0, I);
end;

end.
