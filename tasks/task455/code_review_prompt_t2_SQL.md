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

### FORM (C:\4c\projeto\app\forms\cadastros\FormJUS.prg) - TRECHOS RELEVANTES PARA PASS SQL (966 linhas total):

*-- Linhas 370 a 388:
370:             .HighlightBackColor = RGB(255, 255, 255)
371:             .HighlightForeColor = RGB(15, 41, 104)
372:             .HighlightStyle     = 2
373:             .DeleteMark         = .F.
374:             .RecordMark         = .F.
375:             .RowHeight          = 16
376:             .ScrollBars         = 2
377:             .GridLines          = 3
378:             .Visible            = .T.
379:         ENDWITH
380:         WITH loc_oGrid.Column1
381:             .Header1.Caption = "C" + CHR(243) + "digo"
382:             .Width           = 80
383:             .Alignment       = 0
384:         ENDWITH
385:         WITH loc_oGrid.Column2
386:             .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
387:             .Width           = 650
388:         ENDWITH

*-- Linhas 559 a 586:
559:             ELSE
560:                 loc_cFiltro = ""
561:                 IF !EMPTY(THIS.this_cRetrabalho)
562:                     loc_cFiltro = "cRetrabs = " + EscaparSQL(THIS.this_cRetrabalho)
563:                 ENDIF
564: 
565:                 IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
566:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
567:                     loc_oGrid.ColumnCount = 3
568:                     loc_oGrid.RecordSource        = "cursor_4c_Dados"
569:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Cods"
570:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descrs"
571:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.cRetrabs"
572:                     *-- Reconfigurar headers: RecordSource reseta captions
573:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
574:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
575:                     loc_oGrid.Column3.Header1.Caption = "Retrabalho"
576:                     THIS.FormatarGridLista(loc_oGrid)
577:                     loc_lResultado = .T.
578:                 ENDIF
579:             ENDIF
580: 
581:         CATCH TO loException
582:             MostrarErro(loException, "FormJUS.CarregarLista")
583:             loc_lResultado = .F.
584:         ENDTRY
585: 
586:         RETURN loc_lResultado

*-- Linhas 672 a 690:
672:             RETURN
673:         ENDIF
674: 
675:         SELECT cursor_4c_Dados
676:         loc_cCods = ALLTRIM(cursor_4c_Dados.Cods)
677: 
678:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCods)
679:             THIS.this_cModoAtual = "VISUALIZAR"
680:             THIS.BOParaForm()
681:             THIS.HabilitarCampos(.F.)
682:             THIS.AjustarBotoesPorModo()
683:             THIS.AlternarPagina(2)
684:         ELSE
685:             MsgAviso("Erro ao carregar registro selecionado.", "Visualizar")
686:         ENDIF
687:     ENDPROC
688: 
689:     *==========================================================================
690:     * BtnAlterarClick - Carrega registro selecionado para edicao

*-- Linhas 698 a 716:
698:             RETURN
699:         ENDIF
700: 
701:         SELECT cursor_4c_Dados
702:         loc_cCods = ALLTRIM(cursor_4c_Dados.Cods)
703: 
704:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCods)
705:             THIS.this_oBusinessObject.EditarRegistro()
706:             THIS.this_cModoAtual = "ALTERAR"
707:             THIS.BOParaForm()
708:             THIS.HabilitarCampos(.T.)
709:             THIS.AjustarBotoesPorModo()
710:             THIS.AlternarPagina(2)
711:             THIS.pgf_4c_Paginas.Page2.txt_4c_Descr.SetFocus
712:         ELSE
713:             MsgAviso("Erro ao carregar registro selecionado.", "Alterar")
714:         ENDIF
715:     ENDPROC
716: 

*-- Linhas 725 a 743:
725:             RETURN
726:         ENDIF
727: 
728:         SELECT cursor_4c_Dados
729:         loc_cCods = ALLTRIM(cursor_4c_Dados.Cods)
730: 
731:         loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o do registro '" + ;
732:                                     loc_cCods + "'?", "Excluir")
733:         IF !loc_lConfirma
734:             RETURN
735:         ENDIF
736: 
737:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCods)
738:             IF THIS.this_oBusinessObject.Excluir()
739:                 MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.", "Excluir")
740:                 THIS.CarregarLista()
741:             ELSE
742:                 MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir o registro.", "Excluir")
743:             ENDIF

*-- Linhas 757 a 789:
757:         TRY
758:             loc_cFiltro = ""
759:             IF !EMPTY(THIS.this_cRetrabalho)
760:                 loc_cFiltro = "cRetrabs = " + EscaparSQL(THIS.this_cRetrabalho)
761:             ENDIF
762: 
763:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
764:                 "SigPrJst", "cursor_4c_BuscaJus", "Cods", "", ;
765:                 "Buscar Justificativa", .F., .T., loc_cFiltro)
766: 
767:             IF VARTYPE(loc_oBusca) = "O"
768:                 loc_oBusca.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
769:                 loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
770:                 loc_oBusca.Show()
771: 
772:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaJus")
773:                     IF USED("cursor_4c_Dados")
774:                         SELECT cursor_4c_Dados
775:                         LOCATE FOR cursor_4c_Dados.Cods = ALLTRIM(cursor_4c_BuscaJus.Cods)
776:                     ENDIF
777:                 ENDIF
778: 
779:                 loc_oBusca.Release()
780:                 loc_lResultado = .T.
781:             ENDIF
782: 
783:         CATCH TO loException
784:             MostrarErro(loException, "FormJUS.BtnBuscarClick")
785:         ENDTRY
786: 
787:         IF USED("cursor_4c_BuscaJus")
788:             USE IN cursor_4c_BuscaJus
789:         ENDIF


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
    * CarregarPorCodigo - Carrega justificativa pelo codigo (cods) - igual ao legado
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCods)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, cods, cRetrabs, descrs" + ;
                       " FROM SigPrJst" + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(par_cCods))

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

