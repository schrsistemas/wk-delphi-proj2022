//
// Created by the DataSnap proxy generator.
// 31/10/2022 09:04:53
//

unit UClasseServidorClient;

interface

uses System.JSON, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, UClasse.Pessoa, UClasseRepostaOp, System.Generics.Collections, Data.DBXJSONReflect;

type
  TClasseServidorClient = class(TDSAdminClient)
  private
    FtestCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function test: string;
  end;

  TClasseServidorPessoaClient = class(TDSAdminClient)
  private
    FGetCommand: TDBXCommand;
    FGravarCommand: TDBXCommand;
    FAtualizarCommand: TDBXCommand;
    FDeletarCommand: TDBXCommand;
    FFiltrarCommand: TDBXCommand;
    FListarCommand: TDBXCommand;
    FImportarCommand: TDBXCommand;
    FImportarListaCommand: TDBXCommand;
    FExportarCommand: TDBXCommand;
    FExportarListaCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function Get(aID: Integer): TPessoa;
    function Gravar(aObj: TPessoa): TResposta;
    function Atualizar(aObj: TPessoa): TResposta;
    function Deletar(aID: Integer): Boolean;
    function Filtrar(Campo: string; Value: string): TObjectList<UClasse.Pessoa.TPessoa>;
    function Listar: TObjectList<UClasse.Pessoa.TPessoa>;
    function Importar(value: TStream): Boolean;
    function ImportarLista(listaCSV: TStringList): Boolean;
    function Exportar: TStream;
    function ExportarLista: TStringList;
  end;

  TClasseServidorGEDClient = class(TDSAdminClient)
  private
    FpUploadArquivoCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function pUploadArquivo(pArquivoJSON: TJSONArray): Boolean;
  end;

implementation

function TClasseServidorClient.test: string;
begin
  if FtestCommand = nil then
  begin
    FtestCommand := FDBXConnection.CreateCommand;
    FtestCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FtestCommand.Text := 'TClasseServidor.test';
    FtestCommand.Prepare;
  end;
  FtestCommand.ExecuteUpdate;
  Result := FtestCommand.Parameters[0].Value.GetWideString;
end;

constructor TClasseServidorClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TClasseServidorClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TClasseServidorClient.Destroy;
begin
  FtestCommand.DisposeOf;
  inherited;
end;

