# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PKCHAVE' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DESCS

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
  ControlSource = "crSigCdMod.Codigos"
  ControlSource = "crSigCdMod.Descs"
		lcQuery = [Select Descs ] + ;
				    [From SigCdMod ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalBus]) < 1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formmod.prg) - TRECHOS RELEVANTES PARA PASS SQL (856 linhas total):

*-- Linhas 345 a 376:
345:             .HighlightBackColor = RGB(255, 255, 255)
346:             .HighlightForeColor = RGB(15, 41, 104)
347:             .HighlightStyle     = 2
348:             .DeleteMark         = .F.
349:             .RecordMark         = .F.
350:             .RowHeight          = 16
351:             .ScrollBars         = 2
352:             .Visible            = .T.
353: 
354:             .Column1.Width           = 80
355:             .Column1.ControlSource   = "cursor_4c_Dados.Codigos"
356:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
357:             .Column1.Alignment       = 0
358:             .Column1.ReadOnly        = .T.
359: 
360:             .Column2.Width           = 150
361:             .Column2.ControlSource   = "cursor_4c_Dados.Descs"
362:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
363:             .Column2.Alignment       = 0
364:             .Column2.ReadOnly        = .T.
365:         ENDWITH
366: 
367:         THIS.TornarControlesVisiveis(loc_oPagina)
368:     ENDPROC
369: 
370:     *==========================================================================
371:     * ConfigurarPaginaDados - Configura Page2: botoes, labels e textboxes
372:     * Campos: Codigos (ReadOnly, auto-gerado) e Descs (editavel)
373:     *==========================================================================
374:     PROTECTED PROCEDURE ConfigurarPaginaDados()
375:         LOCAL loc_oPagina
376:         loc_oPagina = THIS.pgf_4c_Paginas.Page2

*-- Linhas 681 a 700:
681:                     loc_oGrid.ColumnCount = 2
682:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
683: 
684:                     loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.Codigos"
685:                     loc_oGrid.Column2.ControlSource   = "cursor_4c_Dados.Descs"
686: 
687:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
688:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
689: 
690:                     loc_oGrid.Column1.Width = 80
691:                     loc_oGrid.Column2.Width = 150
692: 
693:                     THIS.FormatarGridLista(loc_oGrid)
694:                     loc_lResultado = .T.
695:                 ENDIF
696:             ENDIF
697: 
698:         CATCH TO loException
699:             MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message, ;
700:                 "Formmod.CarregarLista")

*-- Linhas 727 a 745:
727:             RETURN
728:         ENDIF
729: 
730:         SELECT cursor_4c_Dados
731:         loc_cPkChave = ALLTRIM(cursor_4c_Dados.pkchave)
732: 
733:         IF EMPTY(loc_cPkChave)
734:             MsgAviso("Nenhum registro selecionado.", "Visualizar")
735:             RETURN
736:         ENDIF
737: 
738:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPkChave)
739:             THIS.this_cModoAtual = "VISUALIZAR"
740:             THIS.BOParaForm()
741:             THIS.HabilitarCampos(.F.)
742:             THIS.AlternarPagina(2)
743:         ENDIF
744:     ENDPROC
745: 

*-- Linhas 755 a 773:
755:             RETURN
756:         ENDIF
757: 
758:         SELECT cursor_4c_Dados
759:         loc_cPkChave = ALLTRIM(cursor_4c_Dados.pkchave)
760: 
761:         IF EMPTY(loc_cPkChave)
762:             MsgAviso("Nenhum registro selecionado.", "Alterar")
763:             RETURN
764:         ENDIF
765: 
766:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPkChave)
767:             THIS.this_oBusinessObject.EditarRegistro()
768:             THIS.this_cModoAtual = "ALTERAR"
769:             THIS.BOParaForm()
770:             THIS.HabilitarCampos(.T.)
771:             THIS.AlternarPagina(2)
772:         ENDIF
773:     ENDPROC

*-- Linhas 786 a 804:
786:             RETURN
787:         ENDIF
788: 
789:         SELECT cursor_4c_Dados
790:         loc_cPkChave   = ALLTRIM(cursor_4c_Dados.pkchave)
791:         loc_cCodigo    = ALLTRIM(cursor_4c_Dados.Codigos)
792:         loc_cDescricao = ALLTRIM(cursor_4c_Dados.Descs)
793: 
794:         IF EMPTY(loc_cPkChave)
795:             MsgAviso("Nenhum registro selecionado.", "Excluir")
796:             RETURN
797:         ENDIF
798: 
799:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da modalidade:" + CHR(13) + ;
800:                 loc_cCodigo + " - " + loc_cDescricao + "?", "Excluir Modalidade")
801:             RETURN
802:         ENDIF
803: 
804:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPkChave)

*-- Linhas 826 a 845:
826:             loc_oGrid.ColumnCount = 2
827:             loc_oGrid.RecordSource = "cursor_4c_Dados"
828: 
829:             loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.Codigos"
830:             loc_oGrid.Column2.ControlSource   = "cursor_4c_Dados.Descs"
831: 
832:             loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
833:             loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
834: 
835:             loc_oGrid.Column1.Width = 80
836:             loc_oGrid.Column2.Width = 150
837: 
838:             THIS.FormatarGridLista(loc_oGrid)
839:         ENDIF
840:     ENDPROC
841: 
842:     *==========================================================================
843:     * Destroy - Libera recursos ao fechar o formulario
844:     *==========================================================================
845:     PROCEDURE Destroy()


