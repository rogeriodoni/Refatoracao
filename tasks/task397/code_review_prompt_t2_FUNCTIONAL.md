# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (4)
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormDepartamento.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1471 linhas total):

*-- Linhas 24 a 142:
24:     this_cModoAtual      = "LISTA"
25: 
26:     *--------------------------------------------------------------------------
27:     * Init - Inicializa via FormBase (que chama InicializarForm)
28:     *--------------------------------------------------------------------------
29:     PROCEDURE Init()
30:         RETURN DODEFAULT()
31:     ENDPROC
32: 
33:     *--------------------------------------------------------------------------
34:     * InicializarForm - Cria BO e configura estrutura do form
35:     *--------------------------------------------------------------------------
36:     PROTECTED PROCEDURE InicializarForm()
37:         LOCAL loc_lSucesso
38:         loc_lSucesso = .F.
39: 
40:         TRY
41:             THIS.this_oBusinessObject = CREATEOBJECT("DepartamentoBO")
42: 
43:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
44:                 MostrarErro("Erro ao criar DepartamentoBO" + CHR(13) + ;
45:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
46:                     "Erro")
47:             ELSE
48:                 THIS.ConfigurarPageFrame()
49: 
50:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
51:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
52: 
53:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
54:                     THIS.CarregarLista()
55:                 ENDIF
56: 
57:                 THIS.pgf_4c_Paginas.Visible = .T.
58:                 THIS.pgf_4c_Paginas.ActivePage = 1
59:                 THIS.this_cModoAtual = "LISTA"
60:                 loc_lSucesso = .T.
61:             ENDIF
62: 
63:         CATCH TO loc_oErro
64:             MostrarErro("Erro ao inicializar Formul" + CHR(225) + "rio:" + CHR(13) + ;
65:                 loc_oErro.Message, "Erro")
66:         ENDTRY
67: 
68:         RETURN loc_lSucesso
69:     ENDPROC
70: 
71:     *--------------------------------------------------------------------------
72:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
73:     *--------------------------------------------------------------------------
74:     PROTECTED PROCEDURE ConfigurarPageFrame()
75:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
76:         THIS.pgf_4c_Paginas.PageCount = 2
77: 
78:         WITH THIS.pgf_4c_Paginas
79:             .Top     = -29
80:             .Left    = 0
81:             .Width   = THIS.Width
82:             .Height  = THIS.Height + 29
83:             .Tabs    = .F.
84:             .Visible = .T.
85: 
86:             .Page1.Caption   = "Lista"
87:             .Page1.BackColor = RGB(255, 255, 255)
88:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
89: 
90:             .Page2.Caption   = "Dados"
91:             .Page2.BackColor = RGB(255, 255, 255)
92:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
93:         ENDWITH
94: 
95:         THIS.ConfigurarPaginaLista()
96:         THIS.ConfigurarPaginaDados()
97:     ENDPROC
98: 
99:     *--------------------------------------------------------------------------
100:     * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD e grid de listagem
101:     *--------------------------------------------------------------------------
102:     PROTECTED PROCEDURE ConfigurarPaginaLista()
103:         LOCAL loc_oPagina, loc_oGrid
104:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
105: 
106:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
107:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
108: 
109:         *-- Container cabecalho escuro (Top: 2+29=31 - compensa PageFrame.Top=-29)
110:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
111:         WITH loc_oPagina.cnt_4c_Cabecalho
112:             .Top         = 31
113:             .Left        = 0
114:             .Width       = THIS.Width
115:             .Height      = 80
116:             .BackColor   = RGB(100, 100, 100)
117:             .BorderWidth = 0
118:             .Visible     = .T.
119: 
120:             .AddObject("lbl_4c_Sombra", "Label")
121:             WITH .lbl_4c_Sombra
122:                 .Caption   = THIS.Caption
123:                 .Top       = 15
124:                 .Left      = 10
125:                 .Width     = THIS.Width
126:                 .Height    = 40
127:                 .FontName  = "Tahoma"
128:                 .FontSize  = 16
129:                 .FontBold  = .T.
130:                 .ForeColor = RGB(0, 0, 0)
131:                 .BackStyle = 0
132:                 .AutoSize  = .F.
133:                 .Visible   = .T.
134:             ENDWITH
135: 
136:             .AddObject("lbl_4c_Titulo", "Label")
137:             WITH .lbl_4c_Titulo
138:                 .Caption   = THIS.Caption
139:                 .Top       = 18
140:                 .Left      = 10
141:                 .Width     = THIS.Width
142:                 .Height    = 46

*-- Linhas 277 a 401:
277:             ENDWITH
278:         ENDWITH
279: 
280:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
281:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
282:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
283:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
284:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
285: 
286:         *-- Container saida (canonico: Left=917, Width=90)
287:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
288:         WITH loc_oPagina.cnt_4c_Saida
289:             .Top         = 29
290:             .Left        = 917
291:             .Width       = 90
292:             .Height      = 85
293:             .BackStyle   = 0
294:             .BorderWidth = 0
295:             .Visible     = .T.
296: 
297:             .AddObject("cmd_4c_Encerrar", "CommandButton")
298:             WITH .cmd_4c_Encerrar
299:                 .Caption         = "Encerrar"
300:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
301:                 .PicturePosition = 13
302:                 .Top             = 5
303:                 .Left            = 917
304:                 .Width           = 90
305:                 .Height          = 75
306:                 .BackColor       = RGB(255, 255, 255)
307:                 .ForeColor       = RGB(90, 90, 90)
308:                 .FontName        = "Tahoma"
309:                 .FontSize        = 8
310:                 .FontBold        = .T.
311:                 .FontItalic      = .T.
312:                 .SpecialEffect   = 0
313:                 .MousePointer    = 15
314:                 .WordWrap        = .T.
315:                 .AutoSize        = .F.
316:                 .Visible         = .T.
317:             ENDWITH
318:         ENDWITH
319: 
320:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
321: 
322:         *-- Grid de listagem (Top: 88+29=117; Width=890 nao sobrepoe cnt_4c_Saida)
323:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
324:         loc_oGrid = loc_oPagina.grd_4c_Dados
325:         loc_oGrid.Top         = 117
326:         loc_oGrid.Left        = 26
327:         loc_oGrid.Width       = 890
328:         loc_oGrid.Height      = 498
329:         loc_oGrid.ColumnCount = 2
330:         WITH loc_oGrid
331:             .FontName           = "Verdana"
332:             .FontSize           = 8
333:             .ForeColor          = RGB(90, 90, 90)
334:             .BackColor          = RGB(255, 255, 255)
335:             .GridLineColor      = RGB(238, 238, 238)
336:             .HighlightBackColor = RGB(255, 255, 255)
337:             .HighlightForeColor = RGB(15, 41, 104)
338:             .HighlightStyle     = 2
339:             .DeleteMark         = .F.
340:             .RecordMark         = .F.
341:             .RowHeight          = 16
342:             .ScrollBars         = 2
343:             .GridLines          = 3
344:             .Visible            = .T.
345: 
346:             .Column1.Width           = 80
347:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
348:             .Column1.Alignment       = 0
349: 
350:             .Column2.Width           = 290
351:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
352:             .Column2.Alignment       = 0
353:         ENDWITH
354: 
355:         THIS.TornarControlesVisiveis(loc_oPagina)
356:     ENDPROC
357: 
358:     *--------------------------------------------------------------------------
359:     * ConfigurarPaginaDados - Page2: botoes acao + todos os campos
360:     *--------------------------------------------------------------------------
361:     PROTECTED PROCEDURE ConfigurarPaginaDados()
362:         LOCAL loc_oPagina
363:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
364: 
365:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
366:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
367: 
368:         *-- Container botoes Confirmar/Cancelar (grupo_salva: Top=-4+29=25; Left=841)
369:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
370:         WITH loc_oPagina.cnt_4c_BotoesAcao
371:             .Top         = 25
372:             .Left        = 841
373:             .Width       = 160
374:             .Height      = 85
375:             .BackStyle   = 0
376:             .Visible     = .T.
377:         ENDWITH
378: 
379:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
380:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
381:             .Caption         = "Confirmar"
382:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
383:             .PicturePosition = 13
384:             .Top             = 5
385:             .Left            = 7
386:             .Width           = 75
387:             .Height          = 75
388:             .BackColor       = RGB(255, 255, 255)
389:             .ForeColor       = RGB(90, 90, 90)
390:             .FontName        = "Tahoma"
391:             .FontSize        = 8
392:             .FontBold        = .T.
393:             .FontItalic      = .T.
394:             .Themes          = .F.
395:             .SpecialEffect   = 0
396:             .MousePointer    = 15
397:             .WordWrap        = .T.
398:             .AutoSize        = .F.
399:             .Visible         = .T.
400:         ENDWITH
401: 

