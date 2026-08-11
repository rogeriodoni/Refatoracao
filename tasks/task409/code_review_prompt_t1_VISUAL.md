# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 185: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 208: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 231: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 254: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 277: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 313: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 391: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 414: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormEVE.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1276 linhas total):

*-- Linhas 59 a 68:
59:             ELSE
60:                 THIS.ConfigurarPageFrame()
61: 
62:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
63:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
64: 
65:                 THIS.pgf_4c_Paginas.Visible   = .T.
66:                 THIS.pgf_4c_Paginas.ActivePage = 1
67:                 THIS.this_cModoAtual           = "LISTA"
68: 

*-- Linhas 89 a 106:
89: 
90:         WITH loc_oPgf
91:             .PageCount       = 2
92:             .Top             = -29
93:             .Left            = 0
94:             .Width           = THIS.Width
95:             .Height          = THIS.Height + 29
96:             .Tabs            = .F.
97:             .Visible         = .T.
98:             .Page1.Caption   = "Lista"
99:             .Page1.BackColor = RGB(100, 100, 100)
100:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
101:             .Page2.Caption   = "Dados"
102:             .Page2.BackColor = RGB(100, 100, 100)
103:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
104:         ENDWITH
105: 
106:         THIS.ConfigurarPaginaLista()

*-- Linhas 118 a 156:
118:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
119:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
120:         WITH loc_oCab
121:             .Top         = 30
122:             .Left        = 0
123:             .Width       = THIS.Width
124:             .Height      = 80
125:             .BackColor   = RGB(100, 100, 100)
126:             .BorderWidth = 0
127:             .Visible     = .T.
128:         ENDWITH
129: 
130:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
131:         WITH loc_oCab.lbl_4c_Sombra
132:             .AutoSize  = .F.
133:             .Caption   = THIS.Caption
134:             .Top       = 15
135:             .Left      = 10
136:             .Width     = THIS.Width
137:             .Height    = 40
138:             .FontName  = "Tahoma"
139:             .FontSize  = 16
140:             .FontBold  = .T.
141:             .ForeColor = RGB(0, 0, 0)
142:             .BackStyle = 0
143:             .Visible   = .T.
144:         ENDWITH
145: 
146:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
147:         WITH loc_oCab.lbl_4c_Titulo
148:             .AutoSize  = .F.
149:             .Caption   = THIS.Caption
150:             .Top       = 18
151:             .Left      = 10
152:             .Width     = THIS.Width
153:             .Height    = 46
154:             .FontName  = "Tahoma"
155:             .FontSize  = 16
156:             .FontBold  = .T.

