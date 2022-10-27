unit UClasse.EnderecoIntegracao;

interface

uses
  UICadastro, System.DateUtils, System.SysUtils, System.Classes, System.JSON;

{

-- EnderecoIntegracao Integracao
create table EnderecoIntegracao_integracao (
	idEndereco bigint not null,
	dsuf varchar(50) null,
	nmcidade varchar(100) null,
	nmbairro varchar(50) null,
	nmlogradouro varchar(100) null,
	dscomplemento varchar(100) null,
	constraint EnderecoIntegracaointegracao_pk primary key (idEnderecoIntegracao),
	constraint EnderecoIntegracaointegracao_fk_EnderecoIntegracao foreign key (idEnderecoIntegracao) references EnderecoIntegracao (idEnderecoIntegracao) on delete cascade
);
}

type
  TEnderecoIntegracao = class(TInterfacedObject, iCadastro)
  private
    Fnmcidade: string;
    Fnmlogradouro: string;
    FidEndereco: Integer;
    Fnmbairro: string;
    Fdsuf: string;
    Fdscomplemento: string;

  protected
  public
    property idEndereco: Integer read FidEndereco write FidEndereco;

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

{ TEnderecoIntegracao }

constructor TEnderecoIntegracao.Create;
begin
  inherited;

end;

destructor TEnderecoIntegracao.Destroy;
begin

  inherited;
end;

end.

