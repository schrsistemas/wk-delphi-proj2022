unit UClasseServidor.Pessoa;

interface

uses
  System.Classes, UClasse.Pessoa, UControle.ClassePessoa, UClasseRepostaOp,
  Generics.Collections, Rest.Json, SysUtils;

type
    {$METHODINFO ON}
  TClasseServidorPessoa = class(TComponent)
    function Get(aID: Integer): TPessoa;

    function Gravar(aObj: TPessoa): TResposta;
    function Atualizar(aObj: TPessoa): TResposta;
    function Deletar(aID: Integer): Boolean;

    function Filtrar(Campo: string; Value: string): TObjectList<TPessoa>;
    function Listar: TObjectList<TPessoa>;

    function Importar(value: TStream): Boolean;
    function Exportar: TStream;

  end;
    {$METHODINFO OFF}

implementation

uses
  UDao.ClassePessoa;

{ TClasseServidorPessoa }

function TClasseServidorPessoa.Atualizar(aObj: TPessoa): TResposta;
begin
  Result := Gravar(aObj);
end;

function TClasseServidorPessoa.Deletar(aID: Integer): Boolean;
begin
  var DAOPessoa: TDAOPessoa := TDAOPessoa.Create;
  Result := DAOPessoa.Deletar(aID);
end;

function TClasseServidorPessoa.Exportar: TStream;
begin

end;

function TClasseServidorPessoa.Filtrar(Campo, Value: string): TObjectList<TPessoa>;
begin
  Result := TObjectList<TPessoa>.Create;
  Result.Clear;
  var DAOPessoa: TDAOPessoa := TDAOPessoa.Create;
  var Ids: TStringList := DAOPessoa.ListarIds(Campo, Value);
  for var I := 0 to Ids.Count - 1 do
  begin
    Result.Add(Get(StrToIntDef(Ids[I], 0)));
  end;
end;

function TClasseServidorPessoa.Get(aID: Integer): TPessoa;
begin
  var auxPessoa := TControlePessoa.Create;
  Result := auxPessoa.Get(aID);
end;

function TClasseServidorPessoa.Gravar(aObj: TPessoa): TResposta;
begin
  var auxPessoa := TControlePessoa.Create;
  Result := auxPessoa.Gravar(aObj);
end;

function TClasseServidorPessoa.Importar(value: TStream): Boolean;
begin

end;

function TClasseServidorPessoa.Listar: TObjectList<TPessoa>;
begin
  Result := TObjectList<TPessoa>.Create;
  Result.Clear;
  var DAOPessoa: TDAOPessoa := TDAOPessoa.Create;
  var Ids: TStringList := DAOPessoa.ListarIds;
  for var I := 0 to Ids.Count - 1 do
  begin
    Result.Add(Get(StrToIntDef(Ids[I], 0)));
  end;
end;

end.

