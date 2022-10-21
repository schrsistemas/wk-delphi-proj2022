unit UFrmMenuServidor;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.TabControl;

type
  TFrmMenuServidor = class(TForm)
    LytContainer: TLayout;
    tbcMenu: TTabControl;
    tbtmMenu: TTabItem;
    tbtmLog: TTabItem;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMenuServidor: TFrmMenuServidor;

implementation

{$R *.fmx}

end.
