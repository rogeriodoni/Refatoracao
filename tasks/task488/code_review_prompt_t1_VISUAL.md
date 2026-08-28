# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 180: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 205: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 230: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 255: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 280: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 317: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 420: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 444: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormOpt.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (4619 linhas total):

*-- Linhas 81 a 98:
81: 
82:         WITH THIS.pgf_4c_Paginas
83:             .PageCount       = 2
84:             .Top             = -29
85:             .Left            = 0
86:             .Width           = THIS.Width
87:             .Height          = THIS.Height + 29
88:             .Tabs            = .F.
89:             .Visible         = .T.
90:             .Page1.Caption   = "Lista"
91:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
92:             .Page1.BackColor = RGB(255, 255, 255)
93:             .Page2.Caption   = "Dados"
94:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
95:             .Page2.BackColor = RGB(255, 255, 255)
96:         ENDWITH
97: 
98:         THIS.ConfigurarPaginaLista()

*-- Linhas 112 a 149:
112:         *-- Container Cabecalho (cntSombra no legado: top=2+29=31)
113:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
114:         WITH loc_oPagina.cnt_4c_Cabecalho
115:             .Top         = 31
116:             .Left        = 0
117:             .Width       = THIS.Width
118:             .Height      = 80
119:             .BackColor   = RGB(100, 100, 100)
120:             .BorderWidth = 0
121:             .Visible     = .T.
122:         ENDWITH
123: 
124:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
125:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
126:             .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es de Cheques"
127:             .Top       = 15
128:             .Left      = 10
129:             .Width     = THIS.Width - 20
130:             .Height    = 40
131:             .FontName  = "Tahoma"
132:             .FontSize  = 16
133:             .FontBold  = .T.
134:             .ForeColor = RGB(0, 0, 0)
135:             .BackStyle = 0
136:             .AutoSize  = .F.
137:             .Visible   = .T.
138:         ENDWITH
139: 
140:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
141:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
142:             .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es de Cheques"
143:             .Top       = 18
144:             .Left      = 10
145:             .Width     = THIS.Width - 20
146:             .Height    = 46
147:             .FontName  = "Tahoma"
148:             .FontSize  = 16
149:             .FontBold  = .T.

*-- Linhas 156 a 344:
156:         *-- Container Botoes CRUD (Grupo_op: top=0+29=29, left=542)
157:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
158:         WITH loc_oPagina.cnt_4c_Botoes
159:             .Top         = 29
160:             .Left        = 542
161:             .Width       = 385
162:             .Height      = 85
163:             .BackStyle   = 0
164:             .BorderWidth = 0
165:             .Visible     = .T.
166:         ENDWITH
167: 
168:         *-- Botao Incluir
169:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
170:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
171:             .Caption         = "Incluir"
172:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
173:             .PicturePosition = 13
174:             .Top             = 5
175:             .Left            = 5
176:             .Width           = 75
177:             .Height          = 75
178:             .BackColor       = RGB(255, 255, 255)
179:             .ForeColor       = RGB(90, 90, 90)
180:             .FontName        = "Comic Sans MS"
181:             .FontSize        = 8
182:             .FontBold        = .T.
183:             .FontItalic      = .T.
184:             .Themes          = .F.
185:             .SpecialEffect   = 0
186:             .MousePointer    = 15
187:             .WordWrap        = .T.
188:             .AutoSize        = .F.
189:             .Visible         = .T.
190:         ENDWITH
191:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
192: 
193:         *-- Botao Visualizar
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
216:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
217: 
218:         *-- Botao Alterar
219:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
220:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
221:             .Caption         = "Alterar"
222:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
223:             .PicturePosition = 13
224:             .Top             = 5
225:             .Left            = 155
226:             .Width           = 75
227:             .Height          = 75
228:             .BackColor       = RGB(255, 255, 255)
229:             .ForeColor       = RGB(90, 90, 90)
230:             .FontName        = "Comic Sans MS"
231:             .FontSize        = 8
232:             .FontBold        = .T.
233:             .FontItalic      = .T.
234:             .Themes          = .F.
235:             .SpecialEffect   = 0
236:             .MousePointer    = 15
237:             .WordWrap        = .T.
238:             .AutoSize        = .F.
239:             .Visible         = .T.
240:         ENDWITH
241:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
242: 
243:         *-- Botao Excluir
244:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
245:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
246:             .Caption         = "Excluir"
247:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
248:             .PicturePosition = 13
249:             .Top             = 5
250:             .Left            = 230
251:             .Width           = 75
252:             .Height          = 75
253:             .BackColor       = RGB(255, 255, 255)
254:             .ForeColor       = RGB(90, 90, 90)
255:             .FontName        = "Comic Sans MS"
256:             .FontSize        = 8
257:             .FontBold        = .T.
258:             .FontItalic      = .T.
259:             .Themes          = .F.
260:             .SpecialEffect   = 0
261:             .MousePointer    = 15
262:             .WordWrap        = .T.
263:             .AutoSize        = .F.
264:             .Visible         = .T.
265:         ENDWITH
266:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
267: 
268:         *-- Botao Buscar
269:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
270:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
271:             .Caption         = "Buscar"
272:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
273:             .PicturePosition = 13
274:             .Top             = 5
275:             .Left            = 305
276:             .Width           = 75
277:             .Height          = 75
278:             .BackColor       = RGB(255, 255, 255)
279:             .ForeColor       = RGB(90, 90, 90)
280:             .FontName        = "Comic Sans MS"
281:             .FontSize        = 8
282:             .FontBold        = .T.
283:             .FontItalic      = .T.
284:             .Themes          = .F.
285:             .SpecialEffect   = 0
286:             .MousePointer    = 15
287:             .WordWrap        = .T.
288:             .AutoSize        = .F.
289:             .Visible         = .T.
290:         ENDWITH
291:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
292: 
293:         *-- Container Saida (padrao canonico: Left=917, Width=90, cmd Width=75)
294:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
295:         WITH loc_oPagina.cnt_4c_Saida
296:             .Top         = 29
297:             .Left        = 917
298:             .Width       = 90
299:             .Height      = 85
300:             .BackStyle   = 0
301:             .BorderWidth = 0
302:             .Visible     = .T.
303:         ENDWITH
304: 
305:         *-- Botao Encerrar
306:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
307:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
308:             .Caption         = "Encerrar"
309:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
310:             .PicturePosition = 13
311:             .Top             = 5
312:             .Left            = 5
313:             .Width           = 75
314:             .Height          = 75
315:             .BackColor       = RGB(255, 255, 255)
316:             .ForeColor       = RGB(90, 90, 90)
317:             .FontName        = "Comic Sans MS"
318:             .FontSize        = 8
319:             .FontBold        = .T.
320:             .FontItalic      = .T.
321:             .Themes          = .F.
322:             .SpecialEffect   = 0
323:             .MousePointer    = 15
324:             .WordWrap        = .T.
325:             .AutoSize        = .F.
326:             .Visible         = .T.
327:         ENDWITH
328:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
329: 
330:         *-- Grid da lista (colunas do legado: Movimento/Tipo/Mv.Anterior/Grupo-Ori)
331:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
332:         loc_oGrid = loc_oPagina.grd_4c_Lista
333: 
334:         loc_oGrid.RecordSource = ""
335:         loc_oGrid.ColumnCount  = 4
336: 
337:         WITH loc_oGrid
338:             .Top                = 117
339:             .Left               = 4
340:             .Width              = 992
341:             .Height             = 450
342:             .FontName           = "Verdana"
343:             .FontSize           = 8
344:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 357 a 704:
357:         ENDWITH
358: 
359:         WITH loc_oGrid.Column1
360:             .Header1.Caption = "Movimento"
361:             .Width           = 140
362:             .ReadOnly        = .T.
363:         ENDWITH
364: 
365:         WITH loc_oGrid.Column2
366:             .Header1.Caption = "Tipo"
367:             .Width           = 60
368:             .ReadOnly        = .T.
369:         ENDWITH
370: 
371:         WITH loc_oGrid.Column3
372:             .Header1.Caption = "Mv. Anterior"
373:             .Width           = 140
374:             .ReadOnly        = .T.
375:         ENDWITH
376: 
377:         WITH loc_oGrid.Column4
378:             .Header1.Caption = "Grupo/Ori"
379:             .Width           = 80
380:             .ReadOnly        = .T.
381:         ENDWITH
382: 
383:         THIS.TornarControlesVisiveis(loc_oPagina)
384:     ENDPROC
385: 
386:     *==========================================================================
387:     * ConfigurarPaginaDados - Page2: todos os campos SIGCDOPT
388:     * Fase 5/8: BotoesAcao + campos top<=248 (ate Line2) + BINDEVENTs
389:     * Todos os Tops recebem +29 (compensacao PageFrame.Top=-29)
390:     *==========================================================================
391:     PROTECTED PROCEDURE ConfigurarPaginaDados()
392:         LOCAL loc_oPagina
393:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
394: 
395:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
396: 
397:         *-- Container BotoesAcao (Grupo_Salva: top=4+29=33, left=842)
398:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
399:         WITH loc_oPagina.cnt_4c_BotoesAcao
400:             .Top         = 33
401:             .Left        = 842
402:             .Width       = 160
403:             .Height      = 85
404:             .BackStyle   = 0
405:             .BorderWidth = 0
406:             .Visible     = .T.
407:         ENDWITH
408: 
409:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
410:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
411:             .Caption         = "Confirmar"
412:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
413:             .PicturePosition = 13
414:             .Top             = 5
415:             .Left            = 5
416:             .Width           = 75
417:             .Height          = 75
418:             .BackColor       = RGB(255, 255, 255)
419:             .ForeColor       = RGB(90, 90, 90)
420:             .FontName        = "Comic Sans MS"
421:             .FontSize        = 8
422:             .FontBold        = .T.
423:             .FontItalic      = .T.
424:             .Themes          = .F.
425:             .SpecialEffect   = 0
426:             .MousePointer    = 15
427:             .WordWrap        = .T.
428:             .AutoSize        = .F.
429:             .Visible         = .T.
430:         ENDWITH
431:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
432: 
433:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
434:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
435:             .Caption         = "Encerrar"
436:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
437:             .PicturePosition = 13
438:             .Top             = 5
439:             .Left            = 80
440:             .Width           = 75
441:             .Height          = 75
442:             .BackColor       = RGB(255, 255, 255)
443:             .ForeColor       = RGB(90, 90, 90)
444:             .FontName        = "Comic Sans MS"
445:             .FontSize        = 8
446:             .FontBold        = .T.
447:             .FontItalic      = .T.
448:             .Themes          = .F.
449:             .SpecialEffect   = 0
450:             .MousePointer    = 15
451:             .WordWrap        = .T.
452:             .AutoSize        = .F.
453:             .Visible         = .T.
454:         ENDWITH
455:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
456: 
457:         *-- CheckBox: Inativa (fwcheckbox1 - top=15+29=44, left=299)
458:         loc_oPagina.AddObject("chk_4c_Fwcheckbox1", "CheckBox")
459:         WITH loc_oPagina.chk_4c_Fwcheckbox1
460:             .Caption   = "Inativa"
461:             .Top       = 44
462:             .Left      = 299
463:             .Width     = 60
464:             .Height    = 20
465:             .Value     = 0
466:             .FontName  = "Tahoma"
467:             .FontSize  = 8
468:             .ForeColor = RGB(90, 90, 90)
469:             .BackStyle = 0
470:             .Visible   = .T.
471:         ENDWITH
472: 
473:         *-- Linha 1: Codigo / Descricao / Tipo (top original=12-16; comp.=41-45)
474:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
475:         WITH loc_oPagina.lbl_4c_Label1
476:             .Caption   = "C" + CHR(243) + "digo :"
477:             .Top       = 45
478:             .Left      = 100
479:             .Width     = 43
480:             .Height    = 17
481:             .FontName  = "Tahoma"
482:             .FontSize  = 8
483:             .ForeColor = RGB(90, 90, 90)
484:             .BackStyle = 0
485:             .Visible   = .T.
486:         ENDWITH
487: 
488:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
489:         WITH loc_oPagina.txt_4c_Codigo
490:             .Value     = ""
491:             .Top       = 41
492:             .Left      = 146
493:             .Width     = 150
494:             .Height    = 23
495:             .MaxLength = 15
496:             .FontName  = "Tahoma"
497:             .FontSize  = 8
498:             .Visible   = .T.
499:         ENDWITH
500: 
501:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
502:         WITH loc_oPagina.lbl_4c_Label2
503:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
504:             .Top       = 45
505:             .Left      = 395
506:             .Width     = 56
507:             .Height    = 17
508:             .FontName  = "Tahoma"
509:             .FontSize  = 8
510:             .ForeColor = RGB(90, 90, 90)
511:             .BackStyle = 0
512:             .Visible   = .T.
513:         ENDWITH
514: 
515:         loc_oPagina.AddObject("txt_4c_Descr", "TextBox")
516:         WITH loc_oPagina.txt_4c_Descr
517:             .Value     = ""
518:             .Top       = 41
519:             .Left      = 454
520:             .Width     = 150
521:             .Height    = 23
522:             .MaxLength = 60
523:             .FontName  = "Tahoma"
524:             .FontSize  = 8
525:             .Visible   = .T.
526:         ENDWITH
527: 
528:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
529:         WITH loc_oPagina.lbl_4c_Label3
530:             .Caption   = "Tipo :"
531:             .Top       = 45
532:             .Left      = 679
533:             .Width     = 34
534:             .Height    = 17
535:             .FontName  = "Tahoma"
536:             .FontSize  = 8
537:             .ForeColor = RGB(90, 90, 90)
538:             .BackStyle = 0
539:             .Visible   = .T.
540:         ENDWITH
541: 
542:         loc_oPagina.AddObject("txt_4c_Tipo", "TextBox")
543:         WITH loc_oPagina.txt_4c_Tipo
544:             .Value     = ""
545:             .Top       = 41
546:             .Left      = 712
547:             .Width     = 24
548:             .Height    = 23
549:             .MaxLength = 2
550:             .FontName  = "Tahoma"
551:             .FontSize  = 8
552:             .Visible   = .T.
553:         ENDWITH
554: 
555:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
556:         WITH loc_oPagina.lbl_4c_Label4
557:             .Caption   = "(CR/DB)"
558:             .Top       = 45
559:             .Left      = 745
560:             .Width     = 45
561:             .Height    = 17
562:             .FontName  = "Tahoma"
563:             .FontSize  = 8
564:             .ForeColor = RGB(90, 90, 90)
565:             .BackStyle = 0
566:             .Visible   = .T.
567:         ENDWITH
568: 
569:         *-- Linha 2: Mov.Anterior / Mov.Titulos / Ordem (top orig=37-41; comp.=66-70)
570:         loc_oPagina.AddObject("lbl_4c_Label8", "Label")
571:         WITH loc_oPagina.lbl_4c_Label8
572:             .Caption   = "Movimento Anterior :"
573:             .Top       = 70
574:             .Left      = 39
575:             .Width     = 103
576:             .Height    = 15
577:             .FontName  = "Tahoma"
578:             .FontSize  = 8
579:             .ForeColor = RGB(90, 90, 90)
580:             .BackStyle = 0
581:             .Visible   = .T.
582:         ENDWITH
583: 
584:         loc_oPagina.AddObject("txt_4c_OpAnts", "TextBox")
585:         WITH loc_oPagina.txt_4c_OpAnts
586:             .Value     = ""
587:             .Top       = 66
588:             .Left      = 146
589:             .Width     = 150
590:             .Height    = 23
591:             .MaxLength = 15
592:             .FontName  = "Tahoma"
593:             .FontSize  = 8
594:             .Visible   = .T.
595:         ENDWITH
596:         BINDEVENT(loc_oPagina.txt_4c_OpAnts, "KeyPress", THIS, "ValidarOpAnts")
597: 
598:         loc_oPagina.AddObject("lbl_4c_Label35", "Label")
599:         WITH loc_oPagina.lbl_4c_Label35
600:             .Caption   = "Movimento de T" + CHR(237) + "tulos :"
601:             .Top       = 70
602:             .Left      = 340
603:             .Width     = 110
604:             .Height    = 15
605:             .FontName  = "Tahoma"
606:             .FontSize  = 8
607:             .ForeColor = RGB(90, 90, 90)
608:             .BackStyle = 0
609:             .Visible   = .T.
610:         ENDWITH
611: 
612:         loc_oPagina.AddObject("txt_4c_OpContas", "TextBox")
613:         WITH loc_oPagina.txt_4c_OpContas
614:             .Value     = ""
615:             .Top       = 66
616:             .Left      = 454
617:             .Width     = 150
618:             .Height    = 23
619:             .MaxLength = 15
620:             .FontName  = "Tahoma"
621:             .FontSize  = 8
622:             .Visible   = .T.
623:         ENDWITH
624:         BINDEVENT(loc_oPagina.txt_4c_OpContas, "KeyPress", THIS, "ValidarOpContas")
625: 
626:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
627:         WITH loc_oPagina.lbl_4c_Label5
628:             .Caption   = "Ordem :"
629:             .Top       = 70
630:             .Left      = 667
631:             .Width     = 41
632:             .Height    = 17
633:             .FontName  = "Tahoma"
634:             .FontSize  = 8
635:             .ForeColor = RGB(90, 90, 90)
636:             .BackStyle = 0
637:             .Visible   = .T.
638:         ENDWITH
639: 
640:         loc_oPagina.AddObject("txt_4c_Ordem", "TextBox")
641:         WITH loc_oPagina.txt_4c_Ordem
642:             .Value     = 0
643:             .Top       = 66
644:             .Left      = 712
645:             .Width     = 50
646:             .Height    = 23
647:             .FontName  = "Tahoma"
648:             .FontSize  = 8
649:             .Visible   = .T.
650:         ENDWITH
651: 
652:         *-- Linha 3: Mov.Entrada / Mov.Automatico / Opc_TipoData (top orig=62-66; comp.=91-95)
653:         loc_oPagina.AddObject("lbl_4c_Label67", "Label")
654:         WITH loc_oPagina.lbl_4c_Label67
655:             .Caption   = "Movimento de Entrada :"
656:             .Top       = 95
657:             .Left      = 25
658:             .Width     = 117
659:             .Height    = 15
660:             .FontName  = "Tahoma"
661:             .FontSize  = 8
662:             .ForeColor = RGB(90, 90, 90)
663:             .BackStyle = 0
664:             .Visible   = .T.
665:         ENDWITH
666: 
667:         loc_oPagina.AddObject("txt_4c_OpEntrada", "TextBox")
668:         WITH loc_oPagina.txt_4c_OpEntrada
669:             .Value     = ""
670:             .Top       = 91
671:             .Left      = 146
672:             .Width     = 150
673:             .Height    = 23
674:             .MaxLength = 15
675:             .FontName  = "Tahoma"
676:             .FontSize  = 8
677:             .Visible   = .T.
678:         ENDWITH
679:         BINDEVENT(loc_oPagina.txt_4c_OpEntrada, "KeyPress", THIS, "ValidarOpEntrada")
680: 
681:         loc_oPagina.AddObject("lbl_4c_Label6", "Label")
682:         WITH loc_oPagina.lbl_4c_Label6
683:             .Caption   = "Movimento Autom" + CHR(225) + "tico :"
684:             .Top       = 95
685:             .Left      = 332
686:             .Width     = 120
687:             .Height    = 17
688:             .FontName  = "Tahoma"
689:             .FontSize  = 8
690:             .ForeColor = RGB(90, 90, 90)
691:             .BackStyle = 0
692:             .Visible   = .T.
693:         ENDWITH
694: 
695:         loc_oPagina.AddObject("txt_4c_OpAut", "TextBox")
696:         WITH loc_oPagina.txt_4c_OpAut
697:             .Value     = ""
698:             .Top       = 91
699:             .Left      = 454
700:             .Width     = 18
701:             .Height    = 23
702:             .MaxLength = 1
703:             .FontName  = "Tahoma"
704:             .FontSize  = 8

