unit UClasseServidor.Pessoa;

interface

uses
  System.Classes, UClasse.Pessoa, UControle.ClassePessoa, UClasseRepostaOp,
  Generics.Collections, Rest.Json, SysUtils;

type
    {$METHODINFO ON}
  TClasseServidorPessoa = class(TComponent)
    function Get(aID: Integer): TPessoa;

    function Gravar(aObj: TPessoa): TResposta;
    function Atualizar(aObj: TPessoa): TResposta;
    function Deletar(aID: Integer): Boolean;

    function Filtrar(Campo: string; Value: string): TObjectList<TPessoa>;
    function Listar: TObjectList<TPessoa>;

    function Importar(value: TStream): Boolean;
    function ImportarLista(listaCSV: TStringList): Boolean;

    function Exportar: TStream;
    function ExportarLista: TStringList;

  end;
    {$METHODINFO OFF}

implementation

uses
  UDao.ClassePessoa;

{ TClasseServidorPessoa }

function TClasseServidorPessoa.Atualizar(aObj: TPessoa): TResposta;
begin
  Result := Gravar(aObj);
end;

function TClasseServidorPessoa.Deletar(aID: Integer): Boolean;
begin
  var DAOPessoa: TDAOPessoa := TDAOPessoa.Create;
  Result := DAOPessoa.Deletar(aID);
end;

function TClasseServidorPessoa.Exportar: TStream;
begin
  Result := TMemoryStream.Create;

  var strAux := TStringList.Create;
  strAux.Clear;

  var DAOPessoa: TDAOPessoa := TDAOPessoa.Create;
  var Ids: TStringList := DAOPessoa.ListarIds;
  for var I := 0 to Ids.Count - 1 do
  begin
    strAux.Add(Get(StrToIntDef(Ids[I], 0)).ToCSVString);
  end;

  Result.Write(Pointer(strAux.Text)^, length(strAux.Text));

end;

function TClasseServidorPessoa.ExportarLista: TStringList;
begin
  Result := TStringList.Create;
  Result.Clear;

  var DAOPessoa: TDAOPessoa := TDAOPessoa.Create;
  var Ids: TStringList := DAOPessoa.ListarIds;
  for var I := 0 to Ids.Count - 1 do
  begin
    Result.Add(Get(StrToIntDef(Ids[I], 0)).ToCSVString);
  end;

end;

function TClasseServidorPessoa.Filtrar(Campo, Value: string): TObjectList<TPessoa>;
begin
  Result := TObjectList<TPessoa>.Create;
  Result.Clear;
  var DAOPessoa: TDAOPessoa := TDAOPessoa.Create;
  var Ids: TStringList := DAOPessoa.ListarIds(Campo, Value);
  for var I := 0 to Ids.Count - 1 do
  begin
    Result.Add(Get(StrToIntDef(Ids[I], 0)));
  end;
end;

function TClasseServidorPessoa.Get(aID: Integer): TPessoa;
begin
  var auxPessoa := TControlePessoa.Create;
  Result := auxPessoa.Get(aID);
end;

function TClasseServidorPessoa.Gravar(aObj: TPessoa): TResposta;
begin
  var auxPessoa := TControlePessoa.Create;
  Result := auxPessoa.Gravar(aObj);
end;

function TClasseServidorPessoa.Importar(value: TStream): Boolean;
begin

end;

function TClasseServidorPessoa.ImportarLista(listaCSV: TStringList): Boolean;
var
  Contador, I: Integer;
  Linha: string;
  // Lê Linha e Monta os valores

  function MontaValor: string;
  var
    ValorMontado: string;
  begin
    ValorMontado := '';
    inc(I);
    while Linha[I] >= ' ' do
    begin
      if Linha[I] = '|' then // delimitador
        break;
      ValorMontado := ValorMontado + Linha[I];
      inc(I);
    end;
    result := ValorMontado;
  end;

begin
  Result := False;

  var auxPessoa := TControlePessoa.Create;
  Contador := 0;
  for var l := 0 to listaCSV.Count - 1 do
  begin
    try
      Contador := Contador + 1;
    // CODIGO;NATUREZA;DOCUMENTO;NOME_RAZAO;NOME_SECUNDARIO;CEP;LOGRADOURO;BAIRRO;CIDADE;UF;COMPLEMENTO;
      I := 0;
      Linha := listaCSV[l];

      var pessoa := TPessoa.Create;

      pessoa.idpessoa := 0;
      MontaValor;
      pessoa.flnatureza := natNI;
      MontaValor;
      pessoa.dsdocumento := MontaValor;
      pessoa.nmprimeiro := MontaValor;
      pessoa.nmsegundo := MontaValor;

      pessoa.endereco.dscep := MontaValor;

      pessoa.enderecoIntegracao.nmlogradouro := MontaValor;
      pessoa.enderecoIntegracao.nmbairro := MontaValor;
      pessoa.enderecoIntegracao.nmcidade := MontaValor;
      pessoa.enderecoIntegracao.dsuf := MontaValor;
      pessoa.enderecoIntegracao.dscomplemento := MontaValor;

      auxPessoa.Gravar(pessoa);

    except
      on E: Exception do
        raise E;
    end;

  end;

  Result := True;
end;

function TClasseServidorPessoa.Listar: TObjectList<TPessoa>;
begin
  Result := TObjectList<TPessoa>.Create;
  Result.Clear;
  var DAOPessoa: TDAOPessoa := TDAOPessoa.Create;
  var Ids: TStringList := DAOPessoa.ListarIds;
  for var I := 0 to Ids.Count - 1 do
  begin
    Result.Add(Get(StrToIntDef(Ids[I], 0)));
  end;
end;

end.

