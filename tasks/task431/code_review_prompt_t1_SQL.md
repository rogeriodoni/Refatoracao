# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DOPES, CIDAS

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
  ControlSource = "CrSigCdFrt.Valors"
  ControlSource = "crSigCdFrt.cidas"
			lcSql = [Select * From SigOpFrt Where Dopes = ']+ThisForm.pDopes+[']
		lcSql = [Select distinct Cidades From Cep ]
		ThisForm.Podatamg2.Sqlexecute(lcsql,'TmpCep')
Select CrSigCdFrt
		lcSql = [Select * From SigCdFrt Where Cidas = ']+ThisForm.Pagina.Dados.GetCidade.Value+[']
		lcSql = [Select * From SigOpFrt Where Cidas = ']+ThisForm.Pagina.Dados.GetCidade.Value+[' And Dopes = ']+ThisForm.pDopes+[' ]
	If ThisForm.Podatamgr.Sqlexecute(lcsql,'TmpFrete') > 0 And ;

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormFre.prg) - TRECHOS RELEVANTES PARA PASS SQL (1167 linhas total):

*-- Linhas 395 a 413:
395:             .Left               = 12
396:             .Width              = 970
397:             .Height             = 470
398:             .DeleteMark         = .F.
399:             .RecordMark         = .F.
400:             .GridLines          = 3
401:             .RowHeight          = 16
402:             .ScrollBars         = 2
403:             .HighlightStyle     = 2
404:             .HighlightBackColor = RGB(255, 255, 255)
405:             .HighlightForeColor = RGB(15, 41, 104)
406:             .GridLineColor      = RGB(238, 238, 238)
407:             .BackColor          = RGB(255, 255, 255)
408:             .FontName           = "Verdana"
409:             .FontSize           = 8
410:             .Column1.Header1.Caption = "Cidade"
411:             .Column1.Width           = 400
412:             .Column2.Header1.Caption = "Valor do Frete"
413:             .Column2.Width           = 120

*-- Linhas 509 a 527:
509:         ENDWITH
510: 
511:         *-- TextBox Cidade (GetCidade: Top=145, Left=359, Width=220, compensado +29 = 174)
512:         *-- ControlSource legado: crSigCdFrt.cidas | Format="K!" (uppercase)
513:         loc_oPagina.AddObject("txt_4c_Cidade", "TextBox")
514:         WITH loc_oPagina.txt_4c_Cidade
515:             .Value         = ""
516:             .Top           = 174
517:             .Left          = 359
518:             .Width         = 220
519:             .Height        = 25
520:             .MaxLength     = 30
521:             .SpecialEffect = 1
522:             .FontName      = "Tahoma"
523:             .FontSize      = 8
524:             .ForeColor     = RGB(0, 0, 0)
525:             .BackColor     = RGB(255, 255, 255)
526:             .Themes        = .F.
527:             .ReadOnly      = .F.

*-- Linhas 571 a 638:
571: 
572:     *===========================================================================
573:     * CarregarTmpCep - Carrega cursor TmpCep com cidades do banco de dados
574:     * Substitui: poDataMg2.SqlExecute + CREATE CURSOR TmpCep do legado
575:     * Exibir btnAguarde durante carga (fidelidade UX ao legado)
576:     *===========================================================================
577:     PROTECTED PROCEDURE CarregarTmpCep()
578:         LOCAL loc_nResult, loc_oPagina
579: 
580:         TRY
581:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
582: 
583:             IF USED("TmpCep")
584:                 USE IN TmpCep
585:             ENDIF
586: 
587:             *-- Exibir indicador de progresso (equivalente ao btnAguarde do legado)
588:             IF VARTYPE(loc_oPagina) = "O" AND ;
589:                PEMSTATUS(loc_oPagina, "cmd_4c_BtnAguarde", 5)
590:                 loc_oPagina.cmd_4c_BtnAguarde.Visible = .T.
591:                 THIS.Refresh()
592:             ENDIF
593: 
594:             *-- Tentar carregar cidades do banco Cep
595:             SET NULL ON
596:             CREATE CURSOR TmpCep (Cidades C(30))
597:             SET NULL OFF
598: 
599:             loc_nResult = SQLEXEC(gnConnHandle, ;
600:                 "SELECT DISTINCT Cidades FROM Cep ORDER BY Cidades", ;
601:                 "cursor_4c_TmpCepLoad")
602: 
603:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_TmpCepLoad") > 0
604:                 SELECT cursor_4c_TmpCepLoad
605:                 SCAN
606:                     INSERT INTO TmpCep VALUES (ALLTRIM(cursor_4c_TmpCepLoad.Cidades))
607:                 ENDSCAN
608:             ENDIF
609: 
610:             IF USED("cursor_4c_TmpCepLoad")
611:                 USE IN cursor_4c_TmpCepLoad
612:             ENDIF
613: 
614:             *-- Indexar para busca rapida no lookup de GetCidade
615:             IF USED("TmpCep") AND RECCOUNT("TmpCep") > 0
616:                 SELECT TmpCep
617:                 INDEX ON Cidades TAG Cidades
618:             ENDIF
619: 
620:         CATCH TO loException
621:             *-- Em caso de falha, garantir cursor vazio (sem bloquear abertura do form)
622:             IF !USED("TmpCep")
623:                 CREATE CURSOR TmpCep (Cidades C(30))
624:             ENDIF
625:             IF USED("cursor_4c_TmpCepLoad")
626:                 USE IN cursor_4c_TmpCepLoad
627:             ENDIF
628:         ENDTRY
629: 
630:         *-- Ocultar indicador de progresso
631:         IF VARTYPE(loc_oPagina) = "O" AND ;
632:            PEMSTATUS(loc_oPagina, "cmd_4c_BtnAguarde", 5)
633:             loc_oPagina.cmd_4c_BtnAguarde.Visible = .F.
634:         ENDIF
635:     ENDPROC
636: 
637:     *===========================================================================
638:     * CarregarLista - Carrega dados no grid da Page1 via FreBO.Buscar()

*-- Linhas 650 a 669:
650:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
651:                         loc_oGrid.ColumnCount = 2
652:                         loc_oGrid.RecordSource          = "cursor_4c_Dados"
653:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cidas"
654:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.valors"
655:                         *-- Redefinir headers apos RecordSource (auto-bind os sobrescreve)
656:                         loc_oGrid.Column1.Header1.Caption = "Cidade"
657:                         loc_oGrid.Column1.Width           = 400
658:                         loc_oGrid.Column2.Header1.Caption = "Valor do Frete"
659:                         loc_oGrid.Column2.Width           = 120
660:                         loc_oGrid.Column2.Alignment       = 1
661:                         THIS.FormatarGridLista(loc_oGrid)
662:                         loc_lResultado = .T.
663:                     ENDIF
664:                 ENDIF
665:             ENDIF
666:         CATCH TO loException
667:             MostrarErro(loException, "FormFre.CarregarLista")
668:         ENDTRY
669: 

*-- Linhas 869 a 887:
869:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
870:                 MsgAviso("Nenhum registro selecionado.", "Visualizar")
871:             ELSE
872:                 SELECT cursor_4c_Dados
873:                 IF EMPTY(THIS.this_oBusinessObject.this_cDopes)
874:                     loc_cCodigo = ALLTRIM(cursor_4c_Dados.cidas)
875:                 ELSE
876:                     loc_cCodigo = ALLTRIM(cursor_4c_Dados.cidchaves)
877:                 ENDIF
878: 
879:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
880:                     THIS.this_cModoAtual = "VISUALIZAR"
881:                     IF PEMSTATUS(THIS, "BOParaForm", 5)
882:                         THIS.BOParaForm()
883:                     ENDIF
884:                     IF PEMSTATUS(THIS, "HabilitarCampos", 5)
885:                         THIS.HabilitarCampos(.F.)
886:                     ENDIF
887:                     IF PEMSTATUS(THIS, "AjustarBotoesPorModo", 5)

*-- Linhas 912 a 930:
912:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
913:                 MsgAviso("Nenhum registro selecionado.", "Alterar")
914:             ELSE
915:                 SELECT cursor_4c_Dados
916:                 IF EMPTY(THIS.this_oBusinessObject.this_cDopes)
917:                     loc_cCodigo = ALLTRIM(cursor_4c_Dados.cidas)
918:                 ELSE
919:                     loc_cCodigo = ALLTRIM(cursor_4c_Dados.cidchaves)
920:                 ENDIF
921: 
922:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
923:                     THIS.this_oBusinessObject.EditarRegistro()
924:                     THIS.this_cModoAtual = "ALTERAR"
925:                     IF PEMSTATUS(THIS, "BOParaForm", 5)
926:                         THIS.BOParaForm()
927:                     ENDIF
928:                     IF PEMSTATUS(THIS, "HabilitarCampos", 5)
929:                         THIS.HabilitarCampos(.T.)
930:                     ENDIF

