# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODS, CRETRABS

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
  ControlSource = "CrSigPrJst.Descrs"
  ControlSource = "CrSigPrJst.Cods"
Select CrSigPrJst
		lcSql = [Select * From SigPrJst Where cRetrabs = ']+ThisForm.pRetrab+[']
	lcSql = [Select * From SigPrJst Where Cods = ']+lcCod+[' ]
	If ThisForm.Podatamgr.Sqlexecute(lcsql,'TmpJust') > 0 And ;

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormJUS.prg) - TRECHOS RELEVANTES PARA PASS SQL (965 linhas total):

*-- Linhas 368 a 386:
368:             .HighlightBackColor = RGB(255, 255, 255)
369:             .HighlightForeColor = RGB(15, 41, 104)
370:             .HighlightStyle     = 2
371:             .DeleteMark         = .F.
372:             .RecordMark         = .F.
373:             .RowHeight          = 16
374:             .ScrollBars         = 2
375:             .GridLines          = 3
376:             .Visible            = .T.
377:         ENDWITH
378:         WITH loc_oGrid.Column1
379:             .Header1.Caption = "C" + CHR(243) + "digo"
380:             .Width           = 80
381:             .Alignment       = 0
382:         ENDWITH
383:         WITH loc_oGrid.Column2
384:             .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
385:             .Width           = 650
386:         ENDWITH

*-- Linhas 557 a 584:
557:             ELSE
558:                 loc_cFiltro = ""
559:                 IF !EMPTY(THIS.this_cRetrabalho)
560:                     loc_cFiltro = "cRetrabs = " + EscaparSQL(THIS.this_cRetrabalho)
561:                 ENDIF
562: 
563:                 IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
564:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
565:                     loc_oGrid.ColumnCount = 3
566:                     loc_oGrid.RecordSource        = "cursor_4c_Dados"
567:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Cods"
568:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descrs"
569:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.cRetrabs"
570:                     *-- Reconfigurar headers: RecordSource reseta captions
571:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
572:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
573:                     loc_oGrid.Column3.Header1.Caption = "Retrabalho"
574:                     THIS.FormatarGridLista(loc_oGrid)
575:                     loc_lResultado = .T.
576:                 ENDIF
577:             ENDIF
578: 
579:         CATCH TO loException
580:             MostrarErro(loException, "FormJUS.CarregarLista")
581:             loc_lResultado = .F.
582:         ENDTRY
583: 
584:         RETURN loc_lResultado

*-- Linhas 670 a 688:
670:             RETURN
671:         ENDIF
672: 
673:         SELECT cursor_4c_Dados
674:         loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
675: 
676:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
677:             THIS.this_cModoAtual = "VISUALIZAR"
678:             THIS.BOParaForm()
679:             THIS.HabilitarCampos(.F.)
680:             THIS.AjustarBotoesPorModo()
681:             THIS.AlternarPagina(2)
682:         ELSE
683:             MsgAviso("Erro ao carregar registro selecionado.", "Visualizar")
684:         ENDIF
685:     ENDPROC
686: 
687:     *==========================================================================
688:     * BtnAlterarClick - Carrega registro selecionado para edicao

*-- Linhas 696 a 714:
696:             RETURN
697:         ENDIF
698: 
699:         SELECT cursor_4c_Dados
700:         loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
701: 
702:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
703:             THIS.this_oBusinessObject.EditarRegistro()
704:             THIS.this_cModoAtual = "ALTERAR"
705:             THIS.BOParaForm()
706:             THIS.HabilitarCampos(.T.)
707:             THIS.AjustarBotoesPorModo()
708:             THIS.AlternarPagina(2)
709:             THIS.pgf_4c_Paginas.Page2.txt_4c_Descr.SetFocus
710:         ELSE
711:             MsgAviso("Erro ao carregar registro selecionado.", "Alterar")
712:         ENDIF
713:     ENDPROC
714: 

*-- Linhas 723 a 741:
723:             RETURN
724:         ENDIF
725: 
726:         SELECT cursor_4c_Dados
727:         loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
728:         loc_cCods      = ALLTRIM(cursor_4c_Dados.Cods)
729: 
730:         loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o do registro '" + ;
731:                                     loc_cCods + "'?", "Excluir")
732:         IF !loc_lConfirma
733:             RETURN
734:         ENDIF
735: 
736:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
737:             IF THIS.this_oBusinessObject.Excluir()
738:                 MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.", "Excluir")
739:                 THIS.CarregarLista()
740:             ELSE
741:                 MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir o registro.", "Excluir")

