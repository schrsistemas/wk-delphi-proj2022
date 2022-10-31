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
    function pJSONParaArquivo(pArquivoJSON: TJSONArray; const pDir: string): string;
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

function TClasseServidorGED.pJSONParaArquivo(pArquivoJSON: TJSONArray; const pDir: string): string;
var
  SSArquivoStream: TStringStream;
  sArquivoString, sNomeArquivo: string;
  iTamanhoArquivo, iCont: Integer;
  SLArrayStringsArquivo: TStringList;
  byArquivoBytes: Tbytes;
  pathFile: string;
begin
  Result := '';
  try
    sArquivoString := pArquivoJSON.Get(0).ToString;  // Pega a posi��o 0 do array que contem os bytes do arquivo
    Delete(sArquivoString, Length(sArquivoString), 1); // Deleta a �ltima aspas da string
    Delete(sArquivoString, 1, 1); // Deleta a primeira aspas da string

    sNomeArquivo := pArquivoJSON.Get(2).ToString;  // Pega o nome do arquivo que est� na posi��o 2
    Delete(sNomeArquivo, Length(sNomeArquivo), 1); // Deleta a �ltima aspas da string
    Delete(sNomeArquivo, 1, 1); // Deleta a primeira aspas da string

    iTamanhoArquivo := TJSONNumber(pArquivoJSON.Get(1)).AsInt; // Pega na posi��o 1 o tamanho do arquivo

    SLArrayStringsArquivo := TStringList.Create; // Cria um obje do tipo TStringList para emparelhar os bytes
    ExtractStrings([','], [' '], PChar(sArquivoString), SLArrayStringsArquivo); // Coloca cada byte em uma linha no objeto TStringList

    SetLength(byArquivoBytes, iTamanhoArquivo); // Seta o tamanho do array de bytes igual ao tamanho do arquivo

    // Faz um la�o para pegar os bytes do objeto TStringList
    for iCont := 0 to iTamanhoArquivo - 1 do
    begin
      //Pega os bytes do TStringList e adiciona no array de bytes
      byArquivoBytes[iCont] := StrToInt(SLArrayStringsArquivo[iCont]);
    end;
    SSArquivoStream := TStringStream.Create(byArquivoBytes); // Instancia o objeto TStringStream para salvar o arquivo

    // Verifica se o diret�rio passado por par�metro n�o existe
    if not DirectoryExists(pDir) then
      ForceDirectories(pDir); // Se n�o existir o diret�rio vai ser criado

    pathFile := pDir + sNomeArquivo;

    SSArquivoStream.SaveToFile(pathFile); // Salvar o arquivo no hd

    Result := pathFile;
  finally
    SSArquivoStream.Free;
    SLArrayStringsArquivo.Free;
  end;
end;

function TClasseServidorGED.pUploadArquivo(pArquivoJSON: TJSONArray): Boolean;
begin
  ForceDirectories(ExtractFilePath(ParamStr(0)) + 'GED\');
  var pathFile := pJSONParaArquivo(pArquivoJSON, ExtractFilePath(ParamStr(0)) + 'GED\');

  if FileExists(pathFile) and (ExtractFileExt(AnsiUpperCase(pathFile)) = '.CSV') then
    ExecutaImportacao(pathFile);

  Result := True;
end;

end.

