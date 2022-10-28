unit USistema;

interface

uses
  UControle.ClasseCfgAppCliente, UControle.ClasseCfgAppServidor,
  UClasseCfgAppCliente, UClasseCfgAppServidor;

type
  ISistema = interface
    ['{A44973DA-D38D-4D25-8912-C19EB95FE525}']
  end;

  TSistema = class(TInterfacedObject, ISistema)
  private
    FCfgAppCliente: TClasseCfgAppCliente;
    FCfgAppServidor: TClasseCfgAppServidor;
  public
    destructor Destroy; override;
    property CfgAppCliente: TClasseCfgAppCliente read FCfgAppCliente write FCfgAppCliente;
    property CfgAppServidor: TClasseCfgAppServidor read FCfgAppServidor write FCfgAppServidor;
    procedure Init;
    function GravaConfigCfgCliente(aServidor: string; aPorta: Integer): Boolean;
    function GravaConfigCfgServidor(aPorta: Integer): Boolean;

  end;

var
  Sistema: TSistema;

implementation


{ TSistema }

destructor TSistema.Destroy;
begin
  if Assigned(FCfgAppCliente) then
    FCfgAppCliente.Free;

  if Assigned(FCfgAppServidor) then
    FCfgAppServidor.Free;

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

function TSistema.GravaConfigCfgServidor(aPorta: Integer): Boolean;
begin
  if Assigned(FCfgAppServidor) then
  begin
    FCfgAppServidor.Porta := aPorta;

    Result := TControleClasseCfgAppServidor.GravarIni(FCfgAppServidor);
  end;
end;

procedure TSistema.Init;
begin
  FCfgAppCliente := TControleClasseCfgAppCliente.CarregaIniParaClasse;
  FCfgAppServidor := TControleClasseCfgAppServidor.CarregaIniParaClasse;

end;

end.

