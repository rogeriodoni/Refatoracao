# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (12)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 219: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 243: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 267: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 350: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 373: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 396: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 419: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 442: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 494: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 517: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 553: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFti.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2434 linhas total):

*-- Linhas 104 a 113:
104:     PROTECTED PROCEDURE ConfigurarPageFrame()
105:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
106:         WITH THIS.pgf_4c_Paginas
107:             .Top       = -29
108:             .Left      = 0
109:             .Width     = THIS.Width
110:             .Height    = THIS.Height + 29
111:             .PageCount = 2
112:             .Tabs      = .F.
113:             .Visible   = .T.

*-- Linhas 136 a 290:
136: 
137:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
138:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
139: 
140:         *-- Cabecalho cinza (cntSombra: Top=1, Left=-1, Width=1008, H=80 -> comp +29)
141:         loc_oPagina.AddObject("cnt_4c_Sombra", "Container")
142:         WITH loc_oPagina.cnt_4c_Sombra
143:             .Top         = 30
144:             .Left        = 0
145:             .Width       = THIS.Width
146:             .Height      = 80
147:             .BackColor   = RGB(100, 100, 100)
148:             .BorderWidth = 0
149:             .Visible     = .T.
150:         ENDWITH
151: 
152:         loc_oPagina.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
153:         WITH loc_oPagina.cnt_4c_Sombra.lbl_4c_Sombra
154:             .Top       = 15
155:             .Left      = 10
156:             .Width     = 769
157:             .Height    = 40
158:             .AutoSize  = .F.
159:             .Caption   = "Cadastro de Feitios"
160:             .FontName  = "Tahoma"
161:             .FontSize  = 16
162:             .FontBold  = .T.
163:             .ForeColor = RGB(0, 0, 0)
164:             .BackStyle = 0
165:             .Visible   = .T.
166:         ENDWITH
167: 
168:         loc_oPagina.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
169:         WITH loc_oPagina.cnt_4c_Sombra.lbl_4c_Titulo
170:             .Top       = 18
171:             .Left      = 10
172:             .Width     = 769
173:             .Height    = 46
174:             .AutoSize  = .F.
175:             .Caption   = "Cadastro de Feitios"
176:             .FontName  = "Tahoma"
177:             .FontSize  = 16
178:             .FontBold  = .T.
179:             .ForeColor = RGB(255, 255, 255)
180:             .BackStyle = 0
181:             .Visible   = .T.
182:         ENDWITH
183: 
184:         *-- Container botoes CRUD (Grupo_op: Left=543, Top=-1+29=28, W=385, H=85)
185:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
186:         WITH loc_oPagina.cnt_4c_Botoes
187:             .Top         = 28
188:             .Left        =  542
189:             .Width       = 385
190:             .Height      = 85
191:             .BackStyle = 1
192:             .BackColor = RGB(255, 255, 255)
193:             .BorderWidth = 0
194:             .Visible     = .T.
195:         ENDWITH
196: 
197:         *-- Container Saida canonico (Left=917, Top=29, Width=90, Height=85)
198:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
199:         WITH loc_oPagina.cnt_4c_Saida
200:             .Top         = 29
201:             .Left        = 917
202:             .Width       = 90
203:             .Height      = 85
204:             .BackStyle = 1
205:             .BackColor = RGB(255, 255, 255)
206:             .BorderWidth = 0
207:             .Visible     = .T.
208:         ENDWITH
209: 
210:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
211:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
212:             .Caption         = "Encerrar"
213:             .Top             = 5
214:             .Left            = 5
215:             .Width           = 75
216:             .Height          = 75
217:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
218:             .PicturePosition = 13
219:             .FontName        = "Comic Sans MS"
220:             .FontSize        = 8
221:             .FontBold        = .T.
222:             .FontItalic      = .T.
223:             .ForeColor       = RGB(90, 90, 90)
224:             .BackColor       = RGB(255, 255, 255)
225:             .Themes          = .F.
226:             .SpecialEffect   = 0
227:             .WordWrap        = .T.
228:             .MousePointer    = 15
229:             .Visible         = .T.
230:         ENDWITH
231:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
232: 
233:         *-- Botao Exporta XML (Top=83+29=112, Left=712, W=105, H=45)
234:         loc_oPagina.AddObject("cmd_4c_BtnExpXML", "CommandButton")
235:         WITH loc_oPagina.cmd_4c_BtnExpXML
236:             .Caption         = "Exporta XML"
237:             .Top             = 112
238:             .Left            = 712
239:             .Width           = 105
240:             .Height          = 45
241:             .Picture         = gc_4c_CaminhoIcones + "exportar_48.png"
242:             .PicturePosition = 1
243:             .FontName        = "Comic Sans MS"
244:             .FontSize        = 8
245:             .FontBold        = .T.
246:             .FontItalic      = .T.
247:             .ForeColor       = RGB(90, 90, 90)
248:             .BackColor       = RGB(255, 255, 255)
249:             .Themes          = .F.
250:             .SpecialEffect   = 0
251:             .WordWrap        = .T.
252:             .ToolTipText     = "Exporta Opera" + CHR(231) + CHR(227) + "o Para Um Arquivo XML"
253:             .Visible         = .T.
254:         ENDWITH
255:         BINDEVENT(loc_oPagina.cmd_4c_BtnExpXML, "Click", THIS, "BtnExpXMLClick")
256: 
257:         *-- Botao Importa XML (Top=83+29=112, Left=818, W=105, H=45)
258:         loc_oPagina.AddObject("cmd_4c_BtnImpXML", "CommandButton")
259:         WITH loc_oPagina.cmd_4c_BtnImpXML
260:             .Caption         = "Importa XML"
261:             .Top             = 112
262:             .Left            = 818
263:             .Width           = 105
264:             .Height          = 45
265:             .Picture         = gc_4c_CaminhoIcones + "importar_48.png"
266:             .PicturePosition = 1
267:             .FontName        = "Comic Sans MS"
268:             .FontSize        = 8
269:             .FontBold        = .T.
270:             .FontItalic      = .T.
271:             .ForeColor       = RGB(90, 90, 90)
272:             .BackColor       = RGB(255, 255, 255)
273:             .Themes          = .F.
274:             .SpecialEffect   = 0
275:             .WordWrap        = .T.
276:             .ToolTipText     = "Importa Opera" + CHR(231) + CHR(227) + "o De Um Arquivo XML"
277:             .Visible         = .T.
278:         ENDWITH
279:         BINDEVENT(loc_oPagina.cmd_4c_BtnImpXML, "Click", THIS, "BtnImpXMLClick")
280: 
281:         *-- Grid principal de lista (Grade: Top=133+29=162, Left=12, W=940, H=458)
282:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
283:         WITH loc_oPagina.grd_4c_Lista
284:             .Top               = 162
285:             .Left              = 12
286:             .Width             = 940
287:             .Height            = 458
288:             .ColumnCount       = 2
289:             .FontName          = "Verdana"
290:             .FontSize          = 8

*-- Linhas 306 a 329:
306:             .Movable       = .F.
307:             .Resizable     = .F.
308:         ENDWITH
309:         loc_oPagina.grd_4c_Lista.Column1.Header1.Caption = "C" + CHR(243) + "digo"
310:         WITH loc_oPagina.grd_4c_Lista.Column2
311:             .ControlSource = "cursor_4c_Dados.descs"
312:             .Width         = 270
313:             .Movable       = .F.
314:             .Resizable     = .F.
315:         ENDWITH
316:         loc_oPagina.grd_4c_Lista.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
317:         THIS.FormatarGridLista(loc_oPagina.grd_4c_Lista)
318: 
319:         *-- Botoes CRUD dentro de cnt_4c_Botoes (Left=5/80/155/230/305, Top=5, W=75, H=75)
320:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
321:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
322:             .Caption         = "Incluir"
323:             .Top             = 5
324:             .Left            = 5
325:             .Width           = 75
326:             .Height          = 75
327:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
328:             .PicturePosition = 13
329:             .FontName        = "Comic Sans MS"

