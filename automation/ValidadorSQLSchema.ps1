<#
.SYNOPSIS
    Valida nomes de colunas SQL em arquivos .prg contra o schema.sql e/ou banco SQL Server
.DESCRIPTION
    Analise estatica (sem LLM) que:
    1. Parseia schema.sql para extrair tabelas e colunas
    2. Opcionalmente consulta INFORMATION_SCHEMA.COLUMNS do SQL Server (DB first, fallback schema.sql)
    3. Parseia arquivos .prg para extrair referencias SQL (SELECT, INSERT, UPDATE, DELETE)
    4. Valida se as colunas referenciadas existem no schema
    5. Valida tipos de dados em CREATE CURSOR vs schema
.PARAMETER FormFile
    Caminho do arquivo .prg do formulario
.PARAMETER BOFile
    Caminho do arquivo .prg do Business Object
.PARAMETER SchemaFile
    Caminho do schema.sql (default: C:\4c\docs\schema.sql)
.PARAMETER DbServer
    Servidor SQL Server (opcional). Ex: "192.168.15.101,1435"
.PARAMETER DbName
    Nome do banco de dados (opcional). Ex: "DB_MBAHIA"
.PARAMETER DbUser
    Usuario SQL Server (opcional). Ex: "sa"
.PARAMETER DbPass
    Senha SQL Server (opcional)
.OUTPUTS
    Array de strings com problemas encontrados. Vazio = sem problemas.
.EXAMPLE
    $problemas = & .\ValidadorSQLSchema.ps1 -FormFile "C:\4c\projeto\app\forms\cadastros\FormCor.prg"
.EXAMPLE
    $problemas = & .\ValidadorSQLSchema.ps1 -FormFile "FormCor.prg" -DbServer "192.168.15.101,1435" -DbName "DB_MBAHIA" -DbUser "sa" -DbPass "pwd"
#>
param(
    [Parameter(Mandatory=$true)]
    [string]$FormFile,

    [string]$BOFile = "",

    [string]$SchemaFile = "C:\4c\docs\schema.sql",

    [string]$DbServer = "",
    [string]$DbName = "",
    [string]$DbUser = "",
    [string]$DbPass = ""
)

# Cache de schema obtido do banco (por tabela)
$script:SchemaDBCache = @{}
$script:DbConnectionString = ""

# Determinar se temos conexao DB disponivel
$script:UseDB = ($DbServer -ne "" -and $DbName -ne "" -and $DbUser -ne "" -and $DbPass -ne "")
if ($script:UseDB) {
    $script:DbConnectionString = "Server=$DbServer;Database=$DbName;User Id=$DbUser;Password=$DbPass;"
}

# ============================================================================
# FUNCAO: Get-SchemaFromDB - Consulta INFORMATION_SCHEMA.COLUMNS do SQL Server
# ============================================================================
function Get-SchemaFromDB {
    param([string]$TableName)

    $tableKey = $TableName.ToLower()

    # Retornar do cache se ja consultado
    if ($script:SchemaDBCache.ContainsKey($tableKey)) {
        return $script:SchemaDBCache[$tableKey]
    }

    $columns = @{}

    try {
        $conn = New-Object System.Data.SqlClient.SqlConnection
        $conn.ConnectionString = $script:DbConnectionString
        $conn.Open()

        $cmd = $conn.CreateCommand()
        $cmd.CommandText = "SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @TableName"
        $cmd.Parameters.AddWithValue("@TableName", $TableName) | Out-Null

        $reader = $cmd.ExecuteReader()
        while ($reader.Read()) {
            $colName = $reader["COLUMN_NAME"].ToString().ToLower()
            $dataType = $reader["DATA_TYPE"].ToString().ToLower()
            $columns[$colName] = $dataType
        }
        $reader.Close()
        $conn.Close()
    }
    catch {
        Write-Warning "Erro ao consultar DB para tabela '$TableName': $($_.Exception.Message)"
    }

    # Cachear resultado (mesmo vazio, para nao re-consultar)
    $script:SchemaDBCache[$tableKey] = $columns

    return $columns
}

