unit UDmControle;

interface

uses
  System.SysUtils, System.Classes, UICadastro, UClasse.Pessoa, Data.DBXDataSnap,
  Data.DBXCommon, IPPeerClient, Data.DB, Data.SqlExpr, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.DS, FireDAC.Phys.DSDef, FireDAC.Phys.TDBXBase,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  UClasseServidorClient;

type
  iControle = interface
    ['{E72FC5F7-B3BD-4A54-8374-EA6C8EF93CEC}']
    function Importar: iControle;
    function Exportar: iControle;
    function Cadastrar(value: iCadastro): iControle;
    function Atualizar(value: iCadastro): iControle;
    function Deletar(value: Integer): iControle;
  end;

  TDmControle = class(TDataModule)
    SQLConnection: TSQLConnection;
  private
    procedure InitComponents;
  public
    class function CreateDm: Boolean;
    function Test: string;
    function ConectarServidor: Boolean;
    function DesConectarServidor: Boolean;

  end;

var
  DmControle: TDmControle;

implementation

uses
  USistema;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TDmControle }

function TDmControle.ConectarServidor: Boolean;
begin
  Result := False;

  try
    SQLConnection.Close;
    SQLConnection.Params.Clear;
    SQLConnection.Params.Add('DriverUnit=Data.DbxDatasnap');
    SQLConnection.Params.Add('HostName=' + Sistema.CfgAppCliente.Servidor);
    SQLConnection.Params.Add('Port=' + IntToStr(Sistema.CfgAppCliente.Porta));
    SQLConnection.Params.Add('CommunicationProtocol=tcp/ip');
    SQLConnection.Params.Add('DatasnapContext=datasnap/');
    SQLConnection.Open;

    Result := SQLConnection.Connected;
  except
    on E: Exception do
    begin
      raise E;
    end;
  end;

end;

class function TDmControle.CreateDm: Boolean;
begin
  if not Assigned(DmControle) then
    DmControle := TDmControle.Create(nil);
end;

function TDmControle.DesConectarServidor: Boolean;
begin
  SQLConnection.Close;
end;

procedure TDmControle.InitComponents;
begin

end;

function TDmControle.Test: string;
begin
  if not SQLConnection.Connected then
    ConectarServidor;
  var cServidorClient: TClasseServidorClient := TClasseServidorClient.Create(SQLConnection.DBXConnection);
  Result := cServidorClient.Test;
end;

end.

