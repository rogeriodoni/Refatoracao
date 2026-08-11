# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (14)
- [ALINHAMENTO] Botao 'cmd_4c_Copia' tem Top=33 mas grupo usa Top=19 (diferenca de 14px)
- [ALINHAMENTO] Botao 'cmd_4c_OKCopia' tem Top=19 mas grupo usa Top=5 (diferenca de 14px)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 183: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 204: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 226: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 248: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 270: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 304: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 327: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 448: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 465: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1751: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1772: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormDup.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2894 linhas total):

*-- Linhas 80 a 98:
80:             THIS.AddObject("pgf_4c_Paginas", "PageFrame")
81:             WITH THIS.pgf_4c_Paginas
82:                 .PageCount  = 2
83:                 .Top        = -29
84:                 .Left       = 0
85:                 .Width      = THIS.Width
86:                 .Height     = THIS.Height + 29
87:                 .Tabs       = .F.
88:                 .TabStretch = 1
89:                 .Visible    = .T.
90:                 .Page1.Caption   = "Lista"
91:                 .Page1.BackColor = RGB(236, 236, 236)
92:                 .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
93:                 .Page2.Caption   = "Dados"
94:                 .Page2.BackColor = RGB(236, 236, 236)
95:                 .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
96:             ENDWITH
97: 
98:             THIS.ConfigurarPaginaLista()

*-- Linhas 118 a 154:
118:             *-- Container cabecalho (cntSombra no legado) - Top=2 dentro da Page
119:             loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
120:             WITH loc_oPagina.cnt_4c_Cabecalho
121:                 .Top         = 2
122:                 .Left        = 0
123:                 .Width       = THIS.Width
124:                 .Height      = 80
125:                 .BackColor   = RGB(100, 100, 100)
126:                 .BorderWidth = 0
127:                 .Visible     = .T.
128: 
129:                 .AddObject("lbl_4c_Sombra", "Label")
130:                 WITH .lbl_4c_Sombra
131:                     .Caption   = THIS.Caption
132:                     .Top       = 15
133:                     .Left      = 10
134:                     .Width     = THIS.Width
135:                     .Height    = 40
136:                     .FontName  = "Tahoma"
137:                     .FontSize  = 16
138:                     .FontBold  = .T.
139:                     .ForeColor = RGB(0, 0, 0)
140:                     .BackStyle = 0
141:                     .AutoSize  = .F.
142:                     .Visible   = .T.
143:                 ENDWITH
144: 
145:                 .AddObject("lbl_4c_Titulo", "Label")
146:                 WITH .lbl_4c_Titulo
147:                     .Caption   = THIS.Caption
148:                     .Top       = 18
149:                     .Left      = 10
150:                     .Width     = THIS.Width
151:                     .Height    = 46
152:                     .FontName  = "Tahoma"
153:                     .FontSize  = 16
154:                     .FontBold  = .T.

*-- Linhas 162 a 276:
162:             *-- Container botoes CRUD (Grupo_Op no legado) - lado direito
163:             loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
164:             WITH loc_oPagina.cnt_4c_Botoes
165:                 .Top         = 0
166:                 .Left        = 542
167:                 .Width       = 390
168:                 .Height      = 85
169:                 .BackStyle   = 1
170:                 .BackColor   = RGB(53, 53, 53)
171:                 .BorderWidth = 0
172:                 .Visible     = .T.
173: 
174:                 .AddObject("cmd_4c_Incluir", "CommandButton")
175:                 WITH .cmd_4c_Incluir
176:                     .Caption         = "Incluir"
177:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
178:                     .PicturePosition = 13
179:                     .Top             = 5
180:                     .Left            =  542
181:                     .Width           = 75
182:                     .Height          = 75
183:                     .FontName        = "Comic Sans MS"
184:                     .FontSize        = 8
185:                     .FontBold        = .T.
186:                     .FontItalic      = .T.
187:                     .ForeColor       = RGB(90, 90, 90)
188:                     .BackColor       = RGB(255, 255, 255)
189:                     .SpecialEffect   = 0
190:                     .MousePointer    = 15
191:                     .WordWrap        = .T.
192:                     .AutoSize        = .F.
193:                 ENDWITH
194: 
195:                 .AddObject("cmd_4c_Visualizar", "CommandButton")
196:                 WITH .cmd_4c_Visualizar
197:                     .Caption         = "Visualizar"
198:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
199:                     .PicturePosition = 13
200:                     .Top             = 5
201:                     .Left            =  542
202:                     .Width           = 75
203:                     .Height          = 75
204:                     .FontName        = "Comic Sans MS"
205:                     .FontSize        = 8
206:                     .FontBold        = .T.
207:                     .FontItalic      = .T.
208:                     .ForeColor       = RGB(90, 90, 90)
209:                     .BackColor       = RGB(255, 255, 255)
210:                     .Themes          = .F.
211:                     .SpecialEffect   = 0
212:                     .MousePointer    = 15
213:                     .WordWrap        = .T.
214:                     .AutoSize        = .F.
215:                 ENDWITH
216: 
217:                 .AddObject("cmd_4c_Alterar", "CommandButton")
218:                 WITH .cmd_4c_Alterar
219:                     .Caption         = "Alterar"
220:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
221:                     .PicturePosition = 13
222:                     .Top             = 5
223:                     .Left            =  542
224:                     .Width           = 75
225:                     .Height          = 75
226:                     .FontName        = "Comic Sans MS"
227:                     .FontSize        = 8
228:                     .FontBold        = .T.
229:                     .FontItalic      = .T.
230:                     .ForeColor       = RGB(90, 90, 90)
231:                     .BackColor       = RGB(255, 255, 255)
232:                     .Themes          = .F.
233:                     .SpecialEffect   = 0
234:                     .MousePointer    = 15
235:                     .WordWrap        = .T.
236:                     .AutoSize        = .F.
237:                 ENDWITH
238: 
239:                 .AddObject("cmd_4c_Excluir", "CommandButton")
240:                 WITH .cmd_4c_Excluir
241:                     .Caption         = "Excluir"
242:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
243:                     .PicturePosition = 13
244:                     .Top             = 5
245:                     .Left            =  542
246:                     .Width           = 75
247:                     .Height          = 75
248:                     .FontName        = "Comic Sans MS"
249:                     .FontSize        = 8
250:                     .FontBold        = .T.
251:                     .FontItalic      = .T.
252:                     .ForeColor       = RGB(90, 90, 90)
253:                     .BackColor       = RGB(255, 255, 255)
254:                     .Themes          = .F.
255:                     .SpecialEffect   = 0
256:                     .MousePointer    = 15
257:                     .WordWrap        = .T.
258:                     .AutoSize        = .F.
259:                 ENDWITH
260: 
261:                 .AddObject("cmd_4c_Buscar", "CommandButton")
262:                 WITH .cmd_4c_Buscar
263:                     .Caption         = "Buscar"
264:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
265:                     .PicturePosition = 13
266:                     .Top             = 5
267:                     .Left            =  542
268:                     .Width           = 75
269:                     .Height          = 75
270:                     .FontName        = "Comic Sans MS"
271:                     .FontSize        = 8
272:                     .FontBold        = .T.
273:                     .FontItalic      = .T.
274:                     .ForeColor       = RGB(90, 90, 90)
275:                     .BackColor       = RGB(255, 255, 255)
276:                     .Themes          = .F.