# ============================================================================
# FUNCAO: Get-SchemaForTable - Tenta DB primeiro, fallback para schema.sql
# ============================================================================
function Get-SchemaForTable {
    param(
        [string]$TableName,
        [hashtable]$FileSchema
    )

    $tableKey = $TableName.ToLower()

    # Tentar DB primeiro (se disponivel)
    if ($script:UseDB) {
        $dbColumns = Get-SchemaFromDB -TableName $TableName
        if ($dbColumns.Count -gt 0) {
            return $dbColumns
        }
    }

    # Fallback: schema.sql parseado
    if ($FileSchema.ContainsKey($tableKey)) {
        return $FileSchema[$tableKey]
    }

    return @{}
}

# ============================================================================
# FUNCAO: Parse-Schema - Extrai tabelas e colunas do schema.sql
# ============================================================================
function Parse-Schema {
    param([string]$SchemaFile)

    $schema = @{}  # @{ "tabela_lower" = @{ "coluna_lower" = "tipo_original"; ... } }

    if (-not $SchemaFile -or -not (Test-Path $SchemaFile)) {
        Write-Warning "Schema file not found: $SchemaFile"
        return $schema
    }

    $content = Get-Content $SchemaFile -Raw -Encoding UTF8

    # Pattern para CREATE TABLE [dbo].[NomeTabela] ( ... )
    # O schema.sql tem caracteres estranhos (espacados), entao usamos pattern flexivel
    $tablePattern = 'CREATE\s+TABLE\s+\[dbo\]\.\[(\w+)\]'
    $tableMatches = [regex]::Matches($content, $tablePattern, 'IgnoreCase')

    foreach ($tm in $tableMatches) {
        $tableName = $tm.Groups[1].Value.ToLower()
        $startPos = $tm.Index + $tm.Length

        # Encontrar o bloco de colunas (ate CONSTRAINT ou proximo CREATE)
        $endPos = $content.Length
        $constraintMatch = [regex]::Match($content.Substring($startPos), '(?i)\bCONSTRAINT\b|\bCREATE\b')
        if ($constraintMatch.Success) {
            $endPos = $startPos + $constraintMatch.Index
        }

        $block = $content.Substring($startPos, $endPos - $startPos)

        # Extrair colunas: [nome_coluna] [tipo](tamanho)
        $colPattern = '\[(\w+)\]\s+\[(\w+)\]'
        $colMatches = [regex]::Matches($block, $colPattern)

        if (-not $schema.ContainsKey($tableName)) {
            $schema[$tableName] = @{}
        }

        foreach ($cm in $colMatches) {
            $colName = $cm.Groups[1].Value.ToLower()
            $colType = $cm.Groups[2].Value.ToLower()

            # Ignorar nomes que sao tipos SQL (nao colunas)
            if ($colType -in @('not','null','primary','key','clustered','asc','desc','on','off',
                               'pad_index','statistics_norecompute','ignore_dup_key','allow_row_locks',
                               'allow_page_locks','optimize_for_sequential_key','default')) {
                continue
            }

            $schema[$tableName][$colName] = $colType
        }
    }

    # Segundo pass: capturar colunas adicionadas via ALTER TABLE ADD
    $alterPattern = '(?i)ALTER\s+TABLE\s+\[dbo\]\.\[(\w+)\]\s+ADD\s+\[(\w+)\]\s+\[(\w+)\]'
    $alterMatches = [regex]::Matches($content, $alterPattern)
    foreach ($am in $alterMatches) {
        $tblName = $am.Groups[1].Value.ToLower()
        $colName = $am.Groups[2].Value.ToLower()
        $colType = $am.Groups[3].Value.ToLower()
        if ($schema.ContainsKey($tblName)) {
            if (-not $schema[$tblName].ContainsKey($colName)) {
                $schema[$tblName][$colName] = $colType
            }
        }
    }

    return $schema
}

