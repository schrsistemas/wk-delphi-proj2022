unit UConsultaCEP;

interface

uses
  URestUtil, SysUtils, UFuncoes.Texto, System.JSON, REST.Client;

type
  TClasseCEP = class(TObject)
  private
    Flogradouro: string;
    Fbairro: string;
    Fuf: string;
    Flocalidade: string;
    Fcomplemento: string;
    Fcep: string;
    FdtHrAtualizacao: TDateTime;

  public
    property cep: string read Fcep write Fcep;
    property logradouro: string read Flogradouro write Flogradouro;
    property bairro: string read Fbairro write Fbairro;
    property uf: string read Fuf write Fuf;
    property localidade: string read Flocalidade write Flocalidade;
    property complemento: string read Fcomplemento write Fcomplemento;
    property dtHrAtualizacao: TDateTime read FdtHrAtualizacao write FdtHrAtualizacao;

    function ToString: string; override;

    constructor Create;

  end;

  IConsultaCEP = interface
    ['{C6E1F54F-483E-4070-8101-B242B39B150E}']
    function Consultar(aCEP: string): TClasseCEP;
  end;

  TConsultaCEP = class(TInterfacedObject, IConsultaCEP)
  private
  protected
  public
    constructor Create;
    destructor Destroy;
    class function Instance: IConsultaCEP;

    function Consultar(aCEP: string): TClasseCEP;

  published
  end;

implementation

{ TConsultaCEP }

function TConsultaCEP.Consultar(aCEP: string): TClasseCEP;
begin
  Result := TClasseCEP.Create;

  var restAux: TRestUtil := TRestUtil(TRestUtil.Instance);

  aCEP := LimpaNumeros(aCEP);

  restAux.BaseURL := 'https://viacep.com.br/ws/' + aCEP + '/json';
  restAux.Executar;

  var data: TJSONObject := restAux.Data as TJSONObject;

  if Assigned(data) then
  begin
    try
      Result.logradouro := data.Values['logradouro'].Value;
    except
      on Exception do
        Result.logradouro := '';
    end;
    try
      Result.bairro := data.Values['bairro'].Value;
    except
      on Exception do
        Result.bairro := '';
    end;
    try
      Result.uf := data.Values['uf'].Value;
    except
      on Exception do
        Result.uf := '';
    end;
    try
      Result.localidade := data.Values['localidade'].Value;
    except
      on Exception do
        Result.localidade := '';
    end;
    try
      Result.complemento := data.Values['complemento'].Value;
    except
      on Exception do
        Result.complemento := '';
    end;
  end;

end;

constructor TConsultaCEP.Create;
begin
  inherited;

end;

destructor TConsultaCEP.Destroy;
begin

  inherited;
end;

class function TConsultaCEP.Instance: IConsultaCEP;
begin
  Result := Self.Create;
end;

{ TClasseCEP }

constructor TClasseCEP.Create;
begin
  inherited;

end;

function TClasseCEP.ToString: string;
begin
  Result := 'UF= ' + Fuf + #13#10 + 'Localidade= ' + Flocalidade + #13#10 + 'Bairro=' + Fbairro + #13#10 + 'Logradouro=' + Flogradouro + #13#10 + 'Compl.=' + Fcomplemento;
end;

end.

