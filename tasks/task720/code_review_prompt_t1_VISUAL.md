# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Itens' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' numa tela cujo dump legado NAO declara essa fonte - trocar por 'Tahoma' SO nas linhas apontadas, nunca "todas as ocorrencias" (Erro178: o legado do SIGCDPRO declara Comic Sans MS nos 8 botoes de navegacao, e a troca em massa virou regressao de PILAR 1)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpDet.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1357 linhas total):

*-- Linhas 15 a 35:
15: * Historico de fases:
16: *   Fase 1/2: SigOpDetBO.prg (propriedades + CRUD completo)
17: *   Fase 3:   FormSigOpDet.prg - estrutura base (Init, InicializarForm,
18: *             ConfigurarCabecalho, TornarControlesVisiveis, Destroy)
19: *   Fase 4:   Grade (Caracteristica/Complemento/Outros) ligada a
20: *             cursor_4c_Itens, CommandGroup cnt_4c_Botoes (Confirmar/
21: *             Cancelar) e cmg_4c_InserirExcluir (Inserir/Excluir linha).
22: *             Celulas da grade usam TextBoxCaracteristicaDet_4c/
23: *             TextBoxComplementoDet_4c/TextBoxOutrosDet_4c (TextBoxGridLookup.
24: *             prg), que delegam para os metodos PUBLIC deste form (regra #46:
25: *             Valid/When de Column.Text1 tem de estar EMBUTIDO na classe, nao
26: *             em BINDEVENT).
27: *   Fase 5:   nada a acrescentar - o SCX SIGOPDET nao tem campo de tela.
28: *             Os 3 "BaseClass: textbox" do dump sao o Text1 NATIVO das 3
29: *             Column da Grade (Parent SIGOPDET.Grade.ColumnN - regra #18),
30: *             ja entregues na Fase 4 como TextBox subclasse. Fora deles o
31: *             dump tem so a faixa do cabecalho (cntSombra + 2 Label), os 2
32: *             CommandGroup e a Grade: ZERO campo/Label solto, nenhum
33: *             AddObject/AddProperty em runtime, e os unicos ControlSource
34: *             do legado sao os das 3 colunas. Criar um metodo de pagina
35: *             de Dados aqui seria metodo vazio (proibido pela regra de

*-- Linhas 140 a 160:
140: *             VincularColunaDet (bind da grade em FONTE UNICA),
141: *             RepintarGradeDet (regra #21) e AjustarBotoesPorModo.
142: *
143: *             Por que CarregarLista nao eh mero apelido de
144: *             CarregarDadosGrade: SigOpDetBO.CarregarItens() FECHA e
145: *             RECRIA o alias cursor_4c_Itens (USE IN + SELECT ... INTO
146: *             CURSOR ... READWRITE). Derrubar o alias sob uma grade JA
147: *             bindada zera o ColumnCount e destroi os TextBox que as
148: *             Column receberam por AddObject - a grade viraria um
149: *             retangulo branco, sem erro e sem log. Por isso o funil
150: *             reaplica o bind INTEIRO depois de recarregar
151: *             (VincularGradeDet) e so entao repinta. Na PRIMEIRA carga
152: *             (dentro de ConfigurarPageFrame) a grade ainda nao existe e
153: *             o funil apenas popula o cursor - que eh justamente a ordem
154: *             que a regra #41 exige, porque Column.ControlSource estoura
155: *             se o cursor nao existir.
156: *
157: *             O bind deixou de morar no ConfigurarGrade e passou a
158: *             VincularGradeDet/VincularColunaDet (FONTE UNICA - regra
159: *             #44, item 6): RecordSource reseta Column.Width,
160: *             Header1.Caption, Sparse e CurrentControl (regra #48), entao

*-- Linhas 342 a 356:
342:             THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
343: 
344:             *-- Caption identico ao legado ("Selecao de Detalhes")
345:             THIS.Caption = "Sele" + CHR(231) + CHR(227) + "o de Detalhes"
346: 
347:             THIS.ConfigurarPageFrame()
348: 
349:             *-- Propaga o titulo para os labels do cabecalho
350:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
351:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
352: 
353:             *-- Torna a arvore de controles visivel (AddObject cria com Visible=.F.)
354:             THIS.TornarControlesVisiveis(THIS)
355: 
356:             loc_lSucesso = .T.

*-- Linhas 374 a 459:
374:     *--------------------------------------------------------------------------
375:     PROTECTED PROCEDURE ConfigurarPageFrame()
376:         THIS.ConfigurarCabecalho()
377: 
378:         *-- Carga pelo funil UNICO (CarregarLista). Aqui a grade ainda nao
379:         *-- existe, entao o funil so popula cursor_4c_Itens - e eh essa a
380:         *-- ordem correta: Column.ControlSource estoura se o cursor nao
381:         *-- existir (regra #41), e SigOpDetBO.CarregarItens() recria o
382:         *-- alias, o que derrubaria o bind se a grade ja estivesse pronta.
383:         THIS.CarregarLista()
384: 
385:         THIS.ConfigurarGrade()
386:         THIS.ConfigurarBotoesConfirmar()
387:         THIS.ConfigurarBotoesInserirExcluir()
388: 
389:         *-- Grade pronta: GO TOP + Refresh, senao o cursor fica cheio e a
390:         *-- grade aparece vazia (regra #21)
391:         THIS.RepintarGradeDet()
392:     ENDPROC
393: 
394:     *--------------------------------------------------------------------------
395:     * CarregarDadosGrade - Popula cursor_4c_Itens (e cursor_4c_LocalFtc, o
396:     * universo de referencia) ANTES de a Grade ser montada. Em modo de
397:     * validacao de UI (sem conexao SQL - regra gb_4c_ValidandoUI), ou se a
398:     * carga real falhar, cria um cursor vazio com a MESMA estrutura (ordem
399:     * de campos identica - regra do CLAUDE.md para forms OPERACIONAIS), so
400:     * para a Grade conseguir bindar sem erro.
401:     *
402:     * Devolve .T. quando cursor_4c_Itens EXISTE no fim (com dado real ou
403:     * como placeholder): eh isso que o chamador precisa saber para decidir
404:     * se pode bindar a grade. Carga real que falha nao eh erro de fluxo -
405:     * SigOpDetBO.CarregarItens() ja exibiu a mensagem do SQL Server.
406:     *--------------------------------------------------------------------------
407:     PROTECTED PROCEDURE CarregarDadosGrade()
408:         LOCAL loc_lCarregou
409:         loc_lCarregou = .F.
410: 
411:         IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) ;
412:             AND VARTYPE(THIS.this_oBusinessObject) = "O"
413:             loc_lCarregou = THIS.this_oBusinessObject.CarregarItens()
414:         ENDIF
415: 
416:         IF !loc_lCarregou
417:             THIS.CriarCursorItensPlaceholder()
418:         ENDIF
419: 
420:         RETURN USED("cursor_4c_Itens")
421:     ENDPROC
422: 
423:     *--------------------------------------------------------------------------
424:     * CriarCursorItensPlaceholder - cursor_4c_Itens vazio, com a MESMA ordem
425:     * de campos usada em SigOpDetBO.CarregarItens()/GravarItens() (regra:
426:     * CREATE CURSOR com ordem identica em todos os locais)
427:     *--------------------------------------------------------------------------
428:     PROTECTED PROCEDURE CriarCursorItensPlaceholder()
429:         IF USED("cursor_4c_Itens")
430:             USE IN cursor_4c_Itens
431:         ENDIF
432: 
433:         CREATE CURSOR cursor_4c_Itens ;
434:             (cidchaves C(20), empdopnums C(29), cpros C(14), ;
435:              ccars C(20), ctits C(20), resps C(20), ordens N(6,0))
436:     ENDPROC
437: 
438:     *--------------------------------------------------------------------------
439:     * ConfigurarGrade - Grade de Caracteristica/Complemento/Outros (SIGOPDET.
440:     * Grade do legado). Aqui ficam SO as propriedades que nao dependem de
441:     * dado; todo o bind (ColumnCount/RecordSource/ControlSource/Width/
442:     * Header1.Caption/CurrentControl/Sparse/ReadOnly) mora em
443:     * VincularGradeDet, que eh FONTE UNICA compartilhada com CarregarLista
444:     * (regra #44, item 6) - duas copias do bind divergiriam em silencio na
445:     * primeira coluna nova.
446:     *--------------------------------------------------------------------------
447:     PROTECTED PROCEDURE ConfigurarGrade()
448:         LOCAL loc_oGrade
449: 
450:         THIS.AddObject("grd_4c_Dados", "Grid")
451:         loc_oGrade = THIS.grd_4c_Dados
452:         WITH loc_oGrade
453:             .Top           = 88
454:             .Left          = 74
455:             .Width         = 600
456:             .Height        = 405
457:             .FontName      = "Tahoma"
458:             .FontSize      = 8
459:             .DeleteMark    = .F.

*-- Linhas 465 a 517:
465: 
466:         THIS.VincularGradeDet()
467:     ENDPROC
468: 
469:     *--------------------------------------------------------------------------
470:     * VincularGradeDet - Bind COMPLETO da grade a cursor_4c_Itens. FONTE
471:     * UNICA: chamado por ConfigurarGrade (criacao) e por CarregarLista
472:     * (recarga). Precisa ser reaplicado inteiro a cada recarga porque
473:     * RecordSource reseta Column.Width, Header1.Caption, Sparse e
474:     * CurrentControl (regra #48), e porque SigOpDetBO.CarregarItens() FECHA
475:     * e RECRIA o alias - o que zera o ColumnCount e destroi os TextBox das
476:     * Column.
477:     *
478:     * ColumnCount so eh tocado quando esta diferente de 3: reatribui-lo
479:     * DESTROI os objetos Column e com eles os controles postos por
480:     * AddObject (regra do CLAUDE.md sobre ColumnCount em Carregar*).
481:     *--------------------------------------------------------------------------
482:     PROTECTED PROCEDURE VincularGradeDet()
483:         LOCAL loc_oGrade, loc_lSucesso
484:         loc_lSucesso = .F.
485: 
486:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND USED("cursor_4c_Itens")
487:             loc_oGrade = THIS.grd_4c_Dados
488: 
489:             IF loc_oGrade.ColumnCount != 3
490:                 loc_oGrade.ColumnCount = 3
491:             ENDIF
492: 
493:             loc_oGrade.RecordSource = "cursor_4c_Itens"
494: 
495:             *-- Column1 - Caracteristica | Column2 - Complemento
496:             *-- Column3 - Outros (coluna Resps - observacao livre)
497:             THIS.VincularColunaDet(loc_oGrade.Column1, "txt_4c_Caracteristica", ;
498:                 "TextBoxCaracteristicaDet_4c", "cursor_4c_Itens.ccars", 155, "Caracteristica")
499:             THIS.VincularColunaDet(loc_oGrade.Column2, "txt_4c_Complemento", ;
500:                 "TextBoxComplementoDet_4c", "cursor_4c_Itens.ctits", 155, "Complemento")
501:             THIS.VincularColunaDet(loc_oGrade.Column3, "txt_4c_Outros", ;
502:                 "TextBoxOutrosDet_4c", "cursor_4c_Itens.resps", 255, "Outros")
503: 
504:             *-- Grid.ReadOnly/Column.ReadOnly por ULTIMO e na ordem certa
505:             *-- (regra #18) - o modo de operacao manda, nao um literal
506:             THIS.AjustarBotoesPorModo()
507: 
508:             loc_lSucesso = .T.
509:         ENDIF
510: 
511:         RETURN loc_lSucesso
512:     ENDPROC
513: 
514:     *--------------------------------------------------------------------------
515:     * VincularColunaDet - Bind de UMA Column da grade de detalhes. O
516:     * TextBox de celula so eh recriado quando a Column o PERDEU (guarda
517:     * PEMSTATUS): AddObject com nome que ja existe estoura "Object is

*-- Linhas 542 a 569:
542:             .Width             = par_nWidth
543:             .Movable           = .F.
544:             .Resizable         = .F.
545:             .Header1.Caption   = par_cCaption
546:             .Header1.Alignment = 2
547:             .Header1.FontName  = "Tahoma"
548:             .Header1.FontSize  = 8
549:         ENDWITH
550:     ENDPROC
551: 
552:     *--------------------------------------------------------------------------
553:     * CarregarLista - FUNIL UNICO de carga da grade de detalhes: recarrega
554:     * cursor_4c_Itens, reaplica o bind e repinta. PUBLIC porque o harness
555:     * de teste automatico chama THIS.oForm.CarregarLista() de FORA da
556:     * classe (CLAUDE.md regra #3 - PROTECTED falharia em runtime com
557:     * "Property CARREGARLISTA is not found").
558:     *
559:     * O rebind depois da carga NAO eh zelo: SigOpDetBO.CarregarItens() faz
560:     * USE IN + SELECT ... INTO CURSOR ... READWRITE, isto eh FECHA e RECRIA
561:     * o alias que a grade usa como RecordSource. Com a grade ja bindada
562:     * isso zera o ColumnCount e destroi os TextBox das Column - a grade
563:     * vira um retangulo branco sem erro, sem log e para o RESTO da vida do
564:     * form. Na primeira chamada (ConfigurarPageFrame) a grade ainda nao
565:     * existe e o bloco de rebind eh pulado pela guarda do VincularGradeDet.
566:     *--------------------------------------------------------------------------
567:     PROCEDURE CarregarLista()
568:         LOCAL loc_lSucesso
569: 

*-- Linhas 591 a 612:
591:     *--------------------------------------------------------------------------
592:     PROTECTED PROCEDURE RepintarGradeDet()
593:         LOCAL loc_lSucesso
594:         loc_lSucesso = .F.
595: 
596:         IF USED("cursor_4c_Itens") AND PEMSTATUS(THIS, "grd_4c_Dados", 5)
597:             SELECT cursor_4c_Itens
598:             GO TOP
599:             THIS.grd_4c_Dados.Refresh()
600:             loc_lSucesso = .T.
601:         ENDIF
602: 
603:         RETURN loc_lSucesso
604:     ENDPROC
605: 
606:     *--------------------------------------------------------------------------
607:     * AjustarBotoesPorModo - Aplica o modo de operacao recebido do form
608:     * chamador (pcEscolha do legado) a superficie editavel da tela. PUBLIC
609:     * porque o harness de teste automatico tambem o chama de fora da classe
610:     * (CLAUDE.md regra #3).
611:     *
612:     * O legado trava a edicao pelo When de CADA celula (InList(pcEscolha,

*-- Linhas 678 a 701:
678:     PROTECTED PROCEDURE FormParaBO()
679:         LOCAL loc_lSucesso, loc_oErro
680:         loc_lSucesso = .F.
681: 
682:         TRY
683:             IF VARTYPE(THIS.this_oBusinessObject) = "O" AND USED("cursor_4c_Itens")
684:                 SELECT cursor_4c_Itens
685:                 IF RECCOUNT("cursor_4c_Itens") > 0 AND !EOF("cursor_4c_Itens")
686:                     loc_lSucesso = THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Itens")
687: 
688:                     THIS.this_oBusinessObject.this_cEmpDopNums = THIS.this_cEmpDopNums
689:                     THIS.this_oBusinessObject.this_cCpros      = THIS.this_cCpros
690:                 ENDIF
691:             ENDIF
692:         CATCH TO loc_oErro
693:             MsgErro(loc_oErro.Message + CHR(13) + ;
694:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
695:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpDet.FormParaBO")
696:         ENDTRY
697: 
698:         RETURN loc_lSucesso
699:     ENDPROC
700: 
701:     *--------------------------------------------------------------------------

*-- Linhas 725 a 759:
725:         LOCAL loc_lSucesso, loc_oErro
726:         LOCAL loc_cIdChave, loc_cCCars, loc_cCTits, loc_cResps, loc_nOrdens
727:         loc_lSucesso = .F.
728: 
729:         TRY
730:             IF VARTYPE(THIS.this_oBusinessObject) = "O" AND USED("cursor_4c_Itens")
731:                 SELECT cursor_4c_Itens
732:                 IF RECCOUNT("cursor_4c_Itens") > 0 AND !EOF("cursor_4c_Itens")
733:                     loc_cIdChave = LEFT(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cCIdChaves, "")), 20)
734:                     loc_cCCars   = LEFT(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cCCars,     "")), 20)
735:                     loc_cCTits   = LEFT(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cCTits,     "")), 20)
736:                     loc_cResps   = LEFT(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cResps,     "")), 20)
737:                     loc_nOrdens  = NVL(THIS.this_oBusinessObject.this_nOrdens, 0)
738: 
739:                     REPLACE cidchaves WITH loc_cIdChave, ;
740:                             ccars     WITH loc_cCCars,   ;
741:                             ctits     WITH loc_cCTits,   ;
742:                             resps     WITH loc_cResps,   ;
743:                             ordens    WITH loc_nOrdens   ;
744:                         IN cursor_4c_Itens
745: 
746:                     loc_lSucesso = .T.
747:                 ENDIF
748:             ENDIF
749:         CATCH TO loc_oErro
750:             MsgErro(loc_oErro.Message + CHR(13) + ;
751:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
752:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpDet.BOParaForm")
753:         ENDTRY
754: 
755:         RETURN loc_lSucesso
756:     ENDPROC
757: 
758:     *--------------------------------------------------------------------------
759:     * ConfigurarBotoesConfirmar - cntBotoes do legado (CommandGroup com

*-- Linhas 767 a 776:
767:         THIS.AddObject("cnt_4c_Botoes", "CommandGroup")
768:         loc_oGrp = THIS.cnt_4c_Botoes
769:         WITH loc_oGrp
770:             .Top           = -2
771:             .Left          = 642
772:             .Width         = 160
773:             .Height        = 85
774:             .ButtonCount   = 2
775:             .BackStyle     = 0
776:             .BorderStyle   = 0

*-- Linhas 791 a 810:
791: 
792:         *-- Buttons(1) = btnSair ("Cancelar")
793:         WITH loc_oGrp.Buttons(1)
794:             .Top          = 5
795:             .Left         = 80
796:             .Height       = 75
797:             .Width        = 75
798:             .AutoSize     = .F.
799:             .FontBold     = .T.
800:             .FontItalic   = .T.
801:             .FontName     = "Comic Sans MS"
802:             .FontSize     = 8
803:             .WordWrap     = .T.
804:             .Picture      = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
805:             .Caption       = "\<Cancelar"
806:             .Cancel        = .T.
807:             .MousePointer  = 15
808:             .ToolTipText   = "[Esc] Encerrar"
809:             .ForeColor     = RGB(90, 90, 90)
810:             .BackColor     = RGB(255, 255, 255)

*-- Linhas 818 a 837:
818: 
819:         *-- Buttons(2) = btnConfirmar ("Confirmar")
820:         WITH loc_oGrp.Buttons(2)
821:             .Top          = 5
822:             .Left         = 5
823:             .Height       = 75
824:             .Width        = 75
825:             .AutoSize     = .F.
826:             .FontBold     = .T.
827:             .FontItalic   = .T.
828:             .FontName     = "Comic Sans MS"
829:             .FontSize     = 8
830:             .WordWrap     = .T.
831:             .Picture      = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
832:             .Caption      = "\<Confirmar"
833:             .MousePointer = 15
834:             .ToolTipText  = "Confirmar a Sele" + CHR(231) + CHR(227) + "o"
835:             .ForeColor    = RGB(90, 90, 90)
836:             .BackColor    = RGB(255, 255, 255)
837:             .Themes       = .F.

*-- Linhas 856 a 865:
856:         THIS.AddObject("cmg_4c_InserirExcluir", "CommandGroup")
857:         loc_oGrp = THIS.cmg_4c_InserirExcluir
858:         WITH loc_oGrp
859:             .Top         = 272
860:             .Left        = 676
861:             .Width       = 50
862:             .Height      = 90
863:             .ButtonCount = 2
864:             .BackStyle   = 0
865:             .BorderStyle = 0

*-- Linhas 873 a 912:
873: 
874:         *-- Buttons(1) = cmdInserir
875:         WITH loc_oGrp.Buttons(1)
876:             .Top               = 5
877:             .Left              = 5
878:             .Height            = 40
879:             .Width             = 40
880:             .FontBold          = .T.
881:             .FontName          = "Small Fonts"
882:             .FontSize          = 7
883:             .WordWrap          = .T.
884:             .Picture           = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
885:             .Caption           = ""
886:             .ToolTipText       = "Inserir Composi" + CHR(231) + CHR(227) + "o"
887:             .ForeColor         = RGB(0, 0, 0)
888:             .BackColor         = RGB(255, 255, 255)
889:             .DisabledForeColor = RGB(128, 128, 128)
890:             .Themes            = .F.
891:             *-- SpecialEffect do dump (Command1 = cmdInserir)
892:             .SpecialEffect     = 0
893:         ENDWITH
894: 
895:         *-- Buttons(2) = cmdExcluir
896:         WITH loc_oGrp.Buttons(2)
897:             .AutoSize  = .F.
898:             .Top       = 45
899:             .Left      = 5
900:             .Height    = 40
901:             .Width     = 40
902:             .FontBold  = .T.
903:             .FontName  = "Small Fonts"
904:             .FontSize  = 7
905:             .WordWrap  = .T.
906:             .Picture       = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
907:             .Caption       = ""
908:             .ForeColor     = RGB(0, 0, 0)
909:             .BackColor     = RGB(255, 255, 255)
910:             .Themes        = .F.
911:             *-- SpecialEffect do dump (Command2 = cmdExcluir). O legado NAO
912:             *-- declara ToolTipText neste botao - nao inventar (PILAR 1).

*-- Linhas 933 a 954:
933:     *--------------------------------------------------------------------------
934:     PROCEDURE GradeDetOutrosEditavel()
935:         LOCAL loc_lEditavel
936:         loc_lEditavel = .F.
937: 
938:         IF USED("cursor_4c_Itens") AND THIS.GradeDetEditavel()
939:             loc_lEditavel = EMPTY(ALLTRIM(NVL(cursor_4c_Itens.ctits, "")))
940:         ENDIF
941: 
942:         RETURN loc_lEditavel
943:     ENDPROC
944: 
945:     *--------------------------------------------------------------------------
946:     * ValidarCaracteristicaDetExec - Valid de Column1.txt_4c_Caracteristica
947:     * (legado: busca em LocalFtc; se nao achar exato, abre o picker sobre o
948:     * proprio universo - fwbuscaint no legado, FormBuscaSimples aqui, porque
949:     * o universo e um CURSOR local, nao uma tabela SQL Server). PUBLIC -
950:     * chamado via THISFORM pela TextBox subclass (regra #3/#46).
951:     *--------------------------------------------------------------------------
952:     PROCEDURE ValidarCaracteristicaDetExec(par_oTxt)
953:         LOCAL loc_cValor
954: 

*-- Linhas 1037 a 1058:
1037:     *--------------------------------------------------------------------------
1038:     PROCEDURE ValidarComplementoDetExec(par_oTxt)
1039:         LOCAL loc_cValor, loc_cCCars
1040: 
1041:         loc_cCCars = ""
1042:         IF USED("cursor_4c_Itens")
1043:             loc_cCCars = ALLTRIM(NVL(cursor_4c_Itens.ccars, ""))
1044:         ENDIF
1045: 
1046:         loc_cValor = UPPER(ALLTRIM(par_oTxt.Value))
1047: 
1048:         IF EMPTY(loc_cValor)
1049:             par_oTxt.Value = ""
1050:         ELSE
1051:             IF USED("cursor_4c_SigOpDetLocalTits")
1052:                 USE IN cursor_4c_SigOpDetLocalTits
1053:             ENDIF
1054: 
1055:             IF USED("cursor_4c_LocalFtc")
1056:                 SELECT DISTINCT ctits, descrs FROM cursor_4c_LocalFtc ;
1057:                     WHERE ccars = loc_cCCars INTO CURSOR cursor_4c_SigOpDetLocalTits READWRITE
1058:             ENDIF

*-- Linhas 1130 a 1154:
1130:     PROCEDURE GarantirLinhaVaziaGradeDet(par_oTxt)
1131:         IF VARTYPE(par_oTxt) != "O" OR EMPTY(ALLTRIM(NVL(par_oTxt.Value, "")))
1132:             RETURN
1133:         ENDIF
1134: 
1135:         IF VARTYPE(THIS.this_oBusinessObject) != "O" OR !USED("cursor_4c_Itens")
1136:             RETURN
1137:         ENDIF
1138: 
1139:         SELECT cursor_4c_Itens
1140:         LOCATE FOR EMPTY(ccars)
1141:         IF EOF()
1142:             THIS.this_oBusinessObject.InserirLinhaPadrao()
1143:         ENDIF
1144: 
1145:         KEYBOARD "{DNARROW}"
1146:         THIS.grd_4c_Dados.Refresh()
1147:         THIS.grd_4c_Dados.Column1.SetFocus()
1148:     ENDPROC
1149: 
1150:     *--------------------------------------------------------------------------
1151:     * BtnInserirDetClick - cmdInserir.Click do legado (guard de modo +
1152:     * garante linha em branco no fim + foca Column1)
1153:     *--------------------------------------------------------------------------
1154:     PROCEDURE BtnInserirDetClick()

*-- Linhas 1264 a 1312:
1264:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
1265:         loc_oCab = THIS.cnt_4c_Cabecalho
1266:         WITH loc_oCab
1267:             .Top         = 0
1268:             .Left        = 0
1269:             .Width       = THIS.Width
1270:             .Height      = 80
1271:             .BorderWidth = 0
1272:             .BackStyle   = 1
1273:             .BackColor   = RGB(100, 100, 100)
1274:         ENDWITH
1275: 
1276:         *-- Labels adicionados FORA do WITH do container: WITH aninhado com
1277:         *-- AddObject ignora propriedades silenciosamente (CLAUDE.md #33)
1278:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
1279:         WITH loc_oCab.lbl_4c_Sombra
1280:             .FontBold  = .T.
1281:             .FontName  = "Tahoma"
1282:             .FontSize  = 18
1283:             .WordWrap  = .T.
1284:             .AutoSize  = .F.
1285:             .Alignment = 0
1286:             .BackStyle = 0
1287:             .Caption   = ""
1288:             .Height    = 40
1289:             .Left      = 10
1290:             .Top       = 18
1291:             .Width     = 769
1292:             .ForeColor = RGB(0, 0, 0)
1293:         ENDWITH
1294: 
1295:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
1296:         WITH loc_oCab.lbl_4c_Titulo
1297:             .FontBold  = .T.
1298:             .FontName  = "Tahoma"
1299:             .FontSize  = 18
1300:             .WordWrap  = .T.
1301:             .AutoSize  = .F.
1302:             .Alignment = 0
1303:             .BackStyle = 0
1304:             .Caption   = ""
1305:             .Height    = 46
1306:             .Left      = 10
1307:             .Top       = 17
1308:             .Width     = 769
1309:             .ForeColor = RGB(255, 255, 255)
1310:         ENDWITH
1311:     ENDPROC
1312: 

*-- Linhas 1345 a 1357:
1345:     *--------------------------------------------------------------------------
1346:     PROCEDURE Destroy()
1347:         IF USED("cursor_4c_LocalFtc")
1348:             USE IN cursor_4c_LocalFtc
1349:         ENDIF
1350:         IF USED("cursor_4c_Itens")
1351:             USE IN cursor_4c_Itens
1352:         ENDIF
1353: 
1354:         DODEFAULT()
1355:     ENDPROC
1356: 
1357: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpDetBO.prg):
*==============================================================================
* SigOpDetBO.prg - Business Object para o dialogo de Selecao de Detalhes
* (Caracteristicas/Complementos de Produto) - SIGOPDET
*
* Form OPERACIONAL de DIALOGO (WindowType = 1, TitleBar = 0, ControlBox = .F.,
* AutoCenter = .T., AlwaysOnTop = .T., Height = 500, Width = 800) aberto por um
* form PAI - o Init legado recebe "LParameters pCnx, pEscolha, pDopes, pProd,
* pEDN" (pCnx = ThisForm.poDataMgr, nao portado - este ambiente usa o handle
* global gnConnHandle).
*
* OBJETIVO DO DIALOGO
* --------------------
* Exibir, numa grade de 3 colunas (Caracteristica / Complemento / Outros), as
* linhas de SigMvFtc associadas a um item de movimento (par EmpDopNums+Cpros)
* e permitir ao usuario escolher, para cada linha, uma Caracteristica (coluna
* ccars, validada contra SigCrRap) e um Complemento (coluna ctits, validado
* contra SigPrCpP), alem de digitar uma observacao livre (coluna resps).
*
* O universo de Caracteristicas/Complementos permitido para o par
* Grupo (pDopes, equivale a SigCdFtc.cgrus) + Grande Grupo do produto
* (SigCdPro.Mercs) vem de SigCdFtc (filtrada por ntipos = 2), unida com
* SigCrRap (descricao + flag chkobrig - caracteristica obrigatoria) e
* SigPrCpP (descricao do complemento). Essa lista NAO tem tabela propria no
* dialogo - fica numa cursor de referencia (equivalente ao LocalFtc do
* legado), carregada por metodo a implementar na Fase 2.
*
* TABELA PRINCIPAL (persistida e editada por este dialogo): SigMvFtc
*   cidchaves  char(20) NOT NULL  - PK (fUniqueIds() por linha, regra #22)
*   empdopnums char(29) NOT NULL  - chave do movimento (par_cEmpDopNums)
*   cpros      char(14) NOT NULL  - codigo do produto (par_cCpros)
*   ccars      char(20) NOT NULL  - caracteristica selecionada na linha
*   ctits      char(20) NOT NULL  - complemento selecionado na linha
*   resps      char(20) NOT NULL  - observacao/resposta digitada na linha
*   ordens     numeric(6,0) NOT NULL - ordem da linha (sem DEFAULT no schema -
*                                      o legado nunca grava no INSERT da
*                                      cursor local; a Fase 2 precisa decidir
*                                      um valor antes do INSERT real na tabela
*                                      - regra #22)
*
* PARAMETROS RECEBIDOS DO FORM PAI (Init legado, sem o pCnx que nao existe
* mais neste ambiente):
*   this_cModoOperacao - pEscolha (INSERIR/ALTERAR/VISUALIZAR/etc) - decide se
*                        as colunas da grade aceitam edicao (When do legado:
*                        InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR'))
*   this_cGrupo        - pDopes (SigCdFtc.cgrus) - grupo de caracteristicas
*   this_cCpros        - pProd (SigCdPro.Cpros) - produto do item de movimento
*   this_cEmpDopNums   - pEDN (chave do item de movimento, SigMvCab/SigMvItn)
*
* DADO DE REFERENCIA CARREGADO A PARTIR DO PRODUTO (Fase 2):
*   this_cMercs - SigCdPro.Mercs (Grande Grupo do produto), obtido via
*                 CursorQuery/SQLEXEC em SigCdPro WHERE Cpros = this_cCpros.
*                 Usado para filtrar SigCrRap.cgrus = this_cMercs na consulta
*                 da lista de Caracteristicas/Complementos permitidos.
*
* PROPRIEDADES DA LINHA CORRENTE DA GRADE (SigMvFtc - uma linha por vez, no
* padrao de validacao de celula da grade - regra #46: Valid do TextBox da
* coluna, nunca AfterRowColChange):
*   this_cCIdChaves - cidchaves da linha corrente
*   this_cCCars     - ccars da linha corrente (Caracteristica)
*   this_cCTits     - ctits da linha corrente (Complemento)
*   this_cResps     - resps da linha corrente (observacao)
*   this_nOrdens    - ordens da linha corrente
*
* METODOS DE CARGA/PERSISTENCIA DA GRADE (Fase 4):
*   CarregarProduto()        - le SigCdPro para obter this_cMercs
*   CarregarListaReferencia() - popula cursor_4c_LocalFtc (equivalente ao
*                               LocalFtc do legado - join SigCdFtc+SigCrRap+
*                               SigPrCpP)
*   CarregarItens()          - orquestra CarregarProduto+CarregarListaReferencia
*                               e popula cursor_4c_Itens a partir de SigMvFtc
*                               (equivalente ao Init legado), garantindo uma
*                               linha para cada caracteristica obrigatoria
*   InserirLinhaPadrao()     - garante linha em branco no final da grade
*                               (cmdInserir.Click do legado)
*   ExcluirLinhaAtual()      - remove a linha corrente (cmdExcluir.Click)
*   Validacao()              - confere que toda Caracteristica obrigatoria
*                               (SigCrRap.chkobrig=1) tem linha preenchida;
*                               se ok, descarta as linhas em branco
*   GravarItens()            - persiste as linhas sobreviventes em SigMvFtc
*                               (Confirmar/Cancelar do legado - equivalente
*                               ao TABLEUPDATE automatico do cursor remoto
*                               buffered, que este ambiente nao possui)
*   ObterChavePrimaria()      - retorna this_cCIdChaves (ALLTRIM)
*
* Lookup de Caracteristica/Complemento (ValidarCaracteristica/
* ValidarComplemento, equivalentes ao fwbuscaint do legado) vivem no FORM
* (TextBoxGridLookup.prg - regra #46: Valid do TextBox da coluna), nao no BO,
* porque dependem diretamente do TextBox da celula.
*
* Este dialogo PERSISTE uma tabela propria (SigMvFtc, ao contrario de
* SigOpCtsBO/SigOpAutBO) via GravarItens()/Inserir().
*
* Fase 4/8 (atual): carga/persistencia completa da grade.
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS SigOpDetBO AS BusinessBase

    *-- Parametros recebidos do form pai na abertura (Init legado: pEscolha,
    *-- pDopes, pProd, pEDN - sem pCnx, que nao existe mais neste ambiente)
    this_cModoOperacao = ""    && pEscolha - INSERIR/ALTERAR/VISUALIZAR/etc
    this_cGrupo        = ""    && pDopes - SigCdFtc.cgrus (grupo de caracteristicas)
    this_cCpros        = ""    && pProd - SigCdPro.Cpros (produto do item de movimento)
    this_cEmpDopNums   = ""    && pEDN - chave do item de movimento (SigMvCab/SigMvItn)

    *-- Dado de referencia obtido a partir do produto (Fase 2:
    *-- CarregarProduto) - usado para filtrar o universo de Caracteristicas/
    *-- Complementos permitidos (SigCrRap.cgrus = this_cMercs)
    this_cMercs = ""            && SigCdPro.Mercs - Grande Grupo do produto

    *-- Propriedades da entidade (mapeamento para tabela SigMvFtc - linha
    *-- corrente da grade, uma linha por vez)
    this_cCIdChaves = ""         && cidchaves char(20) NOT NULL - PK
    this_cCCars     = ""         && ccars char(20) NOT NULL - Caracteristica
    this_cCTits     = ""         && ctits char(20) NOT NULL - Complemento
    this_cResps     = ""         && resps char(20) NOT NULL - observacao da linha
    this_nOrdens    = 0          && ordens numeric(6,0) NOT NULL - ordem da linha

    *====================================================================
    * Init - Inicializa Business Object
    * par_cModoOperacao - pEscolha do legado (INSERIR/ALTERAR/VISUALIZAR)
    * par_cGrupo        - pDopes do legado (SigCdFtc.cgrus)
    * par_cCpros        - pProd do legado (SigCdPro.Cpros)
    * par_cEmpDopNums   - pEDN do legado (chave do item de movimento)
    *====================================================================
    PROCEDURE Init(par_cModoOperacao, par_cGrupo, par_cCpros, par_cEmpDopNums)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigMvFtc"
            THIS.this_cCampoChave = "cidchaves"

            THIS.this_cModoOperacao = IIF(VARTYPE(par_cModoOperacao) = "C", ;
                ALLTRIM(par_cModoOperacao), "")
            THIS.this_cGrupo        = IIF(VARTYPE(par_cGrupo) = "C", ;
                ALLTRIM(par_cGrupo), "")
            THIS.this_cCpros        = IIF(VARTYPE(par_cCpros) = "C", ;
                ALLTRIM(par_cCpros), "")
            THIS.this_cEmpDopNums   = IIF(VARTYPE(par_cEmpDopNums) = "C", ;
                ALLTRIM(par_cEmpDopNums), "")

            THIS.this_cMercs = ""

            THIS.this_cCIdChaves = ""
            THIS.this_cCCars     = ""
            THIS.this_cCTits     = ""
            THIS.this_cResps     = ""
            THIS.this_nOrdens    = 0

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades da LINHA CORRENTE da grade
    * a partir de um cursor de SigMvFtc (regra #46: a validacao de celula
    * fica no Valid do TextBox da coluna, que le este metodo depois de
    * posicionar o cursor na linha da grade - nao em AfterRowColChange)
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCIdChaves  = TratarNulo(cidchaves,  "C")
                THIS.this_cEmpDopNums = TratarNulo(empdopnums, "C")
                THIS.this_cCpros      = TratarNulo(cpros,      "C")
                THIS.this_cCCars      = TratarNulo(ccars,      "C")
                THIS.this_cCTits      = TratarNulo(ctits,      "C")
                THIS.this_cResps      = TratarNulo(resps,      "C")
                THIS.this_nOrdens     = TratarNulo(ordens,     "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna cidchaves da linha corrente (PK de
    * SigMvFtc), usada por RegistrarAuditoria em Inserir/Atualizar
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCIdChaves)
    ENDPROC

    *====================================================================
    * Inserir - Insere uma nova linha (Caracteristica/Complemento/Resposta)
    * em SigMvFtc para o item de movimento corrente (this_cEmpDopNums +
    * this_cCpros, fixos para o dialogo inteiro - regra #22: cidchaves
    * gerado por fUniqueIds(), nunca string vazia, para nao colidir no
    * indice unico quando a grade tiver mais de uma linha)
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCIdChaves)
                THIS.this_cCIdChaves = fUniqueIds()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigMvFtc (cidchaves, empdopnums, cpros, ccars, ctits, resps, ordens)
                VALUES (
                    <<EscaparSQL(THIS.this_cCIdChaves)>>,
                    <<EscaparSQL(THIS.this_cEmpDopNums)>>,
                    <<EscaparSQL(THIS.this_cCpros)>>,
                    <<EscaparSQL(THIS.this_cCCars)>>,
                    <<EscaparSQL(THIS.this_cCTits)>>,
                    <<EscaparSQL(THIS.this_cResps)>>,
                    <<FormatarNumeroSQL(THIS.this_nOrdens, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir linha de detalhe:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza a linha corrente (ccars/ctits/resps/ordens) de
    * SigMvFtc pela chave cidchaves. Nao atualiza empdopnums/cpros (fixos
    * para o item de movimento corrente)
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigMvFtc
                SET ccars  = <<EscaparSQL(THIS.this_cCCars)>>,
                    ctits  = <<EscaparSQL(THIS.this_cCTits)>>,
                    resps  = <<EscaparSQL(THIS.this_cResps)>>,
                    ordens = <<FormatarNumeroSQL(THIS.this_nOrdens, 0)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCIdChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar linha de detalhe:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarProduto - Le SigCdPro para obter this_cMercs (Grande Grupo
    * do produto), usado para filtrar o universo de Caracteristicas/
    * Complementos permitidos (equivale ao CursorQuery('SigCdPro',
    * 'crProduto','Cpros',ThisForm.pcPro,'Mercs, Cpros') do Init legado)
    *====================================================================
    PROTECTED PROCEDURE CarregarProduto()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_SigOpDetProd")
                USE IN cursor_4c_SigOpDetProd
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT mercs FROM SigCdPro WHERE cpros = <<EscaparSQL(THIS.this_cCpros)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpDetProd")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_SigOpDetProd") AND RECCOUNT("cursor_4c_SigOpDetProd") > 0
                    THIS.this_cMercs = TratarNulo(cursor_4c_SigOpDetProd.mercs, "C")
                ELSE
                    THIS.this_cMercs = ""
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar o produto do item:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_SigOpDetProd")
                USE IN cursor_4c_SigOpDetProd
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.CarregarProduto")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarListaReferencia - Monta cursor_4c_LocalFtc (equivalente ao
    * LocalFtc do legado): universo de Caracteristicas/Complementos
    * permitidos para o par Grupo (this_cGrupo = SigCdFtc.cgrus) + Grande
    * Grupo do produto (this_cMercs), com a descricao da caracteristica
    * (SigCrRap.descrs AS Desccars) e do complemento (SigPrCpP.descrs, SEM
    * alias - os nomes finais tem de bater com os das sub-consultas feitas
    * pelo Form em cima deste cursor: "Desccars" e "descrs")
    *====================================================================
    PROTECTED PROCEDURE CarregarListaReferencia()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_LocalFtc")
                USE IN cursor_4c_LocalFtc
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT a.ccars, b.descrs AS Desccars, a.ctits, b.chkobrig, c.descrs, a.cgrus AS Dopes
                FROM SigCdFtc a
                INNER JOIN SigCrRap b ON a.ccars = b.codigos
                INNER JOIN SigPrCpP c ON a.ctits = c.codigos
                WHERE a.ntipos = 2
                AND a.cgrus = <<EscaparSQL(THIS.this_cGrupo)>>
                AND b.cgrus = <<EscaparSQL(THIS.this_cMercs)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalFtc")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar a lista de caracter" + CHR(237) + "sticas/complementos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.CarregarListaReferencia")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarItens - Orquestra a carga completa do dialogo (equivalente
    * ao Init legado, do CursorQuery do produto em diante): CarregarProduto,
    * CarregarListaReferencia, popula cursor_4c_Itens (equivalente a
    * crSigMvFtc) a partir de SigMvFtc filtrado por this_cEmpDopNums +
    * this_cCpros, e garante uma linha para CADA caracteristica obrigatoria
    * (SigCrRap.chkobrig = 1) que ainda nao esteja representada
    * (regra do legado: "Insert Into crSigMvFtc (...) Values (...)" dentro
    * do SCAN de CarsObrigs).
    *
    * cursor_4c_Itens nasce de um alias TEMPORARIO + SELECT INTO CURSOR
    * READWRITE (SQLEXEC() sozinho cria cursor so-leitura - a grade do Form
    * precisa editar celulas).
    *====================================================================
    PROCEDURE CarregarItens()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCarObrig, loc_nOrdem
        loc_lSucesso = .F.

        TRY
            IF !THIS.CarregarProduto()
                loc_lSucesso = .F.
            ELSE
                IF !THIS.CarregarListaReferencia()
                    loc_lSucesso = .F.
                ELSE
                    IF USED("cursor_4c_SigOpDetItensTmp")
                        USE IN cursor_4c_SigOpDetItensTmp
                    ENDIF

                    TEXT TO loc_cSQL TEXTMERGE NOSHOW
                        SELECT cidchaves, empdopnums, cpros, ccars, ctits, resps, ordens
                        FROM SigMvFtc
                        WHERE empdopnums = <<EscaparSQL(THIS.this_cEmpDopNums)>>
                        AND cpros = <<EscaparSQL(THIS.this_cCpros)>>
                    ENDTEXT

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpDetItensTmp")

                    IF loc_nResultado < 0
                        MostrarErro("Erro ao carregar os detalhes do item:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ELSE
                        IF USED("cursor_4c_Itens")
                            USE IN cursor_4c_Itens
                        ENDIF
                        SELECT * FROM cursor_4c_SigOpDetItensTmp INTO CURSOR cursor_4c_Itens READWRITE
                        IF USED("cursor_4c_SigOpDetItensTmp")
                            USE IN cursor_4c_SigOpDetItensTmp
                        ENDIF

                        *-- Garante uma linha para cada caracteristica obrigatoria
                        *-- ainda nao representada (legado: Insert dentro do Scan)
                        IF USED("cursor_4c_SigOpDetObrigs")
                            USE IN cursor_4c_SigOpDetObrigs
                        ENDIF
                        SELECT DISTINCT ccars, desccars FROM cursor_4c_LocalFtc ;
                            WHERE chkobrig = 1 INTO CURSOR cursor_4c_SigOpDetObrigs READWRITE

                        loc_nOrdem = 0
                        SELECT cursor_4c_Itens
                        GO TOP
                        LOCATE FOR !EMPTY(ccars)
                        IF !EOF()
                            loc_nOrdem = RECCOUNT("cursor_4c_Itens")
                        ENDIF

                        IF USED("cursor_4c_SigOpDetObrigs")
                            SELECT cursor_4c_SigOpDetObrigs
                            SCAN
                                loc_cCarObrig = ccars
                                SELECT cursor_4c_Itens
                                LOCATE FOR ccars = loc_cCarObrig
                                IF !FOUND()
                                    loc_nOrdem = loc_nOrdem + 1
                                    INSERT INTO cursor_4c_Itens (cidchaves, empdopnums, cpros, ccars, ordens) ;
                                        VALUES (fUniqueIds(), THIS.this_cEmpDopNums, THIS.this_cCpros, loc_cCarObrig, loc_nOrdem)
                                ENDIF
                                SELECT cursor_4c_SigOpDetObrigs
                            ENDSCAN
                            USE IN cursor_4c_SigOpDetObrigs
                        ENDIF

                        SELECT cursor_4c_Itens
                        GO TOP
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.CarregarItens")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * InserirLinhaPadrao - Garante que exista uma linha em branco no final
    * de cursor_4c_Itens para o usuario preencher (equivalente ao
    * cmdInserir.Click do legado: so cria se nao houver NENHUMA linha com
    * CCars vazio)
    *====================================================================
    PROCEDURE InserirLinhaPadrao()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Itens")
                SELECT cursor_4c_Itens
                GO TOP
                LOCATE FOR EMPTY(ccars)
                IF EOF()
                    INSERT INTO cursor_4c_Itens (cidchaves, empdopnums, cpros, ordens) ;
                        VALUES (fUniqueIds(), THIS.this_cEmpDopNums, THIS.this_cCpros, RECCOUNT("cursor_4c_Itens") + 1)
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.InserirLinhaPadrao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExcluirLinhaAtual - Remove a linha corrente de cursor_4c_Itens
    * (equivalente ao cmdExcluir.Click do legado)
    *====================================================================
    PROCEDURE ExcluirLinhaAtual()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Itens")
                SELECT cursor_4c_Itens
                IF !EOF()
                    DELETE
                ENDIF
                IF !EOF()
                    SKIP
                    SKIP -1
                ENDIF
                GO BOTTOM
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.ExcluirLinhaAtual")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Validacao - Confere que toda Caracteristica obrigatoria (SigCrRap.
    * chkobrig = 1) para o par Grupo/Grande Grupo tem uma linha preenchida
    * em cursor_4c_Itens; se faltar alguma, avisa e devolve .F. (mesma
    * mensagem do legado). Se tudo ok, apaga as linhas em branco (Delete
    * From crSigMvFtc where Empty(CCars) do legado) e devolve .T.
    *====================================================================
    FUNCTION Validacao()
        LOCAL loc_lOk, loc_cCarObrig, loc_cDescObrig, loc_cMsg
        loc_lOk  = .T.
        loc_cMsg = ""

        TRY
            IF USED("cursor_4c_SigOpDetObrigs")
                USE IN cursor_4c_SigOpDetObrigs
            ENDIF

            IF USED("cursor_4c_LocalFtc")
                SELECT DISTINCT ccars, desccars FROM cursor_4c_LocalFtc ;
                    WHERE chkobrig = 1 INTO CURSOR cursor_4c_SigOpDetObrigs READWRITE

                IF USED("cursor_4c_SigOpDetObrigs")
                    SELECT cursor_4c_SigOpDetObrigs
                    SCAN
                        loc_cCarObrig  = ccars
                        loc_cDescObrig = desccars

                        IF USED("cursor_4c_Itens")
                            SELECT cursor_4c_Itens
                            LOCATE FOR ccars = loc_cCarObrig
                            IF !FOUND()
                                loc_cMsg = loc_cMsg + ALLTRIM(loc_cDescObrig) + CHR(13) + CHR(10)
                                loc_lOk = .F.
                            ENDIF
                        ELSE
                            loc_cMsg = loc_cMsg + ALLTRIM(loc_cDescObrig) + CHR(13) + CHR(10)
                            loc_lOk = .F.
                        ENDIF

                        IF !loc_lOk
                            EXIT
                        ENDIF
                        SELECT cursor_4c_SigOpDetObrigs
                    ENDSCAN
                    USE IN cursor_4c_SigOpDetObrigs
                ENDIF
            ENDIF

            IF !loc_lOk
                MsgAviso("Existem Caracteristicas Obrigat" + CHR(243) + "rias e n" + CHR(227) + "o Foram Informadas." + CHR(13) + CHR(10) + ;
                    CHR(13) + CHR(10) + loc_cMsg + CHR(13) + CHR(10) + "Verifique.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF USED("cursor_4c_Itens")
                    DELETE FROM cursor_4c_Itens WHERE EMPTY(ccars)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.Validacao")
            loc_lOk = .F.
        ENDTRY

        RETURN loc_lOk
    ENDFUNC

    *====================================================================
    * GravarItens - Persiste as linhas sobreviventes de cursor_4c_Itens
    * (apos Validacao() ja ter descartado as em branco) em SigMvFtc. O
    * item de movimento (this_cEmpDopNums + this_cCpros) e gravado por
    * completo: apaga tudo que ja existia na tabela para o item e regrava
    * cada linha corrente do cursor - equivalente, para esta tela, ao
    * TABLEUPDATE automatico do cursor remoto buffered do legado
    * (crSigMvFtc), que este ambiente nao possui.
    *====================================================================
    PROCEDURE GravarItens()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nOrdem
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                DELETE FROM SigMvFtc
                WHERE empdopnums = <<EscaparSQL(THIS.this_cEmpDopNums)>>
                AND cpros = <<EscaparSQL(THIS.this_cCpros)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MostrarErro("Erro ao limpar os detalhes anteriores do item:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
                loc_nOrdem = 0

                IF USED("cursor_4c_Itens")
                    SELECT cursor_4c_Itens
                    SCAN FOR !DELETED() AND !EMPTY(ccars)
                        loc_nOrdem = loc_nOrdem + 1

                        THIS.this_cCIdChaves = TratarNulo(cidchaves, "C")
                        THIS.this_cCCars     = TratarNulo(ccars,     "C")
                        THIS.this_cCTits     = TratarNulo(ctits,     "C")
                        THIS.this_cResps     = TratarNulo(resps,     "C")
                        THIS.this_nOrdens    = loc_nOrdem

                        IF EMPTY(THIS.this_cCIdChaves)
                            THIS.this_cCIdChaves = fUniqueIds()
                        ENDIF

                        IF !THIS.Inserir()
                            loc_lSucesso = .F.
                            EXIT
                        ENDIF

                        SELECT cursor_4c_Itens
                    ENDSCAN
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.GravarItens")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