*-- Linhas 756 a 788:
756:         TRY
757:             loc_cFiltro = ""
758:             IF !EMPTY(THIS.this_cRetrabalho)
759:                 loc_cFiltro = "cRetrabs = " + EscaparSQL(THIS.this_cRetrabalho)
760:             ENDIF
761: 
762:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
763:                 "SigPrJst", "cursor_4c_BuscaJus", "Cods", "", ;
764:                 "Buscar Justificativa", .F., .T., loc_cFiltro)
765: 
766:             IF VARTYPE(loc_oBusca) = "O"
767:                 loc_oBusca.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
768:                 loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
769:                 loc_oBusca.Show()
770: 
771:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaJus")
772:                     IF USED("cursor_4c_Dados")
773:                         SELECT cursor_4c_Dados
774:                         LOCATE FOR cursor_4c_Dados.Cods = ALLTRIM(cursor_4c_BuscaJus.Cods)
775:                     ENDIF
776:                 ENDIF
777: 
778:                 loc_oBusca.Release()
779:                 loc_lResultado = .T.
780:             ENDIF
781: 
782:         CATCH TO loException
783:             MostrarErro(loException, "FormJUS.BtnBuscarClick")
784:         ENDTRY
785: 
786:         IF USED("cursor_4c_BuscaJus")
787:             USE IN cursor_4c_BuscaJus
788:         ENDIF


### BO (C:\4c\projeto\app\classes\JUSBO.prg):
*==============================================================================
* JUSBO.prg - Business Object para Justificativas do Retrabalho (SigPrJst)
*==============================================================================

DEFINE CLASS JUSBO AS BusinessBase

    *-- Chave primaria
    this_cCidChaves = ""   && cidchaves char(20) - PK gerada por fUniqueIds()

    *-- Campos da tabela SigPrJst
    this_cCods      = ""   && cods char(3) - codigo da justificativa
    this_cRetrabs   = ""   && cretrabs char(6) - tipo de retrabalho (FK)
    this_cDescrs    = ""   && descrs char(30) - descricao

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigPrJst"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para registro de auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    * REGRA: Sempre SELECT (alias) antes de acessar campos
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            THIS.this_cCods      = TratarNulo(cods, "C")
            THIS.this_cRetrabs   = TratarNulo(cRetrabs, "C")
            THIS.this_cDescrs    = TratarNulo(descrs, "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista justificativas com filtro WHERE opcional
    * par_cFiltro: condicao sem a palavra WHERE (ex: "cRetrabs = 'X'")
    * Resultado em cursor_4c_Dados
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, cods, cRetrabs, descrs" + ;
                       " FROM SigPrJst"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + ALLTRIM(par_cFiltro)
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY cods"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar justificativas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega justificativa pela chave primaria (cidchaves)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCidChaves)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, cods, cRetrabs, descrs" + ;
                       " FROM SigPrJst" + ;
                       " WHERE cidchaves = " + EscaparSQL(ALLTRIM(par_cCidChaves))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND USED("cursor_4c_Carrega") AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar justificativa:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida campos obrigatorios e unicidade antes de salvar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDados()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .T.

        TRY
            *-- Codigo obrigatorio
            IF EMPTY(ALLTRIM(THIS.this_cCods))
                MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido!!!", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ENDIF

            *-- Validar duplicidade no INSERT: cods+cretrabs devem ser unicos
            IF loc_lResultado AND THIS.this_lNovoRegistro
                loc_cSQL = "SELECT cidchaves FROM SigPrJst" + ;
                           " WHERE cods = " + EscaparSQL(THIS.this_cCods) + ;
                           " AND cRetrabs = " + EscaparSQL(THIS.this_cRetrabs)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dup")
                IF loc_nResultado >= 0 AND USED("cursor_4c_Dup") AND RECCOUNT("cursor_4c_Dup") > 0
                    SELECT cursor_4c_Dup
                    MsgAviso("Justificativa j" + CHR(225) + " cadastrada para o Retrabalho " + ;
                             ALLTRIM(THIS.this_cRetrabs), "")
                    loc_lResultado = .F.
                ENDIF
                IF USED("cursor_4c_Dup")
                    USE IN cursor_4c_Dup
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigPrJst
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            THIS.this_cCidChaves = fUniqueIds()

            loc_cSQL = "INSERT INTO SigPrJst" + ;
                       " (cidchaves, cods, cRetrabs, descrs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cCods) + ", " + ;
                       EscaparSQL(THIS.this_cRetrabs) + ", " + ;
                       EscaparSQL(THIS.this_cDescrs) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir justificativa:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Ins")
            USE IN cursor_4c_Ins
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigPrJst (cods nao atualiza em modo ALTERAR pois
    * o original so habilita get_Descr no ALTERAR, mantendo cods readonly)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigPrJst SET" + ;
                       " descrs = " + EscaparSQL(THIS.this_cDescrs) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar justificativa:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Upd")
            USE IN cursor_4c_Upd
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de SigPrJst
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrJst" + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir justificativa:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Del")
            USE IN cursor_4c_Del
        ENDIF

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

