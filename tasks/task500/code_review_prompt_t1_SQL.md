# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS

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
  ControlSource = "CrSigCdPmc.codigo"
  ControlSource = "CrSigCdPmc.dtfin"
  ControlSource = "CrSigCdPmc.dtini"
  ControlSource = "CrSigCdPmc.valmin"
  ControlSource = "CrSigCdPmc.cpros"
  ControlSource = "crSigCdPmc.tppro"
	lcQuery = 	[Select * From SigCdPmc where cpros = ']+CrSigCdPmc.cpros+[' and ']+lcDat+[' ]+;
	If ThisForm.Podatamgr.Sqlexecute(lcQuery,'crAux1') < 1
	lcQuery = 	[Select * From SigCdPmc where cpros = ']+CrSigCdPmc.cpros+[' and ']+lcDat+[' ]+;
	If ThisForm.Podatamgr.Sqlexecute(lcQuery,'crAux2') < 1

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormPMC.prg) - TRECHOS RELEVANTES PARA PASS SQL (1327 linhas total):

*-- Linhas 344 a 362:
344:             .HighlightBackColor = RGB(255, 255, 255)
345:             .HighlightForeColor = RGB(15, 41, 104)
346:             .HighlightStyle     = 2
347:             .DeleteMark         = .F.
348:             .RecordMark         = .F.
349:             .RowHeight          = 16
350:             .ScrollBars         = 2
351:             .GridLines          = 3
352:             .ReadOnly           = .T.
353:             .Visible            = .T.
354:             .Column1.Width      = 80
355:             .Column1.ReadOnly   = .T.
356:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
357:             .Column2.Width      = 150
358:             .Column2.ReadOnly   = .T.
359:             .Column2.Header1.Caption = "Produto"
360:             .Column3.Width      = 80
361:             .Column3.ReadOnly   = .T.
362:             .Column3.Header1.Caption = "Tipo"

*-- Linhas 669 a 694:
669:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
670:                         loc_oGrid.ColumnCount = 8
671:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
672:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigo"
673:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.cpros"
674:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.tppro"
675:                         loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.valmin"
676:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.dtini"
677:                         loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.dtfin"
678:                         loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.usualts"
679:                         loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.dtalts"
680:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
681:                         loc_oGrid.Column2.Header1.Caption = "Produto"
682:                         loc_oGrid.Column3.Header1.Caption = "Tipo"
683:                         loc_oGrid.Column4.Header1.Caption = "Valor M" + CHR(237) + "nimo"
684:                         loc_oGrid.Column5.Header1.Caption = "Dt In" + CHR(237) + "cio"
685:                         loc_oGrid.Column6.Header1.Caption = "Dt final"
686:                         loc_oGrid.Column7.Header1.Caption = "Usu" + CHR(225) + "rio"
687:                         loc_oGrid.Column8.Header1.Caption = "Altera" + CHR(231) + CHR(227) + "o"
688:                         THIS.FormatarGridLista(loc_oGrid)
689:                     ENDIF
690:                     loc_lResultado = .T.
691:                 ENDIF
692:             ENDIF
693:         CATCH TO loc_oErro
694:             MsgErro("Erro em FormPMC.CarregarLista:" + CHR(13) + loc_oErro.Message + ;

*-- Linhas 811 a 829:
811:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
812:                 MsgAviso("Selecione um registro na lista.", "Visualizar")
813:             ELSE
814:                 SELECT cursor_4c_Dados
815:                 IF EOF("cursor_4c_Dados")
816:                     MsgAviso("Selecione um registro na lista.", "Visualizar")
817:                 ELSE
818:                     loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigo)
819:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
820:                         THIS.this_cModoAtual    = "VISUALIZAR"
821:                         THIS.this_cPkChaveAtual = loc_cCodigo
822:                         THIS.BOParaForm()
823:                         THIS.HabilitarCampos(.F.)
824:                         THIS.AjustarBotoesPorModo()
825:                         THIS.AlternarPagina(2)
826:                     ELSE
827:                         MsgErro("Erro ao carregar registro!", "Visualizar")
828:                     ENDIF
829:                 ENDIF

*-- Linhas 844 a 862:
844:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
845:                 MsgAviso("Selecione um registro na lista.", "Alterar")
846:             ELSE
847:                 SELECT cursor_4c_Dados
848:                 IF EOF("cursor_4c_Dados")
849:                     MsgAviso("Selecione um registro na lista.", "Alterar")
850:                 ELSE
851:                     loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigo)
852:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
853:                         THIS.this_oBusinessObject.EditarRegistro()
854:                         THIS.this_cModoAtual    = "ALTERAR"
855:                         THIS.this_cPkChaveAtual = loc_cCodigo
856:                         THIS.BOParaForm()
857:                         THIS.HabilitarCampos(.T.)
858:                         THIS.AjustarBotoesPorModo()
859:                         THIS.AlternarPagina(2)
860:                         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Valmin", 5)
861:                             THIS.pgf_4c_Paginas.Page2.txt_4c_Valmin.SetFocus
862:                         ENDIF

*-- Linhas 881 a 899:
881:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
882:                 MsgAviso("Selecione um registro na lista.", "Excluir")
883:             ELSE
884:                 SELECT cursor_4c_Dados
885:                 IF EOF("cursor_4c_Dados")
886:                     MsgAviso("Selecione um registro na lista.", "Excluir")
887:                 ELSE
888:                     loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigo)
889:                     IF MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", ;
890:                                    "Confirmar Exclus" + CHR(227) + "o")
891:                         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
892:                             IF THIS.this_oBusinessObject.Excluir()
893:                                 MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", ;
894:                                         "Exclu" + CHR(237) + "do")
895:                                 THIS.CarregarLista()
896:                             ELSE
897:                                 MsgErro("Erro ao excluir registro!", "Excluir")
898:                             ENDIF
899:                         ELSE

*-- Linhas 918 a 949:
918: 
919:         TRY
920:             IF !EMPTY(ALLTRIM(loc_cTermoBusca))
921:                 loc_cFiltro = "cpros LIKE " + EscaparSQL(ALLTRIM(loc_cTermoBusca) + "%")
922:                 IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
923:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
924:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
925:                         loc_oGrid.ColumnCount = 8
926:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
927:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigo"
928:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.cpros"
929:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.tppro"
930:                         loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.valmin"
931:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.dtini"
932:                         loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.dtfin"
933:                         loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.usualts"
934:                         loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.dtalts"
935:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
936:                         loc_oGrid.Column2.Header1.Caption = "Produto"
937:                         loc_oGrid.Column3.Header1.Caption = "Tipo"
938:                         loc_oGrid.Column4.Header1.Caption = "Valor M" + CHR(237) + "nimo"
939:                         loc_oGrid.Column5.Header1.Caption = "Dt In" + CHR(237) + "cio"
940:                         loc_oGrid.Column6.Header1.Caption = "Dt final"
941:                         loc_oGrid.Column7.Header1.Caption = "Usu" + CHR(225) + "rio"
942:                         loc_oGrid.Column8.Header1.Caption = "Altera" + CHR(231) + CHR(227) + "o"
943:                         THIS.FormatarGridLista(loc_oGrid)
944:                     ENDIF
945:                 ENDIF
946:             ELSE
947:                 THIS.CarregarLista()
948:             ENDIF
949:         CATCH TO loc_oErro

*-- Linhas 1298 a 1325:
1298:         ENDIF
1299: 
1300:         TRY
1301:             loc_cSQL = "SELECT CPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCpros)
1302: 
1303:             IF USED("cursor_4c_ValPro")
1304:                 USE IN cursor_4c_ValPro
1305:             ENDIF
1306: 
1307:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValPro")
1308: 
1309:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ValPro") > 0
1310:                 SELECT cursor_4c_ValPro
1311:                 loc_oPg2.txt_4c_Cpros.Value = ALLTRIM(cursor_4c_ValPro.CPros)
1312:             ELSE
1313:                 THIS.AbrirBuscaProduto()
1314:             ENDIF
1315: 
1316:             IF USED("cursor_4c_ValPro")
1317:                 USE IN cursor_4c_ValPro
1318:             ENDIF
1319:         CATCH TO loc_oErro
1320:             MsgErro("Erro em ValidarProduto:" + CHR(13) + loc_oErro.Message, "Erro")
1321:             IF USED("cursor_4c_ValPro")
1322:                 USE IN cursor_4c_ValPro
1323:             ENDIF
1324:         ENDTRY
1325:     ENDPROC