*-- Linhas 710 a 902:
710:         loc_oPagina.AddObject("obj_4c_Opc_TipoData", "OptionGroup")
711:         WITH loc_oPagina.obj_4c_Opc_TipoData
712:             .ButtonCount = 4
713:             .Top         = 91
714:             .Left        = 471
715:             .Width       = 340
716:             .Height      = 22
717:             .BackStyle   = 0
718:             .BorderStyle = 0
719:             .Enabled     = .F.
720:             .Visible     = .T.
721:         ENDWITH
722:         WITH loc_oPagina.obj_4c_Opc_TipoData.Buttons(1)
723:             .Caption   = "Emiss" + CHR(227) + "o"
724:             .BackStyle = 0
725:             .Left      = 3
726:             .Top       = 2
727:             .Width     = 70
728:             .AutoSize  = .T.
729:             .FontName  = "Tahoma"
730:             .FontSize  = 8
731:             .ForeColor = RGB(90, 90, 90)
732:             .Themes    = .F.
733:         ENDWITH
734:         WITH loc_oPagina.obj_4c_Opc_TipoData.Buttons(2)
735:             .Caption   = "Vencimento"
736:             .BackStyle = 0
737:             .Left      = 80
738:             .Top       = 2
739:             .Width     = 75
740:             .AutoSize  = .T.
741:             .FontName  = "Tahoma"
742:             .FontSize  = 8
743:             .ForeColor = RGB(90, 90, 90)
744:             .Themes    = .F.
745:         ENDWITH
746:         WITH loc_oPagina.obj_4c_Opc_TipoData.Buttons(3)
747:             .Caption   = "Transa" + CHR(231) + CHR(227) + "o"
748:             .BackStyle = 0
749:             .Left      = 162
750:             .Top       = 2
751:             .Width     = 80
752:             .AutoSize  = .T.
753:             .FontName  = "Tahoma"
754:             .FontSize  = 8
755:             .ForeColor = RGB(90, 90, 90)
756:             .Themes    = .F.
757:         ENDWITH
758:         WITH loc_oPagina.obj_4c_Opc_TipoData.Buttons(4)
759:             .Caption   = "Nenhum"
760:             .BackStyle = 0
761:             .Left      = 250
762:             .Top       = 2
763:             .Width     = 70
764:             .AutoSize  = .T.
765:             .FontName  = "Tahoma"
766:             .FontSize  = 8
767:             .ForeColor = RGB(90, 90, 90)
768:             .Themes    = .F.
769:         ENDWITH
770: 
771:         *-- Linha 4: Cond.Pagto / Historico Padrao / OpTpHists (top orig=86-91; comp.=115-120)
772:         loc_oPagina.AddObject("lbl_4c_Label65", "Label")
773:         WITH loc_oPagina.lbl_4c_Label65
774:             .Caption   = "Condi" + CHR(231) + CHR(227) + "o de Pagto :"
775:             .Top       = 120
776:             .Left      = 43
777:             .Width     = 99
778:             .Height    = 15
779:             .FontName  = "Tahoma"
780:             .FontSize  = 8
781:             .ForeColor = RGB(90, 90, 90)
782:             .BackStyle = 0
783:             .Visible   = .T.
784:         ENDWITH
785: 
786:         loc_oPagina.AddObject("txt_4c_Fpg", "TextBox")
787:         WITH loc_oPagina.txt_4c_Fpg
788:             .Value     = ""
789:             .Top       = 116
790:             .Left      = 146
791:             .Width     = 94
792:             .Height    = 23
793:             .MaxLength = 10
794:             .FontName  = "Tahoma"
795:             .FontSize  = 8
796:             .Visible   = .T.
797:         ENDWITH
798:         BINDEVENT(loc_oPagina.txt_4c_Fpg, "KeyPress", THIS, "ValidarFpg")
799: 
800:         loc_oPagina.AddObject("lbl_4c_Label28", "Label")
801:         WITH loc_oPagina.lbl_4c_Label28
802:             .Caption   = "Hist" + CHR(243) + "rico Padr" + CHR(227) + "o :"
803:             .Top       = 120
804:             .Left      = 363
805:             .Width     = 85
806:             .Height    = 17
807:             .FontName  = "Tahoma"
808:             .FontSize  = 8
809:             .ForeColor = RGB(90, 90, 90)
810:             .BackStyle = 0
811:             .Visible   = .T.
812:         ENDWITH
813: 
814:         loc_oPagina.AddObject("txt_4c_Hists", "TextBox")
815:         WITH loc_oPagina.txt_4c_Hists
816:             .Value     = ""
817:             .Top       = 116
818:             .Left      = 454
819:             .Width     = 220
820:             .Height    = 23
821:             .MaxLength = 100
822:             .FontName  = "Tahoma"
823:             .FontSize  = 8
824:             .Visible   = .T.
825:         ENDWITH
826: 
827:         *-- OptionGroup: OpTpHists (2 botoes; top=86+29=115, left=670, w=145)
828:         loc_oPagina.AddObject("obj_4c_OpTpHists", "OptionGroup")
829:         WITH loc_oPagina.obj_4c_OpTpHists
830:             .ButtonCount = 2
831:             .Top         = 115
832:             .Left        = 670
833:             .Width       = 145
834:             .Height      = 25
835:             .BackStyle   = 0
836:             .BorderStyle = 0
837:             .Visible     = .T.
838:         ENDWITH
839:         WITH loc_oPagina.obj_4c_OpTpHists.Buttons(1)
840:             .Caption   = "Padr" + CHR(227) + "o"
841:             .BackStyle = 0
842:             .Left      = 5
843:             .Top       = 3
844:             .Width     = 60
845:             .AutoSize  = .T.
846:             .FontName  = "Tahoma"
847:             .FontSize  = 8
848:             .ForeColor = RGB(90, 90, 90)
849:             .Themes    = .F.
850:         ENDWITH
851:         WITH loc_oPagina.obj_4c_OpTpHists.Buttons(2)
852:             .Caption   = "Livre"
853:             .BackStyle = 0
854:             .Left      = 72
855:             .Top       = 3
856:             .Width     = 50
857:             .AutoSize  = .T.
858:             .FontName  = "Tahoma"
859:             .FontSize  = 8
860:             .ForeColor = RGB(90, 90, 90)
861:             .Themes    = .F.
862:         ENDWITH
863: 
864:         *-- Linha 5: Grupo Emissor / Tipo Emissor (top orig=112-116; comp.=141-145)
865:         loc_oPagina.AddObject("lbl_4c_Label49", "Label")
866:         WITH loc_oPagina.lbl_4c_Label49
867:             .Caption   = "Grupo Emissor Default :"
868:             .Top       = 145
869:             .Left      = 27
870:             .Width     = 115
871:             .Height    = 17
872:             .FontName  = "Tahoma"
873:             .FontSize  = 8
874:             .ForeColor = RGB(90, 90, 90)
875:             .BackStyle = 0
876:             .Visible   = .T.
877:         ENDWITH
878: 
879:         loc_oPagina.AddObject("txt_4c_Hispad", "TextBox")
880:         WITH loc_oPagina.txt_4c_Hispad
881:             .Value     = ""
882:             .Top       = 141
883:             .Left      = 146
884:             .Width     = 80
885:             .Height    = 23
886:             .MaxLength = 10
887:             .FontName  = "Tahoma"
888:             .FontSize  = 8
889:             .Visible   = .T.
890:         ENDWITH
891:         BINDEVENT(loc_oPagina.txt_4c_Hispad, "KeyPress", THIS, "ValidarHispad")
892: 
893:         loc_oPagina.AddObject("lbl_4c_Label61", "Label")
894:         WITH loc_oPagina.lbl_4c_Label61
895:             .Caption   = "Tipo do Emissor :"
896:             .Top       = 145
897:             .Left      = 367
898:             .Width     = 83
899:             .Height    = 15
900:             .FontName  = "Tahoma"
901:             .FontSize  = 8
902:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 908 a 1052:
908:         loc_oPagina.AddObject("obj_4c_Opc_tpemissor", "OptionGroup")
909:         WITH loc_oPagina.obj_4c_Opc_tpemissor
910:             .ButtonCount = 2
911:             .Top         = 141
912:             .Left        = 447
913:             .Width       = 151
914:             .Height      = 25
915:             .BackStyle   = 0
916:             .BorderStyle = 0
917:             .Visible     = .T.
918:         ENDWITH
919:         WITH loc_oPagina.obj_4c_Opc_tpemissor.Buttons(1)
920:             .Caption   = "Normal"
921:             .BackStyle = 0
922:             .Left      = 5
923:             .Top       = 3
924:             .Width     = 60
925:             .AutoSize  = .T.
926:             .FontName  = "Tahoma"
927:             .FontSize  = 8
928:             .ForeColor = RGB(90, 90, 90)
929:             .Themes    = .F.
930:         ENDWITH
931:         WITH loc_oPagina.obj_4c_Opc_tpemissor.Buttons(2)
932:             .Caption   = "Terceiro"
933:             .BackStyle = 0
934:             .Left      = 72
935:             .Top       = 3
936:             .Width     = 65
937:             .AutoSize  = .T.
938:             .FontName  = "Tahoma"
939:             .FontSize  = 8
940:             .ForeColor = RGB(90, 90, 90)
941:             .Themes    = .F.
942:         ENDWITH
943: 
944:         *-- Linha 6: Situacao / Responsavel / Central de Credito (top orig=137-141; comp.=166-170)
945:         loc_oPagina.AddObject("lbl_4c_Label60", "Label")
946:         WITH loc_oPagina.lbl_4c_Label60
947:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o do Cliente :"
948:             .Top       = 170
949:             .Left      = 41
950:             .Width     = 101
951:             .Height    = 15
952:             .FontName  = "Tahoma"
953:             .FontSize  = 8
954:             .ForeColor = RGB(90, 90, 90)
955:             .BackStyle = 0
956:             .Visible   = .T.
957:         ENDWITH
958: 
959:         loc_oPagina.AddObject("txt_4c_Situa", "TextBox")
960:         WITH loc_oPagina.txt_4c_Situa
961:             .Value     = ""
962:             .Top       = 166
963:             .Left      = 146
964:             .Width     = 31
965:             .Height    = 23
966:             .MaxLength = 5
967:             .FontName  = "Tahoma"
968:             .FontSize  = 8
969:             .Visible   = .T.
970:         ENDWITH
971:         BINDEVENT(loc_oPagina.txt_4c_Situa, "KeyPress", THIS, "ValidarSituacao")
972: 
973:         loc_oPagina.AddObject("lbl_4c_Label47", "Label")
974:         WITH loc_oPagina.lbl_4c_Label47
975:             .Caption   = "Respons" + CHR(225) + "vel :"
976:             .Top       = 170
977:             .Left      = 380
978:             .Width     = 70
979:             .Height    = 17
980:             .FontName  = "Tahoma"
981:             .FontSize  = 8
982:             .ForeColor = RGB(90, 90, 90)
983:             .BackStyle = 0
984:             .Visible   = .T.
985:         ENDWITH
986: 
987:         loc_oPagina.AddObject("txt_4c_Respons", "TextBox")
988:         WITH loc_oPagina.txt_4c_Respons
989:             .Value     = ""
990:             .Top       = 166
991:             .Left      = 454
992:             .Width     = 80
993:             .Height    = 23
994:             .MaxLength = 10
995:             .FontName  = "Tahoma"
996:             .FontSize  = 8
997:             .Visible   = .T.
998:         ENDWITH
999:         BINDEVENT(loc_oPagina.txt_4c_Respons, "KeyPress", THIS, "ValidarResponsavel")
1000: 
1001:         loc_oPagina.AddObject("lbl_4c_Label21", "Label")
1002:         WITH loc_oPagina.lbl_4c_Label21
1003:             .Caption   = "Central de Cr" + CHR(233) + "dito :"
1004:             .Top       = 170
1005:             .Left      = 611
1006:             .Width     = 97
1007:             .Height    = 15
1008:             .FontName  = "Tahoma"
1009:             .FontSize  = 8
1010:             .ForeColor = RGB(90, 90, 90)
1011:             .BackStyle = 0
1012:             .Visible   = .T.
1013:         ENDWITH
1014: 
1015:         loc_oPagina.AddObject("txt_4c_Central", "TextBox")
1016:         WITH loc_oPagina.txt_4c_Central
1017:             .Value     = ""
1018:             .Top       = 166
1019:             .Left      = 712
1020:             .Width     = 24
1021:             .Height    = 23
1022:             .MaxLength = 15
1023:             .FontName  = "Tahoma"
1024:             .FontSize  = 8
1025:             .Visible   = .T.
1026:         ENDWITH
1027:         BINDEVENT(loc_oPagina.txt_4c_Central, "KeyPress", THIS, "ValidarCentral")
1028: 
1029:         loc_oPagina.AddObject("txt_4c_DCentral", "TextBox")
1030:         WITH loc_oPagina.txt_4c_DCentral
1031:             .Value     = ""
1032:             .Top       = 166
1033:             .Left      = 738
1034:             .Width     = 194
1035:             .Height    = 23
1036:             .MaxLength = 60
1037:             .FontName  = "Tahoma"
1038:             .FontSize  = 8
1039:             .Visible   = .T.
1040:         ENDWITH
1041:         BINDEVENT(loc_oPagina.txt_4c_DCentral, "KeyPress", THIS, "ValidarDescCentral")
1042: 
1043:         *-- Linha separadora Line1 (original top=166; comp.=195)
1044:         loc_oPagina.AddObject("lin_4c_Line1", "Shape")
1045:         WITH loc_oPagina.lin_4c_Line1
1046:             .Top         = 195
1047:             .Left        = 7
1048:             .Width       = 984
1049:             .Height      = 2
1050:             .BackColor   = RGB(180, 180, 180)
1051:             .BackStyle   = 1
1052:             .BorderStyle = 0

