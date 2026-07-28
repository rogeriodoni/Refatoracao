# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 219: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 240: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 262: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 284: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 306: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 340: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 440: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 462: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCAD.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1061 linhas total):

*-- Linhas 5 a 13:
5: * Formulario PARAMETRIZADO: recebe par_cTipoCads no Init para filtrar
6: * registros de SigCdCad por categoria (TipoCads).
7: *
8: * Fase 5/8 - Campos Page2: cnt_4c_Cabecalho, lbl_4c_LblCodCads, txt_4c_CodCads.
9: *==============================================================================
10: 
11: DEFINE CLASS FormCAD AS FormBase
12: 
13:     *-- Propriedades visuais (PILAR 1 - UX fidelidade)

*-- Linhas 49 a 59:
49:             ENDIF
50: 
51:             *-- Caption dinamico baseado no tipo
52:             THIS.Caption = PROPER(THIS.this_cTipoCads)
53:             IF PADR(UPPER(THIS.this_cTipoCads), 20) = PADR("APONTAMTO", 20)
54:                 THIS.Caption = "Avalia" + CHR(231) + CHR(227) + "o"
55:             ENDIF
56: 
57:             loc_lSucesso = DODEFAULT()
58: 
59:         CATCH TO loException

*-- Linhas 116 a 135:
116: 
117:             WITH THIS.pgf_4c_Paginas
118:                 .PageCount = 2
119:                 .Top       = -29
120:                 .Left      = 0
121:                 .Width     = THIS.Width
122:                 .Height    = THIS.Height + 29
123:                 .Tabs      = .F.
124:                 .Visible   = .T.
125: 
126:                 .Page1.Caption   = "Lista"
127:                 .Page1.BackColor = RGB(100, 100, 100)
128:                 .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
129: 
130:                 .Page2.Caption   = "Dados"
131:                 .Page2.BackColor = RGB(100, 100, 100)
132:                 .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
133:             ENDWITH
134: 
135:         CATCH TO loException

*-- Linhas 154 a 189:
154:             *-- Container cabecalho (cntSombra no legado: Top=1 -> comp +29 -> 30; usando 31)
155:             loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
156:             WITH loc_oPagina.cnt_4c_Cabecalho
157:                 .Top         = 31
158:                 .Left        = 0
159:                 .Width       = THIS.Width
160:                 .Height      = 80
161:                 .BackColor   = RGB(100, 100, 100)
162:                 .BorderWidth = 0
163:                 .Visible     = .T.
164: 
165:                 .AddObject("lbl_4c_Sombra", "Label")
166:                 WITH .lbl_4c_Sombra
167:                     .Caption   = THIS.Caption
168:                     .Top       = 15
169:                     .Left      = 10
170:                     .Width     = THIS.Width
171:                     .Height    = 40
172:                     .FontName  = "Tahoma"
173:                     .FontSize  = 16
174:                     .FontBold  = .T.
175:                     .ForeColor = RGB(0, 0, 0)
176:                     .BackStyle = 0
177:                     .AutoSize  = .F.
178:                 ENDWITH
179: 
180:                 .AddObject("lbl_4c_Titulo", "Label")
181:                 WITH .lbl_4c_Titulo
182:                     .Caption   = THIS.Caption
183:                     .Top       = 18
184:                     .Left      = 10
185:                     .Width     = THIS.Width
186:                     .Height    = 46
187:                     .FontName  = "Tahoma"
188:                     .FontSize  = 16
189:                     .FontBold  = .T.