*-- Linhas 955 a 973:
955:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
956:                 MsgAviso("Nenhum registro selecionado.", "Excluir")
957:             ELSE
958:                 SELECT cursor_4c_Dados
959:                 loc_cCidade = ALLTRIM(cursor_4c_Dados.cidas)
960:                 IF EMPTY(THIS.this_oBusinessObject.this_cDopes)
961:                     loc_cCodigo = loc_cCidade
962:                 ELSE
963:                     loc_cCodigo = ALLTRIM(cursor_4c_Dados.cidchaves)
964:                 ENDIF
965: 
966:                 IF MsgConfirma("Excluir o frete da cidade " + CHR(34) + loc_cCidade + CHR(34) + "?", ;
967:                     "Confirmar Exclus" + CHR(227) + "o")
968:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
969:                         IF THIS.this_oBusinessObject.Excluir()
970:                             MsgInfo("Frete exclu" + CHR(237) + "do com sucesso.", "Sucesso")
971:                             THIS.CarregarLista()
972:                         ENDIF
973:                     ENDIF

*-- Linhas 993 a 1012:
993:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
994:                     loc_oGrid.ColumnCount = 2
995:                     loc_oGrid.RecordSource          = "cursor_4c_Dados"
996:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cidas"
997:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.valors"
998:                     *-- Redefinir headers apos RecordSource
999:                     loc_oGrid.Column1.Header1.Caption = "Cidade"
1000:                     loc_oGrid.Column1.Width           = 400
1001:                     loc_oGrid.Column2.Header1.Caption = "Valor do Frete"
1002:                     loc_oGrid.Column2.Width           = 120
1003:                     loc_oGrid.Column2.Alignment       = 1
1004:                     THIS.FormatarGridLista(loc_oGrid)
1005:                 ENDIF
1006:             ENDIF
1007:         CATCH TO loException
1008:             MostrarErro(loException, "FormFre.BtnBuscarClick")
1009:         ENDTRY
1010:     ENDPROC
1011: 
1012:     *===========================================================================


### BO (C:\4c\projeto\app\classes\FreBO.prg):
*==============================================================================
* FreBO.prg - Business Object: Fretes por Cidade
*==============================================================================
* Tabelas:
*   SigCdFrt  - modo global (this_cDopes vazio): PK = cidas
*   SigOpFrt  - modo operacional (this_cDopes preenchido): PK = cidchaves
*==============================================================================

