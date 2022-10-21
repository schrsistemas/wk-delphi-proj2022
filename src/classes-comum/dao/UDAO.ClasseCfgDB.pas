unit UDAO.ClasseCfgDB;

interface

uses
  UConstantes, IniFiles, UClasseCfgDB, Forms, System.SysUtils;

type
  TDAOClasseCfgDB = class(TObject)
  private
  public
    class function GravarIni(CfgDB: TClasseCfgDB): Boolean;
    class function CarregaIniParaClasse: TClasseCfgDB;
  end;

implementation

{ TDAOClasseCfgDB }

class function TDAOClasseCfgDB.CarregaIniParaClasse: TClasseCfgDB;
begin
  var IniCfg := TIniFile.Create(ExtractFilePath(Application.ExeName) + CONFIG_INI);
  try
    Result := TClasseCfgDB.Create;

    Result.SGBD := TSGDB(IniCfg.ReadInteger(SESSAO_SGDB, IDENT_SGDB, 0));
    Result.Servidor := IniCfg.ReadString(SESSAO_SGDB, IDENT_SERVIDOR, 'localhost');
    Result.Porta := IniCfg.ReadInteger(SESSAO_SGDB, IDENT_PORTA, 0);
    Result.Banco := IniCfg.ReadString(SESSAO_SGDB, IDENT_BANCO, '');
    Result.Usuario := IniCfg.ReadString(SESSAO_SGDB, IDENT_USUARIO, '');
    Result.Senha := IniCfg.ReadString(SESSAO_SGDB, IDENT_SENHA, '');

  finally
    FreeAndNil(IniCfg);
  end;

end;

class function TDAOClasseCfgDB.GravarIni(CfgDB: TClasseCfgDB): Boolean;
begin
  var IniCfg := TIniFile.Create(ExtractFilePath(Application.ExeName) + CONFIG_INI);
  try

    IniCfg.WriteInteger(SESSAO_SGDB, IDENT_SGDB, Integer(CfgDB.SGBD));
    IniCfg.WriteString(SESSAO_SGDB, IDENT_SERVIDOR, CfgDB.Servidor);
    IniCfg.WriteInteger(SESSAO_SGDB, IDENT_PORTA, CfgDB.Porta);
    IniCfg.WriteString(SESSAO_SGDB, IDENT_BANCO, CfgDB.Banco);
    IniCfg.WriteString(SESSAO_SGDB, IDENT_USUARIO, CfgDB.Usuario);
    IniCfg.WriteString(SESSAO_SGDB, IDENT_SENHA, CfgDB.Senha);

  finally
    FreeAndNil(IniCfg);
  end;

end;

end.