### BO (C:\4c\projeto\app\classes\PMCBO.prg):
*==============================================================================
* PMCBO.prg - Business Object: Tabela de Promo??es por Per?odo
* Tabela: SigCdPmc (PK: codigo)
* Schema:
*   codigo   char(10)     PK  auto-gerado PMC+AAMM+SEQ
*   cpros    char(14)     FK SigCdPro.CPros
*   tppro    numeric(2,0) tipo (1=Brinde)
*   dtini    datetime     data inicial
*   dtfin    datetime     data final
*   valmin   numeric(9,2) valor minimo
*   usualts  char(10)     usuario ultima alteracao
*   dtalts   datetime     data/hora ultima alteracao
*==============================================================================
DEFINE CLASS PMCBO AS BusinessBase

    *-- Chave prim?ria
    this_cCodigo   = ""

    *-- Produto (FK SigCdPro.CPros)
    this_cCpros    = ""

    *-- Tipo de promo??o: 1=Brinde
    this_nTppro    = 0

    *-- Per?odo de vig?ncia
    this_tDtini    = {}
    this_tDtfin    = {}

    *-- Valor m?nimo da venda para conceder o brinde
    this_nValmin   = 0

    *-- Auditoria
    this_cUsualts  = ""
    this_tDtalts   = {}

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        DODEFAULT()
        THIS.this_cTabela     = "SigCdPmc"
        THIS.this_cCampoChave = "codigo"
        RETURN .T.
    ENDPROC

    *==========================================================================
    PROCEDURE ObterChavePrimaria()
    *==========================================================================
        RETURN THIS.this_cCodigo
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo   = TratarNulo(codigo,   "")
            THIS.this_cCpros    = TratarNulo(cpros,    "")
            THIS.this_nTppro    = TratarNulo(tppro,    0)
            THIS.this_tDtini    = TratarNulo(dtini,    {})
            THIS.this_tDtfin    = TratarNulo(dtfin,    {})
            THIS.this_nValmin   = TratarNulo(valmin,   0)
            THIS.this_cUsualts  = TratarNulo(usualts,  "")
            THIS.this_tDtalts   = TratarNulo(dtalts,   {})
            THIS.this_lNovoRegistro = .F.
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - SELECT lista para o grid
    * par_cFiltro: condi??o SQL adicional (sem WHERE), ou "" para todos
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cWhere
        loc_lSucesso = .F.

        TRY
            loc_cWhere = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = "SELECT codigo, cpros, tppro, valmin, dtini, dtfin," + ;
                       " usualts, dtalts" + ;
                       " FROM SigCdPmc" + loc_cWhere + ;
                       " ORDER BY codigo"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar promo??es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em PMCBO.Buscar:" + CHR(13) + loException.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega um registro pelo c?digo (PK)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigo, cpros, tppro, valmin, dtini, dtfin," + ;
                       " usualts, dtalts" + ;
                       " FROM SigCdPmc" + ;
                       " WHERE codigo = " + EscaparSQL(par_cCodigo)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em PMCBO.CarregarPorCodigo:" + CHR(13) + loException.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * GerarCodigo - Gera c?digo auto no formato PMC+AAMM+SEQ (ex: PMC2608001)
    * Replica l?gica original: 'PMC'+SUBSTR(STR(YEAR),3)+PADL(MONTH,2,'0')+SEQ
    *==========================================================================
    PROCEDURE GerarCodigo()
    *==========================================================================
        LOCAL loc_cPrefixo, loc_cSQL, loc_nResult, loc_cCodigo, loc_nSeq, loc_lSucesso
        loc_lSucesso = .F.
        loc_cCodigo  = ""

        TRY
            loc_cPrefixo = "PMC" + SUBSTR(ALLTRIM(STR(YEAR(DATE()))), 3) + ;
                           PADL(ALLTRIM(STR(MONTH(DATE()))), 2, "0")

            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdPmc" + ;
                       " WHERE codigo LIKE " + EscaparSQL(loc_cPrefixo + "%")

            IF USED("cursor_4c_Seq")
                USE IN cursor_4c_Seq
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Seq")

            IF loc_nResult >= 0
                SELECT cursor_4c_Seq
                loc_nSeq    = cursor_4c_Seq.qtd + 1
                loc_cCodigo = loc_cPrefixo + PADL(ALLTRIM(STR(loc_nSeq)), 3, "0")
                USE IN cursor_4c_Seq
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao gerar c?digo PMC:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                IF USED("cursor_4c_Seq")
                    USE IN cursor_4c_Seq
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em PMCBO.GerarCodigo:" + CHR(13) + loException.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        IF loc_lSucesso
            THIS.this_cCodigo = loc_cCodigo
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDtIniFim - Valida que dtini <= dtfin e que o per?odo n?o existe
    * Retorna "" se OK, ou mensagem de erro
    *==========================================================================
    PROCEDURE ValidarPeriodo()
    *==========================================================================
        LOCAL loc_cMsg, loc_cSQL, loc_nResult, loc_cDtIni, loc_cDtFin, loc_lSucesso
        loc_cMsg     = ""
        loc_lSucesso = .T.

        TRY
            *-- Validar campos obrigat?rios
            IF EMPTY(THIS.this_cCpros)
                loc_lSucesso = "Produto n" + CHR(227) + "o pode ficar em branco!"
            ENDIF
            IF EMPTY(THIS.this_tDtini)
                loc_lSucesso = "Data Inicial n" + CHR(227) + "o pode ficar em branco!"
            ENDIF
            IF EMPTY(THIS.this_tDtfin)
                loc_lSucesso = "Data final n" + CHR(227) + "o pode ficar em branco!"
            ENDIF
            IF THIS.this_tDtini > THIS.this_tDtfin
                loc_lSucesso = "As datas est" + CHR(227) + "o incompat" + CHR(237) + "veis!"
            ENDIF

            *-- Verificar sobreposi??o de per?odo para o mesmo produto (s? no INSERT)
            IF THIS.this_lNovoRegistro
                loc_cDtIni = FormatarDataSQL(THIS.this_tDtini)
                loc_cDtFin = FormatarDataSQL(THIS.this_tDtfin)

                loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdPmc" + ;
                           " WHERE cpros = " + EscaparSQL(THIS.this_cCpros) + ;
                           " AND (" + ;
                           "  " + loc_cDtIni + " BETWEEN" + ;
                           "    LEFT(CONVERT(VARCHAR, dtini, 120), 10)" + ;
                           "    AND LEFT(CONVERT(VARCHAR, dtfin, 120), 10)" + ;
                           " OR " + ;
                           "  " + loc_cDtFin + " BETWEEN" + ;
                           "    LEFT(CONVERT(VARCHAR, dtini, 120), 10)" + ;
                           "    AND LEFT(CONVERT(VARCHAR, dtfin, 120), 10)" + ;
                           ")"

                IF USED("cursor_4c_Val")
                    USE IN cursor_4c_Val
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Val")

                IF loc_nResult >= 0
                    SELECT cursor_4c_Val
                    IF cursor_4c_Val.qtd > 0
                        loc_cMsg = "Esse intervalo j" + CHR(225) + " est" + CHR(225) + ;
                                   " cadastrado para esse produto!"
                    ENDIF
                    USE IN cursor_4c_Val
                ELSE
                    MsgErro("Erro ao validar per?odo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    IF USED("cursor_4c_Val")
                        USE IN cursor_4c_Val
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em PMCBO.ValidarPeriodo:" + CHR(13) + loException.Message, "Erro")
            loc_cMsg = "Erro interno ao validar per?odo."
        ENDTRY

        RETURN loc_cMsg
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE Inserir()
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdPmc" + ;
                       " (codigo, cpros, tppro, dtini, dtfin, valmin, usualts, dtalts)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigo)            + ", " + ;
                       EscaparSQL(THIS.this_cCpros)             + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTppro)       + ", " + ;
                       FormatarDataSQL(THIS.this_tDtini)         + ", " + ;
                       FormatarDataSQL(THIS.this_tDtfin)         + ", " + ;
                       FormatarNumeroSQL(THIS.this_nValmin)      + ", " + ;
                       EscaparSQL(THIS.this_cUsualts)           + ", " + ;
                       FormatarDataSQL(THIS.this_tDtalts)        + ;
                       ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir promo??o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em PMCBO.Inserir:" + CHR(13) + loException.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdPmc SET" + ;
                       " cpros   = " + EscaparSQL(THIS.this_cCpros)          + ", " + ;
                       " tppro   = " + FormatarNumeroSQL(THIS.this_nTppro)   + ", " + ;
                       " dtini   = " + FormatarDataSQL(THIS.this_tDtini)     + ", " + ;
                       " dtfin   = " + FormatarDataSQL(THIS.this_tDtfin)     + ", " + ;
                       " valmin  = " + FormatarNumeroSQL(THIS.this_nValmin)  + ", " + ;
                       " usualts = " + EscaparSQL(THIS.this_cUsualts)        + ", " + ;
                       " dtalts  = " + FormatarDataSQL(THIS.this_tDtalts)    + ;
                       " WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar promo??o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em PMCBO.Atualizar:" + CHR(13) + loException.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdPmc WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir promo??o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em PMCBO.ExecutarExclusao:" + CHR(13) + loException.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

