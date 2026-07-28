# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=11 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Dados' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [LAYOUT-POSITION] Controle 'Get_grupo' (parent: SIGCDCCR.Pagina.Dados.PageFrame1.Geral): Left original=486 vs migrado 'Get_grupo' Left=179 (diff=307px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formccr.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (6744 linhas total):

*-- Linhas 29 a 153:
29:     this_oUltimoCntFat   = .NULL.
30: 
31:     *--------------------------------------------------------------------------
32:     * Init - Retorna DODEFAULT (FormBase.Init chama InicializarForm)
33:     *--------------------------------------------------------------------------
34:     PROCEDURE Init()
35:         LOCAL loc_lResultado
36:         loc_lResultado = .F.
37: 
38:         TRY
39:             loc_lResultado = DODEFAULT()
40:         CATCH TO loc_oErro
41:             MsgErro(loc_oErro.Message, "Formccr.Init")
42:         ENDTRY
43: 
44:         RETURN loc_lResultado
45:     ENDPROC
46: 
47:     *--------------------------------------------------------------------------
48:     * InicializarForm - Configura estrutura completa do formulario
49:     * Chamado automaticamente pelo FormBase.Init()
50:     *--------------------------------------------------------------------------
51:     PROTECTED PROCEDURE InicializarForm()
52:         LOCAL loc_lResultado
53:         loc_lResultado = .F.
54: 
55:         TRY
56:             THIS.this_oBusinessObject = CREATEOBJECT("ccrBO")
57: 
58:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
59:                 MsgErro("Falha ao criar ccrBO", "Erro")
60:             ELSE
61:                 THIS.ConfigurarPageFrame()
62: 
63:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
64:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
65: 
66:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
67:                     THIS.CarregarLista()
68:                 ENDIF
69: 
70:                 THIS.pgf_4c_Paginas.Visible = .T.
71:                 THIS.pgf_4c_Paginas.ActivePage = 1
72:                 THIS.this_cModoAtual = "LISTA"
73:                 loc_lResultado = .T.
74:             ENDIF
75:         CATCH TO loc_oErro
76:             MsgErro(loc_oErro.Message, "Formccr.InicializarForm")
77:         ENDTRY
78: 
79:         RETURN loc_lResultado
80:     ENDPROC
81: 
82:     *--------------------------------------------------------------------------
83:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
84:     *--------------------------------------------------------------------------
85:     PROTECTED PROCEDURE ConfigurarPageFrame()
86:         LOCAL loc_oPgf
87:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
88:         loc_oPgf = THIS.pgf_4c_Paginas
89: 
90:         WITH loc_oPgf
91:             .PageCount = 2
92:             .Top       = -29
93:             .Left      = 0
94:             .Width     = THIS.Width
95:             .Height    = THIS.Height + 29
96:             .Tabs      = .F.
97:             .Visible   = .T.
98:             .Page1.Caption   = "Lista"
99:             .Page1.BackColor = RGB(100, 100, 100)
100:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
101:             .Page2.Caption   = "Dados"
102:             .Page2.BackColor = RGB(100, 100, 100)
103:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
104:         ENDWITH
105: 
106:         THIS.ConfigurarPaginaLista()
107:         THIS.ConfigurarPaginaDados()
108:     ENDPROC
109: 
110:     *--------------------------------------------------------------------------
111:     * ConfigurarPaginaLista - Cria containers da Page1 (Lista)
112:     *--------------------------------------------------------------------------
113:     PROTECTED PROCEDURE ConfigurarPaginaLista()
114:         LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida, loc_oGrid
115:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
116: 
117:         *-- Container cabecalho cinza escuro
118:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
119:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
120:         WITH loc_oCab
121:             .Top         = 31
122:             .Left        = 0
123:             .Width       = THIS.Width
124:             .Height      = 80
125:             .BackColor   = RGB(100, 100, 100)
126:             .BorderWidth = 0
127:             .Visible     = .T.
128:         ENDWITH
129: 
130:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
131:         WITH loc_oCab.lbl_4c_Sombra
132:             .AutoSize  = .F.
133:             .Caption   = THIS.Caption
134:             .Top       = 15
135:             .Left      = 10
136:             .Width     = THIS.Width
137:             .Height    = 40
138:             .FontName  = "Tahoma"
139:             .FontSize  = 16
140:             .FontBold  = .T.
141:             .ForeColor = RGB(0, 0, 0)
142:             .BackStyle = 0
143:             .Visible   = .T.
144:         ENDWITH
145: 
146:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
147:         WITH loc_oCab.lbl_4c_Titulo
148:             .AutoSize  = .F.
149:             .Caption   = THIS.Caption
150:             .Top       = 18
151:             .Left      = 10
152:             .Width     = THIS.Width
153:             .Height    = 46

*-- Linhas 288 a 410:
288:             .Visible         = .T.
289:         ENDWITH
290: 
291:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
292:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
293:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
294:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
295:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
296: 
297:         *-- Container Encerrar (canonico: Left=917, Width=90, Height=85)
298:         loc_oPg1.AddObject("cnt_4c_Saida", "Container")
299:         loc_oSaida = loc_oPg1.cnt_4c_Saida
300:         WITH loc_oSaida
301:             .Top         = 29
302:             .Left        = 917
303:             .Width       = 90
304:             .Height      = 85
305:             .BackStyle   = 0
306:             .BorderWidth = 0
307:             .Visible     = .T.
308:         ENDWITH
309: 
310:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
311:         WITH loc_oSaida.cmd_4c_Encerrar
312:             .Caption         = "Encerrar"
313:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
314:             .PicturePosition = 13
315:             .Top             = 5
316:             .Left            = 5
317:             .Width           = 75
318:             .Height          = 75
319:             .BackColor       = RGB(255, 255, 255)
320:             .ForeColor       = RGB(90, 90, 90)
321:             .FontName        = "Tahoma"
322:             .FontSize        = 8
323:             .FontBold        = .T.
324:             .FontItalic      = .T.
325:             .Themes          = .F.
326:             .SpecialEffect   = 0
327:             .MousePointer    = 15
328:             .WordWrap        = .T.
329:             .AutoSize        = .F.
330:             .Visible         = .T.
331:         ENDWITH
332: 
333:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
334: 
335:         *-- Grid de lista
336:         loc_oPg1.AddObject("grd_4c_Lista", "Grid")
337:         loc_oGrid = loc_oPg1.grd_4c_Lista
338: 
339:         loc_oGrid.RecordSource = ""
340:         loc_oGrid.ColumnCount  = 2
341: 
342:         WITH loc_oGrid
343:             .Top                = 117
344:             .Left               = 26
345:             .Width              = 945
346:             .Height             = 460
347:             .FontName           = "Verdana"
348:             .FontSize           = 8
349:             .ForeColor          = RGB(90, 90, 90)
350:             .BackColor          = RGB(255, 255, 255)
351:             .GridLineColor      = RGB(238, 238, 238)
352:             .HighlightBackColor = RGB(255, 255, 255)
353:             .HighlightForeColor = RGB(15, 41, 104)
354:             .HighlightStyle     = 2
355:             .DeleteMark         = .F.
356:             .RecordMark         = .F.
357:             .RowHeight          = 16
358:             .ScrollBars         = 2
359:             .GridLines          = 3
360:             .ReadOnly           = .T.
361:             .Visible            = .T.
362:         ENDWITH
363: 
364:         THIS.TornarControlesVisiveis(loc_oPg1)
365:     ENDPROC
366: 
367:     *--------------------------------------------------------------------------
368:     * ConfigurarPaginaDados - Cria containers da Page2 (Dados)
369:     *--------------------------------------------------------------------------
370:     PROTECTED PROCEDURE ConfigurarPaginaDados()
371:         LOCAL loc_oPg2, loc_oBotoesAcao
372:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
373: 
374:         *-- Container Confirmar/Cancelar (Top=33, Left=838, Width=160)
375:         loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
376:         loc_oBotoesAcao = loc_oPg2.cnt_4c_BotoesAcao
377:         WITH loc_oBotoesAcao
378:             .Top         = 33
379:             .Left        = 838
380:             .Width       = 160
381:             .Height      = 85
382:             .BackStyle   = 0
383:             .BorderWidth = 0
384:             .Visible     = .T.
385:         ENDWITH
386: 
387:         loc_oBotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
388:         WITH loc_oBotoesAcao.cmd_4c_Confirmar
389:             .Caption         = "Confirmar"
390:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
391:             .PicturePosition = 13
392:             .Top             = 5
393:             .Left            = 5
394:             .Width           = 75
395:             .Height          = 75
396:             .BackColor       = RGB(255, 255, 255)
397:             .ForeColor       = RGB(90, 90, 90)
398:             .FontName        = "Tahoma"
399:             .FontSize        = 8
400:             .FontBold        = .T.
401:             .FontItalic      = .T.
402:             .Themes          = .F.
403:             .SpecialEffect   = 0
404:             .MousePointer    = 15
405:             .WordWrap        = .T.
406:             .AutoSize        = .F.
407:             .Visible         = .T.
408:         ENDWITH
409: 
410:         loc_oBotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")

*-- Linhas 430 a 474:
430:             .Visible         = .T.
431:         ENDWITH
432: 
433:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
434:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
435: 
436:         *-- Label + TextBox Codigo
437:         loc_oPg2.AddObject("lbl_4c_LblCodigo", "Label")
438:         WITH loc_oPg2.lbl_4c_LblCodigo
439:             .Caption   = "C" + CHR(243) + "digo:"
440:             .Top       = 47
441:             .Left      = 39
442:             .Width     = 42
443:             .Height    = 17
444:             .FontName  = "Tahoma"
445:             .FontSize  = 8
446:             .ForeColor = RGB(90, 90, 90)
447:             .BackStyle = 0
448:             .Alignment = 1
449:             .Visible   = .T.
450:         ENDWITH
451: 
452:         loc_oPg2.AddObject("txt_4c_Codigo", "TextBox")
453:         WITH loc_oPg2.txt_4c_Codigo
454:             .Value         = ""
455:             .Top           = 43
456:             .Left          = 83
457:             .Width         = 80
458:             .Height        = 23
459:             .MaxLength     = 10
460:             .FontName      = "Tahoma"
461:             .FontSize      = 8
462:             .ForeColor     = RGB(90, 90, 90)
463:             .BackColor     = RGB(255, 255, 255)
464:             .Themes        = .F.
465:             .SpecialEffect = 0
466:             .Visible       = .T.
467:         ENDWITH
468: 
469:         *-- Label + TextBox Digito
470:         loc_oPg2.AddObject("lbl_4c_LblDigito", "Label")
471:         WITH loc_oPg2.lbl_4c_LblDigito
472:             .Caption   = "D" + CHR(237) + "g:"
473:             .Top       = 47
474:             .Left      = 176

*-- Linhas 615 a 1560:
615:             .Visible       = .T.
616:         ENDWITH
617: 
618:         BINDEVENT(loc_oPg2.txt_4c_Classes, "KeyPress",  THIS, "ClassesKeyPress")
619:         BINDEVENT(loc_oPg2.txt_4c_Classes, "DblClick",  THIS, "ClassesDblClick")
620:         BINDEVENT(loc_oPg2.txt_4c_Classes, "KeyPress", THIS, "ClassesLostFocus")
621: 
622:         *-- Label + OptionGroup Codificacao
623:         loc_oPg2.AddObject("lbl_4c_LblTpCods", "Label")
624:         WITH loc_oPg2.lbl_4c_LblTpCods
625:             .Caption   = "Codifica" + CHR(231) + CHR(227) + "o:"
626:             .Top       = 100
627:             .Left      = 17
628:             .Width     = 64
629:             .Height    = 17
630:             .FontName  = "Tahoma"
631:             .FontSize  = 8
632:             .ForeColor = RGB(90, 90, 90)
633:             .BackStyle = 0
634:             .Alignment = 1
635:             .Visible   = .T.
636:         ENDWITH
637: 
638:         loc_oPg2.AddObject("obj_4c_Opt_TpCods", "OptionGroup")
639:         WITH loc_oPg2.obj_4c_Opt_TpCods
640:             .ButtonCount = 2
641:             .Top         = 94
642:             .Left        = 83
643:             .Width       = 150
644:             .Height      = 23
645:             .BackStyle   = 0
646:             .BorderStyle = 0
647:             .Value       = 1
648:             .Visible     = .T.
649:         ENDWITH
650: 
651:         loc_oPg2.obj_4c_Opt_TpCods.Buttons(1).Caption   = "Simples"
652:         loc_oPg2.obj_4c_Opt_TpCods.Buttons(1).Left      = 5
653:         loc_oPg2.obj_4c_Opt_TpCods.Buttons(1).Top       = 3
654:         loc_oPg2.obj_4c_Opt_TpCods.Buttons(1).Width     = 65
655:         loc_oPg2.obj_4c_Opt_TpCods.Buttons(1).FontName  = "Tahoma"
656:         loc_oPg2.obj_4c_Opt_TpCods.Buttons(1).FontSize  = 8
657:         loc_oPg2.obj_4c_Opt_TpCods.Buttons(1).ForeColor = RGB(90, 90, 90)
658:         loc_oPg2.obj_4c_Opt_TpCods.Buttons(1).Themes    = .F.
659: 
660:         loc_oPg2.obj_4c_Opt_TpCods.Buttons(2).Caption   = "Composto"
661:         loc_oPg2.obj_4c_Opt_TpCods.Buttons(2).Left      = 75
662:         loc_oPg2.obj_4c_Opt_TpCods.Buttons(2).Top       = 3
663:         loc_oPg2.obj_4c_Opt_TpCods.Buttons(2).Width     = 70
664:         loc_oPg2.obj_4c_Opt_TpCods.Buttons(2).FontName  = "Tahoma"
665:         loc_oPg2.obj_4c_Opt_TpCods.Buttons(2).FontSize  = 8
666:         loc_oPg2.obj_4c_Opt_TpCods.Buttons(2).ForeColor = RGB(90, 90, 90)
667:         loc_oPg2.obj_4c_Opt_TpCods.Buttons(2).Themes    = .F.
668: 
669:         *-- Label + OptionGroup Incluir Empresa
670:         loc_oPg2.AddObject("lbl_4c_LblTpEmps", "Label")
671:         WITH loc_oPg2.lbl_4c_LblTpEmps
672:             .Caption   = "Incluir Empresa:"
673:             .Top       = 97
674:             .Left      = 318
675:             .Width     = 90
676:             .Height    = 17
677:             .FontName  = "Tahoma"
678:             .FontSize  = 8
679:             .ForeColor = RGB(90, 90, 90)
680:             .BackStyle = 0
681:             .Alignment = 1
682:             .Visible   = .T.
683:         ENDWITH
684: 
685:         loc_oPg2.AddObject("obj_4c_Opt_TpEmps", "OptionGroup")
686:         WITH loc_oPg2.obj_4c_Opt_TpEmps
687:             .ButtonCount = 3
688:             .Top         = 93
689:             .Left        = 459
690:             .Width       = 225
691:             .Height      = 23
692:             .BackStyle   = 0
693:             .BorderStyle = 0
694:             .Value       = 1
695:             .Visible     = .T.
696:         ENDWITH
697: 
698:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(1).Caption   = "N" + CHR(227) + "o"
699:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(1).Left      = 5
700:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(1).Top       = 3
701:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(1).Width     = 40
702:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(1).FontName  = "Tahoma"
703:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(1).FontSize  = 8
704:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(1).ForeColor = RGB(90, 90, 90)
705:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(1).Themes    = .F.
706: 
707:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(2).Caption   = "Sim"
708:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(2).Left      = 50
709:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(2).Top       = 3
710:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(2).Width     = 40
711:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(2).FontName  = "Tahoma"
712:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(2).FontSize  = 8
713:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(2).ForeColor = RGB(90, 90, 90)
714:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(2).Themes    = .F.
715: 
716:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(3).Caption   = "Obrigat" + CHR(243) + "rio"
717:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(3).Left      = 95
718:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(3).Top       = 3
719:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(3).Width     = 85
720:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(3).FontName  = "Tahoma"
721:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(3).FontSize  = 8
722:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(3).ForeColor = RGB(90, 90, 90)
723:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(3).Themes    = .F.
724: 
725:         *-- Label + OptionGroup Tipo
726:         loc_oPg2.AddObject("lbl_4c_LblTpCads", "Label")
727:         WITH loc_oPg2.lbl_4c_LblTpCads
728:             .Caption   = "Tipo:"
729:             .Top       = 124
730:             .Left      = 52
731:             .Width     = 30
732:             .Height    = 17
733:             .FontName  = "Tahoma"
734:             .FontSize  = 8
735:             .ForeColor = RGB(90, 90, 90)
736:             .BackStyle = 0
737:             .Alignment = 1
738:             .Visible   = .T.
739:         ENDWITH
740: 
741:         loc_oPg2.AddObject("obj_4c_Opt_TpCads", "OptionGroup")
742:         WITH loc_oPg2.obj_4c_Opt_TpCads
743:             .ButtonCount = 2
744:             .Top         = 120
745:             .Left        = 83
746:             .Width       = 150
747:             .Height      = 23
748:             .BackStyle   = 0
749:             .BorderStyle = 0
750:             .Value       = 1
751:             .Visible     = .T.
752:         ENDWITH
753: 
754:         loc_oPg2.obj_4c_Opt_TpCads.Buttons(1).Caption   = "Pessoa F" + CHR(237) + "sica"
755:         loc_oPg2.obj_4c_Opt_TpCads.Buttons(1).Left      = 5
756:         loc_oPg2.obj_4c_Opt_TpCads.Buttons(1).Top       = 3
757:         loc_oPg2.obj_4c_Opt_TpCads.Buttons(1).Width     = 70
758:         loc_oPg2.obj_4c_Opt_TpCads.Buttons(1).FontName  = "Tahoma"
759:         loc_oPg2.obj_4c_Opt_TpCads.Buttons(1).FontSize  = 8
760:         loc_oPg2.obj_4c_Opt_TpCads.Buttons(1).ForeColor = RGB(90, 90, 90)
761:         loc_oPg2.obj_4c_Opt_TpCads.Buttons(1).Themes    = .F.
762: 
763:         loc_oPg2.obj_4c_Opt_TpCads.Buttons(2).Caption   = "Pessoa Jur" + CHR(237) + "dica"
764:         loc_oPg2.obj_4c_Opt_TpCads.Buttons(2).Left      = 80
765:         loc_oPg2.obj_4c_Opt_TpCads.Buttons(2).Top       = 3
766:         loc_oPg2.obj_4c_Opt_TpCads.Buttons(2).Width     = 70
767:         loc_oPg2.obj_4c_Opt_TpCads.Buttons(2).FontName  = "Tahoma"
768:         loc_oPg2.obj_4c_Opt_TpCads.Buttons(2).FontSize  = 8
769:         loc_oPg2.obj_4c_Opt_TpCads.Buttons(2).ForeColor = RGB(90, 90, 90)
770:         loc_oPg2.obj_4c_Opt_TpCads.Buttons(2).Themes    = .F.
771: 
772:         *-- PageFrame interno (abas Geral/Cadastro/Estoque/Faturamento)
773:         THIS.CriarPageFrameInterno(loc_oPg2)
774: 
775:         THIS.TornarControlesVisiveis(loc_oPg2)
776:     ENDPROC
777: 
778:     *--------------------------------------------------------------------------
779:     * CriarPageFrameInterno - Cria pgf_4c_1 com 4 abas dentro da Page2
780:     *--------------------------------------------------------------------------
781:     PROTECTED PROCEDURE CriarPageFrameInterno(par_oPg2)
782:         LOCAL loc_oPgf1
783:         par_oPg2.AddObject("pgf_4c_1", "PageFrame")
784:         loc_oPgf1 = par_oPg2.pgf_4c_1
785: 
786:         WITH loc_oPgf1
787:             .Top       = 146
788:             .Left      = 1
789:             .Width     = 998
790:             .Height    = 454
791:             .Tabs      = .T.
792:             .PageCount = 4
793:             .Visible   = .T.
794:             .Page1.Caption = "Geral"
795:             .Page2.Caption = "Cadastro"
796:             .Page3.Caption = "Estoque"
797:             .Page4.Caption = "Faturamento"
798:         ENDWITH
799: 
800:         THIS.CriarAbaGeral(loc_oPgf1.Page1)
801:         THIS.CriarAbaCadastro(loc_oPgf1.Page2)
802:         THIS.CriarAbaEstoque(loc_oPgf1.Page3)
803:         THIS.CriarAbaFaturamento(loc_oPgf1.Page4)
804:     ENDPROC
805: 
806:     *--------------------------------------------------------------------------
807:     * CriarAbaGeral - Controles da aba Geral (pgf_4c_1.Page1)
808:     *--------------------------------------------------------------------------
809:     PROTECTED PROCEDURE CriarAbaGeral(par_oPg)
810:         LOCAL loc_oOpt
811: 
812:         *-- Coluna esquerda: opcoes gerais (Left ~92-165)
813:         *-- Complemento
814:         par_oPg.AddObject("lbl_4c_LblComple", "Label")
815:         WITH par_oPg.lbl_4c_LblComple
816:             .Caption = "Complemento:"
817:             .Top = 18
818:             .Left = 92
819:             .Width = 72
820:             .Height = 17
821:             .FontName = "Tahoma"
822:             .FontSize = 8
823:             .ForeColor = RGB(90,90,90)
824:             .BackStyle = 0
825:             .Alignment = 1
826:             .Visible = .T.
827:         ENDWITH
828: 
829:         par_oPg.AddObject("obj_4c_Opt_Comple", "OptionGroup")
830:         loc_oOpt = par_oPg.obj_4c_Opt_Comple
831:         WITH loc_oOpt
832:             .ButtonCount = 2
833:             .Top = 15
834:             .Left = 165
835:             .Width = 97
836:             .Height = 23
837:             .BackStyle = 0
838:             .BorderStyle = 0
839:             .Value = 1
840:             .Visible = .T.
841:         ENDWITH
842:         loc_oOpt.Buttons(1).Caption = "Sim"
843:         loc_oOpt.Buttons(1).Left = 5
844:         loc_oOpt.Buttons(1).Top = 3
845:         loc_oOpt.Buttons(1).Width = 40
846:         loc_oOpt.Buttons(1).FontName = "Tahoma"
847:         loc_oOpt.Buttons(1).FontSize = 8
848:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
849:         loc_oOpt.Buttons(1).Themes = .F.
850:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
851:         loc_oOpt.Buttons(2).Left = 48
852:         loc_oOpt.Buttons(2).Top = 3
853:         loc_oOpt.Buttons(2).Width = 44
854:         loc_oOpt.Buttons(2).FontName = "Tahoma"
855:         loc_oOpt.Buttons(2).FontSize = 8
856:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
857:         loc_oOpt.Buttons(2).Themes = .F.
858: 
859:         *-- Dados Pessoais
860:         par_oPg.AddObject("lbl_4c_LblPessoais", "Label")
861:         WITH par_oPg.lbl_4c_LblPessoais
862:             .Caption = "Dados Pessoais:"
863:             .Top = 44
864:             .Left = 83
865:             .Width = 80
866:             .Height = 17
867:             .FontName = "Tahoma"
868:             .FontSize = 8
869:             .ForeColor = RGB(90,90,90)
870:             .BackStyle = 0
871:             .Alignment = 1
872:             .Visible = .T.
873:         ENDWITH
874: 
875:         par_oPg.AddObject("obj_4c_Opt_Pessoais", "OptionGroup")
876:         loc_oOpt = par_oPg.obj_4c_Opt_Pessoais
877:         WITH loc_oOpt
878:             .ButtonCount = 2
879:             .Top = 41
880:             .Left = 165
881:             .Width = 97
882:             .Height = 23
883:             .BackStyle = 0
884:             .BorderStyle = 0
885:             .Value = 1
886:             .Visible = .T.
887:         ENDWITH
888:         loc_oOpt.Buttons(1).Caption = "Sim"
889:         loc_oOpt.Buttons(1).Left = 5
890:         loc_oOpt.Buttons(1).Top = 3
891:         loc_oOpt.Buttons(1).Width = 40
892:         loc_oOpt.Buttons(1).FontName = "Tahoma"
893:         loc_oOpt.Buttons(1).FontSize = 8
894:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
895:         loc_oOpt.Buttons(1).Themes = .F.
896:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
897:         loc_oOpt.Buttons(2).Left = 48
898:         loc_oOpt.Buttons(2).Top = 3
899:         loc_oOpt.Buttons(2).Width = 44
900:         loc_oOpt.Buttons(2).FontName = "Tahoma"
901:         loc_oOpt.Buttons(2).FontSize = 8
902:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
903:         loc_oOpt.Buttons(2).Themes = .F.
904: 
905:         *-- Ref. Bancarias
906:         par_oPg.AddObject("lbl_4c_LblRefbancs", "Label")
907:         WITH par_oPg.lbl_4c_LblRefbancs
908:             .Caption = "Ref. Banc" + CHR(225) + "rias:"
909:             .Top = 70
910:             .Left = 87
911:             .Width = 77
912:             .Height = 17
913:             .FontName = "Tahoma"
914:             .FontSize = 8
915:             .ForeColor = RGB(90,90,90)
916:             .BackStyle = 0
917:             .Alignment = 1
918:             .Visible = .T.
919:         ENDWITH
920: 
921:         par_oPg.AddObject("obj_4c_Opt_RefBancs", "OptionGroup")
922:         loc_oOpt = par_oPg.obj_4c_Opt_RefBancs
923:         WITH loc_oOpt
924:             .ButtonCount = 2
925:             .Top = 67
926:             .Left = 165
927:             .Width = 97
928:             .Height = 23
929:             .BackStyle = 0
930:             .BorderStyle = 0
931:             .Value = 1
932:             .Visible = .T.
933:         ENDWITH
934:         loc_oOpt.Buttons(1).Caption = "Sim"
935:         loc_oOpt.Buttons(1).Left = 5
936:         loc_oOpt.Buttons(1).Top = 3
937:         loc_oOpt.Buttons(1).Width = 40
938:         loc_oOpt.Buttons(1).FontName = "Tahoma"
939:         loc_oOpt.Buttons(1).FontSize = 8
940:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
941:         loc_oOpt.Buttons(1).Themes = .F.
942:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
943:         loc_oOpt.Buttons(2).Left = 48
944:         loc_oOpt.Buttons(2).Top = 3
945:         loc_oOpt.Buttons(2).Width = 44
946:         loc_oOpt.Buttons(2).FontName = "Tahoma"
947:         loc_oOpt.Buttons(2).FontSize = 8
948:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
949:         loc_oOpt.Buttons(2).Themes = .F.
950: 
951:         *-- Follow-Up
952:         par_oPg.AddObject("lbl_4c_LblFollowUp", "Label")
953:         WITH par_oPg.lbl_4c_LblFollowUp
954:             .Caption = "Follow-Up:"
955:             .Top = 97
956:             .Left = 110
957:             .Width = 54
958:             .Height = 17
959:             .FontName = "Tahoma"
960:             .FontSize = 8
961:             .ForeColor = RGB(90,90,90)
962:             .BackStyle = 0
963:             .Alignment = 1
964:             .Visible = .T.
965:         ENDWITH
966: 
967:         par_oPg.AddObject("obj_4c_Opt_FollowUp", "OptionGroup")
968:         loc_oOpt = par_oPg.obj_4c_Opt_FollowUp
969:         WITH loc_oOpt
970:             .ButtonCount = 2
971:             .Top = 94
972:             .Left = 165
973:             .Width = 97
974:             .Height = 23
975:             .BackStyle = 0
976:             .BorderStyle = 0
977:             .Value = 1
978:             .Visible = .T.
979:         ENDWITH
980:         loc_oOpt.Buttons(1).Caption = "Sim"
981:         loc_oOpt.Buttons(1).Left = 5
982:         loc_oOpt.Buttons(1).Top = 3
983:         loc_oOpt.Buttons(1).Width = 40
984:         loc_oOpt.Buttons(1).FontName = "Tahoma"
985:         loc_oOpt.Buttons(1).FontSize = 8
986:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
987:         loc_oOpt.Buttons(1).Themes = .F.
988:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
989:         loc_oOpt.Buttons(2).Left = 48
990:         loc_oOpt.Buttons(2).Top = 3
991:         loc_oOpt.Buttons(2).Width = 44
992:         loc_oOpt.Buttons(2).FontName = "Tahoma"
993:         loc_oOpt.Buttons(2).FontSize = 8
994:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
995:         loc_oOpt.Buttons(2).Themes = .F.
996: 
997:         *-- Dados Fiscais
998:         par_oPg.AddObject("lbl_4c_LblFiscais", "Label")
999:         WITH par_oPg.lbl_4c_LblFiscais
1000:             .Caption = "Dados Fiscais:"
1001:             .Top = 123
1002:             .Left = 93
1003:             .Width = 71
1004:             .Height = 17
1005:             .FontName = "Tahoma"
1006:             .FontSize = 8
1007:             .ForeColor = RGB(90,90,90)
1008:             .BackStyle = 0
1009:             .Alignment = 1
1010:             .Visible = .T.
1011:         ENDWITH
1012: 
1013:         par_oPg.AddObject("obj_4c_Opt_Fiscais", "OptionGroup")
1014:         loc_oOpt = par_oPg.obj_4c_Opt_Fiscais
1015:         WITH loc_oOpt
1016:             .ButtonCount = 2
1017:             .Top = 120
1018:             .Left = 165
1019:             .Width = 97
1020:             .Height = 23
1021:             .BackStyle = 0
1022:             .BorderStyle = 0
1023:             .Value = 1
1024:             .Visible = .T.
1025:         ENDWITH
1026:         loc_oOpt.Buttons(1).Caption = "Sim"
1027:         loc_oOpt.Buttons(1).Left = 5
1028:         loc_oOpt.Buttons(1).Top = 3
1029:         loc_oOpt.Buttons(1).Width = 40
1030:         loc_oOpt.Buttons(1).FontName = "Tahoma"
1031:         loc_oOpt.Buttons(1).FontSize = 8
1032:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
1033:         loc_oOpt.Buttons(1).Themes = .F.
1034:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
1035:         loc_oOpt.Buttons(2).Left = 48
1036:         loc_oOpt.Buttons(2).Top = 3
1037:         loc_oOpt.Buttons(2).Width = 44
1038:         loc_oOpt.Buttons(2).FontName = "Tahoma"
1039:         loc_oOpt.Buttons(2).FontSize = 8
1040:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
1041:         loc_oOpt.Buttons(2).Themes = .F.
1042: 
1043:         *-- Dados Comerciais
1044:         par_oPg.AddObject("lbl_4c_LblDadcoms", "Label")
1045:         WITH par_oPg.lbl_4c_LblDadcoms
1046:             .Caption = "Dados Comerciais:"
1047:             .Top = 148
1048:             .Left = 73
1049:             .Width = 91
1050:             .Height = 17
1051:             .FontName = "Tahoma"
1052:             .FontSize = 8
1053:             .ForeColor = RGB(90,90,90)
1054:             .BackStyle = 0
1055:             .Alignment = 1
1056:             .Visible = .T.
1057:         ENDWITH
1058: 
1059:         par_oPg.AddObject("obj_4c_Opt_DadosCom", "OptionGroup")
1060:         loc_oOpt = par_oPg.obj_4c_Opt_DadosCom
1061:         WITH loc_oOpt
1062:             .ButtonCount = 2
1063:             .Top = 146
1064:             .Left = 165
1065:             .Width = 97
1066:             .Height = 23
1067:             .BackStyle = 0
1068:             .BorderStyle = 0
1069:             .Value = 1
1070:             .Visible = .T.
1071:         ENDWITH
1072:         loc_oOpt.Buttons(1).Caption = "Sim"
1073:         loc_oOpt.Buttons(1).Left = 5
1074:         loc_oOpt.Buttons(1).Top = 3
1075:         loc_oOpt.Buttons(1).Width = 40
1076:         loc_oOpt.Buttons(1).FontName = "Tahoma"
1077:         loc_oOpt.Buttons(1).FontSize = 8
1078:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
1079:         loc_oOpt.Buttons(1).Themes = .F.
1080:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
1081:         loc_oOpt.Buttons(2).Left = 48
1082:         loc_oOpt.Buttons(2).Top = 3
1083:         loc_oOpt.Buttons(2).Width = 44
1084:         loc_oOpt.Buttons(2).FontName = "Tahoma"
1085:         loc_oOpt.Buttons(2).FontSize = 8
1086:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
1087:         loc_oOpt.Buttons(2).Themes = .F.
1088: 
1089:         *-- Possui Responsavel
1090:         par_oPg.AddObject("lbl_4c_LblRespos", "Label")
1091:         WITH par_oPg.lbl_4c_LblRespos
1092:             .Caption = "Possui Respons" + CHR(225) + "vel:"
1093:             .Top = 174
1094:             .Left = 63
1095:             .Width = 101
1096:             .Height = 17
1097:             .FontName = "Tahoma"
1098:             .FontSize = 8
1099:             .ForeColor = RGB(90,90,90)
1100:             .BackStyle = 0
1101:             .Alignment = 1
1102:             .Visible = .T.
1103:         ENDWITH
1104: 
1105:         par_oPg.AddObject("obj_4c_Opt_Respos", "OptionGroup")
1106:         loc_oOpt = par_oPg.obj_4c_Opt_Respos
1107:         WITH loc_oOpt
1108:             .ButtonCount = 2
1109:             .Top = 171
1110:             .Left = 165
1111:             .Width = 97
1112:             .Height = 23
1113:             .BackStyle = 0
1114:             .BorderStyle = 0
1115:             .Value = 1
1116:             .Visible = .T.
1117:         ENDWITH
1118:         loc_oOpt.Buttons(1).Caption = "Sim"
1119:         loc_oOpt.Buttons(1).Left = 5
1120:         loc_oOpt.Buttons(1).Top = 3
1121:         loc_oOpt.Buttons(1).Width = 40
1122:         loc_oOpt.Buttons(1).FontName = "Tahoma"
1123:         loc_oOpt.Buttons(1).FontSize = 8
1124:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
1125:         loc_oOpt.Buttons(1).Themes = .F.
1126:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
1127:         loc_oOpt.Buttons(2).Left = 48
1128:         loc_oOpt.Buttons(2).Top = 3
1129:         loc_oOpt.Buttons(2).Width = 44
1130:         loc_oOpt.Buttons(2).FontName = "Tahoma"
1131:         loc_oOpt.Buttons(2).FontSize = 8
1132:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
1133:         loc_oOpt.Buttons(2).Themes = .F.
1134: 
1135:         *-- Limite de Credito
1136:         par_oPg.AddObject("lbl_4c_LblLimcres", "Label")
1137:         WITH par_oPg.lbl_4c_LblLimcres
1138:             .Caption = "Limite de Cr" + CHR(233) + "dito:"
1139:             .Top = 199
1140:             .Left = 77
1141:             .Width = 87
1142:             .Height = 17
1143:             .FontName = "Tahoma"
1144:             .FontSize = 8
1145:             .ForeColor = RGB(90,90,90)
1146:             .BackStyle = 0
1147:             .Alignment = 1
1148:             .Visible = .T.
1149:         ENDWITH
1150: 
1151:         par_oPg.AddObject("obj_4c_Opt_LimCre", "OptionGroup")
1152:         loc_oOpt = par_oPg.obj_4c_Opt_LimCre
1153:         WITH loc_oOpt
1154:             .ButtonCount = 2
1155:             .Top = 196
1156:             .Left = 165
1157:             .Width = 97
1158:             .Height = 23
1159:             .BackStyle = 0
1160:             .BorderStyle = 0
1161:             .Value = 1
1162:             .Visible = .T.
1163:         ENDWITH
1164:         loc_oOpt.Buttons(1).Caption = "Sim"
1165:         loc_oOpt.Buttons(1).Left = 5
1166:         loc_oOpt.Buttons(1).Top = 3
1167:         loc_oOpt.Buttons(1).Width = 40
1168:         loc_oOpt.Buttons(1).FontName = "Tahoma"
1169:         loc_oOpt.Buttons(1).FontSize = 8
1170:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
1171:         loc_oOpt.Buttons(1).Themes = .F.
1172:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
1173:         loc_oOpt.Buttons(2).Left = 48
1174:         loc_oOpt.Buttons(2).Top = 3
1175:         loc_oOpt.Buttons(2).Width = 44
1176:         loc_oOpt.Buttons(2).FontName = "Tahoma"
1177:         loc_oOpt.Buttons(2).FontSize = 8
1178:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
1179:         loc_oOpt.Buttons(2).Themes = .F.
1180: 
1181:         *-- Comissao
1182:         par_oPg.AddObject("lbl_4c_LblComis", "Label")
1183:         WITH par_oPg.lbl_4c_LblComis
1184:             .Caption = "Comiss" + CHR(227) + "o:"
1185:             .Top = 225
1186:             .Left = 112
1187:             .Width = 52
1188:             .Height = 17
1189:             .FontName = "Tahoma"
1190:             .FontSize = 8
1191:             .ForeColor = RGB(90,90,90)
1192:             .BackStyle = 0
1193:             .Alignment = 1
1194:             .Visible = .T.
1195:         ENDWITH
1196: 
1197:         par_oPg.AddObject("obj_4c_Opt_Comi", "OptionGroup")
1198:         loc_oOpt = par_oPg.obj_4c_Opt_Comi
1199:         WITH loc_oOpt
1200:             .ButtonCount = 2
1201:             .Top = 222
1202:             .Left = 165
1203:             .Width = 97
1204:             .Height = 23
1205:             .BackStyle = 0
1206:             .BorderStyle = 0
1207:             .Value = 1
1208:             .Visible = .T.
1209:         ENDWITH
1210:         loc_oOpt.Buttons(1).Caption = "Sim"
1211:         loc_oOpt.Buttons(1).Left = 5
1212:         loc_oOpt.Buttons(1).Top = 3
1213:         loc_oOpt.Buttons(1).Width = 40
1214:         loc_oOpt.Buttons(1).FontName = "Tahoma"
1215:         loc_oOpt.Buttons(1).FontSize = 8
1216:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
1217:         loc_oOpt.Buttons(1).Themes = .F.
1218:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
1219:         loc_oOpt.Buttons(2).Left = 48
1220:         loc_oOpt.Buttons(2).Top = 3
1221:         loc_oOpt.Buttons(2).Width = 44
1222:         loc_oOpt.Buttons(2).FontName = "Tahoma"
1223:         loc_oOpt.Buttons(2).FontSize = 8
1224:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
1225:         loc_oOpt.Buttons(2).Themes = .F.
1226: 
1227:         *-- Coluna central: opcoes gerais (Left ~394-483)
1228:         *-- Dados da Empresa
1229:         par_oPg.AddObject("lbl_4c_LblEmpresas", "Label")
1230:         WITH par_oPg.lbl_4c_LblEmpresas
1231:             .Caption = "Dados da Empresa:"
1232:             .Top = 19
1233:             .Left = 386
1234:             .Width = 96
1235:             .Height = 17
1236:             .FontName = "Tahoma"
1237:             .FontSize = 8
1238:             .ForeColor = RGB(90,90,90)
1239:             .BackStyle = 0
1240:             .Alignment = 1
1241:             .Visible = .T.
1242:         ENDWITH
1243: 
1244:         par_oPg.AddObject("obj_4c_Opt_Empresa", "OptionGroup")
1245:         loc_oOpt = par_oPg.obj_4c_Opt_Empresa
1246:         WITH loc_oOpt
1247:             .ButtonCount = 2
1248:             .Top = 15
1249:             .Left = 483
1250:             .Width = 97
1251:             .Height = 23
1252:             .BackStyle = 0
1253:             .BorderStyle = 0
1254:             .Value = 1
1255:             .Visible = .T.
1256:         ENDWITH
1257:         loc_oOpt.Buttons(1).Caption = "Sim"
1258:         loc_oOpt.Buttons(1).Left = 5
1259:         loc_oOpt.Buttons(1).Top = 3
1260:         loc_oOpt.Buttons(1).Width = 40
1261:         loc_oOpt.Buttons(1).FontName = "Tahoma"
1262:         loc_oOpt.Buttons(1).FontSize = 8
1263:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
1264:         loc_oOpt.Buttons(1).Themes = .F.
1265:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
1266:         loc_oOpt.Buttons(2).Left = 48
1267:         loc_oOpt.Buttons(2).Top = 3
1268:         loc_oOpt.Buttons(2).Width = 44
1269:         loc_oOpt.Buttons(2).FontName = "Tahoma"
1270:         loc_oOpt.Buttons(2).FontSize = 8
1271:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
1272:         loc_oOpt.Buttons(2).Themes = .F.
1273: 
1274:         *-- Dados Contabeis
1275:         par_oPg.AddObject("lbl_4c_LblContabs", "Label")
1276:         WITH par_oPg.lbl_4c_LblContabs
1277:             .Caption = "Dados Cont" + CHR(225) + "beis:"
1278:             .Top = 45
1279:             .Left = 394
1280:             .Width = 88
1281:             .Height = 17
1282:             .FontName = "Tahoma"
1283:             .FontSize = 8
1284:             .ForeColor = RGB(90,90,90)
1285:             .BackStyle = 0
1286:             .Alignment = 1
1287:             .Visible = .T.
1288:         ENDWITH
1289: 
1290:         par_oPg.AddObject("obj_4c_Opt_Contabs", "OptionGroup")
1291:         loc_oOpt = par_oPg.obj_4c_Opt_Contabs
1292:         WITH loc_oOpt
1293:             .ButtonCount = 2
1294:             .Top = 41
1295:             .Left = 483
1296:             .Width = 97
1297:             .Height = 23
1298:             .BackStyle = 0
1299:             .BorderStyle = 0
1300:             .Value = 1
1301:             .Visible = .T.
1302:         ENDWITH
1303:         loc_oOpt.Buttons(1).Caption = "Sim"
1304:         loc_oOpt.Buttons(1).Left = 5
1305:         loc_oOpt.Buttons(1).Top = 3
1306:         loc_oOpt.Buttons(1).Width = 40
1307:         loc_oOpt.Buttons(1).FontName = "Tahoma"
1308:         loc_oOpt.Buttons(1).FontSize = 8
1309:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
1310:         loc_oOpt.Buttons(1).Themes = .F.
1311:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
1312:         loc_oOpt.Buttons(2).Left = 48
1313:         loc_oOpt.Buttons(2).Top = 3
1314:         loc_oOpt.Buttons(2).Width = 44
1315:         loc_oOpt.Buttons(2).FontName = "Tahoma"
1316:         loc_oOpt.Buttons(2).FontSize = 8
1317:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
1318:         loc_oOpt.Buttons(2).Themes = .F.
1319: 
1320:         *-- Caracteristicas
1321:         par_oPg.AddObject("lbl_4c_LblCaracteris", "Label")
1322:         WITH par_oPg.lbl_4c_LblCaracteris
1323:             .Caption = "Caracter" + CHR(237) + "sticas:"
1324:             .Top = 71
1325:             .Left = 404
1326:             .Width = 78
1327:             .Height = 17
1328:             .FontName = "Tahoma"
1329:             .FontSize = 8
1330:             .ForeColor = RGB(90,90,90)
1331:             .BackStyle = 0
1332:             .Alignment = 1
1333:             .Visible = .T.
1334:         ENDWITH
1335: 
1336:         par_oPg.AddObject("obj_4c_Opt_Caracteris", "OptionGroup")
1337:         loc_oOpt = par_oPg.obj_4c_Opt_Caracteris
1338:         WITH loc_oOpt
1339:             .ButtonCount = 2
1340:             .Top = 67
1341:             .Left = 483
1342:             .Width = 97
1343:             .Height = 23
1344:             .BackStyle = 0
1345:             .BorderStyle = 0
1346:             .Value = 1
1347:             .Visible = .T.
1348:         ENDWITH
1349:         loc_oOpt.Buttons(1).Caption = "Sim"
1350:         loc_oOpt.Buttons(1).Left = 5
1351:         loc_oOpt.Buttons(1).Top = 3
1352:         loc_oOpt.Buttons(1).Width = 40
1353:         loc_oOpt.Buttons(1).FontName = "Tahoma"
1354:         loc_oOpt.Buttons(1).FontSize = 8
1355:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
1356:         loc_oOpt.Buttons(1).Themes = .F.
1357:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
1358:         loc_oOpt.Buttons(2).Left = 48
1359:         loc_oOpt.Buttons(2).Top = 3
1360:         loc_oOpt.Buttons(2).Width = 44
1361:         loc_oOpt.Buttons(2).FontName = "Tahoma"
1362:         loc_oOpt.Buttons(2).FontSize = 8
1363:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
1364:         loc_oOpt.Buttons(2).Themes = .F.
1365: 
1366:         *-- Informacoes Cadastrais
1367:         par_oPg.AddObject("lbl_4c_LblInfcads", "Label")
1368:         WITH par_oPg.lbl_4c_LblInfcads
1369:             .Caption = "Informa" + CHR(231) + CHR(245) + "es Cadastrais:"
1370:             .Top = 98
1371:             .Left = 361
1372:             .Width = 121
1373:             .Height = 17
1374:             .FontName = "Tahoma"
1375:             .FontSize = 8
1376:             .ForeColor = RGB(90,90,90)
1377:             .BackStyle = 0
1378:             .Alignment = 1
1379:             .Visible = .T.
1380:         ENDWITH
1381: 
1382:         par_oPg.AddObject("obj_4c_Fwoption1", "OptionGroup")
1383:         loc_oOpt = par_oPg.obj_4c_Fwoption1
1384:         WITH loc_oOpt
1385:             .ButtonCount = 2
1386:             .Top = 94
1387:             .Left = 483
1388:             .Width = 97
1389:             .Height = 23
1390:             .BackStyle = 0
1391:             .BorderStyle = 0
1392:             .Value = 1
1393:             .Visible = .T.
1394:         ENDWITH
1395:         loc_oOpt.Buttons(1).Caption = "Sim"
1396:         loc_oOpt.Buttons(1).Left = 5
1397:         loc_oOpt.Buttons(1).Top = 3
1398:         loc_oOpt.Buttons(1).Width = 40
1399:         loc_oOpt.Buttons(1).FontName = "Tahoma"
1400:         loc_oOpt.Buttons(1).FontSize = 8
1401:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
1402:         loc_oOpt.Buttons(1).Themes = .F.
1403:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
1404:         loc_oOpt.Buttons(2).Left = 48
1405:         loc_oOpt.Buttons(2).Top = 3
1406:         loc_oOpt.Buttons(2).Width = 44
1407:         loc_oOpt.Buttons(2).FontName = "Tahoma"
1408:         loc_oOpt.Buttons(2).FontSize = 8
1409:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
1410:         loc_oOpt.Buttons(2).Themes = .F.
1411: 
1412:         *-- Perfil
1413:         par_oPg.AddObject("lbl_4c_LblPerfil", "Label")
1414:         WITH par_oPg.lbl_4c_LblPerfil
1415:             .Caption = "Perfil:"
1416:             .Top = 124
1417:             .Left = 451
1418:             .Width = 31
1419:             .Height = 17
1420:             .FontName = "Tahoma"
1421:             .FontSize = 8
1422:             .ForeColor = RGB(90,90,90)
1423:             .BackStyle = 0
1424:             .Alignment = 1
1425:             .Visible = .T.
1426:         ENDWITH
1427: 
1428:         par_oPg.AddObject("obj_4c_Fwoption2", "OptionGroup")
1429:         loc_oOpt = par_oPg.obj_4c_Fwoption2
1430:         WITH loc_oOpt
1431:             .ButtonCount = 2
1432:             .Top = 120
1433:             .Left = 483
1434:             .Width = 97
1435:             .Height = 23
1436:             .BackStyle = 0
1437:             .BorderStyle = 0
1438:             .Value = 1
1439:             .Visible = .T.
1440:         ENDWITH
1441:         loc_oOpt.Buttons(1).Caption = "Sim"
1442:         loc_oOpt.Buttons(1).Left = 5
1443:         loc_oOpt.Buttons(1).Top = 3
1444:         loc_oOpt.Buttons(1).Width = 40
1445:         loc_oOpt.Buttons(1).FontName = "Tahoma"
1446:         loc_oOpt.Buttons(1).FontSize = 8
1447:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
1448:         loc_oOpt.Buttons(1).Themes = .F.
1449:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
1450:         loc_oOpt.Buttons(2).Left = 48
1451:         loc_oOpt.Buttons(2).Top = 3
1452:         loc_oOpt.Buttons(2).Width = 44
1453:         loc_oOpt.Buttons(2).FontName = "Tahoma"
1454:         loc_oOpt.Buttons(2).FontSize = 8
1455:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
1456:         loc_oOpt.Buttons(2).Themes = .F.
1457: 
1458:         *-- Cargos
1459:         par_oPg.AddObject("lbl_4c_LblCargos", "Label")
1460:         WITH par_oPg.lbl_4c_LblCargos
1461:             .Caption = "Cargos:"
1462:             .Top = 149
1463:             .Left = 441
1464:             .Width = 41
1465:             .Height = 17
1466:             .FontName = "Tahoma"
1467:             .FontSize = 8
1468:             .ForeColor = RGB(90,90,90)
1469:             .BackStyle = 0
1470:             .Alignment = 1
1471:             .Visible = .T.
1472:         ENDWITH
1473: 
1474:         par_oPg.AddObject("obj_4c_Opt_Cargo", "OptionGroup")
1475:         loc_oOpt = par_oPg.obj_4c_Opt_Cargo
1476:         WITH loc_oOpt
1477:             .ButtonCount = 2
1478:             .Top = 145
1479:             .Left = 483
1480:             .Width = 97
1481:             .Height = 23
1482:             .BackStyle = 0
1483:             .BorderStyle = 0
1484:             .Value = 1
1485:             .Visible = .T.
1486:         ENDWITH
1487:         loc_oOpt.Buttons(1).Caption = "Sim"
1488:         loc_oOpt.Buttons(1).Left = 5
1489:         loc_oOpt.Buttons(1).Top = 3
1490:         loc_oOpt.Buttons(1).Width = 40
1491:         loc_oOpt.Buttons(1).FontName = "Tahoma"
1492:         loc_oOpt.Buttons(1).FontSize = 8
1493:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
1494:         loc_oOpt.Buttons(1).Themes = .F.
1495:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
1496:         loc_oOpt.Buttons(2).Left = 48
1497:         loc_oOpt.Buttons(2).Top = 3
1498:         loc_oOpt.Buttons(2).Width = 44
1499:         loc_oOpt.Buttons(2).FontName = "Tahoma"
1500:         loc_oOpt.Buttons(2).FontSize = 8
1501:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
1502:         loc_oOpt.Buttons(2).Themes = .F.
1503: 
1504:         *-- Checa Limite de Credito
1505:         par_oPg.AddObject("lbl_4c_LblChkLimCr", "Label")
1506:         WITH par_oPg.lbl_4c_LblChkLimCr
1507:             .Caption = "Checa Limite Cr" + CHR(233) + "dito:"
1508:             .Top = 175
1509:             .Left = 377
1510:             .Width = 105
1511:             .Height = 17
1512:             .FontName = "Tahoma"
1513:             .FontSize = 8
1514:             .ForeColor = RGB(90,90,90)
1515:             .BackStyle = 0
1516:             .Alignment = 1
1517:             .Visible = .T.
1518:         ENDWITH
1519: 
1520:         par_oPg.AddObject("obj_4c_Opt_ChkLimCr", "OptionGroup")
1521:         loc_oOpt = par_oPg.obj_4c_Opt_ChkLimCr
1522:         WITH loc_oOpt
1523:             .ButtonCount = 2
1524:             .Top = 171
1525:             .Left = 483
1526:             .Width = 97
1527:             .Height = 23
1528:             .BackStyle = 0
1529:             .BorderStyle = 0
1530:             .Value = 1
1531:             .Visible = .T.
1532:         ENDWITH
1533:         loc_oOpt.Buttons(1).Caption = "Sim"
1534:         loc_oOpt.Buttons(1).Left = 5
1535:         loc_oOpt.Buttons(1).Top = 3
1536:         loc_oOpt.Buttons(1).Width = 40
1537:         loc_oOpt.Buttons(1).FontName = "Tahoma"
1538:         loc_oOpt.Buttons(1).FontSize = 8
1539:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
1540:         loc_oOpt.Buttons(1).Themes = .F.
1541:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
1542:         loc_oOpt.Buttons(2).Left = 48
1543:         loc_oOpt.Buttons(2).Top = 3
1544:         loc_oOpt.Buttons(2).Width = 44
1545:         loc_oOpt.Buttons(2).FontName = "Tahoma"
1546:         loc_oOpt.Buttons(2).FontSize = 8
1547:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
1548:         loc_oOpt.Buttons(2).Themes = .F.
1549: 
1550:         *-- Lim.Credito Grupo Valor Moeda
1551:         par_oPg.AddObject("lbl_4c_LblLimVrMoe", "Label")
1552:         WITH par_oPg.lbl_4c_LblLimVrMoe
1553:             .Caption = "Lim.Cr" + CHR(233) + "dito Grupo/Vr/Moeda:"
1554:             .Top = 200
1555:             .Left = 339
1556:             .Width = 143
1557:             .Height = 17
1558:             .FontName = "Tahoma"
1559:             .FontSize = 8
1560:             .ForeColor = RGB(90,90,90)

