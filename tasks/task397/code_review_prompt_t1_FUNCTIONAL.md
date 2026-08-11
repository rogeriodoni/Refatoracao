# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (7)
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [GRID-HEADER] Header Caption 'Departamento' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Código, Descrição. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Departamento' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Código, Descrição. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Departamento' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Código, Descrição. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormDepartamento.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1452 linhas total):

*-- Linhas 24 a 139:
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
50:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
51:                     THIS.CarregarLista()
52:                 ENDIF
53: 
54:                 THIS.pgf_4c_Paginas.Visible = .T.
55:                 THIS.pgf_4c_Paginas.ActivePage = 1
56:                 THIS.this_cModoAtual = "LISTA"
57:                 loc_lSucesso = .T.
58:             ENDIF
59: 
60:         CATCH TO loc_oErro
61:             MostrarErro("Erro ao inicializar Formul" + CHR(225) + "rio:" + CHR(13) + ;
62:                 loc_oErro.Message, "Erro")
63:         ENDTRY
64: 
65:         RETURN loc_lSucesso
66:     ENDPROC
67: 
68:     *--------------------------------------------------------------------------
69:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
70:     *--------------------------------------------------------------------------
71:     PROTECTED PROCEDURE ConfigurarPageFrame()
72:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
73:         THIS.pgf_4c_Paginas.PageCount = 2
74: 
75:         WITH THIS.pgf_4c_Paginas
76:             .Top     = -29
77:             .Left    = 0
78:             .Width   = THIS.Width
79:             .Height  = THIS.Height + 29
80:             .Tabs    = .F.
81:             .Visible = .T.
82: 
83:             .Page1.Caption   = "Lista"
84:             .Page1.BackColor = RGB(255, 255, 255)
85:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
86: 
87:             .Page2.Caption   = "Dados"
88:             .Page2.BackColor = RGB(255, 255, 255)
89:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
90:         ENDWITH
91: 
92:         THIS.ConfigurarPaginaLista()
93:         THIS.ConfigurarPaginaDados()
94:     ENDPROC
95: 
96:     *--------------------------------------------------------------------------
97:     * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD e grid de listagem
98:     *--------------------------------------------------------------------------
99:     PROTECTED PROCEDURE ConfigurarPaginaLista()
100:         LOCAL loc_oPagina, loc_oGrid
101:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
102: 
103:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
104:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
105: 
106:         *-- Container cabecalho escuro (Top: 2+29=31 - compensa PageFrame.Top=-29)
107:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
108:         WITH loc_oPagina.cnt_4c_Cabecalho
109:             .Top         = 31
110:             .Left        = 0
111:             .Width       = THIS.Width
112:             .Height      = 80
113:             .BackColor   = RGB(100, 100, 100)
114:             .BorderWidth = 0
115:             .Visible     = .T.
116: 
117:             .AddObject("lbl_4c_Sombra", "Label")
118:             WITH .lbl_4c_Sombra
119:                 .Caption   = THIS.Caption
120:                 .Top       = 15
121:                 .Left      = 10
122:                 .Width     = THIS.Width
123:                 .Height    = 40
124:                 .FontName  = "Tahoma"
125:                 .FontSize  = 16
126:                 .FontBold  = .T.
127:                 .ForeColor = RGB(0, 0, 0)
128:                 .BackStyle = 0
129:                 .AutoSize  = .F.
130:                 .Visible   = .T.
131:             ENDWITH
132: 
133:             .AddObject("lbl_4c_Titulo", "Label")
134:             WITH .lbl_4c_Titulo
135:                 .Caption   = THIS.Caption
136:                 .Top       = 18
137:                 .Left      = 10
138:                 .Width     = THIS.Width
139:                 .Height    = 46

*-- Linhas 274 a 398:
274:             ENDWITH
275:         ENDWITH
276: 
277:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
278:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
279:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
280:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
281:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
282: 
283:         *-- Container saida (canonico: Left=917, Width=90)
284:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
285:         WITH loc_oPagina.cnt_4c_Saida
286:             .Top         = 29
287:             .Left        = 917
288:             .Width       = 90
289:             .Height      = 85
290:             .BackStyle   = 0
291:             .BorderWidth = 0
292:             .Visible     = .T.
293: 
294:             .AddObject("cmd_4c_Encerrar", "CommandButton")
295:             WITH .cmd_4c_Encerrar
296:                 .Caption         = "Encerrar"
297:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
298:                 .PicturePosition = 13
299:                 .Top             = 5
300:                 .Left            = 917
301:                 .Width           = 90
302:                 .Height          = 75
303:                 .BackColor       = RGB(255, 255, 255)
304:                 .ForeColor       = RGB(90, 90, 90)
305:                 .FontName        = "Comic Sans MS"
306:                 .FontSize        = 8
307:                 .FontBold        = .T.
308:                 .FontItalic      = .T.
309:                 .SpecialEffect   = 0
310:                 .MousePointer    = 15
311:                 .WordWrap        = .T.
312:                 .AutoSize        = .F.
313:                 .Visible         = .T.
314:             ENDWITH
315:         ENDWITH
316: 
317:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
318: 
319:         *-- Grid de listagem (Top: 88+29=117; Width=890 nao sobrepoe cnt_4c_Saida)
320:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
321:         loc_oGrid = loc_oPagina.grd_4c_Dados
322:         loc_oGrid.Top         = 117
323:         loc_oGrid.Left        = 26
324:         loc_oGrid.Width       = 890
325:         loc_oGrid.Height      = 498
326:         loc_oGrid.ColumnCount = 2
327:         WITH loc_oGrid
328:             .FontName           = "Verdana"
329:             .FontSize           = 8
330:             .ForeColor          = RGB(90, 90, 90)
331:             .BackColor          = RGB(255, 255, 255)
332:             .GridLineColor      = RGB(238, 238, 238)
333:             .HighlightBackColor = RGB(255, 255, 255)
334:             .HighlightForeColor = RGB(15, 41, 104)
335:             .HighlightStyle     = 2
336:             .DeleteMark         = .F.
337:             .RecordMark         = .F.
338:             .RowHeight          = 16
339:             .ScrollBars         = 2
340:             .GridLines          = 3
341:             .Visible            = .T.
342: 
343:             .Column1.Width           = 80
344:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
345:             .Column1.Alignment       = 0
346: 
347:             .Column2.Width           = 290
348:             .Column2.Header1.Caption = "Departamento"
349:             .Column2.Alignment       = 0
350:         ENDWITH
351: 
352:         THIS.TornarControlesVisiveis(loc_oPagina)
353:     ENDPROC
354: 
355:     *--------------------------------------------------------------------------
356:     * ConfigurarPaginaDados - Page2: botoes acao + todos os campos
357:     *--------------------------------------------------------------------------
358:     PROTECTED PROCEDURE ConfigurarPaginaDados()
359:         LOCAL loc_oPagina
360:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
361: 
362:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
363:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
364: 
365:         *-- Container botoes Confirmar/Cancelar (grupo_salva: Top=-4+29=25; Left=841)
366:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
367:         WITH loc_oPagina.cnt_4c_BotoesAcao
368:             .Top         = 25
369:             .Left        = 841
370:             .Width       = 160
371:             .Height      = 85
372:             .BackStyle   = 0
373:             .Visible     = .T.
374:         ENDWITH
375: 
376:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
377:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
378:             .Caption         = "Confirmar"
379:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
380:             .PicturePosition = 13
381:             .Top             = 5
382:             .Left            = 7
383:             .Width           = 75
384:             .Height          = 75
385:             .BackColor       = RGB(255, 255, 255)
386:             .ForeColor       = RGB(90, 90, 90)
387:             .FontName        = "Comic Sans MS"
388:             .FontSize        = 8
389:             .FontBold        = .T.
390:             .FontItalic      = .T.
391:             .Themes          = .F.
392:             .SpecialEffect   = 0
393:             .MousePointer    = 15
394:             .WordWrap        = .T.
395:             .AutoSize        = .F.
396:             .Visible         = .T.
397:         ENDWITH
398: 

