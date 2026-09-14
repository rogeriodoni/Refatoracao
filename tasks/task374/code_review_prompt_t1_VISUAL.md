# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [FONTNAME-ERRADO] Linha 211: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 233: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 255: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 277: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 299: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 335: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 462: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 484: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 520: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCmr.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2472 linhas total):

*-- Linhas 42 a 50:
42:         TRY
43:             IF PCOUNT() >= 1 AND VARTYPE(par_cBalancos) = "C"
44:                 THIS.this_cBalancos = ALLTRIM(par_cBalancos)
45:                 THIS.Caption = "Itens : " + ALLTRIM(par_cBalancos)
46:             ENDIF
47:             IF PCOUNT() >= 2 AND VARTYPE(par_nMapas) = "N"
48:                 THIS.this_nMapas = par_nMapas
49:             ENDIF
50: 

*-- Linhas 75 a 85:
75:                 THIS.ConfigurarPaginaLista()
76:                 THIS.ConfigurarPaginaDados()
77: 
78:                 IF TYPE("THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo") = "O"
79:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
80:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
81:                 ENDIF
82: 
83:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
84:                     THIS.CarregarLista()
85:                 ENDIF

*-- Linhas 108 a 136:
108:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
109: 
110:         WITH THIS.pgf_4c_Paginas
111:             .Top       = -29
112:             .Left      = 0
113:             .Width     = 1003
114:             .Height    = 629
115:             .PageCount = 2
116:             .Tabs      = .F.
117:             .Visible   = .T.
118: 
119:             .Page1.Caption   = "Lista"
120:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
121:             .Page1.BackColor = RGB(255, 255, 255)
122: 
123:             .Page2.Caption   = "Dados"
124:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
125:             .Page2.BackColor = RGB(255, 255, 255)
126:         ENDWITH
127:     ENDPROC
128: 
129:     *==========================================================================
130:     * CONFIGURACAO PAGE1 - LISTA
131:     * Compensacao +29: Grupo_op.Top=-1 -> 28; cntSombra.Top=2 -> 31
132:     *==========================================================================
133: 
134:     PROTECTED PROCEDURE ConfigurarPaginaLista()
135:         LOCAL loc_oPagina
136:         loc_oPagina = THIS.pgf_4c_Paginas.Page1

*-- Linhas 143 a 305:
143:         *----------------------------------------------------------------------
144:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
145:         WITH loc_oPagina.cnt_4c_Cabecalho
146:             .Top         = 31
147:             .Left        = 0
148:             .Width       = THIS.Width
149:             .Height      = 80
150:             .BackColor   = RGB(100, 100, 100)
151:             .BorderWidth = 0
152:             .Visible     = .T.
153:         ENDWITH
154: 
155:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
156:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
157:             .Top       = 15
158:             .Left      = 10
159:             .Width     = THIS.Width - 10
160:             .Height    = 40
161:             .AutoSize  = .F.
162:             .FontName  = "Tahoma"
163:             .FontSize  = 16
164:             .FontBold  = .T.
165:             .ForeColor = RGB(0, 0, 0)
166:             .BackStyle = 0
167:             .Caption   = THIS.Caption
168:             .Visible   = .T.
169:         ENDWITH
170: 
171:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
172:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
173:             .Top       = 18
174:             .Left      = 10
175:             .Width     = THIS.Width - 10
176:             .Height    = 46
177:             .AutoSize  = .F.
178:             .FontName  = "Tahoma"
179:             .FontSize  = 16
180:             .FontBold  = .T.
181:             .ForeColor = RGB(255, 255, 255)
182:             .BackStyle = 0
183:             .Caption   = THIS.Caption
184:             .Visible   = .T.
185:         ENDWITH
186: 
187:         *----------------------------------------------------------------------
188:         * Container Botoes CRUD (Grupo_op no legado)
189:         * Legado: Left=344(800px) -> proporcional 542(1000px), Top=-1+29=28
190:         *----------------------------------------------------------------------
191:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
192:         WITH loc_oPagina.cnt_4c_Botoes
193:             .Top         = 28
194:             .Left        = 542
195:             .Width       = 390
196:             .Height      = 85
197:             .BackStyle = 0
198:             .BorderWidth = 0
199:             .Visible     = .T.
200:         ENDWITH
201: 
202:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
203:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
204:             .Caption         = "Incluir"
205:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
206:             .PicturePosition = 13
207:             .Top             = 5
208:             .Left            = 5
209:             .Width           = 75
210:             .Height          = 75
211:             .FontName        = "Comic Sans MS"
212:             .FontBold        = .T.
213:             .FontItalic      = .T.
214:             .FontSize        = 8
215:             .ForeColor       = RGB(90, 90, 90)
216:             .BackColor       = RGB(255, 255, 255)
217:             .Themes          = .F.
218:             .SpecialEffect   = 0
219:             .MousePointer    = 15
220:             .WordWrap        = .T.
221:             .Visible         = .T.
222:         ENDWITH
223: 
224:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
225:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
226:             .Caption         = "Visualizar"
227:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
228:             .PicturePosition = 13
229:             .Top             = 5
230:             .Left            = 80
231:             .Width           = 75
232:             .Height          = 75
233:             .FontName        = "Comic Sans MS"
234:             .FontBold        = .T.
235:             .FontItalic      = .T.
236:             .FontSize        = 8
237:             .ForeColor       = RGB(90, 90, 90)
238:             .BackColor       = RGB(255, 255, 255)
239:             .Themes          = .F.
240:             .SpecialEffect   = 0
241:             .MousePointer    = 15
242:             .WordWrap        = .T.
243:             .Visible         = .T.
244:         ENDWITH
245: 
246:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
247:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
248:             .Caption         = "Alterar"
249:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
250:             .PicturePosition = 13
251:             .Top             = 5
252:             .Left            = 155
253:             .Width           = 75
254:             .Height          = 75
255:             .FontName        = "Comic Sans MS"
256:             .FontBold        = .T.
257:             .FontItalic      = .T.
258:             .FontSize        = 8
259:             .ForeColor       = RGB(90, 90, 90)
260:             .BackColor       = RGB(255, 255, 255)
261:             .Themes          = .F.
262:             .SpecialEffect   = 0
263:             .MousePointer    = 15
264:             .WordWrap        = .T.
265:             .Visible         = .T.
266:         ENDWITH
267: 
268:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
269:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
270:             .Caption         = "Excluir"
271:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
272:             .PicturePosition = 13
273:             .Top             = 5
274:             .Left            = 230
275:             .Width           = 75
276:             .Height          = 75
277:             .FontName        = "Comic Sans MS"
278:             .FontBold        = .T.
279:             .FontItalic      = .T.
280:             .FontSize        = 8
281:             .ForeColor       = RGB(90, 90, 90)
282:             .BackColor       = RGB(255, 255, 255)
283:             .Themes          = .F.
284:             .SpecialEffect   = 0
285:             .MousePointer    = 15
286:             .WordWrap        = .T.
287:             .Visible         = .T.
288:         ENDWITH
289: 
290:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
291:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
292:             .Caption         = "Buscar"
293:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
294:             .PicturePosition = 13
295:             .Top             = 5
296:             .Left            = 305
297:             .Width           = 75
298:             .Height          = 75
299:             .FontName        = "Comic Sans MS"
300:             .FontBold        = .T.
301:             .FontItalic      = .T.
302:             .FontSize        = 8
303:             .ForeColor       = RGB(90, 90, 90)
304:             .BackColor       = RGB(255, 255, 255)
305:             .Themes          = .F.

