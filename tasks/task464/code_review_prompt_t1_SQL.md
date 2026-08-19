# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'FPAGS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CMOES

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES SQL
- [GRID-SQL] Campos no ControlSource que nao existem no CREATE CURSOR/SELECT
- [SQL-COLUNA] Nomes de colunas que NAO existem na tabela (validado contra banco real)
  - A mensagem mostra colunas VALIDAS - usar nome EXATO
  - Se sugere "voce quis dizer 'X'?", usar X
- [SQL-TABELA] Tabela inventada que nao existe no original
- [SQL-ASPAS] Aspas duplicadas ou concatenacao sem EscaparSQL
  - EscaparSQL() JA retorna com aspas. FormatarDataSQL() idem.
- [SQL-FILTRO-INVENTADO] Condicao WHERE inventada pela LLM - REMOVER
- [TRANSACAO-AVULSA] COMMIT/ROLLBACK sem BEGIN TRANSACTION - REMOVER

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

### LINHAS SQL/CONTROLSOURCE DO CODIGO ORIGINAL (referencia):
  ControlSource = "crSigCdMoe.Toleras"
  ControlSource = "crSigCdMoe.Qtdeqs"
  ControlSource = "crSigCdMoe.moeqs"
  ControlSource = "crSigCdMoe.FPAGS"
  ControlSource = "crSigCdMoe.submoes"
  ControlSource = "crSigCdMoe.grumoes"
  ControlSource = "crSigCdMoe.cmoes"
  ControlSource = "crSigCdMoe.dmoes"
  ControlSource = "crSigCdMoe.cotas"
  ControlSource = "crSigCdMoe.valadics"
  ControlSource = "crSigCdMoe.disfpres"
  ControlSource = "crSigCdMoe.fmults"
  ControlSource = "crSigCdMoe.nordrels"
  ControlSource = "crSigCdMoe.tabrefs"
  ControlSource = "crSigCdMoe.Consultas"
lcQueryCot = [Select * From SigCdCot Where cmoes = ?lcMoe ]
Select CrSigCdMoe
Select CrSigCdMoe
Select CrSigCdMoe
	Select CrSigCdCot
Select CrSigCdMoe
	Select CrSigCdCot

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormMoe.prg) - TRECHOS RELEVANTES PARA PASS SQL (1677 linhas total):

*-- Linhas 361 a 379:
361:             .HighlightBackColor = RGB(255, 255, 255)
362:             .HighlightForeColor = RGB(15, 41, 104)
363:             .HighlightStyle     = 2
364:             .DeleteMark         = .F.
365:             .RecordMark         = .F.
366:             .RowHeight          = 16
367:             .ScrollBars         = 2
368:             .GridLines          = 3
369:             .ReadOnly           = .T.
370:             .Visible            = .T.
371:         ENDWITH
372: 
373:         *-- ColumnCount FORA do WITH para criar colunas imediatamente (Problema 36)
374:         loc_oPagina.grd_4c_Lista.ColumnCount = 3
375: 
376:         WITH loc_oPagina.grd_4c_Lista
377:             .Column1.Header1.Caption = "Moeda"
378:             .Column1.Width           = 120
379:             .Column1.Alignment       = 0

*-- Linhas 1166 a 1186:
1166:                 IF THIS.this_oBusinessObject.Buscar("")
1167:                     loc_oGrid.ColumnCount = 3
1168:                     loc_oGrid.RecordSource          = "cursor_4c_Dados"
1169:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cmoes"
1170:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.dmoes"
1171:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.nordrels"
1172: 
1173:                     *-- Reconfigurar headers apos RecordSource (RecordSource reseta captions)
1174:                     loc_oGrid.Column1.Header1.Caption = "Moeda"
1175:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1176:                     loc_oGrid.Column3.Header1.Caption = "Ordem de Impress" + CHR(227) + "o"
1177: 
1178:                     loc_oGrid.Column1.Width = 120
1179:                     loc_oGrid.Column2.Width = 330
1180:                     loc_oGrid.Column3.Width = 129
1181: 
1182:                     THIS.FormatarGridLista(loc_oGrid)
1183:                     loc_oGrid.Refresh()
1184:                     loc_lResultado = .T.
1185:                 ENDIF
1186:             CATCH TO loc_oErro

