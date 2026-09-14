# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formccr.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (3655 linhas total):

*-- Linhas 73 a 81:
73:                 THIS.ConfigurarPageFrame()
74:                 THIS.ConfigurarPaginaLista()
75:                 THIS.ConfigurarPaginaDados()
76:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = ;
77:                     "Grupos de Contas Corrente"
78: 
79:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
80:                     THIS.CarregarLista()
81:                 ENDIF

*-- Linhas 103 a 123:
103:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
104: 
105:         WITH THIS.pgf_4c_Paginas
106:             .Top       = -29
107:             .Left      = 0
108:             .Width     = 1003
109:             .Height    = 629
110:             .PageCount = 2
111:             .Tabs      = .F.
112:             .Visible   = .T.
113: 
114:             .Page1.Caption   = "Lista"
115:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
116:             .Page1.BackColor = RGB(255, 255, 255)
117: 
118:             .Page2.Caption   = "Dados"
119:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
120:             .Page2.BackColor = RGB(255, 255, 255)
121:         ENDWITH
122:     ENDPROC
123: 

*-- Linhas 132 a 153:
132:         *-- Container cabecalho (Top=31, Width=1020, Height=80)
133:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
134:         WITH loc_oPagina.cnt_4c_Cabecalho
135:             .Top         = 31
136:             .Left        = 0
137:             .Width       = 1020
138:             .Height      = 80
139:             .BackStyle   = 0
140:             .BorderWidth = 0
141:             .Visible     = .T.
142:         ENDWITH
143: 
144:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
145:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
146:             .Caption   = "Grupos de Contas Corrente"
147:             .Top       = 20
148:             .Left      = 20
149:             .Width     = 400
150:             .Height    = 30
151:             .FontName  = "Tahoma"
152:             .FontSize  = 14
153:             .FontBold  = .T.

*-- Linhas 159 a 326:
159:         *-- Container botoes CRUD (Left=542, Top=29, Width=400, Height=85)
160:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
161:         WITH loc_oPagina.cnt_4c_Botoes
162:             .Top         = 29
163:             .Left        = 542
164:             .Width       = 400
165:             .Height      = 85
166:             .BackStyle = 1
167:             .BackColor = RGB(53, 53, 53)
168:             .BorderWidth = 0
169:             .Visible     = .T.
170:         ENDWITH
171: 
172:         *-- Incluir (Left=5)
173:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
174:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
175:             .Caption         = "Incluir"
176:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
177:             .PicturePosition = 13
178:             .Width           = 75
179:             .Height          = 75
180:             .Left            = 5
181:             .Top             = 5
182:             .FontName        = "Tahoma"
183:             .FontSize        = 8
184:             .Themes          = .F.
185:             .SpecialEffect   = 0
186:             .BackColor       = RGB(255, 255, 255)
187:             .ForeColor       = RGB(90, 90, 90)
188:             .Visible         = .T.
189:         ENDWITH
190:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
191: 
192:         *-- Visualizar (Left=80)
193:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
194:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
195:             .Caption         = "Visualizar"
196:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
197:             .PicturePosition = 13
198:             .Width           = 75
199:             .Height          = 75
200:             .Left            = 80
201:             .Top             = 5
202:             .FontName        = "Tahoma"
203:             .FontSize        = 8
204:             .Themes          = .F.
205:             .SpecialEffect   = 0
206:             .BackColor       = RGB(255, 255, 255)
207:             .ForeColor       = RGB(90, 90, 90)
208:             .Visible         = .T.
209:         ENDWITH
210:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
211: 
212:         *-- Alterar (Left=155)
213:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
214:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
215:             .Caption         = "Alterar"
216:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
217:             .PicturePosition = 13
218:             .Width           = 75
219:             .Height          = 75
220:             .Left            = 155
221:             .Top             = 5
222:             .FontName        = "Tahoma"
223:             .FontSize        = 8
224:             .Themes          = .F.
225:             .SpecialEffect   = 0
226:             .BackColor       = RGB(255, 255, 255)
227:             .ForeColor       = RGB(90, 90, 90)
228:             .Visible         = .T.
229:         ENDWITH
230:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
231: 
232:         *-- Excluir (Left=230)
233:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
234:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
235:             .Caption         = "Excluir"
236:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
237:             .PicturePosition = 13
238:             .Width           = 75
239:             .Height          = 75
240:             .Left            = 230
241:             .Top             = 5
242:             .FontName        = "Tahoma"
243:             .FontSize        = 8
244:             .Themes          = .F.
245:             .SpecialEffect   = 0
246:             .BackColor       = RGB(255, 255, 255)
247:             .ForeColor       = RGB(90, 90, 90)
248:             .Visible         = .T.
249:         ENDWITH
250:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
251: 
252:         *-- Buscar (Left=305)
253:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
254:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
255:             .Caption         = "Buscar"
256:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
257:             .PicturePosition = 13
258:             .Width           = 75
259:             .Height          = 75
260:             .Left            = 305
261:             .Top             = 5
262:             .FontName        = "Tahoma"
263:             .FontSize        = 8
264:             .Themes          = .F.
265:             .SpecialEffect   = 0
266:             .BackColor       = RGB(255, 255, 255)
267:             .ForeColor       = RGB(90, 90, 90)
268:             .Visible         = .T.
269:         ENDWITH
270:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
271: 
272:         *-- Container saida (Left=917, Top=29, Width=90, Height=85)
273:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
274:         WITH loc_oPagina.cnt_4c_Saida
275:             .Top         = 29
276:             .Left        = 917
277:             .Width       = 90
278:             .Height      = 85
279:             .BackStyle = 1
280:             .BackColor = RGB(53, 53, 53)
281:             .BorderWidth = 0
282:             .Visible     = .T.
283:         ENDWITH
284: 
285:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
286:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
287:             .Caption         = "Encerrar"
288:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
289:             .PicturePosition = 13
290:             .Width           = 75
291:             .Height          = 75
292:             .Left            = 5
293:             .Top             = 5
294:             .FontName        = "Tahoma"
295:             .FontSize        = 8
296:             .Themes          = .F.
297:             .SpecialEffect   = 0
298:             .BackColor       = RGB(255, 255, 255)
299:             .ForeColor       = RGB(90, 90, 90)
300:             .Visible         = .T.
301:         ENDWITH
302:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
303: 
304:         *-- Container filtros (Left=5, Top=29, vazio - busca via BtnBuscarClick)
305:         loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
306:         WITH loc_oPagina.cnt_4c_Filtros
307:             .Top         = 29
308:             .Left        = 5
309:             .Width       = 530
310:             .Height      = 85
311:             .BackStyle   = 0
312:             .BorderWidth = 0
313:             .Visible     = .T.
314:         ENDWITH
315: 
316:         *-- Grid de lista (Top=121, Left=11, Width=938, Height=470)
317:         *-- 5 colunas: Codigos/Descrs/Internos/TpCods/DClasses
318:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
319:         WITH loc_oPagina.grd_4c_Lista
320:             .Top               = 121
321:             .Left              = 11
322:             .Width             = 938
323:             .Height            = 470
324:             .ReadOnly          = .T.
325:             .DeleteMark        = .F.
326:             .RecordMark        = .F.

*-- Linhas 345 a 496:
345:         *-- Botoes Salvar/Cancelar (Top=38, Left=819, Width=165, Height=85)
346:         loc_oPagina.AddObject("cnt_4c_BotoesDados", "Container")
347:         WITH loc_oPagina.cnt_4c_BotoesDados
348:             .Top         = 38
349:             .Left        = 819
350:             .Width       = 165
351:             .Height      = 85
352:             .BackStyle = 1
353:             .BackColor = RGB(53, 53, 53)
354:             .BorderWidth = 0
355:             .Visible     = .T.
356:         ENDWITH
357: 
358:         loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Salvar", "CommandButton")
359:         WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Salvar
360:             .Caption         = "Salvar"
361:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
362:             .PicturePosition = 13
363:             .Width           = 75
364:             .Height          = 75
365:             .Left            = 7
366:             .Top             = 5
367:             .FontName        = "Tahoma"
368:             .FontSize        = 8
369:             .Themes          = .F.
370:             .SpecialEffect   = 0
371:             .BackColor       = RGB(255, 255, 255)
372:             .ForeColor       = RGB(90, 90, 90)
373:             .Visible         = .T.
374:         ENDWITH
375:         BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")
376: 
377:         loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Cancelar", "CommandButton")
378:         WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar
379:             .Caption         = "Cancelar"
380:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
381:             .PicturePosition = 13
382:             .Width           = 75
383:             .Height          = 75
384:             .Left            = 83
385:             .Top             = 5
386:             .FontName        = "Tahoma"
387:             .FontSize        = 8
388:             .Themes          = .F.
389:             .SpecialEffect   = 0
390:             .BackColor       = RGB(255, 255, 255)
391:             .ForeColor       = RGB(90, 90, 90)
392:             .Visible         = .T.
393:         ENDWITH
394:         BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
395: 
396:         *----------------------------------------------------------------------
397:         *-- ROW 1: Codigos | Descrs | Internos (Top=38)
398:         *----------------------------------------------------------------------
399:         loc_oPagina.AddObject("lbl_4c_LblCodigos", "Label")
400:         WITH loc_oPagina.lbl_4c_LblCodigos
401:             .Caption   = "C" + CHR(243) + "digo :"
402:             .Left      = 5
403:             .Top       = 43
404:             .Width     = 50
405:             .Height    = 15
406:             .FontName  = "Tahoma"
407:             .FontSize  = 8
408:             .BackStyle = 0
409:             .ForeColor = RGB(90, 90, 90)
410:             .Visible   = .T.
411:         ENDWITH
412: 
413:         loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
414:         WITH loc_oPagina.txt_4c_Codigos
415:             .Value         = ""
416:             .Left          = 57
417:             .Top           = 38
418:             .Width         = 65
419:             .Height        = 24
420:             .FontName      = "Tahoma"
421:             .FontSize      = 8
422:             .SpecialEffect = 1
423:             .MaxLength     = 10
424:             .InputMask     = "XXXXXXXXXX"
425:             .Visible       = .T.
426:         ENDWITH
427: 
428:         loc_oPagina.AddObject("lbl_4c_LblDescrs", "Label")
429:         WITH loc_oPagina.lbl_4c_LblDescrs
430:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
431:             .Left      = 130
432:             .Top       = 43
433:             .Width     = 63
434:             .Height    = 15
435:             .FontName  = "Tahoma"
436:             .FontSize  = 8
437:             .BackStyle = 0
438:             .ForeColor = RGB(90, 90, 90)
439:             .Visible   = .T.
440:         ENDWITH
441: 
442:         loc_oPagina.AddObject("txt_4c_Descrs", "TextBox")
443:         WITH loc_oPagina.txt_4c_Descrs
444:             .Value         = ""
445:             .Left          = 198
446:             .Top           = 38
447:             .Width         = 250
448:             .Height        = 24
449:             .FontName      = "Tahoma"
450:             .FontSize      = 8
451:             .SpecialEffect = 1
452:             .MaxLength     = 40
453:             .Visible       = .T.
454:         ENDWITH
455: 
456:         loc_oPagina.AddObject("lbl_4c_LblInterno", "Label")
457:         WITH loc_oPagina.lbl_4c_LblInterno
458:             .Caption   = "Interno :"
459:             .Left      = 456
460:             .Top       = 43
461:             .Width     = 55
462:             .Height    = 15
463:             .FontName  = "Tahoma"
464:             .FontSize  = 8
465:             .BackStyle = 0
466:             .ForeColor = RGB(90, 90, 90)
467:             .Visible   = .T.
468:         ENDWITH
469: 
470:         loc_oPagina.AddObject("txt_4c_Interno", "TextBox")
471:         WITH loc_oPagina.txt_4c_Interno
472:             .Value         = ""
473:             .Left          = 514
474:             .Top           = 38
475:             .Width         = 100
476:             .Height        = 24
477:             .FontName      = "Tahoma"
478:             .FontSize      = 8
479:             .SpecialEffect = 1
480:             .MaxLength     = 20
481:             .Visible       = .T.
482:         ENDWITH
483: 
484:         *----------------------------------------------------------------------
485:         *-- ROW 2: TpCods | Digito | Classes | DClasses | ChkLimCrds | ChkLimEsts (Top=68)
486:         *----------------------------------------------------------------------
487:         loc_oPagina.AddObject("lbl_4c_LblTpCods", "Label")
488:         WITH loc_oPagina.lbl_4c_LblTpCods
489:             .Caption   = "Tipo :"
490:             .Left      = 5
491:             .Top       = 73
492:             .Width     = 40
493:             .Height    = 15
494:             .FontName  = "Tahoma"
495:             .FontSize  = 8
496:             .BackStyle = 0

