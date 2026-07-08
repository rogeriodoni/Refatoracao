$raw = Get-Content 'C:\4c\tasks\task008\comportamento.json' -Raw | ConvertFrom-Json
$items = $raw.metodos
$fasepItems = $items | Where-Object { $_.objeto -like "*FaseP*" }
$sb = [System.Text.StringBuilder]::new()
foreach ($item in $fasepItems) {
    [void]$sb.AppendLine("=== $($item.objeto) :: $($item.evento) ===")
    [void]$sb.AppendLine($item.codigoOriginal)
    [void]$sb.AppendLine("---")
}
[System.IO.File]::WriteAllText('C:\4c\tasks\task008\handlers3.txt', $sb.ToString())
Write-Host "Written $($fasepItems.Count) items"
