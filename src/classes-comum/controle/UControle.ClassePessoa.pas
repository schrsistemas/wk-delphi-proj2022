unit UControle.ClassePessoa;

interface

uses
  UClasse.Endereco, UClasse.EnderecoIntegracao, UClasse.Pessoa,
  UDao.ClassePessoa, UDao.ClasseEndereco, UDao.ClasseEnderecoIntegracao,
  Generics.Collections, Rest.Json, UClasseRepostaOp, System.Classes, SysUtils;

type
  IControlePessoa = interface
    ['{7158FF70-C15B-4945-8BEE-70FE9859E043}']
  end;

  TControlePessoa = class(TInterfacedObject, IControlePessoa)
  private
  { private declarations }
  protected
  { protected declarations }
  public
  { public declarations }
    function Get(aID: Integer): TPessoa;
    function Gravar(aObj: TPessoa): TResposta;
    function Atualizar(aObj: TPessoa): TResposta;
    function Listar(): TObjectList<TPessoa>;
    function Filtrar(Campo: string; Value: Variant): TObjectList<TPessoa>;
    function Deletar(aID: Integer): Boolean;

  published
  { published declarations }
  end;

implementation

{ TControlePessoa }

function TControlePessoa.Atualizar(aObj: TPessoa): TResposta;
begin
  Result := Gravar(aObj);
end;

function TControlePessoa.Deletar(aID: Integer): Boolean;
begin
  var DAOPessoa: TDAOPessoa := TDAOPessoa.Create;
  Result := DAOPessoa.Deletar(aID);
  // Result.Msg := 'Pessoa (Id) = ' + IntToStr(aID) + ' deletado da base!';
end;

function TControlePessoa.Get(aID: Integer): TPessoa;
begin
  var DAOPessoa: TDAOPessoa := TDAOPessoa.Create;
  Result := TPessoa(DAOPessoa.Get(aID));

  var DAOEndereco: TDAOEndereco := TDAOEndereco.Create;
  Result.endereco := TEndereco(DAOEndereco.Get(aID));

  var DAOEnderecoIntegracao: TDAOEnderecoIntegracao := TDAOEnderecoIntegracao.Create;
  Result.enderecoIntegracao := TEnderecoIntegracao(DAOEnderecoIntegracao.Get(Result.endereco.idendereco));

end;

function TControlePessoa.Gravar(aObj: TPessoa): TResposta;
begin

  var DAOPessoa: TDAOPessoa := TDAOPessoa.Create;
  Result := DAOPessoa.Gravar(aObj);
  if Result.Operacao = opNovo then
  begin
    aObj.endereco.idpessoa := TPessoa(Result.Obj).idpessoa;
  end;

  var DAOEndereco: TDAOEndereco := TDAOEndereco.Create;
  Result := DAOEndereco.Gravar(aObj.endereco);
  if Result.Operacao = opNovo then
  begin
    aObj.enderecoIntegracao.idendereco := TEndereco(Result.Obj).idendereco;
  end;

  var DAOEnderecoIntegracao: TDAOEnderecoIntegracao := TDAOEnderecoIntegracao.Create;
  DAOEnderecoIntegracao.Gravar(aObj.enderecoIntegracao);

  Result.Msg := 'Pessoa (Id) = ' + IntToStr(aObj.idpessoa) + ' registrado em base!';
  Result.Obj := aObj;

end;

function TControlePessoa.Listar: TObjectList<TPessoa>;
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

function TControlePessoa.Filtrar(Campo: string; Value: Variant): TObjectList<TPessoa>;
begin
  Result := TObjectList<TPessoa>.Create;
  Result.Clear;

end;

end.

