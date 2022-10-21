unit URestUtil;

{
  Classe utilitaria consumo api
}

interface

uses
  System.JSON, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Comp.Client, System.Classes,
  REST.Client, IPPeerClient, System.SysUtils, REST.Authenticator.Simple;

type
  IRestUtil = interface
    ['{BF5D93E1-F37E-4057-9F23-7879CDE46D62}']
    function Executar: Boolean;
  end;

  TRestUtil = class(TInterfacedObject, IRestUtil)
  private
    FRESTClient: TRESTClient;
    FRESTRequest: TRESTRequest;
    FRESTResponse: TRESTResponse;
    FSimpleAuthenticator: TSimpleAuthenticator;

    FData: TJSONObject;
    FBaseURL: string;

    procedure InitComponents;
    procedure SetBaseURL(const Value: string);
    function GetData: TJSONValue;
  public
    constructor Create;
    destructor Destroy; override;
    class function Instance: TRestUtil;

    function Executar: Boolean;

  published
    property Data: TJSONValue read GetData;
    property RESTClient: TRESTClient read FRESTClient write FRESTClient;
    property RESTRequest: TRESTRequest read FRESTRequest write FRESTRequest;
    property RESTResponse: TRESTResponse read FRESTResponse write FRESTResponse;
    property SimpleAuthenticator: TSimpleAuthenticator read FSimpleAuthenticator write FSimpleAuthenticator;

    property BaseURL: string read FBaseURL write SetBaseURL;

  end;

implementation

{ TRestUtil }

constructor TRestUtil.Create;
begin
  inherited;

  InitComponents;
end;

destructor TRestUtil.Destroy;
begin

  if Assigned(FRESTClient) then
    FRESTClient.Free;

  if Assigned(FSimpleAuthenticator) then
    FSimpleAuthenticator.Free;

  if Assigned(FData) then
    FData.Free;

  inherited;

end;

function TRestUtil.Executar: Boolean;
begin
  try
    FRESTRequest.Execute;
    Result := (FRESTRequest.Response.StatusCode = 200);
  except
    on E: Exception do
      raise E;
  end;
end;

function TRestUtil.GetData: TJSONValue;
begin
  Result := FRESTResponse.JSONValue;
end;

procedure TRestUtil.InitComponents;
begin
  FRESTClient := TRESTClient.Create(nil);
  FRESTRequest := TRESTRequest.Create(nil);
  FRESTResponse := TRESTResponse.Create(nil);
  FSimpleAuthenticator := TSimpleAuthenticator.Create(nil);

  FRESTClient.ResetToDefaults;
  FRESTRequest.ResetToDefaults;
  FRESTResponse.ResetToDefaults;
  FSimpleAuthenticator.ResetToDefaults;

  FRESTClient.Authenticator := FSimpleAuthenticator;
  FRESTClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  FRESTClient.AcceptCharset := 'utf-8, *;q=0.8';

  FRESTRequest.Client := FRESTClient;
  FRESTRequest.Response := FRESTResponse;
  FRESTRequest.SynchronizedEvents := False;

  FRESTResponse.ContentType := 'application/json';

end;

class function TRestUtil.Instance: TRestUtil;
begin
  Result := Self.Create;
end;

procedure TRestUtil.SetBaseURL(const Value: string);
begin
  FBaseURL := Value;
  FRESTClient.BaseURL := FBaseURL;

end;

end.