# ============================================================================
# FUNCAO: Extract-SQLReferences - Extrai tabela.coluna de statements SQL
# ============================================================================
function Extract-SQLReferences {
    param(
        [string]$Content,
        [hashtable]$Schema
    )

    $references = @()
    $lines = $Content -split "`n"

    # Primeiro: reconstruir statements SQL multi-linha
    # Detectar linhas com loc_cSQL = "SELECT..." ou concatenacoes + ;
    $sqlStatements = @()
    $currentSQL = ""
    $currentStartLine = 0
    $inSQL = $false

    for ($i = 0; $i -lt $lines.Count; $i++) {
        $line = $lines[$i].TrimEnd()

        # Detectar inicio de SQL: variavel = "SELECT|INSERT|UPDATE|DELETE..."
        if ($line -match '(?i)=\s*[\["]?\s*(SELECT|INSERT\s+INTO|UPDATE|DELETE\s+FROM)\b') {
            $inSQL = $true
            $currentSQL = $line
            $currentStartLine = $i + 1
        }
        elseif ($inSQL) {
            $currentSQL += " " + $line
        }

        # Detectar fim do SQL (linha sem continuacao ;)
        if ($inSQL -and $line -notmatch ';\s*$' -and $line -notmatch '\+\s*;?\s*$') {
            $sqlStatements += [PSCustomObject]@{
                SQL = $currentSQL
                StartLine = $currentStartLine
            }
            $inSQL = $false
            $currentSQL = ""
        }
    }

    # Se ficou SQL pendente
    if ($inSQL -and $currentSQL) {
        $sqlStatements += [PSCustomObject]@{
            SQL = $currentSQL
            StartLine = $currentStartLine
        }
    }

    # Post-processar: juntar strings VFP9 multi-linha (remover " + ; \n "  artefatos)
    # Pattern: " + ;  seguido de espacos opcionais e "  ->  substituir por espaco simples
    for ($j = 0; $j -lt $sqlStatements.Count; $j++) {
        $cleanSQL = $sqlStatements[$j].SQL
        # Remove VFP9 string concatenation: " + ; <whitespace> "
        $cleanSQL = $cleanSQL -replace '"\s*\+\s*;\s*"', ' '
        # Remove remaining line-continuation semicolons at end of quoted strings: " ;  (standalone)
        $cleanSQL = $cleanSQL -replace '"\s*;\s*$', '"'
        $sqlStatements[$j].SQL = $cleanSQL
    }

    return $sqlStatements
}

