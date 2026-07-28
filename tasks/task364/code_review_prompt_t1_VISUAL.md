# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 191: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 213: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 235: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 257: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 279: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 320: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 420: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 442: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCfb.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2784 linhas total):

*-- Linhas 59 a 68:
59:             ELSE
60:                 THIS.ConfigurarPageFrame()
61: 
62:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
63:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
64: 
65:                 THIS.pgf_4c_Paginas.Visible    = .T.
66:                 THIS.pgf_4c_Paginas.ActivePage = 1
67:                 THIS.this_cModoAtual           = "LISTA"
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

*-- Linhas 119 a 158:
119:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
120:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
121:         WITH loc_oCab
122:             .Top           = 30
123:             .Left          = 0
124:             .Width         = THIS.Width
125:             .Height        = 80
126:             .BackColor     = RGB(100, 100, 100)
127:             .BorderWidth   = 0
128:             .SpecialEffect = 0
129:             .Visible       = .T.
130:         ENDWITH
131: 
132:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
133:         WITH loc_oCab.lbl_4c_Sombra
134:             .AutoSize  = .F.
135:             .Caption   = THIS.Caption
136:             .Top       = 15
137:             .Left      = 10
138:             .Width     = THIS.Width
139:             .Height    = 40
140:             .FontName  = "Tahoma"
141:             .FontSize  = 16
142:             .FontBold  = .T.
143:             .ForeColor = RGB(0, 0, 0)
144:             .BackStyle = 0
145:             .Visible   = .T.
146:         ENDWITH
147: 
148:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
149:         WITH loc_oCab.lbl_4c_Titulo
150:             .AutoSize  = .F.
151:             .Caption   = THIS.Caption
152:             .Top       = 18
153:             .Left      = 10
154:             .Width     = THIS.Width
155:             .Height    = 46
156:             .FontName  = "Tahoma"
157:             .FontSize  = 16
158:             .FontBold  = .T.

*-- Linhas 166 a 342:
166:         loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
167:         loc_oBotoes = loc_oPg1.cnt_4c_Botoes
168:         WITH loc_oBotoes
169:             .Top           = 29
170:             .Left          = 542
171:             .Width         = 390
172:             .Height        = 85
173:             .BackStyle     = 1
174:             .BackColor     = RGB(53, 53, 53)
175:             .BorderWidth   = 0
176:             .SpecialEffect = 0
177:             .Visible       = .T.
178:         ENDWITH
179: 
180:         loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
181:         WITH loc_oBotoes.cmd_4c_Incluir
182:             .Caption         = "Incluir"
183:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
184:             .PicturePosition = 13
185:             .Top             = 5
186:             .Left            = 5
187:             .Width           = 75
188:             .Height          = 75
189:             .BackColor       = RGB(255, 255, 255)
190:             .ForeColor       = RGB(90, 90, 90)
191:             .FontName        = "Comic Sans MS"
192:             .FontBold        = .T.
193:             .FontItalic      = .T.
194:             .FontSize        = 8
195:             .Themes          = .F.
196:             .SpecialEffect   = 0
197:             .MousePointer    = 15
198:             .WordWrap        = .T.
199:             .Visible         = .T.
200:         ENDWITH
201: 
202:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
203:         WITH loc_oBotoes.cmd_4c_Alterar
204:             .Caption         = "Alterar"
205:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
206:             .PicturePosition = 13
207:             .Top             = 5
208:             .Left            = 80
209:             .Width           = 75
210:             .Height          = 75
211:             .BackColor       = RGB(255, 255, 255)
212:             .ForeColor       = RGB(90, 90, 90)
213:             .FontName        = "Comic Sans MS"
214:             .FontBold        = .T.
215:             .FontItalic      = .T.
216:             .FontSize        = 8
217:             .Themes          = .F.
218:             .SpecialEffect   = 0
219:             .MousePointer    = 15
220:             .WordWrap        = .T.
221:             .Visible         = .T.
222:         ENDWITH
223: 
224:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
225:         WITH loc_oBotoes.cmd_4c_Visualizar
226:             .Caption         = "Visualizar"
227:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
228:             .PicturePosition = 13
229:             .Top             = 5
230:             .Left            = 155
231:             .Width           = 75
232:             .Height          = 75
233:             .BackColor       = RGB(255, 255, 255)
234:             .ForeColor       = RGB(90, 90, 90)
235:             .FontName        = "Comic Sans MS"
236:             .FontBold        = .T.
237:             .FontItalic      = .T.
238:             .FontSize        = 8
239:             .Themes          = .F.
240:             .SpecialEffect   = 0
241:             .MousePointer    = 15
242:             .WordWrap        = .T.
243:             .Visible         = .T.
244:         ENDWITH
245: 
246:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
247:         WITH loc_oBotoes.cmd_4c_Excluir
248:             .Caption         = "Excluir"
249:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
250:             .PicturePosition = 13
251:             .Top             = 5
252:             .Left            = 230
253:             .Width           = 75
254:             .Height          = 75
255:             .BackColor       = RGB(255, 255, 255)
256:             .ForeColor       = RGB(90, 90, 90)
257:             .FontName        = "Comic Sans MS"
258:             .FontBold        = .T.
259:             .FontItalic      = .T.
260:             .FontSize        = 8
261:             .Themes          = .F.
262:             .SpecialEffect   = 0
263:             .MousePointer    = 15
264:             .WordWrap        = .T.
265:             .Visible         = .T.
266:         ENDWITH
267: 
268:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
269:         WITH loc_oBotoes.cmd_4c_Buscar
270:             .Caption         = "Buscar"
271:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
272:             .PicturePosition = 13
273:             .Top             = 5
274:             .Left            = 305
275:             .Width           = 75
276:             .Height          = 75
277:             .BackColor       = RGB(255, 255, 255)
278:             .ForeColor       = RGB(90, 90, 90)
279:             .FontName        = "Comic Sans MS"
280:             .FontBold        = .T.
281:             .FontItalic      = .T.
282:             .FontSize        = 8
283:             .Themes          = .F.
284:             .SpecialEffect   = 0
285:             .MousePointer    = 15
286:             .WordWrap        = .T.
287:             .Visible         = .T.
288:         ENDWITH
289: 
290:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
291:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
292:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
293:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
294:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
295: 
296:         *-- Container Encerrar (canonico: Left=917, Top=29)
297:         loc_oPg1.AddObject("cnt_4c_Saida", "Container")
298:         loc_oSaida = loc_oPg1.cnt_4c_Saida
299:         WITH loc_oSaida
300:             .Top           = 29
301:             .Left          = 917
302:             .Width         = 90
303:             .Height        = 85
304:             .BackStyle     = 0
305:             .BorderWidth   = 0
306:             .Visible       = .T.
307:         ENDWITH
308: 
309:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
310:         WITH loc_oSaida.cmd_4c_Encerrar
311:             .Caption         = "Encerrar"
312:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
313:             .PicturePosition = 13
314:             .Top             = 5
315:             .Left            = 5
316:             .Width           = 75
317:             .Height          = 75
318:             .BackColor       = RGB(255, 255, 255)
319:             .ForeColor       = RGB(90, 90, 90)
320:             .FontName        = "Comic Sans MS"
321:             .FontBold        = .T.
322:             .FontItalic      = .T.
323:             .FontSize        = 8
324:             .Themes          = .F.
325:             .SpecialEffect   = 0
326:             .MousePointer    = 15
327:             .WordWrap        = .T.
328:             .Visible         = .T.
329:         ENDWITH
330: 
331:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
332: 
333:         *-- Grid de lista (Top=117 = 88+29 compensacao)
334:         loc_oPg1.AddObject("grd_4c_Lista", "Grid")
335:         loc_oGrid = loc_oPg1.grd_4c_Lista
336:         loc_oGrid.Top         = 117
337:         loc_oGrid.Left        = 12
338:         loc_oGrid.Width       = 950
339:         loc_oGrid.Height      = 476
340:         loc_oGrid.ColumnCount = 3
341:         WITH loc_oGrid
342:             .FontName           = "Verdana"

*-- Linhas 359 a 385:
359:             .Width           = 100
360:             .Resizable       = .T.
361:             .Alignment       = 0
362:             .Header1.Caption = "Forma Pgto"
363:             .Header1.FontName = "Tahoma"
364:             .Header1.FontSize = 8
365:         ENDWITH
366: 
367:         WITH loc_oGrid.Column2
368:             .Width           = 680
369:             .Resizable       = .T.
370:             .Alignment       = 0
371:             .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
372:             .Header1.FontName = "Tahoma"
373:             .Header1.FontSize = 8
374:         ENDWITH
375: 
376:         WITH loc_oGrid.Column3
377:             .Width           = 100
378:             .Resizable       = .T.
379:             .Alignment       = 0
380:             .Header1.Caption = "Configurado"
381:             .Header1.FontName = "Tahoma"
382:             .Header1.FontSize = 8
383:         ENDWITH
384: 
385:         THIS.TornarControlesVisiveis(loc_oPg1)