*-- Linhas 284 a 334:
284:             *-- Container saida - padrao canonico (CLAUDE.md regra #10)
285:             loc_oPagina.AddObject("cnt_4c_Saida", "Container")
286:             WITH loc_oPagina.cnt_4c_Saida
287:                 .Top         = 29
288:                 .Left        = 917
289:                 .Width       = 90
290:                 .Height      = 85
291:                 .BackStyle   = 0
292:                 .BorderWidth = 0
293:                 .Visible     = .T.
294: 
295:                 .AddObject("cmd_4c_Encerrar", "CommandButton")
296:                 WITH .cmd_4c_Encerrar
297:                     .Caption         = "Encerrar"
298:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
299:                     .PicturePosition = 13
300:                     .Top             = 5
301:                     .Left            = 917
302:                     .Width           = 90
303:                     .Height          = 75
304:                     .FontName        = "Comic Sans MS"
305:                     .FontSize        = 8
306:                     .FontBold        = .T.
307:                     .FontItalic      = .T.
308:                     .ForeColor       = RGB(90, 90, 90)
309:                     .BackColor       = RGB(255, 255, 255)
310:                     .SpecialEffect   = 0
311:                     .MousePointer    = 15
312:                     .WordWrap        = .T.
313:                     .AutoSize        = .F.
314:                 ENDWITH
315:             ENDWITH
316: 
317:             *-- Botao Copiar (Copia no legado) - original top=4 -> migrado 4+29=33
318:             loc_oPagina.AddObject("cmd_4c_Copia", "CommandButton")
319:             WITH loc_oPagina.cmd_4c_Copia
320:                 .Caption         = "Copiar"
321:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
322:                 .PicturePosition = 13
323:                 .Top             = 33
324:                 .Left            = 474
325:                 .Width           = 75
326:                 .Height          = 75
327:                 .FontName        = "Comic Sans MS"
328:                 .FontSize        = 8
329:                 .FontBold        = .T.
330:                 .FontItalic      = .T.
331:                 .ForeColor       = RGB(90, 90, 90)
332:                 .BackColor       = RGB(255, 255, 255)
333:                 .Themes          = .F.
334:                 .SpecialEffect   = 0

*-- Linhas 344 a 353:
344:             loc_oPagina.grd_4c_Lista.ColumnCount = 1
345:             loc_oPagina.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
346:             WITH loc_oPagina.grd_4c_Lista
347:                 .Top                = 117
348:                 .Left               = 12
349:                 .Width              = 890
350:                 .Height             = 490
351:                 .FontName           = "Verdana"
352:                 .FontSize           = 8
353:                 .ForeColor          = RGB(90, 90, 90)

*-- Linhas 367 a 498:
367:                     .ControlSource    = "cursor_4c_Dados.series"
368:                     .Width            = 100
369:                     .Resizable        = .T.
370:                     .Header1.Caption  = "S" + CHR(233) + "rie"
371:                 ENDWITH
372:             ENDWITH
373: 
374:             *-- Painel flutuante de copia de series (cntcopia no legado - Visible=.F.)
375:             *-- Top=270 = 241 (original) + 29 (compensacao PageFrame)
376:             *-- Nome "cnt_4c_CopiaFl" -> UPPER = "CNT_4C_COPIAFL" (guardado em TornarControlesVisiveis)
377:             loc_oPagina.AddObject("cnt_4c_CopiaFl", "Container")
378:             WITH loc_oPagina.cnt_4c_CopiaFl
379:                 .Top         = 270
380:                 .Left        = 335
381:                 .Width       = 317
382:                 .Height      = 123
383:                 .BackColor   = RGB(220, 220, 220)
384:                 .BorderWidth = 1
385:                 .Visible     = .F.
386: 
387:                 .AddObject("lbl_4c_LblSerieOrigem", "Label")
388:                 WITH .lbl_4c_LblSerieOrigem
389:                     .Caption   = "S" + CHR(233) + "rie Origem :"
390:                     .Top       = 40
391:                     .Left      = 29
392:                     .Width     = 72
393:                     .Height    = 15
394:                     .FontName  = "Tahoma"
395:                     .FontSize  = 8
396:                     .BackStyle = 0
397:                     .ForeColor = RGB(0, 0, 0)
398:                     .Visible   = .T.
399:                 ENDWITH
400: 
401:                 .AddObject("txt_4c_SeriesOrigem", "TextBox")
402:                 WITH .txt_4c_SeriesOrigem
403:                     .Top      = 36
404:                     .Left     = 103
405:                     .Width    = 34
406:                     .Height   = 24
407:                     .FontName = "Tahoma"
408:                     .FontSize = 8
409:                     .Value    = ""
410:                     .ReadOnly = .T.
411:                     .Visible  = .T.
412:                 ENDWITH
413: 
414:                 .AddObject("lbl_4c_LblSerieDestino", "Label")
415:                 WITH .lbl_4c_LblSerieDestino
416:                     .Caption   = "S" + CHR(233) + "rie Destino :"
417:                     .Top       = 66
418:                     .Left      = 27
419:                     .Width     = 72
420:                     .Height    = 15
421:                     .FontName  = "Tahoma"
422:                     .FontSize  = 8
423:                     .BackStyle = 0
424:                     .ForeColor = RGB(0, 0, 0)
425:                     .Visible   = .T.
426:                 ENDWITH
427: 
428:                 .AddObject("txt_4c_SerieDestino", "TextBox")
429:                 WITH .txt_4c_SerieDestino
430:                     .Top      = 62
431:                     .Left     = 103
432:                     .Width    = 34
433:                     .Height   = 24
434:                     .FontName = "Tahoma"
435:                     .FontSize = 8
436:                     .Value    = ""
437:                     .Visible  = .T.
438:                 ENDWITH
439: 
440:                 .AddObject("cmd_4c_OKCopia", "CommandButton")
441:                 WITH .cmd_4c_OKCopia
442:                     .Caption       = "Confirmar"
443:                     .Top           = 19
444:                     .Left          = 158
445:                     .Width         = 75
446:                     .Height        = 75
447:                     .FontName      = "Comic Sans MS"
448:                     .FontSize      = 8
449:                     .ForeColor     = RGB(90, 90, 90)
450:                     .BackColor     = RGB(255, 255, 255)
451:                     .Themes        = .F.
452:                     .SpecialEffect = 0
453:                     .MousePointer  = 15
454:                     .Visible       = .T.
455:                 ENDWITH
456: 
457:                 .AddObject("cmd_4c_CancelarCopia", "CommandButton")
458:                 WITH .cmd_4c_CancelarCopia
459:                     .Caption       = "Cancelar"
460:                     .Top           = 19
461:                     .Left          = 239
462:                     .Width         = 75
463:                     .Height        = 75
464:                     .FontName      = "Comic Sans MS"
465:                     .FontSize      = 8
466:                     .ForeColor     = RGB(90, 90, 90)
467:                     .BackColor     = RGB(255, 255, 255)
468:                     .Themes        = .F.
469:                     .SpecialEffect = 0
470:                     .MousePointer  = 15
471:                     .Visible       = .T.
472:                 ENDWITH
473:             ENDWITH
474: 
475:             *-- BINDEVENTs da Page1
476:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,        "Click", THIS, "BtnIncluirClick")
477:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar,     "Click", THIS, "BtnVisualizarClick")
478:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,        "Click", THIS, "BtnAlterarClick")
479:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,        "Click", THIS, "BtnExcluirClick")
480:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,         "Click", THIS, "BtnBuscarClick")
481:             BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,        "Click", THIS, "BtnEncerrarClick")
482:             BINDEVENT(loc_oPagina.cmd_4c_Copia,                        "Click", THIS, "BtnCopiarClick")
483:             BINDEVENT(loc_oPagina.cnt_4c_CopiaFl.cmd_4c_OKCopia,       "Click", THIS, "BtnOKCopiarClick")
484:             BINDEVENT(loc_oPagina.cnt_4c_CopiaFl.cmd_4c_CancelarCopia, "Click", THIS, "BtnCancelarCopiarClick")
485:             BINDEVENT(loc_oPagina.cnt_4c_CopiaFl.txt_4c_SerieDestino,  "KeyPress", THIS, "ValidarSerieDestino")
486: 
487:             THIS.TornarControlesVisiveis(loc_oPagina)
488: 
489:         CATCH TO loException
490:             MsgErro("Erro ao configurar Page1:" + CHR(13) + loException.Message, "Erro")
491:         ENDTRY
492:     ENDPROC
493: 
494:     *==========================================================================
495:     * ConfigurarPaginaDados - Configura Page2 (Dados)
496:     * Fase 5: Serie, Cabecalho e primeira linha do Sacado
497:     * Fase 6: Segunda linha Sacado, Observacao e Impressora (a adicionar)
498:     *==========================================================================