*-- Linhas 1309 a 1349:
1309:     *==========================================================================
1310:     * BtnSalvarClick - Salva o registro atual (Confirmar no legado)
1311:     * Validacoes da Salva.Click original:
1312:     *   INSERT: cmoes nao vazio, nao duplicado, nordrels entre 0-5
1313:     *   INSERT/ALTER: disfpres padrao 'S' se vazio (tratado no FormParaBO)
1314:     *==========================================================================
1315:     PROCEDURE BtnSalvarClick()
1316:         LOCAL loc_oPg2, loc_cCodigo, loc_nOrdem, loc_lSucesso
1317:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1318: 
1319:         *-- Validacoes ANTES do TRY (RETURN fora de TRY e correto)
1320:         IF THIS.this_cModoAtual = "INCLUIR"
1321:             loc_cCodigo = ALLTRIM(loc_oPg2.txt_4c_Moeda.Value)
1322:             IF EMPTY(loc_cCodigo)
1323:                 MsgAviso("Moeda inv" + CHR(225) + "lida !!!", ;
1324:                     "Aten" + CHR(231) + CHR(227) + "o")
1325:                 loc_oPg2.txt_4c_Moeda.SetFocus
1326:                 RETURN
1327:             ENDIF
1328: 
1329:             *-- Verificar duplicidade
1330:             loc_lSucesso = .F.
1331:             TRY
1332:                 LOCAL loc_nDup
1333:                 loc_nDup = SQLEXEC(gnConnHandle, ;
1334:                     "SELECT cmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cCodigo), ;
1335:                     "cursor_4c_DupCheck")
1336:                 IF loc_nDup > 0 AND USED("cursor_4c_DupCheck") AND RECCOUNT("cursor_4c_DupCheck") > 0
1337:                     IF USED("cursor_4c_DupCheck")
1338:                         USE IN cursor_4c_DupCheck
1339:                     ENDIF
1340:                     MsgAviso("Moeda j" + CHR(225) + " cadastrada !!!", ;
1341:                         "Aten" + CHR(231) + CHR(227) + "o")
1342:                     loc_oPg2.txt_4c_Moeda.SetFocus
1343:                     RETURN
1344:                 ENDIF
1345:                 IF USED("cursor_4c_DupCheck")
1346:                     USE IN cursor_4c_DupCheck
1347:                 ENDIF
1348:             CATCH TO loc_oErro
1349:                 MsgErro("Erro ao verificar duplicidade: " + loc_oErro.Message, "Erro")

*-- Linhas 1400 a 1419:
1400:         ENDIF
1401: 
1402:         TRY
1403:             loc_nResult = SQLEXEC(gnConnHandle, ;
1404:                 "SELECT cmoes, dmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cMoeEq), ;
1405:                 "cursor_4c_BuscaMoe")
1406: 
1407:             IF loc_nResult > 0 AND USED("cursor_4c_BuscaMoe") AND RECCOUNT("cursor_4c_BuscaMoe") > 0
1408:                 *-- Encontrou exato, manter valor
1409:                 IF USED("cursor_4c_BuscaMoe")
1410:                     USE IN cursor_4c_BuscaMoe
1411:                 ENDIF
1412:             ELSE
1413:                 *-- Nao encontrou exato, abrir busca
1414:                 IF USED("cursor_4c_BuscaMoe")
1415:                     USE IN cursor_4c_BuscaMoe
1416:                 ENDIF
1417: 
1418:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1419:                     "SigCdMoe", "cursor_4c_BuscaMoe", "cmoes", loc_cMoeEq, "Moedas")

