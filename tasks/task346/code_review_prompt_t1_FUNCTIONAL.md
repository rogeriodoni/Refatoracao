# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (6)
- [BINDEVENT-PARAMS] Handler 'ValidarOpAutos' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarOpAutos(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarOpSaidas' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarOpSaidas(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarFPagSAutos' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarFPagSAutos(par_nKeyCode, par_nShiftAltCtrl)
- [GRID-WITH] Bloco WITH ENDWITH define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ENDWITH.RecordSource).
- [LAYOUT-POSITION] Controle 'optPefins' (parent: SIGCDALI.Pagina.Dados): Top original=291 vs migrado 'opt_4c_OptPefins' Top=5 (diff=286px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optPefins' (parent: SIGCDALI.Pagina.Dados): Left original=335 vs migrado 'opt_4c_OptPefins' Left=5 (diff=330px, tolerancia=30px)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES FUNCIONAIS
- [CONTAINER-VISIVEL] TornarControlesVisiveis nao filtra containers ocultos (Visible=.F.). Adicionar INLIST
- [BUSCA-CURSOR] FormBuscaAuxiliar sem this_cCursorDestino no Modo 2
- [OPTIONGROUP-LEFT] Buttons sobrepostos - definir .Left, .Top, .AutoSize em CADA Button
- [CARGA-DADOS] Validar* sem chamada de carga / OptionGroup sem InteractiveChange
- [BINDEVENT-PARAMS] Handler sem LPARAMETERS (AfterRowColChange(par_nColIndex), KeyPress(par_nKeyCode, par_nShift))
- [STUB-MSGAVISO] Btn*Click com MsgAviso placeholder ao inves de logica real
- [LOSTFOCUS-SEM-GUARDIA] Handler abre busca sem verificar se valor mudou
- [INIT-DUPLICADO] Init() chama DODEFAULT() + InicializarForm() (duplicado)
- [METODO-INEXISTENTE] THIS.Metodo() chamado mas nao definido no Form. LLM pode ter inventado. IMPLEMENTAR ou REMOVER.

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormAli.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1259 linhas total):

*-- Linhas 28 a 152:
28:     this_cModoAtual      = "LISTA"
29: 
30:     *--------------------------------------------------------------------------
31:     * Init - APENAS retorna DODEFAULT (FormBase.Init chama InicializarForm)
32:     *--------------------------------------------------------------------------
33:     PROCEDURE Init()
34:         LOCAL loc_lResultado
35:         loc_lResultado = .F.
36: 
37:         TRY
38:             loc_lResultado = DODEFAULT()
39:         CATCH TO loc_oErro
40:             MsgErro(loc_oErro.Message, "FormAli.Init")
41:         ENDTRY
42: 
43:         RETURN loc_lResultado
44:     ENDPROC
45: 
46:     *--------------------------------------------------------------------------
47:     * InicializarForm - Configura estrutura completa
48:     * Chamado automaticamente pelo FormBase.Init()
49:     *--------------------------------------------------------------------------
50:     PROTECTED PROCEDURE InicializarForm()
51:         LOCAL loc_lResultado
52:         loc_lResultado = .F.
53: 
54:         TRY
55:             THIS.this_oBusinessObject = CREATEOBJECT("AliBO")
56: 
57:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
58:                 MsgErro("Falha ao criar AliBO", "Erro")
59:             ELSE
60:                 THIS.ConfigurarPageFrame()
61: 
62:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
63:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
64: 
65:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
66:                     THIS.CarregarLista()
67:                 ENDIF
68: 
69:                 THIS.pgf_4c_Paginas.Visible = .T.
70:                 THIS.pgf_4c_Paginas.ActivePage = 1
71:                 THIS.this_cModoAtual = "LISTA"
72:                 loc_lResultado = .T.
73:             ENDIF
74:         CATCH TO loc_oErro
75:             MsgErro(loc_oErro.Message, "FormAli.InicializarForm")
76:         ENDTRY
77: 
78:         RETURN loc_lResultado
79:     ENDPROC
80: 
81:     *--------------------------------------------------------------------------
82:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
83:     *--------------------------------------------------------------------------
84:     PROTECTED PROCEDURE ConfigurarPageFrame()
85:         LOCAL loc_oPgf
86:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
87:         loc_oPgf = THIS.pgf_4c_Paginas
88: 
89:         WITH loc_oPgf
90:             .PageCount = 2
91:             .Top       = -29
92:             .Left      = 0
93:             .Width     = THIS.Width
94:             .Height    = THIS.Height + 29
95:             .Tabs      = .F.
96:             .Visible   = .T.
97:             .Page1.Caption   = "Lista"
98:             .Page1.BackColor = RGB(100, 100, 100)
99:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
100:             .Page2.Caption   = "Dados"
101:             .Page2.BackColor = RGB(100, 100, 100)
102:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
103:         ENDWITH
104: 
105:         THIS.ConfigurarPaginaLista()
106:         THIS.ConfigurarPaginaDados()
107:     ENDPROC
108: 
109:     *--------------------------------------------------------------------------
110:     * ConfigurarPaginaLista - Cria containers, grid e botoes da Page1 (Lista)
111:     *--------------------------------------------------------------------------
112:     PROTECTED PROCEDURE ConfigurarPaginaLista()
113:         LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida
114:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
115: 
116:         *-- Container cabecalho cinza (Top = 2 + 29 = 31, compensacao PageFrame.Top=-29)
117:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
118:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
119:         WITH loc_oCab
120:             .Top         = 31
121:             .Left        = 0
122:             .Width       = THIS.Width
123:             .Height      = 80
124:             .BackColor   = RGB(100, 100, 100)
125:             .BorderWidth = 0
126:             .Visible     = .T.
127:         ENDWITH
128: 
129:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
130:         WITH loc_oCab.lbl_4c_Sombra
131:             .AutoSize  = .F.
132:             .Caption   = THIS.Caption
133:             .Top       = 15
134:             .Left      = 10
135:             .Width     = THIS.Width
136:             .Height    = 40
137:             .FontName  = "Tahoma"
138:             .FontSize  = 16
139:             .FontBold  = .T.
140:             .ForeColor = RGB(0, 0, 0)
141:             .BackStyle = 0
142:             .Visible   = .T.
143:         ENDWITH
144: 
145:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
146:         WITH loc_oCab.lbl_4c_Titulo
147:             .AutoSize  = .F.
148:             .Caption   = THIS.Caption
149:             .Top       = 18
150:             .Left      = 10
151:             .Width     = THIS.Width
152:             .Height    = 46

