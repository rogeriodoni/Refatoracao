# =============================================================================
# SweepGateFase8ToolTip.ps1
#
# Mede o BLAST RADIUS da fonte TOOLTIPTEXT acrescentada em
# Test-AcaoDoLegadoTemHandler (2026-11-09, task772/SIGOPNOP), comparando o
# VEREDITO COMPLETO da Fase 8, dump a dump, entre duas versoes do orquestrador:
#
#   NOVO - o arquivo real (colhe o verbo tambem do ToolTipText, no nivel do
#          objeto E no do membro de CommandGroup);
#   SEM  - copia identica com AS DUAS adicoes neutralizadas, que eh o controle
#          negativo exato: isola SO esta mudanca, sem arrastar as outras
#          alteracoes nao commitadas do arquivo.
#
# Medir o HELPER isolado nao basta: o que importa eh o veredito da FASE
# (feedback_token_grade_de_outro_form_derruba_ramo_captura). A conta tem de
# fechar - passam_depois = passam_antes + mudaram, com regressoes = 0.
# A monotonia garante regressoes = 0 por construcao (a fonte nova so
# ACRESCENTA candidato, e o unico consumidor eh
# "-not $legadoSemAcao -> $metodosFaltantes +="), mas isso se MEDE.
#
# Nao executa o orquestrador: extrai as funcoes e o bloco `case 8` via
# AST/linha (dot-source dispararia uma migracao real -
# feedback_dot_source_orquestrador_dispara_migracao).
#
# Mesmo molde de SweepGateFase8Navegador.ps1 (fonte unica do harness).
# =============================================================================
param(
    [string]$Novo       = 'C:\4c\automation\OrquestradorMigracao.ps1',
    [string]$TasksDir   = 'C:\4c\tasks',
    [string]$ProjetoDir = 'C:\4c\projeto',
    [int]$LinhaInicio   = 11275,
    [int]$LinhaFim      = 13800,
    # Julga o .prg pelo CODIGO, nao pela PROSA (ver SweepGateFase8Navegador).
    [switch]$SemCitacao
)

$ErrorActionPreference = 'Stop'

# ---------- controle negativo: copia com as DUAS adicoes neutralizadas ------
$enc     = [System.Text.Encoding]::GetEncoding(28591)
$txtNovo = [System.IO.File]::ReadAllText($Novo, $enc)

