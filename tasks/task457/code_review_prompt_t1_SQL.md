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
  ControlSource = "crSigCdLct.cods"
  ControlSource = "crSigCdLct.descs"
Select CrSigCdLct
Select CrSigCdLct
Select CrSigCdLct

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formlct.prg) - TRECHOS RELEVANTES PARA PASS SQL (887 linhas total):

*-- Linhas 340 a 358:
340:             .HighlightBackColor = RGB(255, 255, 255)
341:             .HighlightForeColor = RGB(15, 41, 104)
342:             .HighlightStyle     = 2
343:             .DeleteMark         = .F.
344:             .RecordMark         = .F.
345:             .RowHeight          = 16
346:             .ScrollBars         = 2
347:             .Visible            = .T.
348:         ENDWITH
349:         WITH loc_oGrid.Column1
350:             .Header1.Caption = "C" + CHR(243) + "digo"
351:             .Width           = 90
352:             .ReadOnly        = .T.
353:         ENDWITH
354:         WITH loc_oGrid.Column2
355:             .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
356:             .Width           = 337
357:             .ReadOnly        = .T.
358:         ENDWITH

*-- Linhas 521 a 540:
521:                     IF PEMSTATUS(loc_oPg1, "grd_4c_Lista", 5)
522:                         loc_oPg1.grd_4c_Lista.ColumnCount = 2
523:                         loc_oPg1.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
524:                         loc_oPg1.grd_4c_Lista.Column1.ControlSource = "cursor_4c_Dados.cods"
525:                         loc_oPg1.grd_4c_Lista.Column2.ControlSource = "cursor_4c_Dados.descs"
526:                         loc_oPg1.grd_4c_Lista.Column1.Header1.Caption = "C" + CHR(243) + "digo"
527:                         loc_oPg1.grd_4c_Lista.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
528:                         THIS.FormatarGridLista(loc_oPg1.grd_4c_Lista)
529:                     ENDIF
530: 
531:                     loc_lResultado = .T.
532:                 ENDIF
533:             ENDIF
534: 
535:         CATCH TO loc_oErro
536:             MsgErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, "Formlct.CarregarLista")
537:             loc_lResultado = .F.
538:         ENDTRY
539: 
540:         RETURN loc_lResultado

*-- Linhas 626 a 644:
626:         loc_cCodigo = ""
627: 
628:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
629:             SELECT cursor_4c_Dados
630:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
631:         ENDIF
632: 
633:         IF EMPTY(loc_cCodigo)
634:             MsgAviso("Selecione um registro na lista.", "Visualizar")
635:             RETURN
636:         ENDIF
637: 
638:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
639:             THIS.BOParaForm()
640:             THIS.this_cModoAtual = "VISUALIZAR"
641:             THIS.AjustarBotoesPorModo()
642:             THIS.pgf_4c_Paginas.ActivePage = 2
643:         ELSE
644:             MsgErro("Erro ao carregar o registro selecionado.", "Visualizar")

*-- Linhas 654 a 672:
654:         loc_cCodigo = ""
655: 
656:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
657:             SELECT cursor_4c_Dados
658:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
659:         ENDIF
660: 
661:         IF EMPTY(loc_cCodigo)
662:             MsgAviso("Selecione um registro na lista.", "Alterar")
663:             RETURN
664:         ENDIF
665: 
666:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
667:             THIS.this_oBusinessObject.EditarRegistro()
668:             THIS.BOParaForm()
669:             THIS.this_cModoAtual = "ALTERAR"
670:             THIS.AjustarBotoesPorModo()
671:             THIS.pgf_4c_Paginas.ActivePage = 2
672:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Desc", 5)

*-- Linhas 686 a 704:
686:         loc_lResultado = .F.
687: 
688:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
689:             SELECT cursor_4c_Dados
690:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
691:         ENDIF
692: 
693:         IF EMPTY(loc_cCodigo)
694:             MsgAviso("Selecione um registro na lista.", "Excluir")
695:             RETURN
696:         ENDIF
697: 
698:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro '" + loc_cCodigo + "'?", "Excluir")
699:             RETURN
700:         ENDIF
701: 
702:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
703:             loc_lResultado = THIS.this_oBusinessObject.Excluir()
704:             IF loc_lResultado