*-- Linhas 1646 a 1748:
1646:             .Visible = .T.
1647:         ENDWITH
1648: 
1649:         BINDEVENT(par_oPg.txt_4c__cd_moeda, "KeyPress",  THIS, "MoedaComissaoKeyPress")
1650:         BINDEVENT(par_oPg.txt_4c__cd_moeda, "DblClick",  THIS, "MoedaComissaoDblClick")
1651:         BINDEVENT(par_oPg.txt_4c__cd_moeda, "KeyPress", THIS, "MoedaComissaoLostFocus")
1652:         BINDEVENT(par_oPg.txt_4c__molimc,   "KeyPress",  THIS, "MoedaLimiteKeyPress")
1653:         BINDEVENT(par_oPg.txt_4c__molimc,   "DblClick",  THIS, "MoedaLimiteDblClick")
1654:         BINDEVENT(par_oPg.txt_4c__molimc,   "KeyPress", THIS, "MoedaLimiteLostFocus")
1655: 
1656:         *-- Grupo Padrao Contabil
1657:         par_oPg.AddObject("lbl_4c_LblGrupolms", "Label")
1658:         WITH par_oPg.lbl_4c_LblGrupolms
1659:             .Caption = "Grupo Padr" + CHR(227) + "o:"
1660:             .Top = 19
1661:             .Left = 678
1662:             .Width = 80
1663:             .Height = 17
1664:             .FontName = "Tahoma"
1665:             .FontSize = 8
1666:             .ForeColor = RGB(90,90,90)
1667:             .BackStyle = 0
1668:             .Alignment = 1
1669:             .Visible = .T.
1670:         ENDWITH
1671: 
1672:         par_oPg.AddObject("txt_4c_Grupo", "TextBox")
1673:         WITH par_oPg.txt_4c_Grupo
1674:             .Value = ""
1675:             .Top = 17
1676:             .Left = 760
1677:             .Width = 120
1678:             .Height = 23
1679:             .MaxLength = 10
1680:             .FontName = "Tahoma"
1681:             .FontSize = 8
1682:             .ForeColor = RGB(90,90,90)
1683:             .BackColor = RGB(255,255,255)
1684:             .Themes = .F.
1685:             .SpecialEffect = 0
1686:             .Visible = .T.
1687:         ENDWITH
1688: 
1689:         BINDEVENT(par_oPg.txt_4c_Grupo, "KeyPress", THIS, "GrupoContabKeyPress")
1690:         BINDEVENT(par_oPg.txt_4c_Grupo, "DblClick", THIS, "GrupoContabDblClick")
1691: 
1692:         *-- Coletor (11 opcoes) - OptionGroup vertical
1693:         par_oPg.AddObject("lbl_4c_LblColetor", "Label")
1694:         WITH par_oPg.lbl_4c_LblColetor
1695:             .Caption = "Coletor:"
1696:             .Top = 8
1697:             .Left = 700
1698:             .Width = 50
1699:             .Height = 17
1700:             .FontName = "Tahoma"
1701:             .FontSize = 8
1702:             .ForeColor = RGB(90,90,90)
1703:             .BackStyle = 0
1704:             .Alignment = 1
1705:             .Visible = .T.
1706:         ENDWITH
1707: 
1708:         par_oPg.AddObject("obj_4c_Opt_Coletor", "OptionGroup")
1709:         loc_oOpt = par_oPg.obj_4c_Opt_Coletor
1710:         WITH loc_oOpt
1711:             .ButtonCount = 11
1712:             .Top = 12
1713:             .Left = 750
1714:             .Width = 141
1715:             .Height = 210
1716:             .BackStyle = 0
1717:             .BorderStyle = 0
1718:             .Value = 1
1719:             .Visible = .T.
1720:         ENDWITH
1721: 
1722:         LOCAL loc_nI, loc_nTop
1723:         FOR loc_nI = 1 TO 11
1724:             loc_nTop = (loc_nI - 1) * 18 + 5
1725:             loc_oOpt.Buttons(loc_nI).Caption   = STR(loc_nI, 2)
1726:             loc_oOpt.Buttons(loc_nI).Left      = 5
1727:             loc_oOpt.Buttons(loc_nI).Top       = loc_nTop
1728:             loc_oOpt.Buttons(loc_nI).Width     = 130
1729:             loc_oOpt.Buttons(loc_nI).FontName  = "Tahoma"
1730:             loc_oOpt.Buttons(loc_nI).FontSize  = 8
1731:             loc_oOpt.Buttons(loc_nI).ForeColor = RGB(90, 90, 90)
1732:             loc_oOpt.Buttons(loc_nI).Themes    = .F.
1733:         ENDFOR
1734:         loc_oOpt.Buttons(1).Caption  = "N" + CHR(227) + "o"
1735:         loc_oOpt.Buttons(2).Caption  = "Coletor 1"
1736:         loc_oOpt.Buttons(3).Caption  = "Coletor 2"
1737:         loc_oOpt.Buttons(4).Caption  = "Coletor 3"
1738:         loc_oOpt.Buttons(5).Caption  = "Coletor 4"
1739:         loc_oOpt.Buttons(6).Caption  = "Coletor 5"
1740:         loc_oOpt.Buttons(7).Caption  = "Coletor 6"
1741:         loc_oOpt.Buttons(8).Caption  = "Coletor 7"
1742:         loc_oOpt.Buttons(9).Caption  = "Coletor 8"
1743:         loc_oOpt.Buttons(10).Caption = "Coletor 9"
1744:         loc_oOpt.Buttons(11).Caption = "Coletor 10"
1745: 
1746:         *-- LEAD / Pre-Cadastro
1747:         par_oPg.AddObject("lbl_4c_LblPreCad", "Label")
1748:         WITH par_oPg.lbl_4c_LblPreCad

*-- Linhas 1759 a 1802:
1759:             .Visible = .T.
1760:         ENDWITH
1761: 
1762:         par_oPg.AddObject("obj_4c_OptPreCad", "OptionGroup")
1763:         loc_oOpt = par_oPg.obj_4c_OptPreCad
1764:         WITH loc_oOpt
1765:             .ButtonCount = 2
1766:             .Top = 217
1767:             .Left = 751
1768:             .Width = 97
1769:             .Height = 23
1770:             .BackStyle = 0
1771:             .BorderStyle = 0
1772:             .Value = 1
1773:             .Visible = .T.
1774:         ENDWITH
1775:         loc_oOpt.Buttons(1).Caption = "Sim"
1776:         loc_oOpt.Buttons(1).Left = 5
1777:         loc_oOpt.Buttons(1).Top = 3
1778:         loc_oOpt.Buttons(1).Width = 40
1779:         loc_oOpt.Buttons(1).FontName = "Tahoma"
1780:         loc_oOpt.Buttons(1).FontSize = 8
1781:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
1782:         loc_oOpt.Buttons(1).Themes = .F.
1783:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
1784:         loc_oOpt.Buttons(2).Left = 48
1785:         loc_oOpt.Buttons(2).Top = 3
1786:         loc_oOpt.Buttons(2).Width = 44
1787:         loc_oOpt.Buttons(2).FontName = "Tahoma"
1788:         loc_oOpt.Buttons(2).FontSize = 8
1789:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
1790:         loc_oOpt.Buttons(2).Themes = .F.
1791: 
1792:         *-- Linha separadora
1793:         par_oPg.AddObject("lin_4c_Line1", "Line")
1794:         WITH par_oPg.lin_4c_Line1
1795:             .Top = 253
1796:             .Left = 17
1797:             .Width = 959
1798:             .Height = 1
1799:             .BorderColor = RGB(150,150,150)
1800:             .Visible = .T.
1801:         ENDWITH
1802: 

*-- Linhas 1836 a 1879:
1836:     *--------------------------------------------------------------------------
1837:     * CriarAbaCadastro - Controles da aba Cadastro (pgf_4c_1.Page2)
1838:     *--------------------------------------------------------------------------
1839:     PROTECTED PROCEDURE CriarAbaCadastro(par_oPg)
1840:         LOCAL loc_oOpt
1841: 
1842:         *-- Linhas separadoras
1843:         par_oPg.AddObject("lin_4c_Cad1", "Line")
1844:         WITH par_oPg.lin_4c_Cad1
1845:             .Top = 341
1846:             .Left = 17
1847:             .Width = 959
1848:             .Height = 1
1849:             .BorderColor = RGB(150,150,150)
1850:             .Visible = .T.
1851:         ENDWITH
1852: 
1853:         par_oPg.AddObject("lin_4c_Cad2", "Line")
1854:         WITH par_oPg.lin_4c_Cad2
1855:             .Top = 29
1856:             .Left = 344
1857:             .Width = 1
1858:             .Height = 312
1859:             .BorderColor = RGB(150,150,150)
1860:             .Visible = .T.
1861:         ENDWITH
1862: 
1863:         par_oPg.AddObject("lin_4c_Cad3", "Line")
1864:         WITH par_oPg.lin_4c_Cad3
1865:             .Top = 29
1866:             .Left = 583
1867:             .Width = 1
1868:             .Height = 312
1869:             .BorderColor = RGB(150,150,150)
1870:             .Visible = .T.
1871:         ENDWITH
1872: 
1873:         *-- Col 1: CPF/CNPJ Obrigatorio (3 btn)
1874:         par_oPg.AddObject("lbl_4c_LblCpfObrig", "Label")
1875:         WITH par_oPg.lbl_4c_LblCpfObrig
1876:             .Caption = "CPF/CNPJ Obrig.:"
1877:             .Top = 34
1878:             .Left = 17
1879:             .Width = 141

*-- Linhas 1886 a 1929:
1886:             .Visible = .T.
1887:         ENDWITH
1888: 
1889:         par_oPg.AddObject("Opt_CPFObrig", "OptionGroup")
1890:         loc_oOpt = par_oPg.Opt_CPFObrig
1891:         WITH loc_oOpt
1892:             .ButtonCount = 3
1893:             .Top = 34
1894:             .Left = 160
1895:             .Width = 201
1896:             .Height = 23
1897:             .BackStyle = 0
1898:             .BorderStyle = 0
1899:             .Value = 1
1900:             .Visible = .T.
1901:         ENDWITH
1902:         loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
1903:         loc_oOpt.Buttons(1).Left = 5
1904:         loc_oOpt.Buttons(1).Top = 3
1905:         loc_oOpt.Buttons(1).Width = 44
1906:         loc_oOpt.Buttons(1).FontName = "Tahoma"
1907:         loc_oOpt.Buttons(1).FontSize = 8
1908:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
1909:         loc_oOpt.Buttons(1).Themes = .F.
1910:         loc_oOpt.Buttons(2).Caption = "Opcional"
1911:         loc_oOpt.Buttons(2).Left = 55
1912:         loc_oOpt.Buttons(2).Top = 3
1913:         loc_oOpt.Buttons(2).Width = 65
1914:         loc_oOpt.Buttons(2).FontName = "Tahoma"
1915:         loc_oOpt.Buttons(2).FontSize = 8
1916:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
1917:         loc_oOpt.Buttons(2).Themes = .F.
1918:         loc_oOpt.Buttons(3).Caption = "Obrigat" + CHR(243) + "rio"
1919:         loc_oOpt.Buttons(3).Left = 125
1920:         loc_oOpt.Buttons(3).Top = 3
1921:         loc_oOpt.Buttons(3).Width = 70
1922:         loc_oOpt.Buttons(3).FontName = "Tahoma"
1923:         loc_oOpt.Buttons(3).FontSize = 8
1924:         loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
1925:         loc_oOpt.Buttons(3).Themes = .F.
1926: 
1927:         *-- Calc Imediato
1928:         par_oPg.AddObject("lbl_4c_LblCalcImeds", "Label")
1929:         WITH par_oPg.lbl_4c_LblCalcImeds

