# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 218: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 240: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 263: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 286: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 309: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 350: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 434: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 456: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormPrm.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1830 linhas total):

*-- Linhas 40 a 50:
40:             ENDIF
41: 
42:             IF THIS.this_cTipo == "E"
43:                 THIS.Caption = "Cadastro de Promo" + CHR(231) + CHR(245) + "es e-Commerce"
44:             ELSE
45:                 THIS.Caption = "Cadastro de Promo" + CHR(231) + CHR(245) + "es"
46:             ENDIF
47: 
48:             loc_lSucesso = DODEFAULT()
49:         CATCH TO loException
50:             MostrarErro(loException, "FormPrm.Init")

*-- Linhas 126 a 143:
126:     PROTECTED PROCEDURE ConfigurarPageFrame()
127:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
128:         WITH THIS.pgf_4c_Paginas
129:             .Top       = -29
130:             .Left      = 0
131:             .Width     = THIS.Width
132:             .Height    = THIS.Height + 29
133:             .PageCount = 2
134:             .Tabs      = .F.
135:             .TabStop   = .F.
136:             .Visible   = .T.
137:             .Page1.Caption = "Lista"
138:             .Page2.Caption = "Dados"
139:             .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
140:             .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
141:         ENDWITH
142:     ENDPROC
143: 

