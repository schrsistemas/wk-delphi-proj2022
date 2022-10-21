unit UConstantes;

interface

type
  TSGDB = (sgdbMySQL, sgdbPostgreSQL);

const
{$REGION 'Configuração do SGDB'}
  CONFIG_INI = 'CONFIG.INI';
  SESSAO_SGDB = 'BASE';
  IDENT_SGDB = 'SGDB';
  IDENT_USUARIO = 'USUARIO';
  IDENT_SENHA = 'SENHA';
  IDENT_PORTA = 'PORTA';
  IDENT_SERVIDOR = 'SERVIDOR';
  IDENT_BANCO = 'BANCO';
{$ENDREGION}

{$REGION 'REST SERVER'}
  PORTA_REST_SERVER = '9020';
{$ENDREGION}

implementation

end.

