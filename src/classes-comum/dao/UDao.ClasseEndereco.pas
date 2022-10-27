unit UDao.ClasseEndereco;

{
  Classe de persistência da Tabela de Endereço;

}

interface

uses
  UDAO, FireDAC.Comp.Client, UClasse.Endereco, Generics.Collections, Rest.Json,
  UClasseRepostaOp, System.SysUtils;

type
  IDAOEndereco = interface
    ['{0D9C9278-59F0-49C6-B87F-6DD4C1130B52}']
  end;

  TDAOEndereco = class(TDAO, IDAOEndereco)
  private
  public
    function Get(aID: Integer): TObject;
    function Gravar(aObj: TObject): TResposta;
    function Listar(): TObjectList<TObject>; overload;
    function Listar(Campo: string; Value: Variant): TObjectList<TObject>; overload;
  end;

implementation

{ TDAOEndereco }

function TDAOEndereco.Get(aID: Integer): TObject;
begin
  Result := TEndereco.Create;

  try
    Query := GeraQuery('SELECT idendereco, idpessoa, dscep FROM endereco WHERE idpessoa = :pe_idpessoa;');

    Query.Close;
    Query.ParamByName('pe_idpessoa').AsInteger := aID;
    Query.Open;

    try

      TEndereco(Result).idpessoa := Query.FieldByName('idpessoa').AsInteger;
      TEndereco(Result).idendereco := Query.FieldByName('idendereco').AsInteger;
      TEndereco(Result).dscep := Query.FieldByName('dscep').AsString;

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

function TDAOEndereco.Gravar(aObj: TObject): TResposta;
begin
  Result := TResposta.Create;

  try
    Query := GeraQuery('SELECT idendereco, idpessoa, dscep FROM endereco WHERE idpessoa = :pe_idpessoa;');

    Query.Close;
    Query.ParamByName('pe_idpessoa').AsInteger := TEndereco(TEndereco(aObj)).idpessoa;
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

      Query.FieldByName('idpessoa').AsInteger := TEndereco(aObj).idpessoa;
      Query.FieldByName('idendereco').AsInteger := TEndereco(aObj).idendereco;
      Query.FieldByName('dscep').AsString := TEndereco(aObj).dscep;

      Query.Post;

      TEndereco(aObj).idendereco := Query.FieldByName('idendereco').AsInteger;

      Result.Obj := TEndereco(aObj);

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

function TDAOEndereco.Listar: TObjectList<TObject>;
begin
  Result := TObjectList<TObject>.Create;
  Result.Clear;

end;

function TDAOEndereco.Listar(Campo: string; Value: Variant): TObjectList<TObject>;
begin
  Result := TObjectList<TObject>.Create;
  Result.Clear;

end;

end.

