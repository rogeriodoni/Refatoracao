# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 187: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 211: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 235: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 259: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 283: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 320: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 405: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 429: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCat.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1228 linhas total):

*-- Linhas 84 a 101:
84: 
85:         WITH THIS.pgf_4c_Paginas
86:             .PageCount  = 2
87:             .Top        = -29
88:             .Left       = 0
89:             .Width      = THIS.Width
90:             .Height     = THIS.Height + 29
91:             .Tabs       = .F.
92:             .Visible    = .T.
93:             .Page1.Caption   = "Lista"
94:             .Page1.BackColor = RGB(225, 225, 225)
95:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
96:             .Page2.Caption   = "Dados"
97:             .Page2.BackColor = RGB(225, 225, 225)
98:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
99:         ENDWITH
100: 
101:         THIS.ConfigurarPaginaLista()

*-- Linhas 116 a 152:
116:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
117: 
118:         WITH loc_oPagina.cnt_4c_Cabecalho
119:             .Top         = 31
120:             .Left        = 0
121:             .Width       = THIS.Width
122:             .Height      = 80
123:             .BackColor   = RGB(100, 100, 100)
124:             .BorderWidth = 0
125:             .Visible     = .T.
126: 
127:             .AddObject("lbl_4c_Sombra", "Label")
128:             WITH .lbl_4c_Sombra
129:                 .Caption   = "Categorias de Produto"
130:                 .Top       = 15
131:                 .Left      = 10
132:                 .Width     = THIS.Width
133:                 .Height    = 40
134:                 .FontName  = "Tahoma"
135:                 .FontSize  = 16
136:                 .FontBold  = .T.
137:                 .ForeColor = RGB(0, 0, 0)
138:                 .BackStyle = 0
139:                 .AutoSize  = .F.
140:                 .Visible   = .T.
141:             ENDWITH
142: 
143:             .AddObject("lbl_4c_Titulo", "Label")
144:             WITH .lbl_4c_Titulo
145:                 .Caption   = "Categorias de Produto"
146:                 .Top       = 18
147:                 .Left      = 10
148:                 .Width     = THIS.Width
149:                 .Height    = 46
150:                 .FontName  = "Tahoma"
151:                 .FontSize  = 16
152:                 .FontBold  = .T.