*-- Linhas 151 a 376:
151:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
152:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
153: 
154:         *-- Container cabecalho - Top=31 (2 + 29 compensacao PageFrame.Top=-29)
155:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
156:         WITH loc_oPagina.cnt_4c_Cabecalho
157:             .Top         = 31
158:             .Left        = 0
159:             .Width       = THIS.Width
160:             .Height      = 80
161:             .BackColor   = RGB(100, 100, 100)
162:             .BorderWidth = 0
163: 
164:             .AddObject("lbl_4c_Sombra", "Label")
165:             WITH .lbl_4c_Sombra
166:                 .Top       = 15
167:                 .Left      = 10
168:                 .Width     = THIS.Width
169:                 .Height    = 40
170:                 .Caption   = THIS.Caption
171:                 .FontName  = "Tahoma"
172:                 .FontSize  = 16
173:                 .FontBold  = .T.
174:                 .ForeColor = RGB(0, 0, 0)
175:                 .BackStyle = 0
176:                 .Visible   = .T.
177:             ENDWITH
178: 
179:             .AddObject("lbl_4c_Titulo", "Label")
180:             WITH .lbl_4c_Titulo
181:                 .Top       = 18
182:                 .Left      = 10
183:                 .Width     = THIS.Width
184:                 .Height    = 46
185:                 .Caption   = THIS.Caption
186:                 .FontName  = "Tahoma"
187:                 .FontSize  = 16
188:                 .FontBold  = .T.
189:                 .ForeColor = RGB(255, 255, 255)
190:                 .BackStyle = 0
191:                 .Visible   = .T.
192:             ENDWITH
193:         ENDWITH
194: 
195:         *-- Container botoes CRUD (lado direito) - Top=29 (0+29 compensacao)
196:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
197:         WITH loc_oPagina.cnt_4c_Botoes
198:             .Top         = 29
199:             .Left        = 542
200:             .Width       = 390
201:             .Height      = 85
202:             .BackColor   = RGB(53, 53, 53)
203:             .BackStyle   = 1
204:             .BorderWidth = 0
205:             .Visible     = .T.
206: 
207:             .AddObject("cmd_4c_Incluir", "CommandButton")
208:             WITH .cmd_4c_Incluir
209:                 .Caption         = "Incluir"
210:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
211:                 .PicturePosition = 13
212:                 .Top             = 5
213:                 .Left            =  542
214:                 .Width           = 75
215:                 .Height          = 75
216:                 .BackColor       = RGB(255, 255, 255)
217:                 .ForeColor       = RGB(90, 90, 90)
218:                 .FontName        = "Comic Sans MS"
219:                 .FontSize        = 8
220:                 .FontBold        = .T.
221:                 .FontItalic      = .T.
222:                 .SpecialEffect   = 0
223:                 .MousePointer    = 15
224:                 .WordWrap        = .T.
225:                 .AutoSize        = .F.
226:                 .Visible         = .T.
227:             ENDWITH
228: 
229:             .AddObject("cmd_4c_Visualizar", "CommandButton")
230:             WITH .cmd_4c_Visualizar
231:                 .Caption         = "Visualizar"
232:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
233:                 .PicturePosition = 13
234:                 .Top             = 5
235:                 .Left            =  542
236:                 .Width           = 75
237:                 .Height          = 75
238:                 .BackColor       = RGB(255, 255, 255)
239:                 .ForeColor       = RGB(90, 90, 90)
240:                 .FontName        = "Comic Sans MS"
241:                 .FontSize        = 8
242:                 .FontBold        = .T.
243:                 .FontItalic      = .T.
244:                 .Themes          = .F.
245:                 .SpecialEffect   = 0
246:                 .MousePointer    = 15
247:                 .WordWrap        = .T.
248:                 .AutoSize        = .F.
249:                 .Visible         = .T.
250:             ENDWITH
251: 
252:             .AddObject("cmd_4c_Alterar", "CommandButton")
253:             WITH .cmd_4c_Alterar
254:                 .Caption         = "Alterar"
255:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
256:                 .PicturePosition = 13
257:                 .Top             = 5
258:                 .Left            =  542
259:                 .Width           = 75
260:                 .Height          = 75
261:                 .BackColor       = RGB(255, 255, 255)
262:                 .ForeColor       = RGB(90, 90, 90)
263:                 .FontName        = "Comic Sans MS"
264:                 .FontSize        = 8
265:                 .FontBold        = .T.
266:                 .FontItalic      = .T.
267:                 .Themes          = .F.
268:                 .SpecialEffect   = 0
269:                 .MousePointer    = 15
270:                 .WordWrap        = .T.
271:                 .AutoSize        = .F.
272:                 .Visible         = .T.
273:             ENDWITH
274: 
275:             .AddObject("cmd_4c_Excluir", "CommandButton")
276:             WITH .cmd_4c_Excluir
277:                 .Caption         = "Excluir"
278:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
279:                 .PicturePosition = 13
280:                 .Top             = 5
281:                 .Left            =  542
282:                 .Width           = 75
283:                 .Height          = 75
284:                 .BackColor       = RGB(255, 255, 255)
285:                 .ForeColor       = RGB(90, 90, 90)
286:                 .FontName        = "Comic Sans MS"
287:                 .FontSize        = 8
288:                 .FontBold        = .T.
289:                 .FontItalic      = .T.
290:                 .Themes          = .F.
291:                 .SpecialEffect   = 0
292:                 .MousePointer    = 15
293:                 .WordWrap        = .T.
294:                 .AutoSize        = .F.
295:                 .Visible         = .T.
296:             ENDWITH
297: 
298:             .AddObject("cmd_4c_Buscar", "CommandButton")
299:             WITH .cmd_4c_Buscar
300:                 .Caption         = "Buscar"
301:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
302:                 .PicturePosition = 13
303:                 .Top             = 5
304:                 .Left            =  542
305:                 .Width           = 75
306:                 .Height          = 75
307:                 .BackColor       = RGB(255, 255, 255)
308:                 .ForeColor       = RGB(90, 90, 90)
309:                 .FontName        = "Comic Sans MS"
310:                 .FontSize        = 8
311:                 .FontBold        = .T.
312:                 .FontItalic      = .T.
313:                 .Themes          = .F.
314:                 .SpecialEffect   = 0
315:                 .MousePointer    = 15
316:                 .WordWrap        = .T.
317:                 .AutoSize        = .F.
318:                 .Visible         = .T.
319:             ENDWITH
320:         ENDWITH
321: 
322:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
323:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
324:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
325:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
326:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
327: 
328:         *-- Container saida (padrao canonico, Top=29)
329:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
330:         WITH loc_oPagina.cnt_4c_Saida
331:             .Top         = 29
332:             .Left        = 917
333:             .Width       = 90
334:             .Height      = 85
335:             .BackStyle   = 0
336:             .BorderWidth = 0
337:             .Visible     = .T.
338: 
339:             .AddObject("cmd_4c_Encerrar", "CommandButton")
340:             WITH .cmd_4c_Encerrar
341:                 .Caption         = "Encerrar"
342:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
343:                 .PicturePosition = 13
344:                 .Top             = 5
345:                 .Left            = 917
346:                 .Width           = 90
347:                 .Height          = 75
348:                 .BackColor       = RGB(255, 255, 255)
349:                 .ForeColor       = RGB(90, 90, 90)
350:                 .FontName        = "Comic Sans MS"
351:                 .FontSize        = 8
352:                 .FontBold        = .T.
353:                 .FontItalic      = .T.
354:                 .SpecialEffect   = 0
355:                 .MousePointer    = 15
356:                 .WordWrap        = .T.
357:                 .AutoSize        = .F.
358:                 .Visible         = .T.
359:             ENDWITH
360:         ENDWITH
361: 
362:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
363: 
364:         *-- Grid principal: Top=117 (88+29), Width=910 (nao sobrepoem cnt_4c_Saida em Left=917)
365:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
366:         loc_oGrid = loc_oPagina.grd_4c_Lista
367:         loc_oGrid.RecordSource = ""
368:         loc_oGrid.ColumnCount  = 5
369:         WITH loc_oGrid
370:             .Top                = 117
371:             .Left               = 0
372:             .Width              = 910
373:             .Height             = 478
374:             .FontName           = "Verdana"
375:             .FontSize           = 8
376:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 409 a 484:
409:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
410: 
411:         *-- Container botoes Confirmar/Cancelar (canonico: Top=33, Left=842)
412:         *-- Legado: Grupo_Salva.Left=611, Top=13 -> usar canonico
413:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
414:         WITH loc_oPagina.cnt_4c_BotoesAcao
415:             .Top         = 33
416:             .Left        = 842
417:             .Width       = 160
418:             .Height      = 85
419:             .BackStyle   = 0
420:             .BorderWidth = 0
421:             .Visible     = .T.
422: 
423:             .AddObject("cmd_4c_Confirmar", "CommandButton")
424:             WITH .cmd_4c_Confirmar
425:                 .Caption         = "Confirmar"
426:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
427:                 .PicturePosition = 13
428:                 .Top             = 5
429:                 .Left            = 5
430:                 .Width           = 75
431:                 .Height          = 75
432:                 .BackColor       = RGB(255, 255, 255)
433:                 .ForeColor       = RGB(90, 90, 90)
434:                 .FontName        = "Comic Sans MS"
435:                 .FontSize        = 8
436:                 .FontBold        = .T.
437:                 .FontItalic      = .T.
438:                 .SpecialEffect   = 0
439:                 .MousePointer    = 15
440:                 .WordWrap        = .T.
441:                 .AutoSize        = .F.
442:                 .Visible         = .T.
443:             ENDWITH
444: 
445:             .AddObject("cmd_4c_Cancelar", "CommandButton")
446:             WITH .cmd_4c_Cancelar
447:                 .Caption         = "Encerrar"
448:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
449:                 .PicturePosition = 13
450:                 .Top             = 5
451:                 .Left            = 80
452:                 .Width           = 75
453:                 .Height          = 75
454:                 .BackColor       = RGB(255, 255, 255)
455:                 .ForeColor       = RGB(90, 90, 90)
456:                 .FontName        = "Comic Sans MS"
457:                 .FontSize        = 8
458:                 .FontBold        = .T.
459:                 .FontItalic      = .T.
460:                 .Themes          = .F.
461:                 .SpecialEffect   = 0
462:                 .MousePointer    = 15
463:                 .WordWrap        = .T.
464:                 .AutoSize        = .F.
465:                 .Visible         = .T.
466:             ENDWITH
467:         ENDWITH
468: 
469:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
470:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
471: 
472:         *-- Label "Promoção :" + txt_4c_Promos
473:         *-- Legado: lbl_promocao Top=133, Left=31 -> compensado +29 = 162
474:         *-- Legado: get_promos   Top=130, Left=101 -> compensado +29 = 159
475:         loc_oPagina.AddObject("lbl_4c_Promocao", "Label")
476:         WITH loc_oPagina.lbl_4c_Promocao
477:             .Caption   = "Promo" + CHR(231) + CHR(227) + "o :"
478:             .Top       = 162
479:             .Left      = 31
480:             .Width     = 68
481:             .Height    = 15
482:             .FontName  = "Tahoma"
483:             .FontSize  = 8
484:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 490 a 515:
490:         loc_oPagina.AddObject("txt_4c_Promos", "TextBox")
491:         WITH loc_oPagina.txt_4c_Promos
492:             .Value     = ""
493:             .Top       = 159
494:             .Left      = 101
495:             .Width     = 185
496:             .Height    = 23
497:             .FontName  = "Tahoma"
498:             .FontSize  = 8
499:             .MaxLength = 25
500:             .Visible   = .T.
501:         ENDWITH
502: 
503:         *-- Label "Código :" + txt_4c_Codigo
504:         *-- Legado: Say1     Top=157, Left=48  -> compensado +29 = 186
505:         *-- Legado: getCodigo Top=154, Left=101 -> compensado +29 = 183
506:         loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
507:         WITH loc_oPagina.lbl_4c_Codigo
508:             .Caption   = "C" + CHR(243) + "digo :"
509:             .Top       = 186
510:             .Left      = 48
511:             .Width     = 51
512:             .Height    = 15
513:             .FontName  = "Tahoma"
514:             .FontSize  = 8
515:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 521 a 593:
521:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
522:         WITH loc_oPagina.txt_4c_Codigo
523:             .Value     = ""
524:             .Top       = 183
525:             .Left      = 101
526:             .Width     = 31
527:             .Height    = 23
528:             .FontName  = "Tahoma"
529:             .FontSize  = 8
530:             .MaxLength = 3
531:             .Visible   = .T.
532:         ENDWITH
533: 
534:         *-- CheckBox "Comissão Incentivada :" + txt_4c_Comiss
535:         *-- Legado: chkComissao Top=133, Left=310 -> compensado +29 = 162
536:         *-- Legado: getComiss   Top=130, Left=466 -> compensado +29 = 159
537:         loc_oPagina.AddObject("chk_4c_Comissao", "CheckBox")
538:         WITH loc_oPagina.chk_4c_Comissao
539:             .Caption   = "Comiss" + CHR(227) + "o Incentivada :"
540:             .Value     = 0
541:             .Top       = 162
542:             .Left      = 310
543:             .Width     = 155
544:             .Height    = 17
545:             .FontName  = "Tahoma"
546:             .FontSize  = 8
547:             .ForeColor = RGB(90, 90, 90)
548:             .BackStyle = 0
549:             .Visible   = .T.
550:         ENDWITH
551: 
552:         loc_oPagina.AddObject("txt_4c_Comiss", "TextBox")
553:         WITH loc_oPagina.txt_4c_Comiss
554:             .Value     = 0
555:             .Top       = 159
556:             .Left      = 466
557:             .Width     = 52
558:             .Height    = 23
559:             .FontName  = "Tahoma"
560:             .FontSize  = 8
561:             .InputMask = "99.99"
562:             .Enabled   = .F.
563:             .Visible   = .T.
564:         ENDWITH
565: 
566:         *-- CheckBox "Integrar e-Commerce :" + txt_4c_LPrecos
567:         *-- Legado: chkeCommerce Top=157, Left=311 -> compensado +29 = 186
568:         *-- Legado: getLPrecos   Top=154, Left=466 -> compensado +29 = 183
569:         loc_oPagina.AddObject("chk_4c_eCommerce", "CheckBox")
570:         WITH loc_oPagina.chk_4c_eCommerce
571:             .Caption   = "Integrar e-Commerce :"
572:             .Value     = 0
573:             .Top       = 186
574:             .Left      = 311
575:             .Width     = 148
576:             .Height    = 17
577:             .FontName  = "Tahoma"
578:             .FontSize  = 8
579:             .ForeColor = RGB(90, 90, 90)
580:             .BackStyle = 0
581:             .Visible   = .T.
582:         ENDWITH
583: 
584:         loc_oPagina.AddObject("txt_4c_LPrecos", "TextBox")
585:         WITH loc_oPagina.txt_4c_LPrecos
586:             .Value     = ""
587:             .Top       = 183
588:             .Left      = 466
589:             .Width     = 220
590:             .Height    = 23
591:             .FontName  = "Tahoma"
592:             .FontSize  = 8
593:             .MaxLength = 30

