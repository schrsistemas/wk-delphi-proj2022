// JCL_DEBUG_EXPERT_GENERATEJDBG OFF
// JCL_DEBUG_EXPERT_INSERTJDBG OFF
// JCL_DEBUG_EXPERT_DELETEMAPFILE OFF
program AppServidor;

uses
  FMX.Forms,
  UDmSC in 'UDmSC.pas' {DmSC: TDataModule},
  UDmBase in 'UDmBase.pas' {DmBase: TDataModule},
  UClasseCfgDB in '..\classes-comum\negocio\UClasseCfgDB.pas',
  UControle.ClasseCfgDB in '..\classes-comum\controle\UControle.ClasseCfgDB.pas',
  UDAO.ClasseCfgDB in '..\classes-comum\dao\UDAO.ClasseCfgDB.pas',
  UFrmMenuServidor in 'UFrmMenuServidor.pas' {FrmMenuServidor},
  URestUtil in '..\classes-comum\util\URestUtil.pas',
  UThreadMonitorEndereco in 'UThreadMonitorEndereco.pas',
  UConsultaCEP in '..\classes-comum\util\UConsultaCEP.pas',
  UFuncoes.Texto in '..\classes-comum\util\UFuncoes.Texto.pas',
  UConstantes in '..\classes-comum\util\UConstantes.pas',
  UClasse.Endereco in '..\classes-comum\negocio\UClasse.Endereco.pas',
  UClasse.Pessoa in '..\classes-comum\negocio\UClasse.Pessoa.pas',
  UICadastro in '..\classes-comum\interfaces\UICadastro.pas',
  UDao.ClassePessoa in '..\classes-comum\dao\UDao.ClassePessoa.pas',
  UDao.ClasseEndereco in '..\classes-comum\dao\UDao.ClasseEndereco.pas',
  UDao.ClasseEnderecoIntegracao in '..\classes-comum\dao\UDao.ClasseEnderecoIntegracao.pas',
  UControle.ClassePessoa in '..\classes-comum\controle\UControle.ClassePessoa.pas',
  UIDAO in '..\classes-comum\interfaces\UIDAO.pas',
  UDAO in '..\classes-comum\dao\UDAO.pas',
  UClasse.EnderecoIntegracao in '..\classes-comum\negocio\UClasse.EnderecoIntegracao.pas',
  UClasseRepostaOp in '..\classes-comum\negocio\UClasseRepostaOp.pas';

{$R *.res}

begin
  Application.Initialize;
{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
{$ENDIF}
  Application.CreateForm(TFrmMenuServidor, FrmMenuServidor);
  Application.Run;
end.
