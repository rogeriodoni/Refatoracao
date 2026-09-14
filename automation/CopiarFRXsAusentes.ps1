# =============================================================================
# CopiarFRXsAusentes.ps1
# ---------------------------------------------------------------------------
# Detecta FRXs referenciados por BOs REPORT (via THIS.ExecutarReportForm ou
# ObterNomeFRX) que NAO existem em projeto/app/reports/ e copia do legado.
#
# Fontes legado (ordem de prioridade):
#   1. C:\4install\FortyusMC\Fortyus\
#   2. C:\4install\WorkSpace\FortyusMC\Fortyus\
#
# Windows FS eh case-insensitive, entao preserva nome-case do BO.
#
# Origem: Erro92 (2026-08-05, FormSigReCmp — SigReCp2.frx + SigReCp3.frx
# nunca portados; dialog "Arquivo de relatorio nao encontrado").
# =============================================================================

param(
    [string]$ProjetoReports = "C:\4c\projeto\app\reports",
    [string]$BOsDir = "C:\4c\projeto\app\classes",
    [string[]]$LegadoDirs = @(
        "C:\4install\FortyusMC\Fortyus",
        "C:\4install\WorkSpace\FortyusMC\Fortyus"
    ),
    [switch]$DryRun
)

Write-Host "=== VERIFICADOR DE FRXs AUSENTES ===" -ForegroundColor Cyan
Write-Host ""

if (-not (Test-Path $ProjetoReports)) {
    Write-Host "ERRO: Diretorio de reports nao existe: $ProjetoReports" -ForegroundColor Red
    exit 1
}

# Coleta todos os BOs REPORT
$bos = Get-ChildItem -Path $BOsDir -Filter "*BO.prg" -File | Where-Object {
    $content = Get-Content $_.FullName -Raw -ErrorAction SilentlyContinue
    $content -match '(?im)DEFINE\s+CLASS\s+\w+\s+AS\s+RelatorioBase\b'
}

Write-Host "BOs REPORT encontrados: $($bos.Count)" -ForegroundColor White
Write-Host ""

# Extrair nomes FRX referenciados
$frxNomes = @{}
$rxExec = [regex]'(?i)ExecutarReportForm\s*\(\s*"([^"]+)"'
$rxReturn = [regex]'(?im)RETURN\s+"(Sig\w+)"'  # heuristica para ObterNomeFRX

foreach ($bo in $bos) {
    $content = Get-Content $bo.FullName -Raw
    foreach ($m in $rxExec.Matches($content)) {
        $nome = $m.Groups[1].Value
        if ($nome -notmatch '^Sig') { continue }  # skip valores nao-FRX
        if (-not $frxNomes.ContainsKey($nome)) {
            $frxNomes[$nome] = @()
        }
        $frxNomes[$nome] += $bo.Name
    }
    # ObterNomeFRX branches — captura RETURN "SigReXxx"
    if ($content -match '(?im)PROCEDURE\s+ObterNomeFRX') {
        foreach ($m in $rxReturn.Matches($content)) {
            $nome = $m.Groups[1].Value
            if (-not $frxNomes.ContainsKey($nome)) {
                $frxNomes[$nome] = @()
            }
            $frxNomes[$nome] += $bo.Name + " (ObterNomeFRX)"
        }
    }
}

Write-Host "FRXs referenciados: $($frxNomes.Count)" -ForegroundColor White
Write-Host ""

$ausentes = @()
$copiados = 0
$naoEncontrados = 0

foreach ($nome in ($frxNomes.Keys | Sort-Object)) {
    $frxPath = Join-Path $ProjetoReports "$nome.frx"
    $frtPath = Join-Path $ProjetoReports "$nome.frt"

    if (Test-Path $frxPath) {
        continue  # ja existe
    }

    $ausentes += $nome
    Write-Host "AUSENTE: $nome.frx (referenciado por $($frxNomes[$nome] -join ', '))" -ForegroundColor Yellow

    # Procurar no legado (case-insensitive)
    $encontrado = $null
    foreach ($legadoDir in $LegadoDirs) {
        if (-not (Test-Path $legadoDir)) { continue }
        $matches = Get-ChildItem -Path $legadoDir -File | Where-Object {
            $_.BaseName -ieq $nome -and ($_.Extension -ieq ".frx" -or $_.Extension -ieq ".frt")
        }
        if ($matches.Count -ge 1) {
            $encontrado = $legadoDir
            break
        }
    }

    if ($null -eq $encontrado) {
        Write-Host "  NAO ENCONTRADO em nenhum diretorio legado!" -ForegroundColor Red
        $naoEncontrados++
        continue
    }

    # Copiar preservando nome-case do BO
    $srcFrx = Get-ChildItem -Path $encontrado -File | Where-Object {
        $_.BaseName -ieq $nome -and $_.Extension -ieq ".frx"
    } | Select-Object -First 1
    $srcFrt = Get-ChildItem -Path $encontrado -File | Where-Object {
        $_.BaseName -ieq $nome -and $_.Extension -ieq ".frt"
    } | Select-Object -First 1

    if ($DryRun) {
        Write-Host "  [DRY-RUN] Copiaria $($srcFrx.FullName) -> $frxPath" -ForegroundColor Cyan
        if ($srcFrt) {
            Write-Host "  [DRY-RUN] Copiaria $($srcFrt.FullName) -> $frtPath" -ForegroundColor Cyan
        }
    } else {
        if ($srcFrx) {
            Copy-Item -Path $srcFrx.FullName -Destination $frxPath -Force
            Write-Host "  Copiado FRX: $($srcFrx.Name) -> $nome.frx" -ForegroundColor Green
        }
        if ($srcFrt) {
            Copy-Item -Path $srcFrt.FullName -Destination $frtPath -Force
            Write-Host "  Copiado FRT: $($srcFrt.Name) -> $nome.frt" -ForegroundColor Green
        }
        $copiados++
    }
}

Write-Host ""
Write-Host "=== RESUMO ===" -ForegroundColor Cyan
Write-Host "Total FRXs referenciados: $($frxNomes.Count)"
Write-Host "FRXs ausentes: $($ausentes.Count)"
Write-Host "FRXs copiados: $copiados"
Write-Host "FRXs nao encontrados no legado: $naoEncontrados"

if ($naoEncontrados -gt 0) {
    exit 2
}
exit 0