*-- Linhas 502 a 582:
502:         loc_oPagina.AddObject("opt_4c_TpCods", "OptionGroup")
503:         WITH loc_oPagina.opt_4c_TpCods
504:             .ButtonCount  = 2
505:             .Left         = 48
506:             .Top          = 68
507:             .Width        = 130
508:             .Height       = 24
509:             .BorderStyle  = 0
510:             .Value        = 1
511:             .Visible      = .T.
512:             .Buttons(1).Caption  = "Empresa"
513:             .Buttons(1).Width    = 65
514:             .Buttons(1).Left     = 0
515:             .Buttons(1).Top      = 0
516:             .Buttons(1).AutoSize = .F.
517:             .Buttons(1).ForeColor = RGB(90, 90, 90)
518:             .Buttons(1).Themes   = .F.
519:             .Buttons(2).Caption  = "C/C"
520:             .Buttons(2).Width    = 55
521:             .Buttons(2).Left     = 65
522:             .Buttons(2).Top      = 0
523:             .Buttons(2).AutoSize = .F.
524:             .Buttons(2).ForeColor = RGB(90, 90, 90)
525:             .Buttons(2).Themes   = .F.
526:         ENDWITH
527:         BINDEVENT(loc_oPagina.opt_4c_TpCods, "InteractiveChange", THIS, "opt_4c_TpCods_InteractiveChange")
528: 
529:         *-- Digito (visivel somente quando TpCods=1)
530:         loc_oPagina.AddObject("lbl_4c_LblDigito", "Label")
531:         WITH loc_oPagina.lbl_4c_LblDigito
532:             .Caption   = "D" + CHR(237) + "gito :"
533:             .Left      = 183
534:             .Top       = 73
535:             .Width     = 50
536:             .Height    = 15
537:             .FontName  = "Tahoma"
538:             .FontSize  = 8
539:             .BackStyle = 0
540:             .ForeColor = RGB(90, 90, 90)
541:             .Visible   = .T.
542:         ENDWITH
543: 
544:         loc_oPagina.AddObject("txt_4c_Digito", "TextBox")
545:         WITH loc_oPagina.txt_4c_Digito
546:             .Value         = ""
547:             .Left          = 236
548:             .Top           = 68
549:             .Width         = 25
550:             .Height        = 24
551:             .FontName      = "Tahoma"
552:             .FontSize      = 8
553:             .SpecialEffect = 1
554:             .MaxLength     = 1
555:             .Visible       = .T.
556:         ENDWITH
557: 
558:         *-- Classes (lookup SigCdCss via F4/LostFocus)
559:         loc_oPagina.AddObject("lbl_4c_LblClasses", "Label")
560:         WITH loc_oPagina.lbl_4c_LblClasses
561:             .Caption   = "Classe :"
562:             .Left      = 267
563:             .Top       = 73
564:             .Width     = 48
565:             .Height    = 15
566:             .FontName  = "Tahoma"
567:             .FontSize  = 8
568:             .BackStyle = 0
569:             .ForeColor = RGB(90, 90, 90)
570:             .Visible   = .T.
571:         ENDWITH
572: 
573:         loc_oPagina.AddObject("txt_4c_Classes", "TextBox")
574:         WITH loc_oPagina.txt_4c_Classes
575:             .Value         = ""
576:             .Left          = 318
577:             .Top           = 68
578:             .Width         = 70
579:             .Height        = 24
580:             .FontName      = "Tahoma"
581:             .FontSize      = 8
582:             .SpecialEffect = 1

*-- Linhas 590 a 738:
590:         loc_oPagina.AddObject("txt_4c_DClasses", "TextBox")
591:         WITH loc_oPagina.txt_4c_DClasses
592:             .Value         = ""
593:             .Left          = 394
594:             .Top           = 68
595:             .Width         = 185
596:             .Height        = 24
597:             .FontName      = "Tahoma"
598:             .FontSize      = 8
599:             .SpecialEffect = 1
600:             .Enabled       = .F.
601:             .Visible       = .T.
602:         ENDWITH
603: 
604:         *-- chk_4c_LimCrds - Verif. Limite Credito (chklimcrds N(1,0))
605:         loc_oPagina.AddObject("chk_4c_LimCrds", "CheckBox")
606:         WITH loc_oPagina.chk_4c_LimCrds
607:             .Caption   = "Verif. Limite Cr" + CHR(233) + "d."
608:             .Left      = 585
609:             .Top       = 68
610:             .Width     = 105
611:             .Height    = 20
612:             .FontName  = "Tahoma"
613:             .FontSize  = 8
614:             .BackStyle = 0
615:             .Visible   = .T.
616:         ENDWITH
617: 
618:         *-- chk_4c_LimEsts - Verif. Limite Estoque (chklimests N(1,0))
619:         loc_oPagina.AddObject("chk_4c_LimEsts", "CheckBox")
620:         WITH loc_oPagina.chk_4c_LimEsts
621:             .Caption   = "Verif. Limite Est."
622:             .Left      = 695
623:             .Top       = 68
624:             .Width     = 115
625:             .Height    = 20
626:             .FontName  = "Tahoma"
627:             .FontSize  = 8
628:             .BackStyle = 0
629:             .Visible   = .T.
630:         ENDWITH
631: 
632:         *----------------------------------------------------------------------
633:         *-- ROW 2B: TpEmps (visivel somente TpCods=1) e TpCads (sempre visivel)
634:         *-- TpEmps: Left=353, Top=68 | TpCads: Left=5, Top=93
635:         *----------------------------------------------------------------------
636:         loc_oPagina.AddObject("lbl_4c_TpEmps", "Label")
637:         WITH loc_oPagina.lbl_4c_TpEmps
638:             .Caption   = "Incl. Empresa :"
639:             .Left      = 353
640:             .Top       = 73
641:             .Width     = 90
642:             .Height    = 15
643:             .FontName  = "Tahoma"
644:             .FontSize  = 8
645:             .BackStyle = 0
646:             .ForeColor = RGB(90, 90, 90)
647:             .Visible   = .T.  && controlado por TpCods
648:         ENDWITH
649: 
650:         loc_oPagina.AddObject("opt_4c_TpEmps", "OptionGroup")
651:         WITH loc_oPagina.opt_4c_TpEmps
652:             .ButtonCount  = 2
653:             .Left         = 447
654:             .Top          = 68
655:             .Width        = 98
656:             .Height       = 23
657:             .BorderStyle  = 0
658:             .Value        = 1
659:             .Visible      = .T.  && controlado por TpCods
660:             .Buttons(1).Caption  = "Sim"
661:             .Buttons(1).Width    = 49
662:             .Buttons(1).Left     = 0
663:             .Buttons(1).Top      = 0
664:             .Buttons(1).AutoSize = .F.
665:             .Buttons(1).ForeColor = RGB(90, 90, 90)
666:             .Buttons(1).Themes   = .F.
667:             .Buttons(2).Caption  = "N" + CHR(227) + "o"
668:             .Buttons(2).Width    = 49
669:             .Buttons(2).Left     = 49
670:             .Buttons(2).Top      = 0
671:             .Buttons(2).AutoSize = .F.
672:             .Buttons(2).ForeColor = RGB(90, 90, 90)
673:             .Buttons(2).Themes   = .F.
674:         ENDWITH
675: 
676:         loc_oPagina.AddObject("lbl_4c_TpCads", "Label")
677:         WITH loc_oPagina.lbl_4c_TpCads
678:             .Caption   = "Tp.Cad. :"
679:             .Left      = 5
680:             .Top       = 98
681:             .Width     = 55
682:             .Height    = 15
683:             .FontName  = "Tahoma"
684:             .FontSize  = 8
685:             .BackStyle = 0
686:             .ForeColor = RGB(90, 90, 90)
687:             .Visible   = .T.
688:         ENDWITH
689: 
690:         loc_oPagina.AddObject("opt_4c_TpCads", "OptionGroup")
691:         WITH loc_oPagina.opt_4c_TpCads
692:             .ButtonCount  = 2
693:             .Left         = 63
694:             .Top          = 93
695:             .Width        = 150
696:             .Height       = 23
697:             .BorderStyle  = 0
698:             .Value        = 1
699:             .Visible      = .T.
700:             .Buttons(1).Caption  = "Empresa"
701:             .Buttons(1).Width    = 75
702:             .Buttons(1).Left     = 0
703:             .Buttons(1).Top      = 0
704:             .Buttons(1).AutoSize = .F.
705:             .Buttons(1).ForeColor = RGB(90, 90, 90)
706:             .Buttons(1).Themes   = .F.
707:             .Buttons(2).Caption  = "C/C"
708:             .Buttons(2).Width    = 75
709:             .Buttons(2).Left     = 75
710:             .Buttons(2).Top      = 0
711:             .Buttons(2).AutoSize = .F.
712:             .Buttons(2).ForeColor = RGB(90, 90, 90)
713:             .Buttons(2).Themes   = .F.
714:         ENDWITH
715: 
716:         *----------------------------------------------------------------------
717:         *-- Inner PageFrame - 4 abas (Geral, Cadastro, Estoque, Faturamento)
718:         *-- (Top=120, Left=5, Width=985, Height=447)
719:         *----------------------------------------------------------------------
720:         loc_oPagina.AddObject("pgf_4c_AbaDados", "PageFrame")
721:         WITH loc_oPagina.pgf_4c_AbaDados
722:             .Top       = 120
723:             .Left      = 5
724:             .Width     = 985
725:             .Height    = 447
726:             .PageCount = 4
727:             .Tabs      = .T.
728:             .Visible   = .T.
729: 
730:             .Page1.Caption = "Geral"
731:             .Page2.Caption = "Cadastro"
732:             .Page3.Caption = "Estoque"
733:             .Page4.Caption = "Faturamento"
734:         ENDWITH
735: 
736:         THIS.ConfigurarAbaGeral()
737:         THIS.ConfigurarAbaCadastro()
738:         THIS.ConfigurarAbaEstoque()

*-- Linhas 747 a 757:
747:     PROTECTED PROCEDURE CriarLabel(par_oParent, par_cNome, par_cCaption, par_nLeft, par_nTop, par_nWidth)
748:         par_oParent.AddObject(par_cNome, "Label")
749:         WITH par_oParent.Controls(par_oParent.ControlCount)
750:             .Caption   = par_cCaption
751:             .Left      = par_nLeft
752:             .Top       = par_nTop
753:             .Width     = par_nWidth
754:             .Height    = 15
755:             .FontName  = "Tahoma"
756:             .FontSize  = 8
757:             .BackStyle = 0