*-- Linhas 419 a 463:
419:             .Visible         = .T.
420:         ENDWITH
421: 
422:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
423:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
424: 
425:         *-- Label + TextBox: Codigo (getcodigos Top=133->162; Left=361/405; W=42/80; MaxLen=10)
426:         loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
427:         WITH loc_oPagina.lbl_4c_Codigo
428:             .Caption   = "C" + CHR(243) + "digo :"
429:             .Top       = 166
430:             .Left      = 361
431:             .Width     = 42
432:             .Height    = 15
433:             .FontName  = "Tahoma"
434:             .FontSize  = 8
435:             .FontBold  = .F.
436:             .BackStyle = 0
437:             .ForeColor = RGB(90, 90, 90)
438:             .AutoSize  = .F.
439:             .Visible   = .T.
440:         ENDWITH
441: 
442:         loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
443:         WITH loc_oPagina.txt_4c_Codigos
444:             .Value         = ""
445:             .Top           = 162
446:             .Left          = 405
447:             .Width         = 80
448:             .Height        = 21
449:             .MaxLength     = 10
450:             .Format        = "K!"
451:             .SpecialEffect = 1
452:             .FontName      = "Tahoma"
453:             .FontSize      = 8
454:             .ForeColor     = RGB(0, 0, 0)
455:             .BorderColor   = RGB(100, 100, 100)
456:             .Visible       = .T.
457:         ENDWITH
458: 
459:         *-- Label + TextBox: Descricao (getDescricaos Top=158->187; Left=348/405; W=55/290; H=23)
460:         loc_oPagina.AddObject("lbl_4c_Descricaos", "Label")
461:         WITH loc_oPagina.lbl_4c_Descricaos
462:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
463:             .Top       = 189

*-- Linhas 491 a 637:
491:         ENDWITH
492: 
493:         *-- Label + TextBox: Diretor (getDiretores Top=183->212; Left=361/405; W=42/80; H=23)
494:         *-- Lookup: F4 abre FormBuscaAuxiliar em SigCdUsu (Usuarios, NComps)
495:         loc_oPagina.AddObject("lbl_4c_Diretor", "Label")
496:         WITH loc_oPagina.lbl_4c_Diretor
497:             .Caption   = "Diretor :"
498:             .Top       = 214
499:             .Left      = 361
500:             .Width     = 42
501:             .Height    = 15
502:             .FontName  = "Tahoma"
503:             .FontSize  = 8
504:             .FontBold  = .F.
505:             .BackStyle = 0
506:             .ForeColor = RGB(90, 90, 90)
507:             .AutoSize  = .F.
508:             .Visible   = .T.
509:         ENDWITH
510: 
511:         loc_oPagina.AddObject("txt_4c_Diretores", "TextBox")
512:         WITH loc_oPagina.txt_4c_Diretores
513:             .Value         = ""
514:             .Top           = 212
515:             .Left          = 405
516:             .Width         = 80
517:             .Height        = 23
518:             .MaxLength     = 10
519:             .Format        = "K!"
520:             .SpecialEffect = 1
521:             .FontName      = "Tahoma"
522:             .FontSize      = 8
523:             .ForeColor     = RGB(0, 0, 0)
524:             .BorderColor   = RGB(100, 100, 100)
525:             .Visible       = .T.
526:         ENDWITH
527: 
528:         BINDEVENT(loc_oPagina.txt_4c_Diretores, "KeyPress", THIS, "DiretorKeyPress")
529: 
530:         *-- Label4 + opt_4c_SubclaEnc (Optiongroup1: nchksubs; Top=210->239; Left=249/400)
531:         loc_oPagina.AddObject("lbl_4c_SubclaEnc", "Label")
532:         WITH loc_oPagina.lbl_4c_SubclaEnc
533:             .Caption   = "Obriga Subclas. Encerramento :"
534:             .Top       = 239
535:             .Left      = 249
536:             .Width     = 154
537:             .Height    = 15
538:             .FontName  = "Tahoma"
539:             .FontSize  = 8
540:             .FontBold  = .F.
541:             .BackStyle = 0
542:             .ForeColor = RGB(90, 90, 90)
543:             .AutoSize  = .F.
544:             .Visible   = .T.
545:         ENDWITH
546: 
547:         loc_oPagina.AddObject("opt_4c_SubclaEnc", "OptionGroup")
548:         WITH loc_oPagina.opt_4c_SubclaEnc
549:             .ButtonCount = 2
550:             .BackStyle   = 0
551:             .BorderStyle = 0
552:             .Value       = 1
553:             .Top         = 238
554:             .Left        = 400
555:             .Width       = 109
556:             .Height      = 24
557:             .Visible     = .T.
558:             WITH .Buttons(1)
559:                 .Caption   = "Sim"
560:                 .BackStyle = 0
561:                 .ForeColor = RGB(90, 90, 90)
562:                 .Height    = 17
563:                 .Left      = 5
564:                 .Top       = 3
565:                 .Width     = 61
566:             ENDWITH
567:             WITH .Buttons(2)
568:                 .Caption   = "N" + CHR(227) + "o"
569:                 .FontName  = "Tahoma"
570:                 .FontSize  = 8
571:                 .BackStyle = 0
572:                 .ForeColor = RGB(90, 90, 90)
573:                 .Height    = 17
574:                 .Left      = 61
575:                 .Top       = 3
576:                 .Width     = 61
577:             ENDWITH
578:         ENDWITH
579: 
580:         *-- Label5 + opt_4c_Tipo (Optiongroup2: nchktipos; Top=232->261; Left=374/400)
581:         loc_oPagina.AddObject("lbl_4c_Tipo", "Label")
582:         WITH loc_oPagina.lbl_4c_Tipo
583:             .Caption   = "Tipo :"
584:             .Top       = 261
585:             .Left      = 374
586:             .Width     = 29
587:             .Height    = 15
588:             .FontName  = "Tahoma"
589:             .FontSize  = 8
590:             .FontBold  = .F.
591:             .BackStyle = 0
592:             .ForeColor = RGB(90, 90, 90)
593:             .AutoSize  = .F.
594:             .Visible   = .T.
595:         ENDWITH
596: 
597:         loc_oPagina.AddObject("opt_4c_Tipo", "OptionGroup")
598:         WITH loc_oPagina.opt_4c_Tipo
599:             .ButtonCount = 2
600:             .BackStyle   = 0
601:             .BorderStyle = 0
602:             .Value       = 1
603:             .Top         = 257
604:             .Left        = 400
605:             .Width       = 109
606:             .Height      = 24
607:             .Visible     = .T.
608:             WITH .Buttons(1)
609:                 .Caption   = "Sim"
610:                 .BackStyle = 0
611:                 .ForeColor = RGB(90, 90, 90)
612:                 .Height    = 17
613:                 .Left      = 5
614:                 .Top       = 3
615:                 .Width     = 61
616:             ENDWITH
617:             WITH .Buttons(2)
618:                 .Caption   = "N" + CHR(227) + "o"
619:                 .FontName  = "Tahoma"
620:                 .FontSize  = 8
621:                 .BackStyle = 0
622:                 .ForeColor = RGB(90, 90, 90)
623:                 .Height    = 17
624:                 .Left      = 61
625:                 .Top       = 3
626:                 .Width     = 61
627:             ENDWITH
628:         ENDWITH
629: 
630:         *-- Label6 + opt_4c_Autos (optAutos: autos; Top=251->280; Left=343/400)
631:         *-- Convencao invertida: Sim=Option1.Value=0, Nao=Option2.Value=1; default Value=2(Nao)
632:         loc_oPagina.AddObject("lbl_4c_Autos", "Label")
633:         WITH loc_oPagina.lbl_4c_Autos
634:             .Caption   = "Autom" + CHR(225) + "tico:"
635:             .Top       = 280
636:             .Left      = 343
637:             .Width     = 60

