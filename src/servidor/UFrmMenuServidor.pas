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
  REST.Authenticator.Simple;

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
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    SimpleAuthenticator1: TSimpleAuthenticator;
    procedure FormShow(Sender: TObject);
    procedure SBConsultarCEPClick(Sender: TObject);
  private
    { Private declarations }
    procedure InitComponents;
  public
    { Public declarations }
    procedure AddLog(texto: string); overload;
    procedure AddLog(e: Exception); overload;
  end;

var
  FrmMenuServidor: TFrmMenuServidor;

implementation

uses
  UDmSC, UDmBase;

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

procedure TFrmMenuServidor.FormShow(Sender: TObject);
begin
  InitComponents;
end;

procedure TFrmMenuServidor.InitComponents;
begin
  try
  {$REGION 'Rest Server'}
    TDmSC.CreateDm;
    edtPorta.Text := PORTA_REST_SERVER;
  {$ENDREGION}

  {$REGION 'Acesso DB'}
    LblStatusDB.Text := '???';
    if TDmBase.CreateDm then
      LblStatusDB.Text := 'Status DB = Conectado!';
  {$ENDREGION}
  except
    on e: Exception do
      AddLog(e);
  end;

end;

procedure TFrmMenuServidor.SBConsultarCEPClick(Sender: TObject);
begin
  var classeCEP: TClasseCEP := TConsultaCEP.Instance.Consultar(edtCEP.Text);

  mmoDadosCEP.Text := classeCEP.ToString;

end;

end.

