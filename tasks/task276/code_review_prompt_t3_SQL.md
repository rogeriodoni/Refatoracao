# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, IDIOMA, OBSCOMPRAS, DPROS

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
  Column1.ControlSource = "crProdutos.CPros"
  Column2.ControlSource = "crProdutos.Portugues"
  Column3.ControlSource = "crProdutos.Traduzido"
  ControlSource = "csContas.CprosAnt"
  ControlSource = "csContas.CprosNov"
Select crProdutos
	oProg.Update(.t.)
	lcQuery = [Update SigCdPro ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, []) < 1)
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Traducao - Update SigCdPro)])
	lcQuery = [Delete From SigPrPrt Where CPros = '] + lcPro + [']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, []) < 1)
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Traducao - Delete SigPrPrt)], 10000)
lcQuery = [Select CPros ] + ;
		    [From SigCdPro ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crPrdTraduz]) < 1)
Select crPrdTraduz
	oProg.Update(.t.)
		lcQuery = [Select a.CPros, a.CGrus, a.CodCors, b.DGrus, b.Mercs, b.MontaGrDs, c.Descs ] + ;
				    [From SigCdPro a ] + ;
				    [Left Join SigCdGrp b On b.CGrus = a.CGrus ] + ;
				    [Left Join SigCdCor c On c.Cods = a.CodCors ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalPro]) < 1)
			Select crSigCdDic
			Insert Into crProdutos (CPros, Portugues, Traduzido, DscCompras, ObsCompras) ;
Select crProdutos
		lcQuery = [Select Expressao, Traducao ] + ;
					[From SigCdDic ] + ;
		If (.poDataMgr.SqlExecute(lcQuery, [crSigCdDic]) < 1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrDsc.prg) - TRECHOS RELEVANTES PARA PASS SQL (1036 linhas total):

*-- Linhas 5 a 23:
5: *
6: * Pilares:
7: *   UX   -> layout identico ao legado (800->1000px proporcional)
8: *   BD   -> SigCdPro (UPDATE DscCompras/ObsCompras/DPros) + SigCdDic (dicionario)
9: *   CODE -> arquitetura em camadas (FormBase / SigPrDscBO)
10: *
11: * Layout original (800px) escalado para 1000px (fator 1.25)
12: * Estrutura flat:
13: *   cnt_4c_Cabecalho (Top=0, L=0, W=1000, H=80)
14: *   cmd_4c_Encerrar  (Top=3, L=910, W=75, H=75) - standalone sobre cabecalho
15: *   cmd_4c_Atualizar (Top=3, L=825, W=75, H=75) - standalone sobre cabecalho
16: *   Labels filtros + txt_4c_CProsI/F + txt_4c_CGrus + cmd_4c_Selecionar (Top=135)
17: *   grd_4c_Dados     (Top=164, L=15, W=960, H=343)
18: *==============================================================================
19: 
20: DEFINE CLASS FormSigPrDsc AS FormBase
21: 
22:     *--------------------------------------------------------------------------
23:     * Propriedades visuais (identicas ao legado, width escalado 800->1000)

*-- Linhas 71 a 89:
71:                     *-- Criar cursor placeholder para o grid
72:                     *-- Estrutura IDENTICA ao crProdutos do legado
73:                     SET NULL ON
74:                     CREATE CURSOR cursor_4c_Produtos (;
75:                         CPros       C(14)   NULL, ;
76:                         Portugues   C(254)  NULL, ;
77:                         Traduzido   C(254)  NULL, ;
78:                         DscCompras  M(10)   NULL, ;
79:                         ObsCompras  M(10)   NULL  ;
80:                     )
81:                     SET NULL OFF
82: 
83:                     *-- Aparencia base do form (OPERACIONAL sem PageFrame Page1/Page2)
84:                     THIS.ConfigurarPageFrame()
85: 
86:                     *-- Configurar cabecalho cinza escuro (cntSombra do legado)
87:                     THIS.ConfigurarCabecalho()
88: 
89:                     *-- Propagar Caption para labels do cabecalho

