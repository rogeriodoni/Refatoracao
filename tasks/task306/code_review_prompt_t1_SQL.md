# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCRS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODS

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
  ControlSource = "crSigOpIns.descrs"
  ControlSource = "crSigOpIns.cods"
  ControlSource = "crSigOpIns.Tipos"
  ControlSource = "crSigOpIns.mensas"
SELECT csSigOpIns
	SELECT crSigOpIns
		SELECT csSigOpIns
		SELECT crSigOpIns
		.Column1.ControlSource = "csSigOpIns.Cods"
		.Column2.ControlSource = "csSigOpIns.Descrs"
		.Column3.ControlSource = "csSigOpIns.Tipo"
SELECT crSigOpIns
	SELECT csSigOpIns
		SELECT crSigOpIns
			m.lnErro1 = Iif(.poDataMgr.UpDate('crSigOpIns'),1,-1)
	SELECT csSigOpIns
	DELETE

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormSIGPRINT.prg) - TRECHOS RELEVANTES PARA PASS SQL (1108 linhas total):

*-- Linhas 320 a 338:
320:             .HighlightBackColor = RGB(255, 255, 255)
321:             .HighlightForeColor = RGB(15, 41, 104)
322:             .HighlightStyle     = 2
323:             .DeleteMark         = .F.
324:             .RecordMark         = .F.
325:             .RowHeight          = 16
326:             .ScrollBars         = 2
327:             .ReadOnly           = .T.
328:             .Visible            = .T.
329:             .Column1.Width      = 100
330:             .Column2.Width      = 680
331:             .Column3.Width      = 60
332:         ENDWITH
333: 
334:         *-- BINDEVENTs dos botoes CRUD
335:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
336:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
337:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
338:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")

*-- Linhas 618 a 638:
618:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
619: 
620:                     WITH loc_oGrid
621:                         .Column1.ControlSource    = "cursor_4c_Dados.cods"
622:                         .Column2.ControlSource    = "cursor_4c_Dados.descrs"
623:                         .Column3.ControlSource    = "cursor_4c_Dados.tipos"
624:                         .Column1.Width            = 100
625:                         .Column2.Width            = 680
626:                         .Column3.Width            = 60
627:                         .Column1.Header1.Caption  = "C" + CHR(243) + "digo"
628:                         .Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
629:                         .Column3.Header1.Caption  = "Tipo"
630:                         .Column1.Alignment        = 0
631:                         .Column2.Alignment        = 0
632:                         .Column3.Alignment        = 2
633:                     ENDWITH
634: 
635:                     THIS.FormatarGridLista(loc_oGrid)
636:                     loc_lResultado = .T.
637:                 ENDIF
638:             ELSE

*-- Linhas 821 a 839:
821:         loc_lPode   = .F.
822: 
823:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
824:             SELECT cursor_4c_Dados
825:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
826:             loc_lPode   = !EMPTY(loc_cCodigo)
827:         ENDIF
828: 
829:         IF !loc_lPode
830:             MsgAviso("Nenhum registro selecionado.", "Visualizar")
831:             RETURN
832:         ENDIF
833: 
834:         TRY
835:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
836:                 THIS.this_cModoAtual = "VISUALIZAR"
837:                 THIS.BOParaForm()
838:                 THIS.HabilitarCampos(.F.)
839:                 THIS.AjustarBotoesPorModo()

*-- Linhas 853 a 871:
853:         loc_lPode   = .F.
854: 
855:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
856:             SELECT cursor_4c_Dados
857:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
858:             loc_lPode   = !EMPTY(loc_cCodigo)
859:         ENDIF
860: 
861:         IF !loc_lPode
862:             MsgAviso("Nenhum registro selecionado.", "Alterar")
863:             RETURN
864:         ENDIF
865: 
866:         TRY
867:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
868:                 THIS.this_oBusinessObject.EditarRegistro()
869:                 THIS.this_cModoAtual = "ALTERAR"
870:                 THIS.BOParaForm()
871:                 THIS.HabilitarCampos(.T.)

*-- Linhas 887 a 905:
887:         loc_lConfirmou = .F.
888: 
889:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
890:             SELECT cursor_4c_Dados
891:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
892:             loc_lPode   = !EMPTY(loc_cCodigo)
893:         ENDIF
894: 
895:         IF !loc_lPode
896:             MsgAviso("Nenhum registro selecionado.", "Excluir")
897:             RETURN
898:         ENDIF
899: 
900:         loc_lConfirmou = MsgConfirma("Confirma a exclus" + CHR(227) + "o da instru" + ;
901:             CHR(231) + CHR(227) + "o '" + loc_cCodigo + "'?", "Excluir")
902: 
903:         IF loc_lConfirmou
904:             TRY
905:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)

*-- Linhas 941 a 959:
941:                 loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
942:                 loc_oBusca.Show()
943:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Dados")
944:                     SELECT cursor_4c_Dados
945:                     loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
946:                 ENDIF
947:                 loc_oBusca.Release()
948:             ENDIF
949:         CATCH TO loException
950:             MsgErro(loException.Message, "FormSIGPRINT.BtnBuscarClick")
951:         ENDTRY
952: 
953:         IF !EMPTY(loc_cCodigo)
954:             TRY
955:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
956:                     THIS.this_cModoAtual = "VISUALIZAR"
957:                     THIS.BOParaForm()
958:                     THIS.HabilitarCampos(.F.)
959:                     THIS.AjustarBotoesPorModo()