*-- Linhas 768 a 890:
768:         par_oParent.AddObject(par_cNome, "OptionGroup")
769:         WITH par_oParent.Controls(par_oParent.ControlCount)
770:             .ButtonCount  = 2
771:             .Left         = par_nLeft
772:             .Top          = par_nTop
773:             .Width        = par_nWidth
774:             .Height       = 23
775:             .FontName     = "Tahoma"
776:             .FontSize     = 8
777:             .BorderStyle  = 0
778:             .BackStyle    = 0
779:             .Value        = par_nDefault
780:             .Buttons(1).Caption  = "Sim"
781:             .Buttons(1).Width    = loc_nBtnW
782:             .Buttons(1).Left     = 0
783:             .Buttons(1).Top      = 0
784:             .Buttons(1).AutoSize = .F.
785:             .Buttons(1).ForeColor = RGB(90, 90, 90)
786:             .Buttons(1).Themes   = .F.
787:             .Buttons(2).Caption  = "N" + CHR(227) + "o"
788:             .Buttons(2).Width    = par_nWidth - loc_nBtnW
789:             .Buttons(2).Left     = loc_nBtnW
790:             .Buttons(2).Top      = 0
791:             .Buttons(2).AutoSize = .F.
792:             .Buttons(2).ForeColor = RGB(90, 90, 90)
793:             .Buttons(2).Themes   = .F.
794:         ENDWITH
795:     ENDPROC
796: 
797:     *--------------------------------------------------------------------------
798:     * CriarContainerFiscal - Helper: container com 5 campos fiscais
799:     * Estrutura: lbl_4c_TaxNome, txt_4c_CdGrupos, txt_4c_CdContas,
800:     *            txt_4c_DsContas(disabled), txt_4c_PctAliqs, txt_4c_Receitas
801:     *--------------------------------------------------------------------------
802:     PROTECTED PROCEDURE CriarContainerFiscal(par_oAba, par_cNome, par_cLabel, par_nTop)
803:         LOCAL loc_oCnt
804:         par_oAba.AddObject(par_cNome, "Container")
805:         loc_oCnt = par_oAba.Controls(par_oAba.ControlCount)
806:         WITH loc_oCnt
807:             .Top         = par_nTop
808:             .Left        = 18
809:             .Width       = 673
810:             .Height      = 25
811:             .BackStyle   = 0
812:             .BorderWidth = 0
813:         ENDWITH
814: 
815:         loc_oCnt.AddObject("lbl_4c_TaxNome", "Label")
816:         WITH loc_oCnt.lbl_4c_TaxNome
817:             .Caption   = par_cLabel
818:             .Left      = 10
819:             .Top       = 5
820:             .Width     = 55
821:             .Height    = 15
822:             .FontName  = "Tahoma"
823:             .FontSize  = 8
824:             .BackStyle = 0
825:             .ForeColor = RGB(90, 90, 90)
826:         ENDWITH
827: 
828:         loc_oCnt.AddObject("txt_4c_CdGrupos", "TextBox")
829:         WITH loc_oCnt.txt_4c_CdGrupos
830:             .Value         = ""
831:             .Left          = 66
832:             .Top           = 2
833:             .Width         = 80
834:             .Height        = 21
835:             .FontName      = "Tahoma"
836:             .FontSize      = 8
837:             .SpecialEffect = 1
838:             .MaxLength     = 20
839:         ENDWITH
840: 
841:         loc_oCnt.AddObject("txt_4c_CdContas", "TextBox")
842:         WITH loc_oCnt.txt_4c_CdContas
843:             .Value         = ""
844:             .Left          = 155
845:             .Top           = 2
846:             .Width         = 80
847:             .Height        = 21
848:             .FontName      = "Tahoma"
849:             .FontSize      = 8
850:             .SpecialEffect = 1
851:             .MaxLength     = 20
852:             .Enabled       = .F.  && When: CdGrupos nao vazio
853:         ENDWITH
854: 
855:         loc_oCnt.AddObject("txt_4c_DsContas", "TextBox")
856:         WITH loc_oCnt.txt_4c_DsContas
857:             .Value         = ""
858:             .Left          = 237
859:             .Top           = 2
860:             .Width         = 290
861:             .Height        = 21
862:             .FontName      = "Tahoma"
863:             .FontSize      = 8
864:             .SpecialEffect = 1
865:             .Enabled       = .F.  && When: CdGrupos nao vazio E CdContas vazio
866:         ENDWITH
867: 
868:         loc_oCnt.AddObject("txt_4c_PctAliqs", "TextBox")
869:         WITH loc_oCnt.txt_4c_PctAliqs
870:             .Value         = 0
871:             .Left          = 536
872:             .Top           = 2
873:             .Width         = 42
874:             .Height        = 21
875:             .FontName      = "Tahoma"
876:             .FontSize      = 8
877:             .SpecialEffect = 1
878:             .Enabled       = .F.  && When: CdGrupos e CdContas nao vazios
879:         ENDWITH
880: 
881:         loc_oCnt.AddObject("txt_4c_Receitas", "TextBox")
882:         WITH loc_oCnt.txt_4c_Receitas
883:             .Value         = ""
884:             .Left          = 588
885:             .Top           = 2
886:             .Width         = 80
887:             .Height        = 21
888:             .FontName      = "Tahoma"
889:             .FontSize      = 8
890:             .SpecialEffect = 1

*-- Linhas 912 a 1096:
912:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page1
913: 
914:         *== Coluna Esquerda (labels left~27-103, opts left=128) ==================
915:         THIS.CriarLabel(loc_oAba, "lbl_4c_GComple",   "Complemento :",                   56, 22,  74)
916:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptComple",   128, 18, 97, 2)
917: 
918:         THIS.CriarLabel(loc_oAba, "lbl_4c_GPessoais", "Dados Pessoais :",                 47, 48,  83)
919:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptPessoais",  128, 44, 97, 2)
920: 
921:         THIS.CriarLabel(loc_oAba, "lbl_4c_GRefBancs", "Ref. Banc" + CHR(225) + "rias :", 51, 74,  79)
922:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptRefBancs",  128, 70, 97, 2)
923: 
924:         THIS.CriarLabel(loc_oAba, "lbl_4c_GFollowUp", "Follow-Up :",                     74, 101, 56)
925:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptFollowUp",  128, 97, 97, 2)
926: 
927:         THIS.CriarLabel(loc_oAba, "lbl_4c_GFiscais",  "Dados Fiscais :",                 57, 127, 73)
928:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptFiscais",   128, 123, 97, 2)
929: 
930:         THIS.CriarLabel(loc_oAba, "lbl_4c_GDadosCom", "Dados Comerciais :",              37, 153, 93)
931:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptDadosCom",  128, 149, 97, 2)
932: 
933:         THIS.CriarLabel(loc_oAba, "lbl_4c_GRespos", ;
934:             "Possui Respons" + CHR(225) + "vel :",             27, 178, 103)
935:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptRespos",    128, 174, 97, 2)
936: 
937:         *-- Limite de Credito (3 botoes)
938:         THIS.CriarLabel(loc_oAba, "lbl_4c_GLimCre", ;
939:             "Limite de Cr" + CHR(233) + "dito :",              41, 202, 89)
940:         loc_oAba.AddObject("opt_4c_OptLimCre", "OptionGroup")
941:         WITH loc_oAba.opt_4c_OptLimCre
942:             .ButtonCount  = 3
943:             .Left         = 126
944:             .Top          = 197
945:             .Width        = 225
946:             .Height       = 25
947:             .BorderStyle  = 0
948:             .Value        = 1
949:             .Buttons(1).Caption  = "Sim"
950:             .Buttons(1).Width    = 70
951:             .Buttons(1).Left     = 0
952:             .Buttons(1).Top      = 0
953:             .Buttons(1).AutoSize = .F.
954:             .Buttons(1).ForeColor = RGB(90, 90, 90)
955:             .Buttons(1).Themes   = .F.
956:             .Buttons(2).Caption  = "N" + CHR(227) + "o"
957:             .Buttons(2).Width    = 70
958:             .Buttons(2).Left     = 70
959:             .Buttons(2).Top      = 0
960:             .Buttons(2).AutoSize = .F.
961:             .Buttons(2).ForeColor = RGB(90, 90, 90)
962:             .Buttons(2).Themes   = .F.
963:             .Buttons(3).Caption  = "Sim-Saldo"
964:             .Buttons(3).Width    = 85
965:             .Buttons(3).Left     = 140
966:             .Buttons(3).Top      = 0
967:             .Buttons(3).AutoSize = .F.
968:             .Buttons(3).ForeColor = RGB(90, 90, 90)
969:             .Buttons(3).Themes   = .F.
970:         ENDWITH
971: 
972:         THIS.CriarLabel(loc_oAba, "lbl_4c_GComi", ;
973:             "Comiss" + CHR(227) + "o :",                       76, 229, 54)
974:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptComi",      128, 225, 97, 2)
975: 
976:         *== Coluna Direita (labels left~411-501, opts left=533) ==================
977:         THIS.CriarLabel(loc_oAba, "lbl_4c_GEmpresa",  "Dados da Empresa :",             436, 22,  98)
978:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptEmpresa",   533, 18, 97, 2)
979: 
980:         THIS.CriarLabel(loc_oAba, "lbl_4c_GContabs", ;
981:             "Dados Cont" + CHR(225) + "beis :",               444, 48,  90)
982:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptContabs",   533, 44, 97, 2)
983: 
984:         THIS.CriarLabel(loc_oAba, "lbl_4c_GCaract", ;
985:             "Caracter" + CHR(237) + "sticas :",               454, 74,  80)
986:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptCaract",    533, 70, 97, 2)
987: 
988:         THIS.CriarLabel(loc_oAba, "lbl_4c_GPerfil",   "Perfil :",                       501, 127, 33)
989:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptPerfil",    533, 123, 97, 2)
990: 
991:         THIS.CriarLabel(loc_oAba, "lbl_4c_GCargos",   "Cargos :",                       491, 153, 43)
992:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptCargos",    533, 149, 97, 2)
993: 
994:         THIS.CriarLabel(loc_oAba, "lbl_4c_GChkLimCr", ;
995:             "Checa Limite Cr" + CHR(233) + "dito :",          427, 178, 107)
996:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptChkLimCrG", 533, 174, 97, 2)
997: 
998:         *== Extrema Direita: Grupo Padrao (Coletor, 11 botoes) ==================
999:         THIS.CriarLabel(loc_oAba, "lbl_4c_GColetor", ;
1000:             "Grupo Padr" + CHR(227) + "o :",                  706, 22,  75)
1001:         loc_oAba.AddObject("opt_4c_OptColetor", "OptionGroup")
1002:         WITH loc_oAba.opt_4c_OptColetor
1003:             .ButtonCount  = 11
1004:             .Left         = 780
1005:             .Top          = 15
1006:             .Width        = 141
1007:             .Height       = 210
1008:             .BorderStyle  = 0
1009:             .Value        = 1
1010:             .Buttons(1).Caption  = " 1"
1011:             .Buttons(1).Left     = 0
1012:             .Buttons(1).Top      = 0
1013:             .Buttons(1).AutoSize = .F.
1014:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1015:             .Buttons(1).Themes   = .F.
1016:             .Buttons(2).Caption  = " 2"
1017:             .Buttons(2).Left     = 0
1018:             .Buttons(2).Top      = 19
1019:             .Buttons(2).AutoSize = .F.
1020:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1021:             .Buttons(2).Themes   = .F.
1022:             .Buttons(3).Caption  = " 3"
1023:             .Buttons(3).Left     = 0
1024:             .Buttons(3).Top      = 38
1025:             .Buttons(3).AutoSize = .F.
1026:             .Buttons(3).ForeColor = RGB(90, 90, 90)
1027:             .Buttons(3).Themes   = .F.
1028:             .Buttons(4).Caption  = " 4"
1029:             .Buttons(4).Left     = 0
1030:             .Buttons(4).Top      = 57
1031:             .Buttons(4).AutoSize = .F.
1032:             .Buttons(4).ForeColor = RGB(90, 90, 90)
1033:             .Buttons(4).Themes   = .F.
1034:             .Buttons(5).Caption  = " 5"
1035:             .Buttons(5).Left     = 0
1036:             .Buttons(5).Top      = 76
1037:             .Buttons(5).AutoSize = .F.
1038:             .Buttons(5).ForeColor = RGB(90, 90, 90)
1039:             .Buttons(5).Themes   = .F.
1040:             .Buttons(6).Caption  = " 6"
1041:             .Buttons(6).Left     = 0
1042:             .Buttons(6).Top      = 95
1043:             .Buttons(6).AutoSize = .F.
1044:             .Buttons(6).ForeColor = RGB(90, 90, 90)
1045:             .Buttons(6).Themes   = .F.
1046:             .Buttons(7).Caption  = " 7"
1047:             .Buttons(7).Left     = 0
1048:             .Buttons(7).Top      = 114
1049:             .Buttons(7).AutoSize = .F.
1050:             .Buttons(7).ForeColor = RGB(90, 90, 90)
1051:             .Buttons(7).Themes   = .F.
1052:             .Buttons(8).Caption  = " 8"
1053:             .Buttons(8).Left     = 0
1054:             .Buttons(8).Top      = 133
1055:             .Buttons(8).AutoSize = .F.
1056:             .Buttons(8).ForeColor = RGB(90, 90, 90)
1057:             .Buttons(8).Themes   = .F.
1058:             .Buttons(9).Caption  = " 9"
1059:             .Buttons(9).Left     = 0
1060:             .Buttons(9).Top      = 152
1061:             .Buttons(9).AutoSize = .F.
1062:             .Buttons(9).ForeColor = RGB(90, 90, 90)
1063:             .Buttons(9).Themes   = .F.
1064:             .Buttons(10).Caption  = "10"
1065:             .Buttons(10).Left     = 0
1066:             .Buttons(10).Top      = 171
1067:             .Buttons(10).AutoSize = .F.
1068:             .Buttons(10).ForeColor = RGB(90, 90, 90)
1069:             .Buttons(10).Themes   = .F.
1070:             .Buttons(11).Caption  = "11"
1071:             .Buttons(11).Left     = 0
1072:             .Buttons(11).Top      = 190
1073:             .Buttons(11).AutoSize = .F.
1074:             .Buttons(11).ForeColor = RGB(90, 90, 90)
1075:             .Buttons(11).Themes   = .F.
1076:         ENDWITH
1077: 
1078:         *-- Pre Cadastro
1079:         THIS.CriarLabel(loc_oAba, "lbl_4c_GPreCad", ;
1080:             "Pr" + CHR(233) + " Cadastro :",                  709, 229, 72)
1081:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptPreCad",    780, 225, 97, 2)
1082: 
1083:         *== Secao inferior: Limite Credito Grupo/Vr/Moeda ========================
1084:         THIS.CriarLabel(loc_oAba, "lbl_4c_GLimCrGVM", ;
1085:             "Lim.Cr" + CHR(233) + "dito Grupo/Vr/Moeda :",   389, 204, 145)
1086: 
1087:         loc_oAba.AddObject("txt_4c_GrupoGeral", "TextBox")
1088:         WITH loc_oAba.txt_4c_GrupoGeral
1089:             .Value         = ""
1090:             .Left          = 536
1091:             .Top           = 199
1092:             .Width         = 97
1093:             .Height        = 23
1094:             .FontName      = "Tahoma"
1095:             .FontSize      = 8
1096:             .SpecialEffect = 1

