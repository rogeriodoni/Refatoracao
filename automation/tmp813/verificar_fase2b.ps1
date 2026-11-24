$ErrorActionPreference = 'Stop'
$f = 'C:\4c\projeto\app\classes\SigOpTotBO.prg'
$enc = [System.Text.Encoding]::GetEncoding(28591)
$t = [System.IO.File]::ReadAllText($f, $enc)
$CR = [string][char]13; $LF = [string][char]10
$lines = $t.Split(@($CR + $LF), [System.StringSplitOptions]::None)

# monta versao do arquivo SEM comentarios (linha iniciada por * e cauda &&),
# preservando o numero de linha
$semCom = New-Object 'System.Collections.Generic.List[string]'
foreach ($l in $lines) {
    $s = $l
    if ($s.Trim().StartsWith('*')) { $semCom.Add('') ; continue }
    $p = $s.IndexOf('&&')
    if ($p -ge 0) { $s = $s.Substring(0, $p) }
    $semCom.Add($s)
}
$falhou = $false

function Scan([string]$rotulo, [string]$re) {
    $achou = 0
    for ($i = 0; $i -lt $script:semCom.Count; $i++) {
        if ($script:semCom[$i] -match $re) {
            Write-Host ("  *** " + $rotulo + " linha " + ($i+1) + ": " + $script:semCom[$i].Trim())
            $achou++
        }
    }
    if ($achou -eq 0) { Write-Host ("  {0,-30} OK" -f $rotulo) } else { $script:falhou = $true }
}

Write-Host '=== 6b. LEITURA DE FLAG FORA DE CarregarDoCursor (so codigo) ==='
Scan 'leitura direta de flag' '(?i)crSigCdOpe\.(ChkQtds|PesoVts|PrecoVts|HabServs|TotCompos|Opers|Cmoes)|crSigOpCd[cd]\.(DocQtd2s|MtCubs)'

Write-Host ''
Write-Host '=== 8b. ARMADILHAS VFP9 (so codigo) ==='
Scan 'ISEMPTY('                '(?i)\bISEMPTY\s*\('
Scan '(variavel).campo'        '\(\s*(?:THIS\.)?(?:loc|par|this)_\w+\s*\)\s*\.'
Scan 'MESSAGEBOX direto'       '(?i)(?:^|=\s*)MESSAGEBOX\s*\('
Scan 'PUBLIC PROC/FUNC'        '(?i)^\s*PUBLIC\s+(PROCEDURE|FUNCTION)\b'
Scan '.Self'                   '(?i)\.Self\b'
Scan 'EVALUATE atribuindo'     '(?i)EVALUATE\s*\(\s*"[^"]*=\s*'
Scan 'COUNT TO ... IN'         '(?i)\bCOUNT\s+TO\s+\w+\s+IN\b'
Scan 'MostrarAviso'            '(?i)\bMostrarAviso\s*\('
Scan 'IF ... THEN inline'      '(?i)^\s*IF\b.*\bTHEN\b'
Scan 'RETURN em PROC vazia'    '(?i)^\s*TABLEREVERT\s*\('

Write-Host ''
Write-Host '=== 9. this_ props usadas x declaradas ==='
$decl = @{}
foreach ($m in [regex]::Matches($t, '(?im)^\s{4}(this_\w+)\s*=')) { $decl[$m.Groups[1].Value.ToUpper()] = $true }
$herdadas = @('THIS_CTABELA','THIS_CCAMPOCHAVE','THIS_CMENSAGEMERRO','THIS_LEMEDICAO',
              'THIS_LNOVOREGISTRO','THIS_LDADOSALTERADOS','THIS_ODATAACCESS','THIS_LERROEXIBIDO')
$faltando = @{}
foreach ($m in [regex]::Matches($t, '(?i)THIS\.(this_\w+)')) {
    $n = $m.Groups[1].Value.ToUpper()
    if (-not $decl.ContainsKey($n) -and $herdadas -notcontains $n) { $faltando[$n] = $true }
}
if ($faltando.Count -eq 0) {
    Write-Host ('  OK - ' + $decl.Count + ' properties declaradas, nenhuma usada sem declarar')
} else {
    $falhou = $true
    foreach ($k in $faltando.Keys) { Write-Host ("  *** USADA SEM DECLARAR: " + $k) }
}

