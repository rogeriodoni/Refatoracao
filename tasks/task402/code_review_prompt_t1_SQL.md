# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TOTAL' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODS

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
  ControlSource = "crSigCdEmb.cods"
  ControlSource = "crSigCdEmb.pesos"
  ControlSource = "crSigCdEmb.descs"
  ControlSource = "crSigCdEmb.multis"
  ControlSource = "crSigCdEmb.precos"

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormEmb.prg) - TRECHOS RELEVANTES PARA PASS SQL (1087 linhas total):

*-- Linhas 362 a 380:
362:             .Left               = 26
363:             .Width              = 880
364:             .Height             = 498
365:             .DeleteMark         = .F.
366:             .RecordMark         = .F.
367:             .GridLines          = 3
368:             .GridLineColor      = RGB(238, 238, 238)
369:             .HighlightStyle     = 2
370:             .HighlightBackColor = RGB(255, 255, 255)
371:             .HighlightForeColor = RGB(15, 41, 104)
372:             .RowHeight          = 16
373:             .ScrollBars         = 2
374:             .ReadOnly           = .T.
375:             .FontName           = "Verdana"
376:             .FontSize           = 8
377:             .ForeColor          = RGB(90, 90, 90)
378:             .Visible            = .T.
379:         ENDWITH
380: 

*-- Linhas 687 a 716:
687:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
688:                 loc_oGrid.ColumnCount  = 3
689: 
690:                 *-- ControlSource APOS RecordSource (Problema 48)
691:                 *-- Header1.Caption RECONFIGURADO apos RecordSource (Problema 6/32)
692:                 WITH loc_oGrid
693:                     .Column1.ControlSource   = "cursor_4c_Dados.cods"
694:                     .Column1.Width           = 75
695:                     .Column1.Header1.Caption = "C" + CHR(243) + "digo"
696: 
697:                     .Column2.ControlSource   = "cursor_4c_Dados.descs"
698:                     .Column2.Width           = 297
699:                     .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
700: 
701:                     .Column3.ControlSource   = "cursor_4c_Dados.pesos"
702:                     .Column3.Width           = 107
703:                     .Column3.Header1.Caption = "Peso"
704:                 ENDWITH
705: 
706:                 THIS.FormatarGridLista(loc_oGrid)
707:                 loc_lResultado = .T.
708:             ENDIF
709:         CATCH TO loc_oErro
710:             MsgErro(loc_oErro.Message, "FormEmb.CarregarLista")
711:             loc_lResultado = .F.
712:         ENDTRY
713: 
714:         RETURN loc_lResultado
715:     ENDPROC
716: 

*-- Linhas 885 a 903:
885:             RETURN
886:         ENDIF
887: 
888:         SELECT cursor_4c_Dados
889:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
890: 
891:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
892:             THIS.this_oBusinessObject.EditarRegistro()
893:             THIS.BOParaForm()
894:             THIS.this_cModoAtual = "ALTERAR"
895:             THIS.HabilitarCampos(.T.)
896:             THIS.AjustarBotoesPorModo()
897:             THIS.AlternarPagina(2)
898:             THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.SetFocus()
899:         ELSE
900:             MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar o registro!", "Alterar")
901:         ENDIF
902:     ENDPROC
903: 

*-- Linhas 914 a 932:
914:             RETURN
915:         ENDIF
916: 
917:         SELECT cursor_4c_Dados
918:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
919: 
920:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
921:             THIS.BOParaForm()
922:             THIS.this_cModoAtual = "VISUALIZAR"
923:             THIS.HabilitarCampos(.F.)
924:             THIS.AjustarBotoesPorModo()
925:             THIS.AlternarPagina(2)
926:             THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus()
927:         ELSE
928:             MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar o registro!", "Visualizar")
929:         ENDIF
930:     ENDPROC
931: 
932:     *--------------------------------------------------------------------------

*-- Linhas 942 a 960:
942:             RETURN
943:         ENDIF
944: 
945:         SELECT cursor_4c_Dados
946:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
947: 
948:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da embalagem '" + ;
949:                 loc_cCodigo + "'?", "Excluir")
950:             RETURN
951:         ENDIF
952: 
953:         TRY
954:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
955:                 IF THIS.this_oBusinessObject.Excluir()
956:                     MsgInfo("Embalagem exclu" + CHR(237) + "da com sucesso!", "Excluir")
957:                     THIS.CarregarLista()
958:                     loc_lResultado = .T.
959:                 ELSE
960:                     MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir a embalagem!", "Excluir")