*-- Linhas 605 a 621:
605:         *-- Legado: pgGrades Top=181 -> compensado +29 = 210 (em Page2 do pgf_4c_Paginas com Top=-29)
606:         loc_oPagina.AddObject("pgf_4c_Grades", "PageFrame")
607:         WITH loc_oPagina.pgf_4c_Grades
608:             .Top       = 210
609:             .Left      = 23
610:             .Width     = 762
611:             .Height    = 396
612:             .PageCount = 2
613:             .Tabs      = .T.
614:             .TabStop   = .F.
615:             .Page1.Caption = "Produtos"
616:             .Page2.Caption = "Grupos de Venda"
617:         ENDWITH
618: 
619:         THIS.ConfigurarGradeProdutos(loc_oPagina.pgf_4c_Grades.Page1)
620:         THIS.ConfigurarGradeGrupos(loc_oPagina.pgf_4c_Grades.Page2)
621: 

*-- Linhas 650 a 662:
650:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.eCommerce"
651:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.LPrecos"
652:                     *-- Redefinir Headers APOS RecordSource (obrigatorio - RecordSource os reseta)
653:                     loc_oGrid.Column1.Header1.Caption = "Promo" + CHR(231) + CHR(227) + "o"
654:                     loc_oGrid.Column2.Header1.Caption = "C" + CHR(243) + "d."
655:                     loc_oGrid.Column3.Header1.Caption = "Comiss%"
656:                     loc_oGrid.Column4.Header1.Caption = "e-Com."
657:                     loc_oGrid.Column5.Header1.Caption = "Lista Pre" + CHR(231) + "os"
658:                     loc_oGrid.Column3.Alignment = 1
659:                     loc_oGrid.Column4.Alignment = 1
660:                     THIS.FormatarGridLista(loc_oGrid)
661:                     IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
662:                         GO TOP IN cursor_4c_Dados

*-- Linhas 958 a 966:
958:         loc_oPg2.chk_4c_eCommerce.Value = IIF(THIS.this_oBusinessObject.this_nECommerce = 1, 1, 0)
959:         loc_oPg2.txt_4c_LPrecos.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cLPrecos)
960: 
961:         *-- Habilitar dependencias visuais conforme checkboxes
962:         loc_oPg2.txt_4c_Comiss.Enabled  = (THIS.this_oBusinessObject.this_nIncentivs = 1)
963:         loc_oPg2.txt_4c_LPrecos.Enabled = (THIS.this_oBusinessObject.this_nECommerce = 1)
964: 
965:         *-- Carregar itens e grupos nos cursores e atualizar grids
966:         IF !EMPTY(loc_cPromos)

*-- Linhas 988 a 1015:
988:         loc_oPg2.txt_4c_Codigo.Enabled = par_lHabilitar AND ;
989:                                           (THIS.this_cModoAtual == "INCLUIR")
990: 
991:         *-- Checkboxes: editaveis em INCLUIR/ALTERAR
992:         loc_oPg2.chk_4c_Comissao.Enabled  = par_lHabilitar
993:         loc_oPg2.chk_4c_eCommerce.Enabled = par_lHabilitar AND !(THIS.this_cTipo == "E")
994: 
995:         *-- Campos vinculados ao checkbox
996:         loc_oPg2.txt_4c_Comiss.Enabled = par_lHabilitar AND ;
997:                                           (loc_oPg2.chk_4c_Comissao.Value)
998:         loc_oPg2.txt_4c_LPrecos.Enabled = par_lHabilitar AND ;
999:                                            (loc_oPg2.chk_4c_eCommerce.Value)
1000: 
1001:         *-- Botoes de acao
1002:         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
1003:         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1004: 
1005:         *-- Grids de edicao: ReadOnly em VISUALIZAR, editaveis em INCLUIR/ALTERAR
1006:         IF PEMSTATUS(loc_oPg2, "pgf_4c_Grades", 5)
1007:             loc_oPg2.pgf_4c_Grades.Page1.grd_4c_Produtos.ReadOnly   = !par_lHabilitar
1008:             loc_oPg2.pgf_4c_Grades.Page2.grd_4c_Grupos.ReadOnly     = !par_lHabilitar
1009:             loc_oPg2.pgf_4c_Grades.Page1.cmd_4c_ApagarItem.Enabled  = par_lHabilitar
1010:             loc_oPg2.pgf_4c_Grades.Page2.cmd_4c_ApagarGrupo.Enabled = par_lHabilitar
1011:         ENDIF
1012:     ENDPROC
1013: 
1014:     *====================================================================
1015:     * LimparCampos - Limpa valores de todos os campos da Page2

