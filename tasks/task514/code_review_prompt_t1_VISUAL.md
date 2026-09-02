# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (11)
- [FONTNAME-ERRADO] Linha 204: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 227: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 250: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 273: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 296: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 332: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 475: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 497: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 3449: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 3473: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 3497: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormRPT.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (3673 linhas total):

*-- Linhas 77 a 87:
77:             THIS.this_cModoAtual = "LISTA"
78: 
79:             *-- Propagar Caption para labels de titulo
80:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho, "lbl_4c_Titulo", 5)
81:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
82:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
83:             ENDIF
84: 
85:             *-- Carregar lista inicial (pula se validando UI)
86:             IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
87:                 THIS.CarregarLista()

*-- Linhas 98 a 124:
98: 
99:     *==========================================================================
100:     * ConfigurarPageFrame - Cria PageFrame externo com Page1 (Lista) e Page2 (Dados)
101:     * PageFrame.Top = -29 oculta as abas; compensacao +29 em controles internos
102:     *==========================================================================
103:     PROTECTED PROCEDURE ConfigurarPageFrame()
104:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
105:         WITH THIS.pgf_4c_Paginas
106:             .Top       = -29
107:             .Left      = 0
108:             .Width     = THIS.Width
109:             .Height    = THIS.Height + 29
110:             .PageCount = 2
111:             .Tabs      = .F.
112:             .Visible   = .T.
113: 
114:             *-- Pagina 1: Lista de Reports
115:             .Page1.Caption  = "Lista"
116:             .Page1.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
117: 
118:             *-- Pagina 2: Edicao/Configuracao do Report
119:             .Page2.Caption  = "Dados"
120:             .Page2.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
121:         ENDWITH
122:     ENDPROC
123: 
124:     *==========================================================================

*-- Linhas 134 a 173:
134: 
135:         *----------------------------------------------------------------------
136:         * Container cabecalho (escuro, com titulo do form)
137:         * Top=29: compensacao do PageFrame.Top=-29
138:         *----------------------------------------------------------------------
139:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
140:         WITH loc_oPagina.cnt_4c_Cabecalho
141:             .Top         = 29
142:             .Left        = 0
143:             .Width       = THIS.Width
144:             .Height      = 85
145:             .BackColor   = RGB(100, 100, 100)
146:             .BorderWidth = 0
147:             .Visible     = .T.
148: 
149:             .AddObject("lbl_4c_Sombra", "Label")
150:             WITH .lbl_4c_Sombra
151:                 .Caption   = THIS.Caption
152:                 .Top       = 17
153:                 .Left      = 12
154:                 .Width     = THIS.Width
155:                 .Height    = 40
156:                 .FontName  = "Tahoma"
157:                 .FontSize  = 16
158:                 .FontBold  = .T.
159:                 .ForeColor = RGB(0, 0, 0)
160:                 .BackStyle = 0
161:                 .Visible   = .T.
162:             ENDWITH
163: 
164:             .AddObject("lbl_4c_Titulo", "Label")
165:             WITH .lbl_4c_Titulo
166:                 .Caption   = THIS.Caption
167:                 .Top       = 15
168:                 .Left      = 10
169:                 .Width     = THIS.Width
170:                 .Height    = 40
171:                 .FontName  = "Tahoma"
172:                 .FontSize  = 16
173:                 .FontBold  = .T.

*-- Linhas 183 a 302:
183:         *----------------------------------------------------------------------
184:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
185:         WITH loc_oPagina.cnt_4c_Botoes
186:             .Top         = 29
187:             .Left        = 542
188:             .Width       = 390
189:             .Height      = 85
190:             .BackStyle   = 0
191:             .BorderWidth = 0
192:             .Visible     = .T.
193:         ENDWITH
194: 
195:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
196:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
197:             .Caption         = "Incluir"
198:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
199:             .PicturePosition = 13
200:             .Top             = 5
201:             .Left            = 5
202:             .Width           = 75
203:             .Height          = 75
204:             .FontName        = "Comic Sans MS"
205:             .FontSize        = 8
206:             .FontBold        = .T.
207:             .FontItalic      = .T.
208:             .ForeColor       = RGB(90, 90, 90)
209:             .BackColor       = RGB(255, 255, 255)
210:             .Themes          = .F.
211:             .SpecialEffect   = 0
212:             .MousePointer    = 15
213:             .WordWrap        = .T.
214:             .AutoSize        = .F.
215:             .Visible         = .T.
216:         ENDWITH
217: 
218:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
219:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
220:             .Caption         = "Visualizar"
221:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
222:             .PicturePosition = 13
223:             .Top             = 5
224:             .Left            = 80
225:             .Width           = 75
226:             .Height          = 75
227:             .FontName        = "Comic Sans MS"
228:             .FontSize        = 8
229:             .FontBold        = .T.
230:             .FontItalic      = .T.
231:             .ForeColor       = RGB(90, 90, 90)
232:             .BackColor       = RGB(255, 255, 255)
233:             .Themes          = .F.
234:             .SpecialEffect   = 0
235:             .MousePointer    = 15
236:             .WordWrap        = .T.
237:             .AutoSize        = .F.
238:             .Visible         = .T.
239:         ENDWITH
240: 
241:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
242:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
243:             .Caption         = "Alterar"
244:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
245:             .PicturePosition = 13
246:             .Top             = 5
247:             .Left            = 155
248:             .Width           = 75
249:             .Height          = 75
250:             .FontName        = "Comic Sans MS"
251:             .FontSize        = 8
252:             .FontBold        = .T.
253:             .FontItalic      = .T.
254:             .ForeColor       = RGB(90, 90, 90)
255:             .BackColor       = RGB(255, 255, 255)
256:             .Themes          = .F.
257:             .SpecialEffect   = 0
258:             .MousePointer    = 15
259:             .WordWrap        = .T.
260:             .AutoSize        = .F.
261:             .Visible         = .T.
262:         ENDWITH
263: 
264:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
265:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
266:             .Caption         = "Excluir"
267:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
268:             .PicturePosition = 13
269:             .Top             = 5
270:             .Left            = 230
271:             .Width           = 75
272:             .Height          = 75
273:             .FontName        = "Comic Sans MS"
274:             .FontSize        = 8
275:             .FontBold        = .T.
276:             .FontItalic      = .T.
277:             .ForeColor       = RGB(90, 90, 90)
278:             .BackColor       = RGB(255, 255, 255)
279:             .Themes          = .F.
280:             .SpecialEffect   = 0
281:             .MousePointer    = 15
282:             .WordWrap        = .T.
283:             .AutoSize        = .F.
284:             .Visible         = .T.
285:         ENDWITH
286: 
287:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
288:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
289:             .Caption         = "Buscar"
290:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
291:             .PicturePosition = 13
292:             .Top             = 5
293:             .Left            = 305
294:             .Width           = 75
295:             .Height          = 75
296:             .FontName        = "Comic Sans MS"
297:             .FontSize        = 8
298:             .FontBold        = .T.
299:             .FontItalic      = .T.
300:             .ForeColor       = RGB(90, 90, 90)
301:             .BackColor       = RGB(255, 255, 255)
302:             .Themes          = .F.

*-- Linhas 312 a 338:
312:         *----------------------------------------------------------------------
313:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
314:         WITH loc_oPagina.cnt_4c_Saida
315:             .Top         = 29
316:             .Left        = 917
317:             .Width       = 90
318:             .Height      = 85
319:             .BackStyle   = 0
320:             .BorderWidth = 0
321:             .Visible     = .T.
322: 
323:             .AddObject("cmd_4c_Encerrar", "CommandButton")
324:             WITH .cmd_4c_Encerrar
325:                 .Caption         = "Encerrar"
326:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
327:                 .PicturePosition = 13
328:                 .Top             = 5
329:                 .Left            = 917
330:                 .Width           = 75
331:                 .Height          = 75
332:                 .FontName        = "Comic Sans MS"
333:                 .FontSize        = 8
334:                 .FontBold        = .T.
335:                 .FontItalic      = .T.
336:                 .ForeColor       = RGB(90, 90, 90)
337:                 .BackColor       = RGB(255, 255, 255)
338:                 .SpecialEffect   = 0

*-- Linhas 350 a 359:
350:         *----------------------------------------------------------------------
351:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
352:         WITH loc_oPagina.grd_4c_Lista
353:             .Top                = 117
354:             .Left               = 2
355:             .Width              = 995
356:             .Height             = 470
357:             .GridLines          = 3
358:             .GridLineColor      = RGB(238, 238, 238)
359:             .HighlightBackColor = RGB(255, 255, 255)