*-- Linhas 162 a 289:
162:         loc_oCnt = loc_oPagina.cnt_4c_Botoes
163: 
164:         WITH loc_oCnt
165:             .Top         = 29
166:             .Left        = 542
167:             .Width       = 390
168:             .Height      = 85
169:             .BackStyle   = 1
170:             .BackColor   = RGB(53, 53, 53)
171:             .BorderWidth = 0
172:             .Visible     = .T.
173:         ENDWITH
174: 
175:         *-- Botao Incluir
176:         loc_oCnt.AddObject("cmd_4c_Incluir", "CommandButton")
177:         WITH loc_oCnt.cmd_4c_Incluir
178:             .Caption         = "Incluir"
179:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
180:             .PicturePosition = 13
181:             .Top             = 5
182:             .Left            = 5
183:             .Width           = 75
184:             .Height          = 75
185:             .BackColor       = RGB(255, 255, 255)
186:             .ForeColor       = RGB(90, 90, 90)
187:             .FontName        = "Comic Sans MS"
188:             .FontSize        = 8
189:             .FontBold        = .T.
190:             .FontItalic      = .T.
191:             .Themes          = .F.
192:             .SpecialEffect   = 0
193:             .MousePointer    = 15
194:             .WordWrap        = .T.
195:             .AutoSize        = .F.
196:             .Visible         = .T.
197:         ENDWITH
198: 
199:         *-- Botao Visualizar
200:         loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
201:         WITH loc_oCnt.cmd_4c_Visualizar
202:             .Caption         = "Visualizar"
203:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
204:             .PicturePosition = 13
205:             .Top             = 5
206:             .Left            = 80
207:             .Width           = 75
208:             .Height          = 75
209:             .BackColor       = RGB(255, 255, 255)
210:             .ForeColor       = RGB(90, 90, 90)
211:             .FontName        = "Comic Sans MS"
212:             .FontSize        = 8
213:             .FontBold        = .T.
214:             .FontItalic      = .T.
215:             .Themes          = .F.
216:             .SpecialEffect   = 0
217:             .MousePointer    = 15
218:             .WordWrap        = .T.
219:             .AutoSize        = .F.
220:             .Visible         = .T.
221:         ENDWITH
222: 
223:         *-- Botao Alterar
224:         loc_oCnt.AddObject("cmd_4c_Alterar", "CommandButton")
225:         WITH loc_oCnt.cmd_4c_Alterar
226:             .Caption         = "Alterar"
227:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
228:             .PicturePosition = 13
229:             .Top             = 5
230:             .Left            = 155
231:             .Width           = 75
232:             .Height          = 75
233:             .BackColor       = RGB(255, 255, 255)
234:             .ForeColor       = RGB(90, 90, 90)
235:             .FontName        = "Comic Sans MS"
236:             .FontSize        = 8
237:             .FontBold        = .T.
238:             .FontItalic      = .T.
239:             .Themes          = .F.
240:             .SpecialEffect   = 0
241:             .MousePointer    = 15
242:             .WordWrap        = .T.
243:             .AutoSize        = .F.
244:             .Visible         = .T.
245:         ENDWITH
246: 
247:         *-- Botao Excluir
248:         loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
249:         WITH loc_oCnt.cmd_4c_Excluir
250:             .Caption         = "Excluir"
251:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
252:             .PicturePosition = 13
253:             .Top             = 5
254:             .Left            = 230
255:             .Width           = 75
256:             .Height          = 75
257:             .BackColor       = RGB(255, 255, 255)
258:             .ForeColor       = RGB(90, 90, 90)
259:             .FontName        = "Comic Sans MS"
260:             .FontSize        = 8
261:             .FontBold        = .T.
262:             .FontItalic      = .T.
263:             .Themes          = .F.
264:             .SpecialEffect   = 0
265:             .MousePointer    = 15
266:             .WordWrap        = .T.
267:             .AutoSize        = .F.
268:             .Visible         = .T.
269:         ENDWITH
270: 
271:         *-- Botao Buscar
272:         loc_oCnt.AddObject("cmd_4c_Buscar", "CommandButton")
273:         WITH loc_oCnt.cmd_4c_Buscar
274:             .Caption         = "Buscar"
275:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
276:             .PicturePosition = 13
277:             .Top             = 5
278:             .Left            = 305
279:             .Width           = 75
280:             .Height          = 75
281:             .BackColor       = RGB(255, 255, 255)
282:             .ForeColor       = RGB(90, 90, 90)
283:             .FontName        = "Comic Sans MS"
284:             .FontSize        = 8
285:             .FontBold        = .T.
286:             .FontItalic      = .T.
287:             .Themes          = .F.
288:             .SpecialEffect   = 0
289:             .MousePointer    = 15

*-- Linhas 296 a 326:
296:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
297: 
298:         WITH loc_oPagina.cnt_4c_Saida
299:             .Top         = 29
300:             .Left        = 917
301:             .Width       = 90
302:             .Height      = 85
303:             .BackStyle   = 0
304:             .BorderWidth = 0
305:             .Visible     = .T.
306:         ENDWITH
307: 
308:         *-- Botao Encerrar
309:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
310:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
311:             .Caption         = "Encerrar"
312:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
313:             .PicturePosition = 13
314:             .Top             = 5
315:             .Left            = 5
316:             .Width           = 75
317:             .Height          = 75
318:             .BackColor       = RGB(255, 255, 255)
319:             .ForeColor       = RGB(90, 90, 90)
320:             .FontName        = "Comic Sans MS"
321:             .FontSize        = 8
322:             .FontBold        = .T.
323:             .FontItalic      = .T.
324:             .Themes          = .F.
325:             .SpecialEffect   = 0
326:             .MousePointer    = 15

