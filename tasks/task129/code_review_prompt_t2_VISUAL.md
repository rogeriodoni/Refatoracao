# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (7)
- [LAYOUT-POSITION] Controle 'Option' (parent: SIGREIPR): Top original=190 vs migrado 'opt_4c_Option' Top=105 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OpOrdem' (parent: SIGREIPR): Top original=190 vs migrado 'opt_4c_OpOrdem' Top=105 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'chkEnderecos' (parent: SIGREIPR): Top original=148 vs migrado 'chk_4c_ChkEnderecos' Top=63 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'chkTelefones' (parent: SIGREIPR): Top original=148 vs migrado 'chk_4c_ChkTelefones' Top=63 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ChkClassif' (parent: SIGREIPR): Top original=168 vs migrado 'chk_4c_ChkClassif' Top=83 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'chkRepres' (parent: SIGREIPR): Top original=168 vs migrado 'chk_4c_ChkRepres' Top=83 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'chkDtCom' (parent: SIGREIPR): Top original=148 vs migrado 'chk_4c_ChkDtCom' Top=63 (diff=85px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReIpr.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1063 linhas total):

*-- Linhas 46 a 54:
46:         LOCAL loc_lSucesso
47:         loc_lSucesso = .F.
48:         TRY
49:             THIS.Caption = "Relat" + CHR(243) + "rio de Mailing"
50: 
51:             IF TYPE("gc_4c_CaminhoIcones") = "U"
52:                 gc_4c_CaminhoIcones = ""
53:             ENDIF
54:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 62 a 71:
62:                 THIS.ConfigurarBotoes()
63:                 THIS.ConfigurarPageFrame()
64: 
65:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
66:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
67: 
68:                 THIS.ConfigurarPaginaLista()
69: 
70:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
71:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")

*-- Linhas 92 a 166:
92:     PROTECTED PROCEDURE ConfigurarCabecalho()
93:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
94:         WITH THIS.cnt_4c_Cabecalho
95:             .Top         = 0
96:             .Left        = 0
97:             .Width       = THIS.Width
98:             .Height      = 80
99:             .BackStyle   = 1
100:             .BackColor   = RGB(100, 100, 100)
101:             .BorderWidth = 0
102:             .Visible     = .T.
103: 
104:             .AddObject("lbl_4c_Sombra", "Label")
105:             WITH .lbl_4c_Sombra
106:                 .Top       = 22
107:                 .Left      = 22
108:                 .Width     = THIS.Width
109:                 .Height    = 30
110:                 .Caption   = "Relat" + CHR(243) + "rio de Mailing"
111:                 .FontName  = "Tahoma"
112:                 .FontSize  = 14
113:                 .FontBold  = .T.
114:                 .ForeColor = RGB(0, 0, 0)
115:                 .BackStyle = 0
116:                 .Visible   = .T.
117:             ENDWITH
118: 
119:             .AddObject("lbl_4c_Titulo", "Label")
120:             WITH .lbl_4c_Titulo
121:                 .Top       = 20
122:                 .Left      = 20
123:                 .Width     = THIS.Width
124:                 .Height    = 30
125:                 .Caption   = "Relat" + CHR(243) + "rio de Mailing"
126:                 .FontName  = "Tahoma"
127:                 .FontSize  = 14
128:                 .FontBold  = .T.
129:                 .ForeColor = RGB(255, 255, 255)
130:                 .BackStyle = 0
131:                 .Visible   = .T.
132:             ENDWITH
133:         ENDWITH
134:     ENDPROC
135: 
136:     *--------------------------------------------------------------------------
137:     * ConfigurarBotoes - CommandGroup com 4 botoes do relatorio
138:     *   Original: btnReport.Top=-2, Left=287, Width=313, Height=85
139:     *   Botoes: Visualiza(5), Imprime(81), DocExcel(157), Sair(233) - W=75 cada
140:     *--------------------------------------------------------------------------
141:     PROTECTED PROCEDURE ConfigurarBotoes()
142:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
143:         WITH THIS.cmg_4c_Botoes
144:             .Top           = 0
145:             .Left          = 529
146:             .Width         = 273
147:             .Height        = 80
148:             .ButtonCount   = 4
149:             .BackStyle     = 0
150:             .BorderStyle   = 0
151:             .BorderColor   = RGB(136, 189, 188)
152:             .SpecialEffect = 1
153:             .Themes        = .F.
154:             .Visible       = .T.
155: 
156:             WITH .Buttons(1)
157:                 .Top             = 5
158:                 .Left            = 5
159:                 .Width           = 65
160:                 .Height          = 70
161:                 .Caption         = "Visualizar"
162:                 .FontBold        = .T.
163:                 .FontItalic      = .T.
164:                 .BackColor       = RGB(255, 255, 255)
165:                 .ForeColor       = RGB(90, 90, 90)
166:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 173 a 185:
173:             ENDWITH
174: 
175:             WITH .Buttons(2)
176:                 .Top             = 5
177:                 .Left            = 71
178:                 .Width           = 65
179:                 .Height          = 70
180:                 .Caption         = "Imprimir"
181:                 .FontName        = "Tahoma"
182:                 .FontBold        = .T.
183:                 .FontItalic      = .T.
184:                 .FontSize        = 8
185:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 194 a 206:
194:             ENDWITH
195: 
196:             WITH .Buttons(3)
197:                 .Top             = 5
198:                 .Left            = 137
199:                 .Width           = 65
200:                 .Height          = 70
201:                 .Caption         = "Excel"
202:                 .FontName        = "Tahoma"
203:                 .FontBold        = .T.
204:                 .FontItalic      = .T.
205:                 .FontSize        = 8
206:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 215 a 227:
215:             ENDWITH
216: 
217:             WITH .Buttons(4)
218:                 .Top             = 5
219:                 .Left            = 203
220:                 .Width           = 65
221:                 .Height          = 70
222:                 .Caption         = "Encerrar"
223:                 .Cancel          = .T.
224:                 .FontName        = "Tahoma"
225:                 .FontBold        = .T.
226:                 .FontItalic      = .T.
227:                 .FontSize        = 8

