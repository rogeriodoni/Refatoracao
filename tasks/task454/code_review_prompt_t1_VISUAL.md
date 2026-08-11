# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (10)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 195: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 220: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 245: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 270: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 295: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 334: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 363: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 673: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 697: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormJrn.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2089 linhas total):

*-- Linhas 83 a 106:
83: 
84:         WITH THIS.pgf_4c_Paginas
85:             .PageCount  = 2
86:             .Top        = -29
87:             .Left       = 0
88:             .Width      = THIS.Width
89:             .Height     = THIS.Height + 29
90:             .Tabs       = .F.
91:             .TabStretch = 1
92:             .Visible    = .T.
93:         ENDWITH
94: 
95:         WITH THIS.pgf_4c_Paginas.Page1
96:             .Caption   = "Lista"
97:             .BackColor = RGB(255, 255, 255)
98:         ENDWITH
99: 
100:         WITH THIS.pgf_4c_Paginas.Page2
101:             .Caption   = "Dados"
102:             .BackColor = RGB(255, 255, 255)
103:         ENDWITH
104: 
105:         THIS.ConfigurarPaginaLista()
106:         THIS.ConfigurarPaginaDados()

*-- Linhas 115 a 163:
115:     *   Grupo_Saida : Top=-1, Left=750               -> canonico Left=917
116:     *   Command1    : Top=4,  Left=305 ("Copia Mes") -> Left=462 (proporcional)
117:     *   Grade       : Top=96, Left=32, Width=783, Height=470
118:     * Compensacao PageFrame (+29): grade.Top = 96+29 = 125
119:     *==========================================================================
120:     PROTECTED PROCEDURE ConfigurarPaginaLista()
121:         LOCAL loc_oPagina, loc_oGrid
122:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
123: 
124:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
125: 
126:         *-- Cabecalho cinza (cntSombra.Top=1 -> 1+29=30)
127:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
128:         WITH loc_oPagina.cnt_4c_Cabecalho
129:             .Top         = 30
130:             .Left        = 0
131:             .Width       = THIS.Width
132:             .Height      = 80
133:             .BackColor   = RGB(100, 100, 100)
134:             .BorderWidth = 0
135:             .Visible     = .T.
136:         ENDWITH
137: 
138:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
139:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
140:             .Caption   = "Jornadas de Trabalho"
141:             .Top       = 15
142:             .Left      = 11
143:             .Width     = THIS.Width - 20
144:             .Height    = 40
145:             .FontName  = "Tahoma"
146:             .FontSize  = 16
147:             .FontBold  = .T.
148:             .ForeColor = RGB(0, 0, 0)
149:             .BackStyle = 0
150:             .AutoSize  = .F.
151:             .Visible   = .T.
152:         ENDWITH
153: 
154:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
155:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
156:             .Caption   = "Jornadas de Trabalho"
157:             .Top       = 18
158:             .Left      = 10
159:             .Width     = THIS.Width - 20
160:             .Height    = 46
161:             .FontName  = "Tahoma"
162:             .FontSize  = 16
163:             .FontBold  = .T.

