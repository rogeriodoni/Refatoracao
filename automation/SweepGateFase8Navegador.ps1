# =============================================================================
# SweepGateFase8Navegador.ps1
#
# Mede o BLAST RADIUS do 15o ramo do gate da Fase 8 ($legadoNavegadorPaiF8,
# 2026-10-30, task714/SIGOPCRP) comparando o VEREDITO COMPLETO da fase, dump a
# dump, entre duas versoes do orquestrador:
#
#   NOVO    - o arquivo real (com o ramo);
#   SEM     - copia identica com o ramo neutralizado (" -and $false"), que eh o
#             controle negativo exato: isola SO esta mudanca, sem arrastar as
#             outras alteracoes nao commitadas do arquivo.
#
# Medir o HELPER isolado nao basta: o que importa eh o veredito
# (feedback_token_grade_de_outro_form_derruba_ramo_captura). A conta tem de
# fechar - passam_depois = passam_antes + mudaram, com regressoes = 0.
#
# Nao executa o orquestrador: extrai as funcoes e o bloco `case 8` via
# AST/linha (dot-source dispararia uma migracao real -
# feedback_dot_source_orquestrador_dispara_migracao).
# =============================================================================
param(
    [string]$Novo      = 'C:\4c\automation\OrquestradorMigracao.ps1',
    [string]$TasksDir  = 'C:\4c\tasks',
    [string]$ProjetoDir = 'C:\4c\projeto',
    [int]$LinhaInicio  = 9873,
    [int]$LinhaFim     = 11902,
    # Julga o .prg pelo CODIGO, nao pela PROSA: remove de cada form as linhas
    # de COMENTARIO que citam os nomes dispensados. O gate usa -notmatch SOLTO,
    # entao o cabecalho que EXPLICA por que BtnCancelarClick/CarregarLista nao
    # se aplicam satisfaz a exigencia por coincidencia
    # (feedback_comentario_citando_nome_satisfaz_gate) e esconde o efeito real
    # do ramo. Sem este modo, "mudaram = 0" fica indistinguivel de harness que
    # nao mediu nada.
    [switch]$SemCitacao
)

$ErrorActionPreference = 'Stop'

# ---------- controle negativo: copia com o ramo neutralizado ----------
$enc    = [System.Text.Encoding]::GetEncoding(28591)
$ancora = '                                             $temSuperficieNavegadorF8)'
$txtNovo = [System.IO.File]::ReadAllText($Novo, $enc)
$nAnc = ([regex]::Matches($txtNovo, [regex]::Escape($ancora))).Count
if ($nAnc -ne 1) { Write-Host "ANCORA x$nAnc - abortando"; exit 1 }
$semRamo = Join-Path $env:TEMP 'Orq_SEM_RAMO_sweep.ps1'
[System.IO.File]::WriteAllText($semRamo, $txtNovo.Replace($ancora, $ancora + ' -and $false'), $enc)

function Get-BlocoCase8 {
    param([string]$Arquivo)
    $errs = $null
    [System.Management.Automation.Language.Parser]::ParseFile($Arquivo, [ref]$null, [ref]$errs) | Out-Null
    if ($errs -and $errs.Count -gt 0) { throw "parse de $Arquivo falhou ($($errs.Count) erro(s))" }

    $ls = Get-Content $Arquivo
    $bl = $ls[($LinhaInicio - 1)..($LinhaFim - 1)]
    if ($bl[0] -notmatch '^\s*8\s*\{\s*$')  { throw "ancora inicial errada em $Arquivo" }
    if ($bl[-1] -notmatch '^\s*\}\s*$')     { throw "ancora final errada em $Arquivo" }
    $corpo = ($bl[1..($bl.Count - 2)] -join "`r`n")
    $e2 = $null
    [System.Management.Automation.Language.Parser]::ParseInput($corpo, [ref]$null, [ref]$e2) | Out-Null
    if ($e2 -and $e2.Count -gt 0) { throw "recorte invalido em $Arquivo" }
    return [scriptblock]::Create($corpo)
}

# Helpers: carregados UMA vez, da versao NOVA (sao identicos nas duas copias -
# a neutralizacao mexe so no predicado do ramo).
$ast = [System.Management.Automation.Language.Parser]::ParseFile($Novo, [ref]$null, [ref]$null)
foreach ($f in $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)) {
    . ([scriptblock]::Create($f.Extent.Text))
}

$sbNovo = Get-BlocoCase8 -Arquivo $Novo
$sbSem  = Get-BlocoCase8 -Arquivo $semRamo

