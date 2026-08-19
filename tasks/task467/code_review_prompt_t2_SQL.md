# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NTIPOS, CODIGOS, COMPLS, CTITS

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
  ControlSource = "crSigPrCpP.Descrs"
  ControlSource = "crSigPrCpP.Codigos"
	lcQuery = [Select * from SigPrCpP where nTipos = ]+Str(ThisForm.pnTipo,1)
Select crSigPrCpP
Select crSigPrCpP
			lcQuery = [Select * From SigPrCpP ] + ;
			If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crBusca') < 1)
		lcQuery = [Select * From SigClCrc ] + ;
		If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crSigClCrc') < 1)
	lcQuery = [Select CGrus ] + ;
		[From SigCdFtc ] + ;
	If (Thisform.poDataMgr.SqlExecute(lcQuery, 'SigCdFtc') < 1)
Select crSigPrCpP

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formmpp.prg) - TRECHOS RELEVANTES PARA PASS SQL (959 linhas total):

*-- Linhas 366 a 384:
366:             .HighlightBackColor   = RGB(255, 255, 255)
367:             .HighlightForeColor   = RGB(15, 41, 104)
368:             .HighlightStyle       = 2
369:             .DeleteMark           = .F.
370:             .RecordMark           = .F.
371:             .RowHeight            = 16
372:             .ScrollBars           = 2
373:             .GridLines            = 3
374:             .ReadOnly             = .T.
375:             .Column1.Width        = 120
376:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
377:             .Column2.Width        = 400
378:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
379:             .Visible              = .T.
380:         ENDWITH
381: 
382:         THIS.TornarControlesVisiveis(loc_oPg1)
383:     ENDPROC
384: 

*-- Linhas 566 a 585:
566:             ELSE
567:                 loc_oGrid.ColumnCount = 2
568:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
569:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Codigos"
570:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descrs"
571:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
572:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
573:                 THIS.FormatarGridLista(loc_oGrid)
574:                 THIS.AjustarBotoesPorModo()
575:                 loc_lResultado = .T.
576:             ENDIF
577:         CATCH TO loc_oErro
578:             MsgErro("Erro em Formmpp.CarregarLista:" + CHR(13) + loc_oErro.Message, "Erro")
579:             loc_lResultado = .F.
580:         ENDTRY
581: 
582:         RETURN loc_lResultado
583:     ENDPROC
584: 
585:     *--------------------------------------------------------------------------

*-- Linhas 639 a 657:
639:             RETURN
640:         ENDIF
641: 
642:         SELECT cursor_4c_Dados
643:         loc_cChave = ALLTRIM(cursor_4c_Dados.CidChaves)
644: 
645:         IF EMPTY(loc_cChave)
646:             MsgAviso("Selecione um registro na lista.", "Visualizar")
647:             RETURN
648:         ENDIF
649: 
650:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
651:             THIS.this_cModoAtual = "VISUALIZAR"
652:             THIS.BOParaForm()
653:             THIS.HabilitarCampos(.F.)
654:             THIS.AlternarPagina(2)
655:         ELSE
656:             MsgErro("Erro ao carregar registro selecionado.", "Visualizar")
657:         ENDIF

*-- Linhas 669 a 687:
669:             RETURN
670:         ENDIF
671: 
672:         SELECT cursor_4c_Dados
673:         loc_cChave = ALLTRIM(cursor_4c_Dados.CidChaves)
674: 
675:         IF EMPTY(loc_cChave)
676:             MsgAviso("Selecione um registro na lista.", "Alterar")
677:             RETURN
678:         ENDIF
679: 
680:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
681:             THIS.this_oBusinessObject.EditarRegistro()
682:             THIS.this_cModoAtual = "ALTERAR"
683:             THIS.BOParaForm()
684:             THIS.HabilitarCampos(.T.)
685:             THIS.AlternarPagina(2)
686:         ELSE
687:             MsgErro("Erro ao carregar registro para edi" + CHR(231) + CHR(227) + "o.", "Alterar")

*-- Linhas 704 a 722:
704:             RETURN
705:         ENDIF
706: 
707:         SELECT cursor_4c_Dados
708:         loc_cChave   = ALLTRIM(cursor_4c_Dados.CidChaves)
709:         loc_cDescrs  = ALLTRIM(cursor_4c_Dados.Descrs)
710:         loc_cCodigos = ALLTRIM(cursor_4c_Dados.Codigos)
711: 
712:         IF EMPTY(loc_cChave)
713:             MsgAviso("Selecione um registro na lista.", "Excluir")
714:             RETURN
715:         ENDIF
716: 
717:         loc_lConfirma = MsgConfirma("Excluir o complemento:" + CHR(13) + ;
718:             CHR(13) + loc_cDescrs + CHR(13) + CHR(13) + "Confirma?", "Excluir")
719: 
720:         IF !loc_lConfirma
721:             RETURN
722:         ENDIF

