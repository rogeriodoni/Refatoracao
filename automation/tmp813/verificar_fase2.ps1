$ErrorActionPreference = 'Stop'
$f = 'C:\4c\projeto\app\classes\SigOpTotBO.prg'
$enc = [System.Text.Encoding]::GetEncoding(28591)
$t = [System.IO.File]::ReadAllText($f, $enc)
$CR = [string][char]13; $LF = [string][char]10
$lines = $t.Split(@($CR + $LF), [System.StringSplitOptions]::None)

Write-Host '=== 1. LINE ENDINGS ==='
$nCRLF = ([regex]::Matches($t, [regex]::Escape($CR + $LF))).Count
$nLFsolto = ([regex]::Matches($t, '(?<!' + [regex]::Escape($CR) + ')' + [regex]::Escape($LF))).Count
Write-Host ("  CRLF=$nCRLF  LF-solto=$nLFsolto  linhas=" + $lines.Count)

Write-Host ''
Write-Host '=== 2. BALANCEAMENTO ==='
# conta apenas linhas de codigo (fora de comentario * e &&)
$codigo = @()
foreach ($l in $lines) {
    $s = $l.Trim()
    if ($s -eq '' -or $s.StartsWith('*')) { continue }
    $p = $s.IndexOf('&&')
    if ($p -ge 0) { $s = $s.Substring(0, $p).Trim() }
    if ($s -ne '') { $codigo += $s }
}
function Cnt([string]$re) { ($codigo | Where-Object { $_ -match $re } | Measure-Object).Count }
$pares = @(
  @('TRY',        '^TRY$',                                   '^ENDTRY$',    'ENDTRY'),
  @('DO CASE',    '^DO\s+CASE$',                             '^ENDCASE$',   'ENDCASE'),
  @('SCAN',       '^SCAN\b',                                 '^ENDSCAN$',   'ENDSCAN'),
  @('WITH',       '^WITH\b',                                 '^ENDWITH$',   'ENDWITH'),
  @('IF',         '^IF\b',                                   '^ENDIF$',     'ENDIF'),
  @('PROCEDURE',  '^(PROTECTED\s+|HIDDEN\s+)?PROCEDURE\b',   '^ENDPROC$',   'ENDPROC'),
  @('FUNCTION',   '^(PROTECTED\s+|HIDDEN\s+)?FUNCTION\b',    '^ENDFUNC$',   'ENDFUNC')
)
$falhou = $false
foreach ($p in $pares) {
    $a = Cnt $p[1]; $b = Cnt $p[2]
    $ok = ($a -eq $b)
    if (-not $ok) { $falhou = $true }
    Write-Host ("  {0,-10} {1,3} x {2,-8} {3,3}   {4}" -f $p[0], $a, $p[3], $b, $(if ($ok) {'OK'} else {'*** DESBALANCEADO ***'}))
}

Write-Host ''
Write-Host '=== 3. RETURN DENTRO DE TRY/CATCH (regra #1) ==='
$prof = 0; $achou = 0
for ($i = 0; $i -lt $lines.Count; $i++) {
    $s = $lines[$i].Trim()
    if ($s.StartsWith('*')) { continue }
    $p = $s.IndexOf('&&'); if ($p -ge 0) { $s = $s.Substring(0,$p).Trim() }
    if ($s -match '^TRY$')    { $prof++ ; continue }
    if ($s -match '^ENDTRY$') { $prof-- ; continue }
    if ($prof -gt 0 -and $s -match '^RETURN\b') {
        Write-Host ("  *** linha " + ($i+1) + ": " + $s)
        $achou++
    }
}
if ($achou -eq 0) { Write-Host '  OK - nenhum RETURN dentro de TRY/CATCH' } else { $falhou = $true }

