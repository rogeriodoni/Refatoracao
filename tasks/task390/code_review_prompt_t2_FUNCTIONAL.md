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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCVE.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1951 linhas total):

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
334:                     .Width           = 90
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

*-- Linhas 1031 a 1160:
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
1043:     * cnt_4c_Copia deve permanecer oculto (container flutuante)
1044:     *==========================================================================
1045:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1046:         LOCAL loc_nI, loc_oObjeto, loc_cNome, loc_nP
1047: 
1048:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1049:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1050: 
1051:             IF VARTYPE(loc_oObjeto) = "O"
1052:                 loc_cNome = UPPER(loc_oObjeto.Name)
1053: 
1054:                 IF INLIST(loc_cNome, "CNT_4C_COPIA", "CNT_4C_CABECALHO", "CNT_4C_BOTOESACAO")
1055:                     IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1056:                         THIS.TornarControlesVisiveis(loc_oObjeto)
1057:                     ENDIF
1058:                     LOOP
1059:                 ENDIF
1060: 
1061:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1062:                     loc_oObjeto.Visible = .T.
1063:                 ENDIF
1064: 
1065:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1066:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1067:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1068:                     ENDFOR
1069:                 ENDIF
1070: 
1071:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1072:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1073:                 ENDIF
1074:             ENDIF
1075:         ENDFOR
1076:     ENDPROC
1077: 
1078:     *==========================================================================
1079:     * FormatarGridLista - Formata visual do grid
1080:     *==========================================================================
1081:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1082:         WITH par_oGrid
1083:             .FontName = "Tahoma"
1084:             .FontSize = 8
1085:         ENDWITH
1086:     ENDPROC
1087: 
1088:     *==========================================================================
1089:     * AlternarPagina - Alterna entre Page1 (1=Lista) e Page2 (2=Dados)
1090:     *==========================================================================
1091:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1092:         LOCAL loc_lResultado
1093:         loc_lResultado = .F.
1094: 
1095:         TRY
1096:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
1097:                 loc_lResultado = .F.
1098:             ELSE
1099:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1100: 
1101:                 IF par_nPagina = 1
1102:                     THIS.this_cModoAtual = "LISTA"
1103:                     THIS.CarregarLista()
1104:                 ENDIF
1105: 
1106:                 loc_lResultado = .T.
1107:             ENDIF
1108:         CATCH TO loc_oErro
1109:             MsgErro("Erro em AlternarPagina:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
1110:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
1111:             loc_lResultado = .F.
1112:         ENDTRY
1113: 
1114:         RETURN loc_lResultado
1115:     ENDPROC
1116: 
1117:     *==========================================================================
1118:     * CarregarLista - Carrega grid com dados de SigCcCmI filtrados por periodo
1119:     *==========================================================================
1120:     PROCEDURE CarregarLista()
1121:         LOCAL loc_lResultado, loc_cSQL, loc_nResult
1122:         LOCAL loc_cMesI, loc_cMesF, loc_cAnoI, loc_cAnoF
1123:         LOCAL loc_oPagina, loc_oGrid
1124:         loc_lResultado = .F.
1125: 
1126:         TRY
1127:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1128:                 loc_lResultado = .T.
1129:             ELSE
1130:                 loc_oPagina = THIS.pgf_4c_Paginas.Page1
1131:                 loc_oGrid   = loc_oPagina.grd_4c_Lista
1132: 
1133:                 loc_cMesI = PADL(ALLTRIM(loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroMess.Value), 2, "0")
1134:                 loc_cAnoI = PADL(ALLTRIM(loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroAnos.Value), 4, "0")
1135:                 loc_cMesF = IIF(loc_cMesI = "00", "12", loc_cMesI)
1136:                 loc_cAnoF = IIF(loc_cAnoI = "0000", "9999", loc_cAnoI)
1137: 
1138:                 IF USED("crSigCcCmI")
1139:                     USE IN crSigCcCmI
1140:                 ENDIF
1141: 
1142:                 loc_cSQL = "SELECT cIdChaves, Usuars, Mess, Anos, Indivs, Setors," + ;
1143:                            " Adics, Minimos, MinExps" + ;
1144:                            " FROM SigCcCmI" + ;
1145:                            " WHERE Mess BETWEEN " + EscaparSQL(loc_cMesI) + ;
1146:                            " AND " + EscaparSQL(loc_cMesF) + ;
1147:                            " AND Anos BETWEEN " + EscaparSQL(loc_cAnoI) + ;
1148:                            " AND " + EscaparSQL(loc_cAnoF) + ;
1149:                            " ORDER BY Anos, Mess, Usuars, Setors"
1150: 
1151:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCcCmI")
1152: 
1153:                 IF loc_nResult < 0
1154:                     MsgErro("Erro ao carregar comiss" + CHR(245) + "es:" + CHR(13) + ;
1155:                             CapturarErroSQL(), "Erro SQL")
1156:                 ELSE
1157:                     loc_oGrid.RecordSource           = "crSigCcCmI"
1158:                     loc_oGrid.Column1.ControlSource  = "crSigCcCmI.Usuars"
1159:                     loc_oGrid.Column2.ControlSource  = "crSigCcCmI.Mess"
1160:                     loc_oGrid.Column3.ControlSource  = "crSigCcCmI.Anos"

*-- Linhas 1202 a 1497:
1202:     *==========================================================================
1203:     * FiltroMesLostFocus - Ao sair do campo mes, padroniza e foca ano
1204:     *==========================================================================
1205:     PROCEDURE FiltroMesLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1206:         LOCAL loc_oPagina
1207:         TRY
1208:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
1209:             loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroMess.Value = ;
1210:                 PADL(ALLTRIM(loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroMess.Value), 2, "0")
1211:             loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroAnos.SetFocus
1212:         CATCH TO loc_oErro
1213:             MsgErro("Erro em FiltroMesLostFocus:" + CHR(13) + loc_oErro.Message, "Erro")
1214:         ENDTRY
1215:     ENDPROC
1216: 
1217:     *==========================================================================
1218:     * FiltroAnosLostFocus - Ao sair do campo ano, padroniza e recarrega grid
1219:     *==========================================================================
1220:     PROCEDURE FiltroAnosLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1221:         LOCAL loc_oPagina
1222:         TRY
1223:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
1224:             loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroAnos.Value = ;
1225:                 PADL(ALLTRIM(loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroAnos.Value), 4, "0")
1226:             THIS.CarregarLista()
1227:         CATCH TO loc_oErro
1228:             MsgErro("Erro em FiltroAnosLostFocus:" + CHR(13) + loc_oErro.Message, "Erro")
1229:         ENDTRY
1230:     ENDPROC
1231: 
1232:     *==========================================================================
1233:     * BtnIncluirClick - Prepara novo registro e navega para Page2
1234:     *==========================================================================
1235:     PROCEDURE BtnIncluirClick()
1236:         TRY
1237:             THIS.this_oBusinessObject.NovoRegistro()
1238:             THIS.this_cModoAtual = "INCLUIR"
1239:             THIS.LimparCampos()
1240:             THIS.HabilitarCampos(.T.)
1241:             THIS.AjustarBotoesPorModo()
1242:             THIS.AlternarPagina(2)
1243:             THIS.pgf_4c_Paginas.Page2.txt_4c_Usuars.SetFocus
1244:         CATCH TO loc_oErro
1245:             MsgErro("Erro em BtnIncluirClick:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
1246:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
1247:         ENDTRY
1248:     ENDPROC
1249: 
1250:     *==========================================================================
1251:     * BtnAlterarClick - Carrega registro selecionado e navega para Page2
1252:     *==========================================================================
1253:     PROCEDURE BtnAlterarClick()
1254:         LOCAL loc_cChave
1255:         TRY
1256:             IF !USED("crSigCcCmI") OR EOF("crSigCcCmI") OR RECCOUNT("crSigCcCmI") = 0
1257:                 MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
1258:             ELSE
1259:                 SELECT crSigCcCmI
1260:                 loc_cChave = ALLTRIM(crSigCcCmI.cIdChaves)
1261: 
1262:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1263:                     THIS.this_oBusinessObject.EditarRegistro()
1264:                     THIS.this_cModoAtual = "ALTERAR"
1265:                     THIS.BOParaForm()
1266:                     THIS.HabilitarCampos(.T.)
1267:                     THIS.AjustarBotoesPorModo()
1268:                     THIS.AlternarPagina(2)
1269:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Indivs.SetFocus
1270:                 ELSE
1271:                     MsgErro("Erro ao carregar registro para altera" + CHR(231) + CHR(227) + "o!", "Erro")
1272:                 ENDIF
1273:             ENDIF
1274:         CATCH TO loc_oErro
1275:             MsgErro("Erro em BtnAlterarClick:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
1276:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
1277:         ENDTRY
1278:     ENDPROC
1279: 
1280:     *==========================================================================
1281:     * BtnVisualizarClick - Carrega registro em modo somente leitura
1282:     *==========================================================================
1283:     PROCEDURE BtnVisualizarClick()
1284:         LOCAL loc_cChave
1285:         TRY
1286:             IF !USED("crSigCcCmI") OR EOF("crSigCcCmI") OR RECCOUNT("crSigCcCmI") = 0
1287:                 MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
1288:             ELSE
1289:                 SELECT crSigCcCmI
1290:                 loc_cChave = ALLTRIM(crSigCcCmI.cIdChaves)
1291: 
1292:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1293:                     THIS.this_cModoAtual = "VISUALIZAR"
1294:                     THIS.BOParaForm()
1295:                     THIS.HabilitarCampos(.F.)
1296:                     THIS.AjustarBotoesPorModo()
1297:                     THIS.AlternarPagina(2)
1298:                 ELSE
1299:                     MsgErro("Erro ao carregar registro para visualiza" + CHR(231) + CHR(227) + "o!", "Erro")
1300:                 ENDIF
1301:             ENDIF
1302:         CATCH TO loc_oErro
1303:             MsgErro("Erro em BtnVisualizarClick:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
1304:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
1305:         ENDTRY
1306:     ENDPROC
1307: 
1308:     *==========================================================================
1309:     * BtnExcluirClick - Confirma e exclui registro selecionado
1310:     *==========================================================================
1311:     PROCEDURE BtnExcluirClick()
1312:         LOCAL loc_cChave, loc_lConfirma
1313:         TRY
1314:             IF !USED("crSigCcCmI") OR EOF("crSigCcCmI") OR RECCOUNT("crSigCcCmI") = 0
1315:                 MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
1316:             ELSE
1317:                 SELECT crSigCcCmI
1318:                 loc_cChave   = ALLTRIM(crSigCcCmI.cIdChaves)
1319:                 loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro?", ;
1320:                                             "Excluir")
1321: 
1322:                 IF loc_lConfirma
1323:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1324:                         IF THIS.this_oBusinessObject.Excluir()
1325:                             MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "")
1326:                             THIS.CarregarLista()
1327:                         ELSE
1328:                             MsgErro("Erro ao excluir registro!", "Erro")
1329:                         ENDIF
1330:                     ELSE
1331:                         MsgErro("Erro ao carregar registro para exclus" + CHR(227) + "o!", "Erro")
1332:                     ENDIF
1333:                 ENDIF
1334:             ENDIF
1335:         CATCH TO loc_oErro
1336:             MsgErro("Erro em BtnExcluirClick:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
1337:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
1338:         ENDTRY
1339:     ENDPROC
1340: 
1341:     *==========================================================================
1342:     * BtnBuscarClick - Recarrega grid com filtro atual
1343:     *==========================================================================
1344:     PROCEDURE BtnBuscarClick()
1345:         TRY
1346:             THIS.CarregarLista()
1347:             IF USED("crSigCcCmI") AND !EOF("crSigCcCmI")
1348:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.SetFocus
1349:             ENDIF
1350:         CATCH TO loc_oErro
1351:             MsgErro("Erro em BtnBuscarClick:" + CHR(13) + loc_oErro.Message, "Erro")
1352:         ENDTRY
1353:     ENDPROC
1354: 
1355:     *==========================================================================
1356:     * BtnEncerrarClick - Fecha o formulario
1357:     *==========================================================================
1358:     PROCEDURE BtnEncerrarClick()
1359:         TRY
1360:             THIS.Release()
1361:         CATCH TO loc_oErro
1362:             *-- Ignorar erros ao fechar
1363:         ENDTRY
1364:     ENDPROC
1365: 
1366:     *==========================================================================
1367:     * BtnSalvarClick - Valida e salva registro
1368:     *==========================================================================
1369:     PROCEDURE BtnSalvarClick()
1370:         IF !THIS.FormParaBO()
1371:             RETURN
1372:         ENDIF
1373: 
1374:         TRY
1375:             IF THIS.this_oBusinessObject.Salvar()
1376:                 MsgInfo("Registro salvo com sucesso!", "")
1377:                 THIS.AlternarPagina(1)
1378:             ELSE
1379:                 MsgErro("Erro ao salvar registro!", "Erro")
1380:             ENDIF
1381:         CATCH TO loc_oErro
1382:             MsgErro("Erro em BtnSalvarClick:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
1383:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
1384:         ENDTRY
1385:     ENDPROC
1386: 
1387:     *==========================================================================
1388:     * BtnCancelarClick - Cancela edicao e volta para lista
1389:     *==========================================================================
1390:     PROCEDURE BtnCancelarClick()
1391:         TRY
1392:             THIS.AlternarPagina(1)
1393:         CATCH TO loc_oErro
1394:             MsgErro("Erro em BtnCancelarClick:" + CHR(13) + loc_oErro.Message, "Erro")
1395:         ENDTRY
1396:     ENDPROC
1397: 
1398:     *==========================================================================
1399:     * BtnCopiarClick - Mostra container de copia de periodo
1400:     *==========================================================================
1401:     PROCEDURE BtnCopiarClick()
1402:         LOCAL loc_oPagina
1403:         TRY
1404:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
1405: 
1406:             loc_oPagina.grd_4c_Lista.Enabled  = .F.
1407:             loc_oPagina.cnt_4c_Botoes.Enabled = .F.
1408:             loc_oPagina.cnt_4c_Saida.Enabled  = .F.
1409:             loc_oPagina.cmd_4c_Copia.Enabled  = .F.
1410: 
1411:             WITH loc_oPagina.cnt_4c_Copia
1412:                 .txt_4c_OMess.Value = ""
1413:                 .txt_4c_OAnos.Value = ""
1414:                 .txt_4c_DMess.Value = ""
1415:                 .txt_4c_DAnos.Value = ""
1416:                 .Visible = .T.
1417:                 .ZOrder(0)
1418:                 .txt_4c_OMess.SetFocus
1419:             ENDWITH
1420:         CATCH TO loc_oErro
1421:             MsgErro("Erro em BtnCopiarClick:" + CHR(13) + loc_oErro.Message, "Erro")
1422:         ENDTRY
1423:     ENDPROC
1424: 
1425:     *==========================================================================
1426:     * BtnOkCopiaClick - Executa copia de todos os registros do periodo origem
1427:     *                   para o periodo destino no SQL Server
1428:     *==========================================================================
1429:     PROCEDURE BtnOkCopiaClick()
1430:         LOCAL loc_oPagina, loc_cOMess, loc_cDMess, loc_cOAnos, loc_cDAnos
1431:         LOCAL loc_nResult, loc_cSQL, loc_lCopiar
1432:         loc_lCopiar = .F.
1433: 
1434:         TRY
1435:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
1436: 
1437:             loc_cOMess = PADL(ALLTRIM(loc_oPagina.cnt_4c_Copia.txt_4c_OMess.Value), 2, "0")
1438:             loc_cOAnos = PADL(ALLTRIM(loc_oPagina.cnt_4c_Copia.txt_4c_OAnos.Value), 4, "0")
1439:             loc_cDMess = PADL(ALLTRIM(loc_oPagina.cnt_4c_Copia.txt_4c_DMess.Value), 2, "0")
1440:             loc_cDAnos = PADL(ALLTRIM(loc_oPagina.cnt_4c_Copia.txt_4c_DAnos.Value), 4, "0")
1441: 
1442:             IF EMPTY(loc_cOMess) OR loc_cOMess = "00" OR VAL(loc_cOMess) = 0
1443:                 MsgAviso("Obrigat" + CHR(243) + "rio informar o M" + CHR(234) + ;
1444:                          "s de Origem!", "")
1445:                 loc_oPagina.cnt_4c_Copia.txt_4c_OMess.SetFocus
1446:             ELSE
1447:                 IF EMPTY(loc_cOAnos) OR loc_cOAnos = "0000" OR VAL(loc_cOAnos) = 0
1448:                 MsgAviso("Obrigat" + CHR(243) + "rio informar o Ano de Origem!", "")
1449:                 loc_oPagina.cnt_4c_Copia.txt_4c_OAnos.SetFocus
1450:             ELSE
1451:                 IF EMPTY(loc_cDMess) OR loc_cDMess = "00" OR VAL(loc_cDMess) = 0
1452:                 MsgAviso("Obrigat" + CHR(243) + "rio informar o M" + CHR(234) + ;
1453:                          "s de Destino!", "")
1454:                 loc_oPagina.cnt_4c_Copia.txt_4c_DMess.SetFocus
1455:             ELSE
1456:                 IF EMPTY(loc_cDAnos) OR loc_cDAnos = "0000" OR VAL(loc_cDAnos) = 0
1457:                 MsgAviso("Obrigat" + CHR(243) + "rio informar o Ano de Destino!", "")
1458:                 loc_oPagina.cnt_4c_Copia.txt_4c_DAnos.SetFocus
1459:             ELSE
1460:                 *-- Verificar se destino ja tem registros
1461:                 loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCcCmI" + ;
1462:                            " WHERE Mess = " + EscaparSQL(loc_cDMess) + ;
1463:                            " AND Anos = " + EscaparSQL(loc_cDAnos)
1464: 
1465:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerifDest")
1466: 
1467:                 IF loc_nResult >= 0 AND USED("cursor_4c_VerifDest") AND ;
1468:                    cursor_4c_VerifDest.Total > 0
1469:                     IF MsgConfirma("O per" + CHR(237) + "odo de destino j" + CHR(225) + ;
1470:                                    " possui registros. Deseja sobrepor?", "Confirmar")
1471:                         loc_lCopiar = .T.
1472:                     ENDIF
1473:                 ELSE
1474:                     loc_lCopiar = .T.
1475:                 ENDIF
1476: 
1477:                 IF USED("cursor_4c_VerifDest")
1478:                     USE IN cursor_4c_VerifDest
1479:                 ENDIF
1480: 
1481:                 IF loc_lCopiar
1482:                     loc_cSQL = "INSERT INTO SigCcCmI" + ;
1483:                                " (cIdChaves, Usuars, Indivs, Setors, Adics, Minimos, MinExps," + ;
1484:                                " Mess, Anos)" + ;
1485:                                " SELECT NEWID(), Usuars, Indivs, Setors, Adics, Minimos, MinExps," + ;
1486:                                " " + EscaparSQL(loc_cDMess) + ", " + EscaparSQL(loc_cDAnos) + ;
1487:                                " FROM SigCcCmI" + ;
1488:                                " WHERE Mess = " + EscaparSQL(loc_cOMess) + ;
1489:                                " AND Anos = " + EscaparSQL(loc_cOAnos) + ;
1490:                                " AND NOT EXISTS (" + ;
1491:                                "   SELECT 1 FROM SigCcCmI d" + ;
1492:                                "   WHERE d.Mess = " + EscaparSQL(loc_cDMess) + ;
1493:                                "   AND d.Anos = " + EscaparSQL(loc_cDAnos) + ;
1494:                                "   AND d.Usuars = SigCcCmI.Usuars)"
1495: 
1496:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CopRes")
1497: 

*-- Linhas 1527 a 1951:
1527:     *==========================================================================
1528:     * BtnCancelarCopiaClick - Oculta container de copia e reabilita area
1529:     *==========================================================================
1530:     PROCEDURE BtnCancelarCopiaClick()
1531:         LOCAL loc_oPagina
1532:         TRY
1533:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
1534: 
1535:             loc_oPagina.cnt_4c_Copia.Visible  = .F.
1536:             loc_oPagina.grd_4c_Lista.Enabled  = .T.
1537:             loc_oPagina.cnt_4c_Botoes.Enabled = .T.
1538:             loc_oPagina.cnt_4c_Saida.Enabled  = .T.
1539:             loc_oPagina.cmd_4c_Copia.Enabled  = .T.
1540: 
1541:             IF USED("crSigCcCmI")
1542:                 loc_oPagina.grd_4c_Lista.SetFocus
1543:             ENDIF
1544:         CATCH TO loc_oErro
1545:             MsgErro("Erro em BtnCancelarCopiaClick:" + CHR(13) + loc_oErro.Message, "Erro")
1546:         ENDTRY
1547:     ENDPROC
1548: 
1549:     *==========================================================================
1550:     * LimparCampos - Limpa todos os campos da Page2
1551:     *==========================================================================
1552:     PROTECTED PROCEDURE LimparCampos()
1553:         LOCAL loc_oPagina
1554:         TRY
1555:             THIS.this_oBusinessObject.NovoRegistro()
1556:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1557:             loc_oPagina.txt_4c_Usuars.Value  = ""
1558:             loc_oPagina.txt_4c_Mess.Value    = ""
1559:             loc_oPagina.txt_4c_Anos.Value    = ""
1560:             loc_oPagina.txt_4c_Indivs.Value  = "N"
1561:             loc_oPagina.txt_4c_Setors.Value  = ""
1562:             loc_oPagina.txt_4c_Adics.Value   = 0.00
1563:             loc_oPagina.txt_4c_Minimos.Value = 0.00
1564:             loc_oPagina.txt_4c_MinExps.Value = 0.00
1565:         CATCH TO loc_oErro
1566:             MsgErro("Erro em LimparCampos:" + CHR(13) + loc_oErro.Message, "Erro")
1567:         ENDTRY
1568:     ENDPROC
1569: 
1570:     *==========================================================================
1571:     * HabilitarCampos - Habilita ou desabilita todos os campos editaveis da Page2
1572:     *==========================================================================
1573:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1574:         LOCAL loc_oPagina
1575:         TRY
1576:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1577:             loc_oPagina.txt_4c_Usuars.Enabled  = par_lHabilitar
1578:             loc_oPagina.txt_4c_Mess.Enabled    = par_lHabilitar
1579:             loc_oPagina.txt_4c_Anos.Enabled    = par_lHabilitar
1580:             loc_oPagina.txt_4c_Indivs.Enabled  = par_lHabilitar
1581:             loc_oPagina.txt_4c_Setors.Enabled  = par_lHabilitar
1582:             loc_oPagina.txt_4c_Adics.Enabled   = par_lHabilitar
1583:             loc_oPagina.txt_4c_Minimos.Enabled = par_lHabilitar
1584:             loc_oPagina.txt_4c_MinExps.Enabled = par_lHabilitar
1585:             WITH loc_oPagina.cnt_4c_BotoesAcao
1586:                 .cmd_4c_Confirmar.Enabled = par_lHabilitar
1587:                 .Visible     = .T.
1588:             ENDWITH
1589:         CATCH TO loc_oErro
1590:             MsgErro("Erro em HabilitarCampos:" + CHR(13) + loc_oErro.Message, "Erro")
1591:         ENDTRY
1592:     ENDPROC
1593: 
1594:     *==========================================================================
1595:     * AjustarBotoesPorModo - Ajusta estado dos botoes da Page2 conforme modo
1596:     *==========================================================================
1597:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1598:         LOCAL loc_oPagina, loc_lEditar
1599:         TRY
1600:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1601:             loc_lEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1602: 
1603:             WITH loc_oPagina.cnt_4c_BotoesAcao
1604:                 .cmd_4c_Confirmar.Enabled = loc_lEditar
1605:                 .cmd_4c_Cancelar.Enabled  = .T.
1606:                 .Visible     = .T.
1607:             ENDWITH
1608:         CATCH TO loc_oErro
1609:             MsgErro("Erro em AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message, "Erro")
1610:         ENDTRY
1611:     ENDPROC
1612: 
1613:     *==========================================================================
1614:     * BOParaForm - Transfere propriedades do BO para os campos da Page2
1615:     *==========================================================================
1616:     PROTECTED PROCEDURE BOParaForm()
1617:         LOCAL loc_lResultado, loc_oPagina, loc_oBO
1618:         loc_lResultado = .F.
1619: 
1620:         TRY
1621:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1622:             loc_oBO     = THIS.this_oBusinessObject
1623: 
1624:             loc_oPagina.txt_4c_Usuars.Value  = ALLTRIM(loc_oBO.this_cUsuars)
1625:             loc_oPagina.txt_4c_Mess.Value    = ALLTRIM(loc_oBO.this_cMess)
1626:             loc_oPagina.txt_4c_Anos.Value    = ALLTRIM(loc_oBO.this_cAnos)
1627:             loc_oPagina.txt_4c_Indivs.Value  = IIF(EMPTY(ALLTRIM(loc_oBO.this_cIndivs)), ;
1628:                                                     "N", UPPER(ALLTRIM(loc_oBO.this_cIndivs)))
1629:             loc_oPagina.txt_4c_Setors.Value  = ALLTRIM(loc_oBO.this_cSetors)
1630:             loc_oPagina.txt_4c_Adics.Value   = loc_oBO.this_nAdics
1631:             loc_oPagina.txt_4c_Minimos.Value = loc_oBO.this_nMinimos
1632:             loc_oPagina.txt_4c_MinExps.Value = loc_oBO.this_nMinExps
1633: 
1634:             loc_lResultado = .T.
1635:         CATCH TO loc_oErro
1636:             MsgErro("Erro em BOParaForm:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
1637:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
1638:             loc_lResultado = .F.
1639:         ENDTRY
1640: 
1641:         RETURN loc_lResultado
1642:     ENDPROC
1643: 
1644:     *==========================================================================
1645:     * FormParaBO - Valida campos da Page2 e transfere para o BO
1646:     * Retorna .T. se valido, .F. se ha erro de validacao
1647:     *==========================================================================
1648:     PROTECTED PROCEDURE FormParaBO()
1649:         LOCAL loc_lResultado, loc_oPagina, loc_oBO
1650:         LOCAL loc_cUsuars, loc_cMess, loc_cAnos, loc_cIndivs, loc_cSetors
1651:         LOCAL loc_cMsgDupI, loc_cMsgDupV
1652:         loc_lResultado = .F.
1653: 
1654:         TRY
1655:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1656:             loc_oBO     = THIS.this_oBusinessObject
1657: 
1658:             loc_cUsuars = UPPER(ALLTRIM(loc_oPagina.txt_4c_Usuars.Value))
1659:             loc_cMess   = PADL(ALLTRIM(loc_oPagina.txt_4c_Mess.Value),  2, "0")
1660:             loc_cAnos   = PADL(ALLTRIM(loc_oPagina.txt_4c_Anos.Value),  4, "0")
1661:             loc_cIndivs = UPPER(ALLTRIM(loc_oPagina.txt_4c_Indivs.Value))
1662:             loc_cSetors = UPPER(ALLTRIM(loc_oPagina.txt_4c_Setors.Value))
1663: 
1664:             IF EMPTY(loc_cUsuars)
1665:                 MsgAviso("Obrigat" + CHR(243) + "rio informar o Usu" + CHR(225) + "rio!!!", "")
1666:                 loc_oPagina.txt_4c_Usuars.SetFocus
1667:             ELSE
1668:                 IF EMPTY(loc_cMess) OR loc_cMess = "00" OR VAL(loc_cMess) = 0
1669:                 MsgAviso("Obrigat" + CHR(243) + "rio informar o M" + CHR(234) + ;
1670:                          "s de Refer" + CHR(234) + "ncia!!!", "")
1671:                 loc_oPagina.txt_4c_Mess.SetFocus
1672:             ELSE
1673:                 IF EMPTY(loc_cAnos) OR loc_cAnos = "0000" OR VAL(loc_cAnos) = 0
1674:                 MsgAviso("Obrigat" + CHR(243) + "rio informar o Ano de Refer" + CHR(234) + ;
1675:                          "ncia!!!", "")
1676:                 loc_oPagina.txt_4c_Anos.SetFocus
1677:             ELSE
1678:                 IF !EMPTY(loc_cIndivs) AND !INLIST(loc_cIndivs, "S", "N")
1679:                 MsgAviso("Vendedor deve ser S ou N!!!", "")
1680:                 loc_oPagina.txt_4c_Indivs.SetFocus
1681:             ELSE
1682:                 loc_oBO.this_cUsuars    = loc_cUsuars
1683:                 loc_oBO.this_cMess      = loc_cMess
1684:                 loc_oBO.this_cAnos      = loc_cAnos
1685:                 loc_oBO.this_cIndivs    = IIF(EMPTY(loc_cIndivs), "N", loc_cIndivs)
1686:                 loc_oBO.this_cSetors    = loc_cSetors
1687:                 loc_oBO.this_nAdics     = loc_oPagina.txt_4c_Adics.Value
1688:                 loc_oBO.this_nMinimos   = loc_oPagina.txt_4c_Minimos.Value
1689:                 loc_oBO.this_nMinExps   = loc_oPagina.txt_4c_MinExps.Value
1690: 
1691:                 loc_cMsgDupI = loc_oBO.ValidarDuplicidadeEmSigCcCmI()
1692:                 IF !EMPTY(loc_cMsgDupI)
1693:                     MsgAviso(loc_cMsgDupI, "")
1694:                 ELSE
1695:                     loc_cMsgDupV = loc_oBO.ValidarDuplicidadeEmSigCcCmV()
1696:                     IF !EMPTY(loc_cMsgDupV)
1697:                         MsgAviso(loc_cMsgDupV, "")
1698:                     ELSE
1699:                         loc_lResultado = .T.
1700:                     ENDIF
1701:                 ENDIF
1702:                 ENDIF
1703:                 ENDIF
1704:                 ENDIF
1705:             ENDIF
1706:         CATCH TO loc_oErro
1707:             MsgErro("Erro em FormParaBO:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
1708:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
1709:             loc_lResultado = .F.
1710:         ENDTRY
1711: 
1712:         RETURN loc_lResultado
1713:     ENDPROC
1714: 
1715:     *==========================================================================
1716:     * AbrirBuscaUsuars - Abre picker FormBuscaAuxiliar para SigCdUsu
1717:     *==========================================================================
1718:     PROCEDURE AbrirBuscaUsuars()
1719:         LOCAL loc_oPagina, loc_cValor, loc_oBusca
1720:         TRY
1721:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1722:             loc_cValor  = UPPER(ALLTRIM(loc_oPagina.txt_4c_Usuars.Value))
1723: 
1724:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1725:                                       "SigCdUsu", "cursor_4c_BuscaUsu", ;
1726:                                       "Usuarios", loc_cValor, ;
1727:                                       "Busca de Usu" + CHR(225) + "rios")
1728: 
1729:             IF VARTYPE(loc_oBusca) = "O"
1730:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1731:                     loc_oPagina.txt_4c_Usuars.Value = ALLTRIM(cursor_4c_BuscaUsu.Usuarios)
1732:                     THIS.PreencherPeriodoDoUsuario(ALLTRIM(cursor_4c_BuscaUsu.Usuarios))
1733:                 ELSE
1734:                     IF !loc_oBusca.this_lAchouRegistro
1735:                     loc_oBusca.mAddColuna("Usuarios", "", "Usu" + CHR(225) + "rio")
1736:                     loc_oBusca.mAddColuna("NComps",   "", "Nome")
1737:                     loc_oBusca.Show()
1738:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUsu")
1739:                         loc_oPagina.txt_4c_Usuars.Value = ALLTRIM(cursor_4c_BuscaUsu.Usuarios)
1740:                         THIS.PreencherPeriodoDoUsuario(ALLTRIM(cursor_4c_BuscaUsu.Usuarios))
1741:                     ENDIF
1742:                     ENDIF
1743:                 ENDIF
1744:                 loc_oBusca.Release()
1745:             ENDIF
1746: 
1747:             IF USED("cursor_4c_BuscaUsu")
1748:                 USE IN cursor_4c_BuscaUsu
1749:             ENDIF
1750:         CATCH TO loc_oErro
1751:             MsgErro("Erro em AbrirBuscaUsuars:" + CHR(13) + loc_oErro.Message, "Erro")
1752:             IF USED("cursor_4c_BuscaUsu")
1753:                 USE IN cursor_4c_BuscaUsu
1754:             ENDIF
1755:         ENDTRY
1756:     ENDPROC
1757: 
1758:     *==========================================================================
1759:     * TeclaLookupUsuars - Dispara AbrirBuscaUsuars com F4 ou F5
1760:     *==========================================================================
1761:     PROCEDURE TeclaLookupUsuars(par_nKeyCode, par_nShiftAltCtrl)
1762:         IF INLIST(par_nKeyCode, 115, 116)
1763:             THIS.AbrirBuscaUsuars()
1764:         ENDIF
1765:     ENDPROC
1766: 
1767:     *==========================================================================
1768:     * ValidarUsuars - Valida codigo de usuario ao sair do campo
1769:     *==========================================================================
1770:     PROCEDURE ValidarUsuars(par_nKeyCode, par_nShiftAltCtrl)
1771:         LOCAL loc_oPagina, loc_cValor, loc_cSQL, loc_nResultado
1772:         TRY
1773:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1774:             loc_cValor  = UPPER(ALLTRIM(loc_oPagina.txt_4c_Usuars.Value))
1775: 
1776:             IF EMPTY(loc_cValor)
1777:                 RETURN
1778:             ENDIF
1779: 
1780:             loc_cSQL       = "SELECT Usuars, NComps FROM SigCdUsu" + ;
1781:                              " WHERE Usuars = " + EscaparSQL(loc_cValor)
1782:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValUsu")
1783: 
1784:             IF loc_nResultado > 0 AND USED("cursor_4c_ValUsu") AND ;
1785:                RECCOUNT("cursor_4c_ValUsu") > 0
1786:                 loc_oPagina.txt_4c_Usuars.Value = ALLTRIM(cursor_4c_ValUsu.Usuars)
1787:                 THIS.PreencherPeriodoDoUsuario(ALLTRIM(cursor_4c_ValUsu.Usuars))
1788:             ELSE
1789:                 IF USED("cursor_4c_ValUsu")
1790:                     USE IN cursor_4c_ValUsu
1791:                 ENDIF
1792:                 *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
1793:                 THIS.AbrirBuscaUsuars()
1794:                 RETURN
1795:             ENDIF
1796: 
1797:             IF USED("cursor_4c_ValUsu")
1798:                 USE IN cursor_4c_ValUsu
1799:             ENDIF
1800:         CATCH TO loc_oErro
1801:             MsgErro("Erro em ValidarUsuars:" + CHR(13) + loc_oErro.Message, "Erro")
1802:             IF USED("cursor_4c_ValUsu")
1803:                 USE IN cursor_4c_ValUsu
1804:             ENDIF
1805:         ENDTRY
1806:     ENDPROC
1807: 
1808:     *==========================================================================
1809:     * PreencherPeriodoDoUsuario - Ao selecionar usuario sem periodo preenchido,
1810:     * carrega o ultimo periodo cadastrado para ele (auto-preenchimento)
1811:     *==========================================================================
1812:     PROTECTED PROCEDURE PreencherPeriodoDoUsuario(par_cUsuars)
1813:         LOCAL loc_oPagina
1814:         TRY
1815:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1816: 
1817:             IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Mess.Value)) OR ;
1818:                ALLTRIM(loc_oPagina.txt_4c_Mess.Value) = "00"
1819: 
1820:                 IF THIS.this_oBusinessObject.CarregarUltimoPeriodoUsuario(par_cUsuars)
1821:                     IF USED("cursor_4c_UltPer") AND RECCOUNT("cursor_4c_UltPer") > 0
1822:                         SELECT cursor_4c_UltPer
1823:                         loc_oPagina.txt_4c_Mess.Value   = ALLTRIM(cursor_4c_UltPer.mess)
1824:                         loc_oPagina.txt_4c_Anos.Value   = ALLTRIM(cursor_4c_UltPer.anos)
1825:                         loc_oPagina.txt_4c_Indivs.Value = IIF(EMPTY(cursor_4c_UltPer.indivs), ;
1826:                                                               "N", UPPER(cursor_4c_UltPer.indivs))
1827:                         loc_oPagina.txt_4c_Setors.Value  = ALLTRIM(cursor_4c_UltPer.setors)
1828:                         loc_oPagina.txt_4c_Adics.Value   = cursor_4c_UltPer.adics
1829:                         loc_oPagina.txt_4c_Minimos.Value = cursor_4c_UltPer.minimos
1830:                         loc_oPagina.txt_4c_MinExps.Value = cursor_4c_UltPer.minexps
1831:                     ENDIF
1832:                     IF USED("cursor_4c_UltPer")
1833:                         USE IN cursor_4c_UltPer
1834:                     ENDIF
1835:                 ENDIF
1836:             ENDIF
1837:         CATCH TO loc_oErro
1838:             MsgErro("Erro em PreencherPeriodoDoUsuario:" + CHR(13) + loc_oErro.Message, "Erro")
1839:             IF USED("cursor_4c_UltPer")
1840:                 USE IN cursor_4c_UltPer
1841:             ENDIF
1842:         ENDTRY
1843:     ENDPROC
1844: 
1845:     *==========================================================================
1846:     * AbrirBuscaSetors - Abre picker FormBuscaAuxiliar para SigCdCrg (Cargos)
1847:     *==========================================================================
1848:     PROCEDURE AbrirBuscaSetors()
1849:         LOCAL loc_oPagina, loc_cValor, loc_oBusca
1850:         TRY
1851:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1852:             loc_cValor  = UPPER(ALLTRIM(loc_oPagina.txt_4c_Setors.Value))
1853: 
1854:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1855:                                       "SigCdCrg", "cursor_4c_BuscaCrg", ;
1856:                                       "CCargs", loc_cValor, ;
1857:                                       "Busca de Cargos")
1858: 
1859:             IF VARTYPE(loc_oBusca) = "O"
1860:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1861:                     loc_oPagina.txt_4c_Setors.Value = ALLTRIM(cursor_4c_BuscaCrg.CCargs)
1862:                 ELSE
1863:                     IF !loc_oBusca.this_lAchouRegistro
1864:                     loc_oBusca.mAddColuna("CCargs", "", "Cargo")
1865:                     loc_oBusca.mAddColuna("DCargs", "", "Descri" + CHR(231) + CHR(227) + "o")
1866:                     loc_oBusca.Show()
1867:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCrg")
1868:                         loc_oPagina.txt_4c_Setors.Value = ALLTRIM(cursor_4c_BuscaCrg.CCargs)
1869:                     ENDIF
1870:                     ENDIF
1871:                 ENDIF
1872:                 loc_oBusca.Release()
1873:             ENDIF
1874: 
1875:             IF USED("cursor_4c_BuscaCrg")
1876:                 USE IN cursor_4c_BuscaCrg
1877:             ENDIF
1878:         CATCH TO loc_oErro
1879:             MsgErro("Erro em AbrirBuscaSetors:" + CHR(13) + loc_oErro.Message, "Erro")
1880:             IF USED("cursor_4c_BuscaCrg")
1881:                 USE IN cursor_4c_BuscaCrg
1882:             ENDIF
1883:         ENDTRY
1884:     ENDPROC
1885: 
1886:     *==========================================================================
1887:     * TeclaLookupSetors - Dispara AbrirBuscaSetors com F4 ou F5
1888:     *==========================================================================
1889:     PROCEDURE TeclaLookupSetors(par_nKeyCode, par_nShiftAltCtrl)
1890:         IF INLIST(par_nKeyCode, 115, 116)
1891:             THIS.AbrirBuscaSetors()
1892:         ENDIF
1893:     ENDPROC
1894: 
1895:     *==========================================================================
1896:     * ValidarSetors - Valida codigo de cargo ao sair do campo
1897:     *==========================================================================
1898:     PROCEDURE ValidarSetors(par_nKeyCode, par_nShiftAltCtrl)
1899:         LOCAL loc_oPagina, loc_cValor
1900:         TRY
1901:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1902:             loc_cValor  = UPPER(ALLTRIM(loc_oPagina.txt_4c_Setors.Value))
1903: 
1904:             IF EMPTY(loc_cValor)
1905:                 RETURN
1906:             ENDIF
1907: 
1908:             THIS.AbrirBuscaSetors()
1909:         CATCH TO loc_oErro
1910:             MsgErro("Erro em ValidarSetors:" + CHR(13) + loc_oErro.Message, "Erro")
1911:         ENDTRY
1912:     ENDPROC
1913: 
1914:     *==========================================================================
1915:     * Destroy - Libera recursos
1916:     *==========================================================================
1917:     PROCEDURE Destroy()
1918:         TRY
1919:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1920:                 THIS.this_oBusinessObject = .NULL.
1921:             ENDIF
1922: 
1923:             IF USED("crSigCcCmI")
1924:                 USE IN crSigCcCmI
1925:             ENDIF
1926:             IF USED("cursor_4c_VerifDest")
1927:                 USE IN cursor_4c_VerifDest
1928:             ENDIF
1929:             IF USED("cursor_4c_CopRes")
1930:                 USE IN cursor_4c_CopRes
1931:             ENDIF
1932:             IF USED("cursor_4c_BuscaUsu")
1933:                 USE IN cursor_4c_BuscaUsu
1934:             ENDIF
1935:             IF USED("cursor_4c_ValUsu")
1936:                 USE IN cursor_4c_ValUsu
1937:             ENDIF
1938:             IF USED("cursor_4c_BuscaCrg")
1939:                 USE IN cursor_4c_BuscaCrg
1940:             ENDIF
1941:             IF USED("cursor_4c_UltPer")
1942:                 USE IN cursor_4c_UltPer
1943:             ENDIF
1944:         CATCH TO loc_oErro
1945:             *-- Ignorar erros no Destroy
1946:         ENDTRY
1947: 
1948:         DODEFAULT()
1949:     ENDPROC
1950: 
1951: ENDDEFINE


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

