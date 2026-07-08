# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [ALINHAMENTO] Botao 'cmd_4c_IniTarefa' tem Top=161 mas grupo usa Top=168 (diferenca de 7px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (13541 linhas total):

*-- Linhas 80 a 88:
80:                 THIS.ConfigurarPageFrame()
81:                 THIS.ConfigurarPaginaLista()
82:                 THIS.ConfigurarPaginaDados()
83:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
84: 
85:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
86:                     IF !THIS.CarregarLista()
87:                         *-- Se falhar ao carregar, nao impede abertura
88:                     ENDIF

*-- Linhas 109 a 129:
109:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
110: 
111:         WITH THIS.pgf_4c_Paginas
112:             .Top       = -29
113:             .Left      = 0
114:             .Width     = 1003
115:             .Height    = 660
116:             .PageCount = 2
117:             .Tabs      = .F.
118:             .Visible   = .T.
119: 
120:             .Page1.Caption  = "Lista"
121:             .Page1.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
122:             .Page1.BackColor = RGB(255, 255, 255)
123: 
124:             .Page2.Caption  = "Dados"
125:             .Page2.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
126:             .Page2.BackColor = RGB(255, 255, 255)
127:         ENDWITH
128:     ENDPROC
129: 

*-- Linhas 139 a 161:
139:         *-- Container cabecalho
140:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
141:         WITH loc_oPagina.cnt_4c_Cabecalho
142:             .Top         = 31
143:             .Left        = 0
144:             .Width       = 1020
145:             .Height      = 80
146:             .BackStyle   = 1
147:             .BackColor   = RGB(53, 53, 53)
148:             .BorderWidth = 0
149:             .Visible     = .T.
150:         ENDWITH
151: 
152:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
153:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
154:             .Caption   = "Cadastro de Produtos"
155:             .Top       = 20
156:             .Left      = 20
157:             .Width     = 400
158:             .Height    = 30
159:             .FontName  = "Tahoma"
160:             .FontSize  = 14
161:             .FontBold  = .T.

*-- Linhas 167 a 335:
167:         *-- Container de botoes CRUD (Grupo_op: Left=542 no legado, Top=0 -> 29)
168:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
169:         WITH loc_oPagina.cnt_4c_Botoes
170:             .Top         = 29
171:             .Left        = 542
172:             .Width       = 380
173:             .Height      = 85
174:             .BackStyle = 1
175:             .BackColor = RGB(53, 53, 53)
176:             .BorderWidth = 0
177:             .Visible     = .T.
178:         ENDWITH
179: 
180:         *-- Botao Incluir (Left=5)
181:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
182:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
183:             .Caption         = "Incluir"
184:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
185:             .PicturePosition = 13
186:             .Width           = 75
187:             .Height          = 75
188:             .Left            = 5
189:             .Top             = 5
190:             .FontName        = "Tahoma"
191:             .FontSize        = 8
192:             .Themes          = .F.
193:             .SpecialEffect   = 0
194:             .BackColor       = RGB(255, 255, 255)
195:             .ForeColor       = RGB(90, 90, 90)
196:             .Visible         = .T.
197:         ENDWITH
198:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
199: 
200:         *-- Botao Visualizar (Left=80)
201:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
202:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
203:             .Caption         = "Visualizar"
204:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
205:             .PicturePosition = 13
206:             .Width           = 75
207:             .Height          = 75
208:             .Left            = 80
209:             .Top             = 5
210:             .FontName        = "Tahoma"
211:             .FontSize        = 8
212:             .Themes          = .F.
213:             .SpecialEffect   = 0
214:             .BackColor       = RGB(255, 255, 255)
215:             .ForeColor       = RGB(90, 90, 90)
216:             .Visible         = .T.
217:         ENDWITH
218:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
219: 
220:         *-- Botao Alterar (Left=155)
221:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
222:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
223:             .Caption         = "Alterar"
224:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
225:             .PicturePosition = 13
226:             .Width           = 75
227:             .Height          = 75
228:             .Left            = 155
229:             .Top             = 5
230:             .FontName        = "Tahoma"
231:             .FontSize        = 8
232:             .Themes          = .F.
233:             .SpecialEffect   = 0
234:             .BackColor       = RGB(255, 255, 255)
235:             .ForeColor       = RGB(90, 90, 90)
236:             .Visible         = .T.
237:         ENDWITH
238:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
239: 
240:         *-- Botao Excluir (Left=230)
241:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
242:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
243:             .Caption         = "Excluir"
244:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
245:             .PicturePosition = 13
246:             .Width           = 75
247:             .Height          = 75
248:             .Left            = 230
249:             .Top             = 5
250:             .FontName        = "Tahoma"
251:             .FontSize        = 8
252:             .Themes          = .F.
253:             .SpecialEffect   = 0
254:             .BackColor       = RGB(255, 255, 255)
255:             .ForeColor       = RGB(90, 90, 90)
256:             .Visible         = .T.
257:         ENDWITH
258:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
259: 
260:         *-- Botao Buscar (Left=305)
261:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
262:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
263:             .Caption         = "Buscar"
264:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
265:             .PicturePosition = 13
266:             .Width           = 75
267:             .Height          = 75
268:             .Left            = 305
269:             .Top             = 5
270:             .FontName        = "Tahoma"
271:             .FontSize        = 8
272:             .Themes          = .F.
273:             .SpecialEffect   = 0
274:             .BackColor       = RGB(255, 255, 255)
275:             .ForeColor       = RGB(90, 90, 90)
276:             .Visible         = .T.
277:         ENDWITH
278:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
279: 
280:         *-- Container de saida separado (Left=917, Top=29)
281:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
282:         WITH loc_oPagina.cnt_4c_Saida
283:             .Top         = 29
284:             .Left        = 917
285:             .Width       = 90
286:             .Height      = 85
287:             .BackStyle = 1
288:             .BackColor = RGB(53, 53, 53)
289:             .BorderWidth = 0
290:             .Visible     = .T.
291:         ENDWITH
292: 
293:         *-- Botao Encerrar
294:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
295:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
296:             .Caption         = "Encerrar"
297:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
298:             .PicturePosition = 13
299:             .Width           = 75
300:             .Height          = 75
301:             .Left            = 5
302:             .Top             = 5
303:             .FontName        = "Tahoma"
304:             .FontSize        = 8
305:             .Themes          = .F.
306:             .SpecialEffect   = 0
307:             .BackColor       = RGB(255, 255, 255)
308:             .ForeColor       = RGB(90, 90, 90)
309:             .Visible         = .T.
310:         ENDWITH
311:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
312: 
313:         *-- Container de filtros (cntFiltros legado: continha getCgru/getDgru/getDtIni/Fim/optFilSituas)
314:         loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
315:         WITH loc_oPagina.cnt_4c_Filtros
316:             .Top         = 120
317:             .Left        = 12
318:             .Width       = 940
319:             .Height      = 55
320:             .BackStyle   = 0
321:             .BorderWidth = 0
322:             .Visible     = .T.
323:         ENDWITH
324: 
325:         *-- Filtro: Label Grupo
326:         loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_LblGrupo", "Label")
327:         WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_LblGrupo
328:             .Caption   = "Grupo:"
329:             .Left      = 5
330:             .Top       = 8
331:             .Width     = 40
332:             .Height    = 15
333:             .FontName  = "Tahoma"
334:             .FontSize  = 8
335:             .BackStyle = 0

*-- Linhas 341 a 350:
341:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_FiltroCgru", "TextBox")
342:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_FiltroCgru
343:             .Value         = ""
344:             .Left          = 47
345:             .Top           = 3
346:             .Width         = 35
347:             .Height        = 22
348:             .FontName      = "Tahoma"
349:             .FontSize      = 8
350:             .SpecialEffect = 1

*-- Linhas 358 a 383:
358:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_FiltroDgru", "TextBox")
359:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_FiltroDgru
360:             .Value         = ""
361:             .Left          = 84
362:             .Top           = 3
363:             .Width         = 156
364:             .Height        = 22
365:             .FontName      = "Tahoma"
366:             .FontSize      = 8
367:             .SpecialEffect = 1
368:             .ReadOnly      = .T.
369:             .Enabled       = .F.
370:             .Visible       = .T.
371:         ENDWITH
372: 
373:         *-- Filtro: Label Ultima alteracao
374:         loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_LblData", "Label")
375:         WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_LblData
376:             .Caption   = "Ult. Alt.:"
377:             .Left      = 248
378:             .Top       = 8
379:             .Width     = 52
380:             .Height    = 15
381:             .FontName  = "Tahoma"
382:             .FontSize  = 8
383:             .BackStyle = 0

*-- Linhas 389 a 412:
389:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_FiltroDataIni", "TextBox")
390:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_FiltroDataIni
391:             .Value         = {}
392:             .Left          = 302
393:             .Top           = 3
394:             .Width         = 80
395:             .Height        = 22
396:             .FontName      = "Tahoma"
397:             .FontSize      = 8
398:             .SpecialEffect = 1
399:             .Visible       = .T.
400:         ENDWITH
401: 
402:         *-- Filtro: Label "ate"
403:         loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_LblAte", "Label")
404:         WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_LblAte
405:             .Caption   = "at" + CHR(233) + ":"
406:             .Left      = 386
407:             .Top       = 8
408:             .Width     = 22
409:             .Height    = 15
410:             .FontName  = "Tahoma"
411:             .FontSize  = 8
412:             .BackStyle = 0

*-- Linhas 418 a 497:
418:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_FiltroDataFim", "TextBox")
419:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_FiltroDataFim
420:             .Value         = {}
421:             .Left          = 410
422:             .Top           = 3
423:             .Width         = 80
424:             .Height        = 22
425:             .FontName      = "Tahoma"
426:             .FontSize      = 8
427:             .SpecialEffect = 1
428:             .Visible       = .T.
429:         ENDWITH
430: 
431:         *-- Filtro: Situacao (Todos/Ativos/Inativos) - legado: optFilSituas
432:         loc_oPagina.cnt_4c_Filtros.AddObject("opt_4c_FiltraSituas", "OptionGroup")
433:         WITH loc_oPagina.cnt_4c_Filtros.opt_4c_FiltraSituas
434:             .Left        = 500
435:             .Top         = 3
436:             .Width       = 200
437:             .Height      = 25
438:             .ButtonCount = 3
439:             .BorderStyle = 0
440:             .Themes      = .F.
441:             .Value       = 1
442:             .Visible     = .T.
443:         ENDWITH
444:         WITH loc_oPagina.cnt_4c_Filtros.opt_4c_FiltraSituas
445:             .Buttons(1).Caption   = "Todos"
446:             .Buttons(1).Left      = 0
447:             .Buttons(1).Top       = 0
448:             .Buttons(1).AutoSize  = .T.
449:             .Buttons(1).Themes    = .F.
450:             .Buttons(1).FontName  = "Tahoma"
451:             .Buttons(1).FontSize  = 8
452:             .Buttons(2).Caption   = "Ativos"
453:             .Buttons(2).Left      = 65
454:             .Buttons(2).Top       = 0
455:             .Buttons(2).AutoSize  = .T.
456:             .Buttons(2).Themes    = .F.
457:             .Buttons(2).FontName  = "Tahoma"
458:             .Buttons(2).FontSize  = 8
459:             .Buttons(3).Caption   = "Inativos"
460:             .Buttons(3).Left      = 130
461:             .Buttons(3).Top       = 0
462:             .Buttons(3).AutoSize  = .T.
463:             .Buttons(3).Themes    = .F.
464:             .Buttons(3).FontName  = "Tahoma"
465:             .Buttons(3).FontSize  = 8
466:         ENDWITH
467:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.opt_4c_FiltraSituas, "InteractiveChange", THIS, "FiltroSituas_InteractiveChange")
468: 
469:         *-- Botao Pesquisar
470:         loc_oPagina.cnt_4c_Filtros.AddObject("cmd_4c_Pesquisar", "CommandButton")
471:         WITH loc_oPagina.cnt_4c_Filtros.cmd_4c_Pesquisar
472:             .Caption         = "Pesquisar"
473:             .Left            = 708
474:             .Top             = 2
475:             .Width           = 75
476:             .Height          = 22
477:             .FontName        = "Tahoma"
478:             .FontSize        = 8
479:             .Themes          = .F.
480:             .SpecialEffect   = 0
481:             .BackColor       = RGB(255, 255, 255)
482:             .ForeColor       = RGB(90, 90, 90)
483:             .Visible         = .T.
484:         ENDWITH
485:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.cmd_4c_Pesquisar, "Click", THIS, "BtnPesquisarClick")
486: 
487:         *-- Label contador de produtos (legado: lblProdutos top=584)
488:         loc_oPagina.AddObject("lbl_4c_ContadorProdutos", "Label")
489:         WITH loc_oPagina.lbl_4c_ContadorProdutos
490:             .Caption   = "0 produto(s)"
491:             .Top       = 583
492:             .Left      = 38
493:             .Width     = 200
494:             .Height    = 15
495:             .FontName  = "Tahoma"
496:             .FontSize  = 8
497:             .BackStyle = 0

*-- Linhas 503 a 512:
503:         *-- 7 colunas: cpros, dpros, cgrus, sgrus, reffs, usuaalts, situacao
504:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
505:         WITH loc_oPagina.grd_4c_Lista
506:             .Top               = 182
507:             .Left              = 12
508:             .Width             = 940
509:             .Height            = 395
510:             .ReadOnly          = .T.
511:             .DeleteMark        = .F.
512:             .RecordMark        = .F.

*-- Linhas 532 a 661:
532:         *-- Container de botoes Salvar/Cancelar (Top=34, Left=819)
533:         loc_oPagina.AddObject("cnt_4c_BotoesDados", "Container")
534:         WITH loc_oPagina.cnt_4c_BotoesDados
535:             .Top         = 34
536:             .Left        = 819
537:             .Width       = 165
538:             .Height      = 85
539:             .BackStyle = 1
540:             .BackColor = RGB(53, 53, 53)
541:             .BorderWidth = 0
542:             .Visible     = .T.
543:         ENDWITH
544: 
545:         *-- Botao Salvar (Left=7, Top=5)
546:         loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Salvar", "CommandButton")
547:         WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Salvar
548:             .Caption         = "Salvar"
549:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
550:             .PicturePosition = 13
551:             .Width           = 75
552:             .Height          = 75
553:             .Left            = 7
554:             .Top             = 5
555:             .FontName        = "Tahoma"
556:             .FontSize        = 8
557:             .Themes          = .F.
558:             .SpecialEffect   = 0
559:             .BackColor       = RGB(255, 255, 255)
560:             .ForeColor       = RGB(90, 90, 90)
561:             .Visible         = .T.
562:         ENDWITH
563:         BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")
564: 
565:         *-- Botao Cancelar (Left=83, Top=5)
566:         loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Cancelar", "CommandButton")
567:         WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar
568:             .Caption         = "Cancelar"
569:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
570:             .PicturePosition = 13
571:             .Width           = 75
572:             .Height          = 75
573:             .Left            = 83
574:             .Top             = 5
575:             .FontName        = "Tahoma"
576:             .FontSize        = 8
577:             .Themes          = .F.
578:             .SpecialEffect   = 0
579:             .BackColor       = RGB(255, 255, 255)
580:             .ForeColor       = RGB(90, 90, 90)
581:             .Visible         = .T.
582:         ENDWITH
583:         BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
584: 
585:         *-- OptionGroup para navegacao entre abas internas
586:         *-- Legado: Optiongroup1 top=5->34, left=5, width=535, height=85, buttonCount=7
587:         loc_oPagina.AddObject("opt_4c_Abas", "OptionGroup")
588:         WITH loc_oPagina.opt_4c_Abas
589:             .Left        = 5
590:             .Top         = 34
591:             .Width       = 800
592:             .Height      = 85
593:             .ButtonCount = 7
594:             .BorderStyle = 0
595:             .Themes      = .F.
596:             .Value       = 1
597:             .Visible     = .T.
598:         ENDWITH
599:         WITH loc_oPagina.opt_4c_Abas
600:             .Buttons(1).Caption   = "Principal"
601:             .Buttons(1).Left      = 0
602:             .Buttons(1).Top       = 25
603:             .Buttons(1).Width     = 85
604:             .Buttons(1).Height    = 30
605:             .Buttons(1).Themes    = .F.
606:             .Buttons(1).FontName  = "Tahoma"
607:             .Buttons(1).FontSize  = 8
608:             .Buttons(1).ForeColor = RGB(50, 50, 50)
609:             .Buttons(2).Caption   = "Composi" + CHR(231) + CHR(227) + "o"
610:             .Buttons(2).Left      = 90
611:             .Buttons(2).Top       = 25
612:             .Buttons(2).Width     = 90
613:             .Buttons(2).Height    = 30
614:             .Buttons(2).Themes    = .F.
615:             .Buttons(2).FontName  = "Tahoma"
616:             .Buttons(2).FontSize  = 8
617:             .Buttons(2).ForeColor = RGB(50, 50, 50)
618:             .Buttons(3).Caption   = "Custos"
619:             .Buttons(3).Left      = 185
620:             .Buttons(3).Top       = 25
621:             .Buttons(3).Width     = 75
622:             .Buttons(3).Height    = 30
623:             .Buttons(3).Themes    = .F.
624:             .Buttons(3).FontName  = "Tahoma"
625:             .Buttons(3).FontSize  = 8
626:             .Buttons(3).ForeColor = RGB(50, 50, 50)
627:             .Buttons(4).Caption   = "Dados Fiscais"
628:             .Buttons(4).Left      = 265
629:             .Buttons(4).Top       = 25
630:             .Buttons(4).Width     = 90
631:             .Buttons(4).Height    = 30
632:             .Buttons(4).Themes    = .F.
633:             .Buttons(4).FontName  = "Tahoma"
634:             .Buttons(4).FontSize  = 8
635:             .Buttons(4).ForeColor = RGB(50, 50, 50)
636:             .Buttons(5).Caption   = "Designer"
637:             .Buttons(5).Left      = 360
638:             .Buttons(5).Top       = 25
639:             .Buttons(5).Width     = 75
640:             .Buttons(5).Height    = 30
641:             .Buttons(5).Themes    = .F.
642:             .Buttons(5).FontName  = "Tahoma"
643:             .Buttons(5).FontSize  = 8
644:             .Buttons(5).ForeColor = RGB(50, 50, 50)
645:             .Buttons(6).Caption   = "Consulta P."
646:             .Buttons(6).Left      = 440
647:             .Buttons(6).Top       = 25
648:             .Buttons(6).Width     = 85
649:             .Buttons(6).Height    = 30
650:             .Buttons(6).Themes    = .F.
651:             .Buttons(6).FontName  = "Tahoma"
652:             .Buttons(6).FontSize  = 8
653:             .Buttons(6).ForeColor = RGB(50, 50, 50)
654:             .Buttons(7).Caption   = "Fases"
655:             .Buttons(7).Left      = 530
656:             .Buttons(7).Top       = 25
657:             .Buttons(7).Width     = 60
658:             .Buttons(7).Height    = 30
659:             .Buttons(7).Themes    = .F.
660:             .Buttons(7).FontName  = "Tahoma"
661:             .Buttons(7).FontSize  = 8

*-- Linhas 667 a 695:
667:         *-- Tabs=.F. para ocultar abas (navegacao pelo OptionGroup)
668:         loc_oPagina.AddObject("pgf_4c_Dados", "PageFrame")
669:         WITH loc_oPagina.pgf_4c_Dados
670:             .Top       = -54
671:             .Left      = -1
672:             .Width     = 1003
673:             .Height    = 685
674:             .PageCount = 7
675:             .Tabs      = .F.
676:             .Visible   = .T.
677: 
678:             .Page1.Caption  = "Principal"
679:             .Page1.BackColor = RGB(255, 255, 255)
680:             .Page2.Caption  = "Composicao"
681:             .Page2.BackColor = RGB(255, 255, 255)
682:             .Page3.Caption  = "Custos"
683:             .Page3.BackColor = RGB(255, 255, 255)
684:             .Page4.Caption  = "Dados Fiscais"
685:             .Page4.BackColor = RGB(255, 255, 255)
686:             .Page5.Caption  = "Designer"
687:             .Page5.BackColor = RGB(255, 255, 255)
688:             .Page6.Caption  = "Consulta"
689:             .Page6.BackColor = RGB(255, 255, 255)
690:             .Page7.Caption  = "Fases"
691:             .Page7.BackColor = RGB(255, 255, 255)
692:         ENDWITH
693: 
694:         *-- Configurar conteudo de cada aba
695:         THIS.ConfigurarTabPrincipal()

*-- Linhas 716 a 821:
716: 
717:         *-- === CODIGO e DESCRICAO =============================================
718: 
719:         loc_oPg.AddObject("lbl_4c_LblCpros", "Label")
720:         WITH loc_oPg.lbl_4c_LblCpros
721:             .Caption = "Produto :"
722:             .Top = 134
723:             .Left = 58
724:             .Width = 53
725:             .Height = 15
726:             .FontName = "Tahoma"
727:             .FontSize = 8
728:             .BackStyle = 0
729:             .ForeColor = RGB(90,90,90)
730:         ENDWITH
731: 
732:         loc_oPg.AddObject("txt_4c_Cpros", "TextBox")
733:         WITH loc_oPg.txt_4c_Cpros
734:             .Value = ""
735:             .Top = 130
736:             .Left = 113
737:             .Width = 108
738:             .Height = 23
739:             .FontName = "Tahoma"
740:             .FontSize = 8
741:             .SpecialEffect = 1
742:             .MaxLength = 14
743:         ENDWITH
744: 
745:         loc_oPg.AddObject("lbl_4c_LblDpros", "Label")
746:         WITH loc_oPg.lbl_4c_LblDpros
747:             .Caption = "Descri" + CHR(231) + CHR(227) + "o :"
748:             .Top = 134
749:             .Left = 222
750:             .Width = 70
751:             .Height = 15
752:             .FontName = "Tahoma"
753:             .FontSize = 8
754:             .BackStyle = 0
755:             .ForeColor = RGB(90,90,90)
756:         ENDWITH
757: 
758:         loc_oPg.AddObject("txt_4c_Dpros", "TextBox")
759:         WITH loc_oPg.txt_4c_Dpros
760:             .Value = ""
761:             .Top = 130
762:             .Left = 222
763:             .Width = 290
764:             .Height = 23
765:             .FontName = "Tahoma"
766:             .FontSize = 8
767:             .SpecialEffect = 1
768:             .MaxLength = 65
769:         ENDWITH
770: 
771:         loc_oPg.AddObject("lbl_4c_LblDpro2s", "Label")
772:         WITH loc_oPg.lbl_4c_LblDpro2s
773:             .Caption = "Descritivo :"
774:             .Top = 158
775:             .Left = 55
776:             .Width = 56
777:             .Height = 15
778:             .FontName = "Tahoma"
779:             .FontSize = 8
780:             .BackStyle = 0
781:             .ForeColor = RGB(90,90,90)
782:         ENDWITH
783: 
784:         loc_oPg.AddObject("txt_4c_Dpro2s", "TextBox")
785:         WITH loc_oPg.txt_4c_Dpro2s
786:             .Value = ""
787:             .Top = 154
788:             .Left = 113
789:             .Width = 399
790:             .Height = 23
791:             .FontName = "Tahoma"
792:             .FontSize = 8
793:             .SpecialEffect = 1
794:             .MaxLength = 45
795:         ENDWITH
796: 
797:         *-- === GRUPO / SUBGRUPO ===============================================
798: 
799:         loc_oPg.AddObject("lbl_4c_LblCgrus", "Label")
800:         WITH loc_oPg.lbl_4c_LblCgrus
801:             .Caption = "Grupo :"
802:             .Top = 182
803:             .Left = 73
804:             .Width = 38
805:             .Height = 15
806:             .FontName = "Tahoma"
807:             .FontSize = 8
808:             .BackStyle = 0
809:             .ForeColor = RGB(90,90,90)
810:         ENDWITH
811: 
812:         loc_oPg.AddObject("txt_4c_Cgrus", "TextBox")
813:         WITH loc_oPg.txt_4c_Cgrus
814:             .Value = ""
815:             .Top = 178
816:             .Left = 113
817:             .Width = 31
818:             .Height = 23
819:             .FontName = "Tahoma"
820:             .FontSize = 8
821:             .SpecialEffect = 1

*-- Linhas 827 a 905:
827:         loc_oPg.AddObject("txt_4c_Dgrus", "TextBox")
828:         WITH loc_oPg.txt_4c_Dgrus
829:             .Value = ""
830:             .Top = 178
831:             .Left = 145
832:             .Width = 171
833:             .Height = 23
834:             .FontName = "Tahoma"
835:             .FontSize = 8
836:             .SpecialEffect = 1
837:             .ReadOnly = .T.
838:             .Enabled = .F.
839:         ENDWITH
840: 
841:         loc_oPg.AddObject("lbl_4c_LblSgrus", "Label")
842:         WITH loc_oPg.lbl_4c_LblSgrus
843:             .Caption = "Subgrupo :"
844:             .Top = 206
845:             .Left = 56
846:             .Width = 55
847:             .Height = 15
848:             .FontName = "Tahoma"
849:             .FontSize = 8
850:             .BackStyle = 0
851:             .ForeColor = RGB(90,90,90)
852:         ENDWITH
853: 
854:         loc_oPg.AddObject("txt_4c_Csgrus", "TextBox")
855:         WITH loc_oPg.txt_4c_Csgrus
856:             .Value = ""
857:             .Top = 202
858:             .Left = 113
859:             .Width = 52
860:             .Height = 23
861:             .FontName = "Tahoma"
862:             .FontSize = 8
863:             .SpecialEffect = 1
864:             .MaxLength = 6
865:         ENDWITH
866: 
867:         loc_oPg.AddObject("txt_4c_Dsgrus", "TextBox")
868:         WITH loc_oPg.txt_4c_Dsgrus
869:             .Value = ""
870:             .Top = 202
871:             .Left = 166
872:             .Width = 150
873:             .Height = 23
874:             .FontName = "Tahoma"
875:             .FontSize = 8
876:             .SpecialEffect = 1
877:             .ReadOnly = .T.
878:             .Enabled = .F.
879:         ENDWITH
880: 
881:         *-- === LINHA / COLECAO ================================================
882: 
883:         loc_oPg.AddObject("lbl_4c_LblLinhas", "Label")
884:         WITH loc_oPg.lbl_4c_LblLinhas
885:             .Caption = "Linha :"
886:             .Top = 230
887:             .Left = 77
888:             .Width = 34
889:             .Height = 15
890:             .FontName = "Tahoma"
891:             .FontSize = 8
892:             .BackStyle = 0
893:             .ForeColor = RGB(90,90,90)
894:         ENDWITH
895: 
896:         loc_oPg.AddObject("txt_4c_Linhas", "TextBox")
897:         WITH loc_oPg.txt_4c_Linhas
898:             .Value = ""
899:             .Top = 226
900:             .Left = 113
901:             .Width = 80
902:             .Height = 23
903:             .FontName = "Tahoma"
904:             .FontSize = 8
905:             .SpecialEffect = 1

*-- Linhas 911 a 947:
911:         loc_oPg.AddObject("txt_4c_Dlinhas", "TextBox")
912:         WITH loc_oPg.txt_4c_Dlinhas
913:             .Value = ""
914:             .Top = 226
915:             .Left = 194
916:             .Width = 318
917:             .Height = 23
918:             .FontName = "Tahoma"
919:             .FontSize = 8
920:             .SpecialEffect = 1
921:             .ReadOnly = .T.
922:             .Enabled = .F.
923:         ENDWITH
924: 
925:         loc_oPg.AddObject("lbl_4c_LblColecoes", "Label")
926:         WITH loc_oPg.lbl_4c_LblColecoes
927:             .Caption = "Grupo de Venda :"
928:             .Top = 253
929:             .Left = 25
930:             .Width = 86
931:             .Height = 15
932:             .FontName = "Tahoma"
933:             .FontSize = 8
934:             .BackStyle = 0
935:             .ForeColor = RGB(90,90,90)
936:         ENDWITH
937: 
938:         loc_oPg.AddObject("txt_4c_Colecoes", "TextBox")
939:         WITH loc_oPg.txt_4c_Colecoes
940:             .Value = ""
941:             .Top = 250
942:             .Left = 113
943:             .Width = 80
944:             .Height = 23
945:             .FontName = "Tahoma"
946:             .FontSize = 8
947:             .SpecialEffect = 1

*-- Linhas 953 a 991:
953:         loc_oPg.AddObject("txt_4c_Dcolecoes", "TextBox")
954:         WITH loc_oPg.txt_4c_Dcolecoes
955:             .Value = ""
956:             .Top = 250
957:             .Left = 194
958:             .Width = 318
959:             .Height = 23
960:             .FontName = "Tahoma"
961:             .FontSize = 8
962:             .SpecialEffect = 1
963:             .ReadOnly = .T.
964:             .Enabled = .F.
965:         ENDWITH
966: 
967:         *-- === FORNECEDOR / REF ==============================================
968: 
969:         loc_oPg.AddObject("lbl_4c_LblIfors", "Label")
970:         WITH loc_oPg.lbl_4c_LblIfors
971:             .Caption = "Fornecedor :"
972:             .Top = 278
973:             .Left = 47
974:             .Width = 64
975:             .Height = 15
976:             .FontName = "Tahoma"
977:             .FontSize = 8
978:             .BackStyle = 0
979:             .ForeColor = RGB(90,90,90)
980:         ENDWITH
981: 
982:         loc_oPg.AddObject("txt_4c_Ifors", "TextBox")
983:         WITH loc_oPg.txt_4c_Ifors
984:             .Value = ""
985:             .Top = 274
986:             .Left = 113
987:             .Width = 80
988:             .Height = 23
989:             .FontName = "Tahoma"
990:             .FontSize = 8
991:             .SpecialEffect = 1

