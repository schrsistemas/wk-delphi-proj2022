unit UFrmConsPessoa;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Layouts, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  System.Generics.Collections, UClasse.Pessoa;

type
  TFrmConsPessoa = class(TForm)
    lytContainer: TLayout;
    LytHeader: TLayout;
    RtTitle: TRectangle;
    SBClose: TSpeedButton;
    LblTitle: TLabel;
    LytBody: TLayout;
    lytToolbar: TLayout;
    btnRefresh: TSpeedButton;
    btnAdd: TSpeedButton;
    LblInfo: TLabel;
    lvLista: TListView;
    imgDelete: TImage;
    procedure btnAddClick(Sender: TObject);
    procedure SBCloseClick(Sender: TObject);
    procedure lvListaUpdateObjects(const Sender: TObject; const AItem: TListViewItem);
    procedure lvListaItemClickEx(const Sender: TObject; ItemIndex: Integer; const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
    procedure btnRefreshClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure LayoutListview(AItem: TListViewItem);
    procedure AddRegistroListView(value: TPessoa);
    procedure Listar;
  public
    class function ShowFrm: Boolean;
  end;

var
  FrmConsPessoa: TFrmConsPessoa;

implementation

uses
  UFrmCadPessoa, UControle.Service.Pessoa;

{$R *.fmx}

{ TFrmConsPessoa }

procedure TFrmConsPessoa.btnAddClick(Sender: TObject);
begin
  if TFrmCadPessoa.ShowFrm(0) then
    Listar;

end;

procedure TFrmConsPessoa.btnRefreshClick(Sender: TObject);
begin
  Listar;
end;

procedure TFrmConsPessoa.FormShow(Sender: TObject);
begin
  Listar;
end;

procedure TFrmConsPessoa.lvListaItemClickEx(const Sender: TObject; ItemIndex: Integer; const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
begin
  if (ItemObject <> nil) and (ItemObject.Name = 'imgDelete') then
  begin
    if MessageDlg('Deletar esta pessoa?', TMsgDlgType.mtConfirmation, mbOKCancel, 0) = mrOk then
    begin
      if TServPessoa.Deletar(Trunc(ItemObject.TagFloat)) then
      begin
        lvLista.Items.Delete(ItemIndex);
      end;
    end;
  end
  else
  begin
    if TFrmCadPessoa.ShowFrm(lvLista.Items[ItemIndex].Tag) then
      Listar;
    //showmessage(TListItemText(lvLista.Items[ItemIndex].Objects.FindDrawable('txtNome')).Text);
  end;
end;

procedure TFrmConsPessoa.AddRegistroListView(value: TPessoa);
var
  item: TListViewItem;
begin
  item := lvLista.Items.Add;
  item.Height := 90;
  item.Tag := value.idpessoa;

    // Nome
  TListItemText(item.Objects.FindDrawable('txtNome')).Text := value.nmprimeiro + ' - ' + value.nmsegundo;

  case value.flnatureza of
    natCPF:
      TListItemText(item.Objects.FindDrawable('txtNatureza')).Text := 'Física (CPF)';
    natCNPJ:
      TListItemText(item.Objects.FindDrawable('txtNatureza')).Text := 'Jurídica (CNPJ)';
    natEstrangeiro:
      TListItemText(item.Objects.FindDrawable('txtNatureza')).Text := 'Estrangeiro (EX)';
  end;

  TListItemText(item.Objects.FindDrawable('txtDocumento')).Text := value.dsdocumento;

  TListItemText(item.Objects.FindDrawable('txtDtRegistro')).Text := FormatDateTime('dd/MM/yyyy', value.dtregistro);

  TListItemText(item.Objects.FindDrawable('txtCEP')).Text := value.endereco.dscep;

  TListItemText(item.Objects.FindDrawable('txtEndereco')).Text := value.enderecoIntegracao.nmlogradouro + ', ' + value.enderecoIntegracao.dscomplemento + #13#10 + value.enderecoIntegracao.nmbairro + ', ' + value.enderecoIntegracao.nmcidade + ', ' + value.enderecoIntegracao.dsuf;

    // Delete
  TListItemImage(item.Objects.FindDrawable('imgDelete')).Bitmap := imgDelete.Bitmap;
  TListItemImage(item.Objects.FindDrawable('imgDelete')).TagFloat := value.idpessoa;

  LayoutListview(item);
end;

procedure TFrmConsPessoa.Listar;
begin
  TThread.CreateAnonymousThread(
    procedure
    begin
      TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
          btnRefresh.Enabled := False;
          try
            lvLista.BeginUpdate;
            lvLista.Items.Clear;
            lblInfo.Text := 'Aguarde,... Efetuando consulta!';
            try
              var values := TServPessoa.Listar;
              var cont := 0;
              for var pessoa in values do
              begin
                AddRegistroListView(pessoa);
                cont := cont + 1;
              end;
              lblInfo.Text := IntToStr(cont) + ' registros localizados.';
            except
              on E: Exception do
                lblInfo.Text := 'Erro na conexão com o servidor... ' + E.Message;
            end;

            lvLista.EndUpdate;
          finally
            btnRefresh.Enabled := True;
          end;
        end);
    end).start();
end;

procedure TFrmConsPessoa.lvListaUpdateObjects(const Sender: TObject; const AItem: TListViewItem);
begin
  LayoutListview(AItem);
end;

procedure TFrmConsPessoa.LayoutListview(AItem: TListViewItem);
begin

end;

procedure TFrmConsPessoa.SBCloseClick(Sender: TObject);
begin
  Close;
end;

class function TFrmConsPessoa.ShowFrm: Boolean;
begin
  FrmConsPessoa := TFrmConsPessoa.Create(nil);
  try
    FrmConsPessoa.ShowModal;
  finally
    FrmConsPessoa.Free;
  end;
end;

end.

