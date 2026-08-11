# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TRADUCAO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EXPRESSAO, IDIOMA
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EXPRESSAO, IDIOMA

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
  ControlSource = "crSigCdDic.Idioma"
  ControlSource = "crSigCdDic.Expressao"
  ControlSource = "crSigCdDic.Traducao"
	lcQuery = [Select * From SigCdDic Where Expressao = '] + ThisForm.Pagina.Dados.GetExpressao.Value + [' ] + ;
    ThisForm.poDataMgr.SqlExecute(lcQuery, 'csSigCdDic')
	Select crSigCdDic

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormDIC.prg) - TRECHOS RELEVANTES PARA PASS SQL (898 linhas total):

*-- Linhas 315 a 333:
315:             .HighlightBackColor = RGB(255, 255, 255)
316:             .HighlightForeColor = RGB(15, 41, 104)
317:             .HighlightStyle     = 2
318:             .DeleteMark         = .F.
319:             .RecordMark         = .F.
320:             .RowHeight          = 16
321:             .ScrollBars         = 2
322:             .GridLines          = 3
323:             .Visible            = .T.
324:         ENDWITH
325: 
326:         *-- BINDEVENT: vincular botoes
327:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
328:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
329:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
330:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
331:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
332:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
333: 

*-- Linhas 529 a 549:
529:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
530:                     loc_oGrid.ColumnCount  = 3
531: 
532:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Idioma"
533:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Expressao"
534:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Traducao"
535: 
536:                     loc_oGrid.Column1.Width = 70
537:                     loc_oGrid.Column2.Width = 280
538:                     loc_oGrid.Column3.Width = 280
539: 
540:                     loc_oGrid.Column1.Header1.Caption = "Idioma"
541:                     loc_oGrid.Column2.Header1.Caption = "Express" + CHR(227) + "o"
542:                     loc_oGrid.Column3.Header1.Caption = "Tradu" + CHR(231) + CHR(227) + "o"
543: 
544:                     loc_oGrid.Refresh()
545:                     THIS.FormatarGridLista(loc_oGrid)
546:                     loc_lResultado = .T.
547:                 ENDIF
548:             ENDIF
549:         CATCH TO loc_oErro

*-- Linhas 699 a 717:
699:             THIS.this_cModoAtual = "LISTA"
700:             THIS.AlternarPagina(1)
701:             IF !EMPTY(loc_cExpressao) AND USED("cursor_4c_Dados")
702:                 SELECT cursor_4c_Dados
703:                 LOCATE FOR ALLTRIM(cursor_4c_Dados.Expressao) = loc_cExpressao
704:                 IF !EOF("cursor_4c_Dados")
705:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
706:                 ENDIF
707:             ENDIF
708:             RETURN
709:         ENDIF
710: 
711:         *-- Obter valores para validacao
712:         IF PEMSTATUS(loc_oPagina, "txt_4c_Expressao", 5)
713:             loc_cExpressao = ALLTRIM(loc_oPagina.txt_4c_Expressao.Value)
714:         ENDIF
715:         IF PEMSTATUS(loc_oPagina, "txt_4c_Idioma", 5)
716:             loc_cIdioma = ALLTRIM(loc_oPagina.txt_4c_Idioma.Value)
717:         ENDIF

*-- Linhas 744 a 764:
744: 
745:         *-- Em modo INCLUIR: verificar duplicidade por Expressao + Idioma
746:         IF THIS.this_cModoAtual = "INCLUIR"
747:             loc_cSQL = "SELECT 1 AS chk FROM SigCdDic WHERE Expressao = " + EscaparSQL(loc_cExpressao) + ;
748:                        " AND Idioma = " + EscaparSQL(loc_cIdioma)
749:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupCheck")
750:             IF USED("cursor_4c_DupCheck")
751:                 IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_DupCheck") > 0
752:                     USE IN cursor_4c_DupCheck
753:                     MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " Cadastrado !!", "Salvar")
754:                     IF PEMSTATUS(loc_oPagina, "txt_4c_Expressao", 5)
755:                         loc_oPagina.txt_4c_Expressao.SetFocus()
756:                     ENDIF
757:                     RETURN
758:                 ENDIF
759:                 USE IN cursor_4c_DupCheck
760:             ENDIF
761:         ENDIF
762: 
763:         *-- Transferir Form -> BO e salvar
764:         THIS.FormParaBO()

*-- Linhas 794 a 833:
794:             RETURN
795:         ENDIF
796: 
797:         SELECT cursor_4c_Dados
798:         loc_cIdChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
799: 
800:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
801:             THIS.BOParaForm()
802:             THIS.this_cModoAtual = "VISUALIZAR"
803:             THIS.HabilitarCampos(.F.)
804:             THIS.AjustarBotoesPorModo()
805:             THIS.AlternarPagina(2)
806:         ENDIF
807:     ENDPROC
808: 
809:     *--------------------------------------------------------------------------
810:     PROCEDURE BtnAlterarClick()
811:         LOCAL loc_cIdChaves
812: 
813:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
814:             MsgAviso("Selecione um registro na lista!", "Alterar")
815:             RETURN
816:         ENDIF
817: 
818:         SELECT cursor_4c_Dados
819:         loc_cIdChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
820: 
821:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
822:             THIS.this_oBusinessObject.EditarRegistro()
823:             THIS.BOParaForm()
824:             THIS.this_cModoAtual = "ALTERAR"
825:             THIS.HabilitarCampos(.T.)
826:             THIS.AjustarBotoesPorModo()
827:             THIS.AlternarPagina(2)
828:         ENDIF
829:     ENDPROC
830: 
831:     *--------------------------------------------------------------------------
832:     PROCEDURE BtnExcluirClick()
833:         LOCAL loc_cIdChaves

