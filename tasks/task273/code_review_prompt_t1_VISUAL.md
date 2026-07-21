# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 215: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 239: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 263: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 287: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 311: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 484: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 508: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 970: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSigPrCtr.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (3779 linhas total):

*-- Linhas 77 a 89:
77: 
78:                 *-- Propaga Caption para labels do cabecalho
79:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Cabecalho", 5)
80:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho, "lbl_4c_Sombra", 5)
81:                         THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
82:                     ENDIF
83:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho, "lbl_4c_Titulo", 5)
84:                         THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
85:                     ENDIF
86:                 ENDIF
87: 
88:                 THIS.CarregarLista()
89: 

*-- Linhas 113 a 347:
113: 
114:         WITH THIS.pgf_4c_Paginas
115:             .PageCount = 2
116:             .Top       = -29
117:             .Left      = 0
118:             .Width     = THIS.Width
119:             .Height    = THIS.Height + 29
120:             .Tabs      = .F.
121:         ENDWITH
122: 
123:         THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
124:         THIS.pgf_4c_Paginas.Page1.BackColor = RGB(255, 255, 255)
125:         THIS.pgf_4c_Paginas.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
126: 
127:         THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
128:         THIS.pgf_4c_Paginas.Page2.BackColor = RGB(255, 255, 255)
129:         THIS.pgf_4c_Paginas.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
130:     ENDPROC
131: 
132:     *--------------------------------------------------------------------------
133:     * ConfigurarPaginaLista - Containers da Page1 (Lista)
134:     * cnt_4c_Cabecalho : barra cinza escura com titulo
135:     * cnt_4c_Botoes    : container CRUD - botoes adicionados na Fase 4
136:     * cnt_4c_Saida     : container canonico com cmd_4c_Encerrar
137:     * Grid e filtros de data sao adicionados na Fase 4
138:     *--------------------------------------------------------------------------
139:     PROTECTED PROCEDURE ConfigurarPaginaLista()
140:         LOCAL loc_oPagina
141:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
142: 
143:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
144:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
145: 
146:         *-- Container cabecalho (cntSombra do legado: Top=2+29=31)
147:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
148:         WITH loc_oPagina.cnt_4c_Cabecalho
149:             .Top         = 31
150:             .Left        = 0
151:             .Width       = THIS.Width
152:             .Height      = 80
153:             .BackColor   = RGB(100, 100, 100)
154:             .BorderWidth = 0
155:             .Visible     = .T.
156:         ENDWITH
157: 
158:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
159:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
160:             .AutoSize  = .F.
161:             .Caption   = THIS.Caption
162:             .Top       = 15
163:             .Left      = 10
164:             .Width     = THIS.Width - 20
165:             .Height    = 40
166:             .FontName  = "Tahoma"
167:             .FontSize  = 16
168:             .FontBold  = .T.
169:             .ForeColor = RGB(0, 0, 0)
170:             .BackStyle = 0
171:             .Visible   = .T.
172:         ENDWITH
173: 
174:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
175:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
176:             .AutoSize  = .F.
177:             .Caption   = THIS.Caption
178:             .Top       = 18
179:             .Left      = 10
180:             .Width     = THIS.Width - 20
181:             .Height    = 46
182:             .FontName  = "Tahoma"
183:             .FontSize  = 16
184:             .FontBold  = .T.
185:             .ForeColor = RGB(255, 255, 255)
186:             .BackStyle = 0
187:             .Visible   = .T.
188:         ENDWITH
189: 
190:         *-- Container botoes CRUD (Grupo_Op: Left escalonado para 1200px)
191:         *-- Original Grupo_Op.Left = 542 em form 1000px; adaptado: 742 em 1200px
192:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
193:         WITH loc_oPagina.cnt_4c_Botoes
194:             .Top         = 29
195:             .Left        =  542
196:             .Width       = 390
197:             .Height      = 85
198:             .BackStyle = 0
199:             .BorderWidth = 0
200:             .Visible     = .T.
201:         ENDWITH
202: 
203:         *-- 5 botoes CRUD dentro de cnt_4c_Botoes
204:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
205:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
206:             .Caption = "Incluir"
207:             .Picture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
208:             .PicturePosition = 13
209:             .Top = 5
210:             .Left = 5
211:             .Width = 75
212:             .Height = 75
213:             .BackColor = RGB(255,255,255)
214:             .ForeColor = RGB(90,90,90)
215:             .FontName = "Comic Sans MS"
216:             .FontSize = 8
217:             .FontBold = .T.
218:             .FontItalic = .T.
219:             .Themes = .F.
220:             .SpecialEffect = 0
221:             .MousePointer = 15
222:             .WordWrap = .T.
223:             .AutoSize = .F.
224:             .Visible = .T.
225:         ENDWITH
226:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
227: 
228:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
229:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
230:             .Caption = "Visualizar"
231:             .Picture = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
232:             .PicturePosition = 13
233:             .Top = 5
234:             .Left = 80
235:             .Width = 75
236:             .Height = 75
237:             .BackColor = RGB(255,255,255)
238:             .ForeColor = RGB(90,90,90)
239:             .FontName = "Comic Sans MS"
240:             .FontSize = 8
241:             .FontBold = .T.
242:             .FontItalic = .T.
243:             .Themes = .F.
244:             .SpecialEffect = 0
245:             .MousePointer = 15
246:             .WordWrap = .T.
247:             .AutoSize = .F.
248:             .Visible = .T.
249:         ENDWITH
250:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
251: 
252:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
253:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
254:             .Caption = "Alterar"
255:             .Picture = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
256:             .PicturePosition = 13
257:             .Top = 5
258:             .Left = 155
259:             .Width = 75
260:             .Height = 75
261:             .BackColor = RGB(255,255,255)
262:             .ForeColor = RGB(90,90,90)
263:             .FontName = "Comic Sans MS"
264:             .FontSize = 8
265:             .FontBold = .T.
266:             .FontItalic = .T.
267:             .Themes = .F.
268:             .SpecialEffect = 0
269:             .MousePointer = 15
270:             .WordWrap = .T.
271:             .AutoSize = .F.
272:             .Visible = .T.
273:         ENDWITH
274:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
275: 
276:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
277:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
278:             .Caption = "Excluir"
279:             .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
280:             .PicturePosition = 13
281:             .Top = 5
282:             .Left = 230
283:             .Width = 75
284:             .Height = 75
285:             .BackColor = RGB(255,255,255)
286:             .ForeColor = RGB(90,90,90)
287:             .FontName = "Comic Sans MS"
288:             .FontSize = 8
289:             .FontBold = .T.
290:             .FontItalic = .T.
291:             .Themes = .F.
292:             .SpecialEffect = 0
293:             .MousePointer = 15
294:             .WordWrap = .T.
295:             .AutoSize = .F.
296:             .Visible = .T.
297:         ENDWITH
298:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
299: 
300:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
301:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
302:             .Caption = "Buscar"
303:             .Picture = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
304:             .PicturePosition = 13
305:             .Top = 5
306:             .Left = 305
307:             .Width = 75
308:             .Height = 75
309:             .BackColor = RGB(255,255,255)
310:             .ForeColor = RGB(90,90,90)
311:             .FontName = "Comic Sans MS"
312:             .FontSize = 8
313:             .FontBold = .T.
314:             .FontItalic = .T.
315:             .Themes = .F.
316:             .SpecialEffect = 0
317:             .MousePointer = 15
318:             .WordWrap = .T.
319:             .AutoSize = .F.
320:             .Visible = .T.
321:         ENDWITH
322:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
323: 
324:         *-- Container de saida canonico: Left = THIS.Width - 83 = 1117
325:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
326:         WITH loc_oPagina.cnt_4c_Saida
327:             .Top         = 29
328:             .Left        = 917
329:             .Width       = 90
330:             .Height      = 85
331:             .BackStyle   = 0
332:             .BorderWidth = 0
333:             .Visible     = .T.
334:         ENDWITH
335: 
336:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
337:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
338:             .Caption         = "Encerrar"
339:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
340:             .PicturePosition = 13
341:             .Top = 5
342:             .Left = 5
343:             .Width = 75
344:             .Height = 75
345:             .BackColor = RGB(255,255,255)
346:             .ForeColor = RGB(90,90,90)
347:             .FontName = "Tahoma"