*-- Linhas 997 a 1762:
997:         loc_oPg.AddObject("txt_4c_Dfors", "TextBox")
998:         WITH loc_oPg.txt_4c_Dfors
999:             .Value = ""
1000:             .Top = 274
1001:             .Left = 194
1002:             .Width = 318
1003:             .Height = 23
1004:             .FontName = "Tahoma"
1005:             .FontSize = 8
1006:             .SpecialEffect = 1
1007:             .ReadOnly = .T.
1008:             .Enabled = .F.
1009:         ENDWITH
1010: 
1011:         loc_oPg.AddObject("lbl_4c_LblReffs", "Label")
1012:         WITH loc_oPg.lbl_4c_LblReffs
1013:             .Caption = "Ref. Fornecedor :"
1014:             .Top = 301
1015:             .Left = 23
1016:             .Width = 88
1017:             .Height = 15
1018:             .FontName = "Tahoma"
1019:             .FontSize = 8
1020:             .BackStyle = 0
1021:             .ForeColor = RGB(90,90,90)
1022:         ENDWITH
1023: 
1024:         loc_oPg.AddObject("txt_4c_Reffs", "TextBox")
1025:         WITH loc_oPg.txt_4c_Reffs
1026:             .Value = ""
1027:             .Top = 298
1028:             .Left = 113
1029:             .Width = 152
1030:             .Height = 23
1031:             .FontName = "Tahoma"
1032:             .FontSize = 8
1033:             .SpecialEffect = 1
1034:             .MaxLength = 40
1035:         ENDWITH
1036: 
1037:         *-- === CODIGOS AUX (Tipo/Identificador/Conjunto) =====================
1038: 
1039:         loc_oPg.AddObject("lbl_4c_LblMercs", "Label")
1040:         WITH loc_oPg.lbl_4c_LblMercs
1041:             .Caption = "Tipo :"
1042:             .Top = 182
1043:             .Left = 324
1044:             .Width = 30
1045:             .Height = 15
1046:             .FontName = "Tahoma"
1047:             .FontSize = 8
1048:             .BackStyle = 0
1049:             .ForeColor = RGB(90,90,90)
1050:         ENDWITH
1051: 
1052:         loc_oPg.AddObject("txt_4c_Mercs", "TextBox")
1053:         WITH loc_oPg.txt_4c_Mercs
1054:             .Value = ""
1055:             .Top = 178
1056:             .Left = 318
1057:             .Width = 31
1058:             .Height = 23
1059:             .FontName = "Tahoma"
1060:             .FontSize = 8
1061:             .SpecialEffect = 1
1062:             .MaxLength = 3
1063:         ENDWITH
1064: 
1065:         loc_oPg.AddObject("lbl_4c_LblIdecpros", "Label")
1066:         WITH loc_oPg.lbl_4c_LblIdecpros
1067:             .Caption = "Identificador :"
1068:             .Top = 182
1069:             .Left = 408
1070:             .Width = 70
1071:             .Height = 15
1072:             .FontName = "Tahoma"
1073:             .FontSize = 8
1074:             .BackStyle = 0
1075:             .ForeColor = RGB(90,90,90)
1076:         ENDWITH
1077: 
1078:         loc_oPg.AddObject("txt_4c_Idecpros", "TextBox")
1079:         WITH loc_oPg.txt_4c_Idecpros
1080:             .Value = ""
1081:             .Top = 178
1082:             .Left = 481
1083:             .Width = 31
1084:             .Height = 23
1085:             .FontName = "Tahoma"
1086:             .FontSize = 8
1087:             .SpecialEffect = 1
1088:             .MaxLength = 3
1089:         ENDWITH
1090: 
1091:         loc_oPg.AddObject("lbl_4c_LblConj", "Label")
1092:         WITH loc_oPg.lbl_4c_LblConj
1093:             .Caption = "Conjunto :"
1094:             .Top = 206
1095:             .Left = 408
1096:             .Width = 53
1097:             .Height = 15
1098:             .FontName = "Tahoma"
1099:             .FontSize = 8
1100:             .BackStyle = 0
1101:             .ForeColor = RGB(90,90,90)
1102:         ENDWITH
1103: 
1104:         loc_oPg.AddObject("txt_4c_Conjunts", "TextBox")
1105:         WITH loc_oPg.txt_4c_Conjunts
1106:             .Value = ""
1107:             .Top = 202
1108:             .Left = 460
1109:             .Width = 52
1110:             .Height = 23
1111:             .FontName = "Tahoma"
1112:             .FontSize = 8
1113:             .SpecialEffect = 1
1114:             .MaxLength = 6
1115:         ENDWITH
1116: 
1117:         *-- === COLUNA DIREITA: EQUIVALENTE / BARRA / EAN ====================
1118: 
1119:         loc_oPg.AddObject("lbl_4c_LblCproeqs", "Label")
1120:         WITH loc_oPg.lbl_4c_LblCproeqs
1121:             .Caption = "Equivalente :"
1122:             .Top = 137
1123:             .Left = 560
1124:             .Width = 65
1125:             .Height = 15
1126:             .FontName = "Tahoma"
1127:             .FontSize = 8
1128:             .BackStyle = 0
1129:             .ForeColor = RGB(90,90,90)
1130:         ENDWITH
1131: 
1132:         loc_oPg.AddObject("txt_4c_Cproeqs", "TextBox")
1133:         WITH loc_oPg.txt_4c_Cproeqs
1134:             .Value = ""
1135:             .Top = 133
1136:             .Left = 626
1137:             .Width = 108
1138:             .Height = 21
1139:             .FontName = "Tahoma"
1140:             .FontSize = 8
1141:             .SpecialEffect = 1
1142:             .MaxLength = 14
1143:         ENDWITH
1144:         BINDEVENT(loc_oPg.txt_4c_Cproeqs, "KeyPress", THIS, "TabPrincipal_CproeqsKeyPress")
1145: 
1146:         loc_oPg.AddObject("lbl_4c_LblCbars", "Label")
1147:         WITH loc_oPg.lbl_4c_LblCbars
1148:             .Caption = "Barra :"
1149:             .Top = 157
1150:             .Left = 590
1151:             .Width = 35
1152:             .Height = 15
1153:             .FontName = "Tahoma"
1154:             .FontSize = 8
1155:             .BackStyle = 0
1156:             .ForeColor = RGB(90,90,90)
1157:         ENDWITH
1158: 
1159:         loc_oPg.AddObject("txt_4c_Cbars", "TextBox")
1160:         WITH loc_oPg.txt_4c_Cbars
1161:             .Value = 0
1162:             .Top = 155
1163:             .Left = 626
1164:             .Width = 108
1165:             .Height = 21
1166:             .FontName = "Tahoma"
1167:             .FontSize = 8
1168:             .SpecialEffect = 1
1169:         ENDWITH
1170: 
1171:         loc_oPg.AddObject("lbl_4c_LblEan13", "Label")
1172:         WITH loc_oPg.lbl_4c_LblEan13
1173:             .Caption = "EAN/GTIN :"
1174:             .Top = 181
1175:             .Left = 568
1176:             .Width = 57
1177:             .Height = 15
1178:             .FontName = "Tahoma"
1179:             .FontSize = 8
1180:             .BackStyle = 0
1181:             .ForeColor = RGB(90,90,90)
1182:         ENDWITH
1183: 
1184:         loc_oPg.AddObject("txt_4c_Ean13", "TextBox")
1185:         WITH loc_oPg.txt_4c_Ean13
1186:             .Value = 0
1187:             .Top = 177
1188:             .Left = 626
1189:             .Width = 108
1190:             .Height = 21
1191:             .FontName = "Tahoma"
1192:             .FontSize = 8
1193:             .SpecialEffect = 1
1194:         ENDWITH
1195: 
1196:         *-- === SITUACAO / DATA SITUACAO ======================================
1197: 
1198:         loc_oPg.AddObject("opt_4c_Situas", "OptionGroup")
1199:         WITH loc_oPg.opt_4c_Situas
1200:             .Top = 130
1201:             .Left = 735
1202:             .Width = 142
1203:             .Height = 25
1204:             .ButtonCount = 2
1205:             .BorderStyle = 0
1206:             .Themes = .F.
1207:             .Value = 1
1208:         ENDWITH
1209:         WITH loc_oPg.opt_4c_Situas
1210:             .Buttons(1).Caption = "Ativo"
1211:             .Buttons(1).Left = 0
1212:             .Buttons(1).Top = 0
1213:             .Buttons(1).AutoSize = .T.
1214:             .Buttons(1).Themes = .F.
1215:             .Buttons(1).FontName = "Tahoma"
1216:             .Buttons(1).FontSize = 8
1217:             .Buttons(2).Caption = "Inativo"
1218:             .Buttons(2).Left = 60
1219:             .Buttons(2).Top = 0
1220:             .Buttons(2).AutoSize = .T.
1221:             .Buttons(2).Themes = .F.
1222:             .Buttons(2).FontName = "Tahoma"
1223:             .Buttons(2).FontSize = 8
1224:         ENDWITH
1225:         BINDEVENT(loc_oPg.opt_4c_Situas, "InteractiveChange", THIS, "OptSituasChange")
1226: 
1227:         loc_oPg.AddObject("txt_4c_DtSituas", "TextBox")
1228:         WITH loc_oPg.txt_4c_DtSituas
1229:             .Value = {}
1230:             .Top = 132
1231:             .Left = 878
1232:             .Width = 80
1233:             .Height = 21
1234:             .FontName = "Tahoma"
1235:             .FontSize = 8
1236:             .SpecialEffect = 1
1237:             .ReadOnly = .T.
1238:             .Enabled = .F.
1239:         ENDWITH
1240: 
1241:         *-- === LOTE MINIMO ===================================================
1242: 
1243:         loc_oPg.AddObject("lbl_4c_LblLtmins", "Label")
1244:         WITH loc_oPg.lbl_4c_LblLtmins
1245:             .Caption = "Lote M" + CHR(237) + "nimo :"
1246:             .Top = 157
1247:             .Left = 812
1248:             .Width = 65
1249:             .Height = 15
1250:             .FontName = "Tahoma"
1251:             .FontSize = 8
1252:             .BackStyle = 0
1253:             .ForeColor = RGB(90,90,90)
1254:         ENDWITH
1255: 
1256:         loc_oPg.AddObject("txt_4c_Ltminsv", "TextBox")
1257:         WITH loc_oPg.txt_4c_Ltminsv
1258:             .Value = 0
1259:             .Top = 154
1260:             .Left = 878
1261:             .Width = 80
1262:             .Height = 21
1263:             .FontName = "Tahoma"
1264:             .FontSize = 8
1265:             .SpecialEffect = 1
1266:         ENDWITH
1267: 
1268:         *-- === COLUNA DIREITA MEDIA: QTDE/OBS/ESTOQUE ========================
1269: 
1270:         loc_oPg.AddObject("lbl_4c_LblQmins", "Label")
1271:         WITH loc_oPg.lbl_4c_LblQmins
1272:             .Caption = "Qtde. M" + CHR(237) + "nima :"
1273:             .Top = 203
1274:             .Left = 553
1275:             .Width = 72
1276:             .Height = 15
1277:             .FontName = "Tahoma"
1278:             .FontSize = 8
1279:             .BackStyle = 0
1280:             .ForeColor = RGB(90,90,90)
1281:         ENDWITH
1282: 
1283:         loc_oPg.AddObject("txt_4c_Qmins", "TextBox")
1284:         WITH loc_oPg.txt_4c_Qmins
1285:             .Value = 0
1286:             .Top = 199
1287:             .Left = 626
1288:             .Width = 80
1289:             .Height = 21
1290:             .FontName = "Tahoma"
1291:             .FontSize = 8
1292:             .SpecialEffect = 1
1293:         ENDWITH
1294: 
1295:         loc_oPg.AddObject("lbl_4c_LblQtped", "Label")
1296:         WITH loc_oPg.lbl_4c_LblQtped
1297:             .Caption = "Qtde. Pedido :"
1298:             .Top = 225
1299:             .Left = 553
1300:             .Width = 72
1301:             .Height = 15
1302:             .FontName = "Tahoma"
1303:             .FontSize = 8
1304:             .BackStyle = 0
1305:             .ForeColor = RGB(90,90,90)
1306:         ENDWITH
1307: 
1308:         loc_oPg.AddObject("txt_4c_Qtped", "TextBox")
1309:         WITH loc_oPg.txt_4c_Qtped
1310:             .Value = 0
1311:             .Top = 221
1312:             .Left = 626
1313:             .Width = 80
1314:             .Height = 21
1315:             .FontName = "Tahoma"
1316:             .FontSize = 8
1317:             .SpecialEffect = 1
1318:         ENDWITH
1319: 
1320:         loc_oPg.AddObject("lbl_4c_LblObs3", "Label")
1321:         WITH loc_oPg.lbl_4c_LblObs3
1322:             .Caption = "Obs. Componente :"
1323:             .Top = 247
1324:             .Left = 529
1325:             .Width = 96
1326:             .Height = 15
1327:             .FontName = "Tahoma"
1328:             .FontSize = 8
1329:             .BackStyle = 0
1330:             .ForeColor = RGB(90,90,90)
1331:         ENDWITH
1332: 
1333:         loc_oPg.AddObject("txt_4c_Obsetqs", "TextBox")
1334:         WITH loc_oPg.txt_4c_Obsetqs
1335:             .Value = ""
1336:             .Top = 243
1337:             .Left = 626
1338:             .Width = 80
1339:             .Height = 21
1340:             .FontName = "Tahoma"
1341:             .FontSize = 8
1342:             .SpecialEffect = 1
1343:             .MaxLength = 10
1344:         ENDWITH
1345: 
1346:         loc_oPg.AddObject("lbl_4c_LblObs1", "Label")
1347:         WITH loc_oPg.lbl_4c_LblObs1
1348:             .Caption = "Observa" + CHR(231) + CHR(227) + "o :"
1349:             .Top = 269
1350:             .Left = 558
1351:             .Width = 67
1352:             .Height = 15
1353:             .FontName = "Tahoma"
1354:             .FontSize = 8
1355:             .BackStyle = 0
1356:             .ForeColor = RGB(90,90,90)
1357:         ENDWITH
1358: 
1359:         loc_oPg.AddObject("txt_4c_Obspeds", "TextBox")
1360:         WITH loc_oPg.txt_4c_Obspeds
1361:             .Value = ""
1362:             .Top = 265
1363:             .Left = 626
1364:             .Width = 220
1365:             .Height = 21
1366:             .FontName = "Tahoma"
1367:             .FontSize = 8
1368:             .SpecialEffect = 1
1369:             .MaxLength = 30
1370:         ENDWITH
1371: 
1372:         loc_oPg.AddObject("lbl_4c_LblObs2", "Label")
1373:         WITH loc_oPg.lbl_4c_LblObs2
1374:             .Caption = "Complemento :"
1375:             .Top = 290
1376:             .Left = 551
1377:             .Width = 74
1378:             .Height = 15
1379:             .FontName = "Tahoma"
1380:             .FontSize = 8
1381:             .BackStyle = 0
1382:             .ForeColor = RGB(90,90,90)
1383:         ENDWITH
1384: 
1385:         loc_oPg.AddObject("txt_4c_Obspes", "TextBox")
1386:         WITH loc_oPg.txt_4c_Obspes
1387:             .Value = ""
1388:             .Top = 287
1389:             .Left = 626
1390:             .Width = 220
1391:             .Height = 21
1392:             .FontName = "Tahoma"
1393:             .FontSize = 8
1394:             .SpecialEffect = 1
1395:             .MaxLength = 30
1396:         ENDWITH
1397: 
1398:         loc_oPg.AddObject("lbl_4c_LblUltcomp", "Label")
1399:         WITH loc_oPg.lbl_4c_LblUltcomp
1400:             .Caption = CHR(218) + "lt.Compra :"
1401:             .Top = 313
1402:             .Left = 562
1403:             .Width = 63
1404:             .Height = 15
1405:             .FontName = "Tahoma"
1406:             .FontSize = 8
1407:             .BackStyle = 0
1408:             .ForeColor = RGB(90,90,90)
1409:         ENDWITH
1410: 
1411:         loc_oPg.AddObject("txt_4c_Dtucp", "TextBox")
1412:         WITH loc_oPg.txt_4c_Dtucp
1413:             .Value = {}
1414:             .Top = 309
1415:             .Left = 626
1416:             .Width = 79
1417:             .Height = 21
1418:             .FontName = "Tahoma"
1419:             .FontSize = 8
1420:             .SpecialEffect = 1
1421:             .ReadOnly = .T.
1422:             .Enabled = .F.
1423:         ENDWITH
1424: 
1425:         loc_oPg.AddObject("txt_4c_Vucp", "TextBox")
1426:         WITH loc_oPg.txt_4c_Vucp
1427:             .Value = 0
1428:             .Top = 309
1429:             .Left = 706
1430:             .Width = 106
1431:             .Height = 21
1432:             .FontName = "Tahoma"
1433:             .FontSize = 8
1434:             .SpecialEffect = 1
1435:             .ReadOnly = .T.
1436:             .Enabled = .F.
1437:         ENDWITH
1438: 
1439:         loc_oPg.AddObject("txt_4c_Mucp", "TextBox")
1440:         WITH loc_oPg.txt_4c_Mucp
1441:             .Value = ""
1442:             .Top = 309
1443:             .Left = 813
1444:             .Width = 33
1445:             .Height = 21
1446:             .FontName = "Tahoma"
1447:             .FontSize = 8
1448:             .SpecialEffect = 1
1449:             .ReadOnly = .T.
1450:             .Enabled = .F.
1451:         ENDWITH
1452: 
1453:         loc_oPg.AddObject("lbl_4c_LblQtdultcomp", "Label")
1454:         WITH loc_oPg.lbl_4c_LblQtdultcomp
1455:             .Caption = "Qtde " + CHR(218) + "lt.Compra :"
1456:             .Top = 335
1457:             .Left = 535
1458:             .Width = 90
1459:             .Height = 15
1460:             .FontName = "Tahoma"
1461:             .FontSize = 8
1462:             .BackStyle = 0
1463:             .ForeColor = RGB(90,90,90)
1464:         ENDWITH
1465: 
1466:         loc_oPg.AddObject("txt_4c_Qtdultcomp", "TextBox")
1467:         WITH loc_oPg.txt_4c_Qtdultcomp
1468:             .Value = 0
1469:             .Top = 331
1470:             .Left = 626
1471:             .Width = 79
1472:             .Height = 21
1473:             .FontName = "Tahoma"
1474:             .FontSize = 8
1475:             .SpecialEffect = 1
1476:             .ReadOnly = .T.
1477:             .Enabled = .F.
1478:         ENDWITH
1479: 
1480:         loc_oPg.AddObject("lbl_4c_LblEstoque", "Label")
1481:         WITH loc_oPg.lbl_4c_LblEstoque
1482:             .Caption = "Estoque :"
1483:             .Top = 357
1484:             .Left = 577
1485:             .Width = 48
1486:             .Height = 15
1487:             .FontName = "Tahoma"
1488:             .FontSize = 8
1489:             .BackStyle = 0
1490:             .ForeColor = RGB(90,90,90)
1491:         ENDWITH
1492: 
1493:         loc_oPg.AddObject("txt_4c_Estoques", "TextBox")
1494:         WITH loc_oPg.txt_4c_Estoques
1495:             .Value = 0
1496:             .Top = 353
1497:             .Left = 626
1498:             .Width = 79
1499:             .Height = 21
1500:             .FontName = "Tahoma"
1501:             .FontSize = 8
1502:             .SpecialEffect = 1
1503:             .ReadOnly = .T.
1504:             .Enabled = .F.
1505:         ENDWITH
1506: 
1507:         loc_oPg.AddObject("txt_4c_QtdEsts", "TextBox")
1508:         WITH loc_oPg.txt_4c_QtdEsts
1509:             .Value = 0
1510:             .Top = 353
1511:             .Left = 706
1512:             .Width = 79
1513:             .Height = 21
1514:             .FontName = "Tahoma"
1515:             .FontSize = 8
1516:             .SpecialEffect = 1
1517:             .ReadOnly = .T.
1518:             .Enabled = .F.
1519:         ENDWITH
1520: 
1521:         *-- === PRECOS / MOEDAS ===============================================
1522: 
1523:         loc_oPg.AddObject("lbl_4c_LblCtotal", "Label")
1524:         WITH loc_oPg.lbl_4c_LblCtotal
1525:             .Caption = "Valor de Custo :"
1526:             .Top = 379
1527:             .Left = 546
1528:             .Width = 79
1529:             .Height = 15
1530:             .FontName = "Tahoma"
1531:             .FontSize = 8
1532:             .BackStyle = 0
1533:             .ForeColor = RGB(90,90,90)
1534:         ENDWITH
1535: 
1536:         loc_oPg.AddObject("txt_4c_Custofs", "TextBox")
1537:         WITH loc_oPg.txt_4c_Custofs
1538:             .Value = 0
1539:             .Top = 375
1540:             .Left = 626
1541:             .Width = 127
1542:             .Height = 21
1543:             .FontName = "Tahoma"
1544:             .FontSize = 8
1545:             .SpecialEffect = 1
1546:         ENDWITH
1547: 
1548:         loc_oPg.AddObject("txt_4c_Moecs", "TextBox")
1549:         WITH loc_oPg.txt_4c_Moecs
1550:             .Value = ""
1551:             .Top = 375
1552:             .Left = 754
1553:             .Width = 31
1554:             .Height = 21
1555:             .FontName = "Tahoma"
1556:             .FontSize = 8
1557:             .SpecialEffect = 1
1558:             .MaxLength = 3
1559:         ENDWITH
1560:         BINDEVENT(loc_oPg.txt_4c_Moecs, "KeyPress", THIS, "TabPrincipal_MoeKeyPress")
1561:         BINDEVENT(loc_oPg.txt_4c_Moecs, "LostFocus", THIS, "TabPrincipal_MoeLostFocus")
1562: 
1563:         loc_oPg.AddObject("lbl_4c_LblPvens", "Label")
1564:         WITH loc_oPg.lbl_4c_LblPvens
1565:             .Caption = "Valor de Venda :"
1566:             .Top = 400
1567:             .Left = 505
1568:             .Width = 120
1569:             .Height = 15
1570:             .FontName = "Tahoma"
1571:             .FontSize = 8
1572:             .BackStyle = 0
1573:             .ForeColor = RGB(90,90,90)
1574:         ENDWITH
1575: 
1576:         loc_oPg.AddObject("txt_4c_Pvens", "TextBox")
1577:         WITH loc_oPg.txt_4c_Pvens
1578:             .Value = 0
1579:             .Top = 397
1580:             .Left = 626
1581:             .Width = 127
1582:             .Height = 21
1583:             .FontName = "Tahoma"
1584:             .FontSize = 8
1585:             .SpecialEffect = 1
1586:         ENDWITH
1587: 
1588:         loc_oPg.AddObject("txt_4c_Moepvs", "TextBox")
1589:         WITH loc_oPg.txt_4c_Moepvs
1590:             .Value = ""
1591:             .Top = 397
1592:             .Left = 754
1593:             .Width = 31
1594:             .Height = 21
1595:             .FontName = "Tahoma"
1596:             .FontSize = 8
1597:             .SpecialEffect = 1
1598:             .MaxLength = 3
1599:         ENDWITH
1600:         BINDEVENT(loc_oPg.txt_4c_Moepvs, "KeyPress", THIS, "TabPrincipal_MoeKeyPress")
1601:         BINDEVENT(loc_oPg.txt_4c_Moepvs, "LostFocus", THIS, "TabPrincipal_MoeLostFocus")
1602: 
1603:         loc_oPg.AddObject("lbl_4c_LblFvendas", "Label")
1604:         WITH loc_oPg.lbl_4c_LblFvendas
1605:             .Caption = "Fator  de Venda :"
1606:             .Top = 422
1607:             .Left = 539
1608:             .Width = 86
1609:             .Height = 15
1610:             .FontName = "Tahoma"
1611:             .FontSize = 8
1612:             .BackStyle = 0
1613:             .ForeColor = RGB(90,90,90)
1614:         ENDWITH
1615: 
1616:         loc_oPg.AddObject("txt_4c_Fvendas", "TextBox")
1617:         WITH loc_oPg.txt_4c_Fvendas
1618:             .Value = 0
1619:             .Top = 419
1620:             .Left = 626
1621:             .Width = 127
1622:             .Height = 21
1623:             .FontName = "Tahoma"
1624:             .FontSize = 8
1625:             .SpecialEffect = 1
1626:         ENDWITH
1627: 
1628:         loc_oPg.AddObject("txt_4c_Moevs", "TextBox")
1629:         WITH loc_oPg.txt_4c_Moevs
1630:             .Value = ""
1631:             .Top = 419
1632:             .Left = 754
1633:             .Width = 31
1634:             .Height = 21
1635:             .FontName = "Tahoma"
1636:             .FontSize = 8
1637:             .SpecialEffect = 1
1638:             .MaxLength = 3
1639:         ENDWITH
1640: 
1641:         *-- === AUDITORIA (ReadOnly) ==========================================
1642: 
1643:         loc_oPg.AddObject("lbl_4c_LblAuditoria", "Label")
1644:         WITH loc_oPg.lbl_4c_LblAuditoria
1645:             .Caption = "Data / Usu" + CHR(225) + "rio"
1646:             .Top = 365
1647:             .Left = 833
1648:             .Width = 84
1649:             .Height = 15
1650:             .FontName = "Tahoma"
1651:             .FontSize = 8
1652:             .BackStyle = 0
1653:             .ForeColor = RGB(90,90,90)
1654:         ENDWITH
1655: 
1656:         loc_oPg.AddObject("lbl_4c_LblInc", "Label")
1657:         WITH loc_oPg.lbl_4c_LblInc
1658:             .Caption = "Inclus" + CHR(227) + "o"
1659:             .Top = 384
1660:             .Left = 833
1661:             .Width = 42
1662:             .Height = 15
1663:             .FontName = "Tahoma"
1664:             .FontSize = 8
1665:             .BackStyle = 0
1666:             .ForeColor = RGB(90,90,90)
1667:         ENDWITH
1668: 
1669:         loc_oPg.AddObject("lbl_4c_LblAlt", "Label")
1670:         WITH loc_oPg.lbl_4c_LblAlt
1671:             .Caption = "Altera" + CHR(231) + CHR(227) + "o"
1672:             .Top = 384
1673:             .Left = 914
1674:             .Width = 48
1675:             .Height = 15
1676:             .FontName = "Tahoma"
1677:             .FontSize = 8
1678:             .BackStyle = 0
1679:             .ForeColor = RGB(90,90,90)
1680:         ENDWITH
1681: 
1682:         loc_oPg.AddObject("txt_4c_DtIncs", "TextBox")
1683:         WITH loc_oPg.txt_4c_DtIncs
1684:             .Value = {}
1685:             .Top = 397
1686:             .Left = 833
1687:             .Width = 79
1688:             .Height = 21
1689:             .FontName = "Tahoma"
1690:             .FontSize = 8
1691:             .SpecialEffect = 1
1692:             .ReadOnly = .T.
1693:             .Enabled = .F.
1694:         ENDWITH
1695: 
1696:         loc_oPg.AddObject("txt_4c_Usuincs", "TextBox")
1697:         WITH loc_oPg.txt_4c_Usuincs
1698:             .Value = ""
1699:             .Top = 419
1700:             .Left = 833
1701:             .Width = 79
1702:             .Height = 21
1703:             .FontName = "Tahoma"
1704:             .FontSize = 8
1705:             .SpecialEffect = 1
1706:             .ReadOnly = .T.
1707:             .Enabled = .F.
1708:         ENDWITH
1709: 
1710:         loc_oPg.AddObject("txt_4c_DtAlts", "TextBox")
1711:         WITH loc_oPg.txt_4c_DtAlts
1712:             .Value = {}
1713:             .Top = 397
1714:             .Left = 914
1715:             .Width = 79
1716:             .Height = 21
1717:             .FontName = "Tahoma"
1718:             .FontSize = 8
1719:             .SpecialEffect = 1
1720:             .ReadOnly = .T.
1721:             .Enabled = .F.
1722:         ENDWITH
1723: 
1724:         loc_oPg.AddObject("txt_4c_UsuaAlts", "TextBox")
1725:         WITH loc_oPg.txt_4c_UsuaAlts
1726:             .Value = ""
1727:             .Top = 419
1728:             .Left = 914
1729:             .Width = 79
1730:             .Height = 21
1731:             .FontName = "Tahoma"
1732:             .FontSize = 8
1733:             .SpecialEffect = 1
1734:             .ReadOnly = .T.
1735:             .Enabled = .F.
1736:         ENDWITH
1737: 
1738:         *-- === UNIDADES ======================================================
1739: 
1740:         loc_oPg.AddObject("lbl_4c_LblCunis", "Label")
1741:         WITH loc_oPg.lbl_4c_LblCunis
1742:             .Caption = "Unidades (1) :"
1743:             .Top = 398
1744:             .Left = 41
1745:             .Width = 70
1746:             .Height = 15
1747:             .FontName = "Tahoma"
1748:             .FontSize = 8
1749:             .BackStyle = 0
1750:             .ForeColor = RGB(90,90,90)
1751:         ENDWITH
1752: 
1753:         loc_oPg.AddObject("txt_4c_Cunis", "TextBox")
1754:         WITH loc_oPg.txt_4c_Cunis
1755:             .Value = ""
1756:             .Top = 394
1757:             .Left = 113
1758:             .Width = 31
1759:             .Height = 23
1760:             .FontName = "Tahoma"
1761:             .FontSize = 8
1762:             .SpecialEffect = 1

*-- Linhas 1768 a 1804:
1768:         loc_oPg.AddObject("txt_4c_Dunis", "TextBox")
1769:         WITH loc_oPg.txt_4c_Dunis
1770:             .Value = ""
1771:             .Top = 394
1772:             .Left = 145
1773:             .Width = 150
1774:             .Height = 23
1775:             .FontName = "Tahoma"
1776:             .FontSize = 8
1777:             .SpecialEffect = 1
1778:             .ReadOnly = .T.
1779:             .Enabled = .F.
1780:         ENDWITH
1781: 
1782:         loc_oPg.AddObject("lbl_4c_LblCunips", "Label")
1783:         WITH loc_oPg.lbl_4c_LblCunips
1784:             .Caption = "(2) :"
1785:             .Top = 398
1786:             .Left = 301
1787:             .Width = 23
1788:             .Height = 15
1789:             .FontName = "Tahoma"
1790:             .FontSize = 8
1791:             .BackStyle = 0
1792:             .ForeColor = RGB(90,90,90)
1793:         ENDWITH
1794: 
1795:         loc_oPg.AddObject("txt_4c_Cunips", "TextBox")
1796:         WITH loc_oPg.txt_4c_Cunips
1797:             .Value = ""
1798:             .Top = 394
1799:             .Left = 330
1800:             .Width = 31
1801:             .Height = 23
1802:             .FontName = "Tahoma"
1803:             .FontSize = 8
1804:             .SpecialEffect = 1

