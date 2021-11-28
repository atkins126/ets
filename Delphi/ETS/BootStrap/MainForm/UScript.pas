unit UScript;

interface

uses
  Windows, Classes, SysUtils, ActiveX, Variants, UDUICore, UFrameBase, UInterface;

type
  TFrmScriptFrame = class(TFrameBase)
    procedure FrameBaseInit(AParent: IParent; AIndex: Integer);
  private
    FScript: IScript;
  published
    property AcceptDropFiles;
  end;

implementation

uses
  TypInfo, qjson, UModuleBase, UDispatchWrapper, UDUIUtils;

{$R *.dfm}

procedure TFrmScriptFrame.FrameBaseInit(AParent: IParent; AIndex: Integer);
  function getScript(AScriptName: String): IScript;
  var
    objModule, objScript: IDispatch;
  begin
    Result := nil;

    objModule := GetRawManager.Plugins['Script'];
    if not Assigned(objModule) then
      Exit;

    case TScriptLanguage(GetEnumValue(TypeInfo(TScriptLanguage), AScriptName)) of
      slJScript: objScript := Variant(objModule).GetJScript;
      slPython: objScript := Variant(objModule).GetPython;
    else
      Exit;
    end;

    if not Assigned(objScript) then
      Exit;

    if not Supports(objScript, IScript, Result) then
      Result := nil;
  end;
var
  js, jsConfig: TQJson;
begin
  jsConfig := TQJson(AParent.Param[AIndex].FConfig);
  if not Assigned(jsConfig) then
    Exit;

  FScript := getScript(jsConfig.ValueByName('Language', 'slJScript'));
  if not Assigned(FScript) then
    Exit;

  FScript.RegContainer(nil);
  FScript.RegFrame(WrapperObject(Self, False));

  if jsConfig.HasChild('File', js) then
    //FScript.RunModule(js.Value, 'Init();')
    FScript.RunCode(Format('var __main__ = Require("%s"); __main__.Init();', [js.Value]))
  else if jsConfig.HasChild('Source', js) then
    FScript.RunCode(js.Value);
end;

//GetFrame
//获取某个控件下面的子控件，支持多级查找，支持使用控件名称或索引
//参数0：
//要获取组件的路径名，支持按索引和组件名两种方式查找，多级路径用“.”连接
//如果输入空，则返回根组件
//调用样例(js代码)：
//objFrame.GetFrame('Parent1.Parent2.<其他父控件>.Control')
function GetFrame(AObject: TObject; AName: String; AFlag: Word;
  AParamCount: Integer; const AParams: PVariantArray): OleVariant;
  function getControlByName(AParent: TDUIBase; AName: String): TDUIBase;
  var
    i: Integer;
  begin
    for i := 0 to AParent.ControlCount - 1 do
    begin
      Result := AParent.Controls[i];
      if CompareText(Result.Name, AName) = 0 then
        Exit;
    end;

    raise Exception.Create('控件不存在');
  end;
  function getControlByIndex(AParent: TDUIBase; AIndex: Integer): TDUIBase;
  begin
    if (AIndex < 0) or (AIndex >= AParent.ControlCount) then
      raise Exception.Create('控件不存在');

    Result := AParent.Controls[AIndex];
  end;
var
  ctl: TDUIBase;
  pcBegin, pcEnd: PChar;
  strName: String;
begin
  Result := Null;
  if not (AObject is TDUIBase) then
    Exit;
  if AParamCount <> 1 then
    Exit;

  ctl := TDUIBase(AObject);
  strName := VarToStr(AParams[0]);
  pcBegin := @strName[1];
  if pcBegin^ = '[' then
    pcBegin := pcBegin + 1;
  pcEnd := pcBegin + 1;
  while pcBegin^ <> #0 do
  begin
    case pcEnd^ of
      '[', '.':
      begin
        if pcBegin < pcEnd then
          ctl := getControlByName(ctl, Copy(pcBegin, 0, pcEnd - pcBegin));
        pcBegin := pcEnd + 1;
        pcEnd := pcBegin;
      end;
      ']':
      begin
        ctl := getControlByIndex(ctl, StrToIntDef(Copy(pcBegin, 0, pcEnd - pcBegin), -1));
        pcBegin := pcEnd + 1;
        pcEnd := pcBegin;
      end;
      #0:
      begin
        ctl := getControlByName(ctl, Copy(pcBegin, 0, pcEnd - pcBegin));
        Break;
      end;
    else
      Inc(pcEnd);
    end;
  end;

  if Assigned(ctl) then
    Result := WrapperObject(ctl, False);
end;

function CreateFrameImpl(AObject: TObject; AName: String; AFlag: Word;
  AParamCount: Integer; const AParams: PVariantArray): OleVariant;
var
  js: TQJson;
  ss: TStringStream;
  ctl: TObject;
begin
  Result := Null;
  if not (AObject is TDUIBase) then
    Exit;
  if AParamCount <> 1 then
    Exit;

  js := nil;
  ss := nil;
  ctl := nil;
  try
    js := TQJson.Create;
    ss := TStringStream.Create(VarToStr(AParams[0]));
    js.LoadFromStream(ss);
    JsonToComponent(ctl, js, AObject);
  finally
    FreeAndNil(js);
    FreeAndNil(ss);
  end;

  if Assigned(ctl) then
    Result := WrapperObject(ctl, False);
end;

type
  TSyncCallback = class
  strict private
    FObject: TObject;
    FName: String;
    FFlag: Word;
    FParamCount: Integer;
    FParams: PVariantArray;
    FResult: POleVariant;
  public
    constructor Create(AObject: TObject; AName: String; AFlag: Word;
      AParamCount: Integer; const AParams: PVariantArray; AResult: POleVariant);
    procedure Call;
  end;

{ TSyncCallback }

constructor TSyncCallback.Create(AObject: TObject; AName: String; AFlag: Word;
  AParamCount: Integer; const AParams: PVariantArray; AResult: POleVariant);
begin
  inherited Create;

  FObject := AObject;
  FName := AName;
  FFlag := AFlag;
  FParamCount := AParamCount;
  FParams := AParams;
  FResult := AResult;
end;

procedure TSyncCallback.Call;
begin
  FResult^ := CreateFrameImpl(FObject, FName, FFlag, FParamCount, FParams);
end;

//CreateFrame
//传入json格式的配置，创建子控件，控件支持级联(类似dfm，但改用json作为配置)
//调用样例(js代码)：
//objFrame.CreateFrame('{"__class__": "TDUIBase", "__property__": {...}, "__child__": [...]}')
function CreateFrame(AObject: TObject; AName: String; AFlag: Word;
  AParamCount: Integer; const AParams: PVariantArray): OleVariant;
begin
  //控件创建的过程统一放在主线程中处理，防止待句柄的控件的消息循环出现问题
  if GetCurrentThreadID = MainThreadID then
    Result := CreateFrameImpl(AObject, AName, AFlag, AParamCount, AParams)
  else
    with TSyncCallback.Create(AObject, AName, AFlag, AParamCount, AParams, @Result) do
      try
        TThread.Synchronize(nil, Call);
      finally
        Free;
      end;
end;

initialization
  TDispatchWrapper.RegCustomDispatch(TDUIBase, 'GetFrame', GetFrame);
  TDispatchWrapper.RegCustomDispatch(TDUIBase, 'CreateFrame', CreateFrame);

end.