*-- Linhas 1102 a 1126:
1102:         loc_oAba.AddObject("txt_4c_VrLimCre", "TextBox")
1103:         WITH loc_oAba.txt_4c_VrLimCre
1104:             .Value         = 0
1105:             .Left          = 636
1106:             .Top           = 199
1107:             .Width         = 110
1108:             .Height        = 23
1109:             .FontName      = "Tahoma"
1110:             .FontSize      = 8
1111:             .SpecialEffect = 1
1112:         ENDWITH
1113: 
1114:         THIS.CriarLabel(loc_oAba, "lbl_4c_GMoeda", ;
1115:             "Moeda da Comiss" + CHR(227) + "o :",             430, 229, 107)
1116: 
1117:         loc_oAba.AddObject("txt_4c_CdMoeda", "TextBox")
1118:         WITH loc_oAba.txt_4c_CdMoeda
1119:             .Value         = ""
1120:             .Left          = 536
1121:             .Top           = 225
1122:             .Width         = 32
1123:             .Height        = 23
1124:             .FontName      = "Tahoma"
1125:             .FontSize      = 8
1126:             .SpecialEffect = 1

*-- Linhas 1132 a 1159:
1132:         loc_oAba.AddObject("txt_4c_DsMoeda", "TextBox")
1133:         WITH loc_oAba.txt_4c_DsMoeda
1134:             .Value         = ""
1135:             .Left          = 570
1136:             .Top           = 225
1137:             .Width         = 130
1138:             .Height        = 23
1139:             .FontName      = "Tahoma"
1140:             .FontSize      = 8
1141:             .SpecialEffect = 1
1142:             .Enabled       = .F.
1143:         ENDWITH
1144: 
1145:         *== Rodape Relatorio Conta Corrente =====================================
1146:         THIS.CriarLabel(loc_oAba, "lbl_4c_GRodape", ;
1147:             "Rod" + CHR(225) + "p" + CHR(233) + " do Relat" + CHR(243) + ;
1148:             "rio de Conta Corrente",                          165, 263, 220)
1149: 
1150:         loc_oAba.AddObject("edt_4c_RodRelCC", "EditBox")
1151:         WITH loc_oAba.edt_4c_RodRelCC
1152:             .Value         = ""
1153:             .Left          = 165
1154:             .Top           = 280
1155:             .Width         = 788
1156:             .Height        = 117
1157:             .FontName      = "Tahoma"
1158:             .FontSize      = 8
1159:             .SpecialEffect = 1

