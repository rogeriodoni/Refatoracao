# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODS

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
  ControlSource = "crSigCdOrl.cods"
  ControlSource = "crSigCdOrl.descs"
Select CrSigCdOrl
Select CrSigCdOrl
Select CrSigCdOrl

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formorl.prg) - TRECHOS RELEVANTES PARA PASS SQL (869 linhas total):

*-- Linhas 328 a 346:
328:             .HighlightBackColor = RGB(255, 255, 255)
329:             .HighlightForeColor = RGB(15, 41, 104)
330:             .HighlightStyle     = 2
331:             .DeleteMark         = .F.
332:             .RecordMark         = .F.
333:             .RowHeight          = 16
334:             .ScrollBars         = 2
335:             .GridLines          = 3
336:             .Visible            = .T.
337: 
338:             WITH .Column1
339:                 .Width              = 90
340:                 .Alignment          = 0
341:                 .Header1.Caption    = "C" + CHR(243) + "digo"
342:             ENDWITH
343: 
344:             WITH .Column2
345:                 .Width              = 337
346:                 .Alignment          = 0

*-- Linhas 509 a 528:
509:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
510:                     loc_oGrid.ColumnCount = 2
511:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
512:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
513:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
514:                     loc_oGrid.Column1.Width = 90
515:                     loc_oGrid.Column2.Width = 337
516:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
517:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
518:                     THIS.FormatarGridLista(loc_oGrid)
519:                     loc_lResultado = .T.
520:                 ENDIF
521:             ENDIF
522:         CATCH TO loException
523:             MostrarErro(loException, "Formorl.CarregarLista")
524:         ENDTRY
525: 
526:         RETURN loc_lResultado
527:     ENDPROC
528: 

*-- Linhas 589 a 607:
589:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
590:                 MsgAviso("Nenhum registro selecionado.", "Visualizar")
591:             ELSE
592:                 SELECT cursor_4c_Dados
593:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
594:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
595:                     THIS.BOParaForm()
596:                     THIS.this_cModoAtual = "VISUALIZAR"
597:                     THIS.HabilitarCampos(.F.)
598:                     THIS.AjustarBotoesPorModo()
599:                     THIS.AlternarPagina(2)
600:                 ELSE
601:                     MsgErro("Registro n" + CHR(227) + "o encontrado.", "Visualizar")
602:                 ENDIF
603:             ENDIF
604:         CATCH TO loException
605:             MostrarErro(loException, "Formorl.BtnVisualizarClick")
606:         ENDTRY
607:     ENDPROC

*-- Linhas 615 a 633:
615:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
616:                 MsgAviso("Nenhum registro selecionado.", "Alterar")
617:             ELSE
618:                 SELECT cursor_4c_Dados
619:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
620:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
621:                     THIS.this_oBusinessObject.EditarRegistro()
622:                     THIS.BOParaForm()
623:                     THIS.this_cModoAtual = "ALTERAR"
624:                     THIS.HabilitarCampos(.T.)
625:                     THIS.AjustarBotoesPorModo()
626:                     THIS.AlternarPagina(2)
627:                     *-- Legado: ALTERAR -> foco na descricao (codigo bloqueado)
628:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Desc", 5)
629:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Desc.SetFocus()
630:                     ENDIF
631:                 ELSE
632:                     MsgErro("Registro n" + CHR(227) + "o encontrado.", "Alterar")
633:                 ENDIF

*-- Linhas 646 a 664:
646:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
647:                 MsgAviso("Nenhum registro selecionado.", "Excluir")
648:             ELSE
649:                 SELECT cursor_4c_Dados
650:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
651:                 loc_lConfirmado = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro " + ;
652:                     CHR(34) + loc_cCodigo + CHR(34) + "?", "Excluir")
653:                 IF loc_lConfirmado
654:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
655:                         IF THIS.this_oBusinessObject.Excluir()
656:                             MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Excluir")
657:                             THIS.CarregarLista()
658:                         ELSE
659:                             MsgErro("Erro ao excluir o registro.", "Excluir")
660:                         ENDIF
661:                     ENDIF
662:                 ENDIF
663:             ENDIF
664:         CATCH TO loException

