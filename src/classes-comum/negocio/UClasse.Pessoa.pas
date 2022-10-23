unit UClasse.Pessoa;

interface

uses
  UICadastro, System.DateUtils, System.SysUtils, System.Classes, System.JSON,
  UClasse.Endereco;

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
  TPessoa = class(TInterfacedObject, iCadastro)
  private
    Fidpessoa: Integer;
    Fendereco: TEndereco;
    Fnmprimeiro: string;
    Fdtregistro: TDateTime;
    Fnmsegundo: string;
    Fdsdocumento: string;
    Fflnatureza: Integer;
  protected
  public
    property idpessoa: Integer read Fidpessoa write Fidpessoa;
    property flnatureza: Integer read Fflnatureza write Fflnatureza;
    property dsdocumento: string read Fdsdocumento write Fdsdocumento;
    property nmprimeiro: string read Fnmprimeiro write Fnmprimeiro;
    property nmsegundo: string read Fnmsegundo write Fnmsegundo;
    property dtregistro: TDateTime read Fdtregistro write Fdtregistro;

    property endereco: TEndereco read Fendereco write Fendereco;

    constructor Create;
    destructor Destroy; override;

  published
  end;

implementation

{ TPessoa }

constructor TPessoa.Create;
begin
  inherited;

end;

destructor TPessoa.Destroy;
begin

  inherited;
end;

end.