*-- Linhas 250 a 264:
250: 
251:         loc_oPgf.PageCount = 1
252: 
253:         loc_oPgf.Top    = 85
254:         loc_oPgf.Left   = -1
255:         loc_oPgf.Width  = THIS.Width + 2
256:         loc_oPgf.Height = THIS.Height - 85
257:         loc_oPgf.Tabs   = .F.
258: 
259:         loc_oPgf.Page1.Caption   = "Filtros"
260:         loc_oPgf.Page1.FontName  = "Tahoma"
261:         loc_oPgf.Page1.FontSize  = 8
262:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
263:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
264:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 278 a 305:
278:         loc_oPg = THIS.pgf_4c_Paginas.Page1
279: 
280:         *-- Label "Sele??o :"
281:         loc_oPg.AddObject("lbl_4c_Label1", "Label")
282:         WITH loc_oPg.lbl_4c_Label1
283:             .Top       = 38
284:             .Left      = 94
285:             .Width     = 52
286:             .Height    = 15
287:             .Caption   = "Sele" + CHR(231) + CHR(227) + "o :"
288:             .FontName  = "Tahoma"
289:             .FontSize  = 8
290:             .FontBold  = .F.
291:             .ForeColor = RGB(90, 90, 90)
292:             .BackStyle = 0
293:             .Visible   = .T.
294:         ENDWITH
295: 
296:         *-- TextBox c?digo do mailing (Get_codigo -> txt_4c_Codigo)
297:         loc_oPg.AddObject("txt_4c_Codigo", "TextBox")
298:         WITH loc_oPg.txt_4c_Codigo
299:             .Top           = 35
300:             .Left          = 152
301:             .Width         = 77
302:             .Height        = 23
303:             .Value         = ""
304:             .MaxLength     = 10
305:             .FontName      = "Tahoma"

*-- Linhas 314 a 323:
314:         *-- TextBox descri??o do mailing (Get_desc -> txt_4c_Desc)
315:         loc_oPg.AddObject("txt_4c_Desc", "TextBox")
316:         WITH loc_oPg.txt_4c_Desc
317:             .Top           = 35
318:             .Left          = 231
319:             .Width         = 316
320:             .Height        = 23
321:             .Value         = ""
322:             .MaxLength     = 30
323:             .FontName      = "Tahoma"

