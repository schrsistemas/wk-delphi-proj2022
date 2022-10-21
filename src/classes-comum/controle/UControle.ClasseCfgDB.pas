unit UControle.ClasseCfgDB;

interface

uses
  UClasseCfgDB, UDAO.ClasseCfgDB;

type
  TControleClasseCfgDB = class(TObject)
  private
  public
    class function GravarIni(CfgDB: TClasseCfgDB): Boolean;
    class function CarregaIniParaClasse: TClasseCfgDB;
  end;

implementation

{ TControleClasseCfgDB }

class function TControleClasseCfgDB.CarregaIniParaClasse: TClasseCfgDB;
begin
  Result := TDAOClasseCfgDB.CarregaIniParaClasse;
end;

class function TControleClasseCfgDB.GravarIni(CfgDB: TClasseCfgDB): Boolean;
begin
  Result := TDAOClasseCfgDB.GravarIni(CfgDB);
end;

end.