*-- Linhas 397 a 482:
397:         loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
398:         loc_oSalva = loc_oPg2.cnt_4c_BotoesAcao
399:         WITH loc_oSalva
400:             .Top         = 33
401:             .Left        = 842
402:             .Width       = 160
403:             .Height      = 85
404:             .BackStyle   = 0
405:             .BorderWidth = 0
406:             .Visible     = .T.
407:         ENDWITH
408: 
409:         loc_oSalva.AddObject("cmd_4c_Confirmar", "CommandButton")
410:         WITH loc_oSalva.cmd_4c_Confirmar
411:             .Caption         = "Confirmar"
412:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
413:             .PicturePosition = 13
414:             .Top             = 5
415:             .Left            = 5
416:             .Width           = 75
417:             .Height          = 75
418:             .BackColor       = RGB(255, 255, 255)
419:             .ForeColor       = RGB(90, 90, 90)
420:             .FontName        = "Comic Sans MS"
421:             .FontBold        = .T.
422:             .FontItalic      = .T.
423:             .FontSize        = 8
424:             .Themes          = .F.
425:             .SpecialEffect   = 0
426:             .MousePointer    = 15
427:             .WordWrap        = .T.
428:             .Visible         = .T.
429:         ENDWITH
430: 
431:         loc_oSalva.AddObject("cmd_4c_Cancelar", "CommandButton")
432:         WITH loc_oSalva.cmd_4c_Cancelar
433:             .Caption         = "Encerrar"
434:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
435:             .PicturePosition = 13
436:             .Top             = 5
437:             .Left            = 80
438:             .Width           = 75
439:             .Height          = 75
440:             .BackColor       = RGB(255, 255, 255)
441:             .ForeColor       = RGB(90, 90, 90)
442:             .FontName        = "Comic Sans MS"
443:             .FontBold        = .T.
444:             .FontItalic      = .T.
445:             .FontSize        = 8
446:             .Themes          = .F.
447:             .SpecialEffect   = 0
448:             .MousePointer    = 15
449:             .WordWrap        = .T.
450:             .Visible         = .T.
451:         ENDWITH
452: 
453:         BINDEVENT(loc_oSalva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
454:         BINDEVENT(loc_oSalva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
455: 
456:         *-- Shape2: separador no topo da area de dados (top=138+29=167)
457:         loc_oPg2.AddObject("shp_4c_Shape2", "Shape")
458:         WITH loc_oPg2.shp_4c_Shape2
459:             .Top       = 167
460:             .Left      = 54
461:             .Width     = 577
462:             .Height    = 2
463:             .BackColor = RGB(80, 80, 80)
464:             .FillStyle = 1
465:             .BackStyle = 1
466:             .Visible   = .T.
467:         ENDWITH
468: 
469:         *-- ==============================================================
470:         *-- SECAO: Condicao de Pagamento (top original=121-144 + 29=150-173)
471:         *-- ==============================================================
472:         loc_oPg2.AddObject("lbl_4c_Label1", "Label")
473:         WITH loc_oPg2.lbl_4c_Label1
474:             .AutoSize  = .F.
475:             .Caption   = " Condi" + CHR(231) + CHR(227) + "o de Pagamento "
476:             .Top       = 150
477:             .Left      = 61
478:             .Width     = 144
479:             .Height    = 15
480:             .FontName  = "Tahoma"
481:             .FontSize  = 8
482:             .FontBold  = .F.

*-- Linhas 489 a 1532:
489:         loc_oPg2.AddObject("txt_4c_FPags", "TextBox")
490:         WITH loc_oPg2.txt_4c_FPags
491:             .Value    = ""
492:             .Top      = 173
493:             .Left     = 64
494:             .Width    = 94
495:             .Height   = 18
496:             .FontName = "Tahoma"
497:             .FontSize = 8
498:             .Enabled  = .F.
499:             .Visible  = .T.
500:         ENDWITH
501: 
502:         *-- txt_4c_DPags: descricao da condicao (display only, vem de SigOpFp.Descrs)
503:         loc_oPg2.AddObject("txt_4c_DPags", "TextBox")
504:         WITH loc_oPg2.txt_4c_DPags
505:             .Value    = ""
506:             .Top      = 173
507:             .Left     = 159
508:             .Width    = 220
509:             .Height   = 18
510:             .FontName = "Tahoma"
511:             .FontSize = 8
512:             .Enabled  = .F.
513:             .Visible  = .T.
514:         ENDWITH
515: 
516:         *-- Shape7: separador entre Condicao e Cabecalho (top=201+29=230)
517:         loc_oPg2.AddObject("shp_4c_Shape7", "Shape")
518:         WITH loc_oPg2.shp_4c_Shape7
519:             .Top       = 230
520:             .Left      = 54
521:             .Width     = 577
522:             .Height    = 2
523:             .BackColor = RGB(80, 80, 80)
524:             .FillStyle = 1
525:             .BackStyle = 1
526:             .Visible   = .T.
527:         ENDWITH
528: 
529:         *-- ==============================================================
530:         *-- SECAO: Cabecalho (top original=184+29=213)
531:         *-- Campos sao pares linha x coluna para posicionamento no boleto
532:         *-- ==============================================================
533:         loc_oPg2.AddObject("lbl_4c_Label28", "Label")
534:         WITH loc_oPg2.lbl_4c_Label28
535:             .AutoSize  = .F.
536:             .Caption   = " Cabe" + CHR(231) + "alho "
537:             .Top       = 213
538:             .Left      = 61
539:             .Width     = 66
540:             .Height    = 15
541:             .FontName  = "Tahoma"
542:             .FontSize  = 8
543:             .FontBold  = .T.
544:             .ForeColor = RGB(255, 255, 255)
545:             .BackStyle = 0
546:             .Visible   = .T.
547:         ENDWITH
548: 
549:         *-- Local de Pagamento (Label2 + Text1 x Text2) top=206+29=235 / 220+29=249
550:         loc_oPg2.AddObject("lbl_4c_Label2", "Label")
551:         WITH loc_oPg2.lbl_4c_Label2
552:             .AutoSize  = .F.
553:             .Caption   = "Local de Pagamento"
554:             .Top       = 235
555:             .Left      = 64
556:             .Width     = 98
557:             .Height    = 15
558:             .FontName  = "Tahoma"
559:             .FontSize  = 8
560:             .ForeColor = RGB(255, 255, 255)
561:             .BackStyle = 0
562:             .Visible   = .T.
563:         ENDWITH
564: 
565:         loc_oPg2.AddObject("txt_4c_Text1", "TextBox")
566:         WITH loc_oPg2.txt_4c_Text1
567:             .Value    = 0
568:             .Top      = 249
569:             .Left     = 64
570:             .Width    = 41
571:             .Height   = 18
572:             .FontName = "Tahoma"
573:             .FontSize = 8
574:             .Enabled  = .F.
575:             .Visible  = .T.
576:         ENDWITH
577: 
578:         loc_oPg2.AddObject("lbl_4c_Label3", "Label")
579:         WITH loc_oPg2.lbl_4c_Label3
580:             .AutoSize  = .F.
581:             .Caption   = "x"
582:             .Top       = 250
583:             .Left      = 109
584:             .Width     = 8
585:             .Height    = 15
586:             .FontName  = "Tahoma"
587:             .FontSize  = 8
588:             .ForeColor = RGB(255, 255, 255)
589:             .BackStyle = 0
590:             .Visible   = .T.
591:         ENDWITH
592: 
593:         loc_oPg2.AddObject("txt_4c_Text2", "TextBox")
594:         WITH loc_oPg2.txt_4c_Text2
595:             .Value    = 0
596:             .Top      = 249
597:             .Left     = 118
598:             .Width    = 41
599:             .Height   = 18
600:             .FontName = "Tahoma"
601:             .FontSize = 8
602:             .Enabled  = .F.
603:             .Visible  = .T.
604:         ENDWITH
605: 
606:         *-- Vencimento (Label4 + Text3 x Text4)
607:         loc_oPg2.AddObject("lbl_4c_Label4", "Label")
608:         WITH loc_oPg2.lbl_4c_Label4
609:             .AutoSize  = .F.
610:             .Caption   = "Vencimento"
611:             .Top       = 235
612:             .Left      = 179
613:             .Width     = 57
614:             .Height    = 15
615:             .FontName  = "Tahoma"
616:             .FontSize  = 8
617:             .ForeColor = RGB(255, 255, 255)
618:             .BackStyle = 0
619:             .Visible   = .T.
620:         ENDWITH
621: 
622:         loc_oPg2.AddObject("txt_4c_Text3", "TextBox")
623:         WITH loc_oPg2.txt_4c_Text3
624:             .Value    = 0
625:             .Top      = 249
626:             .Left     = 179
627:             .Width    = 41
628:             .Height   = 18
629:             .FontName = "Tahoma"
630:             .FontSize = 8
631:             .Enabled  = .F.
632:             .Visible  = .T.
633:         ENDWITH
634: 
635:         loc_oPg2.AddObject("lbl_4c_Label5", "Label")
636:         WITH loc_oPg2.lbl_4c_Label5
637:             .AutoSize  = .F.
638:             .Caption   = "x"
639:             .Top       = 250
640:             .Left      = 224
641:             .Width     = 8
642:             .Height    = 15
643:             .FontName  = "Tahoma"
644:             .FontSize  = 8
645:             .ForeColor = RGB(255, 255, 255)
646:             .BackStyle = 0
647:             .Visible   = .T.
648:         ENDWITH
649: 
650:         loc_oPg2.AddObject("txt_4c_Text4", "TextBox")
651:         WITH loc_oPg2.txt_4c_Text4
652:             .Value    = 0
653:             .Top      = 249
654:             .Left     = 233
655:             .Width    = 41
656:             .Height   = 18
657:             .FontName = "Tahoma"
658:             .FontSize = 8
659:             .Enabled  = .F.
660:             .Visible  = .T.
661:         ENDWITH
662: 
663:         *-- Data Documento (Label6 + Text5 x Text6)
664:         loc_oPg2.AddObject("lbl_4c_Label6", "Label")
665:         WITH loc_oPg2.lbl_4c_Label6
666:             .AutoSize  = .F.
667:             .Caption   = "Data Documento"
668:             .Top       = 235
669:             .Left      = 294
670:             .Width     = 82
671:             .Height    = 15
672:             .FontName  = "Tahoma"
673:             .FontSize  = 8
674:             .ForeColor = RGB(255, 255, 255)
675:             .BackStyle = 0
676:             .Visible   = .T.
677:         ENDWITH
678: 
679:         loc_oPg2.AddObject("txt_4c_Text5", "TextBox")
680:         WITH loc_oPg2.txt_4c_Text5
681:             .Value    = 0
682:             .Top      = 249
683:             .Left     = 294
684:             .Width    = 41
685:             .Height   = 18
686:             .FontName = "Tahoma"
687:             .FontSize = 8
688:             .Enabled  = .F.
689:             .Visible  = .T.
690:         ENDWITH
691: 
692:         loc_oPg2.AddObject("lbl_4c_Label7", "Label")
693:         WITH loc_oPg2.lbl_4c_Label7
694:             .AutoSize  = .F.
695:             .Caption   = "x"
696:             .Top       = 250
697:             .Left      = 339
698:             .Width     = 8
699:             .Height    = 15
700:             .FontName  = "Tahoma"
701:             .FontSize  = 8
702:             .ForeColor = RGB(255, 255, 255)
703:             .BackStyle = 0
704:             .Visible   = .T.
705:         ENDWITH
706: 
707:         loc_oPg2.AddObject("txt_4c_Text6", "TextBox")
708:         WITH loc_oPg2.txt_4c_Text6
709:             .Value    = 0
710:             .Top      = 249
711:             .Left     = 348
712:             .Width    = 41
713:             .Height   = 18
714:             .FontName = "Tahoma"
715:             .FontSize = 8
716:             .Enabled  = .F.
717:             .Visible  = .T.
718:         ENDWITH
719: 
720:         *-- Nro do Documento (Label8 + Text7 x Text8)
721:         loc_oPg2.AddObject("lbl_4c_Label8", "Label")
722:         WITH loc_oPg2.lbl_4c_Label8
723:             .AutoSize  = .F.
724:             .Caption   = "N" + CHR(186) + " do Documento"
725:             .Top       = 235
726:             .Left      = 409
727:             .Width     = 86
728:             .Height    = 15
729:             .FontName  = "Tahoma"
730:             .FontSize  = 8
731:             .ForeColor = RGB(255, 255, 255)
732:             .BackStyle = 0
733:             .Visible   = .T.
734:         ENDWITH
735: 
736:         loc_oPg2.AddObject("txt_4c_Text7", "TextBox")
737:         WITH loc_oPg2.txt_4c_Text7
738:             .Value    = 0
739:             .Top      = 249
740:             .Left     = 409
741:             .Width    = 41
742:             .Height   = 18
743:             .FontName = "Tahoma"
744:             .FontSize = 8
745:             .Enabled  = .F.
746:             .Visible  = .T.
747:         ENDWITH
748: 
749:         loc_oPg2.AddObject("lbl_4c_Label9", "Label")
750:         WITH loc_oPg2.lbl_4c_Label9
751:             .AutoSize  = .F.
752:             .Caption   = "x"
753:             .Top       = 250
754:             .Left      = 454
755:             .Width     = 8
756:             .Height    = 15
757:             .FontName  = "Tahoma"
758:             .FontSize  = 8
759:             .ForeColor = RGB(255, 255, 255)
760:             .BackStyle = 0
761:             .Visible   = .T.
762:         ENDWITH
763: 
764:         loc_oPg2.AddObject("txt_4c_Text8", "TextBox")
765:         WITH loc_oPg2.txt_4c_Text8
766:             .Value    = 0
767:             .Top      = 249
768:             .Left     = 463
769:             .Width    = 41
770:             .Height   = 18
771:             .FontName = "Tahoma"
772:             .FontSize = 8
773:             .Enabled  = .F.
774:             .Visible  = .T.
775:         ENDWITH
776: 
777:         *-- Valor do Documento (Label10 + Text9 x Text10)
778:         loc_oPg2.AddObject("lbl_4c_Label10", "Label")
779:         WITH loc_oPg2.lbl_4c_Label10
780:             .AutoSize  = .F.
781:             .Caption   = "Valor do Documento"
782:             .Top       = 235
783:             .Left      = 524
784:             .Width     = 98
785:             .Height    = 15
786:             .FontName  = "Tahoma"
787:             .FontSize  = 8
788:             .ForeColor = RGB(255, 255, 255)
789:             .BackStyle = 0
790:             .Visible   = .T.
791:         ENDWITH
792: 
793:         loc_oPg2.AddObject("txt_4c_Text9", "TextBox")
794:         WITH loc_oPg2.txt_4c_Text9
795:             .Value    = 0
796:             .Top      = 249
797:             .Left     = 524
798:             .Width    = 41
799:             .Height   = 18
800:             .FontName = "Tahoma"
801:             .FontSize = 8
802:             .Enabled  = .F.
803:             .Visible  = .T.
804:         ENDWITH
805: 
806:         loc_oPg2.AddObject("lbl_4c_Label11", "Label")
807:         WITH loc_oPg2.lbl_4c_Label11
808:             .AutoSize  = .F.
809:             .Caption   = "x"
810:             .Top       = 250
811:             .Left      = 569
812:             .Width     = 8
813:             .Height    = 15
814:             .FontName  = "Tahoma"
815:             .FontSize  = 8
816:             .ForeColor = RGB(255, 255, 255)
817:             .BackStyle = 0
818:             .Visible   = .T.
819:         ENDWITH
820: 
821:         loc_oPg2.AddObject("txt_4c_Text10", "TextBox")
822:         WITH loc_oPg2.txt_4c_Text10
823:             .Value    = 0
824:             .Top      = 249
825:             .Left     = 578
826:             .Width    = 41
827:             .Height   = 18
828:             .FontName = "Tahoma"
829:             .FontSize = 8
830:             .Enabled  = .F.
831:             .Visible  = .T.
832:         ENDWITH
833: 
834:         *-- Shape6: separador Cabecalho / Texto Responsabilidade (top=275+29=304)
835:         loc_oPg2.AddObject("shp_4c_Shape6", "Shape")
836:         WITH loc_oPg2.shp_4c_Shape6
837:             .Top       = 304
838:             .Left      = 54
839:             .Width     = 577
840:             .Height    = 2
841:             .BackColor = RGB(80, 80, 80)
842:             .FillStyle = 1
843:             .BackStyle = 1
844:             .Visible   = .T.
845:         ENDWITH
846: 
847:         *-- ==============================================================
848:         *-- SECAO: Texto de Responsabilidade do Cedente (top=258+29=287)
849:         *-- ==============================================================
850:         loc_oPg2.AddObject("lbl_4c_Label29", "Label")
851:         WITH loc_oPg2.lbl_4c_Label29
852:             .AutoSize  = .F.
853:             .Caption   = " Texto de Responsabilidade do Cedente "
854:             .Top       = 287
855:             .Left      = 61
856:             .Width     = 227
857:             .Height    = 15
858:             .FontName  = "Tahoma"
859:             .FontSize  = 8
860:             .FontBold  = .T.
861:             .ForeColor = RGB(255, 255, 255)
862:             .BackStyle = 0
863:             .Visible   = .T.
864:         ENDWITH
865: 
866:         *-- Texto (Label12 + Text11 x Text12) top=280+29=309 / 295+29=324
867:         loc_oPg2.AddObject("lbl_4c_Label12", "Label")
868:         WITH loc_oPg2.lbl_4c_Label12
869:             .AutoSize  = .F.
870:             .Caption   = "Texto"
871:             .Top       = 309
872:             .Left      = 64
873:             .Width     = 30
874:             .Height    = 15
875:             .FontName  = "Tahoma"
876:             .FontSize  = 8
877:             .ForeColor = RGB(255, 255, 255)
878:             .BackStyle = 0
879:             .Visible   = .T.
880:         ENDWITH
881: 
882:         loc_oPg2.AddObject("txt_4c_Text11", "TextBox")
883:         WITH loc_oPg2.txt_4c_Text11
884:             .Value    = 0
885:             .Top      = 324
886:             .Left     = 64
887:             .Width    = 41
888:             .Height   = 18
889:             .FontName = "Tahoma"
890:             .FontSize = 8
891:             .Enabled  = .F.
892:             .Visible  = .T.
893:         ENDWITH
894: 
895:         loc_oPg2.AddObject("lbl_4c_Label13", "Label")
896:         WITH loc_oPg2.lbl_4c_Label13
897:             .AutoSize  = .F.
898:             .Caption   = "x"
899:             .Top       = 325
900:             .Left      = 109
901:             .Width     = 8
902:             .Height    = 15
903:             .FontName  = "Tahoma"
904:             .FontSize  = 8
905:             .ForeColor = RGB(255, 255, 255)
906:             .BackStyle = 0
907:             .Visible   = .T.
908:         ENDWITH
909: 
910:         loc_oPg2.AddObject("txt_4c_Text12", "TextBox")
911:         WITH loc_oPg2.txt_4c_Text12
912:             .Value    = 0
913:             .Top      = 324
914:             .Left     = 118
915:             .Width    = 41
916:             .Height   = 18
917:             .FontName = "Tahoma"
918:             .FontSize = 8
919:             .Enabled  = .F.
920:             .Visible  = .T.
921:         ENDWITH
922: 
923:         *-- Nro Colunas (Label31 + Text13)
924:         loc_oPg2.AddObject("lbl_4c_Label31", "Label")
925:         WITH loc_oPg2.lbl_4c_Label31
926:             .AutoSize  = .F.
927:             .Caption   = "N" + CHR(186) + " Colunas"
928:             .Top       = 309
929:             .Left      = 180
930:             .Width     = 55
931:             .Height    = 15
932:             .FontName  = "Tahoma"
933:             .FontSize  = 8
934:             .ForeColor = RGB(255, 255, 255)
935:             .BackStyle = 0
936:             .Visible   = .T.
937:         ENDWITH
938: 
939:         loc_oPg2.AddObject("txt_4c_Text13", "TextBox")
940:         WITH loc_oPg2.txt_4c_Text13
941:             .Value    = 0
942:             .Top      = 324
943:             .Left     = 179
944:             .Width    = 41
945:             .Height   = 18
946:             .FontName = "Tahoma"
947:             .FontSize = 8
948:             .Enabled  = .F.
949:             .Visible  = .T.
950:         ENDWITH
951: 
952:         *-- Nro Linhas (Label30 + Text14)
953:         loc_oPg2.AddObject("lbl_4c_Label30", "Label")
954:         WITH loc_oPg2.lbl_4c_Label30
955:             .AutoSize  = .F.
956:             .Caption   = "N" + CHR(186) + " Linhas"
957:             .Top       = 309
958:             .Left      = 246
959:             .Width     = 47
960:             .Height    = 15
961:             .FontName  = "Tahoma"
962:             .FontSize  = 8
963:             .ForeColor = RGB(255, 255, 255)
964:             .BackStyle = 0
965:             .Visible   = .T.
966:         ENDWITH
967: 
968:         loc_oPg2.AddObject("txt_4c_Text14", "TextBox")
969:         WITH loc_oPg2.txt_4c_Text14
970:             .Value    = 0
971:             .Top      = 324
972:             .Left     = 246
973:             .Width    = 41
974:             .Height   = 18
975:             .FontName = "Tahoma"
976:             .FontSize = 8
977:             .Enabled  = .F.
978:             .Visible  = .T.
979:         ENDWITH
980: 
981:         *-- Shape3: separador Texto / Sacado (top=349+29=378)
982:         loc_oPg2.AddObject("shp_4c_Shape3", "Shape")
983:         WITH loc_oPg2.shp_4c_Shape3
984:             .Top       = 378
985:             .Left      = 54
986:             .Width     = 577
987:             .Height    = 2
988:             .BackColor = RGB(80, 80, 80)
989:             .FillStyle = 1
990:             .BackStyle = 1
991:             .Visible   = .T.
992:         ENDWITH
993: 
994:         *-- ==============================================================
995:         *-- SECAO: Sacado (top original=332+29=361)
996:         *-- Campos sao pares linha x coluna para posicionamento no boleto
997:         *-- ==============================================================
998:         loc_oPg2.AddObject("lbl_4c_Label32", "Label")
999:         WITH loc_oPg2.lbl_4c_Label32
1000:             .AutoSize  = .F.
1001:             .Caption   = " Sacado "
1002:             .Top       = 361
1003:             .Left      = 61
1004:             .Width     = 49
1005:             .Height    = 15
1006:             .FontName  = "Tahoma"
1007:             .FontSize  = 8
1008:             .FontBold  = .T.
1009:             .ForeColor = RGB(255, 255, 255)
1010:             .BackStyle = 0
1011:             .Visible   = .T.
1012:         ENDWITH
1013: 
1014:         *-- Razao Social (Label14 + Text15 x Text16) top=354+29=383 / 369+29=398
1015:         loc_oPg2.AddObject("lbl_4c_Label14", "Label")
1016:         WITH loc_oPg2.lbl_4c_Label14
1017:             .AutoSize  = .F.
1018:             .Caption   = "Raz" + CHR(227) + "o Social"
1019:             .Top       = 383
1020:             .Left      = 64
1021:             .Width     = 62
1022:             .Height    = 15
1023:             .FontName  = "Tahoma"
1024:             .FontSize  = 8
1025:             .ForeColor = RGB(255, 255, 255)
1026:             .BackStyle = 0
1027:             .Visible   = .T.
1028:         ENDWITH
1029:         loc_oPg2.AddObject("txt_4c_Text15", "TextBox")
1030:         WITH loc_oPg2.txt_4c_Text15
1031:             .Value    = 0
1032:             .Top      = 398
1033:             .Left     = 64
1034:             .Width    = 41
1035:             .Height   = 18
1036:             .FontName = "Tahoma"
1037:             .FontSize = 8
1038:             .Enabled  = .F.
1039:             .Visible  = .T.
1040:         ENDWITH
1041:         loc_oPg2.AddObject("lbl_4c_Label15", "Label")
1042:         WITH loc_oPg2.lbl_4c_Label15
1043:             .AutoSize  = .F.
1044:             .Caption   = "x"
1045:             .Top       = 399
1046:             .Left      = 109
1047:             .Width     = 8
1048:             .Height    = 15
1049:             .FontName  = "Tahoma"
1050:             .FontSize  = 8
1051:             .ForeColor = RGB(255, 255, 255)
1052:             .BackStyle = 0
1053:             .Visible   = .T.
1054:         ENDWITH
1055:         loc_oPg2.AddObject("txt_4c_Text16", "TextBox")
1056:         WITH loc_oPg2.txt_4c_Text16
1057:             .Value    = 0
1058:             .Top      = 398
1059:             .Left     = 118
1060:             .Width    = 41
1061:             .Height   = 18
1062:             .FontName = "Tahoma"
1063:             .FontSize = 8
1064:             .Enabled  = .F.
1065:             .Visible  = .T.
1066:         ENDWITH
1067: 
1068:         *-- C.G.C./C.P.F. (Label16 + Text17 x Text18)
1069:         loc_oPg2.AddObject("lbl_4c_Label16", "Label")
1070:         WITH loc_oPg2.lbl_4c_Label16
1071:             .AutoSize  = .F.
1072:             .Caption   = "C.G.C./C.P.F."
1073:             .Top       = 383
1074:             .Left      = 179
1075:             .Width     = 70
1076:             .Height    = 15
1077:             .FontName  = "Tahoma"
1078:             .FontSize  = 8
1079:             .ForeColor = RGB(255, 255, 255)
1080:             .BackStyle = 0
1081:             .Visible   = .T.
1082:         ENDWITH
1083:         loc_oPg2.AddObject("txt_4c_Text17", "TextBox")
1084:         WITH loc_oPg2.txt_4c_Text17
1085:             .Value    = 0
1086:             .Top      = 398
1087:             .Left     = 179
1088:             .Width    = 41
1089:             .Height   = 18
1090:             .FontName = "Tahoma"
1091:             .FontSize = 8
1092:             .Enabled  = .F.
1093:             .Visible  = .T.
1094:         ENDWITH
1095:         loc_oPg2.AddObject("lbl_4c_Label17", "Label")
1096:         WITH loc_oPg2.lbl_4c_Label17
1097:             .AutoSize  = .F.
1098:             .Caption   = "x"
1099:             .Top       = 399
1100:             .Left      = 224
1101:             .Width     = 8
1102:             .Height    = 15
1103:             .FontName  = "Tahoma"
1104:             .FontSize  = 8
1105:             .ForeColor = RGB(255, 255, 255)
1106:             .BackStyle = 0
1107:             .Visible   = .T.
1108:         ENDWITH
1109:         loc_oPg2.AddObject("txt_4c_Text18", "TextBox")
1110:         WITH loc_oPg2.txt_4c_Text18
1111:             .Value    = 0
1112:             .Top      = 398
1113:             .Left     = 233
1114:             .Width    = 41
1115:             .Height   = 18
1116:             .FontName = "Tahoma"
1117:             .FontSize = 8
1118:             .Enabled  = .F.
1119:             .Visible  = .T.
1120:         ENDWITH
1121: 
1122:         *-- Endereco (Label18 + Text19 x Text20)
1123:         loc_oPg2.AddObject("lbl_4c_Label18", "Label")
1124:         WITH loc_oPg2.lbl_4c_Label18
1125:             .AutoSize  = .F.
1126:             .Caption   = "Endere" + CHR(231) + "o"
1127:             .Top       = 383
1128:             .Left      = 294
1129:             .Width     = 47
1130:             .Height    = 15
1131:             .FontName  = "Tahoma"
1132:             .FontSize  = 8
1133:             .ForeColor = RGB(255, 255, 255)
1134:             .BackStyle = 0
1135:             .Visible   = .T.
1136:         ENDWITH
1137:         loc_oPg2.AddObject("txt_4c_Text19", "TextBox")
1138:         WITH loc_oPg2.txt_4c_Text19
1139:             .Value    = 0
1140:             .Top      = 398
1141:             .Left     = 294
1142:             .Width    = 41
1143:             .Height   = 18
1144:             .FontName = "Tahoma"
1145:             .FontSize = 8
1146:             .Enabled  = .F.
1147:             .Visible  = .T.
1148:         ENDWITH
1149:         loc_oPg2.AddObject("lbl_4c_Label37", "Label")
1150:         WITH loc_oPg2.lbl_4c_Label37
1151:             .AutoSize  = .F.
1152:             .Caption   = "x"
1153:             .Top       = 399
1154:             .Left      = 339
1155:             .Width     = 8
1156:             .Height    = 15
1157:             .FontName  = "Tahoma"
1158:             .FontSize  = 8
1159:             .ForeColor = RGB(255, 255, 255)
1160:             .BackStyle = 0
1161:             .Visible   = .T.
1162:         ENDWITH
1163:         loc_oPg2.AddObject("txt_4c_Text20", "TextBox")
1164:         WITH loc_oPg2.txt_4c_Text20
1165:             .Value    = 0
1166:             .Top      = 398
1167:             .Left     = 348
1168:             .Width    = 41
1169:             .Height   = 18
1170:             .FontName = "Tahoma"
1171:             .FontSize = 8
1172:             .Enabled  = .F.
1173:             .Visible  = .T.
1174:         ENDWITH
1175: 
1176:         *-- Bairro (Label20 + Text21 x Text22)
1177:         loc_oPg2.AddObject("lbl_4c_Label20", "Label")
1178:         WITH loc_oPg2.lbl_4c_Label20
1179:             .AutoSize  = .F.
1180:             .Caption   = "Bairro"
1181:             .Top       = 383
1182:             .Left      = 409
1183:             .Width     = 30
1184:             .Height    = 15
1185:             .FontName  = "Tahoma"
1186:             .FontSize  = 8
1187:             .ForeColor = RGB(255, 255, 255)
1188:             .BackStyle = 0
1189:             .Visible   = .T.
1190:         ENDWITH
1191:         loc_oPg2.AddObject("txt_4c_Text21", "TextBox")
1192:         WITH loc_oPg2.txt_4c_Text21
1193:             .Value    = 0
1194:             .Top      = 398
1195:             .Left     = 409
1196:             .Width    = 41
1197:             .Height   = 18
1198:             .FontName = "Tahoma"
1199:             .FontSize = 8
1200:             .Enabled  = .F.
1201:             .Visible  = .T.
1202:         ENDWITH
1203:         loc_oPg2.AddObject("lbl_4c_Label21", "Label")
1204:         WITH loc_oPg2.lbl_4c_Label21
1205:             .AutoSize  = .F.
1206:             .Caption   = "x"
1207:             .Top       = 399
1208:             .Left      = 454
1209:             .Width     = 8
1210:             .Height    = 15
1211:             .FontName  = "Tahoma"
1212:             .FontSize  = 8
1213:             .ForeColor = RGB(255, 255, 255)
1214:             .BackStyle = 0
1215:             .Visible   = .T.
1216:         ENDWITH
1217:         loc_oPg2.AddObject("txt_4c_Text22", "TextBox")
1218:         WITH loc_oPg2.txt_4c_Text22
1219:             .Value    = 0
1220:             .Top      = 398
1221:             .Left     = 463
1222:             .Width    = 41
1223:             .Height   = 18
1224:             .FontName = "Tahoma"
1225:             .FontSize = 8
1226:             .Enabled  = .F.
1227:             .Visible  = .T.
1228:         ENDWITH
1229: 
1230:         *-- Cidade (Label22 + Text23 x Text24)
1231:         loc_oPg2.AddObject("lbl_4c_Label22", "Label")
1232:         WITH loc_oPg2.lbl_4c_Label22
1233:             .AutoSize  = .F.
1234:             .Caption   = "Cidade"
1235:             .Top       = 383
1236:             .Left      = 524
1237:             .Width     = 35
1238:             .Height    = 15
1239:             .FontName  = "Tahoma"
1240:             .FontSize  = 8
1241:             .ForeColor = RGB(255, 255, 255)
1242:             .BackStyle = 0
1243:             .Visible   = .T.
1244:         ENDWITH
1245:         loc_oPg2.AddObject("txt_4c_Text23", "TextBox")
1246:         WITH loc_oPg2.txt_4c_Text23
1247:             .Value    = 0
1248:             .Top      = 397
1249:             .Left     = 524
1250:             .Width    = 41
1251:             .Height   = 18
1252:             .FontName = "Tahoma"
1253:             .FontSize = 8
1254:             .Enabled  = .F.
1255:             .Visible  = .T.
1256:         ENDWITH
1257:         loc_oPg2.AddObject("lbl_4c_Label23", "Label")
1258:         WITH loc_oPg2.lbl_4c_Label23
1259:             .AutoSize  = .F.
1260:             .Caption   = "x"
1261:             .Top       = 398
1262:             .Left      = 569
1263:             .Width     = 8
1264:             .Height    = 15
1265:             .FontName  = "Tahoma"
1266:             .FontSize  = 8
1267:             .ForeColor = RGB(255, 255, 255)
1268:             .BackStyle = 0
1269:             .Visible   = .T.
1270:         ENDWITH
1271:         loc_oPg2.AddObject("txt_4c_Text24", "TextBox")
1272:         WITH loc_oPg2.txt_4c_Text24
1273:             .Value    = 0
1274:             .Top      = 397
1275:             .Left     = 578
1276:             .Width    = 41
1277:             .Height   = 18
1278:             .FontName = "Tahoma"
1279:             .FontSize = 8
1280:             .Enabled  = .F.
1281:             .Visible  = .T.
1282:         ENDWITH
1283: 
1284:         *-- U.F. (Label24 + Text25 x Text26) top=389+29=418 / 403+29=432
1285:         loc_oPg2.AddObject("lbl_4c_Label24", "Label")
1286:         WITH loc_oPg2.lbl_4c_Label24
1287:             .AutoSize  = .F.
1288:             .Caption   = "U.F."
1289:             .Top       = 418
1290:             .Left      = 65
1291:             .Width     = 23
1292:             .Height    = 15
1293:             .FontName  = "Tahoma"
1294:             .FontSize  = 8
1295:             .ForeColor = RGB(255, 255, 255)
1296:             .BackStyle = 0
1297:             .Visible   = .T.
1298:         ENDWITH
1299:         loc_oPg2.AddObject("txt_4c_Text25", "TextBox")
1300:         WITH loc_oPg2.txt_4c_Text25
1301:             .Value    = 0
1302:             .Top      = 432
1303:             .Left     = 65
1304:             .Width    = 41
1305:             .Height   = 18
1306:             .FontName = "Tahoma"
1307:             .FontSize = 8
1308:             .Enabled  = .F.
1309:             .Visible  = .T.
1310:         ENDWITH
1311:         loc_oPg2.AddObject("lbl_4c_Label25", "Label")
1312:         WITH loc_oPg2.lbl_4c_Label25
1313:             .AutoSize  = .F.
1314:             .Caption   = "x"
1315:             .Top       = 433
1316:             .Left      = 109
1317:             .Width     = 8
1318:             .Height    = 15
1319:             .FontName  = "Tahoma"
1320:             .FontSize  = 8
1321:             .ForeColor = RGB(255, 255, 255)
1322:             .BackStyle = 0
1323:             .Visible   = .T.
1324:         ENDWITH
1325:         loc_oPg2.AddObject("txt_4c_Text26", "TextBox")
1326:         WITH loc_oPg2.txt_4c_Text26
1327:             .Value    = 0
1328:             .Top      = 432
1329:             .Left     = 118
1330:             .Width    = 41
1331:             .Height   = 18
1332:             .FontName = "Tahoma"
1333:             .FontSize = 8
1334:             .Enabled  = .F.
1335:             .Visible  = .T.
1336:         ENDWITH
1337: 
1338:         *-- C.E.P. (Label26 + Text27 x Text28)
1339:         loc_oPg2.AddObject("lbl_4c_Label26", "Label")
1340:         WITH loc_oPg2.lbl_4c_Label26
1341:             .AutoSize  = .F.
1342:             .Caption   = "C.E.P."
1343:             .Top       = 418
1344:             .Left      = 179
1345:             .Width     = 33
1346:             .Height    = 15
1347:             .FontName  = "Tahoma"
1348:             .FontSize  = 8
1349:             .ForeColor = RGB(255, 255, 255)
1350:             .BackStyle = 0
1351:             .Visible   = .T.
1352:         ENDWITH
1353:         loc_oPg2.AddObject("txt_4c_Text27", "TextBox")
1354:         WITH loc_oPg2.txt_4c_Text27
1355:             .Value    = 0
1356:             .Top      = 432
1357:             .Left     = 179
1358:             .Width    = 41
1359:             .Height   = 18
1360:             .FontName = "Tahoma"
1361:             .FontSize = 8
1362:             .Enabled  = .F.
1363:             .Visible  = .T.
1364:         ENDWITH
1365:         loc_oPg2.AddObject("lbl_4c_Label27", "Label")
1366:         WITH loc_oPg2.lbl_4c_Label27
1367:             .AutoSize  = .F.
1368:             .Caption   = "x"
1369:             .Top       = 433
1370:             .Left      = 224
1371:             .Width     = 8
1372:             .Height    = 15
1373:             .FontName  = "Tahoma"
1374:             .FontSize  = 8
1375:             .ForeColor = RGB(255, 255, 255)
1376:             .BackStyle = 0
1377:             .Visible   = .T.
1378:         ENDWITH
1379:         loc_oPg2.AddObject("txt_4c_Text28", "TextBox")
1380:         WITH loc_oPg2.txt_4c_Text28
1381:             .Value    = 0
1382:             .Top      = 432
1383:             .Left     = 233
1384:             .Width    = 41
1385:             .Height   = 18
1386:             .FontName = "Tahoma"
1387:             .FontSize = 8
1388:             .Enabled  = .F.
1389:             .Visible  = .T.
1390:         ENDWITH
1391: 
1392:         *-- Shape4: separador Sacado / Impressora (top=456+29=485)
1393:         loc_oPg2.AddObject("shp_4c_Shape4", "Shape")
1394:         WITH loc_oPg2.shp_4c_Shape4
1395:             .Top       = 485
1396:             .Left      = 54
1397:             .Width     = 577
1398:             .Height    = 2
1399:             .BackColor = RGB(80, 80, 80)
1400:             .FillStyle = 1
1401:             .BackStyle = 1
1402:             .Visible   = .T.
1403:         ENDWITH
1404: 
1405:         *-- ==============================================================
1406:         *-- SECAO: Impressora / Fonte (top original=439+29=468)
1407:         *-- ==============================================================
1408:         loc_oPg2.AddObject("lbl_4c_Label36", "Label")
1409:         WITH loc_oPg2.lbl_4c_Label36
1410:             .AutoSize  = .F.
1411:             .Caption   = " Impressora / Fonte "
1412:             .Top       = 468
1413:             .Left      = 61
1414:             .Width     = 118
1415:             .Height    = 15
1416:             .FontName  = "Tahoma"
1417:             .FontSize  = 8
1418:             .FontBold  = .T.
1419:             .ForeColor = RGB(255, 255, 255)
1420:             .BackStyle = 0
1421:             .Visible   = .T.
1422:         ENDWITH
1423: 
1424:         *-- Nome da Impressora (Label33 + Text29) top=461+29=490 / 474+29=503
1425:         loc_oPg2.AddObject("lbl_4c_Label33", "Label")
1426:         WITH loc_oPg2.lbl_4c_Label33
1427:             .AutoSize  = .F.
1428:             .Caption   = "Nome da Impressora"
1429:             .Top       = 490
1430:             .Left      = 64
1431:             .Width     = 101
1432:             .Height    = 15
1433:             .FontName  = "Tahoma"
1434:             .FontSize  = 8
1435:             .ForeColor = RGB(255, 255, 255)
1436:             .BackStyle = 0
1437:             .Visible   = .T.
1438:         ENDWITH
1439:         loc_oPg2.AddObject("txt_4c_Text29", "TextBox")
1440:         WITH loc_oPg2.txt_4c_Text29
1441:             .Value    = ""
1442:             .Top      = 503
1443:             .Left     = 64
1444:             .Width    = 240
1445:             .Height   = 18
1446:             .FontName = "Tahoma"
1447:             .FontSize = 8
1448:             .Enabled  = .F.
1449:             .Visible  = .T.
1450:         ENDWITH
1451: 
1452:         *-- Fonte Padrao (Label34 + Text30) top=494+29=523 / 508+29=537
1453:         loc_oPg2.AddObject("lbl_4c_Label34", "Label")
1454:         WITH loc_oPg2.lbl_4c_Label34
1455:             .AutoSize  = .F.
1456:             .Caption   = "Fonte Padr" + CHR(227) + "o"
1457:             .Top       = 523
1458:             .Left      = 64
1459:             .Width     = 67
1460:             .Height    = 15
1461:             .FontName  = "Tahoma"
1462:             .FontSize  = 8
1463:             .ForeColor = RGB(255, 255, 255)
1464:             .BackStyle = 0
1465:             .Visible   = .T.
1466:         ENDWITH
1467:         loc_oPg2.AddObject("txt_4c_Text30", "TextBox")
1468:         WITH loc_oPg2.txt_4c_Text30
1469:             .Value    = ""
1470:             .Top      = 537
1471:             .Left     = 64
1472:             .Width    = 192
1473:             .Height   = 18
1474:             .FontName = "Tahoma"
1475:             .FontSize = 8
1476:             .Enabled  = .F.
1477:             .Visible  = .T.
1478:         ENDWITH
1479: 
1480:         *-- Tamanho Fonte (Label35 + Text31)
1481:         loc_oPg2.AddObject("lbl_4c_Label35", "Label")
1482:         WITH loc_oPg2.lbl_4c_Label35
1483:             .AutoSize  = .F.
1484:             .Caption   = "Tamanho"
1485:             .Top       = 523
1486:             .Left      = 263
1487:             .Width     = 46
1488:             .Height    = 15
1489:             .FontName  = "Tahoma"
1490:             .FontSize  = 8
1491:             .ForeColor = RGB(255, 255, 255)
1492:             .BackStyle = 0
1493:             .Visible   = .T.
1494:         ENDWITH
1495:         loc_oPg2.AddObject("txt_4c_Text31", "TextBox")
1496:         WITH loc_oPg2.txt_4c_Text31
1497:             .Value    = 0
1498:             .Top      = 537
1499:             .Left     = 263
1500:             .Width    = 41
1501:             .Height   = 18
1502:             .FontName = "Tahoma"
1503:             .FontSize = 8
1504:             .Enabled  = .F.
1505:             .Visible  = .T.
1506:         ENDWITH
1507: 
1508:         *-- Tamanho Folha (Label38 + Text40) top=460+29=489 / 473+29=502
1509:         loc_oPg2.AddObject("lbl_4c_Label38", "Label")
1510:         WITH loc_oPg2.lbl_4c_Label38
1511:             .AutoSize  = .F.
1512:             .Caption   = "Tamanho Folha"
1513:             .Top       = 489
1514:             .Left      = 337
1515:             .Width     = 75
1516:             .Height    = 15
1517:             .FontName  = "Tahoma"
1518:             .FontSize  = 8
1519:             .ForeColor = RGB(255, 255, 255)
1520:             .BackStyle = 0
1521:             .Visible   = .T.
1522:         ENDWITH
1523:         loc_oPg2.AddObject("txt_4c_Text40", "TextBox")
1524:         WITH loc_oPg2.txt_4c_Text40
1525:             .Value    = ""
1526:             .Top      = 502
1527:             .Left     = 336
1528:             .Width    = 244
1529:             .Height   = 19
1530:             .FontName = "Tahoma"
1531:             .FontSize = 8
1532:             .Enabled  = .F.

*-- Linhas 1565 a 1575:
1565:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.TemDados"
1566: 
1567:                     *-- Reconfigurar headers apos RecordSource (VFP9 reseta headers)
1568:                     loc_oGrid.Column1.Header1.Caption = "Forma Pgto"
1569:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1570:                     loc_oGrid.Column3.Header1.Caption = "Configurado"
1571: 
1572:                     THIS.FormatarGridLista(loc_oGrid)
1573:                     loc_lResultado = .T.
1574:                 ENDIF
1575:             ENDIF

*-- Linhas 1787 a 1797:
1787:         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.FPags"
1788:         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descrs"
1789:         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.TemDados"
1790:         loc_oGrid.Column1.Header1.Caption = "Forma Pgto"
1791:         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1792:         loc_oGrid.Column3.Header1.Caption = "Configurado"
1793:         THIS.FormatarGridLista(loc_oGrid)
1794:     ENDPROC
1795: 
1796:     *--------------------------------------------------------------------------
1797:     * FormParaBO - Transfere valores dos campos do Form para o BO

*-- Linhas 2071 a 2079:
2071: 
2072:         TRY
2073:             IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
2074:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
2075:             ENDIF
2076:             *-- txt_4c_FPags e txt_4c_DPags sao SEMPRE read-only (FK de SigOpFp)
2077: 
2078:             *-- Secao Cabecalho - Local de Pagamento
2079:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text1", 5)

*-- Linhas 2506 a 2516:
2506:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descrs"
2507:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.TemDados"
2508: 
2509:                 loc_oGrid.Column1.Header1.Caption = "Forma Pgto"
2510:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2511:                 loc_oGrid.Column3.Header1.Caption = "Configurado"
2512: 
2513:                 THIS.FormatarGridLista(loc_oGrid)
2514:                 loc_lResultado = .T.
2515:             ENDIF
2516:         CATCH TO loc_oErro

*-- Linhas 2708 a 2718:
2708:             loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descrs"
2709:             loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.TemDados"
2710: 
2711:             loc_oGrid.Column1.Header1.Caption = "Forma Pgto"
2712:             loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2713:             loc_oGrid.Column3.Header1.Caption = "Configurado"
2714: 
2715:             THIS.FormatarGridLista(loc_oGrid)
2716:         CATCH TO loc_oErro
2717:             MsgErro(loc_oErro.Message, "FormCfb.BtnBuscarClick")
2718:         ENDTRY

*-- Linhas 2763 a 2772:
2763:             loc_lAlterar = (THIS.this_cModoAtual = "ALTERAR")
2764: 
2765:             IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
2766:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lAlterar
2767:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
2768:             ENDIF
2769:         CATCH TO loc_oErro
2770:             MsgErro(loc_oErro.Message, "FormCfb.AjustarBotoesPorModo")
2771:         ENDTRY
2772:     ENDPROC


### BO (C:\4c\projeto\app\classes\CfbBO.prg):
*==============================================================================
* CfbBO.prg - Business Object: Configura??o de Boletos Banc?rios
* Tabela: SIGCNFBL
* PK: cidchaves (t?cnica) | Chave de neg?cio: fpags (FK SigOpFp)
*==============================================================================
DEFINE CLASS CfbBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - Chaves
    *--------------------------------------------------------------------------
    this_cCidChaves = ""    && cidchaves char(20) - PK t?cnica
    this_cFPags     = ""    && fpags     char(12) - chave de neg?cio (FK SigOpFp)

    *--------------------------------------------------------------------------
    * Propriedades - Audi/Controle
    *--------------------------------------------------------------------------
    this_cCEmps     = ""    && cemps      char(3)
    this_dDDatas    = {}    && ddatas     datetime
    this_cCHoras    = ""    && choras     char(8)
    this_cCUsuarios = ""    && cusuarios  char(20)

    *--------------------------------------------------------------------------
    * Propriedades - Texto livre (sem binding UI, preservado na grava??o)
    *--------------------------------------------------------------------------
    this_cCLocals   = ""    && clocals    char(100) - local de pagamento (texto)
    this_cCTxtCds   = ""    && ctxtcds    text      - texto de resp. do cedente

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Cabe?alho (Local de Pagamento)
    *--------------------------------------------------------------------------
    this_nNlnLocals = 0     && nlnlocals  numeric(5,2) - linha
    this_nNclLocals = 0     && ncllocals  numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Vencimento
    *--------------------------------------------------------------------------
    this_nNlnDtVencs = 0    && nlndtvencs numeric(5,2) - linha
    this_nNclDtVencs = 0    && ncldtvencs numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Data Documento
    *--------------------------------------------------------------------------
    this_nNlnDtDocs = 0     && nlndtdocs  numeric(5,2) - linha
    this_nNclDtDocs = 0     && ncldtdocs  numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o N? do Documento
    *--------------------------------------------------------------------------
    this_nNlnNrDocs = 0     && nlnnrdocs  numeric(5,2) - linha
    this_nNclNrDocs = 0     && nclnrdocs  numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Valor do Documento
    *--------------------------------------------------------------------------
    this_nNlnVlDocs = 0     && nlnvldocs  numeric(5,2) - linha
    this_nNclVlDocs = 0     && nclvldocs  numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Texto de Responsabilidade
    *--------------------------------------------------------------------------
    this_nNlnTxtCds = 0     && nlntxtcds  numeric(5,2) - linha
    this_nNclTxtCds = 0     && ncltxtcds  numeric(5,2) - coluna
    this_nNTxtLins  = 0     && ntxtlins   numeric(3,0) - n? de linhas
    this_nNTxtCols  = 0     && ntxtcols   numeric(3,0) - n? de colunas

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Sacado: Raz?o Social
    *--------------------------------------------------------------------------
    this_nNlnRazClis = 0    && nlnrazclis numeric(5,2) - linha
    this_nNclRazClis = 0    && nclrazclis numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Sacado: C.G.C./C.P.F.
    *--------------------------------------------------------------------------
    this_nNlnCgcClis = 0    && nlncgcclis numeric(5,2) - linha
    this_nNclCgcClis = 0    && nclcgcclis numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Sacado: Endere?o
    *--------------------------------------------------------------------------
    this_nNlnEndCobs = 0    && nlnendcobs numeric(5,2) - linha
    this_nNclEndCobs = 0    && nclendcobs numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Sacado: Bairro
    *--------------------------------------------------------------------------
    this_nNlnBaiCobs = 0    && nlnbaicobs numeric(5,2) - linha
    this_nNclBaiCobs = 0    && nclbaicobs numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Sacado: Cidade
    *--------------------------------------------------------------------------
    this_nNlnCidCobs = 0    && nlncidcobs numeric(5,2) - linha
    this_nNclCidCobs = 0    && nclcidcobs numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Sacado: U.F.
    *--------------------------------------------------------------------------
    this_nNlnEstCobs = 0    && nlnestcobs numeric(5,2) - linha
    this_nNclEstCobs = 0    && nclestcobs numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Sacado: C.E.P.
    *--------------------------------------------------------------------------
    this_nNlnCepCobs = 0    && nlncepcobs numeric(5,2) - linha
    this_nNclCepCobs = 0    && nclcepcobs numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Impressora / Fonte
    *--------------------------------------------------------------------------
    this_cCNomeImps  = ""   && cnomeimps  char(128) - nome da impressora
    this_cCFontePdrs = ""   && cfontepdrs char(128) - fonte padr?o
    this_nNTamFontes = 0    && ntamfontes numeric(3,0) - tamanho da fonte
    this_cCTamFolha  = ""   && ctamfolha  char(50)  - tamanho da folha

    *--------------------------------------------------------------------------
    * Propriedades auxiliares (display only, n?o persistidas em SIGCNFBL)
    *--------------------------------------------------------------------------
    this_cDescrs = ""       && Descrs de SigOpFp (descri??o da condi??o de pgto)

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        DODEFAULT()
        THIS.this_cTabela     = "SIGCNFBL"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *==========================================================================
    PROCEDURE ObterChavePrimaria()
    *==========================================================================
        RETURN THIS.this_cCidChaves
    ENDPROC

    *==========================================================================
    * Buscar - Lista condi??es de pagamento com indicador de configura??o
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = "SELECT DISTINCT a.FPags, a.Descrs," + ;
                    " b.FPags AS TemDados" + ;
                    " FROM SigOpFp a" + ;
                    " LEFT JOIN SIGCNFBL b ON a.FPags = b.FPags" + ;
                    " ORDER BY a.FPags"
            ELSE
                loc_cSQL = "SELECT DISTINCT a.FPags, a.Descrs," + ;
                    " b.FPags AS TemDados" + ;
                    " FROM SigOpFp a" + ;
                    " LEFT JOIN SIGCNFBL b ON a.FPags = b.FPags" + ;
                    " WHERE a.FPags = " + EscaparSQL(ALLTRIM(par_cFiltro)) + ;
                    " ORDER BY a.FPags"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar condi" + CHR(231) + CHR(245) + "es de pagamento:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar condi" + CHR(231) + CHR(245) + "es de pagamento:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega configura??o de boleto pelo fpags
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cFPags)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, fpags, cemps, ddatas, choras, cusuarios," + ;
                " ctxtcds, clocals," + ;
                " nlnlocals, ncllocals, nlndtvencs, ncldtvencs," + ;
                " nlndtdocs, ncldtdocs, nlnnrdocs, nclnrdocs," + ;
                " nlnvldocs, nclvldocs, nlntxtcds, ncltxtcds, ntxtlins, ntxtcols," + ;
                " nlnrazclis, nclrazclis, nlncgcclis, nclcgcclis," + ;
                " nlnendcobs, nclendcobs, nlnbaicobs, nclbaicobs," + ;
                " nlncidcobs, nclcidcobs, nlnestcobs, nclestcobs," + ;
                " nlncepcobs, nclcepcobs," + ;
                " cnomeimps, cfontepdrs, ntamfontes, ctamfolha" + ;
                " FROM SIGCNFBL" + ;
                " WHERE fpags = " + EscaparSQL(ALLTRIM(par_cFPags))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves    = TratarNulo(cidchaves,    "C")
            THIS.this_cFPags        = TratarNulo(fpags,        "C")
            THIS.this_cCEmps        = TratarNulo(cemps,        "C")
            THIS.this_dDDatas       = TratarNulo(ddatas,       "D")
            THIS.this_cCHoras       = TratarNulo(choras,       "C")
            THIS.this_cCUsuarios    = TratarNulo(cusuarios,    "C")
            THIS.this_cCTxtCds      = TratarNulo(ctxtcds,      "C")
            THIS.this_cCLocals      = TratarNulo(clocals,      "C")
            THIS.this_nNlnLocals    = TratarNulo(nlnlocals,    "N")
            THIS.this_nNclLocals    = TratarNulo(ncllocals,    "N")
            THIS.this_nNlnDtVencs   = TratarNulo(nlndtvencs,   "N")
            THIS.this_nNclDtVencs   = TratarNulo(ncldtvencs,   "N")
            THIS.this_nNlnDtDocs    = TratarNulo(nlndtdocs,    "N")
            THIS.this_nNclDtDocs    = TratarNulo(ncldtdocs,    "N")
            THIS.this_nNlnNrDocs    = TratarNulo(nlnnrdocs,    "N")
            THIS.this_nNclNrDocs    = TratarNulo(nclnrdocs,    "N")
            THIS.this_nNlnVlDocs    = TratarNulo(nlnvldocs,    "N")
            THIS.this_nNclVlDocs    = TratarNulo(nclvldocs,    "N")
            THIS.this_nNlnTxtCds    = TratarNulo(nlntxtcds,    "N")
            THIS.this_nNclTxtCds    = TratarNulo(ncltxtcds,    "N")
            THIS.this_nNTxtLins     = TratarNulo(ntxtlins,     "N")
            THIS.this_nNTxtCols     = TratarNulo(ntxtcols,     "N")
            THIS.this_nNlnRazClis   = TratarNulo(nlnrazclis,   "N")
            THIS.this_nNclRazClis   = TratarNulo(nclrazclis,   "N")
            THIS.this_nNlnCgcClis   = TratarNulo(nlncgcclis,   "N")
            THIS.this_nNclCgcClis   = TratarNulo(nclcgcclis,   "N")
            THIS.this_nNlnEndCobs   = TratarNulo(nlnendcobs,   "N")
            THIS.this_nNclEndCobs   = TratarNulo(nclendcobs,   "N")
            THIS.this_nNlnBaiCobs   = TratarNulo(nlnbaicobs,   "N")
            THIS.this_nNclBaiCobs   = TratarNulo(nclbaicobs,   "N")
            THIS.this_nNlnCidCobs   = TratarNulo(nlncidcobs,   "N")
            THIS.this_nNclCidCobs   = TratarNulo(nclcidcobs,   "N")
            THIS.this_nNlnEstCobs   = TratarNulo(nlnestcobs,   "N")
            THIS.this_nNclEstCobs   = TratarNulo(nclestcobs,   "N")
            THIS.this_nNlnCepCobs   = TratarNulo(nlncepcobs,   "N")
            THIS.this_nNclCepCobs   = TratarNulo(nclcepcobs,   "N")
            THIS.this_cCNomeImps    = TratarNulo(cnomeimps,    "C")
            THIS.this_cCFontePdrs   = TratarNulo(cfontepdrs,   "C")
            THIS.this_nNTamFontes   = TratarNulo(ntamfontes,   "N")
            THIS.this_cCTamFolha    = TratarNulo(ctamfolha,    "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Insere nova configura??o de boleto bancario
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_cVals, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SIGCNFBL" + ;
                " (cidchaves, fpags, cemps, ddatas, choras, cusuarios," + ;
                " ctxtcds, clocals," + ;
                " nlnlocals, ncllocals, nlndtvencs, ncldtvencs," + ;
                " nlndtdocs, ncldtdocs, nlnnrdocs, nclnrdocs," + ;
                " nlnvldocs, nclvldocs, nlntxtcds, ncltxtcds, ntxtlins, ntxtcols," + ;
                " nlnrazclis, nclrazclis, nlncgcclis, nclcgcclis," + ;
                " nlnendcobs, nclendcobs, nlnbaicobs, nclbaicobs," + ;
                " nlncidcobs, nclcidcobs, nlnestcobs, nclestcobs," + ;
                " nlncepcobs, nclcepcobs," + ;
                " cnomeimps, cfontepdrs, ntamfontes, ctamfolha)"

            loc_cVals = " VALUES (LEFT(NEWID(), 20)," + ;
                " " + EscaparSQL(ALLTRIM(THIS.this_cFPags)) + "," + ;
                " " + EscaparSQL(LEFT(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3)) + "," + ;
                " GETDATE()," + ;
                " " + EscaparSQL(LEFT(TIME(), 8)) + "," + ;
                " " + EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 20)) + "," + ;
                " " + EscaparSQL(ALLTRIM(THIS.this_cCTxtCds)) + "," + ;
                " " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCLocals), 100)) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnLocals) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclLocals) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnDtVencs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclDtVencs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnDtDocs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclDtDocs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnNrDocs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclNrDocs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnVlDocs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclVlDocs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnTxtCds) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclTxtCds) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNTxtLins) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNTxtCols) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnRazClis) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclRazClis) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnCgcClis) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclCgcClis) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnEndCobs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclEndCobs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnBaiCobs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclBaiCobs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnCidCobs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclCidCobs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnEstCobs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclEstCobs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnCepCobs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclCepCobs) + "," + ;
                " " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCNomeImps), 128)) + "," + ;
                " " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCFontePdrs), 128)) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNTamFontes) + "," + ;
                " " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCTamFolha), 50)) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL + loc_cVals, "cursor_4c_Ins")
            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza configura??o de boleto bancario existente
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SIGCNFBL SET" + ;
                " cemps = " + EscaparSQL(LEFT(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3)) + "," + ;
                " ddatas = GETDATE()," + ;
                " choras = " + EscaparSQL(LEFT(TIME(), 8)) + "," + ;
                " cusuarios = " + EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 20)) + "," + ;
                " ctxtcds = " + EscaparSQL(ALLTRIM(THIS.this_cCTxtCds)) + "," + ;
                " clocals = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCLocals), 100)) + "," + ;
                " nlnlocals = " + FormatarNumeroSQL(THIS.this_nNlnLocals) + "," + ;
                " ncllocals = " + FormatarNumeroSQL(THIS.this_nNclLocals) + "," + ;
                " nlndtvencs = " + FormatarNumeroSQL(THIS.this_nNlnDtVencs) + "," + ;
                " ncldtvencs = " + FormatarNumeroSQL(THIS.this_nNclDtVencs) + "," + ;
                " nlndtdocs = " + FormatarNumeroSQL(THIS.this_nNlnDtDocs) + "," + ;
                " ncldtdocs = " + FormatarNumeroSQL(THIS.this_nNclDtDocs) + "," + ;
                " nlnnrdocs = " + FormatarNumeroSQL(THIS.this_nNlnNrDocs) + "," + ;
                " nclnrdocs = " + FormatarNumeroSQL(THIS.this_nNclNrDocs) + "," + ;
                " nlnvldocs = " + FormatarNumeroSQL(THIS.this_nNlnVlDocs) + "," + ;
                " nclvldocs = " + FormatarNumeroSQL(THIS.this_nNclVlDocs) + "," + ;
                " nlntxtcds = " + FormatarNumeroSQL(THIS.this_nNlnTxtCds) + "," + ;
                " ncltxtcds = " + FormatarNumeroSQL(THIS.this_nNclTxtCds) + "," + ;
                " ntxtlins = " + FormatarNumeroSQL(THIS.this_nNTxtLins) + "," + ;
                " ntxtcols = " + FormatarNumeroSQL(THIS.this_nNTxtCols) + "," + ;
                " nlnrazclis = " + FormatarNumeroSQL(THIS.this_nNlnRazClis) + "," + ;
                " nclrazclis = " + FormatarNumeroSQL(THIS.this_nNclRazClis) + "," + ;
                " nlncgcclis = " + FormatarNumeroSQL(THIS.this_nNlnCgcClis) + "," + ;
                " nclcgcclis = " + FormatarNumeroSQL(THIS.this_nNclCgcClis) + "," + ;
                " nlnendcobs = " + FormatarNumeroSQL(THIS.this_nNlnEndCobs) + "," + ;
                " nclendcobs = " + FormatarNumeroSQL(THIS.this_nNclEndCobs) + "," + ;
                " nlnbaicobs = " + FormatarNumeroSQL(THIS.this_nNlnBaiCobs) + "," + ;
                " nclbaicobs = " + FormatarNumeroSQL(THIS.this_nNclBaiCobs) + "," + ;
                " nlncidcobs = " + FormatarNumeroSQL(THIS.this_nNlnCidCobs) + "," + ;
                " nclcidcobs = " + FormatarNumeroSQL(THIS.this_nNclCidCobs) + "," + ;
                " nlnestcobs = " + FormatarNumeroSQL(THIS.this_nNlnEstCobs) + "," + ;
                " nclestcobs = " + FormatarNumeroSQL(THIS.this_nNclEstCobs) + "," + ;
                " nlncepcobs = " + FormatarNumeroSQL(THIS.this_nNlnCepCobs) + "," + ;
                " nclcepcobs = " + FormatarNumeroSQL(THIS.this_nNclCepCobs) + "," + ;
                " cnomeimps = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCNomeImps), 128)) + "," + ;
                " cfontepdrs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCFontePdrs), 128)) + "," + ;
                " ntamfontes = " + FormatarNumeroSQL(THIS.this_nNTamFontes) + "," + ;
                " ctamfolha = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCTamFolha), 50)) + ;
                " WHERE fpags = " + EscaparSQL(ALLTRIM(THIS.this_cFPags))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui configura??o de boleto bancario
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SIGCNFBL WHERE fpags = " + EscaparSQL(ALLTRIM(THIS.this_cFPags))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
            IF USED("cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