*-- Linhas 334 a 343:
334:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
335:         loc_oGrid = loc_oPagina.grd_4c_Lista
336: 
337:         loc_oGrid.Top               = 117
338:         loc_oGrid.Left              = 26
339:         loc_oGrid.Width             = 890
340:         loc_oGrid.Height            = 470
341:         loc_oGrid.FontName          = "Verdana"
342:         loc_oGrid.FontSize          = 8
343:         loc_oGrid.ForeColor         = RGB(90, 90, 90)

*-- Linhas 355 a 368:
355:         loc_oGrid.Visible           = .T.
356: 
357:         *-- BINDEVENTs para botoes CRUD e duplo clique no grid
358:         BINDEVENT(loc_oCnt.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
359:         BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
360:         BINDEVENT(loc_oCnt.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
361:         BINDEVENT(loc_oCnt.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
362:         BINDEVENT(loc_oCnt.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
363:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
364:         BINDEVENT(loc_oGrid, "DblClick", THIS, "BtnVisualizarClick")
365: 
366:         THIS.TornarControlesVisiveis(loc_oPagina)
367:     ENDPROC
368: 

*-- Linhas 381 a 485:
381:         loc_oCnt = loc_oPagina.cnt_4c_BotoesAcao
382: 
383:         WITH loc_oCnt
384:             .Top         = 33
385:             .Left        = 842
386:             .Width       = 160
387:             .Height      = 85
388:             .BackStyle   = 0
389:             .BorderWidth = 0
390:             .Visible     = .T.
391:         ENDWITH
392: 
393:         *-- Botao Confirmar (Salvar)
394:         loc_oCnt.AddObject("cmd_4c_Confirmar", "CommandButton")
395:         WITH loc_oCnt.cmd_4c_Confirmar
396:             .Caption         = "Confirmar"
397:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
398:             .PicturePosition = 13
399:             .Top             = 5
400:             .Left            = 5
401:             .Width           = 75
402:             .Height          = 75
403:             .BackColor       = RGB(255, 255, 255)
404:             .ForeColor       = RGB(90, 90, 90)
405:             .FontName        = "Comic Sans MS"
406:             .FontSize        = 8
407:             .FontBold        = .T.
408:             .FontItalic      = .T.
409:             .Themes          = .F.
410:             .SpecialEffect   = 0
411:             .MousePointer    = 15
412:             .WordWrap        = .T.
413:             .AutoSize        = .F.
414:             .Visible         = .T.
415:         ENDWITH
416: 
417:         *-- Botao Cancelar
418:         loc_oCnt.AddObject("cmd_4c_Cancelar", "CommandButton")
419:         WITH loc_oCnt.cmd_4c_Cancelar
420:             .Caption         = "Encerrar"
421:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
422:             .PicturePosition = 13
423:             .Top             = 5
424:             .Left            = 80
425:             .Width           = 75
426:             .Height          = 75
427:             .BackColor       = RGB(255, 255, 255)
428:             .ForeColor       = RGB(90, 90, 90)
429:             .FontName        = "Comic Sans MS"
430:             .FontSize        = 8
431:             .FontBold        = .T.
432:             .FontItalic      = .T.
433:             .Themes          = .F.
434:             .SpecialEffect   = 0
435:             .MousePointer    = 15
436:             .WordWrap        = .T.
437:             .AutoSize        = .F.
438:             .Visible         = .T.
439:         ENDWITH
440: 
441:         *-- BINDEVENTs para botoes de acao
442:         BINDEVENT(loc_oCnt.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
443:         BINDEVENT(loc_oCnt.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
444: 
445:         *-- ============================================================
446:         *-- Container cabecalho Page2 (cinza, mesmo estilo da Page1)
447:         *-- ============================================================
448:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
449: 
450:         WITH loc_oPagina.cnt_4c_Cabecalho
451:             .Top         = 31
452:             .Left        = 0
453:             .Width       = THIS.Width
454:             .Height      = 80
455:             .BackColor   = RGB(100, 100, 100)
456:             .BorderWidth = 0
457:             .Visible     = .T.
458:             .AddObject("lbl_4c_Sombra", "Label")
459:             .AddObject("lbl_4c_Titulo", "Label")
460:         ENDWITH
461: 
462:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
463:             .Caption   = "Categorias de Produto"
464:             .Top       = 15
465:             .Left      = 10
466:             .Width     = THIS.Width - 20
467:             .Height    = 40
468:             .FontName  = "Tahoma"
469:             .FontSize  = 16
470:             .FontBold  = .T.
471:             .ForeColor = RGB(0, 0, 0)
472:             .BackStyle = 0
473:             .AutoSize  = .F.
474:             .Visible   = .T.
475:         ENDWITH
476: 
477:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
478:             .Caption   = "Categorias de Produto"
479:             .Top       = 18
480:             .Left      = 10
481:             .Width     = THIS.Width - 20
482:             .Height    = 46
483:             .FontName  = "Tahoma"
484:             .FontSize  = 16
485:             .FontBold  = .T.

*-- Linhas 491 a 507:
491: 
492:         *-- ============================================================
493:         *-- Campos - Primeiros 50% (Fase 5/8)
494:         *-- Posicoes originais compensadas +29 (PageFrame.Top=-29)
495:         *-- ============================================================
496: 
497:         *-- Label "Codigo :" (Say1: top=200+29=229, left=256, width~45)
498:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
499:         WITH loc_oPagina.lbl_4c_Label1
500:             .Caption   = "C" + CHR(243) + "digo :"
501:             .Top       = 229
502:             .Left      = 256
503:             .Width     = 45
504:             .Height    = 17
505:             .FontName  = "Tahoma"
506:             .FontSize  = 8
507:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 516 a 539:
516:         WITH loc_oPagina.txt_4c_Codigo
517:             .Value     = ""
518:             .MaxLength = 6
519:             .Top       = 226
520:             .Left      = 301
521:             .Width     = 52
522:             .Height    = 20
523:             .FontName  = "Tahoma"
524:             .FontSize  = 8
525:             .ForeColor = RGB(90, 90, 90)
526:             .Visible   = .T.
527:         ENDWITH
528: 
529:         *-- Label "Descricao :" (Say2: top=224+29=253, left=243, width~58)
530:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
531:         WITH loc_oPagina.lbl_4c_Label2
532:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
533:             .Top       = 253
534:             .Left      = 243
535:             .Width     = 58
536:             .Height    = 17
537:             .FontName  = "Tahoma"
538:             .FontSize  = 8
539:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 548 a 571:
548:         WITH loc_oPagina.txt_4c_Descricao
549:             .Value     = ""
550:             .MaxLength = 15
551:             .Top       = 250
552:             .Left      = 301
553:             .Width     = 115
554:             .Height    = 20
555:             .FontName  = "Tahoma"
556:             .FontSize  = 8
557:             .ForeColor = RGB(90, 90, 90)
558:             .Visible   = .T.
559:         ENDWITH
560: 
561:         *-- Label "Descricao Completa :" (Say5: top=248+29=277, left=195, width~106)
562:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
563:         WITH loc_oPagina.lbl_4c_Label5
564:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o Completa :"
565:             .Top       = 277
566:             .Left      = 195
567:             .Width     = 106
568:             .Height    = 17
569:             .FontName  = "Tahoma"
570:             .FontSize  = 8
571:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 580 a 603:
580:         WITH loc_oPagina.txt_4c_Desc2s
581:             .Value     = ""
582:             .MaxLength = 40
583:             .Top       = 274
584:             .Left      = 301
585:             .Width     = 290
586:             .Height    = 20
587:             .FontName  = "Tahoma"
588:             .FontSize  = 8
589:             .ForeColor = RGB(90, 90, 90)
590:             .Visible   = .T.
591:         ENDWITH
592: 
593:         *-- Label "Gde.Grp.:" (Say13: top=273+29=302, left=248, width=50)
594:         loc_oPagina.AddObject("lbl_4c_Label13", "Label")
595:         WITH loc_oPagina.lbl_4c_Label13
596:             .Caption   = "Gde.Grp.:"
597:             .Top       = 302
598:             .Left      = 248
599:             .Width     = 50
600:             .Height    = 17
601:             .FontName  = "Tahoma"
602:             .FontSize  = 8
603:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 612 a 635:
612:         WITH loc_oPagina.txt_4c_GdeGrp
613:             .Value     = ""
614:             .MaxLength = 3
615:             .Top       = 299
616:             .Left      = 301
617:             .Width     = 34
618:             .Height    = 23
619:             .FontName  = "Tahoma"
620:             .FontSize  = 8
621:             .ForeColor = RGB(90, 90, 90)
622:             .Visible   = .T.
623:         ENDWITH
624: 
625:         *-- Label "Prazo de Entrega :" (Say3: top=297+29=326, left=206, width=92)
626:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
627:         WITH loc_oPagina.lbl_4c_Label3
628:             .Caption   = "Prazo de Entrega :"
629:             .Top       = 326
630:             .Left      = 206
631:             .Width     = 92
632:             .Height    = 17
633:             .FontName  = "Tahoma"
634:             .FontSize  = 8
635:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 643 a 667:
643:         loc_oPagina.AddObject("txt_4c_Prazo", "TextBox")
644:         WITH loc_oPagina.txt_4c_Prazo
645:             .Value     = 0
646:             .Top       = 323
647:             .Left      = 301
648:             .Width     = 24
649:             .Height    = 20
650:             .FontName  = "Tahoma"
651:             .FontSize  = 8
652:             .ForeColor = RGB(90, 90, 90)
653:             .InputMask = "99"
654:             .Visible   = .T.
655:         ENDWITH
656: 
657:         *-- Label "Dias" (Say4: top=298+29=327, left=329, width=22)
658:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
659:         WITH loc_oPagina.lbl_4c_Label4
660:             .Caption   = "Dias"
661:             .Top       = 327
662:             .Left      = 329
663:             .Width     = 22
664:             .Height    = 17
665:             .FontName  = "Tahoma"
666:             .FontSize  = 8
667:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 707 a 718:
707:                         .Column3.Width = 80
708:                         .Column4.Width = 60
709: 
710:                         .Column1.Header1.Caption = "C" + CHR(243) + "digos"
711:                         .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
712:                         .Column3.Header1.Caption = "Gde. Grp"
713:                         .Column4.Header1.Caption = "Prazo"
714: 
715:                         .Column1.ReadOnly = .T.
716:                         .Column2.ReadOnly = .T.
717:                         .Column3.ReadOnly = .T.
718:                         .Column4.ReadOnly = .T.

*-- Linhas 905 a 916:
905:                         .Column3.ControlSource = "cursor_4c_Dados.gdegrps"
906:                         .Column4.ControlSource = "cursor_4c_Dados.prazos"
907: 
908:                         .Column1.Header1.Caption = "C" + CHR(243) + "digos"
909:                         .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
910:                         .Column3.Header1.Caption = "Gde. Grp"
911:                         .Column4.Header1.Caption = "Prazo"
912:                     ENDWITH
913: 
914:                     loc_oGrid.Refresh()
915:                 ENDIF
916:             ENDIF

*-- Linhas 1099 a 1111:
1099:         loc_oCntAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
1100: 
1101:         TRY
1102:             IF PEMSTATUS(loc_oCntAcao, "cmd_4c_Confirmar", 5)
1103:                 loc_oCntAcao.cmd_4c_Confirmar.Enabled = (THIS.this_cModoAtual != "VISUALIZAR")
1104:             ENDIF
1105:             IF PEMSTATUS(loc_oCntAcao, "cmd_4c_Cancelar", 5)
1106:                 loc_oCntAcao.cmd_4c_Cancelar.Enabled  = .T.
1107:             ENDIF
1108:         CATCH TO loc_oErro
1109:             MsgErro("Erro ao ajustar bot" + CHR(245) + "es:" + CHR(13) + loc_oErro.Message, "Erro")
1110:         ENDTRY
1111:     ENDPROC


### BO (C:\4c\projeto\app\classes\CatBO.prg):
*====================================================================
* CatBO.prg
*
* Business Object para Categorias de Produto
* Tabela principal: SIGCDCAT (cidchaves PK, cods chave de negocio)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS CatBO AS BusinessBase

	*-- Propriedades da entidade (SIGCDCAT)
	this_cCidchaves = ""   && cidchaves char(20)    - PK tecnica (UUID fUniqueIds)
	this_cCods      = ""   && cods char(6)          - codigo de categoria
	this_cDescs     = ""   && descs char(15)        - descricao curta
	this_cDesc2s    = ""   && desc2s char(40)       - descricao completa
	this_cGdegrps   = ""   && gdegrps char(3)       - grande grupo (FK SigCdGpr.Codigos)
	this_nPrazos    = 0    && prazos numeric(2,0)   - prazo de entrega (dias)

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SIGCDCAT"
		THIS.this_cCampoChave = "cidchaves"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCidchaves)
	ENDPROC

	*====================================================================
	* Buscar - Carrega lista de categorias no cursor_4c_Dados
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(par_cFiltro)
				loc_cSQL = "SELECT cidchaves, cods, descs, gdegrps, prazos" + ;
				           " FROM SIGCDCAT" + ;
				           " ORDER BY cods"
			ELSE
				loc_cSQL = "SELECT cidchaves, cods, descs, gdegrps, prazos" + ;
				           " FROM SIGCDCAT" + ;
				           " WHERE RTRIM(cods) = " + EscaparSQL(ALLTRIM(par_cFiltro)) + ;
				           " ORDER BY cods"
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar categorias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar categorias:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um registro pelo cidchaves (PK)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCidchaves)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT cidchaves, cods, descs, desc2s, gdegrps, prazos" + ;
			           " FROM SIGCDCAT" + ;
			           " WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(par_cCidchaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar categoria:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_cCidchaves = TratarNulo(cidchaves, "C")
			THIS.this_cCods      = TratarNulo(cods, "C")
			THIS.this_cDescs     = TratarNulo(descs, "C")
			THIS.this_cDesc2s    = TratarNulo(desc2s, "C")
			THIS.this_cGdegrps   = TratarNulo(gdegrps, "C")
			THIS.this_nPrazos    = TratarNulo(prazos, "N")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - INSERT na tabela SIGCDCAT
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)

			loc_cSQL = "INSERT INTO SIGCDCAT (cidchaves, cods, descs, desc2s, gdegrps, prazos)" + ;
			           " VALUES (" + ;
			           EscaparSQL(THIS.this_cCidchaves) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cCods), 6)) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cDescs), 15)) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cDesc2s), 40)) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cGdegrps), 3)) + "," + ;
			           FormatarNumeroSQL(THIS.this_nPrazos) + ;
			           ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao inserir categoria:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir categoria:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE na tabela SIGCDCAT
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SIGCDCAT SET" + ;
			           " cods = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCods), 6)) + "," + ;
			           " descs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cDescs), 15)) + "," + ;
			           " desc2s = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cDesc2s), 40)) + "," + ;
			           " gdegrps = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cGdegrps), 3)) + "," + ;
			           " prazos = " + FormatarNumeroSQL(THIS.this_nPrazos) + ;
			           " WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar categoria:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar categoria:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE da tabela SIGCDCAT
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SIGCDCAT WHERE RTRIM(cidchaves) = " + ;
			           EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir categoria:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir categoria:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