*-- Linhas 507 a 1099:
507:             *------------------------------------------------------------------
508:             * SERIE (PK) - txt_4c_Series: top=70+29=99 / Label40: top=72+29=101
509:             *------------------------------------------------------------------
510:             loc_oPagina.AddObject("lbl_4c_LblSerie", "Label")
511:             WITH loc_oPagina.lbl_4c_LblSerie
512:                 .Caption   = "S" + CHR(233) + "rie :"
513:                 .Top       = 101
514:                 .Left      = 185
515:                 .Width     = 37
516:                 .Height    = 15
517:                 .FontName  = "Tahoma"
518:                 .FontSize  = 8
519:                 .ForeColor = RGB(90, 90, 90)
520:                 .BackStyle = 0
521:                 .Visible   = .T.
522:             ENDWITH
523: 
524:             loc_oPagina.AddObject("txt_4c_Series", "TextBox")
525:             WITH loc_oPagina.txt_4c_Series
526:                 .Value    = ""
527:                 .Top      = 99
528:                 .Left     = 229
529:                 .Width    = 31
530:                 .Height   = 18
531:                 .FontName = "Tahoma"
532:                 .FontSize = 8
533:                 .Visible  = .T.
534:             ENDWITH
535: 
536:             *------------------------------------------------------------------
537:             * SECAO CABECALHO (linha/coluna impressao dados do documento)
538:             * Label27 top=103+29=132 / Shape1 top=119+29=148
539:             *------------------------------------------------------------------
540:             loc_oPagina.AddObject("lbl_4c_SecCabecalho", "Label")
541:             WITH loc_oPagina.lbl_4c_SecCabecalho
542:                 .Caption   = "Cabe" + CHR(231) + "alho"
543:                 .Top       = 132
544:                 .Left      = 183
545:                 .Width     = 80
546:                 .Height    = 15
547:                 .FontName  = "Tahoma"
548:                 .FontSize  = 8
549:                 .FontBold  = .T.
550:                 .ForeColor = RGB(90, 90, 90)
551:                 .BackStyle = 0
552:                 .Visible   = .T.
553:             ENDWITH
554: 
555:             loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
556:             WITH loc_oPagina.shp_4c_Shape1
557:                 .Top           = 148
558:                 .Left          = 173
559:                 .Width         = 560
560:                 .Height        = 2
561:                 .FillColor     = RGB(150, 150, 150)
562:                 .ForeColor     = RGB(150, 150, 150)
563:                 .BackStyle     = 0
564:                 .BorderStyle   = 1
565:                 .SpecialEffect = 0
566:                 .Visible       = .T.
567:             ENDWITH
568: 
569:             *-- Data Emissao (Label5/Text5/Label6/Text6) top=124+29=153 / 138+29=167
570:             loc_oPagina.AddObject("lbl_4c_LblDtDoc", "Label")
571:             WITH loc_oPagina.lbl_4c_LblDtDoc
572:                 .Caption   = "Data Emiss" + CHR(227) + "o"
573:                 .Top       = 153
574:                 .Left      = 184
575:                 .Width     = 66
576:                 .Height    = 15
577:                 .FontName  = "Tahoma"
578:                 .FontSize  = 8
579:                 .ForeColor = RGB(90, 90, 90)
580:                 .BackStyle = 0
581:                 .Visible   = .T.
582:             ENDWITH
583:             loc_oPagina.AddObject("txt_4c_Text5", "TextBox")
584:             WITH loc_oPagina.txt_4c_Text5
585:                 .Value    = 0
586:                 .Top      = 167
587:                 .Left     = 184
588:                 .Width    = 41
589:                 .Height   = 18
590:                 .FontName = "Tahoma"
591:                 .FontSize = 8
592:                 .Visible  = .T.
593:             ENDWITH
594:             loc_oPagina.AddObject("lbl_4c_XDtDoc", "Label")
595:             WITH loc_oPagina.lbl_4c_XDtDoc
596:                 .Caption   = "x"
597:                 .Top       = 169
598:                 .Left      = 226
599:                 .Width     = 8
600:                 .Height    = 15
601:                 .FontName  = "Tahoma"
602:                 .FontSize  = 8
603:                 .ForeColor = RGB(90, 90, 90)
604:                 .BackStyle = 0
605:                 .Visible   = .T.
606:             ENDWITH
607:             loc_oPagina.AddObject("txt_4c_Text6", "TextBox")
608:             WITH loc_oPagina.txt_4c_Text6
609:                 .Value    = 0
610:                 .Top      = 167
611:                 .Left     = 233
612:                 .Width    = 41
613:                 .Height   = 18
614:                 .FontName = "Tahoma"
615:                 .FontSize = 8
616:                 .Visible  = .T.
617:             ENDWITH
618: 
619:             *-- Nota Fiscal (Label1/Text1/Label2/Text2) top=153 / 167
620:             loc_oPagina.AddObject("lbl_4c_LblNota", "Label")
621:             WITH loc_oPagina.lbl_4c_LblNota
622:                 .Caption   = "Nota Fiscal"
623:                 .Top       = 153
624:                 .Left      = 293
625:                 .Width     = 54
626:                 .Height    = 15
627:                 .FontName  = "Tahoma"
628:                 .FontSize  = 8
629:                 .ForeColor = RGB(90, 90, 90)
630:                 .BackStyle = 0
631:                 .Visible   = .T.
632:             ENDWITH
633:             loc_oPagina.AddObject("txt_4c_Text1", "TextBox")
634:             WITH loc_oPagina.txt_4c_Text1
635:                 .Value    = 0
636:                 .Top      = 167
637:                 .Left     = 293
638:                 .Width    = 41
639:                 .Height   = 18
640:                 .FontName = "Tahoma"
641:                 .FontSize = 8
642:                 .Visible  = .T.
643:             ENDWITH
644:             loc_oPagina.AddObject("lbl_4c_XNota", "Label")
645:             WITH loc_oPagina.lbl_4c_XNota
646:                 .Caption   = "x"
647:                 .Top       = 169
648:                 .Left      = 335
649:                 .Width     = 8
650:                 .Height    = 15
651:                 .FontName  = "Tahoma"
652:                 .FontSize  = 8
653:                 .ForeColor = RGB(90, 90, 90)
654:                 .BackStyle = 0
655:                 .Visible   = .T.
656:             ENDWITH
657:             loc_oPagina.AddObject("txt_4c_Text2", "TextBox")
658:             WITH loc_oPagina.txt_4c_Text2
659:                 .Value    = 0
660:                 .Top      = 167
661:                 .Left     = 342
662:                 .Width    = 41
663:                 .Height   = 18
664:                 .FontName = "Tahoma"
665:                 .FontSize = 8
666:                 .Visible  = .T.
667:             ENDWITH
668: 
669:             *-- Valor da Duplicata (Label9/Text9/Label10/Text10)
670:             loc_oPagina.AddObject("lbl_4c_LblVlDoc", "Label")
671:             WITH loc_oPagina.lbl_4c_LblVlDoc
672:                 .Caption   = "Valor da Duplicata"
673:                 .Top       = 153
674:                 .Left      = 403
675:                 .Width     = 88
676:                 .Height    = 15
677:                 .FontName  = "Tahoma"
678:                 .FontSize  = 8
679:                 .ForeColor = RGB(90, 90, 90)
680:                 .BackStyle = 0
681:                 .Visible   = .T.
682:             ENDWITH
683:             loc_oPagina.AddObject("txt_4c_Text9", "TextBox")
684:             WITH loc_oPagina.txt_4c_Text9
685:                 .Value    = 0
686:                 .Top      = 168
687:                 .Left     = 403
688:                 .Width    = 41
689:                 .Height   = 18
690:                 .FontName = "Tahoma"
691:                 .FontSize = 8
692:                 .Visible  = .T.
693:             ENDWITH
694:             loc_oPagina.AddObject("lbl_4c_XVlDoc", "Label")
695:             WITH loc_oPagina.lbl_4c_XVlDoc
696:                 .Caption   = "x"
697:                 .Top       = 169
698:                 .Left      = 445
699:                 .Width     = 8
700:                 .Height    = 15
701:                 .FontName  = "Tahoma"
702:                 .FontSize  = 8
703:                 .ForeColor = RGB(90, 90, 90)
704:                 .BackStyle = 0
705:                 .Visible   = .T.
706:             ENDWITH
707:             loc_oPagina.AddObject("txt_4c_Text10", "TextBox")
708:             WITH loc_oPagina.txt_4c_Text10
709:                 .Value    = 0
710:                 .Top      = 168
711:                 .Left     = 452
712:                 .Width    = 41
713:                 .Height   = 18
714:                 .FontName = "Tahoma"
715:                 .FontSize = 8
716:                 .Visible  = .T.
717:             ENDWITH
718: 
719:             *-- N da Duplicata (Label7/Text7/Label8/Text8)
720:             loc_oPagina.AddObject("lbl_4c_LblNrDoc", "Label")
721:             WITH loc_oPagina.lbl_4c_LblNrDoc
722:                 .Caption   = "N" + CHR(176) + " da Duplicata"
723:                 .Top       = 153
724:                 .Left      = 513
725:                 .Width     = 76
726:                 .Height    = 15
727:                 .FontName  = "Tahoma"
728:                 .FontSize  = 8
729:                 .ForeColor = RGB(90, 90, 90)
730:                 .BackStyle = 0
731:                 .Visible   = .T.
732:             ENDWITH
733:             loc_oPagina.AddObject("txt_4c_Text7", "TextBox")
734:             WITH loc_oPagina.txt_4c_Text7
735:                 .Value    = 0
736:                 .Top      = 167
737:                 .Left     = 513
738:                 .Width    = 41
739:                 .Height   = 18
740:                 .FontName = "Tahoma"
741:                 .FontSize = 8
742:                 .Visible  = .T.
743:             ENDWITH
744:             loc_oPagina.AddObject("lbl_4c_XNrDoc", "Label")
745:             WITH loc_oPagina.lbl_4c_XNrDoc
746:                 .Caption   = "x"
747:                 .Top       = 169
748:                 .Left      = 555
749:                 .Width     = 8
750:                 .Height    = 15
751:                 .FontName  = "Tahoma"
752:                 .FontSize  = 8
753:                 .ForeColor = RGB(90, 90, 90)
754:                 .BackStyle = 0
755:                 .Visible   = .T.
756:             ENDWITH
757:             loc_oPagina.AddObject("txt_4c_Text8", "TextBox")
758:             WITH loc_oPagina.txt_4c_Text8
759:                 .Value    = 0
760:                 .Top      = 167
761:                 .Left     = 562
762:                 .Width    = 41
763:                 .Height   = 18
764:                 .FontName = "Tahoma"
765:                 .FontSize = 8
766:                 .Visible  = .T.
767:             ENDWITH
768: 
769:             *-- Vencimento (Label3/Text3/Label4/Text4)
770:             loc_oPagina.AddObject("lbl_4c_LblDtVenc", "Label")
771:             WITH loc_oPagina.lbl_4c_LblDtVenc
772:                 .Caption   = "Vencimento"
773:                 .Top       = 153
774:                 .Left      = 623
775:                 .Width     = 57
776:                 .Height    = 15
777:                 .FontName  = "Tahoma"
778:                 .FontSize  = 8
779:                 .ForeColor = RGB(90, 90, 90)
780:                 .BackStyle = 0
781:                 .Visible   = .T.
782:             ENDWITH
783:             loc_oPagina.AddObject("txt_4c_Text3", "TextBox")
784:             WITH loc_oPagina.txt_4c_Text3
785:                 .Value    = 0
786:                 .Top      = 167
787:                 .Left     = 623
788:                 .Width    = 41
789:                 .Height   = 18
790:                 .FontName = "Tahoma"
791:                 .FontSize = 8
792:                 .Visible  = .T.
793:             ENDWITH
794:             loc_oPagina.AddObject("lbl_4c_XDtVenc", "Label")
795:             WITH loc_oPagina.lbl_4c_XDtVenc
796:                 .Caption   = "x"
797:                 .Top       = 169
798:                 .Left      = 665
799:                 .Width     = 8
800:                 .Height    = 15
801:                 .FontName  = "Tahoma"
802:                 .FontSize  = 8
803:                 .ForeColor = RGB(90, 90, 90)
804:                 .BackStyle = 0
805:                 .Visible   = .T.
806:             ENDWITH
807:             loc_oPagina.AddObject("txt_4c_Text4", "TextBox")
808:             WITH loc_oPagina.txt_4c_Text4
809:                 .Value    = 0
810:                 .Top      = 167
811:                 .Left     = 672
812:                 .Width    = 41
813:                 .Height   = 18
814:                 .FontName = "Tahoma"
815:                 .FontSize = 8
816:                 .Visible  = .T.
817:             ENDWITH
818: 
819:             *------------------------------------------------------------------
820:             * SECAO SACADO - primeira linha (linha/coluna dados do cliente)
821:             * Label31 top=174+29=203 / Shape3 top=190+29=219
822:             *------------------------------------------------------------------
823:             loc_oPagina.AddObject("lbl_4c_SecSacado", "Label")
824:             WITH loc_oPagina.lbl_4c_SecSacado
825:                 .Caption   = "Sacado"
826:                 .Top       = 203
827:                 .Left      = 183
828:                 .Width     = 43
829:                 .Height    = 15
830:                 .FontName  = "Tahoma"
831:                 .FontSize  = 8
832:                 .FontBold  = .T.
833:                 .ForeColor = RGB(90, 90, 90)
834:                 .BackStyle = 0
835:                 .Visible   = .T.
836:             ENDWITH
837: 
838:             loc_oPagina.AddObject("shp_4c_Shape3", "Shape")
839:             WITH loc_oPagina.shp_4c_Shape3
840:                 .Top           = 219
841:                 .Left          = 173
842:                 .Width         = 560
843:                 .Height        = 2
844:                 .FillColor     = RGB(150, 150, 150)
845:                 .ForeColor     = RGB(150, 150, 150)
846:                 .BackStyle     = 0
847:                 .BorderStyle   = 1
848:                 .SpecialEffect = 0
849:                 .Visible       = .T.
850:             ENDWITH
851: 
852:             *-- Razao Social (Label13/Text15/Label14/Text16) top=195+29=224 / 210+29=239
853:             loc_oPagina.AddObject("lbl_4c_LblRazCli", "Label")
854:             WITH loc_oPagina.lbl_4c_LblRazCli
855:                 .Caption   = "Raz" + CHR(227) + "o Social"
856:                 .Top       = 224
857:                 .Left      = 183
858:                 .Width     = 62
859:                 .Height    = 15
860:                 .FontName  = "Tahoma"
861:                 .FontSize  = 8
862:                 .ForeColor = RGB(90, 90, 90)
863:                 .BackStyle = 0
864:                 .Visible   = .T.
865:             ENDWITH
866:             loc_oPagina.AddObject("txt_4c_Text15", "TextBox")
867:             WITH loc_oPagina.txt_4c_Text15
868:                 .Value    = 0
869:                 .Top      = 239
870:                 .Left     = 183
871:                 .Width    = 41
872:                 .Height   = 18
873:                 .FontName = "Tahoma"
874:                 .FontSize = 8
875:                 .Visible  = .T.
876:             ENDWITH
877:             loc_oPagina.AddObject("lbl_4c_XRazCli", "Label")
878:             WITH loc_oPagina.lbl_4c_XRazCli
879:                 .Caption   = "x"
880:                 .Top       = 240
881:                 .Left      = 225
882:                 .Width     = 8
883:                 .Height    = 15
884:                 .FontName  = "Tahoma"
885:                 .FontSize  = 8
886:                 .ForeColor = RGB(90, 90, 90)
887:                 .BackStyle = 0
888:                 .Visible   = .T.
889:             ENDWITH
890:             loc_oPagina.AddObject("txt_4c_Text16", "TextBox")
891:             WITH loc_oPagina.txt_4c_Text16
892:                 .Value    = 0
893:                 .Top      = 239
894:                 .Left     = 232
895:                 .Width    = 41
896:                 .Height   = 18
897:                 .FontName = "Tahoma"
898:                 .FontSize = 8
899:                 .Visible  = .T.
900:             ENDWITH
901: 
902:             *-- C.G.C./C.P.F. (Label15/Text17/Label16/Text18)
903:             loc_oPagina.AddObject("lbl_4c_LblCgcCli", "Label")
904:             WITH loc_oPagina.lbl_4c_LblCgcCli
905:                 .Caption   = "C.G.C./C.P.F."
906:                 .Top       = 224
907:                 .Left      = 293
908:                 .Width     = 70
909:                 .Height    = 15
910:                 .FontName  = "Tahoma"
911:                 .FontSize  = 8
912:                 .ForeColor = RGB(90, 90, 90)
913:                 .BackStyle = 0
914:                 .Visible   = .T.
915:             ENDWITH
916:             loc_oPagina.AddObject("txt_4c_Text17", "TextBox")
917:             WITH loc_oPagina.txt_4c_Text17
918:                 .Value    = 0
919:                 .Top      = 239
920:                 .Left     = 293
921:                 .Width    = 41
922:                 .Height   = 18
923:                 .FontName = "Tahoma"
924:                 .FontSize = 8
925:                 .Visible  = .T.
926:             ENDWITH
927:             loc_oPagina.AddObject("lbl_4c_XCgcCli", "Label")
928:             WITH loc_oPagina.lbl_4c_XCgcCli
929:                 .Caption   = "x"
930:                 .Top       = 240
931:                 .Left      = 335
932:                 .Width     = 8
933:                 .Height    = 15
934:                 .FontName  = "Tahoma"
935:                 .FontSize  = 8
936:                 .ForeColor = RGB(90, 90, 90)
937:                 .BackStyle = 0
938:                 .Visible   = .T.
939:             ENDWITH
940:             loc_oPagina.AddObject("txt_4c_Text18", "TextBox")
941:             WITH loc_oPagina.txt_4c_Text18
942:                 .Value    = 0
943:                 .Top      = 239
944:                 .Left     = 342
945:                 .Width    = 41
946:                 .Height   = 18
947:                 .FontName = "Tahoma"
948:                 .FontSize = 8
949:                 .Visible  = .T.
950:             ENDWITH
951: 
952:             *-- Insc. Estadual (Label11/Text11/Label12/Text12)
953:             loc_oPagina.AddObject("lbl_4c_LblEstCli", "Label")
954:             WITH loc_oPagina.lbl_4c_LblEstCli
955:                 .Caption   = "Insc. Estadual"
956:                 .Top       = 224
957:                 .Left      = 403
958:                 .Width     = 70
959:                 .Height    = 15
960:                 .FontName  = "Tahoma"
961:                 .FontSize  = 8
962:                 .ForeColor = RGB(90, 90, 90)
963:                 .BackStyle = 0
964:                 .Visible   = .T.
965:             ENDWITH
966:             loc_oPagina.AddObject("txt_4c_Text11", "TextBox")
967:             WITH loc_oPagina.txt_4c_Text11
968:                 .Value    = 0
969:                 .Top      = 239
970:                 .Left     = 403
971:                 .Width    = 41
972:                 .Height   = 18
973:                 .FontName = "Tahoma"
974:                 .FontSize = 8
975:                 .Visible  = .T.
976:             ENDWITH
977:             loc_oPagina.AddObject("lbl_4c_XEstCli", "Label")
978:             WITH loc_oPagina.lbl_4c_XEstCli
979:                 .Caption   = "x"
980:                 .Top       = 240
981:                 .Left      = 445
982:                 .Width     = 8
983:                 .Height    = 15
984:                 .FontName  = "Tahoma"
985:                 .FontSize  = 8
986:                 .ForeColor = RGB(90, 90, 90)
987:                 .BackStyle = 0
988:                 .Visible   = .T.
989:             ENDWITH
990:             loc_oPagina.AddObject("txt_4c_Text12", "TextBox")
991:             WITH loc_oPagina.txt_4c_Text12
992:                 .Value    = 0
993:                 .Top      = 239
994:                 .Left     = 452
995:                 .Width    = 41
996:                 .Height   = 18
997:                 .FontName = "Tahoma"
998:                 .FontSize = 8
999:                 .Visible  = .T.
1000:             ENDWITH
1001: 
1002:             *-- Valor por Extenso (Label28/Text13/Label29/Text14)
1003:             loc_oPagina.AddObject("lbl_4c_LblExtens", "Label")
1004:             WITH loc_oPagina.lbl_4c_LblExtens
1005:                 .Caption   = "Valor por Extenso"
1006:                 .Top       = 223
1007:                 .Left      = 516
1008:                 .Width     = 87
1009:                 .Height    = 15
1010:                 .FontName  = "Tahoma"
1011:                 .FontSize  = 8
1012:                 .ForeColor = RGB(90, 90, 90)
1013:                 .BackStyle = 0
1014:                 .Visible   = .T.
1015:             ENDWITH
1016:             loc_oPagina.AddObject("txt_4c_Text13", "TextBox")
1017:             WITH loc_oPagina.txt_4c_Text13
1018:                 .Value    = 0
1019:                 .Top      = 238
1020:                 .Left     = 516
1021:                 .Width    = 41
1022:                 .Height   = 18
1023:                 .FontName = "Tahoma"
1024:                 .FontSize = 8
1025:                 .Visible  = .T.
1026:             ENDWITH
1027:             loc_oPagina.AddObject("lbl_4c_XExtens", "Label")
1028:             WITH loc_oPagina.lbl_4c_XExtens
1029:                 .Caption   = "x"
1030:                 .Top       = 239
1031:                 .Left      = 558
1032:                 .Width     = 8
1033:                 .Height    = 15
1034:                 .FontName  = "Tahoma"
1035:                 .FontSize  = 8
1036:                 .ForeColor = RGB(90, 90, 90)
1037:                 .BackStyle = 0
1038:                 .Visible   = .T.
1039:             ENDWITH
1040:             loc_oPagina.AddObject("txt_4c_Text14", "TextBox")
1041:             WITH loc_oPagina.txt_4c_Text14
1042:                 .Value    = 0
1043:                 .Top      = 238
1044:                 .Left     = 565
1045:                 .Width    = 41
1046:                 .Height   = 18
1047:                 .FontName = "Tahoma"
1048:                 .FontSize = 8
1049:                 .Visible  = .T.
1050:             ENDWITH
1051: 
1052:             *-- Praca (Label30/Text32/Label37/Text33)
1053:             loc_oPagina.AddObject("lbl_4c_LblPraca", "Label")
1054:             WITH loc_oPagina.lbl_4c_LblPraca
1055:                 .Caption   = "Pra" + CHR(231) + "a"
1056:                 .Top       = 224
1057:                 .Left      = 626
1058:                 .Width     = 32
1059:                 .Height    = 15
1060:                 .FontName  = "Tahoma"
1061:                 .FontSize  = 8
1062:                 .ForeColor = RGB(90, 90, 90)
1063:                 .BackStyle = 0
1064:                 .Visible   = .T.
1065:             ENDWITH
1066:             loc_oPagina.AddObject("txt_4c_Text32", "TextBox")
1067:             WITH loc_oPagina.txt_4c_Text32
1068:                 .Value    = 0
1069:                 .Top      = 239
1070:                 .Left     = 626
1071:                 .Width    = 41
1072:                 .Height   = 18
1073:                 .FontName = "Tahoma"
1074:                 .FontSize = 8
1075:                 .Visible  = .T.
1076:             ENDWITH
1077:             loc_oPagina.AddObject("lbl_4c_XPraca", "Label")
1078:             WITH loc_oPagina.lbl_4c_XPraca
1079:                 .Caption   = "x"
1080:                 .Top       = 240
1081:                 .Left      = 668
1082:                 .Width     = 8
1083:                 .Height    = 15
1084:                 .FontName  = "Tahoma"
1085:                 .FontSize  = 8
1086:                 .ForeColor = RGB(90, 90, 90)
1087:                 .BackStyle = 0
1088:                 .Visible   = .T.
1089:             ENDWITH
1090:             loc_oPagina.AddObject("txt_4c_Text33", "TextBox")
1091:             WITH loc_oPagina.txt_4c_Text33
1092:                 .Value    = 0
1093:                 .Top      = 239
1094:                 .Left     = 675
1095:                 .Width    = 41
1096:                 .Height   = 18
1097:                 .FontName = "Tahoma"
1098:                 .FontSize = 8
1099:                 .Visible  = .T.