*-- Linhas 1940 a 2812:
1940:             .Visible = .T.
1941:         ENDWITH
1942: 
1943:         par_oPg.AddObject("fwoption2", "OptionGroup")
1944:         loc_oOpt = par_oPg.fwoption2
1945:         WITH loc_oOpt
1946:             .ButtonCount = 2
1947:             .Top = 54
1948:             .Left = 160
1949:             .Width = 115
1950:             .Height = 23
1951:             .BackStyle = 0
1952:             .BorderStyle = 0
1953:             .Value = 1
1954:             .Visible = .T.
1955:         ENDWITH
1956:         loc_oOpt.Buttons(1).Caption = "Sim"
1957:         loc_oOpt.Buttons(1).Left = 5
1958:         loc_oOpt.Buttons(1).Top = 3
1959:         loc_oOpt.Buttons(1).Width = 40
1960:         loc_oOpt.Buttons(1).FontName = "Tahoma"
1961:         loc_oOpt.Buttons(1).FontSize = 8
1962:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
1963:         loc_oOpt.Buttons(1).Themes = .F.
1964:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
1965:         loc_oOpt.Buttons(2).Left = 48
1966:         loc_oOpt.Buttons(2).Top = 3
1967:         loc_oOpt.Buttons(2).Width = 44
1968:         loc_oOpt.Buttons(2).FontName = "Tahoma"
1969:         loc_oOpt.Buttons(2).FontSize = 8
1970:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
1971:         loc_oOpt.Buttons(2).Themes = .F.
1972: 
1973:         *-- Calcimeds (optCalcIMeds)
1974:         par_oPg.AddObject("lbl_4c_LblCalcIMed2", "Label")
1975:         WITH par_oPg.lbl_4c_LblCalcIMed2
1976:             .Caption = "Calc.Imeds2:"
1977:             .Top = 73
1978:             .Left = 17
1979:             .Width = 141
1980:             .Height = 17
1981:             .FontName = "Tahoma"
1982:             .FontSize = 8
1983:             .ForeColor = RGB(90,90,90)
1984:             .BackStyle = 0
1985:             .Alignment = 1
1986:             .Visible = .T.
1987:         ENDWITH
1988: 
1989:         par_oPg.AddObject("optCalcIMeds", "OptionGroup")
1990:         loc_oOpt = par_oPg.optCalcIMeds
1991:         WITH loc_oOpt
1992:             .ButtonCount = 2
1993:             .Top = 73
1994:             .Left = 160
1995:             .Width = 97
1996:             .Height = 25
1997:             .BackStyle = 0
1998:             .BorderStyle = 0
1999:             .Value = 1
2000:             .Visible = .T.
2001:         ENDWITH
2002:         loc_oOpt.Buttons(1).Caption = "Sim"
2003:         loc_oOpt.Buttons(1).Left = 5
2004:         loc_oOpt.Buttons(1).Top = 3
2005:         loc_oOpt.Buttons(1).Width = 40
2006:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2007:         loc_oOpt.Buttons(1).FontSize = 8
2008:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2009:         loc_oOpt.Buttons(1).Themes = .F.
2010:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2011:         loc_oOpt.Buttons(2).Left = 48
2012:         loc_oOpt.Buttons(2).Top = 3
2013:         loc_oOpt.Buttons(2).Width = 44
2014:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2015:         loc_oOpt.Buttons(2).FontSize = 8
2016:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2017:         loc_oOpt.Buttons(2).Themes = .F.
2018: 
2019:         *-- ObrMails
2020:         par_oPg.AddObject("lbl_4c_LblObrMails", "Label")
2021:         WITH par_oPg.lbl_4c_LblObrMails
2022:             .Caption = "E-mail Obrig.:"
2023:             .Top = 96
2024:             .Left = 17
2025:             .Width = 141
2026:             .Height = 17
2027:             .FontName = "Tahoma"
2028:             .FontSize = 8
2029:             .ForeColor = RGB(90,90,90)
2030:             .BackStyle = 0
2031:             .Alignment = 1
2032:             .Visible = .T.
2033:         ENDWITH
2034: 
2035:         par_oPg.AddObject("getObrMails", "OptionGroup")
2036:         loc_oOpt = par_oPg.getObrMails
2037:         WITH loc_oOpt
2038:             .ButtonCount = 2
2039:             .Top = 96
2040:             .Left = 160
2041:             .Width = 97
2042:             .Height = 25
2043:             .BackStyle = 0
2044:             .BorderStyle = 0
2045:             .Value = 1
2046:             .Visible = .T.
2047:         ENDWITH
2048:         loc_oOpt.Buttons(1).Caption = "Sim"
2049:         loc_oOpt.Buttons(1).Left = 5
2050:         loc_oOpt.Buttons(1).Top = 3
2051:         loc_oOpt.Buttons(1).Width = 40
2052:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2053:         loc_oOpt.Buttons(1).FontSize = 8
2054:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2055:         loc_oOpt.Buttons(1).Themes = .F.
2056:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2057:         loc_oOpt.Buttons(2).Left = 48
2058:         loc_oOpt.Buttons(2).Top = 3
2059:         loc_oOpt.Buttons(2).Width = 44
2060:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2061:         loc_oOpt.Buttons(2).FontSize = 8
2062:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2063:         loc_oOpt.Buttons(2).Themes = .F.
2064: 
2065:         *-- ObrNome
2066:         par_oPg.AddObject("lbl_4c_LblObrNome", "Label")
2067:         WITH par_oPg.lbl_4c_LblObrNome
2068:             .Caption = "Nome Obrig.:"
2069:             .Top = 117
2070:             .Left = 17
2071:             .Width = 141
2072:             .Height = 17
2073:             .FontName = "Tahoma"
2074:             .FontSize = 8
2075:             .ForeColor = RGB(90,90,90)
2076:             .BackStyle = 0
2077:             .Alignment = 1
2078:             .Visible = .T.
2079:         ENDWITH
2080: 
2081:         par_oPg.AddObject("getObrNome", "OptionGroup")
2082:         loc_oOpt = par_oPg.getObrNome
2083:         WITH loc_oOpt
2084:             .ButtonCount = 2
2085:             .Top = 117
2086:             .Left = 160
2087:             .Width = 97
2088:             .Height = 25
2089:             .BackStyle = 0
2090:             .BorderStyle = 0
2091:             .Value = 1
2092:             .Visible = .T.
2093:         ENDWITH
2094:         loc_oOpt.Buttons(1).Caption = "Sim"
2095:         loc_oOpt.Buttons(1).Left = 5
2096:         loc_oOpt.Buttons(1).Top = 3
2097:         loc_oOpt.Buttons(1).Width = 40
2098:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2099:         loc_oOpt.Buttons(1).FontSize = 8
2100:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2101:         loc_oOpt.Buttons(1).Themes = .F.
2102:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2103:         loc_oOpt.Buttons(2).Left = 48
2104:         loc_oOpt.Buttons(2).Top = 3
2105:         loc_oOpt.Buttons(2).Width = 44
2106:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2107:         loc_oOpt.Buttons(2).FontSize = 8
2108:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2109:         loc_oOpt.Buttons(2).Themes = .F.
2110: 
2111:         *-- RazSoc Obrig (Fwoption15)
2112:         par_oPg.AddObject("lbl_4c_LblRazSocObr", "Label")
2113:         WITH par_oPg.lbl_4c_LblRazSocObr
2114:             .Caption = "Raz" + CHR(227) + "o Social Obrig.:"
2115:             .Top = 136
2116:             .Left = 17
2117:             .Width = 141
2118:             .Height = 17
2119:             .FontName = "Tahoma"
2120:             .FontSize = 8
2121:             .ForeColor = RGB(90,90,90)
2122:             .BackStyle = 0
2123:             .Alignment = 1
2124:             .Visible = .T.
2125:         ENDWITH
2126: 
2127:         par_oPg.AddObject("Fwoption15", "OptionGroup")
2128:         loc_oOpt = par_oPg.Fwoption15
2129:         WITH loc_oOpt
2130:             .ButtonCount = 2
2131:             .Top = 136
2132:             .Left = 160
2133:             .Width = 97
2134:             .Height = 25
2135:             .BackStyle = 0
2136:             .BorderStyle = 0
2137:             .Value = 1
2138:             .Visible = .T.
2139:         ENDWITH
2140:         loc_oOpt.Buttons(1).Caption = "Sim"
2141:         loc_oOpt.Buttons(1).Left = 5
2142:         loc_oOpt.Buttons(1).Top = 3
2143:         loc_oOpt.Buttons(1).Width = 40
2144:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2145:         loc_oOpt.Buttons(1).FontSize = 8
2146:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2147:         loc_oOpt.Buttons(1).Themes = .F.
2148:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2149:         loc_oOpt.Buttons(2).Left = 48
2150:         loc_oOpt.Buttons(2).Top = 3
2151:         loc_oOpt.Buttons(2).Width = 44
2152:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2153:         loc_oOpt.Buttons(2).FontSize = 8
2154:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2155:         loc_oOpt.Buttons(2).Themes = .F.
2156: 
2157:         *-- ObrSit
2158:         par_oPg.AddObject("lbl_4c_LblObrSit", "Label")
2159:         WITH par_oPg.lbl_4c_LblObrSit
2160:             .Caption = "Situa" + CHR(231) + CHR(227) + "o Obrig.:"
2161:             .Top = 157
2162:             .Left = 17
2163:             .Width = 141
2164:             .Height = 17
2165:             .FontName = "Tahoma"
2166:             .FontSize = 8
2167:             .ForeColor = RGB(90,90,90)
2168:             .BackStyle = 0
2169:             .Alignment = 1
2170:             .Visible = .T.
2171:         ENDWITH
2172: 
2173:         par_oPg.AddObject("getObrSit", "OptionGroup")
2174:         loc_oOpt = par_oPg.getObrSit
2175:         WITH loc_oOpt
2176:             .ButtonCount = 2
2177:             .Top = 157
2178:             .Left = 160
2179:             .Width = 97
2180:             .Height = 25
2181:             .BackStyle = 0
2182:             .BorderStyle = 0
2183:             .Value = 1
2184:             .Visible = .T.
2185:         ENDWITH
2186:         loc_oOpt.Buttons(1).Caption = "Sim"
2187:         loc_oOpt.Buttons(1).Left = 5
2188:         loc_oOpt.Buttons(1).Top = 3
2189:         loc_oOpt.Buttons(1).Width = 40
2190:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2191:         loc_oOpt.Buttons(1).FontSize = 8
2192:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2193:         loc_oOpt.Buttons(1).Themes = .F.
2194:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2195:         loc_oOpt.Buttons(2).Left = 48
2196:         loc_oOpt.Buttons(2).Top = 3
2197:         loc_oOpt.Buttons(2).Width = 44
2198:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2199:         loc_oOpt.Buttons(2).FontSize = 8
2200:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2201:         loc_oOpt.Buttons(2).Themes = .F.
2202: 
2203:         *-- ObrTlm (Telemarketing)
2204:         par_oPg.AddObject("lbl_4c_LblObrTlm", "Label")
2205:         WITH par_oPg.lbl_4c_LblObrTlm
2206:             .Caption = "Telemarketing Obrig.:"
2207:             .Top = 179
2208:             .Left = 17
2209:             .Width = 141
2210:             .Height = 17
2211:             .FontName = "Tahoma"
2212:             .FontSize = 8
2213:             .ForeColor = RGB(90,90,90)
2214:             .BackStyle = 0
2215:             .Alignment = 1
2216:             .Visible = .T.
2217:         ENDWITH
2218: 
2219:         par_oPg.AddObject("getObrTlm", "OptionGroup")
2220:         loc_oOpt = par_oPg.getObrTlm
2221:         WITH loc_oOpt
2222:             .ButtonCount = 2
2223:             .Top = 179
2224:             .Left = 160
2225:             .Width = 97
2226:             .Height = 25
2227:             .BackStyle = 0
2228:             .BorderStyle = 0
2229:             .Value = 1
2230:             .Visible = .T.
2231:         ENDWITH
2232:         loc_oOpt.Buttons(1).Caption = "Sim"
2233:         loc_oOpt.Buttons(1).Left = 5
2234:         loc_oOpt.Buttons(1).Top = 3
2235:         loc_oOpt.Buttons(1).Width = 40
2236:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2237:         loc_oOpt.Buttons(1).FontSize = 8
2238:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2239:         loc_oOpt.Buttons(1).Themes = .F.
2240:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2241:         loc_oOpt.Buttons(2).Left = 48
2242:         loc_oOpt.Buttons(2).Top = 3
2243:         loc_oOpt.Buttons(2).Width = 44
2244:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2245:         loc_oOpt.Buttons(2).FontSize = 8
2246:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2247:         loc_oOpt.Buttons(2).Themes = .F.
2248: 
2249:         *-- ObrCla (Classificacao)
2250:         par_oPg.AddObject("lbl_4c_LblObrCla", "Label")
2251:         WITH par_oPg.lbl_4c_LblObrCla
2252:             .Caption = "Classifica" + CHR(231) + CHR(227) + "o Obrig.:"
2253:             .Top = 201
2254:             .Left = 17
2255:             .Width = 141
2256:             .Height = 17
2257:             .FontName = "Tahoma"
2258:             .FontSize = 8
2259:             .ForeColor = RGB(90,90,90)
2260:             .BackStyle = 0
2261:             .Alignment = 1
2262:             .Visible = .T.
2263:         ENDWITH
2264: 
2265:         par_oPg.AddObject("getObrCla", "OptionGroup")
2266:         loc_oOpt = par_oPg.getObrCla
2267:         WITH loc_oOpt
2268:             .ButtonCount = 2
2269:             .Top = 201
2270:             .Left = 160
2271:             .Width = 97
2272:             .Height = 25
2273:             .BackStyle = 0
2274:             .BorderStyle = 0
2275:             .Value = 1
2276:             .Visible = .T.
2277:         ENDWITH
2278:         loc_oOpt.Buttons(1).Caption = "Sim"
2279:         loc_oOpt.Buttons(1).Left = 5
2280:         loc_oOpt.Buttons(1).Top = 3
2281:         loc_oOpt.Buttons(1).Width = 40
2282:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2283:         loc_oOpt.Buttons(1).FontSize = 8
2284:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2285:         loc_oOpt.Buttons(1).Themes = .F.
2286:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2287:         loc_oOpt.Buttons(2).Left = 48
2288:         loc_oOpt.Buttons(2).Top = 3
2289:         loc_oOpt.Buttons(2).Width = 44
2290:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2291:         loc_oOpt.Buttons(2).FontSize = 8
2292:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2293:         loc_oOpt.Buttons(2).Themes = .F.
2294: 
2295:         *-- ObrSeg (Segmento)
2296:         par_oPg.AddObject("lbl_4c_LblObrSeg", "Label")
2297:         WITH par_oPg.lbl_4c_LblObrSeg
2298:             .Caption = "Segmento Obrig.:"
2299:             .Top = 222
2300:             .Left = 17
2301:             .Width = 141
2302:             .Height = 17
2303:             .FontName = "Tahoma"
2304:             .FontSize = 8
2305:             .ForeColor = RGB(90,90,90)
2306:             .BackStyle = 0
2307:             .Alignment = 1
2308:             .Visible = .T.
2309:         ENDWITH
2310: 
2311:         par_oPg.AddObject("getObrSeg", "OptionGroup")
2312:         loc_oOpt = par_oPg.getObrSeg
2313:         WITH loc_oOpt
2314:             .ButtonCount = 2
2315:             .Top = 222
2316:             .Left = 160
2317:             .Width = 97
2318:             .Height = 25
2319:             .BackStyle = 0
2320:             .BorderStyle = 0
2321:             .Value = 1
2322:             .Visible = .T.
2323:         ENDWITH
2324:         loc_oOpt.Buttons(1).Caption = "Sim"
2325:         loc_oOpt.Buttons(1).Left = 5
2326:         loc_oOpt.Buttons(1).Top = 3
2327:         loc_oOpt.Buttons(1).Width = 40
2328:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2329:         loc_oOpt.Buttons(1).FontSize = 8
2330:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2331:         loc_oOpt.Buttons(1).Themes = .F.
2332:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2333:         loc_oOpt.Buttons(2).Left = 48
2334:         loc_oOpt.Buttons(2).Top = 3
2335:         loc_oOpt.Buttons(2).Width = 44
2336:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2337:         loc_oOpt.Buttons(2).FontSize = 8
2338:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2339:         loc_oOpt.Buttons(2).Themes = .F.
2340: 
2341:         *-- Nascimento Obrig (Fwoption6)
2342:         par_oPg.AddObject("lbl_4c_LblNascObr", "Label")
2343:         WITH par_oPg.lbl_4c_LblNascObr
2344:             .Caption = "Nascimento Obrig.:"
2345:             .Top = 241
2346:             .Left = 17
2347:             .Width = 141
2348:             .Height = 17
2349:             .FontName = "Tahoma"
2350:             .FontSize = 8
2351:             .ForeColor = RGB(90,90,90)
2352:             .BackStyle = 0
2353:             .Alignment = 1
2354:             .Visible = .T.
2355:         ENDWITH
2356: 
2357:         par_oPg.AddObject("Fwoption6", "OptionGroup")
2358:         loc_oOpt = par_oPg.Fwoption6
2359:         WITH loc_oOpt
2360:             .ButtonCount = 2
2361:             .Top = 241
2362:             .Left = 160
2363:             .Width = 97
2364:             .Height = 25
2365:             .BackStyle = 0
2366:             .BorderStyle = 0
2367:             .Value = 1
2368:             .Visible = .T.
2369:         ENDWITH
2370:         loc_oOpt.Buttons(1).Caption = "Sim"
2371:         loc_oOpt.Buttons(1).Left = 5
2372:         loc_oOpt.Buttons(1).Top = 3
2373:         loc_oOpt.Buttons(1).Width = 40
2374:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2375:         loc_oOpt.Buttons(1).FontSize = 8
2376:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2377:         loc_oOpt.Buttons(1).Themes = .F.
2378:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2379:         loc_oOpt.Buttons(2).Left = 48
2380:         loc_oOpt.Buttons(2).Top = 3
2381:         loc_oOpt.Buttons(2).Width = 44
2382:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2383:         loc_oOpt.Buttons(2).FontSize = 8
2384:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2385:         loc_oOpt.Buttons(2).Themes = .F.
2386: 
2387:         *-- Sexo Obrig (Fwoption7)
2388:         par_oPg.AddObject("lbl_4c_LblSexoObr", "Label")
2389:         WITH par_oPg.lbl_4c_LblSexoObr
2390:             .Caption = "Sexo Obrig.:"
2391:             .Top = 262
2392:             .Left = 17
2393:             .Width = 141
2394:             .Height = 17
2395:             .FontName = "Tahoma"
2396:             .FontSize = 8
2397:             .ForeColor = RGB(90,90,90)
2398:             .BackStyle = 0
2399:             .Alignment = 1
2400:             .Visible = .T.
2401:         ENDWITH
2402: 
2403:         par_oPg.AddObject("Fwoption7", "OptionGroup")
2404:         loc_oOpt = par_oPg.Fwoption7
2405:         WITH loc_oOpt
2406:             .ButtonCount = 2
2407:             .Top = 262
2408:             .Left = 160
2409:             .Width = 97
2410:             .Height = 25
2411:             .BackStyle = 0
2412:             .BorderStyle = 0
2413:             .Value = 1
2414:             .Visible = .T.
2415:         ENDWITH
2416:         loc_oOpt.Buttons(1).Caption = "Sim"
2417:         loc_oOpt.Buttons(1).Left = 5
2418:         loc_oOpt.Buttons(1).Top = 3
2419:         loc_oOpt.Buttons(1).Width = 40
2420:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2421:         loc_oOpt.Buttons(1).FontSize = 8
2422:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2423:         loc_oOpt.Buttons(1).Themes = .F.
2424:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2425:         loc_oOpt.Buttons(2).Left = 48
2426:         loc_oOpt.Buttons(2).Top = 3
2427:         loc_oOpt.Buttons(2).Width = 44
2428:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2429:         loc_oOpt.Buttons(2).FontSize = 8
2430:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2431:         loc_oOpt.Buttons(2).Themes = .F.
2432: 
2433:         *-- Telefone 1 Obrig (Fwoption12)
2434:         par_oPg.AddObject("lbl_4c_LblTel1Obr", "Label")
2435:         WITH par_oPg.lbl_4c_LblTel1Obr
2436:             .Caption = "Telefone 1 Obrig.:"
2437:             .Top = 283
2438:             .Left = 17
2439:             .Width = 141
2440:             .Height = 17
2441:             .FontName = "Tahoma"
2442:             .FontSize = 8
2443:             .ForeColor = RGB(90,90,90)
2444:             .BackStyle = 0
2445:             .Alignment = 1
2446:             .Visible = .T.
2447:         ENDWITH
2448: 
2449:         par_oPg.AddObject("Fwoption12", "OptionGroup")
2450:         loc_oOpt = par_oPg.Fwoption12
2451:         WITH loc_oOpt
2452:             .ButtonCount = 2
2453:             .Top = 283
2454:             .Left = 160
2455:             .Width = 97
2456:             .Height = 25
2457:             .BackStyle = 0
2458:             .BorderStyle = 0
2459:             .Value = 1
2460:             .Visible = .T.
2461:         ENDWITH
2462:         loc_oOpt.Buttons(1).Caption = "Sim"
2463:         loc_oOpt.Buttons(1).Left = 5
2464:         loc_oOpt.Buttons(1).Top = 3
2465:         loc_oOpt.Buttons(1).Width = 40
2466:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2467:         loc_oOpt.Buttons(1).FontSize = 8
2468:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2469:         loc_oOpt.Buttons(1).Themes = .F.
2470:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2471:         loc_oOpt.Buttons(2).Left = 48
2472:         loc_oOpt.Buttons(2).Top = 3
2473:         loc_oOpt.Buttons(2).Width = 44
2474:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2475:         loc_oOpt.Buttons(2).FontSize = 8
2476:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2477:         loc_oOpt.Buttons(2).Themes = .F.
2478: 
2479:         *-- Telefone 2 Obrig (Fwoption13)
2480:         par_oPg.AddObject("lbl_4c_LblTel2Obr", "Label")
2481:         WITH par_oPg.lbl_4c_LblTel2Obr
2482:             .Caption = "Telefone 2 Obrig.:"
2483:             .Top = 302
2484:             .Left = 17
2485:             .Width = 141
2486:             .Height = 17
2487:             .FontName = "Tahoma"
2488:             .FontSize = 8
2489:             .ForeColor = RGB(90,90,90)
2490:             .BackStyle = 0
2491:             .Alignment = 1
2492:             .Visible = .T.
2493:         ENDWITH
2494: 
2495:         par_oPg.AddObject("Fwoption13", "OptionGroup")
2496:         loc_oOpt = par_oPg.Fwoption13
2497:         WITH loc_oOpt
2498:             .ButtonCount = 2
2499:             .Top = 302
2500:             .Left = 160
2501:             .Width = 97
2502:             .Height = 25
2503:             .BackStyle = 0
2504:             .BorderStyle = 0
2505:             .Value = 1
2506:             .Visible = .T.
2507:         ENDWITH
2508:         loc_oOpt.Buttons(1).Caption = "Sim"
2509:         loc_oOpt.Buttons(1).Left = 5
2510:         loc_oOpt.Buttons(1).Top = 3
2511:         loc_oOpt.Buttons(1).Width = 40
2512:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2513:         loc_oOpt.Buttons(1).FontSize = 8
2514:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2515:         loc_oOpt.Buttons(1).Themes = .F.
2516:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2517:         loc_oOpt.Buttons(2).Left = 48
2518:         loc_oOpt.Buttons(2).Top = 3
2519:         loc_oOpt.Buttons(2).Width = 44
2520:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2521:         loc_oOpt.Buttons(2).FontSize = 8
2522:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2523:         loc_oOpt.Buttons(2).Themes = .F.
2524: 
2525:         *-- Col 2: Endereco obrigatorio (Left 464)
2526:         *-- Endereco Obrig (Fwoption14)
2527:         par_oPg.AddObject("lbl_4c_LblEndObr", "Label")
2528:         WITH par_oPg.lbl_4c_LblEndObr
2529:             .Caption = "Endere" + CHR(231) + "o Obrig.:"
2530:             .Top = 33
2531:             .Left = 360
2532:             .Width = 103
2533:             .Height = 17
2534:             .FontName = "Tahoma"
2535:             .FontSize = 8
2536:             .ForeColor = RGB(90,90,90)
2537:             .BackStyle = 0
2538:             .Alignment = 1
2539:             .Visible = .T.
2540:         ENDWITH
2541: 
2542:         par_oPg.AddObject("Fwoption14", "OptionGroup")
2543:         loc_oOpt = par_oPg.Fwoption14
2544:         WITH loc_oOpt
2545:             .ButtonCount = 2
2546:             .Top = 33
2547:             .Left = 464
2548:             .Width = 97
2549:             .Height = 25
2550:             .BackStyle = 0
2551:             .BorderStyle = 0
2552:             .Value = 1
2553:             .Visible = .T.
2554:         ENDWITH
2555:         loc_oOpt.Buttons(1).Caption = "Sim"
2556:         loc_oOpt.Buttons(1).Left = 5
2557:         loc_oOpt.Buttons(1).Top = 3
2558:         loc_oOpt.Buttons(1).Width = 40
2559:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2560:         loc_oOpt.Buttons(1).FontSize = 8
2561:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2562:         loc_oOpt.Buttons(1).Themes = .F.
2563:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2564:         loc_oOpt.Buttons(2).Left = 48
2565:         loc_oOpt.Buttons(2).Top = 3
2566:         loc_oOpt.Buttons(2).Width = 44
2567:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2568:         loc_oOpt.Buttons(2).FontSize = 8
2569:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2570:         loc_oOpt.Buttons(2).Themes = .F.
2571: 
2572:         *-- Numero Obrig (Fwoption8)
2573:         par_oPg.AddObject("lbl_4c_LblNumObr", "Label")
2574:         WITH par_oPg.lbl_4c_LblNumObr
2575:             .Caption = "N" + CHR(250) + "mero Obrig.:"
2576:             .Top = 52
2577:             .Left = 360
2578:             .Width = 103
2579:             .Height = 17
2580:             .FontName = "Tahoma"
2581:             .FontSize = 8
2582:             .ForeColor = RGB(90,90,90)
2583:             .BackStyle = 0
2584:             .Alignment = 1
2585:             .Visible = .T.
2586:         ENDWITH
2587: 
2588:         par_oPg.AddObject("Fwoption8", "OptionGroup")
2589:         loc_oOpt = par_oPg.Fwoption8
2590:         WITH loc_oOpt
2591:             .ButtonCount = 2
2592:             .Top = 52
2593:             .Left = 464
2594:             .Width = 97
2595:             .Height = 25
2596:             .BackStyle = 0
2597:             .BorderStyle = 0
2598:             .Value = 1
2599:             .Visible = .T.
2600:         ENDWITH
2601:         loc_oOpt.Buttons(1).Caption = "Sim"
2602:         loc_oOpt.Buttons(1).Left = 5
2603:         loc_oOpt.Buttons(1).Top = 3
2604:         loc_oOpt.Buttons(1).Width = 40
2605:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2606:         loc_oOpt.Buttons(1).FontSize = 8
2607:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2608:         loc_oOpt.Buttons(1).Themes = .F.
2609:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2610:         loc_oOpt.Buttons(2).Left = 48
2611:         loc_oOpt.Buttons(2).Top = 3
2612:         loc_oOpt.Buttons(2).Width = 44
2613:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2614:         loc_oOpt.Buttons(2).FontSize = 8
2615:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2616:         loc_oOpt.Buttons(2).Themes = .F.
2617: 
2618:         *-- Bairro Obrig (Fwoption9)
2619:         par_oPg.AddObject("lbl_4c_LblBairroObr", "Label")
2620:         WITH par_oPg.lbl_4c_LblBairroObr
2621:             .Caption = "Bairro Obrig.:"
2622:             .Top = 73
2623:             .Left = 360
2624:             .Width = 103
2625:             .Height = 17
2626:             .FontName = "Tahoma"
2627:             .FontSize = 8
2628:             .ForeColor = RGB(90,90,90)
2629:             .BackStyle = 0
2630:             .Alignment = 1
2631:             .Visible = .T.
2632:         ENDWITH
2633: 
2634:         par_oPg.AddObject("Fwoption9", "OptionGroup")
2635:         loc_oOpt = par_oPg.Fwoption9
2636:         WITH loc_oOpt
2637:             .ButtonCount = 2
2638:             .Top = 73
2639:             .Left = 464
2640:             .Width = 97
2641:             .Height = 25
2642:             .BackStyle = 0
2643:             .BorderStyle = 0
2644:             .Value = 1
2645:             .Visible = .T.
2646:         ENDWITH
2647:         loc_oOpt.Buttons(1).Caption = "Sim"
2648:         loc_oOpt.Buttons(1).Left = 5
2649:         loc_oOpt.Buttons(1).Top = 3
2650:         loc_oOpt.Buttons(1).Width = 40
2651:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2652:         loc_oOpt.Buttons(1).FontSize = 8
2653:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2654:         loc_oOpt.Buttons(1).Themes = .F.
2655:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2656:         loc_oOpt.Buttons(2).Left = 48
2657:         loc_oOpt.Buttons(2).Top = 3
2658:         loc_oOpt.Buttons(2).Width = 44
2659:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2660:         loc_oOpt.Buttons(2).FontSize = 8
2661:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2662:         loc_oOpt.Buttons(2).Themes = .F.
2663: 
2664:         *-- Cidade Obrig (Fwoption11)
2665:         par_oPg.AddObject("lbl_4c_LblCidObr", "Label")
2666:         WITH par_oPg.lbl_4c_LblCidObr
2667:             .Caption = "Cidade Obrig.:"
2668:             .Top = 92
2669:             .Left = 360
2670:             .Width = 103
2671:             .Height = 17
2672:             .FontName = "Tahoma"
2673:             .FontSize = 8
2674:             .ForeColor = RGB(90,90,90)
2675:             .BackStyle = 0
2676:             .Alignment = 1
2677:             .Visible = .T.
2678:         ENDWITH
2679: 
2680:         par_oPg.AddObject("Fwoption11", "OptionGroup")
2681:         loc_oOpt = par_oPg.Fwoption11
2682:         WITH loc_oOpt
2683:             .ButtonCount = 2
2684:             .Top = 92
2685:             .Left = 464
2686:             .Width = 97
2687:             .Height = 25
2688:             .BackStyle = 0
2689:             .BorderStyle = 0
2690:             .Value = 1
2691:             .Visible = .T.
2692:         ENDWITH
2693:         loc_oOpt.Buttons(1).Caption = "Sim"
2694:         loc_oOpt.Buttons(1).Left = 5
2695:         loc_oOpt.Buttons(1).Top = 3
2696:         loc_oOpt.Buttons(1).Width = 40
2697:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2698:         loc_oOpt.Buttons(1).FontSize = 8
2699:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2700:         loc_oOpt.Buttons(1).Themes = .F.
2701:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2702:         loc_oOpt.Buttons(2).Left = 48
2703:         loc_oOpt.Buttons(2).Top = 3
2704:         loc_oOpt.Buttons(2).Width = 44
2705:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2706:         loc_oOpt.Buttons(2).FontSize = 8
2707:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2708:         loc_oOpt.Buttons(2).Themes = .F.
2709: 
2710:         *-- Pais Obrig (Fwoption10)
2711:         par_oPg.AddObject("lbl_4c_LblPaisObr", "Label")
2712:         WITH par_oPg.lbl_4c_LblPaisObr
2713:             .Caption = "Pa" + CHR(237) + "s Obrig.:"
2714:             .Top = 112
2715:             .Left = 360
2716:             .Width = 103
2717:             .Height = 17
2718:             .FontName = "Tahoma"
2719:             .FontSize = 8
2720:             .ForeColor = RGB(90,90,90)
2721:             .BackStyle = 0
2722:             .Alignment = 1
2723:             .Visible = .T.
2724:         ENDWITH
2725: 
2726:         par_oPg.AddObject("Fwoption10", "OptionGroup")
2727:         loc_oOpt = par_oPg.Fwoption10
2728:         WITH loc_oOpt
2729:             .ButtonCount = 2
2730:             .Top = 112
2731:             .Left = 464
2732:             .Width = 97
2733:             .Height = 25
2734:             .BackStyle = 0
2735:             .BorderStyle = 0
2736:             .Value = 1
2737:             .Visible = .T.
2738:         ENDWITH
2739:         loc_oOpt.Buttons(1).Caption = "Sim"
2740:         loc_oOpt.Buttons(1).Left = 5
2741:         loc_oOpt.Buttons(1).Top = 3
2742:         loc_oOpt.Buttons(1).Width = 40
2743:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2744:         loc_oOpt.Buttons(1).FontSize = 8
2745:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2746:         loc_oOpt.Buttons(1).Themes = .F.
2747:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2748:         loc_oOpt.Buttons(2).Left = 48
2749:         loc_oOpt.Buttons(2).Top = 3
2750:         loc_oOpt.Buttons(2).Width = 44
2751:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2752:         loc_oOpt.Buttons(2).FontSize = 8
2753:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2754:         loc_oOpt.Buttons(2).Themes = .F.
2755: 
2756:         *-- CEP Obrig (Opt_CEPObrig, 3 btn)
2757:         par_oPg.AddObject("lbl_4c_LblCepObr", "Label")
2758:         WITH par_oPg.lbl_4c_LblCepObr
2759:             .Caption = "CEP Obrig.:"
2760:             .Top = 132
2761:             .Left = 360
2762:             .Width = 103
2763:             .Height = 17
2764:             .FontName = "Tahoma"
2765:             .FontSize = 8
2766:             .ForeColor = RGB(90,90,90)
2767:             .BackStyle = 0
2768:             .Alignment = 1
2769:             .Visible = .T.
2770:         ENDWITH
2771: 
2772:         par_oPg.AddObject("Opt_CEPObrig", "OptionGroup")
2773:         loc_oOpt = par_oPg.Opt_CEPObrig
2774:         WITH loc_oOpt
2775:             .ButtonCount = 3
2776:             .Top = 132
2777:             .Left = 464
2778:             .Width = 180
2779:             .Height = 25
2780:             .BackStyle = 0
2781:             .BorderStyle = 0
2782:             .Value = 1
2783:             .Visible = .T.
2784:         ENDWITH
2785:         loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
2786:         loc_oOpt.Buttons(1).Left = 5
2787:         loc_oOpt.Buttons(1).Top = 3
2788:         loc_oOpt.Buttons(1).Width = 44
2789:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2790:         loc_oOpt.Buttons(1).FontSize = 8
2791:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2792:         loc_oOpt.Buttons(1).Themes = .F.
2793:         loc_oOpt.Buttons(2).Caption = "Opcional"
2794:         loc_oOpt.Buttons(2).Left = 55
2795:         loc_oOpt.Buttons(2).Top = 3
2796:         loc_oOpt.Buttons(2).Width = 65
2797:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2798:         loc_oOpt.Buttons(2).FontSize = 8
2799:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2800:         loc_oOpt.Buttons(2).Themes = .F.
2801:         loc_oOpt.Buttons(3).Caption = "Obrigat" + CHR(243) + "rio"
2802:         loc_oOpt.Buttons(3).Left = 125
2803:         loc_oOpt.Buttons(3).Top = 3
2804:         loc_oOpt.Buttons(3).Width = 50
2805:         loc_oOpt.Buttons(3).FontName = "Tahoma"
2806:         loc_oOpt.Buttons(3).FontSize = 8
2807:         loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
2808:         loc_oOpt.Buttons(3).Themes = .F.
2809: 
2810:         *-- IBGE Obrig (getObrIbge)
2811:         par_oPg.AddObject("lbl_4c_LblIbgeObr", "Label")
2812:         WITH par_oPg.lbl_4c_LblIbgeObr

*-- Linhas 2823 a 2866:
2823:             .Visible = .T.
2824:         ENDWITH
2825: 
2826:         par_oPg.AddObject("getObrIbge", "OptionGroup")
2827:         loc_oOpt = par_oPg.getObrIbge
2828:         WITH loc_oOpt
2829:             .ButtonCount = 2
2830:             .Top = 190
2831:             .Left = 464
2832:             .Width = 97
2833:             .Height = 25
2834:             .BackStyle = 0
2835:             .BorderStyle = 0
2836:             .Value = 1
2837:             .Visible = .T.
2838:         ENDWITH
2839:         loc_oOpt.Buttons(1).Caption = "Sim"
2840:         loc_oOpt.Buttons(1).Left = 5
2841:         loc_oOpt.Buttons(1).Top = 3
2842:         loc_oOpt.Buttons(1).Width = 40
2843:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2844:         loc_oOpt.Buttons(1).FontSize = 8
2845:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2846:         loc_oOpt.Buttons(1).Themes = .F.
2847:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2848:         loc_oOpt.Buttons(2).Left = 48
2849:         loc_oOpt.Buttons(2).Top = 3
2850:         loc_oOpt.Buttons(2).Width = 44
2851:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2852:         loc_oOpt.Buttons(2).FontSize = 8
2853:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2854:         loc_oOpt.Buttons(2).Themes = .F.
2855: 
2856:         *-- Conta Interna
2857:         par_oPg.AddObject("lbl_4c_LblContint", "Label")
2858:         WITH par_oPg.lbl_4c_LblContint
2859:             .Caption = "Conta Interna:"
2860:             .Top = 349
2861:             .Left = 17
2862:             .Width = 90
2863:             .Height = 17
2864:             .FontName = "Tahoma"
2865:             .FontSize = 8
2866:             .ForeColor = RGB(90,90,90)

*-- Linhas 2902 a 2945:
2902:             .Visible = .T.
2903:         ENDWITH
2904: 
2905:         par_oPg.AddObject("Opt_Integ", "OptionGroup")
2906:         loc_oOpt = par_oPg.Opt_Integ
2907:         WITH loc_oOpt
2908:             .ButtonCount = 3
2909:             .Top = 373
2910:             .Left = 192
2911:             .Width = 316
2912:             .Height = 23
2913:             .BackStyle = 0
2914:             .BorderStyle = 0
2915:             .Value = 1
2916:             .Visible = .T.
2917:         ENDWITH
2918:         loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
2919:         loc_oOpt.Buttons(1).Left = 5
2920:         loc_oOpt.Buttons(1).Top = 3
2921:         loc_oOpt.Buttons(1).Width = 40
2922:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2923:         loc_oOpt.Buttons(1).FontSize = 8
2924:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2925:         loc_oOpt.Buttons(1).Themes = .F.
2926:         loc_oOpt.Buttons(2).Caption = "Integra" + CHR(231) + CHR(227) + "o Padr" + CHR(227) + "o"
2927:         loc_oOpt.Buttons(2).Left = 50
2928:         loc_oOpt.Buttons(2).Top = 3
2929:         loc_oOpt.Buttons(2).Width = 130
2930:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2931:         loc_oOpt.Buttons(2).FontSize = 8
2932:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2933:         loc_oOpt.Buttons(2).Themes = .F.
2934:         loc_oOpt.Buttons(3).Caption = "Por Grupo"
2935:         loc_oOpt.Buttons(3).Left = 185
2936:         loc_oOpt.Buttons(3).Top = 3
2937:         loc_oOpt.Buttons(3).Width = 90
2938:         loc_oOpt.Buttons(3).FontName = "Tahoma"
2939:         loc_oOpt.Buttons(3).FontSize = 8
2940:         loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
2941:         loc_oOpt.Buttons(3).Themes = .F.
2942: 
2943:         *-- Padrao Preenchimento (Fwoption3, 4 btn)
2944:         par_oPg.AddObject("lbl_4c_LblPadPgrec", "Label")
2945:         WITH par_oPg.lbl_4c_LblPadPgrec

*-- Linhas 2956 a 2999:
2956:             .Visible = .T.
2957:         ENDWITH
2958: 
2959:         par_oPg.AddObject("Fwoption3", "OptionGroup")
2960:         loc_oOpt = par_oPg.Fwoption3
2961:         WITH loc_oOpt
2962:             .ButtonCount = 4
2963:             .Top = 394
2964:             .Left = 192
2965:             .Width = 353
2966:             .Height = 23
2967:             .BackStyle = 0
2968:             .BorderStyle = 0
2969:             .Value = 1
2970:             .Visible = .T.
2971:         ENDWITH
2972:         loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
2973:         loc_oOpt.Buttons(1).Left = 5
2974:         loc_oOpt.Buttons(1).Top = 3
2975:         loc_oOpt.Buttons(1).Width = 40
2976:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2977:         loc_oOpt.Buttons(1).FontSize = 8
2978:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2979:         loc_oOpt.Buttons(1).Themes = .F.
2980:         loc_oOpt.Buttons(2).Caption = "Gravar Zero"
2981:         loc_oOpt.Buttons(2).Left = 50
2982:         loc_oOpt.Buttons(2).Top = 3
2983:         loc_oOpt.Buttons(2).Width = 80
2984:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2985:         loc_oOpt.Buttons(2).FontSize = 8
2986:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2987:         loc_oOpt.Buttons(2).Themes = .F.
2988:         loc_oOpt.Buttons(3).Caption = "Gravar Nulo"
2989:         loc_oOpt.Buttons(3).Left = 135
2990:         loc_oOpt.Buttons(3).Top = 3
2991:         loc_oOpt.Buttons(3).Width = 80
2992:         loc_oOpt.Buttons(3).FontName = "Tahoma"
2993:         loc_oOpt.Buttons(3).FontSize = 8
2994:         loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
2995:         loc_oOpt.Buttons(3).Themes = .F.
2996:         loc_oOpt.Buttons(4).Caption = "Gravar Vazio"
2997:         loc_oOpt.Buttons(4).Left = 220
2998:         loc_oOpt.Buttons(4).Top = 3
2999:         loc_oOpt.Buttons(4).Width = 80