*-- Linhas 1067 a 1079:
1067: 
1068:         DO CASE
1069:         CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1070:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
1071:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1072:         OTHERWISE
1073:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
1074:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1075:         ENDCASE
1076:     ENDPROC
1077: 
1078:     *====================================================================
1079:     * ValidarPromos - Valida campo promocao ao perder foco (PUBLIC - BINDEVENT)

*-- Linhas 1205 a 1214:
1205:         par_oPgProdutos.AddObject("grd_4c_Produtos", "Grid")
1206:         loc_oGrid = par_oPgProdutos.grd_4c_Produtos
1207:         WITH loc_oGrid
1208:             .Top             = 3
1209:             .Left            = 8
1210:             .Width           = 742
1211:             .Height          = 220
1212:             .ColumnCount     = 6
1213:             .FontName        = "Tahoma"
1214:             .FontSize        = 8

*-- Linhas 1233 a 1306:
1233:             .ControlSource   = "cursor_4c_Itens.CPros"
1234:             .Width           = 100
1235:             .Sparse          = .F.
1236:             .Header1.Caption = "Produto"
1237:         ENDWITH
1238:         BINDEVENT(loc_oGrid.Column1.Text1, "Valid", THIS, "ValidarProdutoCodigo")
1239: 
1240:         WITH loc_oGrid.Column2
1241:             .ControlSource   = "cursor_4c_Itens.DPros"
1242:             .Width           = 200
1243:             .ReadOnly        = .T.
1244:             .Sparse          = .F.
1245:             .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1246:         ENDWITH
1247: 
1248:         WITH loc_oGrid.Column3
1249:             .ControlSource   = "cursor_4c_Itens.Pecas"
1250:             .Width           = 70
1251:             .Sparse          = .F.
1252:             .Header1.Caption = "Pe" + CHR(231) + "a"
1253:         ENDWITH
1254: 
1255:         WITH loc_oGrid.Column4
1256:             .ControlSource   = "cursor_4c_Itens.CBars"
1257:             .Width           = 80
1258:             .Sparse          = .F.
1259:             .ReadOnly        = .T.
1260:             .Header1.Caption = "C" + CHR(243) + "d. Barra"
1261:         ENDWITH
1262: 
1263:         WITH loc_oGrid.Column5
1264:             .ControlSource   = "cursor_4c_Itens.Datas"
1265:             .Width           = 80
1266:             .Sparse          = .F.
1267:             .Header1.Caption = "Data Inicial"
1268:         ENDWITH
1269:         BINDEVENT(loc_oGrid.Column5.Text1, "Valid", THIS, "GridProdutosDatasValid")
1270: 
1271:         *-- Column6: Vendavels com CheckBox (7 props obrigatorias + Sparse=.F.)
1272:         WITH loc_oGrid.Column6
1273:             .ControlSource   = "cursor_4c_Itens.Vendavels"
1274:             .Width           = 35
1275:             .Sparse          = .F.
1276:             .Header1.Caption = "V"
1277:             .AddObject("chk_4c_Vendavel", "CheckBox")
1278:             WITH .chk_4c_Vendavel
1279:                 .ControlSource = "cursor_4c_Itens.Vendavels"
1280:                 .Caption       = ""
1281:                 .Alignment     = 0
1282:                 .ReadOnly      = .F.
1283:                 .Visible       = .T.
1284:                 .Top           = 9
1285:                 .Left          = 2
1286:                 .Height        = 17
1287:                 .Width         = 22
1288:             ENDWITH
1289:             .CurrentControl  = "chk_4c_Vendavel"
1290:         ENDWITH
1291:         BINDEVENT(loc_oGrid.Column6.chk_4c_Vendavel, "Click",    THIS, "GridCheckVendavelClick")
1292:         BINDEVENT(loc_oGrid.Column6.chk_4c_Vendavel, "KeyPress", THIS, "GridProdutosKeyPress")
1293: 
1294:         BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GridProdutosAfterRowColChange")
1295: 
1296:         *-- Label "Busca :" (legado: Say2 Top=276,Left=299)
1297:         par_oPgProdutos.AddObject("lbl_4c_Busca", "Label")
1298:         WITH par_oPgProdutos.lbl_4c_Busca
1299:             .Caption   = "Busca :"
1300:             .Top       = 276
1301:             .Left      = 299
1302:             .Width     = 37
1303:             .Height    = 15
1304:             .FontName  = "Tahoma"
1305:             .FontSize  = 8
1306:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1312 a 1351:
1312:         par_oPgProdutos.AddObject("txt_4c_Busca", "TextBox")
1313:         WITH par_oPgProdutos.txt_4c_Busca
1314:             .Value     = ""
1315:             .Top       = 273
1316:             .Left      = 344
1317:             .Width     = 108
1318:             .Height    = 23
1319:             .FontName  = "Tahoma"
1320:             .FontSize  = 8
1321:             .MaxLength = 14
1322:             .Visible   = .T.
1323:         ENDWITH
1324:         BINDEVENT(par_oPgProdutos.txt_4c_Busca, "LostFocus",     THIS, "BuscaItemValid")
1325:         BINDEVENT(par_oPgProdutos.txt_4c_Busca, "KeyPress", THIS, "BuscaItemLostFocus")
1326: 
1327:         *-- Botao Apagar Item (legado: cmdApagar Top=252,Left=551,W=50,H=50)
1328:         par_oPgProdutos.AddObject("cmd_4c_ApagarItem", "CommandButton")
1329:         WITH par_oPgProdutos.cmd_4c_ApagarItem
1330:             .Caption      = "Apagar"
1331:             .Top          = 252
1332:             .Left         = 551
1333:             .Width        = 50
1334:             .Height       = 50
1335:             .FontName     = "Tahoma"
1336:             .FontSize     = 8
1337:             .MousePointer = 15
1338:             .Visible      = .T.
1339:         ENDWITH
1340:         BINDEVENT(par_oPgProdutos.cmd_4c_ApagarItem, "Click", THIS, "BtnApagarItemClick")
1341: 
1342:         *-- Imagem produto (legado: ImgProd Top=228,Left=59,W=175,H=104)
1343:         par_oPgProdutos.AddObject("img_4c_ImgProd", "Image")
1344:         WITH par_oPgProdutos.img_4c_ImgProd
1345:             .Top     = 228
1346:             .Left    = 59
1347:             .Width   = 175
1348:             .Height  = 104
1349:             .Stretch = 2
1350:             .Visible = .F.
1351:         ENDWITH

*-- Linhas 1361 a 1370:
1361:         par_oPgGrupos.AddObject("grd_4c_Grupos", "Grid")
1362:         loc_oGrid = par_oPgGrupos.grd_4c_Grupos
1363:         WITH loc_oGrid
1364:             .Top             = 24
1365:             .Left            = 256
1366:             .Width           = 192
1367:             .Height          = 324
1368:             .ColumnCount     = 2
1369:             .FontName        = "Tahoma"
1370:             .FontSize        = 8

