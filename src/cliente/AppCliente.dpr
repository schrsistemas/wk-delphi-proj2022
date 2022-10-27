// JCL_DEBUG_EXPERT_GENERATEJDBG OFF
// JCL_DEBUG_EXPERT_INSERTJDBG OFF
// JCL_DEBUG_EXPERT_DELETEMAPFILE OFF
program AppCliente;

uses
  System.StartUpCopy,
  FMX.Forms,
  UFrmMenuCliente in 'UFrmMenuCliente.pas' {FrmMenuCliente},
  UDmControle in 'UDmControle.pas' {DmControle: TDataModule},
  UICadastro in '..\classes-comum\interfaces\UICadastro.pas',
  UClasse.Pessoa in '..\classes-comum\negocio\UClasse.Pessoa.pas',
  UClasse.Endereco in '..\classes-comum\negocio\UClasse.Endereco.pas',
  UFrmCadPessoa in 'visao\UFrmCadPessoa.pas' {FrmCadPessoa},
  UConsultaCEP in '..\classes-comum\util\UConsultaCEP.pas',
  URestUtil in '..\classes-comum\util\URestUtil.pas',
  UFuncoes.Texto in '..\classes-comum\util\UFuncoes.Texto.pas',
  UControle.Service.Pessoa in 'controle\UControle.Service.Pessoa.pas',
  UClasseCfgAppCliente in '..\classes-comum\negocio\UClasseCfgAppCliente.pas',
  UConstantes in '..\classes-comum\util\UConstantes.pas',
  UControle.ClasseCfgAppCliente in '..\classes-comum\controle\UControle.ClasseCfgAppCliente.pas',
  UDAO.ClasseCfgAppCliente in '..\classes-comum\dao\UDAO.ClasseCfgAppCliente.pas',
  USistema in '..\classes-comum\negocio\USistema.pas';

{$R *.res}

begin
  Application.Initialize;
{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
{$ENDIF}
  Application.CreateForm(TFrmMenuCliente, FrmMenuCliente);
  Application.Run;
end.