*-- Linhas 1105 a 1599:
1105:             *------------------------------------------------------------------
1106:             loc_oPagina.AddObject("shp_4c_Shape2", "Shape")
1107:             WITH loc_oPagina.shp_4c_Shape2
1108:                 .Top           = 318
1109:                 .Left          = 174
1110:                 .Width         = 262
1111:                 .Height        = 2
1112:                 .FillColor     = RGB(150, 150, 150)
1113:                 .ForeColor     = RGB(150, 150, 150)
1114:                 .BackStyle     = 0
1115:                 .BorderStyle   = 1
1116:                 .SpecialEffect = 0
1117:                 .Visible       = .T.
1118:             ENDWITH
1119: 
1120:             loc_oPagina.AddObject("shp_4c_Shape6", "Shape")
1121:             WITH loc_oPagina.shp_4c_Shape6
1122:                 .Top           = 318
1123:                 .Left          = 437
1124:                 .Width         = 217
1125:                 .Height        = 2
1126:                 .FillColor     = RGB(150, 150, 150)
1127:                 .ForeColor     = RGB(150, 150, 150)
1128:                 .BackStyle     = 0
1129:                 .BorderStyle   = 1
1130:                 .SpecialEffect = 0
1131:                 .Visible       = .T.
1132:             ENDWITH
1133: 
1134:             *-- Endereco (Label17/Text19/lbl_4c_XEnd/Text20) top=229+29=258 / 244+29=273
1135:             loc_oPagina.AddObject("lbl_4c_LblEnd", "Label")
1136:             WITH loc_oPagina.lbl_4c_LblEnd
1137:                 .Caption   = "Endere" + CHR(231) + "o"
1138:                 .Top       = 258
1139:                 .Left      = 183
1140:                 .Width     = 47
1141:                 .Height    = 15
1142:                 .FontName  = "Tahoma"
1143:                 .FontSize  = 8
1144:                 .ForeColor = RGB(90, 90, 90)
1145:                 .BackStyle = 0
1146:                 .Visible   = .T.
1147:             ENDWITH
1148:             loc_oPagina.AddObject("txt_4c_Text19", "TextBox")
1149:             WITH loc_oPagina.txt_4c_Text19
1150:                 .Value    = 0
1151:                 .Top      = 273
1152:                 .Left     = 183
1153:                 .Width    = 41
1154:                 .Height   = 18
1155:                 .FontName = "Tahoma"
1156:                 .FontSize = 8
1157:                 .Visible  = .T.
1158:             ENDWITH
1159:             loc_oPagina.AddObject("lbl_4c_XEnd", "Label")
1160:             WITH loc_oPagina.lbl_4c_XEnd
1161:                 .Caption   = "x"
1162:                 .Top       = 275
1163:                 .Left      = 225
1164:                 .Width     = 8
1165:                 .Height    = 15
1166:                 .FontName  = "Tahoma"
1167:                 .FontSize  = 8
1168:                 .ForeColor = RGB(90, 90, 90)
1169:                 .BackStyle = 0
1170:                 .Visible   = .T.
1171:             ENDWITH
1172:             loc_oPagina.AddObject("txt_4c_Text20", "TextBox")
1173:             WITH loc_oPagina.txt_4c_Text20
1174:                 .Value    = 0
1175:                 .Top      = 273
1176:                 .Left     = 232
1177:                 .Width    = 41
1178:                 .Height   = 18
1179:                 .FontName = "Tahoma"
1180:                 .FontSize = 8
1181:                 .Visible  = .T.
1182:             ENDWITH
1183: 
1184:             *-- Bairro (Label19/Text21/Label20/Text22)
1185:             loc_oPagina.AddObject("lbl_4c_LblBairro", "Label")
1186:             WITH loc_oPagina.lbl_4c_LblBairro
1187:                 .Caption   = "Bairro"
1188:                 .Top       = 258
1189:                 .Left      = 293
1190:                 .Width     = 30
1191:                 .Height    = 15
1192:                 .FontName  = "Tahoma"
1193:                 .FontSize  = 8
1194:                 .ForeColor = RGB(90, 90, 90)
1195:                 .BackStyle = 0
1196:                 .Visible   = .T.
1197:             ENDWITH
1198:             loc_oPagina.AddObject("txt_4c_Text21", "TextBox")
1199:             WITH loc_oPagina.txt_4c_Text21
1200:                 .Value    = 0
1201:                 .Top      = 273
1202:                 .Left     = 293
1203:                 .Width    = 41
1204:                 .Height   = 18
1205:                 .FontName = "Tahoma"
1206:                 .FontSize = 8
1207:                 .Visible  = .T.
1208:             ENDWITH
1209:             loc_oPagina.AddObject("lbl_4c_XBairro", "Label")
1210:             WITH loc_oPagina.lbl_4c_XBairro
1211:                 .Caption   = "x"
1212:                 .Top       = 274
1213:                 .Left      = 335
1214:                 .Width     = 8
1215:                 .Height    = 15
1216:                 .FontName  = "Tahoma"
1217:                 .FontSize  = 8
1218:                 .ForeColor = RGB(90, 90, 90)
1219:                 .BackStyle = 0
1220:                 .Visible   = .T.
1221:             ENDWITH
1222:             loc_oPagina.AddObject("txt_4c_Text22", "TextBox")
1223:             WITH loc_oPagina.txt_4c_Text22
1224:                 .Value    = 0
1225:                 .Top      = 273
1226:                 .Left     = 342
1227:                 .Width    = 41
1228:                 .Height   = 18
1229:                 .FontName = "Tahoma"
1230:                 .FontSize = 8
1231:                 .Visible  = .T.
1232:             ENDWITH
1233: 
1234:             *-- C.E.P. (Label25/Text27/Label26/Text28)
1235:             loc_oPagina.AddObject("lbl_4c_LblCep", "Label")
1236:             WITH loc_oPagina.lbl_4c_LblCep
1237:                 .Caption   = "C.E.P."
1238:                 .Top       = 259
1239:                 .Left      = 403
1240:                 .Width     = 33
1241:                 .Height    = 15
1242:                 .FontName  = "Tahoma"
1243:                 .FontSize  = 8
1244:                 .ForeColor = RGB(90, 90, 90)
1245:                 .BackStyle = 0
1246:                 .Visible   = .T.
1247:             ENDWITH
1248:             loc_oPagina.AddObject("txt_4c_Text27", "TextBox")
1249:             WITH loc_oPagina.txt_4c_Text27
1250:                 .Value    = 0
1251:                 .Top      = 273
1252:                 .Left     = 403
1253:                 .Width    = 41
1254:                 .Height   = 18
1255:                 .FontName = "Tahoma"
1256:                 .FontSize = 8
1257:                 .Visible  = .T.
1258:             ENDWITH
1259:             loc_oPagina.AddObject("lbl_4c_XCep", "Label")
1260:             WITH loc_oPagina.lbl_4c_XCep
1261:                 .Caption   = "x"
1262:                 .Top       = 274
1263:                 .Left      = 445
1264:                 .Width     = 8
1265:                 .Height    = 15
1266:                 .FontName  = "Tahoma"
1267:                 .FontSize  = 8
1268:                 .ForeColor = RGB(90, 90, 90)
1269:                 .BackStyle = 0
1270:                 .Visible   = .T.
1271:             ENDWITH
1272:             loc_oPagina.AddObject("txt_4c_Text28", "TextBox")
1273:             WITH loc_oPagina.txt_4c_Text28
1274:                 .Value    = 0
1275:                 .Top      = 273
1276:                 .Left     = 452
1277:                 .Width    = 41
1278:                 .Height   = 18
1279:                 .FontName = "Tahoma"
1280:                 .FontSize = 8
1281:                 .Visible  = .T.
1282:             ENDWITH
1283: 
1284:             *-- Cidade (Label21/Text23/Label22/Text24)
1285:             loc_oPagina.AddObject("lbl_4c_LblCidade", "Label")
1286:             WITH loc_oPagina.lbl_4c_LblCidade
1287:                 .Caption   = "Cidade"
1288:                 .Top       = 259
1289:                 .Left      = 516
1290:                 .Width     = 35
1291:                 .Height    = 15
1292:                 .FontName  = "Tahoma"
1293:                 .FontSize  = 8
1294:                 .ForeColor = RGB(90, 90, 90)
1295:                 .BackStyle = 0
1296:                 .Visible   = .T.
1297:             ENDWITH
1298:             loc_oPagina.AddObject("txt_4c_Text23", "TextBox")
1299:             WITH loc_oPagina.txt_4c_Text23
1300:                 .Value    = 0
1301:                 .Top      = 273
1302:                 .Left     = 516
1303:                 .Width    = 41
1304:                 .Height   = 18
1305:                 .FontName = "Tahoma"
1306:                 .FontSize = 8
1307:                 .Visible  = .T.
1308:             ENDWITH
1309:             loc_oPagina.AddObject("lbl_4c_XCidade", "Label")
1310:             WITH loc_oPagina.lbl_4c_XCidade
1311:                 .Caption   = "x"
1312:                 .Top       = 274
1313:                 .Left      = 558
1314:                 .Width     = 8
1315:                 .Height    = 15
1316:                 .FontName  = "Tahoma"
1317:                 .FontSize  = 8
1318:                 .ForeColor = RGB(90, 90, 90)
1319:                 .BackStyle = 0
1320:                 .Visible   = .T.
1321:             ENDWITH
1322:             loc_oPagina.AddObject("txt_4c_Text24", "TextBox")
1323:             WITH loc_oPagina.txt_4c_Text24
1324:                 .Value    = 0
1325:                 .Top      = 273
1326:                 .Left     = 565
1327:                 .Width    = 41
1328:                 .Height   = 18
1329:                 .FontName = "Tahoma"
1330:                 .FontSize = 8
1331:                 .Visible  = .T.
1332:             ENDWITH
1333: 
1334:             *-- U.F. (Label23/Text25/Label24/Text26)
1335:             loc_oPagina.AddObject("lbl_4c_LblUF", "Label")
1336:             WITH loc_oPagina.lbl_4c_LblUF
1337:                 .Caption   = "U.F."
1338:                 .Top       = 259
1339:                 .Left      = 626
1340:                 .Width     = 23
1341:                 .Height    = 15
1342:                 .FontName  = "Tahoma"
1343:                 .FontSize  = 8
1344:                 .ForeColor = RGB(90, 90, 90)
1345:                 .BackStyle = 0
1346:                 .Visible   = .T.
1347:             ENDWITH
1348:             loc_oPagina.AddObject("txt_4c_Text25", "TextBox")
1349:             WITH loc_oPagina.txt_4c_Text25
1350:                 .Value    = 0
1351:                 .Top      = 273
1352:                 .Left     = 626
1353:                 .Width    = 41
1354:                 .Height   = 18
1355:                 .FontName = "Tahoma"
1356:                 .FontSize = 8
1357:                 .Visible  = .T.
1358:             ENDWITH
1359:             loc_oPagina.AddObject("lbl_4c_XUF", "Label")
1360:             WITH loc_oPagina.lbl_4c_XUF
1361:                 .Caption   = "x"
1362:                 .Top       = 274
1363:                 .Left      = 668
1364:                 .Width     = 8
1365:                 .Height    = 15
1366:                 .FontName  = "Tahoma"
1367:                 .FontSize  = 8
1368:                 .ForeColor = RGB(90, 90, 90)
1369:                 .BackStyle = 0
1370:                 .Visible   = .T.
1371:             ENDWITH
1372:             loc_oPagina.AddObject("txt_4c_Text26", "TextBox")
1373:             WITH loc_oPagina.txt_4c_Text26
1374:                 .Value    = 0
1375:                 .Top      = 273
1376:                 .Left     = 675
1377:                 .Width    = 41
1378:                 .Height   = 18
1379:                 .FontName = "Tahoma"
1380:                 .FontSize = 8
1381:                 .Visible  = .T.
1382:             ENDWITH
1383: 
1384:             *------------------------------------------------------------------
1385:             * SECAO OBSERVACAO
1386:             * Label44 (Observacao) top=273+29=302
1387:             *------------------------------------------------------------------
1388:             loc_oPagina.AddObject("lbl_4c_SecObs", "Label")
1389:             WITH loc_oPagina.lbl_4c_SecObs
1390:                 .Caption   = "Observa" + CHR(231) + CHR(227) + "o"
1391:                 .Top       = 302
1392:                 .Left      = 184
1393:                 .Width     = 69
1394:                 .Height    = 15
1395:                 .FontName  = "Tahoma"
1396:                 .FontSize  = 8
1397:                 .FontBold  = .T.
1398:                 .ForeColor = RGB(90, 90, 90)
1399:                 .BackStyle = 0
1400:                 .Visible   = .T.
1401:             ENDWITH
1402: 
1403:             *-- Obs linha/coluna (Text36/lbl_4c_XObs/Text37) top=292+29=321 / 304+29=333
1404:             loc_oPagina.AddObject("txt_4c_Text36", "TextBox")
1405:             WITH loc_oPagina.txt_4c_Text36
1406:                 .Value    = 0
1407:                 .Top      = 333
1408:                 .Left     = 184
1409:                 .Width    = 41
1410:                 .Height   = 18
1411:                 .FontName = "Tahoma"
1412:                 .FontSize = 8
1413:                 .Visible  = .T.
1414:             ENDWITH
1415:             loc_oPagina.AddObject("lbl_4c_XObs", "Label")
1416:             WITH loc_oPagina.lbl_4c_XObs
1417:                 .Caption   = "x"
1418:                 .Top       = 335
1419:                 .Left      = 227
1420:                 .Width     = 8
1421:                 .Height    = 15
1422:                 .FontName  = "Tahoma"
1423:                 .FontSize  = 8
1424:                 .ForeColor = RGB(90, 90, 90)
1425:                 .BackStyle = 0
1426:                 .Visible   = .T.
1427:             ENDWITH
1428:             loc_oPagina.AddObject("txt_4c_Text37", "TextBox")
1429:             WITH loc_oPagina.txt_4c_Text37
1430:                 .Value    = 0
1431:                 .Top      = 333
1432:                 .Left     = 233
1433:                 .Width    = 41
1434:                 .Height   = 18
1435:                 .FontName = "Tahoma"
1436:                 .FontSize = 8
1437:                 .Visible  = .T.
1438:             ENDWITH
1439: 
1440:             *-- N Colunas/N Linhas Obs (Label42/Text38/Label43/Text39) top=292+29=321 / 304+29=333
1441:             loc_oPagina.AddObject("lbl_4c_LblNcol", "Label")
1442:             WITH loc_oPagina.lbl_4c_LblNcol
1443:                 .Caption   = "N" + CHR(176) + " Colunas"
1444:                 .Top       = 321
1445:                 .Left      = 298
1446:                 .Width     = 55
1447:                 .Height    = 15
1448:                 .FontName  = "Tahoma"
1449:                 .FontSize  = 8
1450:                 .ForeColor = RGB(90, 90, 90)
1451:                 .BackStyle = 0
1452:                 .Visible   = .T.
1453:             ENDWITH
1454:             loc_oPagina.AddObject("txt_4c_Text38", "TextBox")
1455:             WITH loc_oPagina.txt_4c_Text38
1456:                 .Value    = 0
1457:                 .Top      = 333
1458:                 .Left     = 298
1459:                 .Width    = 41
1460:                 .Height   = 18
1461:                 .FontName = "Tahoma"
1462:                 .FontSize = 8
1463:                 .Visible  = .T.
1464:             ENDWITH
1465:             loc_oPagina.AddObject("lbl_4c_LblNlin", "Label")
1466:             WITH loc_oPagina.lbl_4c_LblNlin
1467:                 .Caption   = "N" + CHR(176) + " Linhas"
1468:                 .Top       = 321
1469:                 .Left      = 369
1470:                 .Width     = 47
1471:                 .Height    = 15
1472:                 .FontName  = "Tahoma"
1473:                 .FontSize  = 8
1474:                 .ForeColor = RGB(90, 90, 90)
1475:                 .BackStyle = 0
1476:                 .Visible   = .T.
1477:             ENDWITH
1478:             loc_oPagina.AddObject("txt_4c_Text39", "TextBox")
1479:             WITH loc_oPagina.txt_4c_Text39
1480:                 .Value    = 0
1481:                 .Top      = 333
1482:                 .Left     = 369
1483:                 .Width    = 41
1484:                 .Height   = 18
1485:                 .FontName = "Tahoma"
1486:                 .FontSize = 8
1487:                 .Visible  = .T.
1488:             ENDWITH
1489: 
1490:             *-- Valor da NF linha/coluna (Label38/Text34/Label39/Text35) top=291+29=320 / 306+29=335
1491:             loc_oPagina.AddObject("lbl_4c_LblVlNF", "Label")
1492:             WITH loc_oPagina.lbl_4c_LblVlNF
1493:                 .Caption   = "Valor da NF"
1494:                 .Top       = 320
1495:                 .Left      = 443
1496:                 .Width     = 57
1497:                 .Height    = 15
1498:                 .FontName  = "Tahoma"
1499:                 .FontSize  = 8
1500:                 .ForeColor = RGB(90, 90, 90)
1501:                 .BackStyle = 0
1502:                 .Visible   = .T.
1503:             ENDWITH
1504:             loc_oPagina.AddObject("txt_4c_Text34", "TextBox")
1505:             WITH loc_oPagina.txt_4c_Text34
1506:                 .Value    = 0
1507:                 .Top      = 335
1508:                 .Left     = 443
1509:                 .Width    = 41
1510:                 .Height   = 18
1511:                 .FontName = "Tahoma"
1512:                 .FontSize = 8
1513:                 .Visible  = .T.
1514:             ENDWITH
1515:             loc_oPagina.AddObject("lbl_4c_XVlNF", "Label")
1516:             WITH loc_oPagina.lbl_4c_XVlNF
1517:                 .Caption   = "x"
1518:                 .Top       = 336
1519:                 .Left      = 485
1520:                 .Width     = 8
1521:                 .Height    = 15
1522:                 .FontName  = "Tahoma"
1523:                 .FontSize  = 8
1524:                 .ForeColor = RGB(90, 90, 90)
1525:                 .BackStyle = 0
1526:                 .Visible   = .T.
1527:             ENDWITH
1528:             loc_oPagina.AddObject("txt_4c_Text35", "TextBox")
1529:             WITH loc_oPagina.txt_4c_Text35
1530:                 .Value    = 0
1531:                 .Top      = 335
1532:                 .Left     = 492
1533:                 .Width    = 41
1534:                 .Height   = 18
1535:                 .FontName = "Tahoma"
1536:                 .FontSize = 8
1537:                 .Visible  = .T.
1538:             ENDWITH
1539: 
1540:             *-- Codigo linha/coluna (Label45/Text41/Label46/Text42) top=291+29=320 / 306+29=335
1541:             loc_oPagina.AddObject("lbl_4c_LblCod", "Label")
1542:             WITH loc_oPagina.lbl_4c_LblCod
1543:                 .Caption   = "C" + CHR(243) + "digo"
1544:                 .Top       = 320
1545:                 .Left      = 556
1546:                 .Width     = 35
1547:                 .Height    = 15
1548:                 .FontName  = "Tahoma"
1549:                 .FontSize  = 8
1550:                 .ForeColor = RGB(90, 90, 90)
1551:                 .BackStyle = 0
1552:                 .Visible   = .T.
1553:             ENDWITH
1554:             loc_oPagina.AddObject("txt_4c_Text41", "TextBox")
1555:             WITH loc_oPagina.txt_4c_Text41
1556:                 .Value    = 0
1557:                 .Top      = 335
1558:                 .Left     = 556
1559:                 .Width    = 41
1560:                 .Height   = 18
1561:                 .FontName = "Tahoma"
1562:                 .FontSize = 8
1563:                 .Visible  = .T.
1564:             ENDWITH
1565:             loc_oPagina.AddObject("lbl_4c_XCod", "Label")
1566:             WITH loc_oPagina.lbl_4c_XCod
1567:                 .Caption   = "x"
1568:                 .Top       = 336
1569:                 .Left      = 598
1570:                 .Width     = 8
1571:                 .Height    = 15
1572:                 .FontName  = "Tahoma"
1573:                 .FontSize  = 8
1574:                 .ForeColor = RGB(90, 90, 90)
1575:                 .BackStyle = 0
1576:                 .Visible   = .T.
1577:             ENDWITH
1578:             loc_oPagina.AddObject("txt_4c_Text42", "TextBox")
1579:             WITH loc_oPagina.txt_4c_Text42
1580:                 .Value    = 0
1581:                 .Top      = 335
1582:                 .Left     = 605
1583:                 .Width    = 41
1584:                 .Height   = 18
1585:                 .FontName = "Tahoma"
1586:                 .FontSize = 8
1587:                 .Visible  = .T.
1588:             ENDWITH
1589: 
1590:             *-- Shape4: separador top=354+29=383
1591:             loc_oPagina.AddObject("shp_4c_Shape4", "Shape")
1592:             WITH loc_oPagina.shp_4c_Shape4
1593:                 .Top           = 383
1594:                 .Left          = 173
1595:                 .Width         = 263
1596:                 .Height        = 2
1597:                 .FillColor     = RGB(150, 150, 150)
1598:                 .ForeColor     = RGB(150, 150, 150)
1599:                 .BackStyle     = 0

