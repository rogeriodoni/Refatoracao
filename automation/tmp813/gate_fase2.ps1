$ErrorActionPreference = 'Stop'
# Replica EXATA do gate "case 2" de Invoke-FaseMigracao (OrquestradorMigracao.ps1)
# e de Test-CompletudeCodigo. O orquestrador NAO e dot-sourced de proposito:
# dot-source dele dispara migracao.

$boFile   = 'C:\4c\projeto\app\classes\SigOpTotBO.prg'
$TaskPath = 'C:\4c\tasks\task813'
$BaseName = 'SigOpTot'
$FormType = 'OPERACIONAL'

$conteudo = Get-Content $boFile -Raw

# ---------------- excecao fail-closed: BO somente-leitura ----------------
$boSomenteLeitura = $false
$dumpLegadoF2 = Join-Path $TaskPath "$($BaseName)_form_codigo_fonte.txt"
if ($FormType -ne "REPORT" -and (Test-Path $dumpLegadoF2)) {
    $txtLegadoF2 = Get-Content $dumpLegadoF2 -Raw -ErrorAction SilentlyContinue
    if ($txtLegadoF2) {
        $f2SemTableUpdate = ($txtLegadoF2 -notmatch '(?i)\bTABLEUPDATE\s*\(')
        $f2SemAddCursor   = ($txtLegadoF2 -notmatch '(?i)\.AddCursor\s*\(')

        $f2CursoresLocais = @{}
        foreach ($mc in [regex]::Matches($txtLegadoF2, '(?im)\b(?:Create\s+Cursor|Into\s+Cursor)\s+([A-Za-z_][A-Za-z0-9_]*)')) {
            $f2CursoresLocais[$mc.Groups[1].Value.ToUpper()] = $true
        }
        $f2ReArgCursor = "(?:'([^']+)'|\[([^\]]+)\]|`"([^`"]+)`")"
        $f2PadroesCursor = @(
            "(?i)\.SqlExecute\s*\(\s*(?:[^,()]|\([^()]*\))*,\s*$f2ReArgCursor",
            "(?i)\bSQLEXEC\s*\(\s*(?:[^,()]|\([^()]*\))*,\s*(?:[^,()]|\([^()]*\))*,\s*$f2ReArgCursor",
            "(?i)\.CursorQuery\s*\(\s*(?:'[^']*'|\[[^\]]*\]|`"[^`"]*`")\s*,\s*$f2ReArgCursor"
        )
        foreach ($f2Pad in $f2PadroesCursor) {
            foreach ($mc2 in [regex]::Matches($txtLegadoF2, $f2Pad)) {
                for ($f2i = 1; $f2i -le 3; $f2i++) {
                    $f2Nome = $mc2.Groups[$f2i].Value
                    if ($f2Nome -and $f2Nome.Trim()) { $f2CursoresLocais[$f2Nome.Trim().ToUpper()] = $true; break }
                }
            }
        }
        $f2AlvosLocais = $true
        $f2AlvoRemoto  = ""
        foreach ($mw in [regex]::Matches($txtLegadoF2, '(?im)\b(?:Insert\s+Into|Update|Delete\s+From)\s+([A-Za-z_][A-Za-z0-9_]*)')) {
            if (-not $f2CursoresLocais.ContainsKey($mw.Groups[1].Value.ToUpper())) {
                $f2AlvosLocais = $false; $f2AlvoRemoto = $mw.Groups[1].Value; break
            }
        }
        $f2BoSemEscrita = ($conteudo -notmatch '(?is)SQLEXEC\s*\([^\)]*(INSERT\s+INTO|UPDATE\s+|DELETE\s+FROM)')
        $boSomenteLeitura = $f2SemTableUpdate -and $f2SemAddCursor -and $f2AlvosLocais -and $f2BoSemEscrita

        Write-Host '--- provas da excecao BO somente-leitura ---'
        Write-Host ("  (1) sem TABLEUPDATE(  : " + $f2SemTableUpdate)
        Write-Host ("  (2) sem .AddCursor(   : " + $f2SemAddCursor)
        Write-Host ("  (3) alvos todos locais: " + $f2AlvosLocais + $(if (-not $f2AlvosLocais) { "  (alvo remoto: $f2AlvoRemoto)" } else { "" }))
        Write-Host ("  (4) BO sem SQLEXEC de escrita: " + $f2BoSemEscrita)
        Write-Host ("  => boSomenteLeitura = " + $boSomenteLeitura)
    }
}

Write-Host ''
Write-Host '--- tokens exigidos ---'
Write-Host ("  CarregarDoCursor : " + [bool]($conteudo -match "CarregarDoCursor"))
Write-Host ("  Inserir          : " + [bool]($conteudo -match "Inserir"))
Write-Host ("  Atualizar        : " + [bool]($conteudo -match "Atualizar"))

$validado = $false
if ($conteudo -match "CarregarDoCursor" -and (($conteudo -match "Inserir" -and $conteudo -match "Atualizar") -or $boSomenteLeitura)) {
    $tamanho = [math]::Round((Get-Item $boFile).Length / 1KB, 2)
    Write-Host ''
    Write-Host ("  [OK] BO completado com metodos CRUD: $boFile ($tamanho KB)") -ForegroundColor Green
    $validado = $true
} else {
    Write-Host ''
    Write-Host '  [FALHA] BO existe mas faltam metodos CRUD (CarregarDoCursor, Inserir, Atualizar)' -ForegroundColor Red
}

# ---------------------------- Test-CompletudeCodigo ----------------------------
Write-Host ''
Write-Host '--- Test-CompletudeCodigo ---'
$problemas = @()
foreach ($m in [regex]::Matches($conteudo, "(?im)^\s*\*\-?\-?\s*(TODO|FIXME|HACK|XXX|PLACEHOLDER)\b")) {
    $problemas += "Marcador: $($m.Value.Trim())"
}
foreach ($m in [regex]::Matches($conteudo, "(?ims)PROCEDURE\s+(\w+)\s*(\(.*?\))?\s*\r?\n(.*?)ENDPROC")) {
    $procName = $m.Groups[1].Value
    $body = $m.Groups[3].Value
    if ($body -match "DODEFAULT\(\)") { continue }
    $procParams = $m.Groups[2].Value
    if ($procName -match "^Tecla" -and $procParams -match "par_nKeyCode") { continue }
    $codeLines = ($body -split "`n" | Where-Object { $_ -match "\S" -and $_ -notmatch "^\s*\*" -and $_ -notmatch "^\s*&&" } | Measure-Object).Count
    if ($codeLines -eq 0) { $problemas += "Procedure vazia: $procName" }
}
foreach ($m in [regex]::Matches($conteudo, "(?im)\*.*?(implementar\s+(depois|later|futur)|pr[oô]xima\s+fase|\bpendente|nao\s+implement)")) {
    $problemas += "Indicador de pendencia: $($m.Value.Trim())"
}
foreach ($m in [regex]::Matches($conteudo, '(?im)MsgAviso\(.+?(implementad|ser.{1,5}\s+implementad|n.o\s+dispon.vel|em\s+desenvolvimento)')) {
    $problemas += "Stub com MsgAviso placeholder"
}
if ($problemas.Count -eq 0) {
    Write-Host '  [OK] nenhum TODO/stub/procedure vazia detectado' -ForegroundColor Green
} else {
    foreach ($p in $problemas) { Write-Host ("  - " + $p) -ForegroundColor Yellow }
}

Write-Host ''
if ($validado -and $problemas.Count -eq 0) { Write-Host 'FASE 2: PASSA' -ForegroundColor Green; exit 0 }
if (-not $validado) { Write-Host 'FASE 2: REPROVA' -ForegroundColor Red; exit 1 }
Write-Host 'FASE 2: PASSA (com avisos de completude)' -ForegroundColor Yellow
exit 0
