unit UDmSC;

interface

uses
  System.SysUtils, System.Classes, System.JSON, Rest.Json, Rest.Types,
  UThreadMonitorEndereco;

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

{$R *.dfm}

{ TDmSC }

class function TDmSC.CreateDm: Boolean;
begin
  if not Assigned(DmSC) then
  begin
    DmSC := TDmSC.Create(nil);
  end;

end;

function TDmSC.IniciarMonitorTarefas: iServerRest;
begin
  FthreadMonitorEndereco := TThreadMonitorEndereco.Create(True);

  FthreadMonitorEndereco.Start;
end;

function TDmSC.IniciarServidor: iServerRest;
begin

end;

function TDmSC.PararMonitorTarefas: iServerRest;
begin
  if Assigned(FthreadMonitorEndereco) then
    FthreadMonitorEndereco.Terminate;

end;

function TDmSC.PararServidor: iServerRest;
begin

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
  Result := 'Status Servidor: ???';
end;

end.