*-- Linhas 355 a 423:
355:             .AutoSize = .F.
356:             .Visible = .T.
357:         ENDWITH
358:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
359: 
360:         *-- Filtros de data (original: Dt_inicial top=102, left=495; Dt_final top=102, left=598)
361:         *-- Compensacao PageFrame +29: top=131
362:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
363:         WITH loc_oPagina.lbl_4c_Label1
364:             .Caption  = "\<Per" + CHR(237) + "odo :"
365:             .Top = 135
366:             .Left = 440
367:             .Width = 52
368:             .Height = 15
369:             .FontName = "Tahoma"
370:             .FontSize = 8
371:             .Visible  = .T.
372:         ENDWITH
373: 
374:         loc_oPagina.AddObject("txt_4c_DtInicial", "TextBox")
375:         WITH loc_oPagina.txt_4c_DtInicial
376:             .Value  = DATE()
377:             .Format = "D"
378:             .Top = 131
379:             .Left = 495
380:             .Width = 80
381:             .Height = 21
382:             .FontName = "Tahoma"
383:             .FontSize = 8
384:             .Visible = .T.
385:         ENDWITH
386:         BINDEVENT(loc_oPagina.txt_4c_DtInicial, "KeyPress", THIS, "DtInicialLostFocus")
387: 
388:         loc_oPagina.AddObject("lbl_4c_Sep", "Label")
389:         WITH loc_oPagina.lbl_4c_Sep
390:             .Caption  = "-"
391:             .Top = 135
392:             .Left = 578
393:             .Width = 15
394:             .Height = 15
395:             .FontName = "Tahoma"
396:             .FontSize = 8
397:             .Visible  = .T.
398:         ENDWITH
399: 
400:         loc_oPagina.AddObject("txt_4c_DtFinal", "TextBox")
401:         WITH loc_oPagina.txt_4c_DtFinal
402:             .Value  = DATE()
403:             .Format = "D"
404:             .Top = 131
405:             .Left = 598
406:             .Width = 80
407:             .Height = 21
408:             .FontName = "Tahoma"
409:             .FontSize = 8
410:             .Visible = .T.
411:         ENDWITH
412:         BINDEVENT(loc_oPagina.txt_4c_DtFinal, "KeyPress", THIS, "DtFinalLostFocus")
413: 
414:         *-- Grid de lista de lotes - abaixo dos filtros de data
415:         *-- ColumnCount ANTES do WITH para que Column1..N existam no bloco
416:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
417:         loc_oPagina.grd_4c_Dados.Top         = 155
418:         loc_oPagina.grd_4c_Dados.Left        = 12
419:         loc_oPagina.grd_4c_Dados.Width       = 1100
420:         loc_oPagina.grd_4c_Dados.Height      = 430
421:         loc_oPagina.grd_4c_Dados.ColumnCount = 6
422:         WITH loc_oPagina.grd_4c_Dados
423:             .FontName           = "Verdana"

*-- Linhas 462 a 567:
462:         *-- Container botoes Confirmar/Cancelar (canonico: Top=4+29=33, Left=1042)
463:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
464:         WITH loc_oPagina.cnt_4c_BotoesAcao
465:             .Top         = 33
466:             .Left        = 1042
467:             .Width       = 160
468:             .Height      = 85
469:             .BackStyle   = 0
470:             .Visible     = .T.
471:         ENDWITH
472: 
473:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
474:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
475:             .Caption = "Confirmar"
476:             .Picture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
477:             .PicturePosition = 13
478:             .Top = 5
479:             .Left = 5
480:             .Width = 75
481:             .Height = 75
482:             .BackColor = RGB(255,255,255)
483:             .ForeColor = RGB(90,90,90)
484:             .FontName = "Comic Sans MS"
485:             .FontSize = 8
486:             .FontBold = .T.
487:             .FontItalic = .T.
488:             .Themes = .F.
489:             .SpecialEffect = 0
490:             .MousePointer = 15
491:             .WordWrap = .T.
492:             .AutoSize = .F.
493:             .Visible = .T.
494:         ENDWITH
495:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
496: 
497:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
498:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
499:             .Caption = "Encerrar"
500:             .Picture = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
501:             .PicturePosition = 13
502:             .Top = 5
503:             .Left = 80
504:             .Width = 75
505:             .Height = 75
506:             .BackColor = RGB(255,255,255)
507:             .ForeColor = RGB(90,90,90)
508:             .FontName = "Comic Sans MS"
509:             .FontSize = 8
510:             .FontBold = .T.
511:             .FontItalic = .T.
512:             .Themes = .F.
513:             .SpecialEffect = 0
514:             .MousePointer = 15
515:             .WordWrap = .T.
516:             .AutoSize = .F.
517:             .Visible = .T.
518:         ENDWITH
519:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
520: 
521:         *-- PageFrame interno (Pageframe1 do legado: top=3+29=32, left=-1)
522:         loc_oPagina.AddObject("pgf_4c_Dados", "PageFrame")
523:         WITH loc_oPagina.pgf_4c_Dados
524:             .PageCount = 2
525:             .Top       = 32
526:             .Left      = -1
527:             .Width     = THIS.Width + 1
528:             .Height    = 617
529:             .Tabs      = .F.
530:         ENDWITH
531: 
532:         loc_oPagina.pgf_4c_Dados.Page1.Caption   = "Lote"
533:         loc_oPagina.pgf_4c_Dados.Page1.BackColor = RGB(255, 255, 255)
534: 
535:         loc_oPagina.pgf_4c_Dados.Page2.Caption   = "Itens"
536:         loc_oPagina.pgf_4c_Dados.Page2.BackColor = RGB(255, 255, 255)
537: 
538:         THIS.ConfigurarPaginaDadosLote()
539:         THIS.ConfigurarPaginaDadosDetalhe()
540:         THIS.TornarControlesVisiveis(loc_oPagina)
541:     ENDPROC
542: 
543:     *--------------------------------------------------------------------------
544:     * ConfigurarPaginaDadosLote - Controles do pgf_4c_Dados.Page1 (Lote)
545:     * Campos do lote: Grupo, Conta, Dconta, Cpf, Moeda, Arquivo
546:     * OptionGroups: opt_4c_Custo (2 botoes), opt_4c_Fil (3 botoes)
547:     * Botoes: cmd_4c_Processar, cmd_4c_BotConsulta, cmd_4c_BtnCadastros,
548:     *         cmd_4c_Command12, cmd_4c_CmdOperacao (CommandGroup)
549:     * Grid: grd_4c_Estoque (5 colunas: Empresa, Movimentacao, Numero, Grupo, Conta)
550:     * Offset +29 em Top para compensar aba oculta do inner PageFrame
551:     *--------------------------------------------------------------------------
552:     PROTECTED PROCEDURE ConfigurarPaginaDadosLote()
553:         LOCAL loc_oPg2P1
554:         loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
555: 
556:         *-- Label: Fornecedores (Say4: top=69+29=98)
557:         loc_oPg2P1.AddObject("lbl_4c_Forn", "Label")
558:         WITH loc_oPg2P1.lbl_4c_Forn
559:             .Caption   = "Fornecedores :"
560:             .AutoSize  = .T.
561:             .Top = 98
562:             .Left = 228
563:             .Height = 15
564:             .FontName  = "Tahoma"
565:             .FontSize = 8
566:             .BackStyle = 0
567:             .Visible = .T.

*-- Linhas 573 a 582:
573:             .Value = ""
574:             .MaxLength = 10
575:             .Format = "K"
576:             .Top = 95
577:             .Left = 307
578:             .Width = 85
579:             .Height = 21
580:             .FontName = "Tahoma"
581:             .FontSize = 8
582:             .SpecialEffect = 1

*-- Linhas 592 a 601:
592:             .Value = ""
593:             .MaxLength = 10
594:             .Format = "K"
595:             .Top = 95
596:             .Left = 394
597:             .Width = 85
598:             .Height = 21
599:             .FontName = "Tahoma"
600:             .FontSize = 8
601:             .SpecialEffect = 1

*-- Linhas 611 a 620:
611:             .Value = ""
612:             .MaxLength = 40
613:             .Format = "K"
614:             .Top = 118
615:             .Left = 307
616:             .Width = 357
617:             .Height = 21
618:             .FontName = "Tahoma"
619:             .FontSize = 8
620:             .SpecialEffect = 1

*-- Linhas 630 a 709:
630:             .Value = ""
631:             .MaxLength = 20
632:             .InputMask = "XXXXXXXXXXXXXXXXXXXX"
633:             .Top = 95
634:             .Left = 481
635:             .Width = 146
636:             .Height = 21
637:             .FontName = "Tahoma"
638:             .FontSize = 8
639:             .SpecialEffect = 1
640:             .Visible = .T.
641:         ENDWITH
642:         BINDEVENT(loc_oPg2P1.txt_4c_Cpf, "KeyPress", THIS, "TxtCpfLostFocus")
643: 
644:         *-- Label: Precificacao (Say1: top=114+29=143)
645:         loc_oPg2P1.AddObject("lbl_4c_Precif", "Label")
646:         WITH loc_oPg2P1.lbl_4c_Precif
647:             .Caption   = "Precifica" + CHR(231) + CHR(227) + "o :"
648:             .AutoSize  = .T.
649:             .Top = 143
650:             .Left = 237
651:             .Height = 15
652:             .FontName  = "Tahoma"
653:             .FontSize = 8
654:             .BackStyle = 0
655:             .Visible = .T.
656:         ENDWITH
657: 
658:         *-- OptionGroup: Opt_Custo / opt_4c_Custo (top=113+29=142)
659:         *-- ButtonCount ANTES do WITH; .Value de Buttons(N) OMITIDO (regra anti-todos-marcados)
660:         loc_oPg2P1.AddObject("opt_4c_Custo", "OptionGroup")
661:         loc_oPg2P1.opt_4c_Custo.ButtonCount = 2
662:         loc_oPg2P1.opt_4c_Custo.Top         = 142
663:         loc_oPg2P1.opt_4c_Custo.Left        = 303
664:         loc_oPg2P1.opt_4c_Custo.Width       = 255
665:         loc_oPg2P1.opt_4c_Custo.Height      = 17
666:         WITH loc_oPg2P1.opt_4c_Custo
667:             .BackStyle   = 0
668:             .BorderStyle = 0
669:             .Visible = .T.
670:             WITH .Buttons(1)
671:                 .Caption   = "Custo Total"
672:                 .BackStyle = 0
673:                 .AutoSize  = .T.
674:                 .Top = 1
675:                 .Left = 5
676:                 .Height = 15
677:                 .Width = 73
678:                 .ForeColor = RGB(90, 90, 90)
679:                 .Themes = .F.
680:             ENDWITH
681:             WITH .Buttons(2)
682:                 .Caption   = "Custo pela Composi" + CHR(231) + CHR(227) + "o"
683:                 .FontName  = "Tahoma"
684:                 .FontSize = 8
685:                 .BackStyle = 0
686:                 .AutoSize = .T.
687:                 .Top = 1
688:                 .Left = 98
689:                 .Height = 15
690:                 .Width = 129
691:                 .ForeColor = RGB(90, 90, 90)
692:                 .Themes = .F.
693:             ENDWITH
694:             .Value = 1
695:         ENDWITH
696:         BINDEVENT(loc_oPg2P1.opt_4c_Custo, "InteractiveChange", THIS, "OptCustoInteractiveChange")
697: 
698:         *-- Label: Moeda (Say3: top=137+29=166)
699:         loc_oPg2P1.AddObject("lbl_4c_LoteMoeda", "Label")
700:         WITH loc_oPg2P1.lbl_4c_LoteMoeda
701:             .Caption   = "Moeda :"
702:             .AutoSize  = .T.
703:             .Top = 166
704:             .Left = 262
705:             .Height = 15
706:             .FontName  = "Tahoma"
707:             .FontSize = 8
708:             .BackStyle = 0
709:             .Visible = .T.

