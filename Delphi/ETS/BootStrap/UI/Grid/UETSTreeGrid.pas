unit UETSTreeGrid;

interface

uses
  UDUIGrid, UDUITreeGrid;

type
  {$METHODINFO ON}
  TETSTreeColumns = class(TDUITreeColumns)
  public
    function Add(ACaption: String): TDUITreeColumn;
    procedure Delete(AIndex: Integer);
    function GetItems(AIndex: Integer): TDUITreeColumn;
  published
    property Count;
  end;

  TETSTreeNode = class(TDUITreeNode)
  public
    function AddChild(ACaption: String; AFirst: Boolean): TDUITreeNode;
    procedure Clear;
    function GetItems(AIndex: Integer): TDUITreeNode;
  published
    property Caption;
    property ChildCount;
    property Collapsed;
    property Height;
    property Index;
    property Level;
    property Prior;
    property Next;
  end;

  TETSTreeGrid = class(TDUITreeGrid)
  protected
    procedure DoCreate(var AColumns: TDUITreeColumns; var ARootNode: TDUITreeNode); override;
  published
    property RootNode;
  end;
  {$METHODINFO OFF}

implementation

{ TETSTreeColumns }

function TETSTreeColumns.Add(ACaption: String): TDUITreeColumn;
begin
  Result := inherited Add(ACaption);
end;

procedure TETSTreeColumns.Delete(AIndex: Integer);
begin
  if (AIndex < 0) or (AIndex >= Count) then
    Exit;

  inherited Delete(AIndex);
end;

function TETSTreeColumns.GetItems(AIndex: Integer): TDUITreeColumn;
begin
  Result := Items[AIndex];
end;

{ TETSTreeNode }

function TETSTreeNode.AddChild(ACaption: String; AFirst: Boolean): TDUITreeNode;
begin
  Result := inherited AddChild(ACaption, AFirst);
end;

procedure TETSTreeNode.Clear;
begin
  inherited;
end;

function TETSTreeNode.GetItems(AIndex: Integer): TDUITreeNode;
begin
  Result := Childs[AIndex];
end;

{ TETSTreeGrid }

procedure TETSTreeGrid.DoCreate(var AColumns: TDUITreeColumns; var ARootNode: TDUITreeNode);
begin
  Options := Options - [goHorzTitle];

  AColumns := TETSTreeColumns.Create(Self, TDUITreeColumn);
  AColumns.Add('');

  ARootNode := TETSTreeNode.Create(TETSTreeNode);
end;

end.
