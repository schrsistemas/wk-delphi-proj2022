unit UThreadMonitorEndereco;

{
  Tarefa de monitoramento e correção do endereço das pessoas registradas no sistema.
}

interface

uses
  System.Classes, URestUtil, UClasse.Endereco, UClasse.Pessoa, Rest.Types,
  System.JSON, UConsultaCEP, UDmBase;

type
  TThreadMonitorEndereco = class(TThread)
  private
    FIsRunning: Boolean;

  protected
    procedure Execute; override;
    constructor Create;
  public
    property IsRunning: Boolean read FIsRunning write FIsRunning;

  end;

implementation

{
  Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure ThreadMonitorEndereco.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end;

    or

    Synchronize(
      procedure
      begin
        Form1.Caption := 'Updated in thread via an anonymous method'
      end
      )
    );

  where an anonymous method is passed.

  Similarly, the developer can call the Queue method with similar parameters as
  above, instead passing another TThread class as the first parameter, putting
  the calling thread in a queue with the other thread.

}

{ ThreadMonitorEndereco }

constructor TThreadMonitorEndereco.Create;
begin
  inherited Create;
  Suspended := True;
  FreeOnTerminate := True;
  Priority := tpNormal;

end;

procedure TThreadMonitorEndereco.Execute;
begin
  NameThreadForDebugging('TMonitorEndereco');
  { Place thread code here }

  while not Terminated do
  begin
    FIsRunning := True;

  end;

end;

end.

