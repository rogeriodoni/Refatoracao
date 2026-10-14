<#
.SYNOPSIS
    Acusa JOIN/predicado SQL que compara colunas char de COLLATIONS DIFERENTES.

.DESCRIPTION
    O DB_MBAHIA tem DUAS collations convivendo: o default Latin1_General_CI_AS
    (205 tabelas) e SQL_Latin1_General_CP1_CI_AS (609 tabelas). Comparar uma
    coluna de cada grupo faz o SQL Server RECUSAR a query inteira:

        "Nao foi possivel resolver o conflito de ordenacao entre
         SQL_Latin1_General_CP1_CI_AS e Latin1_General_CI_AS na operacao equal to"

    O .prg COMPILA LIMPO - o erro so aparece em RUNTIME, quando o usuario abre a
    tela. Nao da para deduzir a collation pelo nome nem pelo prefixo da tabela, e
    docs\schema.sql NAO serve: foi gerado com "Script Collation = False" e nao traz
    nenhuma clausula COLLATE. A unica fonte de verdade eh sys.columns.

    Conserto: COLLATE DATABASE_DEFAULT em UM dos lados do predicado.
    Ver CLAUDE.md regra #52. Origem: Erro201 (FormVEN / VENBO).

.PARAMETER Raiz
    Pasta varrida. Default: C:\4c\projeto\app

.PARAMETER MapaCollation
    TSV <tabela>\t<coluna>\t<collation>. Se ausente, o script CONSULTA o banco.
    Sem banco e sem mapa ele AVISA e sai com 0 - nunca inventa defeito.

.PARAMETER Atualizar
    Forca reconsulta ao banco e regrava o cache do mapa.

.EXAMPLE
    powershell -File automation\VerificarCollationJoinSQL.ps1
    powershell -File automation\VerificarCollationJoinSQL.ps1 -Raiz projeto\app\classes
#>
[CmdletBinding()]
param(
    [string] $Raiz          = 'C:\4c\projeto\app',
    [string] $MapaCollation = 'C:\4c\automation\collations_db.tsv',
    [switch] $Atualizar
)

$ErrorActionPreference = 'Stop'

# ---------------------------------------------------------------- mapa
function Get-MapaCollation {
    param([string] $Cache, [switch] $Forcar)

    if ((-not $Forcar) -and (Test-Path -LiteralPath $Cache)) {
        return Get-Content -LiteralPath $Cache
    }

    $cs = 'Server=192.168.200.10;Database=DB_MBAHIA;User Id=4control;' +
          'Password=f2016jstcr%@;TrustServerCertificate=True;Connect Timeout=20'
    try {
        $cn = New-Object System.Data.SqlClient.SqlConnection $cs
        $cn.Open()
        $cmd = $cn.CreateCommand()
        $cmd.CommandText = @'
SELECT t.name, c.name, c.collation_name
FROM sys.columns c JOIN sys.tables t ON t.object_id = c.object_id
WHERE c.collation_name IS NOT NULL
'@
        $rd = $cmd.ExecuteReader()
        $linhas = New-Object System.Collections.Generic.List[string]
        while ($rd.Read()) { $linhas.Add("$($rd[0])`t$($rd[1])`t$($rd[2])") }
        $rd.Close(); $cn.Close()
        $linhas | Set-Content -LiteralPath $Cache -Encoding utf8
        Write-Host "  mapa de collation atualizado do banco: $($linhas.Count) colunas" -ForegroundColor DarkGray
        return $linhas
    } catch {
        return $null
    }
}

$mapaLinhas = Get-MapaCollation -Cache $MapaCollation -Forcar:$Atualizar
if ($null -eq $mapaLinhas) {
    Write-Host 'AVISO: sem mapa de collation (banco inacessivel e cache ausente).' -ForegroundColor Yellow
    Write-Host '       Gere com: -Atualizar, com rota para 192.168.200.10.'        -ForegroundColor Yellow
    Write-Host '       Nenhum defeito foi avaliado.'                              -ForegroundColor Yellow
    exit 0
}

$coll = @{}
foreach ($l in $mapaLinhas) {
    $p = $l -split "`t"
    if ($p.Count -eq 3) { $coll[($p[0] + '.' + $p[1]).ToLower()] = $p[2] }
}

# ---------------------------------------------------------------- varredura
# Palavras que NUNCA sao alias (senao "FROM x WHERE" vira alias "where").
$naoAlias = @('on','where','inner','left','right','full','outer','join','group',
              'order','set','and','or','with','nolock','as','having','union',
              'select','top','distinct','cross','apply','option')

$achados = New-Object System.Collections.Generic.List[object]