*-- Linhas 1024 a 1051:
1024:             RETURN
1025:         ENDIF
1026: 
1027:         *-- Verificar codigo duplicado no INSERT (logica de getCods.Valid do legado)
1028:         IF THIS.this_cModoAtual = "INCLUIR"
1029:             LOCAL loc_lExiste, loc_cSQLChk, loc_nResultChk
1030:             loc_lExiste    = .F.
1031:             loc_cSQLChk    = "SELECT COUNT(*) AS qtd FROM SigOpIns WHERE Cods = " + EscaparSQL(loc_cCodigo)
1032:             loc_nResultChk = 0
1033:             TRY
1034:                 loc_nResultChk = SQLEXEC(gnConnHandle, loc_cSQLChk, "cursor_4c_ChkCod")
1035:                 IF loc_nResultChk > 0 AND USED("cursor_4c_ChkCod")
1036:                     SELECT cursor_4c_ChkCod
1037:                     loc_lExiste = (cursor_4c_ChkCod.qtd > 0)
1038:                     USE IN cursor_4c_ChkCod
1039:                 ENDIF
1040:             CATCH TO loExcChk
1041:                 MsgErro(loExcChk.Message, "FormSIGPRINT.BtnSalvarClick.ChkCod")
1042:             ENDTRY
1043:             IF loc_lExiste
1044:                 MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!", "Validar")
1045:                 IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
1046:                     loc_oPg2.txt_4c_Codigo.Value = ""
1047:                     loc_oPg2.txt_4c_Codigo.SetFocus()
1048:                 ENDIF
1049:                 RETURN
1050:             ENDIF
1051:         ENDIF


### BO (C:\4c\projeto\app\classes\SIGPRINTBO.prg):
*==============================================================================
* SIGPRINTBO.prg - Business Object para Cadastro de Instru????es de Impress??o
* Tabela: SigOpIns
* Gerado em: 2026-07-17
*==============================================================================

DEFINE CLASS SIGPRINTBO AS BusinessBase

    *-- Propriedades da entidade (mapeiam colunas de SigOpIns)
    this_cCodigo    = ""   && cods    char(10) NOT NULL - PK
    this_cDescricao = ""   && descrs  char(76) NOT NULL
    this_cMensagem  = ""   && mensas  text NULL
    this_nTipo      = 0    && tipos   numeric(1,0) NOT NULL - 1=Cheque, 2=Titulos, 3=FollowUp
    this_cCidChaves = ""   && cidchaves char(20) NOT NULL

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigOpIns"
            THIS.this_cCampoChave = "cods"
            loc_lResultado = .T.
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Retorna todos os registros de SigOpIns
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT cods, descrs, mensas, tipos, cidchaves" + ;
                       " FROM SigOpIns ORDER BY cods"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = "SELECT cods, descrs, mensas, tipos, cidchaves" + ;
                           " FROM SigOpIns" + ;
                           " WHERE cods LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                           " OR descrs LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                           " ORDER BY cods"
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult > 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar instru" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo codigo (cods)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT cods, descrs, mensas, tipos, cidchaves" + ;
                       " FROM SigOpIns" + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(par_cCodigo))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo    = TratarNulo(cods,      "C")
            THIS.this_cDescricao = TratarNulo(descrs,    "C")
            THIS.this_cMensagem  = TratarNulo(mensas,    "C")
            THIS.this_nTipo      = TratarNulo(tipos,     "N")
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigOpIns
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            THIS.this_cCidChaves = LEFT(SYS(2015) + SYS(2015), 20)

            loc_cSQL = "INSERT INTO SigOpIns (cods, descrs, mensas, tipos, cidchaves)" + ;
                       " VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCodigo)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cDescricao), 76)) + ", " + ;
                       EscaparSQL(THIS.this_cMensagem) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTipo) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCidChaves)) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir instru" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigOpIns (PK = cidchaves)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigOpIns SET" + ;
                       " cods = "   + EscaparSQL(ALLTRIM(THIS.this_cCodigo))  + ", " + ;
                       " descrs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cDescricao), 76)) + ", " + ;
                       " mensas = " + EscaparSQL(THIS.this_cMensagem) + ", " + ;
                       " tipos = "  + FormatarNumeroSQL(THIS.this_nTipo) + ;
                       " WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar instru" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigOpIns (PK = cidchaves)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigOpIns" + ;
                       " WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir instru" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCodigo - Verifica se codigo ja existe (para validar unicidade)
    *--------------------------------------------------------------------------
    FUNCTION ValidarCodigo(par_cCodigo)
        LOCAL loc_lExiste, loc_cSQL, loc_nResult
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigOpIns" + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(par_cCodigo))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ValCod")
                TABLEREVERT(.T., "cursor_4c_ValCod")
                USE IN cursor_4c_ValCod
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValCod")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ValCod") > 0
                SELECT cursor_4c_ValCod
                loc_lExiste = (qtd > 0)
            ENDIF

            IF USED("cursor_4c_ValCod")
                USE IN cursor_4c_ValCod
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY

        RETURN loc_lExiste
    ENDFUNC

ENDDEFINE

