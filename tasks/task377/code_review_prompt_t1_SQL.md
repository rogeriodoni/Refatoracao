# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PKCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CONQUILHAS, CODTAMS

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
  ControlSource = "crSigCdCnq.Valors"
  ControlSource = "crSigCdCnq.Conquilhas"
  ControlSource = "crSigCdCnq.Codtams"
lcQryCnq = [Select * From SigCdCnq]
		Select crSigCdCnq
Select crSigCdCnq
Select crSigCdCnq
	lcQuery = [Select * From SigCdCnq Where conquilhas = '] + lcCon + [' And codtams = '] + lcCod + [']
	ThisForm.poDataMgr.SqlExecute(lcQuery, [crLocal])
	SELECT crLocal
		SELECT crSigCdCnq
SELECT crSigCdCnq
SELECT crSigcdcnq

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormCNQ.prg) - TRECHOS RELEVANTES PARA PASS SQL (1048 linhas total):

*-- Linhas 320 a 351:
320:         ENDWITH
321: 
322:         *-- Grid grd_4c_Lista - Legado: Grade (conquilhas/codtams/valors)
323:         *-- RecordSource e ControlSource configurados em CarregarLista() apos Buscar()
324:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
325:         loc_oGrid                    = loc_oPagina.grd_4c_Lista
326:         loc_oGrid.Top                = 117
327:         loc_oGrid.Left               = 2
328:         loc_oGrid.Width              = 910
329:         loc_oGrid.Height             = 477
330:         loc_oGrid.ColumnCount        = 3
331:         loc_oGrid.GridLines          = 3
332:         loc_oGrid.GridLineColor      = RGB(238, 238, 238)
333:         loc_oGrid.HighlightBackColor = RGB(255, 255, 255)
334:         loc_oGrid.HighlightForeColor = RGB(15, 41, 104)
335:         loc_oGrid.HighlightStyle     = 2
336:         loc_oGrid.DeleteMark         = .F.
337:         loc_oGrid.RecordMark         = .F.
338:         loc_oGrid.RowHeight          = 16
339:         loc_oGrid.ScrollBars         = 2
340:         loc_oGrid.FontName           = "Verdana"
341:         loc_oGrid.FontSize           = 8
342:         loc_oGrid.ForeColor          = RGB(90, 90, 90)
343:         loc_oGrid.BackColor          = RGB(255, 255, 255)
344:         loc_oGrid.Visible            = .T.
345: 
346:         *-- BINDEVENTs (metodos PUBLIC para funcionar com BINDEVENT)
347:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
348:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar,  "Click", THIS, "BtnVisualizarClick")
349:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
350:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
351:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")

*-- Linhas 565 a 595:
565:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
566:                     loc_oGrid.ColumnCount  = 3
567: 
568:                     *-- Problema 32: redefinir Headers APOS RecordSource + ControlSource
569:                     WITH loc_oGrid
570:                         .Column1.ControlSource   = "cursor_4c_Dados.conquilhas"
571:                         .Column1.Width           = 150
572:                         .Column1.Header1.Caption = "Conquilha"
573:                         .Column1.Alignment       = 0
574: 
575:                         .Column2.ControlSource   = "cursor_4c_Dados.codtams"
576:                         .Column2.Width           = 100
577:                         .Column2.Header1.Caption = "Aro"
578:                         .Column2.Alignment       = 1
579: 
580:                         .Column3.ControlSource   = "cursor_4c_Dados.valors"
581:                         .Column3.Width           = 100
582:                         .Column3.Header1.Caption = "Valor"
583:                         .Column3.Alignment       = 1
584:                     ENDWITH
585: 
586:                     THIS.FormatarGridLista(loc_oGrid)
587:                     loc_oGrid.Refresh()
588:                 ENDIF
589:                 loc_lResultado = .T.
590:             ENDIF
591:         CATCH TO loException
592:             MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message, "FormCNQ.CarregarLista")
593:             loc_lResultado = .F.
594:         ENDTRY
595: 