*-- Linhas 1059 a 1104:
1059:         loc_oPagina.AddObject("obj_4c_Op_origem", "OptionGroup")
1060:         WITH loc_oPagina.obj_4c_Op_origem
1061:             .ButtonCount = 2
1062:             .Top         = 197
1063:             .Left        = 140
1064:             .Width       = 95
1065:             .Height      = 25
1066:             .BackStyle   = 0
1067:             .BorderStyle = 0
1068:             .Visible     = .T.
1069:         ENDWITH
1070:         WITH loc_oPagina.obj_4c_Op_origem.Buttons(1)
1071:             .Caption   = "CR"
1072:             .BackStyle = 0
1073:             .Left      = 5
1074:             .Top       = 3
1075:             .Width     = 35
1076:             .AutoSize  = .T.
1077:             .FontName  = "Tahoma"
1078:             .FontSize  = 8
1079:             .ForeColor = RGB(90, 90, 90)
1080:             .Themes    = .F.
1081:         ENDWITH
1082:         WITH loc_oPagina.obj_4c_Op_origem.Buttons(2)
1083:             .Caption   = "DB"
1084:             .BackStyle = 0
1085:             .Left      = 48
1086:             .Top       = 3
1087:             .Width     = 35
1088:             .AutoSize  = .T.
1089:             .FontName  = "Tahoma"
1090:             .FontSize  = 8
1091:             .ForeColor = RGB(90, 90, 90)
1092:             .Themes    = .F.
1093:         ENDWITH
1094: 
1095:         loc_oPagina.AddObject("lbl_4c_Label43", "Label")
1096:         WITH loc_oPagina.lbl_4c_Label43
1097:             .Caption   = "Origem :"
1098:             .Top       = 202
1099:             .Left      = 99
1100:             .Width     = 43
1101:             .Height    = 15
1102:             .FontName  = "Tahoma"
1103:             .FontSize  = 8
1104:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1110 a 1353:
1110:         loc_oPagina.AddObject("obj_4c_Op_destino", "OptionGroup")
1111:         WITH loc_oPagina.obj_4c_Op_destino
1112:             .ButtonCount = 3
1113:             .Top         = 197
1114:             .Left        = 619
1115:             .Width       = 169
1116:             .Height      = 27
1117:             .BackStyle   = 0
1118:             .BorderStyle = 0
1119:             .Visible     = .T.
1120:         ENDWITH
1121:         WITH loc_oPagina.obj_4c_Op_destino.Buttons(1)
1122:             .Caption   = "Nenhum"
1123:             .BackStyle = 0
1124:             .Left      = 5
1125:             .Top       = 3
1126:             .Width     = 55
1127:             .AutoSize  = .T.
1128:             .FontName  = "Tahoma"
1129:             .FontSize  = 8
1130:             .ForeColor = RGB(90, 90, 90)
1131:             .Themes    = .F.
1132:         ENDWITH
1133:         WITH loc_oPagina.obj_4c_Op_destino.Buttons(2)
1134:             .Caption   = "CR"
1135:             .BackStyle = 0
1136:             .Left      = 68
1137:             .Top       = 3
1138:             .Width     = 35
1139:             .AutoSize  = .T.
1140:             .FontName  = "Tahoma"
1141:             .FontSize  = 8
1142:             .ForeColor = RGB(90, 90, 90)
1143:             .Themes    = .F.
1144:         ENDWITH
1145:         WITH loc_oPagina.obj_4c_Op_destino.Buttons(3)
1146:             .Caption   = "DB"
1147:             .BackStyle = 0
1148:             .Left      = 110
1149:             .Top       = 3
1150:             .Width     = 35
1151:             .AutoSize  = .T.
1152:             .FontName  = "Tahoma"
1153:             .FontSize  = 8
1154:             .ForeColor = RGB(90, 90, 90)
1155:             .Themes    = .F.
1156:         ENDWITH
1157: 
1158:         loc_oPagina.AddObject("lbl_4c_Label25", "Label")
1159:         WITH loc_oPagina.lbl_4c_Label25
1160:             .Caption   = "Destino :"
1161:             .Top       = 202
1162:             .Left      = 574
1163:             .Width     = 45
1164:             .Height    = 15
1165:             .FontName  = "Tahoma"
1166:             .FontSize  = 8
1167:             .ForeColor = RGB(90, 90, 90)
1168:             .BackStyle = 0
1169:             .Visible   = .T.
1170:         ENDWITH
1171: 
1172:         *-- GrupoOs/DGrupoOs - Origem (top orig=192-195; comp.=221-224)
1173:         loc_oPagina.AddObject("lbl_4c_Label41", "Label")
1174:         WITH loc_oPagina.lbl_4c_Label41
1175:             .Caption   = "Grupo/Origem :"
1176:             .Top       = 224
1177:             .Left      = 66
1178:             .Width     = 75
1179:             .Height    = 17
1180:             .FontName  = "Tahoma"
1181:             .FontSize  = 8
1182:             .ForeColor = RGB(90, 90, 90)
1183:             .BackStyle = 0
1184:             .Visible   = .T.
1185:         ENDWITH
1186: 
1187:         loc_oPagina.AddObject("txt_4c_GrupoOs", "TextBox")
1188:         WITH loc_oPagina.txt_4c_GrupoOs
1189:             .Value     = ""
1190:             .Top       = 221
1191:             .Left      = 146
1192:             .Width     = 79
1193:             .Height    = 23
1194:             .MaxLength = 10
1195:             .FontName  = "Tahoma"
1196:             .FontSize  = 8
1197:             .Visible   = .T.
1198:         ENDWITH
1199:         BINDEVENT(loc_oPagina.txt_4c_GrupoOs, "KeyPress", THIS, "ValidarGrupoOrig")
1200: 
1201:         loc_oPagina.AddObject("txt_4c_DGrupoOs", "TextBox")
1202:         WITH loc_oPagina.txt_4c_DGrupoOs
1203:             .Value     = ""
1204:             .Top       = 221
1205:             .Left      = 227
1206:             .Width     = 290
1207:             .Height    = 23
1208:             .MaxLength = 60
1209:             .FontName  = "Tahoma"
1210:             .FontSize  = 8
1211:             .Visible   = .T.
1212:         ENDWITH
1213:         BINDEVENT(loc_oPagina.txt_4c_DGrupoOs, "KeyPress", THIS, "ValidarDescGrupoOrig")
1214: 
1215:         *-- Grupo/Destino (top orig=193-197; comp.=222-226)
1216:         loc_oPagina.AddObject("lbl_4c_Label9", "Label")
1217:         WITH loc_oPagina.lbl_4c_Label9
1218:             .Caption   = "Grupo/Destino :"
1219:             .Top       = 226
1220:             .Left      = 541
1221:             .Width     = 78
1222:             .Height    = 17
1223:             .FontName  = "Tahoma"
1224:             .FontSize  = 8
1225:             .ForeColor = RGB(90, 90, 90)
1226:             .BackStyle = 0
1227:             .Visible   = .T.
1228:         ENDWITH
1229: 
1230:         loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
1231:         WITH loc_oPagina.txt_4c_Grupo
1232:             .Value     = ""
1233:             .Top       = 222
1234:             .Left      = 621
1235:             .Width     = 79
1236:             .Height    = 23
1237:             .MaxLength = 10
1238:             .FontName  = "Tahoma"
1239:             .FontSize  = 8
1240:             .Visible   = .T.
1241:         ENDWITH
1242:         BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress", THIS, "ValidarGrupoDest")
1243: 
1244:         loc_oPagina.AddObject("txt_4c__ds_grupo", "TextBox")
1245:         WITH loc_oPagina.txt_4c__ds_grupo
1246:             .Value     = ""
1247:             .Top       = 222
1248:             .Left      = 701
1249:             .Width     = 290
1250:             .Height    = 23
1251:             .MaxLength = 60
1252:             .FontName  = "Tahoma"
1253:             .FontSize  = 8
1254:             .Visible   = .T.
1255:         ENDWITH
1256:         BINDEVENT(loc_oPagina.txt_4c__ds_grupo, "KeyPress", THIS, "ValidarDescGrupoDest")
1257: 
1258:         *-- ContaOs/DContaOs - Origem (top orig=217-220; comp.=246-249)
1259:         loc_oPagina.AddObject("lbl_4c_Label42", "Label")
1260:         WITH loc_oPagina.lbl_4c_Label42
1261:             .Caption   = "Conta/Origem :"
1262:             .Top       = 249
1263:             .Left      = 66
1264:             .Width     = 72
1265:             .Height    = 17
1266:             .FontName  = "Tahoma"
1267:             .FontSize  = 8
1268:             .ForeColor = RGB(90, 90, 90)
1269:             .BackStyle = 0
1270:             .Visible   = .T.
1271:         ENDWITH
1272: 
1273:         loc_oPagina.AddObject("txt_4c_ContaOs", "TextBox")
1274:         WITH loc_oPagina.txt_4c_ContaOs
1275:             .Value     = ""
1276:             .Top       = 246
1277:             .Left      = 146
1278:             .Width     = 79
1279:             .Height    = 23
1280:             .MaxLength = 15
1281:             .FontName  = "Tahoma"
1282:             .FontSize  = 8
1283:             .Visible   = .T.
1284:         ENDWITH
1285:         BINDEVENT(loc_oPagina.txt_4c_ContaOs, "KeyPress", THIS, "ValidarContaOrig")
1286: 
1287:         loc_oPagina.AddObject("txt_4c_DContaOs", "TextBox")
1288:         WITH loc_oPagina.txt_4c_DContaOs
1289:             .Value     = ""
1290:             .Top       = 246
1291:             .Left      = 227
1292:             .Width     = 290
1293:             .Height    = 23
1294:             .MaxLength = 60
1295:             .FontName  = "Tahoma"
1296:             .FontSize  = 8
1297:             .Visible   = .T.
1298:         ENDWITH
1299:         BINDEVENT(loc_oPagina.txt_4c_DContaOs, "KeyPress", THIS, "ValidarDescContaOrig")
1300: 
1301:         *-- Conta/Destino (top orig=218-222; comp.=247-251)
1302:         loc_oPagina.AddObject("lbl_4c_Label10", "Label")
1303:         WITH loc_oPagina.lbl_4c_Label10
1304:             .Caption   = "Conta/Destino :"
1305:             .Top       = 251
1306:             .Left      = 541
1307:             .Width     = 78
1308:             .Height    = 17
1309:             .FontName  = "Tahoma"
1310:             .FontSize  = 8
1311:             .ForeColor = RGB(90, 90, 90)
1312:             .BackStyle = 0
1313:             .Visible   = .T.
1314:         ENDWITH
1315: 
1316:         loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
1317:         WITH loc_oPagina.txt_4c_Conta
1318:             .Value     = ""
1319:             .Top       = 247
1320:             .Left      = 621
1321:             .Width     = 79
1322:             .Height    = 23
1323:             .MaxLength = 15
1324:             .FontName  = "Tahoma"
1325:             .FontSize  = 8
1326:             .Visible   = .T.
1327:         ENDWITH
1328:         BINDEVENT(loc_oPagina.txt_4c_Conta, "KeyPress", THIS, "ValidarContaDest")
1329: 
1330:         loc_oPagina.AddObject("txt_4c_DConta", "TextBox")
1331:         WITH loc_oPagina.txt_4c_DConta
1332:             .Value     = ""
1333:             .Top       = 247
1334:             .Left      = 701
1335:             .Width     = 290
1336:             .Height    = 23
1337:             .MaxLength = 60
1338:             .FontName  = "Tahoma"
1339:             .FontSize  = 8
1340:             .Visible   = .T.
1341:         ENDWITH
1342:         BINDEVENT(loc_oPagina.txt_4c_DConta, "KeyPress", THIS, "ValidarDescContaDest")
1343: 
1344:         *-- Linha separadora Line2 (original top=248; comp.=277)
1345:         loc_oPagina.AddObject("lin_4c_Line2", "Shape")
1346:         WITH loc_oPagina.lin_4c_Line2
1347:             .Top         = 277
1348:             .Left        = 7
1349:             .Width       = 984
1350:             .Height      = 2
1351:             .BackColor   = RGB(180, 180, 180)
1352:             .BackStyle   = 1
1353:             .BorderStyle = 0

