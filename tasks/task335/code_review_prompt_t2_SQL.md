# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, CODTAMS, IF
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, CODTAMS, IF
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, CODTAMS, IF

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
  DeleteMark = .F.
  AllowCellSelection = .T.
		lcSql = [Select Dpros, pvens, pcuss From SigCdPro Where Cpros = ']+pcPro+[']
		.PodataMgr.Sqlexecute(lcSql,'LocalPro')
		lcSql = [Select a.*, Space(40) as Descs From SigPrTam a Where a.cPros = ']+pcPro+[']
		.Podatamgr.Sqlexecute(lcSql,'CrSigPrTam')
Select crSigPrTam
	.Column1.ControlSource = [crSigPrTam.CodTams]
	.Column2.ControlSource = [crSigPrTam.Descs]
	.Column3.ControlSource = [crSigPrTam.PesoMs]
	.Column4.ControlSource = [crSigPrTam.Percs]
	.Column5.ControlSource = [crSigPrTam.Valor]
	.Column6.ControlSource = [crSigPrTam.DiasPrz]
			Select a.CodTams ;
			  From crSigPrTam a ;
			Select crAux
			Select crSigPrTam
			Select a.CodTams ;
			  From crSigPrTam a ;
			Select crAux
Select crSigPrTam
	Delete
		Select crSigPrTam
Select crSigPrTam
	Insert Into crSigPrTam (cPros, CidChaves) Values (crSigCdPro.cPros,fUniqueIds())
Select crSigPrTam

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprtam.prg) - TRECHOS RELEVANTES PARA PASS SQL (1042 linhas total):

*-- Linhas 404 a 428:
404:             .HighlightBackColor  = RGB(255, 255, 255)
405:             .HighlightForeColor  = RGB(15, 41, 104)
406:             .HighlightStyle      = 2
407:             .DeleteMark          = .F.
408:             .RecordMark          = .F.
409:             .RowHeight           = 17
410:             .ScrollBars          = 2
411:             .AllowHeaderSizing   = .F.
412:             .AllowRowSizing      = .F.
413:             .AllowCellSelection  = .T.
414:             .Panel               = 1
415: 
416:             *-- Column1: codtams - Tam. (Width=38 do SCX)
417:             WITH .Column1
418:                 .Width           = 38
419:                 .Movable         = .F.
420:                 .Resizable       = .F.
421:                 .Header1.Caption = "Tam."
422:                 .Header1.FontName = "Tahoma"
423:                 .Header1.FontSize = 8
424:                 .Header1.Alignment = 2
425:                 .Header1.ForeColor = RGB(90, 90, 90)
426:             ENDWITH
427: 
428:             *-- Column2: descs - Descricao (Width=216 do SCX)

*-- Linhas 535 a 558:
535:         loc_oGrd.RecordSource = loc_cCursor
536: 
537:         WITH loc_oGrd
538:             .Column1.ControlSource   = loc_cCursor + ".codtams"
539:             .Column2.ControlSource   = loc_cCursor + ".descs"
540:             .Column3.ControlSource   = loc_cCursor + ".pesoms"
541:             .Column4.ControlSource   = loc_cCursor + ".percs"
542:             .Column5.ControlSource   = loc_cCursor + ".valor"
543:             .Column6.ControlSource   = loc_cCursor + ".diasprz"
544: 
545:             *-- Redefinir cabecalhos apos RecordSource (VFP9 os reseta)
546:             .Column1.Header1.Caption = "Tam."
547:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
548:             .Column3.Header1.Caption = "Peso M" + CHR(233) + "dio"
549:             .Column4.Header1.Caption = "Percentual"
550:             .Column5.Header1.Caption = "Valor"
551:             .Column6.Header1.Caption = "Entrega"
552:         ENDWITH
553:     ENDPROC
554: 
555:     *==========================================================================
556:     * ConfigurarBINDEVENTs - Liga eventos aos controles via BINDEVENT
557:     * Botoes: Inserir / Excluir / Encerrar
558:     * Grid Column1/2: lookup SigCdTam por codigo ou descricao