DEFINE CLASS FreBO AS BusinessBase

    *-- Campos compartilhados (SigCdFrt e SigOpFrt)
    this_cCidade     = ""   && cidas       CHAR(30)       - nome da cidade
    this_nFrete      = 0    && valors      NUMERIC(11,2)  - valor do frete

    *-- Campos exclusivos modo operacional (SigOpFrt)
    this_cDopes      = ""   && dopes       CHAR(20)       - tipo de operacao (vazio = modo global)
    this_cChaveUnica = ""   && cidchaves   CHAR(20)       - chave unica PK no modo operacional

    *===========================================================================
    * Init - Inicializa BO no modo global (SigCdFrt / PK = cidas)
    *        Para modo operacional: setar this_cDopes apos Init()
    *===========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdFrt"
            THIS.this_cCampoChave = "cidas"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "FreBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *   Modo global:      cidas (cidade)
    *   Modo operacional: cidchaves (chave unica gerada)
    *===========================================================================
    FUNCTION ObterChavePrimaria()
        IF EMPTY(THIS.this_cDopes)
            RETURN ALLTRIM(THIS.this_cCidade)
        ELSE
            RETURN ALLTRIM(THIS.this_cChaveUnica)
        ENDIF
    ENDFUNC

    *===========================================================================
    * Buscar - Lista registros no cursor cursor_4c_Dados
    *   par_cFiltro: filtro opcional em cidas (LIKE)
    *===========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cDopes)
                *-- Modo global: SigCdFrt
                IF EMPTY(par_cFiltro)
                    loc_cSQL = "SELECT cidas, valors FROM SigCdFrt ORDER BY cidas"
                ELSE
                    loc_cSQL = "SELECT cidas, valors FROM SigCdFrt" + ;
                        " WHERE cidas LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                        " ORDER BY cidas"
                ENDIF
            ELSE
                *-- Modo operacional: SigOpFrt filtrado por dopes
                IF EMPTY(par_cFiltro)
                    loc_cSQL = "SELECT cidas, cidchaves, dopes, valors FROM SigOpFrt" + ;
                        " WHERE dopes = " + EscaparSQL(THIS.this_cDopes) + ;
                        " ORDER BY cidas"
                ELSE
                    loc_cSQL = "SELECT cidas, cidchaves, dopes, valors FROM SigOpFrt" + ;
                        " WHERE dopes = " + EscaparSQL(THIS.this_cDopes) + ;
                        " AND cidas LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                        " ORDER BY cidas"
                ENDIF
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar fretes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FreBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * CarregarPorCodigo - Carrega registro por PK no cursor cursor_4c_Carrega
    *   Modo global:      par_cCodigo = cidas
    *   Modo operacional: par_cCodigo = cidchaves
    *===========================================================================
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cDopes)
                loc_cSQL = "SELECT cidas, valors FROM SigCdFrt" + ;
                    " WHERE cidas = " + EscaparSQL(par_cCodigo)
            ELSE
                loc_cSQL = "SELECT cidas, cidchaves, dopes, valors FROM SigOpFrt" + ;
                    " WHERE cidchaves = " + EscaparSQL(par_cCodigo)
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FreBO.CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * CarregarDoCursor - Mapeia cursor para propriedades do BO
    *===========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidade = TratarNulo(cidas, "C")
                THIS.this_nFrete  = TratarNulo(valors, "N")
                IF !EMPTY(THIS.this_cDopes)
                    THIS.this_cChaveUnica = TratarNulo(cidchaves, "C")
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FreBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * Inserir - INSERT em SigCdFrt (global) ou SigOpFrt (operacional) [PROTECTED]
    *===========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cChave
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cDopes)
                *-- Modo global: INSERT em SigCdFrt
                loc_cSQL = "INSERT INTO SigCdFrt (cidas, valors) VALUES (" + ;
                    EscaparSQL(THIS.this_cCidade) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nFrete) + ")"
            ELSE
                *-- Modo operacional: INSERT em SigOpFrt com nova cidchaves
                loc_cChave = THIS.GerarChaveUnica()
                THIS.this_cChaveUnica = loc_cChave
                loc_cSQL = "INSERT INTO SigOpFrt (cidas, cidchaves, dopes, valors) VALUES (" + ;
                    EscaparSQL(THIS.this_cCidade) + ", " + ;
                    EscaparSQL(loc_cChave) + ", " + ;
                    EscaparSQL(THIS.this_cDopes) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nFrete) + ")"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir frete:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FreBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * Atualizar - UPDATE em SigCdFrt (global) ou SigOpFrt (operacional) [PROTECTED]
    *===========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cDopes)
                *-- Modo global: UPDATE SigCdFrt por cidas (PK nao alteravel, so valors)
                loc_cSQL = "UPDATE SigCdFrt SET" + ;
                    " valors = " + FormatarNumeroSQL(THIS.this_nFrete) + ;
                    " WHERE cidas = " + EscaparSQL(THIS.this_cCidade)
            ELSE
                *-- Modo operacional: UPDATE SigOpFrt por cidchaves (PK)
                loc_cSQL = "UPDATE SigOpFrt SET" + ;
                    " cidas = " + EscaparSQL(THIS.this_cCidade) + "," + ;
                    " valors = " + FormatarNumeroSQL(THIS.this_nFrete) + ;
                    " WHERE cidchaves = " + EscaparSQL(THIS.this_cChaveUnica)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar frete:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FreBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * ExecutarExclusao - DELETE em SigCdFrt (global) ou SigOpFrt (operacional) [PROTECTED]
    *===========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cDopes)
                loc_cSQL = "DELETE FROM SigCdFrt WHERE cidas = " + EscaparSQL(THIS.this_cCidade)
            ELSE
                loc_cSQL = "DELETE FROM SigOpFrt WHERE cidchaves = " + EscaparSQL(THIS.this_cChaveUnica)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir frete:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FreBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * GerarChaveUnica - Gera nova chave unica (20 chars) para SigOpFrt.cidchaves
    *===========================================================================
    PROTECTED FUNCTION GerarChaveUnica()
        LOCAL loc_cChave, loc_nResultado
        loc_cChave = ""

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT LEFT(REPLACE(CONVERT(varchar(36), NEWID()), '-', ''), 20) AS nova_chave", ;
                "cursor_4c_NewId")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_NewId") > 0
                SELECT cursor_4c_NewId
                loc_cChave = ALLTRIM(nova_chave)
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FreBO.GerarChaveUnica")
        ENDTRY

        IF USED("cursor_4c_NewId")
            USE IN cursor_4c_NewId
        ENDIF

        RETURN loc_cChave
    ENDFUNC

ENDDEFINE

