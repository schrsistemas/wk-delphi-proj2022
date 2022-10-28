unit UDmSC;

interface

uses
  System.SysUtils, System.Classes, System.JSON, Rest.Json, Rest.Types,
  UThreadMonitorEndereco, Datasnap.DSCommonServer, Datasnap.DSServer,
  IPPeerServer, Datasnap.DSTCPServerTransport, Datasnap.DSAuth,
  Data.Bind.Components, Data.Bind.ObjectScope, REST.Client, Data.FMTBcd,
  DataSnap.DBClient, FireDAC.Phys.TDBXDef, FireDAC.Stan.Intf, FireDAC.Phys,
  FireDAC.Phys.TDBXBase, FireDAC.Phys.TDBX, Data.Bind.DBScope,
  Data.Bind.DBXScope, UClasseServidor, UClasseServidor.Pessoa;

type
  iServerRest = interface
    ['{EB6E1072-15CA-47FD-A6D2-33A8D2F4B208}']
  {$REGION 'Controle Servidor Rest'}
    function IniciarServidor: iServerRest;
    function PararServidor: iServerRest;
    function StatusServidor: string;
  {$ENDREGION}

  {$REGION 'Monitor de Tarefas'}
    function IniciarMonitorTarefas: iServerRest;
    function PararMonitorTarefas: iServerRest;
    function StatusMonitorTarefas: string;
  {$ENDREGION}
  end;

  TDmSC = class(TDataModule, iServerRest)
    DSServer: TDSServer;
    DSTCPServerTransport: TDSTCPServerTransport;
    DSServerClass: TDSServerClass;
    DSServerClassPessoa: TDSServerClass;
    procedure DSAuthenticationManagerUserAuthenticate(Sender: TObject; const Protocol, Context, User, Password: string; var valid: Boolean; UserRoles: TStrings);
    procedure DSAuthenticationManagerUserAuthorize(Sender: TObject; AuthorizeEventObject: TDSAuthorizeEventObject; var valid: Boolean);
    procedure DSServerClassGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
    procedure DSServerClassPessoaGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
  private
    FthreadMonitorEndereco: TThreadMonitorEndereco;
    { Private declarations }
  public
    { Public declarations }
    property threadMonitorEndereco: TThreadMonitorEndereco read FthreadMonitorEndereco write FthreadMonitorEndereco;

    class function CreateDm: Boolean;

    function IniciarServidor: iServerRest;
    function PararServidor: iServerRest;
    function StatusServidor: string;

    function IniciarMonitorTarefas: iServerRest;
    function PararMonitorTarefas: iServerRest;
    function StatusMonitorTarefas: string;

  end;

var
  DmSC: TDmSC;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

uses
  USistema;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TDmSC }

class function TDmSC.CreateDm: Boolean;
begin
  if not Assigned(DmSC) then
  begin
    DmSC := TDmSC.Create(nil);
  end;

end;

procedure TDmSC.DSAuthenticationManagerUserAuthenticate(Sender: TObject; const Protocol, Context, User, Password: string; var valid: Boolean; UserRoles: TStrings);
begin
  valid := True;
end;

procedure TDmSC.DSAuthenticationManagerUserAuthorize(Sender: TObject; AuthorizeEventObject: TDSAuthorizeEventObject; var valid: Boolean);
begin
  valid := True;
end;

procedure TDmSC.DSServerClassGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := TClasseServidor;
end;

procedure TDmSC.DSServerClassPessoaGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := TClasseServidorPessoa;
end;

function TDmSC.IniciarMonitorTarefas: iServerRest;
begin
  FthreadMonitorEndereco := TThreadMonitorEndereco.Create(True);

  FthreadMonitorEndereco.Start;
end;

function TDmSC.IniciarServidor: iServerRest;
begin
  DSTCPServerTransport.Port := Sistema.CfgAppServidor.Porta;

  DSServer.Start;

end;

function TDmSC.PararMonitorTarefas: iServerRest;
begin
  if Assigned(FthreadMonitorEndereco) then
    FthreadMonitorEndereco.Terminate;

end;

function TDmSC.PararServidor: iServerRest;
begin
  DSServer.Stop;

end;

function TDmSC.StatusMonitorTarefas: string;
begin
  if Assigned(FthreadMonitorEndereco) then
  begin
    if FthreadMonitorEndereco.IsRunning then
      Result := 'Monitor de Tarefas: Ok!'
    else
      Result := 'Monitor de Tarefas: ???';

  end;

end;

function TDmSC.StatusServidor: string;
begin
  if DSServer.Started then
    Result := 'Status Servidor: OK!'
  else
    Result := 'Status Servidor: ???';

end;

end.

