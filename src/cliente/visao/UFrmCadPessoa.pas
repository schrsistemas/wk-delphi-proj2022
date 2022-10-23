unit UFrmCadPessoa;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  UClasse.Endereco, UClasse.Pessoa;

type
  TFrmCadPessoa = class(TForm)
    lytContainer: TLayout;
  private
    { Private declarations }
  public
    { Public declarations }
    class function ShowFrm(value: Integer): Boolean;
    function SetValues: Boolean;
    function GetValues: Boolean;
  end;

var
  FrmCadPessoa: TFrmCadPessoa;

implementation

uses
  UConsultaCEP;

{$R *.fmx}

{ TFrmCadPessoa }

function TFrmCadPessoa.GetValues: Boolean;
begin

end;

function TFrmCadPessoa.SetValues: Boolean;
begin

end;

class function TFrmCadPessoa.ShowFrm(value: Integer): Boolean;
begin
  FrmCadPessoa := TFrmCadPessoa.Create(nil);
  try
    FrmCadPessoa.ShowModal;
  finally
    FrmCadPessoa.Free;
  end;
end;

end.

