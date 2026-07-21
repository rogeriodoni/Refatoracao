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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrDsc.prg) - TRECHOS RELEVANTES PARA PASS SQL (1039 linhas total):

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

*-- Linhas 398 a 456:
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
416:         THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Produtos.CPros"
417:         THIS.grd_4c_Dados.Column2.ControlSource = "cursor_4c_Produtos.Portugues"
418:         THIS.grd_4c_Dados.Column3.ControlSource = "cursor_4c_Produtos.Traduzido"
419: 
420:         WITH THIS.grd_4c_Dados.Column1
421:             .ControlSource     = "cursor_4c_Produtos.CPros"
422:             .Width             = 135
423:             .Header1.Caption   = "C" + CHR(243) + "digo"
424:             .Header1.FontName  = "Tahoma"
425:             .Header1.FontSize  = 8
426:             .Header1.Alignment = 2
427:             .ReadOnly          = .T.
428:         ENDWITH
429: 
430:         WITH THIS.grd_4c_Dados.Column2
431:             .ControlSource     = "cursor_4c_Produtos.Portugues"
432:             .Width             = 363
433:             .ReadOnly          = .T.
434:             .Header1.Caption   = "Portugu" + CHR(234) + "s"
435:             .Header1.FontName  = "Tahoma"
436:             .Header1.FontSize  = 8
437:             .Header1.Alignment = 2
438:         ENDWITH
439: 
440:         WITH THIS.grd_4c_Dados.Column3
441:             .ControlSource     = "cursor_4c_Produtos.Traduzido"
442:             .Width             = 424
443:             .ReadOnly          = .T.
444:             .Header1.Caption   = "Traduzido"
445:             .Header1.FontName  = "Tahoma"
446:             .Header1.FontSize  = 8
447:             .Header1.Alignment = 2
448:         ENDWITH
449:     ENDPROC
450: 
451:     *==========================================================================
452:     PROCEDURE CarregarDados
453:     *==========================================================================
454:         LOCAL loc_lSucesso, loc_oErro
455:         loc_lSucesso = .F.
456:         TRY

*-- Linhas 559 a 583:
559:                 *-- Recarregar grid (ColumnCount ANTES de RecordSource - regra critica)
560:                 THIS.grd_4c_Dados.ColumnCount  = 3
561:                 THIS.grd_4c_Dados.RecordSource = "cursor_4c_Produtos"
562:                 THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Produtos.CPros"
563:                 THIS.grd_4c_Dados.Column2.ControlSource = "cursor_4c_Produtos.Portugues"
564:                 THIS.grd_4c_Dados.Column3.ControlSource = "cursor_4c_Produtos.Traduzido"
565:                 THIS.grd_4c_Dados.Column1.Header1.Caption = "C" + CHR(243) + "digo"
566:                 THIS.grd_4c_Dados.Column2.Header1.Caption = "Portugu" + CHR(234) + "s"
567:                 THIS.grd_4c_Dados.Column3.Header1.Caption = "Traduzido"
568:                 SELECT cursor_4c_Produtos
569:                 GO TOP
570:                 THIS.grd_4c_Dados.Refresh()
571: 
572:             ENDIF && filtros preenchidos
573: 
574:         CATCH TO loc_oErro
575:             MsgErro(loc_oErro.Message, "Erro")
576:         ENDTRY
577:     ENDPROC
578: 
579:     *-- KeyPress do txt_4c_CProsI: valida produto e abre picker se nao encontrado
580:     PROCEDURE TxtCProsIKeyPress
581:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
582:         LOCAL loc_cCPros, loc_cSQL, loc_oErro
583: 

*-- Linhas 592 a 614:
592:         ENDIF
593: 
594:         TRY
595:             loc_cSQL = "SELECT TOP 1 CPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCPros)
596:             IF USED("cursor_4c_ProBusca")
597:                 USE IN cursor_4c_ProBusca
598:             ENDIF
599:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProBusca") >= 1 AND ;
600:                RECCOUNT("cursor_4c_ProBusca") > 0
601:                 *-- Produto encontrado: copiar para CProsF se vazio + limpar CGrus (logica legado)
602:                 IF EMPTY(ALLTRIM(THIS.txt_4c_CProsF.Value))
603:                     THIS.txt_4c_CProsF.Value = loc_cCPros
604:                     THIS.txt_4c_CProsF.Refresh()
605:                 ENDIF
606:                 THIS.txt_4c_CGrus.Value = ""
607:                 THIS.txt_4c_CGrus.Refresh()
608:             ELSE
609:                 *-- Produto nao encontrado: abrir picker
610:                 THIS.AbrirBuscaProduto("I")
611:             ENDIF
612:             IF USED("cursor_4c_ProBusca")
613:                 USE IN cursor_4c_ProBusca
614:             ENDIF

