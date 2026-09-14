# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [GRID-HEADER] Header Caption ' ' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Data, Conta, Contrapartida, Histórico, Débito, Crédito, , NF, Documento, O. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption ' ' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Data, Conta, Contrapartida, Histórico, Débito, Crédito, , NF, Documento, O. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigmvccr.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2336 linhas total):

*-- Linhas 73 a 81:
73:                 THIS.ConfigurarPaginaDados()
74: 
75:                 *-- Propagar titulo do form para label do cabecalho
76:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
77: 
78:                 *-- Ativar PageFrame
79:                 THIS.pgf_4c_Paginas.Visible   = .T.
80:                 THIS.pgf_4c_Paginas.ActivePage = 1
81:                 THIS.this_cModoAtual = "LISTA"

*-- Linhas 101 a 151:
101: 
102:         WITH THIS.pgf_4c_Paginas
103:             .PageCount   = 2
104:             .Top         = -29
105:             .Left        = 0
106:             .Width       = THIS.Width
107:             .Height      = THIS.Height + 29
108:             .Tabs        = .F.
109: 
110:             .Page1.Caption   = "Lista"
111:             .Page2.Caption   = "Dados"
112:             .Page1.BackColor = RGB(240, 240, 240)
113:             .Page2.BackColor = RGB(240, 240, 240)
114:         ENDWITH
115:     ENDPROC
116: 
117:     *--------------------------------------------------------------------------
118:     * ConfigurarPaginaLista - Configura Page1: cabecalho, botoes CRUD (7),
119:     * filtro de periodo e grade de lancamentos (11 colunas).
120:     * Todos os controles com Top += 29 (compensacao PageFrame.Top=-29)
121:     *--------------------------------------------------------------------------
122:     PROTECTED PROCEDURE ConfigurarPaginaLista()
123:         LOCAL loc_oPagina, loc_oGrid, loc_oCnt, loc_oPer
124:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
125: 
126:         *--------------------------------------------------------------------
127:         * CONTAINER CABECALHO (titulo escuro - esquerda do topo)
128:         * Original: top=2 -> migrado: top = 2 + 29 = 31
129:         *--------------------------------------------------------------------
130:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
131:         WITH loc_oPagina.cnt_4c_Cabecalho
132:             .Top           = 31
133:             .Left          = 0
134:             .Width         = 453
135:             .Height        = 75
136:             .BackStyle     = 1
137:             .BackColor     = RGB(53, 53, 53)
138:             .SpecialEffect = 0
139:             .BorderWidth   = 0
140:             .Visible     = .T.
141:         ENDWITH
142:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
143:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
144:             .Caption   = "Conta Corrente Geral"
145:             .Top       = 25
146:             .Left      = 10
147:             .Width     = 430
148:             .Height    = 25
149:             .BackStyle = 0
150:             .ForeColor = RGB(255, 255, 255)
151:             .FontName  = "Tahoma"

