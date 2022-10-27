unit UControle.ClassePessoa;

interface

uses
  UClasse.Endereco, UClasse.EnderecoIntegracao, UClasse.Pessoa,
  UDao.ClassePessoa, UDao.ClasseEndereco, UDao.ClasseEnderecoIntegracao,
  Generics.Collections, Rest.Json, UClasseRepostaOp;

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
    function Atualizar(aObj: TPessoa): TPessoa;
    function Listar(): TObjectList<TPessoa>; overload;
    function Listar(Campo: string; Value: Variant): TObjectList<TPessoa>; overload;
    function Deletar(aID: Integer): Boolean;

  published
  { published declarations }
  end;

implementation

{ TControlePessoa }

function TControlePessoa.Atualizar(aObj: TPessoa): TPessoa;
begin

end;

function TControlePessoa.Deletar(aID: Integer): Boolean;
begin

end;

function TControlePessoa.Get(aID: Integer): TPessoa;
begin

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

end;

function TControlePessoa.Listar: TObjectList<TPessoa>;
begin

end;

function TControlePessoa.Listar(Campo: string; Value: Variant): TObjectList<TPessoa>;
begin

end;

end.