*-- Linhas 338 a 473:
338:             .MousePointer    = 15
339:             .Visible         = .T.
340:         ENDWITH
341:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
342: 
343:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
344:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
345:             .Caption         = "Visualizar"
346:             .Top             = 5
347:             .Left            = 80
348:             .Width           = 75
349:             .Height          = 75
350:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
351:             .PicturePosition = 13
352:             .FontName        = "Comic Sans MS"
353:             .FontSize        = 8
354:             .FontBold        = .T.
355:             .FontItalic      = .T.
356:             .ForeColor       = RGB(90, 90, 90)
357:             .BackColor       = RGB(255, 255, 255)
358:             .Themes          = .F.
359:             .SpecialEffect   = 0
360:             .WordWrap        = .T.
361:             .MousePointer    = 15
362:             .Visible         = .T.
363:         ENDWITH
364:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
365: 
366:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
367:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
368:             .Caption         = "Alterar"
369:             .Top             = 5
370:             .Left            = 155
371:             .Width           = 75
372:             .Height          = 75
373:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
374:             .PicturePosition = 13
375:             .FontName        = "Comic Sans MS"
376:             .FontSize        = 8
377:             .FontBold        = .T.
378:             .FontItalic      = .T.
379:             .ForeColor       = RGB(90, 90, 90)
380:             .BackColor       = RGB(255, 255, 255)
381:             .Themes          = .F.
382:             .SpecialEffect   = 0
383:             .WordWrap        = .T.
384:             .MousePointer    = 15
385:             .Visible         = .T.
386:         ENDWITH
387:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
388: 
389:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
390:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
391:             .Caption         = "Excluir"
392:             .Top             = 5
393:             .Left            = 230
394:             .Width           = 75
395:             .Height          = 75
396:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
397:             .PicturePosition = 13
398:             .FontName        = "Comic Sans MS"
399:             .FontSize        = 8
400:             .FontBold        = .T.
401:             .FontItalic      = .T.
402:             .ForeColor       = RGB(90, 90, 90)
403:             .BackColor       = RGB(255, 255, 255)
404:             .Themes          = .F.
405:             .SpecialEffect   = 0
406:             .WordWrap        = .T.
407:             .MousePointer    = 15
408:             .Visible         = .T.
409:         ENDWITH
410:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
411: 
412:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
413:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
414:             .Caption         = "Buscar"
415:             .Top             = 5
416:             .Left            = 305
417:             .Width           = 75
418:             .Height          = 75
419:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
420:             .PicturePosition = 13
421:             .FontName        = "Comic Sans MS"
422:             .FontSize        = 8
423:             .FontBold        = .T.
424:             .FontItalic      = .T.
425:             .ForeColor       = RGB(90, 90, 90)
426:             .BackColor       = RGB(255, 255, 255)
427:             .Themes          = .F.
428:             .SpecialEffect   = 0
429:             .WordWrap        = .T.
430:             .MousePointer    = 15
431:             .Visible         = .T.
432:         ENDWITH
433:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
434: 
435:         THIS.TornarControlesVisiveis(loc_oPagina)
436:     ENDPROC
437: 
438:     *==========================================================================
439:     * ConfigurarPaginaDados - Estrutura da Page2 (Dados)
440:     * Criados aqui: cnt_4c_Salva, cnt_4c_BotoesLinha, pgf_4c_Configuracao(shell)
441:     * TextBoxes e OptionGroups: Fases 5-6
442:     * Grids de configuracao: Fase 4
443:     *==========================================================================
444:     PROTECTED PROCEDURE ConfigurarPaginaDados()
445:         LOCAL loc_oPagina
446:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
447: 
448:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
449:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
450: 
451:         *-- Container Salvar/Cancelar (Grupo_Salva: Left=818, Top=10+29=39, W=160, H=85)
452:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
453:         WITH loc_oPagina.cnt_4c_Salva
454:             .Top         = 39
455:             .Left        = 818
456:             .Width       = 160
457:             .Height      = 85
458:             .BackStyle = 1
459:             .BackColor = RGB(255, 255, 255)
460:             .BorderWidth = 0
461:             .Visible     = .T.
462:         ENDWITH
463: 
464:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
465:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
466:             .Caption         = "Confirmar"
467:             .Top             = 5
468:             .Left            = 5
469:             .Width           = 75
470:             .Height          = 75
471:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
472:             .PicturePosition = 13
473:             .FontName        = "Comic Sans MS"

*-- Linhas 482 a 532:
482:             .MousePointer    = 15
483:             .Visible         = .T.
484:         ENDWITH
485:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
486: 
487:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
488:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
489:             .Caption         = "Encerrar"
490:             .Top             = 5
491:             .Left            = 80
492:             .Width           = 75
493:             .Height          = 75
494:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
495:             .PicturePosition = 13
496:             .FontName        = "Comic Sans MS"
497:             .FontSize        = 8
498:             .FontBold        = .T.
499:             .FontItalic      = .T.
500:             .ForeColor       = RGB(90, 90, 90)
501:             .BackColor       = RGB(255, 255, 255)
502:             .Themes          = .F.
503:             .SpecialEffect   = 0
504:             .WordWrap        = .T.
505:             .MousePointer    = 15
506:             .Visible         = .T.
507:         ENDWITH
508:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
509: 
510:         *-- Container botao Excluir Linha da grade (cmdBotoes: Top=361+29=390, Left=755, W=85)
511:         loc_oPagina.AddObject("cnt_4c_BotoesLinha", "Container")
512:         WITH loc_oPagina.cnt_4c_BotoesLinha
513:             .Top         = 390
514:             .Left        = 755
515:             .Width       = 85
516:             .Height      = 85
517:             .BackStyle = 1
518:             .BackColor = RGB(255, 255, 255)
519:             .BorderWidth = 0
520:             .Visible     = .T.
521:         ENDWITH
522: 
523:         loc_oPagina.cnt_4c_BotoesLinha.AddObject("cmd_4c_ExcluirLinha", "CommandButton")
524:         WITH loc_oPagina.cnt_4c_BotoesLinha.cmd_4c_ExcluirLinha
525:             .Caption         = "Excluir"
526:             .Top             = 5
527:             .Left            = 5
528:             .Width           = 75
529:             .Height          = 75
530:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
531:             .PicturePosition = 13
532:             .FontName        = "Comic Sans MS"

*-- Linhas 541 a 574:
541:             .MousePointer    = 15
542:             .Visible         = .T.
543:         ENDWITH
544:         BINDEVENT(loc_oPagina.cnt_4c_BotoesLinha.cmd_4c_ExcluirLinha, "Click", THIS, "BtnExcluirLinhaClick")
545: 
546:         *-- PageFrame Configuracao aninhado (Top=184+29=213, Left=-2, W=1003, H=420)
547:         loc_oPagina.AddObject("pgf_4c_Configuracao", "PageFrame")
548:         WITH loc_oPagina.pgf_4c_Configuracao
549:             .Top       = 213
550:             .Left      = -2
551:             .Width     = 1003
552:             .Height    = 420
553:             .PageCount = 2
554:             .Tabs      = .T.
555:             .Visible   = .T.
556:         ENDWITH
557:         loc_oPagina.pgf_4c_Configuracao.Page1.Caption = "Grupos de Produto"
558:         loc_oPagina.pgf_4c_Configuracao.Page2.Caption = "Custos Fixo"
559: 
560:         *-- =================================================================
561:         *-- CAMPOS PRINCIPAIS DA PAGE2 - PARTE 1 (Fase 5/8)
562:         *-- =================================================================
563: 
564:         *-- Label1: "Código : " (top=12+29=41, left=121, W=45, H=15)
565:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
566:         WITH loc_oPagina.lbl_4c_Label1
567:             .Caption   = "C" + CHR(243) + "digo : "
568:             .Top       = 41
569:             .Left      = 121
570:             .Width     = 45
571:             .Height    = 15
572:             .AutoSize  = .F.
573:             .FontName  = "Tahoma"
574:             .FontSize  = 8

*-- Linhas 584 a 608:
584:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
585:         WITH loc_oPagina.txt_4c_Codigo
586:             .Value     = ""
587:             .Top       = 37
588:             .Left      = 166
589:             .Width     = 34
590:             .Height    = 23
591:             .FontName  = "Tahoma"
592:             .FontSize  = 8
593:             .ForeColor = RGB(90, 90, 90)
594:             .MaxLength = 4
595:             .Visible   = .T.
596:         ENDWITH
597: 
598:         *-- Label2: "Descrição : " (top=12+29=41, left=215, W=58, H=15)
599:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
600:         WITH loc_oPagina.lbl_4c_Label2
601:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "
602:             .Top       = 41
603:             .Left      = 215
604:             .Width     = 58
605:             .Height    = 15
606:             .AutoSize  = .F.
607:             .FontName  = "Tahoma"
608:             .FontSize  = 8

*-- Linhas 617 a 641:
617:         loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
618:         WITH loc_oPagina.txt_4c_Descricao
619:             .Value     = ""
620:             .Top       = 37
621:             .Left      = 278
622:             .Width     = 290
623:             .Height    = 23
624:             .FontName  = "Tahoma"
625:             .FontSize  = 8
626:             .ForeColor = RGB(90, 90, 90)
627:             .MaxLength = 30
628:             .Visible   = .T.
629:         ENDWITH
630: 
631:         *-- Label3: "Valor do Feitio : " (top=37+29=66, left=86, W=80, H=15)
632:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
633:         WITH loc_oPagina.lbl_4c_Label3
634:             .Caption   = "Valor do Feitio : "
635:             .Top       = 66
636:             .Left      = 86
637:             .Width     = 80
638:             .Height    = 15
639:             .AutoSize  = .F.
640:             .FontName  = "Tahoma"
641:             .FontSize  = 8

*-- Linhas 650 a 659:
650:         loc_oPagina.AddObject("txt_4c_Valor", "TextBox")
651:         WITH loc_oPagina.txt_4c_Valor
652:             .Value     = 0
653:             .Top       = 63
654:             .Left      = 166
655:             .Width     = 150
656:             .Height    = 23
657:             .FontName  = "Tahoma"
658:             .FontSize  = 8
659:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 666 a 726:
666:         loc_oPagina.AddObject("opt_4c_TpFtio", "OptionGroup")
667:         WITH loc_oPagina.opt_4c_TpFtio
668:             .ButtonCount = 3
669:             .Top         = 62
670:             .Left        = 316
671:             .Width       = 283
672:             .Height      = 27
673:             .BackStyle   = 0
674:             .BorderStyle = 0
675:             .Value       = 1
676:             .Visible     = .T.
677:         ENDWITH
678:         WITH loc_oPagina.opt_4c_TpFtio.Buttons(1)
679:             .Caption   = "Por Peso"
680:             .BackStyle = 0
681:             .Left      = 5
682:             .Top       = 5
683:             .Width     = 70
684:             .AutoSize  = .T.
685:             .FontName  = "Tahoma"
686:             .FontSize  = 8
687:             .ForeColor = RGB(90, 90, 90)
688:             .Themes    = .F.
689:         ENDWITH
690:         WITH loc_oPagina.opt_4c_TpFtio.Buttons(2)
691:             .Caption   = "Valor Adicional"
692:             .BackStyle = 0
693:             .Left      = 80
694:             .Top       = 5
695:             .Width     = 65
696:             .AutoSize  = .T.
697:             .FontName  = "Tahoma"
698:             .FontSize  = 8
699:             .ForeColor = RGB(90, 90, 90)
700:             .Themes    = .F.
701:         ENDWITH
702:         WITH loc_oPagina.opt_4c_TpFtio.Buttons(3)
703:             .Caption   = "Informativo"
704:             .BackStyle = 0
705:             .Left      = 160
706:             .Top       = 5
707:             .Width     = 75
708:             .AutoSize  = .T.
709:             .FontName  = "Tahoma"
710:             .FontSize  = 8
711:             .ForeColor = RGB(90, 90, 90)
712:             .Themes    = .F.
713:         ENDWITH
714:         BINDEVENT(loc_oPagina.opt_4c_TpFtio, "InteractiveChange", THIS, "TpFtioChanged")
715: 
716:         *-- Label4: "Moeda : " (top=64+29=93, left=122, W=44, H=15)
717:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
718:         WITH loc_oPagina.lbl_4c_Label4
719:             .Caption   = "Moeda : "
720:             .Top       = 93
721:             .Left      = 122
722:             .Width     = 44
723:             .Height    = 15
724:             .AutoSize  = .F.
725:             .FontName  = "Tahoma"
726:             .FontSize  = 8

*-- Linhas 736 a 745:
736:         loc_oPagina.AddObject("txt_4c_CdMoeda", "TextBox")
737:         WITH loc_oPagina.txt_4c_CdMoeda
738:             .Value     = ""
739:             .Top       = 89
740:             .Left      = 166
741:             .Width     = 32
742:             .Height    = 23
743:             .FontName  = "Tahoma"
744:             .FontSize  = 8
745:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 753 a 778:
753:         loc_oPagina.AddObject("txt_4c_DsMoeda", "TextBox")
754:         WITH loc_oPagina.txt_4c_DsMoeda
755:             .Value     = ""
756:             .Top       = 89
757:             .Left      = 201
758:             .Width     = 115
759:             .Height    = 23
760:             .FontName  = "Tahoma"
761:             .FontSize  = 8
762:             .ForeColor = RGB(90, 90, 90)
763:             .MaxLength = 20
764:             .Visible   = .T.
765:         ENDWITH
766:         BINDEVENT(loc_oPagina.txt_4c_DsMoeda, "KeyPress", THIS, "ValidarDsMoeda")
767: 
768:         *-- Label5: "Multiplicador : " (top=64+29=93, left=401, W=71, H=15)
769:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
770:         WITH loc_oPagina.lbl_4c_Label5
771:             .Caption   = "Multiplicador : "
772:             .Top       = 93
773:             .Left      = 401
774:             .Width     = 71
775:             .Height    = 15
776:             .AutoSize  = .F.
777:             .FontName  = "Tahoma"
778:             .FontSize  = 8

*-- Linhas 787 a 811:
787:         loc_oPagina.AddObject("txt_4c_Acrescimo", "TextBox")
788:         WITH loc_oPagina.txt_4c_Acrescimo
789:             .Value     = 0
790:             .Top       = 89
791:             .Left      = 474
792:             .Width     = 94
793:             .Height    = 23
794:             .FontName  = "Tahoma"
795:             .FontSize  = 8
796:             .ForeColor = RGB(90, 90, 90)
797:             .InputMask = "999.9999"
798:             .Visible   = .T.
799:         ENDWITH
800: 
801:         *-- Label12: "sem uso :" (top=14+29=43, left=586, W=59) - OCULTO (Visible=.F. no original)
802:         loc_oPagina.AddObject("lbl_4c_Label12", "Label")
803:         WITH loc_oPagina.lbl_4c_Label12
804:             .Caption   = "sem uso :"
805:             .Top       = 43
806:             .Left      = 586
807:             .Width     = 59
808:             .Height    = 15
809:             .AutoSize  = .F.
810:             .FontName  = "Tahoma"
811:             .FontSize  = 8

*-- Linhas 819 a 846:
819:         loc_oPagina.AddObject("txt_4c_Lucro", "TextBox")
820:         WITH loc_oPagina.txt_4c_Lucro
821:             .Value     = 0
822:             .Top       = 39
823:             .Left      = 647
824:             .Width     = 50
825:             .Height    = 23
826:             .FontName  = "Tahoma"
827:             .FontSize  = 8
828:             .ForeColor = RGB(90, 90, 90)
829:             .Visible   = .F.
830:         ENDWITH
831: 
832:         *-- =================================================================
833:         *-- CAMPOS PRINCIPAIS DA PAGE2 - PARTE 2 (Fase 6/8)
834:         *-- =================================================================
835: 
836:         *-- lbl_4c_Label8: "Faixa de : " (top=90+29=119, left=113)
837:         loc_oPagina.AddObject("lbl_4c_Label8", "Label")
838:         WITH loc_oPagina.lbl_4c_Label8
839:             .Caption   = "Faixa de : "
840:             .Top       = 119
841:             .Left      = 113
842:             .Width     = 53
843:             .Height    = 15
844:             .AutoSize  = .F.
845:             .FontName  = "Tahoma"
846:             .FontSize  = 8

*-- Linhas 854 a 880:
854:         loc_oPagina.AddObject("txt_4c_FaixaI", "TextBox")
855:         WITH loc_oPagina.txt_4c_FaixaI
856:             .Value         = 0
857:             .Top           = 115
858:             .Left          = 166
859:             .Width         = 94
860:             .Height        = 23
861:             .InputMask     = "99999.999999"
862:             .Alignment     = 3
863:             .SpecialEffect = 1
864:             .FontName      = "Tahoma"
865:             .FontSize      = 8
866:             .ForeColor     = RGB(90, 90, 90)
867:             .Visible       = .T.
868:         ENDWITH
869: 
870:         *-- lbl_4c_Label9: "até" (top=90+29=119, left=266)
871:         loc_oPagina.AddObject("lbl_4c_Label9", "Label")
872:         WITH loc_oPagina.lbl_4c_Label9
873:             .Caption   = "at" + CHR(233)
874:             .Top       = 119
875:             .Left      = 266
876:             .Width     = 18
877:             .Height    = 15
878:             .AutoSize  = .T.
879:             .FontName  = "Tahoma"
880:             .FontSize  = 8

