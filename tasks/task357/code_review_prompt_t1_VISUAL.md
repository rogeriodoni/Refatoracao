# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 192: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 214: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 236: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 258: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 280: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 314: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 430: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 452: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCco.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1646 linhas total):

*-- Linhas 30 a 38:
30:     * Init - Corrige Caption com acentos e delega ao FormBase
31:     *==========================================================================
32:     PROCEDURE Init()
33:         THIS.Caption = "Cadastro de Classifica" + CHR(231) + CHR(227) + "o de Contas"
34:         RETURN DODEFAULT()
35:     ENDPROC
36: 
37:     *==========================================================================
38:     * InicializarForm - Configura estrutura completa

*-- Linhas 84 a 108:
84: 
85:     *==========================================================================
86:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
87:     * Legado: Pagina.Top=-28 -> compensacao +28 em todos os controles
88:     *==========================================================================
89:     PROTECTED PROCEDURE ConfigurarPageFrame()
90:         LOCAL loc_oPg1, loc_oPg2
91: 
92:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
93:         WITH THIS.pgf_4c_Paginas
94:             .PageCount = 2
95:             .Top       = -28
96:             .Left      = -1
97:             .Width     = THIS.Width + 2
98:             .Height    = THIS.Height + 30
99:             .Tabs      = .F.
100:             .Visible   = .T.
101:             .Page1.Caption   = "Lista"
102:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
103:             .Page2.Caption   = "Dados"
104:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
105:             .Page1.BackColor = RGB(100, 100, 100)
106:             .Page2.BackColor = RGB(100, 100, 100)
107:         ENDWITH
108: 

*-- Linhas 125 a 162:
125:         *-- Cabecalho cinza (cntSombra do legado, Top=0 -> +28 = 28)
126:         par_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
127:         WITH par_oPagina.cnt_4c_Cabecalho
128:             .Top         = 28
129:             .Left        = 0
130:             .Width       = THIS.Width
131:             .Height      = 80
132:             .BackColor   = RGB(100, 100, 100)
133:             .BorderWidth = 0
134:             .Visible     = .T.
135:         ENDWITH
136: 
137:         par_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
138:         WITH par_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
139:             .Caption   = "Cadastro de Classifica" + CHR(231) + CHR(227) + "o de Contas"
140:             .Top       = 15
141:             .Left      = 10
142:             .Width     = THIS.Width - 20
143:             .Height    = 40
144:             .AutoSize  = .F.
145:             .FontName  = "Tahoma"
146:             .FontSize  = 16
147:             .FontBold  = .T.
148:             .ForeColor = RGB(0, 0, 0)
149:             .BackStyle = 0
150:             .Visible   = .T.
151:         ENDWITH
152: 
153:         par_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
154:         WITH par_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
155:             .Caption   = "Cadastro de Classifica" + CHR(231) + CHR(227) + "o de Contas"
156:             .Top       = 18
157:             .Left      = 10
158:             .Width     = THIS.Width - 20
159:             .Height    = 46
160:             .AutoSize  = .F.
161:             .FontName  = "Tahoma"
162:             .FontSize  = 16

*-- Linhas 169 a 320:
169:         *-- Container botoes CRUD (Grupo_op: Left=544, Top=-2 -> +28 = 26)
170:         par_oPagina.AddObject("cnt_4c_Botoes", "Container")
171:         WITH par_oPagina.cnt_4c_Botoes
172:             .Top         = 26
173:             .Left        = 542
174:             .Width       = 390
175:             .Height      = 85
176:             .BackStyle = 0
177:             .BorderWidth = 0
178:             .Visible     = .T.
179:         ENDWITH
180: 
181:         par_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
182:         WITH par_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
183:             .Caption         = "Incluir"
184:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
185:             .PicturePosition = 13
186:             .Top             = 5
187:             .Left            = 5
188:             .Width           = 75
189:             .Height          = 75
190:             .BackColor       = RGB(255, 255, 255)
191:             .ForeColor       = RGB(90, 90, 90)
192:             .FontName        = "Comic Sans MS"
193:             .FontBold        = .T.
194:             .FontItalic      = .T.
195:             .FontSize        = 8
196:             .Themes          = .F.
197:             .SpecialEffect   = 0
198:             .MousePointer    = 15
199:             .WordWrap        = .T.
200:             .Visible         = .T.
201:         ENDWITH
202: 
203:         par_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
204:         WITH par_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
205:             .Caption         = "Visualizar"
206:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
207:             .PicturePosition = 13
208:             .Top             = 5
209:             .Left            = 80
210:             .Width           = 75
211:             .Height          = 75
212:             .BackColor       = RGB(255, 255, 255)
213:             .ForeColor       = RGB(90, 90, 90)
214:             .FontName        = "Comic Sans MS"
215:             .FontBold        = .T.
216:             .FontItalic      = .T.
217:             .FontSize        = 8
218:             .Themes          = .F.
219:             .SpecialEffect   = 0
220:             .MousePointer    = 15
221:             .WordWrap        = .T.
222:             .Visible         = .T.
223:         ENDWITH
224: 
225:         par_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
226:         WITH par_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
227:             .Caption         = "Alterar"
228:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
229:             .PicturePosition = 13
230:             .Top             = 5
231:             .Left            = 155
232:             .Width           = 75
233:             .Height          = 75
234:             .BackColor       = RGB(255, 255, 255)
235:             .ForeColor       = RGB(90, 90, 90)
236:             .FontName        = "Comic Sans MS"
237:             .FontBold        = .T.
238:             .FontItalic      = .T.
239:             .FontSize        = 8
240:             .Themes          = .F.
241:             .SpecialEffect   = 0
242:             .MousePointer    = 15
243:             .WordWrap        = .T.
244:             .Visible         = .T.
245:         ENDWITH
246: 
247:         par_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
248:         WITH par_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
249:             .Caption         = "Excluir"
250:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
251:             .PicturePosition = 13
252:             .Top             = 5
253:             .Left            = 230
254:             .Width           = 75
255:             .Height          = 75
256:             .BackColor       = RGB(255, 255, 255)
257:             .ForeColor       = RGB(90, 90, 90)
258:             .FontName        = "Comic Sans MS"
259:             .FontBold        = .T.
260:             .FontItalic      = .T.
261:             .FontSize        = 8
262:             .Themes          = .F.
263:             .SpecialEffect   = 0
264:             .MousePointer    = 15
265:             .WordWrap        = .T.
266:             .Visible         = .T.
267:         ENDWITH
268: 
269:         par_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
270:         WITH par_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
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
281:             .FontBold        = .T.
282:             .FontItalic      = .T.
283:             .FontSize        = 8
284:             .Themes          = .F.
285:             .SpecialEffect   = 0
286:             .MousePointer    = 15
287:             .WordWrap        = .T.
288:             .Visible         = .T.
289:         ENDWITH
290: 
291:         *-- Container Saida - padrao canonico (prevalece sobre SCX legado)
292:         par_oPagina.AddObject("cnt_4c_Saida", "Container")
293:         WITH par_oPagina.cnt_4c_Saida
294:             .Top         = 29
295:             .Left        = 917
296:             .Width       = 90
297:             .Height      = 85
298:             .BackStyle   = 0
299:             .BorderWidth = 0
300:             .Visible     = .T.
301:         ENDWITH
302: 
303:         par_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
304:         WITH par_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
305:             .Caption         = "Encerrar"
306:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
307:             .PicturePosition = 13
308:             .Top             = 5
309:             .Left            = 5
310:             .Width           = 75
311:             .Height          = 75
312:             .BackColor       = RGB(255, 255, 255)
313:             .ForeColor       = RGB(90, 90, 90)
314:             .FontName        = "Comic Sans MS"
315:             .FontBold        = .T.
316:             .FontItalic      = .T.
317:             .FontSize        = 8
318:             .Themes          = .F.
319:             .SpecialEffect   = 0
320:             .MousePointer    = 15