*-- Linhas 1810 a 1928:
1810:         loc_oPg.AddObject("txt_4c_Dunips", "TextBox")
1811:         WITH loc_oPg.txt_4c_Dunips
1812:             .Value = ""
1813:             .Top = 394
1814:             .Left = 362
1815:             .Width = 150
1816:             .Height = 23
1817:             .FontName = "Tahoma"
1818:             .FontSize = 8
1819:             .SpecialEffect = 1
1820:             .ReadOnly = .T.
1821:             .Enabled = .F.
1822:         ENDWITH
1823: 
1824:         *-- === CLASSIFICACAO / MODELO / ACABAMENTO / LOCAL ===================
1825: 
1826:         loc_oPg.AddObject("lbl_4c_LblCclass", "Label")
1827:         WITH loc_oPg.lbl_4c_LblCclass
1828:             .Caption = "Classifica" + CHR(231) + CHR(227) + "o :"
1829:             .Top = 374
1830:             .Left = 7
1831:             .Width = 104
1832:             .Height = 15
1833:             .FontName = "Tahoma"
1834:             .FontSize = 8
1835:             .BackStyle = 0
1836:             .ForeColor = RGB(90,90,90)
1837:         ENDWITH
1838: 
1839:         loc_oPg.AddObject("txt_4c_Cclass", "TextBox")
1840:         WITH loc_oPg.txt_4c_Cclass
1841:             .Value = ""
1842:             .Top = 370
1843:             .Left = 113
1844:             .Width = 31
1845:             .Height = 23
1846:             .FontName = "Tahoma"
1847:             .FontSize = 8
1848:             .SpecialEffect = 1
1849:             .MaxLength = 3
1850:         ENDWITH
1851: 
1852:         loc_oPg.AddObject("txt_4c_Dclass", "TextBox")
1853:         WITH loc_oPg.txt_4c_Dclass
1854:             .Value = ""
1855:             .Top = 370
1856:             .Left = 145
1857:             .Width = 150
1858:             .Height = 23
1859:             .FontName = "Tahoma"
1860:             .FontSize = 8
1861:             .SpecialEffect = 1
1862:             .ReadOnly = .T.
1863:             .Enabled = .F.
1864:         ENDWITH
1865: 
1866:         loc_oPg.AddObject("lbl_4c_LblCodfinp", "Label")
1867:         WITH loc_oPg.lbl_4c_LblCodfinp
1868:             .Caption = "Modelo :"
1869:             .Top = 326
1870:             .Left = 7
1871:             .Width = 104
1872:             .Height = 15
1873:             .FontName = "Tahoma"
1874:             .FontSize = 8
1875:             .BackStyle = 0
1876:             .ForeColor = RGB(90,90,90)
1877:         ENDWITH
1878: 
1879:         loc_oPg.AddObject("txt_4c_Codfinp", "TextBox")
1880:         WITH loc_oPg.txt_4c_Codfinp
1881:             .Value = ""
1882:             .Top = 322
1883:             .Left = 113
1884:             .Width = 31
1885:             .Height = 23
1886:             .FontName = "Tahoma"
1887:             .FontSize = 8
1888:             .SpecialEffect = 1
1889:             .MaxLength = 3
1890:         ENDWITH
1891: 
1892:         loc_oPg.AddObject("txt_4c_Dcodfinp", "TextBox")
1893:         WITH loc_oPg.txt_4c_Dcodfinp
1894:             .Value = ""
1895:             .Top = 322
1896:             .Left = 145
1897:             .Width = 150
1898:             .Height = 23
1899:             .FontName = "Tahoma"
1900:             .FontSize = 8
1901:             .SpecialEffect = 1
1902:             .ReadOnly = .T.
1903:             .Enabled = .F.
1904:         ENDWITH
1905: 
1906:         loc_oPg.AddObject("lbl_4c_LblCodacbs", "Label")
1907:         WITH loc_oPg.lbl_4c_LblCodacbs
1908:             .Caption = "Acabamento :"
1909:             .Top = 350
1910:             .Left = 7
1911:             .Width = 104
1912:             .Height = 15
1913:             .FontName = "Tahoma"
1914:             .FontSize = 8
1915:             .BackStyle = 0
1916:             .ForeColor = RGB(90,90,90)
1917:         ENDWITH
1918: 
1919:         loc_oPg.AddObject("txt_4c_Codacbs", "TextBox")
1920:         WITH loc_oPg.txt_4c_Codacbs
1921:             .Value = ""
1922:             .Top = 346
1923:             .Left = 113
1924:             .Width = 31
1925:             .Height = 23
1926:             .FontName = "Tahoma"
1927:             .FontSize = 8
1928:             .SpecialEffect = 1

*-- Linhas 1934 a 2746:
1934:         loc_oPg.AddObject("txt_4c_Dcodacbs", "TextBox")
1935:         WITH loc_oPg.txt_4c_Dcodacbs
1936:             .Value = ""
1937:             .Top = 346
1938:             .Left = 145
1939:             .Width = 150
1940:             .Height = 23
1941:             .FontName = "Tahoma"
1942:             .FontSize = 8
1943:             .SpecialEffect = 1
1944:             .ReadOnly = .T.
1945:             .Enabled = .F.
1946:         ENDWITH
1947: 
1948:         loc_oPg.AddObject("lbl_4c_LblLocals", "Label")
1949:         WITH loc_oPg.lbl_4c_LblLocals
1950:             .Caption = "Local :"
1951:             .Top = 374
1952:             .Left = 364
1953:             .Width = 33
1954:             .Height = 15
1955:             .FontName = "Tahoma"
1956:             .FontSize = 8
1957:             .BackStyle = 0
1958:             .ForeColor = RGB(90,90,90)
1959:         ENDWITH
1960: 
1961:         loc_oPg.AddObject("txt_4c_Locals", "TextBox")
1962:         WITH loc_oPg.txt_4c_Locals
1963:             .Value = ""
1964:             .Top = 370
1965:             .Left = 401
1966:             .Width = 111
1967:             .Height = 23
1968:             .FontName = "Tahoma"
1969:             .FontSize = 8
1970:             .SpecialEffect = 1
1971:             .MaxLength = 10
1972:         ENDWITH
1973: 
1974:         *-- === PESOS / COR / TAM / CODIDENT ==================================
1975: 
1976:         loc_oPg.AddObject("lbl_4c_LblPesobs", "Label")
1977:         WITH loc_oPg.lbl_4c_LblPesobs
1978:             .Caption = "Peso Bruto :"
1979:             .Top = 326
1980:             .Left = 336
1981:             .Width = 61
1982:             .Height = 15
1983:             .FontName = "Tahoma"
1984:             .FontSize = 8
1985:             .BackStyle = 0
1986:             .ForeColor = RGB(90,90,90)
1987:         ENDWITH
1988: 
1989:         loc_oPg.AddObject("txt_4c_Pesobs", "TextBox")
1990:         WITH loc_oPg.txt_4c_Pesobs
1991:             .Value = 0
1992:             .Top = 322
1993:             .Left = 401
1994:             .Width = 111
1995:             .Height = 23
1996:             .FontName = "Tahoma"
1997:             .FontSize = 8
1998:             .SpecialEffect = 1
1999:         ENDWITH
2000: 
2001:         loc_oPg.AddObject("lbl_4c_LblPesoms", "Label")
2002:         WITH loc_oPg.lbl_4c_LblPesoms
2003:             .Caption = "Peso L" + CHR(237) + "quido :"
2004:             .Top = 350
2005:             .Left = 329
2006:             .Width = 68
2007:             .Height = 15
2008:             .FontName = "Tahoma"
2009:             .FontSize = 8
2010:             .BackStyle = 0
2011:             .ForeColor = RGB(90,90,90)
2012:         ENDWITH
2013: 
2014:         loc_oPg.AddObject("txt_4c_Pesoms", "TextBox")
2015:         WITH loc_oPg.txt_4c_Pesoms
2016:             .Value = 0
2017:             .Top = 346
2018:             .Left = 401
2019:             .Width = 111
2020:             .Height = 23
2021:             .FontName = "Tahoma"
2022:             .FontSize = 8
2023:             .SpecialEffect = 1
2024:         ENDWITH
2025: 
2026:         loc_oPg.AddObject("lbl_4c_LblCodcors", "Label")
2027:         WITH loc_oPg.lbl_4c_LblCodcors
2028:             .Caption = "Padr" + CHR(227) + "o > Cor :"
2029:             .Top = 302
2030:             .Left = 323
2031:             .Width = 77
2032:             .Height = 15
2033:             .FontName = "Tahoma"
2034:             .FontSize = 8
2035:             .BackStyle = 0
2036:             .ForeColor = RGB(90,90,90)
2037:         ENDWITH
2038: 
2039:         loc_oPg.AddObject("txt_4c_Codcors", "TextBox")
2040:         WITH loc_oPg.txt_4c_Codcors
2041:             .Value = ""
2042:             .Top = 298
2043:             .Left = 401
2044:             .Width = 38
2045:             .Height = 23
2046:             .FontName = "Tahoma"
2047:             .FontSize = 8
2048:             .SpecialEffect = 1
2049:             .MaxLength = 4
2050:         ENDWITH
2051:         BINDEVENT(loc_oPg.txt_4c_Codcors, "KeyPress", THIS, "TabPrincipal_CodcorsKeyPress")
2052:         BINDEVENT(loc_oPg.txt_4c_Codcors, "LostFocus", THIS, "TabPrincipal_CodcorsLostFocus")
2053: 
2054:         loc_oPg.AddObject("lbl_4c_LblCodtams", "Label")
2055:         WITH loc_oPg.lbl_4c_LblCodtams
2056:             .Caption = "Tam:"
2057:             .Top = 302
2058:             .Left = 442
2059:             .Width = 30
2060:             .Height = 15
2061:             .FontName = "Tahoma"
2062:             .FontSize = 8
2063:             .BackStyle = 0
2064:             .ForeColor = RGB(90,90,90)
2065:         ENDWITH
2066: 
2067:         loc_oPg.AddObject("txt_4c_Codtams", "TextBox")
2068:         WITH loc_oPg.txt_4c_Codtams
2069:             .Value = ""
2070:             .Top = 298
2071:             .Left = 474
2072:             .Width = 38
2073:             .Height = 23
2074:             .FontName = "Tahoma"
2075:             .FontSize = 8
2076:             .SpecialEffect = 1
2077:             .MaxLength = 4
2078:         ENDWITH
2079:         BINDEVENT(loc_oPg.txt_4c_Codtams, "KeyPress", THIS, "TabPrincipal_CodtamsKeyPress")
2080: 
2081:         loc_oPg.AddObject("lbl_4c_LblCodident", "Label")
2082:         WITH loc_oPg.lbl_4c_LblCodident
2083:             .Caption = "Cod. Identidade :"
2084:             .Top = 422
2085:             .Left = 24
2086:             .Width = 87
2087:             .Height = 15
2088:             .FontName = "Tahoma"
2089:             .FontSize = 8
2090:             .BackStyle = 0
2091:             .ForeColor = RGB(90,90,90)
2092:         ENDWITH
2093: 
2094:         loc_oPg.AddObject("txt_4c_Codident", "TextBox")
2095:         WITH loc_oPg.txt_4c_Codident
2096:             .Value = ""
2097:             .Top = 418
2098:             .Left = 113
2099:             .Width = 182
2100:             .Height = 23
2101:             .FontName = "Tahoma"
2102:             .FontSize = 8
2103:             .SpecialEffect = 1
2104:             .MaxLength = 20
2105:         ENDWITH
2106: 
2107:         *-- === GARANTIA / PRODUTO WEB / VARIACAO =============================
2108: 
2109:         loc_oPg.AddObject("lbl_4c_LblDiasgar", "Label")
2110:         WITH loc_oPg.lbl_4c_LblDiasgar
2111:             .Caption = "Garantia :"
2112:             .Top = 228
2113:             .Left = 827
2114:             .Width = 50
2115:             .Height = 15
2116:             .FontName = "Tahoma"
2117:             .FontSize = 8
2118:             .BackStyle = 0
2119:             .ForeColor = RGB(90,90,90)
2120:         ENDWITH
2121: 
2122:         loc_oPg.AddObject("txt_4c_Diasgar", "TextBox")
2123:         WITH loc_oPg.txt_4c_Diasgar
2124:             .Value = 0
2125:             .Top = 224
2126:             .Left = 880
2127:             .Width = 34
2128:             .Height = 21
2129:             .FontName = "Tahoma"
2130:             .FontSize = 8
2131:             .SpecialEffect = 1
2132:         ENDWITH
2133: 
2134:         loc_oPg.AddObject("lbl_4c_LblDias1", "Label")
2135:         WITH loc_oPg.lbl_4c_LblDias1
2136:             .Caption = "Dias"
2137:             .Top = 228
2138:             .Left = 918
2139:             .Width = 22
2140:             .Height = 15
2141:             .FontName = "Tahoma"
2142:             .FontSize = 8
2143:             .BackStyle = 0
2144:             .ForeColor = RGB(90,90,90)
2145:         ENDWITH
2146: 
2147:         loc_oPg.AddObject("chk_4c_Chkgarvit", "CheckBox")
2148:         WITH loc_oPg.chk_4c_Chkgarvit
2149:             .Caption = "Vital" + CHR(237) + "cia"
2150:             .Top = 228
2151:             .Left = 943
2152:             .Width = 55
2153:             .Height = 17
2154:             .Value = .F.
2155:             .FontName = "Tahoma"
2156:             .FontSize = 8
2157:             .Themes = .F.
2158:         ENDWITH
2159: 
2160:         loc_oPg.AddObject("lbl_4c_LblProdweb", "Label")
2161:         WITH loc_oPg.lbl_4c_LblProdweb
2162:             .Caption = "Produto Web :"
2163:             .Top = 176
2164:             .Left = 805
2165:             .Width = 72
2166:             .Height = 15
2167:             .FontName = "Tahoma"
2168:             .FontSize = 8
2169:             .BackStyle = 0
2170:             .ForeColor = RGB(90,90,90)
2171:         ENDWITH
2172: 
2173:         loc_oPg.AddObject("opt_4c_ProdWeb", "OptionGroup")
2174:         WITH loc_oPg.opt_4c_ProdWeb
2175:             .Top = 172
2176:             .Left = 879
2177:             .Width = 117
2178:             .Height = 42
2179:             .ButtonCount = 4
2180:             .BorderStyle = 0
2181:             .Themes = .F.
2182:             .Value = 1
2183:         ENDWITH
2184:         WITH loc_oPg.opt_4c_ProdWeb
2185:             .Buttons(1).Caption = "N" + CHR(227) + "o"
2186:             .Buttons(1).Left = 0 
2187:             .Buttons(1).Top = 0
2188:             .Buttons(1).AutoSize = .T.
2189:             .Buttons(1).Themes = .F.
2190:             .Buttons(1).FontName = "Tahoma"
2191:             .Buttons(1).FontSize = 8
2192:             .Buttons(2).Caption = "Sim"  
2193:             .Buttons(2).Left = 35
2194:             .Buttons(2).Top = 0
2195:             .Buttons(2).AutoSize = .T.
2196:             .Buttons(2).Themes = .F.
2197:             .Buttons(2).FontName = "Tahoma"
2198:             .Buttons(2).FontSize = 8
2199:             .Buttons(3).Caption = "Img"  
2200:             .Buttons(3).Left = 65
2201:             .Buttons(3).Top = 0
2202:             .Buttons(3).AutoSize = .T.
2203:             .Buttons(3).Themes = .F.
2204:             .Buttons(3).FontName = "Tahoma"
2205:             .Buttons(3).FontSize = 8
2206:             .Buttons(4).Caption = "Sim+Img"
2207:             .Buttons(4).Left = 0
2208:             .Buttons(4).Top = 22
2209:             .Buttons(4).AutoSize = .T.
2210:             .Buttons(4).Themes = .F.
2211:             .Buttons(4).FontName = "Tahoma"
2212:             .Buttons(4).FontSize = 8
2213:         ENDWITH
2214:         BINDEVENT(loc_oPg.opt_4c_ProdWeb, "InteractiveChange", THIS, "OptProdWebChange")
2215: 
2216:         loc_oPg.AddObject("lbl_4c_LblVariacao", "Label")
2217:         WITH loc_oPg.lbl_4c_LblVariacao
2218:             .Caption = "Varia" + CHR(231) + CHR(227) + "o :"
2219:             .Top = 207
2220:             .Left = 827
2221:             .Width = 50
2222:             .Height = 15
2223:             .FontName = "Tahoma"
2224:             .FontSize = 8
2225:             .BackStyle = 0
2226:             .ForeColor = RGB(90,90,90)
2227:         ENDWITH
2228: 
2229:         loc_oPg.AddObject("opt_4c_Varias", "OptionGroup")
2230:         WITH loc_oPg.opt_4c_Varias
2231:             .Top = 203
2232:             .Left = 874
2233:             .Width = 107
2234:             .Height = 22
2235:             .ButtonCount = 2
2236:             .BorderStyle = 0
2237:             .Themes = .F.
2238:             .Value = 2
2239:         ENDWITH
2240:         WITH loc_oPg.opt_4c_Varias
2241:             .Buttons(1).Caption = "Sim"        
2242:             .Buttons(1).Left = 0 
2243:             .Buttons(1).Top = 0
2244:             .Buttons(1).AutoSize = .T.
2245:             .Buttons(1).Themes = .F.
2246:             .Buttons(1).FontName = "Tahoma"
2247:             .Buttons(1).FontSize = 8
2248:             .Buttons(2).Caption = "N" + CHR(227) + "o"
2249:             .Buttons(2).Left = 42
2250:             .Buttons(2).Top = 0
2251:             .Buttons(2).AutoSize = .T.
2252:             .Buttons(2).Themes = .F.
2253:             .Buttons(2).FontName = "Tahoma"
2254:             .Buttons(2).FontSize = 8
2255:         ENDWITH
2256:         BINDEVENT(loc_oPg.opt_4c_Varias, "InteractiveChange", THIS, "OptVariasChange")
2257: 
2258:         *-- === DIMENSOES FINAS (altura/largura/diametro/espessura/comprimento) =
2259: 
2260:         loc_oPg.AddObject("lbl_4c_LblAltura", "Label")
2261:         WITH loc_oPg.lbl_4c_LblAltura
2262:             .Caption = "Altura :"
2263:             .Top = 250
2264:             .Left = 881
2265:             .Width = 38
2266:             .Height = 15
2267:             .FontName = "Tahoma"
2268:             .FontSize = 8
2269:             .BackStyle = 0
2270:             .ForeColor = RGB(90,90,90)
2271:         ENDWITH
2272:         loc_oPg.AddObject("txt_4c_Altura", "TextBox")
2273:         WITH loc_oPg.txt_4c_Altura
2274:             .Value = 0
2275:             .Top = 247
2276:             .Left = 923
2277:             .Width = 48
2278:             .Height = 21
2279:             .FontName = "Tahoma"
2280:             .FontSize = 8
2281:             .SpecialEffect = 1
2282:         ENDWITH
2283:         loc_oPg.AddObject("lbl_4c_MmAltura", "Label")
2284:         WITH loc_oPg.lbl_4c_MmAltura
2285:             .Caption = "MM"
2286:             .Top = 251
2287:             .Left = 976
2288:             .Width = 18
2289:             .Height = 15
2290:             .FontName = "Tahoma"
2291:             .FontSize = 8
2292:             .BackStyle = 0
2293:             .ForeColor = RGB(90,90,90)
2294:         ENDWITH
2295: 
2296:         loc_oPg.AddObject("lbl_4c_LblLargura", "Label")
2297:         WITH loc_oPg.lbl_4c_LblLargura
2298:             .Caption = "Largura :"
2299:             .Top = 270
2300:             .Left = 873
2301:             .Width = 46
2302:             .Height = 15
2303:             .FontName = "Tahoma"
2304:             .FontSize = 8
2305:             .BackStyle = 0
2306:             .ForeColor = RGB(90,90,90)
2307:         ENDWITH
2308:         loc_oPg.AddObject("txt_4c_Largura", "TextBox")
2309:         WITH loc_oPg.txt_4c_Largura
2310:             .Value = 0
2311:             .Top = 269
2312:             .Left = 923
2313:             .Width = 48
2314:             .Height = 21
2315:             .FontName = "Tahoma"
2316:             .FontSize = 8
2317:             .SpecialEffect = 1
2318:         ENDWITH
2319:         loc_oPg.AddObject("lbl_4c_MmLargura", "Label")
2320:         WITH loc_oPg.lbl_4c_MmLargura
2321:             .Caption = "MM"
2322:             .Top = 271
2323:             .Left = 976
2324:             .Width = 18
2325:             .Height = 15
2326:             .FontName = "Tahoma"
2327:             .FontSize = 8
2328:             .BackStyle = 0
2329:             .ForeColor = RGB(90,90,90)
2330:         ENDWITH
2331: 
2332:         loc_oPg.AddObject("lbl_4c_LblDiametro", "Label")
2333:         WITH loc_oPg.lbl_4c_LblDiametro
2334:             .Caption = "Di" + CHR(226) + "metro :"
2335:             .Top = 293
2336:             .Left = 867
2337:             .Width = 52
2338:             .Height = 15
2339:             .FontName = "Tahoma"
2340:             .FontSize = 8
2341:             .BackStyle = 0
2342:             .ForeColor = RGB(90,90,90)
2343:         ENDWITH
2344:         loc_oPg.AddObject("txt_4c_Diametro", "TextBox")
2345:         WITH loc_oPg.txt_4c_Diametro
2346:             .Value = 0
2347:             .Top = 291
2348:             .Left = 923
2349:             .Width = 48
2350:             .Height = 21
2351:             .FontName = "Tahoma"
2352:             .FontSize = 8
2353:             .SpecialEffect = 1
2354:         ENDWITH
2355:         loc_oPg.AddObject("lbl_4c_MmDiametro", "Label")
2356:         WITH loc_oPg.lbl_4c_MmDiametro
2357:             .Caption = "MM"
2358:             .Top = 294
2359:             .Left = 976
2360:             .Width = 18
2361:             .Height = 15
2362:             .FontName = "Tahoma"
2363:             .FontSize = 8
2364:             .BackStyle = 0
2365:             .ForeColor = RGB(90,90,90)
2366:         ENDWITH
2367: 
2368:         loc_oPg.AddObject("lbl_4c_LblEspessura", "Label")
2369:         WITH loc_oPg.lbl_4c_LblEspessura
2370:             .Caption = "Espessura :"
2371:             .Top = 316
2372:             .Left = 861
2373:             .Width = 58
2374:             .Height = 15
2375:             .FontName = "Tahoma"
2376:             .FontSize = 8
2377:             .BackStyle = 0
2378:             .ForeColor = RGB(90,90,90)
2379:         ENDWITH
2380:         loc_oPg.AddObject("txt_4c_Espessura", "TextBox")
2381:         WITH loc_oPg.txt_4c_Espessura
2382:             .Value = 0
2383:             .Top = 313
2384:             .Left = 923
2385:             .Width = 48
2386:             .Height = 21
2387:             .FontName = "Tahoma"
2388:             .FontSize = 8
2389:             .SpecialEffect = 1
2390:         ENDWITH
2391:         loc_oPg.AddObject("lbl_4c_MmEspessura", "Label")
2392:         WITH loc_oPg.lbl_4c_MmEspessura
2393:             .Caption = "MM"
2394:             .Top = 317
2395:             .Left = 976
2396:             .Width = 18
2397:             .Height = 15
2398:             .FontName = "Tahoma"
2399:             .FontSize = 8
2400:             .BackStyle = 0
2401:             .ForeColor = RGB(90,90,90)
2402:         ENDWITH
2403: 
2404:         loc_oPg.AddObject("lbl_4c_LblCompriment", "Label")
2405:         WITH loc_oPg.lbl_4c_LblCompriment
2406:             .Caption = "Comprimento :"
2407:             .Top = 339
2408:             .Left = 847
2409:             .Width = 72
2410:             .Height = 15
2411:             .FontName = "Tahoma"
2412:             .FontSize = 8
2413:             .BackStyle = 0
2414:             .ForeColor = RGB(90,90,90)
2415:         ENDWITH
2416:         loc_oPg.AddObject("txt_4c_Compriment", "TextBox")
2417:         WITH loc_oPg.txt_4c_Compriment
2418:             .Value = 0
2419:             .Top = 335
2420:             .Left = 923
2421:             .Width = 48
2422:             .Height = 21
2423:             .FontName = "Tahoma"
2424:             .FontSize = 8
2425:             .SpecialEffect = 1
2426:         ENDWITH
2427:         loc_oPg.AddObject("lbl_4c_CmCompriment", "Label")
2428:         WITH loc_oPg.lbl_4c_CmCompriment
2429:             .Caption = "CM"
2430:             .Top = 340
2431:             .Left = 976
2432:             .Width = 17
2433:             .Height = 15
2434:             .FontName = "Tahoma"
2435:             .FontSize = 8
2436:             .BackStyle = 0
2437:             .ForeColor = RGB(90,90,90)
2438:         ENDWITH
2439: 
2440:         *-- === CHECKBOXES / ENTREGA / DIMENSAO / VOLUMES =====================
2441: 
2442:         loc_oPg.AddObject("lbl_4c_LblSituAb", "Label")
2443:         WITH loc_oPg.lbl_4c_LblSituAb
2444:             .Caption = "Situa" + CHR(231) + CHR(227) + "o :"
2445:             .Top = 451
2446:             .Left = 548
2447:             .Width = 50
2448:             .Height = 15
2449:             .FontName = "Tahoma"
2450:             .FontSize = 8
2451:             .BackStyle = 0
2452:             .ForeColor = RGB(90,90,90)
2453:         ENDWITH
2454: 
2455:         loc_oPg.AddObject("chk_4c_Consigs", "CheckBox")
2456:         WITH loc_oPg.chk_4c_Consigs
2457:             .Caption = "Consigna"
2458:             .Top = 451
2459:             .Left = 601
2460:             .Width = 75
2461:             .Height = 17
2462:             .Value = .F.
2463:             .FontName = "Tahoma"
2464:             .FontSize = 8
2465:             .Themes = .F.
2466:         ENDWITH
2467: 
2468:         loc_oPg.AddObject("chk_4c_Fabrproprs", "CheckBox")
2469:         WITH loc_oPg.chk_4c_Fabrproprs
2470:             .Caption = "Fabr. Pr" + CHR(243) + "pria"
2471:             .Top = 451
2472:             .Left = 681
2473:             .Width = 90
2474:             .Height = 17
2475:             .Value = .F.
2476:             .FontName = "Tahoma"
2477:             .FontSize = 8
2478:             .Themes = .F.
2479:         ENDWITH
2480: 
2481:         loc_oPg.AddObject("chk_4c_Encoms", "CheckBox")
2482:         WITH loc_oPg.chk_4c_Encoms
2483:             .Caption = "Encomenda"
2484:             .Top = 451
2485:             .Left = 781
2486:             .Width = 80
2487:             .Height = 17
2488:             .Value = .F.
2489:             .FontName = "Tahoma"
2490:             .FontSize = 8
2491:             .Themes = .F.
2492:         ENDWITH
2493: 
2494:         loc_oPg.AddObject("lbl_4c_LblTents", "Label")
2495:         WITH loc_oPg.lbl_4c_LblTents
2496:             .Caption = "Entrega :"
2497:             .Top = 451
2498:             .Left = 884
2499:             .Width = 47
2500:             .Height = 15
2501:             .FontName = "Tahoma"
2502:             .FontSize = 8
2503:             .BackStyle = 0
2504:             .ForeColor = RGB(90,90,90)
2505:         ENDWITH
2506: 
2507:         loc_oPg.AddObject("txt_4c_Tents", "TextBox")
2508:         WITH loc_oPg.txt_4c_Tents
2509:             .Value = 0
2510:             .Top = 447
2511:             .Left = 934
2512:             .Width = 31
2513:             .Height = 22
2514:             .FontName = "Tahoma"
2515:             .FontSize = 8
2516:             .SpecialEffect = 1
2517:         ENDWITH
2518: 
2519:         loc_oPg.AddObject("lbl_4c_LblDias2", "Label")
2520:         WITH loc_oPg.lbl_4c_LblDias2
2521:             .Caption = "Dias"
2522:             .Top = 451
2523:             .Left = 967
2524:             .Width = 22
2525:             .Height = 15
2526:             .FontName = "Tahoma"
2527:             .FontSize = 8
2528:             .BackStyle = 0
2529:             .ForeColor = RGB(90,90,90)
2530:         ENDWITH
2531: 
2532:         loc_oPg.AddObject("lbl_4c_LblDim", "Label")
2533:         WITH loc_oPg.lbl_4c_LblDim
2534:             .Caption = "Dimens" + CHR(227) + "o :"
2535:             .Top = 474
2536:             .Left = 543
2537:             .Width = 55
2538:             .Height = 15
2539:             .FontName = "Tahoma"
2540:             .FontSize = 8
2541:             .BackStyle = 0
2542:             .ForeColor = RGB(90,90,90)
2543:         ENDWITH
2544: 
2545:         loc_oPg.AddObject("txt_4c_DimA", "TextBox")
2546:         WITH loc_oPg.txt_4c_DimA
2547:             .Value = 0
2548:             .Top = 470
2549:             .Left = 601
2550:             .Width = 58
2551:             .Height = 23
2552:             .FontName = "Tahoma"
2553:             .FontSize = 8
2554:             .SpecialEffect = 1
2555:         ENDWITH
2556:         loc_oPg.AddObject("lbl_4c_LblPpp", "Label")
2557:         WITH loc_oPg.lbl_4c_LblPpp
2558:             .Caption = "ppp"
2559:             .Top = 474
2560:             .Left = 661
2561:             .Width = 20
2562:             .Height = 15
2563:             .FontName = "Tahoma"
2564:             .FontSize = 8
2565:             .BackStyle = 0
2566:             .ForeColor = RGB(90,90,90)
2567:         ENDWITH
2568:         loc_oPg.AddObject("txt_4c_DimB", "TextBox")
2569:         WITH loc_oPg.txt_4c_DimB
2570:             .Value = 0
2571:             .Top = 470
2572:             .Left = 688
2573:             .Width = 58
2574:             .Height = 23
2575:             .FontName = "Tahoma"
2576:             .FontSize = 8
2577:             .SpecialEffect = 1
2578:         ENDWITH
2579:         loc_oPg.AddObject("lbl_4c_LblAaa", "Label")
2580:         WITH loc_oPg.lbl_4c_LblAaa
2581:             .Caption = "aaa"
2582:             .Top = 474
2583:             .Left = 749
2584:             .Width = 20
2585:             .Height = 15
2586:             .FontName = "Tahoma"
2587:             .FontSize = 8
2588:             .BackStyle = 0
2589:             .ForeColor = RGB(90,90,90)
2590:         ENDWITH
2591:         loc_oPg.AddObject("txt_4c_DimC", "TextBox")
2592:         WITH loc_oPg.txt_4c_DimC
2593:             .Value = 0
2594:             .Top = 470
2595:             .Left = 776
2596:             .Width = 58
2597:             .Height = 23
2598:             .FontName = "Tahoma"
2599:             .FontSize = 8
2600:             .SpecialEffect = 1
2601:         ENDWITH
2602:         loc_oPg.AddObject("lbl_4c_LblCcc", "Label")
2603:         WITH loc_oPg.lbl_4c_LblCcc
2604:             .Caption = "ccc"
2605:             .Top = 474
2606:             .Left = 836
2607:             .Width = 17
2608:             .Height = 15
2609:             .FontName = "Tahoma"
2610:             .FontSize = 8
2611:             .BackStyle = 0
2612:             .ForeColor = RGB(90,90,90)
2613:         ENDWITH
2614: 
2615:         loc_oPg.AddObject("lbl_4c_LblVolumes", "Label")
2616:         WITH loc_oPg.lbl_4c_LblVolumes
2617:             .Caption = "Volumes :"
2618:             .Top = 474
2619:             .Left = 883
2620:             .Width = 48
2621:             .Height = 15
2622:             .FontName = "Tahoma"
2623:             .FontSize = 8
2624:             .BackStyle = 0
2625:             .ForeColor = RGB(90,90,90)
2626:         ENDWITH
2627: 
2628:         loc_oPg.AddObject("txt_4c_Volumes", "TextBox")
2629:         WITH loc_oPg.txt_4c_Volumes
2630:             .Value = 0
2631:             .Top = 470
2632:             .Left = 934
2633:             .Width = 31
2634:             .Height = 23
2635:             .FontName = "Tahoma"
2636:             .FontSize = 8
2637:             .SpecialEffect = 1
2638:         ENDWITH
2639: 
2640:         *-- === LABELS IMAGENS ================================================
2641: 
2642:         loc_oPg.AddObject("lbl_4c_LblFigJpg", "Label")
2643:         WITH loc_oPg.lbl_4c_LblFigJpg
2644:             .Caption = "Imagem Principal"
2645:             .Top = 502
2646:             .Left = 543
2647:             .Width = 101
2648:             .Height = 15
2649:             .FontName = "Tahoma"
2650:             .FontSize = 8
2651:             .BackStyle = 0
2652:             .ForeColor = RGB(90,90,90)
2653:         ENDWITH
2654:         loc_oPg.AddObject("lbl_4c_LblFigTec", "Label")
2655:         WITH loc_oPg.lbl_4c_LblFigTec
2656:             .Caption = "Imagem T" + CHR(233) + "cnica"
2657:             .Top = 502
2658:             .Left = 775
2659:             .Width = 96
2660:             .Height = 15
2661:             .FontName = "Tahoma"
2662:             .FontSize = 8
2663:             .BackStyle = 0
2664:             .ForeColor = RGB(90,90,90)
2665:         ENDWITH
2666: 
2667:         *-- === MEMO FIELDS ===================================================
2668: 
2669:         loc_oPg.AddObject("lbl_4c_LblDsccompras", "Label")
2670:         WITH loc_oPg.lbl_4c_LblDsccompras
2671:             .Caption = "Descri" + CHR(231) + CHR(227) + "o de : Compra ."
2672:             .Top = 448
2673:             .Left = 23
2674:             .Width = 88
2675:             .Height = 28
2676:             .FontName = "Tahoma"
2677:             .FontSize = 8
2678:             .BackStyle = 0
2679:             .ForeColor = RGB(90,90,90)
2680:             .WordWrap = .T.
2681:         ENDWITH
2682: 
2683:         loc_oPg.AddObject("edt_4c_Dsccompras", "EditBox")
2684:         WITH loc_oPg.edt_4c_Dsccompras
2685:             .Value = ""
2686:             .Top = 448
2687:             .Left = 113
2688:             .Width = 400
2689:             .Height = 58
2690:             .FontName = "Tahoma"
2691:             .FontSize = 8
2692:             .SpecialEffect = 1
2693:             .MaxLength = 0
2694:         ENDWITH
2695: 
2696:         loc_oPg.AddObject("lbl_4c_LblDpro3s", "Label")
2697:         WITH loc_oPg.lbl_4c_LblDpro3s
2698:             .Caption = "Descri" + CHR(231) + CHR(227) + "o : Completa ."
2699:             .Top = 507
2700:             .Left = 23
2701:             .Width = 88
2702:             .Height = 28
2703:             .FontName = "Tahoma"
2704:             .FontSize = 8
2705:             .BackStyle = 0
2706:             .ForeColor = RGB(90,90,90)
2707:             .WordWrap = .T.
2708:         ENDWITH
2709: 
2710:         loc_oPg.AddObject("edt_4c_Dpro3s", "EditBox")
2711:         WITH loc_oPg.edt_4c_Dpro3s
2712:             .Value = ""
2713:             .Top = 507
2714:             .Left = 113
2715:             .Width = 400
2716:             .Height = 58
2717:             .FontName = "Tahoma"
2718:             .FontSize = 8
2719:             .SpecialEffect = 1
2720:             .MaxLength = 0
2721:         ENDWITH
2722: 
2723:         loc_oPg.AddObject("lbl_4c_LblObscompras", "Label")
2724:         WITH loc_oPg.lbl_4c_LblObscompras
2725:             .Caption = "Observa" + CHR(231) + CHR(227) + "o : da  Compra ."
2726:             .Top = 566
2727:             .Left = 23
2728:             .Width = 88
2729:             .Height = 28
2730:             .FontName = "Tahoma"
2731:             .FontSize = 8
2732:             .BackStyle = 0
2733:             .ForeColor = RGB(90,90,90)
2734:             .WordWrap = .T.
2735:         ENDWITH
2736: 
2737:         loc_oPg.AddObject("edt_4c_Obscompras", "EditBox")
2738:         WITH loc_oPg.edt_4c_Obscompras
2739:             .Value = ""
2740:             .Top = 566
2741:             .Left = 113
2742:             .Width = 400
2743:             .Height = 58
2744:             .FontName = "Tahoma"
2745:             .FontSize = 8
2746:             .SpecialEffect = 1

