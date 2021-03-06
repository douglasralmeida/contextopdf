unit uProcessador;

interface

uses
  Winapi.Windows;

type
  TTipoTamanho = (ttKB, ttMB);
  TDividirAuxiliar = record
    tamanho: Cardinal;
    tipotamanho: TTipoTamanho;
    arquivo: string;
    salvarmesmolocal: boolean;
    substituir: boolean;
    excluirorigem: boolean;
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

function ProcessarDivisao(Parametros: TDividirAuxiliar): boolean;

procedure splitBySize(sop: PSplitOptions); cdecl; external 'pdfhandler.dll';

implementation

uses
  {$WARN UNIT_PLATFORM OFF}
  Vcl.FileCtrl,
  {$WARN UNIT_PLATFORM ON}
  System.SysUtils, uAuxiliar;

function GetDirectory(dirinicial: string): string;
var
  dirs: TArray<string>;
begin
  if SelectDirectory(dirinicial, dirs, []) then
    result := dirs[0] + '\'
  else
    result := ''
end;

procedure ExibirMsg(const Msg: PAnsiChar); cdecl;
begin
  ExibirMensagemErro(WideString(Msg), 100);
end;

function ProcessarDivisao(Parametros: TDividirAuxiliar): boolean;
var
  sop: TSplitOptions;
  dirsaida: String;
  prefixo: String;
begin
  dirsaida := ExtractFilePath(parametros.arquivo);
  if not parametros.salvarmesmolocal then
  begin
    dirsaida := GetDirectory(dirsaida);
    if dirsaida.Length = 0 then
      exit(false);
  end;
  prefixo := ExtrairArquivoPrefixo(ExtractFileName(parametros.arquivo));
  sop.success := false;
  sop.filein := PWideChar(parametros.arquivo);
  sop.dirout := PWideChar(dirsaida);
  sop.prefixout := PWideChar(prefixo);
  sop.forcereplace := parametros.substituir;
  sop.delsource := parametros.excluirorigem;
  sop.maxsize := parametros.tamanho;
  if parametros.tipotamanho = ttMB then
    sop.maxsize := sop.maxsize * 1024;
  sop.catchprogress := Assigned(parametros.callbackproc);
  sop.progressproc := parametros.callbackproc;
  sop.msgproc := @ExibirMsg;
  splitBySize(@sop);
  Result := sop.success;
end;

end.
