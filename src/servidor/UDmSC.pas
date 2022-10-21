unit UDmSC;

interface

uses
  System.SysUtils, System.Classes;

type
  TDmSC = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
    class function CreateDm: Boolean;
  end;

var
  DmSC: TDmSC;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TDmSC }

class function TDmSC.CreateDm: Boolean;
begin
  if not Assigned(DmSC) then
  begin
    DmSC := TDmSC.Create(nil);
  end;

end;

end.
