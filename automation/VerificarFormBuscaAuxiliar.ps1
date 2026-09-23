<#
===============================================================================
 VerificarFormBuscaAuxiliar.ps1

 Acusa CREATEOBJECT("FormBuscaAuxiliar", ...) cujo PRIMEIRO argumento nao eh o
 handle da conexao.

 MOTIVO (Erro172, 2026-09-23):
   A assinatura real eh
     Init(par_nConn, par_cTabela, par_cCursor, par_cCampo, par_cValor,
          par_cTitulo, par_lBuscaExata, par_lMostraGrid, par_cFiltro)
   e o 1o parametro eh o HANDLE (gnConnHandle). Passar a tabela ali desloca
   TODOS os argumentos: par_cTabela recebe o nome da COLUNA, par_cCursor recebe
   o titulo, e o picker consulta uma "tabela" que nao existe. NAO ha erro de
   compilacao e NAO ha excecao: o Init tem
       IF VARTYPE(par_cTabela) != "C"
           RETURN .T.
   entao com string em tudo ele segue adiante e o usuario ve um picker vazio.

 ATENCAO ao escrever/alterar este script - a 1a versao acusou 95 sites, sendo
 ~86 FALSOS POSITIVOS, por dois motivos que QUALQUER auditoria deste projeto
 precisa tratar:
   1. CONTINUACAO DE LINHA: a forma dominante eh
          loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
              gnConnHandle, "SigCdMoe", ...)
      o 1o argumento esta na linha SEGUINTE. Sem juntar as continuacoes, o
      script le argumento vazio e acusa tudo.
   2. PARENTESE FINAL: em `CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle)` o
      1o argumento vem como "gnConnHandle)" e nao casa com ^gnConnHandle$.

 Sem auto-fix: o argumento certo (tabela, cursor, campo) depende do dump do
 legado de cada tela, e varios sites querem reusar um cursor JA populado.

 Uso:
   .\VerificarFormBuscaAuxiliar.ps1                 # todo projeto\app
   .\VerificarFormBuscaAuxiliar.ps1 -Caminho <.prg> # um arquivo

 Exit code: 1 se houver achado, 0 caso contrario.
===============================================================================
#>
[CmdletBinding()]
param([string] $Caminho = 'C:\4c\projeto\app')

$ErrorActionPreference = 'Stop'

$arquivos = if (Test-Path $Caminho -PathType Leaf) {
    @(Get-Item $Caminho)
} else {
    Get-ChildItem -Path $Caminho -Filter '*.prg' -Recurse |
        Where-Object { $_.FullName -notmatch 'backup' -and $_.Name -notmatch '\.bak$' }
}

$achados = @()

foreach ($f in $arquivos) {
    $linhas = Get-Content $f.FullName

    for ($i = 0; $i -lt $linhas.Count; $i++) {
        if ($linhas[$i].Trim().StartsWith('*')) { continue }
        if ($linhas[$i] -notmatch '(?i)CREATEOBJECT\s*\(\s*"FormBuscaAuxiliar"') { continue }

        # junta as linhas de continuacao (` ;` no fim) ate fechar a chamada
        $junta = $linhas[$i]
        $j = $i
        while ($junta -match ';\s*$' -and $j + 1 -lt $linhas.Count) {
            $junta = ($junta -replace ';\s*$', ' ') + $linhas[$j + 1].Trim()
            $j++
        }

        $m = [regex]::Match($junta, '(?i)CREATEOBJECT\s*\(\s*"FormBuscaAuxiliar"\s*,\s*(.+)$')
        if (-not $m.Success) {
            # CREATEOBJECT("FormBuscaAuxiliar") sem argumento nenhum: modo manual,
            # documentado e fora do escopo deste check
            continue
        }

        # 1o argumento = ate a proxima virgula de TOPO (ignora virgula dentro de
        # parenteses, ex.: IIF(a, b, c)), e sem o parentese que fecha a chamada
        $resto = $m.Groups[1].Value
        $prof = 0
        $prim = ''
        foreach ($ch in $resto.ToCharArray()) {
            if ($ch -eq '(') { $prof++ }
            elseif ($ch -eq ')') { if ($prof -eq 0) { break }; $prof-- }
            elseif ($ch -eq ',' -and $prof -eq 0) { break }
            $prim += $ch
        }
        $primeiro = $prim.Trim()
        if ($primeiro -eq '') { continue }

        # aceitos: gnConnHandle, variavel numerica da convencao, literal numerico
        $ok = ($primeiro -match '(?i)^(m\.)?gnConnHandle$') -or
              ($primeiro -match '(?i)^(m\.)?(loc_n|par_n|this_n)[A-Za-z0-9_]*$') -or
              ($primeiro -match '^\d+$')

        if (-not $ok) {
            $achados += [pscustomobject]@{
                Arquivo = $f.FullName; Linha = $i + 1; Primeiro = $primeiro
                Texto = ($junta.Trim() -replace '\s+', ' ')
            }
        }
        $i = $j   # nao reprocessa as linhas de continuacao
    }
}

if ($achados.Count -eq 0) {
    Write-Host "[BUSCA-AUX] OK - todo CREATEOBJECT(FormBuscaAuxiliar) comeca pelo handle" -ForegroundColor Green
    exit 0
}

Write-Host "[BUSCA-AUX] $($achados.Count) chamada(s) com o 1o argumento errado:" -ForegroundColor Red
foreach ($a in $achados) {
    Write-Host ("  {0}:{1}  1o arg = {2}" -f (Split-Path $a.Arquivo -Leaf), $a.Linha, $a.Primeiro) -ForegroundColor Red
    $amostra = $a.Texto
    if ($amostra.Length -gt 130) { $amostra = $amostra.Substring(0, 130) + '...' }
    Write-Host ("      {0}" -f $amostra) -ForegroundColor DarkGray
}
Write-Host ""
Write-Host "O 1o parametro do Init eh par_nConn (gnConnHandle). Passar a tabela ali desloca" -ForegroundColor Yellow
Write-Host "TODOS os argumentos - compila limpo, nao estoura, e o picker abre vazio." -ForegroundColor Yellow
exit 1