*-- Linhas 681 a 700:
681:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
682:                     loc_oGrid.ColumnCount = 2
683:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
684:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
685:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
686:                     loc_oGrid.Column1.Width = 90
687:                     loc_oGrid.Column2.Width = 337
688:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
689:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
690:                     THIS.FormatarGridLista(loc_oGrid)
691:                     loc_lResultado = .T.
692:                 ELSE
693:                     MsgAviso("Nenhum registro encontrado para o filtro informado.", "Buscar")
694:                 ENDIF
695:             ELSE
696:                 THIS.CarregarLista()
697:             ENDIF
698:         CATCH TO loException
699:             MostrarErro(loException, "Formorl.BtnBuscarClick")
700:         ENDTRY


### BO (C:\4c\projeto\app\classes\orlBO.prg):
*====================================================================
* orlBO.prg
*
* Business Object para Cadastro de Origem
* Tabela: sigcdorl
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS orlBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela sigcdorl)
    this_cCodigo    = ""    && cods char(10) - codigo de origem (chave de negocio)
    this_cCodChaves = ""    && cidchaves char(20) - PK tecnica gerada por fUniqueIds()
    this_cDescricao = ""    && descs char(40)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "sigcdorl"
            THIS.this_cCampoChave = "cods"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "orlBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigo    = TratarNulo(cods,      "C")
                THIS.this_cCodChaves = TratarNulo(cidchaves, "C")
                THIS.this_cDescricao = TratarNulo(descs,     "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "orlBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCodigo)
            MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cDescricao)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * Buscar - SELECT de registros (suporta filtro parcial por cods/descs)
    *====================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT cods, cidchaves, descs" + ;
                       " FROM sigcdorl"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + ;
                    " WHERE cods LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                    " OR descs LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%")
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY cods"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult < 0
                MostrarErro("Erro ao buscar origens:" + CHR(13) + CapturarErroSQL(), "orlBO.Buscar")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "orlBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pelo codigo de negocio (cods)
    *====================================================================
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT cods, cidchaves, descs" + ;
                       " FROM sigcdorl" + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(par_cCodigo))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult < 0
                MostrarErro("Erro ao carregar origem:" + CHR(13) + CapturarErroSQL(), "orlBO.CarregarPorCodigo")
            ELSE
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "orlBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * VerificarCodigoDuplicado - Verifica se cods ja existe (apenas no INSERT)
    *====================================================================
    FUNCTION VerificarCodigoDuplicado()
        LOCAL loc_lDuplicado, loc_cSQL, loc_nResult
        loc_lDuplicado = .F.

        TRY
            IF USED("cursor_4c_Chk")
                USE IN cursor_4c_Chk
            ENDIF

            loc_cSQL = "SELECT COUNT(*) AS qtd FROM sigcdorl" + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Chk")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Chk") > 0
                SELECT cursor_4c_Chk
                loc_lDuplicado = (cursor_4c_Chk.qtd > 0)
            ENDIF

            IF USED("cursor_4c_Chk")
                USE IN cursor_4c_Chk
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar duplicidade:" + CHR(13) + loException.Message, "orlBO.VerificarCodigoDuplicado")
        ENDTRY

        RETURN loc_lDuplicado
    ENDFUNC

    *====================================================================
    * Inserir - INSERT de um novo registro em sigcdorl
    * Gera cidchaves via fUniqueIds()
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            IF THIS.VerificarCodigoDuplicado()
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!")
                loc_lSucesso = .F.
            ELSE
                THIS.this_cCodChaves = fUniqueIds()

                loc_cSQL = "INSERT INTO sigcdorl" + ;
                           " (cods, cidchaves, descs)" + ;
                           " VALUES (" + ;
                           EscaparSQL(ALLTRIM(THIS.this_cCodigo)) + ", " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cCodChaves)) + ", " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cDescricao)) + ")"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult < 0
                    MostrarErro("Erro ao inserir origem:" + CHR(13) + CapturarErroSQL(), "orlBO.Inserir")
                ELSE
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "orlBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE do registro em sigcdorl (identifica por cods)
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE sigcdorl SET" + ;
                       " descs = " + EscaparSQL(ALLTRIM(THIS.this_cDescricao)) + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult < 0
                MostrarErro("Erro ao atualizar origem:" + CHR(13) + CapturarErroSQL(), "orlBO.Atualizar")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "orlBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - DELETE do registro em sigcdorl
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM sigcdorl" + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult < 0
                MostrarErro("Erro ao excluir origem:" + CHR(13) + CapturarErroSQL(), "orlBO.ExecutarExclusao")
            ELSE
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "orlBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Destroy - Libera cursores
    *====================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF
        IF USED("cursor_4c_Chk")
            USE IN cursor_4c_Chk
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

