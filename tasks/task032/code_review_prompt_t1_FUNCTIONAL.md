# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (19)
- [METODO-INEXISTENTE] Metodo 'THIS.CarregarCursores()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'lbl_fator' (parent: SIGREAPP): Top original=183 vs migrado 'lbl_4c_Lbl_fator' Top=98 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'LblPeriodo' (parent: SIGREAPP): Top original=129 vs migrado 'lbl_4c_LblPeriodo' Top=44 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optSaldos' (parent: SIGREAPP): Top original=125 vs migrado 'obj_4c_OptSaldos' Top=6 (diff=119px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optSaldos' (parent: SIGREAPP): Left original=798 vs migrado 'obj_4c_OptSaldos' Left=5 (diff=793px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_AnaSi' (parent: SIGREAPP): Top original=98 vs migrado 'obj_4c_Opt_AnaSi' Top=6 (diff=92px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_AnaSi' (parent: SIGREAPP): Left original=92 vs migrado 'obj_4c_Opt_AnaSi' Left=5 (diff=87px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ck_MarcaEmp' (parent: SIGREAPP): Top original=283 vs migrado 'chk_4c_Ck_MarcaEmp' Top=198 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_estoque' (parent: SIGREAPP): Top original=184 vs migrado 'lbl_4c_Lbl_estoque' Top=99 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_Juros' (parent: SIGREAPP): Top original=153 vs migrado 'obj_4c_Opt_Juros' Top=5 (diff=148px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_Juros' (parent: SIGREAPP): Left original=646 vs migrado 'obj_4c_Opt_Juros' Left=5 (diff=641px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ck_MarcaOpe' (parent: SIGREAPP): Top original=283 vs migrado 'chk_4c_Ck_MarcaOpe' Top=198 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ck_Pagamentos' (parent: SIGREAPP): Top original=159 vs migrado 'chk_4c_Ck_Pagamentos' Top=74 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ck_Recebimentos' (parent: SIGREAPP): Top original=182 vs migrado 'chk_4c_Ck_Recebimentos' Top=97 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ck_MarcaCla' (parent: SIGREAPP): Top original=283 vs migrado 'chk_4c_Ck_MarcaCla' Top=198 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optAutorizados' (parent: SIGREAPP): Top original=230 vs migrado 'obj_4c_OptAutorizados' Top=5 (diff=225px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optAutorizados' (parent: SIGREAPP): Left original=92 vs migrado 'obj_4c_OptAutorizados' Left=5 (diff=87px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optDatas' (parent: SIGREAPP): Top original=124 vs migrado 'obj_4c_OptDatas' Top=6 (diff=118px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optDatas' (parent: SIGREAPP): Left original=287 vs migrado 'obj_4c_OptDatas' Left=5 (diff=282px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreapp.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2220 linhas total):

*-- Linhas 34 a 139:
34:     this_cMensagemErro = ""
35: 
36:     *--------------------------------------------------------------------------
37:     * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
38:     *--------------------------------------------------------------------------
39:     PROCEDURE Init()
40:         RETURN DODEFAULT()
41:     ENDPROC
42: 
43:     *--------------------------------------------------------------------------
44:     * InicializarForm - Cria estrutura visual do formulario de relatorio
45:     *--------------------------------------------------------------------------
46:     PROTECTED PROCEDURE InicializarForm()
47:         LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
48:         loc_lSucesso   = .F.
49:         loc_lContinuar = .T.
50: 
51:         TRY
52:             THIS.Caption = "Relat" + CHR(243) + "rio de An" + CHR(225) + "lise a Pagar / Receber"
53: 
54:             IF TYPE("gc_4c_CaminhoIcones") = "U"
55:                 gc_4c_CaminhoIcones = ""
56:             ENDIF
57:             IF TYPE("gc_4c_CaminhoReports") = "U"
58:                 gc_4c_CaminhoReports = ""
59:             ENDIF
60:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
61: 
62:             THIS.this_oRelatorio = CREATEOBJECT("sigreappBO")
63:             IF VARTYPE(THIS.this_oRelatorio) != "O"
64:                 MsgErro("Erro ao criar sigreappBO" + CHR(13) + ;
65:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
66:                 loc_lContinuar = .F.
67:             ENDIF
68: 
69:             IF loc_lContinuar
70:                 THIS.ConfigurarCabecalho()
71:                 THIS.ConfigurarPageFrame()
72:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
73:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
74:                 THIS.ConfigurarFiltros()
75:                 IF !THIS.CarregarCursores()
76:                     loc_lContinuar = .F.
77:                 ENDIF
78:             ENDIF
79: 
80:             IF loc_lContinuar
81:                 THIS.ConfigurarGrids()
82:                 THIS.LimparCampos()
83:                 loc_lSucesso = .T.
84:             ENDIF
85: 
86:         CATCH TO loc_oErro
87:             THIS.this_cMensagemErro = loc_oErro.Message
88:             MsgErro(loc_oErro.Message + CHR(13) + ;
89:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
90:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
91:         ENDTRY
92: 
93:         RETURN loc_lSucesso
94:     ENDPROC
95: 
96:     *--------------------------------------------------------------------------
97:     * ConfigurarCabecalho - Container cinza superior com titulo e 4 botoes
98:     *--------------------------------------------------------------------------
99:     PROTECTED PROCEDURE ConfigurarCabecalho()
100:         LOCAL loc_oCab, loc_oCmg
101:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
102:         loc_oCab = THIS.cnt_4c_Cabecalho
103: 
104:         WITH loc_oCab
105:             .Top         = 0
106:             .Left        = 0
107:             .Width       = THIS.Width
108:             .Height      = 80
109:             .BackStyle   = 1
110:             .BackColor   = RGB(100, 100, 100)
111:             .BorderWidth = 0
112:             .Visible     = .T.
113: 
114:             .AddObject("lbl_4c_Sombra", "Label")
115:             WITH .lbl_4c_Sombra
116:                 .Top       = 22
117:                 .Left      = 22
118:                 .Width     = THIS.Width
119:                 .Height    = 30
120:                 .Caption   = ""
121:                 .FontName  = "Tahoma"
122:                 .FontSize  = 14
123:                 .FontBold  = .T.
124:                 .ForeColor = RGB(0, 0, 0)
125:                 .BackStyle = 0
126:                 .Visible   = .T.
127:             ENDWITH
128: 
129:             .AddObject("lbl_4c_Titulo", "Label")
130:             WITH .lbl_4c_Titulo
131:                 .Top       = 20
132:                 .Left      = 20
133:                 .Width     = THIS.Width
134:                 .Height    = 30
135:                 .Caption   = ""
136:                 .FontName  = "Tahoma"
137:                 .FontSize  = 14
138:                 .FontBold  = .T.
139:                 .ForeColor = RGB(255, 255, 255)

*-- Linhas 232 a 333:
232:         ENDWITH
233: 
234:         loc_oCmg = loc_oCab.cmg_4c_Botoes
235:         BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnVisualizarClick")
236:         BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnImprimirClick")
237:         BINDEVENT(loc_oCmg.Buttons(3), "Click", THIS, "BtnGerarExcelClick")
238:         BINDEVENT(loc_oCmg.Buttons(4), "Click", THIS, "BtnCancelarClick")
239:     ENDPROC
240: 
241:     *--------------------------------------------------------------------------
242:     * ConfigurarPageFrame - PageFrame plano (sem abas) com 1 pagina de filtros
243:     * Top=85, Height=615 (700-85), Width=1302
244:     *--------------------------------------------------------------------------
245:     PROTECTED PROCEDURE ConfigurarPageFrame()
246:         LOCAL loc_oPgf
247: 
248:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
249:         loc_oPgf = THIS.pgf_4c_Paginas
250: 
251:         loc_oPgf.PageCount   = 1
252:         loc_oPgf.Top         = 85
253:         loc_oPgf.Left        = -1
254:         loc_oPgf.Width       = THIS.Width + 2
255:         loc_oPgf.Height      = THIS.Height - 85
256:         loc_oPgf.Tabs        = .F.
257: 
258:         loc_oPgf.Page1.Caption   = "Filtros"
259:         loc_oPgf.Page1.FontName  = "Tahoma"
260:         loc_oPgf.Page1.FontSize  = 8
261:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
262:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
263:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)
264: 
265:         loc_oPgf.Visible    = .T.
266:         loc_oPgf.ActivePage = 1
267:     ENDPROC
268: 
269:     *--------------------------------------------------------------------------
270:     * ConfigurarFiltros - Adiciona todos os controles de filtro em Page1
271:     * Coordenadas: Top_page1 = Top_original - 85
272:     *--------------------------------------------------------------------------
273:     PROTECTED PROCEDURE ConfigurarFiltros()
274:         LOCAL loc_oPg1
275:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
276: 
277:         *-- Tipo de relatorio (Analitico/Sintetico/Fluxo de Caixa)
278:         loc_oPg1.AddObject("lbl_4c_Label2", "Label")
279:         WITH loc_oPg1.lbl_4c_Label2
280:             .Top       = 20
281:             .Left      = 64
282:             .Width     = 35
283:             .Height    = 15
284:             .Caption   = "Tipo :"
285:             .FontName  = "Tahoma"
286:             .FontSize  = 8
287:             .ForeColor = RGB(90, 90, 90)
288:             .BackStyle = 0
289:             .AutoSize  = .T.
290:             .Visible   = .T.
291:         ENDWITH
292: 
293:         loc_oPg1.AddObject("obj_4c_Opt_AnaSi", "OptionGroup")
294:         WITH loc_oPg1.obj_4c_Opt_AnaSi
295:             .Top         = 13
296:             .Left        = 92
297:             .Width       = 265
298:             .Height      = 29
299:             .ButtonCount = 3
300:             .BackStyle   = 0
301:             .BorderStyle = 0
302:             .Value       = 1
303:             .Visible     = .T.
304:             WITH .Buttons(1)
305:                 .Caption   = "Anal" + CHR(237) + "tico"
306:                 .Value     = 1
307:                 .Top       = 6
308:                 .Left      = 5
309:                 .Width     = 58
310:                 .Height    = 15
311:                 .AutoSize  = .T.
312:                 .BackStyle = 0
313:                 .ForeColor = RGB(90, 90, 90)
314:             ENDWITH
315:             WITH .Buttons(2)
316:                 .Caption   = "Sint" + CHR(233) + "tico"
317:                 .Value     = 0
318:                 .Top       = 6
319:                 .Left      = 76
320:                 .Width     = 59
321:                 .Height    = 15
322:                 .AutoSize  = .T.
323:                 .BackStyle = 0
324:                 .FontName  = "Tahoma"
325:                 .FontSize  = 8
326:                 .ForeColor = RGB(90, 90, 90)
327:             ENDWITH
328:             WITH .Buttons(3)
329:                 .Caption   = "Fluxo de Caixa"
330:                 .Top       = 6
331:                 .Left      = 151
332:                 .Width     = 89
333:                 .Height    = 15

*-- Linhas 402 a 445:
402:         ENDWITH
403: 
404:         *-- Tipo de data (Vencimento/Emissao/Lancamento)
405:         loc_oPg1.AddObject("obj_4c_OptDatas", "OptionGroup")
406:         WITH loc_oPg1.obj_4c_OptDatas
407:             .Top         = 39
408:             .Left        = 287
409:             .Width       = 265
410:             .Height      = 29
411:             .ButtonCount = 3
412:             .BackStyle   = 0
413:             .BorderStyle = 0
414:             .Value       = 1
415:             .Visible     = .T.
416:             WITH .Buttons(1)
417:                 .Caption   = "Vencimento"
418:                 .Value     = 1
419:                 .Top       = 6
420:                 .Left      = 5
421:                 .Width     = 73
422:                 .Height    = 15
423:                 .AutoSize  = .T.
424:                 .BackStyle = 0
425:                 .ForeColor = RGB(90, 90, 90)
426:             ENDWITH
427:             WITH .Buttons(2)
428:                 .Caption   = "Emiss" + CHR(227) + "o"
429:                 .Value     = 0
430:                 .Top       = 6
431:                 .Left      = 91
432:                 .Width     = 56
433:                 .Height    = 15
434:                 .AutoSize  = .T.
435:                 .BackStyle = 0
436:                 .FontName  = "Tahoma"
437:                 .FontSize  = 8
438:                 .ForeColor = RGB(90, 90, 90)
439:             ENDWITH
440:             WITH .Buttons(3)
441:                 .Caption   = "Lan" + CHR(231) + "amento"
442:                 .Top       = 6
443:                 .Left      = 159
444:                 .Width     = 76
445:                 .Height    = 15

*-- Linhas 485 a 528:
485:         ENDWITH
486: 
487:         *-- Saldos (Informado/Data Inicial/Data Atual)
488:         loc_oPg1.AddObject("obj_4c_OptSaldos", "OptionGroup")
489:         WITH loc_oPg1.obj_4c_OptSaldos
490:             .Top         = 40
491:             .Left        = 798
492:             .Width       = 265
493:             .Height      = 29
494:             .ButtonCount = 3
495:             .BackStyle   = 0
496:             .BorderStyle = 0
497:             .Value       = 1
498:             .Visible     = .T.
499:             WITH .Buttons(1)
500:                 .Caption   = "Informado"
501:                 .Value     = 1
502:                 .Top       = 6
503:                 .Left      = 5
504:                 .Width     = 68
505:                 .Height    = 15
506:                 .AutoSize  = .T.
507:                 .BackStyle = 0
508:                 .ForeColor = RGB(90, 90, 90)
509:             ENDWITH
510:             WITH .Buttons(2)
511:                 .Caption   = "Data Inicial"
512:                 .Value     = 0
513:                 .Top       = 6
514:                 .Left      = 87
515:                 .Width     = 71
516:                 .Height    = 15
517:                 .AutoSize  = .T.
518:                 .BackStyle = 0
519:                 .FontName  = "Tahoma"
520:                 .FontSize  = 8
521:                 .ForeColor = RGB(90, 90, 90)
522:             ENDWITH
523:             WITH .Buttons(3)
524:                 .Caption   = "Data Atual"
525:                 .Top       = 6
526:                 .Left      = 176
527:                 .Width     = 69
528:                 .Height    = 15

*-- Linhas 566 a 911:
566:             .SpecialEffect = 1
567:             .Visible       = .T.
568:         ENDWITH
569:         BINDEVENT(loc_oPg1.txt_4c_Grupo, "KeyPress", THIS, "TxtGrupoKeyPress")
570: 
571:         loc_oPg1.AddObject("txt_4c_DGrupo", "TextBox")
572:         WITH loc_oPg1.txt_4c_DGrupo
573:             .Top           = 67
574:             .Left          = 181
575:             .Width         = 301
576:             .Height        = 24
577:             .Value         = ""
578:             .Format        = "K"
579:             .MaxLength     = 20
580:             .FontName      = "Tahoma"
581:             .FontSize      = 8
582:             .ForeColor     = RGB(0, 0, 0)
583:             .BorderStyle   = 1
584:             .SpecialEffect = 1
585:             .Visible       = .T.
586:         ENDWITH
587:         BINDEVENT(loc_oPg1.txt_4c_DGrupo, "When",  THIS, "DGrupoWhen")
588:         BINDEVENT(loc_oPg1.txt_4c_DGrupo, "KeyPress", THIS, "TxtDGrupoKeyPress")
589: 
590:         *-- Juros
591:         loc_oPg1.AddObject("lbl_4c_Label6", "Label")
592:         WITH loc_oPg1.lbl_4c_Label6
593:             .Top       = 71
594:             .Left      = 614
595:             .Width     = 40
596:             .Height    = 15
597:             .Caption   = "Juros :"
598:             .FontName  = "Tahoma"
599:             .FontSize  = 8
600:             .ForeColor = RGB(90, 90, 90)
601:             .BackStyle = 0
602:             .AutoSize  = .T.
603:             .Visible   = .T.
604:         ENDWITH
605: 
606:         loc_oPg1.AddObject("obj_4c_Opt_Juros", "OptionGroup")
607:         WITH loc_oPg1.obj_4c_Opt_Juros
608:             .Top         = 68
609:             .Left        = 646
610:             .Width       = 91
611:             .Height      = 23
612:             .ButtonCount = 2
613:             .BackStyle   = 0
614:             .BorderStyle = 0
615:             .Value       = 2
616:             .Visible     = .T.
617:             WITH .Buttons(1)
618:                 .Caption   = "Sim"
619:                 .Value     = 0
620:                 .Top       = 5
621:                 .Left      = 5
622:                 .Width     = 38
623:                 .Height    = 17
624:                 .AutoSize  = .F.
625:                 .BackStyle = 0
626:                 .ForeColor = RGB(90, 90, 90)
627:             ENDWITH
628:             WITH .Buttons(2)
629:                 .Caption   = "N" + CHR(227) + "o"
630:                 .Value     = 1
631:                 .Top       = 5
632:                 .Left      = 48
633:                 .Width     = 38
634:                 .Height    = 17
635:                 .AutoSize  = .F.
636:                 .BackStyle = 0
637:                 .FontName  = "Tahoma"
638:                 .FontSize  = 8
639:                 .ForeColor = RGB(90, 90, 90)
640:             ENDWITH
641:         ENDWITH
642:         BINDEVENT(loc_oPg1.obj_4c_Opt_Juros, "Click", THIS, "JurosOptClick")
643: 
644:         loc_oPg1.AddObject("txt_4c__Juros", "TextBox")
645:         WITH loc_oPg1.txt_4c__Juros
646:             .Top           = 67
647:             .Left          = 749
648:             .Width         = 51
649:             .Height        = 24
650:             .Value         = 0
651:             .Alignment     = 1
652:             .Format        = "K"
653:             .InputMask     = "99.99"
654:             .FontName      = "Tahoma"
655:             .FontSize      = 8
656:             .BorderStyle   = 1
657:             .SpecialEffect = 1
658:             .Visible       = .T.
659:         ENDWITH
660:         BINDEVENT(loc_oPg1.txt_4c__Juros, "When", THIS, "JurosWhen")
661: 
662:         loc_oPg1.AddObject("lbl_4c_Label7", "Label")
663:         WITH loc_oPg1.lbl_4c_Label7
664:             .Top       = 72
665:             .Left      = 802
666:             .Width     = 40
667:             .Height    = 15
668:             .Caption   = "% m" + CHR(234) + "s"
669:             .FontName  = "Tahoma"
670:             .FontSize  = 8
671:             .ForeColor = RGB(90, 90, 90)
672:             .BackStyle = 0
673:             .AutoSize  = .T.
674:             .Visible   = .T.
675:         ENDWITH
676: 
677:         *-- Pagamentos / Recebimentos
678:         loc_oPg1.AddObject("chk_4c_Ck_Pagamentos", "CheckBox")
679:         WITH loc_oPg1.chk_4c_Ck_Pagamentos
680:             .Top       = 74
681:             .Left      = 889
682:             .Width     = 90
683:             .Height    = 15
684:             .Caption   = "Pagamentos"
685:             .Value     = 0
686:             .BackStyle = 0
687:             .Alignment = 0
688:             .AutoSize  = .T.
689:             .FontName  = "Tahoma"
690:             .FontSize  = 8
691:             .ForeColor = RGB(90, 90, 90)
692:             .Visible   = .T.
693:         ENDWITH
694:         BINDEVENT(loc_oPg1.chk_4c_Ck_Pagamentos, "InteractiveChange", THIS, "PagamentosChange")
695: 
696:         loc_oPg1.AddObject("chk_4c_Ck_Recebimentos", "CheckBox")
697:         WITH loc_oPg1.chk_4c_Ck_Recebimentos
698:             .Top       = 97
699:             .Left      = 889
700:             .Width     = 100
701:             .Height    = 15
702:             .Caption   = "Recebimentos"
703:             .Value     = 0
704:             .BackStyle = 0
705:             .Alignment = 0
706:             .AutoSize  = .T.
707:             .FontName  = "Tahoma"
708:             .FontSize  = 8
709:             .ForeColor = RGB(90, 90, 90)
710:             .Visible   = .T.
711:         ENDWITH
712:         BINDEVENT(loc_oPg1.chk_4c_Ck_Recebimentos, "InteractiveChange", THIS, "RecebimentosChange")
713: 
714:         *-- Conta contabil
715:         loc_oPg1.AddObject("lbl_4c_Lbl_estoque", "Label")
716:         WITH loc_oPg1.lbl_4c_Lbl_estoque
717:             .Top       = 99
718:             .Left      = 55
719:             .Width     = 40
720:             .Height    = 15
721:             .Caption   = "Conta :"
722:             .FontName  = "Tahoma"
723:             .FontSize  = 8
724:             .ForeColor = RGB(90, 90, 90)
725:             .BackStyle = 0
726:             .AutoSize  = .T.
727:             .Visible   = .T.
728:         ENDWITH
729: 
730:         loc_oPg1.AddObject("txt_4c_Conta", "TextBox")
731:         WITH loc_oPg1.txt_4c_Conta
732:             .Top           = 94
733:             .Left          = 98
734:             .Width         = 80
735:             .Height        = 24
736:             .Value         = ""
737:             .Format        = "K"
738:             .MaxLength     = 10
739:             .FontName      = "Tahoma"
740:             .FontSize      = 9
741:             .ForeColor     = RGB(0, 0, 0)
742:             .BorderStyle   = 1
743:             .SpecialEffect = 1
744:             .Visible       = .T.
745:         ENDWITH
746:         BINDEVENT(loc_oPg1.txt_4c_Conta, "KeyPress", THIS, "TxtContaKeyPress")
747: 
748:         loc_oPg1.AddObject("txt_4c_DConta", "TextBox")
749:         WITH loc_oPg1.txt_4c_DConta
750:             .Top           = 94
751:             .Left          = 181
752:             .Width         = 301
753:             .Height        = 24
754:             .Value         = ""
755:             .Format        = "K"
756:             .MaxLength     = 40
757:             .FontName      = "Tahoma"
758:             .FontSize      = 8
759:             .ForeColor     = RGB(0, 0, 0)
760:             .BorderStyle   = 1
761:             .SpecialEffect = 1
762:             .Visible       = .T.
763:         ENDWITH
764:         BINDEVENT(loc_oPg1.txt_4c_DConta, "When",  THIS, "DContaWhen")
765:         BINDEVENT(loc_oPg1.txt_4c_DConta, "KeyPress", THIS, "TxtDContaKeyPress")
766: 
767:         *-- Moeda
768:         loc_oPg1.AddObject("lbl_4c_Lbl_fator", "Label")
769:         WITH loc_oPg1.lbl_4c_Lbl_fator
770:             .Top       = 98
771:             .Left      = 608
772:             .Width     = 50
773:             .Height    = 15
774:             .Caption   = "Moeda :"
775:             .FontName  = "Tahoma"
776:             .FontSize  = 8
777:             .ForeColor = RGB(90, 90, 90)
778:             .BackStyle = 0
779:             .AutoSize  = .T.
780:             .Visible   = .T.
781:         ENDWITH
782: 
783:         loc_oPg1.AddObject("txt_4c__cd_moeda", "TextBox")
784:         WITH loc_oPg1.txt_4c__cd_moeda
785:             .Top           = 94
786:             .Left          = 652
787:             .Width         = 31
788:             .Height        = 24
789:             .Value         = ""
790:             .Format        = "K"
791:             .MaxLength     = 3
792:             .FontName      = "Tahoma"
793:             .FontSize      = 9
794:             .ForeColor     = RGB(0, 0, 0)
795:             .BackStyle     = 1
796:             .BorderStyle   = 1
797:             .SpecialEffect = 1
798:             .Alignment     = 0
799:             .Visible       = .T.
800:         ENDWITH
801:         BINDEVENT(loc_oPg1.txt_4c__cd_moeda, "KeyPress",   THIS, "TxtMoedaCdKeyPress")
802: 
803:         loc_oPg1.AddObject("txt_4c__ds_moeda", "TextBox")
804:         WITH loc_oPg1.txt_4c__ds_moeda
805:             .Top           = 94
806:             .Left          = 685
807:             .Width         = 115
808:             .Height        = 24
809:             .Value         = ""
810:             .Format        = "K"
811:             .MaxLength     = 15
812:             .FontName      = "Tahoma"
813:             .FontSize      = 8
814:             .BorderStyle   = 1
815:             .SpecialEffect = 1
816:             .Visible       = .T.
817:         ENDWITH
818:         BINDEVENT(loc_oPg1.txt_4c__ds_moeda, "When",      THIS, "MoedaDsWhen")
819:         BINDEVENT(loc_oPg1.txt_4c__ds_moeda, "KeyPress",   THIS, "TxtMoedaDsKeyPress")
820: 
821:         *-- Job (centro de custo)
822:         loc_oPg1.AddObject("lbl_4c_Label11", "Label")
823:         WITH loc_oPg1.lbl_4c_Label11
824:             .Top       = 125
825:             .Left      = 67
826:             .Width     = 30
827:             .Height    = 15
828:             .Caption   = "Job :"
829:             .FontName  = "Tahoma"
830:             .FontSize  = 8
831:             .ForeColor = RGB(90, 90, 90)
832:             .BackStyle = 0
833:             .AutoSize  = .T.
834:             .Visible   = .T.
835:         ENDWITH
836: 
837:         loc_oPg1.AddObject("txt_4c__Jobs", "TextBox")
838:         WITH loc_oPg1.txt_4c__Jobs
839:             .Top           = 120
840:             .Left          = 98
841:             .Width         = 80
842:             .Height        = 24
843:             .Value         = ""
844:             .FontName      = "Tahoma"
845:             .FontSize      = 8
846:             .ForeColor     = RGB(0, 0, 0)
847:             .BorderStyle   = 1
848:             .SpecialEffect = 1
849:             .Margin        = 0
850:             .Visible       = .T.
851:         ENDWITH
852:         BINDEVENT(loc_oPg1.txt_4c__Jobs, "KeyPress", THIS, "TxtJobsKeyPress")
853: 
854:         loc_oPg1.AddObject("txt_4c_DJobs", "TextBox")
855:         WITH loc_oPg1.txt_4c_DJobs
856:             .Top           = 120
857:             .Left          = 181
858:             .Width         = 301
859:             .Height        = 24
860:             .Value         = ""
861:             .MaxLength     = 40
862:             .FontName      = "Tahoma"
863:             .FontSize      = 8
864:             .ForeColor     = RGB(0, 0, 0)
865:             .BorderStyle   = 1
866:             .SpecialEffect = 1
867:             .Margin        = 0
868:             .Visible       = .T.
869:         ENDWITH
870:         BINDEVENT(loc_oPg1.txt_4c_DJobs, "When",  THIS, "DJobsWhen")
871:         BINDEVENT(loc_oPg1.txt_4c_DJobs, "KeyPress", THIS, "TxtDJobsKeyPress")
872: 
873:         *-- Numero da operacao
874:         loc_oPg1.AddObject("lbl_4c_Label9", "Label")
875:         WITH loc_oPg1.lbl_4c_Label9
876:             .Top       = 125
877:             .Left      = 607
878:             .Width     = 50
879:             .Height    = 15
880:             .Caption   = "C" + CHR(243) + "digo :"
881:             .FontName  = "Tahoma"
882:             .FontSize  = 8
883:             .ForeColor = RGB(90, 90, 90)
884:             .BackStyle = 0
885:             .AutoSize  = .T.
886:             .Visible   = .T.
887:         ENDWITH
888: 
889:         loc_oPg1.AddObject("txt_4c__Numes", "TextBox")
890:         WITH loc_oPg1.txt_4c__Numes
891:             .Top           = 121
892:             .Left          = 653
893:             .Width         = 80
894:             .Height        = 24
895:             .Value         = 0
896:             .Format        = "K"
897:             .MaxLength     = 10
898:             .FontName      = "Tahoma"
899:             .FontSize      = 8
900:             .BorderStyle   = 1
901:             .SpecialEffect = 1
902:             .Enabled       = .F.
903:             .Visible       = .T.
904:         ENDWITH
905: 
906:         *-- Autorizados
907:         loc_oPg1.AddObject("lbl_4c_Label12", "Label")
908:         WITH loc_oPg1.lbl_4c_Label12
909:             .Top       = 150
910:             .Left      = 27
911:             .Width     = 70

*-- Linhas 919 a 962:
919:             .Visible   = .T.
920:         ENDWITH
921: 
922:         loc_oPg1.AddObject("obj_4c_OptAutorizados", "OptionGroup")
923:         WITH loc_oPg1.obj_4c_OptAutorizados
924:             .Top         = 145
925:             .Left        = 92
926:             .Width       = 310
927:             .Height      = 27
928:             .ButtonCount = 3
929:             .BackStyle   = 0
930:             .BorderStyle = 0
931:             .Value       = 1
932:             .Visible     = .T.
933:             WITH .Buttons(1)
934:                 .Caption   = "Todos"
935:                 .Top       = 5
936:                 .Left      = 5
937:                 .Width     = 56
938:                 .Height    = 17
939:                 .AutoSize  = .F.
940:                 .BackStyle = 0
941:                 .ForeColor = RGB(90, 90, 90)
942:             ENDWITH
943:             WITH .Buttons(2)
944:                 .Caption   = "Autorizados"
945:                 .Top       = 6
946:                 .Left      = 63
947:                 .Width     = 75
948:                 .Height    = 15
949:                 .AutoSize  = .T.
950:                 .BackStyle = 0
951:                 .FontName  = "Tahoma"
952:                 .FontSize  = 8
953:                 .ForeColor = RGB(90, 90, 90)
954:             ENDWITH
955:             WITH .Buttons(3)
956:                 .Caption   = "N" + CHR(227) + "o Autorizados"
957:                 .Top       = 6
958:                 .Left      = 154
959:                 .Width     = 97
960:                 .Height    = 15
961:                 .AutoSize  = .T.
962:                 .BackStyle = 0

*-- Linhas 1082 a 1210:
1082:     * ConfigurarGrids - Cria os tres grids apos cursores ja carregados
1083:     * grd_4c_Emps (Empresas), grd_4c_Tipo (Operacoes), grd_4c_Cla (Classificacoes)
1084:     *--------------------------------------------------------------------------
1085:     PROTECTED PROCEDURE ConfigurarGrids()
1086:         LOCAL loc_oPg1, loc_oGrd
1087:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1088: 
1089:         *======================================================================
1090:         *-- GRID EMPRESAS
1091:         *======================================================================
1092:         loc_oPg1.AddObject("lbl_4c_Label1", "Label")
1093:         WITH loc_oPg1.lbl_4c_Label1
1094:             .Top       = 181
1095:             .Left      = 24
1096:             .Width     = 60
1097:             .Height    = 15
1098:             .Caption   = "Empresas"
1099:             .FontName  = "Tahoma"
1100:             .FontSize  = 8
1101:             .FontBold  = .T.
1102:             .ForeColor = RGB(90, 90, 90)
1103:             .BackStyle = 0
1104:             .AutoSize  = .T.
1105:             .Visible   = .T.
1106:         ENDWITH
1107: 
1108:         loc_oPg1.AddObject("chk_4c_Ck_MarcaEmp", "CheckBox")
1109:         WITH loc_oPg1.chk_4c_Ck_MarcaEmp
1110:             .Top       = 198
1111:             .Left      = 25
1112:             .Width     = 13
1113:             .Height    = 16
1114:             .Caption   = ""
1115:             .Value     = 1
1116:             .Alignment = 0
1117:             .Centered  = .F.
1118:             .Visible   = .T.
1119:         ENDWITH
1120:         BINDEVENT(loc_oPg1.chk_4c_Ck_MarcaEmp, "Click", THIS, "MarcaEmpClick")
1121: 
1122:         loc_oPg1.AddObject("grd_4c_Emps", "Grid")
1123:         loc_oGrd = loc_oPg1.grd_4c_Emps
1124:         WITH loc_oGrd
1125:             .Top               = 197
1126:             .Left              = 24
1127:             .Width             = 331
1128:             .Height            = 394
1129:             .ColumnCount       = 3
1130:             .FontName          = "Tahoma"
1131:             .FontSize          = 8
1132:             .AllowHeaderSizing = .F.
1133:             .AllowRowSizing    = .F.
1134:             .DeleteMark        = .F.
1135:             .RecordMark        = .F.
1136:             .RowHeight         = 17
1137:             .ScrollBars        = 2
1138:             .GridLineColor     = RGB(238, 238, 238)
1139:             .ReadOnly          = .F.
1140:             .RecordSource      = "cursor_4c_SigCdEmp"
1141:             .Visible           = .T.
1142:         ENDWITH
1143:         loc_oGrd.Column1.ControlSource = "cursor_4c_SigCdEmp.Imps"
1144:         loc_oGrd.Column2.ControlSource = "cursor_4c_SigCdEmp.cEmps"
1145:         loc_oGrd.Column3.ControlSource = "cursor_4c_SigCdEmp.Razas"
1146: 
1147:         WITH loc_oGrd.Column1
1148:             .Width         = 17
1149:             .ControlSource = "cursor_4c_SigCdEmp.Imps"
1150:             .FontName      = "Courier New"
1151:             .Movable       = .F.
1152:             .Resizable     = .F.
1153:             .ReadOnly      = .F.
1154:             .Sparse        = .F.
1155:         ENDWITH
1156:         loc_oGrd.Column1.Header1.Caption  = ""
1157:         loc_oGrd.Column1.Header1.ForeColor = RGB(90, 90, 90)
1158:         loc_oGrd.Column1.AddObject("Check1", "CheckBox")
1159:         WITH loc_oGrd.Column1.Check1
1160:             .Alignment = 0
1161:             .Caption   = ""
1162:             .AutoSize  = .T.
1163:             .BackStyle = 0
1164:             .Visible   = .T.
1165:         ENDWITH
1166:         loc_oGrd.Column1.CurrentControl = "Check1"
1167:         BINDEVENT(loc_oGrd.Column1.Check1, "MouseDown", THIS, "EmpCheckMouseDown")
1168:         BINDEVENT(loc_oGrd.Column1.Check1, "MouseUp",   THIS, "EmpCheckMouseUp")
1169:         BINDEVENT(loc_oGrd.Column1.Check1, "Click",     THIS, "EmpCheckClick")
1170:         BINDEVENT(loc_oGrd.Column1.Check1, "KeyPress",  THIS, "EmpCheckKeyPress")
1171: 
1172:         WITH loc_oGrd.Column2
1173:             .Width         = 27
1174:             .ControlSource = "cursor_4c_SigCdEmp.cEmps"
1175:             .FontName      = "Courier New"
1176:             .Movable       = .F.
1177:             .Resizable     = .F.
1178:             .ReadOnly      = .T.
1179:         ENDWITH
1180:         loc_oGrd.Column2.Header1.Caption   = "Emp."
1181:         loc_oGrd.Column2.Header1.Alignment = 2
1182:         loc_oGrd.Column2.Header1.ForeColor = RGB(90, 90, 90)
1183:         loc_oGrd.Column2.Text1.ForeColor   = RGB(0, 0, 0)
1184: 
1185:         WITH loc_oGrd.Column3
1186:             .Width         = 263
1187:             .ControlSource = "cursor_4c_SigCdEmp.Razas"
1188:             .FontName      = "Courier New"
1189:             .Movable       = .F.
1190:             .Resizable     = .F.
1191:             .ReadOnly      = .T.
1192:         ENDWITH
1193:         loc_oGrd.Column3.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1194:         loc_oGrd.Column3.Header1.Alignment = 2
1195:         loc_oGrd.Column3.Header1.ForeColor = RGB(90, 90, 90)
1196:         loc_oGrd.Column3.Text1.ForeColor   = RGB(0, 0, 0)
1197: 
1198:         *======================================================================
1199:         *-- GRID OPERACOES DE TITULO
1200:         *======================================================================
1201:         loc_oPg1.AddObject("lbl_4c_Label4", "Label")
1202:         WITH loc_oPg1.lbl_4c_Label4
1203:             .Top       = 181
1204:             .Left      = 369
1205:             .Width     = 120
1206:             .Height    = 15
1207:             .Caption   = "Opera" + CHR(231) + CHR(245) + "es de T" + CHR(237) + "tulo"
1208:             .FontName  = "Tahoma"
1209:             .FontSize  = 8
1210:             .FontBold  = .T.

*-- Linhas 1226 a 1269:
1226:             .Centered  = .F.
1227:             .Visible   = .T.
1228:         ENDWITH
1229:         BINDEVENT(loc_oPg1.chk_4c_Ck_MarcaOpe, "Click", THIS, "MarcaOpeClick")
1230: 
1231:         loc_oPg1.AddObject("grd_4c_Tipo", "Grid")
1232:         loc_oGrd = loc_oPg1.grd_4c_Tipo
1233:         WITH loc_oGrd
1234:             .Top               = 197
1235:             .Left              = 369
1236:             .Width             = 323
1237:             .Height            = 394
1238:             .ColumnCount       = 2
1239:             .FontName          = "Tahoma"
1240:             .FontSize          = 8
1241:             .AllowHeaderSizing = .F.
1242:             .AllowRowSizing    = .F.
1243:             .DeleteMark        = .F.
1244:             .RecordMark        = .F.
1245:             .HeaderHeight      = 17
1246:             .RowHeight         = 17
1247:             .ScrollBars        = 2
1248:             .GridLineColor     = RGB(238, 238, 238)
1249:             .ReadOnly          = .F.
1250:             .RecordSource      = "cursor_4c_SigOpOpe"
1251:             .Visible           = .T.
1252:         ENDWITH
1253:         loc_oGrd.Column1.ControlSource = "cursor_4c_SigOpOpe.Imps"
1254:         loc_oGrd.Column2.ControlSource = "cursor_4c_SigOpOpe.Dopes"
1255: 
1256:         WITH loc_oGrd.Column1
1257:             .Width         = 17
1258:             .ControlSource = "cursor_4c_SigOpOpe.Imps"
1259:             .Alignment     = 0
1260:             .FontName      = "Courier New"
1261:             .Movable       = .F.
1262:             .Resizable     = .F.
1263:             .ReadOnly      = .F.
1264:             .Sparse        = .F.
1265:             .Enabled       = .T.
1266:         ENDWITH
1267:         loc_oGrd.Column1.Header1.Caption  = ""
1268:         loc_oGrd.Column1.Header1.ForeColor = RGB(90, 90, 90)
1269:         loc_oGrd.Column1.AddObject("check12", "CheckBox")

*-- Linhas 1276 a 1322:
1276:             .Visible   = .T.
1277:         ENDWITH
1278:         loc_oGrd.Column1.CurrentControl = "check12"
1279:         BINDEVENT(loc_oGrd.Column1.check12, "MouseDown", THIS, "TipoCheckMouseDown")
1280:         BINDEVENT(loc_oGrd.Column1.check12, "MouseUp",   THIS, "TipoCheckMouseUp")
1281:         BINDEVENT(loc_oGrd.Column1.check12, "Click",     THIS, "TipoCheckClick")
1282:         BINDEVENT(loc_oGrd.Column1.check12, "KeyPress",  THIS, "TipoCheckKeyPress")
1283: 
1284:         WITH loc_oGrd.Column2
1285:             .Width         = 283
1286:             .ControlSource = "cursor_4c_SigOpOpe.Dopes"
1287:             .FontName      = "Courier New"
1288:             .Movable       = .F.
1289:             .Resizable     = .F.
1290:             .ReadOnly      = .T.
1291:             .Enabled       = .T.
1292:         ENDWITH
1293:         loc_oGrd.Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1294:         loc_oGrd.Column2.Header1.Alignment = 2
1295:         loc_oGrd.Column2.Header1.ForeColor = RGB(90, 90, 90)
1296:         loc_oGrd.Column2.Text1.ForeColor   = RGB(0, 0, 0)
1297:         loc_oGrd.Column2.Text1.BackColor   = RGB(255, 255, 255)
1298:         loc_oGrd.Column2.Text1.ReadOnly    = .T.
1299: 
1300:         *======================================================================
1301:         *-- GRID CLASSIFICACOES
1302:         *======================================================================
1303:         loc_oPg1.AddObject("lbl_4c_Label8", "Label")
1304:         WITH loc_oPg1.lbl_4c_Label8
1305:             .Top       = 180
1306:             .Left      = 706
1307:             .Width     = 95
1308:             .Height    = 15
1309:             .Caption   = "Classifica" + CHR(231) + CHR(245) + "es"
1310:             .FontName  = "Tahoma"
1311:             .FontSize  = 8
1312:             .FontBold  = .T.
1313:             .ForeColor = RGB(90, 90, 90)
1314:             .BackStyle = 0
1315:             .AutoSize  = .T.
1316:             .Visible   = .T.
1317:         ENDWITH
1318: 
1319:         loc_oPg1.AddObject("chk_4c_Ck_MarcaCla", "CheckBox")
1320:         WITH loc_oPg1.chk_4c_Ck_MarcaCla
1321:             .Top       = 198
1322:             .Left      = 708

*-- Linhas 1328 a 2220:
1328:             .Centered  = .F.
1329:             .Visible   = .T.
1330:         ENDWITH
1331:         BINDEVENT(loc_oPg1.chk_4c_Ck_MarcaCla, "Click", THIS, "MarcaClaClick")
1332: 
1333:         loc_oPg1.AddObject("grd_4c_Cla", "Grid")
1334:         loc_oGrd = loc_oPg1.grd_4c_Cla
1335:         WITH loc_oGrd
1336:             .Top               = 197
1337:             .Left              = 706
1338:             .Width             = 574
1339:             .Height            = 394
1340:             .ColumnCount       = 3
1341:             .FontName          = "Tahoma"
1342:             .FontSize          = 8
1343:             .AllowHeaderSizing = .F.
1344:             .AllowRowSizing    = .F.
1345:             .DeleteMark        = .F.
1346:             .RecordMark        = .F.
1347:             .RowHeight         = 17
1348:             .ScrollBars        = 2
1349:             .GridLineColor     = RGB(238, 238, 238)
1350:             .ReadOnly          = .F.
1351:             .RecordSource      = "cursor_4c_SigCdClc"
1352:             .Visible           = .T.
1353:         ENDWITH
1354:         loc_oGrd.Column1.ControlSource = "cursor_4c_SigCdClc.Imps"
1355:         loc_oGrd.Column2.ControlSource = "cursor_4c_SigCdClc.Codigos"
1356:         loc_oGrd.Column3.ControlSource = "cursor_4c_SigCdClc.Descs"
1357: 
1358:         WITH loc_oGrd.Column1
1359:             .Width         = 19
1360:             .ControlSource = "cursor_4c_SigCdClc.Imps"
1361:             .FontName      = "Courier New"
1362:             .Movable       = .F.
1363:             .Resizable     = .F.
1364:             .ReadOnly      = .F.
1365:             .Sparse        = .F.
1366:         ENDWITH
1367:         loc_oGrd.Column1.Header1.Caption  = ""
1368:         loc_oGrd.Column1.Header1.ForeColor = RGB(90, 90, 90)
1369:         loc_oGrd.Column1.AddObject("check13", "CheckBox")
1370:         WITH loc_oGrd.Column1.check13
1371:             .Alignment = 0
1372:             .Caption   = ""
1373:             .AutoSize  = .T.
1374:             .BackStyle = 0
1375:             .Visible   = .T.
1376:         ENDWITH
1377:         loc_oGrd.Column1.CurrentControl = "check13"
1378:         BINDEVENT(loc_oGrd.Column1.check13, "MouseDown", THIS, "ClaCheckMouseDown")
1379:         BINDEVENT(loc_oGrd.Column1.check13, "MouseUp",   THIS, "ClaCheckMouseUp")
1380:         BINDEVENT(loc_oGrd.Column1.check13, "Click",     THIS, "ClaCheckClick")
1381:         BINDEVENT(loc_oGrd.Column1.check13, "KeyPress",  THIS, "ClaCheckKeyPress")
1382: 
1383:         WITH loc_oGrd.Column2
1384:             .Width         = 80
1385:             .ControlSource = "cursor_4c_SigCdClc.Codigos"
1386:             .FontName      = "Courier New"
1387:             .Movable       = .F.
1388:             .Resizable     = .F.
1389:             .ReadOnly      = .T.
1390:         ENDWITH
1391:         loc_oGrd.Column2.Header1.Caption   = "C" + CHR(243) + "digo"
1392:         loc_oGrd.Column2.Header1.Alignment = 2
1393:         loc_oGrd.Column2.Header1.ForeColor = RGB(90, 90, 90)
1394:         loc_oGrd.Column2.Text1.ForeColor   = RGB(0, 0, 0)
1395:         loc_oGrd.Column2.Text1.ReadOnly    = .F.
1396: 
1397:         WITH loc_oGrd.Column3
1398:             .Width         = 452
1399:             .ControlSource = "cursor_4c_SigCdClc.Descs"
1400:             .FontName      = "Courier New"
1401:             .Movable       = .F.
1402:             .Resizable     = .F.
1403:             .ReadOnly      = .T.
1404:         ENDWITH
1405:         loc_oGrd.Column3.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1406:         loc_oGrd.Column3.Header1.Alignment = 2
1407:         loc_oGrd.Column3.Header1.ForeColor = RGB(90, 90, 90)
1408:         loc_oGrd.Column3.Text1.ForeColor   = RGB(0, 0, 0)
1409:         loc_oGrd.Column3.Text1.BackColor   = RGB(255, 255, 255)
1410:         loc_oGrd.Column3.Text1.ReadOnly    = .T.
1411: 
1412:     ENDPROC
1413: 
1414:     *--------------------------------------------------------------------------
1415:     * AtualizarEstadoControles - Report form: sem estado CRUD, ajusta botoes
1416:     *--------------------------------------------------------------------------
1417:     PROCEDURE AtualizarEstadoControles()
1418:         THIS.AjustarBotoesPorModo()
1419:     ENDPROC
1420: 
1421:     *--------------------------------------------------------------------------
1422:     * LimparCampos - Reseta todos os filtros para valores padrao
1423:     *--------------------------------------------------------------------------
1424:     PROCEDURE LimparCampos()
1425:         LOCAL loc_oPg1
1426:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1427:         loc_oPg1.txt_4c_DtInicial.Value          = DATE()
1428:         loc_oPg1.txt_4c_DtFinal.Value            = DATE()
1429:         loc_oPg1.txt_4c__Numes.Value             = 0
1430:         loc_oPg1.txt_4c_Saldo.Value              = 0
1431:         loc_oPg1.txt_4c__Juros.Value             = 0
1432:         loc_oPg1.txt_4c_Grupo.Value              = ""
1433:         loc_oPg1.txt_4c_DGrupo.Value             = ""
1434:         loc_oPg1.txt_4c_Conta.Value              = ""
1435:         loc_oPg1.txt_4c_DConta.Value             = ""
1436:         loc_oPg1.txt_4c__Jobs.Value              = ""
1437:         loc_oPg1.txt_4c_DJobs.Value              = ""
1438:         loc_oPg1.obj_4c_Opt_AnaSi.Value          = 1
1439:         loc_oPg1.obj_4c_OptDatas.Value           = 1
1440:         loc_oPg1.obj_4c_OptSaldos.Value          = 1
1441:         loc_oPg1.obj_4c_OptAutorizados.Value     = 1
1442:         loc_oPg1.obj_4c_Opt_Juros.Value          = 2
1443:         loc_oPg1.chk_4c_Ck_Pagamentos.Value     = 0
1444:         loc_oPg1.chk_4c_Ck_Recebimentos.Value   = 0
1445:         THIS.HabObjs(.F.)
1446:     ENDPROC
1447: 
1448:     *--------------------------------------------------------------------------
1449:     * HabObjs - Habilita/desabilita controles conforme modo PagRec
1450:     * par_lPagRec: .T. = modo pagamento/recebimento, .F. = modo normal
1451:     *--------------------------------------------------------------------------
1452:     PROCEDURE HabObjs(par_lPagRec)
1453:         LOCAL loc_oPg1, loc_cLabel
1454:         loc_oPg1   = THIS.pgf_4c_Paginas.Page1
1455:         loc_cLabel = IIF(loc_oPg1.chk_4c_Ck_Pagamentos.Value = 1, ;
1456:             "Pagamento:", "Recebimento:")
1457:         loc_oPg1.txt_4c__Numes.Enabled     = par_lPagRec
1458:         loc_oPg1.obj_4c_Opt_AnaSi.Enabled  = !par_lPagRec
1459:         loc_oPg1.lbl_4c_LblPeriodo.Caption = IIF(par_lPagRec, loc_cLabel, "Vencimento :")
1460:         loc_oPg1.obj_4c_Opt_Juros.Enabled  = !par_lPagRec
1461:         loc_oPg1.txt_4c__Juros.Enabled     = !par_lPagRec
1462:     ENDPROC
1463: 
1464:     *--------------------------------------------------------------------------
1465:     * FormParaRelatorio - Transfere valores do formulario para o BO
1466:     *--------------------------------------------------------------------------
1467:     PROCEDURE FormParaRelatorio()
1468:         LOCAL loc_oPg1, loc_oBO
1469:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1470:         loc_oBO  = THIS.this_oRelatorio
1471: 
1472:         loc_oBO.this_dDtInicial      = loc_oPg1.txt_4c_DtInicial.Value
1473:         loc_oBO.this_dDtFinal        = loc_oPg1.txt_4c_DtFinal.Value
1474:         loc_oBO.this_nOptAnaSi       = loc_oPg1.obj_4c_Opt_AnaSi.Value
1475:         loc_oBO.this_nOptDatas       = loc_oPg1.obj_4c_OptDatas.Value
1476:         loc_oBO.this_nOptSaldos      = loc_oPg1.obj_4c_OptSaldos.Value
1477:         loc_oBO.this_nOptAutorizados = loc_oPg1.obj_4c_OptAutorizados.Value
1478:         loc_oBO.this_nOptJuros       = loc_oPg1.obj_4c_Opt_Juros.Value
1479:         loc_oBO.this_nJuros          = loc_oPg1.txt_4c__Juros.Value
1480:         loc_oBO.this_nSaldo          = loc_oPg1.txt_4c_Saldo.Value
1481:         loc_oBO.this_cGrupo          = PADR(ALLTRIM(loc_oPg1.txt_4c_Grupo.Value), 10)
1482:         loc_oBO.this_cDGrupo         = ALLTRIM(loc_oPg1.txt_4c_DGrupo.Value)
1483:         loc_oBO.this_cConta          = PADR(ALLTRIM(loc_oPg1.txt_4c_Conta.Value), 10)
1484:         loc_oBO.this_cDConta         = ALLTRIM(loc_oPg1.txt_4c_DConta.Value)
1485:         loc_oBO.this_cCdMoeda        = ALLTRIM(loc_oPg1.txt_4c__cd_moeda.Value)
1486:         loc_oBO.this_cDsMoeda        = ALLTRIM(loc_oPg1.txt_4c__ds_moeda.Value)
1487:         loc_oBO.this_cJobs           = PADR(ALLTRIM(loc_oPg1.txt_4c__Jobs.Value), 10)
1488:         loc_oBO.this_cDJobs          = ALLTRIM(loc_oPg1.txt_4c_DJobs.Value)
1489:         loc_oBO.this_nNumes          = loc_oPg1.txt_4c__Numes.Value
1490:         loc_oBO.this_nPagamentos     = loc_oPg1.chk_4c_Ck_Pagamentos.Value
1491:         loc_oBO.this_nRecebimentos   = loc_oPg1.chk_4c_Ck_Recebimentos.Value
1492:     ENDPROC
1493: 
1494:     *==========================================================================
1495:     * HANDLERS DE BOTOES
1496:     *==========================================================================
1497: 
1498:     PROCEDURE BtnVisualizarClick()
1499:         LOCAL loc_oPg1
1500:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1501:         IF EMPTY(loc_oPg1.txt_4c_DtInicial.Value) OR ;
1502:            EMPTY(loc_oPg1.txt_4c_DtFinal.Value)
1503:             MsgAviso("Informe o per" + CHR(237) + "odo inicial e final.")
1504:             RETURN
1505:         ENDIF
1506:         THIS.FormParaRelatorio()
1507:         THIS.this_oRelatorio.Visualizar()
1508:     ENDPROC
1509: 
1510:     PROCEDURE BtnImprimirClick()
1511:         LOCAL loc_oPg1
1512:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1513:         IF EMPTY(loc_oPg1.txt_4c_DtInicial.Value) OR ;
1514:            EMPTY(loc_oPg1.txt_4c_DtFinal.Value)
1515:             MsgAviso("Informe o per" + CHR(237) + "odo inicial e final.")
1516:             RETURN
1517:         ENDIF
1518:         THIS.FormParaRelatorio()
1519:         THIS.this_oRelatorio.Imprimir()
1520:     ENDPROC
1521: 
1522:     PROCEDURE BtnGerarExcelClick()
1523:         LOCAL loc_oPg1
1524:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1525:         IF EMPTY(loc_oPg1.txt_4c_DtInicial.Value) OR ;
1526:            EMPTY(loc_oPg1.txt_4c_DtFinal.Value)
1527:             MsgAviso("Informe o per" + CHR(237) + "odo inicial e final.")
1528:             RETURN
1529:         ENDIF
1530:         THIS.FormParaRelatorio()
1531:         THIS.this_oRelatorio.ExportarExcel()
1532:     ENDPROC
1533: 
1534:     PROCEDURE BtnCancelarClick()
1535:         THIS.Release()
1536:     ENDPROC
1537: 
1538:     *==========================================================================
1539:     * HANDLERS CRUD (form REPORT - delegam para acoes equivalentes do relatorio)
1540:     *==========================================================================
1541: 
1542:     PROCEDURE BtnIncluirClick()
1543:         LOCAL loc_oPg1
1544:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1545:         IF EMPTY(loc_oPg1.txt_4c_DtInicial.Value) OR ;
1546:            EMPTY(loc_oPg1.txt_4c_DtFinal.Value)
1547:             MsgAviso("Informe o per" + CHR(237) + "odo inicial e final.")
1548:             RETURN
1549:         ENDIF
1550:         THIS.FormParaRelatorio()
1551:         THIS.this_oRelatorio.Visualizar()
1552:     ENDPROC
1553: 
1554:     PROCEDURE BtnAlterarClick()
1555:         LOCAL loc_oPg1
1556:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1557:         IF EMPTY(loc_oPg1.txt_4c_DtInicial.Value) OR ;
1558:            EMPTY(loc_oPg1.txt_4c_DtFinal.Value)
1559:             MsgAviso("Informe o per" + CHR(237) + "odo inicial e final.")
1560:             RETURN
1561:         ENDIF
1562:         THIS.FormParaRelatorio()
1563:         THIS.this_oRelatorio.Imprimir()
1564:     ENDPROC
1565: 
1566:     PROCEDURE BtnExcluirClick()
1567:         THIS.LimparCampos()
1568:         THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial.SetFocus()
1569:     ENDPROC
1570: 
1571:     *==========================================================================
1572:     * HANDLERS MARCAR/DESMARCAR TODOS (checkboxes acima de cada grid)
1573:     *==========================================================================
1574: 
1575:     PROCEDURE MarcaEmpClick()
1576:         LOCAL loc_nImps
1577:         loc_nImps = IIF(THIS.pgf_4c_Paginas.Page1.chk_4c_Ck_MarcaEmp.Value = 1, 1, 0)
1578:         REPLACE ALL Imps WITH loc_nImps IN cursor_4c_SigCdEmp
1579:         THIS.pgf_4c_Paginas.Page1.grd_4c_Emps.Refresh()
1580:     ENDPROC
1581: 
1582:     PROCEDURE MarcaOpeClick()
1583:         LOCAL loc_nImps
1584:         loc_nImps = IIF(THIS.pgf_4c_Paginas.Page1.chk_4c_Ck_MarcaOpe.Value = 1, 1, 0)
1585:         REPLACE ALL Imps WITH loc_nImps IN cursor_4c_SigOpOpe
1586:         THIS.pgf_4c_Paginas.Page1.grd_4c_Tipo.Refresh()
1587:     ENDPROC
1588: 
1589:     PROCEDURE MarcaClaClick()
1590:         LOCAL loc_nImps
1591:         loc_nImps = IIF(THIS.pgf_4c_Paginas.Page1.chk_4c_Ck_MarcaCla.Value = 1, 1, 0)
1592:         REPLACE ALL Imps WITH loc_nImps IN cursor_4c_SigCdClc
1593:         THIS.pgf_4c_Paginas.Page1.grd_4c_Cla.Refresh()
1594:     ENDPROC
1595: 
1596:     *==========================================================================
1597:     * HANDLERS CHECKBOX DO GRID EMPRESAS
1598:     *==========================================================================
1599: 
1600:     PROCEDURE EmpCheckMouseDown(par_nButton, par_nShift, par_nX, par_nY)
1601:         LOCAL loc_nImps
1602:         loc_nImps = IIF(cursor_4c_SigCdEmp.Imps = 0, 1, 0)
1603:         REPLACE Imps WITH loc_nImps IN cursor_4c_SigCdEmp
1604:         THIS.pgf_4c_Paginas.Page1.grd_4c_Emps.Refresh()
1605:         NODEFAULT
1606:     ENDPROC
1607: 
1608:     PROCEDURE EmpCheckMouseUp(par_nButton, par_nShift, par_nX, par_nY)
1609:         NODEFAULT
1610:     ENDPROC
1611: 
1612:     PROCEDURE EmpCheckClick()
1613:         NODEFAULT
1614:     ENDPROC
1615: 
1616:     PROCEDURE EmpCheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1617:         IF INLIST(par_nKeyCode, 13, 32)
1618:             LOCAL loc_nImps
1619:             loc_nImps = IIF(cursor_4c_SigCdEmp.Imps = 1, 0, 1)
1620:             REPLACE Imps WITH loc_nImps IN cursor_4c_SigCdEmp
1621:             THIS.pgf_4c_Paginas.Page1.grd_4c_Emps.Refresh()
1622:             NODEFAULT
1623:         ENDIF
1624:     ENDPROC
1625: 
1626:     *==========================================================================
1627:     * HANDLERS CHECKBOX DO GRID TIPO (OPERACOES)
1628:     *==========================================================================
1629: 
1630:     PROCEDURE TipoCheckMouseDown(par_nButton, par_nShift, par_nX, par_nY)
1631:         LOCAL loc_nImps
1632:         loc_nImps = IIF(cursor_4c_SigOpOpe.Imps = 0, 1, 0)
1633:         REPLACE Imps WITH loc_nImps IN cursor_4c_SigOpOpe
1634:         THIS.pgf_4c_Paginas.Page1.grd_4c_Tipo.Refresh()
1635:         NODEFAULT
1636:     ENDPROC
1637: 
1638:     PROCEDURE TipoCheckMouseUp(par_nButton, par_nShift, par_nX, par_nY)
1639:         NODEFAULT
1640:     ENDPROC
1641: 
1642:     PROCEDURE TipoCheckClick()
1643:         NODEFAULT
1644:     ENDPROC
1645: 
1646:     PROCEDURE TipoCheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1647:         IF INLIST(par_nKeyCode, 13, 32)
1648:             LOCAL loc_nImps
1649:             loc_nImps = IIF(cursor_4c_SigOpOpe.Imps = 1, 0, 1)
1650:             REPLACE Imps WITH loc_nImps IN cursor_4c_SigOpOpe
1651:             THIS.pgf_4c_Paginas.Page1.grd_4c_Tipo.Refresh()
1652:             NODEFAULT
1653:         ENDIF
1654:     ENDPROC
1655: 
1656:     *==========================================================================
1657:     * HANDLERS CHECKBOX DO GRID CLASSIFICACOES
1658:     *==========================================================================
1659: 
1660:     PROCEDURE ClaCheckMouseDown(par_nButton, par_nShift, par_nX, par_nY)
1661:         LOCAL loc_nImps
1662:         loc_nImps = IIF(cursor_4c_SigCdClc.Imps = 0, 1, 0)
1663:         REPLACE Imps WITH loc_nImps IN cursor_4c_SigCdClc
1664:         THIS.pgf_4c_Paginas.Page1.grd_4c_Cla.Refresh()
1665:         NODEFAULT
1666:     ENDPROC
1667: 
1668:     PROCEDURE ClaCheckMouseUp(par_nButton, par_nShift, par_nX, par_nY)
1669:         NODEFAULT
1670:     ENDPROC
1671: 
1672:     PROCEDURE ClaCheckClick()
1673:         NODEFAULT
1674:     ENDPROC
1675: 
1676:     PROCEDURE ClaCheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1677:         IF INLIST(par_nKeyCode, 13, 32)
1678:             LOCAL loc_nImps
1679:             loc_nImps = IIF(cursor_4c_SigCdClc.Imps = 1, 0, 1)
1680:             REPLACE Imps WITH loc_nImps IN cursor_4c_SigCdClc
1681:             THIS.pgf_4c_Paginas.Page1.grd_4c_Cla.Refresh()
1682:             NODEFAULT
1683:         ENDIF
1684:     ENDPROC
1685: 
1686:     *==========================================================================
1687:     * HANDLERS MODO PAGREC E JUROS
1688:     *==========================================================================
1689: 
1690:     PROCEDURE PagamentosChange()
1691:         LOCAL loc_oPg1
1692:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1693:         IF loc_oPg1.chk_4c_Ck_Pagamentos.Value = 1
1694:             loc_oPg1.chk_4c_Ck_Recebimentos.Value = 0
1695:         ENDIF
1696:         THIS.HabObjs((loc_oPg1.chk_4c_Ck_Pagamentos.Value = 1) OR ;
1697:             (loc_oPg1.chk_4c_Ck_Recebimentos.Value = 1))
1698:     ENDPROC
1699: 
1700:     PROCEDURE RecebimentosChange()
1701:         LOCAL loc_oPg1
1702:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1703:         IF loc_oPg1.chk_4c_Ck_Recebimentos.Value = 1
1704:             loc_oPg1.chk_4c_Ck_Pagamentos.Value = 0
1705:         ENDIF
1706:         THIS.HabObjs((loc_oPg1.chk_4c_Ck_Pagamentos.Value = 1) OR ;
1707:             (loc_oPg1.chk_4c_Ck_Recebimentos.Value = 1))
1708:     ENDPROC
1709: 
1710:     PROCEDURE JurosOptClick()
1711:         IF THIS.pgf_4c_Paginas.Page1.obj_4c_Opt_Juros.Value = 2
1712:             THIS.pgf_4c_Paginas.Page1.txt_4c__Juros.Value = 0
1713:         ENDIF
1714:     ENDPROC
1715: 
1716:     FUNCTION JurosWhen()
1717:         RETURN (THIS.pgf_4c_Paginas.Page1.obj_4c_Opt_Juros.Value = 1)
1718:     ENDFUNC
1719: 
1720:     *==========================================================================
1721:     * LOOKUP MOEDA
1722:     *==========================================================================
1723: 
1724:     PROCEDURE TxtMoedaCdKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1725:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR ;
1726:            par_nKeyCode = 115 OR par_nKeyCode = 116
1727:             LOCAL loc_cValor, loc_nRes, loc_nCotacao
1728:             loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c__cd_moeda.Value)
1729:             IF EMPTY(loc_cValor)
1730:                 THIS.pgf_4c_Paginas.Page1.txt_4c__ds_moeda.Value = ""
1731:                 THIS.this_oRelatorio.this_nVlCotacao = 1
1732:             ELSE
1733:                 loc_nRes = SQLEXEC(gnConnHandle, ;
1734:                     "SELECT CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cValor), ;
1735:                     "cursor_4c_ValidaMoeda")
1736:                 IF loc_nRes > 0 AND !EOF("cursor_4c_ValidaMoeda")
1737:                     THIS.pgf_4c_Paginas.Page1.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_ValidaMoeda.CMoes)
1738:                     THIS.pgf_4c_Paginas.Page1.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_ValidaMoeda.DMoes)
1739:                     loc_nCotacao = THIS.this_oRelatorio.BuscarCambio(loc_cValor)
1740:                     THIS.this_oRelatorio.this_nVlCotacao = IIF(loc_nCotacao = 0, 1, loc_nCotacao)
1741:                 ELSE
1742:                     THIS.AbrirBuscaMoeda()
1743:                 ENDIF
1744:                 IF USED("cursor_4c_ValidaMoeda")
1745:                     USE IN cursor_4c_ValidaMoeda
1746:                 ENDIF
1747:             ENDIF
1748:         ENDIF
1749:     ENDPROC
1750: 
1751:     FUNCTION MoedaDsWhen()
1752:         RETURN EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c__cd_moeda.Value)
1753:     ENDFUNC
1754: 
1755:     PROCEDURE TxtMoedaDsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1756:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR ;
1757:            par_nKeyCode = 115 OR par_nKeyCode = 116
1758:             LOCAL loc_cValor
1759:             loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c__ds_moeda.Value)
1760:             IF EMPTY(loc_cValor)
1761:                 THIS.pgf_4c_Paginas.Page1.txt_4c__cd_moeda.Value = ""
1762:                 THIS.pgf_4c_Paginas.Page1.txt_4c__ds_moeda.Value = ""
1763:             ELSE
1764:                 THIS.AbrirBuscaMoeda()
1765:             ENDIF
1766:         ENDIF
1767:     ENDPROC
1768: 
1769:     PROCEDURE AbrirBuscaMoeda()
1770:         LOCAL loc_oForm, loc_cValor, loc_cMoedaSel, loc_nCotacao
1771:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c__cd_moeda.Value)
1772:         IF EMPTY(loc_cValor)
1773:             loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c__ds_moeda.Value)
1774:         ENDIF
1775: 
1776:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1777:             "SigCdMoe", "cursor_4c_BuscaMoeda", "CMoes", loc_cValor, ;
1778:             "Busca de Moeda")
1779:         IF VARTYPE(loc_oForm) != "O"
1780:             RETURN
1781:         ENDIF
1782: 
1783:         IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1784:             THIS.pgf_4c_Paginas.Page1.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)
1785:             THIS.pgf_4c_Paginas.Page1.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.DMoes)
1786:             loc_cMoedaSel = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)
1787:             loc_nCotacao  = THIS.this_oRelatorio.BuscarCambio(loc_cMoedaSel)
1788:             THIS.this_oRelatorio.this_nVlCotacao = IIF(loc_nCotacao = 0, 1, loc_nCotacao)
1789:         ELSE
1790:             IF !loc_oForm.this_lAchouRegistro
1791:             loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
1792:             loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1793:             loc_oForm.Show()
1794:             IF loc_oForm.this_lSelecionou
1795:                 THIS.pgf_4c_Paginas.Page1.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)
1796:                 THIS.pgf_4c_Paginas.Page1.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.DMoes)
1797:                 loc_cMoedaSel = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)
1798:                 loc_nCotacao  = THIS.this_oRelatorio.BuscarCambio(loc_cMoedaSel)
1799:                 THIS.this_oRelatorio.this_nVlCotacao = IIF(loc_nCotacao = 0, 1, loc_nCotacao)
1800:             ELSE
1801:                 THIS.pgf_4c_Paginas.Page1.txt_4c__cd_moeda.Value = ""
1802:                 THIS.pgf_4c_Paginas.Page1.txt_4c__ds_moeda.Value = ""
1803:                 THIS.this_oRelatorio.this_nVlCotacao = 1
1804:             ENDIF
1805:             ENDIF
1806:         ENDIF
1807: 
1808:         IF USED("cursor_4c_BuscaMoeda")
1809:             USE IN cursor_4c_BuscaMoeda
1810:         ENDIF
1811:         loc_oForm.Release()
1812:     ENDPROC
1813: 
1814:     *==========================================================================
1815:     * LOOKUP GRUPO / DGRUPO
1816:     *==========================================================================
1817: 
1818:     PROCEDURE TxtGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1819:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR ;
1820:            par_nKeyCode = 115 OR par_nKeyCode = 116
1821:             LOCAL loc_cValor, loc_nRes
1822:             loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value)
1823:             IF EMPTY(loc_cValor)
1824:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupo.Value = ""
1825:             ELSE
1826:                 loc_nRes = SQLEXEC(gnConnHandle, ;
1827:                     "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cValor), ;
1828:                     "cursor_4c_ValidaGrupo")
1829:                 IF loc_nRes > 0 AND !EOF("cursor_4c_ValidaGrupo")
1830:                     THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_ValidaGrupo.Codigos)
1831:                     THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_ValidaGrupo.Descrs)
1832:                 ELSE
1833:                     THIS.AbrirBuscaGrupo()
1834:                 ENDIF
1835:                 IF USED("cursor_4c_ValidaGrupo")
1836:                     USE IN cursor_4c_ValidaGrupo
1837:                 ENDIF
1838:             ENDIF
1839:         ENDIF
1840:     ENDPROC
1841: 
1842:     FUNCTION DGrupoWhen()
1843:         RETURN EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value)
1844:     ENDFUNC
1845: 
1846:     PROCEDURE TxtDGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1847:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR ;
1848:            par_nKeyCode = 115 OR par_nKeyCode = 116
1849:             LOCAL loc_cValor
1850:             loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupo.Value)
1851:             IF EMPTY(loc_cValor)
1852:                 THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value = ""
1853:             ELSE
1854:                 THIS.AbrirBuscaGrupo()
1855:             ENDIF
1856:         ENDIF
1857:     ENDPROC
1858: 
1859:     PROCEDURE AbrirBuscaGrupo()
1860:         LOCAL loc_oForm, loc_cValor
1861:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value)
1862: 
1863:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1864:             "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", loc_cValor, ;
1865:             "Busca de Grupo Cont" + CHR(225) + "bil")
1866:         IF VARTYPE(loc_oForm) != "O"
1867:             RETURN
1868:         ENDIF
1869: 
1870:         IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1871:             THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
1872:             THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
1873:         ELSE
1874:             IF !loc_oForm.this_lAchouRegistro
1875:             loc_oForm.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1876:             loc_oForm.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1877:             loc_oForm.Show()
1878:             IF loc_oForm.this_lSelecionou
1879:                 THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
1880:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
1881:             ELSE
1882:                 THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value  = ""
1883:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupo.Value = ""
1884:             ENDIF
1885:             ENDIF
1886:         ENDIF
1887: 
1888:         IF USED("cursor_4c_BuscaGrupo")
1889:             USE IN cursor_4c_BuscaGrupo
1890:         ENDIF
1891:         loc_oForm.Release()
1892:     ENDPROC
1893: 
1894:     *==========================================================================
1895:     * LOOKUP CONTA / DCONTA
1896:     *==========================================================================
1897: 
1898:     PROCEDURE TxtContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1899:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR ;
1900:            par_nKeyCode = 115 OR par_nKeyCode = 116
1901:             LOCAL loc_cValor, loc_cGrupo, loc_nRes, loc_cSQL
1902:             loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Conta.Value)
1903:             IF EMPTY(loc_cValor)
1904:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DConta.Value = ""
1905:             ELSE
1906:                 loc_cGrupo = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value)
1907:                 loc_cSQL   = "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + ;
1908:                     EscaparSQL(PADR(loc_cValor, 10))
1909:                 IF !EMPTY(loc_cGrupo)
1910:                     loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(loc_cGrupo)
1911:                 ENDIF
1912:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaConta")
1913:                 IF loc_nRes > 0 AND !EOF("cursor_4c_ValidaConta")
1914:                     THIS.pgf_4c_Paginas.Page1.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_ValidaConta.IClis)
1915:                     THIS.pgf_4c_Paginas.Page1.txt_4c_DConta.Value = ALLTRIM(cursor_4c_ValidaConta.RClis)
1916:                 ELSE
1917:                     THIS.AbrirBuscaConta()
1918:                 ENDIF
1919:                 IF USED("cursor_4c_ValidaConta")
1920:                     USE IN cursor_4c_ValidaConta
1921:                 ENDIF
1922:             ENDIF
1923:         ENDIF
1924:     ENDPROC
1925: 
1926:     FUNCTION DContaWhen()
1927:         RETURN EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_Conta.Value)
1928:     ENDFUNC
1929: 
1930:     PROCEDURE TxtDContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1931:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR ;
1932:            par_nKeyCode = 115 OR par_nKeyCode = 116
1933:             LOCAL loc_cValor
1934:             loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DConta.Value)
1935:             IF EMPTY(loc_cValor)
1936:                 THIS.pgf_4c_Paginas.Page1.txt_4c_Conta.Value = ""
1937:             ELSE
1938:                 THIS.AbrirBuscaConta()
1939:             ENDIF
1940:         ENDIF
1941:     ENDPROC
1942: 
1943:     PROCEDURE AbrirBuscaConta()
1944:         LOCAL loc_oForm, loc_cValor
1945:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Conta.Value)
1946: 
1947:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1948:             "SigCdCli", "cursor_4c_BuscaConta", "IClis", loc_cValor, ;
1949:             "Busca de Conta")
1950:         IF VARTYPE(loc_oForm) != "O"
1951:             RETURN
1952:         ENDIF
1953: 
1954:         IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1955:             THIS.pgf_4c_Paginas.Page1.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
1956:             THIS.pgf_4c_Paginas.Page1.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
1957:         ELSE
1958:             IF !loc_oForm.this_lAchouRegistro
1959:             loc_oForm.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
1960:             loc_oForm.mAddColuna("RClis", "", "Nome")
1961:             loc_oForm.Show()
1962:             IF loc_oForm.this_lSelecionou
1963:                 THIS.pgf_4c_Paginas.Page1.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
1964:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
1965:             ELSE
1966:                 THIS.pgf_4c_Paginas.Page1.txt_4c_Conta.Value  = ""
1967:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DConta.Value = ""
1968:             ENDIF
1969:             ENDIF
1970:         ENDIF
1971: 
1972:         IF USED("cursor_4c_BuscaConta")
1973:             USE IN cursor_4c_BuscaConta
1974:         ENDIF
1975:         loc_oForm.Release()
1976:     ENDPROC
1977: 
1978:     *==========================================================================
1979:     * LOOKUP JOBS / DJOBS
1980:     *==========================================================================
1981: 
1982:     PROCEDURE TxtJobsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1983:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR ;
1984:            par_nKeyCode = 115 OR par_nKeyCode = 116
1985:             LOCAL loc_cValor, loc_nRes
1986:             loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c__Jobs.Value)
1987:             IF EMPTY(loc_cValor)
1988:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DJobs.Value = ""
1989:             ELSE
1990:                 loc_nRes = SQLEXEC(gnConnHandle, ;
1991:                     "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + ;
1992:                     EscaparSQL(PADR(loc_cValor, 10)), ;
1993:                     "cursor_4c_ValidaJobs")
1994:                 IF loc_nRes > 0 AND !EOF("cursor_4c_ValidaJobs")
1995:                     THIS.pgf_4c_Paginas.Page1.txt_4c__Jobs.Value = ALLTRIM(cursor_4c_ValidaJobs.IClis)
1996:                     THIS.pgf_4c_Paginas.Page1.txt_4c_DJobs.Value = ALLTRIM(cursor_4c_ValidaJobs.RClis)
1997:                 ELSE
1998:                     THIS.AbrirBuscaJobs()
1999:                 ENDIF
2000:                 IF USED("cursor_4c_ValidaJobs")
2001:                     USE IN cursor_4c_ValidaJobs
2002:                 ENDIF
2003:             ENDIF
2004:         ENDIF
2005:     ENDPROC
2006: 
2007:     FUNCTION DJobsWhen()
2008:         RETURN EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c__Jobs.Value)
2009:     ENDFUNC
2010: 
2011:     PROCEDURE TxtDJobsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2012:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR ;
2013:            par_nKeyCode = 115 OR par_nKeyCode = 116
2014:             LOCAL loc_cValor
2015:             loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DJobs.Value)
2016:             IF EMPTY(loc_cValor)
2017:                 THIS.pgf_4c_Paginas.Page1.txt_4c__Jobs.Value = ""
2018:             ELSE
2019:                 THIS.AbrirBuscaJobs()
2020:             ENDIF
2021:         ENDIF
2022:     ENDPROC
2023: 
2024:     PROCEDURE AbrirBuscaJobs()
2025:         LOCAL loc_oForm, loc_cValor
2026:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c__Jobs.Value)
2027: 
2028:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2029:             "SigCdCli", "cursor_4c_BuscaJobs", "IClis", loc_cValor, ;
2030:             "Busca de Job")
2031:         IF VARTYPE(loc_oForm) != "O"
2032:             RETURN
2033:         ENDIF
2034: 
2035:         IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
2036:             THIS.pgf_4c_Paginas.Page1.txt_4c__Jobs.Value = ALLTRIM(cursor_4c_BuscaJobs.IClis)
2037:             THIS.pgf_4c_Paginas.Page1.txt_4c_DJobs.Value = ALLTRIM(cursor_4c_BuscaJobs.RClis)
2038:         ELSE
2039:             IF !loc_oForm.this_lAchouRegistro
2040:             loc_oForm.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
2041:             loc_oForm.mAddColuna("RClis", "", "Nome")
2042:             loc_oForm.Show()
2043:             IF loc_oForm.this_lSelecionou
2044:                 THIS.pgf_4c_Paginas.Page1.txt_4c__Jobs.Value = ALLTRIM(cursor_4c_BuscaJobs.IClis)
2045:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DJobs.Value = ALLTRIM(cursor_4c_BuscaJobs.RClis)
2046:             ELSE
2047:                 THIS.pgf_4c_Paginas.Page1.txt_4c__Jobs.Value = ""
2048:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DJobs.Value = ""
2049:             ENDIF
2050:             ENDIF
2051:         ENDIF
2052: 
2053:         IF USED("cursor_4c_BuscaJobs")
2054:             USE IN cursor_4c_BuscaJobs
2055:         ENDIF
2056:         loc_oForm.Release()
2057:     ENDPROC
2058: 
2059:     *--------------------------------------------------------------------------
2060:     * ConfigurarPaginaLista - Configura conteudo de Page1 (grids de selecao)
2061:     * Em forms REPORT, Page1 hospeda os filtros e os 3 grids de selecao
2062:     * (Empresas, Operacoes, Classificacoes). Esta procedure encapsula a
2063:     * configuracao desses grids, delegando para ConfigurarGrids().
2064:     *--------------------------------------------------------------------------
2065:     PROTECTED PROCEDURE ConfigurarPaginaLista()
2066:         LOCAL loc_oPg1
2067:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
2068:         THIS.ConfigurarGrids()
2069:         loc_oPg1.grd_4c_Emps.Visible    = .T.
2070:         loc_oPg1.grd_4c_Tipo.Visible    = .T.
2071:         loc_oPg1.grd_4c_Cla.Visible     = .T.
2072:     ENDPROC
2073: 
2074:     *--------------------------------------------------------------------------
2075:     * ConfigurarPaginaDados - Configura conteudo de pagina de dados
2076:     * Em forms REPORT (frmrelatorio) NAO existe Page2 (Dados): todos os
2077:     * filtros estao em Page1 e ja foram configurados por ConfigurarFiltros().
2078:     * Este metodo existe para manter compatibilidade com a API de forms CRUD
2079:     * e satisfaz validacoes do pipeline de migracao multi-fase.
2080:     *--------------------------------------------------------------------------
2081:     PROTECTED PROCEDURE ConfigurarPaginaDados()
2082:         *-- Form REPORT usa layout FLAT com apenas Page1 contendo todos os filtros.
2083:         *-- Os campos de filtro sao adicionados em ConfigurarFiltros() que ja foi
2084:         *-- chamado durante InicializarForm(). Portanto nao ha controles adicionais
2085:         *-- a configurar nesta pagina.
2086:         IF THIS.pgf_4c_Paginas.PageCount >= 1
2087:             THIS.pgf_4c_Paginas.Page1.Refresh()
2088:         ENDIF
2089:     ENDPROC
2090: 
2091:     *--------------------------------------------------------------------------
2092:     * AlternarPagina - Define a pagina ativa do PageFrame
2093:     * Em forms REPORT este form usa uma unica pagina (Page1) que contem
2094:     * todos os filtros e grids. Mantido por compatibilidade com a API de
2095:     * forms de cadastro.
2096:     *--------------------------------------------------------------------------
2097:     PROCEDURE AlternarPagina(par_nPagina)
2098:         LOCAL loc_nPagina
2099:         loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
2100:         IF loc_nPagina < 1 OR loc_nPagina > THIS.pgf_4c_Paginas.PageCount
2101:             loc_nPagina = 1
2102:         ENDIF
2103:         THIS.pgf_4c_Paginas.ActivePage = loc_nPagina
2104:         THIS.pgf_4c_Paginas.Refresh()
2105:     ENDPROC
2106: 
2107:     *--------------------------------------------------------------------------
2108:     * BtnBuscarClick - Para forms REPORT: equivale a Visualizar (preview)
2109:     *--------------------------------------------------------------------------
2110:     PROCEDURE BtnBuscarClick()
2111:         LOCAL loc_oPg1
2112:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
2113:         IF EMPTY(loc_oPg1.txt_4c_DtInicial.Value) OR ;
2114:            EMPTY(loc_oPg1.txt_4c_DtFinal.Value)
2115:             MsgAviso("Informe o per" + CHR(237) + "odo inicial e final.")
2116:             RETURN
2117:         ENDIF
2118:         THIS.FormParaRelatorio()
2119:         THIS.this_oRelatorio.Visualizar()
2120:     ENDPROC
2121: 
2122:     *--------------------------------------------------------------------------
2123:     * BtnEncerrarClick - Fecha o formulario
2124:     *--------------------------------------------------------------------------
2125:     PROCEDURE BtnEncerrarClick()
2126:         THIS.Release()
2127:     ENDPROC
2128: 
2129:     *--------------------------------------------------------------------------
2130:     * BtnSalvarClick - Para forms REPORT: equivale a Imprimir
2131:     *--------------------------------------------------------------------------
2132:     PROCEDURE BtnSalvarClick()
2133:         LOCAL loc_oPg1
2134:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
2135:         IF EMPTY(loc_oPg1.txt_4c_DtInicial.Value) OR ;
2136:            EMPTY(loc_oPg1.txt_4c_DtFinal.Value)
2137:             MsgAviso("Informe o per" + CHR(237) + "odo inicial e final.")
2138:             RETURN
2139:         ENDIF
2140:         THIS.FormParaRelatorio()
2141:         THIS.this_oRelatorio.Imprimir()
2142:     ENDPROC
2143: 
2144:     *--------------------------------------------------------------------------
2145:     * FormParaBO - Para forms REPORT: delega para FormParaRelatorio
2146:     *--------------------------------------------------------------------------
2147:     PROCEDURE FormParaBO()
2148:         THIS.FormParaRelatorio()
2149:     ENDPROC
2150: 
2151:     *--------------------------------------------------------------------------
2152:     * BOParaForm - Para forms REPORT: grids ja carregados em CarregarCursores
2153:     * Filtros de tela nao precisam ser recarregados a partir do BO.
2154:     *--------------------------------------------------------------------------
2155:     PROCEDURE BOParaForm()
2156:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
2157:             THIS.pgf_4c_Paginas.Refresh()
2158:         ENDIF
2159:     ENDPROC
2160: 
2161:     *--------------------------------------------------------------------------
2162:     * HabilitarCampos - Habilita todos os filtros; aplica regra PagRec via HabObjs
2163:     *--------------------------------------------------------------------------
2164:     PROCEDURE HabilitarCampos()
2165:         LOCAL loc_oPg1, loc_lPagRec
2166:         loc_oPg1    = THIS.pgf_4c_Paginas.Page1
2167:         loc_lPagRec = (loc_oPg1.chk_4c_Ck_Pagamentos.Value = 1) OR ;
2168:                       (loc_oPg1.chk_4c_Ck_Recebimentos.Value = 1)
2169:         loc_oPg1.txt_4c_DtInicial.Enabled         = .T.
2170:         loc_oPg1.txt_4c_DtFinal.Enabled           = .T.
2171:         loc_oPg1.txt_4c_Saldo.Enabled             = .T.
2172:         loc_oPg1.txt_4c_Grupo.Enabled             = .T.
2173:         loc_oPg1.txt_4c_DGrupo.Enabled            = .T.
2174:         loc_oPg1.txt_4c_Conta.Enabled             = .T.
2175:         loc_oPg1.txt_4c_DConta.Enabled            = .T.
2176:         loc_oPg1.txt_4c__cd_moeda.Enabled         = .T.
2177:         loc_oPg1.txt_4c__ds_moeda.Enabled         = .T.
2178:         loc_oPg1.txt_4c__Jobs.Enabled             = .T.
2179:         loc_oPg1.txt_4c_DJobs.Enabled             = .T.
2180:         loc_oPg1.obj_4c_OptDatas.Enabled          = .T.
2181:         loc_oPg1.obj_4c_OptSaldos.Enabled         = .T.
2182:         loc_oPg1.obj_4c_OptAutorizados.Enabled    = .T.
2183:         loc_oPg1.chk_4c_Ck_Pagamentos.Enabled    = .T.
2184:         loc_oPg1.chk_4c_Ck_Recebimentos.Enabled  = .T.
2185:         THIS.HabObjs(loc_lPagRec)
2186:     ENDPROC
2187: 
2188:     *--------------------------------------------------------------------------
2189:     * CarregarLista - Para forms REPORT: cursores ja carregados em CarregarCursores
2190:     * Retorna .T. para compatibilidade com o ciclo de vida do FormBase
2191:     *--------------------------------------------------------------------------
2192:     FUNCTION CarregarLista()
2193:         RETURN .T.
2194:     ENDFUNC
2195: 
2196:     *--------------------------------------------------------------------------
2197:     * AjustarBotoesPorModo - Para forms REPORT: botoes sempre habilitados
2198:     *--------------------------------------------------------------------------
2199:     PROCEDURE AjustarBotoesPorModo()
2200:         IF VARTYPE(THIS.cnt_4c_Cabecalho) = "O"
2201:             WITH THIS.cnt_4c_Cabecalho.cmg_4c_Botoes
2202:                 .Buttons(1).Enabled = .T.
2203:                 .Buttons(2).Enabled = .T.
2204:                 .Buttons(3).Enabled = .T.
2205:                 .Buttons(4).Enabled = .T.
2206:             ENDWITH
2207:         ENDIF
2208:     ENDPROC
2209: 
2210:     *--------------------------------------------------------------------------
2211:     * Destroy - Libera referencia ao BO e cursores da sessao privada
2212:     *--------------------------------------------------------------------------
2213:     PROCEDURE Destroy()
2214:         IF VARTYPE(THIS.this_oRelatorio) = "O"
2215:             THIS.this_oRelatorio = .NULL.
2216:         ENDIF
2217:         DODEFAULT()
2218:     ENDPROC
2219: 
2220: ENDDEFINE

