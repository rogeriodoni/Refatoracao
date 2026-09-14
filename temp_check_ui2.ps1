$reportPath = 'C:\4c\projeto\app\utils\relatorios\UIFidelity_Formsigopind_20260310204520.html'
$content = Get-Content $reportPath -Raw
$matches2 = [regex]::Matches($content, '<div class="numero">(.*?)</div>')
Write-Host "=== March 10 report ==="
foreach ($m in $matches2[0..5]) { Write-Host $m.Value }