*-- Linhas 715 a 871:
715:             .Value = ""
716:             .MaxLength = 10
717:             .Format = "K"
718:             .Top = 163
719:             .Left = 307
720:             .Width = 85
721:             .Height = 21
722:             .FontName = "Tahoma"
723:             .FontSize = 8
724:             .SpecialEffect = 1
725:             .Visible = .T.
726:         ENDWITH
727:         BINDEVENT(loc_oPg2P1.txt_4c_Moeda, "KeyPress", THIS, "TxtMoedaLostFocus")
728:         BINDEVENT(loc_oPg2P1.txt_4c_Moeda, "KeyPress",  THIS, "TxtMoedaKeyPress")
729:         BINDEVENT(loc_oPg2P1.txt_4c_Moeda, "DblClick",  THIS, "TxtMoedaDblClick")
730: 
731:         *-- Label: Diretorio (Say2: top=160+29=189)
732:         loc_oPg2P1.AddObject("lbl_4c_Dir", "Label")
733:         WITH loc_oPg2P1.lbl_4c_Dir
734:             .Caption   = "Diret" + CHR(243) + "rio :"
735:             .AutoSize  = .T.
736:             .Top = 189
737:             .Left = 253
738:             .Height = 15
739:             .FontName  = "Tahoma"
740:             .FontSize = 8
741:             .BackStyle = 0
742:             .Visible = .T.
743:         ENDWITH
744: 
745:         *-- TextBox: Get_Arquivo / txt_4c_Arquivo - ReadOnly, preenchido por Command12
746:         loc_oPg2P1.AddObject("txt_4c_Arquivo", "TextBox")
747:         WITH loc_oPg2P1.txt_4c_Arquivo
748:             .Value = ""
749:             .MaxLength = 200
750:             .Top = 186
751:             .Left = 307
752:             .Width = 357
753:             .Height = 21
754:             .FontName = "Tahoma"
755:             .FontSize = 8
756:             .SpecialEffect = 1
757:             .ReadOnly = .T.
758:             .Visible = .T.
759:         ENDWITH
760: 
761:         *-- Button: Command12 / cmd_4c_Command12 - file picker (top=157+29=186)
762:         loc_oPg2P1.AddObject("cmd_4c_Command12", "CommandButton")
763:         WITH loc_oPg2P1.cmd_4c_Command12
764:             .Caption = "..."
765:             .Top = 186
766:             .Left = 667
767:             .Width = 20
768:             .Height = 20
769:             .FontName = "Tahoma"
770:             .FontSize = 8
771:             .SpecialEffect = 0
772:             .MousePointer = 15
773:             .Visible = .T.
774:         ENDWITH
775:         BINDEVENT(loc_oPg2P1.cmd_4c_Command12, "Click", THIS, "CmdCommand12Click")
776: 
777:         *-- Label: Carregar produtos... (Label1: top=184+29=213)
778:         loc_oPg2P1.AddObject("lbl_4c_Label1", "Label")
779:         WITH loc_oPg2P1.lbl_4c_Label1
780:             .Caption   = "Carregar produtos que constam nos XML" + CHR(39) + "s :"
781:             .FontBold  = .T.
782:             .AutoSize  = .T.
783:             .Top = 213
784:             .Left = 55
785:             .Width = 246
786:             .Height = 15
787:             .FontName  = "Tahoma"
788:             .FontSize = 8
789:             .BackStyle = 0
790:             .ForeColor = RGB(90, 90, 90)
791:             .Visible = .T.
792:         ENDWITH
793: 
794:         *-- OptionGroup: Opt_Fil / opt_4c_Fil (top=179+29=208)
795:         loc_oPg2P1.AddObject("opt_4c_Fil", "OptionGroup")
796:         loc_oPg2P1.opt_4c_Fil.ButtonCount = 3
797:         loc_oPg2P1.opt_4c_Fil.Top         = 208
798:         loc_oPg2P1.opt_4c_Fil.Left        = 303
799:         loc_oPg2P1.opt_4c_Fil.Width       = 192
800:         loc_oPg2P1.opt_4c_Fil.Height      = 24
801:         WITH loc_oPg2P1.opt_4c_Fil
802:             .BackStyle   = 0
803:             .BorderStyle = 0
804:             .Visible = .T.
805:             WITH .Buttons(1)
806:                 .Caption   = "Somente"
807:                 .BackStyle = 0
808:                 .AutoSize  = .T.
809:                 .Top = 5
810:                 .Left = 5
811:                 .Height = 15
812:                 .Width = 60
813:                 .ForeColor = RGB(90, 90, 90)
814:                 .Themes = .F.
815:             ENDWITH
816:             WITH .Buttons(2)
817:                 .Caption   = "N" + CHR(227) + "o"
818:                 .FontName  = "Tahoma"
819:                 .FontSize = 8
820:                 .BackStyle = 0
821:                 .AutoSize = .T.
822:                 .Top = 5
823:                 .Left = 84
824:                 .Height = 15
825:                 .Width = 37
826:                 .ForeColor = RGB(90, 90, 90)
827:                 .Themes = .F.
828:             ENDWITH
829:             WITH .Buttons(3)
830:                 .Caption   = "Ambos"
831:                 .FontName  = "Tahoma"
832:                 .FontSize = 8
833:                 .BackStyle = 0
834:                 .AutoSize = .T.
835:                 .Top = 5
836:                 .Left = 132
837:                 .Height = 15
838:                 .Width = 50
839:                 .ForeColor = RGB(90, 90, 90)
840:                 .Themes = .F.
841:             ENDWITH
842:             .Value = 1
843:         ENDWITH
844:         BINDEVENT(loc_oPg2P1.opt_4c_Fil, "InteractiveChange", THIS, "OptFilInteractiveChange")
845: 
846:         *-- Label: Movimentacoes (Say5: top=204+29=233)
847:         loc_oPg2P1.AddObject("lbl_4c_Movs", "Label")
848:         WITH loc_oPg2P1.lbl_4c_Movs
849:             .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es :"
850:             .FontBold  = .T.
851:             .AutoSize = .T.
852:             .Top = 233
853:             .Left = 203
854:             .Height = 15
855:             .FontName  = "Tahoma"
856:             .FontSize = 8
857:             .ForeColor = RGB(90, 90, 90)
858:             .BackStyle = 0
859:             .Visible = .T.
860:         ENDWITH
861: 
862:         *-- Grid: grdEstoque / grd_4c_Estoque (top=206+29=235)
863:         *-- ColumnCount OBRIGATORIAMENTE antes do WITH
864:         loc_oPg2P1.AddObject("grd_4c_Estoque", "Grid")
865:         loc_oPg2P1.grd_4c_Estoque.Top         = 235
866:         loc_oPg2P1.grd_4c_Estoque.Left        = 307
867:         loc_oPg2P1.grd_4c_Estoque.Width       = 545
868:         loc_oPg2P1.grd_4c_Estoque.Height      = 340
869:         loc_oPg2P1.grd_4c_Estoque.ColumnCount = 5
870:         WITH loc_oPg2P1.grd_4c_Estoque
871:             .FontName          = "Tahoma"