*-- Linhas 765 a 792:
765:                 loc_oBusca.Show()
766: 
767:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMpp")
768:                     SELECT cursor_4c_BuscaMpp
769:                     loc_cFiltro = "Codigos = " + EscaparSQL(ALLTRIM(cursor_4c_BuscaMpp.Codigos))
770:                     THIS.this_oBusinessObject.Buscar(loc_cFiltro, THIS.this_nTipo)
771: 
772:                     LOCAL loc_oGrid
773:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
774:                     loc_oGrid.ColumnCount = 2
775:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
776:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Codigos"
777:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descrs"
778:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
779:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
780:                     THIS.FormatarGridLista(loc_oGrid)
781:                 ENDIF
782: 
783:                 loc_oBusca.Release()
784:             ENDIF
785:         CATCH TO loc_oErro
786:             MsgErro("Erro em Formmpp.BtnBuscarClick:" + CHR(13) + loc_oErro.Message, "Erro")
787:         ENDTRY
788: 
789:         IF USED("cursor_4c_BuscaMpp")
790:             USE IN cursor_4c_BuscaMpp
791:         ENDIF
792:     ENDPROC


### BO (C:\4c\projeto\app\classes\mppBO.prg):
*==============================================================================
* mppBO.prg - Business Object para Complementos de Caracteristicas
* Tabela  : SigPrCpP
* PK      : CidChaves (UUID gerado por fUniqueIds)
* nTipos  : 0=Produtos  1=Contas  2=Movimentacoes
*==============================================================================

