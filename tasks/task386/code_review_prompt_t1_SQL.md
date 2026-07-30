# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PKCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODS

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
  ControlSource = "crSigCdCsi.Cods"
  ControlSource = "crSigCdCsi.Descs"
		lcQuery = [Select Cods ] + ;
				    [From sigcdcsi ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalBus]) < 1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormCsi.prg) - TRECHOS RELEVANTES PARA PASS SQL (883 linhas total):

*-- Linhas 330 a 348:
330:             .HighlightBackColor = RGB(255, 255, 255)
331:             .HighlightForeColor = RGB(15, 41, 104)
332:             .HighlightStyle     = 2
333:             .DeleteMark         = .F.
334:             .RecordMark         = .F.
335:             .RowHeight          = 16
336:             .ScrollBars         = 2
337:             .GridLines          = 3
338:             .Column1.Width           = 80
339:             .Column2.Width           = 150
340:         ENDWITH
341: 
342:         THIS.TornarControlesVisiveis(loc_oPagina)
343:     ENDPROC
344: 
345:     *==========================================================================
346:     * ConfigurarPaginaDados - Configura Page2: botoes acao e saida
347:     * Nota: Labels e TextBoxes adicionados nas Fases 5-6
348:     *==========================================================================

*-- Linhas 533 a 554:
533:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
534:                     loc_oGrid.ColumnCount  = 2
535:                     WITH loc_oGrid
536:                         .Column1.ControlSource   = "cursor_4c_Dados.Cods"
537:                         .Column1.Width           = 80
538:                         .Column1.Header1.Caption = "C" + CHR(243) + "digo"
539:                         .Column2.ControlSource   = "cursor_4c_Dados.Descs"
540:                         .Column2.Width           = 150
541:                         .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
542:                     ENDWITH
543: 
544:                     THIS.FormatarGridLista(loc_oGrid)
545:                     loc_oGrid.Refresh()
546:                     THIS.AjustarBotoesPorModo()
547:                     loc_lResultado = .T.
548:                 ENDIF
549:             ENDIF
550: 
551:         CATCH TO loException
552:             MostrarErro("Erro em FormCsi.CarregarLista:" + CHR(13) + ;
553:                         loException.Message + CHR(13) + ;
554:                         "Linha: " + TRANSFORM(loException.LineNo), "Erro")

*-- Linhas 612 a 669:
612:             MsgAviso("Nenhum registro selecionado para visualizar!")
613:             RETURN
614:         ENDIF
615:         SELECT cursor_4c_Dados
616:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.Cods)
617:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
618:             THIS.this_cModoAtual = "VISUALIZAR"
619:             THIS.BOParaForm()
620:             THIS.HabilitarCampos(.F.)
621:             THIS.AlternarPagina(2)
622:         ENDIF
623:     ENDPROC
624: 
625:     *==========================================================================
626:     * BtnAlterarClick - Carrega registro selecionado para edicao
627:     *==========================================================================
628:     PROCEDURE BtnAlterarClick()
629:         LOCAL loc_cCodigo
630:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
631:             MsgAviso("Nenhum registro selecionado para alterar!")
632:             RETURN
633:         ENDIF
634:         SELECT cursor_4c_Dados
635:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.Cods)
636:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
637:             THIS.this_oBusinessObject.EditarRegistro()
638:             THIS.this_cModoAtual = "ALTERAR"
639:             THIS.BOParaForm()
640:             THIS.HabilitarCampos(.T.)
641:             THIS.AlternarPagina(2)
642:         ENDIF
643:     ENDPROC
644: 
645:     *==========================================================================
646:     * BtnExcluirClick - Exclui o registro selecionado apos confirmacao
647:     *==========================================================================
648:     PROCEDURE BtnExcluirClick()
649:         LOCAL loc_cCodigo, loc_lConfirmou
650:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
651:             MsgAviso("Nenhum registro selecionado para excluir!")
652:             RETURN
653:         ENDIF
654:         SELECT cursor_4c_Dados
655:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.Cods)
656:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
657:             loc_lConfirmou = MsgConfirma("Confirma a exclus" + CHR(227) + "o da categoria " + ;
658:                                          CHR(34) + loc_cCodigo + CHR(34) + "?", ;
659:                                          "Confirmar Exclus" + CHR(227) + "o")
660:             IF loc_lConfirmou
661:                 IF THIS.this_oBusinessObject.Excluir()
662:                     MsgInfo("Categoria exclu" + CHR(237) + "da com sucesso!")
663:                     THIS.CarregarLista()
664:                 ENDIF
665:             ENDIF
666:         ENDIF
667:     ENDPROC
668: 
669:     *==========================================================================


