# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TOTAL' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ABREVS, DOPES, CODIGOS

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
  ControlSource = "crSigCdObs.Comiss"
  ControlSource = "crSigCdObs.descrs"
  ControlSource = "crSigCdObs.Classifs"
  ControlSource = "crSigCdObs.grupos"
  ControlSource = "crSigCdObs.Observas"
  ControlSource = "crSigCdObs.Codigos"
  ControlSource = "crSigCdObs.agrupas"
  ControlSource = "crSigCdObs.MovAutDop"
	.podatamgr.sqlexecute([Select Dopes, Cmoes, nFiscals, Abrevs From SigCdOpe Order by Dopes],'nivel')
Select CrSigCdObs
Select CrSigCdObs
	Select * From Nivel Where Abrevs <> ' ' Into Cursor Selecao ReadWrite
	Select Selecao

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormObs.prg) - TRECHOS RELEVANTES PARA PASS SQL (1517 linhas total):

*-- Linhas 63 a 82:
63:                 MsgErro("Falha ao criar ObsBO", "Erro")
64:             ELSE
65:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
66:                     SQLEXEC(gnConnHandle, ;
67:                         "SELECT Dopes, Cmoes, nFiscals, Abrevs FROM SigCdOpe" + ;
68:                         " ORDER BY Dopes", ;
69:                         "cursor_4c_Nivel")
70:                 ENDIF
71: 
72:                 THIS.ConfigurarPageFrame()
73: 
74:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
75:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
76: 
77:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
78:                     THIS.CarregarLista()
79:                 ENDIF
80: 
81:                 THIS.pgf_4c_Paginas.Visible  = .T.
82:                 THIS.pgf_4c_Paginas.ActivePage = 1

*-- Linhas 355 a 373:
355:             .Left               = 12
356:             .Width              = 894
357:             .Height             = 455
358:             .DeleteMark         = .F.
359:             .RecordMark         = .F.
360:             .RowHeight          = 16
361:             .ScrollBars         = 2
362:             .GridLines          = 3
363:             .HighlightStyle     = 2
364:             .HighlightBackColor = RGB(255, 255, 255)
365:             .HighlightForeColor = RGB(15, 41, 104)
366:             .GridLineColor      = RGB(238, 238, 238)
367:             .BackColor          = RGB(255, 255, 255)
368:             .FontName           = "Tahoma"
369:             .FontSize           = 8
370:             .Visible            = .T.
371:         ENDWITH
372: 
373:         *-- ColumnCount FORA de WITH (Problema 36: colunas precisam existir antes de acessar)

*-- Linhas 1067 a 1090:
1067:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1068:                     loc_oGrid.ColumnCount  = 5
1069: 
1070:                     *-- ControlSource APOS RecordSource (Problema 48)
1071:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Codigos"
1072:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descrs"
1073:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.PgComissao"
1074:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.Grupos"
1075:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Agrupas"
1076: 
1077:                     *-- Larguras e Headers APOS RecordSource (Problema 32)
1078:                     loc_oGrid.Column1.Width           = 50
1079:                     loc_oGrid.Column1.Alignment       = 2
1080:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1081:                     loc_oGrid.Column2.Width           = 450
1082:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(245) + "es"
1083:                     loc_oGrid.Column3.Width           = 90
1084:                     loc_oGrid.Column3.Alignment       = 2
1085:                     loc_oGrid.Column3.Header1.Caption = "Pg.Comiss" + CHR(227) + "o"
1086:                     loc_oGrid.Column4.Width           = 80
1087:                     loc_oGrid.Column4.Header1.Caption = "Grupo"
1088:                     loc_oGrid.Column5.Width           = 80
1089:                     loc_oGrid.Column5.Header1.Caption = "Agrupam."
1090: 

*-- Linhas 1150 a 1173:
1150:                 loc_lResultado = .T.
1151:             ELSE
1152:                 IF USED("cursor_4c_Nivel")
1153:                 SELECT Dopes, Cmoes, nFiscals, Abrevs ;
1154:                     FROM cursor_4c_Nivel ;
1155:                     WHERE !EMPTY(ALLTRIM(Abrevs)) ;
1156:                     INTO CURSOR cursor_4c_NivelSel READWRITE
1157: 
1158:                 SELECT cursor_4c_NivelSel
1159:                 LOCATE FOR ALLTRIM(Dopes) = loc_cValor
1160:                 IF EOF()
1161:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1162:                     IF VARTYPE(loc_oBusca) = "O"
1163:                         loc_oBusca.this_cCursorDestino = "cursor_4c_NivelSel"
1164:                         loc_oBusca.this_cTitulo = "Opera" + CHR(231) + CHR(245) + "es"
1165:                         loc_oBusca.mAddColuna("Dopes", "", "C" + CHR(243) + "digo")
1166:                         loc_oBusca.Show()
1167: 
1168:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_NivelSel")
1169:                             THIS.pgf_4c_Paginas.Page2.txt_4c_MovAutDop.Value = ;
1170:                                 ALLTRIM(cursor_4c_NivelSel.Dopes)
1171:                         ELSE
1172:                             THIS.pgf_4c_Paginas.Page2.txt_4c_MovAutDop.Value = ""
1173:                         ENDIF

