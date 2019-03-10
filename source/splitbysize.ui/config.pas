unit config;

interface

uses
  System.Classes;

type
  TConfig = class(TPersistent)
  private
    FSize: integer;
    FSizeType: integer;
    FSaveSamePlace: boolean;
    FReplace: boolean;
    FDelete: boolean;
    function GetDelete: Boolean;
    function GetSaveSamePlace: Boolean;
    function GetReplace: Boolean;
    function GetSize: Integer;
    function GetSizeType: Integer;
    procedure SetDelete(Value: boolean);
    procedure SetSaveSamePlace(Value: boolean);
    procedure SetReplace(Value: boolean);
    procedure SetSize(Value: integer);
    procedure SetSizeType(Value: integer);
  public
    procedure Assign(Source: TPersistent); override;
    function Load: boolean;
    procedure Save;
  published
    property Delete: Boolean read GetDelete write SetDelete;
    property SaveSamePlace: Boolean read GetSaveSamePlace write SetSaveSamePlace;
    property Replace: Boolean read GetReplace write SetReplace;
    property Size: Integer read GetSize write SetSize default 0;
    property SizeType: Integer read GetSizeType write SetSizeType;
  end;

implementation

uses
  System.Win.Registry, Winapi.Windows, Vcl.Dialogs;

const
  REGKEY = 'Software\\Douglas R. Almeida\\ContextoPDF\\';

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
    FSize := TConfig(Source).Size;
    FSizeType := TConfig(Source).SizeType;
    FSaveSamePlace := TConfig(Source).SaveSamePlace;
    FReplace := TConfig(Source).Replace;
    FDelete := TConfig(Source).Delete;
    Exit;
  end;
  inherited Assign(Source);
end;

function TConfig.Load: boolean;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  Reg.Access := KEY_READ;
  Reg.RootKey := HKEY_CURRENT_USER;
  if Reg.KeyExists(REGKEY) then
  begin
    Reg.OpenKey(REGKEY, false);
    FSize := ReadValue(Reg, 'lastsize', 0);
    FSizeType := ReadValue(Reg, 'lasttype', 1);
    FSaveSamePlace := ReadValue(Reg, 'lastsave', 1);
    FDelete := ReadValue(Reg, 'lastdelete', 1);
    FReplace := ReadValue(Reg, 'lastreplace', 1);
    Reg.CloseKey;
    Result := true;
  end
  else
  begin
    FSize := 0;
    FSizeType := 1;
    FSaveSamePlace := true;
    FDelete := true;
    FReplace := true;
    Result := false;
  end;
  Reg.Free;
end;

function TConfig.GetDelete: Boolean;
begin
  Result := FDelete;
end;

function TConfig.GetSaveSamePlace: Boolean;
begin
  Result := FSaveSamePlace;
end;

function TConfig.GetReplace: Boolean;
begin
  Result := FReplace;
end;

function TConfig.GetSize: Integer;
begin
  Result := FSize;
end;

function TConfig.GetSizeType: Integer;
begin
  Result := FSizeType;
end;

procedure TConfig.Save;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.Access := KEY_WRITE;
    Reg.RootKey := HKEY_CURRENT_USER;
    Reg.OpenKey(REGKEY, true);
    Reg.WriteInteger('lastsize', FSize);
    Reg.WriteInteger('lasttype', FSizeType);
    Reg.WriteBool('lastsave', FSaveSamePlace);
    Reg.WriteBool('lastdelete', FDelete);
    Reg.WriteBool('lastreplace', FReplace);
  finally
    if Assigned(Reg) then
    begin
      Reg.CloseKey;
      Reg.Free;
    end;
  end;
end;

procedure TConfig.SetDelete(Value: boolean);
begin
  FDelete := Value;
end;

procedure TConfig.SetSaveSamePlace(Value: boolean);
begin
  FSaveSamePlace := Value;
end;

procedure TConfig.SetReplace(Value: boolean);
begin
  FReplace := Value;
end;

procedure TConfig.SetSize(Value: integer);
begin
  FSize := Value;
end;

procedure TConfig.SetSizeType(Value: integer);
begin
  FSizeType := Value;
end;

end.
