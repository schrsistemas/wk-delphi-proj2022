unit UDAO.ClasseCfgAppCliente;

interface

uses
  UConstantes, IniFiles, UClasseCfgAppCliente, System.SysUtils;

type
  TDAOClasseCfgAppCliente = class(TObject)
  private
  public
    class function GravarIni(CfgDB: TClasseCfgAppCliente): Boolean;
    class function CarregaIniParaClasse: TClasseCfgAppCliente;
  end;

implementation

{ TDAOClasseCfgAppCliente }

class function TDAOClasseCfgAppCliente.CarregaIniParaClasse: TClasseCfgAppCliente;
begin
  var IniCfg := TIniFile.Create(ExtractFilePath(ParamStr(0)) + CONFIG_INI);
  try
    Result := TClasseCfgAppCliente.Create;

    Result.Servidor := IniCfg.ReadString(SESSAO_REST_SERVER, IDENT_SERVIDOR_REST_SERVER, SERVIDOR_REST_SERVER);
    Result.Porta := IniCfg.ReadInteger(SESSAO_REST_SERVER, IDENT_PORTA_REST_SERVER, PORTA_REST_SERVER);
  finally
    FreeAndNil(IniCfg);
  end;

end;

class function TDAOClasseCfgAppCliente.GravarIni(CfgDB: TClasseCfgAppCliente): Boolean;
begin
  var IniCfg := TIniFile.Create(ExtractFilePath(ParamStr(0)) + CONFIG_INI);
  try

    IniCfg.WriteString(SESSAO_REST_SERVER, IDENT_SERVIDOR_REST_SERVER, CfgDB.Servidor);
    IniCfg.WriteInteger(SESSAO_REST_SERVER, IDENT_PORTA_REST_SERVER, CfgDB.Porta);

  finally
    FreeAndNil(IniCfg);
  end;

end;

end.

