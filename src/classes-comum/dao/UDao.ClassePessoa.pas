unit UDao.ClassePessoa;

{
  Classe de persistência da Tabela de Endereço;

}

interface

uses
  UDAO, FireDAC.Comp.Client, UClasse.Pessoa, Generics.Collections, Rest.Json,
  UClasseRepostaOp, System.SysUtils, System.Classes;

type
  IDAOPessoa = interface
    ['{40955836-0DFA-42EE-BD1C-9BAAF2D8F5BD}']
  end;

  TDAOPessoa = class(TDAO, IDAOPessoa)
  private
  public
    function Get(aID: Integer): TObject;
    function Gravar(aObj: TObject): TResposta;
    function Atualizar(aObj: TObject): TResposta;

    function ListarIdsPendentesAtualizacaoEndereco: TStringList;
    function ListarIds(Campo: string; Value: Variant): TStringList; overload;
    function ListarIds: TStringList; overload;

    function Listar(): TObjectList<TObject>; overload;
    function Listar(Campo: string; Value: Variant): TObjectList<TObject>; overload;

    function Deletar(aID: Integer): Boolean;
  end;

implementation

{ TDAOPessoa }

function TDAOPessoa.Atualizar(aObj: TObject): TResposta;
begin
  Result := Gravar(aObj);
end;

function TDAOPessoa.Deletar(aID: Integer): Boolean;
begin
  Result := False;
  Query := GeraQuery('SELECT * FROM pessoa WHERE idpessoa = :pe_id;');

  try
    Query.Close;
    Query.ParamByName('pe_id').AsInteger := aID;
    Query.Open;

    try
      Query.Delete;
      Result := True;
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

function TDAOPessoa.Get(aID: Integer): TObject;
begin
  Result := TPessoa.Create;

  Query := GeraQuery('SELECT idpessoa, flnatureza, dsdocumento, nmprimeiro, nmsegundo, dtregistro FROM pessoa WHERE idpessoa = :pe_id;');

  try
    Query.Close;
    Query.ParamByName('pe_id').AsInteger := aID;
    Query.Open;

    try

      TPessoa(Result).idpessoa := Query.FieldByName('idpessoa').AsInteger;
      TPessoa(Result).flnatureza := TNatureza(Query.FieldByName('flnatureza').AsInteger);
      TPessoa(Result).dsdocumento := Query.FieldByName('dsdocumento').AsString;
      TPessoa(Result).nmprimeiro := Query.FieldByName('nmprimeiro').AsString;
      TPessoa(Result).nmsegundo := Query.FieldByName('nmsegundo').AsString;
      TPessoa(Result).dtregistro := Query.FieldByName('dtregistro').AsDateTime;

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

function TDAOPessoa.Gravar(aObj: TObject): TResposta;
begin
  Result := TResposta.Create;

  Query := GeraQuery('SELECT idpessoa, flnatureza, dsdocumento, nmprimeiro, nmsegundo, dtregistro FROM pessoa WHERE idpessoa = :pe_id;');

  try
    Query.Close;
    Query.ParamByName('pe_id').AsInteger := TPessoa(aObj).idpessoa;
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

      Query.FieldByName('idpessoa').AsInteger := TPessoa(aObj).idpessoa;
      Query.FieldByName('flnatureza').AsInteger := Integer(TPessoa(aObj).flnatureza);
      Query.FieldByName('dsdocumento').AsString := TPessoa(aObj).dsdocumento;
      Query.FieldByName('nmprimeiro').AsString := TPessoa(aObj).nmprimeiro;
      Query.FieldByName('nmsegundo').AsString := TPessoa(aObj).nmsegundo;
      Query.FieldByName('dtregistro').AsDateTime := TPessoa(aObj).dtregistro;

      Query.Post;

      TPessoa(aObj).idpessoa := Query.FieldByName('idpessoa').AsInteger;

      Result.Obj := TPessoa(aObj);

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

function TDAOPessoa.Listar: TObjectList<TObject>;
begin
  Result := TObjectList<TObject>.Create;
  Result.Clear;

end;

function TDAOPessoa.Listar(Campo: string; Value: Variant): TObjectList<TObject>;
begin
  Result := TObjectList<TObject>.Create;
  Result.Clear;

end;

function TDAOPessoa.ListarIdsPendentesAtualizacaoEndereco: TStringList;
begin
  Result := TStringList.Create;

  var auxSQL := TStringList.Create;
  auxSQL.Clear;
  auxSQL.Add('select pessoa.idpessoa from pessoa');
  auxSQL.Add('inner join endereco on (endereco.idpessoa = pessoa.idpessoa)');
  auxSQL.Add('inner join endereco_integracao on (endereco.idendereco = endereco_integracao.idendereco)');
  auxSQL.Add('where');
  auxSQL.Add('coalesce(endereco_integracao.nmcidade) = ' + QuotedStr(''));
  auxSQL.Add('or');
  auxSQL.Add('coalesce(endereco_integracao.dsuf) = ' + QuotedStr(''));

  Query := GeraQuery(auxSQL.Text);

  try
    Query.Close;
    Query.Open;
    Query.First;
    try
      while not Query.Eof do
      begin
        Result.Add(Query.FieldByName('idpessoa').AsString);
        Query.Next;
      end;

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

function TDAOPessoa.ListarIds: TStringList;
begin
  Result := TStringList.Create;

  Query := GeraQuery('SELECT idpessoa FROM pessoa;');

  try
    Query.Close;
    Query.Open;
    Query.First;
    try
      while not Query.Eof do
      begin
        Result.Add(Query.FieldByName('idpessoa').AsString);
        Query.Next;
      end;

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

function TDAOPessoa.ListarIds(Campo: string; Value: Variant): TStringList;
begin
  Result := TStringList.Create;

  Query := GeraQuery('SELECT idpessoa FROM pessoa;');

  try
    Query.Close;
    Query.Open;
    Query.First;
    try
      while not Query.Eof do
      begin
        Result.Add(Query.FieldByName('idpessoa').AsString);
        Query.Next;
      end;

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

end.

