# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [FONTNAME-ERRADO] Linha 215: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 236: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 258: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREAPR.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1377 linhas total):

*-- Linhas 81 a 89:
81:         loc_lSucesso   = .F.
82:         loc_lContinuar = .T.
83:         TRY
84:             THIS.Caption = "Relat" + CHR(243) + "rio de Altera" + CHR(231) + CHR(245) + "es de Produtos"
85: 
86:             IF TYPE("gc_4c_CaminhoIcones") = "U"
87:                 gc_4c_CaminhoIcones = ""
88:             ENDIF
89:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 103 a 112:
103:                 THIS.ConfigurarPaginaLista()
104:                 THIS.LimparCampos()
105: 
106:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
107:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
108: 
109:                 THIS.Visible = .T.
110:                 loc_lSucesso = .T.
111:             ENDIF
112:         CATCH TO loc_oErro

*-- Linhas 120 a 200:
120: 
121:     *--------------------------------------------------------------------------
122:     * ConfigurarCabecalho - Container escuro superior com titulo do relatorio
123:     *   Equivalente ao cntSombra.Top=0, Left=-1 do frmrelatorio legado.
124:     *   Width = THIS.Width (cobre toda a faixa superior).
125:     *--------------------------------------------------------------------------
126:     PROTECTED PROCEDURE ConfigurarCabecalho()
127:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
128:         WITH THIS.cnt_4c_Cabecalho
129:             .Top         = 0
130:             .Left        = 0
131:             .Width       = THIS.Width
132:             .Height      = 80
133:             .BackStyle   = 1
134:             .BackColor   = RGB(100, 100, 100)
135:             .BorderWidth = 0
136:             .Visible     = .T.
137: 
138:             .AddObject("lbl_4c_Sombra", "Label")
139:             WITH .lbl_4c_Sombra
140:                 .Top       = 22
141:                 .Left      = 22
142:                 .Width     = THIS.Width
143:                 .Height    = 30
144:                 .Caption   = "Relat" + CHR(243) + "rio de Altera" + CHR(231) + CHR(245) + "es de Produtos"
145:                 .FontName  = "Tahoma"
146:                 .FontSize  = 14
147:                 .FontBold  = .T.
148:                 .ForeColor = RGB(0, 0, 0)
149:                 .BackStyle = 0
150:                 .Visible   = .T.
151:             ENDWITH
152: 
153:             .AddObject("lbl_4c_Titulo", "Label")
154:             WITH .lbl_4c_Titulo
155:                 .Top       = 20
156:                 .Left      = 20
157:                 .Width     = THIS.Width
158:                 .Height    = 30
159:                 .Caption   = "Relat" + CHR(243) + "rio de Altera" + CHR(231) + CHR(245) + "es de Produtos"
160:                 .FontName  = "Tahoma"
161:                 .FontSize  = 14
162:                 .FontBold  = .T.
163:                 .ForeColor = RGB(255, 255, 255)
164:                 .BackStyle = 0
165:                 .Visible   = .T.
166:             ENDWITH
167:         ENDWITH
168:     ENDPROC
169: 
170:     *--------------------------------------------------------------------------
171:     * ConfigurarBotoes - CommandGroup de botoes do relatorio (btnReport legado)
172:     *   Original: btnReport.Left=526, Top=3, Width~270, Height~85
173:     *   Botoes: Visualiza(Left=6), Imprime(72), DocExcel(138), Sair(204) - W=60
174:     *--------------------------------------------------------------------------
175:     PROTECTED PROCEDURE ConfigurarBotoes()
176:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
177:         WITH THIS.cmg_4c_Botoes
178:             .Top           = 0
179:             .Left          = 529
180:             .Width         = 273
181:             .Height        = 80
182:             .ButtonCount   = 4
183:             .BackStyle     = 0
184:             .BorderStyle   = 0
185:             .BorderColor   = RGB(136, 189, 188)
186:             .SpecialEffect = 1
187:             .Themes        = .F.
188:             .Visible       = .T.
189: 
190:             WITH .Buttons(1)
191:                 .Top             = 5
192:                 .Left            = 5
193:                 .Width           = 65
194:                 .Height          = 70
195:                 .Caption         = "Visualizar"
196:                 .FontBold        = .T.
197:                 .FontItalic      = .T.
198:                 .BackColor       = RGB(255, 255, 255)
199:                 .ForeColor       = RGB(90, 90, 90)
200:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 207 a 221:
207:             ENDWITH
208: 
209:             WITH .Buttons(2)
210:                 .Top             = 5
211:                 .Left            = 71
212:                 .Width           = 65
213:                 .Height          = 70
214:                 .Caption         = "Imprimir"
215:                 .FontName        = "Comic Sans MS"
216:                 .FontBold        = .T.
217:                 .FontItalic      = .T.
218:                 .FontSize        = 8
219:                 .BackColor       = RGB(255, 255, 255)
220:                 .ForeColor       = RGB(90, 90, 90)
221:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"

