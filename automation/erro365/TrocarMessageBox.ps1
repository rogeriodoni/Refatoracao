param([string]$Arq)
$t = [IO.File]::ReadAllText($Arq)
$sb = New-Object Text.StringBuilder; $pos = 0; $n = 0; $skip = 0
$rx = [regex]'(?i)MessageBox\s*\('
while($true){
  $m = $rx.Match($t, $pos); if(-not $m.Success){ [void]$sb.Append($t.Substring($pos)); break }
  [void]$sb.Append($t.Substring($pos, $m.Index - $pos))
  # varre ate o ')' correspondente, separando argumentos de nivel 0
  $i = $m.Index + $m.Length; $depth = 1; $close = $null; $args = New-Object Collections.Generic.List[string]; $cur = New-Object Text.StringBuilder
  while($i -lt $t.Length -and $depth -gt 0){
    $ch = $t[$i]
    if($null -ne $close){ if($ch -eq $close){ $close = $null }; [void]$cur.Append($ch) }
    elseif($ch -eq "'" -or $ch -eq '"'){ $close = $ch; [void]$cur.Append($ch) }
    elseif($ch -eq '['){ $close = ']'; [void]$cur.Append($ch) }
    elseif($ch -eq '('){ $depth++; [void]$cur.Append($ch) }
    elseif($ch -eq ')'){ $depth--; if($depth -gt 0){ [void]$cur.Append($ch) } }
    elseif($ch -eq ',' -and $depth -eq 1){ $args.Add($cur.ToString()); $cur.Clear() | Out-Null }
    else { [void]$cur.Append($ch) }
    $i++
  }
  $args.Add($cur.ToString())
  $tipo = if($args.Count -ge 2){ ($args[1] -replace '\s','') } else { '' }
  $fn = $null
  if($tipo -match '^(16|0\+16)$'){ $fn = 'MsgErro' } elseif($tipo -match '^(48|0\+48|64|32|0)$'){ $fn = 'MsgAviso' }
  if($fn){
    $titulo = if($args.Count -ge 3){ $args[2].Trim() } else { '""' }
    [void]$sb.Append("$fn(" + $args[0].Trim() + ", " + $titulo + ")"); $n++
  } else { [void]$sb.Append($t.Substring($m.Index, $i - $m.Index)); $skip++ }
  $pos = $i
}
[IO.File]::WriteAllText($Arq, $sb.ToString(), [Text.Encoding]::ASCII)
"$([IO.Path]::GetFileName($Arq)): $n MessageBox -> Msg*, $skip mantidos"
