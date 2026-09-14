# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (5)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Dados' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-WITH] Bloco WITH loc_oGrid define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrid.RecordSource).
- [GRID-HEADER] Header Caption 'Emitente / Destinatário' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Número, Data, Vecto, Valor, Emitente / Detinatário, Operação. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'Processar' (parent: SIGREGDP): Top original=92 vs migrado 'cmd_4c_Processar' Top=7 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'SelTudo' (parent: SIGREGDP): Top original=529 vs migrado 'cmd_4c_SelTudo' Top=444 (diff=85px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREGDP.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1218 linhas total):

*-- Linhas 7 a 27:
7: * Layout: Cabecalho + CommandGroup de 4 botoes + PageFrame de 1 pagina
8: *   - Cabe" + CHR(231) + "alho escuro com t" + CHR(237) + "tulo (cnt_4c_Cabecalho)
9: *   - 4 botoes do framework relatorio (cmg_4c_Botoes: Visualizar/Imprimir/DocExcel/Sair)
10: *   - PageFrame de 1 pagina (pgf_4c_Paginas.Page1 = "Sele" + CHR(231) + CHR(227) + "o")
11: *     hospeda filtros (Serie, NF Ini/Fim, optSelecao), botao Processar,
12: *     Grid com checkboxes (cursor_4c_Dados equivalente TmpNFis) e botoes
13: *     de marcacao SelTudo/Desmarcar
14: *==============================================================================
15: 
16: DEFINE CLASS FormSIGREGDP AS FormBase
17: 
18:     *-- Dimensoes e aparencia (EXATAS do original: Width=800, Height=700)
19:     Height      = 700
20:     Width       = 800
21:     DataSession = 2
22:     ShowWindow  = 1
23:     WindowType  = 1
24:     AutoCenter  = .T.
25:     BorderStyle = 2
26:     ControlBox  = .F.
27:     MaxButton   = .F.

*-- Linhas 56 a 64:
56:         loc_lContinuar = .T.
57: 
58:         TRY
59:             THIS.Caption = "Emiss" + CHR(227) + "o Global de Duplicatas/Boletos"
60: 
61:             IF TYPE("gc_4c_CaminhoIcones") = "U"
62:                 gc_4c_CaminhoIcones = ""
63:             ENDIF
64:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 91 a 100:
91:                 *-- PageFrame de 1 pagina ("Sele" + CHR(231) + CHR(227) + "o") - hospeda filtros e grid
92:                 THIS.ConfigurarPageFrame()
93: 
94:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
95:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
96: 
97:                 *-- Filtros, Grid e botoes de selecao dentro da Page1 (via wrapper)
98:                 THIS.ConfigurarPaginaLista()
99: 
100:                 THIS.LimparCampos()

*-- Linhas 122 a 161:
122:     PROTECTED PROCEDURE ConfigurarCabecalho()
123:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
124:         WITH THIS.cnt_4c_Cabecalho
125:             .Top         = 0
126:             .Left        = 0
127:             .Width       = THIS.Width
128:             .Height      = 80
129:             .BackColor   = RGB(100, 100, 100)
130:             .BackStyle   = 1
131:             .BorderWidth = 0
132:             .Visible     = .T.
133:         ENDWITH
134: 
135:         *-- Sombra do texto (efeito 3D - texto preto ligeiramente deslocado)
136:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
137:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
138:             .Top       = 17
139:             .Left      = 12
140:             .AutoSize  = .T.
141:             .Caption   = "Emiss" + CHR(227) + "o Global de Duplicatas/Boletos"
142:             .FontName  = "Tahoma"
143:             .FontSize  = 14
144:             .FontBold  = .T.
145:             .ForeColor = RGB(0, 0, 0)
146:             .BackStyle = 0
147:             .Visible   = .T.
148:         ENDWITH
149: 
150:         *-- Titulo principal (texto branco sobre fundo cinza escuro)
151:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
152:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
153:             .Top       = 20
154:             .Left      = 10
155:             .AutoSize  = .T.
156:             .Caption   = "Emiss" + CHR(227) + "o Global de Duplicatas/Boletos"
157:             .FontName  = "Tahoma"
158:             .FontSize  = 14
159:             .FontBold  = .T.
160:             .ForeColor = RGB(255, 255, 255)
161:             .BackStyle = 0

*-- Linhas 173 a 182:
173:     PROTECTED PROCEDURE ConfigurarBotoes()
174:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
175:         WITH THIS.cmg_4c_Botoes
176:             .Top           = 0
177:             .Left          = 528
178:             .Width         = 273
179:             .Height        = 80
180:             .ButtonCount   = 4
181:             .BackStyle     = 0
182:             .BorderStyle   = 0

