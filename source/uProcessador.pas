unit uProcessador;

interface

type
  TTipoTamanho = (ttKB, ttMB);
  TDividirAuxiliar = record
    tamanho: double;
    tipotamanho: TTipoTamanho;
    arquivo: string;
    salvarmesmolocal: boolean;
    substituir: boolean;
    excluirorigem: boolean;
  end;

function ProcessarDivisao(Parametros: TDividirAuxiliar): boolean;

implementation

function ProcessarDivisao(Parametros: TDividirAuxiliar): boolean;
begin
  Result := false;
end;

end.
