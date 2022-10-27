unit UControle.ClasseCfgAppCliente;

interface

uses
  UClasseCfgAppCliente, UDAO.ClasseCfgAppCliente;

type
  TControleClasseCfgAppCliente = class(TObject)
  private
  public
    class function GravarIni(CfgDB: TClasseCfgAppCliente): Boolean;
    class function CarregaIniParaClasse: TClasseCfgAppCliente;
  end;

implementation

{ TControleClasseCfgAppCliente }

class function TControleClasseCfgAppCliente.CarregaIniParaClasse: TClasseCfgAppCliente;
begin
  Result := TDAOClasseCfgAppCliente.CarregaIniParaClasse;
end;

class function TControleClasseCfgAppCliente.GravarIni(CfgDB: TClasseCfgAppCliente): Boolean;
begin
  Result := TDAOClasseCfgAppCliente.GravarIni(CfgDB);
end;

end.