*-- Linhas 1474 a 1493:
1474:                 USE IN cursor_4c_BuscaFpag
1475:             ENDIF
1476: 
1477:             loc_nResult = SQLEXEC(gnConnHandle, ;
1478:                 "SELECT Fpags, Descrs FROM SigOpFp WHERE Fpags = " + EscaparSQL(loc_cFpag), ;
1479:                 "cursor_4c_BuscaFpag")
1480: 
1481:             IF loc_nResult > 0 AND USED("cursor_4c_BuscaFpag") AND RECCOUNT("cursor_4c_BuscaFpag") > 0
1482:                 *-- Encontrou exato, manter valor
1483:                 IF USED("cursor_4c_BuscaFpag")
1484:                     USE IN cursor_4c_BuscaFpag
1485:                 ENDIF
1486:             ELSE
1487:                 *-- Nao encontrou, abrir busca
1488:                 IF USED("cursor_4c_BuscaFpag")
1489:                     USE IN cursor_4c_BuscaFpag
1490:                 ENDIF
1491:                 THIS.AbrirLookupFpag()
1492:             ENDIF
1493: 


### BO (C:\4c\projeto\app\classes\MoeBO.prg):
*==============================================================================
* MoeBO.prg - Business Object para Cadastro de Moedas
* Tabela: SigCdMoe
* Chave primaria: cmoes char(3)
*==============================================================================