*-- Linhas 188 a 200:
188: 
189:         *-- Botao 1: Visualizar (preview duplicatas/boletos)
190:         WITH THIS.cmg_4c_Botoes.Buttons(1)
191:             .Top             = 5
192:             .Left            = 5
193:             .Width           = 65
194:             .Height          = 70
195:             .Caption         = "Visualizar"
196:             .FontName        = "Tahoma"
197:             .FontBold        = .T.
198:             .FontItalic      = .T.
199:             .FontSize        = 8
200:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 210 a 222:
210: 
211:         *-- Botao 2: Imprimir (emite duplicatas/boletos selecionados)
212:         WITH THIS.cmg_4c_Botoes.Buttons(2)
213:             .Top             = 5
214:             .Left            = 71
215:             .Width           = 65
216:             .Height          = 70
217:             .Caption         = "Imprimir"
218:             .FontName        = "Tahoma"
219:             .FontBold        = .T.
220:             .FontItalic      = .T.
221:             .FontSize        = 8
222:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 232 a 244:
232: 
233:         *-- Botao 3: DocExcel (exporta cursor para planilha Excel)
234:         WITH THIS.cmg_4c_Botoes.Buttons(3)
235:             .Top             = 5
236:             .Left            = 137
237:             .Width           = 65
238:             .Height          = 70
239:             .Caption         = "DocExcel"
240:             .FontName        = "Tahoma"
241:             .FontBold        = .T.
242:             .FontItalic      = .T.
243:             .FontSize        = 8
244:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 254 a 266:
254: 
255:         *-- Botao 4: Sair (fecha o formulario, Cancel=.T. => ESC fecha)
256:         WITH THIS.cmg_4c_Botoes.Buttons(4)
257:             .Top             = 5
258:             .Left            = 203
259:             .Width           = 65
260:             .Height          = 70
261:             .Caption         = "Sair"
262:             .FontName        = "Tahoma"
263:             .FontBold        = .T.
264:             .FontItalic      = .T.
265:             .FontSize        = 8
266:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 297 a 311:
297:         loc_oPgf.PageCount = 1
298: 
299:         *-- Logo abaixo do cabecalho (80px) ate o fim do form
300:         loc_oPgf.Top    = 85
301:         loc_oPgf.Left   = -1
302:         loc_oPgf.Width  = THIS.Width + 2
303:         loc_oPgf.Height = THIS.Height - 85
304:         loc_oPgf.Tabs   = .F.
305: 
306:         loc_oPgf.Page1.Caption   = "Sele" + CHR(231) + CHR(227) + "o"
307:         loc_oPgf.Page1.FontName  = "Tahoma"
308:         loc_oPgf.Page1.FontSize  = 8
309:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
310:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
311:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 335 a 404:
335:     *   Para frmrelatorio, "Dados" corresponde aos parametros de selecao.
336:     *   Esta metade adiciona Serie (Say1/Get_Serie) e NF Inicial (Say2/Get_NFIni).
337:     *
338:     *   Posicoes Top compensadas em -85 (form_top - PageFrame.Top=85):
339:     *     Say1 Top=138 -> 53, Get_Serie Top=135 -> 50
340:     *     Say2 Top=138 -> 53, Get_NFIni Top=135 -> 50
341:     *
342:     *   BINDEVENT do TxtSerie (lookup F4/ENTER/TAB) registrado aqui pois
343:     *   o controle eh criado neste metodo.
344:     *--------------------------------------------------------------------------
345:     PROTECTED PROCEDURE ConfigurarPaginaDados()
346:         LOCAL loc_oPagina
347:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
348: 
349:         *-- Label Serie (Say1: Top=138 -> 53, Left=100)
350:         loc_oPagina.AddObject("lbl_4c_Serie", "Label")
351:         WITH loc_oPagina.lbl_4c_Serie
352:             .Top       = 53
353:             .Left      = 100
354:             .AutoSize  = .T.
355:             .FontBold  = .T.
356:             .FontName  = "Tahoma"
357:             .FontSize  = 8
358:             .Caption   = "S" + CHR(233) + "rie : "
359:             .ForeColor = RGB(90, 90, 90)
360:             .BackStyle = 0
361:             .Visible   = .T.
362:         ENDWITH
363: 
364:         *-- TextBox Serie (Get_Serie: Top=135 -> 50, Left=145, Width=34)
365:         loc_oPagina.AddObject("txt_4c_Serie", "TextBox")
366:         WITH loc_oPagina.txt_4c_Serie
367:             .Top       = 50
368:             .Left      = 145
369:             .Width     = 34
370:             .Height    = 23
371:             .FontName  = "Tahoma"
372:             .FontSize  = 8
373:             .MaxLength = 3
374:             .Value     = ""
375:             .ForeColor = RGB(0, 0, 0)
376:             .TabIndex  = 2
377:             .Visible   = .T.
378:         ENDWITH
379: 
380:         *-- Label NF Inicial (Say2: Top=138 -> 53, Left=217)
381:         loc_oPagina.AddObject("lbl_4c_NfIni", "Label")
382:         WITH loc_oPagina.lbl_4c_NfIni
383:             .Top       = 53
384:             .Left      = 217
385:             .AutoSize  = .T.
386:             .FontBold  = .T.
387:             .FontName  = "Tahoma"
388:             .FontSize  = 8
389:             .Caption   = "NF Inicial : "
390:             .ForeColor = RGB(90, 90, 90)
391:             .BackStyle = 0
392:             .Visible   = .T.
393:         ENDWITH
394: 
395:         *-- TextBox NF Inicial (Get_NFIni: Top=135 -> 50, Left=283, Width=55)
396:         loc_oPagina.AddObject("txt_4c_NFIni", "TextBox")
397:         WITH loc_oPagina.txt_4c_NFIni
398:             .Top       = 50
399:             .Left      = 283
400:             .Width     = 55
401:             .Height    = 23
402:             .FontName  = "Tahoma"
403:             .FontSize  = 8
404:             .InputMask = "999999"