*-- Linhas 720 a 762:
720:         loc_cCodAtual = ""
721: 
722:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
723:             SELECT cursor_4c_Dados
724:             loc_cCodAtual = ALLTRIM(cursor_4c_Dados.cods)
725:         ENDIF
726: 
727:         TRY
728:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
729:                 "SigCdLct", "cursor_4c_BuscaLct", "cods", loc_cCodAtual, ;
730:                 "Lan" + CHR(231) + "amentos")
731: 
732:             IF VARTYPE(loc_oBusca) = "O"
733:                 IF !loc_oBusca.this_lAchouRegistro
734:                     loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
735:                     loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
736:                     loc_oBusca.Show()
737:                 ENDIF
738: 
739:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLct")
740:                     SELECT cursor_4c_BuscaLct
741:                     IF !EOF("cursor_4c_BuscaLct")
742:                         THIS.this_oBusinessObject.Buscar(ALLTRIM(cursor_4c_BuscaLct.cods))
743:                         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
744:                         loc_oPg1.grd_4c_Lista.ColumnCount = 2
745:                         loc_oPg1.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
746:                         loc_oPg1.grd_4c_Lista.Column1.ControlSource = "cursor_4c_Dados.cods"
747:                         loc_oPg1.grd_4c_Lista.Column2.ControlSource = "cursor_4c_Dados.descs"
748:                         loc_oPg1.grd_4c_Lista.Column1.Header1.Caption = "C" + CHR(243) + "digo"
749:                         loc_oPg1.grd_4c_Lista.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
750:                         THIS.FormatarGridLista(loc_oPg1.grd_4c_Lista)
751:                     ENDIF
752:                 ENDIF
753: 
754:                 loc_oBusca.Release()
755:             ENDIF
756: 
757:         CATCH TO loc_oErro
758:             MsgErro(loc_oErro.Message, "Formlct.BtnBuscarClick")
759:         ENDTRY
760: 
761:         IF USED("cursor_4c_BuscaLct")
762:             USE IN cursor_4c_BuscaLct


### BO (C:\4c\projeto\app\classes\lctBO.prg):
*==============================================================================
* lctBO.prg - Business Object: Cadastro de Lancamentos
* Tabela: SigCdLct
* PK: cidchaves (char 20, gerada por GerarIdUnico())
* Chave negocio: cods (char 10, unica, validada no Inserir)
*==============================================================================
DEFINE CLASS lctBO AS BusinessBase

    *-- Propriedades da tabela SigCdLct
    this_cCods      = ""   && char(10) - Codigo de lancamento (chave negocio)
    this_cCidChaves = ""   && char(20) - Chave primaria interna (PK)
    this_cDescs     = ""   && char(40) - Descricao do lancamento

    *-- Configuracao do BO
    this_cTabela     = "SigCdLct"
    this_cCampoChave = "cidchaves"

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdLct"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MsgErro(loException.Message, "lctBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCods      = TratarNulo(cods,      "C")
                THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
                THIS.this_cDescs     = TratarNulo(descs,     "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "lctBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
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

    *--------------------------------------------------------------------------
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdLct" + ;
                " WHERE cods = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkLct")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkLct")
                SELECT cursor_4c_ChkLct
                loc_lExiste = (cursor_4c_ChkLct.qtd > 0)
                USE IN cursor_4c_ChkLct
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "lctBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cNovaChave
        loc_lSucesso = .F.

        TRY
            loc_cNovaChave = fUniqueIds()
            THIS.this_cCidChaves = loc_cNovaChave

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdLct (cods, cidchaves, descs)
                VALUES (
                    <<EscaparSQL(THIS.this_cCods)>>,
                    <<EscaparSQL(loc_cNovaChave)>>,
                    <<EscaparSQL(THIS.this_cDescs)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir lan" + CHR(231) + "amento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "lctBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdLct
                SET descs = <<EscaparSQL(THIS.this_cDescs)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar lan" + CHR(231) + "amento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "lctBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdLct WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir lan" + CHR(231) + "amento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "lctBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (cods C(10), descs C(40))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT cods, descs FROM SigCdLct"

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
                        MostrarErro("Erro ao buscar lan" + CHR(231) + "amentos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar lan" + CHR(231) + "amentos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "lctBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cods, cidchaves, descs FROM SigCdLct" + ;
                " WHERE cods = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Lan" + CHR(231) + "amento n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar lan" + CHR(231) + "amento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "lctBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