*-- Linhas 228 a 242:
228:             ENDWITH
229: 
230:             WITH .Buttons(3)
231:                 .Top             = 5
232:                 .Left            = 137
233:                 .Width           = 65
234:                 .Height          = 70
235:                 .Caption         = "Excel"
236:                 .FontName        = "Comic Sans MS"
237:                 .FontBold        = .T.
238:                 .FontItalic      = .T.
239:                 .FontSize        = 8
240:                 .BackColor       = RGB(255, 255, 255)
241:                 .ForeColor       = RGB(90, 90, 90)
242:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"

*-- Linhas 249 a 264:
249:             ENDWITH
250: 
251:             WITH .Buttons(4)
252:                 .Top             = 5
253:                 .Left            = 203
254:                 .Width           = 65
255:                 .Height          = 70
256:                 .Caption         = "Encerrar"
257:                 .Cancel          = .T.
258:                 .FontName        = "Comic Sans MS"
259:                 .FontBold        = .T.
260:                 .FontItalic      = .T.
261:                 .FontSize        = 8
262:                 .BackColor       = RGB(255, 255, 255)
263:                 .ForeColor       = RGB(90, 90, 90)
264:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"

*-- Linhas 287 a 301:
287: 
288:         loc_oPgf.PageCount = 1
289: 
290:         loc_oPgf.Top    = 85
291:         loc_oPgf.Left   = -1
292:         loc_oPgf.Width  = THIS.Width + 2
293:         loc_oPgf.Height = THIS.Height - 85
294:         loc_oPgf.Tabs   = .F.
295: 
296:         loc_oPgf.Page1.Caption   = "Filtros"
297:         loc_oPgf.Page1.FontName  = "Tahoma"
298:         loc_oPgf.Page1.FontSize  = 8
299:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
300:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
301:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 319 a 477:
319:     *   em pgf_4c_Paginas.Page1 (REPORT flat sem Page2 separada).
320:     *   Controles: Data Inicial, Grupo (cod+desc), Produto (cod+desc), Linha
321:     *   (cod+desc). Total: 4 labels + 7 textboxes = 11 controles.
322:     *   Coordenadas: top_original - 85 (PageFrame.Top=85 desloca a origem).
323:     *   Chamado por InicializarForm() ANTES de ConfigurarPaginaLista() para
324:     *   que os BINDEVENTs (em ConfigurarPaginaLista) encontrem os controles.
325:     *--------------------------------------------------------------------------
326:     PROTECTED PROCEDURE ConfigurarPaginaDados()
327:         LOCAL loc_oPg
328:         loc_oPg = THIS.pgf_4c_Paginas.Page1
329: 
330:         *-- lbl_4c_Label1 "Data Inicial :" (Say1: top=98, left=189)
331:         loc_oPg.AddObject("lbl_4c_Label1", "Label")
332:         WITH loc_oPg.lbl_4c_Label1
333:             .Top       = 13
334:             .Left      = 189
335:             .Width     = 70
336:             .Height    = 15
337:             .Caption   = "Data Inicial :"
338:             .FontName  = "Tahoma"
339:             .FontSize  = 8
340:             .ForeColor = RGB(90, 90, 90)
341:             .BackStyle = 0
342:             .Visible   = .T.
343:         ENDWITH
344: 
345:         *-- txt_4c_DtInicial (getDtInicial: top=95, left=255)
346:         loc_oPg.AddObject("txt_4c_DtInicial", "TextBox")
347:         WITH loc_oPg.txt_4c_DtInicial
348:             .Top      = 10
349:             .Left     = 255
350:             .Width    = 80
351:             .Height   = 23
352:             .FontName = "Tahoma"
353:             .FontSize = 8
354:             .Value    = {}
355:             .Visible  = .T.
356:         ENDWITH
357: 
358:         *-- lbl_4c_Label2 "Grupo :" (Say2: top=123, left=213)
359:         loc_oPg.AddObject("lbl_4c_Label2", "Label")
360:         WITH loc_oPg.lbl_4c_Label2
361:             .Top       = 38
362:             .Left      = 213
363:             .Width     = 38
364:             .Height    = 15
365:             .Caption   = "Grupo :"
366:             .FontName  = "Tahoma"
367:             .FontSize  = 8
368:             .ForeColor = RGB(90, 90, 90)
369:             .BackStyle = 0
370:             .Visible   = .T.
371:         ENDWITH
372: 
373:         *-- txt_4c_Grupo (getGrupo: top=120, left=255, width=31)
374:         loc_oPg.AddObject("txt_4c_Grupo", "TextBox")
375:         WITH loc_oPg.txt_4c_Grupo
376:             .Top      = 35
377:             .Left     = 255
378:             .Width    = 31
379:             .Height   = 23
380:             .FontName = "Tahoma"
381:             .FontSize = 8
382:             .Value    = ""
383:             .Visible  = .T.
384:         ENDWITH
385: 
386:         *-- txt_4c_DGrupo (getDGrupo: top=120, left=288, width=181)
387:         loc_oPg.AddObject("txt_4c_DGrupo", "TextBox")
388:         WITH loc_oPg.txt_4c_DGrupo
389:             .Top      = 35
390:             .Left     = 288
391:             .Width    = 181
392:             .Height   = 23
393:             .FontName = "Tahoma"
394:             .FontSize = 8
395:             .Value    = ""
396:             .Visible  = .T.
397:         ENDWITH
398: 
399:         *-- lbl_4c_Label3 "Produto :" (Say3: top=148, left=204)
400:         loc_oPg.AddObject("lbl_4c_Label3", "Label")
401:         WITH loc_oPg.lbl_4c_Label3
402:             .Top       = 63
403:             .Left      = 204
404:             .Width     = 47
405:             .Height    = 15
406:             .Caption   = "Produto :"
407:             .FontName  = "Tahoma"
408:             .FontSize  = 8
409:             .ForeColor = RGB(90, 90, 90)
410:             .BackStyle = 0
411:             .Visible   = .T.
412:         ENDWITH
413: 
414:         *-- txt_4c_CPros (getCPros: top=145, left=255, width=108)
415:         loc_oPg.AddObject("txt_4c_CPros", "TextBox")
416:         WITH loc_oPg.txt_4c_CPros
417:             .Top      = 60
418:             .Left     = 255
419:             .Width    = 108
420:             .Height   = 23
421:             .FontName = "Tahoma"
422:             .FontSize = 8
423:             .Value    = ""
424:             .Visible  = .T.
425:         ENDWITH
426: 
427:         *-- txt_4c_DPros (getDPros: top=145, left=365, width=290)
428:         loc_oPg.AddObject("txt_4c_DPros", "TextBox")
429:         WITH loc_oPg.txt_4c_DPros
430:             .Top      = 60
431:             .Left     = 365
432:             .Width    = 290
433:             .Height   = 23
434:             .FontName = "Tahoma"
435:             .FontSize = 8
436:             .Value    = ""
437:             .Visible  = .T.
438:         ENDWITH
439: 
440:         *-- lbl_4c_Label16 "Linha :" (Say16: top=173, left=217)
441:         loc_oPg.AddObject("lbl_4c_Label16", "Label")
442:         WITH loc_oPg.lbl_4c_Label16
443:             .Top       = 88
444:             .Left      = 217
445:             .Width     = 34
446:             .Height    = 15
447:             .Caption   = "Linha :"
448:             .FontName  = "Tahoma"
449:             .FontSize  = 8
450:             .ForeColor = RGB(90, 90, 90)
451:             .BackStyle = 0
452:             .Visible   = .T.
453:         ENDWITH
454: 
455:         *-- txt_4c_Lin (GetLin: top=170, left=255, width=80)
456:         loc_oPg.AddObject("txt_4c_Lin", "TextBox")
457:         WITH loc_oPg.txt_4c_Lin
458:             .Top      = 85
459:             .Left     = 255
460:             .Width    = 80
461:             .Height   = 23
462:             .FontName = "Tahoma"
463:             .FontSize = 8
464:             .Value    = ""
465:             .Visible  = .T.
466:         ENDWITH
467: 
468:         *-- txt_4c_DLin (GetDLin: top=170, left=337, width=290)
469:         loc_oPg.AddObject("txt_4c_DLin", "TextBox")
470:         WITH loc_oPg.txt_4c_DLin
471:             .Top      = 85
472:             .Left     = 337
473:             .Width    = 290
474:             .Height   = 23
475:             .FontName = "Tahoma"
476:             .FontSize = 8
477:             .Value    = ""