*-- Linhas 2761 a 2770:
2761:         *-- Mostra totais por grupo de composicao
2762:         loc_oPg.AddObject("grd_4c_GrupoCompo", "Grid")
2763:         WITH loc_oPg.grd_4c_GrupoCompo
2764:             .Top         = 34
2765:             .Left        = 582
2766:             .Width       = 229
2767:             .Height      = 107
2768:             .ReadOnly    = .T.
2769:             .DeleteMark  = .F.
2770:             .RecordMark  = .F.

*-- Linhas 2776 a 2797:
2776:             .Visible     = .T.
2777:         ENDWITH
2778:         WITH loc_oPg.grd_4c_GrupoCompo
2779:             .Column1.Header1.Caption = "Grupo"
2780:             .Column1.Width = 70
2781:             .Column2.Header1.Caption = "Total"
2782:             .Column2.Width = 95
2783:             .Column3.Header1.Caption = "Moe"
2784:             .Column3.Width = 50
2785:         ENDWITH
2786: 
2787:         *-- grdCompo - Composicao principal (top=148, left=6, width=943, height=147, 14 cols)
2788:         *-- Dados: SIGPRCPO - Material, Descricao, Unidade, Valor, Qtde, Total, Moeda, Obs, Etiq, Consumo, QtdCV, UnCV, Ordem, Compos
2789:         loc_oPg.AddObject("grd_4c_Compo", "Grid")
2790:         WITH loc_oPg.grd_4c_Compo
2791:             .Top         = 148
2792:             .Left        = 6
2793:             .Width       = 943
2794:             .Height      = 147
2795:             .ReadOnly    = .T.
2796:             .DeleteMark  = .F.
2797:             .RecordMark  = .F.

*-- Linhas 2803 a 2846:
2803:             .Visible     = .T.
2804:         ENDWITH
2805:         WITH loc_oPg.grd_4c_Compo
2806:             .Column1.Header1.Caption  = "Material"
2807:             .Column1.Width  = 90
2808:             .Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
2809:             .Column2.Width  = 190
2810:             .Column3.Header1.Caption  = "Un"
2811:             .Column3.Width  = 35
2812:             .Column4.Header1.Caption  = "Valor"
2813:             .Column4.Width  = 75
2814:             .Column5.Header1.Caption  = "Qtde."
2815:             .Column5.Width  = 60
2816:             .Column6.Header1.Caption  = "Total"
2817:             .Column6.Width  = 75
2818:             .Column7.Header1.Caption  = "Moe"
2819:             .Column7.Width  = 35
2820:             .Column8.Header1.Caption  = "Observa" + CHR(231) + CHR(227) + "o"
2821:             .Column8.Width  = 80
2822:             .Column9.Header1.Caption  = "E"
2823:             .Column9.Width  = 20
2824:             .Column10.Header1.Caption = "Consumo"
2825:             .Column10.Width = 70
2826:             .Column11.Header1.Caption = "Qtde."
2827:             .Column11.Width = 60
2828:             .Column12.Header1.Caption = "Un"
2829:             .Column12.Width = 35
2830:             .Column13.Header1.Caption = "Ord"
2831:             .Column13.Width = 35
2832:             .Column14.Header1.Caption = "Material"
2833:             .Column14.Width = 70
2834:         ENDWITH
2835: 
2836:         *-- grdsubcp - Sub-componentes (top=348, left=6, width=943, height=83, 15 cols)
2837:         *-- Dados: sigsubcp
2838:         loc_oPg.AddObject("grd_4c_SubCompo", "Grid")
2839:         WITH loc_oPg.grd_4c_SubCompo
2840:             .Top         = 348
2841:             .Left        = 6
2842:             .Width       = 943
2843:             .Height      = 83
2844:             .ReadOnly    = .T.
2845:             .DeleteMark  = .F.
2846:             .RecordMark  = .F.