*-- Linhas 173 a 398:
173:         *----------------------------------------------------------------------
174:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
175:         WITH loc_oPagina.cnt_4c_Botoes
176:             .Top         = 28
177:             .Left        = 542
178:             .Width       = 390
179:             .Height      = 85
180:             .BackStyle = 0
181:             .BorderWidth = 0
182:             .Visible     = .T.
183:         ENDWITH
184: 
185:         *-- Incluir (Inserir.Left=5)
186:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
187:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
188:             .Caption         = "Incluir"
189:             .Top             = 5
190:             .Left            = 5
191:             .Width           = 75
192:             .Height          = 75
193:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
194:             .PicturePosition = 13
195:             .FontName        = "Comic Sans MS"
196:             .FontSize        = 8
197:             .FontBold        = .T.
198:             .FontItalic      = .T.
199:             .ForeColor       = RGB(90, 90, 90)
200:             .BackColor       = RGB(255, 255, 255)
201:             .Themes          = .F.
202:             .SpecialEffect   = 0
203:             .MousePointer    = 15
204:             .WordWrap        = .T.
205:             .AutoSize        = .F.
206:             .Visible         = .T.
207:         ENDWITH
208:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
209: 
210:         *-- Visualizar (Consultar.Left=80)
211:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
212:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
213:             .Caption         = "Visualizar"
214:             .Top             = 5
215:             .Left            = 80
216:             .Width           = 75
217:             .Height          = 75
218:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
219:             .PicturePosition = 13
220:             .FontName        = "Comic Sans MS"
221:             .FontSize        = 8
222:             .FontBold        = .T.
223:             .FontItalic      = .T.
224:             .ForeColor       = RGB(90, 90, 90)
225:             .BackColor       = RGB(255, 255, 255)
226:             .Themes          = .F.
227:             .SpecialEffect   = 0
228:             .MousePointer    = 15
229:             .WordWrap        = .T.
230:             .AutoSize        = .F.
231:             .Visible         = .T.
232:         ENDWITH
233:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
234: 
235:         *-- Alterar (Left=155)
236:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
237:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
238:             .Caption         = "Alterar"
239:             .Top             = 5
240:             .Left            = 155
241:             .Width           = 75
242:             .Height          = 75
243:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
244:             .PicturePosition = 13
245:             .FontName        = "Comic Sans MS"
246:             .FontSize        = 8
247:             .FontBold        = .T.
248:             .FontItalic      = .T.
249:             .ForeColor       = RGB(90, 90, 90)
250:             .BackColor       = RGB(255, 255, 255)
251:             .Themes          = .F.
252:             .SpecialEffect   = 0
253:             .MousePointer    = 15
254:             .WordWrap        = .T.
255:             .AutoSize        = .F.
256:             .Visible         = .T.
257:         ENDWITH
258:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
259: 
260:         *-- Excluir (Left=230)
261:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
262:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
263:             .Caption         = "Excluir"
264:             .Top             = 5
265:             .Left            = 230
266:             .Width           = 75
267:             .Height          = 75
268:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
269:             .PicturePosition = 13
270:             .FontName        = "Comic Sans MS"
271:             .FontSize        = 8
272:             .FontBold        = .T.
273:             .FontItalic      = .T.
274:             .ForeColor       = RGB(90, 90, 90)
275:             .BackColor       = RGB(255, 255, 255)
276:             .Themes          = .F.
277:             .SpecialEffect   = 0
278:             .MousePointer    = 15
279:             .WordWrap        = .T.
280:             .AutoSize        = .F.
281:             .Visible         = .T.
282:         ENDWITH
283:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
284: 
285:         *-- Buscar (Procurar.Left=305)
286:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
287:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
288:             .Caption         = "Buscar"
289:             .Top             = 5
290:             .Left            = 305
291:             .Width           = 75
292:             .Height          = 75
293:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
294:             .PicturePosition = 13
295:             .FontName        = "Comic Sans MS"
296:             .FontSize        = 8
297:             .FontBold        = .T.
298:             .FontItalic      = .T.
299:             .ForeColor       = RGB(90, 90, 90)
300:             .BackColor       = RGB(255, 255, 255)
301:             .Themes          = .F.
302:             .SpecialEffect   = 0
303:             .MousePointer    = 15
304:             .WordWrap        = .T.
305:             .AutoSize        = .F.
306:             .Visible         = .T.
307:         ENDWITH
308:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
309: 
310:         *----------------------------------------------------------------------
311:         * Container saida - padrao canonico CLAUDE.md #10
312:         * Grupo_Saida.Left=750, Top=-1 -> canonico Left=917, Top=28
313:         *----------------------------------------------------------------------
314:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
315:         WITH loc_oPagina.cnt_4c_Saida
316:             .Top         = 28
317:             .Left        = 917
318:             .Width       = 90
319:             .Height      = 85
320:             .BackStyle   = 0
321:             .BorderWidth = 0
322:             .Visible     = .T.
323:         ENDWITH
324: 
325:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
326:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
327:             .Caption         = "Encerrar"
328:             .Top             = 5
329:             .Left            = 5
330:             .Width           = 75
331:             .Height          = 75
332:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
333:             .PicturePosition = 13
334:             .FontName        = "Comic Sans MS"
335:             .FontSize        = 8
336:             .FontBold        = .T.
337:             .FontItalic      = .T.
338:             .ForeColor       = RGB(90, 90, 90)
339:             .BackColor       = RGB(255, 255, 255)
340:             .Themes          = .F.
341:             .SpecialEffect   = 0
342:             .MousePointer    = 15
343:             .WordWrap        = .T.
344:             .AutoSize        = .F.
345:             .Visible         = .T.
346:         ENDWITH
347:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
348: 
349:         *----------------------------------------------------------------------
350:         * Botao "Copia Mes" (Command1 standalone no legado)
351:         * Original: Top=4, Left=305 em form 834px
352:         * Novo:     Top=4+29=33, Left proporcional ~462 (a esquerda de 542)
353:         *----------------------------------------------------------------------
354:         loc_oPagina.AddObject("cmd_4c_CopiarMes", "CommandButton")
355:         WITH loc_oPagina.cmd_4c_CopiarMes
356:             .Caption         = "Copia M" + CHR(234) + "s"
357:             .Top             = 33
358:             .Left            = 462
359:             .Width           = 75
360:             .Height          = 75
361:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
362:             .PicturePosition = 13
363:             .FontName        = "Comic Sans MS"
364:             .FontSize        = 8
365:             .FontBold        = .T.
366:             .FontItalic      = .T.
367:             .ForeColor       = RGB(90, 90, 90)
368:             .BackColor       = RGB(255, 255, 255)
369:             .Themes          = .F.
370:             .SpecialEffect   = 0
371:             .MousePointer    = 15
372:             .WordWrap        = .T.
373:             .AutoSize        = .F.
374:             .Visible         = .T.
375:         ENDWITH
376:         BINDEVENT(loc_oPagina.cmd_4c_CopiarMes, "Click", THIS, "BtnCopiarMesClick")
377: 
378:         *----------------------------------------------------------------------
379:         * Grid (Grade no legado: Top=96, Left=32, Width=783, Height=470)
380:         * Novo: Top=96+29=125, Left=32, Width=880 (ate cnt_4c_Saida.Left=917)
381:         * 14 colunas: iclis, cargos, refers, hora01-04, cDom-cSab
382:         *
383:         * ColumnCount FORA do WITH (Problema 36: nao criar colunas dentro de WITH)
384:         * ControlSource redefinido em CarregarLista apos RecordSource (Problema 48)
385:         *----------------------------------------------------------------------
386:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
387:         loc_oGrid = loc_oPagina.grd_4c_Lista
388: 
389:         loc_oGrid.ColumnCount = 14
390: 
391:         WITH loc_oGrid
392:             .Top                = 125
393:             .Left               = 32
394:             .Width              = 880
395:             .Height             = 470
396:             .FontName           = "Verdana"
397:             .FontSize           = 8
398:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 410 a 536:
410: 
411:             .Column1.Width           = 80
412:             .Column1.Alignment       = 0
413:             .Column1.Header1.Caption = "Funcion" + CHR(225) + "rio"
414: 
415:             .Column2.Width           = 80
416:             .Column2.Alignment       = 0
417:             .Column2.Header1.Caption = "Cargo"
418: 
419:             .Column3.Width           = 52
420:             .Column3.Alignment       = 0
421:             .Column3.Header1.Caption = "Ano/M" + CHR(234) + "s"
422: 
423:             .Column4.Width           = 45
424:             .Column4.Alignment       = 0
425:             .Column4.Header1.Caption = "Inicio"
426: 
427:             .Column5.Width           = 45
428:             .Column5.Alignment       = 0
429:             .Column5.Header1.Caption = "Intervalo"
430: 
431:             .Column6.Width           = 45
432:             .Column6.Alignment       = 0
433:             .Column6.Header1.Caption = "Intervalo"
434: 
435:             .Column7.Width           = 45
436:             .Column7.Alignment       = 0
437:             .Column7.Header1.Caption = "Fim"
438: 
439:             .Column8.Width            = 20
440:             .Column8.Alignment        = 2
441:             .Column8.Header1.Caption  = "Dom"
442: 
443:             .Column9.Width            = 20
444:             .Column9.Alignment        = 2
445:             .Column9.Header1.Caption  = "Seg"
446: 
447:             .Column10.Width           = 20
448:             .Column10.Alignment       = 2
449:             .Column10.Header1.Caption = "Ter"
450: 
451:             .Column11.Width           = 20
452:             .Column11.Alignment       = 2
453:             .Column11.Header1.Caption = "Qua"
454: 
455:             .Column12.Width           = 20
456:             .Column12.Alignment       = 2
457:             .Column12.Header1.Caption = "Qui"
458: 
459:             .Column13.Width           = 20
460:             .Column13.Alignment       = 2
461:             .Column13.Header1.Caption = "Sex"
462: 
463:             .Column14.Width           = 20
464:             .Column14.Alignment       = 2
465:             .Column14.Header1.Caption = "S" + CHR(225) + "b"
466:         ENDWITH
467: 
468:         *----------------------------------------------------------------------
469:         * Painel flutuante "Copiar Jornada do Mes" (Problema 26: iniciar oculto)
470:         * Original cntCopiaMes: Top=233, Left=280, Width=273, Height=136
471:         * Com compensacao PageFrame +29: Top=262
472:         *----------------------------------------------------------------------
473:         loc_oPagina.AddObject("cnt_4c_CopiaMes", "Container")
474:         WITH loc_oPagina.cnt_4c_CopiaMes
475:             .Top         = 262
476:             .Left        = 280
477:             .Width       = 273
478:             .Height      = 136
479:             .BackStyle   = 1
480:             .BackColor   = RGB(240, 240, 240)
481:             .BorderColor = RGB(100, 100, 100)
482:             .Visible     = .F.
483:         ENDWITH
484: 
485:         loc_oPagina.cnt_4c_CopiaMes.AddObject("shp_4c_HeaderCopia", "Shape")
486:         WITH loc_oPagina.cnt_4c_CopiaMes.shp_4c_HeaderCopia
487:             .Top         = 0
488:             .Left        = 0
489:             .Width       = 274
490:             .Height      = 25
491:             .BackStyle   = 1
492:             .BackColor   = RGB(53, 53, 53)
493:             .BorderStyle = 0
494:             .Visible     = .T.
495:         ENDWITH
496: 
497:         loc_oPagina.cnt_4c_CopiaMes.AddObject("lbl_4c_TituloCopiaMes", "Label")
498:         WITH loc_oPagina.cnt_4c_CopiaMes.lbl_4c_TituloCopiaMes
499:             .Caption   = "  Copiar Jornada do M" + CHR(234) + "s"
500:             .Top       = 4
501:             .Left      = 2
502:             .Width     = 197
503:             .Height    = 21
504:             .FontName  = "Tahoma"
505:             .FontSize  = 8
506:             .FontBold  = .T.
507:             .ForeColor = RGB(255, 255, 255)
508:             .BackStyle = 0
509:             .AutoSize  = .F.
510:             .Visible   = .T.
511:         ENDWITH
512: 
513:         loc_oPagina.cnt_4c_CopiaMes.AddObject("lbl_4c_De", "Label")
514:         WITH loc_oPagina.cnt_4c_CopiaMes.lbl_4c_De
515:             .Caption   = "De :"
516:             .Top       = 57
517:             .Left      = 44
518:             .Height    = 15
519:             .Width     = 25
520:             .FontName  = "Tahoma"
521:             .FontSize  = 8
522:             .BackStyle = 0
523:             .ForeColor = RGB(0, 0, 0)
524:             .AutoSize  = .F.
525:             .Visible   = .T.
526:         ENDWITH
527: 
528:         loc_oPagina.cnt_4c_CopiaMes.AddObject("cbo_4c_De", "ComboBox")
529:         WITH loc_oPagina.cnt_4c_CopiaMes.cbo_4c_De
530:             .Top           = 53
531:             .Left          = 71
532:             .Width         = 100
533:             .Height        = 24
534:             .ColumnCount   = 2
535:             .ColumnWidths  = "95,0"
536:             .BoundColumn   = 2

