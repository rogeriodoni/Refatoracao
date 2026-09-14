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

### FORM (C:\4c\projeto\app\forms\cadastros\Formema.prg) - TRECHOS RELEVANTES PARA PASS SQL (925 linhas total):

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

*-- Linhas 525 a 559:
525:         TRY
526:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
527:                 SET NULL ON
528:                 CREATE CURSOR cursor_4c_Dados (cIdChaves C(36), Cods C(50))
529:                 SET NULL OFF
530:                 loc_lResultado = .T.
531:             ELSE
532:                 loc_lResultado = THIS.this_oBusinessObject.Buscar("")
533:             ENDIF
534: 
535:             IF loc_lResultado AND PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
536:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
537: 
538:                 *-- RecordSource e ColumnCount FORA de WITH (Problema 36/48)
539:                 loc_oGrid.ColumnCount = 3
540:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
541:                 loc_oGrid.ColumnCount  = 1
542: 
543:                 WITH loc_oGrid
544:                     .Column1.ControlSource   = "cursor_4c_Dados.Cods"
545:                     .Column1.Width           = 880
546:                     .Column1.Header1.Caption = "Email"
547:                 ENDWITH
548: 
549:                 THIS.FormatarGridLista(loc_oGrid)
550:                 loc_oGrid.Refresh()
551:             ENDIF
552:         CATCH TO loc_oErro
553:             MsgErro("Erro em CarregarLista:" + CHR(13) + loc_oErro.Message, "Erro")
554:             loc_lResultado = .F.
555:         ENDTRY
556: 
557:         RETURN loc_lResultado
558:     ENDPROC
559: 

*-- Linhas 635 a 653:
635:         loc_cCodigo = ""
636: 
637:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
638:             SELECT cursor_4c_Dados
639:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.Cods)
640:         ENDIF
641: 
642:         IF EMPTY(loc_cCodigo)
643:             MsgAviso("Selecione um registro na lista.", "Visualizar")
644:             RETURN
645:         ENDIF
646: 
647:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
648:             THIS.BOParaForm()
649:             THIS.this_cModoAtual = "VISUALIZAR"
650:             THIS.HabilitarCampos(.F.)
651:             THIS.AlternarPagina(2)
652:         ENDIF
653:     ENDPROC

*-- Linhas 660 a 678:
660:         loc_cCodigo = ""
661: 
662:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
663:             SELECT cursor_4c_Dados
664:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.Cods)
665:         ENDIF
666: 
667:         IF EMPTY(loc_cCodigo)
668:             MsgAviso("Selecione um registro na lista.", "Alterar")
669:             RETURN
670:         ENDIF
671: 
672:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
673:             THIS.this_oBusinessObject.EditarRegistro()
674:             THIS.BOParaForm()
675:             THIS.this_cModoAtual = "ALTERAR"
676:             THIS.HabilitarCampos(.T.)
677:             THIS.AlternarPagina(2)
678:         ENDIF

*-- Linhas 687 a 705:
687:         loc_lConfirmado = .F.
688: 
689:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
690:             SELECT cursor_4c_Dados
691:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.Cods)
692:         ENDIF
693: 
694:         IF EMPTY(loc_cCodigo)
695:             MsgAviso("Selecione um registro na lista.", "Excluir")
696:             RETURN
697:         ENDIF
698: 
699:         loc_lConfirmado = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", ;
700:                                       "Confirmar Exclus" + CHR(227) + "o")
701:         IF !loc_lConfirmado
702:             RETURN
703:         ENDIF
704: 
705:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)

*-- Linhas 731 a 749:
731:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
732:                 loc_oGrid.ColumnCount  = 1
733:                 WITH loc_oGrid
734:                     .Column1.ControlSource   = "cursor_4c_Dados.Cods"
735:                     .Column1.Width           = 880
736:                     .Column1.Header1.Caption = "Email"
737:                 ENDWITH
738:                 loc_oGrid.Refresh()
739:             ENDIF
740:         CATCH TO loc_oErro
741:             MsgErro("Erro em BtnBuscarClick:" + CHR(13) + loc_oErro.Message, "Erro")
742:         ENDTRY
743:     ENDPROC
744: 
745:     *--------------------------------------------------------------------------
746:     * BtnEncerrarClick - Fecha o formulario
747:     *--------------------------------------------------------------------------
748:     PROCEDURE BtnEncerrarClick()
749:         THIS.Release()

*-- Linhas 817 a 835:
817:     ENDPROC
818: 
819:     *--------------------------------------------------------------------------
820:     * BtnSalvarClick - Valida e salva o registro (INSERT ou UPDATE)
821:     * Logica: valida email nao vazio, delega ao BO (que verifica duplicidade)
822:     *--------------------------------------------------------------------------
823:     PROCEDURE BtnSalvarClick()
824:         LOCAL loc_cEmail, loc_lSucesso
825:         loc_cEmail   = ""
826:         loc_lSucesso = .F.
827: 
828:         *-- Validacao ANTES do TRY (RETURN e permitido fora de TRY/CATCH)
829:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Codigo", 5)
830:             loc_cEmail = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.Value)
831:         ENDIF
832: 
833:         IF EMPTY(loc_cEmail)
834:             MsgAviso("Email Inv" + CHR(225) + "lido!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
835:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Codigo", 5)


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
                       " WHERE Cods = " + EscaparSQL(PADR(ALLTRIM(par_cCodigo), 50))

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

