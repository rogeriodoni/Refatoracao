# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 246: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 271: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 295: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 319: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 343: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 367: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 505: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 529: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSigPrCtc.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1398 linhas total):

*-- Linhas 62 a 70:
62: 
63:             IF VARTYPE(par_cEmps) = "C" AND VARTYPE(par_cDopes) = "C" AND VARTYPE(par_nNumes) = "N"
64:                 THIS.this_cEmpDopNums = ALLTRIM(par_cEmps) + ALLTRIM(par_cDopes) + STR(par_nNumes, 6)
65:                 THIS.Caption = "Cota" + CHR(231) + CHR(245) + "es " + ;
66:                                ALLTRIM(PROPER(THIS.this_cEmpDopNums))
67:             ENDIF
68: 
69:             loc_lSucesso = DODEFAULT()
70:         CATCH TO loc_oErro

*-- Linhas 101 a 113:
101: 
102:                 *-- Propaga Caption para labels do cabecalho (fase 4 cria os labels)
103:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Cabecalho", 5)
104:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho, "lbl_4c_Sombra", 5)
105:                         THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
106:                     ENDIF
107:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho, "lbl_4c_Titulo", 5)
108:                         THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
109:                     ENDIF
110:                 ENDIF
111: 
112:                 THIS.pgf_4c_Paginas.Visible    = .T.
113:                 THIS.pgf_4c_Paginas.ActivePage = 1

*-- Linhas 134 a 153:
134: 
135:         WITH THIS.pgf_4c_Paginas
136:             .PageCount = 2
137:             .Top       = -29
138:             .Left      = 0
139:             .Width     = 1003
140:             .Height    = 631
141:             .Tabs      = .F.
142:         ENDWITH
143: 
144:         THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
145:         THIS.pgf_4c_Paginas.Page1.BackColor = RGB(255, 255, 255)
146:         THIS.pgf_4c_Paginas.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
147: 
148:         THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
149:         THIS.pgf_4c_Paginas.Page2.BackColor = RGB(255, 255, 255)
150:         THIS.pgf_4c_Paginas.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
151:     ENDPROC
152: 
153:     *--------------------------------------------------------------------------

*-- Linhas 166 a 204:
166:         *-- Container do cabecalho (cntSombra: Top=2+29, W=THIS.Width, H=80)
167:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
168:         WITH loc_oPagina.cnt_4c_Cabecalho
169:             .Top         = 31
170:             .Left        = 0
171:             .Width       = THIS.Width
172:             .Height      = 80
173:             .BackColor   = RGB(100, 100, 100)
174:             .BorderWidth = 0
175:             .Visible     = .T.
176:         ENDWITH
177: 
178:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
179:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
180:             .AutoSize  = .F.
181:             .Caption   = THIS.Caption
182:             .Top       = 15
183:             .Left      = 10
184:             .Width     = THIS.Width - 20
185:             .Height    = 40
186:             .FontName  = "Tahoma"
187:             .FontSize  = 16
188:             .FontBold  = .T.
189:             .ForeColor = RGB(0, 0, 0)
190:             .BackStyle = 0
191:             .Visible   = .T.
192:         ENDWITH
193: 
194:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
195:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
196:             .AutoSize  = .F.
197:             .Caption   = THIS.Caption
198:             .Top       = 18
199:             .Left      = 10
200:             .Width     = THIS.Width - 20
201:             .Height    = 46
202:             .FontName  = "Tahoma"
203:             .FontSize  = 16
204:             .FontBold  = .T.

