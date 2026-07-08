# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [CARGA-DADOS] OptionGroup 'opt_4c_Agrupa' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [GRID-WITH] Bloco WITH ENDWITH define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ENDWITH.RecordSource).
- [LAYOUT-POSITION] Controle 'lblemp' (parent: SIGREDOC): Top original=104 vs migrado 'lbl_4c_LblEmpresas' Top=19 (diff=85px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigredoc.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1224 linhas total):

*-- Linhas 10 a 30:
10: *   - Periodo    : txt_4c_DtInicial / txt_4c_DtFinal (mutuamente exclusivos com Numeros)
11: *   - Numero     : txt_4c_NumeroI / txt_4c_NumeroF  (mutuamente exclusivos com Datas)
12: *   - Reimp      : chk_4c_Reimp (habilitado/desabilitado por ValidarOperacao)
13: *   - Imagem     : chk_4c_Imagem
14: *   - FiltroAbto : chk_4c_Itens (itens sem baixa)
15: *   - Agrupar    : opt_4c_Agrupa (2 opcoes, padrao=Nenhum)
16: *
17: * Form: Width=800, Height=500
18: * Cabecalho: Top=0, Height=80
19: * PageFrame: Top=85, Height=415, Width=802
20: * Page1 controles: Top_page1 = Top_original - 85
21: *==============================================================================
22: 
23: DEFINE CLASS Formsigredoc AS FormBase
24: 
25:     Height      = 500
26:     Width       = 800
27:     DataSession = 2
28:     ShowWindow  = 1
29:     WindowType  = 1
30:     AutoCenter  = .T.