*-- Linhas 398 a 453:
398:             .Width             = 960
399:             .Height            = 343
400:             .RecordMark        = .F.
401:             .DeleteMark        = .F.
402:             .AllowHeaderSizing = .F.
403:             .AllowRowSizing    = .F.
404:             .RowHeight         = 17
405:             .HeaderHeight      = 17
406:             .ScrollBars        = 2
407:             .GridLineColor     = RGB(238, 238, 238)
408:             .HighlightBackColor = RGB(255, 255, 255)
409:             .HighlightForeColor = RGB(15, 41, 104)
410:             .HighlightStyle    = 2
411:             .FontName          = "Verdana"
412:             .FontSize          = 8
413:         ENDWITH
414:         THIS.grd_4c_Dados.ColumnCount  = 3
415:         THIS.grd_4c_Dados.RecordSource = "cursor_4c_Produtos"
416: 
417:         WITH THIS.grd_4c_Dados.Column1
418:             .ControlSource     = "cursor_4c_Produtos.CPros"
419:             .Width             = 135
420:             .Header1.Caption   = "C" + CHR(243) + "digo"
421:             .Header1.FontName  = "Tahoma"
422:             .Header1.FontSize  = 8
423:             .Header1.Alignment = 2
424:             .ReadOnly          = .T.
425:         ENDWITH
426: 
427:         WITH THIS.grd_4c_Dados.Column2
428:             .ControlSource     = "cursor_4c_Produtos.Portugues"
429:             .Width             = 363
430:             .ReadOnly          = .T.
431:             .Header1.Caption   = "Portugu" + CHR(234) + "s"
432:             .Header1.FontName  = "Tahoma"
433:             .Header1.FontSize  = 8
434:             .Header1.Alignment = 2
435:         ENDWITH
436: 
437:         WITH THIS.grd_4c_Dados.Column3
438:             .ControlSource     = "cursor_4c_Produtos.Traduzido"
439:             .Width             = 424
440:             .ReadOnly          = .T.
441:             .Header1.Caption   = "Traduzido"
442:             .Header1.FontName  = "Tahoma"
443:             .Header1.FontSize  = 8
444:             .Header1.Alignment = 2
445:         ENDWITH
446:     ENDPROC
447: 
448:     *==========================================================================
449:     PROCEDURE CarregarDados
450:     *==========================================================================
451:         LOCAL loc_lSucesso, loc_oErro
452:         loc_lSucesso = .F.
453:         TRY

*-- Linhas 556 a 580:
556:                 *-- Recarregar grid (ColumnCount ANTES de RecordSource - regra critica)
557:                 THIS.grd_4c_Dados.ColumnCount  = 3
558:                 THIS.grd_4c_Dados.RecordSource = "cursor_4c_Produtos"
559:                 THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Produtos.CPros"
560:                 THIS.grd_4c_Dados.Column2.ControlSource = "cursor_4c_Produtos.Portugues"
561:                 THIS.grd_4c_Dados.Column3.ControlSource = "cursor_4c_Produtos.Traduzido"
562:                 THIS.grd_4c_Dados.Column1.Header1.Caption = "C" + CHR(243) + "digo"
563:                 THIS.grd_4c_Dados.Column2.Header1.Caption = "Portugu" + CHR(234) + "s"
564:                 THIS.grd_4c_Dados.Column3.Header1.Caption = "Traduzido"
565:                 SELECT cursor_4c_Produtos
566:                 GO TOP
567:                 THIS.grd_4c_Dados.Refresh()
568: 
569:             ENDIF && filtros preenchidos
570: 
571:         CATCH TO loc_oErro
572:             MsgErro(loc_oErro.Message, "Erro")
573:         ENDTRY
574:     ENDPROC
575: 
576:     *-- KeyPress do txt_4c_CProsI: valida produto e abre picker se nao encontrado
577:     PROCEDURE TxtCProsIKeyPress
578:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
579:         LOCAL loc_cCPros, loc_cSQL, loc_oErro
580: 

*-- Linhas 589 a 611:
589:         ENDIF
590: 
591:         TRY
592:             loc_cSQL = "SELECT TOP 1 CPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCPros)
593:             IF USED("cursor_4c_ProBusca")
594:                 USE IN cursor_4c_ProBusca
595:             ENDIF
596:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProBusca") >= 1 AND ;
597:                RECCOUNT("cursor_4c_ProBusca") > 0
598:                 *-- Produto encontrado: copiar para CProsF se vazio + limpar CGrus (logica legado)
599:                 IF EMPTY(ALLTRIM(THIS.txt_4c_CProsF.Value))
600:                     THIS.txt_4c_CProsF.Value = loc_cCPros
601:                     THIS.txt_4c_CProsF.Refresh()
602:                 ENDIF
603:                 THIS.txt_4c_CGrus.Value = ""
604:                 THIS.txt_4c_CGrus.Refresh()
605:             ELSE
606:                 *-- Produto nao encontrado: abrir picker
607:                 THIS.AbrirBuscaProduto("I")
608:             ENDIF
609:             IF USED("cursor_4c_ProBusca")
610:                 USE IN cursor_4c_ProBusca
611:             ENDIF