*-- Linhas 210 a 390:
210:         *-- Container de botoes CRUD (Grupo_op: Left=542, Top=0+29)
211:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
212:         WITH loc_oPagina.cnt_4c_Botoes
213:             .Top         = 29
214:             .Left        = 542
215:             .Width       = 390
216:             .Height      = 85
217:             .BackStyle = 0
218:             .BorderWidth = 0
219:             .Visible     = .T.
220:         ENDWITH
221: 
222:         *-- Container de saida canonico (cnt_4c_Saida)
223:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
224:         WITH loc_oPagina.cnt_4c_Saida
225:             .Top         = 29
226:             .Left        = 917
227:             .Width       = 90
228:             .Height      = 85
229:             .BackStyle   = 0
230:             .BorderWidth = 0
231:             .Visible     = .T.
232:         ENDWITH
233: 
234:         *-- Botao Encerrar no container cnt_4c_Saida (canonico)
235:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
236:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
237:             .Caption         = "Encerrar"
238:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
239:             .PicturePosition = 13
240:             .Top             = 5
241:             .Left            = 5
242:             .Width           = 75
243:             .Height          = 75
244:             .BackColor       = RGB(255, 255, 255)
245:             .ForeColor       = RGB(90, 90, 90)
246:             .FontName        = "Comic Sans MS"
247:             .FontSize        = 8
248:             .FontBold        = .T.
249:             .FontItalic      = .T.
250:             .Themes          = .F.
251:             .SpecialEffect   = 0
252:             .MousePointer    = 15
253:             .WordWrap        = .T.
254:             .AutoSize        = .F.
255:             .Visible         = .T.
256:         ENDWITH
257:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
258: 
259:         *-- Botoes CRUD em cnt_4c_Botoes
260:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
261:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
262:             .Caption         = "Incluir"
263:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
264:             .PicturePosition = 13
265:             .Top             = 5
266:             .Left            = 5
267:             .Width           = 75
268:             .Height          = 75
269:             .BackColor       = RGB(255, 255, 255)
270:             .ForeColor       = RGB(90, 90, 90)
271:             .FontName        = "Comic Sans MS"
272:             .FontSize        = 8
273:             .FontBold        = .T.
274:             .FontItalic      = .T.
275:             .Themes          = .F.
276:             .SpecialEffect   = 0
277:             .MousePointer    = 15
278:             .WordWrap        = .T.
279:             .AutoSize        = .F.
280:             .Visible         = .T.
281:         ENDWITH
282:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
283: 
284:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
285:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
286:             .Caption         = "Visualizar"
287:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
288:             .PicturePosition = 13
289:             .Top             = 5
290:             .Left            = 80
291:             .Width           = 75
292:             .Height          = 75
293:             .BackColor       = RGB(255, 255, 255)
294:             .ForeColor       = RGB(90, 90, 90)
295:             .FontName        = "Comic Sans MS"
296:             .FontSize        = 8
297:             .FontBold        = .T.
298:             .FontItalic      = .T.
299:             .Themes          = .F.
300:             .SpecialEffect   = 0
301:             .MousePointer    = 15
302:             .WordWrap        = .T.
303:             .AutoSize        = .F.
304:             .Visible         = .T.
305:         ENDWITH
306:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
307: 
308:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
309:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
310:             .Caption         = "Alterar"
311:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
312:             .PicturePosition = 13
313:             .Top             = 5
314:             .Left            = 155
315:             .Width           = 75
316:             .Height          = 75
317:             .BackColor       = RGB(255, 255, 255)
318:             .ForeColor       = RGB(90, 90, 90)
319:             .FontName        = "Comic Sans MS"
320:             .FontSize        = 8
321:             .FontBold        = .T.
322:             .FontItalic      = .T.
323:             .Themes          = .F.
324:             .SpecialEffect   = 0
325:             .MousePointer    = 15
326:             .WordWrap        = .T.
327:             .AutoSize        = .F.
328:             .Visible         = .T.
329:         ENDWITH
330:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
331: 
332:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
333:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
334:             .Caption         = "Excluir"
335:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
336:             .PicturePosition = 13
337:             .Top             = 5
338:             .Left            = 230
339:             .Width           = 75
340:             .Height          = 75
341:             .BackColor       = RGB(255, 255, 255)
342:             .ForeColor       = RGB(90, 90, 90)
343:             .FontName        = "Comic Sans MS"
344:             .FontSize        = 8
345:             .FontBold        = .T.
346:             .FontItalic      = .T.
347:             .Themes          = .F.
348:             .SpecialEffect   = 0
349:             .MousePointer    = 15
350:             .WordWrap        = .T.
351:             .AutoSize        = .F.
352:             .Visible         = .T.
353:         ENDWITH
354:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
355: 
356:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
357:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
358:             .Caption         = "Buscar"
359:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
360:             .PicturePosition = 13
361:             .Top             = 5
362:             .Left            = 305
363:             .Width           = 75
364:             .Height          = 75
365:             .BackColor       = RGB(255, 255, 255)
366:             .ForeColor       = RGB(90, 90, 90)
367:             .FontName        = "Comic Sans MS"
368:             .FontSize        = 8
369:             .FontBold        = .T.
370:             .FontItalic      = .T.
371:             .Themes          = .F.
372:             .SpecialEffect   = 0
373:             .MousePointer    = 15
374:             .WordWrap        = .T.
375:             .AutoSize        = .F.
376:             .Visible         = .T.
377:         ENDWITH
378:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
379: 
380:         *-- Grid grd_4c_Dados (GradeSubN legado: Top=110, Left=85, Width=379 em form 550px)
381:         *-- Adaptado para form 1000px: Top=117 (+29 compensacao PageFrame), Left=12, Width=890
382:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
383:         loc_oGrid = loc_oPagina.grd_4c_Dados
384:         loc_oGrid.Top                = 117
385:         loc_oGrid.Left               = 12
386:         loc_oGrid.Width              = 890
387:         loc_oGrid.Height             = 498
388:         loc_oGrid.ColumnCount        = 3
389:         loc_oGrid.GridLines          = 3
390:         loc_oGrid.FontName           = "Verdana"