*-- Linhas 483 a 651:
483:     * ConfigurarPaginaLista - Adiciona campos de filtro em pgf_4c_Paginas.Page1
484:     *   Nome "Lista" mantido por convencao do pipeline; neste form REPORT a
485:     *   Page1 hospeda os FILTROS (nao ha grid de registros - frmrelatorio FLAT).
486:     *   Coordenadas: top_original - 85 (PageFrame.Top=85 desloca a origem).
487:     *--------------------------------------------------------------------------
488:     PROTECTED PROCEDURE ConfigurarPaginaLista()
489:         LOCAL loc_oPg
490:         loc_oPg = THIS.pgf_4c_Paginas.Page1
491: 
492:         *-- Controles da PARTE SUPERIOR (Data, Grupo, Produto, Linha) sao
493:         *-- criados em ConfigurarPaginaDados() - Fase 5.
494:         *-- Aqui (Fase 4 + extensoes) configuramos a PARTE INFERIOR:
495:         *-- Fornecedor + Diferencas Minimas (Venda/Custo).
496: 
497:         *-- lbl_4c_Lbl_fornecedor "Fornecedor :" (lbl_fornecedor: top=198, left=187)
498:         loc_oPg.AddObject("lbl_4c_Lbl_fornecedor", "Label")
499:         WITH loc_oPg.lbl_4c_Lbl_fornecedor
500:             .Top       = 113
501:             .Left      = 187
502:             .Width     = 64
503:             .Height    = 15
504:             .Caption   = "Fornecedor :"
505:             .FontName  = "Tahoma"
506:             .FontSize  = 8
507:             .ForeColor = RGB(90, 90, 90)
508:             .BackStyle = 0
509:             .Visible   = .T.
510:         ENDWITH
511: 
512:         *-- txt_4c_Fornecedor (getFornecedor: top=195, left=255, width=80)
513:         loc_oPg.AddObject("txt_4c_Fornecedor", "TextBox")
514:         WITH loc_oPg.txt_4c_Fornecedor
515:             .Top      = 110
516:             .Left     = 255
517:             .Width    = 80
518:             .Height   = 23
519:             .FontName = "Tahoma"
520:             .FontSize = 8
521:             .Value    = ""
522:             .Visible  = .T.
523:         ENDWITH
524: 
525:         *-- txt_4c_DFornecedor (getDFornecedor: top=195, left=337, width=290)
526:         loc_oPg.AddObject("txt_4c_DFornecedor", "TextBox")
527:         WITH loc_oPg.txt_4c_DFornecedor
528:             .Top      = 110
529:             .Left     = 337
530:             .Width    = 290
531:             .Height   = 23
532:             .FontName = "Tahoma"
533:             .FontSize = 8
534:             .Value    = ""
535:             .Visible  = .T.
536:         ENDWITH
537: 
538:         *-- lbl_4c_Label5 " Diferenca Minima " (Say5: top=226, left=187)
539:         loc_oPg.AddObject("lbl_4c_Label5", "Label")
540:         WITH loc_oPg.lbl_4c_Label5
541:             .Top       = 141
542:             .Left      = 187
543:             .Width     = 106
544:             .Height    = 15
545:             .Caption   = " Diferen" + CHR(231) + "a M" + CHR(237) + "nima "
546:             .FontName  = "Tahoma"
547:             .FontSize  = 8
548:             .ForeColor = RGB(90, 90, 90)
549:             .BackStyle = 0
550:             .Visible   = .T.
551:         ENDWITH
552: 
553:         *-- shp_4c_Shape1 - linha separadora (Shape1: top=242, left=177, w=450, h=2)
554:         loc_oPg.AddObject("shp_4c_Shape1", "Shape")
555:         WITH loc_oPg.shp_4c_Shape1
556:             .Top         = 157
557:             .Left        = 177
558:             .Width       = 450
559:             .Height      = 2
560:             .BackStyle   = 1
561:             .BackColor   = RGB(200, 200, 200)
562:             .BorderStyle = 1
563:             .Visible     = .T.
564:         ENDWITH
565: 
566:         *-- lbl_4c_Label4 "Venda :" (Say4: top=252, left=212)
567:         loc_oPg.AddObject("lbl_4c_Label4", "Label")
568:         WITH loc_oPg.lbl_4c_Label4
569:             .Top       = 167
570:             .Left      = 212
571:             .Width     = 39
572:             .Height    = 15
573:             .Caption   = "Venda :"
574:             .FontName  = "Tahoma"
575:             .FontSize  = 8
576:             .ForeColor = RGB(90, 90, 90)
577:             .BackStyle = 0
578:             .Visible   = .T.
579:         ENDWITH
580: 
581:         *-- txt_4c_MinVendas (getMinVendas: top=249, left=255, width=52)
582:         loc_oPg.AddObject("txt_4c_MinVendas", "TextBox")
583:         WITH loc_oPg.txt_4c_MinVendas
584:             .Top       = 164
585:             .Left      = 255
586:             .Width     = 52
587:             .Height    = 23
588:             .FontName  = "Tahoma"
589:             .FontSize  = 8
590:             .Value     = 0
591:             .InputMask = "99.99"
592:             .Visible   = .T.
593:         ENDWITH
594: 
595:         *-- lbl_4c_Label6 "%" (Say6: top=253, left=310)
596:         loc_oPg.AddObject("lbl_4c_Label6", "Label")
597:         WITH loc_oPg.lbl_4c_Label6
598:             .Top       = 168
599:             .Left      = 310
600:             .Width     = 13
601:             .Height    = 15
602:             .Caption   = "%"
603:             .FontName  = "Tahoma"
604:             .FontSize  = 8
605:             .ForeColor = RGB(90, 90, 90)
606:             .BackStyle = 0
607:             .Visible   = .T.
608:         ENDWITH
609: 
610:         *-- lbl_4c_Label7 "Custo :" (Say7: top=252, left=351)
611:         loc_oPg.AddObject("lbl_4c_Label7", "Label")
612:         WITH loc_oPg.lbl_4c_Label7
613:             .Top       = 167
614:             .Left      = 351
615:             .Width     = 37
616:             .Height    = 15
617:             .Caption   = "Custo :"
618:             .FontName  = "Tahoma"
619:             .FontSize  = 8
620:             .ForeColor = RGB(90, 90, 90)
621:             .BackStyle = 0
622:             .Visible   = .T.
623:         ENDWITH
624: 
625:         *-- txt_4c_MinCustos (getMinCustos: top=249, left=391, width=52)
626:         loc_oPg.AddObject("txt_4c_MinCustos", "TextBox")
627:         WITH loc_oPg.txt_4c_MinCustos
628:             .Top       = 164
629:             .Left      = 391
630:             .Width     = 52
631:             .Height    = 23
632:             .FontName  = "Tahoma"
633:             .FontSize  = 8
634:             .Value     = 0
635:             .InputMask = "99.99"
636:             .Visible   = .T.
637:         ENDWITH
638: 
639:         *-- lbl_4c_Label8 "%" (Say8: top=253, left=446)
640:         loc_oPg.AddObject("lbl_4c_Label8", "Label")
641:         WITH loc_oPg.lbl_4c_Label8
642:             .Top       = 168
643:             .Left      = 446
644:             .Width     = 13
645:             .Height    = 15
646:             .Caption   = "%"
647:             .FontName  = "Tahoma"
648:             .FontSize  = 8
649:             .ForeColor = RGB(90, 90, 90)
650:             .BackStyle = 0
651:             .Visible   = .T.

