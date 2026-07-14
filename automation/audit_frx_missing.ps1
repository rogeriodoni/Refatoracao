# audit_frx_missing.ps1
# Scan all REPORT BOs + forms for FRX names, find missing in reports/, copy from Fortyus
$ErrorActionPreference = 'Stop'

$reportsDir = 'C:\4c\projeto\app\reports'
$fortyusDir = 'C:\4install\FortyusMC\Fortyus'
$scanDirs = @(
    'C:\4c\projeto\app\classes',
    'C:\4c\projeto\app\forms\relatorios',
    'C:\4c\projeto\app\forms\operacionais'
)

# Extract FRX names from source code
$frxRefs = New-Object System.Collections.Generic.HashSet[string]

foreach ($dir in $scanDirs) {
    Get-ChildItem -Path $dir -Filter '*.prg' -Recurse -ErrorAction SilentlyContinue |
        Where-Object { $_.Name -notmatch '\.bak$|\.BAK$' } |
        ForEach-Object {
            $content = Get-Content -Raw -LiteralPath $_.FullName -Encoding Default
            # Match: THIS.ExecutarReportForm("Name", ...)
            # Match: loc_cFrx = "Name"
            # Match: par_cRelatorioBase = "Name"
            # Match: gc_4c_CaminhoReports + "Name.frx"
            # Match: REPORT FORM (var)  (indirect, via var)
            $patterns = @(
                'ExecutarReportForm\s*\(\s*"([A-Za-z][A-Za-z0-9_]{3,20})"',
                'loc_cFrx\s*=\s*"([A-Za-z][A-Za-z0-9_]{3,20})"',
                'loc_cFRX\s*=\s*"([A-Za-z][A-Za-z0-9_]{3,20})"',
                'par_cRelatorioBase\s*=\s*"([A-Za-z][A-Za-z0-9_]{3,20})"',
                'gc_4c_CaminhoReports\s*\+\s*"([A-Za-z][A-Za-z0-9_]{3,20})\.frx"',
                'gc_4c_CaminhoReports\s*\+\s*"([A-Za-z][A-Za-z0-9_]{3,20})"'
            )
            foreach ($pat in $patterns) {
                $matches = [regex]::Matches($content, $pat, 'IgnoreCase')
                foreach ($m in $matches) {
                    $name = $m.Groups[1].Value
                    # Skip obvious non-FRX names
                    if ($name -notmatch '^(THIS|SELF|PREVIEW|PRINTER|PRINTER_PROMPT|Aviso|Info|Erro)$') {
                        [void]$frxRefs.Add($name)
                    }
                }
            }
        }
}

Write-Host "Total FRX names referenciados: $($frxRefs.Count)"

# Check which exist in reports/ and which are missing
$missing = @()
$present = 0
foreach ($name in $frxRefs) {
    $target = Join-Path $reportsDir "$name.frx"
    if (Test-Path -LiteralPath $target) {
        $present++
    } else {
        $missing += $name
    }
}

Write-Host "FRX presentes: $present"
Write-Host "FRX ausentes:  $($missing.Count)"
Write-Host ""

# For each missing, check Fortyus and copy
$copied = 0
$notFound = @()
foreach ($name in $missing) {
    $srcFrx = Join-Path $fortyusDir "$name.frx"
    $srcFrt = Join-Path $fortyusDir "$name.frt"
    if (Test-Path -LiteralPath $srcFrx) {
        Copy-Item -LiteralPath $srcFrx -Destination $reportsDir -Force
        if (Test-Path -LiteralPath $srcFrt) {
            Copy-Item -LiteralPath $srcFrt -Destination $reportsDir -Force
        }
        Write-Host "  COPIADO: $name.frx" -ForegroundColor Green
        $copied++
    } else {
        $notFound += $name
    }
}

Write-Host ""
Write-Host "RESUMO:" -ForegroundColor Cyan
Write-Host "  Referenciados: $($frxRefs.Count)"
Write-Host "  Ja presentes:  $present"
Write-Host "  Copiados:      $copied"
Write-Host "  NAO ACHADOS em Fortyus: $($notFound.Count)"
if ($notFound.Count -gt 0) {
    Write-Host ""
    Write-Host "FRX referenciados mas ausentes AMBOS (portados e Fortyus):" -ForegroundColor Yellow
    $notFound | Sort-Object | ForEach-Object { Write-Host "  $_" }
}
