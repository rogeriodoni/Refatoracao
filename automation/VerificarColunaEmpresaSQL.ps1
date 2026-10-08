# =============================================================================
# VerificarColunaEmpresaSQL.ps1
#
# Erro196 (2026-10-08): a coluna de empresa nas tabelas Sig* NAO segue o prefixo
# da tabela. `SIGCDCEG` eh mestre (prefixo Cd) e mesmo assim usa `emps` sem C;
# `SIGFITEF` eh Fi e usa `cemps`. Deduzir pelo prefixo gera
# "Nome de coluna 'cemps' invalido" - erro do SQL Server, em RUNTIME, que nao
# quebra compilacao e nao aparece em gate nenhum.
#
# O detector NAO deduz: le `docs/schema.sql` (UTF-16, Get-Content -Raw - regra
# #14) e monta a lista REAL de colunas por tabela. Depois resolve, dentro de
# cada string SQL, qual tabela cada alias representa (FROM/JOIN <T> [AS] <a>) e
# confere se `<a>.emps` / `<a>.cemps` existe mesmo naquela tabela.
#
# Origem: Erro196 (CegBO - "Cadastro de Prioridade de Estoque p/Globalizacao").
# O sweep do Erro108 tinha liberado o CegBO como seguro JUSTAMENTE pelo prefixo.
# =============================================================================
param(
    [string]$Caminho = "C:\4c\projeto\app",
    [string]$Schema  = "C:\4c\docs\schema.sql"
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path $Schema)) {
    Write-Host "[COL-EMPRESA] schema nao encontrado: $Schema" -ForegroundColor Red
    exit 2
}

# ---- colunas reais por tabela (schema eh UTF-16: -Raw respeita o BOM) -------
$txt = Get-Content $Schema -Raw
$tabelas = @{}
foreach ($m in [regex]::Matches($txt, '(?is)CREATE TABLE \[dbo\]\.\[([A-Za-z0-9_]+)\]\((.*?)\r?\n\)')) {
    $nome = $m.Groups[1].Value.ToLower()
    $cols = @{}
    foreach ($c in [regex]::Matches($m.Groups[2].Value, '\[([A-Za-z0-9_]+)\]\s+\[')) {
        $cols[$c.Groups[1].Value.ToLower()] = $true
    }
    $tabelas[$nome] = $cols
}
if ($tabelas.Count -lt 100) {
    Write-Host "[COL-EMPRESA] schema leu so $($tabelas.Count) tabelas - encoding suspeito, abortando" -ForegroundColor Red
    exit 2
}
Write-Host "[COL-EMPRESA] schema: $($tabelas.Count) tabelas" -ForegroundColor Cyan

$arquivos = Get-ChildItem -Path $Caminho -Filter "*.prg" -Recurse -File
$nErro = 0; $nSkip = 0

foreach ($arq in $arquivos) {
    $linhas = Get-Content -LiteralPath $arq.FullName

    # Junta as continuacoes de linha (";" no fim) para o SQL montado em varias
    # linhas virar um bloco unico - sem isso o alias e o FROM caem em linhas
    # diferentes e nada resolve.
    $blocos = @()
    $buf = ""; $ini = 0
    for ($i = 0; $i -lt $linhas.Count; $i++) {
        $l = $linhas[$i]
        if ($l -match '^\s*(\*|&&)') { continue }
        if ($buf -eq "") { $ini = $i + 1 }
        $buf += " " + $l
        if ($l -notmatch ';\s*$') { $blocos += ,@($ini, $buf); $buf = "" }
    }
    if ($buf -ne "") { $blocos += ,@($ini, $buf) }

    foreach ($b in $blocos) {
        $linha = $b[0]; $sql = $b[1]
        if ($sql -notmatch '(?i)\.c?emps\b') { continue }
        if ($sql -notmatch '(?i)\b(FROM|JOIN)\s+') { continue }

        # alias -> tabela, dentro deste bloco
        $alias = @{}
        foreach ($m in [regex]::Matches($sql, '(?i)\b(?:FROM|JOIN)\s+([A-Za-z0-9_]+)\s+(?:AS\s+)?([A-Za-z][A-Za-z0-9_]*)\b')) {
            $t = $m.Groups[1].Value.ToLower()
            $a = $m.Groups[2].Value.ToLower()
            if ($a -in @('on','where','inner','left','right','join','outer','group','order','set','as')) { continue }
            if ($tabelas.ContainsKey($t)) { $alias[$a] = $t }
        }
        if ($alias.Count -eq 0) { continue }

        foreach ($m in [regex]::Matches($sql, '(?i)\b([A-Za-z][A-Za-z0-9_]*)\.(c?emps)\b')) {
            $a   = $m.Groups[1].Value.ToLower()
            $col = $m.Groups[2].Value.ToLower()
            if (-not $alias.ContainsKey($a)) { $nSkip++; continue }
            $t = $alias[$a]
            if ($tabelas[$t].ContainsKey($col)) { continue }

            $certa = if ($col -eq 'cemps') { 'emps' } else { 'cemps' }
            $existe = $tabelas[$t].ContainsKey($certa)
            $rel = $arq.FullName.Replace("C:\4c\", "")
            if ($existe) {
                Write-Host "[ERRO]  $rel`:$linha - $a.$col mas $t tem '$certa' (use $a.$certa). Erro196" -ForegroundColor Red
            } else {
                Write-Host "[ERRO]  $rel`:$linha - $a.$col e $t NAO tem nem 'emps' nem 'cemps'. Erro196" -ForegroundColor Red
            }
            $nErro++
        }
    }
}

Write-Host ""
Write-Host "[COL-EMPRESA] $($arquivos.Count) arquivos. ERRO=$nErro (alias nao resolvido: $nSkip)" -ForegroundColor Cyan
if ($nErro -gt 0) { exit 1 }
exit 0
