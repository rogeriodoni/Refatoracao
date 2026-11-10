# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (22)
- [GRID-WITH] Bloco WITH loc_nSal define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_nSal.RecordSource).
- [NAVEGACAO-PAGINA] Metodo 'BtnConfirmarClick' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).
- [NAVEGACAO-PAGINA] Metodo 'BtnCancelarClick' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).
- [LAYOUT-POSITION] Controle 'lbl_conta' (parent: SIGOPIND.Page.SALDO.SigCcrConsulta): Top original=66 vs migrado 'lbl_4c_Lbl_conta' Top=100 (diff=34px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_conta' (parent: SIGOPIND.Page.SALDO.SigCcrConsulta): Left original=23 vs migrado 'lbl_4c_Lbl_conta' Left=418 (diff=395px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGOPIND.Page.SALDO.SigCcrConsulta): Top original=3 vs migrado 'lbl_4c_Label1' Top=100 (diff=97px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGOPIND.Page.SALDO.SigCcrConsulta): Left original=1 vs migrado 'lbl_4c_Label1' Left=276 (diff=275px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGOPIND.Page.SALDO): Left original=21 vs migrado 'lbl_4c_Label1' Left=276 (diff=255px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGOPIND.Page.SALDO.SigCcrSaldos): Top original=4 vs migrado 'lbl_4c_Label1' Top=100 (diff=96px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGOPIND.Page.SALDO.SigCcrSaldos): Left original=1 vs migrado 'lbl_4c_Label1' Left=276 (diff=275px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Cmd_Visual' (parent: SIGOPIND.Page.HIST.SigCcrimpressao): Top original=3 vs migrado 'cmd_4c_Cmd_Visual' Top=160 (diff=157px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Cmd_Visual' (parent: SIGOPIND.Page.HIST.SigCcrimpressao): Left original=419 vs migrado 'cmd_4c_Cmd_Visual' Left=214 (diff=205px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Cmd_Imprimir' (parent: SIGOPIND.Page.HIST.SigCcrimpressao): Top original=3 vs migrado 'cmd_4c_Cmd_Imprimir' Top=160 (diff=157px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Cmd_Imprimir' (parent: SIGOPIND.Page.HIST.SigCcrimpressao): Left original=494 vs migrado 'cmd_4c_Cmd_Imprimir' Left=170 (diff=324px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Command1' (parent: SIGOPIND.Page.HIST.SigCcrimpressao): Top original=3 vs migrado 'cmd_4c_Command1' Top=160 (diff=157px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Command1' (parent: SIGOPIND.Page.HIST.SigCcrimpressao): Left original=569 vs migrado 'cmd_4c_Command1' Left=125 (diff=444px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_periodo' (parent: SIGOPIND.Page.HIST.SigCcrimpressao): Top original=109 vs migrado 'lbl_4c_Lbl_periodo' Top=55 (diff=54px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_lancamentos' (parent: SIGOPIND.Page.HIST): Top original=110+compensacao=138 vs migrado 'lbl_4c_Lbl_lancamentos' Top=100 (diff=38px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGOPIND.Page.HIST): Top original=110+compensacao=138 vs migrado 'lbl_4c_Label1' Top=100 (diff=38px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Procura' (parent: SIGOPIND.Page.HIST): Top original=103+compensacao=131 vs migrado 'cmd_4c_Procura' Top=93 (diff=38px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGOPIND.Page.HIST.SigCcrQuita��o): Top original=5 vs migrado 'lbl_4c_Label1' Top=100 (diff=95px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGOPIND.Page.HIST.SigCcrQuita��o): Left original=0 vs migrado 'lbl_4c_Label1' Left=276 (diff=276px, tolerancia=30px)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' numa tela cujo dump legado NAO declara essa fonte - trocar por 'Tahoma' SO nas linhas apontadas, nunca "todas as ocorrencias" (Erro178: o legado do SIGCDPRO declara Comic Sans MS nos 8 botoes de navegacao, e a troca em massa virou regressao de PILAR 1)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopind.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (6924 linhas total):

*-- Linhas 126 a 135:
126:             THIS.ConfigurarPageFrame()
127: 
128:             *-- Propagar Caption para labels de titulo/sombra
129:             THIS.pgf_4c_1.Page1.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
130:             THIS.pgf_4c_1.Page1.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
131: 
132:             *-- BINDEVENT: Form-level KeyPress (atalhos globais: F2-F11, CTRL+Enter)
133:             BINDEVENT(THIS, "KeyPress", THIS, "FormKeyPress")
134: 
135:             *-- BINDEVENT: Page Activate/Click (controla estado ao navegar entre abas)

*-- Linhas 172 a 181:
172:         loc_oPgf = THIS.pgf_4c_1
173: 
174:         WITH loc_oPgf
175:             .Top       = -28
176:             .Left      = 0
177:             .Width     = 1004
178:             .Height    = 635
179:             .PageCount = 2
180:             .Tabs      = .F.
181:         ENDWITH

*-- Linhas 197 a 246:
197: 
198:         loc_oPagina = THIS.pgf_4c_1.Page1
199:         WITH loc_oPagina
200:             .Caption   = "Saldo"
201:             .BackColor = RGB(212, 208, 200)
202:         ENDWITH
203: 
204:         *----------------------------------------------------------------------
205:         * Container cabecalho - efeito sombra + titulo
206:         * cntSombra: top=0, left=0, width=1000, height=80
207:         *----------------------------------------------------------------------
208:         loc_oPagina.AddObject("cnt_4c_Sombra", "Container")
209:         loc_oCnt = loc_oPagina.cnt_4c_Sombra
210:         WITH loc_oCnt
211:             .Top           = 0
212:             .Left          = 0
213:             .Width         = 1000
214:             .Height        = 80
215:             .BackColor     = RGB(100, 100, 100)
216:             .BorderWidth   = 0
217:             .SpecialEffect = 0
218:         ENDWITH
219: 
220:         loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
221:         WITH loc_oCnt.lbl_4c_LblSombra
222:             .Top       = 7
223:             .Left      = 10
224:             .Width     = 769
225:             .Height    = 40
226:             .Caption   = THIS.Caption
227:             .FontName  = "Tahoma"
228:             .FontSize  = 18
229:             .FontBold  = .T.
230:             .ForeColor = RGB(0, 0, 0)
231:             .BackStyle = 0
232:             .AutoSize  = .F.
233:         ENDWITH
234: 
235:         loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
236:         WITH loc_oCnt.lbl_4c_LblTitulo
237:             .Top       = 10
238:             .Left      = 10
239:             .Width     = 769
240:             .Height    = 46
241:             .Caption   = THIS.Caption
242:             .FontName  = "Tahoma"
243:             .FontSize  = 18
244:             .FontBold  = .T.
245:             .ForeColor = RGB(255, 255, 255)
246:             .BackStyle = 0

*-- Linhas 253 a 288:
253:         *----------------------------------------------------------------------
254:         loc_oPagina.AddObject("obj_4c_Grp_operacao", "CommandGroup")
255:         WITH loc_oPagina.obj_4c_Grp_operacao
256:             .Top           = -1
257:             .Left          = 669
258:             .Width         = 334
259:             .Height        = 83
260:             .ButtonCount   = 2
261:             .BorderStyle   = 0
262:             .SpecialEffect = 0
263:         ENDWITH
264:         WITH loc_oPagina.obj_4c_Grp_operacao.Buttons(1)
265:             .Caption   = "\<Consultar"
266:             .Width     = 75
267:             .Height    = 75
268:             .Left      = 178
269:             .Top       = 5
270:             .FontName  = "Comic Sans MS"
271:             .FontSize  = 8
272:             .FontBold  = .T.
273:             .FontItalic = .T.
274:             .ForeColor = RGB(90, 90, 90)
275:             .Picture   = gc_4c_CaminhoIcones + "geral_procura_60.jpg"
276:             .Themes    = .F.
277:         ENDWITH
278:         WITH loc_oPagina.obj_4c_Grp_operacao.Buttons(2)
279:             .Caption   = "\<Encerrar"
280:             .Width     = 75
281:             .Height    = 75
282:             .Left      = 253
283:             .Top       = 5
284:             .FontName  = "Comic Sans MS"
285:             .FontSize  = 8
286:             .FontBold  = .T.
287:             .FontItalic = .T.
288:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 296 a 437:
296:         * cmd_procurar - Botao Procurar Conta
297:         * top=4, left=697, width=75, height=75
298:         *----------------------------------------------------------------------
299:         loc_oPagina.AddObject("cmd_4c_Cmd_procurar", "CommandButton")
300:         WITH loc_oPagina.cmd_4c_Cmd_procurar
301:             .Top        = 4
302:             .Left       = 697
303:             .Width      = 75
304:             .Height     = 75
305:             .Caption    = "\<Procurar"
306:             .FontName   = "Comic Sans MS"
307:             .FontSize   = 8
308:             .FontBold   = .T.
309:             .FontItalic = .T.
310:             .ForeColor  = RGB(90, 90, 90)
311:             .BackColor  = RGB(255, 255, 255)
312:             .Themes     = .F.
313:             .Picture    = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
314:         ENDWITH
315:         BINDEVENT(loc_oPagina.cmd_4c_Cmd_procurar, "Click", THIS, "BtnProcurarSaldoClick")
316: 
317:         *----------------------------------------------------------------------
318:         * Com_Imprimir2 - Botao Imprimir Relatorio de Saldos
319:         * top=4, left=772, width=75, height=75
320:         *----------------------------------------------------------------------
321:         loc_oPagina.AddObject("cmd_4c_Com_Imprimir2", "CommandButton")
322:         WITH loc_oPagina.cmd_4c_Com_Imprimir2
323:             .Top        = 4
324:             .Left       = 772
325:             .Width      = 75
326:             .Height     = 75
327:             .Caption    = "\<Imprimir"
328:             .FontName   = "Comic Sans MS"
329:             .FontSize   = 8
330:             .FontBold   = .T.
331:             .FontItalic = .T.
332:             .ForeColor  = RGB(90, 90, 90)
333:             .BackColor  = RGB(255, 255, 255)
334:             .Themes     = .F.
335:             .Picture    = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
336:         ENDWITH
337:         BINDEVENT(loc_oPagina.cmd_4c_Com_Imprimir2, "Click", THIS, "BtnImprimirSaldoClick")
338: 
339:         *----------------------------------------------------------------------
340:         * Linha de filtro de periodo
341:         * Label1 "Periodo:": top=86, left=9, width=51, height=15
342:         * Dt_inicial: top=84, left=64, width=80, height=23
343:         * Say2 "ate": top=88, left=147
344:         * Dt_final: top=84, left=173, width=80, height=23
345:         * optFiltro: top=82, left=253, width=206, height=26, buttonCount=3
346:         *----------------------------------------------------------------------
347:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
348:         WITH loc_oPagina.lbl_4c_Label1
349:             .Top       = 86
350:             .Left      = 9
351:             .Width     = 51
352:             .Height    = 15
353:             .Caption   = "Per" + CHR(237) + "odo :"
354:             .FontName  = "Tahoma"
355:             .FontSize  = 8
356:             .ForeColor = RGB(0, 0, 0)
357:             .BackStyle = 0
358:         ENDWITH
359: 
360:         loc_oPagina.AddObject("txt_4c_Dt_inicial", "TextBox")
361:         WITH loc_oPagina.txt_4c_Dt_inicial
362:             .Top      = 84
363:             .Left     = 64
364:             .Width    = 80
365:             .Height   = 23
366:             .Value    = {}
367:             .Format   = "D"
368:             .FontName = "Tahoma"
369:             .FontSize = 8
370:         ENDWITH
371: 
372:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
373:         WITH loc_oPagina.lbl_4c_Label2
374:             .Top       = 88
375:             .Left      = 147
376:             .Width     = 22
377:             .Height    = 15
378:             .Caption   = "at" + CHR(233)
379:             .FontName  = "Tahoma"
380:             .FontSize  = 8
381:             .ForeColor = RGB(0, 0, 0)
382:             .BackStyle = 0
383:         ENDWITH
384: 
385:         loc_oPagina.AddObject("txt_4c_Dt_final", "TextBox")
386:         WITH loc_oPagina.txt_4c_Dt_final
387:             .Top      = 84
388:             .Left     = 173
389:             .Width    = 80
390:             .Height   = 23
391:             .Value    = {}
392:             .Format   = "D"
393:             .FontName = "Tahoma"
394:             .FontSize = 8
395:         ENDWITH
396: 
397:         *-- optFiltro: 3 botoes (Todos / Positivos / Negativos)
398:         loc_oPagina.AddObject("obj_4c_OptFiltro", "OptionGroup")
399:         loc_oOpt = loc_oPagina.obj_4c_OptFiltro
400:         WITH loc_oOpt
401:             .Top         = 82
402:             .Left        = 253
403:             .Width       = 206
404:             .Height      = 26
405:             .ButtonCount = 3
406:             .BorderStyle = 0
407:             .Value       = 1
408:         ENDWITH
409:         WITH loc_oOpt.Buttons(1)
410:             .Caption  = "Todos"
411:             .Width    = 68
412:             .Height   = 21
413:             .Left     = 0
414:             .Top      = 3
415:             .FontName = "Tahoma"
416:             .FontSize = 8
417:         ENDWITH
418:         WITH loc_oOpt.Buttons(2)
419:             .Caption  = "Positivos"
420:             .Width    = 68
421:             .Height   = 21
422:             .Left     = 69
423:             .Top      = 3
424:             .FontName = "Tahoma"
425:             .FontSize = 8
426:         ENDWITH
427:         WITH loc_oOpt.Buttons(3)
428:             .Caption  = "Negativos"
429:             .Width    = 68
430:             .Height   = 21
431:             .Left     = 138
432:             .Top      = 3
433:             .FontName = "Tahoma"
434:             .FontSize = 8
435:         ENDWITH
436:         BINDEVENT(loc_oOpt, "InteractiveChange", THIS, "OptFiltroSaldoChange")
437: 

*-- Linhas 445 a 482:
445:         * Get_Grupo: top=110, left=64, width=80, height=23
446:         * Get_DGrupo: top=110, left=146, width=318, height=23
447:         *----------------------------------------------------------------------
448:         loc_oPagina.AddObject("lbl_4c_Lbl_grupo", "Label")
449:         WITH loc_oPagina.lbl_4c_Lbl_grupo
450:             .Top       = 114
451:             .Left      = 18
452:             .Width     = 42
453:             .Height    = 15
454:             .Caption   = "Grupo :"
455:             .FontName  = "Tahoma"
456:             .FontSize  = 8
457:             .ForeColor = RGB(0, 0, 0)
458:             .BackStyle = 0
459:         ENDWITH
460: 
461:         loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
462:         WITH loc_oPagina.txt_4c_Grupo
463:             .Top       = 110
464:             .Left      = 64
465:             .Width     = 80
466:             .Height    = 23
467:             .Value     = ""
468:             .FontName  = "Tahoma"
469:             .FontSize  = 8
470:             .MaxLength = 10
471:         ENDWITH
472:         BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress", THIS, "TxtGrupoKeyPress")
473: 
474:         loc_oPagina.AddObject("txt_4c_DGrupo", "TextBox")
475:         WITH loc_oPagina.txt_4c_DGrupo
476:             .Top       = 110
477:             .Left      = 146
478:             .Width     = 318
479:             .Height    = 23
480:             .Value     = ""
481:             .FontName  = "Tahoma"
482:             .FontSize  = 8

*-- Linhas 499 a 508:
499:         loc_oPagina.AddObject("grd_4c_Saldos", "Grid")
500:         loc_oGrd = loc_oPagina.grd_4c_Saldos
501:         WITH loc_oGrd
502:             .Top           = 140
503:             .Left          = 10
504:             .Width         = 980
505:             .Height        = 453
506:             .ReadOnly      = .T.
507:             .FontName      = "Tahoma"
508:             .FontSize      = 8

*-- Linhas 527 a 535:
527:         loc_oGrd.Column1.Movable           = .F.
528:         loc_oGrd.Column1.Resizable         = .F.
529:         loc_oGrd.Column1.ReadOnly          = .T.
530:         loc_oGrd.Column1.Header1.Caption   = "Conta"
531:         loc_oGrd.Column1.Header1.FontName  = "Tahoma"
532:         loc_oGrd.Column1.Header1.FontSize  = 8
533:         loc_oGrd.Column1.Header1.FontBold  = .T.
534:         loc_oGrd.Column1.Header1.Alignment = 2
535:         loc_oGrd.Column1.Header1.ForeColor = RGB(90, 90, 90)

*-- Linhas 541 a 549:
541:         loc_oGrd.Column2.Movable           = .F.
542:         loc_oGrd.Column2.Resizable         = .F.
543:         loc_oGrd.Column2.ReadOnly          = .T.
544:         loc_oGrd.Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
545:         loc_oGrd.Column2.Header1.FontName  = "Tahoma"
546:         loc_oGrd.Column2.Header1.FontSize  = 8
547:         loc_oGrd.Column2.Header1.FontBold  = .T.
548:         loc_oGrd.Column2.Header1.Alignment = 2
549:         loc_oGrd.Column2.Header1.ForeColor = RGB(90, 90, 90)

*-- Linhas 556 a 564:
556:         loc_oGrd.Column3.Resizable         = .F.
557:         loc_oGrd.Column3.ReadOnly          = .T.
558:         loc_oGrd.Column3.Text1.Alignment   = 3
559:         loc_oGrd.Column3.Header1.Caption   = "Moeda"
560:         loc_oGrd.Column3.Header1.FontName  = "Tahoma"
561:         loc_oGrd.Column3.Header1.FontSize  = 8
562:         loc_oGrd.Column3.Header1.FontBold  = .T.
563:         loc_oGrd.Column3.Header1.Alignment = 2
564:         loc_oGrd.Column3.Header1.ForeColor = RGB(90, 90, 90)

*-- Linhas 571 a 591:
571:         loc_oGrd.Column4.Resizable         = .F.
572:         loc_oGrd.Column4.ReadOnly          = .T.
573:         loc_oGrd.Column4.Text1.InputMask   = "99,999,999,999.99"
574:         loc_oGrd.Column4.Header1.Caption   = "Saldo"
575:         loc_oGrd.Column4.Header1.FontName  = "Tahoma"
576:         loc_oGrd.Column4.Header1.FontSize  = 8
577:         loc_oGrd.Column4.Header1.FontBold  = .T.
578:         loc_oGrd.Column4.Header1.Alignment = 2
579:         loc_oGrd.Column4.Header1.ForeColor = RGB(90, 90, 90)
580:         loc_oGrd.Column4.Header1.BackColor = RGB(255, 255, 255)
581: 
582:         loc_oGrd.Column5.ControlSource     = "cursor_4c_Saldos.Emps"
583:         loc_oGrd.Column5.ColumnOrder       = 6
584:         loc_oGrd.Column5.Width             = 41
585:         loc_oGrd.Column5.ReadOnly          = .T.
586:         loc_oGrd.Column5.Header1.Caption   = "Emp"
587:         loc_oGrd.Column5.Header1.FontName  = "Tahoma"
588:         loc_oGrd.Column5.Header1.FontSize  = 8
589:         loc_oGrd.Column5.Header1.FontBold  = .T.
590:         loc_oGrd.Column5.Header1.Alignment = 2
591:         loc_oGrd.Column5.Header1.ForeColor = RGB(90, 90, 90)

*-- Linhas 597 a 605:
597:         loc_oGrd.Column6.Movable           = .F.
598:         loc_oGrd.Column6.Resizable         = .F.
599:         loc_oGrd.Column6.ReadOnly          = .T.
600:         loc_oGrd.Column6.Header1.Caption   = "CPF/CNPJ"
601:         loc_oGrd.Column6.Header1.FontName  = "Tahoma"
602:         loc_oGrd.Column6.Header1.FontSize  = 8
603:         loc_oGrd.Column6.Header1.FontBold  = .T.
604:         loc_oGrd.Column6.Header1.Alignment = 2
605:         loc_oGrd.Column6.Header1.ForeColor = RGB(90, 90, 90)

*-- Linhas 615 a 623:
615:         loc_oGrd.Column7.Alignment         = 2
616:         loc_oGrd.Column7.ReadOnly          = .T.
617:         loc_oGrd.Column7.Text1.Alignment   = 2
618:         loc_oGrd.Column7.Header1.Caption   = "M/F"
619:         loc_oGrd.Column7.Header1.FontName  = "Tahoma"
620:         loc_oGrd.Column7.Header1.FontSize  = 8
621:         loc_oGrd.Column7.Header1.FontBold  = .T.
622:         loc_oGrd.Column7.Header1.ForeColor = RGB(90, 90, 90)
623: 

*-- Linhas 666 a 961:
666:         par_oPagina.AddObject("cnt_4c_Saldo", "Container")
667:         loc_oCnt = par_oPagina.cnt_4c_Saldo
668:         WITH loc_oCnt
669:             .Top           = 231
670:             .Left          = 344
671:             .Width         = 312
672:             .Height        = 212
673:             .Visible       = .F.
674:             .BackColor     = RGB(212, 208, 200)
675:             .BorderWidth   = 1
676:             .SpecialEffect = 1
677:         ENDWITH
678: 
679:         *-- Label titulo
680:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
681:         WITH loc_oCnt.lbl_4c_Label1
682:             .Top       = 4
683:             .Left      = 1
684:             .Width     = 310
685:             .Height    = 17
686:             .Caption   = "Relat" + CHR(243) + "rio de Saldos de Conta Corrente"
687:             .FontName  = "Tahoma"
688:             .FontSize  = 8
689:             .FontBold  = .T.
690:             .ForeColor = RGB(0, 0, 128)
691:             .BackStyle = 0
692:         ENDWITH
693: 
694:         *-- Say1 "Moeda:"
695:         loc_oCnt.AddObject("lbl_4c_Label_moeda", "Label")
696:         WITH loc_oCnt.lbl_4c_Label_moeda
697:             .Top       = 28
698:             .Left      = 16
699:             .Width     = 41
700:             .Height    = 15
701:             .Caption   = "Moeda :"
702:             .FontName  = "Tahoma"
703:             .FontSize  = 8
704:             .ForeColor = RGB(0, 0, 0)
705:             .BackStyle = 0
706:         ENDWITH
707: 
708:         *-- get_cd_moeda: top=25, left=59, width=33, height=23
709:         loc_oCnt.AddObject("txt_4c__cd_moeda", "TextBox")
710:         WITH loc_oCnt.txt_4c__cd_moeda
711:             .Top       = 25
712:             .Left      = 59
713:             .Width     = 33
714:             .Height    = 23
715:             .Value     = ""
716:             .FontName  = "Tahoma"
717:             .FontSize  = 8
718:             .MaxLength = 3
719:         ENDWITH
720:         BINDEVENT(loc_oCnt.txt_4c__cd_moeda, "KeyPress", THIS, "TxtCdMoedaSaldoKeyPress")
721: 
722:         *-- get_ds_moeda: top=25, left=94, width=126, height=23
723:         loc_oCnt.AddObject("txt_4c__ds_moeda", "TextBox")
724:         WITH loc_oCnt.txt_4c__ds_moeda
725:             .Top      = 25
726:             .Left     = 94
727:             .Width    = 126
728:             .Height   = 23
729:             .Value    = ""
730:             .FontName = "Tahoma"
731:             .FontSize = 8
732:         ENDWITH
733:         BINDEVENT(loc_oCnt.txt_4c__ds_moeda, "KeyPress", THIS, "TxtDsMoedaSaldoKeyPress")
734: 
735:         *-- lbl_periodo "Data:": top=55, left=25, width=32
736:         loc_oCnt.AddObject("lbl_4c_Lbl_periodo", "Label")
737:         WITH loc_oCnt.lbl_4c_Lbl_periodo
738:             .Top       = 55
739:             .Left      = 25
740:             .Width     = 32
741:             .Height    = 15
742:             .Caption   = "Data :"
743:             .FontName  = "Tahoma"
744:             .FontSize  = 8
745:             .ForeColor = RGB(0, 0, 0)
746:             .BackStyle = 0
747:         ENDWITH
748: 
749:         *-- get_dtlimite: top=50, left=59, width=80, height=23
750:         loc_oCnt.AddObject("txt_4c__dtlimite", "TextBox")
751:         WITH loc_oCnt.txt_4c__dtlimite
752:             .Top      = 50
753:             .Left     = 59
754:             .Width    = 80
755:             .Height   = 23
756:             .Value    = {}
757:             .Format   = "D"
758:             .FontName = "Tahoma"
759:             .FontSize = 8
760:         ENDWITH
761: 
762:         *-- Say21 "Situacao:": top=54, left=168, width=50
763:         loc_oCnt.AddObject("lbl_4c_Label21", "Label")
764:         WITH loc_oCnt.lbl_4c_Label21
765:             .Top       = 54
766:             .Left      = 168
767:             .Width     = 50
768:             .Height    = 15
769:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
770:             .FontName  = "Tahoma"
771:             .FontSize  = 8
772:             .ForeColor = RGB(0, 0, 0)
773:             .BackStyle = 0
774:         ENDWITH
775: 
776:         *-- Get_Situa: top=50, left=224, width=31, height=23
777:         loc_oCnt.AddObject("txt_4c_Situa", "TextBox")
778:         WITH loc_oCnt.txt_4c_Situa
779:             .Top       = 50
780:             .Left      = 224
781:             .Width     = 31
782:             .Height    = 23
783:             .Value     = ""
784:             .FontName  = "Tahoma"
785:             .FontSize  = 8
786:             .MaxLength = 4
787:         ENDWITH
788:         BINDEVENT(loc_oCnt.txt_4c_Situa, "KeyPress", THIS, "TxtSituacaoKeyPress")
789: 
790:         *-- Say2 "Ordem:": top=84, left=16, width=41
791:         loc_oCnt.AddObject("lbl_4c_Label2", "Label")
792:         WITH loc_oCnt.lbl_4c_Label2
793:             .Top       = 84
794:             .Left      = 16
795:             .Width     = 41
796:             .Height    = 15
797:             .Caption   = "Ordem :"
798:             .FontName  = "Tahoma"
799:             .FontSize  = 8
800:             .ForeColor = RGB(0, 0, 0)
801:             .BackStyle = 0
802:         ENDWITH
803: 
804:         *-- optOrdem: top=79, left=54, width=199, height=27, buttonCount=3
805:         loc_oCnt.AddObject("obj_4c_OptOrdem", "OptionGroup")
806:         loc_oOpt = loc_oCnt.obj_4c_OptOrdem
807:         WITH loc_oOpt
808:             .Top         = 79
809:             .Left        = 54
810:             .Width       = 199
811:             .Height      = 27
812:             .ButtonCount = 3
813:             .BorderStyle = 0
814:             .Value       = 1
815:         ENDWITH
816:         WITH loc_oOpt.Buttons(1)
817:             .Caption  = "Conta"
818:             .Width    = 65
819:             .Height   = 21
820:             .Left     = 0
821:             .Top      = 3
822:             .FontName = "Tahoma"
823:             .FontSize = 8
824:         ENDWITH
825:         WITH loc_oOpt.Buttons(2)
826:             .Caption  = "Moeda"
827:             .Width    = 65
828:             .Height   = 21
829:             .Left     = 66
830:             .Top      = 3
831:             .FontName = "Tahoma"
832:             .FontSize = 8
833:         ENDWITH
834:         WITH loc_oOpt.Buttons(3)
835:             .Caption  = "Saldo"
836:             .Width    = 65
837:             .Height   = 21
838:             .Left     = 132
839:             .Top      = 3
840:             .FontName = "Tahoma"
841:             .FontSize = 8
842:         ENDWITH
843:         BINDEVENT(loc_oOpt, "InteractiveChange", THIS, "OptOrdemSaldoChange")
844: 
845:         *-- chkAscendente: top=105, left=199, width=84, height=17, value=1
846:         loc_oCnt.AddObject("chk_4c_ChkAscendente", "CheckBox")
847:         WITH loc_oCnt.chk_4c_ChkAscendente
848:             .Top       = 105
849:             .Left      = 199
850:             .Width     = 84
851:             .Height    = 17
852:             .Caption   = "Ascendente"
853:             .Value     = 1
854:             .FontName  = "Tahoma"
855:             .FontSize  = 8
856:             .BackStyle = 0
857:         ENDWITH
858: 
859:         *-- CheckSaldo "Imprime Saldo Zero": top=103, left=14, width=110, height=15, value=0
860:         loc_oCnt.AddObject("chk_4c_CheckSaldo", "CheckBox")
861:         WITH loc_oCnt.chk_4c_CheckSaldo
862:             .Top       = 103
863:             .Left      = 14
864:             .Width     = 110
865:             .Height    = 15
866:             .Caption   = "Imprime Saldo Zero"
867:             .Value     = 0
868:             .FontName  = "Tahoma"
869:             .FontSize  = 8
870:             .BackStyle = 0
871:         ENDWITH
872: 
873:         *-- lb_Aguarde (Visible=.F.): top=130, left=6, width=300, height=17
874:         loc_oCnt.AddObject("lbl_4c_Lb_Aguarde", "Label")
875:         WITH loc_oCnt.lbl_4c_Lb_Aguarde
876:             .Top       = 130
877:             .Left      = 6
878:             .Width     = 300
879:             .Height    = 17
880:             .Caption   = "Aguarde... Processando!"
881:             .FontName  = "Tahoma"
882:             .FontSize  = 8
883:             .FontBold  = .T.
884:             .ForeColor = RGB(255, 0, 0)
885:             .BackStyle = 0
886:             .Visible   = .F.
887:         ENDWITH
888: 
889:         *-- Command1 (Excel): top=160, left=125, width=45, height=45
890:         loc_oCnt.AddObject("cmd_4c_Command1", "CommandButton")
891:         WITH loc_oCnt.cmd_4c_Command1
892:             .Top      = 160
893:             .Left     = 125
894:             .Width    = 45
895:             .Height   = 45
896:             .Caption  = ""
897:             .FontName = "Verdana"
898:             .FontSize = 8
899:             .ForeColor = RGB(36, 84, 155)
900:             .BackColor = RGB(255, 255, 255)
901:             .Themes   = .F.
902:             .Picture  = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"
903:         ENDWITH
904:         BINDEVENT(loc_oCnt.cmd_4c_Command1, "Click", THIS, "BtnSaldoExcelClick")
905: 
906:         *-- Cmd_Imprimir: top=160, left=170, width=44, height=45
907:         loc_oCnt.AddObject("cmd_4c_Cmd_Imprimir", "CommandButton")
908:         WITH loc_oCnt.cmd_4c_Cmd_Imprimir
909:             .Top      = 160
910:             .Left     = 170
911:             .Width    = 44
912:             .Height   = 45
913:             .Caption  = ""
914:             .FontName = "Verdana"
915:             .FontSize = 8
916:             .ForeColor = RGB(36, 84, 155)
917:             .BackColor = RGB(255, 255, 255)
918:             .Themes   = .F.
919:             .Picture  = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
920:         ENDWITH
921:         BINDEVENT(loc_oCnt.cmd_4c_Cmd_Imprimir, "Click", THIS, "BtnSaldoImprimirClick")
922: 
923:         *-- Cmd_Visual: top=160, left=214, width=44, height=45
924:         loc_oCnt.AddObject("cmd_4c_Cmd_Visual", "CommandButton")
925:         WITH loc_oCnt.cmd_4c_Cmd_Visual
926:             .Top      = 160
927:             .Left     = 214
928:             .Width    = 44
929:             .Height   = 45
930:             .Caption  = ""
931:             .FontName = "Verdana"
932:             .FontSize = 8
933:             .ForeColor = RGB(36, 84, 155)
934:             .BackColor = RGB(255, 255, 255)
935:             .Themes   = .F.
936:             .Picture  = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
937:         ENDWITH
938:         BINDEVENT(loc_oCnt.cmd_4c_Cmd_Visual, "Click", THIS, "BtnSaldoVisualClick")
939: 
940:         *-- cmd_grupo (OK): top=155, left=255, width=50, height=50, buttonCount=1
941:         loc_oCnt.AddObject("obj_4c_Cmd_grupo", "CommandGroup")
942:         WITH loc_oCnt.obj_4c_Cmd_grupo
943:             .Top           = 155
944:             .Left          = 255
945:             .Width         = 50
946:             .Height        = 50
947:             .ButtonCount   = 1
948:             .BorderStyle   = 0
949:             .SpecialEffect = 0
950:         ENDWITH
951:         WITH loc_oCnt.obj_4c_Cmd_grupo.Buttons(1)
952:             .Caption   = "OK"
953:             .Width     = 50
954:             .Height    = 50
955:             .Left      = 0
956:             .Top       = 0
957:             .FontName  = "Tahoma"
958:             .FontSize  = 8
959:         ENDWITH
960:         BINDEVENT(loc_oCnt.obj_4c_Cmd_grupo, "Click", THIS, "BtnSaldoCntOKClick")
961:     ENDPROC

*-- Linhas 971 a 1084:
971:         par_oPagina.AddObject("cnt_4c_Consulta", "Container")
972:         loc_oCnt = par_oPagina.cnt_4c_Consulta
973:         WITH loc_oCnt
974:             .Top           = 263
975:             .Left          = 310
976:             .Width         = 379
977:             .Height        = 149
978:             .Visible       = .F.
979:             .BackColor     = RGB(212, 208, 200)
980:             .BorderWidth   = 1
981:             .SpecialEffect = 1
982:         ENDWITH
983: 
984:         *-- Label1 "Procura por Conta/Descricao": top=3, left=1, width=377, height=18
985:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
986:         WITH loc_oCnt.lbl_4c_Label1
987:             .Top       = 3
988:             .Left      = 1
989:             .Width     = 377
990:             .Height    = 18
991:             .Caption   = "Procura por Conta/Descri" + CHR(231) + CHR(227) + "o"
992:             .FontName  = "Tahoma"
993:             .FontSize  = 8
994:             .FontBold  = .T.
995:             .ForeColor = RGB(0, 0, 128)
996:             .BackStyle = 0
997:         ENDWITH
998: 
999:         *-- Say1 "Codigo:": top=42, left=35
1000:         loc_oCnt.AddObject("lbl_4c_Label_cod", "Label")
1001:         WITH loc_oCnt.lbl_4c_Label_cod
1002:             .Top       = 42
1003:             .Left      = 35
1004:             .Width     = 41
1005:             .Height    = 15
1006:             .Caption   = "C" + CHR(243) + "digo :"
1007:             .FontName  = "Tahoma"
1008:             .FontSize  = 8
1009:             .ForeColor = RGB(0, 0, 0)
1010:             .BackStyle = 0
1011:         ENDWITH
1012: 
1013:         *-- Get_Cd_Conta: top=37, left=80, width=82, height=23
1014:         loc_oCnt.AddObject("txt_4c_Cd_Conta", "TextBox")
1015:         WITH loc_oCnt.txt_4c_Cd_Conta
1016:             .Top       = 37
1017:             .Left      = 80
1018:             .Width     = 82
1019:             .Height    = 23
1020:             .Value     = ""
1021:             .FontName  = "Tahoma"
1022:             .FontSize  = 8
1023:             .MaxLength = 10
1024:         ENDWITH
1025:         BINDEVENT(loc_oCnt.txt_4c_Cd_Conta, "KeyPress", THIS, "TxtCdContaKeyPress")
1026: 
1027:         *-- lbl_conta "Descricao:": top=66, left=22
1028:         loc_oCnt.AddObject("lbl_4c_Lbl_conta", "Label")
1029:         WITH loc_oCnt.lbl_4c_Lbl_conta
1030:             .Top       = 66
1031:             .Left      = 22
1032:             .Width     = 55
1033:             .Height    = 15
1034:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
1035:             .FontName  = "Tahoma"
1036:             .FontSize  = 8
1037:             .ForeColor = RGB(0, 0, 0)
1038:             .BackStyle = 0
1039:         ENDWITH
1040: 
1041:         *-- get_ds_conta: top=62, left=80, width=290
1042:         loc_oCnt.AddObject("txt_4c__ds_conta", "TextBox")
1043:         WITH loc_oCnt.txt_4c__ds_conta
1044:             .Top      = 62
1045:             .Left     = 80
1046:             .Width    = 290
1047:             .Height   = 23
1048:             .Value    = ""
1049:             .FontName = "Tahoma"
1050:             .FontSize = 8
1051:         ENDWITH
1052:         BINDEVENT(loc_oCnt.txt_4c__ds_conta, "KeyPress", THIS, "TxtDsContaKeyPress")
1053: 
1054:         *-- cmd_grupo (OK/Cancelar): top=99, left=284, width=88, height=43, buttonCount=2
1055:         loc_oCnt.AddObject("obj_4c_Cmd_grupo", "CommandGroup")
1056:         WITH loc_oCnt.obj_4c_Cmd_grupo
1057:             .Top           = 99
1058:             .Left          = 284
1059:             .Width         = 88
1060:             .Height        = 43
1061:             .ButtonCount   = 2
1062:             .BorderStyle   = 0
1063:             .SpecialEffect = 0
1064:         ENDWITH
1065:         WITH loc_oCnt.obj_4c_Cmd_grupo.Buttons(1)
1066:             .Caption  = "OK"
1067:             .Width    = 44
1068:             .Height   = 43
1069:             .Left     = 0
1070:             .Top      = 0
1071:             .FontName = "Tahoma"
1072:             .FontSize = 8
1073:         ENDWITH
1074:         WITH loc_oCnt.obj_4c_Cmd_grupo.Buttons(2)
1075:             .Caption  = "Cancelar"
1076:             .Width    = 44
1077:             .Height   = 43
1078:             .Left     = 44
1079:             .Top      = 0
1080:             .FontName = "Tahoma"
1081:             .FontSize = 8
1082:         ENDWITH
1083:         BINDEVENT(loc_oCnt.obj_4c_Cmd_grupo, "Click", THIS, "BtnConsultaCntClick")
1084:     ENDPROC

*-- Linhas 1095 a 1128:
1095: 
1096:         loc_oPagina = THIS.pgf_4c_1.Page2
1097:         WITH loc_oPagina
1098:             .Caption   = "Hist" + CHR(243) + "rico"
1099:             .BackColor = RGB(212, 208, 200)
1100:         ENDWITH
1101: 
1102:         *----------------------------------------------------------------------
1103:         * Container cabecalho - fundo escuro (espelho do SALDO)
1104:         *----------------------------------------------------------------------
1105:         loc_oPagina.AddObject("cnt_4c_Sombra", "Container")
1106:         loc_oCnt = loc_oPagina.cnt_4c_Sombra
1107:         WITH loc_oCnt
1108:             .Top           = 0
1109:             .Left          = 0
1110:             .Width         = 1000
1111:             .Height        = 90
1112:             .BackColor     = RGB(100, 100, 100)
1113:             .BorderWidth   = 0
1114:             .SpecialEffect = 0
1115:         ENDWITH
1116: 
1117:         *----------------------------------------------------------------------
1118:         * Container1 - barra separadora visual: top=6, left=100, width=14, height=84
1119:         *----------------------------------------------------------------------
1120:         loc_oPagina.AddObject("cnt_4c_Container1", "Container")
1121:         WITH loc_oPagina.cnt_4c_Container1
1122:             .Top           = 6
1123:             .Left          = 100
1124:             .Width         = 14
1125:             .Height        = 84
1126:             .BackColor     = RGB(100, 100, 100)
1127:             .BorderWidth   = 0
1128:             .SpecialEffect = 0

*-- Linhas 1134 a 1268:
1134:         *----------------------------------------------------------------------
1135: 
1136:         *-- Cmd_Consulta "Visualizar": left=96
1137:         loc_oPagina.AddObject("cmd_4c_Cmd_Consulta", "CommandButton")
1138:         WITH loc_oPagina.cmd_4c_Cmd_Consulta
1139:             .Top        = 11
1140:             .Left       = 96
1141:             .Width      = 75
1142:             .Height     = 75
1143:             .Caption    = "\<Visualizar"
1144:             .FontName   = "Comic Sans MS"
1145:             .FontSize   = 8
1146:             .FontBold   = .T.
1147:             .FontItalic = .T.
1148:             .WordWrap   = .T.
1149:             .ForeColor  = RGB(90, 90, 90)
1150:             .BackColor  = RGB(255, 255, 255)
1151:             .Themes     = .F.
1152:             .Picture    = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
1153:         ENDWITH
1154:         BINDEVENT(loc_oPagina.cmd_4c_Cmd_Consulta, "Click", THIS, "BtnConsultaHistClick")
1155: 
1156:         *-- Cmd_Alterar "Alterar": left=171
1157:         loc_oPagina.AddObject("cmd_4c_Cmd_Alterar", "CommandButton")
1158:         WITH loc_oPagina.cmd_4c_Cmd_Alterar
1159:             .Top        = 11
1160:             .Left       = 171
1161:             .Width      = 75
1162:             .Height     = 75
1163:             .Caption    = "Alterar"
1164:             .FontName   = "Comic Sans MS"
1165:             .FontSize   = 8
1166:             .FontBold   = .T.
1167:             .FontItalic = .T.
1168:             .WordWrap   = .T.
1169:             .ForeColor  = RGB(90, 90, 90)
1170:             .BackColor  = RGB(255, 255, 255)
1171:             .Themes     = .F.
1172:             .Picture    = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
1173:         ENDWITH
1174:         BINDEVENT(loc_oPagina.cmd_4c_Cmd_Alterar, "Click", THIS, "BtnAlterarHistClick")
1175: 
1176:         *-- Cmd_Excluir "Excluir": left=246
1177:         loc_oPagina.AddObject("cmd_4c_Cmd_Excluir", "CommandButton")
1178:         WITH loc_oPagina.cmd_4c_Cmd_Excluir
1179:             .Top        = 11
1180:             .Left       = 246
1181:             .Width      = 75
1182:             .Height     = 75
1183:             .Caption    = "Excluir"
1184:             .FontName   = "Comic Sans MS"
1185:             .FontSize   = 8
1186:             .FontBold   = .T.
1187:             .FontItalic = .T.
1188:             .WordWrap   = .T.
1189:             .ForeColor  = RGB(90, 90, 90)
1190:             .BackColor  = RGB(255, 255, 255)
1191:             .Themes     = .F.
1192:             .Picture    = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
1193:         ENDWITH
1194:         BINDEVENT(loc_oPagina.cmd_4c_Cmd_Excluir, "Click", THIS, "BtnExcluirHistClick")
1195: 
1196:         *-- cmd_impressao "Imprimir": left=321
1197:         loc_oPagina.AddObject("cmd_4c_Cmd_impressao", "CommandButton")
1198:         WITH loc_oPagina.cmd_4c_Cmd_impressao
1199:             .Top        = 11
1200:             .Left       = 321
1201:             .Width      = 75
1202:             .Height     = 75
1203:             .Caption    = "Imprimir"
1204:             .FontName   = "Comic Sans MS"
1205:             .FontSize   = 8
1206:             .FontBold   = .T.
1207:             .FontItalic = .T.
1208:             .WordWrap   = .T.
1209:             .ForeColor  = RGB(90, 90, 90)
1210:             .BackColor  = RGB(255, 255, 255)
1211:             .Themes     = .F.
1212:             .Picture    = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
1213:         ENDWITH
1214:         BINDEVENT(loc_oPagina.cmd_4c_Cmd_impressao, "Click", THIS, "BtnImpressaoHistClick")
1215: 
1216:         *-- Anexa "Movimento": left=396
1217:         loc_oPagina.AddObject("cmd_4c_Anexa", "CommandButton")
1218:         WITH loc_oPagina.cmd_4c_Anexa
1219:             .Top        = 11
1220:             .Left       = 396
1221:             .Width      = 75
1222:             .Height     = 75
1223:             .Caption    = "Movimento"
1224:             .FontName   = "Comic Sans MS"
1225:             .FontSize   = 8
1226:             .FontBold   = .T.
1227:             .FontItalic = .T.
1228:             .WordWrap   = .T.
1229:             .ForeColor  = RGB(90, 90, 90)
1230:             .BackColor  = RGB(255, 255, 255)
1231:             .Themes     = .F.
1232:             .Picture    = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
1233:         ENDWITH
1234:         BINDEVENT(loc_oPagina.cmd_4c_Anexa, "Click", THIS, "BtnAnexaHistClick")
1235: 
1236:         *-- Chk_Quitacao "Receber" (commandbutton): left=471
1237:         loc_oPagina.AddObject("cmd_4c_Chk_Quitacao", "CommandButton")
1238:         WITH loc_oPagina.cmd_4c_Chk_Quitacao
1239:             .Top        = 11
1240:             .Left       = 471
1241:             .Width      = 75
1242:             .Height     = 75
1243:             .Caption    = "Receber"
1244:             .FontName   = "Comic Sans MS"
1245:             .FontSize   = 8
1246:             .FontBold   = .T.
1247:             .FontItalic = .T.
1248:             .WordWrap   = .T.
1249:             .ForeColor  = RGB(90, 90, 90)
1250:             .BackColor  = RGB(255, 255, 255)
1251:             .Themes     = .F.
1252:             .Picture    = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
1253:         ENDWITH
1254:         BINDEVENT(loc_oPagina.cmd_4c_Chk_Quitacao, "Click", THIS, "BtnQuitacaoHistClick")
1255: 
1256:         *-- Chk_Concilia "Conciliar" (checkbox): left=547
1257:         loc_oPagina.AddObject("chk_4c_Chk_Concilia", "CheckBox")
1258:         WITH loc_oPagina.chk_4c_Chk_Concilia
1259:             .Top        = 11
1260:             .Left       = 547
1261:             .Width      = 75
1262:             .Height     = 75
1263:             .Caption    = "Conciliar"
1264:             .Value      = 0
1265:             .FontName   = "Comic Sans MS"
1266:             .FontSize   = 8
1267:             .FontBold   = .T.
1268:             .FontItalic = .T.

*-- Linhas 1276 a 1291:
1276:         ENDWITH
1277:         BINDEVENT(loc_oPagina.chk_4c_Chk_Concilia, "InteractiveChange", THIS, "BtnConciliaHistClick")
1278: 
1279:         *-- Chk_Auditoria "Auditar" (checkbox): left=622
1280:         loc_oPagina.AddObject("chk_4c_Chk_Auditoria", "CheckBox")
1281:         WITH loc_oPagina.chk_4c_Chk_Auditoria
1282:             .Top        = 11
1283:             .Left       = 622
1284:             .Width      = 75
1285:             .Height     = 75
1286:             .Caption    = "Auditar"
1287:             .Value      = 0
1288:             .FontName   = "Comic Sans MS"
1289:             .FontSize   = 8
1290:             .FontBold   = .T.
1291:             .FontItalic = .T.

*-- Linhas 1300 a 1383:
1300:         BINDEVENT(loc_oPagina.chk_4c_Chk_Auditoria, "InteractiveChange", THIS, "BtnAuditoriaHistClick")
1301: 
1302:         *-- Chk_Follow "Follow-up Conciliacao" (commandbutton): left=697
1303:         loc_oPagina.AddObject("cmd_4c_Chk_Follow", "CommandButton")
1304:         WITH loc_oPagina.cmd_4c_Chk_Follow
1305:             .Top        = 11
1306:             .Left       = 697
1307:             .Width      = 75
1308:             .Height     = 75
1309:             .Caption    = "Follow-\<up Concilia" + CHR(231) + CHR(227) + "o"
1310:             .FontName   = "Comic Sans MS"
1311:             .FontSize   = 8
1312:             .FontBold   = .T.
1313:             .FontItalic = .T.
1314:             .WordWrap   = .T.
1315:             .ForeColor  = RGB(90, 90, 90)
1316:             .BackColor  = RGB(255, 255, 255)
1317:             .Themes     = .F.
1318:             .Picture    = gc_4c_CaminhoIcones + "geral_pasta_60.jpg"
1319:         ENDWITH
1320:         BINDEVENT(loc_oPagina.cmd_4c_Chk_Follow, "Click", THIS, "BtnFollowConciliaHistClick")
1321: 
1322:         *-- FollowUp "Follow-up Conta": left=772
1323:         loc_oPagina.AddObject("cmd_4c_FollowUp", "CommandButton")
1324:         WITH loc_oPagina.cmd_4c_FollowUp
1325:             .Top        = 11
1326:             .Left       = 772
1327:             .Width      = 75
1328:             .Height     = 75
1329:             .Caption    = "Follow-up Conta"
1330:             .FontName   = "Comic Sans MS"
1331:             .FontSize   = 8
1332:             .FontBold   = .T.
1333:             .FontItalic = .T.
1334:             .WordWrap   = .T.
1335:             .ForeColor  = RGB(90, 90, 90)
1336:             .BackColor  = RGB(255, 255, 255)
1337:             .Themes     = .F.
1338:             .Picture    = gc_4c_CaminhoIcones + "geral_contatos_60.jpg"
1339:         ENDWITH
1340:         BINDEVENT(loc_oPagina.cmd_4c_FollowUp, "Click", THIS, "BtnFollowUpHistClick")
1341: 
1342:         *-- FollowUpI "Follow-up Lancamento": left=847
1343:         loc_oPagina.AddObject("cmd_4c_FollowLancto", "CommandButton")
1344:         WITH loc_oPagina.cmd_4c_FollowLancto
1345:             .Top        = 11
1346:             .Left       = 847
1347:             .Width      = 75
1348:             .Height     = 75
1349:             .Caption    = "Follow-up Lan" + CHR(231) + "amento"
1350:             .FontName   = "Comic Sans MS"
1351:             .FontSize   = 8
1352:             .FontBold   = .T.
1353:             .FontItalic = .T.
1354:             .WordWrap   = .T.
1355:             .ForeColor  = RGB(90, 90, 90)
1356:             .BackColor  = RGB(255, 255, 255)
1357:             .Themes     = .F.
1358:             .Picture    = gc_4c_CaminhoIcones + "geral_datas_60.jpg"
1359:         ENDWITH
1360:         BINDEVENT(loc_oPagina.cmd_4c_FollowLancto, "Click", THIS, "BtnFollowUpIHistClick")
1361: 
1362:         *-- grp_operacao "Sair": top=6, left=917, width=85, height=85, buttonCount=1
1363:         loc_oPagina.AddObject("obj_4c_Grp_operacao", "CommandGroup")
1364:         WITH loc_oPagina.obj_4c_Grp_operacao
1365:             .Top           = 6
1366:             .Left          = 917
1367:             .Width         = 85
1368:             .Height        = 85
1369:             .ButtonCount   = 1
1370:             .BorderStyle   = 0
1371:             .SpecialEffect = 0
1372:         ENDWITH
1373:         WITH loc_oPagina.obj_4c_Grp_operacao.Buttons(1)
1374:             .Caption    = "Encerrar"
1375:             .Width      = 75
1376:             .Height     = 75
1377:             .Left       = 5
1378:             .Top        = 5
1379:             .FontName   = "Comic Sans MS"
1380:             .FontSize   = 8
1381:             .FontBold   = .T.
1382:             .FontItalic = .T.
1383:             .ForeColor  = RGB(90, 90, 90)

*-- Linhas 1393 a 1569:
1393:         *----------------------------------------------------------------------
1394: 
1395:         *-- lbl_lancamentos "Filtro": top=100, left=10, width=31, height=15
1396:         loc_oPagina.AddObject("lbl_4c_Lbl_lancamentos", "Label")
1397:         WITH loc_oPagina.lbl_4c_Lbl_lancamentos
1398:             .Top       = 100
1399:             .Left      = 10
1400:             .Width     = 31
1401:             .Height    = 15
1402:             .Caption   = "Filtro"
1403:             .FontName  = "Tahoma"
1404:             .FontSize  = 8
1405:             .ForeColor = RGB(0, 0, 0)
1406:             .BackStyle = 0
1407:         ENDWITH
1408: 
1409:         *-- Cmb_Concilia: top=114, left=10, width=256, height=24
1410:         loc_oPagina.AddObject("cmb_4c_Concilia", "ComboBox")
1411:         WITH loc_oPagina.cmb_4c_Concilia
1412:             .Top    = 114
1413:             .Left   = 10
1414:             .Width  = 256
1415:             .Height = 24
1416:             .FontName = "Tahoma"
1417:             .FontSize = 8
1418:             .Style  = 2
1419:         ENDWITH
1420:         BINDEVENT(loc_oPagina.cmb_4c_Concilia, "InteractiveChange", THIS, "CmbConciliaHistChange")
1421: 
1422:         *-- Label1 "Moeda": top=100, left=276, width=40, height=15
1423:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
1424:         WITH loc_oPagina.lbl_4c_Label1
1425:             .Top       = 100
1426:             .Left      = 276
1427:             .Width     = 40
1428:             .Height    = 15
1429:             .Caption   = "Moeda"
1430:             .FontName  = "Tahoma"
1431:             .FontSize  = 8
1432:             .ForeColor = RGB(0, 0, 0)
1433:             .BackStyle = 0
1434:         ENDWITH
1435: 
1436:         *-- Get_MOEDA: top=115, left=276, width=44
1437:         loc_oPagina.AddObject("txt_4c_Moeda", "TextBox")
1438:         WITH loc_oPagina.txt_4c_Moeda
1439:             .Top      = 115
1440:             .Left     = 276
1441:             .Width    = 44
1442:             .Height   = 23
1443:             .Value    = ""
1444:             .FontName = "Tahoma"
1445:             .FontSize = 8
1446:             .MaxLength = 3
1447:         ENDWITH
1448:         BINDEVENT(loc_oPagina.txt_4c_Moeda, "KeyPress", THIS, "TxtMoedaHistKeyPress")
1449: 
1450:         *-- lbl_grupo_conta "Grupo": top=100, left=329, width=36, height=15
1451:         loc_oPagina.AddObject("lbl_4c_LblHistGrupo", "Label")
1452:         WITH loc_oPagina.lbl_4c_LblHistGrupo
1453:             .Top       = 100
1454:             .Left      = 329
1455:             .Width     = 36
1456:             .Height    = 15
1457:             .Caption   = "Grupo"
1458:             .FontName  = "Tahoma"
1459:             .FontSize  = 8
1460:             .ForeColor = RGB(0, 0, 0)
1461:             .BackStyle = 0
1462:         ENDWITH
1463: 
1464:         *-- Get_GRUPO: top=115, left=329, width=80
1465:         loc_oPagina.AddObject("txt_4c_GrupoHist", "TextBox")
1466:         WITH loc_oPagina.txt_4c_GrupoHist
1467:             .Top      = 115
1468:             .Left     = 329
1469:             .Width    = 80
1470:             .Height   = 23
1471:             .Value    = ""
1472:             .FontName = "Tahoma"
1473:             .FontSize = 8
1474:             .MaxLength = 10
1475:         ENDWITH
1476:         BINDEVENT(loc_oPagina.txt_4c_GrupoHist, "KeyPress", THIS, "TxtGrupoHistKeyPress")
1477: 
1478:         *-- Label4 "Conta": top=100, left=418, width=35, height=15
1479:         loc_oPagina.AddObject("lbl_4c_Lbl_Conta", "Label")
1480:         WITH loc_oPagina.lbl_4c_Lbl_Conta
1481:             .Top       = 100
1482:             .Left      = 418
1483:             .Width     = 35
1484:             .Height    = 15
1485:             .Caption   = "Conta"
1486:             .FontName  = "Tahoma"
1487:             .FontSize  = 8
1488:             .ForeColor = RGB(0, 0, 0)
1489:             .BackStyle = 0
1490:         ENDWITH
1491: 
1492:         *-- Get_Hconta: top=115, left=418, width=80
1493:         loc_oPagina.AddObject("txt_4c_Hconta", "TextBox")
1494:         WITH loc_oPagina.txt_4c_Hconta
1495:             .Top      = 115
1496:             .Left     = 418
1497:             .Width    = 80
1498:             .Height   = 23
1499:             .Value    = ""
1500:             .FontName = "Tahoma"
1501:             .FontSize = 8
1502:             .MaxLength = 10
1503:         ENDWITH
1504:         BINDEVENT(loc_oPagina.txt_4c_Hconta, "KeyPress", THIS, "TxtHcontaHistKeyPress")
1505: 
1506:         *-- Get_Hdconta (descricao da conta, ReadOnly): top=115, left=500, width=349, height=23
1507:         loc_oPagina.AddObject("txt_4c_Hdconta", "TextBox")
1508:         WITH loc_oPagina.txt_4c_Hdconta
1509:             .Top      = 115
1510:             .Left     = 500
1511:             .Width    = 349
1512:             .Height   = 23
1513:             .Value    = ""
1514:             .FontName = "Tahoma"
1515:             .FontSize = 8
1516:             .ReadOnly = .T.
1517:         ENDWITH
1518: 
1519:         *-- Procura button: top=93, left=853, width=45, height=45
1520:         loc_oPagina.AddObject("cmd_4c_Procura", "CommandButton")
1521:         WITH loc_oPagina.cmd_4c_Procura
1522:             .Top     = 93
1523:             .Left    = 853
1524:             .Width   = 45
1525:             .Height  = 45
1526:             .Caption = "..."
1527:             .FontName = "Tahoma"
1528:             .FontSize = 8
1529:             .Picture = gc_4c_CaminhoIcones + "geral_procura_60.jpg"
1530:         ENDWITH
1531:         BINDEVENT(loc_oPagina.cmd_4c_Procura, "Click", THIS, "BtnProcuraHistClick")
1532: 
1533:         *----------------------------------------------------------------------
1534:         * Total das linhas MARCADAS na grade de lancamentos
1535:         * Legado: Say8 "Total Saldo :" (top=106, left=650, ForeColor 90,90,90)
1536:         * e GetTotal (top=103, left=724, width=124, height=21,
1537:         * InputMask 999,999,999.99, Alignment=3, SpecialEffect=1,
1538:         * When = .F. -> somente leitura).
1539:         * Tops/Lefts seguem o mesmo deslocamento dos vizinhos desta faixa
1540:         * (legado - 10 no Top, legado + 1 no Left).
1541:         *----------------------------------------------------------------------
1542: 
1543:         *-- Say8 "Total Saldo :"
1544:         loc_oPagina.AddObject("lbl_4c_TotalSaldo", "Label")
1545:         WITH loc_oPagina.lbl_4c_TotalSaldo
1546:             .Top       = 96
1547:             .Left      = 651
1548:             .Width     = 71
1549:             .Height    = 15
1550:             .Caption   = "Total Saldo :"
1551:             .FontName  = "Tahoma"
1552:             .FontSize  = 8
1553:             .FontBold  = .T.
1554:             .AutoSize  = .F.
1555:             .Alignment = 0
1556:             .ForeColor = RGB(90, 90, 90)
1557:             .BackStyle = 0
1558:         ENDWITH
1559: 
1560:         *-- GetTotal: total acumulado (somente leitura - legado When = .F.)
1561:         loc_oPagina.AddObject("txt_4c_Total", "TextBox")
1562:         WITH loc_oPagina.txt_4c_Total
1563:             .Top           = 93
1564:             .Left          = 725
1565:             .Width         = 124
1566:             .Height        = 21
1567:             .Value         = 0
1568:             .Alignment     = 3
1569:             .InputMask     = "999,999,999.99"

*-- Linhas 1581 a 1874:
1581:         *----------------------------------------------------------------------
1582: 
1583:         *-- Label5 "Baixado": top=89, left=926
1584:         loc_oPagina.AddObject("lbl_4c_Lbl5", "Label")
1585:         WITH loc_oPagina.lbl_4c_Lbl5
1586:             .Top       = 89
1587:             .Left      = 926
1588:             .Width     = 40
1589:             .Height    = 15
1590:             .Caption   = "Baixado"
1591:             .FontName  = "Tahoma"
1592:             .FontSize  = 8
1593:             .ForeColor = RGB(0, 0, 0)
1594:             .BackStyle = 0
1595:         ENDWITH
1596: 
1597:         *-- Label6 "Cancelado": top=102, left=926
1598:         loc_oPagina.AddObject("lbl_4c_Lbl6", "Label")
1599:         WITH loc_oPagina.lbl_4c_Lbl6
1600:             .Top       = 102
1601:             .Left      = 926
1602:             .Width     = 52
1603:             .Height    = 15
1604:             .Caption   = "Cancelado"
1605:             .FontName  = "Tahoma"
1606:             .FontSize  = 8
1607:             .ForeColor = RGB(0, 0, 0)
1608:             .BackStyle = 0
1609:         ENDWITH
1610: 
1611:         *-- Label7 "Conciliado": top=114, left=926
1612:         loc_oPagina.AddObject("lbl_4c_Lbl7", "Label")
1613:         WITH loc_oPagina.lbl_4c_Lbl7
1614:             .Top       = 114
1615:             .Left      = 926
1616:             .Width     = 50
1617:             .Height    = 15
1618:             .Caption   = "Conciliado"
1619:             .FontName  = "Tahoma"
1620:             .FontSize  = 8
1621:             .ForeColor = RGB(0, 0, 0)
1622:             .BackStyle = 0
1623:         ENDWITH
1624: 
1625:         *-- Label9 "Prorrogado": top=127, left=926
1626:         loc_oPagina.AddObject("lbl_4c_Lbl9", "Label")
1627:         WITH loc_oPagina.lbl_4c_Lbl9
1628:             .Top       = 127
1629:             .Left      = 926
1630:             .Width     = 56
1631:             .Height    = 15
1632:             .Caption   = "Prorrogado"
1633:             .FontName  = "Tahoma"
1634:             .FontSize  = 8
1635:             .ForeColor = RGB(0, 0, 0)
1636:             .BackStyle = 0
1637:         ENDWITH
1638: 
1639:         *-- Botoes container - marcadores de status coloridos: top=90, left=906, width=17, height=50
1640:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
1641:         loc_oCnt = loc_oPagina.cnt_4c_Botoes
1642:         WITH loc_oCnt
1643:             .Top           = 90
1644:             .Left          =  542
1645:             .Width         = 17
1646:             .Height        = 50
1647:             .BackColor     = RGB(212, 208, 200)
1648:             .BorderWidth   = 0
1649:             .SpecialEffect = 0
1650:         ENDWITH
1651: 
1652:         *-- Botao1 verde (Baixado): top=1
1653:         loc_oCnt.AddObject("txt_4c_Botao1", "TextBox")
1654:         WITH loc_oCnt.txt_4c_Botao1
1655:             .Top         = 1
1656:             .Left        = 0
1657:             .Width       = 17
1658:             .Height      = 12
1659:             .ReadOnly    = .T.
1660:             .BackColor   = RGB(0, 128, 0)
1661:             .BorderStyle = 0
1662:         ENDWITH
1663: 
1664:         *-- Botao2 vermelho (Cancelado): top=13
1665:         loc_oCnt.AddObject("txt_4c_Botao2", "TextBox")
1666:         WITH loc_oCnt.txt_4c_Botao2
1667:             .Top         = 13
1668:             .Left        = 0
1669:             .Width       = 17
1670:             .Height      = 12
1671:             .ReadOnly    = .T.
1672:             .BackColor   = RGB(255, 0, 0)
1673:             .BorderStyle = 0
1674:         ENDWITH
1675: 
1676:         *-- Botao3 azul (Conciliado): top=25
1677:         loc_oCnt.AddObject("txt_4c_Botao3", "TextBox")
1678:         WITH loc_oCnt.txt_4c_Botao3
1679:             .Top         = 25
1680:             .Left        = 0
1681:             .Width       = 17
1682:             .Height      = 12
1683:             .ReadOnly    = .T.
1684:             .BackColor   = RGB(0, 0, 255)
1685:             .BorderStyle = 0
1686:         ENDWITH
1687: 
1688:         *-- Text4 laranja (Prorrogado): top=37
1689:         loc_oCnt.AddObject("txt_4c_Text4", "TextBox")
1690:         WITH loc_oCnt.txt_4c_Text4
1691:             .Top         = 37
1692:             .Left        = 0
1693:             .Width       = 17
1694:             .Height      = 12
1695:             .ReadOnly    = .T.
1696:             .BackColor   = RGB(255, 128, 0)
1697:             .BorderStyle = 0
1698:         ENDWITH
1699: 
1700:         *----------------------------------------------------------------------
1701:         * Faixa inferior - informacoes do lancamento selecionado (top=538-580)
1702:         *----------------------------------------------------------------------
1703: 
1704:         *-- Label2 "Historico": top=538, left=8, width=52, height=15
1705:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
1706:         WITH loc_oPagina.lbl_4c_Label2
1707:             .Top       = 538
1708:             .Left      = 8
1709:             .Width     = 52
1710:             .Height    = 15
1711:             .Caption   = "Hist" + CHR(243) + "rico"
1712:             .FontName  = "Tahoma"
1713:             .FontSize  = 8
1714:             .ForeColor = RGB(0, 0, 0)
1715:             .BackStyle = 0
1716:         ENDWITH
1717: 
1718:         *-- Get_HIST: top=553, left=8, width=290, height=20
1719:         loc_oPagina.AddObject("txt_4c_HIST", "TextBox")
1720:         WITH loc_oPagina.txt_4c_HIST
1721:             .Top      = 553
1722:             .Left     = 8
1723:             .Width    = 290
1724:             .Height   = 20
1725:             .Value    = ""
1726:             .FontName = "Tahoma"
1727:             .FontSize = 8
1728:             .ReadOnly = .T.
1729:         ENDWITH
1730: 
1731:         *-- Get_Hist2: top=574, left=8, width=290, height=20
1732:         loc_oPagina.AddObject("txt_4c_Hist2", "TextBox")
1733:         WITH loc_oPagina.txt_4c_Hist2
1734:             .Top      = 574
1735:             .Left     = 8
1736:             .Width    = 290
1737:             .Height   = 20
1738:             .Value    = ""
1739:             .FontName = "Tahoma"
1740:             .FontSize = 8
1741:             .ReadOnly = .T.
1742:         ENDWITH
1743: 
1744:         *-- Label3 "Usuario": top=538, left=310, width=45, height=15
1745:         loc_oPagina.AddObject("lbl_4c_Lbl3", "Label")
1746:         WITH loc_oPagina.lbl_4c_Lbl3
1747:             .Top       = 538
1748:             .Left      = 310
1749:             .Width     = 45
1750:             .Height    = 15
1751:             .Caption   = "Usu" + CHR(225) + "rio"
1752:             .FontName  = "Tahoma"
1753:             .FontSize  = 8
1754:             .ForeColor = RGB(0, 0, 0)
1755:             .BackStyle = 0
1756:         ENDWITH
1757: 
1758:         *-- Get1: top=553, left=308, width=89, height=20
1759:         loc_oPagina.AddObject("txt_4c_Get1", "TextBox")
1760:         WITH loc_oPagina.txt_4c_Get1
1761:             .Top      = 553
1762:             .Left     = 308
1763:             .Width    = 89
1764:             .Height   = 20
1765:             .Value    = ""
1766:             .FontName = "Tahoma"
1767:             .FontSize = 8
1768:             .ReadOnly = .T.
1769:         ENDWITH
1770: 
1771:         *-- Label8 "Cobranca": top=538, left=408, width=55, height=15
1772:         loc_oPagina.AddObject("lbl_4c_Lbl8", "Label")
1773:         WITH loc_oPagina.lbl_4c_Lbl8
1774:             .Top       = 538
1775:             .Left      = 408
1776:             .Width     = 55
1777:             .Height    = 15
1778:             .Caption   = "Cobran" + CHR(231) + CHR(97) + ""
1779:             .FontName  = "Tahoma"
1780:             .FontSize  = 8
1781:             .ForeColor = RGB(0, 0, 0)
1782:             .BackStyle = 0
1783:         ENDWITH
1784: 
1785:         *-- getCtaCob: top=553, left=406, width=89, height=20
1786:         loc_oPagina.AddObject("txt_4c_CtaCob", "TextBox")
1787:         WITH loc_oPagina.txt_4c_CtaCob
1788:             .Top      = 553
1789:             .Left     = 406
1790:             .Width    = 89
1791:             .Height   = 20
1792:             .Value    = ""
1793:             .FontName = "Tahoma"
1794:             .FontSize = 8
1795:             .ReadOnly = .T.
1796:         ENDWITH
1797: 
1798:         *-- getNomCob: top=553, left=496, width=327, height=20
1799:         loc_oPagina.AddObject("txt_4c_NomCob", "TextBox")
1800:         WITH loc_oPagina.txt_4c_NomCob
1801:             .Top      = 553
1802:             .Left     = 496
1803:             .Width    = 327
1804:             .Height   = 20
1805:             .Value    = ""
1806:             .FontName = "Tahoma"
1807:             .FontSize = 8
1808:             .ReadOnly = .T.
1809:         ENDWITH
1810: 
1811:         *-- Label10 "Job:": top=578, left=370, width=28, height=15
1812:         loc_oPagina.AddObject("lbl_4c_Lbl10", "Label")
1813:         WITH loc_oPagina.lbl_4c_Lbl10
1814:             .Top       = 578
1815:             .Left      = 370
1816:             .Width     = 28
1817:             .Height    = 15
1818:             .Caption   = "Job :"
1819:             .FontName  = "Tahoma"
1820:             .FontSize  = 8
1821:             .ForeColor = RGB(0, 0, 0)
1822:             .BackStyle = 0
1823:         ENDWITH
1824: 
1825:         *-- getjob: top=574, left=406, width=89, height=20
1826:         loc_oPagina.AddObject("txt_4c_job", "TextBox")
1827:         WITH loc_oPagina.txt_4c_job
1828:             .Top      = 574
1829:             .Left     = 406
1830:             .Width    = 89
1831:             .Height   = 20
1832:             .Value    = ""
1833:             .FontName = "Tahoma"
1834:             .FontSize = 8
1835:             .ReadOnly = .T.
1836:         ENDWITH
1837: 
1838:         *-- getdjob: top=574, left=496, width=327, height=20
1839:         loc_oPagina.AddObject("txt_4c_djob", "TextBox")
1840:         WITH loc_oPagina.txt_4c_djob
1841:             .Top      = 574
1842:             .Left     = 496
1843:             .Width    = 327
1844:             .Height   = 20
1845:             .Value    = ""
1846:             .FontName = "Tahoma"
1847:             .FontSize = 8
1848:             .ReadOnly = .T.
1849:         ENDWITH
1850: 
1851:         *-- Say_Data "Conciliacao": top=538, left=833, width=68, height=15
1852:         loc_oPagina.AddObject("lbl_4c_SayData", "Label")
1853:         WITH loc_oPagina.lbl_4c_SayData
1854:             .Top       = 538
1855:             .Left      = 833
1856:             .Width     = 68
1857:             .Height    = 15
1858:             .Caption   = "Concilia" + CHR(231) + CHR(227) + "o"
1859:             .FontName  = "Tahoma"
1860:             .FontSize  = 8
1861:             .ForeColor = RGB(0, 0, 0)
1862:             .BackStyle = 0
1863:         ENDWITH
1864: 
1865:         *-- Get_Data (data de conciliacao): top=553, left=833, width=73, height=20
1866:         loc_oPagina.AddObject("txt_4c_DataConcilia", "TextBox")
1867:         WITH loc_oPagina.txt_4c_DataConcilia
1868:             .Top      = 553
1869:             .Left     = 833
1870:             .Width    = 73
1871:             .Height   = 20
1872:             .Value    = {}
1873:             .Format   = "D"
1874:             .FontName = "Tahoma"

*-- Linhas 1880 a 1929:
1880:         *-- Get3: top=574, left=833, width=73, height=20
1881:         loc_oPagina.AddObject("txt_4c_Get3", "TextBox")
1882:         WITH loc_oPagina.txt_4c_Get3
1883:             .Top      = 574
1884:             .Left     = 833
1885:             .Width    = 73
1886:             .Height   = 20
1887:             .Value    = ""
1888:             .FontName = "Tahoma"
1889:             .FontSize = 8
1890:             .ReadOnly = .T.
1891:         ENDWITH
1892: 
1893:         *-- Lbl_Auditoria "Auditoria": top=538, left=916, width=54, height=15
1894:         loc_oPagina.AddObject("lbl_4c_LblAuditoria", "Label")
1895:         WITH loc_oPagina.lbl_4c_LblAuditoria
1896:             .Top       = 538
1897:             .Left      = 916
1898:             .Width     = 54
1899:             .Height    = 15
1900:             .Caption   = "Auditoria"
1901:             .FontName  = "Tahoma"
1902:             .FontSize  = 8
1903:             .ForeColor = RGB(0, 0, 0)
1904:             .BackStyle = 0
1905:         ENDWITH
1906: 
1907:         *-- Get_DtAudits: top=553, left=916, width=73, height=20
1908:         loc_oPagina.AddObject("txt_4c_DtAudits", "TextBox")
1909:         WITH loc_oPagina.txt_4c_DtAudits
1910:             .Top      = 553
1911:             .Left     = 916
1912:             .Width    = 73
1913:             .Height   = 20
1914:             .Value    = {}
1915:             .FontName = "Tahoma"
1916:             .FontSize = 8
1917:             .ReadOnly = .T.
1918:         ENDWITH
1919: 
1920:         *-- Get_Auditors: top=574, left=916, width=73, height=20
1921:         loc_oPagina.AddObject("txt_4c_Auditors", "TextBox")
1922:         WITH loc_oPagina.txt_4c_Auditors
1923:             .Top      = 574
1924:             .Left     = 916
1925:             .Width    = 73
1926:             .Height   = 20
1927:             .Value    = ""
1928:             .FontName = "Tahoma"
1929:             .FontSize = 8

*-- Linhas 1989 a 1998:
1989:         loc_oPagina.AddObject("grd_4c_Lancamento", "Grid")
1990:         loc_oGrd = loc_oPagina.grd_4c_Lancamento
1991:         WITH loc_oGrd
1992:             .Top        = 142
1993:             .Left       = 10
1994:             .Width      = 981
1995:             .Height     = 389
1996:             .FontName   = "Tahoma"
1997:             .FontSize   = 8
1998:             .GridLines  = 0

*-- Linhas 2006 a 2133:
2006:         * Column11 (col_selec no legado): coluna de MARCACAO da linha.
2007:         * Legado: ColumnOrder = 1 (primeira na tela), Width = 22, Movable = .F.,
2008:         * ReadOnly = .F., Sparse = .F., Header1 com Picture CHECKBX.BMP.
2009:         * O CheckBox precisa de AddObject + CurrentControl para APARECER
2010:         * (a Column nasce so com Header1/Text1).
2011:         *----------------------------------------------------------------------
2012:         loc_oGrd.Column11.AddObject("chk_4c_Selec", "CheckBox")
2013:         WITH loc_oGrd.Column11.chk_4c_Selec
2014:             .Top       = 23
2015:             .Left      = 4
2016:             .Width     = 60
2017:             .Height    = 17
2018:             .Caption   = ""
2019:             .Value     = 0
2020:             .FontName  = "Tahoma"
2021:             .Alignment = 0
2022:             .ReadOnly  = .F.
2023:             .BackStyle = 0
2024:             .Visible   = .T.
2025:         ENDWITH
2026: 
2027:         *-- Handlers do CheckBox de grade: o toggle nativo NAO altera o cursor,
2028:         *-- por isso Click/MouseDown suprimem o default e MouseUp/KeyPress
2029:         *-- gravam o valor (legado col_selec.Check1).
2030:         BINDEVENT(loc_oGrd.Column11.chk_4c_Selec, "Click",     THIS, "ChkSelecClick")
2031:         BINDEVENT(loc_oGrd.Column11.chk_4c_Selec, "MouseDown", THIS, "ChkSelecMouseDown")
2032:         BINDEVENT(loc_oGrd.Column11.chk_4c_Selec, "MouseUp",   THIS, "ChkSelecMouseUp")
2033:         BINDEVENT(loc_oGrd.Column11.chk_4c_Selec, "KeyPress",  THIS, "ChkSelecKeyPress")
2034:         BINDEVENT(loc_oGrd.Column11.Header1,      "Click",     THIS, "HeaderSelecClick")
2035: 
2036:         *-- Column1: Datas (Data)
2037:         WITH loc_oGrd.Column1
2038:             .Header1.Caption = "Data"
2039:             .ControlSource   = "CrSigMvCcr.Datas"
2040:             .Width           = 72
2041:             .Alignment       = 0
2042:             .Text1.FontName  = "Tahoma"
2043:             .Text1.FontSize  = 8
2044:         ENDWITH
2045: 
2046:         *-- Column2: Hists (Historico)
2047:         WITH loc_oGrd.Column2
2048:             .Header1.Caption = "Hist" + CHR(243) + "rico"
2049:             .ControlSource   = "CrSigMvCcr.Hists"
2050:             .Width           = 240
2051:             .Alignment       = 0
2052:             .Text1.FontName  = "Tahoma"
2053:             .Text1.FontSize  = 8
2054:         ENDWITH
2055: 
2056:         *-- Column3: Valors (Valor)
2057:         WITH loc_oGrd.Column3
2058:             .Header1.Caption = "Valor"
2059:             .ControlSource   = "CrSigMvCcr.Valors"
2060:             .Width           = 90
2061:             .Alignment       = 1
2062:             .Text1.FontName  = "Tahoma"
2063:             .Text1.FontSize  = 8
2064:         ENDWITH
2065: 
2066:         *-- Column4: Opers (Mov)
2067:         WITH loc_oGrd.Column4
2068:             .Header1.Caption = "Mov"
2069:             .ControlSource   = "CrSigMvCcr.Opers"
2070:             .Width           = 40
2071:             .Alignment       = 2
2072:             .Text1.FontName  = "Tahoma"
2073:             .Text1.FontSize  = 8
2074:         ENDWITH
2075: 
2076:         *-- Column5: Emps (Emp)
2077:         WITH loc_oGrd.Column5
2078:             .Header1.Caption = "Emp"
2079:             .ControlSource   = "CrSigMvCcr.Emps"
2080:             .Width           = 40
2081:             .Alignment       = 2
2082:             .Text1.FontName  = "Tahoma"
2083:             .Text1.FontSize  = 8
2084:         ENDWITH
2085: 
2086:         *-- Column6: Saldos (Saldo)
2087:         WITH loc_oGrd.Column6
2088:             .Header1.Caption = "Saldo"
2089:             .ControlSource   = "CrSigMvCcr.Saldos"
2090:             .Width           = 90
2091:             .Alignment       = 1
2092:             .Text1.FontName  = "Tahoma"
2093:             .Text1.FontSize  = 8
2094:         ENDWITH
2095: 
2096:         *-- Column7: Docus (Documento)
2097:         WITH loc_oGrd.Column7
2098:             .Header1.Caption = "Documento"
2099:             .ControlSource   = "CrSigMvCcr.Docus"
2100:             .Width           = 110
2101:             .Alignment       = 0
2102:             .Text1.FontName  = "Tahoma"
2103:             .Text1.FontSize  = 8
2104:         ENDWITH
2105: 
2106:         *-- Column8: NFs (Nota)
2107:         WITH loc_oGrd.Column8
2108:             .Header1.Caption = "Nota"
2109:             .ControlSource   = "CrSigMvCcr.NFs"
2110:             .Width           = 80
2111:             .Alignment       = 0
2112:             .Text1.FontName  = "Tahoma"
2113:             .Text1.FontSize  = 8
2114:         ENDWITH
2115: 
2116:         *-- Column9: Titulos (Titulo)
2117:         WITH loc_oGrd.Column9
2118:             .Header1.Caption = "T" + CHR(237) + "tulo"
2119:             .ControlSource   = "CrSigMvCcr.Titulos"
2120:             .Width           = 115
2121:             .Alignment       = 0
2122:             .Text1.FontName  = "Tahoma"
2123:             .Text1.FontSize  = 8
2124:         ENDWITH
2125: 
2126:         *-- Column10: Tipo (T)
2127:         WITH loc_oGrd.Column10
2128:             .Header1.Caption = "T"
2129:             .ControlSource   = "CrSigMvCcr.Tipo"
2130:             .Width           = 40
2131:             .Alignment       = 2
2132:             .Text1.FontName  = "Tahoma"
2133:             .Text1.FontSize  = 8

*-- Linhas 2179 a 2255:
2179:             par_oPagina.AddObject("cnt_4c_Imprime", "Container")
2180:             loc_oCnt = par_oPagina.cnt_4c_Imprime
2181:             WITH loc_oCnt
2182:                 .Top           = 187
2183:                 .Left          = 145
2184:                 .Width         = 709
2185:                 .Height        = 231
2186:                 .Visible       = .F.
2187:                 .BackColor     = RGB(212, 208, 200)
2188:                 .BorderWidth   = 1
2189:                 .SpecialEffect = 0
2190:             ENDWITH
2191: 
2192:             *-- Shape1 (fundo/borda superior): top=2, left=1, width=708, height=80
2193:             loc_oCnt.AddObject("shp_4c_Shape1", "Shape")
2194:             WITH loc_oCnt.shp_4c_Shape1
2195:                 .Top           = 2
2196:                 .Left          = 1
2197:                 .Width         = 708
2198:                 .Height        = 80
2199:                 .BackColor     = RGB(212, 208, 200)
2200:                 .BorderColor   = RGB(128, 128, 128)
2201:                 .SpecialEffect = 0
2202:             ENDWITH
2203: 
2204:             *-- Sombra titulo (Label2 shadow): top=35, left=16
2205:             loc_oCnt.AddObject("lbl_4c_ImpSombra", "Label")
2206:             WITH loc_oCnt.lbl_4c_ImpSombra
2207:                 .Top       = 35
2208:                 .Left      = 16
2209:                 .Width     = 291
2210:                 .Height    = 22
2211:                 .Caption   = "Relat" + CHR(243) + "rio de Conta Corrente"
2212:                 .FontName  = "Tahoma"
2213:                 .FontSize  = 10
2214:                 .FontBold  = .T.
2215:                 .ForeColor = RGB(0, 0, 0)
2216:                 .BackStyle = 0
2217:             ENDWITH
2218: 
2219:             *-- Titulo (Label1): top=33, left=16
2220:             loc_oCnt.AddObject("lbl_4c_TituloImprime", "Label")
2221:             WITH loc_oCnt.lbl_4c_TituloImprime
2222:                 .Top       = 33
2223:                 .Left      = 16
2224:                 .Width     = 291
2225:                 .Height    = 22
2226:                 .Caption   = "Relat" + CHR(243) + "rio de Conta Corrente"
2227:                 .FontName  = "Tahoma"
2228:                 .FontSize  = 10
2229:                 .FontBold  = .T.
2230:                 .ForeColor = RGB(0, 0, 128)
2231:                 .BackStyle = 0
2232:             ENDWITH
2233: 
2234:             *-- Botao Voltar (CommandGroup top=0, left=627, width=85, height=85)
2235:             loc_oCnt.AddObject("obj_4c_CntImpVoltar", "CommandGroup")
2236:             WITH loc_oCnt.obj_4c_CntImpVoltar
2237:                 .Top         = 0
2238:                 .Left        = 627
2239:                 .Width       = 85
2240:                 .Height      = 85
2241:                 .ButtonCount = 1
2242:                 .BorderStyle = 0
2243:                 .SpecialEffect = 0
2244:             ENDWITH
2245:             WITH loc_oCnt.obj_4c_CntImpVoltar.Buttons(1)
2246:                 .Caption    = "Encerrar"
2247:                 .Width      = 75
2248:                 .Height     = 75
2249:                 .Left       = 5
2250:                 .Top        = 5
2251:                 .FontName   = "Comic Sans MS"
2252:                 .FontSize   = 8
2253:                 .FontBold   = .T.
2254:                 .FontItalic = .T.
2255:                 .ForeColor  = RGB(90, 90, 90)

*-- Linhas 2261 a 2653:
2261:             BINDEVENT(loc_oCnt.obj_4c_CntImpVoltar, "Click", THIS, "BtnCntImpVoltarClick")
2262: 
2263:             *-- Botao Excel (Command1): top=11, left=557, width=75, height=75
2264:             loc_oCnt.AddObject("cmd_4c_ImpExcel", "CommandButton")
2265:             WITH loc_oCnt.cmd_4c_ImpExcel
2266:                 .Top              = 11
2267:                 .Left             = 557
2268:                 .Width            = 75
2269:                 .Height           = 75
2270:                 .Caption          = "   E\<xcel             "
2271:                 .FontName         = "Comic Sans MS"
2272:                 .FontSize         = 8
2273:                 .FontBold         = .T.
2274:                 .FontItalic       = .T.
2275:                 .ForeColor        = RGB(90, 90, 90)
2276:                 .BackColor        = RGB(255, 255, 255)
2277:                 .Themes           = .F.
2278:                 .PicturePosition  = 13
2279:                 .Picture          = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"
2280:             ENDWITH
2281:             BINDEVENT(loc_oCnt.cmd_4c_ImpExcel, "Click", THIS, "BtnCntImpExcelClick")
2282: 
2283:             *-- Botao Impressora (Cmd_Imprimir): top=11, left=482, width=75, height=75
2284:             loc_oCnt.AddObject("cmd_4c_ImpPrint", "CommandButton")
2285:             WITH loc_oCnt.cmd_4c_ImpPrint
2286:                 .Top              = 11
2287:                 .Left             = 482
2288:                 .Width            = 75
2289:                 .Height           = 75
2290:                 .Caption          = "\<Impressora"
2291:                 .FontName         = "Comic Sans MS"
2292:                 .FontSize         = 8
2293:                 .FontBold         = .T.
2294:                 .FontItalic       = .T.
2295:                 .ForeColor        = RGB(90, 90, 90)
2296:                 .BackColor        = RGB(255, 255, 255)
2297:                 .Themes           = .F.
2298:                 .PicturePosition  = 13
2299:                 .Picture          = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
2300:             ENDWITH
2301:             BINDEVENT(loc_oCnt.cmd_4c_ImpPrint, "Click", THIS, "BtnCntImpImprimirClick")
2302: 
2303:             *-- Botao Video/Preview (Cmd_Visual): top=11, left=407, width=75, height=75
2304:             loc_oCnt.AddObject("cmd_4c_ImpVideo", "CommandButton")
2305:             WITH loc_oCnt.cmd_4c_ImpVideo
2306:                 .Top              = 11
2307:                 .Left             = 407
2308:                 .Width            = 75
2309:                 .Height           = 75
2310:                 .Caption          = "\<V" + CHR(237) + "deo"
2311:                 .FontName         = "Comic Sans MS"
2312:                 .FontSize         = 8
2313:                 .FontBold         = .T.
2314:                 .FontItalic       = .T.
2315:                 .ForeColor        = RGB(90, 90, 90)
2316:                 .BackColor        = RGB(255, 255, 255)
2317:                 .Themes           = .F.
2318:                 .PicturePosition  = 13
2319:                 .Picture          = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
2320:             ENDWITH
2321:             BINDEVENT(loc_oCnt.cmd_4c_ImpVideo, "Click", THIS, "BtnCntImpVisualClick")
2322: 
2323:             *-- lbl_periodo "Periodo :": top=103, left=32, width=45
2324:             loc_oCnt.AddObject("lbl_4c_ImpPeriodo", "Label")
2325:             WITH loc_oCnt.lbl_4c_ImpPeriodo
2326:                 .Top      = 103
2327:                 .Left     = 32
2328:                 .Width    = 45
2329:                 .Caption  = "Per" + CHR(237) + "odo :"
2330:                 .FontName = "Tahoma"
2331:                 .FontSize = 8
2332:                 .ForeColor = RGB(0, 0, 0)
2333:                 .BackStyle = 0
2334:             ENDWITH
2335: 
2336:             *-- get_dt_inicial: top=98, left=80, width=80
2337:             loc_oCnt.AddObject("txt_4c_Dt_inicial", "TextBox")
2338:             WITH loc_oCnt.txt_4c_Dt_inicial
2339:                 .Top      = 98
2340:                 .Left     = 80
2341:                 .Width    = 80
2342:                 .Height   = 23
2343:                 .Value    = {}
2344:                 .FontName = "Tahoma"
2345:                 .FontSize = 8
2346:             ENDWITH
2347: 
2348:             *-- lbl_periodo_a "a": top=103, left=163
2349:             loc_oCnt.AddObject("lbl_4c_A", "Label")
2350:             WITH loc_oCnt.lbl_4c_A
2351:                 .Top      = 103
2352:                 .Left     = 163
2353:                 .Width    = 8
2354:                 .Caption  = CHR(224)
2355:                 .FontName = "Tahoma"
2356:                 .FontSize = 8
2357:                 .ForeColor = RGB(0, 0, 0)
2358:                 .BackStyle = 0
2359:             ENDWITH
2360: 
2361:             *-- get_dt_final: top=98, left=174, width=80
2362:             loc_oCnt.AddObject("txt_4c_Dt_final", "TextBox")
2363:             WITH loc_oCnt.txt_4c_Dt_final
2364:                 .Top      = 98
2365:                 .Left     = 174
2366:                 .Width    = 80
2367:                 .Height   = 23
2368:                 .Value    = {}
2369:                 .FontName = "Tahoma"
2370:                 .FontSize = 8
2371:             ENDWITH
2372: 
2373:             *-- Say2 "D/C:": top=102, left=266
2374:             loc_oCnt.AddObject("lbl_4c_DC", "Label")
2375:             WITH loc_oCnt.lbl_4c_DC
2376:                 .Top      = 102
2377:                 .Left     = 266
2378:                 .Width    = 24
2379:                 .Caption  = "D/C:"
2380:                 .FontName = "Tahoma"
2381:                 .FontSize = 8
2382:                 .ForeColor = RGB(0, 0, 0)
2383:                 .BackStyle = 0
2384:             ENDWITH
2385: 
2386:             *-- Get_Oper: top=98, left=298, width=17
2387:             loc_oCnt.AddObject("txt_4c_Oper", "TextBox")
2388:             WITH loc_oCnt.txt_4c_Oper
2389:                 .Top       = 98
2390:                 .Left      = 298
2391:                 .Width     = 17
2392:                 .Height    = 23
2393:                 .Value     = ""
2394:                 .MaxLength = 1
2395:                 .FontName  = "Tahoma"
2396:                 .FontSize  = 8
2397:             ENDWITH
2398:             BINDEVENT(loc_oCnt.txt_4c_Oper, "KeyPress", THIS, "TxtOperImpKeyPress")
2399: 
2400:             *-- Say1 "Moeda :": top=127, left=36
2401:             loc_oCnt.AddObject("lbl_4c_MoedaImp", "Label")
2402:             WITH loc_oCnt.lbl_4c_MoedaImp
2403:                 .Top      = 127
2404:                 .Left     = 36
2405:                 .Width    = 41
2406:                 .Caption  = "Moeda :"
2407:                 .FontName = "Tahoma"
2408:                 .FontSize = 8
2409:                 .ForeColor = RGB(0, 0, 0)
2410:                 .BackStyle = 0
2411:             ENDWITH
2412: 
2413:             *-- get_cd_moeda: top=123, left=80, width=31
2414:             loc_oCnt.AddObject("txt_4c_CdMoeda", "TextBox")
2415:             WITH loc_oCnt.txt_4c_CdMoeda
2416:                 .Top       = 123
2417:                 .Left      = 80
2418:                 .Width     = 31
2419:                 .Height    = 23
2420:                 .Value     = ""
2421:                 .MaxLength = 3
2422:                 .FontName  = "Tahoma"
2423:                 .FontSize  = 8
2424:             ENDWITH
2425:             BINDEVENT(loc_oCnt.txt_4c_CdMoeda, "KeyPress", THIS, "TxtCdMoedaImpKeyPress")
2426: 
2427:             *-- get_ds_moeda: top=123, left=113, width=202, height=23
2428:             loc_oCnt.AddObject("txt_4c_DsMoeda", "TextBox")
2429:             WITH loc_oCnt.txt_4c_DsMoeda
2430:                 .Top      = 123
2431:                 .Left     = 113
2432:                 .Width    = 202
2433:                 .Height   = 23
2434:                 .Value    = ""
2435:                 .FontName = "Tahoma"
2436:                 .FontSize = 8
2437:             ENDWITH
2438:             BINDEVENT(loc_oCnt.txt_4c_DsMoeda, "KeyPress", THIS, "TxtDsMoedaImpKeyPress")
2439: 
2440:             *-- Say3 "Empresa :": top=152, left=27
2441:             loc_oCnt.AddObject("lbl_4c_EmpresaImp", "Label")
2442:             WITH loc_oCnt.lbl_4c_EmpresaImp
2443:                 .Top      = 152
2444:                 .Left     = 27
2445:                 .Width    = 50
2446:                 .Caption  = "Empresa :"
2447:                 .FontName = "Tahoma"
2448:                 .FontSize = 8
2449:                 .ForeColor = RGB(0, 0, 0)
2450:                 .BackStyle = 0
2451:             ENDWITH
2452: 
2453:             *-- getEmps: top=148, left=80, width=31
2454:             loc_oCnt.AddObject("txt_4c_Emps", "TextBox")
2455:             WITH loc_oCnt.txt_4c_Emps
2456:                 .Top       = 148
2457:                 .Left      = 80
2458:                 .Width     = 31
2459:                 .Height    = 23
2460:                 .Value     = ""
2461:                 .MaxLength = 3
2462:                 .FontName  = "Tahoma"
2463:                 .FontSize  = 8
2464:             ENDWITH
2465:             BINDEVENT(loc_oCnt.txt_4c_Emps, "KeyPress", THIS, "TxtEmpsImpKeyPress")
2466: 
2467:             *-- getDEmps: top=148, left=113, width=202, height=23
2468:             loc_oCnt.AddObject("txt_4c_DEmps", "TextBox")
2469:             WITH loc_oCnt.txt_4c_DEmps
2470:                 .Top      = 148
2471:                 .Left     = 113
2472:                 .Width    = 202
2473:                 .Height   = 23
2474:                 .Value    = ""
2475:                 .FontName = "Tahoma"
2476:                 .FontSize = 8
2477:             ENDWITH
2478:             BINDEVENT(loc_oCnt.txt_4c_DEmps, "KeyPress", THIS, "TxtDEmpsImpKeyPress")
2479: 
2480:             *-- Chk_Grupo: top=97, left=321, width=143, height=15
2481:             loc_oCnt.AddObject("chk_4c_Grupo", "CheckBox")
2482:             WITH loc_oCnt.chk_4c_Grupo
2483:                 .Top      = 97
2484:                 .Left     = 321
2485:                 .Width    = 143
2486:                 .Height   = 15
2487:                 .Caption  = "Todas as contas do Grupo"
2488:                 .Value    = 0
2489:                 .FontName = "Tahoma"
2490:                 .FontSize = 8
2491:             ENDWITH
2492: 
2493:             *-- Check_Salto: top=115, left=321, width=138, height=15
2494:             loc_oCnt.AddObject("chk_4c_Salto", "CheckBox")
2495:             WITH loc_oCnt.chk_4c_Salto
2496:                 .Top      = 115
2497:                 .Left     = 321
2498:                 .Width    = 138
2499:                 .Height   = 15
2500:                 .Caption  = "Quebra p" + CHR(225) + "gina por conta"
2501:                 .Value    = 0
2502:                 .FontName = "Tahoma"
2503:                 .FontSize = 8
2504:             ENDWITH
2505: 
2506:             *-- Check_sAnt: top=133, left=321, width=109, height=15
2507:             loc_oCnt.AddObject("chk_4c_Sant", "CheckBox")
2508:             WITH loc_oCnt.chk_4c_Sant
2509:                 .Top      = 133
2510:                 .Left     = 321
2511:                 .Width    = 109
2512:                 .Height   = 15
2513:                 .Caption  = "Sem Saldo Anterior"
2514:                 .Value    = 0
2515:                 .FontName = "Tahoma"
2516:                 .FontSize = 8
2517:             ENDWITH
2518: 
2519:             *-- Check_Comissao: top=152, left=321, width=63, height=15
2520:             loc_oCnt.AddObject("chk_4c_Comissao", "CheckBox")
2521:             WITH loc_oCnt.chk_4c_Comissao
2522:                 .Top      = 152
2523:                 .Left     = 321
2524:                 .Width    = 63
2525:                 .Height   = 15
2526:                 .Caption  = "Comiss" + CHR(227) + "o"
2527:                 .Value    = 0
2528:                 .FontName = "Tahoma"
2529:                 .FontSize = 8
2530:             ENDWITH
2531: 
2532:             *-- Check_Saldoa: top=152, left=407, width=67, height=15
2533:             loc_oCnt.AddObject("chk_4c_Saldoa", "CheckBox")
2534:             WITH loc_oCnt.chk_4c_Saldoa
2535:                 .Top      = 152
2536:                 .Left     = 407
2537:                 .Width    = 67
2538:                 .Height   = 15
2539:                 .Caption  = "Sem Saldo"
2540:                 .Value    = 0
2541:                 .FontName = "Tahoma"
2542:                 .FontSize = 8
2543:             ENDWITH
2544: 
2545:             *-- chkTaxas: top=170, left=321, width=79, height=15
2546:             loc_oCnt.AddObject("chk_4c_Taxas", "CheckBox")
2547:             WITH loc_oCnt.chk_4c_Taxas
2548:                 .Top      = 170
2549:                 .Left     = 321
2550:                 .Width    = 79
2551:                 .Height   = 15
2552:                 .Caption  = "Incluir Taxas"
2553:                 .Value    = 0
2554:                 .FontName = "Tahoma"
2555:                 .FontSize = 8
2556:             ENDWITH
2557: 
2558:             *-- chkOcultaCta: top=188, left=321, width=149, height=15
2559:             loc_oCnt.AddObject("chk_4c_OcultaCta", "CheckBox")
2560:             WITH loc_oCnt.chk_4c_OcultaCta
2561:                 .Top      = 188
2562:                 .Left     = 321
2563:                 .Width    = 149
2564:                 .Height   = 15
2565:                 .Caption  = "Ocultar Descri" + CHR(231) + CHR(227) + "o da Conta"
2566:                 .Value    = 0
2567:                 .FontName = "Tahoma"
2568:                 .FontSize = 8
2569:             ENDWITH
2570: 
2571:             *-- Check_RazaoCP: top=97, left=521, width=148, height=15
2572:             loc_oCnt.AddObject("chk_4c_RazaoCp", "CheckBox")
2573:             WITH loc_oCnt.chk_4c_RazaoCp
2574:                 .Top      = 97
2575:                 .Left     = 521
2576:                 .Width    = 148
2577:                 .Height   = 15
2578:                 .Caption  = "Rela" + CHR(231) + CHR(227) + "o com Contrapartida"
2579:                 .Value    = 0
2580:                 .FontName = "Tahoma"
2581:                 .FontSize = 8
2582:             ENDWITH
2583:             BINDEVENT(loc_oCnt.chk_4c_RazaoCp, "InteractiveChange", THIS, "ChkRazaoCPChange")
2584: 
2585:             *-- Check_RazaoDoc: top=115, left=521, width=135, height=15
2586:             loc_oCnt.AddObject("chk_4c_RazaoDoc", "CheckBox")
2587:             WITH loc_oCnt.chk_4c_RazaoDoc
2588:                 .Top      = 115
2589:                 .Left     = 521
2590:                 .Width    = 135
2591:                 .Height   = 15
2592:                 .Caption  = "Rela" + CHR(231) + CHR(227) + "o com Documento"
2593:                 .Value    = 0
2594:                 .FontName = "Tahoma"
2595:                 .FontSize = 8
2596:             ENDWITH
2597:             BINDEVENT(loc_oCnt.chk_4c_RazaoDoc, "InteractiveChange", THIS, "ChkRazaoDocChange")
2598: 
2599:             *-- chkRelDets: top=133, left=521, width=108, height=15
2600:             loc_oCnt.AddObject("chk_4c_RelDets", "CheckBox")
2601:             WITH loc_oCnt.chk_4c_RelDets
2602:                 .Top      = 133
2603:                 .Left     = 521
2604:                 .Width    = 108
2605:                 .Height   = 15
2606:                 .Caption  = "Rela" + CHR(231) + CHR(227) + "o Detalhada"
2607:                 .Value    = 0
2608:                 .FontName = "Tahoma"
2609:                 .FontSize = 8
2610:             ENDWITH
2611:             BINDEVENT(loc_oCnt.chk_4c_RelDets, "InteractiveChange", THIS, "ChkRelDetsChange")
2612: 
2613:             *-- optSNA (S/N/A): top=147, left=520, width=160, height=27, buttonCount=3
2614:             loc_oCnt.AddObject("obj_4c_OptSNA", "OptionGroup")
2615:             WITH loc_oCnt.obj_4c_OptSNA
2616:                 .Top         = 147
2617:                 .Left        = 520
2618:                 .Width       = 160
2619:                 .Height      = 27
2620:                 .ButtonCount = 3
2621:                 .BorderStyle = 0
2622:                 .Value       = 1
2623:             ENDWITH
2624:             WITH loc_oCnt.obj_4c_OptSNA.Buttons(1)
2625:                 .Caption   = "S"
2626:                 .BackStyle = 0
2627:                 .Top       = 3
2628:                 .Left      = 3
2629:                 .Width     = 40
2630:                 .Height    = 20
2631:                 .FontName  = "Tahoma"
2632:                 .FontSize  = 8
2633:             ENDWITH
2634:             WITH loc_oCnt.obj_4c_OptSNA.Buttons(2)
2635:                 .Caption   = "N"
2636:                 .BackStyle = 0
2637:                 .Top       = 3
2638:                 .Left      = 50
2639:                 .Width     = 40
2640:                 .Height    = 20
2641:                 .FontName  = "Tahoma"
2642:                 .FontSize  = 8
2643:             ENDWITH
2644:             WITH loc_oCnt.obj_4c_OptSNA.Buttons(3)
2645:                 .Caption   = "A"
2646:                 .BackStyle = 0
2647:                 .Top       = 3
2648:                 .Left      = 97
2649:                 .Width     = 40
2650:                 .Height    = 20
2651:                 .FontName  = "Tahoma"
2652:                 .FontSize  = 8
2653:             ENDWITH

*-- Linhas 2669 a 2694:
2669:             par_oPagina.AddObject("cnt_4c_Quitas", "Container")
2670:             loc_oCnt = par_oPagina.cnt_4c_Quitas
2671:             WITH loc_oCnt
2672:                 .Top           = 198
2673:                 .Left          = 252
2674:                 .Width         = 496
2675:                 .Height        = 272
2676:                 .Visible       = .F.
2677:                 .BackColor     = RGB(212, 208, 200)
2678:                 .BorderWidth   = 1
2679:                 .SpecialEffect = 0
2680:             ENDWITH
2681: 
2682:             *-- Label1 "Recebimento de Parcelas": top=5, left=39, width=418, height=20
2683:             loc_oCnt.AddObject("lbl_4c_LblQuitasTitulo", "Label")
2684:             WITH loc_oCnt.lbl_4c_LblQuitasTitulo
2685:                 .Top       = 5
2686:                 .Left      = 39
2687:                 .Width     = 418
2688:                 .Height    = 20
2689:                 .Caption   = "Recebimento de Parcelas"
2690:                 .FontName  = "Tahoma"
2691:                 .FontSize  = 10
2692:                 .FontBold  = .T.
2693:                 .ForeColor = RGB(0, 0, 128)
2694:                 .BackStyle = 0

*-- Linhas 2704 a 2713:
2704:             loc_oCnt.AddObject("grd_4c_Grade", "Grid")
2705:             loc_oGrd = loc_oCnt.grd_4c_Grade
2706:             WITH loc_oGrd
2707:                 .Top      = 34
2708:                 .Left     = 13
2709:                 .Width    = 469
2710:                 .Height   = 180
2711:                 .ReadOnly = .T.
2712:                 .FontName = "Tahoma"
2713:                 .FontSize = 8

*-- Linhas 2724 a 2761:
2724:             loc_oGrd.Column4.ControlSource   = "cursor_4c_Baixas.Valos"
2725:             loc_oGrd.Column5.ControlSource   = "cursor_4c_Baixas.Moedas"
2726:             loc_oGrd.Column6.ControlSource   = "cursor_4c_Baixas.Datarcs"
2727:             loc_oGrd.Column1.Header1.Caption = "Emp"
2728:             loc_oGrd.Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
2729:             loc_oGrd.Column3.Header1.Caption = "C" + CHR(243) + "digo"
2730:             loc_oGrd.Column4.Header1.Caption = "Valor"
2731:             loc_oGrd.Column5.Header1.Caption = "Moe"
2732:             loc_oGrd.Column6.Header1.Caption = "Data"
2733:             loc_oGrd.Column1.Width = 35
2734:             loc_oGrd.Column2.Width = 120
2735:             loc_oGrd.Column3.Width = 60
2736:             loc_oGrd.Column4.Width = 80
2737:             loc_oGrd.Column5.Width = 35
2738:             loc_oGrd.Column6.Width = 70
2739: 
2740:             *-- cmd_grupo (Voltar): top=214, left=432, width=50, height=50, buttonCount=1
2741:             loc_oCnt.AddObject("obj_4c_QuitasVoltar", "CommandGroup")
2742:             WITH loc_oCnt.obj_4c_QuitasVoltar
2743:                 .Top         = 214
2744:                 .Left        = 432
2745:                 .Width       = 50
2746:                 .Height      = 50
2747:                 .ButtonCount = 1
2748:                 .BorderStyle = 0
2749:                 .SpecialEffect = 0
2750:             ENDWITH
2751:             WITH loc_oCnt.obj_4c_QuitasVoltar.Buttons(1)
2752:                 .Caption   = "OK"
2753:                 .Width     = 45
2754:                 .Height    = 45
2755:                 .Left      = 2
2756:                 .Top       = 2
2757:                 .Picture   = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
2758:                 .FontName  = "Tahoma"
2759:                 .FontSize  = 8
2760:                 .ForeColor = RGB(90, 90, 90)
2761:             ENDWITH

*-- Linhas 2944 a 2958:
2944:             loc_oGrd.Column7.Width       = 28
2945: 
2946:             *-- Reconfigurar headers (RecordSource os reseta)
2947:             loc_oGrd.Column1.Header1.Caption = "Conta"
2948:             loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2949:             loc_oGrd.Column3.Header1.Caption = "Moeda"
2950:             loc_oGrd.Column4.Header1.Caption = "Saldo"
2951:             loc_oGrd.Column5.Header1.Caption = "Emp"
2952:             loc_oGrd.Column6.Header1.Caption = "CPF/CNPJ"
2953:             loc_oGrd.Column7.Header1.Caption = "M/F"
2954: 
2955:             *-- O DynamicBackColor (matriz verde / filial amarelo) tambem eh
2956:             *-- perdido ao reatribuir RecordSource - reaplicar.
2957:             loc_oGrd.SetAll("DynamicBackColor", ;
2958:                 "IIF(cursor_4c_Saldos.Matriz = 'M', RGB(220,255,220), " + ;

*-- Linhas 3008 a 3016:
3008: 
3009:         TRY
3010:             *-- Mostrar indicador de processamento
3011:             loc_oCnt.lbl_4c_Lb_Aguarde.Visible = .T.
3012:             loc_oCnt.Refresh()
3013: 
3014:             *-- Montar SQL para relatorio
3015:             loc_cSQL = "SELECT a.Emps, a.Grupos, a.Contas, a.Moedas, " + ;
3016:                        "a.Saldos, b.RClis, b.Situas, b.Cpfs, b.ContaMats " + ;

*-- Linhas 3068 a 3076:
3068:             MsgErro(loc_oErro.Message, "Erro em ProcessaSaldo")
3069:         ENDTRY
3070: 
3071:         loc_oCnt.lbl_4c_Lb_Aguarde.Visible = .F.
3072:     ENDPROC
3073: 
3074:     *==========================================================================
3075:     * Handlers de eventos - Pagina SALDO
3076:     *==========================================================================

*-- Linhas 3429 a 3438:
3429:     PROCEDURE BtnProcurarSaldoClick()
3430:         LOCAL loc_oPag
3431:         loc_oPag = THIS.pgf_4c_1.Page1
3432:         loc_oPag.cmd_4c_Cmd_procurar.Enabled  = .F.
3433:         loc_oPag.cmd_4c_Com_Imprimir2.Enabled = .F.
3434:         loc_oPag.obj_4c_Grp_operacao.Enabled  = .F.
3435:         loc_oPag.grd_4c_Saldos.Enabled        = .F.
3436:         loc_oPag.cnt_4c_Consulta.txt_4c__ds_conta.Value = ""
3437:         loc_oPag.cnt_4c_Consulta.Visible      = .T.
3438:         loc_oPag.cnt_4c_Consulta.ZOrder(0)

*-- Linhas 3445 a 3454:
3445:     PROCEDURE BtnImprimirSaldoClick()
3446:         LOCAL loc_oPag
3447:         loc_oPag = THIS.pgf_4c_1.Page1
3448:         loc_oPag.cmd_4c_Cmd_procurar.Enabled  = .F.
3449:         loc_oPag.cmd_4c_Com_Imprimir2.Enabled = .F.
3450:         loc_oPag.obj_4c_Grp_operacao.Enabled  = .F.
3451:         loc_oPag.grd_4c_Saldos.Enabled        = .F.
3452:         loc_oPag.cnt_4c_Saldo.Visible         = .T.
3453:         loc_oPag.cnt_4c_Saldo.ZOrder(0)
3454:         loc_oPag.cnt_4c_Saldo.Refresh()

*-- Linhas 3672 a 3681:
3672:         LOCAL loc_oPag
3673:         loc_oPag = THIS.pgf_4c_1.Page1
3674:         loc_oPag.cnt_4c_Saldo.Visible         = .F.
3675:         loc_oPag.cmd_4c_Cmd_procurar.Enabled  = .T.
3676:         loc_oPag.cmd_4c_Com_Imprimir2.Enabled = .T.
3677:         loc_oPag.obj_4c_Grp_operacao.Enabled  = .T.
3678:         loc_oPag.grd_4c_Saldos.Enabled        = .T.
3679:         loc_oPag.grd_4c_Saldos.SetFocus()
3680:     ENDPROC
3681: 

*-- Linhas 3831 a 3840:
3831: 
3832:         loc_oPag = THIS.pgf_4c_1.Page1
3833: 
3834:         loc_oPag.cmd_4c_Cmd_procurar.Enabled  = .T.
3835:         loc_oPag.cmd_4c_Com_Imprimir2.Enabled = .T.
3836:         loc_oPag.obj_4c_Grp_operacao.Enabled  = .T.
3837:         loc_oPag.grd_4c_Saldos.Enabled        = .T.
3838:         loc_oPag.cnt_4c_Consulta.Visible      = .F.
3839:         loc_oPag.grd_4c_Saldos.SetFocus()
3840:     ENDPROC

*-- Linhas 4787 a 4799:
4787: 
4788:             *-- Habilitar/desabilitar botoes de acao conforme Tipo
4789:             *   Previsao (Tipo='P'): desabilita Concilia/Audita/Quita; habilita Alterar/Excluir
4790:             IF PEMSTATUS(loc_oPagHist, "cmd_4c_Cmd_Alterar", 5)
4791:                 loc_oPagHist.cmd_4c_Cmd_Alterar.Enabled = .T.
4792:             ENDIF
4793:             IF PEMSTATUS(loc_oPagHist, "cmd_4c_Cmd_Excluir", 5)
4794:                 loc_oPagHist.cmd_4c_Cmd_Excluir.Enabled = .T.
4795:             ENDIF
4796:             IF PEMSTATUS(loc_oPagHist, "chk_4c_Concilia", 5)
4797:                 loc_oPagHist.chk_4c_Concilia.Enabled = !loc_lEhPrevisao
4798:             ENDIF
4799:             IF PEMSTATUS(loc_oPagHist, "chk_4c_Auditoria", 5)

*-- Linhas 4822 a 4839:
4822:             loc_oPagHist = THIS.pgf_4c_1.Page2
4823:             DO CASE
4824:                 CASE par_nKeyCode = -2
4825:                     IF PEMSTATUS(loc_oPagHist, "cmd_4c_Cmd_Alterar", 5)
4826:                         IF loc_oPagHist.cmd_4c_Cmd_Alterar.Enabled
4827:                             loc_oPagHist.cmd_4c_Cmd_Alterar.SetFocus()
4828:                             THIS.BtnAlterarHistClick()
4829:                         ENDIF
4830:                     ENDIF
4831:                 CASE par_nKeyCode = -3
4832:                     IF PEMSTATUS(loc_oPagHist, "cmd_4c_Cmd_Excluir", 5)
4833:                         IF loc_oPagHist.cmd_4c_Cmd_Excluir.Enabled
4834:                             loc_oPagHist.cmd_4c_Cmd_Excluir.SetFocus()
4835:                             THIS.BtnExcluirHistClick()
4836:                         ENDIF
4837:                     ENDIF
4838:                 CASE par_nKeyCode = -4
4839:                     THIS.BtnProcuraHistClick()

*-- Linhas 5225 a 5233:
5225:         TRY
5226:             loc_oPagHist = THIS.pgf_4c_1.Page2
5227: 
5228:             *-- Ignorar se checkbox desabilitado ou lancamento provisorio
5229:             IF !PEMSTATUS(loc_oPagHist, "chk_4c_Chk_Concilia", 5)
5230:                 loc_lProsseguir4c = .F.
5231:             ENDIF
5232:             IF loc_lProsseguir4c
5233:                 IF !loc_oPagHist.chk_4c_Chk_Concilia.Enabled

*-- Linhas 5471 a 5479:
5471:         TRY
5472:             loc_oPagHist = THIS.pgf_4c_1.Page2
5473: 
5474:             *-- Ignorar se checkbox desabilitado ou lancamento provisorio
5475:             IF !PEMSTATUS(loc_oPagHist, "chk_4c_Chk_Auditoria", 5)
5476:                 loc_lProsseguir4c = .F.
5477:             ENDIF
5478:             IF loc_lProsseguir4c
5479:                 IF !loc_oPagHist.chk_4c_Chk_Auditoria.Enabled

*-- Linhas 5677 a 5729:
5677: 
5678:                 CASE par_nKeyCode = -2 AND loc_nPagina = 2
5679:                     *-- F3 -> Alterar
5680:                     IF PEMSTATUS(loc_oPagHist, "cmd_4c_Cmd_Alterar", 5) AND ;
5681:                        loc_oPagHist.cmd_4c_Cmd_Alterar.Enabled
5682:                         NODEFAULT
5683:                         THIS.BtnAlterarHistClick()
5684:                     ENDIF
5685: 
5686:                 CASE par_nKeyCode = -3 AND loc_nPagina = 2
5687:                     *-- F4 -> Excluir
5688:                     IF PEMSTATUS(loc_oPagHist, "cmd_4c_Cmd_Excluir", 5) AND ;
5689:                        loc_oPagHist.cmd_4c_Cmd_Excluir.Enabled
5690:                         NODEFAULT
5691:                         THIS.BtnExcluirHistClick()
5692:                     ENDIF
5693: 
5694:                 CASE par_nKeyCode = -5 AND loc_nPagina = 2
5695:                     *-- F6 -> Imprimir (na pagina HIST)
5696:                     IF PEMSTATUS(loc_oPagHist, "cmd_4c_Cmd_impressao", 5) AND ;
5697:                        loc_oPagHist.cmd_4c_Cmd_impressao.Enabled
5698:                         NODEFAULT
5699:                         THIS.BtnImpressaoHistClick()
5700:                     ENDIF
5701: 
5702:                 CASE par_nKeyCode = -6 AND loc_nPagina = 2
5703:                     *-- F7 -> Movimento (Anexa)
5704:                     IF PEMSTATUS(loc_oPagHist, "cmd_4c_Anexa", 5) AND ;
5705:                        loc_oPagHist.cmd_4c_Anexa.Enabled
5706:                         NODEFAULT
5707:                         THIS.BtnAnexaHistClick()
5708:                     ENDIF
5709: 
5710:                 CASE par_nKeyCode = -7 AND loc_nPagina = 2
5711:                     *-- F8 -> Conciliar (toggle checkbox)
5712:                     IF PEMSTATUS(loc_oPagHist, "chk_4c_Chk_Concilia", 5) AND ;
5713:                        loc_oPagHist.chk_4c_Chk_Concilia.Enabled
5714:                         NODEFAULT
5715:                         IF loc_oPagHist.chk_4c_Chk_Concilia.Value = 1
5716:                             loc_oPagHist.chk_4c_Chk_Concilia.Value = 0
5717:                         ELSE
5718:                             loc_oPagHist.chk_4c_Chk_Concilia.Value = 1
5719:                         ENDIF
5720:                         THIS.BtnConciliaHistClick()
5721:                     ENDIF
5722: 
5723:                 CASE par_nKeyCode = 133 AND loc_nPagina = 2
5724:                     *-- F11 -> Auditar (toggle checkbox)
5725:                     IF PEMSTATUS(loc_oPagHist, "chk_4c_Chk_Auditoria", 5) AND ;
5726:                        loc_oPagHist.chk_4c_Chk_Auditoria.Enabled
5727:                         NODEFAULT
5728:                         IF loc_oPagHist.chk_4c_Chk_Auditoria.Value = 1
5729:                             loc_oPagHist.chk_4c_Chk_Auditoria.Value = 0

*-- Linhas 5735 a 5784:
5735: 
5736:                 CASE par_nKeyCode = -8 AND loc_nPagina = 2
5737:                     *-- F9 -> Quitacao (Receber)
5738:                     IF PEMSTATUS(loc_oPagHist, "cmd_4c_Chk_Quitacao", 5) AND ;
5739:                        loc_oPagHist.cmd_4c_Chk_Quitacao.Enabled
5740:                         NODEFAULT
5741:                         THIS.BtnQuitacaoHistClick()
5742:                     ENDIF
5743: 
5744:                 CASE par_nKeyCode = -4 AND loc_nPagina = 2
5745:                     *-- F5 -> Follow-up (Chk_Follow na pagina HIST)
5746:                     IF PEMSTATUS(loc_oPagHist, "cmd_4c_Chk_Follow", 5) AND ;
5747:                        loc_oPagHist.cmd_4c_Chk_Follow.Enabled
5748:                         NODEFAULT
5749:                         THIS.BtnFollowConciliaHistClick()
5750:                     ENDIF
5751: 
5752:                 CASE par_nKeyCode = -1 AND loc_nPagina = 2
5753:                     *-- F2 -> Follow-up Conta
5754:                     IF PEMSTATUS(loc_oPagHist, "cmd_4c_FollowUp", 5) AND ;
5755:                        loc_oPagHist.cmd_4c_FollowUp.Enabled
5756:                         NODEFAULT
5757:                         THIS.BtnFollowUpHistClick()
5758:                     ENDIF
5759: 
5760:                 CASE par_nKeyCode = 95 AND loc_nPagina = 2
5761:                     *-- CTRL+F2 -> Follow-up Lancamento
5762:                     IF PEMSTATUS(loc_oPagHist, "cmd_4c_FollowLancto", 5) AND ;
5763:                        loc_oPagHist.cmd_4c_FollowLancto.Enabled
5764:                         NODEFAULT
5765:                         THIS.BtnFollowUpIHistClick()
5766:                     ENDIF
5767: 
5768:                 CASE par_nKeyCode = -4 AND loc_nPagina = 1
5769:                     *-- F5 -> Procurar (na pagina SALDO)
5770:                     IF PEMSTATUS(loc_oPagSaldo, "cmd_4c_Cmd_procurar", 5) AND ;
5771:                        loc_oPagSaldo.cmd_4c_Cmd_procurar.Enabled
5772:                         NODEFAULT
5773:                         THIS.BtnProcurarSaldoClick()
5774:                     ENDIF
5775: 
5776:                 CASE par_nKeyCode = -5 AND loc_nPagina = 1
5777:                     *-- F6 -> Imprimir (na pagina SALDO)
5778:                     IF PEMSTATUS(loc_oPagSaldo, "cmd_4c_Com_Imprimir2", 5) AND ;
5779:                        loc_oPagSaldo.cmd_4c_Com_Imprimir2.Enabled
5780:                         NODEFAULT
5781:                         THIS.BtnImprimirSaldoClick()
5782:                     ENDIF
5783:             ENDCASE
5784:         CATCH TO loc_oErro

*-- Linhas 5848 a 5868:
5848:             IF PEMSTATUS(loc_oPagHist, "txt_4c_DataConcilia", 5)
5849:                 loc_oPagHist.txt_4c_DataConcilia.Visible = loc_lConcilia
5850:             ENDIF
5851:             IF PEMSTATUS(loc_oPagHist, "lbl_4c_SayData", 5)
5852:                 loc_oPagHist.lbl_4c_SayData.Visible = loc_lConcilia
5853:             ENDIF
5854:             IF PEMSTATUS(loc_oPagHist, "txt_4c_Get3", 5)
5855:                 loc_oPagHist.txt_4c_Get3.Visible = loc_lConcilia
5856:             ENDIF
5857: 
5858:             *-- Habilitar/desabilitar controles de auditoria
5859:             IF PEMSTATUS(loc_oPagHist, "chk_4c_Chk_Auditoria", 5)
5860:                 loc_oPagHist.chk_4c_Chk_Auditoria.Enabled = loc_lAudita
5861:             ENDIF
5862:             IF PEMSTATUS(loc_oPagHist, "lbl_4c_LblAuditoria", 5)
5863:                 loc_oPagHist.lbl_4c_LblAuditoria.Visible = loc_lAudita
5864:             ENDIF
5865:             IF PEMSTATUS(loc_oPagHist, "txt_4c_DtAudits", 5)
5866:                 loc_oPagHist.txt_4c_DtAudits.Visible = loc_lAudita
5867:             ENDIF
5868:             IF PEMSTATUS(loc_oPagHist, "txt_4c_Auditors", 5)

*-- Linhas 6406 a 6418:
6406:             IF PEMSTATUS(loc_oPag1, "obj_4c_Grp_operacao", 5)
6407:                 loc_oPag1.obj_4c_Grp_operacao.Enabled = loc_lHab
6408:             ENDIF
6409:             IF PEMSTATUS(loc_oPag1, "cmd_4c_Cmd_procurar", 5)
6410:                 loc_oPag1.cmd_4c_Cmd_procurar.Enabled = loc_lHab
6411:             ENDIF
6412:             IF PEMSTATUS(loc_oPag1, "cmd_4c_Com_Imprimir2", 5)
6413:                 loc_oPag1.cmd_4c_Com_Imprimir2.Enabled = loc_lHab
6414:             ENDIF
6415:             IF PEMSTATUS(loc_oPag1, "grd_4c_Dados", 5)
6416:                 loc_oPag1.grd_4c_Dados.Enabled = loc_lHab
6417:             ENDIF
6418: 

*-- Linhas 6444 a 6490:
6444:             ENDIF
6445: 
6446:             *-- Botoes de acao da pagina HIST
6447:             IF PEMSTATUS(loc_oPag2, "cmd_4c_Cmd_Consulta", 5)
6448:                 loc_oPag2.cmd_4c_Cmd_Consulta.Enabled = loc_lTemRegistro AND loc_lNaoProvisorio
6449:             ENDIF
6450:             IF PEMSTATUS(loc_oPag2, "cmd_4c_Cmd_Alterar", 5)
6451:                 loc_oPag2.cmd_4c_Cmd_Alterar.Enabled = loc_lTemRegistro AND loc_lNaoProvisorio
6452:             ENDIF
6453:             IF PEMSTATUS(loc_oPag2, "cmd_4c_Cmd_Excluir", 5)
6454:                 loc_oPag2.cmd_4c_Cmd_Excluir.Enabled = loc_lTemRegistro AND loc_lNaoProvisorio
6455:             ENDIF
6456:             IF PEMSTATUS(loc_oPag2, "cmd_4c_Cmd_impressao", 5)
6457:                 loc_oPag2.cmd_4c_Cmd_impressao.Enabled = loc_lTemRegistro
6458:             ENDIF
6459:             IF PEMSTATUS(loc_oPag2, "cmd_4c_Anexa", 5)
6460:                 loc_oPag2.cmd_4c_Anexa.Enabled = loc_lTemRegistro AND loc_lNaoProvisorio
6461:             ENDIF
6462:             IF PEMSTATUS(loc_oPag2, "cmd_4c_Chk_Quitacao", 5)
6463:                 loc_oPag2.cmd_4c_Chk_Quitacao.Enabled = loc_lTemRegistro AND loc_lNaoProvisorio
6464:             ENDIF
6465:             IF PEMSTATUS(loc_oPag2, "cmd_4c_Chk_Follow", 5)
6466:                 loc_oPag2.cmd_4c_Chk_Follow.Enabled = loc_lTemRegistro AND loc_lNaoProvisorio
6467:             ENDIF
6468:             IF PEMSTATUS(loc_oPag2, "cmd_4c_FollowUp", 5)
6469:                 loc_oPag2.cmd_4c_FollowUp.Enabled = loc_lTemRegistro
6470:             ENDIF
6471:             IF PEMSTATUS(loc_oPag2, "cmd_4c_FollowLancto", 5)
6472:                 loc_oPag2.cmd_4c_FollowLancto.Enabled = loc_lTemRegistro AND loc_lNaoProvisorio
6473:             ENDIF
6474:             IF PEMSTATUS(loc_oPag2, "cmd_4c_Procura", 5)
6475:                 loc_oPag2.cmd_4c_Procura.Enabled = loc_lTemRegistro
6476:             ENDIF
6477: 
6478:             *-- CheckBoxes de conciliacao e auditoria: habilitados conforme acesso
6479:             IF PEMSTATUS(loc_oPag2, "chk_4c_Chk_Concilia", 5)
6480:                 loc_oPag2.chk_4c_Chk_Concilia.Enabled = loc_lTemRegistro AND loc_lNaoProvisorio
6481:             ENDIF
6482:             IF PEMSTATUS(loc_oPag2, "chk_4c_Chk_Auditoria", 5)
6483:                 loc_oPag2.chk_4c_Chk_Auditoria.Enabled = loc_lTemRegistro AND loc_lNaoProvisorio
6484:             ENDIF
6485: 
6486:         CATCH TO loc_oErro
6487:             MsgErro(loc_oErro.Message, "Erro em AjustarBotoesPorModo")
6488:         ENDTRY
6489:     ENDPROC
6490: 

*-- Linhas 6505 a 6521:
6505:             IF VARTYPE(par_oGrid) = "O" AND par_oGrid.ColumnCount >= 11
6506:                 loc_oCol = par_oGrid.Column11
6507: 
6508:                 *-- O CheckBox pode ter sido destruido junto com a Column
6509:                 IF !PEMSTATUS(loc_oCol, "chk_4c_Selec", 5)
6510:                     loc_oCol.AddObject("chk_4c_Selec", "CheckBox")
6511:                     WITH loc_oCol.chk_4c_Selec
6512:                         .Top       = 23
6513:                         .Left      = 4
6514:                         .Width     = 60
6515:                         .Height    = 17
6516:                         .Caption   = ""
6517:                         .Value     = 0
6518:                         .FontName  = "Tahoma"
6519:                         .Alignment = 0
6520:                         .ReadOnly  = .F.
6521:                         .BackStyle = 0

*-- Linhas 6541 a 6549:
6541:                 loc_oCol.ReadOnly       = .F.
6542: 
6543:                 WITH loc_oCol.Header1
6544:                     .Caption     = ""
6545:                     .Alignment   = 2
6546:                     .Picture     = gc_4c_CaminhoIcones + "CHECKBX.BMP"
6547:                     .ToolTipText = "Marca/Desmarca todos"
6548:                 ENDWITH
6549:             ENDIF


### BO (C:\4c\projeto\app\classes\sigopindBO.prg):
*==============================================================================
* sigopindBO.prg - Business Object para Contas Correntes Individuais (SIGOPIND)
* Herda de: BusinessBase
* Fase 1/8: Propriedades e Init()
*==============================================================================

DEFINE CLASS sigopindBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Identificacao da tabela principal
    *--------------------------------------------------------------------------
    this_cTabela     = "SigMvSlc"
    this_cCampoChave = "Contas"

    *--------------------------------------------------------------------------
    * Propriedades de contexto operacional do formulario
    *--------------------------------------------------------------------------
    this_cGrupoOper    = ""    && Grupo de conta corrente selecionado
    this_cCliente      = ""    && Codigo do cliente/conta selecionada
    this_dDataConcilia = {}    && Data de conciliacao em andamento
    this_lMatrizes     = .F.   && Flag: eh matriz (go_4c_Sistema.Matrizes)
    this_cOperacao     = ""    && Operacao corrente (CONSULTA, ALTERAR, etc.)
    this_cUsuario      = ""    && Usuario logado corrente

    *--------------------------------------------------------------------------
    * Propriedades de SigMvSlc (saldos por conta/moeda)
    *--------------------------------------------------------------------------
    this_cEmps       = ""      && Empresa
    this_cGrupos     = ""      && Grupo de conta corrente
    this_cContas     = ""      && Codigo da conta (cliente)
    this_cMoedas     = ""      && Codigo da moeda
    this_nSaldos     = 0       && Saldo atual
    this_cRClis      = ""      && Razao social do cliente
    this_cSituas     = ""      && Situacao do cliente
    this_cCpfs       = ""      && CPF/CNPJ do cliente
    this_cContaMats  = ""      && Conta matriz

    *--------------------------------------------------------------------------
    * Propriedades de SigCdCli (dados do cliente)
    *--------------------------------------------------------------------------
    this_cIClis          = ""   && Codigo interno do cliente
    this_nConcilias      = 0    && Flag: aceita conciliacao
    this_nCanAudits      = 0    && Flag: pode auditar

    *--------------------------------------------------------------------------
    * Propriedades de SigMvCcr (lancamentos/historico)
    *--------------------------------------------------------------------------
    this_cLancEmps      = ""    && Empresa do lancamento
    this_cDopes         = ""    && Documento/operacao
    this_nNumes         = 0     && Numero do lancamento
    this_nNopers        = 0     && Numero da operacao
    this_cVOpers        = ""    && Valor/numero operacao complementar
    this_cOpers         = ""    && Identificador de operacao
    this_cDopcs         = ""    && Documento contra-partida
    this_nNumcs         = 0     && Numero da contra-partida
    this_dDatas         = {}    && Data do lancamento
    this_nSaldosCcr     = 0     && Saldo do lancamento
    this_cHists         = ""    && Historico do lancamento
    this_lConcs         = .F.   && Conciliado?
    this_cUsuConcs      = ""    && Usuario que conciliou
    this_cAuditors      = ""    && Auditor
    this_dDtAudits      = {}    && Data de auditoria
    this_cTipo          = ""    && Tipo do lancamento (P=provisorio, etc.)
    this_cSGrupos       = ""    && Sub-grupo do lancamento

    *--------------------------------------------------------------------------
    * Propriedades de filtro do painel Saldo (cntSaldo / ProcessaSaldo)
    *--------------------------------------------------------------------------
    this_cMoedaCodFiltro   = ""  && Codigo da moeda para filtro saldo
    this_cMoedaDescFiltro  = ""  && Descricao da moeda para filtro saldo
    this_dDataLimiteFiltro = {}  && Data limite para filtro saldo
    this_nOrdemFiltro      = 1   && Ordem: 1=Nome 2=Codigo 3=Saldo
    this_lAscendente       = .F. && Ordenacao ascendente?
    this_cSituacaoFiltro   = ""  && Codigo da situacao para filtro
    this_lImprimeSaldoZero = .F. && Imprimir contas com saldo zero?
    this_nOptFiltro        = 1   && Opcao do optFiltro (1=Todos 2=Devedor 3=Credor)

    *--------------------------------------------------------------------------
    * Propriedades de filtro do historico (cntImprime / ProcessaHist)
    *--------------------------------------------------------------------------
    this_dDtInicial       = {}   && Data inicial do historico
    this_dDtFinal         = {}   && Data final do historico
    this_cMoedaHistCod    = ""   && Codigo da moeda para historico
    this_cMoedaHistDesc   = ""   && Descricao da moeda para historico
    this_cEmpsCod         = ""   && Codigo da empresa para historico
    this_cEmpsDesc        = ""   && Descricao da empresa para historico
    this_cGetOper         = ""   && D/C (debito/credito) para filtro
    this_nCmbConcilia     = 0    && Opcao do combobox de conciliacao
    this_lChkGrupo        = .F.  && Todas as contas do grupo?
    this_lCheckSalto      = .F.  && Quebra pagina por conta?
    this_lCheckSAnt       = .F.  && Sem saldo anterior?
    this_lCheckRazaoCP    = .F.  && Relacao com contrapartida?
    this_lCheckRazaoDoc   = .F.  && Relacao com documento?
    this_lCheckComissao   = .F.  && Incluir comissao?
    this_lCheckSaldoa     = .F.  && Sem saldo?
    this_lChkTaxas        = .F.  && Incluir taxas?
    this_lChkRelDets      = .F.  && Relacao detalhada?
    this_nOptSNA          = 1    && Opcao S/N/A (1=S, 2=N, 3=A)
    this_lChkOcultaCta    = .F.  && Ocultar descricao da conta?

    *--------------------------------------------------------------------------
    * Propriedades de periodos padroes da grade Saldo
    *--------------------------------------------------------------------------
    this_dDataInicialSaldo = {}   && Data inicial do filtro de periodo saldo
    this_dDataFinalSaldo   = {}   && Data final do filtro de periodo saldo

    *--------------------------------------------------------------------------
    * Propriedades para busca de conta (cntConsulta)
    *--------------------------------------------------------------------------
    this_cCdContaBusca  = ""    && Codigo da conta digitado para busca
    this_cDsContaBusca  = ""    && Descricao da conta digitado para busca

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigMvSlc"
            THIS.this_cCampoChave = "Contas"

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE ObterChavePrimaria()
    *==========================================================================
    *-- Retorna a chave primaria do registro corrente
        RETURN THIS.this_cContas
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *==========================================================================
    *-- Carrega propriedades do BO a partir do cursor combinado (SigMvSlc + SigCdCli)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cEmps      = TratarNulo(Emps, "C")
                THIS.this_cGrupos    = TratarNulo(Grupos, "C")
                THIS.this_cContas    = TratarNulo(Contas, "C")
                THIS.this_cMoedas    = TratarNulo(Moedas, "C")
                THIS.this_nSaldos    = TratarNulo(Saldos, "N")
                THIS.this_cRClis     = TratarNulo(RClis, "C")
                THIS.this_cSituas    = TratarNulo(Situas, "C")
                THIS.this_cCpfs      = TratarNulo(Cpfs, "C")
                THIS.this_cContaMats = TratarNulo(ContaMats, "C")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE Inserir()
    *==========================================================================
    *-- Form OPERACIONAL: insercoes sao feitas via lancamentos contabeis externos
        RETURN .F.
    ENDPROC

    *==========================================================================
    PROCEDURE Atualizar()
    *==========================================================================
    *-- Atualiza conciliacao/auditoria do lancamento corrente em SigMvCcr
        LOCAL loc_lResultado, loc_cSQL, loc_nRet
        loc_lResultado = .F.
        TRY
            IF gnConnHandle <= 0
                MsgErro("Sem conex" + CHR(227) + "o com o banco de dados.", "Erro")
                loc_lResultado = loc_lResultado
            ENDIF

            loc_cSQL = "UPDATE SigMvCcr SET " + ;
                       "Concs = " + IIF(THIS.this_lConcs, "1", "0") + ", " + ;
                       "Usuconcs = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ", " + ;
                       "Dataconcs = " + FormatarDataSQL(THIS.this_dDataConcilia) + ", " + ;
                       "Auditors = " + EscaparSQL(ALLTRIM(THIS.this_cAuditors)) + ", " + ;
                       "DtAudits = " + FormatarDataSQL(THIS.this_dDtAudits) + " " + ;
                       "WHERE Nopers = " + FormatarNumeroSQL(THIS.this_nNopers) + ;
                       " AND Emps = " + EscaparSQL(ALLTRIM(THIS.this_cLancEmps))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet < 1
                MsgErro("Erro ao atualizar registro.", "Erro")
            ELSE
                THIS.RegistrarAuditoria("A")
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
    *==========================================================================
    *-- Exclui todos os lancamentos da operacao (corrente + contra-partida) em SigMvCcr
        LOCAL loc_lResultado, loc_cSQL, loc_nRet
        loc_lResultado = .F.
        TRY
            IF gnConnHandle <= 0
                MsgErro("Sem conex" + CHR(227) + "o com o banco de dados.", "Erro")
                loc_lResultado = loc_lResultado
            ENDIF

            loc_cSQL = "DELETE FROM SigMvCcr " + ;
                       "WHERE Nopers = " + FormatarNumeroSQL(THIS.this_nNopers) + ;
                       " AND Emps = " + EscaparSQL(ALLTRIM(THIS.this_cLancEmps))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet < 1
                MsgErro("Erro ao excluir lan" + CHR(231) + "amento.", "Erro")
            ELSE
                THIS.RegistrarAuditoria("E")
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE Excluir()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF MsgConfirma("Confirma a exclus" + CHR(227) + "o deste lan" + ;
                           CHR(231) + "amento?", "Confirma" + CHR(231) + CHR(227) + "o")
                loc_lResultado = THIS.ExecutarExclusao()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE MontaGrade(par_cGrupo, par_nOptFiltro)
    *==========================================================================
    *-- Carrega cursor_4c_Saldos com dados de SigMvSlc + SigCdCli por grupo
    *-- par_cGrupo    : codigo do grupo de conta corrente
    *-- par_nOptFiltro: 1=Todos  2=Devedores(Saldo>0)  3=Credores(Saldo<0)
        LOCAL loc_lResultado, loc_cSQL, loc_nRet, loc_cFiltroSaldo
        loc_lResultado = .F.
        TRY
            IF gnConnHandle <= 0
                loc_lResultado = loc_lResultado
            ENDIF

            IF EMPTY(ALLTRIM(par_cGrupo))
                loc_lResultado = loc_lResultado
            ENDIF

            *-- Filtro de saldo conforme opcao selecionada
            DO CASE
                CASE par_nOptFiltro = 2
                    loc_cFiltroSaldo = " AND a.Saldos > 0"
                CASE par_nOptFiltro = 3
                    loc_cFiltroSaldo = " AND a.Saldos < 0"
                OTHERWISE
                    loc_cFiltroSaldo = ""
            ENDCASE

            *-- Consulta principal: saldos por conta/moeda do grupo
            loc_cSQL = "SELECT a.Emps, a.Grupos, a.Contas, a.Moedas, a.Saldos, " + ;
                       "b.RClis, b.Situas, b.Cpfs, b.ContaMats, " + ;
                       "CAST(' ' AS CHAR(1)) AS Matriz " + ;
                       "FROM SigMvSlc a " + ;
                       "INNER JOIN SigCdCli b ON a.Contas = b.IClis " + ;
                       "WHERE a.Grupos = " + EscaparSQL(ALLTRIM(par_cGrupo)) + ;
                       loc_cFiltroSaldo + ;
                       " ORDER BY a.Contas, a.Moedas"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SaldosTemp")
            IF loc_nRet < 1
                MsgErro("Erro ao carregar saldos do grupo.", "Erro")
                loc_lResultado = loc_lResultado
            ENDIF

            *-- Transferir para cursor permanente do grid (protege colunas)
            SELECT cursor_4c_Saldos
            ZAP
            IF RECCOUNT("cursor_4c_SaldosTemp") > 0
                APPEND FROM DBF("cursor_4c_SaldosTemp")
            ENDIF
            IF USED("cursor_4c_SaldosTemp")
                USE IN cursor_4c_SaldosTemp
            ENDIF

            GO TOP IN cursor_4c_Saldos
            loc_lResultado = .T.

        CATCH TO loc_oErro
            IF USED("cursor_4c_SaldosTemp")
                USE IN cursor_4c_SaldosTemp
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE BuscarHistorico(par_cGrupo, par_cConta, par_cMoeda, ;
                                     par_dDataI, par_dDataF, ;
                                     par_cEmp, par_nCmbConcilia)
    *==========================================================================
    *-- Carrega CrSigMvCcr com lancamentos de SigMvCcr
    *-- par_cGrupo      : grupo conta corrente
    *-- par_cConta      : conta (codigo do cliente)
    *-- par_cMoeda      : moeda
    *-- par_dDataI/F    : intervalo de datas
    *-- par_cEmp        : empresa (vazio = todas as empresas)
    *-- par_nCmbConcilia: 0=Todos  1=N" + CHR(227) + "o conciliados  2=Conciliados
        LOCAL loc_lResultado, loc_cSQL, loc_nRet
        LOCAL loc_cGruConMoe, loc_cFiltroEmp
        loc_lResultado = .F.
        TRY
            IF gnConnHandle <= 0
                loc_lResultado = loc_lResultado
            ENDIF

            *-- Chave composta gruconmoes: grupo(10) + conta(10) + moeda(3) = 23
            loc_cGruConMoe = PADR(ALLTRIM(par_cGrupo), 10) + ;
                             PADR(ALLTRIM(par_cConta), 10) + ;
                             PADR(ALLTRIM(par_cMoeda), 3)

            *-- Filtro de empresa
            loc_cFiltroEmp = ""
            IF !EMPTY(ALLTRIM(par_cEmp))
                loc_cFiltroEmp = " AND a.Emps = " + EscaparSQL(ALLTRIM(par_cEmp))
            ENDIF

            *-- Consulta de lancamentos da conta no periodo (todos os registros)
            *-- Filtro de conciliacao aplicado localmente apos carga (como no original)
            loc_cSQL = "SELECT a.Emps, a.Grupos, a.Contas, a.Moedas, " + ;
                       "a.Datas, a.Dataconcs, a.Hists, a.Hist2s, a.Valors, a.Saldos, " + ;
                       "a.Opers, a.Nopers, a.Numes, a.Dopes, a.Dopcs, a.Numcs, " + ;
                       "a.Concs, a.Usuconcs, a.Usualts, a.Auditors, a.DtAudits, " + ;
                       "a.Tipos, a.Vopers, a.Titulos, a.Nfs, a.Docus, " + ;
                       "a.Empos, a.SGrupos, a.Nlancs, a.GruConMoes, " + ;
                       "a.CidChaves, a.EmpCCs, a.Pagos, a.TitCancs, " + ;
                       "a.Jobs, a.Saldocs, " + ;
                       "b.RClis, b.Situas, b.Concilias " + ;
                       "FROM SigMvCcr a " + ;
                       "INNER JOIN SigCdCli b ON a.Contas = b.IClis " + ;
                       "WHERE a.GruConMoes = " + EscaparSQL(loc_cGruConMoe) + ;
                       " AND a.Datas >= " + FormatarDataSQL(par_dDataI) + ;
                       " AND a.Datas < DATEADD(day, 1, " + FormatarDataSQL(par_dDataF) + ")" + ;
                       loc_cFiltroEmp + ;
                       " ORDER BY a.Datas, a.Nopers"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigMvCcrTemp")
            IF loc_nRet < 1
                MsgErro("Erro ao carregar hist" + CHR(243) + "rico.", "Erro")
                loc_lResultado = loc_lResultado
            ENDIF

            *-- Transferir para cursor permanente do grid (protege colunas)
            SELECT CrSigMvCcr
            ZAP
            IF RECCOUNT("CrSigMvCcrTemp") > 0
                APPEND FROM DBF("CrSigMvCcrTemp")
            ENDIF
            IF USED("CrSigMvCcrTemp")
                USE IN CrSigMvCcrTemp
            ENDIF

            *-- Aplicar filtro de conciliacao localmente (como no original: Delete Where Concs)
            SELECT CrSigMvCcr
            DO CASE
                CASE par_nCmbConcilia = 1
                    SET FILTER TO !Concs
                CASE par_nCmbConcilia = 2
                    SET FILTER TO Concs
                OTHERWISE
                    SET FILTER TO
            ENDCASE

            GO TOP IN CrSigMvCcr
            loc_lResultado = .T.

        CATCH TO loc_oErro
            IF USED("CrSigMvCcrTemp")
                USE IN CrSigMvCcrTemp
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE AtualizarConciliacao(par_lConciliar, par_nNopers, ;
                                          par_cEmps, par_dDataConc)
    *==========================================================================
    *-- Concilia ou desconcilia todos os lancamentos de uma operacao
    *-- par_lConciliar: .T. = conciliar  .F. = desconciliar
    *-- par_nNopers   : numero da operacao (identifica todos os lancamentos)
    *-- par_cEmps     : empresa
    *-- par_dDataConc : data de conciliacao (usada ao conciliar)
        LOCAL loc_lResultado, loc_cSQL, loc_nRet
        LOCAL loc_cConcs, loc_cUsConcs, loc_cDataConcs
        loc_lResultado = .F.
        TRY
            IF gnConnHandle <= 0
                MsgErro("Sem conex" + CHR(227) + "o com o banco de dados.", "Erro")
                loc_lResultado = loc_lResultado
            ENDIF

            IF par_lConciliar
                loc_cConcs     = "1"
                loc_cUsConcs   = EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado))
                loc_cDataConcs = FormatarDataSQL(par_dDataConc)
            ELSE
                loc_cConcs     = "0"
                loc_cUsConcs   = EscaparSQL("")
                loc_cDataConcs = "NULL"
            ENDIF

            *-- Atualiza todos os lancamentos da operacao (corrente + contra-partida)
            loc_cSQL = "UPDATE SigMvCcr SET " + ;
                       "Concs = " + loc_cConcs + ", " + ;
                       "Usuconcs = " + loc_cUsConcs + ", " + ;
                       "Dataconcs = " + loc_cDataConcs + " " + ;
                       "WHERE Nopers = " + FormatarNumeroSQL(par_nNopers) + ;
                       " AND Emps = " + EscaparSQL(ALLTRIM(par_cEmps))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet < 1
                MsgErro("Erro ao atualizar concilia" + CHR(231) + CHR(227) + "o.", "Erro")
            ELSE
                THIS.this_nNopers    = par_nNopers
                THIS.this_cLancEmps  = par_cEmps
                THIS.this_lConcs     = par_lConciliar
                THIS.RegistrarAuditoria("A")
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE AtualizarAuditoria(par_lAuditar, par_nNopers, par_cEmps)
    *==========================================================================
    *-- Audita ou desaudita todos os lancamentos de uma operacao
    *-- par_lAuditar: .T. = auditar  .F. = desauditar
    *-- par_nNopers : numero da operacao
    *-- par_cEmps   : empresa
        LOCAL loc_lResultado, loc_cSQL, loc_nRet
        LOCAL loc_cAuditors, loc_cDtAudits
        loc_lResultado = .F.
        TRY
            IF gnConnHandle <= 0
                MsgErro("Sem conex" + CHR(227) + "o com o banco de dados.", "Erro")
                loc_lResultado = loc_lResultado
            ENDIF

            IF par_lAuditar
                loc_cAuditors = EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado))
                loc_cDtAudits = FormatarDataSQL(DATE())
            ELSE
                loc_cAuditors = EscaparSQL("")
                loc_cDtAudits = "NULL"
            ENDIF

            loc_cSQL = "UPDATE SigMvCcr SET " + ;
                       "Auditors = " + loc_cAuditors + ", " + ;
                       "DtAudits = " + loc_cDtAudits + " " + ;
                       "WHERE Nopers = " + FormatarNumeroSQL(par_nNopers) + ;
                       " AND Emps = " + EscaparSQL(ALLTRIM(par_cEmps))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet < 1
                MsgErro("Erro ao atualizar auditoria.", "Erro")
            ELSE
                THIS.this_nNopers   = par_nNopers
                THIS.this_cLancEmps = par_cEmps
                THIS.RegistrarAuditoria("A")
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarDadosCliente(par_cICli)
    *==========================================================================
    *-- Carrega dados de SigCdCli para propriedades do BO
        LOCAL loc_lResultado, loc_cSQL, loc_nRet
        loc_lResultado = .F.
        TRY
            IF gnConnHandle <= 0
                loc_lResultado = loc_lResultado
            ENDIF

            IF EMPTY(ALLTRIM(par_cICli))
                loc_lResultado = loc_lResultado
            ENDIF

            loc_cSQL = "SELECT IClis, RClis, Concilias " + ;
                       "FROM SigCdCli " + ;
                       "WHERE IClis = " + EscaparSQL(ALLTRIM(par_cICli))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliTemp")
            IF loc_nRet >= 1
                SELECT cursor_4c_CliTemp
                IF !EOF()
                    THIS.this_cIClis     = TratarNulo(IClis, "C")
                    THIS.this_cRClis     = TratarNulo(RClis, "C")
                    THIS.this_nConcilias = TratarNulo(Concilias, "N")
                    loc_lResultado = .T.
                ENDIF
            ENDIF

            IF USED("cursor_4c_CliTemp")
                USE IN cursor_4c_CliTemp
            ENDIF

        CATCH TO loc_oErro
            IF USED("cursor_4c_CliTemp")
                USE IN cursor_4c_CliTemp
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarLancamento(par_cEmps, par_nNopers)
    *==========================================================================
    *-- Carrega dados de SigMvCcr para propriedades do BO pelo numero da operacao
        LOCAL loc_lResultado, loc_cSQL, loc_nRet
        loc_lResultado = .F.
        TRY
            IF gnConnHandle <= 0
                loc_lResultado = loc_lResultado
            ENDIF

            loc_cSQL = "SELECT Emps, Grupos, Contas, Moedas, Datas, Dataconcs, " + ;
                       "Hists, Valors, Saldos, Opers, Nopers, Numes, Dopes, " + ;
                       "Dopcs, Numcs, Concs, Usuconcs, Auditors, DtAudits, " + ;
                       "Tipos, Vopers, Empos, SGrupos " + ;
                       "FROM SigMvCcr " + ;
                       "WHERE Emps = " + EscaparSQL(ALLTRIM(par_cEmps)) + ;
                       " AND Nopers = " + FormatarNumeroSQL(par_nNopers) + ;
                       " ORDER BY Nopers"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LancTemp")
            IF loc_nRet >= 1
                SELECT cursor_4c_LancTemp
                IF !EOF()
                    THIS.this_cLancEmps  = TratarNulo(Emps, "C")
                    THIS.this_cGrupos    = TratarNulo(Grupos, "C")
                    THIS.this_cContas    = TratarNulo(Contas, "C")
                    THIS.this_cMoedas    = TratarNulo(Moedas, "C")
                    THIS.this_dDatas     = TratarNulo(Datas, "D")
                    THIS.this_cHists     = TratarNulo(Hists, "C")
                    THIS.this_nSaldosCcr = TratarNulo(Saldos, "N")
                    THIS.this_cOpers     = TratarNulo(Opers, "C")
                    THIS.this_nNopers    = TratarNulo(Nopers, "N")
                    THIS.this_nNumes     = TratarNulo(Numes, "N")
                    THIS.this_cDopes     = TratarNulo(Dopes, "C")
                    THIS.this_cDopcs     = TratarNulo(Dopcs, "C")
                    THIS.this_nNumcs     = TratarNulo(Numcs, "N")
                    THIS.this_lConcs     = (TratarNulo(Concs, "N") = 1)
                    THIS.this_cUsuConcs  = TratarNulo(Usuconcs, "C")
                    THIS.this_cAuditors  = TratarNulo(Auditors, "C")
                    THIS.this_dDtAudits  = TratarNulo(DtAudits, "D")
                    THIS.this_cTipo      = TratarNulo(Tipos, "C")
                    THIS.this_cVOpers    = TratarNulo(Vopers, "C")
                    THIS.this_cSGrupos   = TratarNulo(SGrupos, "C")
                    loc_lResultado = .T.
                ENDIF
            ENDIF

            IF USED("cursor_4c_LancTemp")
                USE IN cursor_4c_LancTemp
            ENDIF

        CATCH TO loc_oErro
            IF USED("cursor_4c_LancTemp")
                USE IN cursor_4c_LancTemp
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE ProcessaSaldo(par_cTipo, par_cGrupo, par_cMoeda, ;
                                   par_nOrdem, par_lAscendente, par_cSitua, ;
                                   par_nOptFiltro, par_lImprimeSaldoZero)
    *==========================================================================
    *-- Gera relatorio de Saldos de Conta Corrente
    *-- par_cTipo          : 'I'=Impressora  'V'=Video/Preview  'E'=Excel
    *-- par_cGrupo         : codigo do grupo
    *-- par_cMoeda         : codigo da moeda (vazio = todas)
    *-- par_nOrdem         : 1=Nome  2=Codigo  3=Saldo
    *-- par_lAscendente    : .T. = ascendente
    *-- par_cSitua         : codigo da situacao (vazio = todas)
    *-- par_nOptFiltro     : 1=Todos  2=Devedores  3=Credores
    *-- par_lImprimeSaldoZero: .T. = inclui contas com saldo zero
        LOCAL loc_lResultado, loc_cSQL, loc_nRet
        LOCAL loc_cFiltroMoeda, loc_cFiltroSitua, loc_cFiltroSaldo
        LOCAL loc_cOrdem, loc_cDirecao, loc_cArqRel, loc_cSaida
        loc_lResultado = .F.
        TRY
            IF gnConnHandle <= 0
                MsgErro("Sem conex" + CHR(227) + "o com o banco de dados.", "Erro")
                loc_lResultado = loc_lResultado
            ENDIF

            *-- Filtros opcionais
            loc_cFiltroMoeda = ""
            IF !EMPTY(ALLTRIM(par_cMoeda))
                loc_cFiltroMoeda = " AND a.Moedas = " + EscaparSQL(ALLTRIM(par_cMoeda))
            ENDIF

            loc_cFiltroSitua = ""
            IF !EMPTY(ALLTRIM(par_cSitua))
                loc_cFiltroSitua = " AND b.Situas = " + EscaparSQL(ALLTRIM(par_cSitua))
            ENDIF

            DO CASE
                CASE par_nOptFiltro = 2
                    loc_cFiltroSaldo = " AND a.Saldos > 0"
                CASE par_nOptFiltro = 3
                    loc_cFiltroSaldo = " AND a.Saldos < 0"
                OTHERWISE
                    loc_cFiltroSaldo = IIF(!par_lImprimeSaldoZero, " AND a.Saldos <> 0", "")
            ENDCASE

            *-- Criterio de ordenacao
            DO CASE
                CASE par_nOrdem = 2
                    loc_cOrdem = "a.Contas"
                CASE par_nOrdem = 3
                    loc_cOrdem = "a.Saldos"
                OTHERWISE
                    loc_cOrdem = "b.RClis"
            ENDCASE
            loc_cDirecao = IIF(par_lAscendente, " ASC", " DESC")

            loc_cSQL = "SELECT a.Emps, a.Grupos, a.Contas, a.Moedas, a.Saldos, " + ;
                       "b.RClis, b.Situas, b.Cpfs, b.ContaMats " + ;
                       "FROM SigMvSlc a " + ;
                       "INNER JOIN SigCdCli b ON a.Contas = b.IClis " + ;
                       "WHERE a.Grupos = " + EscaparSQL(ALLTRIM(par_cGrupo)) + ;
                       loc_cFiltroMoeda + loc_cFiltroSitua + loc_cFiltroSaldo + ;
                       " ORDER BY " + loc_cOrdem + loc_cDirecao

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RelSaldo")
            IF loc_nRet < 1
                MsgErro("Erro ao gerar dados do relat" + CHR(243) + "rio.", "Erro")
                loc_lResultado = loc_lResultado
            ENDIF

            *-- Definir tipo de saida e arquivo
            loc_cArqRel = gc_4c_CaminhoReports + "RelSigOpIndSaldo.frx"
            DO CASE
                CASE par_cTipo = "I"
                    loc_cSaida = "TO PRINTER PROMPT NOCONSOLE"
                CASE par_cTipo = "E"
                    loc_cSaida = "TO FILE " + gc_4c_CaminhoBase + "RelSaldo.xls TYPE XL5 PROMPT NOCONSOLE"
                OTHERWISE
                    loc_cSaida = "PREVIEW NOCONSOLE"
            ENDCASE

            REPORT FORM (loc_cArqRel) &loc_cSaida

            IF USED("cursor_4c_RelSaldo")
                USE IN cursor_4c_RelSaldo
            ENDIF

            loc_lResultado = .T.

        CATCH TO loc_oErro
            IF USED("cursor_4c_RelSaldo")
                USE IN cursor_4c_RelSaldo
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE ProcessaHist(par_cTipo, par_cGrupo, par_cConta, ;
                                  par_cMoeda, par_dDataI, par_dDataF, ;
                                  par_cEmp, par_cGetOper, par_nCmbConcilia, ;
                                  par_lChkGrupo, par_lCheckSalto, ;
                                  par_lCheckSAnt, par_lCheckRazaoCP, ;
                                  par_lCheckRazaoDoc, par_lCheckComissao, ;
                                  par_lCheckSaldoa, par_lChkTaxas, ;
                                  par_lChkRelDets, par_nOptSNA, ;
                                  par_lChkOcultaCta)
    *==========================================================================
    *-- Gera relatorio de Historico de Conta Corrente
    *-- par_cTipo    : 'I'=Impressora  'V'=Video/Preview  'E'=Excel
    *-- par_lChkGrupo: .T. = todas as contas do grupo / .F. = conta individual
        LOCAL loc_lResultado, loc_cSQL, loc_nRet
        LOCAL loc_cGruConMoe, loc_cFiltroEmp, loc_cFiltroOper
        LOCAL loc_cEscopo, loc_cArqRel, loc_cSaida
        loc_lResultado = .F.
        TRY
            IF gnConnHandle <= 0
                MsgErro("Sem conex" + CHR(227) + "o com o banco de dados.", "Erro")
                loc_lResultado = loc_lResultado
            ENDIF

            *-- Validacoes obrigatorias
            IF EMPTY(ALLTRIM(par_cMoeda))
                MsgAviso("A Moeda N" + CHR(227) + "o Foi Informada!!!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = loc_lResultado
            ENDIF
            IF EMPTY(par_dDataI)
                MsgAviso("A Data Inicial N" + CHR(227) + "o Foi Informada!!!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = loc_lResultado
            ENDIF
            IF EMPTY(par_dDataF)
                MsgAviso("A Data Final N" + CHR(227) + "o Foi Informada!!!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = loc_lResultado
            ENDIF
            IF par_dDataF < par_dDataI
                MsgAviso("Data Final menor que Data Inicial!!!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = loc_lResultado
            ENDIF

            *-- Chave composta gruconmoes: grupo(10) + conta(10) + moeda(3)
            loc_cGruConMoe = PADR(ALLTRIM(par_cGrupo), 10) + ;
                             PADR(ALLTRIM(par_cConta), 10) + ;
                             PADR(ALLTRIM(par_cMoeda), 3)

            *-- Filtros opcionais
            loc_cFiltroEmp = ""
            IF !EMPTY(ALLTRIM(par_cEmp))
                loc_cFiltroEmp = " AND a.Emps = " + EscaparSQL(ALLTRIM(par_cEmp))
            ENDIF

            loc_cFiltroOper = ""
            IF !EMPTY(ALLTRIM(par_cGetOper)) AND !ALLTRIM(par_cGetOper) = " "
                loc_cFiltroOper = " AND a.Opers = " + EscaparSQL(UPPER(ALLTRIM(par_cGetOper)))
            ENDIF

            *-- Escopo: conta individual ou todas do grupo
            IF par_lChkGrupo
                loc_cEscopo = "a.Grupos = " + EscaparSQL(ALLTRIM(par_cGrupo)) + ;
                              " AND a.Moedas = " + EscaparSQL(ALLTRIM(par_cMoeda))
            ELSE
                loc_cEscopo = "a.GruConMoes = " + EscaparSQL(loc_cGruConMoe)
            ENDIF

            *-- Ordenacao: por conta (grupo) ou por data (individual)
            *-- Filtro de conciliacao aplicado localmente apos carga (como no original)
            IF par_lChkGrupo
                loc_cSQL = "SELECT a.Emps, a.Grupos, a.Contas, a.Moedas, " + ;
                           "a.Datas, a.Dataconcs, a.Hists, a.Valors, a.Saldos, " + ;
                           "a.Opers, a.Nopers, a.Numes, a.Dopes, a.Dopcs, a.Numcs, " + ;
                           "a.Concs, a.Usuconcs, a.Auditors, a.DtAudits, a.Tipos, " + ;
                           "a.Vopers, a.Titulos, a.Nfs, a.Empos, b.RClis " + ;
                           "FROM SigMvCcr a " + ;
                           "INNER JOIN SigCdCli b ON a.Contas = b.IClis " + ;
                           "WHERE " + loc_cEscopo + ;
                           " AND a.Datas >= " + FormatarDataSQL(par_dDataI) + ;
                           " AND a.Datas < DATEADD(day, 1, " + FormatarDataSQL(par_dDataF) + ")" + ;
                           loc_cFiltroEmp + loc_cFiltroOper + ;
                           " ORDER BY a.Contas, a.Datas, a.Nopers"
            ELSE
                loc_cSQL = "SELECT a.Emps, a.Grupos, a.Contas, a.Moedas, " + ;
                           "a.Datas, a.Dataconcs, a.Hists, a.Valors, a.Saldos, " + ;
                           "a.Opers, a.Nopers, a.Numes, a.Dopes, a.Dopcs, a.Numcs, " + ;
                           "a.Concs, a.Usuconcs, a.Auditors, a.DtAudits, a.Tipos, " + ;
                           "a.Vopers, a.Titulos, a.Nfs, a.Empos, b.RClis " + ;
                           "FROM SigMvCcr a " + ;
                           "INNER JOIN SigCdCli b ON a.Contas = b.IClis " + ;
                           "WHERE " + loc_cEscopo + ;
                           " AND a.Datas >= " + FormatarDataSQL(par_dDataI) + ;
                           " AND a.Datas < DATEADD(day, 1, " + FormatarDataSQL(par_dDataF) + ")" + ;
                           loc_cFiltroEmp + loc_cFiltroOper + ;
                           " ORDER BY a.Datas, a.Nopers"
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RelHistorico")
            IF loc_nRet < 1
                MsgErro("Erro ao gerar dados do relat" + CHR(243) + "rio.", "Erro")
                loc_lResultado = loc_lResultado
            ENDIF

            *-- Aplicar filtro de conciliacao localmente (como no original: Delete Where Concs)
            SELECT cursor_4c_RelHistorico
            DO CASE
                CASE par_nCmbConcilia = 1
                    SET FILTER TO !Concs
                CASE par_nCmbConcilia = 2
                    SET FILTER TO Concs
                OTHERWISE
                    SET FILTER TO
            ENDCASE
            GO TOP

            *-- Arquivo de relatorio e tipo de saida
            loc_cArqRel = gc_4c_CaminhoReports + "RelSigOpIndHist.frx"
            DO CASE
                CASE par_cTipo = "I"
                    loc_cSaida = "TO PRINTER PROMPT NOCONSOLE"
                CASE par_cTipo = "E"
                    loc_cSaida = "TO FILE " + gc_4c_CaminhoBase + "RelHistorico.xls TYPE XL5 PROMPT NOCONSOLE"
                OTHERWISE
                    loc_cSaida = "PREVIEW NOCONSOLE"
            ENDCASE

            REPORT FORM (loc_cArqRel) &loc_cSaida

            IF USED("cursor_4c_RelHistorico")
                USE IN cursor_4c_RelHistorico
            ENDIF

            loc_lResultado = .T.

        CATCH TO loc_oErro
            IF USED("cursor_4c_RelHistorico")
                USE IN cursor_4c_RelHistorico
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