*-- Linhas 888 a 914:
888:         loc_oPagina.AddObject("txt_4c_Faixaf", "TextBox")
889:         WITH loc_oPagina.txt_4c_Faixaf
890:             .Value         = 0
891:             .Top           = 115
892:             .Left          = 290
893:             .Width         = 94
894:             .Height        = 23
895:             .InputMask     = "99999.999999"
896:             .Alignment     = 3
897:             .SpecialEffect = 1
898:             .FontName      = "Tahoma"
899:             .FontSize      = 8
900:             .ForeColor     = RGB(90, 90, 90)
901:             .Visible       = .T.
902:         ENDWITH
903: 
904:         *-- lbl_4c_Label11: "Perda do Metal : " (top=90+29=119, left=442)
905:         loc_oPagina.AddObject("lbl_4c_Label11", "Label")
906:         WITH loc_oPagina.lbl_4c_Label11
907:             .Caption   = "Perda do Metal : "
908:             .Top       = 119
909:             .Left      = 442
910:             .Width     = 84
911:             .Height    = 15
912:             .AutoSize  = .T.
913:             .FontName  = "Tahoma"
914:             .FontSize  = 8

*-- Linhas 922 a 947:
922:         loc_oPagina.AddObject("txt_4c_Perdas", "TextBox")
923:         WITH loc_oPagina.txt_4c_Perdas
924:             .Value         = 0
925:             .Top           = 115
926:             .Left          = 528
927:             .Width         = 40
928:             .Height        = 23
929:             .InputMask     = "99.9"
930:             .SpecialEffect = 1
931:             .FontName      = "Tahoma"
932:             .FontSize      = 8
933:             .ForeColor     = RGB(90, 90, 90)
934:             .Visible       = .T.
935:         ENDWITH
936: 
937:         *-- lbl_4c_Label6: "Tipo : " (top=113+29=142, left=134)
938:         loc_oPagina.AddObject("lbl_4c_Label6", "Label")
939:         WITH loc_oPagina.lbl_4c_Label6
940:             .Caption   = "Tipo : "
941:             .Top       = 142
942:             .Left      = 134
943:             .Width     = 32
944:             .Height    = 15
945:             .AutoSize  = .T.
946:             .FontName  = "Tahoma"
947:             .FontSize  = 8

*-- Linhas 955 a 1001:
955:         loc_oPagina.AddObject("opt_4c_CusVenda", "OptionGroup")
956:         WITH loc_oPagina.opt_4c_CusVenda
957:             .ButtonCount   = 2
958:             .Top           = 141
959:             .Left          = 161
960:             .Width         = 158
961:             .Height        = 17
962:             .BackStyle     = 0
963:             .BorderStyle   = 0
964:             .SpecialEffect = 0
965:             .Value         = 2
966:             .Visible       = .T.
967:         ENDWITH
968:         WITH loc_oPagina.opt_4c_CusVenda.Buttons(1)
969:             .Caption   = "Custo"
970:             .BackStyle = 0
971:             .Left      = 5
972:             .Top       = 1
973:             .AutoSize  = .T.
974:             .FontName  = "Tahoma"
975:             .FontSize  = 8
976:             .ForeColor = RGB(90, 90, 90)
977:             .Themes    = .F.
978:         ENDWITH
979:         WITH loc_oPagina.opt_4c_CusVenda.Buttons(2)
980:             .Caption   = "Venda"
981:             .BackStyle = 0
982:             .Left      = 98
983:             .Top       = 1
984:             .AutoSize  = .T.
985:             .FontName  = "Tahoma"
986:             .FontSize  = 8
987:             .ForeColor = RGB(90, 90, 90)
988:             .Themes    = .F.
989:         ENDWITH
990: 
991:         *-- lbl_4c_Label13: "Utilizado na Etiqueta : " (top=114+29=143, left=359)
992:         loc_oPagina.AddObject("lbl_4c_Label13", "Label")
993:         WITH loc_oPagina.lbl_4c_Label13
994:             .Caption   = "Utilizado na Etiqueta : "
995:             .Top       = 143
996:             .Left      = 359
997:             .Width     = 110
998:             .Height    = 15
999:             .AutoSize  = .T.
1000:             .FontName  = "Tahoma"
1001:             .FontSize  = 8

*-- Linhas 1009 a 1066:
1009:         loc_oPagina.AddObject("opt_4c_Etiquetas", "OptionGroup")
1010:         WITH loc_oPagina.opt_4c_Etiquetas
1011:             .ButtonCount   = 3
1012:             .Top           = 137
1013:             .Left          = 474
1014:             .Width         = 182
1015:             .Height        = 25
1016:             .BackStyle     = 0
1017:             .BorderStyle   = 0
1018:             .SpecialEffect = 0
1019:             .Value         = 3
1020:             .Visible       = .T.
1021:         ENDWITH
1022:         WITH loc_oPagina.opt_4c_Etiquetas.Buttons(1)
1023:             .Caption   = "Sim"
1024:             .BackStyle = 0
1025:             .Left      = 5
1026:             .Top       = 5
1027:             .AutoSize  = .T.
1028:             .FontName  = "Tahoma"
1029:             .FontSize  = 8
1030:             .ForeColor = RGB(90, 90, 90)
1031:             .Themes    = .F.
1032:         ENDWITH
1033:         WITH loc_oPagina.opt_4c_Etiquetas.Buttons(2)
1034:             .Caption   = "Sim - AU"
1035:             .BackStyle = 0
1036:             .Left      = 60
1037:             .Top       = 5
1038:             .AutoSize  = .T.
1039:             .FontName  = "Tahoma"
1040:             .FontSize  = 8
1041:             .ForeColor = RGB(90, 90, 90)
1042:             .Themes    = .F.
1043:         ENDWITH
1044:         WITH loc_oPagina.opt_4c_Etiquetas.Buttons(3)
1045:             .Caption   = "N" + CHR(227) + "o"
1046:             .BackStyle = 0
1047:             .Left      = 140
1048:             .Top       = 5
1049:             .AutoSize  = .T.
1050:             .FontName  = "Tahoma"
1051:             .FontSize  = 8
1052:             .ForeColor = RGB(90, 90, 90)
1053:             .Themes    = .F.
1054:         ENDWITH
1055: 
1056:         *-- lbl_4c_Label7: "Coeficiente Custo Fixo : " (top=133+29=162, left=46)
1057:         loc_oPagina.AddObject("lbl_4c_Label7", "Label")
1058:         WITH loc_oPagina.lbl_4c_Label7
1059:             .Caption   = "Coeficiente Custo Fixo : "
1060:             .Top       = 162
1061:             .Left      = 46
1062:             .Width     = 120
1063:             .Height    = 15
1064:             .AutoSize  = .T.
1065:             .FontName  = "Tahoma"
1066:             .FontSize  = 8

*-- Linhas 1074 a 1120:
1074:         loc_oPagina.AddObject("opt_4c_Cfixo", "OptionGroup")
1075:         WITH loc_oPagina.opt_4c_Cfixo
1076:             .ButtonCount   = 2
1077:             .Top           = 161
1078:             .Left          = 161
1079:             .Width         = 162
1080:             .Height        = 17
1081:             .BackStyle     = 0
1082:             .BorderStyle   = 0
1083:             .SpecialEffect = 0
1084:             .Value         = 1
1085:             .Visible       = .T.
1086:         ENDWITH
1087:         WITH loc_oPagina.opt_4c_Cfixo.Buttons(1)
1088:             .Caption   = "Multiplicador"
1089:             .BackStyle = 0
1090:             .Left      = 5
1091:             .Top       = 1
1092:             .AutoSize  = .T.
1093:             .FontName  = "Tahoma"
1094:             .FontSize  = 8
1095:             .ForeColor = RGB(90, 90, 90)
1096:             .Themes    = .F.
1097:         ENDWITH
1098:         WITH loc_oPagina.opt_4c_Cfixo.Buttons(2)
1099:             .Caption   = "Divisor"
1100:             .BackStyle = 0
1101:             .Left      = 98
1102:             .Top       = 1
1103:             .AutoSize  = .T.
1104:             .FontName  = "Tahoma"
1105:             .FontSize  = 8
1106:             .ForeColor = RGB(90, 90, 90)
1107:             .Themes    = .F.
1108:         ENDWITH
1109: 
1110:         *-- lbl_4c_Label10: "Aplicar Sobre Custo : " (top=153+29=182, left=60)
1111:         loc_oPagina.AddObject("lbl_4c_Label10", "Label")
1112:         WITH loc_oPagina.lbl_4c_Label10
1113:             .Caption   = "Aplicar Sobre Custo : "
1114:             .Top       = 182
1115:             .Left      = 60
1116:             .Width     = 106
1117:             .Height    = 15
1118:             .AutoSize  = .T.
1119:             .FontName  = "Tahoma"
1120:             .FontSize  = 8