*-- Linhas 3018 a 3338:
3018:             .Visible = .T.
3019:         ENDWITH
3020: 
3021:         par_oPg.AddObject("optVincPgRcs", "OptionGroup")
3022:         loc_oOpt = par_oPg.optVincPgRcs
3023:         WITH loc_oOpt
3024:             .ButtonCount = 2
3025:             .Top = 415
3026:             .Left = 192
3027:             .Width = 181
3028:             .Height = 23
3029:             .BackStyle = 0
3030:             .BorderStyle = 0
3031:             .Value = 1
3032:             .Visible = .T.
3033:         ENDWITH
3034:         loc_oOpt.Buttons(1).Caption = "Sim"
3035:         loc_oOpt.Buttons(1).Left = 5
3036:         loc_oOpt.Buttons(1).Top = 3
3037:         loc_oOpt.Buttons(1).Width = 40
3038:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3039:         loc_oOpt.Buttons(1).FontSize = 8
3040:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3041:         loc_oOpt.Buttons(1).Themes = .F.
3042:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3043:         loc_oOpt.Buttons(2).Left = 48
3044:         loc_oOpt.Buttons(2).Top = 3
3045:         loc_oOpt.Buttons(2).Width = 44
3046:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3047:         loc_oOpt.Buttons(2).FontSize = 8
3048:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3049:         loc_oOpt.Buttons(2).Themes = .F.
3050: 
3051:         *-- Tit Nao Baixado (OptTitBaixado)
3052:         par_oPg.AddObject("lbl_4c_LblTitBaix", "Label")
3053:         WITH par_oPg.lbl_4c_LblTitBaix
3054:             .Caption = "Visualiza Tit.n" + CHR(227) + "o Baixados:"
3055:             .Top = 435
3056:             .Left = 17
3057:             .Width = 173
3058:             .Height = 17
3059:             .FontName = "Tahoma"
3060:             .FontSize = 8
3061:             .ForeColor = RGB(90,90,90)
3062:             .BackStyle = 0
3063:             .Alignment = 1
3064:             .Visible = .T.
3065:         ENDWITH
3066: 
3067:         par_oPg.AddObject("OptTitBaixado", "OptionGroup")
3068:         loc_oOpt = par_oPg.OptTitBaixado
3069:         WITH loc_oOpt
3070:             .ButtonCount = 2
3071:             .Top = 435
3072:             .Left = 192
3073:             .Width = 181
3074:             .Height = 23
3075:             .BackStyle = 0
3076:             .BorderStyle = 0
3077:             .Value = 1
3078:             .Visible = .T.
3079:         ENDWITH
3080:         loc_oOpt.Buttons(1).Caption = "Sim"
3081:         loc_oOpt.Buttons(1).Left = 5
3082:         loc_oOpt.Buttons(1).Top = 3
3083:         loc_oOpt.Buttons(1).Width = 40
3084:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3085:         loc_oOpt.Buttons(1).FontSize = 8
3086:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3087:         loc_oOpt.Buttons(1).Themes = .F.
3088:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3089:         loc_oOpt.Buttons(2).Left = 48
3090:         loc_oOpt.Buttons(2).Top = 3
3091:         loc_oOpt.Buttons(2).Width = 44
3092:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3093:         loc_oOpt.Buttons(2).FontSize = 8
3094:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3095:         loc_oOpt.Buttons(2).Themes = .F.
3096: 
3097:         *-- Col 3: dados adicionais (Left 583+)
3098:         *-- Duplicar Endereco (Fwoption4)
3099:         par_oPg.AddObject("lbl_4c_LblDupEnd", "Label")
3100:         WITH par_oPg.lbl_4c_LblDupEnd
3101:             .Caption = "Duplicar Endere" + CHR(231) + "o:"
3102:             .Top = 34
3103:             .Left = 600
3104:             .Width = 120
3105:             .Height = 17
3106:             .FontName = "Tahoma"
3107:             .FontSize = 8
3108:             .ForeColor = RGB(90,90,90)
3109:             .BackStyle = 0
3110:             .Alignment = 1
3111:             .Visible = .T.
3112:         ENDWITH
3113: 
3114:         par_oPg.AddObject("Fwoption4", "OptionGroup")
3115:         loc_oOpt = par_oPg.Fwoption4
3116:         WITH loc_oOpt
3117:             .ButtonCount = 2
3118:             .Top = 34
3119:             .Left = 796
3120:             .Width = 131
3121:             .Height = 23
3122:             .BackStyle = 0
3123:             .BorderStyle = 0
3124:             .Value = 1
3125:             .Visible = .T.
3126:         ENDWITH
3127:         loc_oOpt.Buttons(1).Caption = "Sim"
3128:         loc_oOpt.Buttons(1).Left = 5
3129:         loc_oOpt.Buttons(1).Top = 3
3130:         loc_oOpt.Buttons(1).Width = 40
3131:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3132:         loc_oOpt.Buttons(1).FontSize = 8
3133:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3134:         loc_oOpt.Buttons(1).Themes = .F.
3135:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3136:         loc_oOpt.Buttons(2).Left = 48
3137:         loc_oOpt.Buttons(2).Top = 3
3138:         loc_oOpt.Buttons(2).Width = 44
3139:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3140:         loc_oOpt.Buttons(2).FontSize = 8
3141:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3142:         loc_oOpt.Buttons(2).Themes = .F.
3143: 
3144:         *-- Restringe Endereco (Fwoption5)
3145:         par_oPg.AddObject("lbl_4c_LblRestrEnd", "Label")
3146:         WITH par_oPg.lbl_4c_LblRestrEnd
3147:             .Caption = "Restringe Endere" + CHR(231) + "o:"
3148:             .Top = 55
3149:             .Left = 600
3150:             .Width = 120
3151:             .Height = 17
3152:             .FontName = "Tahoma"
3153:             .FontSize = 8
3154:             .ForeColor = RGB(90,90,90)
3155:             .BackStyle = 0
3156:             .Alignment = 1
3157:             .Visible = .T.
3158:         ENDWITH
3159: 
3160:         par_oPg.AddObject("Fwoption5", "OptionGroup")
3161:         loc_oOpt = par_oPg.Fwoption5
3162:         WITH loc_oOpt
3163:             .ButtonCount = 2
3164:             .Top = 55
3165:             .Left = 796
3166:             .Width = 131
3167:             .Height = 23
3168:             .BackStyle = 0
3169:             .BorderStyle = 0
3170:             .Value = 1
3171:             .Visible = .T.
3172:         ENDWITH
3173:         loc_oOpt.Buttons(1).Caption = "Sim"
3174:         loc_oOpt.Buttons(1).Left = 5
3175:         loc_oOpt.Buttons(1).Top = 3
3176:         loc_oOpt.Buttons(1).Width = 40
3177:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3178:         loc_oOpt.Buttons(1).FontSize = 8
3179:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3180:         loc_oOpt.Buttons(1).Themes = .F.
3181:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3182:         loc_oOpt.Buttons(2).Left = 48
3183:         loc_oOpt.Buttons(2).Top = 3
3184:         loc_oOpt.Buttons(2).Width = 44
3185:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3186:         loc_oOpt.Buttons(2).FontSize = 8
3187:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3188:         loc_oOpt.Buttons(2).Themes = .F.
3189: 
3190:         *-- Bloqueia CPF (Fwoption16)
3191:         par_oPg.AddObject("lbl_4c_LblBlqCpf", "Label")
3192:         WITH par_oPg.lbl_4c_LblBlqCpf
3193:             .Caption = "Bloqueia CPF dup.:"
3194:             .Top = 73
3195:             .Left = 600
3196:             .Width = 120
3197:             .Height = 17
3198:             .FontName = "Tahoma"
3199:             .FontSize = 8
3200:             .ForeColor = RGB(90,90,90)
3201:             .BackStyle = 0
3202:             .Alignment = 1
3203:             .Visible = .T.
3204:         ENDWITH
3205: 
3206:         par_oPg.AddObject("Fwoption16", "OptionGroup")
3207:         loc_oOpt = par_oPg.Fwoption16
3208:         WITH loc_oOpt
3209:             .ButtonCount = 2
3210:             .Top = 73
3211:             .Left = 796
3212:             .Width = 131
3213:             .Height = 23
3214:             .BackStyle = 0
3215:             .BorderStyle = 0
3216:             .Value = 1
3217:             .Visible = .T.
3218:         ENDWITH
3219:         loc_oOpt.Buttons(1).Caption = "Sim"
3220:         loc_oOpt.Buttons(1).Left = 5
3221:         loc_oOpt.Buttons(1).Top = 3
3222:         loc_oOpt.Buttons(1).Width = 40
3223:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3224:         loc_oOpt.Buttons(1).FontSize = 8
3225:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3226:         loc_oOpt.Buttons(1).Themes = .F.
3227:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3228:         loc_oOpt.Buttons(2).Left = 48
3229:         loc_oOpt.Buttons(2).Top = 3
3230:         loc_oOpt.Buttons(2).Width = 44
3231:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3232:         loc_oOpt.Buttons(2).FontSize = 8
3233:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3234:         loc_oOpt.Buttons(2).Themes = .F.
3235: 
3236:         *-- Mostrar Foto (Opt_MFotos)
3237:         par_oPg.AddObject("lbl_4c_LblMFotos", "Label")
3238:         WITH par_oPg.lbl_4c_LblMFotos
3239:             .Caption = "Mostrar Foto:"
3240:             .Top = 93
3241:             .Left = 600
3242:             .Width = 120
3243:             .Height = 17
3244:             .FontName = "Tahoma"
3245:             .FontSize = 8
3246:             .ForeColor = RGB(90,90,90)
3247:             .BackStyle = 0
3248:             .Alignment = 1
3249:             .Visible = .T.
3250:         ENDWITH
3251: 
3252:         par_oPg.AddObject("Opt_MFotos", "OptionGroup")
3253:         loc_oOpt = par_oPg.Opt_MFotos
3254:         WITH loc_oOpt
3255:             .ButtonCount = 2
3256:             .Top = 93
3257:             .Left = 796
3258:             .Width = 131
3259:             .Height = 22
3260:             .BackStyle = 0
3261:             .BorderStyle = 0
3262:             .Value = 1
3263:             .Visible = .T.
3264:         ENDWITH
3265:         loc_oOpt.Buttons(1).Caption = "Sim"
3266:         loc_oOpt.Buttons(1).Left = 5
3267:         loc_oOpt.Buttons(1).Top = 3
3268:         loc_oOpt.Buttons(1).Width = 40
3269:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3270:         loc_oOpt.Buttons(1).FontSize = 8
3271:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3272:         loc_oOpt.Buttons(1).Themes = .F.
3273:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3274:         loc_oOpt.Buttons(2).Left = 48
3275:         loc_oOpt.Buttons(2).Top = 3
3276:         loc_oOpt.Buttons(2).Width = 44
3277:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3278:         loc_oOpt.Buttons(2).FontSize = 8
3279:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3280:         loc_oOpt.Buttons(2).Themes = .F.
3281: 
3282:         *-- Observacoes (fwoption1, 3 btn)
3283:         par_oPg.AddObject("lbl_4c_LblObservs", "Label")
3284:         WITH par_oPg.lbl_4c_LblObservs
3285:             .Caption = "Observa" + CHR(231) + CHR(245) + "es:"
3286:             .Top = 111
3287:             .Left = 600
3288:             .Width = 120
3289:             .Height = 17
3290:             .FontName = "Tahoma"
3291:             .FontSize = 8
3292:             .ForeColor = RGB(90,90,90)
3293:             .BackStyle = 0
3294:             .Alignment = 1
3295:             .Visible = .T.
3296:         ENDWITH
3297: 
3298:         par_oPg.AddObject("fwoption1", "OptionGroup")
3299:         loc_oOpt = par_oPg.fwoption1
3300:         WITH loc_oOpt
3301:             .ButtonCount = 3
3302:             .Top = 111
3303:             .Left = 797
3304:             .Width = 131
3305:             .Height = 52
3306:             .BackStyle = 0
3307:             .BorderStyle = 0
3308:             .Value = 1
3309:             .Visible = .T.
3310:         ENDWITH
3311:         loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
3312:         loc_oOpt.Buttons(1).Left = 5
3313:         loc_oOpt.Buttons(1).Top = 3
3314:         loc_oOpt.Buttons(1).Width = 44
3315:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3316:         loc_oOpt.Buttons(1).FontSize = 8
3317:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3318:         loc_oOpt.Buttons(1).Themes = .F.
3319:         loc_oOpt.Buttons(2).Caption = "Livre"
3320:         loc_oOpt.Buttons(2).Left = 5
3321:         loc_oOpt.Buttons(2).Top = 22
3322:         loc_oOpt.Buttons(2).Width = 44
3323:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3324:         loc_oOpt.Buttons(2).FontSize = 8
3325:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3326:         loc_oOpt.Buttons(2).Themes = .F.
3327:         loc_oOpt.Buttons(3).Caption = "RTF"
3328:         loc_oOpt.Buttons(3).Left = 5
3329:         loc_oOpt.Buttons(3).Top = 41
3330:         loc_oOpt.Buttons(3).Width = 44
3331:         loc_oOpt.Buttons(3).FontName = "Tahoma"
3332:         loc_oOpt.Buttons(3).FontSize = 8
3333:         loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
3334:         loc_oOpt.Buttons(3).Themes = .F.
3335: 
3336:         *-- CPF Fixo (optCpffixo, 3 btn)
3337:         par_oPg.AddObject("lbl_4c_LblCpfFixo", "Label")
3338:         WITH par_oPg.lbl_4c_LblCpfFixo

*-- Linhas 3349 a 3392:
3349:             .Visible = .T.
3350:         ENDWITH
3351: 
3352:         par_oPg.AddObject("optCpffixo", "OptionGroup")
3353:         loc_oOpt = par_oPg.optCpffixo
3354:         WITH loc_oOpt
3355:             .ButtonCount = 3
3356:             .Top = 163
3357:             .Left = 798
3358:             .Width = 183
3359:             .Height = 23
3360:             .BackStyle = 0
3361:             .BorderStyle = 0
3362:             .Value = 1
3363:             .Visible = .T.
3364:         ENDWITH
3365:         loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
3366:         loc_oOpt.Buttons(1).Left = 5
3367:         loc_oOpt.Buttons(1).Top = 3
3368:         loc_oOpt.Buttons(1).Width = 40
3369:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3370:         loc_oOpt.Buttons(1).FontSize = 8
3371:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3372:         loc_oOpt.Buttons(1).Themes = .F.
3373:         loc_oOpt.Buttons(2).Caption = "Fixar Formato"
3374:         loc_oOpt.Buttons(2).Left = 50
3375:         loc_oOpt.Buttons(2).Top = 3
3376:         loc_oOpt.Buttons(2).Width = 80
3377:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3378:         loc_oOpt.Buttons(2).FontSize = 8
3379:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3380:         loc_oOpt.Buttons(2).Themes = .F.
3381:         loc_oOpt.Buttons(3).Caption = "Fixar CPF"
3382:         loc_oOpt.Buttons(3).Left = 135
3383:         loc_oOpt.Buttons(3).Top = 3
3384:         loc_oOpt.Buttons(3).Width = 45
3385:         loc_oOpt.Buttons(3).FontName = "Tahoma"
3386:         loc_oOpt.Buttons(3).FontSize = 8
3387:         loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
3388:         loc_oOpt.Buttons(3).Themes = .F.
3389: 
3390:         *-- Situacao Padrao
3391:         par_oPg.AddObject("lbl_4c_LblSitPad", "Label")
3392:         WITH par_oPg.lbl_4c_LblSitPad

*-- Linhas 3419 a 3574:
3419:             .SpecialEffect = 0
3420:             .Visible = .T.
3421:         ENDWITH
3422:         BINDEVENT(par_oPg.getSituas, "KeyPress",  THIS, "SituacaoKeyPress")
3423:         BINDEVENT(par_oPg.getSituas, "DblClick",  THIS, "SituacaoDblClick")
3424:         BINDEVENT(par_oPg.getSituas, "KeyPress", THIS, "SituacaoLostFocus")
3425: 
3426:         *-- Caracteristicas (optCarac)
3427:         par_oPg.AddObject("lbl_4c_LblCarac", "Label")
3428:         WITH par_oPg.lbl_4c_LblCarac
3429:             .Caption = "Caracter" + CHR(237) + "sticas:"
3430:             .Top = 211
3431:             .Left = 600
3432:             .Width = 120
3433:             .Height = 17
3434:             .FontName = "Tahoma"
3435:             .FontSize = 8
3436:             .ForeColor = RGB(90,90,90)
3437:             .BackStyle = 0
3438:             .Alignment = 1
3439:             .Visible = .T.
3440:         ENDWITH
3441: 
3442:         par_oPg.AddObject("optCarac", "OptionGroup")
3443:         loc_oOpt = par_oPg.optCarac
3444:         WITH loc_oOpt
3445:             .ButtonCount = 2
3446:             .Top = 211
3447:             .Left = 796
3448:             .Width = 131
3449:             .Height = 23
3450:             .BackStyle = 0
3451:             .BorderStyle = 0
3452:             .Value = 1
3453:             .Visible = .T.
3454:         ENDWITH
3455:         loc_oOpt.Buttons(1).Caption = "Sim"
3456:         loc_oOpt.Buttons(1).Left = 5
3457:         loc_oOpt.Buttons(1).Top = 3
3458:         loc_oOpt.Buttons(1).Width = 40
3459:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3460:         loc_oOpt.Buttons(1).FontSize = 8
3461:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3462:         loc_oOpt.Buttons(1).Themes = .F.
3463:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3464:         loc_oOpt.Buttons(2).Left = 48
3465:         loc_oOpt.Buttons(2).Top = 3
3466:         loc_oOpt.Buttons(2).Width = 44
3467:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3468:         loc_oOpt.Buttons(2).FontSize = 8
3469:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3470:         loc_oOpt.Buttons(2).Themes = .F.
3471: 
3472:         *-- AceJob (optAceJob)
3473:         par_oPg.AddObject("lbl_4c_LblAceJob", "Label")
3474:         WITH par_oPg.lbl_4c_LblAceJob
3475:             .Caption = "Aceita Job:"
3476:             .Top = 232
3477:             .Left = 600
3478:             .Width = 120
3479:             .Height = 17
3480:             .FontName = "Tahoma"
3481:             .FontSize = 8
3482:             .ForeColor = RGB(90,90,90)
3483:             .BackStyle = 0
3484:             .Alignment = 1
3485:             .Visible = .T.
3486:         ENDWITH
3487: 
3488:         par_oPg.AddObject("optAceJob", "OptionGroup")
3489:         loc_oOpt = par_oPg.optAceJob
3490:         WITH loc_oOpt
3491:             .ButtonCount = 2
3492:             .Top = 232
3493:             .Left = 796
3494:             .Width = 131
3495:             .Height = 23
3496:             .BackStyle = 0
3497:             .BorderStyle = 0
3498:             .Value = 1
3499:             .Visible = .T.
3500:         ENDWITH
3501:         loc_oOpt.Buttons(1).Caption = "Sim"
3502:         loc_oOpt.Buttons(1).Left = 5
3503:         loc_oOpt.Buttons(1).Top = 3
3504:         loc_oOpt.Buttons(1).Width = 40
3505:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3506:         loc_oOpt.Buttons(1).FontSize = 8
3507:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3508:         loc_oOpt.Buttons(1).Themes = .F.
3509:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3510:         loc_oOpt.Buttons(2).Left = 48
3511:         loc_oOpt.Buttons(2).Top = 3
3512:         loc_oOpt.Buttons(2).Width = 44
3513:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3514:         loc_oOpt.Buttons(2).FontSize = 8
3515:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3516:         loc_oOpt.Buttons(2).Themes = .F.
3517: 
3518:         *-- Alerta Cadastro (OptAlertaCad)
3519:         par_oPg.AddObject("lbl_4c_LblAlertaCad", "Label")
3520:         WITH par_oPg.lbl_4c_LblAlertaCad
3521:             .Caption = "Alerta Cadastro:"
3522:             .Top = 250
3523:             .Left = 600
3524:             .Width = 120
3525:             .Height = 17
3526:             .FontName = "Tahoma"
3527:             .FontSize = 8
3528:             .ForeColor = RGB(90,90,90)
3529:             .BackStyle = 0
3530:             .Alignment = 1
3531:             .Visible = .T.
3532:         ENDWITH
3533: 
3534:         par_oPg.AddObject("OptAlertaCad", "OptionGroup")
3535:         loc_oOpt = par_oPg.OptAlertaCad
3536:         WITH loc_oOpt
3537:             .ButtonCount = 2
3538:             .Top = 250
3539:             .Left = 795
3540:             .Width = 98
3541:             .Height = 25
3542:             .BackStyle = 0
3543:             .BorderStyle = 0
3544:             .Value = 1
3545:             .Visible = .T.
3546:         ENDWITH
3547:         loc_oOpt.Buttons(1).Caption = "Sim"
3548:         loc_oOpt.Buttons(1).Left = 5
3549:         loc_oOpt.Buttons(1).Top = 3
3550:         loc_oOpt.Buttons(1).Width = 40
3551:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3552:         loc_oOpt.Buttons(1).FontSize = 8
3553:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3554:         loc_oOpt.Buttons(1).Themes = .F.
3555:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3556:         loc_oOpt.Buttons(2).Left = 48
3557:         loc_oOpt.Buttons(2).Top = 3
3558:         loc_oOpt.Buttons(2).Width = 44
3559:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3560:         loc_oOpt.Buttons(2).FontSize = 8
3561:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3562:         loc_oOpt.Buttons(2).Themes = .F.
3563: 
3564:         *-- Mensagem de Alerta
3565:         par_oPg.AddObject("lbl_4c_LblMsgAlerta", "Label")
3566:         WITH par_oPg.lbl_4c_LblMsgAlerta
3567:             .Caption = "Mensagem Alerta:"
3568:             .Top = 271
3569:             .Left = 600
3570:             .Width = 120
3571:             .Height = 17
3572:             .FontName = "Tahoma"
3573:             .FontSize = 8
3574:             .ForeColor = RGB(90,90,90)

*-- Linhas 3597 a 3900:
3597:     *--------------------------------------------------------------------------
3598:     * CriarAbaEstoque - Controles da aba Estoque (pgf_4c_1.Page3)
3599:     *--------------------------------------------------------------------------
3600:     PROTECTED PROCEDURE CriarAbaEstoque(par_oPg)
3601:         LOCAL loc_oOpt
3602: 
3603:         *-- Linha separadora
3604:         par_oPg.AddObject("lin_4c_Est1", "Line")
3605:         WITH par_oPg.lin_4c_Est1
3606:             .Top = 158
3607:             .Left = 17
3608:             .Width = 959
3609:             .Height = 1
3610:             .BorderColor = RGB(150,150,150)
3611:             .Visible = .T.
3612:         ENDWITH
3613: 
3614:         *-- Limite de Estoque (Opt_LimEsto)
3615:         par_oPg.AddObject("lbl_4c_LblLimEsto", "Label")
3616:         WITH par_oPg.lbl_4c_LblLimEsto
3617:             .Caption = "Limite de Estoque:"
3618:             .Top = 29
3619:             .Left = 17
3620:             .Width = 156
3621:             .Height = 17
3622:             .FontName = "Tahoma"
3623:             .FontSize = 8
3624:             .ForeColor = RGB(90,90,90)
3625:             .BackStyle = 0
3626:             .Alignment = 1
3627:             .Visible = .T.
3628:         ENDWITH
3629: 
3630:         par_oPg.AddObject("Opt_LimEsto", "OptionGroup")
3631:         loc_oOpt = par_oPg.Opt_LimEsto
3632:         WITH loc_oOpt
3633:             .ButtonCount = 2
3634:             .Top = 29
3635:             .Left = 174
3636:             .Width = 92
3637:             .Height = 25
3638:             .BackStyle = 0
3639:             .BorderStyle = 0
3640:             .Value = 1
3641:             .Visible = .T.
3642:         ENDWITH
3643:         loc_oOpt.Buttons(1).Caption = "Sim"
3644:         loc_oOpt.Buttons(1).Left = 5
3645:         loc_oOpt.Buttons(1).Top = 3
3646:         loc_oOpt.Buttons(1).Width = 40
3647:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3648:         loc_oOpt.Buttons(1).FontSize = 8
3649:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3650:         loc_oOpt.Buttons(1).Themes = .F.
3651:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3652:         loc_oOpt.Buttons(2).Left = 48
3653:         loc_oOpt.Buttons(2).Top = 3
3654:         loc_oOpt.Buttons(2).Width = 44
3655:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3656:         loc_oOpt.Buttons(2).FontSize = 8
3657:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3658:         loc_oOpt.Buttons(2).Themes = .F.
3659: 
3660:         *-- Verificar Estoque (Opt_VerEst)
3661:         par_oPg.AddObject("lbl_4c_LblVerEst", "Label")
3662:         WITH par_oPg.lbl_4c_LblVerEst
3663:             .Caption = "Verificar Estoque:"
3664:             .Top = 53
3665:             .Left = 17
3666:             .Width = 156
3667:             .Height = 17
3668:             .FontName = "Tahoma"
3669:             .FontSize = 8
3670:             .ForeColor = RGB(90,90,90)
3671:             .BackStyle = 0
3672:             .Alignment = 1
3673:             .Visible = .T.
3674:         ENDWITH
3675: 
3676:         par_oPg.AddObject("Opt_VerEst", "OptionGroup")
3677:         loc_oOpt = par_oPg.Opt_VerEst
3678:         WITH loc_oOpt
3679:             .ButtonCount = 2
3680:             .Top = 53
3681:             .Left = 174
3682:             .Width = 92
3683:             .Height = 25
3684:             .BackStyle = 0
3685:             .BorderStyle = 0
3686:             .Value = 1
3687:             .Visible = .T.
3688:         ENDWITH
3689:         loc_oOpt.Buttons(1).Caption = "Sim"
3690:         loc_oOpt.Buttons(1).Left = 5
3691:         loc_oOpt.Buttons(1).Top = 3
3692:         loc_oOpt.Buttons(1).Width = 40
3693:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3694:         loc_oOpt.Buttons(1).FontSize = 8
3695:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3696:         loc_oOpt.Buttons(1).Themes = .F.
3697:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3698:         loc_oOpt.Buttons(2).Left = 48
3699:         loc_oOpt.Buttons(2).Top = 3
3700:         loc_oOpt.Buttons(2).Width = 44
3701:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3702:         loc_oOpt.Buttons(2).FontSize = 8
3703:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3704:         loc_oOpt.Buttons(2).Themes = .F.
3705: 
3706:         *-- Est P.Acabar (Opt_EstPAcab)
3707:         par_oPg.AddObject("lbl_4c_LblEstPAcab", "Label")
3708:         WITH par_oPg.lbl_4c_LblEstPAcab
3709:             .Caption = "Est. P.Acabar:"
3710:             .Top = 77
3711:             .Left = 17
3712:             .Width = 156
3713:             .Height = 17
3714:             .FontName = "Tahoma"
3715:             .FontSize = 8
3716:             .ForeColor = RGB(90,90,90)
3717:             .BackStyle = 0
3718:             .Alignment = 1
3719:             .Visible = .T.
3720:         ENDWITH
3721: 
3722:         par_oPg.AddObject("Opt_EstPAcab", "OptionGroup")
3723:         loc_oOpt = par_oPg.Opt_EstPAcab
3724:         WITH loc_oOpt
3725:             .ButtonCount = 2
3726:             .Top = 77
3727:             .Left = 174
3728:             .Width = 92
3729:             .Height = 25
3730:             .BackStyle = 0
3731:             .BorderStyle = 0
3732:             .Value = 1
3733:             .Visible = .T.
3734:         ENDWITH
3735:         loc_oOpt.Buttons(1).Caption = "Sim"
3736:         loc_oOpt.Buttons(1).Left = 5
3737:         loc_oOpt.Buttons(1).Top = 3
3738:         loc_oOpt.Buttons(1).Width = 40
3739:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3740:         loc_oOpt.Buttons(1).FontSize = 8
3741:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3742:         loc_oOpt.Buttons(1).Themes = .F.
3743:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3744:         loc_oOpt.Buttons(2).Left = 48
3745:         loc_oOpt.Buttons(2).Top = 3
3746:         loc_oOpt.Buttons(2).Width = 44
3747:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3748:         loc_oOpt.Buttons(2).FontSize = 8
3749:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3750:         loc_oOpt.Buttons(2).Themes = .F.
3751: 
3752:         *-- Checa Lim Estoque (opt_ChkLimest)
3753:         par_oPg.AddObject("lbl_4c_LblChkLimEst", "Label")
3754:         WITH par_oPg.lbl_4c_LblChkLimEst
3755:             .Caption = "Checa Lim.Estoque:"
3756:             .Top = 101
3757:             .Left = 17
3758:             .Width = 156
3759:             .Height = 17
3760:             .FontName = "Tahoma"
3761:             .FontSize = 8
3762:             .ForeColor = RGB(90,90,90)
3763:             .BackStyle = 0
3764:             .Alignment = 1
3765:             .Visible = .T.
3766:         ENDWITH
3767: 
3768:         par_oPg.AddObject("opt_ChkLimest", "OptionGroup")
3769:         loc_oOpt = par_oPg.opt_ChkLimest
3770:         WITH loc_oOpt
3771:             .ButtonCount = 2
3772:             .Top = 101
3773:             .Left = 174
3774:             .Width = 92
3775:             .Height = 25
3776:             .BackStyle = 0
3777:             .BorderStyle = 0
3778:             .Value = 1
3779:             .Visible = .T.
3780:         ENDWITH
3781:         loc_oOpt.Buttons(1).Caption = "Sim"
3782:         loc_oOpt.Buttons(1).Left = 5
3783:         loc_oOpt.Buttons(1).Top = 3
3784:         loc_oOpt.Buttons(1).Width = 40
3785:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3786:         loc_oOpt.Buttons(1).FontSize = 8
3787:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3788:         loc_oOpt.Buttons(1).Themes = .F.
3789:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3790:         loc_oOpt.Buttons(2).Left = 48
3791:         loc_oOpt.Buttons(2).Top = 3
3792:         loc_oOpt.Buttons(2).Width = 44
3793:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3794:         loc_oOpt.Buttons(2).FontSize = 8
3795:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3796:         loc_oOpt.Buttons(2).Themes = .F.
3797: 
3798:         *-- Centro de Custos (Opt_CCusto)
3799:         par_oPg.AddObject("lbl_4c_LblCCusto", "Label")
3800:         WITH par_oPg.lbl_4c_LblCCusto
3801:             .Caption = "Centro de Custos:"
3802:             .Top = 125
3803:             .Left = 17
3804:             .Width = 156
3805:             .Height = 17
3806:             .FontName = "Tahoma"
3807:             .FontSize = 8
3808:             .ForeColor = RGB(90,90,90)
3809:             .BackStyle = 0
3810:             .Alignment = 1
3811:             .Visible = .T.
3812:         ENDWITH
3813: 
3814:         par_oPg.AddObject("Opt_CCusto", "OptionGroup")
3815:         loc_oOpt = par_oPg.Opt_CCusto
3816:         WITH loc_oOpt
3817:             .ButtonCount = 2
3818:             .Top = 125
3819:             .Left = 174
3820:             .Width = 92
3821:             .Height = 25
3822:             .BackStyle = 0
3823:             .BorderStyle = 0
3824:             .Value = 1
3825:             .Visible = .T.
3826:         ENDWITH
3827:         loc_oOpt.Buttons(1).Caption = "Sim"
3828:         loc_oOpt.Buttons(1).Left = 5
3829:         loc_oOpt.Buttons(1).Top = 3
3830:         loc_oOpt.Buttons(1).Width = 40
3831:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3832:         loc_oOpt.Buttons(1).FontSize = 8
3833:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3834:         loc_oOpt.Buttons(1).Themes = .F.
3835:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3836:         loc_oOpt.Buttons(2).Left = 48
3837:         loc_oOpt.Buttons(2).Top = 3
3838:         loc_oOpt.Buttons(2).Width = 44
3839:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3840:         loc_oOpt.Buttons(2).FontSize = 8
3841:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3842:         loc_oOpt.Buttons(2).Themes = .F.
3843: 
3844:         *-- Gerar Balancete (Opt_GBals)
3845:         par_oPg.AddObject("lbl_4c_LblGBals", "Label")
3846:         WITH par_oPg.lbl_4c_LblGBals
3847:             .Caption = "Gerar Balan" + CHR(231) + "o:"
3848:             .Top = 191
3849:             .Left = 17
3850:             .Width = 156
3851:             .Height = 17
3852:             .FontName = "Tahoma"
3853:             .FontSize = 8
3854:             .ForeColor = RGB(90,90,90)
3855:             .BackStyle = 0
3856:             .Alignment = 1
3857:             .Visible = .T.
3858:         ENDWITH
3859: 
3860:         par_oPg.AddObject("Opt_GBals", "OptionGroup")
3861:         loc_oOpt = par_oPg.Opt_GBals
3862:         WITH loc_oOpt
3863:             .ButtonCount = 2
3864:             .Top = 191
3865:             .Left = 174
3866:             .Width = 92
3867:             .Height = 25
3868:             .BackStyle = 0
3869:             .BorderStyle = 0
3870:             .Value = 1
3871:             .Visible = .T.
3872:         ENDWITH
3873:         loc_oOpt.Buttons(1).Caption = "Sim"
3874:         loc_oOpt.Buttons(1).Left = 5
3875:         loc_oOpt.Buttons(1).Top = 3
3876:         loc_oOpt.Buttons(1).Width = 40
3877:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3878:         loc_oOpt.Buttons(1).FontSize = 8
3879:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3880:         loc_oOpt.Buttons(1).Themes = .F.
3881:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3882:         loc_oOpt.Buttons(2).Left = 48
3883:         loc_oOpt.Buttons(2).Top = 3
3884:         loc_oOpt.Buttons(2).Width = 44
3885:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3886:         loc_oOpt.Buttons(2).FontSize = 8
3887:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3888:         loc_oOpt.Buttons(2).Themes = .F.
3889: 
3890:         *-- Grupo Dif Balanco
3891:         par_oPg.AddObject("lbl_4c_LblGrufals", "Label")
3892:         WITH par_oPg.lbl_4c_LblGrufals
3893:             .Caption = "Grupo Dif.Balan" + CHR(231) + "o:"
3894:             .Top = 216
3895:             .Left = 17
3896:             .Width = 156
3897:             .Height = 17
3898:             .FontName = "Tahoma"
3899:             .FontSize = 8
3900:             .ForeColor = RGB(90,90,90)

