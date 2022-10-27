unit USistema;

interface

uses
  UControle.ClasseCfgAppCliente, UClasseCfgAppCliente;

type
  ISistema = interface
    ['{A44973DA-D38D-4D25-8912-C19EB95FE525}']
  end;

  TSistema = class(TInterfacedObject, ISistema)
  private
    FCfgAppCliente: TClasseCfgAppCliente;
  public
    destructor Destroy; override;
    property CfgAppCliente: TClasseCfgAppCliente read FCfgAppCliente write FCfgAppCliente;
    procedure Init;
    function GravaConfigCfgCliente(aServidor: string; aPorta: Integer): Boolean;

  end;

var
  Sistema: TSistema;

implementation


{ TSistema }

destructor TSistema.Destroy;
begin
  if Assigned(FCfgAppCliente) then
    FCfgAppCliente.Free;

  inherited;
end;

function TSistema.GravaConfigCfgCliente(aServidor: string; aPorta: Integer): Boolean;
begin
  if Assigned(FCfgAppCliente) then
  begin
    FCfgAppCliente.Servidor := aServidor;
    FCfgAppCliente.Porta := aPorta;

    Result := TControleClasseCfgAppCliente.GravarIni(FCfgAppCliente);
  end;

end;

procedure TSistema.Init;
begin
  FCfgAppCliente := TControleClasseCfgAppCliente.CarregaIniParaClasse;

end;

end.

