unit UDao.ClassePessoa;

{
  Classe de persist�ncia da Tabela de Endere�o;

}

interface

uses
  UDAO, FireDAC.Comp.Client, UClasse.Pessoa, Generics.Collections, Rest.Json,
  UClasseRepostaOp, System.SysUtils;

type
  IDAOPessoa = interface
    ['{40955836-0DFA-42EE-BD1C-9BAAF2D8F5BD}']
  end;

  TDAOPessoa = class(TDAO, IDAOPessoa)
  private
  public
    function Get(aID: Integer): TResposta;
    function Gravar(aObj: TObject): TResposta;
    function Atualizar(aObj: TObject): TResposta;
    function Listar(): TObjectList<TObject>; overload;
    function Listar(Campo: string; Value: Variant): TObjectList<TObject>; overload;
    function Deletar(aID: Integer): Boolean;
  end;

implementation

{ TDAOPessoa }

function TDAOPessoa.Atualizar(aObj: TObject): TResposta;
begin

end;

function TDAOPessoa.Deletar(aID: Integer): Boolean;
begin

end;

function TDAOPessoa.Get(aID: Integer): TResposta;
begin

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

end;

function TDAOPessoa.Listar(Campo: string; Value: Variant): TObjectList<TObject>;
begin

end;

end.