*-- Linhas 327 a 336:
327:         par_oPagina.grd_4c_Lista.RecordSource = ""
328:         par_oPagina.grd_4c_Lista.ColumnCount  = 8
329:         WITH par_oPagina.grd_4c_Lista
330:             .Top                = 115
331:             .Left               = 5
332:             .Width              = 990
333:             .Height             = 510
334:             .RecordMark         = .F.
335:             .DeleteMark         = .F.
336:             .GridLineColor      = RGB(238, 238, 238)

*-- Linhas 347 a 401:
347:             .Visible            = .T.
348:         ENDWITH
349:         WITH par_oPagina.grd_4c_Lista.Column1
350:             .Header1.Caption = "Empresa"
351:             .Width           = 50
352:             .Alignment       = 2
353:         ENDWITH
354:         WITH par_oPagina.grd_4c_Lista.Column2
355:             .Header1.Caption = "Grupo"
356:             .Width           = 90
357:             .Alignment       = 0
358:         ENDWITH
359:         WITH par_oPagina.grd_4c_Lista.Column3
360:             .Header1.Caption = "C" + CHR(243) + "digo"
361:             .Width           = 180
362:             .Alignment       = 0
363:         ENDWITH
364:         WITH par_oPagina.grd_4c_Lista.Column4
365:             .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
366:             .Width           = 290
367:             .Alignment       = 0
368:         ENDWITH
369:         WITH par_oPagina.grd_4c_Lista.Column5
370:             .Header1.Caption = "Prior."
371:             .Width           = 50
372:             .Alignment       = 2
373:         ENDWITH
374:         WITH par_oPagina.grd_4c_Lista.Column6
375:             .Header1.Caption = "Faixa De"
376:             .Width           = 100
377:             .Alignment       = 1
378:         ENDWITH
379:         WITH par_oPagina.grd_4c_Lista.Column7
380:             .Header1.Caption = "Faixa At" + CHR(233)
381:             .Width           = 100
382:             .Alignment       = 1
383:         ENDWITH
384:         WITH par_oPagina.grd_4c_Lista.Column8
385:             .Header1.Caption = "Selecio."
386:             .Width           = 120
387:             .Alignment       = 0
388:         ENDWITH
389: 
390:         *-- BINDEVENTs dos botoes CRUD (metodos PUBLIC - sem PROTECTED)
391:         BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
392:         BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
393:         BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
394:         BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
395:         BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
396:         BINDEVENT(par_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
397: 
398:         THIS.TornarControlesVisiveis(par_oPagina)
399:     ENDPROC
400: 
401:     *==========================================================================

*-- Linhas 408 a 458:
408:         *-- Container botoes Confirmar/Cancelar (Grupo_Salva: Left=841, Top=-3 -> +28=25)
409:         par_oPagina.AddObject("cnt_4c_Salva", "Container")
410:         WITH par_oPagina.cnt_4c_Salva
411:             .Top         = 25
412:             .Left        = 841
413:             .Width       = 165
414:             .Height      = 85
415:             .BackStyle   = 0
416:             .Visible     = .T.
417:         ENDWITH
418: 
419:         par_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Salvar", "CommandButton")
420:         WITH par_oPagina.cnt_4c_Salva.cmd_4c_Salvar
421:             .Caption         = "Confirmar"
422:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
423:             .PicturePosition = 13
424:             .Top             = 5
425:             .Left            = 5
426:             .Width           = 75
427:             .Height          = 75
428:             .BackColor       = RGB(255, 255, 255)
429:             .ForeColor       = RGB(90, 90, 90)
430:             .FontName        = "Comic Sans MS"
431:             .FontBold        = .T.
432:             .FontItalic      = .T.
433:             .FontSize        = 8
434:             .Themes          = .F.
435:             .SpecialEffect   = 0
436:             .MousePointer    = 15
437:             .WordWrap        = .T.
438:             .Visible         = .T.
439:         ENDWITH
440: 
441:         par_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
442:         WITH par_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
443:             .Caption         = "Encerrar"
444:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
445:             .PicturePosition = 13
446:             .Top             = 5
447:             .Left            = 80
448:             .Width           = 75
449:             .Height          = 75
450:             .BackColor       = RGB(255, 255, 255)
451:             .ForeColor       = RGB(90, 90, 90)
452:             .FontName        = "Comic Sans MS"
453:             .FontBold        = .T.
454:             .FontItalic      = .T.
455:             .FontSize        = 8
456:             .Themes          = .F.
457:             .SpecialEffect   = 0
458:             .MousePointer    = 15

*-- Linhas 465 a 540:
465:         *-- Top original 49-53 -> +28 = 77-81
466:         *----------------------------------------------------------------------
467: 
468:         *-- lbl_4c_Codigo (Say2: Left=95, Top=53 -> +28=81)
469:         par_oPagina.AddObject("lbl_4c_Codigo", "Label")
470:         WITH par_oPagina.lbl_4c_Codigo
471:             .Caption   = "C" + CHR(243) + "digo :"
472:             .Left      = 95
473:             .Top       = 81
474:             .FontName  = "Tahoma"
475:             .FontSize  = 8
476:             .FontBold  = .F.
477:             .ForeColor = RGB(90, 90, 90)
478:             .BackStyle = 0
479:             .Visible   = .T.
480:         ENDWITH
481: 
482:         *-- txt_4c_Codigo (Get_codigo: Left=139, Top=49 -> +28=77, Width=80, codigos C80)
483:         par_oPagina.AddObject("txt_4c_Codigo", "TextBox")
484:         WITH par_oPagina.txt_4c_Codigo
485:             .Value         = ""
486:             .Left          = 139
487:             .Top           = 77
488:             .Width         = 80
489:             .Height        = 23
490:             .SpecialEffect = 1
491:             .FontName      = "Tahoma"
492:             .FontSize      = 8
493:             .ForeColor     = RGB(0, 0, 0)
494:             .BorderColor   = RGB(100, 100, 100)
495:             .MaxLength     = 80
496:             .Visible       = .T.
497:         ENDWITH
498: 
499:         *-- lbl_4c_Descricao (Say3: Left=270, Top=53 -> +28=81)
500:         par_oPagina.AddObject("lbl_4c_Descricao", "Label")
501:         WITH par_oPagina.lbl_4c_Descricao
502:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
503:             .Left      = 270
504:             .Top       = 81
505:             .FontName  = "Tahoma"
506:             .FontSize  = 8
507:             .FontBold  = .F.
508:             .ForeColor = RGB(90, 90, 90)
509:             .BackStyle = 0
510:             .Visible   = .T.
511:         ENDWITH
512: 
513:         *-- txt_4c_Descricao (Get_descricao: Left=327, Top=49 -> +28=77, Width=220, descs C220)
514:         par_oPagina.AddObject("txt_4c_Descricao", "TextBox")
515:         WITH par_oPagina.txt_4c_Descricao
516:             .Value         = ""
517:             .Left          = 327
518:             .Top           = 77
519:             .Width         = 220
520:             .Height        = 23
521:             .SpecialEffect = 1
522:             .FontName      = "Tahoma"
523:             .FontSize      = 8
524:             .ForeColor     = RGB(0, 0, 0)
525:             .BorderColor   = RGB(100, 100, 100)
526:             .MaxLength     = 220
527:             .Visible       = .T.
528:         ENDWITH
529: 
530:         *-- lbl_4c_ClcStatus (Say8: Left=573, Top=52 -> +28=80)
531:         par_oPagina.AddObject("lbl_4c_ClcStatus", "Label")
532:         WITH par_oPagina.lbl_4c_ClcStatus
533:             .Caption   = "Selecionavel nos Cadastros :"
534:             .Left      = 573
535:             .Top       = 80
536:             .FontName  = "Tahoma"
537:             .FontSize  = 8
538:             .FontBold  = .F.
539:             .ForeColor = RGB(90, 90, 90)
540:             .BackStyle = 0

*-- Linhas 546 a 579:
546:         par_oPagina.AddObject("opt_4c_ClcStatus", "OptionGroup")
547:         WITH par_oPagina.opt_4c_ClcStatus
548:             .ButtonCount = 2
549:             .Left        = 711
550:             .Top         = 75
551:             .Width       = 105
552:             .Height      = 26
553:             .BackStyle   = 0
554:             .BorderStyle = 0
555:             .Value       = 1
556:             .Visible     = .T.
557:         ENDWITH
558:         WITH par_oPagina.opt_4c_ClcStatus.Buttons(1)
559:             .Caption   = "Sim"
560:             .BackStyle = 0
561:             .Left      = 5
562:             .Top       = 5
563:             .Width     = 40
564:             .AutoSize  = .T.
565:             .ForeColor = RGB(90, 90, 90)
566:             .Themes    = .F.
567:             .FontName  = "Tahoma"
568:             .FontSize  = 8
569:         ENDWITH
570:         WITH par_oPagina.opt_4c_ClcStatus.Buttons(2)
571:             .Caption   = "N" + CHR(227) + "o"
572:             .BackStyle = 0
573:             .Left      = 51
574:             .Top       = 5
575:             .Width     = 44
576:             .AutoSize  = .T.
577:             .ForeColor = RGB(90, 90, 90)
578:             .Themes    = .F.
579:             .FontName  = "Tahoma"

*-- Linhas 585 a 598:
585:         *-- Top original 74-78 -> +28 = 102-106
586:         *----------------------------------------------------------------------
587: 
588:         *-- lbl_4c_Grupo (Say1: Left=99, Top=78 -> +28=106)
589:         par_oPagina.AddObject("lbl_4c_Grupo", "Label")
590:         WITH par_oPagina.lbl_4c_Grupo
591:             .Caption   = "Grupo :"
592:             .Left      = 99
593:             .Top       = 106
594:             .FontName  = "Tahoma"
595:             .FontSize  = 8
596:             .FontBold  = .F.
597:             .ForeColor = RGB(90, 90, 90)
598:             .BackStyle = 0

*-- Linhas 604 a 613:
604:         par_oPagina.AddObject("txt_4c_Grupo", "TextBox")
605:         WITH par_oPagina.txt_4c_Grupo
606:             .Value         = ""
607:             .Left          = 139
608:             .Top           = 102
609:             .Width         = 80
610:             .Height        = 23
611:             .SpecialEffect = 1
612:             .FontName      = "Tahoma"
613:             .FontSize      = 8

*-- Linhas 619 a 646:
619:         BINDEVENT(par_oPagina.txt_4c_Grupo, "KeyPress",  THIS, "TxtGrupoKeyPress")
620:         BINDEVENT(par_oPagina.txt_4c_Grupo, "KeyPress", THIS, "ValidarGrupo")
621: 
622:         *-- lbl_4c_Priori (Say7: Left=268, Top=78 -> +28=106)
623:         par_oPagina.AddObject("lbl_4c_Priori", "Label")
624:         WITH par_oPagina.lbl_4c_Priori
625:             .Caption   = "Prioridade :"
626:             .Left      = 268
627:             .Top       = 106
628:             .FontName  = "Tahoma"
629:             .FontSize  = 8
630:             .FontBold  = .F.
631:             .ForeColor = RGB(90, 90, 90)
632:             .BackStyle = 0
633:             .Visible   = .T.
634:         ENDWITH
635: 
636:         *-- txt_4c_Priori (GetPriori: Left=327, Top=74 -> +28=102, Width=26, InputMask="99")
637:         par_oPagina.AddObject("txt_4c_Priori", "TextBox")
638:         WITH par_oPagina.txt_4c_Priori
639:             .Value         = 0
640:             .Left          = 327
641:             .Top           = 102
642:             .Width         = 26
643:             .Height        = 23
644:             .SpecialEffect = 1
645:             .FontName      = "Tahoma"
646:             .FontSize      = 8

*-- Linhas 656 a 683:
656:         *-- Top original 99-103 -> +28 = 127-131
657:         *----------------------------------------------------------------------
658: 
659:         *-- lbl_4c_Empresa (Say6: Left=87, Top=103 -> +28=131)
660:         par_oPagina.AddObject("lbl_4c_Empresa", "Label")
661:         WITH par_oPagina.lbl_4c_Empresa
662:             .Caption   = "Empresa :"
663:             .Left      = 87
664:             .Top       = 131
665:             .FontName  = "Tahoma"
666:             .FontSize  = 8
667:             .FontBold  = .F.
668:             .ForeColor = RGB(90, 90, 90)
669:             .BackStyle = 0
670:             .Visible   = .T.
671:         ENDWITH
672: 
673:         *-- txt_4c_Emps (GetEmps: Left=139, Top=99 -> +28=127, Width=34, H=23, C(3))
674:         par_oPagina.AddObject("txt_4c_Emps", "TextBox")
675:         WITH par_oPagina.txt_4c_Emps
676:             .Value         = ""
677:             .Left          = 139
678:             .Top           = 127
679:             .Width         = 34
680:             .Height        = 23
681:             .SpecialEffect = 1
682:             .FontName      = "Tahoma"
683:             .FontSize      = 8

*-- Linhas 689 a 747:
689:         BINDEVENT(par_oPagina.txt_4c_Emps, "KeyPress",  THIS, "TxtEmpsKeyPress")
690:         BINDEVENT(par_oPagina.txt_4c_Emps, "KeyPress", THIS, "ValidarEmps")
691: 
692:         *-- lbl_4c_FaixaDe (Say4: Left=275, Top=103 -> +28=131)
693:         par_oPagina.AddObject("lbl_4c_FaixaDe", "Label")
694:         WITH par_oPagina.lbl_4c_FaixaDe
695:             .Caption   = "Faixa de :"
696:             .Left      = 275
697:             .Top       = 131
698:             .FontName  = "Tahoma"
699:             .FontSize  = 8
700:             .FontBold  = .F.
701:             .ForeColor = RGB(90, 90, 90)
702:             .BackStyle = 0
703:             .Visible   = .T.
704:         ENDWITH
705: 
706:         *-- txt_4c_FaixaI (Get_faixai: Left=327, Top=99 -> +28=127, Width=108, H=23)
707:         par_oPagina.AddObject("txt_4c_FaixaI", "TextBox")
708:         WITH par_oPagina.txt_4c_FaixaI
709:             .Value         = 0
710:             .Left          = 327
711:             .Top           = 127
712:             .Width         = 108
713:             .Height        = 23
714:             .SpecialEffect = 1
715:             .FontName      = "Tahoma"
716:             .FontSize      = 8
717:             .ForeColor     = RGB(0, 0, 0)
718:             .BorderColor   = RGB(100, 100, 100)
719:             .InputMask     = "9999999999.99"
720:             .Visible       = .T.
721:         ENDWITH
722: 
723:         *-- lbl_4c_FaixaAte (Say5: Left=439, Top=103 -> +28=131)
724:         par_oPagina.AddObject("lbl_4c_FaixaAte", "Label")
725:         WITH par_oPagina.lbl_4c_FaixaAte
726:             .Caption   = "at" + CHR(233) + " :"
727:             .Left      = 439
728:             .Top       = 131
729:             .FontName  = "Tahoma"
730:             .FontSize  = 8
731:             .FontBold  = .F.
732:             .ForeColor = RGB(90, 90, 90)
733:             .BackStyle = 0
734:             .Visible   = .T.
735:         ENDWITH
736: 
737:         *-- txt_4c_FaixaF (Get_faixaf: Left=461, Top=99 -> +28=127, Width=115, H=23)
738:         par_oPagina.AddObject("txt_4c_FaixaF", "TextBox")
739:         WITH par_oPagina.txt_4c_FaixaF
740:             .Value         = 0
741:             .Left          = 461
742:             .Top           = 127
743:             .Width         = 115
744:             .Height        = 23
745:             .SpecialEffect = 1
746:             .FontName      = "Tahoma"
747:             .FontSize      = 8

*-- Linhas 761 a 770:
761:             .ColumnCount       = 3
762:             .FontName          = "Tahoma"
763:             .FontSize          = 8
764:             .Left              = 98
765:             .Top               = 160
766:             .Width             = 706
767:             .Height            = 464
768:             .AllowHeaderSizing = .F.
769:             .AllowRowSizing    = .F.
770:             .DeleteMark        = .F.

*-- Linhas 787 a 795:
787:                 .FontName      = "Tahoma"
788:                 .FontSize      = 8
789:                 WITH .Header1
790:                     .Caption   = "Motivo"
791:                     .FontName  = "Tahoma"
792:                     .FontSize  = 8
793:                     .Alignment = 2
794:                 ENDWITH
795:                 WITH .Text1

*-- Linhas 815 a 823:
815:                 .FontName      = "Tahoma"
816:                 .FontSize      = 8
817:                 WITH .Header1
818:                     .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
819:                     .FontName  = "Tahoma"
820:                     .FontSize  = 8
821:                     .Alignment = 2
822:                 ENDWITH
823:                 WITH .Text1

*-- Linhas 844 a 852:
844:                 .FontName      = "Tahoma"
845:                 .FontSize      = 8
846:                 WITH .Header1
847:                     .Caption   = "Tipo"
848:                     .FontName  = "Tahoma"
849:                     .FontSize  = 8
850:                     .Alignment = 2
851:                 ENDWITH
852:             ENDWITH

*-- Linhas 859 a 906:
859:             .BorderStyle = 0
860:             .AutoSize    = .F.
861:             .Value       = 1
862:             .Left        = 2
863:             .Top         = 2
864:             .Width       = 191
865:             .Height      = 16
866:             .BackStyle   = 0
867:         ENDWITH
868:         WITH par_oPagina.grd_4c_Motivos.Column3.opt_4c_Tipos.Buttons(1)
869:             .Caption  = "Inserir"
870:             .BackStyle = 0
871:             .Value    = 1
872:             .Left     = 5
873:             .Top      = 2
874:             .Width    = 48
875:             .Height   = 14
876:             .AutoSize = .T.
877:             .FontSize = 8
878:         ENDWITH
879:         WITH par_oPagina.grd_4c_Motivos.Column3.opt_4c_Tipos.Buttons(2)
880:             .Caption  = "Excluir"
881:             .BackStyle = 0
882:             .Left     = 60
883:             .Top      = 2
884:             .Width    = 50
885:             .Height   = 14
886:             .AutoSize = .T.
887:             .FontSize = 8
888:         ENDWITH
889:         WITH par_oPagina.grd_4c_Motivos.Column3.opt_4c_Tipos.Buttons(3)
890:             .Caption  = "Nenhum"
891:             .BackStyle = 0
892:             .Left     = 120
893:             .Top      = 2
894:             .Width    = 61
895:             .Height   = 15
896:             .FontSize = 8
897:         ENDWITH
898: 
899:         *-- BINDEVENTs dos botoes Confirmar/Cancelar
900:         BINDEVENT(par_oPagina.cnt_4c_Salva.cmd_4c_Salvar,   "Click", THIS, "BtnSalvarClick")
901:         BINDEVENT(par_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
902: 
903:         THIS.TornarControlesVisiveis(par_oPagina)
904:     ENDPROC
905: 
906:     *==========================================================================

*-- Linhas 933 a 948:
933:                         loc_oGrid.Column7.ControlSource     = "cursor_4c_Dados.faixafs"
934:                         loc_oGrid.Column8.ControlSource     = "cursor_4c_Dados.ClcStatus"
935:                         *-- Redefinir headers apos RecordSource (VFP reseta automaticamente)
936:                         loc_oGrid.Column1.Header1.Caption   = "Empresa"
937:                         loc_oGrid.Column2.Header1.Caption   = "Grupo"
938:                         loc_oGrid.Column3.Header1.Caption   = "C" + CHR(243) + "digo"
939:                         loc_oGrid.Column4.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
940:                         loc_oGrid.Column5.Header1.Caption   = "Prior."
941:                         loc_oGrid.Column6.Header1.Caption   = "Faixa De"
942:                         loc_oGrid.Column7.Header1.Caption   = "Faixa At" + CHR(233)
943:                         loc_oGrid.Column8.Header1.Caption   = "Selecio."
944:                         THIS.FormatarGridLista(loc_oGrid)
945:                     ENDIF
946:                 ENDIF
947:             ENDIF
948:         CATCH TO loException

*-- Linhas 1179 a 1194:
1179:                     loc_oGrid.Column6.ControlSource     = "cursor_4c_Dados.faixais"
1180:                     loc_oGrid.Column7.ControlSource     = "cursor_4c_Dados.faixafs"
1181:                     loc_oGrid.Column8.ControlSource     = "cursor_4c_Dados.ClcStatus"
1182:                     loc_oGrid.Column1.Header1.Caption   = "Empresa"
1183:                     loc_oGrid.Column2.Header1.Caption   = "Grupo"
1184:                     loc_oGrid.Column3.Header1.Caption   = "C" + CHR(243) + "digo"
1185:                     loc_oGrid.Column4.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1186:                     loc_oGrid.Column5.Header1.Caption   = "Prior."
1187:                     loc_oGrid.Column6.Header1.Caption   = "Faixa De"
1188:                     loc_oGrid.Column7.Header1.Caption   = "Faixa At" + CHR(233)
1189:                     loc_oGrid.Column8.Header1.Caption   = "Selecio."
1190:                     THIS.FormatarGridLista(loc_oGrid)
1191:                 ENDIF
1192:             ENDIF
1193:         ENDIF
1194:     ENDPROC

*-- Linhas 1607 a 1619:
1607:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1608:             IF VARTYPE(loc_oPg2) = "O"
1609:                 IF PEMSTATUS(loc_oPg2, "cnt_4c_Salva", 5)
1610:                     IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Salvar", 5)
1611:                         loc_oPg2.cnt_4c_Salva.cmd_4c_Salvar.Enabled  = loc_lConfirmar
1612:                     ENDIF
1613:                     IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Cancelar", 5)
1614:                         loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled = .T.
1615:                     ENDIF
1616:                 ENDIF
1617:             ENDIF
1618:         CATCH TO loException
1619:             MsgErro("Erro em FormCco.AjustarBotoesPorModo: " + loException.Message, "Erro")


### BO (C:\4c\projeto\app\classes\CcoBO.prg):
*==============================================================================
* CcoBO.prg - Business Object para Classificacao de Contas (SigCdClc)
* Tabela principal : SigCdClc
* Tabela detalhe  : SigCdCmt (motivos/tipos da classificacao)
* Chave primaria  : cIdChaves (UUID gerado por fUniqueIds)
*==============================================================================
DEFINE CLASS CcoBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Campos da tabela SigCdClc
    *--------------------------------------------------------------------------
    this_cIdChaves      = ""    && cIdChaves   C     - chave primaria (UUID)
    this_cEmps          = ""    && Emps        C(3)  - empresa
    this_cGrupos        = ""    && grupos      C(10) - grupo de conta corrente (FK SigCdGcr)
    this_cCodigos       = ""    && codigos     C(80) - codigo da classificacao
    this_cDescs         = ""    && descs       C(220)- descricao
    this_nPrioridades   = 0     && Prioridades N(2)  - prioridade
    this_nFaixaIs       = 0     && faixais     N(12,2) - faixa inicial
    this_nFaixaFs       = 0     && faixafs     N(12,2) - faixa final
    this_nClcStatus     = 1     && ClcStatus   N(1)  - 1=Sim (selecionavel), 2=Nao

    *--------------------------------------------------------------------------
    * Nomes dos cursores auxiliares
    *--------------------------------------------------------------------------
    this_cCursorMotivos = "crMotivos"    && cursor local de motivos (SigCdCmt + SigCdFs)
    this_cCursorGrupos  = "crSigCdGcr"  && cursor de grupos (SigCdGcr)

    *--------------------------------------------------------------------------
    * Contexto de filtragem (definido pelo Form conforme parametro pCli do legado)
    *--------------------------------------------------------------------------
    this_cGruposFiltro   = ""    && grupo padrao (de SigCdPam.GrPadClis)
    this_lClientesFiltro = .F.   && .T. = filtrar pelo grupo, .F. = excluir o grupo

    *==========================================================================
    * Init - Configura tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdClc"
            THIS.this_cCampoChave = "cIdChaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MsgErro(loException.Message, "CcoBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cIdChaves
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Popula propriedades a partir de cursor aberto
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cIdChaves    = TratarNulo(cIdChaves,   "C")
                THIS.this_cEmps        = TratarNulo(Emps,        "C")
                THIS.this_cGrupos      = TratarNulo(grupos,      "C")
                THIS.this_cCodigos     = TratarNulo(codigos,     "C")
                THIS.this_cDescs       = TratarNulo(descs,       "C")
                THIS.this_nPrioridades = TratarNulo(Prioridades, "N")
                THIS.this_nFaixaIs     = TratarNulo(faixais,     "N")
                THIS.this_nFaixaFs     = TratarNulo(faixafs,     "N")
                THIS.this_nClcStatus   = TratarNulo(ClcStatus,   "N")
                IF THIS.this_nClcStatus = 0
                    THIS.this_nClcStatus = 1
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CcoBO.CarregarDoCursor: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - SELECT de SigCdClc para o grid (cursor_4c_Dados)
    * Aplica filtro de grupo conforme this_cGruposFiltro / this_lClientesFiltro
    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cFiltro) != "C"
                par_cFiltro = ""
            ENDIF

            loc_cWhere = ""

            IF !EMPTY(ALLTRIM(THIS.this_cGruposFiltro))
                IF THIS.this_lClientesFiltro
                    loc_cWhere = " WHERE grupos = " + EscaparSQL(THIS.this_cGruposFiltro)
                ELSE
                    loc_cWhere = " WHERE NOT grupos = " + EscaparSQL(THIS.this_cGruposFiltro)
                ENDIF
            ENDIF

            IF !EMPTY(ALLTRIM(par_cFiltro))
                IF EMPTY(loc_cWhere)
                    loc_cWhere = " WHERE " + par_cFiltro
                ELSE
                    loc_cWhere = loc_cWhere + " AND " + par_cFiltro
                ENDIF
            ENDIF

            loc_cSQL = "SELECT cIdChaves, Emps, grupos, codigos, descs," + ;
                       " Prioridades, faixais, faixafs, ClcStatus" + ;
                       " FROM SigCdClc" + loc_cWhere + ;
                       " ORDER BY grupos, codigos"

            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar classifica" + CHR(231) + CHR(245) + "es: " + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CcoBO.Buscar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (cIdChaves)
    *==========================================================================
    FUNCTION CarregarPorCodigo(par_cIdChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cIdChaves, Emps, grupos, codigos, descs," + ;
                       " Prioridades, faixais, faixafs, ClcStatus" + ;
                       " FROM SigCdClc" + ;
                       " WHERE cIdChaves = " + EscaparSQL(par_cIdChaves)

            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MsgErro("Erro ao carregar classifica" + CHR(231) + CHR(227) + "o: " + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CcoBO.CarregarPorCodigo: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BuscarParametros - Carrega GrPadClis de SigCdPam
    * Popula this_cGruposFiltro
    *==========================================================================
    FUNCTION BuscarParametros()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT GrPadClis FROM SigCdPam"

            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Pam") > 0
                SELECT cursor_4c_Pam
                THIS.this_cGruposFiltro = PADR(TratarNulo(GrPadClis, "C"), 10)
                loc_lSucesso = .T.
            ELSE
                THIS.this_cGruposFiltro = ""
                loc_lSucesso = .T.
            ENDIF

            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CcoBO.BuscarParametros: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BuscarGrupos - Carrega SigCdGcr para lookup (cursor crSigCdGcr)
    *==========================================================================
    FUNCTION BuscarGrupos()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr ORDER BY Codigos"

            IF USED("crSigCdGcr")
                USE IN crSigCdGcr
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdGcr")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar grupos: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CcoBO.BuscarGrupos: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarMotivosClassif - Carrega motivos de uma classificacao (SigCdCmt + SigCdFs)
    * Popula cursor crMotivos (Codigos C10, Descrs C40, Tipos N1)
    * par_cIdChaves: cIdChaves da classificacao
    *==========================================================================
    FUNCTION CarregarMotivosClassif(par_cIdChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_ClaMt")
                USE IN cursor_4c_ClaMt
            ENDIF

            loc_cSQL = "SELECT a.Codigos, b.Descrs, a.Tipos" + ;
                       " FROM SigCdCmt a, SigCdFs b" + ;
                       " WHERE a.fkChaves = " + EscaparSQL(par_cIdChaves) + ;
                       " AND a.Codigos = b.codigos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClaMt")
            IF loc_nResultado >= 0
                SELECT crMotivos
                ZAP IN crMotivos
                SELECT cursor_4c_ClaMt
                SCAN
                    INSERT INTO crMotivos (Codigos, Descrs, Tipos) ;
                        VALUES (cursor_4c_ClaMt.Codigos, cursor_4c_ClaMt.Descrs, cursor_4c_ClaMt.Tipos)
                ENDSCAN
                IF USED("cursor_4c_ClaMt")
                    USE IN cursor_4c_ClaMt
                ENDIF
                GO TOP IN crMotivos
                loc_lSucesso = .T.
            ELSE
                IF USED("cursor_4c_ClaMt")
                    USE IN cursor_4c_ClaMt
                ENDIF
                MsgErro("Erro ao carregar motivos: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_ClaMt")
                USE IN cursor_4c_ClaMt
            ENDIF
            MsgErro("Erro em CcoBO.CarregarMotivosClassif: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CompletarMotivosFS - Adiciona ao cursor crMotivos os motivos de SigCdFs
    * ausentes (com Tipos=3, Nenhum). Usado em modo INSERIR/ALTERAR.
    *==========================================================================
    FUNCTION CompletarMotivosFS()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCodigos
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_MdSc")
                USE IN cursor_4c_MdSc
            ENDIF

            loc_cSQL = "SELECT codigos, descrs FROM SigCdFs ORDER BY codigos"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MdSc")

            IF loc_nResultado >= 0
                SELECT cursor_4c_MdSc
                SCAN
                    loc_cCodigos = ALLTRIM(cursor_4c_MdSc.codigos)
                    IF !USED("crMotivos") OR EOF("crMotivos")
                        INSERT INTO crMotivos (Codigos, Descrs, Tipos) ;
                            VALUES (loc_cCodigos, cursor_4c_MdSc.descrs, 3)
                    ELSE
                        SELECT crMotivos
                        GO TOP IN crMotivos
                        LOCATE FOR ALLTRIM(crMotivos.Codigos) = loc_cCodigos
                        IF EOF("crMotivos")
                            INSERT INTO crMotivos (Codigos, Descrs, Tipos) ;
                                VALUES (loc_cCodigos, cursor_4c_MdSc.descrs, 3)
                        ENDIF
                    ENDIF
                ENDSCAN

                IF USED("cursor_4c_MdSc")
                    USE IN cursor_4c_MdSc
                ENDIF
                GO TOP IN crMotivos
                loc_lSucesso = .T.
            ELSE
                IF USED("cursor_4c_MdSc")
                    USE IN cursor_4c_MdSc
                ENDIF
                MsgErro("Erro ao carregar motivos FS: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_MdSc")
                USE IN cursor_4c_MdSc
            ENDIF
            MsgErro("Erro em CcoBO.CompletarMotivosFS: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * VerificarDuplicidade - Verifica se grupo+codigos+emps ja existe em SigCdClc
    * Retorna .T. se JA EXISTE (duplicado), .F. se pode inserir
    *==========================================================================
    FUNCTION VerificarDuplicidade(par_cEmps, par_cGrupos, par_cCodigos, par_cIdChavesExcluir)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            IF VARTYPE(par_cIdChavesExcluir) != "C"
                par_cIdChavesExcluir = ""
            ENDIF

            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdClc" + ;
                       " WHERE Emps = " + EscaparSQL(par_cEmps) + ;
                       " AND grupos = " + EscaparSQL(par_cGrupos) + ;
                       " AND codigos = " + EscaparSQL(par_cCodigos)

            IF !EMPTY(ALLTRIM(par_cIdChavesExcluir))
                loc_cSQL = loc_cSQL + " AND NOT cIdChaves = " + EscaparSQL(par_cIdChavesExcluir)
            ENDIF

            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dup")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Dup") > 0
                SELECT cursor_4c_Dup
                loc_lExiste = (cursor_4c_Dup.qtd > 0)
            ENDIF

            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF
            MsgErro("Erro em CcoBO.VerificarDuplicidade: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lExiste
    ENDFUNC

    *==========================================================================
    * VerificarFaixaSobreposta - Verifica se faixa sobrepe outra existente
    * Retorna "" se OK, ou mensagem descricao do conflito
    *==========================================================================
    FUNCTION VerificarFaixaSobreposta(par_cEmps, par_cGrupos, par_nFaixaI, par_nFaixaF, par_cIdChavesExcluir)
        LOCAL loc_cSQL, loc_nResultado, loc_cMensagem
        loc_cMensagem = ""

        TRY
            IF VARTYPE(par_cIdChavesExcluir) != "C"
                par_cIdChavesExcluir = ""
            ENDIF

            loc_cSQL = "SELECT descs, faixais, faixafs FROM SigCdClc" + ;
                       " WHERE Emps = " + EscaparSQL(par_cEmps) + ;
                       " AND grupos = " + EscaparSQL(par_cGrupos) + ;
                       " AND NOT cIdChaves = " + EscaparSQL(par_cIdChavesExcluir) + ;
                       " AND (" + ;
                       "   (" + FormatarNumeroSQL(par_nFaixaI) + " BETWEEN faixais AND faixafs)" + ;
                       "   OR (" + FormatarNumeroSQL(par_nFaixaF) + " BETWEEN faixais AND faixafs)" + ;
                       "   OR (faixais BETWEEN " + FormatarNumeroSQL(par_nFaixaI) + " AND " + FormatarNumeroSQL(par_nFaixaF) + ")" + ;
                       "   OR (faixafs BETWEEN " + FormatarNumeroSQL(par_nFaixaI) + " AND " + FormatarNumeroSQL(par_nFaixaF) + ")" + ;
                       ")"

            IF USED("cursor_4c_Faixa")
                USE IN cursor_4c_Faixa
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Faixa")
            IF loc_nResultado >= 0 AND !EOF("cursor_4c_Faixa")
                SELECT cursor_4c_Faixa
                loc_cMensagem = "Faixa Cadastrada no C" + CHR(243) + "digo " + ;
                    ALLTRIM(cursor_4c_Faixa.descs) + CHR(13) + ;
                    "Valor : " + ALLTRIM(STR(cursor_4c_Faixa.faixais, 12, 2)) + ;
                    " " + CHR(224) + " " + ALLTRIM(STR(cursor_4c_Faixa.faixafs, 12, 2))
            ENDIF

            IF USED("cursor_4c_Faixa")
                USE IN cursor_4c_Faixa
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_Faixa")
                USE IN cursor_4c_Faixa
            ENDIF
            MsgErro("Erro em CcoBO.VerificarFaixaSobreposta: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_cMensagem
    ENDFUNC

    *==========================================================================
    * VerificarVinculoCli - Verifica se classificacao tem conta vinculada em SigCdCli
    * Retorna .T. se existir vinculo (bloqueio de exclusao)
    *==========================================================================
    FUNCTION VerificarVinculoCli(par_cGrupos, par_cCodigos)
        LOCAL loc_cSQL, loc_nResultado, loc_lTemVinculo
        loc_lTemVinculo = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdCli" + ;
                       " WHERE grupos = " + EscaparSQL(par_cGrupos) + ;
                       " AND codigos = " + EscaparSQL(par_cCodigos)

            IF USED("cursor_4c_VinCli")
                USE IN cursor_4c_VinCli
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VinCli")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_VinCli") > 0
                SELECT cursor_4c_VinCli
                loc_lTemVinculo = (cursor_4c_VinCli.qtd > 0)
            ENDIF

            IF USED("cursor_4c_VinCli")
                USE IN cursor_4c_VinCli
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_VinCli")
                USE IN cursor_4c_VinCli
            ENDIF
            MsgErro("Erro em CcoBO.VerificarVinculoCli: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lTemVinculo
    ENDFUNC

    *==========================================================================
    * SalvarMotivos - Delete + Insert de SigCdCmt para a classificacao atual
    * par_cIdChaves: cIdChaves da classificacao
    * par_cCursorMotivos: nome do cursor com os motivos a salvar
    *   (colunas: Codigos C10, Descrs C40, Tipos N1 - tipos 1 e 2 sao salvos)
    *==========================================================================
    FUNCTION SalvarMotivos(par_cIdChaves, par_cCursorMotivos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cIdMot
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdCmt WHERE fkChaves = " + EscaparSQL(par_cIdChaves)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MsgErro("Erro ao excluir motivos antigos: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED(par_cCursorMotivos)
                    SELECT (par_cCursorMotivos)
                    GO TOP
                    SCAN
                        IF INLIST(Tipos, 1, 2)
                            loc_cIdMot = fUniqueIds()
                            loc_cSQL = "INSERT INTO SigCdCmt (fkChaves, cIdChaves, Codigos, Tipos)" + ;
                                       " VALUES (" + EscaparSQL(par_cIdChaves) + ;
                                       ", " + EscaparSQL(loc_cIdMot) + ;
                                       ", " + EscaparSQL(ALLTRIM(Codigos)) + ;
                                       ", " + FormatarNumeroSQL(Tipos) + ")"
                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                            IF loc_nResultado < 0
                                MsgErro("Erro ao gravar motivo: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
                                loc_lSucesso = .F.
                                EXIT
                            ENDIF
                        ENDIF
                    ENDSCAN
                    loc_lSucesso = .T.
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CcoBO.SalvarMotivos: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Inserir - INSERT INTO SigCdClc (chamado pelo BusinessBase.Salvar)
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cIdChaves))
                THIS.this_cIdChaves = fUniqueIds()
            ENDIF

            loc_cSQL = "INSERT INTO SigCdClc" + ;
                       " (cIdChaves, Emps, grupos, codigos, descs," + ;
                       " Prioridades, faixais, faixafs, ClcStatus)" + ;
                       " VALUES (" + EscaparSQL(THIS.this_cIdChaves) + ;
                       ", " + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ;
                       ", " + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + ;
                       ", " + EscaparSQL(LEFT(THIS.this_cCodigos, 80)) + ;
                       ", " + EscaparSQL(LEFT(THIS.this_cDescs, 220)) + ;
                       ", " + FormatarNumeroSQL(THIS.this_nPrioridades) + ;
                       ", " + FormatarNumeroSQL(THIS.this_nFaixaIs) + ;
                       ", " + FormatarNumeroSQL(THIS.this_nFaixaFs) + ;
                       ", " + FormatarNumeroSQL(THIS.this_nClcStatus) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir classifica" + CHR(231) + CHR(227) + "o: " + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CcoBO.Inserir: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE SigCdClc (chamado pelo BusinessBase.Salvar)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdClc SET" + ;
                       " Emps = " + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ;
                       ", grupos = " + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + ;
                       ", codigos = " + EscaparSQL(LEFT(THIS.this_cCodigos, 80)) + ;
                       ", descs = " + EscaparSQL(LEFT(THIS.this_cDescs, 220)) + ;
                       ", Prioridades = " + FormatarNumeroSQL(THIS.this_nPrioridades) + ;
                       ", faixais = " + FormatarNumeroSQL(THIS.this_nFaixaIs) + ;
                       ", faixafs = " + FormatarNumeroSQL(THIS.this_nFaixaFs) + ;
                       ", ClcStatus = " + FormatarNumeroSQL(THIS.this_nClcStatus) + ;
                       " WHERE cIdChaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar classifica" + CHR(231) + CHR(227) + "o: " + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CcoBO.Atualizar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - DELETE SigCdClc + cascade SigCdCmt
    * (chamado pelo BusinessBase.Excluir via PublicExcluir)
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdCmt WHERE fkChaves = " + EscaparSQL(THIS.this_cIdChaves)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MsgErro("Erro ao excluir motivos: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_cSQL = "DELETE FROM SigCdClc WHERE cIdChaves = " + EscaparSQL(THIS.this_cIdChaves)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao excluir classifica" + CHR(231) + CHR(227) + "o: " + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CcoBO.ExecutarExclusao: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