*-- Linhas 662 a 680:
662: 
663:     *==========================================================================
664:     * BtnExcluirClick - Remove linha corrente do grid de tamanhos
665:     * Equiv. cmdExcluir.Click legado: DELETE + Skip/Skip-1
666:     *==========================================================================
667:     PROCEDURE BtnExcluirClick()
668:         THIS.this_lHouveExcl = .T.
669:         IF THIS.this_oBusinessObject.ExcluirLinhaGrid(THIS.this_cCPros)
670:             THIS.grd_4c_Dados.Refresh()
671:         ENDIF
672:     ENDPROC
673: 
674:     *==========================================================================
675:     * BtnEncerrarClick - Valida, salva e fecha o form
676:     * Equiv. cmdSair.Click legado: valida CodTams preenchido, libera ParentForm
677:     * Em modo INSERIR/ALTERAR: persiste via SalvarTamanhos() no SQL Server
678:     *==========================================================================
679:     PROCEDURE BtnEncerrarClick()
680:         IF THIS.cmd_4c_Inserir.Visible OR THIS.cmd_4c_Excluir.Visible

*-- Linhas 710 a 734:
710:         loc_cIdChavesAtual = ""
711: 
712:         IF USED(loc_cCursor) AND !EOF(loc_cCursor)
713:             SELECT (loc_cCursor)
714:             loc_cIdChavesAtual = ALLTRIM(cidchaves)
715:         ENDIF
716: 
717:         IF EMPTY(loc_cCodTams)
718:             IF USED(loc_cCursor) AND !EOF(loc_cCursor)
719:                 SELECT (loc_cCursor)
720:                 REPLACE codtams WITH "", descs WITH ""
721:             ENDIF
722:             THIS.grd_4c_Dados.Refresh()
723:             RETURN
724:         ENDIF
725: 
726:         THIS.AbrirBuscaTamanho("cods", loc_cCodTams, loc_cIdChavesAtual)
727:     ENDPROC
728: 
729:     *==========================================================================
730:     * GrdColuna2KeyPress - KeyPress em Column2.Text1 (descricao do tamanho)
731:     * Apenas ativo quando Column1 (codtams) estiver vazio (legado: When retorna .F. se col1 preenchida)
732:     * ENTER/TAB/F4: busca SigCdTam por descs LIKE; abre picker
733:     *==========================================================================
734:     PROCEDURE GrdColuna2KeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 749 a 773:
749:         loc_cIdChavesAtual = ""
750: 
751:         IF USED(loc_cCursor) AND !EOF(loc_cCursor)
752:             SELECT (loc_cCursor)
753:             loc_cIdChavesAtual = ALLTRIM(cidchaves)
754:         ENDIF
755: 
756:         IF EMPTY(loc_cDescs)
757:             IF USED(loc_cCursor) AND !EOF(loc_cCursor)
758:                 SELECT (loc_cCursor)
759:                 REPLACE codtams WITH "", descs WITH ""
760:             ENDIF
761:             THIS.grd_4c_Dados.Refresh()
762:             RETURN
763:         ENDIF
764: 
765:         THIS.AbrirBuscaTamanho("descs", loc_cDescs, loc_cIdChavesAtual)
766:     ENDPROC
767: 
768:     *==========================================================================
769:     * GrdColuna4KeyPress - KeyPress em Column4.Text1 (percentual)
770:     * ENTER/TAB: calcula Valor = PVens + (PVens * Percs/100)
771:     * Equiv. Column4.Text1.Valid legado
772:     *==========================================================================
773:     PROCEDURE GrdColuna4KeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 789 a 807:
789:                          loc_nPercs, THIS.this_oBusinessObject.this_nPVens)
790: 
791:         IF USED(loc_cCursor) AND !EOF(loc_cCursor)
792:             SELECT (loc_cCursor)
793:             REPLACE valor WITH loc_nValor
794:         ENDIF
795:         THIS.grd_4c_Dados.Refresh()
796:     ENDPROC
797: 
798:     *==========================================================================
799:     * GrdColuna5KeyPress - KeyPress em Column5.Text1 (valor)
800:     * ENTER/TAB: calcula Percs = ((Valor - PVens) / PVens) * 100
801:     * Valida PVens > 0; equiv. Column5.Text1.Valid legado
802:     *==========================================================================
803:     PROCEDURE GrdColuna5KeyPress(par_nKeyCode, par_nShiftAltCtrl)
804: 
805:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
806:             RETURN
807:         ENDIF