*-- Linhas 196 a 312:
196:             *-- Container botoes CRUD - LADO DIREITO (Grupo_op: Top=-1+29=28 -> 29 canonico)
197:             loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
198:             WITH loc_oPagina.cnt_4c_Botoes
199:                 .Top         = 29
200:                 .Left        = 542
201:                 .Width       = 390
202:                 .Height      = 85
203:                 .BackColor   = RGB(53, 53, 53)
204:                 .BackStyle   = 1
205:                 .BorderWidth = 0
206:                 .Visible     = .T.
207: 
208:                 .AddObject("cmd_4c_Incluir", "CommandButton")
209:                 WITH .cmd_4c_Incluir
210:                     .Caption         = "Incluir"
211:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
212:                     .PicturePosition = 13
213:                     .Top             = 5
214:                     .Left            =  542
215:                     .Width           = 75
216:                     .Height          = 75
217:                     .BackColor       = RGB(255, 255, 255)
218:                     .ForeColor       = RGB(90, 90, 90)
219:                     .FontName        = "Comic Sans MS"
220:                     .FontSize        = 8
221:                     .FontBold        = .T.
222:                     .FontItalic      = .T.
223:                     .SpecialEffect   = 0
224:                     .MousePointer    = 15
225:                     .WordWrap        = .T.
226:                     .AutoSize        = .F.
227:                 ENDWITH
228: 
229:                 .AddObject("cmd_4c_Visualizar", "CommandButton")
230:                 WITH .cmd_4c_Visualizar
231:                     .Caption         = "Visualizar"
232:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
233:                     .PicturePosition = 13
234:                     .Top             = 5
235:                     .Left            =  542
236:                     .Width           = 75
237:                     .Height          = 75
238:                     .BackColor       = RGB(255, 255, 255)
239:                     .ForeColor       = RGB(90, 90, 90)
240:                     .FontName        = "Comic Sans MS"
241:                     .FontSize        = 8
242:                     .FontBold        = .T.
243:                     .FontItalic      = .T.
244:                     .Themes          = .F.
245:                     .SpecialEffect   = 0
246:                     .MousePointer    = 15
247:                     .WordWrap        = .T.
248:                     .AutoSize        = .F.
249:                 ENDWITH
250: 
251:                 .AddObject("cmd_4c_Alterar", "CommandButton")
252:                 WITH .cmd_4c_Alterar
253:                     .Caption         = "Alterar"
254:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
255:                     .PicturePosition = 13
256:                     .Top             = 5
257:                     .Left            =  542
258:                     .Width           = 75
259:                     .Height          = 75
260:                     .BackColor       = RGB(255, 255, 255)
261:                     .ForeColor       = RGB(90, 90, 90)
262:                     .FontName        = "Comic Sans MS"
263:                     .FontSize        = 8
264:                     .FontBold        = .T.
265:                     .FontItalic      = .T.
266:                     .Themes          = .F.
267:                     .SpecialEffect   = 0
268:                     .MousePointer    = 15
269:                     .WordWrap        = .T.
270:                     .AutoSize        = .F.
271:                 ENDWITH
272: 
273:                 .AddObject("cmd_4c_Excluir", "CommandButton")
274:                 WITH .cmd_4c_Excluir
275:                     .Caption         = "Excluir"
276:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
277:                     .PicturePosition = 13
278:                     .Top             = 5
279:                     .Left            =  542
280:                     .Width           = 75
281:                     .Height          = 75
282:                     .BackColor       = RGB(255, 255, 255)
283:                     .ForeColor       = RGB(90, 90, 90)
284:                     .FontName        = "Comic Sans MS"
285:                     .FontSize        = 8
286:                     .FontBold        = .T.
287:                     .FontItalic      = .T.
288:                     .Themes          = .F.
289:                     .SpecialEffect   = 0
290:                     .MousePointer    = 15
291:                     .WordWrap        = .T.
292:                     .AutoSize        = .F.
293:                 ENDWITH
294: 
295:                 .AddObject("cmd_4c_Buscar", "CommandButton")
296:                 WITH .cmd_4c_Buscar
297:                     .Caption         = "Buscar"
298:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
299:                     .PicturePosition = 13
300:                     .Top             = 5
301:                     .Left            =  542
302:                     .Width           = 75
303:                     .Height          = 75
304:                     .BackColor       = RGB(255, 255, 255)
305:                     .ForeColor       = RGB(90, 90, 90)
306:                     .FontName        = "Comic Sans MS"
307:                     .FontSize        = 8
308:                     .FontBold        = .T.
309:                     .FontItalic      = .T.
310:                     .Themes          = .F.
311:                     .SpecialEffect   = 0
312:                     .MousePointer    = 15

