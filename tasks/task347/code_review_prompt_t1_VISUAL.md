# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 186: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 210: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 234: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 258: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 282: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 319: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 405: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 429: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormARV.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1305 linhas total):

*-- Linhas 59 a 68:
59:             ELSE
60:                 THIS.ConfigurarPageFrame()
61: 
62:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
63:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
64: 
65:                 THIS.pgf_4c_Paginas.Visible    = .T.
66:                 THIS.pgf_4c_Paginas.ActivePage = 1
67:                 THIS.this_cModoAtual = "LISTA"
68: 

*-- Linhas 89 a 106:
89: 
90:         WITH loc_oPgf
91:             .PageCount = 2
92:             .Top       = -29
93:             .Left      = 0
94:             .Width     = THIS.Width
95:             .Height    = THIS.Height + 29
96:             .Tabs      = .F.
97:             .Visible   = .T.
98:             .Page1.Caption   = "Lista"
99:             .Page1.BackColor = RGB(100, 100, 100)
100:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
101:             .Page2.Caption   = "Dados"
102:             .Page2.BackColor = RGB(100, 100, 100)
103:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
104:         ENDWITH
105: 
106:         THIS.ConfigurarPaginaLista()

*-- Linhas 114 a 156:
114:         LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida, loc_oGrid
115:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
116: 
117:         *-- Cabecalho cinza (Top = 2+29 = 31, compensacao PageFrame.Top=-29)
118:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
119:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
120:         WITH loc_oCab
121:             .Top         = 31
122:             .Left        = 0
123:             .Width       = THIS.Width
124:             .Height      = 80
125:             .BackColor   = RGB(100, 100, 100)
126:             .BorderWidth = 0
127:             .Visible     = .T.
128:         ENDWITH
129: 
130:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
131:         WITH loc_oCab.lbl_4c_Sombra
132:             .AutoSize  = .F.
133:             .Caption   = THIS.Caption
134:             .Top       = 15
135:             .Left      = 10
136:             .Width     = THIS.Width
137:             .Height    = 40
138:             .FontName  = "Tahoma"
139:             .FontSize  = 16
140:             .FontBold  = .T.
141:             .ForeColor = RGB(0, 0, 0)
142:             .BackStyle = 0
143:             .Visible   = .T.
144:         ENDWITH
145: 
146:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
147:         WITH loc_oCab.lbl_4c_Titulo
148:             .AutoSize  = .F.
149:             .Caption   = THIS.Caption
150:             .Top       = 18
151:             .Left      = 10
152:             .Width     = THIS.Width
153:             .Height    = 46
154:             .FontName  = "Tahoma"
155:             .FontSize  = 16
156:             .FontBold  = .T.

*-- Linhas 163 a 192:
163:         loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
164:         loc_oBotoes = loc_oPg1.cnt_4c_Botoes
165:         WITH loc_oBotoes
166:             .Top         = 29
167:             .Left        = 542
168:             .Width       = 390
169:             .Height      = 85
170:             .BackColor   = RGB(53, 53, 53)
171:             .BackStyle   = 1
172:             .BorderWidth = 0
173:             .Visible     = .T.
174:         ENDWITH
175: 
176:         *-- Botao Incluir
177:         loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
178:         WITH loc_oBotoes.cmd_4c_Incluir
179:             .Caption         = "Incluir"
180:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
181:             .PicturePosition = 13
182:             .Top    = 5
183:             .Left   = 5
184:             .Width  = 75
185:             .Height = 75
186:             .FontName = "Comic Sans MS"
187:             .FontSize = 8
188:             .FontBold   = .T.
189:             .FontItalic = .T.
190:             .ForeColor = RGB(90,90,90)
191:             .BackColor = RGB(255,255,255)
192:             .Themes        = .F.