*-- Linhas 1321 a 1339:
1321:             RETURN
1322:         ENDIF
1323: 
1324:         SELECT cursor_4c_Dados
1325:         loc_nCodigo = cursor_4c_Dados.Codigos
1326: 
1327:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
1328:             MsgErro("Registro n" + CHR(227) + "o encontrado.", "Alterar")
1329:             RETURN
1330:         ENDIF
1331: 
1332:         THIS.this_oBusinessObject.EditarRegistro()
1333:         THIS.this_cModoAtual = "ALTERAR"
1334:         THIS.BOParaForm()
1335:         THIS.HabilitarCampos(.T.)
1336:         THIS.AlternarPagina(2)
1337: 
1338:         TRY
1339:             THIS.pgf_4c_Paginas.Page2.edt_4c_Observas.SetFocus()

*-- Linhas 1354 a 1372:
1354:             RETURN
1355:         ENDIF
1356: 
1357:         SELECT cursor_4c_Dados
1358:         loc_nCodigo = cursor_4c_Dados.Codigos
1359: 
1360:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
1361:             MsgErro("Registro n" + CHR(227) + "o encontrado.", "Visualizar")
1362:             RETURN
1363:         ENDIF
1364: 
1365:         THIS.this_cModoAtual = "VISUALIZAR"
1366:         THIS.BOParaForm()
1367:         THIS.HabilitarCampos(.F.)
1368:         THIS.AlternarPagina(2)
1369: 
1370:         TRY
1371:             THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus()
1372:         CATCH

*-- Linhas 1385 a 1403:
1385:             RETURN
1386:         ENDIF
1387: 
1388:         SELECT cursor_4c_Dados
1389:         loc_nCodigo = cursor_4c_Dados.Codigos
1390: 
1391:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da observa" + CHR(231) + ;
1392:                 CHR(227) + "o " + TRANSFORM(loc_nCodigo) + "?", "Excluir")
1393:             RETURN
1394:         ENDIF
1395: 
1396:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
1397:             MsgErro("Registro n" + CHR(227) + "o encontrado.", "Excluir")
1398:             RETURN
1399:         ENDIF
1400: 
1401:         IF THIS.this_oBusinessObject.Excluir()
1402:             MsgInfo("Observa" + CHR(231) + CHR(227) + "o exclu" + CHR(237) + "da com sucesso!", "Excluir")
1403:             THIS.CarregarLista()

*-- Linhas 1447 a 1465:
1447:         IF THIS.this_cModoAtual = "PROCURAR"
1448:             loc_nCodigo = THIS.pgf_4c_Paginas.Page2.txt_4c_Codigos.Value
1449:             IF loc_nCodigo > 0 AND USED("cursor_4c_Dados")
1450:                 SELECT cursor_4c_Dados
1451:                 LOCATE FOR Codigos = loc_nCodigo
1452:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
1453:             ENDIF
1454:             THIS.AlternarPagina(1)
1455:             RETURN
1456:         ENDIF
1457: 
1458:         *-- Modo VISUALIZAR: Confirmar nao deveria estar habilitado, mas por seguranca cancela
1459:         IF THIS.this_cModoAtual = "VISUALIZAR"
1460:             THIS.BtnCancelarClick()
1461:             RETURN
1462:         ENDIF
1463: 
1464:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
1465:         loc_nCodigo = loc_oPg2.txt_4c_Codigos.Value

*-- Linhas 1479 a 1499:
1479: 
1480:         *-- Verificar codigo duplicado apenas para INCLUIR
1481:         IF THIS.this_cModoAtual = "INCLUIR"
1482:             loc_nVerif = SQLEXEC(gnConnHandle, ;
1483:                 "SELECT COUNT(*) AS Total FROM SigCdObs WHERE Codigos = " + ;
1484:                 FormatarNumeroSQL(loc_nCodigo), "cursor_4c_Verif")
1485:             IF loc_nVerif >= 0 AND USED("cursor_4c_Verif") AND cursor_4c_Verif.Total > 0
1486:                 IF USED("cursor_4c_Verif")
1487:                     USE IN cursor_4c_Verif
1488:                 ENDIF
1489:                 MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado.", "Salvar")
1490:                 loc_oPg2.txt_4c_Codigos.SetFocus()
1491:                 RETURN
1492:             ENDIF
1493:             IF USED("cursor_4c_Verif")
1494:                 USE IN cursor_4c_Verif
1495:             ENDIF
1496:         ENDIF
1497: 
1498:         THIS.FormParaBO()
1499: 


