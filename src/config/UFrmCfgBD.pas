unit UFrmCfgBD;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, UConstantes, IniFiles, UDmBase, UClasseCfgDB,
  Vcl.Samples.Spin, UControle.ClasseCfgDB;

type
  TFrmCfgBD = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    edtServidor: TEdit;
    btnOk: TButton;
    btnCancel: TButton;
    Panel3: TPanel;
    Label2: TLabel;
    edtSenha: TEdit;
    Panel4: TPanel;
    Label3: TLabel;
    edtUsuario: TEdit;
    Panel5: TPanel;
    Label4: TLabel;
    Panel6: TPanel;
    Label5: TLabel;
    btnTest: TButton;
    Panel7: TPanel;
    Label6: TLabel;
    edtBanco: TEdit;
    cbxSGDB: TComboBox;
    sePorta: TSpinEdit;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
  private
    { Private declarations }
    FCfgDB: TClasseCfgDB;
    procedure CarregaCfgBD;
    procedure GravarCfgBD;
    procedure TestarCfgBD;
    procedure MapearClasse;
  public
    { Public declarations }
    FrmOk: Boolean;
    class function ShowFrm: Boolean;
  end;

var
  FrmCfgBD: TFrmCfgBD;

implementation

{$R *.dfm}

{ TFrmCfgBD }

procedure TFrmCfgBD.btnCancelClick(Sender: TObject);
begin
  FrmOk := False;
  Close;
end;

procedure TFrmCfgBD.btnOkClick(Sender: TObject);
begin
  FrmOk := True;
  Close;
end;

procedure TFrmCfgBD.btnTestClick(Sender: TObject);
begin
  TestarCfgBD;
end;

procedure TFrmCfgBD.CarregaCfgBD;
begin
  FCfgDB := TControleClasseCfgDB.CarregaIniParaClasse;

  cbxSGDB.ItemIndex := Integer(FCfgDB.SGBD);
  edtServidor.Text := FCfgDB.Servidor;
  edtBanco.Text := FCfgDB.Banco;
  edtUsuario.Text := FCfgDB.Usuario;
  edtSenha.Text := FCfgDB.Senha;
  sePorta.Value := FCfgDB.Porta;

end;

procedure TFrmCfgBD.GravarCfgBD;
begin
  MapearClasse;
  TControleClasseCfgDB.GravarIni(FCfgDB);
end;

procedure TFrmCfgBD.MapearClasse;
begin
  FCfgDB := TClasseCfgDB.Create;
  with FCfgDB do
  begin
    SGBD := TSGDB(cbxSGDB.ItemIndex);
    Usuario := edtUsuario.Text;
    Senha := edtSenha.Text;
    Servidor := edtServidor.Text;
    Banco := edtBanco.Text;
    Porta := sePorta.Value;
  end;
end;

class function TFrmCfgBD.ShowFrm: Boolean;
begin
  FrmCfgBD := TFrmCfgBD.Create(Application);
  try
    with FrmCfgBD do
    begin
      CarregaCfgBD;
      ShowModal;
      if FrmOk then
      begin
        GravarCfgBD;
      end;
    end;

  finally
    FreeAndNil(FrmCfgBD);
  end;

end;

procedure TFrmCfgBD.TestarCfgBD;
begin
  if not Assigned(DmBase) then
    DmBase := TDmBase.Create(nil);

  MapearClasse;
  if DmBase.TestarConexao(FCfgDB) then
  begin
    ShowMessage('Conectado com sucesso!');
  end;
end;

end.