*-- Linhas 1128 a 1161:
1128:         loc_oPagina.AddObject("opt_4c_Fwoption1", "OptionGroup")
1129:         WITH loc_oPagina.opt_4c_Fwoption1
1130:             .ButtonCount   = 2
1131:             .Top           = 180
1132:             .Left          = 161
1133:             .Width         = 144
1134:             .Height        = 19
1135:             .BackStyle     = 0
1136:             .BorderStyle   = 0
1137:             .SpecialEffect = 0
1138:             .Value         = 2
1139:             .Visible       = .T.
1140:         ENDWITH
1141:         WITH loc_oPagina.opt_4c_Fwoption1.Buttons(1)
1142:             .Caption   = "Sim"
1143:             .BackStyle = 0
1144:             .Left      = 5
1145:             .Top       = 2
1146:             .AutoSize  = .T.
1147:             .FontName  = "Tahoma"
1148:             .FontSize  = 8
1149:             .ForeColor = RGB(90, 90, 90)
1150:             .Themes    = .F.
1151:         ENDWITH
1152:         WITH loc_oPagina.opt_4c_Fwoption1.Buttons(2)
1153:             .Caption   = "N" + CHR(227) + "o"
1154:             .BackStyle = 0
1155:             .Left      = 98
1156:             .Top       = 2
1157:             .AutoSize  = .T.
1158:             .FontName  = "Tahoma"
1159:             .FontSize  = 8
1160:             .ForeColor = RGB(90, 90, 90)
1161:             .Themes    = .F.

*-- Linhas 1176 a 1185:
1176:         *-- grd_4c_Grade (Grupos de Produto: Top=16, Left=234, W=521, H=371, RecordSource=csGrade)
1177:         loc_oPgGrupos.AddObject("grd_4c_Grade", "Grid")
1178:         WITH loc_oPgGrupos.grd_4c_Grade
1179:             .Top               = 16
1180:             .Left              = 234
1181:             .Width             = 521
1182:             .Height            = 371
1183:             .ColumnCount       = 5
1184:             .FontName          = "Tahoma"
1185:             .FontSize          = 8

*-- Linhas 1201 a 1244:
1201:             .Movable       = .F.
1202:             .Resizable     = .F.
1203:         ENDWITH
1204:         loc_oPgGrupos.grd_4c_Grade.Column1.Header1.Caption = "Grupo"
1205:         WITH loc_oPgGrupos.grd_4c_Grade.Column2
1206:             .ColumnOrder   = 4
1207:             .ControlSource = "csGrade.Dgrus"
1208:             .Width         = 224
1209:             .Movable       = .F.
1210:             .Resizable     = .F.
1211:         ENDWITH
1212:         loc_oPgGrupos.grd_4c_Grade.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1213:         WITH loc_oPgGrupos.grd_4c_Grade.Column3
1214:             .ColumnOrder   = 5
1215:             .ControlSource = "csGrade.Coefs"
1216:             .Width         = 70
1217:             .Movable       = .F.
1218:             .Resizable     = .F.
1219:             .Sparse        = .F.
1220:         ENDWITH
1221:         loc_oPgGrupos.grd_4c_Grade.Column3.Header1.Caption = "Coeficiente"
1222:         loc_oPgGrupos.grd_4c_Grade.Column3.Text1.InputMask = "999.9999"
1223:         WITH loc_oPgGrupos.grd_4c_Grade.Column4
1224:             .ColumnOrder   = 3
1225:             .ControlSource = "csGrade.CPros"
1226:             .Width         = 108
1227:             .Movable       = .F.
1228:             .Resizable     = .F.
1229:             .Sparse        = .F.
1230:         ENDWITH
1231:         loc_oPgGrupos.grd_4c_Grade.Column4.Header1.Caption = "Produto"
1232:         WITH loc_oPgGrupos.grd_4c_Grade.Column5
1233:             .ColumnOrder   = 1
1234:             .ControlSource = "csGrade.Ordem"
1235:             .Width         = 42
1236:             .Movable       = .F.
1237:             .Resizable     = .F.
1238:         ENDWITH
1239:         loc_oPgGrupos.grd_4c_Grade.Column5.Header1.Caption = "Ordem"
1240:         loc_oPgGrupos.grd_4c_Grade.Column2.ReadOnly = .T.
1241:         BINDEVENT(loc_oPgGrupos.grd_4c_Grade.Column1.Text1, "When",      THIS, "GradeGrupoCol1When")
1242:         BINDEVENT(loc_oPgGrupos.grd_4c_Grade.Column1.Text1, "Valid",     THIS, "GradeGrupoCol1Valid")
1243:         BINDEVENT(loc_oPgGrupos.grd_4c_Grade.Column3.Text1, "When",      THIS, "GradeGrupoCol3When")
1244:         BINDEVENT(loc_oPgGrupos.grd_4c_Grade.Column3.Text1, "KeyPress", THIS, "GradeGrupoCol3LostFocus")

*-- Linhas 1257 a 1266:
1257:         *-- grd_4c_Custo (Custo Fixo: Top=16, Left=278, W=478, H=371, RecordSource=csCusto)
1258:         loc_oPgCusto.AddObject("grd_4c_Custo", "Grid")
1259:         WITH loc_oPgCusto.grd_4c_Custo
1260:             .Top               = 16
1261:             .Left              = 278
1262:             .Width             = 478
1263:             .Height            = 371
1264:             .ColumnCount       = 4
1265:             .FontName          = "Tahoma"
1266:             .FontSize          = 8

*-- Linhas 1281 a 1316:
1281:             .Movable       = .F.
1282:             .Resizable     = .F.
1283:         ENDWITH
1284:         loc_oPgCusto.grd_4c_Custo.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1285:         WITH loc_oPgCusto.grd_4c_Custo.Column2
1286:             .ControlSource = "csCusto.Dpros"
1287:             .Width         = 190
1288:             .Movable       = .F.
1289:             .Resizable     = .F.
1290:         ENDWITH
1291:         loc_oPgCusto.grd_4c_Custo.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1292:         loc_oPgCusto.grd_4c_Custo.Column2.ReadOnly = .T.
1293:         WITH loc_oPgCusto.grd_4c_Custo.Column3
1294:             .ColumnOrder   = 4
1295:             .ControlSource = "csCusto.Coefs"
1296:             .Width         = 70
1297:             .Movable       = .F.
1298:             .Resizable     = .F.
1299:             .Sparse        = .F.
1300:         ENDWITH
1301:         loc_oPgCusto.grd_4c_Custo.Column3.Header1.Caption = "Coeficiente"
1302:         loc_oPgCusto.grd_4c_Custo.Column3.Text1.InputMask = "999.9999"
1303:         WITH loc_oPgCusto.grd_4c_Custo.Column4
1304:             .ColumnOrder   = 3
1305:             .ControlSource = "csCusto.Seqs"
1306:             .Width         = 75
1307:             .Movable       = .F.
1308:             .Resizable     = .F.
1309:             .Sparse        = .F.
1310:         ENDWITH
1311:         loc_oPgCusto.grd_4c_Custo.Column4.Header1.Caption = "Sequencia"
1312:         loc_oPgCusto.grd_4c_Custo.Column4.Text1.InputMask = "99999"
1313:         BINDEVENT(loc_oPgCusto.grd_4c_Custo.Column1.Text1, "When",      THIS, "GradeCustoCol1When")
1314:         BINDEVENT(loc_oPgCusto.grd_4c_Custo.Column1.Text1, "Valid",     THIS, "GradeCustoCol1Valid")
1315:         BINDEVENT(loc_oPgCusto.grd_4c_Custo.Column3.Text1, "When",      THIS, "GradeCustoCol3When")
1316:         BINDEVENT(loc_oPgCusto.grd_4c_Custo.Column3.Text1, "KeyPress", THIS, "GradeCustoCol3LostFocus")

