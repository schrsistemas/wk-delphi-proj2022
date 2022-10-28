unit UControle.Service.Pessoa;

interface

uses
  URestUtil, UClasse.Pessoa, UClasse.Endereco, UClasse.EnderecoIntegracao,
  UDmControle, USistema, SysUtils, System.Classes;

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

uses
  UClasseServidorClient;

{ TServPessoa }

class function TServPessoa.BuscarPessoa(aID: Integer): TPessoa;
begin
  if not DmControle.SQLConnection.Connected then
    DmControle.ConectarServidor;

  try
    var auxServ := TClasseServidorPessoaClient.Create(DmControle.SQLConnection.DBXConnection);
    Result := auxServ.Get(aID);
  except
    on E: Exception do
    begin
      DmControle.DesConectarServidor;
      raise E;
    end;
  end;

end;

class function TServPessoa.ImportarListaPessoas(aArquivo: string): Boolean;
begin

end;

class function TServPessoa.RegistrarPessoa(aObj: TPessoa): Boolean;
begin
  if not DmControle.SQLConnection.Connected then
    DmControle.ConectarServidor;

  try
    var auxServ := TClasseServidorPessoaClient.Create(DmControle.SQLConnection.DBXConnection);
    auxServ.Gravar(aObj);
  except
    on E: Exception do
    begin
      DmControle.DesConectarServidor;
      raise E;
    end;
  end;
end;

end.