foreach ($f in Get-ChildItem -Path $Raiz -Filter *.prg -Recurse) {

    $linhas = Get-Content -LiteralPath $f.FullName

    # Junta continuacoes ";" numa LINHA LOGICA: a SQL quase sempre nasce assim,
    # e sem juntar o parser le argumento pela metade (licao da regra #36).
    $logicas = New-Object System.Collections.Generic.List[object]
    $buf = ''; $ini = 0
    for ($i = 0; $i -lt $linhas.Count; $i++) {
        $t = $linhas[$i].TrimEnd()
        if ($buf -eq '') { $ini = $i + 1 }
        if ($t -match '^\s*\*') { continue }                  # comentario
        if ($t -match ';\s*$')  { $buf += ($t -replace ';\s*$',''); continue }
        $buf += $t
        if ($buf.Trim() -ne '') { $logicas.Add([pscustomobject]@{ linha = $ini; txt = $buf }) }
        $buf = ''
    }
    if ($buf.Trim() -ne '') { $logicas.Add([pscustomobject]@{ linha = $ini; txt = $buf }) }

    foreach ($lg in $logicas) {

        # So o conteudo das strings: a SQL vem concatenada com "+".
        $sql = (([regex]::Matches($lg.txt, '"([^"]*)"') |
                 ForEach-Object { $_.Groups[1].Value }) -join ' ')
        if ($sql -notmatch '(?i)\bjoin\b' -or $sql -notmatch '(?i)\bfrom\b') { continue }

        # alias -> tabela. Cobre "FROM t a", "JOIN t a" E a lista com virgula
        # (", SigMvItn b with(nolock)") - sem isso o alias fica orfao e o
        # predicado nao chega a ser avaliado.
        $sqlA  = $sql -replace '(?i)\s+with\s*\(\s*nolock\s*\)', ' '
        $alias = @{}
        foreach ($m in [regex]::Matches($sqlA,
                 '(?i)(?:\b(?:from|join)\s+|,\s*)(?:\[dbo\]\.)?\[?(\w+)\]?\s+(?:as\s+)?(\w+)\b')) {
            $tb = $m.Groups[1].Value
            $al = $m.Groups[2].Value.ToLower()
            if ($al -in $naoAlias) { continue }
            # Alias amarrado a duas tabelas no MESMO statement: marcar ambiguo em
            # vez de chutar (mesma colisao das regras #11/#44/#48).
            if ($alias.ContainsKey($al)) {
                if ($alias[$al] -ne $tb) { $alias[$al] = '<<AMBIGUO>>' }
            } else { $alias[$al] = $tb }
        }
        if ($alias.Count -lt 2) { continue }

        foreach ($m in [regex]::Matches($sql, '(\w+)\.(\w+)\s*=\s*(\w+)\.(\w+)')) {
            $a1 = $m.Groups[1].Value.ToLower(); $c1 = $m.Groups[2].Value.ToLower()
            $a2 = $m.Groups[3].Value.ToLower(); $c2 = $m.Groups[4].Value.ToLower()
            if (-not $alias.ContainsKey($a1) -or -not $alias.ContainsKey($a2)) { continue }
            $t1 = $alias[$a1]; $t2 = $alias[$a2]
            if ($t1 -eq '<<AMBIGUO>>' -or $t2 -eq '<<AMBIGUO>>') { continue }

            $k1 = "$t1.$c1".ToLower(); $k2 = "$t2.$c2".ToLower()
            # Ausente do mapa = coluna nao-char (collation NULL) ou inexistente:
            # nos dois casos nao ha conflito de ordenacao a acusar.
            if (-not $coll.ContainsKey($k1) -or -not $coll.ContainsKey($k2)) { continue }
            if ($coll[$k1] -eq $coll[$k2]) { continue }

            # Ja corrigido? COLLATE na vizinhanca do predicado.
            $de     = [Math]::Max(0, $m.Index - 40)
            $trecho = $sql.Substring($de, [Math]::Min(120, $sql.Length - $de))
            if ($trecho -match '(?i)\bcollate\b') { continue }

            $achados.Add([pscustomobject]@{
                Arquivo = $f.FullName.Replace('C:\4c\', '')
                Linha   = $lg.linha
                Pred    = $m.Value
                Esq     = "$t1.$c1 [$($coll[$k1])]"
                Dir     = "$t2.$c2 [$($coll[$k2])]"
            })
        }
    }
}

# ---------------------------------------------------------------- saida
if ($achados.Count -eq 0) {
    Write-Host 'OK: nenhum JOIN comparando collations diferentes.' -ForegroundColor Green
    exit 0
}

Write-Host ''
Write-Host "ERRO: $($achados.Count) predicado(s) comparando COLLATIONS DIFERENTES" -ForegroundColor Red
Write-Host '      (o SQL Server recusa a query; a tela nao abre)' -ForegroundColor Red
Write-Host ''
foreach ($a in ($achados | Sort-Object Arquivo, Linha)) {
    Write-Host ("  {0}:{1}" -f $a.Arquivo, $a.Linha) -ForegroundColor Yellow
    Write-Host ("      {0}" -f $a.Pred)
    Write-Host ("      ESQ {0}" -f $a.Esq) -ForegroundColor DarkGray
    Write-Host ("      DIR {0}" -f $a.Dir) -ForegroundColor DarkGray
}
Write-Host ''
Write-Host 'CONSERTO: COLLATE DATABASE_DEFAULT em UM dos lados do predicado.' -ForegroundColor Cyan
Write-Host '          " ... ON a.col COLLATE DATABASE_DEFAULT = b.col"'       -ForegroundColor Cyan
exit 1
