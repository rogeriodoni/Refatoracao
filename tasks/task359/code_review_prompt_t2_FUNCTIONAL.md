# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=11 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [LAYOUT-POSITION] Controle 'Get_grupo' (parent: SIGCDCCR.Pagina.Dados.PageFrame1.Estoque): Left original=179 vs migrado 'Get_grupo' Left=486 (diff=307px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formccr.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (6747 linhas total):

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
1729:             loc_oOpt.Buttons(loc_nI).AutoSize  = .F.
1730:             loc_oOpt.Buttons(loc_nI).FontName  = "Tahoma"
1731:             loc_oOpt.Buttons(loc_nI).FontSize  = 8
1732:             loc_oOpt.Buttons(loc_nI).ForeColor = RGB(90, 90, 90)
1733:             loc_oOpt.Buttons(loc_nI).Themes    = .F.
1734:         ENDFOR
1735:         loc_oOpt.Buttons(1).Caption  = "N" + CHR(227) + "o"
1736:         loc_oOpt.Buttons(2).Caption  = "Coletor 1"
1737:         loc_oOpt.Buttons(3).Caption  = "Coletor 2"
1738:         loc_oOpt.Buttons(4).Caption  = "Coletor 3"
1739:         loc_oOpt.Buttons(5).Caption  = "Coletor 4"
1740:         loc_oOpt.Buttons(6).Caption  = "Coletor 5"
1741:         loc_oOpt.Buttons(7).Caption  = "Coletor 6"
1742:         loc_oOpt.Buttons(8).Caption  = "Coletor 7"
1743:         loc_oOpt.Buttons(9).Caption  = "Coletor 8"
1744:         loc_oOpt.Buttons(10).Caption = "Coletor 9"
1745:         loc_oOpt.Buttons(11).Caption = "Coletor 10"
1746: 
1747:         *-- LEAD / Pre-Cadastro
1748:         par_oPg.AddObject("lbl_4c_LblPreCad", "Label")

*-- Linhas 1760 a 1803:
1760:             .Visible = .T.
1761:         ENDWITH
1762: 
1763:         par_oPg.AddObject("obj_4c_OptPreCad", "OptionGroup")
1764:         loc_oOpt = par_oPg.obj_4c_OptPreCad
1765:         WITH loc_oOpt
1766:             .ButtonCount = 2
1767:             .Top = 217
1768:             .Left = 751
1769:             .Width = 97
1770:             .Height = 23
1771:             .BackStyle = 0
1772:             .BorderStyle = 0
1773:             .Value = 1
1774:             .Visible = .T.
1775:         ENDWITH
1776:         loc_oOpt.Buttons(1).Caption = "Sim"
1777:         loc_oOpt.Buttons(1).Left = 5
1778:         loc_oOpt.Buttons(1).Top = 3
1779:         loc_oOpt.Buttons(1).Width = 40
1780:         loc_oOpt.Buttons(1).FontName = "Tahoma"
1781:         loc_oOpt.Buttons(1).FontSize = 8
1782:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
1783:         loc_oOpt.Buttons(1).Themes = .F.
1784:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
1785:         loc_oOpt.Buttons(2).Left = 48
1786:         loc_oOpt.Buttons(2).Top = 3
1787:         loc_oOpt.Buttons(2).Width = 44
1788:         loc_oOpt.Buttons(2).FontName = "Tahoma"
1789:         loc_oOpt.Buttons(2).FontSize = 8
1790:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
1791:         loc_oOpt.Buttons(2).Themes = .F.
1792: 
1793:         *-- Linha separadora
1794:         par_oPg.AddObject("lin_4c_Line1", "Line")
1795:         WITH par_oPg.lin_4c_Line1
1796:             .Top = 253
1797:             .Left = 17
1798:             .Width = 959
1799:             .Height = 1
1800:             .BorderColor = RGB(150,150,150)
1801:             .Visible = .T.
1802:         ENDWITH
1803: 

*-- Linhas 1837 a 1880:
1837:     *--------------------------------------------------------------------------
1838:     * CriarAbaCadastro - Controles da aba Cadastro (pgf_4c_1.Page2)
1839:     *--------------------------------------------------------------------------
1840:     PROTECTED PROCEDURE CriarAbaCadastro(par_oPg)
1841:         LOCAL loc_oOpt
1842: 
1843:         *-- Linhas separadoras
1844:         par_oPg.AddObject("lin_4c_Cad1", "Line")
1845:         WITH par_oPg.lin_4c_Cad1
1846:             .Top = 341
1847:             .Left = 17
1848:             .Width = 959
1849:             .Height = 1
1850:             .BorderColor = RGB(150,150,150)
1851:             .Visible = .T.
1852:         ENDWITH
1853: 
1854:         par_oPg.AddObject("lin_4c_Cad2", "Line")
1855:         WITH par_oPg.lin_4c_Cad2
1856:             .Top = 29
1857:             .Left = 344
1858:             .Width = 1
1859:             .Height = 312
1860:             .BorderColor = RGB(150,150,150)
1861:             .Visible = .T.
1862:         ENDWITH
1863: 
1864:         par_oPg.AddObject("lin_4c_Cad3", "Line")
1865:         WITH par_oPg.lin_4c_Cad3
1866:             .Top = 29
1867:             .Left = 583
1868:             .Width = 1
1869:             .Height = 312
1870:             .BorderColor = RGB(150,150,150)
1871:             .Visible = .T.
1872:         ENDWITH
1873: 
1874:         *-- Col 1: CPF/CNPJ Obrigatorio (3 btn)
1875:         par_oPg.AddObject("lbl_4c_LblCpfObrig", "Label")
1876:         WITH par_oPg.lbl_4c_LblCpfObrig
1877:             .Caption = "CPF/CNPJ Obrig.:"
1878:             .Top = 34
1879:             .Left = 17
1880:             .Width = 141

*-- Linhas 1887 a 1930:
1887:             .Visible = .T.
1888:         ENDWITH
1889: 
1890:         par_oPg.AddObject("Opt_CPFObrig", "OptionGroup")
1891:         loc_oOpt = par_oPg.Opt_CPFObrig
1892:         WITH loc_oOpt
1893:             .ButtonCount = 3
1894:             .Top = 34
1895:             .Left = 160
1896:             .Width = 201
1897:             .Height = 23
1898:             .BackStyle = 0
1899:             .BorderStyle = 0
1900:             .Value = 1
1901:             .Visible = .T.
1902:         ENDWITH
1903:         loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
1904:         loc_oOpt.Buttons(1).Left = 5
1905:         loc_oOpt.Buttons(1).Top = 3
1906:         loc_oOpt.Buttons(1).Width = 44
1907:         loc_oOpt.Buttons(1).FontName = "Tahoma"
1908:         loc_oOpt.Buttons(1).FontSize = 8
1909:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
1910:         loc_oOpt.Buttons(1).Themes = .F.
1911:         loc_oOpt.Buttons(2).Caption = "Opcional"
1912:         loc_oOpt.Buttons(2).Left = 55
1913:         loc_oOpt.Buttons(2).Top = 3
1914:         loc_oOpt.Buttons(2).Width = 65
1915:         loc_oOpt.Buttons(2).FontName = "Tahoma"
1916:         loc_oOpt.Buttons(2).FontSize = 8
1917:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
1918:         loc_oOpt.Buttons(2).Themes = .F.
1919:         loc_oOpt.Buttons(3).Caption = "Obrigat" + CHR(243) + "rio"
1920:         loc_oOpt.Buttons(3).Left = 125
1921:         loc_oOpt.Buttons(3).Top = 3
1922:         loc_oOpt.Buttons(3).Width = 70
1923:         loc_oOpt.Buttons(3).FontName = "Tahoma"
1924:         loc_oOpt.Buttons(3).FontSize = 8
1925:         loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
1926:         loc_oOpt.Buttons(3).Themes = .F.
1927: 
1928:         *-- Calc Imediato
1929:         par_oPg.AddObject("lbl_4c_LblCalcImeds", "Label")
1930:         WITH par_oPg.lbl_4c_LblCalcImeds