*-- Linhas 287 a 420:
287:             .Visible         = .T.
288:         ENDWITH
289: 
290:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
291:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
292:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
293:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
294:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
295: 
296:         *-- Container Encerrar (canonico: Left=917, Width=90)
297:         loc_oPg1.AddObject("cnt_4c_Saida", "Container")
298:         loc_oSaida = loc_oPg1.cnt_4c_Saida
299:         WITH loc_oSaida
300:             .Top         = 29
301:             .Left        = 917
302:             .Width       = 90
303:             .Height      = 85
304:             .BackStyle   = 0
305:             .BorderWidth = 0
306:             .Visible     = .T.
307:         ENDWITH
308: 
309:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
310:         WITH loc_oSaida.cmd_4c_Encerrar
311:             .Caption         = "Encerrar"
312:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
313:             .PicturePosition = 13
314:             .Top             = 5
315:             .Left            = 5
316:             .Width           = 75
317:             .Height          = 75
318:             .BackColor       = RGB(255, 255, 255)
319:             .ForeColor       = RGB(90, 90, 90)
320:             .FontName        = "Comic Sans MS"
321:             .FontSize        = 8
322:             .FontBold        = .T.
323:             .FontItalic      = .T.
324:             .Themes          = .F.
325:             .SpecialEffect   = 0
326:             .MousePointer    = 15
327:             .WordWrap        = .T.
328:             .AutoSize        = .F.
329:             .Visible         = .T.
330:         ENDWITH
331: 
332:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
333: 
334:         *-- Grid de listagem (Top=88+29=117, Left=12, Width=890, Height=480)
335:         *-- RecordSource e ColumnCount FORA do WITH para criar colunas imediatamente
336:         loc_oPg1.AddObject("grd_4c_Lista", "Grid")
337:         loc_oPg1.grd_4c_Lista.RecordSource = ""
338:         loc_oPg1.grd_4c_Lista.ColumnCount  = 4
339: 
340:         WITH loc_oPg1.grd_4c_Lista
341:             .Top                     = 117
342:             .Left                    = 12
343:             .Width                   = 890
344:             .Height                  = 480
345:             .FontName                = "Verdana"
346:             .FontSize                = 8
347:             .ForeColor               = RGB(90, 90, 90)
348:             .BackColor               = RGB(255, 255, 255)
349:             .GridLineColor           = RGB(238, 238, 238)
350:             .HighlightBackColor      = RGB(255, 255, 255)
351:             .HighlightForeColor      = RGB(15, 41, 104)
352:             .HighlightStyle          = 2
353:             .DeleteMark              = .F.
354:             .RecordMark              = .F.
355:             .RowHeight               = 16
356:             .ScrollBars              = 2
357:             .GridLines               = 3
358:             .ReadOnly                = .T.
359:             .Visible                 = .T.
360:             .Column1.Width           = 50
361:             .Column2.Width           = 415
362:             .Column3.Width           = 200
363:             .Column4.Width           = 160
364:             .Column1.ReadOnly        = .T.
365:             .Column2.ReadOnly        = .T.
366:             .Column3.ReadOnly        = .T.
367:             .Column4.ReadOnly        = .T.
368:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
369:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
370:             .Column3.Header1.Caption = "Oper. Autom. Cheque"
371:             .Column4.Header1.Caption = "Cond. Pag. Autom."
372:         ENDWITH
373: 
374:         THIS.TornarControlesVisiveis(loc_oPg1)
375:     ENDPROC
376: 
377:     *--------------------------------------------------------------------------
378:     * ConfigurarPaginaDados - Cria containers e botoes da Page2 (Dados)
379:     *--------------------------------------------------------------------------
380:     PROTECTED PROCEDURE ConfigurarPaginaDados()
381:         LOCAL loc_oPg2, loc_oBotoesAcao
382:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
383: 
384:         *-- Container botoes Confirmar/Cancelar (Top = 4 + 29 = 33)
385:         loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
386:         loc_oBotoesAcao = loc_oPg2.cnt_4c_BotoesAcao
387:         WITH loc_oBotoesAcao
388:             .Top         = 33
389:             .Left        = 842
390:             .Width       = 160
391:             .Height      = 85
392:             .BackStyle   = 0
393:             .BorderWidth = 0
394:             .Visible     = .T.
395:         ENDWITH
396: 
397:         loc_oBotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
398:         WITH loc_oBotoesAcao.cmd_4c_Confirmar
399:             .Caption         = "Confirmar"
400:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
401:             .PicturePosition = 13
402:             .Top             = 5
403:             .Left            = 5
404:             .Width           = 75
405:             .Height          = 75
406:             .BackColor       = RGB(255, 255, 255)
407:             .ForeColor       = RGB(90, 90, 90)
408:             .FontName        = "Comic Sans MS"
409:             .FontSize        = 8
410:             .FontBold        = .T.
411:             .FontItalic      = .T.
412:             .Themes          = .F.
413:             .SpecialEffect   = 0
414:             .MousePointer    = 15
415:             .WordWrap        = .T.
416:             .AutoSize        = .F.
417:             .Visible         = .T.
418:         ENDWITH
419: 
420:         loc_oBotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")

