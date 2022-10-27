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
  REST.Authenticator.Simple, FMX.Memo.Types;

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
    procedure FormShow(Sender: TObject);
    procedure SBConsultarCEPClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SBStartClick(Sender: TObject);
    procedure SBStopClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tmrMonitoraServidorTimer(Sender: TObject);
    procedure SBGeraRegistroDBClick(Sender: TObject);
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
  UDmSC, UDmBase, UControle.ClassePessoa, UClasse.Pessoa;

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

procedure TFrmMenuServidor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DmSC.PararServidor;
  DmSC.PararMonitorTarefas;
end;

procedure TFrmMenuServidor.FormDestroy(Sender: TObject);
begin
  if Assigned(DmSC) then
    DmSC.Free;

  if Assigned(DmBase) then
    DmBase.Free;

end;

procedure TFrmMenuServidor.FormShow(Sender: TObject);
begin
  InitComponents;
end;

procedure TFrmMenuServidor.InitComponents;
begin
  try
  {$REGION 'Rest Server'}
    TDmSC.CreateDm;
    edtPorta.Text := IntToStr(PORTA_REST_SERVER);
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

  cPessoa.Gravar(auxPessoa);

  cPessoa.Get(1);

end;

procedure TFrmMenuServidor.SBStartClick(Sender: TObject);
begin
  DmSC.IniciarServidor;

end;

procedure TFrmMenuServidor.SBStopClick(Sender: TObject);
begin
  DmSC.PararServidor;
end;

procedure TFrmMenuServidor.SetDisplayStatus;
begin
  lblMonitorTarefas.Text := DmSC.StatusMonitorTarefas;

  lblServidorRest.Text := DmSC.StatusServidor;

end;

procedure TFrmMenuServidor.tmrMonitoraServidorTimer(Sender: TObject);
begin
  SetDisplayStatus;

end;

end.

