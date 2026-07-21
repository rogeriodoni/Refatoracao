# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (2)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 397: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 554: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrDsc.prg) - TRECHOS RELEVANTES PARA PASS GRID (1029 linhas total):

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
89:                     *-- Configurar botoes de acao no canto superior direito
90:                     THIS.ConfigurarBotoes()
91: 
92:                     *-- Configurar area de filtros/input (equivalente Page2 Dados em OPERACIONAL)
93:                     THIS.ConfigurarPaginaDados()
94: 
95:                     *-- Configurar grade de resultados (equivalente Page1 Lista em OPERACIONAL)
96:                     THIS.ConfigurarPaginaLista()

*-- Linhas 367 a 454:
367: 
368:     *==========================================================================
369:     * ConfigurarPaginaLista - configura grade de resultados (equivalente Page1 Lista)
370:     * Em OPERACIONAL flat, o grid grd_4c_Dados corresponde funcionalmente a Page1
371:     * Lista do padrao CRUD: eh o output visual dos registros processados.
372:     *==========================================================================
373:     PROTECTED PROCEDURE ConfigurarPaginaLista
374:         THIS.ConfigurarGrade()
375:     ENDPROC
376: 
377:     *==========================================================================
378:     * AlternarPagina - stub para OPERACIONAL (sem alternancia de paginas)
379:     * Forms OPERACIONAIS flat nao possuem Page1/Page2 como forms CRUD.
380:     *==========================================================================
381:     PROCEDURE AlternarPagina
382:         LPARAMETERS par_nPagina
383:         *-- Nao aplicavel: layout flat sem PageFrame de alternancia
384:     ENDPROC
385: 
386:     *==========================================================================
387:     PROTECTED PROCEDURE ConfigurarGrade
388:     *==========================================================================
389:         *-- Grade - Top=164, Left=15, Width=769 em 800px -> Width=960 em 1000px
390:         THIS.AddObject("grd_4c_Dados", "Grid")
391:         WITH THIS.grd_4c_Dados
392:             .Top               = 164
393:             .Left              = 15
394:             .Width             = 960
395:             .Height            = 343
396:             .ColumnCount       = 3
397:             .RecordSource      = "cursor_4c_Produtos"
398:             .RecordMark        = .F.
399:             .DeleteMark        = .F.
400:             .AllowHeaderSizing = .F.
401:             .AllowRowSizing    = .F.
402:             .RowHeight         = 17
403:             .HeaderHeight      = 17
404:             .ScrollBars        = 2
405:             .GridLineColor     = RGB(238, 238, 238)
406:             .HighlightBackColor = RGB(255, 255, 255)
407:             .HighlightForeColor = RGB(15, 41, 104)
408:             .HighlightStyle    = 2
409:             .FontName          = "Verdana"
410:             .FontSize          = 8
411: 
412:             WITH .Column1
413:                 .ControlSource = "cursor_4c_Produtos.CPros"
414:                 .Width         = 135
415:                 .Header1.Caption   = "C" + CHR(243) + "digo"
416:                 .Header1.FontName  = "Tahoma"
417:                 .Header1.FontSize  = 8
418:                 .Header1.Alignment = 2
419:                 .ReadOnly          = .T.
420:             ENDWITH
421: 
422:             WITH .Column2
423:                 .ControlSource = "cursor_4c_Produtos.Portugues"
424:                 .Width         = 363
425:                 .ReadOnly          = .T.
426:                 .Header1.Caption   = "Portugu" + CHR(234) + "s"
427:                 .Header1.FontName  = "Tahoma"
428:                 .Header1.FontSize  = 8
429:                 .Header1.Alignment = 2
430:             ENDWITH
431: 
432:             WITH .Column3
433:                 .ControlSource = "cursor_4c_Produtos.Traduzido"
434:                 .Width         = 424
435:                 .ReadOnly          = .T.
436:                 .Header1.Caption   = "Traduzido"
437:                 .Header1.FontName  = "Tahoma"
438:                 .Header1.FontSize  = 8
439:                 .Header1.Alignment = 2
440:             ENDWITH
441:         ENDWITH
442:     ENDPROC
443: 
444:     *==========================================================================
445:     PROCEDURE CarregarDados
446:     *==========================================================================
447:         LOCAL loc_lSucesso, loc_oErro
448:         loc_lSucesso = .F.
449:         TRY
450:             *-- Carrega o dicionario de traducoes ao abrir o form
451:             *-- Os produtos sao carregados apenas quando usuario clicar Selecionar
452:             loc_lSucesso = THIS.this_oBusinessObject.BuscarDicionario()
453:         CATCH TO loc_oErro
454:             MsgErro(loc_oErro.Message, "Erro")

