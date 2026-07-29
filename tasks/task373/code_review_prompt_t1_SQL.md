# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-TABELA] Tabela 'SigCdCmp' usada no BO migrado mas NAO aparece no codigo original. Pode ser tabela inventada/confundida.
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'QTD' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODS

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
  ControlSource = "CrSigCdCmp.cods"
  ControlSource = "CrSigCdCmp.descs"
Select CrSigCdCmp
Select CrSigCdCmp
Select CrSigCdCmp

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formcmp.prg) - TRECHOS RELEVANTES PARA PASS SQL (994 linhas total):

*-- Linhas 395 a 451:
395: 
396:             *-- Cursor placeholder com mesmos campos de cursor_4c_Dados retornado por Buscar()
397:             SET NULL ON
398:             CREATE CURSOR cursor_4c_Dados (cods C(10), descs C(60))
399:             SET NULL OFF
400: 
401:             *-- Grid de lista
402:             *-- Top = 117 (canonico: 88+29), Left = 12
403:             loc_oPagina.AddObject("grd_4c_Lista", "Grid")
404:             WITH loc_oPagina.grd_4c_Lista
405:                 .Top                = 117
406:                 .Left               = 12
407:                 .Width              = 937
408:                 .Height             = 470
409:                 .FontName           = "Verdana"
410:                 .FontSize           = 8
411:                 .ForeColor          = RGB(90, 90, 90)
412:                 .BackColor          = RGB(255, 255, 255)
413:                 .GridLineColor      = RGB(238, 238, 238)
414:                 .GridLines          = 3
415:                 .HighlightBackColor = RGB(255, 255, 255)
416:                 .HighlightForeColor = RGB(15, 41, 104)
417:                 .HighlightStyle     = 2
418:                 .DeleteMark         = .F.
419:                 .RecordMark         = .F.
420:                 .RowHeight          = 16
421:                 .ScrollBars         = 2
422:                 .Visible            = .T.
423:             ENDWITH
424: 
425:             *-- RecordSource e ColumnCount FORA do WITH (evita "Unknown member COLUMN1")
426:             loc_oPagina.grd_4c_Lista.ColumnCount  = 2
427:             loc_oPagina.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
428:             loc_oPagina.grd_4c_Lista.ColumnCount  = 2
429: 
430:             *-- ControlSources APOS RecordSource (evita auto-bind por ordem de campos)
431:             WITH loc_oPagina.grd_4c_Lista
432:                 .Column1.ControlSource   = "cursor_4c_Dados.cods"
433:                 .Column1.Width           = 90
434:                 .Column1.Header1.Caption = "C" + CHR(243) + "digo"
435: 
436:                 .Column2.ControlSource   = "cursor_4c_Dados.descs"
437:                 .Column2.Width           = 337
438:                 .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
439:             ENDWITH
440: 
441:             THIS.FormatarGridLista(loc_oPagina.grd_4c_Lista)
442:             THIS.TornarControlesVisiveis(loc_oPagina)
443: 
444:         CATCH TO loException
445:             MostrarErro(loException, "Formcmp.ConfigurarPaginaLista")
446:         ENDTRY
447:     ENDPROC
448: 
449:     *--------------------------------------------------------------------------
450:     * ConfigurarPaginaDados - Adiciona botoes Confirmar/Cancelar e campos na Page2
451:     *--------------------------------------------------------------------------

*-- Linhas 601 a 625:
601:             IF !THIS.this_oBusinessObject.Buscar("")
602:                 loc_lResultado = .F.
603:             ELSE
604:                 *-- Reconectar ControlSources apos ZAP+APPEND (evita reset de headers)
605:                 WITH loc_oGrid
606:                     .Column1.ControlSource   = "cursor_4c_Dados.cods"
607:                     .Column1.Width           = 90
608:                     .Column1.Header1.Caption = "C" + CHR(243) + "digo"
609: 
610:                     .Column2.ControlSource   = "cursor_4c_Dados.descs"
611:                     .Column2.Width           = 337
612:                     .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
613:                 ENDWITH
614: 
615:                 loc_oGrid.Refresh()
616:                 loc_lResultado = .T.
617:             ENDIF
618: 
619:         CATCH TO loException
620:             MostrarErro(loException, "Formcmp.CarregarLista")
621:             loc_lResultado = .F.
622:         ENDTRY
623: 
624:         RETURN loc_lResultado
625:     ENDPROC

*-- Linhas 762 a 780:
762:         ENDIF
763: 
764:         TRY
765:             SELECT cursor_4c_Dados
766:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
767: 
768:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
769:                 THIS.BOParaForm()
770:                 THIS.this_cModoAtual = "VISUALIZAR"
771:                 THIS.HabilitarCampos(.F.)
772:                 THIS.AlternarPagina(2)
773:                 *-- Foco no Confirmar (Salva.SetFocus no legado - modo consulta)
774:                 IF VARTYPE(THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva) = "O"
775:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva.cmd_4c_Confirmar.SetFocus()
776:                 ENDIF
777:             ENDIF
778:         CATCH TO loException
779:             MostrarErro(loException, "Formcmp.BtnVisualizarClick")
780:         ENDTRY

