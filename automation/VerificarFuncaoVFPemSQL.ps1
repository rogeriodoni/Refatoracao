# =============================================================================
# VerificarFuncaoVFPemSQL.ps1 - Erro306
#
# Acha funcao do VFP escrita DENTRO de string SQL. O .prg compila limpo e o
# erro so aparece em RUNTIME, vindo do SQL Server:
#   "'NVL' nao e um nome da funcao interna reconhecido."
#
# A distincao que importa: NVL(cursor.campo) em codigo VFP e CORRETO; o que
# quebra e NVL(...) dentro de uma string que vai para o SQLEXEC. Por isso o
# detector so olha o conteudo ENTRE ASPAS.
#
# Mapa VFP -> T-SQL:
#   NVL(x, y)      -> ISNULL(x, y)
#   ALLTRIM(x)     -> LTRIM(RTRIM(x))
#   EMPTY(x)       -> (x IS NULL OR x = '')
#   IIF(c, a, b)   -> CASE WHEN c THEN a ELSE b END   (SQL 2012+: IIF existe)
#   AT(a, b)       -> CHARINDEX(a, b)
#   PADR/PADL      -> nao existem
#   TRANSFORM(x)   -> CAST(x AS varchar)
#   DATE()/DATETIME() -> GETDATE()
#   CTOD/DTOC/DTOS -> CONVERT(...)
#   STR(x)         -> CAST(x AS varchar)
#   OCCURS, RAT, STRTRAN(ok no T-SQL e REPLACE), SUBSTR -> SUBSTRING
# =============================================================================
[CmdletBinding()]
param(
    [string] $Pasta = 'C:\4c\projeto\app',
    [string] $Arquivo = '',
    [switch] $Detalhar
)

# funcoes VFP que NAO existem em T-SQL (ou tem nome diferente)
$mapa = [ordered]@{
    'NVL'       = 'ISNULL'
    'ALLTRIM'   = 'LTRIM(RTRIM(...))'
    'PADR'      = 'nao existe em T-SQL'
    'PADL'      = 'nao existe em T-SQL'
    'EMPTY'     = "(x IS NULL OR x = '')"
    'TRANSFORM' = 'CAST(... AS varchar)'
    'CTOD'      = 'CONVERT(date, ...)'
    'DTOC'      = 'CONVERT(varchar, ...)'
    'DTOS'      = 'CONVERT(varchar(8), ..., 112)'
    'OCCURS'    = 'nao existe em T-SQL'
    'SUBSTR'    = 'SUBSTRING'
    'AT'        = 'CHARINDEX'
    'RAT'       = 'nao existe em T-SQL'
    'VARTYPE'   = 'nao existe em T-SQL'
    'INLIST'    = 'IN (...)'
    'BETWEEN'   = 'BETWEEN ... AND ...'
    'STRTRAN'   = 'REPLACE'
    'PROPER'    = 'nao existe em T-SQL'
    'CHRTRAN'   = 'nao existe em T-SQL'
}

$arquivos = Get-ChildItem -Path $Pasta -Filter '*.prg' -Recurse -File |
            Where-Object { $_.Name -notlike '*.bak*' }
if ($Arquivo) { $arquivos = $arquivos | Where-Object { $_.BaseName -ieq $Arquivo } }

$achados = New-Object System.Collections.ArrayList

foreach ($arq in $arquivos) {
    $linhas = [System.IO.File]::ReadAllLines($arq.FullName)
    for ($i = 0; $i -lt $linhas.Count; $i++) {
        $l = $linhas[$i]
        if ($l.Trim().StartsWith('*')) { continue }     # comentario

        # extrair TODO conteudo entre aspas duplas e entre aspas simples
        $trechos = @()
        foreach ($m in [regex]::Matches($l, '"([^"]*)"')) { $trechos += $m.Groups[1].Value }
        foreach ($m in [regex]::Matches($l, "'([^']*)'"))  { $trechos += $m.Groups[1].Value }
        if ($trechos.Count -eq 0) { continue }

        foreach ($t in $trechos) {
            foreach ($fn in $mapa.Keys) {
                # funcao seguida de "(" e precedida de nao-identificador
                if ($t -match "(?i)(^|[^A-Za-z0-9_])$fn\s*\(") {
                    [void]$achados.Add([pscustomobject]@{
                        Arquivo = $arq.Name
                        Pasta   = $arq.Directory.Name
                        Linha   = $i + 1
                        Funcao  = $fn
                        TSQL    = $mapa[$fn]
                        Trecho  = $t.Trim()
                        Codigo  = $l.Trim()
                    })
                }
            }
        }
    }
}

