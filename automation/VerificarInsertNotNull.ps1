#==============================================================================
# VerificarInsertNotNull.ps1
#
# PROPOSITO: encontra BOs cujo INSERT INTO omite coluna NOT NULL sem DEFAULT.
#            O SQL Server rejeita com "Nao eh possivel inserir o valor NULL na
#            coluna '<col>' ... a coluna nao permite nulos. Falha em INSERT."
#            e o cadastro fica sem conseguir incluir (Erro151, AliBO/reincids).
#
# USO:
#   .\VerificarInsertNotNull.ps1                 # relatorio na tela
#   .\VerificarInsertNotNull.ps1 -Csv saida.csv  # tambem grava CSV
#
# Le os metadados de INFORMATION_SCHEMA e faz o parse dos blocos
# `INSERT INTO <tabela> (col, col, ...)` dos *BO.prg (a lista de colunas pode
# estar quebrada em varias linhas com o continuador `+ ;` do VFP).
#
# LIMITACOES CONHECIDAS (o resultado eh uma LISTA DE CANDIDATOS, sempre conferir
# o INSERT no arquivo antes de mexer):
#   - SQL montado em varias atribuicoes (`loc_cSQL = loc_cSQL + "..."`) faz a
#     captura parar antes do fim da lista: colunas do final aparecem como
#     "faltando" mesmo estando presentes (visto em SRVBO/codrecirrf e
#     sigopdivBO/docus,tmpmins).
#   - Colunas gemeas (ex.: SIGCDROM tem `tipo` E `tipos`; SIGCDCLC tem
#     `prioridade` E `prioridades`; SIGOPPIC tem `imprs` E `iimprs`) sao faceis
#     de confundir na leitura do relatorio — conferir o nome exato.
#   - Um mesmo arquivo pode aparecer duas vezes quando tem dois INSERT na mesma
#     tabela; um deles pode ja estar correto.
# Falsos NEGATIVOS nao acontecem: se a coluna eh NOT NULL sem default e nao
# esta na lista capturada, o INSERT falha mesmo.
#==============================================================================

param(
    [string]$Csv = "",
    [string]$Servidor = "192.168.200.10",
    [string]$Banco    = "DB_MBAHIA",
    [string]$Usuario  = "4control",
    [string]$Senha    = "f2016jstcr%@",
    [string]$PastaBOs = "C:\4c\projeto\app\classes"
)

$ErrorActionPreference = "Stop"

# ---------------------------------------------------------------- metadados
$cs = "Server=$Servidor;Database=$Banco;User Id=$Usuario;Password=$Senha;Connect Timeout=30"
$cn = New-Object System.Data.SqlClient.SqlConnection $cs
$cn.Open()
$cmd = $cn.CreateCommand()
# IDENTITY e colunas computadas nao entram no INSERT: o banco as gera sozinho.
# Sem esse filtro o relatorio acusa LOGAUDITORIA.ID (identity) em dezenas de BOs.
$cmd.CommandText = @"
SELECT c.TABLE_NAME, c.COLUMN_NAME, c.IS_NULLABLE, c.COLUMN_DEFAULT
  FROM INFORMATION_SCHEMA.COLUMNS c
 WHERE COLUMNPROPERTY(OBJECT_ID(QUOTENAME(c.TABLE_SCHEMA) + '.' + QUOTENAME(c.TABLE_NAME)), c.COLUMN_NAME, 'IsIdentity') = 0
   AND COLUMNPROPERTY(OBJECT_ID(QUOTENAME(c.TABLE_SCHEMA) + '.' + QUOTENAME(c.TABLE_NAME)), c.COLUMN_NAME, 'IsComputed') = 0
"@
$rd = $cmd.ExecuteReader()

$obrigatorias = @{}   # tabela (upper) -> colunas NOT NULL sem default (upper)
$todas        = @{}   # tabela (upper) -> todas as colunas (upper)
while ($rd.Read()) {
    $tab = $rd[0].ToString().ToUpper()
    $col = $rd[1].ToString().ToUpper()
    if (-not $todas.ContainsKey($tab))        { $todas[$tab] = @() }
    if (-not $obrigatorias.ContainsKey($tab)) { $obrigatorias[$tab] = @() }
    $todas[$tab] += $col
    if ($rd[2].ToString() -eq 'NO' -and [string]::IsNullOrEmpty($rd[3].ToString())) {
        $obrigatorias[$tab] += $col
    }
}
$rd.Close()
$cn.Close()
Write-Host "Metadados carregados: $($todas.Count) tabelas" -ForegroundColor Cyan

# ---------------------------------------------------------------- analise
$rxInsert = [regex]'(?is)INSERT\s+INTO\s+(\w+)\s*\((.*?)\)\s*"?\s*\+?\s*;?\s*"?\s*VALUES'
$achados = @()

foreach ($arq in (Get-ChildItem -Path $PastaBOs -Filter '*BO.prg' -File)) {
    $txt = [System.IO.File]::ReadAllText($arq.FullName)
    # Remove comentarios ANTES de qualquer coisa: uma linha como
    #   *-- INSERT INTO SigInBep (rastreio: cidchaves + empdnps + empdopnums)
    # casava no regex e a captura nao-gulosa engolia ate o INSERT real, gerando
    # lista de colunas truncada e falso positivo (visto em SigPrGstBO).
    $linhas = $txt -split "`r?`n" | Where-Object { $_ -notmatch '^\s*(\*|&&)' }
    $txt = $linhas -join "`r`n"
    # junta as continuacoes de linha do VFP para o regex enxergar a lista inteira
    $plano = $txt -replace '"\s*\+\s*;\s*\r?\n\s*"', ''

    foreach ($m in $rxInsert.Matches($plano)) {
        $tabela = $m.Groups[1].Value.ToUpper()
        if (-not $obrigatorias.ContainsKey($tabela)) { continue }   # tabela desconhecida

        # `[local]`, `[key]` etc: nome delimitado por colchetes (palavra reservada no
        # SQL Server). Sem remover os colchetes o token nao casa `^\w+$` e a coluna
        # aparece como "faltando" mesmo estando no INSERT (falso positivo em CHMBO).
        $lista = ($m.Groups[2].Value -replace '"', ' ') -replace '[\[\]]', ''
        $cols  = @($lista -split ',' | ForEach-Object { $_.Trim().ToUpper() } | Where-Object { $_ -match '^\w+$' })
        if ($cols.Count -eq 0) { continue }

        $faltando = @($obrigatorias[$tabela] | Where-Object { $cols -notcontains $_ })
        if ($faltando.Count -gt 0) {
            $linha = ($plano.Substring(0, $m.Index) -split "`n").Count
            $achados += [PSCustomObject]@{
                BO        = $arq.Name
                Tabela    = $tabela
                Faltando  = ($faltando -join ', ')
                Colunas   = $cols.Count
                LinhaAprox = $linha
            }
            Write-Host ("[FALTA NOT NULL] {0,-22} {1,-14} -> {2}" -f $arq.Name, $tabela, ($faltando -join ', ')) -ForegroundColor Red
        }
    }
}

Write-Host ""
Write-Host "BOs com INSERT incompleto: $($achados.Count)" -ForegroundColor $(if ($achados.Count -gt 0) { "Red" } else { "Green" })

if ($Csv -ne "") {
    $achados | Export-Csv -Path $Csv -NoTypeInformation -Encoding UTF8
    Write-Host "CSV gravado em $Csv" -ForegroundColor Cyan
}
