<#
.SYNOPSIS
    Audita as funcoes GLOBAIS do legado Fortyus que os VCX chamam e que NAO
    existem no projeto novo.

.DESCRIPTION
    Os VCX legado (framework.vcx / classresp.vcx / classobj.vcx) sao p-code
    COMPILADO: nao da para editar. Eles chamam funcoes globais da aplicacao
    legado (sig.prg / SIGFUNCS.PRG) que NAO vieram no acervo migrado -
    fSQLExec, fChkCpoVlc, fValidarCpf, fGravarLog, fConfigGeral...

    Em VFP9, nome desconhecido seguido de "(" NAO eh erro de compilacao: o
    interpretador procura <nome>.prg no PATH. Ou seja, a ausencia so aparece em
    RUNTIME - e quase sempre dentro de um Init / Valid / Click, FORA de qualquer
    TRY/CATCH, onde a excecao nao tratada DERRUBA O FORM.

    Foi o Erro163_Aba1: o campo UF do Cadastro de Cliente fechava a tela porque
    clsconta...GetEstado.Valid faz CreateObject('fwBuscaExt', ...) SEM o guard
    Type()=='O' que o GetCEP tem, e o Init do fwBuscaExt chama fSQLExec().

    O texto-fonte dos metodos VIVE no arquivo .VCT (memo do VCX), entao da para
    varrer as chamadas sem abrir o VFP. Eh o que este script faz.

.PARAMETER FrameworkDir
    Pasta dos VCX/VCT legado. Default C:\4c\Framework (ignora Framework_old).

.PARAMETER ProjetoDir
    Raiz do projeto novo. Default C:\4c\projeto\app.

.PARAMETER TodosVCT
    Por default varre SO os VCX que o projeto realmente carrega (descobertos
    pelos SET CLASSLIB dos .prg de $ProjetoDir). Com este switch, varre todos os
    .VCT da pasta - util para investigar, RUIDOSO para auditar: o memo dos VCX
    de terceiro (ReportPreview\listener, _frxcursor, ClassGdi/_gdiplus, SFCTRLS,
    ClassScrl) guarda TEXTO DE DESCRICAO das propriedades e ate XSLT, onde
    "floor(", "format(", "files(" casam com o regex sem serem chamada nenhuma.

.PARAMETER Prefixo
    Regex do prefixo de nome a auditar. Default "f" - a convencao de nomes das
    funcoes globais Fortyus. Use "." para auditar TODO identificador (bem mais
    ruidoso: pega palavra de comentario, keyword de SQL e nome de cursor).

.PARAMETER MostrarResolvidas
    Lista tambem as que JA existem, com o arquivo que as define.

.EXAMPLE
    powershell -ExecutionPolicy Bypass -File C:\4c\automation\VerificarFuncoesLegadoVCX.ps1

.NOTES
    Como CORRIGIR o que este script acusar: criar um wrapper
    projeto\app\utils\<nome minusculo>.prg, no padrao de isempty.prg /
    fconfiggeral.prg (LPARAMETERS + RETURN, SEM cabecalho FUNCTION - o arquivo
    eh resolvido pelo NOME). O cabecalho de comentario tem de dizer de onde vem
    a chamada e o que se perde.

    NAO criar stub que devolve VALOR DE CALCULO (fCalcularST / fCalcularIPI):
    devolver 0 grava imposto errado sem erro nenhum na tela - regra #17 do
    CLAUDE.md. Nesses casos, deixar ausente eh mais seguro: o erro aparece alto.

    Origem: Erro163_Aba1 (2026-09-18). Regras #13 e #26 do CLAUDE.md.
#>
[CmdletBinding()]
param(
    [string]$FrameworkDir = 'C:\4c\Framework',
    [string]$ProjetoDir   = 'C:\4c\projeto\app',
    [string]$Prefixo      = 'f',
    [switch]$TodosVCT,
    [switch]$MostrarResolvidas
)

$ErrorActionPreference = 'Stop'

# -- Funcoes NATIVAS do VFP9 que comecam com F (nao sao do legado) -------------
$builtins = @(
    'fchsize','fclose','fcount','fcreate','fdate','feof','ferror','fflush',
    'fgets','field','file','filetostr','filter','fklabel','fkmax','fldlist',
    'flock','fontmetric','fopen','forceext','forcepath','for','found','fputs',
    'fread','fseek','fsize','ftime','fulltrim','fullpath','fv','fwrite',
    'from','func','function'
) | ForEach-Object { $_.ToLower() }
$builtinSet = @{}
$builtins | ForEach-Object { $builtinSet[$_] = $true }

# -- O que o projeto novo JA define -------------------------------------------
Write-Host "Mapeando o que o projeto ja define..." -ForegroundColor Cyan
$definidas = @{}

$fontes = @()
$fontes += Get-ChildItem -Path $ProjetoDir -Recurse -Include *.prg,*.PRG -File -ErrorAction SilentlyContinue |
           Where-Object { $_.Name -notmatch '\.bak' }
# ATENCAO: -Include sem -Recurse so funciona com wildcard no -Path. Sem o '\*'
# esta linha devolve ZERO em silencio e sigacess.PRG (fAcessoCampos,
# fAcessoEmpresa, fChecaAcessoJOB) aparece como "ausente" - falso positivo.
$fontes += Get-ChildItem -Path (Join-Path $FrameworkDir '*') -Include *.prg,*.PRG -File -ErrorAction SilentlyContinue

foreach ($f in $fontes) {
    # (a) cabecalho FUNCTION/PROCEDURE
    $txt = Get-Content -LiteralPath $f.FullName -Raw -ErrorAction SilentlyContinue
    if ($txt) {
        foreach ($m in [regex]::Matches($txt, '(?im)^\s*(?:FUNCTION|PROCEDURE)\s+([A-Za-z_][A-Za-z0-9_]*)')) {
            $n = $m.Groups[1].Value.ToLower()
            if (-not $definidas.ContainsKey($n)) { $definidas[$n] = $f.Name }
        }
    }
    # (b) wrapper resolvido pelo NOME DO ARQUIVO (padrao isempty.prg)
    $bn = $f.BaseName.ToLower()
    if (-not $definidas.ContainsKey($bn)) { $definidas[$bn] = $f.Name }
}
Write-Host "  $($definidas.Count) nomes resolviveis." -ForegroundColor DarkGray

# -- Varredura dos .VCT --------------------------------------------------------
$vcts = Get-ChildItem -Path $FrameworkDir -Recurse -Include *.vct,*.VCT -File -ErrorAction SilentlyContinue |
        Where-Object { $_.FullName -notmatch '\\Framework_old\\' }

if (-not $TodosVCT) {
    # So os VCX que o projeto carrega de fato (SET CLASSLIB nos .prg). O que o
    # sistema nunca instancia nao pode derrubar tela nenhuma - e os VCX de
    # terceiro enchem o relatorio de falso positivo (ver .PARAMETER TodosVCT).
    $carregados = @{}
    foreach ($p in $fontes) {
        if ($p.FullName -notlike "$ProjetoDir*") { continue }
        $t = Get-Content -LiteralPath $p.FullName -Raw -ErrorAction SilentlyContinue
        if (-not $t) { continue }
        foreach ($m in [regex]::Matches($t, '(?i)([A-Za-z0-9_]+)\.vcx')) {
            $carregados[$m.Groups[1].Value.ToLower()] = $true
        }
    }
    if ($carregados.Count) {
        Write-Host ("  VCX carregados pelo projeto: " + (($carregados.Keys | Sort-Object) -join ', ')) -ForegroundColor DarkGray
        $vcts = $vcts | Where-Object { $carregados.ContainsKey($_.BaseName.ToLower()) }
    }
}

if (-not $vcts) {
    Write-Host "Nenhum .VCT a varrer em $FrameworkDir" -ForegroundColor Red
    exit 2
}

$enc      = [System.Text.Encoding]::GetEncoding(1252)
$regex    = "(?<![\.\w&])($Prefixo[A-Za-z][A-Za-z0-9_]{2,})\s*\("
$achados  = @{}

Write-Host "Varrendo $($vcts.Count) arquivo(s) .VCT..." -ForegroundColor Cyan
foreach ($v in $vcts) {
    $s = $enc.GetString([System.IO.File]::ReadAllBytes($v.FullName))
    foreach ($m in [regex]::Matches($s, $regex)) {
        $nome = $m.Groups[1].Value
        $key  = $nome.ToLower()
        if ($builtinSet.ContainsKey($key)) { continue }

        # Chamada COMENTADA nao executa. O memo do VCX guarda o fonte inteiro,
        # comentario incluso: sem este filtro o fGravaLog do listener.vcx (41
        # "chamadas", todas em linha *!*) entra no relatorio como pendencia.
        $ini = $s.LastIndexOfAny([char[]]@("`r", "`n"), $m.Index) + 1
        $pre = $s.Substring($ini, $m.Index - $ini)
        if ($pre.TrimStart() -match '^(\*|&&)') { continue }
        if ($pre -match '&&') { continue }

        if (-not $achados.ContainsKey($key)) {
            # guarda o primeiro trecho legivel como evidencia
            $ini     = [Math]::Max(0, $m.Index - 150)
            $ctx     = $s.Substring($ini, [Math]::Min(260, $s.Length - $ini))
            $ctx     = ($ctx -replace '[^\x20-\x7E]', ' ') -replace '\s{2,}', ' '
            $achados[$key] = [PSCustomObject]@{
                Nome     = $nome
                Arquivos = New-Object System.Collections.Generic.List[string]
                Chamadas = 0
                Contexto = $ctx.Trim()
            }
        }
        $achados[$key].Chamadas++
        if (-not $achados[$key].Arquivos.Contains($v.Name)) {
            $achados[$key].Arquivos.Add($v.Name)
        }
    }
}

# -- Ausencias DELIBERADAS -----------------------------------------------------
# Nao eh "ainda nao fizemos": eh "fazer seria pior". Sao funcoes que devolvem
# VALOR DE CALCULO; um stub devolvendo 0 gravaria imposto errado sem erro nenhum
# na tela (regra #17 do CLAUDE.md). Ausente, o erro aparece alto e claro.
# Ao portar a de verdade a partir do fonte legado, TIRAR daqui.
$deliberadas = @{
    'fcalcularst'  = 'Substituicao Tributaria - regra fiscal, so TRANSCREVER do legado (regra #17)'
    'fcalcularipi' = 'IPI - regra fiscal, so TRANSCREVER do legado (regra #17)'
}

# -- Relatorio -----------------------------------------------------------------
$ausentes  = @()
$conhecidas= @()
$presentes = @()
foreach ($k in ($achados.Keys | Sort-Object)) {
    if ($definidas.ContainsKey($k)) {
        $presentes += [PSCustomObject]@{ Funcao = $achados[$k].Nome; Definida = $definidas[$k] }
    } elseif ($deliberadas.ContainsKey($k)) {
        $conhecidas += [PSCustomObject]@{ Funcao = $achados[$k].Nome; Motivo = $deliberadas[$k] }
    } else {
        $ausentes += $achados[$k]
    }
}

Write-Host ""
Write-Host "================================================================" -ForegroundColor Yellow
Write-Host " FUNCOES GLOBAIS LEGADO CHAMADAS PELOS VCX" -ForegroundColor Yellow
Write-Host "================================================================" -ForegroundColor Yellow
Write-Host " Chamadas distintas encontradas : $($achados.Count)"
Write-Host " Ja resolvidas no projeto       : $($presentes.Count)"
Write-Host " Ausentes DE PROPOSITO          : $($conhecidas.Count)"
Write-Host " AUSENTES (quebram em runtime)  : $($ausentes.Count)" -ForegroundColor $(if ($ausentes.Count) { 'Red' } else { 'Green' })
Write-Host ""

if ($conhecidas.Count) {
    Write-Host "-- AUSENTES DE PROPOSITO (nao sao pendencia) -------------------" -ForegroundColor DarkYellow
    $conhecidas | ForEach-Object { "  {0,-16} {1}" -f $_.Funcao, $_.Motivo }
    Write-Host ""
}

if ($MostrarResolvidas -and $presentes.Count) {
    Write-Host "-- RESOLVIDAS --------------------------------------------------" -ForegroundColor DarkGray
    $presentes | ForEach-Object { "  {0,-22} -> {1}" -f $_.Funcao, $_.Definida }
    Write-Host ""
}

if ($ausentes.Count) {
    Write-Host "-- AUSENTES ----------------------------------------------------" -ForegroundColor Red
    foreach ($a in $ausentes) {
        Write-Host ("  {0,-18} {1,3} chamada(s)  em {2}" -f $a.Nome, $a.Chamadas, ($a.Arquivos -join ', ')) -ForegroundColor Red
        Write-Host ("      call site: ..." + $a.Contexto) -ForegroundColor DarkGray
        Write-Host ("      fix      : criar projeto\app\utils\{0}.prg (padrao isempty.prg)" -f $a.Nome.ToLower()) -ForegroundColor DarkGray
        Write-Host ""
    }
    Write-Host "ATENCAO: se a funcao devolve VALOR DE CALCULO (imposto, preco,"  -ForegroundColor Yellow
    Write-Host "prazo), NAO criar stub devolvendo 0 - grava numero errado em"     -ForegroundColor Yellow
    Write-Host "silencio (regra #17). Deixar ausente eh mais seguro."             -ForegroundColor Yellow
    exit 1
}

Write-Host "Nenhuma funcao global legado ausente." -ForegroundColor Green
exit 0