*-- Linhas 318 a 346:
318:             *-- Container saida - CANONICO (Left=917, Width=90, cmd Width=75)
319:             loc_oPagina.AddObject("cnt_4c_Saida", "Container")
320:             WITH loc_oPagina.cnt_4c_Saida
321:                 .Top         = 29
322:                 .Left        = 917
323:                 .Width       = 90
324:                 .Height      = 85
325:                 .BackStyle   = 0
326:                 .BorderWidth = 0
327:                 .Visible     = .T.
328: 
329:                 .AddObject("cmd_4c_Encerrar", "CommandButton")
330:                 WITH .cmd_4c_Encerrar
331:                     .Caption         = "Encerrar"
332:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
333:                     .PicturePosition = 13
334:                     .Top             = 5
335:                     .Left            = 917
336:                     .Width           = 75
337:                     .Height          = 75
338:                     .BackColor       = RGB(255, 255, 255)
339:                     .ForeColor       = RGB(90, 90, 90)
340:                     .FontName        = "Comic Sans MS"
341:                     .FontSize        = 8
342:                     .FontBold        = .T.
343:                     .FontItalic      = .T.
344:                     .SpecialEffect   = 0
345:                     .MousePointer    = 15
346:                     .WordWrap        = .T.

*-- Linhas 357 a 366:
357:             loc_oGrid.ColumnCount  = 2
358: 
359:             WITH loc_oGrid
360:                 .Top                = 117
361:                 .Left               = 26
362:                 .Width              = 890
363:                 .Height             = 453
364:                 .FontName           = "Verdana"
365:                 .FontSize           = 8
366:                 .ForeColor          = RGB(90, 90, 90)

*-- Linhas 378 a 412:
378: 
379:                 .Column1.ControlSource    = "cursor_4c_Dados.codcads"
380:                 .Column1.Width            = 150
381:                 .Column1.Header1.Caption  = "C" + CHR(243) + "digo"
382: 
383:                 .Column2.ControlSource    = "cursor_4c_Dados.descads"
384:                 .Column2.Width            = 738
385:                 .Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
386:             ENDWITH
387: 
388:             *-- BINDEVENTs para botoes CRUD (metodos PUBLIC - sem PROTECTED)
389:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
390:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
391:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
392:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
393:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
394:             BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
395:             BINDEVENT(loc_oGrid, "DblClick", THIS, "BtnVisualizarClick")
396: 
397:             THIS.TornarControlesVisiveis(loc_oPagina)
398: 
399:         CATCH TO loException
400:             MsgErro("Erro ao configurar Page1:" + CHR(13) + loException.Message, "Erro")
401:         ENDTRY
402:     ENDPROC
403: 
404:     *==========================================================================
405:     * ConfigurarPaginaDados - Page2: botoes Salvar/Cancelar + campos CodCads
406:     * Fase 5: cnt_4c_Cabecalho, lbl_4c_LblCodCads, txt_4c_CodCads.
407:     * Fase 6: lbl_4c_Descricao, txt_4c_DesCads.
408:     *==========================================================================
409:     PROTECTED PROCEDURE ConfigurarPaginaDados()
410:         LOCAL loc_oPagina
411:         loc_oPagina = .NULL.
412: 

