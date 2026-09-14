# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 184: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 207: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 231: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 255: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 279: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 314: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 400: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 423: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormImp.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2342 linhas total):

*-- Linhas 79 a 104:
79:     PROTECTED PROCEDURE ConfigurarPageFrame()
80:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
81:         WITH THIS.pgf_4c_Paginas
82:             .Top       = -29
83:             .Left      = 0
84:             .Width     = THIS.Width
85:             .Height    = THIS.Height + 29
86:             .PageCount = 2
87:             .Tabs      = .F.
88:             .TabStop   = .F.
89:             .Visible   = .T.
90:         ENDWITH
91: 
92:         WITH THIS.pgf_4c_Paginas.Page1
93:             .Caption   = "Lista"
94:             .BackColor = RGB(255, 255, 255)
95:             .Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
96:         ENDWITH
97: 
98:         WITH THIS.pgf_4c_Paginas.Page2
99:             .Caption   = "Dados"
100:             .BackColor = RGB(255, 255, 255)
101:             .Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
102:         ENDWITH
103: 
104:         THIS.ConfigurarPaginaLista()

*-- Linhas 116 a 152:
116:         *-- Cabecalho cinza com titulo
117:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
118:         WITH loc_oPagina.cnt_4c_Cabecalho
119:             .Top         = 2
120:             .Left        = 0
121:             .Width       = THIS.Width
122:             .Height      = 80
123:             .BackColor   = RGB(100, 100, 100)
124:             .BorderWidth = 0
125:             .Visible     = .T.
126: 
127:             .AddObject("lbl_4c_Sombra", "Label")
128:             WITH .lbl_4c_Sombra
129:                 .Caption   = THIS.Caption
130:                 .Top       = 15
131:                 .Left      = 10
132:                 .Width     = THIS.Width
133:                 .Height    = 40
134:                 .FontName  = "Tahoma"
135:                 .FontSize  = 16
136:                 .FontBold  = .T.
137:                 .ForeColor = RGB(0, 0, 0)
138:                 .BackStyle = 0
139:                 .AutoSize  = .F.
140:                 .Visible   = .T.
141:             ENDWITH
142: 
143:             .AddObject("lbl_4c_Titulo", "Label")
144:             WITH .lbl_4c_Titulo
145:                 .Caption   = THIS.Caption
146:                 .Top       = 12
147:                 .Left      = 8
148:                 .Width     = THIS.Width
149:                 .Height    = 46
150:                 .FontName  = "Tahoma"
151:                 .FontSize  = 16
152:                 .FontBold  = .T.

*-- Linhas 160 a 285:
160:         *-- Container botoes CRUD (lado direito, canonico)
161:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
162:         WITH loc_oPagina.cnt_4c_Botoes
163:             .Top         = 29
164:             .Left        = 542
165:             .Width       = 390
166:             .Height      = 85
167:             .BackStyle   = 1
168:             .BackColor   = RGB(53, 53, 53)
169:             .BorderWidth = 0
170:             .Visible     = .T.
171: 
172:             *-- Incluir
173:             .AddObject("cmd_4c_Incluir", "CommandButton")
174:             WITH .cmd_4c_Incluir
175:                 .Caption         = "Incluir"
176:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
177:                 .PicturePosition = 13
178:                 .Top    = 5
179:                 .Left   =  542
180:                 .Width  = 75
181:                 .Height = 75
182:                 .BackColor   = RGB(255, 255, 255)
183:                 .ForeColor   = RGB(90, 90, 90)
184:                 .FontName    = "Comic Sans MS"
185:                 .FontSize    = 8
186:                 .FontBold    = .T.
187:                 .FontItalic  = .T.
188:                 .SpecialEffect = 0
189:                 .MousePointer  = 15
190:                 .WordWrap    = .T.
191:                 .AutoSize    = .F.
192:                 .Visible     = .T.
193:             ENDWITH
194: 
195:             *-- Visualizar
196:             .AddObject("cmd_4c_Visualizar", "CommandButton")
197:             WITH .cmd_4c_Visualizar
198:                 .Caption         = "Visualizar"
199:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
200:                 .PicturePosition = 13
201:                 .Top    = 5
202:                 .Left   =  542
203:                 .Width  = 75
204:                 .Height = 75
205:                 .BackColor   = RGB(255, 255, 255)
206:                 .ForeColor   = RGB(90, 90, 90)
207:                 .FontName    = "Comic Sans MS"
208:                 .FontSize    = 8
209:                 .FontBold    = .T.
210:                 .FontItalic  = .T.
211:                 .Themes      = .F.
212:                 .SpecialEffect = 0
213:                 .MousePointer  = 15
214:                 .WordWrap    = .T.
215:                 .AutoSize    = .F.
216:                 .Visible     = .T.
217:             ENDWITH
218: 
219:             *-- Alterar
220:             .AddObject("cmd_4c_Alterar", "CommandButton")
221:             WITH .cmd_4c_Alterar
222:                 .Caption         = "Alterar"
223:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
224:                 .PicturePosition = 13
225:                 .Top    = 5
226:                 .Left   =  542
227:                 .Width  = 75
228:                 .Height = 75
229:                 .BackColor   = RGB(255, 255, 255)
230:                 .ForeColor   = RGB(90, 90, 90)
231:                 .FontName    = "Comic Sans MS"
232:                 .FontSize    = 8
233:                 .FontBold    = .T.
234:                 .FontItalic  = .T.
235:                 .Themes      = .F.
236:                 .SpecialEffect = 0
237:                 .MousePointer  = 15
238:                 .WordWrap    = .T.
239:                 .AutoSize    = .F.
240:                 .Visible     = .T.
241:             ENDWITH
242: 
243:             *-- Excluir
244:             .AddObject("cmd_4c_Excluir", "CommandButton")
245:             WITH .cmd_4c_Excluir
246:                 .Caption         = "Excluir"
247:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
248:                 .PicturePosition = 13
249:                 .Top    = 5
250:                 .Left   =  542
251:                 .Width  = 75
252:                 .Height = 75
253:                 .BackColor   = RGB(255, 255, 255)
254:                 .ForeColor   = RGB(90, 90, 90)
255:                 .FontName    = "Comic Sans MS"
256:                 .FontSize    = 8
257:                 .FontBold    = .T.
258:                 .FontItalic  = .T.
259:                 .Themes      = .F.
260:                 .SpecialEffect = 0
261:                 .MousePointer  = 15
262:                 .WordWrap    = .T.
263:                 .AutoSize    = .F.
264:                 .Visible     = .T.
265:             ENDWITH
266: 
267:             *-- Buscar
268:             .AddObject("cmd_4c_Buscar", "CommandButton")
269:             WITH .cmd_4c_Buscar
270:                 .Caption         = "Buscar"
271:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
272:                 .PicturePosition = 13
273:                 .Top    = 5
274:                 .Left   =  542
275:                 .Width  = 75
276:                 .Height = 75
277:                 .BackColor   = RGB(255, 255, 255)
278:                 .ForeColor   = RGB(90, 90, 90)
279:                 .FontName    = "Comic Sans MS"
280:                 .FontSize    = 8
281:                 .FontBold    = .T.
282:                 .FontItalic  = .T.
283:                 .Themes      = .F.
284:                 .SpecialEffect = 0
285:                 .MousePointer  = 15