### BO (C:\4c\projeto\app\classes\modBO.prg):
*=============================================================================
* modBO.prg - Business Object de Modalidades
* Tabela: SigCdMod
* Schema: pkchave C(20) PK, Codigos C(2), Descs C(30)
*=============================================================================
DEFINE CLASS modBO AS BusinessBase

    *-- Chave primaria
    this_cPkChave = ""

    *-- Campos da tabela SigCdMod
    this_cCodigos = ""
    this_cDescs   = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdMod"
        THIS.this_cCampoChave = "pkchave"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cPkChave
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Retorna lista de modalidades no cursor_4c_Dados
    * par_cFiltro: "" = todos, ou texto para filtrar por Descs
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cFiltro) # "C"
                par_cFiltro = ""
            ENDIF

            loc_cSQL = "SELECT pkchave, Codigos, Descs FROM SigCdMod"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + ;
                    " WHERE Descs LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%")
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY Descs"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar modalidades:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro:" + CHR(13) + loException.Message, "modBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega modalidade pela chave primaria (pkchave)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cPkChave)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cPkChave) # "C" OR EMPTY(ALLTRIM(par_cPkChave))
                loc_lSucesso = .F.
            ELSE
                loc_cSQL = "SELECT pkchave, Codigos, Descs FROM SigCdMod" + ;
                           " WHERE pkchave = " + EscaparSQL(ALLTRIM(par_cPkChave))

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

                IF loc_nResult >= 0
                    IF RECCOUNT("cursor_4c_Carrega") > 0
                        loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                        THIS.this_lNovoRegistro = .F.
                    ENDIF
                ELSE
                    MostrarErro("Erro ao carregar modalidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro:" + CHR(13) + loException.Message, "modBO.CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cPkChave = TratarNulo(pkchave, "C")
            THIS.this_cCodigos = TratarNulo(Codigos, "C")
            THIS.this_cDescs   = TratarNulo(Descs,   "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarProximoCodigo - Gera proximo codigo sequencial C(2)
    * Equivalente ao fGerUniqueKey('SIGCDMOD') do legado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarProximoCodigo()
        LOCAL loc_cSQL, loc_nResult, loc_nProximo, loc_cCodigo
        loc_nProximo = 1
        loc_cCodigo  = ""

        TRY
            loc_cSQL = "SELECT ISNULL(MAX(CAST(LTRIM(RTRIM(Codigos)) AS INT)), 0) AS MaxCod" + ;
                       " FROM SigCdMod"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxCod")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_MaxCod") > 0
                SELECT cursor_4c_MaxCod
                loc_nProximo = NVL(cursor_4c_MaxCod.MaxCod, 0) + 1
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao gerar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "modBO.GerarProximoCodigo")
        ENDTRY

        IF USED("cursor_4c_MaxCod")
            USE IN cursor_4c_MaxCod
        ENDIF

        RETURN ALLTRIM(STR(loc_nProximo, 2))
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cDescs))
                MsgAviso("Descri" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida!", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF THIS.this_lNovoRegistro
                    loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdMod" + ;
                               " WHERE Descs = " + EscaparSQL(ALLTRIM(THIS.this_cDescs))
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaMod")
                    IF loc_nResult >= 0
                        SELECT cursor_4c_ValidaMod
                        IF cursor_4c_ValidaMod.Total > 0
                            MsgAviso("Descri" + CHR(231) + CHR(227) + "o j" + CHR(225) + " cadastrada!", ;
                                "Aten" + CHR(231) + CHR(227) + "o")
                        ELSE
                            loc_lSucesso = .T.
                        ENDIF
                    ELSE
                        MostrarErro("Erro ao validar modalidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                    IF USED("cursor_4c_ValidaMod")
                        USE IN cursor_4c_ValidaMod
                    ENDIF
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro:" + CHR(13) + loException.Message, "modBO.ValidarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdMod
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ELSE
                IF EMPTY(ALLTRIM(THIS.this_cPkChave))
                    THIS.this_cPkChave = ALLTRIM(SYS(2015))
                ENDIF

                IF EMPTY(ALLTRIM(THIS.this_cCodigos))
                    THIS.this_cCodigos = THIS.GerarProximoCodigo()
                ENDIF

                loc_cSQL = "INSERT INTO SigCdMod (pkchave, Codigos, Descs)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cPkChave) + ", " + ;
                           EscaparSQL(THIS.this_cCodigos) + ", " + ;
                           EscaparSQL(THIS.this_cDescs)   + ")"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao inserir modalidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro:" + CHR(13) + loException.Message, "modBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdMod (apenas Descs pode ser alterada)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ELSE
                loc_cSQL = "UPDATE SigCdMod" + ;
                           " SET Descs = " + EscaparSQL(THIS.this_cDescs) + ;
                           " WHERE pkchave = " + EscaparSQL(THIS.this_cPkChave)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao atualizar modalidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro:" + CHR(13) + loException.Message, "modBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigCdMod
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cPkChave))
                MsgAviso("Nenhum registro selecionado para exclus" + CHR(227) + "o!", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_cSQL = "DELETE FROM SigCdMod" + ;
                           " WHERE pkchave = " + EscaparSQL(THIS.this_cPkChave)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao excluir modalidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro:" + CHR(13) + loException.Message, "modBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