*-- Linhas 368 a 381:
368:         ENDWITH
369: 
370:         *-- BINDEVENTs dos botoes (handlers devem ser PUBLIC)
371:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
372:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
373:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
374:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
375:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
376:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
377: 
378:         THIS.TornarControlesVisiveis(loc_oPagina)
379:     ENDPROC
380: 
381:     *==========================================================================

*-- Linhas 394 a 448:
394:         *-- PageFrame interno (Top=-29: oculta abas; compensacao +29 nos controles internos)
395:         loc_oPagina.AddObject("pgf_4c_Dados", "PageFrame")
396:         WITH loc_oPagina.pgf_4c_Dados
397:             .Top       = -29
398:             .Left      = 0
399:             .Width     = THIS.Width
400:             .Height    = loc_oPagina.Height + 29
401:             .PageCount = 2
402:             .Tabs      = .F.
403:             .Visible   = .T.
404:             .Page1.Caption = "SQL"
405:             .Page2.Caption = "Layout"
406:         ENDWITH
407: 
408:         *==========================================================
409:         * Sub-Page1: Editor SQL + Metadados + Botoes + Grid resultado
410:         *==========================================================
411:         loc_oSubPg1 = loc_oPagina.pgf_4c_Dados.Page1
412: 
413:         *-- Cabecalho escuro (Top=29 compensa pgf_4c_Dados.Top=-29)
414:         loc_oSubPg1.AddObject("cnt_4c_CabecalhoDados", "Container")
415:         WITH loc_oSubPg1.cnt_4c_CabecalhoDados
416:             .Top         = 29
417:             .Left        = 0
418:             .Width       = THIS.Width - 168
419:             .Height      = 85
420:             .BackColor   = RGB(100, 100, 100)
421:             .BorderWidth = 0
422:             .Visible     = .T.
423: 
424:             .AddObject("lbl_4c_TituloD_Sombra", "Label")
425:             WITH .lbl_4c_TituloD_Sombra
426:                 .Caption   = "Dados do Relat" + CHR(243) + "rio"
427:                 .Top       = 17
428:                 .Left      = 12
429:                 .Width     = THIS.Width - 188
430:                 .Height    = 40
431:                 .FontName  = "Tahoma"
432:                 .FontSize  = 16
433:                 .FontBold  = .T.
434:                 .ForeColor = RGB(0, 0, 0)
435:                 .BackStyle = 0
436:                 .Visible   = .T.
437:             ENDWITH
438: 
439:             .AddObject("lbl_4c_TituloD", "Label")
440:             WITH .lbl_4c_TituloD
441:                 .Caption   = "Dados do Relat" + CHR(243) + "rio"
442:                 .Top       = 15
443:                 .Left      = 10
444:                 .Width     = THIS.Width - 188
445:                 .Height    = 40
446:                 .FontName  = "Tahoma"
447:                 .FontSize  = 16
448:                 .FontBold  = .T.

*-- Linhas 455 a 503:
455:         *-- Container Confirmar/Cancelar (Left=835: 832 cabecalho + 3 gap)
456:         loc_oSubPg1.AddObject("cnt_4c_Salva", "Container")
457:         WITH loc_oSubPg1.cnt_4c_Salva
458:             .Top         = 29
459:             .Left        = THIS.Width - 165
460:             .Width       = 165
461:             .Height      = 85
462:             .BackStyle   = 0
463:             .BorderWidth = 0
464:             .Visible     = .T.
465: 
466:             .AddObject("cmd_4c_Confirmar", "CommandButton")
467:             WITH .cmd_4c_Confirmar
468:                 .Caption         = "Confirmar"
469:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_confirmar_60.jpg"
470:                 .PicturePosition = 13
471:                 .Top             = 5
472:                 .Left            = 5
473:                 .Width           = 75
474:                 .Height          = 75
475:                 .FontName        = "Comic Sans MS"
476:                 .FontSize        = 8
477:                 .FontBold        = .T.
478:                 .FontItalic      = .T.
479:                 .ForeColor       = RGB(90, 90, 90)
480:                 .BackColor       = RGB(255, 255, 255)
481:                 .SpecialEffect   = 0
482:                 .MousePointer    = 15
483:                 .WordWrap        = .T.
484:                 .AutoSize        = .F.
485:                 .Visible         = .T.
486:             ENDWITH
487: 
488:             .AddObject("cmd_4c_Cancelar", "CommandButton")
489:             WITH .cmd_4c_Cancelar
490:                 .Caption         = "Encerrar"
491:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
492:                 .PicturePosition = 13
493:                 .Top             = 5
494:                 .Left            = 85
495:                 .Width           = 75
496:                 .Height          = 75
497:                 .FontName        = "Comic Sans MS"
498:                 .FontSize        = 8
499:                 .FontBold        = .T.
500:                 .FontItalic      = .T.
501:                 .ForeColor       = RGB(90, 90, 90)
502:                 .BackColor       = RGB(255, 255, 255)
503:                 .Themes          = .F.

*-- Linhas 510 a 522:
510:         ENDWITH
511: 
512:         *-- Row 1 (Top=120): Nome do Report
513:         loc_oSubPg1.AddObject("lbl_4c_NmReport", "Label")
514:         WITH loc_oSubPg1.lbl_4c_NmReport
515:             .Caption   = "Nome:"
516:             .Top       = 123
517:             .Left      = 5
518:             .Width     = 48
519:             .Height    = 17
520:             .FontName  = "Tahoma"
521:             .FontSize  = 8
522:             .FontBold  = .T.

*-- Linhas 528 a 580:
528:         loc_oSubPg1.AddObject("txt_4c_NmReport", "TextBox")
529:         WITH loc_oSubPg1.txt_4c_NmReport
530:             .Value       = ""
531:             .Top         = 120
532:             .Left        = 56
533:             .Width       = 335
534:             .Height      = 23
535:             .FontName    = "Tahoma"
536:             .FontSize    = 8
537:             .MaxLength   = 100
538:             .BackColor   = RGB(255, 255, 255)
539:             .BorderStyle = 1
540:             .Visible     = .T.
541:         ENDWITH
542: 
543:         *-- Row 1: Ativo
544:         loc_oSubPg1.AddObject("lbl_4c_Ativo", "Label")
545:         WITH loc_oSubPg1.lbl_4c_Ativo
546:             .Caption   = "Ativo:"
547:             .Top       = 123
548:             .Left      = 398
549:             .Width     = 38
550:             .Height    = 17
551:             .FontName  = "Tahoma"
552:             .FontSize  = 8
553:             .FontBold  = .T.
554:             .ForeColor = RGB(53, 53, 53)
555:             .BackStyle = 0
556:             .Visible   = .T.
557:         ENDWITH
558: 
559:         loc_oSubPg1.AddObject("chk_4c_Ativo", "CheckBox")
560:         WITH loc_oSubPg1.chk_4c_Ativo
561:             .Value   = 1
562:             .Caption = ""
563:             .Top     = 121
564:             .Left    = 438
565:             .Width   = 20
566:             .Height  = 20
567:             .Visible = .T.
568:         ENDWITH
569: 
570:         *-- Row 1: DtCriacao
571:         loc_oSubPg1.AddObject("lbl_4c_DtCriacao", "Label")
572:         WITH loc_oSubPg1.lbl_4c_DtCriacao
573:             .Caption   = "Criado em:"
574:             .Top       = 123
575:             .Left      = 465
576:             .Width     = 65
577:             .Height    = 17
578:             .FontName  = "Tahoma"
579:             .FontSize  = 8
580:             .FontBold  = .T.

*-- Linhas 586 a 611:
586:         loc_oSubPg1.AddObject("txt_4c_DtCriacao", "TextBox")
587:         WITH loc_oSubPg1.txt_4c_DtCriacao
588:             .Value       = ""
589:             .Top         = 120
590:             .Left        = 533
591:             .Width       = 90
592:             .Height      = 23
593:             .FontName    = "Tahoma"
594:             .FontSize    = 8
595:             .ReadOnly    = .T.
596:             .BackColor   = RGB(240, 240, 240)
597:             .BorderStyle = 1
598:             .Visible     = .T.
599:         ENDWITH
600: 
601:         *-- Row 1: DtAlteracao
602:         loc_oSubPg1.AddObject("lbl_4c_DtAlteracao", "Label")
603:         WITH loc_oSubPg1.lbl_4c_DtAlteracao
604:             .Caption   = "Alterado em:"
605:             .Top       = 123
606:             .Left      = 630
607:             .Width     = 75
608:             .Height    = 17
609:             .FontName  = "Tahoma"
610:             .FontSize  = 8
611:             .FontBold  = .T.