*-- Linhas 791 a 809:
791:         ENDIF
792: 
793:         TRY
794:             SELECT cursor_4c_Dados
795:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
796: 
797:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
798:                 THIS.this_oBusinessObject.EditarRegistro()
799:                 THIS.BOParaForm()
800:                 THIS.this_cModoAtual = "ALTERAR"
801:                 THIS.HabilitarCampos(.T.)
802:                 THIS.AlternarPagina(2)
803:                 *-- Foco na descricao (ALTERAR: Get_Desc.SetFocus no legado)
804:                 IF VARTYPE(THIS.pgf_4c_Paginas.Page2.txt_4c_Desc) = "O"
805:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Desc.SetFocus()
806:                 ENDIF
807:             ENDIF
808:         CATCH TO loException
809:             MostrarErro(loException, "Formcmp.BtnAlterarClick")

*-- Linhas 820 a 838:
820:             RETURN
821:         ENDIF
822: 
823:         SELECT cursor_4c_Dados
824:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
825: 
826:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro '" + loc_cCodigo + "'?", ;
827:                         "Excluir Compra Para")
828:             RETURN
829:         ENDIF
830: 
831:         TRY
832:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
833:                 IF THIS.this_oBusinessObject.Excluir()
834:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
835:                     THIS.CarregarLista()
836:                 ENDIF
837:             ENDIF
838:         CATCH TO loException

*-- Linhas 855 a 874:
855:                 loc_oBusca.Show()
856: 
857:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCmp")
858:                     SELECT cursor_4c_BuscaCmp
859:                     loc_cFiltro = "cods = " + EscaparSQL(ALLTRIM(cursor_4c_BuscaCmp.cods))
860:                 ENDIF
861: 
862:                 loc_oBusca.Release()
863:             ENDIF
864: 
865:             IF USED("cursor_4c_BuscaCmp")
866:                 USE IN cursor_4c_BuscaCmp
867:             ENDIF
868: 
869:             IF !EMPTY(loc_cFiltro)
870:                 THIS.this_oBusinessObject.Buscar(loc_cFiltro)
871:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
872:             ENDIF
873: 
874:         CATCH TO loException


### BO (C:\4c\projeto\app\classes\cmpBO.prg):
*==============================================================================
* cmpBO.prg - Business Object para Compra Para
* Data: 2026-07-29
* Tabela: SigCdCmp | PK: cods
*==============================================================================

DEFINE CLASS cmpBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento com campos da tabela SigCdCmp)
    this_cCodigo    = ""    && cods       CHAR - C" + CHR(243) + "digo (PK)
    this_cDescricao = ""    && descs      CHAR - Descri" + CHR(231) + CHR(227) + "o
    this_cIdChaves  = ""    && cIdChaves  CHAR - Chave " + CHR(250) + "nica UUID

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdCmp"
        THIS.this_cCampoChave = "cods"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
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
                THIS.this_cCodigo    = TratarNulo(cods,      "C")
                THIS.this_cDescricao = TratarNulo(descs,     "C")
                THIS.this_cIdChaves  = TratarNulo(cIdChaves, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "cmpBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida campos obrigatorios antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido, loc_nResultado, loc_cSQL
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCodigo))
            MsgAviso("C" + CHR(243) + "digo obrigat" + CHR(243) + "rio!")
            loc_lValido = .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cDescricao))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o obrigat" + CHR(243) + "ria!")
            loc_lValido = .F.
        ENDIF

        *-- Verificar duplicidade apenas em novo registro
        IF loc_lValido AND THIS.this_lNovoRegistro
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdCmp WHERE cods = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDup")
            IF loc_nResultado >= 0
                IF USED("cursor_4c_ChkDup") AND cursor_4c_ChkDup.qtd > 0
                    MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!")
                    loc_lValido = .F.
                ENDIF
                IF USED("cursor_4c_ChkDup")
                    USE IN cursor_4c_ChkDup
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCdCmp
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cIdChaves
        loc_lSucesso = .F.

        TRY
            loc_cIdChaves = ALLTRIM(fUniqueIds())

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdCmp (cods, descs, cIdChaves)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigo)>>,
                    <<EscaparSQL(THIS.this_cDescricao)>>,
                    <<EscaparSQL(loc_cIdChaves)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.this_cIdChaves = loc_cIdChaves
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir compra para:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "cmpBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigCdCmp
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdCmp
                SET descs = <<EscaparSQL(THIS.this_cDescricao)>>
                WHERE cods = <<EscaparSQL(THIS.this_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar compra para:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "cmpBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigCdCmp
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                DELETE FROM SigCdCmp WHERE cods = <<EscaparSQL(THIS.this_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir compra para:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "cmpBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com cods, descs
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Sem conexao: criar cursor vazio para nao bloquear o grid
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    CREATE CURSOR cursor_4c_Dados (cods C(10), descs C(60))
                ENDIF
                loc_lSucesso = .T.
            ENDIF

            loc_cSQL = "SELECT cods, descs FROM SigCdCmp"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY cods"

            *-- Protecao de grid: se cursor ja esta aberto (grid vinculado), usar ZAP+APPEND
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
                    MostrarErro("Erro ao buscar compra para:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar compra para:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "cmpBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT cods, descs, cIdChaves
                FROM SigCdCmp
                WHERE cods = <<EscaparSQL(par_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Compra Para n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar compra para:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "cmpBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

