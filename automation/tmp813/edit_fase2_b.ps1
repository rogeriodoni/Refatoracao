$ErrorActionPreference = 'Stop'
$f = 'C:\4c\projeto\app\classes\SigOpTotBO.prg'
$enc = [System.Text.Encoding]::GetEncoding(28591)
$script:t = [System.IO.File]::ReadAllText($f, $enc)

$LF = [string][char]10
$CR = [string][char]13
$NL = $CR + $LF          # a parte A ja gravou o arquivo em CRLF
$script:nAplic = 0

function Swap([string]$old, [string]$new, [string]$rotulo) {
    $n = ([regex]::Matches($script:t, [regex]::Escape($old))).Count
    if ($n -ne 1) { throw "ANCORA '$rotulo' casou $n vez(es) - esperado 1" }
    $script:t = $script:t.Replace($old, $new)
    $script:nAplic++
    Write-Host ("  [OK] " + $rotulo)
}
function SwapAll([string]$old, [string]$new, [string]$rotulo, [int]$esperado) {
    $n = ([regex]::Matches($script:t, [regex]::Escape($old))).Count
    if ($n -ne $esperado) { throw "ANCORA '$rotulo' casou $n vez(es) - esperado $esperado" }
    $script:t = $script:t.Replace($old, $new)
    $script:nAplic++
    Write-Host ("  [OK] " + $rotulo + " (x" + $n + ")")
}

$SEP = '    *--------------------------------------------------------------------------'

# =====================================================================
# B1 - metodos novos: CarregarDoCursor + leitores + Inserir + ExecutarExclusao
#      inseridos ANTES do bloco de CarregarOperacao (reaproveita o
#      separador que ja existe acima daquele comentario)
# =====================================================================
$ancCarregarOp = '    * CarregarOperacao - Replica o fallback do Init legado:'

