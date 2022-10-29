unit UControle.Service.Pessoa;

interface

uses
  URestUtil, UClasse.Pessoa, UClasse.Endereco, UClasse.EnderecoIntegracao,
  UDmControle, USistema, SysUtils, System.Classes, System.Generics.Collections,
  UClasseRepostaOp;

type
  TServPessoa = class(TObject)
  private
  { private declarations }
  protected
  { protected declarations }
  public
  { public declarations }

    class function Filtrar(Campo: string; Value: string): TObjectList<TPessoa>;
    class function Listar: TObjectList<TPessoa>;

    class function Importar(value: TStream): Boolean;
    class function Exportar: TStream;

    class function BuscarPessoa(aID: Integer): TPessoa;
    class function RegistrarPessoa(aObj: TPessoa): TResposta;
    class function Deletar(aID: Integer): Boolean;

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

class function TServPessoa.Deletar(aID: Integer): Boolean;
begin
  if not DmControle.SQLConnection.Connected then
    DmControle.ConectarServidor;

  try
    var auxServ := TClasseServidorPessoaClient.Create(DmControle.SQLConnection.DBXConnection);
    Result := auxServ.Deletar(aID);
  except
    on E: Exception do
    begin
      DmControle.DesConectarServidor;
      raise E;
    end;
  end;
end;

class function TServPessoa.Exportar: TStream;
begin

end;

class function TServPessoa.Filtrar(Campo, Value: string): TObjectList<TPessoa>;
begin

end;

class function TServPessoa.Importar(value: TStream): Boolean;
begin

end;

class function TServPessoa.ImportarListaPessoas(aArquivo: string): Boolean;
begin

end;

class function TServPessoa.Listar: TObjectList<TPessoa>;
begin
  if not DmControle.SQLConnection.Connected then
    DmControle.ConectarServidor;

  try
    var auxServ := TClasseServidorPessoaClient.Create(DmControle.SQLConnection.DBXConnection);
    Result := auxServ.Listar;
  except
    on E: Exception do
    begin
      DmControle.DesConectarServidor;
      raise E;
    end;
  end;
end;

class function TServPessoa.RegistrarPessoa(aObj: TPessoa): TResposta;
begin
  if not DmControle.SQLConnection.Connected then
    DmControle.ConectarServidor;

  try
    var auxServ := TClasseServidorPessoaClient.Create(DmControle.SQLConnection.DBXConnection);
    Result := auxServ.Gravar(aObj);
  except
    on E: Exception do
    begin
      DmControle.DesConectarServidor;
      raise E;
    end;
  end;
end;

end.

