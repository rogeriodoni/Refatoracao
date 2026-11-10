$ErrorActionPreference = 'Stop'
$prg = 'C:\4c\projeto\app\forms\operacionais\FormSigOpIbo.prg'
$bo  = 'C:\4c\projeto\app\classes\SigOpIboBO.prg'

foreach ($f in @($prg, $bo)) {
    Write-Host ("===== " + (Split-Path $f -Leaf) + " =====")
    $content = Get-Content $f -Raw
    $probl = @()

    # 1. marcadores
    foreach ($m in [regex]::Matches($content, "(?im)^\s*\*\-?\-?\s*(TODO|FIXME|HACK|XXX|PLACEHOLDER)\b")) {
        $probl += "Marcador: " + $m.Value.Trim()
    }
    # 2. procedures vazias
    foreach ($m in [regex]::Matches($content, "(?ims)PROCEDURE\s+(\w+)\s*(\(.*?\))?\s*\r?\n(.*?)ENDPROC")) {
        $nome = $m.Groups[1].Value; $body = $m.Groups[3].Value
        if ($body -match "DODEFAULT\(\)") { continue }
        $pp = $m.Groups[2].Value
        if ($nome -match "^Tecla" -and $pp -match "par_nKeyCode") { continue }
        $n = ($body -split "`n" | Where-Object { $_ -match "\S" -and $_ -notmatch "^\s*\*" -and $_ -notmatch "^\s*&&" } | Measure-Object).Count
        if ($n -eq 0) { $probl += "Procedure vazia: $nome" }
    }
    # 3. pendencia
    foreach ($m in [regex]::Matches($content, "(?im)\*.*?(implementar\s+(depois|later|futur)|pr[oÃ³]xima\s+fase|\bpendente|nao\s+implement)")) {
        $probl += "Pendencia: " + $m.Value.Trim()
    }
    # 4. stub MsgAviso
    foreach ($m in [regex]::Matches($content, '(?im)MsgAviso\(.+?(implementad|ser.{1,5}\s+implementad|n.o\s+dispon.vel|em\s+desenvolvimento)')) {
        $probl += "Stub MsgAviso: " + $m.Value.Trim()
    }
    if ($probl.Count -eq 0) { Write-Host "  [OK] completude: 0 problemas" }
    else { $probl | ForEach-Object { Write-Host ("  [X] " + $_) } }

    # acentos literais
    $ac = [regex]::Matches($content, '[\u00C0-\u00FF]').Count
    Write-Host ("  acentos literais        : " + $ac)
    # regra #43
    Write-Host ("  this_X .Value (regra43) : " + [regex]::Matches($content, 'this_\w+\s+\.Value').Count)
    # ISEMPTY / MostrarAviso / MESSAGEBOX
    Write-Host ("  ISEMPTY(                : " + [regex]::Matches($content, '(?i)\bISEMPTY\s*\(').Count)
    Write-Host ("  MostrarAviso(           : " + [regex]::Matches($content, '(?i)\bMostrarAviso\s*\(').Count)
    Write-Host ("  MESSAGEBOX(             : " + [regex]::Matches($content, '(?i)\bMESSAGEBOX\s*\(').Count)
    Write-Host ("  PUBLIC FUNC/PROC        : " + [regex]::Matches($content, '(?im)^\s*PUBLIC\s+(FUNCTION|PROCEDURE)\b').Count)
    Write-Host ("  .Self                   : " + [regex]::Matches($content, '(?i)\.Self\b').Count)
    Write-Host ("  Controls por NOME       : " + [regex]::Matches($content, [char]67 + [char]111 + [char]110 + [char]116 + [char]114 + [char]111 + [char]108 + [char]115 + [char]92 + [char]40 + [char]92 + [char]115 + [char]42 + [char]34).Count)
    Write-Host ("  ZOrderSet / ShapeType   : " + [regex]::Matches($content, '(?i)\b(ZOrderSet|ShapeType)\b').Count)
    Write-Host ("  TABLEREVERT             : " + [regex]::Matches($content, '(?i)\bTABLEREVERT\s*\(').Count)

    # RETURN dentro de TRY (contagem de profundidade)
    $linhas = $content -split "`r?`n"
    $prof = 0; $ret = @()
    for ($i = 0; $i -lt $linhas.Count; $i++) {
        $l = $linhas[$i]
        if ($l -match '^\s*\*') { continue }
        if ($l -match '(?i)^\s*TRY\s*$') { $prof++ ; continue }
        if ($l -match '(?i)^\s*ENDTRY\s*$') { $prof-- ; continue }
        if ($prof -gt 0 -and $l -match '(?i)^\s*RETURN\b') { $ret += ("linha " + ($i+1) + ": " + $l.Trim()) }
    }
    Write-Host ("  RETURN dentro de TRY    : " + $ret.Count)
    $ret | ForEach-Object { Write-Host ("     " + $_) }
    Write-Host ("  profundidade TRY final  : " + $prof + "  (0 = balanceado)")

    # WITH / ENDWITH, IF / ENDIF, DO CASE / ENDCASE
    $o = [regex]::Matches($content, '(?im)^\s*WITH\s').Count
    $c = [regex]::Matches($content, '(?im)^\s*ENDWITH\s*$').Count
    Write-Host ("  WITH=$o ENDWITH=$c")
    $o = [regex]::Matches($content, '(?im)^\s*DO\s+CASE\s*$').Count
    $c = [regex]::Matches($content, '(?im)^\s*ENDCASE\s*$').Count
    Write-Host ("  DO CASE=$o ENDCASE=$c")
}
