# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_BOTOESACAO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCVE.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1954 linhas total):

*-- Linhas 31 a 172:
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
70:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
71:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
72:                     THIS.pgf_4c_Paginas.Visible = .T.
73:                     THIS.pgf_4c_Paginas.ActivePage = 1
74:                     THIS.this_cModoAtual = "LISTA"
75: 
76:                     IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
77:                         THIS.CarregarLista()
78:                     ENDIF
79: 
80:                     loc_lResultado = .T.
81:                 ENDIF
82:             ENDIF
83:         CATCH TO loc_oErro
84:             MsgErro("Erro em InicializarForm:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
85:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
86:                     "Procedure: " + loc_oErro.Procedure, "Erro")
87:             loc_lResultado = .F.
88:         ENDTRY
89: 
90:         RETURN loc_lResultado
91:     ENDPROC
92: 
93:     *==========================================================================
94:     * ConfigurarPageFrame - Cria PageFrame com 2 paginas
95:     *==========================================================================
96:     PROTECTED PROCEDURE ConfigurarPageFrame()
97:         TRY
98:             THIS.AddObject("pgf_4c_Paginas", "PageFrame")
99: 
100:             WITH THIS.pgf_4c_Paginas
101:                 .PageCount = 2
102:                 .Top       = -29
103:                 .Left      = 0
104:                 .Width     = THIS.Width
105:                 .Height    = THIS.Height + 29
106:                 .Tabs      = .F.
107:                 .FontName  = "Tahoma"
108:                 .FontSize  = 8
109:                 .Page1.Caption   = "Lista"
110:                 .Page1.BackColor = RGB(100, 100, 100)
111:                 .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
112:                 .Page2.Caption   = "Dados"
113:                 .Page2.BackColor = RGB(100, 100, 100)
114:                 .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
115:                 .Visible = .T.
116:             ENDWITH
117: 
118:             THIS.ConfigurarPaginaLista()
119:             THIS.ConfigurarPaginaDados()
120: 
121:         CATCH TO loc_oErro
122:             MsgErro("Erro em ConfigurarPageFrame:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
123:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
124:         ENDTRY
125:     ENDPROC
126: 
127:     *==========================================================================
128:     * ConfigurarPaginaLista - Page1 completa:
129:     *   Cabecalho, Botoes CRUD, Encerrar, Filtro de Periodo,
130:     *   Botao Copia, Container Copia flutuante, Grid
131:     *==========================================================================
132:     PROTECTED PROCEDURE ConfigurarPaginaLista()
133:         LOCAL loc_oPagina, loc_cCaption, loc_oGrid
134:         loc_oPagina  = THIS.pgf_4c_Paginas.Page1
135: 
136:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
137:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
138:         loc_cCaption = THIS.Caption
139: 
140:         TRY
141:             *-- Cabecalho (Top=2+29=31)
142:             loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
143:             WITH loc_oPagina.cnt_4c_Cabecalho
144:                 .Top         = 31
145:                 .Left        = 0
146:                 .Width       = THIS.Width
147:                 .Height      = 80
148:                 .BackColor   = RGB(100, 100, 100)
149:                 .BorderWidth = 0
150:                 .Visible     = .T.
151: 
152:                 .AddObject("lbl_4c_Sombra", "Label")
153:                 WITH .lbl_4c_Sombra
154:                     .Caption   = loc_cCaption
155:                     .Top       = 15
156:                     .Left      = 10
157:                     .Width     = THIS.Width
158:                     .Height    = 40
159:                     .FontName  = "Tahoma"
160:                     .FontSize  = 16
161:                     .FontBold  = .T.
162:                     .ForeColor = RGB(0, 0, 0)
163:                     .BackStyle = 0
164:                     .AutoSize  = .F.
165:                     .Visible   = .T.
166:                 ENDWITH
167: 
168:                 .AddObject("lbl_4c_Titulo", "Label")
169:                 WITH .lbl_4c_Titulo
170:                     .Caption   = loc_cCaption
171:                     .Top       = 18
172:                     .Left      = 10

*-- Linhas 309 a 392:
309:                 ENDWITH
310:             ENDWITH
311: 
312:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
313:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
314:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
315:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
316:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
317: 
318:             *-- Encerrar - padrao canonico (CLAUDE.md Regra #10)
319:             loc_oPagina.AddObject("cnt_4c_Saida", "Container")
320:             WITH loc_oPagina.cnt_4c_Saida
321:                 .Top         = 29
322:                 .Left        = 917
323:                 .Width       = 90
324:                 .Height      = 85
325:                 .BackStyle   = 0
326:                 .BorderWidth = 0
327:                 .Visible     = .T.
328: 
329:                 .AddObject("cmd_4c_Encerrar", "CommandButton")
330:                 WITH .cmd_4c_Encerrar
331:                     .Caption         = "Encerrar"
332:                     .Top             = 5
333:                     .Left            = 917
334:                     .Width           = 75
335:                     .Height          = 75
336:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
337:                     .PicturePosition = 13
338:                     .FontName        = "Tahoma"
339:                     .FontSize        = 8
340:                     .FontBold        = .T.
341:                     .FontItalic      = .T.
342:                     .ForeColor       = RGB(90, 90, 90)
343:                     .BackColor       = RGB(255, 255, 255)
344:                     .SpecialEffect   = 0
345:                     .MousePointer    = 15
346:                     .WordWrap        = .T.
347:                     .AutoSize        = .F.
348:                     .Visible         = .T.
349:                 ENDWITH
350:             ENDWITH
351: 
352:             BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
353: 
354:             *-- Filtro Periodo (top=119+29=148)
355:             loc_oPagina.AddObject("cnt_4c_Filtro", "Container")
356:             WITH loc_oPagina.cnt_4c_Filtro
357:                 .Top         = 148
358:                 .Left        = 11
359:                 .Width       = 162
360:                 .Height      = 33
361:                 .BackStyle   = 0
362:                 .BorderWidth = 0
363:                 .Visible     = .T.
364: 
365:                 .AddObject("lbl_4c_Periodo", "Label")
366:                 WITH .lbl_4c_Periodo
367:                     .Caption   = "Per" + CHR(237) + "odo :"
368:                     .Top       = 9
369:                     .Left      = 23
370:                     .Width     = 50
371:                     .Height    = 15
372:                     .FontName  = "Tahoma"
373:                     .FontSize  = 8
374:                     .ForeColor = RGB(255, 255, 255)
375:                     .BackStyle = 0
376:                     .Visible   = .T.
377:                 ENDWITH
378: 
379:                 .AddObject("txt_4c_FiltroMess", "TextBox")
380:                 WITH .txt_4c_FiltroMess
381:                     .Value     = PADL(ALLTRIM(STR(MONTH(DATE()))), 2, "0")
382:                     .Top       = 6
383:                     .Left      = 71
384:                     .Width     = 24
385:                     .Height    = 23
386:                     .InputMask = "99"
387:                     .FontName  = "Tahoma"
388:                     .FontSize  = 8
389:                     .Visible   = .T.
390:                 ENDWITH
391: 
392:                 .AddObject("lbl_4c_Barra", "Label")

*-- Linhas 417 a 482:
417:                 ENDWITH
418:             ENDWITH
419: 
420:             BINDEVENT(loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroMess, "KeyPress", THIS, "FiltroMesLostFocus")
421:             BINDEVENT(loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroAnos, "KeyPress", THIS, "FiltroAnosLostFocus")
422: 
423:             *-- Botao Copia de Periodo (top=91+29=120, left=347)
424:             loc_oPagina.AddObject("cmd_4c_Copia", "CommandButton")
425:             WITH loc_oPagina.cmd_4c_Copia
426:                 .Caption       = "C" + CHR(243) + "pia"
427:                 .Top           = 120
428:                 .Left          = 347
429:                 .Width         = 105
430:                 .Height        = 45
431:                 .FontName      = "Tahoma"
432:                 .FontSize      = 8
433:                 .FontBold      = .T.
434:                 .ForeColor     = RGB(90, 90, 90)
435:                 .BackColor     = RGB(255, 255, 255)
436:                 .Themes        = .T.
437:                 .SpecialEffect = 0
438:                 .MousePointer  = 15
439:                 .Visible       = .T.
440:             ENDWITH
441: 
442:             BINDEVENT(loc_oPagina.cmd_4c_Copia, "Click", THIS, "BtnCopiarClick")
443: 
444:             *-- Container flutuante Copia de Periodo (top=264+29=293, inicia oculto)
445:             loc_oPagina.AddObject("cnt_4c_Copia", "Container")
446:             WITH loc_oPagina.cnt_4c_Copia
447:                 .Top         = 293
448:                 .Left        = 226
449:                 .Width       = 348
450:                 .Height      = 77
451:                 .BackColor   = RGB(240, 240, 240)
452:                 .BackStyle   = 1
453:                 .BorderWidth = 1
454:                 .Visible     = .F.
455: 
456:                 .AddObject("lbl_4c_TituloCopia", "Label")
457:                 WITH .lbl_4c_TituloCopia
458:                     .Caption   = "C" + CHR(243) + "pia de Per" + CHR(237) + "odo"
459:                     .Top       = 5
460:                     .Left      = 8
461:                     .Width     = 150
462:                     .Height    = 15
463:                     .FontName  = "Tahoma"
464:                     .FontSize  = 8
465:                     .FontBold  = .T.
466:                     .ForeColor = RGB(0, 0, 0)
467:                     .BackStyle = 0
468:                     .Visible   = .T.
469:                 ENDWITH
470: 
471:                 .AddObject("lbl_4c_Origem", "Label")
472:                 WITH .lbl_4c_Origem
473:                     .Caption   = "Per" + CHR(237) + "odo de Origem :"
474:                     .Top       = 27
475:                     .Left      = 28
476:                     .Width     = 97
477:                     .Height    = 15
478:                     .FontName  = "Tahoma"
479:                     .FontSize  = 8
480:                     .ForeColor = RGB(0, 0, 0)
481:                     .BackStyle = 0
482:                     .Visible   = .T.

*-- Linhas 607 a 651:
607:                 ENDWITH
608:             ENDWITH
609: 
610:             BINDEVENT(loc_oPagina.cnt_4c_Copia.cmd_4c_OkCopia,       "Click", THIS, "BtnOkCopiaClick")
611:             BINDEVENT(loc_oPagina.cnt_4c_Copia.cmd_4c_CancelarCopia, "Click", THIS, "BtnCancelarCopiaClick")
612: 
613:             *-- Grid (top=185, left=11)
614:             loc_oPagina.AddObject("grd_4c_Lista", "Grid")
615: 
616:             loc_oGrid             = loc_oPagina.grd_4c_Lista
617:             loc_oGrid.ColumnCount = 8
618: 
619:             WITH loc_oGrid
620:                 .Top                = 185
621:                 .Left               = 11
622:                 .Width              = 895
623:                 .Height             = 390
624:                 .FontName           = "Tahoma"
625:                 .FontSize           = 8
626:                 .ForeColor          = RGB(90, 90, 90)
627:                 .BackColor          = RGB(255, 255, 255)
628:                 .GridLineColor      = RGB(238, 238, 238)
629:                 .HighlightBackColor = RGB(255, 255, 255)
630:                 .HighlightForeColor = RGB(15, 41, 104)
631:                 .HighlightStyle     = 2
632:                 .DeleteMark         = .F.
633:                 .RecordMark         = .F.
634:                 .RowHeight          = 16
635:                 .ScrollBars         = 2
636:                 .GridLines          = 3
637:                 .Visible            = .T.
638: 
639:                 WITH .Column1
640:                     .Width           = 110
641:                     .Header1.Caption = "Usu" + CHR(225) + "rio"
642:                 ENDWITH
643:                 WITH .Column2
644:                     .Width           = 35
645:                     .Header1.Caption = "M" + CHR(234) + "s"
646:                 ENDWITH
647:                 WITH .Column3
648:                     .Width           = 45
649:                     .Header1.Caption = "Ano"
650:                 ENDWITH
651:                 WITH .Column4

*-- Linhas 673 a 729:
673:                 ENDWITH
674:             ENDWITH
675: 
676:             THIS.TornarControlesVisiveis(loc_oPagina)
677: 
678:         CATCH TO loc_oErro
679:             MsgErro("Erro em ConfigurarPaginaLista:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
680:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
681:         ENDTRY
682:     ENDPROC
683: 
684:     *==========================================================================
685:     * ConfigurarPaginaDados - Page2 com todos os campos de SigCcCmI
686:     *   Usuars (lookup SigCdUsu), Mess, Anos, Indivs, Setors (lookup SigCdCrg),
687:     *   Adics, Minimos, MinExps + botoes Confirmar/Cancelar
688:     *==========================================================================
689:     PROTECTED PROCEDURE ConfigurarPaginaDados()
690:         LOCAL loc_oPagina
691:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
692: 
693:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
694:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
695: 
696:         TRY
697:             *-- Botoes Acao: Confirmar e Cancelar
698:             loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
699:             WITH loc_oPagina.cnt_4c_BotoesAcao
700:                 .Top         = 33
701:                 .Left        = 842
702:                 .Width       = 160
703:                 .Height      = 85
704:                 .BackStyle   = 0
705:                 .BorderWidth = 0
706:                 .Visible     = .T.
707: 
708:                 .AddObject("cmd_4c_Confirmar", "CommandButton")
709:                 WITH .cmd_4c_Confirmar
710:                     .Caption         = "Confirmar"
711:                     .Top             = 5
712:                     .Left            = 5
713:                     .Width           = 75
714:                     .Height          = 75
715:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
716:                     .PicturePosition = 13
717:                     .FontName        = "Tahoma"
718:                     .FontSize        = 8
719:                     .FontBold        = .T.
720:                     .FontItalic      = .T.
721:                     .ForeColor       = RGB(90, 90, 90)
722:                     .BackColor       = RGB(255, 255, 255)
723:                     .SpecialEffect   = 0
724:                     .MousePointer    = 15
725:                     .WordWrap        = .T.
726:                     .AutoSize        = .F.
727:                     .Visible         = .T.
728:                 ENDWITH
729: 

*-- Linhas 751 a 829:
751:                 ENDWITH
752:             ENDWITH
753: 
754:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
755:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
756: 
757:             *-- Label: Usu?rio (layout top=179 +29=208)
758:             loc_oPagina.AddObject("lbl_4c_Usuars", "Label")
759:             WITH loc_oPagina.lbl_4c_Usuars
760:                 .Caption   = "Usu" + CHR(225) + "rio :"
761:                 .Top       = 208
762:                 .Left      = 248
763:                 .Width     = 54
764:                 .Height    = 15
765:                 .FontName  = "Tahoma"
766:                 .FontSize  = 8
767:                 .ForeColor = RGB(255, 255, 255)
768:                 .BackStyle = 0
769:                 .AutoSize  = .F.
770:                 .Visible   = .T.
771:             ENDWITH
772: 
773:             *-- TextBox: Usu?rio (layout top=176 +29=205)
774:             loc_oPagina.AddObject("txt_4c_Usuars", "TextBox")
775:             WITH loc_oPagina.txt_4c_Usuars
776:                 .Value     = ""
777:                 .Top       = 205
778:                 .Left      = 311
779:                 .Width     = 80
780:                 .Height    = 23
781:                 .MaxLength = 10
782:                 .FontName  = "Tahoma"
783:                 .FontSize  = 8
784:                 .Visible   = .T.
785:             ENDWITH
786: 
787:             BINDEVENT(loc_oPagina.txt_4c_Usuars, "DblClick",  THIS, "AbrirBuscaUsuars")
788:             BINDEVENT(loc_oPagina.txt_4c_Usuars, "KeyPress",  THIS, "TeclaLookupUsuars")
789:             BINDEVENT(loc_oPagina.txt_4c_Usuars, "KeyPress", THIS, "ValidarUsuars")
790: 
791:             *-- Label: Per?odo (layout top=204 +29=233)
792:             loc_oPagina.AddObject("lbl_4c_Periodo2", "Label")
793:             WITH loc_oPagina.lbl_4c_Periodo2
794:                 .Caption   = "Per" + CHR(237) + "odo :"
795:                 .Top       = 233
796:                 .Left      = 248
797:                 .Width     = 54
798:                 .Height    = 15
799:                 .FontName  = "Tahoma"
800:                 .FontSize  = 8
801:                 .ForeColor = RGB(255, 255, 255)
802:                 .BackStyle = 0
803:                 .AutoSize  = .F.
804:                 .Visible   = .T.
805:             ENDWITH
806: 
807:             *-- TextBox: M?s Per?odo (layout top=201 +29=230)
808:             loc_oPagina.AddObject("txt_4c_Mess", "TextBox")
809:             WITH loc_oPagina.txt_4c_Mess
810:                 .Value     = ""
811:                 .Top       = 230
812:                 .Left      = 311
813:                 .Width     = 24
814:                 .Height    = 23
815:                 .InputMask = "99"
816:                 .MaxLength = 2
817:                 .FontName  = "Tahoma"
818:                 .FontSize  = 8
819:                 .Visible   = .T.
820:             ENDWITH
821: 
822:             *-- Separador "/" entre M?s e Ano (layout top=202 +29=231)
823:             loc_oPagina.AddObject("lbl_4c_BarraMesAno", "Label")
824:             WITH loc_oPagina.lbl_4c_BarraMesAno
825:                 .Caption   = "/"
826:                 .Top       = 231
827:                 .Left      = 340
828:                 .Width     = 8
829:                 .Height    = 15

*-- Linhas 925 a 970:
925:                 .Visible   = .T.
926:             ENDWITH
927: 
928:             BINDEVENT(loc_oPagina.txt_4c_Setors, "DblClick",  THIS, "AbrirBuscaSetors")
929:             BINDEVENT(loc_oPagina.txt_4c_Setors, "KeyPress",  THIS, "TeclaLookupSetors")
930:             BINDEVENT(loc_oPagina.txt_4c_Setors, "KeyPress", THIS, "ValidarSetors")
931: 
932:             *-- Label: Adicional (layout top=278 +29=307)
933:             loc_oPagina.AddObject("lbl_4c_Adics", "Label")
934:             WITH loc_oPagina.lbl_4c_Adics
935:                 .Caption   = "Adicional :"
936:                 .Top       = 307
937:                 .Left      = 240
938:                 .Width     = 62
939:                 .Height    = 15
940:                 .FontName  = "Tahoma"
941:                 .FontSize  = 8
942:                 .ForeColor = RGB(255, 255, 255)
943:                 .BackStyle = 0
944:                 .AutoSize  = .F.
945:                 .Visible   = .T.
946:             ENDWITH
947: 
948:             *-- TextBox: Adicional % (layout top=275 +29=304)
949:             loc_oPagina.AddObject("txt_4c_Adics", "TextBox")
950:             WITH loc_oPagina.txt_4c_Adics
951:                 .Value    = 0.00
952:                 .Top      = 304
953:                 .Left     = 311
954:                 .Width    = 52
955:                 .Height   = 23
956:                 .FontName = "Tahoma"
957:                 .FontSize = 8
958:                 .Visible  = .T.
959:             ENDWITH
960: 
961:             *-- Label: % (layout top=280 +29=309)
962:             loc_oPagina.AddObject("lbl_4c_PctAdics", "Label")
963:             WITH loc_oPagina.lbl_4c_PctAdics
964:                 .Caption   = "%"
965:                 .Top       = 309
966:                 .Left      = 368
967:                 .Width     = 14
968:                 .Height    = 15
969:                 .FontName  = "Tahoma"
970:                 .FontSize  = 8

*-- Linhas 1031 a 1163:
1031:                 .Visible  = .T.
1032:             ENDWITH
1033: 
1034:             THIS.TornarControlesVisiveis(loc_oPagina)
1035:         CATCH TO loc_oErro
1036:             MsgErro("Erro em ConfigurarPaginaDados:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
1037:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
1038:         ENDTRY
1039:     ENDPROC
1040: 
1041:     *==========================================================================
1042:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
1043:     * Containers excluidos (mantem Visible original):
1044:     *   cnt_4c_Copia      - container flutuante de copia de periodo (inicia oculto)
1045:     *   cnt_4c_Cabecalho  - cabecalho cinza (Visible gerenciado por ConfigurarPaginaLista)
1046:     *   cnt_4c_BotoesAcao - botoes Confirmar/Cancelar (Visible gerenciado por HabilitarCampos)
1047:     *==========================================================================
1048:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1049:         LOCAL loc_nI, loc_oObjeto, loc_cNome, loc_nP
1050: 
1051:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1052:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1053: 
1054:             IF VARTYPE(loc_oObjeto) = "O"
1055:                 loc_cNome = UPPER(loc_oObjeto.Name)
1056: 
1057:                 IF INLIST(loc_cNome, "CNT_4C_COPIA", "CNT_4C_CABECALHO", "CNT_4C_BOTOESACAO")
1058:                     IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1059:                         THIS.TornarControlesVisiveis(loc_oObjeto)
1060:                     ENDIF
1061:                     LOOP
1062:                 ENDIF
1063: 
1064:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1065:                     loc_oObjeto.Visible = .T.
1066:                 ENDIF
1067: 
1068:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1069:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1070:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1071:                     ENDFOR
1072:                 ENDIF
1073: 
1074:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1075:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1076:                 ENDIF
1077:             ENDIF
1078:         ENDFOR
1079:     ENDPROC
1080: 
1081:     *==========================================================================
1082:     * FormatarGridLista - Formata visual do grid
1083:     *==========================================================================
1084:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1085:         WITH par_oGrid
1086:             .FontName = "Tahoma"
1087:             .FontSize = 8
1088:         ENDWITH
1089:     ENDPROC
1090: 
1091:     *==========================================================================
1092:     * AlternarPagina - Alterna entre Page1 (1=Lista) e Page2 (2=Dados)
1093:     *==========================================================================
1094:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1095:         LOCAL loc_lResultado
1096:         loc_lResultado = .F.
1097: 
1098:         TRY
1099:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
1100:                 loc_lResultado = .F.
1101:             ELSE
1102:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1103: 
1104:                 IF par_nPagina = 1
1105:                     THIS.this_cModoAtual = "LISTA"
1106:                     THIS.CarregarLista()
1107:                 ENDIF
1108: 
1109:                 loc_lResultado = .T.
1110:             ENDIF
1111:         CATCH TO loc_oErro
1112:             MsgErro("Erro em AlternarPagina:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
1113:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
1114:             loc_lResultado = .F.
1115:         ENDTRY
1116: 
1117:         RETURN loc_lResultado
1118:     ENDPROC
1119: 
1120:     *==========================================================================
1121:     * CarregarLista - Carrega grid com dados de SigCcCmI filtrados por periodo
1122:     *==========================================================================
1123:     PROCEDURE CarregarLista()
1124:         LOCAL loc_lResultado, loc_cSQL, loc_nResult
1125:         LOCAL loc_cMesI, loc_cMesF, loc_cAnoI, loc_cAnoF
1126:         LOCAL loc_oPagina, loc_oGrid
1127:         loc_lResultado = .F.
1128: 
1129:         TRY
1130:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1131:                 loc_lResultado = .T.
1132:             ELSE
1133:                 loc_oPagina = THIS.pgf_4c_Paginas.Page1
1134:                 loc_oGrid   = loc_oPagina.grd_4c_Lista
1135: 
1136:                 loc_cMesI = PADL(ALLTRIM(loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroMess.Value), 2, "0")
1137:                 loc_cAnoI = PADL(ALLTRIM(loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroAnos.Value), 4, "0")
1138:                 loc_cMesF = IIF(loc_cMesI = "00", "12", loc_cMesI)
1139:                 loc_cAnoF = IIF(loc_cAnoI = "0000", "9999", loc_cAnoI)
1140: 
1141:                 IF USED("crSigCcCmI")
1142:                     USE IN crSigCcCmI
1143:                 ENDIF
1144: 
1145:                 loc_cSQL = "SELECT cIdChaves, Usuars, Mess, Anos, Indivs, Setors," + ;
1146:                            " Adics, Minimos, MinExps" + ;
1147:                            " FROM SigCcCmI" + ;
1148:                            " WHERE Mess BETWEEN " + EscaparSQL(loc_cMesI) + ;
1149:                            " AND " + EscaparSQL(loc_cMesF) + ;
1150:                            " AND Anos BETWEEN " + EscaparSQL(loc_cAnoI) + ;
1151:                            " AND " + EscaparSQL(loc_cAnoF) + ;
1152:                            " ORDER BY Anos, Mess, Usuars, Setors"
1153: 
1154:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCcCmI")
1155: 
1156:                 IF loc_nResult < 0
1157:                     MsgErro("Erro ao carregar comiss" + CHR(245) + "es:" + CHR(13) + ;
1158:                             CapturarErroSQL(), "Erro SQL")
1159:                 ELSE
1160:                     loc_oGrid.RecordSource           = "crSigCcCmI"
1161:                     loc_oGrid.Column1.ControlSource  = "crSigCcCmI.Usuars"
1162:                     loc_oGrid.Column2.ControlSource  = "crSigCcCmI.Mess"
1163:                     loc_oGrid.Column3.ControlSource  = "crSigCcCmI.Anos"

*-- Linhas 1205 a 1500:
1205:     *==========================================================================
1206:     * FiltroMesLostFocus - Ao sair do campo mes, padroniza e foca ano
1207:     *==========================================================================
1208:     PROCEDURE FiltroMesLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1209:         LOCAL loc_oPagina
1210:         TRY
1211:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
1212:             loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroMess.Value = ;
1213:                 PADL(ALLTRIM(loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroMess.Value), 2, "0")
1214:             loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroAnos.SetFocus
1215:         CATCH TO loc_oErro
1216:             MsgErro("Erro em FiltroMesLostFocus:" + CHR(13) + loc_oErro.Message, "Erro")
1217:         ENDTRY
1218:     ENDPROC
1219: 
1220:     *==========================================================================
1221:     * FiltroAnosLostFocus - Ao sair do campo ano, padroniza e recarrega grid
1222:     *==========================================================================
1223:     PROCEDURE FiltroAnosLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1224:         LOCAL loc_oPagina
1225:         TRY
1226:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
1227:             loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroAnos.Value = ;
1228:                 PADL(ALLTRIM(loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroAnos.Value), 4, "0")
1229:             THIS.CarregarLista()
1230:         CATCH TO loc_oErro
1231:             MsgErro("Erro em FiltroAnosLostFocus:" + CHR(13) + loc_oErro.Message, "Erro")
1232:         ENDTRY
1233:     ENDPROC
1234: 
1235:     *==========================================================================
1236:     * BtnIncluirClick - Prepara novo registro e navega para Page2
1237:     *==========================================================================
1238:     PROCEDURE BtnIncluirClick()
1239:         TRY
1240:             THIS.this_oBusinessObject.NovoRegistro()
1241:             THIS.this_cModoAtual = "INCLUIR"
1242:             THIS.LimparCampos()
1243:             THIS.HabilitarCampos(.T.)
1244:             THIS.AjustarBotoesPorModo()
1245:             THIS.AlternarPagina(2)
1246:             THIS.pgf_4c_Paginas.Page2.txt_4c_Usuars.SetFocus
1247:         CATCH TO loc_oErro
1248:             MsgErro("Erro em BtnIncluirClick:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
1249:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
1250:         ENDTRY
1251:     ENDPROC
1252: 
1253:     *==========================================================================
1254:     * BtnAlterarClick - Carrega registro selecionado e navega para Page2
1255:     *==========================================================================
1256:     PROCEDURE BtnAlterarClick()
1257:         LOCAL loc_cChave
1258:         TRY
1259:             IF !USED("crSigCcCmI") OR EOF("crSigCcCmI") OR RECCOUNT("crSigCcCmI") = 0
1260:                 MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
1261:             ELSE
1262:                 SELECT crSigCcCmI
1263:                 loc_cChave = ALLTRIM(crSigCcCmI.cIdChaves)
1264: 
1265:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1266:                     THIS.this_oBusinessObject.EditarRegistro()
1267:                     THIS.this_cModoAtual = "ALTERAR"
1268:                     THIS.BOParaForm()
1269:                     THIS.HabilitarCampos(.T.)
1270:                     THIS.AjustarBotoesPorModo()
1271:                     THIS.AlternarPagina(2)
1272:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Indivs.SetFocus
1273:                 ELSE
1274:                     MsgErro("Erro ao carregar registro para altera" + CHR(231) + CHR(227) + "o!", "Erro")
1275:                 ENDIF
1276:             ENDIF
1277:         CATCH TO loc_oErro
1278:             MsgErro("Erro em BtnAlterarClick:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
1279:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
1280:         ENDTRY
1281:     ENDPROC
1282: 
1283:     *==========================================================================
1284:     * BtnVisualizarClick - Carrega registro em modo somente leitura
1285:     *==========================================================================
1286:     PROCEDURE BtnVisualizarClick()
1287:         LOCAL loc_cChave
1288:         TRY
1289:             IF !USED("crSigCcCmI") OR EOF("crSigCcCmI") OR RECCOUNT("crSigCcCmI") = 0
1290:                 MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
1291:             ELSE
1292:                 SELECT crSigCcCmI
1293:                 loc_cChave = ALLTRIM(crSigCcCmI.cIdChaves)
1294: 
1295:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1296:                     THIS.this_cModoAtual = "VISUALIZAR"
1297:                     THIS.BOParaForm()
1298:                     THIS.HabilitarCampos(.F.)
1299:                     THIS.AjustarBotoesPorModo()
1300:                     THIS.AlternarPagina(2)
1301:                 ELSE
1302:                     MsgErro("Erro ao carregar registro para visualiza" + CHR(231) + CHR(227) + "o!", "Erro")
1303:                 ENDIF
1304:             ENDIF
1305:         CATCH TO loc_oErro
1306:             MsgErro("Erro em BtnVisualizarClick:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
1307:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
1308:         ENDTRY
1309:     ENDPROC
1310: 
1311:     *==========================================================================
1312:     * BtnExcluirClick - Confirma e exclui registro selecionado
1313:     *==========================================================================
1314:     PROCEDURE BtnExcluirClick()
1315:         LOCAL loc_cChave, loc_lConfirma
1316:         TRY
1317:             IF !USED("crSigCcCmI") OR EOF("crSigCcCmI") OR RECCOUNT("crSigCcCmI") = 0
1318:                 MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
1319:             ELSE
1320:                 SELECT crSigCcCmI
1321:                 loc_cChave   = ALLTRIM(crSigCcCmI.cIdChaves)
1322:                 loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro?", ;
1323:                                             "Excluir")
1324: 
1325:                 IF loc_lConfirma
1326:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1327:                         IF THIS.this_oBusinessObject.Excluir()
1328:                             MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "")
1329:                             THIS.CarregarLista()
1330:                         ELSE
1331:                             MsgErro("Erro ao excluir registro!", "Erro")
1332:                         ENDIF
1333:                     ELSE
1334:                         MsgErro("Erro ao carregar registro para exclus" + CHR(227) + "o!", "Erro")
1335:                     ENDIF
1336:                 ENDIF
1337:             ENDIF
1338:         CATCH TO loc_oErro
1339:             MsgErro("Erro em BtnExcluirClick:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
1340:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
1341:         ENDTRY
1342:     ENDPROC
1343: 
1344:     *==========================================================================
1345:     * BtnBuscarClick - Recarrega grid com filtro atual
1346:     *==========================================================================
1347:     PROCEDURE BtnBuscarClick()
1348:         TRY
1349:             THIS.CarregarLista()
1350:             IF USED("crSigCcCmI") AND !EOF("crSigCcCmI")
1351:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.SetFocus
1352:             ENDIF
1353:         CATCH TO loc_oErro
1354:             MsgErro("Erro em BtnBuscarClick:" + CHR(13) + loc_oErro.Message, "Erro")
1355:         ENDTRY
1356:     ENDPROC
1357: 
1358:     *==========================================================================
1359:     * BtnEncerrarClick - Fecha o formulario
1360:     *==========================================================================
1361:     PROCEDURE BtnEncerrarClick()
1362:         TRY
1363:             THIS.Release()
1364:         CATCH TO loc_oErro
1365:             *-- Ignorar erros ao fechar
1366:         ENDTRY
1367:     ENDPROC
1368: 
1369:     *==========================================================================
1370:     * BtnSalvarClick - Valida e salva registro
1371:     *==========================================================================
1372:     PROCEDURE BtnSalvarClick()
1373:         IF !THIS.FormParaBO()
1374:             RETURN
1375:         ENDIF
1376: 
1377:         TRY
1378:             IF THIS.this_oBusinessObject.Salvar()
1379:                 MsgInfo("Registro salvo com sucesso!", "")
1380:                 THIS.AlternarPagina(1)
1381:             ELSE
1382:                 MsgErro("Erro ao salvar registro!", "Erro")
1383:             ENDIF
1384:         CATCH TO loc_oErro
1385:             MsgErro("Erro em BtnSalvarClick:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
1386:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
1387:         ENDTRY
1388:     ENDPROC
1389: 
1390:     *==========================================================================
1391:     * BtnCancelarClick - Cancela edicao e volta para lista
1392:     *==========================================================================
1393:     PROCEDURE BtnCancelarClick()
1394:         TRY
1395:             THIS.AlternarPagina(1)
1396:         CATCH TO loc_oErro
1397:             MsgErro("Erro em BtnCancelarClick:" + CHR(13) + loc_oErro.Message, "Erro")
1398:         ENDTRY
1399:     ENDPROC
1400: 
1401:     *==========================================================================
1402:     * BtnCopiarClick - Mostra container de copia de periodo
1403:     *==========================================================================
1404:     PROCEDURE BtnCopiarClick()
1405:         LOCAL loc_oPagina
1406:         TRY
1407:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
1408: 
1409:             loc_oPagina.grd_4c_Lista.Enabled  = .F.
1410:             loc_oPagina.cnt_4c_Botoes.Enabled = .F.
1411:             loc_oPagina.cnt_4c_Saida.Enabled  = .F.
1412:             loc_oPagina.cmd_4c_Copia.Enabled  = .F.
1413: 
1414:             WITH loc_oPagina.cnt_4c_Copia
1415:                 .txt_4c_OMess.Value = ""
1416:                 .txt_4c_OAnos.Value = ""
1417:                 .txt_4c_DMess.Value = ""
1418:                 .txt_4c_DAnos.Value = ""
1419:                 .Visible = .T.
1420:                 .ZOrder(0)
1421:                 .txt_4c_OMess.SetFocus
1422:             ENDWITH
1423:         CATCH TO loc_oErro
1424:             MsgErro("Erro em BtnCopiarClick:" + CHR(13) + loc_oErro.Message, "Erro")
1425:         ENDTRY
1426:     ENDPROC
1427: 
1428:     *==========================================================================
1429:     * BtnOkCopiaClick - Executa copia de todos os registros do periodo origem
1430:     *                   para o periodo destino no SQL Server
1431:     *==========================================================================
1432:     PROCEDURE BtnOkCopiaClick()
1433:         LOCAL loc_oPagina, loc_cOMess, loc_cDMess, loc_cOAnos, loc_cDAnos
1434:         LOCAL loc_nResult, loc_cSQL, loc_lCopiar
1435:         loc_lCopiar = .F.
1436: 
1437:         TRY
1438:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
1439: 
1440:             loc_cOMess = PADL(ALLTRIM(loc_oPagina.cnt_4c_Copia.txt_4c_OMess.Value), 2, "0")
1441:             loc_cOAnos = PADL(ALLTRIM(loc_oPagina.cnt_4c_Copia.txt_4c_OAnos.Value), 4, "0")
1442:             loc_cDMess = PADL(ALLTRIM(loc_oPagina.cnt_4c_Copia.txt_4c_DMess.Value), 2, "0")
1443:             loc_cDAnos = PADL(ALLTRIM(loc_oPagina.cnt_4c_Copia.txt_4c_DAnos.Value), 4, "0")
1444: 
1445:             IF EMPTY(loc_cOMess) OR loc_cOMess = "00" OR VAL(loc_cOMess) = 0
1446:                 MsgAviso("Obrigat" + CHR(243) + "rio informar o M" + CHR(234) + ;
1447:                          "s de Origem!", "")
1448:                 loc_oPagina.cnt_4c_Copia.txt_4c_OMess.SetFocus
1449:             ELSE
1450:                 IF EMPTY(loc_cOAnos) OR loc_cOAnos = "0000" OR VAL(loc_cOAnos) = 0
1451:                 MsgAviso("Obrigat" + CHR(243) + "rio informar o Ano de Origem!", "")
1452:                 loc_oPagina.cnt_4c_Copia.txt_4c_OAnos.SetFocus
1453:             ELSE
1454:                 IF EMPTY(loc_cDMess) OR loc_cDMess = "00" OR VAL(loc_cDMess) = 0
1455:                 MsgAviso("Obrigat" + CHR(243) + "rio informar o M" + CHR(234) + ;
1456:                          "s de Destino!", "")
1457:                 loc_oPagina.cnt_4c_Copia.txt_4c_DMess.SetFocus
1458:             ELSE
1459:                 IF EMPTY(loc_cDAnos) OR loc_cDAnos = "0000" OR VAL(loc_cDAnos) = 0
1460:                 MsgAviso("Obrigat" + CHR(243) + "rio informar o Ano de Destino!", "")
1461:                 loc_oPagina.cnt_4c_Copia.txt_4c_DAnos.SetFocus
1462:             ELSE
1463:                 *-- Verificar se destino ja tem registros
1464:                 loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCcCmI" + ;
1465:                            " WHERE Mess = " + EscaparSQL(loc_cDMess) + ;
1466:                            " AND Anos = " + EscaparSQL(loc_cDAnos)
1467: 
1468:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerifDest")
1469: 
1470:                 IF loc_nResult >= 0 AND USED("cursor_4c_VerifDest") AND ;
1471:                    cursor_4c_VerifDest.Total > 0
1472:                     IF MsgConfirma("O per" + CHR(237) + "odo de destino j" + CHR(225) + ;
1473:                                    " possui registros. Deseja sobrepor?", "Confirmar")
1474:                         loc_lCopiar = .T.
1475:                     ENDIF
1476:                 ELSE
1477:                     loc_lCopiar = .T.
1478:                 ENDIF
1479: 
1480:                 IF USED("cursor_4c_VerifDest")
1481:                     USE IN cursor_4c_VerifDest
1482:                 ENDIF
1483: 
1484:                 IF loc_lCopiar
1485:                     loc_cSQL = "INSERT INTO SigCcCmI" + ;
1486:                                " (cIdChaves, Usuars, Indivs, Setors, Adics, Minimos, MinExps," + ;
1487:                                " Mess, Anos)" + ;
1488:                                " SELECT NEWID(), Usuars, Indivs, Setors, Adics, Minimos, MinExps," + ;
1489:                                " " + EscaparSQL(loc_cDMess) + ", " + EscaparSQL(loc_cDAnos) + ;
1490:                                " FROM SigCcCmI" + ;
1491:                                " WHERE Mess = " + EscaparSQL(loc_cOMess) + ;
1492:                                " AND Anos = " + EscaparSQL(loc_cOAnos) + ;
1493:                                " AND NOT EXISTS (" + ;
1494:                                "   SELECT 1 FROM SigCcCmI d" + ;
1495:                                "   WHERE d.Mess = " + EscaparSQL(loc_cDMess) + ;
1496:                                "   AND d.Anos = " + EscaparSQL(loc_cDAnos) + ;
1497:                                "   AND d.Usuars = SigCcCmI.Usuars)"
1498: 
1499:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CopRes")
1500: 

*-- Linhas 1530 a 1954:
1530:     *==========================================================================
1531:     * BtnCancelarCopiaClick - Oculta container de copia e reabilita area
1532:     *==========================================================================
1533:     PROCEDURE BtnCancelarCopiaClick()
1534:         LOCAL loc_oPagina
1535:         TRY
1536:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
1537: 
1538:             loc_oPagina.cnt_4c_Copia.Visible  = .F.
1539:             loc_oPagina.grd_4c_Lista.Enabled  = .T.
1540:             loc_oPagina.cnt_4c_Botoes.Enabled = .T.
1541:             loc_oPagina.cnt_4c_Saida.Enabled  = .T.
1542:             loc_oPagina.cmd_4c_Copia.Enabled  = .T.
1543: 
1544:             IF USED("crSigCcCmI")
1545:                 loc_oPagina.grd_4c_Lista.SetFocus
1546:             ENDIF
1547:         CATCH TO loc_oErro
1548:             MsgErro("Erro em BtnCancelarCopiaClick:" + CHR(13) + loc_oErro.Message, "Erro")
1549:         ENDTRY
1550:     ENDPROC
1551: 
1552:     *==========================================================================
1553:     * LimparCampos - Limpa todos os campos da Page2
1554:     *==========================================================================
1555:     PROTECTED PROCEDURE LimparCampos()
1556:         LOCAL loc_oPagina
1557:         TRY
1558:             THIS.this_oBusinessObject.NovoRegistro()
1559:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1560:             loc_oPagina.txt_4c_Usuars.Value  = ""
1561:             loc_oPagina.txt_4c_Mess.Value    = ""
1562:             loc_oPagina.txt_4c_Anos.Value    = ""
1563:             loc_oPagina.txt_4c_Indivs.Value  = "N"
1564:             loc_oPagina.txt_4c_Setors.Value  = ""
1565:             loc_oPagina.txt_4c_Adics.Value   = 0.00
1566:             loc_oPagina.txt_4c_Minimos.Value = 0.00
1567:             loc_oPagina.txt_4c_MinExps.Value = 0.00
1568:         CATCH TO loc_oErro
1569:             MsgErro("Erro em LimparCampos:" + CHR(13) + loc_oErro.Message, "Erro")
1570:         ENDTRY
1571:     ENDPROC
1572: 
1573:     *==========================================================================
1574:     * HabilitarCampos - Habilita ou desabilita todos os campos editaveis da Page2
1575:     *==========================================================================
1576:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1577:         LOCAL loc_oPagina
1578:         TRY
1579:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1580:             loc_oPagina.txt_4c_Usuars.Enabled  = par_lHabilitar
1581:             loc_oPagina.txt_4c_Mess.Enabled    = par_lHabilitar
1582:             loc_oPagina.txt_4c_Anos.Enabled    = par_lHabilitar
1583:             loc_oPagina.txt_4c_Indivs.Enabled  = par_lHabilitar
1584:             loc_oPagina.txt_4c_Setors.Enabled  = par_lHabilitar
1585:             loc_oPagina.txt_4c_Adics.Enabled   = par_lHabilitar
1586:             loc_oPagina.txt_4c_Minimos.Enabled = par_lHabilitar
1587:             loc_oPagina.txt_4c_MinExps.Enabled = par_lHabilitar
1588:             WITH loc_oPagina.cnt_4c_BotoesAcao
1589:                 .cmd_4c_Confirmar.Enabled = par_lHabilitar
1590:                 .Visible     = .T.
1591:             ENDWITH
1592:         CATCH TO loc_oErro
1593:             MsgErro("Erro em HabilitarCampos:" + CHR(13) + loc_oErro.Message, "Erro")
1594:         ENDTRY
1595:     ENDPROC
1596: 
1597:     *==========================================================================
1598:     * AjustarBotoesPorModo - Ajusta estado dos botoes da Page2 conforme modo
1599:     *==========================================================================
1600:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1601:         LOCAL loc_oPagina, loc_lEditar
1602:         TRY
1603:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1604:             loc_lEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1605: 
1606:             WITH loc_oPagina.cnt_4c_BotoesAcao
1607:                 .cmd_4c_Confirmar.Enabled = loc_lEditar
1608:                 .cmd_4c_Cancelar.Enabled  = .T.
1609:                 .Visible     = .T.
1610:             ENDWITH
1611:         CATCH TO loc_oErro
1612:             MsgErro("Erro em AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message, "Erro")
1613:         ENDTRY
1614:     ENDPROC
1615: 
1616:     *==========================================================================
1617:     * BOParaForm - Transfere propriedades do BO para os campos da Page2
1618:     *==========================================================================
1619:     PROTECTED PROCEDURE BOParaForm()
1620:         LOCAL loc_lResultado, loc_oPagina, loc_oBO
1621:         loc_lResultado = .F.
1622: 
1623:         TRY
1624:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1625:             loc_oBO     = THIS.this_oBusinessObject
1626: 
1627:             loc_oPagina.txt_4c_Usuars.Value  = ALLTRIM(loc_oBO.this_cUsuars)
1628:             loc_oPagina.txt_4c_Mess.Value    = ALLTRIM(loc_oBO.this_cMess)
1629:             loc_oPagina.txt_4c_Anos.Value    = ALLTRIM(loc_oBO.this_cAnos)
1630:             loc_oPagina.txt_4c_Indivs.Value  = IIF(EMPTY(ALLTRIM(loc_oBO.this_cIndivs)), ;
1631:                                                     "N", UPPER(ALLTRIM(loc_oBO.this_cIndivs)))
1632:             loc_oPagina.txt_4c_Setors.Value  = ALLTRIM(loc_oBO.this_cSetors)
1633:             loc_oPagina.txt_4c_Adics.Value   = loc_oBO.this_nAdics
1634:             loc_oPagina.txt_4c_Minimos.Value = loc_oBO.this_nMinimos
1635:             loc_oPagina.txt_4c_MinExps.Value = loc_oBO.this_nMinExps
1636: 
1637:             loc_lResultado = .T.
1638:         CATCH TO loc_oErro
1639:             MsgErro("Erro em BOParaForm:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
1640:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
1641:             loc_lResultado = .F.
1642:         ENDTRY
1643: 
1644:         RETURN loc_lResultado
1645:     ENDPROC
1646: 
1647:     *==========================================================================
1648:     * FormParaBO - Valida campos da Page2 e transfere para o BO
1649:     * Retorna .T. se valido, .F. se ha erro de validacao
1650:     *==========================================================================
1651:     PROTECTED PROCEDURE FormParaBO()
1652:         LOCAL loc_lResultado, loc_oPagina, loc_oBO
1653:         LOCAL loc_cUsuars, loc_cMess, loc_cAnos, loc_cIndivs, loc_cSetors
1654:         LOCAL loc_cMsgDupI, loc_cMsgDupV
1655:         loc_lResultado = .F.
1656: 
1657:         TRY
1658:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1659:             loc_oBO     = THIS.this_oBusinessObject
1660: 
1661:             loc_cUsuars = UPPER(ALLTRIM(loc_oPagina.txt_4c_Usuars.Value))
1662:             loc_cMess   = PADL(ALLTRIM(loc_oPagina.txt_4c_Mess.Value),  2, "0")
1663:             loc_cAnos   = PADL(ALLTRIM(loc_oPagina.txt_4c_Anos.Value),  4, "0")
1664:             loc_cIndivs = UPPER(ALLTRIM(loc_oPagina.txt_4c_Indivs.Value))
1665:             loc_cSetors = UPPER(ALLTRIM(loc_oPagina.txt_4c_Setors.Value))
1666: 
1667:             IF EMPTY(loc_cUsuars)
1668:                 MsgAviso("Obrigat" + CHR(243) + "rio informar o Usu" + CHR(225) + "rio!!!", "")
1669:                 loc_oPagina.txt_4c_Usuars.SetFocus
1670:             ELSE
1671:                 IF EMPTY(loc_cMess) OR loc_cMess = "00" OR VAL(loc_cMess) = 0
1672:                 MsgAviso("Obrigat" + CHR(243) + "rio informar o M" + CHR(234) + ;
1673:                          "s de Refer" + CHR(234) + "ncia!!!", "")
1674:                 loc_oPagina.txt_4c_Mess.SetFocus
1675:             ELSE
1676:                 IF EMPTY(loc_cAnos) OR loc_cAnos = "0000" OR VAL(loc_cAnos) = 0
1677:                 MsgAviso("Obrigat" + CHR(243) + "rio informar o Ano de Refer" + CHR(234) + ;
1678:                          "ncia!!!", "")
1679:                 loc_oPagina.txt_4c_Anos.SetFocus
1680:             ELSE
1681:                 IF !EMPTY(loc_cIndivs) AND !INLIST(loc_cIndivs, "S", "N")
1682:                 MsgAviso("Vendedor deve ser S ou N!!!", "")
1683:                 loc_oPagina.txt_4c_Indivs.SetFocus
1684:             ELSE
1685:                 loc_oBO.this_cUsuars    = loc_cUsuars
1686:                 loc_oBO.this_cMess      = loc_cMess
1687:                 loc_oBO.this_cAnos      = loc_cAnos
1688:                 loc_oBO.this_cIndivs    = IIF(EMPTY(loc_cIndivs), "N", loc_cIndivs)
1689:                 loc_oBO.this_cSetors    = loc_cSetors
1690:                 loc_oBO.this_nAdics     = loc_oPagina.txt_4c_Adics.Value
1691:                 loc_oBO.this_nMinimos   = loc_oPagina.txt_4c_Minimos.Value
1692:                 loc_oBO.this_nMinExps   = loc_oPagina.txt_4c_MinExps.Value
1693: 
1694:                 loc_cMsgDupI = loc_oBO.ValidarDuplicidadeEmSigCcCmI()
1695:                 IF !EMPTY(loc_cMsgDupI)
1696:                     MsgAviso(loc_cMsgDupI, "")
1697:                 ELSE
1698:                     loc_cMsgDupV = loc_oBO.ValidarDuplicidadeEmSigCcCmV()
1699:                     IF !EMPTY(loc_cMsgDupV)
1700:                         MsgAviso(loc_cMsgDupV, "")
1701:                     ELSE
1702:                         loc_lResultado = .T.
1703:                     ENDIF
1704:                 ENDIF
1705:                 ENDIF
1706:                 ENDIF
1707:                 ENDIF
1708:             ENDIF
1709:         CATCH TO loc_oErro
1710:             MsgErro("Erro em FormParaBO:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
1711:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
1712:             loc_lResultado = .F.
1713:         ENDTRY
1714: 
1715:         RETURN loc_lResultado
1716:     ENDPROC
1717: 
1718:     *==========================================================================
1719:     * AbrirBuscaUsuars - Abre picker FormBuscaAuxiliar para SigCdUsu
1720:     *==========================================================================
1721:     PROCEDURE AbrirBuscaUsuars()
1722:         LOCAL loc_oPagina, loc_cValor, loc_oBusca
1723:         TRY
1724:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1725:             loc_cValor  = UPPER(ALLTRIM(loc_oPagina.txt_4c_Usuars.Value))
1726: 
1727:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1728:                                       "SigCdUsu", "cursor_4c_BuscaUsu", ;
1729:                                       "Usuarios", loc_cValor, ;
1730:                                       "Busca de Usu" + CHR(225) + "rios")
1731: 
1732:             IF VARTYPE(loc_oBusca) = "O"
1733:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1734:                     loc_oPagina.txt_4c_Usuars.Value = ALLTRIM(cursor_4c_BuscaUsu.Usuarios)
1735:                     THIS.PreencherPeriodoDoUsuario(ALLTRIM(cursor_4c_BuscaUsu.Usuarios))
1736:                 ELSE
1737:                     IF !loc_oBusca.this_lAchouRegistro
1738:                     loc_oBusca.mAddColuna("Usuarios", "", "Usu" + CHR(225) + "rio")
1739:                     loc_oBusca.mAddColuna("NComps",   "", "Nome")
1740:                     loc_oBusca.Show()
1741:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUsu")
1742:                         loc_oPagina.txt_4c_Usuars.Value = ALLTRIM(cursor_4c_BuscaUsu.Usuarios)
1743:                         THIS.PreencherPeriodoDoUsuario(ALLTRIM(cursor_4c_BuscaUsu.Usuarios))
1744:                     ENDIF
1745:                     ENDIF
1746:                 ENDIF
1747:                 loc_oBusca.Release()
1748:             ENDIF
1749: 
1750:             IF USED("cursor_4c_BuscaUsu")
1751:                 USE IN cursor_4c_BuscaUsu
1752:             ENDIF
1753:         CATCH TO loc_oErro
1754:             MsgErro("Erro em AbrirBuscaUsuars:" + CHR(13) + loc_oErro.Message, "Erro")
1755:             IF USED("cursor_4c_BuscaUsu")
1756:                 USE IN cursor_4c_BuscaUsu
1757:             ENDIF
1758:         ENDTRY
1759:     ENDPROC
1760: 
1761:     *==========================================================================
1762:     * TeclaLookupUsuars - Dispara AbrirBuscaUsuars com F4 ou F5
1763:     *==========================================================================
1764:     PROCEDURE TeclaLookupUsuars(par_nKeyCode, par_nShiftAltCtrl)
1765:         IF INLIST(par_nKeyCode, 115, 116)
1766:             THIS.AbrirBuscaUsuars()
1767:         ENDIF
1768:     ENDPROC
1769: 
1770:     *==========================================================================
1771:     * ValidarUsuars - Valida codigo de usuario ao sair do campo
1772:     *==========================================================================
1773:     PROCEDURE ValidarUsuars(par_nKeyCode, par_nShiftAltCtrl)
1774:         LOCAL loc_oPagina, loc_cValor, loc_cSQL, loc_nResultado
1775:         TRY
1776:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1777:             loc_cValor  = UPPER(ALLTRIM(loc_oPagina.txt_4c_Usuars.Value))
1778: 
1779:             IF EMPTY(loc_cValor)
1780:                 RETURN
1781:             ENDIF
1782: 
1783:             loc_cSQL       = "SELECT Usuars, NComps FROM SigCdUsu" + ;
1784:                              " WHERE Usuars = " + EscaparSQL(loc_cValor)
1785:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValUsu")
1786: 
1787:             IF loc_nResultado > 0 AND USED("cursor_4c_ValUsu") AND ;
1788:                RECCOUNT("cursor_4c_ValUsu") > 0
1789:                 loc_oPagina.txt_4c_Usuars.Value = ALLTRIM(cursor_4c_ValUsu.Usuars)
1790:                 THIS.PreencherPeriodoDoUsuario(ALLTRIM(cursor_4c_ValUsu.Usuars))
1791:             ELSE
1792:                 IF USED("cursor_4c_ValUsu")
1793:                     USE IN cursor_4c_ValUsu
1794:                 ENDIF
1795:                 *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
1796:                 THIS.AbrirBuscaUsuars()
1797:                 RETURN
1798:             ENDIF
1799: 
1800:             IF USED("cursor_4c_ValUsu")
1801:                 USE IN cursor_4c_ValUsu
1802:             ENDIF
1803:         CATCH TO loc_oErro
1804:             MsgErro("Erro em ValidarUsuars:" + CHR(13) + loc_oErro.Message, "Erro")
1805:             IF USED("cursor_4c_ValUsu")
1806:                 USE IN cursor_4c_ValUsu
1807:             ENDIF
1808:         ENDTRY
1809:     ENDPROC
1810: 
1811:     *==========================================================================
1812:     * PreencherPeriodoDoUsuario - Ao selecionar usuario sem periodo preenchido,
1813:     * carrega o ultimo periodo cadastrado para ele (auto-preenchimento)
1814:     *==========================================================================
1815:     PROTECTED PROCEDURE PreencherPeriodoDoUsuario(par_cUsuars)
1816:         LOCAL loc_oPagina
1817:         TRY
1818:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1819: 
1820:             IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Mess.Value)) OR ;
1821:                ALLTRIM(loc_oPagina.txt_4c_Mess.Value) = "00"
1822: 
1823:                 IF THIS.this_oBusinessObject.CarregarUltimoPeriodoUsuario(par_cUsuars)
1824:                     IF USED("cursor_4c_UltPer") AND RECCOUNT("cursor_4c_UltPer") > 0
1825:                         SELECT cursor_4c_UltPer
1826:                         loc_oPagina.txt_4c_Mess.Value   = ALLTRIM(cursor_4c_UltPer.mess)
1827:                         loc_oPagina.txt_4c_Anos.Value   = ALLTRIM(cursor_4c_UltPer.anos)
1828:                         loc_oPagina.txt_4c_Indivs.Value = IIF(EMPTY(cursor_4c_UltPer.indivs), ;
1829:                                                               "N", UPPER(cursor_4c_UltPer.indivs))
1830:                         loc_oPagina.txt_4c_Setors.Value  = ALLTRIM(cursor_4c_UltPer.setors)
1831:                         loc_oPagina.txt_4c_Adics.Value   = cursor_4c_UltPer.adics
1832:                         loc_oPagina.txt_4c_Minimos.Value = cursor_4c_UltPer.minimos
1833:                         loc_oPagina.txt_4c_MinExps.Value = cursor_4c_UltPer.minexps
1834:                     ENDIF
1835:                     IF USED("cursor_4c_UltPer")
1836:                         USE IN cursor_4c_UltPer
1837:                     ENDIF
1838:                 ENDIF
1839:             ENDIF
1840:         CATCH TO loc_oErro
1841:             MsgErro("Erro em PreencherPeriodoDoUsuario:" + CHR(13) + loc_oErro.Message, "Erro")
1842:             IF USED("cursor_4c_UltPer")
1843:                 USE IN cursor_4c_UltPer
1844:             ENDIF
1845:         ENDTRY
1846:     ENDPROC
1847: 
1848:     *==========================================================================
1849:     * AbrirBuscaSetors - Abre picker FormBuscaAuxiliar para SigCdCrg (Cargos)
1850:     *==========================================================================
1851:     PROCEDURE AbrirBuscaSetors()
1852:         LOCAL loc_oPagina, loc_cValor, loc_oBusca
1853:         TRY
1854:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1855:             loc_cValor  = UPPER(ALLTRIM(loc_oPagina.txt_4c_Setors.Value))
1856: 
1857:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1858:                                       "SigCdCrg", "cursor_4c_BuscaCrg", ;
1859:                                       "CCargs", loc_cValor, ;
1860:                                       "Busca de Cargos")
1861: 
1862:             IF VARTYPE(loc_oBusca) = "O"
1863:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1864:                     loc_oPagina.txt_4c_Setors.Value = ALLTRIM(cursor_4c_BuscaCrg.CCargs)
1865:                 ELSE
1866:                     IF !loc_oBusca.this_lAchouRegistro
1867:                     loc_oBusca.mAddColuna("CCargs", "", "Cargo")
1868:                     loc_oBusca.mAddColuna("DCargs", "", "Descri" + CHR(231) + CHR(227) + "o")
1869:                     loc_oBusca.Show()
1870:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCrg")
1871:                         loc_oPagina.txt_4c_Setors.Value = ALLTRIM(cursor_4c_BuscaCrg.CCargs)
1872:                     ENDIF
1873:                     ENDIF
1874:                 ENDIF
1875:                 loc_oBusca.Release()
1876:             ENDIF
1877: 
1878:             IF USED("cursor_4c_BuscaCrg")
1879:                 USE IN cursor_4c_BuscaCrg
1880:             ENDIF
1881:         CATCH TO loc_oErro
1882:             MsgErro("Erro em AbrirBuscaSetors:" + CHR(13) + loc_oErro.Message, "Erro")
1883:             IF USED("cursor_4c_BuscaCrg")
1884:                 USE IN cursor_4c_BuscaCrg
1885:             ENDIF
1886:         ENDTRY
1887:     ENDPROC
1888: 
1889:     *==========================================================================
1890:     * TeclaLookupSetors - Dispara AbrirBuscaSetors com F4 ou F5
1891:     *==========================================================================
1892:     PROCEDURE TeclaLookupSetors(par_nKeyCode, par_nShiftAltCtrl)
1893:         IF INLIST(par_nKeyCode, 115, 116)
1894:             THIS.AbrirBuscaSetors()
1895:         ENDIF
1896:     ENDPROC
1897: 
1898:     *==========================================================================
1899:     * ValidarSetors - Valida codigo de cargo ao sair do campo
1900:     *==========================================================================
1901:     PROCEDURE ValidarSetors(par_nKeyCode, par_nShiftAltCtrl)
1902:         LOCAL loc_oPagina, loc_cValor
1903:         TRY
1904:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1905:             loc_cValor  = UPPER(ALLTRIM(loc_oPagina.txt_4c_Setors.Value))
1906: 
1907:             IF EMPTY(loc_cValor)
1908:                 RETURN
1909:             ENDIF
1910: 
1911:             THIS.AbrirBuscaSetors()
1912:         CATCH TO loc_oErro
1913:             MsgErro("Erro em ValidarSetors:" + CHR(13) + loc_oErro.Message, "Erro")
1914:         ENDTRY
1915:     ENDPROC
1916: 
1917:     *==========================================================================
1918:     * Destroy - Libera recursos
1919:     *==========================================================================
1920:     PROCEDURE Destroy()
1921:         TRY
1922:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1923:                 THIS.this_oBusinessObject = .NULL.
1924:             ENDIF
1925: 
1926:             IF USED("crSigCcCmI")
1927:                 USE IN crSigCcCmI
1928:             ENDIF
1929:             IF USED("cursor_4c_VerifDest")
1930:                 USE IN cursor_4c_VerifDest
1931:             ENDIF
1932:             IF USED("cursor_4c_CopRes")
1933:                 USE IN cursor_4c_CopRes
1934:             ENDIF
1935:             IF USED("cursor_4c_BuscaUsu")
1936:                 USE IN cursor_4c_BuscaUsu
1937:             ENDIF
1938:             IF USED("cursor_4c_ValUsu")
1939:                 USE IN cursor_4c_ValUsu
1940:             ENDIF
1941:             IF USED("cursor_4c_BuscaCrg")
1942:                 USE IN cursor_4c_BuscaCrg
1943:             ENDIF
1944:             IF USED("cursor_4c_UltPer")
1945:                 USE IN cursor_4c_UltPer
1946:             ENDIF
1947:         CATCH TO loc_oErro
1948:             *-- Ignorar erros no Destroy
1949:         ENDTRY
1950: 
1951:         DODEFAULT()
1952:     ENDPROC
1953: 
1954: ENDDEFINE


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

