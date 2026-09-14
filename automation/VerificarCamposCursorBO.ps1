#==============================================================================
# VerificarCamposCursorBO.ps1
#
# PROPOSITO: encontra leituras de CAMPO DE CURSOR nos *BO.prg que nao
#            correspondem a nenhuma coluna real - tipicamente em
#            CarregarDoCursor(), onde o codigo faz
#                THIS.this_nMargens = TratarNulo(margens, "N")
#            mas a coluna no banco chama `margems`. Como CarregarPorCodigo
#            costuma usar `SELECT *`, o cursor traz a grafia REAL e a leitura
#            estoura em RUNTIME com "Variable MARGENS is not found".
#            O .prg COMPILA LIMPO: o defeito so aparece quando o usuario
#            aciona Alterar/Visualizar.
#
# POR QUE ESTE SCRIPT EXISTE: ValidadorSQLSchema.ps1 cobre INSERT/UPDATE/SELECT
#            porque sao SQL. A leitura do cursor NAO eh SQL - eh referencia a
#            campo VFP - e nenhuma validacao a cobria (Erro159, gpdBO/SigCdGrp,
#            onde os 6 nomes errados estavam no INSERT, no UPDATE e aqui).
#
# USO:
#   .\VerificarCamposCursorBO.ps1                 # relatorio na tela
#   .\VerificarCamposCursorBO.ps1 -Csv saida.csv  # tambem grava CSV
#
# CRITERIO: so acusa identificador que nao eh coluna de NENHUMA tabela do banco,
#            nem aparece em algum SELECT ou CREATE CURSOR do arquivo. Restringir
#            a tabela do BO parecia mais preciso, mas gerava dezenas de falsos
#            positivos: muitos BOs de relatorio chamam CarregarDoCursor com um
#            cursor de outra tabela ou de filtro (sigprnfeBO lendo LOTES,
#            SigPrPpcBO lendo DATAI). O criterio largo nao perde nada no caso que
#            motivou o script: as 6 grafias erradas do gpdBO nao existem em
#            nenhuma das 677 tabelas. Em compensacao, um erro de grafia que
#            coincida com coluna de OUTRA tabela passa - esse fica por conta do
#            ValidadorSQLSchema, que confere INSERT/UPDATE contra a tabela certa.
#
# O resultado eh LISTA DE CANDIDATOS, nao veredito: sobram cursores montados no
#            FORM (`SELECT ... AS x INTO CURSOR`), que o BO nao declara. Conferir
#            no arquivo antes de mexer. Sinal forte de defeito real: a coluna
#            sugerida em "-> provavel" (anagrama ou troca de uma letra).
#==============================================================================