Write-Host ''
Write-Host '=== 10. metodos THIS.<x>() chamados x definidos ==='
$metDef = @{}
foreach ($m in [regex]::Matches($t, '(?im)^\s*(?:PROTECTED\s+|HIDDEN\s+)?(?:PROCEDURE|FUNCTION)\s+(\w+)')) { $metDef[$m.Groups[1].Value.ToUpper()] = $true }
$baseMet = @('SALVAR','EXCLUIR','BUSCAR','NOVOREGISTRO','EDITARREGISTRO','CANCELAREDICAO',
             'LIMPARDADOS','VALIDARDADOS','REGISTRARAUDITORIA','ATUALIZAR','EXIBIRFALHA',
             'ANTESDEGRAVAR','DEPOISDEGRAVAR','ANTESDEEXCLUIR','DEPOISDEEXCLUIR',
             'INICIALIZARVALORESPADRAO','MARCARCOMOALTERADO','OBTERMENSAGEMERRO','ADDPROPERTY')
$metFalta = @{}
foreach ($m in [regex]::Matches($t, '(?i)THIS\.(\w+)\s*\(')) {
    $n = $m.Groups[1].Value.ToUpper()
    if (-not $metDef.ContainsKey($n) -and $baseMet -notcontains $n) { $metFalta[$n] = $true }
}
if ($metFalta.Count -eq 0) {
    Write-Host ('  OK - ' + $metDef.Count + ' metodos definidos, nenhuma chamada orfa')
} else {
    $falhou = $true
    foreach ($k in $metFalta.Keys) { Write-Host ("  *** CHAMADO SEM DEFINIR: " + $k) }
}

Write-Host ''
Write-Host '=== 11. helpers globais usados ==='
$helpersOk = @('ESCAPARSQL','FORMATARNUMEROSQL','FORMATARDATASQL','TRATARNULO','CAPTURARERROSQL',
               'MSGERRO','MSGAVISO','MSGINFO','MSGCONFIRMA','MOSTRARERRO','FUNIQUEIDS',
               'CONVERTERPARADATA','CONVERTERPARALOGICO','CENTRALIZAR')
$vfp = @('IIF','EMPTY','ALLTRIM','UPPER','LOWER','VARTYPE','TYPE','USED','EOF','BOF','RECCOUNT','RECNO',
         'SELECT','EVALUATE','NVL','ISNULL','VAL','STR','TRANSFORM','CHR','ABS','ROUND','INLIST',
         'PEMSTATUS','SEEK','DATE','DATETIME','PADR','LEFT','RIGHT','SUBSTR','SQLEXEC','DODEFAULT',
         'CREATEOBJECT','MESSAGEBOX','BETWEEN','MAX','MIN','SUM','COUNT','SPACE','LEN','OCCURS','AT',
         'FILE','FULLPATH','JUSTPATH','ADDBS','SYS','SET','CURSORGETPROP','CURSORSETPROP','TABLEREVERT',
         'TABLEUPDATE','GETDATE','DELETED','FCOUNT','FIELD','AFIELDS','ASCAN','ALEN','STRTOFILE')
$desc = @{}
foreach ($m in [regex]::Matches($t, '(?im)(?<![\w.])([A-Za-z_]\w{2,})\s*\(')) {
    $n = $m.Groups[1].Value.ToUpper()
    if ($helpersOk -contains $n) { continue }
    if ($vfp -contains $n) { continue }
    if ($metDef.ContainsKey($n)) { continue }
    if ($n -match '^(IF|DO|FOR|WHILE|CASE|AND|OR|NOT|RETURN|THEN|ELSE|ENDIF|WITH|SCAN)$') { continue }
    $desc[$n] = $true
}
if ($desc.Count -eq 0) { Write-Host '  OK - nenhuma funcao desconhecida' }
else { foreach ($k in $desc.Keys) { Write-Host ("  [conferir] " + $k) } }

Write-Host ''
if ($falhou) { Write-Host 'RESULTADO: HA PROBLEMAS' -ForegroundColor Red; exit 1 }
Write-Host 'RESULTADO: OK' -ForegroundColor Green