*-- Linhas 403 a 423:
403: 
404:         WITH loc_oGrid.Column1
405:             .Width           = 100
406:             .Header1.Caption = "Moeda"
407:         ENDWITH
408: 
409:         WITH loc_oGrid.Column2
410:             .Width           = 550
411:             .ReadOnly        = .T.
412:             .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
413:         ENDWITH
414: 
415:         WITH loc_oGrid.Column3
416:             .Width           = 200
417:             .ReadOnly        = .T.
418:             .Header1.Caption = "Cota" + CHR(231) + CHR(227) + "o"
419:         ENDWITH
420: 
421:         BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
422: 
423:         THIS.TornarControlesVisiveis(loc_oPagina)

*-- Linhas 438 a 476:
438:         *-- Container do cabecalho da Page2 (mesmo layout da Page1)
439:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
440:         WITH loc_oPagina.cnt_4c_Cabecalho
441:             .Top         = 31
442:             .Left        = 0
443:             .Width       = THIS.Width
444:             .Height      = 80
445:             .BackColor   = RGB(100, 100, 100)
446:             .BorderWidth = 0
447:             .Visible     = .T.
448:         ENDWITH
449: 
450:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
451:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
452:             .AutoSize  = .F.
453:             .Caption   = THIS.Caption
454:             .Top       = 15
455:             .Left      = 10
456:             .Width     = THIS.Width - 20
457:             .Height    = 40
458:             .FontName  = "Tahoma"
459:             .FontSize  = 16
460:             .FontBold  = .T.
461:             .ForeColor = RGB(0, 0, 0)
462:             .BackStyle = 0
463:             .Visible   = .T.
464:         ENDWITH
465: 
466:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
467:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
468:             .AutoSize  = .F.
469:             .Caption   = THIS.Caption
470:             .Top       = 18
471:             .Left      = 10
472:             .Width     = THIS.Width - 20
473:             .Height    = 46
474:             .FontName  = "Tahoma"
475:             .FontSize  = 16
476:             .FontBold  = .T.

