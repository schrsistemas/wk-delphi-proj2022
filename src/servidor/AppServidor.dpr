// JCL_DEBUG_EXPERT_GENERATEJDBG OFF
// JCL_DEBUG_EXPERT_INSERTJDBG OFF
// JCL_DEBUG_EXPERT_DELETEMAPFILE OFF
program AppServidor;

uses
  FMX.Forms,
  UDmSC in 'UDmSC.pas' {DmSC: TDataModule},
  UDmBase in 'UDmBase.pas' {DmBase: TDataModule},
  UConstantes in '..\classes-comum\UConstantes.pas',
  UClasseCfgDB in '..\classes-comum\negocio\UClasseCfgDB.pas',
  UControle.ClasseCfgDB in '..\classes-comum\controle\UControle.ClasseCfgDB.pas',
  UDAO.ClasseCfgDB in '..\classes-comum\dao\UDAO.ClasseCfgDB.pas',
  UFrmMenuServidor in 'UFrmMenuServidor.pas' {FrmMenuServidor};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMenuServidor, FrmMenuServidor);
  Application.Run;
end.