*-- Linhas 646 a 664:
646:         loc_cPK = ""
647: 
648:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
649:             SELECT cursor_4c_Dados
650:             loc_cPK = ALLTRIM(cursor_4c_Dados.pkChaves)
651:         ENDIF
652: 
653:         IF EMPTY(loc_cPK)
654:             MsgAviso("Selecione um registro na lista.")
655:             RETURN
656:         ENDIF
657: 
658:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPK)
659:             THIS.BOParaForm()
660:             THIS.this_cPkSelecionado = loc_cPK
661:             THIS.this_cModoAtual     = "VISUALIZAR"
662:             THIS.HabilitarCampos(.F.)
663:             THIS.AjustarBotoesPorModo()
664:             THIS.pgf_4c_Paginas.ActivePage = 2

*-- Linhas 673 a 691:
673:         loc_cPK = ""
674: 
675:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
676:             SELECT cursor_4c_Dados
677:             loc_cPK = ALLTRIM(cursor_4c_Dados.pkChaves)
678:         ENDIF
679: 
680:         IF EMPTY(loc_cPK)
681:             MsgAviso("Selecione um registro na lista.")
682:             RETURN
683:         ENDIF
684: 
685:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPK)
686:             THIS.this_oBusinessObject.EditarRegistro()
687:             THIS.BOParaForm()
688:             THIS.this_cPkSelecionado = loc_cPK
689:             THIS.this_cModoAtual     = "ALTERAR"
690:             THIS.HabilitarCampos(.T.)
691:             THIS.AjustarBotoesPorModo()

*-- Linhas 701 a 719:
701:         loc_cPK = ""
702: 
703:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
704:             SELECT cursor_4c_Dados
705:             loc_cPK = ALLTRIM(cursor_4c_Dados.pkChaves)
706:         ENDIF
707: 
708:         IF EMPTY(loc_cPK)
709:             MsgAviso("Selecione um registro na lista.")
710:             RETURN
711:         ENDIF
712: 
713:         loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", ;
714:                                      "Confirmar Exclus" + CHR(227) + "o")
715:         IF !loc_lConfirma
716:             RETURN
717:         ENDIF
718: 
719:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPK)

*-- Linhas 736 a 754:
736:         IF EMPTY(ALLTRIM(loc_cConquilha))
737:             loc_cFiltro = ""
738:         ELSE
739:             loc_cFiltro = "conquilhas LIKE " + EscaparSQL("%" + ALLTRIM(loc_cConquilha) + "%")
740:         ENDIF
741: 
742:         THIS.this_cFiltroBusca = loc_cFiltro
743:         THIS.CarregarLista()
744:     ENDPROC
745: 
746:     *--------------------------------------------------------------------------
747:     * BtnEncerrarClick - Fechar formulario
748:     *--------------------------------------------------------------------------
749:     PROCEDURE BtnEncerrarClick()
750:         THIS.Release()
751:     ENDPROC
752: 
753:     *--------------------------------------------------------------------------
754:     * BtnSalvarClick - Salvar alteracoes (chamado por cmd_4c_Confirmar)


### BO (C:\4c\projeto\app\classes\CNQBO.prg):
*==============================================================================
* CNQBO.prg - Business Object para Conquilhas (CNQ)
* Tabela: SigCdCnq | PK: pkChaves (auto via SQL NEWID)
* Schema: codtams char(4), conquilhas char(10), pkChaves char(20), valors numeric(6,3)
*==============================================================================