### BO (C:\4c\projeto\app\classes\CsiBO.prg):
*------------------------------------------------------------------------------
* CsiBO.prg - Business Object: Categoria do Site
* Tabela: sigcdcsi | PK: pkchaves char(20) | Campos: cods char(2), descs char(30)
*------------------------------------------------------------------------------

DEFINE CLASS CsiBO AS BusinessBase

    *-- Propriedades de dados
    this_cCodigo    = ""    && cods     char(2) - codigo da categoria
    this_cDescricao = ""    && descs    char(30) - descricao da categoria
    this_cPkChaves  = ""    && pkchaves char(20) - PK tecnica gerada no insert

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "sigcdcsi"
            THIS.this_cCampoChave = "pkchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "CsiBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades do BO
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cPkChaves  = TratarNulo(pkChaves, "C")
                THIS.this_cCodigo    = TratarNulo(Cods,     "C")
                THIS.this_cDescricao = TratarNulo(Descs,    "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "CsiBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    * Replica logica do Salva.Click original: valida Cods e Descs obrigatorios
    * + verificacao de duplicidade no INSERT
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCodigo))
            MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido!!!", ;
                     "Aten" + CHR(231) + CHR(227) + "o!!!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarCodigoExistente(THIS.this_cCodigo)
                MsgAviso("C" + CHR(243) + "digo J" + CHR(225) + " Cadastrado!!!", ;
                         "Aten" + CHR(231) + CHR(227) + "o!!!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cDescricao))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!", ;
                     "Aten" + CHR(231) + CHR(227) + "o!!!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarCodigoExistente - Verifica se cods ja existe na tabela
    *--------------------------------------------------------------------------
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM sigcdcsi" + ;
                       " WHERE Cods = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
                SELECT cursor_4c_ChkCod
                loc_lExiste = (cursor_4c_ChkCod.qtd > 0)
                USE IN cursor_4c_ChkCod
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "CsiBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela sigcdcsi
    * Gera pkChaves unico via SYS(2015) (substituto do fUniqueIds legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cPkChaves = LEFT(SYS(2015) + SYS(2015), 20)

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO sigcdcsi (pkChaves, Cods, Descs)
                VALUES (
                    <<EscaparSQL(THIS.this_cPkChaves)>>,
                    <<EscaparSQL(THIS.this_cCodigo)>>,
                    <<EscaparSQL(THIS.this_cDescricao)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir categoria:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "CsiBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela sigcdcsi
    * Nota: Cods e readonly em ALTERAR (getCods.When = .F. no original)
    * UPDATE apenas Descs, identificando pelo pkChaves tecnico
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE sigcdcsi
                SET Descs = <<EscaparSQL(THIS.this_cDescricao)>>
                WHERE pkChaves = <<EscaparSQL(THIS.this_cPkChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar categoria:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "CsiBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela sigcdcsi
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM sigcdcsi" + ;
                       " WHERE pkChaves = " + EscaparSQL(THIS.this_cPkChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir categoria:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "CsiBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - SELECT registros com filtro opcional
    * Retorna cursor_4c_Dados com pkChaves, Cods, Descs
    * Grid mostra: Cods (Codigo, 80px), Descs (Descricao, 150px)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (pkChaves C(20), Cods C(2), Descs C(30))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT pkChaves, Cods, Descs FROM sigcdcsi"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY Cods"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        SET NULL ON
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        SET NULL OFF
                        IF USED("cursor_4c_DadosTmp")
                            USE IN cursor_4c_DadosTmp
                        ENDIF
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar categorias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar categorias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "CsiBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo codigo natural (Cods)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT pkChaves, Cods, Descs FROM sigcdcsi" + ;
                       " WHERE Cods = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Categoria n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar categoria:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "CsiBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