$novosMetodos = @(
'    * CarregarDoCursor - FONTE UNICA de leitura das flags do tipo de',
'    * operacao. No legado essas colunas sao lidas soltas, direto do cursor,',
'    * em 18 pontos do Init/calctotais (crSigCdOpe.ChkQtds 6x, .Cmoes 7x,',
'    * .Opers/.PesoVts/.PrecoVts/.HabServs/.TotCompos 1x cada,',
'    * crSigOpCdc.DocQtd2s 2x, CrSigOpCdd.MtCubs 1x); aqui elas entram em',
'    * property uma vez e todos os metodos passam a decidir pela property.',
'    *',
'    * Os TRES cursores de parametro tem conjuntos DISJUNTOS de colunas',
'    * (SigCdOpe tem as flags, SigOpCdc tem DocQtd2s, SigOpCdd tem MtCubs),',
'    * por isso CADA coluna so e lida quando existe NESTE alias: sem esse',
'    * cuidado a 2a chamada apagaria o que a 1a carregou. Chamado com o',
'    * cursor da operacao, cascateia para os dois complementares, de modo',
'    * que uma chamada carrega tudo.',
'    *',
'    * A existencia da coluna e testada com TYPE(alias + ".coluna"), nunca',
'    * com PEMSTATUS (que exige OBJETO no 1o argumento e estoura com alias',
'    * de cursor), e o valor e lido com EVALUATE - leitura por nome montado',
'    * e justamente o uso correto de EVALUATE. O acesso "(variavel).campo"',
'    * NAO existe em VFP9, por isso o SELECT (alias) vem antes.',
$SEP,
'    PROCEDURE CarregarDoCursor(par_cAliasCursor)',
'        LOCAL loc_cAlias, loc_lLeu, loc_lSucesso',
'        loc_lSucesso = .F.',
'',
'        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C", ALLTRIM(par_cAliasCursor), "")',
'        IF EMPTY(loc_cAlias)',
'            loc_cAlias = THIS.this_cCursorOperacao',
'        ENDIF',
'',
'        IF !USED(loc_cAlias)',
'            THIS.this_cMensagemErro = "Cursor [" + loc_cAlias + "] n" + CHR(227) + ;',
'                "o est" + CHR(225) + " aberto"',
'            RETURN .F.',
'        ENDIF',
'',
'        *-- Sem registro posicionado as flags viriam todas zero, o que',
'        *-- desligaria secao inteira da tela sem erro nenhum - prefere-se',
'        *-- falhar alto.',
'        IF EOF(loc_cAlias)',
'            THIS.this_cMensagemErro = "Cursor [" + loc_cAlias + ;',
'                "] sem registro posicionado"',
'            RETURN .F.',
'        ENDIF',
'',
'        TRY',
'            SELECT (loc_cAlias)',
'            loc_lLeu = .F.',
'',
'            *-- Flags de SigCdOpe',
'            IF TYPE(loc_cAlias + ".ChkQtds") != "U"',
'                THIS.this_nChkQtds = THIS.LerFlagNumerica(loc_cAlias, "ChkQtds", THIS.this_nChkQtds)',
'                loc_lLeu = .T.',
'            ENDIF',
'            IF TYPE(loc_cAlias + ".PesoVts") != "U"',
'                THIS.this_nPesoVts = THIS.LerFlagNumerica(loc_cAlias, "PesoVts", THIS.this_nPesoVts)',
'                loc_lLeu = .T.',
'            ENDIF',
'            IF TYPE(loc_cAlias + ".PrecoVts") != "U"',
'                THIS.this_nPrecoVts = THIS.LerFlagNumerica(loc_cAlias, "PrecoVts", THIS.this_nPrecoVts)',
'                loc_lLeu = .T.',
'            ENDIF',
'            IF TYPE(loc_cAlias + ".TotCompos") != "U"',
'                THIS.this_nTotCompos = THIS.LerFlagNumerica(loc_cAlias, "TotCompos", THIS.this_nTotCompos)',
'                loc_lLeu = .T.',
'            ENDIF',
'            IF TYPE(loc_cAlias + ".Opers") != "U"',
'                THIS.this_nOpers = THIS.LerFlagNumerica(loc_cAlias, "Opers", THIS.this_nOpers)',
'                loc_lLeu = .T.',
'            ENDIF',
'            IF TYPE(loc_cAlias + ".Cmoes") != "U"',
'                THIS.this_cCmoes = THIS.LerTextoColuna(loc_cAlias, "Cmoes", THIS.this_cCmoes)',
'                loc_lLeu = .T.',
'            ENDIF',
'',
'            *-- HabServs existe em SigCdOpe E em SigOpCdc (schema conferido):',
'            *-- o legado decide pelo cursor da OPERACAO (CrSigCdOpe.HabServs),',
'            *-- por isso o cursor complementar nao pode sobrescrever a flag.',
'            IF TYPE(loc_cAlias + ".HabServs") != "U" ;',
'                    AND UPPER(ALLTRIM(loc_cAlias)) == UPPER(ALLTRIM(THIS.this_cCursorOperacao))',
'                THIS.this_nHabServs = THIS.LerFlagNumerica(loc_cAlias, "HabServs", THIS.this_nHabServs)',
'                loc_lLeu = .T.',
'            ENDIF',
'',
'            *-- Parametros complementares',
'            IF TYPE(loc_cAlias + ".DocQtd2s") != "U"',
'                THIS.this_cDocQtd2s = THIS.LerTextoColuna(loc_cAlias, "DocQtd2s", THIS.this_cDocQtd2s)',
'                loc_lLeu = .T.',
'            ENDIF',
'            IF TYPE(loc_cAlias + ".MtCubs") != "U"',
'                THIS.this_nMtCubs = THIS.LerFlagNumerica(loc_cAlias, "MtCubs", THIS.this_nMtCubs)',
'                loc_lLeu = .T.',
'            ENDIF',
'',
'            *-- Cascata: uma chamada com o cursor da operacao carrega tambem',
'            *-- os dois cursores de parametro, quando o form pai os deixou',
'            *-- abertos (no legado eles sao lidos soltos, sem guard).',
'            IF UPPER(ALLTRIM(loc_cAlias)) == UPPER(ALLTRIM(THIS.this_cCursorOperacao))',
'                IF USED(THIS.this_cCursorOpCdc) AND !EOF(THIS.this_cCursorOpCdc)',
'                    THIS.CarregarDoCursor(THIS.this_cCursorOpCdc)',
'                ENDIF',
'                IF USED(THIS.this_cCursorOpCdd) AND !EOF(THIS.this_cCursorOpCdd)',
'                    THIS.CarregarDoCursor(THIS.this_cCursorOpCdd)',
'                ENDIF',
'',
'                SELECT (loc_cAlias)',
'                THIS.this_lFlagsCarregadas = loc_lLeu',
'            ENDIF',
'',
'            IF loc_lLeu',
'                THIS.this_cMensagemErro = ""',
'            ENDIF',
'',
'            loc_lSucesso = loc_lLeu',
'',
'        CATCH TO loc_oErro',
'            THIS.this_cMensagemErro = "Erro ao ler os par" + CHR(226) + "metros da opera" + ;',
'                CHR(231) + CHR(227) + "o: " + loc_oErro.Message',
'            loc_lSucesso = .F.',
'        ENDTRY',
'',
'        RETURN loc_lSucesso',
'    ENDPROC',
'',
$SEP,
'    * LerFlagNumerica - Le uma coluna de flag do cursor informado,',
'    * devolvendo sempre NUMERICO. A mesma coluna chega com tipo diferente',
'    * conforme a origem: numeric(1,0) do SQL Server chega Numerico, coluna',
'    * bit chega ora Logica ora Numerica conforme o driver, e cursor local',
'    * pode trazer marcacao em char - comparar Logico com numero estoura',
'    * "Operator/operand type mismatch", por isso o tipo e testado antes.',
'    * Coluna ausente devolve o valor ATUAL da property (par_nAtual), para',
'    * a leitura de um cursor complementar nao apagar o que o cursor da',
'    * operacao ja tinha carregado.',
$SEP,
'    PROTECTED FUNCTION LerFlagNumerica(par_cAlias, par_cColuna, par_nAtual)',
'        LOCAL loc_cExpr, loc_uValor, loc_nRetorno',
'',
'        loc_nRetorno = IIF(VARTYPE(par_nAtual) = "N", par_nAtual, 0)',
'        loc_cExpr    = ALLTRIM(par_cAlias) + "." + ALLTRIM(par_cColuna)',
'',
'        IF TYPE(loc_cExpr) = "U"',
'            RETURN loc_nRetorno',
'        ENDIF',
'',
'        loc_uValor = EVALUATE(loc_cExpr)',
'',
'        DO CASE',
'        CASE ISNULL(loc_uValor)',
'            loc_nRetorno = 0',
'        CASE VARTYPE(loc_uValor) = "N"',
'            loc_nRetorno = loc_uValor',
'        CASE VARTYPE(loc_uValor) = "L"',
'            loc_nRetorno = IIF(loc_uValor, 1, 0)',
'        CASE VARTYPE(loc_uValor) = "C"',
'            loc_nRetorno = VAL(loc_uValor)',
'        ENDCASE',
'',
'        RETURN loc_nRetorno',
'    ENDFUNC',
'',
$SEP,
'    * LerTextoColuna - Par de LerFlagNumerica para as colunas char',
'    * (SigCdOpe.Cmoes, SigOpCdc.DocQtd2s). Coluna ausente devolve o valor',
'    * atual da property; NULL devolve string vazia (o legado trata campo',
'    * nulo como vazio nos Iif(IsEmpty(...)) que consomem esses valores).',
$SEP,
'    PROTECTED FUNCTION LerTextoColuna(par_cAlias, par_cColuna, par_cAtual)',
'        LOCAL loc_cExpr, loc_uValor, loc_cRetorno',
'',
'        loc_cRetorno = IIF(VARTYPE(par_cAtual) = "C", par_cAtual, "")',
'        loc_cExpr    = ALLTRIM(par_cAlias) + "." + ALLTRIM(par_cColuna)',
'',
'        IF TYPE(loc_cExpr) = "U"',
'            RETURN loc_cRetorno',
'        ENDIF',
'',
'        loc_uValor = EVALUATE(loc_cExpr)',
'',
'        DO CASE',
'        CASE ISNULL(loc_uValor)',
'            loc_cRetorno = ""',
'        CASE VARTYPE(loc_uValor) = "C"',
'            loc_cRetorno = loc_uValor',
'        OTHERWISE',
'            loc_cRetorno = TRANSFORM(loc_uValor)',
'        ENDCASE',
'',
'        RETURN loc_cRetorno',
'    ENDFUNC',
'',
$SEP,
'    * Inserir - Grava na AREA DE TROCA SigTempD as linhas agrupadas por',
'    * produto, reproduzindo o trecho do Init legado (linhas 1450-1470):',
'    *     Select CrSigTempD / Zap',
'    *     Scan wEesti -> Append Blank + Replace Cpros/CidQuerys/Qtds/CidChaves',
'    *     ThisForm.Podatamgr.UpDate(" + "CrSigTempD" + ") + PoDataMgr.commit()',
'    * O UpDate do Fortyus e o TABLEUPDATE do cursor remoto bufferizado, ou',
'    * seja um INSERT em SigTempD - por isso esta gravacao remota existe de',
'    * verdade e vem para ca em vez de ficar herdada de BusinessBase.',
'    *',
'    * COLUNAS: as que o legado preenche (cidquerys/cpros/qtds) MAIS as duas',
'    * NOT NULL sem DEFAULT de SIGTEMPD conferidas no docs/schema.sql -',
'    * cidchaves char(64), a PK, que recebe fUniqueIds() (nunca string',
'    * vazia, senao a 2a linha colide no indice unico) e dpros char(65),',
'    * que fica em branco porque no legado vinha do registro em branco do',
'    * Append Blank. Omitir qualquer uma delas faria o SQL Server recusar o',
'    * INSERT inteiro (regra #22 do CLAUDE.md).',
'    *',
'    * O lote inteiro vai num UNICO SQLEXEC com controle de transacao em',
'    * T-SQL (SAVE TRANSACTION quando @@TRANCOUNT > 0) - BEGIN/COMMIT em',
'    * SQLEXECs separados NAO protegem, porque a conexao do VFP ja abre com',
'    * Transactions = 2 e @@TRANCOUNT = 1, e seria so aninhamento.',
$SEP,
'    PROCEDURE Inserir()',
'        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_nLinhas, ;',
'              loc_cCidQuery3, loc_cAlias',
'        loc_lSucesso = .F.',
'',
'        THIS.this_cMensagemErro = ""',
'',
'        loc_cAlias = THIS.this_cCursorAgrupado',
'',
'        IF !USED(loc_cAlias)',
'            THIS.this_cMensagemErro = "Cursor de agrupamento [" + loc_cAlias + ;',
'                "] n" + CHR(227) + "o est" + CHR(225) + " aberto"',
'            RETURN .F.',
'        ENDIF',
'',
'        loc_cCidQuery3 = ALLTRIM(THIS.this_cCidQuery3)',
'        IF EMPTY(loc_cCidQuery3)',
'            THIS.this_cMensagemErro = "Chave de correla" + CHR(231) + CHR(227) + ;',
'                "o da opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o foi gerada"',
'            RETURN .F.',
'        ENDIF',
'',
'        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0',
'            THIS.this_cMensagemErro = "Favor reinicializar o processo."',
'            RETURN .F.',
'        ENDIF',
'',
'        TRY',
'            loc_nLinhas = 0',
'',
'            loc_cSQL = "SET NOCOUNT ON;" + CHR(13) + ;',
'                "DECLARE @nivel4c int = @@TRANCOUNT;" + CHR(13) + ;',
'                "IF @nivel4c = 0 BEGIN TRANSACTION ELSE SAVE TRANSACTION Compo4c;" + CHR(13) + ;',
'                "BEGIN TRY" + CHR(13)',
'',
'            *-- Campos lidos sem qualificar o alias: o SELECT abaixo torna',
'            *-- esta a area corrente, e VFP9 nao aceita "(variavel).campo".',
'            SELECT (loc_cAlias)',
'            SCAN',
'                loc_nLinhas = loc_nLinhas + 1',
'                loc_cSQL = loc_cSQL + ;',
'                    "INSERT INTO SigTempD (cidchaves, cidquerys, cpros, dpros, qtds) VALUES (" + ;',
'                    EscaparSQL(fUniqueIds()) + ", " + ;',
'                    EscaparSQL(loc_cCidQuery3) + ", " + ;',
'                    EscaparSQL(Cpros) + ", " + ;',
'                    EscaparSQL("") + ", " + ;',
'                    FormatarNumeroSQL(Qtds, 2) + ");" + CHR(13)',
'            ENDSCAN',
'',
'            loc_cSQL = loc_cSQL + ;',
'                "IF @nivel4c = 0 COMMIT TRANSACTION;" + CHR(13) + ;',
'                "END TRY" + CHR(13) + ;',
'                "BEGIN CATCH" + CHR(13) + ;',
'                "    IF @nivel4c = 0 BEGIN IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION; END" + CHR(13) + ;',
'                "    ELSE BEGIN IF XACT_STATE() = 1 ROLLBACK TRANSACTION Compo4c; END;" + CHR(13) + ;',
'                "    THROW;" + CHR(13) + ;',
'                "END CATCH"',
'',
'            IF loc_nLinhas = 0',
'                *-- Nenhum produto a explodir: nada a gravar, e isso nao e falha',
'                loc_lSucesso = .T.',
'            ELSE',
'                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)',
'',
'                IF loc_nResultado < 0',
'                    THIS.this_cMensagemErro = "Favor reinicializar o processo." + ;',
'                        CHR(13) + CapturarErroSQL()',
'                    loc_lSucesso = .F.',
'                ELSE',
'                    loc_lSucesso = .T.',
'                ENDIF',
'            ENDIF',
'',
'            SELECT (loc_cAlias)',
'            GO TOP',
'',
'        CATCH TO loc_oErro',
'            THIS.this_cMensagemErro = "Erro ao gravar a " + CHR(225) + "rea de troca " + ;',
'                "SigTempD: " + loc_oErro.Message',
'            loc_lSucesso = .F.',
'        ENDTRY',
'',
'        RETURN loc_lSucesso',
'    ENDPROC',
'',
$SEP,
'    * ExecutarExclusao - Apaga as linhas transitorias desta instancia na',
'    * area de troca, reproduzindo o Init legado (linha 1484):',
'    *     lcDelete = [Delete From SigTempD Where CidQuerys = ?lcCidQuery3]',
'    * Roda nos DOIS caminhos de ProcessarComponentes (sucesso e falha da',
'    * consulta de componentes), para a tabela nunca ficar com sobra desta',
'    * sessao - no legado a limpeza tambem acontece antes do uso do',
'    * resultado.',
'    *',
'    * Continua PROTECTED, como em BusinessBase: de fora, a exclusao de um',
'    * registro de entidade entra sempre por Excluir(). Aqui ela e um passo',
'    * interno do processamento, chamado so por ProcessarComponentes.',
$SEP,
'    PROTECTED PROCEDURE ExecutarExclusao()',
'        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cCidQuery3',
'        loc_lSucesso = .F.',
'',
'        loc_cCidQuery3 = ALLTRIM(THIS.this_cCidQuery3)',
'        IF EMPTY(loc_cCidQuery3)',
'            THIS.this_cMensagemErro = "Chave de correla" + CHR(231) + CHR(227) + ;',
'                "o da opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o foi gerada"',
'            RETURN .F.',
'        ENDIF',
'',
'        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0',
'            THIS.this_cMensagemErro = "Favor reinicializar o processo."',
'            RETURN .F.',
'        ENDIF',
'',
'        loc_cSQL = "DELETE FROM SigTempD WHERE cidquerys = " + EscaparSQL(loc_cCidQuery3)',
'',
'        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)',
'',
'        IF loc_nResultado < 0',
'            THIS.this_cMensagemErro = "Favor reinicializar o processo." + ;',
'                CHR(13) + CapturarErroSQL()',
'            loc_lSucesso = .F.',
'        ELSE',
'            loc_lSucesso = .T.',
'        ENDIF',
'',
'        RETURN loc_lSucesso',
'    ENDPROC',
'',
$SEP,
$ancCarregarOp
) -join $NL
Swap $ancCarregarOp $novosMetodos 'B1 metodos novos'

