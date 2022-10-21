unit UClasseCfgDB;

interface

uses
  UConstantes;

type
  TClasseCfgDB = class(TObject)
  private
    FSGBD: TSGDB;
    FBanco: string;
    FServidor: string;
    FSenha: string;
    FUsuario: string;
    FPorta: Integer;
    function GetDriveName: string;
  public
    property SGBD: TSGDB read FSGBD write FSGBD;
    property Usuario: string read FUsuario write FUsuario;
    property Senha: string read FSenha write FSenha;
    property Servidor: string read FServidor write FServidor;
    property Banco: string read FBanco write FBanco;
    property Porta: Integer read FPorta write FPorta;
    property DriverName: string read GetDriveName;
  end;

implementation

{ TClasseCfgDB }

function TClasseCfgDB.GetDriveName: string;
begin
  case SGBD of
    sgdbMySQL:
      Result := 'MySQL';
    sgdbPostgreSQL:
      Result := 'PG';
  end;
end;

end.

