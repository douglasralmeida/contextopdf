unit frmDividir;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TFormDividir = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Bevel1: TBevel;
    Button1: TButton;
    Button2: TButton;
    Caderno: TNotebook;
    Label2: TLabel;
    Edit1: TEdit;
    ComboBox1: TComboBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Label3: TLabel;
    ProgressBar1: TProgressBar;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormDividir: TFormDividir;

implementation

{$R *.dfm}

procedure TFormDividir.FormCreate(Sender: TObject);
begin
  Caderno.PageIndex := 0;
end;

end.
