# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 189: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 210: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 232: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 254: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 276: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 310: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 458: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 479: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formcrf.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1784 linhas total):

*-- Linhas 96 a 112:
96: 
97:         WITH THIS.pgf_4c_Paginas
98:             .PageCount  = 2
99:             .Top        = -29
100:             .Left       = 0
101:             .Width      = 1003
102:             .Height     = 635
103:             .Tabs       = .F.
104:             .Visible    = .T.
105:             .Page1.Caption = "Lista"
106:             .Page1.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
107:             .Page2.Caption = "Dados"
108:             .Page2.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
109:         ENDWITH
110:     ENDPROC
111: 
112:     *==========================================================================

*-- Linhas 123 a 282:
123:         *-- Container cabecalho cinza (cntSombra: Top=1, +29 = 30)
124:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
125:         WITH loc_oPagina.cnt_4c_Cabecalho
126:             .Top           = 30
127:             .Left          = -1
128:             .Width         = 1004
129:             .Height        = 80
130:             .BackColor     = RGB(100, 100, 100)
131:             .BackStyle     = 1
132:             .BorderWidth   = 0
133:             .SpecialEffect = 0
134:             .Visible       = .T.
135: 
136:             .AddObject("lbl_4c_Sombra", "Label")
137:             WITH .lbl_4c_Sombra
138:                 .Top       = 15
139:                 .Left      = 10
140:                 .Width     = THIS.Width
141:                 .Height    = 40
142:                 .AutoSize  = .F.
143:                 .FontName  = "Tahoma"
144:                 .FontSize  = 16
145:                 .FontBold  = .T.
146:                 .ForeColor = RGB(0, 0, 0)
147:                 .BackStyle = 0
148:                 .Caption   = "Contagem de Refer" + CHR(234) + "ncia"
149:             ENDWITH
150: 
151:             .AddObject("lbl_4c_Titulo", "Label")
152:             WITH .lbl_4c_Titulo
153:                 .Top       = 18
154:                 .Left      = 10
155:                 .Width     = THIS.Width
156:                 .Height    = 46
157:                 .AutoSize  = .F.
158:                 .FontName  = "Tahoma"
159:                 .FontSize  = 16
160:                 .FontBold  = .T.
161:                 .ForeColor = RGB(255, 255, 255)
162:                 .BackStyle = 0
163:                 .Caption   = "Contagem de Refer" + CHR(234) + "ncia"
164:             ENDWITH
165:         ENDWITH
166: 
167:         *-- Container botoes CRUD (Grupo_op: Left=543, Top=-1, +29 = 29)
168:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
169:         WITH loc_oPagina.cnt_4c_Botoes
170:             .Top           = 29
171:             .Left          =  542
172:             .Width         = 390
173:             .Height        = 85
174:             .BackColor     = RGB(53, 53, 53)
175:             .BackStyle     = 1
176:             .BorderWidth   = 0
177:             .SpecialEffect = 0
178:             .Visible       = .T.
179: 
180:             .AddObject("cmd_4c_Incluir", "CommandButton")
181:             WITH .cmd_4c_Incluir
182:                 .Caption         = "Incluir"
183:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
184:                 .PicturePosition = 13
185:                 .Top             = 5
186:                 .Left            =  542
187:                 .Width           = 75
188:                 .Height          = 75
189:                 .FontName        = "Comic Sans MS"
190:                 .FontSize        = 8
191:                 .FontBold        = .T.
192:                 .FontItalic      = .T.
193:                 .ForeColor       = RGB(90, 90, 90)
194:                 .BackColor       = RGB(255, 255, 255)
195:                 .SpecialEffect   = 0
196:                 .MousePointer    = 15
197:                 .WordWrap        = .T.
198:                 .AutoSize        = .F.
199:             ENDWITH
200: 
201:             .AddObject("cmd_4c_Visualizar", "CommandButton")
202:             WITH .cmd_4c_Visualizar
203:                 .Caption         = "Visualizar"
204:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
205:                 .PicturePosition = 13
206:                 .Top             = 5
207:                 .Left            =  542
208:                 .Width           = 75
209:                 .Height          = 75
210:                 .FontName        = "Comic Sans MS"
211:                 .FontSize        = 8
212:                 .FontBold        = .T.
213:                 .FontItalic      = .T.
214:                 .ForeColor       = RGB(90, 90, 90)
215:                 .BackColor       = RGB(255, 255, 255)
216:                 .Themes          = .F.
217:                 .SpecialEffect   = 0
218:                 .MousePointer    = 15
219:                 .WordWrap        = .T.
220:                 .AutoSize        = .F.
221:             ENDWITH
222: 
223:             .AddObject("cmd_4c_Alterar", "CommandButton")
224:             WITH .cmd_4c_Alterar
225:                 .Caption         = "Alterar"
226:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
227:                 .PicturePosition = 13
228:                 .Top             = 5
229:                 .Left            =  542
230:                 .Width           = 75
231:                 .Height          = 75
232:                 .FontName        = "Comic Sans MS"
233:                 .FontSize        = 8
234:                 .FontBold        = .T.
235:                 .FontItalic      = .T.
236:                 .ForeColor       = RGB(90, 90, 90)
237:                 .BackColor       = RGB(255, 255, 255)
238:                 .Themes          = .F.
239:                 .SpecialEffect   = 0
240:                 .MousePointer    = 15
241:                 .WordWrap        = .T.
242:                 .AutoSize        = .F.
243:             ENDWITH
244: 
245:             .AddObject("cmd_4c_Excluir", "CommandButton")
246:             WITH .cmd_4c_Excluir
247:                 .Caption         = "Excluir"
248:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
249:                 .PicturePosition = 13
250:                 .Top             = 5
251:                 .Left            =  542
252:                 .Width           = 75
253:                 .Height          = 75
254:                 .FontName        = "Comic Sans MS"
255:                 .FontSize        = 8
256:                 .FontBold        = .T.
257:                 .FontItalic      = .T.
258:                 .ForeColor       = RGB(90, 90, 90)
259:                 .BackColor       = RGB(255, 255, 255)
260:                 .Themes          = .F.
261:                 .SpecialEffect   = 0
262:                 .MousePointer    = 15
263:                 .WordWrap        = .T.
264:                 .AutoSize        = .F.
265:             ENDWITH
266: 
267:             .AddObject("cmd_4c_Buscar", "CommandButton")
268:             WITH .cmd_4c_Buscar
269:                 .Caption         = "Buscar"
270:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
271:                 .PicturePosition = 13
272:                 .Top             = 5
273:                 .Left            =  542
274:                 .Width           = 75
275:                 .Height          = 75
276:                 .FontName        = "Comic Sans MS"
277:                 .FontSize        = 8
278:                 .FontBold        = .T.
279:                 .FontItalic      = .T.
280:                 .ForeColor       = RGB(90, 90, 90)
281:                 .BackColor       = RGB(255, 255, 255)
282:                 .Themes          = .F.

