# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-TABELA] Tabela 'SigCdFAPP' usada no BO migrado mas NAO aparece no codigo original. Pode ser tabela inventada/confundida.

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


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormFAPP.prg) - TRECHOS RELEVANTES PARA PASS SQL (863 linhas total):

*-- Linhas 338 a 370:
338:             .HighlightBackColor = RGB(255, 255, 255)
339:             .HighlightForeColor = RGB(15, 41, 104)
340:             .HighlightStyle     = 2
341:             .DeleteMark         = .F.
342:             .RecordMark         = .F.
343:             .RowHeight          = 16
344:             .ScrollBars         = 2
345: 
346:             WITH .Column1
347:                 .Width           = 100
348:                 .Header1.Caption = "C" + CHR(243) + "digo"
349:                 .ControlSource   = "cursor_4c_Dados.cods"
350:             ENDWITH
351: 
352:             WITH .Column2
353:                 .Width           = 787
354:                 .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
355:                 .ControlSource   = "cursor_4c_Dados.descs"
356:             ENDWITH
357:         ENDWITH
358: 
359:         THIS.TornarControlesVisiveis(loc_oPagina)
360:     ENDPROC
361: 
362:     *==========================================================================
363:     * ConfigurarPaginaDados - Configura Page2 com containers de edicao
364:     * Completo: container base (BotoesAcao) + campos cods e descs
365:     *==========================================================================
366:     PROTECTED PROCEDURE ConfigurarPaginaDados()
367:         LOCAL loc_oPagina
368:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
369: 
370:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 523 a 542:
523:                 IF VARTYPE(loc_oGrid) = "O"
524:                     loc_oGrid.ColumnCount        = 2
525:                     loc_oGrid.RecordSource       = "cursor_4c_Dados"
526:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
527:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
528:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
529:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
530:                     THIS.FormatarGridLista(loc_oGrid)
531:                 ENDIF
532:             ENDIF
533: 
534:         CATCH TO loc_oErro
535:             MostrarErro("Erro ao carregar lista:" + CHR(13) + ;
536:                 loc_oErro.Message + CHR(13) + ;
537:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
538:                 "FormFAPP.CarregarLista")
539:         ENDTRY
540: 
541:         RETURN loc_lSucesso
542:     ENDPROC

*-- Linhas 688 a 706:
688:         loc_cCodigo = ""
689: 
690:         IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
691:             SELECT cursor_4c_Dados
692:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
693:         ENDIF
694: 
695:         IF EMPTY(loc_cCodigo)
696:             MsgAviso("Selecione um registro para visualizar!")
697:             RETURN
698:         ENDIF
699: 
700:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
701:             THIS.this_cModoAtual = "VISUALIZAR"
702:             THIS.BOParaForm()
703:             THIS.HabilitarCampos(.F.)
704:             THIS.AjustarBotoesPorModo()
705:             THIS.pgf_4c_Paginas.ActivePage = 2
706:         ENDIF

*-- Linhas 714 a 732:
714:         loc_cCodigo = ""
715: 
716:         IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
717:             SELECT cursor_4c_Dados
718:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
719:         ENDIF
720: 
721:         IF EMPTY(loc_cCodigo)
722:             MsgAviso("Selecione um registro para alterar!")
723:             RETURN
724:         ENDIF
725: 
726:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
727:             THIS.this_oBusinessObject.EditarRegistro()
728:             THIS.this_cModoAtual = "ALTERAR"
729:             THIS.BOParaForm()
730:             THIS.HabilitarCampos(.T.)
731:             THIS.AjustarBotoesPorModo()
732:             THIS.pgf_4c_Paginas.ActivePage = 2

*-- Linhas 742 a 760:
742:         loc_lConfirmar = .F.
743: 
744:         IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
745:             SELECT cursor_4c_Dados
746:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
747:         ENDIF
748: 
749:         IF EMPTY(loc_cCodigo)
750:             MsgAviso("Selecione um registro para excluir!")
751:             RETURN
752:         ENDIF
753: 
754:         loc_lConfirmar = MsgConfirma("Deseja excluir o registro '" + loc_cCodigo + "'?")
755:         IF !loc_lConfirmar
756:             RETURN
757:         ENDIF
758: 
759:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
760:             IF THIS.this_oBusinessObject.Excluir()