*-- Linhas 198 a 216:
198:         ENDWITH
199: 
200:         *-- Botao Visualizar
201:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
202:         WITH loc_oBotoes.cmd_4c_Visualizar
203:             .Caption         = "Visualizar"
204:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
205:             .PicturePosition = 13
206:             .Top    = 5
207:             .Left   = 80
208:             .Width  = 75
209:             .Height = 75
210:             .FontName = "Comic Sans MS"
211:             .FontSize = 8
212:             .FontBold   = .T.
213:             .FontItalic = .T.
214:             .ForeColor = RGB(90,90,90)
215:             .BackColor = RGB(255,255,255)
216:             .Themes        = .F.

*-- Linhas 222 a 240:
222:         ENDWITH
223: 
224:         *-- Botao Alterar
225:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
226:         WITH loc_oBotoes.cmd_4c_Alterar
227:             .Caption         = "Alterar"
228:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
229:             .PicturePosition = 13
230:             .Top    = 5
231:             .Left   = 155
232:             .Width  = 75
233:             .Height = 75
234:             .FontName = "Comic Sans MS"
235:             .FontSize = 8
236:             .FontBold   = .T.
237:             .FontItalic = .T.
238:             .ForeColor = RGB(90,90,90)
239:             .BackColor = RGB(255,255,255)
240:             .Themes        = .F.

*-- Linhas 246 a 264:
246:         ENDWITH
247: 
248:         *-- Botao Excluir
249:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
250:         WITH loc_oBotoes.cmd_4c_Excluir
251:             .Caption         = "Excluir"
252:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
253:             .PicturePosition = 13
254:             .Top    = 5
255:             .Left   = 230
256:             .Width  = 75
257:             .Height = 75
258:             .FontName = "Comic Sans MS"
259:             .FontSize = 8
260:             .FontBold   = .T.
261:             .FontItalic = .T.
262:             .ForeColor = RGB(90,90,90)
263:             .BackColor = RGB(255,255,255)
264:             .Themes        = .F.

*-- Linhas 270 a 288:
270:         ENDWITH
271: 
272:         *-- Botao Buscar
273:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
274:         WITH loc_oBotoes.cmd_4c_Buscar
275:             .Caption         = "Buscar"
276:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
277:             .PicturePosition = 13
278:             .Top    = 5
279:             .Left   = 305
280:             .Width  = 75
281:             .Height = 75
282:             .FontName = "Comic Sans MS"
283:             .FontSize = 8
284:             .FontBold   = .T.
285:             .FontItalic = .T.
286:             .ForeColor = RGB(90,90,90)
287:             .BackColor = RGB(255,255,255)
288:             .Themes        = .F.

*-- Linhas 297 a 325:
297:         loc_oPg1.AddObject("cnt_4c_Saida", "Container")
298:         loc_oSaida = loc_oPg1.cnt_4c_Saida
299:         WITH loc_oSaida
300:             .Top         = 29
301:             .Left        = 917
302:             .Width       = 90
303:             .Height      = 85
304:             .BackStyle   = 0
305:             .BorderWidth = 0
306:             .Visible     = .T.
307:         ENDWITH
308: 
309:         *-- Botao Encerrar (canonico)
310:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
311:         WITH loc_oSaida.cmd_4c_Encerrar
312:             .Caption         = "Encerrar"
313:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
314:             .PicturePosition = 13
315:             .Top    = 5
316:             .Left   = 5
317:             .Width  = 75
318:             .Height = 75
319:             .FontName = "Comic Sans MS"
320:             .FontSize = 8
321:             .FontBold   = .T.
322:             .FontItalic = .T.
323:             .ForeColor = RGB(90,90,90)
324:             .BackColor = RGB(255,255,255)
325:             .Themes        = .F.

