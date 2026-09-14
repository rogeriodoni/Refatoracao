# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [LAYOUT-POSITION] Controle 'entrada' (parent: SIGRECTC): Top original=123 vs migrado 'chk_4c_Entrada' Top=38 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'receber' (parent: SIGRECTC): Top original=123 vs migrado 'chk_4c_Receber' Top=38 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'depositar' (parent: SIGRECTC): Top original=123 vs migrado 'chk_4c_Depositar' Top=38 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'baixa' (parent: SIGRECTC): Top original=123 vs migrado 'chk_4c_Baixa' Top=38 (diff=85px, tolerancia=30px)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' encontrado - substituir por 'Tahoma'

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrectc.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1150 linhas total):

*-- Linhas 16 a 24:
16: *   * HabilitarCampos(), CarregarLista(), AjustarBotoesPorModo() (API gen" + CHR(233) + "rica)
17: *   * Integra" + CHR(231) + CHR(227) + "o no menu.prg (popRelatorios BAR 83)
18: *   * BINDEVENTs para F4/F5/ENTER/TAB em todos os campos de lookup
19: *   * Handlers dos checkboxes de tipo de movimenta" + CHR(231) + CHR(227) + "o (AjustarOptTpDep)
20: *   * FormParaRelatorio(), LimparCampos()
21: *   * Eventos principais: BtnVisualizarClick, BtnImprimirClick, BtnExcelClick, BtnEncerrarClick
22: *==============================================================================
23: 
24: DEFINE CLASS Formsigrectc AS FormBase

*-- Linhas 60 a 68:
60:         loc_lSucesso   = .F.
61:         loc_lContinuar = .T.
62:         TRY
63:             THIS.Caption = "Relat" + CHR(243) + "rio Movimenta" + CHR(231) + CHR(227) + "o de Cart" + CHR(245) + "es"
64: 
65:             IF TYPE("gc_4c_CaminhoIcones") = "U"
66:                 gc_4c_CaminhoIcones = ""
67:             ENDIF
68:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 96 a 117:
96:                 *-- PageFrame com p" + CHR(225) + "gina de filtros
97:                 THIS.ConfigurarPageFrame()
98: 
99:                 *-- Campos de filtro na Page1 (checkboxes, datas, empresa, cart" + CHR(227) + "o)
100:                 THIS.ConfigurarPaginaLista()
101: 
102:                 *-- InputMask, MaxLength, Format, TabIndex (UI fidelity - Fase 5)
103:                 THIS.ConfigurarPaginaDados()
104: 
105:                 *-- BINDEVENT para bot" + CHR(245) + "es da CommandGroup (Visualizar/Imprimir/Excel/Encerrar)
106:                 THIS.VincularBotoes()
107: 
108:                 *-- Valores iniciais dos filtros
109:                 THIS.LimparCampos()
110: 
111:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
112:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
113: 
114:                 THIS.Visible = .T.
115:                 loc_lSucesso = .T.
116:             ENDIF
117:         CATCH TO loc_oErro

*-- Linhas 131 a 209:
131:     PROTECTED PROCEDURE ConfigurarCabecalho()
132:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
133:         WITH THIS.cnt_4c_Cabecalho
134:             .Top         = 0
135:             .Left        = 0
136:             .Width       = THIS.Width
137:             .Height      = 80
138:             .BackStyle   = 1
139:             .BackColor   = RGB(100, 100, 100)
140:             .BorderWidth = 0
141:             .Visible     = .T.
142: 
143:             *-- Sombra (deslocada 2px para efeito 3D do texto branco)
144:             .AddObject("lbl_4c_Sombra", "Label")
145:             WITH .lbl_4c_Sombra
146:                 .Top       = 22
147:                 .Left      = 22
148:                 .Width     = THIS.Width
149:                 .Height    = 30
150:                 .Caption   = "Relat" + CHR(243) + "rio Movimenta" + CHR(231) + CHR(227) + "o de Cart" + CHR(245) + "es"
151:                 .FontName  = "Tahoma"
152:                 .FontSize  = 14
153:                 .FontBold  = .T.
154:                 .ForeColor = RGB(0, 0, 0)
155:                 .BackStyle = 0
156:                 .Visible   = .T.
157:             ENDWITH
158: 
159:             *-- T" + CHR(237) + "tulo em branco (sobre a sombra)
160:             .AddObject("lbl_4c_Titulo", "Label")
161:             WITH .lbl_4c_Titulo
162:                 .Top       = 20
163:                 .Left      = 20
164:                 .Width     = THIS.Width
165:                 .Height    = 30
166:                 .Caption   = "Relat" + CHR(243) + "rio Movimenta" + CHR(231) + CHR(227) + "o de Cart" + CHR(245) + "es"
167:                 .FontName  = "Tahoma"
168:                 .FontSize  = 14
169:                 .FontBold  = .T.
170:                 .ForeColor = RGB(255, 255, 255)
171:                 .BackStyle = 0
172:                 .Visible   = .T.
173:             ENDWITH
174:         ENDWITH
175:     ENDPROC
176: 
177:     *--------------------------------------------------------------------------
178:     * ConfigurarBotoes - CommandGroup de a" + CHR(231) + CHR(245) + "es do relat" + CHR(243) + "rio (btnReport area)
179:     *   Original: btnReport.Top=0, Left=530, Width~270
180:     *   Bot" + CHR(245) + "es: Visualiza(5), Imprime(71), DocExcel(137), Sair(203) - W=65 cada
181:     *   Eventos Click vinculados nas Fases 7-8 (BINDEVENTs).
182:     *--------------------------------------------------------------------------
183:     PROTECTED PROCEDURE ConfigurarBotoes()
184:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
185:         WITH THIS.cmg_4c_Botoes
186:             .Top           = 0
187:             .Left          = 529
188:             .Width         = 273
189:             .Height        = 80
190:             .ButtonCount   = 4
191:             .BackStyle     = 0
192:             .BorderStyle   = 0
193:             .BorderColor   = RGB(136, 189, 188)
194:             .SpecialEffect = 1
195:             .Themes        = .F.
196:             .Visible       = .T.
197: 
198:             *-- Bot" + CHR(227) + "o 1: Visualizar (preview em tela)
199:             WITH .Buttons(1)
200:                 .Top             = 5
201:                 .Left            = 5
202:                 .Width           = 65
203:                 .Height          = 70
204:                 .Caption         = "Visualizar"
205:                 .FontBold        = .T.
206:                 .FontItalic      = .T.
207:                 .BackColor       = RGB(255, 255, 255)
208:                 .ForeColor       = RGB(90, 90, 90)
209:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 217 a 229:
217: 
218:             *-- Bot" + CHR(227) + "o 2: Imprimir (impressora padr" + CHR(227) + "o)
219:             WITH .Buttons(2)
220:                 .Top             = 5
221:                 .Left            = 71
222:                 .Width           = 65
223:                 .Height          = 70
224:                 .Caption         = "Imprimir"
225:                 .FontName        = "Tahoma"
226:                 .FontBold        = .T.
227:                 .FontItalic      = .T.
228:                 .FontSize        = 8
229:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 239 a 251:
239: 
240:             *-- Bot" + CHR(227) + "o 3: Excel (exportar dados)
241:             WITH .Buttons(3)
242:                 .Top             = 5
243:                 .Left            = 137
244:                 .Width           = 65
245:                 .Height          = 70
246:                 .Caption         = "Excel"
247:                 .FontName        = "Tahoma"
248:                 .FontBold        = .T.
249:                 .FontItalic      = .T.
250:                 .FontSize        = 8
251:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 261 a 273:
261: 
262:             *-- Bot" + CHR(227) + "o 4: Encerrar (ESC fecha o form)
263:             WITH .Buttons(4)
264:                 .Top             = 5
265:                 .Left            = 203
266:                 .Width           = 65
267:                 .Height          = 70
268:                 .Caption         = "Encerrar"
269:                 .Cancel          = .T.
270:                 .FontName        = "Tahoma"
271:                 .FontBold        = .T.
272:                 .FontItalic      = .T.
273:                 .FontSize        = 8

