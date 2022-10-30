unit UThreadMonitorGED;

interface

uses
  System.Classes;

type
  ThreadMonitorGED = class(TThread)
  private
    FArquivo: string;
  protected
    procedure Execute; override;
  public
    property Arquivo: string read FArquivo write FArquivo;
  end;

implementation

{
  Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure ThreadMonitorGED.UpdateCaption;
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

{ ThreadMonitorGED }

procedure ThreadMonitorGED.Execute;
begin
  NameThreadForDebugging('TMonitorGED');
  { Place thread code here }


end;

end.

