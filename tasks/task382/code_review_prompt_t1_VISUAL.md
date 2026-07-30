# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 182: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 205: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 228: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 251: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 274: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 315: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 394: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 418: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCRC.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1268 linhas total):

*-- Linhas 83 a 92:
83:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
84: 
85:         WITH THIS.pgf_4c_Paginas
86:             .Top       = -29
87:             .Left      = 0
88:             .Width     = THIS.Width
89:             .Height    = THIS.Height + 29
90:             .PageCount = 2
91:             .Tabs      = .F.
92:             .Visible   = .T.

*-- Linhas 115 a 152:
115:         *-- Container cabecalho (titulo do form)
116:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
117:         WITH loc_oPagina.cnt_4c_Cabecalho
118:             .Top         = 31
119:             .Left        = 0
120:             .Width       = THIS.Width
121:             .Height      = 80
122:             .BackColor   = RGB(100, 100, 100)
123:             .BorderWidth = 0
124:             .Visible     = .T.
125:         ENDWITH
126: 
127:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
128:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
129:             .Caption   = "Cadastro de Caracter" + CHR(237) + "sticas de Contas"
130:             .Top       = 15
131:             .Left      = 10
132:             .Width     = THIS.Width - 20
133:             .Height    = 40
134:             .FontName  = "Tahoma"
135:             .FontSize  = 16
136:             .FontBold  = .T.
137:             .ForeColor = RGB(0, 0, 0)
138:             .BackStyle = 0
139:             .AutoSize  = .F.
140:             .Visible   = .T.
141:         ENDWITH
142: 
143:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
144:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
145:             .Caption   = "Cadastro de Caracter" + CHR(237) + "sticas de Contas"
146:             .Top       = 18
147:             .Left      = 10
148:             .Width     = THIS.Width - 20
149:             .Height    = 46
150:             .FontName  = "Tahoma"
151:             .FontSize  = 16
152:             .FontBold  = .T.