*-- Linhas 645 a 740:
645:             .Visible   = .T.
646:         ENDWITH
647: 
648:         loc_oPagina.AddObject("opt_4c_Autos", "OptionGroup")
649:         WITH loc_oPagina.opt_4c_Autos
650:             .ButtonCount = 2
651:             .BackStyle   = 0
652:             .BorderStyle = 0
653:             .Value       = 2
654:             .Top         = 276
655:             .Left        = 400
656:             .Width       = 109
657:             .Height      = 24
658:             .Visible     = .T.
659:             WITH .Buttons(1)
660:                 .Caption   = "Sim"
661:                 .BackStyle = 0
662:                 .ForeColor = RGB(90, 90, 90)
663:                 .Height    = 17
664:                 .Left      = 5
665:                 .Top       = 3
666:                 .Width     = 61
667:             ENDWITH
668:             WITH .Buttons(2)
669:                 .Caption   = "N" + CHR(227) + "o"
670:                 .FontName  = "Tahoma"
671:                 .FontSize  = 8
672:                 .BackStyle = 0
673:                 .ForeColor = RGB(90, 90, 90)
674:                 .Height    = 17
675:                 .Left      = 61
676:                 .Top       = 3
677:                 .Width     = 61
678:             ENDWITH
679:         ENDWITH
680: 
681:         *-- Label7 + opt_4c_UtiLacto (Optiongroup3: UtiLacto; Top=271->300; Left=241/400)
682:         *-- Convencao invertida: Sim=Option1.Value=0, Nao=Option2.Value=1; default Value=2(Nao)
683:         *-- UtiLacto: campo de UI apenas (nao persistido no banco - SigCdDpt nao tem coluna)
684:         loc_oPagina.AddObject("lbl_4c_UtiLacto", "Label")
685:         WITH loc_oPagina.lbl_4c_UtiLacto
686:             .Caption   = "Utiliza nos dados de lan" + CHR(231) + "amento :"
687:             .Top       = 300
688:             .Left      = 241
689:             .Width     = 162
690:             .Height    = 15
691:             .FontName  = "Tahoma"
692:             .FontSize  = 8
693:             .FontBold  = .F.
694:             .BackStyle = 0
695:             .ForeColor = RGB(90, 90, 90)
696:             .AutoSize  = .F.
697:             .Visible   = .T.
698:         ENDWITH
699: 
700:         loc_oPagina.AddObject("opt_4c_UtiLacto", "OptionGroup")
701:         WITH loc_oPagina.opt_4c_UtiLacto
702:             .ButtonCount = 2
703:             .BackStyle   = 0
704:             .BorderStyle = 0
705:             .Value       = 2
706:             .Top         = 296
707:             .Left        = 400
708:             .Width       = 109
709:             .Height      = 24
710:             .Visible     = .T.
711:             WITH .Buttons(1)
712:                 .Caption   = "Sim"
713:                 .BackStyle = 0
714:                 .ForeColor = RGB(90, 90, 90)
715:                 .Height    = 17
716:                 .Left      = 5
717:                 .Top       = 3
718:                 .Width     = 61
719:             ENDWITH
720:             WITH .Buttons(2)
721:                 .Caption   = "N" + CHR(227) + "o"
722:                 .FontName  = "Tahoma"
723:                 .FontSize  = 8
724:                 .BackStyle = 0
725:                 .ForeColor = RGB(90, 90, 90)
726:                 .Height    = 17
727:                 .Left      = 61
728:                 .Top       = 3
729:                 .Width     = 61
730:             ENDWITH
731:         ENDWITH
732: 
733:         *-- Say44 (lbl_4c_GdeGrupo; Top=292->321; Left=339)
734:         loc_oPagina.AddObject("lbl_4c_GdeGrupo", "Label")
735:         WITH loc_oPagina.lbl_4c_GdeGrupo
736:             .Caption   = "Gde. Grupo :"
737:             .Top       = 321
738:             .Left      = 339
739:             .Width     = 64
740:             .Height    = 15