*-- Linhas 314 a 341:
314:         *----------------------------------------------------------------------
315:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
316:         WITH loc_oPagina.cnt_4c_Saida
317:             .Top         = 29
318:             .Left        = 917
319:             .Width       = 90
320:             .Height      = 85
321:             .BackStyle   = 0
322:             .BorderWidth = 0
323:             .Visible     = .T.
324:         ENDWITH
325: 
326:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
327:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
328:             .Caption         = "Encerrar"
329:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
330:             .PicturePosition = 13
331:             .Top             = 5
332:             .Left            = 5
333:             .Width           = 75
334:             .Height          = 75
335:             .FontName        = "Comic Sans MS"
336:             .FontBold        = .T.
337:             .FontItalic      = .T.
338:             .FontSize        = 8
339:             .ForeColor       = RGB(90, 90, 90)
340:             .BackColor       = RGB(255, 255, 255)
341:             .Themes          = .F.

*-- Linhas 354 a 363:
354:         loc_oPagina.grd_4c_Lista.RecordSource = ""
355: 
356:         WITH loc_oPagina.grd_4c_Lista
357:             .Top                = 117
358:             .Left               = 12
359:             .Width              = 900
360:             .Height             = 455
361:             .FontName           = "Tahoma"
362:             .FontSize           = 8
363:             .RowHeight          = 16

*-- Linhas 376 a 434:
376: 
377:             .Column1.Width          = 80
378:             .Column1.Alignment      = 0
379:             .Column1.Header1.Caption = "Classe"
380: 
381:             .Column2.Width          = 33
382:             .Column2.Alignment      = 1
383:             .Column2.Header1.Caption = "N" + CHR(237) + "vel"
384: 
385:             .Column3.Width          = 40
386:             .Column3.Alignment      = 1
387:             .Column3.Header1.Caption = "Oper"
388: 
389:             .Column4.Width          = 80
390:             .Column4.Alignment      = 0
391:             .Column4.Header1.Caption = "Grupo"
392: 
393:             .Column5.Width          = 30
394:             .Column5.Alignment      = 1
395:             .Column5.Header1.Caption = "A/S"
396: 
397:             .Column6.Width          = 220
398:             .Column6.Alignment      = 0
399:             .Column6.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
400: 
401:             .Column7.Width          = 40
402:             .Column7.Alignment      = 1
403:             .Column7.Header1.Caption = "Fator"
404: 
405:             .Column8.Width          = 80
406:             .Column8.Alignment      = 0
407:             .Column8.Header1.Caption = "T" + CHR(237) + "tulo"
408: 
409:             .Column9.Width          = 50
410:             .Column9.Alignment      = 1
411:             .Column9.Header1.Caption = "Ordem"
412:         ENDWITH
413: 
414:         *----------------------------------------------------------------------
415:         * BINDEVENTs - botoes Page1 (metodos PUBLIC para BINDEVENT)
416:         *----------------------------------------------------------------------
417:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
418:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
419:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
420:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
421:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
422:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
423: 
424:         THIS.TornarControlesVisiveis(loc_oPagina)
425:     ENDPROC
426: 
427:     *==========================================================================
428:     * CONFIGURACAO PAGE2 - DADOS
429:     * Todos os controles com compensacao +29 de PageFrame.Top=-29
430:     *==========================================================================
431: 
432:     PROTECTED PROCEDURE ConfigurarPaginaDados()
433:         LOCAL loc_oPagina
434:         loc_oPagina = THIS.pgf_4c_Paginas.Page2

*-- Linhas 441 a 490:
441:         *----------------------------------------------------------------------
442:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
443:         WITH loc_oPagina.cnt_4c_BotoesAcao
444:             .Top         = 33
445:             .Left        = 842
446:             .Width       = 160
447:             .Height      = 85
448:             .BackStyle = 1
449:             .BackColor = RGB(255, 255, 255)
450:             .Visible     = .T.
451:         ENDWITH
452: 
453:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
454:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
455:             .Caption         = "Confirmar"
456:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
457:             .PicturePosition = 13
458:             .Top             = 5
459:             .Left            = 5
460:             .Width           = 75
461:             .Height          = 75
462:             .FontName        = "Comic Sans MS"
463:             .FontBold        = .T.
464:             .FontItalic      = .T.
465:             .FontSize        = 8
466:             .ForeColor       = RGB(90, 90, 90)
467:             .BackColor       = RGB(255, 255, 255)
468:             .Themes          = .F.
469:             .SpecialEffect   = 0
470:             .MousePointer    = 15
471:             .WordWrap        = .T.
472:             .Visible         = .T.
473:         ENDWITH
474: 
475:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
476:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
477:             .Caption         = "Encerrar"
478:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
479:             .PicturePosition = 13
480:             .Top             = 5
481:             .Left            = 80
482:             .Width           = 75
483:             .Height          = 75
484:             .FontName        = "Comic Sans MS"
485:             .FontBold        = .T.
486:             .FontItalic      = .T.
487:             .FontSize        = 8
488:             .ForeColor       = RGB(90, 90, 90)
489:             .BackColor       = RGB(255, 255, 255)
490:             .Themes          = .F.

