unit frmDividir;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Imaging.pngimage;

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
    ProgressBar1: TProgressBar;
    txtStatus: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btoOKClick(Sender: TObject);
  private
    nomearquivo: string;
    function ChecarForm: boolean;
    procedure IrParaStatus;
  public
    procedure SetNomeArquivo(Valor: String);
  end;

var
  FormDividir: TFormDividir;

implementation

uses uAuxiliar, uProcessador;

{$R *.dfm}

procedure TFormDividir.btoOKClick(Sender: TObject);
var
  auxiliar: TDividirAuxiliar;
begin
  if ChecarForm then
  begin
    btoOK.Enabled := false;
    auxiliar.tamanho := StrToFloat(editTamanho.Text);
    auxiliar.tipotamanho := TTipoTamanho(comboTipoTamanho.ItemIndex);
    auxiliar.arquivo := nomearquivo;
    auxiliar.salvarmesmolocal := checSalvarMesmoLocal.Checked;
    auxiliar.substituir := checSubstituir.Checked;
    auxiliar.excluirorigem := checExcluirOrigem.Checked;
    IrParaStatus;
    ProcessarDivisao(auxiliar);
  end;
end;

function TFormDividir.ChecarForm: boolean;
const
  MSG_TEXTOVAZIO = 'O tamanho máximo do arquivo PDF não foi informado. Digite o tamanho máximo antes de continuar.';
  MSG_NAOEREAL = 'O tamanho máximo do informado não é um número real válido. Tente novamente.';
begin
  if Length(Trim(editTamanho.Text)) = 0 then
  begin
    ExibirMensagemErro(MSG_TEXTOVAZIO, 101);
    editTamanho.SetFocus;
    Exit(false);
  end;
  try
    StrToFloat(editTamanho.Text);
  except
    ExibirMensagemErro(MSG_NAOEREAL, 102);
    editTamanho.SetFocus;
    Exit(false);
  end;
  Result := true;
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

procedure TFormDividir.IrParaStatus;
begin
  txtStatus.Caption := 'Inicializando divisão...';
  Caderno.PageIndex := 1;
end;

procedure TFormDividir.SetNomeArquivo(Valor: String);
begin
  nomearquivo := Valor;
end;

end.
