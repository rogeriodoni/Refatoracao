# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 415: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES GRID/CURSOR
- [MADDCOLUNA] mAddColuna com parametro numerico. Assinatura: (campo, mascara, titulo) - TODOS strings
- [GRID-HEADERS] Apos RecordSource, Header1.Caption resetado para nome do campo. REDEFINIR todos os captions
- [SQLEXEC-GRID] SQLEXEC direto no cursor do Grid destroi colunas. Usar cursor temp + ZAP + APPEND
- [CREATE-CURSOR-NULL] SET NULL ON antes de CREATE CURSOR (APPEND de dados com NULL falha)
- [RECORDSOURCE-WITH] RecordSource/ColumnCount FORA do WITH block (dentro causa "Unknown member COLUMN1")
- [CURSOR-DUPLICADO] CREATE CURSOR duplicado com ordem diferente de campos
- [GRID-RECORDSOURCE-AUTOBIND] Apos .RecordSource =, REDEFINIR .ControlSource de TODAS as colunas

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrDsc.prg) - TRECHOS RELEVANTES PARA PASS GRID (1036 linhas total):

*-- Linhas 14 a 32:
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
24:     *--------------------------------------------------------------------------
25:     Height      = 600
26:     Width       = 1000
27:     BorderStyle = 2
28:     AutoCenter  = .T.
29:     ShowTips    = .T.
30:     TitleBar    = 0
31:     ShowWindow = 1
32:     ControlBox  = .F.

*-- Linhas 70 a 96:
70: 
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
90:                     THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
91:                     THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
92: 
93:                     *-- Configurar botoes de acao no canto superior direito
94:                     THIS.ConfigurarBotoes()
95: 
96:                     *-- Configurar area de filtros/input (equivalente Page2 Dados em OPERACIONAL)

*-- Linhas 371 a 459:
371: 
372:     *==========================================================================
373:     * ConfigurarPaginaLista - configura grade de resultados (equivalente Page1 Lista)
374:     * Em OPERACIONAL flat, o grid grd_4c_Dados corresponde funcionalmente a Page1
375:     * Lista do padrao CRUD: eh o output visual dos registros processados.
376:     *==========================================================================
377:     PROTECTED PROCEDURE ConfigurarPaginaLista
378:         THIS.ConfigurarGrade()
379:     ENDPROC
380: 
381:     *==========================================================================
382:     * AlternarPagina - stub para OPERACIONAL (sem alternancia de paginas)
383:     * Forms OPERACIONAIS flat nao possuem Page1/Page2 como forms CRUD.
384:     *==========================================================================
385:     PROCEDURE AlternarPagina
386:         LPARAMETERS par_nPagina
387:         *-- Nao aplicavel: layout flat sem PageFrame de alternancia
388:     ENDPROC
389: 
390:     *==========================================================================
391:     PROTECTED PROCEDURE ConfigurarGrade
392:     *==========================================================================
393:         *-- Grade - Top=164, Left=15, Width=769 em 800px -> Width=960 em 1000px
394:         THIS.AddObject("grd_4c_Dados", "Grid")
395:         WITH THIS.grd_4c_Dados
396:             .Top               = 164
397:             .Left              = 15
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
454:             *-- Carrega o dicionario de traducoes ao abrir o form
455:             *-- Os produtos sao carregados apenas quando usuario clicar Selecionar
456:             loc_lSucesso = THIS.this_oBusinessObject.BuscarDicionario()
457:         CATCH TO loc_oErro
458:             MsgErro(loc_oErro.Message, "Erro")
459:         ENDTRY

*-- Linhas 508 a 526:
508:                 loc_nTotal = THIS.this_oBusinessObject.this_nTotalGravados
509:                 MsgInfo("Foram gravados " + TRANSFORM(loc_nTotal) + " produto(s).", ;
510:                         "Processamento Conclu" + CHR(237) + "do")
511:                 THIS.grd_4c_Dados.Refresh()
512:             ENDIF
513:         CATCH TO loc_oErro
514:             MsgErro(loc_oErro.Message, "Erro")
515:         ENDTRY
516:     ENDPROC
517: 
518:     PROCEDURE BtnSelecionarClick
519:         LOCAL loc_lSucesso, loc_oErro
520:         loc_lSucesso = .F.
521:         TRY
522:             *-- Validar: ao menos um filtro deve ser preenchido
523:             IF EMPTY(ALLTRIM(THIS.txt_4c_CProsI.Value)) AND ;
524:                EMPTY(ALLTRIM(THIS.txt_4c_CProsF.Value)) AND ;
525:                EMPTY(ALLTRIM(THIS.txt_4c_CGrus.Value))
526:                 MsgAviso("Nenhum filtro foi informado.", "Aten" + CHR(231) + CHR(227) + "o")

*-- Linhas 553 a 582:
553:                     THIS.cmd_4c_Atualizar.Enabled = .F.
554:                 ENDIF
555: 
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
581:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
582:             RETURN

*-- Linhas 673 a 693:
673:                           "SigCdPro", "cursor_4c_LookupPro", "CPros", loc_cValor, ;
674:                           "Sele" + CHR(231) + CHR(227) + "o", .F., .T., "")
675:             IF VARTYPE(loc_oLookup) = "O"
676:                 loc_oLookup.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
677:                 loc_oLookup.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
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

*-- Linhas 762 a 781:
762:                           "SigCdGrp", "cursor_4c_LookupGru", "CGrus", loc_cValor, ;
763:                           "Grupo de Produto", .F., .T., "")
764:             IF VARTYPE(loc_oLookup) = "O"
765:                 loc_oLookup.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
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

*-- Linhas 831 a 849:
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
848:         *-- No form OPERACIONAL SigPrDsc, "Alterar" significa gravar as descricoes
849:         *-- editadas no grid de volta a tabela SigCdPro (mesma acao do btnAtualizar).

*-- Linhas 859 a 877:
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
876:             ENDIF
877: 

*-- Linhas 885 a 903:
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

*-- Linhas 973 a 992:
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
989:     PROCEDURE CarregarLista
990:         RETURN THIS.CarregarDados()
991:     ENDPROC
992: 