*-- Linhas 1361 a 2732:
1361:         *-- ===================================================================
1362: 
1363:         *-- Coluna esquerda (left~194): flags S/N financeiros
1364:         loc_oPagina.AddObject("lbl_4c_LblValPend", "Label")
1365:         WITH loc_oPagina.lbl_4c_LblValPend
1366:             .Caption   = "Valor Pendente (Emissor) :"
1367:             .Top       = 288
1368:             .Left      = 63
1369:             .Width     = 129
1370:             .Height    = 15
1371:             .FontName  = "Tahoma"
1372:             .FontSize  = 8
1373:             .ForeColor = RGB(90, 90, 90)
1374:             .BackStyle = 0
1375:             .Visible   = .T.
1376:         ENDWITH
1377: 
1378:         loc_oPagina.AddObject("txt_4c_ValPend", "TextBox")
1379:         WITH loc_oPagina.txt_4c_ValPend
1380:             .Value     = ""
1381:             .Top       = 284
1382:             .Left      = 194
1383:             .Width     = 18
1384:             .Height    = 23
1385:             .MaxLength = 1
1386:             .FontName  = "Tahoma"
1387:             .FontSize  = 8
1388:             .Visible   = .T.
1389:         ENDWITH
1390: 
1391:         loc_oPagina.AddObject("lbl_4c_LblSN1", "Label")
1392:         WITH loc_oPagina.lbl_4c_LblSN1
1393:             .Caption   = "[S/N]"
1394:             .Top       = 288
1395:             .Left      = 215
1396:             .Width     = 35
1397:             .Height    = 15
1398:             .FontName  = "Tahoma"
1399:             .FontSize  = 8
1400:             .ForeColor = RGB(90, 90, 90)
1401:             .BackStyle = 0
1402:             .Visible   = .T.
1403:         ENDWITH
1404: 
1405:         loc_oPagina.AddObject("lbl_4c_LblValPend2", "Label")
1406:         WITH loc_oPagina.lbl_4c_LblValPend2
1407:             .Caption   = "Valor Pendente (Dep" + CHR(243) + "sito) :"
1408:             .Top       = 313
1409:             .Left      = 57
1410:             .Width     = 135
1411:             .Height    = 15
1412:             .FontName  = "Tahoma"
1413:             .FontSize  = 8
1414:             .ForeColor = RGB(90, 90, 90)
1415:             .BackStyle = 0
1416:             .Visible   = .T.
1417:         ENDWITH
1418: 
1419:         loc_oPagina.AddObject("txt_4c_ValPend2", "TextBox")
1420:         WITH loc_oPagina.txt_4c_ValPend2
1421:             .Value     = ""
1422:             .Top       = 309
1423:             .Left      = 194
1424:             .Width     = 18
1425:             .Height    = 23
1426:             .MaxLength = 1
1427:             .FontName  = "Tahoma"
1428:             .FontSize  = 8
1429:             .Visible   = .T.
1430:         ENDWITH
1431: 
1432:         loc_oPagina.AddObject("lbl_4c_LblSN2", "Label")
1433:         WITH loc_oPagina.lbl_4c_LblSN2
1434:             .Caption   = "[S/N]"
1435:             .Top       = 313
1436:             .Left      = 215
1437:             .Width     = 35
1438:             .Height    = 15
1439:             .FontName  = "Tahoma"
1440:             .FontSize  = 8
1441:             .ForeColor = RGB(90, 90, 90)
1442:             .BackStyle = 0
1443:             .Visible   = .T.
1444:         ENDWITH
1445: 
1446:         loc_oPagina.AddObject("lbl_4c_LblFazCont", "Label")
1447:         WITH loc_oPagina.lbl_4c_LblFazCont
1448:             .Caption   = "Lan" + CHR(231) + "a Conta Corrente :"
1449:             .Top       = 338
1450:             .Left      = 77
1451:             .Width     = 115
1452:             .Height    = 15
1453:             .FontName  = "Tahoma"
1454:             .FontSize  = 8
1455:             .ForeColor = RGB(90, 90, 90)
1456:             .BackStyle = 0
1457:             .Visible   = .T.
1458:         ENDWITH
1459: 
1460:         loc_oPagina.AddObject("txt_4c_FazContas", "TextBox")
1461:         WITH loc_oPagina.txt_4c_FazContas
1462:             .Value     = ""
1463:             .Top       = 334
1464:             .Left      = 194
1465:             .Width     = 18
1466:             .Height    = 23
1467:             .MaxLength = 1
1468:             .FontName  = "Tahoma"
1469:             .FontSize  = 8
1470:             .Visible   = .T.
1471:         ENDWITH
1472: 
1473:         loc_oPagina.AddObject("lbl_4c_LblSN3", "Label")
1474:         WITH loc_oPagina.lbl_4c_LblSN3
1475:             .Caption   = "[S/N]"
1476:             .Top       = 338
1477:             .Left      = 215
1478:             .Width     = 35
1479:             .Height    = 15
1480:             .FontName  = "Tahoma"
1481:             .FontSize  = 8
1482:             .ForeColor = RGB(90, 90, 90)
1483:             .BackStyle = 0
1484:             .Visible   = .T.
1485:         ENDWITH
1486: 
1487:         loc_oPagina.AddObject("lbl_4c_LblBxPend", "Label")
1488:         WITH loc_oPagina.lbl_4c_LblBxPend
1489:             .Caption   = "Baixa Pend" + CHR(234) + "ncias :"
1490:             .Top       = 363
1491:             .Left      = 100
1492:             .Width     = 92
1493:             .Height    = 15
1494:             .FontName  = "Tahoma"
1495:             .FontSize  = 8
1496:             .ForeColor = RGB(90, 90, 90)
1497:             .BackStyle = 0
1498:             .Visible   = .T.
1499:         ENDWITH
1500: 
1501:         loc_oPagina.AddObject("txt_4c_BxPend", "TextBox")
1502:         WITH loc_oPagina.txt_4c_BxPend
1503:             .Value     = ""
1504:             .Top       = 359
1505:             .Left      = 194
1506:             .Width     = 18
1507:             .Height    = 23
1508:             .MaxLength = 1
1509:             .FontName  = "Tahoma"
1510:             .FontSize  = 8
1511:             .Visible   = .T.
1512:         ENDWITH
1513: 
1514:         loc_oPagina.AddObject("lbl_4c_LblSN4", "Label")
1515:         WITH loc_oPagina.lbl_4c_LblSN4
1516:             .Caption   = "[S/N]"
1517:             .Top       = 363
1518:             .Left      = 215
1519:             .Width     = 35
1520:             .Height    = 15
1521:             .FontName  = "Tahoma"
1522:             .FontSize  = 8
1523:             .ForeColor = RGB(90, 90, 90)
1524:             .BackStyle = 0
1525:             .Visible   = .T.
1526:         ENDWITH
1527: 
1528:         loc_oPagina.AddObject("lbl_4c_LblVVecto", "Label")
1529:         WITH loc_oPagina.lbl_4c_LblVVecto
1530:             .Caption   = "Verifica Vencimento :"
1531:             .Top       = 388
1532:             .Left      = 90
1533:             .Width     = 102
1534:             .Height    = 15
1535:             .FontName  = "Tahoma"
1536:             .FontSize  = 8
1537:             .ForeColor = RGB(90, 90, 90)
1538:             .BackStyle = 0
1539:             .Visible   = .T.
1540:         ENDWITH
1541: 
1542:         loc_oPagina.AddObject("txt_4c_VVecto", "TextBox")
1543:         WITH loc_oPagina.txt_4c_VVecto
1544:             .Value     = ""
1545:             .Top       = 384
1546:             .Left      = 194
1547:             .Width     = 18
1548:             .Height    = 23
1549:             .MaxLength = 1
1550:             .FontName  = "Tahoma"
1551:             .FontSize  = 8
1552:             .Visible   = .T.
1553:         ENDWITH
1554: 
1555:         loc_oPagina.AddObject("lbl_4c_LblSN5", "Label")
1556:         WITH loc_oPagina.lbl_4c_LblSN5
1557:             .Caption   = "[S/N]"
1558:             .Top       = 388
1559:             .Left      = 215
1560:             .Width     = 35
1561:             .Height    = 15
1562:             .FontName  = "Tahoma"
1563:             .FontSize  = 8
1564:             .ForeColor = RGB(90, 90, 90)
1565:             .BackStyle = 0
1566:             .Visible   = .T.
1567:         ENDWITH
1568: 
1569:         loc_oPagina.AddObject("lbl_4c_LblHistClis", "Label")
1570:         WITH loc_oPagina.lbl_4c_LblHistClis
1571:             .Caption   = "Lan" + CHR(231) + "a Hist" + CHR(243) + "rico do Cliente :"
1572:             .Top       = 413
1573:             .Left      = 60
1574:             .Width     = 132
1575:             .Height    = 15
1576:             .FontName  = "Tahoma"
1577:             .FontSize  = 8
1578:             .ForeColor = RGB(90, 90, 90)
1579:             .BackStyle = 0
1580:             .Visible   = .T.
1581:         ENDWITH
1582: 
1583:         loc_oPagina.AddObject("txt_4c_HistClis", "TextBox")
1584:         WITH loc_oPagina.txt_4c_HistClis
1585:             .Value     = ""
1586:             .Top       = 409
1587:             .Left      = 194
1588:             .Width     = 18
1589:             .Height    = 23
1590:             .MaxLength = 1
1591:             .FontName  = "Tahoma"
1592:             .FontSize  = 8
1593:             .Visible   = .T.
1594:         ENDWITH
1595: 
1596:         loc_oPagina.AddObject("lbl_4c_LblSN6", "Label")
1597:         WITH loc_oPagina.lbl_4c_LblSN6
1598:             .Caption   = "[S/N]"
1599:             .Top       = 413
1600:             .Left      = 215
1601:             .Width     = 35
1602:             .Height    = 15
1603:             .FontName  = "Tahoma"
1604:             .FontSize  = 8
1605:             .ForeColor = RGB(90, 90, 90)
1606:             .BackStyle = 0
1607:             .Visible   = .T.
1608:         ENDWITH
1609: 
1610:         loc_oPagina.AddObject("lbl_4c_LblCongvs", "Label")
1611:         WITH loc_oPagina.lbl_4c_LblCongvs
1612:             .Caption   = "Cons. Global de Vendas :"
1613:             .Top       = 438
1614:             .Left      = 70
1615:             .Width     = 122
1616:             .Height    = 15
1617:             .FontName  = "Tahoma"
1618:             .FontSize  = 8
1619:             .ForeColor = RGB(90, 90, 90)
1620:             .BackStyle = 0
1621:             .Visible   = .T.
1622:         ENDWITH
1623: 
1624:         loc_oPagina.AddObject("txt_4c_Congvs", "TextBox")
1625:         WITH loc_oPagina.txt_4c_Congvs
1626:             .Value     = ""
1627:             .Top       = 434
1628:             .Left      = 194
1629:             .Width     = 18
1630:             .Height    = 23
1631:             .MaxLength = 1
1632:             .FontName  = "Tahoma"
1633:             .FontSize  = 8
1634:             .Visible   = .T.
1635:         ENDWITH
1636: 
1637:         loc_oPagina.AddObject("lbl_4c_LblSN7", "Label")
1638:         WITH loc_oPagina.lbl_4c_LblSN7
1639:             .Caption   = "[S/N]"
1640:             .Top       = 438
1641:             .Left      = 215
1642:             .Width     = 35
1643:             .Height    = 15
1644:             .FontName  = "Tahoma"
1645:             .FontSize  = 8
1646:             .ForeColor = RGB(90, 90, 90)
1647:             .BackStyle = 0
1648:             .Visible   = .T.
1649:         ENDWITH
1650: 
1651:         loc_oPagina.AddObject("lbl_4c_LblParcelas", "Label")
1652:         WITH loc_oPagina.lbl_4c_LblParcelas
1653:             .Caption   = "Parcelas :"
1654:             .Top       = 463
1655:             .Left      = 143
1656:             .Width     = 49
1657:             .Height    = 15
1658:             .FontName  = "Tahoma"
1659:             .FontSize  = 8
1660:             .ForeColor = RGB(90, 90, 90)
1661:             .BackStyle = 0
1662:             .Visible   = .T.
1663:         ENDWITH
1664: 
1665:         loc_oPagina.AddObject("txt_4c_Parcelas", "TextBox")
1666:         WITH loc_oPagina.txt_4c_Parcelas
1667:             .Value     = ""
1668:             .Top       = 459
1669:             .Left      = 194
1670:             .Width     = 18
1671:             .Height    = 23
1672:             .MaxLength = 1
1673:             .FontName  = "Tahoma"
1674:             .FontSize  = 8
1675:             .Visible   = .T.
1676:         ENDWITH
1677: 
1678:         loc_oPagina.AddObject("lbl_4c_LblSN8", "Label")
1679:         WITH loc_oPagina.lbl_4c_LblSN8
1680:             .Caption   = "[S/N]"
1681:             .Top       = 463
1682:             .Left      = 215
1683:             .Width     = 35
1684:             .Height    = 15
1685:             .FontName  = "Tahoma"
1686:             .FontSize  = 8
1687:             .ForeColor = RGB(90, 90, 90)
1688:             .BackStyle = 0
1689:             .Visible   = .T.
1690:         ENDWITH
1691: 
1692:         *-- OptionGroups coluna esquerda-baixo (left=190)
1693:         loc_oPagina.AddObject("lbl_4c_LblLeProts", "Label")
1694:         WITH loc_oPagina.lbl_4c_LblLeProts
1695:             .Caption   = "Leitura Cheque pelo Protocolo :"
1696:             .Top       = 488
1697:             .Left      = 39
1698:             .Width     = 153
1699:             .Height    = 15
1700:             .FontName  = "Tahoma"
1701:             .FontSize  = 8
1702:             .ForeColor = RGB(90, 90, 90)
1703:             .BackStyle = 0
1704:             .Visible   = .T.
1705:         ENDWITH
1706: 
1707:         loc_oPagina.AddObject("obj_4c_Opt_LeProts", "OptionGroup")
1708:         WITH loc_oPagina.obj_4c_Opt_LeProts
1709:             .ButtonCount = 2
1710:             .Top         = 484
1711:             .Left        = 190
1712:             .Width       = 127
1713:             .Height      = 25
1714:             .BackStyle   = 0
1715:             .BorderStyle = 0
1716:             .Visible     = .T.
1717:         ENDWITH
1718:         WITH loc_oPagina.obj_4c_Opt_LeProts.Buttons(1)
1719:             .Caption   = "Sim"
1720:             .Top       = 5
1721:             .Left      = 5
1722:             .AutoSize  = .T.
1723:             .BackStyle = 0
1724:             .FontName  = "Tahoma"
1725:             .FontSize  = 8
1726:             .ForeColor = RGB(90, 90, 90)
1727:         ENDWITH
1728:         WITH loc_oPagina.obj_4c_Opt_LeProts.Buttons(2)
1729:             .Caption   = "N" + CHR(227) + "o"
1730:             .Top       = 5
1731:             .Left      = 85
1732:             .AutoSize  = .T.
1733:             .BackStyle = 0
1734:             .FontName  = "Tahoma"
1735:             .FontSize  = 8
1736:             .ForeColor = RGB(90, 90, 90)
1737:         ENDWITH
1738: 
1739:         loc_oPagina.AddObject("lbl_4c_LblTpLeit", "Label")
1740:         WITH loc_oPagina.lbl_4c_LblTpLeit
1741:             .Caption   = "Tipo de Leitura de Cheque :"
1742:             .Top       = 514
1743:             .Left      = 57
1744:             .Width     = 135
1745:             .Height    = 15
1746:             .FontName  = "Tahoma"
1747:             .FontSize  = 8
1748:             .ForeColor = RGB(90, 90, 90)
1749:             .BackStyle = 0
1750:             .Visible   = .T.
1751:         ENDWITH
1752: 
1753:         loc_oPagina.AddObject("obj_4c_OptTpLeit", "OptionGroup")
1754:         WITH loc_oPagina.obj_4c_OptTpLeit
1755:             .ButtonCount = 2
1756:             .Top         = 510
1757:             .Left        = 190
1758:             .Width       = 136
1759:             .Height      = 25
1760:             .BackStyle   = 0
1761:             .BorderStyle = 0
1762:             .Visible     = .T.
1763:         ENDWITH
1764:         WITH loc_oPagina.obj_4c_OptTpLeit.Buttons(1)
1765:             .Caption   = "Digita" + CHR(231) + CHR(227) + "o"
1766:             .Top       = 5
1767:             .Left      = 5
1768:             .AutoSize  = .T.
1769:             .BackStyle = 0
1770:             .FontName  = "Tahoma"
1771:             .FontSize  = 8
1772:             .ForeColor = RGB(90, 90, 90)
1773:         ENDWITH
1774:         WITH loc_oPagina.obj_4c_OptTpLeit.Buttons(2)
1775:             .Caption   = "CMC7"
1776:             .Top       = 5
1777:             .Left      = 85
1778:             .AutoSize  = .T.
1779:             .BackStyle = 0
1780:             .FontName  = "Tahoma"
1781:             .FontSize  = 8
1782:             .ForeColor = RGB(90, 90, 90)
1783:         ENDWITH
1784: 
1785:         loc_oPagina.AddObject("lbl_4c_LblGerarq", "Label")
1786:         WITH loc_oPagina.lbl_4c_LblGerarq
1787:             .Caption   = "Gera n" + CHR(186) + " Arquivo :"
1788:             .Top       = 539
1789:             .Left      = 106
1790:             .Width     = 86
1791:             .Height    = 15
1792:             .FontName  = "Tahoma"
1793:             .FontSize  = 8
1794:             .ForeColor = RGB(90, 90, 90)
1795:             .BackStyle = 0
1796:             .Visible   = .T.
1797:         ENDWITH
1798: 
1799:         loc_oPagina.AddObject("obj_4c_Opc_Gerarq", "OptionGroup")
1800:         WITH loc_oPagina.obj_4c_Opc_Gerarq
1801:             .ButtonCount = 2
1802:             .Top         = 535
1803:             .Left        = 190
1804:             .Width       = 127
1805:             .Height      = 25
1806:             .BackStyle   = 0
1807:             .BorderStyle = 0
1808:             .Visible     = .T.
1809:         ENDWITH
1810:         WITH loc_oPagina.obj_4c_Opc_Gerarq.Buttons(1)
1811:             .Caption   = "Sim"
1812:             .Top       = 5
1813:             .Left      = 5
1814:             .AutoSize  = .T.
1815:             .BackStyle = 0
1816:             .FontName  = "Tahoma"
1817:             .FontSize  = 8
1818:             .ForeColor = RGB(90, 90, 90)
1819:         ENDWITH
1820:         WITH loc_oPagina.obj_4c_Opc_Gerarq.Buttons(2)
1821:             .Caption   = "N" + CHR(227) + "o"
1822:             .Top       = 5
1823:             .Left      = 85
1824:             .AutoSize  = .T.
1825:             .BackStyle = 0
1826:             .FontName  = "Tahoma"
1827:             .FontSize  = 8
1828:             .ForeColor = RGB(90, 90, 90)
1829:         ENDWITH
1830: 
1831:         loc_oPagina.AddObject("lbl_4c_LblAnaSit", "Label")
1832:         WITH loc_oPagina.lbl_4c_LblAnaSit
1833:             .Caption   = "Cons. Global de Situa" + CHR(231) + CHR(227) + "o :"
1834:             .Top       = 565
1835:             .Left      = 64
1836:             .Width     = 128
1837:             .Height    = 15
1838:             .FontName  = "Tahoma"
1839:             .FontSize  = 8
1840:             .ForeColor = RGB(90, 90, 90)
1841:             .BackStyle = 0
1842:             .Visible   = .T.
1843:         ENDWITH
1844: 
1845:         loc_oPagina.AddObject("obj_4c_Opc_gensit", "OptionGroup")
1846:         WITH loc_oPagina.obj_4c_Opc_gensit
1847:             .ButtonCount = 2
1848:             .Top         = 561
1849:             .Left        = 190
1850:             .Width       = 127
1851:             .Height      = 25
1852:             .BackStyle   = 0
1853:             .BorderStyle = 0
1854:             .Visible     = .T.
1855:         ENDWITH
1856:         WITH loc_oPagina.obj_4c_Opc_gensit.Buttons(1)
1857:             .Caption   = "Sim"
1858:             .Top       = 5
1859:             .Left      = 5
1860:             .AutoSize  = .T.
1861:             .BackStyle = 0
1862:             .FontName  = "Tahoma"
1863:             .FontSize  = 8
1864:             .ForeColor = RGB(90, 90, 90)
1865:         ENDWITH
1866:         WITH loc_oPagina.obj_4c_Opc_gensit.Buttons(2)
1867:             .Caption   = "N" + CHR(227) + "o"
1868:             .Top       = 5
1869:             .Left      = 85
1870:             .AutoSize  = .T.
1871:             .BackStyle = 0
1872:             .FontName  = "Tahoma"
1873:             .FontSize  = 8
1874:             .ForeColor = RGB(90, 90, 90)
1875:         ENDWITH
1876: 
1877:         loc_oPagina.AddObject("lbl_4c_LblAltDados", "Label")
1878:         WITH loc_oPagina.lbl_4c_LblAltDados
1879:             .Caption   = "Altera Dados :"
1880:             .Top       = 590
1881:             .Left      = 121
1882:             .Width     = 71
1883:             .Height    = 15
1884:             .FontName  = "Tahoma"
1885:             .FontSize  = 8
1886:             .ForeColor = RGB(90, 90, 90)
1887:             .BackStyle = 0
1888:             .Visible   = .T.
1889:         ENDWITH
1890: 
1891:         loc_oPagina.AddObject("obj_4c_AltDados", "OptionGroup")
1892:         WITH loc_oPagina.obj_4c_AltDados
1893:             .ButtonCount = 2
1894:             .Top         = 586
1895:             .Left        = 190
1896:             .Width       = 127
1897:             .Height      = 25
1898:             .BackStyle   = 0
1899:             .BorderStyle = 0
1900:             .Visible     = .T.
1901:         ENDWITH
1902:         WITH loc_oPagina.obj_4c_AltDados.Buttons(1)
1903:             .Caption   = "Sim"
1904:             .Top       = 5
1905:             .Left      = 5
1906:             .AutoSize  = .T.
1907:             .BackStyle = 0
1908:             .FontName  = "Tahoma"
1909:             .FontSize  = 8
1910:             .ForeColor = RGB(90, 90, 90)
1911:         ENDWITH
1912:         WITH loc_oPagina.obj_4c_AltDados.Buttons(2)
1913:             .Caption   = "N" + CHR(227) + "o"
1914:             .Top       = 5
1915:             .Left      = 85
1916:             .AutoSize  = .T.
1917:             .BackStyle = 0
1918:             .FontName  = "Tahoma"
1919:             .FontSize  = 8
1920:             .ForeColor = RGB(90, 90, 90)
1921:         ENDWITH
1922: 
1923:         *-- Coluna central (left~512): flags S/N emissao
1924:         loc_oPagina.AddObject("lbl_4c_LblEmiInd", "Label")
1925:         WITH loc_oPagina.lbl_4c_LblEmiInd
1926:             .Caption   = "Emissor Individual :"
1927:             .Top       = 288
1928:             .Left      = 415
1929:             .Width     = 93
1930:             .Height    = 15
1931:             .FontName  = "Tahoma"
1932:             .FontSize  = 8
1933:             .ForeColor = RGB(90, 90, 90)
1934:             .BackStyle = 0
1935:             .Visible   = .T.
1936:         ENDWITH
1937: 
1938:         loc_oPagina.AddObject("txt_4c_EmiInd", "TextBox")
1939:         WITH loc_oPagina.txt_4c_EmiInd
1940:             .Value     = ""
1941:             .Top       = 284
1942:             .Left      = 512
1943:             .Width     = 18
1944:             .Height    = 23
1945:             .MaxLength = 1
1946:             .FontName  = "Tahoma"
1947:             .FontSize  = 8
1948:             .Visible   = .T.
1949:         ENDWITH
1950: 
1951:         loc_oPagina.AddObject("lbl_4c_LblSNM1", "Label")
1952:         WITH loc_oPagina.lbl_4c_LblSNM1
1953:             .Caption   = "[S/N]"
1954:             .Top       = 288
1955:             .Left      = 533
1956:             .Width     = 35
1957:             .Height    = 15
1958:             .FontName  = "Tahoma"
1959:             .FontSize  = 8
1960:             .ForeColor = RGB(90, 90, 90)
1961:             .BackStyle = 0
1962:             .Visible   = .T.
1963:         ENDWITH
1964: 
1965:         loc_oPagina.AddObject("lbl_4c_LblCademis", "Label")
1966:         WITH loc_oPagina.lbl_4c_LblCademis
1967:             .Caption   = "Cadastra Emissor :"
1968:             .Top       = 313
1969:             .Left      = 417
1970:             .Width     = 91
1971:             .Height    = 15
1972:             .FontName  = "Tahoma"
1973:             .FontSize  = 8
1974:             .ForeColor = RGB(90, 90, 90)
1975:             .BackStyle = 0
1976:             .Visible   = .T.
1977:         ENDWITH
1978: 
1979:         loc_oPagina.AddObject("txt_4c_Cademis", "TextBox")
1980:         WITH loc_oPagina.txt_4c_Cademis
1981:             .Value     = ""
1982:             .Top       = 309
1983:             .Left      = 512
1984:             .Width     = 18
1985:             .Height    = 23
1986:             .MaxLength = 1
1987:             .FontName  = "Tahoma"
1988:             .FontSize  = 8
1989:             .Visible   = .T.
1990:         ENDWITH
1991: 
1992:         loc_oPagina.AddObject("lbl_4c_LblSNM2", "Label")
1993:         WITH loc_oPagina.lbl_4c_LblSNM2
1994:             .Caption   = "[S/N]"
1995:             .Top       = 313
1996:             .Left      = 533
1997:             .Width     = 35
1998:             .Height    = 15
1999:             .FontName  = "Tahoma"
2000:             .FontSize  = 8
2001:             .ForeColor = RGB(90, 90, 90)
2002:             .BackStyle = 0
2003:             .Visible   = .T.
2004:         ENDWITH
2005: 
2006:         loc_oPagina.AddObject("lbl_4c_LblEmpInd", "Label")
2007:         WITH loc_oPagina.lbl_4c_LblEmpInd
2008:             .Caption   = "Empresa Individual :"
2009:             .Top       = 338
2010:             .Left      = 410
2011:             .Width     = 100
2012:             .Height    = 15
2013:             .FontName  = "Tahoma"
2014:             .FontSize  = 8
2015:             .ForeColor = RGB(90, 90, 90)
2016:             .BackStyle = 0
2017:             .Visible   = .T.
2018:         ENDWITH
2019: 
2020:         loc_oPagina.AddObject("txt_4c_EmpInd", "TextBox")
2021:         WITH loc_oPagina.txt_4c_EmpInd
2022:             .Value     = ""
2023:             .Top       = 334
2024:             .Left      = 512
2025:             .Width     = 18
2026:             .Height    = 23
2027:             .MaxLength = 1
2028:             .FontName  = "Tahoma"
2029:             .FontSize  = 8
2030:             .Visible   = .T.
2031:         ENDWITH
2032: 
2033:         loc_oPagina.AddObject("lbl_4c_LblSNM3", "Label")
2034:         WITH loc_oPagina.lbl_4c_LblSNM3
2035:             .Caption   = "[S/N]"
2036:             .Top       = 338
2037:             .Left      = 533
2038:             .Width     = 35
2039:             .Height    = 15
2040:             .FontName  = "Tahoma"
2041:             .FontSize  = 8
2042:             .ForeColor = RGB(90, 90, 90)
2043:             .BackStyle = 0
2044:             .Visible   = .T.
2045:         ENDWITH
2046: 
2047:         loc_oPagina.AddObject("lbl_4c_LblEmiProts", "Label")
2048:         WITH loc_oPagina.lbl_4c_LblEmiProts
2049:             .Caption   = "Emite Protocolo :"
2050:             .Top       = 363
2051:             .Left      = 426
2052:             .Width     = 83
2053:             .Height    = 15
2054:             .FontName  = "Tahoma"
2055:             .FontSize  = 8
2056:             .ForeColor = RGB(90, 90, 90)
2057:             .BackStyle = 0
2058:             .Visible   = .T.
2059:         ENDWITH
2060: 
2061:         loc_oPagina.AddObject("txt_4c_EmiProts", "TextBox")
2062:         WITH loc_oPagina.txt_4c_EmiProts
2063:             .Value     = ""
2064:             .Top       = 359
2065:             .Left      = 512
2066:             .Width     = 18
2067:             .Height    = 23
2068:             .MaxLength = 1
2069:             .FontName  = "Tahoma"
2070:             .FontSize  = 8
2071:             .Visible   = .T.
2072:         ENDWITH
2073: 
2074:         loc_oPagina.AddObject("lbl_4c_LblSNM4", "Label")
2075:         WITH loc_oPagina.lbl_4c_LblSNM4
2076:             .Caption   = "[S/N]"
2077:             .Top       = 363
2078:             .Left      = 533
2079:             .Width     = 35
2080:             .Height    = 15
2081:             .FontName  = "Tahoma"
2082:             .FontSize  = 8
2083:             .ForeColor = RGB(90, 90, 90)
2084:             .BackStyle = 0
2085:             .Visible   = .T.
2086:         ENDWITH
2087: 
2088:         loc_oPagina.AddObject("lbl_4c_LblDevolvido", "Label")
2089:         WITH loc_oPagina.lbl_4c_LblDevolvido
2090:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o de Devolvido :"
2091:             .Top       = 388
2092:             .Left      = 388
2093:             .Width     = 121
2094:             .Height    = 15
2095:             .FontName  = "Tahoma"
2096:             .FontSize  = 8
2097:             .ForeColor = RGB(90, 90, 90)
2098:             .BackStyle = 0
2099:             .Visible   = .T.
2100:         ENDWITH
2101: 
2102:         loc_oPagina.AddObject("txt_4c_Devolvido", "TextBox")
2103:         WITH loc_oPagina.txt_4c_Devolvido
2104:             .Value     = ""
2105:             .Top       = 384
2106:             .Left      = 512
2107:             .Width     = 18
2108:             .Height    = 23
2109:             .MaxLength = 1
2110:             .FontName  = "Tahoma"
2111:             .FontSize  = 8
2112:             .Visible   = .T.
2113:         ENDWITH
2114: 
2115:         loc_oPagina.AddObject("lbl_4c_LblSNM5", "Label")
2116:         WITH loc_oPagina.lbl_4c_LblSNM5
2117:             .Caption   = "[S/N]"
2118:             .Top       = 388
2119:             .Left      = 533
2120:             .Width     = 35
2121:             .Height    = 15
2122:             .FontName  = "Tahoma"
2123:             .FontSize  = 8
2124:             .ForeColor = RGB(90, 90, 90)
2125:             .BackStyle = 0
2126:             .Visible   = .T.
2127:         ENDWITH
2128: 
2129:         loc_oPagina.AddObject("lbl_4c_LblAlinea", "Label")
2130:         WITH loc_oPagina.lbl_4c_LblAlinea
2131:             .Caption   = "Tem Alinea :"
2132:             .Top       = 413
2133:             .Left      = 448
2134:             .Width     = 61
2135:             .Height    = 15
2136:             .FontName  = "Tahoma"
2137:             .FontSize  = 8
2138:             .ForeColor = RGB(90, 90, 90)
2139:             .BackStyle = 0
2140:             .Visible   = .T.
2141:         ENDWITH
2142: 
2143:         loc_oPagina.AddObject("txt_4c_Alinea", "TextBox")
2144:         WITH loc_oPagina.txt_4c_Alinea
2145:             .Value     = ""
2146:             .Top       = 409
2147:             .Left      = 512
2148:             .Width     = 18
2149:             .Height    = 23
2150:             .MaxLength = 1
2151:             .FontName  = "Tahoma"
2152:             .FontSize  = 8
2153:             .Visible   = .T.
2154:         ENDWITH
2155: 
2156:         loc_oPagina.AddObject("lbl_4c_LblSNM6", "Label")
2157:         WITH loc_oPagina.lbl_4c_LblSNM6
2158:             .Caption   = "[S/N]"
2159:             .Top       = 413
2160:             .Left      = 533
2161:             .Width     = 35
2162:             .Height    = 15
2163:             .FontName  = "Tahoma"
2164:             .FontSize  = 8
2165:             .ForeColor = RGB(90, 90, 90)
2166:             .BackStyle = 0
2167:             .Visible   = .T.
2168:         ENDWITH
2169: 
2170:         loc_oPagina.AddObject("lbl_4c_LblEmiCarta", "Label")
2171:         WITH loc_oPagina.lbl_4c_LblEmiCarta
2172:             .Caption   = "Emite Carta :"
2173:             .Top       = 438
2174:             .Left      = 444
2175:             .Width     = 65
2176:             .Height    = 15
2177:             .FontName  = "Tahoma"
2178:             .FontSize  = 8
2179:             .ForeColor = RGB(90, 90, 90)
2180:             .BackStyle = 0
2181:             .Visible   = .T.
2182:         ENDWITH
2183: 
2184:         loc_oPagina.AddObject("txt_4c_EmiCarta", "TextBox")
2185:         WITH loc_oPagina.txt_4c_EmiCarta
2186:             .Value     = ""
2187:             .Top       = 434
2188:             .Left      = 512
2189:             .Width     = 18
2190:             .Height    = 23
2191:             .MaxLength = 1
2192:             .FontName  = "Tahoma"
2193:             .FontSize  = 8
2194:             .Visible   = .T.
2195:         ENDWITH
2196: 
2197:         loc_oPagina.AddObject("lbl_4c_LblSNM7", "Label")
2198:         WITH loc_oPagina.lbl_4c_LblSNM7
2199:             .Caption   = "[S/N]"
2200:             .Top       = 438
2201:             .Left      = 533
2202:             .Width     = 35
2203:             .Height    = 15
2204:             .FontName  = "Tahoma"
2205:             .FontSize  = 8
2206:             .ForeColor = RGB(90, 90, 90)
2207:             .BackStyle = 0
2208:             .Visible   = .T.
2209:         ENDWITH
2210: 
2211:         loc_oPagina.AddObject("lbl_4c_LblConsolida", "Label")
2212:         WITH loc_oPagina.lbl_4c_LblConsolida
2213:             .Caption   = "Consolida Lan" + CHR(231) + "amentos :"
2214:             .Top       = 463
2215:             .Left      = 388
2216:             .Width     = 121
2217:             .Height    = 15
2218:             .FontName  = "Tahoma"
2219:             .FontSize  = 8
2220:             .ForeColor = RGB(90, 90, 90)
2221:             .BackStyle = 0
2222:             .Visible   = .T.
2223:         ENDWITH
2224: 
2225:         loc_oPagina.AddObject("txt_4c_Consolida", "TextBox")
2226:         WITH loc_oPagina.txt_4c_Consolida
2227:             .Value     = ""
2228:             .Top       = 459
2229:             .Left      = 512
2230:             .Width     = 18
2231:             .Height    = 23
2232:             .MaxLength = 1
2233:             .FontName  = "Tahoma"
2234:             .FontSize  = 8
2235:             .Visible   = .T.
2236:         ENDWITH
2237: 
2238:         loc_oPagina.AddObject("lbl_4c_LblSNM8", "Label")
2239:         WITH loc_oPagina.lbl_4c_LblSNM8
2240:             .Caption   = "[S/N]"
2241:             .Top       = 463
2242:             .Left      = 533
2243:             .Width     = 35
2244:             .Height    = 15
2245:             .FontName  = "Tahoma"
2246:             .FontSize  = 8
2247:             .ForeColor = RGB(90, 90, 90)
2248:             .BackStyle = 0
2249:             .Visible   = .T.
2250:         ENDWITH
2251: 
2252:         loc_oPagina.AddObject("lbl_4c_LblObs", "Label")
2253:         WITH loc_oPagina.lbl_4c_LblObs
2254:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
2255:             .Top       = 488
2256:             .Left      = 442
2257:             .Width     = 68
2258:             .Height    = 15
2259:             .FontName  = "Tahoma"
2260:             .FontSize  = 8
2261:             .ForeColor = RGB(90, 90, 90)
2262:             .BackStyle = 0
2263:             .Visible   = .T.
2264:         ENDWITH
2265: 
2266:         loc_oPagina.AddObject("txt_4c_Obs", "TextBox")
2267:         WITH loc_oPagina.txt_4c_Obs
2268:             .Value     = ""
2269:             .Top       = 484
2270:             .Left      = 512
2271:             .Width     = 18
2272:             .Height    = 23
2273:             .MaxLength = 1
2274:             .FontName  = "Tahoma"
2275:             .FontSize  = 8
2276:             .Visible   = .T.
2277:         ENDWITH
2278: 
2279:         loc_oPagina.AddObject("lbl_4c_LblSNC", "Label")
2280:         WITH loc_oPagina.lbl_4c_LblSNC
2281:             .Caption   = "[S/N/C]"
2282:             .Top       = 488
2283:             .Left      = 533
2284:             .Width     = 40
2285:             .Height    = 15
2286:             .FontName  = "Tahoma"
2287:             .FontSize  = 8
2288:             .ForeColor = RGB(90, 90, 90)
2289:             .BackStyle = 0
2290:             .Visible   = .T.
2291:         ENDWITH
2292: 
2293:         *-- OptionGroups coluna central-baixo (left=506)
2294:         loc_oPagina.AddObject("lbl_4c_LblProrroga", "Label")
2295:         WITH loc_oPagina.lbl_4c_LblProrroga
2296:             .Caption   = "Prorrogar Tipo (CR) :"
2297:             .Top       = 514
2298:             .Left      = 406
2299:             .Width     = 103
2300:             .Height    = 15
2301:             .FontName  = "Tahoma"
2302:             .FontSize  = 8
2303:             .ForeColor = RGB(90, 90, 90)
2304:             .BackStyle = 0
2305:             .Visible   = .T.
2306:         ENDWITH
2307: 
2308:         loc_oPagina.AddObject("obj_4c_Prorroga", "OptionGroup")
2309:         WITH loc_oPagina.obj_4c_Prorroga
2310:             .ButtonCount = 2
2311:             .Top         = 510
2312:             .Left        = 506
2313:             .Width       = 127
2314:             .Height      = 25
2315:             .BackStyle   = 0
2316:             .BorderStyle = 0
2317:             .Visible     = .T.
2318:         ENDWITH
2319:         WITH loc_oPagina.obj_4c_Prorroga.Buttons(1)
2320:             .Caption   = "Sim"
2321:             .Top       = 5
2322:             .Left      = 5
2323:             .AutoSize  = .T.
2324:             .BackStyle = 0
2325:             .FontName  = "Tahoma"
2326:             .FontSize  = 8
2327:             .ForeColor = RGB(90, 90, 90)
2328:         ENDWITH
2329:         WITH loc_oPagina.obj_4c_Prorroga.Buttons(2)
2330:             .Caption   = "N" + CHR(227) + "o"
2331:             .Top       = 5
2332:             .Left      = 85
2333:             .AutoSize  = .T.
2334:             .BackStyle = 0
2335:             .FontName  = "Tahoma"
2336:             .FontSize  = 8
2337:             .ForeColor = RGB(90, 90, 90)
2338:         ENDWITH
2339: 
2340:         loc_oPagina.AddObject("lbl_4c_LblCarteira", "Label")
2341:         WITH loc_oPagina.lbl_4c_LblCarteira
2342:             .Caption   = "Permitir Carteira Tipo (CR) :"
2343:             .Top       = 539
2344:             .Left      = 374
2345:             .Width     = 135
2346:             .Height    = 15
2347:             .FontName  = "Tahoma"
2348:             .FontSize  = 8
2349:             .ForeColor = RGB(90, 90, 90)
2350:             .BackStyle = 0
2351:             .Visible   = .T.
2352:         ENDWITH
2353: 
2354:         loc_oPagina.AddObject("obj_4c_Carteira", "OptionGroup")
2355:         WITH loc_oPagina.obj_4c_Carteira
2356:             .ButtonCount = 2
2357:             .Top         = 535
2358:             .Left        = 506
2359:             .Width       = 127
2360:             .Height      = 25
2361:             .BackStyle   = 0
2362:             .BorderStyle = 0
2363:             .Visible     = .T.
2364:         ENDWITH
2365:         WITH loc_oPagina.obj_4c_Carteira.Buttons(1)
2366:             .Caption   = "Sim"
2367:             .Top       = 5
2368:             .Left      = 5
2369:             .AutoSize  = .T.
2370:             .BackStyle = 0
2371:             .FontName  = "Tahoma"
2372:             .FontSize  = 8
2373:             .ForeColor = RGB(90, 90, 90)
2374:         ENDWITH
2375:         WITH loc_oPagina.obj_4c_Carteira.Buttons(2)
2376:             .Caption   = "N" + CHR(227) + "o"
2377:             .Top       = 5
2378:             .Left      = 85
2379:             .AutoSize  = .T.
2380:             .BackStyle = 0
2381:             .FontName  = "Tahoma"
2382:             .FontSize  = 8
2383:             .ForeColor = RGB(90, 90, 90)
2384:         ENDWITH
2385: 
2386:         loc_oPagina.AddObject("lbl_4c_LblVencUtil", "Label")
2387:         WITH loc_oPagina.lbl_4c_LblVencUtil
2388:             .Caption   = "Vencimento dia " + CHR(250) + "til :"
2389:             .Top       = 561
2390:             .Left      = 411
2391:             .Width     = 98
2392:             .Height    = 15
2393:             .FontName  = "Tahoma"
2394:             .FontSize  = 8
2395:             .ForeColor = RGB(90, 90, 90)
2396:             .BackStyle = 0
2397:             .Visible   = .T.
2398:         ENDWITH
2399: 
2400:         loc_oPagina.AddObject("obj_4c_VencUtil", "OptionGroup")
2401:         WITH loc_oPagina.obj_4c_VencUtil
2402:             .ButtonCount = 2
2403:             .Top         = 557
2404:             .Left        = 506
2405:             .Width       = 127
2406:             .Height      = 25
2407:             .BackStyle   = 0
2408:             .BorderStyle = 0
2409:             .Visible     = .T.
2410:         ENDWITH
2411:         WITH loc_oPagina.obj_4c_VencUtil.Buttons(1)
2412:             .Caption   = "Sim"
2413:             .Top       = 5
2414:             .Left      = 5
2415:             .AutoSize  = .T.
2416:             .BackStyle = 0
2417:             .FontName  = "Tahoma"
2418:             .FontSize  = 8
2419:             .ForeColor = RGB(90, 90, 90)
2420:         ENDWITH
2421:         WITH loc_oPagina.obj_4c_VencUtil.Buttons(2)
2422:             .Caption   = "N" + CHR(227) + "o"
2423:             .Top       = 5
2424:             .Left      = 85
2425:             .AutoSize  = .T.
2426:             .BackStyle = 0
2427:             .FontName  = "Tahoma"
2428:             .FontSize  = 8
2429:             .ForeColor = RGB(90, 90, 90)
2430:         ENDWITH
2431: 
2432:         *-- Area direita (left=764): Data emissao, Pend.Fin., Comissao, Moeda
2433:         loc_oPagina.AddObject("lbl_4c_LblDtEmiss", "Label")
2434:         WITH loc_oPagina.lbl_4c_LblDtEmiss
2435:             .Caption   = "Data de Emiss" + CHR(227) + "o Padr" + CHR(227) + "o :"
2436:             .Top       = 286
2437:             .Left      = 641
2438:             .Width     = 125
2439:             .Height    = 15
2440:             .FontName  = "Tahoma"
2441:             .FontSize  = 8
2442:             .ForeColor = RGB(90, 90, 90)
2443:             .BackStyle = 0
2444:             .Visible   = .T.
2445:         ENDWITH
2446: 
2447:         loc_oPagina.AddObject("obj_4c_Opt_DtEmiss", "OptionGroup")
2448:         WITH loc_oPagina.obj_4c_Opt_DtEmiss
2449:             .ButtonCount = 3
2450:             .Top         = 281
2451:             .Left        = 764
2452:             .Width       = 124
2453:             .Height      = 66
2454:             .BackStyle   = 0
2455:             .BorderStyle = 0
2456:             .Visible     = .T.
2457:         ENDWITH
2458:         WITH loc_oPagina.obj_4c_Opt_DtEmiss.Buttons(1)
2459:             .Caption   = "Data de Entrada"
2460:             .Top       = 5
2461:             .Left      = 5
2462:             .AutoSize  = .T.
2463:             .BackStyle = 0
2464:             .FontName  = "Tahoma"
2465:             .FontSize  = 8
2466:             .ForeColor = RGB(90, 90, 90)
2467:         ENDWITH
2468:         WITH loc_oPagina.obj_4c_Opt_DtEmiss.Buttons(2)
2469:             .Caption   = "Data de Vencimento"
2470:             .Top       = 25
2471:             .Left      = 5
2472:             .AutoSize  = .T.
2473:             .BackStyle = 0
2474:             .FontName  = "Tahoma"
2475:             .FontSize  = 8
2476:             .ForeColor = RGB(90, 90, 90)
2477:         ENDWITH
2478:         WITH loc_oPagina.obj_4c_Opt_DtEmiss.Buttons(3)
2479:             .Caption   = "Nenhum"
2480:             .Top       = 44
2481:             .Left      = 5
2482:             .AutoSize  = .F.
2483:             .Width     = 66
2484:             .Height    = 17
2485:             .BackStyle = 0
2486:             .FontName  = "Tahoma"
2487:             .FontSize  = 8
2488:             .ForeColor = RGB(90, 90, 90)
2489:         ENDWITH
2490: 
2491:         loc_oPagina.AddObject("lbl_4c_LblPenFin", "Label")
2492:         WITH loc_oPagina.lbl_4c_LblPenFin
2493:             .Caption   = "Pend" + CHR(234) + "ncias Financeiras :"
2494:             .Top       = 352
2495:             .Left      = 646
2496:             .Width     = 120
2497:             .Height    = 15
2498:             .FontName  = "Tahoma"
2499:             .FontSize  = 8
2500:             .ForeColor = RGB(90, 90, 90)
2501:             .BackStyle = 0
2502:             .Visible   = .T.
2503:         ENDWITH
2504: 
2505:         loc_oPagina.AddObject("obj_4c_Opc_penfin", "OptionGroup")
2506:         WITH loc_oPagina.obj_4c_Opc_penfin
2507:             .ButtonCount = 3
2508:             .Top         = 348
2509:             .Left        = 764
2510:             .Width       = 218
2511:             .Height      = 25
2512:             .BackStyle   = 0
2513:             .BorderStyle = 0
2514:             .Visible     = .T.
2515:         ENDWITH
2516:         WITH loc_oPagina.obj_4c_Opc_penfin.Buttons(1)
2517:             .Caption   = "Incluir"
2518:             .Top       = 5
2519:             .Left      = 5
2520:             .AutoSize  = .T.
2521:             .BackStyle = 0
2522:             .FontName  = "Tahoma"
2523:             .FontSize  = 8
2524:             .ForeColor = RGB(90, 90, 90)
2525:         ENDWITH
2526:         WITH loc_oPagina.obj_4c_Opc_penfin.Buttons(2)
2527:             .Caption   = "Excluir"
2528:             .Top       = 5
2529:             .Left      = 74
2530:             .AutoSize  = .T.
2531:             .BackStyle = 0
2532:             .FontName  = "Tahoma"
2533:             .FontSize  = 8
2534:             .ForeColor = RGB(90, 90, 90)
2535:         ENDWITH
2536:         WITH loc_oPagina.obj_4c_Opc_penfin.Buttons(3)
2537:             .Caption   = "Nenhuma"
2538:             .Top       = 5
2539:             .Left      = 150
2540:             .AutoSize  = .T.
2541:             .BackStyle = 0
2542:             .FontName  = "Tahoma"
2543:             .FontSize  = 8
2544:             .ForeColor = RGB(90, 90, 90)
2545:         ENDWITH
2546: 
2547:         loc_oPagina.AddObject("lbl_4c_LblComiss", "Label")
2548:         WITH loc_oPagina.lbl_4c_LblComiss
2549:             .Caption   = "C" + CHR(225) + "lculo de Comiss" + CHR(227) + "o :"
2550:             .Top       = 377
2551:             .Left      = 660
2552:             .Width     = 106
2553:             .Height    = 15
2554:             .FontName  = "Tahoma"
2555:             .FontSize  = 8
2556:             .ForeColor = RGB(90, 90, 90)
2557:             .BackStyle = 0
2558:             .Visible   = .T.
2559:         ENDWITH
2560: 
2561:         loc_oPagina.AddObject("obj_4c_OpComiss", "OptionGroup")
2562:         WITH loc_oPagina.obj_4c_OpComiss
2563:             .ButtonCount = 3
2564:             .Top         = 373
2565:             .Left        = 764
2566:             .Width       = 219
2567:             .Height      = 25
2568:             .BackStyle   = 0
2569:             .BorderStyle = 0
2570:             .Visible     = .T.
2571:         ENDWITH
2572:         WITH loc_oPagina.obj_4c_OpComiss.Buttons(1)
2573:             .Caption   = "Nenhum"
2574:             .Top       = 5
2575:             .Left      = 5
2576:             .AutoSize  = .T.
2577:             .BackStyle = 0
2578:             .FontName  = "Tahoma"
2579:             .FontSize  = 8
2580:             .ForeColor = RGB(90, 90, 90)
2581:         ENDWITH
2582:         WITH loc_oPagina.obj_4c_OpComiss.Buttons(2)
2583:             .Caption   = "Desconta"
2584:             .Top       = 5
2585:             .Left      = 74
2586:             .AutoSize  = .T.
2587:             .BackStyle = 0
2588:             .FontName  = "Tahoma"
2589:             .FontSize  = 8
2590:             .ForeColor = RGB(90, 90, 90)
2591:         ENDWITH
2592:         WITH loc_oPagina.obj_4c_OpComiss.Buttons(3)
2593:             .Caption   = "Recupera"
2594:             .Top       = 5
2595:             .Left      = 148
2596:             .AutoSize  = .T.
2597:             .BackStyle = 0
2598:             .FontName  = "Tahoma"
2599:             .FontSize  = 8
2600:             .ForeColor = RGB(90, 90, 90)
2601:         ENDWITH
2602: 
2603:         loc_oPagina.AddObject("lbl_4c_LblDesconto", "Label")
2604:         WITH loc_oPagina.lbl_4c_LblDesconto
2605:             .Caption   = "Percentual Comiss" + CHR(227) + "o :"
2606:             .Top       = 401
2607:             .Left      = 658
2608:             .Width     = 111
2609:             .Height    = 15
2610:             .FontName  = "Tahoma"
2611:             .FontSize  = 8
2612:             .ForeColor = RGB(90, 90, 90)
2613:             .BackStyle = 0
2614:             .Visible   = .T.
2615:         ENDWITH
2616: 
2617:         loc_oPagina.AddObject("txt_4c_Desconto", "TextBox")
2618:         WITH loc_oPagina.txt_4c_Desconto
2619:             .Value     = 0
2620:             .Top       = 397
2621:             .Left      = 771
2622:             .Width     = 52
2623:             .Height    = 23
2624:             .FontName  = "Tahoma"
2625:             .FontSize  = 8
2626:             .Visible   = .T.
2627:         ENDWITH
2628: 
2629:         loc_oPagina.AddObject("lbl_4c_LblMoeda", "Label")
2630:         WITH loc_oPagina.lbl_4c_LblMoeda
2631:             .Caption   = "Moeda :"
2632:             .Top       = 427
2633:             .Left      = 725
2634:             .Width     = 44
2635:             .Height    = 15
2636:             .FontName  = "Tahoma"
2637:             .FontSize  = 8
2638:             .ForeColor = RGB(90, 90, 90)
2639:             .BackStyle = 0
2640:             .Visible   = .T.
2641:         ENDWITH
2642: 
2643:         loc_oPagina.AddObject("txt_4c_Moeda", "TextBox")
2644:         WITH loc_oPagina.txt_4c_Moeda
2645:             .Value     = ""
2646:             .Top       = 422
2647:             .Left      = 771
2648:             .Width     = 32
2649:             .Height    = 23
2650:             .MaxLength = 3
2651:             .FontName  = "Tahoma"
2652:             .FontSize  = 8
2653:             .Visible   = .T.
2654:         ENDWITH
2655: 
2656:         *-- Grupo Terceiro (fundo da pagina)
2657:         loc_oPagina.AddObject("lbl_4c_LblGrupoT", "Label")
2658:         WITH loc_oPagina.lbl_4c_LblGrupoT
2659:             .Caption   = "Grupo Terceiro :"
2660:             .Top       = 608
2661:             .Left      = 524
2662:             .Width     = 94
2663:             .Height    = 15
2664:             .FontName  = "Tahoma"
2665:             .FontSize  = 8
2666:             .ForeColor = RGB(90, 90, 90)
2667:             .BackStyle = 0
2668:             .Visible   = .T.
2669:         ENDWITH
2670: 
2671:         loc_oPagina.AddObject("txt_4c_GrupoT", "TextBox")
2672:         WITH loc_oPagina.txt_4c_GrupoT
2673:             .Value     = ""
2674:             .Top       = 604
2675:             .Left      = 621
2676:             .Width     = 79
2677:             .Height    = 23
2678:             .MaxLength = 10
2679:             .FontName  = "Tahoma"
2680:             .FontSize  = 8
2681:             .Visible   = .T.
2682:         ENDWITH
2683: 
2684:         loc_oPagina.AddObject("txt_4c_DGrupoT", "TextBox")
2685:         WITH loc_oPagina.txt_4c_DGrupoT
2686:             .Value     = ""
2687:             .Top       = 604
2688:             .Left      = 701
2689:             .Width     = 290
2690:             .Height    = 23
2691:             .ReadOnly  = .T.
2692:             .FontName  = "Tahoma"
2693:             .FontSize  = 8
2694:             .BackColor = RGB(240, 240, 240)
2695:             .Visible   = .T.
2696:         ENDWITH
2697: 
2698:         *-- BtnCarta: Botao para acessar SigOpCoc (left=569, top=434)
2699:         loc_oPagina.AddObject("cmd_4c_BtnCarta", "CommandButton")
2700:         WITH loc_oPagina.cmd_4c_BtnCarta
2701:             .Caption     = "..."
2702:             .Top         = 434
2703:             .Left        = 569
2704:             .Width       = 23
2705:             .Height      = 23
2706:             .FontName    = "Tahoma"
2707:             .FontSize    = 8
2708:             .BackColor   = RGB(255, 255, 255)
2709:             .ForeColor   = RGB(90, 90, 90)
2710:             .Themes      = .F.
2711:             .SpecialEffect = 0
2712:             .Enabled     = .F.
2713:             .Visible     = .T.
2714:         ENDWITH
2715:         BINDEVENT(loc_oPagina.cmd_4c_BtnCarta, "Click", THIS, "BtnCartaClick")
2716: 
2717:         *-- BINDEVENTs para controles da secao 2
2718:         BINDEVENT(loc_oPagina.txt_4c_EmiCarta, "InteractiveChange", THIS, "AtualizarEstadoCarta")
2719:         BINDEVENT(loc_oPagina.txt_4c_Moeda,    "KeyPress",         THIS, "ValidarMoedas")
2720:         BINDEVENT(loc_oPagina.txt_4c_GrupoT,   "KeyPress",         THIS, "ValidarGrupoT")
2721:         BINDEVENT(loc_oPagina.txt_4c_DGrupoT,  "KeyPress",         THIS, "ValidarDescGrupoT")
2722: 
2723:         *-- Linha separadora Line3 (fundo direito)
2724:         loc_oPagina.AddObject("lin_4c_Line3", "Shape")
2725:         WITH loc_oPagina.lin_4c_Line3
2726:             .Top         = 594
2727:             .Left        = 527
2728:             .Width       = 466
2729:             .Height      = 2
2730:             .BackColor   = RGB(90, 90, 90)
2731:             .BackStyle   = 1
2732:             .BorderStyle = 0