*-- Linhas 631 a 653:
631:         ENDIF
632: 
633:         TRY
634:             loc_cSQL = "SELECT TOP 1 CPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCPros)
635:             IF USED("cursor_4c_ProBusca")
636:                 USE IN cursor_4c_ProBusca
637:             ENDIF
638:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProBusca") >= 1 AND ;
639:                RECCOUNT("cursor_4c_ProBusca") > 0
640:                 *-- Produto encontrado: copiar para CProsI se vazio + limpar CGrus (logica legado)
641:                 IF EMPTY(ALLTRIM(THIS.txt_4c_CProsI.Value))
642:                     THIS.txt_4c_CProsI.Value = loc_cCPros
643:                     THIS.txt_4c_CProsI.Refresh()
644:                 ENDIF
645:                 THIS.txt_4c_CGrus.Value = ""
646:                 THIS.txt_4c_CGrus.Refresh()
647:             ELSE
648:                 *-- Produto nao encontrado: abrir picker
649:                 THIS.AbrirBuscaProduto("F")
650:             ENDIF
651:             IF USED("cursor_4c_ProBusca")
652:                 USE IN cursor_4c_ProBusca
653:             ENDIF

*-- Linhas 678 a 696:
678:                 loc_oLookup.mAddColuna("CGrus", "", "Grupo")
679:                 loc_oLookup.Show()
680:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_LookupPro")
681:                     SELECT cursor_4c_LookupPro
682:                     loc_cCodSel = ALLTRIM(cursor_4c_LookupPro.CPros)
683:                     IF par_cCampo = "I"
684:                         THIS.txt_4c_CProsI.Value = loc_cCodSel
685:                         THIS.txt_4c_CProsI.Refresh()
686:                         IF EMPTY(ALLTRIM(THIS.txt_4c_CProsF.Value))
687:                             THIS.txt_4c_CProsF.Value = loc_cCodSel
688:                             THIS.txt_4c_CProsF.Refresh()
689:                         ENDIF
690:                     ELSE
691:                         THIS.txt_4c_CProsF.Value = loc_cCodSel
692:                         THIS.txt_4c_CProsF.Refresh()
693:                         IF EMPTY(ALLTRIM(THIS.txt_4c_CProsI.Value))
694:                             THIS.txt_4c_CProsI.Value = loc_cCodSel
695:                             THIS.txt_4c_CProsI.Refresh()
696:                         ENDIF

*-- Linhas 729 a 751:
729: 
730:         TRY
731:             *-- Verificar se grupo existe em SigCdGrp
732:             loc_cSQL = "SELECT TOP 1 CGrus FROM SigCdGrp WHERE CGrus = " + EscaparSQL(loc_cCGrus)
733:             IF USED("cursor_4c_GruBusca")
734:                 USE IN cursor_4c_GruBusca
735:             ENDIF
736:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruBusca") >= 1 AND ;
737:                RECCOUNT("cursor_4c_GruBusca") > 0
738:                 *-- Grupo encontrado: limpar intervalo de produto (logica legado)
739:                 THIS.txt_4c_CProsI.Value = ""
740:                 THIS.txt_4c_CProsF.Value = ""
741:                 THIS.txt_4c_CProsI.Refresh()
742:                 THIS.txt_4c_CProsF.Refresh()
743:             ELSE
744:                 *-- Grupo nao encontrado: abrir picker
745:                 THIS.AbrirBuscaGrupo()
746:             ENDIF
747:             IF USED("cursor_4c_GruBusca")
748:                 USE IN cursor_4c_GruBusca
749:             ENDIF
750:             THIS.AtualizarEstadoCampos()
751:         CATCH TO loc_oErro

