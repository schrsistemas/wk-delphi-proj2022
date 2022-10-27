unit UFrmMenuCliente;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.TabControl, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, USistema,
  UControle.Service.Pessoa, FMX.ScrollBox, FMX.Memo;

type
  TFrmMenuCliente = class(TForm)
    LytContainer: TLayout;
    tbcContainer: TTabControl;
    tbtmMenu: TTabItem;
    tbtmConsulta: TTabItem;
    tbtmCadastro: TTabItem;
    tbtmImporta: TTabItem;
    tbtmExporta: TTabItem;
    lblInfo: TLabel;
    btnImportarDados: TSpeedButton;
    btnExportarDados: TSpeedButton;
    btnEfetuarCadastro: TSpeedButton;
    tbtmConfig: TTabItem;
    grpConfigAcesso: TGroupBox;
    LblURL: TLabel;
    SBTestar: TSpeedButton;
    SpeedButton1: TSpeedButton;
    edtServidor: TEdit;
    Label1: TLabel;
    edtPorta: TEdit;
    dlgOpen: TOpenDialog;
    mmoExemploImp: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnEfetuarCadastroClick(Sender: TObject);
    procedure SBTestarClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure btnImportarDadosClick(Sender: TObject);
  private
    { Private declarations }
    procedure InitComponents;
  public
    { Public declarations }
  end;

var
  FrmMenuCliente: TFrmMenuCliente;

implementation

uses
  UDmControle, UFrmCadPessoa;

{$R *.fmx}

procedure TFrmMenuCliente.btnEfetuarCadastroClick(Sender: TObject);
begin
  TFrmCadPessoa.ShowFrm(0);

end;

procedure TFrmMenuCliente.btnImportarDadosClick(Sender: TObject);
begin
  dlgOpen.InitialDir := ExtractFilePath(ParamStr(0));
  if dlgOpen.Execute then
  begin
    TServPessoa.ImportarListaPessoas(dlgOpen.FileName);
  end;

end;

procedure TFrmMenuCliente.FormCreate(Sender: TObject);
begin
  InitComponents;
end;

procedure TFrmMenuCliente.FormDestroy(Sender: TObject);
begin
  if Assigned(DmControle) then
    DmControle.Free;

  if Assigned(Sistema) then
    Sistema.Free;

end;

procedure TFrmMenuCliente.InitComponents;
begin
  TDmControle.CreateDm;

  tbcContainer.TabIndex := 0;

  Sistema := TSistema.Create;
  Sistema.Init;

  edtServidor.Text := Sistema.CfgAppCliente.Servidor;
  edtPorta.Text := Sistema.CfgAppCliente.Porta.ToString;

end;

procedure TFrmMenuCliente.SBTestarClick(Sender: TObject);
begin
  raise Exception.Create('Não implementado!');

end;

procedure TFrmMenuCliente.SpeedButton1Click(Sender: TObject);
begin
  if Sistema.GravaConfigCfgCliente(edtServidor.Text, StrToIntDef(edtPorta.Text, 0)) then
    ShowMessage('Configuração gravado com sucesso!');

end;

end.

