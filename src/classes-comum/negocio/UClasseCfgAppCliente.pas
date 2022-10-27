unit UClasseCfgAppCliente;

interface

uses
  UConstantes;

type
  TClasseCfgAppCliente = class(TObject)
  private
    FServidor: string;
    FPorta: Integer;
  public
    property Servidor: string read FServidor write FServidor;
    property Porta: Integer read FPorta write FPorta;
  end;

implementation

{ TClasseCfgAppCliente }

end.

