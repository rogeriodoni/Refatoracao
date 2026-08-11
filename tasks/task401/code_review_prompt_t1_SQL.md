# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
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
  ControlSource = "crSigCdEma.Cods"
		lcQuery = [Select Cods From SigCdEma Where Cods = '] + Padr(ThisForm.Pagina.Dados.getCods.Value, 50) + [']
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalBus]) < 1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formema.prg) - TRECHOS RELEVANTES PARA PASS SQL (923 linhas total):

*-- Linhas 338 a 356:
338:             .HighlightBackColor = RGB(255, 255, 255)
339:             .HighlightForeColor = RGB(15, 41, 104)
340:             .HighlightStyle     = 2
341:             .DeleteMark         = .F.
342:             .RecordMark         = .F.
343:             .RowHeight          = 16
344:             .ScrollBars         = 2
345:             .GridLines          = 3
346:             .Visible            = .T.
347:         ENDWITH
348: 
349:         *-- BINDEVENTs dos botoes CRUD (handlers devem ser PUBLIC)
350:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
351:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
352:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
353:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
354:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
355:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
356:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "GradeListaDblClick")

*-- Linhas 524 a 557:
524: 
525:         TRY
526:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
527:                 CREATE CURSOR cursor_4c_Dados (cIdChaves C(36), Cods C(50))
528:                 loc_lResultado = .T.
529:             ELSE
530:                 loc_lResultado = THIS.this_oBusinessObject.Buscar("")
531:             ENDIF
532: 
533:             IF loc_lResultado AND PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
534:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
535: 
536:                 *-- RecordSource e ColumnCount FORA de WITH (Problema 36/48)
537:                 loc_oGrid.ColumnCount = 3
538:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
539:                 loc_oGrid.ColumnCount  = 1
540: 
541:                 WITH loc_oGrid
542:                     .Column1.ControlSource   = "cursor_4c_Dados.Cods"
543:                     .Column1.Width           = 880
544:                     .Column1.Header1.Caption = "Email"
545:                 ENDWITH
546: 
547:                 THIS.FormatarGridLista(loc_oGrid)
548:                 loc_oGrid.Refresh()
549:             ENDIF
550:         CATCH TO loc_oErro
551:             MsgErro("Erro em CarregarLista:" + CHR(13) + loc_oErro.Message, "Erro")
552:             loc_lResultado = .F.
553:         ENDTRY
554: 
555:         RETURN loc_lResultado
556:     ENDPROC
557: 

*-- Linhas 633 a 651:
633:         loc_cCodigo = ""
634: 
635:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
636:             SELECT cursor_4c_Dados
637:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cIdChaves)
638:         ENDIF
639: 
640:         IF EMPTY(loc_cCodigo)
641:             MsgAviso("Selecione um registro na lista.", "Visualizar")
642:             RETURN
643:         ENDIF
644: 
645:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
646:             THIS.BOParaForm()
647:             THIS.this_cModoAtual = "VISUALIZAR"
648:             THIS.HabilitarCampos(.F.)
649:             THIS.AlternarPagina(2)
650:         ENDIF
651:     ENDPROC

*-- Linhas 658 a 676:
658:         loc_cCodigo = ""
659: 
660:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
661:             SELECT cursor_4c_Dados
662:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cIdChaves)
663:         ENDIF
664: 
665:         IF EMPTY(loc_cCodigo)
666:             MsgAviso("Selecione um registro na lista.", "Alterar")
667:             RETURN
668:         ENDIF
669: 
670:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
671:             THIS.this_oBusinessObject.EditarRegistro()
672:             THIS.BOParaForm()
673:             THIS.this_cModoAtual = "ALTERAR"
674:             THIS.HabilitarCampos(.T.)
675:             THIS.AlternarPagina(2)
676:         ENDIF

*-- Linhas 685 a 703:
685:         loc_lConfirmado = .F.
686: 
687:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
688:             SELECT cursor_4c_Dados
689:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cIdChaves)
690:         ENDIF
691: 
692:         IF EMPTY(loc_cCodigo)
693:             MsgAviso("Selecione um registro na lista.", "Excluir")
694:             RETURN
695:         ENDIF
696: 
697:         loc_lConfirmado = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", ;
698:                                       "Confirmar Exclus" + CHR(227) + "o")
699:         IF !loc_lConfirmado
700:             RETURN
701:         ENDIF
702: 
703:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)

*-- Linhas 729 a 747:
729:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
730:                 loc_oGrid.ColumnCount  = 1
731:                 WITH loc_oGrid
732:                     .Column1.ControlSource   = "cursor_4c_Dados.Cods"
733:                     .Column1.Width           = 880
734:                     .Column1.Header1.Caption = "Email"
735:                 ENDWITH
736:                 loc_oGrid.Refresh()
737:             ENDIF
738:         CATCH TO loc_oErro
739:             MsgErro("Erro em BtnBuscarClick:" + CHR(13) + loc_oErro.Message, "Erro")
740:         ENDTRY
741:     ENDPROC
742: 
743:     *--------------------------------------------------------------------------
744:     * BtnEncerrarClick - Fecha o formulario
745:     *--------------------------------------------------------------------------
746:     PROCEDURE BtnEncerrarClick()
747:         THIS.Release()