*-- Linhas 419 a 468:
419:             *-- Container botoes Salvar/Cancelar (Grupo_Salva: Top=9+29=38 -> canonico Left=842)
420:             loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
421:             WITH loc_oPagina.cnt_4c_BotoesAcao
422:                 .Top         = 33
423:                 .Left        = 842
424:                 .Width       = 160
425:                 .Height      = 85
426:                 .BackStyle   = 0
427:                 .Visible     = .T.
428: 
429:                 .AddObject("cmd_4c_Confirmar", "CommandButton")
430:                 WITH .cmd_4c_Confirmar
431:                     .Caption         = "Confirmar"
432:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
433:                     .PicturePosition = 13
434:                     .Top             = 5
435:                     .Left            = 5
436:                     .Width           = 75
437:                     .Height          = 75
438:                     .BackColor       = RGB(255, 255, 255)
439:                     .ForeColor       = RGB(90, 90, 90)
440:                     .FontName        = "Comic Sans MS"
441:                     .FontSize        = 8
442:                     .FontBold        = .T.
443:                     .FontItalic      = .T.
444:                     .SpecialEffect   = 0
445:                     .MousePointer    = 15
446:                     .WordWrap        = .T.
447:                     .AutoSize        = .F.
448:                     .Enabled         = .F.
449:                 ENDWITH
450: 
451:                 .AddObject("cmd_4c_Cancelar", "CommandButton")
452:                 WITH .cmd_4c_Cancelar
453:                     .Caption         = "Encerrar"
454:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
455:                     .PicturePosition = 13
456:                     .Top             = 5
457:                     .Left            = 80
458:                     .Width           = 75
459:                     .Height          = 75
460:                     .BackColor       = RGB(255, 255, 255)
461:                     .ForeColor       = RGB(90, 90, 90)
462:                     .FontName        = "Comic Sans MS"
463:                     .FontSize        = 8
464:                     .FontBold        = .T.
465:                     .FontItalic      = .T.
466:                     .Themes          = .F.
467:                     .SpecialEffect   = 0
468:                     .MousePointer    = 15

*-- Linhas 474 a 527:
474:             *-- Container cabecalho na Page2 (espelha Page1 para consistencia visual)
475:             loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
476:             WITH loc_oPagina.cnt_4c_Cabecalho
477:                 .Top         = 31
478:                 .Left        = 0
479:                 .Width       = THIS.Width
480:                 .Height      = 80
481:                 .BackColor   = RGB(100, 100, 100)
482:                 .BorderWidth = 0
483:                 .Visible     = .T.
484: 
485:                 .AddObject("lbl_4c_Sombra", "Label")
486:                 WITH .lbl_4c_Sombra
487:                     .Caption   = THIS.Caption
488:                     .Top       = 15
489:                     .Left      = 10
490:                     .Width     = THIS.Width
491:                     .Height    = 40
492:                     .FontName  = "Tahoma"
493:                     .FontSize  = 16
494:                     .FontBold  = .T.
495:                     .ForeColor = RGB(0, 0, 0)
496:                     .BackStyle = 0
497:                     .AutoSize  = .F.
498:                 ENDWITH
499: 
500:                 .AddObject("lbl_4c_Titulo", "Label")
501:                 WITH .lbl_4c_Titulo
502:                     .Caption   = THIS.Caption
503:                     .Top       = 18
504:                     .Left      = 10
505:                     .Width     = THIS.Width
506:                     .Height    = 46
507:                     .FontName  = "Tahoma"
508:                     .FontSize  = 16
509:                     .FontBold  = .T.
510:                     .ForeColor = RGB(255, 255, 255)
511:                     .BackStyle = 0
512:                     .AutoSize  = .F.
513:                 ENDWITH
514:             ENDWITH
515: 
516:             *-- lbl_4c_LblCodCads: exibe dinamicamente "TipoCads :" como label
517:             *-- Original: lblCodCads (TextBox-como-label), Top=154, Left=78, Width=268 -> +29 -> Top=183
518:             loc_oPagina.AddObject("lbl_4c_LblCodCads", "Label")
519:             WITH loc_oPagina.lbl_4c_LblCodCads
520:                 .Caption   = THIS.Caption + " :"
521:                 .Top       = 183
522:                 .Left      = 78
523:                 .Width     = 268
524:                 .Height    = 23
525:                 .FontName  = "Tahoma"
526:                 .FontSize  = 8
527:                 .FontBold  = .F.

