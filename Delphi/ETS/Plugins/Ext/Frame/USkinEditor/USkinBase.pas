unit USkinBase;

interface

uses
  Windows, Controls, GDIHelper, UDUIForm, UFrameBase, USkinEditor, Classes,
  UDUICore, UDUIButton, UDUIPanel, UDUIImage, UDUIWinWrapper, UDUIEdit, UDUIShape;

type
  TFrmSkinBase = class(TDUIFrame, ISkinEditor)
  private
    FDirtyButtons: array[0..1] of TDUIButton;
    procedure DoClick(ASender: TObject);
    function GetHelper: TBaseHelper;
  protected
    procedure DoCommit; virtual; abstract;
    procedure DoUpdate; virtual; abstract;
    procedure SetDirty;
    procedure ChangeHelperType(AClass: TBaseHelperClass);
    property Helper: TBaseHelper read GetHelper;
  protected
    { ISkinEditor µœ÷ }
    procedure Init(AParent: TFrameBase); virtual;
    procedure UnInit; virtual;
    procedure OnDropFile(AFileName: String; AIndex, ACount: Integer); virtual;
  end;

implementation

{$R *.dfm}

{ TFrmSkinBase }

procedure TFrmSkinBase.Init(AParent: TFrameBase);
begin
  DUIParent := AParent;
  Align := alClient;
  DoUpdate;
end;

procedure TFrmSkinBase.OnDropFile(AFileName: String; AIndex, ACount: Integer);
begin
end;

procedure TFrmSkinBase.UnInit;
begin
  DUIParent := nil;
end;

procedure TFrmSkinBase.ChangeHelperType(AClass: TBaseHelperClass);
begin
  TFrmSkinEditor(DUIParent).ChangeHelperType(AClass);
end;

procedure TFrmSkinBase.DoClick(ASender: TObject);
begin
  if ASender = FDirtyButtons[0] then
  begin
    DoCommit;
    TFrmSkinEditor(DUIParent).Commit;
  end
  else
  begin
    TFrmSkinEditor(DUIParent).Cancel;
    DoUpdate;
  end;

  FDirtyButtons[0].Visible := False;
  FDirtyButtons[1].Visible := False;
end;

function TFrmSkinBase.GetHelper: TBaseHelper;
begin
  Result := TFrmSkinEditor(DUIParent).Helper;
end;

procedure TFrmSkinBase.SetDirty;
const
  CButtonSize: Integer = 10;
begin
  if not Assigned(FDirtyButtons[0]) then
  begin
    FDirtyButtons[0] := TDUIButton.Create(Self);
    with FDirtyButtons[0] do
    begin
      DUIParent := Self;
      Width := 3 * CButtonSize div 2;
      Height := 3 * CButtonSize div 2;
      Shape.Width := CButtonSize;
      Shape.Height := CButtonSize;
      Shape.ShapeType := stCommit;
      Shape.LineWidth := 1;
      Anchors := [akTop, akRight];
      OnClick := DoClick;
    end;

    FDirtyButtons[1] := TDUIButton.Create(Self);
    with FDirtyButtons[1] do
    begin
      DUIParent := Self;
      Width := 3 * CButtonSize div 2;
      Height := 3 * CButtonSize div 2;
      Shape.Width := CButtonSize;
      Shape.Height := CButtonSize;
      Shape.ShapeType := stClose;
      Shape.LineWidth := 1;
      Anchors := [akTop, akRight];
      OnClick := DoClick;
    end;
  end;

  with FDirtyButtons[0] do
  begin
    Left := Self.Width - 2 * Width;
    Visible := True;
    BringToFront;
  end;

  with FDirtyButtons[1] do
  begin
    Left := Self.Width - Width;
    Visible := True;
    BringToFront;
  end;
end;

end.
