$reportPath = 'C:\4c\projeto\app\utils\relatorios\UIFidelity_Formsigopind_20260312154713.html'
$content = Get-Content $reportPath -Raw
$errCount  = ([regex]::Matches($content, 'class="erro"')).Count
$warnCount = ([regex]::Matches($content, 'class="aviso"')).Count
$diffCount = ([regex]::Matches($content, 'class="diferenca"')).Count
Write-Host "Errors: $errCount | Warnings: $warnCount | Differences: $diffCount"
if ($content -match 'Total[^<]*(\d+)\s*problemas') { Write-Host "Summary: $($matches[0])" }