### BO (C:\4c\projeto\app\classes\ObsBO.prg):
*====================================================================
* ObsBO.prg
*
* Business Object para Cadastro de Observacoes
* Tabela: SigCdObs
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS ObsBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdObs)
    this_nCodigos    = 0     && Codigos numeric(3,0) - PK
    this_cDescrs     = ""    && descrs  char
    this_cObservas   = ""    && Observas memo
    this_cGrupos     = ""    && grupos  char
    this_cAgrupas    = ""    && agrupas char
    this_nComiss     = 0     && Comiss  numeric (1=Sim, 2=Nao)
    this_nClassifs   = 0     && Classifs numeric (1=Grave, 2=Leve, 3=Interno)
    this_cMovAutDop  = ""    && MovAutDop char (lookup SigCdOpe.Dopes)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdObs"
            THIS.this_cCampoChave = "Codigos"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "ObsBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna valor da PK para auditoria (PUBLIC)
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nCodigos)
    ENDFUNC

    *====================================================================
    * Buscar - Carrega lista de registros no cursor_4c_Dados (PUBLIC)
    * par_cFiltro: condicao WHERE sem "WHERE" (pode ser "")
    *====================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cWhere = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = "SELECT Codigos, Descrs," + ;
                       " CASE WHEN Comiss = 2 THEN 'NAO' ELSE 'SIM' END AS PgComissao," + ;
                       " Grupos, Agrupas" + ;
                       " FROM SigCdObs" + ;
                       loc_cWhere + ;
                       " ORDER BY Codigos"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar observa" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "ObsBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pelo codigo (PUBLIC)
    *====================================================================
    FUNCTION CarregarPorCodigo(par_nCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Codigos, Descrs, Observas, Comiss, Classifs," + ;
                       " Grupos, Agrupas, MovAutDop" + ;
                       " FROM SigCdObs" + ;
                       " WHERE Codigos = " + FormatarNumeroSQL(par_nCodigo)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar observa" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "ObsBO.CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Popula propriedades a partir de cursor (PROTECTED)
    *====================================================================
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_nCodigos   = TratarNulo(codigos,   "N")
                THIS.this_cDescrs    = TratarNulo(descrs,    "C")
                THIS.this_cObservas  = TratarNulo(observas,  "C")
                THIS.this_cGrupos    = TratarNulo(grupos,    "C")
                THIS.this_cAgrupas   = TratarNulo(agrupas,   "C")
                THIS.this_nComiss    = TratarNulo(comiss,    "N")
                THIS.this_nClassifs  = TratarNulo(classifs,  "N")
                THIS.this_cMovAutDop = TratarNulo(movautdop, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "ObsBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * Inserir - Insere novo registro na tabela (PROTECTED)
    * Chamado por BusinessBase.Salvar() quando this_lNovoRegistro=.T.
    *====================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdObs" + ;
                       " (Codigos, Descrs, Observas, Comiss, Classifs," + ;
                       "  Grupos, Agrupas, MovAutDop)" + ;
                       " VALUES (" + ;
                       FormatarNumeroSQL(THIS.this_nCodigos) + ", " + ;
                       EscaparSQL(THIS.this_cDescrs) + ", " + ;
                       EscaparSQL(THIS.this_cObservas) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nComiss) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClassifs) + ", " + ;
                       EscaparSQL(THIS.this_cGrupos) + ", " + ;
                       EscaparSQL(THIS.this_cAgrupas) + ", " + ;
                       EscaparSQL(THIS.this_cMovAutDop) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir observa" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "ObsBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * Atualizar - Atualiza registro existente (PROTECTED)
    * Chamado por BusinessBase.Salvar() quando this_lNovoRegistro=.F.
    *====================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdObs SET" + ;
                       " Descrs    = " + EscaparSQL(THIS.this_cDescrs) + "," + ;
                       " Observas  = " + EscaparSQL(THIS.this_cObservas) + "," + ;
                       " Comiss    = " + FormatarNumeroSQL(THIS.this_nComiss) + "," + ;
                       " Classifs  = " + FormatarNumeroSQL(THIS.this_nClassifs) + "," + ;
                       " Grupos    = " + EscaparSQL(THIS.this_cGrupos) + "," + ;
                       " Agrupas   = " + EscaparSQL(THIS.this_cAgrupas) + "," + ;
                       " MovAutDop = " + EscaparSQL(THIS.this_cMovAutDop) + ;
                       " WHERE Codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar observa" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "ObsBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ExecutarExclusao - Remove registro da tabela (PROTECTED)
    * Chamado internamente por BusinessBase.Excluir()
    *====================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdObs" + ;
                       " WHERE Codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir observa" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "ObsBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * BuscarOperacoesNivel - Carrega cursor para lookup de MovAutDop (PUBLIC)
    * Equivalente ao: Select Dopes,Cmoes,nFiscals,Abrevs From SigCdOpe
    * Usado pelo Form para popular o lookup de Movimentacao Automatica
    *====================================================================
    FUNCTION BuscarOperacoesNivel()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Nivel")
                USE IN cursor_4c_Nivel
            ENDIF

            loc_cSQL = "SELECT Dopes, Cmoes, NFiscals, Abrevs" + ;
                       " FROM SigCdOpe" + ;
                       " WHERE LTRIM(RTRIM(Abrevs)) <> ''" + ;
                       " ORDER BY Dopes"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Nivel")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "ObsBO.BuscarOperacoesNivel")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

