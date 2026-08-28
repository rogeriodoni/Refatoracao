# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: TIPOS

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
  ControlSource = "crSigBaOco.apuras"
  ControlSource = "crSigBaOco.codigos"
  ControlSource = "crSigBaOco.descrs"
  ControlSource = "crSigBaOco.tipos"
  ControlSource = "crSigBaOco.lancas"
  ControlSource = "crSigBaOco.opers"
  ControlSource = "crSigBaOco.autos"
  ControlSource = "crSigBaOco.operacaos"
  ControlSource = "crSigBaOco.grupos"
			SELECT crSigBaOco
			SELECT crSigBaOco
Select crSigBaOco
Select crSigBaOco

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormOcb.prg) - TRECHOS RELEVANTES PARA PASS SQL (1523 linhas total):

*-- Linhas 346 a 364:
346:             .HighlightBackColor = RGB(255, 255, 255)
347:             .HighlightForeColor = RGB(15, 41, 104)
348:             .HighlightStyle     = 2
349:             .DeleteMark         = .F.
350:             .RecordMark         = .F.
351:             .RowHeight          = 16
352:             .ScrollBars         = 2
353:             .GridLines          = 3
354:             .Visible            = .T.
355: 
356:             .Column1.Width  = 35
357:             .Column2.Width  = 80
358:             .Column3.Width  = 285
359:             .Column4.Width  = 65
360:             .Column5.Width  = 65
361:             .Column6.Width  = 65
362:             .Column7.Width  = 65
363:             .Column8.Width  = 45
364:             .Column9.Width  = 90

*-- Linhas 849 a 875:
849:                     loc_oGrid.ColumnCount = 9
850:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
851: 
852:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.tipos"
853:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.codigos"
854:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.descrs"
855:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.apuras"
856:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.lancas"
857:                     loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.opers"
858:                     loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.autos"
859:                     loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.operacaos"
860:                     loc_oGrid.Column9.ControlSource = "cursor_4c_Dados.grupos"
861: 
862:                     loc_oGrid.Column1.Header1.Caption = "Tipo"
863:                     loc_oGrid.Column2.Header1.Caption = "C" + CHR(243) + "digo"
864:                     loc_oGrid.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
865:                     loc_oGrid.Column4.Header1.Caption = "Apura" + CHR(231) + CHR(227) + "o"
866:                     loc_oGrid.Column5.Header1.Caption = "Lan" + CHR(231) + "a C/C"
867:                     loc_oGrid.Column6.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
868:                     loc_oGrid.Column7.Header1.Caption = "Autom" + CHR(225) + "tico"
869:                     loc_oGrid.Column8.Header1.Caption = "Op."
870:                     loc_oGrid.Column9.Header1.Caption = "Gr.Cont" + CHR(225) + "bil"
871: 
872:                     THIS.FormatarGridLista(loc_oGrid)
873:                     loc_lSucesso = .T.
874:                 ENDIF
875:             ENDIF

*-- Linhas 962 a 980:
962:                 loc_oBusca.Show()
963: 
964:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca") AND USED("cursor_4c_Dados")
965:                     SELECT cursor_4c_Dados
966:                     LOCATE FOR ALLTRIM(codigos) = ALLTRIM(cursor_4c_Busca.codigos)
967:                     IF FOUND()
968:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.SetFocus
969:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh
970:                     ENDIF
971:                 ENDIF
972: 
973:                 loc_oBusca.Release()
974:             ENDIF
975:         CATCH TO loException
976:             MsgErro("Erro ao buscar:" + CHR(13) + loException.Message + CHR(13) + ;
977:                 "Linha: " + TRANSFORM(loException.LineNo), "FormOcb.BtnBuscarClick")
978:         ENDTRY
979: 
980:         IF USED("cursor_4c_Busca")

*-- Linhas 1009 a 1027:
1009:             RETURN
1010:         ENDIF
1011: 
1012:         SELECT cursor_4c_Dados
1013:         loc_cCodigo = ALLTRIM(codigos)
1014: 
1015:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1016:             THIS.this_cModoAtual = "VISUALIZAR"
1017:             THIS.BOParaForm()
1018:             THIS.HabilitarCampos(.F.)
1019:             THIS.AlternarPagina(2)
1020:             THIS.pgf_4c_Paginas.Page2.txt_4c_Tipos.SetFocus()
1021:         ENDIF
1022:     ENDPROC
1023: 
1024:     *===========================================================================
1025:     * BtnAlterarClick - Carrega registro selecionado para edicao
1026:     *===========================================================================
1027:     PROCEDURE BtnAlterarClick()

*-- Linhas 1033 a 1051:
1033:             RETURN
1034:         ENDIF
1035: 
1036:         SELECT cursor_4c_Dados
1037:         loc_cCodigo = ALLTRIM(codigos)
1038: 
1039:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1040:             THIS.this_oBusinessObject.EditarRegistro()
1041:             THIS.this_cModoAtual = "ALTERAR"
1042:             THIS.BOParaForm()
1043:             THIS.HabilitarCampos(.T.)
1044:             THIS.AlternarPagina(2)
1045:             THIS.pgf_4c_Paginas.Page2.txt_4c_Descrs.SetFocus()
1046:         ENDIF
1047:     ENDPROC
1048: 
1049:     *===========================================================================
1050:     * BtnExcluirClick - Confirma e executa exclusao do registro selecionado
1051:     *===========================================================================