*-- Linhas 1389 a 1422:
1389:             .ControlSource   = "cursor_4c_Grupos.Colecoes"
1390:             .Width           = 80
1391:             .Sparse          = .F.
1392:             .Header1.Caption = "Grp. Venda"
1393:         ENDWITH
1394:         BINDEVENT(loc_oGrid.Column1.Text1, "Valid", THIS, "ValidarColecao")
1395: 
1396:         WITH loc_oGrid.Column2
1397:             .ControlSource   = "cursor_4c_Grupos.Datas"
1398:             .Width           = 80
1399:             .Sparse          = .F.
1400:             .Header1.Caption = "Data Inicial"
1401:         ENDWITH
1402:         BINDEVENT(loc_oGrid.Column2.Text1, "Valid", THIS, "ValidarDataGrupo")
1403: 
1404:         *-- Botao Apagar Grupo (legado: cmdApagar Top=161,Left=451,W=50,H=50)
1405:         par_oPgGrupos.AddObject("cmd_4c_ApagarGrupo", "CommandButton")
1406:         WITH par_oPgGrupos.cmd_4c_ApagarGrupo
1407:             .Caption      = "Apagar"
1408:             .Top          = 161
1409:             .Left         = 451
1410:             .Width        = 50
1411:             .Height       = 50
1412:             .FontName     = "Tahoma"
1413:             .FontSize     = 8
1414:             .MousePointer = 15
1415:             .Visible      = .T.
1416:         ENDWITH
1417:         BINDEVENT(par_oPgGrupos.cmd_4c_ApagarGrupo, "Click", THIS, "BtnApagarGrupoClick")
1418:     ENDPROC
1419: 
1420:     *====================================================================
1421:     * GridProdutosAfterRowColChange - Carrega imagem do produto ao mudar linha
1422:     * Legado: grd_produtos.AfterRowColChange - SQLEXEC FigJpgs FROM SigCdPro

*-- Linhas 1555 a 1563:
1555:     ENDPROC
1556: 
1557:     *====================================================================
1558:     * GridCheckVendavelClick - Click no CheckBox Vendavel na Column6
1559:     * Legado: Column6.Check1.Click - Replace Vendavels With This.Value
1560:     *====================================================================
1561:     PROCEDURE GridCheckVendavelClick()
1562:         LOCAL loc_oChk
1563:         TRY

*-- Linhas 1574 a 1595:
1574:     ENDPROC
1575: 
1576:     *====================================================================
1577:     * GridProdutosKeyPress - KeyPress no CheckBox Vendavel (Column6)
1578:     * Legado: TAB=Salva.SetFocus, SHIFT+TAB=Get_Promos.SetFocus
1579:     *====================================================================
1580:     PROCEDURE GridProdutosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1581:         LOCAL loc_oPg2
1582:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1583: 
1584:         IF par_nKeyCode = 9
1585:             IF BITAND(par_nShiftAltCtrl, 1) = 1
1586:                 *-- SHIFT+TAB: voltar para campo Promocao
1587:                 loc_oPg2.txt_4c_Promos.SetFocus
1588:             ELSE
1589:                 *-- TAB: ir para botao Confirmar
1590:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
1591:             ENDIF
1592:         ENDIF
1593:     ENDPROC
1594: 
1595:     *====================================================================