*-- Linhas 159 a 341:
159:         *-- Container botoes CRUD (Incluir/Visualizar/Alterar/Excluir/Buscar)
160:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
161:         WITH loc_oPagina.cnt_4c_Botoes
162:             .Top         = 29
163:             .Left        = 542
164:             .Width       = 390
165:             .Height      = 85
166:             .BackStyle = 0
167:             .BorderWidth = 0
168:             .Visible     = .T.
169:         ENDWITH
170: 
171:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
172:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
173:             .Caption         = "Incluir"
174:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
175:             .PicturePosition = 13
176:             .Top             = 5
177:             .Left            = 5
178:             .Width           = 75
179:             .Height          = 75
180:             .BackColor       = RGB(255, 255, 255)
181:             .ForeColor       = RGB(90, 90, 90)
182:             .FontName        = "Comic Sans MS"
183:             .FontSize        = 8
184:             .FontBold        = .T.
185:             .FontItalic      = .T.
186:             .Themes          = .F.
187:             .SpecialEffect   = 0
188:             .MousePointer    = 15
189:             .WordWrap        = .T.
190:             .AutoSize        = .F.
191:             .Visible         = .T.
192:         ENDWITH
193: 
194:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
195:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
196:             .Caption         = "Visualizar"
197:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
198:             .PicturePosition = 13
199:             .Top             = 5
200:             .Left            = 80
201:             .Width           = 75
202:             .Height          = 75
203:             .BackColor       = RGB(255, 255, 255)
204:             .ForeColor       = RGB(90, 90, 90)
205:             .FontName        = "Comic Sans MS"
206:             .FontSize        = 8
207:             .FontBold        = .T.
208:             .FontItalic      = .T.
209:             .Themes          = .F.
210:             .SpecialEffect   = 0
211:             .MousePointer    = 15
212:             .WordWrap        = .T.
213:             .AutoSize        = .F.
214:             .Visible         = .T.
215:         ENDWITH
216: 
217:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
218:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
219:             .Caption         = "Alterar"
220:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
221:             .PicturePosition = 13
222:             .Top             = 5
223:             .Left            = 155
224:             .Width           = 75
225:             .Height          = 75
226:             .BackColor       = RGB(255, 255, 255)
227:             .ForeColor       = RGB(90, 90, 90)
228:             .FontName        = "Comic Sans MS"
229:             .FontSize        = 8
230:             .FontBold        = .T.
231:             .FontItalic      = .T.
232:             .Themes          = .F.
233:             .SpecialEffect   = 0
234:             .MousePointer    = 15
235:             .WordWrap        = .T.
236:             .AutoSize        = .F.
237:             .Visible         = .T.
238:         ENDWITH
239: 
240:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
241:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
242:             .Caption         = "Excluir"
243:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
244:             .PicturePosition = 13
245:             .Top             = 5
246:             .Left            = 230
247:             .Width           = 75
248:             .Height          = 75
249:             .BackColor       = RGB(255, 255, 255)
250:             .ForeColor       = RGB(90, 90, 90)
251:             .FontName        = "Comic Sans MS"
252:             .FontSize        = 8
253:             .FontBold        = .T.
254:             .FontItalic      = .T.
255:             .Themes          = .F.
256:             .SpecialEffect   = 0
257:             .MousePointer    = 15
258:             .WordWrap        = .T.
259:             .AutoSize        = .F.
260:             .Visible         = .T.
261:         ENDWITH
262: 
263:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
264:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
265:             .Caption         = "Buscar"
266:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
267:             .PicturePosition = 13
268:             .Top             = 5
269:             .Left            = 305
270:             .Width           = 75
271:             .Height          = 75
272:             .BackColor       = RGB(255, 255, 255)
273:             .ForeColor       = RGB(90, 90, 90)
274:             .FontName        = "Comic Sans MS"
275:             .FontSize        = 8
276:             .FontBold        = .T.
277:             .FontItalic      = .T.
278:             .Themes          = .F.
279:             .SpecialEffect   = 0
280:             .MousePointer    = 15
281:             .WordWrap        = .T.
282:             .AutoSize        = .F.
283:             .Visible         = .T.
284:         ENDWITH
285: 
286:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
287:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
288:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
289:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
290:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
291: 
292:         *-- Container Encerrar (canonico: Left=917, Width=90, cmd Width=75)
293:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
294:         WITH loc_oPagina.cnt_4c_Saida
295:             .Top         = 29
296:             .Left        = 917
297:             .Width       = 90
298:             .Height      = 85
299:             .BackStyle   = 0
300:             .BorderWidth = 0
301:             .Visible     = .T.
302:         ENDWITH
303: 
304:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
305:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
306:             .Caption         = "Encerrar"
307:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
308:             .PicturePosition = 13
309:             .Top             = 5
310:             .Left            = 5
311:             .Width           = 75
312:             .Height          = 75
313:             .BackColor       = RGB(255, 255, 255)
314:             .ForeColor       = RGB(90, 90, 90)
315:             .FontName        = "Comic Sans MS"
316:             .FontSize        = 8
317:             .FontBold        = .T.
318:             .FontItalic      = .T.
319:             .Themes          = .F.
320:             .SpecialEffect   = 0
321:             .MousePointer    = 15
322:             .WordWrap        = .T.
323:             .AutoSize        = .F.
324:             .Visible         = .T.
325:         ENDWITH
326: 
327:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
328: 
329:         *-- Grid da lista: 3 colunas do original (Grupos=80, Codigos=150, Descrs=290)
330:         *-- ColumnCount FORA do WITH (Problema 36)
331:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
332:         loc_oPagina.grd_4c_Lista.ColumnCount = 3
333: 
334:         WITH loc_oPagina.grd_4c_Lista
335:             .Top                = 126
336:             .Left               = 31
337:             .Width              = 937
338:             .Height             = 489
339:             .FontName           = "Verdana"
340:             .FontSize           = 8
341:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 360 a 446:
360:     *==========================================================================
361:     * ConfigurarPaginaDados - Estrutura da Page2 (Dados)
362:     * cnt_4c_Salva com botoes Confirmar + Cancelar
363:     * Fases 5-6 adicionam: Labels, TextBoxes e CheckBoxes
364:     *==========================================================================
365:     PROTECTED PROCEDURE ConfigurarPaginaDados()
366:         LOCAL loc_oPagina
367:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
368: 
369:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
370:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
371: 
372:         *-- Container botoes acao (Confirmar + Cancelar)
373:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
374:         WITH loc_oPagina.cnt_4c_Salva
375:             .Top         = 33
376:             .Left        = 842
377:             .Width       = 160
378:             .Height      = 85
379:             .BackStyle   = 0
380:             .Visible     = .T.
381:         ENDWITH
382: 
383:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
384:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
385:             .Caption         = "Confirmar"
386:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
387:             .PicturePosition = 13
388:             .Top             = 5
389:             .Left            = 5
390:             .Width           = 75
391:             .Height          = 75
392:             .BackColor       = RGB(255, 255, 255)
393:             .ForeColor       = RGB(90, 90, 90)
394:             .FontName        = "Comic Sans MS"
395:             .FontSize        = 8
396:             .FontBold        = .T.
397:             .FontItalic      = .T.
398:             .Themes          = .F.
399:             .SpecialEffect   = 0
400:             .MousePointer    = 15
401:             .WordWrap        = .T.
402:             .AutoSize        = .F.
403:             .Enabled         = .F.
404:             .Visible         = .T.
405:         ENDWITH
406: 
407:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
408:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
409:             .Caption         = "Encerrar"
410:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
411:             .PicturePosition = 13
412:             .Top             = 5
413:             .Left            = 80
414:             .Width           = 75
415:             .Height          = 75
416:             .BackColor       = RGB(255, 255, 255)
417:             .ForeColor       = RGB(90, 90, 90)
418:             .FontName        = "Comic Sans MS"
419:             .FontSize        = 8
420:             .FontBold        = .T.
421:             .FontItalic      = .T.
422:             .Themes          = .F.
423:             .SpecialEffect   = 0
424:             .MousePointer    = 15
425:             .WordWrap        = .T.
426:             .AutoSize        = .F.
427:             .Visible         = .T.
428:         ENDWITH
429: 
430:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
431:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
432: 
433:         *-- ===== FASE 5: Labels + TextBoxes (Codigos e Descrs) =====
434:         *-- Compensacao PageFrame: Top_original + 29
435: 
436:         *-- Label: Codigo (Say1 original: Top=174, Left=297, ForeColor=90,90,90)
437:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
438:         WITH loc_oPagina.lbl_4c_Label1
439:             .Caption   = "C" + CHR(243) + "digo :"
440:             .Top       = 203
441:             .Left      = 297
442:             .Width     = 44
443:             .Height    = 17
444:             .FontName  = "Tahoma"
445:             .FontSize  = 8
446:             .FontBold  = .F.