*-- Linhas 482 a 555:
482:         *-- Container de botoes de acao (Confirmar/Cancelar)
483:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
484:         WITH loc_oPagina.cnt_4c_BotoesAcao
485:             .Top         = 33
486:             .Left        = 842
487:             .Width       = 160
488:             .Height      = 85
489:             .BackStyle   = 0
490:             .BorderWidth = 0
491:             .Visible     = .T.
492:         ENDWITH
493: 
494:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
495:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
496:             .Caption         = "Confirmar"
497:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
498:             .PicturePosition = 13
499:             .Top             = 5
500:             .Left            = 5
501:             .Width           = 75
502:             .Height          = 75
503:             .BackColor       = RGB(255, 255, 255)
504:             .ForeColor       = RGB(90, 90, 90)
505:             .FontName        = "Comic Sans MS"
506:             .FontSize        = 8
507:             .FontBold        = .T.
508:             .FontItalic      = .T.
509:             .Themes          = .F.
510:             .SpecialEffect   = 0
511:             .MousePointer    = 15
512:             .WordWrap        = .T.
513:             .AutoSize        = .F.
514:             .Visible         = .T.
515:         ENDWITH
516:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
517: 
518:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
519:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
520:             .Caption         = "Encerrar"
521:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
522:             .PicturePosition = 13
523:             .Top             = 5
524:             .Left            = 80
525:             .Width           = 75
526:             .Height          = 75
527:             .BackColor       = RGB(255, 255, 255)
528:             .ForeColor       = RGB(90, 90, 90)
529:             .FontName        = "Comic Sans MS"
530:             .FontSize        = 8
531:             .FontBold        = .T.
532:             .FontItalic      = .T.
533:             .Themes          = .F.
534:             .SpecialEffect   = 0
535:             .MousePointer    = 15
536:             .WordWrap        = .T.
537:             .AutoSize        = .F.
538:             .Visible         = .T.
539:         ENDWITH
540:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
541: 
542:         *-- Primeiros 50% dos campos: Moeda (cmoes) e Descricao (Descrs)
543: 
544:         *-- Campo Moeda
545:         loc_oPagina.AddObject("lbl_4c_LblMoeda", "Label")
546:         WITH loc_oPagina.lbl_4c_LblMoeda
547:             .AutoSize  = .F.
548:             .Caption   = "Moeda :"
549:             .Top       = 133
550:             .Left      = 40
551:             .Width     = 100
552:             .Height    = 17
553:             .BackStyle = 0
554:             .FontName  = "Tahoma"
555:             .FontSize  = 8

*-- Linhas 561 a 588:
561:         loc_oPagina.AddObject("txt_4c_Cmoes", "TextBox")
562:         WITH loc_oPagina.txt_4c_Cmoes
563:             .Value     = ""
564:             .Top       = 130
565:             .Left      = 150
566:             .Width     = 120
567:             .Height    = 23
568:             .MaxLength = 3
569:             .FontName  = "Tahoma"
570:             .FontSize  = 8
571:             .ForeColor = RGB(90, 90, 90)
572:             .BackColor = RGB(255, 255, 255)
573:             .Enabled   = .T.
574:             .Visible   = .T.
575:         ENDWITH
576: 
577:         *-- Campo Descricao (read-only, preenchido automaticamente pelo lookup de moeda)
578:         loc_oPagina.AddObject("lbl_4c_LblDescrs", "Label")
579:         WITH loc_oPagina.lbl_4c_LblDescrs
580:             .AutoSize  = .F.
581:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
582:             .Top       = 168
583:             .Left      = 40
584:             .Width     = 100
585:             .Height    = 17
586:             .BackStyle = 0
587:             .FontName  = "Tahoma"
588:             .FontSize  = 8

*-- Linhas 594 a 603:
594:         loc_oPagina.AddObject("txt_4c_Descrs", "TextBox")
595:         WITH loc_oPagina.txt_4c_Descrs
596:             .Value     = ""
597:             .Top       = 165
598:             .Left      = 150
599:             .Width     = 400
600:             .Height    = 23
601:             .MaxLength = 15
602:             .FontName  = "Tahoma"
603:             .FontSize  = 8

*-- Linhas 609 a 622:
609:         ENDWITH
610: 
611:         *-- Campo Cotacao (valos - numerico 11,6 - equivalente Column3 do grid original)
612:         loc_oPagina.AddObject("lbl_4c_LblValos", "Label")
613:         WITH loc_oPagina.lbl_4c_LblValos
614:             .AutoSize  = .F.
615:             .Caption   = "Cota" + CHR(231) + CHR(227) + "o :"
616:             .Top       = 203
617:             .Left      = 40
618:             .Width     = 100
619:             .Height    = 17
620:             .BackStyle = 0
621:             .FontName  = "Tahoma"
622:             .FontSize  = 8

