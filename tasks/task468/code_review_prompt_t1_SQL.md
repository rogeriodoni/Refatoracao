# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TITULOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: BALANCOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: BALANCOS

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
  ControlSource = "crSigCdMrr.balancos"
  ControlSource = "crSigCdMrr.titulos"
  ControlSource = "crSigCdMrr.mapas"
		.AddCursor('SigCdMri','CidChaves','csSigCdMri','Classes',.f.,[Select * From SigCdMri Where Balancos = ?crSigCdMrr.Balancos])
ThisForm.Pagina.Lista.grade.Column3.ControlSource=[IIF(crSigCdMrr.Mapas=2,"MAPA","PLANO")]
		m.lnErro1 = Iif(.poDataMgr.UpDate('crSigCdMrr'),1,-1)
		m.lnErro1 = Iif(.poDataMgr.UpDate('csSigCdMri'),1,-1)
SELECT crSigCdMrr
	SELECT CsSigCdMri
	DELETE ALL
	SELECT crSigCdMrr
	DELETE

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormMrc.prg) - TRECHOS RELEVANTES PARA PASS SQL (1034 linhas total):

*-- Linhas 377 a 395:
377:             .HighlightBackColor = RGB(255, 255, 255)
378:             .HighlightForeColor = RGB(15, 41, 104)
379:             .HighlightStyle     = 2
380:             .DeleteMark         = .F.
381:             .RecordMark         = .F.
382:             .RowHeight          = 16
383:             .ScrollBars         = 2
384:             .GridLines          = 3
385:             .ReadOnly           = .T.
386:             .Visible            = .T.
387:         ENDWITH
388:         *-- ColumnCount FORA de WITH para criar colunas imediatamente (Problema 36)
389:         loc_oPagina.grd_4c_Lista.ColumnCount = 3
390: 
391:         THIS.TornarControlesVisiveis(loc_oPagina)
392:     ENDPROC
393: 
394:     *--------------------------------------------------------------------------
395:     * ConfigurarPaginaDados - Configura Page2: botoes Confirmar/Cancelar,

*-- Linhas 611 a 632:
611:                     loc_oGrid.RecordSource = THIS.this_cCursorDados
612:                     loc_oGrid.ColumnCount  = 3
613: 
614:                     *-- ControlSources APOS RecordSource (Problema 48: auto-bind reseta)
615:                     loc_oGrid.Column1.ControlSource = THIS.this_cCursorDados + ".Balancos"
616:                     loc_oGrid.Column2.ControlSource = THIS.this_cCursorDados + ".Titulos"
617:                     loc_oGrid.Column3.ControlSource = ;
618:                         "IIF(cursor_4c_Dados.Mapas=2,'MAPA','PLANO')"
619: 
620:                     *-- Headers APOS RecordSource (Problema 6/32: VFP reseta headers)
621:                     loc_oGrid.Column1.Header1.Caption = "Demonstrativo"
622:                     loc_oGrid.Column2.Header1.Caption = "T" + CHR(237) + "tulo"
623:                     loc_oGrid.Column3.Header1.Caption = "Impress" + CHR(227) + "o"
624: 
625:                     *-- Larguras conforme legado
626:                     loc_oGrid.Column1.Width = 150
627:                     loc_oGrid.Column2.Width = 290
628:                     loc_oGrid.Column3.Width = 75
629: 
630:                     *-- DynamicForeColor: Mapa de Contas em azul, Plano em preto (legado)
631:                     loc_oGrid.SetAll("DynamicForeColor", ;
632:                         "IIF(cursor_4c_Dados.Mapas=2,RGB(0,0,255),RGB(0,0,0))", ;

*-- Linhas 674 a 692:
674:     ENDPROC
675: 
676:     *--------------------------------------------------------------------------
677:     * BtnIncluirClick - Prepara BO para INSERT e navega para Page2
678:     *--------------------------------------------------------------------------
679:     PROCEDURE BtnIncluirClick()
680:         THIS.this_oBusinessObject.NovoRegistro()
681:         THIS.LimparCampos()
682:         THIS.this_cModoAtual = "INCLUIR"
683:         THIS.HabilitarCampos(.T.)
684:         THIS.AjustarBotoesPorModo()
685:         THIS.AlternarPagina(2)
686:         IF TYPE("THIS.pgf_4c_Paginas.Page2.txt_4c_Balanco") = "O"
687:             THIS.pgf_4c_Paginas.Page2.txt_4c_Balanco.SetFocus
688:         ENDIF
689:     ENDPROC
690: 
691:     *--------------------------------------------------------------------------
692:     * BtnVisualizarClick - Carrega registro selecionado em modo somente leitura

*-- Linhas 699 a 717:
699:         ENDIF
700: 
701:         LOCAL loc_cBalanco
702:         SELECT cursor_4c_Dados
703:         loc_cBalanco = ALLTRIM(cursor_4c_Dados.Balancos)
704: 
705:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cBalanco)
706:             THIS.this_cModoAtual = "VISUALIZAR"
707:             THIS.BOParaForm()
708:             THIS.HabilitarCampos(.F.)
709:             THIS.AjustarBotoesPorModo()
710:             THIS.AlternarPagina(2)
711:             IF TYPE("THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar") = "O"
712:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus
713:             ENDIF
714:         ENDIF
715:     ENDPROC
716: 
717:     *--------------------------------------------------------------------------

