$content = Get-Content 'C:\4c\projeto\app\forms\operacionais\Formsigopind.prg' -Raw -Encoding Default
$remaining = ([regex]::Matches($content, ' : \.')).Count
Write-Host "Remaining ' : .' patterns: $remaining"
$lines = ($content -split "`r?`n").Count
Write-Host "Total lines: $lines"
$elseif = ([regex]::Matches($content, '\bELSEIF\b')).Count
Write-Host "ELSEIF count: $elseif"