*-- Linhas 499 a 526:
499:         *----------------------------------------------------------------------
500:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
501:         WITH loc_oPagina.cnt_4c_Saida
502:             .Top         = 29
503:             .Left        = 917
504:             .Width       = 90
505:             .Height      = 85
506:             .BackStyle   = 0
507:             .BorderWidth = 0
508:             .Visible     = .T.
509:         ENDWITH
510: 
511:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
512:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
513:             .Caption         = "Encerrar"
514:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
515:             .PicturePosition = 13
516:             .Top             = 5
517:             .Left            = 5
518:             .Width           = 75
519:             .Height          = 75
520:             .FontName        = "Comic Sans MS"
521:             .FontBold        = .T.
522:             .FontItalic      = .T.
523:             .FontSize        = 8
524:             .ForeColor       = RGB(90, 90, 90)
525:             .BackColor       = RGB(255, 255, 255)
526:             .Themes          = .F.

*-- Linhas 543 a 595:
543:             .BackStyle   = 0
544:             .BorderStyle = 0
545:             .Value       = 1
546:             .Top         = 204
547:             .Left        = 304
548:             .Width       = 185
549:             .Height      = 26
550:             .Visible     = .T.
551:         ENDWITH
552:         WITH loc_oPagina.obj_4c_OptTpregs.Buttons(1)
553:             .Caption   = "\<Grupo"
554:             .BackStyle = 0
555:             .Left      = 5
556:             .Top       = 5
557:             .Width     = 47
558:             .AutoSize  = .T.
559:             .FontName  = "Tahoma"
560:             .FontSize  = 8
561:             .ForeColor = RGB(90, 90, 90)
562:         ENDWITH
563:         WITH loc_oPagina.obj_4c_OptTpregs.Buttons(2)
564:             .Caption   = "\<SubTotal"
565:             .BackStyle = 0
566:             .Left      = 120
567:             .Top       = 6
568:             .AutoSize  = .T.
569:             .FontName  = "Tahoma"
570:             .FontSize  = 8
571:             .ForeColor = RGB(90, 90, 90)
572:         ENDWITH
573:         WITH loc_oPagina.obj_4c_OptTpregs.Buttons(3)
574:             .Caption   = "Classe"
575:             .BackStyle = 0
576:             .Left      = 59
577:             .Top       = 5
578:             .Width     = 49
579:             .AutoSize  = .T.
580:             .FontName  = "Tahoma"
581:             .FontSize  = 8
582:             .ForeColor = RGB(90, 90, 90)
583:         ENDWITH
584: 
585:         *-- Say1: Descricao SubTotal (Top=211+29=240)
586:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
587:         WITH loc_oPagina.lbl_4c_Label1
588:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o SubTotal :"
589:             .Top       = 240
590:             .Left      = 197
591:             .Width     = 103
592:             .Height    = 17
593:             .FontName  = "Tahoma"
594:             .FontSize  = 8
595:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 601 a 654:
601:         *-- getDescgrps (Top=205+29=234)
602:         loc_oPagina.AddObject("txt_4c_Descgrps", "TextBox")
603:         WITH loc_oPagina.txt_4c_Descgrps
604:             .Top       = 234
605:             .Left      = 304
606:             .Width     = 220
607:             .Height    = 25
608:             .MaxLength = 30
609:             .FontName  = "Tahoma"
610:             .FontSize  = 8
611:             .ForeColor = RGB(90, 90, 90)
612:             .Visible   = .T.
613:         ENDWITH
614: 
615:         *-- Say6: Ordem (Top=210+29=239)
616:         loc_oPagina.AddObject("lbl_4c_Label6", "Label")
617:         WITH loc_oPagina.lbl_4c_Label6
618:             .Caption   = "Ordem :"
619:             .Top       = 239
620:             .Left      = 526
621:             .Height    = 17
622:             .FontName  = "Tahoma"
623:             .FontSize  = 8
624:             .ForeColor = RGB(90, 90, 90)
625:             .AutoSize  = .T.
626:             .BackStyle = 0
627:             .Visible   = .T.
628:         ENDWITH
629: 
630:         *-- getOrdems (Top=206+29=235)
631:         loc_oPagina.AddObject("txt_4c_Ordems", "TextBox")
632:         WITH loc_oPagina.txt_4c_Ordems
633:             .Top       = 235
634:             .Left      = 574
635:             .Width     = 31
636:             .Height    = 25
637:             .InputMask = "999"
638:             .FontName  = "Tahoma"
639:             .FontSize  = 8
640:             .ForeColor = RGB(90, 90, 90)
641:             .Visible   = .T.
642:         ENDWITH
643: 
644:         *-- lbl_grupos (Top=236+29=265)
645:         loc_oPagina.AddObject("lbl_4c_Lbl_grupos", "Label")
646:         WITH loc_oPagina.lbl_4c_Lbl_grupos
647:             .Caption   = "Grupo :"
648:             .Top       = 265
649:             .Left      = 262
650:             .Width     = 38
651:             .Height    = 17
652:             .FontName  = "Tahoma"
653:             .FontSize  = 8
654:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 660 a 699:
660:         *-- get_cd_grupos (Top=231+29=260)
661:         loc_oPagina.AddObject("txt_4c__cd_grupos", "TextBox")
662:         WITH loc_oPagina.txt_4c__cd_grupos
663:             .Top       = 260
664:             .Left      = 304
665:             .Width     = 80
666:             .Height    = 25
667:             .MaxLength = 10
668:             .FontName  = "Tahoma"
669:             .FontSize  = 8
670:             .ForeColor = RGB(90, 90, 90)
671:             .Visible   = .T.
672:         ENDWITH
673: 
674:         *-- get_ds_grupos (Top=231+29=260)
675:         loc_oPagina.AddObject("txt_4c__ds_grupos", "TextBox")
676:         WITH loc_oPagina.txt_4c__ds_grupos
677:             .Top       = 260
678:             .Left      = 385
679:             .Width     = 150
680:             .Height    = 25
681:             .MaxLength = 20
682:             .ReadOnly  = .T.
683:             .FontName  = "Tahoma"
684:             .FontSize  = 8
685:             .ForeColor = RGB(90, 90, 90)
686:             .Visible   = .T.
687:         ENDWITH
688: 
689:         *-- Say4: Classe (Top=263+29=292)
690:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
691:         WITH loc_oPagina.lbl_4c_Label4
692:             .Caption   = "Classe :"
693:             .Top       = 292
694:             .Left      = 260
695:             .Width     = 40
696:             .Height    = 17
697:             .FontName  = "Tahoma"
698:             .FontSize  = 8
699:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 705 a 744:
705:         *-- Get_classe (Top=257+29=286)
706:         loc_oPagina.AddObject("txt_4c_Classe", "TextBox")
707:         WITH loc_oPagina.txt_4c_Classe
708:             .Top       = 286
709:             .Left      = 304
710:             .Width     = 80
711:             .Height    = 25
712:             .MaxLength = 10
713:             .FontName  = "Tahoma"
714:             .FontSize  = 8
715:             .ForeColor = RGB(90, 90, 90)
716:             .Visible   = .T.
717:         ENDWITH
718: 
719:         *-- Get_dclasse (Top=257+29=286)
720:         loc_oPagina.AddObject("txt_4c_Dclasse", "TextBox")
721:         WITH loc_oPagina.txt_4c_Dclasse
722:             .Top       = 286
723:             .Left      = 385
724:             .Width     = 220
725:             .Height    = 25
726:             .MaxLength = 20
727:             .ReadOnly  = .T.
728:             .FontName  = "Tahoma"
729:             .FontSize  = 8
730:             .ForeColor = RGB(90, 90, 90)
731:             .Visible   = .T.
732:         ENDWITH
733: 
734:         *-- lbl_operacaos (Top=289+29=318)
735:         loc_oPagina.AddObject("lbl_4c_Lbl_operacaos", "Label")
736:         WITH loc_oPagina.lbl_4c_Lbl_operacaos
737:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
738:             .Top       = 318
739:             .Left      = 244
740:             .Width     = 56
741:             .Height    = 17
742:             .FontName  = "Tahoma"
743:             .FontSize  = 8
744:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 750 a 759:
750:         *-- cmb_operacaos (Top=283+29=312, Style=2 dropdown list)
751:         loc_oPagina.AddObject("cbo_4c_Cmb_operacaos", "ComboBox")
752:         WITH loc_oPagina.cbo_4c_Cmb_operacaos
753:             .Top       = 312
754:             .Left      = 304
755:             .Width     = 150
756:             .Height    = 25
757:             .Style     = 2
758:             .FontName  = "Tahoma"
759:             .FontSize  = 8

