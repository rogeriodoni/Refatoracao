# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (5)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_BOTOESACAO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [BINDEVENT-PARAMS] Handler 'FiltroMesLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE FiltroMesLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'FiltroAnosLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE FiltroAnosLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarUsuars' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarUsuars(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarSetors' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarSetors(par_nKeyCode, par_nShiftAltCtrl)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCVE.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1973 linhas total):

*-- Linhas 31 a 170:
31:     this_cModoAtual      = "LISTA"
32: 
33:     *==========================================================================
34:     * Init - FormBase.Init() chama THIS.InicializarForm() via DODEFAULT
35:     *==========================================================================
36:     PROCEDURE Init()
37:         LOCAL loc_lResultado
38:         loc_lResultado = .F.
39: 
40:         TRY
41:             loc_lResultado = DODEFAULT()
42:         CATCH TO loc_oErro
43:             MsgErro("Erro ao inicializar FormCVE:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
44:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
45:         ENDTRY
46: 
47:         RETURN loc_lResultado
48:     ENDPROC
49: 
50:     *==========================================================================
51:     * InicializarForm - Configuracao completa do formulario
52:     *==========================================================================
53:     PROTECTED PROCEDURE InicializarForm()
54:         LOCAL loc_lResultado
55:         loc_lResultado = .F.
56: 
57:         TRY
58:             IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
59:                 MsgErro("Sem conex" + CHR(227) + "o com o banco de dados!", "Erro")
60:             ELSE
61:                 THIS.this_oBusinessObject = CREATEOBJECT("CVEBO")
62: 
63:                 IF VARTYPE(THIS.this_oBusinessObject) != "O"
64:                     MsgErro("Erro ao criar CVEBO!", "Erro")
65:                 ELSE
66:                     THIS.Caption = "Cadastro de Comiss" + CHR(245) + "es de " + ;
67:                                    "Vendedores por Cargos"
68: 
69:                     THIS.ConfigurarPageFrame()
70:                     THIS.pgf_4c_Paginas.Visible = .T.
71:                     THIS.pgf_4c_Paginas.ActivePage = 1
72:                     THIS.this_cModoAtual = "LISTA"
73: 
74:                     IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
75:                         THIS.CarregarLista()
76:                     ENDIF
77: 
78:                     loc_lResultado = .T.
79:                 ENDIF
80:             ENDIF
81:         CATCH TO loc_oErro
82:             MsgErro("Erro em InicializarForm:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
83:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
84:                     "Procedure: " + loc_oErro.Procedure, "Erro")
85:             loc_lResultado = .F.
86:         ENDTRY
87: 
88:         RETURN loc_lResultado
89:     ENDPROC
90: 
91:     *==========================================================================
92:     * ConfigurarPageFrame - Cria PageFrame com 2 paginas
93:     *==========================================================================
94:     PROTECTED PROCEDURE ConfigurarPageFrame()
95:         TRY
96:             THIS.AddObject("pgf_4c_Paginas", "PageFrame")
97: 
98:             WITH THIS.pgf_4c_Paginas
99:                 .PageCount = 2
100:                 .Top       = -29
101:                 .Left      = 0
102:                 .Width     = THIS.Width
103:                 .Height    = THIS.Height + 29
104:                 .Tabs      = .F.
105:                 .FontName  = "Tahoma"
106:                 .FontSize  = 8
107:                 .Page1.Caption   = "Lista"
108:                 .Page1.BackColor = RGB(100, 100, 100)
109:                 .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
110:                 .Page2.Caption   = "Dados"
111:                 .Page2.BackColor = RGB(100, 100, 100)
112:                 .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
113:                 .Visible = .T.
114:             ENDWITH
115: 
116:             THIS.ConfigurarPaginaLista()
117:             THIS.ConfigurarPaginaDados()
118: 
119:         CATCH TO loc_oErro
120:             MsgErro("Erro em ConfigurarPageFrame:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
121:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
122:         ENDTRY
123:     ENDPROC
124: 
125:     *==========================================================================
126:     * ConfigurarPaginaLista - Page1 completa:
127:     *   Cabecalho, Botoes CRUD, Encerrar, Filtro de Periodo,
128:     *   Botao Copia, Container Copia flutuante, Grid
129:     *==========================================================================
130:     PROTECTED PROCEDURE ConfigurarPaginaLista()
131:         LOCAL loc_oPagina, loc_cCaption, loc_oGrid
132:         loc_oPagina  = THIS.pgf_4c_Paginas.Page1
133: 
134:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
135:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
136:         loc_cCaption = THIS.Caption
137: 
138:         TRY
139:             *-- Cabecalho (Top=2+29=31)
140:             loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
141:             WITH loc_oPagina.cnt_4c_Cabecalho
142:                 .Top         = 31
143:                 .Left        = 0
144:                 .Width       = THIS.Width
145:                 .Height      = 80
146:                 .BackColor   = RGB(100, 100, 100)
147:                 .BorderWidth = 0
148:                 .Visible     = .T.
149: 
150:                 .AddObject("lbl_4c_Sombra", "Label")
151:                 WITH .lbl_4c_Sombra
152:                     .Caption   = loc_cCaption
153:                     .Top       = 15
154:                     .Left      = 10
155:                     .Width     = THIS.Width
156:                     .Height    = 40
157:                     .FontName  = "Tahoma"
158:                     .FontSize  = 16
159:                     .FontBold  = .T.
160:                     .ForeColor = RGB(0, 0, 0)
161:                     .BackStyle = 0
162:                     .AutoSize  = .F.
163:                     .Visible   = .T.
164:                 ENDWITH
165: 
166:                 .AddObject("lbl_4c_Titulo", "Label")
167:                 WITH .lbl_4c_Titulo
168:                     .Caption   = loc_cCaption
169:                     .Top       = 18
170:                     .Left      = 10

*-- Linhas 307 a 390:
307:                 ENDWITH
308:             ENDWITH
309: 
310:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
311:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
312:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
313:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
314:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
315: 
316:             *-- Encerrar - padrao canonico (CLAUDE.md Regra #10)
317:             loc_oPagina.AddObject("cnt_4c_Saida", "Container")
318:             WITH loc_oPagina.cnt_4c_Saida
319:                 .Top         = 29
320:                 .Left        = 917
321:                 .Width       = 90
322:                 .Height      = 85
323:                 .BackStyle   = 0
324:                 .BorderWidth = 0
325:                 .Visible     = .T.
326: 
327:                 .AddObject("cmd_4c_Encerrar", "CommandButton")
328:                 WITH .cmd_4c_Encerrar
329:                     .Caption         = "Encerrar"
330:                     .Top             = 5
331:                     .Left            = 917
332:                     .Width           = 75
333:                     .Height          = 75
334:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
335:                     .PicturePosition = 13
336:                     .FontName        = "Comic Sans MS"
337:                     .FontSize        = 8
338:                     .FontBold        = .T.
339:                     .FontItalic      = .T.
340:                     .ForeColor       = RGB(90, 90, 90)
341:                     .BackColor       = RGB(255, 255, 255)
342:                     .SpecialEffect   = 0
343:                     .MousePointer    = 15
344:                     .WordWrap        = .T.
345:                     .AutoSize        = .F.
346:                     .Visible         = .T.
347:                 ENDWITH
348:             ENDWITH
349: 
350:             BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
351: 
352:             *-- Filtro Periodo (top=119+29=148)
353:             loc_oPagina.AddObject("cnt_4c_Filtro", "Container")
354:             WITH loc_oPagina.cnt_4c_Filtro
355:                 .Top         = 148
356:                 .Left        = 11
357:                 .Width       = 162
358:                 .Height      = 33
359:                 .BackStyle   = 0
360:                 .BorderWidth = 0
361:                 .Visible     = .T.
362: 
363:                 .AddObject("lbl_4c_Periodo", "Label")
364:                 WITH .lbl_4c_Periodo
365:                     .Caption   = "Per" + CHR(237) + "odo :"
366:                     .Top       = 9
367:                     .Left      = 23
368:                     .Width     = 50
369:                     .Height    = 15
370:                     .FontName  = "Tahoma"
371:                     .FontSize  = 8
372:                     .ForeColor = RGB(255, 255, 255)
373:                     .BackStyle = 0
374:                     .Visible   = .T.
375:                 ENDWITH
376: 
377:                 .AddObject("txt_4c_FiltroMess", "TextBox")
378:                 WITH .txt_4c_FiltroMess
379:                     .Value     = PADL(ALLTRIM(STR(MONTH(DATE()))), 2, "0")
380:                     .Top       = 6
381:                     .Left      = 71
382:                     .Width     = 24
383:                     .Height    = 23
384:                     .InputMask = "99"
385:                     .FontName  = "Tahoma"
386:                     .FontSize  = 8
387:                     .Visible   = .T.
388:                 ENDWITH
389: 
390:                 .AddObject("lbl_4c_Barra", "Label")

*-- Linhas 415 a 480:
415:                 ENDWITH
416:             ENDWITH
417: 
418:             BINDEVENT(loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroMess, "KeyPress", THIS, "FiltroMesLostFocus")
419:             BINDEVENT(loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroAnos, "KeyPress", THIS, "FiltroAnosLostFocus")
420: 
421:             *-- Botao Copia de Periodo (top=91+29=120, left=347)
422:             loc_oPagina.AddObject("cmd_4c_Copia", "CommandButton")
423:             WITH loc_oPagina.cmd_4c_Copia
424:                 .Caption       = "C" + CHR(243) + "pia"
425:                 .Top           = 120
426:                 .Left          = 347
427:                 .Width         = 105
428:                 .Height        = 45
429:                 .FontName      = "Tahoma"
430:                 .FontSize      = 8
431:                 .FontBold      = .T.
432:                 .ForeColor     = RGB(90, 90, 90)
433:                 .BackColor     = RGB(255, 255, 255)
434:                 .Themes        = .T.
435:                 .SpecialEffect = 0
436:                 .MousePointer  = 15
437:                 .Visible       = .T.
438:             ENDWITH
439: 
440:             BINDEVENT(loc_oPagina.cmd_4c_Copia, "Click", THIS, "BtnCopiarClick")
441: 
442:             *-- Container flutuante Copia de Periodo (top=264+29=293, inicia oculto)
443:             loc_oPagina.AddObject("cnt_4c_Copia", "Container")
444:             WITH loc_oPagina.cnt_4c_Copia
445:                 .Top         = 293
446:                 .Left        = 226
447:                 .Width       = 348
448:                 .Height      = 77
449:                 .BackColor   = RGB(240, 240, 240)
450:                 .BackStyle   = 1
451:                 .BorderWidth = 1
452:                 .Visible     = .F.
453: 
454:                 .AddObject("lbl_4c_TituloCopia", "Label")
455:                 WITH .lbl_4c_TituloCopia
456:                     .Caption   = "C" + CHR(243) + "pia de Per" + CHR(237) + "odo"
457:                     .Top       = 5
458:                     .Left      = 8
459:                     .Width     = 150
460:                     .Height    = 15
461:                     .FontName  = "Tahoma"
462:                     .FontSize  = 8
463:                     .FontBold  = .T.
464:                     .ForeColor = RGB(0, 0, 0)
465:                     .BackStyle = 0
466:                     .Visible   = .T.
467:                 ENDWITH
468: 
469:                 .AddObject("lbl_4c_Origem", "Label")
470:                 WITH .lbl_4c_Origem
471:                     .Caption   = "Per" + CHR(237) + "odo de Origem :"
472:                     .Top       = 27
473:                     .Left      = 28
474:                     .Width     = 97
475:                     .Height    = 15
476:                     .FontName  = "Tahoma"
477:                     .FontSize  = 8
478:                     .ForeColor = RGB(0, 0, 0)
479:                     .BackStyle = 0
480:                     .Visible   = .T.

*-- Linhas 605 a 649:
605:                 ENDWITH
606:             ENDWITH
607: 
608:             BINDEVENT(loc_oPagina.cnt_4c_Copia.cmd_4c_OkCopia,       "Click", THIS, "BtnOkCopiaClick")
609:             BINDEVENT(loc_oPagina.cnt_4c_Copia.cmd_4c_CancelarCopia, "Click", THIS, "BtnCancelarCopiaClick")
610: 
611:             *-- Grid (top=185, left=11)
612:             loc_oPagina.AddObject("grd_4c_Lista", "Grid")
613: 
614:             loc_oGrid             = loc_oPagina.grd_4c_Lista
615:             loc_oGrid.ColumnCount = 8
616: 
617:             WITH loc_oGrid
618:                 .Top                = 185
619:                 .Left               = 11
620:                 .Width              = 895
621:                 .Height             = 390
622:                 .FontName           = "Tahoma"
623:                 .FontSize           = 8
624:                 .ForeColor          = RGB(90, 90, 90)
625:                 .BackColor          = RGB(255, 255, 255)
626:                 .GridLineColor      = RGB(238, 238, 238)
627:                 .HighlightBackColor = RGB(255, 255, 255)
628:                 .HighlightForeColor = RGB(15, 41, 104)
629:                 .HighlightStyle     = 2
630:                 .DeleteMark         = .F.
631:                 .RecordMark         = .F.
632:                 .RowHeight          = 16
633:                 .ScrollBars         = 2
634:                 .GridLines          = 3
635:                 .Visible            = .T.
636: 
637:                 WITH .Column1
638:                     .Width           = 110
639:                     .Header1.Caption = "Usu" + CHR(225) + "rio"
640:                 ENDWITH
641:                 WITH .Column2
642:                     .Width           = 35
643:                     .Header1.Caption = "M" + CHR(234) + "s"
644:                 ENDWITH
645:                 WITH .Column3
646:                     .Width           = 45
647:                     .Header1.Caption = "Ano"
648:                 ENDWITH
649:                 WITH .Column4

*-- Linhas 671 a 727:
671:                 ENDWITH
672:             ENDWITH
673: 
674:             THIS.TornarControlesVisiveis(loc_oPagina)
675: 
676:         CATCH TO loc_oErro
677:             MsgErro("Erro em ConfigurarPaginaLista:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
678:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
679:         ENDTRY
680:     ENDPROC
681: 
682:     *==========================================================================
683:     * ConfigurarPaginaDados - Page2 com todos os campos de SigCcCmI
684:     *   Usuars (lookup SigCdUsu), Mess, Anos, Indivs, Setors (lookup SigCdCrg),
685:     *   Adics, Minimos, MinExps + botoes Confirmar/Cancelar
686:     *==========================================================================
687:     PROTECTED PROCEDURE ConfigurarPaginaDados()
688:         LOCAL loc_oPagina
689:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
690: 
691:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
692:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
693: 
694:         TRY
695:             *-- Botoes Acao: Confirmar e Cancelar
696:             loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
697:             WITH loc_oPagina.cnt_4c_BotoesAcao
698:                 .Top         = 33
699:                 .Left        = 842
700:                 .Width       = 160
701:                 .Height      = 85
702:                 .BackStyle   = 0
703:                 .BorderWidth = 0
704:                 .Visible     = .T.
705: 
706:                 .AddObject("cmd_4c_Confirmar", "CommandButton")
707:                 WITH .cmd_4c_Confirmar
708:                     .Caption         = "Confirmar"
709:                     .Top             = 5
710:                     .Left            = 5
711:                     .Width           = 75
712:                     .Height          = 75
713:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
714:                     .PicturePosition = 13
715:                     .FontName        = "Comic Sans MS"
716:                     .FontSize        = 8
717:                     .FontBold        = .T.
718:                     .FontItalic      = .T.
719:                     .ForeColor       = RGB(90, 90, 90)
720:                     .BackColor       = RGB(255, 255, 255)
721:                     .SpecialEffect   = 0
722:                     .MousePointer    = 15
723:                     .WordWrap        = .T.
724:                     .AutoSize        = .F.
725:                     .Visible         = .T.
726:                 ENDWITH
727: 

*-- Linhas 749 a 827:
749:                 ENDWITH
750:             ENDWITH
751: 
752:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
753:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
754: 
755:             *-- Label: Usu?rio (layout top=179 +29=208)
756:             loc_oPagina.AddObject("lbl_4c_Usuars", "Label")
757:             WITH loc_oPagina.lbl_4c_Usuars
758:                 .Caption   = "Usu" + CHR(225) + "rio :"
759:                 .Top       = 208
760:                 .Left      = 248
761:                 .Width     = 54
762:                 .Height    = 15
763:                 .FontName  = "Tahoma"
764:                 .FontSize  = 8
765:                 .ForeColor = RGB(255, 255, 255)
766:                 .BackStyle = 0
767:                 .AutoSize  = .F.
768:                 .Visible   = .T.
769:             ENDWITH
770: 
771:             *-- TextBox: Usu?rio (layout top=176 +29=205)
772:             loc_oPagina.AddObject("txt_4c_Usuars", "TextBox")
773:             WITH loc_oPagina.txt_4c_Usuars
774:                 .Value     = ""
775:                 .Top       = 205
776:                 .Left      = 311
777:                 .Width     = 80
778:                 .Height    = 23
779:                 .MaxLength = 10
780:                 .FontName  = "Tahoma"
781:                 .FontSize  = 8
782:                 .Visible   = .T.
783:             ENDWITH
784: 
785:             BINDEVENT(loc_oPagina.txt_4c_Usuars, "DblClick",  THIS, "AbrirBuscaUsuars")
786:             BINDEVENT(loc_oPagina.txt_4c_Usuars, "KeyPress",  THIS, "TeclaLookupUsuars")
787:             BINDEVENT(loc_oPagina.txt_4c_Usuars, "KeyPress", THIS, "ValidarUsuars")
788: 
789:             *-- Label: Per?odo (layout top=204 +29=233)
790:             loc_oPagina.AddObject("lbl_4c_Periodo2", "Label")
791:             WITH loc_oPagina.lbl_4c_Periodo2
792:                 .Caption   = "Per" + CHR(237) + "odo :"
793:                 .Top       = 233
794:                 .Left      = 248
795:                 .Width     = 54
796:                 .Height    = 15
797:                 .FontName  = "Tahoma"
798:                 .FontSize  = 8
799:                 .ForeColor = RGB(255, 255, 255)
800:                 .BackStyle = 0
801:                 .AutoSize  = .F.
802:                 .Visible   = .T.
803:             ENDWITH
804: 
805:             *-- TextBox: M?s Per?odo (layout top=201 +29=230)
806:             loc_oPagina.AddObject("txt_4c_Mess", "TextBox")
807:             WITH loc_oPagina.txt_4c_Mess
808:                 .Value     = ""
809:                 .Top       = 230
810:                 .Left      = 311
811:                 .Width     = 24
812:                 .Height    = 23
813:                 .InputMask = "99"
814:                 .MaxLength = 2
815:                 .FontName  = "Tahoma"
816:                 .FontSize  = 8
817:                 .Visible   = .T.
818:             ENDWITH
819: 
820:             *-- Separador "/" entre M?s e Ano (layout top=202 +29=231)
821:             loc_oPagina.AddObject("lbl_4c_BarraMesAno", "Label")
822:             WITH loc_oPagina.lbl_4c_BarraMesAno
823:                 .Caption   = "/"
824:                 .Top       = 231
825:                 .Left      = 340
826:                 .Width     = 8
827:                 .Height    = 15

*-- Linhas 923 a 968:
923:                 .Visible   = .T.
924:             ENDWITH
925: 
926:             BINDEVENT(loc_oPagina.txt_4c_Setors, "DblClick",  THIS, "AbrirBuscaSetors")
927:             BINDEVENT(loc_oPagina.txt_4c_Setors, "KeyPress",  THIS, "TeclaLookupSetors")
928:             BINDEVENT(loc_oPagina.txt_4c_Setors, "KeyPress", THIS, "ValidarSetors")
929: 
930:             *-- Label: Adicional (layout top=278 +29=307)
931:             loc_oPagina.AddObject("lbl_4c_Adics", "Label")
932:             WITH loc_oPagina.lbl_4c_Adics
933:                 .Caption   = "Adicional :"
934:                 .Top       = 307
935:                 .Left      = 240
936:                 .Width     = 62
937:                 .Height    = 15
938:                 .FontName  = "Tahoma"
939:                 .FontSize  = 8
940:                 .ForeColor = RGB(255, 255, 255)
941:                 .BackStyle = 0
942:                 .AutoSize  = .F.
943:                 .Visible   = .T.
944:             ENDWITH
945: 
946:             *-- TextBox: Adicional % (layout top=275 +29=304)
947:             loc_oPagina.AddObject("txt_4c_Adics", "TextBox")
948:             WITH loc_oPagina.txt_4c_Adics
949:                 .Value    = 0.00
950:                 .Top      = 304
951:                 .Left     = 311
952:                 .Width    = 52
953:                 .Height   = 23
954:                 .FontName = "Tahoma"
955:                 .FontSize = 8
956:                 .Visible  = .T.
957:             ENDWITH
958: 
959:             *-- Label: % (layout top=280 +29=309)
960:             loc_oPagina.AddObject("lbl_4c_PctAdics", "Label")
961:             WITH loc_oPagina.lbl_4c_PctAdics
962:                 .Caption   = "%"
963:                 .Top       = 309
964:                 .Left      = 368
965:                 .Width     = 14
966:                 .Height    = 15
967:                 .FontName  = "Tahoma"
968:                 .FontSize  = 8

*-- Linhas 1029 a 1158:
1029:                 .Visible  = .T.
1030:             ENDWITH
1031: 
1032:             THIS.TornarControlesVisiveis(loc_oPagina)
1033:         CATCH TO loc_oErro
1034:             MsgErro("Erro em ConfigurarPaginaDados:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
1035:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
1036:         ENDTRY
1037:     ENDPROC
1038: 
1039:     *==========================================================================
1040:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
1041:     * cnt_4c_Copia deve permanecer oculto (container flutuante)
1042:     *==========================================================================
1043:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1044:         LOCAL loc_nI, loc_oObjeto, loc_cNome, loc_nP
1045: 
1046:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1047:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1048: 
1049:             IF VARTYPE(loc_oObjeto) = "O"
1050:                 loc_cNome = UPPER(loc_oObjeto.Name)
1051: 
1052:                 IF INLIST(loc_cNome, "CNT_4C_COPIA")
1053:                     IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1054:                         THIS.TornarControlesVisiveis(loc_oObjeto)
1055:                     ENDIF
1056:                     LOOP
1057:                 ENDIF
1058: 
1059:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1060:                     loc_oObjeto.Visible = .T.
1061:                 ENDIF
1062: 
1063:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1064:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1065:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1066:                     ENDFOR
1067:                 ENDIF
1068: 
1069:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1070:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1071:                 ENDIF
1072:             ENDIF
1073:         ENDFOR
1074:     ENDPROC
1075: 
1076:     *==========================================================================
1077:     * FormatarGridLista - Formata visual do grid
1078:     *==========================================================================
1079:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1080:         WITH par_oGrid
1081:             .FontName = "Tahoma"
1082:             .FontSize = 8
1083:         ENDWITH
1084:     ENDPROC
1085: 
1086:     *==========================================================================
1087:     * AlternarPagina - Alterna entre Page1 (1=Lista) e Page2 (2=Dados)
1088:     *==========================================================================
1089:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1090:         LOCAL loc_lResultado
1091:         loc_lResultado = .F.
1092: 
1093:         TRY
1094:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
1095:                 loc_lResultado = .F.
1096:             ELSE
1097:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1098: 
1099:                 IF par_nPagina = 1
1100:                     THIS.this_cModoAtual = "LISTA"
1101:                     THIS.CarregarLista()
1102:                 ENDIF
1103: 
1104:                 loc_lResultado = .T.
1105:             ENDIF
1106:         CATCH TO loc_oErro
1107:             MsgErro("Erro em AlternarPagina:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
1108:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
1109:             loc_lResultado = .F.
1110:         ENDTRY
1111: 
1112:         RETURN loc_lResultado
1113:     ENDPROC
1114: 
1115:     *==========================================================================
1116:     * CarregarLista - Carrega grid com dados de SigCcCmI filtrados por periodo
1117:     *==========================================================================
1118:     PROCEDURE CarregarLista()
1119:         LOCAL loc_lResultado, loc_cSQL, loc_nResult
1120:         LOCAL loc_cMesI, loc_cMesF, loc_cAnoI, loc_cAnoF
1121:         LOCAL loc_oPagina, loc_oGrid
1122:         loc_lResultado = .F.
1123: 
1124:         TRY
1125:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1126:                 loc_lResultado = .T.
1127:             ELSE
1128:                 loc_oPagina = THIS.pgf_4c_Paginas.Page1
1129:                 loc_oGrid   = loc_oPagina.grd_4c_Lista
1130: 
1131:                 loc_cMesI = PADL(ALLTRIM(loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroMess.Value), 2, "0")
1132:                 loc_cAnoI = PADL(ALLTRIM(loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroAnos.Value), 4, "0")
1133:                 loc_cMesF = IIF(loc_cMesI = "00", "12", loc_cMesI)
1134:                 loc_cAnoF = IIF(loc_cAnoI = "0000", "9999", loc_cAnoI)
1135: 
1136:                 IF USED("crSigCcCmI")
1137:                     USE IN crSigCcCmI
1138:                 ENDIF
1139: 
1140:                 loc_cSQL = "SELECT cIdChaves, Usuars, Mess, Anos, Indivs, Setors," + ;
1141:                            " Adics, Minimos, MinExps" + ;
1142:                            " FROM SigCcCmI" + ;
1143:                            " WHERE Mess BETWEEN " + EscaparSQL(loc_cMesI) + ;
1144:                            " AND " + EscaparSQL(loc_cMesF) + ;
1145:                            " AND Anos BETWEEN " + EscaparSQL(loc_cAnoI) + ;
1146:                            " AND " + EscaparSQL(loc_cAnoF) + ;
1147:                            " ORDER BY Anos, Mess, Usuars, Setors"
1148: 
1149:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCcCmI")
1150: 
1151:                 IF loc_nResult < 0
1152:                     MsgErro("Erro ao carregar comiss" + CHR(245) + "es:" + CHR(13) + ;
1153:                             CapturarErroSQL(), "Erro SQL")
1154:                 ELSE
1155:                     loc_oGrid.RecordSource           = "crSigCcCmI"
1156:                     loc_oGrid.Column1.ControlSource  = "crSigCcCmI.Usuars"
1157:                     loc_oGrid.Column2.ControlSource  = "crSigCcCmI.Mess"
1158:                     loc_oGrid.Column3.ControlSource  = "crSigCcCmI.Anos"

*-- Linhas 1198 a 1495:
1198:     ENDPROC
1199: 
1200:     *==========================================================================
1201:     * FiltroMesLostFocus - Ao sair do campo mes, padroniza e foca ano
1202:     *==========================================================================
1203:     PROCEDURE FiltroMesLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1204:         LOCAL loc_oPagina
1205:         TRY
1206:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
1207:             loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroMess.Value = ;
1208:                 PADL(ALLTRIM(loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroMess.Value), 2, "0")
1209:             loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroAnos.SetFocus
1210:         CATCH TO loc_oErro
1211:             MsgErro("Erro em FiltroMesLostFocus:" + CHR(13) + loc_oErro.Message, "Erro")
1212:         ENDTRY
1213:     ENDPROC
1214: 
1215:     *==========================================================================
1216:     * FiltroAnosLostFocus - Ao sair do campo ano, padroniza e recarrega grid
1217:     *==========================================================================
1218:     PROCEDURE FiltroAnosLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1219:         LOCAL loc_oPagina
1220:         TRY
1221:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
1222:             loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroAnos.Value = ;
1223:                 PADL(ALLTRIM(loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroAnos.Value), 4, "0")
1224:             THIS.CarregarLista()
1225:         CATCH TO loc_oErro
1226:             MsgErro("Erro em FiltroAnosLostFocus:" + CHR(13) + loc_oErro.Message, "Erro")
1227:         ENDTRY
1228:     ENDPROC
1229: 
1230:     *==========================================================================
1231:     * BtnIncluirClick - Prepara novo registro e navega para Page2
1232:     *==========================================================================
1233:     PROCEDURE BtnIncluirClick()
1234:         TRY
1235:             THIS.this_oBusinessObject.NovoRegistro()
1236:             THIS.this_cModoAtual = "INCLUIR"
1237:             THIS.LimparCampos()
1238:             THIS.HabilitarCampos(.T.)
1239:             THIS.AjustarBotoesPorModo()
1240:             THIS.AlternarPagina(2)
1241:             THIS.pgf_4c_Paginas.Page2.txt_4c_Usuars.SetFocus
1242:         CATCH TO loc_oErro
1243:             MsgErro("Erro em BtnIncluirClick:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
1244:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
1245:         ENDTRY
1246:     ENDPROC
1247: 
1248:     *==========================================================================
1249:     * BtnAlterarClick - Carrega registro selecionado e navega para Page2
1250:     *==========================================================================
1251:     PROCEDURE BtnAlterarClick()
1252:         LOCAL loc_cChave
1253:         TRY
1254:             IF !USED("crSigCcCmI") OR EOF("crSigCcCmI") OR RECCOUNT("crSigCcCmI") = 0
1255:                 MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
1256:             ELSE
1257:                 SELECT crSigCcCmI
1258:                 loc_cChave = ALLTRIM(crSigCcCmI.cIdChaves)
1259: 
1260:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1261:                     THIS.this_oBusinessObject.EditarRegistro()
1262:                     THIS.this_cModoAtual = "ALTERAR"
1263:                     THIS.BOParaForm()
1264:                     THIS.HabilitarCampos(.T.)
1265:                     THIS.AjustarBotoesPorModo()
1266:                     THIS.AlternarPagina(2)
1267:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Indivs.SetFocus
1268:                 ELSE
1269:                     MsgErro("Erro ao carregar registro para altera" + CHR(231) + CHR(227) + "o!", "Erro")
1270:                 ENDIF
1271:             ENDIF
1272:         CATCH TO loc_oErro
1273:             MsgErro("Erro em BtnAlterarClick:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
1274:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
1275:         ENDTRY
1276:     ENDPROC
1277: 
1278:     *==========================================================================
1279:     * BtnVisualizarClick - Carrega registro em modo somente leitura
1280:     *==========================================================================
1281:     PROCEDURE BtnVisualizarClick()
1282:         LOCAL loc_cChave
1283:         TRY
1284:             IF !USED("crSigCcCmI") OR EOF("crSigCcCmI") OR RECCOUNT("crSigCcCmI") = 0
1285:                 MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
1286:             ELSE
1287:                 SELECT crSigCcCmI
1288:                 loc_cChave = ALLTRIM(crSigCcCmI.cIdChaves)
1289: 
1290:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1291:                     THIS.this_cModoAtual = "VISUALIZAR"
1292:                     THIS.BOParaForm()
1293:                     THIS.HabilitarCampos(.F.)
1294:                     THIS.AjustarBotoesPorModo()
1295:                     THIS.AlternarPagina(2)
1296:                 ELSE
1297:                     MsgErro("Erro ao carregar registro para visualiza" + CHR(231) + CHR(227) + "o!", "Erro")
1298:                 ENDIF
1299:             ENDIF
1300:         CATCH TO loc_oErro
1301:             MsgErro("Erro em BtnVisualizarClick:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
1302:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
1303:         ENDTRY
1304:     ENDPROC
1305: 
1306:     *==========================================================================
1307:     * BtnExcluirClick - Confirma e exclui registro selecionado
1308:     *==========================================================================
1309:     PROCEDURE BtnExcluirClick()
1310:         LOCAL loc_cChave, loc_lConfirma
1311:         TRY
1312:             IF !USED("crSigCcCmI") OR EOF("crSigCcCmI") OR RECCOUNT("crSigCcCmI") = 0
1313:                 MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
1314:             ELSE
1315:                 SELECT crSigCcCmI
1316:                 loc_cChave   = ALLTRIM(crSigCcCmI.cIdChaves)
1317:                 loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro?", ;
1318:                                             "Excluir")
1319: 
1320:                 IF loc_lConfirma
1321:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1322:                         IF THIS.this_oBusinessObject.Excluir()
1323:                             MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "")
1324:                             THIS.CarregarLista()
1325:                         ELSE
1326:                             MsgErro("Erro ao excluir registro!", "Erro")
1327:                         ENDIF
1328:                     ELSE
1329:                         MsgErro("Erro ao carregar registro para exclus" + CHR(227) + "o!", "Erro")
1330:                     ENDIF
1331:                 ENDIF
1332:             ENDIF
1333:         CATCH TO loc_oErro
1334:             MsgErro("Erro em BtnExcluirClick:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
1335:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
1336:         ENDTRY
1337:     ENDPROC
1338: 
1339:     *==========================================================================
1340:     * BtnBuscarClick - Recarrega grid com filtro atual
1341:     *==========================================================================
1342:     PROCEDURE BtnBuscarClick()
1343:         TRY
1344:             THIS.CarregarLista()
1345:             IF USED("crSigCcCmI") AND !EOF("crSigCcCmI")
1346:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.SetFocus
1347:             ENDIF
1348:         CATCH TO loc_oErro
1349:             MsgErro("Erro em BtnBuscarClick:" + CHR(13) + loc_oErro.Message, "Erro")
1350:         ENDTRY
1351:     ENDPROC
1352: 
1353:     *==========================================================================
1354:     * BtnEncerrarClick - Fecha o formulario
1355:     *==========================================================================
1356:     PROCEDURE BtnEncerrarClick()
1357:         TRY
1358:             THIS.Release()
1359:         CATCH TO loc_oErro
1360:             *-- Ignorar erros ao fechar
1361:         ENDTRY
1362:     ENDPROC
1363: 
1364:     *==========================================================================
1365:     * BtnSalvarClick - Valida e salva registro
1366:     *==========================================================================
1367:     PROCEDURE BtnSalvarClick()
1368:         IF !THIS.FormParaBO()
1369:             RETURN
1370:         ENDIF
1371: 
1372:         TRY
1373:             IF THIS.this_oBusinessObject.Salvar()
1374:                 MsgInfo("Registro salvo com sucesso!", "")
1375:                 THIS.AlternarPagina(1)
1376:             ELSE
1377:                 MsgErro("Erro ao salvar registro!", "Erro")
1378:             ENDIF
1379:         CATCH TO loc_oErro
1380:             MsgErro("Erro em BtnSalvarClick:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
1381:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
1382:         ENDTRY
1383:     ENDPROC
1384: 
1385:     *==========================================================================
1386:     * BtnCancelarClick - Cancela edicao e volta para lista
1387:     *==========================================================================
1388:     PROCEDURE BtnCancelarClick()
1389:         TRY
1390:             THIS.AlternarPagina(1)
1391:         CATCH TO loc_oErro
1392:             MsgErro("Erro em BtnCancelarClick:" + CHR(13) + loc_oErro.Message, "Erro")
1393:         ENDTRY
1394:     ENDPROC
1395: 
1396:     *==========================================================================
1397:     * BtnCopiarClick - Mostra container de copia de periodo
1398:     *==========================================================================
1399:     PROCEDURE BtnCopiarClick()
1400:         LOCAL loc_oPagina
1401:         TRY
1402:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
1403: 
1404:             loc_oPagina.grd_4c_Lista.Enabled  = .F.
1405:             loc_oPagina.cnt_4c_Botoes.Enabled = .F.
1406:             loc_oPagina.cnt_4c_Saida.Enabled  = .F.
1407:             loc_oPagina.cmd_4c_Copia.Enabled  = .F.
1408: 
1409:             WITH loc_oPagina.cnt_4c_Copia
1410:                 .txt_4c_OMess.Value = ""
1411:                 .txt_4c_OAnos.Value = ""
1412:                 .txt_4c_DMess.Value = ""
1413:                 .txt_4c_DAnos.Value = ""
1414:                 .Visible = .T.
1415:                 .ZOrder(0)
1416:                 .txt_4c_OMess.SetFocus
1417:             ENDWITH
1418:         CATCH TO loc_oErro
1419:             MsgErro("Erro em BtnCopiarClick:" + CHR(13) + loc_oErro.Message, "Erro")
1420:         ENDTRY
1421:     ENDPROC
1422: 
1423:     *==========================================================================
1424:     * BtnOkCopiaClick - Executa copia de todos os registros do periodo origem
1425:     *                   para o periodo destino no SQL Server
1426:     *==========================================================================
1427:     PROCEDURE BtnOkCopiaClick()
1428:         LOCAL loc_oPagina, loc_cOMess, loc_cDMess, loc_cOAnos, loc_cDAnos
1429:         LOCAL loc_nResult, loc_cSQL, loc_lCopiar
1430:         loc_lCopiar = .F.
1431: 
1432:         TRY
1433:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
1434: 
1435:             loc_cOMess = PADL(ALLTRIM(loc_oPagina.cnt_4c_Copia.txt_4c_OMess.Value), 2, "0")
1436:             loc_cOAnos = PADL(ALLTRIM(loc_oPagina.cnt_4c_Copia.txt_4c_OAnos.Value), 4, "0")
1437:             loc_cDMess = PADL(ALLTRIM(loc_oPagina.cnt_4c_Copia.txt_4c_DMess.Value), 2, "0")
1438:             loc_cDAnos = PADL(ALLTRIM(loc_oPagina.cnt_4c_Copia.txt_4c_DAnos.Value), 4, "0")
1439: 
1440:             IF EMPTY(loc_cOMess) OR loc_cOMess = "00" OR VAL(loc_cOMess) = 0
1441:                 MsgAviso("Obrigat" + CHR(243) + "rio informar o M" + CHR(234) + ;
1442:                          "s de Origem!", "")
1443:                 loc_oPagina.cnt_4c_Copia.txt_4c_OMess.SetFocus
1444:             ELSE
1445:                 IF EMPTY(loc_cOAnos) OR loc_cOAnos = "0000" OR VAL(loc_cOAnos) = 0
1446:                 MsgAviso("Obrigat" + CHR(243) + "rio informar o Ano de Origem!", "")
1447:                 loc_oPagina.cnt_4c_Copia.txt_4c_OAnos.SetFocus
1448:             ELSE
1449:                 IF EMPTY(loc_cDMess) OR loc_cDMess = "00" OR VAL(loc_cDMess) = 0
1450:                 MsgAviso("Obrigat" + CHR(243) + "rio informar o M" + CHR(234) + ;
1451:                          "s de Destino!", "")
1452:                 loc_oPagina.cnt_4c_Copia.txt_4c_DMess.SetFocus
1453:             ELSE
1454:                 IF EMPTY(loc_cDAnos) OR loc_cDAnos = "0000" OR VAL(loc_cDAnos) = 0
1455:                 MsgAviso("Obrigat" + CHR(243) + "rio informar o Ano de Destino!", "")
1456:                 loc_oPagina.cnt_4c_Copia.txt_4c_DAnos.SetFocus
1457:             ELSE
1458:                 *-- Verificar se destino ja tem registros
1459:                 loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCcCmI" + ;
1460:                            " WHERE Mess = " + EscaparSQL(loc_cDMess) + ;
1461:                            " AND Anos = " + EscaparSQL(loc_cDAnos)
1462: 
1463:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerifDest")
1464: 
1465:                 IF loc_nResult >= 0 AND USED("cursor_4c_VerifDest") AND ;
1466:                    cursor_4c_VerifDest.Total > 0
1467:                     IF MsgConfirma("O per" + CHR(237) + "odo de destino j" + CHR(225) + ;
1468:                                    " possui registros. Deseja sobrepor?", "Confirmar")
1469:                         loc_lCopiar = .T.
1470:                     ENDIF
1471:                 ELSE
1472:                     loc_lCopiar = .T.
1473:                 ENDIF
1474: 
1475:                 IF USED("cursor_4c_VerifDest")
1476:                     USE IN cursor_4c_VerifDest
1477:                 ENDIF
1478: 
1479:                 IF loc_lCopiar
1480:                     loc_cSQL = "INSERT INTO SigCcCmI" + ;
1481:                                " (cIdChaves, Usuars, Indivs, Setors, Adics, Minimos, MinExps," + ;
1482:                                " Mess, Anos)" + ;
1483:                                " SELECT NEWID(), Usuars, Indivs, Setors, Adics, Minimos, MinExps," + ;
1484:                                " " + EscaparSQL(loc_cDMess) + ", " + EscaparSQL(loc_cDAnos) + ;
1485:                                " FROM SigCcCmI" + ;
1486:                                " WHERE Mess = " + EscaparSQL(loc_cOMess) + ;
1487:                                " AND Anos = " + EscaparSQL(loc_cOAnos) + ;
1488:                                " AND NOT EXISTS (" + ;
1489:                                "   SELECT 1 FROM SigCcCmI d" + ;
1490:                                "   WHERE d.Mess = " + EscaparSQL(loc_cDMess) + ;
1491:                                "   AND d.Anos = " + EscaparSQL(loc_cDAnos) + ;
1492:                                "   AND d.Usuars = SigCcCmI.Usuars)"
1493: 
1494:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CopRes")
1495: 

*-- Linhas 1525 a 1973:
1525:     *==========================================================================
1526:     * BtnCancelarCopiaClick - Oculta container de copia e reabilita area
1527:     *==========================================================================
1528:     PROCEDURE BtnCancelarCopiaClick()
1529:         LOCAL loc_oPagina
1530:         TRY
1531:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
1532: 
1533:             loc_oPagina.cnt_4c_Copia.Visible  = .F.
1534:             loc_oPagina.grd_4c_Lista.Enabled  = .T.
1535:             loc_oPagina.cnt_4c_Botoes.Enabled = .T.
1536:             loc_oPagina.cnt_4c_Saida.Enabled  = .T.
1537:             loc_oPagina.cmd_4c_Copia.Enabled  = .T.
1538: 
1539:             IF USED("crSigCcCmI")
1540:                 loc_oPagina.grd_4c_Lista.SetFocus
1541:             ENDIF
1542:         CATCH TO loc_oErro
1543:             MsgErro("Erro em BtnCancelarCopiaClick:" + CHR(13) + loc_oErro.Message, "Erro")
1544:         ENDTRY
1545:     ENDPROC
1546: 
1547:     *==========================================================================
1548:     * LimparCampos - Limpa todos os campos da Page2
1549:     *==========================================================================
1550:     PROTECTED PROCEDURE LimparCampos()
1551:         LOCAL loc_oPagina
1552:         TRY
1553:             THIS.this_oBusinessObject.NovoRegistro()
1554:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1555:             loc_oPagina.txt_4c_Usuars.Value  = ""
1556:             loc_oPagina.txt_4c_Mess.Value    = ""
1557:             loc_oPagina.txt_4c_Anos.Value    = ""
1558:             loc_oPagina.txt_4c_Indivs.Value  = "N"
1559:             loc_oPagina.txt_4c_Setors.Value  = ""
1560:             loc_oPagina.txt_4c_Adics.Value   = 0.00
1561:             loc_oPagina.txt_4c_Minimos.Value = 0.00
1562:             loc_oPagina.txt_4c_MinExps.Value = 0.00
1563:         CATCH TO loc_oErro
1564:             MsgErro("Erro em LimparCampos:" + CHR(13) + loc_oErro.Message, "Erro")
1565:         ENDTRY
1566:     ENDPROC
1567: 
1568:     *==========================================================================
1569:     * HabilitarCampos - Habilita ou desabilita todos os campos editaveis da Page2
1570:     *==========================================================================
1571:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1572:         LOCAL loc_oPagina
1573:         TRY
1574:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1575:             loc_oPagina.txt_4c_Usuars.Enabled  = par_lHabilitar
1576:             loc_oPagina.txt_4c_Mess.Enabled    = par_lHabilitar
1577:             loc_oPagina.txt_4c_Anos.Enabled    = par_lHabilitar
1578:             loc_oPagina.txt_4c_Indivs.Enabled  = par_lHabilitar
1579:             loc_oPagina.txt_4c_Setors.Enabled  = par_lHabilitar
1580:             loc_oPagina.txt_4c_Adics.Enabled   = par_lHabilitar
1581:             loc_oPagina.txt_4c_Minimos.Enabled = par_lHabilitar
1582:             loc_oPagina.txt_4c_MinExps.Enabled = par_lHabilitar
1583:             WITH loc_oPagina.cnt_4c_BotoesAcao
1584:                 .cmd_4c_Confirmar.Enabled = par_lHabilitar
1585:                 .Visible     = .T.
1586:             ENDWITH
1587:         CATCH TO loc_oErro
1588:             MsgErro("Erro em HabilitarCampos:" + CHR(13) + loc_oErro.Message, "Erro")
1589:         ENDTRY
1590:     ENDPROC
1591: 
1592:     *==========================================================================
1593:     * AjustarBotoesPorModo - Ajusta estado dos botoes da Page2 conforme modo
1594:     *==========================================================================
1595:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1596:         LOCAL loc_oPagina, loc_lEditar
1597:         TRY
1598:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1599:             loc_lEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1600: 
1601:             WITH loc_oPagina.cnt_4c_BotoesAcao
1602:                 .cmd_4c_Confirmar.Enabled = loc_lEditar
1603:                 .cmd_4c_Cancelar.Enabled  = .T.
1604:                 .Visible     = .T.
1605:             ENDWITH
1606:         CATCH TO loc_oErro
1607:             MsgErro("Erro em AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message, "Erro")
1608:         ENDTRY
1609:     ENDPROC
1610: 
1611:     *==========================================================================
1612:     * BOParaForm - Transfere propriedades do BO para os campos da Page2
1613:     *==========================================================================
1614:     PROTECTED PROCEDURE BOParaForm()
1615:         LOCAL loc_lResultado, loc_oPagina, loc_oBO
1616:         loc_lResultado = .F.
1617: 
1618:         TRY
1619:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1620:             loc_oBO     = THIS.this_oBusinessObject
1621: 
1622:             loc_oPagina.txt_4c_Usuars.Value  = ALLTRIM(loc_oBO.this_cUsuars)
1623:             loc_oPagina.txt_4c_Mess.Value    = ALLTRIM(loc_oBO.this_cMess)
1624:             loc_oPagina.txt_4c_Anos.Value    = ALLTRIM(loc_oBO.this_cAnos)
1625:             loc_oPagina.txt_4c_Indivs.Value  = IIF(EMPTY(ALLTRIM(loc_oBO.this_cIndivs)), ;
1626:                                                     "N", UPPER(ALLTRIM(loc_oBO.this_cIndivs)))
1627:             loc_oPagina.txt_4c_Setors.Value  = ALLTRIM(loc_oBO.this_cSetors)
1628:             loc_oPagina.txt_4c_Adics.Value   = loc_oBO.this_nAdics
1629:             loc_oPagina.txt_4c_Minimos.Value = loc_oBO.this_nMinimos
1630:             loc_oPagina.txt_4c_MinExps.Value = loc_oBO.this_nMinExps
1631: 
1632:             loc_lResultado = .T.
1633:         CATCH TO loc_oErro
1634:             MsgErro("Erro em BOParaForm:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
1635:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
1636:             loc_lResultado = .F.
1637:         ENDTRY
1638: 
1639:         RETURN loc_lResultado
1640:     ENDPROC
1641: 
1642:     *==========================================================================
1643:     * FormParaBO - Valida campos da Page2 e transfere para o BO
1644:     * Retorna .T. se valido, .F. se ha erro de validacao
1645:     *==========================================================================
1646:     PROTECTED PROCEDURE FormParaBO()
1647:         LOCAL loc_lResultado, loc_oPagina, loc_oBO
1648:         LOCAL loc_cUsuars, loc_cMess, loc_cAnos, loc_cIndivs, loc_cSetors
1649:         LOCAL loc_cMsgDupI, loc_cMsgDupV
1650:         loc_lResultado = .F.
1651: 
1652:         TRY
1653:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1654:             loc_oBO     = THIS.this_oBusinessObject
1655: 
1656:             loc_cUsuars = UPPER(ALLTRIM(loc_oPagina.txt_4c_Usuars.Value))
1657:             loc_cMess   = PADL(ALLTRIM(loc_oPagina.txt_4c_Mess.Value),  2, "0")
1658:             loc_cAnos   = PADL(ALLTRIM(loc_oPagina.txt_4c_Anos.Value),  4, "0")
1659:             loc_cIndivs = UPPER(ALLTRIM(loc_oPagina.txt_4c_Indivs.Value))
1660:             loc_cSetors = UPPER(ALLTRIM(loc_oPagina.txt_4c_Setors.Value))
1661: 
1662:             IF EMPTY(loc_cUsuars)
1663:                 MsgAviso("Obrigat" + CHR(243) + "rio informar o Usu" + CHR(225) + "rio!!!", "")
1664:                 loc_oPagina.txt_4c_Usuars.SetFocus
1665:             ELSE
1666:                 IF EMPTY(loc_cMess) OR loc_cMess = "00" OR VAL(loc_cMess) = 0
1667:                 MsgAviso("Obrigat" + CHR(243) + "rio informar o M" + CHR(234) + ;
1668:                          "s de Refer" + CHR(234) + "ncia!!!", "")
1669:                 loc_oPagina.txt_4c_Mess.SetFocus
1670:             ELSE
1671:                 IF EMPTY(loc_cAnos) OR loc_cAnos = "0000" OR VAL(loc_cAnos) = 0
1672:                 MsgAviso("Obrigat" + CHR(243) + "rio informar o Ano de Refer" + CHR(234) + ;
1673:                          "ncia!!!", "")
1674:                 loc_oPagina.txt_4c_Anos.SetFocus
1675:             ELSE
1676:                 IF !EMPTY(loc_cIndivs) AND !INLIST(loc_cIndivs, "S", "N")
1677:                 MsgAviso("Vendedor deve ser S ou N!!!", "")
1678:                 loc_oPagina.txt_4c_Indivs.SetFocus
1679:             ELSE
1680:                 loc_oBO.this_cUsuars    = loc_cUsuars
1681:                 loc_oBO.this_cMess      = loc_cMess
1682:                 loc_oBO.this_cAnos      = loc_cAnos
1683:                 loc_oBO.this_cIndivs    = IIF(EMPTY(loc_cIndivs), "N", loc_cIndivs)
1684:                 loc_oBO.this_cSetors    = loc_cSetors
1685:                 loc_oBO.this_nAdics     = loc_oPagina.txt_4c_Adics.Value
1686:                 loc_oBO.this_nMinimos   = loc_oPagina.txt_4c_Minimos.Value
1687:                 loc_oBO.this_nMinExps   = loc_oPagina.txt_4c_MinExps.Value
1688: 
1689:                 loc_cMsgDupI = loc_oBO.ValidarDuplicidadeEmSigCcCmI()
1690:                 IF !EMPTY(loc_cMsgDupI)
1691:                     MsgAviso(loc_cMsgDupI, "")
1692:                 ELSE
1693:                     loc_cMsgDupV = loc_oBO.ValidarDuplicidadeEmSigCcCmV()
1694:                     IF !EMPTY(loc_cMsgDupV)
1695:                         MsgAviso(loc_cMsgDupV, "")
1696:                     ELSE
1697:                         loc_lResultado = .T.
1698:                     ENDIF
1699:                 ENDIF
1700:                 ENDIF
1701:                 ENDIF
1702:                 ENDIF
1703:             ENDIF
1704:         CATCH TO loc_oErro
1705:             MsgErro("Erro em FormParaBO:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
1706:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
1707:             loc_lResultado = .F.
1708:         ENDTRY
1709: 
1710:         RETURN loc_lResultado
1711:     ENDPROC
1712: 
1713:     *==========================================================================
1714:     * AbrirBuscaUsuars - Abre picker FormBuscaAuxiliar para SigCdUsu
1715:     *==========================================================================
1716:     PROCEDURE AbrirBuscaUsuars()
1717:         LOCAL loc_oPagina, loc_cValor, loc_oBusca
1718:         TRY
1719:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1720:             loc_cValor  = UPPER(ALLTRIM(loc_oPagina.txt_4c_Usuars.Value))
1721: 
1722:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1723:                                       "SigCdUsu", "cursor_4c_BuscaUsu", ;
1724:                                       "Usuarios", loc_cValor, ;
1725:                                       "Busca de Usu" + CHR(225) + "rios")
1726: 
1727:             IF VARTYPE(loc_oBusca) = "O"
1728:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1729:                     loc_oPagina.txt_4c_Usuars.Value = ALLTRIM(cursor_4c_BuscaUsu.Usuarios)
1730:                     THIS.PreencherPeriodoDoUsuario(ALLTRIM(cursor_4c_BuscaUsu.Usuarios))
1731:                 ELSE
1732:                     IF !loc_oBusca.this_lAchouRegistro
1733:                     loc_oBusca.mAddColuna("Usuarios", "", "Usu" + CHR(225) + "rio")
1734:                     loc_oBusca.mAddColuna("NComps",   "", "Nome")
1735:                     loc_oBusca.Show()
1736:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUsu")
1737:                         loc_oPagina.txt_4c_Usuars.Value = ALLTRIM(cursor_4c_BuscaUsu.Usuarios)
1738:                         THIS.PreencherPeriodoDoUsuario(ALLTRIM(cursor_4c_BuscaUsu.Usuarios))
1739:                     ENDIF
1740:                     ENDIF
1741:                 ENDIF
1742:                 loc_oBusca.Release()
1743:             ENDIF
1744: 
1745:             IF USED("cursor_4c_BuscaUsu")
1746:                 USE IN cursor_4c_BuscaUsu
1747:             ENDIF
1748:         CATCH TO loc_oErro
1749:             MsgErro("Erro em AbrirBuscaUsuars:" + CHR(13) + loc_oErro.Message, "Erro")
1750:             IF USED("cursor_4c_BuscaUsu")
1751:                 USE IN cursor_4c_BuscaUsu
1752:             ENDIF
1753:         ENDTRY
1754:     ENDPROC
1755: 
1756:     *==========================================================================
1757:     * TeclaLookupUsuars - Dispara AbrirBuscaUsuars com F4 ou F5
1758:     *==========================================================================
1759:     PROCEDURE TeclaLookupUsuars(par_nKeyCode, par_nShiftAltCtrl)
1760:         IF INLIST(par_nKeyCode, 115, 116)
1761:             THIS.AbrirBuscaUsuars()
1762:         ENDIF
1763:     ENDPROC
1764: 
1765:     *==========================================================================
1766:     * ValidarUsuars - Valida codigo de usuario ao sair do campo
1767:     *==========================================================================
1768:     PROCEDURE ValidarUsuars(par_nKeyCode, par_nShiftAltCtrl)
1769:         LOCAL loc_oPagina, loc_cValor, loc_cSQL, loc_nResultado
1770:         TRY
1771:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1772:             loc_cValor  = UPPER(ALLTRIM(loc_oPagina.txt_4c_Usuars.Value))
1773: 
1774:             IF EMPTY(loc_cValor)
1775:                 RETURN
1776:             ENDIF
1777: 
1778:             loc_cSQL       = "SELECT Usuars, NComps FROM SigCdUsu" + ;
1779:                              " WHERE Usuars = " + EscaparSQL(loc_cValor)
1780:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValUsu")
1781: 
1782:             IF loc_nResultado > 0 AND USED("cursor_4c_ValUsu") AND ;
1783:                RECCOUNT("cursor_4c_ValUsu") > 0
1784:                 loc_oPagina.txt_4c_Usuars.Value = ALLTRIM(cursor_4c_ValUsu.Usuars)
1785:                 THIS.PreencherPeriodoDoUsuario(ALLTRIM(cursor_4c_ValUsu.Usuars))
1786:             ELSE
1787:                 IF USED("cursor_4c_ValUsu")
1788:                     USE IN cursor_4c_ValUsu
1789:                 ENDIF
1790:                 *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
1791:                 THIS.AbrirBuscaUsuars()
1792:                 RETURN
1793:             ENDIF
1794: 
1795:             IF USED("cursor_4c_ValUsu")
1796:                 USE IN cursor_4c_ValUsu
1797:             ENDIF
1798:         CATCH TO loc_oErro
1799:             MsgErro("Erro em ValidarUsuars:" + CHR(13) + loc_oErro.Message, "Erro")
1800:             IF USED("cursor_4c_ValUsu")
1801:                 USE IN cursor_4c_ValUsu
1802:             ENDIF
1803:         ENDTRY
1804:     ENDPROC
1805: 
1806:     *==========================================================================
1807:     * PreencherPeriodoDoUsuario - Ao selecionar usuario sem periodo preenchido,
1808:     * carrega o ultimo periodo cadastrado para ele (auto-preenchimento)
1809:     *==========================================================================
1810:     PROTECTED PROCEDURE PreencherPeriodoDoUsuario(par_cUsuars)
1811:         LOCAL loc_oPagina
1812:         TRY
1813:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1814: 
1815:             IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Mess.Value)) OR ;
1816:                ALLTRIM(loc_oPagina.txt_4c_Mess.Value) = "00"
1817: 
1818:                 IF THIS.this_oBusinessObject.CarregarUltimoPeriodoUsuario(par_cUsuars)
1819:                     IF USED("cursor_4c_UltPer") AND RECCOUNT("cursor_4c_UltPer") > 0
1820:                         SELECT cursor_4c_UltPer
1821:                         loc_oPagina.txt_4c_Mess.Value   = ALLTRIM(cursor_4c_UltPer.mess)
1822:                         loc_oPagina.txt_4c_Anos.Value   = ALLTRIM(cursor_4c_UltPer.anos)
1823:                         loc_oPagina.txt_4c_Indivs.Value = IIF(EMPTY(cursor_4c_UltPer.indivs), ;
1824:                                                               "N", UPPER(cursor_4c_UltPer.indivs))
1825:                         loc_oPagina.txt_4c_Setors.Value  = ALLTRIM(cursor_4c_UltPer.setors)
1826:                         loc_oPagina.txt_4c_Adics.Value   = cursor_4c_UltPer.adics
1827:                         loc_oPagina.txt_4c_Minimos.Value = cursor_4c_UltPer.minimos
1828:                         loc_oPagina.txt_4c_MinExps.Value = cursor_4c_UltPer.minexps
1829:                     ENDIF
1830:                     IF USED("cursor_4c_UltPer")
1831:                         USE IN cursor_4c_UltPer
1832:                     ENDIF
1833:                 ENDIF
1834:             ENDIF
1835:         CATCH TO loc_oErro
1836:             MsgErro("Erro em PreencherPeriodoDoUsuario:" + CHR(13) + loc_oErro.Message, "Erro")
1837:             IF USED("cursor_4c_UltPer")
1838:                 USE IN cursor_4c_UltPer
1839:             ENDIF
1840:         ENDTRY
1841:     ENDPROC
1842: 
1843:     *==========================================================================
1844:     * AbrirBuscaSetors - Abre picker FormBuscaAuxiliar para SigCdCrg (Cargos)
1845:     *==========================================================================
1846:     PROCEDURE AbrirBuscaSetors()
1847:         LOCAL loc_oPagina, loc_cValor, loc_oBusca
1848:         TRY
1849:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1850:             loc_cValor  = UPPER(ALLTRIM(loc_oPagina.txt_4c_Setors.Value))
1851: 
1852:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1853:                                       "SigCdCrg", "cursor_4c_BuscaCrg", ;
1854:                                       "CCargs", loc_cValor, ;
1855:                                       "Busca de Cargos")
1856: 
1857:             IF VARTYPE(loc_oBusca) = "O"
1858:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1859:                     loc_oPagina.txt_4c_Setors.Value = ALLTRIM(cursor_4c_BuscaCrg.CCargs)
1860:                 ELSE
1861:                     IF !loc_oBusca.this_lAchouRegistro
1862:                     loc_oBusca.mAddColuna("CCargs", "", "Cargo")
1863:                     loc_oBusca.mAddColuna("DCargs", "", "Descri" + CHR(231) + CHR(227) + "o")
1864:                     loc_oBusca.Show()
1865:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCrg")
1866:                         loc_oPagina.txt_4c_Setors.Value = ALLTRIM(cursor_4c_BuscaCrg.CCargs)
1867:                     ENDIF
1868:                     ENDIF
1869:                 ENDIF
1870:                 loc_oBusca.Release()
1871:             ENDIF
1872: 
1873:             IF USED("cursor_4c_BuscaCrg")
1874:                 USE IN cursor_4c_BuscaCrg
1875:             ENDIF
1876:         CATCH TO loc_oErro
1877:             MsgErro("Erro em AbrirBuscaSetors:" + CHR(13) + loc_oErro.Message, "Erro")
1878:             IF USED("cursor_4c_BuscaCrg")
1879:                 USE IN cursor_4c_BuscaCrg
1880:             ENDIF
1881:         ENDTRY
1882:     ENDPROC
1883: 
1884:     *==========================================================================
1885:     * TeclaLookupSetors - Dispara AbrirBuscaSetors com F4 ou F5
1886:     *==========================================================================
1887:     PROCEDURE TeclaLookupSetors(par_nKeyCode, par_nShiftAltCtrl)
1888:         IF INLIST(par_nKeyCode, 115, 116)
1889:             THIS.AbrirBuscaSetors()
1890:         ENDIF
1891:     ENDPROC
1892: 
1893:     *==========================================================================
1894:     * ValidarSetors - Valida codigo de cargo ao sair do campo
1895:     *==========================================================================
1896:     PROCEDURE ValidarSetors(par_nKeyCode, par_nShiftAltCtrl)
1897:         LOCAL loc_oPagina, loc_cValor, loc_cSQL, loc_nResultado
1898:         TRY
1899:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1900:             loc_cValor  = UPPER(ALLTRIM(loc_oPagina.txt_4c_Setors.Value))
1901: 
1902:             IF EMPTY(loc_cValor)
1903:                 RETURN
1904:             ENDIF
1905: 
1906:             loc_cSQL       = "SELECT CCargs, DCargs FROM SigCdCrg" + ;
1907:                              " WHERE CCargs = " + EscaparSQL(loc_cValor)
1908:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValCrg")
1909: 
1910:             IF loc_nResultado > 0 AND USED("cursor_4c_ValCrg") AND ;
1911:                RECCOUNT("cursor_4c_ValCrg") > 0
1912:                 loc_oPagina.txt_4c_Setors.Value = ALLTRIM(cursor_4c_ValCrg.CCargs)
1913:             ELSE
1914:                 IF USED("cursor_4c_ValCrg")
1915:                     USE IN cursor_4c_ValCrg
1916:                 ENDIF
1917:                 *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
1918:                 THIS.AbrirBuscaSetors()
1919:                 RETURN
1920:             ENDIF
1921: 
1922:             IF USED("cursor_4c_ValCrg")
1923:                 USE IN cursor_4c_ValCrg
1924:             ENDIF
1925:         CATCH TO loc_oErro
1926:             MsgErro("Erro em ValidarSetors:" + CHR(13) + loc_oErro.Message, "Erro")
1927:             IF USED("cursor_4c_ValCrg")
1928:                 USE IN cursor_4c_ValCrg
1929:             ENDIF
1930:         ENDTRY
1931:     ENDPROC
1932: 
1933:     *==========================================================================
1934:     * Destroy - Libera recursos
1935:     *==========================================================================
1936:     PROCEDURE Destroy()
1937:         TRY
1938:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1939:                 THIS.this_oBusinessObject = .NULL.
1940:             ENDIF
1941: 
1942:             IF USED("crSigCcCmI")
1943:                 USE IN crSigCcCmI
1944:             ENDIF
1945:             IF USED("cursor_4c_VerifDest")
1946:                 USE IN cursor_4c_VerifDest
1947:             ENDIF
1948:             IF USED("cursor_4c_CopRes")
1949:                 USE IN cursor_4c_CopRes
1950:             ENDIF
1951:             IF USED("cursor_4c_BuscaUsu")
1952:                 USE IN cursor_4c_BuscaUsu
1953:             ENDIF
1954:             IF USED("cursor_4c_ValUsu")
1955:                 USE IN cursor_4c_ValUsu
1956:             ENDIF
1957:             IF USED("cursor_4c_BuscaCrg")
1958:                 USE IN cursor_4c_BuscaCrg
1959:             ENDIF
1960:             IF USED("cursor_4c_ValCrg")
1961:                 USE IN cursor_4c_ValCrg
1962:             ENDIF
1963:             IF USED("cursor_4c_UltPer")
1964:                 USE IN cursor_4c_UltPer
1965:             ENDIF
1966:         CATCH TO loc_oErro
1967:             *-- Ignorar erros no Destroy
1968:         ENDTRY
1969: 
1970:         DODEFAULT()
1971:     ENDPROC
1972: 
1973: ENDDEFINE


### BO (C:\4c\projeto\app\classes\CVEBO.prg):
*==============================================================================
* CVEBO.prg - Business Object para Comissoes de Vendedores por Cargos
* Tabela: SigCcCmI (Comissoes por Cargo - Inidividual)
* Chave:  cidchaves CHAR(20) - PK unica gerada por fUniqueIds()
*==============================================================================

DEFINE CLASS CVEBO AS BusinessBase

	*--------------------------------------------------------------------------
	* Propriedades da entidade (SigCcCmI)
	*--------------------------------------------------------------------------

	*-- PK
	this_cCidchaves  = ""  && cidchaves char(20) - chave prim" + CHR(225) + "ria UUID

	*-- Identificacao do usuario e periodo
	this_cUsuars     = ""  && usuars   char(10) - usu" + CHR(225) + "rio
	this_cMess       = ""  && mess     char(2)  - m" + CHR(234) + "s de refer" + CHR(234) + "ncia (01-12)
	this_cAnos       = ""  && anos     char(4)  - ano de refer" + CHR(234) + "ncia (0001-9999)
	this_cIndivs     = ""  && indivs   char(1)  - vendedor individual (S/N)

	*-- Cargo e supervisor
	this_cSetors     = ""  && setors   char(10) - c" + CHR(243) + "digo do cargo (FK SigCdCrg.CCargs)
	this_cSupervs    = ""  && supervs  char(10) - supervisor do setor

	*-- Valores de comiss" + CHR(227) + "o
	this_nAdics      = 0   && adics    numeric(5,2)  - adicional (%)
	this_nMinimos    = 0   && minimos  numeric(11,2) - valor m" + CHR(237) + "nimo
	this_nMinExps    = 0   && minexps  numeric(11,2) - experi" + CHR(234) + "ncia m" + CHR(237) + "nima

	*==========================================================================
	* Init - Configura tabela e campo-chave
	*==========================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigCcCmI"
		THIS.this_cCampoChave = "cidchaves"
		RETURN .T.
	ENDPROC

	*==========================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*==========================================================================
	PROCEDURE ObterChavePrimaria()
		RETURN THIS.this_cCidchaves
	ENDPROC

	*==========================================================================
	* CarregarDoCursor - Carrega propriedades a partir de um cursor
	*==========================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				THIS.this_cCidchaves = TratarNulo(cidchaves, "C")
				THIS.this_cUsuars    = TratarNulo(usuars,    "C")
				THIS.this_cMess      = TratarNulo(mess,      "C")
				THIS.this_cAnos      = TratarNulo(anos,      "C")
				THIS.this_cIndivs    = TratarNulo(indivs,    "C")
				THIS.this_cSetors    = TratarNulo(setors,    "C")
				THIS.this_cSupervs   = TratarNulo(supervs,   "C")
				THIS.this_nAdics     = TratarNulo(adics,     "N")
				THIS.this_nMinimos   = TratarNulo(minimos,   "N")
				THIS.this_nMinExps   = TratarNulo(minexps,   "N")
				loc_lResultado = .T.
			ENDIF
		CATCH TO loException
			MsgErro("Erro em CarregarDoCursor: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*==========================================================================
	* Buscar - Retorna registros de SigCcCmI filtrados por periodo
	* par_cFiltro: "MM/AAAA" ou "MM/MMFINAL-AAAA/AAAFINAL" ou "" (todos)
	*==========================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		LOCAL loc_cMesIni, loc_cMesFin, loc_cAnoIni, loc_cAnoFin
		loc_lSucesso = .F.

		TRY
			*-- Por default filtra pelo mes/ano atual
			loc_cMesIni = SUBSTR(DTOS(DATE()), 5, 2)
			loc_cMesFin = loc_cMesIni
			loc_cAnoIni = SUBSTR(DTOS(DATE()), 1, 4)
			loc_cAnoFin = loc_cAnoIni

			IF !EMPTY(par_cFiltro)
				*-- Aceita filtro no formato "MM/AAAA"
				IF LEN(ALLTRIM(par_cFiltro)) >= 7
					loc_cMesIni = LEFT(ALLTRIM(par_cFiltro), 2)
					loc_cMesFin = loc_cMesIni
					loc_cAnoIni = RIGHT(ALLTRIM(par_cFiltro), 4)
					loc_cAnoFin = loc_cAnoIni
				ENDIF
			ELSE
				*-- Sem filtro: trazer todos
				loc_cMesIni = "01"
				loc_cMesFin = "12"
				loc_cAnoIni = "0001"
				loc_cAnoFin = "9999"
			ENDIF

			loc_cSQL = "SELECT cidchaves, usuars, mess, anos, indivs," + ;
			           " setors, supervs, adics, minimos, minexps" + ;
			           " FROM SigCcCmI" + ;
			           " WHERE mess BETWEEN " + EscaparSQL(loc_cMesIni) + ;
			           " AND " + EscaparSQL(loc_cMesFin) + ;
			           " AND anos BETWEEN " + EscaparSQL(loc_cAnoIni) + ;
			           " AND " + EscaparSQL(loc_cAnoFin) + ;
			           " ORDER BY usuars, anos, mess"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCcCmI")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar comiss" + CHR(245) + "es: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em Buscar: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* BuscarComFiltroPeriodo - Busca com mes/ano de filtro explicitoS
	*==========================================================================
	PROCEDURE BuscarComFiltroPeriodo(par_cMesIni, par_cMesFin, par_cAnoIni, par_cAnoFin)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT cidchaves, usuars, mess, anos, indivs," + ;
			           " setors, supervs, adics, minimos, minexps" + ;
			           " FROM SigCcCmI" + ;
			           " WHERE mess BETWEEN " + EscaparSQL(par_cMesIni) + ;
			           " AND " + EscaparSQL(par_cMesFin) + ;
			           " AND anos BETWEEN " + EscaparSQL(par_cAnoIni) + ;
			           " AND " + EscaparSQL(par_cAnoFin) + ;
			           " ORDER BY usuars, anos, mess"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCcCmI")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar comiss" + CHR(245) + "es: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em BuscarComFiltroPeriodo: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* CarregarPorCodigo - Carrega comissao pela chave primaria (cidchaves)
	*==========================================================================
	PROCEDURE CarregarPorCodigo(par_cCidchaves)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT cidchaves, usuars, mess, anos, indivs," + ;
			           " setors, supervs, adics, minimos, minexps" + ;
			           " FROM SigCcCmI" + ;
			           " WHERE cidchaves = " + EscaparSQL(ALLTRIM(par_cCidchaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0
				IF RECCOUNT("cursor_4c_Carrega") > 0
					loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
					THIS.this_lNovoRegistro = .F.
				ENDIF
				IF USED("cursor_4c_Carrega")
					USE IN cursor_4c_Carrega
				ENDIF
			ELSE
				MsgErro("Erro ao carregar comiss" + CHR(227) + "o: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em CarregarPorCodigo: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* Inserir - Insere novo registro em SigCcCmI (PROTECTED)
	*==========================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			*-- Gerar UUID via SQL Server (fUniqueIds nao portada)
			IF EMPTY(THIS.this_cCidchaves)
				loc_nResultado = SQLEXEC(gnConnHandle, "SELECT NEWID() AS NovaChave", ;
				                         "cursor_4c_NovaChave")
				IF loc_nResultado >= 0 AND USED("cursor_4c_NovaChave") AND ;
				   RECCOUNT("cursor_4c_NovaChave") > 0
					THIS.this_cCidchaves = ALLTRIM(cursor_4c_NovaChave.NovaChave)
				ENDIF
				IF USED("cursor_4c_NovaChave")
					USE IN cursor_4c_NovaChave
				ENDIF
				IF EMPTY(THIS.this_cCidchaves)
					MsgErro("Erro ao gerar chave prim" + CHR(225) + "ria!", "Erro")
				ELSE
					loc_cSQL = "INSERT INTO SigCcCmI" + ;
					           " (cidchaves, usuars, mess, anos, indivs," + ;
					           "  setors, supervs, adics, minimos, minexps)" + ;
					           " VALUES (" + ;
					           EscaparSQL(THIS.this_cCidchaves) + ", " + ;
					           EscaparSQL(THIS.this_cUsuars)    + ", " + ;
					           EscaparSQL(THIS.this_cMess)      + ", " + ;
					           EscaparSQL(THIS.this_cAnos)      + ", " + ;
					           EscaparSQL(THIS.this_cIndivs)    + ", " + ;
					           EscaparSQL(THIS.this_cSetors)    + ", " + ;
					           EscaparSQL(THIS.this_cSupervs)   + ", " + ;
					           FormatarNumeroSQL(THIS.this_nAdics)   + ", " + ;
					           FormatarNumeroSQL(THIS.this_nMinimos) + ", " + ;
					           FormatarNumeroSQL(THIS.this_nMinExps) + ")"

					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResultado >= 0
						THIS.RegistrarAuditoria("INSERT")
						loc_lSucesso = .T.
					ELSE
						MsgErro("Erro ao inserir comiss" + CHR(227) + "o: " + CapturarErroSQL(), "Erro SQL")
					ENDIF
				ENDIF
			ELSE
				loc_cSQL = "INSERT INTO SigCcCmI" + ;
				           " (cidchaves, usuars, mess, anos, indivs," + ;
				           "  setors, supervs, adics, minimos, minexps)" + ;
				           " VALUES (" + ;
				           EscaparSQL(THIS.this_cCidchaves) + ", " + ;
				           EscaparSQL(THIS.this_cUsuars)    + ", " + ;
				           EscaparSQL(THIS.this_cMess)      + ", " + ;
				           EscaparSQL(THIS.this_cAnos)      + ", " + ;
				           EscaparSQL(THIS.this_cIndivs)    + ", " + ;
				           EscaparSQL(THIS.this_cSetors)    + ", " + ;
				           EscaparSQL(THIS.this_cSupervs)   + ", " + ;
				           FormatarNumeroSQL(THIS.this_nAdics)   + ", " + ;
				           FormatarNumeroSQL(THIS.this_nMinimos) + ", " + ;
				           FormatarNumeroSQL(THIS.this_nMinExps) + ")"

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
				IF loc_nResultado >= 0
					THIS.RegistrarAuditoria("INSERT")
					loc_lSucesso = .T.
				ELSE
					MsgErro("Erro ao inserir comiss" + CHR(227) + "o: " + CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF
		CATCH TO loException
			MsgErro("Erro em Inserir: " + loException.Message, "Erro")
			IF USED("cursor_4c_NovaChave")
				USE IN cursor_4c_NovaChave
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* Atualizar - Atualiza registro em SigCcCmI (PROTECTED)
	*==========================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SigCcCmI SET" + ;
			           "  usuars  = " + EscaparSQL(THIS.this_cUsuars)            + ", " + ;
			           "  mess    = " + EscaparSQL(THIS.this_cMess)              + ", " + ;
			           "  anos    = " + EscaparSQL(THIS.this_cAnos)              + ", " + ;
			           "  indivs  = " + EscaparSQL(THIS.this_cIndivs)            + ", " + ;
			           "  setors  = " + EscaparSQL(THIS.this_cSetors)            + ", " + ;
			           "  supervs = " + EscaparSQL(THIS.this_cSupervs)           + ", " + ;
			           "  adics   = " + FormatarNumeroSQL(THIS.this_nAdics)      + ", " + ;
			           "  minimos = " + FormatarNumeroSQL(THIS.this_nMinimos)    + ", " + ;
			           "  minexps = " + FormatarNumeroSQL(THIS.this_nMinExps)    + ;
			           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar comiss" + CHR(227) + "o: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em Atualizar: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* ExecutarExclusao - Exclui registro de SigCcCmI (PROTECTED)
	*==========================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCcCmI" + ;
			           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir comiss" + CHR(227) + "o: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em ExecutarExclusao: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* ValidarDuplicidadeEmSigCcCmI - Verifica se usuario ja existe no periodo
	* Retorna "" se ok, mensagem de erro se duplicado
	*==========================================================================
	PROCEDURE ValidarDuplicidadeEmSigCcCmI()
		LOCAL loc_cSQL, loc_nResultado, loc_cErro
		loc_cErro = ""

		TRY
			loc_cSQL = "SELECT cidchaves, usuars, mess, anos" + ;
			           " FROM SigCcCmI" + ;
			           " WHERE usuars = " + EscaparSQL(THIS.this_cUsuars) + ;
			           " AND mess = " + EscaparSQL(THIS.this_cMess) + ;
			           " AND anos = " + EscaparSQL(THIS.this_cAnos) + ;
			           " AND cidchaves <> " + EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupI")
			IF loc_nResultado >= 0
				IF RECCOUNT("cursor_4c_DupI") > 0
					loc_cErro = "Usu" + CHR(225) + "rio J" + CHR(225) + ;
					            " Cadastrado No Per" + CHR(237) + "odo!!!"
				ENDIF
				IF USED("cursor_4c_DupI")
					USE IN cursor_4c_DupI
				ENDIF
			ENDIF
		CATCH TO loException
			MsgErro("Erro em ValidarDuplicidadeEmSigCcCmI: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_cErro
	ENDPROC

	*==========================================================================
	* ValidarDuplicidadeEmSigCcCmV - Verifica se usuario ja existe em SigCcCmV
	* (tabela de vendedores individuais) para o mesmo periodo
	*==========================================================================
	PROCEDURE ValidarDuplicidadeEmSigCcCmV()
		LOCAL loc_cSQL, loc_nResultado, loc_cErro
		loc_cErro = ""

		TRY
			loc_cSQL = "SELECT cidchaves, usuars, mess, anos" + ;
			           " FROM SigCcCmV" + ;
			           " WHERE usuars = " + EscaparSQL(THIS.this_cUsuars) + ;
			           " AND mess = " + EscaparSQL(THIS.this_cMess) + ;
			           " AND anos = " + EscaparSQL(THIS.this_cAnos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupV")
			IF loc_nResultado >= 0
				IF RECCOUNT("cursor_4c_DupV") > 0
					loc_cErro = "Usu" + CHR(225) + "rio J" + CHR(225) + ;
					            " Cadastrado No Per" + CHR(237) + "odo Como Vendedor Individual!!!"
				ENDIF
				IF USED("cursor_4c_DupV")
					USE IN cursor_4c_DupV
				ENDIF
			ENDIF
		CATCH TO loException
			MsgErro("Erro em ValidarDuplicidadeEmSigCcCmV: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_cErro
	ENDPROC

	*==========================================================================
	* CarregarUltimoPeriodoUsuario - Carrega o ultimo periodo cadastrado para
	* o usuario (usado para auto-preencher o periodo seguinte em novos registros)
	*==========================================================================
	PROCEDURE CarregarUltimoPeriodoUsuario(par_cUsuars)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT TOP 1 cidchaves, usuars, mess, anos, indivs," + ;
			           " setors, supervs, adics, minimos, minexps" + ;
			           " FROM SigCcCmI" + ;
			           " WHERE usuars = " + EscaparSQL(ALLTRIM(par_cUsuars)) + ;
			           " ORDER BY anos DESC, mess DESC"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UltPer")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_UltPer") > 0
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MsgErro("Erro em CarregarUltimoPeriodoUsuario: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* CopiarPeriodo - Copia registros de um periodo para outro
	* par_cMesOri/par_cAnoOri: periodo de origem
	* par_cMesDes/par_cAnoDes: periodo de destino
	* Retorna .T. se copiou registros, .F. caso contrario
	*==========================================================================
	PROCEDURE CopiarPeriodo(par_cMesOri, par_cAnoOri, par_cMesDes, par_cAnoDes)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_lInseriu, loc_lOk
		LOCAL loc_cNovaChave, loc_cErroCopia
		loc_lSucesso = .F.
		loc_lInseriu = .F.
		loc_lOk      = .T.

		TRY
			*-- Busca registros do periodo de origem
			loc_cSQL = "SELECT cidchaves, usuars, mess, anos, indivs," + ;
			           " setors, supervs, adics, minimos, minexps" + ;
			           " FROM SigCcCmI" + ;
			           " WHERE mess = " + EscaparSQL(par_cMesOri) + ;
			           " AND anos = " + EscaparSQL(par_cAnoOri) + ;
			           " ORDER BY usuars"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Origem")
			IF loc_nResultado < 0
				MsgErro("Erro ao buscar per" + CHR(237) + "odo de origem: " + CapturarErroSQL(), "Erro SQL")
			ELSE
				IF RECCOUNT("cursor_4c_Origem") = 0
					MsgAviso("Nenhum Vendedor Est" + CHR(225) + " Cadastrado no Per" + ;
					        CHR(237) + "odo de Origem Informado!!!", "")
				ELSE
					SELECT cursor_4c_Origem
					GO TOP
					SCAN
						*-- Verifica se vendedor ja existe no periodo destino
						loc_cSQL = "SELECT cidchaves FROM SigCcCmI" + ;
						           " WHERE usuars = " + EscaparSQL(cursor_4c_Origem.usuars) + ;
						           " AND mess = " + EscaparSQL(par_cMesDes) + ;
						           " AND anos = " + EscaparSQL(par_cAnoDes)

						loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Busca")
						IF loc_nResultado >= 0
							IF RECCOUNT("cursor_4c_Busca") = 0
								*-- Insere novo registro no periodo destino
								loc_cNovaChave = fUniqueIds()
								loc_cSQL = "INSERT INTO SigCcCmI" + ;
								           " (cidchaves, usuars, mess, anos, indivs," + ;
								           "  setors, supervs, adics, minimos, minexps)" + ;
								           " VALUES (" + ;
								           EscaparSQL(loc_cNovaChave)                    + ", " + ;
								           EscaparSQL(cursor_4c_Origem.usuars)           + ", " + ;
								           EscaparSQL(par_cMesDes)                       + ", " + ;
								           EscaparSQL(par_cAnoDes)                       + ", " + ;
								           EscaparSQL(cursor_4c_Origem.indivs)           + ", " + ;
								           EscaparSQL(cursor_4c_Origem.setors)           + ", " + ;
								           EscaparSQL(cursor_4c_Origem.supervs)          + ", " + ;
								           FormatarNumeroSQL(cursor_4c_Origem.adics)     + ", " + ;
								           FormatarNumeroSQL(cursor_4c_Origem.minimos)   + ", " + ;
								           FormatarNumeroSQL(cursor_4c_Origem.minexps)   + ")"

								loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
								IF loc_nResultado >= 0
									loc_lInseriu = .T.
								ELSE
									loc_lOk = .F.
								ENDIF
							ENDIF
							IF USED("cursor_4c_Busca")
								USE IN cursor_4c_Busca
							ENDIF
						ELSE
							loc_lOk = .F.
						ENDIF
					ENDSCAN

					loc_lSucesso = loc_lInseriu AND loc_lOk
				ENDIF
			ENDIF

			IF USED("cursor_4c_Origem")
				USE IN cursor_4c_Origem
			ENDIF
		CATCH TO loException
			MsgErro("Erro em CopiarPeriodo: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