*-- Linhas 455 a 464:
455:         loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
456:         WITH loc_oPagina.txt_4c_Codigos
457:             .Value         = ""
458:             .Top           = 200
459:             .Left          = 341
460:             .Width         = 150
461:             .Height        = 23
462:             .FontName      = "Tahoma"
463:             .FontSize      = 8
464:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 472 a 484:
472:         ENDWITH
473: 
474:         *-- Label: Descricao (Say2 original: Top=201, Left=284, ForeColor=90,90,90)
475:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
476:         WITH loc_oPagina.lbl_4c_Label2
477:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
478:             .Top       = 230
479:             .Left      = 284
480:             .Width     = 57
481:             .Height    = 17
482:             .FontName  = "Tahoma"
483:             .FontSize  = 8
484:             .FontBold  = .F.

*-- Linhas 493 a 502:
493:         loc_oPagina.AddObject("txt_4c_Descrs", "TextBox")
494:         WITH loc_oPagina.txt_4c_Descrs
495:             .Value         = ""
496:             .Top           = 227
497:             .Left          = 341
498:             .Width         = 290
499:             .Height        = 23
500:             .FontName      = "Tahoma"
501:             .FontSize      = 8
502:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 510 a 522:
510:         ENDWITH
511: 
512:         *-- Label: Grupo (Say3 original: Top=228, Left=301, ForeColor=90,90,90)
513:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
514:         WITH loc_oPagina.lbl_4c_Label3
515:             .Caption   = "Grupo :"
516:             .Top       = 257
517:             .Left      = 301
518:             .Width     = 40
519:             .Height    = 17
520:             .FontName  = "Tahoma"
521:             .FontSize  = 8
522:             .FontBold  = .F.

*-- Linhas 531 a 540:
531:         loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
532:         WITH loc_oPagina.txt_4c_Grupo
533:             .Value         = ""
534:             .Top           = 254
535:             .Left          = 341
536:             .Width         = 80
537:             .Height        = 23
538:             .FontName      = "Tahoma"
539:             .FontSize      = 8
540:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 552 a 561:
552:         loc_oPagina.AddObject("txt_4c_DGrupos", "TextBox")
553:         WITH loc_oPagina.txt_4c_DGrupos
554:             .Value         = ""
555:             .Top           = 254
556:             .Left          = 425
557:             .Width         = 290
558:             .Height        = 23
559:             .FontName      = "Tahoma"
560:             .FontSize      = 8
561:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 568 a 581:
568:             .Visible       = .T.
569:         ENDWITH
570: 
571:         *-- CheckBox: Lock (Check1: graphical style=1, Top=159+29=188, Left=494, 35x35)
572:         loc_oPagina.AddObject("chk_4c_Check1", "CheckBox")
573:         WITH loc_oPagina.chk_4c_Check1
574:             .Caption       = ""
575:             .Top           = 188
576:             .Left          = 494
577:             .Height        = 35
578:             .Width         = 35
579:             .Style         = 1
580:             .Picture       = gc_4c_CaminhoIcones + "geral_lock_on_34.jpg"
581:             .Alignment     = 0

*-- Linhas 588 a 601:
588:             .Visible       = .T.
589:         ENDWITH
590: 
591:         *-- CheckBox: Automatico (chkAuto: Top=174+29=203, Left=535)
592:         loc_oPagina.AddObject("chk_4c_ChkAuto", "CheckBox")
593:         WITH loc_oPagina.chk_4c_ChkAuto
594:             .Caption       = "Autom" + CHR(225) + "tico"
595:             .Top           = 203
596:             .Left          = 535
597:             .Height        = 17
598:             .Width         = 80
599:             .FontName      = "Tahoma"
600:             .FontSize      = 8
601:             .FontBold      = .F.

*-- Linhas 608 a 621:
608:             .Visible       = .T.
609:         ENDWITH
610: 
611:         *-- CheckBox: Bloquear Alteracoes (chkBloqueios: Top=256+29=285, Left=341)
612:         loc_oPagina.AddObject("chk_4c_ChkBloqueios", "CheckBox")
613:         WITH loc_oPagina.chk_4c_ChkBloqueios
614:             .Caption       = "Bloquear Altera" + CHR(231) + CHR(245) + "es"
615:             .Top           = 285
616:             .Left          = 341
617:             .Height        = 17
618:             .Width         = 120
619:             .FontName      = "Tahoma"
620:             .FontSize      = 8
621:             .FontBold      = .F.

*-- Linhas 628 a 641:
628:             .Visible       = .T.
629:         ENDWITH
630: 
631:         *-- CheckBox: Lancamento Obrigatorio (chkObrigs: Top=279+29=308, Left=341)
632:         loc_oPagina.AddObject("chk_4c_ChkObrigs", "CheckBox")
633:         WITH loc_oPagina.chk_4c_ChkObrigs
634:             .Caption       = "Lan" + CHR(231) + "amento Obrigat" + CHR(243) + "rio"
635:             .Top           = 308
636:             .Left          = 341
637:             .Height        = 17
638:             .Width         = 140
639:             .FontName      = "Tahoma"
640:             .FontSize      = 8
641:             .FontBold      = .F.

*-- Linhas 689 a 699:
689:                             loc_oGrid.Column3.Width = 290
690: 
691:                             *-- Headers OBRIGATORIO apos RecordSource (Problema 2 / Problema 32)
692:                             loc_oGrid.Column1.Header1.Caption = "Grupo"
693:                             loc_oGrid.Column2.Header1.Caption = "C" + CHR(243) + "digo"
694:                             loc_oGrid.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
695: 
696:                             THIS.FormatarGridLista(loc_oGrid)
697:                         ENDIF
698:                         loc_lSucesso = .T.
699:                     ENDIF

*-- Linhas 949 a 958:
949:             loc_oPag2.chk_4c_Check1.Enabled = par_lHabilitar
950:         ENDIF
951:         IF PEMSTATUS(loc_oPag2, "cnt_4c_Salva", 5)
952:             loc_oPag2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = par_lHabilitar
953:             loc_oPag2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
954:         ENDIF
955:     ENDPROC
956: 
957:     *==========================================================================
958:     * BOParaForm - Transfere dados do BO para os campos da Page2

*-- Linhas 1229 a 1244:
1229: 
1230:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Botoes", 5)
1231:             loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
1232:             IF PEMSTATUS(loc_oCnt, "cmd_4c_Visualizar", 5)
1233:                 loc_oCnt.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
1234:             ENDIF
1235:             IF PEMSTATUS(loc_oCnt, "cmd_4c_Alterar", 5)
1236:                 loc_oCnt.cmd_4c_Alterar.Enabled = loc_lTemRegistro
1237:             ENDIF
1238:             IF PEMSTATUS(loc_oCnt, "cmd_4c_Excluir", 5)
1239:                 loc_oCnt.cmd_4c_Excluir.Enabled = loc_lTemRegistro
1240:             ENDIF
1241:         ENDIF
1242:     ENDPROC
1243: 
1244:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)


### BO (C:\4c\projeto\app\classes\CRCBO.prg):
*==============================================================================
* CRCBO.prg - Business Object: Caracteristicas de Contas (SigCrRac)
*==============================================================================
* Tarefa   : task382 - Migracao de SIGCDCRC
* Tabela   : SigCrRac
* PK       : Codigos  (char 20)
*==============================================================================