*-- Linhas 542 a 568:
542:             .Visible       = .T.
543:         ENDWITH
544: 
545:         loc_oPagina.cnt_4c_CopiaMes.AddObject("lbl_4c_Para", "Label")
546:         WITH loc_oPagina.cnt_4c_CopiaMes.lbl_4c_Para
547:             .Caption   = "Para :"
548:             .Top       = 87
549:             .Left      = 31
550:             .Height    = 15
551:             .Width     = 35
552:             .FontName  = "Tahoma"
553:             .FontSize  = 8
554:             .BackStyle = 0
555:             .ForeColor = RGB(0, 0, 0)
556:             .AutoSize  = .F.
557:             .Visible   = .T.
558:         ENDWITH
559: 
560:         loc_oPagina.cnt_4c_CopiaMes.AddObject("cbo_4c_Para", "ComboBox")
561:         WITH loc_oPagina.cnt_4c_CopiaMes.cbo_4c_Para
562:             .Top           = 82
563:             .Left          = 71
564:             .Width         = 100
565:             .Height        = 24
566:             .ColumnCount   = 2
567:             .ColumnWidths  = "95,0"
568:             .BoundColumn   = 2

*-- Linhas 575 a 618:
575:         ENDWITH
576: 
577:         *-- Botao Confirmar (Command2 no legado: Top=39, Left=213, Width=40, Height=40)
578:         loc_oPagina.cnt_4c_CopiaMes.AddObject("cmd_4c_CopiarMesOK", "CommandButton")
579:         WITH loc_oPagina.cnt_4c_CopiaMes.cmd_4c_CopiarMesOK
580:             .Caption       = "OK"
581:             .Top           = 39
582:             .Left          = 213
583:             .Width         = 40
584:             .Height        = 40
585:             .FontName      = "Tahoma"
586:             .FontSize      = 8
587:             .FontBold      = .T.
588:             .ForeColor     = RGB(0, 100, 0)
589:             .BackColor     = RGB(255, 255, 255)
590:             .Themes        = .F.
591:             .SpecialEffect = 0
592:             .Visible       = .T.
593:         ENDWITH
594:         BINDEVENT(loc_oPagina.cnt_4c_CopiaMes.cmd_4c_CopiarMesOK, "Click", THIS, "CopiaMesConfirmarClick")
595: 
596:         *-- Botao Cancelar (Command1 no legado: Top=80, Left=213, Width=40, Height=40)
597:         loc_oPagina.cnt_4c_CopiaMes.AddObject("cmd_4c_CopiarMesX", "CommandButton")
598:         WITH loc_oPagina.cnt_4c_CopiaMes.cmd_4c_CopiarMesX
599:             .Caption       = "X"
600:             .Top           = 80
601:             .Left          = 213
602:             .Width         = 40
603:             .Height        = 40
604:             .FontName      = "Tahoma"
605:             .FontSize      = 8
606:             .FontBold      = .T.
607:             .ForeColor     = RGB(180, 0, 0)
608:             .BackColor     = RGB(255, 255, 255)
609:             .Themes        = .F.
610:             .SpecialEffect = 0
611:             .Visible       = .T.
612:         ENDWITH
613:         BINDEVENT(loc_oPagina.cnt_4c_CopiaMes.cmd_4c_CopiarMesX, "Click", THIS, "CopiaMesCancelarClick")
614: 
615:         THIS.TornarControlesVisiveis(loc_oPagina)
616:     ENDPROC
617: 
618:     *==========================================================================

*-- Linhas 625 a 633:
625:     *   getCodCgo   : Left=148, Top=189 -> Top=218 (+29)
626:     *   cboMes/Ano  : Left=148/232, Top=136 -> Top=165 (+29)
627:     *   getHora01-04: Top=246 -> Top=275 (+29)
628:     *   checkboxes  : Top=295/318 -> Top=324/347 (+29)
629:     *   Shape(dias) : Top=287  -> Top=316 (+29), Width=433, Height=57
630:     *==========================================================================
631:     PROTECTED PROCEDURE ConfigurarPaginaDados()
632:         LOCAL loc_oPagina, loc_cAnos, loc_n, loc_cRowMes
633:         loc_oPagina = THIS.pgf_4c_Paginas.Page2

*-- Linhas 648 a 741:
648: 
649:         *----------------------------------------------------------------------
650:         * Container botoes acao (Grupo_Salva: Left=635->760, Top=13->42)
651:         * Confirmar.Left=5, Cancelar.Left=85, ambos Width=75, Height=75
652:         *----------------------------------------------------------------------
653:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
654:         WITH loc_oPagina.cnt_4c_BotoesAcao
655:             .Top         = 42
656:             .Left        = 760
657:             .Width       = 165
658:             .Height      = 85
659:             .BackStyle = 0
660:             .BorderWidth = 0
661:             .Visible     = .T.
662:         ENDWITH
663: 
664:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
665:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
666:             .Caption         = "Confirmar"
667:             .Top             = 5
668:             .Left            = 5
669:             .Width           = 75
670:             .Height          = 75
671:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
672:             .PicturePosition = 13
673:             .FontName        = "Comic Sans MS"
674:             .FontSize        = 8
675:             .FontBold        = .T.
676:             .FontItalic      = .T.
677:             .ForeColor       = RGB(90, 90, 90)
678:             .BackColor       = RGB(255, 255, 255)
679:             .Themes          = .F.
680:             .SpecialEffect   = 0
681:             .MousePointer    = 15
682:             .WordWrap        = .T.
683:             .AutoSize        = .F.
684:             .Visible         = .T.
685:         ENDWITH
686:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
687: 
688:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
689:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
690:             .Caption         = "Encerrar"
691:             .Top             = 5
692:             .Left            = 85
693:             .Width           = 75
694:             .Height          = 75
695:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
696:             .PicturePosition = 13
697:             .FontName        = "Comic Sans MS"
698:             .FontSize        = 8
699:             .FontBold        = .T.
700:             .FontItalic      = .T.
701:             .ForeColor       = RGB(90, 90, 90)
702:             .BackColor       = RGB(255, 255, 255)
703:             .Themes          = .F.
704:             .SpecialEffect   = 0
705:             .MousePointer    = 15
706:             .WordWrap        = .T.
707:             .AutoSize        = .F.
708:             .Visible         = .T.
709:         ENDWITH
710:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
711: 
712:         *----------------------------------------------------------------------
713:         * Referencia: label + combo Mes + combo Ano
714:         * Label8 "Referencia :" Left=83, Top=139 -> Top=168
715:         * cboMes: Left=148, Top=136 -> Top=165
716:         * cboAno: Left=232, Top=136 -> Top=165
717:         *----------------------------------------------------------------------
718:         loc_oPagina.AddObject("lbl_4c_LblReferencia", "Label")
719:         WITH loc_oPagina.lbl_4c_LblReferencia
720:             .Caption   = "Refer" + CHR(234) + "ncia :"
721:             .Top       = 168
722:             .Left      = 83
723:             .Height    = 15
724:             .Width     = 65
725:             .FontName  = "Tahoma"
726:             .FontSize  = 8
727:             .BackStyle = 0
728:             .ForeColor = RGB(0, 90, 90)
729:             .AutoSize  = .F.
730:             .Visible   = .T.
731:         ENDWITH
732: 
733:         loc_oPagina.AddObject("cbo_4c_CboMes", "ComboBox")
734:         WITH loc_oPagina.cbo_4c_CboMes
735:             .Top             = 165
736:             .Left            = 148
737:             .Width           = 80
738:             .Height          = 24
739:             .BoundColumn     = 2
740:             .ColumnCount     = 2
741:             .ColumnWidths    = "0,70"