function TClasseServidorPessoaClient.Get(aID: Integer): TPessoa;
begin
  if FGetCommand = nil then
  begin
    FGetCommand := FDBXConnection.CreateCommand;
    FGetCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetCommand.Text := 'TClasseServidorPessoa.Get';
    FGetCommand.Prepare;
  end;
  FGetCommand.Parameters[0].Value.SetInt32(aID);
  FGetCommand.ExecuteUpdate;
  if not FGetCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TPessoa(FUnMarshal.UnMarshal(FGetCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TClasseServidorPessoaClient.Gravar(aObj: TPessoa): TResposta;
begin
  if FGravarCommand = nil then
  begin
    FGravarCommand := FDBXConnection.CreateCommand;
    FGravarCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGravarCommand.Text := 'TClasseServidorPessoa.Gravar';
    FGravarCommand.Prepare;
  end;
  if not Assigned(aObj) then
    FGravarCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FGravarCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FGravarCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(aObj), True);
      if FInstanceOwner then
        aObj.Free
    finally
      FreeAndNil(FMarshal)
    end
  end;
  FGravarCommand.ExecuteUpdate;
  if not FGravarCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGravarCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TResposta(FUnMarshal.UnMarshal(FGravarCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGravarCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TClasseServidorPessoaClient.Atualizar(aObj: TPessoa): TResposta;
begin
  if FAtualizarCommand = nil then
  begin
    FAtualizarCommand := FDBXConnection.CreateCommand;
    FAtualizarCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FAtualizarCommand.Text := 'TClasseServidorPessoa.Atualizar';
    FAtualizarCommand.Prepare;
  end;
  if not Assigned(aObj) then
    FAtualizarCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FAtualizarCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FAtualizarCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(aObj), True);
      if FInstanceOwner then
        aObj.Free
    finally
      FreeAndNil(FMarshal)
    end
  end;
  FAtualizarCommand.ExecuteUpdate;
  if not FAtualizarCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FAtualizarCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TResposta(FUnMarshal.UnMarshal(FAtualizarCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FAtualizarCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TClasseServidorPessoaClient.Deletar(aID: Integer): Boolean;
begin
  if FDeletarCommand = nil then
  begin
    FDeletarCommand := FDBXConnection.CreateCommand;
    FDeletarCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FDeletarCommand.Text := 'TClasseServidorPessoa.Deletar';
    FDeletarCommand.Prepare;
  end;
  FDeletarCommand.Parameters[0].Value.SetInt32(aID);
  FDeletarCommand.ExecuteUpdate;
  Result := FDeletarCommand.Parameters[1].Value.GetBoolean;
end;

function TClasseServidorPessoaClient.Filtrar(Campo: string; Value: string): TObjectList<UClasse.Pessoa.TPessoa>;
begin
  if FFiltrarCommand = nil then
  begin
    FFiltrarCommand := FDBXConnection.CreateCommand;
    FFiltrarCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FFiltrarCommand.Text := 'TClasseServidorPessoa.Filtrar';
    FFiltrarCommand.Prepare;
  end;
  FFiltrarCommand.Parameters[0].Value.SetWideString(Campo);
  FFiltrarCommand.Parameters[1].Value.SetWideString(Value);
  FFiltrarCommand.ExecuteUpdate;
  if not FFiltrarCommand.Parameters[2].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FFiltrarCommand.Parameters[2].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TObjectList<UClasse.Pessoa.TPessoa>(FUnMarshal.UnMarshal(FFiltrarCommand.Parameters[2].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FFiltrarCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TClasseServidorPessoaClient.Listar: TObjectList<UClasse.Pessoa.TPessoa>;
begin
  if FListarCommand = nil then
  begin
    FListarCommand := FDBXConnection.CreateCommand;
    FListarCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FListarCommand.Text := 'TClasseServidorPessoa.Listar';
    FListarCommand.Prepare;
  end;
  FListarCommand.ExecuteUpdate;
  if not FListarCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FListarCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TObjectList<UClasse.Pessoa.TPessoa>(FUnMarshal.UnMarshal(FListarCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FListarCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TClasseServidorPessoaClient.Importar(value: TStream): Boolean;
begin
  if FImportarCommand = nil then
  begin
    FImportarCommand := FDBXConnection.CreateCommand;
    FImportarCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FImportarCommand.Text := 'TClasseServidorPessoa.Importar';
    FImportarCommand.Prepare;
  end;
  FImportarCommand.Parameters[0].Value.SetStream(value, FInstanceOwner);
  FImportarCommand.ExecuteUpdate;
  Result := FImportarCommand.Parameters[1].Value.GetBoolean;
end;

function TClasseServidorPessoaClient.ImportarLista(listaCSV: TStringList): Boolean;
begin
  if FImportarListaCommand = nil then
  begin
    FImportarListaCommand := FDBXConnection.CreateCommand;
    FImportarListaCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FImportarListaCommand.Text := 'TClasseServidorPessoa.ImportarLista';
    FImportarListaCommand.Prepare;
  end;
  if not Assigned(listaCSV) then
    FImportarListaCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FImportarListaCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FImportarListaCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(listaCSV), True);
      if FInstanceOwner then
        listaCSV.Free
    finally
      FreeAndNil(FMarshal)
    end
  end;
  FImportarListaCommand.ExecuteUpdate;
  Result := FImportarListaCommand.Parameters[1].Value.GetBoolean;
end;

function TClasseServidorPessoaClient.Exportar: TStream;
begin
  if FExportarCommand = nil then
  begin
    FExportarCommand := FDBXConnection.CreateCommand;
    FExportarCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FExportarCommand.Text := 'TClasseServidorPessoa.Exportar';
    FExportarCommand.Prepare;
  end;
  FExportarCommand.ExecuteUpdate;
  Result := FExportarCommand.Parameters[0].Value.GetStream(FInstanceOwner);
end;

function TClasseServidorPessoaClient.ExportarLista: TStringList;
begin
  if FExportarListaCommand = nil then
  begin
    FExportarListaCommand := FDBXConnection.CreateCommand;
    FExportarListaCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FExportarListaCommand.Text := 'TClasseServidorPessoa.ExportarLista';
    FExportarListaCommand.Prepare;
  end;
  FExportarListaCommand.ExecuteUpdate;
  if not FExportarListaCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FExportarListaCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TStringList(FUnMarshal.UnMarshal(FExportarListaCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FExportarListaCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

constructor TClasseServidorPessoaClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TClasseServidorPessoaClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TClasseServidorPessoaClient.Destroy;
begin
  FGetCommand.DisposeOf;
  FGravarCommand.DisposeOf;
  FAtualizarCommand.DisposeOf;
  FDeletarCommand.DisposeOf;
  FFiltrarCommand.DisposeOf;
  FListarCommand.DisposeOf;
  FImportarCommand.DisposeOf;
  FImportarListaCommand.DisposeOf;
  FExportarCommand.DisposeOf;
  FExportarListaCommand.DisposeOf;
  inherited;
end;

function TClasseServidorGEDClient.pUploadArquivo(pArquivoJSON: TJSONArray): Boolean;
begin
  if FpUploadArquivoCommand = nil then
  begin
    FpUploadArquivoCommand := FDBXConnection.CreateCommand;
    FpUploadArquivoCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FpUploadArquivoCommand.Text := 'TClasseServidorGED.pUploadArquivo';
    FpUploadArquivoCommand.Prepare;
  end;
  FpUploadArquivoCommand.Parameters[0].Value.SetJSONValue(pArquivoJSON, FInstanceOwner);
  FpUploadArquivoCommand.ExecuteUpdate;
  Result := FpUploadArquivoCommand.Parameters[1].Value.GetBoolean;
end;

constructor TClasseServidorGEDClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TClasseServidorGEDClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TClasseServidorGEDClient.Destroy;
begin
  FpUploadArquivoCommand.DisposeOf;
  inherited;
end;

end.