# =====================================================================
# B2 - ProcessarComponentes passa a decidir pela property e a delegar
#      a gravacao/limpeza remota para Inserir()/ExecutarExclusao()
# =====================================================================
$oldGateCompo = @(
'        IF !USED("crSigCdOpe") OR crSigCdOpe.TotCompos != 1',
'            RETURN .T.',
'        ENDIF'
) -join $NL
$newGateCompo = @(
'        *-- A flag vem da property (fonte unica). O latch garante a carga',
'        *-- mesmo quando este metodo e acionado por um caminho que nao',
'        *-- passou pelo ProcessarTotais - TotCompos lido como zero',
'        *-- desligaria a grade de componentes sem erro nenhum.',
'        IF !THIS.this_lFlagsCarregadas',
'            IF !THIS.CarregarDoCursor(THIS.this_cCursorOperacao)',
'                RETURN .F.',
'            ENDIF',
'        ENDIF',
'',
'        IF THIS.this_nTotCompos != 1',
'            RETURN .T.',
'        ENDIF'
) -join $NL
Swap $oldGateCompo $newGateCompo 'B2a gate TotCompos'

$oldMontaSQL = @(
'            IF USED("cursor_4c_CompoAgrupado")',
'                USE IN cursor_4c_CompoAgrupado',
'            ENDIF',
'',
'            SELECT Cpros, SUM(Qtds) AS Qtds ;',
'                FROM crTpmMvItn ;',
'                WHERE !EMPTY(Cpros) ;',
'                GROUP BY Cpros ;',
'                INTO CURSOR cursor_4c_CompoAgrupado READWRITE',
'',
'            loc_nLinhas = RECCOUNT("cursor_4c_CompoAgrupado")',
'',
'            IF loc_nLinhas > 0',
'                loc_cSQL = "SET NOCOUNT ON;" + CHR(13) + ;',
'                    "DECLARE @nivel4c int = @@TRANCOUNT;" + CHR(13) + ;',
'                    "IF @nivel4c = 0 BEGIN TRANSACTION ELSE SAVE TRANSACTION Compo4c;" + CHR(13) + ;',
'                    "BEGIN TRY" + CHR(13)',
'',
'                SELECT cursor_4c_CompoAgrupado',
'                SCAN',
'                    loc_cSQL = loc_cSQL + ;',
'                        "INSERT INTO SigTempD (cidchaves, cidquerys, cpros, dpros, qtds) VALUES (" + ;',
'                        EscaparSQL(fUniqueIds()) + ", " + ;',
'                        EscaparSQL(loc_cCidQuery3) + ", " + ;',
'                        EscaparSQL(cursor_4c_CompoAgrupado.Cpros) + ", " + ;',
'                        EscaparSQL("") + ", " + ;',
'                        FormatarNumeroSQL(cursor_4c_CompoAgrupado.Qtds, 2) + ");" + CHR(13)',
'                ENDSCAN',
'',
'                loc_cSQL = loc_cSQL + ;',
'                    "IF @nivel4c = 0 COMMIT TRANSACTION;" + CHR(13) + ;',
'                    "END TRY" + CHR(13) + ;',
'                    "BEGIN CATCH" + CHR(13) + ;',
'                    "    IF @nivel4c = 0 BEGIN IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION; END" + CHR(13) + ;',
'                    "    ELSE BEGIN IF XACT_STATE() = 1 ROLLBACK TRANSACTION Compo4c; END;" + CHR(13) + ;',
'                    "    THROW;" + CHR(13) + ;',
'                    "END CATCH"',
'',
'                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)',
'',
'                IF loc_nResultado < 0',
'                    THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + CapturarErroSQL()',
'                    loc_lProsseguir = .F.',
'                ENDIF'
) -join $NL
$newMontaSQL = @(
'            IF USED(THIS.this_cCursorAgrupado)',
'                USE IN (THIS.this_cCursorAgrupado)',
'            ENDIF',
'',
'            *-- Equivale a "Select Cpros,Sum(Qtds) as Qtds From crTpmMvItn',
'            *-- Group by Cpros Into cursor wEesti" do Init legado (linha',
'            *-- 1452). O !EMPTY(Cpros) reproduz o "If IsEmpty(Cpros) Loop"',
'            *-- que o Scan logo abaixo faz no legado.',
'            SELECT Cpros, SUM(Qtds) AS Qtds ;',
'                FROM crTpmMvItn ;',
'                WHERE !EMPTY(Cpros) ;',
'                GROUP BY Cpros ;',
'                INTO CURSOR (THIS.this_cCursorAgrupado) READWRITE',
'',
'            *-- COUNT (e nao RECCOUNT) porque RECCOUNT conta tambem',
'            *-- registro marcado para exclusao',
'            SELECT (THIS.this_cCursorAgrupado)',
'            COUNT TO loc_nLinhas',
'            GO TOP',
'',
'            IF loc_nLinhas > 0',
'                *-- Gravacao remota na area de troca (ver Inserir())',
'                IF !THIS.Inserir()',
'                    loc_lProsseguir = .F.',
'                ENDIF'
) -join $NL
Swap $oldMontaSQL $newMontaSQL 'B2b delega para Inserir()'

