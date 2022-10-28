unit UClasseCfgAppServidor;

interface

uses
  UConstantes;

type
  TClasseCfgAppServidor = class(TObject)
  private
    FPorta: Integer;

  public
    property Porta: Integer read FPorta write FPorta;

  end;

implementation

{ TClasseCfgAppServidor }

end.