DEFINE CLASS CRCBO AS BusinessBase

    *-- ----------------------------------------------------------------
    *-- Campos da tabela SigCrRac
    *-- ----------------------------------------------------------------
    this_cCodigos   = ""    && codigos   char(20)  PK
    this_cDescrs    = ""    && descrs    char(40)
    this_cGrupos    = ""    && grupos    char(10)  FK -> SigCdGcr.Codigos
    this_nAutos     = 0     && autos     numeric(1,0)
    this_nLocks     = 0     && locks     numeric(1,0)
    this_nBloqueios = 0     && bloqueios numeric(1,0)
    this_nObrigs    = 0     && obrigs    numeric(1,0)
    this_nCodobs    = 0     && codobs    numeric(3,0)
    this_dDtInis    = {}    && dtinis    datetime NULL
    this_dDtFins    = {}    && dtfins    datetime NULL
    this_nOrdems    = 0     && ordems    numeric(3,0)
    this_cRelacs    = ""    && relacs    char(30)
    this_nTipoops   = 0     && tipoops   numeric(2,0)
    this_nTpprocs   = 0     && tpprocs   numeric(2,0)

    *-- Campo auxiliar de UI (descricao do grupo - vem de SigCdGcr.Descrs, nao persiste)
    this_cDGrupos   = ""

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo-chave do BusinessBase
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCrRac"
        THIS.this_cCampoChave = "Codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para o sistema de auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigos)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigos   = TratarNulo(codigos,   "C")
                THIS.this_cDescrs    = TratarNulo(descrs,    "C")
                THIS.this_cGrupos    = TratarNulo(grupos,    "C")
                THIS.this_nAutos     = TratarNulo(autos,     "N")
                THIS.this_nLocks     = TratarNulo(locks,     "N")
                THIS.this_nBloqueios = TratarNulo(bloqueios, "N")
                THIS.this_nObrigs    = TratarNulo(obrigs,    "N")
                THIS.this_nCodobs    = TratarNulo(codobs,    "N")
                THIS.this_dDtInis    = TratarNulo(dtinis,    "T")
                THIS.this_dDtFins    = TratarNulo(dtfins,    "T")
                THIS.this_nOrdems    = TratarNulo(ordems,    "N")
                THIS.this_cRelacs    = TratarNulo(relacs,    "C")
                THIS.this_nTipoops   = TratarNulo(tipoops,   "N")
                THIS.this_nTpprocs   = TratarNulo(tpprocs,   "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "CRCBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido, loc_nResultado, loc_cSQL
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCodigos)
            MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido!")
            loc_lValido = .F.
            RETURN loc_lValido
        ENDIF

        IF EMPTY(THIS.this_cDescrs)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!")
            loc_lValido = .F.
            RETURN loc_lValido
        ENDIF

        *-- Verificar duplicidade de Codigos (apenas no INSERT)
        IF THIS.this_lNovoRegistro
            TRY
                loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCrRac" + ;
                    " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")
                IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
                    SELECT cursor_4c_ChkCod
                    IF cursor_4c_ChkCod.qtd > 0
                        MsgAviso("C" + CHR(243) + "digo da Caracter" + CHR(237) + "stica J" + CHR(225) + " Cadastrado!!!")
                        loc_lValido = .F.
                    ENDIF
                    USE IN cursor_4c_ChkCod
                ENDIF
            CATCH TO loException
                MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "CRCBO.ValidarDados")
                loc_lValido = .F.
            ENDTRY
        ENDIF

        IF !loc_lValido
            RETURN loc_lValido
        ENDIF

        *-- Verificar duplicidade de Descrs (INSERT e UPDATE - exceto o proprio registro)
        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCrRac" + ;
                " WHERE descrs = " + EscaparSQL(THIS.this_cDescrs)
            IF !THIS.this_lNovoRegistro
                loc_cSQL = loc_cSQL + " AND codigos <> " + EscaparSQL(THIS.this_cCodigos)
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDesc")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkDesc")
                SELECT cursor_4c_ChkDesc
                IF cursor_4c_ChkDesc.qtd > 0
                    MsgAviso("Descri" + CHR(231) + CHR(227) + "o da Caracter" + CHR(237) + "stica J" + CHR(225) + " Cadastrada!!!")
                    loc_lValido = .F.
                ENDIF
                USE IN cursor_4c_ChkDesc
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar descri" + CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, "CRCBO.ValidarDados")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCrRac
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCrRac (codigos, descrs, grupos, autos, locks, bloqueios, obrigs, codobs, dtinis, dtfins, ordems, relacs, tipoops, tpprocs)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigos)>>,
                    <<EscaparSQL(THIS.this_cDescrs)>>,
                    <<EscaparSQL(THIS.this_cGrupos)>>,
                    <<FormatarNumeroSQL(THIS.this_nAutos,     0)>>,
                    <<FormatarNumeroSQL(THIS.this_nLocks,     0)>>,
                    <<FormatarNumeroSQL(THIS.this_nBloqueios, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nObrigs,    0)>>,
                    <<FormatarNumeroSQL(THIS.this_nCodobs,    0)>>,
                    <<IIF(EMPTY(THIS.this_dDtInis), "NULL", FormatarDataSQL(THIS.this_dDtInis))>>,
                    <<IIF(EMPTY(THIS.this_dDtFins), "NULL", FormatarDataSQL(THIS.this_dDtFins))>>,
                    <<FormatarNumeroSQL(THIS.this_nOrdems,    0)>>,
                    <<EscaparSQL(THIS.this_cRelacs)>>,
                    <<FormatarNumeroSQL(THIS.this_nTipoops,   0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTpprocs,   0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir caracteristica de conta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "CRCBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigCrRac
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCrRac
                SET descrs    = <<EscaparSQL(THIS.this_cDescrs)>>,
                    grupos    = <<EscaparSQL(THIS.this_cGrupos)>>,
                    autos     = <<FormatarNumeroSQL(THIS.this_nAutos,     0)>>,
                    locks     = <<FormatarNumeroSQL(THIS.this_nLocks,     0)>>,
                    bloqueios = <<FormatarNumeroSQL(THIS.this_nBloqueios, 0)>>,
                    obrigs    = <<FormatarNumeroSQL(THIS.this_nObrigs,    0)>>,
                    codobs    = <<FormatarNumeroSQL(THIS.this_nCodobs,    0)>>,
                    dtinis    = <<IIF(EMPTY(THIS.this_dDtInis), "NULL", FormatarDataSQL(THIS.this_dDtInis))>>,
                    dtfins    = <<IIF(EMPTY(THIS.this_dDtFins), "NULL", FormatarDataSQL(THIS.this_dDtFins))>>,
                    ordems    = <<FormatarNumeroSQL(THIS.this_nOrdems,    0)>>,
                    relacs    = <<EscaparSQL(THIS.this_cRelacs)>>,
                    tipoops   = <<FormatarNumeroSQL(THIS.this_nTipoops,   0)>>,
                    tpprocs   = <<FormatarNumeroSQL(THIS.this_nTpprocs,   0)>>
                WHERE codigos = <<EscaparSQL(THIS.this_cCodigos)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar caracteristica de conta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "CRCBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigCrRac
    * Verifica uso em SigClCrc antes de excluir
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nUso
        loc_lSucesso = .F.

        TRY
            *-- Verificar se a caracteristica esta sendo utilizada em SigClCrc
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigClCrc" + ;
                " WHERE Caracteris = " + EscaparSQL(THIS.this_cCodigos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCrc")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCrc")
                SELECT cursor_4c_ChkCrc
                loc_nUso = cursor_4c_ChkCrc.qtd
                USE IN cursor_4c_ChkCrc
                IF loc_nUso > 0
                    MsgAviso("Caracter" + CHR(237) + "stica Sendo Utilizada!!!")
                    loc_lSucesso = .F.
                ELSE
                    loc_cSQL = "DELETE FROM SigCrRac WHERE codigos = " + ;
                        EscaparSQL(THIS.this_cCodigos)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResultado >= 0
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao excluir caracteristica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ELSE
                MostrarErro("Erro ao verificar depend" + CHR(234) + "ncias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "CRCBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros para o grid da Page1
    * Grid original: Grupos(80), Codigos(150), Descrs(290)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (grupos C(10), codigos C(20), descrs C(40))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT grupos, codigos, descrs FROM SigCrRac"

                IF !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY codigos"

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
                        MostrarErro("Erro ao buscar caracteristicas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar caracteristicas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "CRCBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria (codigos)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descrs, grupos, autos, locks, bloqueios, obrigs," + ;
                " codobs, dtinis, dtfins, ordems, relacs, tipoops, tpprocs" + ;
                " FROM SigCrRac WHERE codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Caracteristica n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar caracteristica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "CRCBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarDescricaoGrupo - Busca descricao de grupo em SigCdGcr pelo codigo
    * Substitui fAcessoContab(Usuar, 'C', ...) do legado
    *--------------------------------------------------------------------------
    PROCEDURE BuscarDescricaoGrupo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_cDescricao
        loc_cDescricao = ""

        TRY
            IF !EMPTY(par_cCodigo)
                loc_cSQL = "SELECT descrs FROM SigCdGcr" + ;
                    " WHERE codigos = " + EscaparSQL(par_cCodigo)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrp")
                IF loc_nResultado >= 0 AND USED("cursor_4c_BuscaGrp")
                    IF !EOF("cursor_4c_BuscaGrp")
                        SELECT cursor_4c_BuscaGrp
                        loc_cDescricao = ALLTRIM(cursor_4c_BuscaGrp.descrs)
                    ENDIF
                    USE IN cursor_4c_BuscaGrp
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao buscar grupo:" + CHR(13) + loException.Message, "CRCBO.BuscarDescricaoGrupo")
        ENDTRY

        RETURN loc_cDescricao
    ENDPROC

ENDDEFINE