*-- Linhas 40 a 142:
40:     this_cMensagemErro = ""
41: 
42:     *--------------------------------------------------------------------------
43:     * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
44:     *--------------------------------------------------------------------------
45:     PROCEDURE Init()
46:         RETURN DODEFAULT()
47:     ENDPROC
48: 
49:     *--------------------------------------------------------------------------
50:     * InicializarForm - Cria estrutura visual e instancia BO
51:     *--------------------------------------------------------------------------
52:     PROTECTED PROCEDURE InicializarForm()
53:         LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
54:         loc_lSucesso   = .F.
55:         loc_lContinuar = .T.
56: 
57:         TRY
58:             THIS.Caption = "Impress" + CHR(227) + "o de Documento"
59: 
60:             IF TYPE("gc_4c_CaminhoIcones") = "U"
61:                 gc_4c_CaminhoIcones = ""
62:             ENDIF
63:             IF TYPE("gc_4c_CaminhoBase") = "U"
64:                 gc_4c_CaminhoBase = ""
65:             ENDIF
66: 
67:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
68: 
69:             THIS.this_oRelatorio = CREATEOBJECT("sigredocBO")
70:             IF VARTYPE(THIS.this_oRelatorio) != "O"
71:                 MsgErro("Erro ao criar sigredocBO" + CHR(13) + ;
72:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
73:                 loc_lContinuar = .F.
74:             ENDIF
75: 
76:             IF loc_lContinuar
77:                 THIS.ConfigurarCabecalho()
78:                 THIS.ConfigurarPageFrame()
79:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
80:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
81:                 THIS.ConfigurarPaginaLista()
82:                 THIS.ConfigurarPaginaDados()
83:                 THIS.CarregarEmpresas()
84:                 THIS.LimparCampos()
85:                 loc_lSucesso = .T.
86:             ENDIF
87: 
88:         CATCH TO loc_oErro
89:             THIS.this_cMensagemErro = loc_oErro.Message
90:             MsgErro(loc_oErro.Message + CHR(13) + ;
91:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
92:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
93:         ENDTRY
94: 
95:         RETURN loc_lSucesso
96:     ENDPROC
97: 
98:     *--------------------------------------------------------------------------
99:     * ConfigurarCabecalho - Container cinza com titulo e botoes de acao
100:     *   cmg_4c_Botoes: Visualizar / Imprimir / Doc.Excel / Sair
101:     *--------------------------------------------------------------------------
102:     PROTECTED PROCEDURE ConfigurarCabecalho()
103:         LOCAL loc_oCab, loc_oCmg
104:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
105:         loc_oCab = THIS.cnt_4c_Cabecalho
106: 
107:         WITH loc_oCab
108:             .Top         = 0
109:             .Left        = 0
110:             .Width       = THIS.Width
111:             .Height      = 80
112:             .BackStyle   = 1
113:             .BackColor   = RGB(100, 100, 100)
114:             .BorderWidth = 0
115:             .Visible     = .T.
116: 
117:             .AddObject("lbl_4c_Sombra", "Label")
118:             WITH .lbl_4c_Sombra
119:                 .Top       = 22
120:                 .Left      = 22
121:                 .Width     = THIS.Width
122:                 .Height    = 30
123:                 .Caption   = "Impress" + CHR(227) + "o de Documento"
124:                 .FontName  = "Tahoma"
125:                 .FontSize  = 14
126:                 .FontBold  = .T.
127:                 .ForeColor = RGB(0, 0, 0)
128:                 .BackStyle = 0
129:                 .Visible   = .T.
130:             ENDWITH
131: 
132:             .AddObject("lbl_4c_Titulo", "Label")
133:             WITH .lbl_4c_Titulo
134:                 .Top       = 20
135:                 .Left      = 20
136:                 .Width     = THIS.Width
137:                 .Height    = 30
138:                 .Caption   = "Impress" + CHR(227) + "o de Documento"
139:                 .FontName  = "Tahoma"
140:                 .FontSize  = 14
141:                 .FontBold  = .T.
142:                 .ForeColor = RGB(255, 255, 255)

*-- Linhas 235 a 320:
235:         ENDWITH
236: 
237:         loc_oCmg = loc_oCab.cmg_4c_Botoes
238:         BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnVisualizarClick")
239:         BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnImprimirClick")
240:         BINDEVENT(loc_oCmg.Buttons(3), "Click", THIS, "BtnGerarExcelClick")
241:         BINDEVENT(loc_oCmg.Buttons(4), "Click", THIS, "BtnCancelarClick")
242:     ENDPROC
243: 
244:     *--------------------------------------------------------------------------
245:     * ConfigurarPageFrame - PageFrame com 1 pagina (Filtros)
246:     *   Form Height=500; Cabecalho Height=80; PageFrame Top=85, Height=415
247:     *--------------------------------------------------------------------------
248:     PROTECTED PROCEDURE ConfigurarPageFrame()
249:         LOCAL loc_oPgf
250: 
251:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
252:         loc_oPgf = THIS.pgf_4c_Paginas
253: 
254:         loc_oPgf.PageCount = 1
255:         loc_oPgf.Top       = 85
256:         loc_oPgf.Left      = -1
257:         loc_oPgf.Width     = THIS.Width + 2
258:         loc_oPgf.Height    = THIS.Height - 85
259:         loc_oPgf.Tabs      = .F.
260: 
261:         loc_oPgf.Page1.Caption   = "Filtros"
262:         loc_oPgf.Page1.FontName  = "Tahoma"
263:         loc_oPgf.Page1.FontSize  = 8
264:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
265:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
266:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)
267: 
268:         loc_oPgf.Visible    = .T.
269:         loc_oPgf.ActivePage = 1
270:     ENDPROC
271: 
272:     *--------------------------------------------------------------------------
273:     * ConfigurarPaginaLista - Todos os controles de filtro na Page1 (REPORT form)
274:     *   Em forms REPORT, a "pagina lista" eh a pagina unica com filtros + grid
275:     *   de empresas; o nome ConfigurarPaginaLista mantem compatibilidade com o
276:     *   pipeline multi-fase (validacao Fase 4) e com forms similares (FormSIGREDIR).
277:     *   Posicoes: Top_page1 = Top_original - 85
278:     *   (Form original Top max ~420; PageFrame.Top=85)
279:     *--------------------------------------------------------------------------
280:     PROTECTED PROCEDURE ConfigurarPaginaLista()
281:         LOCAL loc_oPagina, loc_oGrd
282:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
283: 
284:         *-- Label "Empresas :" (top_orig=104, left=217 -> page1 top=19)
285:         loc_oPagina.AddObject("lbl_4c_LblEmpresas", "Label")
286:         WITH loc_oPagina.lbl_4c_LblEmpresas
287:             .Top       = 19
288:             .Left      = 217
289:             .Width     = 63
290:             .Height    = 15
291:             .Caption   = "Empresas :"
292:             .FontName  = "Tahoma"
293:             .FontSize  = 8
294:             .FontBold  = .T.
295:             .ForeColor = RGB(90, 90, 90)
296:             .BackStyle = 0
297:             .Visible   = .T.
298:         ENDWITH
299: 
300:         *-- Grid de empresas (top_orig=120, left=216 -> page1 top=35)
301:         *   Column1: CheckBox Marca (w=15)
302:         *   Column2: cEmps Cod. (w=33, ReadOnly)
303:         *   Column3: Razas Nome (w=245, ReadOnly)
304:         loc_oPagina.AddObject("grd_4c_Emps", "Grid")
305:         loc_oGrd = loc_oPagina.grd_4c_Emps
306:         WITH loc_oGrd
307:             .Top              = 35
308:             .Left             = 216
309:             .Width            = 327
310:             .Height           = 164
311:             .ColumnCount      = 3
312:             .FontName         = "Tahoma"
313:             .FontSize         = 8
314:             .AllowHeaderSizing = .F.
315:             .AllowRowSizing   = .F.
316:             .DeleteMark       = .F.
317:             .HeaderHeight     = 16
318:             .RowHeight        = 16
319:             .ScrollBars       = 2
320:             .GridLineColor    = RGB(238, 238, 238)

*-- Linhas 408 a 655:
408:             .Themes       = .F.
409:             .Visible      = .T.
410:         ENDWITH
411:         BINDEVENT(loc_oPagina.cmd_4c_SelecionarTodas, "Click", THIS, "CmdSelecionarTodasClick")
412: 
413:         *-- Botao Desmarcar Todas (CmdApgEmp, top_orig=204, left=547 -> top=119)
414:         loc_oPagina.AddObject("cmd_4c_DesmarcarTodas", "CommandButton")
415:         WITH loc_oPagina.cmd_4c_DesmarcarTodas
416:             .Top          = 119
417:             .Left         = 547
418:             .Width        = 40
419:             .Height       = 40
420:             .Caption      = ""
421:             .Picture      = gc_4c_CaminhoBase + "vbmp\cancelab.bmp"
422:             .FontName     = "Verdana"
423:             .FontSize     = 8
424:             .WordWrap     = .T.
425:             .ToolTipText  = "Desmarcar"
426:             .TabStop      = .F.
427:             .ForeColor    = RGB(36, 84, 155)
428:             .BackColor    = RGB(255, 255, 255)
429:             .Themes       = .F.
430:             .Visible      = .T.
431:         ENDWITH
432:         BINDEVENT(loc_oPagina.cmd_4c_DesmarcarTodas, "Click", THIS, "CmdDesmarcarTodasClick")
433: 
434:         *-- Label "Opera" + CHR(231) + CHR(227) + "o :" (top_orig=293, left=225 -> top=208)
435:         loc_oPagina.AddObject("lbl_4c_Operacao", "Label")
436:         WITH loc_oPagina.lbl_4c_Operacao
437:             .Top       = 208
438:             .Left      = 225
439:             .Width     = 59
440:             .Height    = 18
441:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o : "
442:             .FontName  = "Tahoma"
443:             .FontSize  = 8
444:             .ForeColor = RGB(90, 90, 90)
445:             .BackStyle = 0
446:             .AutoSize  = .T.
447:             .Visible   = .T.
448:         ENDWITH
449: 
450:         *-- Campo Operacao get_dopes (top_orig=289, left=288 -> top=204)
451:         loc_oPagina.AddObject("txt_4c_Dopes", "TextBox")
452:         WITH loc_oPagina.txt_4c_Dopes
453:             .Top           = 204
454:             .Left          = 288
455:             .Width         = 150
456:             .Height        = 23
457:             .Value         = ""
458:             .FontName      = "Tahoma"
459:             .FontSize      = 9
460:             .ForeColor     = RGB(0, 0, 0)
461:             .BackColor     = RGB(255, 255, 255)
462:             .Format        = "K!"
463:             .MaxLength     = 20
464:             .SpecialEffect = 0
465:             .BorderStyle   = 1
466:             .Alignment     = 0
467:             .Visible       = .T.
468:         ENDWITH
469:         BINDEVENT(loc_oPagina.txt_4c_Dopes, "KeyPress", THIS, "TeclaDopes")
470: 
471:         *-- Label "Periodo :" (top_orig=318, left=236 -> top=233)
472:         loc_oPagina.AddObject("lbl_4c_Periodo", "Label")
473:         WITH loc_oPagina.lbl_4c_Periodo
474:             .Top       = 233
475:             .Left      = 236
476:             .Width     = 48
477:             .Height    = 18
478:             .Caption   = "Periodo : "
479:             .FontName  = "Tahoma"
480:             .FontSize  = 8
481:             .ForeColor = RGB(90, 90, 90)
482:             .BackStyle = 0
483:             .AutoSize  = .T.
484:             .Visible   = .T.
485:         ENDWITH
486: 
487:         *-- Data Inicial (top_orig=314, left=288 -> top=229)
488:         loc_oPagina.AddObject("txt_4c_DtInicial", "TextBox")
489:         WITH loc_oPagina.txt_4c_DtInicial
490:             .Top           = 229
491:             .Left          = 288
492:             .Width         = 80
493:             .Height        = 23
494:             .Value         = {}
495:             .FontName      = "Tahoma"
496:             .FontSize      = 8
497:             .ForeColor     = RGB(0, 0, 0)
498:             .Format        = "K"
499:             .MaxLength     = 10
500:             .SpecialEffect = 1
501:             .BorderStyle   = 1
502:             .Visible       = .T.
503:         ENDWITH
504:         BINDEVENT(loc_oPagina.txt_4c_DtInicial, "KeyPress", THIS, "TeclaDtInicial")
505:         BINDEVENT(loc_oPagina.txt_4c_DtInicial, "LostFocus", THIS, "AtualizarEstadoFiltros")
506: 
507:         *-- Separador "a" entre datas (top_orig=319, left=371 -> top=234)
508:         loc_oPagina.AddObject("lbl_4c_SepData", "Label")
509:         WITH loc_oPagina.lbl_4c_SepData
510:             .Top       = 234
511:             .Left      = 371
512:             .Width     = 8
513:             .Height    = 18
514:             .Caption   = CHR(224)
515:             .FontName  = "Tahoma"
516:             .FontSize  = 8
517:             .ForeColor = RGB(90, 90, 90)
518:             .BackStyle = 0
519:             .Visible   = .T.
520:         ENDWITH
521: 
522:         *-- Data Final (top_orig=314, left=382 -> top=229)
523:         loc_oPagina.AddObject("txt_4c_DtFinal", "TextBox")
524:         WITH loc_oPagina.txt_4c_DtFinal
525:             .Top           = 229
526:             .Left          = 382
527:             .Width         = 80
528:             .Height        = 23
529:             .Value         = {}
530:             .FontName      = "Tahoma"
531:             .FontSize      = 8
532:             .ForeColor     = RGB(0, 0, 0)
533:             .Format        = "K"
534:             .MaxLength     = 10
535:             .SpecialEffect = 1
536:             .BorderStyle   = 1
537:             .Visible       = .T.
538:         ENDWITH
539:         BINDEVENT(loc_oPagina.txt_4c_DtFinal, "KeyPress", THIS, "TeclaDtFinal")
540:         BINDEVENT(loc_oPagina.txt_4c_DtFinal, "LostFocus", THIS, "AtualizarEstadoFiltros")
541: 
542:         *-- Label "N" + CHR(250) + "mero :" (top_orig=341, left=235 -> top=256)
543:         loc_oPagina.AddObject("lbl_4c_Numero", "Label")
544:         WITH loc_oPagina.lbl_4c_Numero
545:             .Top       = 256
546:             .Left      = 235
547:             .Width     = 49
548:             .Height    = 18
549:             .Caption   = "N" + CHR(250) + "mero : "
550:             .FontName  = "Tahoma"
551:             .FontSize  = 8
552:             .ForeColor = RGB(90, 90, 90)
553:             .BackStyle = 0
554:             .AutoSize  = .T.
555:             .Visible   = .T.
556:         ENDWITH
557: 
558:         *-- Numero Inicial Get_Opera??oi (top_orig=339, left=288 -> top=254)
559:         loc_oPagina.AddObject("txt_4c_NumeroI", "TextBox")
560:         WITH loc_oPagina.txt_4c_NumeroI
561:             .Top           = 254
562:             .Left          = 288
563:             .Width         = 55
564:             .Height        = 23
565:             .Value         = 0
566:             .FontName      = "Tahoma"
567:             .FontSize      = 8
568:             .ForeColor     = RGB(0, 0, 0)
569:             .Format        = "K"
570:             .InputMask     = "999999"
571:             .MaxLength     = 6
572:             .Alignment     = 3
573:             .SpecialEffect = 1
574:             .BorderStyle   = 1
575:             .Visible       = .T.
576:         ENDWITH
577:         BINDEVENT(loc_oPagina.txt_4c_NumeroI, "KeyPress", THIS, "TeclaNumeroI")
578:         BINDEVENT(loc_oPagina.txt_4c_NumeroI, "LostFocus", THIS, "AtualizarEstadoFiltros")
579: 
580:         *-- Separador "a" entre numeros (top_orig=344, left=349 -> top=259)
581:         loc_oPagina.AddObject("lbl_4c_SepNumero", "Label")
582:         WITH loc_oPagina.lbl_4c_SepNumero
583:             .Top       = 259
584:             .Left      = 349
585:             .Width     = 8
586:             .Height    = 15
587:             .Caption   = CHR(224)
588:             .FontName  = "Tahoma"
589:             .FontSize  = 8
590:             .ForeColor = RGB(90, 90, 90)
591:             .BackStyle = 0
592:             .Visible   = .T.
593:         ENDWITH
594: 
595:         *-- Numero Final Get_Opera??of (top_orig=339, left=363 -> top=254)
596:         loc_oPagina.AddObject("txt_4c_NumeroF", "TextBox")
597:         WITH loc_oPagina.txt_4c_NumeroF
598:             .Top           = 254
599:             .Left          = 363
600:             .Width         = 55
601:             .Height        = 23
602:             .Value         = 0
603:             .FontName      = "Tahoma"
604:             .FontSize      = 8
605:             .ForeColor     = RGB(0, 0, 0)
606:             .Format        = "K"
607:             .InputMask     = "999999"
608:             .MaxLength     = 6
609:             .Alignment     = 3
610:             .SpecialEffect = 1
611:             .BorderStyle   = 1
612:             .Visible       = .T.
613:         ENDWITH
614:         BINDEVENT(loc_oPagina.txt_4c_NumeroF, "KeyPress", THIS, "TeclaNumeroF")
615:         BINDEVENT(loc_oPagina.txt_4c_NumeroF, "LostFocus", THIS, "AtualizarEstadoFiltros")
616: 
617:         *-- Checkbox Imprimir Imagem (top_orig=368, left=288 -> top=283)
618:         loc_oPagina.AddObject("chk_4c_Imagem", "CheckBox")
619:         WITH loc_oPagina.chk_4c_Imagem
620:             .Top       = 283
621:             .Left      = 288
622:             .Width     = 100
623:             .Height    = 15
624:             .Caption   = "Imprimir Imagem"
625:             .Value     = 0
626:             .FontName  = "Tahoma"
627:             .FontSize  = 8
628:             .FontBold  = .F.
629:             .AutoSize  = .T.
630:             .Alignment = 0
631:             .BackStyle = 0
632:             .ForeColor = RGB(90, 90, 90)
633:             .Visible   = .T.
634:         ENDWITH
635: 
636:         *-- Checkbox Imprimir Apenas Itens em Aberto (top_orig=384, left=288 -> top=299)
637:         loc_oPagina.AddObject("chk_4c_ItensPendentes", "CheckBox")
638:         WITH loc_oPagina.chk_4c_ItensPendentes
639:             .Top       = 299
640:             .Left      = 288
641:             .Width     = 170
642:             .Height    = 15
643:             .Caption   = "Imprimir Apenas Itens Pendentes"
644:             .Value     = 0
645:             .FontName  = "Tahoma"
646:             .FontSize  = 8
647:             .FontBold  = .F.
648:             .AutoSize  = .T.
649:             .Alignment = 0
650:             .BackStyle = 0
651:             .ForeColor = RGB(90, 90, 90)
652:             .Visible   = .T.
653:         ENDWITH
654: 
655:         *-- Checkbox Reimpressao (top_orig=400, left=288 -> top=315)

*-- Linhas 691 a 1224:
691: 
692:         *-- OptAgrupa (top_orig=416, left=283 -> top=331)
693:         *   Value=2 = Nenhum (padrao)
694:         *   Button1: "Produto, Cor, Valor Unit" + CHR(225) + "rio" (Value=1)
695:         *   Button2: "Nenhum" (Value=1 dentro do botao, mas grupo Value=2)
696:         loc_oPagina.AddObject("opt_4c_Agrupa", "OptionGroup")
697:         WITH loc_oPagina.opt_4c_Agrupa
698:             .Top         = 331
699:             .Left        = 283
700:             .Width       = 267
701:             .Height      = 27
702:             .ButtonCount = 2
703:             .AutoSize    = .T.
704:             .BackStyle   = 0
705:             .BorderStyle = 0
706:             .Value       = 2
707:             .Visible     = .T.
708: 
709:             WITH .Buttons(1)
710:                 .Caption   = "Produto, Cor, Valor Unit" + CHR(225) + "rio"
711:                 .Top       = 5
712:                 .Left      = 5
713:                 .Width     = 151
714:                 .Height    = 15
715:                 .AutoSize  = .T.
716:                 .BackStyle = 0
717:                 .ForeColor = RGB(90, 90, 90)
718:             ENDWITH
719: 
720:             WITH .Buttons(2)
721:                 .Caption   = "Nenhum"
722:                 .Top       = 5
723:                 .Left      = 193
724:                 .Width     = 69
725:                 .Height    = 17
726:                 .AutoSize  = .T.
727:                 .BackStyle = 0
728:                 .FontName  = "Tahoma"
729:                 .FontSize  = 8
730:                 .ForeColor = RGB(90, 90, 90)
731:             ENDWITH
732:         ENDWITH
733:     ENDPROC
734: 
735:     *--------------------------------------------------------------------------
736:     * ConfigurarPaginaDados - Form REPORT: todos os controles estao em
737:     *   ConfigurarPaginaLista() (Page1 = Filtros). Nao ha Page2 de edicao.
738:     *   O original SIGREDOC.SCX (frmrelatorio) tem layout plano sem PageFrame
739:     *   de edicao; todos os 20 controles migrados estao na Page1/Filtros:
740:     *     grd_4c_Emps (3 colunas), txt_4c_Dopes, txt_4c_DtInicial,
741:     *     txt_4c_DtFinal, txt_4c_NumeroI, txt_4c_NumeroF, chk_4c_Imagem,
742:     *     chk_4c_Reimp, opt_4c_Agrupa (2 botoes), checkboxes de filtro,
743:     *     cmd_4c_SelecionarTodas, cmd_4c_DesmarcarTodas + 6 labels.
744:     *--------------------------------------------------------------------------
745:     PROTECTED PROCEDURE ConfigurarPaginaDados()
746:         LOCAL loc_oPagina, loc_oErro, loc_lOk
747:         loc_lOk = .F.
748:         TRY
749:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
750:             *-- Verificar que os controles essenciais existem
751:             loc_lOk = PEMSTATUS(loc_oPagina, "txt_4c_Dopes",    5) AND ;
752:                       PEMSTATUS(loc_oPagina, "grd_4c_Emps",     5) AND ;
753:                       PEMSTATUS(loc_oPagina, "chk_4c_Reimp",    5) AND ;
754:                       PEMSTATUS(loc_oPagina, "opt_4c_Agrupa",   5)
755:             IF !loc_lOk
756:                 THIS.this_cMensagemErro = "Controles de filtro n" + CHR(227) + "o encontrados na Page1"
757:                 MsgErro(THIS.this_cMensagemErro, "ConfigurarPaginaDados")
758:             ENDIF
759:         CATCH TO loc_oErro
760:             MsgErro(loc_oErro.Message, "ConfigurarPaginaDados")
761:             loc_lOk = .F.
762:         ENDTRY
763:         RETURN loc_lOk
764:     ENDPROC
765: 
766:     *--------------------------------------------------------------------------
767:     * CarregarEmpresas - Carrega cursor de empresas e vincula ao grid
768:     *--------------------------------------------------------------------------
769:     PROCEDURE CarregarEmpresas()
770:         LOCAL loc_oCursor, loc_oGrd, loc_oErro
771:         TRY
772:             IF VARTYPE(THIS.this_oRelatorio) = "O"
773:                 IF THIS.this_oRelatorio.CarregarEmpresas()
774:                     loc_oCursor = THIS.this_oRelatorio.this_cCursorEmpresas
775:                     loc_oGrd    = THIS.pgf_4c_Paginas.Page1.grd_4c_Emps
776: 
777:                     WITH loc_oGrd
778:                         .RecordSource             = loc_oCursor
779:                         .Column1.ControlSource    = loc_oCursor + ".Marca"
780:                         .Column2.ControlSource    = loc_oCursor + ".cEmps"
781:                         .Column3.ControlSource    = loc_oCursor + ".Razas"
782:                         .Refresh()
783:                     ENDWITH
784:                 ELSE
785:                     MsgErro("Falha ao carregar lista de empresas.", "CarregarEmpresas")
786:                 ENDIF
787:             ENDIF
788:         CATCH TO loc_oErro
789:             MsgErro(loc_oErro.Message, "CarregarEmpresas")
790:         ENDTRY
791:     ENDPROC
792: 
793:     *--------------------------------------------------------------------------
794:     * LimparCampos - Inicializa filtros com valores padrao
795:     *--------------------------------------------------------------------------
796:     PROCEDURE LimparCampos()
797:         LOCAL loc_oPagina, loc_oErro
798: 
799:         TRY
800:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
801: 
802:             WITH loc_oPagina
803:                 .txt_4c_Dopes.Value          = ""
804:                 .txt_4c_DtInicial.Value      = {}
805:                 .txt_4c_DtFinal.Value        = {}
806:                 .txt_4c_NumeroI.Value        = 0
807:                 .txt_4c_NumeroF.Value        = 0
808:                 .chk_4c_Imagem.Value         = 0
809:                 .chk_4c_ItensPendentes.Value = 0
810:                 .chk_4c_Reimp.Value          = 0
811:                 .chk_4c_Reimp.Enabled        = .T.
812:                 .opt_4c_Agrupa.Value         = 2
813:             ENDWITH
814: 
815:             THIS.AtualizarEstadoFiltros()
816: 
817:         CATCH TO loc_oErro
818:             MsgErro(loc_oErro.Message, "LimparCampos")
819:         ENDTRY
820:     ENDPROC
821: 
822:     *--------------------------------------------------------------------------
823:     * AlternarPagina - Ativa pagina (forms REPORT tem so Page1)
824:     *--------------------------------------------------------------------------
825:     PROCEDURE AlternarPagina(par_nPagina)
826:         LOCAL loc_nPagina, loc_oErro, loc_oPagina
827:         TRY
828:             loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
829:             IF loc_nPagina < 1 OR loc_nPagina > THIS.pgf_4c_Paginas.PageCount
830:                 loc_nPagina = 1
831:             ENDIF
832:             THIS.pgf_4c_Paginas.ActivePage = loc_nPagina
833:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
834:             IF PEMSTATUS(loc_oPagina, "txt_4c_Dopes", 5)
835:                 loc_oPagina.txt_4c_Dopes.SetFocus()
836:             ENDIF
837:         CATCH TO loc_oErro
838:             MsgErro(loc_oErro.Message, "Erro ao Alternar P" + CHR(225) + "gina")
839:         ENDTRY
840:     ENDPROC
841: 
842:     *--------------------------------------------------------------------------
843:     * FormParaRelatorio - Copia valores do form para o BO antes de processar
844:     *--------------------------------------------------------------------------
845:     PROTECTED PROCEDURE FormParaRelatorio()
846:         LOCAL loc_oPagina
847:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
848:         WITH THIS.this_oRelatorio
849:             .this_cDopes          = ALLTRIM(loc_oPagina.txt_4c_Dopes.Value)
850:             .this_dDtInicial      = loc_oPagina.txt_4c_DtInicial.Value
851:             .this_dDtFinal        = loc_oPagina.txt_4c_DtFinal.Value
852:             .this_nOperacaoI      = loc_oPagina.txt_4c_NumeroI.Value
853:             .this_nOperacaoF      = loc_oPagina.txt_4c_NumeroF.Value
854:             .this_nReimp          = loc_oPagina.chk_4c_Reimp.Value
855:             .this_nAgrupa         = loc_oPagina.opt_4c_Agrupa.Value
856:             .this_lImagem         = (loc_oPagina.chk_4c_Imagem.Value = 1)
857:             .this_lItensPendentes = (loc_oPagina.chk_4c_ItensPendentes.Value = 1)
858:         ENDWITH
859:     ENDPROC
860: 
861:     *--------------------------------------------------------------------------
862:     * ValidarOperacao - Valida codigo de operacao e atualiza estado chk_4c_Reimp
863:     *   Equivalente ao get_dopes.Valid do legado
864:     *--------------------------------------------------------------------------
865:     PROCEDURE ValidarOperacao()
866:         LOCAL loc_cDopes, loc_oPagina, loc_oErro, loc_lEnabled, loc_nNdopes
867:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
868:         loc_cDopes  = ALLTRIM(loc_oPagina.txt_4c_Dopes.Value)
869: 
870:         TRY
871:             IF !EMPTY(loc_cDopes)
872:                 fAcessoMovmto(gc_4c_UsuarioLogado, loc_cDopes, loc_oPagina.txt_4c_Dopes)
873:             ENDIF
874: 
875:             IF !EMPTY(loc_cDopes)
876:                 IF VARTYPE(THIS.this_oRelatorio) = "O"
877:                     THIS.this_oRelatorio.ValidarOperacao(loc_cDopes)
878:                     IF THIS.this_oRelatorio.this_nChkImpDoc = 1
879:                         loc_nNdopes  = THIS.this_oRelatorio.this_nNdopes
880:                         loc_lEnabled = fChecaAcesso( ;
881:                             PADL(ALLTRIM(STR(loc_nNdopes)), 8, "0"), "REIMPDOC")
882:                         loc_oPagina.chk_4c_Reimp.Enabled = loc_lEnabled
883:                         IF !loc_lEnabled
884:                             loc_oPagina.chk_4c_Reimp.Value = 0
885:                         ENDIF
886:                     ELSE
887:                         loc_oPagina.chk_4c_Reimp.Enabled = .T.
888:                     ENDIF
889:                 ENDIF
890:             ELSE
891:                 loc_oPagina.chk_4c_Reimp.Enabled = .T.
892:             ENDIF
893: 
894:         CATCH TO loc_oErro
895:             MsgErro(loc_oErro.Message, "ValidarOpera" + CHR(231) + CHR(227) + "o")
896:         ENDTRY
897:     ENDPROC
898: 
899:     *--------------------------------------------------------------------------
900:     * AtualizarEstadoFiltros - Controla exclusao mutua entre datas e numeros
901:     *   Datas preenchidas -> numeros desabilitados (e vice-versa)
902:     *   Replicando comportamento dos When events do legado
903:     *--------------------------------------------------------------------------
904:     PROCEDURE AtualizarEstadoFiltros()
905:         LOCAL loc_oPagina, loc_lDatasVazias, loc_lNumerosZero, loc_nIni, loc_nFim, loc_oErro
906:         TRY
907:             loc_oPagina      = THIS.pgf_4c_Paginas.Page1
908:             loc_lDatasVazias = EMPTY(loc_oPagina.txt_4c_DtInicial.Value) AND ;
909:                                EMPTY(loc_oPagina.txt_4c_DtFinal.Value)
910:             loc_nIni         = loc_oPagina.txt_4c_NumeroI.Value
911:             loc_nFim         = loc_oPagina.txt_4c_NumeroF.Value
912:             loc_lNumerosZero = (loc_nIni = 0) AND (loc_nFim = 0)
913: 
914:             *-- Sync: se NumeroI preenchido e NumeroF=0, copiar valor
915:             IF loc_nIni > 0 AND loc_nFim = 0 AND loc_lDatasVazias
916:                 loc_oPagina.txt_4c_NumeroF.Value = loc_nIni
917:                 loc_oPagina.txt_4c_NumeroF.Refresh()
918:                 loc_lNumerosZero = .F.
919:             ENDIF
920: 
921:             *-- Numeros habilitados somente quando datas vazias
922:             loc_oPagina.txt_4c_NumeroI.Enabled = loc_lDatasVazias
923:             loc_oPagina.txt_4c_NumeroF.Enabled = loc_lDatasVazias
924: 
925:             *-- Datas habilitadas somente quando numeros zero
926:             loc_oPagina.txt_4c_DtInicial.Enabled = loc_lNumerosZero
927:             loc_oPagina.txt_4c_DtFinal.Enabled   = loc_lNumerosZero
928: 
929:         CATCH TO loc_oErro
930:             MsgErro(loc_oErro.Message, "AtualizarEstadoFiltros")
931:         ENDTRY
932:     ENDPROC
933: 
934:     *--------------------------------------------------------------------------
935:     * TeclaDopes - KeyPress em txt_4c_Dopes; dispara ValidarOperacao ao ENTER/TAB
936:     *--------------------------------------------------------------------------
937:     PROCEDURE TeclaDopes(par_nKeyCode, par_nShiftAltCtrl)
938:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
939:             THIS.ValidarOperacao()
940:         ENDIF
941:     ENDPROC
942: 
943:     *--------------------------------------------------------------------------
944:     * TeclaDtInicial / TeclaDtFinal - KeyPress em campos de data (sem acao especial)
945:     *--------------------------------------------------------------------------
946:     PROCEDURE TeclaDtInicial(par_nKeyCode, par_nShiftAltCtrl)
947:     ENDPROC
948: 
949:     PROCEDURE TeclaDtFinal(par_nKeyCode, par_nShiftAltCtrl)
950:     ENDPROC
951: 
952:     *--------------------------------------------------------------------------
953:     * TeclaNumeroI / TeclaNumeroF - KeyPress em campos de numero (sem acao especial)
954:     *--------------------------------------------------------------------------
955:     PROCEDURE TeclaNumeroI(par_nKeyCode, par_nShiftAltCtrl)
956:     ENDPROC
957: 
958:     PROCEDURE TeclaNumeroF(par_nKeyCode, par_nShiftAltCtrl)
959:     ENDPROC
960: 
961:     *--------------------------------------------------------------------------
962:     * CmdSelecionarTodasClick - Marca todas as empresas (Marca=1)
963:     *--------------------------------------------------------------------------
964:     PROCEDURE CmdSelecionarTodasClick()
965:         LOCAL loc_oCursor, loc_oErro
966:         TRY
967:             IF VARTYPE(THIS.this_oRelatorio) = "O"
968:                 loc_oCursor = THIS.this_oRelatorio.this_cCursorEmpresas
969:                 IF USED(loc_oCursor)
970:                     SELECT (loc_oCursor)
971:                     REPLACE ALL Marca WITH 1
972:                     GO TOP
973:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Emps.Refresh()
974:                 ENDIF
975:             ENDIF
976:         CATCH TO loc_oErro
977:             MsgErro(loc_oErro.Message, "CmdSelecionarTodas")
978:         ENDTRY
979:     ENDPROC
980: 
981:     *--------------------------------------------------------------------------
982:     * CmdDesmarcarTodasClick - Desmarca todas as empresas (Marca=0)
983:     *--------------------------------------------------------------------------
984:     PROCEDURE CmdDesmarcarTodasClick()
985:         LOCAL loc_oCursor, loc_oErro
986:         TRY
987:             IF VARTYPE(THIS.this_oRelatorio) = "O"
988:                 loc_oCursor = THIS.this_oRelatorio.this_cCursorEmpresas
989:                 IF USED(loc_oCursor)
990:                     SELECT (loc_oCursor)
991:                     REPLACE ALL Marca WITH 0
992:                     GO TOP
993:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Emps.Refresh()
994:                 ENDIF
995:             ENDIF
996:         CATCH TO loc_oErro
997:             MsgErro(loc_oErro.Message, "CmdDesmarcarTodas")
998:         ENDTRY
999:     ENDPROC
1000: 
1001:     *--------------------------------------------------------------------------
1002:     * BtnVisualizarClick - Preview do relatorio na tela
1003:     *--------------------------------------------------------------------------
1004:     PROCEDURE BtnVisualizarClick()
1005:         LOCAL loc_oErro, loc_lContinuar, loc_cDopes
1006:         loc_lContinuar = .T.
1007:         TRY
1008:             loc_cDopes = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Dopes.Value)
1009:             IF EMPTY(loc_cDopes)
1010:                 MsgAviso("Informe o c" + CHR(243) + "digo da opera" + CHR(231) + CHR(227) + "o.", ;
1011:                          "Valida" + CHR(231) + CHR(227) + "o")
1012:                 loc_lContinuar = .F.
1013:             ENDIF
1014: 
1015:             IF loc_lContinuar
1016:                 THIS.FormParaRelatorio()
1017:                 IF !THIS.this_oRelatorio.Visualizar()
1018:                     MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
1019:                             "Erro ao Visualizar")
1020:                 ENDIF
1021:             ENDIF
1022:         CATCH TO loc_oErro
1023:             MsgErro(loc_oErro.Message + CHR(13) + ;
1024:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro Detalhado")
1025:         ENDTRY
1026:     ENDPROC
1027: 
1028:     *--------------------------------------------------------------------------
1029:     * BtnImprimirClick - Imprime relatorio com dialogo de impressora
1030:     *--------------------------------------------------------------------------
1031:     PROCEDURE BtnImprimirClick()
1032:         LOCAL loc_oErro, loc_lContinuar, loc_cDopes
1033:         loc_lContinuar = .T.
1034:         TRY
1035:             loc_cDopes = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Dopes.Value)
1036:             IF EMPTY(loc_cDopes)
1037:                 MsgAviso("Informe o c" + CHR(243) + "digo da opera" + CHR(231) + CHR(227) + "o.", ;
1038:                          "Valida" + CHR(231) + CHR(227) + "o")
1039:                 loc_lContinuar = .F.
1040:             ENDIF
1041: 
1042:             IF loc_lContinuar
1043:                 THIS.FormParaRelatorio()
1044:                 IF !THIS.this_oRelatorio.ImprimirComDialog()
1045:                     MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
1046:                             "Erro ao Imprimir")
1047:                 ENDIF
1048:             ENDIF
1049:         CATCH TO loc_oErro
1050:             MsgErro(loc_oErro.Message + CHR(13) + ;
1051:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro Detalhado")
1052:         ENDTRY
1053:     ENDPROC
1054: 
1055:     *--------------------------------------------------------------------------
1056:     * BtnGerarExcelClick - Doc. Excel (impressao direta sem dialogo)
1057:     *--------------------------------------------------------------------------
1058:     PROCEDURE BtnGerarExcelClick()
1059:         LOCAL loc_oErro, loc_lContinuar, loc_cDopes
1060:         loc_lContinuar = .T.
1061:         TRY
1062:             loc_cDopes = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Dopes.Value)
1063:             IF EMPTY(loc_cDopes)
1064:                 MsgAviso("Informe o c" + CHR(243) + "digo da opera" + CHR(231) + CHR(227) + "o.", ;
1065:                          "Valida" + CHR(231) + CHR(227) + "o")
1066:                 loc_lContinuar = .F.
1067:             ENDIF
1068: 
1069:             IF loc_lContinuar
1070:                 THIS.FormParaRelatorio()
1071:                 IF !THIS.this_oRelatorio.Imprimir()
1072:                     MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
1073:                             "Erro ao Imprimir")
1074:                 ENDIF
1075:             ENDIF
1076:         CATCH TO loc_oErro
1077:             MsgErro(loc_oErro.Message + CHR(13) + ;
1078:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro Detalhado")
1079:         ENDTRY
1080:     ENDPROC
1081: 
1082:     *--------------------------------------------------------------------------
1083:     * BtnCancelarClick - Fecha o formulario
1084:     *--------------------------------------------------------------------------
1085:     PROCEDURE BtnCancelarClick()
1086:         THIS.Release()
1087:     ENDPROC
1088: 
1089:     *--------------------------------------------------------------------------
1090:     * Destroy - Libera referencia ao BO e cursor de empresas
1091:     *--------------------------------------------------------------------------
1092:     PROCEDURE Destroy()
1093:         IF VARTYPE(THIS.this_oRelatorio) = "O"
1094:             LOCAL loc_oCursor
1095:             loc_oCursor = THIS.this_oRelatorio.this_cCursorEmpresas
1096:             IF USED(loc_oCursor)
1097:                 USE IN (loc_oCursor)
1098:             ENDIF
1099:             THIS.this_oRelatorio = .NULL.
1100:         ENDIF
1101:         DODEFAULT()
1102:     ENDPROC
1103: 
1104:     *--------------------------------------------------------------------------
1105:     * CarregarLista - Forms REPORT nao tem grid CRUD
1106:     *--------------------------------------------------------------------------
1107:     PROCEDURE CarregarLista()
1108:         RETURN .T.
1109:     ENDPROC
1110: 
1111:     *--------------------------------------------------------------------------
1112:     * AjustarBotoesPorModo - Em forms REPORT todos os botoes ficam habilitados
1113:     *--------------------------------------------------------------------------
1114:     PROCEDURE AjustarBotoesPorModo()
1115:         LOCAL loc_oCmg, loc_oErro, loc_nI
1116:         TRY
1117:             IF VARTYPE(THIS.cnt_4c_Cabecalho) = "O" AND ;
1118:                PEMSTATUS(THIS.cnt_4c_Cabecalho, "cmg_4c_Botoes", 5)
1119:                 loc_oCmg = THIS.cnt_4c_Cabecalho.cmg_4c_Botoes
1120:                 FOR loc_nI = 1 TO loc_oCmg.ButtonCount
1121:                     loc_oCmg.Buttons(loc_nI).Enabled = .T.
1122:                 ENDFOR
1123:             ENDIF
1124:         CATCH TO loc_oErro
1125:             MsgErro(loc_oErro.Message, "AjustarBotoesPorModo")
1126:         ENDTRY
1127:     ENDPROC
1128: 
1129:     *--------------------------------------------------------------------------
1130:     * Aliases de interface CRUD exigidos pelo pipeline multi-fase
1131:     *--------------------------------------------------------------------------
1132:     PROCEDURE BtnBuscarClick()
1133:         THIS.BtnVisualizarClick()
1134:     ENDPROC
1135: 
1136:     PROCEDURE BtnEncerrarClick()
1137:         THIS.Release()
1138:     ENDPROC
1139: 
1140:     PROCEDURE BtnSalvarClick()
1141:         THIS.BtnImprimirClick()
1142:     ENDPROC
1143: 
1144:     PROCEDURE BtnConsultarClick()
1145:         THIS.BtnVisualizarClick()
1146:     ENDPROC
1147: 
1148:     PROCEDURE BtnIncluirClick()
1149:         THIS.BtnVisualizarClick()
1150:     ENDPROC
1151: 
1152:     PROCEDURE BtnAlterarClick()
1153:         THIS.BtnVisualizarClick()
1154:     ENDPROC
1155: 
1156:     PROCEDURE BtnExcluirClick()
1157:         THIS.BtnVisualizarClick()
1158:     ENDPROC
1159: 
1160:     *--------------------------------------------------------------------------
1161:     * FormParaBO / BOParaForm - Aliases para a interface generica FormBase
1162:     *--------------------------------------------------------------------------
1163:     PROTECTED PROCEDURE FormParaBO()
1164:         THIS.FormParaRelatorio()
1165:     ENDPROC
1166: 
1167:     PROTECTED PROCEDURE BOParaForm()
1168:         LOCAL loc_oPg, loc_oErro
1169:         TRY
1170:             IF VARTYPE(THIS.this_oRelatorio) = "O"
1171:                 loc_oPg = THIS.pgf_4c_Paginas.Page1
1172:                 WITH THIS.this_oRelatorio
1173:                     loc_oPg.txt_4c_Dopes.Value          = .this_cDopes
1174:                     IF !EMPTY(.this_dDtInicial)
1175:                         loc_oPg.txt_4c_DtInicial.Value  = .this_dDtInicial
1176:                     ENDIF
1177:                     IF !EMPTY(.this_dDtFinal)
1178:                         loc_oPg.txt_4c_DtFinal.Value    = .this_dDtFinal
1179:                     ENDIF
1180:                     loc_oPg.txt_4c_NumeroI.Value        = .this_nOperacaoI
1181:                     loc_oPg.txt_4c_NumeroF.Value        = .this_nOperacaoF
1182:                     loc_oPg.chk_4c_Reimp.Value          = .this_nReimp
1183:                     loc_oPg.opt_4c_Agrupa.Value         = .this_nAgrupa
1184:                     loc_oPg.chk_4c_Imagem.Value         = IIF(.this_lImagem, 1, 0)
1185:                     loc_oPg.chk_4c_ItensPendentes.Value = IIF(.this_lItensPendentes, 1, 0)
1186:                 ENDWITH
1187:                 THIS.AtualizarEstadoFiltros()
1188:             ENDIF
1189:         CATCH TO loc_oErro
1190:             MsgErro(loc_oErro.Message, "BOParaForm")
1191:         ENDTRY
1192:     ENDPROC
1193: 
1194:     *--------------------------------------------------------------------------
1195:     * HabilitarCampos - Habilita ou desabilita os campos de filtro
1196:     *--------------------------------------------------------------------------
1197:     PROCEDURE HabilitarCampos(par_lHabilitar)
1198:         LOCAL loc_oPg, loc_lHab, loc_oErro
1199:         TRY
1200:             loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
1201:             loc_oPg  = THIS.pgf_4c_Paginas.Page1
1202:             IF VARTYPE(loc_oPg) = "O"
1203:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dopes", 5)
1204:                     loc_oPg.txt_4c_Dopes.ReadOnly = !loc_lHab
1205:                 ENDIF
1206:                 IF PEMSTATUS(loc_oPg, "txt_4c_DtInicial", 5)
1207:                     loc_oPg.txt_4c_DtInicial.ReadOnly = !loc_lHab
1208:                 ENDIF
1209:                 IF PEMSTATUS(loc_oPg, "txt_4c_DtFinal", 5)
1210:                     loc_oPg.txt_4c_DtFinal.ReadOnly = !loc_lHab
1211:                 ENDIF
1212:                 IF PEMSTATUS(loc_oPg, "txt_4c_NumeroI", 5)
1213:                     loc_oPg.txt_4c_NumeroI.ReadOnly = !loc_lHab
1214:                 ENDIF
1215:                 IF PEMSTATUS(loc_oPg, "txt_4c_NumeroF", 5)
1216:                     loc_oPg.txt_4c_NumeroF.ReadOnly = !loc_lHab
1217:                 ENDIF
1218:             ENDIF
1219:         CATCH TO loc_oErro
1220:             MsgErro(loc_oErro.Message, "HabilitarCampos")
1221:         ENDTRY
1222:     ENDPROC
1223: 
1224: ENDDEFINE

