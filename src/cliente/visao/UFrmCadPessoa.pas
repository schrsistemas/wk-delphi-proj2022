unit UFrmCadPessoa;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  UClasse.Endereco, UClasse.Pessoa, FMX.Objects, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.Edit, FMX.ComboEdit, FMX.DateTimeCtrls;

type
  TFrmCadPessoa = class(TForm)
    lytContainer: TLayout;
    LytHeader: TLayout;
    LytBody: TLayout;
    Layout2: TLayout;
    RtCancel: TRectangle;
    RtOk: TRectangle;
    SBCancel: TSpeedButton;
    SBOk: TSpeedButton;
    RtTitle: TRectangle;
    LblTitle: TLabel;
    SBClose: TSpeedButton;
    Layout1: TLayout;
    Label1: TLabel;
    Edit1: TEdit;
    Layout3: TLayout;
    Label2: TLabel;
    Edit2: TEdit;
    Layout4: TLayout;
    Label3: TLabel;
    Edit3: TEdit;
    Layout5: TLayout;
    Label4: TLabel;
    Edit4: TEdit;
    Layout6: TLayout;
    Label5: TLabel;
    CmbNatureza: TComboEdit;
    Layout7: TLayout;
    Label6: TLabel;
    edtCEP: TEdit;
    Label7: TLabel;
    EdtDataRegistro: TDateEdit;
    Layout8: TLayout;
    Label8: TLabel;
    edtCidade: TEdit;
    Layout9: TLayout;
    Label9: TLabel;
    edtBairro: TEdit;
    Layout10: TLayout;
    Label10: TLabel;
    edtLogradouro: TEdit;
    edtUF: TEdit;
    Label11: TLabel;
    Layout11: TLayout;
    Label12: TLabel;
    edtComplemento: TEdit;
    SBLocalizaCEP: TSpeedButton;
    procedure SBCloseClick(Sender: TObject);
    procedure SBOkClick(Sender: TObject);
    procedure SBCancelClick(Sender: TObject);
    procedure SBLocalizaCEPClick(Sender: TObject);
  private
    FFrmOk: Boolean;
    FPessoa: TPessoa;
    FId: Integer;

  public
    property FrmOk: Boolean read FFrmOk write FFrmOk;

    property Id: Integer read FId write FId;

    property Pessoa: TPessoa read FPessoa write FPessoa;

    class function ShowFrm(value: Integer): Boolean;
    function SetValues: Boolean;
    function GetValues: Boolean;
    function ValidarCadastro: Boolean;
    procedure LocalizarCEP;
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

function TFrmCadPessoa.ValidarCadastro: Boolean;
begin

  Result := True;
end;

procedure TFrmCadPessoa.LocalizarCEP;
begin

end;

procedure TFrmCadPessoa.SBCancelClick(Sender: TObject);
begin
  FFrmOk := False;
  Close;
end;

procedure TFrmCadPessoa.SBCloseClick(Sender: TObject);
begin
  FFrmOk := False;
  Close;
end;

procedure TFrmCadPessoa.SBLocalizaCEPClick(Sender: TObject);
begin
  LocalizarCEP;
end;

procedure TFrmCadPessoa.SBOkClick(Sender: TObject);
begin
  if ValidarCadastro then
  begin
    FFrmOk := True;
    Close;
  end;
end;

end.