*-- Linhas 725 a 743:
725:         ENDIF
726: 
727:         LOCAL loc_cBalanco
728:         SELECT cursor_4c_Dados
729:         loc_cBalanco = ALLTRIM(cursor_4c_Dados.Balancos)
730: 
731:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cBalanco)
732:             THIS.this_oBusinessObject.EditarRegistro()
733:             THIS.this_cModoAtual = "ALTERAR"
734:             THIS.BOParaForm()
735:             THIS.HabilitarCampos(.T.)
736:             THIS.AjustarBotoesPorModo()
737:             THIS.AlternarPagina(2)
738:             IF TYPE("THIS.pgf_4c_Paginas.Page2.txt_4c_Titulo") = "O"
739:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Titulo.SetFocus
740:             ENDIF
741:         ENDIF
742:     ENDPROC
743: 

*-- Linhas 752 a 770:
752:         ENDIF
753: 
754:         LOCAL loc_cBalanco
755:         SELECT cursor_4c_Dados
756:         loc_cBalanco = ALLTRIM(cursor_4c_Dados.Balancos)
757: 
758:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cBalanco)
759:             THIS.this_cModoAtual = "EXCLUIR"
760:             THIS.BOParaForm()
761:             THIS.HabilitarCampos(.F.)
762:             THIS.AjustarBotoesPorModo()
763:             THIS.AlternarPagina(2)
764:             IF TYPE("THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar") = "O"
765:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
766:             ENDIF
767:         ENDIF
768:     ENDPROC
769: 
770:     *--------------------------------------------------------------------------

*-- Linhas 776 a 795:
776:         loc_cBalanco = ""
777: 
778:         TRY
779:             loc_nSQL = SQLEXEC(gnConnHandle, ;
780:                 "SELECT Balancos, Titulos FROM SigCdMrr ORDER BY Balancos", ;
781:                 "cursor_4c_BuscaMrc")
782: 
783:             IF loc_nSQL >= 0
784:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
785:                 IF VARTYPE(loc_oBusca) = "O"
786:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaMrc", "Balancos", "Titulos", ;
787:                         "Buscar Demonstrativo")
788:                     IF loc_oBusca.Mostrar()
789:                         loc_cBalanco = ALLTRIM(loc_oBusca.cCodigoSelecionado)
790:                     ENDIF
791:                     loc_oBusca.Release()
792:                 ENDIF
793:             ELSE
794:                 MsgErro("Erro ao buscar demonstrativos: " + CapturarErroSQL(), "Erro SQL")
795:             ENDIF

*-- Linhas 802 a 820:
802:         ENDIF
803: 
804:         IF !EMPTY(loc_cBalanco) AND USED(THIS.this_cCursorDados)
805:             SELECT cursor_4c_Dados
806:             LOCATE FOR ALLTRIM(Balancos) == loc_cBalanco
807:             THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
808:         ENDIF
809:     ENDPROC
810: 
811:     *--------------------------------------------------------------------------
812:     * BtnEncerrarClick - Fecha o formulario
813:     *--------------------------------------------------------------------------
814:     PROCEDURE BtnEncerrarClick()
815:         THIS.Release()
816:     ENDPROC
817: 
818:     *--------------------------------------------------------------------------
819:     * BtnItensClick - Abre formulario de Itens do Demonstrativo (SigCdCmr)
820:     * Legado: do form SigCdCmr with Thisform,thisform.datasessionid

*-- Linhas 827 a 845:
827:         ENDIF
828: 
829:         LOCAL loc_cBalanco, loc_oItens
830:         SELECT cursor_4c_Dados
831:         loc_cBalanco = ALLTRIM(cursor_4c_Dados.Balancos)
832: 
833:         TRY
834:             loc_oItens = CREATEOBJECT("FormCmr", loc_cBalanco)
835:             IF VARTYPE(loc_oItens) = "O"
836:                 loc_oItens.Show()
837:             ELSE
838:                 MsgErro("Erro ao criar formul" + CHR(225) + "rio de Itens." + CHR(13) + ;
839:                     "VARTYPE retornou: " + VARTYPE(loc_oItens), "Erro")
840:             ENDIF
841:         CATCH TO loc_oErro
842:             LOCAL loc_cMsg
843:             loc_cMsg = "Erro ao abrir Itens do Demonstrativo:" + CHR(13) + CHR(13) + ;
844:                        "Erro: " + loc_oErro.Message + CHR(13) + ;
845:                        "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;