$ancTooltip = '        [void]$brutos.Add($tooltip)'
$ancMembro  = "'(?im)^\s*\w+\.(?:Name|Caption|ToolTipText)\s*=\s*`"([^`"]*)`"'"

foreach ($a in @($ancTooltip, $ancMembro)) {
    $n = ([regex]::Matches($txtNovo, [regex]::Escape($a))).Count
    if ($n -ne 1) { Write-Host ("ANCORA x{0} - abortando: [{1}]" -f $n, $a); exit 1 }
}

$txtSem = $txtNovo.Replace($ancTooltip, '        # [void]$brutos.Add($tooltip)   # NEUTRALIZADO pelo sweep')
$txtSem = $txtSem.Replace($ancMembro, "'(?im)^\s*\w+\.(?:Name|Caption)\s*=\s*`"([^`"]*)`"'")

$semFonte = Join-Path $env:TEMP 'Orq_SEM_TOOLTIP_sweep.ps1'
[System.IO.File]::WriteAllText($semFonte, $txtSem, $enc)

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

# O bloco `case 8` eh o MESMO nas duas copias (a neutralizacao mexe so no
# helper), mas os HELPERS nao sao - e redefinir uma funcao sobrescreve a
# anterior. Por isso cada lado roda em sua propria passada, recarregando os
# helpers da copia correspondente.
#
# ATENCAO: esta funcao TEM de ser chamada com DOT-SOURCE (". Import-Helpers
# -Arquivo x") e a partir do escopo de SCRIPT. Chamada normal, o dot-source de
# dentro dela definiria as funcoes no escopo DELA, que morre no return - e o
# bloco `case 8` passaria a estourar em toda chamada de helper, caindo no
# "try {} catch {}" e devolvendo $false para TODO mundo. O sintoma eh traicoeiro:
# o sweep fecha a conta com "mudaram = 0" e parece prova de que a mudanca nao
# tem alcance, quando na verdade nao mediu nada.
function Import-Helpers {
    param([string]$Arquivo)
    $ast = [System.Management.Automation.Language.Parser]::ParseFile($Arquivo, [ref]$null, [ref]$null)
    foreach ($f in $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)) {
        . ([scriptblock]::Create($f.Extent.Text))
    }
}

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

# Monta a lista de casos UMA vez (o contexto nao depende da copia do gate).
$casos = @()
$semForm = 0
foreach ($d in $dumps) {
    $base = $d.Name -replace '_form_codigo_fonte\.txt$', ''
    $cand = @("FORM$($base.ToUpper())", $base.ToUpper())
    $reg = $null
    foreach ($c in $cand) { if ($porClasse.ContainsKey($c)) { $reg = $porClasse[$c]; break } }
    if (-not $reg) { $semForm++; continue }

    $ff = $reg.Caminho
    if ($SemCitacao) {
        $linhasPrg = [System.IO.File]::ReadAllLines($ff, $enc)
        $filtradas = @($linhasPrg | Where-Object {
            -not ($_ -match '^\s*\*' -and $_ -match '(?i)(BtnCancelarClick|CarregarLista)')
        })
        if ($filtradas.Count -ne $linhasPrg.Count) {
            $tmpPrg = Join-Path $env:TEMP ("sweepF8tt_" + [System.IO.Path]::GetFileName($ff))
            [System.IO.File]::WriteAllLines($tmpPrg, $filtradas, $enc)
            $ff = $tmpPrg
        }
    }

    $casos += [pscustomobject]@{
        Base      = $base
        Task      = $d.Directory.Name
        TaskPath  = $d.Directory.FullName
        FormFile  = $ff
        FormClass = [System.IO.Path]::GetFileNameWithoutExtension($reg.Caminho)
        BoClass   = "$($base)BO"
        FormType  = $tipoPorPasta[$reg.Tipo]
    }
}
Write-Host ("CASOS AVALIAVEIS = {0}   (sem form migrado: {1})" -f $casos.Count, $semForm)

function Measure-Lado {
    param([string]$Arquivo, $Casos)
    $sb = Get-BlocoCase8 -Arquivo $Arquivo
    $res = @{}
    foreach ($c in $Casos) {
        $TaskPath = $c.TaskPath; $BaseName = $c.Base; $formFile = $c.FormFile
        $formClass = $c.FormClass; $boClass = $c.BoClass; $FormType = $c.FormType
        $validado = $false; $metodosFaltantes = @()
        try { . $sb } catch { }
        $res[$c.Base + '|' + $c.Task] = $validado
    }
    return $res
}

. Import-Helpers -Arquivo $semFonte
$antes  = Measure-Lado -Arquivo $semFonte -Casos $casos

. Import-Helpers -Arquivo $Novo
$depois = Measure-Lado -Arquivo $Novo     -Casos $casos

# Sanidade: se os helpers nao estivessem carregados, TODO caso cairia no
# catch e $antes/$depois viriam todos $false - "mudaram = 0" seria falso
# negativo. Exige que o helper central esteja de fato visivel aqui.
if (-not (Get-Command Test-AcaoDoLegadoTemHandler -ErrorAction SilentlyContinue)) {
    Write-Host "HELPERS NAO CARREGADOS - medicao invalida" -ForegroundColor Red
    exit 1
}

$passAntes = 0; $passDepois = 0
$mudaram = @(); $regressoes = @()
foreach ($k in $antes.Keys) {
    if ($antes[$k])  { $passAntes++ }
    if ($depois[$k]) { $passDepois++ }
    if ($antes[$k] -ne $depois[$k]) {
        if ($depois[$k]) { $mudaram += $k } else { $regressoes += $k }
    }
}

Write-Host ""
Write-Host "=== VEREDITO COMPLETO DA FASE 8 ==="
Write-Host ("passavam_antes    = {0}" -f $passAntes)
Write-Host ("passam_depois     = {0}" -f $passDepois)
Write-Host ("mudaram (REPROVA -> PASSA) = {0}" -f $mudaram.Count)
foreach ($m in ($mudaram | Sort-Object)) { Write-Host "    + $m" }
Write-Host ("REGRESSOES (PASSA -> REPROVA) = {0}" -f $regressoes.Count)
foreach ($r in ($regressoes | Sort-Object)) { Write-Host "    - $r" }
Write-Host ""
if ($passDepois -eq ($passAntes + $mudaram.Count) -and $regressoes.Count -eq 0) {
    Write-Host "CONTA FECHA: passam_depois = passavam_antes + mudaram, regressoes = 0" -ForegroundColor Green
    exit 0
} else {
    Write-Host "CONTA NAO FECHA - revisar" -ForegroundColor Red
    exit 1
}
