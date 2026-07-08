param()
$file = 'C:\4c\projeto\app\forms\operacionais\Formsigregli.prg'
$lines = [System.IO.File]::ReadAllLines($file, [System.Text.Encoding]::UTF8)
$out = New-Object System.Collections.Generic.List[string]

$i = 0
$changes = 0
while ($i -lt $lines.Count) {
    $line = $lines[$i]
    $trimmed = $line.TrimStart()

    # Add FontName/FontSize to Buttons(1) blocks
    if ($trimmed -match '^WITH\s+\.Buttons\s*\(\s*1\s*\)$') {
        $out.Add($line)
        $i++
        if ($i -lt $lines.Count -and $lines[$i].TrimStart() -match '^\.BackStyle\s*=') {
            $indent = $lines[$i] -replace '^(\s*).*', '$1'
            $out.Add($indent + '.FontName  = "Tahoma"')
            $out.Add($indent + '.FontSize  = 8')
            $changes++
        }
        continue
    }

    $out.Add($line)
    $i++
}

[System.IO.File]::WriteAllLines($file, $out.ToArray(), [System.Text.UTF8Encoding]::new($false))
Write-Host "FontName/Size added to $changes Buttons(1) blocks"
Write-Host "Total lines: $($out.Count)"
