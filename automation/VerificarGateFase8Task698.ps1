<#
.SYNOPSIS
    Replica os predicados do gate da Fase 8 (case 8 de Invoke-MigracaoFase) para
    a task698 (SIGOPCHI -> FormSigOpChi), sem dot-sourcear o OrquestradorMigracao
    (dot-source dispara migracao).
.DESCRIPTION
    Confere, na mesma ordem do gate:
      1. os QUATRO nomes canonicos exigidos incondicionalmente
         (BtnCancelarClick / FormParaBO / BOParaForm / CarregarLista);
      2. $padraoAcaoGravar - o botao de ACAO com nome canonico;
      3. $legadoSemSalvar - o dump prova que o legado nao tem botao de gravar;
      4. Test-CompletudeCodigo - TODO/stub/procedure vazia no Form e no BO.
    Exit 0 quando tudo passa; exit 1 com a lista do que falta.
#>

$ErrorActionPreference = 'Stop'

$raiz     = 'C:\4c'
$formFile = Join-Path $raiz 'projeto\app\forms\operacionais\FormSigOpChi.prg'
$boFile   = Join-Path $raiz 'projeto\app\classes\SigOpChiBO.prg'
$dumpFile = Join-Path $raiz 'tasks\task698\SigOpChi_form_codigo_fonte.txt'

function Test-Completude {
    param([string]$Path, [string]$Descricao)

    $content = Get-Content $Path -Raw
    $problemas = @()

    foreach ($m in [regex]::Matches($content, "(?im)^\s*\*\-?\-?\s*(TODO|FIXME|HACK|XXX|PLACEHOLDER)\b")) {
        $problemas += "marcador: $($m.Value.Trim())"
    }
    $laterPattern = "(?im)\*.*?(implementar\s+(depois|later|futur)|pr[o" + [char]0xF3 + "]xima\s+fase|\bpendente|nao\s+implement)"
    foreach ($m in [regex]::Matches($content, $laterPattern)) {
        $problemas += "pendencia: $($m.Value.Trim())"
    }
    foreach ($m in [regex]::Matches($content, '(?im)MsgAviso\(.+?(implementad|ser.{1,5}\s+implementad|n.o\s+dispon.vel|em\s+desenvolvimento)')) {
        $problemas += "stub MsgAviso: $($m.Value.Trim())"
    }
    foreach ($m in [regex]::Matches($content, "(?ims)PROCEDURE\s+(\w+)\s*(\(.*?\))?\s*\r?\n(.*?)ENDPROC")) {
        $body = $m.Groups[3].Value
        if ($body -match "DODEFAULT\(\)") { continue }
        if ($m.Groups[1].Value -match "^Tecla" -and $m.Groups[2].Value -match "par_nKeyCode") { continue }
        $codeLines = ($body -split "`n" |
                      Where-Object { $_ -match "\S" -and $_ -notmatch "^\s*\*" -and $_ -notmatch "^\s*&&" } |
                      Measure-Object).Count
        if ($codeLines -eq 0) { $problemas += "procedure vazia: $($m.Groups[1].Value)" }
    }

    if ($problemas.Count -gt 0) {
        Write-Host ("  [COMPLETUDE] {0}: {1} problema(s)" -f $Descricao, $problemas.Count) -ForegroundColor Yellow
        $problemas | ForEach-Object { Write-Host "    - $_" -ForegroundColor Yellow }
        return $false
    }
    Write-Host ("  [OK] {0} - sem TODO/stub/procedure vazia" -f $Descricao) -ForegroundColor Green
    return $true
}

Write-Host "=== GATE FASE 8 - task698 (SIGOPCHI -> FormSigOpChi) ===" -ForegroundColor Cyan

$falhas = @()

foreach ($p in @($formFile, $boFile, $dumpFile)) {
    if (-not (Test-Path $p)) { $falhas += "arquivo ausente: $p" }
}
if ($falhas.Count -gt 0) {
    $falhas | ForEach-Object { Write-Host "  [ERRO] $_" -ForegroundColor Red }
    exit 1
}

$conteudo   = Get-Content $formFile -Raw
$txtLegadoF8 = Get-Content $dumpFile -Raw