*-- Linhas 1340 a 1349:
1340:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1341:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
1342:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
1343:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1344:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1345:                     loc_oGrid.Refresh()
1346:                 ENDIF
1347:                 loc_lResultado = .T.
1348:             ENDIF
1349:         CATCH TO loException

*-- Linhas 1677 a 1687:
1677:         loc_oPg2.opt_4c_Fwoption1.Enabled = par_lHabilitar
1678:         loc_oPg2.opt_4c_Etiquetas.Enabled = par_lHabilitar
1679: 
1680:         loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = par_lHabilitar
1681:         loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
1682:         loc_oPg2.cnt_4c_BotoesLinha.cmd_4c_ExcluirLinha.Enabled = par_lHabilitar
1683: 
1684:         IF PEMSTATUS(loc_oPg2.pgf_4c_Configuracao.Page1, "grd_4c_Grade", 5)
1685:             loc_oPg2.pgf_4c_Configuracao.Page1.grd_4c_Grade.ReadOnly = !par_lHabilitar
1686:         ENDIF
1687:         IF PEMSTATUS(loc_oPg2.pgf_4c_Configuracao.Page2, "grd_4c_Custo", 5)

*-- Linhas 1698 a 1711:
1698:         loc_lEditando    = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1699:         loc_lVisualizando = (THIS.this_cModoAtual = "VISUALIZAR")
1700: 
1701:         IF PEMSTATUS(loc_oBotoes, "cmd_4c_Incluir", 5)
1702:             loc_oBotoes.cmd_4c_Incluir.Enabled    = !loc_lEditando AND !loc_lVisualizando
1703:             loc_oBotoes.cmd_4c_Alterar.Enabled    = !loc_lEditando AND !loc_lVisualizando
1704:             loc_oBotoes.cmd_4c_Excluir.Enabled    = !loc_lEditando AND !loc_lVisualizando
1705:             loc_oBotoes.cmd_4c_Visualizar.Enabled = !loc_lEditando AND !loc_lVisualizando
1706:             loc_oBotoes.cmd_4c_Buscar.Enabled     = !loc_lEditando AND !loc_lVisualizando
1707:         ENDIF
1708:     ENDPROC
1709: 
1710:     *==========================================================================
1711:     * CarregarItensNaGrade - Carrega SigPrFto nos cursores csGrade e csCusto

*-- Linhas 1793 a 1813:
1793:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1794:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1795: 
1796:             IF VARTYPE(loc_oObjeto) = "O"
1797:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1798:                     IF !INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_SOMBRA")
1799:                         loc_oObjeto.Visible = .T.
1800:                     ENDIF
1801:                 ENDIF
1802: 
1803:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1804:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1805:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1806:                     ENDFOR
1807:                 ENDIF
1808: 
1809:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
1810:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1811:                 ENDIF
1812:             ENDIF
1813:         ENDFOR

*-- Linhas 1962 a 1971:
1962:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1963:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
1964:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
1965:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1966:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1967:                     loc_oGrid.Refresh()
1968:                 ENDIF
1969:                 IF RECCOUNT("cursor_4c_Dados") = 0
1970:                     MsgAviso("Nenhum registro encontrado.", "Buscar")
1971:                 ENDIF

*-- Linhas 2135 a 2143:
2135:         ENDIF
2136: 
2137:         IF PEMSTATUS(loc_oPg2.pgf_4c_Configuracao.Page2, "grd_4c_Custo", 5)
2138:             loc_oPg2.pgf_4c_Configuracao.Page2.grd_4c_Custo.Column3.Header1.Caption = loc_cCaption
2139:             loc_oPg2.pgf_4c_Configuracao.Page2.grd_4c_Custo.Column3.Header1.Refresh()
2140:         ENDIF
2141:     ENDPROC
2142: 
2143:     *==========================================================================


### BO (C:\4c\projeto\app\classes\FtiBO.prg):
*==============================================================================
* FtiBO.prg - Business Object para Cadastro de Feitios
* Tabela principal : SigPrFti (cods = PK)
* Tabela de itens  : SigPrFto (cidchaves = PK)
* Gerado           : Fase 1/8 - Propriedades e Init
*==============================================================================