*-- Linhas 431 a 468:
431: 
432:     *--------------------------------------------------------------------------
433:     * ConfigurarFiltros - Segunda metade dos filtros (NF Final, opt_Selecao, Processar)
434:     *   Posicoes Top compensadas em -85 (form_top - PageFrame.Top=85)
435:     *   Originais:
436:     *     Say3 Top=163, Get_NFFim Top=160 (-> Top=78/75)
437:     *     optSelecao Top=135 (-> Top=50)
438:     *     Processar Top=92 (-> Top=7)
439:     *--------------------------------------------------------------------------
440:     PROTECTED PROCEDURE ConfigurarFiltros()
441:         LOCAL loc_oPagina
442:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
443: 
444:         *-- Label NF Final (Say3: Top=163 -> 78, Left=225)
445:         loc_oPagina.AddObject("lbl_4c_NfFim", "Label")
446:         WITH loc_oPagina.lbl_4c_NfFim
447:             .Top       = 78
448:             .Left      = 225
449:             .AutoSize  = .T.
450:             .FontBold  = .T.
451:             .FontName  = "Tahoma"
452:             .FontSize  = 8
453:             .Caption   = "NF Final : "
454:             .ForeColor = RGB(90, 90, 90)
455:             .BackStyle = 0
456:             .Visible   = .T.
457:         ENDWITH
458: 
459:         *-- TextBox NF Final (Get_NFFim: Top=160 -> 75, Left=283, Width=55)
460:         loc_oPagina.AddObject("txt_4c_NFFim", "TextBox")
461:         WITH loc_oPagina.txt_4c_NFFim
462:             .Top       = 75
463:             .Left      = 283
464:             .Width     = 55
465:             .Height    = 23
466:             .FontName  = "Tahoma"
467:             .FontSize  = 8
468:             .InputMask = "999999"