# filtrar: so interessa se a string tem CARA de SQL
$comCaraDeSql = $achados | Where-Object {
    $_.Trecho -match '(?i)\b(SELECT|FROM|WHERE|INSERT|UPDATE|DELETE|JOIN|ORDER BY|GROUP BY|SET|VALUES|AND|OR|AS)\b'
}

# "cara de SQL" NAO basta: o VFP tem o PROPRIO dialeto SQL, e nele as funcoes
# VFP sao VALIDAS. Medido no Erro306: dos 4 achados, 3 eram falso positivo -
# dois iam para "SELECT ... INTO CURSOR" (SQL do VFP sobre cursor local) e um
# para "SET FILTER TO &var". So quebra o que chega ao SQLEXEC.
# Por isso: rastrear a variavel que recebe a string ate o destino.
$porArquivo = $comCaraDeSql | Group-Object Arquivo
$sqlish = New-Object System.Collections.ArrayList
foreach ($g in $porArquivo) {
    $arqObj = $arquivos | Where-Object { $_.Name -eq $g.Name } | Select-Object -First 1
    if (-not $arqObj) { continue }
    $txt  = [System.IO.File]::ReadAllText($arqObj.FullName)
    $todas = [System.IO.File]::ReadAllLines($arqObj.FullName)
    foreach ($a in $g.Group) {
        # A linha pode ser CONTINUACAO de uma concatenacao (" ... " + ;):
        # subir ate a atribuicao para descobrir a variavel de destino.
        $var = ''
        for ($k = $a.Linha - 1; $k -ge [Math]::Max(0, $a.Linha - 12); $k--) {
            if ($todas[$k] -match '(?i)^\s*(\w+)\s*=') { $var = $Matches[1]; break }
        }

        $destino = 'INDEFINIDO'
        if ($var) {
            $v = [regex]::Escape($var)
            $vaiSqlExec = $txt -match "(?i)SQLEXEC\s*\([^)]*\b$v\b"
            # SQL do VFP: SET FILTER TO &var | LOCATE FOR ... &var |
            # &var usado dentro de um SELECT que termina em INTO CURSOR
            # (a clausula pode estar varias linhas adiante - janela de 400 chars)
            $vaiVfp = ($txt -match "(?i)SET\s+FILTER\s+TO\s*&\s*$v") -or
                      ($txt -match "(?i)LOCATE\s+FOR[^\r\n]*&$v") -or
                      ($txt -match "(?is)&$v\b.{0,400}?INTO\s+CURSOR")
            if     ($vaiSqlExec -and -not $vaiVfp) { $destino = 'SQLEXEC' }
            elseif ($vaiVfp -and -not $vaiSqlExec) { $destino = 'VFP' }
            elseif ($vaiSqlExec -and $vaiVfp)      { $destino = 'AMBOS' }
        }
        if ($a.Codigo -match '(?i)SQLEXEC\s*\(') { $destino = 'SQLEXEC' }

        $a | Add-Member -NotePropertyName Destino -NotePropertyValue $destino -Force
        $a | Add-Member -NotePropertyName Var     -NotePropertyValue $var     -Force
        if ($destino -ne 'VFP') { [void]$sqlish.Add($a) }
    }
}

Write-Host ""
Write-Host "=============================================================="
Write-Host " FUNCAO DO VFP DENTRO DE STRING SQL   (Erro306)"
Write-Host "=============================================================="
Write-Host " arquivos varridos           : $($arquivos.Count)"
Write-Host " ocorrencias em string       : $($achados.Count)"
Write-Host " com CARA de SQL (relevantes): $($sqlish.Count)"
Write-Host ""

if ($sqlish.Count -gt 0) {
    Write-Host " --- por funcao ---"
    $sqlish | Group-Object Funcao | Sort-Object Count -Descending |
        ForEach-Object { "   {0,-10} {1,4} sites   -> T-SQL: {2}" -f $_.Name, $_.Count, $mapa[$_.Name] }
    Write-Host ""
    Write-Host " --- por arquivo ---"
    $sqlish | Group-Object Arquivo | Sort-Object Count -Descending |
        ForEach-Object {
            "   {0,-26} {1,3} sites  ({2})" -f $_.Name, $_.Count,
                (($_.Group | ForEach-Object { $_.Funcao } | Sort-Object -Unique) -join ',')
        }
}

if ($Detalhar) {
    Write-Host ""
    $sqlish | Sort-Object Arquivo, Linha | ForEach-Object {
        "   {0}:{1}  [{2}]  {3}" -f $_.Arquivo, $_.Linha, $_.Funcao, $_.Codigo
    }
}

$sqlish | Export-Csv 'C:\4c\automation\_funcao_vfp_em_sql.csv' -NoTypeInformation -Encoding UTF8
Write-Host ""
Write-Host " csv: C:\4c\automation\_funcao_vfp_em_sql.csv"