*-- Linhas 504 a 522:
504:                 loc_nTotal = THIS.this_oBusinessObject.this_nTotalGravados
505:                 MsgInfo("Foram gravados " + TRANSFORM(loc_nTotal) + " produto(s).", ;
506:                         "Processamento Conclu" + CHR(237) + "do")
507:                 THIS.grd_4c_Dados.Refresh()
508:             ENDIF
509:         CATCH TO loc_oErro
510:             MsgErro(loc_oErro.Message, "Erro")
511:         ENDTRY
512:     ENDPROC
513: 
514:     PROCEDURE BtnSelecionarClick
515:         LOCAL loc_lSucesso, loc_oErro
516:         loc_lSucesso = .F.
517:         TRY
518:             *-- Validar: ao menos um filtro deve ser preenchido
519:             IF EMPTY(ALLTRIM(THIS.txt_4c_CProsI.Value)) AND ;
520:                EMPTY(ALLTRIM(THIS.txt_4c_CProsF.Value)) AND ;
521:                EMPTY(ALLTRIM(THIS.txt_4c_CGrus.Value))
522:                 MsgAviso("Nenhum filtro foi informado.", "Aten" + CHR(231) + CHR(227) + "o")

*-- Linhas 540 a 575:
540:                 THIS.this_oBusinessObject.this_cCProsF = ALLTRIM(THIS.txt_4c_CProsF.Value)
541:                 THIS.this_oBusinessObject.this_cCGrus  = ALLTRIM(THIS.txt_4c_CGrus.Value)
542: 
543:                 *-- Processar traducoes e popular cursor_4c_Produtos
544:                 loc_lSucesso = THIS.this_oBusinessObject.ProcessarTraducoes()
545: 
546:                 IF loc_lSucesso
547:                     THIS.cmd_4c_Atualizar.Enabled = .T.
548:                 ELSE
549:                     THIS.cmd_4c_Atualizar.Enabled = .F.
550:                 ENDIF
551: 
552:                 *-- Recarregar grid (ColumnCount ANTES de RecordSource - regra critica)
553:                 THIS.grd_4c_Dados.ColumnCount  = 3
554:                 THIS.grd_4c_Dados.RecordSource = "cursor_4c_Produtos"
555:                 THIS.grd_4c_Dados.Column1.Header1.Caption = "C" + CHR(243) + "digo"
556:                 THIS.grd_4c_Dados.Column2.Header1.Caption = "Portugu" + CHR(234) + "s"
557:                 THIS.grd_4c_Dados.Column3.Header1.Caption = "Traduzido"
558:                 SELECT cursor_4c_Produtos
559:                 GO TOP
560:                 THIS.grd_4c_Dados.Refresh()
561: 
562:             ENDIF && filtros preenchidos
563: 
564:         CATCH TO loc_oErro
565:             MsgErro(loc_oErro.Message, "Erro")
566:         ENDTRY
567:     ENDPROC
568: 
569:     *-- KeyPress do txt_4c_CProsI: valida produto e abre picker se nao encontrado
570:     PROCEDURE TxtCProsIKeyPress
571:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
572:         LOCAL loc_cCPros, loc_cSQL, loc_oErro
573: 
574:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
575:             RETURN

*-- Linhas 666 a 686:
666:                           "SigCdPro", "cursor_4c_LookupPro", "CPros", loc_cValor, ;
667:                           "Sele" + CHR(231) + CHR(227) + "o", .F., .T., "")
668:             IF VARTYPE(loc_oLookup) = "O"
669:                 loc_oLookup.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
670:                 loc_oLookup.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
671:                 loc_oLookup.mAddColuna("CGrus", "", "Grupo")
672:                 loc_oLookup.Show()
673:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_LookupPro")
674:                     SELECT cursor_4c_LookupPro
675:                     loc_cCodSel = ALLTRIM(cursor_4c_LookupPro.CPros)
676:                     IF par_cCampo = "I"
677:                         THIS.txt_4c_CProsI.Value = loc_cCodSel
678:                         THIS.txt_4c_CProsI.Refresh()
679:                         IF EMPTY(ALLTRIM(THIS.txt_4c_CProsF.Value))
680:                             THIS.txt_4c_CProsF.Value = loc_cCodSel
681:                             THIS.txt_4c_CProsF.Refresh()
682:                         ENDIF
683:                     ELSE
684:                         THIS.txt_4c_CProsF.Value = loc_cCodSel
685:                         THIS.txt_4c_CProsF.Refresh()
686:                         IF EMPTY(ALLTRIM(THIS.txt_4c_CProsI.Value))