*-- Linhas 3919 a 3981:
3919:             .SpecialEffect = 0
3920:             .Visible = .T.
3921:         ENDWITH
3922:         BINDEVENT(par_oPg.Get_grupo, "KeyPress", THIS, "GrupoEstoqueKeyPress")
3923:         BINDEVENT(par_oPg.Get_grupo, "DblClick", THIS, "GrupoEstoqueDblClick")
3924: 
3925:         *-- Balanco Unificado (Opt_UnifBal, 4 btn)
3926:         par_oPg.AddObject("lbl_4c_LblUnifBal", "Label")
3927:         WITH par_oPg.lbl_4c_LblUnifBal
3928:             .Caption = "Balan" + CHR(231) + "o Unificado:"
3929:             .Top = 242
3930:             .Left = 17
3931:             .Width = 156
3932:             .Height = 17
3933:             .FontName = "Tahoma"
3934:             .FontSize = 8
3935:             .ForeColor = RGB(90,90,90)
3936:             .BackStyle = 0
3937:             .Alignment = 1
3938:             .Visible = .T.
3939:         ENDWITH
3940: 
3941:         par_oPg.AddObject("Opt_UnifBal", "OptionGroup")
3942:         loc_oOpt = par_oPg.Opt_UnifBal
3943:         WITH loc_oOpt
3944:             .ButtonCount = 4
3945:             .Top = 242
3946:             .Left = 174
3947:             .Width = 171
3948:             .Height = 43
3949:             .BackStyle = 0
3950:             .BorderStyle = 0
3951:             .Value = 1
3952:             .Visible = .T.
3953:         ENDWITH
3954:         loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
3955:         loc_oOpt.Buttons(1).Left = 5
3956:         loc_oOpt.Buttons(1).Top = 3
3957:         loc_oOpt.Buttons(1).Width = 40
3958:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3959:         loc_oOpt.Buttons(1).FontSize = 8
3960:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3961:         loc_oOpt.Buttons(1).Themes = .F.
3962:         loc_oOpt.Buttons(2).Caption = "Empresa"
3963:         loc_oOpt.Buttons(2).Left = 50
3964:         loc_oOpt.Buttons(2).Top = 3
3965:         loc_oOpt.Buttons(2).Width = 60
3966:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3967:         loc_oOpt.Buttons(2).FontSize = 8
3968:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3969:         loc_oOpt.Buttons(2).Themes = .F.
3970:         loc_oOpt.Buttons(3).Caption = "Grupo"
3971:         loc_oOpt.Buttons(3).Left = 115
3972:         loc_oOpt.Buttons(3).Top = 3
3973:         loc_oOpt.Buttons(3).Width = 50
3974:         loc_oOpt.Buttons(3).FontName = "Tahoma"
3975:         loc_oOpt.Buttons(3).FontSize = 8
3976:         loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
3977:         loc_oOpt.Buttons(3).Themes = .F.
3978:         loc_oOpt.Buttons(4).Caption = "Ambos"
3979:         loc_oOpt.Buttons(4).Left = 5
3980:         loc_oOpt.Buttons(4).Top = 23
3981:         loc_oOpt.Buttons(4).Width = 50

*-- Linhas 4000 a 4412:
4000:             .Visible = .T.
4001:         ENDWITH
4002: 
4003:         par_oPg.AddObject("Opt_FalPers", "OptionGroup")
4004:         loc_oOpt = par_oPg.Opt_FalPers
4005:         WITH loc_oOpt
4006:             .ButtonCount = 2
4007:             .Top = 285
4008:             .Left = 174
4009:             .Width = 92
4010:             .Height = 25
4011:             .BackStyle = 0
4012:             .BorderStyle = 0
4013:             .Value = 1
4014:             .Visible = .T.
4015:         ENDWITH
4016:         loc_oOpt.Buttons(1).Caption = "Sim"
4017:         loc_oOpt.Buttons(1).Left = 5
4018:         loc_oOpt.Buttons(1).Top = 3
4019:         loc_oOpt.Buttons(1).Width = 40
4020:         loc_oOpt.Buttons(1).FontName = "Tahoma"
4021:         loc_oOpt.Buttons(1).FontSize = 8
4022:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
4023:         loc_oOpt.Buttons(1).Themes = .F.
4024:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
4025:         loc_oOpt.Buttons(2).Left = 48
4026:         loc_oOpt.Buttons(2).Top = 3
4027:         loc_oOpt.Buttons(2).Width = 44
4028:         loc_oOpt.Buttons(2).FontName = "Tahoma"
4029:         loc_oOpt.Buttons(2).FontSize = 8
4030:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
4031:         loc_oOpt.Buttons(2).Themes = .F.
4032: 
4033:         *-- Bloqueia Divisao OF (Opt_BlqDivOp)
4034:         par_oPg.AddObject("lbl_4c_LblBlqDivOp", "Label")
4035:         WITH par_oPg.lbl_4c_LblBlqDivOp
4036:             .Caption = "Bloqueia Divis" + CHR(227) + "o OF:"
4037:             .Top = 311
4038:             .Left = 17
4039:             .Width = 156
4040:             .Height = 17
4041:             .FontName = "Tahoma"
4042:             .FontSize = 8
4043:             .ForeColor = RGB(90,90,90)
4044:             .BackStyle = 0
4045:             .Alignment = 1
4046:             .Visible = .T.
4047:         ENDWITH
4048: 
4049:         par_oPg.AddObject("Opt_BlqDivOp", "OptionGroup")
4050:         loc_oOpt = par_oPg.Opt_BlqDivOp
4051:         WITH loc_oOpt
4052:             .ButtonCount = 2
4053:             .Top = 311
4054:             .Left = 174
4055:             .Width = 92
4056:             .Height = 25
4057:             .BackStyle = 0
4058:             .BorderStyle = 0
4059:             .Value = 1
4060:             .Visible = .T.
4061:         ENDWITH
4062:         loc_oOpt.Buttons(1).Caption = "Sim"
4063:         loc_oOpt.Buttons(1).Left = 5
4064:         loc_oOpt.Buttons(1).Top = 3
4065:         loc_oOpt.Buttons(1).Width = 40
4066:         loc_oOpt.Buttons(1).FontName = "Tahoma"
4067:         loc_oOpt.Buttons(1).FontSize = 8
4068:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
4069:         loc_oOpt.Buttons(1).Themes = .F.
4070:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
4071:         loc_oOpt.Buttons(2).Left = 48
4072:         loc_oOpt.Buttons(2).Top = 3
4073:         loc_oOpt.Buttons(2).Width = 44
4074:         loc_oOpt.Buttons(2).FontName = "Tahoma"
4075:         loc_oOpt.Buttons(2).FontSize = 8
4076:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
4077:         loc_oOpt.Buttons(2).Themes = .F.
4078: 
4079:         *-- OS - Data de Entrega (Get_OsPend)
4080:         par_oPg.AddObject("lbl_4c_LblOsPend", "Label")
4081:         WITH par_oPg.lbl_4c_LblOsPend
4082:             .Caption = "OS Pendente Dt.Entrega:"
4083:             .Top = 335
4084:             .Left = 17
4085:             .Width = 156
4086:             .Height = 17
4087:             .FontName = "Tahoma"
4088:             .FontSize = 8
4089:             .ForeColor = RGB(90,90,90)
4090:             .BackStyle = 0
4091:             .Alignment = 1
4092:             .Visible = .T.
4093:         ENDWITH
4094: 
4095:         par_oPg.AddObject("Get_OsPend", "OptionGroup")
4096:         loc_oOpt = par_oPg.Get_OsPend
4097:         WITH loc_oOpt
4098:             .ButtonCount = 2
4099:             .Top = 335
4100:             .Left = 174
4101:             .Width = 92
4102:             .Height = 25
4103:             .BackStyle = 0
4104:             .BorderStyle = 0
4105:             .Value = 1
4106:             .Visible = .T.
4107:         ENDWITH
4108:         loc_oOpt.Buttons(1).Caption = "Sim"
4109:         loc_oOpt.Buttons(1).Left = 5
4110:         loc_oOpt.Buttons(1).Top = 3
4111:         loc_oOpt.Buttons(1).Width = 40
4112:         loc_oOpt.Buttons(1).FontName = "Tahoma"
4113:         loc_oOpt.Buttons(1).FontSize = 8
4114:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
4115:         loc_oOpt.Buttons(1).Themes = .F.
4116:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
4117:         loc_oOpt.Buttons(2).Left = 48
4118:         loc_oOpt.Buttons(2).Top = 3
4119:         loc_oOpt.Buttons(2).Width = 44
4120:         loc_oOpt.Buttons(2).FontName = "Tahoma"
4121:         loc_oOpt.Buttons(2).FontSize = 8
4122:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
4123:         loc_oOpt.Buttons(2).Themes = .F.
4124: 
4125:         *-- Checa Dup Titulo (ObjDupTit)
4126:         par_oPg.AddObject("lbl_4c_LblDupTit", "Label")
4127:         WITH par_oPg.lbl_4c_LblDupTit
4128:             .Caption = "Checa Dup.T" + CHR(237) + "tulo:"
4129:             .Top = 361
4130:             .Left = 17
4131:             .Width = 156
4132:             .Height = 17
4133:             .FontName = "Tahoma"
4134:             .FontSize = 8
4135:             .ForeColor = RGB(90,90,90)
4136:             .BackStyle = 0
4137:             .Alignment = 1
4138:             .Visible = .T.
4139:         ENDWITH
4140: 
4141:         par_oPg.AddObject("ObjDupTit", "OptionGroup")
4142:         loc_oOpt = par_oPg.ObjDupTit
4143:         WITH loc_oOpt
4144:             .ButtonCount = 2
4145:             .Top = 361
4146:             .Left = 174
4147:             .Width = 92
4148:             .Height = 25
4149:             .BackStyle = 0
4150:             .BorderStyle = 0
4151:             .Value = 1
4152:             .Visible = .T.
4153:         ENDWITH
4154:         loc_oOpt.Buttons(1).Caption = "Sim"
4155:         loc_oOpt.Buttons(1).Left = 5
4156:         loc_oOpt.Buttons(1).Top = 3
4157:         loc_oOpt.Buttons(1).Width = 40
4158:         loc_oOpt.Buttons(1).FontName = "Tahoma"
4159:         loc_oOpt.Buttons(1).FontSize = 8
4160:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
4161:         loc_oOpt.Buttons(1).Themes = .F.
4162:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
4163:         loc_oOpt.Buttons(2).Left = 48
4164:         loc_oOpt.Buttons(2).Top = 3
4165:         loc_oOpt.Buttons(2).Width = 44
4166:         loc_oOpt.Buttons(2).FontName = "Tahoma"
4167:         loc_oOpt.Buttons(2).FontSize = 8
4168:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
4169:         loc_oOpt.Buttons(2).Themes = .F.
4170: 
4171:         *-- Col direita: saldo/relevante/etc (Left 469)
4172:         *-- Calcular Saldo (Opt_Saldo)
4173:         par_oPg.AddObject("lbl_4c_LblSaldo", "Label")
4174:         WITH par_oPg.lbl_4c_LblSaldo
4175:             .Caption = "Calcular Saldo:"
4176:             .Top = 29
4177:             .Left = 290
4178:             .Width = 178
4179:             .Height = 17
4180:             .FontName = "Tahoma"
4181:             .FontSize = 8
4182:             .ForeColor = RGB(90,90,90)
4183:             .BackStyle = 0
4184:             .Alignment = 1
4185:             .Visible = .T.
4186:         ENDWITH
4187: 
4188:         par_oPg.AddObject("Opt_Saldo", "OptionGroup")
4189:         loc_oOpt = par_oPg.Opt_Saldo
4190:         WITH loc_oOpt
4191:             .ButtonCount = 2
4192:             .Top = 29
4193:             .Left = 469
4194:             .Width = 149
4195:             .Height = 25
4196:             .BackStyle = 0
4197:             .BorderStyle = 0
4198:             .Value = 1
4199:             .Visible = .T.
4200:         ENDWITH
4201:         loc_oOpt.Buttons(1).Caption = "Sim"
4202:         loc_oOpt.Buttons(1).Left = 5
4203:         loc_oOpt.Buttons(1).Top = 3
4204:         loc_oOpt.Buttons(1).Width = 40
4205:         loc_oOpt.Buttons(1).FontName = "Tahoma"
4206:         loc_oOpt.Buttons(1).FontSize = 8
4207:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
4208:         loc_oOpt.Buttons(1).Themes = .F.
4209:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
4210:         loc_oOpt.Buttons(2).Left = 48
4211:         loc_oOpt.Buttons(2).Top = 3
4212:         loc_oOpt.Buttons(2).Width = 44
4213:         loc_oOpt.Buttons(2).FontName = "Tahoma"
4214:         loc_oOpt.Buttons(2).FontSize = 8
4215:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
4216:         loc_oOpt.Buttons(2).Themes = .F.
4217: 
4218:         *-- Empresa Relevante (Opt_Relevante)
4219:         par_oPg.AddObject("lbl_4c_LblRelev", "Label")
4220:         WITH par_oPg.lbl_4c_LblRelev
4221:             .Caption = "Empresa Relevante:"
4222:             .Top = 53
4223:             .Left = 290
4224:             .Width = 178
4225:             .Height = 17
4226:             .FontName = "Tahoma"
4227:             .FontSize = 8
4228:             .ForeColor = RGB(90,90,90)
4229:             .BackStyle = 0
4230:             .Alignment = 1
4231:             .Visible = .T.
4232:         ENDWITH
4233: 
4234:         par_oPg.AddObject("Opt_Relevante", "OptionGroup")
4235:         loc_oOpt = par_oPg.Opt_Relevante
4236:         WITH loc_oOpt
4237:             .ButtonCount = 2
4238:             .Top = 53
4239:             .Left = 469
4240:             .Width = 149
4241:             .Height = 25
4242:             .BackStyle = 0
4243:             .BorderStyle = 0
4244:             .Value = 1
4245:             .Visible = .T.
4246:         ENDWITH
4247:         loc_oOpt.Buttons(1).Caption = "Sim"
4248:         loc_oOpt.Buttons(1).Left = 5
4249:         loc_oOpt.Buttons(1).Top = 3
4250:         loc_oOpt.Buttons(1).Width = 40
4251:         loc_oOpt.Buttons(1).FontName = "Tahoma"
4252:         loc_oOpt.Buttons(1).FontSize = 8
4253:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
4254:         loc_oOpt.Buttons(1).Themes = .F.
4255:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
4256:         loc_oOpt.Buttons(2).Left = 48
4257:         loc_oOpt.Buttons(2).Top = 3
4258:         loc_oOpt.Buttons(2).Width = 44
4259:         loc_oOpt.Buttons(2).FontName = "Tahoma"
4260:         loc_oOpt.Buttons(2).FontSize = 8
4261:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
4262:         loc_oOpt.Buttons(2).Themes = .F.
4263: 
4264:         *-- Bloqueia Consulta GV (Opt_BlqConGV)
4265:         par_oPg.AddObject("lbl_4c_LblBlqConGV", "Label")
4266:         WITH par_oPg.lbl_4c_LblBlqConGV
4267:             .Caption = "Bloqueia Consulta GV:"
4268:             .Top = 77
4269:             .Left = 290
4270:             .Width = 178
4271:             .Height = 17
4272:             .FontName = "Tahoma"
4273:             .FontSize = 8
4274:             .ForeColor = RGB(90,90,90)
4275:             .BackStyle = 0
4276:             .Alignment = 1
4277:             .Visible = .T.
4278:         ENDWITH
4279: 
4280:         par_oPg.AddObject("Opt_BlqConGV", "OptionGroup")
4281:         loc_oOpt = par_oPg.Opt_BlqConGV
4282:         WITH loc_oOpt
4283:             .ButtonCount = 2
4284:             .Top = 77
4285:             .Left = 469
4286:             .Width = 149
4287:             .Height = 25
4288:             .BackStyle = 0
4289:             .BorderStyle = 0
4290:             .Value = 1
4291:             .Visible = .T.
4292:         ENDWITH
4293:         loc_oOpt.Buttons(1).Caption = "Sim"
4294:         loc_oOpt.Buttons(1).Left = 5
4295:         loc_oOpt.Buttons(1).Top = 3
4296:         loc_oOpt.Buttons(1).Width = 40
4297:         loc_oOpt.Buttons(1).FontName = "Tahoma"
4298:         loc_oOpt.Buttons(1).FontSize = 8
4299:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
4300:         loc_oOpt.Buttons(1).Themes = .F.
4301:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
4302:         loc_oOpt.Buttons(2).Left = 48
4303:         loc_oOpt.Buttons(2).Top = 3
4304:         loc_oOpt.Buttons(2).Width = 44
4305:         loc_oOpt.Buttons(2).FontName = "Tahoma"
4306:         loc_oOpt.Buttons(2).FontSize = 8
4307:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
4308:         loc_oOpt.Buttons(2).Themes = .F.
4309: 
4310:         *-- Patrimonialpor Etiq (Opt_Patrim)
4311:         par_oPg.AddObject("lbl_4c_LblPatrim", "Label")
4312:         WITH par_oPg.lbl_4c_LblPatrim
4313:             .Caption = "Patrimonial/Etiqueta:"
4314:             .Top = 101
4315:             .Left = 290
4316:             .Width = 178
4317:             .Height = 17
4318:             .FontName = "Tahoma"
4319:             .FontSize = 8
4320:             .ForeColor = RGB(90,90,90)
4321:             .BackStyle = 0
4322:             .Alignment = 1
4323:             .Visible = .T.
4324:         ENDWITH
4325: 
4326:         par_oPg.AddObject("Opt_Patrim", "OptionGroup")
4327:         loc_oOpt = par_oPg.Opt_Patrim
4328:         WITH loc_oOpt
4329:             .ButtonCount = 2
4330:             .Top = 101
4331:             .Left = 469
4332:             .Width = 149
4333:             .Height = 25
4334:             .BackStyle = 0
4335:             .BorderStyle = 0
4336:             .Value = 1
4337:             .Visible = .T.
4338:         ENDWITH
4339:         loc_oOpt.Buttons(1).Caption = "Sim"
4340:         loc_oOpt.Buttons(1).Left = 5
4341:         loc_oOpt.Buttons(1).Top = 3
4342:         loc_oOpt.Buttons(1).Width = 40
4343:         loc_oOpt.Buttons(1).FontName = "Tahoma"
4344:         loc_oOpt.Buttons(1).FontSize = 8
4345:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
4346:         loc_oOpt.Buttons(1).Themes = .F.
4347:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
4348:         loc_oOpt.Buttons(2).Left = 48
4349:         loc_oOpt.Buttons(2).Top = 3
4350:         loc_oOpt.Buttons(2).Width = 44
4351:         loc_oOpt.Buttons(2).FontName = "Tahoma"
4352:         loc_oOpt.Buttons(2).FontSize = 8
4353:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
4354:         loc_oOpt.Buttons(2).Themes = .F.
4355: 
4356:         *-- Tipo Inventario (OpTipoInvs, 3 btn)
4357:         par_oPg.AddObject("lbl_4c_LblTipoInv", "Label")
4358:         WITH par_oPg.lbl_4c_LblTipoInv
4359:             .Caption = "Tipo Invent" + CHR(225) + "rio:"
4360:             .Top = 125
4361:             .Left = 290
4362:             .Width = 178
4363:             .Height = 17
4364:             .FontName = "Tahoma"
4365:             .FontSize = 8
4366:             .ForeColor = RGB(90,90,90)
4367:             .BackStyle = 0
4368:             .Alignment = 1
4369:             .Visible = .T.
4370:         ENDWITH
4371: 
4372:         par_oPg.AddObject("OpTipoInvs", "OptionGroup")
4373:         loc_oOpt = par_oPg.OpTipoInvs
4374:         WITH loc_oOpt
4375:             .ButtonCount = 3
4376:             .Top = 125
4377:             .Left = 470
4378:             .Width = 371
4379:             .Height = 25
4380:             .BackStyle = 0
4381:             .BorderStyle = 0
4382:             .Value = 1
4383:             .Visible = .T.
4384:         ENDWITH
4385:         loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
4386:         loc_oOpt.Buttons(1).Left = 5
4387:         loc_oOpt.Buttons(1).Top = 3
4388:         loc_oOpt.Buttons(1).Width = 44
4389:         loc_oOpt.Buttons(1).FontName = "Tahoma"
4390:         loc_oOpt.Buttons(1).FontSize = 8
4391:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
4392:         loc_oOpt.Buttons(1).Themes = .F.
4393:         loc_oOpt.Buttons(2).Caption = "Inventario"
4394:         loc_oOpt.Buttons(2).Left = 54
4395:         loc_oOpt.Buttons(2).Top = 3
4396:         loc_oOpt.Buttons(2).Width = 80
4397:         loc_oOpt.Buttons(2).FontName = "Tahoma"
4398:         loc_oOpt.Buttons(2).FontSize = 8
4399:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
4400:         loc_oOpt.Buttons(2).Themes = .F.
4401:         loc_oOpt.Buttons(3).Caption = "Coletor"
4402:         loc_oOpt.Buttons(3).Left = 139
4403:         loc_oOpt.Buttons(3).Top = 3
4404:         loc_oOpt.Buttons(3).Width = 60
4405:         loc_oOpt.Buttons(3).FontName = "Tahoma"
4406:         loc_oOpt.Buttons(3).FontSize = 8
4407:         loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
4408:         loc_oOpt.Buttons(3).Themes = .F.
4409: 
4410:         *-- Diferenca de Peso
4411:         par_oPg.AddObject("lbl_4c_LblDifPeso", "Label")
4412:         WITH par_oPg.lbl_4c_LblDifPeso

*-- Linhas 4601 a 4644:
4601:             .Visible = .T.
4602:         ENDWITH
4603: 
4604:         par_oPg.AddObject("Chk_TrfPeso", "OptionGroup")
4605:         loc_oOpt = par_oPg.Chk_TrfPeso
4606:         WITH loc_oOpt
4607:             .ButtonCount = 5
4608:             .Top = 216
4609:             .Left = 474
4610:             .Width = 186
4611:             .Height = 95
4612:             .BackStyle = 0
4613:             .BorderStyle = 0
4614:             .Value = 1
4615:             .Visible = .T.
4616:         ENDWITH
4617:         loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
4618:         loc_oOpt.Buttons(1).Left = 5
4619:         loc_oOpt.Buttons(1).Top = 3
4620:         loc_oOpt.Buttons(1).Width = 80
4621:         loc_oOpt.Buttons(1).FontName = "Tahoma"
4622:         loc_oOpt.Buttons(1).FontSize = 8
4623:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
4624:         loc_oOpt.Buttons(1).Themes = .F.
4625:         loc_oOpt.Buttons(2).Caption = "Por Kg"
4626:         loc_oOpt.Buttons(2).Left = 5
4627:         loc_oOpt.Buttons(2).Top = 20
4628:         loc_oOpt.Buttons(2).Width = 80
4629:         loc_oOpt.Buttons(2).FontName = "Tahoma"
4630:         loc_oOpt.Buttons(2).FontSize = 8
4631:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
4632:         loc_oOpt.Buttons(2).Themes = .F.
4633:         loc_oOpt.Buttons(3).Caption = "Por Un"
4634:         loc_oOpt.Buttons(3).Left = 5
4635:         loc_oOpt.Buttons(3).Top = 38
4636:         loc_oOpt.Buttons(3).Width = 80
4637:         loc_oOpt.Buttons(3).FontName = "Tahoma"
4638:         loc_oOpt.Buttons(3).FontSize = 8
4639:         loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
4640:         loc_oOpt.Buttons(3).Themes = .F.
4641:         loc_oOpt.Buttons(4).Caption = "Por Kg (%)"
4642:         loc_oOpt.Buttons(4).Left = 5
4643:         loc_oOpt.Buttons(4).Top = 56
4644:         loc_oOpt.Buttons(4).Width = 80

*-- Linhas 4671 a 4714:
4671:             .Visible = .T.
4672:         ENDWITH
4673: 
4674:         par_oPg.AddObject("op_compagru", "OptionGroup")
4675:         loc_oOpt = par_oPg.op_compagru
4676:         WITH loc_oOpt
4677:             .ButtonCount = 3
4678:             .Top = 337
4679:             .Left = 474
4680:             .Width = 186
4681:             .Height = 21
4682:             .BackStyle = 0
4683:             .BorderStyle = 0
4684:             .Value = 1
4685:             .Visible = .T.
4686:         ENDWITH
4687:         loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
4688:         loc_oOpt.Buttons(1).Left = 5
4689:         loc_oOpt.Buttons(1).Top = 3
4690:         loc_oOpt.Buttons(1).Width = 44
4691:         loc_oOpt.Buttons(1).FontName = "Tahoma"
4692:         loc_oOpt.Buttons(1).FontSize = 8
4693:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
4694:         loc_oOpt.Buttons(1).Themes = .F.
4695:         loc_oOpt.Buttons(2).Caption = "Tipo"
4696:         loc_oOpt.Buttons(2).Left = 54
4697:         loc_oOpt.Buttons(2).Top = 3
4698:         loc_oOpt.Buttons(2).Width = 50
4699:         loc_oOpt.Buttons(2).FontName = "Tahoma"
4700:         loc_oOpt.Buttons(2).FontSize = 8
4701:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
4702:         loc_oOpt.Buttons(2).Themes = .F.
4703:         loc_oOpt.Buttons(3).Caption = "Produto"
4704:         loc_oOpt.Buttons(3).Left = 109
4705:         loc_oOpt.Buttons(3).Top = 3
4706:         loc_oOpt.Buttons(3).Width = 60
4707:         loc_oOpt.Buttons(3).FontName = "Tahoma"
4708:         loc_oOpt.Buttons(3).FontSize = 8
4709:         loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
4710:         loc_oOpt.Buttons(3).Themes = .F.
4711: 
4712:         *-- Agrupamento
4713:         par_oPg.AddObject("lbl_4c_LblAgrupa", "Label")
4714:         WITH par_oPg.lbl_4c_LblAgrupa

*-- Linhas 4758 a 4801:
4758:             .Visible = .T.
4759:         ENDWITH
4760: 
4761:         par_oPg.AddObject("Fwoption1", "OptionGroup")
4762:         loc_oOpt = par_oPg.Fwoption1
4763:         WITH loc_oOpt
4764:             .ButtonCount = 3
4765:             .Top = 390
4766:             .Left = 474
4767:             .Width = 164
4768:             .Height = 21
4769:             .BackStyle = 0
4770:             .BorderStyle = 0
4771:             .Value = 1
4772:             .Visible = .T.
4773:         ENDWITH
4774:         loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
4775:         loc_oOpt.Buttons(1).Left = 5
4776:         loc_oOpt.Buttons(1).Top = 3
4777:         loc_oOpt.Buttons(1).Width = 44
4778:         loc_oOpt.Buttons(1).FontName = "Tahoma"
4779:         loc_oOpt.Buttons(1).FontSize = 8
4780:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
4781:         loc_oOpt.Buttons(1).Themes = .F.
4782:         loc_oOpt.Buttons(2).Caption = "Simples"
4783:         loc_oOpt.Buttons(2).Left = 54
4784:         loc_oOpt.Buttons(2).Top = 3
4785:         loc_oOpt.Buttons(2).Width = 60
4786:         loc_oOpt.Buttons(2).FontName = "Tahoma"
4787:         loc_oOpt.Buttons(2).FontSize = 8
4788:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
4789:         loc_oOpt.Buttons(2).Themes = .F.
4790:         loc_oOpt.Buttons(3).Caption = "Completo"
4791:         loc_oOpt.Buttons(3).Left = 119
4792:         loc_oOpt.Buttons(3).Top = 3
4793:         loc_oOpt.Buttons(3).Width = 65
4794:         loc_oOpt.Buttons(3).FontName = "Tahoma"
4795:         loc_oOpt.Buttons(3).FontSize = 8
4796:         loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
4797:         loc_oOpt.Buttons(3).Themes = .F.
4798: 
4799:         *-- Os/Alianca/Fundicao checkboxes (Container1)
4800:         par_oPg.AddObject("cnt_4c_OsAlfun", "Container")
4801:         WITH par_oPg.cnt_4c_OsAlfun

*-- Linhas 4859 a 4902:
4859:     * CriarAbaFaturamento - Controles da aba Faturamento (pgf_4c_1.Page4)
4860:     * 9 containers de impostos
4861:     *--------------------------------------------------------------------------
4862:     PROTECTED PROCEDURE CriarAbaFaturamento(par_oPg)
4863:         LOCAL loc_aCfg, loc_nI, loc_oCnt
4864:         LOCAL loc_cNome, loc_cProp, loc_nTop
4865: 
4866:         *-- Shapes de fundo (borda e separadores de coluna)
4867:         par_oPg.AddObject("shp_4c_Border", "Shape")
4868:         WITH par_oPg.shp_4c_Border
4869:             .Top           = 50
4870:             .Left          = 45
4871:             .Width         = 673
4872:             .Height        = 261
4873:             .BackStyle     = 0
4874:             .SpecialEffect = 1
4875:             .BorderColor   = RGB(90, 90, 90)
4876:             .Visible       = .T.
4877:         ENDWITH
4878: 
4879:         par_oPg.AddObject("shp_4c_ColGrupo", "Shape")
4880:         WITH par_oPg.shp_4c_ColGrupo
4881:             .Top           = 50
4882:             .Left          = 106
4883:             .Width         = 90
4884:             .Height        = 261
4885:             .BackStyle     = 0
4886:             .SpecialEffect = 1
4887:             .BorderColor   = RGB(90, 90, 90)
4888:             .Visible       = .T.
4889:         ENDWITH
4890: 
4891:         par_oPg.AddObject("shp_4c_HdrLine", "Shape")
4892:         WITH par_oPg.shp_4c_HdrLine
4893:             .Top           = 71
4894:             .Left          = 45
4895:             .Width         = 671
4896:             .Height        = 1
4897:             .BackStyle     = 0
4898:             .SpecialEffect = 1
4899:             .BorderColor   = RGB(90, 90, 90)
4900:             .Visible       = .T.
4901:         ENDWITH
4902: 

*-- Linhas 5156 a 5367:
5156:                 .SpecialEffect = 1
5157:                 .Visible = .T.
5158:             ENDWITH
5159:             BINDEVENT(loc_oCnt.getCdGrupos, "GotFocus",  THIS, "GrupoFatGotFocus")
5160:             BINDEVENT(loc_oCnt.getCdGrupos, "KeyPress",  THIS, "GrupoFatKeyPress")
5161:             BINDEVENT(loc_oCnt.getCdGrupos, "DblClick",  THIS, "GrupoFatDblClick")
5162:             BINDEVENT(loc_oCnt.getCdGrupos, "KeyPress", THIS, "GrupoFatLostFocus")
5163:             BINDEVENT(loc_oCnt.getCdContas, "GotFocus",  THIS, "ContaFatGotFocus")
5164:             BINDEVENT(loc_oCnt.getCdContas, "KeyPress",  THIS, "ContaFatKeyPress")
5165:             BINDEVENT(loc_oCnt.getCdContas, "DblClick",  THIS, "ContaFatDblClick")
5166:             BINDEVENT(loc_oCnt.getCdContas, "KeyPress", THIS, "ContaFatLostFocus")
5167:         ENDFOR
5168:     ENDPROC
5169: 
5170:     *--------------------------------------------------------------------------
5171:     * CarregarLista - Popula cursor_4c_Dados e atualiza grd_4c_Lista
5172:     *--------------------------------------------------------------------------
5173:     PROCEDURE CarregarLista()
5174:         LOCAL loc_lResultado
5175:         loc_lResultado = .F.
5176: 
5177:         TRY
5178:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
5179:                 IF USED("cursor_4c_Dados")
5180:                     USE IN cursor_4c_Dados
5181:                 ENDIF
5182:                 CREATE CURSOR cursor_4c_Dados (codigos C(10), descrs C(40))
5183:                 loc_lResultado = .T.
5184:             ELSE
5185:                 IF THIS.this_oBusinessObject.Buscar("")
5186:                     THIS.AtualizarGrid()
5187:                     loc_lResultado = .T.
5188:                 ENDIF
5189:             ENDIF
5190:         CATCH TO loc_oErro
5191:             MsgErro(loc_oErro.Message, "Formccr.CarregarLista")
5192:             loc_lResultado = .F.
5193:         ENDTRY
5194: 
5195:         RETURN loc_lResultado
5196:     ENDPROC
5197: 
5198:     *--------------------------------------------------------------------------
5199:     * AtualizarGrid - Wire RecordSource e colunas do grd_4c_Lista
5200:     *--------------------------------------------------------------------------
5201:     PROTECTED PROCEDURE AtualizarGrid()
5202:         LOCAL loc_oGrid
5203:         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
5204: 
5205:         loc_oGrid.ColumnCount = 2
5206:         loc_oGrid.RecordSource = "cursor_4c_Dados"
5207:         loc_oGrid.ColumnCount  = 2
5208: 
5209:         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
5210:         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
5211: 
5212:         loc_oGrid.Column1.Width = 120
5213:         loc_oGrid.Column2.Width = 400
5214: 
5215:         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
5216:         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
5217:     ENDPROC
5218: 
5219:     *--------------------------------------------------------------------------
5220:     * AlternarPagina - Navega entre Page1 (Lista=1) e Page2 (Dados=2)
5221:     *--------------------------------------------------------------------------
5222:     PROCEDURE AlternarPagina(par_nPagina)
5223:         LOCAL loc_lResultado
5224:         loc_lResultado = .F.
5225: 
5226:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
5227:             RETURN .F.
5228:         ENDIF
5229: 
5230:         TRY
5231:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
5232: 
5233:             IF par_nPagina = 1
5234:                 THIS.this_cModoAtual = "LISTA"
5235:                 THIS.CarregarLista()
5236:             ENDIF
5237: 
5238:             loc_lResultado = .T.
5239:         CATCH TO loc_oErro
5240:             MsgErro(loc_oErro.Message, "Formccr.AlternarPagina")
5241:         ENDTRY
5242: 
5243:         RETURN loc_lResultado
5244:     ENDPROC
5245: 
5246:     *--------------------------------------------------------------------------
5247:     * AjustarBotoesPorModo - Habilita/desabilita Confirmar conforme modo
5248:     *--------------------------------------------------------------------------
5249:     PROCEDURE AjustarBotoesPorModo()
5250:         LOCAL loc_oPg2, loc_lEdicao
5251:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
5252:         loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
5253: 
5254:         IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
5255:             IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
5256:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEdicao
5257:             ENDIF
5258:         ENDIF
5259:     ENDPROC
5260: 
5261:     *--------------------------------------------------------------------------
5262:     * LimparDados - Limpa valores dos campos da Page2
5263:     *--------------------------------------------------------------------------
5264:     PROTECTED PROCEDURE LimparDados()
5265:         LOCAL loc_oPg2
5266:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
5267: 
5268:         TRY
5269:             loc_oPg2.txt_4c_Codigo.Value = ""
5270:             loc_oPg2.txt_4c_Digito.Value = ""
5271:             loc_oPg2.txt_4c_Descr.Value  = ""
5272:             loc_oPg2.txt_4c_Interno.Value = ""
5273:             loc_oPg2.txt_4c_Classes.Value = ""
5274:             loc_oPg2.txt_4c_DClasses.Value = ""
5275:             loc_oPg2.obj_4c_Opt_TpCods.Value = 1
5276:             loc_oPg2.obj_4c_Opt_TpEmps.Value = 1
5277:             loc_oPg2.obj_4c_Opt_TpCads.Value = 1
5278:             THIS.LimparAbaGeral(loc_oPg2)
5279:             THIS.LimparAbaCadastro(loc_oPg2)
5280:             THIS.LimparAbaEstoque(loc_oPg2)
5281:             THIS.LimparAbaFaturamento(loc_oPg2)
5282:         CATCH TO loc_oErro
5283:             MsgErro(loc_oErro.Message, "LimparDados")
5284:         ENDTRY
5285:     ENDPROC
5286: 
5287:     *--------------------------------------------------------------------------
5288:     * LimparAbaGeral
5289:     *--------------------------------------------------------------------------
5290:     PROTECTED PROCEDURE LimparAbaGeral(par_oPg2)
5291:         LOCAL loc_oPgAba
5292:         loc_oPgAba = par_oPg2.pgf_4c_1.Page1
5293: 
5294:         TRY
5295:             loc_oPgAba.obj_4c_Opt_Comple.Value    = 1
5296:             loc_oPgAba.obj_4c_Opt_Pessoais.Value  = 1
5297:             loc_oPgAba.obj_4c_Opt_RefBancs.Value  = 1
5298:             loc_oPgAba.obj_4c_Opt_FollowUp.Value  = 1
5299:             loc_oPgAba.obj_4c_Opt_Fiscais.Value   = 1
5300:             loc_oPgAba.obj_4c_Opt_Empresa.Value   = 1
5301:             loc_oPgAba.obj_4c_Opt_Contabs.Value   = 1
5302:             loc_oPgAba.obj_4c_Opt_Caracteris.Value = 1
5303:             loc_oPgAba.obj_4c_Fwoption1.Value     = 1
5304:             loc_oPgAba.obj_4c_Fwoption2.Value     = 1
5305:             loc_oPgAba.obj_4c_Opt_DadosCom.Value  = 1
5306:             loc_oPgAba.obj_4c_Opt_Respos.Value    = 1
5307:             loc_oPgAba.obj_4c_Opt_LimCre.Value    = 1
5308:             loc_oPgAba.obj_4c_Opt_Comi.Value      = 1
5309:             loc_oPgAba.obj_4c_Opt_Cargo.Value     = 1
5310:             loc_oPgAba.obj_4c_Opt_ChkLimCr.Value  = 1
5311:             loc_oPgAba.obj_4c_OptPreCad.Value     = 1
5312:             loc_oPgAba.obj_4c_Opt_Coletor.Value   = 1
5313:             loc_oPgAba.txt_4c_Vrlimc.Value = 0
5314:             loc_oPgAba.txt_4c__molimc.Value = ""
5315:             loc_oPgAba.txt_4c__cd_moeda.Value = ""
5316:             loc_oPgAba.txt_4c__ds_moeda.Value = ""
5317:             loc_oPgAba.txt_4c_Grupo.Value = ""
5318:             loc_oPgAba.obj_4c_GetRodRelCC.Value = ""
5319:         CATCH TO loc_oErro
5320:             MsgErro(loc_oErro.Message, "LimparAbaGeral")
5321:         ENDTRY
5322:     ENDPROC
5323: 
5324:     *--------------------------------------------------------------------------
5325:     * LimparAbaCadastro
5326:     *--------------------------------------------------------------------------
5327:     PROTECTED PROCEDURE LimparAbaCadastro(par_oPg2)
5328:         LOCAL loc_oPgAba
5329:         loc_oPgAba = par_oPg2.pgf_4c_1.Page2
5330: 
5331:         TRY
5332:             loc_oPgAba.Opt_CPFObrig.Value   = 1
5333:             loc_oPgAba.fwoption2.Value       = 1
5334:             loc_oPgAba.optCalcIMeds.Value    = 1
5335:             loc_oPgAba.getObrMails.Value     = 1
5336:             loc_oPgAba.getObrNome.Value      = 1
5337:             loc_oPgAba.Fwoption15.Value      = 1
5338:             loc_oPgAba.getObrSit.Value       = 1
5339:             loc_oPgAba.getObrTlm.Value       = 1
5340:             loc_oPgAba.getObrCla.Value       = 1
5341:             loc_oPgAba.getObrSeg.Value       = 1
5342:             loc_oPgAba.Fwoption6.Value       = 1
5343:             loc_oPgAba.Fwoption7.Value       = 1
5344:             loc_oPgAba.Fwoption12.Value      = 1
5345:             loc_oPgAba.Fwoption13.Value      = 1
5346:             loc_oPgAba.Fwoption14.Value      = 1
5347:             loc_oPgAba.Fwoption8.Value       = 1
5348:             loc_oPgAba.Fwoption9.Value       = 1
5349:             loc_oPgAba.Fwoption11.Value      = 1
5350:             loc_oPgAba.Fwoption10.Value      = 1
5351:             loc_oPgAba.Opt_CEPObrig.Value    = 1
5352:             loc_oPgAba.getObrIbge.Value      = 1
5353:             loc_oPgAba.Fwoption4.Value       = 1
5354:             loc_oPgAba.Fwoption5.Value       = 1
5355:             loc_oPgAba.Fwoption16.Value      = 1
5356:             loc_oPgAba.Opt_MFotos.Value      = 1
5357:             loc_oPgAba.fwoption1.Value       = 1
5358:             loc_oPgAba.optCpffixo.Value      = 1
5359:             loc_oPgAba.getSituas.Value       = ""
5360:             loc_oPgAba.optCarac.Value        = 1
5361:             loc_oPgAba.optAceJob.Value       = 1
5362:             loc_oPgAba.OptAlertaCad.Value    = 1
5363:             loc_oPgAba.Getcontint.Value      = ""
5364:             loc_oPgAba.Opt_Integ.Value       = 1
5365:             loc_oPgAba.Fwoption3.Value       = 1
5366:             loc_oPgAba.optVincPgRcs.Value    = 1
5367:             loc_oPgAba.OptTitBaixado.Value   = 1

