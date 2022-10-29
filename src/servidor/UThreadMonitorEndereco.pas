unit UThreadMonitorEndereco;

{
  Tarefa de monitoramento e correção do endereço das pessoas registradas no sistema.
}

interface

uses
  System.Classes, URestUtil, UClasse.Endereco, UClasse.Pessoa, Rest.Types,
  System.JSON, UConsultaCEP, UDmBase, Generics.Collections, System.SysUtils;

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

const
  TMR_INTERVAL = 1000 * 30;  // Intervalo de tempo de verificação - deixado 30 segundos

implementation

uses
  UControle.ClassePessoa;

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

  {
    A Cada X tempo - será verificado a existencia de pessoas pendente de regularização de endereço,
    a validação sera com base na cidade e uf vazia - pensando no fato de cep unico

  }

  while not Terminated do
  begin
    FIsRunning := True;

    try
      var auxCtrlPessoa := TControlePessoa.Create;
      var lista := auxCtrlPessoa.ListarPendentesAtualizacaoEndereco;
      for var pessoa in lista do
      begin
        try
          if pessoa.flnatureza in [natCPF, natCNPJ] then
          begin
            var cep := TConsultaCEP.Instance.Consultar(pessoa.endereco.dscep);

            if cep.localidade <> '' then
            begin
              pessoa.enderecoIntegracao.nmbairro := cep.bairro;
              pessoa.enderecoIntegracao.nmlogradouro := cep.logradouro;
              pessoa.enderecoIntegracao.nmcidade := cep.localidade;
              pessoa.enderecoIntegracao.dsuf := cep.uf;
            end
            else
            begin
              pessoa.enderecoIntegracao.nmlogradouro := '<cep nao localizado.>';
              pessoa.enderecoIntegracao.nmcidade := 'NL';
              pessoa.enderecoIntegracao.dsuf := 'NL';
            end;
          end
          else
          begin
            pessoa.enderecoIntegracao.nmcidade := 'EX';
            pessoa.enderecoIntegracao.dsuf := 'EX';
          end;

        except
          on E: Exception do
          begin
            pessoa.enderecoIntegracao.nmlogradouro := '<cep nao localizado.>';
            pessoa.enderecoIntegracao.nmcidade := 'NI';
            pessoa.enderecoIntegracao.dsuf := 'NI';
          end;
        end;

        auxCtrlPessoa.Gravar(pessoa);
      end;
    except
      on E: Exception do
      begin
      end;
    end;

    TThread.Sleep(TMR_INTERVAL);
  end;

end;

end.