*-- Linhas 1941 a 2813:
1941:             .Visible = .T.
1942:         ENDWITH
1943: 
1944:         par_oPg.AddObject("fwoption2", "OptionGroup")
1945:         loc_oOpt = par_oPg.fwoption2
1946:         WITH loc_oOpt
1947:             .ButtonCount = 2
1948:             .Top = 54
1949:             .Left = 160
1950:             .Width = 115
1951:             .Height = 23
1952:             .BackStyle = 0
1953:             .BorderStyle = 0
1954:             .Value = 1
1955:             .Visible = .T.
1956:         ENDWITH
1957:         loc_oOpt.Buttons(1).Caption = "Sim"
1958:         loc_oOpt.Buttons(1).Left = 5
1959:         loc_oOpt.Buttons(1).Top = 3
1960:         loc_oOpt.Buttons(1).Width = 40
1961:         loc_oOpt.Buttons(1).FontName = "Tahoma"
1962:         loc_oOpt.Buttons(1).FontSize = 8
1963:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
1964:         loc_oOpt.Buttons(1).Themes = .F.
1965:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
1966:         loc_oOpt.Buttons(2).Left = 48
1967:         loc_oOpt.Buttons(2).Top = 3
1968:         loc_oOpt.Buttons(2).Width = 44
1969:         loc_oOpt.Buttons(2).FontName = "Tahoma"
1970:         loc_oOpt.Buttons(2).FontSize = 8
1971:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
1972:         loc_oOpt.Buttons(2).Themes = .F.
1973: 
1974:         *-- Calcimeds (optCalcIMeds)
1975:         par_oPg.AddObject("lbl_4c_LblCalcIMed2", "Label")
1976:         WITH par_oPg.lbl_4c_LblCalcIMed2
1977:             .Caption = "Calc.Imeds2:"
1978:             .Top = 73
1979:             .Left = 17
1980:             .Width = 141
1981:             .Height = 17
1982:             .FontName = "Tahoma"
1983:             .FontSize = 8
1984:             .ForeColor = RGB(90,90,90)
1985:             .BackStyle = 0
1986:             .Alignment = 1
1987:             .Visible = .T.
1988:         ENDWITH
1989: 
1990:         par_oPg.AddObject("optCalcIMeds", "OptionGroup")
1991:         loc_oOpt = par_oPg.optCalcIMeds
1992:         WITH loc_oOpt
1993:             .ButtonCount = 2
1994:             .Top = 73
1995:             .Left = 160
1996:             .Width = 97
1997:             .Height = 25
1998:             .BackStyle = 0
1999:             .BorderStyle = 0
2000:             .Value = 1
2001:             .Visible = .T.
2002:         ENDWITH
2003:         loc_oOpt.Buttons(1).Caption = "Sim"
2004:         loc_oOpt.Buttons(1).Left = 5
2005:         loc_oOpt.Buttons(1).Top = 3
2006:         loc_oOpt.Buttons(1).Width = 40
2007:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2008:         loc_oOpt.Buttons(1).FontSize = 8
2009:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2010:         loc_oOpt.Buttons(1).Themes = .F.
2011:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2012:         loc_oOpt.Buttons(2).Left = 48
2013:         loc_oOpt.Buttons(2).Top = 3
2014:         loc_oOpt.Buttons(2).Width = 44
2015:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2016:         loc_oOpt.Buttons(2).FontSize = 8
2017:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2018:         loc_oOpt.Buttons(2).Themes = .F.
2019: 
2020:         *-- ObrMails
2021:         par_oPg.AddObject("lbl_4c_LblObrMails", "Label")
2022:         WITH par_oPg.lbl_4c_LblObrMails
2023:             .Caption = "E-mail Obrig.:"
2024:             .Top = 96
2025:             .Left = 17
2026:             .Width = 141
2027:             .Height = 17
2028:             .FontName = "Tahoma"
2029:             .FontSize = 8
2030:             .ForeColor = RGB(90,90,90)
2031:             .BackStyle = 0
2032:             .Alignment = 1
2033:             .Visible = .T.
2034:         ENDWITH
2035: 
2036:         par_oPg.AddObject("getObrMails", "OptionGroup")
2037:         loc_oOpt = par_oPg.getObrMails
2038:         WITH loc_oOpt
2039:             .ButtonCount = 2
2040:             .Top = 96
2041:             .Left = 160
2042:             .Width = 97
2043:             .Height = 25
2044:             .BackStyle = 0
2045:             .BorderStyle = 0
2046:             .Value = 1
2047:             .Visible = .T.
2048:         ENDWITH
2049:         loc_oOpt.Buttons(1).Caption = "Sim"
2050:         loc_oOpt.Buttons(1).Left = 5
2051:         loc_oOpt.Buttons(1).Top = 3
2052:         loc_oOpt.Buttons(1).Width = 40
2053:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2054:         loc_oOpt.Buttons(1).FontSize = 8
2055:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2056:         loc_oOpt.Buttons(1).Themes = .F.
2057:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2058:         loc_oOpt.Buttons(2).Left = 48
2059:         loc_oOpt.Buttons(2).Top = 3
2060:         loc_oOpt.Buttons(2).Width = 44
2061:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2062:         loc_oOpt.Buttons(2).FontSize = 8
2063:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2064:         loc_oOpt.Buttons(2).Themes = .F.
2065: 
2066:         *-- ObrNome
2067:         par_oPg.AddObject("lbl_4c_LblObrNome", "Label")
2068:         WITH par_oPg.lbl_4c_LblObrNome
2069:             .Caption = "Nome Obrig.:"
2070:             .Top = 117
2071:             .Left = 17
2072:             .Width = 141
2073:             .Height = 17
2074:             .FontName = "Tahoma"
2075:             .FontSize = 8
2076:             .ForeColor = RGB(90,90,90)
2077:             .BackStyle = 0
2078:             .Alignment = 1
2079:             .Visible = .T.
2080:         ENDWITH
2081: 
2082:         par_oPg.AddObject("getObrNome", "OptionGroup")
2083:         loc_oOpt = par_oPg.getObrNome
2084:         WITH loc_oOpt
2085:             .ButtonCount = 2
2086:             .Top = 117
2087:             .Left = 160
2088:             .Width = 97
2089:             .Height = 25
2090:             .BackStyle = 0
2091:             .BorderStyle = 0
2092:             .Value = 1
2093:             .Visible = .T.
2094:         ENDWITH
2095:         loc_oOpt.Buttons(1).Caption = "Sim"
2096:         loc_oOpt.Buttons(1).Left = 5
2097:         loc_oOpt.Buttons(1).Top = 3
2098:         loc_oOpt.Buttons(1).Width = 40
2099:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2100:         loc_oOpt.Buttons(1).FontSize = 8
2101:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2102:         loc_oOpt.Buttons(1).Themes = .F.
2103:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2104:         loc_oOpt.Buttons(2).Left = 48
2105:         loc_oOpt.Buttons(2).Top = 3
2106:         loc_oOpt.Buttons(2).Width = 44
2107:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2108:         loc_oOpt.Buttons(2).FontSize = 8
2109:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2110:         loc_oOpt.Buttons(2).Themes = .F.
2111: 
2112:         *-- RazSoc Obrig (Fwoption15)
2113:         par_oPg.AddObject("lbl_4c_LblRazSocObr", "Label")
2114:         WITH par_oPg.lbl_4c_LblRazSocObr
2115:             .Caption = "Raz" + CHR(227) + "o Social Obrig.:"
2116:             .Top = 136
2117:             .Left = 17
2118:             .Width = 141
2119:             .Height = 17
2120:             .FontName = "Tahoma"
2121:             .FontSize = 8
2122:             .ForeColor = RGB(90,90,90)
2123:             .BackStyle = 0
2124:             .Alignment = 1
2125:             .Visible = .T.
2126:         ENDWITH
2127: 
2128:         par_oPg.AddObject("Fwoption15", "OptionGroup")
2129:         loc_oOpt = par_oPg.Fwoption15
2130:         WITH loc_oOpt
2131:             .ButtonCount = 2
2132:             .Top = 136
2133:             .Left = 160
2134:             .Width = 97
2135:             .Height = 25
2136:             .BackStyle = 0
2137:             .BorderStyle = 0
2138:             .Value = 1
2139:             .Visible = .T.
2140:         ENDWITH
2141:         loc_oOpt.Buttons(1).Caption = "Sim"
2142:         loc_oOpt.Buttons(1).Left = 5
2143:         loc_oOpt.Buttons(1).Top = 3
2144:         loc_oOpt.Buttons(1).Width = 40
2145:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2146:         loc_oOpt.Buttons(1).FontSize = 8
2147:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2148:         loc_oOpt.Buttons(1).Themes = .F.
2149:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2150:         loc_oOpt.Buttons(2).Left = 48
2151:         loc_oOpt.Buttons(2).Top = 3
2152:         loc_oOpt.Buttons(2).Width = 44
2153:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2154:         loc_oOpt.Buttons(2).FontSize = 8
2155:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2156:         loc_oOpt.Buttons(2).Themes = .F.
2157: 
2158:         *-- ObrSit
2159:         par_oPg.AddObject("lbl_4c_LblObrSit", "Label")
2160:         WITH par_oPg.lbl_4c_LblObrSit
2161:             .Caption = "Situa" + CHR(231) + CHR(227) + "o Obrig.:"
2162:             .Top = 157
2163:             .Left = 17
2164:             .Width = 141
2165:             .Height = 17
2166:             .FontName = "Tahoma"
2167:             .FontSize = 8
2168:             .ForeColor = RGB(90,90,90)
2169:             .BackStyle = 0
2170:             .Alignment = 1
2171:             .Visible = .T.
2172:         ENDWITH
2173: 
2174:         par_oPg.AddObject("getObrSit", "OptionGroup")
2175:         loc_oOpt = par_oPg.getObrSit
2176:         WITH loc_oOpt
2177:             .ButtonCount = 2
2178:             .Top = 157
2179:             .Left = 160
2180:             .Width = 97
2181:             .Height = 25
2182:             .BackStyle = 0
2183:             .BorderStyle = 0
2184:             .Value = 1
2185:             .Visible = .T.
2186:         ENDWITH
2187:         loc_oOpt.Buttons(1).Caption = "Sim"
2188:         loc_oOpt.Buttons(1).Left = 5
2189:         loc_oOpt.Buttons(1).Top = 3
2190:         loc_oOpt.Buttons(1).Width = 40
2191:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2192:         loc_oOpt.Buttons(1).FontSize = 8
2193:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2194:         loc_oOpt.Buttons(1).Themes = .F.
2195:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2196:         loc_oOpt.Buttons(2).Left = 48
2197:         loc_oOpt.Buttons(2).Top = 3
2198:         loc_oOpt.Buttons(2).Width = 44
2199:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2200:         loc_oOpt.Buttons(2).FontSize = 8
2201:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2202:         loc_oOpt.Buttons(2).Themes = .F.
2203: 
2204:         *-- ObrTlm (Telemarketing)
2205:         par_oPg.AddObject("lbl_4c_LblObrTlm", "Label")
2206:         WITH par_oPg.lbl_4c_LblObrTlm
2207:             .Caption = "Telemarketing Obrig.:"
2208:             .Top = 179
2209:             .Left = 17
2210:             .Width = 141
2211:             .Height = 17
2212:             .FontName = "Tahoma"
2213:             .FontSize = 8
2214:             .ForeColor = RGB(90,90,90)
2215:             .BackStyle = 0
2216:             .Alignment = 1
2217:             .Visible = .T.
2218:         ENDWITH
2219: 
2220:         par_oPg.AddObject("getObrTlm", "OptionGroup")
2221:         loc_oOpt = par_oPg.getObrTlm
2222:         WITH loc_oOpt
2223:             .ButtonCount = 2
2224:             .Top = 179
2225:             .Left = 160
2226:             .Width = 97
2227:             .Height = 25
2228:             .BackStyle = 0
2229:             .BorderStyle = 0
2230:             .Value = 1
2231:             .Visible = .T.
2232:         ENDWITH
2233:         loc_oOpt.Buttons(1).Caption = "Sim"
2234:         loc_oOpt.Buttons(1).Left = 5
2235:         loc_oOpt.Buttons(1).Top = 3
2236:         loc_oOpt.Buttons(1).Width = 40
2237:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2238:         loc_oOpt.Buttons(1).FontSize = 8
2239:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2240:         loc_oOpt.Buttons(1).Themes = .F.
2241:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2242:         loc_oOpt.Buttons(2).Left = 48
2243:         loc_oOpt.Buttons(2).Top = 3
2244:         loc_oOpt.Buttons(2).Width = 44
2245:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2246:         loc_oOpt.Buttons(2).FontSize = 8
2247:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2248:         loc_oOpt.Buttons(2).Themes = .F.
2249: 
2250:         *-- ObrCla (Classificacao)
2251:         par_oPg.AddObject("lbl_4c_LblObrCla", "Label")
2252:         WITH par_oPg.lbl_4c_LblObrCla
2253:             .Caption = "Classifica" + CHR(231) + CHR(227) + "o Obrig.:"
2254:             .Top = 201
2255:             .Left = 17
2256:             .Width = 141
2257:             .Height = 17
2258:             .FontName = "Tahoma"
2259:             .FontSize = 8
2260:             .ForeColor = RGB(90,90,90)
2261:             .BackStyle = 0
2262:             .Alignment = 1
2263:             .Visible = .T.
2264:         ENDWITH
2265: 
2266:         par_oPg.AddObject("getObrCla", "OptionGroup")
2267:         loc_oOpt = par_oPg.getObrCla
2268:         WITH loc_oOpt
2269:             .ButtonCount = 2
2270:             .Top = 201
2271:             .Left = 160
2272:             .Width = 97
2273:             .Height = 25
2274:             .BackStyle = 0
2275:             .BorderStyle = 0
2276:             .Value = 1
2277:             .Visible = .T.
2278:         ENDWITH
2279:         loc_oOpt.Buttons(1).Caption = "Sim"
2280:         loc_oOpt.Buttons(1).Left = 5
2281:         loc_oOpt.Buttons(1).Top = 3
2282:         loc_oOpt.Buttons(1).Width = 40
2283:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2284:         loc_oOpt.Buttons(1).FontSize = 8
2285:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2286:         loc_oOpt.Buttons(1).Themes = .F.
2287:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2288:         loc_oOpt.Buttons(2).Left = 48
2289:         loc_oOpt.Buttons(2).Top = 3
2290:         loc_oOpt.Buttons(2).Width = 44
2291:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2292:         loc_oOpt.Buttons(2).FontSize = 8
2293:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2294:         loc_oOpt.Buttons(2).Themes = .F.
2295: 
2296:         *-- ObrSeg (Segmento)
2297:         par_oPg.AddObject("lbl_4c_LblObrSeg", "Label")
2298:         WITH par_oPg.lbl_4c_LblObrSeg
2299:             .Caption = "Segmento Obrig.:"
2300:             .Top = 222
2301:             .Left = 17
2302:             .Width = 141
2303:             .Height = 17
2304:             .FontName = "Tahoma"
2305:             .FontSize = 8
2306:             .ForeColor = RGB(90,90,90)
2307:             .BackStyle = 0
2308:             .Alignment = 1
2309:             .Visible = .T.
2310:         ENDWITH
2311: 
2312:         par_oPg.AddObject("getObrSeg", "OptionGroup")
2313:         loc_oOpt = par_oPg.getObrSeg
2314:         WITH loc_oOpt
2315:             .ButtonCount = 2
2316:             .Top = 222
2317:             .Left = 160
2318:             .Width = 97
2319:             .Height = 25
2320:             .BackStyle = 0
2321:             .BorderStyle = 0
2322:             .Value = 1
2323:             .Visible = .T.
2324:         ENDWITH
2325:         loc_oOpt.Buttons(1).Caption = "Sim"
2326:         loc_oOpt.Buttons(1).Left = 5
2327:         loc_oOpt.Buttons(1).Top = 3
2328:         loc_oOpt.Buttons(1).Width = 40
2329:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2330:         loc_oOpt.Buttons(1).FontSize = 8
2331:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2332:         loc_oOpt.Buttons(1).Themes = .F.
2333:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2334:         loc_oOpt.Buttons(2).Left = 48
2335:         loc_oOpt.Buttons(2).Top = 3
2336:         loc_oOpt.Buttons(2).Width = 44
2337:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2338:         loc_oOpt.Buttons(2).FontSize = 8
2339:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2340:         loc_oOpt.Buttons(2).Themes = .F.
2341: 
2342:         *-- Nascimento Obrig (Fwoption6)
2343:         par_oPg.AddObject("lbl_4c_LblNascObr", "Label")
2344:         WITH par_oPg.lbl_4c_LblNascObr
2345:             .Caption = "Nascimento Obrig.:"
2346:             .Top = 241
2347:             .Left = 17
2348:             .Width = 141
2349:             .Height = 17
2350:             .FontName = "Tahoma"
2351:             .FontSize = 8
2352:             .ForeColor = RGB(90,90,90)
2353:             .BackStyle = 0
2354:             .Alignment = 1
2355:             .Visible = .T.
2356:         ENDWITH
2357: 
2358:         par_oPg.AddObject("Fwoption6", "OptionGroup")
2359:         loc_oOpt = par_oPg.Fwoption6
2360:         WITH loc_oOpt
2361:             .ButtonCount = 2
2362:             .Top = 241
2363:             .Left = 160
2364:             .Width = 97
2365:             .Height = 25
2366:             .BackStyle = 0
2367:             .BorderStyle = 0
2368:             .Value = 1
2369:             .Visible = .T.
2370:         ENDWITH
2371:         loc_oOpt.Buttons(1).Caption = "Sim"
2372:         loc_oOpt.Buttons(1).Left = 5
2373:         loc_oOpt.Buttons(1).Top = 3
2374:         loc_oOpt.Buttons(1).Width = 40
2375:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2376:         loc_oOpt.Buttons(1).FontSize = 8
2377:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2378:         loc_oOpt.Buttons(1).Themes = .F.
2379:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2380:         loc_oOpt.Buttons(2).Left = 48
2381:         loc_oOpt.Buttons(2).Top = 3
2382:         loc_oOpt.Buttons(2).Width = 44
2383:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2384:         loc_oOpt.Buttons(2).FontSize = 8
2385:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2386:         loc_oOpt.Buttons(2).Themes = .F.
2387: 
2388:         *-- Sexo Obrig (Fwoption7)
2389:         par_oPg.AddObject("lbl_4c_LblSexoObr", "Label")
2390:         WITH par_oPg.lbl_4c_LblSexoObr
2391:             .Caption = "Sexo Obrig.:"
2392:             .Top = 262
2393:             .Left = 17
2394:             .Width = 141
2395:             .Height = 17
2396:             .FontName = "Tahoma"
2397:             .FontSize = 8
2398:             .ForeColor = RGB(90,90,90)
2399:             .BackStyle = 0
2400:             .Alignment = 1
2401:             .Visible = .T.
2402:         ENDWITH
2403: 
2404:         par_oPg.AddObject("Fwoption7", "OptionGroup")
2405:         loc_oOpt = par_oPg.Fwoption7
2406:         WITH loc_oOpt
2407:             .ButtonCount = 2
2408:             .Top = 262
2409:             .Left = 160
2410:             .Width = 97
2411:             .Height = 25
2412:             .BackStyle = 0
2413:             .BorderStyle = 0
2414:             .Value = 1
2415:             .Visible = .T.
2416:         ENDWITH
2417:         loc_oOpt.Buttons(1).Caption = "Sim"
2418:         loc_oOpt.Buttons(1).Left = 5
2419:         loc_oOpt.Buttons(1).Top = 3
2420:         loc_oOpt.Buttons(1).Width = 40
2421:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2422:         loc_oOpt.Buttons(1).FontSize = 8
2423:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2424:         loc_oOpt.Buttons(1).Themes = .F.
2425:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2426:         loc_oOpt.Buttons(2).Left = 48
2427:         loc_oOpt.Buttons(2).Top = 3
2428:         loc_oOpt.Buttons(2).Width = 44
2429:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2430:         loc_oOpt.Buttons(2).FontSize = 8
2431:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2432:         loc_oOpt.Buttons(2).Themes = .F.
2433: 
2434:         *-- Telefone 1 Obrig (Fwoption12)
2435:         par_oPg.AddObject("lbl_4c_LblTel1Obr", "Label")
2436:         WITH par_oPg.lbl_4c_LblTel1Obr
2437:             .Caption = "Telefone 1 Obrig.:"
2438:             .Top = 283
2439:             .Left = 17
2440:             .Width = 141
2441:             .Height = 17
2442:             .FontName = "Tahoma"
2443:             .FontSize = 8
2444:             .ForeColor = RGB(90,90,90)
2445:             .BackStyle = 0
2446:             .Alignment = 1
2447:             .Visible = .T.
2448:         ENDWITH
2449: 
2450:         par_oPg.AddObject("Fwoption12", "OptionGroup")
2451:         loc_oOpt = par_oPg.Fwoption12
2452:         WITH loc_oOpt
2453:             .ButtonCount = 2
2454:             .Top = 283
2455:             .Left = 160
2456:             .Width = 97
2457:             .Height = 25
2458:             .BackStyle = 0
2459:             .BorderStyle = 0
2460:             .Value = 1
2461:             .Visible = .T.
2462:         ENDWITH
2463:         loc_oOpt.Buttons(1).Caption = "Sim"
2464:         loc_oOpt.Buttons(1).Left = 5
2465:         loc_oOpt.Buttons(1).Top = 3
2466:         loc_oOpt.Buttons(1).Width = 40
2467:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2468:         loc_oOpt.Buttons(1).FontSize = 8
2469:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2470:         loc_oOpt.Buttons(1).Themes = .F.
2471:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2472:         loc_oOpt.Buttons(2).Left = 48
2473:         loc_oOpt.Buttons(2).Top = 3
2474:         loc_oOpt.Buttons(2).Width = 44
2475:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2476:         loc_oOpt.Buttons(2).FontSize = 8
2477:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2478:         loc_oOpt.Buttons(2).Themes = .F.
2479: 
2480:         *-- Telefone 2 Obrig (Fwoption13)
2481:         par_oPg.AddObject("lbl_4c_LblTel2Obr", "Label")
2482:         WITH par_oPg.lbl_4c_LblTel2Obr
2483:             .Caption = "Telefone 2 Obrig.:"
2484:             .Top = 302
2485:             .Left = 17
2486:             .Width = 141
2487:             .Height = 17
2488:             .FontName = "Tahoma"
2489:             .FontSize = 8
2490:             .ForeColor = RGB(90,90,90)
2491:             .BackStyle = 0
2492:             .Alignment = 1
2493:             .Visible = .T.
2494:         ENDWITH
2495: 
2496:         par_oPg.AddObject("Fwoption13", "OptionGroup")
2497:         loc_oOpt = par_oPg.Fwoption13
2498:         WITH loc_oOpt
2499:             .ButtonCount = 2
2500:             .Top = 302
2501:             .Left = 160
2502:             .Width = 97
2503:             .Height = 25
2504:             .BackStyle = 0
2505:             .BorderStyle = 0
2506:             .Value = 1
2507:             .Visible = .T.
2508:         ENDWITH
2509:         loc_oOpt.Buttons(1).Caption = "Sim"
2510:         loc_oOpt.Buttons(1).Left = 5
2511:         loc_oOpt.Buttons(1).Top = 3
2512:         loc_oOpt.Buttons(1).Width = 40
2513:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2514:         loc_oOpt.Buttons(1).FontSize = 8
2515:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2516:         loc_oOpt.Buttons(1).Themes = .F.
2517:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2518:         loc_oOpt.Buttons(2).Left = 48
2519:         loc_oOpt.Buttons(2).Top = 3
2520:         loc_oOpt.Buttons(2).Width = 44
2521:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2522:         loc_oOpt.Buttons(2).FontSize = 8
2523:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2524:         loc_oOpt.Buttons(2).Themes = .F.
2525: 
2526:         *-- Col 2: Endereco obrigatorio (Left 464)
2527:         *-- Endereco Obrig (Fwoption14)
2528:         par_oPg.AddObject("lbl_4c_LblEndObr", "Label")
2529:         WITH par_oPg.lbl_4c_LblEndObr
2530:             .Caption = "Endere" + CHR(231) + "o Obrig.:"
2531:             .Top = 33
2532:             .Left = 360
2533:             .Width = 103
2534:             .Height = 17
2535:             .FontName = "Tahoma"
2536:             .FontSize = 8
2537:             .ForeColor = RGB(90,90,90)
2538:             .BackStyle = 0
2539:             .Alignment = 1
2540:             .Visible = .T.
2541:         ENDWITH
2542: 
2543:         par_oPg.AddObject("Fwoption14", "OptionGroup")
2544:         loc_oOpt = par_oPg.Fwoption14
2545:         WITH loc_oOpt
2546:             .ButtonCount = 2
2547:             .Top = 33
2548:             .Left = 464
2549:             .Width = 97
2550:             .Height = 25
2551:             .BackStyle = 0
2552:             .BorderStyle = 0
2553:             .Value = 1
2554:             .Visible = .T.
2555:         ENDWITH
2556:         loc_oOpt.Buttons(1).Caption = "Sim"
2557:         loc_oOpt.Buttons(1).Left = 5
2558:         loc_oOpt.Buttons(1).Top = 3
2559:         loc_oOpt.Buttons(1).Width = 40
2560:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2561:         loc_oOpt.Buttons(1).FontSize = 8
2562:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2563:         loc_oOpt.Buttons(1).Themes = .F.
2564:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2565:         loc_oOpt.Buttons(2).Left = 48
2566:         loc_oOpt.Buttons(2).Top = 3
2567:         loc_oOpt.Buttons(2).Width = 44
2568:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2569:         loc_oOpt.Buttons(2).FontSize = 8
2570:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2571:         loc_oOpt.Buttons(2).Themes = .F.
2572: 
2573:         *-- Numero Obrig (Fwoption8)
2574:         par_oPg.AddObject("lbl_4c_LblNumObr", "Label")
2575:         WITH par_oPg.lbl_4c_LblNumObr
2576:             .Caption = "N" + CHR(250) + "mero Obrig.:"
2577:             .Top = 52
2578:             .Left = 360
2579:             .Width = 103
2580:             .Height = 17
2581:             .FontName = "Tahoma"
2582:             .FontSize = 8
2583:             .ForeColor = RGB(90,90,90)
2584:             .BackStyle = 0
2585:             .Alignment = 1
2586:             .Visible = .T.
2587:         ENDWITH
2588: 
2589:         par_oPg.AddObject("Fwoption8", "OptionGroup")
2590:         loc_oOpt = par_oPg.Fwoption8
2591:         WITH loc_oOpt
2592:             .ButtonCount = 2
2593:             .Top = 52
2594:             .Left = 464
2595:             .Width = 97
2596:             .Height = 25
2597:             .BackStyle = 0
2598:             .BorderStyle = 0
2599:             .Value = 1
2600:             .Visible = .T.
2601:         ENDWITH
2602:         loc_oOpt.Buttons(1).Caption = "Sim"
2603:         loc_oOpt.Buttons(1).Left = 5
2604:         loc_oOpt.Buttons(1).Top = 3
2605:         loc_oOpt.Buttons(1).Width = 40
2606:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2607:         loc_oOpt.Buttons(1).FontSize = 8
2608:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2609:         loc_oOpt.Buttons(1).Themes = .F.
2610:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2611:         loc_oOpt.Buttons(2).Left = 48
2612:         loc_oOpt.Buttons(2).Top = 3
2613:         loc_oOpt.Buttons(2).Width = 44
2614:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2615:         loc_oOpt.Buttons(2).FontSize = 8
2616:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2617:         loc_oOpt.Buttons(2).Themes = .F.
2618: 
2619:         *-- Bairro Obrig (Fwoption9)
2620:         par_oPg.AddObject("lbl_4c_LblBairroObr", "Label")
2621:         WITH par_oPg.lbl_4c_LblBairroObr
2622:             .Caption = "Bairro Obrig.:"
2623:             .Top = 73
2624:             .Left = 360
2625:             .Width = 103
2626:             .Height = 17
2627:             .FontName = "Tahoma"
2628:             .FontSize = 8
2629:             .ForeColor = RGB(90,90,90)
2630:             .BackStyle = 0
2631:             .Alignment = 1
2632:             .Visible = .T.
2633:         ENDWITH
2634: 
2635:         par_oPg.AddObject("Fwoption9", "OptionGroup")
2636:         loc_oOpt = par_oPg.Fwoption9
2637:         WITH loc_oOpt
2638:             .ButtonCount = 2
2639:             .Top = 73
2640:             .Left = 464
2641:             .Width = 97
2642:             .Height = 25
2643:             .BackStyle = 0
2644:             .BorderStyle = 0
2645:             .Value = 1
2646:             .Visible = .T.
2647:         ENDWITH
2648:         loc_oOpt.Buttons(1).Caption = "Sim"
2649:         loc_oOpt.Buttons(1).Left = 5
2650:         loc_oOpt.Buttons(1).Top = 3
2651:         loc_oOpt.Buttons(1).Width = 40
2652:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2653:         loc_oOpt.Buttons(1).FontSize = 8
2654:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2655:         loc_oOpt.Buttons(1).Themes = .F.
2656:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2657:         loc_oOpt.Buttons(2).Left = 48
2658:         loc_oOpt.Buttons(2).Top = 3
2659:         loc_oOpt.Buttons(2).Width = 44
2660:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2661:         loc_oOpt.Buttons(2).FontSize = 8
2662:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2663:         loc_oOpt.Buttons(2).Themes = .F.
2664: 
2665:         *-- Cidade Obrig (Fwoption11)
2666:         par_oPg.AddObject("lbl_4c_LblCidObr", "Label")
2667:         WITH par_oPg.lbl_4c_LblCidObr
2668:             .Caption = "Cidade Obrig.:"
2669:             .Top = 92
2670:             .Left = 360
2671:             .Width = 103
2672:             .Height = 17
2673:             .FontName = "Tahoma"
2674:             .FontSize = 8
2675:             .ForeColor = RGB(90,90,90)
2676:             .BackStyle = 0
2677:             .Alignment = 1
2678:             .Visible = .T.
2679:         ENDWITH
2680: 
2681:         par_oPg.AddObject("Fwoption11", "OptionGroup")
2682:         loc_oOpt = par_oPg.Fwoption11
2683:         WITH loc_oOpt
2684:             .ButtonCount = 2
2685:             .Top = 92
2686:             .Left = 464
2687:             .Width = 97
2688:             .Height = 25
2689:             .BackStyle = 0
2690:             .BorderStyle = 0
2691:             .Value = 1
2692:             .Visible = .T.
2693:         ENDWITH
2694:         loc_oOpt.Buttons(1).Caption = "Sim"
2695:         loc_oOpt.Buttons(1).Left = 5
2696:         loc_oOpt.Buttons(1).Top = 3
2697:         loc_oOpt.Buttons(1).Width = 40
2698:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2699:         loc_oOpt.Buttons(1).FontSize = 8
2700:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2701:         loc_oOpt.Buttons(1).Themes = .F.
2702:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2703:         loc_oOpt.Buttons(2).Left = 48
2704:         loc_oOpt.Buttons(2).Top = 3
2705:         loc_oOpt.Buttons(2).Width = 44
2706:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2707:         loc_oOpt.Buttons(2).FontSize = 8
2708:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2709:         loc_oOpt.Buttons(2).Themes = .F.
2710: 
2711:         *-- Pais Obrig (Fwoption10)
2712:         par_oPg.AddObject("lbl_4c_LblPaisObr", "Label")
2713:         WITH par_oPg.lbl_4c_LblPaisObr
2714:             .Caption = "Pa" + CHR(237) + "s Obrig.:"
2715:             .Top = 112
2716:             .Left = 360
2717:             .Width = 103
2718:             .Height = 17
2719:             .FontName = "Tahoma"
2720:             .FontSize = 8
2721:             .ForeColor = RGB(90,90,90)
2722:             .BackStyle = 0
2723:             .Alignment = 1
2724:             .Visible = .T.
2725:         ENDWITH
2726: 
2727:         par_oPg.AddObject("Fwoption10", "OptionGroup")
2728:         loc_oOpt = par_oPg.Fwoption10
2729:         WITH loc_oOpt
2730:             .ButtonCount = 2
2731:             .Top = 112
2732:             .Left = 464
2733:             .Width = 97
2734:             .Height = 25
2735:             .BackStyle = 0
2736:             .BorderStyle = 0
2737:             .Value = 1
2738:             .Visible = .T.
2739:         ENDWITH
2740:         loc_oOpt.Buttons(1).Caption = "Sim"
2741:         loc_oOpt.Buttons(1).Left = 5
2742:         loc_oOpt.Buttons(1).Top = 3
2743:         loc_oOpt.Buttons(1).Width = 40
2744:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2745:         loc_oOpt.Buttons(1).FontSize = 8
2746:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2747:         loc_oOpt.Buttons(1).Themes = .F.
2748:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2749:         loc_oOpt.Buttons(2).Left = 48
2750:         loc_oOpt.Buttons(2).Top = 3
2751:         loc_oOpt.Buttons(2).Width = 44
2752:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2753:         loc_oOpt.Buttons(2).FontSize = 8
2754:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2755:         loc_oOpt.Buttons(2).Themes = .F.
2756: 
2757:         *-- CEP Obrig (Opt_CEPObrig, 3 btn)
2758:         par_oPg.AddObject("lbl_4c_LblCepObr", "Label")
2759:         WITH par_oPg.lbl_4c_LblCepObr
2760:             .Caption = "CEP Obrig.:"
2761:             .Top = 132
2762:             .Left = 360
2763:             .Width = 103
2764:             .Height = 17
2765:             .FontName = "Tahoma"
2766:             .FontSize = 8
2767:             .ForeColor = RGB(90,90,90)
2768:             .BackStyle = 0
2769:             .Alignment = 1
2770:             .Visible = .T.
2771:         ENDWITH
2772: 
2773:         par_oPg.AddObject("Opt_CEPObrig", "OptionGroup")
2774:         loc_oOpt = par_oPg.Opt_CEPObrig
2775:         WITH loc_oOpt
2776:             .ButtonCount = 3
2777:             .Top = 132
2778:             .Left = 464
2779:             .Width = 180
2780:             .Height = 25
2781:             .BackStyle = 0
2782:             .BorderStyle = 0
2783:             .Value = 1
2784:             .Visible = .T.
2785:         ENDWITH
2786:         loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
2787:         loc_oOpt.Buttons(1).Left = 5
2788:         loc_oOpt.Buttons(1).Top = 3
2789:         loc_oOpt.Buttons(1).Width = 44
2790:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2791:         loc_oOpt.Buttons(1).FontSize = 8
2792:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2793:         loc_oOpt.Buttons(1).Themes = .F.
2794:         loc_oOpt.Buttons(2).Caption = "Opcional"
2795:         loc_oOpt.Buttons(2).Left = 55
2796:         loc_oOpt.Buttons(2).Top = 3
2797:         loc_oOpt.Buttons(2).Width = 65
2798:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2799:         loc_oOpt.Buttons(2).FontSize = 8
2800:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2801:         loc_oOpt.Buttons(2).Themes = .F.
2802:         loc_oOpt.Buttons(3).Caption = "Obrigat" + CHR(243) + "rio"
2803:         loc_oOpt.Buttons(3).Left = 125
2804:         loc_oOpt.Buttons(3).Top = 3
2805:         loc_oOpt.Buttons(3).Width = 50
2806:         loc_oOpt.Buttons(3).FontName = "Tahoma"
2807:         loc_oOpt.Buttons(3).FontSize = 8
2808:         loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
2809:         loc_oOpt.Buttons(3).Themes = .F.
2810: 
2811:         *-- IBGE Obrig (getObrIbge)
2812:         par_oPg.AddObject("lbl_4c_LblIbgeObr", "Label")
2813:         WITH par_oPg.lbl_4c_LblIbgeObr

*-- Linhas 2824 a 2867:
2824:             .Visible = .T.
2825:         ENDWITH
2826: 
2827:         par_oPg.AddObject("getObrIbge", "OptionGroup")
2828:         loc_oOpt = par_oPg.getObrIbge
2829:         WITH loc_oOpt
2830:             .ButtonCount = 2
2831:             .Top = 190
2832:             .Left = 464
2833:             .Width = 97
2834:             .Height = 25
2835:             .BackStyle = 0
2836:             .BorderStyle = 0
2837:             .Value = 1
2838:             .Visible = .T.
2839:         ENDWITH
2840:         loc_oOpt.Buttons(1).Caption = "Sim"
2841:         loc_oOpt.Buttons(1).Left = 5
2842:         loc_oOpt.Buttons(1).Top = 3
2843:         loc_oOpt.Buttons(1).Width = 40
2844:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2845:         loc_oOpt.Buttons(1).FontSize = 8
2846:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2847:         loc_oOpt.Buttons(1).Themes = .F.
2848:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2849:         loc_oOpt.Buttons(2).Left = 48
2850:         loc_oOpt.Buttons(2).Top = 3
2851:         loc_oOpt.Buttons(2).Width = 44
2852:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2853:         loc_oOpt.Buttons(2).FontSize = 8
2854:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2855:         loc_oOpt.Buttons(2).Themes = .F.
2856: 
2857:         *-- Conta Interna
2858:         par_oPg.AddObject("lbl_4c_LblContint", "Label")
2859:         WITH par_oPg.lbl_4c_LblContint
2860:             .Caption = "Conta Interna:"
2861:             .Top = 349
2862:             .Left = 17
2863:             .Width = 90
2864:             .Height = 17
2865:             .FontName = "Tahoma"
2866:             .FontSize = 8
2867:             .ForeColor = RGB(90,90,90)