$oldDelErro = '                        SQLEXEC(gnConnHandle, "DELETE FROM SigTempD WHERE CidQuerys = " + EscaparSQL(loc_cCidQuery3))'
$newDelErro = '                        THIS.ExecutarExclusao()'
Swap $oldDelErro $newDelErro 'B2c delete no caminho de falha'

$oldDelOk = '                    SQLEXEC(gnConnHandle, "DELETE FROM SigTempD WHERE CidQuerys = " + EscaparSQL(loc_cCidQuery3))'
$newDelOk = '                    THIS.ExecutarExclusao()'
Swap $oldDelOk $newDelOk 'B2d delete no caminho de sucesso'

$oldFechaAgr = @(
'            IF USED("cursor_4c_CompoAgrupado")',
'                USE IN cursor_4c_CompoAgrupado',
'            ENDIF',
'',
'            loc_lSucesso = loc_lProsseguir'
) -join $NL
$newFechaAgr = @(
'            IF USED(THIS.this_cCursorAgrupado)',
'                USE IN (THIS.this_cCursorAgrupado)',
'            ENDIF',
'',
'            loc_lSucesso = loc_lProsseguir'
) -join $NL
Swap $oldFechaAgr $newFechaAgr 'B2e fecha cursor de agrupamento'

# =====================================================================
# B3 - PrepararRotuloTotalPeso usa a property
# =====================================================================
$oldRotulo = @(
'        IF USED("crSigOpCdc") AND !EMPTY(crSigOpCdc.DocQtd2s)',
'            THIS.this_cRotuloTotalPeso = "Total " + ALLTRIM(crSigOpCdc.DocQtd2s) + " :"'
) -join $NL
$newRotulo = @(
'        IF !EMPTY(THIS.this_cDocQtd2s)',
'            THIS.this_cRotuloTotalPeso = "Total " + ALLTRIM(THIS.this_cDocQtd2s) + " :"'
) -join $NL
Swap $oldRotulo $newRotulo 'B3 rotulo via property'

