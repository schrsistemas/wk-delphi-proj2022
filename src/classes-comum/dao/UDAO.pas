unit UDAO;

{
  Classe generica de persistência de Dados em Base - TDAO
}

interface

uses
  UIDAO, FireDAC.Comp.Client, Generics.Collections, Rest.Json, UDmBase,
  UClasseRepostaOp;

type
  TDAO = class(TInterfacedObject, IDAO)
  private
    FQuery: TFDQuery;
    procedure SetQuery(const Value: TFDQuery);

  protected
    property Query: TFDQuery read FQuery write SetQuery;
    function GeraQuery(SQL: string): TFDQuery;
    procedure Commit;
    procedure Rollback;
  public
    function Get(aID: Integer): TResposta;
    function Gravar(aObj: TObject): TResposta;
    function Atualizar(aObj: TObject): TResposta;
    function Listar(): TObjectList<TObject>; overload;
    function Listar(Campo: string; Value: Variant): TObjectList<TObject>; overload;
    function Deletar(aID: Integer): Boolean;

  end;

implementation

{ TDAO }

function TDAO.Atualizar(aObj: TObject): TResposta;
begin

end;

procedure TDAO.Commit;
begin
  DmBase.Commit;
end;

function TDAO.Deletar(aID: Integer): Boolean;
begin

end;

function TDAO.GeraQuery(SQL: string): TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := DmBase.Conexao;
  Result.Transaction := DmBase.FDTransaction;
  Result.UpdateTransaction := DmBase.FDTransactionUP;

  Result.BeforeOpen := DmBase.QueryBeforeOpen;
  Result.BeforeExecute := DmBase.QueryBeforeExecute;
  Result.AfterExecute := DmBase.QueryAfterExecute;
  Result.AfterPost := DmBase.QueryAfterPost;
  Result.AfterDelete := DmBase.QueryAfterDelete;

  Result.SQL.Clear;
  Result.SQL.Add(SQL);

end;

function TDAO.Get(aID: Integer): TResposta;
begin

end;

function TDAO.Gravar(aObj: TObject): TResposta;
begin

end;

function TDAO.Listar: TObjectList<TObject>;
begin

end;

function TDAO.Listar(Campo: string; Value: Variant): TObjectList<TObject>;
begin

end;

procedure TDAO.Rollback;
begin
  DmBase.Rollback;
end;

procedure TDAO.SetQuery(const Value: TFDQuery);
begin
  FQuery := Value;
end;

end.