*-- Linhas 766 a 784:
766:                 loc_oLookup.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
767:                 loc_oLookup.Show()
768:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_LookupGru")
769:                     SELECT cursor_4c_LookupGru
770:                     THIS.txt_4c_CGrus.Value = ALLTRIM(cursor_4c_LookupGru.CGrus)
771:                     THIS.txt_4c_CGrus.Refresh()
772:                     THIS.txt_4c_CProsI.Value = ""
773:                     THIS.txt_4c_CProsF.Value = ""
774:                     THIS.txt_4c_CProsI.Refresh()
775:                     THIS.txt_4c_CProsF.Refresh()
776:                 ENDIF
777:                 IF USED("cursor_4c_LookupGru")
778:                     USE IN cursor_4c_LookupGru
779:                 ENDIF
780:             ENDIF
781: 
782:         CATCH TO loc_oErro
783:             MsgErro(loc_oErro.Message, "Erro")
784:         ENDTRY

*-- Linhas 829 a 847:
829: 
830:             *-- Zera o cursor do grid
831:             IF USED("cursor_4c_Produtos")
832:                 SELECT cursor_4c_Produtos
833:                 ZAP
834:                 THIS.grd_4c_Dados.Refresh()
835:             ENDIF
836: 
837:             THIS.cmd_4c_Atualizar.Enabled = .F.
838:             THIS.this_cModoAtual = "SELECIONAR"
839: 
840:             *-- Foca no primeiro campo de filtro
841:             THIS.txt_4c_CProsI.SetFocus()
842:         CATCH TO loc_oErro
843:             MsgErro(loc_oErro.Message, "Erro")
844:         ENDTRY
845:     ENDPROC
846: 
847:     PROCEDURE BtnAlterarClick

*-- Linhas 857 a 875:
857:             THIS.BtnSelecionarClick()
858: 
859:             IF USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
860:                 SELECT cursor_4c_Produtos
861:                 GO TOP
862:                 THIS.grd_4c_Dados.SetFocus()
863:             ENDIF
864:         CATCH TO loc_oErro
865:             MsgErro(loc_oErro.Message, "Erro")
866:         ENDTRY
867:     ENDPROC
868: 
869:     PROCEDURE BtnExcluirClick
870:         LOCAL loc_lConfirma, loc_oErro
871:         TRY
872:             IF !USED("cursor_4c_Produtos") OR RECCOUNT("cursor_4c_Produtos") = 0
873:                 MsgAviso("Nenhum produto selecionado para remover.", ;
874:                         "Aten" + CHR(231) + CHR(227) + "o")
875:                 RETURN

*-- Linhas 882 a 907:
882: 
883:             IF loc_lConfirma
884:                 LOCAL loc_nRestantes
885:                 SELECT cursor_4c_Produtos
886:                 DELETE
887:                 SET DELETED ON
888:                 THIS.grd_4c_Dados.Refresh()
889: 
890:                 *-- Conta registros nao-deletados restantes (COUNT nao aceita IN <alias> em VFP9)
891:                 SELECT cursor_4c_Produtos
892:                 COUNT FOR NOT DELETED() TO loc_nRestantes
893:                 THIS.cmd_4c_Atualizar.Enabled = (loc_nRestantes > 0)
894:             ENDIF
895:         CATCH TO loc_oErro
896:             MsgErro(loc_oErro.Message, "Erro")
897:         ENDTRY
898:     ENDPROC
899: 
900:     *==========================================================================
901:     * METODOS DE INTERFACE FORMBASE (OPERACIONAL)
902:     * Implementacao especifica do form OPERACIONAL SigPrDsc.
903:     * Substituem stubs do FormBase com logica real do form.
904:     *==========================================================================
905: 
906:     *-- BtnBuscarClick: executa selecao de produtos (equivalente a Buscar em CRUD)
907:     PROCEDURE BtnBuscarClick

*-- Linhas 970 a 988:
970:             THIS.txt_4c_CGrus.Refresh()
971:         ENDIF
972:         IF USED("cursor_4c_Produtos")
973:             SELECT cursor_4c_Produtos
974:             ZAP
975:         ENDIF
976:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
977:             THIS.grd_4c_Dados.Refresh()
978:         ENDIF
979:         IF PEMSTATUS(THIS, "cmd_4c_Atualizar", 5)
980:             THIS.cmd_4c_Atualizar.Enabled = .F.
981:         ENDIF
982:         THIS.HabilitarCampos(.T.)
983:         THIS.this_cModoAtual = "SELECIONAR"
984:     ENDPROC
985: 
986:     *-- CarregarLista: carrega dados iniciais (dicionario de traducoes SigCdDic)
987:     *-- Em OPERACIONAL SigPrDsc a "lista" eh o dicionario; produtos sao carregados
988:     *-- apenas ao acionar Selecionar.