*-- Linhas 818 a 848:
818:         IF THIS.this_oBusinessObject.this_nPVens = 0
819:             MsgAviso("Favor informar o Pre" + CHR(231) + "o de Venda do Produto.", "Aviso")
820:             IF USED(loc_cCursor) AND !EOF(loc_cCursor)
821:                 SELECT (loc_cCursor)
822:                 REPLACE valor WITH 0
823:             ENDIF
824:             THIS.grd_4c_Dados.Column5.Text1.Value = 0
825:             THIS.grd_4c_Dados.Refresh()
826:             RETURN
827:         ENDIF
828: 
829:         loc_nPercs = THIS.this_oBusinessObject.CalcularPercentualPorValor( ;
830:                          loc_nValor, THIS.this_oBusinessObject.this_nPVens)
831: 
832:         IF USED(loc_cCursor) AND !EOF(loc_cCursor)
833:             SELECT (loc_cCursor)
834:             REPLACE percs WITH loc_nPercs
835:         ENDIF
836:         THIS.grd_4c_Dados.Refresh()
837:     ENDPROC
838: 
839:     *==========================================================================
840:     * AbrirBuscaTamanho - Helper: abre FormBuscaAuxiliar para SigCdTam
841:     * par_cCampoBusca:    "cods" ou "descs" (campo de busca na tabela)
842:     * par_cValorBusca:    valor a pesquisar
843:     * par_cIdChavesAtual: cidchaves da linha corrente (exclusao na validacao dup.)
844:     * Apos selecao: verifica duplicidade, aplica codtams+descs no cursor do grid
845:     *==========================================================================
846:     PROTECTED PROCEDURE AbrirBuscaTamanho(par_cCampoBusca, par_cValorBusca, par_cIdChavesAtual)
847:         LOCAL loc_oBusca, loc_cCodSel, loc_cDescSel, loc_cCursor
848:         loc_cCursor  = THIS.this_oBusinessObject.this_cCursorDados

*-- Linhas 868 a 886:
868: 
869:         IF loc_oBusca.this_lSelecionou
870:             IF USED("cursor_4c_BuscaTam") AND !EOF("cursor_4c_BuscaTam")
871:                 SELECT cursor_4c_BuscaTam
872:                 loc_cCodSel  = NVL(ALLTRIM(cods),  "")
873:                 loc_cDescSel = NVL(ALLTRIM(descs), "")
874:             ENDIF
875:         ENDIF
876: 
877:         loc_oBusca.Release()
878: 
879:         IF USED("cursor_4c_BuscaTam")
880:             USE IN cursor_4c_BuscaTam
881:         ENDIF
882: 
883:         IF EMPTY(loc_cCodSel)
884:             RETURN
885:         ENDIF
886: 

*-- Linhas 893 a 911:
893: 
894:         *-- Aplicar selecao no cursor do grid
895:         IF USED(loc_cCursor) AND !EOF(loc_cCursor)
896:             SELECT (loc_cCursor)
897:             REPLACE codtams WITH loc_cCodSel, descs WITH loc_cDescSel
898:         ENDIF
899:         THIS.grd_4c_Dados.Refresh()
900:     ENDPROC
901: 
902:     *==========================================================================
903:     * CarregarLista - Recarrega o grid de tamanhos do produto pai
904:     * Wrapper canonico CRUD: reexecuta a query no BO, reconecta o grid ao cursor
905:     * e forca refresh visual. Usado apos BtnCancelarClick (descarta alteracoes)
906:     * e apos operacoes que invalidam o cursor de trabalho.
907:     *==========================================================================
908:     PROCEDURE CarregarLista()
909:         LOCAL loc_lSucesso
910:         loc_lSucesso = .F.
911: 


