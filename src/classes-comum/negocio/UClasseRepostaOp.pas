unit UClasseRepostaOp;

{
  Classe de encapsulamento de resposta, pra operações de diversas de uso...
}

interface

uses
  SysUtils;

type
  IReposta = interface
    ['{A233A50B-F971-4F43-8B70-A44ADAD88E48}']
  end;

  TOperacao = (opNI, opNovo, OpAlteracao, opExclusao, opConsulta, opErro);

  TResposta = class(TInterfacedObject, IReposta)
  private
    FMsg: string;
    FOperacao: TOperacao;
    FObj: TObject;
    FHorario: TDateTime;

  public
    property Msg: string read FMsg write FMsg;
    property Obj: TObject read FObj write FObj;
    property Operacao: TOperacao read FOperacao write FOperacao;
    property Horario: TDateTime read FHorario write FHorario;

    constructor Create;

  end;

implementation

{ TResposta }

constructor TResposta.Create;
begin
  FOperacao := opNI;
  FMsg := '';
  FObj := nil;
  FHorario := Now;

end;

end.