*-- Linhas 2852 a 4047:
2852:             .Visible     = .T.
2853:         ENDWITH
2854:         WITH loc_oPg.grd_4c_SubCompo
2855:             .Column1.Header1.Caption  = "Material"
2856:             .Column1.Width  = 80
2857:             .Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
2858:             .Column2.Width  = 160
2859:             .Column3.Header1.Caption  = "Un"
2860:             .Column3.Width  = 35
2861:             .Column4.Header1.Caption  = "Valor"
2862:             .Column4.Width  = 70
2863:             .Column5.Header1.Caption  = "Qtde."
2864:             .Column5.Width  = 55
2865:             .Column6.Header1.Caption  = "Total"
2866:             .Column6.Width  = 70
2867:             .Column7.Header1.Caption  = "Moe"
2868:             .Column7.Width  = 35
2869:             .Column8.Header1.Caption  = "Observa" + CHR(231) + CHR(227) + "o"
2870:             .Column8.Width  = 75
2871:             .Column9.Header1.Caption  = "E"
2872:             .Column9.Width  = 20
2873:             .Column10.Header1.Caption = "Consumo"
2874:             .Column10.Width = 65
2875:             .Column11.Header1.Caption = "Qtde."
2876:             .Column11.Width = 55
2877:             .Column12.Header1.Caption = "Un"
2878:             .Column12.Width = 35
2879:             .Column13.Header1.Caption = "Ord"
2880:             .Column13.Width = 35
2881:             .Column14.Header1.Caption = "Material"
2882:             .Column14.Width = 65
2883:             .Column15.Header1.Caption = "Tam"
2884:             .Column15.Width = 45
2885:         ENDWITH
2886: 
2887:         *-- cntMtPrima - Container Materia Prima (top=511, left=752, width=242, height=108)
2888:         loc_oPg.AddObject("cnt_4c_MtPrima", "Container")
2889:         WITH loc_oPg.cnt_4c_MtPrima
2890:             .Top         = 511
2891:             .Left        = 752
2892:             .Width       = 242
2893:             .Height      = 108
2894:             .BackStyle   = 1
2895:             .BackColor   = RGB(240, 240, 240)
2896:             .BorderWidth = 1
2897:             .Visible     = .T.
2898:         ENDWITH
2899: 
2900:         loc_oPg.cnt_4c_MtPrima.AddObject("lbl_4c_Compos", "Label")
2901:         WITH loc_oPg.cnt_4c_MtPrima.lbl_4c_Compos
2902:             .Caption   = "Composi" + CHR(231) + CHR(227) + "o :"
2903:             .Top       = 1
2904:             .Left      = 6
2905:             .Width     = 80
2906:             .Height    = 15
2907:             .FontName  = "Tahoma"
2908:             .FontSize  = 8
2909:             .BackStyle = 0
2910:             .ForeColor = RGB(90,90,90)
2911:         ENDWITH
2912: 
2913:         loc_oPg.cnt_4c_MtPrima.AddObject("txt_4c_Compos", "TextBox")
2914:         WITH loc_oPg.cnt_4c_MtPrima.txt_4c_Compos
2915:             .Value    = ""
2916:             .Top      = 18
2917:             .Left     = 6
2918:             .Width    = 233
2919:             .Height   = 23
2920:             .FontName = "Tahoma"
2921:             .FontSize = 8
2922:             .ReadOnly = .T.
2923:         ENDWITH
2924: 
2925:         loc_oPg.cnt_4c_MtPrima.AddObject("lbl_4c_Montagem", "Label")
2926:         WITH loc_oPg.cnt_4c_MtPrima.lbl_4c_Montagem
2927:             .Caption   = "Montagem :"
2928:             .Top       = 42
2929:             .Left      = 6
2930:             .Width     = 65
2931:             .Height    = 15
2932:             .FontName  = "Tahoma"
2933:             .FontSize  = 8
2934:             .BackStyle = 0
2935:             .ForeColor = RGB(90,90,90)
2936:         ENDWITH
2937: 
2938:         loc_oPg.cnt_4c_MtPrima.AddObject("txt_4c_MontaDescs", "TextBox")
2939:         WITH loc_oPg.cnt_4c_MtPrima.txt_4c_MontaDescs
2940:             .Value    = 0
2941:             .Top      = 59
2942:             .Left     = 6
2943:             .Width    = 233
2944:             .Height   = 23
2945:             .FontName = "Tahoma"
2946:             .FontSize = 8
2947:             .ReadOnly = .T.
2948:         ENDWITH
2949: 
2950:         loc_oPg.cnt_4c_MtPrima.AddObject("lbl_4c_Digitos", "Label")
2951:         WITH loc_oPg.cnt_4c_MtPrima.lbl_4c_Digitos
2952:             .Caption   = "Digitos :"
2953:             .Top       = 88
2954:             .Left      = 4
2955:             .Width     = 50
2956:             .Height    = 15
2957:             .FontName  = "Tahoma"
2958:             .FontSize  = 8
2959:             .BackStyle = 0
2960:             .ForeColor = RGB(90,90,90)
2961:         ENDWITH
2962: 
2963:         loc_oPg.cnt_4c_MtPrima.AddObject("txt_4c_DigiMaxs", "TextBox")
2964:         WITH loc_oPg.cnt_4c_MtPrima.txt_4c_DigiMaxs
2965:             .Value    = 0
2966:             .Top      = 84
2967:             .Left     = 54
2968:             .Width    = 25
2969:             .Height   = 20
2970:             .FontName = "Tahoma"
2971:             .FontSize = 8
2972:             .ReadOnly = .T.
2973:         ENDWITH
2974: 
2975:         loc_oPg.cnt_4c_MtPrima.AddObject("lbl_4c_Ordem", "Label")
2976:         WITH loc_oPg.cnt_4c_MtPrima.lbl_4c_Ordem
2977:             .Caption   = "Ordem :"
2978:             .Top       = 88
2979:             .Left      = 85
2980:             .Width     = 45
2981:             .Height    = 15
2982:             .FontName  = "Tahoma"
2983:             .FontSize  = 8
2984:             .BackStyle = 0
2985:             .ForeColor = RGB(90,90,90)
2986:         ENDWITH
2987: 
2988:         loc_oPg.cnt_4c_MtPrima.AddObject("txt_4c_OrdCompos", "TextBox")
2989:         WITH loc_oPg.cnt_4c_MtPrima.txt_4c_OrdCompos
2990:             .Value    = 0
2991:             .Top      = 84
2992:             .Left     = 136
2993:             .Width    = 25
2994:             .Height   = 20
2995:             .FontName = "Tahoma"
2996:             .FontSize = 8
2997:             .ReadOnly = .T.
2998:         ENDWITH
2999: 
3000:         loc_oPg.cnt_4c_MtPrima.AddObject("lbl_4c_Casas", "Label")
3001:         WITH loc_oPg.cnt_4c_MtPrima.lbl_4c_Casas
3002:             .Caption   = "Casas :"
3003:             .Top       = 88
3004:             .Left      = 165
3005:             .Width     = 40
3006:             .Height    = 15
3007:             .FontName  = "Tahoma"
3008:             .FontSize  = 8
3009:             .BackStyle = 0
3010:             .ForeColor = RGB(90,90,90)
3011:         ENDWITH
3012: 
3013:         loc_oPg.cnt_4c_MtPrima.AddObject("txt_4c_Casas", "TextBox")
3014:         WITH loc_oPg.cnt_4c_MtPrima.txt_4c_Casas
3015:             .Value    = 0
3016:             .Top      = 84
3017:             .Left     = 213
3018:             .Width    = 25
3019:             .Height   = 20
3020:             .FontName = "Tahoma"
3021:             .FontSize = 8
3022:             .ReadOnly = .T.
3023:         ENDWITH
3024: 
3025:         *-- Campos de preco de custo (bottom area)
3026:         loc_oPg.AddObject("lbl_4c_PcusLabel", "Label")
3027:         WITH loc_oPg.lbl_4c_PcusLabel
3028:             .Caption   = "Pre" + CHR(231) + "o de Custo (Moeda 1)"
3029:             .Top       = 502
3030:             .Left      = 9
3031:             .Width     = 140
3032:             .Height    = 15
3033:             .FontName  = "Tahoma"
3034:             .FontSize  = 8
3035:             .BackStyle = 0
3036:             .ForeColor = RGB(90,90,90)
3037:         ENDWITH
3038: 
3039:         loc_oPg.AddObject("txt_4c_PcusMoe", "TextBox")
3040:         WITH loc_oPg.txt_4c_PcusMoe
3041:             .Value    = ""
3042:             .Top      = 517
3043:             .Left     = 127
3044:             .Width    = 31
3045:             .Height   = 23
3046:             .FontName = "Tahoma"
3047:             .FontSize = 8
3048:             .ReadOnly = .T.
3049:         ENDWITH
3050: 
3051:         loc_oPg.AddObject("txt_4c_Pcus", "TextBox")
3052:         WITH loc_oPg.txt_4c_Pcus
3053:             .Value    = 0
3054:             .Top      = 517
3055:             .Left     = 9
3056:             .Width    = 115
3057:             .Height   = 23
3058:             .FontName = "Tahoma"
3059:             .FontSize = 8
3060:             .ReadOnly = .T.
3061:         ENDWITH
3062: 
3063:         loc_oPg.AddObject("txt_4c_Fcusto", "TextBox")
3064:         WITH loc_oPg.txt_4c_Fcusto
3065:             .Value    = 0
3066:             .Top      = 517
3067:             .Left     = 161
3068:             .Width    = 115
3069:             .Height   = 23
3070:             .FontName = "Tahoma"
3071:             .FontSize = 8
3072:             .ReadOnly = .T.
3073:         ENDWITH
3074: 
3075:         loc_oPg.AddObject("txt_4c_PcusMoepc", "TextBox")
3076:         WITH loc_oPg.txt_4c_PcusMoepc
3077:             .Value    = ""
3078:             .Top      = 517
3079:             .Left     = 279
3080:             .Width    = 31
3081:             .Height   = 23
3082:             .FontName = "Tahoma"
3083:             .FontSize = 8
3084:             .ReadOnly = .T.
3085:         ENDWITH
3086: 
3087:         loc_oPg.AddObject("txt_4c_Custof", "TextBox")
3088:         WITH loc_oPg.txt_4c_Custof
3089:             .Value    = 0
3090:             .Top      = 557
3091:             .Left     = 161
3092:             .Width    = 115
3093:             .Height   = 23
3094:             .FontName = "Tahoma"
3095:             .FontSize = 8
3096:             .ReadOnly = .T.
3097:         ENDWITH
3098: 
3099:         loc_oPg.AddObject("txt_4c_MoecusFoe", "TextBox")
3100:         WITH loc_oPg.txt_4c_MoecusFoe
3101:             .Value    = ""
3102:             .Top      = 557
3103:             .Left     = 279
3104:             .Width    = 31
3105:             .Height   = 23
3106:             .FontName = "Tahoma"
3107:             .FontSize = 8
3108:             .ReadOnly = .T.
3109:         ENDWITH
3110: 
3111:         loc_oPg.AddObject("txt_4c_Pesom", "TextBox")
3112:         WITH loc_oPg.txt_4c_Pesom
3113:             .Value    = 0
3114:             .Top      = 596
3115:             .Left     = 10
3116:             .Width    = 79
3117:             .Height   = 23
3118:             .FontName = "Tahoma"
3119:             .FontSize = 8
3120:             .ReadOnly = .T.
3121:         ENDWITH
3122: 
3123:         loc_oPg.AddObject("txt_4c_MarkupA", "TextBox")
3124:         WITH loc_oPg.txt_4c_MarkupA
3125:             .Value    = 0
3126:             .Top      = 596
3127:             .Left     = 323
3128:             .Width    = 62
3129:             .Height   = 23
3130:             .FontName = "Tahoma"
3131:             .FontSize = 8
3132:             .ReadOnly = .T.
3133:         ENDWITH
3134: 
3135:         *-- === COMANDOS PARA grdCompo (Container com 5 botoes, top=145, left=947) ===========
3136:         loc_oPg.AddObject("obj_4c_CmdgCompo", "Container")
3137:         WITH loc_oPg.obj_4c_CmdgCompo
3138:             .Top         = 145
3139:             .Left        = 947
3140:             .Width       = 50
3141:             .Height      = 210
3142:             .BackStyle   = 0
3143:             .BorderWidth = 0
3144:             .Visible     = .T.
3145:         ENDWITH
3146: 
3147:         loc_oPg.obj_4c_CmdgCompo.AddObject("cmd_4c_CompoIncluir", "CommandButton")
3148:         WITH loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoIncluir
3149:             .Caption         = "+"
3150:             .Top             = 0
3151:             .Left            = 0
3152:             .Width           = 50
3153:             .Height          = 42
3154:             .FontName        = "Tahoma"
3155:             .FontSize        = 14
3156:             .FontBold        = .T.
3157:             .Themes          = .F.
3158:             .SpecialEffect   = 0
3159:             .BackColor       = RGB(255,255,255)
3160:             .ForeColor       = RGB(0,128,0)
3161:             .ToolTipText     = "Incluir"
3162:             .Visible         = .T.
3163:         ENDWITH
3164:         BINDEVENT(loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoIncluir, "Click", THIS, "CmdCompoIncluirClick")
3165: 
3166:         loc_oPg.obj_4c_CmdgCompo.AddObject("cmd_4c_CompoExcluir", "CommandButton")
3167:         WITH loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoExcluir
3168:             .Caption         = "-"
3169:             .Top             = 42
3170:             .Left            = 0
3171:             .Width           = 50
3172:             .Height          = 42
3173:             .FontName        = "Tahoma"
3174:             .FontSize        = 14
3175:             .FontBold        = .T.
3176:             .Themes          = .F.
3177:             .SpecialEffect   = 0
3178:             .BackColor       = RGB(255,255,255)
3179:             .ForeColor       = RGB(180,0,0)
3180:             .ToolTipText     = "Excluir"
3181:             .Visible         = .T.
3182:         ENDWITH
3183:         BINDEVENT(loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoExcluir, "Click", THIS, "CmdCompoExcluirClick")
3184: 
3185:         loc_oPg.obj_4c_CmdgCompo.AddObject("cmd_4c_CompoAtualizar", "CommandButton")
3186:         WITH loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoAtualizar
3187:             .Caption         = CHR(8635)
3188:             .Top             = 84
3189:             .Left            = 0
3190:             .Width           = 50
3191:             .Height          = 42
3192:             .FontName        = "Tahoma"
3193:             .FontSize        = 10
3194:             .Themes          = .F.
3195:             .SpecialEffect   = 0
3196:             .BackColor       = RGB(255,255,255)
3197:             .ForeColor       = RGB(0,0,180)
3198:             .ToolTipText     = "Atualizar Pre" + CHR(231) + "os"
3199:             .Visible         = .T.
3200:         ENDWITH
3201:         BINDEVENT(loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoAtualizar, "Click", THIS, "CmdCompoAtualizarClick")
3202: 
3203:         loc_oPg.obj_4c_CmdgCompo.AddObject("cmd_4c_CompoPeso", "CommandButton")
3204:         WITH loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoPeso
3205:             .Caption         = "Kg"
3206:             .Top             = 126
3207:             .Left            = 0
3208:             .Width           = 50
3209:             .Height          = 42
3210:             .FontName        = "Tahoma"
3211:             .FontSize        = 8
3212:             .Themes          = .F.
3213:             .SpecialEffect   = 0
3214:             .BackColor       = RGB(255,255,255)
3215:             .ForeColor       = RGB(90,90,90)
3216:             .ToolTipText     = "Atualizar Pesos"
3217:             .Visible         = .T.
3218:         ENDWITH
3219:         BINDEVENT(loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoPeso, "Click", THIS, "CmdCompoAtuPesosClick")
3220: 
3221:         loc_oPg.obj_4c_CmdgCompo.AddObject("cmd_4c_CompoRecalc", "CommandButton")
3222:         WITH loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoRecalc
3223:             .Caption         = "="
3224:             .Top             = 168
3225:             .Left            = 0
3226:             .Width           = 50
3227:             .Height          = 42
3228:             .FontName        = "Tahoma"
3229:             .FontSize        = 14
3230:             .Themes          = .F.
3231:             .SpecialEffect   = 0
3232:             .BackColor       = RGB(255,255,255)
3233:             .ForeColor       = RGB(90,90,90)
3234:             .ToolTipText     = "Recalcular"
3235:             .Visible         = .T.
3236:         ENDWITH
3237:         BINDEVENT(loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoRecalc, "Click", THIS, "CmdCompoRecalcClick")
3238: 
3239:         *-- === COMANDOS PARA grdsubcp (Container com 2 botoes, top=345, left=947) ==========
3240:         loc_oPg.AddObject("obj_4c_CmdgSubCp", "Container")
3241:         WITH loc_oPg.obj_4c_CmdgSubCp
3242:             .Top         = 345
3243:             .Left        = 947
3244:             .Width       = 50
3245:             .Height      = 90
3246:             .BackStyle   = 0
3247:             .BorderWidth = 0
3248:             .Visible     = .T.
3249:         ENDWITH
3250: 
3251:         loc_oPg.obj_4c_CmdgSubCp.AddObject("cmd_4c_SubCpIncluir", "CommandButton")
3252:         WITH loc_oPg.obj_4c_CmdgSubCp.cmd_4c_SubCpIncluir
3253:             .Caption         = "+"
3254:             .Top             = 0
3255:             .Left            = 0
3256:             .Width           = 50
3257:             .Height          = 45
3258:             .FontName        = "Tahoma"
3259:             .FontSize        = 14
3260:             .FontBold        = .T.
3261:             .Themes          = .F.
3262:             .SpecialEffect   = 0
3263:             .BackColor       = RGB(255,255,255)
3264:             .ForeColor       = RGB(0,128,0)
3265:             .ToolTipText     = "Incluir Sub-Componente"
3266:             .Visible         = .T.
3267:         ENDWITH
3268:         BINDEVENT(loc_oPg.obj_4c_CmdgSubCp.cmd_4c_SubCpIncluir, "Click", THIS, "CmdSubCpIncluirClick")
3269: 
3270:         loc_oPg.obj_4c_CmdgSubCp.AddObject("cmd_4c_SubCpExcluir", "CommandButton")
3271:         WITH loc_oPg.obj_4c_CmdgSubCp.cmd_4c_SubCpExcluir
3272:             .Caption         = "-"
3273:             .Top             = 45
3274:             .Left            = 0
3275:             .Width           = 50
3276:             .Height          = 45
3277:             .FontName        = "Tahoma"
3278:             .FontSize        = 14
3279:             .FontBold        = .T.
3280:             .Themes          = .F.
3281:             .SpecialEffect   = 0
3282:             .BackColor       = RGB(255,255,255)
3283:             .ForeColor       = RGB(180,0,0)
3284:             .ToolTipText     = "Excluir Sub-Componente"
3285:             .Visible         = .T.
3286:         ENDWITH
3287:         BINDEVENT(loc_oPg.obj_4c_CmdgSubCp.cmd_4c_SubCpExcluir, "Click", THIS, "CmdSubCpExcluirClick")
3288: 
3289:         *-- === OBSERVACAO E DESCRICAO (entre grdCompo e grdsubcp, top=297-325) =============
3290:         loc_oPg.AddObject("lbl_4c_Label4", "Label")
3291:         WITH loc_oPg.lbl_4c_Label4
3292:             .Caption   = "Obs. da OF :"
3293:             .Top       = 300
3294:             .Left      = 36
3295:             .Width     = 64
3296:             .Height    = 15
3297:             .FontName  = "Tahoma"
3298:             .FontSize  = 8
3299:             .BackStyle = 0
3300:             .ForeColor = RGB(90,90,90)
3301:         ENDWITH
3302: 
3303:         loc_oPg.AddObject("txt_4c_ObsOFs", "TextBox")
3304:         WITH loc_oPg.txt_4c_ObsOFs
3305:             .Value    = ""
3306:             .Top      = 297
3307:             .Left     = 99
3308:             .Width    = 850
3309:             .Height   = 21
3310:             .FontName = "Tahoma"
3311:             .FontSize = 8
3312:             .MaxLength = 100
3313:         ENDWITH
3314: 
3315:         loc_oPg.AddObject("lbl_4c_Label16", "Label")
3316:         WITH loc_oPg.lbl_4c_Label16
3317:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
3318:             .Top       = 324
3319:             .Left      = 45
3320:             .Width     = 55
3321:             .Height    = 15
3322:             .FontName  = "Tahoma"
3323:             .FontSize  = 8
3324:             .BackStyle = 0
3325:             .ForeColor = RGB(90,90,90)
3326:         ENDWITH
3327: 
3328:         loc_oPg.AddObject("txt_4c_Desc", "TextBox")
3329:         WITH loc_oPg.txt_4c_Desc
3330:             .Value    = ""
3331:             .Top      = 321
3332:             .Left     = 99
3333:             .Width    = 298
3334:             .Height   = 21
3335:             .FontName = "Tahoma"
3336:             .FontSize = 8
3337:         ENDWITH
3338:         BINDEVENT(loc_oPg.txt_4c_Desc, "LostFocus", THIS, "TabCompo_DescLostFocus")
3339: 
3340:         loc_oPg.AddObject("lbl_4c_Label15", "Label")
3341:         WITH loc_oPg.lbl_4c_Label15
3342:             .Caption   = "Material Principal :"
3343:             .Top       = 324
3344:             .Left      = 421
3345:             .Width     = 89
3346:             .Height    = 15
3347:             .FontName  = "Tahoma"
3348:             .FontSize  = 8
3349:             .BackStyle = 0
3350:             .ForeColor = RGB(90,90,90)
3351:         ENDWITH
3352: 
3353:         loc_oPg.AddObject("txt_4c_MatP", "TextBox")
3354:         WITH loc_oPg.txt_4c_MatP
3355:             .Value    = ""
3356:             .Top      = 321
3357:             .Left     = 517
3358:             .Width    = 108
3359:             .Height   = 21
3360:             .FontName = "Tahoma"
3361:             .FontSize = 8
3362:         ENDWITH
3363:         BINDEVENT(loc_oPg.txt_4c_MatP, "LostFocus", THIS, "TabCompo_MatPLostFocus")
3364: 
3365:         *-- === CAMPOS SUB-COMPONENTE (abaixo de grdsubcp, top=432-435) =====================
3366:         loc_oPg.AddObject("lbl_4c_Label3", "Label")
3367:         WITH loc_oPg.lbl_4c_Label3
3368:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
3369:             .Top       = 435
3370:             .Left      = 39
3371:             .Width     = 55
3372:             .Height    = 15
3373:             .FontName  = "Tahoma"
3374:             .FontSize  = 8
3375:             .BackStyle = 0
3376:             .ForeColor = RGB(90,90,90)
3377:         ENDWITH
3378: 
3379:         loc_oPg.AddObject("txt_4c__desccp", "TextBox")
3380:         WITH loc_oPg.txt_4c__desccp
3381:             .Value    = ""
3382:             .Top      = 432
3383:             .Left     = 99
3384:             .Width    = 298
3385:             .Height   = 21
3386:             .FontName = "Tahoma"
3387:             .FontSize = 8
3388:         ENDWITH
3389:         BINDEVENT(loc_oPg.txt_4c__desccp, "LostFocus", THIS, "TabCompo_DesccpLostFocus")
3390: 
3391:         loc_oPg.AddObject("lbl_4c_Label5", "Label")
3392:         WITH loc_oPg.lbl_4c_Label5
3393:             .Caption   = "Substitui :"
3394:             .Top       = 435
3395:             .Left      = 465
3396:             .Width     = 50
3397:             .Height    = 15
3398:             .FontName  = "Tahoma"
3399:             .FontSize  = 8
3400:             .BackStyle = 0
3401:             .ForeColor = RGB(90,90,90)
3402:         ENDWITH
3403: 
3404:         loc_oPg.AddObject("txt_4c__matsub", "TextBox")
3405:         WITH loc_oPg.txt_4c__matsub
3406:             .Value    = ""
3407:             .Top      = 432
3408:             .Left     = 517
3409:             .Width    = 108
3410:             .Height   = 21
3411:             .FontName = "Tahoma"
3412:             .FontSize = 8
3413:         ENDWITH
3414:         BINDEVENT(loc_oPg.txt_4c__matsub, "LostFocus", THIS, "TabCompo_MatsubLostFocus")
3415: 
3416:         *-- === CHECKBOXES LIBERAR CUSTO / VENDA (top=458-459) ==============================
3417:         loc_oPg.AddObject("chk_4c_ChkLiberaCusto", "CheckBox")
3418:         WITH loc_oPg.chk_4c_ChkLiberaCusto
3419:             .Caption   = "Custo"
3420:             .Value     = .F.
3421:             .Top       = 458
3422:             .Left      = 9
3423:             .Width     = 39
3424:             .Height    = 38
3425:             .FontName  = "Tahoma"
3426:             .FontSize  = 8
3427:             .BackStyle = 0
3428:             .Themes    = .F.
3429:             .Visible   = .T.
3430:         ENDWITH
3431:         BINDEVENT(loc_oPg.chk_4c_ChkLiberaCusto, "Click", THIS, "ChkLiberaCustoClick")
3432: 
3433:         loc_oPg.AddObject("chk_4c_ChkLiberaVenda", "CheckBox")
3434:         WITH loc_oPg.chk_4c_ChkLiberaVenda
3435:             .Caption   = "Venda"
3436:             .Value     = .F.
3437:             .Top       = 459
3438:             .Left      = 323
3439:             .Width     = 39
3440:             .Height    = 38
3441:             .FontName  = "Tahoma"
3442:             .FontSize  = 8
3443:             .BackStyle = 0
3444:             .Themes    = .F.
3445:             .Visible   = .T.
3446:         ENDWITH
3447:         BINDEVENT(loc_oPg.chk_4c_ChkLiberaVenda, "Click", THIS, "ChkLiberaVendaClick")
3448: 
3449:         *-- === LABELS DIVISORES CUSTO/VENDA (top=473-474) ==================================
3450:         loc_oPg.AddObject("lbl_4c_Label1", "Label")
3451:         WITH loc_oPg.lbl_4c_Label1
3452:             .Caption   = " Custo "
3453:             .Top       = 473
3454:             .Left      = 47
3455:             .Width     = 46
3456:             .Height    = 16
3457:             .FontName  = "Tahoma"
3458:             .FontSize  = 8
3459:             .BackStyle = 1
3460:             .BackColor = RGB(220,220,220)
3461:             .ForeColor = RGB(50,50,50)
3462:         ENDWITH
3463: 
3464:         loc_oPg.AddObject("lbl_4c_Label2", "Label")
3465:         WITH loc_oPg.lbl_4c_Label2
3466:             .Caption   = " Venda "
3467:             .Top       = 474
3468:             .Left      = 361
3469:             .Width     = 48
3470:             .Height    = 16
3471:             .FontName  = "Tahoma"
3472:             .FontSize  = 8
3473:             .BackStyle = 1
3474:             .BackColor = RGB(220,220,220)
3475:             .ForeColor = RGB(50,50,50)
3476:         ENDWITH
3477: 
3478:         *-- === SHAPES DIVISORES VISUAIS (top=497-498) ======================================
3479:         loc_oPg.AddObject("shp_4c_Shape6", "Shape")
3480:         WITH loc_oPg.shp_4c_Shape6
3481:             .Top         = 497
3482:             .Left        = 9
3483:             .Width       = 158
3484:             .Height      = 2
3485:             .BackColor   = RGB(180,180,180)
3486:             .BackStyle   = 1
3487:             .BorderColor = RGB(180,180,180)
3488:         ENDWITH
3489: 
3490:         loc_oPg.AddObject("shp_4c_Shape4", "Shape")
3491:         WITH loc_oPg.shp_4c_Shape4
3492:             .Top         = 498
3493:             .Left        = 323
3494:             .Width       = 158
3495:             .Height      = 2
3496:             .BackColor   = RGB(180,180,180)
3497:             .BackStyle   = 1
3498:             .BorderColor = RGB(180,180,180)
3499:         ENDWITH
3500: 
3501:         *-- === ROTULOS AREA CUSTO (top=502-542) ============================================
3502:         *-- lbl_4c_LblCuVda: "Fator de Custo (Moeda 2)" ja existe como lblCompra/lbl_4c_PcusLabel
3503:         *-- Adiciona label faltante para a coluna direita do custo
3504:         loc_oPg.AddObject("lbl_4c_LblCuVda", "Label")
3505:         WITH loc_oPg.lbl_4c_LblCuVda
3506:             .Caption   = "Fator de Custo (Moeda 2)"
3507:             .Top       = 502
3508:             .Left      = 161
3509:             .Width     = 126
3510:             .Height    = 15
3511:             .FontName  = "Tahoma"
3512:             .FontSize  = 8
3513:             .BackStyle = 0
3514:             .ForeColor = RGB(90,90,90)
3515:         ENDWITH
3516: 
3517:         loc_oPg.AddObject("lbl_4c_Label8", "Label")
3518:         WITH loc_oPg.lbl_4c_Label8
3519:             .Caption   = "Total "
3520:             .Top       = 542
3521:             .Left      = 161
3522:             .Width     = 29
3523:             .Height    = 15
3524:             .FontName  = "Tahoma"
3525:             .FontSize  = 8
3526:             .BackStyle = 0
3527:             .ForeColor = RGB(90,90,90)
3528:         ENDWITH
3529: 
3530:         *-- lbl_4c_Label7 (Say7 "Cotacao") para GetCotaCalcP
3531:         loc_oPg.AddObject("lbl_4c_Label7", "Label")
3532:         WITH loc_oPg.lbl_4c_Label7
3533:             .Caption   = "Cota" + CHR(231) + CHR(227) + "o"
3534:             .Top       = 581
3535:             .Left      = 161
3536:             .Width     = 42
3537:             .Height    = 15
3538:             .FontName  = "Tahoma"
3539:             .FontSize  = 8
3540:             .BackStyle = 0
3541:             .ForeColor = RGB(90,90,90)
3542:         ENDWITH
3543: 
3544:         *-- GetCotaCalcP (top=596, left=161): cotacao para calculo
3545:         loc_oPg.AddObject("txt_4c_CotaCalcP", "TextBox")
3546:         WITH loc_oPg.txt_4c_CotaCalcP
3547:             .Value    = 0
3548:             .Top      = 596
3549:             .Left     = 161
3550:             .Width    = 115
3551:             .Height   = 23
3552:             .FontName = "Tahoma"
3553:             .FontSize = 8
3554:             .ReadOnly = .T.
3555:         ENDWITH
3556: 
3557:         *-- Say6 "Peso Medio" (top=581, left=10)
3558:         loc_oPg.AddObject("lbl_4c_Label6", "Label")
3559:         WITH loc_oPg.lbl_4c_Label6
3560:             .Caption   = "Peso M" + CHR(233) + "dio"
3561:             .Top       = 581
3562:             .Left      = 10
3563:             .Width     = 56
3564:             .Height    = 15
3565:             .FontName  = "Tahoma"
3566:             .FontSize  = 8
3567:             .BackStyle = 0
3568:             .ForeColor = RGB(90,90,90)
3569:         ENDWITH
3570: 
3571:         *-- cmdPesoM "..." (top=597, left=92)
3572:         loc_oPg.AddObject("cmd_4c_CmdPesoM", "CommandButton")
3573:         WITH loc_oPg.cmd_4c_CmdPesoM
3574:             .Caption         = "..."
3575:             .Top             = 597
3576:             .Left            = 92
3577:             .Width           = 26
3578:             .Height          = 23
3579:             .FontName        = "Tahoma"
3580:             .FontSize        = 8
3581:             .Themes          = .F.
3582:             .SpecialEffect   = 0
3583:             .BackColor       = RGB(255,255,255)
3584:             .ForeColor       = RGB(90,90,90)
3585:             .ToolTipText     = "Calcular Peso"
3586:             .Visible         = .T.
3587:         ENDWITH
3588:         BINDEVENT(loc_oPg.cmd_4c_CmdPesoM, "Click", THIS, "CmdPesoMClick")
3589: 
3590:         *-- Say22 "MKP" (top=542, left=9) - label para Get_cmkpc
3591:         loc_oPg.AddObject("lbl_4c_Label22", "Label")
3592:         WITH loc_oPg.lbl_4c_Label22
3593:             .Caption   = "MKP"
3594:             .Top       = 542
3595:             .Left      = 9
3596:             .Width     = 22
3597:             .Height    = 15
3598:             .FontName  = "Tahoma"
3599:             .FontSize  = 8
3600:             .BackStyle = 0
3601:             .ForeColor = RGB(90,90,90)
3602:         ENDWITH
3603: 
3604:         *-- Get_cmkpc (top=557, left=9, w=24): markup de custo
3605:         loc_oPg.AddObject("txt_4c_Cmkpc", "TextBox")
3606:         WITH loc_oPg.txt_4c_Cmkpc
3607:             .Value    = ""
3608:             .Top      = 557
3609:             .Left     = 9
3610:             .Width    = 24
3611:             .Height   = 23
3612:             .FontName = "Tahoma"
3613:             .FontSize = 8
3614:         ENDWITH
3615:         BINDEVENT(loc_oPg.txt_4c_Cmkpc, "LostFocus", THIS, "TabCompo_CmkpcLostFocus")
3616: 
3617:         *-- lblValAdics (top=542, left=64): "Valor Adicional"
3618:         loc_oPg.AddObject("lbl_4c_LblValAdics", "Label")
3619:         WITH loc_oPg.lbl_4c_LblValAdics
3620:             .Caption   = "Valor Adicional"
3621:             .Top       = 542
3622:             .Left      = 64
3623:             .Width     = 71
3624:             .Height    = 15
3625:             .FontName  = "Tahoma"
3626:             .FontSize  = 8
3627:             .BackStyle = 0
3628:             .ForeColor = RGB(90,90,90)
3629:         ENDWITH
3630: 
3631:         *-- get_pftioc (top=557, left=64, w=94): valor adicional custo (read-only)
3632:         loc_oPg.AddObject("txt_4c__pftioc", "TextBox")
3633:         WITH loc_oPg.txt_4c__pftioc
3634:             .Value    = 0
3635:             .Top      = 557
3636:             .Left     = 64
3637:             .Width    = 94
3638:             .Height   = 23
3639:             .FontName = "Tahoma"
3640:             .FontSize = 8
3641:             .ReadOnly = .T.
3642:         ENDWITH
3643: 
3644:         *-- chkPlanCus (top=556, left=36): planejamento custo
3645:         loc_oPg.AddObject("chk_4c_ChkPlanCus", "CheckBox")
3646:         WITH loc_oPg.chk_4c_ChkPlanCus
3647:             .Caption   = ""
3648:             .Value     = .F.
3649:             .Top       = 556
3650:             .Left      = 36
3651:             .Width     = 25
3652:             .Height    = 25
3653:             .BackStyle = 0
3654:             .Themes    = .F.
3655:             .Visible   = .T.
3656:         ENDWITH
3657: 
3658:         *-- === ROTULOS AREA VENDA (top=503-542) ============================================
3659:         *-- lbl_4c_LblMkpVenda "MKP Ideal" (top=504, left=324)
3660:         loc_oPg.AddObject("lbl_4c_LblMkpVenda", "Label")
3661:         WITH loc_oPg.lbl_4c_LblMkpVenda
3662:             .Caption   = "MKP Ideal"
3663:             .Top       = 504
3664:             .Left      = 324
3665:             .Width     = 49
3666:             .Height    = 15
3667:             .FontName  = "Tahoma"
3668:             .FontSize  = 8
3669:             .BackStyle = 0
3670:             .ForeColor = RGB(90,90,90)
3671:         ENDWITH
3672: 
3673:         *-- getMargem (top=517, left=323, w=89): markup ideal de venda
3674:         loc_oPg.AddObject("txt_4c_Margem", "TextBox")
3675:         WITH loc_oPg.txt_4c_Margem
3676:             .Value    = 0
3677:             .Top      = 517
3678:             .Left     = 323
3679:             .Width    = 89
3680:             .Height   = 23
3681:             .FontName = "Tahoma"
3682:             .FontSize = 8
3683:         ENDWITH
3684:         BINDEVENT(loc_oPg.txt_4c_Margem, "LostFocus", THIS, "TabCompo_MargemLostFocus")
3685: 
3686:         *-- lblIdeal "Preco Ideal (Moeda 1)" (top=503, left=416)
3687:         loc_oPg.AddObject("lbl_4c_LblIdeal", "Label")
3688:         WITH loc_oPg.lbl_4c_LblIdeal
3689:             .Caption   = "Pre" + CHR(231) + "o Ideal  (Moeda 1)"
3690:             .Top       = 503
3691:             .Left      = 416
3692:             .Width     = 111
3693:             .Height    = 15
3694:             .FontName  = "Tahoma"
3695:             .FontSize  = 8
3696:             .BackStyle = 0
3697:             .ForeColor = RGB(90,90,90)
3698:         ENDWITH
3699: 
3700:         *-- getPvideal (top=517, left=416, w=110): preco ideal (read-only)
3701:         loc_oPg.AddObject("txt_4c_Pvideal", "TextBox")
3702:         WITH loc_oPg.txt_4c_Pvideal
3703:             .Value    = 0
3704:             .Top      = 517
3705:             .Left     = 416
3706:             .Width    = 110
3707:             .Height   = 23
3708:             .FontName = "Tahoma"
3709:             .FontSize = 8
3710:             .ReadOnly = .T.
3711:         ENDWITH
3712: 
3713:         *-- getMoeda (top=517, left=529, w=31): moeda de venda (editable+lookup)
3714:         loc_oPg.AddObject("txt_4c_Moeda", "TextBox")
3715:         WITH loc_oPg.txt_4c_Moeda
3716:             .Value    = ""
3717:             .Top      = 517
3718:             .Left     = 529
3719:             .Width    = 31
3720:             .Height   = 23
3721:             .FontName = "Tahoma"
3722:             .FontSize = 8
3723:         ENDWITH
3724:         BINDEVENT(loc_oPg.txt_4c_Moeda, "LostFocus", THIS, "TabCompo_MoedaLostFocus")
3725: 
3726:         *-- lblFIdeals "Fator Ideal" (top=503, left=563)
3727:         loc_oPg.AddObject("lbl_4c_LblFIdeals", "Label")
3728:         WITH loc_oPg.lbl_4c_LblFIdeals
3729:             .Caption   = "Fator Ideal"
3730:             .Top       = 503
3731:             .Left      = 563
3732:             .Width     = 55
3733:             .Height    = 15
3734:             .FontName  = "Tahoma"
3735:             .FontSize  = 8
3736:             .BackStyle = 0
3737:             .ForeColor = RGB(90,90,90)
3738:         ENDWITH
3739: 
3740:         *-- getFIdeals (top=517, left=563, w=110): fator ideal (read-only)
3741:         loc_oPg.AddObject("txt_4c_FIdeals", "TextBox")
3742:         WITH loc_oPg.txt_4c_FIdeals
3743:             .Value    = 0
3744:             .Top      = 517
3745:             .Left     = 563
3746:             .Width    = 110
3747:             .Height   = 23
3748:             .FontName = "Tahoma"
3749:             .FontSize = 8
3750:             .ReadOnly = .T.
3751:         ENDWITH
3752: 
3753:         *-- Say14 "MKP" (top=542, left=360) - label para Getftio
3754:         loc_oPg.AddObject("lbl_4c_Label14", "Label")
3755:         WITH loc_oPg.lbl_4c_Label14
3756:             .Caption   = "MKP"
3757:             .Top       = 542
3758:             .Left      = 360
3759:             .Width     = 22
3760:             .Height    = 15
3761:             .FontName  = "Tahoma"
3762:             .FontSize  = 8
3763:             .BackStyle = 0
3764:             .ForeColor = RGB(90,90,90)
3765:         ENDWITH
3766: 
3767:         *-- Getftio (top=557, left=360, w=24): fiacao venda (editable+lookup)
3768:         loc_oPg.AddObject("txt_4c_Ftio", "TextBox")
3769:         WITH loc_oPg.txt_4c_Ftio
3770:             .Value    = ""
3771:             .Top      = 557
3772:             .Left     = 360
3773:             .Width    = 24
3774:             .Height   = 23
3775:             .FontName = "Tahoma"
3776:             .FontSize = 8
3777:         ENDWITH
3778:         BINDEVENT(loc_oPg.txt_4c_Ftio, "LostFocus", THIS, "TabCompo_FtioLostFocus")
3779: 
3780:         *-- Say13 "Valor Adicional" (top=542, left=416)
3781:         loc_oPg.AddObject("lbl_4c_Label13", "Label")
3782:         WITH loc_oPg.lbl_4c_Label13
3783:             .Caption   = "Valor Adicional"
3784:             .Top       = 542
3785:             .Left      = 416
3786:             .Width     = 71
3787:             .Height    = 15
3788:             .FontName  = "Tahoma"
3789:             .FontSize  = 8
3790:             .BackStyle = 0
3791:             .ForeColor = RGB(90,90,90)
3792:         ENDWITH
3793: 
3794:         *-- Get_Pftio (top=557, left=416, w=110): valor adicional/preco com fiacao (read-only)
3795:         loc_oPg.AddObject("txt_4c_Pftio", "TextBox")
3796:         WITH loc_oPg.txt_4c_Pftio
3797:             .Value    = 0
3798:             .Top      = 557
3799:             .Left     = 416
3800:             .Width    = 110
3801:             .Height   = 23
3802:             .FontName = "Tahoma"
3803:             .FontSize = 8
3804:             .ReadOnly = .T.
3805:         ENDWITH
3806: 
3807:         *-- Say12 "Fator" (top=542, left=563)
3808:         loc_oPg.AddObject("lbl_4c_Label12", "Label")
3809:         WITH loc_oPg.lbl_4c_Label12
3810:             .Caption   = "Fator"
3811:             .Top       = 542
3812:             .Left      = 563
3813:             .Width     = 28
3814:             .Height    = 15
3815:             .FontName  = "Tahoma"
3816:             .FontSize  = 8
3817:             .BackStyle = 0
3818:             .ForeColor = RGB(90,90,90)
3819:         ENDWITH
3820: 
3821:         *-- getFvenda (top=557, left=563, w=110): fator de venda (editable)
3822:         loc_oPg.AddObject("txt_4c_Fvenda", "TextBox")
3823:         WITH loc_oPg.txt_4c_Fvenda
3824:             .Value    = 0
3825:             .Top      = 557
3826:             .Left     = 563
3827:             .Width    = 110
3828:             .Height   = 23
3829:             .FontName = "Tahoma"
3830:             .FontSize = 8
3831:         ENDWITH
3832:         BINDEVENT(loc_oPg.txt_4c_Fvenda, "LostFocus", THIS, "TabCompo_FvendaLostFocus")
3833: 
3834:         *-- getMoepv (top=557, left=677, w=31): moeda preco venda (editable+lookup)
3835:         loc_oPg.AddObject("txt_4c_Moepv", "TextBox")
3836:         WITH loc_oPg.txt_4c_Moepv
3837:             .Value    = ""
3838:             .Top      = 557
3839:             .Left     = 677
3840:             .Width    = 31
3841:             .Height   = 23
3842:             .FontName = "Tahoma"
3843:             .FontSize = 8
3844:         ENDWITH
3845:         BINDEVENT(loc_oPg.txt_4c_Moepv, "LostFocus", THIS, "TabCompo_MoepvLostFocus")
3846: 
3847:         *-- Get_mftio (top=557, left=529, w=31): markup fiacao (read-only)
3848:         loc_oPg.AddObject("txt_4c_Mftio", "TextBox")
3849:         WITH loc_oPg.txt_4c_Mftio
3850:             .Value    = 0
3851:             .Top      = 557
3852:             .Left     = 529
3853:             .Width    = 31
3854:             .Height   = 23
3855:             .FontName = "Tahoma"
3856:             .FontSize = 8
3857:             .ReadOnly = .T.
3858:         ENDWITH
3859: 
3860:         *-- Say24 "Sts" (top=542, left=324) - label para getStatus
3861:         loc_oPg.AddObject("lbl_4c_Label24", "Label")
3862:         WITH loc_oPg.lbl_4c_Label24
3863:             .Caption   = "Sts"
3864:             .Top       = 542
3865:             .Left      = 324
3866:             .Width     = 17
3867:             .Height    = 15
3868:             .FontName  = "Tahoma"
3869:             .FontSize  = 8
3870:             .BackStyle = 0
3871:             .ForeColor = RGB(90,90,90)
3872:         ENDWITH
3873: 
3874:         *-- getStatus (top=557, left=324, w=31): status composicao (editable+lookup)
3875:         loc_oPg.AddObject("txt_4c_Status", "TextBox")
3876:         WITH loc_oPg.txt_4c_Status
3877:             .Value    = ""
3878:             .Top      = 557
3879:             .Left     = 324
3880:             .Width    = 31
3881:             .Height   = 23
3882:             .FontName = "Tahoma"
3883:             .FontSize = 8
3884:         ENDWITH
3885:         BINDEVENT(loc_oPg.txt_4c_Status, "LostFocus", THIS, "TabCompo_StatusLostFocus")
3886: 
3887:         *-- chkPlanVen (top=556, left=387): planejamento venda
3888:         loc_oPg.AddObject("chk_4c_ChkPlanVen", "CheckBox")
3889:         WITH loc_oPg.chk_4c_ChkPlanVen
3890:             .Caption   = ""
3891:             .Value     = .F.
3892:             .Top       = 556
3893:             .Left      = 387
3894:             .Width     = 25
3895:             .Height    = 25
3896:             .BackStyle = 0
3897:             .Themes    = .F.
3898:             .Visible   = .T.
3899:         ENDWITH
3900: 
3901:         *-- Chk_Pvenda (top=595, left=387, w=25, h=25): usar preco ideal
3902:         loc_oPg.AddObject("chk_4c_ChkPvenda", "CheckBox")
3903:         WITH loc_oPg.chk_4c_ChkPvenda
3904:             .Caption   = ""
3905:             .Value     = .F.
3906:             .Top       = 595
3907:             .Left      = 387
3908:             .Width     = 25
3909:             .Height    = 25
3910:             .BackStyle = 0
3911:             .Themes    = .F.
3912:             .ToolTipText = "Usar Pre" + CHR(231) + "o Ideal"
3913:             .Visible   = .T.
3914:         ENDWITH
3915:         BINDEVENT(loc_oPg.chk_4c_ChkPvenda, "Click", THIS, "ChkPvendaClick")
3916: 
3917:         *-- lblVenda "Preco Atual (Moeda 2)" (top=581, left=416)
3918:         loc_oPg.AddObject("lbl_4c_LblVenda", "Label")
3919:         WITH loc_oPg.lbl_4c_LblVenda
3920:             .Caption   = "Pre" + CHR(231) + "o  Atual  (Moeda 2)"
3921:             .Top       = 581
3922:             .Left      = 416
3923:             .Width     = 115
3924:             .Height    = 15
3925:             .FontName  = "Tahoma"
3926:             .FontSize  = 8
3927:             .BackStyle = 0
3928:             .ForeColor = RGB(90,90,90)
3929:         ENDWITH
3930: 
3931:         *-- getPven (top=596, left=416, w=110): preco de venda atual (read-only)
3932:         loc_oPg.AddObject("txt_4c_Pven", "TextBox")
3933:         WITH loc_oPg.txt_4c_Pven
3934:             .Value    = 0
3935:             .Top      = 596
3936:             .Left     = 416
3937:             .Width    = 110
3938:             .Height   = 23
3939:             .FontName = "Tahoma"
3940:             .FontSize = 8
3941:             .ReadOnly = .T.
3942:         ENDWITH
3943: 
3944:         *-- getMoev (top=596, left=529, w=31): moeda valor venda (editable+lookup)
3945:         loc_oPg.AddObject("txt_4c_Moev", "TextBox")
3946:         WITH loc_oPg.txt_4c_Moev
3947:             .Value    = ""
3948:             .Top      = 596
3949:             .Left     = 529
3950:             .Width    = 31
3951:             .Height   = 23
3952:             .FontName = "Tahoma"
3953:             .FontSize = 8
3954:         ENDWITH
3955:         BINDEVENT(loc_oPg.txt_4c_Moev, "LostFocus", THIS, "TabCompo_MoevLostFocus")
3956: 
3957:         *-- lblFAtuals "Fator Atual" (top=581, left=563)
3958:         loc_oPg.AddObject("lbl_4c_LblFAtuals", "Label")
3959:         WITH loc_oPg.lbl_4c_LblFAtuals
3960:             .Caption   = "Fator Atual"
3961:             .Top       = 581
3962:             .Left      = 563
3963:             .Width     = 56
3964:             .Height    = 15
3965:             .FontName  = "Tahoma"
3966:             .FontSize  = 8
3967:             .BackStyle = 0
3968:             .ForeColor = RGB(90,90,90)
3969:         ENDWITH
3970: 
3971:         *-- getFAtuals (top=596, left=563, w=110): fator atual (read-only)
3972:         loc_oPg.AddObject("txt_4c_FAtuals", "TextBox")
3973:         WITH loc_oPg.txt_4c_FAtuals
3974:             .Value    = 0
3975:             .Top      = 596
3976:             .Left     = 563
3977:             .Width    = 110
3978:             .Height   = 23
3979:             .FontName = "Tahoma"
3980:             .FontSize = 8
3981:             .ReadOnly = .T.
3982:         ENDWITH
3983: 
3984:         *-- Say25 "Financeiro" (top=581, left=678) - label para Get_Encarg
3985:         loc_oPg.AddObject("lbl_4c_Label25", "Label")
3986:         WITH loc_oPg.lbl_4c_Label25
3987:             .Caption   = "Financeiro"
3988:             .Top       = 581
3989:             .Left      = 678
3990:             .Width     = 51
3991:             .Height    = 15
3992:             .FontName  = "Tahoma"
3993:             .FontSize  = 8
3994:             .BackStyle = 0
3995:             .ForeColor = RGB(90,90,90)
3996:         ENDWITH
3997: 
3998:         *-- Get_Encarg (top=595, left=678, w=62): encargos financeiros (read-only)
3999:         loc_oPg.AddObject("txt_4c_Encarg", "TextBox")
4000:         WITH loc_oPg.txt_4c_Encarg
4001:             .Value    = 0
4002:             .Top      = 595
4003:             .Left     = 678
4004:             .Width    = 62
4005:             .Height   = 23
4006:             .FontName = "Tahoma"
4007:             .FontSize = 8
4008:             .ReadOnly = .T.
4009:         ENDWITH
4010: 
4011:         *-- lbl_4c_LblMkpApl "MKP Aplic." (top=581, left=324)
4012:         loc_oPg.AddObject("lbl_4c_LblMkpApl", "Label")
4013:         WITH loc_oPg.lbl_4c_LblMkpApl
4014:             .Caption   = "MKP Aplic."
4015:             .Top       = 581
4016:             .Left      = 324
4017:             .Width     = 51
4018:             .Height    = 15
4019:             .FontName  = "Tahoma"
4020:             .FontSize  = 8
4021:             .BackStyle = 0
4022:             .ForeColor = RGB(90,90,90)
4023:         ENDWITH
4024: 
4025:         *-- cmd_4c_CmdCalcVals "Calcular" (top=507, left=678, w=40, h=40)
4026:         loc_oPg.AddObject("cmd_4c_CmdCalcVals", "CommandButton")
4027:         WITH loc_oPg.cmd_4c_CmdCalcVals
4028:             .Caption         = "Calc"
4029:             .Top             = 507
4030:             .Left            = 678
4031:             .Width           = 40
4032:             .Height          = 40
4033:             .FontName        = "Tahoma"
4034:             .FontSize        = 7
4035:             .Themes          = .F.
4036:             .SpecialEffect   = 0
4037:             .BackColor       = RGB(255,255,255)
4038:             .ForeColor       = RGB(0,0,180)
4039:             .ToolTipText     = "Calcular Valores"
4040:             .Visible         = .T.
4041:         ENDWITH
4042:         BINDEVENT(loc_oPg.cmd_4c_CmdCalcVals, "Click", THIS, "CmdCalcValsClick")
4043: 
4044:         *-- BINDEVENT para campos de moeda existentes (getMoec, getMoecusf)
4045:         BINDEVENT(loc_oPg.txt_4c_PcusMoe,  "LostFocus", THIS, "TabCompo_MoecLostFocus")
4046:         BINDEVENT(loc_oPg.txt_4c_MoecusFoe,"LostFocus", THIS, "TabCompo_MoecusfLostFocus")
4047: 

