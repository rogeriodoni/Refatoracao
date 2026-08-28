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

### FORM (C:\4c\projeto\app\forms\cadastros\FormPMC.prg) - TRECHOS RELEVANTES PARA PASS SQL (1328 linhas total):

*-- Linhas 345 a 363:
345:             .HighlightBackColor = RGB(255, 255, 255)
346:             .HighlightForeColor = RGB(15, 41, 104)
347:             .HighlightStyle     = 2
348:             .DeleteMark         = .F.
349:             .RecordMark         = .F.
350:             .RowHeight          = 16
351:             .ScrollBars         = 2
352:             .GridLines          = 3
353:             .ReadOnly           = .T.
354:             .Visible            = .T.
355:             .Column1.Width      = 80
356:             .Column1.ReadOnly   = .T.
357:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
358:             .Column2.Width      = 150
359:             .Column2.ReadOnly   = .T.
360:             .Column2.Header1.Caption = "Produto"
361:             .Column3.Width      = 80
362:             .Column3.ReadOnly   = .T.
363:             .Column3.Header1.Caption = "Tipo"

*-- Linhas 670 a 695:
670:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
671:                         loc_oGrid.ColumnCount = 8
672:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
673:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigo"
674:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.cpros"
675:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.tppro"
676:                         loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.valmin"
677:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.dtini"
678:                         loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.dtfin"
679:                         loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.usualts"
680:                         loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.dtalts"
681:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
682:                         loc_oGrid.Column2.Header1.Caption = "Produto"
683:                         loc_oGrid.Column3.Header1.Caption = "Tipo"
684:                         loc_oGrid.Column4.Header1.Caption = "Valor M" + CHR(237) + "nimo"
685:                         loc_oGrid.Column5.Header1.Caption = "Dt In" + CHR(237) + "cio"
686:                         loc_oGrid.Column6.Header1.Caption = "Dt final"
687:                         loc_oGrid.Column7.Header1.Caption = "Usu" + CHR(225) + "rio"
688:                         loc_oGrid.Column8.Header1.Caption = "Altera" + CHR(231) + CHR(227) + "o"
689:                         THIS.FormatarGridLista(loc_oGrid)
690:                     ENDIF
691:                     loc_lResultado = .T.
692:                 ENDIF
693:             ENDIF
694:         CATCH TO loc_oErro
695:             MsgErro("Erro em FormPMC.CarregarLista:" + CHR(13) + loc_oErro.Message + ;

*-- Linhas 812 a 830:
812:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
813:                 MsgAviso("Selecione um registro na lista.", "Visualizar")
814:             ELSE
815:                 SELECT cursor_4c_Dados
816:                 IF EOF("cursor_4c_Dados")
817:                     MsgAviso("Selecione um registro na lista.", "Visualizar")
818:                 ELSE
819:                     loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigo)
820:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
821:                         THIS.this_cModoAtual    = "VISUALIZAR"
822:                         THIS.this_cPkChaveAtual = loc_cCodigo
823:                         THIS.BOParaForm()
824:                         THIS.HabilitarCampos(.F.)
825:                         THIS.AjustarBotoesPorModo()
826:                         THIS.AlternarPagina(2)
827:                     ELSE
828:                         MsgErro("Erro ao carregar registro!", "Visualizar")
829:                     ENDIF
830:                 ENDIF

*-- Linhas 845 a 863:
845:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
846:                 MsgAviso("Selecione um registro na lista.", "Alterar")
847:             ELSE
848:                 SELECT cursor_4c_Dados
849:                 IF EOF("cursor_4c_Dados")
850:                     MsgAviso("Selecione um registro na lista.", "Alterar")
851:                 ELSE
852:                     loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigo)
853:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
854:                         THIS.this_oBusinessObject.EditarRegistro()
855:                         THIS.this_cModoAtual    = "ALTERAR"
856:                         THIS.this_cPkChaveAtual = loc_cCodigo
857:                         THIS.BOParaForm()
858:                         THIS.HabilitarCampos(.T.)
859:                         THIS.AjustarBotoesPorModo()
860:                         THIS.AlternarPagina(2)
861:                         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Valmin", 5)
862:                             THIS.pgf_4c_Paginas.Page2.txt_4c_Valmin.SetFocus
863:                         ENDIF

