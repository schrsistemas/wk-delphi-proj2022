unit UFuncoes.Validacao.CPF_CNPJ;

interface

uses
  System.SysUtils, System.Classes, UFuncoes.Texto;

function cnpj(num: string): boolean;

function cpf(num: string): boolean;

function FormataCPF_CNPJ(edvalor: string): string;

implementation

function cnpj(num: string): boolean;
var
  n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12: integer;
  d1, d2: integer;
  digitado, calculado: string;
begin
  num := LimpaNumeros(num);

  n1 := StrToIntDef(num[1], 0);
  n2 := StrToIntDef(num[2], 0);
  n3 := StrToIntDef(num[3], 0);
  n4 := StrToIntDef(num[4], 0);
  n5 := StrToIntDef(num[5], 0);
  n6 := StrToIntDef(num[6], 0);
  n7 := StrToIntDef(num[7], 0);
  n8 := StrToIntDef(num[8], 0);
  n9 := StrToIntDef(num[9], 0);
  n10 := StrToIntDef(num[10], 0);
  n11 := StrToIntDef(num[11], 0);
  n12 := StrToIntDef(num[12], 0);
  d1 := n12 * 2 + n11 * 3 + n10 * 4 + n9 * 5 + n8 * 6 + n7 * 7 + n6 * 8 + n5 * 9 + n4 * 2 + n3 * 3 + n2 * 4 + n1 * 5;
  d1 := 11 - (d1 mod 11);
  if d1 >= 10 then
    d1 := 0;
  d2 := d1 * 2 + n12 * 3 + n11 * 4 + n10 * 5 + n9 * 6 + n8 * 7 + n7 * 8 + n6 * 9 + n5 * 2 + n4 * 3 + n3 * 4 + n2 * 5 + n1 * 6;
  d2 := 11 - (d2 mod 11);
  if d2 >= 10 then
    d2 := 0;
  calculado := inttostr(d1) + inttostr(d2);
  digitado := num[13] + num[14];
  if calculado = digitado then
    Result := true
  else
    Result := false;
end;

//Validar CPF
function cpf(num: string): boolean;
var
  n1, n2, n3, n4, n5, n6, n7, n8, n9: integer;
  d1, d2: integer;
  digitado, calculado: string;
begin
  num := LimpaNumeros(num);

  n1 := StrToIntDef(num[1], 0);
  n2 := StrToIntDef(num[2], 0);
  n3 := StrToIntDef(num[3], 0);
  n4 := StrToIntDef(num[4], 0);
  n5 := StrToIntDef(num[5], 0);
  n6 := StrToIntDef(num[6], 0);
  n7 := StrToIntDef(num[7], 0);
  n8 := StrToIntDef(num[8], 0);
  n9 := StrToIntDef(num[9], 0);
  d1 := n9 * 2 + n8 * 3 + n7 * 4 + n6 * 5 + n5 * 6 + n4 * 7 + n3 * 8 + n2 * 9 + n1 * 10;
  d1 := 11 - (d1 mod 11);
  if d1 >= 10 then
    d1 := 0;
  d2 := d1 * 2 + n9 * 3 + n8 * 4 + n7 * 5 + n6 * 6 + n5 * 7 + n4 * 8 + n3 * 9 + n2 * 10 + n1 * 11;
  d2 := 11 - (d2 mod 11);
  if d2 >= 10 then
    d2 := 0;
  calculado := inttostr(d1) + inttostr(d2);
  digitado := num[10] + num[11];
  if calculado = digitado then
    Result := true
  else
    Result := false;

end;

//Formata CPF ou CNPJ
function FormataCPF_CNPJ(edvalor: string): string;
var
  FormatarCNPJ: string;
  FormatarCPF: string;
begin
  Result := edvalor;
  if Length(edvalor) <> 0 then
    if Length(edvalor) = 14 then
    begin
      if cnpj(edvalor) = True then
      begin
        FormatarCNPJ := Copy(edvalor, 1, 2) + '.' + Copy(edvalor, 3, 3) + '.' + Copy(edvalor, 6, 3) + '/' + Copy(edvalor, 9, 4) + '-' + Copy(edvalor, 13, 2);
        edvalor := FormatarCNPJ;
      end
      else
      begin
        raise Exception.Create('CNPJ com erro. favor verificar');
      end;
    end
    else if Length(edvalor) = 11 then
    begin
      if cpf(edvalor) = True then
      begin
        FormatarCPF := Copy(edvalor, 1, 3) + '.' + Copy(edvalor, 4, 3) + '.' + Copy(edvalor, 7, 3) + '-' + Copy(edvalor, 10, 2);
        edvalor := FormatarCPF;
      end
      else
      begin
        raise Exception.Create('CPF com erro. favor verificar');
      end;
    end
    else
    begin
      raise Exception.Create('O CPF tem 11 nº e CNPJ tem 14 nº.'#13'Prencha com números');
    end;
  Result := edvalor;
end;

end.

