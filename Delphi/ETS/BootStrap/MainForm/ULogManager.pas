unit ULogManager;

{$i UConfigure.inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UMessageConst, UInterface, UTool;

type
  TFmLog = class(TForm, ICallBack)
    MmLog: TMemo;
    PnlControl: TPanel;
    BtnClear: TButton;
    procedure FormCreate(Sender: TObject);
    procedure BtnClearClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { ICallBack µœ÷ }
    function CallBack(AMessage, AWParam, ALParam: Cardinal): HRESULT; stdcall;
  private
    FCallBack: Pointer;
    function GetLogManager: ILogManager;
  protected
    procedure WndProc(var AMessage: TMessage); override;
  end;

implementation

{$R *.dfm}

{ TFmLog }

procedure TFmLog.BtnClearClick(Sender: TObject);
begin
  GetLogManager.Clear;
end;

function TFmLog.CallBack(AMessage, AWParam, ALParam: Cardinal): HRESULT;
begin
  PostMessage(Handle, AMessage, AWParam, ALParam);
  Result := S_OK;
end;

procedure TFmLog.FormCreate(Sender: TObject);
var
  msg: TMessage;
begin
  msg.Msg := WM_SETCURSOR;
  WndProc(msg);

  FCallBack := GetLogManager.RegistCallBack(Self);
end;

procedure TFmLog.FormDestroy(Sender: TObject);
begin
  if Assigned(FCallBack) then
  begin
    GetLogManager.UnRegistCallBack(FCallBack);
    FCallBack := nil;
  end;
end;

function TFmLog.GetLogManager: ILogManager;
begin
  Result := IDispatch(GetRawManager.Service['Log']) as ILogManager;
end;

procedure TFmLog.WndProc(var AMessage: TMessage);
begin
  case AMessage.Msg of
    WM_SETCURSOR:
    begin
      if PtInRect(PnlControl.ClientRect, PnlControl.ScreenToClient(Mouse.CursorPos)) then
        PnlControl.Height := 31
      else
        PnlControl.Height := 3;
    end;
    SM_LOG_ADD:
    begin
      MmLog.Lines.Add(GetLogManager.GetLog(AMessage.LParam));
      BtnClear.Enabled := True;
    end;
    SM_LOG_CLEAR:
    begin
      MmLog.Lines.Clear;
      BtnClear.Enabled := False;
    end;
  end;

  inherited;
end;

end.
