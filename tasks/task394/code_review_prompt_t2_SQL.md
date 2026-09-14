# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormDIC.prg) - TRECHOS RELEVANTES PARA PASS SQL (901 linhas total):

*-- Linhas 318 a 336:
318:             .HighlightBackColor = RGB(255, 255, 255)
319:             .HighlightForeColor = RGB(15, 41, 104)
320:             .HighlightStyle     = 2
321:             .DeleteMark         = .F.
322:             .RecordMark         = .F.
323:             .RowHeight          = 16
324:             .ScrollBars         = 2
325:             .GridLines          = 3
326:             .Visible            = .T.
327:         ENDWITH
328: 
329:         *-- BINDEVENT: vincular botoes
330:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
331:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
332:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
333:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
334:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
335:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
336: 

*-- Linhas 532 a 552:
532:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
533:                     loc_oGrid.ColumnCount  = 3
534: 
535:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Idioma"
536:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Expressao"
537:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Traducao"
538: 
539:                     loc_oGrid.Column1.Width = 70
540:                     loc_oGrid.Column2.Width = 280
541:                     loc_oGrid.Column3.Width = 280
542: 
543:                     loc_oGrid.Column1.Header1.Caption = "Idioma"
544:                     loc_oGrid.Column2.Header1.Caption = "Express" + CHR(227) + "o"
545:                     loc_oGrid.Column3.Header1.Caption = "Tradu" + CHR(231) + CHR(227) + "o"
546: 
547:                     loc_oGrid.Refresh()
548:                     THIS.FormatarGridLista(loc_oGrid)
549:                     loc_lResultado = .T.
550:                 ENDIF
551:             ENDIF
552:         CATCH TO loc_oErro

*-- Linhas 702 a 720:
702:             THIS.this_cModoAtual = "LISTA"
703:             THIS.AlternarPagina(1)
704:             IF !EMPTY(loc_cExpressao) AND USED("cursor_4c_Dados")
705:                 SELECT cursor_4c_Dados
706:                 LOCATE FOR ALLTRIM(cursor_4c_Dados.Expressao) = loc_cExpressao
707:                 IF !EOF("cursor_4c_Dados")
708:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
709:                 ENDIF
710:             ENDIF
711:             RETURN
712:         ENDIF
713: 
714:         *-- Obter valores para validacao
715:         IF PEMSTATUS(loc_oPagina, "txt_4c_Expressao", 5)
716:             loc_cExpressao = ALLTRIM(loc_oPagina.txt_4c_Expressao.Value)
717:         ENDIF
718:         IF PEMSTATUS(loc_oPagina, "txt_4c_Idioma", 5)
719:             loc_cIdioma = ALLTRIM(loc_oPagina.txt_4c_Idioma.Value)
720:         ENDIF

*-- Linhas 747 a 767:
747: 
748:         *-- Em modo INCLUIR: verificar duplicidade por Expressao + Idioma
749:         IF THIS.this_cModoAtual = "INCLUIR"
750:             loc_cSQL = "SELECT 1 AS chk FROM SigCdDic WHERE Expressao = " + EscaparSQL(loc_cExpressao) + ;
751:                        " AND Idioma = " + EscaparSQL(loc_cIdioma)
752:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupCheck")
753:             IF USED("cursor_4c_DupCheck")
754:                 IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_DupCheck") > 0
755:                     USE IN cursor_4c_DupCheck
756:                     MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " Cadastrado !!", "Salvar")
757:                     IF PEMSTATUS(loc_oPagina, "txt_4c_Expressao", 5)
758:                         loc_oPagina.txt_4c_Expressao.SetFocus()
759:                     ENDIF
760:                     RETURN
761:                 ENDIF
762:                 USE IN cursor_4c_DupCheck
763:             ENDIF
764:         ENDIF
765: 
766:         *-- Transferir Form -> BO e salvar
767:         THIS.FormParaBO()

*-- Linhas 797 a 836:
797:             RETURN
798:         ENDIF
799: 
800:         SELECT cursor_4c_Dados
801:         loc_cIdChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
802: 
803:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
804:             THIS.BOParaForm()
805:             THIS.this_cModoAtual = "VISUALIZAR"
806:             THIS.HabilitarCampos(.F.)
807:             THIS.AjustarBotoesPorModo()
808:             THIS.AlternarPagina(2)
809:         ENDIF
810:     ENDPROC
811: 
812:     *--------------------------------------------------------------------------
813:     PROCEDURE BtnAlterarClick()
814:         LOCAL loc_cIdChaves
815: 
816:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
817:             MsgAviso("Selecione um registro na lista!", "Alterar")
818:             RETURN
819:         ENDIF
820: 
821:         SELECT cursor_4c_Dados
822:         loc_cIdChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
823: 
824:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
825:             THIS.this_oBusinessObject.EditarRegistro()
826:             THIS.BOParaForm()
827:             THIS.this_cModoAtual = "ALTERAR"
828:             THIS.HabilitarCampos(.T.)
829:             THIS.AjustarBotoesPorModo()
830:             THIS.AlternarPagina(2)
831:         ENDIF
832:     ENDPROC
833: 
834:     *--------------------------------------------------------------------------
835:     PROCEDURE BtnExcluirClick()
836:         LOCAL loc_cIdChaves

*-- Linhas 844 a 862:
844:             RETURN
845:         ENDIF
846: 
847:         SELECT cursor_4c_Dados
848:         loc_cIdChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
849: 
850:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
851:             IF THIS.this_oBusinessObject.Excluir()
852:                 MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Excluir")
853:                 THIS.CarregarLista()
854:             ENDIF
855:         ENDIF
856:     ENDPROC
857: 
858:     *--------------------------------------------------------------------------
859:     PROCEDURE BtnBuscarClick()
860:         THIS.LimparCampos()
861:         THIS.this_cModoAtual = "BUSCAR"
862:         THIS.HabilitarCampos(.T.)


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