*-- Linhas 628 a 637:
628:         loc_oPagina.AddObject("txt_4c_Valos", "TextBox")
629:         WITH loc_oPagina.txt_4c_Valos
630:             .Value     = 0
631:             .Top       = 200
632:             .Left      = 150
633:             .Width     = 200
634:             .Height    = 23
635:             .InputMask = "99999.9999999"
636:             .Format    = "K"
637:             .FontName  = "Tahoma"

*-- Linhas 743 a 761:
743:                 WITH loc_oGrid
744:                     .Column1.ControlSource   = "cursor_4c_LocalCtMoe.cmoes"
745:                     .Column1.Width           = 100
746:                     .Column1.Header1.Caption = "Moeda"
747: 
748:                     .Column2.ControlSource   = "cursor_4c_LocalCtMoe.Descrs"
749:                     .Column2.Width           = 550
750:                     .Column2.ReadOnly        = .T.
751:                     .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
752: 
753:                     .Column3.ControlSource   = "cursor_4c_LocalCtMoe.valos"
754:                     .Column3.Width           = 200
755:                     .Column3.ReadOnly        = .T.
756:                     .Column3.Header1.Caption = "Cota" + CHR(231) + CHR(227) + "o"
757:                 ENDWITH
758: 
759:                 THIS.FormatarGridLista(loc_oGrid)
760:                 THIS.AjustarBotoesPorModo()
761:             ENDIF

*-- Linhas 1303 a 1318:
1303:                                                        RGB(255,255,255), RGB(240,240,240))
1304:             ENDIF
1305:             IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
1306:                 IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1307:                     IF par_lHabilitar
1308:                         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Caption = "Confirmar"
1309:                         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Picture = ;
1310:                             gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
1311:                     ELSE
1312:                         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Caption = "Fechar"
1313:                         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Picture = ;
1314:                             gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1315:                     ENDIF
1316:                 ENDIF
1317:             ENDIF
1318:         CATCH TO loc_oErro

