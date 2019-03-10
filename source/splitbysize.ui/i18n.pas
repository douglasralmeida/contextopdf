unit i18n;

interface

uses Generics.Collections;

type
  TExpression = class
    FValue: String;
  public
    constructor Create(AValue: String);
    function GetValue: String;
  end;

  TI18n = class
    FDictionary: TDictionary<String, TExpression>;
    function LoadData: Boolean;
  public
    constructor Create;
    destructor Destroy;
    function GetExpression(Key: String): String;
  end;

implementation

uses
  System.Classes, System.SysUtils;

constructor TExpression.Create(AValue: string);
begin
  inherited Create;

  FValue := AValue;
end;

function TExpression.GetValue;
begin
  Result := GetValue;
end;

constructor TI18n.Create;
begin
  inherited Create;

  FDictionary := TDictionary<String, TExpression>.Create(64);
  if not LoadData then
  begin
    FDictionary.Free;
    Exception.Create('I18n data failed to load.');
  end;
end;

destructor TI18n.Destroy;
begin
  if Assigned(FDictionary) then
  begin
    FDictionary.Clear;
    FDictionary.Free;
  end;

  inherited Destroy;
end;

function TI18n.LoadData: Boolean;
const
  DATAFILENAME = 'i18n.dat';
var
  i: Integer;
  data: TStringList;
  item: TArray<String>;
begin
  if not Assigned(FDictionary) then
    Exit(false);
  data := TStringList.Create;
  if not FileExists(DATAFILENAME) then
    Exit(false);
  data.LoadFromFile(DATAFILENAME);
  for i := 0 to data.Count - 1 do
  begin
    item := data[i].Split(['='], 2);
    FDictionary.Add(item[0], TExpression.Create(item[1]));
  end;
  data.Free;

  Result := true;
end;

function TI18n.GetExpression(Key: string): string;
var
  expr: TExpression;
begin
  if FDictionary.TryGetValue(Key, expr) then
    Result := expr.GetValue
  else
    Result := Key;
end;

end.