*-- Linhas 1606 a 1792:
1606:             * SECAO IMPRESSORA / FONTE
1607:             * Label35 top=338+29=367
1608:             *------------------------------------------------------------------
1609:             loc_oPagina.AddObject("lbl_4c_SecImpr", "Label")
1610:             WITH loc_oPagina.lbl_4c_SecImpr
1611:                 .Caption   = "Impressora / Fonte"
1612:                 .Top       = 367
1613:                 .Left      = 183
1614:                 .Width     = 112
1615:                 .Height    = 15
1616:                 .FontName  = "Tahoma"
1617:                 .FontSize  = 8
1618:                 .FontBold  = .T.
1619:                 .ForeColor = RGB(90, 90, 90)
1620:                 .BackStyle = 0
1621:                 .Visible   = .T.
1622:             ENDWITH
1623: 
1624:             *-- Nome da Impressora (Label32/Text29) top=359+29=388 / 373+29=402
1625:             loc_oPagina.AddObject("lbl_4c_LblNomeImp", "Label")
1626:             WITH loc_oPagina.lbl_4c_LblNomeImp
1627:                 .Caption   = "Nome da Impressora"
1628:                 .Top       = 388
1629:                 .Left      = 183
1630:                 .Width     = 101
1631:                 .Height    = 15
1632:                 .FontName  = "Tahoma"
1633:                 .FontSize  = 8
1634:                 .ForeColor = RGB(90, 90, 90)
1635:                 .BackStyle = 0
1636:                 .Visible   = .T.
1637:             ENDWITH
1638:             loc_oPagina.AddObject("txt_4c_Text29", "TextBox")
1639:             WITH loc_oPagina.txt_4c_Text29
1640:                 .Value    = ""
1641:                 .Top      = 402
1642:                 .Left     = 183
1643:                 .Width    = 240
1644:                 .Height   = 18
1645:                 .FontName = "Tahoma"
1646:                 .FontSize = 8
1647:                 .Visible  = .T.
1648:             ENDWITH
1649: 
1650:             *-- Fonte Padrao (Label33/Text30) top=392+29=421 / 406+29=435
1651:             loc_oPagina.AddObject("lbl_4c_LblFonte", "Label")
1652:             WITH loc_oPagina.lbl_4c_LblFonte
1653:                 .Caption   = "Fonte Padr" + CHR(227) + "o"
1654:                 .Top       = 421
1655:                 .Left      = 183
1656:                 .Width     = 67
1657:                 .Height    = 15
1658:                 .FontName  = "Tahoma"
1659:                 .FontSize  = 8
1660:                 .ForeColor = RGB(90, 90, 90)
1661:                 .BackStyle = 0
1662:                 .Visible   = .T.
1663:             ENDWITH
1664:             loc_oPagina.AddObject("txt_4c_Text30", "TextBox")
1665:             WITH loc_oPagina.txt_4c_Text30
1666:                 .Value    = ""
1667:                 .Top      = 435
1668:                 .Left     = 183
1669:                 .Width    = 192
1670:                 .Height   = 18
1671:                 .FontName = "Tahoma"
1672:                 .FontSize = 8
1673:                 .Visible  = .T.
1674:             ENDWITH
1675: 
1676:             *-- Tamanho da Fonte (Label34/Text31) top=392+29=421 / 406+29=435
1677:             loc_oPagina.AddObject("lbl_4c_LblTamFonte", "Label")
1678:             WITH loc_oPagina.lbl_4c_LblTamFonte
1679:                 .Caption   = "Tamanho"
1680:                 .Top       = 421
1681:                 .Left      = 384
1682:                 .Width     = 46
1683:                 .Height    = 15
1684:                 .FontName  = "Tahoma"
1685:                 .FontSize  = 8
1686:                 .ForeColor = RGB(90, 90, 90)
1687:                 .BackStyle = 0
1688:                 .Visible   = .T.
1689:             ENDWITH
1690:             loc_oPagina.AddObject("txt_4c_Text31", "TextBox")
1691:             WITH loc_oPagina.txt_4c_Text31
1692:                 .Value    = 0
1693:                 .Top      = 435
1694:                 .Left     = 384
1695:                 .Width    = 41
1696:                 .Height   = 18
1697:                 .FontName = "Tahoma"
1698:                 .FontSize = 8
1699:                 .Visible  = .T.
1700:             ENDWITH
1701: 
1702:             *-- Tamanho da Folha (Label47/Text40) top=424+29=453 / 439+29=468
1703:             loc_oPagina.AddObject("lbl_4c_LblTamFolha", "Label")
1704:             WITH loc_oPagina.lbl_4c_LblTamFolha
1705:                 .Caption   = "Tamanho da Folha"
1706:                 .Top       = 453
1707:                 .Left      = 183
1708:                 .Width     = 90
1709:                 .Height    = 15
1710:                 .FontName  = "Tahoma"
1711:                 .FontSize  = 8
1712:                 .ForeColor = RGB(90, 90, 90)
1713:                 .BackStyle = 0
1714:                 .Visible   = .T.
1715:             ENDWITH
1716:             loc_oPagina.AddObject("txt_4c_Text40", "TextBox")
1717:             WITH loc_oPagina.txt_4c_Text40
1718:                 .Value    = ""
1719:                 .Top      = 468
1720:                 .Left     = 183
1721:                 .Width    = 240
1722:                 .Height   = 18
1723:                 .FontName = "Tahoma"
1724:                 .FontSize = 8
1725:                 .Visible  = .T.
1726:             ENDWITH
1727: 
1728:             *------------------------------------------------------------------
1729:             * BOTOES DE ACAO (Confirmar / Cancelar) - Grupo_Salva no legado
1730:             *-- Top=33 = 4 (original) + 29 (compensacao PageFrame)
1731:             loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
1732:             WITH loc_oPagina.cnt_4c_BotoesAcao
1733:                 .Top         = 33
1734:                 .Left        = 842
1735:                 .Width       = 160
1736:                 .Height      = 85
1737:                 .BackStyle   = 0
1738:                 .BorderWidth = 0
1739:                 .Visible     = .T.
1740: 
1741:                 .AddObject("cmd_4c_Confirmar", "CommandButton")
1742:                 WITH .cmd_4c_Confirmar
1743:                     .Caption         = "Confirmar"
1744:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
1745:                     .PicturePosition = 13
1746:                     .Top             = 5
1747:                     .Left            = 5
1748:                     .Width           = 75
1749:                     .Height          = 75
1750:                     .FontName        = "Comic Sans MS"
1751:                     .FontSize        = 8
1752:                     .FontBold        = .T.
1753:                     .FontItalic      = .T.
1754:                     .ForeColor       = RGB(90, 90, 90)
1755:                     .BackColor       = RGB(255, 255, 255)
1756:                     .SpecialEffect   = 0
1757:                     .MousePointer    = 15
1758:                     .WordWrap        = .T.
1759:                     .AutoSize        = .F.
1760:                 ENDWITH
1761: 
1762:                 .AddObject("cmd_4c_Cancelar", "CommandButton")
1763:                 WITH .cmd_4c_Cancelar
1764:                     .Caption         = "Encerrar"
1765:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
1766:                     .PicturePosition = 13
1767:                     .Top             = 5
1768:                     .Left            = 80
1769:                     .Width           = 75
1770:                     .Height          = 75
1771:                     .FontName        = "Comic Sans MS"
1772:                     .FontSize        = 8
1773:                     .FontBold        = .T.
1774:                     .FontItalic      = .T.
1775:                     .ForeColor       = RGB(90, 90, 90)
1776:                     .BackColor       = RGB(255, 255, 255)
1777:                     .Themes          = .F.
1778:                     .SpecialEffect   = 0
1779:                     .MousePointer    = 15
1780:                     .WordWrap        = .T.
1781:                     .AutoSize        = .F.
1782:                 ENDWITH
1783:             ENDWITH
1784: 
1785:             *-- BINDEVENTs da Page2
1786:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
1787:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
1788: 
1789:             THIS.TornarControlesVisiveis(loc_oPagina)
1790: 
1791:         CATCH TO loException
1792:             MsgErro("Erro ao configurar Page2:" + CHR(13) + loException.Message, "Erro")