DEFINE CLASS mppBO AS BusinessBase

    *-- Chave primaria (UUID)
    this_cCidChaves     = ""    && char(20)    CidChaves - PK gerada por fUniqueIds()

    *-- Dados cadastrais
    this_cCodigos       = ""    && char(20)    Codigos   - Codigo do complemento
    this_cDescrs        = ""    && char(40)    Descrs    - Descricao

    *-- Tipo de complemento
    this_nTipos         = 0     && numeric(1)  nTipos    - 0=Produto 1=Conta 2=Movimentacao

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigPrCpP"
        THIS.this_cCampoChave = "CidChaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Retorna lista de complementos filtrados por nTipos
    *   par_cFiltro : filtro SQL adicional (sem WHERE) ou "" para todos
    *   par_nTipos  : 0/1/2 conforme tipo; -1 = sem filtro de tipo
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro, par_nTipos)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cWhere
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT CidChaves, Codigos, Descrs, nTipos FROM SigPrCpP"

            loc_cWhere = ""

            IF VARTYPE(par_nTipos) = "N" AND par_nTipos >= 0
                loc_cWhere = "nTipos = " + ALLTRIM(STR(par_nTipos, 1))
            ENDIF

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                IF EMPTY(loc_cWhere)
                    loc_cWhere = par_cFiltro
                ELSE
                    loc_cWhere = loc_cWhere + " AND " + par_cFiltro
                ENDIF
            ENDIF

            IF !EMPTY(loc_cWhere)
                loc_cSQL = loc_cSQL + " WHERE " + loc_cWhere
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY Codigos"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult > 0
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar complementos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em mppBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega complemento pela PK (CidChaves)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCidChaves)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT CidChaves, Codigos, Descrs, nTipos FROM SigPrCpP" + ;
                       " WHERE CidChaves = " + EscaparSQL(par_cCidChaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em mppBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigosETipo - Busca por Codigos + nTipos (chave natural)
    *   Usada para verificar duplicata antes de inserir
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigosETipo(par_cCodigos, par_nTipos)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT CidChaves, Codigos, Descrs, nTipos FROM SigPrCpP" + ;
                       " WHERE Codigos = " + EscaparSQL(par_cCodigos) + ;
                       " AND nTipos = " + ALLTRIM(STR(par_nTipos, 1))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em mppBO.CarregarPorCodigosETipo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarCodigoDuplicado - Retorna .T. se Codigos+nTipos ja existe
    *   (chamado antes do INSERT para barrar duplicatas - logica do legado)
    *--------------------------------------------------------------------------
    FUNCTION VerificarCodigoDuplicado(par_cCodigos, par_nTipos)
        LOCAL loc_cSQL, loc_nResult, loc_lDuplicado
        loc_lDuplicado = .F.
        TRY
            IF USED("cursor_4c_Duplica")
                USE IN cursor_4c_Duplica
            ENDIF

            loc_cSQL = "SELECT TOP 1 CidChaves FROM SigPrCpP" + ;
                       " WHERE Codigos = " + EscaparSQL(par_cCodigos) + ;
                       " AND nTipos = " + ALLTRIM(STR(par_nTipos, 1))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Duplica")
            IF loc_nResult > 0
                loc_lDuplicado = (RECCOUNT("cursor_4c_Duplica") > 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em mppBO.VerificarCodigoDuplicado:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_Duplica")
            USE IN cursor_4c_Duplica
        ENDIF
        RETURN loc_lDuplicado
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarUsoEmCaracteristicasContas - Verifica uso em SigClCrc.Compls
    *   Legado: antes de excluir registro com nTipos=1, verificar uso
    *--------------------------------------------------------------------------
    FUNCTION VerificarUsoEmCaracteristicasContas(par_cDescrs)
        LOCAL loc_cSQL, loc_nResult, loc_lEmUso
        loc_lEmUso = .F.
        TRY
            IF USED("cursor_4c_VerUso")
                USE IN cursor_4c_VerUso
            ENDIF

            loc_cSQL = "SELECT TOP 1 Compls FROM SigClCrc" + ;
                       " WHERE Compls = " + EscaparSQL(par_cDescrs)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerUso")
            IF loc_nResult > 0
                loc_lEmUso = (RECCOUNT("cursor_4c_VerUso") > 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em mppBO.VerificarUsoEmCaracteristicasContas:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_VerUso")
            USE IN cursor_4c_VerUso
        ENDIF
        RETURN loc_lEmUso
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarUsoEmFichasTecnicas - Verifica uso em SigCdFtc.CTits + nTipos
    *   Legado: antes de excluir, verificar se codigo e titulo de ficha tecnica
    *--------------------------------------------------------------------------
    FUNCTION VerificarUsoEmFichasTecnicas(par_cCodigos, par_nTipos)
        LOCAL loc_cSQL, loc_nResult, loc_lEmUso
        loc_lEmUso = .F.
        TRY
            IF USED("cursor_4c_VerFtc")
                USE IN cursor_4c_VerFtc
            ENDIF

            loc_cSQL = "SELECT TOP 1 CGrus FROM SigCdFtc" + ;
                       " WHERE CTits = " + EscaparSQL(par_cCodigos) + ;
                       " AND nTipos = " + ALLTRIM(STR(par_nTipos, 1))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerFtc")
            IF loc_nResult > 0
                loc_lEmUso = (RECCOUNT("cursor_4c_VerFtc") > 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em mppBO.VerificarUsoEmFichasTecnicas:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_VerFtc")
            USE IN cursor_4c_VerFtc
        ENDIF
        RETURN loc_lEmUso
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves = TratarNulo(CidChaves, "C")
            THIS.this_cCodigos   = TratarNulo(Codigos,   "C")
            THIS.this_cDescrs    = TratarNulo(Descrs,    "C")
            THIS.this_nTipos     = TratarNulo(nTipos,    "N")
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cChave
        loc_lSucesso = .F.
        TRY
            loc_cChave           = fUniqueIds()
            THIS.this_cCidChaves = loc_cChave

            loc_cSQL = "INSERT INTO SigPrCpP (CidChaves, Codigos, Descrs, nTipos) VALUES (" + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCodigos)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDescrs)) + ", " + ;
                       ALLTRIM(STR(THIS.this_nTipos, 1)) + ")"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Ins")
                TABLEREVERT(.T., "cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir complemento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em mppBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_Ins")
            USE IN cursor_4c_Ins
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            *-- Legado so permite alterar Descrs (Codigos e readonly em modo ALTERAR)
            loc_cSQL = "UPDATE SigPrCpP SET" + ;
                       " Descrs = " + EscaparSQL(ALLTRIM(THIS.this_cDescrs)) + ;
                       " WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Upd")
                TABLEREVERT(.T., "cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar complemento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em mppBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_Upd")
            USE IN cursor_4c_Upd
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "DELETE FROM SigPrCpP WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Del")
                TABLEREVERT(.T., "cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir complemento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em mppBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_Del")
            USE IN cursor_4c_Del
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