*-- Linhas 330 a 432:
330:         ENDWITH
331: 
332:         *-- Label "Incluir Campos :"
333:         loc_oPg.AddObject("lbl_4c_Label3", "Label")
334:         WITH loc_oPg.lbl_4c_Label3
335:             .Top       = 63
336:             .Left      = 61
337:             .Width     = 82
338:             .Height    = 15
339:             .Caption   = "Incluir Campos :"
340:             .FontName  = "Tahoma"
341:             .FontSize  = 8
342:             .FontBold  = .F.
343:             .ForeColor = RGB(90, 90, 90)
344:             .BackStyle = 0
345:             .Visible   = .T.
346:         ENDWITH
347: 
348:         *-- CheckBox Endere?os
349:         loc_oPg.AddObject("chk_4c_ChkEnderecos", "CheckBox")
350:         WITH loc_oPg.chk_4c_ChkEnderecos
351:             .Top           = 63
352:             .Left          = 154
353:             .Width         = 80
354:             .Height        = 15
355:             .Caption       = "Endere" + CHR(231) + "os"
356:             .Value         = 1
357:             .FontName      = "Tahoma"
358:             .FontSize      = 8
359:             .BackStyle     = 0
360:             .Alignment     = 0
361:             .SpecialEffect = 1
362:             .ForeColor     = RGB(90, 90, 90)
363:             .Visible       = .T.
364:         ENDWITH
365: 
366:         *-- CheckBox Telefones
367:         loc_oPg.AddObject("chk_4c_ChkTelefones", "CheckBox")
368:         WITH loc_oPg.chk_4c_ChkTelefones
369:             .Top           = 63
370:             .Left          = 261
371:             .Width         = 80
372:             .Height        = 15
373:             .Caption       = "Telefones"
374:             .Value         = 1
375:             .FontName      = "Tahoma"
376:             .FontSize      = 8
377:             .BackStyle     = 0
378:             .Alignment     = 0
379:             .SpecialEffect = 1
380:             .ForeColor     = RGB(90, 90, 90)
381:             .Visible       = .T.
382:         ENDWITH
383: 
384:         *-- CheckBox Datas Comemorativas
385:         loc_oPg.AddObject("chk_4c_ChkDtCom", "CheckBox")
386:         WITH loc_oPg.chk_4c_ChkDtCom
387:             .Top           = 63
388:             .Left          = 365
389:             .Width         = 130
390:             .Height        = 15
391:             .Caption       = "Datas Comemorativas"
392:             .Value         = 1
393:             .FontName      = "Tahoma"
394:             .FontSize      = 8
395:             .BackStyle     = 0
396:             .Alignment     = 0
397:             .SpecialEffect = 1
398:             .ForeColor     = RGB(90, 90, 90)
399:             .Visible       = .T.
400:         ENDWITH
401: 
402:         *-- CheckBox Classifica??o
403:         loc_oPg.AddObject("chk_4c_ChkClassif", "CheckBox")
404:         WITH loc_oPg.chk_4c_ChkClassif
405:             .Top           = 83
406:             .Left          = 154
407:             .Width         = 90
408:             .Height        = 15
409:             .Caption       = "Classifica" + CHR(231) + CHR(227) + "o"
410:             .Value         = 1
411:             .FontName      = "Tahoma"
412:             .FontSize      = 8
413:             .BackStyle     = 0
414:             .Alignment     = 0
415:             .SpecialEffect = 1
416:             .ForeColor     = RGB(90, 90, 90)
417:             .Visible       = .T.
418:         ENDWITH
419: 
420:         *-- CheckBox Representante
421:         loc_oPg.AddObject("chk_4c_ChkRepres", "CheckBox")
422:         WITH loc_oPg.chk_4c_ChkRepres
423:             .Top           = 83
424:             .Left          = 261
425:             .Width         = 100
426:             .Height        = 15
427:             .Caption       = "Representante"
428:             .Value         = 1
429:             .FontName      = "Tahoma"
430:             .FontSize      = 8
431:             .BackStyle     = 0
432:             .Alignment     = 0

