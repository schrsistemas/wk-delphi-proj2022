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

}

type
  TEndereco = class(TInterfacedObject, iCadastro)
  private
    Fidendereco: Integer;
    Fdscep: string;
    Fidpessoa: Integer;

  protected
  public
    property idendereco: Integer read Fidendereco write Fidendereco;
    property idpessoa: Integer read Fidpessoa write Fidpessoa;
    property dscep: string read Fdscep write Fdscep;

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