*-- Linhas 440 a 484:
440:             .Visible         = .T.
441:         ENDWITH
442: 
443:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
444:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
445: 
446:         *-- Label Codigo (Say1: top=171+29=200, left=288, width=42)
447:         loc_oPg2.AddObject("lbl_4c_Label1", "Label")
448:         WITH loc_oPg2.lbl_4c_Label1
449:             .Caption   = "C" + CHR(243) + "digo :"
450:             .Top       = 200
451:             .Left      = 288
452:             .Width     = 42
453:             .Height    = 17
454:             .AutoSize  = .F.
455:             .FontName  = "Tahoma"
456:             .FontSize  = 8
457:             .FontBold  = .F.
458:             .ForeColor = RGB(90, 90, 90)
459:             .BackStyle = 0
460:             .Alignment = 1
461:             .Visible   = .T.
462:         ENDWITH
463: 
464:         *-- TextBox Codigo (getCodigos: top=168+29=197, left=335, width=33)
465:         loc_oPg2.AddObject("txt_4c_Codigos", "TextBox")
466:         WITH loc_oPg2.txt_4c_Codigos
467:             .Value         = 0
468:             .Top           = 197
469:             .Left          = 335
470:             .Width         = 33
471:             .Height        = 21
472:             .FontName      = "Tahoma"
473:             .FontSize      = 8
474:             .ForeColor     = RGB(90, 90, 90)
475:             .BackColor     = RGB(255, 255, 255)
476:             .BorderStyle   = 1
477:             .SpecialEffect = 0
478:             .Format        = "K"
479:             .InputMask     = "999"
480:             .Visible       = .T.
481:         ENDWITH
482: 
483:         *-- Label Descricao (Say2: top=196+29=225, left=275, width=60)
484:         loc_oPg2.AddObject("lbl_4c_Label2", "Label")

*-- Linhas 550 a 732:
550:             .Visible       = .T.
551:         ENDWITH
552: 
553:         BINDEVENT(loc_oPg2.txt_4c_OpAutos, "KeyPress", THIS, "ValidarOpAutos")
554: 
555:         *-- Label Operacao Saida de Cheque (Say4: top=246+29=275, left=175)
556:         loc_oPg2.AddObject("lbl_4c_Label4", "Label")
557:         WITH loc_oPg2.lbl_4c_Label4
558:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o de Saida de Cheque :"
559:             .Top       = 275
560:             .Left      = 175
561:             .Width     = 190
562:             .Height    = 17
563:             .AutoSize  = .F.
564:             .FontName  = "Tahoma"
565:             .FontSize  = 8
566:             .FontBold  = .F.
567:             .ForeColor = RGB(90, 90, 90)
568:             .BackStyle = 0
569:             .Alignment = 1
570:             .Visible   = .T.
571:         ENDWITH
572: 
573:         *-- TextBox Operacao Saida de Cheque (GetOpSaidas: top=243+29=272, left=335, width=115)
574:         loc_oPg2.AddObject("txt_4c_OpSaidas", "TextBox")
575:         WITH loc_oPg2.txt_4c_OpSaidas
576:             .Value         = ""
577:             .Top           = 272
578:             .Left          = 335
579:             .Width         = 115
580:             .Height        = 21
581:             .FontName      = "Tahoma"
582:             .FontSize      = 8
583:             .ForeColor     = RGB(90, 90, 90)
584:             .BackColor     = RGB(255, 255, 255)
585:             .BorderStyle   = 1
586:             .SpecialEffect = 0
587:             .Visible       = .T.
588:         ENDWITH
589: 
590:         BINDEVENT(loc_oPg2.txt_4c_OpSaidas, "KeyPress", THIS, "ValidarOpSaidas")
591: 
592:         *-- Label Condicao de Pagamento Automatica (Say5: top=271+29=300, left=148)
593:         loc_oPg2.AddObject("lbl_4c_Label5", "Label")
594:         WITH loc_oPg2.lbl_4c_Label5
595:             .Caption   = "Condi" + CHR(231) + CHR(227) + "o de Pagamento Automatica :"
596:             .Top       = 300
597:             .Left      = 148
598:             .Width     = 215
599:             .Height    = 17
600:             .AutoSize  = .F.
601:             .FontName  = "Tahoma"
602:             .FontSize  = 8
603:             .FontBold  = .F.
604:             .ForeColor = RGB(90, 90, 90)
605:             .BackStyle = 0
606:             .Alignment = 1
607:             .Visible   = .T.
608:         ENDWITH
609: 
610:         *-- TextBox Condicao de Pagamento Automatica (GetFPagSAutos: top=268+29=297, left=335, width=94)
611:         loc_oPg2.AddObject("txt_4c_FPagSAutos", "TextBox")
612:         WITH loc_oPg2.txt_4c_FPagSAutos
613:             .Value         = ""
614:             .Top           = 297
615:             .Left          = 335
616:             .Width         = 94
617:             .Height        = 21
618:             .FontName      = "Tahoma"
619:             .FontSize      = 8
620:             .ForeColor     = RGB(90, 90, 90)
621:             .BackColor     = RGB(255, 255, 255)
622:             .BorderStyle   = 1
623:             .SpecialEffect = 0
624:             .Visible       = .T.
625:         ENDWITH
626: 
627:         BINDEVENT(loc_oPg2.txt_4c_FPagSAutos, "KeyPress", THIS, "ValidarFPagSAutos")
628: 
629:         *-- Label Gera Pendencias Financeiras (Say6: top=295+29=324, left=184)
630:         loc_oPg2.AddObject("lbl_4c_Label6", "Label")
631:         WITH loc_oPg2.lbl_4c_Label6
632:             .Caption   = "Gera Pend" + CHR(234) + "ncias Financeiras :"
633:             .Top       = 324
634:             .Left      = 184
635:             .Width     = 180
636:             .Height    = 17
637:             .AutoSize  = .F.
638:             .FontName  = "Tahoma"
639:             .FontSize  = 8
640:             .FontBold  = .F.
641:             .ForeColor = RGB(90, 90, 90)
642:             .BackStyle = 0
643:             .Alignment = 1
644:             .Visible   = .T.
645:         ENDWITH
646: 
647:         *-- OptionGroup Gera Pendencias (optPefins: top=291+29=320, left=335, width=96, height=27)
648:         *-- Value=2 -> Nao selecionado por default; NAO setar Value em Buttons individuais
649:         loc_oPg2.AddObject("opt_4c_OptPefins", "OptionGroup")
650:         WITH loc_oPg2.opt_4c_OptPefins
651:             .ButtonCount = 2
652:             .Top         = 320
653:             .Left        = 335
654:             .Width       = 96
655:             .Height      = 27
656:             .AutoSize    = .T.
657:             .BackStyle   = 0
658:             .BorderStyle = 0
659:             .Value       = 2
660:             .Visible     = .T.
661:             WITH .Buttons(1)
662:                 .Caption   = "\<Sim"
663:                 .Left      = 5
664:                 .Top       = 5
665:                 .Width     = 40
666:                 .Height    = 17
667:                 .AutoSize  = .F.
668:                 .BackStyle = 0
669:                 .ForeColor = RGB(90, 90, 90)
670:             ENDWITH
671:             WITH .Buttons(2)
672:                 .Caption   = "\<N" + CHR(227) + "o"
673:                 .Left      = 51
674:                 .Top       = 5
675:                 .Width     = 40
676:                 .Height    = 17
677:                 .AutoSize  = .F.
678:                 .FontName  = "Tahoma"
679:                 .FontSize  = 8
680:                 .BackStyle = 0
681:                 .ForeColor = RGB(90, 90, 90)
682:             ENDWITH
683:         ENDWITH
684: 
685:         THIS.TornarControlesVisiveis(loc_oPg2)
686:     ENDPROC
687: 
688:     *--------------------------------------------------------------------------
689:     * CarregarLista - Busca alineas e carrega grid da Page1
690:     * Fase 3: Chama Buscar(). Fase 4 completa o wire do grid.
691:     *--------------------------------------------------------------------------
692:     PROCEDURE CarregarLista()
693:         LOCAL loc_lResultado, loc_oGrid
694:         loc_lResultado = .F.
695: 
696:         TRY
697:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
698:                 loc_lResultado = .T.
699:             ELSE
700:                 IF THIS.this_oBusinessObject.Buscar("")
701:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
702:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
703: 
704:                         loc_oGrid.ColumnCount = 4
705:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
706:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
707:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
708:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.opautos"
709:                         loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.fpagsautos"
710: 
711:                         loc_oGrid.Column1.Width = 50
712:                         loc_oGrid.Column2.Width = 415
713:                         loc_oGrid.Column3.Width = 200
714:                         loc_oGrid.Column4.Width = 160
715: 
716:                         loc_oGrid.Column1.ReadOnly = .T.
717:                         loc_oGrid.Column2.ReadOnly = .T.
718:                         loc_oGrid.Column3.ReadOnly = .T.
719:                         loc_oGrid.Column4.ReadOnly = .T.
720: 
721:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
722:                         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
723:                         loc_oGrid.Column3.Header1.Caption = "Oper. Autom. Cheque"
724:                         loc_oGrid.Column4.Header1.Caption = "Cond. Pag. Autom."
725: 
726:                         THIS.FormatarGridLista(loc_oGrid)
727:                     ENDIF
728:                     loc_lResultado = .T.
729:                 ENDIF
730:             ENDIF
731:         CATCH TO loc_oErro
732:             MsgErro(loc_oErro.Message, "FormAli.CarregarLista")

*-- Linhas 738 a 1259:
738:     *--------------------------------------------------------------------------
739:     * AlternarPagina - Alterna entre Lista (1) e Dados (2)
740:     *--------------------------------------------------------------------------
741:     PROCEDURE AlternarPagina(par_nPagina)
742:         LOCAL loc_lResultado
743:         loc_lResultado = .F.
744: 
745:         TRY
746:             IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
747:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
748:                 IF par_nPagina = 1
749:                     THIS.CarregarLista()
750:                 ENDIF
751:                 loc_lResultado = .T.
752:             ENDIF
753:         CATCH TO loc_oErro
754:             MsgErro(loc_oErro.Message, "FormAli.AlternarPagina")
755:         ENDTRY
756: 
757:         RETURN loc_lResultado
758:     ENDPROC
759: 
760:     *--------------------------------------------------------------------------
761:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
762:     *--------------------------------------------------------------------------
763:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
764:         LOCAL loc_nI, loc_oObjeto, loc_nP
765: 
766:         FOR loc_nI = 1 TO par_oContainer.ControlCount
767:             loc_oObjeto = par_oContainer.Controls(loc_nI)
768: 
769:             IF VARTYPE(loc_oObjeto) = "O"
770:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
771:                     loc_oObjeto.Visible = .T.
772:                 ENDIF
773: 
774:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
775:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
776:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
777:                     ENDFOR
778:                 ENDIF
779: 
780:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
781:                     THIS.TornarControlesVisiveis(loc_oObjeto)
782:                 ENDIF
783:             ENDIF
784:         ENDFOR
785:     ENDPROC
786: 
787:     *--------------------------------------------------------------------------
788:     * FormatarGridLista - Formata visual do grid da lista
789:     *--------------------------------------------------------------------------
790:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
791:         WITH par_oGrid
792:             .FontName = "Tahoma"
793:             .FontSize = 8
794:         ENDWITH
795:     ENDPROC
796: 
797:     *--------------------------------------------------------------------------
798:     * BtnIncluirClick - Prepara form para inclusao de nova alinea
799:     *--------------------------------------------------------------------------
800:     PROCEDURE BtnIncluirClick()
801:         LOCAL loc_lResultado
802:         loc_lResultado = .F.
803: 
804:         TRY
805:             THIS.this_oBusinessObject.NovoRegistro()
806:             THIS.LimparCampos()
807:             THIS.this_cModoAtual = "INCLUIR"
808:             THIS.HabilitarCampos(.T.)
809:             THIS.AjustarBotoesPorModo()
810:             THIS.AlternarPagina(2)
811:             loc_lResultado = .T.
812:         CATCH TO loc_oErro
813:             MsgErro(loc_oErro.Message, "FormAli.BtnIncluirClick")
814:         ENDTRY
815: 
816:         RETURN loc_lResultado
817:     ENDPROC
818: 
819:     *--------------------------------------------------------------------------
820:     * BtnVisualizarClick - Abre registro selecionado em modo somente leitura
821:     *--------------------------------------------------------------------------
822:     PROCEDURE BtnVisualizarClick()
823:         LOCAL loc_nCodigo, loc_lResultado
824:         loc_lResultado = .F.
825: 
826:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
827:             MsgAviso("Nenhum registro selecionado.", "Visualizar")
828:             RETURN .F.
829:         ENDIF
830: 
831:         SELECT cursor_4c_Dados
832:         loc_nCodigo = cursor_4c_Dados.codigos
833: 
834:         TRY
835:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
836:                 THIS.BOParaForm()
837:                 THIS.this_cModoAtual = "VISUALIZAR"
838:                 THIS.HabilitarCampos(.F.)
839:                 THIS.AjustarBotoesPorModo()
840:                 THIS.AlternarPagina(2)
841:                 loc_lResultado = .T.
842:             ENDIF
843:         CATCH TO loc_oErro
844:             MsgErro(loc_oErro.Message, "FormAli.BtnVisualizarClick")
845:         ENDTRY
846: 
847:         RETURN loc_lResultado
848:     ENDPROC
849: 
850:     *--------------------------------------------------------------------------
851:     * BtnAlterarClick - Abre registro selecionado para edicao
852:     *--------------------------------------------------------------------------
853:     PROCEDURE BtnAlterarClick()
854:         LOCAL loc_nCodigo, loc_lResultado
855:         loc_lResultado = .F.
856: 
857:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
858:             MsgAviso("Nenhum registro selecionado.", "Alterar")
859:             RETURN .F.
860:         ENDIF
861: 
862:         SELECT cursor_4c_Dados
863:         loc_nCodigo = cursor_4c_Dados.codigos
864: 
865:         TRY
866:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
867:                 THIS.this_oBusinessObject.EditarRegistro()
868:                 THIS.BOParaForm()
869:                 THIS.this_cModoAtual = "ALTERAR"
870:                 THIS.HabilitarCampos(.T.)
871:                 THIS.AjustarBotoesPorModo()
872:                 THIS.AlternarPagina(2)
873:                 loc_lResultado = .T.
874:             ENDIF
875:         CATCH TO loc_oErro
876:             MsgErro(loc_oErro.Message, "FormAli.BtnAlterarClick")
877:         ENDTRY
878: 
879:         RETURN loc_lResultado
880:     ENDPROC
881: 
882:     *--------------------------------------------------------------------------
883:     * BtnExcluirClick - Exclui registro selecionado apos confirmacao
884:     *--------------------------------------------------------------------------
885:     PROCEDURE BtnExcluirClick()
886:         LOCAL loc_nCodigo, loc_lResultado
887:         loc_lResultado = .F.
888: 
889:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
890:             MsgAviso("Nenhum registro selecionado.", "Excluir")
891:             RETURN .F.
892:         ENDIF
893: 
894:         SELECT cursor_4c_Dados
895:         loc_nCodigo = cursor_4c_Dados.codigos
896: 
897:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
898:             RETURN .F.
899:         ENDIF
900: 
901:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da al" + CHR(237) + ;
902:                         "nea " + TRANSFORM(loc_nCodigo) + "?", "Excluir")
903:             RETURN .F.
904:         ENDIF
905: 
906:         TRY
907:             IF THIS.this_oBusinessObject.Excluir()
908:                 MsgInfo("Al" + CHR(237) + "nea exclu" + CHR(237) + "da com sucesso!")
909:                 THIS.CarregarLista()
910:                 loc_lResultado = .T.
911:             ENDIF
912:         CATCH TO loc_oErro
913:             MsgErro(loc_oErro.Message, "FormAli.BtnExcluirClick")
914:         ENDTRY
915: 
916:         RETURN loc_lResultado
917:     ENDPROC
918: 
919:     *--------------------------------------------------------------------------
920:     * BtnBuscarClick - Vai para Page2 no modo BUSCAR (localizar por codigo)
921:     *--------------------------------------------------------------------------
922:     PROCEDURE BtnBuscarClick()
923:         LOCAL loc_lResultado
924:         loc_lResultado = .F.
925: 
926:         TRY
927:             THIS.this_oBusinessObject.NovoRegistro()
928:             THIS.LimparCampos()
929:             THIS.this_cModoAtual = "BUSCAR"
930:             THIS.HabilitarCampos(.T.)
931:             THIS.AjustarBotoesPorModo()
932:             THIS.AlternarPagina(2)
933:             loc_lResultado = .T.
934:         CATCH TO loc_oErro
935:             MsgErro(loc_oErro.Message, "FormAli.BtnBuscarClick")
936:         ENDTRY
937: 
938:         RETURN loc_lResultado
939:     ENDPROC
940: 
941:     *--------------------------------------------------------------------------
942:     * BtnEncerrarClick - Fecha o formulario
943:     *--------------------------------------------------------------------------
944:     PROCEDURE BtnEncerrarClick()
945:         THIS.Release()
946:     ENDPROC
947: 
948:     *--------------------------------------------------------------------------
949:     * BtnConfirmarClick - Salva registro (ou localiza em modo BUSCAR)
950:     *--------------------------------------------------------------------------
951:     PROCEDURE BtnConfirmarClick()
952:         LOCAL loc_oPg2, loc_nCodBusca, loc_lResultado
953:         loc_lResultado = .F.
954: 
955:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
956: 
957:         *-- Validacoes ANTES do TRY (RETURN valido aqui)
958:         IF PEMSTATUS(loc_oPg2, "txt_4c_Codigos", 5) AND ;
959:            VAL(TRANSFORM(loc_oPg2.txt_4c_Codigos.Value)) = 0 AND ;
960:            THIS.this_cModoAtual = "INCLUIR"
961:             MsgAviso("O c" + CHR(243) + "digo " + CHR(233) + " obrigat" + CHR(243) + "rio.", "")
962:             loc_oPg2.txt_4c_Codigos.SetFocus
963:             RETURN .F.
964:         ENDIF
965: 
966:         IF PEMSTATUS(loc_oPg2, "txt_4c_Descrs", 5) AND ;
967:            EMPTY(ALLTRIM(loc_oPg2.txt_4c_Descrs.Value)) AND ;
968:            !INLIST(THIS.this_cModoAtual, "BUSCAR", "VISUALIZAR")
969:             MsgAviso("A descri" + CHR(231) + CHR(227) + "o " + CHR(233) + " obrigat" + CHR(243) + "ria.", "")
970:             loc_oPg2.txt_4c_Descrs.SetFocus
971:             RETURN .F.
972:         ENDIF
973: 
974:         TRY
975:             IF THIS.this_cModoAtual = "BUSCAR"
976:                 *-- Localiza pelo codigo digitado e volta para lista
977:                 IF PEMSTATUS(loc_oPg2, "txt_4c_Codigos", 5)
978:                     loc_nCodBusca = VAL(TRANSFORM(loc_oPg2.txt_4c_Codigos.Value))
979:                 ELSE
980:                     loc_nCodBusca = 0
981:                 ENDIF
982:                 THIS.this_cModoAtual = "LISTA"
983:                 THIS.AlternarPagina(1)
984:                 IF USED("cursor_4c_Dados") AND loc_nCodBusca > 0
985:                     SELECT cursor_4c_Dados
986:                     LOCATE FOR cursor_4c_Dados.codigos = loc_nCodBusca
987:                 ENDIF
988:                 loc_lResultado = .T.
989:             ELSE
990:                 IF THIS.FormParaBO()
991:                     IF THIS.this_oBusinessObject.Salvar()
992:                         MsgInfo("Al" + CHR(237) + "nea salva com sucesso!")
993:                         THIS.this_cModoAtual = "LISTA"
994:                         THIS.AlternarPagina(1)
995:                         loc_lResultado = .T.
996:                     ENDIF
997:                 ENDIF
998:             ENDIF
999:         CATCH TO loc_oErro
1000:             MsgErro(loc_oErro.Message, "FormAli.BtnConfirmarClick")
1001:         ENDTRY
1002: 
1003:         RETURN loc_lResultado
1004:     ENDPROC
1005: 
1006:     *--------------------------------------------------------------------------
1007:     * BtnSalvarClick - Alias canonico para BtnConfirmarClick (padrao migracao)
1008:     *--------------------------------------------------------------------------
1009:     PROCEDURE BtnSalvarClick()
1010:         RETURN THIS.BtnConfirmarClick()
1011:     ENDPROC
1012: 
1013:     *--------------------------------------------------------------------------
1014:     * BtnCancelarClick - Cancela e volta para lista
1015:     *--------------------------------------------------------------------------
1016:     PROCEDURE BtnCancelarClick()
1017:         TRY
1018:             THIS.this_cModoAtual = "LISTA"
1019:             THIS.AlternarPagina(1)
1020:         CATCH TO loc_oErro
1021:             MsgErro(loc_oErro.Message, "FormAli.BtnCancelarClick")
1022:         ENDTRY
1023:     ENDPROC
1024: 
1025:     *--------------------------------------------------------------------------
1026:     * FormParaBO - Transfere valores do form para o BO
1027:     *--------------------------------------------------------------------------
1028:     PROTECTED PROCEDURE FormParaBO()
1029:         LOCAL loc_oPg2, loc_lResultado
1030:         loc_lResultado = .F.
1031: 
1032:         TRY
1033:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1034:             THIS.this_oBusinessObject.this_nCodigos    = loc_oPg2.txt_4c_Codigos.Value
1035:             THIS.this_oBusinessObject.this_cDescrs     = ALLTRIM(loc_oPg2.txt_4c_Descrs.Value)
1036:             THIS.this_oBusinessObject.this_cOpAutos    = ALLTRIM(loc_oPg2.txt_4c_OpAutos.Value)
1037:             THIS.this_oBusinessObject.this_cOpSaidas   = ALLTRIM(loc_oPg2.txt_4c_OpSaidas.Value)
1038:             THIS.this_oBusinessObject.this_cFPagSAutos = ALLTRIM(loc_oPg2.txt_4c_FPagSAutos.Value)
1039:             THIS.this_oBusinessObject.this_nPefins     = loc_oPg2.opt_4c_OptPefins.Value
1040:             loc_lResultado = .T.
1041:         CATCH TO loc_oErro
1042:             MsgErro(loc_oErro.Message, "FormAli.FormParaBO")
1043:         ENDTRY
1044: 
1045:         RETURN loc_lResultado
1046:     ENDPROC
1047: 
1048:     *--------------------------------------------------------------------------
1049:     * BOParaForm - Transfere valores do BO para o form
1050:     *--------------------------------------------------------------------------
1051:     PROTECTED PROCEDURE BOParaForm()
1052:         LOCAL loc_oPg2, loc_lResultado
1053:         loc_lResultado = .F.
1054: 
1055:         TRY
1056:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1057:             loc_oPg2.txt_4c_Codigos.Value    = THIS.this_oBusinessObject.this_nCodigos
1058:             loc_oPg2.txt_4c_Descrs.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cDescrs)
1059:             loc_oPg2.txt_4c_OpAutos.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cOpAutos)
1060:             loc_oPg2.txt_4c_OpSaidas.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cOpSaidas)
1061:             loc_oPg2.txt_4c_FPagSAutos.Value = ALLTRIM(THIS.this_oBusinessObject.this_cFPagSAutos)
1062:             loc_oPg2.opt_4c_OptPefins.Value  = THIS.this_oBusinessObject.this_nPefins
1063:             loc_lResultado = .T.
1064:         CATCH TO loc_oErro
1065:             MsgErro(loc_oErro.Message, "FormAli.BOParaForm")
1066:         ENDTRY
1067: 
1068:         RETURN loc_lResultado
1069:     ENDPROC
1070: 
1071:     *--------------------------------------------------------------------------
1072:     * LimparCampos - Limpa valores dos campos da Page2
1073:     *--------------------------------------------------------------------------
1074:     PROTECTED PROCEDURE LimparCampos()
1075:         LOCAL loc_oPg2
1076:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1077: 
1078:         TRY
1079:             loc_oPg2.txt_4c_Codigos.Value    = 0
1080:             loc_oPg2.txt_4c_Descrs.Value     = ""
1081:             loc_oPg2.txt_4c_OpAutos.Value    = ""
1082:             loc_oPg2.txt_4c_OpSaidas.Value   = ""
1083:             loc_oPg2.txt_4c_FPagSAutos.Value = ""
1084:             loc_oPg2.opt_4c_OptPefins.Value  = 2
1085:         CATCH TO loc_oErro
1086:             MsgErro(loc_oErro.Message, "FormAli.LimparCampos")
1087:         ENDTRY
1088:     ENDPROC
1089: 
1090:     *--------------------------------------------------------------------------
1091:     * HabilitarCampos - Habilita ou desabilita campos da Page2
1092:     *--------------------------------------------------------------------------
1093:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1094:         LOCAL loc_oPg2, loc_lCodHabilitar
1095:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1096: 
1097:         TRY
1098:             *-- Codigo habilitado somente em INCLUIR e BUSCAR
1099:             loc_lCodHabilitar = INLIST(THIS.this_cModoAtual, "INCLUIR", "BUSCAR")
1100:             loc_oPg2.txt_4c_Codigos.Enabled    = loc_lCodHabilitar
1101:             loc_oPg2.txt_4c_Descrs.Enabled     = par_lHabilitar
1102:             loc_oPg2.txt_4c_OpAutos.Enabled    = par_lHabilitar
1103:             loc_oPg2.txt_4c_OpSaidas.Enabled   = par_lHabilitar
1104:             loc_oPg2.txt_4c_FPagSAutos.Enabled = par_lHabilitar
1105:             loc_oPg2.opt_4c_OptPefins.Enabled  = par_lHabilitar
1106:         CATCH TO loc_oErro
1107:             MsgErro(loc_oErro.Message, "FormAli.HabilitarCampos")
1108:         ENDTRY
1109:     ENDPROC
1110: 
1111:     *--------------------------------------------------------------------------
1112:     * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo atual
1113:     *--------------------------------------------------------------------------
1114:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1115:         LOCAL loc_oBotoesAcao
1116:         loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
1117: 
1118:         TRY
1119:             *-- Confirmar habilitado em INCLUIR, ALTERAR e BUSCAR; desabilitado em VISUALIZAR
1120:             loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "BUSCAR")
1121:             loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1122:         CATCH TO loc_oErro
1123:             MsgErro(loc_oErro.Message, "FormAli.AjustarBotoesPorModo")
1124:         ENDTRY
1125:     ENDPROC
1126: 
1127:     *--------------------------------------------------------------------------
1128:     * ValidarOpAutos - Lookup para Operacao de Cheque Automatica (SigCdOpt)
1129:     *--------------------------------------------------------------------------
1130:     PROCEDURE ValidarOpAutos(par_nKeyCode, par_nShiftAltCtrl)
1131:         LOCAL loc_oPg2, loc_cValor, loc_oBusca
1132:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1133:         loc_cValor = ALLTRIM(loc_oPg2.txt_4c_OpAutos.Value)
1134: 
1135:         IF EMPTY(loc_cValor)
1136:             RETURN
1137:         ENDIF
1138: 
1139:         TRY
1140:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1141:                 "SigCdOpt", "cursor_4c_BuscaOp", "Operacaos", loc_cValor, ;
1142:                 "Opera" + CHR(231) + CHR(227) + "es de Cheques")
1143: 
1144:             IF VARTYPE(loc_oBusca) = "O"
1145:                 IF !loc_oBusca.this_lAchouRegistro
1146:                     loc_oBusca.mAddColuna("Operacaos", "", "Opera" + CHR(231) + CHR(227) + "es")
1147:                     loc_oBusca.Show()
1148:                 ENDIF
1149: 
1150:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOp")
1151:                     SELECT cursor_4c_BuscaOp
1152:                     loc_oPg2.txt_4c_OpAutos.Value = ALLTRIM(cursor_4c_BuscaOp.Operacaos)
1153:                 ENDIF
1154: 
1155:                 loc_oBusca.Release()
1156:             ENDIF
1157:         CATCH TO loc_oErro
1158:             MsgErro(loc_oErro.Message, "FormAli.ValidarOpAutos")
1159:         ENDTRY
1160: 
1161:         IF USED("cursor_4c_BuscaOp")
1162:             USE IN cursor_4c_BuscaOp
1163:         ENDIF
1164:     ENDPROC
1165: 
1166:     *--------------------------------------------------------------------------
1167:     * ValidarOpSaidas - Lookup para Operacao de Saida de Cheque (SigCdOpt)
1168:     *--------------------------------------------------------------------------
1169:     PROCEDURE ValidarOpSaidas(par_nKeyCode, par_nShiftAltCtrl)
1170:         LOCAL loc_oPg2, loc_cValor, loc_oBusca
1171:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1172:         loc_cValor = ALLTRIM(loc_oPg2.txt_4c_OpSaidas.Value)
1173: 
1174:         IF EMPTY(loc_cValor)
1175:             RETURN
1176:         ENDIF
1177: 
1178:         TRY
1179:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1180:                 "SigCdOpt", "cursor_4c_BuscaOpSai", "Operacaos", loc_cValor, ;
1181:                 "Opera" + CHR(231) + CHR(227) + "es de Saida de Cheque")
1182: 
1183:             IF VARTYPE(loc_oBusca) = "O"
1184:                 IF !loc_oBusca.this_lAchouRegistro
1185:                     loc_oBusca.mAddColuna("Operacaos", "", "Opera" + CHR(231) + CHR(227) + "es")
1186:                     loc_oBusca.Show()
1187:                 ENDIF
1188: 
1189:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpSai")
1190:                     SELECT cursor_4c_BuscaOpSai
1191:                     loc_oPg2.txt_4c_OpSaidas.Value = ALLTRIM(cursor_4c_BuscaOpSai.Operacaos)
1192:                 ENDIF
1193: 
1194:                 loc_oBusca.Release()
1195:             ENDIF
1196:         CATCH TO loc_oErro
1197:             MsgErro(loc_oErro.Message, "FormAli.ValidarOpSaidas")
1198:         ENDTRY
1199: 
1200:         IF USED("cursor_4c_BuscaOpSai")
1201:             USE IN cursor_4c_BuscaOpSai
1202:         ENDIF
1203:     ENDPROC
1204: 
1205:     *--------------------------------------------------------------------------
1206:     * ValidarFPagSAutos - Lookup para Condicao de Pagamento Automatica (SigOpFp)
1207:     *--------------------------------------------------------------------------
1208:     PROCEDURE ValidarFPagSAutos(par_nKeyCode, par_nShiftAltCtrl)
1209:         LOCAL loc_oPg2, loc_cValor, loc_oBusca
1210:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1211:         loc_cValor = ALLTRIM(loc_oPg2.txt_4c_FPagSAutos.Value)
1212: 
1213:         IF EMPTY(loc_cValor)
1214:             RETURN
1215:         ENDIF
1216: 
1217:         TRY
1218:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1219:                 "SigOpFp", "cursor_4c_BuscaFPag", "Fpags", loc_cValor, ;
1220:                 "Condi" + CHR(231) + CHR(227) + "o de Pagamento")
1221: 
1222:             IF VARTYPE(loc_oBusca) = "O"
1223:                 IF !loc_oBusca.this_lAchouRegistro
1224:                     loc_oBusca.mAddColuna("Fpags", "", "Condi" + CHR(231) + CHR(227) + "o de Pagamento")
1225:                     loc_oBusca.Show()
1226:                 ENDIF
1227: 
1228:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFPag")
1229:                     SELECT cursor_4c_BuscaFPag
1230:                     loc_oPg2.txt_4c_FPagSAutos.Value = ALLTRIM(cursor_4c_BuscaFPag.Fpags)
1231:                 ENDIF
1232: 
1233:                 loc_oBusca.Release()
1234:             ENDIF
1235:         CATCH TO loc_oErro
1236:             MsgErro(loc_oErro.Message, "FormAli.ValidarFPagSAutos")
1237:         ENDTRY
1238: 
1239:         IF USED("cursor_4c_BuscaFPag")
1240:             USE IN cursor_4c_BuscaFPag
1241:         ENDIF
1242:     ENDPROC
1243: 
1244:     *--------------------------------------------------------------------------
1245:     * Destroy - Libera recursos
1246:     *--------------------------------------------------------------------------
1247:     PROCEDURE Destroy()
1248:         TRY
1249:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1250:                 THIS.this_oBusinessObject = .NULL.
1251:             ENDIF
1252:         CATCH TO loc_oErro
1253:             MsgErro(loc_oErro.Message, "FormAli.Destroy")
1254:         ENDTRY
1255: 
1256:         DODEFAULT()
1257:     ENDPROC
1258: 
1259: ENDDEFINE


### BO (C:\4c\projeto\app\classes\AliBO.prg):
*====================================================================
* AliBO.prg
*
* Business Object para Alineas
* Tabela: SIGCDALI
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS AliBO AS BusinessBase

	*-- Propriedades da entidade (SIGCDALI)
	this_nCodigos    = 0    && codigos numeric(3,0) - PK
	this_cDescrs     = ""   && descrs char(40)
	this_cOpAutos    = ""   && opautos char(15) - FK SigCdOpt.Operacaos
	this_cOpSaidas   = ""   && opsaidas char(15) - FK SigCdOpt.Operacaos
	this_cFPagSAutos = ""   && fpagsautos char(12) - FK SigOpFp.Fpags
	this_nPefins     = 2    && pefins numeric(1,0) - 1=Sim, 2=Nao
	this_nReincids   = 0    && reincids numeric(4,2) - nao exibido no form

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SIGCDALI"
		THIS.this_cCampoChave = "codigos"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN TRANSFORM(THIS.this_nCodigos)
	ENDPROC

	*====================================================================
	* Buscar - Carrega lista de alineas no cursor_4c_Dados
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(par_cFiltro)
				loc_cSQL = "SELECT codigos, descrs, opautos, fpagsautos, opsaidas, pefins, reincids" + ;
				           " FROM SigCdAli" + ;
				           " ORDER BY codigos"
			ELSE
				loc_cSQL = "SELECT codigos, descrs, opautos, fpagsautos, opsaidas, pefins, reincids" + ;
				           " FROM SigCdAli" + ;
				           " WHERE codigos = " + FormatarNumeroSQL(VAL(ALLTRIM(par_cFiltro))) + ;
				           " ORDER BY codigos"
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar al" + CHR(237) + "neas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar al" + CHR(237) + "neas:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um registro pelo codigo (PK)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_nCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT codigos, descrs, opautos, fpagsautos, opsaidas, pefins, reincids" + ;
			           " FROM SigCdAli" + ;
			           " WHERE codigos = " + FormatarNumeroSQL(par_nCodigo)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar al" + CHR(237) + "nea:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_nCodigos    = TratarNulo(codigos, "N")
			THIS.this_cDescrs     = TratarNulo(descrs, "C")
			THIS.this_cOpAutos    = TratarNulo(opautos, "C")
			THIS.this_cOpSaidas   = TratarNulo(opsaidas, "C")
			THIS.this_cFPagSAutos = TratarNulo(fpagsautos, "C")
			THIS.this_nPefins     = TratarNulo(pefins, "N")
			THIS.this_nReincids   = TratarNulo(reincids, "N")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - INSERT na tabela SigCdAli
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "INSERT INTO SigCdAli (codigos, descrs, opautos, opsaidas, fpagsautos, pefins)" + ;
			           " VALUES (" + ;
			           FormatarNumeroSQL(THIS.this_nCodigos) + "," + ;
			           EscaparSQL(THIS.this_cDescrs) + "," + ;
			           EscaparSQL(THIS.this_cOpAutos) + "," + ;
			           EscaparSQL(THIS.this_cOpSaidas) + "," + ;
			           EscaparSQL(THIS.this_cFPagSAutos) + "," + ;
			           FormatarNumeroSQL(THIS.this_nPefins) + ;
			           ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao inserir al" + CHR(237) + "nea:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir al" + CHR(237) + "nea:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE na tabela SigCdAli
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SigCdAli SET" + ;
			           " descrs = " + EscaparSQL(THIS.this_cDescrs) + "," + ;
			           " opautos = " + EscaparSQL(THIS.this_cOpAutos) + "," + ;
			           " opsaidas = " + EscaparSQL(THIS.this_cOpSaidas) + "," + ;
			           " fpagsautos = " + EscaparSQL(THIS.this_cFPagSAutos) + "," + ;
			           " pefins = " + FormatarNumeroSQL(THIS.this_nPefins) + ;
			           " WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar al" + CHR(237) + "nea:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar al" + CHR(237) + "nea:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE da tabela SigCdAli
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCdAli WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir al" + CHR(237) + "nea:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir al" + CHR(237) + "nea:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