*-- Linhas 448 a 599:
448:         loc_oPg = THIS.pgf_4c_Paginas.Page1
449: 
450:         *-- Label "Ordem da Impress?o :"
451:         loc_oPg.AddObject("lbl_4c_Label2", "Label")
452:         WITH loc_oPg.lbl_4c_Label2
453:             .Top       = 105
454:             .Left      = 31
455:             .Width     = 115
456:             .Height    = 15
457:             .Caption   = "Ordem da Impress" + CHR(227) + "o :"
458:             .FontName  = "Tahoma"
459:             .FontSize  = 8
460:             .FontBold  = .F.
461:             .ForeColor = RGB(90, 90, 90)
462:             .BackStyle = 0
463:             .Visible   = .T.
464:         ENDWITH
465: 
466:         *-- OptionGroup Ordem de Impress?o (6 op??es)
467:         *   Original: Option.Top=190, Left=154, Width=283, Height=58, Value=2(CEP)
468:         loc_oPg.AddObject("opt_4c_Option", "OptionGroup")
469:         loc_oPg.opt_4c_Option.ButtonCount = 6
470:         WITH loc_oPg.opt_4c_Option
471:             .Top           = 105
472:             .Left          = 154
473:             .Width         = 283
474:             .Height        = 58
475:             .BackStyle     = 0
476:             .SpecialEffect = 1
477:             .BorderColor   = RGB(90, 90, 90)
478:             .Visible       = .T.
479:         ENDWITH
480:         WITH loc_oPg.opt_4c_Option.Buttons(1)
481:             .Caption   = "Alfab" + CHR(233) + "tica"
482:             .Left      = 5
483:             .Top       = 21
484:             .Width     = 66
485:             .Height    = 15
486:             .FontName  = "Tahoma"
487:             .FontSize  = 8
488:             .BackStyle = 0
489:             .ForeColor = RGB(90, 90, 90)
490:         ENDWITH
491:         WITH loc_oPg.opt_4c_Option.Buttons(2)
492:             .Caption   = "CEP"
493:             .Left      = 5
494:             .Top       = 4
495:             .Width     = 37
496:             .Height    = 15
497:             .FontName  = "Tahoma"
498:             .FontSize  = 8
499:             .BackStyle = 0
500:             .ForeColor = RGB(90, 90, 90)
501:         ENDWITH
502:         WITH loc_oPg.opt_4c_Option.Buttons(3)
503:             .Caption   = "Data de Nascimento"
504:             .Left      = 5
505:             .Top       = 40
506:             .Width     = 114
507:             .Height    = 15
508:             .FontName  = "Tahoma"
509:             .FontSize  = 8
510:             .BackStyle = 0
511:             .ForeColor = RGB(90, 90, 90)
512:         ENDWITH
513:         WITH loc_oPg.opt_4c_Option.Buttons(4)
514:             .Caption   = "Data de Casamento"
515:             .Left      = 143
516:             .Top       = 4
517:             .Width     = 113
518:             .Height    = 15
519:             .FontName  = "Tahoma"
520:             .FontSize  = 8
521:             .BackStyle = 0
522:             .ForeColor = RGB(90, 90, 90)
523:         ENDWITH
524:         WITH loc_oPg.opt_4c_Option.Buttons(5)
525:             .Caption   = "Nascimento C" + CHR(244) + "njuge"
526:             .Left      = 143
527:             .Top       = 21
528:             .Width     = 116
529:             .Height    = 15
530:             .FontName  = "Tahoma"
531:             .FontSize  = 8
532:             .BackStyle = 0
533:             .ForeColor = RGB(90, 90, 90)
534:         ENDWITH
535:         WITH loc_oPg.opt_4c_Option.Buttons(6)
536:             .Caption   = "Data Comemorativa"
537:             .Left      = 143
538:             .Top       = 40
539:             .Width     = 113
540:             .Height    = 15
541:             .FontName  = "Tahoma"
542:             .FontSize  = 8
543:             .BackStyle = 0
544:             .ForeColor = RGB(90, 90, 90)
545:         ENDWITH
546:         loc_oPg.opt_4c_Option.Value = 2
547: 
548:         *-- OptionGroup Dire??o da Ordem (Descendente / Ascendente)
549:         *   Original: OpOrdem.Top=190, Left=445, Width=102, Height=58, Value=2(Asc)
550:         loc_oPg.AddObject("opt_4c_OpOrdem", "OptionGroup")
551:         loc_oPg.opt_4c_OpOrdem.ButtonCount = 2
552:         WITH loc_oPg.opt_4c_OpOrdem
553:             .Top           = 105
554:             .Left          = 445
555:             .Width         = 106
556:             .Height        = 58
557:             .BackStyle     = 0
558:             .SpecialEffect = 1
559:             .BorderColor   = RGB(90, 90, 90)
560:             .Visible       = .T.
561:         ENDWITH
562:         WITH loc_oPg.opt_4c_OpOrdem.Buttons(1)
563:             .Caption   = "Descendente"
564:             .Left      = 5
565:             .Top       = 10
566:             .Width     = 91
567:             .Height    = 17
568:             .FontName  = "Tahoma"
569:             .FontSize  = 8
570:             .BackStyle = 0
571:             .ForeColor = RGB(90, 90, 90)
572:         ENDWITH
573:         WITH loc_oPg.opt_4c_OpOrdem.Buttons(2)
574:             .Caption   = "Ascendente"
575:             .Left      = 5
576:             .Top       = 32
577:             .Width     = 91
578:             .Height    = 17
579:             .FontName  = "Tahoma"
580:             .FontSize  = 8
581:             .BackStyle = 0
582:             .ForeColor = RGB(90, 90, 90)
583:         ENDWITH
584:         loc_oPg.opt_4c_OpOrdem.Value = 2
585: 
586:         *-- Vincular KeyPress nos campos com lookup (F4=115, ENTER=13, TAB=9)
587:         BINDEVENT(loc_oPg.txt_4c_Codigo, "KeyPress", THIS, "TeclaCodigo")
588:         BINDEVENT(loc_oPg.txt_4c_Desc,   "KeyPress", THIS, "TeclaDesc")
589: 
590:         *-- DblClick tamb?m abre lookup
591:         BINDEVENT(loc_oPg.txt_4c_Codigo, "DblClick", THIS, "AbrirBuscaCodigo")
592:         BINDEVENT(loc_oPg.txt_4c_Desc,   "DblClick", THIS, "AbrirBuscaDesc")
593: 
594:         THIS.AtualizarEstadoDescricao()
595:     ENDPROC
596: 
597:     *--------------------------------------------------------------------------
598:     * LimparCampos - Restaura filtros para valores padr?o
599:     *   Sele??o em branco, todos os campos incluidos, ordem por CEP Ascendente

