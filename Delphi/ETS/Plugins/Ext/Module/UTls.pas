unit UTls;

{$i UConfigure.inc}

interface

uses
  Windows, Classes, SysUtils;

type
  {$IFDEF LAZARUS}
  {$M+}
  {$ELSE}
  {$METHODINFO ON}
  {$ENDIF}
  TTls = class
  private
    class var FHandle: THandle;
    class procedure Init;
    class procedure UnInit;
    //直接将静态方法定义为public会导致W1026的编译警告，可能是Delphi的Bug，
    //解决方法是定义一个常规函数，然后在常规函数中调用这些静态方法
    class procedure DeleteCurrentTls;
    class function StaticGetTlsValue(AName: String): String;
    class procedure StaticSetTlsValue(AName, AValue: String);
  published
    function GetTlsValue(AName: String): String;
    procedure SetTlsValue(AName, AValue: String);
  end;
  {$IFDEF LAZARUS}
  {$M-}
  {$ELSE}
  {$METHODINFO OFF}
  {$ENDIF}

procedure DeleteCurrentTls;
function StaticGetTlsValue(AName: String): String;
procedure StaticSetTlsValue(AName, AValue: String);

implementation

procedure DeleteCurrentTls;
begin
  TTls.DeleteCurrentTls;
end;

function StaticGetTlsValue(AName: String): String;
begin
  Result := TTls.StaticGetTlsValue(AName);
end;

procedure StaticSetTlsValue(AName, AValue: String);
begin
  TTls.StaticSetTlsValue(AName, AValue);
end;

type
  TTlsObject = class
  private
    FThread: THandle;
  strict private
    FValue: TStringList;
  private
    function GetValue(AName: String): String;
    procedure SetValue(AName: String; const AValue: String);
  public
    constructor Create;
    destructor Destroy; override;
    property Value[AName: String]: String read GetValue write SetValue; default;
  end;

{ TTlsObject }

constructor TTlsObject.Create;
begin
  FValue := TStringList.Create;
  //FValue.Sorted := True; //排序会导致更新值失败，在TStringList.InsertObject中报异常
  FThread := GetCurrentThread;
end;

destructor TTlsObject.Destroy;
begin
  FreeAndNil(FValue);

  inherited;
end;

function TTlsObject.GetValue(AName: String): String;
var
  i: Integer;
begin
  Result := '';

  i := FValue.IndexOfName(AName);
  if i < 0 then
    Exit;

  Result := FValue.ValueFromIndex[i];
end;

procedure TTlsObject.SetValue(AName: String; const AValue: String);
var
  i: Integer;
begin
  i := FValue.IndexOfName(AName);
  if i < 0 then
    FValue.Add(Format('%s=%s', [AName, AValue]))
  else
    FValue.ValueFromIndex[i] := AValue;
end;

{ TTls }

class procedure TTls.DeleteCurrentTls;
var
  obj: TTlsObject;
begin
  if FHandle = TLS_OUT_OF_INDEXES then
    Exit;

  obj := TTlsObject(TlsGetValue(FHandle));
  if not Assigned(obj) then
    Exit;

  TlsSetValue(FHandle, nil);
  obj.Free;
end;

class function TTls.StaticGetTlsValue(AName: String): String;
var
  obj: TTlsObject;
begin
  Result := '';

  if FHandle = TLS_OUT_OF_INDEXES then
    Exit;

  obj := TTlsObject(TlsGetValue(FHandle));
  if not Assigned(obj) then
    Exit;

  Result := obj[LowerCase(AName)];
end;

class procedure TTls.StaticSetTlsValue(AName, AValue: String);
var
  obj: TTlsObject;
begin
  if FHandle = TLS_OUT_OF_INDEXES then
    Exit;

  obj := TTlsObject(TlsGetValue(FHandle));
  if not Assigned(obj) then
  begin
    obj := TTlsObject.Create;
    TlsSetValue(FHandle, obj);
  end;

  obj[LowerCase(AName)] := AValue;
end;

class procedure TTls.Init;
begin
  FHandle := TlsAlloc;
end;

class procedure TTls.UnInit;
begin
  DeleteCurrentTls;

  if FHandle <> TLS_OUT_OF_INDEXES then
  begin
    TlsFree(FHandle);
    FHandle := TLS_OUT_OF_INDEXES;
  end;
end;

function TTls.GetTlsValue(AName: String): String;
begin
  Result := StaticGetTlsValue(AName);
end;

procedure TTls.SetTlsValue(AName, AValue: String);
begin
  StaticSetTlsValue(AName, AValue);
end;

initialization
  TTls.Init;

finalization
  TTls.UnInit;

end.