*-- Linhas 881 a 977:
881:             .ScrollBars        = 2
882:             .Visible           = .T.
883:             .Column1.Width = 70
884:             .Column1.Header1.Caption = "Empresa"
885:             .Column2.Width = 200
886:             .Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
887:             .Column3.Width = 80
888:             .Column3.Header1.Caption = "Numero"
889:             .Column4.Width = 80
890:             .Column4.Header1.Caption = "Grupo"
891:             .Column5.Width = 80
892:             .Column5.Header1.Caption = "Conta"
893:             .Column4.ReadOnly = .T.
894:             .Column5.ReadOnly = .T.
895:         ENDWITH
896: 
897:         *-- Button: Bot_Consulta / cmd_4c_BotConsulta (top=70+29=99, left=667)
898:         loc_oPg2P1.AddObject("cmd_4c_BotConsulta", "CommandButton")
899:         WITH loc_oPg2P1.cmd_4c_BotConsulta
900:             .Caption     = ""
901:             .Picture     = gc_4c_CaminhoIcones + "geral_calendario_26.jpg"
902:             .Top = 99
903:             .Left = 667
904:             .Width = 40
905:             .Height = 40
906:             .BackColor = RGB(255,255,255)
907:             .ForeColor = RGB(90,90,90)
908:             .SpecialEffect = 0
909:             .Themes = .F.
910:             .ToolTipText = "<F5> Faz a Consulta Gen" + CHR(233) + "rica de Vendas desta Conta..."
911:             .MousePointer = 15
912:             .Visible = .T.
913:         ENDWITH
914:         BINDEVENT(loc_oPg2P1.cmd_4c_BotConsulta, "Click", THIS, "CmdBotConsultaClick")
915: 
916:         *-- Button: btnCadastros / cmd_4c_BtnCadastros (top=70+29=99, left=708)
917:         loc_oPg2P1.AddObject("cmd_4c_BtnCadastros", "CommandButton")
918:         WITH loc_oPg2P1.cmd_4c_BtnCadastros
919:             .Caption     = ""
920:             .Picture     = gc_4c_CaminhoIcones + "geral_pastas_28.jpg"
921:             .Top = 99
922:             .Left = 708
923:             .Width = 40
924:             .Height = 40
925:             .BackColor = RGB(255,255,255)
926:             .ForeColor = RGB(90,90,90)
927:             .SpecialEffect = 0
928:             .Themes = .F.
929:             .ToolTipText = "<F3> Acessa o Cadastro Desta Conta"
930:             .MousePointer = 15
931:             .Visible = .T.
932:         ENDWITH
933:         BINDEVENT(loc_oPg2P1.cmd_4c_BtnCadastros, "Click", THIS, "CmdBtnCadastrosClick")
934: 
935:         *-- CommandGroup: cmdOperacao / cmd_4c_CmdOperacao (top=334+29=363)
936:         loc_oPg2P1.AddObject("cmd_4c_CmdOperacao", "CommandGroup")
937:         loc_oPg2P1.cmd_4c_CmdOperacao.ButtonCount = 1
938:         loc_oPg2P1.cmd_4c_CmdOperacao.Top         = 363
939:         loc_oPg2P1.cmd_4c_CmdOperacao.Left        = 857
940:         loc_oPg2P1.cmd_4c_CmdOperacao.Width       = 85
941:         loc_oPg2P1.cmd_4c_CmdOperacao.Height      = 85
942:         WITH loc_oPg2P1.cmd_4c_CmdOperacao
943:             .BackStyle   = 0
944:             .BorderStyle = 0
945:             .Themes = .F.
946:             .Visible = .T.
947:             WITH .Buttons(1)
948:                 .Top = 5
949:                 .Left = 5
950:                 .Height = 75
951:                 .Width = 75
952:                 .FontBold = .T.
953:                 .FontItalic = .T.
954:                 .Picture         = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
955:                 .Caption         = "Movimento"
956:                 .ToolTipText     = "Movimenta" + CHR(231) + CHR(227) + "o"
957:                 .PicturePosition = 13
958:                 .ForeColor = RGB(90, 90, 90)
959:                 .BackColor = RGB(255, 255, 255)
960:                 .Themes = .F.
961:             ENDWITH
962:         ENDWITH
963:         BINDEVENT(loc_oPg2P1.cmd_4c_CmdOperacao, "Click", THIS, "CmdOperacaoClick")
964: 
965:         *-- Button: processar / cmd_4c_Processar (top=7+29=36, left=962)
966:         loc_oPg2P1.AddObject("cmd_4c_Processar", "CommandButton")
967:         WITH loc_oPg2P1.cmd_4c_Processar
968:             .Caption         = "Processar"
969:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
970:             .PicturePosition = 13
971:             .Top = 36
972:             .Left = 962
973:             .Width = 75
974:             .Height = 75
975:             .BackColor = RGB(255,255,255)
976:             .ForeColor = RGB(90,90,90)
977:             .FontName = "Comic Sans MS"

*-- Linhas 985 a 993:
985:             .AutoSize = .F.
986:             .Visible = .T.
987:         ENDWITH
988:         BINDEVENT(loc_oPg2P1.cmd_4c_Processar, "Click", THIS, "CmdProcessarClick")
989:     ENDPROC
990: 
991:     *--------------------------------------------------------------------------
992:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
993:     *--------------------------------------------------------------------------

*-- Linhas 1393 a 1437:
1393:         IF PEMSTATUS(loc_oPg2P1, "opt_4c_Custo", 5)
1394:             loc_oPg2P1.opt_4c_Custo.Enabled = par_lHabilitar
1395:         ENDIF
1396:         IF PEMSTATUS(loc_oPg2P1, "cmd_4c_Processar", 5)
1397:             loc_oPg2P1.cmd_4c_Processar.Enabled = par_lHabilitar
1398:         ENDIF
1399:         IF PEMSTATUS(loc_oCntAcao, "cmd_4c_Confirmar", 5)
1400:             loc_oCntAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
1401:         ENDIF
1402:     ENDPROC
1403: 
1404:     *--------------------------------------------------------------------------
1405:     * AjustarBotoesPorModo - Habilita/desabilita botoes CRUD conforme modo atual
1406:     *--------------------------------------------------------------------------
1407:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1408:         LOCAL loc_oCnt, loc_lLista, loc_lEdita
1409:         loc_oCnt   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
1410:         loc_lLista = (THIS.this_cModoAtual = "LISTA")
1411:         loc_lEdita = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1412: 
1413:         IF PEMSTATUS(loc_oCnt, "cmd_4c_Incluir", 5)
1414:             loc_oCnt.cmd_4c_Incluir.Enabled = loc_lLista
1415:         ENDIF
1416:         IF PEMSTATUS(loc_oCnt, "cmd_4c_Visualizar", 5)
1417:             loc_oCnt.cmd_4c_Visualizar.Enabled = loc_lLista
1418:         ENDIF
1419:         IF PEMSTATUS(loc_oCnt, "cmd_4c_Alterar", 5)
1420:             loc_oCnt.cmd_4c_Alterar.Enabled = loc_lLista
1421:         ENDIF
1422:         IF PEMSTATUS(loc_oCnt, "cmd_4c_Excluir", 5)
1423:             loc_oCnt.cmd_4c_Excluir.Enabled = loc_lLista
1424:         ENDIF
1425:         IF PEMSTATUS(loc_oCnt, "cmd_4c_Buscar", 5)
1426:             loc_oCnt.cmd_4c_Buscar.Enabled = loc_lLista
1427:         ENDIF
1428: 
1429:         LOCAL loc_oCntAcao
1430:         loc_oCntAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
1431:         IF PEMSTATUS(loc_oCntAcao, "cmd_4c_Confirmar", 5)
1432:             loc_oCntAcao.cmd_4c_Confirmar.Enabled = loc_lEdita
1433:         ENDIF
1434:     ENDPROC
1435: 
1436:     *--------------------------------------------------------------------------
1437:     * CarregarLista - Busca lotes do banco e popula grd_4c_Dados

*-- Linhas 1474 a 1487:
1474:                         loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.Rclis"
1475:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Usuars"
1476:                         loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.OriDopNums"
1477:                         loc_oGrid.Column1.Header1.Caption = "N" + CHR(250) + "mero"
1478:                         loc_oGrid.Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
1479:                         loc_oGrid.Column3.Header1.Caption = "Conta"
1480:                         loc_oGrid.Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1481:                         loc_oGrid.Column5.Header1.Caption = "Grupo"
1482:                         loc_oGrid.Column6.Header1.Caption = "Empresa"
1483: 
1484:                         THIS.FormatarGridLista(loc_oGrid)
1485:                     ENDIF
1486: 
1487:                     loc_lResultado = .T.

*-- Linhas 2807 a 2816:
2807:         *-- Shape5: borda ao redor da imagem (top=1+29=30)
2808:         loc_oPg2P2.AddObject("shp_4c_Shape5", "Shape")
2809:         WITH loc_oPg2P2.shp_4c_Shape5
2810:             .Top = 30
2811:             .Left = 424
2812:             .Height = 113
2813:             .Width = 282
2814:             .BackStyle = 0
2815:             .BorderStyle = 1
2816:             .BorderWidth = 2

*-- Linhas 2822 a 2844:
2822:         loc_oPg2P2.AddObject("img_4c_FigJpg", "Image")
2823:         WITH loc_oPg2P2.img_4c_FigJpg
2824:             .Stretch = 1
2825:             .Top = 32
2826:             .Left = 426
2827:             .Width = 278
2828:             .Height = 109
2829:             .Visible = .F.
2830:         ENDWITH
2831:         BINDEVENT(loc_oPg2P2.img_4c_FigJpg, "DblClick", THIS, "ImgFigJpgDblClick")
2832: 
2833:         *-- Textboxes de cabecalho Sistema/Arquivo (top=113+29=142)
2834:         loc_oPg2P2.AddObject("txt_4c_Sistema", "TextBox")
2835:         WITH loc_oPg2P2.txt_4c_Sistema
2836:             .FontBold = .T.
2837:             .Alignment = 2
2838:             .Top = 142
2839:             .Left = 8
2840:             .Width = 684
2841:             .Height = 20
2842:             .BackColor = RGB(128, 255, 255)
2843:             .BackStyle = 1
2844:             .ReadOnly = .T.

