unit UFrmMenuCliente;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.TabControl, FMX.Controls.Presentation, FMX.StdCtrls;

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
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnEfetuarCadastroClick(Sender: TObject);
  private
    { Private declarations }
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

procedure TFrmMenuCliente.FormCreate(Sender: TObject);
begin
  TDmControle.CreateDm;
end;

procedure TFrmMenuCliente.FormDestroy(Sender: TObject);
begin
  if Assigned(DmControle) then
    DmControle.Free;

end;

end.
