unit USkinImage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GDIHelper, IGDIPlus, USkinBase, UDUICore, UFrameBase, UDUIWinWrapper,
  UDUIEdit, UDUIPanel, UDUIImage, UDUIButton, UDUIShape;

type
  TFrmSkinImage = class(TFrmSkinBase)
    BlChildImage: TDUIButtonList;
    ImgMain: TDUIImage;
    PnlChild: TDUIPanel;
    ImgChild: TDUIImage;
    EdLeft: TDUIEdit;
    EdTop: TDUIEdit;
    EdWidth: TDUIEdit;
    EdHeight: TDUIEdit;
    BtnTransparent: TDUIButton;
    procedure BtnTransparentClick(Sender: TObject);
  private
    FMergeBitmap: IGPBitmap;
    FMergeGraphics: IGPGraphics;
    procedure DoClick(ASender: TObject);
    procedure UpdateButtons;
  protected
    procedure Init(AParent: TFrameBase); override;
    procedure UnInit; override;
    procedure OnDropFile(AFileName: String; AIndex, ACount: Integer); override;
    procedure DoCommit; override;
    procedure DoUpdate; override;
  end;

implementation

uses
  UTool;

{$R *.dfm}

{ TFrmSkinImage }

procedure TFrmSkinImage.DoClick(ASender: TObject);
var
  btn: TDUISpeedButton;
begin
  btn := ASender as TDUISpeedButton;
  if btn.Tag >= 0 then
  begin
  
  end;
end;

procedure TFrmSkinImage.DoCommit;
begin
  if not Assigned(Helper) then
    ChangeHelperType(TImageHelper);

  TImageHelper(Helper).Picture := ImgMain.Picture;
end;

procedure TFrmSkinImage.DoUpdate;
begin
  if Assigned(Helper) then
  begin
    ImgMain.Picture := TImageHelper(Helper).Picture; //拷贝后，Image指向同一个句柄，会导致图片修改会影响原内容，因此，要重新复制一份新的句柄
    ImgMain.Picture.Image := TImageHelper(Helper).Picture.Image.Clone;
  end
  else
    ImgMain.Picture.Image := nil;

  UpdateButtons;
end;

procedure TFrmSkinImage.BtnTransparentClick(Sender: TObject);
var
  clrTransparent: TGPColor;
  bmpSrc, bmpDest: IGPBitmap;
  gra: TGPGraphics;
  ia: IGPImageAttributes;
begin
  bmpSrc := ImgMain.Picture.Bitmap;
  clrTransparent := bmpSrc.Pixels[0, 0];
  bmpDest := TGPBitmap.Create(bmpSrc.Width, bmpSrc.Height);
  gra := TGPGraphics.Create(bmpDest);
  ia := TGPImageAttributes.Create;
  ia.SetColorKey(clrTransparent, clrTransparent, ColorAdjustTypeBitmap);
  gra.DrawImage(bmpSrc, MakeRect(0, 0, bmpSrc.Width, bmpSrc.Height),
    0, 0, bmpSrc.Width, bmpSrc.Height, UnitPixel, ia);

  ImgMain.Picture.Image := bmpDest;
  UpdateButtons;
  SetDirty;
end;

procedure TFrmSkinImage.Init(AParent: TFrameBase);
begin
  inherited;

  AParent.AcceptDropFiles := True;
end;

procedure TFrmSkinImage.OnDropFile(AFileName: String; AIndex, ACount: Integer);
var
  img: IGPImage;
begin
  if ACount = 1 then
  begin
    ImgMain.Picture.Childs.Clear;
    ImgMain.Picture.LoadFromFile(AFileName);
    UpdateButtons;
    SetDirty;
  end
  else if ACount > 1 then
  begin
    img := TGPImage.Create(AFileName);

    if AIndex = 1 then
    begin
      ImgMain.Picture.Childs.Clear;
      FMergeBitmap := TGPBitmap.Create(img.Width, ACount * Integer(img.Height));
      FMergeGraphics := TGPGraphics.Create(FMergeBitmap);
    end;

    FMergeGraphics.DrawImage(img,
      0, (AIndex - 1) * Integer(FMergeBitmap.Height) div ACount,
      FMergeBitmap.Width, Integer(FMergeBitmap.Height) div ACount);
    ImgMain.Picture.Childs.AddChild(ExtractNakedFileName(AFileName),
      0, (AIndex - 1) * Integer(FMergeBitmap.Height) div ACount,
      FMergeBitmap.Width, Integer(FMergeBitmap.Height) div ACount);

    if AIndex = ACount then
    begin
      ImgMain.Picture.Image := FMergeBitmap;
      UpdateButtons;
      SetDirty;

      FMergeGraphics := nil;
      FMergeBitmap := nil;
    end;
  end;
end;

procedure TFrmSkinImage.UnInit;
begin
  TFrameBase(DUIParent).AcceptDropFiles := False;

  inherited;
end;

procedure TFrmSkinImage.UpdateButtons;
var
  i, iIndex: Integer;
begin
  BlChildImage.Clear;
  if not Assigned(ImgMain.Picture.Image) then
    Exit;

  for i := 0 to ImgMain.Picture.Childs.Count - 1 do
  begin
    iIndex := BlChildImage.AddButton(ImgMain.Picture.Childs[i].Name, ImgMain.Picture.Childs[i].Image);
    with BlChildImage[iIndex] do
    begin
      OnClick := DoClick;
      Tag := iIndex;
    end;
  end;

  iIndex := blChildImage.AddButton('');
  with BlChildImage[iIndex] do
  begin
    OnClick := DoClick;
    Tag := -1;
    Shape.ShapeType := stPlus;
  end;
end;

end.
