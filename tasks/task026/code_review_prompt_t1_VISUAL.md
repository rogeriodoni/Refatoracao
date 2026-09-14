# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [GRID-HEADER] Header Caption 'Tipo de Operação' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Descrs. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'SelTudo' (parent: SIGREADS): Top original=213 vs migrado 'cmd_4c_SelTudo' Top=128 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'apaga' (parent: SIGREADS): Top original=253 vs migrado 'cmd_4c_Apaga' Top=168 (diff=85px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREADS.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1779 linhas total):

*-- Linhas 14 a 22:
14: *   - Tipo Varia" + CHR(231) + CHR(227) + "o  (Desconto / Acr" + CHR(233) + "scimo / Ambos / Geral)
15: *   - Tipo Impress" + CHR(227) + "o (Sint" + CHR(233) + "tico / Anal" + CHR(237) + "tico / Resumo)
16: *   - Observa" + CHR(231) + CHR(245) + "es    (Sim / N" + CHR(227) + "o)
17: *   - Grid de tipos de opera" + CHR(231) + CHR(227) + "o (GrdTipo com checkbox + descri" + CHR(231) + CHR(227) + "o)
18: *
19: * FASE 3/8 - Estrutura Base
20: *   * Propriedades visuais (EXATAS do original: Width=800, Height=500)
21: *   * Init() / InicializarForm() / Destroy()
22: *   * ConfigurarCabecalho()  - cabe" + CHR(231) + "alho escuro com t" + CHR(237) + "tulo

*-- Linhas 63 a 71:
63:         loc_lSucesso   = .F.
64:         loc_lContinuar = .T.
65:         TRY
66:             THIS.Caption = "Relat" + CHR(243) + "rio de Apura" + CHR(231) + CHR(227) + "o de Descontos/Acr" + CHR(233) + "scimos"
67: 
68:             IF TYPE("gc_4c_CaminhoIcones") = "U"
69:                 gc_4c_CaminhoIcones = ""
70:             ENDIF
71:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 106 a 115:
106:                 *-- PageFrame com 1 pagina ("Filtros") - agrupa os campos de filtro
107:                 THIS.ConfigurarPageFrame()
108: 
109:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
110:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
111: 
112:                 *-- Grid de tipos de opera" + CHR(231) + CHR(227) + "o + bot" + CHR(245) + "es SelTudo/Apaga
113:                 *-- (em forms REPORT, ConfigurarPaginaLista monta a "p" + CHR(225) + "gina de sele" + CHR(231) + CHR(227) + "o" -
114:                 *--  equivalente ao papel da Page1/Lista em forms CRUD)
115:                 THIS.ConfigurarPaginaLista()

*-- Linhas 140 a 179:
140:     PROTECTED PROCEDURE ConfigurarCabecalho()
141:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
142:         WITH THIS.cnt_4c_Cabecalho
143:             .Top        = 0
144:             .Left       = 0
145:             .Width      = THIS.Width
146:             .Height     = 80
147:             .BackColor  = RGB(100, 100, 100)
148:             .BackStyle  = 1
149:             .BorderWidth = 0
150:             .Visible    = .T.
151:         ENDWITH
152: 
153:         *-- Sombra (texto ligeiramente deslocado para efeito 3D)
154:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
155:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
156:             .Top       = 17
157:             .Left      = 12
158:             .AutoSize  = .T.
159:             .Caption   = "Relat" + CHR(243) + "rio de Apura" + CHR(231) + CHR(227) + "o de Descontos/Acr" + CHR(233) + "scimos"
160:             .FontName  = "Tahoma"
161:             .FontSize  = 14
162:             .FontBold  = .T.
163:             .ForeColor = RGB(0, 0, 0)
164:             .BackStyle = 0
165:             .Visible   = .T.
166:         ENDWITH
167: 
168:         *-- T" + CHR(237) + "tulo principal (texto branco sobre fundo escuro)
169:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
170:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
171:             .Top       = 20
172:             .Left      = 10
173:             .AutoSize  = .T.
174:             .Caption   = "Relat" + CHR(243) + "rio de Apura" + CHR(231) + CHR(227) + "o de Descontos/Acr" + CHR(233) + "scimos"
175:             .FontName  = "Tahoma"
176:             .FontSize  = 14
177:             .FontBold  = .T.
178:             .ForeColor = RGB(255, 255, 255)
179:             .BackStyle = 0

*-- Linhas 191 a 200:
191:     PROTECTED PROCEDURE ConfigurarBotoes()
192:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
193:         WITH THIS.cmg_4c_Botoes
194:             .Top           = 0
195:             .Left          = 527
196:             .Width         = 273
197:             .Height        = 80
198:             .ButtonCount   = 4
199:             .BackStyle     = 0
200:             .BorderStyle   = 0

*-- Linhas 206 a 218:
206: 
207:         *-- Bot" + CHR(227) + "o 1: Visualizar
208:         WITH THIS.cmg_4c_Botoes.Buttons(1)
209:             .Top             = 5
210:             .Left            = 5
211:             .Width           = 65
212:             .Height          = 70
213:             .Caption         = "Visualizar"
214:             .Picture         = gc_4c_CaminhoIcones + "ideo.jpg"
215:             .PicturePosition = 13
216:             .FontName        = "Tahoma"
217:             .FontBold        = .T.
218:             .FontItalic      = .T.

*-- Linhas 227 a 239:
227: 
228:         *-- Bot" + CHR(227) + "o 2: Imprimir
229:         WITH THIS.cmg_4c_Botoes.Buttons(2)
230:             .Top             = 5
231:             .Left            = 71
232:             .Width           = 65
233:             .Height          = 70
234:             .Caption         = "Imprimir"
235:             .Picture         = gc_4c_CaminhoIcones + "impressora.jpg"
236:             .PicturePosition = 13
237:             .FontName        = "Tahoma"
238:             .FontBold        = .T.
239:             .FontItalic      = .T.

*-- Linhas 248 a 260:
248: 
249:         *-- Bot" + CHR(227) + "o 3: Excel
250:         WITH THIS.cmg_4c_Botoes.Buttons(3)
251:             .Top             = 5
252:             .Left            = 137
253:             .Width           = 65
254:             .Height          = 70
255:             .Caption         = "Excel"
256:             .Picture         = gc_4c_CaminhoIcones + "excel.jpg"
257:             .PicturePosition = 13
258:             .FontName        = "Tahoma"
259:             .FontBold        = .T.
260:             .FontItalic      = .T.

*-- Linhas 269 a 281:
269: 
270:         *-- Bot" + CHR(227) + "o 4: Encerrar (Cancel=.T. para ESC fechar)
271:         WITH THIS.cmg_4c_Botoes.Buttons(4)
272:             .Top             = 5
273:             .Left            = 203
274:             .Width           = 65
275:             .Height          = 70
276:             .Caption         = "Encerrar"
277:             .Picture         = gc_4c_CaminhoIcones + "otao_encerrar.jpg"
278:             .PicturePosition = 13
279:             .FontName        = "Tahoma"
280:             .FontBold        = .T.
281:             .FontItalic      = .T.

*-- Linhas 316 a 331:
316:         loc_oPgf.PageCount = 1
317: 
318:         *-- Posicionamento: logo abaixo do cabecalho (80px) ate o fim do form
319:         loc_oPgf.Top    = 85
320:         loc_oPgf.Left   = -1
321:         loc_oPgf.Width  = THIS.Width + 2
322:         loc_oPgf.Height = THIS.Height - 85
323:         loc_oPgf.Tabs   = .F.
324: 
325:         *-- Configurar Page1 (referencia direta - sem WITH para evitar problemas)
326:         loc_oPgf.Page1.Caption   = "Filtros"
327:         loc_oPgf.Page1.FontName  = "Tahoma"
328:         loc_oPgf.Page1.FontSize  = 8
329:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
330:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
331:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 339 a 347:
339:     *
340:     *   Em forms REPORT, a "p" + CHR(225) + "gina de lista" corresponde " + CHR(224) + " p" + CHR(225) + "gina de filtros que cont" + CHR(233) + "m:
341:     *     - Label do t" + CHR(237) + "tulo "Tipo de Opera" + CHR(231) + CHR(227) + "o :" (Label1 original, top=194,left=180)
342:     *     - Grid de tipos de opera" + CHR(231) + CHR(227) + "o com checkbox de sele" + CHR(231) + CHR(227) + "o (GrdTipo original)
343:     *     - Bot" + CHR(227) + "o "Sel. Todos" (SelTudo original, top=213,left=560)
344:     *     - Bot" + CHR(227) + "o "Nenhum" (apaga original, top=253,left=560)
345:     *
346:     *   Cabe" + CHR(231) + "alho ocupa os 85 pixels superiores (cabecalho + cmg_4c_Botoes),
347:     *   ent" + CHR(227) + "o todos os Tops dos controles internos da Page1 s" + CHR(227) + "o subtra" + CHR(237) + "dos de 85.

*-- Linhas 359 a 373:
359:         loc_cCursor = THIS.this_oRelatorio.this_cCursorTipos
360: 
361:         *-- Label acima do grid (Label1 original: top=194, left=180, width=94)
362:         loc_oPagina.AddObject("lbl_4c_TipoOpe", "Label")
363:         WITH loc_oPagina.lbl_4c_TipoOpe
364:             .Top       = 109
365:             .Left      = 180
366:             .Width     = 94
367:             .Height    = 15
368:             .Caption   = "Tipo de Opera" + CHR(231) + CHR(227) + "o :"
369:             .FontName  = "Tahoma"
370:             .FontSize  = 8
371:             .ForeColor = RGB(90, 90, 90)
372:             .BackStyle = 0
373:             .Visible   = .T.

*-- Linhas 386 a 395:
386:         loc_oGrid.ColumnCount = 2
387: 
388:         WITH loc_oGrid
389:             .Top                = 110
390:             .Left               = 277
391:             .Width              = 279
392:             .Height             = 110
393:             .RecordMark         = .F.
394:             .DeleteMark         = .F.
395:             .GridLineColor      = RGB(238, 238, 238)

*-- Linhas 402 a 419:
402:             .FontSize           = 8
403:         ENDWITH
404: 
405:         *-- Column1: CheckBox para Marca (sele" + CHR(231) + CHR(227) + "o do tipo)
406:         *-- REGRA: AddObject ANTES de CurrentControl; ControlSource DEPOIS de CurrentControl
407:         WITH loc_oGrid.Column1
408:             .Width = 25
409:             .AddObject("Check1", "CheckBox")
410:             .Check1.Caption = ""
411:             .Check1.Value   = 0
412:             .CurrentControl = "Check1"
413:             .ControlSource  = loc_cCursor + ".Marca"
414:             .Header1.Caption = ""
415:         ENDWITH
416: 
417:         *-- Column2: Descri" + CHR(231) + CHR(227) + "o do tipo de opera" + CHR(231) + CHR(227) + "o (read-only)
418:         WITH loc_oGrid.Column2
419:             .Width         = 250

*-- Linhas 428 a 491:
428:         loc_oGrid.RecordSource = loc_cCursor
429: 
430:         *-- Reconfigurar headers APOS RecordSource (RecordSource reseta headers)
431:         loc_oGrid.Column1.Header1.Caption = ""
432:         loc_oGrid.Column2.Header1.Caption = "Tipo de Opera" + CHR(231) + CHR(227) + "o"
433:         loc_oGrid.Column2.Header1.FontName = "Tahoma"
434:         loc_oGrid.Column2.Header1.FontSize = 8
435: 
436:         loc_oGrid.Visible = .T.
437: 
438:         *-- Bot" + CHR(227) + "o SelTudo: seleciona todos (original SelTudo.When: replace all marca with 1)
439:         loc_oPagina.AddObject("cmd_4c_SelTudo", "CommandButton")
440:         WITH loc_oPagina.cmd_4c_SelTudo
441:             .Top           = 128
442:             .Left          = 560
443:             .Width         = 65
444:             .Height        = 25
445:             .Caption       = "Sel. Todos"
446:             .FontName      = "Tahoma"
447:             .FontSize      = 8
448:             .BackColor     = RGB(255, 255, 255)
449:             .ForeColor     = RGB(90, 90, 90)
450:             .Themes        = .F.
451:             .SpecialEffect = 0
452:             .MousePointer  = 15
453:             .Visible       = .T.
454:         ENDWITH
455: 
456:         *-- Bot" + CHR(227) + "o Apaga: desmarca todos (original apaga.Click: replace all marca with 0)
457:         loc_oPagina.AddObject("cmd_4c_Apaga", "CommandButton")
458:         WITH loc_oPagina.cmd_4c_Apaga
459:             .Top           = 168
460:             .Left          = 560
461:             .Width         = 65
462:             .Height        = 25
463:             .Caption       = "Nenhum"
464:             .FontName      = "Tahoma"
465:             .FontSize      = 8
466:             .BackColor     = RGB(255, 255, 255)
467:             .ForeColor     = RGB(90, 90, 90)
468:             .Themes        = .F.
469:             .SpecialEffect = 0
470:             .MousePointer  = 15
471:             .Visible       = .T.
472:         ENDWITH
473: 
474:         *-- BINDEVENTs (m" + CHR(233) + "todos PUBLIC por padr" + CHR(227) + "o em DEFINE CLASS)
475:         BINDEVENT(loc_oPagina.cmd_4c_SelTudo, "Click", THIS, "BtnSelTudoClick")
476:         BINDEVENT(loc_oPagina.cmd_4c_Apaga,   "Click", THIS, "BtnApagaClick")
477:     ENDPROC
478: 
479:     *--------------------------------------------------------------------------
480:     * BtnSelTudoClick - Seleciona todos os tipos de opera" + CHR(231) + CHR(227) + "o no grid
481:     *   Equivale ao SelTudo.When do original: replace all marca with 1
482:     *--------------------------------------------------------------------------
483:     PROCEDURE BtnSelTudoClick()
484:         LOCAL loc_cCursor
485:         TRY
486:             loc_cCursor = THIS.this_oRelatorio.this_cCursorTipos
487:             IF USED(loc_cCursor)
488:                 SELECT (loc_cCursor)
489:                 REPLACE ALL Marca WITH 1
490:                 GO TOP
491:                 THIS.pgf_4c_Paginas.Page1.grd_4c_TipoOps.Refresh()

*-- Linhas 536 a 768:
536:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
537: 
538:         *-- EMPRESA (original: lbl_Empresa top=110, Get_Empresa top=108, Get_Dempresa top=108)
539:         loc_oPagina.AddObject("lbl_4c_Empresa", "Label")
540:         WITH loc_oPagina.lbl_4c_Empresa
541:             .Top       = 25
542:             .Left      = 224
543:             .Width     = 50
544:             .Height    = 15
545:             .Caption   = "Empresa :"
546:             .FontName  = "Tahoma"
547:             .FontSize  = 8
548:             .ForeColor = RGB(90, 90, 90)
549:             .BackStyle = 0
550:             .Visible   = .T.
551:         ENDWITH
552: 
553:         loc_oPagina.AddObject("txt_4c_Empresa", "TextBox")
554:         WITH loc_oPagina.txt_4c_Empresa
555:             .Top       = 23
556:             .Left      = 277
557:             .Width     = 33
558:             .Height    = 23
559:             .Value     = ""
560:             .FontName  = "Tahoma"
561:             .FontSize  = 8
562:             .BackColor = RGB(255, 255, 255)
563:             .ForeColor = RGB(90, 90, 90)
564:             .Visible   = .T.
565:         ENDWITH
566: 
567:         loc_oPagina.AddObject("txt_4c_Dempresa", "TextBox")
568:         WITH loc_oPagina.txt_4c_Dempresa
569:             .Top       = 23
570:             .Left      = 312
571:             .Width     = 284
572:             .Height    = 23
573:             .Value     = ""
574:             .FontName  = "Tahoma"
575:             .FontSize  = 8
576:             .BackColor = RGB(255, 255, 255)
577:             .ForeColor = RGB(90, 90, 90)
578:             .Visible   = .T.
579:         ENDWITH
580: 
581:         *-- VENDEDOR (original: Say1 top=135, Get_Vended top=133, Get_Dvend top=133)
582:         *-- Get_Dvend.When original: habilitado quando Get_Vended estiver vazio
583:         loc_oPagina.AddObject("lbl_4c_Vended", "Label")
584:         WITH loc_oPagina.lbl_4c_Vended
585:             .Top       = 50
586:             .Left      = 219
587:             .Width     = 55
588:             .Height    = 15
589:             .Caption   = "Vendedor :"
590:             .FontName  = "Tahoma"
591:             .FontSize  = 8
592:             .ForeColor = RGB(90, 90, 90)
593:             .BackStyle = 0
594:             .Visible   = .T.
595:         ENDWITH
596: 
597:         loc_oPagina.AddObject("txt_4c_Vended", "TextBox")
598:         WITH loc_oPagina.txt_4c_Vended
599:             .Top       = 48
600:             .Left      = 277
601:             .Width     = 81
602:             .Height    = 23
603:             .Value     = ""
604:             .FontName  = "Tahoma"
605:             .FontSize  = 8
606:             .BackColor = RGB(255, 255, 255)
607:             .ForeColor = RGB(90, 90, 90)
608:             .Visible   = .T.
609:         ENDWITH
610: 
611:         loc_oPagina.AddObject("txt_4c_Dvend", "TextBox")
612:         WITH loc_oPagina.txt_4c_Dvend
613:             .Top       = 48
614:             .Left      = 360
615:             .Width     = 236
616:             .Height    = 23
617:             .Value     = ""
618:             .FontName  = "Tahoma"
619:             .FontSize  = 8
620:             .BackColor = RGB(255, 255, 255)
621:             .ForeColor = RGB(90, 90, 90)
622:             .Visible   = .T.
623:         ENDWITH
624: 
625:         *-- OPERACAO (original: lbl_dopes top=161, get_nm_operacao top=158)
626:         loc_oPagina.AddObject("lbl_4c_Operacao", "Label")
627:         WITH loc_oPagina.lbl_4c_Operacao
628:             .Top       = 76
629:             .Left      = 218
630:             .Width     = 56
631:             .Height    = 15
632:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
633:             .FontName  = "Tahoma"
634:             .FontSize  = 8
635:             .ForeColor = RGB(90, 90, 90)
636:             .BackStyle = 0
637:             .Visible   = .T.
638:         ENDWITH
639: 
640:         loc_oPagina.AddObject("txt_4c_Operacao", "TextBox")
641:         WITH loc_oPagina.txt_4c_Operacao
642:             .Top       = 73
643:             .Left      = 277
644:             .Width     = 150
645:             .Height    = 25
646:             .Value     = ""
647:             .FontName  = "Tahoma"
648:             .FontSize  = 8
649:             .BackColor = RGB(255, 255, 255)
650:             .ForeColor = RGB(90, 90, 90)
651:             .Visible   = .T.
652:         ENDWITH
653: 
654:         *-- MOEDA (original: Label6 top=321, getCmoeda top=318, getDmoeda top=318)
655:         *-- getDmoeda.When original: habilitado quando getCmoeda estiver vazio
656:         loc_oPagina.AddObject("lbl_4c_Moeda", "Label")
657:         WITH loc_oPagina.lbl_4c_Moeda
658:             .Top       = 236
659:             .Left      = 229
660:             .Width     = 45
661:             .Height    = 17
662:             .Caption   = "Moeda :"
663:             .FontName  = "Tahoma"
664:             .FontSize  = 8
665:             .ForeColor = RGB(90, 90, 90)
666:             .BackStyle = 0
667:             .Visible   = .T.
668:         ENDWITH
669: 
670:         loc_oPagina.AddObject("txt_4c_Cmoeda", "TextBox")
671:         WITH loc_oPagina.txt_4c_Cmoeda
672:             .Top       = 233
673:             .Left      = 277
674:             .Width     = 31
675:             .Height    = 25
676:             .Value     = ""
677:             .FontName  = "Tahoma"
678:             .FontSize  = 8
679:             .BackColor = RGB(255, 255, 255)
680:             .ForeColor = RGB(90, 90, 90)
681:             .Visible   = .T.
682:         ENDWITH
683: 
684:         loc_oPagina.AddObject("txt_4c_Dmoeda", "TextBox")
685:         WITH loc_oPagina.txt_4c_Dmoeda
686:             .Top       = 233
687:             .Left      = 313
688:             .Width     = 115
689:             .Height    = 25
690:             .Value     = ""
691:             .FontName  = "Tahoma"
692:             .FontSize  = 8
693:             .BackColor = RGB(255, 255, 255)
694:             .ForeColor = RGB(90, 90, 90)
695:             .Visible   = .T.
696:         ENDWITH
697: 
698:         *-- PERIODO (original: lbl_periodo top=347->262, get_dt_inicial top=345->260, get_dt_final top=345->260)
699:         *-- LostFocus de txt_4c_DtInicial copia valor para txt_4c_DtFinal (comportamento do legado)
700:         loc_oPagina.AddObject("lbl_4c_Periodo", "Label")
701:         WITH loc_oPagina.lbl_4c_Periodo
702:             .Top       = 262
703:             .Left      = 223
704:             .Width     = 51
705:             .Height    = 15
706:             .Caption   = "Per" + CHR(237) + "odo :"
707:             .FontName  = "Tahoma"
708:             .FontSize  = 8
709:             .ForeColor = RGB(90, 90, 90)
710:             .BackStyle = 0
711:             .Visible   = .T.
712:         ENDWITH
713: 
714:         loc_oPagina.AddObject("txt_4c_DtInicial", "TextBox")
715:         WITH loc_oPagina.txt_4c_DtInicial
716:             .Top       = 260
717:             .Left      = 277
718:             .Width     = 80
719:             .Height    = 23
720:             .Value     = {}
721:             .FontName  = "Tahoma"
722:             .FontSize  = 8
723:             .BackColor = RGB(255, 255, 255)
724:             .ForeColor = RGB(0, 0, 0)
725:             .Visible   = .T.
726:         ENDWITH
727: 
728:         loc_oPagina.AddObject("lbl_4c_PeriodoA", "Label")
729:         WITH loc_oPagina.lbl_4c_PeriodoA
730:             .Top       = 263
731:             .Left      = 361
732:             .Width     = 8
733:             .AutoSize  = .T.
734:             .Caption   = CHR(224)
735:             .FontName  = "Tahoma"
736:             .FontSize  = 8
737:             .BackStyle = 0
738:             .Visible   = .T.
739:         ENDWITH
740: 
741:         loc_oPagina.AddObject("txt_4c_DtFinal", "TextBox")
742:         WITH loc_oPagina.txt_4c_DtFinal
743:             .Top       = 260
744:             .Left      = 373
745:             .Width     = 80
746:             .Height    = 23
747:             .Value     = {}
748:             .FontName  = "Tahoma"
749:             .FontSize  = 8
750:             .BackColor = RGB(255, 255, 255)
751:             .ForeColor = RGB(0, 0, 0)
752:             .Visible   = .T.
753:         ENDWITH
754: 
755:         *-- TIPO VARIACAO (Opt_TipoVars original: top=371->286, left=272, width=316, buttoncount=4)
756:         *-- Say4 "Opcao :" original: top=373->288, left=234, width=40
757:         loc_oPagina.AddObject("lbl_4c_TipoVars", "Label")
758:         WITH loc_oPagina.lbl_4c_TipoVars
759:             .Top       = 288
760:             .Left      = 234
761:             .Width     = 40
762:             .Height    = 15
763:             .Caption   = "Op" + CHR(231) + CHR(227) + "o :"
764:             .FontName  = "Tahoma"
765:             .FontSize  = 8
766:             .ForeColor = RGB(90, 90, 90)
767:             .BackStyle = 0
768:             .Visible   = .T.

*-- Linhas 776 a 892:
776:             .SpecialEffect = 0
777:             .Themes        = .F.
778:             .Height        = 23
779:             .Left          = 272
780:             .Top           = 286
781:             .Width         = 316
782:             .Value         = 3
783:             .Visible       = .T.
784:         ENDWITH
785: 
786:         WITH loc_oPagina.obj_4c_TipoVars.Buttons(1)
787:             .Caption   = "Desconto"
788:             .FontName  = "Tahoma"
789:             .FontSize  = 8
790:             .BackStyle = 0
791:             .Left      = 5
792:             .Top       = 4
793:             .Width     = 78
794:             .Height    = 16
795:             .ForeColor = RGB(90, 90, 90)
796:         ENDWITH
797: 
798:         WITH loc_oPagina.obj_4c_TipoVars.Buttons(2)
799:             .Caption   = "Acr" + CHR(233) + "scimo"
800:             .FontName  = "Tahoma"
801:             .FontSize  = 8
802:             .BackStyle = 0
803:             .Left      = 85
804:             .Top       = 4
805:             .Width     = 78
806:             .Height    = 16
807:             .ForeColor = RGB(90, 90, 90)
808:         ENDWITH
809: 
810:         WITH loc_oPagina.obj_4c_TipoVars.Buttons(3)
811:             .Caption   = "Ambos"
812:             .FontName  = "Tahoma"
813:             .FontSize  = 8
814:             .BackStyle = 0
815:             .Left      = 165
816:             .Top       = 5
817:             .Width     = 68
818:             .Height    = 16
819:             .ForeColor = RGB(90, 90, 90)
820:         ENDWITH
821: 
822:         WITH loc_oPagina.obj_4c_TipoVars.Buttons(4)
823:             .Caption   = "Geral"
824:             .FontName  = "Tahoma"
825:             .FontSize  = 8
826:             .BackStyle = 0
827:             .Left      = 239
828:             .Top       = 4
829:             .Width     = 43
830:             .Height    = 15
831:             .ForeColor = RGB(90, 90, 90)
832:         ENDWITH
833: 
834:         *-- MARGEM (getMargem original: top=395->310, left=574, width=45, InputMask=99.99)
835:         *-- Say5 "Margem :" original: top=399->314, left=524, width=47
836:         *-- Say6 "%" original: top=399->314, left=620, width=13
837:         loc_oPagina.AddObject("lbl_4c_Margem", "Label")
838:         WITH loc_oPagina.lbl_4c_Margem
839:             .Top       = 314
840:             .Left      = 524
841:             .Width     = 47
842:             .Height    = 15
843:             .Caption   = "Margem :"
844:             .FontName  = "Tahoma"
845:             .FontSize  = 8
846:             .ForeColor = RGB(90, 90, 90)
847:             .BackStyle = 0
848:             .Visible   = .T.
849:         ENDWITH
850: 
851:         loc_oPagina.AddObject("txt_4c_Margem", "TextBox")
852:         WITH loc_oPagina.txt_4c_Margem
853:             .Top       = 310
854:             .Left      = 574
855:             .Width     = 45
856:             .Height    = 23
857:             .Value     = 0
858:             .InputMask = "99.99"
859:             .FontName  = "Tahoma"
860:             .FontSize  = 8
861:             .BackColor = RGB(255, 255, 255)
862:             .ForeColor = RGB(0, 0, 0)
863:             .Visible   = .T.
864:         ENDWITH
865: 
866:         loc_oPagina.AddObject("lbl_4c_MargemPct", "Label")
867:         WITH loc_oPagina.lbl_4c_MargemPct
868:             .Top       = 314
869:             .Left      = 620
870:             .Width     = 13
871:             .Height    = 15
872:             .Caption   = "%"
873:             .FontName  = "Tahoma"
874:             .FontSize  = 8
875:             .BackStyle = 0
876:             .Visible   = .T.
877:         ENDWITH
878: 
879:         *-- TIPO IMPRESSAO (optTipoRel original: top=396->311, left=272, width=244, buttoncount=3)
880:         *-- Say3 "Tipo de Impressao :" original: top=398->313, left=177, width=97
881:         loc_oPagina.AddObject("lbl_4c_TipoRel", "Label")
882:         WITH loc_oPagina.lbl_4c_TipoRel
883:             .Top       = 313
884:             .Left      = 177
885:             .Width     = 97
886:             .Height    = 15
887:             .Caption   = "Tipo de Impress" + CHR(227) + "o :"
888:             .FontName  = "Tahoma"
889:             .FontSize  = 8
890:             .ForeColor = RGB(90, 90, 90)
891:             .BackStyle = 0
892:             .Visible   = .T.

*-- Linhas 900 a 959:
900:             .SpecialEffect = 0
901:             .Themes        = .F.
902:             .Height        = 23
903:             .Left          = 272
904:             .Top           = 311
905:             .Width         = 244
906:             .Value         = 2
907:             .Visible       = .T.
908:         ENDWITH
909: 
910:         WITH loc_oPagina.obj_4c_TipoRel.Buttons(1)
911:             .Caption   = "Sint" + CHR(233) + "tico"
912:             .FontName  = "Tahoma"
913:             .FontSize  = 8
914:             .BackStyle = 0
915:             .Left      = 5
916:             .Top       = 3
917:             .Width     = 81
918:             .Height    = 16
919:             .ForeColor = RGB(90, 90, 90)
920:         ENDWITH
921: 
922:         WITH loc_oPagina.obj_4c_TipoRel.Buttons(2)
923:             .Caption   = "Anal" + CHR(237) + "tico"
924:             .FontName  = "Tahoma"
925:             .FontSize  = 8
926:             .BackStyle = 0
927:             .Left      = 85
928:             .Top       = 3
929:             .Width     = 85
930:             .Height    = 16
931:             .ForeColor = RGB(90, 90, 90)
932:         ENDWITH
933: 
934:         WITH loc_oPagina.obj_4c_TipoRel.Buttons(3)
935:             .Caption   = "Resumo"
936:             .FontName  = "Tahoma"
937:             .FontSize  = 8
938:             .BackStyle = 0
939:             .Left      = 165
940:             .Top       = 3
941:             .Width     = 66
942:             .Height    = 17
943:             .ForeColor = RGB(90, 90, 90)
944:         ENDWITH
945: 
946:         *-- OBSERVACOES (Opt_obs original: top=419->334, left=272, width=248, buttoncount=2)
947:         *-- Say2 "Obs :" original: top=421->336, left=247
948:         loc_oPagina.AddObject("lbl_4c_Obs", "Label")
949:         WITH loc_oPagina.lbl_4c_Obs
950:             .Top       = 336
951:             .Left      = 247
952:             .Height    = 15
953:             .AutoSize  = .T.
954:             .Caption   = "Obs :"
955:             .FontName  = "Tahoma"
956:             .FontSize  = 8
957:             .ForeColor = RGB(90, 90, 90)
958:             .BackStyle = 0
959:             .Visible   = .T.

*-- Linhas 967 a 1000:
967:             .SpecialEffect = 0
968:             .Themes        = .F.
969:             .Height        = 23
970:             .Left          = 272
971:             .Top           = 334
972:             .Width         = 248
973:             .Value         = 1
974:             .Visible       = .T.
975:         ENDWITH
976: 
977:         WITH loc_oPagina.obj_4c_Obs.Buttons(1)
978:             .Caption   = "Sim"
979:             .FontName  = "Tahoma"
980:             .FontSize  = 8
981:             .BackStyle = 0
982:             .Left      = 5
983:             .Top       = 4
984:             .Width     = 42
985:             .Height    = 16
986:             .ForeColor = RGB(90, 90, 90)
987:         ENDWITH
988: 
989:         WITH loc_oPagina.obj_4c_Obs.Buttons(2)
990:             .Caption   = "N" + CHR(227) + "o"
991:             .FontName  = "Tahoma"
992:             .FontSize  = 8
993:             .BackStyle = 0
994:             .Left      = 85
995:             .Top       = 4
996:             .Width     = 42
997:             .Height    = 16
998:             .ForeColor = RGB(90, 90, 90)
999:         ENDWITH
1000: 


### BO (C:\4c\projeto\app\classes\SIGREADSBO.prg):
*==============================================================================
* SIGREADSBO.PRG
* Business Object para Relatorio de Apuracao de Descontos/Acrescimos
*
* Form: FormSIGREADS
* Tabelas: SigMvCab, SigMvMov, SigCdCli, SigCdOpe, SigTempR
* Herda de: RelatorioBase
*==============================================================================

DEFINE CLASS SIGREADSBO AS RelatorioBase

    *-- Filtros de empresa
    this_cEmpresa        = ""    && codigo empresa (cEmps em SigCdEmp - Get_Empresa)
    this_cDEmpresa       = ""    && razao social empresa (Razas em SigCdEmp - Get_Dempresa)

    *-- Filtros de vendedor
    this_cVendedor       = ""    && codigo vendedor (Iclis em SigCdCli - Get_Vended)
    this_cDVendedor      = ""    && nome vendedor (Rclis em SigCdCli - Get_Dvend)

    *-- Filtro de operacao
    this_cNmOperacao     = ""    && codigo da operacao (Dopes em SigCdOpe - get_nm_operacao, max 20)

    *-- Filtros de periodo
    this_dDtInicial      = {}    && data inicial do periodo (get_dt_inicial)
    this_dDtFinal        = {}    && data final do periodo (get_dt_final)

    *-- Filtros de moeda
    this_cMoeda          = ""    && codigo moeda (CMoes em SigCdMoe - getCmoeda, max 3)
    this_cDMoeda         = ""    && descricao moeda (DMoes em SigCdMoe - getDmoeda, max 15)

    *-- Filtro de margem
    this_nMargem         = 0     && margem de tolerancia percentual (getMargem, formato 99.99)

    *-- Opcoes de relatorio
    this_nTipoVars       = 1     && tipo variacao: 1=Desconto, 2=Acrescimo, 3=Ambos, 4=Geral (Opt_TipoVars)
    this_nObs            = 0     && imprimir observacoes: 1=Sim, 0=Nao (Opt_obs)
    this_nTipoRel        = 2     && tipo relatorio: 1=Sintetico, 2=Analitico, 3=Resumo (optTipoRel)

    *-- Flags de acesso (fChecaAcesso)
    this_lTitulos        = .F.   && exibe titulos completos (fChecaAcesso 'SigReAds','TITULOS')
    this_lNomeVend       = .F.   && exibe nome do vendedor (fChecaAcesso 'SigReAds','NOMEVEND')

    *-- Dados auxiliares carregados no Init
    this_cGrPadVens      = ""    && GrPadVens de SigCdPam (grupo padrao de vendas para lookup de vendedor)

    *-- Cursores
    this_cCursorDados    = "csRelatorio"         && cursor principal de saida para REPORT FORM
    this_cCursorTipos    = "cursor_4c_TipoOps"   && cursor com tipos de operacao selecionados no grid
    this_cIdQuery        = ""                     && ID unico para cleanup de SigTempR no modo analitico

    *--------------------------------------------------------------------------
    * Init - Configura o BO e carrega flags de acesso
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cTabela     = "SigMvCab"
            THIS.this_cCampoChave = "Numes"
            THIS.this_lTitulos    = fChecaAcesso("SigReAds", "TITULOS")
            THIS.this_lNomeVend   = fChecaAcesso("SigReAds", "NOMEVEND")
            loc_lSucesso          = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC


    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametrosPadrao - Carrega valores iniciais de SigCdPam e empresa
    * Chamado pelo Form apos CREATEOBJECT para pre-preencher campos
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametrosPadrao()
        LOCAL loc_lSucesso, loc_nResult
        loc_lSucesso = .F.
        TRY
            *-- Carregar SigCdPam para moeda e grupo padrao de vendas
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 MoePadVens, GrPadVens FROM SigCdPam", ;
                "cursor_4c_SigrPam")
            IF loc_nResult > 0 AND !EOF("cursor_4c_SigrPam")
                SELECT cursor_4c_SigrPam
                THIS.this_cMoeda     = ALLTRIM(cursor_4c_SigrPam.MoePadVens)
                THIS.this_cGrPadVens = ALLTRIM(cursor_4c_SigrPam.GrPadVens)
            ENDIF
            IF USED("cursor_4c_SigrPam")
                USE IN cursor_4c_SigrPam
            ENDIF

            *-- Empresa e datas padrao
            THIS.this_cEmpresa   = go_4c_Sistema.cCodEmpresa
            THIS.this_dDtInicial = DATE()
            THIS.this_dDtFinal   = DATE()

            *-- Descricao da moeda padrao
            IF !EMPTY(THIS.this_cMoeda)
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 DMoes FROM SigCdMoe WHERE CMoes = " + ;
                    EscaparSQL(THIS.this_cMoeda), "cursor_4c_SigrMoe")
                IF loc_nResult > 0 AND !EOF("cursor_4c_SigrMoe")
                    SELECT cursor_4c_SigrMoe
                    THIS.this_cDMoeda = ALLTRIM(cursor_4c_SigrMoe.DMoes)
                ENDIF
                IF USED("cursor_4c_SigrMoe")
                    USE IN cursor_4c_SigrMoe
                ENDIF
            ENDIF

            *-- Descricao da empresa padrao
            IF !EMPTY(THIS.this_cEmpresa)
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 Razas FROM SigCdEmp WHERE cEmps = " + ;
                    EscaparSQL(THIS.this_cEmpresa), "cursor_4c_SigrEmpPad")
                IF loc_nResult > 0 AND !EOF("cursor_4c_SigrEmpPad")
                    SELECT cursor_4c_SigrEmpPad
                    THIS.this_cDEmpresa = ALLTRIM(cursor_4c_SigrEmpPad.Razas)
                ENDIF
                IF USED("cursor_4c_SigrEmpPad")
                    USE IN cursor_4c_SigrEmpPad
                ENDIF
            ENDIF

            *-- Valores padrao das opcoes (igual ao legado: TipoVars=3, TipoRel=2)
            THIS.this_nTipoVars = 3
            THIS.this_nTipoRel  = 2
            THIS.this_nObs      = 0
            THIS.this_nMargem   = 0

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarTiposOperacao - Carrega SigCdTom para cursor do grid de tipos
    * par_cCursorDestino: nome do cursor a criar (ex: cursor_4c_TipoOps)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarTiposOperacao(par_cCursorDestino)
        LOCAL loc_lSucesso, loc_nResult, loc_nMarca
        loc_lSucesso = .F.
        TRY
            IF USED(par_cCursorDestino)
                USE IN (par_cCursorDestino)
            ENDIF
            CREATE CURSOR (par_cCursorDestino) (Marca N(1), Codigos N(2), Descri C(40))
            INDEX ON Codigos TAG Codigos

            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Codigos, Descrs FROM SigCdTom ORDER BY Codigos", ;
                "cursor_4c_SigrTomTmp")
            IF loc_nResult > 0
                SELECT cursor_4c_SigrTomTmp
                SCAN
                    loc_nMarca = IIF(INLIST(cursor_4c_SigrTomTmp.Codigos, 4, 5), 1, 0)
                    INSERT INTO (par_cCursorDestino) (Marca, Codigos, Descri) ;
                        VALUES (loc_nMarca, cursor_4c_SigrTomTmp.Codigos, ;
                                ALLTRIM(STR(cursor_4c_SigrTomTmp.Codigos, 2)) + "-" + ;
                                ALLTRIM(cursor_4c_SigrTomTmp.Descrs))
                ENDSCAN
                USE IN cursor_4c_SigrTomTmp
            ENDIF

            SELECT (par_cCursorDestino)
            GO TOP
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarEmpresas - Carrega SigCdEmp (exceto oficiais) para lookup
    * par_cCursorDestino: nome do cursor a criar (ex: cursor_4c_SigrJanEmp)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarEmpresas(par_cCursorDestino)
        LOCAL loc_lSucesso, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED(par_cCursorDestino)
                USE IN (par_cCursorDestino)
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT cEmps, Razas, TipoNFs FROM SigCdEmp " + ;
                "WHERE NOT TipoNFs = 2 ORDER BY cEmps", ;
                par_cCursorDestino)
            IF loc_nResult > 0
                SELECT (par_cCursorDestino)
                INDEX ON cEmps TAG cEmps
                INDEX ON Razas TAG Razas
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa dados do relatorio de Descontos/Acrescimos
    * Equivale ao PROCEDURE processamento do legado (SIGREADS.SCX)
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso
        LOCAL loc_cEmpresa, loc_cOperacao, loc_cVendedor, loc_cMoedaOper
        LOCAL loc_cDtIniStr, loc_cDtFimStr, loc_cDtIniBase, loc_cDtFimBase
        LOCAL loc_nTipoVars, loc_nObs, loc_nTipoRel, loc_nMargem
        LOCAL loc_lAnalitico, loc_cIdQuery
        LOCAL loc_lcTitulo, loc_lcSubTit, loc_lcPeriodo, loc_lNomeVend, loc_cNmEmpresa
        LOCAL loc_cSQL, loc_nResult, loc_cWhere, loc_cNumOp, loc_cWhere1, loc_cWhere2
        LOCAL loc_cEmpDopNums, loc_cUniqueId, loc_nDif, loc_nRec
        LOCAL loc_nTotI1, loc_nTotI2, loc_nResto, loc_nRateio, loc_nVlVend
        LOCAL loc_nItnV, loc_nGerV, loc_cEmpV, loc_cVenV, loc_nNumV
        LOCAL loc_cEmpO, loc_cVenO, loc_nNumO, loc_nMarca

        loc_lSucesso = .F.
        TRY
            *-- 1. Ler filtros das propriedades THIS
            loc_cEmpresa   = ALLTRIM(THIS.this_cEmpresa)
            loc_cOperacao  = ALLTRIM(THIS.this_cNmOperacao)
            loc_cMoedaOper = ALLTRIM(THIS.this_cMoeda)
            loc_cVendedor  = ALLTRIM(THIS.this_cVendedor)
            loc_nTipoVars  = THIS.this_nTipoVars
            loc_nObs       = THIS.this_nObs
            loc_nTipoRel   = THIS.this_nTipoRel
            loc_nMargem    = THIS.this_nMargem
            loc_lAnalitico = (loc_nTipoRel # 1)

            *-- Formatar datas para SQL (DTOS retorna YYYYMMDD)
            loc_cDtIniBase = DTOS(THIS.this_dDtInicial)
            loc_cDtFimBase = DTOS(THIS.this_dDtFinal)
            loc_cDtIniStr  = "'" + SUBSTR(loc_cDtIniBase,1,4) + "-" + ;
                              SUBSTR(loc_cDtIniBase,5,2) + "-" + SUBSTR(loc_cDtIniBase,7,2) + "'"
            loc_cDtFimStr  = "'" + SUBSTR(loc_cDtFimBase,1,4) + "-" + ;
                              SUBSTR(loc_cDtFimBase,5,2) + "-" + SUBSTR(loc_cDtFimBase,7,2) + ;
                              " 23:59:59'"

            *-- 2. Textos do cabecalho
            loc_lcPeriodo = "PERIODO : " + DTOC(THIS.this_dDtInicial) + ;
                            " A " + DTOC(THIS.this_dDtFinal)
            IF THIS.this_lTitulos
                loc_lcTitulo  = "RELA" + CHR(199) + CHR(195) + "O DE APURA" + ;
                                CHR(199) + CHR(195) + "O DE DESCONTOS/ACR" + ;
                                CHR(201) + "SCIMOS"
                loc_lcSubTit  = "MOEDA : " + loc_cMoedaOper + " - " + ;
                                ALLTRIM(THIS.this_cDMoeda) + ;
                                IIF(!EMPTY(loc_nMargem), ;
                                    " - Margem : " + ALLTRIM(STR(loc_nMargem,5,2)) + "%", "")
                loc_lNomeVend = THIS.this_lNomeVend
            ELSE
                loc_lcTitulo  = "RAPDE"
                loc_lcSubTit  = loc_cMoedaOper + ;
                                IIF(!EMPTY(loc_nMargem), ;
                                    " - (" + ALLTRIM(STR(loc_nMargem,5,2)) + "%)", "")
                loc_lNomeVend = .F.
            ENDIF

            *-- 3. Nome da empresa
            loc_cNmEmpresa = loc_cEmpresa
            IF !EMPTY(loc_cEmpresa)
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 Razas FROM SigCdEmp WHERE cEmps = " + ;
                    EscaparSQL(loc_cEmpresa), "cursor_4c_SigrEmpRel")
                IF loc_nResult > 0 AND !EOF("cursor_4c_SigrEmpRel")
                    SELECT cursor_4c_SigrEmpRel
                    loc_cNmEmpresa = ALLTRIM(cursor_4c_SigrEmpRel.Razas)
                ENDIF
                IF USED("cursor_4c_SigrEmpRel")
                    USE IN cursor_4c_SigrEmpRel
                ENDIF
            ENDIF

            *-- 4. Cursor de cabecalho do relatorio
            IF USED("csCabecalho")
                USE IN csCabecalho
            ENDIF
            CREATE CURSOR csCabecalho (NomeEmp C(80), Titulo C(80), Titulo2 C(200), ;
                                        Titulo3 C(200), tObs N(1), Analitico L(1), ;
                                        NVend L(1), Titulos L(1))
            INSERT INTO csCabecalho ;
                (NomeEmp, Titulo, Titulo2, Titulo3, tObs, Analitico, NVend, Titulos) ;
                VALUES (loc_cNmEmpresa, loc_lcTitulo, loc_lcSubTit, loc_lcPeriodo, ;
                        loc_nObs, loc_lAnalitico, loc_lNomeVend, THIS.this_lTitulos)

            *-- 5. Limpar cursores de execucao anterior
            IF USED("csRelatorio")
                USE IN csRelatorio
            ENDIF
            IF USED("csProdutos")
                USE IN csProdutos
            ENDIF
            IF USED("csSqlEest")
                USE IN csSqlEest
            ENDIF
            IF USED("csSqlEest2")
                USE IN csSqlEest2
            ENDIF
            IF USED("TmpCsRelat")
                USE IN TmpCsRelat
            ENDIF
            IF USED("TmpCsRela2")
                USE IN TmpCsRela2
            ENDIF
            IF USED("csRelatorio1")
                USE IN csRelatorio1
            ENDIF

            *-- 6. Montar clausula de tipos de operacao selecionados no grid
            loc_cNumOp = ""
            IF EMPTY(loc_cOperacao) AND USED(THIS.this_cCursorTipos)
                SELECT (THIS.this_cCursorTipos)
                SCAN
                    IF Marca > 0
                        loc_cNumOp = loc_cNumOp + ;
                            IIF(!EMPTY(loc_cNumOp), " Or ", "(") + ;
                            "o.TipoOps = " + ALLTRIM(STR(Codigos, 2))
                    ENDIF
                ENDSCAN
                IF LEN(loc_cNumOp) > 1
                    loc_cNumOp = loc_cNumOp + ")"
                ENDIF
            ENDIF

            SET DECIMALS TO 2
            SET FIXED ON

            *-- 7. Query 1: SigMvCab+SigMvMov+SigCdCli+SigCdOpe (ValPres = 1 ou 3)
            loc_cWhere = IIF(!EMPTY(loc_cEmpresa), ;
                             "a.Emps = " + EscaparSQL(loc_cEmpresa) + " And ", "") + ;
                         "a.Emps = b.Emps And a.Dopes = b.Dopes And a.Numes = b.Numes And " + ;
                         "a.Datas Between " + loc_cDtIniStr + " And " + loc_cDtFimStr + " And " + ;
                         "a.Dopes = o.Dopes And " + ;
                         IIF(!EMPTY(loc_cOperacao), ;
                             "a.Dopes = " + EscaparSQL(loc_cOperacao) + " And ", "") + ;
                         IIF(!EMPTY(loc_cVendedor), ;
                             "a.Vends = " + EscaparSQL(loc_cVendedor) + " And ", "") + ;
                         "a.Vends = c.Iclis And " + ;
                         IIF(EMPTY(loc_cOperacao) AND !EMPTY(loc_cNumOp), ;
                             loc_cNumOp + " And ", "") + ;
                         "(o.ValPres = 1 Or o.ValPres = 3)"

            loc_cSQL = "Select a.Emps, a.Dopes, a.Numes, a.MascNum, a.Vends, c.Rclis, " + ;
                       "b.nSinals, b.ValItens, b.Moeds, a.Datas, " + ;
                       "b.ValTots, a.CodObs, a.Obses, a.Usuars " + ;
                       "From SigMvCab a, SigMvMov b, SigCdCli c, SigCdOpe o " + ;
                       "Where " + loc_cWhere

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "csSqlEest")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados (csSqlEest)"
                loc_lSucesso = .F.
            ENDIF

            *-- 8. VFP SELECT cotacao -> TmpCsRelat
            SELECT csSqlEest
            SELECT Emps, Dopes, Numes, MascNum, Vends, Rclis, Usuars, ;
                   SUM(IIF(nSinals < 0, -1, 1) * ValItens * ;
                       fBuscarCotacao(Moeds, Datas, gnConnHandle) / ;
                       fBuscarCotacao(loc_cMoedaOper, Datas, gnConnHandle)) as ValInis, ;
                   (ValTots * fBuscarCotacao(Moeds, Datas, gnConnHandle) / ;
                    fBuscarCotacao(loc_cMoedaOper, Datas, gnConnHandle)) as Valos, ;
                   CodObs, "CAB" as Tp, 1 as Soma ;
                   FROM csSqlEest ;
                   INTO CURSOR TmpCsRelat ;
                   GROUP BY Emps, Dopes, Numes, MascNum, Vends, Rclis, Usuars, 9, CodObs

            *-- 9. Query 2: SigMvCab+SigCdCli+SigCdOpe (NOT ValPres = 1 ou 3)
            loc_cWhere = IIF(!EMPTY(loc_cEmpresa), ;
                             "a.Emps = " + EscaparSQL(loc_cEmpresa) + " And ", "") + ;
                         "a.Datas Between " + loc_cDtIniStr + " And " + loc_cDtFimStr + " And " + ;
                         "Not a.Valvars = 0 And " + ;
                         "a.Dopes = o.Dopes And " + ;
                         IIF(!EMPTY(loc_cOperacao), ;
                             "a.Dopes = " + EscaparSQL(loc_cOperacao) + " And ", "") + ;
                         IIF(!EMPTY(loc_cVendedor), ;
                             "a.Vends = " + EscaparSQL(loc_cVendedor) + " And ", "") + ;
                         "a.Vends = c.Iclis And " + ;
                         IIF(EMPTY(loc_cOperacao) AND !EMPTY(loc_cNumOp), ;
                             loc_cNumOp + " And ", "") + ;
                         "Not (o.ValPres = 1 Or o.ValPres = 3)"

            loc_cSQL = "Select a.Emps, a.Dopes, a.Numes, a.MascNum, a.Vends, c.Rclis, " + ;
                       "a.ValInis, o.cMoes, a.Datas, " + ;
                       "a.Valos, a.CodObs, a.Obses, a.Usuars " + ;
                       "From SigMvCab a, SigCdCli c, SigCdOpe o " + ;
                       "Where " + loc_cWhere

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "csSqlEest2")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados (csSqlEest2)"
                loc_lSucesso = .F.
            ENDIF

            *-- 10. VFP SELECT cotacao -> TmpCsRela2
            SELECT csSqlEest2
            SELECT Emps, Dopes, Numes, MascNum, Vends, Rclis, Usuars, ;
                   SUM(ValInis * ;
                       IIF(EMPTY(cMoes), 1, fBuscarCotacao(cMoes, Datas, gnConnHandle)) / ;
                       fBuscarCotacao(loc_cMoedaOper, Datas, gnConnHandle)) as ValInis, ;
                   (Valos * ;
                    IIF(EMPTY(cMoes), 1, fBuscarCotacao(cMoes, Datas, gnConnHandle)) / ;
                    fBuscarCotacao(loc_cMoedaOper, Datas, gnConnHandle)) as Valos, ;
                   CodObs, "CAB" as Tp, 1 as Soma ;
                   FROM csSqlEest2 ;
                   INTO CURSOR TmpCsRela2 ;
                   GROUP BY Emps, Dopes, Numes, MascNum, Vends, Rclis, Usuars, 9, CodObs

            *-- 11. Condicoes de filtro por tipo de variacao
            loc_cWhere1 = IIF(loc_nTipoVars=1, ;
                              "ValInis > Valos Or (ValInis = 0 And Not Valos = 0)", ;
                          IIF(loc_nTipoVars=2, "ValInis < Valos Or ValInis = 0", ;
                          IIF(loc_nTipoVars=3, "Not ValInis = Valos", "0=0")))

            loc_cWhere2 = IIF(loc_nTipoVars=1, "ValInis > Valos", ;
                          IIF(loc_nTipoVars=2, "ValInis < Valos", ;
                          IIF(loc_nTipoVars=3, "Not ValInis = Valos", "0=0")))

            *-- 12. UNION ALL das duas selects -> csRelatorio1
            SELECT Emps, Dopes, Numes, MascNum, Vends, Rclis, ValInis, Valos, CodObs, ;
                   Tp, Soma, ;
                   SPACE(14) as CPros, 00000000000000 as CBars, ;
                   SPACE(40) as DPros, SPACE(1) as Opers, ;
                   000000.00 as Qtds, 00000.000000 as Units, ;
                   000000000.00 as Totas, 000000000.00 as DifVal, Usuars ;
                   FROM TmpCsRelat ;
                   WHERE &loc_cWhere1. ;
                   UNION ALL ;
            SELECT Emps, Dopes, Numes, MascNum, Vends, Rclis, ValInis, Valos, CodObs, ;
                   Tp, Soma, ;
                   SPACE(14) as CPros, 00000000000000 as CBars, ;
                   SPACE(40) as DPros, SPACE(1) as Opers, ;
                   000000.00 as Qtds, 00000.000000 as Units, ;
                   000000000.00 as Totas, 000000000.00 as DifVal, Usuars ;
                   FROM TmpCsRela2 ;
                   WHERE &loc_cWhere2. ;
                   INTO CURSOR csRelatorio1 ;
                   ORDER BY 1, 5, 2, 3, 11

            *-- 13. Cursor de observacoes unificado
            IF USED("TmpObses")
                USE IN TmpObses
            ENDIF
            SELECT Emps, Dopes, Numes, Obses FROM csSqlEest ;
            UNION ALL ;
            SELECT Emps, Dopes, Numes, Obses FROM csSqlEest2 ;
            INTO CURSOR TmpObses ;
            ORDER BY 1, 2, 3

            *-- 14. Left join observacoes -> csRelatorio READWRITE
            SELECT a.*, b.Obses FROM csRelatorio1 a ;
                               LEFT JOIN TmpObses b ;
                               ON a.Emps = b.Emps AND a.Dopes = b.Dopes AND ;
                                  a.Numes = b.Numes ;
                               INTO CURSOR csRelatorio READWRITE

            SELECT csRelatorio
            INDEX ON Emps + Dopes + STR(Numes, 6) TAG EmpDopNum
            INDEX ON Emps + Vends + Dopes + STR(Numes, 6) + Tp TAG VdDpNmTp

            *-- 15. Filtrar pela margem de tolerancia
            IF !EMPTY(loc_nMargem)
                SELECT csRelatorio
                SCAN
                    IF ABS(100 - ((Valos*100) / IIF(ValInis#0, ValInis, 1))) < loc_nMargem
                        DELETE
                    ENDIF
                ENDSCAN
            ENDIF

            *-- 16. Modo analitico: inserir cabecalhos em SigTempR e buscar produtos
            IF loc_lAnalitico
                loc_cIdQuery = SYS(2015)
                THIS.this_cIdQuery = loc_cIdQuery

                *-- Limpar registros anteriores desta query
                SQLEXEC(gnConnHandle, ;
                    "DELETE FROM SigTempR WHERE CIdQuerys = " + EscaparSQL(loc_cIdQuery))

                *-- Inserir cada cabecalho no SigTempR via SQL
                SELECT csRelatorio
                GO TOP
                SCAN
                    loc_cEmpDopNums = PADR(csRelatorio.Emps, 3) + ;
                                      PADR(csRelatorio.Dopes, 20) + ;
                                      STR(csRelatorio.Numes, 6)
                    loc_cUniqueId = SYS(2015)

                    loc_cSQL = "INSERT INTO SigTempR " + ;
                               "(Emps, Dopes, Numes, MascNum, CPros, Razas, Valors, Qtds, " + ;
                               "CodObs, Obss, EmpDopNums, CIdQuerys, CIdChaves, Contas) " + ;
                               "VALUES (" + ;
                               EscaparSQL(csRelatorio.Emps) + ", " + ;
                               EscaparSQL(csRelatorio.Dopes) + ", " + ;
                               TRANSFORM(csRelatorio.Numes) + ", " + ;
                               EscaparSQL(csRelatorio.MascNum) + ", " + ;
                               EscaparSQL(csRelatorio.Vends) + ", " + ;
                               EscaparSQL(csRelatorio.RClis) + ", " + ;
                               FormatarNumeroSQL(csRelatorio.Valos) + ", " + ;
                               FormatarNumeroSQL(csRelatorio.ValInis) + ", " + ;
                               EscaparSQL(csRelatorio.CodObs) + ", " + ;
                               EscaparSQL(csRelatorio.Obses) + ", " + ;
                               EscaparSQL(loc_cEmpDopNums) + ", " + ;
                               EscaparSQL(loc_cIdQuery) + ", " + ;
                               EscaparSQL(loc_cUniqueId) + ", " + ;
                               EscaparSQL(csRelatorio.Usuars) + ")"

                    SQLEXEC(gnConnHandle, loc_cSQL)
                    SELECT csRelatorio
                ENDSCAN

                *-- Buscar produtos de SigTempR + SigMvItn
                loc_cSQL = "Select a.Emps, a.Dopes, a.Numes, a.MascNum, a.CPros As Vends, " + ;
                           "a.Razas As RClis, a.Qtds As ValInis, a.Valors As Valos, " + ;
                           "a.CodObs, a.Obss as Obses, 'ITN' as Tp, 0 as Soma, " + ;
                           "b.CPros, b.CodBarras as CBars, b.DPros, b.Opers, b.Qtds, " + ;
                           "b.Totas As Units, b.Totas, 99999999.99 as DifVal, " + ;
                           "a.Contas as Usuars " + ;
                           "From SigTempR a, SigMvItn b " + ;
                           "Where a.EmpDopNums = b.EmpDopNums And a.CIdQuerys = " + ;
                           EscaparSQL(loc_cIdQuery)

                IF USED("csProdutos")
                    USE IN csProdutos
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "csProdutos")

                IF loc_nResult > 0
                    SELECT csProdutos
                    INDEX ON Emps + Dopes + STR(Numes, 6) TAG EmpDopNum
                    INDEX ON Emps + Vends + STR(Numes, 6) TAG EmpVenNum

                    *-- Calcular DifVal (diferenca real paga) por nota
                    SET ORDER TO EmpDopNum
                    REPLACE ALL DifVal WITH 0

                    SCAN
                        loc_nDif = 0
                        IF USED("crSigMvMov")
                            USE IN crSigMvMov
                        ENDIF
                        loc_cSQL = "SELECT ValtOts, Nsinals, ValItens FROM SigMvMov " + ;
                                   "WHERE EmpDopNums = " + ;
                                   EscaparSQL(csProdutos.Emps + csProdutos.Dopes + ;
                                              STR(csProdutos.Numes, 6))
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigMvMov") > 0
                            SELECT crSigMvMov
                            SCAN
                                loc_nDif = loc_nDif + crSigMvMov.Valtots - ;
                                           (crSigMvMov.Nsinals * crSigMvMov.Valitens)
                            ENDSCAN
                            USE IN crSigMvMov
                        ENDIF
                        REPLACE DifVal WITH loc_nDif IN csProdutos
                        SELECT csProdutos
                    ENDSCAN

                    *-- Calcular rateio de desconto/acrescimo por produto
                    SET ORDER TO EmpVenNum
                    GO TOP
                    DO WHILE !EOF()
                        loc_cEmpV  = csProdutos.Emps
                        loc_cVenV  = csProdutos.Vends
                        loc_nNumV  = csProdutos.Numes
                        loc_nTotI1 = 0
                        loc_nRec   = RECNO()
                        loc_nDif   = 0
                        loc_nItnV  = 0
                        loc_nGerV  = 0

                        SCAN WHILE csProdutos.Emps=loc_cEmpV AND ;
                                    csProdutos.Vends=loc_cVenV AND ;
                                    csProdutos.Numes=loc_nNumV
                            IF !INLIST(csProdutos.Cpros, ;
                                       PADR("CP",14), PADR("CR",14), ;
                                       PADR("C",14), PADR("E",14)) ;
                               AND csProdutos.Opers = "S"
                                loc_nItnV  = loc_nItnV + csProdutos.Totas
                                loc_nTotI1 = loc_nTotI1 + 1
                            ENDIF
                            loc_nGerV = loc_nGerV + csProdutos.Totas
                            loc_nDif  = IIF(EMPTY(loc_nDif), csProdutos.DifVal, loc_nDif)
                        ENDSCAN

                        loc_nResto = loc_nDif
                        IF loc_nGerV < 0
                            loc_nResto = ABS(loc_nResto)
                        ENDIF

                        loc_nTotI2 = 0
                        GO loc_nRec
                        SCAN WHILE csProdutos.Emps=loc_cEmpV AND ;
                                    csProdutos.Vends=loc_cVenV AND ;
                                    csProdutos.Numes=loc_nNumV
                            IF !INLIST(csProdutos.Cpros, ;
                                       PADR("CP",14), PADR("CR",14), ;
                                       PADR("C",14), PADR("E",14)) ;
                               AND csProdutos.Opers = "S"
                                loc_nTotI2 = loc_nTotI2 + 1
                                loc_nRateio = ROUND(loc_nDif * ;
                                    (csProdutos.Totas / IIF(loc_nItnV <> 0, loc_nItnV, 1)), 0)
                                IF loc_nTotI1 = loc_nTotI2
                                    loc_nVlVend = csProdutos.Totas + loc_nResto
                                ELSE
                                    loc_nVlVend = csProdutos.Totas + loc_nRateio
                                    loc_nResto  = loc_nResto - loc_nRateio
                                ENDIF
                                REPLACE Totas WITH loc_nVlVend IN csProdutos
                            ENDIF
                        ENDSCAN
                    ENDDO

                    *-- Inserir produtos processados no csRelatorio
                    SELECT csProdutos
                    SCAN
                        INSERT INTO csRelatorio ;
                            (Emps, Dopes, Numes, MascNum, Vends, Rclis, ;
                             ValInis, Valos, CodObs, Obses, Tp, Soma, ;
                             CPros, CBars, DPros, Opers, Qtds, Units, ;
                             Totas, DifVal, Usuars) ;
                            VALUES (csProdutos.Emps, csProdutos.Dopes, ;
                                    csProdutos.Numes, csProdutos.MascNum, ;
                                    csProdutos.Vends, csProdutos.RClis, ;
                                    0, 0, csProdutos.CodObs, csProdutos.Obses, ;
                                    csProdutos.Tp, csProdutos.Soma, ;
                                    csProdutos.CPros, csProdutos.CBars, ;
                                    csProdutos.DPros, csProdutos.Opers, ;
                                    csProdutos.Qtds, csProdutos.Units, ;
                                    csProdutos.Totas, csProdutos.DifVal, ;
                                    csProdutos.Usuars)
                    ENDSCAN
                ENDIF

                *-- Limpar SigTempR desta query
                SQLEXEC(gnConnHandle, ;
                    "DELETE FROM SigTempR WHERE CIdQuerys = " + EscaparSQL(loc_cIdQuery))
                THIS.this_cIdQuery = ""
            ENDIF

            *-- 17. Processar observacoes (marcar registros OB)
            IF loc_nObs = 1
                SELECT csRelatorio
                SET ORDER TO VdDpNmTp DESCENDING
                loc_cEmpO = ""
                loc_cVenO = ""
                loc_nNumO = 0
                SCAN
                    IF loc_cEmpO # csRelatorio.Emps OR ;
                       loc_cVenO # csRelatorio.Vends OR ;
                       loc_nNumO # csRelatorio.Numes
                        REPLACE Tp WITH "OB" + SUBS(csRelatorio.Tp, 1, 1) IN csRelatorio
                        loc_cEmpO = csRelatorio.Emps
                        loc_cVenO = csRelatorio.Vends
                        loc_nNumO = csRelatorio.Numes
                    ENDIF
                ENDSCAN
                SET ORDER TO VdDpNmTp ASCENDING
            ENDIF

            *-- 18. Modo Resumo: agregar por empresa
            IF loc_nTipoRel = 3
                IF USED("csTot1")
                    USE IN csTot1
                ENDIF
                IF USED("csTot2")
                    USE IN csTot2
                ENDIF

                SELECT Emps, COUNT(1) as TotSoma ;
                       FROM TmpCsRelat ;
                       GROUP BY Emps ;
                       INTO CURSOR csTot1
                INDEX ON Emps TAG Emps

                SELECT Emps, COUNT(1) as TotSoma ;
                       FROM TmpCsRela2 ;
                       GROUP BY Emps ;
                       INTO CURSOR csTot2
                INDEX ON Emps TAG Emps

                IF USED("csRelatorio")
                    USE IN csRelatorio
                ENDIF
                SELECT Emps, ;
                       SUM(ValInis) as ValInis, ;
                       SUM(Valos) as Valos, ;
                       SUM(IIF(ValInis > Valos, ValInis - Valos, 0)) as Desconto, ;
                       SUM(IIF(Valos > ValInis, Valos - ValInis, 0)) as Acrescimo, ;
                       SUM(Soma) as Soma, ;
                       0 as TotSoma ;
                       FROM csRelatorio ;
                       GROUP BY Emps ;
                       INTO CURSOR csRelatorio READWRITE

                SELECT csRelatorio
                SCAN
                    IF SEEK(csRelatorio.Emps, "csTot1", "Emps")
                        REPLACE TotSoma WITH TotSoma + csTot1.TotSoma IN csRelatorio
                    ENDIF
                    IF SEEK(csRelatorio.Emps, "csTot2", "Emps")
                        REPLACE TotSoma WITH TotSoma + csTot2.TotSoma IN csRelatorio
                    ENDIF
                ENDSCAN
            ENDIF

            *-- 19. Posicionar no inicio
            SELECT csRelatorio
            SET ORDER TO VdDpNmTp
            GOTO TOP

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirRelatorio - Executa REPORT FORM com dados preparados
    * par_lVisualizar: .T. = visualizar na tela, .F. = imprimir direto
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirRelatorio(par_lVisualizar)
        LOCAL loc_lSucesso, loc_cFrx
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                THIS.this_cMensagemErro = "Erro ao preparar dados para o relat" + CHR(243) + "rio"
                loc_lSucesso = .F.
            ENDIF

            IF !USED("csRelatorio") OR RECCOUNT("csRelatorio") = 0
                MsgAviso("Nenhum dado encontrado para os filtros selecionados.", ;
                         "Relat" + CHR(243) + "rio")
                loc_lSucesso = .T.
            ENDIF

            IF THIS.this_nTipoRel = 3
                loc_cFrx = "SigReAd2"
            ELSE
                loc_cFrx = "SigReAd1"
            ENDIF

            IF par_lVisualizar
                REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE
            ELSE
                REPORT FORM (loc_cFrx) TO PRINTER PROMPT NOCONSOLE
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega valores de filtro a partir de um cursor de preset
    * Permite restaurar parametros previamente salvos para reexecucao do relatorio
    * par_cAliasCursor: nome do cursor com colunas de filtro (formato preset)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        TRY
            loc_cAlias = par_cAliasCursor
            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor de preset nao disponivel: " + ;
                                          ALLTRIM(NVL(loc_cAlias, ""))
                loc_lSucesso = .F.
            ENDIF

            SELECT (loc_cAlias)
            IF EOF()
                THIS.this_cMensagemErro = "Cursor de preset vazio: " + loc_cAlias
                loc_lSucesso = .F.
            ENDIF

            *-- SCATTER MEMVAR para acessar colunas dinamicamente
            SCATTER MEMVAR

            IF TYPE("m.cEmpresa") = "C"
                THIS.this_cEmpresa = ALLTRIM(m.cEmpresa)
            ENDIF
            IF TYPE("m.cDEmpresa") = "C"
                THIS.this_cDEmpresa = ALLTRIM(m.cDEmpresa)
            ENDIF
            IF TYPE("m.cVendedor") = "C"
                THIS.this_cVendedor = ALLTRIM(m.cVendedor)
            ENDIF
            IF TYPE("m.cDVendedor") = "C"
                THIS.this_cDVendedor = ALLTRIM(m.cDVendedor)
            ENDIF
            IF TYPE("m.cNmOperacao") = "C"
                THIS.this_cNmOperacao = ALLTRIM(m.cNmOperacao)
            ENDIF
            IF TYPE("m.dDtInicial") = "D"
                THIS.this_dDtInicial = m.dDtInicial
            ENDIF
            IF TYPE("m.dDtFinal") = "D"
                THIS.this_dDtFinal = m.dDtFinal
            ENDIF
            IF TYPE("m.cMoeda") = "C"
                THIS.this_cMoeda = ALLTRIM(m.cMoeda)
            ENDIF
            IF TYPE("m.cDMoeda") = "C"
                THIS.this_cDMoeda = ALLTRIM(m.cDMoeda)
            ENDIF
            IF TYPE("m.nMargem") = "N"
                THIS.this_nMargem = m.nMargem
            ENDIF
            IF TYPE("m.nTipoVars") = "N"
                THIS.this_nTipoVars = m.nTipoVars
            ENDIF
            IF TYPE("m.nObs") = "N"
                THIS.this_nObs = m.nObs
            ENDIF
            IF TYPE("m.nTipoRel") = "N"
                THIS.this_nTipoRel = m.nTipoRel
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Gera o relatorio enviando para a impressora
    * Semantica para BO de relatorio: "inserir" = produzir documento impresso
    * Delega para ImprimirRelatorio(.F.) e registra auditoria de impressao
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_dDtInicial) OR EMPTY(THIS.this_dDtFinal)
                THIS.this_cMensagemErro = "Per" + CHR(237) + "odo (data inicial/final) " + ;
                                          " obrigat" + CHR(243) + "rio para gerar relat" + ;
                                          CHR(243) + "rio"
                loc_lSucesso = .F.
            ENDIF
            IF EMPTY(THIS.this_cMoeda)
                THIS.this_cMensagemErro = "Moeda obrigat" + CHR(243) + "ria para gerar relat" + ;
                                          CHR(243) + "rio"
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = THIS.ImprimirRelatorio(.F.)
            IF loc_lSucesso
                THIS.RegistrarAuditoria("IMPRESSAO")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Reprocessa os dados e exibe o relatorio em preview
    * Semantica para BO de relatorio: "atualizar" = recalcular e visualizar
    * Delega para ImprimirRelatorio(.T.) e registra auditoria de visualizacao
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_dDtInicial) OR EMPTY(THIS.this_dDtFinal)
                THIS.this_cMensagemErro = "Per" + CHR(237) + "odo (data inicial/final) " + ;
                                          " obrigat" + CHR(243) + "rio para visualizar relat" + ;
                                          CHR(243) + "rio"
                loc_lSucesso = .F.
            ENDIF
            IF EMPTY(THIS.this_cMoeda)
                THIS.this_cMensagemErro = "Moeda obrigat" + CHR(243) + "ria para visualizar relat" + ;
                                          CHR(243) + "rio"
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = THIS.ImprimirRelatorio(.T.)
            IF loc_lSucesso
                THIS.RegistrarAuditoria("VISUALIZACAO")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra geracao do relatorio em LogAuditoria
    * par_cOperacao: tipo de operacao (IMPRESSAO, VISUALIZACAO, EXCEL)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult, loc_cUsuario
        loc_lSucesso = .F.
        TRY
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
            ENDIF

            loc_cChave = "EMP=" + ALLTRIM(THIS.this_cEmpresa) + ;
                         ";PER=" + DTOC(THIS.this_dDtInicial) + "-" + DTOC(THIS.this_dDtFinal) + ;
                         ";VEND=" + ALLTRIM(THIS.this_cVendedor) + ;
                         ";OPE=" + ALLTRIM(THIS.this_cNmOperacao) + ;
                         ";MOE=" + ALLTRIM(THIS.this_cMoeda) + ;
                         ";TR=" + ALLTRIM(STR(THIS.this_nTipoRel, 1))

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(dtOperacao, cUsuario, cTabela, cOperacao, cChave) " + ;
                       "VALUES (GETDATE(), " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL("SigReAds") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            *-- Auditoria nao deve interromper geracao do relatorio
            MsgErro("Falha ao registrar auditoria: " + loc_oErro.Message, "Auditoria")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores e remove registros temporarios de SigTempR
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF !EMPTY(THIS.this_cIdQuery)
            SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigTempR WHERE CIdQuerys = " + ;
                EscaparSQL(THIS.this_cIdQuery))
            THIS.this_cIdQuery = ""
        ENDIF
        IF USED("csRelatorio")
            USE IN csRelatorio
        ENDIF
        IF USED("csProdutos")
            USE IN csProdutos
        ENDIF
        IF USED("csCabecalho")
            USE IN csCabecalho
        ENDIF
        IF USED("csSqlEest")
            USE IN csSqlEest
        ENDIF
        IF USED("csSqlEest2")
            USE IN csSqlEest2
        ENDIF
        IF USED("TmpCsRelat")
            USE IN TmpCsRelat
        ENDIF
        IF USED("TmpCsRela2")
            USE IN TmpCsRela2
        ENDIF
        IF USED("TmpObses")
            USE IN TmpObses
        ENDIF
        IF USED("csRelatorio1")
            USE IN csRelatorio1
        ENDIF
        IF USED("csTot1")
            USE IN csTot1
        ENDIF
        IF USED("csTot2")
            USE IN csTot2
        ENDIF
        IF USED(THIS.this_cCursorTipos)
            USE IN (THIS.this_cCursorTipos)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

