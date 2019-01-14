
unit frmDividir;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Imaging.pngimage, uConfig;

type
  TFormDividir = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Bevel1: TBevel;
    btoOK: TButton;
    btoCancelar: TButton;
    Caderno: TNotebook;
    Label2: TLabel;
    editTamanho: TEdit;
    comboTipoTamanho: TComboBox;
    checSalvarMesmoLocal: TCheckBox;
    checSubstituir: TCheckBox;
    checExcluirOrigem: TCheckBox;
    Label3: TLabel;
    BarraProgresso: TProgressBar;
    txtStatus: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btoOKClick(Sender: TObject);
  private
    nomearquivo: string;
    function ChecarForm: boolean;
    procedure Finalizar;
    procedure IrParaStatus;
  public
    function GetConfig: TConfig;
    procedure SetConfig(Config: TConfig);
    procedure SetNomeArquivo(Valor: String);
  end;

var
  FormDividir: TFormDividir;

implementation

uses uAuxiliar, uProcessador;

{$R *.dfm}

procedure AlterarStatus(const Msg: PWideChar; Pos: Integer); stdcall;
begin
  FormDividir.BarraProgresso.Position := Pos;
  FormDividir.txtStatus.Caption := Msg;
  //Application.ProcessMessages;
end;

procedure TFormDividir.btoOKClick(Sender: TObject);
var
  auxiliar: TDividirAuxiliar;
begin
  if ChecarForm then
  begin
    btoOK.Enabled := false;
    auxiliar.tamanho := StrToUInt(editTamanho.Text);
    auxiliar.tipotamanho := TTipoTamanho(comboTipoTamanho.ItemIndex);
    auxiliar.arquivo := nomearquivo;
    auxiliar.salvarmesmolocal := checSalvarMesmoLocal.Checked;
    auxiliar.substituir := checSubstituir.Checked;
    auxiliar.excluirorigem := checExcluirOrigem.Checked;
    auxiliar.callbackproc := @AlterarStatus;
    IrParaStatus;
    if ProcessarDivisao(auxiliar) then
      Finalizar
    else
    begin
      btoOK.Enabled := true;
      Caderno.PageIndex := 0;
      if editTamanho.CanFocus then
        editTamanho.SetFocus;
    end;
  end;
end;

function TFormDividir.ChecarForm: boolean;
const
  MSG_TEXTOVAZIO = 'O tamanho máximo do arquivo PDF não foi informado. Digite o tamanho máximo antes de continuar.';
  MSG_NAOEINT = 'O tamanho máximo do informado não é um número inteiro válido. Tente novamente.';
  MSG_NAOEMAIORZERO = 'O tamanho máximo do informado não é um número inteiro válido. Tente novamente.';
begin
  if Length(Trim(editTamanho.Text)) = 0 then
  begin
    ExibirMensagemErro(MSG_TEXTOVAZIO, 101);
    editTamanho.SetFocus;
    Exit(false);
  end;
  try
    StrToInt(editTamanho.Text);
  except
    ExibirMensagemErro(MSG_NAOEINT, 102);
    editTamanho.SetFocus;
    Exit(false);
  end;
  if StrToInt(editTamanho.Text) <= 0 then
  begin
    ExibirMensagemErro(MSG_NAOEMAIORZERO, 103);
    editTamanho.SetFocus;
    Exit(false);
  end;
  Result := true;
end;

procedure TFormDividir.Finalizar;
begin
  txtStatus.Caption := 'Divisão finalizada';
  BarraProgresso.Position := 100;
  ModalResult := mrOK;
end;

procedure TFormDividir.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFormDividir.FormCreate(Sender: TObject);
begin
  Caderno.PageIndex := 0;
end;

procedure TFormDividir.FormShow(Sender: TObject);
begin
  Caption := 'Dividir PDF - ' + nomearquivo;
end;

function TFormDividir.GetConfig: TConfig;
begin
  Result := TConfig.Create;
  Result.tamanho := StrToInt(editTamanho.text);
  Result.tipo := comboTipoTamanho.ItemIndex;
  Result.salvarmesmolocal := checSalvarMesmoLocal.checked;
  Result.substituir := checSubstituir.checked;
  Result.excluir := checExcluirOrigem.checked;
end;

procedure TFormDividir.IrParaStatus;
begin
  txtStatus.Caption := 'Inicializando divisão...';
  Caderno.PageIndex := 1;
  Application.ProcessMessages;
end;

procedure TFormDividir.SetConfig(Config: TConfig);
begin
  if Config.tamanho > 0 then
    editTamanho.text := IntToStr(Config.tamanho);
  comboTipoTamanho.ItemIndex := Config.tipo;
  checSalvarMesmoLocal.checked := Config.salvarmesmolocal;
  checSubstituir.checked := Config.substituir;
  checExcluirOrigem.checked := Config.excluir;
end;


procedure TFormDividir.SetNomeArquivo(Valor: String);
begin
  nomearquivo := Valor;
end;

end.
