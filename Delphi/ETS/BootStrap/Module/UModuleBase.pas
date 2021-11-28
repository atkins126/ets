unit UModuleBase;

interface

uses
  Classes, UInterface, UDispatchWrapper;

type
  TModuleBase = class(TInterfacedBase, IDispatch)
  private
    FDispatch: TDispatchWrapper;
    function GetDispatch: IDispatch;
  protected
    property DispatchImpl: IDispatch read GetDispatch implements IDispatch;
  public
    constructor Create; reintroduce; virtual;
    destructor Destroy; override;
  end;

function WrapperObject(AObject: TObject; AOwned: Boolean = True): IDispatch;

implementation

uses
  Windows, SysUtils, UTool;

{ TModuleBase }

constructor TModuleBase.Create;
begin
  inherited Create(nil);

  FDispatch := TDispatchWrapper.Create(Self, False, IInterfaceNoRefCount(IInterface(Self))); //��Selfǿת��IInterface�����ᵼ�����ü����ı仯
end;

destructor TModuleBase.Destroy;
begin
  FreeAndNil(FDispatch);

  inherited;
end;

function TModuleBase.GetDispatch: IDispatch;
begin
  Result := FDispatch;
end;

function WrapperObject(AObject: TObject; AOwned: Boolean): IDispatch;
begin
  Result := TDispatchWrapper.Create(AObject, AOwned) as IDispatch;
end;

end.