*-- Linhas 422 a 466:
422:             .Visible         = .T.
423:         ENDWITH
424: 
425:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
426:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
427: 
428:         *-- Label + TextBox: Codigo (getcodigos Top=133->162; Left=361/405; W=42/80; MaxLen=10)
429:         loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
430:         WITH loc_oPagina.lbl_4c_Codigo
431:             .Caption   = "C" + CHR(243) + "digo :"
432:             .Top       = 166
433:             .Left      = 361
434:             .Width     = 42
435:             .Height    = 15
436:             .FontName  = "Tahoma"
437:             .FontSize  = 8
438:             .FontBold  = .F.
439:             .BackStyle = 0
440:             .ForeColor = RGB(90, 90, 90)
441:             .AutoSize  = .F.
442:             .Visible   = .T.
443:         ENDWITH
444: 
445:         loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
446:         WITH loc_oPagina.txt_4c_Codigos
447:             .Value         = ""
448:             .Top           = 162
449:             .Left          = 405
450:             .Width         = 80
451:             .Height        = 21
452:             .MaxLength     = 10
453:             .Format        = "K!"
454:             .SpecialEffect = 1
455:             .FontName      = "Tahoma"
456:             .FontSize      = 8
457:             .ForeColor     = RGB(0, 0, 0)
458:             .BorderColor   = RGB(100, 100, 100)
459:             .Visible       = .T.
460:         ENDWITH
461: 
462:         *-- Label + TextBox: Descricao (getDescricaos Top=158->187; Left=348/405; W=55/290; H=23)
463:         loc_oPagina.AddObject("lbl_4c_Descricaos", "Label")
464:         WITH loc_oPagina.lbl_4c_Descricaos
465:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
466:             .Top       = 189

*-- Linhas 494 a 644:
494:         ENDWITH
495: 
496:         *-- Label + TextBox: Diretor (getDiretores Top=183->212; Left=361/405; W=42/80; H=23)
497:         *-- Lookup: F4 abre FormBuscaAuxiliar em SigCdUsu (Usuarios, NComps)
498:         loc_oPagina.AddObject("lbl_4c_Diretor", "Label")
499:         WITH loc_oPagina.lbl_4c_Diretor
500:             .Caption   = "Diretor :"
501:             .Top       = 214
502:             .Left      = 361
503:             .Width     = 42
504:             .Height    = 15
505:             .FontName  = "Tahoma"
506:             .FontSize  = 8
507:             .FontBold  = .F.
508:             .BackStyle = 0
509:             .ForeColor = RGB(90, 90, 90)
510:             .AutoSize  = .F.
511:             .Visible   = .T.
512:         ENDWITH
513: 
514:         loc_oPagina.AddObject("txt_4c_Diretores", "TextBox")
515:         WITH loc_oPagina.txt_4c_Diretores
516:             .Value         = ""
517:             .Top           = 212
518:             .Left          = 405
519:             .Width         = 80
520:             .Height        = 23
521:             .MaxLength     = 10
522:             .Format        = "K!"
523:             .SpecialEffect = 1
524:             .FontName      = "Tahoma"
525:             .FontSize      = 8
526:             .ForeColor     = RGB(0, 0, 0)
527:             .BorderColor   = RGB(100, 100, 100)
528:             .Visible       = .T.
529:         ENDWITH
530: 
531:         BINDEVENT(loc_oPagina.txt_4c_Diretores, "KeyPress", THIS, "DiretorKeyPress")
532: 
533:         *-- Label4 + opt_4c_SubclaEnc (Optiongroup1: nchksubs; Top=210->239; Left=249/400)
534:         loc_oPagina.AddObject("lbl_4c_SubclaEnc", "Label")
535:         WITH loc_oPagina.lbl_4c_SubclaEnc
536:             .Caption   = "Obriga Subclas. Encerramento :"
537:             .Top       = 239
538:             .Left      = 249
539:             .Width     = 154
540:             .Height    = 15
541:             .FontName  = "Tahoma"
542:             .FontSize  = 8
543:             .FontBold  = .F.
544:             .BackStyle = 0
545:             .ForeColor = RGB(90, 90, 90)
546:             .AutoSize  = .F.
547:             .Visible   = .T.
548:         ENDWITH
549: 
550:         loc_oPagina.AddObject("opt_4c_SubclaEnc", "OptionGroup")
551:         WITH loc_oPagina.opt_4c_SubclaEnc
552:             .ButtonCount = 2
553:             .BackStyle   = 0
554:             .BorderStyle = 0
555:             .Value       = 1
556:             .Top         = 238
557:             .Left        = 400
558:             .Width       = 109
559:             .Height      = 24
560:             .Visible     = .T.
561:             WITH .Buttons(1)
562:                 .Caption   = "Sim"
563:                 .BackStyle = 0
564:                 .ForeColor = RGB(90, 90, 90)
565:                 .Height    = 17
566:                 .Left      = 5
567:                 .Top       = 3
568:                 .Width     = 61
569:                 .AutoSize  = .F.
570:                 .Themes    = .F.
571:             ENDWITH
572:             WITH .Buttons(2)
573:                 .Caption   = "N" + CHR(227) + "o"
574:                 .FontName  = "Tahoma"
575:                 .FontSize  = 8
576:                 .BackStyle = 0
577:                 .ForeColor = RGB(90, 90, 90)
578:                 .Height    = 17
579:                 .Left      = 61
580:                 .Top       = 3
581:                 .Width     = 61
582:                 .AutoSize  = .F.
583:                 .Themes    = .F.
584:             ENDWITH
585:         ENDWITH
586: 
587:         *-- Label5 + opt_4c_Tipo (Optiongroup2: nchktipos; Top=232->261; Left=374/400)
588:         loc_oPagina.AddObject("lbl_4c_Tipo", "Label")
589:         WITH loc_oPagina.lbl_4c_Tipo
590:             .Caption   = "Tipo :"
591:             .Top       = 261
592:             .Left      = 374
593:             .Width     = 29
594:             .Height    = 15
595:             .FontName  = "Tahoma"
596:             .FontSize  = 8
597:             .FontBold  = .F.
598:             .BackStyle = 0
599:             .ForeColor = RGB(90, 90, 90)
600:             .AutoSize  = .F.
601:             .Visible   = .T.
602:         ENDWITH
603: 
604:         loc_oPagina.AddObject("opt_4c_Tipo", "OptionGroup")
605:         WITH loc_oPagina.opt_4c_Tipo
606:             .ButtonCount = 2
607:             .BackStyle   = 0
608:             .BorderStyle = 0
609:             .Value       = 1
610:             .Top         = 257
611:             .Left        = 400
612:             .Width       = 109
613:             .Height      = 24
614:             .Visible     = .T.
615:             WITH .Buttons(1)
616:                 .Caption   = "Sim"
617:                 .BackStyle = 0
618:                 .ForeColor = RGB(90, 90, 90)
619:                 .Height    = 17
620:                 .Left      = 5
621:                 .Top       = 3
622:                 .Width     = 61
623:                 .AutoSize  = .F.
624:                 .Themes    = .F.
625:             ENDWITH
626:             WITH .Buttons(2)
627:                 .Caption   = "N" + CHR(227) + "o"
628:                 .FontName  = "Tahoma"
629:                 .FontSize  = 8
630:                 .BackStyle = 0
631:                 .ForeColor = RGB(90, 90, 90)
632:                 .Height    = 17
633:                 .Left      = 61
634:                 .Top       = 3
635:                 .Width     = 61
636:                 .AutoSize  = .F.
637:                 .Themes    = .F.
638:             ENDWITH
639:         ENDWITH
640: 
641:         *-- Label6 + opt_4c_Autos (optAutos: autos; Top=251->280; Left=343/400)
642:         *-- Convencao invertida: Sim=Option1.Value=0, Nao=Option2.Value=1; default Value=2(Nao)
643:         loc_oPagina.AddObject("lbl_4c_Autos", "Label")
644:         WITH loc_oPagina.lbl_4c_Autos

