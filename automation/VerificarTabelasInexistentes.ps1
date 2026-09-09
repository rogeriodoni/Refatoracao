#==============================================================================
# VerificarTabelasInexistentes.ps1
#
# PROPOSITO: Cruza TODA tabela referenciada nos BOs (FROM/INTO/UPDATE/DELETE)
#            contra o schema canonico, e acusa as que nao existem. Tabela
#            inexistente nao quebra compilacao: o erro so aparece em RUNTIME,
#            vindo do proprio SQL Server -
#            "Nome de objeto 'SigCdXxx' invalido."
#
# ATENCAO AO ENCODING (a armadilha que originou este script, Erro155):
#   docs\schema.sql eh UTF-16LE. grep/awk/findstr tratam o arquivo como
#   BINARIO e devolvem ZERO ocorrencias SILENCIOSAMENTE - o que faz parecer
#   que a tabela nao existe. Aqui o arquivo eh lido com Get-Content -Raw, que
#   detecta o BOM. NUNCA validar schema com grep direto em docs\schema.sql.
#
#   Pela mesma razao, NAO usar tasks\<task>\schema_ascii.sql como fonte de
#   verdade: e um snapshot congelado na epoca daquela task (task351 tem 674
#   tabelas contra 682 do canonico) e tabela nova aparece como inexistente.
#
# USO:
#   .\VerificarTabelasInexistentes.ps1
#   .\VerificarTabelasInexistentes.ps1 -Schema <caminho>   # outro dump
#==============================================================================

param(
    [string]$Schema  = "C:\4c\docs\schema.sql",
    [string]$Classes = "C:\4c\projeto\app\classes"
)

$ErrorActionPreference = "Stop"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  TABELAS REFERENCIADAS x SCHEMA" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

if (-not (Test-Path $Schema)) {
    Write-Host "ERRO: schema nao encontrado: $Schema" -ForegroundColor Red
    exit 2
}

# Get-Content -Raw respeita o BOM UTF-16 do dump
$texto = Get-Content $Schema -Raw
$catalogo = @{}
foreach ($m in [regex]::Matches($texto, '(?i)CREATE TABLE \[dbo\]\.\[([A-Za-z0-9_]+)\]')) {
    $catalogo[$m.Groups[1].Value.ToLower()] = $m.Groups[1].Value
}
Write-Host "  Schema:  $Schema" -ForegroundColor Gray
Write-Host "  Tabelas: $($catalogo.Count)" -ForegroundColor Gray

if ($catalogo.Count -lt 100) {
    Write-Host ""
    Write-Host "ERRO: so $($catalogo.Count) tabelas lidas - provavel problema de ENCODING." -ForegroundColor Red
    Write-Host "docs\schema.sql eh UTF-16LE; ler como ASCII devolve zero e daria" -ForegroundColor Red
    Write-Host "'tabela nao existe' para TUDO. Abortando para nao gerar diagnostico falso." -ForegroundColor Red
    exit 2
}

$arqs = Get-ChildItem -Path $Classes -Filter "*BO.prg" -ErrorAction SilentlyContinue |
        Where-Object { $_.Name -notmatch '\.bak$' }
Write-Host "  BOs:     $($arqs.Count)" -ForegroundColor Gray
Write-Host ""

$ausentes = @{}
$totalRefs = @{}
foreach ($a in $arqs) {
    $nLinha = 0
    foreach ($bruta in [System.IO.File]::ReadAllLines($a.FullName)) {
        $nLinha++
        $l = $bruta -replace '\s*&&.*$', ''
        if ($l -match '^\s*\*') { continue }
        foreach ($m in [regex]::Matches($l, '(?i)\b(?:FROM|INTO|UPDATE|DELETE\s+FROM)\s+(Sig[A-Za-z0-9_]+)')) {
            $t = $m.Groups[1].Value
            $k = $t.ToLower()
            $totalRefs[$k] = $true
            if ($catalogo.ContainsKey($k)) { continue }
            if (-not $ausentes.ContainsKey($k)) { $ausentes[$k] = @() }
            $ausentes[$k] += [PSCustomObject]@{ Arquivo = $a.Name; Linha = $nLinha; Nome = $t }
        }
    }
}

Write-Host "Tabelas Sig* referenciadas nos BOs: $($totalRefs.Count)" -ForegroundColor Gray
Write-Host ""

if ($ausentes.Count -eq 0) {
    Write-Host "OK - toda tabela referenciada existe no schema." -ForegroundColor Green
    exit 0
}

Write-Host "$($ausentes.Count) tabela(s) referenciada(s) que NAO existem no schema:" -ForegroundColor Red
Write-Host ""
foreach ($k in ($ausentes.Keys | Sort-Object)) {
    $g = $ausentes[$k]
    Write-Host ("== {0}  ({1} referencia(s))" -f $g[0].Nome, $g.Count) -ForegroundColor Yellow
    foreach ($r in ($g | Sort-Object Arquivo, Linha)) {
        Write-Host ("   {0}:{1}" -f $r.Arquivo, $r.Linha)
    }
    Write-Host ""
}
Write-Host "Antes de mexer no codigo, conferir no CODIGO LEGADO (tasks\<task>\*_form_codigo_fonte.txt)" -ForegroundColor Gray
Write-Host "se o legado usa o MESMO nome. Se usa, o codigo migrado esta fiel e a lacuna eh de BANCO" -ForegroundColor Gray
Write-Host "(tabela a criar/importar) - apontar o BO para outra tabela violaria o PILAR 2." -ForegroundColor Gray
exit 1
