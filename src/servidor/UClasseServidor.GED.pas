unit UClasseServidor.GED;

interface

uses
  System.Classes, UClasse.Pessoa, UControle.ClassePessoa, UClasseRepostaOp,
  Generics.Collections, Rest.Json, SysUtils, System.JSON,
  Datasnap.DSProviderDataModuleAdapter;

type
    {$METHODINFO ON}
  TClasseServidorGED = class(TComponent)
  private
    function pJSONParaArquivo(pArquivoJSON: TJSONArray; const pDir: string): Boolean;
    function ExecutaImportacao(aPathFile: string): Boolean;
  public
    function pUploadArquivo(pArquivoJSON: TJSONArray): Boolean;
  end;
    {$METHODINFO OFF}

implementation

uses
  UThreadMonitorGED;

{ TClasseServidor }


{ TClasseServidorGED }

function TClasseServidorGED.ExecutaImportacao(aPathFile: string): Boolean;
begin
  var tmg: ThreadMonitorGED := ThreadMonitorGED.Create;
  tmg.ImportaPessoaCSV := True;
  tmg.Arquivo := aPathFile;
  tmg.Start;

end;

function TClasseServidorGED.pJSONParaArquivo(pArquivoJSON: TJSONArray; const pDir: string): Boolean;
var
  SSArquivoStream: TStringStream;
  sArquivoString, sNomeArquivo: string;
  iTamanhoArquivo, iCont: Integer;
  SLArrayStringsArquivo: TStringList;
  byArquivoBytes: Tbytes;
begin
  Result := False;
  try
    sArquivoString := pArquivoJSON.Get(0).ToString;  // Pega a posição 0 do array que contem os bytes do arquivo
    Delete(sArquivoString, Length(sArquivoString), 1); // Deleta a última aspas da string
    Delete(sArquivoString, 1, 1); // Deleta a primeira aspas da string

    sNomeArquivo := pArquivoJSON.Get(2).ToString;  // Pega o nome do arquivo que está na posição 2
    Delete(sNomeArquivo, Length(sNomeArquivo), 1); // Deleta a última aspas da string
    Delete(sNomeArquivo, 1, 1); // Deleta a primeira aspas da string

    iTamanhoArquivo := TJSONNumber(pArquivoJSON.Get(1)).AsInt; // Pega na posição 1 o tamanho do arquivo

    SLArrayStringsArquivo := TStringList.Create; // Cria um obje do tipo TStringList para emparelhar os bytes
    ExtractStrings([','], [' '], PChar(sArquivoString), SLArrayStringsArquivo); // Coloca cada byte em uma linha no objeto TStringList

    SetLength(byArquivoBytes, iTamanhoArquivo); // Seta o tamanho do array de bytes igual ao tamanho do arquivo

    // Faz um laço para pegar os bytes do objeto TStringList
    for iCont := 0 to iTamanhoArquivo - 1 do
    begin
      //Pega os bytes do TStringList e adiciona no array de bytes
      byArquivoBytes[iCont] := StrToInt(SLArrayStringsArquivo[iCont]);
    end;
    SSArquivoStream := TStringStream.Create(byArquivoBytes); // Instancia o objeto TStringStream para salvar o arquivo

    // Verifica se o diretório passado por parâmetro não existe
    if not DirectoryExists(pDir) then
      ForceDirectories(pDir); // Se não existir o diretório vai ser criado

    var pathFile: string := pDir + sNomeArquivo;

    SSArquivoStream.SaveToFile(pathFile); // Salvar o arquivo no hd

    if ExtractFileExt(AnsiUpperCase(pathFile)) = '.CSV' then
      ExecutaImportacao(pathFile);

    Result := True;
  finally
    SSArquivoStream.Free;
    SLArrayStringsArquivo.Free;
  end;
end;

function TClasseServidorGED.pUploadArquivo(pArquivoJSON: TJSONArray): Boolean;
begin
  ForceDirectories(ExtractFilePath(ParamStr(0)) + 'GED\');
  Result := pJSONParaArquivo(pArquivoJSON, ExtractFilePath(ParamStr(0)) + 'GED\');
end;

end.

