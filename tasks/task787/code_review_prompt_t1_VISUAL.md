# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigoppop.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2486 linhas total):

*-- Linhas 32 a 58:
32: * (modeless) - NAO transcrito literalmente: regra CLAUDE.md
33: * "WindowType 0 transcrito do SCX mata a tela" - usado WindowType=1
34: * (modal), mesmo padrao de Formsigopfin/Formsigopind/Formsigoppag.
35: *
36: * Mapeamento (tasks/task787/mapeamento.json): SIGOPPOP.cntSombra ->
37: * cnt_4c_Sombra, .lblSombra -> lbl_4c_LblSombra, .lblTitulo ->
38: * lbl_4c_LblTitulo.
39: *
40: * FASE 3/8 - ESTRUTURA BASE (esta fase): DEFINE CLASS, propriedades
41: * visuais, Init()/Destroy(), InicializarForm() (cria sigoppopBO +
42: * fundo new_background.jpg) e ConfigurarLayout() com SO a faixa do
43: * cabecalho (ConfigurarCabecalho - cnt_4c_Sombra) e o container vazio
44: * que vai hospedar o CommandGroup de acao (cnt_4c_Botoes, posicionado
45: * na bbox de cmdBtnForm do dump - Top=-2/Left=769/Width=235/Height=85,
46: * flutuante/transparente sobre a faixa, regra CLAUDE.md #11: criado
47: * DEPOIS da faixa para desenhar por cima). O CommandGroup cmg_4c_
48: * CmdBtnForm (Limpar/Copiar/Encerrar) entra dentro deste container em
49: * fase posterior.
50: *
51: * FASE 4/8 - GRADE + BOTOES DE LINHA (layout FLAT, sem PageFrame,
52: * mesmo padrao de Formsigoppag): cnt_4c_Grade (equivalente a cntGrade)
53: * hospedando grd_4c_Dados (equivalente a GrdOperacoes, 11 colunas -
54: * Check1 de marcacao + Codigo/Data/Valor/Documento/Usuario/Origem/
55: * Destino/Orig./Dest./Movimentacao, regra #18
56: * Column.AddObject+CurrentControl+Sparse para a coluna de check) +
57: * cmg_4c_CmdBtnGrade (equivalente a cmdBtnGrade - Selecionar Tudo/
58: * Desmarcar/Documentos) + o funil CarregarLista() ligado a

*-- Linhas 73 a 112:
73: * para repintar depois de popular.
74: *
75: * FASE 5/8 - CAMPOS PRINCIPAIS (PARTE 1) - esta fase: cnt_4c_Operacoes
76: * (equivalente a cntOperacoes do dump) com lbl_4c_TituloOperacoes
77: * (titulo em negrito "Operacoes" - Label1 do dump), obj_4c_OptProcessados
78: * (OptionGroup "Nao Processadas"/"Ja Processadas" - 2 botoes, INDICE,
79: * regra "numeric(1,0) de 2 opcoes nao eh logica" - NUNCA converter para
80: * logico), lbl_4c_Processo + cbo_4c_CmbOperacoes (Processo de Copia -
81: * RowSourceType=2/Alias sobre this_cCursorProcessos, populado por
82: * sigoppopBO.CarregarProcessos() a partir de SigPcOoP.processos char(20);
83: * o legado le o texto selecionado via ListItem(ListIndex), NAO por
84: * codigos numeric - no migrado o equivalente e ler cbo.Value, que e o
85: * mesmo texto pela ColumnCount=1), lbl_4c_Periodo + txt_4c_DtIni +
86: * lbl_4c_Ate + txt_4c_DtFin (periodo - Value inicial = DATE(), igual ao
87: * Init legado), cmd_4c_CmdSelecionar (botao que dispara Selecionar()),
88: * chk_4c_Fwcheckbox1 (CheckBox grafico Picture=consultar.bmp que liga
89: * ThisForm.ShowTips - comportamento.json InteractiveChange) e
90: * chk_4c_ChkMensa (Exibir Mensagens de Erro - .Value NUMERICO, regra
91: * CLAUDE.md, NUNCA .T./.F.). BINDEVENT dos eventos (Click/
92: * InteractiveChange) fica para a Fase 7/8, junto com os demais botoes
93: * do form.
94: *
95: * Colisao de nome resolvida (regra "nomes legado diferem so na caixa
96: * colidem"): mapeamento.json mapeia TANTO Say1 ("Periodo :") QUANTO
97: * Label1 ("Operacoes") para "lbl_4c_Label1" - sao dois Labels distintos
98: * no MESMO container (cntOperacoes), e usar o mesmo nome AddObject
99: * estouraria "object already exists". Say1 ficou lbl_4c_Periodo (label
100: * de campo) e Label1 ficou lbl_4c_TituloOperacoes (titulo de secao em
101: * negrito, Left=13/Top=3/AutoSize=.T.) - nomes diferentes do mapeamento
102: * gerado, documentados aqui.
103: *
104: * Say2 (Caption = "?" no dump/layout.json, Left=464 entre getDtIni e
105: * getDtFin) - a extracao corrompeu o caractere; pela posicao (entre as
106: * duas datas do periodo) e o padrao "Periodo : <DtIni> a <DtFin>", o
107: * texto original e a preposicao "a". Migrado como lbl_4c_Ate = "a".
108: *
109: * FASE 6/8 (esta fase) - CAMPOS RESTANTES E LOOKUPS (PARTE 2):
110: * cnt_4c_Filtro (equivalente a cntFiltro do dump) com os 4 campos de
111: * empresa origem/destino (txt_4c_EmpOs/txt_4c_DEmpOs/txt_4c_EmpDs/
112: * txt_4c_DEmpDs) e cnt_4c_Complemento (equivalente a cntComplemento)

*-- Linhas 136 a 144:
136: * LimpaSelecao()/Processamento()/Release do legado, dump:
137: * sigoppop_form_codigo_fonte.txt:10809-10897) e de cmg_4c_CmdBtnGrade
138: * (btnMarcaTudo/btnDesmarcar/btnDocumentos, dump:10488-10513), Click
139: * de cmd_4c_CmdSelecionar (equivalente ao Valid legado "ThisForm.
140: * Selecionar()", dump:10713-10715 - migrado para "Click", que e o
141: * evento confiavel para CommandButton via BINDEVENT neste projeto) e
142: * os 4 handlers (Click/KeyPress/MouseDown/MouseUp, todos NODEFAULT) da
143: * coluna de marcacao da grade (regra CLAUDE.md #46 - Valid/KeyPress da
144: * celula, NUNCA AfterRowColChange; dump:10525-10575).

