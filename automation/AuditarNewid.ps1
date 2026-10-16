# AuditarNewid.ps1
# Para cada BO que usa NEWID(), descobre qual COLUNA recebe a chave e compara
# com a largura real no schema. GUID do SQL Server = 36 chars; coluna char(N)
# com N < 36 faz o INSERT falhar com "dados seriam truncados" (Erro223).
#
# schema.sql eh UTF-16 - ler com Get-Content -Raw (CLAUDE.md #14).

$ErrorActionPreference = 'Stop'
$schema = Get-Content 'C:\4c\docs\schema.sql' -Raw

function Get-Largura {
    param($tabela, $coluna)
    $m = [regex]::Match($schema, "(?is)CREATE TABLE \[dbo\]\.\[$tabela\].*?\r?\n\s*\)")
    if (-not $m.Success) { return $null }
    $c = [regex]::Match($m.Value, "(?im)^\s*\[$coluna\]\s*\[(n?var)?char\]\((\d+)\)")
    if ($c.Success) { return [int]$c.Groups[2].Value }
    if ([regex]::IsMatch($m.Value, "(?im)^\s*\[$coluna\]\s*\[uniqueidentifier\]")) { return 'GUID' }
    return $null
}

$arquivos = Get-ChildItem 'C:\4c\projeto\app\classes\*.prg' |
            Where-Object { $_.Name -notlike '*.bak' }

$res = @()
foreach ($f in $arquivos) {
    $txt = Get-Content $f.FullName -Raw

    # NEWID() em codigo, ignorando linhas de comentario (* ou && )
    $linhasCod = ($txt -split "`r?`n") | Where-Object {
        $_ -match 'NEWID\(\)' -and $_ -notmatch '^\s*\*' -and $_ -notmatch '^\s*&&'
    }
    if (-not $linhasCod) { continue }

    # TODOS os INSERT INTO com lista de colunas; escolhe o que tem a chave
    $tabela = ''; $colChave = ''
    foreach ($m in [regex]::Matches($txt, '(?is)INSERT\s+INTO\s+\[?(\w+)\]?\s*"?\s*\+?\s*"?\s*\(([^)]*)\)')) {
        $cols = $m.Groups[2].Value
        foreach ($cand in @('cidchaves','pkchaves','cidchave','idchaves')) {
            if ($cols -match "(?i)(^|[\s,(""+])$cand\s*($|[\s,)""+])") {
                $tabela = $m.Groups[1].Value
                $colChave = $cand
                break
            }
        }
        if ($colChave) { break }
    }

    $larg = '?'
    if ($tabela -and $colChave) {
        $v = Get-Largura -tabela $tabela -coluna $colChave
        if ($null -ne $v) { $larg = "$v" }
    }

    # Truncamento tem de estar PERTO do NEWID (mesma linha ou ate 6 linhas abaixo,
    # onde mora a atribuicao da chave). Procurar no arquivo inteiro dava falso
    # negativo: qualquer LEFT( em outro metodo marcava o BO como seguro.
    $arr = $txt -split "`r?`n"
    $temLeft = 'nao'
    for ($i = 0; $i -lt $arr.Count; $i++) {
        if ($arr[$i] -notmatch 'NEWID\(\)') { continue }
        if ($arr[$i] -match '^\s*\*' -or $arr[$i] -match '^\s*&&') { continue }
        $fim = [Math]::Min($i + 6, $arr.Count - 1)
        $jan = ($arr[$i..$fim]) -join "`n"
        if ($jan -match '(?i)LEFT\s*\(' -or $jan -match '(?i)varchar\s*\(\s*20\s*\)' -or $jan -match '(?i)SUBSTR\s*\(') {
            $temLeft = 'sim'
        }
    }

    $veredito = 'INDETERMINADO'
    if ($larg -eq 'GUID')            { $veredito = 'OK (coluna GUID)' }
    elseif ($larg -match '^\d+$') {
        if ([int]$larg -ge 36)       { $veredito = 'OK (cabe)' }
        elseif ($temLeft -eq 'sim')  { $veredito = 'OK (LEFT trunca)' }
        else                         { $veredito = '*** QUEBRA ***' }
    }

    $res += [pscustomobject]@{
        BO       = $f.Name
        Tabela   = $tabela
        Chave    = $colChave
        Largura  = $larg
        LEFT     = $temLeft
        Veredito = $veredito
    }
}

$res | Sort-Object @{e={$_.Veredito -ne '*** QUEBRA ***'}}, BO | Format-Table -AutoSize
""
$q = ($res | Where-Object { $_.Veredito -eq '*** QUEBRA ***' }).Count
$i = ($res | Where-Object { $_.Veredito -eq 'INDETERMINADO' }).Count
"TOTAL=$($res.Count)   QUEBRA=$q   INDETERMINADO=$i"