# =====================================================================
# B4 - MontarGradeServicos usa a property
# =====================================================================
$oldGateServ = @(
'        IF !USED("crSigCdOpe") OR crSigCdOpe.HabServs != 1',
'            RETURN .T.',
'        ENDIF'
) -join $NL
$newGateServ = @(
'        IF !THIS.this_lFlagsCarregadas',
'            IF !THIS.CarregarDoCursor(THIS.this_cCursorOperacao)',
'                RETURN .F.',
'            ENDIF',
'        ENDIF',
'',
'        IF THIS.this_nHabServs != 1',
'            RETURN .T.',
'        ENDIF'
) -join $NL
Swap $oldGateServ $newGateServ 'B4a gate HabServs'

$oldMoeServ = '                loc_cMoePreco = IIF(EMPTY(crSigCdOpe.Cmoes), crTpmMvItn3.Moedas, crSigCdOpe.Cmoes)'
$newMoeServ = '                loc_cMoePreco = IIF(EMPTY(THIS.this_cCmoes), crTpmMvItn3.Moedas, THIS.this_cCmoes)'
Swap $oldMoeServ $newMoeServ 'B4b moeda de servico via property'

# =====================================================================
# B5 - CalcularTotais passa a decidir pelas properties
# =====================================================================
$oldGuardCalc = @(
'        IF !USED("crSigCdOpe") OR !USED("crTpmMvItn") OR !USED("TprMvCab")',
'            THIS.this_cMensagemErro = "Cursores da opera" + CHR(231) + CHR(227) + ;',
'                "o n" + CHR(227) + "o est" + CHR(227) + "o abertos"',
'            RETURN .F.',
'        ENDIF'
) -join $NL
$newGuardCalc = @(
'        IF !USED("crSigCdOpe") OR !USED("crTpmMvItn") OR !USED("TprMvCab")',
'            THIS.this_cMensagemErro = "Cursores da opera" + CHR(231) + CHR(227) + ;',
'                "o n" + CHR(227) + "o est" + CHR(227) + "o abertos"',
'            RETURN .F.',
'        ENDIF',
'',
'        *-- As flags da operacao sao constantes durante todo o SCAN (o',
'        *-- cursor da operacao tem uma linha so), por isso vem da property.',
'        *-- O latch cobre a chamada vinda de ValidarCompensacao, que',
'        *-- recalcula os totais sem passar pelo ProcessarTotais.',
'        IF !THIS.this_lFlagsCarregadas',
'            IF !THIS.CarregarDoCursor(THIS.this_cCursorOperacao)',
'                RETURN .F.',
'            ENDIF',
'        ENDIF'
) -join $NL
Swap $oldGuardCalc $newGuardCalc 'B5a carga das flags em CalcularTotais'

