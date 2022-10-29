unit UDao.ClasseEnderecoIntegracao;

{
  Classe de persistência da Tabela de Endereço Integracao;

}

interface

uses
  UDAO, FireDAC.Comp.Client, UClasse.EnderecoIntegracao, Generics.Collections,
  Rest.Json, UClasseRepostaOp, System.SysUtils;

type
  IDAOEnderecoIntegracao = interface
    ['{2A0E796C-F2F6-409B-8550-935E49E355D3}']
  end;

  TDAOEnderecoIntegracao = class(TDAO, IDAOEnderecoIntegracao)
  private
  public
    function Get(aID: Integer): TObject;
    function Gravar(aObj: TObject): TResposta;
    function Listar(): TObjectList<TObject>; overload;
    function Listar(Campo: string; Value: Variant): TObjectList<TObject>; overload;
  end;

implementation

{ TDAOEnderecoIntegracao }

function TDAOEnderecoIntegracao.Get(aID: Integer): TObject;
begin
  Result := TEnderecoIntegracao.Create;

  try
    Query := GeraQuery('SELECT idendereco, dsuf, nmcidade, nmbairro, nmlogradouro, dscomplemento FROM endereco_integracao WHERE idendereco = :pe_idendereco;');

    Query.Close;
    Query.ParamByName('pe_idendereco').AsInteger := aID;
    Query.Open;

    try

      TEnderecoIntegracao(Result).idEndereco := Query.FieldByName('idendereco').AsInteger;
      TEnderecoIntegracao(Result).dsuf := Query.FieldByName('dsuf').AsString;
      TEnderecoIntegracao(Result).nmcidade := Query.FieldByName('nmcidade').AsString;
      TEnderecoIntegracao(Result).nmbairro := Query.FieldByName('nmbairro').AsString;
      TEnderecoIntegracao(Result).nmlogradouro := Query.FieldByName('nmlogradouro').AsString;
      TEnderecoIntegracao(Result).dscomplemento := Query.FieldByName('dscomplemento').AsString;

    finally
      Query.Close;
    end;
  except
    on E: Exception do
    begin
      Rollback;
      raise E;
    end;
  end;
end;

function TDAOEnderecoIntegracao.Gravar(aObj: TObject): TResposta;
begin
  Result := TResposta.Create;

  try
    Query := GeraQuery('SELECT idendereco, dsuf, nmcidade, nmbairro, nmlogradouro, dscomplemento FROM endereco_integracao WHERE idendereco = :pe_idendereco;');

    Query.Close;
    Query.ParamByName('pe_idendereco').AsInteger := TEnderecoIntegracao(aObj).idEndereco;
    Query.Open;

    try

      if Query.IsEmpty then
      begin
        Query.Insert;
        Result.Operacao := opNovo;
      end
      else
      begin
        Query.Edit;
        Result.Operacao := OpAlteracao;
      end;

      Query.FieldByName('idendereco').AsInteger := TEnderecoIntegracao(aObj).idEndereco;
      Query.FieldByName('dsuf').AsString := TEnderecoIntegracao(aObj).dsuf;
      Query.FieldByName('nmcidade').AsString := TEnderecoIntegracao(aObj).nmcidade;
      Query.FieldByName('nmbairro').AsString := TEnderecoIntegracao(aObj).nmbairro;
      Query.FieldByName('nmlogradouro').AsString := TEnderecoIntegracao(aObj).nmlogradouro;
      Query.FieldByName('dscomplemento').AsString := TEnderecoIntegracao(aObj).dscomplemento;

      Query.Post;

      Result.Obj := TEnderecoIntegracao(aObj);

    finally
      Query.Close;
    end;
  except
    on E: Exception do
    begin
      Result.Operacao := opErro;
      Result.Msg := E.Message;
      Rollback;
    end;
  end;
end;

function TDAOEnderecoIntegracao.Listar(Campo: string; Value: Variant): TObjectList<TObject>;
begin
  Result := TObjectList<TObject>.Create;
  Result.Clear;

end;

function TDAOEnderecoIntegracao.Listar: TObjectList<TObject>;
begin
  Result := TObjectList<TObject>.Create;
  Result.Clear;
end;

end.

