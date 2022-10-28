unit UClasseServidor;

interface

uses
  System.Classes;

type
    {$METHODINFO ON}
  TClasseServidor = class(TComponent)
    function test: string;
  end;
    {$METHODINFO OFF}

implementation

{ TClasseServidor }

function TClasseServidor.test: string;
begin
  Result := 'Ok!';
end;

end.