*-- Linhas 4120 a 4146:
4120:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
4121: 
4122:         *-- Label "Tipo :" (top=159, left=112)
4123:         loc_oPg.AddObject("lbl_4c_TipoCusto", "Label")
4124:         WITH loc_oPg.lbl_4c_TipoCusto
4125:             .Caption   = "Tipo :"
4126:             .Top       = 159
4127:             .Left      = 112
4128:             .Width     = 29
4129:             .Height    = 15
4130:             .FontName  = "Tahoma"
4131:             .FontSize  = 8
4132:             .BackStyle = 0
4133:             .ForeColor = RGB(90, 90, 90)
4134:         ENDWITH
4135: 
4136:         *-- ComboBox cmbTipos (top=154, left=143, width=187)
4137:         *-- Filtra o grid de custos por tipo de calculo de custo
4138:         loc_oPg.AddObject("cmb_4c_TiposCusto", "ComboBox")
4139:         WITH loc_oPg.cmb_4c_TiposCusto
4140:             .Top       = 154
4141:             .Left      = 143
4142:             .Width     = 187
4143:             .Height    = 23
4144:             .Style     = 2
4145:             .FontName  = "Tahoma"
4146:             .FontSize  = 8

*-- Linhas 4158 a 4167:
4158:         *-- Dados: SIGPRCPO filtrado por Tipos (tipo de calculo)
4159:         loc_oPg.AddObject("grd_4c_CompoCusto", "Grid")
4160:         WITH loc_oPg.grd_4c_CompoCusto
4161:             .Top         = 178
4162:             .Left        = 34
4163:             .Width       = 813
4164:             .Height      = 230
4165:             .ReadOnly    = .F.
4166:             .DeleteMark  = .F.
4167:             .RecordMark  = .F.

*-- Linhas 4173 a 4342:
4173:             .Visible     = .T.
4174:         ENDWITH
4175:         WITH loc_oPg.grd_4c_CompoCusto
4176:             .Column1.Header1.Caption  = "Item"
4177:             .Column1.Width  = 80
4178:             .Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
4179:             .Column2.Width  = 180
4180:             .Column3.Header1.Caption  = "Un"
4181:             .Column3.Width  = 35
4182:             .Column4.Header1.Caption  = "Valor"
4183:             .Column4.Width  = 75
4184:             .Column5.Header1.Caption  = "Qtd"
4185:             .Column5.Width  = 60
4186:             .Column6.Header1.Caption  = "Total"
4187:             .Column6.Width  = 75
4188:             .Column7.Header1.Caption  = "Moe"
4189:             .Column7.Width  = 35
4190:             .Column8.Header1.Caption  = "Observa" + CHR(231) + CHR(227) + "o"
4191:             .Column8.Width  = 75
4192:             .Column9.Header1.Caption  = "Etiq"
4193:             .Column9.Width  = 35
4194:             .Column10.Header1.Caption = "Consumo"
4195:             .Column10.Width = 70
4196:             .Column11.Header1.Caption = "Qtd"
4197:             .Column11.Width = 55
4198:             .Column12.Header1.Caption = "Un"
4199:             .Column12.Width = 35
4200:         ENDWITH
4201:         BINDEVENT(loc_oPg.grd_4c_CompoCusto, "AfterRowColChange", THIS, "CustosGrd_AfterRowColChange")
4202: 
4203:         *-- Botoes Incluir/Excluir para grid de custo
4204:         *-- Legado: cmdgCompo (CommandGroup) top=240, left=851, buttonCount=2
4205:         loc_oPg.AddObject("cnt_4c_BotoesCusto", "Container")
4206:         WITH loc_oPg.cnt_4c_BotoesCusto
4207:             .Top         = 178
4208:             .Left        = 851
4209:             .Width       = 50
4210:             .Height      = 90
4211:             .BackStyle = 1
4212:             .BackColor = RGB(53, 53, 53)
4213:             .BorderWidth = 0
4214:             .Visible     = .T.
4215:         ENDWITH
4216: 
4217:         loc_oPg.cnt_4c_BotoesCusto.AddObject("cmd_4c_CustoIncluir", "CommandButton")
4218:         WITH loc_oPg.cnt_4c_BotoesCusto.cmd_4c_CustoIncluir
4219:             .Caption       = "+"
4220:             .Top           = 0
4221:             .Left          = 0
4222:             .Width         = 50
4223:             .Height        = 45
4224:             .FontName      = "Tahoma"
4225:             .FontSize      = 14
4226:             .FontBold      = .T.
4227:             .Themes        = .F.
4228:             .SpecialEffect = 0
4229:             .BackColor     = RGB(230, 255, 230)
4230:             .ForeColor     = RGB(0, 128, 0)
4231:             .Visible       = .T.
4232:         ENDWITH
4233:         BINDEVENT(loc_oPg.cnt_4c_BotoesCusto.cmd_4c_CustoIncluir, "Click", THIS, "CmdCustoIncluirClick")
4234: 
4235:         loc_oPg.cnt_4c_BotoesCusto.AddObject("cmd_4c_CustoExcluir", "CommandButton")
4236:         WITH loc_oPg.cnt_4c_BotoesCusto.cmd_4c_CustoExcluir
4237:             .Caption       = "-"
4238:             .Top           = 45
4239:             .Left          = 0
4240:             .Width         = 50
4241:             .Height        = 45
4242:             .FontName      = "Tahoma"
4243:             .FontSize      = 14
4244:             .FontBold      = .T.
4245:             .Themes        = .F.
4246:             .SpecialEffect = 0
4247:             .BackColor     = RGB(255, 230, 230)
4248:             .ForeColor     = RGB(192, 0, 0)
4249:             .Visible       = .T.
4250:         ENDWITH
4251:         BINDEVENT(loc_oPg.cnt_4c_BotoesCusto.cmd_4c_CustoExcluir, "Click", THIS, "CmdCustoExcluirClick")
4252: 
4253:         *-- Shape separador horizontal (Shape2: top=460, left=35, width=158, height=2)
4254:         loc_oPg.AddObject("shp_4c_SepCusto", "Shape")
4255:         WITH loc_oPg.shp_4c_SepCusto
4256:             .Top         = 460
4257:             .Left        = 35
4258:             .Width       = 158
4259:             .Height      = 2
4260:             .FillColor   = RGB(180, 180, 180)
4261:             .BackColor   = RGB(180, 180, 180)
4262:             .BorderColor = RGB(180, 180, 180)
4263:         ENDWITH
4264: 
4265:         *-- Label "Descricao :" (Say16: top=415, left=52)
4266:         loc_oPg.AddObject("lbl_4c_DescCusto", "Label")
4267:         WITH loc_oPg.lbl_4c_DescCusto
4268:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
4269:             .Top       = 415
4270:             .Left      = 52
4271:             .Width     = 62
4272:             .Height    = 15
4273:             .FontName  = "Tahoma"
4274:             .FontSize  = 8
4275:             .BackStyle = 0
4276:             .ForeColor = RGB(90, 90, 90)
4277:         ENDWITH
4278: 
4279:         *-- TextBox Get_Desc - mostra descricao do item selecionado (top=412, left=116, width=304)
4280:         loc_oPg.AddObject("txt_4c_DescCusto", "TextBox")
4281:         WITH loc_oPg.txt_4c_DescCusto
4282:             .Value    = ""
4283:             .Top      = 412
4284:             .Left     = 116
4285:             .Width    = 304
4286:             .Height   = 21
4287:             .FontName = "Tahoma"
4288:             .FontSize = 8
4289:             .ReadOnly = .T.
4290:         ENDWITH
4291: 
4292:         *-- Label "Grupo :" (Say2: top=415, left=479)
4293:         loc_oPg.AddObject("lbl_4c_GrupoCusto", "Label")
4294:         WITH loc_oPg.lbl_4c_GrupoCusto
4295:             .Caption   = "Grupo :"
4296:             .Top       = 415
4297:             .Left      = 479
4298:             .Width     = 40
4299:             .Height    = 15
4300:             .FontName  = "Tahoma"
4301:             .FontSize  = 8
4302:             .BackStyle = 0
4303:             .ForeColor = RGB(90, 90, 90)
4304:         ENDWITH
4305: 
4306:         *-- TextBox getDGruCompos - mostra grupo do item selecionado (top=412, left=522, width=304)
4307:         loc_oPg.AddObject("txt_4c_DGruCompos", "TextBox")
4308:         WITH loc_oPg.txt_4c_DGruCompos
4309:             .Value    = ""
4310:             .Top      = 412
4311:             .Left     = 522
4312:             .Width    = 304
4313:             .Height   = 21
4314:             .FontName = "Tahoma"
4315:             .FontSize = 8
4316:             .ReadOnly = .T.
4317:         ENDWITH
4318: 
4319:         *-- Label "Resumo por Grupo" (Say3: top=445, left=35)
4320:         loc_oPg.AddObject("lbl_4c_ResumoGrp", "Label")
4321:         WITH loc_oPg.lbl_4c_ResumoGrp
4322:             .Caption   = "Resumo por Grupo"
4323:             .Top       = 445
4324:             .Left      = 35
4325:             .Width     = 107
4326:             .Height    = 15
4327:             .FontName  = "Tahoma"
4328:             .FontSize  = 8
4329:             .BackStyle = 0
4330:             .ForeColor = RGB(90, 90, 90)
4331:         ENDWITH
4332: 
4333:         *-- GradeGRUPO2 - Totais por grupo (top=468, left=35, width=195, height=141, 3 cols)
4334:         loc_oPg.AddObject("grd_4c_GrupoCompo2", "Grid")
4335:         WITH loc_oPg.grd_4c_GrupoCompo2
4336:             .Top         = 468
4337:             .Left        = 35
4338:             .Width       = 195
4339:             .Height      = 141
4340:             .ReadOnly    = .T.
4341:             .DeleteMark  = .F.
4342:             .RecordMark  = .F.

*-- Linhas 4348 a 4360:
4348:             .Visible     = .T.
4349:         ENDWITH
4350:         WITH loc_oPg.grd_4c_GrupoCompo2
4351:             .Column1.Header1.Caption = "Grp"
4352:             .Column1.Width = 55
4353:             .Column2.Header1.Caption = "Total"
4354:             .Column2.Width = 100
4355:             .Column3.Header1.Caption = "Moe"
4356:             .Column3.Width = 35
4357:         ENDWITH
4358: 
4359:         *-- Cursor placeholder para grd_4c_CompoCusto
4360:         IF !USED("cursor_4c_CompoCusto")

*-- Linhas 4401 a 4617:
4401:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
4402: 
4403:         *-- Classificacao Fiscal (top=211, left=206, width=94)
4404:         loc_oPg.AddObject("lbl_4c_Clfiscal", "Label")
4405:         WITH loc_oPg.lbl_4c_Clfiscal
4406:             .Caption   = "Classifica" + CHR(231) + CHR(227) + "o Fiscal :"
4407:             .Top       = 216
4408:             .Left      = 102
4409:             .Width     = 99
4410:             .Height    = 15
4411:             .FontName  = "Tahoma"
4412:             .FontSize  = 8
4413:             .BackStyle = 0
4414:             .ForeColor = RGB(90,90,90)
4415:         ENDWITH
4416: 
4417:         loc_oPg.AddObject("txt_4c_Clfiscal", "TextBox")
4418:         WITH loc_oPg.txt_4c_Clfiscal
4419:             .Value    = ""
4420:             .Top      = 211
4421:             .Left     = 206
4422:             .Width    = 94
4423:             .Height   = 23
4424:             .FontName = "Tahoma"
4425:             .FontSize = 8
4426:             .MaxLength = 10
4427:         ENDWITH
4428:         BINDEVENT(loc_oPg.txt_4c_Clfiscal, "KeyPress", THIS, "TabFiscal_ClfiscalKeyPress")
4429: 
4430:         loc_oPg.AddObject("txt_4c_Dclfiscal", "TextBox")
4431:         WITH loc_oPg.txt_4c_Dclfiscal
4432:             .Value    = ""
4433:             .Top      = 211
4434:             .Left     = 303
4435:             .Width    = 303
4436:             .Height   = 23
4437:             .FontName = "Tahoma"
4438:             .FontSize = 8
4439:             .ReadOnly = .T.
4440:         ENDWITH
4441: 
4442:         *-- Origem Mercadoria (top=236, left=206, width=17)
4443:         loc_oPg.AddObject("lbl_4c_Origmerc", "Label")
4444:         WITH loc_oPg.lbl_4c_Origmerc
4445:             .Caption   = "Origem da Mercadoria :"
4446:             .Top       = 241
4447:             .Left      = 87
4448:             .Width     = 114
4449:             .Height    = 15
4450:             .FontName  = "Tahoma"
4451:             .FontSize  = 8
4452:             .BackStyle = 0
4453:             .ForeColor = RGB(90,90,90)
4454:         ENDWITH
4455: 
4456:         loc_oPg.AddObject("txt_4c_Origmerc", "TextBox")
4457:         WITH loc_oPg.txt_4c_Origmerc
4458:             .Value    = ""
4459:             .Top      = 236
4460:             .Left     = 206
4461:             .Width    = 17
4462:             .Height   = 23
4463:             .FontName = "Tahoma"
4464:             .FontSize = 8
4465:             .MaxLength = 1
4466:         ENDWITH
4467: 
4468:         loc_oPg.AddObject("txt_4c_Dorigmerc", "TextBox")
4469:         WITH loc_oPg.txt_4c_Dorigmerc
4470:             .Value    = ""
4471:             .Top      = 236
4472:             .Left     = 226
4473:             .Width    = 380
4474:             .Height   = 23
4475:             .FontName = "Tahoma"
4476:             .FontSize = 8
4477:             .ReadOnly = .T.
4478:         ENDWITH
4479: 
4480:         *-- Situacao Tributaria ICMS (top=261, left=206, width=31)
4481:         loc_oPg.AddObject("lbl_4c_Sittricms", "Label")
4482:         WITH loc_oPg.lbl_4c_Sittricms
4483:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS :"
4484:             .Top       = 266
4485:             .Left      = 74
4486:             .Width     = 127
4487:             .Height    = 15
4488:             .FontName  = "Tahoma"
4489:             .FontSize  = 8
4490:             .BackStyle = 0
4491:             .ForeColor = RGB(90,90,90)
4492:         ENDWITH
4493: 
4494:         loc_oPg.AddObject("txt_4c_Sittricms", "TextBox")
4495:         WITH loc_oPg.txt_4c_Sittricms
4496:             .Value    = ""
4497:             .Top      = 261
4498:             .Left     = 206
4499:             .Width    = 31
4500:             .Height   = 23
4501:             .FontName = "Tahoma"
4502:             .FontSize = 8
4503:             .MaxLength = 3
4504:         ENDWITH
4505: 
4506:         loc_oPg.AddObject("txt_4c_Dsittricms", "TextBox")
4507:         WITH loc_oPg.txt_4c_Dsittricms
4508:             .Value    = ""
4509:             .Top      = 261
4510:             .Left     = 240
4511:             .Width    = 366
4512:             .Height   = 23
4513:             .FontName = "Tahoma"
4514:             .FontSize = 8
4515:             .ReadOnly = .T.
4516:         ENDWITH
4517: 
4518:         *-- Aliquota ICMS (top=286, left=342, width=45)
4519:         loc_oPg.AddObject("lbl_4c_Icms", "Label")
4520:         WITH loc_oPg.lbl_4c_Icms
4521:             .Caption   = "Al" + CHR(237) + "quota ICMS :"
4522:             .Top       = 291
4523:             .Left      = 250
4524:             .Width     = 85
4525:             .Height    = 15
4526:             .FontName  = "Tahoma"
4527:             .FontSize  = 8
4528:             .BackStyle = 0
4529:             .ForeColor = RGB(90,90,90)
4530:         ENDWITH
4531: 
4532:         loc_oPg.AddObject("txt_4c_Icms", "TextBox")
4533:         WITH loc_oPg.txt_4c_Icms
4534:             .Value    = 0
4535:             .Top      = 286
4536:             .Left     = 342
4537:             .Width    = 45
4538:             .Height   = 23
4539:             .FontName = "Tahoma"
4540:             .FontSize = 8
4541:         ENDWITH
4542: 
4543:         *-- Tipo Tributacao (top=286, left=513, width=38)
4544:         loc_oPg.AddObject("lbl_4c_Tptribs", "Label")
4545:         WITH loc_oPg.lbl_4c_Tptribs
4546:             .Caption   = "Tipo de Tributa" + CHR(231) + CHR(227) + "o :"
4547:             .Top       = 291
4548:             .Left      = 395
4549:             .Width     = 110
4550:             .Height    = 15
4551:             .FontName  = "Tahoma"
4552:             .FontSize  = 8
4553:             .BackStyle = 0
4554:             .ForeColor = RGB(90,90,90)
4555:         ENDWITH
4556: 
4557:         loc_oPg.AddObject("txt_4c_Tptribs", "TextBox")
4558:         WITH loc_oPg.txt_4c_Tptribs
4559:             .Value    = ""
4560:             .Top      = 286
4561:             .Left     = 513
4562:             .Width    = 38
4563:             .Height   = 23
4564:             .FontName = "Tahoma"
4565:             .FontSize = 8
4566:             .MaxLength = 4
4567:         ENDWITH
4568: 
4569:         *-- Codigo de Servicos (top=286, left=206, width=38)
4570:         loc_oPg.AddObject("lbl_4c_CodServs", "Label")
4571:         WITH loc_oPg.lbl_4c_CodServs
4572:             .Caption   = "C" + CHR(243) + "digo de Servi" + CHR(231) + "os para ICMS :"
4573:             .Top       = 291
4574:             .Left      = 48
4575:             .Width     = 153
4576:             .Height    = 15
4577:             .FontName  = "Tahoma"
4578:             .FontSize  = 8
4579:             .BackStyle = 0
4580:             .ForeColor = RGB(90,90,90)
4581:         ENDWITH
4582: 
4583:         loc_oPg.AddObject("txt_4c_CodServs", "TextBox")
4584:         WITH loc_oPg.txt_4c_CodServs
4585:             .Value    = ""
4586:             .Top      = 286
4587:             .Left     = 206
4588:             .Width    = 38
4589:             .Height   = 23
4590:             .FontName = "Tahoma"
4591:             .FontSize = 8
4592:             .MaxLength = 4
4593:         ENDWITH
4594: 
4595:         *-- IPI (top=311, left=206, combobox)
4596:         loc_oPg.AddObject("lbl_4c_Ipis", "Label")
4597:         WITH loc_oPg.lbl_4c_Ipis
4598:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria IPI :"
4599:             .Top       = 316
4600:             .Left      = 85
4601:             .Width     = 116
4602:             .Height    = 15
4603:             .FontName  = "Tahoma"
4604:             .FontSize  = 8
4605:             .BackStyle = 0
4606:             .ForeColor = RGB(90,90,90)
4607:         ENDWITH
4608: 
4609:         loc_oPg.AddObject("cmb_4c_Ipi", "ComboBox")
4610:         WITH loc_oPg.cmb_4c_Ipi
4611:             .Top    = 311
4612:             .Left   = 206
4613:             .Width  = 108
4614:             .Height = 25
4615:             .Style  = 2
4616:             .FontName = "Tahoma"
4617:             .FontSize = 8

*-- Linhas 4625 a 4790:
4625:         ENDWITH
4626: 
4627:         *-- Descricao Fiscal memo (top=338, left=206, width=509, height=89)
4628:         loc_oPg.AddObject("lbl_4c_DescFis", "Label")
4629:         WITH loc_oPg.lbl_4c_DescFis
4630:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o Fiscal :"
4631:             .Top       = 341
4632:             .Left      = 117
4633:             .Width     = 84
4634:             .Height    = 15
4635:             .FontName  = "Tahoma"
4636:             .FontSize  = 8
4637:             .BackStyle = 0
4638:             .ForeColor = RGB(90,90,90)
4639:         ENDWITH
4640: 
4641:         loc_oPg.AddObject("txt_4c_DescFis", "EditBox")
4642:         WITH loc_oPg.txt_4c_DescFis
4643:             .Value    = ""
4644:             .Top      = 338
4645:             .Left     = 206
4646:             .Width    = 509
4647:             .Height   = 89
4648:             .FontName = "Tahoma"
4649:             .FontSize = 8
4650:         ENDWITH
4651: 
4652:         *-- Metal (top=429, left=537)
4653:         loc_oPg.AddObject("lbl_4c_Metal", "Label")
4654:         WITH loc_oPg.lbl_4c_Metal
4655:             .Caption   = "Metal :"
4656:             .Top       = 429
4657:             .Left      = 480
4658:             .Width     = 55
4659:             .Height    = 15
4660:             .FontName  = "Tahoma"
4661:             .FontSize  = 8
4662:             .BackStyle = 0
4663:             .ForeColor = RGB(90,90,90)
4664:         ENDWITH
4665: 
4666:         loc_oPg.AddObject("txt_4c_Metal", "TextBox")
4667:         WITH loc_oPg.txt_4c_Metal
4668:             .Value    = ""
4669:             .Top      = 429
4670:             .Left     = 537
4671:             .Width    = 24
4672:             .Height   = 23
4673:             .FontName = "Tahoma"
4674:             .FontSize = 8
4675:             .MaxLength = 2
4676:         ENDWITH
4677:         BINDEVENT(loc_oPg.txt_4c_Metal, "KeyPress", THIS, "TabFiscal_MetalKeyPress")
4678: 
4679:         loc_oPg.AddObject("txt_4c_DesMetal", "TextBox")
4680:         WITH loc_oPg.txt_4c_DesMetal
4681:             .Value    = ""
4682:             .Top      = 429
4683:             .Left     = 564
4684:             .Width    = 150
4685:             .Height   = 23
4686:             .FontName = "Tahoma"
4687:             .FontSize = 8
4688:             .ReadOnly = .T.
4689:         ENDWITH
4690: 
4691:         *-- Teor (top=454, left=537)
4692:         loc_oPg.AddObject("lbl_4c_Teor", "Label")
4693:         WITH loc_oPg.lbl_4c_Teor
4694:             .Caption   = "Teor :"
4695:             .Top       = 454
4696:             .Left      = 490
4697:             .Width     = 45
4698:             .Height    = 15
4699:             .FontName  = "Tahoma"
4700:             .FontSize  = 8
4701:             .BackStyle = 0
4702:             .ForeColor = RGB(90,90,90)
4703:         ENDWITH
4704: 
4705:         loc_oPg.AddObject("txt_4c_Teor", "TextBox")
4706:         WITH loc_oPg.txt_4c_Teor
4707:             .Value    = ""
4708:             .Top      = 454
4709:             .Left     = 537
4710:             .Width    = 24
4711:             .Height   = 23
4712:             .FontName = "Tahoma"
4713:             .FontSize = 8
4714:             .MaxLength = 2
4715:         ENDWITH
4716:         BINDEVENT(loc_oPg.txt_4c_Teor, "KeyPress", THIS, "TabFiscal_TeorKeyPress")
4717: 
4718:         loc_oPg.AddObject("txt_4c_DesTeor", "TextBox")
4719:         WITH loc_oPg.txt_4c_DesTeor
4720:             .Value    = ""
4721:             .Top      = 454
4722:             .Left     = 564
4723:             .Width    = 150
4724:             .Height   = 23
4725:             .FontName = "Tahoma"
4726:             .FontSize = 8
4727:             .ReadOnly = .T.
4728:         ENDWITH
4729: 
4730:         *-- Descricao ECF (top=429, left=206, width=213)
4731:         loc_oPg.AddObject("lbl_4c_DescEcf", "Label")
4732:         WITH loc_oPg.lbl_4c_DescEcf
4733:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o ECF :"
4734:             .Top       = 433
4735:             .Left      = 124
4736:             .Width     = 77
4737:             .Height    = 15
4738:             .FontName  = "Tahoma"
4739:             .FontSize  = 8
4740:             .BackStyle = 0
4741:             .ForeColor = RGB(90,90,90)
4742:         ENDWITH
4743: 
4744:         loc_oPg.AddObject("txt_4c_DescEcfs", "TextBox")
4745:         WITH loc_oPg.txt_4c_DescEcfs
4746:             .Value    = ""
4747:             .Top      = 429
4748:             .Left     = 206
4749:             .Width    = 213
4750:             .Height   = 23
4751:             .FontName = "Tahoma"
4752:             .FontSize = 8
4753:             .MaxLength = 29
4754:         ENDWITH
4755: 
4756:         *-- Valor Estimado (top=454, left=206)
4757:         loc_oPg.AddObject("lbl_4c_ValorEst", "Label")
4758:         WITH loc_oPg.lbl_4c_ValorEst
4759:             .Caption   = "Valor Estimado :"
4760:             .Top       = 458
4761:             .Left      = 122
4762:             .Width     = 79
4763:             .Height    = 15
4764:             .FontName  = "Tahoma"
4765:             .FontSize  = 8
4766:             .BackStyle = 0
4767:             .ForeColor = RGB(90,90,90)
4768:         ENDWITH
4769: 
4770:         loc_oPg.AddObject("txt_4c_Valors", "TextBox")
4771:         WITH loc_oPg.txt_4c_Valors
4772:             .Value    = 0
4773:             .Top      = 454
4774:             .Left     = 206
4775:             .Width    = 108
4776:             .Height   = 23
4777:             .FontName = "Tahoma"
4778:             .FontSize = 8
4779:         ENDWITH
4780: 
4781:         loc_oPg.AddObject("txt_4c_Moedas", "TextBox")
4782:         WITH loc_oPg.txt_4c_Moedas
4783:             .Value    = ""
4784:             .Top      = 454
4785:             .Left     = 317
4786:             .Width    = 31
4787:             .Height   = 23
4788:             .FontName = "Tahoma"
4789:             .FontSize = 8
4790:             .MaxLength = 3

*-- Linhas 4802 a 5023:
4802: 
4803:         *-- === GRUPO C.C. (get_gruccus: top=161, left=206, width=80) ============
4804: 
4805:         loc_oPg.AddObject("lbl_4c_Gruccus", "Label")
4806:         WITH loc_oPg.lbl_4c_Gruccus
4807:             .Caption   = "Grupo C.C. :"
4808:             .Top       = 165
4809:             .Left      = 138
4810:             .Width     = 63
4811:             .Height    = 15
4812:             .FontName  = "Tahoma"
4813:             .FontSize  = 8
4814:             .BackStyle = 0
4815:             .ForeColor = RGB(90, 90, 90)
4816:         ENDWITH
4817: 
4818:         loc_oPg.AddObject("txt_4c__gruccus", "TextBox")
4819:         WITH loc_oPg.txt_4c__gruccus
4820:             .Value         = ""
4821:             .Top           = 161
4822:             .Left          = 206
4823:             .Width         = 80
4824:             .Height        = 23
4825:             .FontName      = "Tahoma"
4826:             .FontSize      = 8
4827:             .MaxLength     = 10
4828:             .SpecialEffect = 1
4829:         ENDWITH
4830:         BINDEVENT(loc_oPg.txt_4c__gruccus, "LostFocus", THIS, "ValidarGruccus")
4831: 
4832:         loc_oPg.AddObject("txt_4c__dgruccus", "TextBox")
4833:         WITH loc_oPg.txt_4c__dgruccus
4834:             .Value    = ""
4835:             .Top      = 161
4836:             .Left     = 288
4837:             .Width    = 318
4838:             .Height   = 23
4839:             .FontName = "Tahoma"
4840:             .FontSize = 8
4841:             .ReadOnly = .T.
4842:         ENDWITH
4843:         BINDEVENT(loc_oPg.txt_4c__dgruccus, "LostFocus", THIS, "ValidarDgruccus")
4844: 
4845:         *-- === CONTA C.C. (get_contaccus: top=186, left=206, width=80) ==========
4846: 
4847:         loc_oPg.AddObject("lbl_4c_Contaccus", "Label")
4848:         WITH loc_oPg.lbl_4c_Contaccus
4849:             .Caption   = "Conta C.C. :"
4850:             .Top       = 189
4851:             .Left      = 138
4852:             .Width     = 63
4853:             .Height    = 15
4854:             .FontName  = "Tahoma"
4855:             .FontSize  = 8
4856:             .BackStyle = 0
4857:             .ForeColor = RGB(90, 90, 90)
4858:         ENDWITH
4859: 
4860:         loc_oPg.AddObject("txt_4c__contaccus", "TextBox")
4861:         WITH loc_oPg.txt_4c__contaccus
4862:             .Value         = ""
4863:             .Top           = 186
4864:             .Left          = 206
4865:             .Width         = 80
4866:             .Height        = 23
4867:             .FontName      = "Tahoma"
4868:             .FontSize      = 8
4869:             .MaxLength     = 10
4870:             .SpecialEffect = 1
4871:         ENDWITH
4872:         BINDEVENT(loc_oPg.txt_4c__contaccus, "LostFocus", THIS, "ValidarContaccus")
4873: 
4874:         loc_oPg.AddObject("txt_4c__dcontaccus", "TextBox")
4875:         WITH loc_oPg.txt_4c__dcontaccus
4876:             .Value    = ""
4877:             .Top      = 186
4878:             .Left     = 288
4879:             .Width    = 318
4880:             .Height   = 23
4881:             .FontName = "Tahoma"
4882:             .FontSize = 8
4883:             .ReadOnly = .T.
4884:         ENDWITH
4885:         BINDEVENT(loc_oPg.txt_4c__dcontaccus, "LostFocus", THIS, "ValidarDcontaccus")
4886: 
4887:         *-- === ALIQUOTA IPI (Get_AliqIPI: top=311, left=425, width=45) ==========
4888: 
4889:         loc_oPg.AddObject("lbl_4c_AliqIPI", "Label")
4890:         WITH loc_oPg.lbl_4c_AliqIPI
4891:             .Caption   = "Al" + CHR(237) + "quota de IPI :"
4892:             .Top       = 316
4893:             .Left      = 327
4894:             .Width     = 90
4895:             .Height    = 15
4896:             .FontName  = "Tahoma"
4897:             .FontSize  = 8
4898:             .BackStyle = 0
4899:             .ForeColor = RGB(90, 90, 90)
4900:         ENDWITH
4901: 
4902:         loc_oPg.AddObject("txt_4c_AliqIPI", "TextBox")
4903:         WITH loc_oPg.txt_4c_AliqIPI
4904:             .Value    = 0
4905:             .Top      = 311
4906:             .Left     = 425
4907:             .Width    = 45
4908:             .Height   = 25
4909:             .FontName = "Tahoma"
4910:             .FontSize = 8
4911:         ENDWITH
4912:         BINDEVENT(loc_oPg.txt_4c_AliqIPI, "LostFocus", THIS, "ValidarAliqIPI")
4913: 
4914:         *-- === EXCECAO DA TIPI/IPI (getextipi: top=311, left=601, width=35) ======
4915: 
4916:         loc_oPg.AddObject("lbl_4c_Extipi", "Label")
4917:         WITH loc_oPg.lbl_4c_Extipi
4918:             .Caption   = "Exce" + CHR(231) + CHR(227) + "o da TIPI :"
4919:             .Top       = 316
4920:             .Left      = 495
4921:             .Width     = 98
4922:             .Height    = 15
4923:             .FontName  = "Tahoma"
4924:             .FontSize  = 8
4925:             .BackStyle = 0
4926:             .ForeColor = RGB(90, 90, 90)
4927:         ENDWITH
4928: 
4929:         loc_oPg.AddObject("txt_4c_Extipi", "TextBox")
4930:         WITH loc_oPg.txt_4c_Extipi
4931:             .Value     = ""
4932:             .Top       = 311
4933:             .Left      = 601
4934:             .Width     = 35
4935:             .Height    = 25
4936:             .FontName  = "Tahoma"
4937:             .FontSize  = 8
4938:             .MaxLength = 3
4939:         ENDWITH
4940:         BINDEVENT(loc_oPg.txt_4c_Extipi, "GotFocus", THIS, "TabFiscal_ExtIpiGotFocus")
4941: 
4942:         *-- === IAT (getiat: top=286, left=589, width=17) ========================
4943: 
4944:         loc_oPg.AddObject("lbl_4c_Iat", "Label")
4945:         WITH loc_oPg.lbl_4c_Iat
4946:             .Caption   = "IAT :"
4947:             .Top       = 290
4948:             .Left      = 558
4949:             .Width     = 26
4950:             .Height    = 15
4951:             .FontName  = "Tahoma"
4952:             .FontSize  = 8
4953:             .BackStyle = 0
4954:             .ForeColor = RGB(90, 90, 90)
4955:         ENDWITH
4956: 
4957:         loc_oPg.AddObject("lbl_4c_IatDesc", "Label")
4958:         WITH loc_oPg.lbl_4c_IatDesc
4959:             .Caption   = "[A]rredondamento [T]runcamento"
4960:             .Top       = 290
4961:             .Left      = 609
4962:             .Width     = 165
4963:             .Height    = 15
4964:             .FontName  = "Tahoma"
4965:             .FontSize  = 8
4966:             .BackStyle = 0
4967:             .ForeColor = RGB(120, 120, 120)
4968:         ENDWITH
4969: 
4970:         loc_oPg.AddObject("txt_4c_Iat", "TextBox")
4971:         WITH loc_oPg.txt_4c_Iat
4972:             .Value     = ""
4973:             .Top       = 286
4974:             .Left      = 589
4975:             .Width     = 17
4976:             .Height    = 23
4977:             .FontName  = "Tahoma"
4978:             .FontSize  = 8
4979:             .MaxLength = 1
4980:         ENDWITH
4981:         BINDEVENT(loc_oPg.txt_4c_Iat, "LostFocus", THIS, "ValidarIat")
4982: 
4983:         *-- === IPPT/CST (getIPPTCST: top=479, left=206, width=108) =============
4984:         *-- Campo de exibicao calculado: nao armazenado, somente leitura
4985: 
4986:         loc_oPg.AddObject("lbl_4c_IPPTCST", "Label")
4987:         WITH loc_oPg.lbl_4c_IPPTCST
4988:             .Caption   = "IPPT/CST :"
4989:             .Top       = 483
4990:             .Left      = 147
4991:             .Width     = 54
4992:             .Height    = 15
4993:             .FontName  = "Tahoma"
4994:             .FontSize  = 8
4995:             .BackStyle = 0
4996:             .ForeColor = RGB(90, 90, 90)
4997:         ENDWITH
4998: 
4999:         loc_oPg.AddObject("txt_4c_IPPTCST", "TextBox")
5000:         WITH loc_oPg.txt_4c_IPPTCST
5001:             .Value    = ""
5002:             .Top      = 479
5003:             .Left     = 206
5004:             .Width    = 108
5005:             .Height   = 23
5006:             .FontName = "Tahoma"
5007:             .FontSize = 8
5008:             .ReadOnly = .T.
5009:         ENDWITH
5010: 
5011:         *-- === GRID CMV - Custo GR (grdCmv: top=338, left=754, width=223, h=141)
5012:         *-- 3 colunas: Periodo, Valor Custo GR, Moe
5013: 
5014:         loc_oPg.AddObject("lbl_4c_CmvTitulo", "Label")
5015:         WITH loc_oPg.lbl_4c_CmvTitulo
5016:             .Caption   = "Valor do Grama Produzido"
5017:             .Top       = 320
5018:             .Left      = 756
5019:             .Width     = 125
5020:             .Height    = 15
5021:             .FontName  = "Tahoma"
5022:             .FontSize  = 8
5023:             .BackStyle = 0