*-- Linhas 2903 a 2946:
2903:             .Visible = .T.
2904:         ENDWITH
2905: 
2906:         par_oPg.AddObject("Opt_Integ", "OptionGroup")
2907:         loc_oOpt = par_oPg.Opt_Integ
2908:         WITH loc_oOpt
2909:             .ButtonCount = 3
2910:             .Top = 373
2911:             .Left = 192
2912:             .Width = 316
2913:             .Height = 23
2914:             .BackStyle = 0
2915:             .BorderStyle = 0
2916:             .Value = 1
2917:             .Visible = .T.
2918:         ENDWITH
2919:         loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
2920:         loc_oOpt.Buttons(1).Left = 5
2921:         loc_oOpt.Buttons(1).Top = 3
2922:         loc_oOpt.Buttons(1).Width = 40
2923:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2924:         loc_oOpt.Buttons(1).FontSize = 8
2925:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2926:         loc_oOpt.Buttons(1).Themes = .F.
2927:         loc_oOpt.Buttons(2).Caption = "Integra" + CHR(231) + CHR(227) + "o Padr" + CHR(227) + "o"
2928:         loc_oOpt.Buttons(2).Left = 50
2929:         loc_oOpt.Buttons(2).Top = 3
2930:         loc_oOpt.Buttons(2).Width = 130
2931:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2932:         loc_oOpt.Buttons(2).FontSize = 8
2933:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2934:         loc_oOpt.Buttons(2).Themes = .F.
2935:         loc_oOpt.Buttons(3).Caption = "Por Grupo"
2936:         loc_oOpt.Buttons(3).Left = 185
2937:         loc_oOpt.Buttons(3).Top = 3
2938:         loc_oOpt.Buttons(3).Width = 90
2939:         loc_oOpt.Buttons(3).FontName = "Tahoma"
2940:         loc_oOpt.Buttons(3).FontSize = 8
2941:         loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
2942:         loc_oOpt.Buttons(3).Themes = .F.
2943: 
2944:         *-- Padrao Preenchimento (Fwoption3, 4 btn)
2945:         par_oPg.AddObject("lbl_4c_LblPadPgrec", "Label")
2946:         WITH par_oPg.lbl_4c_LblPadPgrec

*-- Linhas 2957 a 3000:
2957:             .Visible = .T.
2958:         ENDWITH
2959: 
2960:         par_oPg.AddObject("Fwoption3", "OptionGroup")
2961:         loc_oOpt = par_oPg.Fwoption3
2962:         WITH loc_oOpt
2963:             .ButtonCount = 4
2964:             .Top = 394
2965:             .Left = 192
2966:             .Width = 353
2967:             .Height = 23
2968:             .BackStyle = 0
2969:             .BorderStyle = 0
2970:             .Value = 1
2971:             .Visible = .T.
2972:         ENDWITH
2973:         loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
2974:         loc_oOpt.Buttons(1).Left = 5
2975:         loc_oOpt.Buttons(1).Top = 3
2976:         loc_oOpt.Buttons(1).Width = 40
2977:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2978:         loc_oOpt.Buttons(1).FontSize = 8
2979:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2980:         loc_oOpt.Buttons(1).Themes = .F.
2981:         loc_oOpt.Buttons(2).Caption = "Gravar Zero"
2982:         loc_oOpt.Buttons(2).Left = 50
2983:         loc_oOpt.Buttons(2).Top = 3
2984:         loc_oOpt.Buttons(2).Width = 80
2985:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2986:         loc_oOpt.Buttons(2).FontSize = 8
2987:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2988:         loc_oOpt.Buttons(2).Themes = .F.
2989:         loc_oOpt.Buttons(3).Caption = "Gravar Nulo"
2990:         loc_oOpt.Buttons(3).Left = 135
2991:         loc_oOpt.Buttons(3).Top = 3
2992:         loc_oOpt.Buttons(3).Width = 80
2993:         loc_oOpt.Buttons(3).FontName = "Tahoma"
2994:         loc_oOpt.Buttons(3).FontSize = 8
2995:         loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
2996:         loc_oOpt.Buttons(3).Themes = .F.
2997:         loc_oOpt.Buttons(4).Caption = "Gravar Vazio"
2998:         loc_oOpt.Buttons(4).Left = 220
2999:         loc_oOpt.Buttons(4).Top = 3
3000:         loc_oOpt.Buttons(4).Width = 80

*-- Linhas 3019 a 3339:
3019:             .Visible = .T.
3020:         ENDWITH
3021: 
3022:         par_oPg.AddObject("optVincPgRcs", "OptionGroup")
3023:         loc_oOpt = par_oPg.optVincPgRcs
3024:         WITH loc_oOpt
3025:             .ButtonCount = 2
3026:             .Top = 415
3027:             .Left = 192
3028:             .Width = 181
3029:             .Height = 23
3030:             .BackStyle = 0
3031:             .BorderStyle = 0
3032:             .Value = 1
3033:             .Visible = .T.
3034:         ENDWITH
3035:         loc_oOpt.Buttons(1).Caption = "Sim"
3036:         loc_oOpt.Buttons(1).Left = 5
3037:         loc_oOpt.Buttons(1).Top = 3
3038:         loc_oOpt.Buttons(1).Width = 40
3039:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3040:         loc_oOpt.Buttons(1).FontSize = 8
3041:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3042:         loc_oOpt.Buttons(1).Themes = .F.
3043:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3044:         loc_oOpt.Buttons(2).Left = 48
3045:         loc_oOpt.Buttons(2).Top = 3
3046:         loc_oOpt.Buttons(2).Width = 44
3047:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3048:         loc_oOpt.Buttons(2).FontSize = 8
3049:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3050:         loc_oOpt.Buttons(2).Themes = .F.
3051: 
3052:         *-- Tit Nao Baixado (OptTitBaixado)
3053:         par_oPg.AddObject("lbl_4c_LblTitBaix", "Label")
3054:         WITH par_oPg.lbl_4c_LblTitBaix
3055:             .Caption = "Visualiza Tit.n" + CHR(227) + "o Baixados:"
3056:             .Top = 435
3057:             .Left = 17
3058:             .Width = 173
3059:             .Height = 17
3060:             .FontName = "Tahoma"
3061:             .FontSize = 8
3062:             .ForeColor = RGB(90,90,90)
3063:             .BackStyle = 0
3064:             .Alignment = 1
3065:             .Visible = .T.
3066:         ENDWITH
3067: 
3068:         par_oPg.AddObject("OptTitBaixado", "OptionGroup")
3069:         loc_oOpt = par_oPg.OptTitBaixado
3070:         WITH loc_oOpt
3071:             .ButtonCount = 2
3072:             .Top = 435
3073:             .Left = 192
3074:             .Width = 181
3075:             .Height = 23
3076:             .BackStyle = 0
3077:             .BorderStyle = 0
3078:             .Value = 1
3079:             .Visible = .T.
3080:         ENDWITH
3081:         loc_oOpt.Buttons(1).Caption = "Sim"
3082:         loc_oOpt.Buttons(1).Left = 5
3083:         loc_oOpt.Buttons(1).Top = 3
3084:         loc_oOpt.Buttons(1).Width = 40
3085:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3086:         loc_oOpt.Buttons(1).FontSize = 8
3087:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3088:         loc_oOpt.Buttons(1).Themes = .F.
3089:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3090:         loc_oOpt.Buttons(2).Left = 48
3091:         loc_oOpt.Buttons(2).Top = 3
3092:         loc_oOpt.Buttons(2).Width = 44
3093:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3094:         loc_oOpt.Buttons(2).FontSize = 8
3095:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3096:         loc_oOpt.Buttons(2).Themes = .F.
3097: 
3098:         *-- Col 3: dados adicionais (Left 583+)
3099:         *-- Duplicar Endereco (Fwoption4)
3100:         par_oPg.AddObject("lbl_4c_LblDupEnd", "Label")
3101:         WITH par_oPg.lbl_4c_LblDupEnd
3102:             .Caption = "Duplicar Endere" + CHR(231) + "o:"
3103:             .Top = 34
3104:             .Left = 600
3105:             .Width = 120
3106:             .Height = 17
3107:             .FontName = "Tahoma"
3108:             .FontSize = 8
3109:             .ForeColor = RGB(90,90,90)
3110:             .BackStyle = 0
3111:             .Alignment = 1
3112:             .Visible = .T.
3113:         ENDWITH
3114: 
3115:         par_oPg.AddObject("Fwoption4", "OptionGroup")
3116:         loc_oOpt = par_oPg.Fwoption4
3117:         WITH loc_oOpt
3118:             .ButtonCount = 2
3119:             .Top = 34
3120:             .Left = 796
3121:             .Width = 131
3122:             .Height = 23
3123:             .BackStyle = 0
3124:             .BorderStyle = 0
3125:             .Value = 1
3126:             .Visible = .T.
3127:         ENDWITH
3128:         loc_oOpt.Buttons(1).Caption = "Sim"
3129:         loc_oOpt.Buttons(1).Left = 5
3130:         loc_oOpt.Buttons(1).Top = 3
3131:         loc_oOpt.Buttons(1).Width = 40
3132:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3133:         loc_oOpt.Buttons(1).FontSize = 8
3134:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3135:         loc_oOpt.Buttons(1).Themes = .F.
3136:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3137:         loc_oOpt.Buttons(2).Left = 48
3138:         loc_oOpt.Buttons(2).Top = 3
3139:         loc_oOpt.Buttons(2).Width = 44
3140:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3141:         loc_oOpt.Buttons(2).FontSize = 8
3142:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3143:         loc_oOpt.Buttons(2).Themes = .F.
3144: 
3145:         *-- Restringe Endereco (Fwoption5)
3146:         par_oPg.AddObject("lbl_4c_LblRestrEnd", "Label")
3147:         WITH par_oPg.lbl_4c_LblRestrEnd
3148:             .Caption = "Restringe Endere" + CHR(231) + "o:"
3149:             .Top = 55
3150:             .Left = 600
3151:             .Width = 120
3152:             .Height = 17
3153:             .FontName = "Tahoma"
3154:             .FontSize = 8
3155:             .ForeColor = RGB(90,90,90)
3156:             .BackStyle = 0
3157:             .Alignment = 1
3158:             .Visible = .T.
3159:         ENDWITH
3160: 
3161:         par_oPg.AddObject("Fwoption5", "OptionGroup")
3162:         loc_oOpt = par_oPg.Fwoption5
3163:         WITH loc_oOpt
3164:             .ButtonCount = 2
3165:             .Top = 55
3166:             .Left = 796
3167:             .Width = 131
3168:             .Height = 23
3169:             .BackStyle = 0
3170:             .BorderStyle = 0
3171:             .Value = 1
3172:             .Visible = .T.
3173:         ENDWITH
3174:         loc_oOpt.Buttons(1).Caption = "Sim"
3175:         loc_oOpt.Buttons(1).Left = 5
3176:         loc_oOpt.Buttons(1).Top = 3
3177:         loc_oOpt.Buttons(1).Width = 40
3178:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3179:         loc_oOpt.Buttons(1).FontSize = 8
3180:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3181:         loc_oOpt.Buttons(1).Themes = .F.
3182:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3183:         loc_oOpt.Buttons(2).Left = 48
3184:         loc_oOpt.Buttons(2).Top = 3
3185:         loc_oOpt.Buttons(2).Width = 44
3186:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3187:         loc_oOpt.Buttons(2).FontSize = 8
3188:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3189:         loc_oOpt.Buttons(2).Themes = .F.
3190: 
3191:         *-- Bloqueia CPF (Fwoption16)
3192:         par_oPg.AddObject("lbl_4c_LblBlqCpf", "Label")
3193:         WITH par_oPg.lbl_4c_LblBlqCpf
3194:             .Caption = "Bloqueia CPF dup.:"
3195:             .Top = 73
3196:             .Left = 600
3197:             .Width = 120
3198:             .Height = 17
3199:             .FontName = "Tahoma"
3200:             .FontSize = 8
3201:             .ForeColor = RGB(90,90,90)
3202:             .BackStyle = 0
3203:             .Alignment = 1
3204:             .Visible = .T.
3205:         ENDWITH
3206: 
3207:         par_oPg.AddObject("Fwoption16", "OptionGroup")
3208:         loc_oOpt = par_oPg.Fwoption16
3209:         WITH loc_oOpt
3210:             .ButtonCount = 2
3211:             .Top = 73
3212:             .Left = 796
3213:             .Width = 131
3214:             .Height = 23
3215:             .BackStyle = 0
3216:             .BorderStyle = 0
3217:             .Value = 1
3218:             .Visible = .T.
3219:         ENDWITH
3220:         loc_oOpt.Buttons(1).Caption = "Sim"
3221:         loc_oOpt.Buttons(1).Left = 5
3222:         loc_oOpt.Buttons(1).Top = 3
3223:         loc_oOpt.Buttons(1).Width = 40
3224:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3225:         loc_oOpt.Buttons(1).FontSize = 8
3226:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3227:         loc_oOpt.Buttons(1).Themes = .F.
3228:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3229:         loc_oOpt.Buttons(2).Left = 48
3230:         loc_oOpt.Buttons(2).Top = 3
3231:         loc_oOpt.Buttons(2).Width = 44
3232:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3233:         loc_oOpt.Buttons(2).FontSize = 8
3234:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3235:         loc_oOpt.Buttons(2).Themes = .F.
3236: 
3237:         *-- Mostrar Foto (Opt_MFotos)
3238:         par_oPg.AddObject("lbl_4c_LblMFotos", "Label")
3239:         WITH par_oPg.lbl_4c_LblMFotos
3240:             .Caption = "Mostrar Foto:"
3241:             .Top = 93
3242:             .Left = 600
3243:             .Width = 120
3244:             .Height = 17
3245:             .FontName = "Tahoma"
3246:             .FontSize = 8
3247:             .ForeColor = RGB(90,90,90)
3248:             .BackStyle = 0
3249:             .Alignment = 1
3250:             .Visible = .T.
3251:         ENDWITH
3252: 
3253:         par_oPg.AddObject("Opt_MFotos", "OptionGroup")
3254:         loc_oOpt = par_oPg.Opt_MFotos
3255:         WITH loc_oOpt
3256:             .ButtonCount = 2
3257:             .Top = 93
3258:             .Left = 796
3259:             .Width = 131
3260:             .Height = 22
3261:             .BackStyle = 0
3262:             .BorderStyle = 0
3263:             .Value = 1
3264:             .Visible = .T.
3265:         ENDWITH
3266:         loc_oOpt.Buttons(1).Caption = "Sim"
3267:         loc_oOpt.Buttons(1).Left = 5
3268:         loc_oOpt.Buttons(1).Top = 3
3269:         loc_oOpt.Buttons(1).Width = 40
3270:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3271:         loc_oOpt.Buttons(1).FontSize = 8
3272:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3273:         loc_oOpt.Buttons(1).Themes = .F.
3274:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3275:         loc_oOpt.Buttons(2).Left = 48
3276:         loc_oOpt.Buttons(2).Top = 3
3277:         loc_oOpt.Buttons(2).Width = 44
3278:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3279:         loc_oOpt.Buttons(2).FontSize = 8
3280:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3281:         loc_oOpt.Buttons(2).Themes = .F.
3282: 
3283:         *-- Observacoes (fwoption1, 3 btn)
3284:         par_oPg.AddObject("lbl_4c_LblObservs", "Label")
3285:         WITH par_oPg.lbl_4c_LblObservs
3286:             .Caption = "Observa" + CHR(231) + CHR(245) + "es:"
3287:             .Top = 111
3288:             .Left = 600
3289:             .Width = 120
3290:             .Height = 17
3291:             .FontName = "Tahoma"
3292:             .FontSize = 8
3293:             .ForeColor = RGB(90,90,90)
3294:             .BackStyle = 0
3295:             .Alignment = 1
3296:             .Visible = .T.
3297:         ENDWITH
3298: 
3299:         par_oPg.AddObject("fwoption1", "OptionGroup")
3300:         loc_oOpt = par_oPg.fwoption1
3301:         WITH loc_oOpt
3302:             .ButtonCount = 3
3303:             .Top = 111
3304:             .Left = 797
3305:             .Width = 131
3306:             .Height = 52
3307:             .BackStyle = 0
3308:             .BorderStyle = 0
3309:             .Value = 1
3310:             .Visible = .T.
3311:         ENDWITH
3312:         loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
3313:         loc_oOpt.Buttons(1).Left = 5
3314:         loc_oOpt.Buttons(1).Top = 3
3315:         loc_oOpt.Buttons(1).Width = 44
3316:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3317:         loc_oOpt.Buttons(1).FontSize = 8
3318:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3319:         loc_oOpt.Buttons(1).Themes = .F.
3320:         loc_oOpt.Buttons(2).Caption = "Livre"
3321:         loc_oOpt.Buttons(2).Left = 5
3322:         loc_oOpt.Buttons(2).Top = 22
3323:         loc_oOpt.Buttons(2).Width = 44
3324:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3325:         loc_oOpt.Buttons(2).FontSize = 8
3326:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3327:         loc_oOpt.Buttons(2).Themes = .F.
3328:         loc_oOpt.Buttons(3).Caption = "RTF"
3329:         loc_oOpt.Buttons(3).Left = 5
3330:         loc_oOpt.Buttons(3).Top = 41
3331:         loc_oOpt.Buttons(3).Width = 44
3332:         loc_oOpt.Buttons(3).FontName = "Tahoma"
3333:         loc_oOpt.Buttons(3).FontSize = 8
3334:         loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
3335:         loc_oOpt.Buttons(3).Themes = .F.
3336: 
3337:         *-- CPF Fixo (optCpffixo, 3 btn)
3338:         par_oPg.AddObject("lbl_4c_LblCpfFixo", "Label")
3339:         WITH par_oPg.lbl_4c_LblCpfFixo

*-- Linhas 3350 a 3393:
3350:             .Visible = .T.
3351:         ENDWITH
3352: 
3353:         par_oPg.AddObject("optCpffixo", "OptionGroup")
3354:         loc_oOpt = par_oPg.optCpffixo
3355:         WITH loc_oOpt
3356:             .ButtonCount = 3
3357:             .Top = 163
3358:             .Left = 798
3359:             .Width = 183
3360:             .Height = 23
3361:             .BackStyle = 0
3362:             .BorderStyle = 0
3363:             .Value = 1
3364:             .Visible = .T.
3365:         ENDWITH
3366:         loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
3367:         loc_oOpt.Buttons(1).Left = 5
3368:         loc_oOpt.Buttons(1).Top = 3
3369:         loc_oOpt.Buttons(1).Width = 40
3370:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3371:         loc_oOpt.Buttons(1).FontSize = 8
3372:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3373:         loc_oOpt.Buttons(1).Themes = .F.
3374:         loc_oOpt.Buttons(2).Caption = "Fixar Formato"
3375:         loc_oOpt.Buttons(2).Left = 50
3376:         loc_oOpt.Buttons(2).Top = 3
3377:         loc_oOpt.Buttons(2).Width = 80
3378:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3379:         loc_oOpt.Buttons(2).FontSize = 8
3380:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3381:         loc_oOpt.Buttons(2).Themes = .F.
3382:         loc_oOpt.Buttons(3).Caption = "Fixar CPF"
3383:         loc_oOpt.Buttons(3).Left = 135
3384:         loc_oOpt.Buttons(3).Top = 3
3385:         loc_oOpt.Buttons(3).Width = 45
3386:         loc_oOpt.Buttons(3).FontName = "Tahoma"
3387:         loc_oOpt.Buttons(3).FontSize = 8
3388:         loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
3389:         loc_oOpt.Buttons(3).Themes = .F.
3390: 
3391:         *-- Situacao Padrao
3392:         par_oPg.AddObject("lbl_4c_LblSitPad", "Label")
3393:         WITH par_oPg.lbl_4c_LblSitPad

*-- Linhas 3420 a 3575:
3420:             .SpecialEffect = 0
3421:             .Visible = .T.
3422:         ENDWITH
3423:         BINDEVENT(par_oPg.getSituas, "KeyPress",  THIS, "SituacaoKeyPress")
3424:         BINDEVENT(par_oPg.getSituas, "DblClick",  THIS, "SituacaoDblClick")
3425:         BINDEVENT(par_oPg.getSituas, "KeyPress", THIS, "SituacaoLostFocus")
3426: 
3427:         *-- Caracteristicas (optCarac)
3428:         par_oPg.AddObject("lbl_4c_LblCarac", "Label")
3429:         WITH par_oPg.lbl_4c_LblCarac
3430:             .Caption = "Caracter" + CHR(237) + "sticas:"
3431:             .Top = 211
3432:             .Left = 600
3433:             .Width = 120
3434:             .Height = 17
3435:             .FontName = "Tahoma"
3436:             .FontSize = 8
3437:             .ForeColor = RGB(90,90,90)
3438:             .BackStyle = 0
3439:             .Alignment = 1
3440:             .Visible = .T.
3441:         ENDWITH
3442: 
3443:         par_oPg.AddObject("optCarac", "OptionGroup")
3444:         loc_oOpt = par_oPg.optCarac
3445:         WITH loc_oOpt
3446:             .ButtonCount = 2
3447:             .Top = 211
3448:             .Left = 796
3449:             .Width = 131
3450:             .Height = 23
3451:             .BackStyle = 0
3452:             .BorderStyle = 0
3453:             .Value = 1
3454:             .Visible = .T.
3455:         ENDWITH
3456:         loc_oOpt.Buttons(1).Caption = "Sim"
3457:         loc_oOpt.Buttons(1).Left = 5
3458:         loc_oOpt.Buttons(1).Top = 3
3459:         loc_oOpt.Buttons(1).Width = 40
3460:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3461:         loc_oOpt.Buttons(1).FontSize = 8
3462:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3463:         loc_oOpt.Buttons(1).Themes = .F.
3464:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3465:         loc_oOpt.Buttons(2).Left = 48
3466:         loc_oOpt.Buttons(2).Top = 3
3467:         loc_oOpt.Buttons(2).Width = 44
3468:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3469:         loc_oOpt.Buttons(2).FontSize = 8
3470:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3471:         loc_oOpt.Buttons(2).Themes = .F.
3472: 
3473:         *-- AceJob (optAceJob)
3474:         par_oPg.AddObject("lbl_4c_LblAceJob", "Label")
3475:         WITH par_oPg.lbl_4c_LblAceJob
3476:             .Caption = "Aceita Job:"
3477:             .Top = 232
3478:             .Left = 600
3479:             .Width = 120
3480:             .Height = 17
3481:             .FontName = "Tahoma"
3482:             .FontSize = 8
3483:             .ForeColor = RGB(90,90,90)
3484:             .BackStyle = 0
3485:             .Alignment = 1
3486:             .Visible = .T.
3487:         ENDWITH
3488: 
3489:         par_oPg.AddObject("optAceJob", "OptionGroup")
3490:         loc_oOpt = par_oPg.optAceJob
3491:         WITH loc_oOpt
3492:             .ButtonCount = 2
3493:             .Top = 232
3494:             .Left = 796
3495:             .Width = 131
3496:             .Height = 23
3497:             .BackStyle = 0
3498:             .BorderStyle = 0
3499:             .Value = 1
3500:             .Visible = .T.
3501:         ENDWITH
3502:         loc_oOpt.Buttons(1).Caption = "Sim"
3503:         loc_oOpt.Buttons(1).Left = 5
3504:         loc_oOpt.Buttons(1).Top = 3
3505:         loc_oOpt.Buttons(1).Width = 40
3506:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3507:         loc_oOpt.Buttons(1).FontSize = 8
3508:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3509:         loc_oOpt.Buttons(1).Themes = .F.
3510:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3511:         loc_oOpt.Buttons(2).Left = 48
3512:         loc_oOpt.Buttons(2).Top = 3
3513:         loc_oOpt.Buttons(2).Width = 44
3514:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3515:         loc_oOpt.Buttons(2).FontSize = 8
3516:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3517:         loc_oOpt.Buttons(2).Themes = .F.
3518: 
3519:         *-- Alerta Cadastro (OptAlertaCad)
3520:         par_oPg.AddObject("lbl_4c_LblAlertaCad", "Label")
3521:         WITH par_oPg.lbl_4c_LblAlertaCad
3522:             .Caption = "Alerta Cadastro:"
3523:             .Top = 250
3524:             .Left = 600
3525:             .Width = 120
3526:             .Height = 17
3527:             .FontName = "Tahoma"
3528:             .FontSize = 8
3529:             .ForeColor = RGB(90,90,90)
3530:             .BackStyle = 0
3531:             .Alignment = 1
3532:             .Visible = .T.
3533:         ENDWITH
3534: 
3535:         par_oPg.AddObject("OptAlertaCad", "OptionGroup")
3536:         loc_oOpt = par_oPg.OptAlertaCad
3537:         WITH loc_oOpt
3538:             .ButtonCount = 2
3539:             .Top = 250
3540:             .Left = 795
3541:             .Width = 98
3542:             .Height = 25
3543:             .BackStyle = 0
3544:             .BorderStyle = 0
3545:             .Value = 1
3546:             .Visible = .T.
3547:         ENDWITH
3548:         loc_oOpt.Buttons(1).Caption = "Sim"
3549:         loc_oOpt.Buttons(1).Left = 5
3550:         loc_oOpt.Buttons(1).Top = 3
3551:         loc_oOpt.Buttons(1).Width = 40
3552:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3553:         loc_oOpt.Buttons(1).FontSize = 8
3554:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3555:         loc_oOpt.Buttons(1).Themes = .F.
3556:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3557:         loc_oOpt.Buttons(2).Left = 48
3558:         loc_oOpt.Buttons(2).Top = 3
3559:         loc_oOpt.Buttons(2).Width = 44
3560:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3561:         loc_oOpt.Buttons(2).FontSize = 8
3562:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3563:         loc_oOpt.Buttons(2).Themes = .F.
3564: 
3565:         *-- Mensagem de Alerta
3566:         par_oPg.AddObject("lbl_4c_LblMsgAlerta", "Label")
3567:         WITH par_oPg.lbl_4c_LblMsgAlerta
3568:             .Caption = "Mensagem Alerta:"
3569:             .Top = 271
3570:             .Left = 600
3571:             .Width = 120
3572:             .Height = 17
3573:             .FontName = "Tahoma"
3574:             .FontSize = 8
3575:             .ForeColor = RGB(90,90,90)

