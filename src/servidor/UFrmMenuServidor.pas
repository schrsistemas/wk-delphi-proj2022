unit UFrmMenuServidor;

{
  Menu de acesso módulo servidor
}

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.TabControl, URestUtil, FMX.StdCtrls, FMX.ScrollBox, FMX.Memo, FMX.Edit,
  FMX.Controls.Presentation, System.DateUtils, UConstantes, UConsultaCEP,
  REST.Types, Data.Bind.Components, Data.Bind.ObjectScope, REST.Client,
  REST.Authenticator.Simple, FMX.Memo.Types, USistema;

type
  TFrmMenuServidor = class(TForm)
    LytContainer: TLayout;
    tbcMenu: TTabControl;
    tbtmMenu: TTabItem;
    tbtmLog: TTabItem;
    tbtmTest: TTabItem;
    grpTestCEP_ViaCEP: TGroupBox;
    edtCEP: TEdit;
    mmoDadosCEP: TMemo;
    SBConsultarCEP: TSpeedButton;
    Lbl1: TLabel;
    grpServidor: TGroupBox;
    LblPorta: TLabel;
    edtPorta: TEdit;
    SBStart: TSpeedButton;
    SBStop: TSpeedButton;
    LblStatusDB: TLabel;
    mmoLog: TMemo;
    tmrMonitoraServidor: TTimer;
    lblMonitorTarefas: TLabel;
    lblServidorRest: TLabel;
    grpTesteDAO: TGroupBox;
    SBGeraRegistroDB: TSpeedButton;
    Button1: TButton;
    procedure FormShow(Sender: TObject);
    procedure SBConsultarCEPClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SBStartClick(Sender: TObject);
    procedure SBStopClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tmrMonitoraServidorTimer(Sender: TObject);
    procedure SBGeraRegistroDBClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    procedure InitComponents;
    procedure SetDisplayStatus;
  public
    { Public declarations }
    procedure AddLog(texto: string); overload;
    procedure AddLog(e: Exception); overload;
  end;

var
  FrmMenuServidor: TFrmMenuServidor;

implementation

uses
  UDmSC, UDmBase, UControle.ClassePessoa, UClasse.Pessoa, UClasseServidor.Pessoa;

{$R *.fmx}

procedure TFrmMenuServidor.AddLog(texto: string);
begin
  mmoLog.Lines.Add(FormatDateTime('dd/mm/yyyy hh:mm:ss', Now) + ' - ' + texto);
end;

procedure TFrmMenuServidor.AddLog(e: Exception);
begin
  AddLog(e.Message);
  if e.StackTrace <> EmptyStr then
    AddLog(e.StackTrace);
end;

procedure TFrmMenuServidor.Button1Click(Sender: TObject);
begin
  var aux := TClasseServidorPessoa.Create(nil);
  aux.Exportar;

end;

procedure TFrmMenuServidor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Sistema.GravaConfigCfgServidor(StrToIntDef(edtPorta.Text, 0));

  DmSC.PararServidor;
  DmSC.PararMonitorTarefas;

end;

procedure TFrmMenuServidor.FormDestroy(Sender: TObject);
begin
  if Assigned(DmSC) then
    DmSC.Free;

  if Assigned(DmBase) then
    DmBase.Free;

  if Assigned(Sistema) then
    Sistema.Free;

end;

procedure TFrmMenuServidor.FormShow(Sender: TObject);
begin
  InitComponents;

  SBStartClick(Sender);

end;

procedure TFrmMenuServidor.InitComponents;
begin
  try
    Sistema := TSistema.Create;
    Sistema.Init;

  {$REGION 'Rest Server'}
    TDmSC.CreateDm;
    edtPorta.Text := Sistema.CfgAppServidor.Porta.ToString;
  {$ENDREGION}

  {$REGION 'Acesso DB'}
    LblStatusDB.Text := '???';
    if TDmBase.CreateDm then
      LblStatusDB.Text := 'Status DB = Conectado!';
  {$ENDREGION}

    DmSC.IniciarMonitorTarefas;

  except
    on e: Exception do
      AddLog(e);
  end;

end;

procedure TFrmMenuServidor.SBConsultarCEPClick(Sender: TObject);
begin
  var classeCEP: TClasseCEP := TConsultaCEP.Instance.Consultar(edtCEP.Text);
  try
    mmoDadosCEP.Text := classeCEP.ToString;
  finally
    classeCEP.Free;
  end;

end;

procedure TFrmMenuServidor.SBGeraRegistroDBClick(Sender: TObject);
begin
  var auxPessoa: TPessoa := TPessoa.Create;
  var cPessoa := TControlePessoa.Create;

  var auxR := cPessoa.Gravar(auxPessoa);

  cPessoa.Get(TPessoa(auxR.Obj).idpessoa);

  cPessoa.Listar;

  cPessoa.Deletar(TPessoa(auxR.Obj).idpessoa);

end;

procedure TFrmMenuServidor.SBStartClick(Sender: TObject);
begin
  TDmSC.CreateDm;
  DmSC.IniciarServidor;
end;

procedure TFrmMenuServidor.SBStopClick(Sender: TObject);
begin
  TDmSC.CreateDm;
  DmSC.PararServidor;
end;

procedure TFrmMenuServidor.SetDisplayStatus;
begin
  if Assigned(DmSC) then
  begin
    lblMonitorTarefas.Text := DmSC.StatusMonitorTarefas;

    lblServidorRest.Text := DmSC.StatusServidor;
  end;

end;

procedure TFrmMenuServidor.tmrMonitoraServidorTimer(Sender: TObject);
begin
  SetDisplayStatus;

end;

end.