*-- Linhas 334 a 343:
334:         loc_oPg1.AddObject("grd_4c_Lista", "Grid")
335:         loc_oGrid = loc_oPg1.grd_4c_Lista
336:         WITH loc_oGrid
337:             .Top                = 117
338:             .Left               = 26
339:             .Width              = 890
340:             .Height             = 498
341:             .FontName           = "Verdana"
342:             .FontSize           = 8
343:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 355 a 411:
355:         ENDWITH
356:         loc_oGrid.ColumnCount              = 2
357:         loc_oGrid.Column1.Width            = 80
358:         loc_oGrid.Column1.Header1.Caption  = "C" + CHR(243) + "digos"
359:         loc_oGrid.Column2.Width            = 290
360:         loc_oGrid.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
361: 
362:         *-- BINDEVENT botoes Page1
363:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
364:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
365:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
366:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
367:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
368:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
369:         BINDEVENT(loc_oGrid,                      "DblClick", THIS, "BtnVisualizarClick")
370: 
371:         THIS.TornarControlesVisiveis(loc_oPg1)
372:     ENDPROC
373: 
374:     *--------------------------------------------------------------------------
375:     * ConfigurarPaginaDados - Page2 (Dados): Salva + campos Parte 1/2 (Fase 5)
376:     * Coordenadas: Top_original + 29 (compensacao PageFrame.Top=-29)
377:     *--------------------------------------------------------------------------
378:     PROTECTED PROCEDURE ConfigurarPaginaDados()
379:         LOCAL loc_oPg2, loc_oSalva
380:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
381: 
382:         *-- Container botoes Confirmar/Cancelar (canonico: Top=33, Left=842)
383:         loc_oPg2.AddObject("cnt_4c_Salva", "Container")
384:         loc_oSalva = loc_oPg2.cnt_4c_Salva
385:         WITH loc_oSalva
386:             .Top         = 33
387:             .Left        = 842
388:             .Width       = 160
389:             .Height      = 85
390:             .BackStyle   = 0
391:             .BorderWidth = 0
392:             .Visible     = .T.
393:         ENDWITH
394: 
395:         *-- Botao Confirmar
396:         loc_oSalva.AddObject("cmd_4c_Confirmar", "CommandButton")
397:         WITH loc_oSalva.cmd_4c_Confirmar
398:             .Caption         = "Confirmar"
399:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
400:             .PicturePosition = 13
401:             .Top    = 5
402:             .Left   = 5
403:             .Width  = 75
404:             .Height = 75
405:             .FontName = "Comic Sans MS"
406:             .FontSize = 8
407:             .FontBold   = .T.
408:             .FontItalic = .T.
409:             .ForeColor = RGB(90,90,90)
410:             .BackColor = RGB(255,255,255)
411:             .Themes        = .F.