*-- Linhas 656 a 755:
656:             .Visible   = .T.
657:         ENDWITH
658: 
659:         loc_oPagina.AddObject("opt_4c_Autos", "OptionGroup")
660:         WITH loc_oPagina.opt_4c_Autos
661:             .ButtonCount = 2
662:             .BackStyle   = 0
663:             .BorderStyle = 0
664:             .Value       = 2
665:             .Top         = 276
666:             .Left        = 400
667:             .Width       = 109
668:             .Height      = 24
669:             .Visible     = .T.
670:             WITH .Buttons(1)
671:                 .Caption   = "Sim"
672:                 .BackStyle = 0
673:                 .ForeColor = RGB(90, 90, 90)
674:                 .Height    = 17
675:                 .Left      = 5
676:                 .Top       = 3
677:                 .Width     = 61
678:                 .AutoSize  = .F.
679:                 .Themes    = .F.
680:             ENDWITH
681:             WITH .Buttons(2)
682:                 .Caption   = "N" + CHR(227) + "o"
683:                 .FontName  = "Tahoma"
684:                 .FontSize  = 8
685:                 .BackStyle = 0
686:                 .ForeColor = RGB(90, 90, 90)
687:                 .Height    = 17
688:                 .Left      = 61
689:                 .Top       = 3
690:                 .Width     = 61
691:                 .AutoSize  = .F.
692:                 .Themes    = .F.
693:             ENDWITH
694:         ENDWITH
695: 
696:         *-- Label7 + opt_4c_UtiLacto (Optiongroup3: UtiLacto; Top=271->300; Left=241/400)
697:         *-- Convencao invertida: Sim=Option1.Value=0, Nao=Option2.Value=1; default Value=2(Nao)
698:         *-- UtiLacto: campo de UI apenas (nao persistido no banco - SigCdDpt nao tem coluna)
699:         loc_oPagina.AddObject("lbl_4c_UtiLacto", "Label")
700:         WITH loc_oPagina.lbl_4c_UtiLacto
701:             .Caption   = "Utiliza nos dados de lan" + CHR(231) + "amento :"
702:             .Top       = 300
703:             .Left      = 241
704:             .Width     = 162
705:             .Height    = 15
706:             .FontName  = "Tahoma"
707:             .FontSize  = 8
708:             .FontBold  = .F.
709:             .BackStyle = 0
710:             .ForeColor = RGB(90, 90, 90)
711:             .AutoSize  = .F.
712:             .Visible   = .T.
713:         ENDWITH
714: 
715:         loc_oPagina.AddObject("opt_4c_UtiLacto", "OptionGroup")
716:         WITH loc_oPagina.opt_4c_UtiLacto
717:             .ButtonCount = 2
718:             .BackStyle   = 0
719:             .BorderStyle = 0
720:             .Value       = 2
721:             .Top         = 296
722:             .Left        = 400
723:             .Width       = 109
724:             .Height      = 24
725:             .Visible     = .T.
726:             WITH .Buttons(1)
727:                 .Caption   = "Sim"
728:                 .BackStyle = 0
729:                 .ForeColor = RGB(90, 90, 90)
730:                 .Height    = 17
731:                 .Left      = 5
732:                 .Top       = 3
733:                 .Width     = 61
734:                 .AutoSize  = .F.
735:                 .Themes    = .F.
736:             ENDWITH
737:             WITH .Buttons(2)
738:                 .Caption   = "N" + CHR(227) + "o"
739:                 .FontName  = "Tahoma"
740:                 .FontSize  = 8
741:                 .BackStyle = 0
742:                 .ForeColor = RGB(90, 90, 90)
743:                 .Height    = 17
744:                 .Left      = 61
745:                 .Top       = 3
746:                 .Width     = 61
747:                 .AutoSize  = .F.
748:                 .Themes    = .F.
749:             ENDWITH
750:         ENDWITH
751: 
752:         *-- Say44 (lbl_4c_GdeGrupo; Top=292->321; Left=339)
753:         loc_oPagina.AddObject("lbl_4c_GdeGrupo", "Label")
754:         WITH loc_oPagina.lbl_4c_GdeGrupo
755:             .Caption   = "Gde. Grupo :"