### BO (C:\4c\projeto\app\classes\SigPrDscBO.prg):
*==============================================================================
* SigPrDscBO.prg - Business Object para Montagem de Descricao de Produtos
* Herda de BusinessBase
* Tabela principal: SigCdPro (atualiza DscCompras/ObsCompras/DPros)
* Tabelas auxiliares: SigCdDic (dicionario), SigCdGrp, SigCdCor, SigPrPrt
*==============================================================================

DEFINE CLASS SigPrDscBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Configuracao da entidade
    *--------------------------------------------------------------------------
    this_cTabela     = "SigCdPro"
    this_cCampoChave = "CPros"

    *--------------------------------------------------------------------------
    * Filtros de selecao de produtos
    *--------------------------------------------------------------------------
    this_cCProsI = ""  && produto inicial do intervalo C(14)
    this_cCProsF = ""  && produto final do intervalo   C(14)
    this_cCGrus  = ""  && grupo de produto (filtro alternativo) C(3)

    *--------------------------------------------------------------------------
    * Controle de processamento e gravacao
    *--------------------------------------------------------------------------
    this_nTotalProcessados = 0
    this_nTotalGravados    = 0
    this_lGravadoOk        = .F.

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "CPros"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - retorna chave para auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCProsI + "-" + THIS.this_cCProsF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - mapeia campos do cursor para propriedades do BO
    * Cursor esperado: alias de SigCdPro com ao menos CPros/CGrus
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCProsI = TratarNulo(CPros, "C")
                THIS.this_cCProsF = TratarNulo(CPros, "C")
                THIS.this_cCGrus  = TratarNulo(CGrus, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarDicionario - carrega dicionario de traducoes de SigCdDic
    * Popula cursor_4c_Dicionario (Expressao/Traducao, ordenado por tamanho desc)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarDicionario()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Dicionario")
                USE IN cursor_4c_Dicionario
            ENDIF
            loc_cSQL = "SELECT Expressao, Traducao " + ;
                       "FROM SigCdDic " + ;
                       "WHERE Idioma = 'INGLES    ' " + ;
                       "ORDER BY LEN(Expressao) DESC, Expressao"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dicionario") < 1
                MsgErro("Falha ao carregar dicion" + CHR(225) + "rio de tradu" + CHR(231) + CHR(245) + "es.", "Erro")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarProdutos - SELECT de produtos baseado nos filtros do BO
    * Popula cursor_4c_ProdTemp (CPros apenas - lista de codigos)
    * Pre-requisito: this_cCProsI/F e this_cCGrus ja setados pelo form
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProdutos()
        LOCAL loc_lSucesso, loc_cSQL, loc_cPrI, loc_cPrF, loc_cGru, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cPrI = PADR(THIS.this_cCProsI, 14)
            loc_cPrF = PADR(THIS.this_cCProsF, 14)
            loc_cGru = PADR(THIS.this_cCGrus, 3)

            IF !EMPTY(ALLTRIM(loc_cGru))
                loc_cSQL = "SELECT CPros FROM SigCdPro " + ;
                           "WHERE CGrus = " + EscaparSQL(ALLTRIM(loc_cGru)) + " " + ;
                           "ORDER BY CPros"
            ELSE
                loc_cSQL = "SELECT CPros FROM SigCdPro " + ;
                           "WHERE CPros BETWEEN " + EscaparSQL(loc_cPrI) + " AND " + EscaparSQL(loc_cPrF) + " " + ;
                           "ORDER BY CPros"
            ENDIF

            IF USED("cursor_4c_ProdTemp")
                USE IN cursor_4c_ProdTemp
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdTemp") < 1
                MsgErro("Falha ao buscar produtos.", "Erro")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarTraducoes - processa produtos e preenche cursor_4c_Produtos
    * Equivalente ao PROCEDURE processamento do legado (SIGPRDSC.processamento)
    * Pre-requisito: cursor_4c_Dicionario carregado via BuscarDicionario()
    * Pre-requisito: cursor_4c_Produtos criado pelo form (CREATE CURSOR)
    * Pos-execucao: cursor_4c_Produtos contem (CPros/Portugues/Traduzido/DscCompras/ObsCompras)
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarTraducoes()
        LOCAL loc_lSucesso, loc_cSQL, loc_cPro, loc_cDes, loc_cIni
        LOCAL loc_cIng, loc_nGrD, loc_oProg, loc_oErro
        loc_lSucesso = .F.
        TRY
            *-- Busca lista de produtos no SQL Server
            IF !THIS.BuscarProdutos()
                loc_lSucesso = .F.
            ENDIF

            IF !USED("cursor_4c_ProdTemp") OR RECCOUNT("cursor_4c_ProdTemp") = 0
                MsgAviso("Nenhum produto encontrado para os filtros informados.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            *-- Zera cursor de resultado do form
            IF USED("cursor_4c_Produtos")
                SELECT cursor_4c_Produtos
                ZAP
            ENDIF

            THIS.this_nTotalProcessados = 0

            loc_oProg = CREATEOBJECT("fwprogressbar", ;
                "Processando Tradu" + CHR(231) + CHR(245) + "es...", ;
                RECCOUNT("cursor_4c_ProdTemp"))
            loc_oProg.Show

            SELECT cursor_4c_ProdTemp
            GO TOP
            SCAN
                loc_cPro = ALLTRIM(cursor_4c_ProdTemp.CPros)

                loc_oProg.SubTitulo.Caption = "Produto : " + loc_cPro
                loc_oProg.Update(.T.)

                IF !EMPTY(loc_cPro)
                    loc_cDes = ""

                    *-- Busca dados complementares: grupo + cor do produto
                    loc_cSQL = "SELECT a.CPros, a.CGrus, a.CodCors, " + ;
                               "b.DGrus, b.Mercs, b.MontaGrDs, c.Descs " + ;
                               "FROM SigCdPro a " + ;
                               "LEFT JOIN SigCdGrp b ON b.CGrus = a.CGrus " + ;
                               "LEFT JOIN SigCdCor c ON c.Cods = a.CodCors " + ;
                               "WHERE a.CPros = " + EscaparSQL(loc_cPro)

                    IF USED("cursor_4c_LocalPro")
                        USE IN cursor_4c_LocalPro
                    ENDIF
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro") >= 1
                        SELECT cursor_4c_LocalPro
                        GO TOP
                        loc_nGrD = NVL(cursor_4c_LocalPro.MontaGrDs, 0)
                        IF loc_nGrD = 1
                            *-- MontaGrDs=1: incluir descricao do grupo (DGrus) + cor (Descs)
                            loc_cDes = ALLTRIM(;
                                ALLTRIM(NVL(cursor_4c_LocalPro.DGrus, "")) + " " + ;
                                ALLTRIM(NVL(cursor_4c_LocalPro.Descs, "")))
                        ELSE
                            *-- MontaGrDs=0: apenas descricao de cor (Descs)
                            loc_cDes = ALLTRIM(NVL(cursor_4c_LocalPro.Descs, ""))
                        ENDIF

                        IF !EMPTY(loc_cDes)
                            loc_cIng = loc_cDes

                            *-- Aplica substituicoes do dicionario portugues->ingles
                            IF USED("cursor_4c_Dicionario")
                                SELECT cursor_4c_Dicionario
                                GO TOP
                                SCAN
                                    loc_cIng = STRTRAN(loc_cIng, ;
                                        ALLTRIM(cursor_4c_Dicionario.Expressao), ;
                                        ALLTRIM(cursor_4c_Dicionario.Traducao))
                                ENDSCAN
                            ENDIF

                            *-- Remove aspas simples e duplas (protecao SQL)
                            loc_cDes = STRTRAN(STRTRAN(loc_cDes, "'", " "), '"', " ")
                            loc_cIng = STRTRAN(STRTRAN(loc_cIng, "'", " "), '"', " ")

                            *-- Insere no cursor de produtos (DscCompras=traduzido, ObsCompras=portugues)
                            SELECT cursor_4c_Produtos
                            INSERT INTO cursor_4c_Produtos ;
                                (CPros, Portugues, Traduzido, DscCompras, ObsCompras) ;
                                VALUES (loc_cPro, loc_cDes, loc_cIng, loc_cIng, loc_cDes)

                            THIS.this_nTotalProcessados = THIS.this_nTotalProcessados + 1
                        ENDIF

                        IF USED("cursor_4c_LocalPro")
                            USE IN cursor_4c_LocalPro
                        ENDIF
                    ENDIF
                ENDIF
            ENDSCAN

            loc_oProg.Complete

            SELECT cursor_4c_Produtos
            GO TOP
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarDescricoes - grava descricoes nos produtos (UPDATE SigCdPro)
    * Equivalente ao PROCEDURE gravacao do legado (SIGPRDSC.gravacao)
    * Pre-requisito: cursor_4c_Produtos populado por ProcessarTraducoes()
    * Cada produto: UPDATE SigCdPro + DELETE SigPrPrt com commit individual
    *--------------------------------------------------------------------------
    PROCEDURE GravarDescricoes()
        LOCAL loc_lSucesso, loc_lOks, loc_cSQL, loc_cPro
        LOCAL loc_oProg, loc_nTotal, loc_oErro
        loc_lSucesso = .F.
        loc_lOks     = .T.
        TRY
            IF !USED("cursor_4c_Produtos")
                MsgAviso("Nenhum produto para gravar.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            loc_nTotal = RECCOUNT("cursor_4c_Produtos")
            IF loc_nTotal = 0
                MsgAviso("Nenhum produto para gravar.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            THIS.this_nTotalGravados = 0
            THIS.this_lGravadoOk     = .F.

            loc_oProg = CREATEOBJECT("fwprogressbar", "Gravando Produtos...", loc_nTotal)
            loc_oProg.Show

            SELECT cursor_4c_Produtos
            GO TOP
            SCAN WHILE loc_lOks
                loc_cPro = ALLTRIM(cursor_4c_Produtos.CPros)

                loc_oProg.SubTitulo.Caption = "Produto : " + loc_cPro
                loc_oProg.Update(.T.)

                *-- UPDATE SigCdPro: DscCompras, ObsCompras, DPros
                loc_cSQL = "UPDATE SigCdPro " + ;
                           "SET DscCompras = " + EscaparSQL(cursor_4c_Produtos.DscCompras) + ", " + ;
                               "ObsCompras = " + EscaparSQL(cursor_4c_Produtos.ObsCompras) + ", " + ;
                               "DPros = " + EscaparSQL(PADR(ALLTRIM(cursor_4c_Produtos.Portugues), 40)) + " " + ;
                           "WHERE CPros = " + EscaparSQL(loc_cPro)

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                    MsgErro("Falha ao atualizar produto " + loc_cPro + " em SigCdPro.", "Erro")
                    loc_lOks = .F.
                ENDIF

                IF loc_lOks
                    *-- DELETE FROM SigPrPrt: remove produto enviado
                    loc_cSQL = "DELETE FROM SigPrPrt WHERE CPros = " + EscaparSQL(loc_cPro)
                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                        MsgErro("Falha ao excluir produto " + loc_cPro + " de SigPrPrt.", "Erro")
                        loc_lOks = .F.
                    ENDIF
                ENDIF

                IF loc_lOks
                    SQLCOMMIT(gnConnHandle)
                    THIS.this_nTotalGravados = THIS.this_nTotalGravados + 1
                ELSE
                    SQLROLLBACK(gnConnHandle)
                ENDIF
            ENDSCAN

            loc_oProg.Complete

            IF loc_lOks
                THIS.this_lGravadoOk = .T.
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - grava as descricoes traduzidas (equivalente a UPDATE em lote)
    * Form OPERACIONAL: unico caminho de persistencia disponivel.
    * Espelha o botao btnAtualizar do legado -> chama gravacao/GravarDescricoes.
    * RegistrarAuditoria eh disparada dentro de GravarDescricoes ao final do lote.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.GravarDescricoes()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - nao aplicavel a este form OPERACIONAL (nao cria produtos novos)
    * O form atualiza descricoes de produtos ja existentes em SigCdPro.
    * Delegamos a Atualizar para manter contrato de BusinessBase e evitar
    * insercao acidental de registros pelo fluxo padrao Salvar().
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN THIS.Atualizar()
    ENDPROC

ENDDEFINE