*-- Linhas 3598 a 3901:
3598:     *--------------------------------------------------------------------------
3599:     * CriarAbaEstoque - Controles da aba Estoque (pgf_4c_1.Page3)
3600:     *--------------------------------------------------------------------------
3601:     PROTECTED PROCEDURE CriarAbaEstoque(par_oPg)
3602:         LOCAL loc_oOpt
3603: 
3604:         *-- Linha separadora
3605:         par_oPg.AddObject("lin_4c_Est1", "Line")
3606:         WITH par_oPg.lin_4c_Est1
3607:             .Top = 158
3608:             .Left = 17
3609:             .Width = 959
3610:             .Height = 1
3611:             .BorderColor = RGB(150,150,150)
3612:             .Visible = .T.
3613:         ENDWITH
3614: 
3615:         *-- Limite de Estoque (Opt_LimEsto)
3616:         par_oPg.AddObject("lbl_4c_LblLimEsto", "Label")
3617:         WITH par_oPg.lbl_4c_LblLimEsto
3618:             .Caption = "Limite de Estoque:"
3619:             .Top = 29
3620:             .Left = 17
3621:             .Width = 156
3622:             .Height = 17
3623:             .FontName = "Tahoma"
3624:             .FontSize = 8
3625:             .ForeColor = RGB(90,90,90)
3626:             .BackStyle = 0
3627:             .Alignment = 1
3628:             .Visible = .T.
3629:         ENDWITH
3630: 
3631:         par_oPg.AddObject("Opt_LimEsto", "OptionGroup")
3632:         loc_oOpt = par_oPg.Opt_LimEsto
3633:         WITH loc_oOpt
3634:             .ButtonCount = 2
3635:             .Top = 29
3636:             .Left = 174
3637:             .Width = 92
3638:             .Height = 25
3639:             .BackStyle = 0
3640:             .BorderStyle = 0
3641:             .Value = 1
3642:             .Visible = .T.
3643:         ENDWITH
3644:         loc_oOpt.Buttons(1).Caption = "Sim"
3645:         loc_oOpt.Buttons(1).Left = 5
3646:         loc_oOpt.Buttons(1).Top = 3
3647:         loc_oOpt.Buttons(1).Width = 40
3648:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3649:         loc_oOpt.Buttons(1).FontSize = 8
3650:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3651:         loc_oOpt.Buttons(1).Themes = .F.
3652:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3653:         loc_oOpt.Buttons(2).Left = 48
3654:         loc_oOpt.Buttons(2).Top = 3
3655:         loc_oOpt.Buttons(2).Width = 44
3656:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3657:         loc_oOpt.Buttons(2).FontSize = 8
3658:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3659:         loc_oOpt.Buttons(2).Themes = .F.
3660: 
3661:         *-- Verificar Estoque (Opt_VerEst)
3662:         par_oPg.AddObject("lbl_4c_LblVerEst", "Label")
3663:         WITH par_oPg.lbl_4c_LblVerEst
3664:             .Caption = "Verificar Estoque:"
3665:             .Top = 53
3666:             .Left = 17
3667:             .Width = 156
3668:             .Height = 17
3669:             .FontName = "Tahoma"
3670:             .FontSize = 8
3671:             .ForeColor = RGB(90,90,90)
3672:             .BackStyle = 0
3673:             .Alignment = 1
3674:             .Visible = .T.
3675:         ENDWITH
3676: 
3677:         par_oPg.AddObject("Opt_VerEst", "OptionGroup")
3678:         loc_oOpt = par_oPg.Opt_VerEst
3679:         WITH loc_oOpt
3680:             .ButtonCount = 2
3681:             .Top = 53
3682:             .Left = 174
3683:             .Width = 92
3684:             .Height = 25
3685:             .BackStyle = 0
3686:             .BorderStyle = 0
3687:             .Value = 1
3688:             .Visible = .T.
3689:         ENDWITH
3690:         loc_oOpt.Buttons(1).Caption = "Sim"
3691:         loc_oOpt.Buttons(1).Left = 5
3692:         loc_oOpt.Buttons(1).Top = 3
3693:         loc_oOpt.Buttons(1).Width = 40
3694:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3695:         loc_oOpt.Buttons(1).FontSize = 8
3696:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3697:         loc_oOpt.Buttons(1).Themes = .F.
3698:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3699:         loc_oOpt.Buttons(2).Left = 48
3700:         loc_oOpt.Buttons(2).Top = 3
3701:         loc_oOpt.Buttons(2).Width = 44
3702:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3703:         loc_oOpt.Buttons(2).FontSize = 8
3704:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3705:         loc_oOpt.Buttons(2).Themes = .F.
3706: 
3707:         *-- Est P.Acabar (Opt_EstPAcab)
3708:         par_oPg.AddObject("lbl_4c_LblEstPAcab", "Label")
3709:         WITH par_oPg.lbl_4c_LblEstPAcab
3710:             .Caption = "Est. P.Acabar:"
3711:             .Top = 77
3712:             .Left = 17
3713:             .Width = 156
3714:             .Height = 17
3715:             .FontName = "Tahoma"
3716:             .FontSize = 8
3717:             .ForeColor = RGB(90,90,90)
3718:             .BackStyle = 0
3719:             .Alignment = 1
3720:             .Visible = .T.
3721:         ENDWITH
3722: 
3723:         par_oPg.AddObject("Opt_EstPAcab", "OptionGroup")
3724:         loc_oOpt = par_oPg.Opt_EstPAcab
3725:         WITH loc_oOpt
3726:             .ButtonCount = 2
3727:             .Top = 77
3728:             .Left = 174
3729:             .Width = 92
3730:             .Height = 25
3731:             .BackStyle = 0
3732:             .BorderStyle = 0
3733:             .Value = 1
3734:             .Visible = .T.
3735:         ENDWITH
3736:         loc_oOpt.Buttons(1).Caption = "Sim"
3737:         loc_oOpt.Buttons(1).Left = 5
3738:         loc_oOpt.Buttons(1).Top = 3
3739:         loc_oOpt.Buttons(1).Width = 40
3740:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3741:         loc_oOpt.Buttons(1).FontSize = 8
3742:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3743:         loc_oOpt.Buttons(1).Themes = .F.
3744:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3745:         loc_oOpt.Buttons(2).Left = 48
3746:         loc_oOpt.Buttons(2).Top = 3
3747:         loc_oOpt.Buttons(2).Width = 44
3748:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3749:         loc_oOpt.Buttons(2).FontSize = 8
3750:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3751:         loc_oOpt.Buttons(2).Themes = .F.
3752: 
3753:         *-- Checa Lim Estoque (opt_ChkLimest)
3754:         par_oPg.AddObject("lbl_4c_LblChkLimEst", "Label")
3755:         WITH par_oPg.lbl_4c_LblChkLimEst
3756:             .Caption = "Checa Lim.Estoque:"
3757:             .Top = 101
3758:             .Left = 17
3759:             .Width = 156
3760:             .Height = 17
3761:             .FontName = "Tahoma"
3762:             .FontSize = 8
3763:             .ForeColor = RGB(90,90,90)
3764:             .BackStyle = 0
3765:             .Alignment = 1
3766:             .Visible = .T.
3767:         ENDWITH
3768: 
3769:         par_oPg.AddObject("opt_ChkLimest", "OptionGroup")
3770:         loc_oOpt = par_oPg.opt_ChkLimest
3771:         WITH loc_oOpt
3772:             .ButtonCount = 2
3773:             .Top = 101
3774:             .Left = 174
3775:             .Width = 92
3776:             .Height = 25
3777:             .BackStyle = 0
3778:             .BorderStyle = 0
3779:             .Value = 1
3780:             .Visible = .T.
3781:         ENDWITH
3782:         loc_oOpt.Buttons(1).Caption = "Sim"
3783:         loc_oOpt.Buttons(1).Left = 5
3784:         loc_oOpt.Buttons(1).Top = 3
3785:         loc_oOpt.Buttons(1).Width = 40
3786:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3787:         loc_oOpt.Buttons(1).FontSize = 8
3788:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3789:         loc_oOpt.Buttons(1).Themes = .F.
3790:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3791:         loc_oOpt.Buttons(2).Left = 48
3792:         loc_oOpt.Buttons(2).Top = 3
3793:         loc_oOpt.Buttons(2).Width = 44
3794:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3795:         loc_oOpt.Buttons(2).FontSize = 8
3796:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3797:         loc_oOpt.Buttons(2).Themes = .F.
3798: 
3799:         *-- Centro de Custos (Opt_CCusto)
3800:         par_oPg.AddObject("lbl_4c_LblCCusto", "Label")
3801:         WITH par_oPg.lbl_4c_LblCCusto
3802:             .Caption = "Centro de Custos:"
3803:             .Top = 125
3804:             .Left = 17
3805:             .Width = 156
3806:             .Height = 17
3807:             .FontName = "Tahoma"
3808:             .FontSize = 8
3809:             .ForeColor = RGB(90,90,90)
3810:             .BackStyle = 0
3811:             .Alignment = 1
3812:             .Visible = .T.
3813:         ENDWITH
3814: 
3815:         par_oPg.AddObject("Opt_CCusto", "OptionGroup")
3816:         loc_oOpt = par_oPg.Opt_CCusto
3817:         WITH loc_oOpt
3818:             .ButtonCount = 2
3819:             .Top = 125
3820:             .Left = 174
3821:             .Width = 92
3822:             .Height = 25
3823:             .BackStyle = 0
3824:             .BorderStyle = 0
3825:             .Value = 1
3826:             .Visible = .T.
3827:         ENDWITH
3828:         loc_oOpt.Buttons(1).Caption = "Sim"
3829:         loc_oOpt.Buttons(1).Left = 5
3830:         loc_oOpt.Buttons(1).Top = 3
3831:         loc_oOpt.Buttons(1).Width = 40
3832:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3833:         loc_oOpt.Buttons(1).FontSize = 8
3834:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3835:         loc_oOpt.Buttons(1).Themes = .F.
3836:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3837:         loc_oOpt.Buttons(2).Left = 48
3838:         loc_oOpt.Buttons(2).Top = 3
3839:         loc_oOpt.Buttons(2).Width = 44
3840:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3841:         loc_oOpt.Buttons(2).FontSize = 8
3842:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3843:         loc_oOpt.Buttons(2).Themes = .F.
3844: 
3845:         *-- Gerar Balancete (Opt_GBals)
3846:         par_oPg.AddObject("lbl_4c_LblGBals", "Label")
3847:         WITH par_oPg.lbl_4c_LblGBals
3848:             .Caption = "Gerar Balan" + CHR(231) + "o:"
3849:             .Top = 191
3850:             .Left = 17
3851:             .Width = 156
3852:             .Height = 17
3853:             .FontName = "Tahoma"
3854:             .FontSize = 8
3855:             .ForeColor = RGB(90,90,90)
3856:             .BackStyle = 0
3857:             .Alignment = 1
3858:             .Visible = .T.
3859:         ENDWITH
3860: 
3861:         par_oPg.AddObject("Opt_GBals", "OptionGroup")
3862:         loc_oOpt = par_oPg.Opt_GBals
3863:         WITH loc_oOpt
3864:             .ButtonCount = 2
3865:             .Top = 191
3866:             .Left = 174
3867:             .Width = 92
3868:             .Height = 25
3869:             .BackStyle = 0
3870:             .BorderStyle = 0
3871:             .Value = 1
3872:             .Visible = .T.
3873:         ENDWITH
3874:         loc_oOpt.Buttons(1).Caption = "Sim"
3875:         loc_oOpt.Buttons(1).Left = 5
3876:         loc_oOpt.Buttons(1).Top = 3
3877:         loc_oOpt.Buttons(1).Width = 40
3878:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3879:         loc_oOpt.Buttons(1).FontSize = 8
3880:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3881:         loc_oOpt.Buttons(1).Themes = .F.
3882:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3883:         loc_oOpt.Buttons(2).Left = 48
3884:         loc_oOpt.Buttons(2).Top = 3
3885:         loc_oOpt.Buttons(2).Width = 44
3886:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3887:         loc_oOpt.Buttons(2).FontSize = 8
3888:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3889:         loc_oOpt.Buttons(2).Themes = .F.
3890: 
3891:         *-- Grupo Dif Balanco
3892:         par_oPg.AddObject("lbl_4c_LblGrufals", "Label")
3893:         WITH par_oPg.lbl_4c_LblGrufals
3894:             .Caption = "Grupo Dif.Balan" + CHR(231) + "o:"
3895:             .Top = 216
3896:             .Left = 17
3897:             .Width = 156
3898:             .Height = 17
3899:             .FontName = "Tahoma"
3900:             .FontSize = 8
3901:             .ForeColor = RGB(90,90,90)

*-- Linhas 3920 a 3982:
3920:             .SpecialEffect = 0
3921:             .Visible = .T.
3922:         ENDWITH
3923:         BINDEVENT(par_oPg.Get_grupo, "KeyPress", THIS, "GrupoEstoqueKeyPress")
3924:         BINDEVENT(par_oPg.Get_grupo, "DblClick", THIS, "GrupoEstoqueDblClick")
3925: 
3926:         *-- Balanco Unificado (Opt_UnifBal, 4 btn)
3927:         par_oPg.AddObject("lbl_4c_LblUnifBal", "Label")
3928:         WITH par_oPg.lbl_4c_LblUnifBal
3929:             .Caption = "Balan" + CHR(231) + "o Unificado:"
3930:             .Top = 242
3931:             .Left = 17
3932:             .Width = 156
3933:             .Height = 17
3934:             .FontName = "Tahoma"
3935:             .FontSize = 8
3936:             .ForeColor = RGB(90,90,90)
3937:             .BackStyle = 0
3938:             .Alignment = 1
3939:             .Visible = .T.
3940:         ENDWITH
3941: 
3942:         par_oPg.AddObject("Opt_UnifBal", "OptionGroup")
3943:         loc_oOpt = par_oPg.Opt_UnifBal
3944:         WITH loc_oOpt
3945:             .ButtonCount = 4
3946:             .Top = 242
3947:             .Left = 174
3948:             .Width = 171
3949:             .Height = 43
3950:             .BackStyle = 0
3951:             .BorderStyle = 0
3952:             .Value = 1
3953:             .Visible = .T.
3954:         ENDWITH
3955:         loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
3956:         loc_oOpt.Buttons(1).Left = 5
3957:         loc_oOpt.Buttons(1).Top = 3
3958:         loc_oOpt.Buttons(1).Width = 40
3959:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3960:         loc_oOpt.Buttons(1).FontSize = 8
3961:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3962:         loc_oOpt.Buttons(1).Themes = .F.
3963:         loc_oOpt.Buttons(2).Caption = "Empresa"
3964:         loc_oOpt.Buttons(2).Left = 50
3965:         loc_oOpt.Buttons(2).Top = 3
3966:         loc_oOpt.Buttons(2).Width = 60
3967:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3968:         loc_oOpt.Buttons(2).FontSize = 8
3969:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3970:         loc_oOpt.Buttons(2).Themes = .F.
3971:         loc_oOpt.Buttons(3).Caption = "Grupo"
3972:         loc_oOpt.Buttons(3).Left = 115
3973:         loc_oOpt.Buttons(3).Top = 3
3974:         loc_oOpt.Buttons(3).Width = 50
3975:         loc_oOpt.Buttons(3).FontName = "Tahoma"
3976:         loc_oOpt.Buttons(3).FontSize = 8
3977:         loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
3978:         loc_oOpt.Buttons(3).Themes = .F.
3979:         loc_oOpt.Buttons(4).Caption = "Ambos"
3980:         loc_oOpt.Buttons(4).Left = 5
3981:         loc_oOpt.Buttons(4).Top = 23
3982:         loc_oOpt.Buttons(4).Width = 50

*-- Linhas 4001 a 4413:
4001:             .Visible = .T.
4002:         ENDWITH
4003: 
4004:         par_oPg.AddObject("Opt_FalPers", "OptionGroup")
4005:         loc_oOpt = par_oPg.Opt_FalPers
4006:         WITH loc_oOpt
4007:             .ButtonCount = 2
4008:             .Top = 285
4009:             .Left = 174
4010:             .Width = 92
4011:             .Height = 25
4012:             .BackStyle = 0
4013:             .BorderStyle = 0
4014:             .Value = 1
4015:             .Visible = .T.
4016:         ENDWITH
4017:         loc_oOpt.Buttons(1).Caption = "Sim"
4018:         loc_oOpt.Buttons(1).Left = 5
4019:         loc_oOpt.Buttons(1).Top = 3
4020:         loc_oOpt.Buttons(1).Width = 40
4021:         loc_oOpt.Buttons(1).FontName = "Tahoma"
4022:         loc_oOpt.Buttons(1).FontSize = 8
4023:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
4024:         loc_oOpt.Buttons(1).Themes = .F.
4025:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
4026:         loc_oOpt.Buttons(2).Left = 48
4027:         loc_oOpt.Buttons(2).Top = 3
4028:         loc_oOpt.Buttons(2).Width = 44
4029:         loc_oOpt.Buttons(2).FontName = "Tahoma"
4030:         loc_oOpt.Buttons(2).FontSize = 8
4031:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
4032:         loc_oOpt.Buttons(2).Themes = .F.
4033: 
4034:         *-- Bloqueia Divisao OF (Opt_BlqDivOp)
4035:         par_oPg.AddObject("lbl_4c_LblBlqDivOp", "Label")
4036:         WITH par_oPg.lbl_4c_LblBlqDivOp
4037:             .Caption = "Bloqueia Divis" + CHR(227) + "o OF:"
4038:             .Top = 311
4039:             .Left = 17
4040:             .Width = 156
4041:             .Height = 17
4042:             .FontName = "Tahoma"
4043:             .FontSize = 8
4044:             .ForeColor = RGB(90,90,90)
4045:             .BackStyle = 0
4046:             .Alignment = 1
4047:             .Visible = .T.
4048:         ENDWITH
4049: 
4050:         par_oPg.AddObject("Opt_BlqDivOp", "OptionGroup")
4051:         loc_oOpt = par_oPg.Opt_BlqDivOp
4052:         WITH loc_oOpt
4053:             .ButtonCount = 2
4054:             .Top = 311
4055:             .Left = 174
4056:             .Width = 92
4057:             .Height = 25
4058:             .BackStyle = 0
4059:             .BorderStyle = 0
4060:             .Value = 1
4061:             .Visible = .T.
4062:         ENDWITH
4063:         loc_oOpt.Buttons(1).Caption = "Sim"
4064:         loc_oOpt.Buttons(1).Left = 5
4065:         loc_oOpt.Buttons(1).Top = 3
4066:         loc_oOpt.Buttons(1).Width = 40
4067:         loc_oOpt.Buttons(1).FontName = "Tahoma"
4068:         loc_oOpt.Buttons(1).FontSize = 8
4069:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
4070:         loc_oOpt.Buttons(1).Themes = .F.
4071:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
4072:         loc_oOpt.Buttons(2).Left = 48
4073:         loc_oOpt.Buttons(2).Top = 3
4074:         loc_oOpt.Buttons(2).Width = 44
4075:         loc_oOpt.Buttons(2).FontName = "Tahoma"
4076:         loc_oOpt.Buttons(2).FontSize = 8
4077:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
4078:         loc_oOpt.Buttons(2).Themes = .F.
4079: 
4080:         *-- OS - Data de Entrega (Get_OsPend)
4081:         par_oPg.AddObject("lbl_4c_LblOsPend", "Label")
4082:         WITH par_oPg.lbl_4c_LblOsPend
4083:             .Caption = "OS Pendente Dt.Entrega:"
4084:             .Top = 335
4085:             .Left = 17
4086:             .Width = 156
4087:             .Height = 17
4088:             .FontName = "Tahoma"
4089:             .FontSize = 8
4090:             .ForeColor = RGB(90,90,90)
4091:             .BackStyle = 0
4092:             .Alignment = 1
4093:             .Visible = .T.
4094:         ENDWITH
4095: 
4096:         par_oPg.AddObject("Get_OsPend", "OptionGroup")
4097:         loc_oOpt = par_oPg.Get_OsPend
4098:         WITH loc_oOpt
4099:             .ButtonCount = 2
4100:             .Top = 335
4101:             .Left = 174
4102:             .Width = 92
4103:             .Height = 25
4104:             .BackStyle = 0
4105:             .BorderStyle = 0
4106:             .Value = 1
4107:             .Visible = .T.
4108:         ENDWITH
4109:         loc_oOpt.Buttons(1).Caption = "Sim"
4110:         loc_oOpt.Buttons(1).Left = 5
4111:         loc_oOpt.Buttons(1).Top = 3
4112:         loc_oOpt.Buttons(1).Width = 40
4113:         loc_oOpt.Buttons(1).FontName = "Tahoma"
4114:         loc_oOpt.Buttons(1).FontSize = 8
4115:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
4116:         loc_oOpt.Buttons(1).Themes = .F.
4117:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
4118:         loc_oOpt.Buttons(2).Left = 48
4119:         loc_oOpt.Buttons(2).Top = 3
4120:         loc_oOpt.Buttons(2).Width = 44
4121:         loc_oOpt.Buttons(2).FontName = "Tahoma"
4122:         loc_oOpt.Buttons(2).FontSize = 8
4123:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
4124:         loc_oOpt.Buttons(2).Themes = .F.
4125: 
4126:         *-- Checa Dup Titulo (ObjDupTit)
4127:         par_oPg.AddObject("lbl_4c_LblDupTit", "Label")
4128:         WITH par_oPg.lbl_4c_LblDupTit
4129:             .Caption = "Checa Dup.T" + CHR(237) + "tulo:"
4130:             .Top = 361
4131:             .Left = 17
4132:             .Width = 156
4133:             .Height = 17
4134:             .FontName = "Tahoma"
4135:             .FontSize = 8
4136:             .ForeColor = RGB(90,90,90)
4137:             .BackStyle = 0
4138:             .Alignment = 1
4139:             .Visible = .T.
4140:         ENDWITH
4141: 
4142:         par_oPg.AddObject("ObjDupTit", "OptionGroup")
4143:         loc_oOpt = par_oPg.ObjDupTit
4144:         WITH loc_oOpt
4145:             .ButtonCount = 2
4146:             .Top = 361
4147:             .Left = 174
4148:             .Width = 92
4149:             .Height = 25
4150:             .BackStyle = 0
4151:             .BorderStyle = 0
4152:             .Value = 1
4153:             .Visible = .T.
4154:         ENDWITH
4155:         loc_oOpt.Buttons(1).Caption = "Sim"
4156:         loc_oOpt.Buttons(1).Left = 5
4157:         loc_oOpt.Buttons(1).Top = 3
4158:         loc_oOpt.Buttons(1).Width = 40
4159:         loc_oOpt.Buttons(1).FontName = "Tahoma"
4160:         loc_oOpt.Buttons(1).FontSize = 8
4161:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
4162:         loc_oOpt.Buttons(1).Themes = .F.
4163:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
4164:         loc_oOpt.Buttons(2).Left = 48
4165:         loc_oOpt.Buttons(2).Top = 3
4166:         loc_oOpt.Buttons(2).Width = 44
4167:         loc_oOpt.Buttons(2).FontName = "Tahoma"
4168:         loc_oOpt.Buttons(2).FontSize = 8
4169:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
4170:         loc_oOpt.Buttons(2).Themes = .F.
4171: 
4172:         *-- Col direita: saldo/relevante/etc (Left 469)
4173:         *-- Calcular Saldo (Opt_Saldo)
4174:         par_oPg.AddObject("lbl_4c_LblSaldo", "Label")
4175:         WITH par_oPg.lbl_4c_LblSaldo
4176:             .Caption = "Calcular Saldo:"
4177:             .Top = 29
4178:             .Left = 290
4179:             .Width = 178
4180:             .Height = 17
4181:             .FontName = "Tahoma"
4182:             .FontSize = 8
4183:             .ForeColor = RGB(90,90,90)
4184:             .BackStyle = 0
4185:             .Alignment = 1
4186:             .Visible = .T.
4187:         ENDWITH
4188: 
4189:         par_oPg.AddObject("Opt_Saldo", "OptionGroup")
4190:         loc_oOpt = par_oPg.Opt_Saldo
4191:         WITH loc_oOpt
4192:             .ButtonCount = 2
4193:             .Top = 29
4194:             .Left = 469
4195:             .Width = 149
4196:             .Height = 25
4197:             .BackStyle = 0
4198:             .BorderStyle = 0
4199:             .Value = 1
4200:             .Visible = .T.
4201:         ENDWITH
4202:         loc_oOpt.Buttons(1).Caption = "Sim"
4203:         loc_oOpt.Buttons(1).Left = 5
4204:         loc_oOpt.Buttons(1).Top = 3
4205:         loc_oOpt.Buttons(1).Width = 40
4206:         loc_oOpt.Buttons(1).FontName = "Tahoma"
4207:         loc_oOpt.Buttons(1).FontSize = 8
4208:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
4209:         loc_oOpt.Buttons(1).Themes = .F.
4210:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
4211:         loc_oOpt.Buttons(2).Left = 48
4212:         loc_oOpt.Buttons(2).Top = 3
4213:         loc_oOpt.Buttons(2).Width = 44
4214:         loc_oOpt.Buttons(2).FontName = "Tahoma"
4215:         loc_oOpt.Buttons(2).FontSize = 8
4216:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
4217:         loc_oOpt.Buttons(2).Themes = .F.
4218: 
4219:         *-- Empresa Relevante (Opt_Relevante)
4220:         par_oPg.AddObject("lbl_4c_LblRelev", "Label")
4221:         WITH par_oPg.lbl_4c_LblRelev
4222:             .Caption = "Empresa Relevante:"
4223:             .Top = 53
4224:             .Left = 290
4225:             .Width = 178
4226:             .Height = 17
4227:             .FontName = "Tahoma"
4228:             .FontSize = 8
4229:             .ForeColor = RGB(90,90,90)
4230:             .BackStyle = 0
4231:             .Alignment = 1
4232:             .Visible = .T.
4233:         ENDWITH
4234: 
4235:         par_oPg.AddObject("Opt_Relevante", "OptionGroup")
4236:         loc_oOpt = par_oPg.Opt_Relevante
4237:         WITH loc_oOpt
4238:             .ButtonCount = 2
4239:             .Top = 53
4240:             .Left = 469
4241:             .Width = 149
4242:             .Height = 25
4243:             .BackStyle = 0
4244:             .BorderStyle = 0
4245:             .Value = 1
4246:             .Visible = .T.
4247:         ENDWITH
4248:         loc_oOpt.Buttons(1).Caption = "Sim"
4249:         loc_oOpt.Buttons(1).Left = 5
4250:         loc_oOpt.Buttons(1).Top = 3
4251:         loc_oOpt.Buttons(1).Width = 40
4252:         loc_oOpt.Buttons(1).FontName = "Tahoma"
4253:         loc_oOpt.Buttons(1).FontSize = 8
4254:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
4255:         loc_oOpt.Buttons(1).Themes = .F.
4256:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
4257:         loc_oOpt.Buttons(2).Left = 48
4258:         loc_oOpt.Buttons(2).Top = 3
4259:         loc_oOpt.Buttons(2).Width = 44
4260:         loc_oOpt.Buttons(2).FontName = "Tahoma"
4261:         loc_oOpt.Buttons(2).FontSize = 8
4262:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
4263:         loc_oOpt.Buttons(2).Themes = .F.
4264: 
4265:         *-- Bloqueia Consulta GV (Opt_BlqConGV)
4266:         par_oPg.AddObject("lbl_4c_LblBlqConGV", "Label")
4267:         WITH par_oPg.lbl_4c_LblBlqConGV
4268:             .Caption = "Bloqueia Consulta GV:"
4269:             .Top = 77
4270:             .Left = 290
4271:             .Width = 178
4272:             .Height = 17
4273:             .FontName = "Tahoma"
4274:             .FontSize = 8
4275:             .ForeColor = RGB(90,90,90)
4276:             .BackStyle = 0
4277:             .Alignment = 1
4278:             .Visible = .T.
4279:         ENDWITH
4280: 
4281:         par_oPg.AddObject("Opt_BlqConGV", "OptionGroup")
4282:         loc_oOpt = par_oPg.Opt_BlqConGV
4283:         WITH loc_oOpt
4284:             .ButtonCount = 2
4285:             .Top = 77
4286:             .Left = 469
4287:             .Width = 149
4288:             .Height = 25
4289:             .BackStyle = 0
4290:             .BorderStyle = 0
4291:             .Value = 1
4292:             .Visible = .T.
4293:         ENDWITH
4294:         loc_oOpt.Buttons(1).Caption = "Sim"
4295:         loc_oOpt.Buttons(1).Left = 5
4296:         loc_oOpt.Buttons(1).Top = 3
4297:         loc_oOpt.Buttons(1).Width = 40
4298:         loc_oOpt.Buttons(1).FontName = "Tahoma"
4299:         loc_oOpt.Buttons(1).FontSize = 8
4300:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
4301:         loc_oOpt.Buttons(1).Themes = .F.
4302:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
4303:         loc_oOpt.Buttons(2).Left = 48
4304:         loc_oOpt.Buttons(2).Top = 3
4305:         loc_oOpt.Buttons(2).Width = 44
4306:         loc_oOpt.Buttons(2).FontName = "Tahoma"
4307:         loc_oOpt.Buttons(2).FontSize = 8
4308:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
4309:         loc_oOpt.Buttons(2).Themes = .F.
4310: 
4311:         *-- Patrimonialpor Etiq (Opt_Patrim)
4312:         par_oPg.AddObject("lbl_4c_LblPatrim", "Label")
4313:         WITH par_oPg.lbl_4c_LblPatrim
4314:             .Caption = "Patrimonial/Etiqueta:"
4315:             .Top = 101
4316:             .Left = 290
4317:             .Width = 178
4318:             .Height = 17
4319:             .FontName = "Tahoma"
4320:             .FontSize = 8
4321:             .ForeColor = RGB(90,90,90)
4322:             .BackStyle = 0
4323:             .Alignment = 1
4324:             .Visible = .T.
4325:         ENDWITH
4326: 
4327:         par_oPg.AddObject("Opt_Patrim", "OptionGroup")
4328:         loc_oOpt = par_oPg.Opt_Patrim
4329:         WITH loc_oOpt
4330:             .ButtonCount = 2
4331:             .Top = 101
4332:             .Left = 469
4333:             .Width = 149
4334:             .Height = 25
4335:             .BackStyle = 0
4336:             .BorderStyle = 0
4337:             .Value = 1
4338:             .Visible = .T.
4339:         ENDWITH
4340:         loc_oOpt.Buttons(1).Caption = "Sim"
4341:         loc_oOpt.Buttons(1).Left = 5
4342:         loc_oOpt.Buttons(1).Top = 3
4343:         loc_oOpt.Buttons(1).Width = 40
4344:         loc_oOpt.Buttons(1).FontName = "Tahoma"
4345:         loc_oOpt.Buttons(1).FontSize = 8
4346:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
4347:         loc_oOpt.Buttons(1).Themes = .F.
4348:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
4349:         loc_oOpt.Buttons(2).Left = 48
4350:         loc_oOpt.Buttons(2).Top = 3
4351:         loc_oOpt.Buttons(2).Width = 44
4352:         loc_oOpt.Buttons(2).FontName = "Tahoma"
4353:         loc_oOpt.Buttons(2).FontSize = 8
4354:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
4355:         loc_oOpt.Buttons(2).Themes = .F.
4356: 
4357:         *-- Tipo Inventario (OpTipoInvs, 3 btn)
4358:         par_oPg.AddObject("lbl_4c_LblTipoInv", "Label")
4359:         WITH par_oPg.lbl_4c_LblTipoInv
4360:             .Caption = "Tipo Invent" + CHR(225) + "rio:"
4361:             .Top = 125
4362:             .Left = 290
4363:             .Width = 178
4364:             .Height = 17
4365:             .FontName = "Tahoma"
4366:             .FontSize = 8
4367:             .ForeColor = RGB(90,90,90)
4368:             .BackStyle = 0
4369:             .Alignment = 1
4370:             .Visible = .T.
4371:         ENDWITH
4372: 
4373:         par_oPg.AddObject("OpTipoInvs", "OptionGroup")
4374:         loc_oOpt = par_oPg.OpTipoInvs
4375:         WITH loc_oOpt
4376:             .ButtonCount = 3
4377:             .Top = 125
4378:             .Left = 470
4379:             .Width = 371
4380:             .Height = 25
4381:             .BackStyle = 0
4382:             .BorderStyle = 0
4383:             .Value = 1
4384:             .Visible = .T.
4385:         ENDWITH
4386:         loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
4387:         loc_oOpt.Buttons(1).Left = 5
4388:         loc_oOpt.Buttons(1).Top = 3
4389:         loc_oOpt.Buttons(1).Width = 44
4390:         loc_oOpt.Buttons(1).FontName = "Tahoma"
4391:         loc_oOpt.Buttons(1).FontSize = 8
4392:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
4393:         loc_oOpt.Buttons(1).Themes = .F.
4394:         loc_oOpt.Buttons(2).Caption = "Inventario"
4395:         loc_oOpt.Buttons(2).Left = 54
4396:         loc_oOpt.Buttons(2).Top = 3
4397:         loc_oOpt.Buttons(2).Width = 80
4398:         loc_oOpt.Buttons(2).FontName = "Tahoma"
4399:         loc_oOpt.Buttons(2).FontSize = 8
4400:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
4401:         loc_oOpt.Buttons(2).Themes = .F.
4402:         loc_oOpt.Buttons(3).Caption = "Coletor"
4403:         loc_oOpt.Buttons(3).Left = 139
4404:         loc_oOpt.Buttons(3).Top = 3
4405:         loc_oOpt.Buttons(3).Width = 60
4406:         loc_oOpt.Buttons(3).FontName = "Tahoma"
4407:         loc_oOpt.Buttons(3).FontSize = 8
4408:         loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
4409:         loc_oOpt.Buttons(3).Themes = .F.
4410: 
4411:         *-- Diferenca de Peso
4412:         par_oPg.AddObject("lbl_4c_LblDifPeso", "Label")
4413:         WITH par_oPg.lbl_4c_LblDifPeso

*-- Linhas 4602 a 4645:
4602:             .Visible = .T.
4603:         ENDWITH
4604: 
4605:         par_oPg.AddObject("Chk_TrfPeso", "OptionGroup")
4606:         loc_oOpt = par_oPg.Chk_TrfPeso
4607:         WITH loc_oOpt
4608:             .ButtonCount = 5
4609:             .Top = 216
4610:             .Left = 474
4611:             .Width = 186
4612:             .Height = 95
4613:             .BackStyle = 0
4614:             .BorderStyle = 0
4615:             .Value = 1
4616:             .Visible = .T.
4617:         ENDWITH
4618:         loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
4619:         loc_oOpt.Buttons(1).Left = 5
4620:         loc_oOpt.Buttons(1).Top = 3
4621:         loc_oOpt.Buttons(1).Width = 80
4622:         loc_oOpt.Buttons(1).FontName = "Tahoma"
4623:         loc_oOpt.Buttons(1).FontSize = 8
4624:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
4625:         loc_oOpt.Buttons(1).Themes = .F.
4626:         loc_oOpt.Buttons(2).Caption = "Por Kg"
4627:         loc_oOpt.Buttons(2).Left = 5
4628:         loc_oOpt.Buttons(2).Top = 20
4629:         loc_oOpt.Buttons(2).Width = 80
4630:         loc_oOpt.Buttons(2).FontName = "Tahoma"
4631:         loc_oOpt.Buttons(2).FontSize = 8
4632:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
4633:         loc_oOpt.Buttons(2).Themes = .F.
4634:         loc_oOpt.Buttons(3).Caption = "Por Un"
4635:         loc_oOpt.Buttons(3).Left = 5
4636:         loc_oOpt.Buttons(3).Top = 38
4637:         loc_oOpt.Buttons(3).Width = 80
4638:         loc_oOpt.Buttons(3).FontName = "Tahoma"
4639:         loc_oOpt.Buttons(3).FontSize = 8
4640:         loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
4641:         loc_oOpt.Buttons(3).Themes = .F.
4642:         loc_oOpt.Buttons(4).Caption = "Por Kg (%)"
4643:         loc_oOpt.Buttons(4).Left = 5
4644:         loc_oOpt.Buttons(4).Top = 56
4645:         loc_oOpt.Buttons(4).Width = 80

*-- Linhas 4672 a 4715:
4672:             .Visible = .T.
4673:         ENDWITH
4674: 
4675:         par_oPg.AddObject("op_compagru", "OptionGroup")
4676:         loc_oOpt = par_oPg.op_compagru
4677:         WITH loc_oOpt
4678:             .ButtonCount = 3
4679:             .Top = 337
4680:             .Left = 474
4681:             .Width = 186
4682:             .Height = 21
4683:             .BackStyle = 0
4684:             .BorderStyle = 0
4685:             .Value = 1
4686:             .Visible = .T.
4687:         ENDWITH
4688:         loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
4689:         loc_oOpt.Buttons(1).Left = 5
4690:         loc_oOpt.Buttons(1).Top = 3
4691:         loc_oOpt.Buttons(1).Width = 44
4692:         loc_oOpt.Buttons(1).FontName = "Tahoma"
4693:         loc_oOpt.Buttons(1).FontSize = 8
4694:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
4695:         loc_oOpt.Buttons(1).Themes = .F.
4696:         loc_oOpt.Buttons(2).Caption = "Tipo"
4697:         loc_oOpt.Buttons(2).Left = 54
4698:         loc_oOpt.Buttons(2).Top = 3
4699:         loc_oOpt.Buttons(2).Width = 50
4700:         loc_oOpt.Buttons(2).FontName = "Tahoma"
4701:         loc_oOpt.Buttons(2).FontSize = 8
4702:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
4703:         loc_oOpt.Buttons(2).Themes = .F.
4704:         loc_oOpt.Buttons(3).Caption = "Produto"
4705:         loc_oOpt.Buttons(3).Left = 109
4706:         loc_oOpt.Buttons(3).Top = 3
4707:         loc_oOpt.Buttons(3).Width = 60
4708:         loc_oOpt.Buttons(3).FontName = "Tahoma"
4709:         loc_oOpt.Buttons(3).FontSize = 8
4710:         loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
4711:         loc_oOpt.Buttons(3).Themes = .F.
4712: 
4713:         *-- Agrupamento
4714:         par_oPg.AddObject("lbl_4c_LblAgrupa", "Label")
4715:         WITH par_oPg.lbl_4c_LblAgrupa

*-- Linhas 4759 a 4802:
4759:             .Visible = .T.
4760:         ENDWITH
4761: 
4762:         par_oPg.AddObject("Fwoption1", "OptionGroup")
4763:         loc_oOpt = par_oPg.Fwoption1
4764:         WITH loc_oOpt
4765:             .ButtonCount = 3
4766:             .Top = 390
4767:             .Left = 474
4768:             .Width = 164
4769:             .Height = 21
4770:             .BackStyle = 0
4771:             .BorderStyle = 0
4772:             .Value = 1
4773:             .Visible = .T.
4774:         ENDWITH
4775:         loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
4776:         loc_oOpt.Buttons(1).Left = 5
4777:         loc_oOpt.Buttons(1).Top = 3
4778:         loc_oOpt.Buttons(1).Width = 44
4779:         loc_oOpt.Buttons(1).FontName = "Tahoma"
4780:         loc_oOpt.Buttons(1).FontSize = 8
4781:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
4782:         loc_oOpt.Buttons(1).Themes = .F.
4783:         loc_oOpt.Buttons(2).Caption = "Simples"
4784:         loc_oOpt.Buttons(2).Left = 54
4785:         loc_oOpt.Buttons(2).Top = 3
4786:         loc_oOpt.Buttons(2).Width = 60
4787:         loc_oOpt.Buttons(2).FontName = "Tahoma"
4788:         loc_oOpt.Buttons(2).FontSize = 8
4789:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
4790:         loc_oOpt.Buttons(2).Themes = .F.
4791:         loc_oOpt.Buttons(3).Caption = "Completo"
4792:         loc_oOpt.Buttons(3).Left = 119
4793:         loc_oOpt.Buttons(3).Top = 3
4794:         loc_oOpt.Buttons(3).Width = 65
4795:         loc_oOpt.Buttons(3).FontName = "Tahoma"
4796:         loc_oOpt.Buttons(3).FontSize = 8
4797:         loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
4798:         loc_oOpt.Buttons(3).Themes = .F.
4799: 
4800:         *-- Os/Alianca/Fundicao checkboxes (Container1)
4801:         par_oPg.AddObject("cnt_4c_OsAlfun", "Container")
4802:         WITH par_oPg.cnt_4c_OsAlfun

*-- Linhas 4860 a 4903:
4860:     * CriarAbaFaturamento - Controles da aba Faturamento (pgf_4c_1.Page4)
4861:     * 9 containers de impostos
4862:     *--------------------------------------------------------------------------
4863:     PROTECTED PROCEDURE CriarAbaFaturamento(par_oPg)
4864:         LOCAL loc_aCfg, loc_nI, loc_oCnt
4865:         LOCAL loc_cNome, loc_cProp, loc_nTop
4866: 
4867:         *-- Shapes de fundo (borda e separadores de coluna)
4868:         par_oPg.AddObject("shp_4c_Border", "Shape")
4869:         WITH par_oPg.shp_4c_Border
4870:             .Top           = 50
4871:             .Left          = 45
4872:             .Width         = 673
4873:             .Height        = 261
4874:             .BackStyle     = 0
4875:             .SpecialEffect = 1
4876:             .BorderColor   = RGB(90, 90, 90)
4877:             .Visible       = .T.
4878:         ENDWITH
4879: 
4880:         par_oPg.AddObject("shp_4c_ColGrupo", "Shape")
4881:         WITH par_oPg.shp_4c_ColGrupo
4882:             .Top           = 50
4883:             .Left          = 106
4884:             .Width         = 90
4885:             .Height        = 261
4886:             .BackStyle     = 0
4887:             .SpecialEffect = 1
4888:             .BorderColor   = RGB(90, 90, 90)
4889:             .Visible       = .T.
4890:         ENDWITH
4891: 
4892:         par_oPg.AddObject("shp_4c_HdrLine", "Shape")
4893:         WITH par_oPg.shp_4c_HdrLine
4894:             .Top           = 71
4895:             .Left          = 45
4896:             .Width         = 671
4897:             .Height        = 1
4898:             .BackStyle     = 0
4899:             .SpecialEffect = 1
4900:             .BorderColor   = RGB(90, 90, 90)
4901:             .Visible       = .T.
4902:         ENDWITH
4903: 