*-- Linhas 1812 a 1820:
1812:                     loc_oGrid.RecordSource              = "cursor_4c_Dados"
1813:                     loc_oGrid.Column1.ControlSource     = "cursor_4c_Dados.series"
1814:                     loc_oGrid.Column1.Width             = 100
1815:                     loc_oGrid.Column1.Header1.Caption   = "S" + CHR(233) + "rie"
1816:                     THIS.FormatarGridLista(loc_oGrid)
1817:                     loc_lResultado = .T.
1818:                 ENDIF
1819:             CATCH TO loException
1820:                 MsgErro("Erro ao carregar lista:" + CHR(13) + loException.Message, "Erro")

*-- Linhas 1860 a 1869:
1860:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Series", 5)
1861:             THIS.pgf_4c_Paginas.Page2.txt_4c_Series.SetFocus
1862:         ELSE
1863:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1864:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
1865:             ENDIF
1866:         ENDIF
1867:     ENDPROC
1868: 
1869:     *==========================================================================

*-- Linhas 1887 a 1896:
1887:             THIS.this_cModoAtual = "VISUALIZAR"
1888:             THIS.BOParaForm()
1889:             THIS.pgf_4c_Paginas.ActivePage = 2
1890:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1891:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
1892:             ENDIF
1893:         ENDIF
1894:     ENDPROC
1895: 
1896:     *==========================================================================