*-- Linhas 607 a 628:
607:             loc_oPg.chk_4c_ChkEnderecos.Value    = 1
608:             loc_oPg.chk_4c_ChkTelefones.Value    = 1
609:             loc_oPg.chk_4c_ChkDtCom.Value        = 1
610:             loc_oPg.chk_4c_ChkClassif.Value      = 1
611:             loc_oPg.chk_4c_ChkRepres.Value       = 1
612:             loc_oPg.opt_4c_Option.Value          = 2
613:             loc_oPg.opt_4c_OpOrdem.Value         = 2
614:             THIS.AtualizarEstadoDescricao()
615:         CATCH TO loc_oErro
616:             MsgErro(loc_oErro.Message, "Erro")
617:         ENDTRY
618:     ENDPROC
619: 
620:     *--------------------------------------------------------------------------
621:     * AtualizarEstadoDescricao - Simula o "When" original de Get_desc
622:     *   Get_desc.When: Return Empty(ThisForm.Get_codigo.Value)
623:     *   Campo de descri??o s? ? edit?vel quando c?digo est? vazio.
624:     *--------------------------------------------------------------------------
625:     PROTECTED PROCEDURE AtualizarEstadoDescricao()
626:         LOCAL loc_oPg
627:         TRY
628:             loc_oPg = THIS.pgf_4c_Paginas.Page1

*-- Linhas 644 a 665:
644:             .this_nImpEnderecos   = loc_oPg.chk_4c_ChkEnderecos.Value
645:             .this_nImpTelefones   = loc_oPg.chk_4c_ChkTelefones.Value
646:             .this_nImpDtCom       = loc_oPg.chk_4c_ChkDtCom.Value
647:             .this_nImpClassif     = loc_oPg.chk_4c_ChkClassif.Value
648:             .this_nImpRepres      = loc_oPg.chk_4c_ChkRepres.Value
649:             .this_nOrdemImpressao = loc_oPg.opt_4c_Option.Value
650:             .this_nOrdemDirecao   = loc_oPg.opt_4c_OpOrdem.Value
651:         ENDWITH
652:     ENDPROC
653: 
654:     *--------------------------------------------------------------------------
655:     * AlternarPagina - Reposiciona foco no campo de c?digo
656:     *   Form de relatorio tem s? 1 p?gina; alterna foco para o primeiro filtro.
657:     *--------------------------------------------------------------------------
658:     PROCEDURE AlternarPagina(par_nPagina)
659:         LOCAL loc_oPgf, loc_oPg
660:         TRY
661:             loc_oPgf = THIS.pgf_4c_Paginas
662:             IF VARTYPE(loc_oPgf) != "O"
663:                 RETURN
664:             ENDIF
665:             loc_oPgf.ActivePage = 1

