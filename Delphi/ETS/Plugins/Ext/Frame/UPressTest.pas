unit UPressTest;

{$i UConfigure.inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, StrUtils, ExtCtrls, Grids, Buttons, ComCtrls,
  UInterface, UFrameBase, UScriptThread, UDUICore, UDUIForm, UDUIWinWrapper,
  Scintilla, UMemoryBlock;

type

  { TFrmPressTest }

  TFrmPressTest = class(TFrameBase)
    WwMain: TDUIWinContainer;
    PnlLeft: TPanel;
    PnlTools: TPanel;
    SbNew: TSpeedButton;
    SbRefresh: TSpeedButton;
    SbStart: TSpeedButton;
    SbStop: TSpeedButton;
    TvScript: TTreeView;
    SpLeftRight: TSplitter;
    PnlClient: TPanel;
    PnlTitle: TPanel;
    EdScript: TScintilla;
    procedure DoControlButtonClick(ASender: TObject);
    procedure TvScriptDblClick(Sender: TObject);
    procedure TvScriptCompare(ASender: TObject; ANode1, ANode2: TTreeNode;
      AData: Integer; var ACompare: Integer);
    procedure FrameBaseInit(AParent: IParent; AIndex: Integer);
    procedure FrameBaseDropFiles(AFileName: string; AIndex, ACount: Integer);
    procedure FrameBaseAfterNotify(ANotifyType: TNotifyType);
  private
    FThreadContainer: Variant;
    procedure CreateTree;
    procedure ClearTree;
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses
  ShellAPI, UModuleBase, UTool;

type
  TTreeNodeEx = class;
  TTreeNodeEx = class(TTreeNode)
  private
    FFileName: String;
    FIsDirectory: Boolean;
  public
    constructor Create(ATreeView: TTreeView; AParentNode: TTreeNode;
      AFileName: String; AIsDirectory: Boolean);
    property FileName: String read FFileName;
    property IsDirectory: Boolean read FIsDirectory;
  end;

{$R *.dfm}

{ TTreeNodeEx }

constructor TTreeNodeEx.Create(ATreeView: TTreeView; AParentNode: TTreeNode;
  AFileName: String; AIsDirectory: Boolean);
begin
  inherited Create(ATreeView.Items);

  FFileName := AFileName;
  FIsDirectory := AIsDirectory;
  ATreeView.Items.AddNode(Self, AParentNode, ExtractFileName(FFileName), nil, naAddChild);
end;

{ TFrmPressTest }

procedure TFrmPressTest.CreateTree;
  procedure DoCreateTree(AParentNode: TTreeNode; ADirectory: String);
  var
    sr: TSearchRec;
  begin
    if SysUtils.FindFirst(ADirectory + '*.*', faAnyFile, sr) = 0 then
      try
        repeat
          if (sr.Name <> '.') and (sr.Name <> '..') then
          begin
            if sr.Attr and faDirectory <> 0 then
              DoCreateTree(TTreeNodeEx.Create(TvScript, AParentNode, ADirectory + sr.Name, True),
                ADirectory + sr.Name + '\')
            else
              TTreeNodeEx.Create(TvScript, AParentNode, ADirectory + sr.Name, False);
          end;
        until SysUtils.FindNext(sr) <> 0;
      finally
        SysUtils.FindClose(sr);
      end;
  end;
begin
  DoCreateTree(nil, '.\Script\');

  if TvScript.Items.Count > 0 then
  begin
    TvScript.AlphaSort;
    //TvScript.Selected := TvScript.Items.Item[0];
    //TvScript.Selected.MakeVisible;
  end;
end;

procedure TFrmPressTest.ClearTree;
begin
  TvScript.Items.Clear;
end;

constructor TFrmPressTest.Create(AOwner: TComponent);
begin
  inherited;

  FThreadContainer := Null;
  DoControlButtonClick(SbNew);
end;

procedure TFrmPressTest.FrameBaseAfterNotify(ANotifyType: TNotifyType);
begin
  case ANotifyType of
    ntActive: CreateTree;
    ntDeActive: ClearTree;
  end;
end;

procedure TFrmPressTest.FrameBaseInit(AParent: IParent; AIndex: Integer);
begin
  SbStart.Enabled := True;
  SbStop.Enabled := False;

  AcceptDropFiles := True;
end;

procedure TFrmPressTest.TvScriptCompare(ASender: TObject;
  ANode1, ANode2: TTreeNode; AData: Integer; var ACompare: Integer);
var
  tn1, tn2: TTreeNodeEx;
begin
  tn1 := TTreeNodeEx(ANode1);
  tn2 := TTreeNodeEx(ANode2);

  if tn1.IsDirectory and tn2.IsDirectory then
    ACompare := CompareText(tn1.FileName, tn2.FileName)
  else if tn1.IsDirectory then
    ACompare := -1
  else if tn2.IsDirectory then
    ACompare := 1
  else
    ACompare := CompareText(tn1.FileName, tn2.FileName);
end;

procedure TFrmPressTest.TvScriptDblClick(Sender: TObject);
begin
  if not Assigned(TvScript.Selected)
    or TTreeNodeEx(TvScript.Selected).IsDirectory then
    Exit;

  PnlTitle.Caption := TTreeNodeEx(TvScript.Selected).FileName;
  EdScript.LoadFromFile(TTreeNodeEx(TvScript.Selected).FileName);
end;

procedure TFrmPressTest.DoControlButtonClick(ASender: TObject);
  procedure doRun;
  begin
    if not VarIsNull(FThreadContainer) then
    begin
      SbStop.Enabled := False;
      FThreadContainer.Terminate;
      Exit;
    end;

    SbStart.Enabled := False;
    SbStop.Enabled := True;
    try
      FThreadContainer := GetScriptThreadContainer;
      FThreadContainer.Restart;
      FThreadContainer.RegFrame(WrapperObject(Self, False));
      if 0 = CompareText(ExtractFileExt(PnlTitle.Caption), '.py') then
        FThreadContainer.AddCacheFile(PnlTitle.Caption, IInterface(TMemoryBlock.Create(EdScript.Text, etUtf8)))
      else
        FThreadContainer.AddCacheFile(PnlTitle.Caption, IInterface(TMemoryBlock.Create(EdScript.Text, etGbk)));
      FThreadContainer.AddThread(PnlTitle.Caption, 'main()');
      FThreadContainer.WaitFor;
    finally
      FThreadContainer := Null;

      SbStart.Enabled := True;
      SbStop.Enabled := False;
    end;
  end;
begin
  case TSpeedButton(ASender).Tag of
    1: //新建
    begin
      PnlTitle.Caption := 'Untitled.js';
      EdScript.LoadFromFile('Lib/Default.js');
    end;
    2: //刷新
    begin
      ClearTree;
      CreateTree;
    end;
    3, 4: //运行、停止
    begin
      doRun;
    end;
  end;
end;

procedure TFrmPressTest.FrameBaseDropFiles(AFileName: String; AIndex, ACount: Integer);
begin
  if AIndex = 1 then //如果选择了多个文件，只取第1个
  begin
    PnlTitle.Caption := AFileName;
    EdScript.LoadFromFile(AFileName);
  end;
end;

initialization
  TFrameBase.RegFrame(TFrmPressTest);

end.