*-- Linhas 335 a 402:
335:     ENDPROC
336: 
337:     *====================================================================
338:     * ConfigurarCabecalho - faixa cinza do topo com o titulo do form.
339:     * Nomes conforme tasks/task787/mapeamento.json (SIGOPPOP.cntSombra/
340:     * lblSombra/lblTitulo -> cnt_4c_Sombra/lbl_4c_LblSombra/
341:     * lbl_4c_LblTitulo). Width usa THIS.Width (canonico do projeto) em
342:     * vez do literal 1004 do dump, que extrapola o Width=1000 do form.
343:     * Caption dos labels fica .Caption = THIS.Caption (equivalente ao
344:     * "ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption" do
345:     * Init legado), nao o texto generico "Cadastro de Testes" do dump.
346:     *====================================================================
347:     PROTECTED PROCEDURE ConfigurarCabecalho()
348:         LOCAL loc_oCnt, loc_oErro
349: 
350:         TRY
351:             THIS.AddObject("cnt_4c_Sombra", "Container")
352:             loc_oCnt = THIS.cnt_4c_Sombra
353:             WITH loc_oCnt
354:                 .Top           = 0
355:                 .Left          = 0
356:                 .Width         = THIS.Width
357:                 .Height        = 80
358:                 .BackStyle     = 1
359:                 .BackColor     = RGB(100, 100, 100)
360:                 .BorderWidth   = 0
361:                 .SpecialEffect = 0
362:                 .Visible       = .T.
363:             ENDWITH
364: 
365:             loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
366:             WITH loc_oCnt.lbl_4c_LblSombra
367:                 .Top       = 15
368:                 .Left      = 10
369:                 .Width     = 769
370:                 .Height    = 40
371:                 .FontName  = "Tahoma"
372:                 .FontSize  = 18
373:                 .FontBold  = .T.
374:                 .WordWrap  = .T.
375:                 .Alignment = 0
376:                 .BackStyle = 0
377:                 .AutoSize  = .F.
378:                 .ForeColor = RGB(0, 0, 0)
379:                 .Caption   = THIS.Caption
380:                 .Visible   = .T.
381:             ENDWITH
382: 
383:             loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
384:             WITH loc_oCnt.lbl_4c_LblTitulo
385:                 .Top       = 18
386:                 .Left      = 10
387:                 .Width     = 769
388:                 .Height    = 46
389:                 .FontName  = "Tahoma"
390:                 .FontSize  = 18
391:                 .FontBold  = .T.
392:                 .WordWrap  = .T.
393:                 .Alignment = 0
394:                 .BackStyle = 0
395:                 .AutoSize  = .F.
396:                 .ForeColor = RGB(255, 255, 255)
397:                 .Caption   = THIS.Caption
398:                 .Visible   = .T.
399:             ENDWITH
400:         CATCH TO loc_oErro
401:             MsgErro(loc_oErro.Message + CHR(13) + ;
402:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

*-- Linhas 419 a 428:
419:         TRY
420:             THIS.AddObject("cnt_4c_Botoes", "Container")
421:             WITH THIS.cnt_4c_Botoes
422:                 .Top         = -2
423:                 .Left        =  542
424:                 .Width       = 235
425:                 .Height      = 85
426:                 .BackStyle   = 0
427:                 .BorderWidth = 0
428:                 .Visible     = .T.

*-- Linhas 461 a 531:
461:         TRY
462:             THIS.cnt_4c_Botoes.AddObject("cmg_4c_CmdBtnForm", "CommandGroup")
463:             WITH THIS.cnt_4c_Botoes.cmg_4c_CmdBtnForm
464:                 .Top         = 0
465:                 .Left        = 0
466:                 .Width       = 235
467:                 .Height      = 85
468:                 .ButtonCount = 3
469:                 .BackStyle   = 0
470:                 .BorderStyle = 0
471:                 .Value       = 1
472:                 .Visible     = .T.
473: 
474:                 WITH .Buttons(1)
475:                     .Top             = 5
476:                     .Left            = 5
477:                     .Height          = 75
478:                     .Width           = 75
479:                     .FontName        = "Comic Sans MS"
480:                     .FontSize        = 8
481:                     .FontBold        = .T.
482:                     .FontItalic      = .T.
483:                     .Caption         = "Limpar"
484:                     .ToolTipText     = "Limpar Sele" + CHR(231) + CHR(227) + "o"
485:                     .ForeColor       = RGB(90, 90, 90)
486:                     .BackColor       = RGB(255, 255, 255)
487:                     .Themes          = .F.
488:                     .Picture         = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
489:                     .DisabledPicture = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
490:                     *-- Desabilitado ate Selecionar() popular a grade (regra do
491:                     *-- legado: btnLimpar.Enabled = .f. no Init - dump:10313).
492:                     .Enabled         = .F.
493:                 ENDWITH
494: 
495:                 WITH .Buttons(2)
496:                     .Top             = 5
497:                     .Left            = 80
498:                     .Height          = 75
499:                     .Width           = 75
500:                     .FontName        = "Comic Sans MS"
501:                     .FontSize        = 8
502:                     .FontBold        = .T.
503:                     .FontItalic      = .T.
504:                     .Caption         = "Copiar"
505:                     .ToolTipText     = ""
506:                     .ForeColor       = RGB(90, 90, 90)
507:                     .BackColor       = RGB(255, 255, 255)
508:                     .Themes          = .F.
509:                     .Picture         = gc_4c_CaminhoIcones + "geral_subnivel_60.jpg"
510:                     .DisabledPicture = gc_4c_CaminhoIcones + "geral_subnivel_60.jpg"
511:                     *-- Desabilitado ate Selecionar() popular a grade (regra do
512:                     *-- legado: btnCopiar.Enabled = .f. no Init - dump:10314).
513:                     .Enabled         = .F.
514:                 ENDWITH
515: 
516:                 WITH .Buttons(3)
517:                     .Top             = 5
518:                     .Left            = 155
519:                     .Height          = 75
520:                     .Width           = 75
521:                     .FontName        = "Comic Sans MS"
522:                     .FontSize        = 8
523:                     .FontBold        = .T.
524:                     .FontItalic      = .T.
525:                     .Cancel          = .T.
526:                     .Caption         = "Encerrar"
527:                     .ToolTipText     = "[ESC] Sair"
528:                     .ForeColor       = RGB(90, 90, 90)
529:                     .BackColor       = RGB(255, 255, 255)
530:                     .Themes          = .F.
531:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"

*-- Linhas 548 a 561:
548:     * grd_4c_Dados, nomes conforme mapeamento.json).
549:     *
550:     * ORDEM OBRIGATORIA (regra "grid_autobind_area_corrente_quebra_
551:     * addobject_checkbox"): um Grid SEM RecordSource ainda atribuida
552:     * auto-binda sozinho ao alias CORRENTE no instante em que
553:     * ColumnCount e definido - e se a coluna que vai receber o
554:     * Column.AddObject("Check1","CheckBox") cair, por acaso, numa
555:     * coluna CHARACTER dessa auto-bind, o AddObject estoura "Data type
556:     * mismatch" DENTRO de si mesmo (CheckBox.Value nasce NUMERICO).
557:     * Por isso RecordSource + ControlSource de TODAS as colunas e
558:     * aplicado ANTES do AddObject do Check1 - nunca depois. ColumnCount
559:     * e fixado AQUI, UMA UNICA VEZ (regra "SOREDUZIRColumn" -
560:     * reatribuir ColumnCount recria as colunas e destroi o Check1).
561:     * CarregarLista() so REBINDA (RecordSource/ControlSource/Width/

*-- Linhas 599 a 622:
599: 
600:             THIS.AddObject("cnt_4c_Grade", "Container")
601:             WITH THIS.cnt_4c_Grade
602:                 .Top         = 209
603:                 .Left        = 9
604:                 .Width       = 932
605:                 .Height      = 375
606:                 .BackStyle   = 0
607:                 .BorderWidth = 0
608:                 .SpecialEffect = 0
609:                 .Visible     = .T.
610:             ENDWITH
611: 
612:             THIS.cnt_4c_Grade.AddObject("grd_4c_Dados", "Grid")
613:             loc_oGrid = THIS.cnt_4c_Grade.grd_4c_Dados
614: 
615:             WITH loc_oGrid
616:                 .Top               = 2
617:                 .Left              = 1
618:                 .Width             = 929
619:                 .Height            = 372
620:                 .FontName          = "Tahoma"
621:                 .FontSize          = 8
622:                 .AllowHeaderSizing = .F.

*-- Linhas 632 a 640:
632:                 *-- RecordSource + ControlSource de TODAS as colunas
633:                 *-- ANTES do AddObject do Check1 (ver comentario do
634:                 *-- metodo acima - evita o auto-bind em coluna
635:                 *-- CHARACTER estourar o AddObject do CheckBox).
636:                 .RecordSource = loc_cCursor
637: 
638:                 .Column1.ControlSource  = loc_cCursor + ".SelImp"
639:                 .Column2.ControlSource  = loc_cCursor + ".Numes"
640:                 .Column3.ControlSource  = loc_cCursor + ".Datas"

*-- Linhas 648 a 671:
648:                 .Column11.ControlSource = loc_cCursor + ".Dopes"
649: 
650:                 *-- Column1 - marcacao (Check1). CurrentControl/Sparse
651:                 *-- obrigatorios (regra #18) para o CheckBox aparecer e
652:                 *-- ser editavel em TODAS as linhas.
653:                 .Column1.FontName = "Tahoma"
654:                 .Column1.FontSize = 8
655:                 .Column1.Header1.Alignment = 2
656:                 .Column1.Header1.Caption   = ""
657:                 .Column1.AddObject("Check1", "CheckBox")
658:                 WITH .Column1.Check1
659:                     .Top         = 9
660:                     .Left        = 2
661:                     .Height      = 17
662:                     .Width       = 22
663:                     .FontName    = "Tahoma"
664:                     .FontSize    = 8
665:                     .Alignment   = 0
666:                     .Caption     = ""
667:                     .ToolTipText = "Marca/Desmarca Esta Opera" + CHR(231) + CHR(227) + "o Para o Processamento"
668:                     .Visible     = .T.
669:                     .ReadOnly    = .F.
670:                 ENDWITH
671:                 .Column1.CurrentControl = "Check1"

*-- Linhas 677 a 780:
677:                 .Column2.FontSize = 8
678:                 .Column2.Width    = 52
679:                 .Column2.Header1.Alignment = 2
680:                 .Column2.Header1.Caption   = "C" + CHR(243) + "digo"
681:                 .Column2.Text1.BorderStyle = 1
682:                 .Column2.Text1.Margin      = 0
683:                 .Column2.Text1.ForeColor   = RGB(0, 0, 0)
684:                 .Column2.Text1.ToolTipText = "C" + CHR(243) + "digo da Opera" + CHR(231) + CHR(227) + "o na Origem"
685: 
686:                 .Column3.FontName = "Tahoma"
687:                 .Column3.FontSize = 8
688:                 .Column3.Width    = 80
689:                 .Column3.Header1.Alignment = 2
690:                 .Column3.Header1.Caption   = "Data"
691:                 .Column3.Text1.Margin      = 0
692:                 .Column3.Text1.ToolTipText = "Data da Opera" + CHR(231) + CHR(227) + "o na Origem"
693: 
694:                 .Column4.FontName = "Tahoma"
695:                 .Column4.FontSize = 8
696:                 .Column4.Width    = 104
697:                 .Column4.Header1.Alignment = 2
698:                 .Column4.Header1.Caption   = "Valor"
699:                 .Column4.Text1.BorderStyle = 0
700:                 .Column4.Text1.Margin      = 0
701:                 .Column4.Text1.ForeColor   = RGB(0, 0, 0)
702:                 .Column4.Text1.BackColor   = RGB(255, 255, 255)
703:                 .Column4.Text1.ToolTipText = "Valor da Opera" + CHR(231) + CHR(227) + "o na Origem"
704: 
705:                 .Column5.FontName = "Tahoma"
706:                 .Column5.FontSize = 8
707:                 .Column5.Width    = 75
708:                 .Column5.Header1.Alignment = 2
709:                 .Column5.Header1.Caption   = "Documento"
710:                 .Column5.Text1.BorderStyle = 0
711:                 .Column5.Text1.Margin      = 0
712:                 .Column5.Text1.ForeColor   = RGB(0, 0, 0)
713:                 .Column5.Text1.BackColor   = RGB(255, 255, 255)
714:                 .Column5.Text1.ToolTipText = "Documento da Opera" + CHR(231) + CHR(227) + "o na Origem"
715: 
716:                 .Column6.FontName = "Tahoma"
717:                 .Column6.FontSize = 8
718:                 .Column6.Width    = 85
719:                 .Column6.Header1.Alignment = 2
720:                 .Column6.Header1.Caption   = "Usu" + CHR(225) + "rio"
721:                 .Column6.Text1.BorderStyle = 0
722:                 .Column6.Text1.Margin      = 0
723:                 .Column6.Text1.ForeColor   = RGB(0, 0, 0)
724:                 .Column6.Text1.BackColor   = RGB(255, 255, 255)
725:                 .Column6.Text1.ToolTipText = "Usu" + CHR(225) + "rio Que Gerou a Opera" + CHR(231) + CHR(227) + "o na Origem"
726: 
727:                 .Column7.FontName = "Tahoma"
728:                 .Column7.FontSize = 8
729:                 .Column7.Width    = 85
730:                 .Column7.Header1.Alignment = 2
731:                 .Column7.Header1.Caption   = "Origem"
732:                 .Column7.Text1.BorderStyle = 0
733:                 .Column7.Text1.Margin      = 0
734:                 .Column7.Text1.ForeColor   = RGB(0, 0, 0)
735:                 .Column7.Text1.BackColor   = RGB(255, 255, 255)
736:                 .Column7.Text1.ToolTipText = "Conta de Origem da Opera" + CHR(231) + CHR(227) + "o na Origem"
737: 
738:                 .Column8.FontName = "Tahoma"
739:                 .Column8.FontSize = 8
740:                 .Column8.Width    = 85
741:                 .Column8.Header1.Alignment = 2
742:                 .Column8.Header1.Caption   = "Destino"
743:                 .Column8.Text1.BorderStyle = 0
744:                 .Column8.Text1.Margin      = 0
745:                 .Column8.Text1.ForeColor   = RGB(0, 0, 0)
746:                 .Column8.Text1.BackColor   = RGB(255, 255, 255)
747:                 .Column8.Text1.ToolTipText = "Conta de Destino da Opera" + CHR(231) + CHR(227) + "o na Origem"
748: 
749:                 .Column9.FontName = "Tahoma"
750:                 .Column9.FontSize = 8
751:                 .Column9.Width    = 37
752:                 .Column9.Header1.Alignment = 2
753:                 .Column9.Header1.Caption   = "Orig."
754:                 .Column9.Text1.BorderStyle = 0
755:                 .Column9.Text1.Margin      = 0
756:                 .Column9.Text1.ForeColor   = RGB(0, 0, 0)
757:                 .Column9.Text1.BackColor   = RGB(255, 255, 255)
758:                 .Column9.Text1.ToolTipText = "Empresa da Opera" + CHR(231) + CHR(227) + "o de Origem"
759: 
760:                 .Column10.FontName = "Tahoma"
761:                 .Column10.FontSize = 8
762:                 .Column10.Width    = 37
763:                 .Column10.Header1.Alignment = 2
764:                 .Column10.Header1.Caption   = "Dest."
765:                 .Column10.Text1.BorderStyle = 0
766:                 .Column10.Text1.Margin      = 0
767:                 .Column10.Text1.ForeColor   = RGB(0, 0, 0)
768:                 .Column10.Text1.BackColor   = RGB(255, 255, 255)
769:                 .Column10.Text1.ToolTipText = "Empresa da Opera" + CHR(231) + CHR(227) + "o de Destino"
770: 
771:                 .Column11.FontName = "Tahoma"
772:                 .Column11.FontSize = 8
773:                 .Column11.Width    = 242
774:                 .Column11.Header1.Alignment = 2
775:                 .Column11.Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
776:                 .Column11.Text1.BorderStyle = 0
777:                 .Column11.Text1.Margin      = 0
778:                 .Column11.Text1.ForeColor   = RGB(0, 0, 0)
779:                 .Column11.Text1.BackColor   = RGB(255, 255, 255)
780: 

*-- Linhas 828 a 891:
828:         TRY
829:             THIS.AddObject("cmg_4c_CmdBtnGrade", "CommandGroup")
830:             WITH THIS.cmg_4c_CmdBtnGrade
831:                 .Top         = 364
832:                 .Left        = 944
833:                 .Width       = 43
834:                 .Height      = 135
835:                 .ButtonCount = 3
836:                 .BackStyle   = 0
837:                 .BorderStyle = 0
838:                 .Value       = 1
839:                 .Visible     = .T.
840: 
841:                 WITH .Buttons(1)
842:                     .Top             = -1
843:                     .Left            = -1
844:                     .Height          = 45
845:                     .Width           = 45
846:                     .FontName        = "Verdana"
847:                     .FontSize        = 8
848:                     .Caption         = ""
849:                     .ToolTipText     = "Selecionar"
850:                     .ForeColor       = RGB(36, 84, 155)
851:                     .BackColor       = RGB(255, 255, 255)
852:                     .Themes          = .F.
853:                     .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
854:                     .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
855:                     *-- Desabilitado ate Selecionar() popular a grade (regra do
856:                     *-- legado: btnMarcaTudo.Enabled = .f. no Init - dump:10315).
857:                     .Enabled         = .F.
858:                 ENDWITH
859: 
860:                 WITH .Buttons(2)
861:                     .Top             = 45
862:                     .Left            = -1
863:                     .Height          = 45
864:                     .Width           = 45
865:                     .FontName        = "Verdana"
866:                     .FontSize        = 8
867:                     .Caption         = ""
868:                     .ToolTipText     = "Desmarcar"
869:                     .ForeColor       = RGB(36, 84, 155)
870:                     .BackColor       = RGB(255, 255, 255)
871:                     .Themes          = .F.
872:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
873:                     .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
874:                     *-- Desabilitado ate Selecionar() popular a grade (regra do
875:                     *-- legado: btnDesmarcar.Enabled = .f. no Init - dump:10316).
876:                     .Enabled         = .F.
877:                 ENDWITH
878: 
879:                 WITH .Buttons(3)
880:                     .Top             = 91
881:                     .Left            = -1
882:                     .Height          = 45
883:                     .Width           = 45
884:                     .FontName        = "Verdana"
885:                     .FontSize        = 8
886:                     .Caption         = ""
887:                     .ToolTipText     = "Documento"
888:                     .ForeColor       = RGB(36, 84, 155)
889:                     .BackColor       = RGB(255, 255, 255)
890:                     .Themes          = .F.
891:                     .Picture         = gc_4c_CaminhoIcones + "geral_configuracao_26.jpg"

*-- Linhas 926 a 1032:
926:             THIS.AddObject("cnt_4c_Operacoes", "Container")
927:             loc_oCnt = THIS.cnt_4c_Operacoes
928:             WITH loc_oCnt
929:                 .Top         = 88
930:                 .Left        = 6
931:                 .Width       = 732
932:                 .Height      = 46
933:                 .BackStyle   = 0
934:                 .BorderWidth = 0
935:                 .SpecialEffect = 0
936:                 .Visible     = .T.
937:             ENDWITH
938: 
939:             *-- Label1 do dump - titulo de secao em negrito ("Operacoes").
940:             *-- Nome lbl_4c_TituloOperacoes (NAO lbl_4c_Label1 do
941:             *-- mapeamento.json - colide com Say1, ver comentario de topo).
942:             loc_oCnt.AddObject("lbl_4c_TituloOperacoes", "Label")
943:             WITH loc_oCnt.lbl_4c_TituloOperacoes
944:                 .Top       = 3
945:                 .Left      = 13
946:                 .Width     = 62
947:                 .Height    = 15
948:                 .FontName  = "Tahoma"
949:                 .FontSize  = 8
950:                 .FontBold  = .T.
951:                 .FontItalic = .F.
952:                 .BackStyle = 0
953:                 .AutoSize  = .F.
954:                 .Alignment = 0
955:                 .ForeColor = RGB(90, 90, 90)
956:                 .Caption   = "Oper" + "\<" + "a" + CHR(231) + CHR(245) + "es"
957:                 .Visible   = .T.
958:             ENDWITH
959: 
960:             *-- optProcessados - OptionGroup "Nao Processadas"/"Ja
961:             *-- Processadas". Value = INDICE (1/2), NUNCA booleano (regra
962:             *-- CLAUDE.md "numeric(1,0) de duas opcoes nao eh logica").
963:             *-- Default = 1 (Nao Processadas), igual a BO.this_nProcessados.
964:             loc_oCnt.AddObject("obj_4c_OptProcessados", "OptionGroup")
965:             WITH loc_oCnt.obj_4c_OptProcessados
966:                 .Top         = 5
967:                 .Left        = 83
968:                 .Width       = 235
969:                 .Height      = 15
970:                 .ButtonCount = 2
971:                 .BackStyle   = 0
972:                 .BorderStyle = 0
973:                 .Value       = 1
974:                 .Visible     = .T.
975: 
976:                 WITH .Buttons(1)
977:                     .Top       = -1
978:                     .Left      = 5
979:                     .FontName  = "Tahoma"
980:                     .FontSize  = 8
981:                     .BackStyle = 0
982:                     .AutoSize  = .T.
983:                     .Caption   = "N" + CHR(227) + "o Processadas"
984:                     .ForeColor = RGB(90, 90, 90)
985:                 ENDWITH
986: 
987:                 WITH .Buttons(2)
988:                     .Top       = -1
989:                     .Left      = 126
990:                     .FontName  = "Tahoma"
991:                     .FontSize  = 8
992:                     .BackStyle = 0
993:                     .AutoSize  = .T.
994:                     .Caption   = "J" + CHR(225) + " Processadas"
995:                     .ForeColor = RGB(90, 90, 90)
996:                 ENDWITH
997:             ENDWITH
998: 
999:             *-- Say3 do dump - "Processo :".
1000:             loc_oCnt.AddObject("lbl_4c_Processo", "Label")
1001:             WITH loc_oCnt.lbl_4c_Processo
1002:                 .Top        = 24
1003:                 .Left       = 23
1004:                 .Width      = 60
1005:                 .Height     = 15
1006:                 .FontName   = "Tahoma"
1007:                 .FontSize   = 8
1008:                 .FontItalic = .F.
1009:                 .BackStyle  = 0
1010:                 .AutoSize   = .F.
1011:                 .Alignment  = 0
1012:                 .ForeColor  = RGB(90, 90, 90)
1013:                 .Caption    = "Processo :"
1014:                 .Visible    = .T.
1015:             ENDWITH
1016: 
1017:             *-- cmbOperacoes - Processo de Copia cadastrado (SigPcOoP).
1018:             *-- RowSourceType=2 (Alias) sobre this_cCursorProcessos,
1019:             *-- populado por sigoppopBO.CarregarProcessos() ANTES desta
1020:             *-- fase (THIS.InicializarForm() chama o BO antes de
1021:             *-- ConfigurarLayout()). ColumnCount=1 (so o texto Processos,
1022:             *-- char(20) - o legado le o mesmo texto via
1023:             *-- ListItem(ListIndex), nao por codigo numerico).
1024:             loc_oCnt.AddObject("cbo_4c_CmbOperacoes", "ComboBox")
1025:             WITH loc_oCnt.cbo_4c_CmbOperacoes
1026:                 .Top            = 20
1027:                 .Left           = 87
1028:                 .Width          = 196
1029:                 .Height         = 24
1030:                 .FontName       = "Courier New"
1031:                 .FontSize       = 8
1032:                 .SpecialEffect  = 1

*-- Linhas 1039 a 1174:
1039:                 .Visible        = .T.
1040:             ENDWITH
1041: 
1042:             *-- Say1 do dump - "Periodo :". Nome lbl_4c_Periodo (NAO
1043:             *-- lbl_4c_Label1 do mapeamento.json - colide com Label1).
1044:             loc_oCnt.AddObject("lbl_4c_Periodo", "Label")
1045:             WITH loc_oCnt.lbl_4c_Periodo
1046:                 .Top        = 23
1047:                 .Left       = 323
1048:                 .Width      = 50
1049:                 .Height     = 15
1050:                 .FontName   = "Tahoma"
1051:                 .FontSize   = 8
1052:                 .FontItalic = .F.
1053:                 .BackStyle  = 0
1054:                 .AutoSize   = .F.
1055:                 .Alignment  = 0
1056:                 .ForeColor  = RGB(90, 90, 90)
1057:                 .Caption    = "Per" + CHR(237) + "odo :"
1058:                 .Visible    = .T.
1059:             ENDWITH
1060: 
1061:             *-- getDtIni - data inicial do periodo. Value inicial =
1062:             *-- DATE(), igual ao Init do legado (ver comentario da
1063:             *-- property BO.this_dDtIni em sigoppopBO.prg).
1064:             loc_oCnt.AddObject("txt_4c_DtIni", "TextBox")
1065:             WITH loc_oCnt.txt_4c_DtIni
1066:                 .Top          = 20
1067:                 .Left         = 377
1068:                 .Width        = 80
1069:                 .Height       = 23
1070:                 .SpecialEffect = 1
1071:                 .ToolTipText  = "Data Inicial Para Sele" + CHR(231) + CHR(227) + "o das Opera" + CHR(231) + CHR(245) + "es "
1072:                 .BorderColor  = RGB(90, 90, 90)
1073:                 .Value        = DATE()
1074:                 .Visible      = .T.
1075:             ENDWITH
1076: 
1077:             *-- Say2 do dump - "a" entre as duas datas do periodo (ver
1078:             *-- comentario de topo sobre a extracao corrompida).
1079:             loc_oCnt.AddObject("lbl_4c_Ate", "Label")
1080:             WITH loc_oCnt.lbl_4c_Ate
1081:                 .Top        = 24
1082:                 .Left       = 464
1083:                 .Width      = 10
1084:                 .Height     = 15
1085:                 .FontName   = "Tahoma"
1086:                 .FontSize   = 8
1087:                 .FontItalic = .F.
1088:                 .BackStyle  = 0
1089:                 .AutoSize   = .F.
1090:                 .Alignment  = 0
1091:                 .ForeColor  = RGB(90, 90, 90)
1092:                 .Caption    = "a"
1093:                 .Visible    = .T.
1094:             ENDWITH
1095: 
1096:             *-- getDtFin - data final do periodo. Value inicial = DATE().
1097:             loc_oCnt.AddObject("txt_4c_DtFin", "TextBox")
1098:             WITH loc_oCnt.txt_4c_DtFin
1099:                 .Top          = 21
1100:                 .Left         = 477
1101:                 .Width        = 80
1102:                 .Height       = 23
1103:                 .SpecialEffect = 1
1104:                 .ToolTipText  = "Data Final Para Sele" + CHR(231) + CHR(227) + "o das Opera" + CHR(231) + CHR(245) + "es "
1105:                 .BorderColor  = RGB(90, 90, 90)
1106:                 .Value        = DATE()
1107:                 .Visible      = .T.
1108:             ENDWITH
1109: 
1110:             *-- cmdSelecionar - dispara Selecionar() (BO), que monta
1111:             *-- cursor_4c_Operacoes a partir do filtro. BINDEVENT do
1112:             *-- Click fica para a Fase 7/8.
1113:             loc_oCnt.AddObject("cmd_4c_CmdSelecionar", "CommandButton")
1114:             WITH loc_oCnt.cmd_4c_CmdSelecionar
1115:                 .Top         = 21
1116:                 .Left        = 595
1117:                 .Width       = 99
1118:                 .Height      = 23
1119:                 .FontName    = "Comic Sans MS"
1120:                 .FontSize    = 8
1121:                 .FontBold    = .T.
1122:                 .FontItalic  = .T.
1123:                 .Caption     = "\<Selecionar"
1124:                 .ToolTipText = "Seleciona as Opera" + CHR(231) + CHR(245) + "es Conforme os Dados Digitados"
1125:                 .ForeColor   = RGB(90, 90, 90)
1126:                 .BackColor   = RGB(255, 255, 255)
1127:                 .Themes      = .F.
1128:                 .Visible     = .T.
1129:             ENDWITH
1130: 
1131:             *-- fwcheckbox1 do dump - CheckBox grafico (Style=1,
1132:             *-- Picture=consultar.bmp do framework legado, rule #25 -
1133:             *-- NUNCA inventar nome de icone) que liga/desliga
1134:             *-- ThisForm.ShowTips (comportamento.json:
1135:             *-- "ThisForm.ShowTips = (This.Value = 1)" no InteractiveChange).
1136:             *-- .Value NUMERICO (regra CLAUDE.md). BINDEVENT do
1137:             *-- InteractiveChange fica para a Fase 7/8, junto com os
1138:             *-- demais eventos do form.
1139:             loc_oCnt.AddObject("chk_4c_Fwcheckbox1", "CheckBox")
1140:             WITH loc_oCnt.chk_4c_Fwcheckbox1
1141:                 .Top       = 21
1142:                 .Left      = 704
1143:                 .Width     = 24
1144:                 .Height    = 23
1145:                 .Style     = 1
1146:                 .Alignment = 0
1147:                 .Caption   = ""
1148:                 .Value     = 0
1149:                 .BackColor = RGB(255, 255, 255)
1150:                 .Picture   = gc_4c_CaminhoFramework + "imagens\consultar.bmp"
1151:                 .Visible   = .T.
1152:             ENDWITH
1153: 
1154:             *-- chkMensa - "Exibir Mensagens de Erro". .Value NUMERICO
1155:             *-- (regra CLAUDE.md), NUNCA .T./.F.. Default = 1 (marcado),
1156:             *-- igual a BO.this_lExibirMensagens = .T..
1157:             loc_oCnt.AddObject("chk_4c_ChkMensa", "CheckBox")
1158:             WITH loc_oCnt.chk_4c_ChkMensa
1159:                 .Top         = 3
1160:                 .Left        = 377
1161:                 .Width       = 180
1162:                 .Height      = 17
1163:                 .FontName    = "Tahoma"
1164:                 .FontSize    = 8
1165:                 .FontItalic  = .F.
1166:                 .AutoSize    = .F.
1167:                 .Alignment   = 0
1168:                 .BackStyle   = 0
1169:                 .Caption     = "Exibir Mensagens de Erro"
1170:                 .Value       = 1
1171:                 .ToolTipText = "Exibe Mensagens Relativas a Erros de Lan" + CHR(231) + "amento"
1172:                 .ForeColor   = RGB(90, 90, 90)
1173:                 .Visible     = .T.
1174:                 *-- Desabilitado ate Selecionar() popular a grade (regra do

*-- Linhas 1210 a 1326:
1210:             THIS.AddObject("cnt_4c_Filtro", "Container")
1211:             loc_oCnt = THIS.cnt_4c_Filtro
1212:             WITH loc_oCnt
1213:                 .Top         = 134
1214:                 .Left        = 6
1215:                 .Width       = 699
1216:                 .Height      = 89
1217:                 .BackStyle   = 0
1218:                 .BorderWidth = 0
1219:                 .SpecialEffect = 0
1220:                 .Visible     = .T.
1221:             ENDWITH
1222: 
1223:             *-- Label2 do dump - titulo de secao em negrito ("Filtro por Empresa").
1224:             loc_oCnt.AddObject("lbl_4c_FiltroEmpresa", "Label")
1225:             WITH loc_oCnt.lbl_4c_FiltroEmpresa
1226:                 .Top        = 1
1227:                 .Left       = 9
1228:                 .Width      = 105
1229:                 .Height     = 15
1230:                 .FontName   = "Tahoma"
1231:                 .FontSize   = 8
1232:                 .FontBold   = .T.
1233:                 .FontItalic = .F.
1234:                 .BackStyle  = 0
1235:                 .AutoSize   = .F.
1236:                 .Alignment  = 0
1237:                 .ForeColor  = RGB(90, 90, 90)
1238:                 .Caption    = "Filtro por " + "\<" + "Empresa"
1239:                 .Visible    = .T.
1240:             ENDWITH
1241: 
1242:             *-- Say4 do dump - "Origem :".
1243:             loc_oCnt.AddObject("lbl_4c_Origem", "Label")
1244:             WITH loc_oCnt.lbl_4c_Origem
1245:                 .Top        = 23
1246:                 .Left       = 31
1247:                 .Width      = 55
1248:                 .Height     = 15
1249:                 .FontName   = "Tahoma"
1250:                 .FontSize   = 8
1251:                 .FontItalic = .F.
1252:                 .BackStyle  = 0
1253:                 .AutoSize   = .F.
1254:                 .Alignment  = 0
1255:                 .ForeColor  = RGB(90, 90, 90)
1256:                 .Caption    = "Origem :"
1257:                 .Visible    = .T.
1258:             ENDWITH
1259: 
1260:             *-- getEmpOs - codigo da empresa de ORIGEM (SigCdEmp.Cemps char(3)).
1261:             loc_oCnt.AddObject("txt_4c_EmpOs", "TextBox")
1262:             WITH loc_oCnt.txt_4c_EmpOs
1263:                 .Top           = 19
1264:                 .Left          = 88
1265:                 .Width         = 31
1266:                 .MaxLength     = 3
1267:                 .SpecialEffect = 1
1268:                 .BorderColor   = RGB(90, 90, 90)
1269:                 .Value         = ""
1270:                 .Visible       = .T.
1271:             ENDWITH
1272: 
1273:             *-- getDEmpOs - razao social da empresa de ORIGEM (SigCdEmp.Razas char(40)).
1274:             loc_oCnt.AddObject("txt_4c_DEmpOs", "TextBox")
1275:             WITH loc_oCnt.txt_4c_DEmpOs
1276:                 .Top           = 19
1277:                 .Left          = 122
1278:                 .Width         = 305
1279:                 .Height        = 23
1280:                 .SpecialEffect = 1
1281:                 .BorderColor   = RGB(90, 90, 90)
1282:                 .Value         = ""
1283:                 .Visible       = .T.
1284:             ENDWITH
1285: 
1286:             *-- Say5 do dump - "Destino :".
1287:             loc_oCnt.AddObject("lbl_4c_Destino", "Label")
1288:             WITH loc_oCnt.lbl_4c_Destino
1289:                 .Top        = 49
1290:                 .Left       = 30
1291:                 .Width      = 56
1292:                 .Height     = 15
1293:                 .FontName   = "Tahoma"
1294:                 .FontSize   = 8
1295:                 .FontItalic = .F.
1296:                 .BackStyle  = 0
1297:                 .AutoSize   = .F.
1298:                 .Alignment  = 0
1299:                 .ForeColor  = RGB(90, 90, 90)
1300:                 .Caption    = "Destino :"
1301:                 .Visible    = .T.
1302:             ENDWITH
1303: 
1304:             *-- getEmpDs - codigo da empresa de DESTINO.
1305:             loc_oCnt.AddObject("txt_4c_EmpDs", "TextBox")
1306:             WITH loc_oCnt.txt_4c_EmpDs
1307:                 .Top           = 45
1308:                 .Left          = 88
1309:                 .Width         = 31
1310:                 .MaxLength     = 3
1311:                 .SpecialEffect = 1
1312:                 .BorderColor   = RGB(90, 90, 90)
1313:                 .Value         = ""
1314:                 .Visible       = .T.
1315:             ENDWITH
1316: 
1317:             *-- getDEmpDs - razao social da empresa de DESTINO.
1318:             loc_oCnt.AddObject("txt_4c_DEmpDs", "TextBox")
1319:             WITH loc_oCnt.txt_4c_DEmpDs
1320:                 .Top           = 45
1321:                 .Left          = 122
1322:                 .Width         = 305
1323:                 .Height        = 23
1324:                 .SpecialEffect = 1
1325:                 .BorderColor   = RGB(90, 90, 90)
1326:                 .Value         = ""

*-- Linhas 1429 a 1438:
1429:                 IF VARTYPE(loc_oBusca) = "O"
1430:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmpOs"
1431:                     loc_oBusca.this_cTitulo        = loc_cTitulo
1432:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
1433:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
1434:                     loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
1435:                     loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
1436:                     loc_oBusca.Show()
1437:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpOs")
1438:                         SELECT cursor_4c_BuscaEmpOs

*-- Linhas 1549 a 1558:
1549:                 IF VARTYPE(loc_oBusca) = "O"
1550:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmpOs"
1551:                     loc_oBusca.this_cTitulo        = loc_cTitulo
1552:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
1553:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
1554:                     loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
1555:                     loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
1556:                     loc_oBusca.Show()
1557:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpOs")
1558:                         SELECT cursor_4c_BuscaEmpOs

*-- Linhas 1664 a 1673:
1664:                 IF VARTYPE(loc_oBusca) = "O"
1665:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmpDs"
1666:                     loc_oBusca.this_cTitulo        = loc_cTitulo
1667:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
1668:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
1669:                     loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
1670:                     loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
1671:                     loc_oBusca.Show()
1672:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpDs")
1673:                         SELECT cursor_4c_BuscaEmpDs

*-- Linhas 1784 a 1793:
1784:                 IF VARTYPE(loc_oBusca) = "O"
1785:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmpDs"
1786:                     loc_oBusca.this_cTitulo        = loc_cTitulo
1787:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
1788:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
1789:                     loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
1790:                     loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
1791:                     loc_oBusca.Show()
1792:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpDs")
1793:                         SELECT cursor_4c_BuscaEmpDs

*-- Linhas 1822 a 1862:
1822:             THIS.AddObject("cnt_4c_Complemento", "Container")
1823:             loc_oCnt = THIS.cnt_4c_Complemento
1824:             WITH loc_oCnt
1825:                 .Top         = 151
1826:                 .Left        = 453
1827:                 .Width       = 240
1828:                 .Height      = 60
1829:                 .BackStyle   = 0
1830:                 .BorderWidth = 0
1831:                 .SpecialEffect = 0
1832:                 .Visible     = .T.
1833:             ENDWITH
1834: 
1835:             *-- Say1 do dump - "Lancar em :".
1836:             loc_oCnt.AddObject("lbl_4c_LancarEm", "Label")
1837:             WITH loc_oCnt.lbl_4c_LancarEm
1838:                 .Top       = 5
1839:                 .Left      = 20
1840:                 .Width     = 65
1841:                 .Height    = 15
1842:                 .FontName  = "Tahoma"
1843:                 .FontSize  = 8
1844:                 .BackStyle = 0
1845:                 .AutoSize  = .F.
1846:                 .Alignment = 0
1847:                 .ForeColor = RGB(90, 90, 90)
1848:                 .Caption   = "La" + "\<" + "n" + CHR(231) + "ar em :"
1849:                 .Visible   = .T.
1850:             ENDWITH
1851: 
1852:             *-- getDtLanc - data de lancamento das operacoes no DESTINO
1853:             *-- (vazia assume a data da origem - this_dDtLanc do BO).
1854:             loc_oCnt.AddObject("txt_4c_DtLanc", "TextBox")
1855:             WITH loc_oCnt.txt_4c_DtLanc
1856:                 .Top           = 1
1857:                 .Left          = 90
1858:                 .Width         = 80
1859:                 .Height        = 23
1860:                 .SpecialEffect = 1
1861:                 .ToolTipText   = "Data Para Lan" + CHR(231) + "amento das Opera" + CHR(231) + CHR(245) + "es no Destino (Em Branco Assume a Data da Origem)"
1862:                 .BorderColor   = RGB(90, 90, 90)

*-- Linhas 1868 a 1877:
1868:             *-- do dump - regra CLAUDE.md #49, transcricao literal).
1869:             loc_oCnt.AddObject("txt_4c_Toleras", "TextBox")
1870:             WITH loc_oCnt.txt_4c_Toleras
1871:                 .Top               = 27
1872:                 .Left              = 90
1873:                 .Width             = 55
1874:                 .Height            = 25
1875:                 .FontName          = "Courier New"
1876:                 .FontSize          = 9
1877:                 .Format            = "K"

*-- Linhas 1885 a 1922:
1885:             ENDWITH
1886: 
1887:             *-- Say7 do dump - "Tolerancia AU :".
1888:             loc_oCnt.AddObject("lbl_4c_Toleras", "Label")
1889:             WITH loc_oCnt.lbl_4c_Toleras
1890:                 .Top       = 32
1891:                 .Left      = 3
1892:                 .Width     = 75
1893:                 .Height    = 15
1894:                 .FontName  = "Tahoma"
1895:                 .FontSize  = 8
1896:                 .BackStyle = 0
1897:                 .AutoSize  = .F.
1898:                 .Alignment = 0
1899:                 .ForeColor = RGB(90, 90, 90)
1900:                 .Caption   = "\<" + "Toler" + CHR(226) + "ncia AU :"
1901:                 .Visible   = .T.
1902:             ENDWITH
1903: 
1904:             *-- Say2 do dump - "Gr." (rotulo residual ao lado da tolerancia).
1905:             loc_oCnt.AddObject("lbl_4c_Gr", "Label")
1906:             WITH loc_oCnt.lbl_4c_Gr
1907:                 .Top       = 32
1908:                 .Left      = 152
1909:                 .Width     = 17
1910:                 .Height    = 15
1911:                 .FontName  = "Tahoma"
1912:                 .FontSize  = 8
1913:                 .BackStyle = 0
1914:                 .AutoSize  = .F.
1915:                 .Alignment = 0
1916:                 .ForeColor = RGB(90, 90, 90)
1917:                 .Caption   = "Gr."
1918:                 .Visible   = .T.
1919:             ENDWITH
1920:         CATCH TO loc_oErro
1921:             MsgErro(loc_oErro.Message + CHR(13) + ;
1922:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

*-- Linhas 1953 a 2007:
1953:             loc_oGrid.RecordSource = loc_cCursor
1954: 
1955:             loc_oGrid.Column1.ControlSource = loc_cCursor + ".SelImp"
1956:             loc_oGrid.Column1.AddObject("Check1", "CheckBox")
1957:             loc_oGrid.Column1.Check1.Caption = ""
1958:             loc_oGrid.Column1.CurrentControl = "Check1"
1959:             loc_oGrid.Column1.Sparse         = .F.
1960:             loc_oGrid.Column1.ReadOnly       = .F.
1961:             loc_oGrid.Column1.Width          = 15
1962: 
1963:             loc_oGrid.Column2.ControlSource = loc_cCursor + ".Numes"
1964:             loc_oGrid.Column2.Width         = 52
1965:             loc_oGrid.Column2.Header1.Caption = "C" + CHR(243) + "digo"
1966: 
1967:             loc_oGrid.Column3.ControlSource = loc_cCursor + ".Datas"
1968:             loc_oGrid.Column3.Width         = 80
1969:             loc_oGrid.Column3.Header1.Caption = "Data"
1970: 
1971:             loc_oGrid.Column4.ControlSource = loc_cCursor + ".Valos"
1972:             loc_oGrid.Column4.Width         = 104
1973:             loc_oGrid.Column4.Header1.Caption = "Valor"
1974: 
1975:             loc_oGrid.Column5.ControlSource = loc_cCursor + ".Notas"
1976:             loc_oGrid.Column5.Width         = 75
1977:             loc_oGrid.Column5.Header1.Caption = "Documento"
1978: 
1979:             loc_oGrid.Column6.ControlSource = loc_cCursor + ".Usuars"
1980:             loc_oGrid.Column6.Width         = 85
1981:             loc_oGrid.Column6.Header1.Caption = "Usu" + CHR(225) + "rio"
1982: 
1983:             loc_oGrid.Column7.ControlSource = loc_cCursor + ".ContaOs"
1984:             loc_oGrid.Column7.Width         = 85
1985:             loc_oGrid.Column7.Header1.Caption = "Origem"
1986: 
1987:             loc_oGrid.Column8.ControlSource = loc_cCursor + ".ContaDs"
1988:             loc_oGrid.Column8.Width         = 85
1989:             loc_oGrid.Column8.Header1.Caption = "Destino"
1990: 
1991:             loc_oGrid.Column9.ControlSource = loc_cCursor + ".Emps"
1992:             loc_oGrid.Column9.Width         = 37
1993:             loc_oGrid.Column9.Header1.Caption = "Orig."
1994: 
1995:             loc_oGrid.Column10.ControlSource = loc_cCursor + ".EmpDs"
1996:             loc_oGrid.Column10.Width         = 37
1997:             loc_oGrid.Column10.Header1.Caption = "Dest."
1998: 
1999:             loc_oGrid.Column11.ControlSource = loc_cCursor + ".Dopes"
2000:             loc_oGrid.Column11.Width         = 242
2001:             loc_oGrid.Column11.ReadOnly      = .F.
2002:             loc_oGrid.Column11.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
2003: 
2004:             SELECT (loc_cCursor)
2005:             GO TOP
2006:             loc_oGrid.Refresh()
2007:         CATCH TO loc_oErro

*-- Linhas 2013 a 2033:
2013: 
2014:     *====================================================================
2015:     * ConfigurarEventosBotoes - BINDEVENT dos botoes de acao (cmg_4c_
2016:     * CmdBtnForm/cmg_4c_CmdBtnGrade/cmd_4c_CmdSelecionar), do checkbox
2017:     * grafico (chk_4c_Fwcheckbox1) e dos 4 handlers da coluna de
2018:     * marcacao da grade (Column1.Check1 - regra CLAUDE.md #46/#18).
2019:     * Chamado ao final de ConfigurarLayout(), depois que todos os
2020:     * controles referenciados ja existem (regra CLAUDE.md "BINDEVENT em
2021:     * objeto que ainda nao existe estoura no proprio bind").
2022:     *====================================================================
2023:     PROTECTED PROCEDURE ConfigurarEventosBotoes()
2024:         LOCAL loc_oErro
2025: 
2026:         TRY
2027:             BINDEVENT(THIS.cnt_4c_Operacoes.cmd_4c_CmdSelecionar, "Click", THIS, "CmdSelecionarClick")
2028:             BINDEVENT(THIS.cnt_4c_Operacoes.chk_4c_Fwcheckbox1, "InteractiveChange", THIS, "ChkFwcheckbox1InteractiveChange")
2029:             BINDEVENT(THIS.cnt_4c_Botoes.cmg_4c_CmdBtnForm, "Click", THIS, "CmdBtnFormClick")
2030:             BINDEVENT(THIS.cmg_4c_CmdBtnGrade, "Click", THIS, "CmdBtnGradeClick")
2031: 
2032:             WITH THIS.cnt_4c_Grade.grd_4c_Dados.Column1.Check1
2033:                 BINDEVENT(THIS.cnt_4c_Grade.grd_4c_Dados.Column1.Check1, "Click",     THIS, "Check1Click")

*-- Linhas 2142 a 2150:
2142:                     .obj_4c_OptProcessados.Buttons(1).Enabled = .F.
2143:                     .obj_4c_OptProcessados.Buttons(2).Enabled = .F.
2144:                     .cbo_4c_CmbOperacoes.Enabled               = .F.
2145:                     .cmd_4c_CmdSelecionar.Enabled               = .F.
2146:                     .chk_4c_ChkMensa.Enabled                    = .T.
2147:                 ENDWITH
2148: 
2149:                 WITH THIS.cnt_4c_Filtro
2150:                     .txt_4c_EmpOs.Enabled  = .F.

*-- Linhas 2253 a 2265:
2253:     ENDPROC
2254: 
2255:     *====================================================================
2256:     * ChkFwcheckbox1InteractiveChange - equivalente ao InteractiveChange
2257:     * legado ("ThisForm.ShowTips = (This.Value = 1)", dump:10727-10729).
2258:     *====================================================================
2259:     PROCEDURE ChkFwcheckbox1InteractiveChange()
2260:         THIS.ShowTips = (THIS.cnt_4c_Operacoes.chk_4c_Fwcheckbox1.Value = 1)
2261:     ENDPROC
2262: 
2263:     *====================================================================
2264:     * LimpaSelecao - equivalente ao metodo legado "limpaselecao"
2265:     * (dump:5610-5647): limpa o cursor de operacoes candidatas e

*-- Linhas 2284 a 2292:
2284:                 .txt_4c_DtIni.Enabled                     = .T.
2285:                 .txt_4c_DtFin.Enabled                     = .T.
2286:                 .cbo_4c_CmbOperacoes.Enabled               = .T.
2287:                 .cmd_4c_CmdSelecionar.Enabled               = .T.
2288:                 .obj_4c_OptProcessados.Buttons(1).Enabled = .T.
2289:                 .obj_4c_OptProcessados.Buttons(2).Enabled = .T.
2290:                 .chk_4c_ChkMensa.Enabled                    = .F.
2291:             ENDWITH
2292: 

*-- Linhas 2426 a 2434:
2426:     *====================================================================
2427:     * Check1Click/KeyPress/MouseDown/MouseUp - toggle da marcacao
2428:     * (SelImp) da coluna 1 da grade. NODEFAULT nos 4 (equivalente ao
2429:     * legado, dump:10523-10575): o toggle nativo do CheckBox e
2430:     * SUPRIMIDO e o REPLACE e feito a mao, igual ao legado ("m.SelImp =
2431:     * (Not csOperacoes.SelImp) / Gather Memvar Fields SelImp"), regra
2432:     * CLAUDE.md #46 (Valid/KeyPress da celula, nao AfterRowColChange).
2433:     *====================================================================
2434:     PROCEDURE Check1Click()