*-- Linhas 1058 a 1076:
1058:             RETURN
1059:         ENDIF
1060: 
1061:         SELECT cursor_4c_Dados
1062:         loc_cCodigo = ALLTRIM(codigos)
1063: 
1064:         IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro '" + ;
1065:                 loc_cCodigo + "'?", "Confirmar Exclus" + CHR(227) + "o")
1066:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1067:                 IF THIS.this_oBusinessObject.Excluir()
1068:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "")
1069:                     THIS.CarregarLista()
1070:                 ENDIF
1071:             ENDIF
1072:         ENDIF
1073:     ENDPROC
1074: 
1075:     *===========================================================================
1076:     * BtnSalvarClick - Valida, transfere form->BO e salva

*-- Linhas 1410 a 1429:
1410:             RETURN .T.
1411:         ENDIF
1412: 
1413:         loc_nResult = SQLEXEC(gnConnHandle, ;
1414:             "SELECT Codigos FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cValor), ;
1415:             "cursor_4c_ValGcr")
1416: 
1417:         IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ValGcr") > 0
1418:             IF USED("cursor_4c_ValGcr")
1419:                 USE IN cursor_4c_ValGcr
1420:             ENDIF
1421:             RETURN .T.
1422:         ENDIF
1423: 
1424:         IF USED("cursor_4c_ValGcr")
1425:             USE IN cursor_4c_ValGcr
1426:         ENDIF
1427: 
1428:         THIS.AbrirLookupGrContabil()
1429:         RETURN .T.


### BO (C:\4c\projeto\app\classes\OcbBO.prg):
*==============================================================================
* OcbBO.prg - Business Object para Ocorrencias do Balanco
* Tabela: SigBaOco
*==============================================================================

DEFINE CLASS OcbBO AS BusinessBase

    *-- Propriedades da entidade (mapeadas de SigBaOco)
    this_cCodigos   = ""    && codigos   char(10) - PK
    this_cDescrs    = ""    && descrs    char(40)
    this_cTipos     = ""    && tipos     char(1) - "O" ou "J"
    this_cApuras    = ""    && apuras    char(1) - "S" ou "N"
    this_cLancas    = ""    && lancas    char(1) - "S" ou "N"
    this_cOpers     = ""    && opers     char(2) - "DB","CR","DF","NL"
    this_cAutos     = ""    && autos     char(1) - "S" ou "N"
    this_cOperacaos = ""    && operacaos char(1) - "E" ou "S"
    this_cGrupos    = ""    && grupos    char(10) - FK SigCdGcr

    *==========================================================================
    * Init - Inicializa o Business Object
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigBaOco"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigos)
    ENDFUNC

    *==========================================================================
    * Buscar - SELECT com filtro opcional (cursor_4c_Dados)
    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descrs, tipos, apuras, lancas," + ;
                       " opers, autos, operacaos, grupos" + ;
                       " FROM SigBaOco"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY codigos"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar ocorr" + CHR(234) + "ncias:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pelo PK
    *==========================================================================
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descrs, tipos, apuras, lancas," + ;
                       " opers, autos, operacaos, grupos" + ;
                       " FROM SigBaOco" + ;
                       " WHERE codigos = " + EscaparSQL(par_cCodigo)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo), "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades this_
    *==========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos    = TratarNulo(codigos,    "C")
            THIS.this_cDescrs     = TratarNulo(descrs,     "C")
            THIS.this_cTipos      = TratarNulo(tipos,      "C")
            THIS.this_cApuras     = TratarNulo(apuras,     "C")
            THIS.this_cLancas     = TratarNulo(lancas,     "C")
            THIS.this_cOpers      = TratarNulo(opers,      "C")
            THIS.this_cAutos      = TratarNulo(autos,      "C")
            THIS.this_cOperacaos  = TratarNulo(operacaos,  "C")
            THIS.this_cGrupos     = TratarNulo(grupos,     "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Inserir - INSERT INTO SigBaOco (PROTECTED - chamado por Salvar)
    *==========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigBaOco" + ;
                       " (codigos, descrs, tipos, apuras, lancas," + ;
                       "  opers, autos, operacaos, grupos)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigos)   + ", " + ;
                       EscaparSQL(THIS.this_cDescrs)    + ", " + ;
                       EscaparSQL(THIS.this_cTipos)     + ", " + ;
                       EscaparSQL(THIS.this_cApuras)    + ", " + ;
                       EscaparSQL(THIS.this_cLancas)    + ", " + ;
                       EscaparSQL(THIS.this_cOpers)     + ", " + ;
                       EscaparSQL(THIS.this_cAutos)     + ", " + ;
                       EscaparSQL(THIS.this_cOperacaos) + ", " + ;
                       EscaparSQL(THIS.this_cGrupos)    + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir ocorr" + CHR(234) + "ncia:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Atualizar - UPDATE SigBaOco (PROTECTED - chamado por Salvar)
    *==========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigBaOco SET" + ;
                       " descrs    = " + EscaparSQL(THIS.this_cDescrs)    + ", " + ;
                       " tipos     = " + EscaparSQL(THIS.this_cTipos)     + ", " + ;
                       " apuras    = " + EscaparSQL(THIS.this_cApuras)    + ", " + ;
                       " lancas    = " + EscaparSQL(THIS.this_cLancas)    + ", " + ;
                       " opers     = " + EscaparSQL(THIS.this_cOpers)     + ", " + ;
                       " autos     = " + EscaparSQL(THIS.this_cAutos)     + ", " + ;
                       " operacaos = " + EscaparSQL(THIS.this_cOperacaos) + ", " + ;
                       " grupos    = " + EscaparSQL(THIS.this_cGrupos)    + ;
                       " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar ocorr" + CHR(234) + "ncia:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExecutarExclusao - DELETE FROM SigBaOco (PROTECTED - chamado por Excluir)
    *==========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigBaOco" + ;
                       " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir ocorr" + CHR(234) + "ncia:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

