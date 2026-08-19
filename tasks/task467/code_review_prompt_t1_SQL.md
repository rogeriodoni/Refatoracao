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

### FORM (C:\4c\projeto\app\forms\cadastros\Formmpp.prg) - TRECHOS RELEVANTES PARA PASS SQL (957 linhas total):

*-- Linhas 364 a 382:
364:             .HighlightBackColor   = RGB(255, 255, 255)
365:             .HighlightForeColor   = RGB(15, 41, 104)
366:             .HighlightStyle       = 2
367:             .DeleteMark           = .F.
368:             .RecordMark           = .F.
369:             .RowHeight            = 16
370:             .ScrollBars           = 2
371:             .GridLines            = 3
372:             .ReadOnly             = .T.
373:             .Column1.Width        = 120
374:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
375:             .Column2.Width        = 400
376:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
377:             .Visible              = .T.
378:         ENDWITH
379: 
380:         THIS.TornarControlesVisiveis(loc_oPg1)
381:     ENDPROC
382: 

*-- Linhas 564 a 583:
564:             ELSE
565:                 loc_oGrid.ColumnCount = 2
566:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
567:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Codigos"
568:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descrs"
569:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
570:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
571:                 THIS.FormatarGridLista(loc_oGrid)
572:                 THIS.AjustarBotoesPorModo()
573:                 loc_lResultado = .T.
574:             ENDIF
575:         CATCH TO loc_oErro
576:             MsgErro("Erro em Formmpp.CarregarLista:" + CHR(13) + loc_oErro.Message, "Erro")
577:             loc_lResultado = .F.
578:         ENDTRY
579: 
580:         RETURN loc_lResultado
581:     ENDPROC
582: 
583:     *--------------------------------------------------------------------------

*-- Linhas 637 a 655:
637:             RETURN
638:         ENDIF
639: 
640:         SELECT cursor_4c_Dados
641:         loc_cChave = ALLTRIM(cursor_4c_Dados.CidChaves)
642: 
643:         IF EMPTY(loc_cChave)
644:             MsgAviso("Selecione um registro na lista.", "Visualizar")
645:             RETURN
646:         ENDIF
647: 
648:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
649:             THIS.this_cModoAtual = "VISUALIZAR"
650:             THIS.BOParaForm()
651:             THIS.HabilitarCampos(.F.)
652:             THIS.AlternarPagina(2)
653:         ELSE
654:             MsgErro("Erro ao carregar registro selecionado.", "Visualizar")
655:         ENDIF

*-- Linhas 667 a 685:
667:             RETURN
668:         ENDIF
669: 
670:         SELECT cursor_4c_Dados
671:         loc_cChave = ALLTRIM(cursor_4c_Dados.CidChaves)
672: 
673:         IF EMPTY(loc_cChave)
674:             MsgAviso("Selecione um registro na lista.", "Alterar")
675:             RETURN
676:         ENDIF
677: 
678:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
679:             THIS.this_oBusinessObject.EditarRegistro()
680:             THIS.this_cModoAtual = "ALTERAR"
681:             THIS.BOParaForm()
682:             THIS.HabilitarCampos(.T.)
683:             THIS.AlternarPagina(2)
684:         ELSE
685:             MsgErro("Erro ao carregar registro para edi" + CHR(231) + CHR(227) + "o.", "Alterar")

*-- Linhas 702 a 720:
702:             RETURN
703:         ENDIF
704: 
705:         SELECT cursor_4c_Dados
706:         loc_cChave   = ALLTRIM(cursor_4c_Dados.CidChaves)
707:         loc_cDescrs  = ALLTRIM(cursor_4c_Dados.Descrs)
708:         loc_cCodigos = ALLTRIM(cursor_4c_Dados.Codigos)
709: 
710:         IF EMPTY(loc_cChave)
711:             MsgAviso("Selecione um registro na lista.", "Excluir")
712:             RETURN
713:         ENDIF
714: 
715:         loc_lConfirma = MsgConfirma("Excluir o complemento:" + CHR(13) + ;
716:             CHR(13) + loc_cDescrs + CHR(13) + CHR(13) + "Confirma?", "Excluir")
717: 
718:         IF !loc_lConfirma
719:             RETURN
720:         ENDIF

*-- Linhas 763 a 790:
763:                 loc_oBusca.Show()
764: 
765:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMpp")
766:                     SELECT cursor_4c_BuscaMpp
767:                     loc_cFiltro = "Codigos = " + EscaparSQL(ALLTRIM(cursor_4c_BuscaMpp.Codigos))
768:                     THIS.this_oBusinessObject.Buscar(loc_cFiltro, THIS.this_nTipo)
769: 
770:                     LOCAL loc_oGrid
771:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
772:                     loc_oGrid.ColumnCount = 2
773:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
774:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Codigos"
775:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descrs"
776:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
777:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
778:                     THIS.FormatarGridLista(loc_oGrid)
779:                 ENDIF
780: 
781:                 loc_oBusca.Release()
782:             ENDIF
783:         CATCH TO loc_oErro
784:             MsgErro("Erro em Formmpp.BtnBuscarClick:" + CHR(13) + loc_oErro.Message, "Erro")
785:         ENDTRY
786: 
787:         IF USED("cursor_4c_BuscaMpp")
788:             USE IN cursor_4c_BuscaMpp
789:         ENDIF
790:     ENDPROC


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

