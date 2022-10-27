unit UIDAO;

interface

uses
  Generics.Collections, Rest.Json, UClasseRepostaOp;

type
  IDAO = interface
    ['{D49BC6C5-CE50-433E-93C7-85DFFB971D30}']
    function Get(aID: Integer): TResposta;
    function Gravar(aObj: TObject): TResposta;
    function Atualizar(aObj: TObject): TResposta;
    function Listar(): TObjectList<TObject>; overload;
    function Listar(Campo: string; Value: Variant): TObjectList<TObject>; overload;
    function Deletar(aID: Integer): Boolean;
  end;

implementation

end.

