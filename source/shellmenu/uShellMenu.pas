unit uShellMenu;

interface

uses
  Windows, ActiveX, ComObj, ShlObj;

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

uses AnsiStrings, ComServ, Dialogs, frmDividir, Registry, ShellAPI;

//Função chamada quando o Windows Explorer está inicializando a extensão.
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

//Função chamada para adicionar um item de menu ao menu de contexto.
function TShellMenu.QueryContextMenu(Menu: HMENU;
  indexMenu, idCmdFirst, idCmdLast, uFlags: UINT): HResult;
const
  MENU_DIVIDIR = '&Dividir...';
begin
  //adiciona um novo item ao menu de contexto
  InsertMenu(Menu, indexMenu, MF_STRING or MF_BYPOSITION, idCmdFirst, MENU_DIVIDIR);
  //returna o número de itens adicionados
  Result := 1;
end;

//Função chamada quando o usuário clica no item do menu de contexto.
function TShellMenu.InvokeCommand(var lpici: TCMInvokeCommandInfo): HResult;
begin
  Result := NOERROR;
  // Garantir que InvokeCommand não foi chamada por uma aplicação
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
    //Abrir caixa de diálogo para divisão de pdf
    FormDividir := TFormDividir.Create(nil);
    FormDividir.SetNomeArquivo(NomeArquivo);
    FormDividir.ShowModal;
  end;
end;

//Função chamada quando o Windows Explorer requer ajuda para o item de menu
function TShellMenu.GetCommandString(idCmd: UINT_PTR; uFlags: UINT; pwReserved: PUINT;
      pszName: LPSTR; cchMax: UINT): HResult; stdcall;
const
  AJUDA_DIVIDIR = 'Divide o arquivo PDF selecionado.';
begin
  if (idCmd = 0) and (uFlags = GCS_HELPTEXT) then
  begin
    // returna a cadeia de caracteres de ajuda do item de menu
    strLCopy(pszName, AJUDA_DIVIDIR, cchMax);
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
    'ContextoPDFMenu', 'Extensão do ContextoPDF para menus de contexto',
    ciMultiInstance, tmApartment);
end.