### BO (C:\4c\projeto\app\classes\sigprtamBO.prg):
*******************************************************************************
* sigprtamBO.prg - Business Object: Peso Medio por Tamanho do Produto
* Herda de BusinessBase
* Tabela principal: sigprtam
*******************************************************************************

DEFINE CLASS sigprtamBO AS BusinessBase

    *-- Identificacao da entidade
    this_cTabela     = "sigprtam"
    this_cCampoChave = "cidchaves"

    *-- Chave primaria
    this_cCidChaves  = ""

    *-- Codigo do tamanho (FK -> SigCdTam.cods)
    this_cCodTams    = ""

    *-- Descricao do tamanho (virtual - SigCdTam.descs, nao persiste em sigprtam)
    this_cDescs      = ""

    *-- Codigo do produto (FK -> SigCdPro.cpros)
    this_cCPros      = ""

    *-- Peso medio por tamanho
    this_nPesoMs     = 0

    *-- Percentual sobre preco de venda
    this_nPercs      = 0

    *-- Valor calculado (preco de venda + percentual)
    this_nValor      = 0

    *-- Dias prazo de entrega
    this_nDiasPrz    = 0

    *-- Data da ultima alteracao
    this_dDataAlts   = {}

    *-- Data de transferencia
    this_dDataTrans  = {}

    *-- Data de movimento
    this_dDtMovs     = {}

    *-- Contexto do produto pai (carregado de SigCdPro)
    this_cDPros      = ""
    this_nPVens      = 0
    this_nPCuss      = 0

    *-- Nome do cursor de trabalho para o grid de tamanhos
    this_cCursorDados = "cursor_4c_TamPro"

    *---------------------------------------------------------------------------
    PROCEDURE Init()
    *---------------------------------------------------------------------------
        THIS.this_cTabela     = "sigprtam"
        THIS.this_cCampoChave = "cidchaves"
        DODEFAULT()
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
    *---------------------------------------------------------------------------
        RETURN THIS.this_cCidChaves
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves  = NVL(ALLTRIM(cidchaves), "")
            THIS.this_cCodTams    = NVL(ALLTRIM(codtams), "")
            THIS.this_cCPros      = NVL(ALLTRIM(cpros), "")
            THIS.this_nPesoMs     = NVL(pesoms, 0)
            THIS.this_nPercs      = NVL(percs, 0)
            THIS.this_nValor      = NVL(valor, 0)
            THIS.this_nDiasPrz    = NVL(diasprz, 0)
            THIS.this_dDataAlts   = NVL(dataalts, {})
            THIS.this_dDataTrans  = NVL(datatrans, {})
            THIS.this_dDtMovs     = NVL(dtmovs, {})
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * CarregarTamanhos - Carrega tamanhos do produto do SQL Server para cursor
    * par_cCPros: codigo do produto
    *---------------------------------------------------------------------------
    PROCEDURE CarregarTamanhos(par_cCPros)
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_cSql
        loc_lSucesso = .F.
        TRY
            IF USED(THIS.this_cCursorDados)
                IF USED(THIS.this_cCursorDados)
                    TABLEREVERT(.T., THIS.this_cCursorDados)
                ENDIF
                USE IN (THIS.this_cCursorDados)
            ENDIF

            loc_cSql = "SELECT a.cidchaves, a.codtams, a.cpros, " + ;
                        "       a.pesoms, a.percs, a.valor, a.diasprz, " + ;
                        "       a.dataalts, a.datatrans, a.dtmovs, " + ;
                        "       ISNULL(b.descs, '') AS descs " + ;
                        "  FROM sigprtam a " + ;
                        "  LEFT JOIN SigCdTam b ON b.cods = a.codtams " + ;
                        " WHERE a.cpros = " + EscaparSQL(par_cCPros) + ;
                        " ORDER BY a.codtams"

            IF SQLEXEC(gnConnHandle, loc_cSql, THIS.this_cCursorDados) > 0
                SELECT (THIS.this_cCursorDados)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar tamanhos do produto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * CarregarProduto - Carrega dados do produto pai (PVens, PCuss, Dpros)
    * par_cCPros: codigo do produto
    *---------------------------------------------------------------------------
    PROCEDURE CarregarProduto(par_cCPros)
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_cSql
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_ProdutoPai")
                USE IN cursor_4c_ProdutoPai
            ENDIF
            loc_cSql = "SELECT TOP 1 dpros, pvens, pcuss " + ;
                        "  FROM SigCdPro " + ;
                        " WHERE cpros = " + EscaparSQL(par_cCPros)
            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_ProdutoPai") > 0
                IF !EOF("cursor_4c_ProdutoPai")
                    SELECT cursor_4c_ProdutoPai
                    THIS.this_cDPros  = NVL(ALLTRIM(dpros), "")
                    THIS.this_nPVens  = NVL(pvens, 0)
                    THIS.this_nPCuss  = NVL(pcuss, 0)
                    loc_lSucesso = .T.
                ENDIF
                USE IN cursor_4c_ProdutoPai
            ELSE
                MsgErro("Erro ao carregar dados do produto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_ProdutoPai")
                USE IN cursor_4c_ProdutoPai
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * InserirLinhaGrid - Insere linha em branco no cursor do grid (local)
    * par_cCPros: codigo do produto
    *---------------------------------------------------------------------------
    PROCEDURE InserirLinhaGrid(par_cCPros)
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_cIdChaves
        loc_lSucesso = .F.
        TRY
            IF !USED(THIS.this_cCursorDados)
                MsgErro("Cursor de tamanhos n" + CHR(227) + "o est" + CHR(225) + " aberto.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Verificar se ja existe linha vazia para este produto
            SELECT (THIS.this_cCursorDados)
            LOCATE FOR ALLTRIM(codtams) = "" AND ALLTRIM(cpros) = ALLTRIM(par_cCPros)
            IF !EOF()
                loc_lSucesso = .T.
            ENDIF

            loc_cIdChaves = fUniqueIds()

            INSERT INTO (THIS.this_cCursorDados) ;
                (cidchaves, codtams, cpros, descs, pesoms, percs, valor, diasprz) ;
                VALUES (loc_cIdChaves, "", par_cCPros, "", 0, 0, 0, 0)

            SELECT (THIS.this_cCursorDados)
            GO BOTTOM
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * ExcluirLinhaGrid - Remove linha corrente do cursor do grid (local)
    * par_cCPros: codigo do produto
    *---------------------------------------------------------------------------
    PROCEDURE ExcluirLinhaGrid(par_cCPros)
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF !USED(THIS.this_cCursorDados)
                loc_lSucesso = .F.
            ENDIF
            SELECT (THIS.this_cCursorDados)
            IF !EOF() AND ALLTRIM(cpros) = ALLTRIM(par_cCPros)
                DELETE
                SKIP
                IF EOF()
                    SKIP -1
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * ValidarTamanhoExiste - Verifica se codtams ja esta em uso para cpros
    * (exceto o registro corrente identificado por cIdChaves)
    * Retorna .T. se duplicado (ja existe), .F. se OK
    *---------------------------------------------------------------------------
    PROCEDURE ValidarTamanhoExiste(par_cCodTams, par_cIdChavesAtual)
    *---------------------------------------------------------------------------
        LOCAL loc_lDuplicado, loc_oErro
        loc_lDuplicado = .F.
        TRY
            IF USED(THIS.this_cCursorDados)
                SELECT (THIS.this_cCursorDados)
                LOCATE FOR ALLTRIM(codtams) = ALLTRIM(par_cCodTams) AND ;
                           ALLTRIM(cidchaves) <> ALLTRIM(par_cIdChavesAtual)
                loc_lDuplicado = !EOF()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lDuplicado
    ENDPROC

    *---------------------------------------------------------------------------
    * BuscarDescricaoTamanho - Busca descricao do tamanho em SigCdTam
    * par_cCodTams: codigo do tamanho
    * Retorna descricao (string) ou "" se nao encontrado
    *---------------------------------------------------------------------------
    PROCEDURE BuscarDescricaoTamanho(par_cCodTams)
    *---------------------------------------------------------------------------
        LOCAL loc_cDescs, loc_oErro, loc_cSql
        loc_cDescs = ""
        TRY
            IF USED("cursor_4c_BuscaTam")
                USE IN cursor_4c_BuscaTam
            ENDIF
            loc_cSql = "SELECT TOP 1 cods, descs FROM SigCdTam " + ;
                        " WHERE cods = " + EscaparSQL(par_cCodTams)
            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_BuscaTam") > 0
                IF !EOF("cursor_4c_BuscaTam")
                    SELECT cursor_4c_BuscaTam
                    loc_cDescs = NVL(ALLTRIM(descs), "")
                ENDIF
                USE IN cursor_4c_BuscaTam
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_BuscaTam")
                USE IN cursor_4c_BuscaTam
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_cDescs
    ENDPROC

    *---------------------------------------------------------------------------
    * SalvarTamanhos - Persiste todas as linhas do cursor no SQL Server
    * par_cCPros: codigo do produto
    * Estrategia: DELETE all + INSERT all (mesma logica do legado via TABLEREVERT/TABLEUPDATE)
    *---------------------------------------------------------------------------
    PROCEDURE SalvarTamanhos(par_cCPros)
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_cSql
        LOCAL loc_cCidChaves, loc_cCodTams, loc_nPesoMs
        LOCAL loc_nPercs, loc_nValor, loc_nDiasPrz
        loc_lSucesso = .F.
        TRY
            IF !USED(THIS.this_cCursorDados)
                loc_lSucesso = .F.
            ENDIF

            *-- Validar: todos os registros devem ter tamanho informado
            SELECT (THIS.this_cCursorDados)
            SCAN
                IF EMPTY(ALLTRIM(codtams))
                    MsgAviso("Tamanho n" + CHR(227) + "o informado!", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lSucesso = .F.
                ENDIF
            ENDSCAN

            *-- Deletar registros existentes no SQL Server
            loc_cSql = "DELETE FROM sigprtam WHERE cpros = " + EscaparSQL(par_cCPros)
            IF SQLEXEC(gnConnHandle, loc_cSql) < 0
                MsgErro("Erro ao excluir tamanhos anteriores.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Inserir todos os registros do cursor
            SELECT (THIS.this_cCursorDados)
            SCAN FOR !DELETED() AND ALLTRIM(cpros) = ALLTRIM(par_cCPros) ;
                AND !EMPTY(ALLTRIM(codtams))
                loc_cCidChaves = ALLTRIM(cidchaves)
                loc_cCodTams   = ALLTRIM(codtams)
                loc_nPesoMs    = NVL(pesoms, 0)
                loc_nPercs     = NVL(percs, 0)
                loc_nValor     = NVL(valor, 0)
                loc_nDiasPrz   = NVL(diasprz, 0)

                loc_cSql = "INSERT INTO sigprtam " + ;
                            "(cidchaves, codtams, cpros, pesoms, percs, valor, diasprz, dataalts) " + ;
                            "VALUES (" + ;
                            EscaparSQL(loc_cCidChaves) + ", " + ;
                            EscaparSQL(loc_cCodTams) + ", " + ;
                            EscaparSQL(par_cCPros) + ", " + ;
                            FormatarNumeroSQL(loc_nPesoMs, 3) + ", " + ;
                            FormatarNumeroSQL(loc_nPercs, 2) + ", " + ;
                            FormatarNumeroSQL(loc_nValor, 5) + ", " + ;
                            FormatarNumeroSQL(loc_nDiasPrz, 0) + ", " + ;
                            "GETDATE())"

                IF SQLEXEC(gnConnHandle, loc_cSql) < 0
                    MsgErro("Erro ao salvar tamanho " + loc_cCodTams + ".", "Erro")
                    loc_lSucesso = .F.
                ENDIF
            ENDSCAN
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * CalcularValorPorPercentual - Calcula Valor a partir de Percs e PVens
    * par_nPercs:  percentual informado
    * par_nPVens:  preco de venda do produto
    * Retorna valor calculado
    *---------------------------------------------------------------------------
    PROCEDURE CalcularValorPorPercentual(par_nPercs, par_nPVens)
    *---------------------------------------------------------------------------
        LOCAL loc_nValor
        loc_nValor = 0
        IF par_nPVens <> 0 AND par_nPercs <> 0
            loc_nValor = par_nPVens + (par_nPVens * (par_nPercs / 100))
        ENDIF
        RETURN loc_nValor
    ENDPROC

    *---------------------------------------------------------------------------
    * CalcularPercentualPorValor - Calcula Percs a partir de Valor e PVens
    * par_nValor:  valor informado
    * par_nPVens:  preco de venda do produto
    * Retorna percentual calculado
    *---------------------------------------------------------------------------
    PROCEDURE CalcularPercentualPorValor(par_nValor, par_nPVens)
    *---------------------------------------------------------------------------
        LOCAL loc_nPercs
        loc_nPercs = 0
        IF par_nPVens <> 0 AND par_nValor <> 0
            loc_nPercs = ((par_nValor - par_nPVens) / par_nPVens) * 100
        ENDIF
        RETURN loc_nPercs
    ENDPROC

    *---------------------------------------------------------------------------
    * Inserir - Insere um unico registro de tamanho no SQL Server
    * Usa as propriedades this_* para montar o INSERT
    *---------------------------------------------------------------------------
    PROCEDURE Inserir()
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_cSql
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF

            loc_cSql = "INSERT INTO sigprtam " + ;
                        "(cidchaves, codtams, cpros, " + ;
                        " pesoms, percs, valor, diasprz, dataalts) " + ;
                        "VALUES (" + ;
                        EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                        EscaparSQL(THIS.this_cCodTams) + ", " + ;
                        EscaparSQL(THIS.this_cCPros) + ", " + ;
                        FormatarNumeroSQL(THIS.this_nPesoMs, 3) + ", " + ;
                        FormatarNumeroSQL(THIS.this_nPercs, 2) + ", " + ;
                        FormatarNumeroSQL(THIS.this_nValor, 5) + ", " + ;
                        FormatarNumeroSQL(THIS.this_nDiasPrz, 0) + ", " + ;
                        "GETDATE())"

            IF SQLEXEC(gnConnHandle, loc_cSql) > 0
                THIS.RegistrarAuditoria("I")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir tamanho " + ALLTRIM(THIS.this_cCodTams) + ".", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * Atualizar - Atualiza um unico registro de tamanho no SQL Server
    * Usa as propriedades this_* para montar o UPDATE
    *---------------------------------------------------------------------------
    PROCEDURE Atualizar()
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_cSql
        loc_lSucesso = .F.
        TRY
            loc_cSql = "UPDATE sigprtam SET " + ;
                        " codtams = " + EscaparSQL(THIS.this_cCodTams) + ", " + ;
                        " cpros   = " + EscaparSQL(THIS.this_cCPros) + ", " + ;
                        " pesoms  = " + FormatarNumeroSQL(THIS.this_nPesoMs, 3) + ", " + ;
                        " percs   = " + FormatarNumeroSQL(THIS.this_nPercs, 2) + ", " + ;
                        " valor   = " + FormatarNumeroSQL(THIS.this_nValor, 5) + ", " + ;
                        " diasprz = " + FormatarNumeroSQL(THIS.this_nDiasPrz, 0) + ", " + ;
                        " dataalts = GETDATE() " + ;
                        " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            IF SQLEXEC(gnConnHandle, loc_cSql) > 0
                THIS.RegistrarAuditoria("A")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar tamanho " + ALLTRIM(THIS.this_cCodTams) + ".", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * ExecutarExclusao - Remove um registro de tamanho do SQL Server (PROTECTED)
    * Chamado por BusinessBase.Excluir()
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_cSql
        loc_lSucesso = .F.
        TRY
            loc_cSql = "DELETE FROM sigprtam " + ;
                        " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
            IF SQLEXEC(gnConnHandle, loc_cSql) > 0
                THIS.RegistrarAuditoria("E")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir tamanho.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC


ENDDEFINE

