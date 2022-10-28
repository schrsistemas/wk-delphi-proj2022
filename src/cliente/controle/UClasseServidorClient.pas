//
// Created by the DataSnap proxy generator.
// 28/10/2022 17:31:22
//

unit UClasseServidorClient;

interface

uses
  System.JSON, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON,
  Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr,
  Data.DBXDBReaders, Data.DBXCDSReaders, Data.DBXJSONReflect;

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

end.