*-- Linhas 2757 a 2768:
2757:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.GrupoOs"
2758: 
2759:                 *-- Reconfigurar cabecalhos apos RecordSource (VFP reseta Headers)
2760:                 loc_oGrid.Column1.Header1.Caption = "Movimento"
2761:                 loc_oGrid.Column2.Header1.Caption = "Tipo"
2762:                 loc_oGrid.Column3.Header1.Caption = "Mv. Anterior"
2763:                 loc_oGrid.Column4.Header1.Caption = "Grupo/Ori"
2764: 
2765:                 loc_oGrid.Column1.Width = 140
2766:                 loc_oGrid.Column2.Width = 60
2767:                 loc_oGrid.Column3.Width = 140
2768:                 loc_oGrid.Column4.Width = 80

*-- Linhas 3035 a 3046:
3035:         ENDIF
3036: 
3037:         IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 4)
3038:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
3039:         ENDIF
3040:         IF PEMSTATUS(loc_oPg2, "chk_4c_Fwcheckbox1", 4)
3041:             loc_oPg2.chk_4c_Fwcheckbox1.Value = 0
3042:         ENDIF
3043:         IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 4)
3044:             loc_oPg2.txt_4c_Codigo.Value = ""
3045:         ENDIF
3046:         IF PEMSTATUS(loc_oPg2, "txt_4c_Descr", 4)

