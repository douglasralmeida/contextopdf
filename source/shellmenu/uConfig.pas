unit uConfig;

interface

uses
  Classes;

type
  TConfig = class(TPersistent)
  private
    FTamanho: integer;
    FTipo: integer;
    FSalvarMesmoLocal: boolean;
    FSubstituir: boolean;
    FExcluir: boolean;
    function GetExcluir: Boolean;
    function GetSalvarMesmoLocal: Boolean;
    function GetSubstituir: Boolean;
    function GetTamanho: Integer;
    function GetTipo: Integer;
    procedure SetExcluir(Value: boolean);
    procedure SetSalvarMesmoLocal(Value: boolean);
    procedure SetSubstituir(Value: boolean);
    procedure SetTamanho(Value: integer);
    procedure SetTipo(Value: integer);
  public
    procedure Assign(Source: TPersistent); override;
    function Carregar: boolean;
    procedure Salvar;
  published
    property Excluir: Boolean read GetExcluir write SetExcluir;
    property SalvarMesmoLocal: Boolean read GetSalvarMesmoLocal write SetSalvarMesmoLocal;
    property Substituir: Boolean read GetSubstituir write SetSubstituir;
    property Tamanho: Integer read GetTamanho write SetTamanho;
    property Tipo: Integer read GetTipo write SetTipo;
  end;

implementation

uses
  Registry, Windows, Dialogs;

const
  chaveReg = 'Software\\Douglas R. Almeida\\ContextoPDF\\';

function ReadValue(Reg: TRegistry; Value: String; Default: Variant): Variant;
begin
  if Reg.ValueExists(Value) then
  begin
    Result := Reg.ReadInteger(Value);
  end
  else
    Result := Default;
end;

procedure TConfig.Assign(Source: TPersistent);
begin
  if Source is TConfig then
  begin
    FTamanho := TConfig(Source).Tamanho;
    Ftipo := TConfig(Source).tipo;
    Fsalvarmesmolocal := TConfig(Source).salvarmesmolocal;
    Fsubstituir := TConfig(Source).substituir;
    FExcluir := TConfig(Source).Excluir;
    Exit;
  end;
  inherited Assign(Source);
end;

function TConfig.Carregar: boolean;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  Reg.Access := KEY_READ;
  Reg.RootKey := HKEY_CURRENT_USER;
  if Reg.KeyExists(chaveReg) then
  begin
    Reg.OpenKey(chaveReg, false);
    FTamanho := ReadValue(Reg, 'lastsize', 0);
    Ftipo := ReadValue(Reg, 'lasttype', 1);
    Fsalvarmesmolocal := ReadValue(Reg, 'lastsave', 1);
    FExcluir := ReadValue(Reg, 'lastdelete', 1);
    Fsubstituir := ReadValue(Reg, 'lastreplace', 1);
    Reg.CloseKey;
    Result := true;
  end
  else
  begin
    FTamanho := 0;
    Ftipo := 1;
    Fsalvarmesmolocal := true;
    FExcluir := true;
    Fsubstituir := true;
    Result := false;
  end;
  Reg.Free;
end;

function TConfig.GetExcluir: Boolean;
begin
  Result := FExcluir;
end;

function TConfig.GetSalvarMesmoLocal: Boolean;
begin
  Result := FSalvarmesmolocal;
end;

function TConfig.GetSubstituir: Boolean;
begin
  Result := FSubstituir;
end;

function TConfig.GetTamanho: Integer;
begin
  Result := FTamanho;
end;

function TConfig.GetTipo: Integer;
begin
  Result := FTipo;
end;

procedure TConfig.Salvar;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.Access := KEY_WRITE;
    Reg.RootKey := HKEY_CURRENT_USER;
    Reg.OpenKey(chaveReg, true);
    Reg.WriteInteger('lastsize', FTamanho);
    Reg.WriteInteger('lasttype', Ftipo);
    Reg.WriteBool('lastsave', Fsalvarmesmolocal);
    Reg.WriteBool('lastdelete', FExcluir);
    Reg.WriteBool('lastreplace', Fsubstituir);
  finally
    if Assigned(Reg) then
    begin
      Reg.CloseKey;
      Reg.Free;
    end;
  end;
end;

procedure TConfig.SetExcluir(Value: boolean);
begin
  FExcluir := Value;
end;

procedure TConfig.SetSalvarMesmoLocal(Value: boolean);
begin
  FSalvarMesmoLocal := Value;
end;

procedure TConfig.SetSubstituir(Value: boolean);
begin
  FSubstituir := Value;
end;

procedure TConfig.SetTamanho(Value: integer);
begin
  FTamanho := Value;
end;

procedure TConfig.SetTipo(Value: integer);
begin
  FTipo := Value;
end;

end.
