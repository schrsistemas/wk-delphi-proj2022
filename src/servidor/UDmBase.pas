unit UDmBase;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Phys,
  FireDAC.Comp.UI, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Phys.PG, FireDAC.Phys.MySQL, UClasseCfgDB, UControle.ClasseCfgDB,
  UConstantes, FireDAC.Comp.Script, FireDAC.Moni.Base, FireDAC.Moni.RemoteClient,
  FireDAC.Phys.PGDef, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys.MySQLDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.VCLUI.Login, FireDAC.VCLUI.Script, FireDAC.VCLUI.Error,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.VCLUI.Wait;

type
  TDmBase = class(TDataModule)
    FDPhysPgDriverLink: TFDPhysPgDriverLink;
    Conexao: TFDConnection;
    FDTransaction: TFDTransaction;
    FDTransactionUP: TFDTransaction;
    Query: TFDQuery;
    FDGUIxLoginDialog: TFDGUIxLoginDialog;
    FDGUIxScriptDialog: TFDGUIxScriptDialog;
    FDGUIxErrorDialog: TFDGUIxErrorDialog;
    FDPhysMySQLDriverLink: TFDPhysMySQLDriverLink;
    FDScript: TFDScript;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDMoniRemoteClientLink: TFDMoniRemoteClientLink;
  private
    { Private declarations }
    procedure FDScriptBeforeExecute(Sender: TObject);
    procedure FDScriptAfterExecute(Sender: TObject);
    procedure QueryAfterExecute(DataSet: TFDDataSet);
    procedure QueryBeforeOpen(DataSet: TDataSet);
    procedure QueryBeforeExecute(DataSet: TFDDataSet);
    procedure QueryAfterPost(DataSet: TDataSet);
    procedure QueryAfterDelete(DataSet: TDataSet);
    procedure Commit;
    procedure Rollback;
    procedure StartTransaction;
  public
    { Public declarations }
    class function CreateDm: Boolean;
    function Conectar(CfgDB: TClasseCfgDB): Boolean;
    function DesConectar: Boolean;
    function TestarConexao(CfgDB: TClasseCfgDB): Boolean;
    procedure ConfigDm(dm: TDataModule);
  end;

var
  DmBase: TDmBase;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TDmBase }

procedure TDmBase.Commit;
begin
  if Conexao.InTransaction then
    Conexao.Commit;
end;

function TDmBase.Conectar(CfgDB: TClasseCfgDB): Boolean;
begin
  Result := False;

  Conexao.LoginPrompt := False;
  Conexao.DriverName := CfgDB.DriverName;

  Conexao.Params.Clear;

  Conexao.Params.Add('DriverID=' + CfgDB.DriverName);
  Conexao.Params.Add('PORT=' + IntToStr(CfgDB.Porta));
  Conexao.Params.Add('Server=' + CfgDB.Servidor);
  Conexao.Params.Add('User_Name=' + CfgDB.Usuario);
  Conexao.Params.Add('Password=' + CfgDB.Senha);
  Conexao.Params.Add('Database=' + CfgDB.Banco);

  Conexao.Params.Add('CharacterSet=utf8');

  case CfgDB.SGBD of
    sgdbMySQL:
      begin
        FDPhysMySQLDriverLink.Release;
        FDPhysMySQLDriverLink.VendorLib := ExtractFilePath(ParamStr(0)) + 'libmysql.dll';
        Conexao.Params.Add('');

      end;
    sgdbPostgreSQL:
      begin
        FDPhysPgDriverLink.Release;
        FDPhysPgDriverLink.VendorLib := ExtractFilePath(ParamStr(0)) + 'libpq.dll';

        Conexao.Params.Add('MetaDefSchema=MySchema');
        Conexao.Params.Add('ExtendedMetadata=True');

      end;
  end;

  try
    Conexao.Connected := True;
    Result := Conexao.Connected;
  except
    on E: Exception do
      raise Exception.Create('Erro ao conectar a Base de Dados' + #13#10 + E.Message);
  end;

end;

procedure TDmBase.ConfigDm(dm: TDataModule);
begin
  var I: Integer := 0;
  for I := 0 to dm.ComponentCount - 1 do
  begin
    if dm.Components[I] is TFDQuery then
    begin
      TFDQuery(dm.Components[I]).Connection := Conexao;
      TFDQuery(dm.Components[I]).Transaction := FDTransaction;
      TFDQuery(dm.Components[I]).UpdateTransaction := FDTransactionUP;

      TFDQuery(dm.Components[I]).BeforeOpen := QueryBeforeOpen;
      TFDQuery(dm.Components[I]).BeforeExecute := QueryBeforeExecute;
      TFDQuery(dm.Components[I]).AfterExecute := QueryAfterExecute;
      TFDQuery(dm.Components[I]).AfterPost := QueryAfterPost;
      TFDQuery(dm.Components[I]).AfterDelete := QueryAfterDelete;
    end
    else if dm.Components[I] is TFDScript then
    begin
      TFDScript(dm.Components[I]).Connection := Conexao;
      TFDScript(dm.Components[I]).Transaction := FDTransaction;

      TFDScript(dm.Components[I]).BeforeExecute := FDScriptBeforeExecute;
      TFDScript(dm.Components[I]).AfterExecute := FDScriptAfterExecute;
    end;
  end;
end;

class function TDmBase.CreateDm: Boolean;
begin
  if not Assigned(DmBase) then
  begin
    DmBase := TDmBase.Create(nil);

    Result := DmBase.Conectar(TControleClasseCfgDB.CarregaIniParaClasse);

  end;

end;

function TDmBase.DesConectar: Boolean;
begin
  Rollback;
  Conexao.Connected := False;
end;

procedure TDmBase.FDScriptAfterExecute(Sender: TObject);
begin
  Commit;
end;

procedure TDmBase.FDScriptBeforeExecute(Sender: TObject);
begin
  StartTransaction;
end;

procedure TDmBase.QueryAfterDelete(DataSet: TDataSet);
begin
  Commit;
end;

procedure TDmBase.QueryAfterExecute(DataSet: TFDDataSet);
begin
  Commit;
end;

procedure TDmBase.QueryAfterPost(DataSet: TDataSet);
begin
  Commit;
end;

procedure TDmBase.QueryBeforeExecute(DataSet: TFDDataSet);
begin
  StartTransaction;
end;

procedure TDmBase.QueryBeforeOpen(DataSet: TDataSet);
begin
  StartTransaction;
end;

procedure TDmBase.Rollback;
begin
  if Conexao.InTransaction then
    Conexao.Rollback;
end;

procedure TDmBase.StartTransaction;
begin
  if not Conexao.InTransaction then
    Conexao.StartTransaction;
end;

function TDmBase.TestarConexao(CfgDB: TClasseCfgDB): Boolean;
begin
  DesConectar;
  Result := Conectar(CfgDB);
end;

end.