*-- Linhas 777 a 796:
777:         IF EMPTY(ALLTRIM(loc_cValor))
778:             THIS.CarregarLista()
779:         ELSE
780:             loc_cFiltro = "(cods LIKE " + EscaparSQL(ALLTRIM(loc_cValor) + "%") + ;
781:                 " OR descs LIKE " + EscaparSQL("%" + ALLTRIM(loc_cValor) + "%") + ")"
782:             THIS.CarregarLista(loc_cFiltro)
783:         ENDIF
784:     ENDPROC
785: 
786:     *==========================================================================
787:     * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo atual
788:     *==========================================================================
789:     PROTECTED PROCEDURE AjustarBotoesPorModo()
790:         LOCAL loc_oCnt, loc_lNoLista, loc_oErro
791:         loc_lNoLista = (THIS.this_cModoAtual = "LISTA")
792: 
793:         TRY
794:             loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
795:             loc_oCnt.cmd_4c_Incluir.Enabled    = loc_lNoLista
796:             loc_oCnt.cmd_4c_Visualizar.Enabled = loc_lNoLista


### BO (C:\4c\projeto\app\classes\FAPPBO.prg):
*==============================================================================
* FAPPBO.PRG
* Business Object para FAPP (SIGCDFAPP)
*
* Tabela Principal : SigCdFAPP - Cadastro de FAPP
*                                (cods char, descs char)
*
* NOTA: O SIGCDFAPP.SCX original estava vazio (form sem campos nem codigo).
*       Estrutura inferida pela convencao SigCd* (cods PK + descs descricao).
*       Revisar nomes de colunas e tamanhos ao confirmar schema real.
*==============================================================================

DEFINE CLASS FAPPBO AS BusinessBase

    *-- Propriedades da entidade (SigCdFAPP)
    this_cCods  = ""   && cods CHAR - Codigo (PK)
    this_cDescs = ""   && descs CHAR - Descricao

    *==========================================================================
    * Init - Inicializa Business Object
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdFAPP"
            THIS.this_cCampoChave = "cods"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "FAPPBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna valor da chave primaria para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCods)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCods  = TratarNulo(cods,  "C")
                THIS.this_cDescs = TratarNulo(descs, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "FAPPBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida dados antes de salvar
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCods)
            MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarCodigoExistente(THIS.this_cCods)
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cDescs)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * VerificarCodigoExistente - Verifica se cods ja existe no banco
    *==========================================================================
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdFAPP" + ;
                " WHERE cods = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkFapp")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkFapp")
                SELECT cursor_4c_ChkFapp
                loc_lExiste = (cursor_4c_ChkFapp.qtd > 0)
                USE IN cursor_4c_ChkFapp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "FAPPBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *==========================================================================
    * Inserir - Insere novo registro na tabela SigCdFAPP
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdFAPP (cods, descs)
                VALUES (
                    <<EscaparSQL(THIS.this_cCods)>>,
                    <<EscaparSQL(THIS.this_cDescs)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir FAPP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao inserir:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "FAPPBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdFAPP
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdFAPP
                SET descs = <<EscaparSQL(THIS.this_cDescs)>>
                WHERE cods = <<EscaparSQL(THIS.this_cCods)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar FAPP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao atualizar:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "FAPPBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdFAPP
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdFAPP WHERE cods = " + EscaparSQL(THIS.this_cCods)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir FAPP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao excluir:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "FAPPBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com cods, descs
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (cods C(20), descs C(60))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT cods, descs FROM SigCdFAPP"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY cods"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        SET NULL ON
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        SET NULL OFF
                        IF USED("cursor_4c_DadosTmp")
                            USE IN cursor_4c_DadosTmp
                        ENDIF
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar FAPP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar FAPP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "FAPPBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (cods)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cods, descs FROM SigCdFAPP" + ;
                " WHERE cods = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("FAPP n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar FAPP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao carregar:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "FAPPBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