*-- Linhas 948 a 974:
948:             ENDIF
949:             loc_oPg = THIS.pgf_4c_Paginas.Page1
950:             WITH THIS.this_oRelatorio
951:                 loc_oPg.txt_4c_Codigo.Value          = .this_cCodigos
952:                 loc_oPg.txt_4c_Desc.Value            = .this_cDescs
953:                 loc_oPg.chk_4c_ChkEnderecos.Value    = .this_nImpEnderecos
954:                 loc_oPg.chk_4c_ChkTelefones.Value    = .this_nImpTelefones
955:                 loc_oPg.chk_4c_ChkDtCom.Value        = .this_nImpDtCom
956:                 loc_oPg.chk_4c_ChkClassif.Value      = .this_nImpClassif
957:                 loc_oPg.chk_4c_ChkRepres.Value       = .this_nImpRepres
958:                 loc_oPg.opt_4c_Option.Value          = .this_nOrdemImpressao
959:                 loc_oPg.opt_4c_OpOrdem.Value         = .this_nOrdemDirecao
960:             ENDWITH
961:             THIS.AtualizarEstadoDescricao()
962:         CATCH TO loc_oErro
963:             MsgErro(loc_oErro.Message, "Erro")
964:         ENDTRY
965:     ENDPROC
966: 
967:     *--------------------------------------------------------------------------
968:     * HabilitarCampos - Habilita ou desabilita campos de filtro
969:     *--------------------------------------------------------------------------
970:     PROCEDURE HabilitarCampos(par_lHabilitar)
971:         LOCAL loc_oPg, loc_lHab
972:         TRY
973:             IF PCOUNT() = 0
974:                 loc_lHab = .T.

*-- Linhas 980 a 1001:
980:             loc_oPg.chk_4c_ChkEnderecos.Enabled = loc_lHab
981:             loc_oPg.chk_4c_ChkTelefones.Enabled = loc_lHab
982:             loc_oPg.chk_4c_ChkDtCom.Enabled     = loc_lHab
983:             loc_oPg.chk_4c_ChkClassif.Enabled   = loc_lHab
984:             loc_oPg.chk_4c_ChkRepres.Enabled    = loc_lHab
985:             loc_oPg.opt_4c_Option.Enabled        = loc_lHab
986:             loc_oPg.opt_4c_OpOrdem.Enabled       = loc_lHab
987:             IF loc_lHab
988:                 THIS.AtualizarEstadoDescricao()
989:             ELSE
990:                 loc_oPg.txt_4c_Desc.Enabled = .F.
991:             ENDIF
992:         CATCH TO loc_oErro
993:             MsgErro(loc_oErro.Message, "Erro")
994:         ENDTRY
995:     ENDPROC
996: 
997:     *--------------------------------------------------------------------------
998:     * AjustarBotoesPorModo - Todos os bot?es sempre habilitados em relatorio
999:     *--------------------------------------------------------------------------
1000:     PROCEDURE AjustarBotoesPorModo()
1001:         TRY


### BO (C:\4c\projeto\app\classes\SigReIprBO.prg):
*==============================================================================
* SIGREIPRBO.PRG
* Business Object para Relatorio de Mailing (SIGREIPR)
* Herda de: RelatorioBase
* Tarefa: task129
*==============================================================================