# ============================================================================
# FUNCAO: Validate-SelectColumns - Valida colunas em SELECT statements
# ============================================================================
function Validate-SelectColumns {
    param(
        [string]$SQL,
        [int]$LineNumber,
        [hashtable]$Schema
    )

    $problemas = @()

    # Extrair tabela(s) do FROM/JOIN com alias
    # Pattern: FROM TableName alias | JOIN TableName alias
    $aliasMap = @{}  # alias -> tablename_lower

    $fromPattern = '(?i)\bFROM\s+(\w+)\s+(\w+)'
    $fromMatches = [regex]::Matches($SQL, $fromPattern)
    foreach ($m in $fromMatches) {
        $table = $m.Groups[1].Value
        $alias = $m.Groups[2].Value
        if ($alias -notin @('WHERE','SET','ORDER','GROUP','HAVING','INNER','LEFT','RIGHT','OUTER','JOIN','ON','AND','OR','AS','INTO')) {
            $aliasMap[$alias.ToLower()] = $table.ToLower()
        }
    }

    # JOIN TableName alias (LEFT JOIN, INNER JOIN, RIGHT JOIN, CROSS JOIN)
    $joinPattern = '(?i)\bJOIN\s+(\w+)\s+(\w+)'
    $joinMatches = [regex]::Matches($SQL, $joinPattern)
    foreach ($m in $joinMatches) {
        $table = $m.Groups[1].Value
        $alias = $m.Groups[2].Value
        if ($alias -notin @('WHERE','SET','ORDER','GROUP','HAVING','INNER','LEFT','RIGHT','OUTER','JOIN','ON','AND','OR','AS','INTO')) {
            $aliasMap[$alias.ToLower()] = $table.ToLower()
        }
    }

    # FROM TableName sem alias (tabela direta)
    $fromDirectPattern = '(?i)\bFROM\s+(\w+)\b(?!\s+\w+\s*(?:WHERE|SET|ORDER|JOIN|,))'
    $fromDirectMatches = [regex]::Matches($SQL, $fromDirectPattern)
    foreach ($m in $fromDirectMatches) {
        $table = $m.Groups[1].Value.ToLower()
        # Verificar se tabela existe no schema (file ou DB)
        $directTableCols = Get-SchemaForTable -TableName $table -FileSchema $Schema
        if ($directTableCols.Count -gt 0 -and -not $aliasMap.ContainsKey($table)) {
            $aliasMap[$table] = $table
        }
    }

    # Extrair colunas referenciadas: alias.coluna ou tabela.coluna
    $colRefPattern = '(?i)\b(\w+)\.(\w+)\b'
    $colMatches = [regex]::Matches($SQL, $colRefPattern)

    foreach ($cm in $colMatches) {
        $prefix = $cm.Groups[1].Value.ToLower()
        $column = $cm.Groups[2].Value.ToLower()

        # Ignorar prefixos conhecidos que nao sao alias de tabela
        if ($prefix -in @('cursor_4c','dbo','loc','this','par','thisform','sys')) { continue }
        # Ignorar propriedades VFP
        if ($column -in @('value','caption','controlsource','enabled','visible','click','init')) { continue }

        # Verificar se o prefixo eh um alias mapeado a uma tabela
        if ($aliasMap.ContainsKey($prefix)) {
            $tableName = $aliasMap[$prefix]
            $tableColumns = Get-SchemaForTable -TableName $tableName -FileSchema $Schema

            if ($tableColumns.Count -gt 0) {
                if (-not $tableColumns.ContainsKey($column)) {
                    $problemas += "[SQL-SCHEMA] Linha ~$LineNumber`: Coluna '$column' NAO EXISTE na tabela '$tableName' (referenciada como $($cm.Groups[1].Value).$($cm.Groups[2].Value))"
                }
            }
        }
    }

    return $problemas
}

# ============================================================================
# FUNCAO: Validate-InsertColumns - Valida colunas em INSERT statements
# ============================================================================
function Validate-InsertColumns {
    param(
        [string]$SQL,
        [int]$LineNumber,
        [hashtable]$Schema
    )

    $problemas = @()

    # Pattern: INSERT INTO TableName (col1, col2, ...)
    $insertPattern = '(?i)INSERT\s+INTO\s+(\w+)\s*\(([^)]+)\)'
    $insertMatch = [regex]::Match($SQL, $insertPattern)

    if ($insertMatch.Success) {
        $tableName = $insertMatch.Groups[1].Value.ToLower()
        $columnList = $insertMatch.Groups[2].Value

        # Ignorar cursores locais (cursor_4c_*)
        if ($tableName -match '^cursor_4c_') { return $problemas }

        $tableColumns = Get-SchemaForTable -TableName $tableName -FileSchema $Schema
        if ($tableColumns.Count -gt 0) {
            $columns = $columnList -split ',' | ForEach-Object { $_.Trim().ToLower() }
            foreach ($col in $columns) {
                $col = $col -replace '[\[\]]', ''  # Remove brackets
                if ($col -and -not $tableColumns.ContainsKey($col)) {
                    $problemas += "[SQL-SCHEMA] Linha ~$LineNumber`: INSERT coluna '$col' NAO EXISTE na tabela '$tableName'"
                }
            }
        }
    }

    return $problemas
}