DEFINE CLASS CNQBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento com campos da tabela SigCdCnq)
    this_cPkChaves  = ""    && pkChaves   CHAR(20)     - Chave primaria (auto gerado)
    this_cConquilha = ""    && Conquilhas CHAR(10)     - Conquilha
    this_cCodTam    = ""    && Codtams    CHAR(4)      - Codigo Tamanho (Aro) FK->SigCdTam.cods
    this_nValor     = 0     && Valors     NUMERIC(6,3) - Valor

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdCnq"
        THIS.this_cCampoChave = "pkChaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cPkChaves  = TratarNulo(pkChaves,   "C")
                THIS.this_cConquilha = TratarNulo(Conquilhas, "C")
                THIS.this_cCodTam    = TratarNulo(Codtams,    "C")
                THIS.this_nValor     = TratarNulo(Valors,     "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "CNQBO.CarregarDoCursor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarChavePrimaria - Gera chave primaria unica via SQL Server NEWID()
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarChavePrimaria()
        LOCAL loc_cPK, loc_nRes
        loc_cPK = ""

        TRY
            loc_nRes = SQLEXEC(gnConnHandle, "SELECT LEFT(NEWID(), 20) AS PK", "cursor_4c_NewPK")
            IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_NewPK") > 0
                SELECT cursor_4c_NewPK
                loc_cPK = ALLTRIM(cursor_4c_NewPK.PK)
            ENDIF
            IF USED("cursor_4c_NewPK")
                USE IN cursor_4c_NewPK
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao gerar chave prim" + CHR(225) + "ria:" + CHR(13) + loException.Message, "CNQBO.GerarChavePrimaria")
        ENDTRY

        RETURN loc_cPK
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarDuplicidade - Verifica conquilha + codtam duplicados no INSERT
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION VerificarDuplicidade()
        LOCAL loc_cSQL, loc_nRes, loc_lDuplicado
        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdCnq" + ;
                       " WHERE conquilhas = " + EscaparSQL(THIS.this_cConquilha) + ;
                       " AND codtams = " + EscaparSQL(THIS.this_cCodTam)

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dup")
            IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_Dup") > 0
                SELECT cursor_4c_Dup
                loc_lDuplicado = (cursor_4c_Dup.Total > 0)
            ENDIF
            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar duplicidade:" + CHR(13) + loException.Message, "CNQBO.VerificarDuplicidade")
        ENDTRY

        RETURN loc_lDuplicado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cConquilha))
            MsgAviso("Obrigat" + CHR(243) + "rio Informar a Conquilha.")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarDuplicidade()
                MsgAviso("Conquilha j" + CHR(225) + " cadastrada para este tamanho (Aro).")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCdCnq
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cPK
        loc_lSucesso = .F.

        TRY
            loc_cPK = THIS.GerarChavePrimaria()
            IF EMPTY(loc_cPK)
                MostrarErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar chave prim" + CHR(225) + "ria.", "CNQBO.Inserir")
            ELSE
                THIS.this_cPkChaves = loc_cPK

                TEXT TO loc_cSQL TEXTMERGE NOSHOW
                    INSERT INTO SigCdCnq (pkChaves, conquilhas, codtams, valors)
                    VALUES (
                        <<EscaparSQL(THIS.this_cPkChaves)>>,
                        <<EscaparSQL(THIS.this_cConquilha)>>,
                        <<EscaparSQL(THIS.this_cCodTam)>>,
                        <<FormatarNumeroSQL(THIS.this_nValor, 3)>>
                    )
                ENDTEXT

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao inserir conquilha:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "CNQBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigCdCnq
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdCnq
                SET conquilhas = <<EscaparSQL(THIS.this_cConquilha)>>,
                    codtams    = <<EscaparSQL(THIS.this_cCodTam)>>,
                    valors     = <<FormatarNumeroSQL(THIS.this_nValor, 3)>>
                WHERE pkChaves = <<EscaparSQL(THIS.this_cPkChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar conquilha:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "CNQBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigCdCnq
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                DELETE FROM SigCdCnq WHERE pkChaves = <<EscaparSQL(THIS.this_cPkChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir conquilha:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "CNQBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com conquilhas, codtams, valors, pkChaves
    * Ordenado por conquilhas (ordem original do legado)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (conquilhas C(10), codtams C(4), valors N(6,3), pkChaves C(20))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT conquilhas, codtams, valors, pkChaves FROM SigCdCnq"

                IF !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY conquilhas"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        IF USED("cursor_4c_DadosTmp")
                            USE IN cursor_4c_DadosTmp
                        ENDIF
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar conquilhas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar conquilhas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "CNQBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria (pkChaves)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cPkChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT pkChaves, conquilhas, codtams, valors
                FROM SigCdCnq
                WHERE pkChaves = <<EscaparSQL(par_cPkChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Conquilha n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar conquilha:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "CNQBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da chave primaria (para auditoria)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDFUNC

ENDDEFINE