*-- Linhas 882 a 900:
882:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
883:                 MsgAviso("Selecione um registro na lista.", "Excluir")
884:             ELSE
885:                 SELECT cursor_4c_Dados
886:                 IF EOF("cursor_4c_Dados")
887:                     MsgAviso("Selecione um registro na lista.", "Excluir")
888:                 ELSE
889:                     loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigo)
890:                     IF MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", ;
891:                                    "Confirmar Exclus" + CHR(227) + "o")
892:                         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
893:                             IF THIS.this_oBusinessObject.Excluir()
894:                                 MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", ;
895:                                         "Exclu" + CHR(237) + "do")
896:                                 THIS.CarregarLista()
897:                             ELSE
898:                                 MsgErro("Erro ao excluir registro!", "Excluir")
899:                             ENDIF
900:                         ELSE

*-- Linhas 919 a 950:
919: 
920:         TRY
921:             IF !EMPTY(ALLTRIM(loc_cTermoBusca))
922:                 loc_cFiltro = "cpros LIKE " + EscaparSQL(ALLTRIM(loc_cTermoBusca) + "%")
923:                 IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
924:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
925:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
926:                         loc_oGrid.ColumnCount = 8
927:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
928:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigo"
929:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.cpros"
930:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.tppro"
931:                         loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.valmin"
932:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.dtini"
933:                         loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.dtfin"
934:                         loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.usualts"
935:                         loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.dtalts"
936:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
937:                         loc_oGrid.Column2.Header1.Caption = "Produto"
938:                         loc_oGrid.Column3.Header1.Caption = "Tipo"
939:                         loc_oGrid.Column4.Header1.Caption = "Valor M" + CHR(237) + "nimo"
940:                         loc_oGrid.Column5.Header1.Caption = "Dt In" + CHR(237) + "cio"
941:                         loc_oGrid.Column6.Header1.Caption = "Dt final"
942:                         loc_oGrid.Column7.Header1.Caption = "Usu" + CHR(225) + "rio"
943:                         loc_oGrid.Column8.Header1.Caption = "Altera" + CHR(231) + CHR(227) + "o"
944:                         THIS.FormatarGridLista(loc_oGrid)
945:                     ENDIF
946:                 ENDIF
947:             ELSE
948:                 THIS.CarregarLista()
949:             ENDIF
950:         CATCH TO loc_oErro

*-- Linhas 1299 a 1326:
1299:         ENDIF
1300: 
1301:         TRY
1302:             loc_cSQL = "SELECT CPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCpros)
1303: 
1304:             IF USED("cursor_4c_ValPro")
1305:                 USE IN cursor_4c_ValPro
1306:             ENDIF
1307: 
1308:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValPro")
1309: 
1310:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ValPro") > 0
1311:                 SELECT cursor_4c_ValPro
1312:                 loc_oPg2.txt_4c_Cpros.Value = ALLTRIM(cursor_4c_ValPro.CPros)
1313:             ELSE
1314:                 THIS.AbrirBuscaProduto()
1315:             ENDIF
1316: 
1317:             IF USED("cursor_4c_ValPro")
1318:                 USE IN cursor_4c_ValPro
1319:             ENDIF
1320:         CATCH TO loc_oErro
1321:             MsgErro("Erro em ValidarProduto:" + CHR(13) + loc_oErro.Message, "Erro")
1322:             IF USED("cursor_4c_ValPro")
1323:                 USE IN cursor_4c_ValPro
1324:             ENDIF
1325:         ENDTRY
1326:     ENDPROC


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