*-- Linhas 749 a 758:
749: 
750:         loc_oPagina.AddObject("cbo_4c_CboAno", "ComboBox")
751:         WITH loc_oPagina.cbo_4c_CboAno
752:             .Top             = 165
753:             .Left            = 232
754:             .Width           = 60
755:             .Height          = 24
756:             .ColumnCount     = 1
757:             .ColumnWidths    = "55"
758:             .RowSourceType   = 1

*-- Linhas 769 a 795:
769:         * getCodCli: Left=148, Top=163 -> Top=192, Width=80
770:         * getDesCli: Left=232, Top=163 -> Top=192, Width=360
771:         *----------------------------------------------------------------------
772:         loc_oPagina.AddObject("lbl_4c_LblFuncionario", "Label")
773:         WITH loc_oPagina.lbl_4c_LblFuncionario
774:             .Caption   = "Funcion" + CHR(225) + "rio :"
775:             .Top       = 195
776:             .Left      = 80
777:             .Height    = 15
778:             .Width     = 68
779:             .FontName  = "Tahoma"
780:             .FontSize  = 8
781:             .BackStyle = 0
782:             .ForeColor = RGB(0, 90, 90)
783:             .AutoSize  = .F.
784:             .Visible   = .T.
785:         ENDWITH
786: 
787:         loc_oPagina.AddObject("txt_4c_CodCli", "TextBox")
788:         WITH loc_oPagina.txt_4c_CodCli
789:             .Top                 = 192
790:             .Left                = 148
791:             .Width               = 80
792:             .Height              = 23
793:             .Value               = ""
794:             .FontName            = "Tahoma"
795:             .FontSize            = 8

*-- Linhas 802 a 811:
802: 
803:         loc_oPagina.AddObject("txt_4c_DesCli", "TextBox")
804:         WITH loc_oPagina.txt_4c_DesCli
805:             .Top                 = 192
806:             .Left                = 232
807:             .Width               = 360
808:             .Height              = 23
809:             .Value               = ""
810:             .Alignment           = 0
811:             .FontName            = "Tahoma"

*-- Linhas 822 a 848:
822:         * Label3 "Cargo :" Left=106, Top=192 -> Top=221
823:         * getCodCgo: Left=148, Top=189 -> Top=218, Width=80, Height=23
824:         *----------------------------------------------------------------------
825:         loc_oPagina.AddObject("lbl_4c_LblCargo", "Label")
826:         WITH loc_oPagina.lbl_4c_LblCargo
827:             .Caption   = "Cargo :"
828:             .Top       = 221
829:             .Left      = 106
830:             .Height    = 15
831:             .Width     = 40
832:             .FontName  = "Tahoma"
833:             .FontSize  = 8
834:             .BackStyle = 0
835:             .ForeColor = RGB(0, 90, 90)
836:             .AutoSize  = .F.
837:             .Visible   = .T.
838:         ENDWITH
839: 
840:         loc_oPagina.AddObject("txt_4c_CodCgo", "TextBox")
841:         WITH loc_oPagina.txt_4c_CodCgo
842:             .Top                 = 218
843:             .Left                = 148
844:             .Width               = 80
845:             .Height              = 23
846:             .Value               = ""
847:             .FontName            = "Tahoma"
848:             .FontSize            = 8

*-- Linhas 860 a 1027:
860:         * getHora01-04: Top=246 -> Top=275, Width=45
861:         *   Left: 148 / 205 / 262 / 320
862:         *----------------------------------------------------------------------
863:         loc_oPagina.AddObject("lbl_4c_LblHorarios", "Label")
864:         WITH loc_oPagina.lbl_4c_LblHorarios
865:             .Caption   = "Hor" + CHR(225) + "rios :"
866:             .Top       = 278
867:             .Left      = 95
868:             .Height    = 15
869:             .Width     = 52
870:             .FontName  = "Tahoma"
871:             .FontSize  = 8
872:             .BackStyle = 0
873:             .ForeColor = RGB(0, 90, 90)
874:             .AutoSize  = .F.
875:             .Visible   = .T.
876:         ENDWITH
877: 
878:         loc_oPagina.AddObject("lbl_4c_LblInicio", "Label")
879:         WITH loc_oPagina.lbl_4c_LblInicio
880:             .Caption   = "In" + CHR(237) + "cio"
881:             .Top       = 254
882:             .Left      = 155
883:             .Height    = 15
884:             .Width     = 30
885:             .FontName  = "Tahoma"
886:             .FontSize  = 8
887:             .BackStyle = 0
888:             .ForeColor = RGB(0, 90, 90)
889:             .AutoSize  = .F.
890:             .Visible   = .T.
891:         ENDWITH
892: 
893:         loc_oPagina.AddObject("lbl_4c_LblIntervalo", "Label")
894:         WITH loc_oPagina.lbl_4c_LblIntervalo
895:             .Caption   = "Intervalo"
896:             .Top       = 254
897:             .Left      = 205
898:             .Height    = 15
899:             .Width     = 52
900:             .FontName  = "Tahoma"
901:             .FontSize  = 8
902:             .BackStyle = 0
903:             .ForeColor = RGB(0, 90, 90)
904:             .AutoSize  = .F.
905:             .Visible   = .T.
906:         ENDWITH
907: 
908:         loc_oPagina.AddObject("lbl_4c_LblFim", "Label")
909:         WITH loc_oPagina.lbl_4c_LblFim
910:             .Caption   = "Fim"
911:             .Top       = 254
912:             .Left      = 331
913:             .Height    = 15
914:             .Width     = 25
915:             .FontName  = "Tahoma"
916:             .FontSize  = 8
917:             .BackStyle = 0
918:             .ForeColor = RGB(0, 90, 90)
919:             .AutoSize  = .F.
920:             .Visible   = .T.
921:         ENDWITH
922: 
923:         loc_oPagina.AddObject("txt_4c_Hora01", "TextBox")
924:         WITH loc_oPagina.txt_4c_Hora01
925:             .Top       = 275
926:             .Left      = 148
927:             .Width     = 45
928:             .Height    = 23
929:             .Value     = ""
930:             .InputMask = "99:99"
931:             .FontName  = "Tahoma"
932:             .FontSize  = 8
933:             .BackColor = RGB(255, 255, 255)
934:             .Visible   = .T.
935:         ENDWITH
936: 
937:         loc_oPagina.AddObject("txt_4c_Hora02", "TextBox")
938:         WITH loc_oPagina.txt_4c_Hora02
939:             .Top       = 275
940:             .Left      = 205
941:             .Width     = 45
942:             .Height    = 23
943:             .Value     = ""
944:             .InputMask = "99:99"
945:             .FontName  = "Tahoma"
946:             .FontSize  = 8
947:             .BackColor = RGB(255, 255, 255)
948:             .Visible   = .T.
949:         ENDWITH
950: 
951:         loc_oPagina.AddObject("txt_4c_Hora03", "TextBox")
952:         WITH loc_oPagina.txt_4c_Hora03
953:             .Top       = 275
954:             .Left      = 262
955:             .Width     = 45
956:             .Height    = 23
957:             .Value     = ""
958:             .InputMask = "99:99"
959:             .FontName  = "Tahoma"
960:             .FontSize  = 8
961:             .BackColor = RGB(255, 255, 255)
962:             .Visible   = .T.
963:         ENDWITH
964: 
965:         loc_oPagina.AddObject("txt_4c_Hora04", "TextBox")
966:         WITH loc_oPagina.txt_4c_Hora04
967:             .Top       = 275
968:             .Left      = 320
969:             .Width     = 45
970:             .Height    = 23
971:             .Value     = ""
972:             .InputMask = "99:99"
973:             .FontName  = "Tahoma"
974:             .FontSize  = 8
975:             .BackColor = RGB(255, 255, 255)
976:             .Visible   = .T.
977:         ENDWITH
978: 
979:         *----------------------------------------------------------------------
980:         * Dias: label + shape (moldura) + 7 checkboxes
981:         * Label1 "Dias :" Left=115, Top=293 -> Top=322
982:         * Shape: Left=148, Top=287 -> Top=316, Width=433, Height=57
983:         * CheckBoxes (posicoes originais com +29):
984:         *   Dom/Seg: Left=160, Top=295/318 -> 324/347
985:         *   Ter/Qua: Left=267, Top=295/318 -> 324/347
986:         *   Qui/Sex: Left=392, Top=295/318 -> 324/347
987:         *   Sab:     Left=508, Top=295     -> 324
988:         *----------------------------------------------------------------------
989:         loc_oPagina.AddObject("lbl_4c_LblDias", "Label")
990:         WITH loc_oPagina.lbl_4c_LblDias
991:             .Caption   = "Dias :"
992:             .Top       = 322
993:             .Left      = 115
994:             .Height    = 15
995:             .Width     = 32
996:             .FontName  = "Tahoma"
997:             .FontSize  = 8
998:             .BackStyle = 0
999:             .ForeColor = RGB(0, 90, 90)
1000:             .AutoSize  = .F.
1001:             .Visible   = .T.
1002:         ENDWITH
1003: 
1004:         *-- Shape decorativo ao redor dos checkboxes (adicionado ANTES dos chks)
1005:         loc_oPagina.AddObject("shp_4c_DiasBox", "Shape")
1006:         WITH loc_oPagina.shp_4c_DiasBox
1007:             .Top         = 316
1008:             .Left        = 148
1009:             .Width       = 433
1010:             .Height      = 57
1011:             .BackStyle   = 0
1012:             .BorderStyle = 1
1013:             .BorderColor = RGB(136, 189, 188)
1014:             .Visible     = .T.
1015:         ENDWITH
1016: 
1017:         *-- Dom: Left=160, Top=324
1018:         loc_oPagina.AddObject("chk_4c_ChkDom", "CheckBox")
1019:         WITH loc_oPagina.chk_4c_ChkDom
1020:             .Caption   = "Domingo"
1021:             .Top       = 324
1022:             .Left      = 160
1023:             .Height    = 17
1024:             .Width     = 60
1025:             .Value     = 0
1026:             .Alignment = 0
1027:             .BackStyle = 0