*-- Linhas 1315 a 1334:
1315: 
1316:         WITH THIS.this_oRelatorio
1317:             IF VARTYPE(.this_dDtInicial) = "D" AND !EMPTY(.this_dDtInicial)
1318:                 loc_oPg.txt_4c_DtInicial.Value = .this_dDtInicial
1319:             ENDIF
1320:             loc_oPg.txt_4c_Grupo.Value         = .this_cGrupo
1321:             loc_oPg.txt_4c_DGrupo.Value        = .this_cDGrupo
1322:             loc_oPg.txt_4c_CPros.Value          = .this_cCPros
1323:             loc_oPg.txt_4c_DPros.Value          = .this_cDPros
1324:             loc_oPg.txt_4c_Lin.Value            = .this_cLin
1325:             loc_oPg.txt_4c_DLin.Value           = .this_cDLin
1326:             loc_oPg.txt_4c_Fornecedor.Value     = .this_cFornecedor
1327:             loc_oPg.txt_4c_DFornecedor.Value    = .this_cDFornecedor
1328:             loc_oPg.txt_4c_MinVendas.Value      = .this_nMinVendas
1329:             loc_oPg.txt_4c_MinCustos.Value      = .this_nMinCustos
1330:         ENDWITH
1331: 
1332:         THIS.AtualizarEstadoCampos()
1333:     ENDPROC
1334: 