DEFINE CLASS MoeBO AS BusinessBase

    *-- Chave primaria
    this_cCodigo      = ""    && char(3)       cmoes  - Codigo da moeda (PK)

    *-- Dados cadastrais
    this_cDescricao   = ""    && char(15)      dmoes  - Descricao da moeda
    this_lCotas       = .F.   && bit           cotas  - Permite cotacao
    this_dDataTrans   = {}    && datetime NULL  datatrans - Data transacao

    *-- Fator multiplicador / ordem relatorios
    this_cFmults      = ""    && char(1)       fmults     - Fator multiplicador (N=Nao / S=Sim)
    this_nNordrels    = 0     && numeric(1,0)  nordrels   - N da coluna nos relatorios (0-5)

    *-- Codificacao etiqueta produto
    this_cDisfpres    = ""    && char(1)       disfpres   - Codifica na etiqueta (N/S/A/P)
    this_nValadics    = 0     && numeric(3,0)  valadics   - Valor adicional

    *-- Moeda equivalente
    this_cMoeqs       = ""    && char(3)       moeqs      - Codigo da moeda equivalente (FK SigCdMoe.cmoes)
    this_nQtdeqs      = 0     && numeric(12,6) qtdeqs     - Quantidade moeda equivalente
    this_nToleras     = 0     && numeric(4,2)  toleras    - Tolerancia conversao

    *-- Classificacao
    this_cGrumoes     = ""    && char(10)      grumoes    - Grupo
    this_cSubmoes     = ""    && char(10)      submoes    - Sub-grupo

    *-- Configuracao gerencial
    this_lTabrefs     = .F.   && bit           tabrefs    - Imprime tabela referencia
    this_cFpags       = ""    && char(12)      fpags      - Cond. pagamento automatica (FK SigOpFp.fpags)
    this_nConsultas   = 1     && numeric(1,0)  consultas  - Listar na consulta (1=Sim / 2=Nao)
    this_nObgfator    = 0     && numeric(1,0)  obgfator   - Obrigatorio fator

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdMoe"
        THIS.this_cCampoChave = "cmoes"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDFUNC

    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT cmoes, dmoes, nordrels, cotas" + ;
                " FROM SigCdMoe"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY cmoes"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult > 0
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar moedas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Buscar: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT cmoes, dmoes, cotas, datatrans, fmults, nordrels," + ;
                " disfpres, valadics, moeqs, qtdeqs, toleras," + ;
                " grumoes, submoes, tabrefs, fpags, consultas, obgfator" + ;
                " FROM SigCdMoe" + ;
                " WHERE cmoes = " + EscaparSQL(ALLTRIM(par_cCodigo))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                MsgAviso("Moeda n" + CHR(227) + "o encontrada: " + ALLTRIM(par_cCodigo), "N" + CHR(227) + "o Encontrado")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo: " + loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo    = TratarNulo(cmoes,    "C")
            THIS.this_cDescricao = TratarNulo(dmoes,    "C")
            IF VARTYPE(cotas) = "L"
                THIS.this_lCotas = cotas
            ELSE
                THIS.this_lCotas = (NVL(cotas, 0) = 1)
            ENDIF
            THIS.this_cFmults    = TratarNulo(fmults,   "C")
            THIS.this_nNordrels  = TratarNulo(nordrels, "N")
            THIS.this_cDisfpres  = TratarNulo(disfpres, "C")
            THIS.this_nValadics  = TratarNulo(valadics, "N")
            THIS.this_cMoeqs     = TratarNulo(moeqs,    "C")
            THIS.this_nQtdeqs    = TratarNulo(qtdeqs,   "N")
            THIS.this_nToleras   = TratarNulo(toleras,  "N")
            THIS.this_cGrumoes   = TratarNulo(grumoes,  "C")
            THIS.this_cSubmoes   = TratarNulo(submoes,  "C")
            IF VARTYPE(tabrefs) = "L"
                THIS.this_lTabrefs = tabrefs
            ELSE
                THIS.this_lTabrefs = (NVL(tabrefs, 0) = 1)
            ENDIF
            THIS.this_cFpags     = TratarNulo(fpags,    "C")
            THIS.this_nConsultas = TratarNulo(consultas,"N")
            THIS.this_nObgfator  = TratarNulo(obgfator, "N")
            IF ISNULL(datatrans) OR EMPTY(datatrans)
                THIS.this_dDataTrans = {}
            ELSE
                THIS.this_dDataTrans = datatrans
            ENDIF
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarDados()
        LOCAL loc_cSQL, loc_nResult, loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCodigo))
            MsgAviso("C" + CHR(243) + "digo da moeda n" + CHR(227) + "o pode ser vazio!", ;
                "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cDescricao))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o da moeda n" + CHR(227) + "o pode ser vazia!", ;
                "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND !BETWEEN(THIS.this_nNordrels, 0, 5)
            MsgAviso("Ordem de Impress" + CHR(227) + "o nos Relat" + CHR(243) + ;
                "rios inv" + CHR(225) + "lida (0 a 5)!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            TRY
                IF USED("cursor_4c_ValidaMoe")
                    USE IN cursor_4c_ValidaMoe
                ENDIF
                loc_cSQL = "SELECT cmoes FROM SigCdMoe" + ;
                    " WHERE cmoes = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaMoe")
                IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ValidaMoe") > 0
                    MsgAviso("Moeda j" + CHR(225) + " cadastrada!", "Valida" + CHR(231) + CHR(227) + "o")
                    loc_lValido = .F.
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro na valida" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message, "Erro")
                loc_lValido = .F.
            ENDTRY
            IF USED("cursor_4c_ValidaMoe")
                USE IN cursor_4c_ValidaMoe
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cDisfpres
        loc_lSucesso = .F.

        loc_cDisfpres = THIS.this_cDisfpres
        IF EMPTY(ALLTRIM(loc_cDisfpres))
            loc_cDisfpres = "S"
        ENDIF

        TRY
            loc_cSQL = "INSERT INTO SigCdMoe" + ;
                " (cmoes, dmoes, cotas, datatrans, fmults, nordrels," + ;
                " disfpres, valadics, moeqs, qtdeqs, toleras," + ;
                " grumoes, submoes, tabrefs, fpags, consultas, obgfator)" + ;
                " VALUES (" + ;
                EscaparSQL(ALLTRIM(THIS.this_cCodigo)) + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cDescricao)) + ", " + ;
                IIF(THIS.this_lCotas, "1", "0") + ", " + ;
                "GETDATE(), " + ;
                EscaparSQL(THIS.this_cFmults) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNordrels) + ", " + ;
                EscaparSQL(loc_cDisfpres) + ", " + ;
                FormatarNumeroSQL(THIS.this_nValadics) + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cMoeqs)) + ", " + ;
                FormatarNumeroSQL(THIS.this_nQtdeqs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nToleras) + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrumoes)) + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cSubmoes)) + ", " + ;
                IIF(THIS.this_lTabrefs, "1", "0") + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cFpags)) + ", " + ;
                FormatarNumeroSQL(THIS.this_nConsultas) + ", " + ;
                FormatarNumeroSQL(THIS.this_nObgfator) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir moeda:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Inserir: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cDisfpres
        loc_lSucesso = .F.

        loc_cDisfpres = THIS.this_cDisfpres
        IF EMPTY(ALLTRIM(loc_cDisfpres))
            loc_cDisfpres = "S"
        ENDIF

        TRY
            loc_cSQL = "UPDATE SigCdMoe SET" + ;
                " dmoes = " + EscaparSQL(ALLTRIM(THIS.this_cDescricao)) + "," + ;
                " cotas = " + IIF(THIS.this_lCotas, "1", "0") + "," + ;
                " datatrans = GETDATE()," + ;
                " fmults = " + EscaparSQL(THIS.this_cFmults) + "," + ;
                " nordrels = " + FormatarNumeroSQL(THIS.this_nNordrels) + "," + ;
                " disfpres = " + EscaparSQL(loc_cDisfpres) + "," + ;
                " valadics = " + FormatarNumeroSQL(THIS.this_nValadics) + "," + ;
                " moeqs = " + EscaparSQL(ALLTRIM(THIS.this_cMoeqs)) + "," + ;
                " qtdeqs = " + FormatarNumeroSQL(THIS.this_nQtdeqs) + "," + ;
                " toleras = " + FormatarNumeroSQL(THIS.this_nToleras) + "," + ;
                " grumoes = " + EscaparSQL(ALLTRIM(THIS.this_cGrumoes)) + "," + ;
                " submoes = " + EscaparSQL(ALLTRIM(THIS.this_cSubmoes)) + "," + ;
                " tabrefs = " + IIF(THIS.this_lTabrefs, "1", "0") + "," + ;
                " fpags = " + EscaparSQL(ALLTRIM(THIS.this_cFpags)) + "," + ;
                " consultas = " + FormatarNumeroSQL(THIS.this_nConsultas) + "," + ;
                " obgfator = " + FormatarNumeroSQL(THIS.this_nObgfator) + ;
                " WHERE cmoes = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar moeda:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_lPodeExcluir
        loc_lSucesso   = .F.
        loc_lPodeExcluir = .F.

        *-- Verificar se há cotações cadastradas
        TRY
            IF USED("cursor_4c_VerifCot")
                USE IN cursor_4c_VerifCot
            ENDIF
            loc_cSQL = "SELECT TOP 1 cidchaves FROM SigCdCot" + ;
                " WHERE cmoes = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerifCot")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_VerifCot") > 0
                MsgErro("Imposs" + CHR(237) + "vel excluir moeda com cota" + CHR(231) + ;
                    CHR(227) + "o cadastrada!", "Exclus" + CHR(227) + "o Inv" + CHR(225) + "lida")
            ELSE
                loc_lPodeExcluir = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar cota" + CHR(231) + CHR(245) + "es: " + loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_VerifCot")
            USE IN cursor_4c_VerifCot
        ENDIF

        IF loc_lPodeExcluir
            TRY
                loc_cSQL = "DELETE FROM SigCdMoe" + ;
                    " WHERE cmoes = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult > 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao excluir moeda:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro em ExecutarExclusao: " + loc_oErro.Message, "Erro")
            ENDTRY
        ENDIF
        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