param(
    [string]$Csv      = "",
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
$cmd.CommandText = "SELECT TABLE_NAME, COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS"
$rd = $cmd.ExecuteReader()
$colunas   = @{}   # tabela (upper) -> hashset de colunas (upper)
$qualquer  = @{}   # UNIAO das colunas de TODAS as tabelas
while ($rd.Read()) {
    $tab = $rd[0].ToString().ToUpper()
    $col = $rd[1].ToString().ToUpper()
    if (-not $colunas.ContainsKey($tab)) { $colunas[$tab] = @{} }
    $colunas[$tab][$col] = $true
    $qualquer[$col] = $true
}
$rd.Close()
$cn.Close()
$nDB = $qualquer.Count

# UNIAO com o schema.sql canonico. Obrigatorio: varias tabelas estao no schema e
# NAO nesta instalacao (SIGCDCCP, SIGCDBLQ, SIGLCLO...). Usar so o banco vivo faz
# as colunas delas parecerem inexistentes e produz falso positivo em massa - eram
# 11 dos 44 candidatos so no sigprccpBO. Pela regra #14 do CLAUDE.md, tabela que
# esta no schema e o legado usa com o mesmo nome significa migrado FIEL: a
# divergencia eh de BANCO/ambiente e nao se conserta no codigo.
# UTF-16: ler com Get-Content -Raw (grep/findstr devolvem ZERO silenciosamente).
$schemaFile = "C:\4c\docs\schema.sql"
if (Test-Path $schemaFile) {
    $sch = Get-Content $schemaFile -Raw
    foreach ($mt in [regex]::Matches($sch, '(?is)CREATE TABLE \[dbo\]\.\[(\w+)\]\s*\((.*?)\r?\n\)')) {
        foreach ($ml in [regex]::Matches($mt.Groups[2].Value, '(?im)^\s*\[(\w+)\]\s+\[')) {
            $qualquer[$ml.Groups[1].Value.ToUpper()] = $true
        }
    }
    foreach ($ma in [regex]::Matches($sch, '(?i)ALTER TABLE \[dbo\]\.\[\w+\]\s+ADD\s+\[(\w+)\]')) {
        $qualquer[$ma.Groups[1].Value.ToUpper()] = $true
    }
}
Write-Host ("Metadados: {0} tabelas no banco, {1} nomes de coluna (banco {2} + schema.sql)" -f `
    $colunas.Count, $qualquer.Count, $nDB) -ForegroundColor Cyan

# Funcoes/palavras que aparecem na posicao de campo mas nao sao campo
$ignorar = @{}
foreach ($p in @('TRATARNULO','NVL','ALLTRIM','UPPER','LOWER','VAL','STR','INT','ROUND','IIF','EMPTY',
                 'DATE','DATETIME','TIME','SPACE','PADR','PADL','LEFT','RIGHT','SUBSTR','TRANSFORM',
                 'C','N','D','T','L','M','THIS','VARTYPE','ISNULL','TTOD','CTOD','RECNO','RECCOUNT',
                 'USED','SELECT','ENDIF','RETURN','LOCAL','TRUE','FALSE')) { $ignorar[$p] = $true }

$achados = @()

foreach ($arq in (Get-ChildItem -Path $PastaBOs -Filter '*BO.prg' -File)) {
    $txt = [System.IO.File]::ReadAllText($arq.FullName)

    # remove comentarios de linha inteira
    $linhas = $txt -split "`r?`n"
    $semCom = ($linhas | Where-Object { $_ -notmatch '^\s*(\*|&&)' }) -join "`r`n"

    # tabela principal do BO
    $mTab = [regex]::Match($semCom, '(?i)this_cTabela\s*=\s*"(\w+)"')
    if (-not $mTab.Success) { continue }
    $tabela = $mTab.Groups[1].Value.ToUpper()
    if (-not $colunas.ContainsKey($tabela)) { continue }   # tabela fora deste banco

    # PERMITIDO = coluna de QUALQUER tabela do banco, nao so da tabela do BO.
    # Muitos BOs (relatorios e OPERACIONAIS) chamam CarregarDoCursor com um cursor
    # montado de outra tabela ou de um CREATE CURSOR de filtro; restringir a
    # tabela do BO gerava dezenas de falsos positivos (sigprnfeBO lendo LOTES,
    # SigPrPpcBO lendo DATAI...). O criterio util eh "nao existe em lugar nenhum":
    # as 6 grafias erradas do Erro159 nao aparecem em NENHUMA das 677 tabelas.
    $permitido = @{}
    foreach ($k in $qualquer.Keys) { $permitido[$k] = $true }

    # Campos declarados em CREATE CURSOR. Procurar TAMBEM no Form correspondente:
    # em BO de relatorio/OPERACIONAL quem monta o cursor de filtro eh o Form, e
    # olhar so o BO acusava campo legitimo (GERNUMES/GERDOPES do FormSigPrGst,
    # PENDENTES do FormSIGPDPNS, SELIMP do Formsigprnfe...).
    $fontes = @($semCom)
    $radical = ($arq.BaseName -replace 'BO$', '')
    foreach ($cand in @("Form$radical.prg", "form$radical.prg")) {
        $achado = Get-ChildItem -Path (Split-Path $PastaBOs -Parent) -Recurse -Filter $cand -File -ErrorAction SilentlyContinue |
                  Where-Object { $_.Name -notmatch '\.bak' } | Select-Object -First 1
        if ($achado) { $fontes += [System.IO.File]::ReadAllText($achado.FullName); break }
    }
    # Dump do form LEGADO: os cursores de trabalho da migracao herdam os nomes de
    # campo do legado, que nao sao colunas de tabela nenhuma (TmpCabec do
    # SigPrGl2 tem Contav, DConta, Peso, Entregas...). Sem esta fonte o script
    # acusa um BO que esta FIEL ao legado.
    $dump = Get-ChildItem -Path "C:\4c\tasks" -Recurse -Filter "*_form_codigo_fonte.txt" -ErrorAction SilentlyContinue |
            Where-Object { $_.Name -match "(?i)^$([regex]::Escape($radical))_form_codigo_fonte\.txt$" } |
            Sort-Object FullName | Select-Object -Last 1
    if ($dump) {
        $leg = [System.IO.File]::ReadAllText($dump.FullName)
        $fontes += $leg
        # ControlSource = "cursor.campo" - nomes de campo usados pela tela
        foreach ($mCs in [regex]::Matches($leg, '(?i)ControlSource\s*=\s*[\["'']\s*\w+\.(\w+)')) {
            $permitido[$mCs.Groups[1].Value.ToUpper()] = $true
        }
    }

    foreach ($fonte in $fontes) {
        foreach ($mCur in [regex]::Matches($fonte, '(?is)CREATE\s+CURSOR\s+\w+\s*\((.{0,3000}?)\)\s*(?:\r?\n|$)')) {
            foreach ($tk in [regex]::Matches($mCur.Groups[1].Value, '[A-Za-z_]\w*')) {
                $permitido[$tk.Value.ToUpper()] = $true
            }
        }
        foreach ($mAs in [regex]::Matches($fonte, '(?i)\bAS\s+(\w+)')) {
            $permitido[$mAs.Groups[1].Value.ToUpper()] = $true
        }
    }
    # CUIDADO: o `SELECT (par_cAlias)` do VFP (troca de area de trabalho) NAO tem
    # FROM. Sem limite, o .*? varre para frente ate o proximo FROM e colhe a lista
    # INTEIRA do INSERT - foi assim que `margens` (grafia errada) entrou nos
    # permitidos e o gpdBO passou limpo. Limitar o alcance e descartar o trecho
    # quando ele atravessa outro statement.
    foreach ($mSel in [regex]::Matches($semCom, '(?is)\bSELECT\b(.{0,2000}?)\bFROM\b')) {
        $cols = $mSel.Groups[1].Value
        if ($cols -match '(?i)\b(INSERT|UPDATE|DELETE|PROCEDURE|FUNCTION|ENDPROC|ENDFUNC)\b') { continue }
        foreach ($tk in [regex]::Matches($cols, '[A-Za-z_]\w*')) {
            $permitido[$tk.Value.ToUpper()] = $true
        }
    }

    # corpo de CarregarDoCursor (ate o proximo ENDPROC/ENDFUNC)
    $mProc = [regex]::Match($semCom,
        '(?is)(?:PROTECTED\s+)?(?:PROCEDURE|FUNCTION)\s+CarregarDoCursor\b(.*?)\b(?:ENDPROC|ENDFUNC)\b')
    if (-not $mProc.Success) { continue }
    $corpo = $mProc.Groups[1].Value

    # posicao aproximada no arquivo original
    $linhaBase = ($semCom.Substring(0, $mProc.Index) -split "`n").Count

    # Leitura PROTEGIDA nao eh defeito: o BO de relatorio le um cursor de FILTRO
    # montado no Form, cuja forma varia, e cerca cada leitura com
    #   IF TYPE(par_cAliasCursor + ".campo") != "U"   /   IF TYPE("campo") = "C"
    # Com o guard, campo ausente simplesmente nao eh lido - nao existe o erro
    # "Variable X is not found". Foi o que explicou 22 dos 32 candidatos que
    # sobraram no Erro159 (SigPrPpcBO, sigredocBO, sigreeunBO). O defeito real
    # (gpdBO, CTABO) eh sempre leitura DESPROTEGIDA.
    $protegidos = @{}
    foreach ($m in [regex]::Matches($corpo, '(?i)\b(?:VAR)?TYPE\s*\(\s*(?:[^)]*?\.)?["'']?\.?(\w+)["'']?\s*\)')) {
        $protegidos[$m.Groups[1].Value.ToUpper()] = $true
    }

    # candidatos: TratarNulo(<campo>, / NVL(<campo>, / = <campo> / (<campo> = 1)
    $cands = @{}
    foreach ($m in [regex]::Matches($corpo, '(?i)\b(?:TratarNulo|NVL)\s*\(\s*([A-Za-z_]\w*)\s*[,\)]')) {
        $cands[$m.Groups[1].Value.ToUpper()] = $true
    }
    # "= campo" no fim da linha. Usar [ \t]* e NAO \s*: \s engole o \r\n e a
    # ancora de fim de linha nunca casa (o script inteiro dava zero achado).
    # o \r? antes de $ eh obrigatorio: em CRLF a ancora casa ANTES do \n, com o
    # \r ainda no caminho, e [ \t]*$ nunca fecha.
    foreach ($m in [regex]::Matches($corpo, '(?im)=[ \t]*([A-Za-z_]\w*)[ \t]*\r?$')) {
        $cands[$m.Groups[1].Value.ToUpper()] = $true
    }
    # "= (campo = 1)" - conversao de bit/numeric para logico
    foreach ($m in [regex]::Matches($corpo, '(?i)=[ \t]*\([ \t]*([A-Za-z_]\w*)[ \t]*=[ \t]*1[ \t]*\)')) {
        $cands[$m.Groups[1].Value.ToUpper()] = $true
    }

    foreach ($c in $cands.Keys) {
        if ($ignorar.ContainsKey($c))    { continue }
        if ($protegidos.ContainsKey($c)) { continue }
        if ($c -like 'THIS_*')          { continue }
        if ($c -like 'LOC_*')           { continue }
        if ($c -like 'PAR_*')           { continue }
        if ($permitido.ContainsKey($c)) { continue }

        # Sugerir a coluna real mais parecida. Os dois erros de grafia vistos no
        # Erro159 sao: metatese (sugestoas/sugestaos - mesmas letras reordenadas)
        # e troca de UMA letra (margens/margems). Cobrir os dois.
        $alvo = ($c.ToCharArray() | Sort-Object) -join ''
        $sug = @($colunas[$tabela].Keys | Where-Object {
                    if ($_ -eq $c) { return $false }
                    if ((($_.ToCharArray() | Sort-Object) -join '') -eq $alvo) { return $true }
                    if ($_.Length -ne $c.Length) { return $false }
                    $dif = 0
                    for ($i = 0; $i -lt $c.Length; $i++) {
                        if ($_[$i] -ne $c[$i]) { $dif++ }
                        if ($dif -gt 1) { return $false }
                    }
                    return ($dif -eq 1)
                })

        $achados += [PSCustomObject]@{
            BO         = $arq.Name
            Tabela     = $tabela
            Campo      = $c
            Sugestao   = ($sug -join '/')
            LinhaAprox = $linhaBase
        }
        $cor = if ($sug.Count -gt 0) { "Red" } else { "Yellow" }
        Write-Host ("[CAMPO INEXISTENTE] {0,-20} {1,-14} {2}{3}" -f `
            $arq.Name, $tabela, $c, $(if ($sug.Count -gt 0) { "  -> provavel: $($sug -join '/')" } else { "" })) `
            -ForegroundColor $cor
    }
}

Write-Host ""
Write-Host "Campos de cursor sem coluna correspondente: $($achados.Count)" `
    -ForegroundColor $(if ($achados.Count -gt 0) { "Red" } else { "Green" })

if ($Csv -ne "") {
    $achados | Export-Csv -Path $Csv -NoTypeInformation -Encoding UTF8
    Write-Host "CSV gravado em $Csv" -ForegroundColor Cyan
}