*-- Linhas 617 a 642:
617:         loc_oSubPg1.AddObject("txt_4c_DtAlteracao", "TextBox")
618:         WITH loc_oSubPg1.txt_4c_DtAlteracao
619:             .Value       = ""
620:             .Top         = 120
621:             .Left        = 708
622:             .Width       = 90
623:             .Height      = 23
624:             .FontName    = "Tahoma"
625:             .FontSize    = 8
626:             .ReadOnly    = .T.
627:             .BackColor   = RGB(240, 240, 240)
628:             .BorderStyle = 1
629:             .Visible     = .T.
630:         ENDWITH
631: 
632:         *-- Row 2 (Top=150): Descricao (EditBox multilinhas)
633:         loc_oSubPg1.AddObject("lbl_4c_Descricao", "Label")
634:         WITH loc_oSubPg1.lbl_4c_Descricao
635:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o:"
636:             .Top       = 153
637:             .Left      = 5
638:             .Width     = 48
639:             .Height    = 17
640:             .FontName  = "Tahoma"
641:             .FontSize  = 8
642:             .FontBold  = .T.

*-- Linhas 648 a 674:
648:         loc_oSubPg1.AddObject("edt_4c_Descricao", "EditBox")
649:         WITH loc_oSubPg1.edt_4c_Descricao
650:             .Value       = ""
651:             .Top         = 150
652:             .Left        = 56
653:             .Width       = 936
654:             .Height      = 53
655:             .FontName    = "Tahoma"
656:             .FontSize    = 8
657:             .MaxLength   = 200
658:             .BackColor   = RGB(255, 255, 255)
659:             .BorderStyle = 1
660:             .ScrollBars  = 2
661:             .Visible     = .T.
662:         ENDWITH
663: 
664:         *-- Row 3 (Top=208): ComboBox para copiar SQL de outro report
665:         loc_oSubPg1.AddObject("lbl_4c_CopiarSQL", "Label")
666:         WITH loc_oSubPg1.lbl_4c_CopiarSQL
667:             .Caption   = "Copiar SQL de:"
668:             .Top       = 211
669:             .Left      = 5
670:             .Width     = 85
671:             .Height    = 17
672:             .FontName  = "Tahoma"
673:             .FontSize  = 8
674:             .FontBold  = .T.

*-- Linhas 680 a 689:
680:         loc_oSubPg1.AddObject("cbo_4c_NmReports", "ComboBox")
681:         WITH loc_oSubPg1.cbo_4c_NmReports
682:             .Value         = ""
683:             .Top           = 208
684:             .Left          = 93
685:             .Width         = 295
686:             .Height        = 23
687:             .FontName      = "Tahoma"
688:             .FontSize      = 8
689:             .Style         = 2

*-- Linhas 698 a 750:
698:         *-- Container de hints de teclado (F8/F9)
699:         loc_oSubPg1.AddObject("cnt_4c_Container1", "Container")
700:         WITH loc_oSubPg1.cnt_4c_Container1
701:             .Top         = 170
702:             .Left        = 326
703:             .Width       = 600
704:             .Height      = 25
705:             .BackStyle   = 0
706:             .BorderWidth = 0
707:             .Visible     = .T.
708: 
709:             .AddObject("lbl_4c_HintF8", "Label")
710:             WITH .lbl_4c_HintF8
711:                 .Caption   = "[F8] Executar SQL"
712:                 .Top       = 4
713:                 .Left      = 5
714:                 .Width     = 130
715:                 .Height    = 17
716:                 .FontName  = "Tahoma"
717:                 .FontSize  = 8
718:                 .FontBold  = .T.
719:                 .ForeColor = RGB(0, 80, 160)
720:                 .BackStyle = 0
721:                 .Visible   = .T.
722:             ENDWITH
723: 
724:             .AddObject("lbl_4c_HintF9", "Label")
725:             WITH .lbl_4c_HintF9
726:                 .Caption   = "[F9] Gerar Relat" + CHR(243) + "rio"
727:                 .Top       = 4
728:                 .Left      = 145
729:                 .Width     = 155
730:                 .Height    = 17
731:                 .FontName  = "Tahoma"
732:                 .FontSize  = 8
733:                 .FontBold  = .T.
734:                 .ForeColor = RGB(0, 80, 160)
735:                 .BackStyle = 0
736:                 .Visible   = .T.
737:             ENDWITH
738:         ENDWITH
739: 
740:         *-- Label da SQL Query (Top=238)
741:         loc_oSubPg1.AddObject("lbl_4c_SqlQuery", "Label")
742:         WITH loc_oSubPg1.lbl_4c_SqlQuery
743:             .Caption   = "SQL Query:"
744:             .Top       = 238
745:             .Left      = 5
746:             .Width     = 65
747:             .Height    = 17
748:             .FontName  = "Tahoma"
749:             .FontSize  = 8
750:             .FontBold  = .T.

*-- Linhas 756 a 776:
756:         *-- OLE RichText para edicao do SQL (Top=257, Height=170)
757:         loc_oSubPg1.AddObject("obj_4c_OleRTF_SqlCMD", "OleControl", "RICHTEXT.RichtextCtrl.1")
758:         WITH loc_oSubPg1.obj_4c_OleRTF_SqlCMD
759:             .Top     = 257
760:             .Left    = 5
761:             .Width   = 988
762:             .Height  = 170
763:             .Visible = .T.
764:         ENDWITH
765: 
766:         *-- Label do resultado (Top=433)
767:         loc_oSubPg1.AddObject("lbl_4c_Resultado", "Label")
768:         WITH loc_oSubPg1.lbl_4c_Resultado
769:             .Caption   = "Resultado da Query:"
770:             .Top       = 433
771:             .Left      = 5
772:             .Width     = 130
773:             .Height    = 17
774:             .FontName  = "Tahoma"
775:             .FontSize  = 8
776:             .FontBold  = .T.

*-- Linhas 782 a 791:
782:         *-- Grid de resultado (Top=452, Height=148: termina em 600px)
783:         loc_oSubPg1.AddObject("grd_4c_Resultado", "Grid")
784:         WITH loc_oSubPg1.grd_4c_Resultado
785:             .Top                = 452
786:             .Left               = 2
787:             .Width              = 993
788:             .Height             = 148
789:             .GridLines          = 3
790:             .GridLineColor      = RGB(238, 238, 238)
791:             .HighlightBackColor = RGB(255, 255, 255)

*-- Linhas 801 a 810:
801:         ENDWITH
802: 
803:         *-- BINDEVENTs (handlers devem ser PUBLIC)
804:         BINDEVENT(loc_oSubPg1.cnt_4c_Salva.cmd_4c_Confirmar, "Click",             THIS, "BtnSalvarClick")
805:         BINDEVENT(loc_oSubPg1.cnt_4c_Salva.cmd_4c_Cancelar,  "Click",             THIS, "BtnCancelarClick")
806:         BINDEVENT(loc_oSubPg1.cbo_4c_NmReports,              "InteractiveChange", THIS, "CboNmReportsChange")
807: 
808:         THIS.ConfigurarSubPaginaLayout()
809:         THIS.ConfigurarPgPage1()
810:         THIS.TornarControlesVisiveis(loc_oPagina)

*-- Linhas 848 a 860:
848:                 loc_oGrid.Column5.Width = 80
849: 
850:                 *-- Headers (obrigatorio reconfigurar apos RecordSource)
851:                 loc_oGrid.Column1.Header1.Caption = "Nome do Report"
852:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
853:                 loc_oGrid.Column3.Header1.Caption = "Ativo"
854:                 loc_oGrid.Column4.Header1.Caption = "Dt. Cria" + CHR(231) + CHR(227) + "o"
855:                 loc_oGrid.Column5.Header1.Caption = "Dt. Altera" + CHR(231) + CHR(227) + "o"
856: 
857:                 THIS.FormatarGridLista(loc_oGrid)
858:                 THIS.PopularComboReports()
859:                 loc_lSucesso = .T.
860:             ENDIF

*-- Linhas 1208 a 1217:
1208:             LOCAL loc_oSubPg, loc_oCnt
1209:             loc_oSubPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1210:             IF PEMSTATUS(loc_oSubPg, "cnt_4c_Salva", 5)
1211:                 IF PEMSTATUS(loc_oSubPg.cnt_4c_Salva, "cmd_4c_Confirmar", 5)
1212:                     loc_oSubPg.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = ;
1213:                         par_lHabilitar OR (THIS.this_cModoAtual = "EXCLUIR")
1214:                 ENDIF
1215:             ENDIF
1216: 
1217:         CATCH TO loc_oErro

