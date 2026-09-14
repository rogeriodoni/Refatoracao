$file = 'C:\4c\projeto\app\forms\operacionais\Formsigopind.prg'
$bytes = [System.IO.File]::ReadAllBytes($file)
$content = [System.Text.Encoding]::Default.GetString($bytes)
$count = ([regex]::Matches($content, ' : \.')).Count
Write-Host "Found $count instances of ' : .' pattern"
$fixed = $content -replace ' : \.', "`r`n    ."
$countAfter = ([regex]::Matches($fixed, ' : \.')).Count
Write-Host "After fix: $countAfter instances remain"
[System.IO.File]::WriteAllBytes($file, [System.Text.Encoding]::Default.GetBytes($fixed))
Write-Host "Done"