*-- Linhas 5157 a 5370:
5157:                 .SpecialEffect = 1
5158:                 .Visible = .T.
5159:             ENDWITH
5160:             BINDEVENT(loc_oCnt.getCdGrupos, "GotFocus",  THIS, "GrupoFatGotFocus")
5161:             BINDEVENT(loc_oCnt.getCdGrupos, "KeyPress",  THIS, "GrupoFatKeyPress")
5162:             BINDEVENT(loc_oCnt.getCdGrupos, "DblClick",  THIS, "GrupoFatDblClick")
5163:             BINDEVENT(loc_oCnt.getCdGrupos, "KeyPress", THIS, "GrupoFatLostFocus")
5164:             BINDEVENT(loc_oCnt.getCdContas, "GotFocus",  THIS, "ContaFatGotFocus")
5165:             BINDEVENT(loc_oCnt.getCdContas, "KeyPress",  THIS, "ContaFatKeyPress")
5166:             BINDEVENT(loc_oCnt.getCdContas, "DblClick",  THIS, "ContaFatDblClick")
5167:             BINDEVENT(loc_oCnt.getCdContas, "KeyPress", THIS, "ContaFatLostFocus")
5168:         ENDFOR
5169:     ENDPROC
5170: 
5171:     *--------------------------------------------------------------------------
5172:     * CarregarLista - Popula cursor_4c_Dados e atualiza grd_4c_Lista
5173:     *--------------------------------------------------------------------------
5174:     PROCEDURE CarregarLista()
5175:         LOCAL loc_lResultado
5176:         loc_lResultado = .F.
5177: 
5178:         TRY
5179:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
5180:                 IF USED("cursor_4c_Dados")
5181:                     USE IN cursor_4c_Dados
5182:                 ENDIF
5183:                 SET NULL ON
5184:                 CREATE CURSOR cursor_4c_Dados (codigos C(10), descrs C(40))
5185:                 SET NULL OFF
5186:                 loc_lResultado = .T.
5187:             ELSE
5188:                 IF THIS.this_oBusinessObject.Buscar("")
5189:                     THIS.AtualizarGrid()
5190:                     loc_lResultado = .T.
5191:                 ENDIF
5192:             ENDIF
5193:         CATCH TO loc_oErro
5194:             MsgErro(loc_oErro.Message, "Formccr.CarregarLista")
5195:             loc_lResultado = .F.
5196:         ENDTRY
5197: 
5198:         RETURN loc_lResultado
5199:     ENDPROC
5200: 
5201:     *--------------------------------------------------------------------------
5202:     * AtualizarGrid - Wire RecordSource e colunas do grd_4c_Lista
5203:     *--------------------------------------------------------------------------
5204:     PROTECTED PROCEDURE AtualizarGrid()
5205:         LOCAL loc_oGrid
5206:         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
5207: 
5208:         loc_oGrid.ColumnCount = 2
5209:         loc_oGrid.RecordSource = "cursor_4c_Dados"
5210:         loc_oGrid.ColumnCount  = 2
5211: 
5212:         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
5213:         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
5214: 
5215:         loc_oGrid.Column1.Width = 120
5216:         loc_oGrid.Column2.Width = 400
5217: 
5218:         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
5219:         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
5220:     ENDPROC
5221: 
5222:     *--------------------------------------------------------------------------
5223:     * AlternarPagina - Navega entre Page1 (Lista=1) e Page2 (Dados=2)
5224:     *--------------------------------------------------------------------------
5225:     PROCEDURE AlternarPagina(par_nPagina)
5226:         LOCAL loc_lResultado
5227:         loc_lResultado = .F.
5228: 
5229:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
5230:             RETURN .F.
5231:         ENDIF
5232: 
5233:         TRY
5234:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
5235: 
5236:             IF par_nPagina = 1
5237:                 THIS.this_cModoAtual = "LISTA"
5238:                 THIS.CarregarLista()
5239:             ENDIF
5240: 
5241:             loc_lResultado = .T.
5242:         CATCH TO loc_oErro
5243:             MsgErro(loc_oErro.Message, "Formccr.AlternarPagina")
5244:         ENDTRY
5245: 
5246:         RETURN loc_lResultado
5247:     ENDPROC
5248: 
5249:     *--------------------------------------------------------------------------
5250:     * AjustarBotoesPorModo - Habilita/desabilita Confirmar conforme modo
5251:     *--------------------------------------------------------------------------
5252:     PROCEDURE AjustarBotoesPorModo()
5253:         LOCAL loc_oPg2, loc_lEdicao
5254:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
5255:         loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
5256: 
5257:         IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
5258:             IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
5259:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEdicao
5260:             ENDIF
5261:         ENDIF
5262:     ENDPROC
5263: 
5264:     *--------------------------------------------------------------------------
5265:     * LimparDados - Limpa valores dos campos da Page2
5266:     *--------------------------------------------------------------------------
5267:     PROTECTED PROCEDURE LimparDados()
5268:         LOCAL loc_oPg2
5269:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
5270: 
5271:         TRY
5272:             loc_oPg2.txt_4c_Codigo.Value = ""
5273:             loc_oPg2.txt_4c_Digito.Value = ""
5274:             loc_oPg2.txt_4c_Descr.Value  = ""
5275:             loc_oPg2.txt_4c_Interno.Value = ""
5276:             loc_oPg2.txt_4c_Classes.Value = ""
5277:             loc_oPg2.txt_4c_DClasses.Value = ""
5278:             loc_oPg2.obj_4c_Opt_TpCods.Value = 1
5279:             loc_oPg2.obj_4c_Opt_TpEmps.Value = 1
5280:             loc_oPg2.obj_4c_Opt_TpCads.Value = 1
5281:             THIS.LimparAbaGeral(loc_oPg2)
5282:             THIS.LimparAbaCadastro(loc_oPg2)
5283:             THIS.LimparAbaEstoque(loc_oPg2)
5284:             THIS.LimparAbaFaturamento(loc_oPg2)
5285:         CATCH TO loc_oErro
5286:             MsgErro(loc_oErro.Message, "LimparDados")
5287:         ENDTRY
5288:     ENDPROC
5289: 
5290:     *--------------------------------------------------------------------------
5291:     * LimparAbaGeral
5292:     *--------------------------------------------------------------------------
5293:     PROTECTED PROCEDURE LimparAbaGeral(par_oPg2)
5294:         LOCAL loc_oPgAba
5295:         loc_oPgAba = par_oPg2.pgf_4c_1.Page1
5296: 
5297:         TRY
5298:             loc_oPgAba.obj_4c_Opt_Comple.Value    = 1
5299:             loc_oPgAba.obj_4c_Opt_Pessoais.Value  = 1
5300:             loc_oPgAba.obj_4c_Opt_RefBancs.Value  = 1
5301:             loc_oPgAba.obj_4c_Opt_FollowUp.Value  = 1
5302:             loc_oPgAba.obj_4c_Opt_Fiscais.Value   = 1
5303:             loc_oPgAba.obj_4c_Opt_Empresa.Value   = 1
5304:             loc_oPgAba.obj_4c_Opt_Contabs.Value   = 1
5305:             loc_oPgAba.obj_4c_Opt_Caracteris.Value = 1
5306:             loc_oPgAba.obj_4c_Fwoption1.Value     = 1
5307:             loc_oPgAba.obj_4c_Fwoption2.Value     = 1
5308:             loc_oPgAba.obj_4c_Opt_DadosCom.Value  = 1
5309:             loc_oPgAba.obj_4c_Opt_Respos.Value    = 1
5310:             loc_oPgAba.obj_4c_Opt_LimCre.Value    = 1
5311:             loc_oPgAba.obj_4c_Opt_Comi.Value      = 1
5312:             loc_oPgAba.obj_4c_Opt_Cargo.Value     = 1
5313:             loc_oPgAba.obj_4c_Opt_ChkLimCr.Value  = 1
5314:             loc_oPgAba.obj_4c_OptPreCad.Value     = 1
5315:             loc_oPgAba.obj_4c_Opt_Coletor.Value   = 1
5316:             loc_oPgAba.txt_4c_Vrlimc.Value = 0
5317:             loc_oPgAba.txt_4c__molimc.Value = ""
5318:             loc_oPgAba.txt_4c__cd_moeda.Value = ""
5319:             loc_oPgAba.txt_4c__ds_moeda.Value = ""
5320:             loc_oPgAba.txt_4c_Grupo.Value = ""
5321:             loc_oPgAba.obj_4c_GetRodRelCC.Value = ""
5322:         CATCH TO loc_oErro
5323:             MsgErro(loc_oErro.Message, "LimparAbaGeral")
5324:         ENDTRY
5325:     ENDPROC
5326: 
5327:     *--------------------------------------------------------------------------
5328:     * LimparAbaCadastro
5329:     *--------------------------------------------------------------------------
5330:     PROTECTED PROCEDURE LimparAbaCadastro(par_oPg2)
5331:         LOCAL loc_oPgAba
5332:         loc_oPgAba = par_oPg2.pgf_4c_1.Page2
5333: 
5334:         TRY
5335:             loc_oPgAba.Opt_CPFObrig.Value   = 1
5336:             loc_oPgAba.fwoption2.Value       = 1
5337:             loc_oPgAba.optCalcIMeds.Value    = 1
5338:             loc_oPgAba.getObrMails.Value     = 1
5339:             loc_oPgAba.getObrNome.Value      = 1
5340:             loc_oPgAba.Fwoption15.Value      = 1
5341:             loc_oPgAba.getObrSit.Value       = 1
5342:             loc_oPgAba.getObrTlm.Value       = 1
5343:             loc_oPgAba.getObrCla.Value       = 1
5344:             loc_oPgAba.getObrSeg.Value       = 1
5345:             loc_oPgAba.Fwoption6.Value       = 1
5346:             loc_oPgAba.Fwoption7.Value       = 1
5347:             loc_oPgAba.Fwoption12.Value      = 1
5348:             loc_oPgAba.Fwoption13.Value      = 1
5349:             loc_oPgAba.Fwoption14.Value      = 1
5350:             loc_oPgAba.Fwoption8.Value       = 1
5351:             loc_oPgAba.Fwoption9.Value       = 1
5352:             loc_oPgAba.Fwoption11.Value      = 1
5353:             loc_oPgAba.Fwoption10.Value      = 1
5354:             loc_oPgAba.Opt_CEPObrig.Value    = 1
5355:             loc_oPgAba.getObrIbge.Value      = 1
5356:             loc_oPgAba.Fwoption4.Value       = 1
5357:             loc_oPgAba.Fwoption5.Value       = 1
5358:             loc_oPgAba.Fwoption16.Value      = 1
5359:             loc_oPgAba.Opt_MFotos.Value      = 1
5360:             loc_oPgAba.fwoption1.Value       = 1
5361:             loc_oPgAba.optCpffixo.Value      = 1
5362:             loc_oPgAba.getSituas.Value       = ""
5363:             loc_oPgAba.optCarac.Value        = 1
5364:             loc_oPgAba.optAceJob.Value       = 1
5365:             loc_oPgAba.OptAlertaCad.Value    = 1
5366:             loc_oPgAba.Getcontint.Value      = ""
5367:             loc_oPgAba.Opt_Integ.Value       = 1
5368:             loc_oPgAba.Fwoption3.Value       = 1
5369:             loc_oPgAba.optVincPgRcs.Value    = 1
5370:             loc_oPgAba.OptTitBaixado.Value   = 1

*-- Linhas 5377 a 5530:
5377:     *--------------------------------------------------------------------------
5378:     * LimparAbaEstoque
5379:     *--------------------------------------------------------------------------
5380:     PROTECTED PROCEDURE LimparAbaEstoque(par_oPg2)
5381:         LOCAL loc_oPgAba
5382:         loc_oPgAba = par_oPg2.pgf_4c_1.Page3
5383: 
5384:         TRY
5385:             loc_oPgAba.Opt_LimEsto.Value   = 1
5386:             loc_oPgAba.Opt_VerEst.Value    = 1
5387:             loc_oPgAba.Opt_EstPAcab.Value  = 1
5388:             loc_oPgAba.opt_ChkLimest.Value = 1
5389:             loc_oPgAba.Opt_CCusto.Value    = 1
5390:             loc_oPgAba.Opt_GBals.Value     = 1
5391:             loc_oPgAba.Opt_UnifBal.Value   = 1
5392:             loc_oPgAba.Opt_FalPers.Value   = 1
5393:             loc_oPgAba.Opt_BlqDivOp.Value  = 1
5394:             loc_oPgAba.Opt_Saldo.Value     = 1
5395:             loc_oPgAba.Opt_Relevante.Value = 1
5396:             loc_oPgAba.Opt_BlqConGV.Value  = 1
5397:             loc_oPgAba.Opt_Patrim.Value    = 1
5398:             loc_oPgAba.OpTipoInvs.Value    = 1
5399:             loc_oPgAba.Chk_TrfPeso.Value   = 1
5400:             loc_oPgAba.op_compagru.Value   = 1
5401:             loc_oPgAba.Fwoption1.Value     = 1
5402:             loc_oPgAba.Get_OsPend.Value    = 1
5403:             loc_oPgAba.ObjDupTit.Value     = 1
5404:             loc_oPgAba.Get_grupo.Value     = ""
5405:             loc_oPgAba.Get_DifPeso.Value   = 0
5406:             loc_oPgAba.Get_Sinal.Value     = 1
5407:             loc_oPgAba.Get_tfalhas.Value   = ""
5408:             loc_oPgAba.Get_Agrupa.Value    = ""
5409:             loc_oPgAba.get_ddr.Value       = 0
5410:             loc_oPgAba.get_ddf.Value       = 0
5411:             loc_oPgAba.op_invisivel.Value  = 0
5412:             loc_oPgAba.cnt_4c_OsAlfun.chk_Os.Value       = 0
5413:             loc_oPgAba.cnt_4c_OsAlfun.chk_Alianca.Value  = 0
5414:             loc_oPgAba.cnt_4c_OsAlfun.chk_Fundicao.Value = 0
5415:         CATCH TO loc_oErro
5416:             MsgErro(loc_oErro.Message, "LimparAbaEstoque")
5417:         ENDTRY
5418:     ENDPROC
5419: 
5420:     *--------------------------------------------------------------------------
5421:     * LimparAbaFaturamento
5422:     *--------------------------------------------------------------------------
5423:     PROTECTED PROCEDURE LimparAbaFaturamento(par_oPg2)
5424:         LOCAL loc_oPgAba, loc_aCnt, loc_nI, loc_oCnt, loc_nIdx
5425:         loc_oPgAba = par_oPg2.pgf_4c_1.Page4
5426: 
5427:         DIMENSION loc_aCnt(9)
5428:         loc_aCnt(1) = "cntIC"
5429:         loc_aCnt(2) = "cntIP"
5430:         loc_aCnt(3) = "cntII"
5431:         loc_aCnt(4) = "cntIS"
5432:         loc_aCnt(5) = "cntIR"
5433:         loc_aCnt(6) = "cntIN"
5434:         loc_aCnt(7) = "cntPI"
5435:         loc_aCnt(8) = "cntCS"
5436:         loc_aCnt(9) = "cntCO"
5437: 
5438:         TRY
5439:             FOR loc_nI = 1 TO 9
5440:                 IF PEMSTATUS(loc_oPgAba, loc_aCnt(loc_nI), 5)
5441:                     loc_nIdx = THIS.ObterIndiceControle(loc_oPgAba, loc_aCnt(loc_nI))
5442:                     loc_oCnt = loc_oPgAba.Controls(loc_nIdx)
5443:                     IF VARTYPE(loc_oCnt) = "O"
5444:                         loc_oCnt.getCdGrupos.Value = ""
5445:                         loc_oCnt.getCdContas.Value = ""
5446:                         loc_oCnt.getDsContas.Value = ""
5447:                         loc_oCnt.getPctAliqs.Value = 0
5448:                         loc_oCnt.getReceitas.Value = ""
5449:                     ENDIF
5450:                 ENDIF
5451:             ENDFOR
5452:         CATCH TO loc_oErro
5453:             MsgErro(loc_oErro.Message, "LimparAbaFaturamento")
5454:         ENDTRY
5455:     ENDPROC
5456: 
5457:     *--------------------------------------------------------------------------
5458:     * HabilitarCampos - Habilita/desabilita campos conforme modo
5459:     *--------------------------------------------------------------------------
5460:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
5461:         LOCAL loc_oPg2, loc_lEdicao
5462:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
5463:         loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
5464: 
5465:         TRY
5466:             *-- Codigo: editavel somente em INCLUIR (PK nao muda em ALTERAR)
5467:             IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
5468:                 loc_oPg2.txt_4c_Codigo.ReadOnly = !(THIS.this_cModoAtual = "INCLUIR")
5469:             ENDIF
5470:             IF PEMSTATUS(loc_oPg2, "txt_4c_Digito", 5)
5471:                 loc_oPg2.txt_4c_Digito.ReadOnly = !loc_lEdicao
5472:             ENDIF
5473:             IF PEMSTATUS(loc_oPg2, "txt_4c_Descr", 5)
5474:                 loc_oPg2.txt_4c_Descr.ReadOnly = !loc_lEdicao
5475:             ENDIF
5476:             IF PEMSTATUS(loc_oPg2, "txt_4c_Interno", 5)
5477:                 loc_oPg2.txt_4c_Interno.ReadOnly = !loc_lEdicao
5478:             ENDIF
5479:             IF PEMSTATUS(loc_oPg2, "txt_4c_Classes", 5)
5480:                 loc_oPg2.txt_4c_Classes.ReadOnly = !loc_lEdicao
5481:             ENDIF
5482:         CATCH TO loc_oErro
5483:             MsgErro(loc_oErro.Message, "HabilitarCampos")
5484:         ENDTRY
5485:     ENDPROC
5486: 
5487:     *--------------------------------------------------------------------------
5488:     * BOParaForm - Transfere BO -> controles da Page2
5489:     *--------------------------------------------------------------------------
5490:     PROCEDURE BOParaForm()
5491:         LOCAL loc_oPg2, loc_oBO, loc_oPgAba, loc_cCfg, loc_nVal
5492:         LOCAL loc_aCnt, loc_nI, loc_oCnt, loc_cProp, loc_cFisStr
5493:         LOCAL loc_cConta, loc_nRet
5494:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
5495:         loc_oBO  = THIS.this_oBusinessObject
5496: 
5497:         TRY
5498:             *-- Identificacao basica
5499:             loc_oPg2.txt_4c_Codigo.Value  = ALLTRIM(loc_oBO.this_cCodigos)
5500:             loc_oPg2.txt_4c_Digito.Value  = ALLTRIM(loc_oBO.this_cDgcods)
5501:             loc_oPg2.txt_4c_Descr.Value   = ALLTRIM(loc_oBO.this_cDescrs)
5502:             loc_oPg2.txt_4c_Interno.Value = ALLTRIM(loc_oBO.this_cInternos)
5503:             loc_oPg2.txt_4c_Classes.Value = ALLTRIM(loc_oBO.this_cClasses)
5504:             loc_oPg2.txt_4c_DClasses.Value = ALLTRIM(loc_oBO.this_cDClasses)
5505: 
5506:             *-- Tipos (1-based index = valor numerico + 1)
5507:             loc_oPg2.obj_4c_Opt_TpCods.Value = IIF(loc_oBO.this_nTpcods = 0, 1, loc_oBO.this_nTpcods)
5508:             loc_oPg2.obj_4c_Opt_TpEmps.Value = IIF(loc_oBO.this_nTpemps = 0, 1, loc_oBO.this_nTpemps)
5509:             loc_oPg2.obj_4c_Opt_TpCads.Value = IIF(loc_oBO.this_nTpcads = 0, 1, loc_oBO.this_nTpcads)
5510: 
5511:             *-- Aba Geral
5512:             loc_oPgAba = loc_oPg2.pgf_4c_1.Page1
5513:             loc_oPgAba.obj_4c_Opt_Comple.Value    = IIF(loc_oBO.this_nComplems = 0, 1, loc_oBO.this_nComplems)
5514:             loc_oPgAba.obj_4c_Opt_Pessoais.Value  = IIF(loc_oBO.this_nPessoais = 0, 1, loc_oBO.this_nPessoais)
5515:             loc_oPgAba.obj_4c_Opt_RefBancs.Value  = IIF(loc_oBO.this_nRefbancs = 0, 1, loc_oBO.this_nRefbancs)
5516:             loc_oPgAba.obj_4c_Opt_FollowUp.Value  = IIF(loc_oBO.this_nFollowups = 0, 1, loc_oBO.this_nFollowups)
5517:             loc_oPgAba.obj_4c_Opt_Fiscais.Value   = IIF(loc_oBO.this_nFiscais = 0, 1, loc_oBO.this_nFiscais)
5518:             loc_oPgAba.obj_4c_Opt_Empresa.Value   = IIF(loc_oBO.this_nEmpresas = 0, 1, loc_oBO.this_nEmpresas)
5519:             loc_oPgAba.obj_4c_Opt_Contabs.Value   = IIF(loc_oBO.this_nContabs = 0, 1, loc_oBO.this_nContabs)
5520:             loc_oPgAba.obj_4c_Opt_Caracteris.Value = IIF(loc_oBO.this_nCaracteris = 0, 1, loc_oBO.this_nCaracteris)
5521:             loc_oPgAba.obj_4c_Fwoption1.Value     = IIF(loc_oBO.this_nInfcads = 0, 1, loc_oBO.this_nInfcads)
5522:             loc_oPgAba.obj_4c_Fwoption2.Value     = IIF(loc_oBO.this_nDadcoms = 0, 1, loc_oBO.this_nDadcoms)
5523:             loc_oPgAba.obj_4c_Opt_DadosCom.Value  = IIF(loc_oBO.this_nDadcoms = 0, 1, loc_oBO.this_nDadcoms)
5524:             loc_oPgAba.obj_4c_Opt_Respos.Value    = IIF(loc_oBO.this_nRespos = 0, 1, loc_oBO.this_nRespos)
5525:             loc_oPgAba.obj_4c_Opt_LimCre.Value    = IIF(loc_oBO.this_nLimcres = 0, 1, loc_oBO.this_nLimcres)
5526:             loc_oPgAba.obj_4c_Opt_Comi.Value      = IIF(loc_oBO.this_nComis = 0, 1, loc_oBO.this_nComis)
5527:             loc_oPgAba.obj_4c_Opt_Cargo.Value     = IIF(loc_oBO.this_nCargos = 0, 1, loc_oBO.this_nCargos)
5528:             loc_oPgAba.obj_4c_Opt_ChkLimCr.Value  = IIF(loc_oBO.this_nChklimcrds = 0, 1, loc_oBO.this_nChklimcrds)
5529:             loc_oPgAba.obj_4c_OptPreCad.Value     = IIF(loc_oBO.this_nPrecad = 0, 1, loc_oBO.this_nPrecad)
5530:             loc_oPgAba.obj_4c_Opt_Coletor.Value   = IIF(loc_oBO.this_nColetors = 0, 1, loc_oBO.this_nColetors + 1)

