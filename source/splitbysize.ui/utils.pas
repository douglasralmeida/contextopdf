unit utils;

interface

procedure ShowErrorMsg(msg: string; helpid: integer);
function ExtractFilePrefix(const FileName: string): string;

implementation

uses
  Vcl.Dialogs, System.SysUtils, System.UITypes;

procedure ShowErrorMsg(msg: string; helpid: integer);
begin
  MessageDlg(msg, mtError, [mbOK], helpid);
end;

function ExtractFilePrefix(const FileName: string): string;
var
  I: Integer;
begin
  I := FileName.LastDelimiter('.' + PathDelim + DriveDelim);
  if (I < 0) or (FileName.Chars[I] <> '.') then
    I := MaxInt;
  Result := FileName.SubString(0, I);
end;

end.
