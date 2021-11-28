unit UETSRegComponents;

interface

procedure RegComponents;

implementation

uses
  Classes, UETSTreeGrid;

procedure RegComponents;
begin
  RegisterClasses([TETSTreeGrid]);
end;

end.