# ============================================================================
# FUNCAO: Validate-TableNames - Valida que tabelas em FROM/JOIN existem
# ============================================================================
function Validate-TableNames {
    param(
        [string]$SQL,
        [int]$LineNumber,
        [hashtable]$Schema
    )

    $problemas = @()

    # Coletar nomes de tabelas de FROM e JOIN
    $tableNames = @()

    # FROM TableName (com ou sem alias)
    $fromMatches = [regex]::Matches($SQL, '(?i)\bFROM\s+(\w+)')
    foreach ($m in $fromMatches) {
        $tableNames += $m.Groups[1].Value
    }

    # JOIN TableName (LEFT/INNER/RIGHT/CROSS JOIN)
    $joinMatches = [regex]::Matches($SQL, '(?i)\bJOIN\s+(\w+)')
    foreach ($m in $joinMatches) {
        $tableNames += $m.Groups[1].Value
    }

    # INSERT INTO TableName
    $insertMatches = [regex]::Matches($SQL, '(?i)\bINSERT\s+INTO\s+(\w+)')
    foreach ($m in $insertMatches) {
        $tableNames += $m.Groups[1].Value
    }

    # UPDATE TableName
    $updateMatches = [regex]::Matches($SQL, '(?i)\bUPDATE\s+(\w+)')
    foreach ($m in $updateMatches) {
        $tableNames += $m.Groups[1].Value
    }

    foreach ($tableName in ($tableNames | Select-Object -Unique)) {
        $tableNameLower = $tableName.ToLower()

        # Ignorar cursores locais e subqueries
        if ($tableNameLower -match '^(cursor_4c_|tmp_|cr[a-z]|#)') { continue }
        # Ignorar palavras-chave SQL que podem ser capturadas
        if ($tableNameLower -in @('select','set','values','where','table')) { continue }

        # Verificar se existe no schema (file ou DB)
        $tableColumns = Get-SchemaForTable -TableName $tableNameLower -FileSchema $Schema
        if ($tableColumns.Count -eq 0) {
            $problemas += "[SQL-SCHEMA] Linha ~$LineNumber`: Tabela '$tableName' NAO EXISTE no banco. Verificar nome correto no schema.sql ou codigo original."
        }
    }

    return $problemas
}

# ============================================================================
# FUNCAO: Validate-UpdateColumns - Valida colunas em UPDATE statements
# ============================================================================
function Validate-UpdateColumns {
    param(
        [string]$SQL,
        [int]$LineNumber,
        [hashtable]$Schema
    )

    $problemas = @()

    # Pattern: UPDATE TableName SET col1 = val, col2 = val WHERE ...
    $updatePattern = '(?i)UPDATE\s+(\w+)\s+SET\s+(.*?)(?:\s+WHERE\b|$)'
    $updateMatch = [regex]::Match($SQL, $updatePattern)

    if ($updateMatch.Success) {
        $tableName = $updateMatch.Groups[1].Value.ToLower()
        $setClause = $updateMatch.Groups[2].Value

        $tableColumns = Get-SchemaForTable -TableName $tableName -FileSchema $Schema
        if ($tableColumns.Count -gt 0) {
            # Extrair nomes de colunas do SET: col = valor
            $setColPattern = '(?i)\b(\w+)\s*='
            $setMatches = [regex]::Matches($setClause, $setColPattern)

            foreach ($sm in $setMatches) {
                $col = $sm.Groups[1].Value.ToLower()
                # Ignorar keywords
                if ($col -in @('and','or','not','where','set')) { continue }
                if (-not $tableColumns.ContainsKey($col)) {
                    $problemas += "[SQL-SCHEMA] Linha ~$LineNumber`: UPDATE coluna '$col' NAO EXISTE na tabela '$tableName'"
                }
            }
        }

        # Validar WHERE clause tambem
        $wherePattern = '(?i)WHERE\s+(.*?)$'
        $whereMatch = [regex]::Match($SQL, $wherePattern)
        if ($whereMatch.Success) {
            $whereClause = $whereMatch.Groups[1].Value
            $whereColPattern = '(?i)\b(\w+)\s*='
            $whereMatches = [regex]::Matches($whereClause, $whereColPattern)
            foreach ($wm in $whereMatches) {
                $col = $wm.Groups[1].Value.ToLower()
                if ($col -in @('and','or','not','where')) { continue }
                $whereTableColumns = Get-SchemaForTable -TableName $tableName -FileSchema $Schema
                if ($whereTableColumns.Count -gt 0 -and -not $whereTableColumns.ContainsKey($col)) {
                    $problemas += "[SQL-SCHEMA] Linha ~$LineNumber`: WHERE coluna '$col' NAO EXISTE na tabela '$tableName'"
                }
            }
        }
    }

    return $problemas
}