*-- Linhas 162 a 373:
162:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
163:         loc_oCnt = loc_oPagina.cnt_4c_Botoes
164:         WITH loc_oCnt
165:             .Top           = 29
166:             .Left          = 453
167:             .Width         = THIS.Width - 453
168:             .Height        = 75
169:             .BackStyle     = 1
170:             .BackColor     = RGB(255, 255, 255)
171:             .SpecialEffect = 0
172:             .BorderWidth   = 0
173:         ENDWITH
174: 
175:         *-- Incluir
176:         loc_oCnt.AddObject("cmd_4c_Incluir", "CommandButton")
177:         WITH loc_oCnt.cmd_4c_Incluir
178:             .Caption         = "Incluir"
179:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
180:             .PicturePosition = 13
181:             .Top             = 2
182:             .Left            = 5
183:             .Width           = 75
184:             .Height          = 71
185:             .BackColor       = RGB(255, 255, 255)
186:             .ForeColor       = RGB(90, 90, 90)
187:             .Themes          = .F.
188:             .SpecialEffect   = 0
189:         ENDWITH
190:         BINDEVENT(loc_oCnt.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
191: 
192:         *-- Visualizar
193:         loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
194:         WITH loc_oCnt.cmd_4c_Visualizar
195:             .Caption         = "Visualizar"
196:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
197:             .PicturePosition = 13
198:             .Top             = 2
199:             .Left            = 82
200:             .Width           = 75
201:             .Height          = 71
202:             .BackColor       = RGB(255, 255, 255)
203:             .ForeColor       = RGB(90, 90, 90)
204:             .Themes          = .F.
205:             .SpecialEffect   = 0
206:         ENDWITH
207:         BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
208: 
209:         *-- Alterar
210:         loc_oCnt.AddObject("cmd_4c_Alterar", "CommandButton")
211:         WITH loc_oCnt.cmd_4c_Alterar
212:             .Caption         = "Alterar"
213:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
214:             .PicturePosition = 13
215:             .Top             = 2
216:             .Left            = 159
217:             .Width           = 75
218:             .Height          = 71
219:             .BackColor       = RGB(255, 255, 255)
220:             .ForeColor       = RGB(90, 90, 90)
221:             .Themes          = .F.
222:             .SpecialEffect   = 0
223:         ENDWITH
224:         BINDEVENT(loc_oCnt.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
225: 
226:         *-- Excluir
227:         loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
228:         WITH loc_oCnt.cmd_4c_Excluir
229:             .Caption         = "Excluir"
230:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
231:             .PicturePosition = 13
232:             .Top             = 2
233:             .Left            = 236
234:             .Width           = 75
235:             .Height          = 71
236:             .BackColor       = RGB(255, 255, 255)
237:             .ForeColor       = RGB(90, 90, 90)
238:             .Themes          = .F.
239:             .SpecialEffect   = 0
240:         ENDWITH
241:         BINDEVENT(loc_oCnt.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
242: 
243:         *-- Buscar
244:         loc_oCnt.AddObject("cmd_4c_Buscar", "CommandButton")
245:         WITH loc_oCnt.cmd_4c_Buscar
246:             .Caption         = "Buscar"
247:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
248:             .PicturePosition = 13
249:             .Top             = 2
250:             .Left            = 313
251:             .Width           = 75
252:             .Height          = 71
253:             .BackColor       = RGB(255, 255, 255)
254:             .ForeColor       = RGB(90, 90, 90)
255:             .Themes          = .F.
256:             .SpecialEffect   = 0
257:         ENDWITH
258:         BINDEVENT(loc_oCnt.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
259: 
260:         *-- Movimento (Anexa - F7 no original, abre SigCdPgr/SigCdLch vinculados)
261:         loc_oCnt.AddObject("cmd_4c_Movimento", "CommandButton")
262:         WITH loc_oCnt.cmd_4c_Movimento
263:             .Caption         = "Movimento"
264:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
265:             .PicturePosition = 13
266:             .Top             = 2
267:             .Left            = 390
268:             .Width           = 75
269:             .Height          = 71
270:             .BackColor       = RGB(255, 255, 255)
271:             .ForeColor       = RGB(90, 90, 90)
272:             .Themes          = .F.
273:             .SpecialEffect   = 0
274:         ENDWITH
275:         BINDEVENT(loc_oCnt.cmd_4c_Movimento, "Click", THIS, "BtnMovimentoClick")
276: 
277:         *-- Encerrar
278:         loc_oCnt.AddObject("cmd_4c_Encerrar", "CommandButton")
279:         WITH loc_oCnt.cmd_4c_Encerrar
280:             .Caption         = "Encerrar"
281:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
282:             .PicturePosition = 13
283:             .Top             = 2
284:             .Left            = 467
285:             .Width           = 75
286:             .Height          = 71
287:             .BackColor       = RGB(255, 255, 255)
288:             .ForeColor       = RGB(90, 90, 90)
289:             .Themes          = .F.
290:             .SpecialEffect   = 0
291:         ENDWITH
292:         BINDEVENT(loc_oCnt.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
293: 
294:         *--------------------------------------------------------------------
295:         * CONTAINER FILTRO PERIODO
296:         * top=104 (visual 75 = fim da toolbar) + 29 = 104
297:         * Estrutura: cnt_4c_Filtros > cnt_4c_Periodo > labels + textboxes
298:         *--------------------------------------------------------------------
299:         loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
300:         WITH loc_oPagina.cnt_4c_Filtros
301:             .Top           = 104
302:             .Left          = 0
303:             .Width         = THIS.Width
304:             .Height        = 40
305:             .BackStyle     = 0
306:             .SpecialEffect = 0
307:             .BorderWidth   = 0
308:             .Visible     = .T.
309:         ENDWITH
310: 
311:         loc_oPagina.cnt_4c_Filtros.AddObject("cnt_4c_Periodo", "Container")
312:         WITH loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo
313:             .Top           = 2
314:             .Left          = 14
315:             .Width         = 271
316:             .Height        = 36
317:             .BackStyle     = 0
318:             .SpecialEffect = 0
319:             .BorderWidth   = 0
320:             .Visible     = .T.
321:         ENDWITH
322: 
323:         loc_oPer = loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo
324: 
325:         loc_oPer.AddObject("lbl_4c_Periodo", "Label")
326:         WITH loc_oPer.lbl_4c_Periodo
327:             .Caption   = "Per" + CHR(237) + "odo : "
328:             .Top       = 10
329:             .Left      = 17
330:             .Width     = 54
331:             .Height    = 15
332:             .BackStyle = 0
333:             .ForeColor = RGB(0, 0, 0)
334:             .FontName  = "Tahoma"
335:             .FontSize  = 8
336:         ENDWITH
337: 
338:         loc_oPer.AddObject("txt_4c_DtInicial", "TextBox")
339:         WITH loc_oPer.txt_4c_DtInicial
340:             .Value     = DATE() - DAY(DATE()) + 1
341:             .Top       = 6
342:             .Left      = 73
343:             .Width     = 80
344:             .Height    = 20
345:             .InputMask = "99/99/9999"
346:             .FontName  = "Tahoma"
347:             .FontSize  = 8
348:         ENDWITH
349:         BINDEVENT(loc_oPer.txt_4c_DtInicial, "KeyPress", THIS, "FiltroDtInicialKeyPress")
350: 
351:         loc_oPer.AddObject("lbl_4c_Ate", "Label")
352:         WITH loc_oPer.lbl_4c_Ate
353:             .Caption   = "at" + CHR(233)
354:             .Top       = 10
355:             .Left      = 158
356:             .Width     = 20
357:             .Height    = 15
358:             .BackStyle = 0
359:             .ForeColor = RGB(0, 0, 0)
360:             .FontName  = "Tahoma"
361:             .FontSize  = 8
362:         ENDWITH
363: 
364:         loc_oPer.AddObject("txt_4c_DtFinal", "TextBox")
365:         WITH loc_oPer.txt_4c_DtFinal
366:             .Value     = DATE()
367:             .Top       = 6
368:             .Left      = 184
369:             .Width     = 80
370:             .Height    = 20
371:             .InputMask = "99/99/9999"
372:             .FontName  = "Tahoma"
373:             .FontSize  = 8

*-- Linhas 383 a 702:
383:         *--------------------------------------------------------------------
384:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
385:         loc_oGrid = loc_oPagina.grd_4c_Dados
386:         loc_oGrid.Top         = 144
387:         loc_oGrid.Left        = 23
388:         loc_oGrid.Width       = 944
389:         loc_oGrid.Height      = 456
390:         loc_oGrid.ColumnCount = 11
391:         loc_oGrid.GridLines   = 3
392:         loc_oGrid.RecordMark  = .F.
393:         loc_oGrid.DeleteMark  = .F.
394:         loc_oGrid.ReadOnly    = .T.
395:         loc_oGrid.FontName    = "Tahoma"
396:         loc_oGrid.FontSize    = 8
397: 
398:         *-- Larguras e headers iniciais (reconfigurados em CarregarLista apos RecordSource)
399:         loc_oGrid.Column1.Width           = 71
400:         loc_oGrid.Column1.Header1.Caption = "Data"
401:         loc_oGrid.Column2.Width           = 20
402:         loc_oGrid.Column2.Header1.Caption = "O"
403:         loc_oGrid.Column3.Width           = 90
404:         loc_oGrid.Column3.Header1.Caption = "Conta"
405:         loc_oGrid.Column4.Width           = 90
406:         loc_oGrid.Column4.Header1.Caption = "Contrapartida"
407:         loc_oGrid.Column5.Width           = 200
408:         loc_oGrid.Column5.Header1.Caption = "Hist" + CHR(243) + "rico"
409:         loc_oGrid.Column6.Width           = 90
410:         loc_oGrid.Column6.Header1.Caption = "D" + CHR(233) + "bito"
411:         loc_oGrid.Column7.Width           = 90
412:         loc_oGrid.Column7.Header1.Caption = "Cr" + CHR(233) + "dito"
413:         loc_oGrid.Column8.Width           = 20
414:         loc_oGrid.Column8.Header1.Caption = ""
415:         loc_oGrid.Column9.Width           = 65
416:         loc_oGrid.Column9.Header1.Caption = "NF"
417:         loc_oGrid.Column10.Width          = 80
418:         loc_oGrid.Column10.Header1.Caption = "Documento"
419:         loc_oGrid.Column11.Width          = 20
420:         loc_oGrid.Column11.Header1.Caption = " "
421: 
422:         BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GridAfterRowColChange")
423: 
424:         THIS.TornarControlesVisiveis(loc_oPagina)
425:     ENDPROC
426: 
427:     *--------------------------------------------------------------------------
428:     * ConfigurarPaginaDados - Configura Page2: botoes Confirmar/Cancelar,
429:     * area do cabecalho (Shape1) e area de movimento esquerda (Shape3).
430:     * Fase 5: 50% dos campos (cabecalho + movimento esquerdo).
431:     * Top += 29 (compensacao PageFrame.Top=-29)
432:     *--------------------------------------------------------------------------
433:     PROTECTED PROCEDURE ConfigurarPaginaDados()
434:         LOCAL loc_oPagina, loc_oCnt
435:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
436: 
437:         *--------------------------------------------------------------------
438:         * BOTOES ACAO (Confirmar/Cancelar - topo direito)
439:         * Original: top=9 -> migrado: top = 9 + 29 = 38
440:         *--------------------------------------------------------------------
441:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
442:         loc_oCnt = loc_oPagina.cnt_4c_BotoesAcao
443:         WITH loc_oCnt
444:             .Top           = 38
445:             .Left          = 843
446:             .Width         = 157
447:             .Height        = 75
448:             .BackStyle     = 1
449:             .BackColor     = RGB(255, 255, 255)
450:             .SpecialEffect = 0
451:             .BorderWidth   = 0
452:         ENDWITH
453: 
454:         loc_oCnt.AddObject("cmd_4c_Confirmar", "CommandButton")
455:         WITH loc_oCnt.cmd_4c_Confirmar
456:             .Caption         = "Confirmar"
457:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
458:             .PicturePosition = 13
459:             .Top             = 2
460:             .Left            = 5
461:             .Width           = 75
462:             .Height          = 71
463:             .BackColor       = RGB(255, 255, 255)
464:             .ForeColor       = RGB(90, 90, 90)
465:             .Themes          = .F.
466:             .SpecialEffect   = 0
467:         ENDWITH
468:         BINDEVENT(loc_oCnt.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
469: 
470:         loc_oCnt.AddObject("cmd_4c_Cancelar", "CommandButton")
471:         WITH loc_oCnt.cmd_4c_Cancelar
472:             .Caption         = "Cancelar"
473:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
474:             .PicturePosition = 13
475:             .Top             = 2
476:             .Left            = 77
477:             .Width           = 75
478:             .Height          = 71
479:             .BackColor       = RGB(255, 255, 255)
480:             .ForeColor       = RGB(90, 90, 90)
481:             .Themes          = .F.
482:             .SpecialEffect   = 0
483:         ENDWITH
484:         BINDEVENT(loc_oCnt.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
485: 
486:         *====================================================================
487:         * AREA DO CABECALHO (Shape1)
488:         * Original: top=153, left=9, width=980, height=64
489:         * Migrado:  top=153+29=182
490:         *====================================================================
491:         loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
492:         WITH loc_oPagina.shp_4c_Shape1
493:             .Top           = 182
494:             .Left          = 9
495:             .Width         = 980
496:             .Height        = 64
497:             .BorderStyle   = 1
498:             .BorderColor   = RGB(192, 192, 192)
499:             .BackStyle     = 0
500:             .SpecialEffect = 1
501:         ENDWITH
502: 
503:         *-- Label Lancamento (Say1): top=165+29=194, left=43
504:         loc_oPagina.AddObject("lbl_4c_Lancamento", "Label")
505:         WITH loc_oPagina.lbl_4c_Lancamento
506:             .Caption   = "Lan" + CHR(231) + "amento :"
507:             .Top       = 194
508:             .Left      = 43
509:             .Width     = 70
510:             .Height    = 17
511:             .BackStyle = 0
512:             .ForeColor = RGB(90, 90, 90)
513:             .FontName  = "Tahoma"
514:             .FontSize  = 8
515:         ENDWITH
516: 
517:         *-- TextBox DATA: top=161+29=190, left=112, width=80
518:         loc_oPagina.AddObject("txt_4c_Data", "TextBox")
519:         WITH loc_oPagina.txt_4c_Data
520:             .Value     = {}
521:             .Top       = 190
522:             .Left      = 112
523:             .Width     = 80
524:             .Height    = 20
525:             .InputMask = "99/99/9999"
526:             .FontName  = "Tahoma"
527:             .FontSize  = 8
528:         ENDWITH
529:         BINDEVENT(loc_oPagina.txt_4c_Data, "KeyPress", THIS, "DtDataKeyPress")
530: 
531:         *-- Label Vencimento (Say10): top=165+29=194, left=234
532:         loc_oPagina.AddObject("lbl_4c_Vencimento", "Label")
533:         WITH loc_oPagina.lbl_4c_Vencimento
534:             .Caption   = "Vencimento :"
535:             .Top       = 194
536:             .Left      = 234
537:             .Width     = 65
538:             .Height    = 17
539:             .BackStyle = 0
540:             .ForeColor = RGB(90, 90, 90)
541:             .FontName  = "Tahoma"
542:             .FontSize  = 8
543:         ENDWITH
544: 
545:         *-- TextBox VENC: top=161+29=190, left=300, width=80
546:         loc_oPagina.AddObject("txt_4c_Venc", "TextBox")
547:         WITH loc_oPagina.txt_4c_Venc
548:             .Value     = {}
549:             .Top       = 190
550:             .Left      = 300
551:             .Width     = 80
552:             .Height    = 20
553:             .InputMask = "99/99/9999"
554:             .FontName  = "Tahoma"
555:             .FontSize  = 8
556:         ENDWITH
557: 
558:         *-- Label Emissao (Say15): top=165+29=194, left=435
559:         loc_oPagina.AddObject("lbl_4c_Emissao", "Label")
560:         WITH loc_oPagina.lbl_4c_Emissao
561:             .Caption   = "Emiss" + CHR(227) + "o :"
562:             .Top       = 194
563:             .Left      = 435
564:             .Width     = 50
565:             .Height    = 17
566:             .BackStyle = 0
567:             .ForeColor = RGB(90, 90, 90)
568:             .FontName  = "Tahoma"
569:             .FontSize  = 8
570:         ENDWITH
571: 
572:         *-- TextBox DtEmis: top=161+29=190, left=484, width=80
573:         loc_oPagina.AddObject("txt_4c_DtEmis", "TextBox")
574:         WITH loc_oPagina.txt_4c_DtEmis
575:             .Value     = {}
576:             .Top       = 190
577:             .Left      = 484
578:             .Width     = 80
579:             .Height    = 20
580:             .InputMask = "99/99/9999"
581:             .FontName  = "Tahoma"
582:             .FontSize  = 8
583:         ENDWITH
584: 
585:         *-- Label Nota Fiscal (Say7): top=165+29=194, left=615
586:         loc_oPagina.AddObject("lbl_4c_NotaFiscal", "Label")
587:         WITH loc_oPagina.lbl_4c_NotaFiscal
588:             .Caption   = "Nota Fiscal :"
589:             .Top       = 194
590:             .Left      = 615
591:             .Width     = 65
592:             .Height    = 17
593:             .BackStyle = 0
594:             .ForeColor = RGB(90, 90, 90)
595:             .FontName  = "Tahoma"
596:             .FontSize  = 8
597:         ENDWITH
598: 
599:         *-- TextBox Nota: top=161+29=190, left=678, width=80
600:         loc_oPagina.AddObject("txt_4c_Nota", "TextBox")
601:         WITH loc_oPagina.txt_4c_Nota
602:             .Value    = ""
603:             .Top      = 190
604:             .Left     = 678
605:             .Width    = 80
606:             .Height   = 20
607:             .FontName = "Tahoma"
608:             .FontSize = 8
609:         ENDWITH
610: 
611:         *-- Label Usuario (Say6): top=165+29=194, left=818
612:         loc_oPagina.AddObject("lbl_4c_Usuario", "Label")
613:         WITH loc_oPagina.lbl_4c_Usuario
614:             .Caption   = "Usu" + CHR(225) + "rio :"
615:             .Top       = 194
616:             .Left      = 818
617:             .Width     = 50
618:             .Height    = 17
619:             .BackStyle = 0
620:             .ForeColor = RGB(90, 90, 90)
621:             .FontName  = "Tahoma"
622:             .FontSize  = 8
623:         ENDWITH
624: 
625:         *-- TextBox Usuario (ReadOnly): top=161+29=190, left=865, width=80
626:         loc_oPagina.AddObject("txt_4c_Usuario", "TextBox")
627:         WITH loc_oPagina.txt_4c_Usuario
628:             .Value    = ""
629:             .Top      = 190
630:             .Left     = 865
631:             .Width    = 80
632:             .Height   = 20
633:             .ReadOnly = .T.
634:             .FontName = "Tahoma"
635:             .FontSize = 8
636:         ENDWITH
637: 
638:         *-- Label Job (Say17): top=191+29=220, left=84
639:         loc_oPagina.AddObject("lbl_4c_Job", "Label")
640:         WITH loc_oPagina.lbl_4c_Job
641:             .Caption   = "Job :"
642:             .Top       = 220
643:             .Left      = 84
644:             .Width     = 30
645:             .Height    = 17
646:             .BackStyle = 0
647:             .ForeColor = RGB(90, 90, 90)
648:             .FontName  = "Tahoma"
649:             .FontSize  = 8
650:         ENDWITH
651: 
652:         *-- TextBox Job: top=187+29=216, left=112, width=80
653:         loc_oPagina.AddObject("txt_4c_Job", "TextBox")
654:         WITH loc_oPagina.txt_4c_Job
655:             .Value    = ""
656:             .Top      = 216
657:             .Left     = 112
658:             .Width    = 80
659:             .Height   = 20
660:             .FontName = "Tahoma"
661:             .FontSize = 8
662:         ENDWITH
663:         BINDEVENT(loc_oPagina.txt_4c_Job, "KeyPress", THIS, "JobKeyPress")
664: 
665:         *-- TextBox DJob (desc job): top=187+29=216, left=195, width=290
666:         loc_oPagina.AddObject("txt_4c_DJob", "TextBox")
667:         WITH loc_oPagina.txt_4c_DJob
668:             .Value    = ""
669:             .Top      = 216
670:             .Left     = 195
671:             .Width    = 290
672:             .Height   = 20
673:             .ReadOnly = .T.
674:             .FontName = "Tahoma"
675:             .FontSize = 8
676:         ENDWITH
677: 
678:         *-- Label Documento (Say2): top=191+29=220, left=613
679:         loc_oPagina.AddObject("lbl_4c_Documento", "Label")
680:         WITH loc_oPagina.lbl_4c_Documento
681:             .Caption   = "Documento :"
682:             .Top       = 220
683:             .Left      = 613
684:             .Width     = 60
685:             .Height    = 17
686:             .BackStyle = 0
687:             .ForeColor = RGB(90, 90, 90)
688:             .FontName  = "Tahoma"
689:             .FontSize  = 8
690:         ENDWITH
691: 
692:         *-- TextBox DOCU: top=187+29=216, left=678, width=80
693:         loc_oPagina.AddObject("txt_4c_DOCU", "TextBox")
694:         WITH loc_oPagina.txt_4c_DOCU
695:             .Value    = ""
696:             .Top      = 216
697:             .Left     = 678
698:             .Width    = 80
699:             .Height   = 20
700:             .FontName = "Tahoma"
701:             .FontSize = 8
702:         ENDWITH

*-- Linhas 708 a 1243:
708:         *====================================================================
709:         loc_oPagina.AddObject("shp_4c_Shape3", "Shape")
710:         WITH loc_oPagina.shp_4c_Shape3
711:             .Top           = 253
712:             .Left          = 9
713:             .Width         = 485
714:             .Height        = 117
715:             .BorderStyle   = 1
716:             .BorderColor   = RGB(192, 192, 192)
717:             .BackStyle     = 0
718:             .SpecialEffect = 1
719:         ENDWITH
720: 
721:         *-- Label Movimento esq (Say3): top=235+29=264, left=49
722:         loc_oPagina.AddObject("lbl_4c_Movimento", "Label")
723:         WITH loc_oPagina.lbl_4c_Movimento
724:             .Caption   = "Movimento :"
725:             .Top       = 264
726:             .Left      = 49
727:             .Width     = 65
728:             .Height    = 17
729:             .BackStyle = 0
730:             .ForeColor = RGB(90, 90, 90)
731:             .FontName  = "Tahoma"
732:             .FontSize  = 8
733:         ENDWITH
734: 
735:         *-- Label [D/C] esq (Say18): top=235+29=264, left=130
736:         loc_oPagina.AddObject("lbl_4c_DC", "Label")
737:         WITH loc_oPagina.lbl_4c_DC
738:             .Caption   = "[D/C]"
739:             .Top       = 264
740:             .Left      = 130
741:             .Width     = 30
742:             .Height    = 17
743:             .BackStyle = 0
744:             .ForeColor = RGB(90, 90, 90)
745:             .FontName  = "Tahoma"
746:             .FontSize  = 8
747:         ENDWITH
748: 
749:         *-- TextBox OPER: top=231+29=260, left=112, width=15
750:         loc_oPagina.AddObject("txt_4c_Oper", "TextBox")
751:         WITH loc_oPagina.txt_4c_Oper
752:             .Value    = ""
753:             .Top      = 260
754:             .Left     = 112
755:             .Width    = 15
756:             .Height   = 20
757:             .FontName = "Tahoma"
758:             .FontSize = 8
759:         ENDWITH
760:         BINDEVENT(loc_oPagina.txt_4c_Oper, "KeyPress", THIS, "OperKeyPress")
761: 
762:         *-- Label Grupo esq (Say4): top=261+29=290, left=72
763:         loc_oPagina.AddObject("lbl_4c_Grupo", "Label")
764:         WITH loc_oPagina.lbl_4c_Grupo
765:             .Caption   = "Grupo :"
766:             .Top       = 290
767:             .Left      = 72
768:             .Width     = 40
769:             .Height    = 17
770:             .BackStyle = 0
771:             .ForeColor = RGB(90, 90, 90)
772:             .FontName  = "Tahoma"
773:             .FontSize  = 8
774:         ENDWITH
775: 
776:         *-- TextBox Grupo: top=257+29=286, left=112, width=80
777:         loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
778:         WITH loc_oPagina.txt_4c_Grupo
779:             .Value    = ""
780:             .Top      = 286
781:             .Left     = 112
782:             .Width    = 80
783:             .Height   = 20
784:             .FontName = "Tahoma"
785:             .FontSize = 8
786:         ENDWITH
787:         BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress", THIS, "GrupoKeyPress")
788: 
789:         *-- TextBox DGrupo: top=257+29=286, left=195, width=290
790:         loc_oPagina.AddObject("txt_4c_DGrupo", "TextBox")
791:         WITH loc_oPagina.txt_4c_DGrupo
792:             .Value    = ""
793:             .Top      = 286
794:             .Left     = 195
795:             .Width    = 290
796:             .Height   = 20
797:             .ReadOnly = .T.
798:             .FontName = "Tahoma"
799:             .FontSize = 8
800:         ENDWITH
801: 
802:         *-- Label Conta esq (Say5): top=287+29=316, left=72
803:         loc_oPagina.AddObject("lbl_4c_Conta", "Label")
804:         WITH loc_oPagina.lbl_4c_Conta
805:             .Caption   = "Conta :"
806:             .Top       = 316
807:             .Left      = 72
808:             .Width     = 40
809:             .Height    = 17
810:             .BackStyle = 0
811:             .ForeColor = RGB(90, 90, 90)
812:             .FontName  = "Tahoma"
813:             .FontSize  = 8
814:         ENDWITH
815: 
816:         *-- TextBox Conta: top=283+29=312, left=112, width=80
817:         loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
818:         WITH loc_oPagina.txt_4c_Conta
819:             .Value    = ""
820:             .Top      = 312
821:             .Left     = 112
822:             .Width    = 80
823:             .Height   = 20
824:             .FontName = "Tahoma"
825:             .FontSize = 8
826:         ENDWITH
827:         BINDEVENT(loc_oPagina.txt_4c_Conta, "KeyPress", THIS, "ContaKeyPress")
828: 
829:         *-- TextBox DConta: top=283+29=312, left=195, width=290
830:         loc_oPagina.AddObject("txt_4c_DConta", "TextBox")
831:         WITH loc_oPagina.txt_4c_DConta
832:             .Value    = ""
833:             .Top      = 312
834:             .Left     = 195
835:             .Width    = 290
836:             .Height   = 20
837:             .ReadOnly = .T.
838:             .FontName = "Tahoma"
839:             .FontSize = 8
840:         ENDWITH
841: 
842:         *-- Label Valor esq (Say8): top=313+29=342, left=77
843:         loc_oPagina.AddObject("lbl_4c_Valor", "Label")
844:         WITH loc_oPagina.lbl_4c_Valor
845:             .Caption   = "Valor :"
846:             .Top       = 342
847:             .Left      = 77
848:             .Width     = 35
849:             .Height    = 17
850:             .BackStyle = 0
851:             .ForeColor = RGB(90, 90, 90)
852:             .FontName  = "Tahoma"
853:             .FontSize  = 8
854:         ENDWITH
855: 
856:         *-- TextBox VALOR: top=309+29=338, left=112, width=128
857:         loc_oPagina.AddObject("txt_4c_Valor", "TextBox")
858:         WITH loc_oPagina.txt_4c_Valor
859:             .Value    = 0
860:             .Top      = 338
861:             .Left     = 112
862:             .Width    = 128
863:             .Height   = 20
864:             .FontName = "Tahoma"
865:             .FontSize = 8
866:         ENDWITH
867:         BINDEVENT(loc_oPagina.txt_4c_Valor, "KeyPress", THIS, "ValorKeyPress")
868: 
869:         *-- TextBox MOEDA: top=309+29=338, left=243, width=31
870:         loc_oPagina.AddObject("txt_4c_Moeda", "TextBox")
871:         WITH loc_oPagina.txt_4c_Moeda
872:             .Value    = ""
873:             .Top      = 338
874:             .Left     = 243
875:             .Width    = 31
876:             .Height   = 20
877:             .FontName = "Tahoma"
878:             .FontSize = 8
879:         ENDWITH
880:         BINDEVENT(loc_oPagina.txt_4c_Moeda, "KeyPress", THIS, "MoedaKeyPress")
881: 
882:         *-- Label Cambio esq (Say_Cotacao): top=313+29=342, left=303
883:         loc_oPagina.AddObject("lbl_4c_Cambio", "Label")
884:         WITH loc_oPagina.lbl_4c_Cambio
885:             .Caption   = "C" + CHR(226) + "mbio :"
886:             .Top       = 342
887:             .Left      = 303
888:             .Width     = 45
889:             .Height    = 17
890:             .BackStyle = 0
891:             .ForeColor = RGB(90, 90, 90)
892:             .FontName  = "Tahoma"
893:             .FontSize  = 8
894:         ENDWITH
895: 
896:         *-- TextBox COTACAO: top=309+29=338, left=349, width=108
897:         loc_oPagina.AddObject("txt_4c_Cotacao", "TextBox")
898:         WITH loc_oPagina.txt_4c_Cotacao
899:             .Value    = 0
900:             .Top      = 338
901:             .Left     = 349
902:             .Width    = 108
903:             .Height   = 20
904:             .FontName = "Tahoma"
905:             .FontSize = 8
906:         ENDWITH
907:         BINDEVENT(loc_oPagina.txt_4c_Cotacao, "KeyPress", THIS, "CotacaoKeyPress")
908: 
909:         *-- Botao alteracotacao ($): top=309+29=338, left=461, width=24
910:         loc_oPagina.AddObject("cmd_4c_AlteraCotacao", "CommandButton")
911:         WITH loc_oPagina.cmd_4c_AlteraCotacao
912:             .Caption       = "$"
913:             .Top           = 338
914:             .Left          = 461
915:             .Width         = 24
916:             .Height        = 20
917:             .BackColor     = RGB(255, 255, 255)
918:             .ForeColor     = RGB(90, 90, 90)
919:             .Themes        = .F.
920:             .SpecialEffect = 0
921:         ENDWITH
922:         BINDEVENT(loc_oPagina.cmd_4c_AlteraCotacao, "Click", THIS, "BtnAlteraCotacaoClick")
923: 
924:         *====================================================================
925:         * AREA MOVIMENTO DIREITA - SIMETRICO (Shape2)
926:         * Original: top=224, left=504, width=485, height=117
927:         * Migrado:  top=224+29=253
928:         *====================================================================
929:         loc_oPagina.AddObject("shp_4c_Shape2", "Shape")
930:         WITH loc_oPagina.shp_4c_Shape2
931:             .Top           = 253
932:             .Left          = 504
933:             .Width         = 485
934:             .Height        = 117
935:             .BorderStyle   = 1
936:             .BorderColor   = RGB(192, 192, 192)
937:             .BackStyle     = 0
938:             .SpecialEffect = 1
939:         ENDWITH
940: 
941:         *-- Label Movimento dir (Say11): top=235+29=264, left=544
942:         loc_oPagina.AddObject("lbl_4c_MovimentoS", "Label")
943:         WITH loc_oPagina.lbl_4c_MovimentoS
944:             .Caption   = "Movimento :"
945:             .Top       = 264
946:             .Left      = 544
947:             .Width     = 65
948:             .Height    = 17
949:             .BackStyle = 0
950:             .ForeColor = RGB(90, 90, 90)
951:             .FontName  = "Tahoma"
952:             .FontSize  = 8
953:         ENDWITH
954: 
955:         *-- Label [D/C] dir (Say14): top=235+29=264, left=626
956:         loc_oPagina.AddObject("lbl_4c_DCS", "Label")
957:         WITH loc_oPagina.lbl_4c_DCS
958:             .Caption   = "[D/C]"
959:             .Top       = 264
960:             .Left      = 626
961:             .Width     = 30
962:             .Height    = 17
963:             .BackStyle = 0
964:             .ForeColor = RGB(90, 90, 90)
965:             .FontName  = "Tahoma"
966:             .FontSize  = 8
967:         ENDWITH
968: 
969:         *-- TextBox SOper: top=231+29=260, left=607, width=15
970:         loc_oPagina.AddObject("txt_4c_SOper", "TextBox")
971:         WITH loc_oPagina.txt_4c_SOper
972:             .Value    = ""
973:             .Top      = 260
974:             .Left     = 607
975:             .Width    = 15
976:             .Height   = 20
977:             .FontName = "Tahoma"
978:             .FontSize = 8
979:         ENDWITH
980:         BINDEVENT(loc_oPagina.txt_4c_SOper, "KeyPress", THIS, "SOperKeyPress")
981: 
982:         *-- Label Grupo dir (Say12): top=261+29=290, left=567
983:         loc_oPagina.AddObject("lbl_4c_GrupoS", "Label")
984:         WITH loc_oPagina.lbl_4c_GrupoS
985:             .Caption   = "Grupo :"
986:             .Top       = 290
987:             .Left      = 567
988:             .Width     = 40
989:             .Height    = 17
990:             .BackStyle = 0
991:             .ForeColor = RGB(90, 90, 90)
992:             .FontName  = "Tahoma"
993:             .FontSize  = 8
994:         ENDWITH
995: 
996:         *-- TextBox SGrupo: top=257+29=286, left=607, width=80
997:         loc_oPagina.AddObject("txt_4c_SGrupo", "TextBox")
998:         WITH loc_oPagina.txt_4c_SGrupo
999:             .Value    = ""
1000:             .Top      = 286
1001:             .Left     = 607
1002:             .Width    = 80
1003:             .Height   = 20
1004:             .FontName = "Tahoma"
1005:             .FontSize = 8
1006:         ENDWITH
1007:         BINDEVENT(loc_oPagina.txt_4c_SGrupo, "KeyPress", THIS, "SGrupoKeyPress")
1008: 
1009:         *-- TextBox SDGrupo (desc): top=257+29=286, left=689, width=290
1010:         loc_oPagina.AddObject("txt_4c_SDGrupo", "TextBox")
1011:         WITH loc_oPagina.txt_4c_SDGrupo
1012:             .Value    = ""
1013:             .Top      = 286
1014:             .Left     = 689
1015:             .Width    = 290
1016:             .Height   = 20
1017:             .ReadOnly = .T.
1018:             .FontName = "Tahoma"
1019:             .FontSize = 8
1020:         ENDWITH
1021: 
1022:         *-- Label Conta dir (Say13): top=287+29=316, left=567
1023:         loc_oPagina.AddObject("lbl_4c_ContaS", "Label")
1024:         WITH loc_oPagina.lbl_4c_ContaS
1025:             .Caption   = "Conta :"
1026:             .Top       = 316
1027:             .Left      = 567
1028:             .Width     = 40
1029:             .Height    = 17
1030:             .BackStyle = 0
1031:             .ForeColor = RGB(90, 90, 90)
1032:             .FontName  = "Tahoma"
1033:             .FontSize  = 8
1034:         ENDWITH
1035: 
1036:         *-- TextBox SConta: top=283+29=312, left=607, width=80
1037:         loc_oPagina.AddObject("txt_4c_SConta", "TextBox")
1038:         WITH loc_oPagina.txt_4c_SConta
1039:             .Value    = ""
1040:             .Top      = 312
1041:             .Left     = 607
1042:             .Width    = 80
1043:             .Height   = 20
1044:             .FontName = "Tahoma"
1045:             .FontSize = 8
1046:         ENDWITH
1047:         BINDEVENT(loc_oPagina.txt_4c_SConta, "KeyPress", THIS, "SContaKeyPress")
1048: 
1049:         *-- TextBox SDConta (desc): top=283+29=312, left=689, width=290
1050:         loc_oPagina.AddObject("txt_4c_SDConta", "TextBox")
1051:         WITH loc_oPagina.txt_4c_SDConta
1052:             .Value    = ""
1053:             .Top      = 312
1054:             .Left     = 689
1055:             .Width    = 290
1056:             .Height   = 20
1057:             .ReadOnly = .T.
1058:             .FontName = "Tahoma"
1059:             .FontSize = 8
1060:         ENDWITH
1061: 
1062:         *-- Label Valor dir (Say16): top=313+29=342, left=572
1063:         loc_oPagina.AddObject("lbl_4c_ValorS", "Label")
1064:         WITH loc_oPagina.lbl_4c_ValorS
1065:             .Caption   = "Valor :"
1066:             .Top       = 342
1067:             .Left      = 572
1068:             .Width     = 35
1069:             .Height    = 17
1070:             .BackStyle = 0
1071:             .ForeColor = RGB(90, 90, 90)
1072:             .FontName  = "Tahoma"
1073:             .FontSize  = 8
1074:         ENDWITH
1075: 
1076:         *-- TextBox SValor: top=309+29=338, left=607, width=128
1077:         loc_oPagina.AddObject("txt_4c_SValor", "TextBox")
1078:         WITH loc_oPagina.txt_4c_SValor
1079:             .Value    = 0
1080:             .Top      = 338
1081:             .Left     = 607
1082:             .Width    = 128
1083:             .Height   = 20
1084:             .FontName = "Tahoma"
1085:             .FontSize = 8
1086:         ENDWITH
1087:         BINDEVENT(loc_oPagina.txt_4c_SValor, "KeyPress", THIS, "SValorKeyPress")
1088: 
1089:         *-- TextBox SMoeda: top=309+29=338, left=737, width=31
1090:         loc_oPagina.AddObject("txt_4c_SMoeda", "TextBox")
1091:         WITH loc_oPagina.txt_4c_SMoeda
1092:             .Value    = ""
1093:             .Top      = 338
1094:             .Left     = 737
1095:             .Width    = 31
1096:             .Height   = 20
1097:             .FontName = "Tahoma"
1098:             .FontSize = 8
1099:         ENDWITH
1100:         BINDEVENT(loc_oPagina.txt_4c_SMoeda, "KeyPress", THIS, "SMoedaKeyPress")
1101: 
1102:         *-- Label Cambio dir (Say_sCotacao): top=313+29=342, left=797
1103:         loc_oPagina.AddObject("lbl_4c_CambioS", "Label")
1104:         WITH loc_oPagina.lbl_4c_CambioS
1105:             .Caption   = "C" + CHR(226) + "mbio :"
1106:             .Top       = 342
1107:             .Left      = 797
1108:             .Width     = 45
1109:             .Height    = 17
1110:             .BackStyle = 0
1111:             .ForeColor = RGB(90, 90, 90)
1112:             .FontName  = "Tahoma"
1113:             .FontSize  = 8
1114:         ENDWITH
1115: 
1116:         *-- TextBox SCotacao: top=309+29=338, left=843, width=108
1117:         loc_oPagina.AddObject("txt_4c_SCotacao", "TextBox")
1118:         WITH loc_oPagina.txt_4c_SCotacao
1119:             .Value    = 0
1120:             .Top      = 338
1121:             .Left     = 843
1122:             .Width    = 108
1123:             .Height   = 20
1124:             .FontName = "Tahoma"
1125:             .FontSize = 8
1126:         ENDWITH
1127:         BINDEVENT(loc_oPagina.txt_4c_SCotacao, "KeyPress", THIS, "SCotacaoKeyPress")
1128: 
1129:         *-- Botao alterascotacao ($): top=309+29=338, left=955, width=24
1130:         loc_oPagina.AddObject("cmd_4c_AlterasCotacao", "CommandButton")
1131:         WITH loc_oPagina.cmd_4c_AlterasCotacao
1132:             .Caption       = "$"
1133:             .Top           = 338
1134:             .Left          = 955
1135:             .Width         = 24
1136:             .Height        = 20
1137:             .BackColor     = RGB(255, 255, 255)
1138:             .ForeColor     = RGB(90, 90, 90)
1139:             .Themes        = .F.
1140:             .SpecialEffect = 0
1141:         ENDWITH
1142:         BINDEVENT(loc_oPagina.cmd_4c_AlterasCotacao, "Click", THIS, "BtnAlterasCotacaoClick")
1143: 
1144:         *====================================================================
1145:         * AREA HISTORICO (Shape6)
1146:         * Original: top=350, left=9, width=980, height=39
1147:         * Migrado:  top=350+29=379
1148:         *====================================================================
1149:         loc_oPagina.AddObject("shp_4c_Shape6", "Shape")
1150:         WITH loc_oPagina.shp_4c_Shape6
1151:             .Top           = 379
1152:             .Left          = 9
1153:             .Width         = 980
1154:             .Height        = 39
1155:             .BorderStyle   = 1
1156:             .BorderColor   = RGB(192, 192, 192)
1157:             .BackStyle     = 0
1158:             .SpecialEffect = 1
1159:         ENDWITH
1160: 
1161:         *-- Label Historico (Say9): top=362+29=391, left=60
1162:         loc_oPagina.AddObject("lbl_4c_Historico", "Label")
1163:         WITH loc_oPagina.lbl_4c_Historico
1164:             .Caption   = "Hist" + CHR(243) + "rico :"
1165:             .Top       = 391
1166:             .Left      = 60
1167:             .Width     = 55
1168:             .Height    = 17
1169:             .BackStyle = 0
1170:             .ForeColor = RGB(90, 90, 90)
1171:             .FontName  = "Tahoma"
1172:             .FontSize  = 8
1173:         ENDWITH
1174: 
1175:         *-- TextBox Hist: top=358+29=387, left=112, width=300
1176:         loc_oPagina.AddObject("txt_4c_Hist", "TextBox")
1177:         WITH loc_oPagina.txt_4c_Hist
1178:             .Value    = ""
1179:             .Top      = 387
1180:             .Left     = 112
1181:             .Width    = 300
1182:             .Height   = 20
1183:             .FontName = "Tahoma"
1184:             .FontSize = 8
1185:         ENDWITH
1186: 
1187:         *-- TextBox Hist2: top=358+29=387, left=415, width=300
1188:         loc_oPagina.AddObject("txt_4c_Hist2", "TextBox")
1189:         WITH loc_oPagina.txt_4c_Hist2
1190:             .Value    = ""
1191:             .Top      = 387
1192:             .Left     = 415
1193:             .Width    = 300
1194:             .Height   = 20
1195:             .FontName = "Tahoma"
1196:             .FontSize = 8
1197:         ENDWITH
1198: 
1199:         *-- Label Lancar Contas (Say19): top=362+29=391, left=758
1200:         loc_oPagina.AddObject("lbl_4c_LancarContas", "Label")
1201:         WITH loc_oPagina.lbl_4c_LancarContas
1202:             .Caption   = "Lan" + CHR(231) + "ar Contas :"
1203:             .Top       = 391
1204:             .Left      = 758
1205:             .Width     = 80
1206:             .Height    = 17
1207:             .BackStyle = 0
1208:             .ForeColor = RGB(90, 90, 90)
1209:             .FontName  = "Tahoma"
1210:             .FontSize  = 8
1211:         ENDWITH
1212: 
1213:         *-- OptionGroup Opcao_conta: top=356+29=385, left=844, width=99, height=27
1214:         *-- ButtonCount=2: Sim(1) / Nao(2)
1215:         loc_oPagina.AddObject("opt_4c_LancarContas", "OptionGroup")
1216:         WITH loc_oPagina.opt_4c_LancarContas
1217:             .Top         = 385
1218:             .Left        = 844
1219:             .Width       = 99
1220:             .Height      = 27
1221:             .ButtonCount = 2
1222:             .Value       = 1
1223:             .BorderStyle = 0
1224:             .Themes      = .F.
1225:         ENDWITH
1226: 
1227:         WITH loc_oPagina.opt_4c_LancarContas
1228:             .Buttons(1).Caption   = "Sim"
1229:             .Buttons(1).Top       = 4
1230:             .Buttons(1).Left      = 2
1231:             .Buttons(1).Width     = 45
1232:             .Buttons(1).Height    = 17
1233:             .Buttons(1).AutoSize  = .F.
1234:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1235:             .Buttons(1).Themes    = .F.
1236:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1237:             .Buttons(2).Top       = 4
1238:             .Buttons(2).Left      = 50
1239:             .Buttons(2).Width     = 45
1240:             .Buttons(2).Height    = 17
1241:             .Buttons(2).AutoSize  = .F.
1242:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1243:             .Buttons(2).Themes    = .F.

*-- Linhas 1323 a 1341:
1323:                 loc_oGrid.Column11.ControlSource = "cursor_4c_Dados.Sopers"
1324: 
1325:                 *-- Redefinir headers APOS RecordSource (Problema 6/32: RecordSource reseta)
1326:                 loc_oGrid.Column1.Header1.Caption  = "Data"
1327:                 loc_oGrid.Column2.Header1.Caption  = "O"
1328:                 loc_oGrid.Column3.Header1.Caption  = "Conta"
1329:                 loc_oGrid.Column4.Header1.Caption  = "Contrapartida"
1330:                 loc_oGrid.Column5.Header1.Caption  = "Hist" + CHR(243) + "rico"
1331:                 loc_oGrid.Column6.Header1.Caption  = "D" + CHR(233) + "bito"
1332:                 loc_oGrid.Column7.Header1.Caption  = "Cr" + CHR(233) + "dito"
1333:                 loc_oGrid.Column8.Header1.Caption  = ""
1334:                 loc_oGrid.Column9.Header1.Caption  = "NF"
1335:                 loc_oGrid.Column10.Header1.Caption = "Documento"
1336:                 loc_oGrid.Column11.Header1.Caption = " "
1337: 
1338:                 *-- Redefinir larguras apos RecordSource
1339:                 loc_oGrid.Column1.Width  = 71
1340:                 loc_oGrid.Column2.Width  = 20
1341:                 loc_oGrid.Column3.Width  = 90

*-- Linhas 2290 a 2300:
2290:             ENDIF
2291: 
2292:             *-- Botoes Cotacao ($): apenas em modo edicao
2293:             IF PEMSTATUS(loc_oPg2, "cmd_4c_AlteraCotacao", 5)
2294:                 loc_oPg2.cmd_4c_AlteraCotacao.Enabled  = loc_lEdit
2295:                 loc_oPg2.cmd_4c_AlterasCotacao.Enabled = loc_lEdit
2296:             ENDIF
2297: 
2298:             *-- Usuario: sempre somente leitura (legado: When = .F.)
2299:             loc_oPg2.txt_4c_Usuario.Enabled = .F.
2300:         CATCH TO loc_oErro

*-- Linhas 2314 a 2323:
2314:         TRY
2315:             *-- Botao Confirmar (Salvar): habilitado apenas em edicao
2316:             IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesDados", 5)
2317:                 IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesDados, "cmd_4c_Confirmar", 5)
2318:                     loc_oPg2.cnt_4c_BotoesDados.cmd_4c_Confirmar.Enabled = loc_lPodeEditar
2319:                 ENDIF
2320:             ENDIF
2321:         CATCH TO loc_oErro
2322:             MsgErro("Erro em AjustarBotoesPorModo: " + loc_oErro.Message, "Erro")
2323:         ENDTRY


### BO (C:\4c\projeto\app\classes\sigmvccrBO.prg):
*******************************************************************************
* sigmvccrBO.prg - Business Object para Conta Corrente Geral
* Tabela : SigMvCcr
* Herda de: BusinessBase
* PK      : Cidchaves (char 20, clustered)
* Chave negocio: Emps + Nopers
* Fase   : 2/8 - Metodos CRUD completos
*******************************************************************************

DEFINE CLASS sigmvccrBO AS BusinessBase

    *===========================================================================
    * IDENTIFICACAO DO REGISTRO
    *===========================================================================
    this_cEmps           = ""    && Empresa (C3)
    this_nNopers         = 0     && Numero da operacao (N7)
    this_cCidChaves      = ""    && Chave unica - PK (C20)

    *===========================================================================
    * DATAS
    *===========================================================================
    this_dDatas          = {}    && Data do lancamento (T NULL)
    this_dVencs          = {}    && Vencimento (T NULL)
    this_dDtEmis         = {}    && Data de emissao - coluna Dtemis (T NULL)
    this_dDatalts        = {}    && Data da alteracao (T NULL)
    this_dDatExcs        = {}    && Data da exclusao logica (T NULL)
    this_dDataConcs      = {}    && Data de conciliacao (T NULL)
    this_dDataTrans      = {}    && Data de transferencia (T NULL)

    *===========================================================================
    * OPERACAO PRINCIPAL (lado debito/credito)
    *===========================================================================
    this_cOpers          = ""    && Operacao D/C (C1)
    this_cGrupos         = ""    && Grupo conta corrente - ref SigCdGcr.Codigos (C10)
    this_cDGrupos        = ""    && Descricao do grupo (derivada via fAcessoContab) (C50)
    this_cContas         = ""    && Conta corrente (C10)
    this_cDContas        = ""    && Descricao da conta (derivada) (C50)
    this_cMoedas         = ""    && Moeda - ref SigCdMoe.CMoes (C3)
    this_nValors         = 0     && Valor do lancamento (N11,2)
    this_nCotacaos       = 0     && Cotacao / cambio (N15,7)

    *===========================================================================
    * OPERACAO SIMETRICA (contrapartida)
    *===========================================================================
    this_cSopers         = ""    && Operacao simetrica D/C (C1)
    this_cSGrupos        = ""    && Grupo simetrico - ref SigCdGcr.Codigos (C10)
    this_cSDGrupos       = ""    && Descricao grupo simetrico (derivada) (C50)
    this_cSContas        = ""    && Conta simetrica (C10)
    this_cSDContas       = ""    && Descricao conta simetrica (derivada) (C50)
    this_cSMoedas        = ""    && Moeda simetrica - ref SigCdMoe.CMoes (C3)
    this_nSValors        = 0     && Valor simetrico (N11,2)
    this_nSCotacaos      = 0     && Cotacao simetrica (N15,7)
    this_cShists         = ""    && Historico simetrico (C40) - coluna Shists

    *===========================================================================
    * HISTORICO E DOCUMENTOS
    *===========================================================================
    this_cHists          = ""    && Historico principal (C60 NULL)
    this_cHist2s         = ""    && Historico complementar (C80 NULL) - coluna Hist2s
    this_cNotas          = ""    && Nota fiscal - coluna Nfs (C10)
    this_cDocus          = ""    && Documento (C10)

    *===========================================================================
    * JOB
    *===========================================================================
    this_cJobs           = ""    && Job (conta tipo 10) - coluna Jobs (C10)
    this_cDJobs          = ""    && Descricao do job (derivada via fAcessoContas) (C50)

    *===========================================================================
    * AUDITORIA E CONTROLE
    *===========================================================================
    this_cUsualts        = ""    && Usuario da alteracao (C10)
    this_cUsuExcs        = ""    && Usuario da exclusao logica (C10)
    this_lAutos          = .F.   && Flag automatico (bit)
    this_lConcs          = .F.   && Flag conciliado (bit)
    this_cUsuConcs       = ""    && Usuario da conciliacao (C10)
    this_cAuditors       = ""    && Auditor (C10)
    this_dDtAudits       = {}    && Data de auditoria (T NULL)

    *===========================================================================
    * CAMPOS INTERNOS DO SISTEMA LEGADO
    *===========================================================================
    this_cVopers         = ""    && Operacao vinculada (C13)
    this_nNumes          = 0     && Numero vinculado - nota pagamento (N6)
    this_cDopes          = ""    && Documento de operacao (C20)
    this_cDopcs          = ""    && Documento de operacao complementar (C20)
    this_nNumcs          = 0     && Numero complementar (N6)
    this_cCotUsus        = ""    && Cotacao informada pelo usuario (C10)
    this_nContaPgs       = 0     && Lancar contas: 0=Nao, outros=Sim (N1)
    this_cGruConMoes     = ""    && Grupo+Conta+Moeda concatenados (C23)
    this_nNlancs         = 0     && Numero de lancamentos (N6)
    this_nNtrans         = 0     && Numero de transacao (N6)
    this_cLocals         = ""    && Local (C10)
    this_cContages       = ""    && Conta de agencia (C10)
    this_cContems        = ""    && Conta empresa (C10)
    this_cTipos          = ""    && Tipo (C1)
    this_cVlancs         = ""    && Valor de lancamento referencia (C10)
    this_cTitulos        = ""    && Titulo vinculado (C10)
    this_cTitBans        = ""    && Titulo bancario (C12)
    this_cGrupages       = ""    && Grupo de agencia (C10)
    this_cGrupems        = ""    && Grupo empresa (C10)
    this_cBContas        = ""    && Banco conta (C10)
    this_cBGrupos        = ""    && Banco grupo (C10)
    this_nBorderos       = 0     && Numero do border? (N6)
    this_nIntConts       = 0     && Numero de integracao (N6)
    this_nSaldos         = 0     && Saldo (N15,2)
    this_nSaldoNs        = 0     && Saldo novo (N15,2)
    this_nSaldoCs        = 0     && Saldo credito (N15,2)
    this_nValpags        = 0     && Valor pago (N11,2)
    this_nValliqs        = 0     && Valor liquido (N11,2)
    this_nValocurs       = 0     && Valor outra moeda (N11,2)
    this_nValprev        = 0     && Valor previsto (N11,2)
    this_cEmpdopncs      = ""    && Emps+Dopes+Numcs composto (C29)
    this_cEmpdopnums     = ""    && Emps+Dopes+Numes composto (C29)
    this_cPagos          = ""    && Flag pago (C1)
    this_cDopotps        = ""    && Documento operacao tipo (C23)
    this_cUsupagos       = ""    && Usuario do pagamento (C10)
    this_nTitcancs       = 0     && Titulo cancelado (N1)
    this_dDtConfs        = {}    && Data de confirmacao (T NULL)
    this_cUsuConfs       = ""    && Usuario de confirmacao (C10)
    this_nNopercancs     = 0     && Nopers cancelado (N7)
    this_cEspecienfs     = ""    && Especie da NF (C6)
    this_nImpostos       = 0     && Impostos (N11,2)
    this_nTpimpostos     = 0     && Tipo de imposto (N2)
    this_cTitPais        = ""    && Titulo pai (C10)
    this_cEmpccs         = ""    && Empresa CC (C3)
    this_nRecor          = 0     && Recorrente (N1)
    this_cCompet         = ""    && Competencia (C7)
    this_cEmpos          = ""    && Empresa operacao (C3)
    this_cOridopnums     = ""    && Documento origem (C29)
    this_cRContas        = ""    && Conta referencia (C10)
    this_cTpdocnf        = ""    && Tipo documento NF (C2)

    *===========================================================================
    * EXIBICAO SOMENTE (derivadas, sem coluna direta no banco)
    *===========================================================================
    this_cUsuarioDisplay = ""    && Usuario logado (somente leitura - get_Usuario)

    *===========================================================================
    * INIT - Configura tabela e campo chave
    *===========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigMvCcr"
        THIS.this_cCampoChave = "Cidchaves"
        RETURN .T.
    ENDPROC

    *===========================================================================
    * OBTERCHAVEPRIMARIA - Retorna chave para registro de auditoria
    *===========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *===========================================================================
    * BUSCAR - Lista lancamentos filtrados (sem filtro de periodo)
    * par_cFiltro: filtro SQL adicional (ex: "Contas = '001'" - sem AND)
    * Cria cursor cursor_4c_Dados com colunas do grid
    *===========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cEmps, loc_cExtra
        loc_lSucesso = .F.

        TRY
            loc_cEmps  = go_4c_Sistema.cCodEmpresa
            loc_cExtra = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                loc_cExtra = " AND " + par_cFiltro
            ENDIF

            loc_cSQL = "SELECT a.Emps, a.Nopers, a.Cidchaves," + ;
                " a.Datas, a.Vencs, a.Dtemis," + ;
                " a.Opers, a.Grupos, a.Contas, a.Moedas, a.Valors, a.Cotacaos," + ;
                " a.Sopers, a.Sgrupos, a.Scontas, a.Smoedas, a.Svalors, a.Scotacaos," + ;
                " a.Hists, a.Hist2s, a.Shists, a.Nfs, a.Docus," + ;
                " a.Jobs, a.Tipos, a.Usualts, a.Usuexcs," + ;
                " a.Concs, a.Contapgs, a.Datexcs," + ;
                " a.Dopes, a.Dopcs, a.Numes, a.Numcs," + ;
                " a.Cotusus, a.Gruconmoes, a.Vopers, a.Vlancs" + ;
                " FROM SigMvCcr a" + ;
                " WHERE a.Emps = " + EscaparSQL(loc_cEmps) + ;
                loc_cExtra + ;
                " ORDER BY a.Datas DESC, a.Nopers DESC"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult < 0
                MsgErro("Erro ao buscar lan" + CHR(231) + "amentos:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ELSE
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Buscar: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * BUSCARPORPERIODO - Lista lancamentos filtrados por intervalo de datas
    * par_dDtInicial : data inicial (inclusive)
    * par_dDtFinal   : data final   (inclusive)
    * par_cFiltroExtra: filtro SQL adicional opcional (sem AND)
    * Cria cursor cursor_4c_Dados com colunas do grid
    *===========================================================================
    FUNCTION BuscarPorPeriodo(par_dDtInicial, par_dDtFinal, par_cFiltroExtra)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        LOCAL loc_cEmps, loc_cDtI, loc_cDtF, loc_cExtra
        loc_lSucesso = .F.

        TRY
            loc_cEmps  = go_4c_Sistema.cCodEmpresa
            loc_cDtI   = FormatarDataSQL(par_dDtInicial)
            loc_cDtF   = FormatarDataSQL(par_dDtFinal)
            loc_cExtra = ""
            IF VARTYPE(par_cFiltroExtra) = "C" AND !EMPTY(par_cFiltroExtra)
                loc_cExtra = " AND " + par_cFiltroExtra
            ENDIF

            loc_cSQL = "SELECT a.Emps, a.Nopers, a.Cidchaves," + ;
                " a.Datas, a.Vencs, a.Dtemis," + ;
                " a.Opers, a.Grupos, a.Contas, a.Moedas, a.Valors, a.Cotacaos," + ;
                " a.Sopers, a.Sgrupos, a.Scontas, a.Smoedas, a.Svalors, a.Scotacaos," + ;
                " a.Hists, a.Hist2s, a.Shists, a.Nfs, a.Docus," + ;
                " a.Jobs, a.Tipos, a.Usualts, a.Usuexcs," + ;
                " a.Concs, a.Contapgs, a.Datexcs," + ;
                " a.Dopes, a.Dopcs, a.Numes, a.Numcs," + ;
                " a.Cotusus, a.Gruconmoes, a.Vopers, a.Vlancs" + ;
                " FROM SigMvCcr a" + ;
                " WHERE a.Emps = " + EscaparSQL(loc_cEmps) + ;
                "   AND a.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF + ;
                loc_cExtra + ;
                " ORDER BY a.Datas, a.Nopers"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult < 0
                MsgErro("Erro ao buscar lan" + CHR(231) + "amentos:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ELSE
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BuscarPorPeriodo: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * CARREGARPORCODIGO - Carrega lancamento pela PK (Cidchaves)
    * par_cCodigo: valor de Cidchaves
    *===========================================================================
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.Emps, a.Nopers, a.Cidchaves," + ;
                " a.Datas, a.Vencs, a.Dtemis, a.Datalts, a.Datexcs, a.Dataconcs," + ;
                " a.Opers, a.Grupos, a.Contas, a.Moedas, a.Valors, a.Cotacaos," + ;
                " a.Sopers, a.Sgrupos, a.Scontas, a.Smoedas, a.Svalors, a.Scotacaos," + ;
                " a.Hists, a.Hist2s, a.Shists, a.Nfs, a.Docus," + ;
                " a.Jobs, a.Tipos, a.Vlancs," + ;
                " a.Usualts, a.Usuexcs, a.Autos, a.Concs," + ;
                " a.Usuconcs, a.Auditors, a.Dtaudits," + ;
                " a.Contapgs, a.Vopers, a.Numes, a.Dopes, a.Dopcs, a.Numcs," + ;
                " a.Cotusus, a.Gruconmoes, a.Locals, a.Contages, a.Contems," + ;
                " a.Titulos, a.Titbans, a.Grupages, a.Grupems," + ;
                " a.Bcontas, a.Bgrupos, a.Borderos, a.Intconts," + ;
                " a.Saldos, a.Saldons, a.Saldocs, a.Valpags, a.Valliqs, a.Valocurs, a.Valprev," + ;
                " a.Empdopncs, a.Empdopnums, a.Pagos, a.Dopotps, a.Usupagos," + ;
                " a.Titcancs, a.Dtconfs, a.Usuconfs, a.Nopercancs, a.Especienfs," + ;
                " a.Impostos, a.Tpimpostos, a.Titpais, a.Empccs, a.Recor," + ;
                " a.Compet, a.Empos, a.Oridopnums, a.Rcontas, a.Tpdocnf," + ;
                " a.Nlancs, a.Ntrans" + ;
                " FROM SigMvCcr a" + ;
                " WHERE a.Cidchaves = " + EscaparSQL(par_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult < 0
                MsgErro("Erro ao carregar lan" + CHR(231) + "amento:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ELSE
                IF RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                loc_lSucesso = .F.
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * CARREGARPORNOPERS - Carrega lancamento pela chave de negocio (Emps + Nopers)
    * par_cEmps  : empresa
    * par_nNopers: numero da operacao
    *===========================================================================
    FUNCTION CarregarPorNopers(par_cEmps, par_nNopers)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.Emps, a.Nopers, a.Cidchaves," + ;
                " a.Datas, a.Vencs, a.Dtemis, a.Datalts, a.Datexcs, a.Dataconcs," + ;
                " a.Opers, a.Grupos, a.Contas, a.Moedas, a.Valors, a.Cotacaos," + ;
                " a.Sopers, a.Sgrupos, a.Scontas, a.Smoedas, a.Svalors, a.Scotacaos," + ;
                " a.Hists, a.Hist2s, a.Shists, a.Nfs, a.Docus," + ;
                " a.Jobs, a.Tipos, a.Vlancs," + ;
                " a.Usualts, a.Usuexcs, a.Autos, a.Concs," + ;
                " a.Usuconcs, a.Auditors, a.Dtaudits," + ;
                " a.Contapgs, a.Vopers, a.Numes, a.Dopes, a.Dopcs, a.Numcs," + ;
                " a.Cotusus, a.Gruconmoes, a.Locals, a.Contages, a.Contems," + ;
                " a.Titulos, a.Titbans, a.Grupages, a.Grupems," + ;
                " a.Bcontas, a.Bgrupos, a.Borderos, a.Intconts," + ;
                " a.Saldos, a.Saldons, a.Saldocs, a.Valpags, a.Valliqs, a.Valocurs, a.Valprev," + ;
                " a.Empdopncs, a.Empdopnums, a.Pagos, a.Dopotps, a.Usupagos," + ;
                " a.Titcancs, a.Dtconfs, a.Usuconfs, a.Nopercancs, a.Especienfs," + ;
                " a.Impostos, a.Tpimpostos, a.Titpais, a.Empccs, a.Recor," + ;
                " a.Compet, a.Empos, a.Oridopnums, a.Rcontas, a.Tpdocnf," + ;
                " a.Nlancs, a.Ntrans" + ;
                " FROM SigMvCcr a" + ;
                " WHERE a.Emps = " + EscaparSQL(par_cEmps) + ;
                "   AND a.Nopers = " + FormatarNumeroSQL(par_nNopers)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult < 0
                MsgErro("Erro ao carregar:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ELSE
                IF RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                loc_lSucesso = .F.
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorNopers: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * CARREGARDOCURSOR - Transfere dados do cursor para as propriedades this_*
    * par_cAliasCursor: nome do cursor (deve estar selecionado ou existir)
    *===========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cCidChaves  = TratarNulo(Cidchaves,  "C")
                THIS.this_cEmps       = TratarNulo(Emps,       "C")
                THIS.this_nNopers     = TratarNulo(Nopers,     "N")
                THIS.this_dDatas      = TratarNulo(Datas,      "D")
                THIS.this_dVencs      = TratarNulo(Vencs,      "D")
                THIS.this_dDtEmis     = TratarNulo(Dtemis,     "D")
                THIS.this_cOpers      = TratarNulo(Opers,      "C")
                THIS.this_cGrupos     = TratarNulo(Grupos,     "C")
                THIS.this_cContas     = TratarNulo(Contas,     "C")
                THIS.this_cMoedas     = TratarNulo(Moedas,     "C")
                THIS.this_nValors     = TratarNulo(Valors,     "N")
                THIS.this_nCotacaos   = TratarNulo(Cotacaos,   "N")
                THIS.this_cSopers     = TratarNulo(Sopers,     "C")
                THIS.this_cSGrupos    = TratarNulo(Sgrupos,    "C")
                THIS.this_cSContas    = TratarNulo(Scontas,    "C")
                THIS.this_cSMoedas    = TratarNulo(Smoedas,    "C")
                THIS.this_nSValors    = TratarNulo(Svalors,    "N")
                THIS.this_nSCotacaos  = TratarNulo(Scotacaos,  "N")
                THIS.this_cShists     = TratarNulo(Shists,     "C")
                THIS.this_cHists      = TratarNulo(Hists,      "C")
                THIS.this_cNotas      = TratarNulo(Nfs,        "C")
                THIS.this_cDocus      = TratarNulo(Docus,      "C")
                THIS.this_cJobs       = TratarNulo(Jobs,       "C")
                THIS.this_cTipos      = TratarNulo(Tipos,      "C")
                THIS.this_cUsualts    = TratarNulo(Usualts,    "C")
                THIS.this_cUsuExcs    = TratarNulo(Usuexcs,    "C")
                THIS.this_lAutos      = (NVL(Autos,  0) = 1)
                THIS.this_lConcs      = (NVL(Concs,  0) = 1)
                THIS.this_nContaPgs   = TratarNulo(Contapgs,  "N")
                THIS.this_cVopers     = TratarNulo(Vopers,    "C")
                THIS.this_nNumes      = TratarNulo(Numes,     "N")
                THIS.this_cDopes      = TratarNulo(Dopes,     "C")
                THIS.this_cDopcs      = TratarNulo(Dopcs,     "C")
                THIS.this_nNumcs      = TratarNulo(Numcs,     "N")
                THIS.this_cCotUsus    = TratarNulo(Cotusus,   "C")
                THIS.this_cGruConMoes = TratarNulo(Gruconmoes,"C")
                THIS.this_cVlancs     = TratarNulo(Vlancs,    "C")

                *-- Campos opcionais (apenas em carregamento completo - CarregarPorCodigo)
                IF TYPE("Hist2s") != "U"
                    THIS.this_cHist2s = TratarNulo(Hist2s, "C")
                ENDIF
                IF TYPE("Datalts") != "U"
                    THIS.this_dDatalts = TratarNulo(Datalts, "D")
                ENDIF
                IF TYPE("Datexcs") != "U"
                    THIS.this_dDatExcs = TratarNulo(Datexcs, "D")
                ENDIF
                IF TYPE("Dataconcs") != "U"
                    THIS.this_dDataConcs = TratarNulo(Dataconcs, "D")
                ENDIF
                IF TYPE("Usuconcs") != "U"
                    THIS.this_cUsuConcs = TratarNulo(Usuconcs, "C")
                ENDIF
                IF TYPE("Auditors") != "U"
                    THIS.this_cAuditors = TratarNulo(Auditors, "C")
                ENDIF
                IF TYPE("Dtaudits") != "U"
                    THIS.this_dDtAudits = TratarNulo(Dtaudits, "D")
                ENDIF
                IF TYPE("Locals") != "U"
                    THIS.this_cLocals = TratarNulo(Locals, "C")
                ENDIF
                IF TYPE("Contages") != "U"
                    THIS.this_cContages = TratarNulo(Contages, "C")
                ENDIF
                IF TYPE("Contems") != "U"
                    THIS.this_cContems = TratarNulo(Contems, "C")
                ENDIF
                IF TYPE("Titulos") != "U"
                    THIS.this_cTitulos = TratarNulo(Titulos, "C")
                ENDIF
                IF TYPE("Titbans") != "U"
                    THIS.this_cTitBans = TratarNulo(Titbans, "C")
                ENDIF
                IF TYPE("Grupages") != "U"
                    THIS.this_cGrupages = TratarNulo(Grupages, "C")
                ENDIF
                IF TYPE("Grupems") != "U"
                    THIS.this_cGrupems = TratarNulo(Grupems, "C")
                ENDIF
                IF TYPE("Bcontas") != "U"
                    THIS.this_cBContas = TratarNulo(Bcontas, "C")
                ENDIF
                IF TYPE("Bgrupos") != "U"
                    THIS.this_cBGrupos = TratarNulo(Bgrupos, "C")
                ENDIF
                IF TYPE("Borderos") != "U"
                    THIS.this_nBorderos = TratarNulo(Borderos, "N")
                ENDIF
                IF TYPE("Intconts") != "U"
                    THIS.this_nIntConts = TratarNulo(Intconts, "N")
                ENDIF
                IF TYPE("Saldos") != "U"
                    THIS.this_nSaldos = TratarNulo(Saldos, "N")
                ENDIF
                IF TYPE("Saldons") != "U"
                    THIS.this_nSaldoNs = TratarNulo(Saldons, "N")
                ENDIF
                IF TYPE("Saldocs") != "U"
                    THIS.this_nSaldoCs = TratarNulo(Saldocs, "N")
                ENDIF
                IF TYPE("Valpags") != "U"
                    THIS.this_nValpags = TratarNulo(Valpags, "N")
                ENDIF
                IF TYPE("Valliqs") != "U"
                    THIS.this_nValliqs = TratarNulo(Valliqs, "N")
                ENDIF
                IF TYPE("Valocurs") != "U"
                    THIS.this_nValocurs = TratarNulo(Valocurs, "N")
                ENDIF
                IF TYPE("Valprev") != "U"
                    THIS.this_nValprev = TratarNulo(Valprev, "N")
                ENDIF
                IF TYPE("Empdopncs") != "U"
                    THIS.this_cEmpdopncs = TratarNulo(Empdopncs, "C")
                ENDIF
                IF TYPE("Empdopnums") != "U"
                    THIS.this_cEmpdopnums = TratarNulo(Empdopnums, "C")
                ENDIF
                IF TYPE("Pagos") != "U"
                    THIS.this_cPagos = TratarNulo(Pagos, "C")
                ENDIF
                IF TYPE("Dopotps") != "U"
                    THIS.this_cDopotps = TratarNulo(Dopotps, "C")
                ENDIF
                IF TYPE("Usupagos") != "U"
                    THIS.this_cUsupagos = TratarNulo(Usupagos, "C")
                ENDIF
                IF TYPE("Titcancs") != "U"
                    THIS.this_nTitcancs = TratarNulo(Titcancs, "N")
                ENDIF
                IF TYPE("Dtconfs") != "U"
                    THIS.this_dDtConfs = TratarNulo(Dtconfs, "D")
                ENDIF
                IF TYPE("Usuconfs") != "U"
                    THIS.this_cUsuConfs = TratarNulo(Usuconfs, "C")
                ENDIF
                IF TYPE("Nopercancs") != "U"
                    THIS.this_nNopercancs = TratarNulo(Nopercancs, "N")
                ENDIF
                IF TYPE("Especienfs") != "U"
                    THIS.this_cEspecienfs = TratarNulo(Especienfs, "C")
                ENDIF
                IF TYPE("Impostos") != "U"
                    THIS.this_nImpostos = TratarNulo(Impostos, "N")
                ENDIF
                IF TYPE("Tpimpostos") != "U"
                    THIS.this_nTpimpostos = TratarNulo(Tpimpostos, "N")
                ENDIF
                IF TYPE("Titpais") != "U"
                    THIS.this_cTitPais = TratarNulo(Titpais, "C")
                ENDIF
                IF TYPE("Empccs") != "U"
                    THIS.this_cEmpccs = TratarNulo(Empccs, "C")
                ENDIF
                IF TYPE("Recor") != "U"
                    THIS.this_nRecor = TratarNulo(Recor, "N")
                ENDIF
                IF TYPE("Compet") != "U"
                    THIS.this_cCompet = TratarNulo(Compet, "C")
                ENDIF
                IF TYPE("Empos") != "U"
                    THIS.this_cEmpos = TratarNulo(Empos, "C")
                ENDIF
                IF TYPE("Oridopnums") != "U"
                    THIS.this_cOridopnums = TratarNulo(Oridopnums, "C")
                ENDIF
                IF TYPE("Rcontas") != "U"
                    THIS.this_cRContas = TratarNulo(Rcontas, "C")
                ENDIF
                IF TYPE("Tpdocnf") != "U"
                    THIS.this_cTpdocnf = TratarNulo(Tpdocnf, "C")
                ENDIF
                IF TYPE("Nlancs") != "U"
                    THIS.this_nNlancs = TratarNulo(Nlancs, "N")
                ENDIF
                IF TYPE("Ntrans") != "U"
                    THIS.this_nNtrans = TratarNulo(Ntrans, "N")
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarDoCursor: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * GERARNEXTNOPER - Gera o proximo numero de operacao para a empresa corrente
    * Retorna 0 em caso de erro
    *===========================================================================
    PROTECTED FUNCTION GerarNextNoper()
        LOCAL loc_cSQL, loc_nResult, loc_nProxNoper
        loc_nProxNoper = 0

        TRY
            loc_cSQL = "SELECT ISNULL(MAX(Nopers), 0) + 1 AS ProxNoper" + ;
                " FROM SigMvCcr" + ;
                " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProxNoper")

            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ProxNoper") > 0
                SELECT cursor_4c_ProxNoper
                loc_nProxNoper = TratarNulo(ProxNoper, "N")
            ENDIF

            IF USED("cursor_4c_ProxNoper")
                USE IN cursor_4c_ProxNoper
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao gerar pr" + CHR(243) + "ximo noper: " + loc_oErro.Message, "Erro")
            loc_nProxNoper = 0
        ENDTRY

        RETURN loc_nProxNoper
    ENDFUNC

    *===========================================================================
    * INSERIR - Insere novo lancamento em SigMvCcr
    * Gera automaticamente: Nopers, Cidchaves, Gruconmoes, Emps
    *===========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        LOCAL loc_nNopers, loc_cCidChaves, loc_cGruConMoes
        loc_lSucesso = .F.

        TRY
            *-- Gera proximo nopers
            loc_nNopers = THIS.GerarNextNoper()
            IF loc_nNopers <= 0
                MsgErro("Erro ao gerar n" + CHR(250) + "mero de opera" + CHR(231) + CHR(227) + "o!", "Erro")
                loc_lSucesso = .F.
            ELSE
                *-- Gera cidchaves: AAAAMMDD + 6 digitos do nopers (formato do legado)
                loc_cCidChaves = DTOS(IIF(EMPTY(THIS.this_dDatas), DATE(), THIS.this_dDatas)) + ;
                    PADL(LTRIM(STR(loc_nNopers)), 6, "0")

            *-- Gera gruconmoes (grupos+contas+moedas concatenados)
            loc_cGruConMoes = PADR(ALLTRIM(THIS.this_cGrupos), 10) + ;
                PADR(ALLTRIM(THIS.this_cContas), 10) + ;
                PADR(ALLTRIM(THIS.this_cMoedas), 3)

            *-- Atualiza propriedades geradas
            THIS.this_nNopers     = loc_nNopers
            THIS.this_cCidChaves  = loc_cCidChaves
            THIS.this_cGruConMoes = loc_cGruConMoes
            THIS.this_cEmps       = go_4c_Sistema.cCodEmpresa
            THIS.this_lAutos      = .F.
            THIS.this_cUsualts    = gc_4c_UsuarioLogado
            THIS.this_dDatalts    = DATETIME()

            loc_cSQL = "INSERT INTO SigMvCcr (" + ;
                "Emps, Nopers, Cidchaves," + ;
                " Datas, Vencs, Dtemis," + ;
                " Opers, Grupos, Contas, Moedas, Valors, Cotacaos," + ;
                " Sopers, Sgrupos, Scontas, Smoedas, Svalors, Scotacaos," + ;
                " Hists, Hist2s, Shists, Nfs, Docus," + ;
                " Jobs, Tipos, Vlancs," + ;
                " Usualts, Datalts, Autos, Concs," + ;
                " Usuconcs, Auditors," + ;
                " Contapgs, Vopers, Numes, Dopes, Dopcs, Numcs," + ;
                " Cotusus, Gruconmoes," + ;
                " Locals, Contages, Contems," + ;
                " Titulos, Titbans, Grupages, Grupems," + ;
                " Bcontas, Bgrupos, Borderos, Intconts," + ;
                " Saldos, Saldons, Saldocs, Valpags, Valliqs, Valocurs, Valprev," + ;
                " Empdopncs, Empdopnums, Pagos, Dopotps, Usupagos," + ;
                " Titcancs, Usuconfs, Nopercancs, Especienfs," + ;
                " Impostos, Tpimpostos, Titpais, Empccs, Recor," + ;
                " Compet, Empos, Oridopnums, Rcontas, Tpdocnf," + ;
                " Nlancs, Ntrans, Usuexcs" + ;
                ") VALUES (" + ;
                EscaparSQL(THIS.this_cEmps) + "," + ;
                FormatarNumeroSQL(THIS.this_nNopers) + "," + ;
                EscaparSQL(loc_cCidChaves) + "," + ;
                IIF(EMPTY(THIS.this_dDatas), "NULL", FormatarDataSQL(THIS.this_dDatas)) + "," + ;
                IIF(EMPTY(THIS.this_dVencs), "NULL", FormatarDataSQL(THIS.this_dVencs)) + "," + ;
                IIF(EMPTY(THIS.this_dDtEmis), "NULL", FormatarDataSQL(THIS.this_dDtEmis)) + "," + ;
                EscaparSQL(THIS.this_cOpers) + "," + ;
                EscaparSQL(THIS.this_cGrupos) + "," + ;
                EscaparSQL(THIS.this_cContas) + "," + ;
                EscaparSQL(THIS.this_cMoedas) + "," + ;
                FormatarNumeroSQL(THIS.this_nValors) + "," + ;
                FormatarNumeroSQL(THIS.this_nCotacaos) + "," + ;
                EscaparSQL(THIS.this_cSopers) + "," + ;
                EscaparSQL(THIS.this_cSGrupos) + "," + ;
                EscaparSQL(THIS.this_cSContas) + "," + ;
                EscaparSQL(THIS.this_cSMoedas) + "," + ;
                FormatarNumeroSQL(THIS.this_nSValors) + "," + ;
                FormatarNumeroSQL(THIS.this_nSCotacaos) + "," + ;
                EscaparSQL(THIS.this_cHists) + "," + ;
                EscaparSQL(THIS.this_cHist2s) + "," + ;
                EscaparSQL(THIS.this_cShists) + "," + ;
                EscaparSQL(THIS.this_cNotas) + "," + ;
                EscaparSQL(THIS.this_cDocus) + "," + ;
                EscaparSQL(THIS.this_cJobs) + "," + ;
                EscaparSQL(THIS.this_cTipos) + "," + ;
                EscaparSQL(THIS.this_cVlancs) + "," + ;
                EscaparSQL(THIS.this_cUsualts) + "," + ;
                FormatarDataSQL(THIS.this_dDatalts) + "," + ;
                IIF(THIS.this_lAutos, "1", "0") + "," + ;
                IIF(THIS.this_lConcs, "1", "0") + "," + ;
                EscaparSQL(THIS.this_cUsuConcs) + "," + ;
                EscaparSQL(THIS.this_cAuditors) + "," + ;
                FormatarNumeroSQL(THIS.this_nContaPgs) + "," + ;
                EscaparSQL(THIS.this_cVopers) + "," + ;
                FormatarNumeroSQL(THIS.this_nNumes) + "," + ;
                EscaparSQL(THIS.this_cDopes) + "," + ;
                EscaparSQL(THIS.this_cDopcs) + "," + ;
                FormatarNumeroSQL(THIS.this_nNumcs) + "," + ;
                EscaparSQL(THIS.this_cCotUsus) + "," + ;
                EscaparSQL(loc_cGruConMoes) + "," + ;
                EscaparSQL(THIS.this_cLocals) + "," + ;
                EscaparSQL(THIS.this_cContages) + "," + ;
                EscaparSQL(THIS.this_cContems) + "," + ;
                EscaparSQL(THIS.this_cTitulos) + "," + ;
                EscaparSQL(THIS.this_cTitBans) + "," + ;
                EscaparSQL(THIS.this_cGrupages) + "," + ;
                EscaparSQL(THIS.this_cGrupems) + "," + ;
                EscaparSQL(THIS.this_cBContas) + "," + ;
                EscaparSQL(THIS.this_cBGrupos) + "," + ;
                FormatarNumeroSQL(THIS.this_nBorderos) + "," + ;
                FormatarNumeroSQL(THIS.this_nIntConts) + "," + ;
                FormatarNumeroSQL(THIS.this_nSaldos) + "," + ;
                FormatarNumeroSQL(THIS.this_nSaldoNs) + "," + ;
                FormatarNumeroSQL(THIS.this_nSaldoCs) + "," + ;
                FormatarNumeroSQL(THIS.this_nValpags) + "," + ;
                FormatarNumeroSQL(THIS.this_nValliqs) + "," + ;
                FormatarNumeroSQL(THIS.this_nValocurs) + "," + ;
                FormatarNumeroSQL(THIS.this_nValprev) + "," + ;
                EscaparSQL(THIS.this_cEmpdopncs) + "," + ;
                EscaparSQL(THIS.this_cEmpdopnums) + "," + ;
                EscaparSQL(THIS.this_cPagos) + "," + ;
                EscaparSQL(THIS.this_cDopotps) + "," + ;
                EscaparSQL(THIS.this_cUsupagos) + "," + ;
                FormatarNumeroSQL(THIS.this_nTitcancs) + "," + ;
                EscaparSQL(THIS.this_cUsuConfs) + "," + ;
                FormatarNumeroSQL(THIS.this_nNopercancs) + "," + ;
                EscaparSQL(THIS.this_cEspecienfs) + "," + ;
                FormatarNumeroSQL(THIS.this_nImpostos) + "," + ;
                FormatarNumeroSQL(THIS.this_nTpimpostos) + "," + ;
                EscaparSQL(THIS.this_cTitPais) + "," + ;
                EscaparSQL(THIS.this_cEmpccs) + "," + ;
                FormatarNumeroSQL(THIS.this_nRecor) + "," + ;
                EscaparSQL(THIS.this_cCompet) + "," + ;
                EscaparSQL(THIS.this_cEmpos) + "," + ;
                EscaparSQL(THIS.this_cOridopnums) + "," + ;
                EscaparSQL(THIS.this_cRContas) + "," + ;
                EscaparSQL(THIS.this_cTpdocnf) + "," + ;
                FormatarNumeroSQL(THIS.this_nNlancs) + "," + ;
                FormatarNumeroSQL(THIS.this_nNtrans) + "," + ;
                EscaparSQL(THIS.this_cUsuExcs) + ;
                ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao inserir lan" + CHR(231) + "amento:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Inserir: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * ATUALIZAR - Atualiza lancamento existente identificado por Emps + Nopers
    * Atualiza apenas os campos editaveis pelo usuario na interface
    *===========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cGruConMoes
        loc_lSucesso = .F.

        TRY
            THIS.this_cUsualts    = gc_4c_UsuarioLogado
            THIS.this_dDatalts    = DATETIME()

            loc_cGruConMoes = PADR(ALLTRIM(THIS.this_cGrupos), 10) + ;
                PADR(ALLTRIM(THIS.this_cContas), 10) + ;
                PADR(ALLTRIM(THIS.this_cMoedas), 3)
            THIS.this_cGruConMoes = loc_cGruConMoes

            loc_cSQL = "UPDATE SigMvCcr SET" + ;
                " Datas      = " + IIF(EMPTY(THIS.this_dDatas), "NULL", FormatarDataSQL(THIS.this_dDatas)) + "," + ;
                " Vencs      = " + IIF(EMPTY(THIS.this_dVencs), "NULL", FormatarDataSQL(THIS.this_dVencs)) + "," + ;
                " Dtemis     = " + IIF(EMPTY(THIS.this_dDtEmis), "NULL", FormatarDataSQL(THIS.this_dDtEmis)) + "," + ;
                " Opers      = " + EscaparSQL(THIS.this_cOpers) + "," + ;
                " Grupos     = " + EscaparSQL(THIS.this_cGrupos) + "," + ;
                " Contas     = " + EscaparSQL(THIS.this_cContas) + "," + ;
                " Moedas     = " + EscaparSQL(THIS.this_cMoedas) + "," + ;
                " Valors     = " + FormatarNumeroSQL(THIS.this_nValors) + "," + ;
                " Cotacaos   = " + FormatarNumeroSQL(THIS.this_nCotacaos) + "," + ;
                " Sopers     = " + EscaparSQL(THIS.this_cSopers) + "," + ;
                " Sgrupos    = " + EscaparSQL(THIS.this_cSGrupos) + "," + ;
                " Scontas    = " + EscaparSQL(THIS.this_cSContas) + "," + ;
                " Smoedas    = " + EscaparSQL(THIS.this_cSMoedas) + "," + ;
                " Svalors    = " + FormatarNumeroSQL(THIS.this_nSValors) + "," + ;
                " Scotacaos  = " + FormatarNumeroSQL(THIS.this_nSCotacaos) + "," + ;
                " Hists      = " + EscaparSQL(THIS.this_cHists) + "," + ;
                " Hist2s     = " + EscaparSQL(THIS.this_cHist2s) + "," + ;
                " Shists     = " + EscaparSQL(THIS.this_cShists) + "," + ;
                " Nfs        = " + EscaparSQL(THIS.this_cNotas) + "," + ;
                " Docus      = " + EscaparSQL(THIS.this_cDocus) + "," + ;
                " Jobs       = " + EscaparSQL(THIS.this_cJobs) + "," + ;
                " Usualts    = " + EscaparSQL(THIS.this_cUsualts) + "," + ;
                " Datalts    = " + FormatarDataSQL(THIS.this_dDatalts) + "," + ;
                " Contapgs   = " + FormatarNumeroSQL(THIS.this_nContaPgs) + "," + ;
                " Cotusus    = " + EscaparSQL(THIS.this_cCotUsus) + "," + ;
                " Gruconmoes = " + EscaparSQL(loc_cGruConMoes) + ;
                " WHERE Emps   = " + EscaparSQL(THIS.this_cEmps) + ;
                "   AND Nopers = " + FormatarNumeroSQL(THIS.this_nNopers)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar lan" + CHR(231) + "amento:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * EXECUTAREXCLUSAO - Exclusao logica: marca Datexcs + Usuexcs (sem DELETE fisico)
    * Compativel com o legado (que usava UPDATE SigMvCcr SET DatExcs/UsuExcs)
    *===========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_dAgora
        loc_lSucesso = .F.

        TRY
            loc_dAgora = DATETIME()

            loc_cSQL = "UPDATE SigMvCcr SET" + ;
                " Datexcs = " + FormatarDataSQL(loc_dAgora) + "," + ;
                " Usuexcs = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                " WHERE Emps   = " + EscaparSQL(THIS.this_cEmps) + ;
                "   AND Nopers = " + FormatarNumeroSQL(THIS.this_nNopers)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao excluir lan" + CHR(231) + "amento:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ELSE
                THIS.this_dDatExcs = loc_dAgora
                THIS.this_cUsuExcs = gc_4c_UsuarioLogado
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ExecutarExclusao: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