*-- Linhas 1265 a 1274:
1265:                 loc_oSubPg1.txt_4c_DtFinal.Value = DTOC(DATE())
1266:             ENDIF
1267: 
1268:             IF PEMSTATUS(loc_oSubPg1, "lbl_4c_SqlAlterado", 5)
1269:                 loc_oSubPg1.lbl_4c_SqlAlterado.ForeColor = RGB(0, 0, 0)
1270:             ENDIF
1271: 
1272:         CATCH TO loc_oErro
1273:             MsgErro("Erro ao limpar campos:" + CHR(13) + loc_oErro.Message, "FormRPT.LimparCampos")
1274:         ENDTRY

*-- Linhas 1285 a 1312:
1285:             *-- Botoes CRUD: habilitados apenas na lista
1286:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Botoes", 5)
1287:                 loc_oPg1Cnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
1288:                 IF PEMSTATUS(loc_oPg1Cnt, "cmd_4c_Incluir", 5)
1289:                     loc_oPg1Cnt.cmd_4c_Incluir.Enabled    = (THIS.this_cModoAtual = "LISTA")
1290:                     loc_oPg1Cnt.cmd_4c_Visualizar.Enabled = (THIS.this_cModoAtual = "LISTA")
1291:                     loc_oPg1Cnt.cmd_4c_Alterar.Enabled    = (THIS.this_cModoAtual = "LISTA")
1292:                     loc_oPg1Cnt.cmd_4c_Excluir.Enabled    = (THIS.this_cModoAtual = "LISTA")
1293:                     loc_oPg1Cnt.cmd_4c_Buscar.Enabled     = (THIS.this_cModoAtual = "LISTA")
1294:                 ENDIF
1295:             ENDIF
1296: 
1297:             *-- Botoes de salvar (Page2 sub-page, criados na Fase 5)
1298:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Dados", 5)
1299:                 LOCAL loc_oSub1
1300:                 loc_oSub1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1301:                 IF PEMSTATUS(loc_oSub1, "cnt_4c_Salva", 5)
1302:                     IF PEMSTATUS(loc_oSub1.cnt_4c_Salva, "cmd_4c_Confirmar", 5)
1303:                         loc_oSub1.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = ;
1304:                             loc_lEdicao OR (THIS.this_cModoAtual = "EXCLUIR")
1305:                     ENDIF
1306:                     IF PEMSTATUS(loc_oSub1.cnt_4c_Salva, "cmd_4c_Cancelar", 5)
1307:                         loc_oSub1.cnt_4c_Salva.cmd_4c_Cancelar.Enabled = .T.
1308:                     ENDIF
1309:                 ENDIF
1310:             ENDIF
1311: 
1312:         CATCH TO loc_oErro

*-- Linhas 1412 a 1420:
1412: 
1413:     *==========================================================================
1414:     * BtnProcessarClick - Seta variaveis de data e executa SQL (FASE 9)
1415:     * Chamado pelo botao Processar (cmd_4c_Processar) dentro do cabecalho
1416:     *==========================================================================
1417:     PROCEDURE BtnProcessarClick()
1418:         LOCAL loc_oSubPg1, loc_dIni, loc_dFim
1419: 
1420:         TRY

*-- Linhas 1448 a 1457:
1448:         TRY
1449:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Dados", 5)
1450:                 loc_oSubPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1451:                 IF PEMSTATUS(loc_oSubPg1, "lbl_4c_SqlAlterado", 5)
1452:                     loc_oSubPg1.lbl_4c_SqlAlterado.ForeColor = RGB(0, 0, 0)
1453:                 ENDIF
1454:             ENDIF
1455:         CATCH TO loc_oErro
1456:             MsgErro("Erro ao resetar indicador:" + CHR(13) + loc_oErro.Message, "FormRPT.BtnProcessarClick")
1457:         ENDTRY

*-- Linhas 1668 a 1735:
1668: 
1669:     *==========================================================================
1670:     * ConfigurarSubPaginaLayout - Constroi controles da Sub-Page2 (Layout FRX)
1671:     * Coordenadas originais do SCX + 29 (compensa pgf_4c_Dados.Top=-29)
1672:     *==========================================================================
1673:     PROTECTED PROCEDURE ConfigurarSubPaginaLayout()
1674:         LOCAL loc_oSubPg2, loc_i
1675:         LOCAL loc_aPaperSize(41)
1676:         loc_oSubPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
1677: 
1678:         *-- Container de botoes (CmdGrp_Acoes: Top=8+29=37)
1679:         loc_oSubPg2.AddObject("cnt_4c_BotoesLayout", "Container")
1680:         WITH loc_oSubPg2.cnt_4c_BotoesLayout
1681:             .Top         = 37
1682:             .Left        = 11
1683:             .Width       = 160
1684:             .Height      = 85
1685:             .BackStyle   = 0
1686:             .BorderWidth = 0
1687:             .Visible     = .T.
1688: 
1689:             .AddObject("cmd_4c_VoltarLayout", "CommandButton")
1690:             WITH .cmd_4c_VoltarLayout
1691:                 .Caption  = "Voltar"
1692:                 .Top      = 5
1693:                 .Left     = 5
1694:                 .Width    = 70
1695:                 .Height   = 70
1696:                 .Visible  = .T.
1697:             ENDWITH
1698: 
1699:             .AddObject("cmd_4c_GerarLayout", "CommandButton")
1700:             WITH .cmd_4c_GerarLayout
1701:                 .Caption  = "Gerar" + CHR(13) + "Layout"
1702:                 .Top      = 5
1703:                 .Left     = 80
1704:                 .Width    = 70
1705:                 .Height   = 70
1706:                 .Visible  = .T.
1707:             ENDWITH
1708:         ENDWITH
1709: 
1710:         *-- Label NmRelatorio (Lbl_Nm_Relatorio: Top=131+29=160)
1711:         loc_oSubPg2.AddObject("lbl_4c_NmRelatorio", "Label")
1712:         WITH loc_oSubPg2.lbl_4c_NmRelatorio
1713:             .Caption   = ""
1714:             .Top       = 160
1715:             .Left      = 10
1716:             .Width     = 540
1717:             .Height    = 22
1718:             .FontName  = "Tahoma"
1719:             .FontSize  = 10
1720:             .FontBold  = .T.
1721:             .BackStyle = 0
1722:             .Visible   = .T.
1723:         ENDWITH
1724: 
1725:         *-- Label "Tamanho do Papel:" (Lbl_TamPapel: Top=48+29=77)
1726:         loc_oSubPg2.AddObject("lbl_4c_TamPapel", "Label")
1727:         WITH loc_oSubPg2.lbl_4c_TamPapel
1728:             .Caption   = "Tamanho do Papel:"
1729:             .Top       = 77
1730:             .Left      = 202
1731:             .Width     = 108
1732:             .Height    = 16
1733:             .FontName  = "Tahoma"
1734:             .FontSize  = 8
1735:             .FontBold  = .T.

*-- Linhas 1741 a 1750:
1741:         *-- BoundColumn=2: valor ligado eh o indice numerico (col2); col1 exibe o nome
1742:         loc_oSubPg2.AddObject("cbo_4c_TamPapel", "ComboBox")
1743:         WITH loc_oSubPg2.cbo_4c_TamPapel
1744:             .Top           = 100
1745:             .Left          = 202
1746:             .Width         = 348
1747:             .Height        = 24
1748:             .Style         = 2
1749:             .ColumnCount   = 2
1750:             .BoundColumn   = 2