Write-Host ''
Write-Host '=== 4. TOKENS DO GATE DA FASE 2 ==='
foreach ($tok in @('CarregarDoCursor','Inserir','Atualizar')) {
    $n = ([regex]::Matches($t, [regex]::Escape($tok))).Count
    $m = if ($t -match [regex]::Escape($tok)) { 'presente' } else { '*** AUSENTE ***' }
    if ($n -eq 0) { $falhou = $true }
    Write-Host ("  {0,-18} {1,3} ocorrencia(s)  {2}" -f $tok, $n, $m)
}

Write-Host ''
Write-Host '=== 5. METODOS DECLARADOS ==='
foreach ($m in [regex]::Matches($t, '(?im)^\s*((?:PROTECTED\s+|HIDDEN\s+)?(?:PROCEDURE|FUNCTION))\s+(\w+)')) {
    Write-Host ("  " + $m.Groups[1].Value.PadRight(20) + $m.Groups[2].Value)
}

Write-Host ''
Write-Host '=== 6. LEITURA DE FLAG FORA DE CarregarDoCursor ==='
$resid = [regex]::Matches($t, '(?i)crSigCdOpe\.(ChkQtds|PesoVts|PrecoVts|HabServs|TotCompos|Opers|Cmoes)|crSigOpCd[cd]\.(DocQtd2s|MtCubs)')
if ($resid.Count -eq 0) {
    Write-Host '  OK - nenhuma leitura direta dessas colunas sobrou no codigo'
} else {
    foreach ($r in $resid) {
        $ln = ($t.Substring(0, $r.Index).Split(@($CR+$LF), [System.StringSplitOptions]::None)).Count
        $txt = $lines[$ln-1].Trim()
        $eComentario = $txt.StartsWith('*')
        Write-Host ("  linha $ln " + $(if ($eComentario) {'(comentario, ok)'} else {'*** CODIGO ***'}) + ": " + $r.Value)
        if (-not $eComentario) { $falhou = $true }
    }
}

Write-Host ''
Write-Host '=== 7. FRASES QUE O VALIDADOR DE COMPLETUDE REPROVA ==='
$bad = [regex]::Matches($t, '(?im)\*.*?(implementar\s+(depois|later|futur)|pr[o]xima\s+fase|\bpendente|nao\s+implement)')
if ($bad.Count -eq 0) { Write-Host '  OK - nenhuma' } else { $falhou = $true; foreach ($b in $bad) { Write-Host ('  *** ' + $b.Value.Trim()) } }

Write-Host ''
Write-Host '=== 8. ARMADILHAS VFP9 ==='
$arm = @(
  @('ISEMPTY(',                  '(?i)\bISEMPTY\s*\('),
  @('(variavel).campo',          '\(\s*(?:THIS\.)?(?:loc|par|this)_\w+\s*\)\s*\.'),
  @('MESSAGEBOX direto',         '(?i)^\s*(?:=\s*)?MESSAGEBOX\s*\('),
  @('PUBLIC em DEFINE CLASS',    '(?im)^\s*PUBLIC\s+(PROCEDURE|FUNCTION)\b'),
  @('.Self',                     '(?i)\.Self\b'),
  @('EVALUATE com atribuicao',   '(?i)EVALUATE\s*\(\s*"[^"]*=\s*'),
  @('COUNT TO ... IN',           '(?i)\bCOUNT\s+TO\s+\w+\s+IN\b'),
  @('MostrarAviso',              '(?i)\bMostrarAviso\s*\('),
  @('IIF com num no 1o arg',     '(?i)IIF\s*\(\s*\w+\.Value\s*,')
)
foreach ($a in $arm) {
    $n = ([regex]::Matches($t, $a[1])).Count
    if ($n -gt 0) { $falhou = $true }
    Write-Host ("  {0,-26} {1}" -f $a[0], $(if ($n -eq 0) {'OK (0)'} else {"*** $n OCORRENCIA(S) ***"}))
}

Write-Host ''
if ($falhou) { Write-Host 'RESULTADO: HA PROBLEMAS' -ForegroundColor Red; exit 1 }
Write-Host 'RESULTADO: TODAS AS VERIFICACOES PASSARAM' -ForegroundColor Green