*-- Linhas 765 a 777:
765:         loc_oPagina.cbo_4c_Cmb_operacaos.ListIndex = 1
766: 
767:         *-- lbl_analitico (Top=313+29=342)
768:         loc_oPagina.AddObject("lbl_4c_Lbl_analitico", "Label")
769:         WITH loc_oPagina.lbl_4c_Lbl_analitico
770:             .Caption   = "Impress" + CHR(227) + "o Anal" + CHR(237) + "tica :"
771:             .Top       = 342
772:             .Left      = 198
773:             .Width     = 102
774:             .Height    = 17
775:             .FontName  = "Tahoma"
776:             .FontSize  = 8
777:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 787 a 828:
787:             .BackStyle   = 0
788:             .BorderStyle = 0
789:             .Value       = 1
790:             .Top         = 337
791:             .Left        = 304
792:             .Width       = 97
793:             .Height      = 25
794:             .Visible     = .T.
795:         ENDWITH
796:         WITH loc_oPagina.obj_4c_Opt_analiticos.Buttons(1)
797:             .Caption   = "Sim"
798:             .BackStyle = 0
799:             .Left      = 5
800:             .Top       = 5
801:             .Width     = 34
802:             .AutoSize  = .T.
803:             .FontName  = "Tahoma"
804:             .FontSize  = 8
805:             .ForeColor = RGB(90, 90, 90)
806:         ENDWITH
807:         WITH loc_oPagina.obj_4c_Opt_analiticos.Buttons(2)
808:             .Caption   = "N" + CHR(227) + "o"
809:             .BackStyle = 0
810:             .Left      = 51
811:             .Top       = 5
812:             .AutoSize  = .T.
813:             .FontName  = "Tahoma"
814:             .FontSize  = 8
815:             .ForeColor = RGB(90, 90, 90)
816:         ENDWITH
817: 
818:         *-- Say5: Contra Partida (Top=335+29=364)
819:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
820:         WITH loc_oPagina.lbl_4c_Label5
821:             .Caption   = "Contra Partida :"
822:             .Top       = 364
823:             .Left      = 221
824:             .Width     = 79
825:             .Height    = 17
826:             .FontName  = "Tahoma"
827:             .FontSize  = 8
828:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 838 a 879:
838:             .BackStyle   = 0
839:             .BorderStyle = 0
840:             .Value       = 2
841:             .Top         = 359
842:             .Left        = 304
843:             .Width       = 97
844:             .Height      = 25
845:             .Visible     = .T.
846:         ENDWITH
847:         WITH loc_oPagina.obj_4c_Opt_CPartida.Buttons(1)
848:             .Caption   = "Sim"
849:             .BackStyle = 0
850:             .Left      = 5
851:             .Top       = 5
852:             .Width     = 34
853:             .AutoSize  = .T.
854:             .FontName  = "Tahoma"
855:             .FontSize  = 8
856:             .ForeColor = RGB(90, 90, 90)
857:         ENDWITH
858:         WITH loc_oPagina.obj_4c_Opt_CPartida.Buttons(2)
859:             .Caption   = "N" + CHR(227) + "o"
860:             .BackStyle = 0
861:             .Left      = 51
862:             .Top       = 5
863:             .AutoSize  = .T.
864:             .FontName  = "Tahoma"
865:             .FontSize  = 8
866:             .ForeColor = RGB(90, 90, 90)
867:         ENDWITH
868: 
869:         *-- Say7: SubTotal 100% (Top=358+29=387)
870:         loc_oPagina.AddObject("lbl_4c_Label7", "Label")
871:         WITH loc_oPagina.lbl_4c_Label7
872:             .Caption   = "SubTotal 100% :"
873:             .Top       = 387
874:             .Left      = 217
875:             .Width     = 83
876:             .Height    = 17
877:             .FontName  = "Tahoma"
878:             .FontSize  = 8
879:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 889 a 1020:
889:             .BackStyle   = 0
890:             .BorderStyle = 0
891:             .Value       = 2
892:             .Top         = 383
893:             .Left        = 304
894:             .Width       = 97
895:             .Height      = 25
896:             .Visible     = .T.
897:         ENDWITH
898:         WITH loc_oPagina.obj_4c_Opt_subtot100.Buttons(1)
899:             .Caption   = "Sim"
900:             .BackStyle = 0
901:             .Left      = 5
902:             .Top       = 5
903:             .Width     = 34
904:             .AutoSize  = .T.
905:             .FontName  = "Tahoma"
906:             .FontSize  = 8
907:             .ForeColor = RGB(90, 90, 90)
908:         ENDWITH
909:         WITH loc_oPagina.obj_4c_Opt_subtot100.Buttons(2)
910:             .Caption   = "N" + CHR(227) + "o"
911:             .BackStyle = 0
912:             .Left      = 51
913:             .Top       = 5
914:             .AutoSize  = .T.
915:             .FontName  = "Tahoma"
916:             .FontSize  = 8
917:             .ForeColor = RGB(90, 90, 90)
918:         ENDWITH
919: 
920:         *-- Say2: Fator (Top=383+29=412)
921:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
922:         WITH loc_oPagina.lbl_4c_Label2
923:             .Caption   = "Fator :"
924:             .Top       = 412
925:             .Left      = 265
926:             .Height    = 17
927:             .FontName  = "Tahoma"
928:             .FontSize  = 8
929:             .ForeColor = RGB(90, 90, 90)
930:             .AutoSize  = .T.
931:             .BackStyle = 0
932:             .Visible   = .T.
933:         ENDWITH
934: 
935:         *-- fator (Top=380+29=409, default 100)
936:         loc_oPagina.AddObject("txt_4c_Fator", "TextBox")
937:         WITH loc_oPagina.txt_4c_Fator
938:             .Top       = 409
939:             .Left      = 304
940:             .Width     = 31
941:             .Height    = 25
942:             .InputMask = "999"
943:             .FontName  = "Tahoma"
944:             .FontSize  = 8
945:             .ForeColor = RGB(90, 90, 90)
946:             .Visible   = .T.
947:         ENDWITH
948: 
949:         *-- Say3: % (Top=384+29=413)
950:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
951:         WITH loc_oPagina.lbl_4c_Label3
952:             .Caption   = "%"
953:             .Top       = 413
954:             .Left      = 343
955:             .Height    = 17
956:             .FontName  = "Tahoma"
957:             .FontSize  = 8
958:             .ForeColor = RGB(90, 90, 90)
959:             .AutoSize  = .T.
960:             .BackStyle = 0
961:             .Visible   = .T.
962:         ENDWITH
963: 
964:         *-- sayTitulo (Top=407+29=436) - visivel somente quando Mapas=2
965:         loc_oPagina.AddObject("lbl_4c_SayTitulo", "Label")
966:         WITH loc_oPagina.lbl_4c_SayTitulo
967:             .Caption   = "T" + CHR(237) + "tulo :"
968:             .Top       = 436
969:             .Left      = 265
970:             .Height    = 17
971:             .FontName  = "Tahoma"
972:             .FontSize  = 8
973:             .ForeColor = RGB(90, 90, 90)
974:             .AutoSize  = .T.
975:             .BackStyle = 0
976:             .Visible   = (THIS.this_nMapas = 2)
977:         ENDWITH
978: 
979:         *-- getTitulo (Top=404+29=433) - visivel somente quando Mapas=2
980:         loc_oPagina.AddObject("txt_4c_Titulo", "TextBox")
981:         WITH loc_oPagina.txt_4c_Titulo
982:             .Top         = 433
983:             .Left        = 304
984:             .Width       = 80
985:             .Height      = 25
986:             .InputMask   = "!!!!!!!!!!"
987:             .MaxLength   = 10
988:             .FontName    = "Tahoma"
989:             .FontSize    = 8
990:             .ForeColor   = RGB(90, 90, 90)
991:             .ToolTipText = "Cabe" + CHR(231) + "alho da Coluna no Relat" + CHR(243) + "rio"
992:             .Visible     = (THIS.this_nMapas = 2)
993:         ENDWITH
994: 
995:         *-- SayDtitulo (Top=410+29=439) - visivel somente quando Mapas=2
996:         loc_oPagina.AddObject("lbl_4c_Dtitulo", "Label")
997:         WITH loc_oPagina.lbl_4c_Dtitulo
998:             .Caption   = "(Emiss" + CHR(227) + "o de Mapa)"
999:             .Top       = 439
1000:             .Left      = 388
1001:             .Height    = 17
1002:             .FontName  = "Tahoma"
1003:             .FontSize  = 8
1004:             .ForeColor = RGB(90, 90, 90)
1005:             .AutoSize  = .T.
1006:             .BackStyle = 0
1007:             .Visible   = (THIS.this_nMapas = 2)
1008:         ENDWITH
1009: 
1010:         *-- Say8: Checar Data (Top=436+29=465)
1011:         loc_oPagina.AddObject("lbl_4c_Label8", "Label")
1012:         WITH loc_oPagina.lbl_4c_Label8
1013:             .Caption   = "Checar Data :"
1014:             .Top       = 465
1015:             .Left      = 231
1016:             .Height    = 17
1017:             .FontName  = "Tahoma"
1018:             .FontSize  = 8
1019:             .ForeColor = RGB(90, 90, 90)
1020:             .AutoSize  = .T.

