unit UClasse.Endereco;

interface

uses
  UICadastro, System.DateUtils, System.SysUtils, System.Classes, System.JSON;

{
-- Endereco da Pessoa
create table endereco (
	idendereco bigserial not null,
	idpessoa int8 not null,
	dscep varchar(15) null,
	constraint endereco_pk primary key (idendereco),
	constraint endereco_fk_pessoa foreign key (idpessoa) references pessoa (idpessoa) on delete cascade
);

-- Endereco Integracao
create table endereco_integracao (
	idendereco bigint not null,
	dsuf varchar(50) null,
	nmcidade varchar(100) null,
	nmbairro varchar(50) null,
	nmlogradouro varchar(100) null,
	dscomplemento varchar(100) null,
	constraint enderecointegracao_pk primary key (idendereco),
	constraint enderecointegracao_fk_endereco foreign key (idendereco) references endereco (idendereco) on delete cascade
);
}

type
  TEndereco = class(TInterfacedObject, iCadastro)
  private
    Fidendereco: Integer;
    Fcep: string;
    Fdsuf: string;
    Fnmcidade: string;
    Fnmlogradouro: string;
    Fnmbairro: string;
    Fdscomplemento: string;
    Fidpessoa: Integer;
  protected
  public
    property idendereco: Integer read Fidendereco write Fidendereco;
    property idpessoa: Integer read Fidpessoa write Fidpessoa;
    property cep: string read Fcep write Fcep;

    property dsuf: string read Fdsuf write Fdsuf;
    property nmcidade: string read Fnmcidade write Fnmcidade;
    property nmbairro: string read Fnmbairro write Fnmbairro;
    property nmlogradouro: string read Fnmlogradouro write Fnmlogradouro;
    property dscomplemento: string read Fdscomplemento write Fdscomplemento;

    constructor Create;
    destructor Destroy; override;

  published
  end;

implementation

{ TEndereco }

constructor TEndereco.Create;
begin
  inherited;

end;

destructor TEndereco.Destroy;
begin

  inherited;
end;

end.

