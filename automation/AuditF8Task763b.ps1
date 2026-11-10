$raiz = 'C:\4c'
# Helpers GLOBais: nome do arquivo (resolucao por nome de .prg) + FUNCTION/PROCEDURE dentro de utils\*.prg
$globais = New-Object System.Collections.Generic.HashSet[string] ([StringComparer]::OrdinalIgnoreCase)
foreach ($u in (Get-ChildItem "$raiz\projeto\app\utils\*.prg")) {
    [void]$globais.Add($u.BaseName)
    foreach ($m in [regex]::Matches((Get-Content $u.FullName -Raw),'(?im)^\s*(?:PROCEDURE|FUNCTION)\s+(\w+)')) {
        [void]$globais.Add($m.Groups[1].Value)
    }
}
foreach ($c in @('formbase','businessbase','gridbase','dataaccess','FormErro')) {
    $p = "$raiz\projeto\app\classes\$c.prg"
    if (Test-Path $p) { foreach ($m in [regex]::Matches((Get-Content $p -Raw),'(?im)^\s*(?:PROTECTED\s+|HIDDEN\s+)?(?:PROCEDURE|FUNCTION)\s+(\w+)')) { [void]$globais.Add($m.Groups[1].Value) } }
}
$vfpTxt = Get-Content "$raiz\automation\vfp_builtins.txt" -Raw -ErrorAction SilentlyContinue
$vfp = @('IIF','ALLTRIM','TRIM','RTRIM','LTRIM','UPPER','LOWER','LEFT','RIGHT','SUBSTR','LEN','CHR','ASC','STR','VAL','TRANSFORM',
'PADR','PADL','PADC','SPACE','REPLICATE','EMPTY','ISNULL','NVL','VARTYPE','TYPE','PEMSTATUS','USED','EOF','BOF','RECCOUNT','RECNO',
'DATE','DATETIME','TTOD','DTOC','CTOD','INLIST','BETWEEN','MAX','MIN','ABS','ROUND','INT','SQLEXEC','CREATEOBJECT','BINDEVENT',
'UNBINDEVENTS','AEVENTS','FILE','FULLPATH','JUSTPATH','ADDBS','SYS','SET','STRTOFILE','ADIR','OCCURS','STRTRAN','LASTKEY',
'DODEFAULT','CURSORGETPROP','TABLEREVERT','EVALUATE','SEEK','DBF','ALIAS','RGB','AMEMBERS','DELETED','SELECT')
foreach ($v in $vfp) { [void]$globais.Add($v) }

foreach ($alvo in @(
    @{ Tag='FORM'; Path="$raiz\projeto\app\forms\operacionais\FormSigOpLoc.prg" },
    @{ Tag='BO';   Path="$raiz\projeto\app\classes\SigOpLocBO.prg" })) {
    $txt = Get-Content $alvo.Path -Raw
    $meus = ([regex]::Matches($txt,'(?im)^\s*(?:PROTECTED\s+|HIDDEN\s+)?(?:PROCEDURE|FUNCTION)\s+(\w+)') | ForEach-Object { $_.Groups[1].Value })
    # tira comentario de linha (*) E comentario inline (&&)
    $uteis = @($txt -split "`r?`n" | Where-Object { $_.Trim() -notmatch '^\*' } | ForEach-Object { ($_ -replace '&&.*','') })
    $orf = @()
    foreach ($m in [regex]::Matches(($uteis -join "`n"),'(?<![\w\.])([A-Za-z_]\w{2,})\s*\(')) {
        $c = $m.Groups[1].Value
        if ($globais.Contains($c)) { continue }
        if ($meus -contains $c)    { continue }
        $orf += $c
    }
    Write-Host ("{0}: chamadas_nao_resolvidas={1}  {2}" -f $alvo.Tag, ($orf | Select-Object -Unique).Count, (($orf | Select-Object -Unique) -join ', '))
}