*-- Linhas 1030 a 1095:
1030:             .BackStyle   = 0
1031:             .BorderStyle = 0
1032:             .Value       = 3
1033:             .Top         = 460
1034:             .Left        = 298
1035:             .Width       = 320
1036:             .Height      = 25
1037:             .AutoSize    = .T.
1038:             .Visible     = .T.
1039:         ENDWITH
1040:         WITH loc_oPagina.obj_4c_OptTpDatas.Buttons(1)
1041:             .Caption   = "Emiss" + CHR(227) + "o"
1042:             .BackStyle = 0
1043:             .Left      = 5
1044:             .Top       = 5
1045:             .Width     = 56
1046:             .AutoSize  = .T.
1047:             .FontName  = "Tahoma"
1048:             .FontSize  = 8
1049:             .ForeColor = RGB(90, 90, 90)
1050:         ENDWITH
1051:         WITH loc_oPagina.obj_4c_OptTpDatas.Buttons(2)
1052:             .Caption   = "Lan" + CHR(231) + "amento"
1053:             .BackStyle = 0
1054:             .Left      = 78
1055:             .Top       = 5
1056:             .Width     = 76
1057:             .AutoSize  = .T.
1058:             .FontName  = "Tahoma"
1059:             .FontSize  = 8
1060:             .ForeColor = RGB(90, 90, 90)
1061:         ENDWITH
1062:         WITH loc_oPagina.obj_4c_OptTpDatas.Buttons(3)
1063:             .Caption   = "Vencimento"
1064:             .BackStyle = 0
1065:             .Left      = 173
1066:             .Top       = 5
1067:             .Width     = 73
1068:             .AutoSize  = .T.
1069:             .FontName  = "Tahoma"
1070:             .FontSize  = 8
1071:             .ForeColor = RGB(90, 90, 90)
1072:         ENDWITH
1073:         WITH loc_oPagina.obj_4c_OptTpDatas.Buttons(4)
1074:             .Caption   = "Baixa"
1075:             .BackStyle = 0
1076:             .Left      = 266
1077:             .Top       = 5
1078:             .Width     = 44
1079:             .AutoSize  = .T.
1080:             .FontName  = "Tahoma"
1081:             .FontSize  = 8
1082:             .ForeColor = RGB(90, 90, 90)
1083:         ENDWITH
1084: 
1085:         *----------------------------------------------------------------------
1086:         * BINDEVENTs Page2
1087:         *----------------------------------------------------------------------
1088:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
1089:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
1090:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,       "Click", THIS, "BtnEncerrarClick")
1091:         BINDEVENT(loc_oPagina.obj_4c_OptTpregs,     "InteractiveChange", THIS, "OptTpregsChanged")
1092:         BINDEVENT(loc_oPagina.txt_4c__cd_grupos,    "KeyPress",        THIS, "ValidarGrupo")
1093:         BINDEVENT(loc_oPagina.txt_4c__ds_grupos,    "KeyPress",        THIS, "ValidarDescGrupo")
1094:         BINDEVENT(loc_oPagina.txt_4c_Classe,        "KeyPress",        THIS, "ValidarClasse")
1095:         BINDEVENT(loc_oPagina.txt_4c_Dclasse,       "KeyPress",        THIS, "ValidarDescClasse")

