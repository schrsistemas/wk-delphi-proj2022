// JCL_DEBUG_EXPERT_GENERATEJDBG OFF
// JCL_DEBUG_EXPERT_INSERTJDBG OFF
// JCL_DEBUG_EXPERT_DELETEMAPFILE OFF
program AppConfig;

uses
  Vcl.Forms,
  UFrmCfgBD in 'UFrmCfgBD.pas' {FrmCfgBD},
  UControle.ClasseCfgDB in '..\classes-comum\controle\UControle.ClasseCfgDB.pas',
  UDAO.ClasseCfgDB in '..\classes-comum\dao\UDAO.ClasseCfgDB.pas',
  UClasseCfgDB in '..\classes-comum\negocio\UClasseCfgDB.pas',
  UConstantes in '..\classes-comum\UConstantes.pas',
  UDmBase in '..\servidor\UDmBase.pas' {DmBase: TDataModule};

{$R *.res}

begin
  Application.Initialize;
{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
{$ENDIF}
  Application.MainFormOnTaskbar := True;
  TFrmCfgBD.ShowFrm;
  Application.Run;
end.
