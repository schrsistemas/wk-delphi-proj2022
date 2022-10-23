unit UDmControle;

interface

uses
  System.SysUtils, System.Classes, UICadastro, UClasse.Pessoa;

type
  iControle = interface
    ['{E72FC5F7-B3BD-4A54-8374-EA6C8EF93CEC}']
    function Importar: iControle;
    function Exportar: iControle;
    function Cadastrar(value: iCadastro): iControle;
    function Atualizar(value: iCadastro): iControle;
    function Deletar(value: Integer): iControle;
  end;

  TDmControle = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
    class function CreateDm: Boolean;
  end;

var
  DmControle: TDmControle;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TDmControle }

class function TDmControle.CreateDm: Boolean;
begin
  if not Assigned(DmControle) then
    DmControle := TDmControle.Create(nil);

end;

end.