*-- Linhas 1133 a 1189:
1133:                     WITH loc_oGrid
1134:                         *-- Column1: Classe (mostra Classes se Grupos vazio, senao branco)
1135:                         .Column1.ControlSource  = "iif(EMPTY(cursor_4c_Dados.Grupos),cursor_4c_Dados.Classes,'')"
1136:                         .Column1.Header1.Caption = "Classe"
1137:                         .Column1.Width  = 80
1138:                         .Column1.Alignment = 0
1139: 
1140:                         *-- Column2: Nivel
1141:                         .Column2.ControlSource  = "cursor_4c_Dados.Nivels"
1142:                         .Column2.Header1.Caption = "N" + CHR(237) + "vel"
1143:                         .Column2.Width  = 33
1144:                         .Column2.Alignment = 1
1145: 
1146:                         *-- Column3: Operacao (+/-) com indicador visual
1147:                         .Column3.ControlSource  = "iif(cursor_4c_Dados.Operacaos='-','[-]','[+]')"
1148:                         .Column3.Header1.Caption = "Oper"
1149:                         .Column3.Width  = 40
1150:                         .Column3.Alignment = 1
1151: 
1152:                         *-- Column4: Grupo
1153:                         .Column4.ControlSource  = "cursor_4c_Dados.Grupos"
1154:                         .Column4.Header1.Caption = "Grupo"
1155:                         .Column4.Width  = 80
1156:                         .Column4.Alignment = 0
1157: 
1158:                         *-- Column5: Analitico/Sintetico
1159:                         .Column5.ControlSource  = "iif(cursor_4c_Dados.Analiticos=1,'A','S')"
1160:                         .Column5.Header1.Caption = "A/S"
1161:                         .Column5.Width  = 30
1162:                         .Column5.Alignment = 1
1163: 
1164:                         *-- Column6: Descricao SubTotal
1165:                         .Column6.ControlSource  = "cursor_4c_Dados.DescGrps"
1166:                         .Column6.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1167:                         .Column6.Width  = 220
1168:                         .Column6.Alignment = 0
1169: 
1170:                         *-- Column7: Fator %
1171:                         .Column7.ControlSource  = "cursor_4c_Dados.Fators"
1172:                         .Column7.Header1.Caption = "Fator"
1173:                         .Column7.Width  = 40
1174:                         .Column7.Alignment = 1
1175: 
1176:                         *-- Column8: Titulo de coluna
1177:                         .Column8.ControlSource  = "cursor_4c_Dados.Titulos"
1178:                         .Column8.Header1.Caption = "T" + CHR(237) + "tulo"
1179:                         .Column8.Width  = 80
1180:                         .Column8.Alignment = 0
1181: 
1182:                         *-- Column9: Ordem
1183:                         .Column9.ControlSource  = "cursor_4c_Dados.Ordems"
1184:                         .Column9.Header1.Caption = "Ordem"
1185:                         .Column9.Width  = 50
1186:                         .Column9.Alignment = 1
1187:                     ENDWITH
1188: 
1189:                     THIS.FormatarGridLista(loc_oGrid)