*-- Linhas 417 a 461:
417:         ENDWITH
418: 
419:         *-- Botao Cancelar
420:         loc_oSalva.AddObject("cmd_4c_Cancelar", "CommandButton")
421:         WITH loc_oSalva.cmd_4c_Cancelar
422:             .Caption         = "Encerrar"
423:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
424:             .PicturePosition = 13
425:             .Top    = 5
426:             .Left   = 80
427:             .Width  = 75
428:             .Height = 75
429:             .FontName = "Comic Sans MS"
430:             .FontSize = 8
431:             .FontBold   = .T.
432:             .FontItalic = .T.
433:             .ForeColor = RGB(90,90,90)
434:             .BackColor = RGB(255,255,255)
435:             .Themes        = .F.
436:             .SpecialEffect = 0
437:             .MousePointer = 15
438:             .WordWrap     = .T.
439:             .AutoSize     = .F.
440:             .Visible = .T.
441:         ENDWITH
442: 
443:         BINDEVENT(loc_oSalva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
444:         BINDEVENT(loc_oSalva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
445: 
446:         *----------------------------------------------------------------------
447:         *-- CAMPOS PARTE 1/2 ? Say1/get_Cod, Say2/get_descs, Say3/get_formula,
448:         *--                     Label7/get_perc/Label8, Label1 (Fundicao)
449:         *----------------------------------------------------------------------
450: 
451:         *-- Label "Codigo :" (Say1, top 171+29=200)
452:         loc_oPg2.AddObject("lbl_4c_Codigo", "Label")
453:         WITH loc_oPg2.lbl_4c_Codigo
454:             .Caption   = "C" + CHR(243) + "digo :"
455:             .Top       = 200
456:             .Left      = 61
457:             .Width     = 50
458:             .Height    = 17
459:             .FontName  = "Tahoma"
460:             .FontSize  = 8
461:             .ForeColor = RGB(255, 255, 255)

*-- Linhas 468 a 490:
468:         loc_oPg2.AddObject("txt_4c_Codigos", "TextBox")
469:         WITH loc_oPg2.txt_4c_Codigos
470:             .Value    = ""
471:             .Top      = 197
472:             .Left     = 116
473:             .Width    = 80
474:             .Height   = 21
475:             .FontName = "Tahoma"
476:             .FontSize = 8
477:             .Visible  = .T.
478:         ENDWITH
479: 
480:         *-- Label "Descricao :" (Say2, top 198+29=227)
481:         loc_oPg2.AddObject("lbl_4c_Descs", "Label")
482:         WITH loc_oPg2.lbl_4c_Descs
483:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
484:             .Top       = 227
485:             .Left      = 45
486:             .Width     = 68
487:             .Height    = 17
488:             .FontName  = "Tahoma"
489:             .FontSize  = 8
490:             .ForeColor = RGB(255, 255, 255)

*-- Linhas 497 a 519:
497:         loc_oPg2.AddObject("txt_4c_Descs", "TextBox")
498:         WITH loc_oPg2.txt_4c_Descs
499:             .Value    = ""
500:             .Top      = 221
501:             .Left     = 116
502:             .Width    = 290
503:             .Height   = 21
504:             .FontName = "Tahoma"
505:             .FontSize = 8
506:             .Visible  = .T.
507:         ENDWITH
508: 
509:         *-- Label "Formula :" (Say3, top 227+29=256)
510:         loc_oPg2.AddObject("lbl_4c_Formula", "Label")
511:         WITH loc_oPg2.lbl_4c_Formula
512:             .Caption   = "F" + CHR(243) + "rmula :"
513:             .Top       = 256
514:             .Left      = 55
515:             .Width     = 58
516:             .Height    = 17
517:             .FontName  = "Tahoma"
518:             .FontSize  = 8
519:             .ForeColor = RGB(255, 255, 255)

*-- Linhas 526 a 551:
526:         loc_oPg2.AddObject("obj_4c_Formulas", "EditBox")
527:         WITH loc_oPg2.obj_4c_Formulas
528:             .Value      = ""
529:             .Top        = 257
530:             .Left       = 115
531:             .Width      = 290
532:             .Height     = 100
533:             .FontName   = "Tahoma"
534:             .FontSize   = 8
535:             .BackColor  = RGB(255, 255, 255)
536:             .ForeColor  = RGB(0, 0, 0)
537:             .ScrollBars = 2
538:             .Visible    = .T.
539:         ENDWITH
540: 
541:         *-- Label "Metal Novo :" (Label7, top 170+29=199)
542:         loc_oPg2.AddObject("lbl_4c_MetalNovo", "Label")
543:         WITH loc_oPg2.lbl_4c_MetalNovo
544:             .Caption   = "Metal Novo :"
545:             .Top       = 199
546:             .Left      = 435
547:             .Width     = 74
548:             .Height    = 15
549:             .FontName  = "Tahoma"
550:             .FontSize  = 8
551:             .ForeColor = RGB(255, 255, 255)

*-- Linhas 558 a 614:
558:         loc_oPg2.AddObject("txt_4c_Percs", "TextBox")
559:         WITH loc_oPg2.txt_4c_Percs
560:             .Value     = 0
561:             .Top       = 195
562:             .Left      = 514
563:             .Width     = 52
564:             .Height    = 21
565:             .FontName  = "Tahoma"
566:             .FontSize  = 8
567:             .InputMask = "999.99"
568:             .Visible   = .T.
569:         ENDWITH
570: 
571:         *-- Label "%" (Label8, top 170+29=199)
572:         loc_oPg2.AddObject("lbl_4c_Pct", "Label")
573:         WITH loc_oPg2.lbl_4c_Pct
574:             .Caption   = "%"
575:             .Top       = 199
576:             .Left      = 570
577:             .Width     = 14
578:             .Height    = 15
579:             .FontName  = "Tahoma"
580:             .FontSize  = 8
581:             .ForeColor = RGB(255, 255, 255)
582:             .BackStyle = 0
583:             .AutoSize  = .F.
584:             .Visible   = .T.
585:         ENDWITH
586: 
587:         *-- Label titulo secao "Fundicao" (Label1, top 208+29=237)
588:         loc_oPg2.AddObject("lbl_4c_Fundicao", "Label")
589:         WITH loc_oPg2.lbl_4c_Fundicao
590:             .Caption   = "Fundi" + CHR(231) + CHR(227) + "o"
591:             .Top       = 237
592:             .Left      = 435
593:             .Width     = 61
594:             .Height    = 15
595:             .FontName  = "Tahoma"
596:             .FontSize  = 8
597:             .FontBold  = .T.
598:             .ForeColor = RGB(255, 255, 255)
599:             .BackStyle = 0
600:             .AutoSize  = .F.
601:             .Visible   = .T.
602:         ENDWITH
603: 
604:         *-- Label "Temperatura Metal" (Label2, top 226+29=255)
605:         loc_oPg2.AddObject("lbl_4c_TempMet", "Label")
606:         WITH loc_oPg2.lbl_4c_TempMet
607:             .Caption   = "Temperatura Metal"
608:             .Top       = 255
609:             .Left      = 465
610:             .Width     = 110
611:             .Height    = 15
612:             .FontName  = "Verdana"
613:             .FontSize  = 8
614:             .FontBold  = .F.

*-- Linhas 622 a 645:
622:         loc_oPg2.AddObject("txt_4c_TempMets", "TextBox")
623:         WITH loc_oPg2.txt_4c_TempMets
624:             .Value     = ""
625:             .Top       = 271
626:             .Left      = 465
627:             .Width     = 115
628:             .Height    = 23
629:             .MaxLength = 15
630:             .FontName  = "Tahoma"
631:             .FontSize  = 8
632:             .Visible   = .T.
633:         ENDWITH
634: 
635:         *-- Label "Temperatura Tubo" (Label3, top 226+29=255)
636:         loc_oPg2.AddObject("lbl_4c_TempTub", "Label")
637:         WITH loc_oPg2.lbl_4c_TempTub
638:             .Caption   = "Temperatura Tubo"
639:             .Top       = 255
640:             .Left      = 615
641:             .Width     = 108
642:             .Height    = 15
643:             .FontName  = "Verdana"
644:             .FontSize  = 8
645:             .FontBold  = .F.

*-- Linhas 653 a 693:
653:         loc_oPg2.AddObject("txt_4c_TempTubs", "TextBox")
654:         WITH loc_oPg2.txt_4c_TempTubs
655:             .Value     = ""
656:             .Top       = 271
657:             .Left      = 615
658:             .Width     = 115
659:             .Height    = 23
660:             .MaxLength = 15
661:             .FontName  = "Tahoma"
662:             .FontSize  = 8
663:             .Visible   = .T.
664:         ENDWITH
665: 
666:         *-- Label "Revestimento" (Label4, top 272+29=301)
667:         loc_oPg2.AddObject("lbl_4c_Revestimento", "Label")
668:         WITH loc_oPg2.lbl_4c_Revestimento
669:             .Caption   = "Revestimento"
670:             .Top       = 301
671:             .Left      = 435
672:             .Width     = 91
673:             .Height    = 15
674:             .FontName  = "Verdana"
675:             .FontSize  = 8
676:             .FontBold  = .T.
677:             .ForeColor = RGB(36, 84, 155)
678:             .BackStyle = 0
679:             .AutoSize  = .F.
680:             .Visible   = .T.
681:         ENDWITH
682: 
683:         *-- Label "Temperatura Ambiente" (Label5, top 288+29=317)
684:         loc_oPg2.AddObject("lbl_4c_TempAmb", "Label")
685:         WITH loc_oPg2.lbl_4c_TempAmb
686:             .Caption   = "Temperatura Ambiente"
687:             .Top       = 317
688:             .Left      = 465
689:             .Width     = 134
690:             .Height    = 15
691:             .FontName  = "Verdana"
692:             .FontSize  = 8
693:             .FontBold  = .F.

*-- Linhas 701 a 724:
701:         loc_oPg2.AddObject("txt_4c_TempAmbs", "TextBox")
702:         WITH loc_oPg2.txt_4c_TempAmbs
703:             .Value     = ""
704:             .Top       = 333
705:             .Left      = 465
706:             .Width     = 115
707:             .Height    = 23
708:             .MaxLength = 15
709:             .FontName  = "Tahoma"
710:             .FontSize  = 8
711:             .Visible   = .T.
712:         ENDWITH
713: 
714:         *-- Label "Temperatura Agua" (Label6, top 288+29=317)
715:         loc_oPg2.AddObject("lbl_4c_TempAgu", "Label")
716:         WITH loc_oPg2.lbl_4c_TempAgu
717:             .Caption   = "Temperatura " + CHR(193) + "gua"
718:             .Top       = 317
719:             .Left      = 615
720:             .Width     = 109
721:             .Height    = 15
722:             .FontName  = "Verdana"
723:             .FontSize  = 8
724:             .FontBold  = .F.

*-- Linhas 732 a 755:
732:         loc_oPg2.AddObject("txt_4c_Tempagus", "TextBox")
733:         WITH loc_oPg2.txt_4c_Tempagus
734:             .Value     = ""
735:             .Top       = 333
736:             .Left      = 615
737:             .Width     = 115
738:             .Height    = 23
739:             .MaxLength = 15
740:             .FontName  = "Tahoma"
741:             .FontSize  = 8
742:             .Visible   = .T.
743:         ENDWITH
744: 
745:         *-- Say4: instrucoes para formula (Say4, top 349+29=378)
746:         loc_oPg2.AddObject("lbl_4c_Say4", "Label")
747:         WITH loc_oPg2.lbl_4c_Say4
748:             .Caption   = "Para montar a f" + CHR(243) + "rmula tem que usar os seguintes campos :"
749:             .Top       = 378
750:             .Left      = 61
751:             .Width     = 380
752:             .Height    = 18
753:             .FontName  = "Tahoma"
754:             .FontSize  = 10
755:             .FontBold  = .F.

*-- Linhas 761 a 773:
761:         ENDWITH
762: 
763:         *-- Say5: BCERAS = Base + Cera (top 369+29=398)
764:         loc_oPg2.AddObject("lbl_4c_Say5", "Label")
765:         WITH loc_oPg2.lbl_4c_Say5
766:             .Caption   = "BCERAS = Base + Cera"
767:             .Top       = 398
768:             .Left      = 61
769:             .Width     = 150
770:             .Height    = 18
771:             .FontName  = "Tahoma"
772:             .FontSize  = 10
773:             .FontBold  = .F.

*-- Linhas 779 a 791:
779:         ENDWITH
780: 
781:         *-- Say6: BASES = Base (top 389+29=418)
782:         loc_oPg2.AddObject("lbl_4c_Say6", "Label")
783:         WITH loc_oPg2.lbl_4c_Say6
784:             .Caption   = "BASES = Base"
785:             .Top       = 418
786:             .Left      = 61
787:             .Width     = 93
788:             .Height    = 18
789:             .FontName  = "Tahoma"
790:             .FontSize  = 10
791:             .FontBold  = .F.

*-- Linhas 797 a 809:
797:         ENDWITH
798: 
799:         *-- Say7: exemplo de formula (top 409+29=438)
800:         loc_oPg2.AddObject("lbl_4c_Say7", "Label")
801:         WITH loc_oPg2.lbl_4c_Say7
802:             .Caption   = "Ex: (((BCERAS - BASES) * 15,3) - 40)/5"
803:             .Top       = 438
804:             .Left      = 61
805:             .Width     = 268
806:             .Height    = 18
807:             .FontName  = "Tahoma"
808:             .FontSize  = 10
809:             .FontBold  = .F.

*-- Linhas 867 a 876:
867:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
868:                 loc_oGrid.Column1.Width         = 80
869:                 loc_oGrid.Column2.Width         = 290
870:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digos"
871:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
872:                 THIS.FormatarGridLista(loc_oGrid)
873:                 loc_lResultado = .T.
874:             ENDIF
875:         CATCH TO loc_oErro
876:             MsgErro(loc_oErro.Message, "FormARV.CarregarLista")

*-- Linhas 950 a 959:
950:         ENDIF
951: 
952:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Salva", 5)
953:             IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Confirmar", 5)
954:                 loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = par_lHabilitar AND loc_lEdicao
955:             ENDIF
956:         ENDIF
957:     ENDPROC
958: 
959:     *--------------------------------------------------------------------------

*-- Linhas 1220 a 1228:
1220:     ENDPROC
1221: 
1222:     *--------------------------------------------------------------------------
1223:     * BtnSalvarClick - Salva registro (chamado pelo cmd_4c_Confirmar da Page2)
1224:     *--------------------------------------------------------------------------
1225:     PROCEDURE BtnSalvarClick()
1226:         LOCAL loc_cCodigo, loc_nChk, loc_lSucesso
1227:         loc_cCodigo  = ""
1228:         loc_nChk     = 0

*-- Linhas 1283 a 1295:
1283:         loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1284: 
1285:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Salva", 5)
1286:             IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Confirmar", 5)
1287:                 loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lEdicao
1288:             ENDIF
1289:             IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Cancelar", 5)
1290:                 loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled = .T.
1291:             ENDIF
1292:         ENDIF
1293:     ENDPROC
1294: 
1295:     *--------------------------------------------------------------------------


### BO (C:\4c\projeto\app\classes\ARVBO.prg):
*====================================================================
* ARVBO.prg
*
* Business Object para Tipos de Arvore
* Tabela: SigCdArv
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS ARVBO AS BusinessBase

	*-- Propriedades da entidade (SigCdArv)
	this_cCodigos  = ""   && codigos  char - PK
	this_cDescs    = ""   && descs    char - Descricao
	this_cFormulas = ""   && formulas memo/char - Formula de calculo
	this_cTempMets = ""   && TempMets char(15) - Formula temperatura metal (Fundicao)
	this_cTempTubs = ""   && TempTubs char(15) - Formula temperatura tubo (Fundicao)
	this_cTempAmbs = ""   && TempAmbs char(15) - Formula temperatura ambiente (Revestimento)
	this_cTempagus = ""   && Tempagus char(15) - Formula temperatura agua (Revestimento)
	this_nPercs    = 0    && Percs    numeric(5,2) - Percentual metal novo

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigCdArv"
		THIS.this_cCampoChave = "codigos"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCodigos)
	ENDPROC

	*====================================================================
	* Buscar - Carrega lista de tipos de arvore no cursor_4c_Dados
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(par_cFiltro)
				loc_cSQL = "SELECT codigos, descs, formulas, TempMets, TempTubs," + ;
				           " TempAmbs, Tempagus, Percs" + ;
				           " FROM SigCdArv" + ;
				           " ORDER BY codigos"
			ELSE
				loc_cSQL = "SELECT codigos, descs, formulas, TempMets, TempTubs," + ;
				           " TempAmbs, Tempagus, Percs" + ;
				           " FROM SigCdArv" + ;
				           " WHERE codigos LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
				           " ORDER BY codigos"
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar tipos de " + CHR(225) + "rvore:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar tipos de " + CHR(225) + "rvore:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um registro pelo codigo (PK)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT codigos, descs, formulas, TempMets, TempTubs," + ;
			           " TempAmbs, Tempagus, Percs" + ;
			           " FROM SigCdArv" + ;
			           " WHERE codigos = " + EscaparSQL(par_cCodigo)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ELSE
				MsgErro("Tipo de " + CHR(225) + "rvore n" + CHR(227) + "o encontrado!", "Aviso")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar tipo de " + CHR(225) + "rvore:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		IF USED("cursor_4c_Carrega")
			USE IN cursor_4c_Carrega
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Popula propriedades a partir de cursor
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_cCodigos  = TratarNulo(codigos,  "C")
			THIS.this_cDescs    = TratarNulo(descs,    "C")
			THIS.this_cFormulas = TratarNulo(formulas, "C")
			THIS.this_cTempMets = TratarNulo(TempMets, "C")
			THIS.this_cTempTubs = TratarNulo(TempTubs, "C")
			THIS.this_cTempAmbs = TratarNulo(TempAmbs, "C")
			THIS.this_cTempagus = TratarNulo(Tempagus, "C")
			THIS.this_nPercs    = TratarNulo(Percs,    "N")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - Insere novo registro (PROTECTED - chamado por Salvar())
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "INSERT INTO SigCdArv" + ;
			           " (codigos, descs, formulas, TempMets, TempTubs, TempAmbs, Tempagus, Percs)" + ;
			           " VALUES (" + ;
			           EscaparSQL(THIS.this_cCodigos)  + "," + ;
			           EscaparSQL(THIS.this_cDescs)    + "," + ;
			           EscaparSQL(THIS.this_cFormulas) + "," + ;
			           EscaparSQL(THIS.this_cTempMets) + "," + ;
			           EscaparSQL(THIS.this_cTempTubs) + "," + ;
			           EscaparSQL(THIS.this_cTempAmbs) + "," + ;
			           EscaparSQL(THIS.this_cTempagus) + "," + ;
			           FormatarNumeroSQL(THIS.this_nPercs) + ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao inserir tipo de " + CHR(225) + "rvore:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir tipo de " + CHR(225) + "rvore:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza registro existente (PROTECTED - chamado por Salvar())
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SigCdArv SET" + ;
			           " descs    = " + EscaparSQL(THIS.this_cDescs)    + "," + ;
			           " formulas = " + EscaparSQL(THIS.this_cFormulas) + "," + ;
			           " TempMets = " + EscaparSQL(THIS.this_cTempMets) + "," + ;
			           " TempTubs = " + EscaparSQL(THIS.this_cTempTubs) + "," + ;
			           " TempAmbs = " + EscaparSQL(THIS.this_cTempAmbs) + "," + ;
			           " Tempagus = " + EscaparSQL(THIS.this_cTempagus) + "," + ;
			           " Percs    = " + FormatarNumeroSQL(THIS.this_nPercs) + ;
			           " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar tipo de " + CHR(225) + "rvore:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar tipo de " + CHR(225) + "rvore:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Exclui registro (PROTECTED - chamado por Excluir())
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCdArv" + ;
			           " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir tipo de " + CHR(225) + "rvore:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir tipo de " + CHR(225) + "rvore:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