*-- Linhas 5374 a 5527:
5374:     *--------------------------------------------------------------------------
5375:     * LimparAbaEstoque
5376:     *--------------------------------------------------------------------------
5377:     PROTECTED PROCEDURE LimparAbaEstoque(par_oPg2)
5378:         LOCAL loc_oPgAba
5379:         loc_oPgAba = par_oPg2.pgf_4c_1.Page3
5380: 
5381:         TRY
5382:             loc_oPgAba.Opt_LimEsto.Value   = 1
5383:             loc_oPgAba.Opt_VerEst.Value    = 1
5384:             loc_oPgAba.Opt_EstPAcab.Value  = 1
5385:             loc_oPgAba.opt_ChkLimest.Value = 1
5386:             loc_oPgAba.Opt_CCusto.Value    = 1
5387:             loc_oPgAba.Opt_GBals.Value     = 1
5388:             loc_oPgAba.Opt_UnifBal.Value   = 1
5389:             loc_oPgAba.Opt_FalPers.Value   = 1
5390:             loc_oPgAba.Opt_BlqDivOp.Value  = 1
5391:             loc_oPgAba.Opt_Saldo.Value     = 1
5392:             loc_oPgAba.Opt_Relevante.Value = 1
5393:             loc_oPgAba.Opt_BlqConGV.Value  = 1
5394:             loc_oPgAba.Opt_Patrim.Value    = 1
5395:             loc_oPgAba.OpTipoInvs.Value    = 1
5396:             loc_oPgAba.Chk_TrfPeso.Value   = 1
5397:             loc_oPgAba.op_compagru.Value   = 1
5398:             loc_oPgAba.Fwoption1.Value     = 1
5399:             loc_oPgAba.Get_OsPend.Value    = 1
5400:             loc_oPgAba.ObjDupTit.Value     = 1
5401:             loc_oPgAba.Get_grupo.Value     = ""
5402:             loc_oPgAba.Get_DifPeso.Value   = 0
5403:             loc_oPgAba.Get_Sinal.Value     = 1
5404:             loc_oPgAba.Get_tfalhas.Value   = ""
5405:             loc_oPgAba.Get_Agrupa.Value    = ""
5406:             loc_oPgAba.get_ddr.Value       = 0
5407:             loc_oPgAba.get_ddf.Value       = 0
5408:             loc_oPgAba.op_invisivel.Value  = 0
5409:             loc_oPgAba.cnt_4c_OsAlfun.chk_Os.Value       = 0
5410:             loc_oPgAba.cnt_4c_OsAlfun.chk_Alianca.Value  = 0
5411:             loc_oPgAba.cnt_4c_OsAlfun.chk_Fundicao.Value = 0
5412:         CATCH TO loc_oErro
5413:             MsgErro(loc_oErro.Message, "LimparAbaEstoque")
5414:         ENDTRY
5415:     ENDPROC
5416: 
5417:     *--------------------------------------------------------------------------
5418:     * LimparAbaFaturamento
5419:     *--------------------------------------------------------------------------
5420:     PROTECTED PROCEDURE LimparAbaFaturamento(par_oPg2)
5421:         LOCAL loc_oPgAba, loc_aCnt, loc_nI, loc_oCnt, loc_nIdx
5422:         loc_oPgAba = par_oPg2.pgf_4c_1.Page4
5423: 
5424:         DIMENSION loc_aCnt(9)
5425:         loc_aCnt(1) = "cntIC"
5426:         loc_aCnt(2) = "cntIP"
5427:         loc_aCnt(3) = "cntII"
5428:         loc_aCnt(4) = "cntIS"
5429:         loc_aCnt(5) = "cntIR"
5430:         loc_aCnt(6) = "cntIN"
5431:         loc_aCnt(7) = "cntPI"
5432:         loc_aCnt(8) = "cntCS"
5433:         loc_aCnt(9) = "cntCO"
5434: 
5435:         TRY
5436:             FOR loc_nI = 1 TO 9
5437:                 IF PEMSTATUS(loc_oPgAba, loc_aCnt(loc_nI), 5)
5438:                     loc_nIdx = THIS.ObterIndiceControle(loc_oPgAba, loc_aCnt(loc_nI))
5439:                     loc_oCnt = loc_oPgAba.Controls(loc_nIdx)
5440:                     IF VARTYPE(loc_oCnt) = "O"
5441:                         loc_oCnt.getCdGrupos.Value = ""
5442:                         loc_oCnt.getCdContas.Value = ""
5443:                         loc_oCnt.getDsContas.Value = ""
5444:                         loc_oCnt.getPctAliqs.Value = 0
5445:                         loc_oCnt.getReceitas.Value = ""
5446:                     ENDIF
5447:                 ENDIF
5448:             ENDFOR
5449:         CATCH TO loc_oErro
5450:             MsgErro(loc_oErro.Message, "LimparAbaFaturamento")
5451:         ENDTRY
5452:     ENDPROC
5453: 
5454:     *--------------------------------------------------------------------------
5455:     * HabilitarCampos - Habilita/desabilita campos conforme modo
5456:     *--------------------------------------------------------------------------
5457:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
5458:         LOCAL loc_oPg2, loc_lEdicao
5459:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
5460:         loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
5461: 
5462:         TRY
5463:             *-- Codigo: editavel somente em INCLUIR (PK nao muda em ALTERAR)
5464:             IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
5465:                 loc_oPg2.txt_4c_Codigo.ReadOnly = !(THIS.this_cModoAtual = "INCLUIR")
5466:             ENDIF
5467:             IF PEMSTATUS(loc_oPg2, "txt_4c_Digito", 5)
5468:                 loc_oPg2.txt_4c_Digito.ReadOnly = !loc_lEdicao
5469:             ENDIF
5470:             IF PEMSTATUS(loc_oPg2, "txt_4c_Descr", 5)
5471:                 loc_oPg2.txt_4c_Descr.ReadOnly = !loc_lEdicao
5472:             ENDIF
5473:             IF PEMSTATUS(loc_oPg2, "txt_4c_Interno", 5)
5474:                 loc_oPg2.txt_4c_Interno.ReadOnly = !loc_lEdicao
5475:             ENDIF
5476:             IF PEMSTATUS(loc_oPg2, "txt_4c_Classes", 5)
5477:                 loc_oPg2.txt_4c_Classes.ReadOnly = !loc_lEdicao
5478:             ENDIF
5479:         CATCH TO loc_oErro
5480:             MsgErro(loc_oErro.Message, "HabilitarCampos")
5481:         ENDTRY
5482:     ENDPROC
5483: 
5484:     *--------------------------------------------------------------------------
5485:     * BOParaForm - Transfere BO -> controles da Page2
5486:     *--------------------------------------------------------------------------
5487:     PROCEDURE BOParaForm()
5488:         LOCAL loc_oPg2, loc_oBO, loc_oPgAba, loc_cCfg, loc_nVal
5489:         LOCAL loc_aCnt, loc_nI, loc_oCnt, loc_cProp, loc_cFisStr
5490:         LOCAL loc_cConta, loc_nRet
5491:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
5492:         loc_oBO  = THIS.this_oBusinessObject
5493: 
5494:         TRY
5495:             *-- Identificacao basica
5496:             loc_oPg2.txt_4c_Codigo.Value  = ALLTRIM(loc_oBO.this_cCodigos)
5497:             loc_oPg2.txt_4c_Digito.Value  = ALLTRIM(loc_oBO.this_cDgcods)
5498:             loc_oPg2.txt_4c_Descr.Value   = ALLTRIM(loc_oBO.this_cDescrs)
5499:             loc_oPg2.txt_4c_Interno.Value = ALLTRIM(loc_oBO.this_cInternos)
5500:             loc_oPg2.txt_4c_Classes.Value = ALLTRIM(loc_oBO.this_cClasses)
5501:             loc_oPg2.txt_4c_DClasses.Value = ALLTRIM(loc_oBO.this_cDClasses)
5502: 
5503:             *-- Tipos (1-based index = valor numerico + 1)
5504:             loc_oPg2.obj_4c_Opt_TpCods.Value = IIF(loc_oBO.this_nTpcods = 0, 1, loc_oBO.this_nTpcods)
5505:             loc_oPg2.obj_4c_Opt_TpEmps.Value = IIF(loc_oBO.this_nTpemps = 0, 1, loc_oBO.this_nTpemps)
5506:             loc_oPg2.obj_4c_Opt_TpCads.Value = IIF(loc_oBO.this_nTpcads = 0, 1, loc_oBO.this_nTpcads)
5507: 
5508:             *-- Aba Geral
5509:             loc_oPgAba = loc_oPg2.pgf_4c_1.Page1
5510:             loc_oPgAba.obj_4c_Opt_Comple.Value    = IIF(loc_oBO.this_nComplems = 0, 1, loc_oBO.this_nComplems)
5511:             loc_oPgAba.obj_4c_Opt_Pessoais.Value  = IIF(loc_oBO.this_nPessoais = 0, 1, loc_oBO.this_nPessoais)
5512:             loc_oPgAba.obj_4c_Opt_RefBancs.Value  = IIF(loc_oBO.this_nRefbancs = 0, 1, loc_oBO.this_nRefbancs)
5513:             loc_oPgAba.obj_4c_Opt_FollowUp.Value  = IIF(loc_oBO.this_nFollowups = 0, 1, loc_oBO.this_nFollowups)
5514:             loc_oPgAba.obj_4c_Opt_Fiscais.Value   = IIF(loc_oBO.this_nFiscais = 0, 1, loc_oBO.this_nFiscais)
5515:             loc_oPgAba.obj_4c_Opt_Empresa.Value   = IIF(loc_oBO.this_nEmpresas = 0, 1, loc_oBO.this_nEmpresas)
5516:             loc_oPgAba.obj_4c_Opt_Contabs.Value   = IIF(loc_oBO.this_nContabs = 0, 1, loc_oBO.this_nContabs)
5517:             loc_oPgAba.obj_4c_Opt_Caracteris.Value = IIF(loc_oBO.this_nCaracteris = 0, 1, loc_oBO.this_nCaracteris)
5518:             loc_oPgAba.obj_4c_Fwoption1.Value     = IIF(loc_oBO.this_nInfcads = 0, 1, loc_oBO.this_nInfcads)
5519:             loc_oPgAba.obj_4c_Fwoption2.Value     = IIF(loc_oBO.this_nDadcoms = 0, 1, loc_oBO.this_nDadcoms)
5520:             loc_oPgAba.obj_4c_Opt_DadosCom.Value  = IIF(loc_oBO.this_nDadcoms = 0, 1, loc_oBO.this_nDadcoms)
5521:             loc_oPgAba.obj_4c_Opt_Respos.Value    = IIF(loc_oBO.this_nRespos = 0, 1, loc_oBO.this_nRespos)
5522:             loc_oPgAba.obj_4c_Opt_LimCre.Value    = IIF(loc_oBO.this_nLimcres = 0, 1, loc_oBO.this_nLimcres)
5523:             loc_oPgAba.obj_4c_Opt_Comi.Value      = IIF(loc_oBO.this_nComis = 0, 1, loc_oBO.this_nComis)
5524:             loc_oPgAba.obj_4c_Opt_Cargo.Value     = IIF(loc_oBO.this_nCargos = 0, 1, loc_oBO.this_nCargos)
5525:             loc_oPgAba.obj_4c_Opt_ChkLimCr.Value  = IIF(loc_oBO.this_nChklimcrds = 0, 1, loc_oBO.this_nChklimcrds)
5526:             loc_oPgAba.obj_4c_OptPreCad.Value     = IIF(loc_oBO.this_nPrecad = 0, 1, loc_oBO.this_nPrecad)
5527:             loc_oPgAba.obj_4c_Opt_Coletor.Value   = IIF(loc_oBO.this_nColetors = 0, 1, loc_oBO.this_nColetors + 1)

*-- Linhas 5707 a 5763:
5707:     *--------------------------------------------------------------------------
5708:     * ObterIndiceControle - retorna indice de um controle pelo nome
5709:     *--------------------------------------------------------------------------
5710:     PROTECTED PROCEDURE ObterIndiceControle(par_oContainer, par_cNome)
5711:         LOCAL loc_nI
5712:         FOR loc_nI = 1 TO par_oContainer.ControlCount
5713:             IF UPPER(par_oContainer.Controls(loc_nI).Name) = UPPER(par_cNome)
5714:                 RETURN loc_nI
5715:             ENDIF
5716:         ENDFOR
5717:         RETURN 1
5718:     ENDPROC
5719: 
5720:     *--------------------------------------------------------------------------
5721:     * FormParaBO - Transfere controles da Page2 -> BO
5722:     *--------------------------------------------------------------------------
5723:     PROCEDURE FormParaBO()
5724:         LOCAL loc_oPg2, loc_oBO, loc_oPgAba, loc_cCfg
5725:         LOCAL loc_aCnt, loc_nI, loc_oCnt, loc_cFisStr, loc_cNomeProp
5726:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
5727:         loc_oBO  = THIS.this_oBusinessObject
5728: 
5729:         TRY
5730:             *-- Identificacao
5731:             loc_oBO.this_cCodigos  = ALLTRIM(NVL(loc_oPg2.txt_4c_Codigo.Value, ""))
5732:             loc_oBO.this_cDgcods   = ALLTRIM(NVL(loc_oPg2.txt_4c_Digito.Value, ""))
5733:             loc_oBO.this_cDescrs   = ALLTRIM(NVL(loc_oPg2.txt_4c_Descr.Value, ""))
5734:             loc_oBO.this_cInternos = ALLTRIM(NVL(loc_oPg2.txt_4c_Interno.Value, ""))
5735:             loc_oBO.this_cClasses  = ALLTRIM(NVL(loc_oPg2.txt_4c_Classes.Value, ""))
5736:             loc_oBO.this_nTpcods   = NVL(loc_oPg2.obj_4c_Opt_TpCods.Value, 1)
5737:             loc_oBO.this_nTpemps   = NVL(loc_oPg2.obj_4c_Opt_TpEmps.Value, 1)
5738:             loc_oBO.this_nTpcads   = NVL(loc_oPg2.obj_4c_Opt_TpCads.Value, 1)
5739: 
5740:             *-- Aba Geral
5741:             loc_oPgAba = loc_oPg2.pgf_4c_1.Page1
5742:             loc_oBO.this_nComplems    = NVL(loc_oPgAba.obj_4c_Opt_Comple.Value, 1)
5743:             loc_oBO.this_nPessoais    = NVL(loc_oPgAba.obj_4c_Opt_Pessoais.Value, 1)
5744:             loc_oBO.this_nRefbancs    = NVL(loc_oPgAba.obj_4c_Opt_RefBancs.Value, 1)
5745:             loc_oBO.this_nFollowups   = NVL(loc_oPgAba.obj_4c_Opt_FollowUp.Value, 1)
5746:             loc_oBO.this_nFiscais     = NVL(loc_oPgAba.obj_4c_Opt_Fiscais.Value, 1)
5747:             loc_oBO.this_nEmpresas    = NVL(loc_oPgAba.obj_4c_Opt_Empresa.Value, 1)
5748:             loc_oBO.this_nContabs     = NVL(loc_oPgAba.obj_4c_Opt_Contabs.Value, 1)
5749:             loc_oBO.this_nCaracteris  = NVL(loc_oPgAba.obj_4c_Opt_Caracteris.Value, 1)
5750:             loc_oBO.this_nInfcads     = NVL(loc_oPgAba.obj_4c_Fwoption1.Value, 1)
5751:             loc_oBO.this_nDadcoms     = NVL(loc_oPgAba.obj_4c_Opt_DadosCom.Value, 1)
5752:             loc_oBO.this_nRespos      = NVL(loc_oPgAba.obj_4c_Opt_Respos.Value, 1)
5753:             loc_oBO.this_nLimcres     = NVL(loc_oPgAba.obj_4c_Opt_LimCre.Value, 1)
5754:             loc_oBO.this_nComis       = NVL(loc_oPgAba.obj_4c_Opt_Comi.Value, 1)
5755:             loc_oBO.this_nCargos      = NVL(loc_oPgAba.obj_4c_Opt_Cargo.Value, 1)
5756:             loc_oBO.this_nChklimcrds  = NVL(loc_oPgAba.obj_4c_Opt_ChkLimCr.Value, 1)
5757:             loc_oBO.this_nPrecad      = NVL(loc_oPgAba.obj_4c_OptPreCad.Value, 1)
5758:             loc_oBO.this_nColetors    = NVL(loc_oPgAba.obj_4c_Opt_Coletor.Value, 1) - 1
5759:             loc_oBO.this_nVrlimcre    = NVL(loc_oPgAba.txt_4c_Vrlimc.Value, 0)
5760:             loc_oBO.this_cMolimcre    = ALLTRIM(NVL(loc_oPgAba.txt_4c__molimc.Value, ""))
5761:             loc_oBO.this_cCommoedas   = ALLTRIM(NVL(loc_oPgAba.txt_4c__cd_moeda.Value, ""))
5762:             loc_oBO.this_cGrupolms    = ALLTRIM(NVL(loc_oPgAba.txt_4c_Grupo.Value, ""))
5763:             loc_oBO.this_cRodrelcc    = NVL(loc_oPgAba.obj_4c_GetRodRelCC.Value, "")