# 1. Os quatro nomes canonicos (mesma checagem por substring do gate)
$metodosFinals = @("BtnCancelarClick", "FormParaBO", "BOParaForm", "CarregarLista")
$metodosFaltantes = @($metodosFinals | Where-Object { $conteudo -notmatch $_ })
if ($metodosFaltantes.Count -eq 0) {
    Write-Host "  [OK] quatro nomes canonicos presentes: $($metodosFinals -join ', ')" -ForegroundColor Green
} else {
    Write-Host "  [ERRO] nomes canonicos ausentes: $($metodosFaltantes -join ', ')" -ForegroundColor Red
    $falhas += "nomes canonicos: $($metodosFaltantes -join ', ')"
}

# Nome presente NAO basta: tem de ser DECLARACAO de metodo, com o escopo que
# FormBase impoe (FormParaBO/BOParaForm sao PROTECTED na base e VFP9 nao
# permite ALARGAR escopo de metodo herdado; CarregarLista eh chamado de FORA
# pelo TesteAutomatico e por isso tem de ser PUBLIC).
$declaracoes = @{
    'BtnCancelarClick' = '(?im)^\s*PROCEDURE\s+BtnCancelarClick\s*\('
    'FormParaBO'       = '(?im)^\s*PROTECTED\s+(PROCEDURE|FUNCTION)\s+FormParaBO\s*\('
    'BOParaForm'       = '(?im)^\s*PROTECTED\s+(PROCEDURE|FUNCTION)\s+BOParaForm\s*\('
    'CarregarLista'    = '(?im)^\s*(PROCEDURE|FUNCTION)\s+CarregarLista\s*\('
}
foreach ($nome in $declaracoes.Keys) {
    if ($conteudo -match $declaracoes[$nome]) {
        Write-Host "  [OK] $nome declarado com o escopo esperado" -ForegroundColor Green
    } else {
        Write-Host "  [ERRO] $nome nao tem declaracao com o escopo esperado" -ForegroundColor Red
        $falhas += "declaracao/escopo de $nome"
    }
}

# 2. Botao de ACAO com nome canonico
$padraoAcaoGravar = 'PROCEDURE\s+Btn(Salvar|Confirmar|Gravar|Processa|Aplicar|Executar|OK)\w*Click'
if ($conteudo -match $padraoAcaoGravar) {
    $m = [regex]::Match($conteudo, $padraoAcaoGravar)
    Write-Host "  [OK] botao de acao com nome canonico: $($m.Value.Trim())" -ForegroundColor Green
} else {
    Write-Host "  [ERRO] nenhum PROCEDURE Btn<verbo canonico>Click" -ForegroundColor Red
    $falhas += "botao de acao com nome canonico"
}

# 3. $legadoSemSalvar - o dump prova que o legado nao grava
$padroesSalvarLegado = @('btnSalvar', 'btnGravar', 'PROCEDURE\s+\w*(Salvar|Gravar)\w*\.Click', 'mGravaDados')
$achadosSalvar = @($padroesSalvarLegado | Where-Object { $txtLegadoF8 -match $_ })
if ($achadosSalvar.Count -eq 0) {
    Write-Host "  [OK] dump do legado nao tem botao/metodo de gravar - BtnSalvarClick nao se aplica" -ForegroundColor Green
} else {
    Write-Host "  [ERRO] dump TEM evidencia de gravacao ($($achadosSalvar -join ', ')) - BtnSalvarClick passa a ser exigido" -ForegroundColor Red
    $falhas += "legado tem botao de gravar"
}

# 4. Completude do Form e do BO
if (-not (Test-Completude -Path $formFile -Descricao "Form (FormSigOpChi)"))  { $falhas += "completude do Form" }
if (-not (Test-Completude -Path $boFile   -Descricao "BO (SigOpChiBO)"))      { $falhas += "completude do BO" }

Write-Host ""
if ($falhas.Count -eq 0) {
    Write-Host "[GATE-F8-TASK698] OK - gate da Fase 8 satisfeito" -ForegroundColor Green
    exit 0
}
Write-Host "[GATE-F8-TASK698] FALHOU: $($falhas -join ' | ')" -ForegroundColor Red
exit 1