*-- Linhas 5710 a 5766:
5710:     *--------------------------------------------------------------------------
5711:     * ObterIndiceControle - retorna indice de um controle pelo nome
5712:     *--------------------------------------------------------------------------
5713:     PROTECTED PROCEDURE ObterIndiceControle(par_oContainer, par_cNome)
5714:         LOCAL loc_nI
5715:         FOR loc_nI = 1 TO par_oContainer.ControlCount
5716:             IF UPPER(par_oContainer.Controls(loc_nI).Name) = UPPER(par_cNome)
5717:                 RETURN loc_nI
5718:             ENDIF
5719:         ENDFOR
5720:         RETURN 1
5721:     ENDPROC
5722: 
5723:     *--------------------------------------------------------------------------
5724:     * FormParaBO - Transfere controles da Page2 -> BO
5725:     *--------------------------------------------------------------------------
5726:     PROCEDURE FormParaBO()
5727:         LOCAL loc_oPg2, loc_oBO, loc_oPgAba, loc_cCfg
5728:         LOCAL loc_aCnt, loc_nI, loc_oCnt, loc_cFisStr, loc_cNomeProp
5729:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
5730:         loc_oBO  = THIS.this_oBusinessObject
5731: 
5732:         TRY
5733:             *-- Identificacao
5734:             loc_oBO.this_cCodigos  = ALLTRIM(NVL(loc_oPg2.txt_4c_Codigo.Value, ""))
5735:             loc_oBO.this_cDgcods   = ALLTRIM(NVL(loc_oPg2.txt_4c_Digito.Value, ""))
5736:             loc_oBO.this_cDescrs   = ALLTRIM(NVL(loc_oPg2.txt_4c_Descr.Value, ""))
5737:             loc_oBO.this_cInternos = ALLTRIM(NVL(loc_oPg2.txt_4c_Interno.Value, ""))
5738:             loc_oBO.this_cClasses  = ALLTRIM(NVL(loc_oPg2.txt_4c_Classes.Value, ""))
5739:             loc_oBO.this_nTpcods   = NVL(loc_oPg2.obj_4c_Opt_TpCods.Value, 1)
5740:             loc_oBO.this_nTpemps   = NVL(loc_oPg2.obj_4c_Opt_TpEmps.Value, 1)
5741:             loc_oBO.this_nTpcads   = NVL(loc_oPg2.obj_4c_Opt_TpCads.Value, 1)
5742: 
5743:             *-- Aba Geral
5744:             loc_oPgAba = loc_oPg2.pgf_4c_1.Page1
5745:             loc_oBO.this_nComplems    = NVL(loc_oPgAba.obj_4c_Opt_Comple.Value, 1)
5746:             loc_oBO.this_nPessoais    = NVL(loc_oPgAba.obj_4c_Opt_Pessoais.Value, 1)
5747:             loc_oBO.this_nRefbancs    = NVL(loc_oPgAba.obj_4c_Opt_RefBancs.Value, 1)
5748:             loc_oBO.this_nFollowups   = NVL(loc_oPgAba.obj_4c_Opt_FollowUp.Value, 1)
5749:             loc_oBO.this_nFiscais     = NVL(loc_oPgAba.obj_4c_Opt_Fiscais.Value, 1)
5750:             loc_oBO.this_nEmpresas    = NVL(loc_oPgAba.obj_4c_Opt_Empresa.Value, 1)
5751:             loc_oBO.this_nContabs     = NVL(loc_oPgAba.obj_4c_Opt_Contabs.Value, 1)
5752:             loc_oBO.this_nCaracteris  = NVL(loc_oPgAba.obj_4c_Opt_Caracteris.Value, 1)
5753:             loc_oBO.this_nInfcads     = NVL(loc_oPgAba.obj_4c_Fwoption1.Value, 1)
5754:             loc_oBO.this_nDadcoms     = NVL(loc_oPgAba.obj_4c_Opt_DadosCom.Value, 1)
5755:             loc_oBO.this_nRespos      = NVL(loc_oPgAba.obj_4c_Opt_Respos.Value, 1)
5756:             loc_oBO.this_nLimcres     = NVL(loc_oPgAba.obj_4c_Opt_LimCre.Value, 1)
5757:             loc_oBO.this_nComis       = NVL(loc_oPgAba.obj_4c_Opt_Comi.Value, 1)
5758:             loc_oBO.this_nCargos      = NVL(loc_oPgAba.obj_4c_Opt_Cargo.Value, 1)
5759:             loc_oBO.this_nChklimcrds  = NVL(loc_oPgAba.obj_4c_Opt_ChkLimCr.Value, 1)
5760:             loc_oBO.this_nPrecad      = NVL(loc_oPgAba.obj_4c_OptPreCad.Value, 1)
5761:             loc_oBO.this_nColetors    = NVL(loc_oPgAba.obj_4c_Opt_Coletor.Value, 1) - 1
5762:             loc_oBO.this_nVrlimcre    = NVL(loc_oPgAba.txt_4c_Vrlimc.Value, 0)
5763:             loc_oBO.this_cMolimcre    = ALLTRIM(NVL(loc_oPgAba.txt_4c__molimc.Value, ""))
5764:             loc_oBO.this_cCommoedas   = ALLTRIM(NVL(loc_oPgAba.txt_4c__cd_moeda.Value, ""))
5765:             loc_oBO.this_cGrupolms    = ALLTRIM(NVL(loc_oPgAba.txt_4c_Grupo.Value, ""))
5766:             loc_oBO.this_cRodrelcc    = NVL(loc_oPgAba.obj_4c_GetRodRelCC.Value, "")