# ============================================================================
# FUNCAO: Validate-CursorTypes - Valida tipos CREATE CURSOR vs schema
# ============================================================================
function Validate-CursorTypes {
    param(
        [string]$Content,
        [hashtable]$Schema
    )

    $problemas = @()

    # Mapa de tipos SQL Server -> VFP esperado
    $typeMap = @{
        'char'     = @('C')           # Character
        'varchar'  = @('C','M')       # Character ou Memo
        'nvarchar' = @('C','M')
        'text'     = @('M','C')       # Memo
        'ntext'    = @('M','C')
        'int'      = @('N','I')       # Numeric ou Integer
        'smallint' = @('N','I')
        'tinyint'  = @('N','I')
        'bigint'   = @('N','I')
        'numeric'  = @('N','B','Y')   # Numeric, Double, Currency
        'decimal'  = @('N','B','Y')
        'float'    = @('N','B')
        'real'     = @('N','B')
        'bit'      = @('L','N')       # Logical ou Numeric(1,0)
        'datetime' = @('T','D')       # DateTime ou Date
        'date'     = @('D','T')
        'money'    = @('Y','N')       # Currency
        'smallmoney' = @('Y','N')
    }

    # Encontrar SELECT ... FROM tabela que alimentam cursores via SQLEXEC
    # Pattern: SQLEXEC(handle, sqlvar, "cursor_name")
    $sqlexecPattern = '(?i)SQLEXEC\s*\(\s*\w+\s*,\s*(\w+)\s*,\s*"(cursor_4c_\w+)"\s*\)'
    $sqlexecMatches = [regex]::Matches($Content, $sqlexecPattern)

    foreach ($sem in $sqlexecMatches) {
        $sqlVar = $sem.Groups[1].Value
        $cursorName = $sem.Groups[2].Value

        # Encontrar de qual tabela vem o SELECT
        $sqlBuildPattern = "(?ims)$sqlVar\s*=\s*[`"[].*?FROM\s+(\w+)"
        $sqlBuild = [regex]::Match($Content, $sqlBuildPattern)

        if (-not $sqlBuild.Success) { continue }

        $tableName = $sqlBuild.Groups[1].Value.ToLower()
        $tableColumns = Get-SchemaForTable -TableName $tableName -FileSchema $Schema
        if ($tableColumns.Count -eq 0) { continue }

        # Encontrar CREATE CURSOR correspondente
        $cursorPattern = "(?ims)CREATE\s+CURSOR\s+$cursorName\s*\(((?:[^()]*|\([^()]*\))*)\)"
        $cursorMatch = [regex]::Match($Content, $cursorPattern)

        if (-not $cursorMatch.Success) { continue }

        $cursorDef = $cursorMatch.Groups[1].Value
        $lineNum = ($Content.Substring(0, $cursorMatch.Index) -split "`n").Count

        # Extrair campos e tipos do cursor: NomeCampo TIPO(tamanho)
        $fieldPattern = '(?i)\b(\w+)\s+([CNDTLMBIYF])\s*(?:\(([^)]*)\))?'
        $fieldMatches = [regex]::Matches($cursorDef, $fieldPattern)

        foreach ($fm in $fieldMatches) {
            $fieldName = $fm.Groups[1].Value.ToLower()
            $vfpType = $fm.Groups[2].Value.ToUpper()

            # Ignorar keywords
            if ($fieldName -in @('set','null','on','off','not')) { continue }

            # Verificar se campo existe na tabela
            if ($tableColumns.ContainsKey($fieldName)) {
                $sqlType = $tableColumns[$fieldName]

                if ($typeMap.ContainsKey($sqlType)) {
                    $expectedTypes = $typeMap[$sqlType]
                    if ($vfpType -notin $expectedTypes) {
                        $problemas += "[SQL-TIPO] Linha ~$lineNum`: Cursor '$cursorName' campo '$fieldName' tipo VFP='$vfpType' incompativel com SQL '$sqlType' (esperado: $($expectedTypes -join '/'))"
                    }
                }
            }
        }
    }

    return $problemas
}