*-- Linhas 800 a 1471:
800:             .Column2.Header1.FontBold = .F.
801:         ENDWITH
802: 
803:         BINDEVENT(loc_oPagina.grd_4c_GruposGG, "AfterRowColChange", THIS, "GruposGGAfterRowColChange")
804: 
805:         *-- Command1 / cmd_4c_AdicionarGrupo (Top=356->385; Left=671; W=45; H=45)
806:         *-- Icone-only: Themes=.T. obrigatorio; nao desabilitar (icone some); guard no click handler
807:         loc_oPagina.AddObject("cmd_4c_AdicionarGrupo", "CommandButton")
808:         WITH loc_oPagina.cmd_4c_AdicionarGrupo
809:             .Caption       = ""
810:             .Picture       = gc_4c_CaminhoIcones + "geral_selecionar_26.jpg"
811:             .ToolTipText   = "Inserir"
812:             .Top           = 385
813:             .Left          = 671
814:             .Width         = 45
815:             .Height        = 45
816:             .BackColor     = RGB(255, 255, 255)
817:             .ForeColor     = RGB(0, 128, 0)
818:             .FontName      = "Arial"
819:             .FontSize      = 9
820:             .FontBold      = .T.
821:             .Themes        = .T.
822:             .SpecialEffect = 0
823:             .MousePointer  = 15
824:             .Visible       = .T.
825:         ENDWITH
826: 
827:         BINDEVENT(loc_oPagina.cmd_4c_AdicionarGrupo, "Click", THIS, "BtnAdicionarGrupoClick")
828: 
829:         *-- Command2 / cmd_4c_RemoverGrupo (Top=400->429; Left=671; W=45; H=45)
830:         *-- Icone-only: Themes=.T. obrigatorio; nao desabilitar; guard no click handler
831:         loc_oPagina.AddObject("cmd_4c_RemoverGrupo", "CommandButton")
832:         WITH loc_oPagina.cmd_4c_RemoverGrupo
833:             .Caption       = ""
834:             .Picture       = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
835:             .ToolTipText   = "Excluir"
836:             .Top           = 429
837:             .Left          = 671
838:             .Width         = 45
839:             .Height        = 45
840:             .BackColor     = RGB(255, 255, 255)
841:             .ForeColor     = RGB(255, 0, 0)
842:             .FontName      = "Arial"
843:             .FontSize      = 9
844:             .FontBold      = .T.
845:             .Themes        = .T.
846:             .SpecialEffect = 0
847:             .MousePointer  = 15
848:             .Visible       = .T.
849:         ENDWITH
850: 
851:         BINDEVENT(loc_oPagina.cmd_4c_RemoverGrupo, "Click", THIS, "BtnRemoverGrupoClick")
852: 
853:         THIS.TornarControlesVisiveis(loc_oPagina)
854:     ENDPROC
855: 
856:     *--------------------------------------------------------------------------
857:     * CarregarLista - Executa Buscar no BO e vincula grid
858:     *--------------------------------------------------------------------------
859:     PROCEDURE CarregarLista()
860:         LOCAL loc_lResultado, loc_oGrid
861:         loc_lResultado = .F.
862: 
863:         TRY
864:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
865:                 loc_lResultado = .T.
866:             ELSE
867:                 IF THIS.this_oBusinessObject.Buscar("")
868:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
869: 
870:                     loc_oGrid.ColumnCount = 2
871:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
872:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
873:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descricaos"
874: 
875:                     *-- Reconfigurar cabecalhos apos RecordSource (VFP reseta)
876:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
877:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
878: 
879:                     THIS.FormatarGridLista(loc_oGrid)
880:                     loc_lResultado = .T.
881:                 ENDIF
882:             ENDIF
883:         CATCH TO loc_oErro
884:             MsgErro("Erro em CarregarLista:" + CHR(13) + loc_oErro.Message, "Erro")
885:         ENDTRY
886: 
887:         RETURN loc_lResultado
888:     ENDPROC
889: 
890:     *--------------------------------------------------------------------------
891:     * AlternarPagina - Alterna entre Page1 (1=Lista) e Page2 (2=Dados)
892:     *--------------------------------------------------------------------------
893:     PROCEDURE AlternarPagina(par_nPagina)
894:         LOCAL loc_lResultado
895:         loc_lResultado = .F.
896: 
897:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
898:             RETURN .F.
899:         ENDIF
900: 
901:         TRY
902:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
903: 
904:             IF par_nPagina = 1
905:                 THIS.CarregarLista()
906:             ENDIF
907: 
908:             loc_lResultado = .T.
909:         CATCH TO loc_oErro
910:             MsgErro("Erro em AlternarPagina:" + CHR(13) + loc_oErro.Message, "Erro")
911:         ENDTRY
912: 
913:         RETURN loc_lResultado
914:     ENDPROC
915: 
916:     *--------------------------------------------------------------------------
917:     * BtnIncluirClick - Novo registro: prepara BO e vai para Page2
918:     *--------------------------------------------------------------------------
919:     PROCEDURE BtnIncluirClick()
920:         THIS.this_oBusinessObject.NovoRegistro()
921:         THIS.this_oBusinessObject.CarregarGrupos("")
922:         THIS.this_cModoAtual = "INCLUIR"
923:         THIS.LimparCampos()
924:         THIS.HabilitarCampos(.T.)
925:         THIS.pgf_4c_Paginas.ActivePage = 2
926:         THIS.pgf_4c_Paginas.Page2.txt_4c_Codigos.SetFocus
927:     ENDPROC
928: 
929:     *--------------------------------------------------------------------------
930:     * BtnVisualizarClick - Visualiza registro selecionado (somente leitura)
931:     *--------------------------------------------------------------------------
932:     PROCEDURE BtnVisualizarClick()
933:         LOCAL loc_cCodigo
934:         loc_cCodigo = ""
935: 
936:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
937:             SELECT cursor_4c_Dados
938:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
939:         ENDIF
940: 
941:         IF EMPTY(loc_cCodigo)
942:             MsgAviso("Selecione um departamento na lista.", "Visualizar")
943:             RETURN
944:         ENDIF
945: 
946:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
947:             THIS.this_oBusinessObject.CarregarGrupos(loc_cCodigo)
948:             THIS.this_cModoAtual = "VISUALIZAR"
949:             THIS.BOParaForm()
950:             THIS.HabilitarCampos(.F.)
951:             THIS.pgf_4c_Paginas.ActivePage = 2
952:         ENDIF
953:     ENDPROC
954: 
955:     *--------------------------------------------------------------------------
956:     * BtnAlterarClick - Carrega registro selecionado para edicao
957:     *--------------------------------------------------------------------------
958:     PROCEDURE BtnAlterarClick()
959:         LOCAL loc_cCodigo
960:         loc_cCodigo = ""
961: 
962:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
963:             SELECT cursor_4c_Dados
964:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
965:         ENDIF
966: 
967:         IF EMPTY(loc_cCodigo)
968:             MsgAviso("Selecione um departamento na lista.", "Alterar")
969:             RETURN
970:         ENDIF
971: 
972:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
973:             THIS.this_oBusinessObject.EditarRegistro()
974:             THIS.this_oBusinessObject.CarregarGrupos(loc_cCodigo)
975:             THIS.this_cModoAtual = "ALTERAR"
976:             THIS.BOParaForm()
977:             THIS.HabilitarCampos(.T.)
978:             THIS.pgf_4c_Paginas.ActivePage = 2
979:         ENDIF
980:     ENDPROC
981: 
982:     *--------------------------------------------------------------------------
983:     * BtnExcluirClick - Exclui registro selecionado com confirmacao
984:     *--------------------------------------------------------------------------
985:     PROCEDURE BtnExcluirClick()
986:         LOCAL loc_cCodigo, loc_lConfirma
987:         loc_cCodigo = ""
988: 
989:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
990:             SELECT cursor_4c_Dados
991:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
992:         ENDIF
993: 
994:         IF EMPTY(loc_cCodigo)
995:             MsgAviso("Selecione um departamento na lista.", "Excluir")
996:             RETURN
997:         ENDIF
998: 
999:         IF THIS.this_oBusinessObject.ValidarDepartamentoEmUso(loc_cCodigo)
1000:             MsgAviso("Departamento em uso por usu" + CHR(225) + "rios. N" + ;
1001:                 CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + "vel excluir.", "Excluir")
1002:             RETURN
1003:         ENDIF
1004: 
1005:         loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do departamento '" + ;
1006:             loc_cCodigo + "'?", "Confirmar Exclus" + CHR(227) + "o")
1007: 
1008:         IF loc_lConfirma
1009:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1010:                 IF THIS.this_oBusinessObject.Excluir()
1011:                     MsgInfo("Departamento exclu" + CHR(237) + "do com sucesso!", "Sucesso")
1012:                     THIS.CarregarLista()
1013:                 ENDIF
1014:             ENDIF
1015:         ENDIF
1016:     ENDPROC
1017: 
1018:     *--------------------------------------------------------------------------
1019:     * BtnBuscarClick - Filtra lista pelo texto digitado
1020:     *--------------------------------------------------------------------------
1021:     PROCEDURE BtnBuscarClick()
1022:         LOCAL loc_cFiltro, loc_oGrid
1023:         loc_cFiltro = InputBox("Informe parte da descri" + CHR(231) + CHR(227) + "o:", ;
1024:             "Buscar Departamento", "")
1025: 
1026:         IF VARTYPE(loc_cFiltro) != "C"
1027:             RETURN
1028:         ENDIF
1029: 
1030:         TRY
1031:             IF THIS.this_oBusinessObject.Buscar(ALLTRIM(loc_cFiltro))
1032:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
1033: 
1034:                 loc_oGrid.ColumnCount = 2
1035:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
1036:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
1037:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descricaos"
1038: 
1039:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1040:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1041: 
1042:                 THIS.FormatarGridLista(loc_oGrid)
1043: 
1044:                 IF RECCOUNT("cursor_4c_Dados") = 0
1045:                     MsgAviso("Nenhum departamento encontrado.", "Buscar")
1046:                 ENDIF
1047:             ENDIF
1048:         CATCH TO loc_oErro
1049:             MsgErro("Erro na busca:" + CHR(13) + loc_oErro.Message, "Erro")
1050:         ENDTRY
1051:     ENDPROC
1052: 
1053:     *--------------------------------------------------------------------------
1054:     * BtnEncerrarClick - Fecha o formulario
1055:     *--------------------------------------------------------------------------
1056:     PROCEDURE BtnEncerrarClick()
1057:         THIS.Release()
1058:     ENDPROC
1059: 
1060:     *--------------------------------------------------------------------------
1061:     * Destroy - Libera recursos
1062:     *--------------------------------------------------------------------------
1063:     PROCEDURE Destroy()
1064:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1065:             THIS.this_oBusinessObject = .NULL.
1066:         ENDIF
1067:         DODEFAULT()
1068:     ENDPROC
1069: 
1070:     *--------------------------------------------------------------------------
1071:     * FormatarGridLista - Formata visual do grid da lista
1072:     *--------------------------------------------------------------------------
1073:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1074:         WITH par_oGrid
1075:             .FontName = "Tahoma"
1076:             .FontSize = 8
1077:         ENDWITH
1078:     ENDPROC
1079: 
1080:     *--------------------------------------------------------------------------
1081:     * BtnSalvarClick - Valida campos e chama FormParaBO + BO.Salvar()
1082:     *--------------------------------------------------------------------------
1083:     PROCEDURE BtnSalvarClick()
1084:         LOCAL loc_oPagina, loc_cCodigo, loc_cDescricao
1085:         loc_oPagina    = THIS.pgf_4c_Paginas.Page2
1086:         loc_cCodigo    = ALLTRIM(loc_oPagina.txt_4c_Codigos.Value)
1087:         loc_cDescricao = ALLTRIM(loc_oPagina.txt_4c_Descricaos.Value)
1088: 
1089:         IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1090:             IF EMPTY(loc_cCodigo)
1091:                 MsgAviso("C" + CHR(243) + "digo precisa ser informado.", "Validar")
1092:                 loc_oPagina.txt_4c_Codigos.SetFocus
1093:                 RETURN
1094:             ENDIF
1095: 
1096:             IF EMPTY(loc_cDescricao)
1097:                 MsgAviso("Descri" + CHR(231) + CHR(227) + "o precisa ser informada.", "Validar")
1098:                 loc_oPagina.txt_4c_Descricaos.SetFocus
1099:                 RETURN
1100:             ENDIF
1101:         ENDIF
1102: 
1103:         TRY
1104:             THIS.FormParaBO()
1105:             IF THIS.this_oBusinessObject.Salvar()
1106:                 MsgInfo("Departamento salvo com sucesso!", "Sucesso")
1107:                 THIS.AlternarPagina(1)
1108:             ENDIF
1109:         CATCH TO loc_oErro
1110:             MsgErro("Erro ao salvar:" + CHR(13) + loc_oErro.Message, "Erro")
1111:         ENDTRY
1112:     ENDPROC
1113: 
1114:     *--------------------------------------------------------------------------
1115:     * BtnCancelarClick - Cancela e volta para lista
1116:     *--------------------------------------------------------------------------
1117:     PROCEDURE BtnCancelarClick()
1118:         THIS.AlternarPagina(1)
1119:         THIS.this_cModoAtual = "LISTA"
1120:     ENDPROC
1121: 
1122:     *--------------------------------------------------------------------------
1123:     * FormParaBO - Transfere dados da Page2 para as propriedades do BO
1124:     * OptionGroups adicionados na Fase 6 - verificados com PEMSTATUS
1125:     *--------------------------------------------------------------------------
1126:     PROTECTED PROCEDURE FormParaBO()
1127:         LOCAL loc_oBo, loc_oPagina
1128:         loc_oBo     = THIS.this_oBusinessObject
1129:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1130: 
1131:         loc_oBo.this_cCodigo    = ALLTRIM(loc_oPagina.txt_4c_Codigos.Value)
1132:         loc_oBo.this_cDescricao = ALLTRIM(loc_oPagina.txt_4c_Descricaos.Value)
1133:         loc_oBo.this_cDiretor   = ALLTRIM(loc_oPagina.txt_4c_Diretores.Value)
1134: 
1135:         IF PEMSTATUS(loc_oPagina, "opt_4c_SubclaEnc", 5)
1136:             loc_oBo.this_nSubclaEncerr = IIF(loc_oPagina.opt_4c_SubclaEnc.Value = 1, 1, 0)
1137:         ENDIF
1138:         IF PEMSTATUS(loc_oPagina, "opt_4c_Tipo", 5)
1139:             loc_oBo.this_nTipo = IIF(loc_oPagina.opt_4c_Tipo.Value = 1, 1, 0)
1140:         ENDIF
1141:         *-- optAutos: Sim=Value1=autos0, Nao=Value2=autos1 (convencao do legado)
1142:         IF PEMSTATUS(loc_oPagina, "opt_4c_Autos", 5)
1143:             loc_oBo.this_nAutomatico = IIF(loc_oPagina.opt_4c_Autos.Value = 1, 0, 1)
1144:         ENDIF
1145:         IF PEMSTATUS(loc_oPagina, "opt_4c_UtiLacto", 5)
1146:             loc_oBo.this_nUtilizaLanc = IIF(loc_oPagina.opt_4c_UtiLacto.Value = 1, 0, 1)
1147:         ENDIF
1148:     ENDPROC
1149: 
1150:     *--------------------------------------------------------------------------
1151:     * BOParaForm - Carrega propriedades do BO para os campos da Page2
1152:     * OptionGroups/grid adicionados na Fase 6 - verificados com PEMSTATUS
1153:     *--------------------------------------------------------------------------
1154:     PROTECTED PROCEDURE BOParaForm()
1155:         LOCAL loc_oBo, loc_oPagina
1156:         loc_oBo     = THIS.this_oBusinessObject
1157:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1158: 
1159:         loc_oPagina.txt_4c_Codigos.Value    = ALLTRIM(loc_oBo.this_cCodigo)
1160:         loc_oPagina.txt_4c_Descricaos.Value = ALLTRIM(loc_oBo.this_cDescricao)
1161:         loc_oPagina.txt_4c_Diretores.Value  = ALLTRIM(loc_oBo.this_cDiretor)
1162: 
1163:         IF PEMSTATUS(loc_oPagina, "opt_4c_SubclaEnc", 5)
1164:             loc_oPagina.opt_4c_SubclaEnc.Value = IIF(loc_oBo.this_nSubclaEncerr = 1, 1, 2)
1165:         ENDIF
1166:         IF PEMSTATUS(loc_oPagina, "opt_4c_Tipo", 5)
1167:             loc_oPagina.opt_4c_Tipo.Value = IIF(loc_oBo.this_nTipo = 1, 1, 2)
1168:         ENDIF
1169:         *-- optAutos: autos=0?Sim(Value1), autos=1?Nao(Value2)
1170:         IF PEMSTATUS(loc_oPagina, "opt_4c_Autos", 5)
1171:             loc_oPagina.opt_4c_Autos.Value = IIF(loc_oBo.this_nAutomatico = 0, 1, 2)
1172:         ENDIF
1173:         IF PEMSTATUS(loc_oPagina, "opt_4c_UtiLacto", 5)
1174:             loc_oPagina.opt_4c_UtiLacto.Value = IIF(loc_oBo.this_nUtilizaLanc = 0, 1, 2)
1175:         ENDIF
1176: 
1177:         IF PEMSTATUS(loc_oPagina, "grd_4c_GruposGG", 5)
1178:             IF USED("cursor_4c_DptGg")
1179:                 loc_oPagina.grd_4c_GruposGG.ColumnCount = 2
1180:                 loc_oPagina.grd_4c_GruposGG.RecordSource = "cursor_4c_DptGg"
1181:                 loc_oPagina.grd_4c_GruposGG.Column1.ControlSource = "cursor_4c_DptGg.CodGrupo"
1182:                 loc_oPagina.grd_4c_GruposGG.Column2.ControlSource = "cursor_4c_DptGg.descs"
1183:                 loc_oPagina.grd_4c_GruposGG.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1184:                 loc_oPagina.grd_4c_GruposGG.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1185:                 GO TOP IN cursor_4c_DptGg
1186:                 loc_oPagina.grd_4c_GruposGG.Refresh()
1187:             ENDIF
1188:         ENDIF
1189:     ENDPROC
1190: 
1191:     *--------------------------------------------------------------------------
1192:     * HabilitarCampos - Habilita/desabilita campos editaveis da Page2
1193:     *--------------------------------------------------------------------------
1194:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1195:         LOCAL loc_oPagina, loc_lHab
1196:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1197:         loc_lHab    = (par_lHabilitar = .T.)
1198: 
1199:         *-- Codigo: editavel apenas no modo INCLUIR
1200:         loc_oPagina.txt_4c_Codigos.Enabled    = (loc_lHab AND THIS.this_cModoAtual = "INCLUIR")
1201:         loc_oPagina.txt_4c_Descricaos.Enabled = loc_lHab
1202:         loc_oPagina.txt_4c_Diretores.Enabled  = loc_lHab
1203: 
1204:         IF PEMSTATUS(loc_oPagina, "opt_4c_SubclaEnc", 5)
1205:             loc_oPagina.opt_4c_SubclaEnc.Enabled = loc_lHab
1206:         ENDIF
1207:         IF PEMSTATUS(loc_oPagina, "opt_4c_Tipo", 5)
1208:             loc_oPagina.opt_4c_Tipo.Enabled = loc_lHab
1209:         ENDIF
1210:         IF PEMSTATUS(loc_oPagina, "opt_4c_Autos", 5)
1211:             loc_oPagina.opt_4c_Autos.Enabled = loc_lHab
1212:         ENDIF
1213:         IF PEMSTATUS(loc_oPagina, "opt_4c_UtiLacto", 5)
1214:             loc_oPagina.opt_4c_UtiLacto.Enabled = loc_lHab
1215:         ENDIF
1216:         IF PEMSTATUS(loc_oPagina, "grd_4c_GruposGG", 5)
1217:             loc_oPagina.grd_4c_GruposGG.ReadOnly = !loc_lHab
1218:         ENDIF
1219:         *-- Icones-only: Enabled=.F. faz icone sumir (VFP9 bug); guard no click handler
1220: 
1221:         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lHab
1222:         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1223:     ENDPROC
1224: 
1225:     *--------------------------------------------------------------------------
1226:     * LimparCampos - Limpa os valores dos campos da Page2
1227:     * Defaults dos OptionGroups seguem os defaults originais do legado
1228:     *--------------------------------------------------------------------------
1229:     PROTECTED PROCEDURE LimparCampos()
1230:         LOCAL loc_oPagina
1231:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1232: 
1233:         loc_oPagina.txt_4c_Codigos.Value    = ""
1234:         loc_oPagina.txt_4c_Descricaos.Value = ""
1235:         loc_oPagina.txt_4c_Diretores.Value  = ""
1236: 
1237:         *-- Optiongroup1 (nchksubs): default Value=1 (Sim) no legado
1238:         IF PEMSTATUS(loc_oPagina, "opt_4c_SubclaEnc", 5)
1239:             loc_oPagina.opt_4c_SubclaEnc.Value = 1
1240:         ENDIF
1241:         *-- Optiongroup2 (nchktipos): default Value=1 (Sim) no legado
1242:         IF PEMSTATUS(loc_oPagina, "opt_4c_Tipo", 5)
1243:             loc_oPagina.opt_4c_Tipo.Value = 1
1244:         ENDIF
1245:         *-- optAutos (autos): default Value=2 (Nao) no legado -> autos=1
1246:         IF PEMSTATUS(loc_oPagina, "opt_4c_Autos", 5)
1247:             loc_oPagina.opt_4c_Autos.Value = 2
1248:         ENDIF
1249:         *-- Optiongroup3 (UtiLacto): default Value=2 (Nao) no legado
1250:         IF PEMSTATUS(loc_oPagina, "opt_4c_UtiLacto", 5)
1251:             loc_oPagina.opt_4c_UtiLacto.Value = 2
1252:         ENDIF
1253: 
1254:         IF PEMSTATUS(loc_oPagina, "grd_4c_GruposGG", 5)
1255:             IF USED("cursor_4c_DptGg")
1256:                 SELECT cursor_4c_DptGg
1257:                 ZAP
1258:                 APPEND BLANK
1259:                 loc_oPagina.grd_4c_GruposGG.ColumnCount = 2
1260:                 loc_oPagina.grd_4c_GruposGG.RecordSource          = "cursor_4c_DptGg"
1261:                 loc_oPagina.grd_4c_GruposGG.Column1.ControlSource = "cursor_4c_DptGg.CodGrupo"
1262:                 loc_oPagina.grd_4c_GruposGG.Column2.ControlSource = "cursor_4c_DptGg.descs"
1263:                 loc_oPagina.grd_4c_GruposGG.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1264:                 loc_oPagina.grd_4c_GruposGG.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1265:                 loc_oPagina.grd_4c_GruposGG.Refresh()
1266:             ENDIF
1267:         ENDIF
1268:     ENDPROC
1269: 
1270:     *--------------------------------------------------------------------------
1271:     * DiretorKeyPress - F4 abre lookup de usuarios para campo Diretor
1272:     *--------------------------------------------------------------------------
1273:     PROCEDURE DiretorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1274:         IF par_nKeyCode = 115
1275:             THIS.AbrirBuscaDiretor()
1276:         ENDIF
1277:     ENDPROC
1278: 
1279:     *--------------------------------------------------------------------------
1280:     * AbrirBuscaDiretor - FormBuscaAuxiliar em SigCdUsu (Usuarios, NComps)
1281:     *--------------------------------------------------------------------------
1282:     PROTECTED PROCEDURE AbrirBuscaDiretor()
1283:         LOCAL loc_oBusca, loc_oPagina, loc_cValor
1284:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1285:         loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Diretores.Value)
1286: 
1287:         TRY
1288:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1289:                 "SigCdUsu", "cursor_4c_BuscaDiretor", ;
1290:                 "Usuarios", loc_cValor, "Selecionar Diretor")
1291: 
1292:             IF VARTYPE(loc_oBusca) = "O"
1293:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1294:                     IF USED("cursor_4c_BuscaDiretor")
1295:                         SELECT cursor_4c_BuscaDiretor
1296:                         loc_oPagina.txt_4c_Diretores.Value = ALLTRIM(cursor_4c_BuscaDiretor.Usuarios)
1297:                     ENDIF
1298:                 ELSE
1299:                     IF !loc_oBusca.this_lAchouRegistro
1300:                     loc_oBusca.mAddColuna("Usuarios", "", "Diretor")
1301:                     loc_oBusca.mAddColuna("NComps",   "", "Nome")
1302:                     loc_oBusca.Show()
1303:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDiretor")
1304:                         SELECT cursor_4c_BuscaDiretor
1305:                         loc_oPagina.txt_4c_Diretores.Value = ALLTRIM(cursor_4c_BuscaDiretor.Usuarios)
1306:                     ENDIF
1307:                     ENDIF
1308:                 ENDIF
1309:                 loc_oBusca.Release()
1310:             ENDIF
1311:         CATCH TO loc_oErro
1312:             MsgErro("Erro ao abrir busca de diretores:" + CHR(13) + loc_oErro.Message, "Erro")
1313:         ENDTRY
1314: 
1315:         IF USED("cursor_4c_BuscaDiretor")
1316:             USE IN cursor_4c_BuscaDiretor
1317:         ENDIF
1318:     ENDPROC
1319: 
1320:     *--------------------------------------------------------------------------
1321:     * GruposGGAfterRowColChange - Lookup SigCdGpr quando sai da coluna Codigo
1322:     *--------------------------------------------------------------------------
1323:     PROCEDURE GruposGGAfterRowColChange(par_nColIndex)
1324:         IF par_nColIndex = 2
1325:             THIS.ValidarCodigoGrupo()
1326:         ENDIF
1327:     ENDPROC
1328: 
1329:     *--------------------------------------------------------------------------
1330:     * BtnAdicionarGrupoClick - Adiciona linha vazia ao cursor_4c_DptGg
1331:     * Guard de modo: icone-only nao desabilitado (icone some), guard aqui
1332:     *--------------------------------------------------------------------------
1333:     PROCEDURE BtnAdicionarGrupoClick()
1334:         LOCAL loc_oPagina
1335:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1336:             RETURN
1337:         ENDIF
1338:         IF USED("cursor_4c_DptGg")
1339:             SELECT cursor_4c_DptGg
1340:             LOCATE FOR EMPTY(CodGrupo)
1341:             IF !FOUND()
1342:                 APPEND BLANK
1343:             ENDIF
1344:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1345:             IF PEMSTATUS(loc_oPagina, "grd_4c_GruposGG", 5)
1346:                 loc_oPagina.grd_4c_GruposGG.Refresh()
1347:                 loc_oPagina.grd_4c_GruposGG.Column1.SetFocus
1348:             ENDIF
1349:         ENDIF
1350:     ENDPROC
1351: 
1352:     *--------------------------------------------------------------------------
1353:     * BtnRemoverGrupoClick - Exclui linha corrente do cursor_4c_DptGg
1354:     * Guard de modo: icone-only nao desabilitado (icone some), guard aqui
1355:     *--------------------------------------------------------------------------
1356:     PROCEDURE BtnRemoverGrupoClick()
1357:         LOCAL loc_oPagina
1358:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1359:             RETURN
1360:         ENDIF
1361:         IF USED("cursor_4c_DptGg") AND !EOF("cursor_4c_DptGg") AND !BOF("cursor_4c_DptGg")
1362:             SELECT cursor_4c_DptGg
1363:             DELETE
1364:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1365:             IF PEMSTATUS(loc_oPagina, "grd_4c_GruposGG", 5)
1366:                 loc_oPagina.grd_4c_GruposGG.Refresh()
1367:             ENDIF
1368:         ENDIF
1369:     ENDPROC
1370: 
1371:     *--------------------------------------------------------------------------
1372:     * ValidarCodigoGrupo - Lookup SigCdGpr para preencher descricao do grupo
1373:     *--------------------------------------------------------------------------
1374:     PROTECTED PROCEDURE ValidarCodigoGrupo()
1375:         LOCAL loc_oBusca, loc_cCodigo
1376:         loc_cCodigo = ""
1377: 
1378:         IF !USED("cursor_4c_DptGg") OR EOF("cursor_4c_DptGg") OR BOF("cursor_4c_DptGg")
1379:             RETURN
1380:         ENDIF
1381: 
1382:         SELECT cursor_4c_DptGg
1383:         loc_cCodigo = ALLTRIM(cursor_4c_DptGg.CodGrupo)
1384: 
1385:         IF EMPTY(loc_cCodigo)
1386:             REPLACE descs WITH "" IN cursor_4c_DptGg
1387:             RETURN
1388:         ENDIF
1389: 
1390:         TRY
1391:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1392:                 "SigCdGpr", "cursor_4c_BuscaGrupo", ;
1393:                 "Codigos", loc_cCodigo, "Selecionar Grupo")
1394: 
1395:             IF VARTYPE(loc_oBusca) = "O"
1396:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1397:                     IF USED("cursor_4c_BuscaGrupo")
1398:                         SELECT cursor_4c_DptGg
1399:                         REPLACE CodGrupo WITH ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
1400:                         REPLACE descs    WITH ALLTRIM(cursor_4c_BuscaGrupo.Descs)
1401:                     ENDIF
1402:                 ELSE
1403:                     IF !loc_oBusca.this_lAchouRegistro
1404:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1405:                     loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
1406:                     loc_oBusca.Show()
1407:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
1408:                         SELECT cursor_4c_DptGg
1409:                         REPLACE CodGrupo WITH ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
1410:                         REPLACE descs    WITH ALLTRIM(cursor_4c_BuscaGrupo.Descs)
1411:                     ELSE
1412:                         SELECT cursor_4c_DptGg
1413:                         REPLACE CodGrupo WITH ""
1414:                         REPLACE descs    WITH ""
1415:                     ENDIF
1416:                     ENDIF
1417:                 ENDIF
1418:                 loc_oBusca.Release()
1419:             ENDIF
1420:         CATCH TO loc_oErro
1421:             MsgErro("Erro ao buscar grupo:" + CHR(13) + loc_oErro.Message, "Erro")
1422:         ENDTRY
1423: 
1424:         IF USED("cursor_4c_BuscaGrupo")
1425:             USE IN cursor_4c_BuscaGrupo
1426:         ENDIF
1427: 
1428:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_GruposGG", 5)
1429:             THIS.pgf_4c_Paginas.Page2.grd_4c_GruposGG.Refresh()
1430:         ENDIF
1431:     ENDPROC
1432: 
1433:     *--------------------------------------------------------------------------
1434:     * AjustarBotoesPorModo - Habilita/desabilita campos e botoes conforme modo
1435:     * INCLUIR/ALTERAR: Confirmar enabled, campos editaveis
1436:     * VISUALIZAR     : Confirmar disabled, campos readonly
1437:     *--------------------------------------------------------------------------
1438:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1439:         LOCAL loc_lHabilitado
1440:         loc_lHabilitado = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1441:         THIS.HabilitarCampos(loc_lHabilitado)
1442:     ENDPROC
1443: 
1444:     *--------------------------------------------------------------------------
1445:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
1446:     *--------------------------------------------------------------------------
1447:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1448:         LOCAL loc_nI, loc_oObjeto, loc_nP
1449: 
1450:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1451:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1452: 
1453:             IF VARTYPE(loc_oObjeto) = "O"
1454:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1455:                     loc_oObjeto.Visible = .T.
1456:                 ENDIF
1457: 
1458:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1459:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1460:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1461:                     ENDFOR
1462:                 ENDIF
1463: 
1464:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1465:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1466:                 ENDIF
1467:             ENDIF
1468:         ENDFOR
1469:     ENDPROC
1470: 
1471: ENDDEFINE