*-- Linhas 5032 a 5041:
5032: 
5033:         loc_oPg.AddObject("grd_4c_Cmv", "Grid")
5034:         WITH loc_oPg.grd_4c_Cmv
5035:             .Top         = 338
5036:             .Left        = 754
5037:             .Width       = 223
5038:             .Height      = 141
5039:             .ReadOnly    = .T.
5040:             .DeleteMark  = .F.
5041:             .RecordMark  = .F.

*-- Linhas 5047 a 5086:
5047:         ENDWITH
5048:         loc_oPg.grd_4c_Cmv.RecordSource = "cursor_4c_Cmv"
5049:         WITH loc_oPg.grd_4c_Cmv
5050:             .Column1.Header1.Caption = "Per" + CHR(237) + "odo"
5051:             .Column1.Width           = 65
5052:             .Column1.ControlSource   = "cursor_4c_Cmv.periodos"
5053:             .Column1.ReadOnly        = .T.
5054:             .Column2.Header1.Caption = "Valor Custo GR"
5055:             .Column2.Width           = 105
5056:             .Column2.ControlSource   = "cursor_4c_Cmv.valcustos"
5057:             .Column2.ReadOnly        = .T.
5058:             .Column3.Header1.Caption = "Moe"
5059:             .Column3.Width           = 40
5060:             .Column3.ControlSource   = "cursor_4c_Cmv.moedas"
5061:             .Column3.ReadOnly        = .T.
5062:         ENDWITH
5063: 
5064:         *-- === BOTAO GERAR DESCRICAO FISCAL (btnDescFis: top=359, left=162) ======
5065: 
5066:         loc_oPg.AddObject("cmd_4c_BtnDescFis", "CommandButton")
5067:         WITH loc_oPg.cmd_4c_BtnDescFis
5068:             .Caption         = ""
5069:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_32.jpg"
5070:             .PicturePosition = 5
5071:             .Top             = 359
5072:             .Left            = 162
5073:             .Width           = 40
5074:             .Height          = 40
5075:             .FontName        = "Tahoma"
5076:             .FontSize        = 8
5077:             .Themes          = .F.
5078:             .SpecialEffect   = 0
5079:             .ToolTipText     = "Gerar Descri" + CHR(231) + CHR(227) + "o Fiscal"
5080:         ENDWITH
5081:         BINDEVENT(loc_oPg.cmd_4c_BtnDescFis, "Click", THIS, "BtnDescFisClick")
5082: 
5083:         *-- === BINDEVENTS para controles JA CRIADOS em ConfigurarTabDadosFiscais ==
5084:         *-- Adicionar LostFocus nos campos lookup existentes
5085: 
5086:         BINDEVENT(loc_oPg.txt_4c_Clfiscal,  "LostFocus", THIS, "ValidarClfiscal")

*-- Linhas 5108 a 5117:
5108:         *-- Dados: sigprtar - Data Inicio, Data Conclusao, Usuario, Tarefa
5109:         loc_oPg.AddObject("grd_4c_Designer", "Grid")
5110:         WITH loc_oPg.grd_4c_Designer
5111:             .Top         = 160
5112:             .Left        = 10
5113:             .Width       = 495
5114:             .Height      = 238
5115:             .ReadOnly    = .T.
5116:             .DeleteMark  = .F.
5117:             .RecordMark  = .F.

*-- Linhas 5123 a 5201:
5123:             .Visible     = .T.
5124:         ENDWITH
5125:         WITH loc_oPg.grd_4c_Designer
5126:             .Column1.Header1.Caption = "Data de In" + CHR(237) + "cio"
5127:             .Column1.Width = 110
5128:             .Column2.Header1.Caption = "Data de Conclus" + CHR(227) + "o"
5129:             .Column2.Width = 120
5130:             .Column3.Header1.Caption = "Usu" + CHR(225) + "rio"
5131:             .Column3.Width = 100
5132:             .Column4.Header1.Caption = "Tarefa"
5133:             .Column4.Width = 160
5134:         ENDWITH
5135: 
5136:         *-- Observacao da Tarefa - EditBox (top=160, left=584, width=407, height=238)
5137:         loc_oPg.AddObject("lbl_4c_ObsTarefa", "Label")
5138:         WITH loc_oPg.lbl_4c_ObsTarefa
5139:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o da Tarefa"
5140:             .Top       = 144
5141:             .Left      = 583
5142:             .Width     = 130
5143:             .Height    = 15
5144:             .FontName  = "Tahoma"
5145:             .FontSize  = 8
5146:             .BackStyle = 0
5147:             .ForeColor = RGB(90,90,90)
5148:         ENDWITH
5149: 
5150:         loc_oPg.AddObject("txt_4c_ObsTarefas", "EditBox")
5151:         WITH loc_oPg.txt_4c_ObsTarefas
5152:             .Value    = ""
5153:             .Top      = 160
5154:             .Left     = 584
5155:             .Width    = 407
5156:             .Height   = 238
5157:             .FontName = "Tahoma"
5158:             .FontSize = 8
5159:             .ReadOnly = .T.
5160:         ENDWITH
5161: 
5162:         *-- Botoes de inicio/fim de tarefa (top=161 e 203, left=509)
5163:         loc_oPg.AddObject("cmd_4c_IniTarefa", "CommandButton")
5164:         WITH loc_oPg.cmd_4c_IniTarefa
5165:             .Caption = "Ini" + CHR(237) + "cio"
5166:             .Top     = 161
5167:             .Left    = 509
5168:             .Width   = 42
5169:             .Height  = 42
5170:             .FontName = "Tahoma"
5171:             .FontSize = 7
5172:             .Themes  = .F.
5173:             .Visible = .T.
5174:         ENDWITH
5175:         BINDEVENT(loc_oPg.cmd_4c_IniTarefa, "Click", THIS, "BtnIniTarefaClick")
5176: 
5177:         loc_oPg.AddObject("cmd_4c_FimTarefa", "CommandButton")
5178:         WITH loc_oPg.cmd_4c_FimTarefa
5179:             .Caption = "Fim"
5180:             .Top     = 203
5181:             .Left    = 509
5182:             .Width   = 42
5183:             .Height  = 42
5184:             .FontName = "Tahoma"
5185:             .FontSize = 7
5186:             .Themes  = .F.
5187:             .Visible = .T.
5188:         ENDWITH
5189:         BINDEVENT(loc_oPg.cmd_4c_FimTarefa, "Click", THIS, "BtnFimTarefaClick")
5190: 
5191:         *-- grdArquivos (top=415, left=10, width=495, height=202, 1 col)
5192:         *-- Dados: sigprarq - Arquivos do designer
5193:         loc_oPg.AddObject("grd_4c_Arquivos", "Grid")
5194:         WITH loc_oPg.grd_4c_Arquivos
5195:             .Top         = 415
5196:             .Left        = 10
5197:             .Width       = 495
5198:             .Height      = 202
5199:             .ReadOnly    = .T.
5200:             .DeleteMark  = .F.
5201:             .RecordMark  = .F.

*-- Linhas 5207 a 5260:
5207:             .Visible     = .T.
5208:         ENDWITH
5209:         WITH loc_oPg.grd_4c_Arquivos
5210:             .Column1.Header1.Caption = "Arquivos Para Designer"
5211:             .Column1.Width = 492
5212:         ENDWITH
5213: 
5214:         *-- Botoes de arquivo (top=416, 458, 500, left=509)
5215:         loc_oPg.AddObject("cmd_4c_InsArqs", "CommandButton")
5216:         WITH loc_oPg.cmd_4c_InsArqs
5217:             .Caption = "Inserir"
5218:             .Top     = 416
5219:             .Left    = 509
5220:             .Width   = 42
5221:             .Height  = 42
5222:             .FontName = "Tahoma"
5223:             .FontSize = 7
5224:             .Themes  = .F.
5225:             .Visible = .T.
5226:         ENDWITH
5227:         BINDEVENT(loc_oPg.cmd_4c_InsArqs, "Click", THIS, "BtnInsArqsClick")
5228: 
5229:         loc_oPg.AddObject("cmd_4c_ExcArqs", "CommandButton")
5230:         WITH loc_oPg.cmd_4c_ExcArqs
5231:             .Caption = "Excluir"
5232:             .Top     = 458
5233:             .Left    = 509
5234:             .Width   = 42
5235:             .Height  = 42
5236:             .FontName = "Tahoma"
5237:             .FontSize = 7
5238:             .Themes  = .F.
5239:             .Visible = .T.
5240:         ENDWITH
5241:         BINDEVENT(loc_oPg.cmd_4c_ExcArqs, "Click", THIS, "BtnExcArqsClick")
5242: 
5243:         loc_oPg.AddObject("cmd_4c_OpnArqs", "CommandButton")
5244:         WITH loc_oPg.cmd_4c_OpnArqs
5245:             .Caption = "Abrir"
5246:             .Top     = 500
5247:             .Left    = 509
5248:             .Width   = 42
5249:             .Height  = 42
5250:             .FontName = "Tahoma"
5251:             .FontSize = 7
5252:             .Themes  = .F.
5253:             .Visible = .T.
5254:         ENDWITH
5255:         BINDEVENT(loc_oPg.cmd_4c_OpnArqs, "Click", THIS, "BtnOpnArqsClick")
5256: 
5257:         *-- Criar cursors placeholder
5258:         IF !USED("cursor_4c_Designer")
5259:             SET NULL ON
5260:             CREATE CURSOR cursor_4c_Designer (dtinis D, dtfims D, usuars C(10), tarefas C(20))

*-- Linhas 5295 a 5317:
5295:         *-- Shape decorativo em volta da area de imagem (top=415, left=584, width=407, height=202)
5296:         loc_oPg.AddObject("shp_4c_Shape1", "Shape")
5297:         WITH loc_oPg.shp_4c_Shape1
5298:             .Top         = 415
5299:             .Left        = 584
5300:             .Width       = 407
5301:             .Height      = 202
5302:             .BorderColor = RGB(128, 128, 128)
5303:             .BorderWidth = 1
5304:             .BackStyle   = 0
5305:             .Visible     = .T.
5306:         ENDWITH
5307: 
5308:         *-- Imagem preview do arquivo selecionado (top=417, left=586, width=403, height=198)
5309:         loc_oPg.AddObject("img_4c_ImgArqJpg", "Image")
5310:         WITH loc_oPg.img_4c_ImgArqJpg
5311:             .Top     = 417
5312:             .Left    = 586
5313:             .Width   = 403
5314:             .Height  = 198
5315:             .Stretch = 2
5316:             .Visible = .F.
5317:         ENDWITH

*-- Linhas 5371 a 5380:
5371:         *-- Colunas somente leitura: 1-Componente, 2-Qtde, 3-Uni, 6-Ord, 9-DescCat
5372:         loc_oPg.AddObject("grd_4c_Consulta", "Grid")
5373:         WITH loc_oPg.grd_4c_Consulta
5374:             .Top         = 155
5375:             .Left        = 6
5376:             .Width       = 987
5377:             .Height      = 362
5378:             .ReadOnly    = .F.
5379:             .DeleteMark  = .F.
5380:             .RecordMark  = .F.

*-- Linhas 5388 a 5492:
5388:         *-- RecordSource ANTES dos headers/ControlSources (evita reset de colunas)
5389:         loc_oPg.grd_4c_Consulta.RecordSource = "cursor_4c_Consulta"
5390:         WITH loc_oPg.grd_4c_Consulta
5391:             .Column1.Header1.Caption = "Componente"
5392:             .Column1.Width           = 110
5393:             .Column1.ControlSource   = "cursor_4c_Consulta.mats"
5394:             .Column1.ReadOnly        = .T.
5395:             .Column2.Header1.Caption = "Qtde."
5396:             .Column2.Width           = 65
5397:             .Column2.ControlSource   = "cursor_4c_Consulta.qtds"
5398:             .Column2.ReadOnly        = .T.
5399:             .Column3.Header1.Caption = "Uni"
5400:             .Column3.Width           = 40
5401:             .Column3.ControlSource   = "cursor_4c_Consulta.unicompos"
5402:             .Column3.ReadOnly        = .T.
5403:             .Column4.Header1.Caption = "Fase"
5404:             .Column4.Width           = 80
5405:             .Column4.ControlSource   = "cursor_4c_Consulta.grupos"
5406:             .Column5.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
5407:             .Column5.Width           = 180
5408:             .Column5.ControlSource   = "cursor_4c_Consulta.dcompos"
5409:             .Column6.Header1.Caption = "Ord."
5410:             .Column6.Width           = 40
5411:             .Column6.ControlSource   = "cursor_4c_Consulta.ordems"
5412:             .Column6.ReadOnly        = .T.
5413:             .Column7.Header1.Caption = "Consumo"
5414:             .Column7.Width           = 75
5415:             .Column7.ControlSource   = "cursor_4c_Consulta.qtscons"
5416:             .Column8.Header1.Caption = "Cat."
5417:             .Column8.Width           = 55
5418:             .Column8.ControlSource   = "cursor_4c_Consulta.cats"
5419:             .Column9.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
5420:             .Column9.Width           = 150
5421:             .Column9.ControlSource   = "cursor_4c_Consulta.dscgrp"
5422:             .Column9.ReadOnly        = .T.
5423:         ENDWITH
5424:         BINDEVENT(loc_oPg.grd_4c_Consulta, "AfterRowColChange", THIS, "ConsultaGrd_AfterRowColChange")
5425: 
5426:         *-- Say7/lbl_4c_QtdCpnt: "Qtde Componentes :" (top=523, left=25)
5427:         loc_oPg.AddObject("lbl_4c_QtdCpnt", "Label")
5428:         WITH loc_oPg.lbl_4c_QtdCpnt
5429:             .Caption   = "Qtde Componentes : "
5430:             .Top       = 523
5431:             .Left      = 25
5432:             .Width     = 115
5433:             .Height    = 15
5434:             .FontName  = "Tahoma"
5435:             .FontSize  = 8
5436:             .BackStyle = 0
5437:             .ForeColor = RGB(90, 90, 90)
5438:         ENDWITH
5439: 
5440:         *-- Getqtcpnt/txt_4c_QtdCpnt: quantidade de componentes (top=519, left=131, width=31)
5441:         loc_oPg.AddObject("txt_4c_QtdCpnt", "TextBox")
5442:         WITH loc_oPg.txt_4c_QtdCpnt
5443:             .Top           = 519
5444:             .Left          = 131
5445:             .Width         = 31
5446:             .Height        = 23
5447:             .Value         = 0
5448:             .ReadOnly      = .T.
5449:             .SpecialEffect = 1
5450:             .FontName      = "Tahoma"
5451:             .FontSize      = 8
5452:         ENDWITH
5453: 
5454:         *-- chkFund/chk_4c_ChkFund: "Nao Checar Cadastro de Fundicao" (top=544, left=10)
5455:         loc_oPg.AddObject("chk_4c_ChkFund", "CheckBox")
5456:         WITH loc_oPg.chk_4c_ChkFund
5457:             .Caption  = "N" + CHR(227) + "o Checar Cadastro de Fundi" + CHR(231) + CHR(227) + "o"
5458:             .Top      = 544
5459:             .Left     = 10
5460:             .Width    = 200
5461:             .Height   = 15
5462:             .FontName = "Tahoma"
5463:             .FontSize = 8
5464:             .Value    = 0
5465:             .Themes   = .F.
5466:         ENDWITH
5467: 
5468:         *-- Say1/lbl_4c_TempoProd: "Tempo Producao por Agrupamento :" (top=521, left=642)
5469:         loc_oPg.AddObject("lbl_4c_TempoProd", "Label")
5470:         WITH loc_oPg.lbl_4c_TempoProd
5471:             .Caption   = "Tempo Produ" + CHR(231) + CHR(227) + "o por Agrupamento :"
5472:             .Top       = 521
5473:             .Left      = 642
5474:             .Width     = 176
5475:             .Height    = 15
5476:             .FontName  = "Tahoma"
5477:             .FontSize  = 8
5478:             .BackStyle = 0
5479:             .ForeColor = RGB(90, 90, 90)
5480:         ENDWITH
5481: 
5482:         *-- grDTEMP/grd_4c_Temp: grid tempo producao (top=519, left=821, width=172, height=107, 2 cols)
5483:         *-- Colunas: Agrupamento (grupos), Tempo % (totas) - somente leitura
5484:         loc_oPg.AddObject("grd_4c_Temp", "Grid")
5485:         WITH loc_oPg.grd_4c_Temp
5486:             .Top         = 519
5487:             .Left        = 821
5488:             .Width       = 172
5489:             .Height      = 107
5490:             .ReadOnly    = .T.
5491:             .DeleteMark  = .F.
5492:             .RecordMark  = .F.

*-- Linhas 5500 a 5511:
5500:         *-- RecordSource ANTES dos headers/ControlSources
5501:         loc_oPg.grd_4c_Temp.RecordSource = "cursor_4c_Temp"
5502:         WITH loc_oPg.grd_4c_Temp
5503:             .Column1.Header1.Caption = "Agrupamento"
5504:             .Column1.Width           = 100
5505:             .Column1.ControlSource   = "cursor_4c_Temp.grupos"
5506:             .Column2.Header1.Caption = "Tempo %"
5507:             .Column2.Width           = 65
5508:             .Column2.ControlSource   = "cursor_4c_Temp.totas"
5509:         ENDWITH
5510:     ENDPROC
5511: 

*-- Linhas 5535 a 5562:
5535:         *======================================================
5536:         *-- LABEL: Say13 - "Qtd. Min. Producao :"
5537:         *======================================================
5538:         loc_oPg.AddObject("lbl_4c_Qmin", "Label")
5539:         WITH loc_oPg.lbl_4c_Qmin
5540:             .Top      = 156
5541:             .Left     = 33
5542:             .Width    = 102
5543:             .Height   = 15
5544:             .Caption  = "Qtd. M" + CHR(237) + "n. Produ" + CHR(231) + CHR(227) + "o :"
5545:             .AutoSize = .F.
5546:             .FontName = "Tahoma"
5547:             .FontSize = 8
5548:             .Visible  = .T.
5549:         ENDWITH
5550: 
5551:         *======================================================
5552:         *-- TEXTBOX: getQmin - Qtde minima fabricacao
5553:         *======================================================
5554:         loc_oPg.AddObject("txt_4c_Qminfab", "TextBox")
5555:         WITH loc_oPg.txt_4c_Qminfab
5556:             .Top           = 152
5557:             .Left          = 137
5558:             .Width         = 80
5559:             .Height        = 23
5560:             .InputMask     = "999,999.99"
5561:             .ReadOnly      = .T.
5562:             .SpecialEffect = 1

*-- Linhas 5568 a 5650:
5568:         *======================================================
5569:         *-- LABEL + TEXTBOX: getCodGarras - Garra
5570:         *======================================================
5571:         loc_oPg.AddObject("lbl_4c_Garra", "Label")
5572:         WITH loc_oPg.lbl_4c_Garra
5573:             .Top      = 181
5574:             .Left     = 99
5575:             .Width    = 36
5576:             .Height   = 15
5577:             .Caption  = "Garra :"
5578:             .AutoSize = .F.
5579:             .FontName = "Tahoma"
5580:             .FontSize = 8
5581:             .Visible  = .T.
5582:         ENDWITH
5583: 
5584:         loc_oPg.AddObject("txt_4c_Codgarras", "TextBox")
5585:         WITH loc_oPg.txt_4c_Codgarras
5586:             .Top           = 177
5587:             .Left          = 137
5588:             .Width         = 80
5589:             .Height        = 23
5590:             .ReadOnly      = .T.
5591:             .SpecialEffect = 1
5592:             .FontName      = "Tahoma"
5593:             .FontSize      = 8
5594:             .Visible       = .T.
5595:         ENDWITH
5596: 
5597:         *======================================================
5598:         *-- LABEL + TEXTBOX: getConquilha - Conquilha
5599:         *======================================================
5600:         loc_oPg.AddObject("lbl_4c_Conquilha", "Label")
5601:         WITH loc_oPg.lbl_4c_Conquilha
5602:             .Top      = 206
5603:             .Left     = 79
5604:             .Width    = 57
5605:             .Height   = 15
5606:             .Caption  = "Conquilha :"
5607:             .AutoSize = .F.
5608:             .FontName = "Tahoma"
5609:             .FontSize = 8
5610:             .Visible  = .T.
5611:         ENDWITH
5612: 
5613:         loc_oPg.AddObject("txt_4c_Conquilhas", "TextBox")
5614:         WITH loc_oPg.txt_4c_Conquilhas
5615:             .Top           = 202
5616:             .Left          = 137
5617:             .Width         = 80
5618:             .Height        = 23
5619:             .ReadOnly      = .T.
5620:             .SpecialEffect = 1
5621:             .FontName      = "Tahoma"
5622:             .FontSize      = 8
5623:             .Visible       = .T.
5624:         ENDWITH
5625: 
5626:         *======================================================
5627:         *-- LABEL + TEXTBOX: getPesoBris - Peso Brilhante
5628:         *======================================================
5629:         loc_oPg.AddObject("lbl_4c_PesoBri", "Label")
5630:         WITH loc_oPg.lbl_4c_PesoBri
5631:             .Top      = 231
5632:             .Left     = 58
5633:             .Width    = 77
5634:             .Height   = 15
5635:             .Caption  = "Peso Brilhante :"
5636:             .AutoSize = .F.
5637:             .FontName = "Tahoma"
5638:             .FontSize = 8
5639:             .Visible  = .T.
5640:         ENDWITH
5641: 
5642:         loc_oPg.AddObject("txt_4c_Pesobris", "TextBox")
5643:         WITH loc_oPg.txt_4c_Pesobris
5644:             .Top           = 227
5645:             .Left          = 137
5646:             .Width         = 80
5647:             .Height        = 23
5648:             .InputMask     = "99,999.999"
5649:             .ReadOnly      = .T.
5650:             .SpecialEffect = 1

*-- Linhas 5656 a 5680:
5656:         *======================================================
5657:         *-- LABEL + TEXTBOX: getPesoMetal - Peso Metal
5658:         *======================================================
5659:         loc_oPg.AddObject("lbl_4c_PesoMet", "Label")
5660:         WITH loc_oPg.lbl_4c_PesoMet
5661:             .Top      = 256
5662:             .Left     = 74
5663:             .Width    = 61
5664:             .Height   = 15
5665:             .Caption  = "Peso Metal :"
5666:             .AutoSize = .F.
5667:             .FontName = "Tahoma"
5668:             .FontSize = 8
5669:             .Visible  = .T.
5670:         ENDWITH
5671: 
5672:         loc_oPg.AddObject("txt_4c_Pesometal", "TextBox")
5673:         WITH loc_oPg.txt_4c_Pesometal
5674:             .Top           = 252
5675:             .Left          = 137
5676:             .Width         = 80
5677:             .Height        = 23
5678:             .InputMask     = "99,999.999"
5679:             .ReadOnly      = .T.
5680:             .SpecialEffect = 1

*-- Linhas 5686 a 5837:
5686:         *======================================================
5687:         *-- LABEL + TEXTBOX: getPesoPdrs - Peso Pedra
5688:         *======================================================
5689:         loc_oPg.AddObject("lbl_4c_PesoPed", "Label")
5690:         WITH loc_oPg.lbl_4c_PesoPed
5691:             .Top      = 281
5692:             .Left     = 72
5693:             .Width    = 63
5694:             .Height   = 15
5695:             .Caption  = "Peso Pedra :"
5696:             .AutoSize = .F.
5697:             .FontName = "Tahoma"
5698:             .FontSize = 8
5699:             .Visible  = .T.
5700:         ENDWITH
5701: 
5702:         loc_oPg.AddObject("txt_4c_Pesopdrs", "TextBox")
5703:         WITH loc_oPg.txt_4c_Pesopdrs
5704:             .Top           = 277
5705:             .Left          = 137
5706:             .Width         = 80
5707:             .Height        = 23
5708:             .InputMask     = "99,999.999"
5709:             .ReadOnly      = .T.
5710:             .SpecialEffect = 1
5711:             .FontName      = "Tahoma"
5712:             .FontSize      = 8
5713:             .Visible       = .T.
5714:         ENDWITH
5715: 
5716:         *======================================================
5717:         *-- LABEL + TEXTBOX: getCor - Cor Padrao + checkbox CravCera
5718:         *======================================================
5719:         loc_oPg.AddObject("lbl_4c_CorPad", "Label")
5720:         WITH loc_oPg.lbl_4c_CorPad
5721:             .Top      = 306
5722:             .Left     = 72
5723:             .Width    = 63
5724:             .Height   = 15
5725:             .Caption  = "Cor Padr" + CHR(227) + "o :"
5726:             .AutoSize = .F.
5727:             .FontName = "Tahoma"
5728:             .FontSize = 8
5729:             .Visible  = .T.
5730:         ENDWITH
5731: 
5732:         loc_oPg.AddObject("txt_4c_CodcorsFas", "TextBox")
5733:         WITH loc_oPg.txt_4c_CodcorsFas
5734:             .Top           = 302
5735:             .Left          = 137
5736:             .Width         = 38
5737:             .Height        = 23
5738:             .ReadOnly      = .T.
5739:             .SpecialEffect = 1
5740:             .FontName      = "Tahoma"
5741:             .FontSize      = 8
5742:             .Visible       = .T.
5743:         ENDWITH
5744: 
5745:         loc_oPg.AddObject("chk_4c_CravCera", "CheckBox")
5746:         WITH loc_oPg.chk_4c_CravCera
5747:             .Top       = 306
5748:             .Left      = 180
5749:             .AutoSize  = .T.
5750:             .Caption   = "Crava" + CHR(231) + CHR(227) + "o em Cera"
5751:             .FontName  = "Tahoma"
5752:             .FontSize  = 8
5753:             .Alignment = 0
5754:             .Themes    = .F.
5755:             .Visible   = .T.
5756:         ENDWITH
5757: 
5758:         *======================================================
5759:         *-- LABEL + TEXTBOX: getTam - Tamanho Padrao + checkbox PesoVariavel
5760:         *======================================================
5761:         loc_oPg.AddObject("lbl_4c_TamPad", "Label")
5762:         WITH loc_oPg.lbl_4c_TamPad
5763:             .Top      = 331
5764:             .Left     = 45
5765:             .Width    = 90
5766:             .Height   = 15
5767:             .Caption  = "Tamanho Padr" + CHR(227) + "o :"
5768:             .AutoSize = .F.
5769:             .FontName = "Tahoma"
5770:             .FontSize = 8
5771:             .Visible  = .T.
5772:         ENDWITH
5773: 
5774:         loc_oPg.AddObject("txt_4c_CodtamsFas", "TextBox")
5775:         WITH loc_oPg.txt_4c_CodtamsFas
5776:             .Top           = 327
5777:             .Left          = 137
5778:             .Width         = 38
5779:             .Height        = 23
5780:             .ReadOnly      = .T.
5781:             .SpecialEffect = 1
5782:             .FontName      = "Tahoma"
5783:             .FontSize      = 8
5784:             .Visible       = .T.
5785:         ENDWITH
5786: 
5787:         loc_oPg.AddObject("chk_4c_PesoVari", "CheckBox")
5788:         WITH loc_oPg.chk_4c_PesoVari
5789:             .Top       = 331
5790:             .Left      = 180
5791:             .AutoSize  = .T.
5792:             .Caption   = "Peso Vari" + CHR(225) + "vel"
5793:             .FontName  = "Tahoma"
5794:             .FontSize  = 8
5795:             .Alignment = 0
5796:             .Themes    = .F.
5797:             .Visible   = .T.
5798:         ENDWITH
5799: 
5800:         *======================================================
5801:         *-- LABEL + TEXTBOXES: get_codacb / get_Dacb - Acabamento
5802:         *======================================================
5803:         loc_oPg.AddObject("lbl_4c_Acabam", "Label")
5804:         WITH loc_oPg.lbl_4c_Acabam
5805:             .Top      = 356
5806:             .Left     = 16
5807:             .Width    = 119
5808:             .Height   = 15
5809:             .Caption  = "Acabamento :"
5810:             .AutoSize = .F.
5811:             .FontName = "Tahoma"
5812:             .FontSize = 8
5813:             .Visible  = .T.
5814:         ENDWITH
5815: 
5816:         loc_oPg.AddObject("txt_4c_CodacbsFas", "TextBox")
5817:         WITH loc_oPg.txt_4c_CodacbsFas
5818:             .Top           = 352
5819:             .Left          = 137
5820:             .Width         = 38
5821:             .Height        = 23
5822:             .ReadOnly      = .T.
5823:             .SpecialEffect = 1
5824:             .FontName      = "Tahoma"
5825:             .FontSize      = 8
5826:             .Visible       = .T.
5827:         ENDWITH
5828: 
5829:         loc_oPg.AddObject("txt_4c_DacbsFas", "TextBox")
5830:         WITH loc_oPg.txt_4c_DacbsFas
5831:             .Top           = 352
5832:             .Left          = 177
5833:             .Width         = 207
5834:             .Height        = 23
5835:             .ReadOnly      = .T.
5836:             .SpecialEffect = 1
5837:             .FontName      = "Tahoma"