*-- Linhas 989 a 1011:
989:             ENDIF
990: 
991:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
992:                 SELECT cursor_4c_Busca
993:                 loc_cCodigo = ALLTRIM(cursor_4c_Busca.cods)
994: 
995:                 IF USED("cursor_4c_Dados") AND !EMPTY(loc_cCodigo)
996:                     SELECT cursor_4c_Dados
997:                     LOCATE FOR ALLTRIM(cods) == loc_cCodigo
998:                 ENDIF
999:             ENDIF
1000: 
1001:             loc_oBusca.Release()
1002:         ENDIF
1003: 
1004:         IF USED("cursor_4c_Busca")
1005:             USE IN cursor_4c_Busca
1006:         ENDIF
1007:     ENDPROC
1008: 
1009:     *--------------------------------------------------------------------------
1010:     * BtnSalvarClick - Valida e salva o registro (Confirmar)
1011:     * Legado: valida Codigo vazio + duplicata em INCLUIR, depois salva e volta

*-- Linhas 1033 a 1053:
1033: 
1034:         *-- Validacao 3: Codigo ja cadastrado em INCLUIR (legado: ChkRegister)
1035:         IF THIS.this_cModoAtual == "INCLUIR"
1036:             loc_nChk = SQLEXEC(gnConnHandle, ;
1037:                 "SELECT COUNT(*) AS Total FROM SigCdEmb WHERE cods = " + ;
1038:                 EscaparSQL(loc_cCodigo), "cursor_4c_ChkEmb")
1039:             IF loc_nChk > 0 AND USED("cursor_4c_ChkEmb") AND cursor_4c_ChkEmb.Total > 0
1040:                 MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " Cadastrado!", "Validar")
1041:                 loc_oPg2.txt_4c_Codigo.SetFocus()
1042:                 IF USED("cursor_4c_ChkEmb")
1043:                     USE IN cursor_4c_ChkEmb
1044:                 ENDIF
1045:                 RETURN
1046:             ENDIF
1047:             IF USED("cursor_4c_ChkEmb")
1048:                 USE IN cursor_4c_ChkEmb
1049:             ENDIF
1050:         ENDIF
1051: 
1052:         THIS.FormParaBO()
1053: 


### BO (C:\4c\projeto\app\classes\EmbBO.prg):
*==============================================================================
* EmbBO.prg - Business Object para Embalagens
* Tabela: SigCdEmb
* Herda de: BusinessBase
*
* Campos (schema.sql):
*   cods   char(3)        NOT NULL  - PK
*   descs  char(20)       NOT NULL
*   multis numeric(5,1)  NOT NULL
*   precos numeric(11,2) NOT NULL
*   pesos  numeric(11,2) NOT NULL
*==============================================================================

DEFINE CLASS EmbBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento 1:1 com colunas SigCdEmb)
    this_cCodigo    = ""  && cods char(3) - PK
    this_cDescricao = ""  && descs char(20)
    this_nMultis    = 0   && multis numeric(5,1)
    this_nPrecos    = 0   && precos numeric(11,2)
    this_nPesos     = 0   && pesos numeric(11,2)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdEmb"
        THIS.this_cCampoChave = "cods"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Retorna lista de embalagens (PUBLIC)
    * par_cFiltro: filtro opcional aplicado ao WHERE
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cods, descs, multis, precos, pesos" + ;
                       " FROM SigCdEmb"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY cods"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar embalagens:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em EmbBO.Buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega embalagem pelo codigo (PUBLIC)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cods, descs, multis, precos, pesos" + ;
                       " FROM SigCdEmb" + ;
                       " WHERE cods = " + EscaparSQL(par_cCodigo)

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
            MsgErro("Erro em EmbBO.CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor para propriedades do BO (PUBLIC)
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo    = TratarNulo(cods,   "C")
            THIS.this_cDescricao = TratarNulo(descs,  "C")
            THIS.this_nMultis    = TratarNulo(multis, "N")
            THIS.this_nPrecos    = TratarNulo(precos, "N")
            THIS.this_nPesos     = TratarNulo(pesos,  "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria (PUBLIC)
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdEmb (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdEmb (cods, descs, multis, precos, pesos)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigo) + ", " + ;
                       EscaparSQL(THIS.this_cDescricao) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nMultis) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPrecos) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPesos) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir embalagem:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em EmbBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCdEmb (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdEmb SET" + ;
                       " descs = "  + EscaparSQL(THIS.this_cDescricao) + ", " + ;
                       " multis = " + FormatarNumeroSQL(THIS.this_nMultis) + ", " + ;
                       " precos = " + FormatarNumeroSQL(THIS.this_nPrecos) + ", " + ;
                       " pesos = "  + FormatarNumeroSQL(THIS.this_nPesos) + ;
                       " WHERE cods = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar embalagem:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em EmbBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigCdEmb (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdEmb WHERE cods = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir embalagem:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em EmbBO.ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

