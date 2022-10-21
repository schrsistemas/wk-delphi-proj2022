// JCL_DEBUG_EXPERT_GENERATEJDBG OFF
// JCL_DEBUG_EXPERT_INSERTJDBG OFF
// JCL_DEBUG_EXPERT_DELETEMAPFILE OFF
program AppCliente;

uses
  System.StartUpCopy,
  FMX.Forms,
  UFrmMenuCliente in 'UFrmMenuCliente.pas' {FrmMenuCliente},
  UDmControle in 'UDmControle.pas' {DmControle: TDataModule};

{$R *.res}

begin
  Application.Initialize;
{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
{$ENDIF}
  Application.CreateForm(TFrmMenuCliente, FrmMenuCliente);
  Application.CreateForm(TDmControle, DmControle);
  Application.Run;
end.