*-- Linhas 1807 a 1873:
1807:         *-- Imagem orientacao (Img_Orientacao: Top=6+29=35)
1808:         loc_oSubPg2.AddObject("img_4c_Orientacao", "Image")
1809:         WITH loc_oSubPg2.img_4c_Orientacao
1810:             .Top     = 35
1811:             .Left    = 603
1812:             .Width   = 130
1813:             .Height  = 116
1814:             .Picture = gc_4c_CaminhoIcones + "Rpt_Orientacao_Retrato_26.JPG"
1815:             .Visible = .T.
1816:         ENDWITH
1817: 
1818:         *-- OptionGroup orientacao (OptGrp_Orientacao: Top=126+29=155)
1819:         *-- ControlSource liga Value (1=Retrato, 2=Paisagem) a cursor_4c_PropsTitulo.Orientation
1820:         loc_oSubPg2.AddObject("opt_4c_Orientacao", "OptionGroup")
1821:         WITH loc_oSubPg2.opt_4c_Orientacao
1822:             .Top           = 155
1823:             .Left          = 580
1824:             .Width         = 180
1825:             .Height        = 28
1826:             .ButtonCount   = 2
1827:             .Value         = 1
1828:             .ControlSource = "cursor_4c_PropsTitulo.Orientation"
1829:             .BackStyle     = 0
1830:             .BorderStyle   = 0
1831:             .Visible       = .T.
1832: 
1833:             WITH .Buttons(1)
1834:                 .Caption = "Retrato"
1835:                 .Left    = 0
1836:                 .Width   = 85
1837:                 .Visible = .T.
1838:             ENDWITH
1839: 
1840:             WITH .Buttons(2)
1841:                 .Caption = "Paisagem"
1842:                 .Left    = 90
1843:                 .Width   = 85
1844:                 .Visible = .T.
1845:             ENDWITH
1846:         ENDWITH
1847: 
1848:         *-- Label "Titulo do Relatorio:" (Label1: Top=162+29=191)
1849:         loc_oSubPg2.AddObject("lbl_4c_TituloRelLayout", "Label")
1850:         WITH loc_oSubPg2.lbl_4c_TituloRelLayout
1851:             .Caption   = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio: "
1852:             .Top       = 191
1853:             .Left      = 10
1854:             .Width     = 110
1855:             .Height    = 16
1856:             .FontName  = "Tahoma"
1857:             .FontSize  = 8
1858:             .FontBold  = .T.
1859:             .BackStyle = 0
1860:             .Visible   = .T.
1861:         ENDWITH
1862: 
1863:         *-- Label "Totalizar pelo Campo:"
1864:         loc_oSubPg2.AddObject("lbl_4c_CmpGrupo", "Label")
1865:         WITH loc_oSubPg2.lbl_4c_CmpGrupo
1866:             .Caption   = "Totalizar pelo Campo: ( Use o clique direito, para apagar )"
1867:             .Top       = 539
1868:             .Left      = 10
1869:             .Width     = 560
1870:             .Height    = 16
1871:             .FontName  = "Tahoma"
1872:             .FontSize  = 8
1873:             .FontBold  = .T.

*-- Linhas 1882 a 1904:
1882:         loc_oSubPg2.grd_4c_PropsTitulo.ColumnCount = 3
1883:         loc_oSubPg2.grd_4c_PropsTitulo.RecordSource      = "cursor_4c_PropsTitulo"
1884:         WITH loc_oSubPg2.grd_4c_PropsTitulo
1885:             .Top          = 209
1886:             .Left         = 4
1887:             .Width        = 990
1888:             .Height       = 65
1889:             .GridLines    = 1
1890:             .HeaderHeight = 18
1891:             .RowHeight    = 20
1892:             .ReadOnly     = .F.
1893:             .Visible      = .T.
1894:             .DeleteMark   = .F.
1895:             .RecordMark   = .F.
1896:             .ScrollBars   = 2
1897: 
1898:             WITH .Column1
1899:                 .Header1.Caption = "Titulo"
1900:                 .ControlSource   = "cursor_4c_PropsTitulo.LblCaption"
1901:                 .Width           = 120
1902:                 .Sparse          = .F.
1903:                 .AddObject("Edit1", "EditBox")
1904:                 .CurrentControl  = "Edit1"

*-- Linhas 1910 a 1918:
1910:             ENDWITH
1911: 
1912:             WITH .Column2
1913:                 .Header1.Caption = "Fonte"
1914:                 .ControlSource   = "cursor_4c_PropsTitulo.LblFonte"
1915:                 .Width           = 300
1916:                 .Sparse          = .F.
1917:                 .AddObject("Edit1", "EditBox")
1918:                 .CurrentControl  = "Edit1"

*-- Linhas 1924 a 1962:
1924:             ENDWITH
1925: 
1926:             WITH .Column3
1927:                 .Header1.Caption = "Fte"
1928:                 .ControlSource   = "cursor_4c_PropsTitulo.LblBtFonte"
1929:                 .Width           = 60
1930:                 .Sparse          = .F.
1931:                 .AddObject("Command1", "CommandButton")
1932:                 .CurrentControl  = "Command1"
1933:                 WITH .Command1
1934:                     .Caption = "..."
1935:                     .Visible = .T.
1936:                     .Width   = 55
1937:                     .Height  = 18
1938:                 ENDWITH
1939:             ENDWITH
1940: 
1941:             WITH .Column4
1942:                 .Header1.Caption = "Cor"
1943:                 .ControlSource   = "cursor_4c_PropsTitulo.LblBtCor"
1944:                 .Width           = 60
1945:                 .Sparse          = .F.
1946:                 .AddObject("Command1", "CommandButton")
1947:                 .CurrentControl  = "Command1"
1948:                 WITH .Command1
1949:                     .Caption = "..."
1950:                     .Visible = .T.
1951:                     .Width   = 55
1952:                     .Height  = 18
1953:                 ENDWITH
1954:             ENDWITH
1955: 
1956:             WITH .Column5
1957:                 .Header1.Caption = "Alinhar"
1958:                 .ControlSource   = "cursor_4c_PropsTitulo.LblAlinhar"
1959:                 .Width           = 450
1960:                 .Sparse          = .F.
1961:                 .AddObject("Combo1", "ComboBox")
1962:                 .CurrentControl  = "Combo1"

*-- Linhas 1978 a 2000:
1978:         loc_oSubPg2.grd_4c_PropsCampos.ColumnCount = 3
1979:         loc_oSubPg2.grd_4c_PropsCampos.RecordSource      = "cursor_4c_PropsCampos"
1980:         WITH loc_oSubPg2.grd_4c_PropsCampos
1981:             .Top          = 287
1982:             .Left         = 4
1983:             .Width        = 990
1984:             .Height       = 238
1985:             .GridLines    = 1
1986:             .HeaderHeight = 18
1987:             .RowHeight    = 20
1988:             .ReadOnly     = .F.
1989:             .Visible      = .T.
1990:             .DeleteMark   = .F.
1991:             .RecordMark   = .F.
1992:             .ScrollBars   = 3
1993: 
1994:             WITH .Column1
1995:                 .Header1.Caption = "Campo"
1996:                 .ControlSource   = "cursor_4c_PropsCampos.NmCampo"
1997:                 .Width           = 100
1998:                 .ReadOnly        = .T.
1999:                 .Sparse          = .F.
2000:                 .AddObject("Text1", "TextBox")

*-- Linhas 2007 a 2015:
2007:             ENDWITH
2008: 
2009:             WITH .Column2
2010:                 .Header1.Caption = "Tipo"
2011:                 .ControlSource   = "cursor_4c_PropsCampos.TpCampo"
2012:                 .Width           = 75
2013:                 .ReadOnly        = .T.
2014:                 .Sparse          = .F.
2015:                 .AddObject("Text1", "TextBox")

*-- Linhas 2022 a 2090:
2022:             ENDWITH
2023: 
2024:             WITH .Column3
2025:                 .Header1.Caption = "Sa" + CHR(237) + "da Rel."
2026:                 .ControlSource   = "cursor_4c_PropsCampos.CkOutRPT"
2027:                 .Width           = 65
2028:                 .Sparse          = .F.
2029:                 .AddObject("Check1", "CheckBox")
2030:                 .CurrentControl  = "Check1"
2031:                 WITH .Check1
2032:                     .Caption = ""
2033:                     .Visible = .T.
2034:                     .Width   = 60
2035:                     .Height  = 17
2036:                 ENDWITH
2037:             ENDWITH
2038: 
2039:             WITH .Column4
2040:                 .Header1.Caption = "Filtro"
2041:                 .ControlSource   = "cursor_4c_PropsCampos.CkFiltro"
2042:                 .Width           = 55
2043:                 .Sparse          = .F.
2044:                 .AddObject("Check1", "CheckBox")
2045:                 .CurrentControl  = "Check1"
2046:                 WITH .Check1
2047:                     .Caption = ""
2048:                     .Visible = .T.
2049:                     .Width   = 50
2050:                     .Height  = 17
2051:                 ENDWITH
2052:             ENDWITH
2053: 
2054:             WITH .Column5
2055:                 .Header1.Caption = "SubTot"
2056:                 .ControlSource   = "cursor_4c_PropsCampos.CkSubTot"
2057:                 .Width           = 60
2058:                 .Sparse          = .F.
2059:                 .AddObject("Check1", "CheckBox")
2060:                 .CurrentControl  = "Check1"
2061:                 WITH .Check1
2062:                     .Caption = ""
2063:                     .Visible = .T.
2064:                     .Width   = 55
2065:                     .Height  = 17
2066:                 ENDWITH
2067:             ENDWITH
2068: 
2069:             WITH .Column6
2070:                 .Header1.Caption = "Total"
2071:                 .ControlSource   = "cursor_4c_PropsCampos.CkTotal"
2072:                 .Width           = 55
2073:                 .Sparse          = .F.
2074:                 .AddObject("Check1", "CheckBox")
2075:                 .CurrentControl  = "Check1"
2076:                 WITH .Check1
2077:                     .Caption = ""
2078:                     .Visible = .T.
2079:                     .Width   = 50
2080:                     .Height  = 17
2081:                 ENDWITH
2082:             ENDWITH
2083: 
2084:             WITH .Column7
2085:                 .Header1.Caption = "Titulo do Campo"
2086:                 .ControlSource   = "cursor_4c_PropsCampos.LblCaption"
2087:                 .Width           = 140
2088:                 .Sparse          = .F.
2089:                 .AddObject("Edit1", "EditBox")
2090:                 .CurrentControl  = "Edit1"

