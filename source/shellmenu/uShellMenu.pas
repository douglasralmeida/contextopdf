unit uShellMenu;

interface

uses
  Winapi.Windows, Winapi.ActiveX, System.Win.ComObj, Winapi.ShlObj;

type
  TShellMenu = class(TComObject, IUnknown, IContextMenu, IShellExtInit)
  private
    nomearquivo: string;
  protected
    function QueryContextMenu(Menu: HMENU; indexMenu, idCmdFirst, idCmdLast,
      uFlags: UINT): HResult; stdcall;
    function InvokeCommand(var lpici: TCMInvokeCommandInfo): HResult; stdcall;
    function GetCommandString(idCmd: UINT_PTR; uFlags: UINT; pwReserved: PUINT;
      pszName: LPSTR; cchMax: UINT): HResult; stdcall;
    function Initialize(pidlFolder: PItemIDList; lpdobj: IDataObject;
      hKeyProgID: HKEY): HResult; reintroduce; stdcall;
  end;

  TShellMenuFactory = class(TComObjectFactory)
  public
    procedure UpdateRegistry(Register: Boolean); override;
  end;

const
  CLASS_SHELLMENU: TGUID = '{273D70CD-B33A-4F25-86CD-F8FC17AD8A56}';

implementation

uses System.AnsiStrings, System.Win.ComServ, Vcl.Dialogs,
     frmDividir, uConfig, Vcl.Graphics,
     System.Win.Registry, Winapi.ShellAPI, System.SysUtils, System.UITypes;

//Fun��o chamada quando o Windows Explorer est� inicializando a extens�o.
function TShellMenu.Initialize(pidlFolder: PItemIDList;
  lpdobj: IDataObject; hKeyProgID: HKEY): HResult; stdcall;
var
  medium: TStgMedium;
  fe: TFormatEtc;
begin
  Result := E_FAIL;
  if Assigned(lpdobj) then
  begin
    with fe do
    begin
      cfFormat := CF_HDROP;
      ptd := nil;
      dwAspect := DVASPECT_CONTENT;
      lindex := -1;
      tymed := TYMED_HGLOBAL;
    end;
    Result := lpdobj.GetData(fe, medium);
    if not Failed(Result) then
    begin
      if DragQueryFile(medium.hGlobal, $FFFFFFFF, nil, 0) = 1 then
      begin
        SetLength(nomearquivo, 1000);
        DragQueryFile(medium.hGlobal, 0, PChar(nomearquivo), 1000);
        nomearquivo := PChar(nomearquivo);
        Result := NOERROR;
      end
      else
        Result := E_FAIL;
    end;
    ReleaseStgMedium(medium);
  end;
end;

//Fun��o chamada para adicionar um item de menu ao menu de contexto.
function TShellMenu.QueryContextMenu(Menu: HMENU;
  indexMenu, idCmdFirst, idCmdLast, uFlags: UINT): HResult;
const
  MENU_DIVIDIR = '&Dividir por tamanho...';
var
  Bitmap: TBitmap;
  Icon: TIcon;
  MenuItemInfo: TMenuItemInfo;
begin
  //adiciona um novo item ao menu de contexto
  InsertMenu(Menu, indexMenu, MF_STRING or MF_BYPOSITION, idCmdFirst, MENU_DIVIDIR);

  //adiciona imagem ao item de menu
  Bitmap := TBitmap.Create;
  Icon := TIcon.Create;
  try
    Bitmap.Height := 16;
    Bitmap.Width := 16;
    Icon.LoadFromResourceName(HInstance, 'PDFICON');
    DrawIconEx(Bitmap.Canvas.Handle, 0, 0, Icon.Handle, Bitmap.Width, Bitmap.Height, 0, GetSysColorBrush(COLOR_MENU), DI_NORMAL);
    ZeroMemory(@MenuItemInfo, SizeOf(MenuItemInfo));
    MenuItemInfo.fMask := MIIM_BITMAP;
    MenuItemInfo.hbmpItem := Bitmap.Handle;
    MenuItemInfo.cbSize := sizeof(MenuItemInfo);
    SetMenuItemInfo(Menu, idCmdFirst, false, MenuItemInfo);
  finally
    if Assigned(Icon) then
      FreeAndNil(Icon);
  end;

  //returna o n�mero de itens adicionados
  Result := 1;
end;

//Fun��o chamada quando o usu�rio clica no item do menu de contexto.
function TShellMenu.InvokeCommand(var lpici: TCMInvokeCommandInfo): HResult;
var
  Config: TConfig;
begin
  Result := NOERROR;
  // Garantir que InvokeCommand n�o foi chamada por uma aplica��o
  if HiWord(Integer(lpici.lpVerb)) <> 0 then
  begin
    Result := E_FAIL;
    Exit;
  end;
  // Garantir a validade do argumento passado
  if LoWord(lpici.lpVerb) > 0 then
  begin
    Result := E_INVALIDARG;
    Exit;
  end;
  // Executar o comando especificado em lpici.lpVerb
  if LoWord(lpici.lpVerb) = 0 then
  begin
    //Abrir caixa de di�logo para divis�o de pdf
    FormDividir := TFormDividir.Create(nil);
    Config := TConfig.Create;
    try
      Config.Carregar;
      FormDividir.SetNomeArquivo(NomeArquivo);
      FormDividir.SetConfig(Config);
      FormDividir.ShowModal;
      if FormDividir.ModalResult = mrOK then
      begin
        Config.Assign(FormDividir.GetConfig);
        Config.Salvar;
      end;
    finally
      if Assigned(Config) then
        FreeAndNil(Config);
      if Assigned(FormDividir) then
      begin
        FormDividir.Release;
        FreeAndNil(FormDividir);
      end;
    end;
  end;
end;

//Fun��o chamada quando o Windows Explorer requer ajuda para o item de menu
function TShellMenu.GetCommandString(idCmd: UINT_PTR; uFlags: UINT; pwReserved: PUINT;
      pszName: LPSTR; cchMax: UINT): HResult; stdcall;
const
  AJUDA_DIVIDIR = 'Divide o arquivo PDF selecionado.';
begin
  if (idCmd = 0) and (uFlags = GCS_HELPTEXT) then
  begin
    // returna a cadeia de caracteres de ajuda do item de menu
    System.AnsiStrings.strLCopy(pszName, AJUDA_DIVIDIR, cchMax);
    Result := NOERROR;
  end
  else
    Result := E_INVALIDARG;
end;

{ TShellMenuFactory }

procedure TShellMenuFactory.UpdateRegistry(Register: Boolean);
const
  REG_SHELLMENU = '\SystemFileAssociations\.pdf\ShellEx\ContextMenuHandlers\ContextoPDF';
var
  Reg: TRegistry;
begin
  inherited UpdateRegistry (Register);

  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_CLASSES_ROOT;
  try
    if Register then
      if Reg.OpenKey(REG_SHELLMENU, True) then
        Reg.WriteString('', GUIDToString(CLASS_SHELLMENU))
    else
      if Reg.OpenKey(REG_SHELLMENU, False) then
        Reg.DeleteKey(REG_SHELLMENU);
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;

initialization
  TShellMenuFactory.Create(
    ComServer, TShellMenu, CLASS_SHELLMENU,
    'ContextoPDFMenu', 'Extens�o do ContextoPDF para menus de contexto',
    ciMultiInstance, tmApartment);
end.