### BO (C:\4c\projeto\app\classes\MrcBO.prg):
*==============================================================================
* MrcBO.prg - Business Object para Cadastro de Demonstrativos
* Tabela principal: SigCdMrr (Demonstrativos)
* Tabela relacionada: SigCdMri (Itens do Demonstrativo)
*==============================================================================
DEFINE CLASS MrcBO AS BusinessBase

    *-- Propriedades da entidade SigCdMrr
    this_cBalanco   = ""   && balancos char(20) - chave primaria
    this_cTitulo    = ""   && titulos  char(40)
    this_nMapa      = 1    && mapas    numeric(1,0): 1=Plano de Contas, 2=Mapa de Contas

    *-- Nome do cursor principal
    this_cCursorDados = "cursor_4c_Dados"

    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdMrr"
        THIS.this_cCampoChave = "Balancos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cBalanco
    ENDFUNC

    *--------------------------------------------------------------------------
    * NovoRegistro - Prepara BO para INSERT
    *--------------------------------------------------------------------------
    PROCEDURE NovoRegistro()
        DODEFAULT()
        THIS.this_cBalanco = ""
        THIS.this_cTitulo  = ""
        THIS.this_nMapa    = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * EditarRegistro - Prepara BO para UPDATE
    *--------------------------------------------------------------------------
    PROCEDURE EditarRegistro()
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cBalanco = TratarNulo(Balancos, "C")
            THIS.this_cTitulo  = TratarNulo(Titulos,  "C")
            THIS.this_nMapa    = TratarNulo(Mapas,    "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida campos obrigatorios antes de salvar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cBalanco))
            THIS.this_cMensagemErro = "Demonstrativo " + CHR(233) + " obrigat" + CHR(243) + "rio."
            MsgAviso(THIS.this_cMensagemErro, "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Seleciona registros de SigCdMrr para a grade
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cWhere = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE Balancos LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                             " OR Titulos LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%")
            ENDIF

            loc_cSQL = "SELECT Balancos, Titulos, Mapas" + ;
                       " FROM SigCdMrr" + ;
                       loc_cWhere + ;
                       " ORDER BY Balancos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar demonstrativos: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao buscar demonstrativos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um demonstrativo pelo codigo (Balancos)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Balancos, Titulos, Mapas" + ;
                       " FROM SigCdMrr" + ;
                       " WHERE Balancos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                THIS.this_cMensagemErro = "Demonstrativo n" + CHR(227) + "o encontrado."
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao carregar demonstrativo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarDuplicidade - Verifica se Balancos ja existe em SigCdMrr
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE VerificarDuplicidade()
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdMrr" + ;
                       " WHERE Balancos = " + EscaparSQL(THIS.this_cBalanco)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupChk")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DupChk") > 0
                SELECT cursor_4c_DupChk
                loc_lExiste = (cursor_4c_DupChk.Total > 0)
            ENDIF

            IF USED("cursor_4c_DupChk")
                USE IN cursor_4c_DupChk
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar duplicidade:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_DupChk")
                USE IN cursor_4c_DupChk
            ENDIF
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo demonstrativo em SigCdMrr (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.VerificarDuplicidade()
                THIS.this_cMensagemErro = "Demonstrativo j" + CHR(225) + " cadastrado."
                MsgAviso(THIS.this_cMensagemErro, "Registro Duplicado")
                loc_lSucesso = .F.
            ELSE
                loc_cSQL = "INSERT INTO SigCdMrr (Balancos, Titulos, Mapas)" + ;
                           " VALUES (" + EscaparSQL(THIS.this_cBalanco) + ;
                           ", " + EscaparSQL(THIS.this_cTitulo) + ;
                           ", " + FormatarNumeroSQL(THIS.this_nMapa) + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao inserir demonstrativo: " + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                ENDIF

                IF USED("cursor_4c_Ins")
                    USE IN cursor_4c_Ins
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inserir demonstrativo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza demonstrativo existente em SigCdMrr (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdMrr" + ;
                       " SET Titulos = " + EscaparSQL(THIS.this_cTitulo) + ;
                       ", Mapas = " + FormatarNumeroSQL(THIS.this_nMapa) + ;
                       " WHERE Balancos = " + EscaparSQL(THIS.this_cBalanco)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar demonstrativo: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao atualizar demonstrativo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui demonstrativo e seus itens (PROTECTED)
    * Cascade: DELETE SigCdMri primeiro, depois SigCdMrr
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- 1. Excluir itens do demonstrativo (SigCdMri) - cascade
            loc_cSQL = "DELETE FROM SigCdMri WHERE Balancos = " + EscaparSQL(THIS.this_cBalanco)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelMri")

            IF USED("cursor_4c_DelMri")
                USE IN cursor_4c_DelMri
            ENDIF

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Erro ao excluir itens: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                loc_lSucesso = .F.
            ELSE
                *-- 2. Excluir o demonstrativo principal (SigCdMrr)
                loc_cSQL = "DELETE FROM SigCdMrr WHERE Balancos = " + EscaparSQL(THIS.this_cBalanco)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelMrr")

                IF USED("cursor_4c_DelMrr")
                    USE IN cursor_4c_DelMrr
                ENDIF

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao excluir demonstrativo: " + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao excluir demonstrativo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_DelMri")
                USE IN cursor_4c_DelMri
            ENDIF
            IF USED("cursor_4c_DelMrr")
                USE IN cursor_4c_DelMrr
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