*-- Linhas 478 a 575:
478:         *   Original optSelecao: Top=135 -> 50, Left=346, W=141, H=48
479:         loc_oPagina.AddObject("opt_4c_Selecao", "OptionGroup")
480:         WITH loc_oPagina.opt_4c_Selecao
481:             .Top         = 50
482:             .Left        = 346
483:             .Width       = 141
484:             .Height      = 48
485:             .AutoSize    = .F.
486:             .BackStyle   = 0
487:             .BorderStyle = 0
488:             .ButtonCount = 2
489:             .TabIndex    = 7
490:             .Value       = 1
491:             .Visible     = .T.
492: 
493:             WITH .Buttons(1)
494:                 .Caption   = "Duplicatas"
495:                 .Top       = 5
496:                 .Left      = 5
497:                 .Height    = 15
498:                 .Width     = 77
499:                 .FontBold  = .T.
500:                 .BackStyle = 0
501:                 .AutoSize  = .T.
502:                 .Style     = 0
503:                 .ForeColor = RGB(90, 90, 90)
504:             ENDWITH
505: 
506:             WITH .Buttons(2)
507:                 .Caption   = "Boletos Banc" + CHR(225) + "rios"
508:                 .Top       = 25
509:                 .Left      = 5
510:                 .Height    = 15
511:                 .Width     = 118
512:                 .FontBold  = .T.
513:                 .FontName  = "Tahoma"
514:                 .FontSize  = 8
515:                 .BackStyle = 0
516:                 .AutoSize  = .T.
517:                 .Style     = 0
518:                 .ForeColor = RGB(90, 90, 90)
519:             ENDWITH
520:         ENDWITH
521: 
522:         *-- Botao Processar (Top=92 -> 7, Left=668, W=75, H=75)
523:         loc_oPagina.AddObject("cmd_4c_Processar", "CommandButton")
524:         WITH loc_oPagina.cmd_4c_Processar
525:             .Top             = 7
526:             .Left            = 668
527:             .Width           = 75
528:             .Height          = 75
529:             .FontBold        = .T.
530:             .FontItalic      = .T.
531:             .FontName        = "Tahoma"
532:             .FontSize        = 8
533:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
534:             .Caption         = "Processar"
535:             .ForeColor       = RGB(90, 90, 90)
536:             .BackColor       = RGB(255, 255, 255)
537:             .Themes          = .F.
538:             .SpecialEffect   = 0
539:             .PicturePosition = 13
540:             .MousePointer    = 15
541:             .TabIndex        = 8
542:             .Visible         = .T.
543:         ENDWITH
544: 
545:         *-- BINDEVENT do botao Processar (TxtSerie.KeyPress vinculado em ConfigurarPaginaDados)
546:         BINDEVENT(loc_oPagina.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
547:     ENDPROC
548: 
549:     *--------------------------------------------------------------------------
550:     * ConfigurarGrade - Grid com 8 colunas (equivalente Grade/TmpNFis original)
551:     *   Coluna 1: CheckBox (Flag) - W=20
552:     *   Coluna 2: NFis (Numero) - W=45
553:     *   Coluna 3: Datas (Data) - W=70 - ColumnOrder=5
554:     *   Coluna 4: Digito - W=16 - ColumnOrder=3
555:     *   Coluna 5: Vecto - W=70 - ColumnOrder=7
556:     *   Coluna 6: Valor - W=80
557:     *   Coluna 7: Conta (Emitente/Destinatario) - W=160 - ColumnOrder=4
558:     *   Coluna 8: Operacao (Emps+Dopes+Numes) - W=170
559:     *   Original Grade: Top=192 -> 107, Left=72, W=671, H=329
560:     *--------------------------------------------------------------------------
561:     PROTECTED PROCEDURE ConfigurarGrade()
562:         LOCAL loc_oPagina, loc_oGrid
563:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
564: 
565:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
566:         loc_oGrid = loc_oPagina.grd_4c_Dados
567: 
568:         WITH loc_oGrid
569:             .Top                = 107
570:             .Left               = 72
571:             .Width              = 671
572:             .Height             = 329
573:             .ColumnCount        = 8
574:             .FontName           = "Tahoma"
575:             .FontSize           = 8

*-- Linhas 585 a 608:
585:             .RecordSource       = THIS.this_oRelatorio.this_cCursorDados
586:             .Visible            = .T.
587: 
588:             *-- Column1: CheckBox Flag (W=20)
589:             *-- ORDEM CRITICA: AddObject -> CurrentControl -> ControlSource
590:             .Column1.Width             = 20
591:             .Column1.Movable           = .F.
592:             .Column1.Resizable         = .F.
593:             .Column1.ReadOnly          = .F.
594:             .Column1.Sparse            = .F.
595:             .Column1.FontName          = "Tahoma"
596:             .Column1.FontSize          = 8
597:             .Column1.Header1.Caption   = ""
598:             .Column1.Header1.FontName  = "Tahoma"
599:             .Column1.Header1.FontSize  = 8
600:             .Column1.Header1.Alignment = 2
601:             .Column1.Header1.ForeColor = RGB(90, 90, 90)
602:             .Column1.AddObject("Check1", "CheckBox")
603:             .Column1.Check1.Caption    = ""
604:             .Column1.Check1.BackStyle  = 0
605:             .Column1.Check1.Alignment  = 0
606:             .Column1.Check1.AutoSize   = .T.
607:             .Column1.Check1.Value      = 0
608:             .Column1.CurrentControl    = "Check1"

*-- Linhas 617 a 625:
617:             .Column2.FontBold          = .T.
618:             .Column2.FontName          = "Tahoma"
619:             .Column2.FontSize          = 8
620:             .Column2.Header1.Caption   = "N" + CHR(250) + "mero"
621:             .Column2.Header1.FontName  = "Tahoma"
622:             .Column2.Header1.FontSize  = 8
623:             .Column2.Header1.Alignment = 2
624:             .Column2.Header1.ForeColor = RGB(90, 90, 90)
625:             .Column2.Text1.BorderStyle = 0

*-- Linhas 637 a 645:
637:             .Column3.ReadOnly          = .T.
638:             .Column3.FontName          = "Tahoma"
639:             .Column3.FontSize          = 8
640:             .Column3.Header1.Caption   = "Data"
641:             .Column3.Header1.FontName  = "Tahoma"
642:             .Column3.Header1.FontSize  = 8
643:             .Column3.Header1.Alignment = 2
644:             .Column3.Header1.ForeColor = RGB(90, 90, 90)
645:             .Column3.Text1.BorderStyle = 0

*-- Linhas 657 a 665:
657:             .Column4.ReadOnly          = .T.
658:             .Column4.FontName          = "Tahoma"
659:             .Column4.FontSize          = 8
660:             .Column4.Header1.Caption   = ""
661:             .Column4.Header1.FontName  = "Tahoma"
662:             .Column4.Header1.FontSize  = 8
663:             .Column4.Header1.Alignment = 2
664:             .Column4.Header1.ForeColor = RGB(90, 90, 90)
665:             .Column4.Text1.BorderStyle = 0

*-- Linhas 677 a 685:
677:             .Column5.ReadOnly          = .T.
678:             .Column5.FontName          = "Tahoma"
679:             .Column5.FontSize          = 8
680:             .Column5.Header1.Caption   = "Vecto"
681:             .Column5.Header1.FontName  = "Tahoma"
682:             .Column5.Header1.FontSize  = 8
683:             .Column5.Header1.Alignment = 2
684:             .Column5.Header1.ForeColor = RGB(90, 90, 90)
685:             .Column5.Text1.BorderStyle = 0

*-- Linhas 697 a 705:
697:             .Column6.InputMask         = "999,999,999.99"
698:             .Column6.FontName          = "Tahoma"
699:             .Column6.FontSize          = 8
700:             .Column6.Header1.Caption   = "Valor"
701:             .Column6.Header1.FontName  = "Tahoma"
702:             .Column6.Header1.FontSize  = 8
703:             .Column6.Header1.Alignment = 2
704:             .Column6.Header1.ForeColor = RGB(90, 90, 90)
705:             .Column6.Text1.BorderStyle = 0

*-- Linhas 717 a 725:
717:             .Column7.ReadOnly          = .T.
718:             .Column7.FontName          = "Tahoma"
719:             .Column7.FontSize          = 8
720:             .Column7.Header1.Caption   = "Emitente / Destinat" + CHR(225) + "rio"
721:             .Column7.Header1.FontName  = "Tahoma"
722:             .Column7.Header1.FontSize  = 8
723:             .Column7.Header1.Alignment = 2
724:             .Column7.Header1.ForeColor = RGB(90, 90, 90)
725:             .Column7.Text1.BorderStyle = 0

*-- Linhas 738 a 746:
738:             .Column8.ReadOnly          = .T.
739:             .Column8.FontName          = "Tahoma"
740:             .Column8.FontSize          = 8
741:             .Column8.Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
742:             .Column8.Header1.FontName  = "Tahoma"
743:             .Column8.Header1.FontSize  = 8
744:             .Column8.Header1.Alignment = 2
745:             .Column8.Header1.ForeColor = RGB(90, 90, 90)
746:             .Column8.Text1.BorderStyle = 0

*-- Linhas 759 a 822:
759:     PROTECTED PROCEDURE ConfigurarBotoesSelecao()
760:         LOCAL loc_oPagina
761:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
762: 
763:         *-- Botao SelTudo (Top=529 -> 444, Left=71, W=45, H=45)
764:         loc_oPagina.AddObject("cmd_4c_SelTudo", "CommandButton")
765:         WITH loc_oPagina.cmd_4c_SelTudo
766:             .Top           = 444
767:             .Left          = 71
768:             .Width         = 45
769:             .Height        = 45
770:             .FontName      = "Verdana"
771:             .FontSize      = 8
772:             .Picture       = gc_4c_CaminhoIcones + "a_save1.bmp"
773:             .Caption       = ""
774:             .ToolTipText   = "Selecionar Todos"
775:             .ForeColor     = RGB(36, 84, 155)
776:             .BackColor     = RGB(255, 255, 255)
777:             .Themes        = .F.
778:             .SpecialEffect = 0
779:             .MousePointer  = 15
780:             .TabIndex      = 10
781:             .Visible       = .T.
782:         ENDWITH
783: 
784:         *-- Botao Desmarcar/apaga (Top=529 -> 444, Left=117, W=45, H=45)
785:         loc_oPagina.AddObject("cmd_4c_Desmarcar", "CommandButton")
786:         WITH loc_oPagina.cmd_4c_Desmarcar
787:             .Top           = 444
788:             .Left          = 117
789:             .Width         = 45
790:             .Height        = 45
791:             .FontBold      = .F.
792:             .FontItalic    = .F.
793:             .FontName      = "Verdana"
794:             .FontSize      = 8
795:             .Picture       = gc_4c_CaminhoIcones + "cancelab.bmp"
796:             .Caption       = ""
797:             .ToolTipText   = "Desmarcar Todos"
798:             .ForeColor     = RGB(36, 84, 155)
799:             .BackColor     = RGB(255, 255, 255)
800:             .Themes        = .F.
801:             .SpecialEffect = 0
802:             .MousePointer  = 15
803:             .TabIndex      = 11
804:             .Visible       = .T.
805:         ENDWITH
806: 
807:         BINDEVENT(loc_oPagina.cmd_4c_SelTudo,   "Click", THIS, "BtnSelTudoClick")
808:         BINDEVENT(loc_oPagina.cmd_4c_Desmarcar, "Click", THIS, "BtnDesmarcarClick")
809:     ENDPROC
810: 
811:     *--------------------------------------------------------------------------
812:     * FormParaRelatorio - Transfere filtros do form para o BO
813:     *--------------------------------------------------------------------------
814:     PROTECTED PROCEDURE FormParaRelatorio()
815:         LOCAL loc_oPagina
816:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
817: 
818:         WITH THIS.this_oRelatorio
819:             .this_cSerieNf = ALLTRIM(loc_oPagina.txt_4c_Serie.Value)
820:             .this_cNFIni   = ALLTRIM(loc_oPagina.txt_4c_NFIni.Value)
821:             .this_cNFFim   = ALLTRIM(loc_oPagina.txt_4c_NFFim.Value)
822:             .this_nSelecao = loc_oPagina.opt_4c_Selecao.Value

*-- Linhas 1152 a 1173:
1152:             loc_oPagina.txt_4c_NFFim.Enabled   = par_lHabilitar
1153:         ENDIF
1154:         IF VARTYPE(loc_oPagina.opt_4c_Selecao) = "O"
1155:             loc_oPagina.opt_4c_Selecao.Enabled = par_lHabilitar
1156:         ENDIF
1157:         IF VARTYPE(loc_oPagina.cmd_4c_Processar) = "O"
1158:             loc_oPagina.cmd_4c_Processar.Enabled = par_lHabilitar
1159:         ENDIF
1160:     ENDPROC
1161: 
1162:     *--------------------------------------------------------------------------
1163:     * CarregarLista - Atualiza o grid com o estado atual do cursor de dados
1164:     *--------------------------------------------------------------------------
1165:     PROCEDURE CarregarLista()
1166:         LOCAL loc_oPagina
1167:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1168: 
1169:         IF VARTYPE(loc_oPagina) != "O"
1170:             RETURN
1171:         ENDIF
1172: 
1173:         IF VARTYPE(loc_oPagina.grd_4c_Dados) = "O"

*-- Linhas 1194 a 1215:
1194:             THIS.cmg_4c_Botoes.Buttons(3).Enabled = loc_lProcessado
1195:         ENDIF
1196: 
1197:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1198:         IF VARTYPE(loc_oPagina) = "O"
1199:             IF VARTYPE(loc_oPagina.cmd_4c_SelTudo) = "O"
1200:                 loc_oPagina.cmd_4c_SelTudo.Enabled   = loc_lProcessado
1201:             ENDIF
1202:             IF VARTYPE(loc_oPagina.cmd_4c_Desmarcar) = "O"
1203:                 loc_oPagina.cmd_4c_Desmarcar.Enabled = loc_lProcessado
1204:             ENDIF
1205:         ENDIF
1206:     ENDPROC
1207: 
1208:     *--------------------------------------------------------------------------
1209:     * Destroy - Libera BO e chama DODEFAULT
1210:     *--------------------------------------------------------------------------
1211:     PROCEDURE Destroy()
1212:         IF VARTYPE(THIS.this_oRelatorio) = "O"
1213:             THIS.this_oRelatorio = .NULL.
1214:         ENDIF
1215:         DODEFAULT()


### BO (C:\4c\projeto\app\classes\SIGREGDPBO.prg):
*==============================================================================
* SIGREGDPBO.PRG
* Business Object - Emissao Global de Duplicatas/Boletos (SIGREGDP)
* Herda de: RelatorioBase
*
* Funcionalidade:
*   - Filtros: Serie NF, NF Inicial/Final, tipo (Duplicatas ou Boletos)
*   - Carrega SigMvNfi join SigMvPar no cursor de dados (equivalente TmpNFis)
*   - Impressao: chama SigIpDup (Duplicatas) ou SigPrIbl/SigPrIbb (Boletos)
*==============================================================================

DEFINE CLASS SIGREGDPBO AS RelatorioBase

    *-- Identificacao (sem tabela CRUD - form operacional)
    this_cTabela        = ""
    this_cCampoChave    = ""

    *-- Filtros do formulario
    this_cSerieNf       = ""    && Serie da NF (Get_Serie, C(3))
    this_cNFIni         = ""    && NF Inicial (Get_NFIni, C(6))
    this_cNFFim         = ""    && NF Final (Get_NFFim, C(6))
    this_nSelecao       = 0     && 1=Duplicatas, 2=Boletos Bancarios

    *-- Nomes dos cursores de trabalho
    this_cCursorDados   = "cursor_4c_Dados"     && Equivalente a TmpNFis (grid)
    this_cCursorOpFp    = "cursor_4c_OpFp"      && SigOpFp (FPags, ImpDups, ImpBols, ImpNotas)
    this_cCursorPam     = "cursor_4c_Pam"       && SigCdPam (MascNums)
    this_cCursorNfi     = "cursor_4c_NfiFiltro" && SigMvNfi JOIN SigMvPar filtrado
    this_cCursorCli     = "cursor_4c_Cli"       && SigCdCli (RClis - nome do cliente)

    *-- Estado interno
    this_lProcessado    = .F.   && .T. apos PrepararDados() executado com sucesso

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO e cursores auxiliares
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            IF DODEFAULT()
                IF THIS.InicializarCursores()
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREGDPBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarCursores - Cria cursor local de dados e carrega auxiliares
    *--------------------------------------------------------------------------
    PROCEDURE InicializarCursores()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            *-- Criar cursor local equivalente ao TmpNFis do legado
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF
            CREATE CURSOR cursor_4c_Dados ( ;
                flag     L, ;
                datas    D NULL, ;
                nfis     C(6), ;
                valor    N(12,2), ;
                conta    C(40), ;
                digito   N(1), ;
                vecto    C(12), ;
                totnotas N(12,2), ;
                emps     C(3), ;
                dopes    C(20), ;
                numes    N(6), ;
                obs      M NULL, ;
                parcs    N(2) ;
            )

            *-- Em modo validacao UI, nao executar SQLs (sem conexao)
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lSucesso = .T.
            ELSE
                *-- Carregar SigOpFp (formas de pagamento com flags de impressao)
                loc_cSQL = "SELECT fpags, impdups, impbols, impnotas FROM SigOpFp"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorOpFp)
                IF loc_nResult > 0
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao carregar formas de pagamento (SigOpFp)"
                ENDIF

                *-- Carregar SigCdPam (mascara de numeros) - nao critico para funcionamento
                loc_cSQL = "SELECT mascnums FROM SigCdPam"
                SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorPam)
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREGDPBO.InicializarCursores")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa NFs conforme filtros (equivalente Processar.Click)
    * Popula cursor_4c_Dados com os registros filtrados e validados
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_cFPags, loc_cCliFors, loc_cNfis, loc_cConta, loc_cVecto
        LOCAL loc_nValos, loc_dDatas, loc_nParcs, loc_nNumes, loc_nTotNot
        LOCAL loc_cEmps, loc_cDopes, loc_cObs, loc_dVencs
        LOCAL loc_nImpDups, loc_nImpBols, loc_nImpNot, loc_nConta
        loc_lSucesso = .F.

        TRY
            *-- ZAP cursor de dados e resetar estado
            IF USED(THIS.this_cCursorDados)
                ZAP IN (THIS.this_cCursorDados)
            ENDIF
            THIS.this_lProcessado = .F.

            *-- Consultar SigMvNfi JOIN SigMvPar com filtros informados
            loc_cSQL = "SELECT a.nfis, a.clifors, a.totnotas, a.emps, a.dopes, a.numes, " + ;
                       "b.fpags, b.parcs, b.valos, b.datas, b.vencs, b.obs " + ;
                       "FROM SigMvNfi a " + ;
                       "INNER JOIN SigMvPar b ON a.empdopnums = b.empdopnums " + ;
                       "WHERE a.nfis BETWEEN " + EscaparSQL(THIS.this_cNFIni) + ;
                       " AND " + EscaparSQL(THIS.this_cNFFim) + ;
                       " AND a.series = " + EscaparSQL(THIS.this_cSerieNf) + ;
                       " ORDER BY a.emps, a.dopes, a.numes, b.fpags, b.parcs"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorNfi)
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao consultar notas fiscais. Verifique a conex" + ;
                                          CHR(227) + "o."
            ELSE
                WAIT WINDOW "Aguarde!!! Selecionando Notas Fiscais..." NOWAIT

                *-- Iterar sobre registros e popular cursor_4c_Dados
                SELECT (THIS.this_cCursorNfi)
                SCAN
                    *-- Capturar todos os valores necessarios antes de trocar de area
                    loc_cFPags   = ALLTRIM(cursor_4c_NfiFiltro.fpags)
                    loc_cCliFors = ALLTRIM(cursor_4c_NfiFiltro.clifors)
                    loc_cNfis    = ALLTRIM(cursor_4c_NfiFiltro.nfis)
                    loc_nValos   = cursor_4c_NfiFiltro.valos
                    loc_dDatas   = TTOD(NVL(cursor_4c_NfiFiltro.datas, CTOT("")))
                    loc_nParcs   = cursor_4c_NfiFiltro.parcs
                    loc_cEmps    = ALLTRIM(cursor_4c_NfiFiltro.emps)
                    loc_cDopes   = ALLTRIM(cursor_4c_NfiFiltro.dopes)
                    loc_nNumes   = cursor_4c_NfiFiltro.numes
                    loc_cObs     = NVL(cursor_4c_NfiFiltro.obs, "")
                    loc_nTotNot  = cursor_4c_NfiFiltro.totnotas
                    loc_dVencs   = cursor_4c_NfiFiltro.vencs

                    *-- Verificar forma de pagamento habilitada em SigOpFp
                    SELECT (THIS.this_cCursorOpFp)
                    LOCATE FOR ALLTRIM(fpags) = loc_cFPags

                    IF !FOUND()
                        SELECT (THIS.this_cCursorNfi)
                        LOOP
                    ENDIF

                    *-- Capturar flags de impressao da forma de pagamento
                    loc_nImpDups = cursor_4c_OpFp.impdups
                    loc_nImpBols = cursor_4c_OpFp.impbols
                    loc_nImpNot  = cursor_4c_OpFp.impnotas

                    *-- Filtrar por tipo de selecao (Duplicatas ou Boletos)
                    IF ((THIS.this_nSelecao = 1) AND (loc_nImpDups <> 1)) OR ;
                       ((THIS.this_nSelecao = 2) AND (loc_nImpBols <> 1))
                        SELECT (THIS.this_cCursorNfi)
                        LOOP
                    ENDIF

                    *-- Numero da parcela (digito)
                    loc_nConta = loc_nParcs

                    loc_cConta = loc_cCliFors

                    *-- Calcular campo Vecto: data de vencimento ou forma de pagamento
                    IF loc_nImpNot = 1
                        loc_cVecto = DTOC(TTOD(NVL(loc_dVencs, CTOT(""))))
                    ELSE
                        loc_cVecto = loc_cFPags
                    ENDIF

                    *-- Inserir registro processado no cursor de dados
                    SELECT (THIS.this_cCursorDados)
                    INSERT INTO cursor_4c_Dados ( ;
                        flag, nfis, valor, datas, conta, digito, parcs, ;
                        vecto, totnotas, obs, emps, dopes, numes) ;
                    VALUES ( ;
                        .T., ;
                        loc_cNfis, ;
                        loc_nValos, ;
                        loc_dDatas, ;
                        loc_cConta, ;
                        loc_nConta, ;
                        loc_nParcs, ;
                        loc_cVecto, ;
                        loc_nTotNot, ;
                        loc_cObs, ;
                        loc_cEmps, ;
                        loc_cDopes, ;
                        loc_nNumes ;
                    )

                    SELECT (THIS.this_cCursorNfi)
                ENDSCAN

                WAIT CLEAR

                *-- Verificar resultado e alertar se vazio
                SELECT (THIS.this_cCursorDados)
                GO TOP
                IF EOF()
                    IF THIS.this_nSelecao = 1
                        MsgAviso("Nenhuma Duplicata Selecionada...")
                    ELSE
                        MsgAviso("Nenhum Boleto Banc" + CHR(225) + "rio Selecionado...")
                    ENDIF
                ENDIF

                THIS.this_lProcessado = .T.
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREGDPBO.PrepararDados")
            WAIT CLEAR
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Emite duplicatas ou boletos para os registros selecionados
    * Equivalente ao procedure "impressao" do legado
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_nQt, loc_cChave
        loc_lSucesso = .F.

        TRY
            IF !THIS.this_lProcessado
                MsgAviso("Execute o Processamento antes de Imprimir.")
            ELSE
                IF THIS.this_nSelecao = 1
                    *-- Emissao de Duplicatas via funcao legada SigIpDup
                    =SigIpDup("", THIS.this_cSerieNf, .T., .NULL.)
                    loc_lSucesso = .T.
                ELSE
                    *-- Emissao de Boletos Bancarios
                    *-- Montar cursor cabecalho agrupado por NF
                    IF USED("cursor_4c_MvCab")
                        USE IN cursor_4c_MvCab
                    ENDIF
                    SELECT emps, dopes, numes, parcs ;
                        FROM (THIS.this_cCursorDados) ;
                        WHERE flag ;
                        GROUP BY emps, dopes, numes, parcs ;
                        INTO CURSOR cursor_4c_MvCab READWRITE

                    *-- Verificar configuracao de boleto bancario em SigCnFBl
                    loc_cSQL = "SELECT COUNT(*) AS qt FROM SigCnFBl WHERE fpags <> ' '"
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfgBol")
                    IF loc_nResult < 1
                        MsgErro("Favor Reinicializar o Processo!!!", ;
                                "Falha na Conex" + CHR(227) + "o (SigCnFBl)")
                    ELSE
                        SELECT cursor_4c_CfgBol
                        loc_nQt = NVL(qt, 0)
                        USE IN cursor_4c_CfgBol

                        IF loc_nQt = 0
                            *-- Sem boleto bancario configurado: imprimir simples
                            DO FORM SigPrIbl WITH "", .NULL.
                        ELSE
                            *-- Com boleto bancario: imprimir por NF individualmente
                            SELECT cursor_4c_MvCab
                            SCAN
                                loc_cChave = cursor_4c_MvCab.emps + ;
                                             cursor_4c_MvCab.dopes + ;
                                             STR(cursor_4c_MvCab.numes, 6)
                                DO FORM SigPrIbb WITH loc_cChave, .NULL.
                            ENDSCAN
                        ENDIF

                        loc_lSucesso = .T.
                    ENDIF

                    IF USED("cursor_4c_MvCab")
                        USE IN cursor_4c_MvCab
                    ENDIF
                ENDIF

                *-- Reposicionar cursor de dados no final (comportamento original)
                IF USED(THIS.this_cCursorDados)
                    SELECT (THIS.this_cCursorDados)
                    GO BOTTOM
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREGDPBO.Imprimir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SelecionarTodos - Marca Flag=.T. em todos os registros do cursor de dados
    * Equivalente ao botao SelTudo do legado
    *--------------------------------------------------------------------------
    PROCEDURE SelecionarTodos()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorDados)
                UPDATE (THIS.this_cCursorDados) SET flag = .T.
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREGDPBO.SelecionarTodos")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarTodos - Marca Flag=.F. em todos os registros do cursor de dados
    * Equivalente ao botao apaga do legado
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarTodos()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorDados)
                UPDATE (THIS.this_cCursorDados) SET flag = .F.
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREGDPBO.DesmarcarTodos")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em modo impressao (original: Visualiza oculto)
    * No legado btnReport.Visualiza.Visible = .F. - nao havia preview separado.
    * Delega para Imprimir() para compatibilidade com qualquer chamada residual.
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        RETURN THIS.Imprimir()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Stub (relatorio nao possui chave primaria)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha todos os cursores abertos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        IF USED(THIS.this_cCursorOpFp)
            USE IN (THIS.this_cCursorOpFp)
        ENDIF
        IF USED(THIS.this_cCursorPam)
            USE IN (THIS.this_cCursorPam)
        ENDIF
        IF USED(THIS.this_cCursorNfi)
            USE IN (THIS.this_cCursorNfi)
        ENDIF
        IF USED(THIS.this_cCursorCli)
            USE IN (THIS.this_cCursorCli)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