*-- Linhas 815 a 833:
815:     ENDPROC
816: 
817:     *--------------------------------------------------------------------------
818:     * BtnSalvarClick - Valida e salva o registro (INSERT ou UPDATE)
819:     * Logica: valida email nao vazio, delega ao BO (que verifica duplicidade)
820:     *--------------------------------------------------------------------------
821:     PROCEDURE BtnSalvarClick()
822:         LOCAL loc_cEmail, loc_lSucesso
823:         loc_cEmail   = ""
824:         loc_lSucesso = .F.
825: 
826:         *-- Validacao ANTES do TRY (RETURN e permitido fora de TRY/CATCH)
827:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Codigo", 5)
828:             loc_cEmail = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.Value)
829:         ENDIF
830: 
831:         IF EMPTY(loc_cEmail)
832:             MsgAviso("Email Inv" + CHR(225) + "lido!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
833:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Codigo", 5)


### BO (C:\4c\projeto\app\classes\emaBO.prg):
*==============================================================================
* EMABO.PRG
* Business Object para Cadastro de Email (SigCdEma)
* Herda de BusinessBase
*==============================================================================

DEFINE CLASS emaBO AS BusinessBase

    *-- Propriedades de dados
    this_cIdChaves = ""    && PK (gerada por fUniqueIds)
    this_cCods     = ""    && Email (C 50)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdEma"
            THIS.this_cCampoChave = "cIdChaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar emaBO: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK atual para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cIdChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cIdChaves = TratarNulo(cIdChaves, "C")
            THIS.this_cCods     = TratarNulo(Cods,      "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Retorna todos os emails (ou filtrados por texto)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_cFiltro) != "C"
                par_cFiltro = ""
            ENDIF

            loc_cSQL = "SELECT cIdChaves, Cods FROM SigCdEma"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + ;
                           " WHERE Cods LIKE " + EscaparSQL(par_cFiltro + "%")
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY Cods"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar emails:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo email (Cods)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT cIdChaves, Cods FROM SigCdEma" + ;
                       " WHERE cIdChaves = " + EscaparSQL(ALLTRIM(par_cCodigo))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MsgErro("Erro ao carregar email:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdEma
    * Logica do legado: valida email nao vazio, verifica duplicidade, gera PK
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_cSQLDup, loc_nDup
        loc_lResultado = .F.

        *-- Validacoes fora do TRY (RETURN permitido aqui)
        IF EMPTY(ALLTRIM(THIS.this_cCods))
            MsgAviso("Email Inv" + CHR(225) + "lido!!!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            *-- Verificar duplicidade de email (logica identica ao legado)
            loc_cSQLDup = "SELECT Cods FROM SigCdEma" + ;
                          " WHERE Cods = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cCods), 50))
            loc_nDup = SQLEXEC(gnConnHandle, loc_cSQLDup, "cursor_4c_Dup")

            IF loc_nDup >= 0 AND RECCOUNT("cursor_4c_Dup") > 0
                IF USED("cursor_4c_Dup")
                    USE IN cursor_4c_Dup
                ENDIF
                MsgAviso("Email J" + CHR(225) + " Cadastrado!!!", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF USED("cursor_4c_Dup")
                    USE IN cursor_4c_Dup
                ENDIF

                *-- Gerar chave primaria (equivalente ao fUniqueIds() do legado)
                THIS.this_cIdChaves = fUniqueIds()

                loc_cSQL = "INSERT INTO SigCdEma (cIdChaves, Cods)" + ;
                           " VALUES (" + EscaparSQL(THIS.this_cIdChaves) + ;
                           ", " + EscaparSQL(ALLTRIM(THIS.this_cCods)) + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao inserir email:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdEma
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        *-- Validacoes fora do TRY (RETURN permitido aqui)
        IF EMPTY(ALLTRIM(THIS.this_cCods))
            MsgAviso("Email Inv" + CHR(225) + "lido!!!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cIdChaves))
            MsgErro("Chave prim" + CHR(225) + "ria inv" + CHR(225) + "lida para atualiza" + ;
                    CHR(231) + CHR(227) + "o.", "Erro")
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "UPDATE SigCdEma" + ;
                       " SET Cods = " + EscaparSQL(ALLTRIM(THIS.this_cCods)) + ;
                       " WHERE cIdChaves = " + EscaparSQL(ALLTRIM(THIS.this_cIdChaves))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar email:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigCdEma
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdEma" + ;
                       " WHERE cIdChaves = " + EscaparSQL(ALLTRIM(THIS.this_cIdChaves))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir email:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

