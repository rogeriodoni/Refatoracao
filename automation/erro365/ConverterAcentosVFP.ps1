# ConverterAcentosVFP.ps1 - converte fonte VFP cp1252 para ASCII puro (regra CLAUDE.md #4):
#   acento DENTRO de literal ('..', "..", [..]) -> fecha literal + CHR(n) + reabre
#   acento em comentario (* no inicio, ou depois de &&) -> transliterado para ASCII
param([string]$Origem, [string]$Destino)
$enc = [Text.Encoding]::GetEncoding(1252)
$lines = [IO.File]::ReadAllLines($Origem, $enc)
$map = @{ [char]0xE1='a';[char]0xE0='a';[char]0xE2='a';[char]0xE3='a';[char]0xE4='a';[char]0xE9='e';[char]0xEA='e';[char]0xED='i';[char]0xF3='o';[char]0xF4='o';[char]0xF5='o';[char]0xFA='u';[char]0xFC='u';[char]0xE7='c';
          [char]0xC1='A';[char]0xC0='A';[char]0xC2='A';[char]0xC3='A';[char]0xC9='E';[char]0xCA='E';[char]0xCD='I';[char]0xD3='O';[char]0xD4='O';[char]0xD5='O';[char]0xDA='U';[char]0xC7='C';[char]0xBA='o';[char]0xAA='a';[char]0xB0='o' }
function Translit([string]$s){ $sb=New-Object Text.StringBuilder; foreach($ch in $s.ToCharArray()){ if([int]$ch -gt 127){ if($map.ContainsKey($ch)){ [void]$sb.Append($map[$ch]) } else { [void]$sb.Append('?') } } else { [void]$sb.Append($ch) } }; $sb.ToString() }
$out = New-Object Collections.Generic.List[string]
$nLit = 0
foreach($line in $lines){
  if($line.TrimStart().StartsWith('*')){ $out.Add((Translit $line)); continue }
  $sb = New-Object Text.StringBuilder
  $close = $null; $open = $null; $i = 0
  while($i -lt $line.Length){
    $ch = $line[$i]
    if($null -eq $close){
      if($ch -eq '&' -and $i+1 -lt $line.Length -and $line[$i+1] -eq '&'){ [void]$sb.Append((Translit $line.Substring($i))); break }
      if($ch -eq "'" -or $ch -eq '"'){ $open=$ch; $close=$ch }
      elseif($ch -eq '['){
        # '[' so eh delimitador de string se nao vier logo apos identificador/')' (subscrito)
        $prev = if($sb.Length -gt 0){ $sb[$sb.Length-1] } else { ' ' }
        if($prev -match '[A-Za-z0-9_\)\]]'){ [void]$sb.Append($ch); $i++; continue }
        $open='['; $close=']'
      }
      [void]$sb.Append($ch)
    } else {
      if($ch -eq $close){ $close=$null; [void]$sb.Append($ch) }
      elseif([int]$ch -gt 127){ $nLit++; [void]$sb.Append($close + ' + CHR(' + [int][char]$enc.GetBytes([string]$ch)[0] + ') + ' + $open) }
      else { [void]$sb.Append($ch) }
    }
    $i++
  }
  $out.Add($sb.ToString())
}
[IO.File]::WriteAllLines($Destino, $out, [Text.Encoding]::ASCII)
$bad = ([IO.File]::ReadAllBytes($Destino) | ? { $_ -gt 127 }).Count
"$([IO.Path]::GetFileName($Destino)): $($lines.Count) linhas, $nLit acentos em literal -> CHR(), bytes>127 restantes=$bad"