*-- Linhas 1339 a 1360:
1339:                 loc_lPodeExcluir = INLIST(UPPER(ALLTRIM(THIS.this_cEscolha)), "INSERIR", "ALTERAR")
1340:             ENDIF
1341: 
1342:             IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
1343:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled = loc_lPodeInserir
1344:             ENDIF
1345:             IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Visualizar", 5)
1346:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
1347:             ENDIF
1348:             IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Alterar", 5)
1349:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled = loc_lTemRegistro
1350:             ENDIF
1351:             IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
1352:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled = loc_lTemRegistro AND loc_lPodeExcluir
1353:             ENDIF
1354:             IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Buscar", 5)
1355:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled = .T.
1356:             ENDIF
1357:         CATCH TO loc_oErro
1358:             MsgErro("Erro em AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message + ;
1359:                     " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
1360:         ENDTRY

*-- Linhas 1381 a 1395:
1381:                                           "INSERIR", "ALTERAR")
1382:             ENDIF
1383: 
1384:             IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
1385:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Visible = loc_lPodeInserir
1386:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled = loc_lPodeInserir
1387:             ENDIF
1388:             IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
1389:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Visible = loc_lPodeExcluir
1390:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled = loc_lPodeExcluir
1391:             ENDIF
1392:         CATCH TO loc_oErro
1393:             MsgErro("Erro em ControlarBotoesPorEscolha:" + CHR(13) + loc_oErro.Message + ;
1394:                     " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
1395:         ENDTRY


### BO (C:\4c\projeto\app\classes\SigPrCtcBO.prg):
*==============================================================================
* SigPrCtcBO.prg - Business Object para Cotacoes por Operacoes
* Herda de BusinessBase
* Tabela principal: sigprctc
* PK: pkchaves (char 20)
* Fase 1: Propriedades e Init()
*==============================================================================

DEFINE CLASS SigPrCtcBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Identificador composto da operacao (pcEmps + pcDopes + STR(pnNumes,6))
    * Chave de agrupamento de todas as cotacoes da operacao
    *--------------------------------------------------------------------------
    this_cEmpDopNums = ""    && empdopnums char(29) - chave da operacao

    *--------------------------------------------------------------------------
    * Campos da linha corrente de sigprctc
    *--------------------------------------------------------------------------
    this_cCmoes      = ""    && cmoes    char(3)       - codigo da moeda (FK SigCdMoe)
    this_nValos      = 0     && valos    numeric(11,6) - cotacao da moeda
    this_cPkChaves   = ""    && pkchaves char(20)      - chave primaria (PK)
    this_dDtalts     = {}    && dtalts   datetime NULL - data/hora alteracao
    this_cUsuars     = ""    && usuars   char(10)      - usuario que gravou

    *--------------------------------------------------------------------------
    * Campo auxiliar vindo do JOIN com SigCdMoe (nao persistido em sigprctc)
    *--------------------------------------------------------------------------
    this_cDescrs     = ""    && dmoes char(15) - descricao da moeda (SigCdMoe.dmoes)

    *--------------------------------------------------------------------------
    * Controle interno de estado da colecao
    *--------------------------------------------------------------------------
    this_lHouveInsercao  = .F.  && .T. se alguma linha foi inserida na sessao
    this_lHouveExclusao  = .F.  && .T. se alguma linha foi removida na sessao

    *==========================================================================
    * Init - Configura tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            THIS.this_cTabela     = "sigprctc"
            THIS.this_cCampoChave = "pkchaves"

            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCtcBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna valor da chave primaria (auditoria)
    *==========================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades de uma linha do cursor
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cEmpDopNums = TratarNulo(empdopnums, "C")
                THIS.this_cCmoes      = TratarNulo(cmoes,      "C")
                THIS.this_nValos      = TratarNulo(valos,      "N")
                THIS.this_cPkChaves   = TratarNulo(pkchaves,   "C")
                THIS.this_cDescrs     = TratarNulo(Descrs,     "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarParaEdicao - Carrega cotacoes da operacao em cursor VFP local
    * par_cEmpDopNums: chave da operacao (emps+dopes+numes, 29 chars)
    * Cria cursor_4c_LocalCtMoe para edicao em memoria
    *==========================================================================
    PROCEDURE CarregarParaEdicao(par_cEmpDopNums)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_LocalCtMoe")
                USE IN cursor_4c_LocalCtMoe
            ENDIF
            IF USED("cursor_4c_CtMoeTemp")
                USE IN cursor_4c_CtMoeTemp
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_LocalCtMoe ;
                (empdopnums C(29), cmoes C(3), valos N(11,6), pkchaves C(20), Descrs C(15))
            SET NULL OFF

            loc_cSQL = "SELECT a.empdopnums, a.cmoes, a.valos, a.pkchaves," + ;
                       " ISNULL(b.dmoes,'') AS Descrs" + ;
                       " FROM sigprctc a" + ;
                       " LEFT JOIN SigCdMoe b ON b.cmoes = a.cmoes" + ;
                       " WHERE a.empdopnums = " + EscaparSQL(ALLTRIM(par_cEmpDopNums))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CtMoeTemp")

            IF loc_nResult > 0 AND USED("cursor_4c_CtMoeTemp") AND RECCOUNT("cursor_4c_CtMoeTemp") > 0
                SELECT cursor_4c_LocalCtMoe
                APPEND FROM DBF("cursor_4c_CtMoeTemp")
            ENDIF

            IF USED("cursor_4c_CtMoeTemp")
                USE IN cursor_4c_CtMoeTemp
            ENDIF

            SELECT cursor_4c_LocalCtMoe
            GO TOP

            THIS.this_lHouveInsercao = .F.
            THIS.this_lHouveExclusao = .F.

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro CarregarParaEdicao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InserirLinhaLocal - Insere nova linha em branco no cursor local
    * par_cEmpDopNums: chave da operacao para preencher o campo de agrupamento
    *==========================================================================
    PROCEDURE InserirLinhaLocal(par_cEmpDopNums)
        LOCAL loc_lSucesso, loc_cPkChave
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_LocalCtMoe")
                MsgErro("Cursor de edi" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o iniciado.", "Erro")
            ELSE
                SELECT cursor_4c_LocalCtMoe
                LOCATE FOR EMPTY(cmoes) AND !DELETED()
                IF EOF()
                    loc_cPkChave = LEFT(SYS(2015) + PADR(TRANSFORM(RECCOUNT("cursor_4c_LocalCtMoe") + 1), 10, "0"), 20)
                    INSERT INTO cursor_4c_LocalCtMoe (empdopnums, cmoes, valos, pkchaves, Descrs) ;
                        VALUES (ALLTRIM(par_cEmpDopNums), SPACE(3), 0, loc_cPkChave, SPACE(15))
                    GO BOTTOM
                ELSE
                    GO RECNO()
                ENDIF
                THIS.this_lHouveInsercao = .T.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro InserirLinhaLocal")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExcluirLinhaLocal - Remove linha corrente do cursor local (marca deleted)
    *==========================================================================
    PROCEDURE ExcluirLinhaLocal()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_LocalCtMoe")
                MsgErro("Cursor de edi" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o iniciado.", "Erro")
            ELSE
                IF !EOF("cursor_4c_LocalCtMoe")
                SELECT cursor_4c_LocalCtMoe
                DELETE
                SKIP
                IF EOF()
                    SKIP -1
                ENDIF
                THIS.this_lHouveExclusao = .T.
                loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ExcluirLinhaLocal")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDuplicidade - Verifica se ha moedas duplicadas no cursor local
    * Retorna .T. se valido (sem duplicatas), .F. se ha moedas repetidas
    *==========================================================================
    PROCEDURE ValidarDuplicidade()
        LOCAL loc_lValido, loc_cMoesDup
        loc_lValido  = .F.
        loc_cMoesDup = ""

        TRY
            IF !USED("cursor_4c_LocalCtMoe")
                MsgErro("Cursor de edi" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o iniciado.", "Erro")
            ELSE
                IF USED("cursor_4c_Totais")
                    USE IN cursor_4c_Totais
                ENDIF

                SELECT cmoes, SUM(1) AS tt FROM cursor_4c_LocalCtMoe ;
                    WHERE !DELETED() AND !EMPTY(ALLTRIM(cmoes)) ;
                    GROUP BY cmoes ;
                    INTO CURSOR cursor_4c_Totais

                IF USED("cursor_4c_Totais")
                    SELECT cursor_4c_Totais
                    SCAN
                        IF tt > 1
                            IF !EMPTY(loc_cMoesDup)
                                loc_cMoesDup = loc_cMoesDup + ", "
                            ENDIF
                            loc_cMoesDup = loc_cMoesDup + ALLTRIM(cmoes)
                        ENDIF
                    ENDSCAN
                    USE IN cursor_4c_Totais
                ENDIF

                IF !EMPTY(loc_cMoesDup)
                    MsgErro("Moeda(s) digitada(s) em duplicidade: " + loc_cMoesDup, ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lValido = .F.
                ELSE
                    loc_lValido = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ValidarDuplicidade")
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * BuscarMoeda - Busca moeda por codigo em SigCdMoe
    * par_cCodigo: codigo da moeda (cmoes)
    * Popula cursor_4c_BuscaMoeda; retorna .T. se encontrou codigo exato
    *==========================================================================
    PROCEDURE BuscarMoeda(par_cCodigo)
        LOCAL loc_lEncontrou, loc_cSQL, loc_nResult
        loc_lEncontrou = .F.

        TRY
            IF USED("cursor_4c_BuscaMoeda")
                USE IN cursor_4c_BuscaMoeda
            ENDIF

            loc_cSQL = "SELECT cmoes, dmoes AS Descrs FROM SigCdMoe" + ;
                       " WHERE cmoes LIKE " + EscaparSQL(ALLTRIM(par_cCodigo) + "%") + ;
                       " ORDER BY cmoes"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoeda")

            IF loc_nResult > 0 AND USED("cursor_4c_BuscaMoeda") AND RECCOUNT("cursor_4c_BuscaMoeda") > 0
                SELECT cursor_4c_BuscaMoeda
                GO TOP
                IF RECCOUNT("cursor_4c_BuscaMoeda") = 1 AND ;
                   UPPER(ALLTRIM(cursor_4c_BuscaMoeda.cmoes)) == UPPER(ALLTRIM(par_cCodigo))
                    THIS.this_cCmoes  = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
                    THIS.this_cDescrs = ALLTRIM(cursor_4c_BuscaMoeda.Descrs)
                    loc_lEncontrou = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro BuscarMoeda")
        ENDTRY

        RETURN loc_lEncontrou
    ENDPROC

    *==========================================================================
    * AtualizarDescricaoMoeda - Atualiza campo Descrs na linha corrente do cursor local
    *==========================================================================
    PROCEDURE AtualizarDescricaoMoeda(par_cDescrs)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_LocalCtMoe") AND !EOF("cursor_4c_LocalCtMoe")
                SELECT cursor_4c_LocalCtMoe
                REPLACE Descrs WITH PADR(ALLTRIM(par_cDescrs), 15)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro AtualizarDescricaoMoeda")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * SalvarCotacoes - Persiste cotacoes no SQL Server (DELETE all + INSERT validas)
    * par_cEmpDopNums: chave da operacao
    * Logica: deleta todos da operacao, re-insere linhas validas do cursor local
    *==========================================================================
    PROCEDURE SalvarCotacoes(par_cEmpDopNums)
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL, loc_nLinha, loc_cPkChave
        loc_lSucesso = .F.

        TRY
            IF !THIS.ValidarDuplicidade()
                *-- mensagem ja exibida por ValidarDuplicidade
            ELSE
                IF !USED("cursor_4c_LocalCtMoe")
                MsgErro("Cursor de edi" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o iniciado.", "Erro")
            ELSE
                *-- Passo 1: Remove todos os registros da operacao no SQL Server
                loc_cSQL = "DELETE FROM sigprctc WHERE empdopnums = " + ;
                           EscaparSQL(ALLTRIM(par_cEmpDopNums))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
                IF USED("cursor_4c_Del")
                    USE IN cursor_4c_Del
                ENDIF

                IF loc_nResult < 0
                    MsgErro("Erro ao excluir cota" + CHR(231) + CHR(245) + "es anteriores:" + ;
                            CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    *-- Passo 2: Re-insere todas as linhas validas do cursor local
                    SELECT cursor_4c_LocalCtMoe
                    GO TOP
                    loc_lSucesso = .T.
                    loc_nLinha   = 0

                    SCAN WHILE loc_lSucesso
                        IF DELETED()
                            LOOP
                        ENDIF
                        IF EMPTY(ALLTRIM(cmoes))
                            LOOP
                        ENDIF

                        loc_nLinha   = loc_nLinha + 1
                        loc_cPkChave = LEFT(SYS(2015) + PADR(TRANSFORM(loc_nLinha), 10, "0"), 20)

                        loc_cSQL = "INSERT INTO sigprctc (empdopnums, cmoes, valos, pkchaves, dtalts, usuars)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(ALLTRIM(par_cEmpDopNums)) + "," + ;
                                   EscaparSQL(ALLTRIM(cmoes)) + "," + ;
                                   FormatarNumeroSQL(valos) + "," + ;
                                   EscaparSQL(loc_cPkChave) + "," + ;
                                   "GETDATE()," + ;
                                   EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)) + ;
                                   ")"

                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
                        IF USED("cursor_4c_Ins")
                            USE IN cursor_4c_Ins
                        ENDIF

                        IF loc_nResult < 0
                            MsgErro("Erro ao inserir cota" + CHR(231) + CHR(227) + "o da moeda " + ;
                                    ALLTRIM(cmoes) + ":" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lSucesso = .F.
                        ENDIF
                    ENDSCAN

                    IF loc_lSucesso
                        THIS.RegistrarAuditoria("SALVAR_COTACOES")
                    ENDIF
                ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SalvarCotacoes")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

