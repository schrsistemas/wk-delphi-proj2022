unit UControle.ClasseCfgAppServidor;

interface

uses
  UClasseCfgAppServidor, UDAO.ClasseCfgAppServidor;

type
  TControleClasseCfgAppServidor = class(TObject)
  private
  public
    class function GravarIni(CfgDB: TClasseCfgAppServidor): Boolean;
    class function CarregaIniParaClasse: TClasseCfgAppServidor;
  end;

implementation

{ TControleClasseCfgAppServidor }

class function TControleClasseCfgAppServidor.CarregaIniParaClasse: TClasseCfgAppServidor;
begin
  Result := TDAOClasseCfgAppServidor.CarregaIniParaClasse;
end;

class function TControleClasseCfgAppServidor.GravarIni(CfgDB: TClasseCfgAppServidor): Boolean;
begin
  Result := TDAOClasseCfgAppServidor.GravarIni(CfgDB);
end;

end.