*-- Linhas 5846 a 5855:
5846:         *======================================================
5847:         loc_oPg.AddObject("grd_4c_Fases", "Grid")
5848:         WITH loc_oPg.grd_4c_Fases
5849:             .Top            = 152
5850:             .Left           = 527
5851:             .Width          = 420
5852:             .Height         = 312
5853:             .ReadOnly       = .F.
5854:             .DeleteMark     = .F.
5855:             .RecordMark     = .F.

*-- Linhas 5862 a 5895:
5862:         loc_oPg.grd_4c_Fases.ColumnCount = 5
5863:         loc_oPg.grd_4c_Fases.RecordSource = "cursor_4c_Fases"
5864:         WITH loc_oPg.grd_4c_Fases
5865:             .Column1.Header1.Caption  = "Ordem"
5866:             .Column1.Width            = 40
5867:             .Column1.ControlSource    = "cursor_4c_Fases.ordems"
5868:             .Column2.Header1.Caption  = "Fase"
5869:             .Column2.Width            = 80
5870:             .Column2.ControlSource    = "cursor_4c_Fases.grupos"
5871:             .Column3.Header1.Caption  = "Utiliza" + CHR(231) + CHR(227) + "o"
5872:             .Column3.Width            = 70
5873:             .Column3.ControlSource    = "cursor_4c_Fases.minutos"
5874:             .Column4.Header1.Caption  = "Uni. Produtiva"
5875:             .Column4.Width            = 90
5876:             .Column4.ControlSource    = "cursor_4c_Fases.uniprdts"
5877:             .Column5.Header1.Caption  = "Material"
5878:             .Column5.Width            = 120
5879:             .Column5.ControlSource    = "cursor_4c_Fases.matprdts"
5880:         ENDWITH
5881: 
5882:         *======================================================
5883:         *-- GRID: grd_4c_Matrizes - 3 colunas - SigPrMtz
5884:         *-- top=380, left=7, width=246, height=240
5885:         *-- Matriz | Local | Qtde
5886:         *======================================================
5887:         loc_oPg.AddObject("grd_4c_Matrizes", "Grid")
5888:         WITH loc_oPg.grd_4c_Matrizes
5889:             .Top            = 380
5890:             .Left           = 7
5891:             .Width          = 246
5892:             .Height         = 240
5893:             .ReadOnly       = .F.
5894:             .DeleteMark     = .F.
5895:             .RecordMark     = .F.

*-- Linhas 5902 a 5940:
5902:         loc_oPg.grd_4c_Matrizes.ColumnCount = 3
5903:         loc_oPg.grd_4c_Matrizes.RecordSource = "cursor_4c_Matrizes"
5904:         WITH loc_oPg.grd_4c_Matrizes
5905:             .Column1.Header1.Caption  = "Matriz"
5906:             .Column1.Width            = 100
5907:             .Column1.ControlSource    = "cursor_4c_Matrizes.cmats"
5908:             .Column2.Header1.Caption  = "Local"
5909:             .Column2.Width            = 80
5910:             .Column2.ControlSource    = "cursor_4c_Matrizes.locals"
5911:             .Column3.Header1.Caption  = "Qtde"
5912:             .Column3.Width            = 60
5913:             .Column3.ControlSource    = "cursor_4c_Matrizes.qtds"
5914:         ENDWITH
5915: 
5916:         *======================================================
5917:         *-- LABEL + TEXTBOX: Get_Desc - Descricao da fase selecionada
5918:         *======================================================
5919:         loc_oPg.AddObject("lbl_4c_DescFase", "Label")
5920:         WITH loc_oPg.lbl_4c_DescFase
5921:             .Top      = 474
5922:             .Left     = 527
5923:             .Width    = 67
5924:             .Height   = 17
5925:             .Caption  = "Descri" + CHR(231) + CHR(227) + "o :"
5926:             .AutoSize = .F.
5927:             .FontName = "Tahoma"
5928:             .FontSize = 8
5929:             .Visible  = .T.
5930:         ENDWITH
5931: 
5932:         loc_oPg.AddObject("txt_4c_DescFase", "TextBox")
5933:         WITH loc_oPg.txt_4c_DescFase
5934:             .Top           = 471
5935:             .Left          = 595
5936:             .Width         = 395
5937:             .Height        = 23
5938:             .ReadOnly      = .T.
5939:             .SpecialEffect = 1
5940:             .FontName      = "Tahoma"

*-- Linhas 5947 a 5956:
5947:         *======================================================
5948:         loc_oPg.AddObject("edt_4c_ObsFase", "EditBox")
5949:         WITH loc_oPg.edt_4c_ObsFase
5950:             .Top           = 497
5951:             .Left          = 527
5952:             .Width         = 463
5953:             .Height        = 122
5954:             .ReadOnly      = .T.
5955:             .SpecialEffect = 1
5956:             .FontName      = "Tahoma"

*-- Linhas 5965 a 5974:
5965:         *======================================================
5966:         loc_oPg.AddObject("shp_4c_ShpFig", "Shape")
5967:         WITH loc_oPg.shp_4c_ShpFig
5968:             .Top         = 152
5969:             .Left        = 231
5970:             .Width       = 244
5971:             .Height      = 148
5972:             .BorderColor = RGB(150, 150, 150)
5973:             .BorderWidth = 1
5974:             .FillStyle   = 1

*-- Linhas 5982 a 6176:
5982:         *======================================================
5983:         loc_oPg.AddObject("img_4c_ImgFigJpg", "Image")
5984:         WITH loc_oPg.img_4c_ImgFigJpg
5985:             .Top     = 153
5986:             .Left    = 232
5987:             .Width   = 241
5988:             .Height  = 146
5989:             .Stretch = 2
5990:             .Visible = .F.
5991:         ENDWITH
5992:         BINDEVENT(loc_oPg.img_4c_ImgFigJpg, "Click", THIS, "ImgFigJpgClick")
5993: 
5994:         *======================================================
5995:         *-- BUTTON: cmd_4c_CmdFicha - Imprimir ficha da fase
5996:         *-- top=152, left=482
5997:         *======================================================
5998:         loc_oPg.AddObject("cmd_4c_CmdFicha", "CommandButton")
5999:         WITH loc_oPg.cmd_4c_CmdFicha
6000:             .Caption       = "Ficha"
6001:             .Top           = 152
6002:             .Left          = 482
6003:             .Width         = 38
6004:             .Height        = 23
6005:             .FontName      = "Tahoma"
6006:             .FontSize      = 8
6007:             .Themes        = .F.
6008:             .SpecialEffect = 0
6009:             .BackColor     = RGB(255, 255, 255)
6010:             .ForeColor     = RGB(90, 90, 90)
6011:             .Visible       = .T.
6012:         ENDWITH
6013:         BINDEVENT(loc_oPg.cmd_4c_CmdFicha, "Click", THIS, "CmdFichaClick")
6014: 
6015:         *======================================================
6016:         *-- BUTTON: cmd_4c_CmdgFigura - Carregar imagem da fase (cmdgFigura)
6017:         *-- top=192, left=482
6018:         *======================================================
6019:         loc_oPg.AddObject("cmd_4c_CmdgFigura", "CommandButton")
6020:         WITH loc_oPg.cmd_4c_CmdgFigura
6021:             .Caption       = "..."
6022:             .Top           = 192
6023:             .Left          = 482
6024:             .Width         = 38
6025:             .Height        = 23
6026:             .FontName      = "Tahoma"
6027:             .FontSize      = 8
6028:             .Themes        = .F.
6029:             .SpecialEffect = 0
6030:             .BackColor     = RGB(255, 255, 255)
6031:             .ForeColor     = RGB(90, 90, 90)
6032:             .Visible       = .T.
6033:         ENDWITH
6034:         BINDEVENT(loc_oPg.cmd_4c_CmdgFigura, "Click", THIS, "CmdgFiguraClick")
6035: 
6036:         *======================================================
6037:         *-- BUTTON: cmd_4c_CmdgFigCam - Camera para imagem de borracha (cmdgFigCam)
6038:         *-- top=232, left=482
6039:         *======================================================
6040:         loc_oPg.AddObject("cmd_4c_CmdgFigCam", "CommandButton")
6041:         WITH loc_oPg.cmd_4c_CmdgFigCam
6042:             .Caption       = "..."
6043:             .Top           = 232
6044:             .Left          = 482
6045:             .Width         = 38
6046:             .Height        = 23
6047:             .FontName      = "Tahoma"
6048:             .FontSize      = 8
6049:             .Themes        = .F.
6050:             .SpecialEffect = 0
6051:             .BackColor     = RGB(255, 255, 255)
6052:             .ForeColor     = RGB(90, 90, 90)
6053:             .Visible       = .T.
6054:         ENDWITH
6055:         BINDEVENT(loc_oPg.cmd_4c_CmdgFigCam, "Click", THIS, "CmdgFigCamClick")
6056: 
6057:         *======================================================
6058:         *-- BUTTON: cmd_4c_InserirFase - Inserir nova fase (inserir)
6059:         *-- top=152, left=950
6060:         *======================================================
6061:         loc_oPg.AddObject("cmd_4c_InserirFase", "CommandButton")
6062:         WITH loc_oPg.cmd_4c_InserirFase
6063:             .Caption       = "Inserir"
6064:             .Top           = 152
6065:             .Left          = 950
6066:             .Width         = 45
6067:             .Height        = 23
6068:             .FontName      = "Tahoma"
6069:             .FontSize      = 8
6070:             .Themes        = .F.
6071:             .SpecialEffect = 0
6072:             .BackColor     = RGB(255, 255, 255)
6073:             .ForeColor     = RGB(90, 90, 90)
6074:             .Visible       = .T.
6075:         ENDWITH
6076:         BINDEVENT(loc_oPg.cmd_4c_InserirFase, "Click", THIS, "BtnInserirFaseClick")
6077: 
6078:         *======================================================
6079:         *-- BUTTON: cmd_4c_ExcluirFase - Excluir fase (excluir)
6080:         *-- top=192, left=950
6081:         *======================================================
6082:         loc_oPg.AddObject("cmd_4c_ExcluirFase", "CommandButton")
6083:         WITH loc_oPg.cmd_4c_ExcluirFase
6084:             .Caption       = "Excluir"
6085:             .Top           = 192
6086:             .Left          = 950
6087:             .Width         = 45
6088:             .Height        = 23
6089:             .FontName      = "Tahoma"
6090:             .FontSize      = 8
6091:             .Themes        = .F.
6092:             .SpecialEffect = 0
6093:             .BackColor     = RGB(255, 255, 255)
6094:             .ForeColor     = RGB(90, 90, 90)
6095:             .Visible       = .T.
6096:         ENDWITH
6097:         BINDEVENT(loc_oPg.cmd_4c_ExcluirFase, "Click", THIS, "BtnExcluirFaseClick")
6098: 
6099:         *======================================================
6100:         *-- BUTTON: cmd_4c_Alternativa - Alternativa de fase
6101:         *-- top=232, left=950
6102:         *======================================================
6103:         loc_oPg.AddObject("cmd_4c_Alternativa", "CommandButton")
6104:         WITH loc_oPg.cmd_4c_Alternativa
6105:             .Caption       = "Altern."
6106:             .Top           = 232
6107:             .Left          = 950
6108:             .Width         = 45
6109:             .Height        = 23
6110:             .FontName      = "Tahoma"
6111:             .FontSize      = 8
6112:             .Themes        = .F.
6113:             .SpecialEffect = 0
6114:             .BackColor     = RGB(255, 255, 255)
6115:             .ForeColor     = RGB(90, 90, 90)
6116:             .Visible       = .T.
6117:         ENDWITH
6118:         BINDEVENT(loc_oPg.cmd_4c_Alternativa, "Click", THIS, "BtnAlternativaFaseClick")
6119: 
6120:         *======================================================
6121:         *-- BUTTON: cmd_4c_BtnInsereMtx - Inserir linha na grade de matrizes
6122:         *-- top=380, left=258
6123:         *======================================================
6124:         loc_oPg.AddObject("cmd_4c_BtnInsereMtx", "CommandButton")
6125:         WITH loc_oPg.cmd_4c_BtnInsereMtx
6126:             .Caption       = "+"
6127:             .Top           = 380
6128:             .Left          = 258
6129:             .Width         = 23
6130:             .Height        = 23
6131:             .FontName      = "Tahoma"
6132:             .FontSize      = 10
6133:             .FontBold      = .T.
6134:             .Themes        = .F.
6135:             .SpecialEffect = 0
6136:             .BackColor     = RGB(255, 255, 255)
6137:             .ForeColor     = RGB(90, 90, 90)
6138:             .Visible       = .T.
6139:         ENDWITH
6140:         BINDEVENT(loc_oPg.cmd_4c_BtnInsereMtx, "Click", THIS, "BtnInserirMatrizClick")
6141: 
6142:         *======================================================
6143:         *-- BUTTON: cmd_4c_BtnExcluiMtz - Excluir linha da grade de matrizes
6144:         *-- top=420, left=258
6145:         *======================================================
6146:         loc_oPg.AddObject("cmd_4c_BtnExcluiMtz", "CommandButton")
6147:         WITH loc_oPg.cmd_4c_BtnExcluiMtz
6148:             .Caption       = "-"
6149:             .Top           = 420
6150:             .Left          = 258
6151:             .Width         = 23
6152:             .Height        = 23
6153:             .FontName      = "Tahoma"
6154:             .FontSize      = 10
6155:             .FontBold      = .T.
6156:             .Themes        = .F.
6157:             .SpecialEffect = 0
6158:             .BackColor     = RGB(255, 255, 255)
6159:             .ForeColor     = RGB(90, 90, 90)
6160:             .Visible       = .T.
6161:         ENDWITH
6162:         BINDEVENT(loc_oPg.cmd_4c_BtnExcluiMtz, "Click", THIS, "BtnExcluirMatrizClick")
6163: 
6164:         *======================================================
6165:         *-- SHAPE: shp_4c_ShpBorracha - Borda ao redor da imagem da borracha
6166:         *-- top=464, left=258, width=236, height=156
6167:         *======================================================
6168:         loc_oPg.AddObject("shp_4c_ShpBorracha", "Shape")
6169:         WITH loc_oPg.shp_4c_ShpBorracha
6170:             .Top         = 464
6171:             .Left        = 258
6172:             .Width       = 236
6173:             .Height      = 156
6174:             .BorderColor = RGB(150, 150, 150)
6175:             .BorderWidth = 1
6176:             .FillStyle   = 1

*-- Linhas 6184 a 6193:
6184:         *======================================================
6185:         loc_oPg.AddObject("img_4c_ImgBorracha", "Image")
6186:         WITH loc_oPg.img_4c_ImgBorracha
6187:             .Top     = 465
6188:             .Left    = 260
6189:             .Width   = 232
6190:             .Height  = 154
6191:             .Stretch = 2
6192:             .Visible = .F.
6193:         ENDWITH

*-- Linhas 6374 a 6395:
6374:                 loc_oGrid.Column7.Width = 40
6375: 
6376:                 *-- Cabecalhos (legado: Produto, Descricao, Grupo, Subgrp., Ref. Fornecedor, Usuario, I)
6377:                 loc_oGrid.Column1.Header1.Caption = "Produto"
6378:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
6379:                 loc_oGrid.Column3.Header1.Caption = "Grupo"
6380:                 loc_oGrid.Column4.Header1.Caption = "Subgrp."
6381:                 loc_oGrid.Column5.Header1.Caption = "Ref. Fornecedor"
6382:                 loc_oGrid.Column6.Header1.Caption = "Usu" + CHR(225) + "rio"
6383:                 loc_oGrid.Column7.Header1.Caption = "I"
6384: 
6385:                 THIS.FormatarGridLista(loc_oGrid)
6386: 
6387:                 *-- Atualizar contador de produtos
6388:                 LOCAL loc_nTotal
6389:                 loc_nTotal = IIF(USED("cursor_4c_Dados"), RECCOUNT("cursor_4c_Dados"), 0)
6390:                 THIS.pgf_4c_Paginas.Page1.lbl_4c_ContadorProdutos.Caption = LTRIM(STR(loc_nTotal)) + " produto(s)"
6391: 
6392:                 loc_lResultado = .T.
6393:             ENDIF
6394: 
6395:         CATCH TO loc_oErro

*-- Linhas 6554 a 6562:
6554:             loc_oBO.this_cCodident = ALLTRIM(loc_oPg.txt_4c_Codident.Value)
6555:         ENDIF
6556: 
6557:         *-- Garantia / CheckBox vitalicia
6558:         IF PEMSTATUS(loc_oPg, "txt_4c_Diasgar", 5)
6559:             loc_oBO.this_nDiasgar   = loc_oPg.txt_4c_Diasgar.Value
6560:         ENDIF
6561:         IF PEMSTATUS(loc_oPg, "chk_4c_Chkgarvit", 5)
6562:             loc_oBO.this_lChkgarvit = (loc_oPg.chk_4c_Chkgarvit.Value = 1)

*-- Linhas 6572 a 6580:
6572:             loc_oBO.this_lVarias = (loc_oPg.opt_4c_Varias.Value = 1)
6573:         ENDIF
6574: 
6575:         *-- CheckBoxes situacao produto
6576:         IF PEMSTATUS(loc_oPg, "chk_4c_Consigs", 5)
6577:             loc_oBO.this_lConsigs    = (loc_oPg.chk_4c_Consigs.Value = 1)
6578:         ENDIF
6579:         IF PEMSTATUS(loc_oPg, "chk_4c_Fabrproprs", 5)
6580:             loc_oBO.this_lFabrproprs = (loc_oPg.chk_4c_Fabrproprs.Value = 1)

*-- Linhas 6931 a 6939:
6931:             loc_oPg.txt_4c_Codident.Value = loc_oBO.this_cCodident
6932:         ENDIF
6933: 
6934:         *-- Garantia / CheckBox vitalicia
6935:         IF PEMSTATUS(loc_oPg, "txt_4c_Diasgar", 5)
6936:             loc_oPg.txt_4c_Diasgar.Value    = loc_oBO.this_nDiasgar
6937:         ENDIF
6938:         IF PEMSTATUS(loc_oPg, "chk_4c_Chkgarvit", 5)
6939:             loc_oPg.chk_4c_Chkgarvit.Value = loc_oBO.this_lChkgarvit

*-- Linhas 6949 a 6957:
6949:             loc_oPg.opt_4c_Varias.Value = IIF(loc_oBO.this_lVarias, 1, 2)
6950:         ENDIF
6951: 
6952:         *-- CheckBoxes situacao produto
6953:         IF PEMSTATUS(loc_oPg, "chk_4c_Consigs", 5)
6954:             loc_oPg.chk_4c_Consigs.Value    = loc_oBO.this_lConsigs
6955:         ENDIF
6956:         IF PEMSTATUS(loc_oPg, "chk_4c_Fabrproprs", 5)
6957:             loc_oPg.chk_4c_Fabrproprs.Value = loc_oBO.this_lFabrproprs

*-- Linhas 7410 a 7418:
7410:             loc_oPg.txt_4c_Codident.Value = ""
7411:         ENDIF
7412: 
7413:         *-- Garantia / Produto Web / Variacao / CheckBoxes
7414:         IF PEMSTATUS(loc_oPg, "txt_4c_Diasgar", 5)
7415:             loc_oPg.txt_4c_Diasgar.Value    = 0
7416:         ENDIF
7417:         IF PEMSTATUS(loc_oPg, "chk_4c_Chkgarvit", 5)
7418:             loc_oPg.chk_4c_Chkgarvit.Value = 0

*-- Linhas 7855 a 7863:
7855:             loc_oPg.txt_4c_Volumes.ReadOnly   = !par_lHabilitar
7856:         ENDIF
7857: 
7858:         *-- OptionGroups e CheckBoxes: Enabled
7859:         IF PEMSTATUS(loc_oPg, "opt_4c_Situas", 5)
7860:             loc_oPg.opt_4c_Situas.Enabled     = par_lHabilitar
7861:         ENDIF
7862:         IF PEMSTATUS(loc_oPg, "opt_4c_ProdWeb", 5)
7863:             loc_oPg.opt_4c_ProdWeb.Enabled    = par_lHabilitar

*-- Linhas 7927 a 7954:
7927:             loc_oPg7.chk_4c_PesoVari.Enabled    = par_lHabilitar
7928:         ENDIF
7929:         *-- Botoes de operacao: habilitados so em modo edicao
7930:         IF PEMSTATUS(loc_oPg7, "cmd_4c_InserirFase", 5)
7931:             loc_oPg7.cmd_4c_InserirFase.Enabled  = par_lHabilitar
7932:         ENDIF
7933:         IF PEMSTATUS(loc_oPg7, "cmd_4c_ExcluirFase", 5)
7934:             loc_oPg7.cmd_4c_ExcluirFase.Enabled  = par_lHabilitar
7935:         ENDIF
7936:         IF PEMSTATUS(loc_oPg7, "cmd_4c_Alternativa", 5)
7937:             loc_oPg7.cmd_4c_Alternativa.Enabled  = par_lHabilitar
7938:         ENDIF
7939:         IF PEMSTATUS(loc_oPg7, "cmd_4c_CmdgFigura", 5)
7940:             loc_oPg7.cmd_4c_CmdgFigura.Enabled   = par_lHabilitar
7941:         ENDIF
7942:         IF PEMSTATUS(loc_oPg7, "cmd_4c_CmdgFigCam", 5)
7943:             loc_oPg7.cmd_4c_CmdgFigCam.Enabled   = par_lHabilitar
7944:         ENDIF
7945:         IF PEMSTATUS(loc_oPg7, "cmd_4c_BtnInsereMtx", 5)
7946:             loc_oPg7.cmd_4c_BtnInsereMtx.Enabled = par_lHabilitar
7947:         ENDIF
7948:         IF PEMSTATUS(loc_oPg7, "cmd_4c_BtnExcluiMtz", 5)
7949:             loc_oPg7.cmd_4c_BtnExcluiMtz.Enabled = par_lHabilitar
7950:         ENDIF
7951:         *-- Grid Fases/Matrizes: somente editavel em modo edicao
7952:         IF PEMSTATUS(loc_oPg7, "grd_4c_Fases", 5)
7953:             loc_oPg7.grd_4c_Fases.ReadOnly    = !par_lHabilitar
7954:         ENDIF

*-- Linhas 10956 a 10968:
10956:         loc_lEmEdicao    = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
10957: 
10958:         TRY
10959:             IF PEMSTATUS(loc_oBotoesDados, "cmd_4c_Salvar", 5)
10960:                 loc_oBotoesDados.cmd_4c_Salvar.Enabled = loc_lEmEdicao
10961:             ENDIF
10962:             IF PEMSTATUS(loc_oBotoesDados, "cmd_4c_Cancelar", 5)
10963:                 loc_oBotoesDados.cmd_4c_Cancelar.Enabled = .T.
10964:             ENDIF
10965:         CATCH TO loc_oErro
10966:             MsgErro(loc_oErro.Message, "FormProduto.AjustarBotoesPorModo")
10967:         ENDTRY
10968:     ENDPROC

*-- Linhas 11009 a 11017:
11009:     ENDPROC
11010: 
11011:     *--------------------------------------------------------------------------
11012:     * ChkLiberaCustoClick - Checkbox liberar custo: habilita/desabilita campos
11013:     *--------------------------------------------------------------------------
11014:     PROCEDURE ChkLiberaCustoClick()
11015:         LOCAL loc_oPg, loc_lLibera
11016:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11017:         loc_lLibera = .F.

*-- Linhas 11038 a 11046:
11038:     ENDPROC
11039: 
11040:     *--------------------------------------------------------------------------
11041:     * ChkLiberaVendaClick - Checkbox liberar venda: habilita/desabilita campos
11042:     *--------------------------------------------------------------------------
11043:     PROCEDURE ChkLiberaVendaClick()
11044:         LOCAL loc_oPg, loc_lLibera
11045:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11046:         loc_lLibera = .F.

*-- Linhas 11073 a 11081:
11073:     ENDPROC
11074: 
11075:     *--------------------------------------------------------------------------
11076:     * ChkPvendaClick - Checkbox usar preco ideal: aplica preco ideal ao preco venda
11077:     *--------------------------------------------------------------------------
11078:     PROCEDURE ChkPvendaClick()
11079:         LOCAL loc_oPg, loc_nPvideal, loc_nEncarg
11080:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11081: 

*-- Linhas 11134 a 11142:
11134:             IF loc_nR <= 0 OR EOF("cursor_4c_MoecTmp")
11135:                 *-- Nao encontrou: abre lookup
11136:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11137:                 loc_oForm.Caption = "Moedas"
11138:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11139:                 loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
11140:                 loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11141:                 loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
11142:                 loc_oForm.Show()

*-- Linhas 11185 a 11193:
11185: 
11186:             IF loc_nR <= 0 OR EOF("cursor_4c_MoecusfTmp")
11187:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11188:                 loc_oForm.Caption = "Moedas"
11189:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11190:                 loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
11191:                 loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11192:                 loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
11193:                 loc_oForm.Show()

*-- Linhas 11236 a 11244:
11236: 
11237:             IF loc_nR <= 0 OR EOF("cursor_4c_MoedaTmp")
11238:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11239:                 loc_oForm.Caption = "Moedas"
11240:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11241:                 loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
11242:                 loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11243:                 loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
11244:                 loc_oForm.Show()

*-- Linhas 11287 a 11295:
11287: 
11288:             IF loc_nR <= 0 OR EOF("cursor_4c_MoepvTmp")
11289:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11290:                 loc_oForm.Caption = "Moedas"
11291:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11292:                 loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
11293:                 loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11294:                 loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
11295:                 loc_oForm.Show()

*-- Linhas 11338 a 11346:
11338: 
11339:             IF loc_nR <= 0 OR EOF("cursor_4c_MoevTmp")
11340:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11341:                 loc_oForm.Caption = "Moedas"
11342:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11343:                 loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
11344:                 loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11345:                 loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
11346:                 loc_oForm.Show()

*-- Linhas 11390 a 11398:
11390: 
11391:             IF loc_nR <= 0 OR EOF("cursor_4c_FtioTmp")
11392:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11393:                 loc_oForm.Caption = "Feitios"
11394:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11395:                 loc_oForm.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
11396:                 loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
11397:                 loc_oForm.mSQL = "SELECT Cods, Descs FROM SigPrFti WHERE Tipos<>1 ORDER BY Cods"
11398:                 loc_oForm.Show()

*-- Linhas 11448 a 11456:
11448: 
11449:             IF loc_nR <= 0 OR EOF("cursor_4c_CmkpcTmp")
11450:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11451:                 loc_oForm.Caption = "Feitios de Custo"
11452:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11453:                 loc_oForm.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
11454:                 loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
11455:                 loc_oForm.mSQL = "SELECT Cods, Descs FROM SigPrFti WHERE Tipos=1 ORDER BY Cods"
11456:                 loc_oForm.Show()

*-- Linhas 11541 a 11549:
11541: 
11542:             IF loc_nR <= 0 OR EOF("cursor_4c_DescTmp")
11543:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11544:                 loc_oForm.Caption = "Produtos"
11545:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11546:                 loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
11547:                 loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
11548:                 loc_oForm.mSQL = "SELECT CPros, DPros FROM SigCdPro ORDER BY DPros"
11549:                 loc_oForm.Show()

*-- Linhas 11599 a 11607:
11599: 
11600:             IF loc_nR <= 0 OR EOF("cursor_4c_MatPTmp")
11601:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11602:                 loc_oForm.Caption = "Material Principal"
11603:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11604:                 loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
11605:                 loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
11606:                 loc_oForm.mSQL = "SELECT CPros, DPros FROM SigCdPro ORDER BY CPros"
11607:                 loc_oForm.Show()

*-- Linhas 11657 a 11665:
11657: 
11658:             IF loc_nR <= 0 OR EOF("cursor_4c_DesccpTmp")
11659:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11660:                 loc_oForm.Caption = "Sub-Componentes"
11661:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11662:                 loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
11663:                 loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
11664:                 loc_oForm.mSQL = "SELECT CPros, DPros FROM SigCdPro ORDER BY DPros"
11665:                 loc_oForm.Show()

*-- Linhas 11715 a 11723:
11715: 
11716:             IF loc_nR <= 0 OR EOF("cursor_4c_MatsubTmp")
11717:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11718:                 loc_oForm.Caption = "Produto Substituto"
11719:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11720:                 loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
11721:                 loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
11722:                 loc_oForm.mSQL = "SELECT CPros, DPros FROM SigCdPro ORDER BY CPros"
11723:                 loc_oForm.Show()