*-- Linhas 538 a 565:
538:             loc_oPagina.AddObject("txt_4c_CodCads", "TextBox")
539:             WITH loc_oPagina.txt_4c_CodCads
540:                 .Value         = ""
541:                 .Top           = 182
542:                 .Left          = 349
543:                 .Width         = (THIS.this_nMaxCodCads * 7) + 10
544:                 .Height        = 24
545:                 .FontName      = "Tahoma"
546:                 .FontSize      = 8
547:                 .Format        = "K!"
548:                 .MaxLength     = THIS.this_nMaxCodCads
549:                 .SpecialEffect = 1
550:                 .Enabled       = .T.
551:                 .Visible       = .T.
552:             ENDWITH
553: 
554:             *-- lbl_4c_Descricao: label "Descricao :" para o campo descricao
555:             *-- Original: Say1, Top=185, Left=291 -> Top+29=214, Left=291
556:             loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
557:             WITH loc_oPagina.lbl_4c_Descricao
558:                 .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
559:                 .Top       = 214
560:                 .Left      = 291
561:                 .Width     = 55
562:                 .Height    = 17
563:                 .FontName  = "Tahoma"
564:                 .FontSize  = 8
565:                 .FontBold  = .F.

*-- Linhas 575 a 597:
575:             loc_oPagina.AddObject("txt_4c_DesCads", "TextBox")
576:             WITH loc_oPagina.txt_4c_DesCads
577:                 .Value         = ""
578:                 .Top           = 209
579:                 .Left          = 349
580:                 .Width         = 290
581:                 .Height        = 24
582:                 .FontName      = "Tahoma"
583:                 .FontSize      = 8
584:                 .MaxLength     = 40
585:                 .SpecialEffect = 1
586:                 .Enabled       = .T.
587:                 .Visible       = .T.
588:             ENDWITH
589: 
590:             *-- BINDEVENTs para botoes da Page2
591:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
592:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
593: 
594:             THIS.TornarControlesVisiveis(loc_oPagina)
595: 
596:         CATCH TO loException
597:             MsgErro("Erro ao configurar Page2:" + CHR(13) + loException.Message, "Erro")

*-- Linhas 621 a 633:
621: 
622:                 loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.codcads"
623:                 loc_oGrid.Column1.Width           = 150
624:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
625: 
626:                 loc_oGrid.Column2.ControlSource   = "cursor_4c_Dados.descads"
627:                 loc_oGrid.Column2.Width           = 738
628:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
629: 
630:                 THIS.FormatarGridLista(loc_oGrid)
631:                 loc_lResultado = .T.
632:             ENDIF
633:         CATCH TO loException

*-- Linhas 680 a 700:
680:             *-- Botoes da Page1: desabilitar durante edicao
681:             IF VARTYPE(loc_oPg1) = "O"
682:                 IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
683:                     loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = !loc_lEdicao
684:                     loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = !loc_lEdicao
685:                     loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = !loc_lEdicao
686:                     loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = !loc_lEdicao
687:                     loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = !loc_lEdicao
688:                 ENDIF
689:             ENDIF
690: 
691:             *-- Botoes da Page2: Confirmar habilitado so em edicao
692:             IF VARTYPE(loc_oPg2) = "O"
693:                 IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
694:                     loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEdicao
695:                     loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
696:                 ENDIF
697:             ENDIF
698: 
699:         CATCH TO loException
700:             MsgErro("Erro ao ajustar bot" + CHR(245) + "es:" + CHR(13) + loException.Message, "Erro")

*-- Linhas 837 a 849:
837: 
838:                     loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.codcads"
839:                     loc_oGrid.Column1.Width           = 150
840:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
841: 
842:                     loc_oGrid.Column2.ControlSource   = "cursor_4c_Dados.descads"
843:                     loc_oGrid.Column2.Width           = 738
844:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
845: 
846:                     THIS.FormatarGridLista(loc_oGrid)
847:                 ENDIF
848:             ENDIF
849:         CATCH TO loException


### BO (C:\4c\projeto\app\classes\CADBO.prg):
*====================================================================
* CADBO.prg
*
* Business Object para Cadastros Gerais (SigCdCad)
* Herda de: BusinessBase
*
* PARAMETRIZADO: this_cTipoCads define a categoria de cadastro.
* Todas as queries filtram por TipoCads.
* Aberto pelo menu com par_cTipoCads e par_nMaxCodCads.
*====================================================================