*-- Linhas 781 a 1452:
781:             .Column2.Header1.FontBold = .F.
782:         ENDWITH
783: 
784:         BINDEVENT(loc_oPagina.grd_4c_GruposGG, "AfterRowColChange", THIS, "GruposGGAfterRowColChange")
785: 
786:         *-- Command1 / cmd_4c_AdicionarGrupo (Top=356->385; Left=671; W=45; H=45)
787:         *-- Icone-only: Themes=.T. obrigatorio; nao desabilitar (icone some); guard no click handler
788:         loc_oPagina.AddObject("cmd_4c_AdicionarGrupo", "CommandButton")
789:         WITH loc_oPagina.cmd_4c_AdicionarGrupo
790:             .Caption       = ""
791:             .Picture       = gc_4c_CaminhoIcones + "geral_selecionar_26.jpg"
792:             .ToolTipText   = "Inserir"
793:             .Top           = 385
794:             .Left          = 671
795:             .Width         = 45
796:             .Height        = 45
797:             .BackColor     = RGB(255, 255, 255)
798:             .ForeColor     = RGB(0, 128, 0)
799:             .FontName      = "Arial"
800:             .FontSize      = 9
801:             .FontBold      = .T.
802:             .Themes        = .T.
803:             .SpecialEffect = 0
804:             .MousePointer  = 15
805:             .Visible       = .T.
806:         ENDWITH
807: 
808:         BINDEVENT(loc_oPagina.cmd_4c_AdicionarGrupo, "Click", THIS, "BtnAdicionarGrupoClick")
809: 
810:         *-- Command2 / cmd_4c_RemoverGrupo (Top=400->429; Left=671; W=45; H=45)
811:         *-- Icone-only: Themes=.T. obrigatorio; nao desabilitar; guard no click handler
812:         loc_oPagina.AddObject("cmd_4c_RemoverGrupo", "CommandButton")
813:         WITH loc_oPagina.cmd_4c_RemoverGrupo
814:             .Caption       = ""
815:             .Picture       = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
816:             .ToolTipText   = "Excluir"
817:             .Top           = 429
818:             .Left          = 671
819:             .Width         = 45
820:             .Height        = 45
821:             .BackColor     = RGB(255, 255, 255)
822:             .ForeColor     = RGB(255, 0, 0)
823:             .FontName      = "Arial"
824:             .FontSize      = 9
825:             .FontBold      = .T.
826:             .Themes        = .T.
827:             .SpecialEffect = 0
828:             .MousePointer  = 15
829:             .Visible       = .T.
830:         ENDWITH
831: 
832:         BINDEVENT(loc_oPagina.cmd_4c_RemoverGrupo, "Click", THIS, "BtnRemoverGrupoClick")
833: 
834:         THIS.TornarControlesVisiveis(loc_oPagina)
835:     ENDPROC
836: 
837:     *--------------------------------------------------------------------------
838:     * CarregarLista - Executa Buscar no BO e vincula grid
839:     *--------------------------------------------------------------------------
840:     PROCEDURE CarregarLista()
841:         LOCAL loc_lResultado, loc_oGrid
842:         loc_lResultado = .F.
843: 
844:         TRY
845:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
846:                 loc_lResultado = .T.
847:             ELSE
848:                 IF THIS.this_oBusinessObject.Buscar("")
849:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
850: 
851:                     loc_oGrid.ColumnCount = 2
852:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
853:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
854:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descricaos"
855: 
856:                     *-- Reconfigurar cabecalhos apos RecordSource (VFP reseta)
857:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
858:                     loc_oGrid.Column2.Header1.Caption = "Departamento"
859: 
860:                     THIS.FormatarGridLista(loc_oGrid)
861:                     loc_lResultado = .T.
862:                 ENDIF
863:             ENDIF
864:         CATCH TO loc_oErro
865:             MsgErro("Erro em CarregarLista:" + CHR(13) + loc_oErro.Message, "Erro")
866:         ENDTRY
867: 
868:         RETURN loc_lResultado
869:     ENDPROC
870: 
871:     *--------------------------------------------------------------------------
872:     * AlternarPagina - Alterna entre Page1 (1=Lista) e Page2 (2=Dados)
873:     *--------------------------------------------------------------------------
874:     PROCEDURE AlternarPagina(par_nPagina)
875:         LOCAL loc_lResultado
876:         loc_lResultado = .F.
877: 
878:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
879:             RETURN .F.
880:         ENDIF
881: 
882:         TRY
883:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
884: 
885:             IF par_nPagina = 1
886:                 THIS.CarregarLista()
887:             ENDIF
888: 
889:             loc_lResultado = .T.
890:         CATCH TO loc_oErro
891:             MsgErro("Erro em AlternarPagina:" + CHR(13) + loc_oErro.Message, "Erro")
892:         ENDTRY
893: 
894:         RETURN loc_lResultado
895:     ENDPROC
896: 
897:     *--------------------------------------------------------------------------
898:     * BtnIncluirClick - Novo registro: prepara BO e vai para Page2
899:     *--------------------------------------------------------------------------
900:     PROCEDURE BtnIncluirClick()
901:         THIS.this_oBusinessObject.NovoRegistro()
902:         THIS.this_oBusinessObject.CarregarGrupos("")
903:         THIS.this_cModoAtual = "INCLUIR"
904:         THIS.LimparCampos()
905:         THIS.HabilitarCampos(.T.)
906:         THIS.pgf_4c_Paginas.ActivePage = 2
907:         THIS.pgf_4c_Paginas.Page2.txt_4c_Codigos.SetFocus
908:     ENDPROC
909: 
910:     *--------------------------------------------------------------------------
911:     * BtnVisualizarClick - Visualiza registro selecionado (somente leitura)
912:     *--------------------------------------------------------------------------
913:     PROCEDURE BtnVisualizarClick()
914:         LOCAL loc_cCodigo
915:         loc_cCodigo = ""
916: 
917:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
918:             SELECT cursor_4c_Dados
919:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
920:         ENDIF
921: 
922:         IF EMPTY(loc_cCodigo)
923:             MsgAviso("Selecione um departamento na lista.", "Visualizar")
924:             RETURN
925:         ENDIF
926: 
927:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
928:             THIS.this_oBusinessObject.CarregarGrupos(loc_cCodigo)
929:             THIS.this_cModoAtual = "VISUALIZAR"
930:             THIS.BOParaForm()
931:             THIS.HabilitarCampos(.F.)
932:             THIS.pgf_4c_Paginas.ActivePage = 2
933:         ENDIF
934:     ENDPROC
935: 
936:     *--------------------------------------------------------------------------
937:     * BtnAlterarClick - Carrega registro selecionado para edicao
938:     *--------------------------------------------------------------------------
939:     PROCEDURE BtnAlterarClick()
940:         LOCAL loc_cCodigo
941:         loc_cCodigo = ""
942: 
943:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
944:             SELECT cursor_4c_Dados
945:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
946:         ENDIF
947: 
948:         IF EMPTY(loc_cCodigo)
949:             MsgAviso("Selecione um departamento na lista.", "Alterar")
950:             RETURN
951:         ENDIF
952: 
953:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
954:             THIS.this_oBusinessObject.EditarRegistro()
955:             THIS.this_oBusinessObject.CarregarGrupos(loc_cCodigo)
956:             THIS.this_cModoAtual = "ALTERAR"
957:             THIS.BOParaForm()
958:             THIS.HabilitarCampos(.T.)
959:             THIS.pgf_4c_Paginas.ActivePage = 2
960:         ENDIF
961:     ENDPROC
962: 
963:     *--------------------------------------------------------------------------
964:     * BtnExcluirClick - Exclui registro selecionado com confirmacao
965:     *--------------------------------------------------------------------------
966:     PROCEDURE BtnExcluirClick()
967:         LOCAL loc_cCodigo, loc_lConfirma
968:         loc_cCodigo = ""
969: 
970:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
971:             SELECT cursor_4c_Dados
972:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
973:         ENDIF
974: 
975:         IF EMPTY(loc_cCodigo)
976:             MsgAviso("Selecione um departamento na lista.", "Excluir")
977:             RETURN
978:         ENDIF
979: 
980:         IF THIS.this_oBusinessObject.ValidarDepartamentoEmUso(loc_cCodigo)
981:             MsgAviso("Departamento em uso por usu" + CHR(225) + "rios. N" + ;
982:                 CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + "vel excluir.", "Excluir")
983:             RETURN
984:         ENDIF
985: 
986:         loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do departamento '" + ;
987:             loc_cCodigo + "'?", "Confirmar Exclus" + CHR(227) + "o")
988: 
989:         IF loc_lConfirma
990:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
991:                 IF THIS.this_oBusinessObject.Excluir()
992:                     MsgInfo("Departamento exclu" + CHR(237) + "do com sucesso!", "Sucesso")
993:                     THIS.CarregarLista()
994:                 ENDIF
995:             ENDIF
996:         ENDIF
997:     ENDPROC
998: 
999:     *--------------------------------------------------------------------------
1000:     * BtnBuscarClick - Filtra lista pelo texto digitado
1001:     *--------------------------------------------------------------------------
1002:     PROCEDURE BtnBuscarClick()
1003:         LOCAL loc_cFiltro, loc_oGrid
1004:         loc_cFiltro = InputBox("Informe parte da descri" + CHR(231) + CHR(227) + "o:", ;
1005:             "Buscar Departamento", "")
1006: 
1007:         IF VARTYPE(loc_cFiltro) != "C"
1008:             RETURN
1009:         ENDIF
1010: 
1011:         TRY
1012:             IF THIS.this_oBusinessObject.Buscar(ALLTRIM(loc_cFiltro))
1013:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
1014: 
1015:                 loc_oGrid.ColumnCount = 2
1016:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
1017:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
1018:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descricaos"
1019: 
1020:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1021:                 loc_oGrid.Column2.Header1.Caption = "Departamento"
1022: 
1023:                 THIS.FormatarGridLista(loc_oGrid)
1024: 
1025:                 IF RECCOUNT("cursor_4c_Dados") = 0
1026:                     MsgAviso("Nenhum departamento encontrado.", "Buscar")
1027:                 ENDIF
1028:             ENDIF
1029:         CATCH TO loc_oErro
1030:             MsgErro("Erro na busca:" + CHR(13) + loc_oErro.Message, "Erro")
1031:         ENDTRY
1032:     ENDPROC
1033: 
1034:     *--------------------------------------------------------------------------
1035:     * BtnEncerrarClick - Fecha o formulario
1036:     *--------------------------------------------------------------------------
1037:     PROCEDURE BtnEncerrarClick()
1038:         THIS.Release()
1039:     ENDPROC
1040: 
1041:     *--------------------------------------------------------------------------
1042:     * Destroy - Libera recursos
1043:     *--------------------------------------------------------------------------
1044:     PROCEDURE Destroy()
1045:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1046:             THIS.this_oBusinessObject = .NULL.
1047:         ENDIF
1048:         DODEFAULT()
1049:     ENDPROC
1050: 
1051:     *--------------------------------------------------------------------------
1052:     * FormatarGridLista - Formata visual do grid da lista
1053:     *--------------------------------------------------------------------------
1054:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1055:         WITH par_oGrid
1056:             .FontName = "Tahoma"
1057:             .FontSize = 8
1058:         ENDWITH
1059:     ENDPROC
1060: 
1061:     *--------------------------------------------------------------------------
1062:     * BtnSalvarClick - Valida campos e chama FormParaBO + BO.Salvar()
1063:     *--------------------------------------------------------------------------
1064:     PROCEDURE BtnSalvarClick()
1065:         LOCAL loc_oPagina, loc_cCodigo, loc_cDescricao
1066:         loc_oPagina    = THIS.pgf_4c_Paginas.Page2
1067:         loc_cCodigo    = ALLTRIM(loc_oPagina.txt_4c_Codigos.Value)
1068:         loc_cDescricao = ALLTRIM(loc_oPagina.txt_4c_Descricaos.Value)
1069: 
1070:         IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1071:             IF EMPTY(loc_cCodigo)
1072:                 MsgAviso("C" + CHR(243) + "digo precisa ser informado.", "Validar")
1073:                 loc_oPagina.txt_4c_Codigos.SetFocus
1074:                 RETURN
1075:             ENDIF
1076: 
1077:             IF EMPTY(loc_cDescricao)
1078:                 MsgAviso("Descri" + CHR(231) + CHR(227) + "o precisa ser informada.", "Validar")
1079:                 loc_oPagina.txt_4c_Descricaos.SetFocus
1080:                 RETURN
1081:             ENDIF
1082:         ENDIF
1083: 
1084:         TRY
1085:             THIS.FormParaBO()
1086:             IF THIS.this_oBusinessObject.Salvar()
1087:                 MsgInfo("Departamento salvo com sucesso!", "Sucesso")
1088:                 THIS.AlternarPagina(1)
1089:             ENDIF
1090:         CATCH TO loc_oErro
1091:             MsgErro("Erro ao salvar:" + CHR(13) + loc_oErro.Message, "Erro")
1092:         ENDTRY
1093:     ENDPROC
1094: 
1095:     *--------------------------------------------------------------------------
1096:     * BtnCancelarClick - Cancela e volta para lista
1097:     *--------------------------------------------------------------------------
1098:     PROCEDURE BtnCancelarClick()
1099:         THIS.AlternarPagina(1)
1100:         THIS.this_cModoAtual = "LISTA"
1101:     ENDPROC
1102: 
1103:     *--------------------------------------------------------------------------
1104:     * FormParaBO - Transfere dados da Page2 para as propriedades do BO
1105:     * OptionGroups adicionados na Fase 6 - verificados com PEMSTATUS
1106:     *--------------------------------------------------------------------------
1107:     PROTECTED PROCEDURE FormParaBO()
1108:         LOCAL loc_oBo, loc_oPagina
1109:         loc_oBo     = THIS.this_oBusinessObject
1110:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1111: 
1112:         loc_oBo.this_cCodigo    = ALLTRIM(loc_oPagina.txt_4c_Codigos.Value)
1113:         loc_oBo.this_cDescricao = ALLTRIM(loc_oPagina.txt_4c_Descricaos.Value)
1114:         loc_oBo.this_cDiretor   = ALLTRIM(loc_oPagina.txt_4c_Diretores.Value)
1115: 
1116:         IF PEMSTATUS(loc_oPagina, "opt_4c_SubclaEnc", 5)
1117:             loc_oBo.this_nSubclaEncerr = IIF(loc_oPagina.opt_4c_SubclaEnc.Value = 1, 1, 0)
1118:         ENDIF
1119:         IF PEMSTATUS(loc_oPagina, "opt_4c_Tipo", 5)
1120:             loc_oBo.this_nTipo = IIF(loc_oPagina.opt_4c_Tipo.Value = 1, 1, 0)
1121:         ENDIF
1122:         *-- optAutos: Sim=Value1=autos0, Nao=Value2=autos1 (convencao do legado)
1123:         IF PEMSTATUS(loc_oPagina, "opt_4c_Autos", 5)
1124:             loc_oBo.this_nAutomatico = IIF(loc_oPagina.opt_4c_Autos.Value = 1, 0, 1)
1125:         ENDIF
1126:         IF PEMSTATUS(loc_oPagina, "opt_4c_UtiLacto", 5)
1127:             loc_oBo.this_nUtilizaLanc = IIF(loc_oPagina.opt_4c_UtiLacto.Value = 1, 0, 1)
1128:         ENDIF
1129:     ENDPROC
1130: 
1131:     *--------------------------------------------------------------------------
1132:     * BOParaForm - Carrega propriedades do BO para os campos da Page2
1133:     * OptionGroups/grid adicionados na Fase 6 - verificados com PEMSTATUS
1134:     *--------------------------------------------------------------------------
1135:     PROTECTED PROCEDURE BOParaForm()
1136:         LOCAL loc_oBo, loc_oPagina
1137:         loc_oBo     = THIS.this_oBusinessObject
1138:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1139: 
1140:         loc_oPagina.txt_4c_Codigos.Value    = ALLTRIM(loc_oBo.this_cCodigo)
1141:         loc_oPagina.txt_4c_Descricaos.Value = ALLTRIM(loc_oBo.this_cDescricao)
1142:         loc_oPagina.txt_4c_Diretores.Value  = ALLTRIM(loc_oBo.this_cDiretor)
1143: 
1144:         IF PEMSTATUS(loc_oPagina, "opt_4c_SubclaEnc", 5)
1145:             loc_oPagina.opt_4c_SubclaEnc.Value = IIF(loc_oBo.this_nSubclaEncerr = 1, 1, 2)
1146:         ENDIF
1147:         IF PEMSTATUS(loc_oPagina, "opt_4c_Tipo", 5)
1148:             loc_oPagina.opt_4c_Tipo.Value = IIF(loc_oBo.this_nTipo = 1, 1, 2)
1149:         ENDIF
1150:         *-- optAutos: autos=0?Sim(Value1), autos=1?Nao(Value2)
1151:         IF PEMSTATUS(loc_oPagina, "opt_4c_Autos", 5)
1152:             loc_oPagina.opt_4c_Autos.Value = IIF(loc_oBo.this_nAutomatico = 0, 1, 2)
1153:         ENDIF
1154:         IF PEMSTATUS(loc_oPagina, "opt_4c_UtiLacto", 5)
1155:             loc_oPagina.opt_4c_UtiLacto.Value = IIF(loc_oBo.this_nUtilizaLanc = 0, 1, 2)
1156:         ENDIF
1157: 
1158:         IF PEMSTATUS(loc_oPagina, "grd_4c_GruposGG", 5)
1159:             IF USED("cursor_4c_DptGg")
1160:                 loc_oPagina.grd_4c_GruposGG.ColumnCount = 2
1161:                 loc_oPagina.grd_4c_GruposGG.RecordSource = "cursor_4c_DptGg"
1162:                 loc_oPagina.grd_4c_GruposGG.Column1.ControlSource = "cursor_4c_DptGg.CodGrupo"
1163:                 loc_oPagina.grd_4c_GruposGG.Column2.ControlSource = "cursor_4c_DptGg.descs"
1164:                 loc_oPagina.grd_4c_GruposGG.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1165:                 loc_oPagina.grd_4c_GruposGG.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1166:                 GO TOP IN cursor_4c_DptGg
1167:                 loc_oPagina.grd_4c_GruposGG.Refresh()
1168:             ENDIF
1169:         ENDIF
1170:     ENDPROC
1171: 
1172:     *--------------------------------------------------------------------------
1173:     * HabilitarCampos - Habilita/desabilita campos editaveis da Page2
1174:     *--------------------------------------------------------------------------
1175:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1176:         LOCAL loc_oPagina, loc_lHab
1177:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1178:         loc_lHab    = (par_lHabilitar = .T.)
1179: 
1180:         *-- Codigo: editavel apenas no modo INCLUIR
1181:         loc_oPagina.txt_4c_Codigos.Enabled    = (loc_lHab AND THIS.this_cModoAtual = "INCLUIR")
1182:         loc_oPagina.txt_4c_Descricaos.Enabled = loc_lHab
1183:         loc_oPagina.txt_4c_Diretores.Enabled  = loc_lHab
1184: 
1185:         IF PEMSTATUS(loc_oPagina, "opt_4c_SubclaEnc", 5)
1186:             loc_oPagina.opt_4c_SubclaEnc.Enabled = loc_lHab
1187:         ENDIF
1188:         IF PEMSTATUS(loc_oPagina, "opt_4c_Tipo", 5)
1189:             loc_oPagina.opt_4c_Tipo.Enabled = loc_lHab
1190:         ENDIF
1191:         IF PEMSTATUS(loc_oPagina, "opt_4c_Autos", 5)
1192:             loc_oPagina.opt_4c_Autos.Enabled = loc_lHab
1193:         ENDIF
1194:         IF PEMSTATUS(loc_oPagina, "opt_4c_UtiLacto", 5)
1195:             loc_oPagina.opt_4c_UtiLacto.Enabled = loc_lHab
1196:         ENDIF
1197:         IF PEMSTATUS(loc_oPagina, "grd_4c_GruposGG", 5)
1198:             loc_oPagina.grd_4c_GruposGG.ReadOnly = !loc_lHab
1199:         ENDIF
1200:         *-- Icones-only: Enabled=.F. faz icone sumir (VFP9 bug); guard no click handler
1201: 
1202:         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lHab
1203:         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1204:     ENDPROC
1205: 
1206:     *--------------------------------------------------------------------------
1207:     * LimparCampos - Limpa os valores dos campos da Page2
1208:     * Defaults dos OptionGroups seguem os defaults originais do legado
1209:     *--------------------------------------------------------------------------
1210:     PROTECTED PROCEDURE LimparCampos()
1211:         LOCAL loc_oPagina
1212:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1213: 
1214:         loc_oPagina.txt_4c_Codigos.Value    = ""
1215:         loc_oPagina.txt_4c_Descricaos.Value = ""
1216:         loc_oPagina.txt_4c_Diretores.Value  = ""
1217: 
1218:         *-- Optiongroup1 (nchksubs): default Value=1 (Sim) no legado
1219:         IF PEMSTATUS(loc_oPagina, "opt_4c_SubclaEnc", 5)
1220:             loc_oPagina.opt_4c_SubclaEnc.Value = 1
1221:         ENDIF
1222:         *-- Optiongroup2 (nchktipos): default Value=1 (Sim) no legado
1223:         IF PEMSTATUS(loc_oPagina, "opt_4c_Tipo", 5)
1224:             loc_oPagina.opt_4c_Tipo.Value = 1
1225:         ENDIF
1226:         *-- optAutos (autos): default Value=2 (Nao) no legado -> autos=1
1227:         IF PEMSTATUS(loc_oPagina, "opt_4c_Autos", 5)
1228:             loc_oPagina.opt_4c_Autos.Value = 2
1229:         ENDIF
1230:         *-- Optiongroup3 (UtiLacto): default Value=2 (Nao) no legado
1231:         IF PEMSTATUS(loc_oPagina, "opt_4c_UtiLacto", 5)
1232:             loc_oPagina.opt_4c_UtiLacto.Value = 2
1233:         ENDIF
1234: 
1235:         IF PEMSTATUS(loc_oPagina, "grd_4c_GruposGG", 5)
1236:             IF USED("cursor_4c_DptGg")
1237:                 SELECT cursor_4c_DptGg
1238:                 ZAP
1239:                 APPEND BLANK
1240:                 loc_oPagina.grd_4c_GruposGG.ColumnCount = 2
1241:                 loc_oPagina.grd_4c_GruposGG.RecordSource          = "cursor_4c_DptGg"
1242:                 loc_oPagina.grd_4c_GruposGG.Column1.ControlSource = "cursor_4c_DptGg.CodGrupo"
1243:                 loc_oPagina.grd_4c_GruposGG.Column2.ControlSource = "cursor_4c_DptGg.descs"
1244:                 loc_oPagina.grd_4c_GruposGG.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1245:                 loc_oPagina.grd_4c_GruposGG.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1246:                 loc_oPagina.grd_4c_GruposGG.Refresh()
1247:             ENDIF
1248:         ENDIF
1249:     ENDPROC
1250: 
1251:     *--------------------------------------------------------------------------
1252:     * DiretorKeyPress - F4 abre lookup de usuarios para campo Diretor
1253:     *--------------------------------------------------------------------------
1254:     PROCEDURE DiretorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1255:         IF par_nKeyCode = 115
1256:             THIS.AbrirBuscaDiretor()
1257:         ENDIF
1258:     ENDPROC
1259: 
1260:     *--------------------------------------------------------------------------
1261:     * AbrirBuscaDiretor - FormBuscaAuxiliar em SigCdUsu (Usuarios, NComps)
1262:     *--------------------------------------------------------------------------
1263:     PROTECTED PROCEDURE AbrirBuscaDiretor()
1264:         LOCAL loc_oBusca, loc_oPagina, loc_cValor
1265:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1266:         loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Diretores.Value)
1267: 
1268:         TRY
1269:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1270:                 "SigCdUsu", "cursor_4c_BuscaDiretor", ;
1271:                 "Usuarios", loc_cValor, "Selecionar Diretor")
1272: 
1273:             IF VARTYPE(loc_oBusca) = "O"
1274:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1275:                     IF USED("cursor_4c_BuscaDiretor")
1276:                         SELECT cursor_4c_BuscaDiretor
1277:                         loc_oPagina.txt_4c_Diretores.Value = ALLTRIM(cursor_4c_BuscaDiretor.Usuarios)
1278:                     ENDIF
1279:                 ELSE
1280:                     IF !loc_oBusca.this_lAchouRegistro
1281:                     loc_oBusca.mAddColuna("Usuarios", "", "Diretor")
1282:                     loc_oBusca.mAddColuna("NComps",   "", "Nome")
1283:                     loc_oBusca.Show()
1284:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDiretor")
1285:                         SELECT cursor_4c_BuscaDiretor
1286:                         loc_oPagina.txt_4c_Diretores.Value = ALLTRIM(cursor_4c_BuscaDiretor.Usuarios)
1287:                     ENDIF
1288:                     ENDIF
1289:                 ENDIF
1290:                 loc_oBusca.Release()
1291:             ENDIF
1292:         CATCH TO loc_oErro
1293:             MsgErro("Erro ao abrir busca de diretores:" + CHR(13) + loc_oErro.Message, "Erro")
1294:         ENDTRY
1295: 
1296:         IF USED("cursor_4c_BuscaDiretor")
1297:             USE IN cursor_4c_BuscaDiretor
1298:         ENDIF
1299:     ENDPROC
1300: 
1301:     *--------------------------------------------------------------------------
1302:     * GruposGGAfterRowColChange - Lookup SigCdGpr quando sai da coluna Codigo
1303:     *--------------------------------------------------------------------------
1304:     PROCEDURE GruposGGAfterRowColChange(par_nColIndex)
1305:         IF par_nColIndex = 2
1306:             THIS.ValidarCodigoGrupo()
1307:         ENDIF
1308:     ENDPROC
1309: 
1310:     *--------------------------------------------------------------------------
1311:     * BtnAdicionarGrupoClick - Adiciona linha vazia ao cursor_4c_DptGg
1312:     * Guard de modo: icone-only nao desabilitado (icone some), guard aqui
1313:     *--------------------------------------------------------------------------
1314:     PROCEDURE BtnAdicionarGrupoClick()
1315:         LOCAL loc_oPagina
1316:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1317:             RETURN
1318:         ENDIF
1319:         IF USED("cursor_4c_DptGg")
1320:             SELECT cursor_4c_DptGg
1321:             LOCATE FOR EMPTY(CodGrupo)
1322:             IF !FOUND()
1323:                 APPEND BLANK
1324:             ENDIF
1325:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1326:             IF PEMSTATUS(loc_oPagina, "grd_4c_GruposGG", 5)
1327:                 loc_oPagina.grd_4c_GruposGG.Refresh()
1328:                 loc_oPagina.grd_4c_GruposGG.Column1.SetFocus
1329:             ENDIF
1330:         ENDIF
1331:     ENDPROC
1332: 
1333:     *--------------------------------------------------------------------------
1334:     * BtnRemoverGrupoClick - Exclui linha corrente do cursor_4c_DptGg
1335:     * Guard de modo: icone-only nao desabilitado (icone some), guard aqui
1336:     *--------------------------------------------------------------------------
1337:     PROCEDURE BtnRemoverGrupoClick()
1338:         LOCAL loc_oPagina
1339:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1340:             RETURN
1341:         ENDIF
1342:         IF USED("cursor_4c_DptGg") AND !EOF("cursor_4c_DptGg") AND !BOF("cursor_4c_DptGg")
1343:             SELECT cursor_4c_DptGg
1344:             DELETE
1345:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1346:             IF PEMSTATUS(loc_oPagina, "grd_4c_GruposGG", 5)
1347:                 loc_oPagina.grd_4c_GruposGG.Refresh()
1348:             ENDIF
1349:         ENDIF
1350:     ENDPROC
1351: 
1352:     *--------------------------------------------------------------------------
1353:     * ValidarCodigoGrupo - Lookup SigCdGpr para preencher descricao do grupo
1354:     *--------------------------------------------------------------------------
1355:     PROTECTED PROCEDURE ValidarCodigoGrupo()
1356:         LOCAL loc_oBusca, loc_cCodigo
1357:         loc_cCodigo = ""
1358: 
1359:         IF !USED("cursor_4c_DptGg") OR EOF("cursor_4c_DptGg") OR BOF("cursor_4c_DptGg")
1360:             RETURN
1361:         ENDIF
1362: 
1363:         SELECT cursor_4c_DptGg
1364:         loc_cCodigo = ALLTRIM(cursor_4c_DptGg.CodGrupo)
1365: 
1366:         IF EMPTY(loc_cCodigo)
1367:             REPLACE descs WITH "" IN cursor_4c_DptGg
1368:             RETURN
1369:         ENDIF
1370: 
1371:         TRY
1372:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1373:                 "SigCdGpr", "cursor_4c_BuscaGrupo", ;
1374:                 "Codigos", loc_cCodigo, "Selecionar Grupo")
1375: 
1376:             IF VARTYPE(loc_oBusca) = "O"
1377:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1378:                     IF USED("cursor_4c_BuscaGrupo")
1379:                         SELECT cursor_4c_DptGg
1380:                         REPLACE CodGrupo WITH ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
1381:                         REPLACE descs    WITH ALLTRIM(cursor_4c_BuscaGrupo.Descs)
1382:                     ENDIF
1383:                 ELSE
1384:                     IF !loc_oBusca.this_lAchouRegistro
1385:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1386:                     loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
1387:                     loc_oBusca.Show()
1388:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
1389:                         SELECT cursor_4c_DptGg
1390:                         REPLACE CodGrupo WITH ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
1391:                         REPLACE descs    WITH ALLTRIM(cursor_4c_BuscaGrupo.Descs)
1392:                     ELSE
1393:                         SELECT cursor_4c_DptGg
1394:                         REPLACE CodGrupo WITH ""
1395:                         REPLACE descs    WITH ""
1396:                     ENDIF
1397:                     ENDIF
1398:                 ENDIF
1399:                 loc_oBusca.Release()
1400:             ENDIF
1401:         CATCH TO loc_oErro
1402:             MsgErro("Erro ao buscar grupo:" + CHR(13) + loc_oErro.Message, "Erro")
1403:         ENDTRY
1404: 
1405:         IF USED("cursor_4c_BuscaGrupo")
1406:             USE IN cursor_4c_BuscaGrupo
1407:         ENDIF
1408: 
1409:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_GruposGG", 5)
1410:             THIS.pgf_4c_Paginas.Page2.grd_4c_GruposGG.Refresh()
1411:         ENDIF
1412:     ENDPROC
1413: 
1414:     *--------------------------------------------------------------------------
1415:     * AjustarBotoesPorModo - Habilita/desabilita campos e botoes conforme modo
1416:     * INCLUIR/ALTERAR: Confirmar enabled, campos editaveis
1417:     * VISUALIZAR     : Confirmar disabled, campos readonly
1418:     *--------------------------------------------------------------------------
1419:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1420:         LOCAL loc_lHabilitado
1421:         loc_lHabilitado = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1422:         THIS.HabilitarCampos(loc_lHabilitado)
1423:     ENDPROC
1424: 
1425:     *--------------------------------------------------------------------------
1426:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
1427:     *--------------------------------------------------------------------------
1428:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1429:         LOCAL loc_nI, loc_oObjeto, loc_nP
1430: 
1431:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1432:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1433: 
1434:             IF VARTYPE(loc_oObjeto) = "O"
1435:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1436:                     loc_oObjeto.Visible = .T.
1437:                 ENDIF
1438: 
1439:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1440:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1441:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1442:                     ENDFOR
1443:                 ENDIF
1444: 
1445:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1446:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1447:                 ENDIF
1448:             ENDIF
1449:         ENDFOR
1450:     ENDPROC
1451: 
1452: ENDDEFINE


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

