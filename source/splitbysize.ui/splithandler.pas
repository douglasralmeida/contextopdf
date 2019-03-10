unit splithandler;

interface

uses
  Winapi.Windows;

type
  TSizeType = (stKB, stMB);
  TPDFSplit = record
    size: Cardinal;
    sizetype: TSizeType;
    filepath: string;
    savesameplace: boolean;
    replace: boolean;
    delete: boolean;
    callbackproc: TFarProc;
  end;
  TSplitOptions = record
    filein: PWideChar;
    dirout: PWideChar;
    prefixout: PWideChar;
    forcereplace: WordBool;
    delsource: WordBool;
    maxsize: Cardinal;
    catchprogress: WordBool;
    success: WordBool;
    progressproc: TFarProc;
    msgproc: TFarProc;
  end;
  PSplitOptions = ^TSplitOptions;

function Process(param: TPDFSplit): boolean;

procedure splitBySize(sop: PSplitOptions); cdecl; external 'pdfhandler.dll';

implementation

uses
  {$WARN UNIT_PLATFORM OFF}
  Vcl.FileCtrl,
  {$WARN UNIT_PLATFORM ON}
  System.SysUtils, utils;

function GetDirectory(rootdir: string): string;
var
  dirs: TArray<string>;
begin
  if SelectDirectory(rootdir, dirs, []) then
    result := dirs[0] + '\'
  else
    result := '';
end;

procedure ShowMsg(const Msg: PAnsiChar); cdecl;
begin
  ShowErrorMsg(WideString(Msg), 100);
end;

function Process(param: TPDFSplit): boolean;
var
  sop: TSplitOptions;
  outdir: String;
  prefix: String;
begin
  outdir := ExtractFilePath(param.filepath);
  if not param.savesameplace then
  begin
    outdir := GetDirectory(outdir);
    if outdir.Length = 0 then
      exit(false);
  end;
  prefix := ExtractFilePrefix(ExtractFileName(param.filepath));
  sop.success := false;
  sop.filein := PWideChar(param.filepath);
  sop.dirout := PWideChar(outdir);
  sop.prefixout := PWideChar(prefix);
  sop.forcereplace := param.replace;
  sop.delsource := param.delete;
  sop.maxsize := param.size;
  if param.sizetype = stMB then
    sop.maxsize := sop.maxsize * 1024;
  sop.catchprogress := Assigned(param.callbackproc);
  sop.progressproc := param.callbackproc;
  sop.msgproc := @ShowMsg;
  splitBySize(@sop);
  Result := sop.success;
end;

end.