*-- Linhas 300 a 315:
300:         loc_oPgf.PageCount = 1
301: 
302:         *-- Posicionamento: logo abaixo do cabecalho ate o fim do form
303:         loc_oPgf.Top    = 85
304:         loc_oPgf.Left   = -1
305:         loc_oPgf.Width  = THIS.Width + 2
306:         loc_oPgf.Height = THIS.Height - 85
307:         loc_oPgf.Tabs   = .F.
308: 
309:         *-- Configurar Page1 (FORA de qualquer WITH - usar refer" + CHR(234) + "ncia direta)
310:         loc_oPgf.Page1.Caption   = "Filtros"
311:         loc_oPgf.Page1.FontName  = "Tahoma"
312:         loc_oPgf.Page1.FontSize  = 8
313:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
314:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
315:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 375 a 491:
375:         LOCAL loc_oPag
376:         loc_oPag = THIS.pgf_4c_Paginas.Page1
377: 
378:         *-- ROW 1 (Top=38): Checkboxes de tipo de movimenta" + CHR(231) + CHR(227) + "o
379:         loc_oPag.AddObject("chk_4c_Entrada", "CheckBox")
380:         WITH loc_oPag.chk_4c_Entrada
381:             .Top       = 38
382:             .Left      = 288
383:             .Width     = 61
384:             .Height    = 15
385:             .Caption   = "Entradas"
386:             .Value     = 0
387:             .FontName  = "Tahoma"
388:             .FontSize  = 8
389:             .ForeColor = RGB(90,90,90)
390:             .BackStyle = 0
391:             .Visible   = .T.
392:         ENDWITH
393: 
394:         loc_oPag.AddObject("chk_4c_Receber", "CheckBox")
395:         WITH loc_oPag.chk_4c_Receber
396:             .Top       = 38
397:             .Left      = 363
398:             .Width     = 68
399:             .Height    = 15
400:             .Caption   = CHR(192) + " Receber"
401:             .Value     = 0
402:             .FontName  = "Tahoma"
403:             .FontSize  = 8
404:             .ForeColor = RGB(90,90,90)
405:             .BackStyle = 0
406:             .Visible   = .T.
407:         ENDWITH
408: 
409:         loc_oPag.AddObject("chk_4c_Depositar", "CheckBox")
410:         WITH loc_oPag.chk_4c_Depositar
411:             .Top       = 38
412:             .Left      = 447
413:             .Width     = 74
414:             .Height    = 15
415:             .Caption   = CHR(192) + " Depositar"
416:             .Value     = 0
417:             .FontName  = "Tahoma"
418:             .FontSize  = 8
419:             .ForeColor = RGB(90,90,90)
420:             .BackStyle = 0
421:             .Visible   = .T.
422:         ENDWITH
423: 
424:         loc_oPag.AddObject("chk_4c_Baixa", "CheckBox")
425:         WITH loc_oPag.chk_4c_Baixa
426:             .Top       = 38
427:             .Left      = 540
428:             .Width     = 61
429:             .Height    = 15
430:             .Caption   = "Baixados"
431:             .Value     = 0
432:             .FontName  = "Tahoma"
433:             .FontSize  = 8
434:             .ForeColor = RGB(90,90,90)
435:             .BackStyle = 0
436:             .Visible   = .T.
437:         ENDWITH
438: 
439:         *-- ROW 2 (Top=58-64): Per" + CHR(237) + "odo + OptionGroup tipo dep" + CHR(243) + "sito
440:         loc_oPag.AddObject("lbl_4c_Periodo", "Label")
441:         WITH loc_oPag.lbl_4c_Periodo
442:             .Top       = 64
443:             .Left      = 240
444:             .Width     = 50
445:             .Height    = 18
446:             .Caption   = "Per" + CHR(237) + "odo :"
447:             .FontName  = "Tahoma"
448:             .FontSize  = 8
449:             .ForeColor = RGB(90,90,90)
450:             .BackStyle = 0
451:             .Visible   = .T.
452:         ENDWITH
453: 
454:         loc_oPag.AddObject("txt_4c_DtInicial", "TextBox")
455:         WITH loc_oPag.txt_4c_DtInicial
456:             .Top           = 59
457:             .Left          = 288
458:             .Width         = 80
459:             .Height        = 25
460:             .Value         = {}
461:             .FontName      = "Tahoma"
462:             .FontSize      = 8
463:             .ForeColor     = RGB(90,90,90)
464:             .BackColor     = RGB(255,255,255)
465:             .SpecialEffect = 1
466:             .Visible       = .T.
467:         ENDWITH
468: 
469:         loc_oPag.AddObject("lbl_4c_A", "Label")
470:         WITH loc_oPag.lbl_4c_A
471:             .Top       = 62
472:             .Left      = 373
473:             .Width     = 12
474:             .Height    = 18
475:             .Caption   = CHR(224)
476:             .FontName  = "Tahoma"
477:             .FontSize  = 8
478:             .ForeColor = RGB(90,90,90)
479:             .BackStyle = 0
480:             .Visible   = .T.
481:         ENDWITH
482: 
483:         loc_oPag.AddObject("txt_4c_DtFinal", "TextBox")
484:         WITH loc_oPag.txt_4c_DtFinal
485:             .Top           = 59
486:             .Left          = 386
487:             .Width         = 80
488:             .Height        = 25
489:             .Value         = {}
490:             .FontName      = "Tahoma"
491:             .FontSize      = 8

*-- Linhas 498 a 559:
498:         *-- OptionGroup: tipo dep" + CHR(243) + "sito (habilitado apenas quando s" + CHR(243) + " Depositar marcado)
499:         loc_oPag.AddObject("opt_4c_TpDep", "OptionGroup")
500:         WITH loc_oPag.opt_4c_TpDep
501:             .Top         = 58
502:             .Left        = 466
503:             .Width       = 152
504:             .Height      = 25
505:             .ButtonCount = 2
506:             .BackStyle   = 0
507:             .BorderStyle = 0
508:             .Themes      = .F.
509:             .Value       = 1
510:             .Visible     = .T.
511:             WITH .Buttons(1)
512:                 .Caption   = "Entrada"
513:                 .Left      = 5
514:                 .Top       = 5
515:                 .Width     = 56
516:                 .Height    = 15
517:                 .ForeColor = RGB(90,90,90)
518:                 .BackStyle = 0
519:                 .Enabled   = .F.
520:                 .Visible   = .T.
521:             ENDWITH
522:             WITH .Buttons(2)
523:                 .Caption   = "Vencimento"
524:                 .Left      = 74
525:                 .Top       = 5
526:                 .Height    = 15
527:                 .FontName  = "Tahoma"
528:                 .FontSize  = 8
529:                 .ForeColor = RGB(90,90,90)
530:                 .BackStyle = 0
531:                 .Enabled   = .F.
532:                 .Visible   = .T.
533:             ENDWITH
534:         ENDWITH
535: 
536:         *-- ROW 3 (Top=86-91): Empresa
537:         loc_oPag.AddObject("lbl_4c_Emps", "Label")
538:         WITH loc_oPag.lbl_4c_Emps
539:             .Top       = 91
540:             .Left      = 235
541:             .Width     = 50
542:             .Height    = 18
543:             .Caption   = "Empresa :"
544:             .FontName  = "Tahoma"
545:             .FontSize  = 8
546:             .ForeColor = RGB(90,90,90)
547:             .BackStyle = 0
548:             .Visible   = .T.
549:         ENDWITH
550: 
551:         loc_oPag.AddObject("txt_4c_Cemps", "TextBox")
552:         WITH loc_oPag.txt_4c_Cemps
553:             .Top           = 86
554:             .Left          = 288
555:             .Width         = 35
556:             .Height        = 25
557:             .Value         = ""
558:             .FontName      = "Tahoma"
559:             .FontSize      = 9

*-- Linhas 567 a 618:
567: 
568:         loc_oPag.AddObject("txt_4c_Razas", "TextBox")
569:         WITH loc_oPag.txt_4c_Razas
570:             .Top           = 86
571:             .Left          = 325
572:             .Width         = 301
573:             .Height        = 25
574:             .Value         = ""
575:             .FontName      = "Tahoma"
576:             .FontSize      = 8
577:             .ForeColor     = RGB(90,90,90)
578:             .BackColor     = RGB(255,255,255)
579:             .SpecialEffect = 1
580:             .Visible       = .T.
581:         ENDWITH
582: 
583:         *-- ROW 4 (Top=113-118): Cart" + CHR(227) + "o / forma de pagamento
584:         loc_oPag.AddObject("lbl_4c_Fpags", "Label")
585:         WITH loc_oPag.lbl_4c_Fpags
586:             .Top       = 118
587:             .Left      = 198
588:             .Width     = 88
589:             .Height    = 18
590:             .Caption   = "Nome do Cart" + CHR(227) + "o :"
591:             .FontName  = "Tahoma"
592:             .FontSize  = 8
593:             .ForeColor = RGB(90,90,90)
594:             .BackStyle = 0
595:             .Visible   = .T.
596:         ENDWITH
597: 
598:         loc_oPag.AddObject("txt_4c_Fpags", "TextBox")
599:         WITH loc_oPag.txt_4c_Fpags
600:             .Top           = 113
601:             .Left          = 288
602:             .Width         = 94
603:             .Height        = 25
604:             .Value         = ""
605:             .FontName      = "Tahoma"
606:             .FontSize      = 8
607:             .ForeColor     = RGB(90,90,90)
608:             .BackColor     = RGB(255,255,255)
609:             .SpecialEffect = 1
610:             .Visible       = .T.
611:         ENDWITH
612: 
613:         *-- BINDEVENT: checkboxes tipo movimenta" + CHR(231) + CHR(227) + "o
614:         BINDEVENT(loc_oPag.chk_4c_Entrada,   "Click", THIS, "ChkEntradaClick")
615:         BINDEVENT(loc_oPag.chk_4c_Receber,   "Click", THIS, "ChkReceberClick")
616:         BINDEVENT(loc_oPag.chk_4c_Depositar, "Click", THIS, "ChkDepositarClick")
617:         BINDEVENT(loc_oPag.chk_4c_Baixa,     "Click", THIS, "ChkBaixaClick")
618: 

*-- Linhas 633 a 641:
633:     *     get_fpags : InputMask="!!!!!!!!!!!!" MaxLength=12
634:     *     get_cemps : Format="!"  MaxLength=3
635:     *     get_razas : Format="!"  MaxLength=40
636:     *     TabIndex  : OptTpDep=1, checkboxes=2-5, datas=6-7, lbl_a=8
637:     *                 lbl_periodo=9, get_cemps=10, get_razas=11
638:     *                 lbl_emps=12, get_fpags=13, lbl_fpags=14
639:     *--------------------------------------------------------------------------
640:     PROTECTED PROCEDURE ConfigurarPaginaDados()
641:         LOCAL loc_oPag

*-- Linhas 667 a 681:
667:         loc_oPag.chk_4c_Baixa.TabIndex     = 5
668:         loc_oPag.txt_4c_DtInicial.TabIndex = 6
669:         loc_oPag.txt_4c_DtFinal.TabIndex   = 7
670:         loc_oPag.lbl_4c_A.TabIndex         = 8
671:         loc_oPag.lbl_4c_Periodo.TabIndex   = 9
672:         loc_oPag.txt_4c_Cemps.TabIndex     = 10
673:         loc_oPag.txt_4c_Razas.TabIndex     = 11
674:         loc_oPag.lbl_4c_Emps.TabIndex      = 12
675:         loc_oPag.txt_4c_Fpags.TabIndex     = 13
676:         loc_oPag.lbl_4c_Fpags.TabIndex     = 14
677:     ENDPROC
678: 
679:     *--------------------------------------------------------------------------
680:     * LimparCampos - Inicializa / reseta todos os campos de filtro
681:     *   Data inicial e final = hoje (identico ao Init original do SIGRECTC.SCX)

*-- Linhas 725 a 734:
725:     ENDPROC
726: 
727:     *--------------------------------------------------------------------------
728:     * AjustarOptTpDep - Habilita/desabilita opt_4c_TpDep conforme checkboxes
729:     *   Habilitado APENAS quando Depositar marcado E nenhum outro checkbox ativo.
730:     *   Equivale " + CHR(224) + " l" + CHR(243) + "gica dos Click events de entrada/receber/depositar/baixa do original.
731:     *--------------------------------------------------------------------------
732:     PROTECTED PROCEDURE AjustarOptTpDep()
733:         LOCAL loc_oPag, loc_oOpt, loc_lOutroAtivo, loc_lDepositar
734:         loc_oPag = THIS.pgf_4c_Paginas.Page1

*-- Linhas 748 a 756:
748:         ENDIF
749:     ENDPROC
750: 
751:     *-- Handlers dos checkboxes de tipo de movimenta" + CHR(231) + CHR(227) + "o (BINDEVENT Click)
752:     PROCEDURE ChkEntradaClick()
753:         THIS.AjustarOptTpDep()
754:     ENDPROC
755: 
756:     PROCEDURE ChkReceberClick()


### BO (C:\4c\projeto\app\classes\sigrectcBO.prg):
*==============================================================================
* SIGRECTCBO.PRG
* Business Object para Relatorio Movimentacao de Cartoes
* Herda de RelatorioBase
* Formulario original: SIGRECTC (sigrectc.SCX)
*==============================================================================

DEFINE CLASS sigrectcBO AS RelatorioBase

    *-- Arquivo e titulo do relatorio
    this_cArquivoRelatorio  = ""
    this_cTituloRelatorio   = ""

    *-- Cursor de saida do relatorio (UNION ALL de listpro1-4)
    this_cCursorDados       = "cursor_4c_DadosCtc"

    *-- Filtros de periodo
    this_dDtInicial         = {}
    this_dDtFinal           = {}

    *-- Filtro de empresa (get_cemps + get_razas)
    this_cEmps              = ""
    this_cRazas             = ""

    *-- Filtro de cartao/forma de pagamento (get_fpags)
    this_cFpags             = ""

    *-- Checkboxes de tipo de movimentacao (0=desmarcado, 1=marcado)
    this_lEntrada           = .F.
    this_lReceber           = .F.
    this_lDepositar         = .F.
    this_lBaixa             = .F.

    *-- OptTpDep: 1=Entrada, 2=Vencimento (controla logica de deposito)
    this_nOptTpDep          = 1

    *-- Deposito por vencimento previsto: Option2 habilitado e TpDep = 2
    this_lDepPrev           = .F.

    *--------------------------------------------------------------------------
    * Init - Inicializa BO do relatorio de movimentacao de cartoes
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()
            THIS.this_cArquivoRelatorio = gc_4c_CaminhoReports + "relsigrectc.frx"
            THIS.this_cTituloRelatorio  = "Relat" + CHR(243) + "rio Movimenta" + ;
                                          CHR(231) + CHR(227) + "o de Cart" + CHR(245) + "es"
            THIS.this_dDtInicial = DATE()
            THIS.this_dDtFinal   = DATE()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCartoes - Carrega cursor de cartoes para lookup do campo fpags
    * SQL original: Select dcarts From SigOpFp where Infos = 'T' group by dcarts
    *--------------------------------------------------------------------------
    PROCEDURE CarregarCartoes()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Cartoes")
                USE IN cursor_4c_Cartoes
            ENDIF
            loc_cSQL = "SELECT dcarts FROM SigOpFp WHERE Infos = 'T' GROUP BY dcarts"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cartoes")
            IF loc_nResult > 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Imposs" + CHR(237) + "vel carregar cart" + CHR(245) + "es"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursores consolidados para o relatorio.
    * Processa 4 tipos de movimento: Entradas, A Receber, A Depositar, Baixados.
    * Baseado no PROCEDURE processamento do SIGRECTC.SCX original.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro, loc_lAbortou
        LOCAL loc_cSQL, loc_nResult
        LOCAL loc_cNomeEmpresa
        LOCAL loc_cEmpresaWhereA, loc_cEmpresaWhereB, loc_cEmpresaWhereD
        LOCAL loc_cCartaoWhereB, loc_cCartaoWhereD
        LOCAL loc_nOpMovimento, loc_cMovimento
        LOCAL loc_dDtIni, loc_dDtFim
        LOCAL loc_cDtIniSQL, loc_cDtFimSQL
        LOCAL loc_cCursorNome

        loc_lSucesso    = .F.
        loc_lAbortou    = .F.
        loc_cCursorNome = THIS.this_cCursorDados

        TRY
            *-- Limpar cursores anteriores
            IF USED("cursor_4c_ListPro1")
                USE IN cursor_4c_ListPro1
            ENDIF
            IF USED("cursor_4c_ListPro2")
                USE IN cursor_4c_ListPro2
            ENDIF
            IF USED("cursor_4c_ListPro3")
                USE IN cursor_4c_ListPro3
            ENDIF
            IF USED("cursor_4c_ListPro4")
                USE IN cursor_4c_ListPro4
            ENDIF
            IF USED("cursor_4c_TmpPro3")
                USE IN cursor_4c_TmpPro3
            ENDIF
            IF USED("cursor_4c_TmpRec2")
                USE IN cursor_4c_TmpRec2
            ENDIF
            IF USED("cursor_4c_TmpRec4")
                USE IN cursor_4c_TmpRec4
            ENDIF
            IF USED(loc_cCursorNome)
                USE IN (loc_cCursorNome)
            ENDIF

            *-- Estrutura padrao identica para os 4 cursores de trabalho
            SET NULL ON
            CREATE CURSOR cursor_4c_ListPro1 (cNomeEmpre C(40), dDtInicial T NULL, ;
                dDtFinal T NULL, CEmps C(3), ncarts N(12), numes N(8), datas T NULL, ;
                nlotecs C(10), fpags C(12), dopes C(20), valor N(13,2), ValLiq N(20,9), ;
                Taxas N(9,3), noresumos C(10), iclis C(10), rclis C(50) NULL, ;
                razas C(40) NULL, opcao I, cMovimento C(30), Vencs D NULL)

            CREATE CURSOR cursor_4c_ListPro2 (cNomeEmpre C(40), dDtInicial T NULL, ;
                dDtFinal T NULL, CEmps C(3), ncarts N(12), numes N(8), datas T NULL, ;
                nlotecs C(10), fpags C(12), dopes C(20), valor N(13,2), ValLiq N(20,9), ;
                Taxas N(9,3), noresumos C(10), iclis C(10), rclis C(50) NULL, ;
                razas C(40) NULL, opcao I, cMovimento C(30), Vencs D NULL)

            CREATE CURSOR cursor_4c_ListPro3 (cNomeEmpre C(40), dDtInicial T NULL, ;
                dDtFinal T NULL, CEmps C(3), ncarts N(12), numes N(8), datas T NULL, ;
                nlotecs C(10), fpags C(12), dopes C(20), valor N(13,2), ValLiq N(20,9), ;
                Taxas N(9,3), noresumos C(10), iclis C(10), rclis C(50) NULL, ;
                razas C(40) NULL, opcao I, cMovimento C(30), Vencs D NULL)

            CREATE CURSOR cursor_4c_ListPro4 (cNomeEmpre C(40), dDtInicial T NULL, ;
                dDtFinal T NULL, CEmps C(3), ncarts N(12), numes N(8), datas T NULL, ;
                nlotecs C(10), fpags C(12), dopes C(20), valor N(13,2), ValLiq N(20,9), ;
                Taxas N(9,3), noresumos C(10), iclis C(10), rclis C(50) NULL, ;
                razas C(40) NULL, opcao I, cMovimento C(30), Vencs D NULL)
            SET NULL OFF

            *-- Obter nome da empresa (cNomeEmpre em cada linha do relatorio)
            loc_cNomeEmpresa = ALLTRIM(go_4c_Sistema.cEmpresa)

            *-- Datas formatadas para SQL Server (inicio do dia / fim do dia)
            loc_cDtIniSQL = FormatarDataSQL(THIS.this_dDtInicial)
            loc_cDtFimSQL = "'" + ;
                            STR(YEAR(THIS.this_dDtFinal), 4) + "-" + ;
                            RIGHT("0" + TRANSFORM(MONTH(THIS.this_dDtFinal)), 2) + "-" + ;
                            RIGHT("0" + TRANSFORM(DAY(THIS.this_dDtFinal)), 2) + ;
                            " 23:59:59'"

            *-- DATETIME para filtros em SELECTs VFP nativos (secao Depositar)
            loc_dDtIni = CTOT(DTOC(THIS.this_dDtInicial))
            loc_dDtFim = CTOT(DTOC(THIS.this_dDtFinal) + " 23:59:59")

            *-- Filtros condicionais de empresa
            IF !EMPTY(THIS.this_cEmps)
                loc_cEmpresaWhereA = "a.emps = " + EscaparSQL(THIS.this_cEmps) + " AND "
                loc_cEmpresaWhereB = " AND b.emps = " + EscaparSQL(THIS.this_cEmps)
                loc_cEmpresaWhereD = " AND d.emps = " + EscaparSQL(THIS.this_cEmps)
            ELSE
                loc_cEmpresaWhereA = ""
                loc_cEmpresaWhereB = ""
                loc_cEmpresaWhereD = ""
            ENDIF

            *-- Filtros condicionais de cartao
            IF !EMPTY(THIS.this_cFpags)
                loc_cCartaoWhereB = " AND b.fpags = " + EscaparSQL(THIS.this_cFpags)
                loc_cCartaoWhereD = " AND d.fpags = " + EscaparSQL(THIS.this_cFpags)
            ELSE
                loc_cCartaoWhereB = ""
                loc_cCartaoWhereD = ""
            ENDIF

            *==================================================================
            *-- ENTRADAS (SigCdCar + SigCdCtt)
            *==================================================================
            IF THIS.this_lEntrada AND !loc_lAbortou
                loc_nOpMovimento = 1
                loc_cMovimento   = PADR("Entradas", 30)

                loc_cSQL = "SELECT " + EscaparSQL(loc_cNomeEmpresa) + " as cNomeEmpre," + ;
                           loc_cDtIniSQL + " as dDtInicial," + ;
                           loc_cDtFimSQL + " as dDtFinal," + ;
                           "a.emps as cemps,b.ncarts,a.numes,a.datas,a.nlotecs," + ;
                           "b.fpags,b.dopes,b.valos as valor," + ;
                           "(b.valos*(1-(b.taxas/100))) as ValLiq,b.taxas," + ;
                           "b.noresumos,b.iclis,b.Vencs,c.Rclis,e.razas," + ;
                           STR(loc_nOpMovimento, 1) + " as opcao," + ;
                           EscaparSQL(loc_cMovimento) + " as cMovimento " + ;
                           "FROM SigCdEmp e,SigCdCar a," + ;
                           "SigCdCtt b LEFT JOIN SigCdCli c ON c.Iclis=b.Iclis " + ;
                           "WHERE " + loc_cEmpresaWhereA + ;
                           "a.datas BETWEEN " + loc_cDtIniSQL + " AND " + loc_cDtFimSQL + ;
                           " AND a.emps=e.cemps" + ;
                           " AND a.emps=b.emps AND a.numes=b.numes" + ;
                           " AND a.Dopes=b.Dopes AND a.Nlotecs=b.Nlotecs" + ;
                           loc_cCartaoWhereB + ;
                           " ORDER BY a.emps,b.fpags,a.datas"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Listp1")
                IF loc_nResult > 0
                    SELECT cursor_4c_Listp1
                    GO TOP
                    SCAN
                        SCATTER MEMVAR
                        INSERT INTO cursor_4c_ListPro1 FROM MEMVAR
                        SELECT cursor_4c_Listp1
                    ENDSCAN
                    USE IN cursor_4c_Listp1
                ELSE
                    THIS.this_cMensagemErro = "Falha ao buscar Entradas"
                    loc_lAbortou = .T.
                ENDIF
            ENDIF

            *==================================================================
            IF THIS.this_lReceber AND !loc_lAbortou
                loc_nOpMovimento = 2
                loc_cMovimento   = PADR(CHR(192) + " Receber", 30)

                loc_cSQL = "SELECT " + EscaparSQL(loc_cNomeEmpresa) + " as cNomeEmpre," + ;
                           loc_cDtIniSQL + " as dDtInicial," + ;
                           loc_cDtFimSQL + " as dDtFinal," + ;
                           "d.emps as cemps,d.ncarts,d.numes,d.vencs as datas,d.nlotecs," + ;
                           "d.fpags,d.dopes,d.totres-d.totpar as valor," + ;
                           "((d.totres-d.totpar)*(1-(d.taxas/100))) as ValLiq,d.taxas," + ;
                           "d.noresumos,d.iclis,c.Rclis,e.razas," + ;
                           STR(loc_nOpMovimento, 1) + " as opcao," + ;
                           EscaparSQL(loc_cMovimento) + " as cMovimento " + ;
                           "FROM SigCdEmp e," + ;
                           "SigCdCrd d LEFT JOIN SigCdCli c ON c.Iclis=d.Iclis " + ;
                           "WHERE NOT (d.totres-d.totpar=0)" + ;
                           loc_cEmpresaWhereD + ;
                           loc_cCartaoWhereD + ;
                           " AND d.emps=e.cemps" + ;
                           " ORDER BY d.emps,d.fpags,d.vencs"

                IF USED("cursor_4c_TmpRec2")
                    USE IN cursor_4c_TmpRec2
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpRec2")
                IF loc_nResult > 0
                    SELECT cNomeEmpre, dDtInicial, dDtFinal, cemps, ;
                           ncarts, numes, datas, nlotecs, fpags, dopes, valor, ValLiq, ;
                           taxas, noresumos, iclis, Rclis, razas, opcao, cMovimento ;
                        FROM cursor_4c_TmpRec2 ;
                        WHERE datas BETWEEN m.loc_dDtIni AND m.loc_dDtFim ;
                        INTO CURSOR cursor_4c_Listp2 ;
                        ORDER BY cemps, fpags, datas
                    USE IN cursor_4c_TmpRec2
                    SELECT cursor_4c_Listp2
                    GO TOP
                    SCAN
                        SCATTER MEMVAR
                        INSERT INTO cursor_4c_ListPro2 FROM MEMVAR
                        SELECT cursor_4c_Listp2
                    ENDSCAN
                    USE IN cursor_4c_Listp2
                ELSE
                    THIS.this_cMensagemErro = "Falha ao buscar " + CHR(192) + " Receber"
                    loc_lAbortou = .T.
                ENDIF
            ENDIF

            *==================================================================
            *-- A DEPOSITAR (SigCdCtt + SigOpFp - ainda nao depositados)
            *==================================================================
            IF THIS.this_lDepositar AND !loc_lAbortou
                loc_nOpMovimento = 3
                loc_cMovimento   = PADR(CHR(192) + " Depositar", 30)

                *-- SQL base: busca dados com colunas extras Parcs e prazos
                *-- NOT EXISTS filtra apenas transacoes ainda nao no SigCdCrd
                loc_cSQL = "SELECT " + EscaparSQL(loc_cNomeEmpresa) + " as cNomeEmpre," + ;
                           loc_cDtIniSQL + " as dDtInicial," + ;
                           loc_cDtFimSQL + " as dDtFinal," + ;
                           "b.emps as cemps,b.ncarts,b.numes,b.datas,b.Parcs,f.prazos," + ;
                           "b.nlotecs,b.fpags,b.dopes,b.valos as valor," + ;
                           "(b.valos*(1-(b.taxas/100))) as ValLiq,b.taxas," + ;
                           "b.noresumos,b.iclis,b.Vencs,c.Rclis,e.razas," + ;
                           STR(loc_nOpMovimento, 1) + " as opcao," + ;
                           EscaparSQL(loc_cMovimento) + " as cMovimento " + ;
                           "FROM SigCdEmp e,SigOpFp f," + ;
                           "SigCdCtt b LEFT JOIN SigCdCli c ON c.Iclis=b.Iclis " + ;
                           "WHERE b.Fpags=f.Fpags" + ;
                           loc_cEmpresaWhereB + ;
                           loc_cCartaoWhereB + ;
                           " AND b.emps=e.cemps" + ;
                           " AND NOT EXISTS (SELECT x.ncarts FROM SigCdCrd x" + ;
                           " WHERE x.ncarts=b.ncarts AND x.emps=b.emps)"

                IF USED("cursor_4c_TmpPro3")
                    USE IN cursor_4c_TmpPro3
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPro3")
                IF loc_nResult <= 0
                    THIS.this_cMensagemErro = "Falha ao buscar " + CHR(192) + " Depositar"
                    loc_lAbortou = .T.
                ELSE
                    *-- Sub-selecao VFP baseada no tipo de deposito escolhido
                    IF THIS.this_lDepPrev
                        *-- Opcao 2: data calculada por vencimento previsto
                        SELECT DISTINCT cNomeEmpre, dDtInicial, dDtFinal, cemps, ;
                               ncarts, numes, ;
                               (datas + IIF(!EMPTY(Parcs), Parcs, 1) * prazos) AS datas, ;
                               nlotecs, fpags, dopes, valor, ;
                               valor * IIF(taxas <> 0, (1-(taxas/100)), 1) AS ValLiq, ;
                               taxas, noresumos, iclis, Rclis, razas, opcao, ;
                               PADR(CHR(192) + " Depositar (Prev. Venc.)", 30) AS cMovimento ;
                            FROM cursor_4c_TmpPro3 ;
                            WHERE (datas + IIF(!EMPTY(Parcs), Parcs, 1) * prazos) ;
                                  BETWEEN m.loc_dDtIni AND m.loc_dDtFim ;
                            INTO CURSOR cursor_4c_Listp3 ;
                            ORDER BY cemps, fpags
                    ELSE
                        *-- Opcao 1: data real de entrada
                        SELECT DISTINCT cNomeEmpre, dDtInicial, dDtFinal, cemps, ;
                               ncarts, numes, datas, nlotecs, fpags, dopes, valor, ValLiq, ;
                               taxas, noresumos, iclis, Rclis, razas, opcao, ;
                               PADR(CHR(192) + " Depositar", 30) AS cMovimento, Vencs ;
                            FROM cursor_4c_TmpPro3 ;
                            WHERE datas BETWEEN m.loc_dDtIni AND m.loc_dDtFim ;
                            INTO CURSOR cursor_4c_Listp3 ;
                            ORDER BY cemps, fpags, datas
                    ENDIF

                    SELECT cursor_4c_Listp3
                    GO TOP
                    SCAN
                        SCATTER MEMVAR
                        INSERT INTO cursor_4c_ListPro3 FROM MEMVAR
                        SELECT cursor_4c_Listp3
                    ENDSCAN
                    IF USED("cursor_4c_Listp3")
                        USE IN cursor_4c_Listp3
                    ENDIF
                    USE IN cursor_4c_TmpPro3
                ENDIF
            ENDIF

            *==================================================================
            *-- BAIXADOS (SigCdCrd - totalmente quitados: totres-totpar=0)
            *==================================================================
            IF THIS.this_lBaixa AND !loc_lAbortou
                loc_nOpMovimento = 4
                loc_cMovimento   = PADR("Baixados", 30)

                loc_cSQL = "SELECT " + EscaparSQL(loc_cNomeEmpresa) + " as cNomeEmpre," + ;
                           loc_cDtIniSQL + " as dDtInicial," + ;
                           loc_cDtFimSQL + " as dDtFinal," + ;
                           "d.emps as cemps,d.ncarts,d.numes,d.vencs as datas,d.nlotecs," + ;
                           "d.fpags,d.dopes,d.totres as valor," + ;
                           "(d.totres*(1-(d.taxas/100))) as ValLiq,d.taxas," + ;
                           "d.noresumos,d.iclis,c.Rclis,e.razas," + ;
                           STR(loc_nOpMovimento, 1) + " as opcao," + ;
                           EscaparSQL(loc_cMovimento) + " as cMovimento " + ;
                           "FROM SigCdEmp e," + ;
                           "SigCdCrd d LEFT JOIN SigCdCli c ON c.Iclis=d.Iclis " + ;
                           "WHERE (d.totres-d.totpar=0)" + ;
                           loc_cEmpresaWhereD + ;
                           loc_cCartaoWhereD + ;
                           " AND d.emps=e.cemps" + ;
                           " ORDER BY d.emps,d.fpags,d.vencs"

                IF USED("cursor_4c_TmpRec4")
                    USE IN cursor_4c_TmpRec4
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpRec4")
                IF loc_nResult > 0
                    SELECT cNomeEmpre, dDtInicial, dDtFinal, cemps, ;
                           ncarts, numes, datas, nlotecs, fpags, dopes, valor, ValLiq, ;
                           taxas, noresumos, iclis, Rclis, razas, opcao, cMovimento ;
                        FROM cursor_4c_TmpRec4 ;
                        WHERE datas BETWEEN m.loc_dDtIni AND m.loc_dDtFim ;
                        INTO CURSOR cursor_4c_Listp4 ;
                        ORDER BY cemps, fpags, datas
                    USE IN cursor_4c_TmpRec4
                    SELECT cursor_4c_Listp4
                    GO TOP
                    SCAN
                        SCATTER MEMVAR
                        INSERT INTO cursor_4c_ListPro4 FROM MEMVAR
                        SELECT cursor_4c_Listp4
                    ENDSCAN
                    USE IN cursor_4c_Listp4
                ELSE
                    THIS.this_cMensagemErro = "Falha ao buscar Baixados"
                    loc_lAbortou = .T.
                ENDIF
            ENDIF

            *==================================================================
            *-- UNION ALL: consolida todos os tipos em cursor final do relatorio
            *==================================================================
            IF !loc_lAbortou AND ( THIS.this_lEntrada OR THIS.this_lReceber OR ;
               THIS.this_lDepositar OR THIS.this_lBaixa )
                SELECT ;
                    cNomeEmpre, dDtInicial, dDtFinal, CEmps, ncarts, numes, ;
                    datas, nlotecs, fpags, dopes, valor, ValLiq, Taxas, ;
                    noresumos, iclis, rclis, razas, opcao, cMovimento, Vencs ;
                    FROM cursor_4c_ListPro1 ;
                UNION ALL ;
                SELECT ;
                    cNomeEmpre, dDtInicial, dDtFinal, CEmps, ncarts, numes, ;
                    datas, nlotecs, fpags, dopes, valor, ValLiq, Taxas, ;
                    noresumos, iclis, rclis, razas, opcao, cMovimento, Vencs ;
                    FROM cursor_4c_ListPro2 ;
                UNION ALL ;
                SELECT ;
                    cNomeEmpre, dDtInicial, dDtFinal, CEmps, ncarts, numes, ;
                    datas, nlotecs, fpags, dopes, valor, ValLiq, Taxas, ;
                    noresumos, iclis, rclis, razas, opcao, cMovimento, Vencs ;
                    FROM cursor_4c_ListPro3 ;
                UNION ALL ;
                SELECT ;
                    cNomeEmpre, dDtInicial, dDtFinal, CEmps, ncarts, numes, ;
                    datas, nlotecs, fpags, dopes, valor, ValLiq, Taxas, ;
                    noresumos, iclis, rclis, razas, opcao, cMovimento, Vencs ;
                    FROM cursor_4c_ListPro4 ;
                INTO CURSOR (loc_cCursorNome) READWRITE ;
                ORDER BY razas
            ENDIF

            *-- Limpar cursores de trabalho intermediarios
            IF USED("cursor_4c_ListPro1")
                USE IN cursor_4c_ListPro1
            ENDIF
            IF USED("cursor_4c_ListPro2")
                USE IN cursor_4c_ListPro2
            ENDIF
            IF USED("cursor_4c_ListPro3")
                USE IN cursor_4c_ListPro3
            ENDIF
            IF USED("cursor_4c_ListPro4")
                USE IN cursor_4c_ListPro4
            ENDIF

            loc_lSucesso = !loc_lAbortou
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros a partir de um cursor de parametros salvos
    * Em REPORT BOs nao ha persistencia de registro, mas o framework pode chamar
    * este metodo para repopular os filtros desde um cursor de "ultimo uso".
    * par_cAliasCursor: alias do cursor com as colunas dos filtros
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF VARTYPE(par_cAliasCursor) != "C" OR EMPTY(par_cAliasCursor)
                THIS.this_cMensagemErro = "Alias do cursor invalido"
            ELSE
                IF !USED(par_cAliasCursor)
                    THIS.this_cMensagemErro = "Cursor " + par_cAliasCursor + " nao esta aberto"
                ELSE
                    SELECT (par_cAliasCursor)
                    IF !EOF()
                        IF TYPE(par_cAliasCursor + ".dDtInicial") = "D" OR ;
                           TYPE(par_cAliasCursor + ".dDtInicial") = "T"
                            THIS.this_dDtInicial = TratarNulo(EVALUATE(par_cAliasCursor + ".dDtInicial"), "D")
                        ENDIF
                        IF TYPE(par_cAliasCursor + ".dDtFinal") = "D" OR ;
                           TYPE(par_cAliasCursor + ".dDtFinal") = "T"
                            THIS.this_dDtFinal = TratarNulo(EVALUATE(par_cAliasCursor + ".dDtFinal"), "D")
                        ENDIF
                        IF TYPE(par_cAliasCursor + ".cemps") = "C"
                            THIS.this_cEmps = TratarNulo(EVALUATE(par_cAliasCursor + ".cemps"), "C")
                        ENDIF
                        IF TYPE(par_cAliasCursor + ".razas") = "C"
                            THIS.this_cRazas = TratarNulo(EVALUATE(par_cAliasCursor + ".razas"), "C")
                        ENDIF
                        IF TYPE(par_cAliasCursor + ".fpags") = "C"
                            THIS.this_cFpags = TratarNulo(EVALUATE(par_cAliasCursor + ".fpags"), "C")
                        ENDIF
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "Cursor vazio"
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Bloqueado em REPORT BO (RelatorioBase nao persiste registros).
    * Mantido para satisfazer contratos genericos do framework.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: " + ALLTRIM(THIS.this_cTituloRelatorio) + " " + ;
            CHR(233) + " um relat" + CHR(243) + "rio (sem persist" + CHR(234) + "ncia)."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Bloqueado em REPORT BO (RelatorioBase nao persiste registros).
    * Mantido para satisfazer contratos genericos do framework.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: " + ALLTRIM(THIS.this_cTituloRelatorio) + " " + ;
            CHR(233) + " um relat" + CHR(243) + "rio (sem persist" + CHR(234) + "ncia)."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - REPORT BO nao tem chave primaria de registro.
    * Devolve uma assinatura unica para fins de auditoria (titulo+periodo).
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ALLTRIM(THIS.this_cTituloRelatorio)
        IF !EMPTY(THIS.this_dDtInicial)
            loc_cChave = loc_cChave + "|" + DTOC(THIS.this_dDtInicial)
        ENDIF
        IF !EMPTY(THIS.this_dDtFinal)
            loc_cChave = loc_cChave + "|" + DTOC(THIS.this_dDtFinal)
        ENDIF
        IF !EMPTY(THIS.this_cEmps)
            loc_cChave = loc_cChave + "|emp:" + ALLTRIM(THIS.this_cEmps)
        ENDIF
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra a execucao do relatorio em LogAuditoria.
    * Override de RelatorioBase para gravar acao real (impressao/visualizacao).
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cOperacao
        loc_lSucesso = .F.
        loc_cOperacao = IIF(VARTYPE(par_cOperacao) = "C" AND !EMPTY(par_cOperacao), ;
                            par_cOperacao, "VISUALIZAR")
        TRY
            loc_cSQL = "INSERT INTO LogAuditoria (Operacao, Tabela, ChavePrimaria, Usuario, DataHora, Detalhes) " + ;
                       "VALUES (" + ;
                       EscaparSQL(loc_cOperacao) + "," + ;
                       EscaparSQL("RELATORIO_CARTOES") + "," + ;
                       EscaparSQL(THIS.ObterChavePrimaria()) + "," + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
                       "GETDATE()," + ;
                       EscaparSQL(ALLTRIM(THIS.this_cTituloRelatorio)) + ")"
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao registrar auditoria"
            ENDIF
        CATCH TO loc_oErro
            *-- Auditoria nao deve bloquear o relatorio: apenas registra erro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Cartoes")
            USE IN cursor_4c_Cartoes
        ENDIF
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

