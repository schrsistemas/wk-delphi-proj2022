unit UFrmMenuCliente;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.TabControl;

type
  TFrmMenuCliente = class(TForm)
    LytContainer: TLayout;
    tbcContainer: TTabControl;
    tbtmMenu: TTabItem;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMenuCliente: TFrmMenuCliente;

implementation

{$R *.fmx}

end.