*-- Linhas 3222 a 3231:
3222:         IF PEMSTATUS(loc_oPg2, "txt_4c_DGrupoT", 4)
3223:             loc_oPg2.txt_4c_DGrupoT.Value    = ""
3224:         ENDIF
3225:         IF PEMSTATUS(loc_oPg2, "cmd_4c_BtnCarta", 4)
3226:             loc_oPg2.cmd_4c_BtnCarta.Enabled = .F.
3227:         ENDIF
3228:     ENDPROC
3229: 
3230:     *==========================================================================
3231:     * HabilitarCampos - Habilita/desabilita campos por modo (Fase 5)

*-- Linhas 3241 a 3252:
3241:         ENDIF
3242: 
3243:         IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 4)
3244:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
3245:         ENDIF
3246:         IF PEMSTATUS(loc_oPg2, "chk_4c_Fwcheckbox1", 4)
3247:             loc_oPg2.chk_4c_Fwcheckbox1.Enabled = par_lHabilitar
3248:         ENDIF
3249:         IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 4)
3250:             loc_oPg2.txt_4c_Codigo.Enabled  = par_lHabilitar
3251:             loc_oPg2.txt_4c_Codigo.ReadOnly = (THIS.this_cModoAtual = "ALTERAR")
3252:         ENDIF

*-- Linhas 3427 a 3440:
3427:         IF PEMSTATUS(loc_oPg2, "txt_4c_GrupoT", 4)
3428:             loc_oPg2.txt_4c_GrupoT.Enabled     = par_lHabilitar
3429:         ENDIF
3430:         IF PEMSTATUS(loc_oPg2, "cmd_4c_BtnCarta", 4)
3431:             IF par_lHabilitar
3432:                 loc_oPg2.cmd_4c_BtnCarta.Enabled = ;
3433:                     (UPPER(ALLTRIM(loc_oPg2.txt_4c_EmiCarta.Value)) = "S")
3434:             ELSE
3435:                 loc_oPg2.cmd_4c_BtnCarta.Enabled = .F.
3436:             ENDIF
3437:         ENDIF
3438:     ENDPROC
3439: 
3440:     *==========================================================================

*-- Linhas 3450 a 3470:
3450: 
3451:         IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 4)
3452:             WITH loc_oPg2.cnt_4c_BotoesAcao
3453:                 .cmd_4c_Confirmar.Enabled = (THIS.this_cModoAtual = "INCLUIR" OR ;
3454:                     THIS.this_cModoAtual = "ALTERAR")
3455:                 .cmd_4c_Cancelar.Enabled  = .T.
3456:                 .Visible     = .T.
3457:             ENDWITH
3458:         ENDIF
3459:     ENDPROC
3460: 
3461:     *==========================================================================
3462:     * FormParaBO - Transfere valores do Form para o BO
3463:     * Campos obrigatorios: Codigo (PK), Descricao, Tipo
3464:     * OptionGroups: .Value direto (1..N) = valor numerico no banco
3465:     * Checkbox Inativa: .Value=.T. -> 1 / .F. -> 0
3466:     *==========================================================================
3467:     PROTECTED PROCEDURE FormParaBO()
3468:         LOCAL loc_oPg2
3469:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3470: 

*-- Linhas 3542 a 3551:
3542:             IF PEMSTATUS(loc_oPg2, "txt_4c_Conta", 4)
3543:                 .this_cConDeps    = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
3544:             ENDIF
3545:             IF PEMSTATUS(loc_oPg2, "chk_4c_Fwcheckbox1", 4)
3546:                 .this_nInativas   = IIF(loc_oPg2.chk_4c_Fwcheckbox1.Value = 1, 1, 0)
3547:             ENDIF
3548:             *-- Secao 2: campos abaixo de Line2
3549:             IF PEMSTATUS(loc_oPg2, "txt_4c_ValPend", 4)
3550:                 .this_cValPends   = UPPER(ALLTRIM(loc_oPg2.txt_4c_ValPend.Value))
3551:             ENDIF

*-- Linhas 3673 a 3681:
3673:                 loc_oPg2.txt_4c_OpContas.Value  = ALLTRIM(.this_cDopcs)
3674:             ENDIF
3675:             IF PEMSTATUS(loc_oPg2, "txt_4c_Ordem", 4)
3676:                 loc_oPg2.txt_4c_Ordem.Value     = .this_nOrdens
3677:             ENDIF
3678:             IF PEMSTATUS(loc_oPg2, "txt_4c_OpEntrada", 4)
3679:                 loc_oPg2.txt_4c_OpEntrada.Value = ALLTRIM(.this_cOpEntradas)
3680:             ENDIF
3681:             IF PEMSTATUS(loc_oPg2, "txt_4c_OpAut", 4)

*-- Linhas 3736 a 3745:
3736:                 loc_oPg2.txt_4c_Conta.Value     = ALLTRIM(.this_cConDeps)
3737:                 loc_oPg2.txt_4c_DConta.Value    = ""
3738:             ENDIF
3739:             IF PEMSTATUS(loc_oPg2, "chk_4c_Fwcheckbox1", 4)
3740:                 loc_oPg2.chk_4c_Fwcheckbox1.Value = IIF(.this_nInativas = 1, 1, 0)
3741:             ENDIF
3742:             *-- Secao 2: campos abaixo de Line2
3743:             IF PEMSTATUS(loc_oPg2, "txt_4c_ValPend", 4)
3744:                 loc_oPg2.txt_4c_ValPend.Value    = ALLTRIM(.this_cValPends)
3745:             ENDIF

*-- Linhas 3792 a 3800:
3792:                 loc_oPg2.txt_4c_Devolvido.Value  = ALLTRIM(.this_cDevolvidos)
3793:             ENDIF
3794:             IF PEMSTATUS(loc_oPg2, "txt_4c_Desconto", 4)
3795:                 loc_oPg2.txt_4c_Desconto.Value   = .this_nDescontos
3796:             ENDIF
3797:             IF PEMSTATUS(loc_oPg2, "txt_4c_Moeda", 4)
3798:                 loc_oPg2.txt_4c_Moeda.Value      = ALLTRIM(.this_cMoedas)
3799:             ENDIF
3800:             IF PEMSTATUS(loc_oPg2, "obj_4c_Opt_DtEmiss", 4)

*-- Linhas 3845 a 3854:
3845:                 loc_oPg2.txt_4c_GrupoT.Value     = ALLTRIM(.this_cGrupoT)
3846:                 loc_oPg2.txt_4c_DGrupoT.Value    = ""
3847:             ENDIF
3848:             IF PEMSTATUS(loc_oPg2, "cmd_4c_BtnCarta", 4)
3849:                 loc_oPg2.cmd_4c_BtnCarta.Enabled = ;
3850:                     (UPPER(ALLTRIM(.this_cEmiCarts)) = "S")
3851:             ENDIF
3852:         ENDWITH
3853: 
3854:         THIS.AjustarBotoesPorModo()

*-- Linhas 4466 a 4486:
4466: 
4467:     *==========================================================================
4468:     * AtualizarEstadoCarta - InteractiveChange de txt_4c_EmiCarta
4469:     * Habilita cmd_4c_BtnCarta somente quando EmiCarta = "S"
4470:     *==========================================================================
4471:     PROCEDURE AtualizarEstadoCarta()
4472:         LOCAL loc_oPg2
4473:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
4474: 
4475:         IF VARTYPE(loc_oPg2) != "O"
4476:             RETURN
4477:         ENDIF
4478: 
4479:         IF PEMSTATUS(loc_oPg2, "cmd_4c_BtnCarta", 4) AND ;
4480:                 PEMSTATUS(loc_oPg2, "txt_4c_EmiCarta", 4)
4481:             loc_oPg2.cmd_4c_BtnCarta.Enabled = ;
4482:                 (UPPER(ALLTRIM(loc_oPg2.txt_4c_EmiCarta.Value)) = "S")
4483:         ENDIF
4484:     ENDPROC
4485: 
4486:     *==========================================================================


### BO (C:\4c\projeto\app\classes\OptBO.prg):
*==============================================================================
* OptBO.prg - Business Object para Cadastro de Movimentacoes de Cheques
* Tabela: SigCdOpt | PK: operacaos
* Gerado: Fase 1/8 - Propriedades e Init
*==============================================================================