*-- Linhas 755 a 774:
755:                           "SigCdGrp", "cursor_4c_LookupGru", "CGrus", loc_cValor, ;
756:                           "Grupo de Produto", .F., .T., "")
757:             IF VARTYPE(loc_oLookup) = "O"
758:                 loc_oLookup.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
759:                 loc_oLookup.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
760:                 loc_oLookup.Show()
761:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_LookupGru")
762:                     SELECT cursor_4c_LookupGru
763:                     THIS.txt_4c_CGrus.Value = ALLTRIM(cursor_4c_LookupGru.CGrus)
764:                     THIS.txt_4c_CGrus.Refresh()
765:                     THIS.txt_4c_CProsI.Value = ""
766:                     THIS.txt_4c_CProsF.Value = ""
767:                     THIS.txt_4c_CProsI.Refresh()
768:                     THIS.txt_4c_CProsF.Refresh()
769:                 ENDIF
770:                 IF USED("cursor_4c_LookupGru")
771:                     USE IN cursor_4c_LookupGru
772:                 ENDIF
773:             ENDIF
774: 

*-- Linhas 824 a 842:
824:             IF USED("cursor_4c_Produtos")
825:                 SELECT cursor_4c_Produtos
826:                 ZAP
827:                 THIS.grd_4c_Dados.Refresh()
828:             ENDIF
829: 
830:             THIS.cmd_4c_Atualizar.Enabled = .F.
831:             THIS.this_cModoAtual = "SELECIONAR"
832: 
833:             *-- Foca no primeiro campo de filtro
834:             THIS.txt_4c_CProsI.SetFocus()
835:         CATCH TO loc_oErro
836:             MsgErro(loc_oErro.Message, "Erro")
837:         ENDTRY
838:     ENDPROC
839: 
840:     PROCEDURE BtnAlterarClick
841:         *-- No form OPERACIONAL SigPrDsc, "Alterar" significa gravar as descricoes
842:         *-- editadas no grid de volta a tabela SigCdPro (mesma acao do btnAtualizar).

*-- Linhas 852 a 870:
852:             IF USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
853:                 SELECT cursor_4c_Produtos
854:                 GO TOP
855:                 THIS.grd_4c_Dados.SetFocus()
856:             ENDIF
857:         CATCH TO loc_oErro
858:             MsgErro(loc_oErro.Message, "Erro")
859:         ENDTRY
860:     ENDPROC
861: 
862:     PROCEDURE BtnExcluirClick
863:         LOCAL loc_lConfirma, loc_oErro
864:         TRY
865:             IF !USED("cursor_4c_Produtos") OR RECCOUNT("cursor_4c_Produtos") = 0
866:                 MsgAviso("Nenhum produto selecionado para remover.", ;
867:                         "Aten" + CHR(231) + CHR(227) + "o")
868:                 RETURN
869:             ENDIF
870: 

*-- Linhas 878 a 896:
878:                 SELECT cursor_4c_Produtos
879:                 DELETE
880:                 SET DELETED ON
881:                 THIS.grd_4c_Dados.Refresh()
882: 
883:                 *-- Conta registros nao-deletados restantes (COUNT nao aceita IN <alias> em VFP9)
884:                 SELECT cursor_4c_Produtos
885:                 COUNT FOR NOT DELETED() TO loc_nRestantes
886:                 THIS.cmd_4c_Atualizar.Enabled = (loc_nRestantes > 0)
887:             ENDIF
888:         CATCH TO loc_oErro
889:             MsgErro(loc_oErro.Message, "Erro")
890:         ENDTRY
891:     ENDPROC
892: 
893:     *==========================================================================
894:     * METODOS DE INTERFACE FORMBASE (OPERACIONAL)
895:     * Implementacao especifica do form OPERACIONAL SigPrDsc.
896:     * Substituem stubs do FormBase com logica real do form.

*-- Linhas 966 a 985:
966:             SELECT cursor_4c_Produtos
967:             ZAP
968:         ENDIF
969:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
970:             THIS.grd_4c_Dados.Refresh()
971:         ENDIF
972:         IF PEMSTATUS(THIS, "cmd_4c_Atualizar", 5)
973:             THIS.cmd_4c_Atualizar.Enabled = .F.
974:         ENDIF
975:         THIS.HabilitarCampos(.T.)
976:         THIS.this_cModoAtual = "SELECIONAR"
977:     ENDPROC
978: 
979:     *-- CarregarLista: carrega dados iniciais (dicionario de traducoes SigCdDic)
980:     *-- Em OPERACIONAL SigPrDsc a "lista" eh o dicionario; produtos sao carregados
981:     *-- apenas ao acionar Selecionar.
982:     PROCEDURE CarregarLista
983:         RETURN THIS.CarregarDados()
984:     ENDPROC
985: 