*-- Linhas 5881 a 6744:
5881:     *--------------------------------------------------------------------------
5882:     * BtnEncerrarClick
5883:     *--------------------------------------------------------------------------
5884:     PROCEDURE BtnEncerrarClick()
5885:         THIS.Release()
5886:     ENDPROC
5887: 
5888:     *--------------------------------------------------------------------------
5889:     * BtnConfirmarClick
5890:     *--------------------------------------------------------------------------
5891:     PROCEDURE BtnConfirmarClick()
5892:         THIS.BtnSalvarClick()
5893:     ENDPROC
5894: 
5895:     *--------------------------------------------------------------------------
5896:     * BtnSalvarClick - Valida, transfere Form->BO e persiste via BO.Salvar()
5897:     *--------------------------------------------------------------------------
5898:     PROCEDURE BtnSalvarClick()
5899:         LOCAL loc_lSucesso, loc_oPg2
5900:         loc_lSucesso = .F.
5901:         loc_oPg2     = THIS.pgf_4c_Paginas.Page2
5902: 
5903:         IF EMPTY(ALLTRIM(NVL(loc_oPg2.txt_4c_Codigo.Value, "")))
5904:             MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o informado.", "Salvar")
5905:             RETURN
5906:         ENDIF
5907: 
5908:         IF EMPTY(ALLTRIM(NVL(loc_oPg2.txt_4c_Descr.Value, "")))
5909:             MsgAviso("Descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada.", "Salvar")
5910:             RETURN
5911:         ENDIF
5912: 
5913:         TRY
5914:             THIS.FormParaBO()
5915:             loc_lSucesso = THIS.this_oBusinessObject.Salvar()
5916: 
5917:             IF loc_lSucesso
5918:                 MsgInfo("Registro salvo com sucesso!", "Salvar")
5919:                 THIS.AlternarPagina(1)
5920:             ENDIF
5921:         CATCH TO loc_oErro
5922:             MsgErro(loc_oErro.Message, "BtnSalvarClick")
5923:         ENDTRY
5924:     ENDPROC
5925: 
5926:     *--------------------------------------------------------------------------
5927:     * BtnCancelarClick
5928:     *--------------------------------------------------------------------------
5929:     PROCEDURE BtnCancelarClick()
5930:         THIS.AlternarPagina(1)
5931:     ENDPROC
5932: 
5933:     *--------------------------------------------------------------------------
5934:     * BtnIncluirClick
5935:     *--------------------------------------------------------------------------
5936:     PROCEDURE BtnIncluirClick()
5937:         THIS.this_oBusinessObject.NovoRegistro()
5938:         THIS.this_cModoAtual = "INCLUIR"
5939:         THIS.LimparDados()
5940:         THIS.HabilitarCampos(.T.)
5941:         THIS.AjustarBotoesPorModo()
5942:         THIS.AlternarPagina(2)
5943:     ENDPROC
5944: 
5945:     *--------------------------------------------------------------------------
5946:     * BtnVisualizarClick
5947:     *--------------------------------------------------------------------------
5948:     PROCEDURE BtnVisualizarClick()
5949:         LOCAL loc_cCodigos
5950:         loc_cCodigos = ""
5951: 
5952:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
5953:             SELECT cursor_4c_Dados
5954:             loc_cCodigos = ALLTRIM(NVL(cursor_4c_Dados.codigos, ""))
5955:         ENDIF
5956: 
5957:         IF EMPTY(loc_cCodigos)
5958:             MsgAviso("Selecione um registro na lista.", "Visualizar")
5959:             RETURN
5960:         ENDIF
5961: 
5962:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigos)
5963:             THIS.this_cModoAtual = "VISUALIZAR"
5964:             THIS.BOParaForm()
5965:             THIS.HabilitarCampos(.F.)
5966:             THIS.AjustarBotoesPorModo()
5967:             THIS.AlternarPagina(2)
5968:         ENDIF
5969:     ENDPROC
5970: 
5971:     *--------------------------------------------------------------------------
5972:     * BtnAlterarClick
5973:     *--------------------------------------------------------------------------
5974:     PROCEDURE BtnAlterarClick()
5975:         LOCAL loc_cCodigos
5976:         loc_cCodigos = ""
5977: 
5978:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
5979:             SELECT cursor_4c_Dados
5980:             loc_cCodigos = ALLTRIM(NVL(cursor_4c_Dados.codigos, ""))
5981:         ENDIF
5982: 
5983:         IF EMPTY(loc_cCodigos)
5984:             MsgAviso("Selecione um registro na lista.", "Alterar")
5985:             RETURN
5986:         ENDIF
5987: 
5988:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigos)
5989:             THIS.this_oBusinessObject.EditarRegistro()
5990:             THIS.this_cModoAtual = "ALTERAR"
5991:             THIS.BOParaForm()
5992:             THIS.HabilitarCampos(.T.)
5993:             THIS.AjustarBotoesPorModo()
5994:             THIS.AlternarPagina(2)
5995:         ENDIF
5996:     ENDPROC
5997: 
5998:     *--------------------------------------------------------------------------
5999:     * BtnExcluirClick
6000:     *--------------------------------------------------------------------------
6001:     PROCEDURE BtnExcluirClick()
6002:         LOCAL loc_cCodigos, loc_lConfirma
6003:         loc_cCodigos  = ""
6004:         loc_lConfirma = .F.
6005: 
6006:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
6007:             SELECT cursor_4c_Dados
6008:             loc_cCodigos = ALLTRIM(NVL(cursor_4c_Dados.codigos, ""))
6009:         ENDIF
6010: 
6011:         IF EMPTY(loc_cCodigos)
6012:             MsgAviso("Selecione um registro na lista.", "Excluir")
6013:             RETURN
6014:         ENDIF
6015: 
6016:         loc_lConfirma = MsgConfirma("Deseja excluir o grupo de contas correntes selecionado?", "Excluir")
6017:         IF !loc_lConfirma
6018:             RETURN
6019:         ENDIF
6020: 
6021:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigos)
6022:             IF THIS.this_oBusinessObject.Excluir()
6023:                 MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Excluir")
6024:                 THIS.CarregarLista()
6025:             ENDIF
6026:         ENDIF
6027:     ENDPROC
6028: 
6029:     *--------------------------------------------------------------------------
6030:     * BtnBuscarClick
6031:     *--------------------------------------------------------------------------
6032:     PROCEDURE BtnBuscarClick()
6033:         LOCAL loc_cFiltro
6034:         loc_cFiltro = INPUTBOX("Informe c" + CHR(243) + "digo ou descri" + CHR(231) + CHR(227) + ;
6035:             "o (vazio = todos):", "Buscar")
6036: 
6037:         IF VARTYPE(loc_cFiltro) = "C"
6038:             IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
6039:                 THIS.AtualizarGrid()
6040:             ENDIF
6041:         ENDIF
6042:     ENDPROC
6043: 
6044:     *--------------------------------------------------------------------------
6045:     * ClassesKeyPress - Abre picker de Classe (SigCdCss) ao pressionar F4
6046:     *--------------------------------------------------------------------------
6047:     PROCEDURE ClassesKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6048:         IF par_nKeyCode = 115
6049:             THIS.AbrirBuscaClasses()
6050:         ENDIF
6051:     ENDPROC
6052: 
6053:     *--------------------------------------------------------------------------
6054:     * ClassesDblClick
6055:     *--------------------------------------------------------------------------
6056:     PROCEDURE ClassesDblClick()
6057:         THIS.AbrirBuscaClasses()
6058:     ENDPROC
6059: 
6060:     *--------------------------------------------------------------------------
6061:     * ClassesLostFocus - Valida classe ao sair do campo
6062:     *--------------------------------------------------------------------------
6063:     PROCEDURE ClassesLostFocus(par_nKeyCode, par_nShiftAltCtrl)
6064:         LOCAL loc_oPg2, loc_cCls
6065:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
6066:         loc_cCls = ALLTRIM(NVL(loc_oPg2.txt_4c_Classes.Value, ""))
6067: 
6068:         IF EMPTY(loc_cCls)
6069:             loc_oPg2.txt_4c_DClasses.Value = ""
6070:             RETURN
6071:         ENDIF
6072: 
6073:         TRY
6074:             IF SQLEXEC(gnConnHandle, "SELECT Descrs FROM SigCdCss WHERE RTRIM(Classes)=" + ;
6075:                 EscaparSQL(loc_cCls), "cursor_4c_Css") >= 0
6076:                 IF USED("cursor_4c_Css") AND RECCOUNT("cursor_4c_Css") > 0
6077:                     SELECT cursor_4c_Css
6078:                     loc_oPg2.txt_4c_DClasses.Value = ALLTRIM(NVL(Descrs, ""))
6079:                 ELSE
6080:                     THIS.AbrirBuscaClasses()
6081:                 ENDIF
6082:                 IF USED("cursor_4c_Css")
6083:                     USE IN cursor_4c_Css
6084:                 ENDIF
6085:             ENDIF
6086:         CATCH TO loc_oErro
6087:             MsgErro(loc_oErro.Message, "ClassesLostFocus")
6088:             IF USED("cursor_4c_Css")
6089:                 USE IN cursor_4c_Css
6090:             ENDIF
6091:         ENDTRY
6092:     ENDPROC
6093: 
6094:     *--------------------------------------------------------------------------
6095:     * AbrirBuscaClasses - FormBuscaAuxiliar para SigCdCss
6096:     *--------------------------------------------------------------------------
6097:     PROCEDURE AbrirBuscaClasses()
6098:         LOCAL loc_oBusca, loc_oPg2
6099:         loc_oBusca = .NULL.
6100:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
6101: 
6102:         TRY
6103:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
6104:                 "SigCdCss", "cursor_4c_BuscaClasse", "Classes", ;
6105:                 ALLTRIM(NVL(loc_oPg2.txt_4c_Classes.Value, "")), ;
6106:                 "Selecionar Classe")
6107: 
6108:             IF VARTYPE(loc_oBusca) = "O"
6109:                 IF !loc_oBusca.this_lAchouRegistro OR !loc_oBusca.this_lSelecionou
6110:                     loc_oBusca.mAddColuna("Classes", "", "Classe")
6111:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
6112:                     loc_oBusca.Show()
6113:                 ENDIF
6114: 
6115:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClasse")
6116:                     SELECT cursor_4c_BuscaClasse
6117:                     loc_oPg2.txt_4c_Classes.Value  = ALLTRIM(NVL(Classes, ""))
6118:                     loc_oPg2.txt_4c_DClasses.Value = ALLTRIM(NVL(Descrs, ""))
6119:                 ELSE
6120:                     IF !loc_oBusca.this_lSelecionou
6121:                         loc_oPg2.txt_4c_Classes.Value  = ""
6122:                         loc_oPg2.txt_4c_DClasses.Value = ""
6123:                     ENDIF
6124:                 ENDIF
6125:                 loc_oBusca.Release()
6126:             ENDIF
6127: 
6128:             IF USED("cursor_4c_BuscaClasse")
6129:                 USE IN cursor_4c_BuscaClasse
6130:             ENDIF
6131:         CATCH TO loc_oErro
6132:             MsgErro(loc_oErro.Message, "AbrirBuscaClasses")
6133:             IF USED("cursor_4c_BuscaClasse")
6134:                 USE IN cursor_4c_BuscaClasse
6135:             ENDIF
6136:         ENDTRY
6137:     ENDPROC
6138: 
6139:     *--------------------------------------------------------------------------
6140:     * MoedaComissaoKeyPress - Abre picker de Moeda Comissao ao F4
6141:     *--------------------------------------------------------------------------
6142:     PROCEDURE MoedaComissaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6143:         IF par_nKeyCode = 115
6144:             THIS.AbrirBuscaMoedaComissao()
6145:         ENDIF
6146:     ENDPROC
6147: 
6148:     *--------------------------------------------------------------------------
6149:     * MoedaComissaoDblClick
6150:     *--------------------------------------------------------------------------
6151:     PROCEDURE MoedaComissaoDblClick()
6152:         THIS.AbrirBuscaMoedaComissao()
6153:     ENDPROC
6154: 
6155:     *--------------------------------------------------------------------------
6156:     * MoedaComissaoLostFocus - Valida moeda comissao ao sair
6157:     *--------------------------------------------------------------------------
6158:     PROCEDURE MoedaComissaoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
6159:         LOCAL loc_oPgAba, loc_cMoe
6160:         loc_oPgAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page1
6161:         loc_cMoe   = ALLTRIM(NVL(loc_oPgAba.txt_4c__cd_moeda.Value, ""))
6162: 
6163:         IF EMPTY(loc_cMoe)
6164:             loc_oPgAba.txt_4c__ds_moeda.Value = ""
6165:             RETURN
6166:         ENDIF
6167: 
6168:         TRY
6169:             IF SQLEXEC(gnConnHandle, "SELECT Dmoes FROM SigCdMoe WHERE RTRIM(Cmoes)=" + ;
6170:                 EscaparSQL(loc_cMoe), "cursor_4c_MoeVal") >= 0
6171:                 IF USED("cursor_4c_MoeVal") AND RECCOUNT("cursor_4c_MoeVal") > 0
6172:                     SELECT cursor_4c_MoeVal
6173:                     loc_oPgAba.txt_4c__ds_moeda.Value = ALLTRIM(NVL(Dmoes, ""))
6174:                 ELSE
6175:                     THIS.AbrirBuscaMoedaComissao()
6176:                 ENDIF
6177:                 IF USED("cursor_4c_MoeVal")
6178:                     USE IN cursor_4c_MoeVal
6179:                 ENDIF
6180:             ENDIF
6181:         CATCH TO loc_oErro
6182:             MsgErro(loc_oErro.Message, "MoedaComissaoLostFocus")
6183:             IF USED("cursor_4c_MoeVal")
6184:                 USE IN cursor_4c_MoeVal
6185:             ENDIF
6186:         ENDTRY
6187:     ENDPROC
6188: 
6189:     *--------------------------------------------------------------------------
6190:     * AbrirBuscaMoedaComissao - FormBuscaAuxiliar para SigCdMoe (comissao)
6191:     *--------------------------------------------------------------------------
6192:     PROCEDURE AbrirBuscaMoedaComissao()
6193:         LOCAL loc_oBusca, loc_oPgAba
6194:         loc_oBusca = .NULL.
6195:         loc_oPgAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page1
6196: 
6197:         TRY
6198:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
6199:                 "SigCdMoe", "cursor_4c_BuscaMoeCom", "Cmoes", ;
6200:                 ALLTRIM(NVL(loc_oPgAba.txt_4c__cd_moeda.Value, "")), ;
6201:                 "Selecionar Moeda Comiss" + CHR(227) + "o")
6202: 
6203:             IF VARTYPE(loc_oBusca) = "O"
6204:                 IF !loc_oBusca.this_lAchouRegistro OR !loc_oBusca.this_lSelecionou
6205:                     loc_oBusca.mAddColuna("Cmoes", "", "C" + CHR(243) + "d.")
6206:                     loc_oBusca.mAddColuna("Dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
6207:                     loc_oBusca.Show()
6208:                 ENDIF
6209: 
6210:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeCom")
6211:                     SELECT cursor_4c_BuscaMoeCom
6212:                     loc_oPgAba.txt_4c__cd_moeda.Value = ALLTRIM(NVL(Cmoes, ""))
6213:                     loc_oPgAba.txt_4c__ds_moeda.Value = ALLTRIM(NVL(Dmoes, ""))
6214:                 ENDIF
6215:                 loc_oBusca.Release()
6216:             ENDIF
6217: 
6218:             IF USED("cursor_4c_BuscaMoeCom")
6219:                 USE IN cursor_4c_BuscaMoeCom
6220:             ENDIF
6221:         CATCH TO loc_oErro
6222:             MsgErro(loc_oErro.Message, "AbrirBuscaMoedaComissao")
6223:             IF USED("cursor_4c_BuscaMoeCom")
6224:                 USE IN cursor_4c_BuscaMoeCom
6225:             ENDIF
6226:         ENDTRY
6227:     ENDPROC
6228: 
6229:     *--------------------------------------------------------------------------
6230:     * MoedaLimiteKeyPress - F4 para moeda limite de credito
6231:     *--------------------------------------------------------------------------
6232:     PROCEDURE MoedaLimiteKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6233:         IF par_nKeyCode = 115
6234:             THIS.AbrirBuscaMoedaLimite()
6235:         ENDIF
6236:     ENDPROC
6237: 
6238:     *--------------------------------------------------------------------------
6239:     * MoedaLimiteDblClick
6240:     *--------------------------------------------------------------------------
6241:     PROCEDURE MoedaLimiteDblClick()
6242:         THIS.AbrirBuscaMoedaLimite()
6243:     ENDPROC
6244: 
6245:     *--------------------------------------------------------------------------
6246:     * MoedaLimiteLostFocus - Valida moeda limite ao sair
6247:     *--------------------------------------------------------------------------
6248:     PROCEDURE MoedaLimiteLostFocus(par_nKeyCode, par_nShiftAltCtrl)
6249:         LOCAL loc_oPgAba, loc_cMoe
6250:         loc_oPgAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page1
6251:         loc_cMoe   = ALLTRIM(NVL(loc_oPgAba.txt_4c__molimc.Value, ""))
6252: 
6253:         IF EMPTY(loc_cMoe)
6254:             RETURN
6255:         ENDIF
6256: 
6257:         TRY
6258:             IF SQLEXEC(gnConnHandle, "SELECT Dmoes FROM SigCdMoe WHERE RTRIM(Cmoes)=" + ;
6259:                 EscaparSQL(loc_cMoe), "cursor_4c_MoeL") >= 0
6260:                 IF !USED("cursor_4c_MoeL") OR RECCOUNT("cursor_4c_MoeL") = 0
6261:                     THIS.AbrirBuscaMoedaLimite()
6262:                 ENDIF
6263:                 IF USED("cursor_4c_MoeL")
6264:                     USE IN cursor_4c_MoeL
6265:                 ENDIF
6266:             ENDIF
6267:         CATCH TO loc_oErro
6268:             MsgErro(loc_oErro.Message, "MoedaLimiteLostFocus")
6269:             IF USED("cursor_4c_MoeL")
6270:                 USE IN cursor_4c_MoeL
6271:             ENDIF
6272:         ENDTRY
6273:     ENDPROC
6274: 
6275:     *--------------------------------------------------------------------------
6276:     * AbrirBuscaMoedaLimite - FormBuscaAuxiliar para SigCdMoe (limite)
6277:     *--------------------------------------------------------------------------
6278:     PROCEDURE AbrirBuscaMoedaLimite()
6279:         LOCAL loc_oBusca, loc_oPgAba
6280:         loc_oBusca = .NULL.
6281:         loc_oPgAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page1
6282: 
6283:         TRY
6284:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
6285:                 "SigCdMoe", "cursor_4c_BuscaMoeLim", "Cmoes", ;
6286:                 ALLTRIM(NVL(loc_oPgAba.txt_4c__molimc.Value, "")), ;
6287:                 "Selecionar Moeda Limite")
6288: 
6289:             IF VARTYPE(loc_oBusca) = "O"
6290:                 IF !loc_oBusca.this_lAchouRegistro OR !loc_oBusca.this_lSelecionou
6291:                     loc_oBusca.mAddColuna("Cmoes", "", "C" + CHR(243) + "d.")
6292:                     loc_oBusca.mAddColuna("Dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
6293:                     loc_oBusca.Show()
6294:                 ENDIF
6295: 
6296:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeLim")
6297:                     SELECT cursor_4c_BuscaMoeLim
6298:                     loc_oPgAba.txt_4c__molimc.Value = ALLTRIM(NVL(Cmoes, ""))
6299:                 ENDIF
6300:                 loc_oBusca.Release()
6301:             ENDIF
6302: 
6303:             IF USED("cursor_4c_BuscaMoeLim")
6304:                 USE IN cursor_4c_BuscaMoeLim
6305:             ENDIF
6306:         CATCH TO loc_oErro
6307:             MsgErro(loc_oErro.Message, "AbrirBuscaMoedaLimite")
6308:             IF USED("cursor_4c_BuscaMoeLim")
6309:                 USE IN cursor_4c_BuscaMoeLim
6310:             ENDIF
6311:         ENDTRY
6312:     ENDPROC
6313: 
6314:     *--------------------------------------------------------------------------
6315:     * GrupoContabKeyPress - F4 para grupo contabil padrao
6316:     *--------------------------------------------------------------------------
6317:     PROCEDURE GrupoContabKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6318:         IF par_nKeyCode = 115
6319:             THIS.AbrirBuscaGrupoContab()
6320:         ENDIF
6321:     ENDPROC
6322: 
6323:     *--------------------------------------------------------------------------
6324:     * GrupoContabDblClick
6325:     *--------------------------------------------------------------------------
6326:     PROCEDURE GrupoContabDblClick()
6327:         THIS.AbrirBuscaGrupoContab()
6328:     ENDPROC
6329: 
6330:     *--------------------------------------------------------------------------
6331:     * AbrirBuscaGrupoContab - FormBuscaAuxiliar para grupo contabil
6332:     *--------------------------------------------------------------------------
6333:     PROCEDURE AbrirBuscaGrupoContab()
6334:         LOCAL loc_oBusca, loc_oPgAba
6335:         loc_oBusca = .NULL.
6336:         loc_oPgAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page1
6337: 
6338:         TRY
6339:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
6340:                 "SigCdGcr", "cursor_4c_BuscaGrp", "codigos", ;
6341:                 ALLTRIM(NVL(loc_oPgAba.txt_4c_Grupo.Value, "")), ;
6342:                 "Selecionar Grupo Cont" + CHR(225) + "bil")
6343: 
6344:             IF VARTYPE(loc_oBusca) = "O"
6345:                 IF !loc_oBusca.this_lAchouRegistro OR !loc_oBusca.this_lSelecionou
6346:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
6347:                     loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
6348:                     loc_oBusca.Show()
6349:                 ENDIF
6350: 
6351:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
6352:                     SELECT cursor_4c_BuscaGrp
6353:                     loc_oPgAba.txt_4c_Grupo.Value = ALLTRIM(NVL(codigos, ""))
6354:                 ENDIF
6355:                 loc_oBusca.Release()
6356:             ENDIF
6357: 
6358:             IF USED("cursor_4c_BuscaGrp")
6359:                 USE IN cursor_4c_BuscaGrp
6360:             ENDIF
6361:         CATCH TO loc_oErro
6362:             MsgErro(loc_oErro.Message, "AbrirBuscaGrupoContab")
6363:             IF USED("cursor_4c_BuscaGrp")
6364:                 USE IN cursor_4c_BuscaGrp
6365:             ENDIF
6366:         ENDTRY
6367:     ENDPROC
6368: 
6369:     *--------------------------------------------------------------------------
6370:     * SituacaoKeyPress - F4 abre picker de Situacao Padrao (SigCdCst)
6371:     *--------------------------------------------------------------------------
6372:     PROCEDURE SituacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6373:         IF par_nKeyCode = 115
6374:             THIS.AbrirBuscaSituacao()
6375:         ENDIF
6376:     ENDPROC
6377: 
6378:     *--------------------------------------------------------------------------
6379:     * SituacaoDblClick - DblClick abre picker de Situacao
6380:     *--------------------------------------------------------------------------
6381:     PROCEDURE SituacaoDblClick()
6382:         THIS.AbrirBuscaSituacao()
6383:     ENDPROC
6384: 
6385:     *--------------------------------------------------------------------------
6386:     * SituacaoLostFocus - Valida Situacao ao sair do campo
6387:     *--------------------------------------------------------------------------
6388:     PROCEDURE SituacaoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
6389:         LOCAL loc_oPgAba, loc_cSit
6390:         loc_oPgAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page2
6391:         loc_cSit   = ALLTRIM(NVL(loc_oPgAba.getSituas.Value, ""))
6392: 
6393:         IF EMPTY(loc_cSit)
6394:             RETURN
6395:         ENDIF
6396: 
6397:         TRY
6398:             IF SQLEXEC(gnConnHandle, "SELECT codigos FROM SigCdCst WHERE RTRIM(codigos)=" + ;
6399:                 EscaparSQL(loc_cSit), "cursor_4c_SitVal") >= 0
6400:                 IF !USED("cursor_4c_SitVal") OR RECCOUNT("cursor_4c_SitVal") = 0
6401:                     THIS.AbrirBuscaSituacao()
6402:                 ENDIF
6403:                 IF USED("cursor_4c_SitVal")
6404:                     USE IN cursor_4c_SitVal
6405:                 ENDIF
6406:             ENDIF
6407:         CATCH TO loc_oErro
6408:             MsgErro(loc_oErro.Message, "SituacaoLostFocus")
6409:             IF USED("cursor_4c_SitVal")
6410:                 USE IN cursor_4c_SitVal
6411:             ENDIF
6412:         ENDTRY
6413:     ENDPROC
6414: 
6415:     *--------------------------------------------------------------------------
6416:     * AbrirBuscaSituacao - FormBuscaAuxiliar para SigCdCst (Situacao Padrao)
6417:     *--------------------------------------------------------------------------
6418:     PROCEDURE AbrirBuscaSituacao()
6419:         LOCAL loc_oBusca, loc_oPgAba
6420:         loc_oBusca = .NULL.
6421:         loc_oPgAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page2
6422: 
6423:         TRY
6424:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
6425:                 "SigCdCst", "cursor_4c_BuscaSit", "codigos", ;
6426:                 ALLTRIM(NVL(loc_oPgAba.getSituas.Value, "")), ;
6427:                 "Selecionar Situa" + CHR(231) + CHR(227) + "o", ;
6428:                 .F., .F., "")
6429: 
6430:             IF VARTYPE(loc_oBusca) = "O"
6431:                 IF !loc_oBusca.this_lAchouRegistro OR !loc_oBusca.this_lSelecionou
6432:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "d.")
6433:                     loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
6434:                     loc_oBusca.Show()
6435:                 ENDIF
6436: 
6437:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSit")
6438:                     SELECT cursor_4c_BuscaSit
6439:                     loc_oPgAba.getSituas.Value = ALLTRIM(NVL(codigos, ""))
6440:                 ENDIF
6441:                 loc_oBusca.Release()
6442:             ENDIF
6443: 
6444:             IF USED("cursor_4c_BuscaSit")
6445:                 USE IN cursor_4c_BuscaSit
6446:             ENDIF
6447:         CATCH TO loc_oErro
6448:             MsgErro(loc_oErro.Message, "AbrirBuscaSituacao")
6449:             IF USED("cursor_4c_BuscaSit")
6450:                 USE IN cursor_4c_BuscaSit
6451:             ENDIF
6452:         ENDTRY
6453:     ENDPROC
6454: 
6455:     *--------------------------------------------------------------------------
6456:     * GrupoEstoqueKeyPress - F4 abre picker de Grupo Diferenca Balanco (Estoque)
6457:     *--------------------------------------------------------------------------
6458:     PROCEDURE GrupoEstoqueKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6459:         IF par_nKeyCode = 115
6460:             THIS.AbrirBuscaGrupoEstoque()
6461:         ENDIF
6462:     ENDPROC
6463: 
6464:     *--------------------------------------------------------------------------
6465:     * GrupoEstoqueDblClick - DblClick abre picker de grupo (Estoque)
6466:     *--------------------------------------------------------------------------
6467:     PROCEDURE GrupoEstoqueDblClick()
6468:         THIS.AbrirBuscaGrupoEstoque()
6469:     ENDPROC
6470: 
6471:     *--------------------------------------------------------------------------
6472:     * AbrirBuscaGrupoEstoque - FormBuscaAuxiliar SigCdGcr para aba Estoque
6473:     *--------------------------------------------------------------------------
6474:     PROCEDURE AbrirBuscaGrupoEstoque()
6475:         LOCAL loc_oBusca, loc_oPgAba
6476:         loc_oBusca = .NULL.
6477:         loc_oPgAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page3
6478: 
6479:         TRY
6480:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
6481:                 "SigCdGcr", "cursor_4c_BuscaGrpEst", "codigos", ;
6482:                 ALLTRIM(NVL(loc_oPgAba.Get_grupo.Value, "")), ;
6483:                 "Selecionar Grupo")
6484: 
6485:             IF VARTYPE(loc_oBusca) = "O"
6486:                 IF !loc_oBusca.this_lAchouRegistro OR !loc_oBusca.this_lSelecionou
6487:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
6488:                     loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
6489:                     loc_oBusca.Show()
6490:                 ENDIF
6491: 
6492:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrpEst")
6493:                     SELECT cursor_4c_BuscaGrpEst
6494:                     loc_oPgAba.Get_grupo.Value = ALLTRIM(NVL(codigos, ""))
6495:                 ENDIF
6496:                 loc_oBusca.Release()
6497:             ENDIF
6498: 
6499:             IF USED("cursor_4c_BuscaGrpEst")
6500:                 USE IN cursor_4c_BuscaGrpEst
6501:             ENDIF
6502:         CATCH TO loc_oErro
6503:             MsgErro(loc_oErro.Message, "AbrirBuscaGrupoEstoque")
6504:             IF USED("cursor_4c_BuscaGrpEst")
6505:                 USE IN cursor_4c_BuscaGrpEst
6506:             ENDIF
6507:         ENDTRY
6508:     ENDPROC
6509: 
6510:     *--------------------------------------------------------------------------
6511:     * GrupoFatKeyPress - F4 abre picker de Grupo no container fiscal ativo
6512:     *--------------------------------------------------------------------------
6513:     PROCEDURE GrupoFatKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6514:         IF par_nKeyCode = 115
6515:             THIS.AbrirBuscaGrupoFat()
6516:         ENDIF
6517:     ENDPROC
6518: 
6519:     *--------------------------------------------------------------------------
6520:     * GrupoFatDblClick - DblClick abre picker de Grupo no container fiscal ativo
6521:     *--------------------------------------------------------------------------
6522:     PROCEDURE GrupoFatDblClick()
6523:         THIS.AbrirBuscaGrupoFat()
6524:     ENDPROC
6525: 
6526:     *--------------------------------------------------------------------------
6527:     * GrupoFatLostFocus - Ao sair de getCdGrupos: limpa campos vinculados se vazio
6528:     * Nao pode usar THIS.ActiveControl.Parent (foco ja mudou); usa propriedade
6529:     * armazenada por GrupoFatGotFocus
6530:     *--------------------------------------------------------------------------
6531:     PROCEDURE GrupoFatLostFocus(par_nKeyCode, par_nShiftAltCtrl)
6532:         LOCAL loc_oCnt
6533:         TRY
6534:             IF VARTYPE(THIS.this_oUltimoCntFat) = "O" AND !ISNULL(THIS.this_oUltimoCntFat)
6535:                 loc_oCnt = THIS.this_oUltimoCntFat
6536:                 IF EMPTY(ALLTRIM(NVL(loc_oCnt.getCdGrupos.Value, "")))
6537:                     loc_oCnt.getCdContas.Value = ""
6538:                     loc_oCnt.getDsContas.Value = ""
6539:                     loc_oCnt.getPctAliqs.Value = 0
6540:                     loc_oCnt.getReceitas.Value = ""
6541:                 ENDIF
6542:             ENDIF
6543:         CATCH TO loc_oErro
6544:             MsgErro(loc_oErro.Message, "GrupoFatLostFocus")
6545:         ENDTRY
6546:     ENDPROC
6547: 
6548:     *--------------------------------------------------------------------------
6549:     * GrupoFatGotFocus - Armazena container ativo ao entrar em getCdGrupos
6550:     *--------------------------------------------------------------------------
6551:     PROCEDURE GrupoFatGotFocus()
6552:         IF VARTYPE(THIS.ActiveControl) = "O" AND ;
6553:                 VARTYPE(THIS.ActiveControl.Parent) = "O"
6554:             THIS.this_oUltimoCntFat = THIS.ActiveControl.Parent
6555:         ENDIF
6556:     ENDPROC
6557: 
6558:     *--------------------------------------------------------------------------
6559:     * AbrirBuscaGrupoFat - FormBuscaAuxiliar SigCdGcr para container fiscal
6560:     *--------------------------------------------------------------------------
6561:     PROCEDURE AbrirBuscaGrupoFat()
6562:         LOCAL loc_oBusca, loc_oCnt
6563:         loc_oBusca = .NULL.
6564: 
6565:         IF VARTYPE(THIS.ActiveControl) # "O" OR ;
6566:                 VARTYPE(THIS.ActiveControl.Parent) # "O"
6567:             RETURN
6568:         ENDIF
6569:         loc_oCnt = THIS.ActiveControl.Parent
6570: 
6571:         TRY
6572:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
6573:                 "SigCdGcr", "cursor_4c_BuscaGrpFat", "codigos", ;
6574:                 ALLTRIM(NVL(loc_oCnt.getCdGrupos.Value, "")), ;
6575:                 "Selecionar Grupo")
6576: 
6577:             IF VARTYPE(loc_oBusca) = "O"
6578:                 IF !loc_oBusca.this_lAchouRegistro OR !loc_oBusca.this_lSelecionou
6579:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
6580:                     loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
6581:                     loc_oBusca.Show()
6582:                 ENDIF
6583: 
6584:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrpFat")
6585:                     SELECT cursor_4c_BuscaGrpFat
6586:                     loc_oCnt.getCdGrupos.Value = ALLTRIM(NVL(codigos, ""))
6587:                     *-- Limpa conta ao trocar grupo
6588:                     loc_oCnt.getCdContas.Value = ""
6589:                     loc_oCnt.getDsContas.Value = ""
6590:                 ENDIF
6591:                 loc_oBusca.Release()
6592:             ENDIF
6593: 
6594:             IF USED("cursor_4c_BuscaGrpFat")
6595:                 USE IN cursor_4c_BuscaGrpFat
6596:             ENDIF
6597:         CATCH TO loc_oErro
6598:             MsgErro(loc_oErro.Message, "AbrirBuscaGrupoFat")
6599:             IF USED("cursor_4c_BuscaGrpFat")
6600:                 USE IN cursor_4c_BuscaGrpFat
6601:             ENDIF
6602:         ENDTRY
6603:     ENDPROC
6604: 
6605:     *--------------------------------------------------------------------------
6606:     * ContaFatKeyPress - F4 abre picker de Conta no container fiscal ativo
6607:     *--------------------------------------------------------------------------
6608:     PROCEDURE ContaFatKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6609:         IF par_nKeyCode = 115
6610:             THIS.AbrirBuscaContaFat()
6611:         ENDIF
6612:     ENDPROC
6613: 
6614:     *--------------------------------------------------------------------------
6615:     * ContaFatDblClick - DblClick abre picker de Conta no container fiscal ativo
6616:     *--------------------------------------------------------------------------
6617:     PROCEDURE ContaFatDblClick()
6618:         THIS.AbrirBuscaContaFat()
6619:     ENDPROC
6620: 
6621:     *--------------------------------------------------------------------------
6622:     * ContaFatLostFocus - Ao sair de getCdContas: limpa descricao se vazio
6623:     *--------------------------------------------------------------------------
6624:     PROCEDURE ContaFatLostFocus(par_nKeyCode, par_nShiftAltCtrl)
6625:         LOCAL loc_oCnt
6626:         TRY
6627:             IF VARTYPE(THIS.this_oUltimoCntFat) = "O" AND !ISNULL(THIS.this_oUltimoCntFat)
6628:                 loc_oCnt = THIS.this_oUltimoCntFat
6629:                 IF EMPTY(ALLTRIM(NVL(loc_oCnt.getCdContas.Value, "")))
6630:                     loc_oCnt.getDsContas.Value = ""
6631:                 ENDIF
6632:             ENDIF
6633:         CATCH TO loc_oErro
6634:             MsgErro(loc_oErro.Message, "ContaFatLostFocus")
6635:         ENDTRY
6636:     ENDPROC
6637: 
6638:     *--------------------------------------------------------------------------
6639:     * ContaFatGotFocus - Armazena container ativo ao entrar em getCdContas
6640:     *--------------------------------------------------------------------------
6641:     PROCEDURE ContaFatGotFocus()
6642:         IF VARTYPE(THIS.ActiveControl) = "O" AND ;
6643:                 VARTYPE(THIS.ActiveControl.Parent) = "O"
6644:             THIS.this_oUltimoCntFat = THIS.ActiveControl.Parent
6645:         ENDIF
6646:     ENDPROC
6647: 
6648:     *--------------------------------------------------------------------------
6649:     * AbrirBuscaContaFat - FormBuscaAuxiliar SigCdCli para container fiscal
6650:     * Filtra por grupo (getCdGrupos) se informado
6651:     *--------------------------------------------------------------------------
6652:     PROCEDURE AbrirBuscaContaFat()
6653:         LOCAL loc_oBusca, loc_oCnt, loc_cGrupo, loc_cFiltro
6654:         loc_oBusca = .NULL.
6655: 
6656:         IF VARTYPE(THIS.ActiveControl) # "O" OR ;
6657:                 VARTYPE(THIS.ActiveControl.Parent) # "O"
6658:             RETURN
6659:         ENDIF
6660:         loc_oCnt   = THIS.ActiveControl.Parent
6661:         loc_cGrupo = ALLTRIM(NVL(loc_oCnt.getCdGrupos.Value, ""))
6662:         loc_cFiltro = IIF(EMPTY(loc_cGrupo), "", "grupos = " + EscaparSQL(loc_cGrupo))
6663: 
6664:         TRY
6665:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
6666:                 "SigCdCli", "cursor_4c_BuscaCntFat", "iclis", ;
6667:                 ALLTRIM(NVL(loc_oCnt.getCdContas.Value, "")), ;
6668:                 "Selecionar Conta", .F., .F., loc_cFiltro)
6669: 
6670:             IF VARTYPE(loc_oBusca) = "O"
6671:                 IF !loc_oBusca.this_lAchouRegistro OR !loc_oBusca.this_lSelecionou
6672:                     loc_oBusca.mAddColuna("iclis",  "", "C" + CHR(243) + "digo")
6673:                     loc_oBusca.mAddColuna("rclis",  "", "Nome/Raz" + CHR(227) + "o Social")
6674:                     loc_oBusca.Show()
6675:                 ENDIF
6676: 
6677:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCntFat")
6678:                     SELECT cursor_4c_BuscaCntFat
6679:                     loc_oCnt.getCdContas.Value = ALLTRIM(NVL(iclis, ""))
6680:                     loc_oCnt.getDsContas.Value = ALLTRIM(NVL(rclis, ""))
6681:                 ENDIF
6682:                 loc_oBusca.Release()
6683:             ENDIF
6684: 
6685:             IF USED("cursor_4c_BuscaCntFat")
6686:                 USE IN cursor_4c_BuscaCntFat
6687:             ENDIF
6688:         CATCH TO loc_oErro
6689:             MsgErro(loc_oErro.Message, "AbrirBuscaContaFat")
6690:             IF USED("cursor_4c_BuscaCntFat")
6691:                 USE IN cursor_4c_BuscaCntFat
6692:             ENDIF
6693:         ENDTRY
6694:     ENDPROC
6695: 
6696:     *--------------------------------------------------------------------------
6697:     * TornarControlesVisiveis - Recursivo, torna tudo visivel
6698:     *--------------------------------------------------------------------------
6699:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
6700:         LOCAL loc_nI, loc_oObjeto, loc_nP
6701: 
6702:         FOR loc_nI = 1 TO par_oContainer.ControlCount
6703:             loc_oObjeto = par_oContainer.Controls(loc_nI)
6704: 
6705:             IF VARTYPE(loc_oObjeto) = "O"
6706:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
6707:                     THIS.TornarControlesVisiveis(loc_oObjeto)
6708:                 ENDIF
6709: 
6710:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
6711:                     loc_oObjeto.Visible = .T.
6712:                 ENDIF
6713: 
6714:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
6715:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
6716:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
6717:                     ENDFOR
6718:                 ENDIF
6719:             ENDIF
6720:         ENDFOR
6721:     ENDPROC
6722: 
6723:     *--------------------------------------------------------------------------
6724:     * Destroy - Libera recursos; chama FormBase.Destroy como ultima linha
6725:     *--------------------------------------------------------------------------
6726:     PROCEDURE Destroy()
6727:         TRY
6728:             IF USED("cursor_4c_Dados")
6729:                 USE IN cursor_4c_Dados
6730:             ENDIF
6731: 
6732:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
6733:                 THIS.this_oBusinessObject = .NULL.
6734:             ENDIF
6735: 
6736:             THIS.this_oUltimoCntFat = .NULL.
6737:         CATCH TO loc_oErro
6738:             MsgErro(loc_oErro.Message, "Formccr.Destroy")
6739:         ENDTRY
6740: 
6741:         DODEFAULT()
6742:     ENDPROC
6743: 
6744: ENDDEFINE


### BO (C:\4c\projeto\app\classes\ccrBO.prg):
*==============================================================================
* ccrBO.prg - Business Object para Grupos de Contas Correntes (SigCdGcr)
* Herda de BusinessBase
* Tabela: SigCdGcr  |  PK: codigos
*==============================================================================

DEFINE CLASS ccrBO AS BusinessBase

    *--------------------------------------------------------------------------
    * IDENTIFICACAO - PK e Descricao
    *--------------------------------------------------------------------------
    this_cCodigos         = ""   && codigos char(10) PK
    this_cDescrs          = ""   && descrs char(40)
    this_cDgcods          = ""   && dgcods char(1) - digito
    this_cInternos        = ""   && internos char(20) - codigo interno
    this_cClasses         = ""   && classes char(10) - FK SigCdCss
    this_cDClasses        = ""   && DClasses virtual (JOIN SigCdCss.Descrs)

    *--------------------------------------------------------------------------
    * TIPO/MODO
    *--------------------------------------------------------------------------
    this_nTpcods          = 0    && tpcods numeric(1,0) - tipo codificacao
    this_nTpemps          = 0    && tpemps numeric(1,0) - tipo empresa
    this_nTpcads          = 0    && tpcads numeric(1,0) - tipo cadastro

    *--------------------------------------------------------------------------
    * ABA GERAL - Opcoes de obrigatoriedade cadastral
    *--------------------------------------------------------------------------
    this_nComplems        = 0    && complems numeric(1,0) - Complemento
    this_nPessoais        = 0    && pessoais numeric(1,0) - Dados Pessoais
    this_nRefbancs        = 0    && refbancs numeric(1,0) - Ref. Bancarias
    this_nFollowups       = 0    && followups numeric(1,0) - Follow-Up
    this_nFiscais         = 0    && fiscais numeric(1,0) - Dados Fiscais
    this_nContabs         = 0    && contabs numeric(1,0) - Dados Contabeis
    this_nEmpresas        = 0    && empresas numeric(1,0) - Dados da Empresa
    this_nCaracteris      = 0    && caracteris numeric(1,0) - Caracteristicas
    this_nRespos          = 0    && respos numeric(1,0) - Possui Responsavel
    this_nLimcres         = 0    && limcres numeric(1,0) - Limite de Credito
    this_nComis           = 0    && comis numeric(1,0) - Comissao
    this_nDadcoms         = 0    && dadcoms numeric(1,0) - Dados Comerciais
    this_nCargos          = 0    && cargos numeric(1,0) - Cargos
    this_nChklimcrds      = 0    && chklimcrds numeric(1,0) - Checa Limite Credito
    this_nColetors        = 0    && coletors numeric(2,0) - Coletor (11 opcoes)
    this_nPrecad          = 0    && precad numeric(1,0) - Pre-Cadastro (LEAD)

    *--------------------------------------------------------------------------
    * ABA GERAL - Grupo padrao contabil / Limite de credito / Moeda
    *--------------------------------------------------------------------------
    this_cGrupolms        = ""   && grupolms char(10) - Grupo Padrao Contabil
    this_nVrlimcre        = 0    && vrlimcre numeric(11,2) - Valor Limite Credito
    this_cMolimcre        = ""   && molimcre char(3) - Moeda Limite Credito
    this_cCommoedas       = ""   && commoedas char(3) - Moeda Comissao
    this_cRodrelcc        = ""   && rodrelcc text - Rodape Relatorio Conta Corrente

    *--------------------------------------------------------------------------
    * ABA CADASTRO - Obrigatoriedades de preenchimento
    *--------------------------------------------------------------------------
    this_cCfgcdgcr        = ""   && cfgcdgcr char(40) - Config flags empacotados

    *-- Posicoes do CfgCdGcr (armazenados em cfgcdgcr):
    *-- Pos 1: ObrMails, Pos 2: ObrNome, Pos 3: VincPgRcs, Pos 4: ObrSit
    *-- Pos 5: Cpffixo, Pos 6: Carac, Pos 7: AceJob

    this_cDescsit         = ""   && descsit char(16) - Situacao Padrao
    this_nCpfobrigs       = 0    && cpfobrigs numeric(1,0) - CPF/CNPJ Obrigatorio
    this_nRgobrigs        = 0    && rgobrigs numeric(1,0) - RG/IE Obrigatorio
    this_nMfotos          = 0    && mfotos numeric(1,0) - Mostrar Foto
    this_nObservas        = 0    && observas numeric(1,0) - Observacao
    this_nInfcads         = 0    && infcads numeric(1,0) - Info Cadastrais
    this_nCalcimeds       = 0    && calcimeds numeric(1,0) - Calc. Imediato
    this_cDesccalcimeds   = ""   && desccalcimeds char(16) - Desc Calc Imediato
    this_nFpublsobr       = 0    && fpublsobr numeric(1,0) - Func.Publico Obrig.
    this_cDescfpubls      = ""   && descfpubls char(16) - Desc Func.Publico
    this_nInfsenha        = 0    && infsenha numeric(1,0) - Info Senha
    this_nLogalt          = 0    && logalt numeric(1,0) - Log Alteracao

    *-- Endereco
    this_nEndobr          = 0    && endobr numeric(1,0) - Endereco Obrigatorio
    this_nNumobr          = 0    && numobr numeric(1,0) - Numero Obrigatorio
    this_nBairroobr       = 0    && bairroobr numeric(1,0) - Bairro Obrigatorio
    this_nCidasobr        = 0    && cidasobr numeric(1,0) - Cidade Obrigatoria
    this_nCepobris        = 0    && cepobris numeric(1,0) - CEP Obrigatorio
    this_nPaisesobr       = 0    && paisesobr numeric(1,0) - Pais Obrigatorio
    this_nChkendds        = 0    && chkendds numeric(1,0) - Checa Duplic. Endereco
    this_nChkendrs        = 0    && chkendrs numeric(1,0) - Checa Restric. Endereco

    *-- Telefone e outros dados pessoais
    this_nTel1obr         = 0    && tel1obr numeric(1,0) - Telefone 1 Obrigatorio
    this_nTel2obr         = 0    && tel2obr numeric(1,0) - Telefone 2 Obrigatorio
    this_nNascobr         = 0    && nascobr numeric(1,0) - Nascimento Obrigatorio
    this_nSexobr          = 0    && sexobr numeric(1,0) - Sexo Obrigatorio
    this_nDtnascobr       = 0    && dtnascobr numeric(1,0) - Data Nasc. Obrigatoria
    this_nDtespobr        = 0    && dtespobr numeric(1,0) - Data Espera Obrigatoria
    this_nObrtelefone     = 0    && Obrtelefone numeric(1,0) - Telefone Obrigatorio
    this_cDesctlm         = ""   && desctlm char(16) - Desc Telemarketing
    this_cDesccla         = ""   && desccla char(16) - Desc Classificacao
    this_cDescseg         = ""   && descseg char(16) - Desc Segmento

    *-- Financeiro no Cadastro
    this_cContconts       = ""   && contconts char(9) - Conta Interna
    this_nIntconts        = 0    && intconts numeric(1,0) - Integracao Contabil
    this_nPadpgrecs       = 0    && padpgrecs numeric(1,0) - Padrao Preenchimento
    this_nCtvinculas      = 0    && ctvinculas numeric(1,0) - Vincula Contas PG/RC
    this_nTitbaixado      = 0    && titbaixado numeric(1,0) - Visualiza Tit.nao Baixados
    this_cContapdr        = ""   && contapdr char(10) - Conta Padrao
    this_nCcustotit       = 0    && ccustotit numeric(1,0) - C.Custo por Titulo

    *-- Alerta Cadastro
    this_nDefhideshow     = 0    && defhideshow numeric(1,0) - Emitir Mensagem Alerta
    this_nCtainatv        = 0    && ctainatv numeric(1,0) - Conta Inativa

    *--------------------------------------------------------------------------
    * ABA ESTOQUE
    *--------------------------------------------------------------------------
    this_nEstoques        = 0    && estoques numeric(1,0) - Avalia Estoque
    this_nLimestoqs       = 0    && limestoqs numeric(1,0) - Limite de Estoque
    this_nVerests         = 0    && verests numeric(1,0) - Verifica Estoque
    this_nEmprelevs       = 0    && emprelevs numeric(1,0) - Empresa Relevante
    this_nBlqcongvs       = 0    && blqcongvs numeric(1,0) - Bloqueia Consulta GV
    this_nCalcsalds       = 0    && calcsalds numeric(1,0) - Calculo de Saldo
    this_nChklimests      = 0    && chklimests numeric(1,0) - Checa Limite Estoque
    this_nPatrietqs       = 0    && patrietqs numeric(1,0) - Patrimonial por Etiqueta
    this_nCcustos         = 0    && ccustos numeric(1,0) - Centro de Custos
    this_nGerbals         = 0    && gerbals numeric(1,0) - Gerar Balanco
    this_nUnifbals        = 0    && unifbals numeric(1,0) - Balanco Unificado
    this_nBalfalpers      = 0    && balfalpers numeric(1,0) - Balanco Falhas/Perdas
    this_nBlqdivops       = 0    && blqdivops numeric(1,0) - Bloqueia Divisao OF
    this_nInvisivel       = 0    && invisivel numeric(1,0) - Grupo nao Selecionavel
    this_nDdfutus         = 0    && ddfutus numeric(5,0) - Dias Bloqueio Futuro
    this_nDdretros        = 0    && ddretros numeric(5,0) - Dias Bloqueio Retroativo
    this_nDdsems          = 0    && ddsems numeric(1,0) - Dias em Semanas
    this_nHordd           = 0    && hordd numeric(4,2) - Hora DD
    this_nTipoinvs        = 0    && tipoinvs numeric(1,0) - Tipo Inventario

    *-- Industria / Fabrica
    this_nTrfpesas        = 0    && trfpesas numeric(1,0) - Transfere Peso
    this_nDifpesags       = 0    && difpesags numeric(9,3) - Diferenca de Peso
    this_nSinals          = 0    && sinals numeric(1,0) - Sinal (+/-)
    this_cPqs             = ""   && pqs char(1) - P ou Q (tipo falha)
    this_nCompagrus       = 0    && compagrus numeric(1,0) - Agrupa Componentes
    this_cAgrupas         = ""   && agrupas char(10) - Agrupamento
    this_nFichatecs       = 0    && fichatecs numeric(1,0) - Ficha Tecnica
    this_cOsalfuns        = ""   && osalfuns char(3) - Os/Alianca/Fundicao flags
    this_cGrufals         = ""   && grufals char(10) - Grupo Falha/Diferenca Balanco
    this_nOspends         = 0    && ospends numeric(1,0) - OS Pendente Dt.Entrega
    this_nChktits         = 0    && chktits numeric(1,0) - Checa Duplicidade Titulo
    this_nTpprecos        = 0    && tpprecos numeric(1,0) - Tipo de Preco
    this_cContafalha      = ""   && contafalha char(10) - Conta Falha
    this_cGrupofalha      = ""   && grupofalha char(10) - Grupo Falha
    this_nCtrlotes        = 0    && ctrlotes numeric(1,0) - Controle de Lote

    *--------------------------------------------------------------------------
    * ABA FATURAMENTO - Configuracoes fiscais por imposto
    * Formato empacotado: grupo(10)+conta(10)+descricao(40)+aliq(9.4)+receita(8)
    *--------------------------------------------------------------------------
    this_cCfgfisics       = ""   && cfgfisics char(50) - ICMS
    this_cCfgfisips       = ""   && cfgfisips char(50) - IPI
    this_cCfgfisiis       = ""   && cfgfisiis char(50) - II
    this_cCfgfisiss       = ""   && cfgfisiss char(50) - ISS
    this_cCfgfisirs       = ""   && cfgfisirs char(50) - IRRF
    this_cCfgfisins       = ""   && cfgfisins char(50) - INSS
    this_cCfgfispis       = ""   && cfgfispis char(50) - PIS
    this_cCfgfiscss       = ""   && cfgfiscss char(50) - CSSL
    this_cCfgfiscos       = ""   && cfgfiscos char(50) - COFINS

    *==========================================================================
    * INIT
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela      = "SigCdGcr"
        THIS.this_cCampoChave  = "codigos"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDPROC

    *==========================================================================
    * Buscar - Carrega lista de grupos de contas correntes no cursor_4c_Dados
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(par_cFiltro)
                loc_cSQL = "SELECT a.codigos, a.descrs, a.classes, ISNULL(b.Descrs,'') AS DClasses" + ;
                           " FROM SigCdGcr a" + ;
                           " LEFT JOIN SigCdCss b ON a.Classes = b.Classes" + ;
                           " ORDER BY a.codigos"
            ELSE
                loc_cSQL = "SELECT a.codigos, a.descrs, a.classes, ISNULL(b.Descrs,'') AS DClasses" + ;
                           " FROM SigCdGcr a" + ;
                           " LEFT JOIN SigCdCss b ON a.Classes = b.Classes" + ;
                           " WHERE RTRIM(a.codigos) LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                           " OR RTRIM(a.descrs) LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                           " ORDER BY a.codigos"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar grupos de contas correntes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar grupos de contas correntes:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega um registro pelo codigo (PK)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.*, ISNULL(b.Descrs,'') AS DClasses" + ;
                       " FROM SigCdGcr a" + ;
                       " LEFT JOIN SigCdCss b ON a.Classes = b.Classes" + ;
                       " WHERE RTRIM(a.codigos) = " + EscaparSQL(ALLTRIM(par_cCodigos))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar grupo de contas correntes:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos         = TratarNulo(codigos, "C")
            THIS.this_cDescrs          = TratarNulo(descrs, "C")
            THIS.this_cDgcods          = TratarNulo(dgcods, "C")
            THIS.this_cInternos        = TratarNulo(internos, "C")
            THIS.this_cClasses         = TratarNulo(classes, "C")
            THIS.this_cDClasses        = TratarNulo(DClasses, "C")
            THIS.this_nTpcods          = TratarNulo(tpcods, "N")
            THIS.this_nTpemps          = TratarNulo(tpemps, "N")
            THIS.this_nTpcads          = TratarNulo(tpcads, "N")
            THIS.this_nComplems        = TratarNulo(complems, "N")
            THIS.this_nPessoais        = TratarNulo(pessoais, "N")
            THIS.this_nRefbancs        = TratarNulo(refbancs, "N")
            THIS.this_nFollowups       = TratarNulo(followups, "N")
            THIS.this_nFiscais         = TratarNulo(fiscais, "N")
            THIS.this_nContabs         = TratarNulo(contabs, "N")
            THIS.this_nEmpresas        = TratarNulo(empresas, "N")
            THIS.this_nCaracteris      = TratarNulo(caracteris, "N")
            THIS.this_nRespos          = TratarNulo(respos, "N")
            THIS.this_nLimcres         = TratarNulo(limcres, "N")
            THIS.this_nComis           = TratarNulo(comis, "N")
            THIS.this_nDadcoms         = TratarNulo(dadcoms, "N")
            THIS.this_nCargos          = TratarNulo(cargos, "N")
            THIS.this_nChklimcrds      = TratarNulo(chklimcrds, "N")
            THIS.this_nColetors        = TratarNulo(coletors, "N")
            THIS.this_nPrecad          = TratarNulo(precad, "N")
            THIS.this_cGrupolms        = TratarNulo(grupolms, "C")
            THIS.this_nVrlimcre        = TratarNulo(vrlimcre, "N")
            THIS.this_cMolimcre        = TratarNulo(molimcre, "C")
            THIS.this_cCommoedas       = TratarNulo(commoedas, "C")
            THIS.this_cRodrelcc        = TratarNulo(rodrelcc, "C")
            THIS.this_cCfgcdgcr        = TratarNulo(cfgcdgcr, "C")
            THIS.this_cDescsit         = TratarNulo(descsit, "C")
            THIS.this_nCpfobrigs       = TratarNulo(cpfobrigs, "N")
            THIS.this_nRgobrigs        = TratarNulo(rgobrigs, "N")
            THIS.this_nMfotos          = TratarNulo(mfotos, "N")
            THIS.this_nObservas        = TratarNulo(observas, "N")
            THIS.this_nInfcads         = TratarNulo(infcads, "N")
            THIS.this_nCalcimeds       = TratarNulo(calcimeds, "N")
            THIS.this_cDesccalcimeds   = TratarNulo(desccalcimeds, "C")
            THIS.this_nFpublsobr       = TratarNulo(fpublsobr, "N")
            THIS.this_cDescfpubls      = TratarNulo(descfpubls, "C")
            THIS.this_nInfsenha        = TratarNulo(infsenha, "N")
            THIS.this_nLogalt          = TratarNulo(logalt, "N")
            THIS.this_nEndobr          = TratarNulo(endobr, "N")
            THIS.this_nNumobr          = TratarNulo(numobr, "N")
            THIS.this_nBairroobr       = TratarNulo(bairroobr, "N")
            THIS.this_nCidasobr        = TratarNulo(cidasobr, "N")
            THIS.this_nCepobris        = TratarNulo(cepobris, "N")
            THIS.this_nPaisesobr       = TratarNulo(paisesobr, "N")
            THIS.this_nChkendds        = TratarNulo(chkendds, "N")
            THIS.this_nChkendrs        = TratarNulo(chkendrs, "N")
            THIS.this_nTel1obr         = TratarNulo(tel1obr, "N")
            THIS.this_nTel2obr         = TratarNulo(tel2obr, "N")
            THIS.this_nNascobr         = TratarNulo(nascobr, "N")
            THIS.this_nSexobr          = TratarNulo(sexobr, "N")
            THIS.this_nDtnascobr       = TratarNulo(dtnascobr, "N")
            THIS.this_nDtespobr        = TratarNulo(dtespobr, "N")
            THIS.this_nObrtelefone     = TratarNulo(Obrtelefone, "N")
            THIS.this_cDesctlm         = TratarNulo(desctlm, "C")
            THIS.this_cDesccla         = TratarNulo(desccla, "C")
            THIS.this_cDescseg         = TratarNulo(descseg, "C")
            THIS.this_cContconts       = TratarNulo(contconts, "C")
            THIS.this_nIntconts        = TratarNulo(intconts, "N")
            THIS.this_nPadpgrecs       = TratarNulo(padpgrecs, "N")
            THIS.this_nCtvinculas      = TratarNulo(ctvinculas, "N")
            THIS.this_nTitbaixado      = TratarNulo(titbaixado, "N")
            THIS.this_cContapdr        = TratarNulo(contapdr, "C")
            THIS.this_nCcustotit       = TratarNulo(ccustotit, "N")
            THIS.this_nDefhideshow     = TratarNulo(defhideshow, "N")
            THIS.this_nCtainatv        = TratarNulo(ctainatv, "N")
            THIS.this_nEstoques        = TratarNulo(estoques, "N")
            THIS.this_nLimestoqs       = TratarNulo(limestoqs, "N")
            THIS.this_nVerests         = TratarNulo(verests, "N")
            THIS.this_nEmprelevs       = TratarNulo(emprelevs, "N")
            THIS.this_nBlqcongvs       = TratarNulo(blqcongvs, "N")
            THIS.this_nCalcsalds       = TratarNulo(calcsalds, "N")
            THIS.this_nChklimests      = TratarNulo(chklimests, "N")
            THIS.this_nPatrietqs       = TratarNulo(patrietqs, "N")
            THIS.this_nCcustos         = TratarNulo(ccustos, "N")
            THIS.this_nGerbals         = TratarNulo(gerbals, "N")
            THIS.this_nUnifbals        = TratarNulo(unifbals, "N")
            THIS.this_nBalfalpers      = TratarNulo(balfalpers, "N")
            THIS.this_nBlqdivops       = TratarNulo(blqdivops, "N")
            THIS.this_nInvisivel       = TratarNulo(invisivel, "N")
            THIS.this_nDdfutus         = TratarNulo(ddfutus, "N")
            THIS.this_nDdretros        = TratarNulo(ddretros, "N")
            THIS.this_nDdsems          = TratarNulo(ddsems, "N")
            THIS.this_nHordd           = TratarNulo(hordd, "N")
            THIS.this_nTipoinvs        = TratarNulo(tipoinvs, "N")
            THIS.this_nTrfpesas        = TratarNulo(trfpesas, "N")
            THIS.this_nDifpesags       = TratarNulo(difpesags, "N")
            THIS.this_nSinals          = TratarNulo(sinals, "N")
            THIS.this_cPqs             = TratarNulo(pqs, "C")
            THIS.this_nCompagrus       = TratarNulo(compagrus, "N")
            THIS.this_cAgrupas         = TratarNulo(agrupas, "C")
            THIS.this_nFichatecs       = TratarNulo(fichatecs, "N")
            THIS.this_cOsalfuns        = TratarNulo(osalfuns, "C")
            THIS.this_cGrufals         = TratarNulo(grufals, "C")
            THIS.this_nOspends         = TratarNulo(ospends, "N")
            THIS.this_nChktits         = TratarNulo(chktits, "N")
            THIS.this_nTpprecos        = TratarNulo(tpprecos, "N")
            THIS.this_cContafalha      = TratarNulo(contafalha, "C")
            THIS.this_cGrupofalha      = TratarNulo(grupofalha, "C")
            THIS.this_nCtrlotes        = TratarNulo(ctrlotes, "N")
            THIS.this_cCfgfisics       = TratarNulo(cfgfisics, "C")
            THIS.this_cCfgfisips       = TratarNulo(cfgfisips, "C")
            THIS.this_cCfgfisiis       = TratarNulo(cfgfisiis, "C")
            THIS.this_cCfgfisiss       = TratarNulo(cfgfisiss, "C")
            THIS.this_cCfgfisirs       = TratarNulo(cfgfisirs, "C")
            THIS.this_cCfgfisins       = TratarNulo(cfgfisins, "C")
            THIS.this_cCfgfispis       = TratarNulo(cfgfispis, "C")
            THIS.this_cCfgfiscss       = TratarNulo(cfgfiscss, "C")
            THIS.this_cCfgfiscos       = TratarNulo(cfgfiscos, "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - INSERT na tabela SigCdGcr
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdGcr (" + ;
                       "codigos,descrs,dgcods,internos,classes," + ;
                       "tpcods,tpemps,tpcads,complems,pessoais," + ;
                       "refbancs,followups,fiscais,contabs,empresas," + ;
                       "caracteris,respos,limcres,comis,dadcoms," + ;
                       "cargos,chklimcrds,coletors,precad,grupolms," + ;
                       "vrlimcre,molimcre,commoedas,rodrelcc,cfgcdgcr," + ;
                       "descsit,cpfobrigs,rgobrigs,mfotos,observas," + ;
                       "infcads,calcimeds,desccalcimeds,fpublsobr,descfpubls," + ;
                       "infsenha,logalt,endobr,numobr,bairroobr," + ;
                       "cidasobr,cepobris,paisesobr,chkendds,chkendrs," + ;
                       "tel1obr,tel2obr,nascobr,sexobr,dtnascobr," + ;
                       "dtespobr,obrtelefone,desctlm,desccla,descseg," + ;
                       "contconts,intconts,padpgrecs,ctvinculas,titbaixado," + ;
                       "contapdr,ccustotit,defhideshow,ctainatv,estoques," + ;
                       "limestoqs,verests,emprelevs,blqcongvs,calcsalds," + ;
                       "chklimests,patrietqs,ccustos,gerbals,unifbals," + ;
                       "balfalpers,blqdivops,invisivel,ddfutus,ddretros," + ;
                       "ddsems,hordd,tipoinvs,trfpesas,difpesags," + ;
                       "sinals,pqs,compagrus,agrupas,fichatecs," + ;
                       "osalfuns,grufals,ospends,chktits,tpprecos," + ;
                       "contafalha,grupofalha,ctrlotes," + ;
                       "cfgfisics,cfgfisips,cfgfisiis,cfgfisiss,cfgfisirs," + ;
                       "cfgfisins,cfgfispis,cfgfiscss,cfgfiscos" + ;
                       ") VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigos) + "," + ;
                       EscaparSQL(THIS.this_cDescrs) + "," + ;
                       EscaparSQL(THIS.this_cDgcods) + "," + ;
                       EscaparSQL(THIS.this_cInternos) + "," + ;
                       EscaparSQL(THIS.this_cClasses) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTpcods) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTpemps) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTpcads) + "," + ;
                       FormatarNumeroSQL(THIS.this_nComplems) + "," + ;
                       FormatarNumeroSQL(THIS.this_nPessoais) + "," + ;
                       FormatarNumeroSQL(THIS.this_nRefbancs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nFollowups) + "," + ;
                       FormatarNumeroSQL(THIS.this_nFiscais) + "," + ;
                       FormatarNumeroSQL(THIS.this_nContabs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nEmpresas) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCaracteris) + "," + ;
                       FormatarNumeroSQL(THIS.this_nRespos) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLimcres) + "," + ;
                       FormatarNumeroSQL(THIS.this_nComis) + "," + ;
                       FormatarNumeroSQL(THIS.this_nDadcoms) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCargos) + "," + ;
                       FormatarNumeroSQL(THIS.this_nChklimcrds) + "," + ;
                       FormatarNumeroSQL(THIS.this_nColetors) + "," + ;
                       FormatarNumeroSQL(THIS.this_nPrecad) + "," + ;
                       EscaparSQL(THIS.this_cGrupolms) + "," + ;
                       FormatarNumeroSQL(THIS.this_nVrlimcre) + "," + ;
                       EscaparSQL(THIS.this_cMolimcre) + "," + ;
                       EscaparSQL(THIS.this_cCommoedas) + "," + ;
                       EscaparSQL(THIS.this_cRodrelcc) + "," + ;
                       EscaparSQL(THIS.this_cCfgcdgcr) + "," + ;
                       EscaparSQL(THIS.this_cDescsit) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCpfobrigs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nRgobrigs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nMfotos) + "," + ;
                       FormatarNumeroSQL(THIS.this_nObservas) + "," + ;
                       FormatarNumeroSQL(THIS.this_nInfcads) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCalcimeds) + "," + ;
                       EscaparSQL(THIS.this_cDesccalcimeds) + "," + ;
                       FormatarNumeroSQL(THIS.this_nFpublsobr) + "," + ;
                       EscaparSQL(THIS.this_cDescfpubls) + "," + ;
                       FormatarNumeroSQL(THIS.this_nInfsenha) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLogalt) + "," + ;
                       FormatarNumeroSQL(THIS.this_nEndobr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nNumobr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nBairroobr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCidasobr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCepobris) + "," + ;
                       FormatarNumeroSQL(THIS.this_nPaisesobr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nChkendds) + "," + ;
                       FormatarNumeroSQL(THIS.this_nChkendrs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTel1obr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTel2obr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nNascobr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nSexobr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nDtnascobr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nDtespobr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nObrtelefone) + "," + ;
                       EscaparSQL(THIS.this_cDesctlm) + "," + ;
                       EscaparSQL(THIS.this_cDesccla) + "," + ;
                       EscaparSQL(THIS.this_cDescseg) + "," + ;
                       EscaparSQL(THIS.this_cContconts) + "," + ;
                       FormatarNumeroSQL(THIS.this_nIntconts) + "," + ;
                       FormatarNumeroSQL(THIS.this_nPadpgrecs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCtvinculas) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTitbaixado) + "," + ;
                       EscaparSQL(THIS.this_cContapdr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCcustotit) + "," + ;
                       FormatarNumeroSQL(THIS.this_nDefhideshow) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCtainatv) + "," + ;
                       FormatarNumeroSQL(THIS.this_nEstoques) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLimestoqs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nVerests) + "," + ;
                       FormatarNumeroSQL(THIS.this_nEmprelevs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nBlqcongvs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCalcsalds) + "," + ;
                       FormatarNumeroSQL(THIS.this_nChklimests) + "," + ;
                       FormatarNumeroSQL(THIS.this_nPatrietqs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCcustos) + "," + ;
                       FormatarNumeroSQL(THIS.this_nGerbals) + "," + ;
                       FormatarNumeroSQL(THIS.this_nUnifbals) + "," + ;
                       FormatarNumeroSQL(THIS.this_nBalfalpers) + "," + ;
                       FormatarNumeroSQL(THIS.this_nBlqdivops) + "," + ;
                       FormatarNumeroSQL(THIS.this_nInvisivel) + "," + ;
                       FormatarNumeroSQL(THIS.this_nDdfutus) + "," + ;
                       FormatarNumeroSQL(THIS.this_nDdretros) + "," + ;
                       FormatarNumeroSQL(THIS.this_nDdsems) + "," + ;
                       FormatarNumeroSQL(THIS.this_nHordd) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTipoinvs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTrfpesas) + "," + ;
                       FormatarNumeroSQL(THIS.this_nDifpesags) + "," + ;
                       FormatarNumeroSQL(THIS.this_nSinals) + "," + ;
                       EscaparSQL(THIS.this_cPqs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCompagrus) + "," + ;
                       EscaparSQL(THIS.this_cAgrupas) + "," + ;
                       FormatarNumeroSQL(THIS.this_nFichatecs) + "," + ;
                       EscaparSQL(THIS.this_cOsalfuns) + "," + ;
                       EscaparSQL(THIS.this_cGrufals) + "," + ;
                       FormatarNumeroSQL(THIS.this_nOspends) + "," + ;
                       FormatarNumeroSQL(THIS.this_nChktits) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTpprecos) + "," + ;
                       EscaparSQL(THIS.this_cContafalha) + "," + ;
                       EscaparSQL(THIS.this_cGrupofalha) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCtrlotes) + "," + ;
                       EscaparSQL(THIS.this_cCfgfisics) + "," + ;
                       EscaparSQL(THIS.this_cCfgfisips) + "," + ;
                       EscaparSQL(THIS.this_cCfgfisiis) + "," + ;
                       EscaparSQL(THIS.this_cCfgfisiss) + "," + ;
                       EscaparSQL(THIS.this_cCfgfisirs) + "," + ;
                       EscaparSQL(THIS.this_cCfgfisins) + "," + ;
                       EscaparSQL(THIS.this_cCfgfispis) + "," + ;
                       EscaparSQL(THIS.this_cCfgfiscss) + "," + ;
                       EscaparSQL(THIS.this_cCfgfiscos) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir grupo de contas correntes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir grupo de contas correntes:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE na tabela SigCdGcr
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdGcr SET" + ;
                       " descrs=" + EscaparSQL(THIS.this_cDescrs) + "," + ;
                       " dgcods=" + EscaparSQL(THIS.this_cDgcods) + "," + ;
                       " internos=" + EscaparSQL(THIS.this_cInternos) + "," + ;
                       " classes=" + EscaparSQL(THIS.this_cClasses) + "," + ;
                       " tpcods=" + FormatarNumeroSQL(THIS.this_nTpcods) + "," + ;
                       " tpemps=" + FormatarNumeroSQL(THIS.this_nTpemps) + "," + ;
                       " tpcads=" + FormatarNumeroSQL(THIS.this_nTpcads) + "," + ;
                       " complems=" + FormatarNumeroSQL(THIS.this_nComplems) + "," + ;
                       " pessoais=" + FormatarNumeroSQL(THIS.this_nPessoais) + "," + ;
                       " refbancs=" + FormatarNumeroSQL(THIS.this_nRefbancs) + "," + ;
                       " followups=" + FormatarNumeroSQL(THIS.this_nFollowups) + "," + ;
                       " fiscais=" + FormatarNumeroSQL(THIS.this_nFiscais) + "," + ;
                       " contabs=" + FormatarNumeroSQL(THIS.this_nContabs) + "," + ;
                       " empresas=" + FormatarNumeroSQL(THIS.this_nEmpresas) + "," + ;
                       " caracteris=" + FormatarNumeroSQL(THIS.this_nCaracteris) + "," + ;
                       " respos=" + FormatarNumeroSQL(THIS.this_nRespos) + "," + ;
                       " limcres=" + FormatarNumeroSQL(THIS.this_nLimcres) + "," + ;
                       " comis=" + FormatarNumeroSQL(THIS.this_nComis) + "," + ;
                       " dadcoms=" + FormatarNumeroSQL(THIS.this_nDadcoms) + "," + ;
                       " cargos=" + FormatarNumeroSQL(THIS.this_nCargos) + "," + ;
                       " chklimcrds=" + FormatarNumeroSQL(THIS.this_nChklimcrds) + "," + ;
                       " coletors=" + FormatarNumeroSQL(THIS.this_nColetors) + "," + ;
                       " precad=" + FormatarNumeroSQL(THIS.this_nPrecad) + "," + ;
                       " grupolms=" + EscaparSQL(THIS.this_cGrupolms) + "," + ;
                       " vrlimcre=" + FormatarNumeroSQL(THIS.this_nVrlimcre) + "," + ;
                       " molimcre=" + EscaparSQL(THIS.this_cMolimcre) + "," + ;
                       " commoedas=" + EscaparSQL(THIS.this_cCommoedas) + "," + ;
                       " rodrelcc=" + EscaparSQL(THIS.this_cRodrelcc) + "," + ;
                       " cfgcdgcr=" + EscaparSQL(THIS.this_cCfgcdgcr) + "," + ;
                       " descsit=" + EscaparSQL(THIS.this_cDescsit) + "," + ;
                       " cpfobrigs=" + FormatarNumeroSQL(THIS.this_nCpfobrigs) + "," + ;
                       " rgobrigs=" + FormatarNumeroSQL(THIS.this_nRgobrigs) + "," + ;
                       " mfotos=" + FormatarNumeroSQL(THIS.this_nMfotos) + "," + ;
                       " observas=" + FormatarNumeroSQL(THIS.this_nObservas) + "," + ;
                       " infcads=" + FormatarNumeroSQL(THIS.this_nInfcads) + "," + ;
                       " calcimeds=" + FormatarNumeroSQL(THIS.this_nCalcimeds) + "," + ;
                       " desccalcimeds=" + EscaparSQL(THIS.this_cDesccalcimeds) + "," + ;
                       " fpublsobr=" + FormatarNumeroSQL(THIS.this_nFpublsobr) + "," + ;
                       " descfpubls=" + EscaparSQL(THIS.this_cDescfpubls) + "," + ;
                       " infsenha=" + FormatarNumeroSQL(THIS.this_nInfsenha) + "," + ;
                       " logalt=" + FormatarNumeroSQL(THIS.this_nLogalt) + "," + ;
                       " endobr=" + FormatarNumeroSQL(THIS.this_nEndobr) + "," + ;
                       " numobr=" + FormatarNumeroSQL(THIS.this_nNumobr) + "," + ;
                       " bairroobr=" + FormatarNumeroSQL(THIS.this_nBairroobr) + "," + ;
                       " cidasobr=" + FormatarNumeroSQL(THIS.this_nCidasobr) + "," + ;
                       " cepobris=" + FormatarNumeroSQL(THIS.this_nCepobris) + "," + ;
                       " paisesobr=" + FormatarNumeroSQL(THIS.this_nPaisesobr) + "," + ;
                       " chkendds=" + FormatarNumeroSQL(THIS.this_nChkendds) + "," + ;
                       " chkendrs=" + FormatarNumeroSQL(THIS.this_nChkendrs) + "," + ;
                       " tel1obr=" + FormatarNumeroSQL(THIS.this_nTel1obr) + "," + ;
                       " tel2obr=" + FormatarNumeroSQL(THIS.this_nTel2obr) + "," + ;
                       " nascobr=" + FormatarNumeroSQL(THIS.this_nNascobr) + "," + ;
                       " sexobr=" + FormatarNumeroSQL(THIS.this_nSexobr) + "," + ;
                       " dtnascobr=" + FormatarNumeroSQL(THIS.this_nDtnascobr) + "," + ;
                       " dtespobr=" + FormatarNumeroSQL(THIS.this_nDtespobr) + "," + ;
                       " obrtelefone=" + FormatarNumeroSQL(THIS.this_nObrtelefone) + "," + ;
                       " desctlm=" + EscaparSQL(THIS.this_cDesctlm) + "," + ;
                       " desccla=" + EscaparSQL(THIS.this_cDesccla) + "," + ;
                       " descseg=" + EscaparSQL(THIS.this_cDescseg) + "," + ;
                       " contconts=" + EscaparSQL(THIS.this_cContconts) + "," + ;
                       " intconts=" + FormatarNumeroSQL(THIS.this_nIntconts) + "," + ;
                       " padpgrecs=" + FormatarNumeroSQL(THIS.this_nPadpgrecs) + "," + ;
                       " ctvinculas=" + FormatarNumeroSQL(THIS.this_nCtvinculas) + "," + ;
                       " titbaixado=" + FormatarNumeroSQL(THIS.this_nTitbaixado) + "," + ;
                       " contapdr=" + EscaparSQL(THIS.this_cContapdr) + "," + ;
                       " ccustotit=" + FormatarNumeroSQL(THIS.this_nCcustotit) + "," + ;
                       " defhideshow=" + FormatarNumeroSQL(THIS.this_nDefhideshow) + "," + ;
                       " ctainatv=" + FormatarNumeroSQL(THIS.this_nCtainatv) + "," + ;
                       " estoques=" + FormatarNumeroSQL(THIS.this_nEstoques) + "," + ;
                       " limestoqs=" + FormatarNumeroSQL(THIS.this_nLimestoqs) + "," + ;
                       " verests=" + FormatarNumeroSQL(THIS.this_nVerests) + "," + ;
                       " emprelevs=" + FormatarNumeroSQL(THIS.this_nEmprelevs) + "," + ;
                       " blqcongvs=" + FormatarNumeroSQL(THIS.this_nBlqcongvs) + "," + ;
                       " calcsalds=" + FormatarNumeroSQL(THIS.this_nCalcsalds) + "," + ;
                       " chklimests=" + FormatarNumeroSQL(THIS.this_nChklimests) + "," + ;
                       " patrietqs=" + FormatarNumeroSQL(THIS.this_nPatrietqs) + "," + ;
                       " ccustos=" + FormatarNumeroSQL(THIS.this_nCcustos) + "," + ;
                       " gerbals=" + FormatarNumeroSQL(THIS.this_nGerbals) + "," + ;
                       " unifbals=" + FormatarNumeroSQL(THIS.this_nUnifbals) + "," + ;
                       " balfalpers=" + FormatarNumeroSQL(THIS.this_nBalfalpers) + "," + ;
                       " blqdivops=" + FormatarNumeroSQL(THIS.this_nBlqdivops) + "," + ;
                       " invisivel=" + FormatarNumeroSQL(THIS.this_nInvisivel) + "," + ;
                       " ddfutus=" + FormatarNumeroSQL(THIS.this_nDdfutus) + "," + ;
                       " ddretros=" + FormatarNumeroSQL(THIS.this_nDdretros) + "," + ;
                       " ddsems=" + FormatarNumeroSQL(THIS.this_nDdsems) + "," + ;
                       " hordd=" + FormatarNumeroSQL(THIS.this_nHordd) + "," + ;
                       " tipoinvs=" + FormatarNumeroSQL(THIS.this_nTipoinvs) + "," + ;
                       " trfpesas=" + FormatarNumeroSQL(THIS.this_nTrfpesas) + "," + ;
                       " difpesags=" + FormatarNumeroSQL(THIS.this_nDifpesags) + "," + ;
                       " sinals=" + FormatarNumeroSQL(THIS.this_nSinals) + "," + ;
                       " pqs=" + EscaparSQL(THIS.this_cPqs) + "," + ;
                       " compagrus=" + FormatarNumeroSQL(THIS.this_nCompagrus) + "," + ;
                       " agrupas=" + EscaparSQL(THIS.this_cAgrupas) + "," + ;
                       " fichatecs=" + FormatarNumeroSQL(THIS.this_nFichatecs) + "," + ;
                       " osalfuns=" + EscaparSQL(THIS.this_cOsalfuns) + "," + ;
                       " grufals=" + EscaparSQL(THIS.this_cGrufals) + "," + ;
                       " ospends=" + FormatarNumeroSQL(THIS.this_nOspends) + "," + ;
                       " chktits=" + FormatarNumeroSQL(THIS.this_nChktits) + "," + ;
                       " tpprecos=" + FormatarNumeroSQL(THIS.this_nTpprecos) + "," + ;
                       " contafalha=" + EscaparSQL(THIS.this_cContafalha) + "," + ;
                       " grupofalha=" + EscaparSQL(THIS.this_cGrupofalha) + "," + ;
                       " ctrlotes=" + FormatarNumeroSQL(THIS.this_nCtrlotes) + "," + ;
                       " cfgfisics=" + EscaparSQL(THIS.this_cCfgfisics) + "," + ;
                       " cfgfisips=" + EscaparSQL(THIS.this_cCfgfisips) + "," + ;
                       " cfgfisiis=" + EscaparSQL(THIS.this_cCfgfisiis) + "," + ;
                       " cfgfisiss=" + EscaparSQL(THIS.this_cCfgfisiss) + "," + ;
                       " cfgfisirs=" + EscaparSQL(THIS.this_cCfgfisirs) + "," + ;
                       " cfgfisins=" + EscaparSQL(THIS.this_cCfgfisins) + "," + ;
                       " cfgfispis=" + EscaparSQL(THIS.this_cCfgfispis) + "," + ;
                       " cfgfiscss=" + EscaparSQL(THIS.this_cCfgfiscss) + "," + ;
                       " cfgfiscos=" + EscaparSQL(THIS.this_cCfgfiscos) + ;
                       " WHERE codigos=" + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar grupo de contas correntes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar grupo de contas correntes:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - DELETE da tabela SigCdGcr com verificacao de dependencias
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_cCodigo, loc_nCount, loc_nResultado, loc_lSucesso, loc_lBloqueado
        loc_lSucesso  = .F.
        loc_lBloqueado = .F.
        loc_cCodigo   = EscaparSQL(ALLTRIM(THIS.this_cCodigos))

        TRY
            IF !loc_lBloqueado
                loc_cSQL = "SELECT COUNT(*) AS cnt FROM SigMvCcr WHERE RTRIM(Grupos) = " + loc_cCodigo
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Chk") >= 0
                    SELECT cursor_4c_Chk
                    loc_nCount = cursor_4c_Chk.cnt
                    USE IN cursor_4c_Chk
                    IF loc_nCount > 0
                        loc_lBloqueado = .T.
                    ENDIF
                ENDIF
            ENDIF

            IF !loc_lBloqueado
                loc_cSQL = "SELECT COUNT(*) AS cnt FROM SigCdCli WHERE RTRIM(Grupos) = " + loc_cCodigo
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Chk") >= 0
                    SELECT cursor_4c_Chk
                    loc_nCount = cursor_4c_Chk.cnt
                    USE IN cursor_4c_Chk
                    IF loc_nCount > 0
                        loc_lBloqueado = .T.
                    ENDIF
                ENDIF
            ENDIF

            IF !loc_lBloqueado
                loc_cSQL = "SELECT COUNT(*) AS cnt FROM SigMvCab WHERE RTRIM(Grupos) = " + loc_cCodigo
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Chk") >= 0
                    SELECT cursor_4c_Chk
                    loc_nCount = cursor_4c_Chk.cnt
                    USE IN cursor_4c_Chk
                    IF loc_nCount > 0
                        loc_lBloqueado = .T.
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lBloqueado
                MsgAviso("Aten" + CHR(231) + CHR(227) + "o!!! Existem Lan" + CHR(231) + "amentos Efetuados Neste Grupo!!!" + CHR(13) + ;
                        "Exclua Todos os Lan" + CHR(231) + "amentos Antes de Excluir o Grupo!!!", "ERRO!!!")
            ELSE
                loc_cSQL = "DELETE FROM SigCdGcr WHERE codigos = " + loc_cCodigo
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao excluir grupo de contas correntes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_Chk")
                USE IN cursor_4c_Chk
            ENDIF
            MsgErro("Erro ao excluir grupo de contas correntes:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