*-- Linhas 2851 a 2877:
2851:         WITH loc_oPg2P2.txt_4c_Arquivo
2852:             .FontBold = .T.
2853:             .Alignment = 2
2854:             .Top = 142
2855:             .Left = 691
2856:             .Width = 495
2857:             .Height = 20
2858:             .BackColor = RGB(255, 255, 128)
2859:             .BackStyle = 1
2860:             .ReadOnly = .T.
2861:             .BorderStyle = 0
2862:             .Value = "Arquivo"
2863:             .Visible = .T.
2864:         ENDWITH
2865: 
2866:         *-- Label procurar produto (top=74+29=103)
2867:         loc_oPg2P2.AddObject("lbl_4c_Lbl_produto", "Label")
2868:         WITH loc_oPg2P2.lbl_4c_Lbl_produto
2869:             .Caption   = "Procurar Produto :"
2870:             .AutoSize  = .T.
2871:             .Top = 103
2872:             .Left = 8
2873:             .Height = 15
2874:             .FontName  = "Tahoma"
2875:             .FontSize = 8
2876:             .ForeColor = RGB(90, 90, 90)
2877:             .BackStyle = 0

*-- Linhas 2884 a 2907:
2884:             .Value = ""
2885:             .MaxLength = 14
2886:             .Format = "K!"
2887:             .Top = 119
2888:             .Left = 8
2889:             .Width = 108
2890:             .Height = 21
2891:             .FontName = "Tahoma"
2892:             .FontSize = 8
2893:             .SpecialEffect = 1
2894:             .Visible = .T.
2895:         ENDWITH
2896:         BINDEVENT(loc_oPg2P2.txt_4c__produto_inicial, "KeyPress", THIS, "TxtProdutoInicialLostFocus")
2897: 
2898:         *-- Grid disponivel / grd_4c_Disponivel (7 colunas, top=134+29=163)
2899:         loc_oPg2P2.AddObject("grd_4c_Disponivel", "Grid")
2900:         loc_oPg2P2.grd_4c_Disponivel.ColumnCount = 7
2901:         loc_oPg2P2.grd_4c_Disponivel.Top         = 163
2902:         loc_oPg2P2.grd_4c_Disponivel.Left        = 8
2903:         loc_oPg2P2.grd_4c_Disponivel.Width       = 684
2904:         loc_oPg2P2.grd_4c_Disponivel.Height      = 344
2905:         WITH loc_oPg2P2.grd_4c_Disponivel
2906:             .FontName  = "Tahoma"
2907:             .FontSize = 8

*-- Linhas 2926 a 3023:
2926:                 .MousePointer = 15
2927:                 .FontBold = .T.
2928:                 .FontUnderline = .T.
2929:                 .Header1.Caption = "C" + CHR(243) + "digo"
2930:                 .Header1.Alignment = 2
2931:                 .Header1.ForeColor = RGB(90, 90, 90)
2932:                 .ControlSource = "cursor_4c_Movimentos.Cpros"
2933:             ENDWITH
2934: 
2935:             WITH .Column2
2936:                 .Width = 235
2937:                 .Movable = .F.
2938:                 .Resizable = .F.
2939:                 .ReadOnly = .T.
2940:                 .BackColor = RGB(237, 242, 243)
2941:                 .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2942:                 .Header1.Alignment = 2
2943:                 .Header1.ForeColor = RGB(90, 90, 90)
2944:                 .ControlSource = "cursor_4c_Movimentos.Dpros"
2945:             ENDWITH
2946: 
2947:             WITH .Column3
2948:                 .Width = 70
2949:                 .Movable = .F.
2950:                 .Resizable = .F.
2951:                 .ReadOnly = .T.
2952:                 .BackColor = RGB(237, 242, 243)
2953:                 .Header1.Caption = "Valor"
2954:                 .Header1.Alignment = 2
2955:                 .Header1.ForeColor = RGB(90, 90, 90)
2956:                 .ControlSource = "cursor_4c_Movimentos.Units"
2957:             ENDWITH
2958: 
2959:             WITH .Column4
2960:                 .Width = 63
2961:                 .Movable = .F.
2962:                 .Resizable = .F.
2963:                 .ReadOnly = .T.
2964:                 .BackColor = RGB(237, 242, 243)
2965:                 .FontBold = .T.
2966:                 .Header1.Caption = "Quantidade"
2967:                 .Header1.Alignment = 2
2968:                 .Header1.ForeColor = RGB(90, 90, 90)
2969:                 .ControlSource = "cursor_4c_Movimentos.Qtds"
2970:             ENDWITH
2971: 
2972:             WITH .Column5
2973:                 .Width = 63
2974:                 .Movable = .F.
2975:                 .Resizable = .F.
2976:                 .ReadOnly = .T.
2977:                 .BackColor = RGB(237, 242, 243)
2978:                 .FontBold = .T.
2979:                 .Header1.Caption = "Baixado"
2980:                 .Header1.Alignment = 2
2981:                 .Header1.ForeColor = RGB(90, 90, 90)
2982:                 .ControlSource = "cursor_4c_Movimentos.QtBaixas"
2983:             ENDWITH
2984: 
2985:             WITH .Column6
2986:                 .Width = 63
2987:                 .Movable = .F.
2988:                 .Resizable = .F.
2989:                 .ReadOnly = .T.
2990:                 .BackColor = RGB(237, 242, 243)
2991:                 .FontBold = .T.
2992:                 .Header1.Caption = "Reservado"
2993:                 .Header1.Alignment = 2
2994:                 .Header1.ForeColor = RGB(90, 90, 90)
2995:                 .ControlSource = "cursor_4c_Movimentos.QtReservas"
2996:             ENDWITH
2997: 
2998:             WITH .Column7
2999:                 .Width = 63
3000:                 .Movable = .F.
3001:                 .Resizable = .F.
3002:                 .ReadOnly = .T.
3003:                 .BackColor = RGB(237, 242, 243)
3004:                 .FontBold = .T.
3005:                 .Header1.Caption = "Saldo"
3006:                 .Header1.Alignment = 2
3007:                 .Header1.ForeColor = RGB(90, 90, 90)
3008:                 .ControlSource = "cursor_4c_Movimentos.Saldo"
3009:             ENDWITH
3010:         ENDWITH
3011:         BINDEVENT(loc_oPg2P2.grd_4c_Disponivel, "AfterRowColChange", THIS, "GrdDisponivelAfterRowColChange")
3012:         BINDEVENT(loc_oPg2P2.grd_4c_Disponivel, "DblClick", THIS, "GrdDisponivelDblClick")
3013: 
3014:         *-- Grid XML / grd_4c_ItemXml (4 colunas, top=134+29=163)
3015:         loc_oPg2P2.AddObject("grd_4c_ItemXml", "Grid")
3016:         loc_oPg2P2.grd_4c_ItemXml.ColumnCount = 4
3017:         loc_oPg2P2.grd_4c_ItemXml.Top         = 163
3018:         loc_oPg2P2.grd_4c_ItemXml.Left        = 693
3019:         loc_oPg2P2.grd_4c_ItemXml.Width       = 493
3020:         loc_oPg2P2.grd_4c_ItemXml.Height      = 344
3021:         WITH loc_oPg2P2.grd_4c_ItemXml
3022:             .FontName  = "Tahoma"
3023:             .FontSize = 8

*-- Linhas 3038 a 3046:
3038:                 .Enabled = .F.
3039:                 .ForeColor = RGB(0, 0, 0)
3040:                 .BackColor = RGB(237, 242, 243)
3041:                 .Header1.Caption = "C" + CHR(243) + "digo"
3042:                 .Header1.Alignment = 2
3043:                 .Header1.ForeColor = RGB(90, 90, 90)
3044:                 .ControlSource = "cursor_4c_Distribui.Cpros"
3045:             ENDWITH
3046: 

*-- Linhas 3052 a 3073:
3052:                 .Enabled = .F.
3053:                 .ForeColor = RGB(0, 0, 0)
3054:                 .BackColor = RGB(237, 242, 243)
3055:                 .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
3056:                 .Header1.Alignment = 2
3057:                 .Header1.ForeColor = RGB(90, 90, 90)
3058:                 .ControlSource = "cursor_4c_Distribui.Dpros"
3059:             ENDWITH
3060: 
3061:             WITH .Column3
3062:                 .Width = 63
3063:                 .Movable = .F.
3064:                 .Resizable = .F.
3065:                 .InputMask = "999999"
3066:                 .ForeColor = RGB(0, 0, 0)
3067:                 .BackColor = RGB(237, 242, 243)
3068:                 .Header1.Caption = "Quantidade"
3069:                 .Header1.Alignment = 2
3070:                 .Header1.ForeColor = RGB(90, 90, 90)
3071:                 .ControlSource = "cursor_4c_Distribui.Qtds"
3072:             ENDWITH
3073: 

