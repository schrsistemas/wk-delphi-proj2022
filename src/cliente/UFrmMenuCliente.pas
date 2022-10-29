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
    dlgSave: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SBTestarClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure btnImportarDadosClick(Sender: TObject);
    procedure tbtmCadastroClick(Sender: TObject);
    procedure tbtmConsultaClick(Sender: TObject);
    procedure tbtmExportaClick(Sender: TObject);
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
  UDmControle, UFrmCadPessoa, UFrmConsPessoa;

{$R *.fmx}

procedure TFrmMenuCliente.btnImportarDadosClick(Sender: TObject);
begin
  dlgOpen.InitialDir := ExtractFilePath(ParamStr(0));
  if dlgOpen.Execute then
  begin
    try
      TServPessoa.ImportarLista(dlgOpen.FileName);
    except
      on E: Exception do
        ShowMessage(E.Message);
    end;
  end;
end;

procedure TFrmMenuCliente.FormCreate(Sender: TObject);
begin
  InitComponents;
end;

procedure TFrmMenuCliente.FormDestroy(Sender: TObject);
begin
  try
    if Assigned(DmControle) then
      DmControle.Free;
  except

  end;

  try
    if Assigned(Sistema) then
      Sistema.Free;
  except

  end;

end;

procedure TFrmMenuCliente.InitComponents;
begin
  TDmControle.CreateDm;

  tbcContainer.TabIndex := 0;

  Sistema := TSistema.Create;
  Sistema.Init;

  edtServidor.Text := Sistema.CfgAppCliente.Servidor;
  edtPorta.Text := Sistema.CfgAppCliente.Porta.ToString;

  TThread.CreateAnonymousThread(
    procedure
    begin
      TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
          try
            if DmControle.ConectarServidor then
            begin
              lblInfo.Text := 'Conexão com o servidor: Ok!';
            end
            else
            begin
              lblInfo.Text := 'Conexão com o servidor: ??? Falha ???';
            end;
          except
            on E: Exception do
              lblInfo.Text := 'Conexão com o servidor: ??? Falha ??? ' + E.Message;
          end;
        end);

    end).start();

end;

procedure TFrmMenuCliente.SBTestarClick(Sender: TObject);
begin
  ShowMessage(DmControle.Test);

end;

procedure TFrmMenuCliente.SpeedButton1Click(Sender: TObject);
begin
  if Sistema.GravaConfigCfgCliente(edtServidor.Text, StrToIntDef(edtPorta.Text, 0)) then
    ShowMessage('Configuração gravado com sucesso!');

end;

procedure TFrmMenuCliente.tbtmCadastroClick(Sender: TObject);
begin
  TFrmCadPessoa.ShowFrm(0);
end;

procedure TFrmMenuCliente.tbtmConsultaClick(Sender: TObject);
begin
  TFrmConsPessoa.ShowFrm;
end;

procedure TFrmMenuCliente.tbtmExportaClick(Sender: TObject);
begin
  dlgSave.InitialDir := ExtractFilePath(ParamStr(0));
  if dlgSave.Execute then
  begin
    try
      TServPessoa.ExportarLista(dlgSave.FileName);
    except
      on E: Exception do
        ShowMessage(E.Message);
    end;
  end;
end;

end.

