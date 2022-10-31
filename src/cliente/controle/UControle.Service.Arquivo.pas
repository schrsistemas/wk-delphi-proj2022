unit UControle.Service.Arquivo;

interface

uses
  URestUtil, UClasse.Pessoa, UClasse.Endereco, UClasse.EnderecoIntegracao,
  UDmControle, USistema, SysUtils, System.Classes, System.Generics.Collections,
  UClasseRepostaOp, System.JSON;

type
  TServArquivo = class(TObject)
  private
    class function fArquivoParaJSON(pDirArquivo: string): TJSONArray;
  public
    class function ImportarArquivo(aArquivo: string): Boolean;
  end;

implementation

uses
  UClasseServidorClient;

{ TServArquivo }

class function TServArquivo.fArquivoParaJSON(pDirArquivo: string): TJSONArray;
var
  sBytesArquivo, sNomeArquivo: string;
  oSSArquivoStream: TStringStream;
  iTamanhoArquivo, iCont: Integer;
begin
  try
    Result := TJSONArray.Create; // Instanciando o objeto JSON que conter� o arquivo serializado

    oSSArquivoStream := TStringStream.Create; // Instanciando o objeto stream que carregar� o arquivo para memoria
    oSSArquivoStream.LoadFromFile(pDirArquivo);  // Carregando o arquivo para memoria
    iTamanhoArquivo := oSSArquivoStream.Size; // pegando o tamanho do arquivo

    sBytesArquivo := '';

    // Fazendo um lan�o no arquivo que est� na memoria para pegar os bytes do mesmo
    for iCont := 0 to iTamanhoArquivo - 1 do
    begin
      // A medida que est� fazendo o la�o para pegar os bytes, os mesmos s�o jogados para
      // uma vari�vel do tipo string separado por ","
      sBytesArquivo := sBytesArquivo + IntToStr(oSSArquivoStream.Bytes[iCont]) + ', ';
    end;

    // Como � colocado uma v�rgula ap�s o byte, fica sempre sobrando uma v�gugula, que � deletada
    Delete(sBytesArquivo, Length(sBytesArquivo) - 1, 2);

    // Adiciona a string que cont�m os bytes para o array JSON
    Result.Add(sBytesArquivo);

    // Adiciona para o array JSON o tamanho do arquivo
    Result.AddElement(TJSONNumber.Create(iTamanhoArquivo));

    // Extrai o nome do arquivo
    sNomeArquivo := ExtractFileName(pDirArquivo);

    // Adiciona na terceira posi��o do array JSON o nome do arquivo
    Result.AddElement(TJSONString.Create(sNomeArquivo));
  finally
    oSSArquivoStream.Free;
  end;
end;

class function TServArquivo.ImportarArquivo(aArquivo: string): Boolean;
var
  oArquivoJSON: TJSONArray;
begin
  if not DmControle.SQLConnection.Connected then
    DmControle.ConectarServidor;

  try
    var auxServ := TClasseServidorGEDClient.Create(DmControle.SQLConnection.DBXConnection);

    //Converte o arquivo passado por par�metro em JSON
    oArquivoJSON := fArquivoParaJSON(aArquivo);

    Result := auxServ.pUploadArquivo(oArquivoJSON);

  except
    on E: Exception do
    begin
      DmControle.DesConectarServidor;
      raise E;
    end;
  end;

end;

end.