*-- Linhas 1033 a 1045:
1033:         ENDWITH
1034: 
1035:         *-- Seg: Left=160, Top=347
1036:         loc_oPagina.AddObject("chk_4c_ChkSeg", "CheckBox")
1037:         WITH loc_oPagina.chk_4c_ChkSeg
1038:             .Caption   = "Segunda"
1039:             .Top       = 347
1040:             .Left      = 160
1041:             .Height    = 17
1042:             .Width     = 60
1043:             .Value     = 0
1044:             .Alignment = 0
1045:             .BackStyle = 0

*-- Linhas 1051 a 1063:
1051:         ENDWITH
1052: 
1053:         *-- Ter: Left=267, Top=324
1054:         loc_oPagina.AddObject("chk_4c_ChkTer", "CheckBox")
1055:         WITH loc_oPagina.chk_4c_ChkTer
1056:             .Caption   = "Ter" + CHR(231) + "a"
1057:             .Top       = 324
1058:             .Left      = 267
1059:             .Height    = 17
1060:             .Width     = 50
1061:             .Value     = 0
1062:             .Alignment = 0
1063:             .BackStyle = 0

*-- Linhas 1069 a 1081:
1069:         ENDWITH
1070: 
1071:         *-- Qua: Left=267, Top=347
1072:         loc_oPagina.AddObject("chk_4c_ChkQua", "CheckBox")
1073:         WITH loc_oPagina.chk_4c_ChkQua
1074:             .Caption   = "Quarta"
1075:             .Top       = 347
1076:             .Left      = 267
1077:             .Height    = 17
1078:             .Width     = 55
1079:             .Value     = 0
1080:             .Alignment = 0
1081:             .BackStyle = 0

*-- Linhas 1087 a 1099:
1087:         ENDWITH
1088: 
1089:         *-- Qui: Left=392, Top=324
1090:         loc_oPagina.AddObject("chk_4c_ChkQui", "CheckBox")
1091:         WITH loc_oPagina.chk_4c_ChkQui
1092:             .Caption   = "Quinta"
1093:             .Top       = 324
1094:             .Left      = 392
1095:             .Height    = 17
1096:             .Width     = 55
1097:             .Value     = 0
1098:             .Alignment = 0
1099:             .BackStyle = 0

*-- Linhas 1105 a 1117:
1105:         ENDWITH
1106: 
1107:         *-- Sex: Left=392, Top=347
1108:         loc_oPagina.AddObject("chk_4c_ChkSex", "CheckBox")
1109:         WITH loc_oPagina.chk_4c_ChkSex
1110:             .Caption   = "Sexta"
1111:             .Top       = 347
1112:             .Left      = 392
1113:             .Height    = 17
1114:             .Width     = 50
1115:             .Value     = 0
1116:             .Alignment = 0
1117:             .BackStyle = 0

*-- Linhas 1123 a 1135:
1123:         ENDWITH
1124: 
1125:         *-- Sab: Left=508, Top=324
1126:         loc_oPagina.AddObject("chk_4c_ChkSab", "CheckBox")
1127:         WITH loc_oPagina.chk_4c_ChkSab
1128:             .Caption   = "S" + CHR(225) + "bado"
1129:             .Top       = 324
1130:             .Left      = 508
1131:             .Height    = 17
1132:             .Width     = 55
1133:             .Value     = 0
1134:             .Alignment = 0
1135:             .BackStyle = 0