DEFINE CLASS OptBO AS BusinessBase

    *-- Identidade da entidade
    this_cTabela      = "SigCdOpt"
    this_cCampoChave  = "operacaos"

    *--------------------------------------------------------------------------
    * Propriedades - SigCdOpt (todas as colunas da tabela)
    *--------------------------------------------------------------------------
    *-- Identificacao / chave primaria
    this_cOperacaos   = ""    && operacaos  char(15)     - Codigo / chave primaria
    this_cDescrs      = ""    && descrs     char(20)     - Descricao
    this_cTipos       = ""    && tipos      char(2)      - Tipo (CR/DB/TR)

    *-- Operacoes relacionadas
    this_cOpAnts      = ""    && opants     char(15)     - Movimento anterior
    this_cOpEntradas  = ""    && opentradas char(15)     - Movimento de entrada
    this_cDopcs       = ""    && dopcs      char(20)     - Movimento de titulos (SIGOPOPE.Dopes)
    this_cDevolvidos  = ""    && devolvidos char(1)      - Operacao de devolvido (S/N)

    *-- Ordem e configuracao basica
    this_nOrdens      = 0     && ordens     numeric(1,0) - Ordem
    this_cOpAuts      = ""    && opauts     char(1)      - Movimento automatico (S/N)
    this_nTpDatas     = 0     && tpdatas    numeric(1,0) - Tipo de data contabil
    this_nDtContab    = 0     && dtcontab   numeric(1,0) - Data contabil option
    this_nDestinos    = 0     && destinos   numeric(1,0) - Destino option
    this_nOrigems     = 0     && origems    numeric(1,0) - Origem option

    *-- Grupo e Conta de Destino (contabilidade)
    this_cGruDeps     = ""    && grudeps    char(10)     - Grupo destino
    this_cConDeps     = ""    && condeps    char(10)     - Conta destino

    *-- Grupo e Conta de Origem (contabilidade - OS)
    this_cGrupoOs     = ""    && grupoos    char(10)     - Grupo origem
    this_cContaOs     = ""    && contaos    char(10)     - Conta origem

    *-- Grupo Terceiro (contabilidade)
    this_cGrupoT      = ""    && grupot     char(10)     - Grupo terceiro

    *-- Central de Credito
    this_cCCentrals   = ""    && ccentrals  char(2)      - Central de credito

    *-- Historico
    this_cHists       = ""    && hists      char(30)     - Historico padrao
    this_nTpHists     = 0     && tphists    numeric(1,0) - Tipo historico
    this_cHistClis    = ""    && histclis   char(1)      - Lanca historico cliente (S/N)

    *-- Responsavel e Emissor
    this_cRespons     = ""    && respons    char(10)     - Responsavel (conta contabil)
    this_cGruEmis     = ""    && gruemis    char(10)     - Grupo emissor default
    this_cEmpInds     = ""    && empinds    char(1)      - Empresa individual (S/N)
    this_cEmiInds     = ""    && emiinds    char(1)      - Emissor individual (S/N)
    this_cCademis     = ""    && cademis    char(1)      - Cadastra emissor (S/N)
    this_nTpEmiss     = 0     && tpemiss    numeric(1,0) - Tipo emissor option

    *-- Forma de Pagamento e Parcelas
    this_cFPags       = ""    && fpags      char(12)     - Condicao de pagamento
    this_cParcelas    = ""    && parcelas   char(1)      - Parcelas (S/N)

    *-- Pendencias e Valores
    this_cValPends    = ""    && valpends   char(1)      - Valor pendente emissor (S/N)
    this_cValPend2s   = ""    && valpend2s  char(1)      - Valor pendente deposito (S/N)
    this_cBxPends     = ""    && bxpends    char(1)      - Baixa pendencias (S/N)
    this_cVVectos     = ""    && vvectos    char(1)      - Verifica vencimento (S/N)
    this_cFazContas   = ""    && fazcontas  char(1)      - Lanca conta corrente (S/N)

    *-- Situacao e Observacao
    this_cSituas      = ""    && situas     char(3)      - Situacao do cliente
    this_cObs         = ""    && obs        char(1)      - Observacao (S/N/C)

    *-- Carta e Protocolo
    this_cEmiCarts    = ""    && emicarts   char(1)      - Emite carta (S/N)
    this_cEmiProts    = ""    && emiprots   char(1)      - Emite protocolo (S/N)
    this_cAlineas     = ""    && alineas    char(1)      - Tem alinea (S/N)

    *-- Leitura e Geracao
    this_nTpLeituras  = 0     && tpleituras numeric(1,0) - Tipo leitura de cheque
    this_nLeProts     = 0     && leprots    numeric(1,0) - Leitura protocolo option
    this_nGeranarqs   = 0     && geranarqs  numeric(1,0) - Gera numero arquivo option
    this_cGerCnabs    = ""    && gercnabs   char(1)      - Gera CNAB (S/N)
    this_cValidaChqs  = ""    && validachqs char(1)      - Valida cheques (S/N)

    *-- Data de Emissao
    this_nNdtEmiss    = 0     && ndtemiss   numeric(1,0) - Data emissao padrao option

    *-- Descontos e Comissao
    this_nDescontos   = 0     && descontos  numeric(4,2) - Percentual comissao
    this_nComiss      = 0     && comiss     numeric(1,0) - Calculo de comissao option
    this_nIndProds    = 0     && indprods   numeric(4,2) - Indicador de producao

    *-- Pendencias Financeiras e Situacao Global
    this_nPeFins      = 0     && pefins     numeric(1,0) - Pendencias financeiras option
    this_nAnaSits     = 0     && anasits    numeric(1,0) - Cons. global situacao option

    *-- Carteira e Prorrogacao
    this_nCartDbs     = 0     && cartdbs    numeric(1,0) - Carteira tipo (CR) option
    this_nProrrogas   = 0     && prorrogas  numeric(1,0) - Prorrogar tipo (CR) option
    this_cLimpCarts   = ""    && limpcarts  char(1)      - Limpa carteira (S/N)

    *-- Consolidacao e Alteracao
    this_cConsolidas  = ""    && consolidas char(1)      - Consolida lancamentos (S/N)
    this_nAltDados    = 0     && altdados   numeric(1,0) - Altera dados option

    *-- Vencimento e Moeda
    this_cCongvs      = ""    && congvs     char(1)      - Vencimento dia util (S/N)
    this_nVencUtil    = 0     && vencutil   numeric(1,0) - Vencimento dia util option
    this_cMoedas      = ""    && moedas     char(3)      - Moeda

    *-- Inativa
    this_nInativas    = 0     && inativas   numeric(1,0) - Inativa (0=Ativo, 1=Inativo)

    *-- Juros
    this_nChkJuros    = 0     && chkjuros   numeric(1,0) - Cobra juros option
    this_nPerJuros    = 0     && perjuros   numeric(4,2) - Percentual de juros
    this_nChkSmtJuro  = 0     && chksmtjuro numeric(1,0) - Somatorio de juros option

    *-- Configuracoes avancadas
    this_nImpChDev    = 0     && impchdev   numeric(1,0) - Imprime cheque devolvido option
    this_nLancCobr    = 0     && lanccobr   numeric(1,0) - Lanca cobranca option
    this_nAltConfSit  = 0     && altconfsit numeric(1,0) - Altera confirmacao situacao option
    this_cAltSituas   = ""    && altsituas  char(3)      - Altera situacao para
    this_nChkPortChq  = 0     && chkPortChq numeric(1,0) - Portador cheque option

    *-- Flags de fixacao de grupos/contas
    this_lFixGOrigs   = .F.   && fixgorigs  bit          - Fixa grupo origem
    this_lFixCOrigs   = .F.   && fixcorigs  bit          - Fixa conta origem
    this_lFixGDests   = .F.   && fixgdests  bit          - Fixa grupo destino
    this_lFixCDests   = .F.   && fixcdests  bit          - Fixa conta destino

    *-- Flags gerais
    this_lFlags       = .F.   && flags      bit          - Flag geral
    this_lLComis      = .F.   && lcomis     bit          - Lanca comissao flag

    *-- Cabecalho e Rodape (text/memo)
    this_cCabs        = ""    && cabs       text         - Cabecalho
    this_cRods        = ""    && rods       text         - Rodape

    *==========================================================================
    * Init - Configura tabela e campo chave
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdOpt"
        THIS.this_cCampoChave = "operacaos"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cOperacaos)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    * REGRA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cOperacaos   = TratarNulo(Operacaos,  "C")
                THIS.this_cDescrs      = TratarNulo(Descrs,     "C")
                THIS.this_cTipos       = TratarNulo(Tipos,      "C")
                THIS.this_cOpAnts      = TratarNulo(OpAnts,     "C")
                THIS.this_cOpEntradas  = TratarNulo(OpEntradas, "C")
                THIS.this_cDopcs       = TratarNulo(Dopcs,      "C")
                THIS.this_cDevolvidos  = TratarNulo(Devolvidos, "C")
                THIS.this_nOrdens      = TratarNulo(Ordens,     "N")
                THIS.this_cOpAuts      = TratarNulo(OpAuts,     "C")
                THIS.this_nTpDatas     = TratarNulo(TpDatas,    "N")
                THIS.this_nDtContab    = TratarNulo(DtContab,   "N")
                THIS.this_nDestinos    = TratarNulo(Destinos,   "N")
                THIS.this_nOrigems     = TratarNulo(Origems,    "N")
                THIS.this_cGruDeps     = TratarNulo(GruDeps,    "C")
                THIS.this_cConDeps     = TratarNulo(ConDeps,    "C")
                THIS.this_cGrupoOs     = TratarNulo(GrupoOs,    "C")
                THIS.this_cContaOs     = TratarNulo(ContaOs,    "C")
                THIS.this_cGrupoT      = TratarNulo(GrupoT,     "C")
                THIS.this_cCCentrals   = TratarNulo(CCentrals,  "C")
                THIS.this_cHists       = TratarNulo(Hists,      "C")
                THIS.this_nTpHists     = TratarNulo(TpHists,    "N")
                THIS.this_cHistClis    = TratarNulo(HistClis,   "C")
                THIS.this_cRespons     = TratarNulo(Respons,    "C")
                THIS.this_cGruEmis     = TratarNulo(GruEmis,    "C")
                THIS.this_cEmpInds     = TratarNulo(EmpInds,    "C")
                THIS.this_cEmiInds     = TratarNulo(EmiInds,    "C")
                THIS.this_cCademis     = TratarNulo(Cademis,    "C")
                THIS.this_nTpEmiss     = TratarNulo(TpEmiss,    "N")
                THIS.this_cFPags       = TratarNulo(FPags,      "C")
                THIS.this_cParcelas    = TratarNulo(Parcelas,   "C")
                THIS.this_cValPends    = TratarNulo(ValPends,   "C")
                THIS.this_cValPend2s   = TratarNulo(ValPend2s,  "C")
                THIS.this_cBxPends     = TratarNulo(BxPends,    "C")
                THIS.this_cVVectos     = TratarNulo(VVectos,    "C")
                THIS.this_cFazContas   = TratarNulo(FazContas,  "C")
                THIS.this_cSituas      = TratarNulo(Situas,     "C")
                THIS.this_cObs         = TratarNulo(Obs,        "C")
                THIS.this_cEmiCarts    = TratarNulo(EmiCarts,   "C")
                THIS.this_cEmiProts    = TratarNulo(EmiProts,   "C")
                THIS.this_cAlineas     = TratarNulo(Alineas,    "C")
                THIS.this_nTpLeituras  = TratarNulo(TpLeituras, "N")
                THIS.this_nLeProts     = TratarNulo(LeProts,    "N")
                THIS.this_nGeranarqs   = TratarNulo(Geranarqs,  "N")
                THIS.this_cGerCnabs    = TratarNulo(GerCnabs,   "C")
                THIS.this_cValidaChqs  = TratarNulo(ValidaChqs, "C")
                THIS.this_nNdtEmiss    = TratarNulo(NdtEmiss,   "N")
                THIS.this_nDescontos   = TratarNulo(Descontos,  "N")
                THIS.this_nComiss      = TratarNulo(Comiss,     "N")
                THIS.this_nIndProds    = TratarNulo(IndProds,   "N")
                THIS.this_nPeFins      = TratarNulo(PeFins,     "N")
                THIS.this_nAnaSits     = TratarNulo(AnaSits,    "N")
                THIS.this_nCartDbs     = TratarNulo(CartDbs,    "N")
                THIS.this_nProrrogas   = TratarNulo(Prorrogas,  "N")
                THIS.this_cLimpCarts   = TratarNulo(LimpCarts,  "C")
                THIS.this_cConsolidas  = TratarNulo(Consolidas, "C")
                THIS.this_nAltDados    = TratarNulo(AltDados,   "N")
                THIS.this_cCongvs      = TratarNulo(Congvs,     "C")
                THIS.this_nVencUtil    = TratarNulo(VencUtil,   "N")
                THIS.this_cMoedas      = TratarNulo(Moedas,     "C")
                THIS.this_nInativas    = TratarNulo(Inativas,   "N")
                THIS.this_nChkJuros    = TratarNulo(ChkJuros,   "N")
                THIS.this_nPerJuros    = TratarNulo(PerJuros,   "N")
                THIS.this_nChkSmtJuro  = TratarNulo(ChkSmtJuro, "N")
                THIS.this_nImpChDev    = TratarNulo(ImpChDev,   "N")
                THIS.this_nLancCobr    = TratarNulo(LancCobr,   "N")
                THIS.this_nAltConfSit  = TratarNulo(AltConfSit, "N")
                THIS.this_cAltSituas   = TratarNulo(AltSituas,  "C")
                THIS.this_nChkPortChq  = TratarNulo(ChkPortChq, "N")
                IF VARTYPE(FixGOrigs) = "L"
                    THIS.this_lFixGOrigs = FixGOrigs
                ELSE
                    THIS.this_lFixGOrigs = (NVL(FixGOrigs, 0) = 1)
                ENDIF
                IF VARTYPE(FixCOrigs) = "L"
                    THIS.this_lFixCOrigs = FixCOrigs
                ELSE
                    THIS.this_lFixCOrigs = (NVL(FixCOrigs, 0) = 1)
                ENDIF
                IF VARTYPE(FixGDests) = "L"
                    THIS.this_lFixGDests = FixGDests
                ELSE
                    THIS.this_lFixGDests = (NVL(FixGDests, 0) = 1)
                ENDIF
                IF VARTYPE(FixCDests) = "L"
                    THIS.this_lFixCDests = FixCDests
                ELSE
                    THIS.this_lFixCDests = (NVL(FixCDests, 0) = 1)
                ENDIF
                IF VARTYPE(Flags) = "L"
                    THIS.this_lFlags = Flags
                ELSE
                    THIS.this_lFlags = (NVL(Flags, 0) = 1)
                ENDIF
                IF VARTYPE(LComis) = "L"
                    THIS.this_lLComis = LComis
                ELSE
                    THIS.this_lLComis = (NVL(LComis, 0) = 1)
                ENDIF
                IF TYPE("Cabs") != "U"
                    THIS.this_cCabs    = TratarNulo(Cabs, "C")
                ENDIF
                IF TYPE("Rods") != "U"
                    THIS.this_cRods    = TratarNulo(Rods, "C")
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar cursor:" + CHR(13) + loException.Message + ;
                " (Linha: " + TRANSFORM(loException.LineNo) + ")", "OptBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida campos obrigatorios antes de salvar
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cOperacaos))
            MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cDescrs))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND !INLIST(UPPER(ALLTRIM(THIS.this_cTipos)), "CR", "DB", "TR")
            MsgAviso("Tipo inv" + CHR(225) + "lido! Use CR, DB ou TR.")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarCodigoExistente(THIS.this_cOperacaos)
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND ALLTRIM(THIS.this_cParcelas) = "S"
            IF UPPER(ALLTRIM(THIS.this_cTipos)) # "CR"
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o com Parcelas permite apenas CR.")
                loc_lValido = .F.
            ENDIF
            IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cOpEntradas))
                MsgAviso("Obrigat" + CHR(243) + "rio informar Opera" + CHR(231) + CHR(227) + "o de Entrada de Cheques.")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND INLIST(THIS.this_nComiss, 2, 3) AND THIS.this_nDescontos = 0
            MsgAviso("Percentual de Desconto/Recupera" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lido!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * VerificarCodigoExistente - Verifica se operacaos ja existe no banco
    *==========================================================================
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdOpt" + ;
                " WHERE Operacaos = " + EscaparSQL(ALLTRIM(par_cCodigo))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkOpt")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkOpt")
                SELECT cursor_4c_ChkOpt
                loc_lExiste = (NVL(cursor_4c_ChkOpt.qtd, 0) > 0)
                USE IN cursor_4c_ChkOpt
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "OptBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *==========================================================================
    * Inserir - INSERT INTO SigCdOpt
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdOpt (" + ;
                "Operacaos, Descrs, Tipos, OpAnts, OpEntradas, Dopcs, Devolvidos," + ;
                " Ordens, OpAuts, TpDatas, DtContab, Destinos, Origems," + ;
                " GruDeps, ConDeps, GrupoOs, ContaOs, GrupoT, CCentrals," + ;
                " Hists, TpHists, HistClis, Respons, GruEmis, EmpInds, EmiInds," + ;
                " Cademis, TpEmiss, FPags, Parcelas," + ;
                " ValPends, ValPend2s, BxPends, VVectos, FazContas," + ;
                " Situas, Obs, EmiCarts, EmiProts, Alineas," + ;
                " TpLeituras, LeProts, Geranarqs, GerCnabs, ValidaChqs, NdtEmiss," + ;
                " Descontos, Comiss, IndProds, PeFins, AnaSits," + ;
                " CartDbs, Prorrogas, LimpCarts, Consolidas, AltDados," + ;
                " Congvs, VencUtil, Moedas, Inativas," + ;
                " ChkJuros, PerJuros, ChkSmtJuro, ImpChDev, LancCobr," + ;
                " AltConfSit, AltSituas, ChkPortChq," + ;
                " FixGOrigs, FixCOrigs, FixGDests, FixCDests, Flags, LComis," + ;
                " Cabs, Rods)" + ;
                " VALUES (" + ;
                EscaparSQL(ALLTRIM(THIS.this_cOperacaos)) + "," + ;
                EscaparSQL(THIS.this_cDescrs)             + "," + ;
                EscaparSQL(THIS.this_cTipos)              + "," + ;
                EscaparSQL(THIS.this_cOpAnts)             + "," + ;
                EscaparSQL(THIS.this_cOpEntradas)         + "," + ;
                EscaparSQL(THIS.this_cDopcs)              + "," + ;
                EscaparSQL(THIS.this_cDevolvidos)         + "," + ;
                FormatarNumeroSQL(THIS.this_nOrdens, 0)   + "," + ;
                EscaparSQL(THIS.this_cOpAuts)             + "," + ;
                FormatarNumeroSQL(THIS.this_nTpDatas, 0)  + "," + ;
                FormatarNumeroSQL(THIS.this_nDtContab, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nDestinos, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nOrigems, 0)  + "," + ;
                EscaparSQL(THIS.this_cGruDeps)            + "," + ;
                EscaparSQL(THIS.this_cConDeps)            + "," + ;
                EscaparSQL(THIS.this_cGrupoOs)            + "," + ;
                EscaparSQL(THIS.this_cContaOs)            + "," + ;
                EscaparSQL(THIS.this_cGrupoT)             + "," + ;
                EscaparSQL(THIS.this_cCCentrals)          + "," + ;
                EscaparSQL(THIS.this_cHists)              + "," + ;
                FormatarNumeroSQL(THIS.this_nTpHists, 0)  + "," + ;
                EscaparSQL(THIS.this_cHistClis)           + "," + ;
                EscaparSQL(THIS.this_cRespons)            + "," + ;
                EscaparSQL(THIS.this_cGruEmis)            + "," + ;
                EscaparSQL(THIS.this_cEmpInds)            + "," + ;
                EscaparSQL(THIS.this_cEmiInds)            + "," + ;
                EscaparSQL(THIS.this_cCademis)            + "," + ;
                FormatarNumeroSQL(THIS.this_nTpEmiss, 0)  + "," + ;
                EscaparSQL(THIS.this_cFPags)              + "," + ;
                EscaparSQL(THIS.this_cParcelas)           + "," + ;
                EscaparSQL(THIS.this_cValPends)           + "," + ;
                EscaparSQL(THIS.this_cValPend2s)          + "," + ;
                EscaparSQL(THIS.this_cBxPends)            + "," + ;
                EscaparSQL(THIS.this_cVVectos)            + "," + ;
                EscaparSQL(THIS.this_cFazContas)          + "," + ;
                EscaparSQL(THIS.this_cSituas)             + "," + ;
                EscaparSQL(THIS.this_cObs)                + "," + ;
                EscaparSQL(THIS.this_cEmiCarts)           + "," + ;
                EscaparSQL(THIS.this_cEmiProts)           + "," + ;
                EscaparSQL(THIS.this_cAlineas)            + "," + ;
                FormatarNumeroSQL(THIS.this_nTpLeituras, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nLeProts, 0)    + "," + ;
                FormatarNumeroSQL(THIS.this_nGeranarqs, 0)  + "," + ;
                EscaparSQL(THIS.this_cGerCnabs)           + "," + ;
                EscaparSQL(THIS.this_cValidaChqs)         + "," + ;
                FormatarNumeroSQL(THIS.this_nNdtEmiss, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nDescontos, 2) + "," + ;
                FormatarNumeroSQL(THIS.this_nComiss, 0)   + "," + ;
                FormatarNumeroSQL(THIS.this_nIndProds, 2) + "," + ;
                FormatarNumeroSQL(THIS.this_nPeFins, 0)   + "," + ;
                FormatarNumeroSQL(THIS.this_nAnaSits, 0)  + "," + ;
                FormatarNumeroSQL(THIS.this_nCartDbs, 0)  + "," + ;
                FormatarNumeroSQL(THIS.this_nProrrogas, 0) + "," + ;
                EscaparSQL(THIS.this_cLimpCarts)          + "," + ;
                EscaparSQL(THIS.this_cConsolidas)         + "," + ;
                FormatarNumeroSQL(THIS.this_nAltDados, 0) + "," + ;
                EscaparSQL(THIS.this_cCongvs)             + "," + ;
                FormatarNumeroSQL(THIS.this_nVencUtil, 0) + "," + ;
                EscaparSQL(THIS.this_cMoedas)             + "," + ;
                FormatarNumeroSQL(THIS.this_nInativas, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nChkJuros, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nPerJuros, 2) + "," + ;
                FormatarNumeroSQL(THIS.this_nChkSmtJuro, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nImpChDev, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nLancCobr, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nAltConfSit, 0) + "," + ;
                EscaparSQL(THIS.this_cAltSituas)          + "," + ;
                FormatarNumeroSQL(THIS.this_nChkPortChq, 0) + "," + ;
                FormatarNumeroSQL(IIF(THIS.this_lFixGOrigs, 1, 0), 0) + "," + ;
                FormatarNumeroSQL(IIF(THIS.this_lFixCOrigs, 1, 0), 0) + "," + ;
                FormatarNumeroSQL(IIF(THIS.this_lFixGDests, 1, 0), 0) + "," + ;
                FormatarNumeroSQL(IIF(THIS.this_lFixCDests, 1, 0), 0) + "," + ;
                FormatarNumeroSQL(IIF(THIS.this_lFlags,     1, 0), 0) + "," + ;
                FormatarNumeroSQL(IIF(THIS.this_lLComis,    1, 0), 0) + "," + ;
                EscaparSQL(THIS.this_cCabs)               + "," + ;
                EscaparSQL(THIS.this_cRods)               + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message + ;
                " (Linha: " + TRANSFORM(loException.LineNo) + ")", "OptBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE SigCdOpt
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdOpt SET" + ;
                " Descrs      = " + EscaparSQL(THIS.this_cDescrs)              + "," + ;
                " Tipos       = " + EscaparSQL(THIS.this_cTipos)               + "," + ;
                " OpAnts      = " + EscaparSQL(THIS.this_cOpAnts)              + "," + ;
                " OpEntradas  = " + EscaparSQL(THIS.this_cOpEntradas)          + "," + ;
                " Dopcs       = " + EscaparSQL(THIS.this_cDopcs)               + "," + ;
                " Devolvidos  = " + EscaparSQL(THIS.this_cDevolvidos)          + "," + ;
                " Ordens      = " + FormatarNumeroSQL(THIS.this_nOrdens, 0)    + "," + ;
                " OpAuts      = " + EscaparSQL(THIS.this_cOpAuts)              + "," + ;
                " TpDatas     = " + FormatarNumeroSQL(THIS.this_nTpDatas, 0)   + "," + ;
                " DtContab    = " + FormatarNumeroSQL(THIS.this_nDtContab, 0)  + "," + ;
                " Destinos    = " + FormatarNumeroSQL(THIS.this_nDestinos, 0)  + "," + ;
                " Origems     = " + FormatarNumeroSQL(THIS.this_nOrigems, 0)   + "," + ;
                " GruDeps     = " + EscaparSQL(THIS.this_cGruDeps)             + "," + ;
                " ConDeps     = " + EscaparSQL(THIS.this_cConDeps)             + "," + ;
                " GrupoOs     = " + EscaparSQL(THIS.this_cGrupoOs)             + "," + ;
                " ContaOs     = " + EscaparSQL(THIS.this_cContaOs)             + "," + ;
                " GrupoT      = " + EscaparSQL(THIS.this_cGrupoT)              + "," + ;
                " CCentrals   = " + EscaparSQL(THIS.this_cCCentrals)           + "," + ;
                " Hists       = " + EscaparSQL(THIS.this_cHists)               + "," + ;
                " TpHists     = " + FormatarNumeroSQL(THIS.this_nTpHists, 0)   + "," + ;
                " HistClis    = " + EscaparSQL(THIS.this_cHistClis)            + "," + ;
                " Respons     = " + EscaparSQL(THIS.this_cRespons)             + "," + ;
                " GruEmis     = " + EscaparSQL(THIS.this_cGruEmis)             + "," + ;
                " EmpInds     = " + EscaparSQL(THIS.this_cEmpInds)             + "," + ;
                " EmiInds     = " + EscaparSQL(THIS.this_cEmiInds)             + "," + ;
                " Cademis     = " + EscaparSQL(THIS.this_cCademis)             + "," + ;
                " TpEmiss     = " + FormatarNumeroSQL(THIS.this_nTpEmiss, 0)   + "," + ;
                " FPags       = " + EscaparSQL(THIS.this_cFPags)               + "," + ;
                " Parcelas    = " + EscaparSQL(THIS.this_cParcelas)            + "," + ;
                " ValPends    = " + EscaparSQL(THIS.this_cValPends)            + "," + ;
                " ValPend2s   = " + EscaparSQL(THIS.this_cValPend2s)           + "," + ;
                " BxPends     = " + EscaparSQL(THIS.this_cBxPends)             + "," + ;
                " VVectos     = " + EscaparSQL(THIS.this_cVVectos)             + "," + ;
                " FazContas   = " + EscaparSQL(THIS.this_cFazContas)           + "," + ;
                " Situas      = " + EscaparSQL(THIS.this_cSituas)              + "," + ;
                " Obs         = " + EscaparSQL(THIS.this_cObs)                 + "," + ;
                " EmiCarts    = " + EscaparSQL(THIS.this_cEmiCarts)            + "," + ;
                " EmiProts    = " + EscaparSQL(THIS.this_cEmiProts)            + "," + ;
                " Alineas     = " + EscaparSQL(THIS.this_cAlineas)             + "," + ;
                " TpLeituras  = " + FormatarNumeroSQL(THIS.this_nTpLeituras, 0) + "," + ;
                " LeProts     = " + FormatarNumeroSQL(THIS.this_nLeProts, 0)   + "," + ;
                " Geranarqs   = " + FormatarNumeroSQL(THIS.this_nGeranarqs, 0) + "," + ;
                " GerCnabs    = " + EscaparSQL(THIS.this_cGerCnabs)            + "," + ;
                " ValidaChqs  = " + EscaparSQL(THIS.this_cValidaChqs)          + "," + ;
                " NdtEmiss    = " + FormatarNumeroSQL(THIS.this_nNdtEmiss, 0)  + "," + ;
                " Descontos   = " + FormatarNumeroSQL(THIS.this_nDescontos, 2) + "," + ;
                " Comiss      = " + FormatarNumeroSQL(THIS.this_nComiss, 0)    + "," + ;
                " IndProds    = " + FormatarNumeroSQL(THIS.this_nIndProds, 2)  + "," + ;
                " PeFins      = " + FormatarNumeroSQL(THIS.this_nPeFins, 0)    + "," + ;
                " AnaSits     = " + FormatarNumeroSQL(THIS.this_nAnaSits, 0)   + "," + ;
                " CartDbs     = " + FormatarNumeroSQL(THIS.this_nCartDbs, 0)   + "," + ;
                " Prorrogas   = " + FormatarNumeroSQL(THIS.this_nProrrogas, 0) + "," + ;
                " LimpCarts   = " + EscaparSQL(THIS.this_cLimpCarts)           + "," + ;
                " Consolidas  = " + EscaparSQL(THIS.this_cConsolidas)          + "," + ;
                " AltDados    = " + FormatarNumeroSQL(THIS.this_nAltDados, 0)  + "," + ;
                " Congvs      = " + EscaparSQL(THIS.this_cCongvs)              + "," + ;
                " VencUtil    = " + FormatarNumeroSQL(THIS.this_nVencUtil, 0)  + "," + ;
                " Moedas      = " + EscaparSQL(THIS.this_cMoedas)              + "," + ;
                " Inativas    = " + FormatarNumeroSQL(THIS.this_nInativas, 0)  + "," + ;
                " ChkJuros    = " + FormatarNumeroSQL(THIS.this_nChkJuros, 0)  + "," + ;
                " PerJuros    = " + FormatarNumeroSQL(THIS.this_nPerJuros, 2)  + "," + ;
                " ChkSmtJuro  = " + FormatarNumeroSQL(THIS.this_nChkSmtJuro, 0) + "," + ;
                " ImpChDev    = " + FormatarNumeroSQL(THIS.this_nImpChDev, 0)  + "," + ;
                " LancCobr    = " + FormatarNumeroSQL(THIS.this_nLancCobr, 0)  + "," + ;
                " AltConfSit  = " + FormatarNumeroSQL(THIS.this_nAltConfSit, 0) + "," + ;
                " AltSituas   = " + EscaparSQL(THIS.this_cAltSituas)           + "," + ;
                " ChkPortChq  = " + FormatarNumeroSQL(THIS.this_nChkPortChq, 0) + "," + ;
                " FixGOrigs   = " + FormatarNumeroSQL(IIF(THIS.this_lFixGOrigs, 1, 0), 0) + "," + ;
                " FixCOrigs   = " + FormatarNumeroSQL(IIF(THIS.this_lFixCOrigs, 1, 0), 0) + "," + ;
                " FixGDests   = " + FormatarNumeroSQL(IIF(THIS.this_lFixGDests, 1, 0), 0) + "," + ;
                " FixCDests   = " + FormatarNumeroSQL(IIF(THIS.this_lFixCDests, 1, 0), 0) + "," + ;
                " Flags       = " + FormatarNumeroSQL(IIF(THIS.this_lFlags,     1, 0), 0) + "," + ;
                " LComis      = " + FormatarNumeroSQL(IIF(THIS.this_lLComis,    1, 0), 0) + "," + ;
                " Cabs        = " + EscaparSQL(THIS.this_cCabs)                + "," + ;
                " Rods        = " + EscaparSQL(THIS.this_cRods)                + ;
                " WHERE Operacaos = " + EscaparSQL(ALLTRIM(THIS.this_cOperacaos))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message + ;
                " (Linha: " + TRANSFORM(loException.LineNo) + ")", "OptBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - DELETE FROM SigCdOpt (verifica uso em lancamentos)
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nUso
        loc_lSucesso = .F.
        loc_nUso     = 0

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SIGCQDEV" + ;
                " WHERE Operacaos = " + EscaparSQL(ALLTRIM(THIS.this_cOperacaos))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkUso")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkUso")
                SELECT cursor_4c_ChkUso
                loc_nUso = NVL(cursor_4c_ChkUso.qtd, 0)
                USE IN cursor_4c_ChkUso
            ENDIF

            IF loc_nUso > 0
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o utilizada em lan" + CHR(231) + "amentos e n" + CHR(227) + "o pode ser exclu" + CHR(237) + "da!")
            ELSE
                loc_cSQL = "DELETE FROM SigCdOpt" + ;
                    " WHERE Operacaos = " + EscaparSQL(ALLTRIM(THIS.this_cOperacaos))
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao excluir:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message + ;
                " (Linha: " + TRANSFORM(loException.LineNo) + ")", "OptBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - Lista movimentacoes de cheques para o grid
    * par_cFiltro: "" = todos | expressao SQL WHERE adicional
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (Operacaos C(15), Tipos C(2), ;
                        OpAnts C(15), GrupoOs C(10), ContaOs C(10), ;
                        GruDeps C(10), ConDeps C(10), ValPends C(1))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cWhere = ""
                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                    loc_cWhere = " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = "SELECT a.Operacaos, a.Tipos, a.OpAnts," + ;
                    " a.GrupoOs, a.ContaOs, a.GruDeps, a.ConDeps, a.ValPends" + ;
                    " FROM SigCdOpt a" + ;
                    loc_cWhere + ;
                    " ORDER BY a.Operacaos"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        SET NULL ON
                        IF RECCOUNT("cursor_4c_DadosTmp") > 0
                            APPEND FROM DBF("cursor_4c_DadosTmp")
                        ENDIF
                        SET NULL OFF
                        IF USED("cursor_4c_DadosTmp")
                            USE IN cursor_4c_DadosTmp
                        ENDIF
                        GO TOP IN cursor_4c_Dados
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar:" + CHR(13) + CapturarErroSQL(), "OptBO.Buscar")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        GO TOP IN cursor_4c_Dados
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar:" + CHR(13) + CapturarErroSQL(), "OptBO.Buscar")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message + ;
                " (Linha: " + TRANSFORM(loException.LineNo) + ")", "OptBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro completo por PK
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT * FROM SigCdOpt" + ;
                " WHERE Operacaos = " + EscaparSQL(ALLTRIM(par_cCodigo))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND USED("cursor_4c_Carrega")
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Registro n" + CHR(227) + "o encontrado!")
                ENDIF
                USE IN cursor_4c_Carrega
            ELSE
                MostrarErro("Erro ao carregar registro:" + CHR(13) + CapturarErroSQL(), "OptBO.CarregarPorCodigo")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message + ;
                " (Linha: " + TRANSFORM(loException.LineNo) + ")", "OptBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarDescGrupoContab - Retorna descricao de grupo contabil (SigCdGcr)
    *==========================================================================
    PROCEDURE BuscarDescGrupoContab(par_cCodigo)
        LOCAL loc_cDesc, loc_nResult
        loc_cDesc = ""

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(ALLTRIM(par_cCodigo)), ;
                "cursor_4c_DescGrpCtb")
            IF loc_nResult > 0 AND USED("cursor_4c_DescGrpCtb") AND RECCOUNT("cursor_4c_DescGrpCtb") > 0
                SELECT cursor_4c_DescGrpCtb
                loc_cDesc = ALLTRIM(NVL(cursor_4c_DescGrpCtb.Descrs, ""))
            ENDIF
        CATCH TO loException
            MostrarErro(loException.Message, "OptBO.BuscarDescGrupoContab")
        ENDTRY

        IF USED("cursor_4c_DescGrpCtb")
            USE IN cursor_4c_DescGrpCtb
        ENDIF

        RETURN loc_cDesc
    ENDPROC

    *==========================================================================
    * BuscarDescContaContab - Retorna descricao de conta contabil
    *==========================================================================
    PROCEDURE BuscarDescContaContab(par_cGrupo, par_cConta)
        LOCAL loc_cDesc, loc_nResult
        loc_cDesc = ""

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(ALLTRIM(par_cConta)), ;
                "cursor_4c_DescCtaCli")
            IF loc_nResult > 0 AND USED("cursor_4c_DescCtaCli") AND RECCOUNT("cursor_4c_DescCtaCli") > 0
                SELECT cursor_4c_DescCtaCli
                loc_cDesc = ALLTRIM(NVL(cursor_4c_DescCtaCli.Rclis, ""))
            ENDIF
        CATCH TO loException
            MostrarErro(loException.Message, "OptBO.BuscarDescContaContab")
        ENDTRY

        IF USED("cursor_4c_DescCtaCli")
            USE IN cursor_4c_DescCtaCli
        ENDIF

        RETURN loc_cDesc
    ENDPROC

    *==========================================================================
    * BuscarDescCentral - Retorna descricao da central de credito (SIGCCCCO)
    *==========================================================================
    PROCEDURE BuscarDescCentral(par_cCodigo)
        LOCAL loc_cDesc, loc_nResult
        loc_cDesc = ""

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Descs FROM SIGCCCCO WHERE Cods = " + EscaparSQL(ALLTRIM(par_cCodigo)), ;
                "cursor_4c_DescCentral")
            IF loc_nResult > 0 AND USED("cursor_4c_DescCentral") AND RECCOUNT("cursor_4c_DescCentral") > 0
                SELECT cursor_4c_DescCentral
                loc_cDesc = ALLTRIM(NVL(cursor_4c_DescCentral.Descs, ""))
            ENDIF
        CATCH TO loException
            MostrarErro(loException.Message, "OptBO.BuscarDescCentral")
        ENDTRY

        IF USED("cursor_4c_DescCentral")
            USE IN cursor_4c_DescCentral
        ENDIF

        RETURN loc_cDesc
    ENDPROC

    *==========================================================================
    * BuscarDescSituacao - Retorna descricao de situacao do cliente (SigCdCst)
    *==========================================================================
    PROCEDURE BuscarDescSituacao(par_cCodigo)
        LOCAL loc_cDesc, loc_nResult
        loc_cDesc = ""

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Descrs FROM SigCdCst WHERE Codigos = " + EscaparSQL(ALLTRIM(par_cCodigo)) + ;
                " AND Priors BETWEEN 1 AND 998", ;
                "cursor_4c_DescSit")
            IF loc_nResult > 0 AND USED("cursor_4c_DescSit") AND RECCOUNT("cursor_4c_DescSit") > 0
                SELECT cursor_4c_DescSit
                loc_cDesc = ALLTRIM(NVL(cursor_4c_DescSit.Descrs, ""))
            ENDIF
        CATCH TO loException
            MostrarErro(loException.Message, "OptBO.BuscarDescSituacao")
        ENDTRY

        IF USED("cursor_4c_DescSit")
            USE IN cursor_4c_DescSit
        ENDIF

        RETURN loc_cDesc
    ENDPROC

    *==========================================================================
    * BuscarDescMoeda - Retorna descricao de moeda (SigCdMoe)
    *==========================================================================
    PROCEDURE BuscarDescMoeda(par_cCodigo)
        LOCAL loc_cDesc, loc_nResult
        loc_cDesc = ""

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT DMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(ALLTRIM(par_cCodigo)), ;
                "cursor_4c_DescMoe")
            IF loc_nResult > 0 AND USED("cursor_4c_DescMoe") AND RECCOUNT("cursor_4c_DescMoe") > 0
                SELECT cursor_4c_DescMoe
                loc_cDesc = ALLTRIM(NVL(cursor_4c_DescMoe.DMoes, ""))
            ENDIF
        CATCH TO loException
            MostrarErro(loException.Message, "OptBO.BuscarDescMoeda")
        ENDTRY

        IF USED("cursor_4c_DescMoe")
            USE IN cursor_4c_DescMoe
        ENDIF

        RETURN loc_cDesc
    ENDPROC

    *==========================================================================
    * BuscarOpContas - Busca operacoes de titulo (SIGOPOPE) para lookup Mov.Titulos
    *==========================================================================
    PROCEDURE BuscarOpContas(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Dopes, Descrs FROM SIGOPOPE WHERE Congvs = 1" + ;
                " ORDER BY Dopes"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOpContas")
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException.Message, "OptBO.BuscarOpContas")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarCondicaoPagamento - Busca condicoes de pagamento (SigOpFp)
    *==========================================================================
    PROCEDURE BuscarCondicaoPagamento(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT FPags, Descrs FROM SigOpFp" + ;
                " WHERE Infos = 'C' AND EmiChqs <> 1" + ;
                " ORDER BY FPags"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaFpg")
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException.Message, "OptBO.BuscarCondicaoPagamento")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

