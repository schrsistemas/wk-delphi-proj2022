unit UFuncoes.Texto;

interface

uses
  Windows, Classes, DateUtils, Math, Messages, SysUtils, StrUtils;

function LimpaNumeros(Str: string): string;

function Split(const Str: string; Delimiter: Char): TStringList;

function GravarTexto(Texto: string; dirArquivo: string): Boolean;

implementation

function GravarTexto(Texto: string; dirArquivo: string): Boolean;
var
  txt: TStringList;
begin
  txt := TStringList.Create;
  txt.Text := Texto;
  txt.SavetoFile(dirArquivo);
end;

function LimpaNumeros(Str: string): string;
var
  I: Integer;
begin
  Result := '';
    // for i  := 1 to Length(Str) - 1 do
  for I := 1 to Length(Str) do
  begin
    if Str[I] in ['0'..'9'] then
      Result := Result + Str[I];
  end;
end;

function Split(const Str: string; Delimiter: Char): TStringList;
begin
  Result := TStringList.Create;
  Result.LineBreak := Delimiter;
  Result.Text := Str;
end;

end.