### BO (C:\4c\projeto\app\classes\SIGREAPRBO.prg):
*==============================================================================
* SIGREAPRBO.PRG
* Business Object para Relatorio de Alteracoes de Produtos
*
* Herda de RelatorioBase
* Formulario original: SIGREAPR.SCX (frmrelatorio)
*==============================================================================

DEFINE CLASS SIGREAPRBO AS RelatorioBase

    *-- Filtros do relatorio
    this_dDtInicial     = {}    && Data Inicial (obrigatorio)
    this_cGrupo         = ""    && Codigo do Grupo (SigCdGrp.CGrus, max 3)
    this_cDGrupo        = ""    && Descricao do Grupo (SigCdGrp.DGrus, max 20)
    this_cCPros         = ""    && Codigo do Produto (SigCdPro.CPros, max 14)
    this_cDPros         = ""    && Descricao do Produto (SigCdPro.DPros, max 40)
    this_cLin           = ""    && Codigo da Linha (SigCdLin.Linhas, max 10)
    this_cDLin          = ""    && Descricao da Linha (SigCdLin.Descs, max 40)
    this_cFornecedor    = ""    && Codigo do Fornecedor (max 10)
    this_cDFornecedor   = ""    && Descricao do Fornecedor (max 40)
    this_nMinVendas     = 0     && Diferenca minima vendas em %
    this_nMinCustos     = 0     && Diferenca minima custos em %

    *-- Controle interno do relatorio
    this_cArquivoFRX    = ""    && Caminho completo do FRX
    this_cTitulo        = ""    && Titulo exibido no relatorio
    this_cCursorDados   = "cursor_4c_SIGREAPRDados"  && Cursor resultado do SQLEXEC

    *--------------------------------------------------------------------------
    * Init - Configura caminhos e valores iniciais dos filtros
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cArquivoFRX = gc_4c_CaminhoReports + "RelSIGREAPR.frx"
            THIS.this_cTitulo     = "Relat" + CHR(243) + "rio de Altera" + CHR(231) + CHR(245) + "es de Produtos"
            THIS.this_dDtInicial  = DATE()
            THIS.this_nMinVendas  = 0
            THIS.this_nMinCustos  = 0
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Compara SigCdPro (atual) vs bkp_sigcdpro (historico)
    * Retorna produtos com variacao de preco acima dos minimos informados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lResultado, loc_cSQL, loc_cWhere, loc_cSub, loc_nResult
        loc_lResultado = .F.
        TRY
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            IF EMPTY(THIS.this_dDtInicial)
                THIS.this_cMensagemErro = "Data Inicial " + CHR(233) + " obrigat" + CHR(243) + "ria"
            ELSE
                loc_cWhere = "p.datas >= " + FormatarDataSQL(THIS.this_dDtInicial)

                IF !EMPTY(ALLTRIM(THIS.this_cGrupo))
                    loc_cWhere = loc_cWhere + ;
                                 " AND p.cgrus = " + EscaparSQL(ALLTRIM(THIS.this_cGrupo))
                ENDIF

                IF !EMPTY(ALLTRIM(THIS.this_cCPros))
                    loc_cWhere = loc_cWhere + ;
                                 " AND p.cpros = " + EscaparSQL(ALLTRIM(THIS.this_cCPros))
                ENDIF

                IF !EMPTY(ALLTRIM(THIS.this_cLin))
                    loc_cWhere = loc_cWhere + ;
                                 " AND p.linhas = " + EscaparSQL(ALLTRIM(THIS.this_cLin))
                ENDIF

                IF !EMPTY(ALLTRIM(THIS.this_cFornecedor))
                    loc_cWhere = loc_cWhere + ;
                                 " AND p.ifors = " + EscaparSQL(ALLTRIM(THIS.this_cFornecedor))
                ENDIF

                loc_cSub = "SELECT p.cpros, p.dpros, p.cgrus, p.linhas, p.ifors," + ;
                           " p.datas AS dtAlteracao," + ;
                           " b.pvens AS pvAnt, p.pvens AS pvAtual," + ;
                           " b.pcuss AS pcAnt, p.pcuss AS pcAtual," + ;
                           " CASE WHEN b.pvens <> 0 THEN ABS((p.pvens - b.pvens) / b.pvens)" + ;
                           " * 100 ELSE 0 END AS varVendas," + ;
                           " CASE WHEN b.pcuss <> 0 THEN ABS((p.pcuss - b.pcuss) / b.pcuss)" + ;
                           " * 100 ELSE 0 END AS varCustos" + ;
                           " FROM SigCdPro p" + ;
                           " INNER JOIN bkp_sigcdpro b ON p.cpros = b.cpros" + ;
                           " WHERE " + loc_cWhere

                loc_cSQL = "SELECT sub.cpros, sub.dpros, sub.cgrus, sub.linhas, sub.ifors," + ;
                           " sub.dtAlteracao, sub.pvAnt, sub.pvAtual," + ;
                           " sub.pcAnt, sub.pcAtual, sub.varVendas, sub.varCustos" + ;
                           " FROM (" + loc_cSub + ") sub" + ;
                           " WHERE (sub.varVendas >= " + ALLTRIM(TRANSFORM(THIS.this_nMinVendas)) + ;
                           " OR sub.varCustos >= " + ALLTRIM(TRANSFORM(THIS.this_nMinCustos)) + ")" + ;
                           " ORDER BY sub.dpros"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)

                IF loc_nResult >= 0
                    SELECT (THIS.this_cCursorDados)
                    IF EOF()
                        THIS.this_cMensagemErro = "Nenhum dado encontrado para os filtros informados"
                    ELSE
                        loc_lResultado = .T.
                    ENDIF
                ELSE
                    THIS.this_cMensagemErro = "Erro ao buscar dados do relat" + CHR(243) + "rio"
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cArquivoFRX) TO PRINT NOCONSOLE
                THIS.RegistrarAuditoria("IMPRIMIR")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao imprimir: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview do relatorio na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cArquivoFRX) PREVIEW NOCONSOLE
                THIS.RegistrarAuditoria("VISUALIZAR")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao visualizar: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave de auditoria da execucao do relatorio
    * Compoe identificador unico com empresa + filtros + data inicial + minimos
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave, loc_cEmpresa

        loc_cEmpresa = IIF(TYPE("go_4c_Sistema.cCodEmpresa") = "C", ;
                           ALLTRIM(go_4c_Sistema.cCodEmpresa), "TODAS")

        loc_cChave = loc_cEmpresa + "/SIGREAPR/" + DTOC(THIS.this_dDtInicial)

        IF !EMPTY(ALLTRIM(THIS.this_cGrupo))
            loc_cChave = loc_cChave + "/G:" + ALLTRIM(THIS.this_cGrupo)
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.this_cCPros))
            loc_cChave = loc_cChave + "/P:" + ALLTRIM(THIS.this_cCPros)
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.this_cLin))
            loc_cChave = loc_cChave + "/L:" + ALLTRIM(THIS.this_cLin)
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.this_cFornecedor))
            loc_cChave = loc_cChave + "/F:" + ALLTRIM(THIS.this_cFornecedor)
        ENDIF

        loc_cChave = loc_cChave + ;
                     "/MV:" + ALLTRIM(STR(THIS.this_nMinVendas, 6, 2)) + ;
                     "/MC:" + ALLTRIM(STR(THIS.this_nMinCustos, 6, 2))

        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio na tabela LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            loc_cChave   = THIS.ObterChavePrimaria()
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                               gc_4c_UsuarioLogado, "SISTEMA")

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SIGREAPR") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(loc_cUsuario) + ", GETDATE())"

            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Aviso: falha ao registrar auditoria - " + ;
                                       loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir / Atualizar / CarregarDoCursor
    *
    * Operacoes nao aplicaveis a BOs de relatorio. Sao implementadas aqui
    * apenas para manter o contrato uniforme com BusinessBase (auditoria,
    * dispatchers genericos, validadores automatizados) e para sinalizar
    * explicitamente a restricao via this_cMensagemErro.
    *
    * Para relatorios o fluxo correto eh:
    *   - PrepararDados() monta o cursor de saida via SQLEXEC comparando
    *     SigCdPro (atual) vs bkp_sigcdpro (historico) no periodo filtrado
    *   - Imprimir() / Visualizar() consomem esse cursor atraves do RelSIGREAPR.frx
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: BO de relat" + CHR(243) + "rio n" + CHR(227) + ;
            "o insere registros. Use PrepararDados()/Imprimir()/Visualizar()."
        RETURN .F.
    ENDPROC

    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: BO de relat" + CHR(243) + "rio n" + CHR(227) + ;
            "o atualiza registros. Use PrepararDados()/Imprimir()/Visualizar()."
        RETURN .F.
    ENDPROC

    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: BO de relat" + CHR(243) + "rio processa o per" + ;
            CHR(237) + "odo inteiro em PrepararDados(), n" + CHR(227) + ;
            "o registro a registro."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro da ultima operacao
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ExportarExcel - Prepara dados e exporta para planilha Excel (XL5)
    *   Usa PUTFILE para escolha interativa do arquivo destino
    *--------------------------------------------------------------------------
    PROCEDURE ExportarExcel()
        LOCAL loc_lResultado, loc_cArquivo, loc_lSafetyEra
        loc_lResultado = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cArquivo = PUTFILE("Exportar para Excel", ;
                               "RelAlteracoesProdutos.xls", "xls")
                IF !EMPTY(loc_cArquivo)
                    IF LOWER(RIGHT(loc_cArquivo, 4)) != ".xls"
                        loc_cArquivo = loc_cArquivo + ".xls"
                    ENDIF
                    SELECT (THIS.this_cCursorDados)
                    loc_lSafetyEra = (SET("SAFETY") = "ON")
                    SET SAFETY OFF
                    COPY TO (loc_cArquivo) TYPE XL5
                    IF loc_lSafetyEra
                        SET SAFETY ON
                    ENDIF
                    THIS.RegistrarAuditoria("EXCEL")
                    MsgInfo("Arquivo exportado com sucesso!", ;
                            "Informa" + CHR(231) + CHR(227) + "o")
                    loc_lResultado = .T.
                ENDIF
            ELSE
                IF !EMPTY(THIS.this_cMensagemErro)
			*-- REMOVIDO (self-assignment causa erro VFP9): THIS.this_cMensagemErro = THIS.this_cMensagemErro
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao exportar: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursor de dados ao destruir objeto
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

