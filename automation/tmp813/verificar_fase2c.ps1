$ErrorActionPreference = 'Stop'
$f = 'C:\4c\projeto\app\classes\SigOpTotBO.prg'
$enc = [System.Text.Encoding]::GetEncoding(28591)
$t = [System.IO.File]::ReadAllText($f, $enc)
$CR = [string][char]13; $LF = [string][char]10
$lines = $t.Split(@($CR + $LF), [System.StringSplitOptions]::None)

$semComLinhas = @()
foreach ($l in $lines) {
    $s = $l
    if ($s.Trim().StartsWith('*')) { $semComLinhas += '' ; continue }
    $p = $s.IndexOf('&&')
    if ($p -ge 0) { $s = $s.Substring(0, $p) }
    $semComLinhas += $s
}
$codigo = $semComLinhas -join $LF
$falhou = $false

Write-Host '=== 9. this_ props: usadas (em CODIGO) x declaradas ==='
$decl = @{}
foreach ($m in [regex]::Matches($t, '(?im)^\s{4}(this_\w+)\s*=')) { $decl[$m.Groups[1].Value.ToUpper()] = $true }
$herdadas = @('THIS_CTABELA','THIS_CCAMPOCHAVE','THIS_CMENSAGEMERRO','THIS_LEMEDICAO',
              'THIS_LNOVOREGISTRO','THIS_LDADOSALTERADOS','THIS_ODATAACCESS','THIS_LERROEXIBIDO')
$faltando = @{}
foreach ($m in [regex]::Matches($codigo, '(?i)THIS\.(this_\w+)')) {
    $n = $m.Groups[1].Value.ToUpper()
    if (-not $decl.ContainsKey($n) -and $herdadas -notcontains $n) { $faltando[$n] = $true }
}
Write-Host ('  declaradas: ' + $decl.Count)
if ($faltando.Count -eq 0) { Write-Host '  OK - nenhuma usada sem declarar' }
else { $falhou = $true; foreach ($k in $faltando.Keys) { Write-Host ('  *** USADA SEM DECLARAR: ' + $k) } }

Write-Host ''
Write-Host '=== 11. funcoes chamadas em CODIGO que nao sao VFP nem helper conhecido ==='
$metDef = @{}
foreach ($m in [regex]::Matches($t, '(?im)^\s*(?:PROTECTED\s+|HIDDEN\s+)?(?:PROCEDURE|FUNCTION)\s+(\w+)')) { $metDef[$m.Groups[1].Value.ToUpper()] = $true }
$helpersOk = @('ESCAPARSQL','FORMATARNUMEROSQL','FORMATARDATASQL','TRATARNULO','CAPTURARERROSQL',
               'MSGERRO','MSGAVISO','MSGINFO','MSGCONFIRMA','MOSTRARERRO','FUNIQUEIDS',
               'CONVERTERPARADATA','CONVERTERPARALOGICO','CENTRALIZAR')
$vfp = @('IIF','EMPTY','ALLTRIM','UPPER','LOWER','VARTYPE','TYPE','USED','EOF','BOF','RECCOUNT','RECNO',
         'EVALUATE','NVL','ISNULL','VAL','STR','TRANSFORM','CHR','ABS','ROUND','INLIST','SUM',
         'PEMSTATUS','SEEK','DATE','DATETIME','PADR','LEFT','RIGHT','SUBSTR','SQLEXEC','DODEFAULT',
         'CREATEOBJECT','BETWEEN','MAX','MIN','SPACE','LEN','DELETED','DBF','FCOUNT','FIELD')
$desc = @{}
foreach ($m in [regex]::Matches($codigo, '(?im)(?<![\w.])([A-Za-z_]\w{2,})\s*\(')) {
    $n = $m.Groups[1].Value.ToUpper()
    if ($helpersOk -contains $n -or $vfp -contains $n -or $metDef.ContainsKey($n)) { continue }
    if ($n -match '^(IF|DO|FOR|WHILE|CASE|AND|OR|NOT|RETURN|THEN|ELSE|ENDIF|WITH|SCAN|SELECT|COUNT|SET)$') { continue }
    $desc[$n] = $true
}
if ($desc.Count -eq 0) { Write-Host '  OK - nenhuma funcao desconhecida chamada' }
else { foreach ($k in $desc.Keys) { Write-Host ('  [conferir] ' + $k) } }

Write-Host ''
Write-Host '=== 12. INSERT em SigTempD: colunas NOT NULL cobertas ==='
$mi = [regex]::Match($codigo, '(?i)INSERT INTO SigTempD \(([^)]*)\)')
if (-not $mi.Success) { Write-Host '  *** nenhum INSERT encontrado'; $falhou = $true }
else {
    $cols = ($mi.Groups[1].Value -split ',') | ForEach-Object { $_.Trim().ToLower() }
    Write-Host ('  colunas no INSERT: ' + ($cols -join ', '))
    foreach ($nn in @('cidchaves','dpros')) {
        if ($cols -contains $nn) { Write-Host ("    [OK] NOT NULL '$nn' coberta") }
        else { Write-Host ("    *** NOT NULL '$nn' AUSENTE"); $falhou = $true }
    }
}

Write-Host ''
if ($falhou) { Write-Host 'RESULTADO: HA PROBLEMAS' -ForegroundColor Red; exit 1 }
Write-Host 'RESULTADO: OK' -ForegroundColor Green