*-- Linhas 841 a 859:
841:             RETURN
842:         ENDIF
843: 
844:         SELECT cursor_4c_Dados
845:         loc_cIdChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
846: 
847:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
848:             IF THIS.this_oBusinessObject.Excluir()
849:                 MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Excluir")
850:                 THIS.CarregarLista()
851:             ENDIF
852:         ENDIF
853:     ENDPROC
854: 
855:     *--------------------------------------------------------------------------
856:     PROCEDURE BtnBuscarClick()
857:         THIS.LimparCampos()
858:         THIS.this_cModoAtual = "BUSCAR"
859:         THIS.HabilitarCampos(.T.)


### BO (C:\4c\projeto\app\classes\DICBO.prg):
*==============================================================================
* DICBO.prg - Business Object para Dicionario de Idiomas
* Tabela: SigCdDic
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS DICBO AS BusinessBase

    *-- Chave primaria (PK: cidchaves char(20), gerada por fUniqueIds())
    this_cIdChaves  = ""

    *-- Campos da tabela SigCdDic
    this_dDatas     = {}    && datas datetime NULL
    this_cExpressao = ""    && expressao char(60) NOT NULL
    this_cIdioma    = ""    && idioma char(10) NOT NULL
    this_cTraducao  = ""    && traducao char(60) NOT NULL
    this_cUsuars    = ""    && usuars char(10) NOT NULL

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdDic"
            THIS.this_cCampoChave = "cidchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cIdChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista registros do dicionario filtrados por par_cFiltro
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_cFiltro) != "C"
                par_cFiltro = ""
            ENDIF

            IF EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = "SELECT Idioma, Expressao, Traducao, cidchaves" + ;
                    " FROM SigCdDic" + ;
                    " ORDER BY Expressao, Idioma"
            ELSE
                loc_cSQL = "SELECT Idioma, Expressao, Traducao, cidchaves" + ;
                    " FROM SigCdDic" + ;
                    " WHERE Expressao LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                    "    OR Idioma LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                    "    OR Traducao LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                    " ORDER BY Expressao, Idioma"
            ENDIF

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar registros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo cidchaves (PK)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cIdChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, datas, expressao, idioma, traducao, usuars" + ;
                " FROM SigCdDic" + ;
                " WHERE cidchaves = " + EscaparSQL(par_cIdChaves)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cIdChaves  = TratarNulo(cidchaves,  "C")
            THIS.this_dDatas     = TratarNulo(datas,      "D")
            THIS.this_cExpressao = TratarNulo(expressao,  "C")
            THIS.this_cIdioma    = TratarNulo(idioma,     "C")
            THIS.this_cTraducao  = TratarNulo(traducao,   "C")
            THIS.this_cUsuars    = TratarNulo(usuars,     "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de inserir/atualizar
    *--------------------------------------------------------------------------
    FUNCTION ValidarDados()
        LOCAL loc_lResultado
        loc_lResultado = .T.

        IF EMPTY(ALLTRIM(THIS.this_cExpressao))
            MsgAviso("Express" + CHR(227) + "o Inv" + CHR(225) + "lida !!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDIF

        IF loc_lResultado AND EMPTY(ALLTRIM(THIS.this_cIdioma))
            MsgAviso("Idioma Inv" + CHR(225) + "lido !!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDIF

        IF loc_lResultado AND EMPTY(ALLTRIM(THIS.this_cTraducao))
            MsgAviso("Tradu" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida !!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarDuplicidade - Verifica se Expressao+Idioma ja existe (apenas no INSERT)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION VerificarDuplicidade()
        LOCAL loc_cSQL, loc_nResultado, loc_lDuplicado
        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdDic" + ;
                " WHERE Expressao = " + EscaparSQL(THIS.this_cExpressao) + ;
                "   AND Idioma    = " + EscaparSQL(THIS.this_cIdioma)

            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dup")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Dup") > 0
                SELECT cursor_4c_Dup
                loc_lDuplicado = (cursor_4c_Dup.Total > 0)
            ENDIF

            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lDuplicado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdDic
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cIdChaves))
                THIS.this_cIdChaves = fUniqueIds()
            ENDIF

            THIS.this_cUsuars = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)

            IF THIS.VerificarDuplicidade()
                MsgAviso(CHR(67) + CHR(243) + "digo j" + CHR(225) + " Cadastrado !!", "Duplicado")
                loc_lResultado = .F.
            ELSE
                loc_cSQL = "INSERT INTO SigCdDic" + ;
                    " (cidchaves, datas, expressao, idioma, traducao, usuars)" + ;
                    " VALUES (" + ;
                    EscaparSQL(THIS.this_cIdChaves) + ", " + ;
                    "GETDATE(), " + ;
                    EscaparSQL(LEFT(ALLTRIM(THIS.this_cExpressao), 60)) + ", " + ;
                    EscaparSQL(LEFT(ALLTRIM(THIS.this_cIdioma), 10)) + ", " + ;
                    EscaparSQL(LEFT(ALLTRIM(THIS.this_cTraducao), 60)) + ", " + ;
                    EscaparSQL(LEFT(ALLTRIM(THIS.this_cUsuars), 10)) + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao inserir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdDic
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_cUsuars = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)

            loc_cSQL = "UPDATE SigCdDic SET" + ;
                " traducao = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cTraducao), 60)) + "," + ;
                " usuars   = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cUsuars), 10)) + ;
                " WHERE cidchaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigCdDic
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdDic" + ;
                " WHERE cidchaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

