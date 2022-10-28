unit UDAO.ClasseCfgAppServidor;

interface

uses
  UConstantes, IniFiles, UClasseCfgAppServidor, System.SysUtils;

type
  TDAOClasseCfgAppServidor = class(TObject)
  private
  public
    class function GravarIni(CfgDB: TClasseCfgAppServidor): Boolean;
    class function CarregaIniParaClasse: TClasseCfgAppServidor;
  end;

implementation

{ TDAOClasseCfgAppServidor }

class function TDAOClasseCfgAppServidor.CarregaIniParaClasse: TClasseCfgAppServidor;
begin
  var IniCfg := TIniFile.Create(ExtractFilePath(ParamStr(0)) + CONFIG_INI);
  try
    Result := TClasseCfgAppServidor.Create;

    Result.Porta := IniCfg.ReadInteger(SESSAO_REST_SERVER, IDENT_PORTA_REST_SERVER, PORTA_REST_SERVER);
  finally
    FreeAndNil(IniCfg);
  end;

end;

class function TDAOClasseCfgAppServidor.GravarIni(CfgDB: TClasseCfgAppServidor): Boolean;
begin
  var IniCfg := TIniFile.Create(ExtractFilePath(ParamStr(0)) + CONFIG_INI);
  try

    IniCfg.WriteInteger(SESSAO_REST_SERVER, IDENT_PORTA_REST_SERVER, CfgDB.Porta);

  finally
    FreeAndNil(IniCfg);
  end;

end;

end.

