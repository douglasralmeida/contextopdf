unit frmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Imaging.pngimage, i18n, config;

type
  TFormMain = class(TForm)
    imgIcon: TImage;
    txtSubtitle: TLabel;
    Bevel1: TBevel;
    btoOK: TButton;
    btoCancel: TButton;
    Notebook: TNotebook;
    txtTypeMaxSize: TLabel;
    editSize: TEdit;
    comboSizeType: TComboBox;
    checSave: TCheckBox;
    checReplace: TCheckBox;
    checDelete: TCheckBox;
    txtDescStatus: TLabel;
    barProcess: TProgressBar;
    txtStatus: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btoOKClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    filename: string;
    Fi18n: TI18n;
    function CheckForm: boolean;
    procedure Finalize;
    procedure GoToStatus;
    procedure SetI18nText;
  public
    function GetConfig: TConfig;
    procedure SetConfig(Config: TConfig);
    procedure SetFileName(Value: String);
  end;

var
  FormMain: TFormMain;

implementation

uses utils, splithandler;

{$R *.dfm}

procedure ChangeStatus(const Msg: PWideChar; Pos: Integer); cdecl;
begin
  FormMain.barProcess.Position := Pos;
  FormMain.txtStatus.Caption := Msg;
end;

procedure TFormMain.btoOKClick(Sender: TObject);
var
  splithandler: TPDFSplit;
begin
  if CheckForm then
  begin
    btoOK.Enabled := false;
    splithandler.size := StrToUInt(editSize.Text);
    splithandler.sizetype := TSizeType(comboSizeType.ItemIndex);
    splithandler.filepath := filename;
    splithandler.savesameplace := checSave.Checked;
    splithandler.replace := checReplace.Checked;
    splithandler.delete := checDelete.Checked;
    splithandler.callbackproc := @ChangeStatus;
    GoToStatus;
    if Process(splithandler) then
      Finalize
    else
    begin
      btoOK.Enabled := true;
      Notebook.PageIndex := 0;
      if editSize.CanFocus then
        editSize.SetFocus;
    end;
  end;
end;

function TFormMain.CheckForm: boolean;
begin
  if Length(Trim(editSize.Text)) = 0 then
  begin
    ShowErrorMsg(Fi18n.GetExpression('SPLITBYSIZE_MAXSIZEEMPTY'), 101);
    editSize.SetFocus;
    Exit(false);
  end;
  try
    StrToInt(editSize.Text);
  except
    ShowErrorMsg(Fi18n.GetExpression('SPLITBYSIZE_MAXSIZEINVALID'), 102);
    editSize.SetFocus;
    Exit(false);
  end;
  if StrToInt(editSize.Text) <= 0 then
  begin
    ShowErrorMsg(Fi18n.GetExpression('SPLITBYSIZE_MAXSIZEINVALID'), 102);
    editSize.SetFocus;
    Exit(false);
  end;
  Result := true;
end;

procedure TFormMain.Finalize;
begin
  txtStatus.Caption := Fi18n.GetExpression('SPLITBYSIZE_DONE');
  BarProcess.Position := 100;
  ModalResult := mrOK;
end;

procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  Notebook.PageIndex := 0;
  Fi18n := TI18n.Create;
  SetI18nText;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  if Assigned(Fi18n) then
    Fi18n.free;
end;

procedure TFormMain.FormShow(Sender: TObject);
begin
  Caption := Format(Fi18n.GetExpression('SPLITBYSIZE_CAPTION'), [ExtractFileName(filename)]);
end;

function TFormMain.GetConfig: TConfig;
begin
  Result := TConfig.Create;
  Result.size := StrToInt(editSize.text);
  Result.sizetype := comboSizeType.ItemIndex;
  Result.savesameplace := checSave.checked;
  Result.replace := checReplace.checked;
  Result.delete := checDelete.checked;
end;

procedure TFormMain.GoToStatus;
begin
  txtStatus.Caption := Fi18n.GetExpression('SPLITBYSIZE_STARTING');
  Notebook.PageIndex := 1;
  Application.ProcessMessages;
end;

procedure TFormMain.SetConfig(Config: TConfig);
begin
  if Config.size > 0 then
    editSize.text := IntToStr(Config.size);
  comboSizeType.ItemIndex := Config.sizetype;
  checSave.checked := Config.savesameplace;
  checReplace.checked := Config.replace;
  checDelete.checked := Config.delete;
end;

procedure TFormMain.SetFileName(Value: String);
begin
  filename := Value;
end;

procedure TFormMain.SetI18nText;
begin
  txtSubtitle.Caption := Fi18n.GetExpression('SPLITBYSIZE_SUBTITLE');
  txtTypeMaxSize.Caption := Fi18n.GetExpression('SPLITBYSIZE_TYPESIZE');
  checSave.Caption := Fi18n.GetExpression('SPLITBYSIZE_SAVE');
  checReplace.Caption := Fi18n.GetExpression('SPLITBYSIZE_REPLACE');
  checDelete.Caption := Fi18n.GetExpression('SPLITBYSIZE_DELETE');
  btoOK.Caption := Fi18n.GetExpression('BTO_OK');
  btoCancel.Caption := Fi18n.GetExpression('BTO_CANCEL');
  txtDescStatus.Caption := Fi18n.GetExpression('SPLITBYSIZE_WAIT');
end;

end.
