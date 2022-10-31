unit UThreadMonitorGED;

interface

uses
  System.Classes, System.SysUtils;

type
  ThreadMonitorGED = class(TThread)
  private
    FArquivo: string;
    FImportaPessoaCSV: Boolean;
  protected
    procedure Execute; override;
  public
    property Arquivo: string read FArquivo write FArquivo;
    property ImportaPessoaCSV: Boolean read FImportaPessoaCSV write FImportaPessoaCSV;

    constructor Create;
  end;

implementation

uses
  UClasse.Pessoa, UControle.ClassePessoa;

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

constructor ThreadMonitorGED.Create;
begin
  inherited Create;
  Suspended := True;
  FreeOnTerminate := True;
  Priority := tpNormal;

end;

procedure ThreadMonitorGED.Execute;
var
  Contador, I: Integer;
  Linha: string;
  listaCSV: TStringList;

  function MontaValor: string;
  var
    ValorMontado: string;
  begin
    ValorMontado := '';
    inc(I);
    while Linha[I] >= ' ' do
    begin
      if Linha[I] = '|' then
        break;
      ValorMontado := ValorMontado + Linha[I];
      inc(I);
    end;
    result := ValorMontado;
  end;

begin
  NameThreadForDebugging('TMonitorGED');
  { Place thread code here }

  if FImportaPessoaCSV then
  begin

    if FileExists(FArquivo) then
    begin
      var auxPessoa := TControlePessoa.Create;

      listaCSV := TStringList.Create;
      listaCSV.LoadFromFile(FArquivo);

      Contador := 0;
      for var l := 0 to listaCSV.Count - 1 do
      begin
        try
          Contador := Contador + 1;

          // DOCUMENTO|NOME_RAZAO|NOME_SECUNDARIO|CEP|
          I := 0;
          Linha := listaCSV[l];

          var pessoa := TPessoa.Create;

          pessoa.idpessoa := 0;
          pessoa.flnatureza := natNI;

          pessoa.dsdocumento := MontaValor;
          pessoa.nmprimeiro := MontaValor;
          pessoa.nmsegundo := MontaValor;

          pessoa.endereco.dscep := MontaValor;

          auxPessoa.Gravar(pessoa);

        except
          on E: Exception do
            raise E;
        end;

      end;

    end;

  end;

end;

end.