*-- Linhas 2096 a 2104:
2096:             ENDWITH
2097: 
2098:             WITH .Column8
2099:                 .Header1.Caption = "Fonte"
2100:                 .ControlSource   = "cursor_4c_PropsCampos.LblFonte"
2101:                 .Width           = 190
2102:                 .Sparse          = .F.
2103:                 .AddObject("Edit1", "EditBox")
2104:                 .CurrentControl  = "Edit1"

*-- Linhas 2110 a 2148:
2110:             ENDWITH
2111: 
2112:             WITH .Column9
2113:                 .Header1.Caption = "Fte"
2114:                 .ControlSource   = "cursor_4c_PropsCampos.LblBtFonte"
2115:                 .Width           = 50
2116:                 .Sparse          = .F.
2117:                 .AddObject("Command1", "CommandButton")
2118:                 .CurrentControl  = "Command1"
2119:                 WITH .Command1
2120:                     .Caption = "..."
2121:                     .Visible = .T.
2122:                     .Width   = 46
2123:                     .Height  = 18
2124:                 ENDWITH
2125:             ENDWITH
2126: 
2127:             WITH .Column10
2128:                 .Header1.Caption = "Cor"
2129:                 .ControlSource   = "cursor_4c_PropsCampos.LblBtCor"
2130:                 .Width           = 50
2131:                 .Sparse          = .F.
2132:                 .AddObject("Command1", "CommandButton")
2133:                 .CurrentControl  = "Command1"
2134:                 WITH .Command1
2135:                     .Caption = "..."
2136:                     .Visible = .T.
2137:                     .Width   = 46
2138:                     .Height  = 18
2139:                 ENDWITH
2140:             ENDWITH
2141: 
2142:             WITH .Column11
2143:                 .Header1.Caption = "Alinhar"
2144:                 .ControlSource   = "cursor_4c_PropsCampos.LblAlinhar"
2145:                 .Width           = 80
2146:                 .Sparse          = .F.
2147:                 .AddObject("Combo1", "ComboBox")
2148:                 .CurrentControl  = "Combo1"

*-- Linhas 2157 a 2165:
2157:             ENDWITH
2158: 
2159:             WITH .Column12
2160:                 .Header1.Caption = "Tam."
2161:                 .ControlSource   = "cursor_4c_PropsCampos.LblTamCmp"
2162:                 .Width           = 70
2163:                 .Sparse          = .F.
2164:                 .AddObject("Spinner1", "Spinner")
2165:                 .CurrentControl  = "Spinner1"

*-- Linhas 2187 a 2209:
2187:         loc_oSubPg2.grd_4c_PropsGrp.ColumnCount = 3
2188:         loc_oSubPg2.grd_4c_PropsGrp.RecordSource      = "cursor_4c_PropsGrp"
2189:         WITH loc_oSubPg2.grd_4c_PropsGrp
2190:             .Top          = 558
2191:             .Left         = 4
2192:             .Width        = 989
2193:             .Height       = 67
2194:             .GridLines    = 1
2195:             .HeaderHeight = 18
2196:             .RowHeight    = 20
2197:             .ReadOnly     = .F.
2198:             .Visible      = .T.
2199:             .DeleteMark   = .F.
2200:             .RecordMark   = .F.
2201:             .ScrollBars   = 2
2202: 
2203:             WITH .Column1
2204:                 .Header1.Caption = "Grupo"
2205:                 .ControlSource   = "cursor_4c_PropsGrp.NmCampo"
2206:                 .Width           = 180
2207:                 .Sparse          = .F.
2208:                 .AddObject("Combo1", "ComboBox")
2209:                 .CurrentControl  = "Combo1"

*-- Linhas 2219 a 2227:
2219:             ENDWITH
2220: 
2221:             WITH .Column2
2222:                 .Header1.Caption = "Titulo do Campo"
2223:                 .ControlSource   = "cursor_4c_PropsGrp.LblCaption"
2224:                 .Width           = 180
2225:                 .Sparse          = .F.
2226:                 .AddObject("Edit1", "EditBox")
2227:                 .CurrentControl  = "Edit1"

*-- Linhas 2233 a 2241:
2233:             ENDWITH
2234: 
2235:             WITH .Column3
2236:                 .Header1.Caption = "Fonte"
2237:                 .ControlSource   = "cursor_4c_PropsGrp.LblFonte"
2238:                 .Width           = 200
2239:                 .Sparse          = .F.
2240:                 .AddObject("Edit1", "EditBox")
2241:                 .CurrentControl  = "Edit1"

*-- Linhas 2247 a 2285:
2247:             ENDWITH
2248: 
2249:             WITH .Column4
2250:                 .Header1.Caption = "Fte"
2251:                 .ControlSource   = "cursor_4c_PropsGrp.LblBtFonte"
2252:                 .Width           = 80
2253:                 .Sparse          = .F.
2254:                 .AddObject("Command1", "CommandButton")
2255:                 .CurrentControl  = "Command1"
2256:                 WITH .Command1
2257:                     .Caption = "..."
2258:                     .Visible = .T.
2259:                     .Width   = 76
2260:                     .Height  = 18
2261:                 ENDWITH
2262:             ENDWITH
2263: 
2264:             WITH .Column5
2265:                 .Header1.Caption = "Cor"
2266:                 .ControlSource   = "cursor_4c_PropsGrp.LblBtCor"
2267:                 .Width           = 80
2268:                 .Sparse          = .F.
2269:                 .AddObject("Command1", "CommandButton")
2270:                 .CurrentControl  = "Command1"
2271:                 WITH .Command1
2272:                     .Caption = "..."
2273:                     .Visible = .T.
2274:                     .Width   = 76
2275:                     .Height  = 18
2276:                 ENDWITH
2277:             ENDWITH
2278: 
2279:             WITH .Column6
2280:                 .Header1.Caption = "Alinhar"
2281:                 .ControlSource   = "cursor_4c_PropsGrp.LblAlinhar"
2282:                 .Width           = 100
2283:                 .Sparse          = .F.
2284:                 .AddObject("Combo1", "ComboBox")
2285:                 .CurrentControl  = "Combo1"

*-- Linhas 2294 a 2302:
2294:             ENDWITH
2295: 
2296:             WITH .Column7
2297:                 .Header1.Caption = "Tam."
2298:                 .ControlSource   = "cursor_4c_PropsGrp.LblTamCmp"
2299:                 .Width           = 169
2300:                 .Sparse          = .F.
2301:                 .AddObject("Spinner1", "Spinner")
2302:                 .CurrentControl  = "Spinner1"

*-- Linhas 2317 a 2326:
2317:         loc_oGrdCMPs = loc_oSubPg2.grd_4c_PropsCampos
2318:         loc_oGrdGRP  = loc_oSubPg2.grd_4c_PropsGrp
2319: 
2320:         BINDEVENT(loc_oSubPg2.cnt_4c_BotoesLayout.cmd_4c_VoltarLayout, "Click", THIS, "BtnVoltarLayoutClick")
2321:         BINDEVENT(loc_oSubPg2.cnt_4c_BotoesLayout.cmd_4c_GerarLayout,  "Click", THIS, "BtnGerarLayoutClick")
2322:         BINDEVENT(loc_oSubPg2.opt_4c_Orientacao, "InteractiveChange",   THIS, "OrientacaoChanged")
2323:         BINDEVENT(loc_oGrdTIT.Column3.Command1,   "Click",              THIS, "BtnFonteTITClick")
2324:         BINDEVENT(loc_oGrdTIT.Column4.Command1,   "Click",              THIS, "BtnCorTITClick")
2325:         BINDEVENT(loc_oGrdCMPs.Column5.Check1,    "When",               THIS, "ChkSubTotalWhen")
2326:         BINDEVENT(loc_oGrdCMPs.Column6.Check1,    "When",               THIS, "ChkTotalFinalWhen")

