unit UMemoryBlock;

interface

uses
  Windows, UInterface;

type
  TMemoryBlock = class(TInterfacedBase, IMemoryBlock)
  private
    FBuffer: String;
    FEncoding: TEncodingType;
  public
    constructor Create(AValue: String; AEncoding: TEncodingType); reintroduce; virtual;
  public
    //IMemoryBlock实现
    function GetEncoding(var AResult: TEncodingType): HRESULT; stdcall;
    function SetEncoding(AValue: TEncodingType): HRESULT; stdcall;
    function GetSize(var AResult: Cardinal): HRESULT; stdcall;
    function SetSize(AValue: Cardinal): HRESULT; stdcall;
    //APosition从0开始计算，和String类型的起始序号有差异
    function Read(APosition: Cardinal; var AValue: Byte; var ALength: Cardinal): HRESULT; stdcall;
    function Write(APosition: Cardinal; var AValue: Byte; ALength: Cardinal): HRESULT; stdcall;
  end;

implementation

{ TMemoryBlock }

constructor TMemoryBlock.Create(AValue: String; AEncoding: TEncodingType);
begin
  FBuffer := AValue;
  FEncoding := AEncoding;
end;

function TMemoryBlock.GetEncoding(var AResult: TEncodingType): HRESULT;
begin
  AResult := FEncoding;

  Result := S_OK;
end;

function TMemoryBlock.GetSize(var AResult: Cardinal): HRESULT;
begin
  AResult := Length(FBuffer);

  Result := S_OK;
end;

function TMemoryBlock.Read(APosition: Cardinal; var AValue: Byte; var ALength: Cardinal): HRESULT;
begin
  if Integer(APosition) >= Length(FBuffer) then
  begin
    Result := E_INVALIDARG;
    Exit;
  end;

  if Integer(APosition + ALength) >= Length(FBuffer) then
    ALength := Cardinal(Length(FBuffer)) - APosition;

  Move(FBuffer[APosition + 1], AValue, ALength);

  Result := S_OK;
end;

function TMemoryBlock.SetEncoding(AValue: TEncodingType): HRESULT;
begin
  {TODO: 添加编码集转换的代码}
  FEncoding := AValue;

  Result := S_OK;
end;

function TMemoryBlock.SetSize(AValue: Cardinal): HRESULT;
begin
  SetLength(FBuffer, AValue);

  Result := S_OK;
end;

function TMemoryBlock.Write(APosition: Cardinal; var AValue: Byte; ALength: Cardinal): HRESULT;
begin
  if Integer(APosition + ALength) >= Length(FBuffer) then
  begin
    Result := E_INVALIDARG;
    Exit;
  end;

  Move(AValue, FBuffer[APosition + 1], ALength);

  Result := S_OK;
end;

end.