*-- Linhas 1258 a 1267:
1258:         loc_oPg2.obj_4c_OptTpDatas.Buttons(4).Enabled       = par_lHabilitar
1259: 
1260:         *-- Confirmar/Cancelar: visiveis somente em modo edicao
1261:         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
1262:         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1263: 
1264:         *-- Refinar habilitacao por tipo (Tpregs) quando habilitando
1265:         IF par_lHabilitar
1266:             THIS.OptTpregsChanged()
1267:         ENDIF

*-- Linhas 1405 a 1439:
1405:         *-- Tpregs=2 (SubTotal): Descgrps habilitado
1406:         *-- Tpregs=3 (Classe): Classe/Dclasse habilitados
1407:         loc_oPg2.txt_4c_Descgrps.Enabled    = (loc_nTpregs = 2) AND loc_lEditar
1408:         loc_oPg2.lbl_4c_Label1.Enabled      = (loc_nTpregs = 2)
1409:         loc_oPg2.txt_4c__cd_grupos.Enabled  = (loc_nTpregs = 1) AND loc_lEditar
1410:         loc_oPg2.lbl_4c_Lbl_grupos.Enabled  = (loc_nTpregs = 1)
1411:         loc_oPg2.txt_4c_Classe.Enabled      = (loc_nTpregs = 3) AND loc_lEditar
1412:         loc_oPg2.lbl_4c_Label4.Enabled      = (loc_nTpregs = 3)
1413: 
1414:         *-- cmb_operacaos: somente Tpregs=1 ou 3
1415:         loc_oPg2.cbo_4c_Cmb_operacaos.Enabled = INLIST(loc_nTpregs, 1, 3) AND loc_lEditar
1416:         loc_oPg2.lbl_4c_Lbl_operacaos.Enabled = INLIST(loc_nTpregs, 1, 3)
1417: 
1418:         *-- opt_analiticos: somente Tpregs=1
1419:         loc_oPg2.obj_4c_Opt_analiticos.Buttons(1).Enabled = (loc_nTpregs = 1) AND loc_lEditar
1420:         loc_oPg2.obj_4c_Opt_analiticos.Buttons(2).Enabled = (loc_nTpregs = 1) AND loc_lEditar
1421:         loc_oPg2.lbl_4c_Lbl_analitico.Enabled             = (loc_nTpregs = 1)
1422: 
1423:         *-- Opt_CPartida: somente Tpregs=1 e Analiticos=1
1424:         loc_oPg2.obj_4c_Opt_CPartida.Buttons(1).Enabled = ;
1425:             (loc_nTpregs = 1) AND (loc_oPg2.obj_4c_Opt_analiticos.Value = 1) AND loc_lEditar
1426:         loc_oPg2.obj_4c_Opt_CPartida.Buttons(2).Enabled = ;
1427:             (loc_nTpregs = 1) AND (loc_oPg2.obj_4c_Opt_analiticos.Value = 1) AND loc_lEditar
1428:         loc_oPg2.lbl_4c_Label5.Enabled = (loc_nTpregs = 1)
1429: 
1430:         *-- opt_subtot100: somente Tpregs=2 e llaltsubtot
1431:         loc_oPg2.obj_4c_Opt_subtot100.Buttons(1).Enabled = ;
1432:             (loc_nTpregs = 2) AND loc_lEditar AND THIS.this_lAltSubtot
1433:         loc_oPg2.obj_4c_Opt_subtot100.Buttons(2).Enabled = (loc_nTpregs = 2) AND loc_lEditar
1434:         loc_oPg2.lbl_4c_Label7.Enabled = (loc_nTpregs = 2)
1435:     ENDPROC
1436: 
1437:     *==========================================================================
1438:     * VALIDACAO: GRUPO (LostFocus de txt_4c__cd_grupos)
1439:     * Busca em SigCdGcr, popula descricao ou abre picker


### BO (C:\4c\projeto\app\classes\CmrBO.prg):
*==============================================================================
* CmrBO.prg - Business Object para Itens de Mapa de Resultados (SigCdMri)
* Data: 2026-07-29
* Tabela: SIGCDMRI | PK: CidChaves (char 20)
* FK: Balancos -> SIGCDMRR.Balancos
*==============================================================================