DEFINE CLASS FtiBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades herdadas (nomes CORRETOS do BusinessBase)
    *--------------------------------------------------------------------------
    this_cTabela      = "SigPrFti"
    this_cCampoChave  = "cods"

    *--------------------------------------------------------------------------
    * Campos de SigPrFti
    *--------------------------------------------------------------------------
    this_cCodigo      = ""    && cods       char(2)  PK
    this_cDescricao   = ""    && descs      char(20)
    this_nValor       = 0     && valors     numeric(11,2)
    this_cMoeda       = ""    && moedas     char(3)
    this_nAcrescimo   = 0     && acrescs    numeric(11,6)
    this_nTipoFeitio  = 1     && tpftios    numeric(1,0)  1=Por Peso 2=Valor Adicional 3=Informativo
    this_nFaixaInicial = 0    && faixais    numeric(11,6)
    this_nFaixaFinal  = 0     && faixafs    numeric(11,6)
    this_nPerdas      = 0     && perdas     numeric(3,1)
    this_nLucros      = 0     && lucros     numeric(5,2)
    this_nDivMult     = 1     && divmults   numeric(1,0)  1=Multiplicador 2=Divisor
    this_nTipo        = 2     && tipos      numeric(1,0)  1=Custo 2=Venda
    this_nAplscus     = 2     && aplscus    numeric(1,0)  1=Sim 2=Nao
    this_nEtiquetas   = 3     && etiquetas  numeric(1,0)  1=Sim 2=Sim-AU 3=Nao
    this_cMcustos     = ""    && mcustos    char(3)
    this_nVcustos     = 0     && vcustos    numeric(11,2)
    this_cUsuarios    = ""    && usuars     char(10)
    this_dDataRs      = {}    && datars     datetime

    *--------------------------------------------------------------------------
    * Propriedades auxiliares de controle
    *--------------------------------------------------------------------------
    this_cDescMoeda   = ""    && descricao da moeda (SigCdMoe.dmoes) - nao salvo
    this_lNovoRegistro = .F.

    *==========================================================================
    * Init - Configura tabela e campo chave
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigPrFti"
        THIS.this_cCampoChave = "cods"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDFUNC

    *==========================================================================
    * NovoRegistro - Prepara BO para INSERT
    *==========================================================================
    PROCEDURE NovoRegistro()
        DODEFAULT()
        THIS.this_cCodigo       = ""
        THIS.this_cDescricao    = ""
        THIS.this_nValor        = 0
        THIS.this_cMoeda        = ""
        THIS.this_cDescMoeda    = ""
        THIS.this_nAcrescimo    = 0
        THIS.this_nTipoFeitio   = 1
        THIS.this_nFaixaInicial = 0
        THIS.this_nFaixaFinal   = 0
        THIS.this_nPerdas       = 0
        THIS.this_nLucros       = 0
        THIS.this_nDivMult      = 1
        THIS.this_nTipo         = 2
        THIS.this_nAplscus      = 2
        THIS.this_nEtiquetas    = 3
        THIS.this_cMcustos      = ""
        THIS.this_nVcustos      = 0
        THIS.this_cUsuarios     = ""
        THIS.this_dDataRs       = {}
        THIS.this_lNovoRegistro = .T.
    ENDPROC

    *==========================================================================
    * EditarRegistro - Prepara BO para UPDATE
    *==========================================================================
    PROCEDURE EditarRegistro()
        DODEFAULT()
        THIS.this_lNovoRegistro = .F.
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo       = ALLTRIM(TratarNulo(cods,      "C"))
            THIS.this_cDescricao    = ALLTRIM(TratarNulo(descs,     "C"))
            THIS.this_nValor        = TratarNulo(valors,    "N")
            THIS.this_cMoeda        = ALLTRIM(TratarNulo(moedas,    "C"))
            THIS.this_nAcrescimo    = TratarNulo(acrescs,   "N")
            THIS.this_nTipoFeitio   = TratarNulo(tpftios,   "N")
            THIS.this_nFaixaInicial = TratarNulo(faixais,   "N")
            THIS.this_nFaixaFinal   = TratarNulo(faixafs,   "N")
            THIS.this_nPerdas       = TratarNulo(perdas,    "N")
            THIS.this_nLucros       = TratarNulo(lucros,    "N")
            THIS.this_nDivMult      = TratarNulo(divmults,  "N")
            THIS.this_nTipo         = TratarNulo(tipos,     "N")
            THIS.this_nAplscus      = TratarNulo(aplscus,   "N")
            THIS.this_nEtiquetas    = TratarNulo(etiquetas, "N")
            THIS.this_cMcustos      = ALLTRIM(TratarNulo(mcustos,   "C"))
            THIS.this_nVcustos      = TratarNulo(vcustos,   "N")
            THIS.this_cUsuarios     = ALLTRIM(TratarNulo(usuars,    "C"))
            THIS.this_dDataRs       = TratarNulo(datars,    "D")
            THIS.this_lNovoRegistro = .F.
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Buscar - Lista registros de SigPrFti (PUBLIC)
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT cods, descs, valors, moedas, acrescs, tpftios" + ;
                       " FROM SigPrFti" + ;
                       " ORDER BY cods"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = "SELECT cods, descs, valors, moedas, acrescs, tpftios" + ;
                           " FROM SigPrFti" + ;
                           " WHERE " + par_cFiltro + ;
                           " ORDER BY cods"
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados") > 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar feitios:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FtiBO.Buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pelo codigo (PUBLIC)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT cods, descs, valors, moedas, acrescs, tpftios," + ;
                       " faixais, faixafs, perdas, lucros, divmults, tipos," + ;
                       " aplscus, etiquetas, mcustos, vcustos, usuars, datars" + ;
                       " FROM SigPrFti" + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(par_cCodigo))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega") > 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ELSE
                MsgErro("Erro ao carregar feitio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FtiBO.CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir - INSERT em SigPrFti (PROTECTED - chamado por BusinessBase.Salvar)
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigPrFti" + ;
                       " (cods, descs, valors, moedas, acrescs, tpftios," + ;
                       "  faixais, faixafs, perdas, lucros, divmults, tipos," + ;
                       "  aplscus, etiquetas, mcustos, vcustos, usuars, datars)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigo)                          + ", " + ;
                       EscaparSQL(THIS.this_cDescricao)                       + ", " + ;
                       FormatarNumeroSQL(THIS.this_nValor)                    + ", " + ;
                       EscaparSQL(THIS.this_cMoeda)                           + ", " + ;
                       FormatarNumeroSQL(THIS.this_nAcrescimo)                + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTipoFeitio)               + ", " + ;
                       FormatarNumeroSQL(THIS.this_nFaixaInicial)             + ", " + ;
                       FormatarNumeroSQL(THIS.this_nFaixaFinal)               + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPerdas)                   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLucros)                   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nDivMult)                  + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTipo)                     + ", " + ;
                       FormatarNumeroSQL(THIS.this_nAplscus)                  + ", " + ;
                       FormatarNumeroSQL(THIS.this_nEtiquetas)                + ", " + ;
                       EscaparSQL(THIS.this_cMcustos)                         + ", " + ;
                       FormatarNumeroSQL(THIS.this_nVcustos)                  + ", " + ;
                       EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado))               + ", " + ;
                       "GETDATE()" + ;
                       ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir feitio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FtiBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE em SigPrFti (PROTECTED - chamado por BusinessBase.Salvar)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigPrFti SET" + ;
                       "  descs    = " + EscaparSQL(THIS.this_cDescricao)          + ", " + ;
                       "  valors   = " + FormatarNumeroSQL(THIS.this_nValor)        + ", " + ;
                       "  moedas   = " + EscaparSQL(THIS.this_cMoeda)              + ", " + ;
                       "  acrescs  = " + FormatarNumeroSQL(THIS.this_nAcrescimo)    + ", " + ;
                       "  tpftios  = " + FormatarNumeroSQL(THIS.this_nTipoFeitio)   + ", " + ;
                       "  faixais  = " + FormatarNumeroSQL(THIS.this_nFaixaInicial) + ", " + ;
                       "  faixafs  = " + FormatarNumeroSQL(THIS.this_nFaixaFinal)   + ", " + ;
                       "  perdas   = " + FormatarNumeroSQL(THIS.this_nPerdas)       + ", " + ;
                       "  lucros   = " + FormatarNumeroSQL(THIS.this_nLucros)       + ", " + ;
                       "  divmults = " + FormatarNumeroSQL(THIS.this_nDivMult)      + ", " + ;
                       "  tipos    = " + FormatarNumeroSQL(THIS.this_nTipo)         + ", " + ;
                       "  aplscus  = " + FormatarNumeroSQL(THIS.this_nAplscus)      + ", " + ;
                       "  etiquetas= " + FormatarNumeroSQL(THIS.this_nEtiquetas)    + ", " + ;
                       "  mcustos  = " + EscaparSQL(THIS.this_cMcustos)            + ", " + ;
                       "  vcustos  = " + FormatarNumeroSQL(THIS.this_nVcustos)      + ", " + ;
                       "  usuars   = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado))  + ", " + ;
                       "  datars   = GETDATE()" + ;
                       " WHERE cods = " + EscaparSQL(THIS.this_cCodigo)

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar feitio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FtiBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - DELETE em SigPrFti + SigPrFto (PROTECTED)
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrFto WHERE cods = " + EscaparSQL(THIS.this_cCodigo)
            IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                MsgErro("Erro ao excluir itens do feitio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_cSQL = "DELETE FROM SigPrFti WHERE cods = " + EscaparSQL(THIS.this_cCodigo)
                IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir feitio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FtiBO.ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarItens - Carrega itens de SigPrFto para o cursor de grade (PUBLIC)
    * Popula cursores csGrade (grupos) e csCusto (custos fixo)
    *==========================================================================
    PROCEDURE CarregarItens(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Itens")
                USE IN cursor_4c_Itens
            ENDIF

            loc_cSQL = "SELECT cgrus, cpros, coefs, cidchaves, sgrus, ordem, seqs" + ;
                       " FROM SigPrFto" + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(par_cCodigo)) + ;
                       " ORDER BY seqs"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Itens") > 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar itens do feitio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FtiBO.CarregarItens:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * SalvarItens - Persiste cursores csGrade e csCusto em SigPrFto (PUBLIC)
    * Deleta itens anteriores e reinsere (igual ao legado)
    *==========================================================================
    PROCEDURE SalvarItens(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.

        TRY
            LOCAL loc_lErro
            loc_lErro = .F.

            loc_cSQL = "DELETE FROM SigPrFto WHERE cods = " + EscaparSQL(ALLTRIM(par_cCodigo))
            IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                MsgErro("Erro ao limpar itens do feitio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lErro = .T.
            ENDIF

            IF USED("csGrade") AND !loc_lErro
                SELECT csGrade
                GO TOP
                SCAN
                    IF (!EMPTY(ALLTRIM(csGrade.Cgrus)) AND csGrade.Coefs <> 0) OR ;
                       (csGrade.Ordem <> 0 AND csGrade.Coefs <> 0)
                        loc_cSQL = "INSERT INTO SigPrFto" + ;
                                   " (cods, cgrus, cpros, coefs, cidchaves, ordem, seqs, calcfeitio, sgrus)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(ALLTRIM(par_cCodigo))      + ", " + ;
                                   EscaparSQL(ALLTRIM(csGrade.Cgrus))    + ", " + ;
                                   EscaparSQL(ALLTRIM(csGrade.CPros))    + ", " + ;
                                   FormatarNumeroSQL(csGrade.Coefs)      + ", " + ;
                                   EscaparSQL(fUniqueIds())              + ", " + ;
                                   FormatarNumeroSQL(csGrade.Ordem)      + ", " + ;
                                   "0"                                   + ", " + ;
                                   "0"                                   + ", " + ;
                                   "''" + ;
                                   ")"
                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                            MsgErro("Erro ao inserir grupo no feitio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lErro = .T.
                            EXIT
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

            IF USED("csCusto") AND !loc_lErro
                SELECT csCusto
                GO TOP
                SCAN
                    IF !EMPTY(ALLTRIM(csCusto.Cpros)) AND csCusto.Coefs <> 0
                        loc_cSQL = "INSERT INTO SigPrFto" + ;
                                   " (cods, cgrus, cpros, coefs, cidchaves, seqs, calcfeitio, sgrus, ordem)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(ALLTRIM(par_cCodigo))      + ", " + ;
                                   "''"                                  + ", " + ;
                                   EscaparSQL(ALLTRIM(csCusto.Cpros))    + ", " + ;
                                   FormatarNumeroSQL(csCusto.Coefs)      + ", " + ;
                                   EscaparSQL(fUniqueIds())              + ", " + ;
                                   FormatarNumeroSQL(csCusto.Seqs)       + ", " + ;
                                   "0"                                   + ", " + ;
                                   "''"                                  + ", " + ;
                                   "0" + ;
                                   ")"
                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                            MsgErro("Erro ao inserir custo fixo no feitio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lErro = .T.
                            EXIT
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

            IF !loc_lErro
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FtiBO.SalvarItens:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarParametros - Carrega cursores auxiliares necessarios ao form (PUBLIC)
    * CrSigCdMoe (moedas), CrSigCdGrp (grupos produto), CrSigCdPro (produtos)
    *==========================================================================
    PROCEDURE CarregarParametros()
        LOCAL loc_lResultado, loc_cSQL, loc_cGrupoCfxs
        loc_lResultado = .F.

        TRY
            IF USED("CrSigCdMoe")
                USE IN CrSigCdMoe
            ENDIF
            loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdMoe") < 1
                MsgErro("Erro ao carregar moedas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ENDIF
            SELECT CrSigCdMoe
            INDEX ON cmoes TAG CMoes

            IF USED("TmpParac")
                USE IN TmpParac
            ENDIF
            loc_cSQL = "SELECT CgruCfxs FROM SigCdPac"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpParac") < 1
                MsgErro("Erro ao carregar parametros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ENDIF
            IF RECCOUNT("TmpParac") > 0
                SELECT TmpParac
                GO TOP
                loc_cGrupoCfxs = ALLTRIM(TmpParac.CgruCfxs)
            ELSE
                loc_cGrupoCfxs = ""
            ENDIF

            IF USED("CrSigCdGrp")
                USE IN CrSigCdGrp
            ENDIF
            loc_cSQL = "SELECT Cgrus, Dgrus, Coefs FROM SigCdGrp"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdGrp") < 1
                MsgErro("Erro ao carregar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ENDIF
            SELECT CrSigCdGrp
            INDEX ON Cgrus TAG Cgrus

            IF USED("CrSigCdPro")
                USE IN CrSigCdPro
            ENDIF
            IF !EMPTY(loc_cGrupoCfxs)
                loc_cSQL = "SELECT Cpros, Dpros, pVens FROM SigCdPro" + ;
                           " WHERE Cgrus = " + EscaparSQL(loc_cGrupoCfxs)
            ELSE
                loc_cSQL = "SELECT Cpros, Dpros, pVens FROM SigCdPro"
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdPro") < 1
                MsgErro("Erro ao carregar produtos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ENDIF
            SELECT CrSigCdPro
            INDEX ON cpros TAG Cpros

            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro em FtiBO.CarregarParametros:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarDuplicidade - Verifica duplicidade de grupos e custos na grade (PUBLIC)
    *==========================================================================
    PROCEDURE ValidarDuplicidade()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .T.

        TRY
            IF USED("CsDuplica")
                USE IN CsDuplica
            ENDIF

            SELECT Cgrus, CPros, SUM(1) AS Tot FROM csGrade ;
                WHERE Cgrus <> ' ' ;
                GROUP BY Cgrus, CPros ;
                INTO CURSOR CsDuplica ;
                HAVING SUM(1) > 1

            IF RECCOUNT("CsDuplica") > 0
                MsgAviso("Existem Grupos/Produtos configurados em duplicidade!", "Valida" + CHR(231) + CHR(227) + "o")
                USE IN CsDuplica
                loc_lResultado = .F.
            ENDIF
            IF USED("CsDuplica")
                USE IN CsDuplica
            ENDIF

            SELECT Cpros, SUM(1) AS Tot FROM csCusto ;
                WHERE Cpros <> ' ' ;
                GROUP BY Cpros ;
                INTO CURSOR CsDuplica ;
                HAVING SUM(1) > 1

            IF RECCOUNT("CsDuplica") > 0
                MsgAviso("Existem Custos Fixo configurados em duplicidade!", "Valida" + CHR(231) + CHR(227) + "o")
                USE IN CsDuplica
                loc_lResultado = .F.
            ENDIF
            IF USED("CsDuplica")
                USE IN CsDuplica
            ENDIF

            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro em FtiBO.ValidarDuplicidade:" + CHR(13) + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarFaixa - Valida que o acrescimo esta dentro da faixa (PUBLIC)
    *==========================================================================
    PROCEDURE ValidarFaixa()
        IF THIS.this_nFaixaFinal > 0
            IF !BETWEEN(THIS.this_nAcrescimo, THIS.this_nFaixaInicial, THIS.this_nFaixaFinal)
                MsgAviso("O multiplicador tem que estar dentro da Faixa!", "Valida" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF
        ENDIF
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ValidarConflitoCampos - Valida que Multiplicador/Valor nao coexistem com grade (PUBLIC)
    *==========================================================================
    PROCEDURE ValidarConflitoCampos()
        LOCAL loc_lResultado
        loc_lResultado = .T.

        TRY
            IF THIS.this_nAcrescimo <> 0 OR THIS.this_nValor <> 0
                IF USED("ChkDados")
                    USE IN ChkDados
                ENDIF

                SELECT " " AS Agrupar, SUM(1) AS Tot FROM csGrade ;
                    WHERE Cgrus <> ' ' AND Coefs <> 0 ;
                    INTO CURSOR ChkDados GROUP BY 1

                SELECT ChkDados
                GO TOP
                IF Tot > 0
                    MsgAviso("O Campo Multiplicador Ou Valor n" + CHR(227) + "o podem ser informados" + ;
                             CHR(13) + "em conjunto com grade de custos", "Valida" + CHR(231) + CHR(227) + "o")
                    USE IN ChkDados
                    loc_lResultado = .F.
                ENDIF

                SELECT " " AS Agrupar, SUM(1) AS Tot FROM csCusto ;
                    WHERE Cpros <> ' ' ;
                    INTO CURSOR ChkDados GROUP BY 1

                SELECT ChkDados
                GO TOP
                IF Tot > 0
                    MsgAviso("O Campo Multiplicador Ou Valor n" + CHR(227) + "o podem ser informados" + ;
                             CHR(13) + "em conjunto com grade de custos", "Valida" + CHR(231) + CHR(227) + "o")
                    USE IN ChkDados
                    loc_lResultado = .F.
                ENDIF

                IF USED("ChkDados")
                    USE IN ChkDados
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FtiBO.ValidarConflitoCampos:" + CHR(13) + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * VerificarCodigoExistente - Verifica se codigo ja existe (para INSERT) (PUBLIC)
    *==========================================================================
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_lExiste, loc_cSQL
        loc_lExiste = .F.

        TRY
            IF USED("cursor_4c_Chk")
                USE IN cursor_4c_Chk
            ENDIF

            loc_cSQL = "SELECT cods FROM SigPrFti WHERE cods = " + EscaparSQL(ALLTRIM(par_cCodigo))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Chk") > 0
                loc_lExiste = (RECCOUNT("cursor_4c_Chk") > 0)
            ENDIF

            IF USED("cursor_4c_Chk")
                USE IN cursor_4c_Chk
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FtiBO.VerificarCodigoExistente:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *==========================================================================
    * Destroy
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_aCursores(9), loc_i
        loc_aCursores(1) = "cursor_4c_Dados"
        loc_aCursores(2) = "cursor_4c_Carrega"
        loc_aCursores(3) = "cursor_4c_Itens"
        loc_aCursores(4) = "cursor_4c_Chk"
        loc_aCursores(5) = "CrSigCdMoe"
        loc_aCursores(6) = "TmpParac"
        loc_aCursores(7) = "CrSigCdGrp"
        loc_aCursores(8) = "CrSigCdPro"
        loc_aCursores(9) = "ChkDados"

        FOR loc_i = 1 TO ALEN(loc_aCursores)
            IF USED(loc_aCursores(loc_i))
                USE IN (loc_aCursores(loc_i))
            ENDIF
        ENDFOR

        DODEFAULT()
    ENDPROC

ENDDEFINE