*-- Linhas 1173 a 1552:
1173:         LOCAL loc_oAba
1174:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page2
1175: 
1176:         THIS.CriarLabel(loc_oAba, "lbl_4c_CadHeader", ;
1177:             "Cadastro de Contas",                              29, 14, 120)
1178: 
1179:         *-- CPF/CNPJ Obrigatorio (4 botoes)
1180:         THIS.CriarLabel(loc_oAba, "lbl_4c_CCpfObrig", ;
1181:             "CPF / CNPJ Obrigat" + CHR(243) + "rio :",        73, 32, 120)
1182:         loc_oAba.AddObject("opt_4c_CpfObrig", "OptionGroup")
1183:         WITH loc_oAba.opt_4c_CpfObrig
1184:             .ButtonCount  = 4
1185:             .Left         = 192
1186:             .Top          = 29
1187:             .Width        = 284
1188:             .Height       = 23
1189:             .BorderStyle  = 0
1190:             .Value        = 1
1191:             .Buttons(1).Caption  = "N" + CHR(227) + "o"
1192:             .Buttons(1).Width    = 64
1193:             .Buttons(1).Left     = 0
1194:             .Buttons(1).Top      = 0
1195:             .Buttons(1).AutoSize = .F.
1196:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1197:             .Buttons(1).Themes   = .F.
1198:             .Buttons(2).Caption  = "Sim"
1199:             .Buttons(2).Width    = 64
1200:             .Buttons(2).Left     = 64
1201:             .Buttons(2).Top      = 0
1202:             .Buttons(2).AutoSize = .F.
1203:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1204:             .Buttons(2).Themes   = .F.
1205:             .Buttons(3).Caption  = "Sim-Dupla"
1206:             .Buttons(3).Width    = 80
1207:             .Buttons(3).Left     = 128
1208:             .Buttons(3).Top      = 0
1209:             .Buttons(3).AutoSize = .F.
1210:             .Buttons(3).ForeColor = RGB(90, 90, 90)
1211:             .Buttons(3).Themes   = .F.
1212:             .Buttons(4).Caption  = "N" + CHR(227) + "o-Dupla"
1213:             .Buttons(4).Width    = 76
1214:             .Buttons(4).Left     = 208
1215:             .Buttons(4).Top      = 0
1216:             .Buttons(4).AutoSize = .F.
1217:             .Buttons(4).ForeColor = RGB(90, 90, 90)
1218:             .Buttons(4).Themes   = .F.
1219:         ENDWITH
1220: 
1221:         *-- RG/IE Obrigatorio
1222:         THIS.CriarLabel(loc_oAba, "lbl_4c_CRgObrig", ;
1223:             "RG / IE Obrigat" + CHR(243) + "rio :",           93, 53, 100)
1224:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_RgObrig",       192, 50, 115, 2)
1225: 
1226:         *-- CEP Obrigatorio (3 botoes)
1227:         THIS.CriarLabel(loc_oAba, "lbl_4c_CCepObrig", ;
1228:             "CEP Obrigat" + CHR(243) + "rio :",               108, 76, 85)
1229:         loc_oAba.AddObject("opt_4c_CepObrig", "OptionGroup")
1230:         WITH loc_oAba.opt_4c_CepObrig
1231:             .ButtonCount  = 3
1232:             .Left         = 191
1233:             .Top          = 70
1234:             .Width        = 201
1235:             .Height       = 25
1236:             .BorderStyle  = 0
1237:             .Value        = 1
1238:             .Buttons(1).Caption  = "N" + CHR(227) + "o"
1239:             .Buttons(1).Width    = 60
1240:             .Buttons(1).Left     = 0
1241:             .Buttons(1).Top      = 0
1242:             .Buttons(1).AutoSize = .F.
1243:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1244:             .Buttons(1).Themes   = .F.
1245:             .Buttons(2).Caption  = "Sim"
1246:             .Buttons(2).Width    = 60
1247:             .Buttons(2).Left     = 60
1248:             .Buttons(2).Top      = 0
1249:             .Buttons(2).AutoSize = .F.
1250:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1251:             .Buttons(2).Themes   = .F.
1252:             .Buttons(3).Caption  = "Sim-Buscar"
1253:             .Buttons(3).Width    = 81
1254:             .Buttons(3).Left     = 120
1255:             .Buttons(3).Top      = 0
1256:             .Buttons(3).AutoSize = .F.
1257:             .Buttons(3).ForeColor = RGB(90, 90, 90)
1258:             .Buttons(3).Themes   = .F.
1259:         ENDWITH
1260: 
1261:         *-- Calc.IMedias
1262:         THIS.CriarLabel(loc_oAba, "lbl_4c_CCalcIMeds", ;
1263:             "Calc. I.M" + CHR(233) + "dias :",                108, 95, 85)
1264:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_CalcIMeds",     191, 92, 97, 2)
1265: 
1266:         *-- eMail Obrigatorio
1267:         THIS.CriarLabel(loc_oAba, "lbl_4c_CObrMails", ;
1268:             "e-Mail Obrigat" + CHR(243) + "rio :",             99, 120, 94)
1269:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_ObrMails",      191, 115, 97, 2)
1270: 
1271:         *-- Nome Obrigatorio
1272:         THIS.CriarLabel(loc_oAba, "lbl_4c_CObrNome", ;
1273:             "Nome Obrigat" + CHR(243) + "rio :",              100, 141, 93)
1274:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_ObrNome",       191, 137, 97, 2)
1275: 
1276:         *-- Situacao Obrigatoria
1277:         THIS.CriarLabel(loc_oAba, "lbl_4c_CObrSit", ;
1278:             "Situa" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria :", 86, 164, 107)
1279:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_ObrSit",        191, 159, 97, 2)
1280: 
1281:         *-- Telemarketing Obrigatorio
1282:         THIS.CriarLabel(loc_oAba, "lbl_4c_CObrTlm", ;
1283:             "Telemarketing Obrigat" + CHR(243) + "rio :",      60, 186, 133)
1284:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_ObrTlm",        190, 181, 97, 2)
1285: 
1286:         *-- Classificacao Obrigatoria
1287:         THIS.CriarLabel(loc_oAba, "lbl_4c_CObrCla", ;
1288:             "Classifica" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria :", 66, 208, 127)
1289:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_ObrCla",        190, 203, 97, 2)
1290: 
1291:         *-- Segmento Obrigatorio
1292:         THIS.CriarLabel(loc_oAba, "lbl_4c_CObrSeg", ;
1293:             "Segmento Obrigat" + CHR(243) + "rio :",           79, 229, 114)
1294:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_ObrSeg",        190, 224, 97, 2)
1295: 
1296:         *-- Cod IBGE Obrigatorio
1297:         THIS.CriarLabel(loc_oAba, "lbl_4c_CObrIbge", ;
1298:             "Cod Ibge Obrigat" + CHR(243) + "rio :",           83, 249, 110)
1299:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_ObrIbge",       190, 244, 97, 2)
1300: 
1301:         *-- F.Publicidade Obrigatoria
1302:         THIS.CriarLabel(loc_oAba, "lbl_4c_CFpublSobr", ;
1303:             "F. Publicidade Obrigat" + CHR(243) + "ria :",     46, 269, 147)
1304:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_FpublSobr",     189, 264, 97, 2)
1305: 
1306:         *-- Data Nascimento Obrigatoria
1307:         THIS.CriarLabel(loc_oAba, "lbl_4c_CNascObrig", ;
1308:             "Data Nascimento Obrigat" + CHR(243) + "ria :",    46, 291, 147)
1309:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_NascObrig",     189, 286, 97, 2)
1310: 
1311:         *== Coluna Direita (opts left=686-690) ===================================
1312: 
1313:         *-- Verifica Restricao Endereco (Fwoption9, top=24)
1314:         THIS.CriarLabel(loc_oAba, "lbl_4c_CRestEnd", ;
1315:             "Verifica Restri" + CHR(231) + CHR(227) + "o de Endere" + CHR(231) + "o :", 533, 27, 155)
1316:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_RestEnd",       686, 24, 97, 2)
1317: 
1318:         *-- Conta Vinculada ao Grupo (Fwoption4, top=49)
1319:         THIS.CriarLabel(loc_oAba, "lbl_4c_CCntVinc", ;
1320:             "Conta Vinculada ao Grupo :",                      555, 52, 133)
1321:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_CntVinc",       688, 47, 115, 2)
1322: 
1323:         *-- Verifica Duplicidade Endereco (Fwoption5, top=70)
1324:         THIS.CriarLabel(loc_oAba, "lbl_4c_CDupEnd", ;
1325:             "Verifica Duplicidade de Endere" + CHR(231) + "o :", 524, 73, 164)
1326:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_DupEnd",        688, 70, 115, 2)
1327: 
1328:         *-- Mostrar Foto
1329:         THIS.CriarLabel(loc_oAba, "lbl_4c_CMFotos",   "Mostrar Foto :",             617, 93, 71)
1330:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_MFotos",        688, 90, 115, 2)
1331: 
1332:         *-- Observacao (3 botoes, height=63)
1333:         THIS.CriarLabel(loc_oAba, "lbl_4c_CObservacao", ;
1334:             "Observa" + CHR(231) + CHR(227) + "o :",          621, 115, 67)
1335:         loc_oAba.AddObject("opt_4c_Observacao", "OptionGroup")
1336:         WITH loc_oAba.opt_4c_Observacao
1337:             .ButtonCount  = 3
1338:             .Left         = 689
1339:             .Top          = 115
1340:             .Width        = 115
1341:             .Height       = 63
1342:             .BorderStyle  = 0
1343:             .Value        = 1
1344:             .Buttons(1).Caption  = "N" + CHR(227) + "o Mostrar"
1345:             .Buttons(1).Width    = 112
1346:             .Buttons(1).Left     = 0
1347:             .Buttons(1).Top      = 0
1348:             .Buttons(1).AutoSize = .F.
1349:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1350:             .Buttons(1).Themes   = .F.
1351:             .Buttons(2).Caption  = "Sempre"
1352:             .Buttons(2).Width    = 112
1353:             .Buttons(2).Left     = 0
1354:             .Buttons(2).Top      = 21
1355:             .Buttons(2).AutoSize = .F.
1356:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1357:             .Buttons(2).Themes   = .F.
1358:             .Buttons(3).Caption  = "Mostrar Bot" + CHR(227) + "o"
1359:             .Buttons(3).Width    = 112
1360:             .Buttons(3).Left     = 0
1361:             .Buttons(3).Top      = 42
1362:             .Buttons(3).AutoSize = .F.
1363:             .Buttons(3).ForeColor = RGB(90, 90, 90)
1364:             .Buttons(3).Themes   = .F.
1365:         ENDWITH
1366: 
1367:         *-- CPF/CNPJ Fixo (3 botoes)
1368:         THIS.CriarLabel(loc_oAba, "lbl_4c_CCpfFixo", ;
1369:             "CPF / CNPJ Fixo :",                              602, 167, 86)
1370:         loc_oAba.AddObject("opt_4c_CpfFixo", "OptionGroup")
1371:         WITH loc_oAba.opt_4c_CpfFixo
1372:             .ButtonCount  = 3
1373:             .Left         = 690
1374:             .Top          = 164
1375:             .Width        = 167
1376:             .Height       = 23
1377:             .BorderStyle  = 0
1378:             .Value        = 1
1379:             .Buttons(1).Caption  = "CPF"
1380:             .Buttons(1).Width    = 50
1381:             .Buttons(1).Left     = 0
1382:             .Buttons(1).Top      = 0
1383:             .Buttons(1).AutoSize = .F.
1384:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1385:             .Buttons(1).Themes   = .F.
1386:             .Buttons(2).Caption  = "CNPJ"
1387:             .Buttons(2).Width    = 50
1388:             .Buttons(2).Left     = 50
1389:             .Buttons(2).Top      = 0
1390:             .Buttons(2).AutoSize = .F.
1391:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1392:             .Buttons(2).Themes   = .F.
1393:             .Buttons(3).Caption  = "Ambos"
1394:             .Buttons(3).Width    = 67
1395:             .Buttons(3).Left     = 100
1396:             .Buttons(3).Top      = 0
1397:             .Buttons(3).AutoSize = .F.
1398:             .Buttons(3).ForeColor = RGB(90, 90, 90)
1399:             .Buttons(3).Themes   = .F.
1400:         ENDWITH
1401: 
1402:         *-- Situacao Padrao (textbox + lookup)
1403:         THIS.CriarLabel(loc_oAba, "lbl_4c_CSituacao", ;
1404:             "Situa" + CHR(231) + CHR(227) + "o Padr" + CHR(227) + "o :", 601, 189, 90)
1405:         loc_oAba.AddObject("txt_4c_Situas", "TextBox")
1406:         WITH loc_oAba.txt_4c_Situas
1407:             .Value         = ""
1408:             .Left          = 693
1409:             .Top           = 185
1410:             .Width         = 32
1411:             .Height        = 23
1412:             .FontName      = "Tahoma"
1413:             .FontSize      = 8
1414:             .SpecialEffect = 1
1415:             .MaxLength     = 10
1416:         ENDWITH
1417:         BINDEVENT(loc_oAba.txt_4c_Situas, "KeyPress",  THIS, "txt_4c_Situas_KeyPress")
1418:         BINDEVENT(loc_oAba.txt_4c_Situas, "LostFocus", THIS, "txt_4c_Situas_LostFocus")
1419: 
1420:         *-- Caracteristica Cadastro
1421:         THIS.CriarLabel(loc_oAba, "lbl_4c_CCaracCad", ;
1422:             "Caracter" + CHR(237) + "stica :",                613, 212, 75)
1423:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_CaracCad",      688, 208, 115, 2)
1424: 
1425:         *-- Acesso Job
1426:         THIS.CriarLabel(loc_oAba, "lbl_4c_CAceJob",   "Acesso Job :",               625, 233, 63)
1427:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_AceJob",        688, 229, 115, 2)
1428: 
1429:         *-- Habilita Centro de Custos Titulos
1430:         THIS.CriarLabel(loc_oAba, "lbl_4c_CCCustoTit", ;
1431:             "Habilita Centro de Custos nos T" + CHR(237) + "tulos :", 503, 254, 185)
1432:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_CCustoTit",     687, 249, 97, 2)
1433: 
1434:         *-- Log de Alteracoes
1435:         THIS.CriarLabel(loc_oAba, "lbl_4c_CLogAlt", ;
1436:             "Log de Altera" + CHR(231) + CHR(245) + "es :",  593, 276, 95)
1437:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_LogAlt",        688, 272, 115, 2)
1438: 
1439:         *-- Informar Senha na Alteracao
1440:         THIS.CriarLabel(loc_oAba, "lbl_4c_CInfSenha", ;
1441:             "Informar senha na Altera" + CHR(231) + CHR(227) + "o :", 541, 296, 147)
1442:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_InfSenha",      688, 292, 115, 2)
1443: 
1444:         *== Separador Financeiro ================================================
1445:         THIS.CriarLabel(loc_oAba, "lbl_4c_CFinHeader", "Financeiro", 29, 315, 60)
1446: 
1447:         *-- Conta Corrente Interna
1448:         THIS.CriarLabel(loc_oAba, "lbl_4c_CContint",  "Conta :",                    152, 324, 40)
1449:         loc_oAba.AddObject("txt_4c_Contint", "TextBox")
1450:         WITH loc_oAba.txt_4c_Contint
1451:             .Value         = ""
1452:             .Left          = 192
1453:             .Top           = 321
1454:             .Width         = 73
1455:             .Height        = 23
1456:             .FontName      = "Tahoma"
1457:             .FontSize      = 8
1458:             .SpecialEffect = 1
1459:             .MaxLength     = 20
1460:         ENDWITH
1461:         BINDEVENT(loc_oAba.txt_4c_Contint, "KeyPress",  THIS, "txt_4c_Contint_KeyPress")
1462:         BINDEVENT(loc_oAba.txt_4c_Contint, "LostFocus", THIS, "txt_4c_Contint_LostFocus")
1463: 
1464:         *-- Integracao Contabil (3 botoes)
1465:         THIS.CriarLabel(loc_oAba, "lbl_4c_CIntegCont", ;
1466:             "Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil :", 86, 348, 104)
1467:         loc_oAba.AddObject("opt_4c_IntegCont", "OptionGroup")
1468:         WITH loc_oAba.opt_4c_IntegCont
1469:             .ButtonCount  = 3
1470:             .Left         = 192
1471:             .Top          = 345
1472:             .Width        = 316
1473:             .Height       = 23
1474:             .BorderStyle  = 0
1475:             .Value        = 1
1476:             .Buttons(1).Caption  = "N" + CHR(227) + "o"
1477:             .Buttons(1).Width    = 80
1478:             .Buttons(1).Left     = 0
1479:             .Buttons(1).Top      = 0
1480:             .Buttons(1).AutoSize = .F.
1481:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1482:             .Buttons(1).Themes   = .F.
1483:             .Buttons(2).Caption  = "Sim"
1484:             .Buttons(2).Width    = 80
1485:             .Buttons(2).Left     = 80
1486:             .Buttons(2).Top      = 0
1487:             .Buttons(2).AutoSize = .F.
1488:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1489:             .Buttons(2).Themes   = .F.
1490:             .Buttons(3).Caption  = "Sem ContraPartida"
1491:             .Buttons(3).Width    = 156
1492:             .Buttons(3).Left     = 160
1493:             .Buttons(3).Top      = 0
1494:             .Buttons(3).AutoSize = .F.
1495:             .Buttons(3).ForeColor = RGB(90, 90, 90)
1496:             .Buttons(3).Themes   = .F.
1497:         ENDWITH
1498: 
1499:         *-- Padrao Preenchimento (4 botoes)
1500:         THIS.CriarLabel(loc_oAba, "lbl_4c_CPadPreench", ;
1501:             "Padr" + CHR(227) + "o de Preenchimento :",       58, 369, 132)
1502:         loc_oAba.AddObject("opt_4c_PadPreench", "OptionGroup")
1503:         WITH loc_oAba.opt_4c_PadPreench
1504:             .ButtonCount  = 4
1505:             .Left         = 192
1506:             .Top          = 366
1507:             .Width        = 353
1508:             .Height       = 23
1509:             .BorderStyle  = 0
1510:             .Value        = 1
1511:             .Buttons(1).Caption  = "Nenhum"
1512:             .Buttons(1).Width    = 70
1513:             .Buttons(1).Left     = 0
1514:             .Buttons(1).Top      = 0
1515:             .Buttons(1).AutoSize = .F.
1516:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1517:             .Buttons(1).Themes   = .F.
1518:             .Buttons(2).Caption  = "Pagamentos"
1519:             .Buttons(2).Width    = 90
1520:             .Buttons(2).Left     = 70
1521:             .Buttons(2).Top      = 0
1522:             .Buttons(2).AutoSize = .F.
1523:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1524:             .Buttons(2).Themes   = .F.
1525:             .Buttons(3).Caption  = "Recebimentos"
1526:             .Buttons(3).Width    = 100
1527:             .Buttons(3).Left     = 160
1528:             .Buttons(3).Top      = 0
1529:             .Buttons(3).AutoSize = .F.
1530:             .Buttons(3).ForeColor = RGB(90, 90, 90)
1531:             .Buttons(3).Themes   = .F.
1532:             .Buttons(4).Caption  = "Ambos"
1533:             .Buttons(4).Width    = 93
1534:             .Buttons(4).Left     = 260
1535:             .Buttons(4).Top      = 0
1536:             .Buttons(4).AutoSize = .F.
1537:             .Buttons(4).ForeColor = RGB(90, 90, 90)
1538:             .Buttons(4).Themes   = .F.
1539:         ENDWITH
1540: 
1541:         *-- Vincula Contas no Pag/Rec
1542:         THIS.CriarLabel(loc_oAba, "lbl_4c_CVincContas", ;
1543:             "Vincula as Contas no Pag/Rec.:",                  38, 390, 152)
1544:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_VincContas",    192, 387, 181, 2)
1545: 
1546:         *-- Visualizar Titulos nao Baixados
1547:         THIS.CriarLabel(loc_oAba, "lbl_4c_CTitBaixado", ;
1548:             "Visualizar T" + CHR(237) + "tulos n" + CHR(227) + "o Baixados :", 36, 410, 154)
1549:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_TitBaixado",    192, 407, 181, 2)
1550:     ENDPROC
1551: 
1552:     *--------------------------------------------------------------------------

*-- Linhas 1559 a 1827:
1559:         LOCAL loc_oAba
1560:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page3
1561: 
1562:         THIS.CriarLabel(loc_oAba, "lbl_4c_EEstHeader", "Estoque", 21, 14, 47)
1563: 
1564:         *== Coluna Esquerda: Limite/Avalia/ProdAcabado/ChkLimEst/CCusto =========
1565:         THIS.CriarLabel(loc_oAba, "lbl_4c_ELimEsto", ;
1566:             "Limite de Estoque :",                             85, 35, 93)
1567:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptLimEsto",    174, 30, 92, 2)
1568: 
1569:         THIS.CriarLabel(loc_oAba, "lbl_4c_EVerEst",   "Avalia Estoque :",            99, 60, 80)
1570:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptVerEst",     174, 56, 92, 2)
1571: 
1572:         THIS.CriarLabel(loc_oAba, "lbl_4c_EEstPAcab", ;
1573:             "Estoque Produto Acabado :",                       45, 84, 134)
1574:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptEstPAcab",   174, 80, 92, 2)
1575: 
1576:         THIS.CriarLabel(loc_oAba, "lbl_4c_EChkLimEst", ;
1577:             "Checa Limite de Estoque:",                        55, 109, 124)
1578:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptChkLimEst",  174, 104, 92, 2)
1579: 
1580:         THIS.CriarLabel(loc_oAba, "lbl_4c_ECCusto",   "Centro de Custos :",          86, 132, 93)
1581:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptCCustoEst",  174, 128, 92, 2)
1582: 
1583:         *== Coluna Direita: Saldo/Relevante/BlqConGV/Patrim/TipoInvs ===========
1584:         THIS.CriarLabel(loc_oAba, "lbl_4c_ESaldo", ;
1585:             "C" + CHR(225) + "lculo de Saldo :",              386, 35, 87)
1586:         loc_oAba.AddObject("opt_4c_OptSaldo", "OptionGroup")
1587:         WITH loc_oAba.opt_4c_OptSaldo
1588:             .ButtonCount  = 2
1589:             .Left         = 469
1590:             .Top          = 30
1591:             .Width        = 149
1592:             .Height       = 25
1593:             .BorderStyle  = 0
1594:             .Value        = 1
1595:             .Buttons(1).Caption  = "Online"
1596:             .Buttons(1).Width    = 70
1597:             .Buttons(1).Left     = 0
1598:             .Buttons(1).Top      = 0
1599:             .Buttons(1).AutoSize = .F.
1600:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1601:             .Buttons(1).Themes   = .F.
1602:             .Buttons(2).Caption  = "Background"
1603:             .Buttons(2).Width    = 79
1604:             .Buttons(2).Left     = 70
1605:             .Buttons(2).Top      = 0
1606:             .Buttons(2).AutoSize = .F.
1607:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1608:             .Buttons(2).Themes   = .F.
1609:         ENDWITH
1610: 
1611:         THIS.CriarLabel(loc_oAba, "lbl_4c_ERelevante", ;
1612:             "Empresa Relevante :",                            370, 60, 102)
1613:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptRelevante",  469, 56, 113, 2)
1614: 
1615:         THIS.CriarLabel(loc_oAba, "lbl_4c_EBlqConGV", ;
1616:             "Bloqueia Consulta Vendas :",                     342, 85, 132)
1617:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptBlqConGV",   469, 80, 113, 2)
1618: 
1619:         THIS.CriarLabel(loc_oAba, "lbl_4c_EPatrim", ;
1620:             "Patrimonial por Etiqueta :",                     351, 109, 123)
1621:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptPatrim",     469, 104, 113, 2)
1622: 
1623:         THIS.CriarLabel(loc_oAba, "lbl_4c_EInvTipo", ;
1624:             "Invent" + CHR(225) + "rio :",                   415, 132, 55)
1625:         loc_oAba.AddObject("opt_4c_OpTipoInvs", "OptionGroup")
1626:         WITH loc_oAba.opt_4c_OpTipoInvs
1627:             .ButtonCount  = 3
1628:             .Left         = 470
1629:             .Top          = 128
1630:             .Width        = 371
1631:             .Height       = 25
1632:             .BorderStyle  = 0
1633:             .Value        = 1
1634:             .Buttons(1).Caption  = "Pr" + CHR(243) + "prio"
1635:             .Buttons(1).Width    = 100
1636:             .Buttons(1).Left     = 0
1637:             .Buttons(1).Top      = 0
1638:             .Buttons(1).AutoSize = .F.
1639:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1640:             .Buttons(1).Themes   = .F.
1641:             .Buttons(2).Caption  = "Pr" + CHR(243) + "prio Poder 3p"
1642:             .Buttons(2).Width    = 135
1643:             .Buttons(2).Left     = 100
1644:             .Buttons(2).Top      = 0
1645:             .Buttons(2).AutoSize = .F.
1646:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1647:             .Buttons(2).Themes   = .F.
1648:             .Buttons(3).Caption  = "Nos Meios 3p"
1649:             .Buttons(3).Width    = 136
1650:             .Buttons(3).Left     = 235
1651:             .Buttons(3).Top      = 0
1652:             .Buttons(3).AutoSize = .F.
1653:             .Buttons(3).ForeColor = RGB(90, 90, 90)
1654:             .Buttons(3).Themes   = .F.
1655:         ENDWITH
1656: 
1657:         *== DDR/DDF (far right) =================================================
1658:         THIS.CriarLabel(loc_oAba, "lbl_4c_EDdR", ;
1659:             "Dias Bloqueio Retroativo :",                     723, 37, 127)
1660:         loc_oAba.AddObject("txt_4c_DdR", "TextBox")
1661:         WITH loc_oAba.txt_4c_DdR
1662:             .Value         = 0
1663:             .Left          = 852
1664:             .Top           = 33
1665:             .Width         = 45
1666:             .Height        = 23
1667:             .FontName      = "Tahoma"
1668:             .FontSize      = 8
1669:             .SpecialEffect = 1
1670:         ENDWITH
1671: 
1672:         THIS.CriarLabel(loc_oAba, "lbl_4c_EDdF", ;
1673:             "Dias Bloqueio Futuro :",                        742, 61, 112)
1674:         loc_oAba.AddObject("txt_4c_DdF", "TextBox")
1675:         WITH loc_oAba.txt_4c_DdF
1676:             .Value         = 0
1677:             .Left          = 852
1678:             .Top           = 57
1679:             .Width         = 45
1680:             .Height        = 23
1681:             .FontName      = "Tahoma"
1682:             .FontSize      = 8
1683:             .SpecialEffect = 1
1684:         ENDWITH
1685: 
1686:         *== Separador Industria ==================================================
1687:         THIS.CriarLabel(loc_oAba, "lbl_4c_EIndHeader", ;
1688:             "Ind" + CHR(250) + "stria",                       21, 174, 54)
1689: 
1690:         *== Balanco Fabrica + DifPeso + Sinal + Tfalhas ==========================
1691:         THIS.CriarLabel(loc_oAba, "lbl_4c_EGBals", ;
1692:             "Balan" + CHR(231) + "o F" + CHR(225) + "brica :", 93, 199, 84)
1693:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptGBals",      174, 194, 92, 2)
1694: 
1695:         THIS.CriarLabel(loc_oAba, "lbl_4c_EDifPeso", ;
1696:             "Diferen" + CHR(231) + "a de Peso :",            378, 199, 95)
1697:         loc_oAba.AddObject("txt_4c_DifPeso", "TextBox")
1698:         WITH loc_oAba.txt_4c_DifPeso
1699:             .Value         = 0
1700:             .Left          = 480
1701:             .Top           = 194
1702:             .Width         = 68
1703:             .Height        = 24
1704:             .FontName      = "Tahoma"
1705:             .FontSize      = 8
1706:             .SpecialEffect = 1
1707:         ENDWITH
1708: 
1709:         loc_oAba.AddObject("cmb_4c_Sinal", "ComboBox")
1710:         WITH loc_oAba.cmb_4c_Sinal
1711:             .RowSourceType = 1
1712:             .RowSource     = "+,-,P,Q"
1713:             .Style         = 2
1714:             .Left          = 550
1715:             .Top           = 194
1716:             .Width         = 48
1717:             .Height        = 24
1718:             .FontName      = "Tahoma"
1719:             .FontSize      = 8
1720:             .Value         = "+"
1721:         ENDWITH
1722: 
1723:         THIS.CriarLabel(loc_oAba, "lbl_4c_ETfalhasPQ", "( P/Q )", 621, 199, 40)
1724:         loc_oAba.AddObject("txt_4c_Tfalhas", "TextBox")
1725:         WITH loc_oAba.txt_4c_Tfalhas
1726:             .Value         = ""
1727:             .Left          = 601
1728:             .Top           = 194
1729:             .Width         = 17
1730:             .Height        = 24
1731:             .FontName      = "Tahoma"
1732:             .FontSize      = 8
1733:             .SpecialEffect = 1
1734:             .MaxLength     = 1
1735:         ENDWITH
1736: 
1737:         *== Grupo Dif. Balanco + Transfere Peso ==================================
1738:         THIS.CriarLabel(loc_oAba, "lbl_4c_EGrupDif", ;
1739:             "Grupo Dif. Balan" + CHR(231) + "o :",            78, 224, 98)
1740:         loc_oAba.AddObject("txt_4c_GrupoEst", "TextBox")
1741:         WITH loc_oAba.txt_4c_GrupoEst
1742:             .Value         = ""
1743:             .Left          = 179
1744:             .Top           = 219
1745:             .Width         = 90
1746:             .Height        = 23
1747:             .FontName      = "Tahoma"
1748:             .FontSize      = 8
1749:             .SpecialEffect = 1
1750:             .MaxLength     = 20
1751:         ENDWITH
1752:         BINDEVENT(loc_oAba.txt_4c_GrupoEst, "KeyPress",  THIS, "txt_4c_GrupoEst_KeyPress")
1753:         BINDEVENT(loc_oAba.txt_4c_GrupoEst, "LostFocus", THIS, "txt_4c_GrupoEst_LostFocus")
1754: 
1755:         *-- Transfere Peso (5 botoes)
1756:         THIS.CriarLabel(loc_oAba, "lbl_4c_ETrfPeso",  "Transfere Peso :",            395, 219, 82)
1757:         loc_oAba.AddObject("opt_4c_ChkTrfPeso", "OptionGroup")
1758:         WITH loc_oAba.opt_4c_ChkTrfPeso
1759:             .ButtonCount  = 5
1760:             .Left         = 474
1761:             .Top          = 219
1762:             .Width        = 186
1763:             .Height       = 95
1764:             .BorderStyle  = 0
1765:             .Value        = 1
1766:             .Buttons(1).Caption  = "1"
1767:             .Buttons(1).Left     = 0
1768:             .Buttons(1).Top      = 0
1769:             .Buttons(1).AutoSize = .F.
1770:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1771:             .Buttons(1).Themes   = .F.
1772:             .Buttons(2).Caption  = "2"
1773:             .Buttons(2).Left     = 0
1774:             .Buttons(2).Top      = 19
1775:             .Buttons(2).AutoSize = .F.
1776:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1777:             .Buttons(2).Themes   = .F.
1778:             .Buttons(3).Caption  = "3"
1779:             .Buttons(3).Left     = 0
1780:             .Buttons(3).Top      = 38
1781:             .Buttons(3).AutoSize = .F.
1782:             .Buttons(3).ForeColor = RGB(90, 90, 90)
1783:             .Buttons(3).Themes   = .F.
1784:             .Buttons(4).Caption  = "4"
1785:             .Buttons(4).Left     = 0
1786:             .Buttons(4).Top      = 57
1787:             .Buttons(4).AutoSize = .F.
1788:             .Buttons(4).ForeColor = RGB(90, 90, 90)
1789:             .Buttons(4).Themes   = .F.
1790:             .Buttons(5).Caption  = "5"
1791:             .Buttons(5).Left     = 0
1792:             .Buttons(5).Top      = 76
1793:             .Buttons(5).AutoSize = .F.
1794:             .Buttons(5).ForeColor = RGB(90, 90, 90)
1795:             .Buttons(5).Themes   = .F.
1796:         ENDWITH
1797: 
1798:         *== Grupo/Conta Falha ====================================================
1799:         THIS.CriarLabel(loc_oAba, "lbl_4c_EGrupoFalha", ;
1800:             "Grupo de Falha :",                              721, 199, 82)
1801:         loc_oAba.AddObject("txt_4c_GrupoFalha", "TextBox")
1802:         WITH loc_oAba.txt_4c_GrupoFalha
1803:             .Value         = ""
1804:             .Left          = 805
1805:             .Top           = 195
1806:             .Width         = 90
1807:             .Height        = 23
1808:             .FontName      = "Tahoma"
1809:             .FontSize      = 8
1810:             .SpecialEffect = 1
1811:             .MaxLength     = 20
1812:         ENDWITH
1813:         BINDEVENT(loc_oAba.txt_4c_GrupoFalha, "KeyPress",  THIS, "txt_4c_GrupoFalha_KeyPress")
1814:         BINDEVENT(loc_oAba.txt_4c_GrupoFalha, "LostFocus", THIS, "txt_4c_GrupoFalha_LostFocus")
1815: 
1816:         THIS.CriarLabel(loc_oAba, "lbl_4c_EContaFalha", ;
1817:             "Conta de Falha :",                              721, 224, 82)
1818:         loc_oAba.AddObject("txt_4c_ContaFalha", "TextBox")
1819:         WITH loc_oAba.txt_4c_ContaFalha
1820:             .Value         = ""
1821:             .Left          = 805
1822:             .Top           = 220
1823:             .Width         = 90
1824:             .Height        = 23
1825:             .FontName      = "Tahoma"
1826:             .FontSize      = 8
1827:             .SpecialEffect = 1

*-- Linhas 1833 a 1900:
1833:         loc_oAba.AddObject("txt_4c_DsContaFalha", "TextBox")
1834:         WITH loc_oAba.txt_4c_DsContaFalha
1835:             .Value         = ""
1836:             .Left          = 897
1837:             .Top           = 220
1838:             .Width         = 59
1839:             .Height        = 23
1840:             .FontName      = "Tahoma"
1841:             .FontSize      = 8
1842:             .SpecialEffect = 1
1843:             .Enabled       = .F.
1844:         ENDWITH
1845: 
1846:         *== Balanco Unificado (4 botoes) =========================================
1847:         THIS.CriarLabel(loc_oAba, "lbl_4c_EUnifBal", ;
1848:             "Balan" + CHR(231) + "o Unificado :",             83, 249, 93)
1849:         loc_oAba.AddObject("opt_4c_OptUnifBal", "OptionGroup")
1850:         WITH loc_oAba.opt_4c_OptUnifBal
1851:             .ButtonCount  = 4
1852:             .Left         = 174
1853:             .Top          = 245
1854:             .Width        = 171
1855:             .Height       = 43
1856:             .BorderStyle  = 0
1857:             .Value        = 1
1858:             .Buttons(1).Caption  = "N" + CHR(227) + "o"
1859:             .Buttons(1).Width    = 42
1860:             .Buttons(1).Left     = 0
1861:             .Buttons(1).Top      = 0
1862:             .Buttons(1).AutoSize = .F.
1863:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1864:             .Buttons(1).Themes   = .F.
1865:             .Buttons(2).Caption  = "Sim"
1866:             .Buttons(2).Width    = 42
1867:             .Buttons(2).Left     = 42
1868:             .Buttons(2).Top      = 0
1869:             .Buttons(2).AutoSize = .F.
1870:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1871:             .Buttons(2).Themes   = .F.
1872:             .Buttons(3).Caption  = "Parcial"
1873:             .Buttons(3).Width    = 43
1874:             .Buttons(3).Left     = 84
1875:             .Buttons(3).Top      = 0
1876:             .Buttons(3).AutoSize = .F.
1877:             .Buttons(3).ForeColor = RGB(90, 90, 90)
1878:             .Buttons(3).Themes   = .F.
1879:             .Buttons(4).Caption  = "Total"
1880:             .Buttons(4).Width    = 44
1881:             .Buttons(4).Left     = 127
1882:             .Buttons(4).Top      = 0
1883:             .Buttons(4).AutoSize = .F.
1884:             .Buttons(4).ForeColor = RGB(90, 90, 90)
1885:             .Buttons(4).Themes   = .F.
1886:         ENDWITH
1887: 
1888:         *== Conta Padrao =========================================================
1889:         THIS.CriarLabel(loc_oAba, "lbl_4c_EContaPdr", ;
1890:             "Conta Padr" + CHR(227) + "o :",                 728, 250, 75)
1891:         loc_oAba.AddObject("txt_4c_ContaPdr", "TextBox")
1892:         WITH loc_oAba.txt_4c_ContaPdr
1893:             .Value         = ""
1894:             .Left          = 805
1895:             .Top           = 246
1896:             .Width         = 90
1897:             .Height        = 23
1898:             .FontName      = "Tahoma"
1899:             .FontSize      = 8
1900:             .SpecialEffect = 1

*-- Linhas 1906 a 2087:
1906:         loc_oAba.AddObject("txt_4c_DsContaPdr", "TextBox")
1907:         WITH loc_oAba.txt_4c_DsContaPdr
1908:             .Value         = ""
1909:             .Left          = 896
1910:             .Top           = 246
1911:             .Width         = 59
1912:             .Height        = 23
1913:             .FontName      = "Tahoma"
1914:             .FontSize      = 8
1915:             .SpecialEffect = 1
1916:             .Enabled       = .F.
1917:         ENDWITH
1918: 
1919:         *== Balanco Falhas/Perdas ================================================
1920:         THIS.CriarLabel(loc_oAba, "lbl_4c_EFalPers", ;
1921:             "Balan" + CHR(231) + "o Falhas/Perdas :",         61, 293, 117)
1922:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptFalPers",    174, 288, 92, 2)
1923: 
1924:         *== Bloqueia Divisao OF ==================================================
1925:         THIS.CriarLabel(loc_oAba, "lbl_4c_EBlqDivOp", ;
1926:             "Bloqueia Divis" + CHR(227) + "o de OF :",        59, 318, 118)
1927:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptBlqDivOp",   174, 314, 92, 2)
1928: 
1929:         *== Container Resumo de Composicao (Os/Alianca/Fundicao) ================
1930:         loc_oAba.AddObject("cnt_4c_OsAlFuns", "Container")
1931:         WITH loc_oAba.cnt_4c_OsAlFuns
1932:             .Top         = 311
1933:             .Left        = 324
1934:             .Width       = 347
1935:             .Height      = 27
1936:             .BackStyle   = 0
1937:             .BorderWidth = 0
1938:             .Visible     = .T.
1939:         ENDWITH
1940: 
1941:         loc_oAba.cnt_4c_OsAlFuns.AddObject("lbl_4c_ResComp", "Label")
1942:         WITH loc_oAba.cnt_4c_OsAlFuns.lbl_4c_ResComp
1943:             .Caption   = "Resumo de Composi" + CHR(231) + CHR(227) + "o :"
1944:             .Left      = 30
1945:             .Top       = 6
1946:             .Width     = 122
1947:             .Height    = 15
1948:             .FontName  = "Tahoma"
1949:             .FontSize  = 8
1950:             .BackStyle = 0
1951:             .ForeColor = RGB(90, 90, 90)
1952:         ENDWITH
1953: 
1954:         loc_oAba.cnt_4c_OsAlFuns.AddObject("chk_4c_CheckOs", "CheckBox")
1955:         WITH loc_oAba.cnt_4c_OsAlFuns.chk_4c_CheckOs
1956:             .Caption   = "Os"
1957:             .Left      = 158
1958:             .Top       = 4
1959:             .Width     = 31
1960:             .Height    = 17
1961:             .FontName  = "Tahoma"
1962:             .FontSize  = 8
1963:             .BackStyle = 0
1964:             .Value     = 0
1965:         ENDWITH
1966: 
1967:         loc_oAba.cnt_4c_OsAlFuns.AddObject("chk_4c_CheckAlianca", "CheckBox")
1968:         WITH loc_oAba.cnt_4c_OsAlFuns.chk_4c_CheckAlianca
1969:             .Caption   = "Alian" + CHR(231) + "a"
1970:             .Left      = 199
1971:             .Top       = 4
1972:             .Width     = 52
1973:             .Height    = 17
1974:             .FontName  = "Tahoma"
1975:             .FontSize  = 8
1976:             .BackStyle = 0
1977:             .Value     = 0
1978:         ENDWITH
1979: 
1980:         loc_oAba.cnt_4c_OsAlFuns.AddObject("chk_4c_CheckFundicao", "CheckBox")
1981:         WITH loc_oAba.cnt_4c_OsAlFuns.chk_4c_CheckFundicao
1982:             .Caption   = "Fundi" + CHR(231) + CHR(227) + "o"
1983:             .Left      = 266
1984:             .Top       = 4
1985:             .Width     = 61
1986:             .Height    = 17
1987:             .FontName  = "Tahoma"
1988:             .FontSize  = 8
1989:             .BackStyle = 0
1990:             .Value     = 0
1991:         ENDWITH
1992: 
1993:         *== OsPend - Prazo de Entrega =============================================
1994:         THIS.CriarLabel(loc_oAba, "lbl_4c_EOsPend", ;
1995:             "OS Pendente Dt.Entrega :",                        49, 343, 128)
1996:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_GetOsPend",     174, 338, 92, 2)
1997: 
1998:         *== Agrupa Componentes (3 botoes) ========================================
1999:         THIS.CriarLabel(loc_oAba, "lbl_4c_ECompagru", ;
2000:             "Agrupa Componentes :",                           364, 341, 109)
2001:         loc_oAba.AddObject("opt_4c_OpCompagru", "OptionGroup")
2002:         WITH loc_oAba.opt_4c_OpCompagru
2003:             .ButtonCount  = 3
2004:             .Left         = 474
2005:             .Top          = 340
2006:             .Width        = 186
2007:             .Height       = 21
2008:             .BorderStyle  = 0
2009:             .Value        = 1
2010:             .Buttons(1).Caption  = "Sim"
2011:             .Buttons(1).Width    = 55
2012:             .Buttons(1).Left     = 0
2013:             .Buttons(1).Top      = 0
2014:             .Buttons(1).AutoSize = .F.
2015:             .Buttons(1).ForeColor = RGB(90, 90, 90)
2016:             .Buttons(1).Themes   = .F.
2017:             .Buttons(2).Caption  = "N" + CHR(227) + "o"
2018:             .Buttons(2).Width    = 55
2019:             .Buttons(2).Left     = 55
2020:             .Buttons(2).Top      = 0
2021:             .Buttons(2).AutoSize = .F.
2022:             .Buttons(2).ForeColor = RGB(90, 90, 90)
2023:             .Buttons(2).Themes   = .F.
2024:             .Buttons(3).Caption  = "Mat. Principal"
2025:             .Buttons(3).Width    = 76
2026:             .Buttons(3).Left     = 110
2027:             .Buttons(3).Top      = 0
2028:             .Buttons(3).AutoSize = .F.
2029:             .Buttons(3).ForeColor = RGB(90, 90, 90)
2030:             .Buttons(3).Themes   = .F.
2031:         ENDWITH
2032: 
2033:         *== Checa Duplicidade de Titulo ==========================================
2034:         THIS.CriarLabel(loc_oAba, "lbl_4c_EObjDupTit", ;
2035:             "Checa Duplicidade de T" + CHR(237) + "tulo:",    41, 369, 137)
2036:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_ObjDupTit",     174, 364, 92, 2)
2037: 
2038:         *== Agrupamento ==========================================================
2039:         THIS.CriarLabel(loc_oAba, "lbl_4c_EAgrupa",   "Agrupamento:",               406, 369, 75)
2040:         loc_oAba.AddObject("txt_4c_GetAgrupa", "TextBox")
2041:         WITH loc_oAba.txt_4c_GetAgrupa
2042:             .Value         = ""
2043:             .Left          = 480
2044:             .Top           = 365
2045:             .Width         = 150
2046:             .Height        = 23
2047:             .FontName      = "Tahoma"
2048:             .FontSize      = 8
2049:             .SpecialEffect = 1
2050:             .MaxLength     = 20
2051:         ENDWITH
2052: 
2053:         *== Controle de Lote (3 botoes) ==========================================
2054:         THIS.CriarLabel(loc_oAba, "lbl_4c_ECtrlLote", ;
2055:             "Controle de Lote :",                             388, 396, 88)
2056:         loc_oAba.AddObject("opt_4c_CtrlLotes", "OptionGroup")
2057:         WITH loc_oAba.opt_4c_CtrlLotes
2058:             .ButtonCount  = 3
2059:             .Left         = 474
2060:             .Top          = 393
2061:             .Width        = 164
2062:             .Height       = 21
2063:             .BorderStyle  = 0
2064:             .Value        = 1
2065:             .Buttons(1).Caption  = "Sim"
2066:             .Buttons(1).Width    = 48
2067:             .Buttons(1).Left     = 0
2068:             .Buttons(1).Top      = 0
2069:             .Buttons(1).AutoSize = .F.
2070:             .Buttons(1).ForeColor = RGB(90, 90, 90)
2071:             .Buttons(1).Themes   = .F.
2072:             .Buttons(2).Caption  = "N" + CHR(227) + "o"
2073:             .Buttons(2).Width    = 48
2074:             .Buttons(2).Left     = 48
2075:             .Buttons(2).Top      = 0
2076:             .Buttons(2).AutoSize = .F.
2077:             .Buttons(2).ForeColor = RGB(90, 90, 90)
2078:             .Buttons(2).Themes   = .F.
2079:             .Buttons(3).Caption  = "M" + CHR(250) + "ltiplos"
2080:             .Buttons(3).Width    = 68
2081:             .Buttons(3).Left     = 96
2082:             .Buttons(3).Top      = 0
2083:             .Buttons(3).AutoSize = .F.
2084:             .Buttons(3).ForeColor = RGB(90, 90, 90)
2085:             .Buttons(3).Themes   = .F.
2086:         ENDWITH
2087:     ENDPROC

*-- Linhas 2096 a 2110:
2096:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page4
2097: 
2098:         *-- Headers
2099:         THIS.CriarLabel(loc_oAba, "lbl_4c_FImposto",  "Impostos",                    22, 33, 60)
2100:         THIS.CriarLabel(loc_oAba, "lbl_4c_FGrupo",    "Grupo",                       104, 33, 40)
2101:         THIS.CriarLabel(loc_oAba, "lbl_4c_FConta", ;
2102:             "Conta e Descri" + CHR(231) + CHR(227) + "o",    301, 33, 120)
2103:         THIS.CriarLabel(loc_oAba, "lbl_4c_FAliqs", ;
2104:             "Al" + CHR(237) + "quota",                        552, 33, 50)
2105:         THIS.CriarLabel(loc_oAba, "lbl_4c_FReceita",  "Receita",                     623, 33, 50)
2106: 
2107:         *-- 9 containers fiscais (mesma estrutura, tops sequenciais)
2108:         THIS.CriarContainerFiscal(loc_oAba, "cnt_4c_ICMS", "ICMS",   52)
2109:         THIS.CriarContainerFiscal(loc_oAba, "cnt_4c_IPI",  "IPI",    78)
2110:         THIS.CriarContainerFiscal(loc_oAba, "cnt_4c_II",   "II",    104)

*-- Linhas 2144 a 2156:
2144:                 loc_oGrid.Column4.Width = 60
2145:                 loc_oGrid.Column5.Width = 300
2146: 
2147:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
2148:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2149:                 loc_oGrid.Column3.Header1.Caption = "Interno"
2150:                 loc_oGrid.Column4.Header1.Caption = "Tipo"
2151:                 loc_oGrid.Column5.Header1.Caption = "Classe"
2152: 
2153:                 THIS.FormatarGridLista(loc_oGrid)
2154:                 loc_lResultado = .T.
2155:             ENDIF
2156: 

*-- Linhas 2183 a 2191:
2183:         loc_oBO.this_cDigito  = ALLTRIM(loc_oPag2.txt_4c_Digito.Value)
2184:         loc_oBO.this_cClasses = ALLTRIM(loc_oPag2.txt_4c_Classes.Value)
2185: 
2186:         *-- ChkLimCrds (CheckBox 1=checked -> this_nOptChkLimCr=1/Sim, 0=this_nOptChkLimCr=2/Nao)
2187:         loc_oBO.this_nOptChkLimCr  = IIF(loc_oPag2.chk_4c_LimCrds.Value = 1, 1, 2)
2188:         loc_oBO.this_nOptChkLimEst = IIF(loc_oPag2.chk_4c_LimEsts.Value = 1, 1, 2)
2189: 
2190:         LOCAL loc_oG, loc_oC, loc_oE, loc_oF
2191:         loc_oG = loc_oPag2.pgf_4c_AbaDados.Page1

*-- Linhas 2353 a 2362:
2353: 
2354:         *-- Visibilidade de Digito e TpEmps: controlada por TpCods=1
2355:         loc_oPag2.txt_4c_Digito.Visible    = (loc_oBO.this_nTpCods = 1)
2356:         loc_oPag2.lbl_4c_LblDigito.Visible = (loc_oBO.this_nTpCods = 1)
2357:         loc_oPag2.lbl_4c_TpEmps.Visible    = (loc_oBO.this_nTpCods = 1)
2358:         loc_oPag2.opt_4c_TpEmps.Visible    = (loc_oBO.this_nTpCods = 1)
2359:         loc_oPag2.opt_4c_TpEmps.Enabled    = (loc_oBO.this_nTpCods = 1)
2360: 
2361:         *-- ChkLimCrds/ChkLimEsts
2362:         loc_oPag2.chk_4c_LimCrds.Value = IIF(loc_oBO.this_nOptChkLimCr  = 1, 1, 0)

*-- Linhas 2543 a 2552:
2543: 
2544:         *-- Resetar visibilidade Digito e TpEmps (padrao TpCods=1 = Empresa)
2545:         loc_oPag2.txt_4c_Digito.Visible    = .T.
2546:         loc_oPag2.lbl_4c_LblDigito.Visible = .T.
2547:         loc_oPag2.lbl_4c_TpEmps.Visible    = .T.
2548:         loc_oPag2.opt_4c_TpEmps.Visible    = .T.
2549:         loc_oPag2.opt_4c_TpEmps.Enabled    = .T.
2550: 
2551:         THIS.this_cUltClasses = ""
2552: 

*-- Linhas 2928 a 2942:
2928:         loc_lEmpresa = (THIS.pgf_4c_Paginas.Page2.opt_4c_TpCods.Value = 1)
2929: 
2930:         THIS.pgf_4c_Paginas.Page2.txt_4c_Digito.Visible    = loc_lEmpresa
2931:         THIS.pgf_4c_Paginas.Page2.lbl_4c_LblDigito.Visible = loc_lEmpresa
2932: 
2933:         IF !loc_lEmpresa
2934:             THIS.pgf_4c_Paginas.Page2.txt_4c_Digito.Value = ""
2935:             THIS.pgf_4c_Paginas.Page2.opt_4c_TpEmps.Value = 2
2936:         ENDIF
2937:         THIS.pgf_4c_Paginas.Page2.lbl_4c_TpEmps.Visible = loc_lEmpresa
2938:         THIS.pgf_4c_Paginas.Page2.opt_4c_TpEmps.Visible = loc_lEmpresa
2939:         THIS.pgf_4c_Paginas.Page2.opt_4c_TpEmps.Enabled = loc_lEmpresa
2940:     ENDPROC
2941: 
2942:     *==========================================================================