*-- Linhas 634 a 656:
634:         ENDIF
635: 
636:         TRY
637:             loc_cSQL = "SELECT TOP 1 CPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCPros)
638:             IF USED("cursor_4c_ProBusca")
639:                 USE IN cursor_4c_ProBusca
640:             ENDIF
641:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProBusca") >= 1 AND ;
642:                RECCOUNT("cursor_4c_ProBusca") > 0
643:                 *-- Produto encontrado: copiar para CProsI se vazio + limpar CGrus (logica legado)
644:                 IF EMPTY(ALLTRIM(THIS.txt_4c_CProsI.Value))
645:                     THIS.txt_4c_CProsI.Value = loc_cCPros
646:                     THIS.txt_4c_CProsI.Refresh()
647:                 ENDIF
648:                 THIS.txt_4c_CGrus.Value = ""
649:                 THIS.txt_4c_CGrus.Refresh()
650:             ELSE
651:                 *-- Produto nao encontrado: abrir picker
652:                 THIS.AbrirBuscaProduto("F")
653:             ENDIF
654:             IF USED("cursor_4c_ProBusca")
655:                 USE IN cursor_4c_ProBusca
656:             ENDIF

*-- Linhas 681 a 699:
681:                 loc_oLookup.mAddColuna("CGrus", "", "Grupo")
682:                 loc_oLookup.Show()
683:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_LookupPro")
684:                     SELECT cursor_4c_LookupPro
685:                     loc_cCodSel = ALLTRIM(cursor_4c_LookupPro.CPros)
686:                     IF par_cCampo = "I"
687:                         THIS.txt_4c_CProsI.Value = loc_cCodSel
688:                         THIS.txt_4c_CProsI.Refresh()
689:                         IF EMPTY(ALLTRIM(THIS.txt_4c_CProsF.Value))
690:                             THIS.txt_4c_CProsF.Value = loc_cCodSel
691:                             THIS.txt_4c_CProsF.Refresh()
692:                         ENDIF
693:                     ELSE
694:                         THIS.txt_4c_CProsF.Value = loc_cCodSel
695:                         THIS.txt_4c_CProsF.Refresh()
696:                         IF EMPTY(ALLTRIM(THIS.txt_4c_CProsI.Value))
697:                             THIS.txt_4c_CProsI.Value = loc_cCodSel
698:                             THIS.txt_4c_CProsI.Refresh()
699:                         ENDIF

*-- Linhas 732 a 754:
732: 
733:         TRY
734:             *-- Verificar se grupo existe em SigCdGrp
735:             loc_cSQL = "SELECT TOP 1 CGrus FROM SigCdGrp WHERE CGrus = " + EscaparSQL(loc_cCGrus)
736:             IF USED("cursor_4c_GruBusca")
737:                 USE IN cursor_4c_GruBusca
738:             ENDIF
739:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruBusca") >= 1 AND ;
740:                RECCOUNT("cursor_4c_GruBusca") > 0
741:                 *-- Grupo encontrado: limpar intervalo de produto (logica legado)
742:                 THIS.txt_4c_CProsI.Value = ""
743:                 THIS.txt_4c_CProsF.Value = ""
744:                 THIS.txt_4c_CProsI.Refresh()
745:                 THIS.txt_4c_CProsF.Refresh()
746:             ELSE
747:                 *-- Grupo nao encontrado: abrir picker
748:                 THIS.AbrirBuscaGrupo()
749:             ENDIF
750:             IF USED("cursor_4c_GruBusca")
751:                 USE IN cursor_4c_GruBusca
752:             ENDIF
753:             THIS.AtualizarEstadoCampos()
754:         CATCH TO loc_oErro

*-- Linhas 769 a 787:
769:                 loc_oLookup.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
770:                 loc_oLookup.Show()
771:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_LookupGru")
772:                     SELECT cursor_4c_LookupGru
773:                     THIS.txt_4c_CGrus.Value = ALLTRIM(cursor_4c_LookupGru.CGrus)
774:                     THIS.txt_4c_CGrus.Refresh()
775:                     THIS.txt_4c_CProsI.Value = ""
776:                     THIS.txt_4c_CProsF.Value = ""
777:                     THIS.txt_4c_CProsI.Refresh()
778:                     THIS.txt_4c_CProsF.Refresh()
779:                 ENDIF
780:                 IF USED("cursor_4c_LookupGru")
781:                     USE IN cursor_4c_LookupGru
782:                 ENDIF
783:             ENDIF
784: 
785:         CATCH TO loc_oErro
786:             MsgErro(loc_oErro.Message, "Erro")
787:         ENDTRY

*-- Linhas 832 a 850:
832: 
833:             *-- Zera o cursor do grid
834:             IF USED("cursor_4c_Produtos")
835:                 SELECT cursor_4c_Produtos
836:                 ZAP
837:                 THIS.grd_4c_Dados.Refresh()
838:             ENDIF
839: 
840:             THIS.cmd_4c_Atualizar.Enabled = .F.
841:             THIS.this_cModoAtual = "SELECIONAR"
842: 
843:             *-- Foca no primeiro campo de filtro
844:             THIS.txt_4c_CProsI.SetFocus()
845:         CATCH TO loc_oErro
846:             MsgErro(loc_oErro.Message, "Erro")
847:         ENDTRY
848:     ENDPROC
849: 
850:     PROCEDURE BtnAlterarClick

*-- Linhas 860 a 878:
860:             THIS.BtnSelecionarClick()
861: 
862:             IF USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
863:                 SELECT cursor_4c_Produtos
864:                 GO TOP
865:                 THIS.grd_4c_Dados.SetFocus()
866:             ENDIF
867:         CATCH TO loc_oErro
868:             MsgErro(loc_oErro.Message, "Erro")
869:         ENDTRY
870:     ENDPROC
871: 
872:     PROCEDURE BtnExcluirClick
873:         LOCAL loc_lConfirma, loc_oErro
874:         TRY
875:             IF !USED("cursor_4c_Produtos") OR RECCOUNT("cursor_4c_Produtos") = 0
876:                 MsgAviso("Nenhum produto selecionado para remover.", ;
877:                         "Aten" + CHR(231) + CHR(227) + "o")
878:                 RETURN

*-- Linhas 885 a 910:
885: 
886:             IF loc_lConfirma
887:                 LOCAL loc_nRestantes
888:                 SELECT cursor_4c_Produtos
889:                 DELETE
890:                 SET DELETED ON
891:                 THIS.grd_4c_Dados.Refresh()
892: 
893:                 *-- Conta registros nao-deletados restantes (COUNT nao aceita IN <alias> em VFP9)
894:                 SELECT cursor_4c_Produtos
895:                 COUNT FOR NOT DELETED() TO loc_nRestantes
896:                 THIS.cmd_4c_Atualizar.Enabled = (loc_nRestantes > 0)
897:             ENDIF
898:         CATCH TO loc_oErro
899:             MsgErro(loc_oErro.Message, "Erro")
900:         ENDTRY
901:     ENDPROC
902: 
903:     *==========================================================================
904:     * METODOS DE INTERFACE FORMBASE (OPERACIONAL)
905:     * Implementacao especifica do form OPERACIONAL SigPrDsc.
906:     * Substituem stubs do FormBase com logica real do form.
907:     *==========================================================================
908: 
909:     *-- BtnBuscarClick: executa selecao de produtos (equivalente a Buscar em CRUD)
910:     PROCEDURE BtnBuscarClick

*-- Linhas 973 a 991:
973:             THIS.txt_4c_CGrus.Refresh()
974:         ENDIF
975:         IF USED("cursor_4c_Produtos")
976:             SELECT cursor_4c_Produtos
977:             ZAP
978:         ENDIF
979:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
980:             THIS.grd_4c_Dados.Refresh()
981:         ENDIF
982:         IF PEMSTATUS(THIS, "cmd_4c_Atualizar", 5)
983:             THIS.cmd_4c_Atualizar.Enabled = .F.
984:         ENDIF
985:         THIS.HabilitarCampos(.T.)
986:         THIS.this_cModoAtual = "SELECIONAR"
987:     ENDPROC
988: 
989:     *-- CarregarLista: carrega dados iniciais (dicionario de traducoes SigCdDic)
990:     *-- Em OPERACIONAL SigPrDsc a "lista" eh o dicionario; produtos sao carregados
991:     *-- apenas ao acionar Selecionar.


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