DEFINE CLASS CADBO AS BusinessBase

    *-- Filtro de categoria (obrigatorio - definido pelo formulario chamador)
    this_cTipoCads   = ""   && tipocads char(20) - tipo/categoria do cadastro

    *-- Propriedades da entidade (SigCdCad)
    this_cPkChaves   = ""   && pkchaves char(20) - chave primaria (LEFT(NEWID(),20))
    this_cCodCads    = ""   && codcads char(20) - codigo do item
    this_cDesCads    = ""   && descads char(40) - descricao do item
    this_cTxtCads    = ""   && txtcads char(50) - texto adicional
    this_cUsuars     = ""   && usuars char(10) - usuario que incluiu
    this_dDtIncs     = {}   && dtincs datetime - data/hora de inclusao
    this_cUsuAlts    = ""   && usualts char(10) - usuario que alterou
    this_dDtAlts     = {}   && dtalts datetime - data/hora de alteracao

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdCad"
        THIS.this_cCampoChave = "pkchaves"
        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDPROC

    *====================================================================
    * LimparDados - Limpa propriedades (chamado por NovoRegistro)
    *====================================================================
    PROTECTED PROCEDURE LimparDados()
        THIS.this_cPkChaves = ""
        THIS.this_cCodCads  = ""
        THIS.this_cDesCads  = ""
        THIS.this_cTxtCads  = ""
        THIS.this_cUsuars   = ""
        THIS.this_dDtIncs   = {}
        THIS.this_cUsuAlts  = ""
        THIS.this_dDtAlts   = {}
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega dados do cursor para propriedades
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)
            THIS.this_cPkChaves = TratarNulo(pkchaves, "C")
            THIS.this_cCodCads  = TratarNulo(codcads,  "C")
            THIS.this_cDesCads  = TratarNulo(descads,  "C")
            THIS.this_cTxtCads  = TratarNulo(txtcads,  "C")
            THIS.this_cTipoCads = TratarNulo(tipocads, "C")
            THIS.this_cUsuars   = TratarNulo(usuars,   "C")
            THIS.this_cUsuAlts  = TratarNulo(usualts,  "C")
            IF !ISNULL(dtincs)
                THIS.this_dDtIncs = dtincs
            ENDIF
            IF !ISNULL(dtalts)
                THIS.this_dDtAlts = dtalts
            ENDIF
            THIS.this_lNovoRegistro = .F.
            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro ao carregar cursor: " + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * Buscar - Carrega lista de cadastros filtrada por TipoCads
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cTipoCads)
            MsgErro("Tipo de cadastro n" + CHR(227) + "o definido.", "Erro")
            RETURN .F.
        ENDIF

        TRY
            IF EMPTY(par_cFiltro)
                loc_cSQL = "SELECT pkchaves, codcads, descads, tipocads, usuars, dtincs, usualts, dtalts" + ;
                           " FROM SigCdCad" + ;
                           " WHERE tipocads = " + EscaparSQL(PADR(THIS.this_cTipoCads, 20)) + ;
                           " ORDER BY codcads"
            ELSE
                loc_cSQL = "SELECT pkchaves, codcads, descads, tipocads, usuars, dtincs, usualts, dtalts" + ;
                           " FROM SigCdCad" + ;
                           " WHERE tipocads = " + EscaparSQL(PADR(THIS.this_cTipoCads, 20)) + ;
                           "   AND codcads LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                           " ORDER BY codcads"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar cadastros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao buscar cadastros:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro por CodCads (chave de negocio)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodCads)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT pkchaves, codcads, descads, tipocads, txtcads," + ;
                       " usuars, dtincs, usualts, dtalts" + ;
                       " FROM SigCdCad" + ;
                       " WHERE tipocads = " + EscaparSQL(PADR(THIS.this_cTipoCads, 20)) + ;
                       "   AND codcads   = " + EscaparSQL(PADR(ALLTRIM(par_cCodCads), 20))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao carregar cadastro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * VerificarDuplicidade - Verifica se CodCads ja existe neste TipoCads
    *====================================================================
    PROCEDURE VerificarDuplicidade(par_cCodCads)
        LOCAL loc_cSQL, loc_nResultado, loc_lDuplicado
        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdCad" + ;
                       " WHERE tipocads = " + EscaparSQL(PADR(THIS.this_cTipoCads, 20)) + ;
                       "   AND codcads   = " + EscaparSQL(PADR(ALLTRIM(par_cCodCads), 20))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dup")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Dup") > 0
                SELECT cursor_4c_Dup
                loc_lDuplicado = (cursor_4c_Dup.qtd > 0)
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao verificar duplicidade:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Dup")
            USE IN cursor_4c_Dup
        ENDIF

        RETURN loc_lDuplicado
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro (PROTECTED - chamado por Salvar)
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cPkNovo
        loc_lSucesso = .F.
        loc_cPkNovo  = ""

        TRY
            *-- Gerar PK via SQL Server (NEWID nao existe em VFP)
            SQLEXEC(gnConnHandle, "SELECT LEFT(NEWID(),20) AS pk_novo", "cursor_4c_PkNovo")
            IF USED("cursor_4c_PkNovo") AND RECCOUNT("cursor_4c_PkNovo") > 0
                SELECT cursor_4c_PkNovo
                loc_cPkNovo = ALLTRIM(cursor_4c_PkNovo.pk_novo)
            ENDIF
            IF USED("cursor_4c_PkNovo")
                USE IN cursor_4c_PkNovo
            ENDIF

            IF !EMPTY(loc_cPkNovo)
                THIS.this_cPkChaves = loc_cPkNovo

                loc_cSQL = "INSERT INTO SigCdCad" + ;
                           " (pkchaves, tipocads, codcads, descads, txtcads, usuars, dtincs, usualts, dtalts)" + ;
                           " VALUES (" + ;
                           EscaparSQL(PADR(THIS.this_cPkChaves, 20)) + ", " + ;
                           EscaparSQL(PADR(THIS.this_cTipoCads, 20)) + ", " + ;
                           EscaparSQL(PADR(THIS.this_cCodCads,  20)) + ", " + ;
                           EscaparSQL(PADR(THIS.this_cDesCads,  40)) + ", " + ;
                           EscaparSQL(PADR(THIS.this_cTxtCads,  50)) + ", " + ;
                           EscaparSQL(PADR(gc_4c_UsuarioLogado, 10)) + ", " + ;
                           "GETDATE(), " + ;
                           EscaparSQL(SPACE(10)) + ", " + ;
                           "NULL" + ;
                           ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir cadastro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Falha ao gerar chave prim" + CHR(225) + "ria.", "Erro")
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao inserir cadastro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente (PROTECTED - chamado por Salvar)
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdCad SET" + ;
                       " descads  = " + EscaparSQL(PADR(THIS.this_cDesCads, 40)) + "," + ;
                       " txtcads  = " + EscaparSQL(PADR(THIS.this_cTxtCads, 50)) + "," + ;
                       " usualts  = " + EscaparSQL(PADR(gc_4c_UsuarioLogado, 10)) + "," + ;
                       " dtalts   = GETDATE()" + ;
                       " WHERE tipocads = " + EscaparSQL(PADR(THIS.this_cTipoCads, 20)) + ;
                       "   AND codcads  = " + EscaparSQL(PADR(THIS.this_cCodCads,  20))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar cadastro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao atualizar cadastro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro (PROTECTED - chamado por Excluir)
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdCad" + ;
                       " WHERE tipocads = " + EscaparSQL(PADR(THIS.this_cTipoCads, 20)) + ;
                       "   AND codcads  = " + EscaparSQL(PADR(THIS.this_cCodCads,  20))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir cadastro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao excluir cadastro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * InicializarValoresPadrao - Hook chamado por NovoRegistro
    *====================================================================
    PROTECTED PROCEDURE InicializarValoresPadrao()
        THIS.this_cPkChaves = ""
        THIS.this_cCodCads  = ""
        THIS.this_cDesCads  = ""
        THIS.this_cTxtCads  = ""
        THIS.this_cUsuars   = ""
        THIS.this_dDtIncs   = {}
        THIS.this_cUsuAlts  = ""
        THIS.this_dDtAlts   = {}
    ENDPROC

ENDDEFINE

