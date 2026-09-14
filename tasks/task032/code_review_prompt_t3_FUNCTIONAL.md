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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreapp.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2219 linhas total):

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

*-- Linhas 1087 a 1215:
1087:     * ConfigurarGrids - Cria os tres grids apos cursores ja carregados
1088:     * grd_4c_Emps (Empresas), grd_4c_Tipo (Operacoes), grd_4c_Cla (Classificacoes)
1089:     *--------------------------------------------------------------------------
1090:     PROTECTED PROCEDURE ConfigurarGrids()
1091:         LOCAL loc_oPg1, loc_oGrd
1092:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1093: 
1094:         *======================================================================
1095:         *-- GRID EMPRESAS
1096:         *======================================================================
1097:         loc_oPg1.AddObject("lbl_4c_Label1", "Label")
1098:         WITH loc_oPg1.lbl_4c_Label1
1099:             .Top       = 181
1100:             .Left      = 24
1101:             .Width     = 60
1102:             .Height    = 15
1103:             .Caption   = "Empresas"
1104:             .FontName  = "Tahoma"
1105:             .FontSize  = 8
1106:             .FontBold  = .T.
1107:             .ForeColor = RGB(90, 90, 90)
1108:             .BackStyle = 0
1109:             .AutoSize  = .T.
1110:             .Visible   = .T.
1111:         ENDWITH
1112: 
1113:         loc_oPg1.AddObject("chk_4c_Ck_MarcaEmp", "CheckBox")
1114:         WITH loc_oPg1.chk_4c_Ck_MarcaEmp
1115:             .Top       = 198
1116:             .Left      = 25
1117:             .Width     = 13
1118:             .Height    = 16
1119:             .Caption   = ""
1120:             .Value     = 1
1121:             .Alignment = 0
1122:             .Centered  = .F.
1123:             .Visible   = .T.
1124:         ENDWITH
1125:         BINDEVENT(loc_oPg1.chk_4c_Ck_MarcaEmp, "Click", THIS, "MarcaEmpClick")
1126: 
1127:         loc_oPg1.AddObject("grd_4c_Emps", "Grid")
1128:         loc_oGrd = loc_oPg1.grd_4c_Emps
1129:         WITH loc_oGrd
1130:             .Top               = 197
1131:             .Left              = 24
1132:             .Width             = 331
1133:             .Height            = 394
1134:             .ColumnCount       = 3
1135:             .FontName          = "Tahoma"
1136:             .FontSize          = 8
1137:             .AllowHeaderSizing = .F.
1138:             .AllowRowSizing    = .F.
1139:             .DeleteMark        = .F.
1140:             .RecordMark        = .F.
1141:             .RowHeight         = 17
1142:             .ScrollBars        = 2
1143:             .GridLineColor     = RGB(238, 238, 238)
1144:             .ReadOnly          = .F.
1145:             .RecordSource      = "cursor_4c_SigCdEmp"
1146:             .Visible           = .T.
1147:         ENDWITH
1148:         loc_oGrd.Column1.ControlSource = "cursor_4c_SigCdEmp.Imps"
1149:         loc_oGrd.Column2.ControlSource = "cursor_4c_SigCdEmp.cEmps"
1150:         loc_oGrd.Column3.ControlSource = "cursor_4c_SigCdEmp.Razas"
1151: 
1152:         WITH loc_oGrd.Column1
1153:             .Width         = 17
1154:             .ControlSource = "cursor_4c_SigCdEmp.Imps"
1155:             .FontName      = "Courier New"
1156:             .Movable       = .F.
1157:             .Resizable     = .F.
1158:             .ReadOnly      = .F.
1159:             .Sparse        = .F.
1160:         ENDWITH
1161:         loc_oGrd.Column1.Header1.Caption  = ""
1162:         loc_oGrd.Column1.Header1.ForeColor = RGB(90, 90, 90)
1163:         loc_oGrd.Column1.AddObject("Check1", "CheckBox")
1164:         WITH loc_oGrd.Column1.Check1
1165:             .Alignment = 0
1166:             .Caption   = ""
1167:             .AutoSize  = .T.
1168:             .BackStyle = 0
1169:             .Visible   = .T.
1170:         ENDWITH
1171:         loc_oGrd.Column1.CurrentControl = "Check1"
1172:         BINDEVENT(loc_oGrd.Column1.Check1, "MouseDown", THIS, "EmpCheckMouseDown")
1173:         BINDEVENT(loc_oGrd.Column1.Check1, "MouseUp",   THIS, "EmpCheckMouseUp")
1174:         BINDEVENT(loc_oGrd.Column1.Check1, "Click",     THIS, "EmpCheckClick")
1175:         BINDEVENT(loc_oGrd.Column1.Check1, "KeyPress",  THIS, "EmpCheckKeyPress")
1176: 
1177:         WITH loc_oGrd.Column2
1178:             .Width         = 27
1179:             .ControlSource = "cursor_4c_SigCdEmp.cEmps"
1180:             .FontName      = "Courier New"
1181:             .Movable       = .F.
1182:             .Resizable     = .F.
1183:             .ReadOnly      = .T.
1184:         ENDWITH
1185:         loc_oGrd.Column2.Header1.Caption   = "Emp."
1186:         loc_oGrd.Column2.Header1.Alignment = 2
1187:         loc_oGrd.Column2.Header1.ForeColor = RGB(90, 90, 90)
1188:         loc_oGrd.Column2.Text1.ForeColor   = RGB(0, 0, 0)
1189: 
1190:         WITH loc_oGrd.Column3
1191:             .Width         = 263
1192:             .ControlSource = "cursor_4c_SigCdEmp.Razas"
1193:             .FontName      = "Courier New"
1194:             .Movable       = .F.
1195:             .Resizable     = .F.
1196:             .ReadOnly      = .T.
1197:         ENDWITH
1198:         loc_oGrd.Column3.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1199:         loc_oGrd.Column3.Header1.Alignment = 2
1200:         loc_oGrd.Column3.Header1.ForeColor = RGB(90, 90, 90)
1201:         loc_oGrd.Column3.Text1.ForeColor   = RGB(0, 0, 0)
1202: 
1203:         *======================================================================
1204:         *-- GRID OPERACOES DE TITULO
1205:         *======================================================================
1206:         loc_oPg1.AddObject("lbl_4c_Label4", "Label")
1207:         WITH loc_oPg1.lbl_4c_Label4
1208:             .Top       = 181
1209:             .Left      = 369
1210:             .Width     = 120
1211:             .Height    = 15
1212:             .Caption   = "Opera" + CHR(231) + CHR(245) + "es de T" + CHR(237) + "tulo"
1213:             .FontName  = "Tahoma"
1214:             .FontSize  = 8
1215:             .FontBold  = .T.

*-- Linhas 1231 a 1274:
1231:             .Centered  = .F.
1232:             .Visible   = .T.
1233:         ENDWITH
1234:         BINDEVENT(loc_oPg1.chk_4c_Ck_MarcaOpe, "Click", THIS, "MarcaOpeClick")
1235: 
1236:         loc_oPg1.AddObject("grd_4c_Tipo", "Grid")
1237:         loc_oGrd = loc_oPg1.grd_4c_Tipo
1238:         WITH loc_oGrd
1239:             .Top               = 197
1240:             .Left              = 369
1241:             .Width             = 323
1242:             .Height            = 394
1243:             .ColumnCount       = 2
1244:             .FontName          = "Tahoma"
1245:             .FontSize          = 8
1246:             .AllowHeaderSizing = .F.
1247:             .AllowRowSizing    = .F.
1248:             .DeleteMark        = .F.
1249:             .RecordMark        = .F.
1250:             .HeaderHeight      = 17
1251:             .RowHeight         = 17
1252:             .ScrollBars        = 2
1253:             .GridLineColor     = RGB(238, 238, 238)
1254:             .ReadOnly          = .F.
1255:             .RecordSource      = "cursor_4c_SigOpOpe"
1256:             .Visible           = .T.
1257:         ENDWITH
1258:         loc_oGrd.Column1.ControlSource = "cursor_4c_SigOpOpe.Imps"
1259:         loc_oGrd.Column2.ControlSource = "cursor_4c_SigOpOpe.Dopes"
1260: 
1261:         WITH loc_oGrd.Column1
1262:             .Width         = 17
1263:             .ControlSource = "cursor_4c_SigOpOpe.Imps"
1264:             .Alignment     = 0
1265:             .FontName      = "Courier New"
1266:             .Movable       = .F.
1267:             .Resizable     = .F.
1268:             .ReadOnly      = .F.
1269:             .Sparse        = .F.
1270:             .Enabled       = .T.
1271:         ENDWITH
1272:         loc_oGrd.Column1.Header1.Caption  = ""
1273:         loc_oGrd.Column1.Header1.ForeColor = RGB(90, 90, 90)
1274:         loc_oGrd.Column1.AddObject("check12", "CheckBox")

*-- Linhas 1281 a 1327:
1281:             .Visible   = .T.
1282:         ENDWITH
1283:         loc_oGrd.Column1.CurrentControl = "check12"
1284:         BINDEVENT(loc_oGrd.Column1.check12, "MouseDown", THIS, "TipoCheckMouseDown")
1285:         BINDEVENT(loc_oGrd.Column1.check12, "MouseUp",   THIS, "TipoCheckMouseUp")
1286:         BINDEVENT(loc_oGrd.Column1.check12, "Click",     THIS, "TipoCheckClick")
1287:         BINDEVENT(loc_oGrd.Column1.check12, "KeyPress",  THIS, "TipoCheckKeyPress")
1288: 
1289:         WITH loc_oGrd.Column2
1290:             .Width         = 283
1291:             .ControlSource = "cursor_4c_SigOpOpe.Dopes"
1292:             .FontName      = "Courier New"
1293:             .Movable       = .F.
1294:             .Resizable     = .F.
1295:             .ReadOnly      = .T.
1296:             .Enabled       = .T.
1297:         ENDWITH
1298:         loc_oGrd.Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1299:         loc_oGrd.Column2.Header1.Alignment = 2
1300:         loc_oGrd.Column2.Header1.ForeColor = RGB(90, 90, 90)
1301:         loc_oGrd.Column2.Text1.ForeColor   = RGB(0, 0, 0)
1302:         loc_oGrd.Column2.Text1.BackColor   = RGB(255, 255, 255)
1303:         loc_oGrd.Column2.Text1.ReadOnly    = .T.
1304: 
1305:         *======================================================================
1306:         *-- GRID CLASSIFICACOES
1307:         *======================================================================
1308:         loc_oPg1.AddObject("lbl_4c_Label8", "Label")
1309:         WITH loc_oPg1.lbl_4c_Label8
1310:             .Top       = 180
1311:             .Left      = 706
1312:             .Width     = 95
1313:             .Height    = 15
1314:             .Caption   = "Classifica" + CHR(231) + CHR(245) + "es"
1315:             .FontName  = "Tahoma"
1316:             .FontSize  = 8
1317:             .FontBold  = .T.
1318:             .ForeColor = RGB(90, 90, 90)
1319:             .BackStyle = 0
1320:             .AutoSize  = .T.
1321:             .Visible   = .T.
1322:         ENDWITH
1323: 
1324:         loc_oPg1.AddObject("chk_4c_Ck_MarcaCla", "CheckBox")
1325:         WITH loc_oPg1.chk_4c_Ck_MarcaCla
1326:             .Top       = 198
1327:             .Left      = 708

*-- Linhas 1333 a 2219:
1333:             .Centered  = .F.
1334:             .Visible   = .T.
1335:         ENDWITH
1336:         BINDEVENT(loc_oPg1.chk_4c_Ck_MarcaCla, "Click", THIS, "MarcaClaClick")
1337: 
1338:         loc_oPg1.AddObject("grd_4c_Cla", "Grid")
1339:         loc_oGrd = loc_oPg1.grd_4c_Cla
1340:         WITH loc_oGrd
1341:             .Top               = 197
1342:             .Left              = 706
1343:             .Width             = 574
1344:             .Height            = 394
1345:             .ColumnCount       = 3
1346:             .FontName          = "Tahoma"
1347:             .FontSize          = 8
1348:             .AllowHeaderSizing = .F.
1349:             .AllowRowSizing    = .F.
1350:             .DeleteMark        = .F.
1351:             .RecordMark        = .F.
1352:             .RowHeight         = 17
1353:             .ScrollBars        = 2
1354:             .GridLineColor     = RGB(238, 238, 238)
1355:             .ReadOnly          = .F.
1356:             .RecordSource      = "cursor_4c_SigCdClc"
1357:             .Visible           = .T.
1358:         ENDWITH
1359:         loc_oGrd.Column1.ControlSource = "cursor_4c_SigCdClc.Imps"
1360:         loc_oGrd.Column2.ControlSource = "cursor_4c_SigCdClc.Codigos"
1361:         loc_oGrd.Column3.ControlSource = "cursor_4c_SigCdClc.Descs"
1362: 
1363:         WITH loc_oGrd.Column1
1364:             .Width         = 19
1365:             .ControlSource = "cursor_4c_SigCdClc.Imps"
1366:             .FontName      = "Courier New"
1367:             .Movable       = .F.
1368:             .Resizable     = .F.
1369:             .ReadOnly      = .F.
1370:             .Sparse        = .F.
1371:         ENDWITH
1372:         loc_oGrd.Column1.Header1.Caption  = ""
1373:         loc_oGrd.Column1.Header1.ForeColor = RGB(90, 90, 90)
1374:         loc_oGrd.Column1.AddObject("check13", "CheckBox")
1375:         WITH loc_oGrd.Column1.check13
1376:             .Alignment = 0
1377:             .Caption   = ""
1378:             .AutoSize  = .T.
1379:             .BackStyle = 0
1380:             .Visible   = .T.
1381:         ENDWITH
1382:         loc_oGrd.Column1.CurrentControl = "check13"
1383:         BINDEVENT(loc_oGrd.Column1.check13, "MouseDown", THIS, "ClaCheckMouseDown")
1384:         BINDEVENT(loc_oGrd.Column1.check13, "MouseUp",   THIS, "ClaCheckMouseUp")
1385:         BINDEVENT(loc_oGrd.Column1.check13, "Click",     THIS, "ClaCheckClick")
1386:         BINDEVENT(loc_oGrd.Column1.check13, "KeyPress",  THIS, "ClaCheckKeyPress")
1387: 
1388:         WITH loc_oGrd.Column2
1389:             .Width         = 80
1390:             .ControlSource = "cursor_4c_SigCdClc.Codigos"
1391:             .FontName      = "Courier New"
1392:             .Movable       = .F.
1393:             .Resizable     = .F.
1394:             .ReadOnly      = .T.
1395:         ENDWITH
1396:         loc_oGrd.Column2.Header1.Caption   = "C" + CHR(243) + "digo"
1397:         loc_oGrd.Column2.Header1.Alignment = 2
1398:         loc_oGrd.Column2.Header1.ForeColor = RGB(90, 90, 90)
1399:         loc_oGrd.Column2.Text1.ForeColor   = RGB(0, 0, 0)
1400:         loc_oGrd.Column2.Text1.ReadOnly    = .F.
1401: 
1402:         WITH loc_oGrd.Column3
1403:             .Width         = 452
1404:             .ControlSource = "cursor_4c_SigCdClc.Descs"
1405:             .FontName      = "Courier New"
1406:             .Movable       = .F.
1407:             .Resizable     = .F.
1408:             .ReadOnly      = .T.
1409:         ENDWITH
1410:         loc_oGrd.Column3.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1411:         loc_oGrd.Column3.Header1.Alignment = 2
1412:         loc_oGrd.Column3.Header1.ForeColor = RGB(90, 90, 90)
1413:         loc_oGrd.Column3.Text1.ForeColor   = RGB(0, 0, 0)
1414:         loc_oGrd.Column3.Text1.BackColor   = RGB(255, 255, 255)
1415:         loc_oGrd.Column3.Text1.ReadOnly    = .T.
1416: 
1417:     ENDPROC
1418: 
1419:     *--------------------------------------------------------------------------
1420:     * AtualizarEstadoControles - Report form: sem estado CRUD, ajusta botoes
1421:     *--------------------------------------------------------------------------
1422:     PROCEDURE AtualizarEstadoControles()
1423:         THIS.AjustarBotoesPorModo()
1424:     ENDPROC
1425: 
1426:     *--------------------------------------------------------------------------
1427:     * LimparCampos - Reseta todos os filtros para valores padrao
1428:     *--------------------------------------------------------------------------
1429:     PROCEDURE LimparCampos()
1430:         LOCAL loc_oPg1
1431:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1432:         loc_oPg1.txt_4c_DtInicial.Value          = DATE()
1433:         loc_oPg1.txt_4c_DtFinal.Value            = DATE()
1434:         loc_oPg1.txt_4c__Numes.Value             = 0
1435:         loc_oPg1.txt_4c_Saldo.Value              = 0
1436:         loc_oPg1.txt_4c__Juros.Value             = 0
1437:         loc_oPg1.txt_4c_Grupo.Value              = ""
1438:         loc_oPg1.txt_4c_DGrupo.Value             = ""
1439:         loc_oPg1.txt_4c_Conta.Value              = ""
1440:         loc_oPg1.txt_4c_DConta.Value             = ""
1441:         loc_oPg1.txt_4c__Jobs.Value              = ""
1442:         loc_oPg1.txt_4c_DJobs.Value              = ""
1443:         loc_oPg1.obj_4c_Opt_AnaSi.Value          = 1
1444:         loc_oPg1.obj_4c_OptDatas.Value           = 1
1445:         loc_oPg1.obj_4c_OptSaldos.Value          = 1
1446:         loc_oPg1.obj_4c_OptAutorizados.Value     = 1
1447:         loc_oPg1.obj_4c_Opt_Juros.Value          = 2
1448:         loc_oPg1.chk_4c_Ck_Pagamentos.Value     = 0
1449:         loc_oPg1.chk_4c_Ck_Recebimentos.Value   = 0
1450:         THIS.HabObjs(.F.)
1451:     ENDPROC
1452: 
1453:     *--------------------------------------------------------------------------
1454:     * HabObjs - Habilita/desabilita controles conforme modo PagRec
1455:     * par_lPagRec: .T. = modo pagamento/recebimento, .F. = modo normal
1456:     *--------------------------------------------------------------------------
1457:     PROCEDURE HabObjs(par_lPagRec)
1458:         LOCAL loc_oPg1, loc_cLabel
1459:         loc_oPg1   = THIS.pgf_4c_Paginas.Page1
1460:         loc_cLabel = IIF(loc_oPg1.chk_4c_Ck_Pagamentos.Value = 1, ;
1461:             "Pagamento:", "Recebimento:")
1462:         loc_oPg1.txt_4c__Numes.Enabled     = par_lPagRec
1463:         loc_oPg1.obj_4c_Opt_AnaSi.Enabled  = !par_lPagRec
1464:         loc_oPg1.lbl_4c_LblPeriodo.Caption = IIF(par_lPagRec, loc_cLabel, "Vencimento :")
1465:         loc_oPg1.obj_4c_Opt_Juros.Enabled  = !par_lPagRec
1466:         loc_oPg1.txt_4c__Juros.Enabled     = !par_lPagRec
1467:     ENDPROC
1468: 
1469:     *--------------------------------------------------------------------------
1470:     * FormParaRelatorio - Transfere valores do formulario para o BO
1471:     *--------------------------------------------------------------------------
1472:     PROCEDURE FormParaRelatorio()
1473:         LOCAL loc_oPg1, loc_oBO
1474:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1475:         loc_oBO  = THIS.this_oRelatorio
1476: 
1477:         loc_oBO.this_dDtInicial      = loc_oPg1.txt_4c_DtInicial.Value
1478:         loc_oBO.this_dDtFinal        = loc_oPg1.txt_4c_DtFinal.Value
1479:         loc_oBO.this_nOptAnaSi       = loc_oPg1.obj_4c_Opt_AnaSi.Value
1480:         loc_oBO.this_nOptDatas       = loc_oPg1.obj_4c_OptDatas.Value
1481:         loc_oBO.this_nOptSaldos      = loc_oPg1.obj_4c_OptSaldos.Value
1482:         loc_oBO.this_nOptAutorizados = loc_oPg1.obj_4c_OptAutorizados.Value
1483:         loc_oBO.this_nOptJuros       = loc_oPg1.obj_4c_Opt_Juros.Value
1484:         loc_oBO.this_nJuros          = loc_oPg1.txt_4c__Juros.Value
1485:         loc_oBO.this_nSaldo          = loc_oPg1.txt_4c_Saldo.Value
1486:         loc_oBO.this_cGrupo          = PADR(ALLTRIM(loc_oPg1.txt_4c_Grupo.Value), 10)
1487:         loc_oBO.this_cDGrupo         = ALLTRIM(loc_oPg1.txt_4c_DGrupo.Value)
1488:         loc_oBO.this_cConta          = PADR(ALLTRIM(loc_oPg1.txt_4c_Conta.Value), 10)
1489:         loc_oBO.this_cDConta         = ALLTRIM(loc_oPg1.txt_4c_DConta.Value)
1490:         loc_oBO.this_cCdMoeda        = ALLTRIM(loc_oPg1.txt_4c__cd_moeda.Value)
1491:         loc_oBO.this_cDsMoeda        = ALLTRIM(loc_oPg1.txt_4c__ds_moeda.Value)
1492:         loc_oBO.this_cJobs           = PADR(ALLTRIM(loc_oPg1.txt_4c__Jobs.Value), 10)
1493:         loc_oBO.this_cDJobs          = ALLTRIM(loc_oPg1.txt_4c_DJobs.Value)
1494:         loc_oBO.this_nNumes          = loc_oPg1.txt_4c__Numes.Value
1495:         loc_oBO.this_nPagamentos     = loc_oPg1.chk_4c_Ck_Pagamentos.Value
1496:         loc_oBO.this_nRecebimentos   = loc_oPg1.chk_4c_Ck_Recebimentos.Value
1497:     ENDPROC
1498: 
1499:     *==========================================================================
1500:     * HANDLERS DE BOTOES
1501:     *==========================================================================
1502: 
1503:     PROCEDURE BtnVisualizarClick()
1504:         LOCAL loc_oPg1
1505:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1506:         IF EMPTY(loc_oPg1.txt_4c_DtInicial.Value) OR ;
1507:            EMPTY(loc_oPg1.txt_4c_DtFinal.Value)
1508:             MsgAviso("Informe o per" + CHR(237) + "odo inicial e final.")
1509:             RETURN
1510:         ENDIF
1511:         THIS.FormParaRelatorio()
1512:         THIS.this_oRelatorio.Visualizar()
1513:     ENDPROC
1514: 
1515:     PROCEDURE BtnImprimirClick()
1516:         LOCAL loc_oPg1
1517:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1518:         IF EMPTY(loc_oPg1.txt_4c_DtInicial.Value) OR ;
1519:            EMPTY(loc_oPg1.txt_4c_DtFinal.Value)
1520:             MsgAviso("Informe o per" + CHR(237) + "odo inicial e final.")
1521:             RETURN
1522:         ENDIF
1523:         THIS.FormParaRelatorio()
1524:         THIS.this_oRelatorio.Imprimir()
1525:     ENDPROC
1526: 
1527:     PROCEDURE BtnGerarExcelClick()
1528:         LOCAL loc_oPg1
1529:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1530:         IF EMPTY(loc_oPg1.txt_4c_DtInicial.Value) OR ;
1531:            EMPTY(loc_oPg1.txt_4c_DtFinal.Value)
1532:             MsgAviso("Informe o per" + CHR(237) + "odo inicial e final.")
1533:             RETURN
1534:         ENDIF
1535:         THIS.FormParaRelatorio()
1536:         THIS.this_oRelatorio.ExportarExcel()
1537:     ENDPROC
1538: 
1539:     PROCEDURE BtnCancelarClick()
1540:         THIS.Release()
1541:     ENDPROC
1542: 
1543:     *==========================================================================
1544:     * HANDLERS CRUD (form REPORT - delegam para acoes equivalentes do relatorio)
1545:     *==========================================================================
1546: 
1547:     PROCEDURE BtnIncluirClick()
1548:         LOCAL loc_oPg1
1549:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1550:         IF EMPTY(loc_oPg1.txt_4c_DtInicial.Value) OR ;
1551:            EMPTY(loc_oPg1.txt_4c_DtFinal.Value)
1552:             MsgAviso("Informe o per" + CHR(237) + "odo inicial e final.")
1553:             RETURN
1554:         ENDIF
1555:         THIS.FormParaRelatorio()
1556:         THIS.this_oRelatorio.Visualizar()
1557:     ENDPROC
1558: 
1559:     PROCEDURE BtnAlterarClick()
1560:         LOCAL loc_oPg1
1561:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1562:         IF EMPTY(loc_oPg1.txt_4c_DtInicial.Value) OR ;
1563:            EMPTY(loc_oPg1.txt_4c_DtFinal.Value)
1564:             MsgAviso("Informe o per" + CHR(237) + "odo inicial e final.")
1565:             RETURN
1566:         ENDIF
1567:         THIS.FormParaRelatorio()
1568:         THIS.this_oRelatorio.Imprimir()
1569:     ENDPROC
1570: 
1571:     PROCEDURE BtnExcluirClick()
1572:         THIS.LimparCampos()
1573:         THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial.SetFocus()
1574:     ENDPROC
1575: 
1576:     *==========================================================================
1577:     * HANDLERS MARCAR/DESMARCAR TODOS (checkboxes acima de cada grid)
1578:     *==========================================================================
1579: 
1580:     PROCEDURE MarcaEmpClick()
1581:         LOCAL loc_nImps
1582:         loc_nImps = IIF(THIS.pgf_4c_Paginas.Page1.chk_4c_Ck_MarcaEmp.Value = 1, 1, 0)
1583:         REPLACE ALL Imps WITH loc_nImps IN cursor_4c_SigCdEmp
1584:         THIS.pgf_4c_Paginas.Page1.grd_4c_Emps.Refresh()
1585:     ENDPROC
1586: 
1587:     PROCEDURE MarcaOpeClick()
1588:         LOCAL loc_nImps
1589:         loc_nImps = IIF(THIS.pgf_4c_Paginas.Page1.chk_4c_Ck_MarcaOpe.Value = 1, 1, 0)
1590:         REPLACE ALL Imps WITH loc_nImps IN cursor_4c_SigOpOpe
1591:         THIS.pgf_4c_Paginas.Page1.grd_4c_Tipo.Refresh()
1592:     ENDPROC
1593: 
1594:     PROCEDURE MarcaClaClick()
1595:         LOCAL loc_nImps
1596:         loc_nImps = IIF(THIS.pgf_4c_Paginas.Page1.chk_4c_Ck_MarcaCla.Value = 1, 1, 0)
1597:         REPLACE ALL Imps WITH loc_nImps IN cursor_4c_SigCdClc
1598:         THIS.pgf_4c_Paginas.Page1.grd_4c_Cla.Refresh()
1599:     ENDPROC
1600: 
1601:     *==========================================================================
1602:     * HANDLERS CHECKBOX DO GRID EMPRESAS
1603:     *==========================================================================
1604: 
1605:     PROCEDURE EmpCheckMouseDown(par_nButton, par_nShift, par_nX, par_nY)
1606:         LOCAL loc_nImps
1607:         loc_nImps = IIF(cursor_4c_SigCdEmp.Imps = 0, 1, 0)
1608:         REPLACE Imps WITH loc_nImps IN cursor_4c_SigCdEmp
1609:         THIS.pgf_4c_Paginas.Page1.grd_4c_Emps.Refresh()
1610:         NODEFAULT
1611:     ENDPROC
1612: 
1613:     PROCEDURE EmpCheckMouseUp(par_nButton, par_nShift, par_nX, par_nY)
1614:         NODEFAULT
1615:     ENDPROC
1616: 
1617:     PROCEDURE EmpCheckClick()
1618:         NODEFAULT
1619:     ENDPROC
1620: 
1621:     PROCEDURE EmpCheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1622:         IF INLIST(par_nKeyCode, 13, 32)
1623:             LOCAL loc_nImps
1624:             loc_nImps = IIF(cursor_4c_SigCdEmp.Imps = 1, 0, 1)
1625:             REPLACE Imps WITH loc_nImps IN cursor_4c_SigCdEmp
1626:             THIS.pgf_4c_Paginas.Page1.grd_4c_Emps.Refresh()
1627:             NODEFAULT
1628:         ENDIF
1629:     ENDPROC
1630: 
1631:     *==========================================================================
1632:     * HANDLERS CHECKBOX DO GRID TIPO (OPERACOES)
1633:     *==========================================================================
1634: 
1635:     PROCEDURE TipoCheckMouseDown(par_nButton, par_nShift, par_nX, par_nY)
1636:         LOCAL loc_nImps
1637:         loc_nImps = IIF(cursor_4c_SigOpOpe.Imps = 0, 1, 0)
1638:         REPLACE Imps WITH loc_nImps IN cursor_4c_SigOpOpe
1639:         THIS.pgf_4c_Paginas.Page1.grd_4c_Tipo.Refresh()
1640:         NODEFAULT
1641:     ENDPROC
1642: 
1643:     PROCEDURE TipoCheckMouseUp(par_nButton, par_nShift, par_nX, par_nY)
1644:         NODEFAULT
1645:     ENDPROC
1646: 
1647:     PROCEDURE TipoCheckClick()
1648:         NODEFAULT
1649:     ENDPROC
1650: 
1651:     PROCEDURE TipoCheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1652:         IF INLIST(par_nKeyCode, 13, 32)
1653:             LOCAL loc_nImps
1654:             loc_nImps = IIF(cursor_4c_SigOpOpe.Imps = 1, 0, 1)
1655:             REPLACE Imps WITH loc_nImps IN cursor_4c_SigOpOpe
1656:             THIS.pgf_4c_Paginas.Page1.grd_4c_Tipo.Refresh()
1657:             NODEFAULT
1658:         ENDIF
1659:     ENDPROC
1660: 
1661:     *==========================================================================
1662:     * HANDLERS CHECKBOX DO GRID CLASSIFICACOES
1663:     *==========================================================================
1664: 
1665:     PROCEDURE ClaCheckMouseDown(par_nButton, par_nShift, par_nX, par_nY)
1666:         LOCAL loc_nImps
1667:         loc_nImps = IIF(cursor_4c_SigCdClc.Imps = 0, 1, 0)
1668:         REPLACE Imps WITH loc_nImps IN cursor_4c_SigCdClc
1669:         THIS.pgf_4c_Paginas.Page1.grd_4c_Cla.Refresh()
1670:         NODEFAULT
1671:     ENDPROC
1672: 
1673:     PROCEDURE ClaCheckMouseUp(par_nButton, par_nShift, par_nX, par_nY)
1674:         NODEFAULT
1675:     ENDPROC
1676: 
1677:     PROCEDURE ClaCheckClick()
1678:         NODEFAULT
1679:     ENDPROC
1680: 
1681:     PROCEDURE ClaCheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1682:         IF INLIST(par_nKeyCode, 13, 32)
1683:             LOCAL loc_nImps
1684:             loc_nImps = IIF(cursor_4c_SigCdClc.Imps = 1, 0, 1)
1685:             REPLACE Imps WITH loc_nImps IN cursor_4c_SigCdClc
1686:             THIS.pgf_4c_Paginas.Page1.grd_4c_Cla.Refresh()
1687:             NODEFAULT
1688:         ENDIF
1689:     ENDPROC
1690: 
1691:     *==========================================================================
1692:     * HANDLERS MODO PAGREC E JUROS
1693:     *==========================================================================
1694: 
1695:     PROCEDURE PagamentosChange()
1696:         LOCAL loc_oPg1
1697:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1698:         IF loc_oPg1.chk_4c_Ck_Pagamentos.Value = 1
1699:             loc_oPg1.chk_4c_Ck_Recebimentos.Value = 0
1700:         ENDIF
1701:         THIS.HabObjs((loc_oPg1.chk_4c_Ck_Pagamentos.Value = 1) OR ;
1702:             (loc_oPg1.chk_4c_Ck_Recebimentos.Value = 1))
1703:     ENDPROC
1704: 
1705:     PROCEDURE RecebimentosChange()
1706:         LOCAL loc_oPg1
1707:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1708:         IF loc_oPg1.chk_4c_Ck_Recebimentos.Value = 1
1709:             loc_oPg1.chk_4c_Ck_Pagamentos.Value = 0
1710:         ENDIF
1711:         THIS.HabObjs((loc_oPg1.chk_4c_Ck_Pagamentos.Value = 1) OR ;
1712:             (loc_oPg1.chk_4c_Ck_Recebimentos.Value = 1))
1713:     ENDPROC
1714: 
1715:     PROCEDURE JurosOptClick()
1716:         IF THIS.pgf_4c_Paginas.Page1.obj_4c_Opt_Juros.Value = 2
1717:             THIS.pgf_4c_Paginas.Page1.txt_4c__Juros.Value = 0
1718:         ENDIF
1719:     ENDPROC
1720: 
1721:     FUNCTION JurosWhen()
1722:         RETURN (THIS.pgf_4c_Paginas.Page1.obj_4c_Opt_Juros.Value = 1)
1723:     ENDFUNC
1724: 
1725:     *==========================================================================
1726:     * LOOKUP MOEDA
1727:     *==========================================================================
1728: 
1729:     PROCEDURE TxtMoedaCdKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1730:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR ;
1731:            par_nKeyCode = 115 OR par_nKeyCode = 116
1732:             LOCAL loc_cValor, loc_nRes, loc_nCotacao
1733:             loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c__cd_moeda.Value)
1734:             IF EMPTY(loc_cValor)
1735:                 THIS.pgf_4c_Paginas.Page1.txt_4c__ds_moeda.Value = ""
1736:                 THIS.this_oRelatorio.this_nVlCotacao = 1
1737:             ELSE
1738:                 IF SEEK(loc_cValor, "cursor_4c_SigCdMoe", "CMoes")
1739:                     THIS.pgf_4c_Paginas.Page1.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_SigCdMoe.CMoes)
1740:                     THIS.pgf_4c_Paginas.Page1.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_SigCdMoe.DMoes)
1741:                     loc_nCotacao = THIS.this_oRelatorio.BuscarCambio(loc_cValor)
1742:                     THIS.this_oRelatorio.this_nVlCotacao = IIF(loc_nCotacao = 0, 1, loc_nCotacao)
1743:                 ELSE
1744:                     THIS.AbrirBuscaMoeda()
1745:                 ENDIF
1746:             ENDIF
1747:         ENDIF
1748:     ENDPROC
1749: 
1750:     FUNCTION MoedaDsWhen()
1751:         RETURN EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c__cd_moeda.Value)
1752:     ENDFUNC
1753: 
1754:     PROCEDURE TxtMoedaDsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1755:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR ;
1756:            par_nKeyCode = 115 OR par_nKeyCode = 116
1757:             LOCAL loc_cValor
1758:             loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c__ds_moeda.Value)
1759:             IF EMPTY(loc_cValor)
1760:                 THIS.pgf_4c_Paginas.Page1.txt_4c__cd_moeda.Value = ""
1761:                 THIS.pgf_4c_Paginas.Page1.txt_4c__ds_moeda.Value = ""
1762:             ELSE
1763:                 THIS.AbrirBuscaMoeda()
1764:             ENDIF
1765:         ENDIF
1766:     ENDPROC
1767: 
1768:     PROCEDURE AbrirBuscaMoeda()
1769:         LOCAL loc_oForm, loc_cValor, loc_cMoedaSel, loc_nCotacao
1770:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c__cd_moeda.Value)
1771:         IF EMPTY(loc_cValor)
1772:             loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c__ds_moeda.Value)
1773:         ENDIF
1774: 
1775:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1776:             "SigCdMoe", "cursor_4c_BuscaMoeda", "CMoes", loc_cValor, ;
1777:             "Busca de Moeda")
1778:         IF VARTYPE(loc_oForm) != "O"
1779:             RETURN
1780:         ENDIF
1781: 
1782:         IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1783:             THIS.pgf_4c_Paginas.Page1.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)
1784:             THIS.pgf_4c_Paginas.Page1.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.DMoes)
1785:             loc_cMoedaSel = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)
1786:             loc_nCotacao  = THIS.this_oRelatorio.BuscarCambio(loc_cMoedaSel)
1787:             THIS.this_oRelatorio.this_nVlCotacao = IIF(loc_nCotacao = 0, 1, loc_nCotacao)
1788:         ELSE
1789:             IF !loc_oForm.this_lAchouRegistro
1790:             loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
1791:             loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1792:             loc_oForm.Show()
1793:             IF loc_oForm.this_lSelecionou
1794:                 THIS.pgf_4c_Paginas.Page1.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)
1795:                 THIS.pgf_4c_Paginas.Page1.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.DMoes)
1796:                 loc_cMoedaSel = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)
1797:                 loc_nCotacao  = THIS.this_oRelatorio.BuscarCambio(loc_cMoedaSel)
1798:                 THIS.this_oRelatorio.this_nVlCotacao = IIF(loc_nCotacao = 0, 1, loc_nCotacao)
1799:             ELSE
1800:                 THIS.pgf_4c_Paginas.Page1.txt_4c__cd_moeda.Value = ""
1801:                 THIS.pgf_4c_Paginas.Page1.txt_4c__ds_moeda.Value = ""
1802:                 THIS.this_oRelatorio.this_nVlCotacao = 1
1803:             ENDIF
1804:             ENDIF
1805:         ENDIF
1806: 
1807:         IF USED("cursor_4c_BuscaMoeda")
1808:             USE IN cursor_4c_BuscaMoeda
1809:         ENDIF
1810:         loc_oForm.Release()
1811:     ENDPROC
1812: 
1813:     *==========================================================================
1814:     * LOOKUP GRUPO / DGRUPO
1815:     *==========================================================================
1816: 
1817:     PROCEDURE TxtGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1818:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR ;
1819:            par_nKeyCode = 115 OR par_nKeyCode = 116
1820:             LOCAL loc_cValor, loc_nRes
1821:             loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value)
1822:             IF EMPTY(loc_cValor)
1823:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupo.Value = ""
1824:             ELSE
1825:                 loc_nRes = SQLEXEC(gnConnHandle, ;
1826:                     "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cValor), ;
1827:                     "cursor_4c_ValidaGrupo")
1828:                 IF loc_nRes > 0 AND !EOF("cursor_4c_ValidaGrupo")
1829:                     THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_ValidaGrupo.Codigos)
1830:                     THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_ValidaGrupo.Descrs)
1831:                 ELSE
1832:                     THIS.AbrirBuscaGrupo()
1833:                 ENDIF
1834:                 IF USED("cursor_4c_ValidaGrupo")
1835:                     USE IN cursor_4c_ValidaGrupo
1836:                 ENDIF
1837:             ENDIF
1838:         ENDIF
1839:     ENDPROC
1840: 
1841:     FUNCTION DGrupoWhen()
1842:         RETURN EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value)
1843:     ENDFUNC
1844: 
1845:     PROCEDURE TxtDGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1846:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR ;
1847:            par_nKeyCode = 115 OR par_nKeyCode = 116
1848:             LOCAL loc_cValor
1849:             loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupo.Value)
1850:             IF EMPTY(loc_cValor)
1851:                 THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value = ""
1852:             ELSE
1853:                 THIS.AbrirBuscaGrupo()
1854:             ENDIF
1855:         ENDIF
1856:     ENDPROC
1857: 
1858:     PROCEDURE AbrirBuscaGrupo()
1859:         LOCAL loc_oForm, loc_cValor
1860:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value)
1861: 
1862:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1863:             "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", loc_cValor, ;
1864:             "Busca de Grupo Cont" + CHR(225) + "bil")
1865:         IF VARTYPE(loc_oForm) != "O"
1866:             RETURN
1867:         ENDIF
1868: 
1869:         IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1870:             THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
1871:             THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
1872:         ELSE
1873:             IF !loc_oForm.this_lAchouRegistro
1874:             loc_oForm.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1875:             loc_oForm.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1876:             loc_oForm.Show()
1877:             IF loc_oForm.this_lSelecionou
1878:                 THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
1879:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
1880:             ELSE
1881:                 THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value  = ""
1882:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupo.Value = ""
1883:             ENDIF
1884:             ENDIF
1885:         ENDIF
1886: 
1887:         IF USED("cursor_4c_BuscaGrupo")
1888:             USE IN cursor_4c_BuscaGrupo
1889:         ENDIF
1890:         loc_oForm.Release()
1891:     ENDPROC
1892: 
1893:     *==========================================================================
1894:     * LOOKUP CONTA / DCONTA
1895:     *==========================================================================
1896: 
1897:     PROCEDURE TxtContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1898:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR ;
1899:            par_nKeyCode = 115 OR par_nKeyCode = 116
1900:             LOCAL loc_cValor, loc_cGrupo, loc_nRes, loc_cSQL
1901:             loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Conta.Value)
1902:             IF EMPTY(loc_cValor)
1903:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DConta.Value = ""
1904:             ELSE
1905:                 loc_cGrupo = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value)
1906:                 loc_cSQL   = "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + ;
1907:                     EscaparSQL(PADR(loc_cValor, 10))
1908:                 IF !EMPTY(loc_cGrupo)
1909:                     loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(loc_cGrupo)
1910:                 ENDIF
1911:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaConta")
1912:                 IF loc_nRes > 0 AND !EOF("cursor_4c_ValidaConta")
1913:                     THIS.pgf_4c_Paginas.Page1.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_ValidaConta.IClis)
1914:                     THIS.pgf_4c_Paginas.Page1.txt_4c_DConta.Value = ALLTRIM(cursor_4c_ValidaConta.RClis)
1915:                 ELSE
1916:                     THIS.AbrirBuscaConta()
1917:                 ENDIF
1918:                 IF USED("cursor_4c_ValidaConta")
1919:                     USE IN cursor_4c_ValidaConta
1920:                 ENDIF
1921:             ENDIF
1922:         ENDIF
1923:     ENDPROC
1924: 
1925:     FUNCTION DContaWhen()
1926:         RETURN EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_Conta.Value)
1927:     ENDFUNC
1928: 
1929:     PROCEDURE TxtDContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1930:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR ;
1931:            par_nKeyCode = 115 OR par_nKeyCode = 116
1932:             LOCAL loc_cValor
1933:             loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DConta.Value)
1934:             IF EMPTY(loc_cValor)
1935:                 THIS.pgf_4c_Paginas.Page1.txt_4c_Conta.Value = ""
1936:             ELSE
1937:                 THIS.AbrirBuscaConta()
1938:             ENDIF
1939:         ENDIF
1940:     ENDPROC
1941: 
1942:     PROCEDURE AbrirBuscaConta()
1943:         LOCAL loc_oForm, loc_cValor
1944:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Conta.Value)
1945: 
1946:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1947:             "SigCdCli", "cursor_4c_BuscaConta", "IClis", loc_cValor, ;
1948:             "Busca de Conta")
1949:         IF VARTYPE(loc_oForm) != "O"
1950:             RETURN
1951:         ENDIF
1952: 
1953:         IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1954:             THIS.pgf_4c_Paginas.Page1.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
1955:             THIS.pgf_4c_Paginas.Page1.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
1956:         ELSE
1957:             IF !loc_oForm.this_lAchouRegistro
1958:             loc_oForm.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
1959:             loc_oForm.mAddColuna("RClis", "", "Nome")
1960:             loc_oForm.Show()
1961:             IF loc_oForm.this_lSelecionou
1962:                 THIS.pgf_4c_Paginas.Page1.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
1963:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
1964:             ELSE
1965:                 THIS.pgf_4c_Paginas.Page1.txt_4c_Conta.Value  = ""
1966:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DConta.Value = ""
1967:             ENDIF
1968:             ENDIF
1969:         ENDIF
1970: 
1971:         IF USED("cursor_4c_BuscaConta")
1972:             USE IN cursor_4c_BuscaConta
1973:         ENDIF
1974:         loc_oForm.Release()
1975:     ENDPROC
1976: 
1977:     *==========================================================================
1978:     * LOOKUP JOBS / DJOBS
1979:     *==========================================================================
1980: 
1981:     PROCEDURE TxtJobsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1982:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR ;
1983:            par_nKeyCode = 115 OR par_nKeyCode = 116
1984:             LOCAL loc_cValor, loc_nRes
1985:             loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c__Jobs.Value)
1986:             IF EMPTY(loc_cValor)
1987:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DJobs.Value = ""
1988:             ELSE
1989:                 loc_nRes = SQLEXEC(gnConnHandle, ;
1990:                     "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + ;
1991:                     EscaparSQL(PADR(loc_cValor, 10)), ;
1992:                     "cursor_4c_ValidaJobs")
1993:                 IF loc_nRes > 0 AND !EOF("cursor_4c_ValidaJobs")
1994:                     THIS.pgf_4c_Paginas.Page1.txt_4c__Jobs.Value = ALLTRIM(cursor_4c_ValidaJobs.IClis)
1995:                     THIS.pgf_4c_Paginas.Page1.txt_4c_DJobs.Value = ALLTRIM(cursor_4c_ValidaJobs.RClis)
1996:                 ELSE
1997:                     THIS.AbrirBuscaJobs()
1998:                 ENDIF
1999:                 IF USED("cursor_4c_ValidaJobs")
2000:                     USE IN cursor_4c_ValidaJobs
2001:                 ENDIF
2002:             ENDIF
2003:         ENDIF
2004:     ENDPROC
2005: 
2006:     FUNCTION DJobsWhen()
2007:         RETURN EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c__Jobs.Value)
2008:     ENDFUNC
2009: 
2010:     PROCEDURE TxtDJobsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2011:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR ;
2012:            par_nKeyCode = 115 OR par_nKeyCode = 116
2013:             LOCAL loc_cValor
2014:             loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DJobs.Value)
2015:             IF EMPTY(loc_cValor)
2016:                 THIS.pgf_4c_Paginas.Page1.txt_4c__Jobs.Value = ""
2017:             ELSE
2018:                 THIS.AbrirBuscaJobs()
2019:             ENDIF
2020:         ENDIF
2021:     ENDPROC
2022: 
2023:     PROCEDURE AbrirBuscaJobs()
2024:         LOCAL loc_oForm, loc_cValor
2025:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c__Jobs.Value)
2026: 
2027:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2028:             "SigCdCli", "cursor_4c_BuscaJobs", "IClis", loc_cValor, ;
2029:             "Busca de Job")
2030:         IF VARTYPE(loc_oForm) != "O"
2031:             RETURN
2032:         ENDIF
2033: 
2034:         IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
2035:             THIS.pgf_4c_Paginas.Page1.txt_4c__Jobs.Value = ALLTRIM(cursor_4c_BuscaJobs.IClis)
2036:             THIS.pgf_4c_Paginas.Page1.txt_4c_DJobs.Value = ALLTRIM(cursor_4c_BuscaJobs.RClis)
2037:         ELSE
2038:             IF !loc_oForm.this_lAchouRegistro
2039:             loc_oForm.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
2040:             loc_oForm.mAddColuna("RClis", "", "Nome")
2041:             loc_oForm.Show()
2042:             IF loc_oForm.this_lSelecionou
2043:                 THIS.pgf_4c_Paginas.Page1.txt_4c__Jobs.Value = ALLTRIM(cursor_4c_BuscaJobs.IClis)
2044:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DJobs.Value = ALLTRIM(cursor_4c_BuscaJobs.RClis)
2045:             ELSE
2046:                 THIS.pgf_4c_Paginas.Page1.txt_4c__Jobs.Value = ""
2047:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DJobs.Value = ""
2048:             ENDIF
2049:             ENDIF
2050:         ENDIF
2051: 
2052:         IF USED("cursor_4c_BuscaJobs")
2053:             USE IN cursor_4c_BuscaJobs
2054:         ENDIF
2055:         loc_oForm.Release()
2056:     ENDPROC
2057: 
2058:     *--------------------------------------------------------------------------
2059:     * ConfigurarPaginaLista - Configura conteudo de Page1 (grids de selecao)
2060:     * Em forms REPORT, Page1 hospeda os filtros e os 3 grids de selecao
2061:     * (Empresas, Operacoes, Classificacoes). Esta procedure encapsula a
2062:     * configuracao desses grids, delegando para ConfigurarGrids().
2063:     *--------------------------------------------------------------------------
2064:     PROTECTED PROCEDURE ConfigurarPaginaLista()
2065:         LOCAL loc_oPg1
2066:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
2067:         THIS.ConfigurarGrids()
2068:         loc_oPg1.grd_4c_Emps.Visible    = .T.
2069:         loc_oPg1.grd_4c_Tipo.Visible    = .T.
2070:         loc_oPg1.grd_4c_Cla.Visible     = .T.
2071:     ENDPROC
2072: 
2073:     *--------------------------------------------------------------------------
2074:     * ConfigurarPaginaDados - Configura conteudo de pagina de dados
2075:     * Em forms REPORT (frmrelatorio) NAO existe Page2 (Dados): todos os
2076:     * filtros estao em Page1 e ja foram configurados por ConfigurarFiltros().
2077:     * Este metodo existe para manter compatibilidade com a API de forms CRUD
2078:     * e satisfaz validacoes do pipeline de migracao multi-fase.
2079:     *--------------------------------------------------------------------------
2080:     PROTECTED PROCEDURE ConfigurarPaginaDados()
2081:         *-- Form REPORT usa layout FLAT com apenas Page1 contendo todos os filtros.
2082:         *-- Os campos de filtro sao adicionados em ConfigurarFiltros() que ja foi
2083:         *-- chamado durante InicializarForm(). Portanto nao ha controles adicionais
2084:         *-- a configurar nesta pagina.
2085:         IF THIS.pgf_4c_Paginas.PageCount >= 1
2086:             THIS.pgf_4c_Paginas.Page1.Refresh()
2087:         ENDIF
2088:     ENDPROC
2089: 
2090:     *--------------------------------------------------------------------------
2091:     * AlternarPagina - Define a pagina ativa do PageFrame
2092:     * Em forms REPORT este form usa uma unica pagina (Page1) que contem
2093:     * todos os filtros e grids. Mantido por compatibilidade com a API de
2094:     * forms de cadastro.
2095:     *--------------------------------------------------------------------------
2096:     PROCEDURE AlternarPagina(par_nPagina)
2097:         LOCAL loc_nPagina
2098:         loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
2099:         IF loc_nPagina < 1 OR loc_nPagina > THIS.pgf_4c_Paginas.PageCount
2100:             loc_nPagina = 1
2101:         ENDIF
2102:         THIS.pgf_4c_Paginas.ActivePage = loc_nPagina
2103:         THIS.pgf_4c_Paginas.Refresh()
2104:     ENDPROC
2105: 
2106:     *--------------------------------------------------------------------------
2107:     * BtnBuscarClick - Para forms REPORT: equivale a Visualizar (preview)
2108:     *--------------------------------------------------------------------------
2109:     PROCEDURE BtnBuscarClick()
2110:         LOCAL loc_oPg1
2111:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
2112:         IF EMPTY(loc_oPg1.txt_4c_DtInicial.Value) OR ;
2113:            EMPTY(loc_oPg1.txt_4c_DtFinal.Value)
2114:             MsgAviso("Informe o per" + CHR(237) + "odo inicial e final.")
2115:             RETURN
2116:         ENDIF
2117:         THIS.FormParaRelatorio()
2118:         THIS.this_oRelatorio.Visualizar()
2119:     ENDPROC
2120: 
2121:     *--------------------------------------------------------------------------
2122:     * BtnEncerrarClick - Fecha o formulario
2123:     *--------------------------------------------------------------------------
2124:     PROCEDURE BtnEncerrarClick()
2125:         THIS.Release()
2126:     ENDPROC
2127: 
2128:     *--------------------------------------------------------------------------
2129:     * BtnSalvarClick - Para forms REPORT: equivale a Imprimir
2130:     *--------------------------------------------------------------------------
2131:     PROCEDURE BtnSalvarClick()
2132:         LOCAL loc_oPg1
2133:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
2134:         IF EMPTY(loc_oPg1.txt_4c_DtInicial.Value) OR ;
2135:            EMPTY(loc_oPg1.txt_4c_DtFinal.Value)
2136:             MsgAviso("Informe o per" + CHR(237) + "odo inicial e final.")
2137:             RETURN
2138:         ENDIF
2139:         THIS.FormParaRelatorio()
2140:         THIS.this_oRelatorio.Imprimir()
2141:     ENDPROC
2142: 
2143:     *--------------------------------------------------------------------------
2144:     * FormParaBO - Para forms REPORT: delega para FormParaRelatorio
2145:     *--------------------------------------------------------------------------
2146:     PROCEDURE FormParaBO()
2147:         THIS.FormParaRelatorio()
2148:     ENDPROC
2149: 
2150:     *--------------------------------------------------------------------------
2151:     * BOParaForm - Para forms REPORT: grids ja carregados em CarregarCursores
2152:     * Filtros de tela nao precisam ser recarregados a partir do BO.
2153:     *--------------------------------------------------------------------------
2154:     PROCEDURE BOParaForm()
2155:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
2156:             THIS.pgf_4c_Paginas.Refresh()
2157:         ENDIF
2158:     ENDPROC
2159: 
2160:     *--------------------------------------------------------------------------
2161:     * HabilitarCampos - Habilita todos os filtros; aplica regra PagRec via HabObjs
2162:     *--------------------------------------------------------------------------
2163:     PROCEDURE HabilitarCampos()
2164:         LOCAL loc_oPg1, loc_lPagRec
2165:         loc_oPg1    = THIS.pgf_4c_Paginas.Page1
2166:         loc_lPagRec = (loc_oPg1.chk_4c_Ck_Pagamentos.Value = 1) OR ;
2167:                       (loc_oPg1.chk_4c_Ck_Recebimentos.Value = 1)
2168:         loc_oPg1.txt_4c_DtInicial.Enabled         = .T.
2169:         loc_oPg1.txt_4c_DtFinal.Enabled           = .T.
2170:         loc_oPg1.txt_4c_Saldo.Enabled             = .T.
2171:         loc_oPg1.txt_4c_Grupo.Enabled             = .T.
2172:         loc_oPg1.txt_4c_DGrupo.Enabled            = .T.
2173:         loc_oPg1.txt_4c_Conta.Enabled             = .T.
2174:         loc_oPg1.txt_4c_DConta.Enabled            = .T.
2175:         loc_oPg1.txt_4c__cd_moeda.Enabled         = .T.
2176:         loc_oPg1.txt_4c__ds_moeda.Enabled         = .T.
2177:         loc_oPg1.txt_4c__Jobs.Enabled             = .T.
2178:         loc_oPg1.txt_4c_DJobs.Enabled             = .T.
2179:         loc_oPg1.obj_4c_OptDatas.Enabled          = .T.
2180:         loc_oPg1.obj_4c_OptSaldos.Enabled         = .T.
2181:         loc_oPg1.obj_4c_OptAutorizados.Enabled    = .T.
2182:         loc_oPg1.chk_4c_Ck_Pagamentos.Enabled    = .T.
2183:         loc_oPg1.chk_4c_Ck_Recebimentos.Enabled  = .T.
2184:         THIS.HabObjs(loc_lPagRec)
2185:     ENDPROC
2186: 
2187:     *--------------------------------------------------------------------------
2188:     * CarregarLista - Para forms REPORT: cursores ja carregados em CarregarCursores
2189:     * Retorna .T. para compatibilidade com o ciclo de vida do FormBase
2190:     *--------------------------------------------------------------------------
2191:     FUNCTION CarregarLista()
2192:         RETURN .T.
2193:     ENDFUNC
2194: 
2195:     *--------------------------------------------------------------------------
2196:     * AjustarBotoesPorModo - Para forms REPORT: botoes sempre habilitados
2197:     *--------------------------------------------------------------------------
2198:     PROCEDURE AjustarBotoesPorModo()
2199:         IF VARTYPE(THIS.cnt_4c_Cabecalho) = "O"
2200:             WITH THIS.cnt_4c_Cabecalho.cmg_4c_Botoes
2201:                 .Buttons(1).Enabled = .T.
2202:                 .Buttons(2).Enabled = .T.
2203:                 .Buttons(3).Enabled = .T.
2204:                 .Buttons(4).Enabled = .T.
2205:             ENDWITH
2206:         ENDIF
2207:     ENDPROC
2208: 
2209:     *--------------------------------------------------------------------------
2210:     * Destroy - Libera referencia ao BO e cursores da sessao privada
2211:     *--------------------------------------------------------------------------
2212:     PROCEDURE Destroy()
2213:         IF VARTYPE(THIS.this_oRelatorio) = "O"
2214:             THIS.this_oRelatorio = .NULL.
2215:         ENDIF
2216:         DODEFAULT()
2217:     ENDPROC
2218: 
2219: ENDDEFINE