*-- Linhas 1208 a 1281:
1208:             .Column1.ControlSource   = "cursor_4c_Dados.iclis"
1209:             .Column1.Width           = 80
1210:             .Column1.Alignment       = 0
1211:             .Column1.Header1.Caption = "Funcion" + CHR(225) + "rio"
1212: 
1213:             .Column2.ControlSource   = "cursor_4c_Dados.cargos"
1214:             .Column2.Width           = 80
1215:             .Column2.Alignment       = 0
1216:             .Column2.Header1.Caption = "Cargo"
1217: 
1218:             .Column3.ControlSource   = "cursor_4c_Dados.refers"
1219:             .Column3.Width           = 52
1220:             .Column3.Alignment       = 0
1221:             .Column3.Header1.Caption = "Ano/M" + CHR(234) + "s"
1222: 
1223:             .Column4.ControlSource   = "cursor_4c_Dados.hora01"
1224:             .Column4.Width           = 45
1225:             .Column4.Alignment       = 0
1226:             .Column4.Header1.Caption = "Inicio"
1227: 
1228:             .Column5.ControlSource   = "cursor_4c_Dados.hora02"
1229:             .Column5.Width           = 45
1230:             .Column5.Alignment       = 0
1231:             .Column5.Header1.Caption = "Intervalo"
1232: 
1233:             .Column6.ControlSource   = "cursor_4c_Dados.hora03"
1234:             .Column6.Width           = 45
1235:             .Column6.Alignment       = 0
1236:             .Column6.Header1.Caption = "Intervalo"
1237: 
1238:             .Column7.ControlSource   = "cursor_4c_Dados.hora04"
1239:             .Column7.Width           = 45
1240:             .Column7.Alignment       = 0
1241:             .Column7.Header1.Caption = "Fim"
1242: 
1243:             .Column8.ControlSource   = "cursor_4c_Dados.cDom"
1244:             .Column8.Width           = 20
1245:             .Column8.Alignment       = 2
1246:             .Column8.Header1.Caption = "Dom"
1247: 
1248:             .Column9.ControlSource   = "cursor_4c_Dados.cSeg"
1249:             .Column9.Width           = 20
1250:             .Column9.Alignment       = 2
1251:             .Column9.Header1.Caption = "Seg"
1252: 
1253:             .Column10.ControlSource  = "cursor_4c_Dados.cTer"
1254:             .Column10.Width          = 20
1255:             .Column10.Alignment      = 2
1256:             .Column10.Header1.Caption = "Ter"
1257: 
1258:             .Column11.ControlSource  = "cursor_4c_Dados.cQua"
1259:             .Column11.Width          = 20
1260:             .Column11.Alignment      = 2
1261:             .Column11.Header1.Caption = "Qua"
1262: 
1263:             .Column12.ControlSource  = "cursor_4c_Dados.cQui"
1264:             .Column12.Width          = 20
1265:             .Column12.Alignment      = 2
1266:             .Column12.Header1.Caption = "Qui"
1267: 
1268:             .Column13.ControlSource  = "cursor_4c_Dados.cSex"
1269:             .Column13.Width          = 20
1270:             .Column13.Alignment      = 2
1271:             .Column13.Header1.Caption = "Sex"
1272: 
1273:             .Column14.ControlSource  = "cursor_4c_Dados.cSab"
1274:             .Column14.Width          = 20
1275:             .Column14.Alignment      = 2
1276:             .Column14.Header1.Caption = "S" + CHR(225) + "b"
1277:         ENDWITH
1278:     ENDPROC
1279: 
1280:     *==========================================================================
1281:     * FormatarGridLista - Padroniza fonte de todas as colunas

*-- Linhas 1319 a 1327:
1319:             loc_oPagina.txt_4c_Hora03.Value = ALLTRIM(THIS.this_oBusinessObject.this_cHora03)
1320:             loc_oPagina.txt_4c_Hora04.Value = ALLTRIM(THIS.this_oBusinessObject.this_cHora04)
1321: 
1322:             *-- Dias da semana (BO = logical, CheckBox.Value = numeric 0/1)
1323:             loc_oPagina.chk_4c_ChkDom.Value = IIF(THIS.this_oBusinessObject.this_lDom, 1, 0)
1324:             loc_oPagina.chk_4c_ChkSeg.Value = IIF(THIS.this_oBusinessObject.this_lSeg, 1, 0)
1325:             loc_oPagina.chk_4c_ChkTer.Value = IIF(THIS.this_oBusinessObject.this_lTer, 1, 0)
1326:             loc_oPagina.chk_4c_ChkQua.Value = IIF(THIS.this_oBusinessObject.this_lQua, 1, 0)
1327:             loc_oPagina.chk_4c_ChkQui.Value = IIF(THIS.this_oBusinessObject.this_lQui, 1, 0)

*-- Linhas 1364 a 1372:
1364:             THIS.this_oBusinessObject.this_cHora03 = ALLTRIM(loc_oPagina.txt_4c_Hora03.Value)
1365:             THIS.this_oBusinessObject.this_cHora04 = ALLTRIM(loc_oPagina.txt_4c_Hora04.Value)
1366: 
1367:             *-- Dias da semana (CheckBox.Value = 0/1 numeric -> logical via comparacao)
1368:             THIS.this_oBusinessObject.this_lDom = (loc_oPagina.chk_4c_ChkDom.Value = 1)
1369:             THIS.this_oBusinessObject.this_lSeg = (loc_oPagina.chk_4c_ChkSeg.Value = 1)
1370:             THIS.this_oBusinessObject.this_lTer = (loc_oPagina.chk_4c_ChkTer.Value = 1)
1371:             THIS.this_oBusinessObject.this_lQua = (loc_oPagina.chk_4c_ChkQua.Value = 1)
1372:             THIS.this_oBusinessObject.this_lQui = (loc_oPagina.chk_4c_ChkQui.Value = 1)

*-- Linhas 1440 a 1448:
1440:             loc_oPagina.chk_4c_ChkQui.Enabled  = par_lHabilitar
1441:             loc_oPagina.chk_4c_ChkSex.Enabled  = par_lHabilitar
1442:             loc_oPagina.chk_4c_ChkSab.Enabled  = par_lHabilitar
1443:             loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
1444:         CATCH TO loc_oErro
1445:             MsgErro("Erro em FormJrn.HabilitarCampos:" + CHR(13) + loc_oErro.Message, "Erro")
1446:         ENDTRY
1447:     ENDPROC
1448: 

*-- Linhas 1650 a 1658:
1650:         THIS.this_oBusinessObject.BuscarMesesDisponiveis(loc_cIclis, loc_cCargos)
1651:         THIS.PopularCombosCopiaMes()
1652: 
1653:         loc_oPagina.cmd_4c_CopiarMes.Enabled = .F.
1654:         loc_oPagina.cnt_4c_Saida.Enabled     = .F.
1655:         loc_oPagina.cnt_4c_Botoes.Enabled    = .F.
1656:         loc_oPagina.grd_4c_Lista.Enabled     = .F.
1657:         loc_oPagina.cnt_4c_CopiaMes.Visible  = .T.
1658:         loc_oPagina.cnt_4c_CopiaMes.SetFocus()

*-- Linhas 2001 a 2009:
2001: 
2002:         TRY
2003:             loc_oPagina.cnt_4c_CopiaMes.Visible  = .F.
2004:             loc_oPagina.cmd_4c_CopiarMes.Enabled = .T.
2005:             loc_oPagina.cnt_4c_Saida.Enabled     = .T.
2006:             loc_oPagina.cnt_4c_Botoes.Enabled    = .T.
2007:             loc_oPagina.grd_4c_Lista.Enabled     = .T.
2008:             loc_oPagina.grd_4c_Lista.SetFocus()
2009:             loc_oPagina.grd_4c_Lista.Refresh()

