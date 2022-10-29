unit UFrmCadPessoa;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  UClasse.Endereco, UClasse.Pessoa, FMX.Objects, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.Edit, FMX.ComboEdit, FMX.DateTimeCtrls, UConsultaCEP,
  UFuncoes.Texto, UControle.Service.Pessoa, URestUtil, UDmControle,
  UClasseRepostaOp;

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
    edtId: TEdit;
    Layout3: TLayout;
    Label2: TLabel;
    edtNomeSecundario: TEdit;
    Layout4: TLayout;
    Label3: TLabel;
    edtNomeRazao: TEdit;
    Layout5: TLayout;
    Label4: TLabel;
    edtDocumento: TEdit;
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

{$R *.fmx}

{ TFrmCadPessoa }

function TFrmCadPessoa.GetValues: Boolean;
begin
  if FId > 0 then
  begin
    try
      FPessoa := TServPessoa.BuscarPessoa(FId);
    except
      on E: Exception do
        ShowMessage(E.Message);
    end;
  end
  else
  begin
    FPessoa := TPessoa.Create;
  end;

  with FPessoa do
  begin
    edtId.Text := IntToStr(idpessoa);
    CmbNatureza.ItemIndex := Integer(flnatureza);
    edtDocumento.Text := dsdocumento;
    edtNomeRazao.Text := nmprimeiro;
    edtNomeSecundario.Text := nmsegundo;
    EdtDataRegistro.Date := dtregistro;

    with endereco do
    begin
      edtCEP.Text := dscep;
    end;

    with enderecoIntegracao do
    begin
      edtCidade.Text := nmcidade;
      edtUF.Text := dsuf;
      edtBairro.Text := nmbairro;
      edtLogradouro.Text := nmlogradouro;
      edtComplemento.Text := dscomplemento;
    end;

  end;

end;

function TFrmCadPessoa.SetValues: Boolean;
begin
  with FPessoa do
  begin
    idpessoa := StrToIntDef(edtId.Text, 0);
    flnatureza := TNatureza(CmbNatureza.ItemIndex);
    dsdocumento := edtDocumento.Text;
    nmprimeiro := edtNomeRazao.Text;
    nmsegundo := edtNomeSecundario.Text;
    dtregistro := EdtDataRegistro.Date;

    with endereco do
    begin
      dscep := edtCEP.Text;
    end;

    with enderecoIntegracao do
    begin
      nmcidade := edtCidade.Text;
      dsuf := edtUF.Text;
      nmbairro := edtBairro.Text;
      nmlogradouro := edtLogradouro.Text;
      dscomplemento := edtComplemento.Text;
    end;

  end;

end;

class function TFrmCadPessoa.ShowFrm(value: Integer): Boolean;
begin
  FrmCadPessoa := TFrmCadPessoa.Create(nil);
  try
    FrmCadPessoa.Id := value;

    FrmCadPessoa.GetValues;

    FrmCadPessoa.ShowModal;

    Result := FrmCadPessoa.FrmOk;
  finally
    FrmCadPessoa.Free;
  end;
end;

function TFrmCadPessoa.ValidarCadastro: Boolean;
begin
  Result := False;

  edtDocumento.Text := LimpaNumeros(edtDocumento.Text);
  edtCEP.Text := LimpaNumeros(edtCEP.Text);

  if Trim(edtDocumento.Text) = '' then
    raise Exception.Create('Informe o Documento');

  if Trim(edtNomeRazao.Text) = '' then
    raise Exception.Create('Informe o Nome');

  if Trim(edtCEP.Text) = '' then
    raise Exception.Create('Informe o CEP');

  if (Length(edtCEP.Text) <> 8) and (TNatureza(CmbNatureza.ItemIndex) in [natCPF, natCNPJ]) then
    raise Exception.Create('Informe um CEP v�lido');

  if (Length(edtDocumento.Text) < 11) and (TNatureza(CmbNatureza.ItemIndex) in [natCPF]) then // #lembrar - criar valida��o do documento informado
    raise Exception.Create('Informe um CPF v�lido');

  if (Length(edtDocumento.Text) < 14) and (TNatureza(CmbNatureza.ItemIndex) in [natCNPJ]) then // #lembrar - criar valida��o do documento informado
    raise Exception.Create('Informe um CNPJ v�lido');

  Result := True;
end;

procedure TFrmCadPessoa.LocalizarCEP;
begin
  if edtCEP.Text <> '' then
  begin
    var auxCep: TClasseCEP := TConsultaCEP.Instance.Consultar(edtCEP.Text);

    with auxCep do
    begin
      edtCEP.Text := cep;
      edtLogradouro.Text := logradouro;
      edtBairro.Text := bairro;
      edtCidade.Text := localidade;
      edtUF.Text := uf;
    end;

  end;

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
    SetValues;

    try
      var resp := TServPessoa.RegistrarPessoa(FPessoa);

      if resp.Msg <> '' then
        ShowMessage(resp.Msg);

      FFrmOk := (resp.Operacao <> opErro);
      if FFrmOk then
        Close;

    except
      on E: Exception do
        ShowMessage(E.Message);
    end;
  end;
end;

end.

