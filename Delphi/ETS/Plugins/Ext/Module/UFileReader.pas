unit UFileReader;

interface

uses
  Classes, UInterface;

type
  {$METHODINFO ON}
  TFileReader = class(TStringList)
  private
    FLineNo: Integer;
    function GetEof: Boolean;
    function GetLine: String;
  public
    procedure LoadFromFile(const AFileName: String); override;
    procedure First;
    procedure Next;
  published
    property Eof: Boolean read GetEof;
    property Line: String read GetLine;
    property Text;
  end;
  {$METHODINFO OFF}

implementation

{ TFileReader }

procedure TFileReader.LoadFromFile(const AFileName: String);
begin
  inherited;

  First;
end;

procedure TFileReader.First;
begin
  FLineNo := 0;
end;

procedure TFileReader.Next;
begin
  Inc(FLineNo);
end;

function TFileReader.GetEof: Boolean;
begin
  Result := FLineNo >= Count;
end;

function TFileReader.GetLine: String;
begin
  Result := Strings[FLineNo];
end;

end.