*-- Linhas 2060 a 2069:
2060:         loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2061: 
2062:         TRY
2063:             loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEdicao
2064:             loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
2065:         CATCH TO loc_oErro
2066:             MsgErro("Erro em FormJrn.AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message, "Erro")
2067:         ENDTRY
2068:     ENDPROC
2069: 


### BO (C:\4c\projeto\app\classes\JrnBO.prg):
*==============================================================================
* JrnBO.prg - Business Object para Cadastro de Jornadas (SigCdJrn)
* Herda de BusinessBase
* Tabela: SigCdJrn
* PK: pkchave (composto: refers + cargos_padded + iclis_padded)
*==============================================================================

DEFINE CLASS JrnBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades da tabela SigCdJrn
    *--------------------------------------------------------------------------

    *-- Chave primaria composta (calculada)
    this_cPkChave    = ""  && pkchave  char - refers + cargos(0pad) + iclis(0pad)

    *-- Campos de identificacao do registro
    this_cRefers     = ""  && refers   char(6)  - periodo referencia (YYYYMM)
    this_cIclis      = ""  && iclis    char     - codigo do funcionario (FK SigCdCli)
    this_cCargos     = ""  && cargos   char     - codigo do cargo (FK SigCdCrg.ccargs)

    *-- Campo dias (string 7 chars: dom/seg/ter/qua/qui/sex/sab = 'X' ou ' ')
    this_cDias       = "       "  && dias  char(7)

    *-- Horarios (formato HH:MM)
    this_cHora01     = ""  && hora01  char(5) - inicio
    this_cHora02     = ""  && hora02  char(5) - inicio intervalo
    this_cHora03     = ""  && hora03  char(5) - fim intervalo
    this_cHora04     = ""  && hora04  char(5) - fim

    *-- Flags de dias da semana (computados de this_cDias)
    this_lDom        = .F.  && Domingo    (posicao 1 de dias)
    this_lSeg        = .F.  && Segunda    (posicao 2 de dias)
    this_lTer        = .F.  && Terca      (posicao 3 de dias)
    this_lQua        = .F.  && Quarta     (posicao 4 de dias)
    this_lQui        = .F.  && Quinta     (posicao 5 de dias)
    this_lSex        = .F.  && Sexta      (posicao 6 de dias)
    this_lSab        = .F.  && Sabado     (posicao 7 de dias)

    *-- Auditoria de criacao
    this_dDatas      = {}   && datas   datetime - data/hora de inclusao
    this_cUsuars     = ""   && usuars  char     - usuario que incluiu

    *-- Auditoria de alteracao
    this_dDtalts     = {}   && dtalts  datetime - data/hora da ultima alteracao
    this_cUsualts    = ""   && usualts char     - usuario da ultima alteracao

    *-- Descricao do funcionario (calculada via JOIN com SigCdCli)
    this_cDescri     = ""   && descri  char - rclis do funcionario (nao eh campo fisico)

    *--------------------------------------------------------------------------
    * Configuracao da classe
    *--------------------------------------------------------------------------

    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdJrn"
        THIS.this_cCampoChave = "pkchave"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - retorna chave para auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cPkChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * CalcularPkChave - constroi a PK composta a partir dos campos
    * refers(6) + cargos(substituindo espacos por "0") + iclis(idem)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CalcularPkChave()
        LOCAL loc_cPk
        loc_cPk = ALLTRIM(THIS.this_cRefers) + ;
                  STRTRAN(THIS.this_cCargos, " ", "0") + ;
                  STRTRAN(THIS.this_cIclis,  " ", "0")
        RETURN loc_cPk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ConstruirDias - constroi string dias (7 chars) a partir dos flags logicos
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ConstruirDias()
        LOCAL loc_cDias
        loc_cDias = IIF(THIS.this_lDom, "X", " ") + ;
                    IIF(THIS.this_lSeg, "X", " ") + ;
                    IIF(THIS.this_lTer, "X", " ") + ;
                    IIF(THIS.this_lQua, "X", " ") + ;
                    IIF(THIS.this_lQui, "X", " ") + ;
                    IIF(THIS.this_lSex, "X", " ") + ;
                    IIF(THIS.this_lSab, "X", " ")
        RETURN loc_cDias
    ENDFUNC

    *--------------------------------------------------------------------------
    * ParsearDias - converte string dias para flags logicos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ParsearDias(par_cDias)
        LOCAL loc_cStr
        loc_cStr = PADR(NVL(par_cDias, "       "), 7)
        THIS.this_lDom = (SUBSTR(loc_cStr, 1, 1) == "X")
        THIS.this_lSeg = (SUBSTR(loc_cStr, 2, 1) == "X")
        THIS.this_lTer = (SUBSTR(loc_cStr, 3, 1) == "X")
        THIS.this_lQua = (SUBSTR(loc_cStr, 4, 1) == "X")
        THIS.this_lQui = (SUBSTR(loc_cStr, 5, 1) == "X")
        THIS.this_lSex = (SUBSTR(loc_cStr, 6, 1) == "X")
        THIS.this_lSab = (SUBSTR(loc_cStr, 7, 1) == "X")
        THIS.this_cDias = loc_cStr
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - carrega propriedades a partir de um cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cPkChave   = TratarNulo(pkchave, "C")
            THIS.this_cRefers    = TratarNulo(refers,  "C")
            THIS.this_cIclis     = TratarNulo(iclis,   "C")
            THIS.this_cCargos    = TratarNulo(cargos,  "C")
            THIS.this_cHora01    = TratarNulo(hora01,  "C")
            THIS.this_cHora02    = TratarNulo(hora02,  "C")
            THIS.this_cHora03    = TratarNulo(hora03,  "C")
            THIS.this_cHora04    = TratarNulo(hora04,  "C")
            THIS.this_dDatas     = TratarNulo(datas,   "D")
            THIS.this_cUsuars    = TratarNulo(usuars,  "C")
            THIS.this_dDtalts    = TratarNulo(dtalts,  "D")
            THIS.this_cUsualts   = TratarNulo(usualts, "C")
            THIS.ParsearDias(TratarNulo(dias, "C"))
            *-- descri eh calculado via JOIN - carrega se existir no cursor
            IF TYPE("descri") != "U"
                THIS.this_cDescri = TratarNulo(descri, "C")
            ENDIF
            THIS.this_lNovoRegistro = .F.
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - SELECT geral com JOIN para descricao do funcionario
    * par_cFiltro: condicao WHERE adicional (sem a palavra WHERE)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cWhere = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = "SELECT a.pkchave, a.refers, a.iclis, a.cargos," + ;
                       " a.dias, a.hora01, a.hora02, a.hora03, a.hora04," + ;
                       " a.datas, a.usuars, a.dtalts, a.usualts," + ;
                       " ISNULL(b.rclis, '') AS descri," + ;
                       " SUBSTRING(a.dias,1,1) AS cDom," + ;
                       " CASE WHEN SUBSTRING(a.dias,1,1)='X' THEN 1 ELSE 0 END AS dom," + ;
                       " SUBSTRING(a.dias,2,1) AS cSeg," + ;
                       " CASE WHEN SUBSTRING(a.dias,2,1)='X' THEN 1 ELSE 0 END AS seg," + ;
                       " SUBSTRING(a.dias,3,1) AS cTer," + ;
                       " CASE WHEN SUBSTRING(a.dias,3,1)='X' THEN 1 ELSE 0 END AS ter," + ;
                       " SUBSTRING(a.dias,4,1) AS cQua," + ;
                       " CASE WHEN SUBSTRING(a.dias,4,1)='X' THEN 1 ELSE 0 END AS qua," + ;
                       " SUBSTRING(a.dias,5,1) AS cQui," + ;
                       " CASE WHEN SUBSTRING(a.dias,5,1)='X' THEN 1 ELSE 0 END AS qui," + ;
                       " SUBSTRING(a.dias,6,1) AS cSex," + ;
                       " CASE WHEN SUBSTRING(a.dias,6,1)='X' THEN 1 ELSE 0 END AS sex," + ;
                       " SUBSTRING(a.dias,7,1) AS cSab," + ;
                       " CASE WHEN SUBSTRING(a.dias,7,1)='X' THEN 1 ELSE 0 END AS sab" + ;
                       " FROM SigCdJrn a" + ;
                       " LEFT JOIN SigCdCli b ON b.iclis = a.iclis" + ;
                       loc_cWhere + ;
                       " ORDER BY a.pkchave"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar jornadas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em JrnBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - carrega registro pelo pkchave
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cPkChave)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.pkchave, a.refers, a.iclis, a.cargos," + ;
                       " a.dias, a.hora01, a.hora02, a.hora03, a.hora04," + ;
                       " a.datas, a.usuars, a.dtalts, a.usualts," + ;
                       " ISNULL(b.rclis, '') AS descri" + ;
                       " FROM SigCdJrn a" + ;
                       " LEFT JOIN SigCdCli b ON b.iclis = a.iclis" + ;
                       " WHERE a.pkchave = " + EscaparSQL(par_cPkChave)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
            ELSE
                IF loc_nResult <= 0
                    MsgErro("Erro ao carregar jornada:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em JrnBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdJrn
    * Constroi pkchave composto e registra auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cPkChave, loc_cDias
        loc_lSucesso = .F.

        TRY
            loc_cPkChave = THIS.CalcularPkChave()
            loc_cDias    = THIS.ConstruirDias()

            loc_cSQL = "INSERT INTO SigCdJrn" + ;
                       " (pkchave, refers, iclis, cargos, dias," + ;
                       "  hora01, hora02, hora03, hora04," + ;
                       "  datas, usuars)" + ;
                       " VALUES (" + ;
                       EscaparSQL(loc_cPkChave) + ", " + ;
                       EscaparSQL(THIS.this_cRefers) + ", " + ;
                       EscaparSQL(THIS.this_cIclis) + ", " + ;
                       EscaparSQL(THIS.this_cCargos) + ", " + ;
                       EscaparSQL(loc_cDias) + ", " + ;
                       EscaparSQL(THIS.this_cHora01) + ", " + ;
                       EscaparSQL(THIS.this_cHora02) + ", " + ;
                       EscaparSQL(THIS.this_cHora03) + ", " + ;
                       EscaparSQL(THIS.this_cHora04) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.this_cPkChave = loc_cPkChave
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao incluir jornada:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em JrnBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCdJrn
    * Altera apenas: dias, refers, dtalts, usualts (conforme logica original)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cDias
        loc_lSucesso = .F.

        TRY
            loc_cDias = THIS.ConstruirDias()

            loc_cSQL = "UPDATE SigCdJrn SET" + ;
                       " refers  = " + EscaparSQL(THIS.this_cRefers) + "," + ;
                       " dias    = " + EscaparSQL(loc_cDias) + "," + ;
                       " hora01  = " + EscaparSQL(THIS.this_cHora01) + "," + ;
                       " hora02  = " + EscaparSQL(THIS.this_cHora02) + "," + ;
                       " hora03  = " + EscaparSQL(THIS.this_cHora03) + "," + ;
                       " hora04  = " + EscaparSQL(THIS.this_cHora04) + "," + ;
                       " dtalts  = GETDATE()," + ;
                       " usualts = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                       " WHERE pkchave = " + EscaparSQL(THIS.this_cPkChave)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao alterar jornada:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em JrnBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigCdJrn
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdJrn" + ;
                       " WHERE pkchave = " + EscaparSQL(THIS.this_cPkChave)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir jornada:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em JrnBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CopiarParaMes - copia a jornada do registro atual para outro mes/ano
    * par_cAno:  ano destino (4 chars, ex: "2025")
    * par_cMes:  mes destino (2 chars, ex: "03")
    * Retorna .T. se copiou com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CopiarParaMes(par_cAno, par_cMes)
        LOCAL loc_cNovoRefers, loc_cNovoPk, loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cAno)) OR EMPTY(ALLTRIM(par_cMes))
                MsgErro("Ano e m" + CHR(234) + "s s" + CHR(227) + "o obrigat" + ;
                        CHR(243) + "rios para copiar jornada.", "Valida" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            loc_cNovoRefers = ALLTRIM(par_cAno) + ALLTRIM(par_cMes)
            loc_cNovoPk     = loc_cNovoRefers + ;
                              STRTRAN(THIS.this_cCargos, " ", "0") + ;
                              STRTRAN(THIS.this_cIclis,  " ", "0")

            *-- Verifica se ja existe registro para o mes destino
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdJrn WHERE pkchave = " + ;
                       EscaparSQL(loc_cNovoPk)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCopia") > 0
                SELECT cursor_4c_ChkCopia
                IF cursor_4c_ChkCopia.qtd > 0
                    *-- Registro existente: UPDATE
                    loc_cSQL = "UPDATE SigCdJrn SET" + ;
                               " refers  = " + EscaparSQL(loc_cNovoRefers) + "," + ;
                               " dias    = " + EscaparSQL(THIS.ConstruirDias()) + "," + ;
                               " hora01  = " + EscaparSQL(THIS.this_cHora01) + "," + ;
                               " hora02  = " + EscaparSQL(THIS.this_cHora02) + "," + ;
                               " hora03  = " + EscaparSQL(THIS.this_cHora03) + "," + ;
                               " hora04  = " + EscaparSQL(THIS.this_cHora04) + "," + ;
                               " dtalts  = GETDATE()," + ;
                               " usualts = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                               " WHERE pkchave = " + EscaparSQL(loc_cNovoPk)
                ELSE
                    *-- Registro novo: INSERT
                    loc_cSQL = "INSERT INTO SigCdJrn" + ;
                               " (pkchave, refers, iclis, cargos, dias," + ;
                               "  hora01, hora02, hora03, hora04," + ;
                               "  datas, usuars)" + ;
                               " VALUES (" + ;
                               EscaparSQL(loc_cNovoPk) + ", " + ;
                               EscaparSQL(loc_cNovoRefers) + ", " + ;
                               EscaparSQL(THIS.this_cIclis) + ", " + ;
                               EscaparSQL(THIS.this_cCargos) + ", " + ;
                               EscaparSQL(THIS.ConstruirDias()) + ", " + ;
                               EscaparSQL(THIS.this_cHora01) + ", " + ;
                               EscaparSQL(THIS.this_cHora02) + ", " + ;
                               EscaparSQL(THIS.this_cHora03) + ", " + ;
                               EscaparSQL(THIS.this_cHora04) + ", " + ;
                               "GETDATE(), " + ;
                               EscaparSQL(gc_4c_UsuarioLogado) + ")"
                ENDIF
                USE IN cursor_4c_ChkCopia
            ELSE
                MsgErro("Erro ao verificar registro destino:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                IF USED("cursor_4c_ChkCopia")
                    USE IN cursor_4c_ChkCopia
                ENDIF
                loc_lSucesso = .F.
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao copiar jornada:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em JrnBO.CopiarParaMes:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ChkCopia")
                USE IN cursor_4c_ChkCopia
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarMesesDisponiveis - retorna cursor com meses existentes para
    * funcionario/cargo especificados (para o painel Copiar Mes)
    * par_cIclis:  codigo do funcionario (pode ser vazio = todos)
    * par_cCargos: codigo do cargo (pode ser vazio = todos)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarMesesDisponiveis(par_cIclis, par_cCargos)
        LOCAL loc_cSQL, loc_cWhere, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Meses")
                USE IN cursor_4c_Meses
            ENDIF

            loc_cWhere = " WHERE (iclis = " + EscaparSQL(par_cIclis) + ;
                         " OR " + EscaparSQL(par_cIclis) + " = '')" + ;
                         " AND (cargos = " + EscaparSQL(par_cCargos) + ;
                         " OR " + EscaparSQL(par_cCargos) + " = '')"

            loc_cSQL = "SELECT refers FROM SigCdJrn" + ;
                       loc_cWhere + ;
                       " ORDER BY refers ASC"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Meses")

            IF loc_nResult > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar meses:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em JrnBO.BuscarMesesDisponiveis:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - valida campos obrigatorios antes de salvar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cRefers))
            MsgErro("Refer" + CHR(234) + "ncia (Ano/M" + CHR(234) + "s) " + ;
                    CHR(233) + " obrigat" + CHR(243) + "ria.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cIclis)) AND EMPTY(ALLTRIM(THIS.this_cCargos))
            MsgAviso("Informe o Funcion" + CHR(225) + "rio ou o Cargo.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido
            IF EMPTY(ALLTRIM(THIS.this_cHora01)) OR EMPTY(ALLTRIM(THIS.this_cHora02)) OR ;
               EMPTY(ALLTRIM(THIS.this_cHora03)) OR EMPTY(ALLTRIM(THIS.this_cHora04))
                MsgAviso("Aten" + CHR(231) + CHR(227) + "o!! Todos os hor" + CHR(225) + ;
                        "rios devem ser preenchidos.", "Valida" + CHR(231) + CHR(227) + "o")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - limpeza de cursores
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF
        IF USED("cursor_4c_Meses")
            USE IN cursor_4c_Meses
        ENDIF
        IF USED("cursor_4c_ChkCopia")
            USE IN cursor_4c_ChkCopia
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