DEFINE CLASS CmrBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento com campos da tabela SIGCDMRI)
    this_cCidChaves   = ""  && cidchaves   CHAR(20)     - Chave " + CHR(250) + "nica (PK)
    this_cBalancos    = ""  && balancos    CHAR(20)     - Balan" + CHR(231) + "o (FK -> SIGCDMRR)
    this_nAnaliticos  = 0   && analiticos  NUMERIC(1,0) - Anal" + CHR(237) + "tico (1=Sim, 2=N" + CHR(227) + "o)
    this_cClasses     = ""  && classes     CHAR(10)     - Classe contabil
    this_cDescGrps    = ""  && descgrps    CHAR(30)     - Descri" + CHR(231) + CHR(227) + "o do Subtotal
    this_nFators      = 0   && fators      NUMERIC(3,0) - Fator percentual (0-100)
    this_cGrupos      = ""  && grupos      CHAR(10)     - Grupo de conta corrente
    this_nNivels      = 0   && nivels      NUMERIC(1,0) - N" + CHR(237) + "vel hier" + CHR(225) + "rquico
    this_cOperacaos   = ""  && operacaos   CHAR(1)      - Opera" + CHR(231) + CHR(227) + "o ('+' Soma / '-' Subtrai)
    this_nTpregs      = 0   && tpregs      NUMERIC(1,0) - Tipo de registro (1=Grupo, 2=SubTotal, 3=Classe)
    this_cTitulos     = ""  && titulos     CHAR(10)     - T" + CHR(237) + "tulo do cabe" + CHR(231) + "alho de coluna
    this_nCpartidas   = 0   && cpartidas   NUMERIC(1,0) - Contra Partida (1=Sim, 2=N" + CHR(227) + "o)
    this_nOrdems      = 0   && ordems      NUMERIC(3,0) - Ordem de exibi" + CHR(231) + CHR(227) + "o
    this_nSubtot100s  = 0   && subtot100s  NUMERIC(1,0) - SubTotal 100% (1=Sim, 2=N" + CHR(227) + "o)
    this_nTpDatas     = 0   && tpdatas     NUMERIC(1,0) - Tipo de data (1=Emiss" + CHR(227) + "o, 2=Lan" + CHR(231) + "amento, 3=Vencimento, 4=Baixa)

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdMri"
        THIS.this_cCampoChave = "CidChaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor -> propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves  = TratarNulo(CidChaves,  "C")
                THIS.this_cBalancos   = TratarNulo(Balancos,   "C")
                THIS.this_nTpregs     = TratarNulo(Tpregs,     "N")
                THIS.this_cGrupos     = TratarNulo(Grupos,     "C")
                THIS.this_cDescGrps   = TratarNulo(DescGrps,   "C")
                THIS.this_cClasses    = TratarNulo(Classes,    "C")
                THIS.this_nAnaliticos = TratarNulo(Analiticos, "N")
                THIS.this_cOperacaos  = TratarNulo(Operacaos,  "C")
                THIS.this_nCpartidas  = TratarNulo(Cpartidas,  "N")
                THIS.this_nSubtot100s = TratarNulo(Subtot100s, "N")
                THIS.this_nFators     = TratarNulo(Fators,     "N")
                THIS.this_cTitulos    = TratarNulo(Titulos,    "C")
                THIS.this_nOrdems     = TratarNulo(Ordems,     "N")
                THIS.this_nTpDatas    = TratarNulo(TpDatas,    "N")
                THIS.this_nNivels     = TratarNulo(Nivels,     "N")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao carregar cursor: " + loException.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista itens do mapa de resultados do Balanco corrente
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            loc_cSQL = "SELECT CidChaves, Balancos, Tpregs, Grupos, DescGrps," + ;
                       " Classes, Analiticos, Operacaos, Cpartidas, Subtot100s," + ;
                       " Fators, Titulos, Ordems, TpDatas, Nivels" + ;
                       " FROM SigCdMri" + ;
                       " WHERE Balancos = " + EscaparSQL(THIS.this_cBalancos) + ;
                       " ORDER BY Ordems, Grupos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") >= 0
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar itens do mapa:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro por CidChaves (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCidChaves)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
            loc_cSQL = "SELECT CidChaves, Balancos, Tpregs, Grupos, DescGrps," + ;
                       " Classes, Analiticos, Operacaos, Cpartidas, Subtot100s," + ;
                       " Fators, Titulos, Ordems, TpDatas, Nivels" + ;
                       " FROM SigCdMri" + ;
                       " WHERE CidChaves = " + EscaparSQL(par_cCidChaves)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                GO TOP IN cursor_4c_Carrega
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdMri (PROTECTED - chamado por Salvar())
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_cNovaChave
        loc_lResultado = .F.
        TRY
            *-- Gerar chave unica via SQL Server (NEWID sem hifens, 20 chars)
            IF USED("cursor_4c_NewID")
                USE IN cursor_4c_NewID
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT LEFT(REPLACE(CAST(NEWID() AS VARCHAR(36)),'-',''),20) AS NovaCidChave", ;
                "cursor_4c_NewID")
            IF loc_nResult >= 0 AND USED("cursor_4c_NewID") AND RECCOUNT("cursor_4c_NewID") > 0
                GO TOP IN cursor_4c_NewID
                loc_cNovaChave = ALLTRIM(cursor_4c_NewID.NovaCidChave)
            ELSE
                loc_cNovaChave = LEFT(SYS(2015) + SYS(2015), 20)
            ENDIF
            IF USED("cursor_4c_NewID")
                USE IN cursor_4c_NewID
            ENDIF
            THIS.this_cCidChaves = loc_cNovaChave

            loc_cSQL = "INSERT INTO SigCdMri" + ;
                " (CidChaves, Balancos, Tpregs, Grupos, DescGrps," + ;
                "  Classes, Analiticos, Operacaos, Cpartidas, Subtot100s," + ;
                "  Fators, Titulos, Ordems, TpDatas, Nivels)" + ;
                " VALUES (" + ;
                EscaparSQL(THIS.this_cCidChaves)  + ", " + ;
                EscaparSQL(THIS.this_cBalancos)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nTpregs) + ", " + ;
                EscaparSQL(THIS.this_cGrupos)     + ", " + ;
                EscaparSQL(THIS.this_cDescGrps)   + ", " + ;
                EscaparSQL(THIS.this_cClasses)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nAnaliticos)  + ", " + ;
                EscaparSQL(THIS.this_cOperacaos)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nCpartidas)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nSubtot100s)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nFators)      + ", " + ;
                EscaparSQL(THIS.this_cTitulos)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nOrdems)      + ", " + ;
                FormatarNumeroSQL(THIS.this_nTpDatas)     + ", " + ;
                FormatarNumeroSQL(THIS.this_nNivels)      + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir item:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCdMri (PROTECTED - chamado por Salvar())
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "UPDATE SigCdMri SET" + ;
                " Tpregs = "      + FormatarNumeroSQL(THIS.this_nTpregs)     + "," + ;
                " Grupos = "      + EscaparSQL(THIS.this_cGrupos)            + "," + ;
                " DescGrps = "    + EscaparSQL(THIS.this_cDescGrps)          + "," + ;
                " Classes = "     + EscaparSQL(THIS.this_cClasses)           + "," + ;
                " Analiticos = "  + FormatarNumeroSQL(THIS.this_nAnaliticos) + "," + ;
                " Operacaos = "   + EscaparSQL(THIS.this_cOperacaos)         + "," + ;
                " Cpartidas = "   + FormatarNumeroSQL(THIS.this_nCpartidas)  + "," + ;
                " Subtot100s = "  + FormatarNumeroSQL(THIS.this_nSubtot100s) + "," + ;
                " Fators = "      + FormatarNumeroSQL(THIS.this_nFators)     + "," + ;
                " Titulos = "     + EscaparSQL(THIS.this_cTitulos)           + "," + ;
                " Ordems = "      + FormatarNumeroSQL(THIS.this_nOrdems)     + "," + ;
                " TpDatas = "     + FormatarNumeroSQL(THIS.this_nTpDatas)    + "," + ;
                " Nivels = "      + FormatarNumeroSQL(THIS.this_nNivels)     + ;
                " WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar item:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de SigCdMri (PROTECTED - chamado por Excluir())
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM SigCdMri" + ;
                " WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir item:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

