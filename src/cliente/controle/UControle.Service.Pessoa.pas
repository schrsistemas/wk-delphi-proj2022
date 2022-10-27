unit UControle.Service.Pessoa;

interface

uses
  URestUtil, UClasse.Pessoa, UClasse.Endereco, UClasse.EnderecoIntegracao,
  UDmControle, USistema;

type
  TServPessoa = class(TObject)
  private
  { private declarations }
  protected
  { protected declarations }
  public
  { public declarations }

    class function BuscarPessoa(aID: Integer): TPessoa;
    class function RegistrarPessoa(aObj: TPessoa): Boolean;
    class function ImportarListaPessoas(aArquivo: string): Boolean;

  published
  { published declarations }
  end;

implementation

{ TServPessoa }

class function TServPessoa.BuscarPessoa(aID: Integer): TPessoa;
begin

end;

class function TServPessoa.ImportarListaPessoas(aArquivo: string): Boolean;
begin

end;

class function TServPessoa.RegistrarPessoa(aObj: TPessoa): Boolean;
begin

end;

end.