# ============================================================================
# MAIN - Execucao principal
# ============================================================================

$allProblemas = @()

# 1. Parsear schema (arquivo)
$schema = Parse-Schema -SchemaFile $SchemaFile

if ($script:UseDB) {
    Write-Host "  [SQL-SCHEMA] Modo DB ativo: $DbServer/$DbName (fallback: schema.sql)" -ForegroundColor Cyan
}

if ($schema.Count -eq 0 -and -not $script:UseDB) {
    Write-Warning "Schema vazio ou nao parseado e sem conexao DB. Abortando validacao."
    return @("Schema vazio - validacao SQL nao executada")
}

Write-Host "  [SQL-SCHEMA] Schema arquivo parseado: $($schema.Count) tabelas" -ForegroundColor Cyan

# 2. Ler conteudo dos arquivos
$content = ""
if (Test-Path $FormFile) {
    $content += Get-Content $FormFile -Raw -Encoding UTF8
}
if ($BOFile -and (Test-Path $BOFile)) {
    $content += "`n" + (Get-Content $BOFile -Raw -Encoding UTF8)
}

if (-not $content) {
    Write-Warning "Nenhum conteudo para validar."
    return @()
}

# 3. Extrair statements SQL
$sqlStatements = Extract-SQLReferences -Content $content -Schema $schema

Write-Host "  [SQL-SCHEMA] Statements SQL encontrados: $($sqlStatements.Count)" -ForegroundColor Cyan

# 4. Validar cada statement
foreach ($stmt in $sqlStatements) {
    $sql = $stmt.SQL
    $lineNum = $stmt.StartLine

    # TABELAS (FROM/JOIN/INSERT/UPDATE) - verificar se existem no schema
    $allProblemas += Validate-TableNames -SQL $sql -LineNumber $lineNum -Schema $schema

    # SELECT
    if ($sql -match '(?i)\bSELECT\b.*\bFROM\b') {
        $allProblemas += Validate-SelectColumns -SQL $sql -LineNumber $lineNum -Schema $schema
    }

    # INSERT INTO (apenas tabelas reais, nao cursores)
    if ($sql -match '(?i)\bINSERT\s+INTO\b') {
        $allProblemas += Validate-InsertColumns -SQL $sql -LineNumber $lineNum -Schema $schema
    }

    # UPDATE
    if ($sql -match '(?i)\bUPDATE\b.*\bSET\b') {
        $allProblemas += Validate-UpdateColumns -SQL $sql -LineNumber $lineNum -Schema $schema
    }
}

# 5. Validar tipos de cursor
$allProblemas += Validate-CursorTypes -Content $content -Schema $schema

# 6. Reportar resultados
if ($allProblemas.Count -eq 0) {
    Write-Host "  [SQL-SCHEMA] PASSOU - Nenhuma coluna invalida detectada" -ForegroundColor Green
}
else {
    Write-Host "  [SQL-SCHEMA] $($allProblemas.Count) problema(s) encontrado(s):" -ForegroundColor Red
    foreach ($p in $allProblemas) {
        Write-Host "    $p" -ForegroundColor Yellow
    }
}

return $allProblemas