*-- Linhas 292 a 320:
292:         *-- Encerrar (posicao canonica - CLAUDE.md regra #10 prevalece sobre legado)
293:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
294:         WITH loc_oPagina.cnt_4c_Saida
295:             .Top         = 29
296:             .Left        = 917
297:             .Width       = 90
298:             .Height      = 85
299:             .BackStyle   = 0
300:             .BorderWidth = 0
301:             .Visible     = .T.
302: 
303:             .AddObject("cmd_4c_Encerrar", "CommandButton")
304:             WITH .cmd_4c_Encerrar
305:                 .Caption         = "Encerrar"
306:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
307:                 .PicturePosition = 13
308:                 .Top    = 5
309:                 .Left   = 917
310:                 .Width  = 90
311:                 .Height = 75
312:                 .BackColor   = RGB(255, 255, 255)
313:                 .ForeColor   = RGB(90, 90, 90)
314:                 .FontName    = "Comic Sans MS"
315:                 .FontSize    = 8
316:                 .FontBold    = .T.
317:                 .FontItalic  = .T.
318:                 .SpecialEffect = 0
319:                 .MousePointer  = 15
320:                 .WordWrap    = .T.

*-- Linhas 329 a 338:
329:         loc_oPagina.grd_4c_Lista.ColumnCount  = 2
330: 
331:         WITH loc_oPagina.grd_4c_Lista
332:             .Top              = 117
333:             .Left             = 26
334:             .Width            = 890
335:             .Height           = 498
336:             .FontName         = "Tahoma"
337:             .FontSize         = 8
338:             .RowHeight        = 16

*-- Linhas 349 a 369:
349:             .Visible          = .T.
350: 
351:             .Column1.Width           = 280
352:             .Column1.Header1.Caption = "Impressoras"
353:             .Column2.Width           = 130
354:             .Column2.Header1.Caption = "M" + CHR(225) + "ximo de Colunas"
355:         ENDWITH
356: 
357:         *-- BINDEVENTs (metodos PUBLIC nao PROTECTED - CLAUDE.md regra)
358:         loc_oCnt = loc_oPagina.cnt_4c_Botoes
359:         BINDEVENT(loc_oCnt.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
360:         BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
361:         BINDEVENT(loc_oCnt.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
362:         BINDEVENT(loc_oCnt.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
363:         BINDEVENT(loc_oCnt.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
364:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
365: 
366:         THIS.TornarControlesVisiveis(loc_oPagina)
367:     ENDPROC
368: 
369:     *==========================================================================

*-- Linhas 378 a 468:
378:         *-- Top = 4 (legado) + 29 (compensacao outer PF) = 33
379:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
380:         WITH loc_oPagina.cnt_4c_Salva
381:             .Top         = 33
382:             .Left        = 842
383:             .Width       = 160
384:             .Height      = 85
385:             .BackStyle   = 0
386:             .Visible     = .T.
387: 
388:             *-- Confirmar (Salva no legado)
389:             .AddObject("cmd_4c_Confirmar", "CommandButton")
390:             WITH .cmd_4c_Confirmar
391:                 .Caption         = "Confirmar"
392:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
393:                 .PicturePosition = 13
394:                 .Top    = 5
395:                 .Left   = 5
396:                 .Width  = 75
397:                 .Height = 75
398:                 .BackColor   = RGB(255, 255, 255)
399:                 .ForeColor   = RGB(90, 90, 90)
400:                 .FontName    = "Comic Sans MS"
401:                 .FontSize    = 8
402:                 .FontBold    = .T.
403:                 .FontItalic  = .T.
404:                 .SpecialEffect = 0
405:                 .MousePointer  = 15
406:                 .WordWrap    = .T.
407:                 .AutoSize    = .F.
408:                 .Visible     = .T.
409:             ENDWITH
410: 
411:             *-- Cancelar
412:             .AddObject("cmd_4c_Cancelar", "CommandButton")
413:             WITH .cmd_4c_Cancelar
414:                 .Caption         = "Encerrar"
415:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
416:                 .PicturePosition = 13
417:                 .Top    = 5
418:                 .Left   = 80
419:                 .Width  = 75
420:                 .Height = 75
421:                 .BackColor   = RGB(255, 255, 255)
422:                 .ForeColor   = RGB(90, 90, 90)
423:                 .FontName    = "Comic Sans MS"
424:                 .FontSize    = 8
425:                 .FontBold    = .T.
426:                 .FontItalic  = .T.
427:                 .Themes      = .F.
428:                 .SpecialEffect = 0
429:                 .MousePointer  = 15
430:                 .WordWrap    = .T.
431:                 .AutoSize    = .F.
432:                 .Visible     = .T.
433:             ENDWITH
434:         ENDWITH
435: 
436:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
437:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
438: 
439:         *-- Inner PageFrame (pgfDados no legado)
440:         *-- Top = 123 (legado) + 29 (compensacao outer PF) = 152
441:         *-- Tabs = .T.: abas visiveis para usuario alternar entre Dados/Cheques
442:         loc_oPagina.AddObject("pgf_4c_Dados", "PageFrame")
443:         WITH loc_oPagina.pgf_4c_Dados
444:             .Top       = 152
445:             .Left      = 29
446:             .Width     = 741
447:             .Height    = 464
448:             .PageCount = 2
449:             .Tabs      = .T.
450:             .Visible   = .T.
451:         ENDWITH
452: 
453:         WITH loc_oPagina.pgf_4c_Dados.Page1
454:             .Caption   = "Dados Principais"
455:             .BackColor = RGB(255, 255, 255)
456:             .ForeColor = RGB(90, 90, 90)
457:             .FontName  = "Tahoma"
458:             .FontSize  = 8
459:         ENDWITH
460: 
461:         *-- Pg2 comeca desabilitada: so habilita quando chkChqf = 1
462:         WITH loc_oPagina.pgf_4c_Dados.Page2
463:             .Caption   = "Cheques em Formul" + CHR(225) + "rio Cont" + CHR(237) + "nuo"
464:             .BackColor = RGB(255, 255, 255)
465:             .ForeColor = RGB(90, 90, 90)
466:             .FontName  = "Tahoma"
467:             .FontSize  = 8
468:             .Enabled   = .F.

*-- Linhas 478 a 548:
478:         LOCAL loc_oPg1
479:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
480: 
481:         *-- 1/2. lbl_4c_Impres + txt_4c_Impres
482:         loc_oPg1.AddObject("lbl_4c_Impres", "Label")
483:         WITH loc_oPg1.lbl_4c_Impres
484:             .Caption   = "Impressora :"
485:             .Top       = 12
486:             .Left      = 83
487:             .Width     = 63
488:             .AutoSize  = .F.
489:             .FontName  = "Tahoma"
490:             .FontSize  = 8
491:             .BackStyle = 0
492:             .ForeColor = RGB(90, 90, 90)
493:             .Visible   = .T.
494:         ENDWITH
495: 
496:         loc_oPg1.AddObject("txt_4c_Impres", "TextBox")
497:         WITH loc_oPg1.txt_4c_Impres
498:             .Top           = 9
499:             .Left          = 151
500:             .Width         = 280
501:             .Height        = 23
502:             .MaxLength     = 30
503:             .SpecialEffect = 1
504:             .FontName      = "Tahoma"
505:             .FontSize      = 8
506:             .Value         = ""
507:             .Visible       = .T.
508:         ENDWITH
509: 
510:         *-- 3/4. lbl_4c_Titulos + txt_4c_Titulos
511:         loc_oPg1.AddObject("lbl_4c_Titulos", "Label")
512:         WITH loc_oPg1.lbl_4c_Titulos
513:             .Caption   = "T" + CHR(237) + "tulo :"
514:             .Top       = 37
515:             .Left      = 111
516:             .Width     = 35
517:             .AutoSize  = .F.
518:             .FontName  = "Tahoma"
519:             .FontSize  = 8
520:             .BackStyle = 0
521:             .ForeColor = RGB(90, 90, 90)
522:             .Visible   = .T.
523:         ENDWITH
524: 
525:         loc_oPg1.AddObject("txt_4c_Titulos", "TextBox")
526:         WITH loc_oPg1.txt_4c_Titulos
527:             .Top           = 34
528:             .Left          = 151
529:             .Width         = 26
530:             .Height        = 23
531:             .SpecialEffect = 1
532:             .FontName      = "Tahoma"
533:             .FontSize      = 8
534:             .Value         = 0
535:             .Visible       = .T.
536:         ENDWITH
537: 
538:         *-- 5. chk_4c_Chqf (Cheque Formulario Continuo)
539:         loc_oPg1.AddObject("chk_4c_Chqf", "CheckBox")
540:         WITH loc_oPg1.chk_4c_Chqf
541:             .Caption   = "Cheque Form. Cont" + CHR(237) + "nuo"
542:             .Top       = 37
543:             .Left      = 207
544:             .Width     = 164
545:             .Height    = 16
546:             .AutoSize  = .F.
547:             .Alignment = 0
548:             .FontName  = "Tahoma"

*-- Linhas 554 a 669:
554:         ENDWITH
555:         BINDEVENT(loc_oPg1.chk_4c_Chqf, "Click", THIS, "ChkChqfChanged")
556: 
557:         *-- 6/7. lbl_4c_Rates + txt_4c_Rates
558:         loc_oPg1.AddObject("lbl_4c_Rates", "Label")
559:         WITH loc_oPg1.lbl_4c_Rates
560:             .Caption   = "Rate :"
561:             .Top       = 63
562:             .Left      = 114
563:             .Width     = 32
564:             .AutoSize  = .F.
565:             .FontName  = "Tahoma"
566:             .FontSize  = 8
567:             .BackStyle = 0
568:             .ForeColor = RGB(90, 90, 90)
569:             .Visible   = .T.
570:         ENDWITH
571: 
572:         loc_oPg1.AddObject("txt_4c_Rates", "TextBox")
573:         WITH loc_oPg1.txt_4c_Rates
574:             .Top           = 59
575:             .Left          = 151
576:             .Width         = 51
577:             .Height        = 23
578:             .SpecialEffect = 1
579:             .FontName      = "Tahoma"
580:             .FontSize      = 8
581:             .Value         = 0
582:             .Visible       = .T.
583:         ENDWITH
584: 
585:         *-- 8. chk_4c_Exps (Expandido)
586:         loc_oPg1.AddObject("chk_4c_Exps", "CheckBox")
587:         WITH loc_oPg1.chk_4c_Exps
588:             .Caption   = "Expandido "
589:             .Top       = 62
590:             .Left      = 207
591:             .Width     = 95
592:             .Height    = 16
593:             .AutoSize  = .F.
594:             .Alignment = 0
595:             .FontName  = "Tahoma"
596:             .FontSize  = 8
597:             .BackStyle = 0
598:             .ForeColor = RGB(90, 90, 90)
599:             .Value     = 0
600:             .Visible   = .T.
601:         ENDWITH
602: 
603:         *-- 9/10. lbl_4c_Barras + txt_4c_Barras
604:         loc_oPg1.AddObject("lbl_4c_Barras", "Label")
605:         WITH loc_oPg1.lbl_4c_Barras
606:             .Caption   = "Barra :"
607:             .Top       = 88
608:             .Left      = 111
609:             .Width     = 35
610:             .AutoSize  = .F.
611:             .FontName  = "Tahoma"
612:             .FontSize  = 8
613:             .BackStyle = 0
614:             .ForeColor = RGB(90, 90, 90)
615:             .Visible   = .T.
616:         ENDWITH
617: 
618:         loc_oPg1.AddObject("txt_4c_Barras", "TextBox")
619:         WITH loc_oPg1.txt_4c_Barras
620:             .Top           = 84
621:             .Left          = 151
622:             .Width         = 26
623:             .Height        = 23
624:             .SpecialEffect = 1
625:             .FontName      = "Tahoma"
626:             .FontSize      = 8
627:             .Value         = 0
628:             .Visible       = .T.
629:         ENDWITH
630: 
631:         *-- 11/12. lbl_4c_Maxcols + txt_4c_Maxcols
632:         loc_oPg1.AddObject("lbl_4c_Maxcols", "Label")
633:         WITH loc_oPg1.lbl_4c_Maxcols
634:             .Caption   = "M" + CHR(225) + "ximo de Colunas :"
635:             .Top       = 113
636:             .Left      = 45
637:             .Width     = 101
638:             .AutoSize  = .F.
639:             .FontName  = "Tahoma"
640:             .FontSize  = 8
641:             .BackStyle = 0
642:             .ForeColor = RGB(90, 90, 90)
643:             .Visible   = .T.
644:         ENDWITH
645: 
646:         loc_oPg1.AddObject("txt_4c_Maxcols", "TextBox")
647:         WITH loc_oPg1.txt_4c_Maxcols
648:             .Top           = 109
649:             .Left          = 151
650:             .Width         = 26
651:             .Height        = 23
652:             .SpecialEffect = 1
653:             .FontName      = "Tahoma"
654:             .FontSize      = 8
655:             .Value         = 0
656:             .Visible       = .T.
657:         ENDWITH
658: 
659:         *-- 13/14. lbl_4c_Tipos + cbo_4c_Tipos (Tipo de Grafico - value list)
660:         loc_oPg1.AddObject("lbl_4c_Tipos", "Label")
661:         WITH loc_oPg1.lbl_4c_Tipos
662:             .Caption   = "Tipo de Gr" + CHR(225) + "fico :"
663:             .Top       = 138
664:             .Left      = 65
665:             .Width     = 81
666:             .Height    = 15
667:             .AutoSize  = .F.
668:             .FontName  = "Tahoma"
669:             .FontSize  = 8

*-- Linhas 677 a 719:
677:             .RowSourceType = 1
678:             .RowSource     = "Epson Esc K,Epson Esc * m n,Mecaf"
679:             .Style         = 2
680:             .Top           = 134
681:             .Left          = 151
682:             .Width         = 155
683:             .Height        = 23
684:             .SpecialEffect = 1
685:             .FontName      = "Tahoma"
686:             .FontSize      = 8
687:             .Value         = ""
688:             .Visible       = .T.
689:         ENDWITH
690: 
691:         *-- 15. chk_4c_Graficos
692:         loc_oPg1.AddObject("chk_4c_Graficos", "CheckBox")
693:         WITH loc_oPg1.chk_4c_Graficos
694:             .Caption   = "Gr" + CHR(225) + "ficos "
695:             .Top       = 137
696:             .Left      = 312
697:             .Width     = 63
698:             .Height    = 16
699:             .AutoSize  = .F.
700:             .Alignment = 0
701:             .FontName  = "Tahoma"
702:             .FontSize  = 8
703:             .BackStyle = 0
704:             .ForeColor = RGB(90, 90, 90)
705:             .Value     = 0
706:             .Visible   = .T.
707:         ENDWITH
708: 
709:         *-- 16. lbl_4c_TpImpres ("Tipo de Impressora")
710:         loc_oPg1.AddObject("lbl_4c_TpImpres", "Label")
711:         WITH loc_oPg1.lbl_4c_TpImpres
712:             .Caption   = "Tipo de Impressora : "
713:             .Top       = 164
714:             .Left      = 44
715:             .Width     = 102
716:             .AutoSize  = .F.
717:             .WordWrap  = .T.
718:             .FontName  = "Tahoma"
719:             .FontSize  = 8

*-- Linhas 728 a 793:
728:             .ButtonCount = 4
729:             .BackStyle   = 0
730:             .BorderStyle = 0
731:             .Top         = 158
732:             .Left        = 147
733:             .Width       = 317
734:             .Height      = 27
735:             .Value       = 1
736:             .Visible     = .T.
737:         ENDWITH
738:         WITH loc_oPg1.opt_4c_TpImpres.Buttons(1)
739:             .Caption   = "Boleto"
740:             .Left      = 5
741:             .Top       = 5
742:             .AutoSize  = .T.
743:             .FontName  = "Tahoma"
744:             .FontSize  = 8
745:             .BackStyle = 0
746:             .ForeColor = RGB(90, 90, 90)
747:         ENDWITH
748:         WITH loc_oPg1.opt_4c_TpImpres.Buttons(2)
749:             .Caption   = "Etiqueta"
750:             .Left      = 66
751:             .Top       = 5
752:             .AutoSize  = .T.
753:             .FontName  = "Tahoma"
754:             .FontSize  = 8
755:             .BackStyle = 0
756:             .ForeColor = RGB(90, 90, 90)
757:         ENDWITH
758:         WITH loc_oPg1.opt_4c_TpImpres.Buttons(3)
759:             .Caption   = "Boleto Zebra"
760:             .Left      = 145
761:             .Top       = 5
762:             .Height    = 15
763:             .Width     = 79
764:             .AutoSize  = .T.
765:             .FontName  = "Tahoma"
766:             .FontSize  = 8
767:             .BackStyle = 0
768:             .ForeColor = RGB(90, 90, 90)
769:         ENDWITH
770:         WITH loc_oPg1.opt_4c_TpImpres.Buttons(4)
771:             .Caption   = "Padr" + CHR(227) + "o"
772:             .Left      = 246
773:             .Top       = 5
774:             .Height    = 15
775:             .Width     = 61
776:             .FontName  = "Tahoma"
777:             .FontSize  = 8
778:             .BackStyle = 0
779:             .ForeColor = RGB(90, 90, 90)
780:             .Themes    = .F.
781:         ENDWITH
782: 
783:         *-- 18. lbl_4c_Etiquetas ("Etiquetas:")
784:         loc_oPg1.AddObject("lbl_4c_Etiquetas", "Label")
785:         WITH loc_oPg1.lbl_4c_Etiquetas
786:             .Caption   = "Etiquetas :"
787:             .Top       = 190
788:             .Left      = 92
789:             .AutoSize  = .T.
790:             .FontName  = "Tahoma"
791:             .FontSize  = 8
792:             .BackStyle = 0
793:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 801 a 854:
801:             .AutoSize    = .F.
802:             .BackStyle   = 0
803:             .BorderStyle = 0
804:             .Top         = 184
805:             .Left        = 147
806:             .Width       = 244
807:             .Height      = 27
808:             .Value       = 1
809:             .Visible     = .T.
810:         ENDWITH
811:         WITH loc_oPg1.opt_4c_ImpEtis.Buttons(1)
812:             .Caption   = "Allegro"
813:             .Left      = 5
814:             .Top       = 5
815:             .AutoSize  = .T.
816:             .FontName  = "Tahoma"
817:             .FontSize  = 8
818:             .BackStyle = 0
819:             .ForeColor = RGB(90, 90, 90)
820:         ENDWITH
821:         WITH loc_oPg1.opt_4c_ImpEtis.Buttons(2)
822:             .Caption   = "Zebra ZPL"
823:             .Left      = 66
824:             .Top       = 5
825:             .AutoSize  = .T.
826:             .FontName  = "Tahoma"
827:             .FontSize  = 8
828:             .BackStyle = 0
829:             .ForeColor = RGB(90, 90, 90)
830:         ENDWITH
831:         WITH loc_oPg1.opt_4c_ImpEtis.Buttons(3)
832:             .Caption   = "Zebra EPL"
833:             .Left      = 145
834:             .Top       = 5
835:             .Height    = 15
836:             .Width     = 66
837:             .AutoSize  = .T.
838:             .FontName  = "Tahoma"
839:             .FontSize  = 8
840:             .BackStyle = 0
841:             .ForeColor = RGB(90, 90, 90)
842:         ENDWITH
843: 
844:         *-- 20/21. lbl_4c_Cetiquetas + cbo_4c_Cetiquetas (cursor crSigCdTpe)
845:         loc_oPg1.AddObject("lbl_4c_Cetiquetas", "Label")
846:         WITH loc_oPg1.lbl_4c_Cetiquetas
847:             .Caption   = "Etiqueta Padr" + CHR(227) + "o :"
848:             .Top       = 216
849:             .Left      = 60
850:             .Width     = 86
851:             .Height    = 15
852:             .AutoSize  = .F.
853:             .FontName  = "Tahoma"
854:             .FontSize  = 8

*-- Linhas 867 a 891:
867:             .FirstElement     = 1
868:             .BoundTo          = .T.
869:             .Style            = 2
870:             .Top              = 212
871:             .Left             = 151
872:             .Width            = 155
873:             .Height           = 23
874:             .SpecialEffect    = 1
875:             .FontName         = "Tahoma"
876:             .FontSize         = 8
877:             .Value            = ""
878:             .Visible          = .T.
879:         ENDWITH
880: 
881:         *-- 22. lbl_4c_ComandoPara ("Comando Para :" - cabecalho da secao abaixo, Top=245)
882:         loc_oPg1.AddObject("lbl_4c_ComandoPara", "Label")
883:         WITH loc_oPg1.lbl_4c_ComandoPara
884:             .Caption   = "Comando Para :"
885:             .Top       = 245
886:             .Left      = 8
887:             .Width     = 90
888:             .AutoSize  = .T.
889:             .FontName  = "Tahoma"
890:             .FontSize  = 8
891:             .FontBold  = .T.

*-- Linhas 897 a 1135:
897:         *-- 23. lin_4c_Linha1 (separador visual, Top=262)
898:         loc_oPg1.AddObject("lin_4c_Linha1", "Line")
899:         WITH loc_oPg1.lin_4c_Linha1
900:             .Top         = 262
901:             .Left        = 8
902:             .Width       = 720
903:             .Height      = 0
904:             .BorderWidth = 2
905:             .Visible     = .T.
906:         ENDWITH
907: 
908:         *-- 24. lbl_4c_Expds + edt_4c_Expds (Desativar Negrito, Top=270, col esquerda)
909:         loc_oPg1.AddObject("lbl_4c_Expds", "Label")
910:         WITH loc_oPg1.lbl_4c_Expds
911:             .Caption   = "Desativar Negrito :"
912:             .Top       = 270
913:             .Left      = 56
914:             .Width     = 93
915:             .AutoSize  = .T.
916:             .FontName  = "Tahoma"
917:             .FontSize  = 8
918:             .BackStyle = 0
919:             .ForeColor = RGB(90, 90, 90)
920:             .Visible   = .T.
921:         ENDWITH
922: 
923:         loc_oPg1.AddObject("edt_4c_Expds", "EditBox")
924:         WITH loc_oPg1.edt_4c_Expds
925:             .Top           = 270
926:             .Left          = 151
927:             .Width         = 220
928:             .Height        = 35
929:             .SpecialEffect = 1
930:             .FontName      = "Tahoma"
931:             .FontSize      = 8
932:             .Value         = ""
933:             .Visible       = .T.
934:         ENDWITH
935: 
936:         *-- 25. lbl_4c_Barcmds + edt_4c_Barcmds (Codigo de Barras, Top=270, col direita)
937:         loc_oPg1.AddObject("lbl_4c_Barcmds", "Label")
938:         WITH loc_oPg1.lbl_4c_Barcmds
939:             .Caption   = "C" + CHR(243) + "digo de Barras :"
940:             .Top       = 270
941:             .Left      = 415
942:             .Width     = 91
943:             .AutoSize  = .T.
944:             .FontName  = "Tahoma"
945:             .FontSize  = 8
946:             .BackStyle = 0
947:             .ForeColor = RGB(90, 90, 90)
948:             .Visible   = .T.
949:         ENDWITH
950: 
951:         loc_oPg1.AddObject("edt_4c_Barcmds", "EditBox")
952:         WITH loc_oPg1.edt_4c_Barcmds
953:             .Top           = 270
954:             .Left          = 509
955:             .Width         = 220
956:             .Height        = 49
957:             .SpecialEffect = 1
958:             .FontName      = "Tahoma"
959:             .FontSize      = 8
960:             .Value         = ""
961:             .Visible       = .T.
962:         ENDWITH
963: 
964:         *-- 26. lbl_4c_Expas + edt_4c_Expas (Ativar Negrito, Top=308)
965:         loc_oPg1.AddObject("lbl_4c_Expas", "Label")
966:         WITH loc_oPg1.lbl_4c_Expas
967:             .Caption   = "Ativar Negrito :"
968:             .Top       = 308
969:             .Left      = 73
970:             .Width     = 76
971:             .AutoSize  = .T.
972:             .FontName  = "Tahoma"
973:             .FontSize  = 8
974:             .BackStyle = 0
975:             .ForeColor = RGB(90, 90, 90)
976:             .Visible   = .T.
977:         ENDWITH
978: 
979:         loc_oPg1.AddObject("edt_4c_Expas", "EditBox")
980:         WITH loc_oPg1.edt_4c_Expas
981:             .Top           = 308
982:             .Left          = 151
983:             .Width         = 220
984:             .Height        = 35
985:             .SpecialEffect = 1
986:             .FontName      = "Tahoma"
987:             .FontSize      = 8
988:             .Value         = ""
989:             .Visible       = .T.
990:         ENDWITH
991: 
992:         *-- 27. lbl_4c_Fontes + edt_4c_Fontes (Inicializacao, Top=322, col direita)
993:         loc_oPg1.AddObject("lbl_4c_Fontes", "Label")
994:         WITH loc_oPg1.lbl_4c_Fontes
995:             .Caption   = "Inicializa" + CHR(231) + CHR(227) + "o :"
996:             .Top       = 322
997:             .Left      = 440
998:             .Width     = 66
999:             .AutoSize  = .T.
1000:             .FontName  = "Tahoma"
1001:             .FontSize  = 8
1002:             .BackStyle = 0
1003:             .ForeColor = RGB(90, 90, 90)
1004:             .Visible   = .T.
1005:         ENDWITH
1006: 
1007:         loc_oPg1.AddObject("edt_4c_Fontes", "EditBox")
1008:         WITH loc_oPg1.edt_4c_Fontes
1009:             .Top           = 322
1010:             .Left          = 509
1011:             .Width         = 220
1012:             .Height        = 49
1013:             .SpecialEffect = 1
1014:             .FontName      = "Tahoma"
1015:             .FontSize      = 8
1016:             .Value         = ""
1017:             .Visible       = .T.
1018:         ENDWITH
1019: 
1020:         *-- 28. lbl_4c_FontePeq + edt_4c_Fonte2s (Ativar Fonte Pequena, Top=348)
1021:         loc_oPg1.AddObject("lbl_4c_FontePeq", "Label")
1022:         WITH loc_oPg1.lbl_4c_FontePeq
1023:             .Caption   = "Ativar Fonte Pequena :"
1024:             .Top       = 348
1025:             .Left      = 35
1026:             .Width     = 114
1027:             .AutoSize  = .T.
1028:             .FontName  = "Tahoma"
1029:             .FontSize  = 8
1030:             .BackStyle = 0
1031:             .ForeColor = RGB(90, 90, 90)
1032:             .Visible   = .T.
1033:         ENDWITH
1034: 
1035:         loc_oPg1.AddObject("edt_4c_Fonte2s", "EditBox")
1036:         WITH loc_oPg1.edt_4c_Fonte2s
1037:             .Top           = 348
1038:             .Left          = 151
1039:             .Width         = 220
1040:             .Height        = 35
1041:             .SpecialEffect = 1
1042:             .FontName      = "Tahoma"
1043:             .FontSize      = 8
1044:             .Value         = ""
1045:             .Visible       = .T.
1046:         ENDWITH
1047: 
1048:         *-- 29. shp_4c_Ajuste (shape contorno area ajustes etiqueta, col direita Top=373)
1049:         loc_oPg1.AddObject("shp_4c_Ajuste", "Shape")
1050:         WITH loc_oPg1.shp_4c_Ajuste
1051:             .Top       = 373
1052:             .Left      = 509
1053:             .Width     = 220
1054:             .Height    = 49
1055:             .BackStyle = 0
1056:             .Visible   = .T.
1057:         ENDWITH
1058: 
1059:         *-- 30. lbl_4c_Ajustes + labels Vertical/Horizontal/Densidade/Velocidade
1060:         loc_oPg1.AddObject("lbl_4c_Ajustes", "Label")
1061:         WITH loc_oPg1.lbl_4c_Ajustes
1062:             .Caption   = "Ajustes :"
1063:             .Top       = 373
1064:             .Left      = 461
1065:             .AutoSize  = .T.
1066:             .FontName  = "Tahoma"
1067:             .FontSize  = 8
1068:             .FontBold  = .F.
1069:             .BackStyle = 0
1070:             .ForeColor = RGB(90, 90, 90)
1071:             .Visible   = .T.
1072:         ENDWITH
1073: 
1074:         loc_oPg1.AddObject("lbl_4c_SayVert", "Label")
1075:         WITH loc_oPg1.lbl_4c_SayVert
1076:             .Caption   = "Vertical"
1077:             .Top       = 380
1078:             .Left      = 512
1079:             .AutoSize  = .T.
1080:             .FontName  = "Tahoma"
1081:             .FontSize  = 8
1082:             .BackStyle = 0
1083:             .ForeColor = RGB(90, 90, 90)
1084:             .Visible   = .T.
1085:         ENDWITH
1086: 
1087:         loc_oPg1.AddObject("lbl_4c_SayHoriz", "Label")
1088:         WITH loc_oPg1.lbl_4c_SayHoriz
1089:             .Caption   = "Horizontal"
1090:             .Top       = 380
1091:             .Left      = 556
1092:             .AutoSize  = .T.
1093:             .FontName  = "Tahoma"
1094:             .FontSize  = 8
1095:             .BackStyle = 0
1096:             .ForeColor = RGB(90, 90, 90)
1097:             .Visible   = .T.
1098:         ENDWITH
1099: 
1100:         loc_oPg1.AddObject("lbl_4c_SayDens", "Label")
1101:         WITH loc_oPg1.lbl_4c_SayDens
1102:             .Caption   = "Densidade"
1103:             .Top       = 380
1104:             .Left      = 612
1105:             .AutoSize  = .T.
1106:             .FontName  = "Tahoma"
1107:             .FontSize  = 8
1108:             .BackStyle = 0
1109:             .ForeColor = RGB(90, 90, 90)
1110:             .Visible   = .T.
1111:         ENDWITH
1112: 
1113:         loc_oPg1.AddObject("lbl_4c_SayVelo", "Label")
1114:         WITH loc_oPg1.lbl_4c_SayVelo
1115:             .Caption   = "Velocidade"
1116:             .Top       = 379
1117:             .Left      = 673
1118:             .AutoSize  = .T.
1119:             .FontName  = "Tahoma"
1120:             .FontSize  = 8
1121:             .BackStyle = 0
1122:             .ForeColor = RGB(90, 90, 90)
1123:             .Visible   = .T.
1124:         ENDWITH
1125: 
1126:         *-- 31. spn_4c_AjVerts (TextBox c/ InputMask = Get_vert original, Top=392)
1127:         loc_oPg1.AddObject("spn_4c_AjVerts", "TextBox")
1128:         WITH loc_oPg1.spn_4c_AjVerts
1129:             .Top           = 392
1130:             .Left          = 516
1131:             .Width         = 31
1132:             .Height        = 23
1133:             .InputMask     = "999"
1134:             .SpecialEffect = 1
1135:             .FontName      = "Tahoma"

*-- Linhas 1142 a 1151:
1142:         *-- 32. spn_4c_AjHorzs (TextBox c/ InputMask = Get_horiz original, Top=392)
1143:         loc_oPg1.AddObject("spn_4c_AjHorzs", "TextBox")
1144:         WITH loc_oPg1.spn_4c_AjHorzs
1145:             .Top           = 392
1146:             .Left          = 564
1147:             .Width         = 37
1148:             .Height        = 23
1149:             .InputMask     = "9999"
1150:             .SpecialEffect = 1
1151:             .FontName      = "Tahoma"

*-- Linhas 1158 a 1167:
1158:         *-- 33. spn_4c_AjDens (Spinner densidade, range 10-20)
1159:         loc_oPg1.AddObject("spn_4c_AjDens", "Spinner")
1160:         WITH loc_oPg1.spn_4c_AjDens
1161:             .Top               = 391
1162:             .Left              = 612
1163:             .Width             = 45
1164:             .Height            = 26
1165:             .KeyboardHighValue = 20
1166:             .KeyboardLowValue  = 10
1167:             .SpinnerHighValue  = 20

*-- Linhas 1177 a 1186:
1177:         *-- 34. spn_4c_AjVelos (Spinner velocidade, range 1-3)
1178:         loc_oPg1.AddObject("spn_4c_AjVelos", "Spinner")
1179:         WITH loc_oPg1.spn_4c_AjVelos
1180:             .Top               = 391
1181:             .Left              = 673
1182:             .Width             = 49
1183:             .Height            = 26
1184:             .KeyboardHighValue = 3
1185:             .KeyboardLowValue  = 1
1186:             .SpinnerHighValue  = 3

*-- Linhas 1193 a 1219:
1193:             .Visible           = .T.
1194:         ENDWITH
1195: 
1196:         *-- 35. lbl_4c_Guilhotina + edt_4c_Fontemp1s (Aciona Guilhotina, Top=388)
1197:         loc_oPg1.AddObject("lbl_4c_Guilhotina", "Label")
1198:         WITH loc_oPg1.lbl_4c_Guilhotina
1199:             .Caption   = "Aciona Guilhotina :"
1200:             .Top       = 388
1201:             .Left      = 58
1202:             .Width     = 91
1203:             .AutoSize  = .T.
1204:             .FontName  = "Tahoma"
1205:             .FontSize  = 8
1206:             .BackStyle = 0
1207:             .ForeColor = RGB(90, 90, 90)
1208:             .Visible   = .T.
1209:         ENDWITH
1210: 
1211:         loc_oPg1.AddObject("edt_4c_Fontemp1s", "EditBox")
1212:         WITH loc_oPg1.edt_4c_Fontemp1s
1213:             .Top           = 388
1214:             .Left          = 151
1215:             .Width         = 220
1216:             .Height        = 35
1217:             .SpecialEffect = 1
1218:             .FontName      = "Tahoma"
1219:             .FontSize      = 8

*-- Linhas 1280 a 1306:
1280:         *======== COLUNA ESQUERDA ========
1281: 
1282:         *-- 1. Valor em Numeros: lbl + txt_4c_Nlivl1s + x + txt_4c_Nclvl1s
1283:         loc_oPg2.AddObject("lbl_4c_Valnums", "Label")
1284:         WITH loc_oPg2.lbl_4c_Valnums
1285:             .Caption   = "Valor em N" + CHR(250) + "meros"
1286:             .Top       = 78
1287:             .Left      = 184
1288:             .Width     = 80
1289:             .Height    = 13
1290:             .AutoSize  = .T.
1291:             .FontName  = "Tahoma"
1292:             .FontSize  = 7
1293:             .BackStyle = 0
1294:             .ForeColor = RGB(90, 90, 90)
1295:             .Visible   = .T.
1296:         ENDWITH
1297: 
1298:         loc_oPg2.AddObject("txt_4c_Nlivl1s", "TextBox")
1299:         WITH loc_oPg2.txt_4c_Nlivl1s
1300:             .Top           = 90
1301:             .Left          = 184
1302:             .Width         = 41
1303:             .Height        = 18
1304:             .BackStyle     = 0
1305:             .SpecialEffect = 1
1306:             .FontName      = "Tahoma"

*-- Linhas 1312 a 1338:
1312:             .Visible       = .T.
1313:         ENDWITH
1314: 
1315:         loc_oPg2.AddObject("lbl_4c_XValNum", "Label")
1316:         WITH loc_oPg2.lbl_4c_XValNum
1317:             .Caption   = "x"
1318:             .Top       = 92
1319:             .Left      = 228
1320:             .Width     = 6
1321:             .Height    = 13
1322:             .AutoSize  = .T.
1323:             .FontName  = "Tahoma"
1324:             .FontSize  = 7
1325:             .BackStyle = 0
1326:             .ForeColor = RGB(90, 90, 90)
1327:             .Visible   = .T.
1328:         ENDWITH
1329: 
1330:         loc_oPg2.AddObject("txt_4c_Nclvl1s", "TextBox")
1331:         WITH loc_oPg2.txt_4c_Nclvl1s
1332:             .Top           = 90
1333:             .Left          = 233
1334:             .Width         = 41
1335:             .Height        = 18
1336:             .BackStyle     = 0
1337:             .SpecialEffect = 1
1338:             .FontName      = "Tahoma"

*-- Linhas 1345 a 1371:
1345:         ENDWITH
1346: 
1347:         *-- 2. Valor por Extenso (1a Linha)
1348:         loc_oPg2.AddObject("lbl_4c_Valext1", "Label")
1349:         WITH loc_oPg2.lbl_4c_Valext1
1350:             .Caption   = "Valor por Extenso (1" + CHR(170) + " Linha)"
1351:             .Top       = 110
1352:             .Left      = 184
1353:             .Width     = 119
1354:             .Height    = 13
1355:             .AutoSize  = .T.
1356:             .FontName  = "Tahoma"
1357:             .FontSize  = 7
1358:             .BackStyle = 0
1359:             .ForeColor = RGB(90, 90, 90)
1360:             .Visible   = .T.
1361:         ENDWITH
1362: 
1363:         loc_oPg2.AddObject("txt_4c_Nlivext1s", "TextBox")
1364:         WITH loc_oPg2.txt_4c_Nlivext1s
1365:             .Top           = 121
1366:             .Left          = 184
1367:             .Width         = 41
1368:             .Height        = 18
1369:             .BackStyle     = 0
1370:             .SpecialEffect = 1
1371:             .FontName      = "Tahoma"

*-- Linhas 1377 a 1403:
1377:             .Visible       = .T.
1378:         ENDWITH
1379: 
1380:         loc_oPg2.AddObject("lbl_4c_XVExt1", "Label")
1381:         WITH loc_oPg2.lbl_4c_XVExt1
1382:             .Caption   = "x"
1383:             .Top       = 123
1384:             .Left      = 228
1385:             .Width     = 6
1386:             .Height    = 13
1387:             .AutoSize  = .T.
1388:             .FontName  = "Tahoma"
1389:             .FontSize  = 7
1390:             .BackStyle = 0
1391:             .ForeColor = RGB(90, 90, 90)
1392:             .Visible   = .T.
1393:         ENDWITH
1394: 
1395:         loc_oPg2.AddObject("txt_4c_Nclvext1s", "TextBox")
1396:         WITH loc_oPg2.txt_4c_Nclvext1s
1397:             .Top           = 121
1398:             .Left          = 233
1399:             .Width         = 41
1400:             .Height        = 18
1401:             .BackStyle     = 0
1402:             .SpecialEffect = 1
1403:             .FontName      = "Tahoma"

*-- Linhas 1410 a 1436:
1410:         ENDWITH
1411: 
1412:         *-- 3. Valor por Extenso (2a Linha)
1413:         loc_oPg2.AddObject("lbl_4c_Valext2", "Label")
1414:         WITH loc_oPg2.lbl_4c_Valext2
1415:             .Caption   = "Valor por Extenso (2" + CHR(170) + " Linha)"
1416:             .Top       = 144
1417:             .Left      = 184
1418:             .Width     = 119
1419:             .Height    = 13
1420:             .AutoSize  = .T.
1421:             .FontName  = "Tahoma"
1422:             .FontSize  = 7
1423:             .BackStyle = 0
1424:             .ForeColor = RGB(90, 90, 90)
1425:             .Visible   = .T.
1426:         ENDWITH
1427: 
1428:         loc_oPg2.AddObject("txt_4c_Nlivext2s", "TextBox")
1429:         WITH loc_oPg2.txt_4c_Nlivext2s
1430:             .Top           = 156
1431:             .Left          = 184
1432:             .Width         = 41
1433:             .Height        = 18
1434:             .BackStyle     = 0
1435:             .SpecialEffect = 1
1436:             .FontName      = "Tahoma"

*-- Linhas 1442 a 1468:
1442:             .Visible       = .T.
1443:         ENDWITH
1444: 
1445:         loc_oPg2.AddObject("lbl_4c_XVExt2", "Label")
1446:         WITH loc_oPg2.lbl_4c_XVExt2
1447:             .Caption   = "x"
1448:             .Top       = 158
1449:             .Left      = 228
1450:             .Width     = 6
1451:             .Height    = 13
1452:             .AutoSize  = .T.
1453:             .FontName  = "Tahoma"
1454:             .FontSize  = 7
1455:             .BackStyle = 0
1456:             .ForeColor = RGB(90, 90, 90)
1457:             .Visible   = .T.
1458:         ENDWITH
1459: 
1460:         loc_oPg2.AddObject("txt_4c_Nclvext2s", "TextBox")
1461:         WITH loc_oPg2.txt_4c_Nclvext2s
1462:             .Top           = 156
1463:             .Left          = 233
1464:             .Width         = 41
1465:             .Height        = 18
1466:             .BackStyle     = 0
1467:             .SpecialEffect = 1
1468:             .FontName      = "Tahoma"

*-- Linhas 1475 a 1501:
1475:         ENDWITH
1476: 
1477:         *-- 4. Favorecido
1478:         loc_oPg2.AddObject("lbl_4c_Favorecido", "Label")
1479:         WITH loc_oPg2.lbl_4c_Favorecido
1480:             .Caption   = "Favorecido"
1481:             .Top       = 180
1482:             .Left      = 184
1483:             .Width     = 48
1484:             .Height    = 13
1485:             .AutoSize  = .T.
1486:             .FontName  = "Tahoma"
1487:             .FontSize  = 7
1488:             .BackStyle = 0
1489:             .ForeColor = RGB(90, 90, 90)
1490:             .Visible   = .T.
1491:         ENDWITH
1492: 
1493:         loc_oPg2.AddObject("txt_4c_Nlinom1s", "TextBox")
1494:         WITH loc_oPg2.txt_4c_Nlinom1s
1495:             .Top           = 192
1496:             .Left          = 184
1497:             .Width         = 41
1498:             .Height        = 18
1499:             .BackStyle     = 0
1500:             .SpecialEffect = 1
1501:             .FontName      = "Tahoma"

*-- Linhas 1507 a 1533:
1507:             .Visible       = .T.
1508:         ENDWITH
1509: 
1510:         loc_oPg2.AddObject("lbl_4c_XFavor", "Label")
1511:         WITH loc_oPg2.lbl_4c_XFavor
1512:             .Caption   = "x"
1513:             .Top       = 194
1514:             .Left      = 228
1515:             .Width     = 6
1516:             .Height    = 13
1517:             .AutoSize  = .T.
1518:             .FontName  = "Tahoma"
1519:             .FontSize  = 7
1520:             .BackStyle = 0
1521:             .ForeColor = RGB(90, 90, 90)
1522:             .Visible   = .T.
1523:         ENDWITH
1524: 
1525:         loc_oPg2.AddObject("txt_4c_Nclnom1s", "TextBox")
1526:         WITH loc_oPg2.txt_4c_Nclnom1s
1527:             .Top           = 192
1528:             .Left          = 233
1529:             .Width         = 41
1530:             .Height        = 18
1531:             .BackStyle     = 0
1532:             .SpecialEffect = 1
1533:             .FontName      = "Tahoma"

*-- Linhas 1542 a 1568:
1542:         *======== COLUNA DIREITA ========
1543: 
1544:         *-- 5. Cidade
1545:         loc_oPg2.AddObject("lbl_4c_Cidade", "Label")
1546:         WITH loc_oPg2.lbl_4c_Cidade
1547:             .Caption   = "Cidade"
1548:             .Top       = 78
1549:             .Left      = 349
1550:             .Width     = 31
1551:             .Height    = 13
1552:             .AutoSize  = .T.
1553:             .FontName  = "Tahoma"
1554:             .FontSize  = 7
1555:             .BackStyle = 0
1556:             .ForeColor = RGB(90, 90, 90)
1557:             .Visible   = .T.
1558:         ENDWITH
1559: 
1560:         loc_oPg2.AddObject("txt_4c_Nlicid1s", "TextBox")
1561:         WITH loc_oPg2.txt_4c_Nlicid1s
1562:             .Top           = 90
1563:             .Left          = 349
1564:             .Width         = 41
1565:             .Height        = 18
1566:             .BackStyle     = 0
1567:             .SpecialEffect = 1
1568:             .FontName      = "Tahoma"

*-- Linhas 1574 a 1600:
1574:             .Visible       = .T.
1575:         ENDWITH
1576: 
1577:         loc_oPg2.AddObject("lbl_4c_XCidad", "Label")
1578:         WITH loc_oPg2.lbl_4c_XCidad
1579:             .Caption   = "x"
1580:             .Top       = 92
1581:             .Left      = 393
1582:             .Width     = 6
1583:             .Height    = 13
1584:             .AutoSize  = .T.
1585:             .FontName  = "Tahoma"
1586:             .FontSize  = 7
1587:             .BackStyle = 0
1588:             .ForeColor = RGB(90, 90, 90)
1589:             .Visible   = .T.
1590:         ENDWITH
1591: 
1592:         loc_oPg2.AddObject("txt_4c_Nclcid1s", "TextBox")
1593:         WITH loc_oPg2.txt_4c_Nclcid1s
1594:             .Top           = 90
1595:             .Left          = 398
1596:             .Width         = 41
1597:             .Height        = 18
1598:             .BackStyle     = 0
1599:             .SpecialEffect = 1
1600:             .FontName      = "Tahoma"

*-- Linhas 1607 a 1633:
1607:         ENDWITH
1608: 
1609:         *-- 6. Dia
1610:         loc_oPg2.AddObject("lbl_4c_Dia", "Label")
1611:         WITH loc_oPg2.lbl_4c_Dia
1612:             .Caption   = "Dia"
1613:             .Top       = 110
1614:             .Left      = 348
1615:             .Width     = 16
1616:             .Height    = 13
1617:             .AutoSize  = .T.
1618:             .FontName  = "Tahoma"
1619:             .FontSize  = 7
1620:             .BackStyle = 0
1621:             .ForeColor = RGB(90, 90, 90)
1622:             .Visible   = .T.
1623:         ENDWITH
1624: 
1625:         loc_oPg2.AddObject("txt_4c_Nlidia1s", "TextBox")
1626:         WITH loc_oPg2.txt_4c_Nlidia1s
1627:             .Top           = 121
1628:             .Left          = 349
1629:             .Width         = 41
1630:             .Height        = 18
1631:             .BackStyle     = 0
1632:             .SpecialEffect = 1
1633:             .FontName      = "Tahoma"

*-- Linhas 1639 a 1665:
1639:             .Visible       = .T.
1640:         ENDWITH
1641: 
1642:         loc_oPg2.AddObject("lbl_4c_XDia", "Label")
1643:         WITH loc_oPg2.lbl_4c_XDia
1644:             .Caption   = "x"
1645:             .Top       = 123
1646:             .Left      = 393
1647:             .Width     = 6
1648:             .Height    = 13
1649:             .AutoSize  = .T.
1650:             .FontName  = "Tahoma"
1651:             .FontSize  = 7
1652:             .BackStyle = 0
1653:             .ForeColor = RGB(90, 90, 90)
1654:             .Visible   = .T.
1655:         ENDWITH
1656: 
1657:         loc_oPg2.AddObject("txt_4c_Ncldia1s", "TextBox")
1658:         WITH loc_oPg2.txt_4c_Ncldia1s
1659:             .Top           = 121
1660:             .Left          = 398
1661:             .Width         = 41
1662:             .Height        = 18
1663:             .BackStyle     = 0
1664:             .SpecialEffect = 1
1665:             .FontName      = "Tahoma"

*-- Linhas 1672 a 1698:
1672:         ENDWITH
1673: 
1674:         *-- 7. Mes
1675:         loc_oPg2.AddObject("lbl_4c_Mes", "Label")
1676:         WITH loc_oPg2.lbl_4c_Mes
1677:             .Caption   = "M" + CHR(234) + "s"
1678:             .Top       = 144
1679:             .Left      = 349
1680:             .Width     = 19
1681:             .Height    = 13
1682:             .AutoSize  = .T.
1683:             .FontName  = "Tahoma"
1684:             .FontSize  = 7
1685:             .BackStyle = 0
1686:             .ForeColor = RGB(90, 90, 90)
1687:             .Visible   = .T.
1688:         ENDWITH
1689: 
1690:         loc_oPg2.AddObject("txt_4c_Nlimes1s", "TextBox")
1691:         WITH loc_oPg2.txt_4c_Nlimes1s
1692:             .Top           = 156
1693:             .Left          = 349
1694:             .Width         = 41
1695:             .Height        = 18
1696:             .BackStyle     = 0
1697:             .SpecialEffect = 1
1698:             .FontName      = "Tahoma"

*-- Linhas 1704 a 1730:
1704:             .Visible       = .T.
1705:         ENDWITH
1706: 
1707:         loc_oPg2.AddObject("lbl_4c_XMes", "Label")
1708:         WITH loc_oPg2.lbl_4c_XMes
1709:             .Caption   = "x"
1710:             .Top       = 158
1711:             .Left      = 393
1712:             .Width     = 6
1713:             .Height    = 13
1714:             .AutoSize  = .T.
1715:             .FontName  = "Tahoma"
1716:             .FontSize  = 7
1717:             .BackStyle = 0
1718:             .ForeColor = RGB(90, 90, 90)
1719:             .Visible   = .T.
1720:         ENDWITH
1721: 
1722:         loc_oPg2.AddObject("txt_4c_Nclmes1s", "TextBox")
1723:         WITH loc_oPg2.txt_4c_Nclmes1s
1724:             .Top           = 156
1725:             .Left          = 398
1726:             .Width         = 41
1727:             .Height        = 18
1728:             .BackStyle     = 0
1729:             .SpecialEffect = 1
1730:             .FontName      = "Tahoma"

*-- Linhas 1737 a 1763:
1737:         ENDWITH
1738: 
1739:         *-- 8. Ano
1740:         loc_oPg2.AddObject("lbl_4c_Ano", "Label")
1741:         WITH loc_oPg2.lbl_4c_Ano
1742:             .Caption   = "Ano"
1743:             .Top       = 180
1744:             .Left      = 349
1745:             .Width     = 19
1746:             .Height    = 13
1747:             .AutoSize  = .T.
1748:             .FontName  = "Tahoma"
1749:             .FontSize  = 7
1750:             .BackStyle = 0
1751:             .ForeColor = RGB(90, 90, 90)
1752:             .Visible   = .T.
1753:         ENDWITH
1754: 
1755:         loc_oPg2.AddObject("txt_4c_Nliano1s", "TextBox")
1756:         WITH loc_oPg2.txt_4c_Nliano1s
1757:             .Top           = 192
1758:             .Left          = 349
1759:             .Width         = 41
1760:             .Height        = 18
1761:             .BackStyle     = 0
1762:             .SpecialEffect = 1
1763:             .FontName      = "Tahoma"

*-- Linhas 1769 a 1795:
1769:             .Visible       = .T.
1770:         ENDWITH
1771: 
1772:         loc_oPg2.AddObject("lbl_4c_XAno", "Label")
1773:         WITH loc_oPg2.lbl_4c_XAno
1774:             .Caption   = "x"
1775:             .Top       = 194
1776:             .Left      = 393
1777:             .Width     = 6
1778:             .Height    = 13
1779:             .AutoSize  = .T.
1780:             .FontName  = "Tahoma"
1781:             .FontSize  = 7
1782:             .BackStyle = 0
1783:             .ForeColor = RGB(90, 90, 90)
1784:             .Visible   = .T.
1785:         ENDWITH
1786: 
1787:         loc_oPg2.AddObject("txt_4c_Nclano1s", "TextBox")
1788:         WITH loc_oPg2.txt_4c_Nclano1s
1789:             .Top           = 192
1790:             .Left          = 400
1791:             .Width         = 41
1792:             .Height        = 18
1793:             .BackStyle     = 0
1794:             .SpecialEffect = 1
1795:             .FontName      = "Tahoma"

*-- Linhas 1831 a 1841:
1831: 
1832:                 *-- Larguras e headers APOS ControlSource (OBRIGATORIO)
1833:                 loc_oGrid.Column1.Width           = 280
1834:                 loc_oGrid.Column1.Header1.Caption = "Impressoras"
1835:                 loc_oGrid.Column2.Width           = 130
1836:                 loc_oGrid.Column2.Header1.Caption = "M" + CHR(225) + "ximo de Colunas"
1837: 
1838:                 THIS.FormatarGridLista(loc_oGrid)
1839:                 loc_oGrid.Refresh()
1840:                 loc_lSucesso = .T.
1841:             ENDIF

*-- Linhas 2137 a 2188:
2137: 
2138:         WITH THIS.this_oBusinessObject
2139:             *-- Page1: Dados Principais
2140:             loc_oPg1.txt_4c_Impres.Value     = .this_cImpres
2141:             loc_oPg1.txt_4c_Maxcols.Value    = .this_nMaxcols
2142:             loc_oPg1.txt_4c_Titulos.Value    = .this_nTitulos
2143:             loc_oPg1.txt_4c_Barras.Value     = .this_nBarras
2144:             loc_oPg1.txt_4c_Rates.Value      = .this_nRates
2145:             loc_oPg1.chk_4c_Graficos.Value   = IIF(.this_lGraficos, 1, 0)
2146:             loc_oPg1.cbo_4c_Tipos.Value      = .this_cTipos
2147:             loc_oPg1.opt_4c_TpImpres.Value   = IIF(.this_nTpImpres > 0, .this_nTpImpres, 1)
2148:             loc_oPg1.edt_4c_Expds.Value      = .this_cExpds
2149:             loc_oPg1.edt_4c_Expas.Value      = .this_cExpas
2150:             loc_oPg1.edt_4c_Fontes.Value     = .this_cFontes
2151:             loc_oPg1.edt_4c_Fonte2s.Value    = .this_cFonte2s
2152:             loc_oPg1.edt_4c_Barcmds.Value    = .this_cBarcmds
2153:             loc_oPg1.edt_4c_Fontemp1s.Value  = .this_cFontemp1s
2154:             loc_oPg1.chk_4c_Chqf.Value       = IIF(.this_lChkChqf, 1, 0)
2155:             loc_oPg1.opt_4c_ImpEtis.Value    = IIF(.this_nImpEtis > 0, .this_nImpEtis, 1)
2156:             loc_oPg1.cbo_4c_Cetiquetas.Value = .this_cCetiquetas
2157:             loc_oPg1.chk_4c_Exps.Value       = IIF(.this_lExps, 1, 0)
2158:             loc_oPg1.spn_4c_AjVerts.Value    = .this_nAjVerts
2159:             loc_oPg1.spn_4c_AjHorzs.Value    = .this_nAjHorzs
2160:             loc_oPg1.spn_4c_AjDens.Value     = .this_nAjDens
2161:             loc_oPg1.spn_4c_AjVelos.Value    = .this_nAjVelos
2162: 
2163:             *-- Habilitar Page2 apenas se chkChqf=1 E estamos em modo de edicao
2164:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.Enabled = ;
2165:                 .this_lChkChqf AND INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2166: 
2167:             *-- Page2: Posicoes de cheque
2168:             loc_oPg2.txt_4c_Nlivl1s.Value    = .this_nNlivl1s
2169:             loc_oPg2.txt_4c_Nclvl1s.Value    = .this_nNclvl1s
2170:             loc_oPg2.txt_4c_Nlivext1s.Value  = .this_nNlivext1s
2171:             loc_oPg2.txt_4c_Nclvext1s.Value  = .this_nNclvext1s
2172:             loc_oPg2.txt_4c_Nlivext2s.Value  = .this_nNlivext2s
2173:             loc_oPg2.txt_4c_Nclvext2s.Value  = .this_nNclvext2s
2174:             loc_oPg2.txt_4c_Nlinom1s.Value   = .this_nNlinom1s
2175:             loc_oPg2.txt_4c_Nclnom1s.Value   = .this_nNclnom1s
2176:             loc_oPg2.txt_4c_Nlicid1s.Value   = .this_nNlicid1s
2177:             loc_oPg2.txt_4c_Nclcid1s.Value   = .this_nNclcid1s
2178:             loc_oPg2.txt_4c_Nlidia1s.Value   = .this_nNlidia1s
2179:             loc_oPg2.txt_4c_Ncldia1s.Value   = .this_nNcldia1s
2180:             loc_oPg2.txt_4c_Nlimes1s.Value   = .this_nNlimes1s
2181:             loc_oPg2.txt_4c_Nclmes1s.Value   = .this_nNclmes1s
2182:             loc_oPg2.txt_4c_Nliano1s.Value   = .this_nNliano1s
2183:             loc_oPg2.txt_4c_Nclano1s.Value   = .this_nNclano1s
2184:         ENDWITH
2185:     ENDPROC
2186: 
2187:     *==========================================================================
2188:     * LimparCampos - Limpa todos os campos do formulario (modo INCLUIR)

*-- Linhas 2280 a 2289:
2280:         loc_oCnt     = THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva
2281:         loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2282: 
2283:         loc_oCnt.cmd_4c_Confirmar.Enabled = loc_lEditando
2284:         loc_oCnt.cmd_4c_Cancelar.Enabled  = .T.
2285:     ENDPROC
2286: 
2287:     *==========================================================================
2288:     PROCEDURE Destroy()
2289:         TRY


### BO (C:\4c\projeto\app\classes\ImpBO.prg):
*==============================================================================
* ImpBO.prg - Business Object para Cadastro de Impressoras
* Tabela: SigCdmp
* Migrado de: SIGCDIMP.SCX (frmcadastro)
*==============================================================================

DEFINE CLASS ImpBO AS BusinessBase

    *-- Identificacao
    this_cImpres    = ""    && Impressora (C30) - PK visivel
    this_cIdChaves  = ""    && Chave interna do framework (C)

    *-- Dados principais (pg1)
    this_nRates     = 0     && Rate
    this_nTitulos   = 0     && Titulo (linhas por pagina)
    this_nBarras    = 0     && Barra (cpi)
    this_nMaxcols   = 0     && Maximo de Colunas

    *-- Checkboxes
    this_lExps      = .F.   && Expandido
    this_lGraficos  = .F.   && Graficos habilitado
    this_lChkChqf   = .F.   && Cheque Formulario Continuo

    *-- OptionGroups
    this_nTpImpres  = 0     && Tipo de Impressora (1=Boleto, 2=Etiqueta, 3=Boleto Zebra, 4=Padrao)
    this_nImpEtis   = 0     && Tipo Etiqueta (1=Allegro, 2=Zebra ZPL, 3=Zebra EPL)

    *-- Tipo grafico e etiqueta padrao
    this_cTipos         = ""    && Tipo de Grafico (C - dropdown: Epson Esc K, Epson Esc * m n, Mecaf)
    this_cCetiquetas    = ""    && Etiqueta Padrao (C - vem de SigCdTpe.Cetiquetas)

    *-- Ajustes de etiqueta
    this_nAjVerts   = 0     && Ajuste Vertical (0-999)
    this_nAjHorzs   = 0     && Ajuste Horizontal (0-9999)
    this_nAjVelos   = 3     && Velocidade (1-3, default 3)
    this_nAjDens    = 20    && Densidade (10-20, default 20)

    *-- Comandos de controle (M - memo/editbox)
    this_cExpds     = ""    && Desativar Negrito
    this_cExpas     = ""    && Ativar Negrito
    this_cBarcmds   = ""    && Codigo de Barras
    this_cFontes    = ""    && Inicializacao
    this_cFonte2s   = ""    && Ativar Fonte Pequena
    this_cFontemp1s = ""    && Aciona Guilhotina

    *-- Posicionamento cheque (pg2) - coordenadas linha/coluna
    *-- Valor em Numeros
    this_nNlivl1s   = 0     && Linha
    this_nNclvl1s   = 0     && Coluna

    *-- Valor por Extenso (1a Linha)
    this_nNlivext1s = 0     && Linha
    this_nNclvext1s = 0     && Coluna

    *-- Valor por Extenso (2a Linha)
    this_nNlivext2s = 0     && Linha
    this_nNclvext2s = 0     && Coluna

    *-- Favorecido
    this_nNlinom1s  = 0     && Linha
    this_nNclnom1s  = 0     && Coluna

    *-- Cidade
    this_nNlicid1s  = 0     && Linha
    this_nNclcid1s  = 0     && Coluna

    *-- Dia
    this_nNlidia1s  = 0     && Linha
    this_nNcldia1s  = 0     && Coluna

    *-- Mes
    this_nNlimes1s  = 0     && Linha
    this_nNclmes1s  = 0     && Coluna

    *-- Ano
    this_nNliano1s  = 0     && Linha
    this_nNclano1s  = 0     && Coluna

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela      = "SigCdmp"
        THIS.this_cCampoChave  = "Impres"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cImpres
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cImpres      = TratarNulo(impres,     "C")
                THIS.this_cIdChaves    = TratarNulo(cIdChaves,  "C")
                THIS.this_nRates       = TratarNulo(rates,      "N")
                THIS.this_nTitulos     = TratarNulo(titulos,    "N")
                THIS.this_nBarras      = TratarNulo(barras,     "N")
                THIS.this_nMaxcols     = TratarNulo(maxcols,    "N")
                THIS.this_lExps        = (TratarNulo(exps,      "N") = 1)
                THIS.this_lGraficos    = (TratarNulo(graficos,  "N") = 1)
                THIS.this_lChkChqf     = (TratarNulo(chkChqf,   "N") = 1)
                THIS.this_nTpImpres    = TratarNulo(nTpImpres,  "N")
                THIS.this_nImpEtis     = TratarNulo(ImpEtis,    "N")
                THIS.this_cTipos       = TratarNulo(Tipos,      "C")
                THIS.this_cCetiquetas  = TratarNulo(cetiquetas, "C")
                THIS.this_nAjVerts     = TratarNulo(AjVerts,    "N")
                THIS.this_nAjHorzs     = TratarNulo(AjHorzs,    "N")
                THIS.this_nAjVelos     = TratarNulo(AjVelos,    "N")
                THIS.this_nAjDens      = TratarNulo(AjDens,     "N")
                THIS.this_cExpds       = TratarNulo(expds,      "C")
                THIS.this_cExpas       = TratarNulo(expas,      "C")
                THIS.this_cBarcmds     = TratarNulo(barcmds,    "C")
                THIS.this_cFontes      = TratarNulo(fontes,     "C")
                THIS.this_cFonte2s     = TratarNulo(fonte2s,    "C")
                THIS.this_cFontemp1s   = TratarNulo(fontemp1s,  "C")
                THIS.this_nNlivl1s     = TratarNulo(nlivl1s,    "N")
                THIS.this_nNclvl1s     = TratarNulo(nclvl1s,    "N")
                THIS.this_nNlivext1s   = TratarNulo(nlivext1s,  "N")
                THIS.this_nNclvext1s   = TratarNulo(nclvext1s,  "N")
                THIS.this_nNlivext2s   = TratarNulo(nlivext2s,  "N")
                THIS.this_nNclvext2s   = TratarNulo(nclvext2s,  "N")
                THIS.this_nNlinom1s    = TratarNulo(nlinom1s,   "N")
                THIS.this_nNclnom1s    = TratarNulo(nclnom1s,   "N")
                THIS.this_nNlicid1s    = TratarNulo(nlicid1s,   "N")
                THIS.this_nNclcid1s    = TratarNulo(nclcid1s,   "N")
                THIS.this_nNlidia1s    = TratarNulo(nlidia1s,   "N")
                THIS.this_nNcldia1s    = TratarNulo(ncldia1s,   "N")
                THIS.this_nNlimes1s    = TratarNulo(nlimes1s,   "N")
                THIS.this_nNclmes1s    = TratarNulo(nclmes1s,   "N")
                THIS.this_nNliano1s    = TratarNulo(nliano1s,   "N")
                THIS.this_nNclano1s    = TratarNulo(nclano1s,   "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "ImpBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cImpres))
            MsgAviso("Impressora n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarImpressoraExistente(THIS.this_cImpres)
                MsgAviso("Impressora j" + CHR(225) + " cadastrada!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * VerificarImpressoraExistente - Verifica se Impres ja existe
    *====================================================================
    PROCEDURE VerificarImpressoraExistente(par_cImpres)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdmp WHERE impres = " + ;
                EscaparSQL(par_cImpres)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkImp")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkImp")
                SELECT cursor_4c_ChkImp
                loc_lExiste = (cursor_4c_ChkImp.qtd > 0)
                USE IN cursor_4c_ChkImp
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar impressora:" + CHR(13) + loException.Message, "ImpBO.VerificarImpressoraExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigCdmp
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cChave
        loc_lSucesso = .F.

        TRY
            loc_cChave = fUniqueIds()
            THIS.this_cIdChaves = loc_cChave

            loc_cSQL = "INSERT INTO SigCdmp (impres, cIdChaves, rates, titulos, barras, maxcols," + ;
                " exps, graficos, chkChqf, nTpImpres, ImpEtis, Tipos, cetiquetas," + ;
                " AjVerts, AjHorzs, AjVelos, AjDens," + ;
                " expds, expas, barcmds, fontes, fonte2s, fontemp1s," + ;
                " nlivl1s, nclvl1s, nlivext1s, nclvext1s, nlivext2s, nclvext2s," + ;
                " nlinom1s, nclnom1s, nlicid1s, nclcid1s," + ;
                " nlidia1s, ncldia1s, nlimes1s, nclmes1s, nliano1s, nclano1s)" + ;
                " VALUES (" + ;
                EscaparSQL(THIS.this_cImpres) + ", " + ;
                EscaparSQL(loc_cChave) + ", " + ;
                FormatarNumeroSQL(THIS.this_nRates,   0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTitulos, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nBarras,  0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nMaxcols, 0) + ", " + ;
                IIF(THIS.this_lExps,     "1", "0") + ", " + ;
                IIF(THIS.this_lGraficos, "1", "0") + ", " + ;
                IIF(THIS.this_lChkChqf,  "1", "0") + ", " + ;
                FormatarNumeroSQL(THIS.this_nTpImpres, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nImpEtis,   0) + ", " + ;
                EscaparSQL(THIS.this_cTipos) + ", " + ;
                EscaparSQL(THIS.this_cCetiquetas) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAjVerts, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAjHorzs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAjVelos, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAjDens,  0) + ", " + ;
                EscaparSQL(THIS.this_cExpds) + ", " + ;
                EscaparSQL(THIS.this_cExpas) + ", " + ;
                EscaparSQL(THIS.this_cBarcmds) + ", " + ;
                EscaparSQL(THIS.this_cFontes) + ", " + ;
                EscaparSQL(THIS.this_cFonte2s) + ", " + ;
                EscaparSQL(THIS.this_cFontemp1s) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlivl1s,   0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclvl1s,   0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlivext1s, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclvext1s, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlivext2s, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclvext2s, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlinom1s,  0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclnom1s,  0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlicid1s,  0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclcid1s,  0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlidia1s,  0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNcldia1s,  0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlimes1s,  0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclmes1s,  0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNliano1s,  0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclano1s,  0) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir impressora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "ImpBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdmp
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdmp SET" + ;
                " rates    = " + FormatarNumeroSQL(THIS.this_nRates,   0) + "," + ;
                " titulos  = " + FormatarNumeroSQL(THIS.this_nTitulos, 0) + "," + ;
                " barras   = " + FormatarNumeroSQL(THIS.this_nBarras,  0) + "," + ;
                " maxcols  = " + FormatarNumeroSQL(THIS.this_nMaxcols, 0) + "," + ;
                " exps     = " + IIF(THIS.this_lExps,     "1", "0") + "," + ;
                " graficos = " + IIF(THIS.this_lGraficos, "1", "0") + "," + ;
                " chkChqf  = " + IIF(THIS.this_lChkChqf,  "1", "0") + "," + ;
                " nTpImpres = " + FormatarNumeroSQL(THIS.this_nTpImpres, 0) + "," + ;
                " ImpEtis  = " + FormatarNumeroSQL(THIS.this_nImpEtis,   0) + "," + ;
                " Tipos    = " + EscaparSQL(THIS.this_cTipos) + "," + ;
                " cetiquetas = " + EscaparSQL(THIS.this_cCetiquetas) + "," + ;
                " AjVerts  = " + FormatarNumeroSQL(THIS.this_nAjVerts, 0) + "," + ;
                " AjHorzs  = " + FormatarNumeroSQL(THIS.this_nAjHorzs, 0) + "," + ;
                " AjVelos  = " + FormatarNumeroSQL(THIS.this_nAjVelos, 0) + "," + ;
                " AjDens   = " + FormatarNumeroSQL(THIS.this_nAjDens,  0) + "," + ;
                " expds    = " + EscaparSQL(THIS.this_cExpds) + "," + ;
                " expas    = " + EscaparSQL(THIS.this_cExpas) + "," + ;
                " barcmds  = " + EscaparSQL(THIS.this_cBarcmds) + "," + ;
                " fontes   = " + EscaparSQL(THIS.this_cFontes) + "," + ;
                " fonte2s  = " + EscaparSQL(THIS.this_cFonte2s) + "," + ;
                " fontemp1s = " + EscaparSQL(THIS.this_cFontemp1s) + "," + ;
                " nlivl1s  = " + FormatarNumeroSQL(THIS.this_nNlivl1s,   0) + "," + ;
                " nclvl1s  = " + FormatarNumeroSQL(THIS.this_nNclvl1s,   0) + "," + ;
                " nlivext1s = " + FormatarNumeroSQL(THIS.this_nNlivext1s, 0) + "," + ;
                " nclvext1s = " + FormatarNumeroSQL(THIS.this_nNclvext1s, 0) + "," + ;
                " nlivext2s = " + FormatarNumeroSQL(THIS.this_nNlivext2s, 0) + "," + ;
                " nclvext2s = " + FormatarNumeroSQL(THIS.this_nNclvext2s, 0) + "," + ;
                " nlinom1s = " + FormatarNumeroSQL(THIS.this_nNlinom1s,  0) + "," + ;
                " nclnom1s = " + FormatarNumeroSQL(THIS.this_nNclnom1s,  0) + "," + ;
                " nlicid1s = " + FormatarNumeroSQL(THIS.this_nNlicid1s,  0) + "," + ;
                " nclcid1s = " + FormatarNumeroSQL(THIS.this_nNclcid1s,  0) + "," + ;
                " nlidia1s = " + FormatarNumeroSQL(THIS.this_nNlidia1s,  0) + "," + ;
                " ncldia1s = " + FormatarNumeroSQL(THIS.this_nNcldia1s,  0) + "," + ;
                " nlimes1s = " + FormatarNumeroSQL(THIS.this_nNlimes1s,  0) + "," + ;
                " nclmes1s = " + FormatarNumeroSQL(THIS.this_nNclmes1s,  0) + "," + ;
                " nliano1s = " + FormatarNumeroSQL(THIS.this_nNliano1s,  0) + "," + ;
                " nclano1s = " + FormatarNumeroSQL(THIS.this_nNclano1s,  0) + ;
                " WHERE impres = " + EscaparSQL(THIS.this_cImpres)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar impressora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "ImpBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdmp
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdmp WHERE impres = " + EscaparSQL(THIS.this_cImpres)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir impressora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "ImpBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros para o grid da lista
    * Retorna cursor_4c_Dados com impres e maxcols
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (impres C(40), maxcols N(5,0))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT impres, maxcols FROM SigCdmp"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY impres"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        SET NULL ON
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        SET NULL OFF
                        IF USED("cursor_4c_DadosTmp")
                            USE IN cursor_4c_DadosTmp
                        ENDIF
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar impressoras:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar impressoras:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "ImpBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro completo pela chave primaria
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cImpres)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT impres, cIdChaves, rates, titulos, barras, maxcols," + ;
                " exps, graficos, chkChqf, nTpImpres, ImpEtis, Tipos, cetiquetas," + ;
                " AjVerts, AjHorzs, AjVelos, AjDens," + ;
                " expds, expas, barcmds, fontes, fonte2s, fontemp1s," + ;
                " nlivl1s, nclvl1s, nlivext1s, nclvext1s, nlivext2s, nclvext2s," + ;
                " nlinom1s, nclnom1s, nlicid1s, nclcid1s," + ;
                " nlidia1s, ncldia1s, nlimes1s, nclmes1s, nliano1s, nclano1s" + ;
                " FROM SigCdmp WHERE impres = " + EscaparSQL(par_cImpres)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Impressora n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar impressora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "ImpBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarTiposEtiqueta - Carrega cursor crSigCdTpe (writable) para combo etiqueta
    * Fonte: SigCdTpe WHERE nSituas=1, acrescenta linha em branco no topo
    *====================================================================
    PROCEDURE CarregarTiposEtiqueta()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("crSigCdTpe")
                USE IN crSigCdTpe
            ENDIF

            loc_cSQL = "SELECT Cetiquetas, nTipos FROM SigCdTpe WHERE nSituas = 1"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdTpeTmp")

            IF loc_nResultado >= 0
                CREATE CURSOR crSigCdTpe (Cetiquetas C(100), nTipos N(5,0))
                IF USED("crSigCdTpeTmp")
                    APPEND FROM DBF("crSigCdTpeTmp")
                    USE IN crSigCdTpeTmp
                ENDIF
                APPEND BLANK
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar tipos de etiqueta:" + CHR(13) + CapturarErroSQL(), "ImpBO.CarregarTiposEtiqueta")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar tipos de etiqueta:" + CHR(13) + loException.Message, "ImpBO.CarregarTiposEtiqueta")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