*-- Linhas 3405 a 3413:
3405:             SELECT cursor_4c_PropsTitulo
3406:             loc_oPg2.opt_4c_Orientacao.Value    = cursor_4c_PropsTitulo.Orientation
3407:             loc_oPg2.cbo_4c_TamPapel.ListIndex  = cursor_4c_PropsTitulo.PaperSize
3408:             loc_oPg2.lbl_4c_NmRelatorio.Caption = ALLTRIM(THIS.this_oBusinessObject.this_cNmReport)
3409:             IF cursor_4c_PropsTitulo.Orientation = 1
3410:                 loc_oPg2.img_4c_Orientacao.Picture = gc_4c_CaminhoIcones + "Rpt_Orientacao_Retrato_26.JPG"
3411:             ELSE
3412:                 loc_oPg2.img_4c_Orientacao.Picture = gc_4c_CaminhoIcones + "Rpt_Orientacao_Paisagem_26.JPG"
3413:             ENDIF

*-- Linhas 3423 a 3431:
3423: 
3424:     *==========================================================================
3425:     * ConfigurarPgPage1 - FASE 9: Adiciona controles ausentes da Page1 original
3426:     * CmdGrp_Acoes (3 botoes), filtros De/Ate (FwEditData), lbl_4c_SqlAlterado
3427:     * Original: SIGCDRPT.Pagina.Dados.Pageframe1.Page1
3428:     *==========================================================================
3429:     PROTECTED PROCEDURE ConfigurarPgPage1()
3430:         LOCAL loc_oSubPg1, loc_oCab
3431:         loc_oSubPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

*-- Linhas 3437 a 3461:
3437:         loc_oCab = loc_oSubPg1.cnt_4c_CabecalhoDados
3438: 
3439:         *-- Reposicionar titulos para dar espaco aos 3 botoes de acao (Left=5..244)
3440:         IF PEMSTATUS(loc_oCab, "lbl_4c_TituloD_Sombra", 5)
3441:             loc_oCab.lbl_4c_TituloD_Sombra.Left  = 257
3442:             loc_oCab.lbl_4c_TituloD_Sombra.Width = THIS.Width - 440
3443:         ENDIF
3444:         IF PEMSTATUS(loc_oCab, "lbl_4c_TituloD", 5)
3445:             loc_oCab.lbl_4c_TituloD.Left  = 255
3446:             loc_oCab.lbl_4c_TituloD.Width = THIS.Width - 440
3447:         ENDIF
3448: 
3449:         *-- Botao LayOutRPT: salva SQL e vai para sub-pagina de Layout
3450:         *-- Original: CmdGrp_Acoes.Cmd_LayOutRPT (Left=5, Width~70)
3451:         loc_oCab.AddObject("cmd_4c_LayOutRPT", "CommandButton")
3452:         WITH loc_oCab.cmd_4c_LayOutRPT
3453:             .Caption         = "Salvar/" + CHR(13) + "Layout"
3454:             .ToolTipText     = "Salvar SQL e configurar Layout do Relat" + CHR(243) + "rio"
3455:             .Top             = 5
3456:             .Left            = 5
3457:             .Width           = 75
3458:             .Height          = 75
3459:             .FontName        = "Comic Sans MS"
3460:             .FontSize        = 7
3461:             .FontBold        = .T.

*-- Linhas 3469 a 3485:
3469:             .AutoSize        = .F.
3470:             .Visible         = .T.
3471:         ENDWITH
3472: 
3473:         *-- Botao Estrutura: exibe colunas da tabela selecionada no editor
3474:         *-- Original: CmdGrp_Acoes.Cmd_Estrutura (Left=80)
3475:         loc_oCab.AddObject("cmd_4c_Estrutura", "CommandButton")
3476:         WITH loc_oCab.cmd_4c_Estrutura
3477:             .Caption         = "Estrutura" + CHR(13) + "Tabela"
3478:             .ToolTipText     = "Mostrar colunas da tabela selecionada"
3479:             .Top             = 5
3480:             .Left            = 85
3481:             .Width           = 75
3482:             .Height          = 75
3483:             .FontName        = "Comic Sans MS"
3484:             .FontSize        = 7
3485:             .FontBold        = .T.

*-- Linhas 3493 a 3509:
3493:             .AutoSize        = .F.
3494:             .Visible         = .T.
3495:         ENDWITH
3496: 
3497:         *-- Botao Processar: seta datas e executa SQL no editor
3498:         *-- Original: CmdGrp_Acoes.Cmd_Processar (Left=155) + F8
3499:         loc_oCab.AddObject("cmd_4c_Processar", "CommandButton")
3500:         WITH loc_oCab.cmd_4c_Processar
3501:             .Caption         = "Executar" + CHR(13) + "SQL (F8)"
3502:             .ToolTipText     = "Executar SQL e exibir resultado"
3503:             .Top             = 5
3504:             .Left            = 165
3505:             .Width           = 80
3506:             .Height          = 75
3507:             .FontName        = "Comic Sans MS"
3508:             .FontSize        = 7
3509:             .FontBold        = .T.

*-- Linhas 3520 a 3532:
3520: 
3521:         *-- Filtros de data De:/Ate: - posicionados na Row1 (Right side, apos txt_4c_DtAlteracao)
3522:         *-- Original: Label1 Top=132 Left=26, FwEditData1 ControlSource="_vp_DtInicial"
3523:         loc_oSubPg1.AddObject("lbl_4c_De", "Label")
3524:         WITH loc_oSubPg1.lbl_4c_De
3525:             .Caption   = "De:"
3526:             .Top       = 123
3527:             .Left      = 802
3528:             .Width     = 22
3529:             .Height    = 17
3530:             .FontName  = "Tahoma"
3531:             .FontSize  = 8
3532:             .FontBold  = .T.

*-- Linhas 3538 a 3564:
3538:         loc_oSubPg1.AddObject("txt_4c_DtInicial", "TextBox")
3539:         WITH loc_oSubPg1.txt_4c_DtInicial
3540:             .Value       = DTOC(DATE())
3541:             .Top         = 120
3542:             .Left        = 827
3543:             .Width       = 68
3544:             .Height      = 23
3545:             .FontName    = "Tahoma"
3546:             .FontSize    = 8
3547:             .Format      = "E"
3548:             .MaxLength   = 10
3549:             .BackColor   = RGB(255, 255, 255)
3550:             .BorderStyle = 1
3551:             .Visible     = .T.
3552:         ENDWITH
3553: 
3554:         *-- Original: Label2 Top=131 Left=164 "Ate:"
3555:         loc_oSubPg1.AddObject("lbl_4c_Ate", "Label")
3556:         WITH loc_oSubPg1.lbl_4c_Ate
3557:             .Caption   = "At" + CHR(233) + ":"
3558:             .Top       = 123
3559:             .Left      = 899
3560:             .Width     = 28
3561:             .Height    = 17
3562:             .FontName  = "Tahoma"
3563:             .FontSize  = 8
3564:             .FontBold  = .T.

*-- Linhas 3571 a 3580:
3571:         loc_oSubPg1.AddObject("txt_4c_DtFinal", "TextBox")
3572:         WITH loc_oSubPg1.txt_4c_DtFinal
3573:             .Value       = DTOC(DATE())
3574:             .Top         = 120
3575:             .Left        = 930
3576:             .Width       = 65
3577:             .Height      = 23
3578:             .FontName    = "Tahoma"
3579:             .FontSize    = 8
3580:             .Format      = "E"