*-- Linhas 163 a 340:
163:         loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
164:         loc_oBotoes = loc_oPg1.cnt_4c_Botoes
165:         WITH loc_oBotoes
166:             .Top         = 29
167:             .Left        = 542
168:             .Width       = 390
169:             .Height      = 85
170:             .BackColor   = RGB(53, 53, 53)
171:             .BackStyle   = 1
172:             .BorderWidth = 0
173:             .Visible     = .T.
174:         ENDWITH
175: 
176:         loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
177:         WITH loc_oBotoes.cmd_4c_Incluir
178:             .Caption         = "Incluir"
179:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
180:             .PicturePosition = 13
181:             .Top             = 5
182:             .Left            = 5
183:             .Width           = 75
184:             .Height          = 75
185:             .FontName        = "Comic Sans MS"
186:             .FontSize        = 8
187:             .FontBold        = .T.
188:             .FontItalic      = .T.
189:             .ForeColor       = RGB(90, 90, 90)
190:             .BackColor       = RGB(255, 255, 255)
191:             .Themes          = .F.
192:             .SpecialEffect   = 0
193:             .MousePointer    = 15
194:             .WordWrap        = .T.
195:             .Visible         = .T.
196:         ENDWITH
197:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
198: 
199:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
200:         WITH loc_oBotoes.cmd_4c_Visualizar
201:             .Caption         = "Visualizar"
202:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
203:             .PicturePosition = 13
204:             .Top             = 5
205:             .Left            = 80
206:             .Width           = 75
207:             .Height          = 75
208:             .FontName        = "Comic Sans MS"
209:             .FontSize        = 8
210:             .FontBold        = .T.
211:             .FontItalic      = .T.
212:             .ForeColor       = RGB(90, 90, 90)
213:             .BackColor       = RGB(255, 255, 255)
214:             .Themes          = .F.
215:             .SpecialEffect   = 0
216:             .MousePointer    = 15
217:             .WordWrap        = .T.
218:             .Visible         = .T.
219:         ENDWITH
220:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
221: 
222:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
223:         WITH loc_oBotoes.cmd_4c_Alterar
224:             .Caption         = "Alterar"
225:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
226:             .PicturePosition = 13
227:             .Top             = 5
228:             .Left            = 155
229:             .Width           = 75
230:             .Height          = 75
231:             .FontName        = "Comic Sans MS"
232:             .FontSize        = 8
233:             .FontBold        = .T.
234:             .FontItalic      = .T.
235:             .ForeColor       = RGB(90, 90, 90)
236:             .BackColor       = RGB(255, 255, 255)
237:             .Themes          = .F.
238:             .SpecialEffect   = 0
239:             .MousePointer    = 15
240:             .WordWrap        = .T.
241:             .Visible         = .T.
242:         ENDWITH
243:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
244: 
245:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
246:         WITH loc_oBotoes.cmd_4c_Excluir
247:             .Caption         = "Excluir"
248:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
249:             .PicturePosition = 13
250:             .Top             = 5
251:             .Left            = 230
252:             .Width           = 75
253:             .Height          = 75
254:             .FontName        = "Comic Sans MS"
255:             .FontSize        = 8
256:             .FontBold        = .T.
257:             .FontItalic      = .T.
258:             .ForeColor       = RGB(90, 90, 90)
259:             .BackColor       = RGB(255, 255, 255)
260:             .Themes          = .F.
261:             .SpecialEffect   = 0
262:             .MousePointer    = 15
263:             .WordWrap        = .T.
264:             .Visible         = .T.
265:         ENDWITH
266:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
267: 
268:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
269:         WITH loc_oBotoes.cmd_4c_Buscar
270:             .Caption         = "Buscar"
271:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
272:             .PicturePosition = 13
273:             .Top             = 5
274:             .Left            = 305
275:             .Width           = 75
276:             .Height          = 75
277:             .FontName        = "Comic Sans MS"
278:             .FontSize        = 8
279:             .FontBold        = .T.
280:             .FontItalic      = .T.
281:             .ForeColor       = RGB(90, 90, 90)
282:             .BackColor       = RGB(255, 255, 255)
283:             .Themes          = .F.
284:             .SpecialEffect   = 0
285:             .MousePointer    = 15
286:             .WordWrap        = .T.
287:             .Visible         = .T.
288:         ENDWITH
289:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
290: 
291:         *-- Container Encerrar (canonico: Left=917, Width=90)
292:         loc_oPg1.AddObject("cnt_4c_Saida", "Container")
293:         loc_oSaida = loc_oPg1.cnt_4c_Saida
294:         WITH loc_oSaida
295:             .Top         = 29
296:             .Left        = 917
297:             .Width       = 90
298:             .Height      = 85
299:             .BackStyle   = 0
300:             .BorderWidth = 0
301:             .Visible     = .T.
302:         ENDWITH
303: 
304:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
305:         WITH loc_oSaida.cmd_4c_Encerrar
306:             .Caption         = "Encerrar"
307:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
308:             .PicturePosition = 13
309:             .Top             = 5
310:             .Left            = 5
311:             .Width           = 75
312:             .Height          = 75
313:             .FontName        = "Comic Sans MS"
314:             .FontSize        = 8
315:             .FontBold        = .T.
316:             .FontItalic      = .T.
317:             .ForeColor       = RGB(90, 90, 90)
318:             .BackColor       = RGB(255, 255, 255)
319:             .Themes          = .F.
320:             .SpecialEffect   = 0
321:             .MousePointer    = 15
322:             .WordWrap        = .T.
323:             .Visible         = .T.
324:         ENDWITH
325:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
326: 
327:         *-- Grid de listagem (Grade legado: Top=88+29=117, Left=26)
328:         loc_oPg1.AddObject("grd_4c_Lista", "Grid")
329:         loc_oGrid = loc_oPg1.grd_4c_Lista
330: 
331:         loc_oGrid.ColumnCount = 4
332: 
333:         WITH loc_oGrid
334:             .Top                = 117
335:             .Left               = 26
336:             .Width              = 880
337:             .Height             = 460
338:             .FontName           = "Verdana"
339:             .FontSize           = 8
340:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 370 a 455:
370:         loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
371:         loc_oBotoes = loc_oPg2.cnt_4c_BotoesAcao
372:         WITH loc_oBotoes
373:             .Top         = 40
374:             .Left        = 817
375:             .Width       = 160
376:             .Height      = 85
377:             .BackStyle   = 0
378:             .BorderWidth = 0
379:             .Visible     = .T.
380:         ENDWITH
381: 
382:         loc_oBotoes.AddObject("cmd_4c_Confirmar", "CommandButton")
383:         WITH loc_oBotoes.cmd_4c_Confirmar
384:             .Caption         = "Confirmar"
385:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
386:             .PicturePosition = 13
387:             .Top             = 5
388:             .Left            = 5
389:             .Width           = 75
390:             .Height          = 75
391:             .FontName        = "Comic Sans MS"
392:             .FontSize        = 8
393:             .FontBold        = .T.
394:             .FontItalic      = .T.
395:             .ForeColor       = RGB(90, 90, 90)
396:             .BackColor       = RGB(255, 255, 255)
397:             .Themes          = .F.
398:             .SpecialEffect   = 0
399:             .MousePointer    = 15
400:             .WordWrap        = .T.
401:             .Visible         = .T.
402:         ENDWITH
403:         BINDEVENT(loc_oBotoes.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
404: 
405:         loc_oBotoes.AddObject("cmd_4c_Cancelar", "CommandButton")
406:         WITH loc_oBotoes.cmd_4c_Cancelar
407:             .Caption         = "Encerrar"
408:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
409:             .PicturePosition = 13
410:             .Top             = 5
411:             .Left            = 81
412:             .Width           = 75
413:             .Height          = 75
414:             .FontName        = "Comic Sans MS"
415:             .FontSize        = 8
416:             .FontBold        = .T.
417:             .FontItalic      = .T.
418:             .ForeColor       = RGB(90, 90, 90)
419:             .BackColor       = RGB(255, 255, 255)
420:             .Themes          = .F.
421:             .SpecialEffect   = 0
422:             .MousePointer    = 15
423:             .WordWrap        = .T.
424:             .Visible         = .T.
425:         ENDWITH
426:         BINDEVENT(loc_oBotoes.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
427: 
428:         *-- ================================================================
429:         *-- CAMPO 1: Codigo
430:         *-- Say1: Top=141+29=170, Left=319 | getCodigo: Top=136+29=165
431:         *-- ================================================================
432:         loc_oPg2.AddObject("lbl_4c_Codigo", "Label")
433:         WITH loc_oPg2.lbl_4c_Codigo
434:             .Caption   = "C" + CHR(243) + "digo :"
435:             .Top       = 170
436:             .Left      = 319
437:             .FontName  = "Tahoma"
438:             .FontSize  = 8
439:             .FontBold  = .F.
440:             .ForeColor = RGB(90, 90, 90)
441:             .BackStyle = 0
442:             .Visible   = .T.
443:         ENDWITH
444: 
445:         loc_oPg2.AddObject("txt_4c_Codigo", "TextBox")
446:         WITH loc_oPg2.txt_4c_Codigo
447:             .Value         = ""
448:             .Format        = "K!"
449:             .Top           = 165
450:             .Left          = 365
451:             .Width         = 96
452:             .Height        = 24
453:             .SpecialEffect = 1
454:             .FontName      = "Tahoma"
455:             .FontSize      = 8

*-- Linhas 464 a 490:
464:         *-- CAMPO 2: Nome
465:         *-- Say2: Top=167+29=196, Left=325 | getNome: Top=163+29=192
466:         *-- ================================================================
467:         loc_oPg2.AddObject("lbl_4c_Nome", "Label")
468:         WITH loc_oPg2.lbl_4c_Nome
469:             .Caption   = "Nome :"
470:             .Top       = 196
471:             .Left      = 325
472:             .FontName  = "Tahoma"
473:             .FontSize  = 8
474:             .FontBold  = .F.
475:             .ForeColor = RGB(90, 90, 90)
476:             .BackStyle = 0
477:             .Visible   = .T.
478:         ENDWITH
479: 
480:         loc_oPg2.AddObject("txt_4c_Nome", "TextBox")
481:         WITH loc_oPg2.txt_4c_Nome
482:             .Value         = ""
483:             .Format        = "K!"
484:             .Top           = 192
485:             .Left          = 365
486:             .Width         = 336
487:             .Height        = 24
488:             .SpecialEffect = 1
489:             .FontName      = "Tahoma"
490:             .FontSize      = 8

*-- Linhas 498 a 524:
498:         *-- CAMPO 3: Descricao/Evento
499:         *-- Say3: Top=194+29=223, Left=306 | GetEvento: Top=190+29=219
500:         *-- ================================================================
501:         loc_oPg2.AddObject("lbl_4c_Descricao", "Label")
502:         WITH loc_oPg2.lbl_4c_Descricao
503:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
504:             .Top       = 223
505:             .Left      = 306
506:             .FontName  = "Tahoma"
507:             .FontSize  = 8
508:             .FontBold  = .F.
509:             .ForeColor = RGB(90, 90, 90)
510:             .BackStyle = 0
511:             .Visible   = .T.
512:         ENDWITH
513: 
514:         loc_oPg2.AddObject("txt_4c_Evento", "TextBox")
515:         WITH loc_oPg2.txt_4c_Evento
516:             .Value         = ""
517:             .Format        = "K!"
518:             .Top           = 219
519:             .Left          = 365
520:             .Width         = 336
521:             .Height        = 24
522:             .SpecialEffect = 1
523:             .FontName      = "Tahoma"
524:             .FontSize      = 8

*-- Linhas 532 a 559:
532:         *-- Say5: Top=220+29=249, Left=323 | getGrupo: Top=217+29=246
533:         *-- getDGrupo (descricao): Left=447, Width=290, Height=23
534:         *-- ================================================================
535:         loc_oPg2.AddObject("lbl_4c_Grupo", "Label")
536:         WITH loc_oPg2.lbl_4c_Grupo
537:             .AutoSize  = .T.
538:             .Caption   = "Grupo :"
539:             .Top       = 249
540:             .Left      = 323
541:             .Width     = 38
542:             .FontName  = "Tahoma"
543:             .FontSize  = 8
544:             .FontBold  = .F.
545:             .ForeColor = RGB(90, 90, 90)
546:             .BackStyle = 0
547:             .Visible   = .T.
548:         ENDWITH
549: 
550:         loc_oPg2.AddObject("txt_4c_Grupo", "TextBox")
551:         WITH loc_oPg2.txt_4c_Grupo
552:             .Value         = ""
553:             .Top           = 246
554:             .Left          = 365
555:             .Width         = 80
556:             .Height        = 24
557:             .SpecialEffect = 1
558:             .FontName      = "Tahoma"
559:             .FontSize      = 8

*-- Linhas 568 a 577:
568:         WITH loc_oPg2.txt_4c_DGrupo
569:             .Value         = ""
570:             .ReadOnly      = .T.
571:             .Top           = 246
572:             .Left          = 447
573:             .Width         = 290
574:             .Height        = 23
575:             .SpecialEffect = 1
576:             .FontName      = "Tahoma"
577:             .FontSize      = 8

*-- Linhas 585 a 611:
585:         *-- getConta: Top=243+29=272, Left=365, Width=80 (ref SigCdCli.Iclis)
586:         *-- getDConta: Left=447, Width=290, ReadOnly (exibe SigCdCli.Rclis)
587:         *-- ================================================================
588:         loc_oPg2.AddObject("lbl_4c_Conta", "Label")
589:         WITH loc_oPg2.lbl_4c_Conta
590:             .AutoSize  = .T.
591:             .Caption   = "Conta :"
592:             .Top       = 275
593:             .Left      = 323
594:             .FontName  = "Tahoma"
595:             .FontSize  = 8
596:             .FontBold  = .F.
597:             .ForeColor = RGB(90, 90, 90)
598:             .BackStyle = 0
599:             .Visible   = .T.
600:         ENDWITH
601: 
602:         loc_oPg2.AddObject("txt_4c_Conta", "TextBox")
603:         WITH loc_oPg2.txt_4c_Conta
604:             .Value         = ""
605:             .Top           = 272
606:             .Left          = 365
607:             .Width         = 80
608:             .Height        = 24
609:             .SpecialEffect = 1
610:             .FontName      = "Tahoma"
611:             .FontSize      = 8

*-- Linhas 621 a 630:
621:         WITH loc_oPg2.txt_4c_DConta
622:             .Value         = ""
623:             .ReadOnly      = .T.
624:             .Top           = 272
625:             .Left          = 447
626:             .Width         = 290
627:             .Height        = 23
628:             .SpecialEffect = 1
629:             .FontName      = "Tahoma"
630:             .FontSize      = 8

*-- Linhas 637 a 663:
637:         *-- CAMPO 6: Status
638:         *-- GetStatus: Top=269+29=298, Left=365, Width=184, MaxLength=50
639:         *-- ================================================================
640:         loc_oPg2.AddObject("lbl_4c_Status", "Label")
641:         WITH loc_oPg2.lbl_4c_Status
642:             .AutoSize  = .T.
643:             .Caption   = "Status :"
644:             .Top       = 302
645:             .Left      = 319
646:             .FontName  = "Tahoma"
647:             .FontSize  = 8
648:             .FontBold  = .F.
649:             .ForeColor = RGB(90, 90, 90)
650:             .BackStyle = 0
651:             .Visible   = .T.
652:         ENDWITH
653: 
654:         loc_oPg2.AddObject("txt_4c_Status", "TextBox")
655:         WITH loc_oPg2.txt_4c_Status
656:             .Value         = ""
657:             .Top           = 298
658:             .Left          = 365
659:             .Width         = 184
660:             .Height        = 24
661:             .SpecialEffect = 1
662:             .FontName      = "Tahoma"
663:             .FontSize      = 8

*-- Linhas 738 a 755:
738:                 loc_oGrid.RecordSource            = "cursor_4c_Dados"
739:                 loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.Codigo"
740:                 loc_oGrid.Column1.Width           = 80
741:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
742:                 loc_oGrid.Column2.ControlSource   = "cursor_4c_Dados.Nome"
743:                 loc_oGrid.Column2.Width           = 400
744:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
745:                 loc_oGrid.Column3.ControlSource   = "cursor_4c_Dados.Grupo"
746:                 loc_oGrid.Column3.Width           = 100
747:                 loc_oGrid.Column3.Header1.Caption = "Grupo"
748:                 loc_oGrid.Column4.ControlSource   = "cursor_4c_Dados.Conta"
749:                 loc_oGrid.Column4.Width           = 100
750:                 loc_oGrid.Column4.Header1.Caption = "Conta"
751:                 THIS.FormatarGridLista(loc_oGrid)
752:                 loc_lResultado = .T.
753:             ENDIF
754:         CATCH TO loc_oErro
755:             MsgErro(loc_oErro.Message, "FormEVE.CarregarLista")

*-- Linhas 1266 a 1275:
1266:         loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1267: 
1268:         TRY
1269:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando
1270:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1271:         CATCH TO loc_oErro
1272:             MsgErro(loc_oErro.Message, "FormEVE.AjustarBotoesPorModo")
1273:         ENDTRY
1274:     ENDPROC
1275: 


### BO (C:\4c\projeto\app\classes\EVEBO.prg):
*==============================================================================
* EVEBO.prg - Business Object para Eventos
* Tabela: SigCdEve
* Arquitetura: Camada de Negocio (BusinessBase)
*==============================================================================

DEFINE CLASS EVEBO AS BusinessBase

    *-- Chave primaria (gerada automaticamente no INSERT)
    this_cPkChaves   = ""   && pkChaves char(20) - PK

    *-- Campos da tabela SigCdEve
    this_cCodigo     = ""   && Codigo   char(10)
    this_cNome       = ""   && Nome     char(100)
    this_cEvento     = ""   && Evento   char(100)
    this_cStatus     = ""   && Status   char(50)
    this_cGrupo      = ""   && Grupo    char(10)  (ref SigCdGcr.Codigos)
    this_cConta      = ""   && Conta    char(10)  (ref SigCdCli.Iclis)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdEve"
            THIS.this_cCampoChave = "pkChaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "EVEBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cPkChaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cPkChaves = TratarNulo(pkChaves, "C")
                THIS.this_cCodigo   = TratarNulo(Codigo,   "C")
                THIS.this_cNome     = TratarNulo(Nome,     "C")
                THIS.this_cEvento   = TratarNulo(Evento,   "C")
                THIS.this_cStatus   = TratarNulo(Status,   "C")
                THIS.this_cGrupo    = TratarNulo(Grupo,    "C")
                THIS.this_cConta    = TratarNulo(Conta,    "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "EVEBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCodigo)
            MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarCodigoExistente(THIS.this_cCodigo)
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " Cadastrado!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cNome)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarCodigoExistente - Verifica se Codigo ja existe no banco
    *--------------------------------------------------------------------------
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdEve" + ;
                " WHERE Codigo = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
                SELECT cursor_4c_ChkCod
                loc_lExiste = (cursor_4c_ChkCod.qtd > 0)
                USE IN cursor_4c_ChkCod
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "EVEBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCdEve
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cPkChaves = SYS(2015) + SYS(2015)

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdEve (pkChaves, Codigo, Nome, Evento, Status, Grupo, Conta)
                VALUES (
                    <<EscaparSQL(THIS.this_cPkChaves)>>,
                    <<EscaparSQL(THIS.this_cCodigo)>>,
                    <<EscaparSQL(THIS.this_cNome)>>,
                    <<EscaparSQL(THIS.this_cEvento)>>,
                    <<EscaparSQL(THIS.this_cStatus)>>,
                    <<EscaparSQL(THIS.this_cGrupo)>>,
                    <<EscaparSQL(THIS.this_cConta)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir evento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "EVEBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigCdEve
    * Nota: Codigo (chave de negocio) nao e alteravel pelo usuario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdEve
                SET Nome   = <<EscaparSQL(THIS.this_cNome)>>,
                    Evento = <<EscaparSQL(THIS.this_cEvento)>>,
                    Status = <<EscaparSQL(THIS.this_cStatus)>>,
                    Grupo  = <<EscaparSQL(THIS.this_cGrupo)>>,
                    Conta  = <<EscaparSQL(THIS.this_cConta)>>
                WHERE pkChaves = <<EscaparSQL(THIS.this_cPkChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar evento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "EVEBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigCdEve
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdEve WHERE pkChaves = " + ;
                EscaparSQL(THIS.this_cPkChaves)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir evento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "EVEBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com colunas do grid: Codigo, Nome, Grupo, Conta
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (pkChaves C(20), Codigo C(10), Nome C(100), Grupo C(10), Conta C(10))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT pkChaves, Codigo, Nome, Grupo, Conta FROM SigCdEve"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY Codigo"

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
                        MostrarErro("Erro ao buscar eventos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar eventos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "EVEBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo Codigo (chave de negocio)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT pkChaves, Codigo, Nome, Evento, Status, Grupo, Conta" + ;
                " FROM SigCdEve WHERE Codigo = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Evento n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar evento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "EVEBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterDescricaoGrupo - Obtem descricao do grupo em SigCdGcr
    * Chamado pelo Form em BOParaForm para popular txt_4c_DGrupo
    *--------------------------------------------------------------------------
    PROCEDURE ObterDescricaoGrupo(par_cGrupo)
        LOCAL loc_cSQL, loc_nResultado, loc_cDescricao
        loc_cDescricao = ""

        IF EMPTY(par_cGrupo)
            RETURN loc_cDescricao
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 Descrs FROM SigCdGcr WHERE Codigos = " + ;
                EscaparSQL(par_cGrupo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoDesc")
            IF loc_nResultado >= 0 AND USED("cursor_4c_GrupoDesc")
                SELECT cursor_4c_GrupoDesc
                IF !EOF()
                    loc_cDescricao = TratarNulo(Descrs, "C")
                ENDIF
                USE IN cursor_4c_GrupoDesc
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao obter descri" + CHR(231) + CHR(227) + "o do grupo:" + CHR(13) + loException.Message, "EVEBO.ObterDescricaoGrupo")
        ENDTRY

        RETURN loc_cDescricao
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterDescricaoConta - Obtem descricao da conta em SigCdCli
    * Chamado pelo Form em BOParaForm para popular txt_4c_DConta
    *--------------------------------------------------------------------------
    PROCEDURE ObterDescricaoConta(par_cConta)
        LOCAL loc_cSQL, loc_nResultado, loc_cDescricao
        loc_cDescricao = ""

        IF EMPTY(par_cConta)
            RETURN loc_cDescricao
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 Rclis FROM SigCdCli WHERE Iclis = " + ;
                EscaparSQL(par_cConta)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaDesc")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ContaDesc")
                SELECT cursor_4c_ContaDesc
                IF !EOF()
                    loc_cDescricao = TratarNulo(Rclis, "C")
                ENDIF
                USE IN cursor_4c_ContaDesc
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao obter descri" + CHR(231) + CHR(227) + "o da conta:" + CHR(13) + loException.Message, "EVEBO.ObterDescricaoConta")
        ENDTRY

        RETURN loc_cDescricao
    ENDPROC

ENDDEFINE