### BO (C:\4c\projeto\app\classes\PrmBO.prg):
*====================================================================
* PrmBO.prg
*
* Business Object para Cadastro de Promocoes
* Tabela Principal: SigPrPmc
* Tabelas Filhas: SigPrPmi (itens/produtos), SigPrPmv (grupos de venda)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS PrmBO AS BusinessBase

    *-- Propriedades SigPrPmc (cabecalho da promocao)
    this_cPromos     = ""    && promos    char(25)  - chave de negocio (codigo promocao)
    this_cCods       = ""    && cods      char(3)   - codigo complementar
    this_cCidChaves  = ""    && cidchaves char(20)  - PK
    this_nComiss     = 0     && comiss    numeric(5,2) - percentual comissao incentivada
    this_nIncentivs  = 0     && incentivs numeric(1,0) - flag comissao incentivada (0/1)
    this_nECommerce  = 0     && ecommerce numeric(1,0) - flag integracao e-commerce (0/1)
    this_cLPrecos    = ""    && lprecos   char(30)  - lista de precos e-commerce

    *-- Propriedade de modo de exibicao (herdada do form original pcTipo)
    this_cTipo       = ""    && "" = modo padrao, "E" = modo e-commerce (filtra por ecommerce=1)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrPmc"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "PrmBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * SEMPRE usar SELECT (par_cAliasCursor) antes de acessar campos
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves  = TratarNulo(cidchaves, "C")
            THIS.this_cPromos     = TratarNulo(Promos, "C")
            THIS.this_cCods       = TratarNulo(Cods, "C")
            THIS.this_nComiss     = TratarNulo(Comiss, "N")
            THIS.this_nIncentivs  = TratarNulo(Incentivs, "N")
            THIS.this_nECommerce  = TratarNulo(eCommerce, "N")
            THIS.this_cLPrecos    = TratarNulo(LPrecos, "C")
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Lista registros de promocoes (PUBLIC)
    * Se this_cTipo = "E", filtra por eCommerce = 1
    *====================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF UPPER(ALLTRIM(THIS.this_cTipo)) == "E"
                loc_cSQL = "SELECT a.cidchaves, a.Promos, a.Cods," + ;
                           " a.Comiss, a.Incentivs, a.eCommerce, a.LPrecos" + ;
                           " FROM SigPrPmc a" + ;
                           " WHERE a.eCommerce = 1" + ;
                           " ORDER BY a.Promos"
            ELSE
                loc_cSQL = "SELECT a.cidchaves, a.Promos, a.Cods," + ;
                           " a.Comiss, a.Incentivs, a.eCommerce, a.LPrecos" + ;
                           " FROM SigPrPmc a"

                IF !EMPTY(ALLTRIM(par_cFiltro))
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY a.Promos"
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar promo" + CHR(231) + CHR(245) + "es:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.Buscar")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarPorCodigo - Carrega promocao pelo cIdChaves (PK) (PUBLIC)
    *====================================================================
    FUNCTION CarregarPorCodigo(par_cCidChaves)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT a.cidchaves, a.Promos, a.Cods," + ;
                       " a.Comiss, a.Incentivs, a.eCommerce, a.LPrecos" + ;
                       " FROM SigPrPmc a" + ;
                       " WHERE a.cidchaves = " + EscaparSQL(par_cCidChaves)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.CarregarPorCodigo")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarPorPromos - Carrega promocao pela chave de negocio (PUBLIC)
    *====================================================================
    FUNCTION CarregarPorPromos(par_cPromos, par_cCods)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT a.cidchaves, a.Promos, a.Cods," + ;
                       " a.Comiss, a.Incentivs, a.eCommerce, a.LPrecos" + ;
                       " FROM SigPrPmc a" + ;
                       " WHERE a.Promos = " + EscaparSQL(par_cPromos)

            IF !EMPTY(ALLTRIM(par_cCods))
                loc_cSQL = loc_cSQL + " AND a.Cods = " + EscaparSQL(par_cCods)
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.CarregarPorPromos")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * VerificarPromoExiste - Verifica se Promos+Cods ja existe no banco
    *====================================================================
    FUNCTION VerificarPromoExiste(par_cPromos, par_cCods)
        LOCAL loc_lExiste, loc_cSQL, loc_nResult
        loc_lExiste = .F.
        TRY
            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigPrPmc" + ;
                       " WHERE Promos = " + EscaparSQL(par_cPromos) + ;
                       " AND Cods = " + EscaparSQL(par_cCods)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Verifica")
                TABLEREVERT(.T., "cursor_4c_Verifica")
                USE IN cursor_4c_Verifica
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Verifica")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Verifica") > 0
                SELECT cursor_4c_Verifica
                loc_lExiste = (cursor_4c_Verifica.Total > 0)
            ENDIF

            IF USED("cursor_4c_Verifica")
                USE IN cursor_4c_Verifica
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.VerificarPromoExiste")
            IF USED("cursor_4c_Verifica")
                USE IN cursor_4c_Verifica
            ENDIF
        ENDTRY
        RETURN loc_lExiste
    ENDFUNC

    *====================================================================
    * GerarIdUnico - Gera ID unico para cIdChaves (substitui fUniqueIds)
    *====================================================================
    FUNCTION GerarIdUnico()
        LOCAL loc_cId, loc_nResult
        loc_cId = ""
        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT REPLACE(NEWID(),'-','') AS NewId", "cursor_4c_NewId")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_NewId") > 0
                SELECT cursor_4c_NewId
                loc_cId = LEFT(ALLTRIM(cursor_4c_NewId.NewId), 20)
            ENDIF
            IF USED("cursor_4c_NewId")
                USE IN cursor_4c_NewId
            ENDIF
        CATCH TO loException
            loc_cId = ""
            IF USED("cursor_4c_NewId")
                USE IN cursor_4c_NewId
            ENDIF
        ENDTRY
        IF EMPTY(loc_cId)
            loc_cId = LEFT(ALLTRIM(SYS(2015)) + ALLTRIM(SYS(3)), 20)
        ENDIF
        RETURN loc_cId
    ENDFUNC

    *====================================================================
    * Inserir - INSERT na tabela SigPrPmc (PROTECTED)
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = THIS.GerarIdUnico()
            ENDIF

            loc_cSQL = "INSERT INTO SigPrPmc" + ;
                       " (cidchaves, Promos, Cods, Comiss, Incentivs, eCommerce, LPrecos)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cPromos) + ", " + ;
                       EscaparSQL(THIS.this_cCods) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nComiss) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nIncentivs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nECommerce) + ", " + ;
                       EscaparSQL(THIS.this_cLPrecos) + ;
                       ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir promo" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE na tabela SigPrPmc (PROTECTED)
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigPrPmc SET" + ;
                       " Promos = " + EscaparSQL(THIS.this_cPromos) + "," + ;
                       " Cods = " + EscaparSQL(THIS.this_cCods) + "," + ;
                       " Comiss = " + FormatarNumeroSQL(THIS.this_nComiss) + "," + ;
                       " Incentivs = " + FormatarNumeroSQL(THIS.this_nIncentivs) + "," + ;
                       " eCommerce = " + FormatarNumeroSQL(THIS.this_nECommerce) + "," + ;
                       " LPrecos = " + EscaparSQL(THIS.this_cLPrecos) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar promo" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - DELETE do cabecalho + itens + grupos (PROTECTED)
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            *-- Excluir itens/produtos da promocao
            loc_cSQL = "DELETE FROM SigPrPmi WHERE Promos = " + EscaparSQL(THIS.this_cPromos)
            SQLEXEC(gnConnHandle, loc_cSQL)

            *-- Excluir grupos de venda da promocao
            loc_cSQL = "DELETE FROM SigPrPmv WHERE Promos = " + EscaparSQL(THIS.this_cPromos)
            SQLEXEC(gnConnHandle, loc_cSQL)

            *-- Excluir cabecalho da promocao
            loc_cSQL = "DELETE FROM SigPrPmc WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir promo" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.ExecutarExclusao")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BuscarItens - Carrega itens/produtos de uma promocao para cursor de edicao
    * Popula cursor_4c_Itens para o grid pgProdutos (PUBLIC)
    *====================================================================
    FUNCTION BuscarItens(par_cPromos)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT a.cIdChaves, a.CPros, a.DPros, a.Pecas," + ;
                       " a.Promos, a.CBars, a.Datas, a.DtAlts," + ;
                       " a.PromoPro, a.Vendavels" + ;
                       " FROM SigPrPmi a" + ;
                       " WHERE a.Promos = " + EscaparSQL(par_cPromos) + ;
                       " ORDER BY a.CPros"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ItensTemp")
                TABLEREVERT(.T., "cursor_4c_ItensTemp")
                USE IN cursor_4c_ItensTemp
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItensTemp")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Itens")
                    USE IN cursor_4c_Itens
                ENDIF

                SET NULL ON
                CREATE CURSOR cursor_4c_Itens ;
                    (cIdChaves C(20), CPros C(14), DPros C(40), Pecas C(10), ;
                     Promos C(25), CBars N(8,0) NULL, Datas D NULL, DtAlts T NULL, ;
                     PromoPro C(35), Vendavels N(1,0) NULL)
                SET NULL OFF

                IF RECCOUNT("cursor_4c_ItensTemp") > 0
                    SELECT cursor_4c_ItensTemp
                    SCAN
                        INSERT INTO cursor_4c_Itens ;
                            (cIdChaves, CPros, DPros, Pecas, Promos, CBars, ;
                             Datas, DtAlts, PromoPro, Vendavels) ;
                        VALUES ;
                            (cursor_4c_ItensTemp.cIdChaves, ;
                             cursor_4c_ItensTemp.CPros, ;
                             cursor_4c_ItensTemp.DPros, ;
                             cursor_4c_ItensTemp.Pecas, ;
                             cursor_4c_ItensTemp.Promos, ;
                             cursor_4c_ItensTemp.CBars, ;
                             cursor_4c_ItensTemp.Datas, ;
                             cursor_4c_ItensTemp.DtAlts, ;
                             cursor_4c_ItensTemp.PromoPro, ;
                             cursor_4c_ItensTemp.Vendavels)
                    ENDSCAN
                ENDIF

                *-- Adicionar linha em branco para edicao (como no legado)
                INSERT INTO cursor_4c_Itens (Promos, Datas, Vendavels) ;
                    VALUES (par_cPromos, DATE(), 1)

                IF USED("cursor_4c_ItensTemp")
                    USE IN cursor_4c_ItensTemp
                ENDIF

                GO TOP IN cursor_4c_Itens
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar itens da promo" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                IF USED("cursor_4c_ItensTemp")
                    USE IN cursor_4c_ItensTemp
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.BuscarItens")
            IF USED("cursor_4c_ItensTemp")
                USE IN cursor_4c_ItensTemp
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * BuscarGrupos - Carrega grupos de venda de uma promocao para cursor de edicao
    * Popula cursor_4c_Grupos para o grid pgGrpVenda (PUBLIC)
    *====================================================================
    FUNCTION BuscarGrupos(par_cPromos)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT a.cIdChaves, a.Promos, a.Colecoes, a.Datas" + ;
                       " FROM SigPrPmv a" + ;
                       " WHERE a.Promos = " + EscaparSQL(par_cPromos) + ;
                       " AND a.Colecoes IS NOT NULL AND a.Colecoes <> ''" + ;
                       " ORDER BY a.Colecoes"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_GruposTemp")
                TABLEREVERT(.T., "cursor_4c_GruposTemp")
                USE IN cursor_4c_GruposTemp
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruposTemp")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Grupos")
                    USE IN cursor_4c_Grupos
                ENDIF

                SET NULL ON
                CREATE CURSOR cursor_4c_Grupos ;
                    (cIdChaves C(20), Promos C(25), Colecoes C(10), Datas T NULL)
                SET NULL OFF

                IF RECCOUNT("cursor_4c_GruposTemp") > 0
                    SELECT cursor_4c_GruposTemp
                    SCAN
                        INSERT INTO cursor_4c_Grupos ;
                            (cIdChaves, Promos, Colecoes, Datas) ;
                        VALUES ;
                            (cursor_4c_GruposTemp.cIdChaves, ;
                             cursor_4c_GruposTemp.Promos, ;
                             cursor_4c_GruposTemp.Colecoes, ;
                             cursor_4c_GruposTemp.Datas)
                    ENDSCAN
                ENDIF

                *-- Linha em branco para edicao (como no legado: INSERT INTO csSigPrPmv (Promos, Datas))
                INSERT INTO cursor_4c_Grupos (Promos, Datas) VALUES (par_cPromos, DATETIME())

                IF USED("cursor_4c_GruposTemp")
                    USE IN cursor_4c_GruposTemp
                ENDIF

                GO TOP IN cursor_4c_Grupos
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar grupos da promo" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                IF USED("cursor_4c_GruposTemp")
                    USE IN cursor_4c_GruposTemp
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.BuscarGrupos")
            IF USED("cursor_4c_GruposTemp")
                USE IN cursor_4c_GruposTemp
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * SalvarItens - Persiste itens/produtos no banco (DELETE+INSERT) (PUBLIC)
    * Chamado pelo form apos salvar cabecalho
    *====================================================================
    FUNCTION SalvarItens(par_cPromos)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cIdChaves
        loc_lSucesso = .F.
        TRY
            IF !USED("cursor_4c_Itens")
                loc_lSucesso = .T.
            ENDIF

            *-- Excluir TODOS os itens existentes no banco (legado faz ZAP + Delete + Update)
            loc_cSQL = "DELETE FROM SigPrPmi WHERE Promos = " + EscaparSQL(par_cPromos)
            SQLEXEC(gnConnHandle, loc_cSQL)

            *-- Inserir itens nao-vazios do cursor de edicao
            SELECT cursor_4c_Itens
            GO TOP IN cursor_4c_Itens
            loc_lSucesso = .T.
            SCAN
                IF EMPTY(ALLTRIM(cursor_4c_Itens.CPros))
                    LOOP
                ENDIF

                IF EMPTY(ALLTRIM(cursor_4c_Itens.cIdChaves))
                    loc_cIdChaves = THIS.GerarIdUnico()
                ELSE
                    loc_cIdChaves = ALLTRIM(cursor_4c_Itens.cIdChaves)
                ENDIF

                loc_cSQL = "INSERT INTO SigPrPmi" + ;
                           " (cIdChaves, CPros, DPros, Pecas, Promos, CBars," + ;
                           " Datas, DtAlts, PromoPro, Vendavels)" + ;
                           " VALUES (" + ;
                           EscaparSQL(loc_cIdChaves) + ", " + ;
                           EscaparSQL(ALLTRIM(cursor_4c_Itens.CPros)) + ", " + ;
                           EscaparSQL(ALLTRIM(cursor_4c_Itens.DPros)) + ", " + ;
                           EscaparSQL(ALLTRIM(cursor_4c_Itens.Pecas)) + ", " + ;
                           EscaparSQL(par_cPromos) + ", " + ;
                           FormatarNumeroSQL(cursor_4c_Itens.CBars) + ", " + ;
                           FormatarDataSQL(cursor_4c_Itens.Datas) + ", " + ;
                           "GETDATE(), " + ;
                           EscaparSQL(par_cPromos + ALLTRIM(cursor_4c_Itens.CPros)) + ", " + ;
                           FormatarNumeroSQL(cursor_4c_Itens.Vendavels) + ;
                           ")"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult < 0
                    MsgErro("Erro ao salvar item " + ALLTRIM(cursor_4c_Itens.CPros) + ":" + ;
                            CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lSucesso = .F.
                ENDIF
            ENDSCAN
        CATCH TO loException
            MostrarErro(loException, "PrmBO.SalvarItens")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * SalvarGrupos - Persiste grupos de venda no banco (DELETE+INSERT) (PUBLIC)
    * Chamado pelo form apos salvar cabecalho
    *====================================================================
    FUNCTION SalvarGrupos(par_cPromos)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cIdChaves
        loc_lSucesso = .F.
        TRY
            IF !USED("cursor_4c_Grupos")
                loc_lSucesso = .T.
            ENDIF

            *-- Excluir grupos nao-vazios existentes no banco
            loc_cSQL = "DELETE FROM SigPrPmv" + ;
                       " WHERE Promos = " + EscaparSQL(par_cPromos) + ;
                       " AND Colecoes IS NOT NULL AND Colecoes <> ''"
            SQLEXEC(gnConnHandle, loc_cSQL)

            *-- Inserir grupos nao-vazios do cursor de edicao
            SELECT cursor_4c_Grupos
            GO TOP IN cursor_4c_Grupos
            loc_lSucesso = .T.
            SCAN
                IF EMPTY(ALLTRIM(cursor_4c_Grupos.Colecoes))
                    LOOP
                ENDIF

                IF EMPTY(ALLTRIM(cursor_4c_Grupos.cIdChaves))
                    loc_cIdChaves = THIS.GerarIdUnico()
                ELSE
                    loc_cIdChaves = ALLTRIM(cursor_4c_Grupos.cIdChaves)
                ENDIF

                loc_cSQL = "INSERT INTO SigPrPmv (cIdChaves, Promos, Colecoes, Datas)" + ;
                           " VALUES (" + ;
                           EscaparSQL(loc_cIdChaves) + ", " + ;
                           EscaparSQL(par_cPromos) + ", " + ;
                           EscaparSQL(ALLTRIM(cursor_4c_Grupos.Colecoes)) + ", " + ;
                           "GETDATE())"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult < 0
                    MsgErro("Erro ao salvar grupo " + ALLTRIM(cursor_4c_Grupos.Colecoes) + ":" + ;
                            CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lSucesso = .F.
                ENDIF
            ENDSCAN
        CATCH TO loException
            MostrarErro(loException, "PrmBO.SalvarGrupos")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ExcluirItem - Exclui item especifico por cIdChaves (PUBLIC)
    * Chamado quando usuario clica cmdApagar no grid de produtos
    *====================================================================
    FUNCTION ExcluirItem(par_cIdChaves)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "DELETE FROM SigPrPmi WHERE cIdChaves = " + EscaparSQL(par_cIdChaves)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir item:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.ExcluirItem")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ExcluirGrupo - Exclui grupo de venda especifico por cIdChaves (PUBLIC)
    * Chamado quando usuario clica cmdApagar no grid de grupos
    *====================================================================
    FUNCTION ExcluirGrupo(par_cIdChaves)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "DELETE FROM SigPrPmv WHERE cIdChaves = " + EscaparSQL(par_cIdChaves)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.ExcluirGrupo")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * BuscarProdutoPorCodigo - Busca produto por codigo ou codigo de barras
    * Popula cursor_4c_BuscaProd (PUBLIC)
    * Substitui a logica de Valid em txt_cpros + fVerificarBarras do legado
    *====================================================================
    FUNCTION BuscarProdutoPorCodigo(par_cCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cCPros
        loc_lSucesso = .F.
        loc_cCPros   = ""
        TRY
            IF USED("cursor_4c_BuscaProd")
                USE IN cursor_4c_BuscaProd
            ENDIF

            *-- Verificar se e codigo de barras (numerico com 8+ digitos)
            IF LEN(ALLTRIM(par_cCodigo)) >= 8 AND !EMPTY(VAL(ALLTRIM(par_cCodigo)))
                loc_cSQL = "SELECT a.CPros, a.CBars FROM SigOpEtq a" + ;
                           " WHERE a.CBars = " + ALLTRIM(par_cCodigo)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_BuscaEtq")
                    TABLEREVERT(.T., "cursor_4c_BuscaEtq")
                    USE IN cursor_4c_BuscaEtq
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEtq")
                IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaEtq") > 0
                    SELECT cursor_4c_BuscaEtq
                    GO TOP
                    loc_cCPros = ALLTRIM(cursor_4c_BuscaEtq.CPros)
                ENDIF
                IF USED("cursor_4c_BuscaEtq")
                    USE IN cursor_4c_BuscaEtq
                ENDIF

                IF EMPTY(loc_cCPros)
                    loc_lSucesso = .F.
                ENDIF
                loc_cSQL = "SELECT a.cPros, a.dPros FROM SigCdPro a" + ;
                           " WHERE a.cPros = " + EscaparSQL(loc_cCPros)
            ELSE
                loc_cSQL = "SELECT a.cPros, a.dPros FROM SigCdPro a" + ;
                           " WHERE a.cPros = " + EscaparSQL(par_cCodigo)
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_BuscaProd")
                TABLEREVERT(.T., "cursor_4c_BuscaProd")
                USE IN cursor_4c_BuscaProd
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaProd")
            IF loc_nResult >= 0
                loc_lSucesso = RECCOUNT("cursor_4c_BuscaProd") > 0
            ELSE
                MsgErro("Erro ao buscar produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.BuscarProdutoPorCodigo")
            IF USED("cursor_4c_BuscaEtq")
                USE IN cursor_4c_BuscaEtq
            ENDIF
            IF USED("cursor_4c_BuscaProd")
                USE IN cursor_4c_BuscaProd
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * BuscarProdutoParaLookup - Busca produtos para FormBuscaAuxiliar (PUBLIC)
    * Popula cursor_4c_BuscaProd com cPros + dPros
    *====================================================================
    FUNCTION BuscarProdutoParaLookup(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_BuscaProd")
                USE IN cursor_4c_BuscaProd
            ENDIF

            loc_cSQL = "SELECT a.cPros, a.dPros FROM SigCdPro a"
            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + ;
                           " WHERE a.cPros LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY a.cPros"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_BuscaProd")
                TABLEREVERT(.T., "cursor_4c_BuscaProd")
                USE IN cursor_4c_BuscaProd
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaProd")
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar produtos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.BuscarProdutoParaLookup")
            IF USED("cursor_4c_BuscaProd")
                USE IN cursor_4c_BuscaProd
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * BuscarColecaoParaLookup - Busca colecoes em SigCdCol (PUBLIC)
    * Substitui fwBuscaExt para SigCdCol no grid de grupos de venda
    * Popula cursor_4c_BuscaCol com Colecoes + Descs
    *====================================================================
    FUNCTION BuscarColecaoParaLookup(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_BuscaCol")
                USE IN cursor_4c_BuscaCol
            ENDIF

            loc_cSQL = "SELECT a.Colecoes, a.Descs FROM SigCdCol a"
            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + ;
                           " WHERE a.Colecoes LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY a.Colecoes"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_BuscaCol")
                TABLEREVERT(.T., "cursor_4c_BuscaCol")
                USE IN cursor_4c_BuscaCol
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCol")
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar cole" + CHR(231) + CHR(245) + "es:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.BuscarColecaoParaLookup")
            IF USED("cursor_4c_BuscaCol")
                USE IN cursor_4c_BuscaCol
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * BuscarListaPrecos - Busca listas de precos em SigCdLpc (PUBLIC)
    * Substitui fwBuscaExt para SigCdLpc no campo getLPrecos
    * Popula cursor_4c_BuscaLpc com LPrecos
    *====================================================================
    FUNCTION BuscarListaPrecos(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_BuscaLpc")
                USE IN cursor_4c_BuscaLpc
            ENDIF

            loc_cSQL = "SELECT a.LPrecos FROM SigCdLpc a ORDER BY a.LPrecos"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaLpc")
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar listas de pre" + CHR(231) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.BuscarListaPrecos")
            IF USED("cursor_4c_BuscaLpc")
                USE IN cursor_4c_BuscaLpc
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarImagemProduto - Carrega imagem JPEG de produto para arquivo temp (PUBLIC)
    * Substitui logica AfterRowColChange do grid de produtos no legado
    *====================================================================
    FUNCTION CarregarImagemProduto(par_cCPros, par_cArquivoTemp)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_ImgProd")
                USE IN cursor_4c_ImgProd
            ENDIF

            loc_cSQL = "SELECT a.FigJpgs FROM SigCdPro a" + ;
                       " WHERE a.cPros = " + EscaparSQL(par_cCPros)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImgProd")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ImgProd") > 0
                SELECT cursor_4c_ImgProd
                IF !EMPTY(cursor_4c_ImgProd.FigJpgs) AND !ISNULL(cursor_4c_ImgProd.FigJpgs)
                    IF STRTOFILE(cursor_4c_ImgProd.FigJpgs, par_cArquivoTemp) > 0
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_ImgProd")
                USE IN cursor_4c_ImgProd
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.CarregarImagemProduto")
            IF USED("cursor_4c_ImgProd")
                USE IN cursor_4c_ImgProd
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