*-- Linhas 3586 a 3612:
3586: 
3587:         *-- Indicador SQL Alterado: "*" fica vermelho quando SQL eh modificado mas nao processado
3588:         *-- Original: Lbl_SQL_Alterado Top=147 Left=8
3589:         loc_oSubPg1.AddObject("lbl_4c_SqlAlterado", "Label")
3590:         WITH loc_oSubPg1.lbl_4c_SqlAlterado
3591:             .Caption   = "*"
3592:             .Top       = 238
3593:             .Left      = 73
3594:             .Width     = 20
3595:             .Height    = 17
3596:             .FontName  = "Tahoma"
3597:             .FontSize  = 10
3598:             .FontBold  = .T.
3599:             .ForeColor = RGB(0, 0, 0)
3600:             .BackStyle = 0
3601:             .Visible   = .T.
3602:         ENDWITH
3603: 
3604:         *-- BINDEVENTs para botoes de acao (handlers PUBLIC)
3605:         BINDEVENT(loc_oCab.cmd_4c_LayOutRPT, "Click", THIS, "BtnLayOutRPTClick")
3606:         BINDEVENT(loc_oCab.cmd_4c_Estrutura, "Click", THIS, "BtnEstruturaClick")
3607:         BINDEVENT(loc_oCab.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
3608: 
3609:     ENDPROC
3610: 
3611:     *==========================================================================
3612:     * FormatarGridLista - Formata visual do grid da lista


### BO (C:\4c\projeto\app\classes\RPTBO.prg):
*==============================================================================
* RPTBO.prg - Business Object - Cadastro Customizado de Relatorios 4Report
* Tabelas: SIGCDRLC (cabecalho), SIGCDRLD (detalhes FRX)
* Fase 1/8 - Propriedades e Init basico
*==============================================================================
DEFINE CLASS RPTBO AS BusinessBase

    *-- Cabecalho do Relatorio (SIGCDRLC)
    this_cRPT_ID         = ""   && RPT_ID - Chave primaria (DTOS+STRTRAN(TIME))
    this_cNmReport       = ""   && NmReport - Nome do arquivo do report
    this_cDescr          = ""   && Descr - Descricao do report
    this_dDtCriacao      = {}   && DtCriacao - Data de criacao
    this_dDtAlteracao    = {}   && DtAlteracao - Data de alteracao
    this_lAtivo          = .T.  && Ativo - Indicador ativo (default ligado)
    this_cSqlQuery       = ""   && SqlQuery - Query SQL do report

    *-- Parametros de Layout do Relatorio (Page2 do formulario)
    this_nOrientacao     = 1    && 1=Retrato, 2=Paisagem
    this_nTamPapel       = 1    && Indice do tamanho de papel no ComboBox

    *-- Controle interno
    this_cArqReport      = ""   && Caminho fisico do arquivo FRX gerado
    this_cDirTmp         = ""   && Diretorio temporario para arquivos FRX

    *==========================================================================
    * Init - Inicializa Business Object
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SIGCDRLC"
            THIS.this_cCampoChave = "RPT_ID"
            THIS.this_cDirTmp     = ".\Tmp\"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "RPTBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cRPT_ID)
    ENDFUNC

    *==========================================================================
    * LimparDados - Limpa todas as propriedades
    *==========================================================================
    PROTECTED PROCEDURE LimparDados()
        DODEFAULT()
        THIS.this_cRPT_ID      = ""
        THIS.this_cNmReport    = ""
        THIS.this_cDescr       = ""
        THIS.this_dDtCriacao   = {}
        THIS.this_dDtAlteracao = {}
        THIS.this_lAtivo       = .T.
        THIS.this_cSqlQuery    = ""
        THIS.this_nOrientacao  = 1
        THIS.this_nTamPapel    = 1
        THIS.this_cArqReport   = ""
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cRPT_ID      = TratarNulo(RPT_ID,      "C")
                THIS.this_cNmReport    = TratarNulo(NmReport,     "C")
                THIS.this_cDescr       = TratarNulo(Descr,        "C")
                THIS.this_lAtivo       = (TratarNulo(Ativo, "N") = 1)
                THIS.this_cSqlQuery    = TratarNulo(SqlQuery,     "C")
                IF PEMSTATUS(ALIAS(), "DtCriacao",   5)
                    THIS.this_dDtCriacao   = TratarNulo(DtCriacao,   "D")
                ENDIF
                IF PEMSTATUS(ALIAS(), "DtAlteracao", 5)
                    THIS.this_dDtAlteracao = TratarNulo(DtAlteracao, "D")
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar do cursor:" + CHR(13) + loc_oErro.Message, "RPTBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida dados antes de salvar
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cNmReport))
            MsgAviso("Obrigat" + CHR(243) + "rio informar o Nome do Report.")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cSqlQuery))
            MsgAviso("Obrigat" + CHR(243) + "rio informar o SQL do Report.")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * GerarRPT_ID - Gera chave RPT_ID no formato YYYYMMDD_HHMMSS
    * Padrao legado: DTOS(DATE()) + "_" + STRTRAN(TIME(), ":", "")
    *==========================================================================
    PROTECTED FUNCTION GerarRPT_ID()
        RETURN DTOS(DATE()) + "_" + STRTRAN(TIME(), ":", "")
    ENDFUNC

    *==========================================================================
    * Inserir - Insere novo registro na tabela SIGCDRLC
    * RPT_ID gerado como YYYYMMDD_HHMMSS
    * DtCriacao e DtAlteracao preenchidos com data atual
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cAtivo, loc_cDataHoje
        loc_lSucesso = .F.

        TRY
            THIS.this_cRPT_ID = THIS.GerarRPT_ID()
            loc_cAtivo        = IIF(THIS.this_lAtivo, "1", "0")
            loc_cDataHoje     = FormatarDataSQL(DATE())

            loc_cSQL = "INSERT INTO SIGCDRLC" + ;
                " (RPT_ID, NmReport, Ativo, Descr, DtCriacao, DtAlteracao, SqlQuery)" + ;
                " VALUES (" + ;
                EscaparSQL(THIS.this_cRPT_ID)            + ", " + ;
                EscaparSQL(UPPER(ALLTRIM(THIS.this_cNmReport))) + ", " + ;
                loc_cAtivo                               + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cDescr))    + ", " + ;
                loc_cDataHoje                            + ", " + ;
                loc_cDataHoje                            + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cSqlQuery)) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir report:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inserir:" + CHR(13) + loc_oErro.Message, "RPTBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza registro existente na tabela SIGCDRLC
    * DtAlteracao atualizado com data atual
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cAtivo
        loc_lSucesso = .F.

        TRY
            loc_cAtivo = IIF(THIS.this_lAtivo, "1", "0")

            loc_cSQL = "UPDATE SIGCDRLC SET" + ;
                " NmReport     = " + EscaparSQL(UPPER(ALLTRIM(THIS.this_cNmReport))) + "," + ;
                " Ativo        = " + loc_cAtivo + "," + ;
                " Descr        = " + EscaparSQL(ALLTRIM(THIS.this_cDescr)) + "," + ;
                " DtAlteracao  = " + FormatarDataSQL(DATE()) + "," + ;
                " SqlQuery     = " + EscaparSQL(ALLTRIM(THIS.this_cSqlQuery)) + ;
                " WHERE RPT_ID = " + EscaparSQL(THIS.this_cRPT_ID)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar report:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar:" + CHR(13) + loc_oErro.Message, "RPTBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui registro de SIGCDRLD (detalhes FRX) e SIGCDRLC
    * Ordem obrigatoria: detalhes primeiro, cabecalho depois (FK)
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SIGCDRLD WHERE RPT_ID = " + ;
                EscaparSQL(THIS.this_cRPT_ID)
            SQLEXEC(gnConnHandle, loc_cSQL)

            loc_cSQL = "DELETE FROM SIGCDRLC WHERE RPT_ID = " + ;
                EscaparSQL(THIS.this_cRPT_ID)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir report:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao excluir:" + CHR(13) + loc_oErro.Message, "RPTBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - Busca lista de reports (exibe no grid da Page1)
    * Cursor: cursor_4c_Dados com RPT_ID, NmReport, Descr, Ativo, DtCriacao, DtAlteracao
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados ( ;
                        RPT_ID       C(20), ;
                        NmReport     C(100), ;
                        Descr        C(200), ;
                        Ativo        I,      ;
                        DtCriacao    D,      ;
                        DtAlteracao  D       ;
                    )
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT RPT_ID, NmReport, Descr, Ativo, DtCriacao, DtAlteracao" + ;
                    " FROM SIGCDRLC"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY NmReport"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao buscar reports:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message, "RPTBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro completo pelo RPT_ID (inclui SqlQuery)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cRPT_ID)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT RPT_ID, NmReport, Descr, Ativo, DtCriacao, DtAlteracao, SqlQuery" + ;
                " FROM SIGCDRLC WHERE RPT_ID = " + EscaparSQL(par_cRPT_ID)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND USED("cursor_4c_Carrega")
                SELECT cursor_4c_Carrega
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                USE IN cursor_4c_Carrega
            ELSE
                MsgErro("Erro ao carregar report:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar por c" + CHR(243) + "digo:" + CHR(13) + loc_oErro.Message, "RPTBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