*-- Linhas 3079 a 3138:
3079:                 .Enabled = .F.
3080:                 .ForeColor = RGB(0, 0, 0)
3081:                 .BackColor = RGB(237, 242, 243)
3082:                 .Header1.Caption = "Valor"
3083:                 .Header1.Alignment = 2
3084:                 .Header1.ForeColor = RGB(90, 90, 90)
3085:                 .ControlSource = "cursor_4c_Distribui.Total"
3086:             ENDWITH
3087:         ENDWITH
3088: 
3089:         *-- Botao excluir Grade Sistema / cmd_4c_BtnExcluirSis (top=479+29=508)
3090:         loc_oPg2P2.AddObject("cmd_4c_BtnExcluirSis", "CommandButton")
3091:         WITH loc_oPg2P2.cmd_4c_BtnExcluirSis
3092:             .Caption = ""
3093:             .Themes = .F.
3094:             .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
3095:             .Top = 508
3096:             .Left = 663
3097:             .Width = 40
3098:             .Height = 37
3099:             .ForeColor = RGB(255, 0, 0)
3100:             .BackColor = RGB(255, 255, 255)
3101:             .ToolTipText = "Excluir Linha da Grade Sistema"
3102:             .SpecialEffect = 0
3103:             .TabStop = .F.
3104:             .Visible = .T.
3105:         ENDWITH
3106:         BINDEVENT(loc_oPg2P2.cmd_4c_BtnExcluirSis, "Click", THIS, "BtnExcluirSisClick")
3107: 
3108:         *-- Botao excluir Grade Arquivo / cmd_4c_BtnExcluirArq (top=479+29=508)
3109:         loc_oPg2P2.AddObject("cmd_4c_BtnExcluirArq", "CommandButton")
3110:         WITH loc_oPg2P2.cmd_4c_BtnExcluirArq
3111:             .Caption = ""
3112:             .Themes = .F.
3113:             .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
3114:             .Top = 508
3115:             .Left = 1146
3116:             .Width = 40
3117:             .Height = 37
3118:             .ForeColor = RGB(255, 0, 0)
3119:             .BackColor = RGB(255, 255, 255)
3120:             .ToolTipText = "Excluir Linha da Grade Arquivo"
3121:             .SpecialEffect = 0
3122:             .TabStop = .F.
3123:             .Visible = .T.
3124:         ENDWITH
3125:         BINDEVENT(loc_oPg2P2.cmd_4c_BtnExcluirArq, "Click", THIS, "BtnExcluirArqClick")
3126: 
3127:         *-- Label: Movimentacao (Say3, top=483+29=512)
3128:         loc_oPg2P2.AddObject("lbl_4c_Label3", "Label")
3129:         WITH loc_oPg2P2.lbl_4c_Label3
3130:             .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
3131:             .AutoSize  = .T.
3132:             .Top = 512
3133:             .Left = 40
3134:             .Height = 15
3135:             .FontName  = "Tahoma"
3136:             .FontSize = 8
3137:             .ForeColor = RGB(90, 90, 90)
3138:             .BackStyle = 0

*-- Linhas 3145 a 3154:
3145:             .Value = ""
3146:             .Format = "K!"
3147:             .ReadOnly = .T.
3148:             .Top = 509
3149:             .Left = 122
3150:             .Width = 65
3151:             .Height = 21
3152:             .FontName = "Tahoma"
3153:             .FontSize = 8
3154:             .SpecialEffect = 1

*-- Linhas 3164 a 3173:
3164:             .MaxLength = 20
3165:             .Format = "K!"
3166:             .ReadOnly = .T.
3167:             .Top = 509
3168:             .Left = 188
3169:             .Width = 205
3170:             .Height = 21
3171:             .FontName = "Tahoma"
3172:             .FontSize = 8
3173:             .SpecialEffect = 1

*-- Linhas 3180 a 3189:
3180:             .Value = ""
3181:             .Format = "K!"
3182:             .ReadOnly = .T.
3183:             .Top = 509
3184:             .Left = 393
3185:             .Width = 65
3186:             .Height = 21
3187:             .FontName = "Tahoma"
3188:             .FontSize = 8
3189:             .SpecialEffect = 1

*-- Linhas 3199 a 3223:
3199:             .MaxLength = 20
3200:             .Format = "K!"
3201:             .ReadOnly = .T.
3202:             .Top = 509
3203:             .Left = 459
3204:             .Width = 173
3205:             .Height = 21
3206:             .FontName = "Tahoma"
3207:             .FontSize = 8
3208:             .SpecialEffect = 1
3209:             .Visible = .T.
3210:         ENDWITH
3211: 
3212:         *-- Label: Ref. Fornecedor (top=505+29=534)
3213:         loc_oPg2P2.AddObject("lbl_4c_Lbl_ref_fornecedor", "Label")
3214:         WITH loc_oPg2P2.lbl_4c_Lbl_ref_fornecedor
3215:             .Caption   = "Ref. Fornecedor :"
3216:             .AutoSize  = .T.
3217:             .Top = 534
3218:             .Left = 30
3219:             .Height = 15
3220:             .FontName  = "Tahoma"
3221:             .FontSize = 8
3222:             .ForeColor = RGB(90, 90, 90)
3223:             .BackStyle = 0

*-- Linhas 3231 a 3257:
3231:             .MaxLength = 20
3232:             .Format = "K!"
3233:             .ReadOnly = .T.
3234:             .Top = 531
3235:             .Left = 122
3236:             .Width = 190
3237:             .Height = 21
3238:             .FontName = "Tahoma"
3239:             .FontSize = 8
3240:             .SpecialEffect = 1
3241:             .Visible = .T.
3242:             .BackColor = RGB(255, 255, 255)
3243:             .BackStyle = 1
3244:         ENDWITH
3245: 
3246:         *-- Label: Custo (Say5, top=527+29=556)
3247:         loc_oPg2P2.AddObject("lbl_4c_Label5", "Label")
3248:         WITH loc_oPg2P2.lbl_4c_Label5
3249:             .Caption   = "Custo :"
3250:             .AutoSize  = .T.
3251:             .Top = 556
3252:             .Left = 81
3253:             .Height = 15
3254:             .FontName  = "Tahoma"
3255:             .FontSize = 8
3256:             .ForeColor = RGB(90, 90, 90)
3257:             .BackStyle = 0

*-- Linhas 3264 a 3291:
3264:             .Value = 0
3265:             .InputMask = "99,999.99999"
3266:             .ReadOnly = .T.
3267:             .Top = 553
3268:             .Left = 122
3269:             .Width = 108
3270:             .Height = 21
3271:             .Alignment = 3
3272:             .FontName = "Tahoma"
3273:             .FontSize = 8
3274:             .SpecialEffect = 1
3275:             .Visible = .T.
3276:             .BackColor = RGB(255, 255, 255)
3277:             .BackStyle = 1
3278:         ENDWITH
3279: 
3280:         *-- Label: Preco Venda (top=549+29=578)
3281:         loc_oPg2P2.AddObject("lbl_4c_Lbl_pr_venda", "Label")
3282:         WITH loc_oPg2P2.lbl_4c_Lbl_pr_venda
3283:             .Caption   = "Pre" + CHR(231) + "o Venda :"
3284:             .AutoSize  = .T.
3285:             .Top = 578
3286:             .Left = 49
3287:             .Height = 15
3288:             .FontName  = "Tahoma"
3289:             .FontSize = 8
3290:             .ForeColor = RGB(90, 90, 90)
3291:             .BackStyle = 0

*-- Linhas 3298 a 3307:
3298:             .Value = 0
3299:             .InputMask = "99,999.99999"
3300:             .ReadOnly = .T.
3301:             .Top = 575
3302:             .Left = 122
3303:             .Width = 108
3304:             .Height = 21
3305:             .Alignment = 3
3306:             .FontName = "Tahoma"
3307:             .FontSize = 8

*-- Linhas 3318 a 3344:
3318:             .MaxLength = 3
3319:             .Format = "K!"
3320:             .ReadOnly = .T.
3321:             .Top = 575
3322:             .Left = 231
3323:             .Width = 31
3324:             .Height = 21
3325:             .FontName = "Tahoma"
3326:             .FontSize = 8
3327:             .SpecialEffect = 1
3328:             .Visible = .T.
3329:             .BackColor = RGB(255, 255, 255)
3330:             .BackStyle = 1
3331:         ENDWITH
3332: 
3333:         *-- Label: Peso (Say1, top=550+29=579)
3334:         loc_oPg2P2.AddObject("lbl_4c_Peso", "Label")
3335:         WITH loc_oPg2P2.lbl_4c_Peso
3336:             .Caption   = "Peso :"
3337:             .AutoSize  = .T.
3338:             .Top = 579
3339:             .Left = 348
3340:             .Height = 15
3341:             .FontName  = "Tahoma"
3342:             .FontSize = 8
3343:             .ForeColor = RGB(90, 90, 90)
3344:             .BackStyle = 0

*-- Linhas 3351 a 3378:
3351:             .Value = 0
3352:             .InputMask = "99,999.999"
3353:             .ReadOnly = .T.
3354:             .Top = 576
3355:             .Left = 383
3356:             .Width = 75
3357:             .Height = 21
3358:             .Alignment = 3
3359:             .FontName = "Tahoma"
3360:             .FontSize = 8
3361:             .SpecialEffect = 1
3362:             .Visible = .T.
3363:             .BackColor = RGB(255, 255, 255)
3364:             .BackStyle = 1
3365:         ENDWITH
3366: 
3367:         *-- Label: Preco Custo (Say2, top=571+29=600)
3368:         loc_oPg2P2.AddObject("lbl_4c_Label2", "Label")
3369:         WITH loc_oPg2P2.lbl_4c_Label2
3370:             .Caption   = "Pre" + CHR(231) + "o Custo :"
3371:             .AutoSize  = .T.
3372:             .Top = 600
3373:             .Left = 51
3374:             .Height = 15
3375:             .FontName  = "Tahoma"
3376:             .FontSize = 8
3377:             .ForeColor = RGB(90, 90, 90)
3378:             .BackStyle = 0

*-- Linhas 3385 a 3394:
3385:             .Value = 0
3386:             .InputMask = "99,999.99999"
3387:             .ReadOnly = .T.
3388:             .Top = 597
3389:             .Left = 122
3390:             .Width = 108
3391:             .Height = 21
3392:             .Alignment = 3
3393:             .FontName = "Tahoma"
3394:             .FontSize = 8

