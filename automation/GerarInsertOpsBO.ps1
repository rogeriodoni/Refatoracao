# =============================================================================
# GerarInsertOpsBO.ps1 - Erro307
#
# Gera o bloco VFP do INSERT de SigCdOpe cobrindo as 248 colunas NOT NULL SEM
# DEFAULT (regra #22). A lista vem do BANCO (INFORMATION_SCHEMA), nao do
# docs/schema.sql - que nao registra DEFAULT e por isso nao distingue "NOT NULL
# obrigatoria" de "NOT NULL com default" (licao do Erro302).
#
# O legado grava com TABLEUPDATE sobre um cursor de "SELECT *": TODA coluna vai
# junto, com o branco/zero que o cursor trouxe. O equivalente em SQL explicito
# e este INSERT completo.
#
# Valor por coluna:
#   - coluna editada na tela -> property do BO
#   - char/varchar           -> EscaparSQL("")
#   - numeric/decimal        -> FormatarNumeroSQL(0, <escala>)
#   - bit                    -> 0
# =============================================================================
$csv = 'C:\4c\automation\_erro307_obrigatorias.csv'
$h   = 'COLUMN_NAME','DATA_TYPE','tam','prec','esc'

$cols = Import-Csv $csv -Header $h |
        ForEach-Object {
            $_.COLUMN_NAME = $_.COLUMN_NAME.Trim()
            $_.DATA_TYPE   = $_.DATA_TYPE.Trim()
            $_
        } |
        Where-Object { $_.DATA_TYPE -ne 'data_type' -and $_.COLUMN_NAME }

# colunas que a TELA edita -> property do BO
$mapa = @{
    'dopes'    = 'EscaparSQL(ALLTRIM(THIS.this_cDopes))'
    'ndopes'   = 'FormatarNumeroSQL(THIS.this_nNDopes, 0)'
    'titopes'  = 'EscaparSQL(THIS.this_cTitOpes)'
    'menus'    = 'EscaparSQL(THIS.this_cMenus)'
    'submenus' = 'EscaparSQL(THIS.this_cSubMenus)'
    'ordes'    = 'FormatarNumeroSQL(THIS.this_nOrdes, 0)'
    'cmoes'    = 'EscaparSQL(THIS.this_cCmoes)'
    'copers'   = 'FormatarNumeroSQL(THIS.this_nCopers, 0)'
    'tipoops'  = 'FormatarNumeroSQL(THIS.this_nTipoOps, 0)'
    'abrevs'   = 'EscaparSQL(THIS.this_cAbrevs)'
    'nivels'   = 'EscaparSQL(THIS.this_cNivels)'
    'nfiscals' = 'FormatarNumeroSQL(THIS.this_nNFiscals, 0)'
}

$nomes  = New-Object System.Collections.ArrayList
$vals   = New-Object System.Collections.ArrayList
$daTela = 0

foreach ($c in $cols) {
    $nome = $c.COLUMN_NAME
    [void]$nomes.Add($nome)
    if ($mapa.ContainsKey($nome.ToLower())) {
        [void]$vals.Add($mapa[$nome.ToLower()])
        $daTela++
    }
    else {
        switch -Regex ($c.DATA_TYPE) {
            '^(char|varchar|nchar|nvarchar)$' { [void]$vals.Add('EscaparSQL("")'); break }
            '^(numeric|decimal|int|smallint|tinyint|money|float|real)$' {
                $esc = 0
                if ($c.esc -match '^\d+$') { $esc = [int]$c.esc }
                [void]$vals.Add("FormatarNumeroSQL(0, $esc)"); break
            }
            '^bit$' { [void]$vals.Add('"0"'); break }
            default { [void]$vals.Add('EscaparSQL("")') }
        }
    }
}

# obsopes nao e obrigatoria, mas tem dado da tela: incluir
[void]$nomes.Add('ObsOpes')
[void]$vals.Add('EscaparSQL(THIS.this_cObsOpes)')

$sb = New-Object System.Text.StringBuilder
[void]$sb.AppendLine('            *-- Erro307 / regra #22: SigCdOpe tem 248 colunas NOT NULL e')
[void]$sb.AppendLine('            *-- NENHUMA com DEFAULT (conferido no INFORMATION_SCHEMA do banco,')
[void]$sb.AppendLine('            *-- nao no docs/schema.sql, que nao registra default). O INSERT')
[void]$sb.AppendLine('            *-- listava 13 e o SQL Server recusava a gravacao inteira:')
[void]$sb.AppendLine('            *--   "Nao e possivel inserir o valor NULL na coluna cfgfinancs".')
[void]$sb.AppendLine('            *-- O legado grava com TABLEUPDATE sobre cursor de SELECT *, entao')
[void]$sb.AppendLine('            *-- TODA coluna ia junto com o branco/zero do cursor - e o que este')
[void]$sb.AppendLine('            *-- INSERT reproduz. Bloco GERADO por automation\GerarInsertOpsBO.ps1.')
[void]$sb.AppendLine('            *-- A montagem e feita em INSTRUCOES SEPARADAS, nao numa linha')
[void]$sb.AppendLine('            *-- logica gigante com "+ ;": com ~320 continuacoes o compilador')
[void]$sb.AppendLine('            *-- do VFP9 PENDURA (medido - o COMPILE nunca retorna).')
[void]$sb.AppendLine('            loc_cSQL = "INSERT INTO SigCdOpe ("')

# nomes: uma instrucao a cada 4 colunas
for ($i = 0; $i -lt $nomes.Count; $i += 4) {
    $fim = [Math]::Min($i + 3, $nomes.Count - 1)
    $parte = ($nomes[$i..$fim] -join ', ')
    $sufixo = if ($fim -lt $nomes.Count - 1) { ',' } else { '' }
    [void]$sb.AppendLine('            loc_cSQL = loc_cSQL + "' + $parte + $sufixo + ' "')
}
[void]$sb.AppendLine('            loc_cSQL = loc_cSQL + ") VALUES ("')
for ($i = 0; $i -lt $vals.Count; $i++) {
    $sep = if ($i -lt $vals.Count - 1) { ' + ","' } else { '' }
    [void]$sb.AppendLine('            loc_cSQL = loc_cSQL + ' + $vals[$i] + $sep)
}
[void]$sb.AppendLine('            loc_cSQL = loc_cSQL + ")"')

$saida = 'C:\4c\automation\_erro307_insert_gerado.txt'
[System.IO.File]::WriteAllText($saida, $sb.ToString(), (New-Object System.Text.UTF8Encoding($false)))

Write-Host ""
Write-Host "colunas no INSERT : $($nomes.Count)   (obrigatorias $($cols.Count) + ObsOpes)"
Write-Host "vindas da tela    : $daTela de $($mapa.Count) mapeadas"
Write-Host "valores           : $($vals.Count)"
Write-Host "pareamento ok     : $($nomes.Count -eq $vals.Count)"
$naoUsadas = $mapa.Keys | Where-Object { $_ -notin ($cols.COLUMN_NAME | ForEach-Object { $_.ToLower() }) }
if ($naoUsadas) { Write-Host "ATENCAO - do mapa, nao encontradas na tabela: $($naoUsadas -join ', ')" }
Write-Host "saida             : $saida"