DEFINE CLASS SigReIprBO AS RelatorioBase

    *-- Filtro: selecao do mailing (SigMlItn)
    this_cCodigos          = ""
    this_cDescs            = ""

    *-- Opcoes de inclusao de campos no relatorio
    this_nImpEnderecos     = 1
    this_nImpTelefones     = 1
    this_nImpClassif       = 1
    this_nImpRepres        = 1
    this_nImpDtCom         = 1

    *-- Opcoes de ordenacao
    *-- this_nOrdemImpressao: 1=Alfab, 2=CEP, 3=DtNasc, 4=DtCasam, 5=NascConj, 6=DtComem
    this_nOrdemImpressao   = 2
    *-- this_nOrdemDirecao: 1=Descendente, 2=Ascendente
    this_nOrdemDirecao     = 2

    *-- Configuracao do relatorio
    this_cCursorDados      = "cursor_4c_MalaRelacao"
    this_cCaminhoFRX       = ""
    this_cTituloRelatorio  = ""
    this_cSubtituloRelatorio = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO do relatorio de Mailing
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cTabela             = "SigMlCab"
            THIS.this_cCampoChave         = "cIdChaves"
            THIS.this_cTituloRelatorio    = "Rela" + CHR(231) + CHR(227) + "o Para Mala Direta"
            THIS.this_cCaminhoFRX         = gc_4c_CaminhoReports + "SigMlda.frx"

            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigReIprBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursor Relacao e CsCabecalho para SigMlda.frx
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_nImpTel, loc_nImpEnd, loc_nImpCom, loc_nImpClf, loc_nImpRep
        LOCAL loc_cTitulo, loc_cSubTit, loc_cCodigos
        LOCAL loc_cQueryRep, loc_nRep

        loc_lSucesso = .F.
        TRY
            loc_nImpTel  = THIS.this_nImpTelefones
            loc_nImpEnd  = THIS.this_nImpEnderecos
            loc_nImpCom  = THIS.this_nImpDtCom
            loc_nImpClf  = THIS.this_nImpClassif
            loc_nImpRep  = THIS.this_nImpRepres
            loc_cCodigos = ALLTRIM(THIS.this_cCodigos)

            loc_cTitulo = "Rela" + CHR(231) + CHR(227) + "o Para Mala Direta"
            loc_cSubTit = loc_cCodigos + " - " + ALLTRIM(THIS.this_cDescs)

            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
            CREATE CURSOR CsCabecalho (Titulo C(100), SubTitulo C(100))
            INSERT INTO CsCabecalho (Titulo, SubTitulo) VALUES (loc_cTitulo, loc_cSubTit)

            IF USED("cursor_4c_MalaCab")
                USE IN cursor_4c_MalaCab
            ENDIF

            loc_cSQL = "SELECT a.IClis, a.RClis, a.Profiss, " + ;
                       "a.Nascs, a.UltComps, a.Sexos, a.Tel1s, a.Tel2s, " + ;
                       "a.Endes, a.Nums, a.Compls, a.Bairs, a.Cidas, " + ;
                       "a.Ceps, a.Estas, a.Quebras, " + ;
                       "a.cIdChaves, b.DDDs, a.DesDtCom, a.DatDtCom, " + ;
                       "a.cpfs, a.TelDtCom, a.DtCasas, " + ;
                       "a.DtnCons, b.eMails, b.Codigos " + ;
                       "FROM SigMlCab a INNER JOIN SigCdCli b ON b.IClis = a.IClis " + ;
                       "WHERE a.Codigos = " + EscaparSQL(loc_cCodigos) + " " + ;
                       "ORDER BY a.IClis, a.RClis"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MalaCab")

            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados de mala direta"
            ELSE
                IF USED("Relacao")
                    USE IN Relacao
                ENDIF

                SELECT IClis, RClis, Profiss, ;
                       NVL(Nascs, {}) AS Nascs, ;
                       NVL(UltComps, {}) AS UltComps, ;
                       Sexos, Tel1s, Tel2s, ;
                       Endes, Nums, Compls, Bairs, Cidas, Ceps, Estas, Quebras, ;
                       loc_nImpTel AS ImpTel, ;
                       loc_nImpEnd AS ImpEnd, ;
                       loc_nImpCom AS ImpCom, ;
                       loc_nImpClf AS ImpClf, ;
                       loc_nImpRep AS ImpRep, ;
                       DDDs, DesDtCom, ;
                       NVL(IIF(YEAR(DatDtCom) <= 1900, .NULL., DatDtCom), {}) AS DatDtCom, ;
                       cpfs, TelDtCom, ;
                       NVL(DtCasas, {}) AS DtCasas, ;
                       NVL(DtnCons, {}) AS DtnCons, ;
                       eMails, Codigos, ;
                       SPACE(10) AS CodReps ;
                FROM cursor_4c_MalaCab ;
                INTO CURSOR Relacao READWRITE

                IF loc_nImpRep = 1
                    SELECT Relacao
                    SCAN
                        IF USED("cursor_4c_LocalCli")
                            USE IN cursor_4c_LocalCli
                        ENDIF
                        loc_cQueryRep = "SELECT ContaVens FROM SigCdCli " + ;
                                       "WHERE IClis = " + ;
                                       EscaparSQL(ALLTRIM(Relacao.IClis))
                        loc_nRep = SQLEXEC(gnConnHandle, loc_cQueryRep, ;
                                           "cursor_4c_LocalCli")
                        IF loc_nRep > 0
                            SELECT cursor_4c_LocalCli
                            GO TOP
                            IF !EOF()
                                REPLACE CodReps WITH ;
                                        ALLTRIM(cursor_4c_LocalCli.ContaVens) ;
                                        IN Relacao
                            ENDIF
                            USE IN cursor_4c_LocalCli
                        ENDIF
                    ENDSCAN
                ENDIF

                SELECT Relacao
                THIS.AplicarOrdenacao()
                GO TOP IN Relacao

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SigReIprBO.PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarOrdenacao - Indexa cursor Relacao conforme opcoes de ordenacao
    *--------------------------------------------------------------------------
    PROCEDURE AplicarOrdenacao()
        LOCAL loc_nOrdem, loc_nDirecao, loc_cDesc
        loc_nOrdem   = THIS.this_nOrdemImpressao
        loc_nDirecao = THIS.this_nOrdemDirecao
        loc_cDesc    = IIF(loc_nDirecao = 1, " DESCENDING", "")

        SELECT Relacao
        DO CASE
            CASE loc_nOrdem = 1
                IF loc_nDirecao = 1
                    INDEX ON Quebras + RClis + IClis DESCENDING TAG RClis
                ELSE
                    INDEX ON Quebras + RClis + IClis TAG RClis
                ENDIF
            CASE loc_nOrdem = 2
                IF loc_nDirecao = 1
                    INDEX ON Quebras + Ceps + IClis DESCENDING TAG Ceps
                ELSE
                    INDEX ON Quebras + Ceps + IClis TAG Ceps
                ENDIF
            CASE loc_nOrdem = 3
                IF loc_nDirecao = 1
                    INDEX ON Quebras + SUBSTR(DTOS(Nascs), 5) + IClis DESCENDING TAG Nascs
                ELSE
                    INDEX ON Quebras + SUBSTR(DTOS(Nascs), 5) + IClis TAG Nascs
                ENDIF
            CASE loc_nOrdem = 4
                IF loc_nDirecao = 1
                    INDEX ON Quebras + SUBSTR(DTOS(DtCasas), 5) + IClis DESCENDING TAG Nascs
                ELSE
                    INDEX ON Quebras + SUBSTR(DTOS(DtCasas), 5) + IClis TAG Nascs
                ENDIF
            CASE loc_nOrdem = 5
                IF loc_nDirecao = 1
                    INDEX ON Quebras + SUBSTR(DTOS(DtnCons), 5) + IClis DESCENDING TAG Nascs
                ELSE
                    INDEX ON Quebras + SUBSTR(DTOS(DtnCons), 5) + IClis TAG Nascs
                ENDIF
            CASE loc_nOrdem = 6
                IF loc_nDirecao = 1
                    INDEX ON Quebras + SUBSTR(DTOS(DatDtCom), 5) + IClis DESCENDING TAG Nascs
                ELSE
                    INDEX ON Quebras + SUBSTR(DTOS(DatDtCom), 5) + IClis TAG Nascs
                ENDIF
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Executa relatorio em modo preview
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cCaminhoFRX) PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SigReIprBO.Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Executa relatorio para impressora com dialogo de selecao
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cCaminhoFRX) TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SigReIprBO.Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Documento - Executa relatorio para impressora sem dialogo
    *--------------------------------------------------------------------------
    PROCEDURE Documento()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cCaminhoFRX) TO PRINTER
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SigReIprBO.Documento")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna codigo do mailing selecionado
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigos)
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro registrada
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores abertos pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_MalaCab")
            USE IN cursor_4c_MalaCab
        ENDIF
        IF USED("CsCabecalho")
            USE IN CsCabecalho
        ENDIF
        IF USED("Relacao")
            USE IN Relacao
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

