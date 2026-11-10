param([string]$Form, [string]$Dump)
$c = Get-Content $Form -Raw
$ok = $true
function Chk($n,$v){ if($v){Write-Host "  [OK]   $n" -f Green}else{Write-Host "  [FAIL] $n" -f Red; $script:ok=$false} }

Write-Host "--- Test-CompletudeCodigo ---"
$p=@()
foreach($m in [regex]::Matches($c,"(?im)^\s*\*\-?\-?\s*(TODO|FIXME|HACK|XXX|PLACEHOLDER)\b")){$p+="marcador: "+$m.Value.Trim()}
foreach($m in [regex]::Matches($c,"(?im)\*.*?(implementar\s+(depois|later|futur)|pr[oó]xima\s+fase|\bpendente|nao\s+implement)")){$p+="pendencia: "+$m.Value.Trim()}
foreach($m in [regex]::Matches($c,'(?im)MsgAviso\(.+?(implementad|ser.{1,5}\s+implementad|n.o\s+dispon.vel|em\s+desenvolvimento)')){$p+="stub MsgAviso: "+$m.Value.Trim()}
foreach($m in [regex]::Matches($c,"(?ims)PROCEDURE\s+(\w+)\s*(\(.*?\))?\s*\r?\n(.*?)ENDPROC")){
  $b=$m.Groups[3].Value; if($b -match "DODEFAULT\(\)"){continue}
  if($m.Groups[1].Value -match "^Tecla" -and $m.Groups[2].Value -match "par_nKeyCode"){continue}
  $n=($b -split "`n" | ? { $_ -match "\S" -and $_ -notmatch "^\s*\*" -and $_ -notmatch "^\s*&&" } | Measure-Object).Count
  if($n -eq 0){$p+="procedure vazia: "+$m.Groups[1].Value}
}
Chk "completude (0 problemas)" ($p.Count -eq 0)
$p | % { Write-Host "         - $_" -f Yellow }

Write-Host "--- Gate case 8: nomes exigidos como METODO (nao substring) ---"
foreach($n in @("BtnCancelarClick","FormParaBO","BOParaForm","CarregarLista")){
  Chk "metodo $n" ([regex]::IsMatch($c,"(?im)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+$n\b"))
}
Chk 'botao de acao (PROCEDURE Btn(Salvar|Confirmar|Gravar|Processa|Aplicar|Executar|OK)\w*Click)' `
  ([regex]::IsMatch($c,'(?im)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+Btn(Salvar|Confirmar|Gravar|Processa|Aplicar|Executar|OK)\w*Click\b'))

Write-Host "--- Regras VFP9 do projeto ---"
Chk "sem acento literal" (-not [regex]::IsMatch($c,"[\u00C0-\u00FF]"))
Chk "sem this_X .Value (regra #43)" (-not [regex]::IsMatch($c,'this_\w+\s+\.Value'))
Chk "sem PUBLIC PROCEDURE/FUNCTION (regra #9.1)" (-not [regex]::IsMatch($c,"(?im)^\s*PUBLIC\s+(PROCEDURE|FUNCTION)\b"))
Chk "sem MESSAGEBOX direto" (-not [regex]::IsMatch($c,"(?im)^[^*]*\bMESSAGEBOX\s*\("))
Chk "sem MostrarAviso (regra #9.3)" (-not [regex]::IsMatch($c,"(?im)\bMostrarAviso\s*\("))
Chk "sem .Self (regra #38)" (-not [regex]::IsMatch($c,"(?im)\.Self\b"))
Chk "sem Controls(<nome>) (regra #34)" (-not [regex]::IsMatch($c,'Controls\(\s*"'))
Chk "sem TABLEREVERT cru (regra #52)" (-not [regex]::IsMatch($c,"(?im)^[^*]*\bTABLEREVERT\s*\("))
Chk "sem ISEMPTY (regra #2)" (-not [regex]::IsMatch($c,"(?im)\bISEMPTY\s*\("))
Chk 'sem escape \" em string' (-not [regex]::IsMatch($c,'[^*]*\\"'))

Write-Host "--- RETURN dentro de TRY (regra #1) ---"
$lines = $c -split "`r?`n"; $d=0; $bad=@()
for($i=0;$i -lt $lines.Count;$i++){
  $l = $lines[$i]; if($l -match "^\s*\*"){continue}
  if($l -match "(?i)^\s*TRY\b"){$d++}
  elseif($l -match "(?i)^\s*ENDTRY\b"){$d--}
  elseif($d -gt 0 -and $l -match "(?i)^\s*RETURN\b"){$bad += ("linha "+($i+1)+": "+$l.Trim())}
}
Chk "nenhum RETURN dentro de TRY" ($bad.Count -eq 0)
$bad | % { Write-Host "         - $_" -f Yellow }

Write-Host ""
if($ok){Write-Host "RESULTADO: TODOS OS GATES PASSARAM" -f Green}else{Write-Host "RESULTADO: HOUVE FALHA" -f Red}
