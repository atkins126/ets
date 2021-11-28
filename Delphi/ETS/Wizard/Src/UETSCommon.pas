unit UETSCommon;

interface

uses
  Windows, Classes, SysUtils, ActiveX, ToolsAPI, UTool;

function GetActiveProjectGroup: IOTAProjectGroup;
//function GetActiveProject: IOTAProject;

function ReadFile(AFileName: String; AParameters: TStringList): String;
function ReadResource(AResName: String; AParameters: TStringList): String;
procedure WriteFile(AFileName, AContent: String);

implementation

function GetActiveProjectGroup: IOTAProjectGroup;
var
  i: Integer;
  ms: IOTAModuleServices;
begin
  ms := BorlandIDEServices as IOTAModuleServices;
  for i := 0 to ms.ModuleCount - 1 do
    if Succeeded(ms.Modules[i].QueryInterface(IOTAProjectGroup, Result)) then
      Exit;

  Result := nil;
end;

{
function GetActiveProject: IOTAProject;
var
  pg: IOTAProjectGroup;
begin
  pg := GetActiveProjectGroup;
  if Assigned(pg) then
    Result := pg.ActiveProject
  else
    Result := nil;
end;
}

function ReadFile(AFileName: String; AParameters: TStringList): String;
begin
  Result := LoadFile(AFileName);
  if (Result = '') or not Assigned(AParameters) then
    Exit;

  Result := FormatEh(Result, AParameters);
end;

function ReadResource(AResName: String; AParameters: TStringList): String;
var
  hRC: HRSRC;
  hData: THandle;
  iSize: Integer;
begin
  Result := '';
  if '' = AResName then
    Exit;

  hRC := FindResource(HInstance, @AResName[1], RT_RCDATA);
  if 0 = hRC then
    Exit;

  iSize := SizeofResource(HInstance, hRC);
  if 0 = iSize then
    Exit;

  hData := LoadResource(HInstance, hRC);

  if 0 >= hData then
    Exit;

  try
    SetLength(Result, iSize);
    Move(LockResource(hData)^, Result[1], iSize);
    UnlockResource(hData);
  finally
    FreeResource(hData);
  end;

  Result := FormatEh(Result, AParameters);
end;

procedure WriteFile(AFileName, AContent: String);
begin
  with TFileStream.Create(AFileName, fmCreate) do
    try
      Write(AContent[1], Length(AContent));
    finally
      Free;
    end;
end;

end.
