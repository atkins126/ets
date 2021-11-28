unit UETSEntry;

interface

{$IFDEF PACKAGE_MODE}
procedure Register;
{$ENDIF}

implementation

uses
  Forms, SysUtils, ToolsAPI, DesignIntf, DesignEditors,
  UETSWizard, UFrameBase, UETSMenu, UETSNotifier;

function DoInitializeWizard(const ABorlandIDEServices: IBorlandIDEServices;
  ARegisterProc: TWizardRegisterProc): Boolean;
begin
  //注册工程、窗口向导
  ARegisterProc(TETSProjectWizard.Create);
  RegisterCustomModule(TFrameBase, TCustomModule);
  ARegisterProc(TETSFrameWizard.Create(TFrameBase));

  //初始化通知器
  TETSNotifierManager.Init(ABorlandIDEServices, ARegisterProc);

  //初始化菜单
  TETSMenuManager.Init(ABorlandIDEServices, ARegisterProc);

  Result := True;
end;

{$IFDEF PACKAGE_MODE}
var
  GWizard: array of Integer;

function RegisterProc(const AWizard: IOTAWizard): Boolean;
begin
  SetLength(GWizard, Length(GWizard) + 1);
  GWizard[Length(GWizard) - 1] := (BorlandIDEServices as IOTAWizardServices).AddWizard(AWizard);

  Result := True;
end;

procedure UnRegisterProc;
var
  i: Integer;
begin
  for i := 0 to Length(GWizard) - 1 do
    if GWizard[i] > 0 then
      (BorlandIDEServices as IOTAWizardServices).RemoveWizard(GWizard[i]);
  SetLength(GWizard, 0);

  TETSNotifierManager.UnInit;
end;

procedure Register;
begin
  DoInitializeWizard(BorlandIDEServices, @RegisterProc);
end;
{$ENDIF}

{$IFDEF DLL_MODE}
procedure UnRegisterProc;
begin
  //dll模式不涉及向导释放的处理

  TETSNotifierManager.UnInit;
end;

function InitWizard(const ABorlandIDEServices: IBorlandIDEServices;
  ARegisterProc: TWizardRegisterProc;
  var ATerminate: TWizardTerminateProc): Boolean; stdcall;
begin
  Result := Assigned(ABorlandIDEServices);
  DoInitializeWizard(ABorlandIDEServices, ARegisterProc);
end;

exports
  InitWizard name WizardEntryPoint;
{$ENDIF}

initialization

finalization
  UnRegisterProc;

end.