*-- Linhas 290 a 316:
290:         *-- Container saida - PADRAO CANONICO Left=917 (CLAUDE.md regra #10)
291:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
292:         WITH loc_oPagina.cnt_4c_Saida
293:             .Top         = 29
294:             .Left        = 917
295:             .Width       = 90
296:             .Height      = 85
297:             .BackStyle   = 0
298:             .BorderWidth = 0
299:             .Visible     = .T.
300: 
301:             .AddObject("cmd_4c_Encerrar", "CommandButton")
302:             WITH .cmd_4c_Encerrar
303:                 .Caption         = "Encerrar"
304:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
305:                 .PicturePosition = 13
306:                 .Top             = 5
307:                 .Left            = 917
308:                 .Width           = 90
309:                 .Height          = 75
310:                 .FontName        = "Comic Sans MS"
311:                 .FontSize        = 8
312:                 .FontBold        = .T.
313:                 .FontItalic      = .T.
314:                 .ForeColor       = RGB(90, 90, 90)
315:                 .BackColor       = RGB(255, 255, 255)
316:                 .SpecialEffect   = 0

*-- Linhas 323 a 377:
323:         *-- Container botoes especiais (cmdEspelho/Fecha/Abre: Top=82, +29 = 111)
324:         loc_oPagina.AddObject("cnt_4c_BotoesEspeciais", "Container")
325:         WITH loc_oPagina.cnt_4c_BotoesEspeciais
326:             .Top         = 111
327:             .Left        = 4
328:             .Width       = 340
329:             .Height      = 50
330:             .BackStyle   = 0
331:             .BorderWidth = 0
332:             .Visible     = .T.
333: 
334:             *-- Espelho: Left=14(abs) - 4(cnt.Left) = 10
335:             .AddObject("cmd_4c_Espelho", "CommandButton")
336:             WITH .cmd_4c_Espelho
337:                 .Caption       = "Espelho"
338:                 .Top           = 5
339:                 .Left          = 10
340:                 .Width         = 105
341:                 .Height        = 40
342:                 .FontName      = "Tahoma"
343:                 .FontSize      = 8
344:                 .ForeColor     = RGB(90, 90, 90)
345:                 .BackColor     = RGB(220, 220, 220)
346:                 .SpecialEffect = 0
347:                 .MousePointer  = 15
348:             ENDWITH
349: 
350:             *-- Fechar contagem: Left=119(abs) - 4(cnt.Left) = 115
351:             .AddObject("cmd_4c_FecharContagem", "CommandButton")
352:             WITH .cmd_4c_FecharContagem
353:                 .Caption       = "Fechar"
354:                 .Top           = 5
355:                 .Left          = 115
356:                 .Width         = 105
357:                 .Height        = 40
358:                 .FontName      = "Tahoma"
359:                 .FontSize      = 8
360:                 .ForeColor     = RGB(90, 90, 90)
361:                 .BackColor     = RGB(220, 220, 220)
362:                 .Themes        = .F.
363:                 .SpecialEffect = 0
364:                 .MousePointer  = 15
365:             ENDWITH
366: 
367:             *-- Abrir contagem: Left=224(abs) - 4(cnt.Left) = 220
368:             .AddObject("cmd_4c_AbrirContagem", "CommandButton")
369:             WITH .cmd_4c_AbrirContagem
370:                 .Caption       = "Abrir"
371:                 .Top           = 5
372:                 .Left          = 220
373:                 .Width         = 105
374:                 .Height        = 40
375:                 .FontName      = "Tahoma"
376:                 .FontSize      = 8
377:                 .ForeColor     = RGB(90, 90, 90)

*-- Linhas 386 a 395:
386:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
387:         loc_oPagina.grd_4c_Lista.ColumnCount = 5
388:         WITH loc_oPagina.grd_4c_Lista
389:             .Top                = 162
390:             .Left               = 0
391:             .Width              = 913
392:             .Height             = 400
393:             .FontName           = "Verdana"
394:             .FontSize           = 8
395:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 406 a 485:
406:         ENDWITH
407: 
408:         *-- BINDEVENT: botoes CRUD
409:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
410:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
411:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
412:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
413:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
414:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
415: 
416:         *-- BINDEVENT: botoes especiais
417:         BINDEVENT(loc_oPagina.cnt_4c_BotoesEspeciais.cmd_4c_Espelho,        "Click", THIS, "BtnEspelhoClick")
418:         BINDEVENT(loc_oPagina.cnt_4c_BotoesEspeciais.cmd_4c_FecharContagem, "Click", THIS, "BtnFecharContagemClick")
419:         BINDEVENT(loc_oPagina.cnt_4c_BotoesEspeciais.cmd_4c_AbrirContagem,  "Click", THIS, "BtnAbrirContagemClick")
420: 
421:         THIS.TornarControlesVisiveis(loc_oPagina)
422:     ENDPROC
423: 
424:     *==========================================================================
425:     * ConfigurarPaginaDados - Page2: Campos principais (Fase 5/8 - primeira metade)
426:     * Top dos controles = Top_original + 29 (compensacao PageFrame.Top=-29)
427:     * Fase 5: cnt_4c_Salva + labels + txt_4c_Codigo/Conta/DConta + Line1
428:     * Fase 6: lbl_4c_Label5/7 + txt_4c_Busca/TotQt/DContas + opt + grd + img + shp
429:     *==========================================================================
430:     PROTECTED PROCEDURE ConfigurarPaginaDados()
431:         LOCAL loc_oPagina
432:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
433: 
434:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
435:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
436: 
437:         *-- Container botoes Confirmar/Cancelar (Grupo_Salva: Top=11+29=40, Left=817)
438:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
439:         WITH loc_oPagina.cnt_4c_Salva
440:             .Top           = 40
441:             .Left          = 817
442:             .Width         = 160
443:             .Height        = 85
444:             .BackStyle     = 0
445:             .BorderWidth   = 0
446:             .SpecialEffect = 0
447:             .Visible       = .T.
448: 
449:             .AddObject("cmd_4c_Confirmar", "CommandButton")
450:             WITH .cmd_4c_Confirmar
451:                 .Caption         = "Confirmar"
452:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
453:                 .PicturePosition = 13
454:                 .Top             = 5
455:                 .Left            = 5
456:                 .Width           = 75
457:                 .Height          = 75
458:                 .FontName        = "Comic Sans MS"
459:                 .FontSize        = 8
460:                 .FontBold        = .T.
461:                 .FontItalic      = .T.
462:                 .ForeColor       = RGB(90, 90, 90)
463:                 .BackColor       = RGB(255, 255, 255)
464:                 .SpecialEffect   = 0
465:                 .MousePointer    = 15
466:                 .WordWrap        = .T.
467:                 .AutoSize        = .F.
468:             ENDWITH
469: 
470:             .AddObject("cmd_4c_Cancelar", "CommandButton")
471:             WITH .cmd_4c_Cancelar
472:                 .Caption         = "Encerrar"
473:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
474:                 .PicturePosition = 13
475:                 .Top             = 5
476:                 .Left            = 80
477:                 .Width           = 75
478:                 .Height          = 75
479:                 .FontName        = "Comic Sans MS"
480:                 .FontSize        = 8
481:                 .FontBold        = .T.
482:                 .FontItalic      = .T.
483:                 .ForeColor       = RGB(90, 90, 90)
484:                 .BackColor       = RGB(255, 255, 255)
485:                 .Themes          = .F.

*-- Linhas 491 a 519:
491:         ENDWITH
492: 
493:         *-- Label Codigo (Label4: Top=68+29=97, Left=205, Width=45)
494:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
495:         WITH loc_oPagina.lbl_4c_Label4
496:             .Top       = 97
497:             .Left      = 205
498:             .Width     = 45
499:             .Height    = 15
500:             .Caption   = "C" + CHR(243) + "digo :"
501:             .FontName  = "Tahoma"
502:             .FontSize  = 8
503:             .FontBold  = .F.
504:             .ForeColor = RGB(90, 90, 90)
505:             .BackStyle = 0
506:             .Alignment = 1
507:             .AutoSize  = .F.
508:         ENDWITH
509: 
510:         *-- TextBox getCods = txt_4c_Codigo (Top=63+29=92, Left=254, readonly - When=.F.)
511:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
512:         WITH loc_oPagina.txt_4c_Codigo
513:             .Top       = 92
514:             .Left      = 254
515:             .Width     = 80
516:             .Height    = 24
517:             .FontName  = "Tahoma"
518:             .FontSize  = 8
519:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 525 a 539:
525:         ENDWITH
526: 
527:         *-- Label Vendedor (Label2: Top=95+29=124, Left=192)
528:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
529:         WITH loc_oPagina.lbl_4c_Label2
530:             .Top       = 124
531:             .Left      = 192
532:             .Width     = 58
533:             .Height    = 15
534:             .Caption   = "Vendedor :"
535:             .FontName  = "Tahoma"
536:             .FontSize  = 8
537:             .FontBold  = .F.
538:             .ForeColor = RGB(90, 90, 90)
539:             .BackStyle = 0

*-- Linhas 545 a 554:
545:         *-- When: InList(pcEscolha, INSERIR, CONSULTAR) -> editavel so em INCLUIR
546:         loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
547:         WITH loc_oPagina.txt_4c_Conta
548:             .Top       = 119
549:             .Left      = 254
550:             .Width     = 80
551:             .Height    = 24
552:             .FontName  = "Tahoma"
553:             .FontSize  = 8
554:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 560 a 679:
560:         *-- TextBox getDConta = txt_4c_DConta (Top=90+29=119, Left=336, Width=290 - nome readonly)
561:         loc_oPagina.AddObject("txt_4c_DConta", "TextBox")
562:         WITH loc_oPagina.txt_4c_DConta
563:             .Top       = 119
564:             .Left      = 336
565:             .Width     = 290
566:             .Height    = 24
567:             .FontName  = "Tahoma"
568:             .FontSize  = 8
569:             .ForeColor = RGB(90, 90, 90)
570:             .BackColor = RGB(224, 224, 224)
571:             .ReadOnly  = .T.
572:             .Enabled   = .F.
573:             .Value     = ""
574:         ENDWITH
575: 
576:         *-- Label Conta (Label1: Top=177+29=206, Left=209)
577:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
578:         WITH loc_oPagina.lbl_4c_Label1
579:             .Top       = 206
580:             .Left      = 209
581:             .Width     = 41
582:             .Height    = 15
583:             .Caption   = "Conta :"
584:             .FontName  = "Tahoma"
585:             .FontSize  = 8
586:             .FontBold  = .F.
587:             .ForeColor = RGB(90, 90, 90)
588:             .BackStyle = 0
589:             .Alignment = 1
590:             .AutoSize  = .F.
591:         ENDWITH
592: 
593:         *-- Label Busca Produto (Label3: Top=126+29=155, Left=169)
594:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
595:         WITH loc_oPagina.lbl_4c_Label3
596:             .Top       = 155
597:             .Left      = 169
598:             .Width     = 81
599:             .Height    = 15
600:             .Caption   = "Busca Produto :"
601:             .FontName  = "Tahoma"
602:             .FontSize  = 8
603:             .FontBold  = .F.
604:             .ForeColor = RGB(90, 90, 90)
605:             .BackStyle = 0
606:             .Alignment = 1
607:             .AutoSize  = .F.
608:         ENDWITH
609: 
610:         *-- Label Procurar (Say3: Top=126+29=155, Left=373)
611:         loc_oPagina.AddObject("lbl_4c_Say3", "Label")
612:         WITH loc_oPagina.lbl_4c_Say3
613:             .Top       = 155
614:             .Left      = 373
615:             .Width     = 43
616:             .Height    = 15
617:             .Caption   = "Procurar"
618:             .FontName  = "Tahoma"
619:             .FontSize  = 8
620:             .FontBold  = .F.
621:             .ForeColor = RGB(90, 90, 90)
622:             .BackStyle = 0
623:             .AutoSize  = .F.
624:         ENDWITH
625: 
626:         *-- Linha separadora (Line1: Top=117+29=146, Left=165, Width=668)
627:         loc_oPagina.AddObject("lin_4c_Line1", "Line")
628:         WITH loc_oPagina.lin_4c_Line1
629:             .Top       = 146
630:             .Left      = 165
631:             .Width     = 668
632:             .Height    = 0
633:             .ForeColor = RGB(180, 180, 180)
634:             .Visible   = .T.
635:         ENDWITH
636: 
637:         *-- Label Quantidade (Label5: Top=152+29=181, Left=182)
638:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
639:         WITH loc_oPagina.lbl_4c_Label5
640:             .Top       = 181
641:             .Left      = 182
642:             .Width     = 68
643:             .Height    = 15
644:             .Caption   = "Quantidade :"
645:             .FontName  = "Tahoma"
646:             .FontSize  = 8
647:             .ForeColor = RGB(90, 90, 90)
648:             .BackStyle = 0
649:             .Alignment = 1
650:             .AutoSize  = .F.
651:         ENDWITH
652: 
653:         *-- Label Descricao (Label7: Top=576+29=605, Left=196)
654:         loc_oPagina.AddObject("lbl_4c_Label7", "Label")
655:         WITH loc_oPagina.lbl_4c_Label7
656:             .Top       = 605
657:             .Left      = 196
658:             .Width     = 55
659:             .Height    = 15
660:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
661:             .FontName  = "Tahoma"
662:             .FontSize  = 8
663:             .ForeColor = RGB(90, 90, 90)
664:             .BackStyle = 0
665:             .Alignment = 1
666:             .AutoSize  = .F.
667:         ENDWITH
668: 
669:         *-- TextBox getBusca = txt_4c_Busca (Top=122+29=151, Left=254, Width=108)
670:         *-- Busca por codigo de barras ou codigo de produto (conforme opt_4c_OptBusca)
671:         loc_oPagina.AddObject("txt_4c_Busca", "TextBox")
672:         WITH loc_oPagina.txt_4c_Busca
673:             .Top       = 151
674:             .Left      = 254
675:             .Width     = 108
676:             .Height    = 23
677:             .FontName  = "Tahoma"
678:             .FontSize  = 8
679:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 686 a 695:
686:         *-- Quantidade a registrar; LostFocus atualiza csSigCdCri.QtdCtg
687:         loc_oPagina.AddObject("txt_4c_TotQt", "TextBox")
688:         WITH loc_oPagina.txt_4c_TotQt
689:             .Top       = 177
690:             .Left      = 254
691:             .Width     = 80
692:             .Height    = 23
693:             .FontName  = "Tahoma"
694:             .FontSize  = 8
695:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 701 a 735:
701:         *-- Buttons(1): busca por Cod.Barra; Buttons(2): busca por Produto
702:         loc_oPagina.AddObject("opt_4c_OptBusca", "OptionGroup")
703:         WITH loc_oPagina.opt_4c_OptBusca
704:             .Top         = 151
705:             .Left        = 414
706:             .Width       = 122
707:             .Height      = 23
708:             .ButtonCount = 2
709:             .BackStyle   = 0
710:             .BorderStyle = 0
711:             .Value       = 1
712:             .Visible     = .T.
713:         ENDWITH
714:         WITH loc_oPagina.opt_4c_OptBusca.Buttons(1)
715:             .Caption   = "C" + CHR(243) + "d.Barra"
716:             .BackStyle = 0
717:             .Left      = 5
718:             .Top       = 3
719:             .Width     = 55
720:             .AutoSize  = .T.
721:             .FontName  = "Tahoma"
722:             .FontSize  = 8
723:             .ForeColor = RGB(90, 90, 90)
724:             .Themes    = .F.
725:         ENDWITH
726:         WITH loc_oPagina.opt_4c_OptBusca.Buttons(2)
727:             .Caption   = "Produto"
728:             .BackStyle = 0
729:             .Left      = 63
730:             .Top       = 3
731:             .Width     = 49
732:             .AutoSize  = .T.
733:             .FontName  = "Tahoma"
734:             .FontSize  = 8
735:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 741 a 750:
741:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
742:         loc_oPagina.grd_4c_Dados.ColumnCount = 6
743:         WITH loc_oPagina.grd_4c_Dados
744:             .Top                = 203
745:             .Left               = 254
746:             .Width              = 477
747:             .Height             = 396
748:             .FontName           = "Verdana"
749:             .FontSize           = 8
750:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 759 a 833:
759:             .RowHeight          = 16
760:             .ScrollBars         = 2
761: 
762:             .Column1.Header1.Caption = "Emp."
763:             .Column1.Width           = 40
764:             .Column1.ReadOnly        = .T.
765: 
766:             .Column2.Header1.Caption = "Qtde."
767:             .Column2.Width           = 60
768: 
769:             .Column3.Header1.Caption = "Estoque"
770:             .Column3.Width           = 60
771:             .Column3.ReadOnly        = .T.
772: 
773:             .Column4.Header1.Caption = "Grupo"
774:             .Column4.Width           = 60
775:             .Column4.ReadOnly        = .T.
776: 
777:             .Column5.Header1.Caption = "Conta"
778:             .Column5.Width           = 80
779:             .Column5.ReadOnly        = .T.
780: 
781:             .Column6.Header1.Caption = "Produto"
782:             .Column6.Width           = 177
783:             .Column6.ReadOnly        = .T.
784:         ENDWITH
785: 
786:         *-- Image ImgJpg (Top=242+29=271, Left=746 - inicialmente invisivel)
787:         loc_oPagina.AddObject("img_4c_ImgJpg", "Image")
788:         WITH loc_oPagina.img_4c_ImgJpg
789:             .Top     = 271
790:             .Left    = 746
791:             .Width   = 241
792:             .Height  = 217
793:             .Visible = .F.
794:         ENDWITH
795: 
796:         *-- Shape ShpFigura (borda da area de imagem: Top=239+29=268, Left=743)
797:         loc_oPagina.AddObject("shp_4c_ShpFigura", "Shape")
798:         WITH loc_oPagina.shp_4c_ShpFigura
799:             .Top         = 268
800:             .Left        = 743
801:             .Width       = 247
802:             .Height      = 224
803:             .BorderColor = RGB(180, 180, 180)
804:             .FillStyle   = 1
805:             .BackStyle   = 0
806:             .Visible     = .T.
807:         ENDWITH
808: 
809:         *-- TextBox getDContas = txt_4c_DContas (Top=571+29=600, Left=254, Width=356)
810:         *-- Descricao do produto selecionado no grid (readonly)
811:         loc_oPagina.AddObject("txt_4c_DContas", "TextBox")
812:         WITH loc_oPagina.txt_4c_DContas
813:             .Top       = 600
814:             .Left      = 254
815:             .Width     = 356
816:             .Height    = 24
817:             .FontName  = "Tahoma"
818:             .FontSize  = 8
819:             .ForeColor = RGB(90, 90, 90)
820:             .BackColor = RGB(224, 224, 224)
821:             .ReadOnly  = .T.
822:             .Enabled   = .F.
823:             .Value     = ""
824:         ENDWITH
825: 
826:         *-- BINDEVENT: botoes Confirmar/Cancelar
827:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
828:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
829: 
830:         *-- BINDEVENT: lookup Vendedor
831:         BINDEVENT(loc_oPagina.txt_4c_Conta, "KeyPress", THIS, "ValidarConta")
832: 
833:         *-- BINDEVENT: busca de produto, quantidade, grid e opcao de busca

*-- Linhas 866 a 882:
866:                     WITH loc_oGrid
867:                         .Column1.ControlSource   = "cursor_4c_Dados.Datas"
868:                         .Column1.Width           = 80
869:                         .Column1.Header1.Caption = "Data"
870: 
871:                         .Column2.ControlSource   = "cursor_4c_Dados.Vends"
872:                         .Column2.Width           = 90
873:                         .Column2.Header1.Caption = "Vendedor"
874: 
875:                         .Column3.ControlSource   = "cursor_4c_Dados.Cods"
876:                         .Column3.Width           = 80
877:                         .Column3.Header1.Caption = "C" + CHR(243) + "digo"
878:                     ENDWITH
879: 
880:                     THIS.FormatarGridLista(loc_oGrid)
881:                     loc_lResultado = .T.
882:                 ENDIF

*-- Linhas 1451 a 1460:
1451:             ENDIF
1452: 
1453:             *-- Botoes salva
1454:             loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = par_lHabilitar
1455:             loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
1456: 
1457:         CATCH TO loException
1458:             MostrarErro(loException, "Formcrf.HabilitarCampos")
1459:         ENDTRY
1460:     ENDPROC

*-- Linhas 1469 a 1481:
1469:         TRY
1470:             DO CASE
1471:             CASE THIS.this_cModoAtual = "VISUALIZAR"
1472:                 loc_oPag2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = .F.
1473:                 loc_oPag2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
1474:             CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1475:                 loc_oPag2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = .T.
1476:                 loc_oPag2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
1477:             ENDCASE
1478:         CATCH TO loException
1479:             *-- Silencioso
1480:         ENDTRY
1481:     ENDPROC

*-- Linhas 1502 a 1535:
1502:                     .Column1.ControlSource   = loc_cCursor + ".Emps"
1503:                     .Column1.Width           = 40
1504:                     .Column1.ReadOnly        = .T.
1505:                     .Column1.Header1.Caption = "Emp."
1506: 
1507:                     .Column2.ControlSource   = loc_cCursor + ".QtdCtg"
1508:                     .Column2.Width           = 60
1509:                     .Column2.ReadOnly        = .F.
1510:                     .Column2.Header1.Caption = "Qtde."
1511: 
1512:                     .Column3.ControlSource   = loc_cCursor + ".qtde"
1513:                     .Column3.Width           = 60
1514:                     .Column3.ReadOnly        = .T.
1515:                     .Column3.Header1.Caption = "Estoque"
1516: 
1517:                     .Column4.ControlSource   = loc_cCursor + ".Grupos"
1518:                     .Column4.Width           = 60
1519:                     .Column4.ReadOnly        = .T.
1520:                     .Column4.Header1.Caption = "Grupo"
1521: 
1522:                     .Column5.ControlSource   = loc_cCursor + ".Estos"
1523:                     .Column5.Width           = 80
1524:                     .Column5.ReadOnly        = .T.
1525:                     .Column5.Header1.Caption = "Conta"
1526: 
1527:                     .Column6.ControlSource   = loc_cCursor + ".Descr"
1528:                     .Column6.Width           = 177
1529:                     .Column6.ReadOnly        = .T.
1530:                     .Column6.Header1.Caption = "Produto"
1531:                 ENDWITH
1532: 
1533:                 THIS.FormatarGridLista(loc_oGrid)
1534:                 loc_oGrid.Refresh()
1535:             ENDIF


### BO (C:\4c\projeto\app\classes\crfBO.prg):
*============================================================================
* crfBO.prg - Business Object para Contagem de Referencia (SigCdCrf)
* Herda de BusinessBase
* Tabela principal: SigCdCrf (cabecalho da contagem)
* Tabela detalhe  : SigCdCri (itens/produtos da contagem)
*============================================================================

DEFINE CLASS crfBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades da tabela SigCdCrf (cabecalho da contagem)
    *--------------------------------------------------------------------------
    this_cCods      = ""    && PK: Codigo da contagem C(10) - gerado por fGerUniqueKey
    this_cEmps      = ""    && Empresa C(3)
    this_cVends     = ""    && Codigo do vendedor C(10) - FK SigCdCli.Iclis
    this_cDesVends  = ""    && Nome do vendedor - virtual do JOIN com SigCdCli.Rclis
    this_dDatas     = {}    && Data da contagem (Date)
    this_nConferido = 0     && Status: 0=contagem aberta, 1=contagem encerrada
    this_cIdChaves  = ""    && Identificador unico do cabecalho - gerado por fUniqueIds

    *--------------------------------------------------------------------------
    * Propriedades auxiliares para operacao
    *--------------------------------------------------------------------------
    this_cGrPadVens    = ""           && Grupo padrao de vendedores (de SigCdPam.GrPadVens)
    this_cCursorItens  = "csSigCdCri" && Cursor de trabalho (itens vindos de SigMvEst)
    this_cCursorSalvar = "crSigCdCri" && Cursor de gravacao (itens para SigCdCri)

    *==========================================================================
    * Init - Inicializa Business Object
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdCrf"
            THIS.this_cCampoChave = "Cods"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "crfBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCods)
    ENDFUNC

    *==========================================================================
    * Buscar - Lista contagens de referencia da empresa
    * par_cFiltro: filtro WHERE opcional (sem a palavra WHERE)
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados ;
                        (Cods C(10), Emps C(3), Vends C(10), Datas D, ;
                         Conferido N(1,0), cIdChaves C(10), DesVends C(50))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT a.Cods, a.Emps, a.Vends, a.Datas," + ;
                           " a.Conferido, a.cIdChaves, b.Rclis AS DesVends" + ;
                           " FROM SigCdCrf a" + ;
                           " LEFT JOIN SigCdCli b ON a.Vends = b.Iclis" + ;
                           " WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

                IF !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " AND (" + par_cFiltro + ")"
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY a.Datas DESC, a.Cods"

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
                        MostrarErro("Erro ao buscar contagens:" + CHR(13) + CapturarErroSQL(), "crfBO.Buscar")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar contagens:" + CHR(13) + CapturarErroSQL(), "crfBO.Buscar")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "crfBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega contagem pelo codigo Cods
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.Cods, a.Emps, a.Vends, a.Datas," + ;
                       " a.Conferido, a.cIdChaves, b.Rclis AS DesVends" + ;
                       " FROM SigCdCrf a" + ;
                       " LEFT JOIN SigCdCli b ON a.Vends = b.Iclis" + ;
                       " WHERE a.Cods = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Contagem n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar contagem:" + CHR(13) + CapturarErroSQL(), "crfBO.CarregarPorCodigo")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "crfBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCods      = TratarNulo(Cods,      "C")
                THIS.this_cEmps      = TratarNulo(Emps,      "C")
                THIS.this_cVends     = TratarNulo(Vends,     "C")
                THIS.this_cDesVends  = TratarNulo(DesVends,  "C")
                THIS.this_dDatas     = TratarNulo(Datas,     "D")
                THIS.this_nConferido = TratarNulo(Conferido, "N")
                THIS.this_cIdChaves  = TratarNulo(cIdChaves, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "crfBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * GerarCodigoContagem - Gera proximo codigo numerico para SigCdCrf
    *==========================================================================
    PROTECTED FUNCTION GerarCodigoContagem()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_nProxId
        loc_lSucesso = .F.
        loc_nProxId  = 1

        TRY
            loc_cSQL = "SELECT ISNULL(MAX(CAST(LTRIM(RTRIM(Cods)) AS BIGINT)), 0) + 1" + ;
                       " AS NextID FROM SigCdCrf WHERE ISNUMERIC(Cods) = 1"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxId")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_MaxId") > 0
                SELECT cursor_4c_MaxId
                loc_nProxId = TratarNulo(NextID, "N")
                IF loc_nProxId < 1
                    loc_nProxId = 1
                ENDIF
            ENDIF

            IF USED("cursor_4c_MaxId")
                USE IN cursor_4c_MaxId
            ENDIF

            THIS.this_cCods     = PADL(ALLTRIM(STR(loc_nProxId, 10)), 10, " ")
            THIS.this_cIdChaves = SYS(2015)
            loc_lSucesso = .T.

        CATCH TO loException
            MostrarErro("Erro ao gerar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "crfBO.GerarCodigoContagem")
            IF USED("cursor_4c_MaxId")
                USE IN cursor_4c_MaxId
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Inserir - Insere cabecalho em SigCdCrf e itens de csSigCdCri em SigCdCri
    * Usa transacao explicita pois atualiza duas tabelas
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_lTransacao
        loc_lSucesso  = .F.
        loc_lTransacao = .F.

        TRY
            IF !THIS.GerarCodigoContagem()
                MostrarErro("Erro ao gerar c" + CHR(243) + "digo da contagem.", "crfBO.Inserir")
            ELSE
                THIS.this_dDatas     = DATE()
                THIS.this_nConferido = 0

                SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
                loc_lTransacao = .T.

                TEXT TO loc_cSQL TEXTMERGE NOSHOW
                    INSERT INTO SigCdCrf (Cods, Emps, Vends, Datas, cIdChaves, Conferido)
                    VALUES (
                        <<EscaparSQL(THIS.this_cCods)>>,
                        <<EscaparSQL(THIS.this_cEmps)>>,
                        <<EscaparSQL(THIS.this_cVends)>>,
                        <<FormatarDataSQL(THIS.this_dDatas)>>,
                        <<EscaparSQL(THIS.this_cIdChaves)>>,
                        <<FormatarNumeroSQL(THIS.this_nConferido, 0)>>
                    )
                ENDTEXT

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 0
                    MostrarErro("Erro ao inserir cabe" + CHR(231) + "alho:" + CHR(13) + CapturarErroSQL(), "crfBO.Inserir")
                ELSE
                    loc_lSucesso = THIS.SalvarItensContagem()

                    IF loc_lSucesso
                        SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                        loc_lTransacao = .F.
                        THIS.RegistrarAuditoria("INSERT")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "crfBO.Inserir")
        ENDTRY

        IF loc_lTransacao
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * SalvarItensContagem - Insere cada item de csSigCdCri em SigCdCri
    * Chamado dentro de transacao (Inserir/Atualizar)
    *==========================================================================
    PROTECTED FUNCTION SalvarItensContagem()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        LOCAL loc_cIdChave, loc_cEmps, loc_cGrupos, loc_cEstos
        LOCAL loc_cCpros, loc_nCBars, loc_nQtds, loc_nEstoque, loc_cDescr
        loc_lSucesso = .F.

        TRY
            IF !USED(THIS.this_cCursorItens)
                MostrarErro("Cursor de itens n" + CHR(227) + "o encontrado: " + THIS.this_cCursorItens, "crfBO.SalvarItensContagem")
            ELSE
                loc_lSucesso = .T.

                SELECT (THIS.this_cCursorItens)
                GO TOP

                SCAN WHILE loc_lSucesso
                    loc_cIdChave = SYS(2015)
                    loc_cEmps    = ALLTRIM(TratarNulo(Emps,   "C"))
                    loc_cGrupos  = ALLTRIM(TratarNulo(Grupos, "C"))
                    loc_cEstos   = ALLTRIM(TratarNulo(Estos,  "C"))
                    loc_cCpros   = ALLTRIM(TratarNulo(Cpros,  "C"))
                    loc_nCBars   = TratarNulo(CBars,   "N")
                    loc_nQtds    = TratarNulo(QtdCtg,  "N")
                    loc_nEstoque = TratarNulo(qtde,    "N")
                    loc_cDescr   = LEFT(ALLTRIM(TratarNulo(Descr, "C")), 60)

                    TEXT TO loc_cSQL TEXTMERGE NOSHOW
                        INSERT INTO SigCdCri (cIdChaves, Cods, Emps, Grupos, Estos, Cpros, CBars, Qtds, Estoque, Descr)
                        VALUES (
                            <<EscaparSQL(loc_cIdChave)>>,
                            <<EscaparSQL(THIS.this_cCods)>>,
                            <<EscaparSQL(loc_cEmps)>>,
                            <<EscaparSQL(loc_cGrupos)>>,
                            <<EscaparSQL(loc_cEstos)>>,
                            <<EscaparSQL(loc_cCpros)>>,
                            <<FormatarNumeroSQL(loc_nCBars, 0)>>,
                            <<FormatarNumeroSQL(loc_nQtds, 2)>>,
                            <<FormatarNumeroSQL(loc_nEstoque, 2)>>,
                            <<EscaparSQL(loc_cDescr)>>
                        )
                    ENDTEXT

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado < 0
                        MostrarErro("Erro ao salvar item [" + loc_cCpros + "]:" + CHR(13) + CapturarErroSQL(), "crfBO.SalvarItensContagem")
                        loc_lSucesso = .F.
                    ENDIF

                    SELECT (THIS.this_cCursorItens)
                ENDSCAN
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao salvar itens:" + CHR(13) + loException.Message, "crfBO.SalvarItensContagem")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Atualizar - Delete+reinsert em SigCdCrf e SigCdCri (mesmo padrao do legado)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_lTransacao
        loc_lSucesso  = .F.
        loc_lTransacao = .F.

        TRY
            THIS.this_dDatas    = DATE()
            THIS.this_cIdChaves = SYS(2015)

            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
            loc_lTransacao = .T.

            *-- Exclui itens existentes
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigCdCri WHERE Cods = " + EscaparSQL(THIS.this_cCods))

            IF loc_nResultado < 0
                MostrarErro("Erro ao excluir itens anteriores:" + CHR(13) + CapturarErroSQL(), "crfBO.Atualizar")
            ELSE
                *-- Exclui cabecalho existente
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "DELETE FROM SigCdCrf WHERE Cods = " + EscaparSQL(THIS.this_cCods))

                IF loc_nResultado < 0
                    MostrarErro("Erro ao excluir cabe" + CHR(231) + "alho anterior:" + CHR(13) + CapturarErroSQL(), "crfBO.Atualizar")
                ELSE
                    TEXT TO loc_cSQL TEXTMERGE NOSHOW
                        INSERT INTO SigCdCrf (Cods, Emps, Vends, Datas, cIdChaves, Conferido)
                        VALUES (
                            <<EscaparSQL(THIS.this_cCods)>>,
                            <<EscaparSQL(THIS.this_cEmps)>>,
                            <<EscaparSQL(THIS.this_cVends)>>,
                            <<FormatarDataSQL(THIS.this_dDatas)>>,
                            <<EscaparSQL(THIS.this_cIdChaves)>>,
                            <<FormatarNumeroSQL(THIS.this_nConferido, 0)>>
                        )
                    ENDTEXT

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado < 0
                        MostrarErro("Erro ao regravar cabe" + CHR(231) + "alho:" + CHR(13) + CapturarErroSQL(), "crfBO.Atualizar")
                    ELSE
                        loc_lSucesso = THIS.SalvarItensContagem()

                        IF loc_lSucesso
                            SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                            loc_lTransacao = .F.
                            THIS.RegistrarAuditoria("UPDATE")
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "crfBO.Atualizar")
        ENDTRY

        IF loc_lTransacao
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui contagem (itens + cabecalho) com verificacao
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_nResultado, loc_lTransacao
        loc_lSucesso  = .F.
        loc_lTransacao = .F.

        TRY
            *-- Verifica se a contagem esta encerrada (nao pode excluir encerradas)
            IF THIS.this_nConferido = 1
                MsgAviso("Contagem J" + CHR(225) + " Encerrada. Reabra antes de excluir.")
            ELSE
                SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
                loc_lTransacao = .T.

                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "DELETE FROM SigCdCri WHERE Cods = " + EscaparSQL(THIS.this_cCods))

                IF loc_nResultado < 0
                    MostrarErro("Erro ao excluir itens:" + CHR(13) + CapturarErroSQL(), "crfBO.ExecutarExclusao")
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, ;
                        "DELETE FROM SigCdCrf WHERE Cods = " + EscaparSQL(THIS.this_cCods))

                    IF loc_nResultado >= 0
                        SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                        loc_lTransacao = .F.
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao excluir contagem:" + CHR(13) + CapturarErroSQL(), "crfBO.ExecutarExclusao")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "crfBO.ExecutarExclusao")
        ENDTRY

        IF loc_lTransacao
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarParametros - Carrega grupo padrao de vendedores de SigCdPam
    *==========================================================================
    PROCEDURE CarregarParametros()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT GrPadVens FROM SigCdPam" + ;
                       " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Params")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Params") > 0
                SELECT cursor_4c_Params
                GO TOP
                THIS.this_cGrPadVens = ALLTRIM(TratarNulo(GrPadVens, "C"))

                IF EMPTY(THIS.this_cGrPadVens)
                    MostrarErro("O Grupo Padr" + CHR(227) + "o de Vendedores n" + CHR(227) + "o est" + ;
                                CHR(225) + " configurado nos Par" + CHR(226) + "metros do Sistema.", ;
                                "Configura" + CHR(231) + CHR(227) + "o Incorreta")
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                MostrarErro("Par" + CHR(226) + "metros do sistema n" + CHR(227) + "o encontrados.", "crfBO.CarregarParametros")
            ENDIF

            IF USED("cursor_4c_Params")
                USE IN cursor_4c_Params
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar par" + CHR(226) + "metros:" + CHR(13) + loException.Message, "crfBO.CarregarParametros")
            IF USED("cursor_4c_Params")
                USE IN cursor_4c_Params
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarProdutosEstoque - Carrega produtos de SigMvEst em csSigCdCri
    * Usado ao iniciar nova contagem (modo INSERIR)
    *==========================================================================
    PROCEDURE CarregarProdutosEstoque()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorItens)
                USE IN (THIS.this_cCursorItens)
            ENDIF

            loc_cSQL = "SELECT a.Emps, a.Grupos, a.Estos, a.cpros," + ;
                       " SUM(a.sqtds) AS qtde," + ;
                       " CONVERT(numeric(5,0), 0) AS QtdCtg," + ;
                       " b.dpros AS Descr, b.cbars AS CBars" + ;
                       " FROM SigMvEst a" + ;
                       " JOIN SigCdpro b ON a.CPros = b.Cpros" + ;
                       " JOIN SigCdCli c ON a.Estos = c.Iclis" + ;
                       " JOIN SigCtCtg d ON a.empgruests = d.empresa + d.grupos + d.contas" + ;
                       " WHERE a.emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       " AND b.cunis = 'UN'" + ;
                       " GROUP BY a.Emps, a.Grupos, a.Estos, b.dpros, a.cpros, b.cbars" + ;
                       " HAVING SUM(a.sqtds) <> 0" + ;
                       " ORDER BY a.Emps, a.Grupos, a.Estos, a.cpros"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorItens)

            IF loc_nResultado >= 0
                SELECT (THIS.this_cCursorItens)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar produtos do estoque:" + CHR(13) + CapturarErroSQL(), "crfBO.CarregarProdutosEstoque")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar estoque:" + CHR(13) + loException.Message, "crfBO.CarregarProdutosEstoque")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarItensContagem - Carrega produtos + mescla com itens de SigCdCri
    * Usado ao editar (ALTERAR) ou visualizar (CONSULTAR) contagem existente
    * par_cCodigo      : codigo da contagem (Cods)
    * par_lSoContados  : .T. = mostra apenas itens que foram contados (CONSULTAR)
    *==========================================================================
    PROCEDURE CarregarItensContagem(par_cCodigo, par_lSoContados)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorItens)
                USE IN (THIS.this_cCursorItens)
            ENDIF

            *-- Query unica: produtos do estoque com QtdCtg ja preenchida de SigCdCri
            loc_cSQL = "SELECT a.Emps, a.Grupos, a.Estos, a.cpros," + ;
                       " SUM(a.sqtds) AS qtde," + ;
                       " ISNULL(" + ;
                       "   (SELECT TOP 1 c.Qtds FROM SigCdCri c" + ;
                       "    WHERE c.Cods = " + EscaparSQL(par_cCodigo) + ;
                       "    AND c.Cpros = a.cpros AND c.Emps = a.Emps" + ;
                       "    AND c.Grupos = a.Grupos AND c.Estos = a.Estos), 0)" + ;
                       " AS QtdCtg," + ;
                       " b.dpros AS Descr, b.cbars AS CBars" + ;
                       " FROM SigMvEst a" + ;
                       " JOIN SigCdpro b ON a.CPros = b.Cpros" + ;
                       " JOIN SigCdCli c ON a.Estos = c.Iclis" + ;
                       " JOIN SigCtCtg d ON a.empgruests = d.empresa + d.grupos + d.contas" + ;
                       " WHERE a.emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       " AND b.cunis = 'UN'" + ;
                       " GROUP BY a.Emps, a.Grupos, a.Estos, b.dpros, a.cpros, b.cbars" + ;
                       " HAVING SUM(a.sqtds) <> 0"

            IF par_lSoContados
                *-- CONSULTAR/Encerrada: filtra apenas itens que existem em SigCdCri
                loc_cSQL = loc_cSQL + ;
                           " AND EXISTS (SELECT 1 FROM SigCdCri cx" + ;
                           " WHERE cx.Cods = " + EscaparSQL(par_cCodigo) + ;
                           " AND cx.Cpros = a.cpros AND cx.Emps = a.Emps" + ;
                           " AND cx.Grupos = a.Grupos AND cx.Estos = a.Estos)"
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.Emps, a.Grupos, a.Estos, a.cpros"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorItens)

            IF loc_nResultado >= 0
                SELECT (THIS.this_cCursorItens)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar itens da contagem:" + CHR(13) + CapturarErroSQL(), "crfBO.CarregarItensContagem")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar itens:" + CHR(13) + loException.Message, "crfBO.CarregarItensContagem")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * EncerrarContagem - Define Conferido=1 na contagem especificada
    *==========================================================================
    PROCEDURE EncerrarContagem(par_cCodigo)
        LOCAL loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "UPDATE SigCdCrf SET Conferido = 1" + ;
                " WHERE Cods = " + EscaparSQL(par_cCodigo) + ;
                " AND Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa))

            IF loc_nResultado >= 0
                THIS.this_nConferido = 1
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao encerrar contagem:" + CHR(13) + CapturarErroSQL(), "crfBO.EncerrarContagem")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao encerrar:" + CHR(13) + loException.Message, "crfBO.EncerrarContagem")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ReabrirContagem - Define Conferido=0 na contagem especificada
    *==========================================================================
    PROCEDURE ReabrirContagem(par_cCodigo)
        LOCAL loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "UPDATE SigCdCrf SET Conferido = 0" + ;
                " WHERE Cods = " + EscaparSQL(par_cCodigo) + ;
                " AND Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa))

            IF loc_nResultado >= 0
                THIS.this_nConferido = 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao reabrir contagem:" + CHR(13) + CapturarErroSQL(), "crfBO.ReabrirContagem")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao reabrir:" + CHR(13) + loException.Message, "crfBO.ReabrirContagem")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarVendedores - Pesquisa vendedores validos no grupo padrao
    * par_cValor: valor de busca inicial
    * par_cCampo: "Iclis" (por codigo) ou "Rclis" (por nome)
    *==========================================================================
    PROCEDURE BuscarVendedores(par_cValor, par_cCampo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cGrPadVens)
                THIS.CarregarParametros()
            ENDIF

            IF USED("cursor_4c_Vendedores")
                USE IN cursor_4c_Vendedores
            ENDIF

            loc_cSQL = "SELECT a.Iclis, a.Rclis, a.Grupos, a.Situas," + ;
                       " a.Cpfs, a.Inativas, a.ContaMats, a.Emps" + ;
                       " FROM SigCdCli a" + ;
                       " INNER JOIN SigCdGcr b ON a.Grupos = b.Codigos" + ;
                       " INNER JOIN SigCdAce c ON a.Iclis = c.Usuarios" + ;
                       " WHERE NOT b.Coletors = 10" + ;
                       " AND a.Grupos = " + EscaparSQL(THIS.this_cGrPadVens) + ;
                       " AND a.Inativas <> 2" + ;
                       " AND c.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       " ORDER BY a.Iclis"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Vendedores")

            IF loc_nResultado >= 0
                SELECT cursor_4c_Vendedores
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar vendedores:" + CHR(13) + CapturarErroSQL(), "crfBO.BuscarVendedores")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar vendedores:" + CHR(13) + loException.Message, "crfBO.BuscarVendedores")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