*-- Linhas 1918 a 1927:
1918:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Text5", 5)
1919:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Text5.SetFocus
1920:             ELSE
1921:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1922:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
1923:                 ENDIF
1924:             ENDIF
1925:         ENDIF
1926:     ENDPROC
1927: 

*-- Linhas 1966 a 1975:
1966:             THIS.pgf_4c_Paginas.Page2.txt_4c_Series.Value = ""
1967:             THIS.pgf_4c_Paginas.Page2.txt_4c_Series.SetFocus
1968:         ELSE
1969:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1970:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
1971:             ENDIF
1972:         ENDIF
1973:     ENDPROC
1974: 
1975:     *==========================================================================

*-- Linhas 1995 a 2003:
1995:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.ColumnCount = 1
1996:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.RecordSource            = "cursor_4c_Dados"
1997:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.ControlSource   = "cursor_4c_Dados.series"
1998:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.Header1.Caption = "S" + CHR(233) + "rie"
1999:                 THIS.FormatarGridLista(THIS.pgf_4c_Paginas.Page1.grd_4c_Lista)
2000:                 THIS.this_cModoAtual = "LISTA"
2001:                 THIS.pgf_4c_Paginas.Visible = .T.
2002:                 THIS.pgf_4c_Paginas.ActivePage = 1
2003:             ENDIF

*-- Linhas 2049 a 2069:
2049: 
2050:         *-- Desabilitar controles durante a copia (como no legado)
2051:         loc_oPg1.cnt_4c_Botoes.Enabled = .F.
2052:         loc_oPg1.grd_4c_Lista.Enabled  = .F.
2053:         loc_oPg1.cnt_4c_Saida.Enabled  = .F.
2054:         loc_oPg1.cmd_4c_Copia.Enabled  = .F.
2055: 
2056:         *-- Preencher e exibir painel
2057:         loc_oPg1.cnt_4c_CopiaFl.txt_4c_SeriesOrigem.Value  = loc_cSeries
2058:         loc_oPg1.cnt_4c_CopiaFl.txt_4c_SerieDestino.Value  = ""
2059:         loc_oPg1.cnt_4c_CopiaFl.Visible                    = .T.
2060:         loc_oPg1.cnt_4c_CopiaFl.txt_4c_SerieDestino.SetFocus
2061:     ENDPROC
2062: 
2063:     *==========================================================================
2064:     * BtnOKCopiarClick - Executa copia da serie
2065:     * Logica baseada no legado: SIGCDDUP.Pagina.Lista.cntcopia.OK.Click
2066:     *==========================================================================
2067:     PROCEDURE BtnOKCopiarClick()
2068:         LOCAL loc_oPg1, loc_cSerieOrigem, loc_cSerieDestino
2069:         LOCAL loc_cSQLCheck, loc_nCheck, loc_lResultado

*-- Linhas 2117 a 2137:
2117:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
2118: 
2119:         loc_oPg1.cnt_4c_Botoes.Enabled = .T.
2120:         loc_oPg1.grd_4c_Lista.Enabled  = .T.
2121:         loc_oPg1.cnt_4c_Saida.Enabled  = .T.
2122:         loc_oPg1.cmd_4c_Copia.Enabled  = .T.
2123:         loc_oPg1.cnt_4c_CopiaFl.Visible = .F.
2124:         loc_oPg1.grd_4c_Lista.SetFocus
2125:     ENDPROC
2126: 
2127:     *==========================================================================
2128:     * ValidarSerieDestino - Abre lookup de series ao sair do campo destino
2129:     * Baseado no legado: SIGCDDUP.Pagina.Lista.cntcopia.nomedest.Valid
2130:     * Tabela SigCdSer (series disponiveis)
2131:     *==========================================================================
2132:     PROCEDURE ValidarSerieDestino
2133:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
2134:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
2135:             RETURN
2136:         ENDIF
2137:         LOCAL loc_oPg1, loc_cSerieDest, loc_oBusca

*-- Linhas 2809 a 2834:
2809:             RETURN
2810:         ENDIF
2811: 
2812:         loc_oBtnConf = loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar
2813:         loc_oBtnCanc = loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar
2814: 
2815:         DO CASE
2816:         CASE THIS.this_cModoAtual = "VISUALIZAR"
2817:             loc_oBtnConf.Caption = "OK"
2818:             loc_oBtnConf.Enabled = .T.
2819:             loc_oBtnCanc.Enabled = .T.
2820:         CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2821:             loc_oBtnConf.Caption = "Confirmar"
2822:             loc_oBtnConf.Enabled = .T.
2823:             loc_oBtnCanc.Enabled = .T.
2824:         CASE THIS.this_cModoAtual = "BUSCAR"
2825:             loc_oBtnConf.Caption = "Buscar"
2826:             loc_oBtnConf.Enabled = .T.
2827:             loc_oBtnCanc.Enabled = .T.
2828:         OTHERWISE
2829:             loc_oBtnConf.Caption = "Confirmar"
2830:             loc_oBtnConf.Enabled = .T.
2831:             loc_oBtnCanc.Enabled = .T.
2832:         ENDCASE
2833:     ENDPROC
2834: 


### BO (C:\4c\projeto\app\classes\DupBO.prg):
*==============================================================================
* DupBO.prg - Business Object para Configuracao de Duplicatas
* Tabela: SigCnFDU
* PK: series
* Fase 1/8: Propriedades e Init()
*==============================================================================