# ---------- indice dos forms migrados, por nome de classe ----------
$porClasse = @{}
foreach ($d in @('cadastros','relatorios','operacionais')) {
    $dir = Join-Path $ProjetoDir "app\forms\$d"
    if (-not (Test-Path $dir)) { continue }
    foreach ($p in (Get-ChildItem $dir -Filter '*.prg' -File)) {
        $t = Get-Content $p.FullName -Raw -ErrorAction SilentlyContinue
        if (-not $t) { continue }
        foreach ($m in [regex]::Matches($t, '(?im)^\s*DEFINE\s+CLASS\s+(\w+)\s+AS\s+\w+')) {
            $k = $m.Groups[1].Value.ToUpper()
            if (-not $porClasse.ContainsKey($k)) {
                $porClasse[$k] = [pscustomobject]@{ Caminho = $p.FullName; Tipo = $d }
            }
        }
    }
}
Write-Host ("CLASSES DE FORM INDEXADAS = {0}" -f $porClasse.Count)

$tipoPorPasta = @{ 'cadastros' = 'CRUD'; 'relatorios' = 'REPORT'; 'operacionais' = 'OPERACIONAL' }

$dumps = Get-ChildItem $TasksDir -Recurse -Filter '*_form_codigo_fonte.txt' -File -ErrorAction SilentlyContinue
Write-Host ("DUMPS = {0}" -f $dumps.Count)

$avaliados = 0; $semForm = 0
$passAntes = 0; $passDepois = 0
$mudaram = @(); $regressoes = @()

foreach ($d in $dumps) {
    $base = $d.Name -replace '_form_codigo_fonte\.txt$', ''
    $cand = @("FORM$($base.ToUpper())", $base.ToUpper())
    $reg = $null
    foreach ($c in $cand) { if ($porClasse.ContainsKey($c)) { $reg = $porClasse[$c]; break } }
    if (-not $reg) { $semForm++; continue }

    # Contexto que o bloco `case 8` consome.
    $TaskPath  = $d.Directory.FullName
    $BaseName  = $base
    $formFile  = $reg.Caminho
    $formClass = [System.IO.Path]::GetFileNameWithoutExtension($formFile)
    $boClass   = "$($base)BO"
    $FormType  = $tipoPorPasta[$reg.Tipo]

    if ($SemCitacao) {
        $linhasPrg = [System.IO.File]::ReadAllLines($formFile, $enc)
        $filtradas = @($linhasPrg | Where-Object {
            -not ($_ -match '^\s*\*' -and $_ -match '(?i)(BtnCancelarClick|CarregarLista)')
        })
        if ($filtradas.Count -ne $linhasPrg.Count) {
            $tmpPrg = Join-Path $env:TEMP ("sweepF8_" + [System.IO.Path]::GetFileName($formFile))
            [System.IO.File]::WriteAllLines($tmpPrg, $filtradas, $enc)
            $formFile = $tmpPrg
        }
    }

    $avaliados++

    $validado = $false; $metodosFaltantes = @()
    try { . $sbSem } catch { }
    $antes = $validado

    $validado = $false; $metodosFaltantes = @()
    try { . $sbNovo } catch { }
    $depois = $validado

    if ($antes)  { $passAntes++ }
    if ($depois) { $passDepois++ }
    if ($antes -ne $depois) {
        if ($depois) { $mudaram    += "$base ($($d.Directory.Name))" }
        else         { $regressoes += "$base ($($d.Directory.Name))" }
    }
}

Write-Host ""
Write-Host "=== VEREDITO COMPLETO DA FASE 8 ==="
Write-Host ("dumps avaliados   = {0}   (sem form migrado: {1})" -f $avaliados, $semForm)
Write-Host ("passavam_antes    = {0}" -f $passAntes)
Write-Host ("passam_depois     = {0}" -f $passDepois)
Write-Host ("mudaram (REPROVA -> PASSA) = {0}" -f $mudaram.Count)
foreach ($m in $mudaram) { Write-Host "    + $m" }
Write-Host ("REGRESSOES (PASSA -> REPROVA) = {0}" -f $regressoes.Count)
foreach ($r in $regressoes) { Write-Host "    - $r" }
Write-Host ""
if ($passDepois -eq ($passAntes + $mudaram.Count) -and $regressoes.Count -eq 0) {
    Write-Host "CONTA FECHA: passam_depois = passavam_antes + mudaram, regressoes = 0" -ForegroundColor Green
    exit 0
} else {
    Write-Host "CONTA NAO FECHA - revisar" -ForegroundColor Red
    exit 1
}