### BO (C:\4c\projeto\app\classes\DepartamentoBO.prg):
*============================================================================
* DepartamentoBO.prg - Business Object: Cadastro de Departamentos
* Migrado de: SIGCDDPT.SCX
* Tabela principal : SigCdDpt  (chave: codigos)
* Tabela relacionada: sigdptgg (grupos do departamento)
*============================================================================
DEFINE CLASS DepartamentoBO AS BusinessBase

    *-- Propriedades: SigCdDpt
    this_cCodigo       = ""   && codigos     C(10) - Chave Primaria
    this_cDescricao    = ""   && descricaos  C(40) - Descricao do departamento
    this_cDiretor      = ""   && diretors    C(10) - FK SigCdUsu.Usuarios
    this_nSubclaEncerr = 0    && nchksubs    N(1)  - Obriga Subclas. Encerramento (1=Sim 2=Nao)
    this_nTipo         = 0    && nchktipos   N(1)  - Tipo do departamento (1=Sim 2=Nao)
    this_nAutomatico   = 0    && autos       N(1)  - Automatico (1=Sim 2=Nao)
    this_nUtilizaLanc  = 0    && UtiLacto - campo exibido no form (nao existe no schema atual)

    *-- Nome do cursor de grupos (sigdptgg)
    this_cCursorGrupos = "cursor_4c_DptGg"

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdDpt"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - SELECT todos os departamentos (filtro opcional por descricao)
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT codigos, descricaos, diretors" + ;
                       " FROM SigCdDpt"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + ;
                    " WHERE UPPER(descricaos) LIKE UPPER(" + ;
                    EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ")"
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY codigos"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar departamentos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - SELECT registro por chave primaria + grupos
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT codigos, descricaos, diretors," + ;
                       " nchksubs, nchktipos, autos" + ;
                       " FROM SigCdDpt" + ;
                       " WHERE codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                IF loc_lResultado
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar departamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigo       = ALLTRIM(TratarNulo(codigos, "C"))
                THIS.this_cDescricao    = ALLTRIM(TratarNulo(descricaos, "C"))
                THIS.this_cDiretor      = ALLTRIM(TratarNulo(diretors, "C"))
                THIS.this_nSubclaEncerr = TratarNulo(nchksubs, "N")
                THIS.this_nTipo         = TratarNulo(nchktipos, "N")
                THIS.this_nAutomatico   = TratarNulo(autos, "N")
                THIS.this_nUtilizaLanc  = 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.CarregarDoCursor:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SigCdDpt + salvar grupos
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdDpt" + ;
                       " (codigos, descricaos, diretors, nchksubs, nchktipos, autos)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigo) + ", " + ;
                       EscaparSQL(THIS.this_cDescricao) + ", " + ;
                       EscaparSQL(THIS.this_cDiretor) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nSubclaEncerr) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTipo) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nAutomatico) + ")"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Ins")
                TABLEREVERT(.T., "cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = THIS.SalvarGrupos(THIS.this_cCodigo)
                IF !loc_lResultado
                    MsgErro("Departamento inserido mas erro ao salvar grupos.", "Erro")
                ENDIF
            ELSE
                MsgErro("Erro ao inserir departamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigCdDpt + reprocessar grupos
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdDpt SET" + ;
                       " descricaos = " + EscaparSQL(THIS.this_cDescricao) + "," + ;
                       " diretors   = " + EscaparSQL(THIS.this_cDiretor)   + "," + ;
                       " nchksubs   = " + FormatarNumeroSQL(THIS.this_nSubclaEncerr) + "," + ;
                       " nchktipos  = " + FormatarNumeroSQL(THIS.this_nTipo)         + "," + ;
                       " autos      = " + FormatarNumeroSQL(THIS.this_nAutomatico)   + ;
                       " WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Upd")
                TABLEREVERT(.T., "cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = THIS.SalvarGrupos(THIS.this_cCodigo)
                IF !loc_lResultado
                    MsgErro("Departamento atualizado mas erro ao salvar grupos.", "Erro")
                ENDIF
            ELSE
                MsgErro("Erro ao atualizar departamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE sigdptgg + DELETE SigCdDpt
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            *-- Remove grupos relacionados primeiro
            loc_cSQL = "DELETE FROM sigdptgg WHERE coddepto = " + ;
                       EscaparSQL(THIS.this_cCodigo)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_DelGg")
                TABLEREVERT(.T., "cursor_4c_DelGg")
                USE IN cursor_4c_DelGg
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelGg")
            IF USED("cursor_4c_DelGg")
                USE IN cursor_4c_DelGg
            ENDIF

            IF loc_nResultado < 0
                MsgErro("Erro ao excluir grupos do departamento:" + CHR(13) + ;
                         CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Remove o registro principal
                loc_cSQL = "DELETE FROM SigCdDpt WHERE codigos = " + ;
                           EscaparSQL(THIS.this_cCodigo)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_Del")
                    TABLEREVERT(.T., "cursor_4c_Del")
                    USE IN cursor_4c_Del
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
                IF USED("cursor_4c_Del")
                    USE IN cursor_4c_Del
                ENDIF

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir departamento:" + CHR(13) + ;
                             CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.ExecutarExclusao:" + CHR(13) + ;
                     loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarGrupos - Carrega grupos do dpto no cursor_4c_DptGg (para o grid)
    *--------------------------------------------------------------------------
    FUNCTION CarregarGrupos(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        LOCAL loc_nTotal, loc_nI, loc_aDepto[1], loc_aGrupo[1], loc_aDescs[1]
        loc_lResultado = .F.

        TRY
            IF USED(THIS.this_cCursorGrupos)
                USE IN (THIS.this_cCursorGrupos)
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_DptGg (CodDepto C(10), CodGrupo C(3), descs C(40))
            SET NULL OFF

            IF !EMPTY(ALLTRIM(par_cCodigo))
                loc_cSQL = "SELECT a.coddepto, a.codgrupo, b.descs" + ;
                           " FROM sigdptgg a" + ;
                           " JOIN SigCdGpr b ON a.codgrupo = b.codigos" + ;
                           " WHERE a.coddepto = " + EscaparSQL(ALLTRIM(par_cCodigo)) + ;
                           " ORDER BY a.codgrupo"

                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_DptGgTmp")
                    TABLEREVERT(.T., "cursor_4c_DptGgTmp")
                    USE IN cursor_4c_DptGgTmp
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DptGgTmp")
                IF loc_nResultado >= 0
                    loc_nTotal = RECCOUNT("cursor_4c_DptGgTmp")
                    IF loc_nTotal > 0
                        DIMENSION loc_aDepto[loc_nTotal]
                        DIMENSION loc_aGrupo[loc_nTotal]
                        DIMENSION loc_aDescs[loc_nTotal]
                        SELECT cursor_4c_DptGgTmp
                        GO TOP
                        FOR loc_nI = 1 TO loc_nTotal
                            loc_aDepto[loc_nI] = ALLTRIM(cursor_4c_DptGgTmp.coddepto)
                            loc_aGrupo[loc_nI] = ALLTRIM(cursor_4c_DptGgTmp.codgrupo)
                            loc_aDescs[loc_nI]  = ALLTRIM(cursor_4c_DptGgTmp.descs)
                            IF !EOF("cursor_4c_DptGgTmp")
                                SKIP IN cursor_4c_DptGgTmp
                            ENDIF
                        ENDFOR
                        FOR loc_nI = 1 TO loc_nTotal
                            SELECT cursor_4c_DptGg
                            APPEND BLANK
                            REPLACE CodDepto WITH loc_aDepto[loc_nI], ;
                                    CodGrupo WITH loc_aGrupo[loc_nI], ;
                                    descs    WITH loc_aDescs[loc_nI]
                        ENDFOR
                    ENDIF
                    IF USED("cursor_4c_DptGgTmp")
                        USE IN cursor_4c_DptGgTmp
                    ENDIF
                ELSE
                    MsgErro("Erro ao carregar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            *-- Garante linha em branco para o grid poder receber entrada
            IF RECCOUNT("cursor_4c_DptGg") = 0
                SELECT cursor_4c_DptGg
                APPEND BLANK
            ENDIF

            GO TOP IN cursor_4c_DptGg
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.CarregarGrupos:" + CHR(13) + ;
                     loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarGrupos - Persiste cursor_4c_DptGg em sigdptgg
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION SalvarGrupos(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        LOCAL loc_nTotal, loc_nI, loc_aGrupos[1]
        loc_lResultado = .F.

        TRY
            *-- Remove todos os grupos existentes para este departamento
            loc_cSQL = "DELETE FROM sigdptgg WHERE coddepto = " + ;
                       EscaparSQL(ALLTRIM(par_cCodigo))
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_DelGrp")
                TABLEREVERT(.T., "cursor_4c_DelGrp")
                USE IN cursor_4c_DelGrp
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelGrp")
            IF USED("cursor_4c_DelGrp")
                USE IN cursor_4c_DelGrp
            ENDIF

            IF loc_nResultado < 0
                MsgErro("Erro ao limpar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lResultado = .T.

                *-- Coleta grupos nao-vazios do cursor numa array
                IF USED(THIS.this_cCursorGrupos)
                    loc_nTotal = RECCOUNT(THIS.this_cCursorGrupos)
                    IF loc_nTotal > 0
                        DIMENSION loc_aGrupos[loc_nTotal]
                        SELECT (THIS.this_cCursorGrupos)
                        GO TOP
                        FOR loc_nI = 1 TO loc_nTotal
                            loc_aGrupos[loc_nI] = ALLTRIM(cursor_4c_DptGg.CodGrupo)
                            IF !EOF("cursor_4c_DptGg")
                                SKIP IN cursor_4c_DptGg
                            ENDIF
                        ENDFOR

                        *-- Insere os grupos via SQL
                        FOR loc_nI = 1 TO loc_nTotal
                            IF !EMPTY(loc_aGrupos[loc_nI])
                                loc_cSQL = "INSERT INTO sigdptgg (pkchave, coddepto, codgrupo)" + ;
                                           " VALUES (" + ;
                                           "LEFT(REPLACE(CONVERT(VARCHAR(36),NEWID()),'-',''),20)," + ;
                                           EscaparSQL(ALLTRIM(par_cCodigo)) + "," + ;
                                           EscaparSQL(LEFT(loc_aGrupos[loc_nI], 3)) + ")"
                                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                                IF USED("cursor_4c_InsGrp")
                                    TABLEREVERT(.T., "cursor_4c_InsGrp")
                                    USE IN cursor_4c_InsGrp
                                ENDIF

                                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsGrp")
                                IF USED("cursor_4c_InsGrp")
                                    USE IN cursor_4c_InsGrp
                                ENDIF
                                IF loc_nResultado < 0
                                    MsgErro("Erro ao inserir grupo " + loc_aGrupos[loc_nI] + ;
                                             ":" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                                    loc_lResultado = .F.
                                ENDIF
                            ENDIF
                        ENDFOR
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.SalvarGrupos:" + CHR(13) + ;
                     loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarGruposDuplicados - Verifica se ha codigos de grupo repetidos
    *--------------------------------------------------------------------------
    FUNCTION ValidarGruposDuplicados()
        LOCAL loc_lValido, loc_nDuplic
        loc_lValido = .T.

        TRY
            IF USED(THIS.this_cCursorGrupos) AND RECCOUNT(THIS.this_cCursorGrupos) > 0
                SELECT CodGrupo FROM cursor_4c_DptGg ;
                       WHERE !EMPTY(CodGrupo) ;
                       GROUP BY CodGrupo ;
                       HAVING COUNT(*) > 1 ;
                       INTO CURSOR cursor_4c_Duplicas

                loc_nDuplic = RECCOUNT("cursor_4c_Duplicas")
                IF USED("cursor_4c_Duplicas")
                    USE IN cursor_4c_Duplicas
                ENDIF

                IF loc_nDuplic > 0
                    loc_lValido = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.ValidarGruposDuplicados:" + CHR(13) + ;
                     loc_oErro.Message, "Erro")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarAutomatico - Verifica se ja existe outro departamento automatico
    * par_cCodIgnorar: codigo do registro atual (para excluir da verificacao)
    *--------------------------------------------------------------------------
    FUNCTION ValidarAutomatico(par_cCodIgnorar)
        LOCAL loc_lValido, loc_cSQL, loc_nResultado, loc_nTotal
        loc_lValido = .T.

        TRY
            IF THIS.this_nAutomatico = 1
                loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdDpt WHERE autos = 1"
                IF VARTYPE(par_cCodIgnorar) = "C" AND !EMPTY(par_cCodIgnorar)
                    loc_cSQL = loc_cSQL + ;
                        " AND codigos <> " + EscaparSQL(ALLTRIM(par_cCodIgnorar))
                ENDIF

                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_AutoChk")
                    TABLEREVERT(.T., "cursor_4c_AutoChk")
                    USE IN cursor_4c_AutoChk
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AutoChk")
                IF loc_nResultado >= 0
                    SELECT cursor_4c_AutoChk
                    loc_nTotal = cursor_4c_AutoChk.Total
                    IF loc_nTotal > 0
                        loc_lValido = .F.
                    ENDIF
                ELSE
                    MsgErro("Erro ao verificar automatico:" + CHR(13) + ;
                             CapturarErroSQL(), "Erro SQL")
                    loc_lValido = .F.
                ENDIF

                IF USED("cursor_4c_AutoChk")
                    USE IN cursor_4c_AutoChk
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.ValidarAutomatico:" + CHR(13) + ;
                     loc_oErro.Message, "Erro")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDepartamentoEmUso - Verifica se o depto esta vinculado a usuarios
    *--------------------------------------------------------------------------
    FUNCTION ValidarDepartamentoEmUso(par_cCodigo)
        LOCAL loc_lEmUso, loc_cSQL, loc_nResultado, loc_nTotal
        loc_lEmUso = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdUsu" + ;
                       " WHERE deptos = " + EscaparSQL(ALLTRIM(par_cCodigo))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_UsoChk")
                TABLEREVERT(.T., "cursor_4c_UsoChk")
                USE IN cursor_4c_UsoChk
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsoChk")
            IF loc_nResultado >= 0
                SELECT cursor_4c_UsoChk
                loc_nTotal = cursor_4c_UsoChk.Total
                IF loc_nTotal > 0
                    loc_lEmUso = .T.
                ENDIF
            ELSE
                MsgErro("Erro ao verificar uso do departamento:" + CHR(13) + ;
                         CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_UsoChk")
                USE IN cursor_4c_UsoChk
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.ValidarDepartamentoEmUso:" + CHR(13) + ;
                     loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lEmUso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarCodigoExistente - Verifica se o codigo ja existe na tabela
    *--------------------------------------------------------------------------
    FUNCTION ValidarCodigoExistente(par_cCodigo)
        LOCAL loc_lExiste, loc_cSQL, loc_nResultado, loc_nTotal
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdDpt" + ;
                       " WHERE codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_CodChk")
                TABLEREVERT(.T., "cursor_4c_CodChk")
                USE IN cursor_4c_CodChk
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CodChk")
            IF loc_nResultado >= 0
                SELECT cursor_4c_CodChk
                loc_nTotal = cursor_4c_CodChk.Total
                IF loc_nTotal > 0
                    loc_lExiste = .T.
                ENDIF
            ELSE
                MsgErro("Erro ao verificar codigo:" + CHR(13) + ;
                         CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_CodChk")
                USE IN cursor_4c_CodChk
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.ValidarCodigoExistente:" + CHR(13) + ;
                     loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lExiste
    ENDFUNC

ENDDEFINE