$oldMulti = @(
'                loc_nMulti = IIF(crSigCdOpe.Opers = 3, ;',
'                    IIF(crTpmMvItn.Opers = "E", -1, 1), ;',
'                    IIF(crTpmMvItn.Opers = "E", 1, -1))'
) -join $NL
$newMulti = @(
'                *-- crSigCdOpe.Opers (numeric) vem da property; crTpmMvItn.Opers',
'                *-- e a marcacao "E"/"S" de CADA item e continua lida do cursor',
'                loc_nMulti = IIF(THIS.this_nOpers = 3, ;',
'                    IIF(crTpmMvItn.Opers = "E", -1, 1), ;',
'                    IIF(crTpmMvItn.Opers = "E", 1, -1))'
) -join $NL
Swap $oldMulti $newMulti 'B5b multiplicador via property'

Swap '                IF crSigCdOpe.PesoVts = 1' '                IF THIS.this_nPesoVts = 1' 'B5c PesoVts'
Swap '                    loc_cMoePeso = IIF(EMPTY(crSigCdOpe.Cmoes), crTpmMvItn.MoeFats, crSigCdOpe.Cmoes)' '                    loc_cMoePeso = IIF(EMPTY(THIS.this_cCmoes), crTpmMvItn.MoeFats, THIS.this_cCmoes)' 'B5d moeda do peso'
Swap '                IF crSigCdOpe.PrecoVts = 1' '                IF THIS.this_nPrecoVts = 1' 'B5e PrecoVts'
Swap '                    loc_cMoePreco = IIF(!EMPTY(crTpmMvItn.Moedas), crTpmMvItn.Moedas, crSigCdOpe.Cmoes)' '                    loc_cMoePreco = IIF(!EMPTY(crTpmMvItn.Moedas), crTpmMvItn.Moedas, THIS.this_cCmoes)' 'B5f moeda do preco'

SwapAll 'IF INLIST(crSigCdOpe.ChkQtds, 6, 7)' 'IF INLIST(THIS.this_nChkQtds, 6, 7)' 'B5g INLIST ChkQtds' 3
SwapAll 'loc_nChkQtds = crSigCdOpe.ChkQtds' 'loc_nChkQtds = THIS.this_nChkQtds' 'B5h ChkQtds local' 3

$oldMtCub = '            IF USED("crSigOpCdd") AND crSigOpCdd.MtCubs <> 0'
$newMtCub = '            IF THIS.this_nMtCubs <> 0'
Swap $oldMtCub $newMtCub 'B5i MtCubs via property'

# ---- gravacao mantendo CRLF
$saida = $script:t.Replace($CR + $LF, $LF).Replace($LF, $CR + $LF)
[System.IO.File]::WriteAllText($f, $saida, $enc)
Write-Host ''
Write-Host ('APLICADOS: ' + $script:nAplic + ' blocos')