*-- Linhas 3405 a 3414:
3405:             .MaxLength = 3
3406:             .Format = "K!"
3407:             .ReadOnly = .T.
3408:             .Top = 597
3409:             .Left = 231
3410:             .Width = 31
3411:             .Height = 21
3412:             .FontName = "Tahoma"
3413:             .FontSize = 8
3414:             .SpecialEffect = 1


### BO (C:\4c\projeto\app\classes\SigPrCtrBO.prg):
*==============================================================================
* SigPrCtrBO.prg - Business Object para Controle de Movimentacoes por XML
* Tabela: SigPrCtr
* Herda de: BusinessBase
*
* Descricao: Gerencia lotes de distribuicao de produtos via XML.
*   Cada "Codigos" representa um lote que agrupa N linhas em SigPrCtr
*   (uma por produto distribuido). A exclusao/atualizacao opera por Codigos
*   (DELETE WHERE Codigos = ?), nao por PkChave.
*==============================================================================

DEFINE CLASS SigPrCtrBO AS BusinessBase

    *-- Chave primaria real da tabela (unica por linha)
    this_cPkChave    = ""  && char(20) - PRIMARY KEY
    *-- Chave de lote: identifica o conjunto de linhas do processamento
    this_cCodigos    = ""  && char(10) - identificador do lote
    *-- Campos do produto na linha
    this_cCodCors    = ""  && char(4)  - codigo da cor
    this_cCodTams    = ""  && char(4)  - codigo do tamanho
    this_cCpros      = ""  && char(14) - codigo do produto
    *-- Quantidades
    this_nQtds       = 0   && numeric(10,2) - quantidade XML
    this_nQtdOs      = 0   && numeric(10,2) - quantidade OS/distribuida
    *-- Referencia de origem
    this_cOriDopNums = ""  && char(29) - EmpDopNums da movimentacao de origem
    this_cFkChaves   = ""  && char(20) - cidchaves do item de movimentacao
    *-- Dados do fornecedor/conta
    this_cContas     = ""  && char(10) - codigo da conta/fornecedor
    *-- Opcoes de processamento
    this_nPrecific   = 0   && numeric(1,0) - tipo de precificacao (Opt_Custo)
    this_cMoedas     = ""  && char(3)  - codigo da moeda
    this_cArquivo    = ""  && char(200) - caminho do arquivo XML
    *-- Auditoria
    this_dDatas      = {}  && datetime - data/hora do processamento
    this_dDtAlts     = {}  && datetime - data/hora da ultima alteracao
    this_cUsuars     = ""  && char(10) - usuario que criou
    this_cUsualts    = ""  && char(10) - usuario da ultima alteracao

    *-- Campos operacionais do formulario (nao persistidos diretamente)
    this_cGrupo      = ""  && grupo contabil (Get_Grupo - GrPadFors de SigCdPam)
    this_cDconta     = ""  && descricao da conta (Get_Dconta)
    this_cCpf        = ""  && CPF/CNPJ do fornecedor (Get_cpf)

    *-- Filtro de data para a lista principal
    this_dDataInicial = {}
    this_dDataFinal   = {}

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela      = "SigPrCtr"
            THIS.this_cCampoChave  = "PkChave"
            THIS.this_dDataInicial = DATE()
            THIS.this_dDataFinal   = DATE()
            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro ao inicializar SigPrCtrBO: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave de lote para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Grava novo lote (delega para SalvarLote)
    *   Form deve popular cursor_4c_Linhas antes de chamar BusinessBase.Salvar()
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        RETURN THIS.SalvarLote("", .T.)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza lote existente (delega para SalvarLote)
    *   Form deve popular cursor_4c_Linhas antes de chamar BusinessBase.Salvar()
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        RETURN THIS.SalvarLote(THIS.this_cCodigos, .F.)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Seleciona lotes distintos de SigPrCtr filtrados por data
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_cDataIni, loc_cDataFin, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cDataIni = FormatarDataSQL(THIS.this_dDataInicial)
            loc_cDataFin = FormatarDataSQL(THIS.this_dDataFinal)

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT DISTINCT a.Codigos, MAX(a.Datas) AS Datas," + ;
                       " a.OriDopNums, a.Usuars, a.Contas, b.Rclis" + ;
                       " FROM SigPrCtr a" + ;
                       " JOIN SigCdCli b ON b.Iclis = a.Contas" + ;
                       " WHERE a.Datas BETWEEN " + loc_cDataIni + ;
                       " AND " + loc_cDataFin + ;
                       " GROUP BY a.Codigos, a.OriDopNums, a.Usuars, a.Contas, b.Rclis"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " HAVING " + par_cFiltro
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar lotes: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigPrCtrBO.Buscar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega primeira linha de um lote pelo Codigos
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigos)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT * FROM SigPrCtr WHERE Codigos = " + EscaparSQL(par_cCodigos)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                IF THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                    loc_lResultado = .T.
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigPrCtrBO.CarregarPorCodigo: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Popula propriedades a partir de um cursor
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cPkChave    = TratarNulo(PkChave,    "C")
                THIS.this_cCodigos    = TratarNulo(Codigos,    "C")
                THIS.this_cCodCors    = TratarNulo(CodCors,    "C")
                THIS.this_cCodTams    = TratarNulo(CodTams,    "C")
                THIS.this_cCpros      = TratarNulo(Cpros,      "C")
                THIS.this_nQtds       = TratarNulo(Qtds,       "N")
                THIS.this_nQtdOs      = TratarNulo(QtdOs,      "N")
                THIS.this_cOriDopNums = TratarNulo(OriDopNums, "C")
                THIS.this_cFkChaves   = TratarNulo(FkChaves,   "C")
                THIS.this_cContas     = TratarNulo(Contas,     "C")
                THIS.this_nPrecific   = TratarNulo(Precific,   "N")
                THIS.this_cMoedas     = TratarNulo(Moedas,     "C")
                THIS.this_cArquivo    = TratarNulo(Arquivo,    "C")
                THIS.this_dDatas      = TratarNulo(Datas,      "T")
                THIS.this_dDtAlts     = TratarNulo(DtAlts,     "T")
                THIS.this_cUsuars     = TratarNulo(Usuars,     "C")
                THIS.this_cUsualts    = TratarNulo(UsuAlts,    "C")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigPrCtrBO.CarregarDoCursor: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarMovimentosDistribuiveis - Produtos do lote para grdDisponivel (Page2)
    *--------------------------------------------------------------------------
    FUNCTION BuscarMovimentosDistribuiveis(par_cCodigos)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Movimentos")
                USE IN cursor_4c_Movimentos
            ENDIF

            loc_cSQL = "SELECT a.Cpros, f.Dpros, a.Units," + ;
                       " SUM(a.Qtds) AS Qtds, SUM(a.QtBaixas) AS QtBaixas," + ;
                       " SUM(a.QtReservas) AS QtReservas," + ;
                       " (SUM(a.Qtds) - SUM(a.QtBaixas) - SUM(a.QtReservas)) AS Saldo," + ;
                       " SUM(g.QtdOs) AS QtdOs," + ;
                       " a.EmpDopNums AS OriDopNums, f.Cgrus, f.Sgrus," + ;
                       " a.CidChaves, a.Moedas" + ;
                       " FROM SigMvItn a" + ;
                       " JOIN SigMvCab c ON a.EmpDopNums = c.EmpDopNums" + ;
                       " JOIN SigCdOpe d ON c.Dopes = d.Dopes" + ;
                       " JOIN SigOpCdd e ON d.Dopes = e.Dopes" + ;
                       " JOIN SigCdPro f ON a.Cpros = f.Cpros" + ;
                       " JOIN SigPrCtr g ON a.EmpDopNums = g.OriDopNums" + ;
                       "   AND a.Cpros = g.Cpros AND g.FkChaves = a.CidChaves" + ;
                       " WHERE e.Distribui = 3" + ;
                       " AND c.GrupoDs <> SPACE(10)" + ;
                       " AND c.ContaDs <> SPACE(10)" + ;
                       " AND a.Qtds <> a.QtBaixas" + ;
                       " AND a.CItem2 = 0" + ;
                       " AND g.Codigos = " + EscaparSQL(par_cCodigos) + ;
                       " GROUP BY a.Cpros, f.Dpros, f.Cgrus, f.Sgrus," + ;
                       "   a.EmpDopNums, a.Units, a.CidChaves, a.Moedas"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Movimentos")
                TABLEREVERT(.T., "cursor_4c_Movimentos")
                USE IN cursor_4c_Movimentos
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Movimentos")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Movimentos")
                    GO TOP IN cursor_4c_Movimentos
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar movimentos: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigPrCtrBO.BuscarMovimentosDistribuiveis: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    *   Retorna movimentacoes distribuiveis para grdEstoque (Page1)
    *   par_cConta   : filtra por fornecedor (vazio = todos)
    *   par_lFiltrar : .T. aplica filtro de conta
    *--------------------------------------------------------------------------
    FUNCTION BuscarMovimentosPendentes(par_cConta, par_lFiltrar)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cFiltro
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Pendentes")
                USE IN cursor_4c_Pendentes
            ENDIF

            loc_cFiltro = ""
            IF par_lFiltrar AND !EMPTY(ALLTRIM(par_cConta))
                loc_cFiltro = " AND a.ContaOs = " + EscaparSQL(par_cConta)
            ENDIF

            loc_cSQL = "SELECT 0 AS nMarca, a.Emps, a.Dopes, a.Numes," + ;
                       " a.EmpDopNums AS OriDopNums," + ;
                       " a.GrupoOs AS Grupos, a.ContaOs AS Contas" + ;
                       " FROM SigMvCab a" + ;
                       " JOIN SigCdOpe b ON a.Dopes = b.Dopes" + ;
                       " JOIN SigOpCdd c ON b.Dopes = c.Dopes" + ;
                       " WHERE c.Distribui = 3" + ;
                       " AND a.ChkSubn = 0" + ;
                       " AND a.GrupoOs <> SPACE(10)" + ;
                       " AND a.ContaOs <> SPACE(10)" + ;
                       loc_cFiltro

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Pendentes")
                TABLEREVERT(.T., "cursor_4c_Pendentes")
                USE IN cursor_4c_Pendentes
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pendentes")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Pendentes")
                    GO TOP IN cursor_4c_Pendentes
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar pendentes: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigPrCtrBO.BuscarMovimentosPendentes: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarLote - Persiste linhas de cursor_4c_Linhas no banco.
    *   Modo INSERIR (par_lNovoLote=.T.): gera novo Codigos, insere linhas
    *   Modo ALTERAR (par_lNovoLote=.F.): deleta lote antigo, insere novas linhas
    *
    *   cursor_4c_Linhas deve conter os campos:
    *     Cpros(C14), CodCors(C4), CodTams(C4), OriDopNums(C29),
    *     Qtds(N), QtdOs(N), Contas(C10), Arquivo(C200),
    *     Moedas(C3), Precific(N), FkChaves(C20)
    *--------------------------------------------------------------------------
    FUNCTION SalvarLote(par_cCodigos, par_lNovoLote)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cCodigos, loc_lScanOK
        loc_lResultado = .F.
        loc_cCodigos   = ""

        IF !USED("cursor_4c_Linhas") OR RECCOUNT("cursor_4c_Linhas") = 0
            MsgErro("Nenhuma linha para gravar no lote.", "Aviso")
            RETURN loc_lResultado
        ENDIF

        TRY
            loc_lResultado = .T.

            *-- Modo ALTERAR: exclui linhas do lote anterior antes de reinserir
            IF !par_lNovoLote AND !EMPTY(ALLTRIM(par_cCodigos))
                loc_cSQL   = "DELETE FROM SigPrCtr WHERE Codigos = " + EscaparSQL(par_cCodigos)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult < 0
                    MsgErro("Erro ao excluir lote anterior: " + CapturarErroSQL(), "Erro SQL")
                    loc_lResultado = .F.
                ENDIF
            ENDIF

            *-- Modo INSERIR: gera novo Codigos sequencial
            IF loc_lResultado AND par_lNovoLote
                loc_cSQL = "SELECT ISNULL(MAX(CAST(LTRIM(RTRIM(Codigos)) AS INT)), 0) + 1" + ;
                           " AS ProxCod FROM SigPrCtr"
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_MaxCod")
                    TABLEREVERT(.T., "cursor_4c_MaxCod")
                    USE IN cursor_4c_MaxCod
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxCod")
                IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_MaxCod") > 0
                    SELECT cursor_4c_MaxCod
                    loc_cCodigos = PADL(ALLTRIM(TRANSFORM(cursor_4c_MaxCod.ProxCod)), 10)
                    USE IN cursor_4c_MaxCod
                ELSE
                    MsgErro("Erro ao gerar codigo de lote: " + CapturarErroSQL(), "Erro SQL")
                    loc_lResultado = .F.
                ENDIF
            ENDIF

            IF loc_lResultado AND !par_lNovoLote
                loc_cCodigos = par_cCodigos
            ENDIF

            *-- Insere cada linha do cursor no banco
            IF loc_lResultado
                SELECT cursor_4c_Linhas
                GO TOP
                loc_lScanOK = .T.
                SCAN WHILE loc_lScanOK
                    loc_cSQL = "INSERT INTO SigPrCtr" + ;
                               " (PkChave, Codigos, Cpros, CodCors, CodTams," + ;
                               "  OriDopNums, Qtds, QtdOs, Contas, Arquivo," + ;
                               "  Moedas, Precific, FkChaves, Datas, Usuars)" + ;
                               " VALUES (" + ;
                               " NEWID()," + ;
                               EscaparSQL(loc_cCodigos) + "," + ;
                               EscaparSQL(LEFT(ALLTRIM(cursor_4c_Linhas.Cpros), 14)) + "," + ;
                               EscaparSQL(LEFT(ALLTRIM(cursor_4c_Linhas.CodCors), 4)) + "," + ;
                               EscaparSQL(LEFT(ALLTRIM(cursor_4c_Linhas.CodTams), 4)) + "," + ;
                               EscaparSQL(LEFT(ALLTRIM(cursor_4c_Linhas.OriDopNums), 29)) + "," + ;
                               FormatarNumeroSQL(cursor_4c_Linhas.Qtds) + "," + ;
                               FormatarNumeroSQL(cursor_4c_Linhas.QtdOs) + "," + ;
                               EscaparSQL(LEFT(ALLTRIM(cursor_4c_Linhas.Contas), 10)) + "," + ;
                               EscaparSQL(LEFT(ALLTRIM(cursor_4c_Linhas.Arquivo), 200)) + "," + ;
                               EscaparSQL(LEFT(ALLTRIM(cursor_4c_Linhas.Moedas), 3)) + "," + ;
                               FormatarNumeroSQL(cursor_4c_Linhas.Precific) + "," + ;
                               EscaparSQL(LEFT(ALLTRIM(cursor_4c_Linhas.FkChaves), 20)) + "," + ;
                               "GETDATE()," + ;
                               EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)) + ")"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResult < 0
                        MsgErro("Erro ao inserir linha do lote: " + CapturarErroSQL(), "Erro SQL")
                        loc_lScanOK = .F.
                        EXIT
                    ENDIF

                    *-- Acumula reserva em SigMvItn (espelha logica legada Salva.Click)
                    IF !EMPTY(ALLTRIM(cursor_4c_Linhas.FkChaves)) AND cursor_4c_Linhas.QtdOs > 0
                        loc_cSQL = "UPDATE SigMvItn SET QtReservas = (QtReservas + " + ;
                                   FormatarNumeroSQL(cursor_4c_Linhas.QtdOs) + ")" + ;
                                   " WHERE CidChaves = " + ;
                                   EscaparSQL(LEFT(ALLTRIM(cursor_4c_Linhas.FkChaves), 20))
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResult < 0
                            MsgErro("Erro ao atualizar reserva em SigMvItn: " + CapturarErroSQL(), "Erro SQL")
                            loc_lScanOK = .F.
                            EXIT
                        ENDIF
                    ENDIF

                    SELECT cursor_4c_Linhas
                ENDSCAN

                loc_lResultado = loc_lScanOK
            ENDIF

            IF loc_lResultado
                THIS.this_cCodigos = loc_cCodigos
                THIS.RegistrarAuditoria(IIF(par_lNovoLote, "INSERT", "UPDATE"))
            ENDIF

        CATCH TO loException
            MsgErro("Erro em SigPrCtrBO.SalvarLote: " + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui todas as linhas do lote e restaura QtReservas.
    *   Chamado internamente por BusinessBase.Excluir()
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_lScanOK
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCodigos))
                MsgErro("Codigo do lote nao informado para exclusao.", "Aviso")
            ELSE
                *-- Carrega linhas para restaurar QtReservas em SigMvItn
                loc_cSQL = "SELECT FkChaves, QtdOs FROM SigPrCtr" + ;
                           " WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_ExclLote")
                    TABLEREVERT(.T., "cursor_4c_ExclLote")
                    USE IN cursor_4c_ExclLote
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ExclLote")

                IF loc_nResult < 0
                    MsgErro("Erro ao carregar lote para exclusao: " + CapturarErroSQL(), "Erro SQL")
                ELSE
                    loc_lScanOK = .T.
                    IF USED("cursor_4c_ExclLote") AND RECCOUNT("cursor_4c_ExclLote") > 0
                        SELECT cursor_4c_ExclLote
                        GO TOP
                        SCAN WHILE loc_lScanOK
                            loc_cSQL = "UPDATE SigMvItn SET QtReservas =" + ;
                                       " CASE WHEN (QtReservas - " + ;
                                       FormatarNumeroSQL(cursor_4c_ExclLote.QtdOs) + ;
                                       ") < 0 THEN 0" + ;
                                       " ELSE (QtReservas - " + ;
                                       FormatarNumeroSQL(cursor_4c_ExclLote.QtdOs) + ")" + ;
                                       " END" + ;
                                       " WHERE CidChaves = " + ;
                                       EscaparSQL(ALLTRIM(cursor_4c_ExclLote.FkChaves))

                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                            IF loc_nResult < 0
                                MsgErro("Erro ao restaurar QtReservas: " + CapturarErroSQL(), "Erro SQL")
                                loc_lScanOK = .F.
                                EXIT
                            ENDIF
                            SELECT cursor_4c_ExclLote
                        ENDSCAN
                        USE IN cursor_4c_ExclLote
                    ENDIF

                    IF loc_lScanOK
                        loc_cSQL = "DELETE FROM SigPrCtr WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResult < 0
                            MsgErro("Erro ao excluir lote: " + CapturarErroSQL(), "Erro SQL")
                        ELSE
                            THIS.RegistrarAuditoria("DELETE")
                            loc_lResultado = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigPrCtrBO.ExecutarExclusao: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE

