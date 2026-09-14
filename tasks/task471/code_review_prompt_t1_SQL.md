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
  ControlSource = "crSigCdMtv.Cods"
  ControlSource = "crSigCdMtv.Descs"
		lcQuery = [Select Cods ] + ;
				    [From SigCdMtv ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalBus]) < 1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormMTV.prg) - TRECHOS RELEVANTES PARA PASS SQL (873 linhas total):

*-- Linhas 336 a 354:
336:             .HighlightBackColor = RGB(255, 255, 255)
337:             .HighlightForeColor = RGB(15, 41, 104)
338:             .HighlightStyle     = 2
339:             .DeleteMark         = .F.
340:             .RecordMark         = .F.
341:             .RowHeight          = 16
342:             .ScrollBars         = 2
343:             .ReadOnly           = .T.
344:             .Visible            = .T.
345:         ENDWITH
346: 
347:         THIS.TornarControlesVisiveis(loc_oPagina)
348:     ENDPROC
349: 
350:     *--------------------------------------------------------------------------
351:     * ConfigurarPaginaDados - Configura Page2: botoes Salvar/Cancelar e campos
352:     *--------------------------------------------------------------------------
353:     PROTECTED PROCEDURE ConfigurarPaginaDados()
354:         LOCAL loc_oPagina

*-- Linhas 504 a 526:
504:                 loc_oGrid.ColumnCount = 2
505:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
506: 
507:                 loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.Cods"
508:                 loc_oGrid.Column1.Width           = 80
509:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
510: 
511:                 loc_oGrid.Column2.ControlSource   = "cursor_4c_Dados.Descs"
512:                 loc_oGrid.Column2.Width           = 150
513:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
514: 
515:                 THIS.FormatarGridLista(loc_oGrid)
516:                 loc_lResultado = .T.
517:             ENDIF
518:         CATCH TO loException
519:             MsgErro("Erro ao carregar lista de Motivos:" + CHR(13) + loException.Message, "Erro")
520:         ENDTRY
521: 
522:         RETURN loc_lResultado
523:     ENDPROC
524: 
525:     *--------------------------------------------------------------------------
526:     * BtnEncerrarClick - Fecha o formulario

*-- Linhas 616 a 634:
616:             RETURN
617:         ENDIF
618: 
619:         SELECT cursor_4c_Dados
620:         IF EOF("cursor_4c_Dados")
621:             MsgAviso("Selecione um registro para visualizar.", "Aten" + CHR(231) + CHR(227) + "o")
622:             RETURN
623:         ENDIF
624: 
625:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.Cods)
626: 
627:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
628:             THIS.this_cModoAtual = "VISUALIZAR"
629:             THIS.BOParaForm()
630:             THIS.HabilitarCampos(.F.)
631:             THIS.AlternarPagina(2)
632:         ELSE
633:             MsgErro("Erro ao carregar registro para visualiza" + CHR(231) + CHR(227) + "o.", "Erro")
634:         ENDIF

*-- Linhas 646 a 664:
646:             RETURN
647:         ENDIF
648: 
649:         SELECT cursor_4c_Dados
650:         IF EOF("cursor_4c_Dados")
651:             MsgAviso("Selecione um registro para alterar.", "Aten" + CHR(231) + CHR(227) + "o")
652:             RETURN
653:         ENDIF
654: 
655:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.Cods)
656: 
657:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
658:             THIS.this_oBusinessObject.EditarRegistro()
659:             THIS.this_cModoAtual = "ALTERAR"
660:             THIS.BOParaForm()
661:             THIS.HabilitarCampos(.T.)
662:             THIS.AlternarPagina(2)
663:             THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.SetFocus()
664:         ELSE

*-- Linhas 679 a 697:
679:             RETURN
680:         ENDIF
681: 
682:         SELECT cursor_4c_Dados
683:         IF EOF("cursor_4c_Dados")
684:             MsgAviso("Selecione um registro para excluir.", "Aten" + CHR(231) + CHR(227) + "o")
685:             RETURN
686:         ENDIF
687: 
688:         loc_cCodigo   = ALLTRIM(cursor_4c_Dados.Cods)
689:         loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro '" + ;
690:                         loc_cCodigo + "'?", "Excluir Motivo")
691: 
692:         IF loc_lConfirma
693:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
694:                 IF THIS.this_oBusinessObject.Excluir()
695:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.", "Sucesso")
696:                     THIS.CarregarLista()
697:                 ELSE

*-- Linhas 718 a 740:
718:                 loc_oGrid.ColumnCount = 2
719:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
720: 
721:                 loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.Cods"
722:                 loc_oGrid.Column1.Width           = 80
723:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
724: 
725:                 loc_oGrid.Column2.ControlSource   = "cursor_4c_Dados.Descs"
726:                 loc_oGrid.Column2.Width           = 150
727:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
728: 
729:                 THIS.FormatarGridLista(loc_oGrid)
730: 
731:                 IF RECCOUNT("cursor_4c_Dados") = 0
732:                     MsgAviso("Nenhum registro encontrado.", "Buscar")
733:                 ENDIF
734: 
735:                 loc_lResultado = .T.
736:             ELSE
737:                 MsgAviso("Nenhum registro encontrado.", "Buscar")
738:             ENDIF
739:         CATCH TO loException
740:             MsgErro("Erro ao buscar:" + CHR(13) + loException.Message, "Erro")


### BO (C:\4c\projeto\app\classes\MTVBO.prg):
*==============================================================================
* MTVBO.prg - Business Object para Motivos
* Tabela: SigCdMtv
* Migrado de: SIGCDMTV.SCX (frmcadastro)
*==============================================================================
DEFINE CLASS MTVBO AS BusinessBase

    *-- Propriedades de dados
    this_cCodigo    = ""
    this_cDescricao = ""

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdMtv"
        THIS.this_cCampoChave = "Cods"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do cursor para o BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo    = TratarNulo(Cods,  "C")
            THIS.this_cDescricao = TratarNulo(Descs, "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega lista de registros no cursor_4c_Dados
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT Cods, Descs" + ;
                       " FROM SigCdMtv" + ;
                       " ORDER BY Cods"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = "SELECT Cods, Descs" + ;
                           " FROM SigCdMtv" + ;
                           " WHERE Cods LIKE " + EscaparSQL(par_cFiltro + "%") + ;
                           " OR Descs LIKE " + EscaparSQL("%" + par_cFiltro + "%") + ;
                           " ORDER BY Cods"
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar motivos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo codigo (chave primaria)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT Cods, Descs" + ;
                       " FROM SigCdMtv" + ;
                       " WHERE Cods = " + EscaparSQL(par_cCodigo)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdMtv (PROTECTED - chamado por Salvar)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado, loc_lDuplicado
        loc_lResultado = .F.
        loc_lDuplicado = .F.

        TRY
            *-- Verificar duplicidade de codigo (RETURN inside TRY proibido - usar flag)
            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdMtv" + ;
                       " WHERE Cods = " + EscaparSQL(THIS.this_cCodigo)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Check")
                TABLEREVERT(.T., "cursor_4c_Check")
                USE IN cursor_4c_Check
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Check")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Check") > 0
                SELECT cursor_4c_Check
                IF cursor_4c_Check.Total > 0
                    MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!")
                    loc_lDuplicado = .T.
                ENDIF
            ENDIF
            IF USED("cursor_4c_Check")
                USE IN cursor_4c_Check
            ENDIF

            IF !loc_lDuplicado
                loc_cSQL = "INSERT INTO SigCdMtv (Cods, Descs)" + ;
                           " VALUES (" + EscaparSQL(THIS.this_cCodigo) + ;
                           ", " + EscaparSQL(THIS.this_cDescricao) + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao inserir motivo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
            IF USED("cursor_4c_Check")
                USE IN cursor_4c_Check
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdMtv (PROTECTED - chamado por Salvar)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdMtv SET" + ;
                       " Descs = " + EscaparSQL(THIS.this_cDescricao) + ;
                       " WHERE Cods = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar motivo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigCdMtv (PROTECTED - chamado por Excluir)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdMtv" + ;
                       " WHERE Cods = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir motivo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE

