$ErrorActionPreference = 'Stop'
$p = 'C:\4c\projeto\app\forms\operacionais\FormSigOpTot.prg'
$content = Get-Content $p -Raw

"--- 1) marcadores TODO/FIXME/HACK/XXX/PLACEHOLDER ---"
$m1 = [regex]::Matches($content, "(?im)^\s*\*\-?\-?\s*(TODO|FIXME|HACK|XXX|PLACEHOLDER)\b")
"  achados: $($m1.Count)"; $m1 | ForEach-Object { "   " + $_.Value.Trim() }

"--- 2) procedures vazias ---"
$n2 = 0
foreach ($m in [regex]::Matches($content, "(?ims)PROCEDURE\s+(\w+)\s*(\(.*?\))?\s*\r?\n(.*?)ENDPROC")) {
    $body = $m.Groups[3].Value
    if ($body -match "DODEFAULT\(\)") { continue }
    if ($m.Groups[1].Value -match "^Tecla" -and $m.Groups[2].Value -match "par_nKeyCode") { continue }
    $cl = ($body -split "`n" | Where-Object { $_ -match "\S" -and $_ -notmatch "^\s*\*" -and $_ -notmatch "^\s*&&" } | Measure-Object).Count
    if ($cl -eq 0) { "   VAZIA: $($m.Groups[1].Value)"; $n2++ }
}
"  achados: $n2"

"--- 3) indicadores de pendencia ---"
$m3 = [regex]::Matches($content, "(?im)\*.*?(implementar\s+(depois|later|futur)|pr[oó]xima\s+fase|\bpendente|nao\s+implement)")
"  achados: $($m3.Count)"; $m3 | ForEach-Object { "   " + $_.Value.Trim() }

"--- 4) stubs MsgAviso ---"
$m4 = [regex]::Matches($content, '(?im)MsgAviso\(.+?(implementad|ser.{1,5}\s+implementad|n.o\s+dispon.vel|em\s+desenvolvimento)')
"  achados: $($m4.Count)"; $m4 | ForEach-Object { "   " + $_.Value.Trim() }

"--- balanceamento estrutural ---"
$txt = $content
foreach ($par in @(@('IF','ENDIF'), @('WITH','ENDWITH'), @('TRY','ENDTRY'), @('FOR','ENDFOR'), @('DO WHILE','ENDDO'))) {
    $a = ([regex]::Matches($txt, "(?im)^\s*$($par[0])\b")).Count
    $b = ([regex]::Matches($txt, "(?im)^\s*$($par[1])\b")).Count
    $flag = if ($a -eq $b) { 'OK' } else { 'DESBALANCEADO' }
    "  $($par[0])/$($par[1]): $a / $b  $flag"
}
$pr = ([regex]::Matches($txt, "(?im)^\s*(PROTECTED\s+|HIDDEN\s+)?PROCEDURE\b")).Count
$ep = ([regex]::Matches($txt, "(?im)^\s*ENDPROC\b")).Count
$fn = ([regex]::Matches($txt, "(?im)^\s*(PROTECTED\s+|HIDDEN\s+)?FUNCTION\b")).Count
$ef = ([regex]::Matches($txt, "(?im)^\s*ENDFUNC\b")).Count
"  PROCEDURE/FUNCTION: $($pr+$fn)  ENDPROC/ENDFUNC: $($ep+$ef)  " + $(if (($pr+$fn) -eq ($ep+$ef)) {'OK'} else {'DESBALANCEADO'})

"--- PUBLIC do handler (regra #3) ---"
"  PROTECTED em ValidarCompensacao(): " + $(if ($txt -match '(?im)^\s*PROTECTED\s+PROCEDURE\s+ValidarCompensacao\s*\(') {'SIM (ERRADO)'} else {'nao (OK)'})