*-- Linhas 5884 a 6747:
5884:     *--------------------------------------------------------------------------
5885:     * BtnEncerrarClick
5886:     *--------------------------------------------------------------------------
5887:     PROCEDURE BtnEncerrarClick()
5888:         THIS.Release()
5889:     ENDPROC
5890: 
5891:     *--------------------------------------------------------------------------
5892:     * BtnConfirmarClick
5893:     *--------------------------------------------------------------------------
5894:     PROCEDURE BtnConfirmarClick()
5895:         THIS.BtnSalvarClick()
5896:     ENDPROC
5897: 
5898:     *--------------------------------------------------------------------------
5899:     * BtnSalvarClick - Valida, transfere Form->BO e persiste via BO.Salvar()
5900:     *--------------------------------------------------------------------------
5901:     PROCEDURE BtnSalvarClick()
5902:         LOCAL loc_lSucesso, loc_oPg2
5903:         loc_lSucesso = .F.
5904:         loc_oPg2     = THIS.pgf_4c_Paginas.Page2
5905: 
5906:         IF EMPTY(ALLTRIM(NVL(loc_oPg2.txt_4c_Codigo.Value, "")))
5907:             MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o informado.", "Salvar")
5908:             RETURN
5909:         ENDIF
5910: 
5911:         IF EMPTY(ALLTRIM(NVL(loc_oPg2.txt_4c_Descr.Value, "")))
5912:             MsgAviso("Descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada.", "Salvar")
5913:             RETURN
5914:         ENDIF
5915: 
5916:         TRY
5917:             THIS.FormParaBO()
5918:             loc_lSucesso = THIS.this_oBusinessObject.Salvar()
5919: 
5920:             IF loc_lSucesso
5921:                 MsgInfo("Registro salvo com sucesso!", "Salvar")
5922:                 THIS.AlternarPagina(1)
5923:             ENDIF
5924:         CATCH TO loc_oErro
5925:             MsgErro(loc_oErro.Message, "BtnSalvarClick")
5926:         ENDTRY
5927:     ENDPROC
5928: 
5929:     *--------------------------------------------------------------------------
5930:     * BtnCancelarClick
5931:     *--------------------------------------------------------------------------
5932:     PROCEDURE BtnCancelarClick()
5933:         THIS.AlternarPagina(1)
5934:     ENDPROC
5935: 
5936:     *--------------------------------------------------------------------------
5937:     * BtnIncluirClick
5938:     *--------------------------------------------------------------------------
5939:     PROCEDURE BtnIncluirClick()
5940:         THIS.this_oBusinessObject.NovoRegistro()
5941:         THIS.this_cModoAtual = "INCLUIR"
5942:         THIS.LimparDados()
5943:         THIS.HabilitarCampos(.T.)
5944:         THIS.AjustarBotoesPorModo()
5945:         THIS.AlternarPagina(2)
5946:     ENDPROC
5947: 
5948:     *--------------------------------------------------------------------------
5949:     * BtnVisualizarClick
5950:     *--------------------------------------------------------------------------
5951:     PROCEDURE BtnVisualizarClick()
5952:         LOCAL loc_cCodigos
5953:         loc_cCodigos = ""
5954: 
5955:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
5956:             SELECT cursor_4c_Dados
5957:             loc_cCodigos = ALLTRIM(NVL(cursor_4c_Dados.codigos, ""))
5958:         ENDIF
5959: 
5960:         IF EMPTY(loc_cCodigos)
5961:             MsgAviso("Selecione um registro na lista.", "Visualizar")
5962:             RETURN
5963:         ENDIF
5964: 
5965:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigos)
5966:             THIS.this_cModoAtual = "VISUALIZAR"
5967:             THIS.BOParaForm()
5968:             THIS.HabilitarCampos(.F.)
5969:             THIS.AjustarBotoesPorModo()
5970:             THIS.AlternarPagina(2)
5971:         ENDIF
5972:     ENDPROC
5973: 
5974:     *--------------------------------------------------------------------------
5975:     * BtnAlterarClick
5976:     *--------------------------------------------------------------------------
5977:     PROCEDURE BtnAlterarClick()
5978:         LOCAL loc_cCodigos
5979:         loc_cCodigos = ""
5980: 
5981:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
5982:             SELECT cursor_4c_Dados
5983:             loc_cCodigos = ALLTRIM(NVL(cursor_4c_Dados.codigos, ""))
5984:         ENDIF
5985: 
5986:         IF EMPTY(loc_cCodigos)
5987:             MsgAviso("Selecione um registro na lista.", "Alterar")
5988:             RETURN
5989:         ENDIF
5990: 
5991:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigos)
5992:             THIS.this_oBusinessObject.EditarRegistro()
5993:             THIS.this_cModoAtual = "ALTERAR"
5994:             THIS.BOParaForm()
5995:             THIS.HabilitarCampos(.T.)
5996:             THIS.AjustarBotoesPorModo()
5997:             THIS.AlternarPagina(2)
5998:         ENDIF
5999:     ENDPROC
6000: 
6001:     *--------------------------------------------------------------------------
6002:     * BtnExcluirClick
6003:     *--------------------------------------------------------------------------
6004:     PROCEDURE BtnExcluirClick()
6005:         LOCAL loc_cCodigos, loc_lConfirma
6006:         loc_cCodigos  = ""
6007:         loc_lConfirma = .F.
6008: 
6009:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
6010:             SELECT cursor_4c_Dados
6011:             loc_cCodigos = ALLTRIM(NVL(cursor_4c_Dados.codigos, ""))
6012:         ENDIF
6013: 
6014:         IF EMPTY(loc_cCodigos)
6015:             MsgAviso("Selecione um registro na lista.", "Excluir")
6016:             RETURN
6017:         ENDIF
6018: 
6019:         loc_lConfirma = MsgConfirma("Deseja excluir o grupo de contas correntes selecionado?", "Excluir")
6020:         IF !loc_lConfirma
6021:             RETURN
6022:         ENDIF
6023: 
6024:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigos)
6025:             IF THIS.this_oBusinessObject.Excluir()
6026:                 MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Excluir")
6027:                 THIS.CarregarLista()
6028:             ENDIF
6029:         ENDIF
6030:     ENDPROC
6031: 
6032:     *--------------------------------------------------------------------------
6033:     * BtnBuscarClick
6034:     *--------------------------------------------------------------------------
6035:     PROCEDURE BtnBuscarClick()
6036:         LOCAL loc_cFiltro
6037:         loc_cFiltro = INPUTBOX("Informe c" + CHR(243) + "digo ou descri" + CHR(231) + CHR(227) + ;
6038:             "o (vazio = todos):", "Buscar")
6039: 
6040:         IF VARTYPE(loc_cFiltro) = "C"
6041:             IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
6042:                 THIS.AtualizarGrid()
6043:             ENDIF
6044:         ENDIF
6045:     ENDPROC
6046: 
6047:     *--------------------------------------------------------------------------
6048:     * ClassesKeyPress - Abre picker de Classe (SigCdCss) ao pressionar F4
6049:     *--------------------------------------------------------------------------
6050:     PROCEDURE ClassesKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6051:         IF par_nKeyCode = 115
6052:             THIS.AbrirBuscaClasses()
6053:         ENDIF
6054:     ENDPROC
6055: 
6056:     *--------------------------------------------------------------------------
6057:     * ClassesDblClick
6058:     *--------------------------------------------------------------------------
6059:     PROCEDURE ClassesDblClick()
6060:         THIS.AbrirBuscaClasses()
6061:     ENDPROC
6062: 
6063:     *--------------------------------------------------------------------------
6064:     * ClassesLostFocus - Valida classe ao sair do campo
6065:     *--------------------------------------------------------------------------
6066:     PROCEDURE ClassesLostFocus(par_nKeyCode, par_nShiftAltCtrl)
6067:         LOCAL loc_oPg2, loc_cCls
6068:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
6069:         loc_cCls = ALLTRIM(NVL(loc_oPg2.txt_4c_Classes.Value, ""))
6070: 
6071:         IF EMPTY(loc_cCls)
6072:             loc_oPg2.txt_4c_DClasses.Value = ""
6073:             RETURN
6074:         ENDIF
6075: 
6076:         TRY
6077:             IF SQLEXEC(gnConnHandle, "SELECT Descrs FROM SigCdCss WHERE RTRIM(Classes)=" + ;
6078:                 EscaparSQL(loc_cCls), "cursor_4c_Css") >= 0
6079:                 IF USED("cursor_4c_Css") AND RECCOUNT("cursor_4c_Css") > 0
6080:                     SELECT cursor_4c_Css
6081:                     loc_oPg2.txt_4c_DClasses.Value = ALLTRIM(NVL(Descrs, ""))
6082:                 ELSE
6083:                     THIS.AbrirBuscaClasses()
6084:                 ENDIF
6085:                 IF USED("cursor_4c_Css")
6086:                     USE IN cursor_4c_Css
6087:                 ENDIF
6088:             ENDIF
6089:         CATCH TO loc_oErro
6090:             MsgErro(loc_oErro.Message, "ClassesLostFocus")
6091:             IF USED("cursor_4c_Css")
6092:                 USE IN cursor_4c_Css
6093:             ENDIF
6094:         ENDTRY
6095:     ENDPROC
6096: 
6097:     *--------------------------------------------------------------------------
6098:     * AbrirBuscaClasses - FormBuscaAuxiliar para SigCdCss
6099:     *--------------------------------------------------------------------------
6100:     PROCEDURE AbrirBuscaClasses()
6101:         LOCAL loc_oBusca, loc_oPg2
6102:         loc_oBusca = .NULL.
6103:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
6104: 
6105:         TRY
6106:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
6107:                 "SigCdCss", "cursor_4c_BuscaClasse", "Classes", ;
6108:                 ALLTRIM(NVL(loc_oPg2.txt_4c_Classes.Value, "")), ;
6109:                 "Selecionar Classe")
6110: 
6111:             IF VARTYPE(loc_oBusca) = "O"
6112:                 IF !loc_oBusca.this_lAchouRegistro OR !loc_oBusca.this_lSelecionou
6113:                     loc_oBusca.mAddColuna("Classes", "", "Classe")
6114:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
6115:                     loc_oBusca.Show()
6116:                 ENDIF
6117: 
6118:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClasse")
6119:                     SELECT cursor_4c_BuscaClasse
6120:                     loc_oPg2.txt_4c_Classes.Value  = ALLTRIM(NVL(Classes, ""))
6121:                     loc_oPg2.txt_4c_DClasses.Value = ALLTRIM(NVL(Descrs, ""))
6122:                 ELSE
6123:                     IF !loc_oBusca.this_lSelecionou
6124:                         loc_oPg2.txt_4c_Classes.Value  = ""
6125:                         loc_oPg2.txt_4c_DClasses.Value = ""
6126:                     ENDIF
6127:                 ENDIF
6128:                 loc_oBusca.Release()
6129:             ENDIF
6130: 
6131:             IF USED("cursor_4c_BuscaClasse")
6132:                 USE IN cursor_4c_BuscaClasse
6133:             ENDIF
6134:         CATCH TO loc_oErro
6135:             MsgErro(loc_oErro.Message, "AbrirBuscaClasses")
6136:             IF USED("cursor_4c_BuscaClasse")
6137:                 USE IN cursor_4c_BuscaClasse
6138:             ENDIF
6139:         ENDTRY
6140:     ENDPROC
6141: 
6142:     *--------------------------------------------------------------------------
6143:     * MoedaComissaoKeyPress - Abre picker de Moeda Comissao ao F4
6144:     *--------------------------------------------------------------------------
6145:     PROCEDURE MoedaComissaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6146:         IF par_nKeyCode = 115
6147:             THIS.AbrirBuscaMoedaComissao()
6148:         ENDIF
6149:     ENDPROC
6150: 
6151:     *--------------------------------------------------------------------------
6152:     * MoedaComissaoDblClick
6153:     *--------------------------------------------------------------------------
6154:     PROCEDURE MoedaComissaoDblClick()
6155:         THIS.AbrirBuscaMoedaComissao()
6156:     ENDPROC
6157: 
6158:     *--------------------------------------------------------------------------
6159:     * MoedaComissaoLostFocus - Valida moeda comissao ao sair
6160:     *--------------------------------------------------------------------------
6161:     PROCEDURE MoedaComissaoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
6162:         LOCAL loc_oPgAba, loc_cMoe
6163:         loc_oPgAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page1
6164:         loc_cMoe   = ALLTRIM(NVL(loc_oPgAba.txt_4c__cd_moeda.Value, ""))
6165: 
6166:         IF EMPTY(loc_cMoe)
6167:             loc_oPgAba.txt_4c__ds_moeda.Value = ""
6168:             RETURN
6169:         ENDIF
6170: 
6171:         TRY
6172:             IF SQLEXEC(gnConnHandle, "SELECT Dmoes FROM SigCdMoe WHERE RTRIM(Cmoes)=" + ;
6173:                 EscaparSQL(loc_cMoe), "cursor_4c_MoeVal") >= 0
6174:                 IF USED("cursor_4c_MoeVal") AND RECCOUNT("cursor_4c_MoeVal") > 0
6175:                     SELECT cursor_4c_MoeVal
6176:                     loc_oPgAba.txt_4c__ds_moeda.Value = ALLTRIM(NVL(Dmoes, ""))
6177:                 ELSE
6178:                     THIS.AbrirBuscaMoedaComissao()
6179:                 ENDIF
6180:                 IF USED("cursor_4c_MoeVal")
6181:                     USE IN cursor_4c_MoeVal
6182:                 ENDIF
6183:             ENDIF
6184:         CATCH TO loc_oErro
6185:             MsgErro(loc_oErro.Message, "MoedaComissaoLostFocus")
6186:             IF USED("cursor_4c_MoeVal")
6187:                 USE IN cursor_4c_MoeVal
6188:             ENDIF
6189:         ENDTRY
6190:     ENDPROC
6191: 
6192:     *--------------------------------------------------------------------------
6193:     * AbrirBuscaMoedaComissao - FormBuscaAuxiliar para SigCdMoe (comissao)
6194:     *--------------------------------------------------------------------------
6195:     PROCEDURE AbrirBuscaMoedaComissao()
6196:         LOCAL loc_oBusca, loc_oPgAba
6197:         loc_oBusca = .NULL.
6198:         loc_oPgAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page1
6199: 
6200:         TRY
6201:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
6202:                 "SigCdMoe", "cursor_4c_BuscaMoeCom", "Cmoes", ;
6203:                 ALLTRIM(NVL(loc_oPgAba.txt_4c__cd_moeda.Value, "")), ;
6204:                 "Selecionar Moeda Comiss" + CHR(227) + "o")
6205: 
6206:             IF VARTYPE(loc_oBusca) = "O"
6207:                 IF !loc_oBusca.this_lAchouRegistro OR !loc_oBusca.this_lSelecionou
6208:                     loc_oBusca.mAddColuna("Cmoes", "", "C" + CHR(243) + "d.")
6209:                     loc_oBusca.mAddColuna("Dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
6210:                     loc_oBusca.Show()
6211:                 ENDIF
6212: 
6213:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeCom")
6214:                     SELECT cursor_4c_BuscaMoeCom
6215:                     loc_oPgAba.txt_4c__cd_moeda.Value = ALLTRIM(NVL(Cmoes, ""))
6216:                     loc_oPgAba.txt_4c__ds_moeda.Value = ALLTRIM(NVL(Dmoes, ""))
6217:                 ENDIF
6218:                 loc_oBusca.Release()
6219:             ENDIF
6220: 
6221:             IF USED("cursor_4c_BuscaMoeCom")
6222:                 USE IN cursor_4c_BuscaMoeCom
6223:             ENDIF
6224:         CATCH TO loc_oErro
6225:             MsgErro(loc_oErro.Message, "AbrirBuscaMoedaComissao")
6226:             IF USED("cursor_4c_BuscaMoeCom")
6227:                 USE IN cursor_4c_BuscaMoeCom
6228:             ENDIF
6229:         ENDTRY
6230:     ENDPROC
6231: 
6232:     *--------------------------------------------------------------------------
6233:     * MoedaLimiteKeyPress - F4 para moeda limite de credito
6234:     *--------------------------------------------------------------------------
6235:     PROCEDURE MoedaLimiteKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6236:         IF par_nKeyCode = 115
6237:             THIS.AbrirBuscaMoedaLimite()
6238:         ENDIF
6239:     ENDPROC
6240: 
6241:     *--------------------------------------------------------------------------
6242:     * MoedaLimiteDblClick
6243:     *--------------------------------------------------------------------------
6244:     PROCEDURE MoedaLimiteDblClick()
6245:         THIS.AbrirBuscaMoedaLimite()
6246:     ENDPROC
6247: 
6248:     *--------------------------------------------------------------------------
6249:     * MoedaLimiteLostFocus - Valida moeda limite ao sair
6250:     *--------------------------------------------------------------------------
6251:     PROCEDURE MoedaLimiteLostFocus(par_nKeyCode, par_nShiftAltCtrl)
6252:         LOCAL loc_oPgAba, loc_cMoe
6253:         loc_oPgAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page1
6254:         loc_cMoe   = ALLTRIM(NVL(loc_oPgAba.txt_4c__molimc.Value, ""))
6255: 
6256:         IF EMPTY(loc_cMoe)
6257:             RETURN
6258:         ENDIF
6259: 
6260:         TRY
6261:             IF SQLEXEC(gnConnHandle, "SELECT Dmoes FROM SigCdMoe WHERE RTRIM(Cmoes)=" + ;
6262:                 EscaparSQL(loc_cMoe), "cursor_4c_MoeL") >= 0
6263:                 IF !USED("cursor_4c_MoeL") OR RECCOUNT("cursor_4c_MoeL") = 0
6264:                     THIS.AbrirBuscaMoedaLimite()
6265:                 ENDIF
6266:                 IF USED("cursor_4c_MoeL")
6267:                     USE IN cursor_4c_MoeL
6268:                 ENDIF
6269:             ENDIF
6270:         CATCH TO loc_oErro
6271:             MsgErro(loc_oErro.Message, "MoedaLimiteLostFocus")
6272:             IF USED("cursor_4c_MoeL")
6273:                 USE IN cursor_4c_MoeL
6274:             ENDIF
6275:         ENDTRY
6276:     ENDPROC
6277: 
6278:     *--------------------------------------------------------------------------
6279:     * AbrirBuscaMoedaLimite - FormBuscaAuxiliar para SigCdMoe (limite)
6280:     *--------------------------------------------------------------------------
6281:     PROCEDURE AbrirBuscaMoedaLimite()
6282:         LOCAL loc_oBusca, loc_oPgAba
6283:         loc_oBusca = .NULL.
6284:         loc_oPgAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page1
6285: 
6286:         TRY
6287:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
6288:                 "SigCdMoe", "cursor_4c_BuscaMoeLim", "Cmoes", ;
6289:                 ALLTRIM(NVL(loc_oPgAba.txt_4c__molimc.Value, "")), ;
6290:                 "Selecionar Moeda Limite")
6291: 
6292:             IF VARTYPE(loc_oBusca) = "O"
6293:                 IF !loc_oBusca.this_lAchouRegistro OR !loc_oBusca.this_lSelecionou
6294:                     loc_oBusca.mAddColuna("Cmoes", "", "C" + CHR(243) + "d.")
6295:                     loc_oBusca.mAddColuna("Dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
6296:                     loc_oBusca.Show()
6297:                 ENDIF
6298: 
6299:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeLim")
6300:                     SELECT cursor_4c_BuscaMoeLim
6301:                     loc_oPgAba.txt_4c__molimc.Value = ALLTRIM(NVL(Cmoes, ""))
6302:                 ENDIF
6303:                 loc_oBusca.Release()
6304:             ENDIF
6305: 
6306:             IF USED("cursor_4c_BuscaMoeLim")
6307:                 USE IN cursor_4c_BuscaMoeLim
6308:             ENDIF
6309:         CATCH TO loc_oErro
6310:             MsgErro(loc_oErro.Message, "AbrirBuscaMoedaLimite")
6311:             IF USED("cursor_4c_BuscaMoeLim")
6312:                 USE IN cursor_4c_BuscaMoeLim
6313:             ENDIF
6314:         ENDTRY
6315:     ENDPROC
6316: 
6317:     *--------------------------------------------------------------------------
6318:     * GrupoContabKeyPress - F4 para grupo contabil padrao
6319:     *--------------------------------------------------------------------------
6320:     PROCEDURE GrupoContabKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6321:         IF par_nKeyCode = 115
6322:             THIS.AbrirBuscaGrupoContab()
6323:         ENDIF
6324:     ENDPROC
6325: 
6326:     *--------------------------------------------------------------------------
6327:     * GrupoContabDblClick
6328:     *--------------------------------------------------------------------------
6329:     PROCEDURE GrupoContabDblClick()
6330:         THIS.AbrirBuscaGrupoContab()
6331:     ENDPROC
6332: 
6333:     *--------------------------------------------------------------------------
6334:     * AbrirBuscaGrupoContab - FormBuscaAuxiliar para grupo contabil
6335:     *--------------------------------------------------------------------------
6336:     PROCEDURE AbrirBuscaGrupoContab()
6337:         LOCAL loc_oBusca, loc_oPgAba
6338:         loc_oBusca = .NULL.
6339:         loc_oPgAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page1
6340: 
6341:         TRY
6342:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
6343:                 "SigCdGcr", "cursor_4c_BuscaGrp", "codigos", ;
6344:                 ALLTRIM(NVL(loc_oPgAba.txt_4c_Grupo.Value, "")), ;
6345:                 "Selecionar Grupo Cont" + CHR(225) + "bil")
6346: 
6347:             IF VARTYPE(loc_oBusca) = "O"
6348:                 IF !loc_oBusca.this_lAchouRegistro OR !loc_oBusca.this_lSelecionou
6349:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
6350:                     loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
6351:                     loc_oBusca.Show()
6352:                 ENDIF
6353: 
6354:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
6355:                     SELECT cursor_4c_BuscaGrp
6356:                     loc_oPgAba.txt_4c_Grupo.Value = ALLTRIM(NVL(codigos, ""))
6357:                 ENDIF
6358:                 loc_oBusca.Release()
6359:             ENDIF
6360: 
6361:             IF USED("cursor_4c_BuscaGrp")
6362:                 USE IN cursor_4c_BuscaGrp
6363:             ENDIF
6364:         CATCH TO loc_oErro
6365:             MsgErro(loc_oErro.Message, "AbrirBuscaGrupoContab")
6366:             IF USED("cursor_4c_BuscaGrp")
6367:                 USE IN cursor_4c_BuscaGrp
6368:             ENDIF
6369:         ENDTRY
6370:     ENDPROC
6371: 
6372:     *--------------------------------------------------------------------------
6373:     * SituacaoKeyPress - F4 abre picker de Situacao Padrao (SigCdCst)
6374:     *--------------------------------------------------------------------------
6375:     PROCEDURE SituacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6376:         IF par_nKeyCode = 115
6377:             THIS.AbrirBuscaSituacao()
6378:         ENDIF
6379:     ENDPROC
6380: 
6381:     *--------------------------------------------------------------------------
6382:     * SituacaoDblClick - DblClick abre picker de Situacao
6383:     *--------------------------------------------------------------------------
6384:     PROCEDURE SituacaoDblClick()
6385:         THIS.AbrirBuscaSituacao()
6386:     ENDPROC
6387: 
6388:     *--------------------------------------------------------------------------
6389:     * SituacaoLostFocus - Valida Situacao ao sair do campo
6390:     *--------------------------------------------------------------------------
6391:     PROCEDURE SituacaoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
6392:         LOCAL loc_oPgAba, loc_cSit
6393:         loc_oPgAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page2
6394:         loc_cSit   = ALLTRIM(NVL(loc_oPgAba.getSituas.Value, ""))
6395: 
6396:         IF EMPTY(loc_cSit)
6397:             RETURN
6398:         ENDIF
6399: 
6400:         TRY
6401:             IF SQLEXEC(gnConnHandle, "SELECT codigos FROM SigCdCst WHERE RTRIM(codigos)=" + ;
6402:                 EscaparSQL(loc_cSit), "cursor_4c_SitVal") >= 0
6403:                 IF !USED("cursor_4c_SitVal") OR RECCOUNT("cursor_4c_SitVal") = 0
6404:                     THIS.AbrirBuscaSituacao()
6405:                 ENDIF
6406:                 IF USED("cursor_4c_SitVal")
6407:                     USE IN cursor_4c_SitVal
6408:                 ENDIF
6409:             ENDIF
6410:         CATCH TO loc_oErro
6411:             MsgErro(loc_oErro.Message, "SituacaoLostFocus")
6412:             IF USED("cursor_4c_SitVal")
6413:                 USE IN cursor_4c_SitVal
6414:             ENDIF
6415:         ENDTRY
6416:     ENDPROC
6417: 
6418:     *--------------------------------------------------------------------------
6419:     * AbrirBuscaSituacao - FormBuscaAuxiliar para SigCdCst (Situacao Padrao)
6420:     *--------------------------------------------------------------------------
6421:     PROCEDURE AbrirBuscaSituacao()
6422:         LOCAL loc_oBusca, loc_oPgAba
6423:         loc_oBusca = .NULL.
6424:         loc_oPgAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page2
6425: 
6426:         TRY
6427:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
6428:                 "SigCdCst", "cursor_4c_BuscaSit", "codigos", ;
6429:                 ALLTRIM(NVL(loc_oPgAba.getSituas.Value, "")), ;
6430:                 "Selecionar Situa" + CHR(231) + CHR(227) + "o", ;
6431:                 .F., .F., "")
6432: 
6433:             IF VARTYPE(loc_oBusca) = "O"
6434:                 IF !loc_oBusca.this_lAchouRegistro OR !loc_oBusca.this_lSelecionou
6435:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "d.")
6436:                     loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
6437:                     loc_oBusca.Show()
6438:                 ENDIF
6439: 
6440:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSit")
6441:                     SELECT cursor_4c_BuscaSit
6442:                     loc_oPgAba.getSituas.Value = ALLTRIM(NVL(codigos, ""))
6443:                 ENDIF
6444:                 loc_oBusca.Release()
6445:             ENDIF
6446: 
6447:             IF USED("cursor_4c_BuscaSit")
6448:                 USE IN cursor_4c_BuscaSit
6449:             ENDIF
6450:         CATCH TO loc_oErro
6451:             MsgErro(loc_oErro.Message, "AbrirBuscaSituacao")
6452:             IF USED("cursor_4c_BuscaSit")
6453:                 USE IN cursor_4c_BuscaSit
6454:             ENDIF
6455:         ENDTRY
6456:     ENDPROC
6457: 
6458:     *--------------------------------------------------------------------------
6459:     * GrupoEstoqueKeyPress - F4 abre picker de Grupo Diferenca Balanco (Estoque)
6460:     *--------------------------------------------------------------------------
6461:     PROCEDURE GrupoEstoqueKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6462:         IF par_nKeyCode = 115
6463:             THIS.AbrirBuscaGrupoEstoque()
6464:         ENDIF
6465:     ENDPROC
6466: 
6467:     *--------------------------------------------------------------------------
6468:     * GrupoEstoqueDblClick - DblClick abre picker de grupo (Estoque)
6469:     *--------------------------------------------------------------------------
6470:     PROCEDURE GrupoEstoqueDblClick()
6471:         THIS.AbrirBuscaGrupoEstoque()
6472:     ENDPROC
6473: 
6474:     *--------------------------------------------------------------------------
6475:     * AbrirBuscaGrupoEstoque - FormBuscaAuxiliar SigCdGcr para aba Estoque
6476:     *--------------------------------------------------------------------------
6477:     PROCEDURE AbrirBuscaGrupoEstoque()
6478:         LOCAL loc_oBusca, loc_oPgAba
6479:         loc_oBusca = .NULL.
6480:         loc_oPgAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page3
6481: 
6482:         TRY
6483:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
6484:                 "SigCdGcr", "cursor_4c_BuscaGrpEst", "codigos", ;
6485:                 ALLTRIM(NVL(loc_oPgAba.Get_grupo.Value, "")), ;
6486:                 "Selecionar Grupo")
6487: 
6488:             IF VARTYPE(loc_oBusca) = "O"
6489:                 IF !loc_oBusca.this_lAchouRegistro OR !loc_oBusca.this_lSelecionou
6490:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
6491:                     loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
6492:                     loc_oBusca.Show()
6493:                 ENDIF
6494: 
6495:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrpEst")
6496:                     SELECT cursor_4c_BuscaGrpEst
6497:                     loc_oPgAba.Get_grupo.Value = ALLTRIM(NVL(codigos, ""))
6498:                 ENDIF
6499:                 loc_oBusca.Release()
6500:             ENDIF
6501: 
6502:             IF USED("cursor_4c_BuscaGrpEst")
6503:                 USE IN cursor_4c_BuscaGrpEst
6504:             ENDIF
6505:         CATCH TO loc_oErro
6506:             MsgErro(loc_oErro.Message, "AbrirBuscaGrupoEstoque")
6507:             IF USED("cursor_4c_BuscaGrpEst")
6508:                 USE IN cursor_4c_BuscaGrpEst
6509:             ENDIF
6510:         ENDTRY
6511:     ENDPROC
6512: 
6513:     *--------------------------------------------------------------------------
6514:     * GrupoFatKeyPress - F4 abre picker de Grupo no container fiscal ativo
6515:     *--------------------------------------------------------------------------
6516:     PROCEDURE GrupoFatKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6517:         IF par_nKeyCode = 115
6518:             THIS.AbrirBuscaGrupoFat()
6519:         ENDIF
6520:     ENDPROC
6521: 
6522:     *--------------------------------------------------------------------------
6523:     * GrupoFatDblClick - DblClick abre picker de Grupo no container fiscal ativo
6524:     *--------------------------------------------------------------------------
6525:     PROCEDURE GrupoFatDblClick()
6526:         THIS.AbrirBuscaGrupoFat()
6527:     ENDPROC
6528: 
6529:     *--------------------------------------------------------------------------
6530:     * GrupoFatLostFocus - Ao sair de getCdGrupos: limpa campos vinculados se vazio
6531:     * Nao pode usar THIS.ActiveControl.Parent (foco ja mudou); usa propriedade
6532:     * armazenada por GrupoFatGotFocus
6533:     *--------------------------------------------------------------------------
6534:     PROCEDURE GrupoFatLostFocus(par_nKeyCode, par_nShiftAltCtrl)
6535:         LOCAL loc_oCnt
6536:         TRY
6537:             IF VARTYPE(THIS.this_oUltimoCntFat) = "O" AND !ISNULL(THIS.this_oUltimoCntFat)
6538:                 loc_oCnt = THIS.this_oUltimoCntFat
6539:                 IF EMPTY(ALLTRIM(NVL(loc_oCnt.getCdGrupos.Value, "")))
6540:                     loc_oCnt.getCdContas.Value = ""
6541:                     loc_oCnt.getDsContas.Value = ""
6542:                     loc_oCnt.getPctAliqs.Value = 0
6543:                     loc_oCnt.getReceitas.Value = ""
6544:                 ENDIF
6545:             ENDIF
6546:         CATCH TO loc_oErro
6547:             MsgErro(loc_oErro.Message, "GrupoFatLostFocus")
6548:         ENDTRY
6549:     ENDPROC
6550: 
6551:     *--------------------------------------------------------------------------
6552:     * GrupoFatGotFocus - Armazena container ativo ao entrar em getCdGrupos
6553:     *--------------------------------------------------------------------------
6554:     PROCEDURE GrupoFatGotFocus()
6555:         IF VARTYPE(THIS.ActiveControl) = "O" AND ;
6556:                 VARTYPE(THIS.ActiveControl.Parent) = "O"
6557:             THIS.this_oUltimoCntFat = THIS.ActiveControl.Parent
6558:         ENDIF
6559:     ENDPROC
6560: 
6561:     *--------------------------------------------------------------------------
6562:     * AbrirBuscaGrupoFat - FormBuscaAuxiliar SigCdGcr para container fiscal
6563:     *--------------------------------------------------------------------------
6564:     PROCEDURE AbrirBuscaGrupoFat()
6565:         LOCAL loc_oBusca, loc_oCnt
6566:         loc_oBusca = .NULL.
6567: 
6568:         IF VARTYPE(THIS.ActiveControl) # "O" OR ;
6569:                 VARTYPE(THIS.ActiveControl.Parent) # "O"
6570:             RETURN
6571:         ENDIF
6572:         loc_oCnt = THIS.ActiveControl.Parent
6573: 
6574:         TRY
6575:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
6576:                 "SigCdGcr", "cursor_4c_BuscaGrpFat", "codigos", ;
6577:                 ALLTRIM(NVL(loc_oCnt.getCdGrupos.Value, "")), ;
6578:                 "Selecionar Grupo")
6579: 
6580:             IF VARTYPE(loc_oBusca) = "O"
6581:                 IF !loc_oBusca.this_lAchouRegistro OR !loc_oBusca.this_lSelecionou
6582:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
6583:                     loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
6584:                     loc_oBusca.Show()
6585:                 ENDIF
6586: 
6587:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrpFat")
6588:                     SELECT cursor_4c_BuscaGrpFat
6589:                     loc_oCnt.getCdGrupos.Value = ALLTRIM(NVL(codigos, ""))
6590:                     *-- Limpa conta ao trocar grupo
6591:                     loc_oCnt.getCdContas.Value = ""
6592:                     loc_oCnt.getDsContas.Value = ""
6593:                 ENDIF
6594:                 loc_oBusca.Release()
6595:             ENDIF
6596: 
6597:             IF USED("cursor_4c_BuscaGrpFat")
6598:                 USE IN cursor_4c_BuscaGrpFat
6599:             ENDIF
6600:         CATCH TO loc_oErro
6601:             MsgErro(loc_oErro.Message, "AbrirBuscaGrupoFat")
6602:             IF USED("cursor_4c_BuscaGrpFat")
6603:                 USE IN cursor_4c_BuscaGrpFat
6604:             ENDIF
6605:         ENDTRY
6606:     ENDPROC
6607: 
6608:     *--------------------------------------------------------------------------
6609:     * ContaFatKeyPress - F4 abre picker de Conta no container fiscal ativo
6610:     *--------------------------------------------------------------------------
6611:     PROCEDURE ContaFatKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6612:         IF par_nKeyCode = 115
6613:             THIS.AbrirBuscaContaFat()
6614:         ENDIF
6615:     ENDPROC
6616: 
6617:     *--------------------------------------------------------------------------
6618:     * ContaFatDblClick - DblClick abre picker de Conta no container fiscal ativo
6619:     *--------------------------------------------------------------------------
6620:     PROCEDURE ContaFatDblClick()
6621:         THIS.AbrirBuscaContaFat()
6622:     ENDPROC
6623: 
6624:     *--------------------------------------------------------------------------
6625:     * ContaFatLostFocus - Ao sair de getCdContas: limpa descricao se vazio
6626:     *--------------------------------------------------------------------------
6627:     PROCEDURE ContaFatLostFocus(par_nKeyCode, par_nShiftAltCtrl)
6628:         LOCAL loc_oCnt
6629:         TRY
6630:             IF VARTYPE(THIS.this_oUltimoCntFat) = "O" AND !ISNULL(THIS.this_oUltimoCntFat)
6631:                 loc_oCnt = THIS.this_oUltimoCntFat
6632:                 IF EMPTY(ALLTRIM(NVL(loc_oCnt.getCdContas.Value, "")))
6633:                     loc_oCnt.getDsContas.Value = ""
6634:                 ENDIF
6635:             ENDIF
6636:         CATCH TO loc_oErro
6637:             MsgErro(loc_oErro.Message, "ContaFatLostFocus")
6638:         ENDTRY
6639:     ENDPROC
6640: 
6641:     *--------------------------------------------------------------------------
6642:     * ContaFatGotFocus - Armazena container ativo ao entrar em getCdContas
6643:     *--------------------------------------------------------------------------
6644:     PROCEDURE ContaFatGotFocus()
6645:         IF VARTYPE(THIS.ActiveControl) = "O" AND ;
6646:                 VARTYPE(THIS.ActiveControl.Parent) = "O"
6647:             THIS.this_oUltimoCntFat = THIS.ActiveControl.Parent
6648:         ENDIF
6649:     ENDPROC
6650: 
6651:     *--------------------------------------------------------------------------
6652:     * AbrirBuscaContaFat - FormBuscaAuxiliar SigCdCli para container fiscal
6653:     * Filtra por grupo (getCdGrupos) se informado
6654:     *--------------------------------------------------------------------------
6655:     PROCEDURE AbrirBuscaContaFat()
6656:         LOCAL loc_oBusca, loc_oCnt, loc_cGrupo, loc_cFiltro
6657:         loc_oBusca = .NULL.
6658: 
6659:         IF VARTYPE(THIS.ActiveControl) # "O" OR ;
6660:                 VARTYPE(THIS.ActiveControl.Parent) # "O"
6661:             RETURN
6662:         ENDIF
6663:         loc_oCnt   = THIS.ActiveControl.Parent
6664:         loc_cGrupo = ALLTRIM(NVL(loc_oCnt.getCdGrupos.Value, ""))
6665:         loc_cFiltro = IIF(EMPTY(loc_cGrupo), "", "grupos = " + EscaparSQL(loc_cGrupo))
6666: 
6667:         TRY
6668:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
6669:                 "SigCdCli", "cursor_4c_BuscaCntFat", "iclis", ;
6670:                 ALLTRIM(NVL(loc_oCnt.getCdContas.Value, "")), ;
6671:                 "Selecionar Conta", .F., .F., loc_cFiltro)
6672: 
6673:             IF VARTYPE(loc_oBusca) = "O"
6674:                 IF !loc_oBusca.this_lAchouRegistro OR !loc_oBusca.this_lSelecionou
6675:                     loc_oBusca.mAddColuna("iclis",  "", "C" + CHR(243) + "digo")
6676:                     loc_oBusca.mAddColuna("rclis",  "", "Nome/Raz" + CHR(227) + "o Social")
6677:                     loc_oBusca.Show()
6678:                 ENDIF
6679: 
6680:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCntFat")
6681:                     SELECT cursor_4c_BuscaCntFat
6682:                     loc_oCnt.getCdContas.Value = ALLTRIM(NVL(iclis, ""))
6683:                     loc_oCnt.getDsContas.Value = ALLTRIM(NVL(rclis, ""))
6684:                 ENDIF
6685:                 loc_oBusca.Release()
6686:             ENDIF
6687: 
6688:             IF USED("cursor_4c_BuscaCntFat")
6689:                 USE IN cursor_4c_BuscaCntFat
6690:             ENDIF
6691:         CATCH TO loc_oErro
6692:             MsgErro(loc_oErro.Message, "AbrirBuscaContaFat")
6693:             IF USED("cursor_4c_BuscaCntFat")
6694:                 USE IN cursor_4c_BuscaCntFat
6695:             ENDIF
6696:         ENDTRY
6697:     ENDPROC
6698: 
6699:     *--------------------------------------------------------------------------
6700:     * TornarControlesVisiveis - Recursivo, torna tudo visivel
6701:     *--------------------------------------------------------------------------
6702:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
6703:         LOCAL loc_nI, loc_oObjeto, loc_nP
6704: 
6705:         FOR loc_nI = 1 TO par_oContainer.ControlCount
6706:             loc_oObjeto = par_oContainer.Controls(loc_nI)
6707: 
6708:             IF VARTYPE(loc_oObjeto) = "O"
6709:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
6710:                     THIS.TornarControlesVisiveis(loc_oObjeto)
6711:                 ENDIF
6712: 
6713:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
6714:                     loc_oObjeto.Visible = .T.
6715:                 ENDIF
6716: 
6717:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
6718:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
6719:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
6720:                     ENDFOR
6721:                 ENDIF
6722:             ENDIF
6723:         ENDFOR
6724:     ENDPROC
6725: 
6726:     *--------------------------------------------------------------------------
6727:     * Destroy - Libera recursos; chama FormBase.Destroy como ultima linha
6728:     *--------------------------------------------------------------------------
6729:     PROCEDURE Destroy()
6730:         TRY
6731:             IF USED("cursor_4c_Dados")
6732:                 USE IN cursor_4c_Dados
6733:             ENDIF
6734: 
6735:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
6736:                 THIS.this_oBusinessObject = .NULL.
6737:             ENDIF
6738: 
6739:             THIS.this_oUltimoCntFat = .NULL.
6740:         CATCH TO loc_oErro
6741:             MsgErro(loc_oErro.Message, "Formccr.Destroy")
6742:         ENDTRY
6743: 
6744:         DODEFAULT()
6745:     ENDPROC
6746: 
6747: ENDDEFINE


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