DEFINE CLASS DupBO AS BusinessBase

    *-- Chave primaria
    this_cSeries = ""

    *-- Cabecalho - posicoes de impressao da Nota Fiscal
    this_nNlnNotas   = 0
    this_nNclNotas   = 0
    this_nNlnDtVencs = 0
    this_nNclDtVencs = 0
    this_nNlnDtDocs  = 0
    this_nNclDtDocs  = 0
    this_nNlnNrDocs  = 0
    this_nNclNrDocs  = 0
    this_nNlnVlDocs  = 0
    this_nNclVlDocs  = 0

    *-- Sacado - posicoes de impressao do cliente/cobranca
    this_nNlnRazClis = 0
    this_nNclRazClis = 0
    this_nNlnCgcClis = 0
    this_nNclCgcClis = 0
    this_nNlnEndCobs = 0
    this_nNclEndCobs = 0
    this_nNlnBaiCobs = 0
    this_nNclBaiCobs = 0
    this_nNlnCidCobs = 0
    this_nNclCidCobs = 0
    this_nNlnEstCobs = 0
    this_nNclEstCobs = 0
    this_nNlnCepCobs = 0
    this_nNclCepCobs = 0
    this_nNlnEstClis = 0
    this_nNclEstClis = 0
    this_nNlnExtens  = 0
    this_nNclExtens  = 0
    this_nNlPracas   = 0
    this_nNcPracas   = 0

    *-- Observacao - posicoes e dimensoes
    this_nNlObs     = 0
    this_nNcObs     = 0
    this_nTamColObs = 0
    this_nTamLinObs = 0

    *-- Codigo - posicao de impressao
    this_nNlnCods   = 0
    this_nNclCods   = 0

    *-- Valor NF - posicao de impressao
    this_nLNota     = 0
    this_nCNota     = 0

    *-- Impressora e fonte
    this_cNomeImps  = ""
    this_cFontePdrs = ""
    this_nTamFontes = 0
    this_cTamFolhas = ""

    *-- Auditoria
    this_dDatas    = {}
    this_cHoras    = ""
    this_cUsuarios = ""

    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCnFDU"
        THIS.this_cCampoChave = "series"
        RETURN .T.
    ENDPROC

    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cSeries
    ENDFUNC

    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT series FROM SigCnFDU"
            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE series LIKE " + EscaparSQL(par_cFiltro + "%")
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY series"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar registros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    FUNCTION CarregarPorCodigo(par_cSeries)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT * FROM SigCnFDU WHERE series = " + EscaparSQL(par_cSeries)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cSeries      = ALLTRIM(TratarNulo(series,      "C"))
            THIS.this_nNlnNotas    = TratarNulo(nlnnotas,    "N")
            THIS.this_nNclNotas    = TratarNulo(nclnotas,    "N")
            THIS.this_nNlnDtVencs  = TratarNulo(nlndtvencs,  "N")
            THIS.this_nNclDtVencs  = TratarNulo(ncldtvencs,  "N")
            THIS.this_nNlnDtDocs   = TratarNulo(nlndtdocs,   "N")
            THIS.this_nNclDtDocs   = TratarNulo(ncldtdocs,   "N")
            THIS.this_nNlnNrDocs   = TratarNulo(nlnnrdocs,   "N")
            THIS.this_nNclNrDocs   = TratarNulo(nclnrdocs,   "N")
            THIS.this_nNlnVlDocs   = TratarNulo(nlnvldocs,   "N")
            THIS.this_nNclVlDocs   = TratarNulo(nclvldocs,   "N")
            THIS.this_nNlnRazClis  = TratarNulo(nlnrazclis,  "N")
            THIS.this_nNclRazClis  = TratarNulo(nclrazclis,  "N")
            THIS.this_nNlnCgcClis  = TratarNulo(nlncgcclis,  "N")
            THIS.this_nNclCgcClis  = TratarNulo(nclcgcclis,  "N")
            THIS.this_nNlnEndCobs  = TratarNulo(nlnendcobs,  "N")
            THIS.this_nNclEndCobs  = TratarNulo(nclendcobs,  "N")
            THIS.this_nNlnBaiCobs  = TratarNulo(nlnbaicobs,  "N")
            THIS.this_nNclBaiCobs  = TratarNulo(nclbaicobs,  "N")
            THIS.this_nNlnCidCobs  = TratarNulo(nlncidcobs,  "N")
            THIS.this_nNclCidCobs  = TratarNulo(nclcidcobs,  "N")
            THIS.this_nNlnEstCobs  = TratarNulo(nlnestcobs,  "N")
            THIS.this_nNclEstCobs  = TratarNulo(nclestcobs,  "N")
            THIS.this_nNlnCepCobs  = TratarNulo(nlncepcobs,  "N")
            THIS.this_nNclCepCobs  = TratarNulo(nclcepcobs,  "N")
            THIS.this_nNlnEstClis  = TratarNulo(nlnestclis,  "N")
            THIS.this_nNclEstClis  = TratarNulo(nclestclis,  "N")
            THIS.this_nNlnExtens   = TratarNulo(nlnextens,   "N")
            THIS.this_nNclExtens   = TratarNulo(nclextens,   "N")
            THIS.this_nNlPracas    = TratarNulo(nlpracas,    "N")
            THIS.this_nNcPracas    = TratarNulo(ncpracas,    "N")
            THIS.this_nNlObs       = TratarNulo(nlobs,       "N")
            THIS.this_nNcObs       = TratarNulo(ncobs,       "N")
            THIS.this_nTamColObs   = TratarNulo(tamcolobs,   "N")
            THIS.this_nTamLinObs   = TratarNulo(tamlinobs,   "N")
            THIS.this_nNlnCods     = TratarNulo(nlncods,     "N")
            THIS.this_nNclCods     = TratarNulo(nclcods,     "N")
            THIS.this_nLNota       = TratarNulo(lnota,       "N")
            THIS.this_nCNota       = TratarNulo(cnota,       "N")
            THIS.this_cNomeImps    = ALLTRIM(TratarNulo(cnomeimps,    "C"))
            THIS.this_cFontePdrs   = ALLTRIM(TratarNulo(cfontepdrs,   "C"))
            THIS.this_nTamFontes   = TratarNulo(ntamfontes,   "N")
            THIS.this_cTamFolhas   = ALLTRIM(TratarNulo(ctamfolhas,   "C"))
            THIS.this_cHoras       = ALLTRIM(TratarNulo(choras,       "C"))
            THIS.this_cUsuarios    = ALLTRIM(TratarNulo(cusuarios,    "C"))
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCnFDU (" + ;
                "series, cemps, cnomeimps, cfontepdrs, ntamfontes, ctamfolhas," + ;
                " cusuarios, ddatas, choras, clocals," + ;
                " nlnnotas, nclnotas, nlndtvencs, ncldtvencs," + ;
                " nlndtdocs, ncldtdocs, nlnnrdocs, nclnrdocs," + ;
                " nlnvldocs, nclvldocs, nlnrazclis, nclrazclis," + ;
                " nlncgcclis, nclcgcclis, nlnendcobs, nclendcobs," + ;
                " nlnbaicobs, nclbaicobs, nlncidcobs, nclcidcobs," + ;
                " nlnestcobs, nclestcobs, nlncepcobs, nclcepcobs," + ;
                " nlnestclis, nclestclis, nlnextens, nclextens," + ;
                " nlpracas, ncpracas, nlobs, ncobs," + ;
                " tamcolobs, tamlinobs, nlncods, nclcods, lnota, cnota" + ;
                ") VALUES (" + ;
                EscaparSQL(THIS.this_cSeries) + ", " + ;
                EscaparSQL(go_4c_Sistema.cCodEmpresa) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cNomeImps,  128)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cFontePdrs, 128)) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTamFontes) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTamFolhas,  80)) + ", " + ;
                EscaparSQL(LEFT(gc_4c_UsuarioLogado,   20)) + ", " + ;
                "GETDATE(), " + ;
                EscaparSQL(TIME()) + ", " + ;
                EscaparSQL("") + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnNotas)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclNotas)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnDtVencs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclDtVencs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnDtDocs)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclDtDocs)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnNrDocs)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclNrDocs)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnVlDocs)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclVlDocs)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnRazClis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclRazClis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnCgcClis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclCgcClis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnEndCobs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclEndCobs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnBaiCobs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclBaiCobs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnCidCobs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclCidCobs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnEstCobs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclEstCobs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnCepCobs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclCepCobs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnEstClis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclEstClis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnExtens)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclExtens)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlPracas)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nNcPracas)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlObs)      + ", " + ;
                FormatarNumeroSQL(THIS.this_nNcObs)      + ", " + ;
                FormatarNumeroSQL(THIS.this_nTamColObs)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nTamLinObs)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnCods)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclCods)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nLNota)      + ", " + ;
                FormatarNumeroSQL(THIS.this_nCNota)      + ;
                ")"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Insert")
                TABLEREVERT(.T., "cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
            IF USED("cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCnFDU SET " + ;
                "cnomeimps  = " + EscaparSQL(LEFT(THIS.this_cNomeImps,  128)) + ", " + ;
                "cfontepdrs = " + EscaparSQL(LEFT(THIS.this_cFontePdrs, 128)) + ", " + ;
                "ntamfontes = " + FormatarNumeroSQL(THIS.this_nTamFontes) + ", " + ;
                "ctamfolhas = " + EscaparSQL(LEFT(THIS.this_cTamFolhas,  80)) + ", " + ;
                "cusuarios  = " + EscaparSQL(LEFT(gc_4c_UsuarioLogado,   20)) + ", " + ;
                "ddatas = GETDATE(), " + ;
                "choras = " + EscaparSQL(TIME()) + ", " + ;
                "nlnnotas   = " + FormatarNumeroSQL(THIS.this_nNlnNotas)   + ", " + ;
                "nclnotas   = " + FormatarNumeroSQL(THIS.this_nNclNotas)   + ", " + ;
                "nlndtvencs = " + FormatarNumeroSQL(THIS.this_nNlnDtVencs) + ", " + ;
                "ncldtvencs = " + FormatarNumeroSQL(THIS.this_nNclDtVencs) + ", " + ;
                "nlndtdocs  = " + FormatarNumeroSQL(THIS.this_nNlnDtDocs)  + ", " + ;
                "ncldtdocs  = " + FormatarNumeroSQL(THIS.this_nNclDtDocs)  + ", " + ;
                "nlnnrdocs  = " + FormatarNumeroSQL(THIS.this_nNlnNrDocs)  + ", " + ;
                "nclnrdocs  = " + FormatarNumeroSQL(THIS.this_nNclNrDocs)  + ", " + ;
                "nlnvldocs  = " + FormatarNumeroSQL(THIS.this_nNlnVlDocs)  + ", " + ;
                "nclvldocs  = " + FormatarNumeroSQL(THIS.this_nNclVlDocs)  + ", " + ;
                "nlnrazclis = " + FormatarNumeroSQL(THIS.this_nNlnRazClis) + ", " + ;
                "nclrazclis = " + FormatarNumeroSQL(THIS.this_nNclRazClis) + ", " + ;
                "nlncgcclis = " + FormatarNumeroSQL(THIS.this_nNlnCgcClis) + ", " + ;
                "nclcgcclis = " + FormatarNumeroSQL(THIS.this_nNclCgcClis) + ", " + ;
                "nlnendcobs = " + FormatarNumeroSQL(THIS.this_nNlnEndCobs) + ", " + ;
                "nclendcobs = " + FormatarNumeroSQL(THIS.this_nNclEndCobs) + ", " + ;
                "nlnbaicobs = " + FormatarNumeroSQL(THIS.this_nNlnBaiCobs) + ", " + ;
                "nclbaicobs = " + FormatarNumeroSQL(THIS.this_nNclBaiCobs) + ", " + ;
                "nlncidcobs = " + FormatarNumeroSQL(THIS.this_nNlnCidCobs) + ", " + ;
                "nclcidcobs = " + FormatarNumeroSQL(THIS.this_nNclCidCobs) + ", " + ;
                "nlnestcobs = " + FormatarNumeroSQL(THIS.this_nNlnEstCobs) + ", " + ;
                "nclestcobs = " + FormatarNumeroSQL(THIS.this_nNclEstCobs) + ", " + ;
                "nlncepcobs = " + FormatarNumeroSQL(THIS.this_nNlnCepCobs) + ", " + ;
                "nclcepcobs = " + FormatarNumeroSQL(THIS.this_nNclCepCobs) + ", " + ;
                "nlnestclis = " + FormatarNumeroSQL(THIS.this_nNlnEstClis) + ", " + ;
                "nclestclis = " + FormatarNumeroSQL(THIS.this_nNclEstClis) + ", " + ;
                "nlnextens  = " + FormatarNumeroSQL(THIS.this_nNlnExtens)  + ", " + ;
                "nclextens  = " + FormatarNumeroSQL(THIS.this_nNclExtens)  + ", " + ;
                "nlpracas   = " + FormatarNumeroSQL(THIS.this_nNlPracas)   + ", " + ;
                "ncpracas   = " + FormatarNumeroSQL(THIS.this_nNcPracas)   + ", " + ;
                "nlobs      = " + FormatarNumeroSQL(THIS.this_nNlObs)      + ", " + ;
                "ncobs      = " + FormatarNumeroSQL(THIS.this_nNcObs)      + ", " + ;
                "tamcolobs  = " + FormatarNumeroSQL(THIS.this_nTamColObs)  + ", " + ;
                "tamlinobs  = " + FormatarNumeroSQL(THIS.this_nTamLinObs)  + ", " + ;
                "nlncods    = " + FormatarNumeroSQL(THIS.this_nNlnCods)    + ", " + ;
                "nclcods    = " + FormatarNumeroSQL(THIS.this_nNclCods)    + ", " + ;
                "lnota      = " + FormatarNumeroSQL(THIS.this_nLNota)      + ", " + ;
                "cnota      = " + FormatarNumeroSQL(THIS.this_nCNota)      + ;
                " WHERE series = " + EscaparSQL(THIS.this_cSeries)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Update")
                TABLEREVERT(.T., "cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCnFDU WHERE series = " + EscaparSQL(THIS.this_cSeries)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Delete")
                TABLEREVERT(.T., "cursor_4c_Delete")
                USE IN cursor_4c_Delete
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Delete")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
            IF USED("cursor_4c_Delete")
                USE IN cursor_4c_Delete
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Delete")
                USE IN cursor_4c_Delete
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE

