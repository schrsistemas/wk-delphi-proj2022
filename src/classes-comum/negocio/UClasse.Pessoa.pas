unit UClasse.Pessoa;

interface

uses
  UICadastro, System.DateUtils, System.SysUtils, System.Classes, System.JSON,
  UClasse.Endereco, UClasse.EnderecoIntegracao, Generics.Collections, Rest.Json;

{
-- Pessoa
create table pessoa
(
	idpessoa bigserial not null,
	flnatureza int2 not null,
	dsdocumento varchar(20) not null,
	nmprimeiro varchar(100) not null,
	nmsegundo varchar(100) not null,
	dtregistro date null,
	constraint pessoa_pk primary key (idpessoa)
);
}

type
  TNatureza = (natCPF, natCNPJ, natEstrangeiro);

  TPessoa = class(TInterfacedObject, iCadastro)
  private
    Fidpessoa: Integer;
    Fendereco: TEndereco;
    Fnmprimeiro: string;
    Fdtregistro: TDateTime;
    Fnmsegundo: string;
    Fdsdocumento: string;
    Fflnatureza: TNatureza;
    FenderecoIntegracao: TEnderecoIntegracao;
  protected
  public
    property idpessoa: Integer read Fidpessoa write Fidpessoa;
    property flnatureza: TNatureza read Fflnatureza write Fflnatureza;
    property dsdocumento: string read Fdsdocumento write Fdsdocumento;
    property nmprimeiro: string read Fnmprimeiro write Fnmprimeiro;
    property nmsegundo: string read Fnmsegundo write Fnmsegundo;
    property dtregistro: TDateTime read Fdtregistro write Fdtregistro;

    property endereco: TEndereco read Fendereco write Fendereco;
    property enderecoIntegracao: TEnderecoIntegracao read FenderecoIntegracao write FenderecoIntegracao;

    class function FromJsonString(AJsonString: string): TPessoa; static;
    function ToJsonString: string;

    constructor Create;
    destructor Destroy; override;

  published
  end;

implementation

{ TPessoa }

constructor TPessoa.Create;
begin
  inherited;

  Fdtregistro := Now;
  endereco := TEndereco.Create;
  enderecoIntegracao := TEnderecoIntegracao.Create;

end;

destructor TPessoa.Destroy;
begin
  if Assigned(endereco) then
    endereco.Free;
  if Assigned(enderecoIntegracao) then
    enderecoIntegracao.Free;

  inherited;
end;

function TPessoa.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TPessoa.FromJsonString(AJsonString: string): TPessoa;
begin
  result := TJson.JsonToObject<TPessoa>(AJsonString)
end;

end.

