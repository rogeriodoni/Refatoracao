# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCADS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: TIPOCADS, CODCADS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PKCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: TIPOCADS, CODCADS

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
  ControlSource = "crSigCdCad.CodCads"
  ControlSource = "crSigCdCad.DesCads"
lcQryCdCad = [Select * From SigCdCad Where TipoCads = ?pIds]
	lcQuery = [Select * ] + ;
			    [From SigCdCad ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalBus]) < 1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormCAD.prg) - TRECHOS RELEVANTES PARA PASS SQL (1061 linhas total):

*-- Linhas 369 a 398:
369:                 .HighlightBackColor = RGB(255, 255, 255)
370:                 .HighlightForeColor = RGB(15, 41, 104)
371:                 .HighlightStyle     = 2
372:                 .DeleteMark         = .F.
373:                 .RecordMark         = .F.
374:                 .RowHeight          = 16
375:                 .ScrollBars         = 2
376:                 .GridLines          = 3
377:                 .Visible            = .T.
378: 
379:                 .Column1.ControlSource    = "cursor_4c_Dados.codcads"
380:                 .Column1.Width            = 150
381:                 .Column1.Header1.Caption  = "C" + CHR(243) + "digo"
382: 
383:                 .Column2.ControlSource    = "cursor_4c_Dados.descads"
384:                 .Column2.Width            = 738
385:                 .Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
386:             ENDWITH
387: 
388:             *-- BINDEVENTs para botoes CRUD (metodos PUBLIC - sem PROTECTED)
389:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
390:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
391:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
392:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
393:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
394:             BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
395:             BINDEVENT(loc_oGrid, "DblClick", THIS, "BtnVisualizarClick")
396: 
397:             THIS.TornarControlesVisiveis(loc_oPagina)
398: 

*-- Linhas 619 a 641:
619:                 loc_oGrid.ColumnCount = 2
620:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
621: 
622:                 loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.codcads"
623:                 loc_oGrid.Column1.Width           = 150
624:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
625: 
626:                 loc_oGrid.Column2.ControlSource   = "cursor_4c_Dados.descads"
627:                 loc_oGrid.Column2.Width           = 738
628:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
629: 
630:                 THIS.FormatarGridLista(loc_oGrid)
631:                 loc_lResultado = .T.
632:             ENDIF
633:         CATCH TO loException
634:             MsgErro("Erro ao carregar lista:" + CHR(13) + loException.Message, "Erro")
635:             loc_lResultado = .F.
636:         ENDTRY
637: 
638:         RETURN loc_lResultado
639:     ENDPROC
640: 
641:     *==========================================================================

*-- Linhas 728 a 746:
728:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
729:                 MsgAviso("Nenhum registro selecionado.", "Aviso")
730:             ELSE
731:                 SELECT cursor_4c_Dados
732:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.codcads)
733: 
734:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
735:                     THIS.this_cModoAtual = "VISUALIZAR"
736:                     THIS.BOParaForm()
737:                     THIS.HabilitarCampos(.F.)
738:                     THIS.AjustarBotoesPorModo()
739:                     THIS.pgf_4c_Paginas.ActivePage = 2
740:                 ENDIF
741:             ENDIF
742:         CATCH TO loException
743:             MsgErro("Erro ao visualizar:" + CHR(13) + loException.Message, "Erro")
744:         ENDTRY
745:     ENDPROC
746: 

*-- Linhas 755 a 773:
755:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
756:                 MsgAviso("Nenhum registro selecionado.", "Aviso")
757:             ELSE
758:                 SELECT cursor_4c_Dados
759:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.codcads)
760: 
761:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
762:                     THIS.this_oBusinessObject.EditarRegistro()
763:                     THIS.this_cModoAtual = "ALTERAR"
764:                     THIS.BOParaForm()
765:                     THIS.HabilitarCampos(.T.)
766:                     THIS.AjustarBotoesPorModo()
767:                     THIS.pgf_4c_Paginas.ActivePage = 2
768:                 ENDIF
769:             ENDIF
770:         CATCH TO loException
771:             MsgErro("Erro ao alterar:" + CHR(13) + loException.Message, "Erro")
772:         ENDTRY
773:     ENDPROC

*-- Linhas 785 a 803:
785:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
786:                 MsgAviso("Nenhum registro selecionado.", "Aviso")
787:             ELSE
788:                 SELECT cursor_4c_Dados
789:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.codcads)
790:                 loc_cDesc   = ALLTRIM(cursor_4c_Dados.descads)
791: 
792:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
793:                     loc_lConfirma = MsgConfirma( ;
794:                         "Confirma a exclus" + CHR(227) + "o do registro:" + CHR(13) + CHR(13) + ;
795:                         "C" + CHR(243) + "digo: " + loc_cCodigo + CHR(13) + ;
796:                         "Descri" + CHR(231) + CHR(227) + "o: " + loc_cDesc, ;
797:                         "Confirmar Exclus" + CHR(227) + "o")
798: 
799:                     IF loc_lConfirma
800:                         IF THIS.this_oBusinessObject.Excluir()
801:                             MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", ;
802:                                 "Exclus" + CHR(227) + "o")
803:                             THIS.CarregarLista()

*-- Linhas 835 a 857:
835:                     loc_oGrid.ColumnCount = 2
836:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
837: 
838:                     loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.codcads"
839:                     loc_oGrid.Column1.Width           = 150
840:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
841: 
842:                     loc_oGrid.Column2.ControlSource   = "cursor_4c_Dados.descads"
843:                     loc_oGrid.Column2.Width           = 738
844:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
845: 
846:                     THIS.FormatarGridLista(loc_oGrid)
847:                 ENDIF
848:             ENDIF
849:         CATCH TO loException
850:             MsgErro("Erro ao buscar:" + CHR(13) + loException.Message, "Erro")
851:         ENDTRY
852:     ENDPROC
853: 
854:     *==========================================================================
855:     * BtnEncerrarClick - Fechar formulario
856:     *==========================================================================
857:     PROCEDURE BtnEncerrarClick()


### BO (C:\4c\projeto\app\classes\CADBO.prg):
*====================================================================
* CADBO.prg
*
* Business Object para Cadastros Gerais (SigCdCad)
* Herda de: BusinessBase
*
* PARAMETRIZADO: this_cTipoCads define a categoria de cadastro.
* Todas as queries filtram por TipoCads.
* Aberto pelo menu com par_cTipoCads e par_nMaxCodCads.
*====================================================================

DEFINE CLASS CADBO AS BusinessBase

    *-- Filtro de categoria (obrigatorio - definido pelo formulario chamador)
    this_cTipoCads   = ""   && tipocads char(20) - tipo/categoria do cadastro

    *-- Propriedades da entidade (SigCdCad)
    this_cPkChaves   = ""   && pkchaves char(20) - chave primaria (LEFT(NEWID(),20))
    this_cCodCads    = ""   && codcads char(20) - codigo do item
    this_cDesCads    = ""   && descads char(40) - descricao do item
    this_cTxtCads    = ""   && txtcads char(50) - texto adicional
    this_cUsuars     = ""   && usuars char(10) - usuario que incluiu
    this_dDtIncs     = {}   && dtincs datetime - data/hora de inclusao
    this_cUsuAlts    = ""   && usualts char(10) - usuario que alterou
    this_dDtAlts     = {}   && dtalts datetime - data/hora de alteracao

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdCad"
        THIS.this_cCampoChave = "pkchaves"
        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDPROC

    *====================================================================
    * LimparDados - Limpa propriedades (chamado por NovoRegistro)
    *====================================================================
    PROTECTED PROCEDURE LimparDados()
        THIS.this_cPkChaves = ""
        THIS.this_cCodCads  = ""
        THIS.this_cDesCads  = ""
        THIS.this_cTxtCads  = ""
        THIS.this_cUsuars   = ""
        THIS.this_dDtIncs   = {}
        THIS.this_cUsuAlts  = ""
        THIS.this_dDtAlts   = {}
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega dados do cursor para propriedades
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)
            THIS.this_cPkChaves = TratarNulo(pkchaves, "C")
            THIS.this_cCodCads  = TratarNulo(codcads,  "C")
            THIS.this_cDesCads  = TratarNulo(descads,  "C")
            THIS.this_cTxtCads  = TratarNulo(txtcads,  "C")
            THIS.this_cTipoCads = TratarNulo(tipocads, "C")
            THIS.this_cUsuars   = TratarNulo(usuars,   "C")
            THIS.this_cUsuAlts  = TratarNulo(usualts,  "C")
            IF !ISNULL(dtincs)
                THIS.this_dDtIncs = dtincs
            ENDIF
            IF !ISNULL(dtalts)
                THIS.this_dDtAlts = dtalts
            ENDIF
            THIS.this_lNovoRegistro = .F.
            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro ao carregar cursor: " + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * Buscar - Carrega lista de cadastros filtrada por TipoCads
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cTipoCads)
            MsgErro("Tipo de cadastro n" + CHR(227) + "o definido.", "Erro")
            RETURN .F.
        ENDIF

        TRY
            IF EMPTY(par_cFiltro)
                loc_cSQL = "SELECT pkchaves, codcads, descads, tipocads, usuars, dtincs, usualts, dtalts" + ;
                           " FROM SigCdCad" + ;
                           " WHERE tipocads = " + EscaparSQL(PADR(THIS.this_cTipoCads, 20)) + ;
                           " ORDER BY codcads"
            ELSE
                loc_cSQL = "SELECT pkchaves, codcads, descads, tipocads, usuars, dtincs, usualts, dtalts" + ;
                           " FROM SigCdCad" + ;
                           " WHERE tipocads = " + EscaparSQL(PADR(THIS.this_cTipoCads, 20)) + ;
                           "   AND (codcads LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                           "     OR descads LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ")" + ;
                           " ORDER BY codcads"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar cadastros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao buscar cadastros:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro por CodCads (chave de negocio)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodCads)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT pkchaves, codcads, descads, tipocads, txtcads," + ;
                       " usuars, dtincs, usualts, dtalts" + ;
                       " FROM SigCdCad" + ;
                       " WHERE tipocads = " + EscaparSQL(PADR(THIS.this_cTipoCads, 20)) + ;
                       "   AND codcads   = " + EscaparSQL(PADR(ALLTRIM(par_cCodCads), 20))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao carregar cadastro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * VerificarDuplicidade - Verifica se CodCads ja existe neste TipoCads
    *====================================================================
    PROCEDURE VerificarDuplicidade(par_cCodCads)
        LOCAL loc_cSQL, loc_nResultado, loc_lDuplicado
        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdCad" + ;
                       " WHERE tipocads = " + EscaparSQL(PADR(THIS.this_cTipoCads, 20)) + ;
                       "   AND codcads   = " + EscaparSQL(PADR(ALLTRIM(par_cCodCads), 20))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dup")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Dup") > 0
                SELECT cursor_4c_Dup
                loc_lDuplicado = (cursor_4c_Dup.qtd > 0)
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao verificar duplicidade:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Dup")
            USE IN cursor_4c_Dup
        ENDIF

        RETURN loc_lDuplicado
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro (PROTECTED - chamado por Salvar)
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cPkNovo
        loc_lSucesso = .F.
        loc_cPkNovo  = ""

        TRY
            *-- Gerar PK via SQL Server (NEWID nao existe em VFP)
            SQLEXEC(gnConnHandle, "SELECT LEFT(NEWID(),20) AS pk_novo", "cursor_4c_PkNovo")
            IF USED("cursor_4c_PkNovo") AND RECCOUNT("cursor_4c_PkNovo") > 0
                SELECT cursor_4c_PkNovo
                loc_cPkNovo = ALLTRIM(cursor_4c_PkNovo.pk_novo)
            ENDIF
            IF USED("cursor_4c_PkNovo")
                USE IN cursor_4c_PkNovo
            ENDIF

            IF !EMPTY(loc_cPkNovo)
                THIS.this_cPkChaves = loc_cPkNovo

                loc_cSQL = "INSERT INTO SigCdCad" + ;
                           " (pkchaves, tipocads, codcads, descads, txtcads, usuars, dtincs, usualts, dtalts)" + ;
                           " VALUES (" + ;
                           EscaparSQL(PADR(THIS.this_cPkChaves, 20)) + ", " + ;
                           EscaparSQL(PADR(THIS.this_cTipoCads, 20)) + ", " + ;
                           EscaparSQL(PADR(THIS.this_cCodCads,  20)) + ", " + ;
                           EscaparSQL(PADR(THIS.this_cDesCads,  40)) + ", " + ;
                           EscaparSQL(PADR(THIS.this_cTxtCads,  50)) + ", " + ;
                           EscaparSQL(PADR(gc_4c_UsuarioLogado, 10)) + ", " + ;
                           "GETDATE(), " + ;
                           EscaparSQL(SPACE(10)) + ", " + ;
                           "NULL" + ;
                           ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir cadastro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Falha ao gerar chave prim" + CHR(225) + "ria.", "Erro")
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao inserir cadastro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente (PROTECTED - chamado por Salvar)
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdCad SET" + ;
                       " descads  = " + EscaparSQL(PADR(THIS.this_cDesCads, 40)) + "," + ;
                       " txtcads  = " + EscaparSQL(PADR(THIS.this_cTxtCads, 50)) + "," + ;
                       " usualts  = " + EscaparSQL(PADR(gc_4c_UsuarioLogado, 10)) + "," + ;
                       " dtalts   = GETDATE()" + ;
                       " WHERE pkchaves = " + EscaparSQL(PADR(THIS.this_cPkChaves, 20))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar cadastro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao atualizar cadastro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro (PROTECTED - chamado por Excluir)
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdCad" + ;
                       " WHERE pkchaves = " + EscaparSQL(PADR(THIS.this_cPkChaves, 20))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir cadastro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao excluir cadastro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * InicializarValoresPadrao - Hook chamado por NovoRegistro
    *====================================================================
    PROTECTED PROCEDURE InicializarValoresPadrao()
        THIS.this_cPkChaves = ""
        THIS.this_cCodCads  = ""
        THIS.this_cDesCads  = ""
        THIS.this_cTxtCads  = ""
        THIS.this_cUsuars   = ""
        THIS.this_dDtIncs   = {}
        THIS.this_cUsuAlts  = ""
        THIS.this_dDtAlts   = {}
    ENDPROC

ENDDEFINE

