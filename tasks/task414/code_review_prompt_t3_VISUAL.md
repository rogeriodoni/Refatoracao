# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [LAYOUT-POSITION] Controle 'Optiongroup1' (parent: SIGCDFBI.Pagina.Dados): Top original=429 vs migrado 'obj_4c_Optiongroup1' Top=3 (diff=426px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup1' (parent: SIGCDFBI.Pagina.Dados): Left original=625 vs migrado 'obj_4c_Optiongroup1' Left=5 (diff=620px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup2' (parent: SIGCDFBI.Pagina.Dados): Top original=451 vs migrado 'obj_4c_Optiongroup2' Top=3 (diff=448px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup2' (parent: SIGCDFBI.Pagina.Dados): Left original=624 vs migrado 'obj_4c_Optiongroup2' Left=5 (diff=619px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFBI.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2214 linhas total):

*-- Linhas 63 a 72:
63:             *-- Configurar estrutura do PageFrame
64:             THIS.ConfigurarPageFrame()
65: 
66:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
67:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
68: 
69:             *-- Configurar Page1 (Lista com Grid e Botoes CRUD)
70:             THIS.ConfigurarPaginaLista()
71: 
72:             *-- Configurar Page2 (Dados com Campos e Botoes Salvar/Cancelar)

*-- Linhas 99 a 108:
99:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
100:         WITH THIS.pgf_4c_Paginas
101:             .PageCount  = 2
102:             .Top        = -29
103:             .Left       = 0
104:             .Width      = THIS.Width
105:             .Height     = THIS.Height + 29
106:             .Tabs       = .F.
107:             .Visible    = .T.
108: 

*-- Linhas 114 a 124:
114:             .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
115:             .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
116: 
117:             .Page1.Caption = "Lista"
118:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
119:             .Page2.Caption = "Dados"
120:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
121:         ENDWITH
122:     ENDPROC
123: 
124:     *====================================================================

*-- Linhas 134 a 204:
134:         *-- Container cabecalho (cntSombra no legado)
135:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
136:         WITH loc_oPagina.cnt_4c_Cabecalho
137:             .Top         = 31
138:             .Left        = 0
139:             .Width       = THIS.Width
140:             .Height      = 80
141:             .BackColor   = RGB(100, 100, 100)
142:             .BorderWidth = 0
143:             .Visible     = .T.
144:         ENDWITH
145: 
146:         *-- Label sombra (efeito visual)
147:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
148:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
149:             .Top       = 15
150:             .Left      = 10
151:             .Width     = 769
152:             .Height    = 40
153:             .Caption   = "Cadastro de Fabrica" + CHR(231) + CHR(227) + "o"
154:             .FontName  = "Tahoma"
155:             .FontSize  = 16
156:             .FontBold  = .T.
157:             .ForeColor = RGB(0, 0, 0)
158:             .BackStyle = 0
159:             .AutoSize  = .F.
160:             .Visible   = .T.
161:         ENDWITH
162: 
163:         *-- Label titulo principal
164:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
165:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
166:             .Top       = 18
167:             .Left      = 10
168:             .Width     = 769
169:             .Height    = 46
170:             .Caption   = "Cadastro de Fabrica" + CHR(231) + CHR(227) + "o"
171:             .FontName  = "Tahoma"
172:             .FontSize  = 16
173:             .FontBold  = .T.
174:             .ForeColor = RGB(255, 255, 255)
175:             .BackStyle = 0
176:             .AutoSize  = .F.
177:             .Visible   = .T.
178:         ENDWITH
179: 
180:         *-- Container botoes CRUD (Grupo_Op no legado) - LADO DIREITO
181:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
182:         WITH loc_oPagina.cnt_4c_Botoes
183:             .Top         = 29
184:             .Left        = 542
185:             .Width       = 390
186:             .Height      = 85
187:             .BackStyle = 0
188:             .BorderWidth = 0
189:             .Visible     = .T.
190:         ENDWITH
191: 
192:         *-- Botao Incluir
193:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
194:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
195:             .Caption         = "Incluir"
196:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
197:             .PicturePosition = 13
198:             .Top             = 5
199:             .Left            = 5
200:             .Width           = 75
201:             .Height          = 75
202:             .FontName        = "Tahoma"
203:             .FontSize        = 8
204:             .FontBold        = .T.

*-- Linhas 212 a 229:
212:             .AutoSize        = .F.
213:             .Visible         = .T.
214:         ENDWITH
215:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
216: 
217:         *-- Botao Visualizar
218:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
219:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
220:             .Caption         = "Visualizar"
221:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
222:             .PicturePosition = 13
223:             .Top             = 5
224:             .Left            = 80
225:             .Width           = 75
226:             .Height          = 75
227:             .FontName        = "Tahoma"
228:             .FontSize        = 8
229:             .FontBold        = .T.

*-- Linhas 237 a 254:
237:             .AutoSize        = .F.
238:             .Visible         = .T.
239:         ENDWITH
240:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
241: 
242:         *-- Botao Alterar
243:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
244:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
245:             .Caption         = "Alterar"
246:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
247:             .PicturePosition = 13
248:             .Top             = 5
249:             .Left            = 155
250:             .Width           = 75
251:             .Height          = 75
252:             .FontName        = "Tahoma"
253:             .FontSize        = 8
254:             .FontBold        = .T.

*-- Linhas 262 a 279:
262:             .AutoSize        = .F.
263:             .Visible         = .T.
264:         ENDWITH
265:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
266: 
267:         *-- Botao Excluir
268:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
269:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
270:             .Caption         = "Excluir"
271:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
272:             .PicturePosition = 13
273:             .Top             = 5
274:             .Left            = 230
275:             .Width           = 75
276:             .Height          = 75
277:             .FontName        = "Tahoma"
278:             .FontSize        = 8
279:             .FontBold        = .T.

*-- Linhas 287 a 304:
287:             .AutoSize        = .F.
288:             .Visible         = .T.
289:         ENDWITH
290:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
291: 
292:         *-- Botao Buscar
293:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
294:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
295:             .Caption         = "Buscar"
296:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
297:             .PicturePosition = 13
298:             .Top             = 5
299:             .Left            = 305
300:             .Width           = 75
301:             .Height          = 75
302:             .FontName        = "Tahoma"
303:             .FontSize        = 8
304:             .FontBold        = .T.

*-- Linhas 312 a 340:
312:             .AutoSize        = .F.
313:             .Visible         = .T.
314:         ENDWITH
315:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
316: 
317:         *-- Container Encerrar (canonico: Left=917, Width=90)
318:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
319:         WITH loc_oPagina.cnt_4c_Saida
320:             .Top         = 29
321:             .Left        = 917
322:             .Width       = 90
323:             .Height      = 85
324:             .BackStyle   = 0
325:             .BorderWidth = 0
326:             .Visible     = .T.
327:         ENDWITH
328: 
329:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
330:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
331:             .Caption         = "Encerrar"
332:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
333:             .PicturePosition = 13
334:             .Top             = 5
335:             .Left            = 5
336:             .Width           = 75
337:             .Height          = 75
338:             .FontName        = "Tahoma"
339:             .FontSize        = 8
340:             .FontBold        = .T.

*-- Linhas 348 a 362:
348:             .AutoSize        = .F.
349:             .Visible         = .T.
350:         ENDWITH
351:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
352: 
353:         *-- Grid de lista
354:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
355:         WITH loc_oPagina.grd_4c_Lista
356:             .Top                  = 121
357:             .Left                 = 12
358:             .Width                = 890
359:             .Height               = 440
360:             .FontName             = "Verdana"
361:             .FontSize             = 8
362:             .ForeColor            = RGB(90, 90, 90)

*-- Linhas 377 a 397:
377:         *-- Configurar colunas do grid apos ColumnCount
378:         WITH loc_oPagina.grd_4c_Lista
379:             .Column1.Width              = 160
380:             .Column1.Header1.Caption    = "N" + CHR(186) + " Fabrica" + CHR(231) + CHR(227) + "o"
381:             .Column1.Alignment          = 0
382: 
383:             .Column2.Width              = 80
384:             .Column2.Header1.Caption    = "Empresa"
385:             .Column2.Alignment          = 0
386: 
387:             .Column3.Width              = 300
388:             .Column3.Header1.Caption    = "Fabrica" + CHR(231) + CHR(227) + "o (Criptografado)"
389:             .Column3.Alignment          = 0
390: 
391:             .Column4.Width              = 120
392:             .Column4.Header1.Caption    = "Caixa"
393:             .Column4.Alignment          = 0
394:         ENDWITH
395: 
396:         *-- Tornar controles visiveis
397:         THIS.TornarControlesVisiveis(loc_oPagina)

*-- Linhas 410 a 434:
410:         *-- Container botoes Salvar/Cancelar (Grupo_Salva no legado)
411:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
412:         WITH loc_oPagina.cnt_4c_BotoesAcao
413:             .Top         = 33
414:             .Left        = 842
415:             .Width       = 160
416:             .Height      = 85
417:             .BackStyle   = 0
418:             .BorderWidth = 0
419:             .Visible     = .T.
420:         ENDWITH
421: 
422:         *-- Botao Confirmar (Salvar)
423:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
424:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
425:             .Caption         = "Confirmar"
426:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
427:             .PicturePosition = 13
428:             .Top             = 5
429:             .Left            = 5
430:             .Width           = 75
431:             .Height          = 75
432:             .FontName        = "Tahoma"
433:             .FontSize        = 8
434:             .FontBold        = .T.

*-- Linhas 442 a 459:
442:             .AutoSize        = .F.
443:             .Visible         = .T.
444:         ENDWITH
445:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
446: 
447:         *-- Botao Cancelar
448:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
449:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
450:             .Caption         = "Encerrar"
451:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
452:             .PicturePosition = 13
453:             .Top             = 5
454:             .Left            = 80
455:             .Width           = 75
456:             .Height          = 75
457:             .FontName        = "Tahoma"
458:             .FontSize        = 8
459:             .FontBold        = .T.

*-- Linhas 467 a 531:
467:             .AutoSize        = .F.
468:             .Visible         = .T.
469:         ENDWITH
470:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
471: 
472:         *-- === COLUNA ESQUERDA - Campos da Page2 (Fase 5: primeiros 50%) ===
473: 
474:         *-- NFAB - No. Fabricacao (chave de negocio, desabilitado no ALTERAR)
475:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
476:         WITH loc_oPagina.lbl_4c_Label1
477:             .Top       = 216
478:             .Left      = 137
479:             .Width     = 115
480:             .Height    = 17
481:             .Caption   = "N" + CHR(186) + " Fabrica" + CHR(231) + CHR(227) + "o - NFAB. :"
482:             .FontName  = "Tahoma"
483:             .FontSize  = 8
484:             .ForeColor = RGB(255, 255, 255)
485:             .BackStyle = 0
486:             .Alignment = 1
487:             .AutoSize  = .F.
488:             .Visible   = .T.
489:         ENDWITH
490: 
491:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
492:         WITH loc_oPagina.txt_4c_Codigo
493:             .Top       = 213
494:             .Left      = 256
495:             .Width     = 157
496:             .Height    = 23
497:             .Value     = ""
498:             .MaxLength = 20
499:             .FontName  = "Tahoma"
500:             .FontSize  = 8
501:             .BackColor = RGB(255, 255, 255)
502:             .ForeColor = RGB(0, 0, 0)
503:             .Visible   = .T.
504:         ENDWITH
505: 
506:         *-- NSEQ - No. do Caixa (obrigatorio 3 digitos)
507:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
508:         WITH loc_oPagina.lbl_4c_Label3
509:             .Top       = 241
510:             .Left      = 146
511:             .Width     = 108
512:             .Height    = 17
513:             .Caption   = "N" + CHR(186) + " do Caixa - NSEQ. :"
514:             .FontName  = "Tahoma"
515:             .FontSize  = 8
516:             .ForeColor = RGB(255, 255, 255)
517:             .BackStyle = 0
518:             .Alignment = 1
519:             .AutoSize  = .F.
520:             .Visible   = .T.
521:         ENDWITH
522: 
523:         loc_oPagina.AddObject("txt_4c_Ncaixa", "TextBox")
524:         WITH loc_oPagina.txt_4c_Ncaixa
525:             .Top       = 238
526:             .Left      = 256
527:             .Width     = 31
528:             .Height    = 21
529:             .Value     = ""
530:             .MaxLength = 3
531:             .FontName  = "Tahoma"

*-- Linhas 537 a 596:
537:         BINDEVENT(loc_oPagina.txt_4c_Ncaixa, "KeyPress", THIS, "NcaixaLostFocus")
538: 
539:         *-- Contador Reinicio de Operacao
540:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
541:         WITH loc_oPagina.lbl_4c_Label4
542:             .Top       = 265
543:             .Left      = 96
544:             .Width     = 158
545:             .Height    = 17
546:             .Caption   = "Contador Reinicio de Opera" + CHR(231) + CHR(227) + "o :"
547:             .FontName  = "Tahoma"
548:             .FontSize  = 8
549:             .ForeColor = RGB(255, 255, 255)
550:             .BackStyle = 0
551:             .Alignment = 1
552:             .AutoSize  = .F.
553:             .Visible   = .T.
554:         ENDWITH
555: 
556:         loc_oPagina.AddObject("txt_4c_Interv", "TextBox")
557:         WITH loc_oPagina.txt_4c_Interv
558:             .Top       = 262
559:             .Left      = 256
560:             .Width     = 38
561:             .Height    = 21
562:             .Value     = ""
563:             .MaxLength = 4
564:             .FontName  = "Tahoma"
565:             .FontSize  = 8
566:             .BackColor = RGB(255, 255, 255)
567:             .ForeColor = RGB(0, 0, 0)
568:             .Visible   = .T.
569:         ENDWITH
570: 
571:         *-- Empresa (lookup em SigCdEmp)
572:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
573:         WITH loc_oPagina.lbl_4c_Label5
574:             .Top       = 290
575:             .Left      = 204
576:             .Width     = 50
577:             .Height    = 17
578:             .Caption   = "Empresa :"
579:             .FontName  = "Tahoma"
580:             .FontSize  = 8
581:             .ForeColor = RGB(255, 255, 255)
582:             .BackStyle = 0
583:             .Alignment = 1
584:             .AutoSize  = .F.
585:             .Visible   = .T.
586:         ENDWITH
587: 
588:         loc_oPagina.AddObject("txt_4c_Emp", "TextBox")
589:         WITH loc_oPagina.txt_4c_Emp
590:             .Top       = 286
591:             .Left      = 256
592:             .Width     = 38
593:             .Height    = 21
594:             .Value     = ""
595:             .MaxLength = 3
596:             .FontName  = "Tahoma"

*-- Linhas 603 a 694:
603:         BINDEVENT(loc_oPagina.txt_4c_Emp, "KeyPress", THIS, "EmpresaKeyPress")
604: 
605:         *-- GT Inicial
606:         loc_oPagina.AddObject("lbl_4c_Label12", "Label")
607:         WITH loc_oPagina.lbl_4c_Label12
608:             .Top       = 314
609:             .Left      = 202
610:             .Width     = 52
611:             .Height    = 17
612:             .Caption   = "GT Inicial :"
613:             .FontName  = "Tahoma"
614:             .FontSize  = 8
615:             .ForeColor = RGB(255, 255, 255)
616:             .BackStyle = 0
617:             .Alignment = 1
618:             .AutoSize  = .F.
619:             .Visible   = .T.
620:         ENDWITH
621: 
622:         loc_oPagina.AddObject("txt_4c_GTInicial", "TextBox")
623:         WITH loc_oPagina.txt_4c_GTInicial
624:             .Top       = 311
625:             .Left      = 256
626:             .Width     = 175
627:             .Height    = 23
628:             .Value     = ""
629:             .MaxLength = 30
630:             .FontName  = "Tahoma"
631:             .FontSize  = 8
632:             .BackColor = RGB(255, 255, 255)
633:             .ForeColor = RGB(0, 0, 0)
634:             .Visible   = .T.
635:         ENDWITH
636: 
637:         *-- GT Atual
638:         loc_oPagina.AddObject("lbl_4c_Label30", "Label")
639:         WITH loc_oPagina.lbl_4c_Label30
640:             .Top       = 339
641:             .Left      = 204
642:             .Width     = 50
643:             .Height    = 17
644:             .Caption   = "GT Atual :"
645:             .FontName  = "Tahoma"
646:             .FontSize  = 8
647:             .ForeColor = RGB(255, 255, 255)
648:             .BackStyle = 0
649:             .Alignment = 1
650:             .AutoSize  = .F.
651:             .Visible   = .T.
652:         ENDWITH
653: 
654:         loc_oPagina.AddObject("txt_4c_Gtatual", "TextBox")
655:         WITH loc_oPagina.txt_4c_Gtatual
656:             .Top       = 336
657:             .Left      = 256
658:             .Width     = 175
659:             .Height    = 23
660:             .Value     = ""
661:             .MaxLength = 30
662:             .FontName  = "Tahoma"
663:             .FontSize  = 8
664:             .BackColor = RGB(255, 255, 255)
665:             .ForeColor = RGB(0, 0, 0)
666:             .Visible   = .T.
667:         ENDWITH
668: 
669:         *-- Modelo ECF (lookup em SigFiMpM)
670:         loc_oPagina.AddObject("lbl_4c_Label16", "Label")
671:         WITH loc_oPagina.lbl_4c_Label16
672:             .Top       = 365
673:             .Left      = 211
674:             .Width     = 43
675:             .Height    = 17
676:             .Caption   = "Modelo :"
677:             .FontName  = "Tahoma"
678:             .FontSize  = 8
679:             .ForeColor = RGB(255, 255, 255)
680:             .BackStyle = 0
681:             .Alignment = 1
682:             .AutoSize  = .F.
683:             .Visible   = .T.
684:         ENDWITH
685: 
686:         loc_oPagina.AddObject("txt_4c_Modelo", "TextBox")
687:         WITH loc_oPagina.txt_4c_Modelo
688:             .Top       = 361
689:             .Left      = 256
690:             .Width     = 220
691:             .Height    = 23
692:             .Value     = ""
693:             .MaxLength = 30
694:             .FontName  = "Tahoma"

*-- Linhas 701 a 728:
701:         BINDEVENT(loc_oPagina.txt_4c_Modelo, "KeyPress", THIS, "ModeloKeyPress")
702: 
703:         *-- Numero do Usuario do ECF
704:         loc_oPagina.AddObject("lbl_4c_Label17", "Label")
705:         WITH loc_oPagina.lbl_4c_Label17
706:             .Top       = 390
707:             .Left      = 114
708:             .Width     = 140
709:             .Height    = 17
710:             .Caption   = "Numero do Usu" + CHR(225) + "rio do ECF :"
711:             .FontName  = "Tahoma"
712:             .FontSize  = 8
713:             .ForeColor = RGB(255, 255, 255)
714:             .BackStyle = 0
715:             .Alignment = 1
716:             .AutoSize  = .F.
717:             .Visible   = .T.
718:         ENDWITH
719: 
720:         loc_oPagina.AddObject("txt_4c_NumUsu", "TextBox")
721:         WITH loc_oPagina.txt_4c_NumUsu
722:             .Top       = 386
723:             .Left      = 256
724:             .Width     = 25
725:             .Height    = 21
726:             .Value     = ""
727:             .MaxLength = 2
728:             .InputMask = "99"

*-- Linhas 736 a 859:
736:         BINDEVENT(loc_oPagina.txt_4c_NumUsu, "KeyPress", THIS, "NumUsuLostFocus")
737: 
738:         *-- Tipo do ECF
739:         loc_oPagina.AddObject("lbl_4c_Label18", "Label")
740:         WITH loc_oPagina.lbl_4c_Label18
741:             .Top       = 414
742:             .Left      = 188
743:             .Width     = 66
744:             .Height    = 17
745:             .Caption   = "Tipo do ECF :"
746:             .FontName  = "Tahoma"
747:             .FontSize  = 8
748:             .ForeColor = RGB(255, 255, 255)
749:             .BackStyle = 0
750:             .Alignment = 1
751:             .AutoSize  = .F.
752:             .Visible   = .T.
753:         ENDWITH
754: 
755:         loc_oPagina.AddObject("txt_4c_TipoECF", "TextBox")
756:         WITH loc_oPagina.txt_4c_TipoECF
757:             .Top       = 410
758:             .Left      = 256
759:             .Width     = 59
760:             .Height    = 23
761:             .Value     = ""
762:             .MaxLength = 7
763:             .FontName  = "Tahoma"
764:             .FontSize  = 8
765:             .BackColor = RGB(255, 255, 255)
766:             .ForeColor = RGB(0, 0, 0)
767:             .Visible   = .T.
768:         ENDWITH
769: 
770:         *-- Versao do Software Basico
771:         loc_oPagina.AddObject("lbl_4c_Label19", "Label")
772:         WITH loc_oPagina.lbl_4c_Label19
773:             .Top       = 437
774:             .Left      = 121
775:             .Width     = 133
776:             .Height    = 17
777:             .Caption   = "Vers" + CHR(227) + "o do Sofware B" + CHR(225) + "sico :"
778:             .FontName  = "Tahoma"
779:             .FontSize  = 8
780:             .ForeColor = RGB(255, 255, 255)
781:             .BackStyle = 0
782:             .Alignment = 1
783:             .AutoSize  = .F.
784:             .Visible   = .T.
785:         ENDWITH
786: 
787:         loc_oPagina.AddObject("txt_4c_VerSB", "TextBox")
788:         WITH loc_oPagina.txt_4c_VerSB
789:             .Top       = 434
790:             .Left      = 256
791:             .Width     = 80
792:             .Height    = 21
793:             .Value     = ""
794:             .MaxLength = 10
795:             .FontName  = "Tahoma"
796:             .FontSize  = 8
797:             .BackColor = RGB(255, 255, 255)
798:             .ForeColor = RGB(0, 0, 0)
799:             .Visible   = .T.
800:         ENDWITH
801: 
802:         *-- Data do Software Basico
803:         loc_oPagina.AddObject("lbl_4c_Label20", "Label")
804:         WITH loc_oPagina.lbl_4c_Label20
805:             .Top       = 461
806:             .Left      = 131
807:             .Width     = 123
808:             .Height    = 17
809:             .Caption   = "Data do Sofware B" + CHR(225) + "sico :"
810:             .FontName  = "Tahoma"
811:             .FontSize  = 8
812:             .ForeColor = RGB(255, 255, 255)
813:             .BackStyle = 0
814:             .Alignment = 1
815:             .AutoSize  = .F.
816:             .Visible   = .T.
817:         ENDWITH
818: 
819:         loc_oPagina.AddObject("txt_4c_DataSB", "TextBox")
820:         WITH loc_oPagina.txt_4c_DataSB
821:             .Top       = 458
822:             .Left      = 256
823:             .Width     = 80
824:             .Height    = 21
825:             .Value     = {}
826:             .Format    = "D"
827:             .FontName  = "Tahoma"
828:             .FontSize  = 8
829:             .BackColor = RGB(255, 255, 255)
830:             .ForeColor = RGB(0, 0, 0)
831:             .Visible   = .T.
832:         ENDWITH
833: 
834:         *-- Hora do Software Basico
835:         loc_oPagina.AddObject("lbl_4c_Label21", "Label")
836:         WITH loc_oPagina.lbl_4c_Label21
837:             .Top       = 485
838:             .Left      = 131
839:             .Width     = 123
840:             .Height    = 17
841:             .Caption   = "Hora do Sofware B" + CHR(225) + "sico :"
842:             .FontName  = "Tahoma"
843:             .FontSize  = 8
844:             .ForeColor = RGB(255, 255, 255)
845:             .BackStyle = 0
846:             .Alignment = 1
847:             .AutoSize  = .F.
848:             .Visible   = .T.
849:         ENDWITH
850: 
851:         loc_oPagina.AddObject("txt_4c_HoraSB", "TextBox")
852:         WITH loc_oPagina.txt_4c_HoraSB
853:             .Top       = 482
854:             .Left      = 256
855:             .Width     = 64
856:             .Height    = 21
857:             .Value     = ""
858:             .MaxLength = 8
859:             .InputMask = "99:99:99"

*-- Linhas 865 a 924:
865:         ENDWITH
866: 
867:         *-- Comando de Geracao RFD
868:         loc_oPagina.AddObject("lbl_4c_Label22", "Label")
869:         WITH loc_oPagina.lbl_4c_Label22
870:             .Top       = 510
871:             .Left      = 119
872:             .Width     = 135
873:             .Height    = 17
874:             .Caption   = "Comando de Gera" + CHR(231) + CHR(227) + "o RFD :"
875:             .FontName  = "Tahoma"
876:             .FontSize  = 8
877:             .ForeColor = RGB(255, 255, 255)
878:             .BackStyle = 0
879:             .Alignment = 1
880:             .AutoSize  = .F.
881:             .Visible   = .T.
882:         ENDWITH
883: 
884:         loc_oPagina.AddObject("txt_4c_CmdRFD", "TextBox")
885:         WITH loc_oPagina.txt_4c_CmdRFD
886:             .Top       = 506
887:             .Left      = 256
888:             .Width     = 30
889:             .Height    = 23
890:             .Value     = ""
891:             .MaxLength = 3
892:             .FontName  = "Tahoma"
893:             .FontSize  = 8
894:             .BackColor = RGB(255, 255, 255)
895:             .ForeColor = RGB(0, 0, 0)
896:             .Visible   = .T.
897:         ENDWITH
898: 
899:         *-- COO Inicial (Troca Aplicativo)
900:         loc_oPagina.AddObject("lbl_4c_Label27", "Label")
901:         WITH loc_oPagina.lbl_4c_Label27
902:             .Top       = 534
903:             .Left      = 109
904:             .Width     = 145
905:             .Height    = 15
906:             .Caption   = "Coo Inicial (Troca Aplicativo) :"
907:             .FontName  = "Tahoma"
908:             .FontSize  = 8
909:             .ForeColor = RGB(255, 255, 255)
910:             .BackStyle = 0
911:             .Alignment = 1
912:             .AutoSize  = .F.
913:             .Visible   = .T.
914:         ENDWITH
915: 
916:         loc_oPagina.AddObject("txt_4c_Coos", "TextBox")
917:         WITH loc_oPagina.txt_4c_Coos
918:             .Top       = 530
919:             .Left      = 256
920:             .Width     = 52
921:             .Height    = 23
922:             .Value     = ""
923:             .MaxLength = 6
924:             .FontName  = "Tahoma"

*-- Linhas 932 a 959:
932:         *-- === COLUNA DIREITA - primeiros campos (Fase 5) ===
933: 
934:         *-- Data do Cadastro do ECF
935:         loc_oPagina.AddObject("lbl_4c_Label23", "Label")
936:         WITH loc_oPagina.lbl_4c_Label23
937:             .Top       = 216
938:             .Left      = 497
939:             .Width     = 131
940:             .Height    = 17
941:             .Caption   = "Data do Cadastro do ECF :"
942:             .FontName  = "Tahoma"
943:             .FontSize  = 8
944:             .ForeColor = RGB(255, 255, 255)
945:             .BackStyle = 0
946:             .Alignment = 1
947:             .AutoSize  = .F.
948:             .Visible   = .T.
949:         ENDWITH
950: 
951:         loc_oPagina.AddObject("txt_4c_DtCad", "TextBox")
952:         WITH loc_oPagina.txt_4c_DtCad
953:             .Top       = 213
954:             .Left      = 630
955:             .Width     = 80
956:             .Height    = 21
957:             .Value     = {}
958:             .Format    = "D"
959:             .FontName  = "Tahoma"

*-- Linhas 966 a 993:
966:         *-- === COLUNA DIREITA - campos restantes (Fase 6) ===
967: 
968:         *-- Hora do Cadastro do ECF
969:         loc_oPagina.AddObject("lbl_4c_Label24", "Label")
970:         WITH loc_oPagina.lbl_4c_Label24
971:             .Top       = 240
972:             .Left      = 497
973:             .Width     = 131
974:             .Height    = 17
975:             .Caption   = "Hora do Cadastro do ECF :"
976:             .FontName  = "Tahoma"
977:             .FontSize  = 8
978:             .ForeColor = RGB(255, 255, 255)
979:             .BackStyle = 0
980:             .Alignment = 1
981:             .AutoSize  = .F.
982:             .Visible   = .T.
983:         ENDWITH
984: 
985:         loc_oPagina.AddObject("txt_4c_HrCad", "TextBox")
986:         WITH loc_oPagina.txt_4c_HrCad
987:             .Top       = 237
988:             .Left      = 630
989:             .Width     = 64
990:             .Height    = 21
991:             .Value     = ""
992:             .MaxLength = 8
993:             .InputMask = "99:99:99"

*-- Linhas 1000 a 1027:
1000:         ENDWITH
1001: 
1002:         *-- Reinicio de Operacoes / CRO Inicial
1003:         loc_oPagina.AddObject("lbl_4c_Label25", "Label")
1004:         WITH loc_oPagina.lbl_4c_Label25
1005:             .Top       = 264
1006:             .Left      = 513
1007:             .Width     = 115
1008:             .Height    = 17
1009:             .Caption   = "Reinicio de Opera" + CHR(231) + CHR(245) + "es :"
1010:             .FontName  = "Tahoma"
1011:             .FontSize  = 8
1012:             .ForeColor = RGB(255, 255, 255)
1013:             .BackStyle = 0
1014:             .Alignment = 1
1015:             .AutoSize  = .F.
1016:             .Visible   = .T.
1017:         ENDWITH
1018: 
1019:         loc_oPagina.AddObject("txt_4c_CRO", "TextBox")
1020:         WITH loc_oPagina.txt_4c_CRO
1021:             .Top       = 261
1022:             .Left      = 630
1023:             .Width     = 50
1024:             .Height    = 23
1025:             .Value     = ""
1026:             .MaxLength = 6
1027:             .InputMask = "999999"

*-- Linhas 1034 a 1327:
1034:         BINDEVENT(loc_oPagina.txt_4c_CRO, "KeyPress", THIS, "CROLostFocus")
1035: 
1036:         *-- Leitura Mem. Fiscal Automatico
1037:         loc_oPagina.AddObject("lbl_4c_Label13", "Label")
1038:         WITH loc_oPagina.lbl_4c_Label13
1039:             .Top       = 285
1040:             .Left      = 468
1041:             .Width     = 160
1042:             .Height    = 17
1043:             .Caption   = "Leitura Mem. Fiscal Autom" + CHR(225) + "tico :"
1044:             .FontName  = "Tahoma"
1045:             .FontSize  = 8
1046:             .ForeColor = RGB(255, 255, 255)
1047:             .BackStyle = 0
1048:             .Alignment = 1
1049:             .AutoSize  = .F.
1050:             .Visible   = .T.
1051:         ENDWITH
1052: 
1053:         loc_oPagina.AddObject("chk_4c_Chk_LeitMF", "CheckBox")
1054:         WITH loc_oPagina.chk_4c_Chk_LeitMF
1055:             .Top       = 285
1056:             .Left      = 630
1057:             .Width     = 18
1058:             .Height    = 17
1059:             .Caption   = ""
1060:             .Value     = 0
1061:             .Alignment = 0
1062:             .BackStyle = 0
1063:             .AutoSize  = .T.
1064:             .Visible   = .T.
1065:         ENDWITH
1066: 
1067:         *-- Gaveta Acoplada
1068:         loc_oPagina.AddObject("lbl_4c_Label7", "Label")
1069:         WITH loc_oPagina.lbl_4c_Label7
1070:             .Top       = 304
1071:             .Left      = 534
1072:             .Width     = 94
1073:             .Height    = 17
1074:             .Caption   = "Gaveta Acoplada :"
1075:             .FontName  = "Tahoma"
1076:             .FontSize  = 8
1077:             .ForeColor = RGB(255, 255, 255)
1078:             .BackStyle = 0
1079:             .Alignment = 1
1080:             .AutoSize  = .F.
1081:             .Visible   = .T.
1082:         ENDWITH
1083: 
1084:         loc_oPagina.AddObject("chk_4c_Chk_gaveta", "CheckBox")
1085:         WITH loc_oPagina.chk_4c_Chk_gaveta
1086:             .Top       = 304
1087:             .Left      = 630
1088:             .Width     = 18
1089:             .Height    = 17
1090:             .Caption   = ""
1091:             .Value     = 0
1092:             .Alignment = 0
1093:             .BackStyle = 0
1094:             .AutoSize  = .T.
1095:             .Visible   = .T.
1096:         ENDWITH
1097: 
1098:         *-- Impressora de Cheques
1099:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
1100:         WITH loc_oPagina.lbl_4c_Label2
1101:             .Top       = 324
1102:             .Left      = 549
1103:             .Width     = 79
1104:             .Height    = 17
1105:             .Caption   = "Imp. Cheques :"
1106:             .FontName  = "Tahoma"
1107:             .FontSize  = 8
1108:             .ForeColor = RGB(255, 255, 255)
1109:             .BackStyle = 0
1110:             .Alignment = 1
1111:             .AutoSize  = .F.
1112:             .Visible   = .T.
1113:         ENDWITH
1114: 
1115:         loc_oPagina.AddObject("chk_4c_Chk_impche", "CheckBox")
1116:         WITH loc_oPagina.chk_4c_Chk_impche
1117:             .Top       = 324
1118:             .Left      = 630
1119:             .Width     = 18
1120:             .Height    = 15
1121:             .Caption   = ""
1122:             .Value     = 0
1123:             .Alignment = 0
1124:             .BackStyle = 0
1125:             .AutoSize  = .T.
1126:             .Visible   = .T.
1127:         ENDWITH
1128: 
1129:         *-- MFD (Memoria de Fita Detalhe)
1130:         loc_oPagina.AddObject("lbl_4c_Label15", "Label")
1131:         WITH loc_oPagina.lbl_4c_Label15
1132:             .Top       = 343
1133:             .Left      = 595
1134:             .Width     = 33
1135:             .Height    = 17
1136:             .Caption   = "MFD :"
1137:             .FontName  = "Tahoma"
1138:             .FontSize  = 8
1139:             .ForeColor = RGB(255, 255, 255)
1140:             .BackStyle = 0
1141:             .Alignment = 1
1142:             .AutoSize  = .F.
1143:             .Visible   = .T.
1144:         ENDWITH
1145: 
1146:         loc_oPagina.AddObject("chk_4c_Fwcheckbox2", "CheckBox")
1147:         WITH loc_oPagina.chk_4c_Fwcheckbox2
1148:             .Top       = 343
1149:             .Left      = 630
1150:             .Width     = 18
1151:             .Height    = 15
1152:             .Caption   = ""
1153:             .Value     = 0
1154:             .Alignment = 0
1155:             .BackStyle = 0
1156:             .AutoSize  = .T.
1157:             .Visible   = .T.
1158:         ENDWITH
1159: 
1160:         *-- Inativa
1161:         loc_oPagina.AddObject("lbl_4c_Label11", "Label")
1162:         WITH loc_oPagina.lbl_4c_Label11
1163:             .Top       = 361
1164:             .Left      = 582
1165:             .Width     = 46
1166:             .Height    = 15
1167:             .Caption   = "Inativa :"
1168:             .FontName  = "Tahoma"
1169:             .FontSize  = 8
1170:             .ForeColor = RGB(255, 255, 255)
1171:             .BackStyle = 0
1172:             .Alignment = 1
1173:             .AutoSize  = .F.
1174:             .Visible   = .T.
1175:         ENDWITH
1176: 
1177:         loc_oPagina.AddObject("chk_4c_Fwcheckbox1", "CheckBox")
1178:         WITH loc_oPagina.chk_4c_Fwcheckbox1
1179:             .Top       = 361
1180:             .Left      = 630
1181:             .Width     = 18
1182:             .Height    = 15
1183:             .Caption   = ""
1184:             .Value     = 0
1185:             .Alignment = 0
1186:             .BackStyle = 0
1187:             .AutoSize  = .T.
1188:             .Visible   = .T.
1189:         ENDWITH
1190: 
1191:         *-- Bom Para (uso cheque)
1192:         loc_oPagina.AddObject("lbl_4c_Label8", "Label")
1193:         WITH loc_oPagina.lbl_4c_Label8
1194:             .Top       = 382
1195:             .Left      = 571
1196:             .Width     = 57
1197:             .Height    = 17
1198:             .Caption   = "Bom Para :"
1199:             .FontName  = "Tahoma"
1200:             .FontSize  = 8
1201:             .ForeColor = RGB(255, 255, 255)
1202:             .BackStyle = 0
1203:             .Alignment = 1
1204:             .AutoSize  = .F.
1205:             .Visible   = .T.
1206:         ENDWITH
1207: 
1208:         loc_oPagina.AddObject("chk_4c_Chk_Bompara", "CheckBox")
1209:         WITH loc_oPagina.chk_4c_Chk_Bompara
1210:             .Top       = 382
1211:             .Left      = 630
1212:             .Width     = 18
1213:             .Height    = 15
1214:             .Caption   = ""
1215:             .Value     = 0
1216:             .Alignment = 0
1217:             .BackStyle = 0
1218:             .AutoSize  = .T.
1219:             .Visible   = .T.
1220:         ENDWITH
1221: 
1222:         *-- Nominal
1223:         loc_oPagina.AddObject("lbl_4c_Label9", "Label")
1224:         WITH loc_oPagina.lbl_4c_Label9
1225:             .Top       = 403
1226:             .Left      = 579
1227:             .Width     = 49
1228:             .Height    = 17
1229:             .Caption   = "Nominal :"
1230:             .FontName  = "Tahoma"
1231:             .FontSize  = 8
1232:             .ForeColor = RGB(255, 255, 255)
1233:             .BackStyle = 0
1234:             .Alignment = 1
1235:             .AutoSize  = .F.
1236:             .Visible   = .T.
1237:         ENDWITH
1238: 
1239:         loc_oPagina.AddObject("chk_4c_Chk_nominal", "CheckBox")
1240:         WITH loc_oPagina.chk_4c_Chk_nominal
1241:             .Top       = 403
1242:             .Left      = 630
1243:             .Width     = 18
1244:             .Height    = 15
1245:             .Caption   = ""
1246:             .Value     = 0
1247:             .Alignment = 0
1248:             .BackStyle = 0
1249:             .AutoSize  = .T.
1250:             .Visible   = .T.
1251:         ENDWITH
1252: 
1253:         *-- Cruzado
1254:         loc_oPagina.AddObject("lbl_4c_Label10", "Label")
1255:         WITH loc_oPagina.lbl_4c_Label10
1256:             .Top       = 423
1257:             .Left      = 576
1258:             .Width     = 52
1259:             .Height    = 17
1260:             .Caption   = "Cruzado :"
1261:             .FontName  = "Tahoma"
1262:             .FontSize  = 8
1263:             .ForeColor = RGB(255, 255, 255)
1264:             .BackStyle = 0
1265:             .Alignment = 1
1266:             .AutoSize  = .F.
1267:             .Visible   = .T.
1268:         ENDWITH
1269: 
1270:         loc_oPagina.AddObject("chk_4c_Chk_cruzado", "CheckBox")
1271:         WITH loc_oPagina.chk_4c_Chk_cruzado
1272:             .Top       = 423
1273:             .Left      = 630
1274:             .Width     = 18
1275:             .Height    = 15
1276:             .Caption   = ""
1277:             .Value     = 0
1278:             .Alignment = 0
1279:             .BackStyle = 0
1280:             .AutoSize  = .T.
1281:             .Visible   = .T.
1282:         ENDWITH
1283: 
1284:         *-- Pertochek / Check-Pronto
1285:         loc_oPagina.AddObject("lbl_4c_Label6", "Label")
1286:         WITH loc_oPagina.lbl_4c_Label6
1287:             .Top       = 442
1288:             .Left      = 493
1289:             .Width     = 135
1290:             .Height    = 17
1291:             .Caption   = "Pertochek / Check-Pronto :"
1292:             .FontName  = "Tahoma"
1293:             .FontSize  = 8
1294:             .ForeColor = RGB(255, 255, 255)
1295:             .BackStyle = 0
1296:             .Alignment = 1
1297:             .AutoSize  = .F.
1298:             .Visible   = .T.
1299:         ENDWITH
1300: 
1301:         loc_oPagina.AddObject("chk_4c_Chk_perto", "CheckBox")
1302:         WITH loc_oPagina.chk_4c_Chk_perto
1303:             .Top       = 442
1304:             .Left      = 630
1305:             .Width     = 18
1306:             .Height    = 15
1307:             .Caption   = ""
1308:             .Value     = 0
1309:             .Alignment = 0
1310:             .BackStyle = 0
1311:             .AutoSize  = .T.
1312:             .Visible   = .T.
1313:         ENDWITH
1314: 
1315:         *-- Autentica (OptionGroup 1=Sim, 2=Nao)
1316:         loc_oPagina.AddObject("lbl_4c_Label14", "Label")
1317:         WITH loc_oPagina.lbl_4c_Label14
1318:             .Top       = 461
1319:             .Left      = 573
1320:             .Width     = 55
1321:             .Height    = 17
1322:             .Caption   = "Autentica :"
1323:             .FontName  = "Tahoma"
1324:             .FontSize  = 8
1325:             .ForeColor = RGB(255, 255, 255)
1326:             .BackStyle = 0
1327:             .Alignment = 1

*-- Linhas 1335 a 1379:
1335:             .BackStyle   = 0
1336:             .BorderStyle = 0
1337:             .Value       = 1
1338:             .Top         = 429
1339:             .Left        = 625
1340:             .Width       = 95
1341:             .Height      = 22
1342:             .Visible     = .T.
1343:             WITH .Buttons(1)
1344:                 .Caption   = "Sim"
1345:                 .Left      = 5
1346:                 .Top       = 3
1347:                 .Width     = 44
1348:                 .Height    = 17
1349:                 .AutoSize  = .T.
1350:                 .ForeColor = RGB(90, 90, 90)
1351:                 .BackStyle = 0
1352:             ENDWITH
1353:             WITH .Buttons(2)
1354:                 .Caption   = "N" + CHR(227) + "o"
1355:                 .Left      = 56
1356:                 .Top       = 3
1357:                 .Width     = 61
1358:                 .Height    = 17
1359:                 .AutoSize  = .T.
1360:                 .FontName  = "Tahoma"
1361:                 .FontSize  = 8
1362:                 .ForeColor = RGB(90, 90, 90)
1363:                 .BackStyle = 0
1364:             ENDWITH
1365:         ENDWITH
1366: 
1367:         *-- Imprime Codigo de Barras (OptionGroup 1=Sim, 2=Nao)
1368:         loc_oPagina.AddObject("lbl_4c_Label26", "Label")
1369:         WITH loc_oPagina.lbl_4c_Label26
1370:             .Top       = 483
1371:             .Left      = 496
1372:             .Width     = 132
1373:             .Height    = 17
1374:             .Caption   = "Imprime C" + CHR(243) + "digo de Barras :"
1375:             .FontName  = "Tahoma"
1376:             .FontSize  = 8
1377:             .ForeColor = RGB(255, 255, 255)
1378:             .BackStyle = 0
1379:             .Alignment = 1

*-- Linhas 1387 a 1444:
1387:             .BackStyle   = 0
1388:             .BorderStyle = 0
1389:             .Value       = 1
1390:             .Top         = 451
1391:             .Left        = 624
1392:             .Width       = 95
1393:             .Height      = 22
1394:             .Visible     = .T.
1395:             WITH .Buttons(1)
1396:                 .Caption   = "Sim"
1397:                 .Left      = 5
1398:                 .Top       = 3
1399:                 .Width     = 44
1400:                 .Height    = 17
1401:                 .AutoSize  = .T.
1402:                 .ForeColor = RGB(90, 90, 90)
1403:                 .BackStyle = 0
1404:             ENDWITH
1405:             WITH .Buttons(2)
1406:                 .Caption   = "N" + CHR(227) + "o"
1407:                 .Left      = 56
1408:                 .Top       = 3
1409:                 .Width     = 61
1410:                 .Height    = 17
1411:                 .AutoSize  = .T.
1412:                 .FontName  = "Tahoma"
1413:                 .FontSize  = 8
1414:                 .ForeColor = RGB(90, 90, 90)
1415:                 .BackStyle = 0
1416:             ENDWITH
1417:         ENDWITH
1418: 
1419:         *-- Codigo Nacional do ECF (ReadOnly - getcodnac.When = .F. no legado)
1420:         loc_oPagina.AddObject("lbl_4c_Label28", "Label")
1421:         WITH loc_oPagina.lbl_4c_Label28
1422:             .Top       = 509
1423:             .Left      = 506
1424:             .Width     = 122
1425:             .Height    = 17
1426:             .Caption   = "C" + CHR(243) + "digo Nacional do ECF :"
1427:             .FontName  = "Tahoma"
1428:             .FontSize  = 8
1429:             .ForeColor = RGB(255, 255, 255)
1430:             .BackStyle = 0
1431:             .Alignment = 1
1432:             .AutoSize  = .F.
1433:             .Visible   = .T.
1434:         ENDWITH
1435: 
1436:         loc_oPagina.AddObject("txt_4c_Codnac", "TextBox")
1437:         WITH loc_oPagina.txt_4c_Codnac
1438:             .Top       = 505
1439:             .Left      = 630
1440:             .Width     = 52
1441:             .Height    = 23
1442:             .Value     = ""
1443:             .MaxLength = 6
1444:             .InputMask = "999999"

*-- Linhas 1452 a 1482:
1452:         ENDWITH
1453: 
1454:         *-- Incidencia Desc. ISSQN
1455:         loc_oPagina.AddObject("lbl_4c_Label29", "Label")
1456:         WITH loc_oPagina.lbl_4c_Label29
1457:             .Top       = 534
1458:             .Left      = 507
1459:             .Width     = 121
1460:             .Height    = 17
1461:             .Caption   = "Incid" + CHR(234) + "ncia Desc. ISSQN :"
1462:             .FontName  = "Tahoma"
1463:             .FontSize  = 8
1464:             .ForeColor = RGB(255, 255, 255)
1465:             .BackStyle = 0
1466:             .Alignment = 1
1467:             .AutoSize  = .F.
1468:             .Visible   = .T.
1469:         ENDWITH
1470: 
1471:         loc_oPagina.AddObject("chk_4c_Fwcheckbox3", "CheckBox")
1472:         WITH loc_oPagina.chk_4c_Fwcheckbox3
1473:             .Top       = 534
1474:             .Left      = 629
1475:             .Width     = 18
1476:             .Height    = 15
1477:             .Caption   = ""
1478:             .Value     = 0
1479:             .Alignment = 0
1480:             .BackStyle = 0
1481:             .AutoSize  = .T.
1482:             .Visible   = .T.

*-- Linhas 1508 a 1519:
1508:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.cncaixas"
1509: 
1510:                     *-- Redefinir headers apos RecordSource (VFP9 reseta cabecalhos)
1511:                     loc_oGrid.Column1.Header1.Caption = "N" + CHR(186) + " Fabrica" + CHR(231) + CHR(227) + "o"
1512:                     loc_oGrid.Column2.Header1.Caption = "Empresa"
1513:                     loc_oGrid.Column3.Header1.Caption = "Fabrica" + CHR(231) + CHR(227) + "o (Criptografado)"
1514:                     loc_oGrid.Column4.Header1.Caption = "Caixa"
1515: 
1516:                     THIS.FormatarGridLista(loc_oGrid)
1517:                     loc_lResultado = .T.
1518:                 ENDIF
1519:             ENDIF

*-- Linhas 1830 a 1846:
1830:             loc_oBO.this_lLeitMF    = (loc_oPg2.chk_4c_Chk_LeitMF.Value  = 1)
1831:             loc_oBO.this_lGaveta    = (loc_oPg2.chk_4c_Chk_gaveta.Value  = 1)
1832:             loc_oBO.this_lImpCheque = (loc_oPg2.chk_4c_Chk_impche.Value  = 1)
1833:             loc_oBO.this_lMFD       = (loc_oPg2.chk_4c_Fwcheckbox2.Value = 1)
1834:             loc_oBO.this_lInativa   = (loc_oPg2.chk_4c_Fwcheckbox1.Value = 1)
1835:             loc_oBO.this_lBomPara   = (loc_oPg2.chk_4c_Chk_Bompara.Value = 1)
1836:             loc_oBO.this_lNominal   = (loc_oPg2.chk_4c_Chk_nominal.Value = 1)
1837:             loc_oBO.this_lCruzado   = (loc_oPg2.chk_4c_Chk_cruzado.Value = 1)
1838:             loc_oBO.this_lPerto     = (loc_oPg2.chk_4c_Chk_perto.Value   = 1)
1839:             loc_oBO.this_nAutentica = loc_oPg2.obj_4c_Optiongroup1.Value
1840:             loc_oBO.this_nImpBars   = loc_oPg2.obj_4c_Optiongroup2.Value
1841:             loc_oBO.this_lISSQN     = (loc_oPg2.chk_4c_Fwcheckbox3.Value = 1)
1842: 
1843:             loc_lResultado = .T.
1844:         CATCH TO loc_oErro
1845:             MostrarErro(loc_oErro, "FormFBI.FormParaBO")
1846:         ENDTRY

*-- Linhas 1880 a 1896:
1880:             loc_oPg2.chk_4c_Chk_LeitMF.Value  = IIF(loc_oBO.this_lLeitMF,    1, 0)
1881:             loc_oPg2.chk_4c_Chk_gaveta.Value  = IIF(loc_oBO.this_lGaveta,    1, 0)
1882:             loc_oPg2.chk_4c_Chk_impche.Value  = IIF(loc_oBO.this_lImpCheque, 1, 0)
1883:             loc_oPg2.chk_4c_Fwcheckbox2.Value = IIF(loc_oBO.this_lMFD,       1, 0)
1884:             loc_oPg2.chk_4c_Fwcheckbox1.Value = IIF(loc_oBO.this_lInativa,   1, 0)
1885:             loc_oPg2.chk_4c_Chk_Bompara.Value = IIF(loc_oBO.this_lBomPara,   1, 0)
1886:             loc_oPg2.chk_4c_Chk_nominal.Value = IIF(loc_oBO.this_lNominal,   1, 0)
1887:             loc_oPg2.chk_4c_Chk_cruzado.Value = IIF(loc_oBO.this_lCruzado,   1, 0)
1888:             loc_oPg2.chk_4c_Chk_perto.Value   = IIF(loc_oBO.this_lPerto,     1, 0)
1889:             loc_oPg2.obj_4c_Optiongroup1.Value = loc_oBO.this_nAutentica
1890:             loc_oPg2.obj_4c_Optiongroup2.Value = loc_oBO.this_nImpBars
1891:             loc_oPg2.chk_4c_Fwcheckbox3.Value = IIF(loc_oBO.this_lISSQN,     1, 0)
1892: 
1893:             loc_lResultado = .T.
1894:         CATCH TO loc_oErro
1895:             MostrarErro(loc_oErro, "FormFBI.BOParaForm")
1896:         ENDTRY

*-- Linhas 1936 a 1952:
1936:             loc_oPg2.chk_4c_Chk_LeitMF.Enabled  = par_lHabilitar
1937:             loc_oPg2.chk_4c_Chk_gaveta.Enabled  = par_lHabilitar
1938:             loc_oPg2.chk_4c_Chk_impche.Enabled  = par_lHabilitar
1939:             loc_oPg2.chk_4c_Fwcheckbox2.Enabled = par_lHabilitar
1940:             loc_oPg2.chk_4c_Fwcheckbox1.Enabled = par_lHabilitar
1941:             loc_oPg2.chk_4c_Chk_Bompara.Enabled = par_lHabilitar
1942:             loc_oPg2.chk_4c_Chk_nominal.Enabled = par_lHabilitar
1943:             loc_oPg2.chk_4c_Chk_cruzado.Enabled = par_lHabilitar
1944:             loc_oPg2.chk_4c_Chk_perto.Enabled   = par_lHabilitar
1945:             loc_oPg2.obj_4c_Optiongroup1.Enabled = par_lHabilitar
1946:             loc_oPg2.obj_4c_Optiongroup2.Enabled = par_lHabilitar
1947:             loc_oPg2.chk_4c_Fwcheckbox3.Enabled = par_lHabilitar
1948: 
1949:             loc_lResultado = .T.
1950:         CATCH TO loc_oErro
1951:             MostrarErro(loc_oErro, "FormFBI.HabilitarCampos")
1952:         ENDTRY

*-- Linhas 1985 a 2001:
1985:             loc_oPg2.chk_4c_Chk_LeitMF.Value  = 0
1986:             loc_oPg2.chk_4c_Chk_gaveta.Value  = 0
1987:             loc_oPg2.chk_4c_Chk_impche.Value  = 0
1988:             loc_oPg2.chk_4c_Fwcheckbox2.Value = 0
1989:             loc_oPg2.chk_4c_Fwcheckbox1.Value = 0
1990:             loc_oPg2.chk_4c_Chk_Bompara.Value = 0
1991:             loc_oPg2.chk_4c_Chk_nominal.Value = 0
1992:             loc_oPg2.chk_4c_Chk_cruzado.Value = 0
1993:             loc_oPg2.chk_4c_Chk_perto.Value   = 0
1994:             loc_oPg2.obj_4c_Optiongroup1.Value = 1
1995:             loc_oPg2.obj_4c_Optiongroup2.Value = 1
1996:             loc_oPg2.chk_4c_Fwcheckbox3.Value = 0
1997: 
1998:             loc_lResultado = .T.
1999:         CATCH TO loc_oErro
2000:             MostrarErro(loc_oErro, "FormFBI.LimparCampos")
2001:         ENDTRY

*-- Linhas 2009 a 2017:
2009:     PROTECTED PROCEDURE AjustarBotoesPorModo()
2010:         LOCAL loc_lConfirmarAtivo
2011:         loc_lConfirmarAtivo = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2012:         THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lConfirmarAtivo
2013:     ENDPROC
2014: 
2015:     *====================================================================
2016:     * BtnIncluirClick - Prepara formulario para inclusao de novo registro
2017:     *====================================================================


### BO (C:\4c\projeto\app\classes\FBIBO.prg):
*====================================================================
* FBIBO.prg
*
* Business Object para Cadastro de Fabricacao (SigFiMpf)
* Herda de: BusinessBase
*
* Tabela: SigFiMpf
* Chave primaria: cImpFabs (No. Fabricacao / NFAB)
*
* Campos GT (cgtinics, cgtatuas) armazenados como strings no legado.
*====================================================================

DEFINE CLASS FBIBO AS BusinessBase

    *-- Identificacao do ECF
    this_cCodigo        = ""   && cImpFabs char(20)   - No. Fabricacao / NFAB (PK)
    this_cEmpresa       = ""   && emps char(3)         - Codigo da empresa
    this_cNcaixas       = ""   && cncaixas char(3)     - No. do Caixa / NSEQ

    *-- Contadores e registradores
    this_cInterv        = ""   && cnintervs char(4)    - Contador Reinicio de Operacao
    this_cGTInics       = ""   && cgtinics char(30)    - GT Inicial (string)
    this_cGTAtuas       = ""   && cgtatuas char(30)    - GT Atual (string)

    *-- Modelo e identificacao do ECF
    this_cModelo        = ""   && cModelos char(30)    - Modelo da impressora ECF
    this_cNumUsuars     = ""   && cnumusuars char(2)   - Numero do Usuario do ECF
    this_cTipoECF       = ""   && ctipoecfs char(7)    - Tipo do ECF
    this_cCodNac        = ""   && cidecfs char(6)      - Codigo Nacional do ECF
    this_cIfCoos        = ""   && cIfCoos char(6)      - COO Inicial (Troca Aplicativo)
    this_cCROIniOps     = ""   && ccroiniops char(6)   - CRO Inicial de Operacoes

    *-- Software Basico
    this_cVersaoSB      = ""   && cversaosbs char(10)  - Versao do Software Basico
    this_dDataSB        = {}   && tdatasbs date        - Data do Software Basico
    this_cHoraSB        = ""   && chorasbs char(8)     - Hora do Software Basico (HH:MM:SS)

    *-- Dados de cadastro do ECF
    this_dDtCadECF      = {}   && tdtcadecfs date      - Data do Cadastro do ECF
    this_cHrCadECF      = ""   && chrcadecfs char(8)   - Hora do Cadastro do ECF (HH:MM:SS)

    *-- Comando RFD
    this_cCmdRFD        = ""   && ccmdgers char(3)     - Comando de Geracao RFD

    *-- Flags booleanos (BIT no SQL Server)
    this_lGaveta        = .F.  && gavetas              - Gaveta Acoplada
    this_lImpCheque     = .F.  && impches              - Impressora de Cheques
    this_lPerto         = .F.  && Pertos               - Pertochek / Check-Pronto
    this_lBomPara       = .F.  && bompara              - Bom Para (uso cheque)
    this_lNominal       = .F.  && nominal              - Nominal
    this_lCruzado       = .F.  && cruzado              - Cruzado
    this_lInativa       = .F.  && ImpAtivas            - Impressora Inativa
    this_lLeitMF        = .F.  && MemFautos            - Leitura Mem. Fiscal Automatico
    this_lMFD           = .F.  && impmfds              - MFD (Memoria de Fita Detalhe)
    this_lISSQN         = .F.  && cissqns              - Incidencia Desconto ISSQN

    *-- Opcoes OptionGroup (N: 1=Sim, 2=Nao)
    this_nAutentica     = 1    && Autenticas           - Autentica cheque (1=Sim, 2=Nao)
    this_nImpBars       = 1    && nImpBars             - Imprime Cod. de Barras (1=Sim, 2=Nao)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigFiMpf"
        THIS.this_cCampoChave = "cImpFabs"
        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDPROC

    *====================================================================
    * LimparDados - Limpa propriedades (chamado por NovoRegistro)
    *====================================================================
    PROTECTED PROCEDURE LimparDados()
        THIS.this_cCodigo    = ""
        THIS.this_cEmpresa   = ""
        THIS.this_cNcaixas   = ""
        THIS.this_cInterv    = ""
        THIS.this_cGTInics   = ""
        THIS.this_cGTAtuas   = ""
        THIS.this_cModelo    = ""
        THIS.this_cNumUsuars = ""
        THIS.this_cTipoECF   = ""
        THIS.this_cCodNac    = ""
        THIS.this_cIfCoos    = ""
        THIS.this_cCROIniOps = ""
        THIS.this_cVersaoSB  = ""
        THIS.this_dDataSB    = {}
        THIS.this_cHoraSB    = ""
        THIS.this_dDtCadECF  = {}
        THIS.this_cHrCadECF  = ""
        THIS.this_cCmdRFD    = ""
        THIS.this_lGaveta    = .F.
        THIS.this_lImpCheque = .F.
        THIS.this_lPerto     = .F.
        THIS.this_lBomPara   = .F.
        THIS.this_lNominal   = .F.
        THIS.this_lCruzado   = .F.
        THIS.this_lInativa   = .F.
        THIS.this_lLeitMF    = .F.
        THIS.this_lMFD       = .F.
        THIS.this_lISSQN     = .F.
        THIS.this_nAutentica = 1
        THIS.this_nImpBars   = 1
    ENDPROC

    *====================================================================
    * Buscar - Retorna lista de registros (cursor_4c_Dados)
    *====================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cImpFabs, emps, cncaixas, cnintervs," + ;
                       " cgtinics, cgtatuas, cModelos, cnumusuars, ctipoecfs," + ;
                       " cidecfs, cIfCoos, ccroiniops, cversaosbs," + ;
                       " tdatasbs, chorasbs, tdtcadecfs, chrcadecfs, ccmdgers," + ;
                       " gavetas, impches, Pertos, bompara, nominal, cruzado," + ;
                       " ImpAtivas, MemFautos, Autenticas, impmfds, nImpBars, cissqns" + ;
                       " FROM SigFiMpf"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE cImpFabs LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%")
                loc_cSQL = loc_cSQL + loc_cWhere
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY cImpFabs"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado > 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar registros: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FBIBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (cImpFabs)
    *====================================================================
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cImpFabs, emps, cncaixas, cnintervs," + ;
                       " cgtinics, cgtatuas, cModelos, cnumusuars, ctipoecfs," + ;
                       " cidecfs, cIfCoos, ccroiniops, cversaosbs," + ;
                       " tdatasbs, chorasbs, tdtcadecfs, chrcadecfs, ccmdgers," + ;
                       " gavetas, impches, Pertos, bompara, nominal, cruzado," + ;
                       " ImpAtivas, MemFautos, Autenticas, impmfds, nImpBars, cissqns" + ;
                       " FROM SigFiMpf WHERE cImpFabs = " + EscaparSQL(par_cCodigo)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                MostrarErro("Registro n" + CHR(227) + "o encontrado.", "")
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FBIBO.CarregarPorCodigo")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigo    = TratarNulo(cImpFabs, "C")
                THIS.this_cEmpresa   = TratarNulo(emps, "C")
                THIS.this_cNcaixas   = TratarNulo(cncaixas, "C")
                THIS.this_cInterv    = TratarNulo(cnintervs, "C")
                THIS.this_cGTInics   = TratarNulo(cgtinics, "C")
                THIS.this_cGTAtuas   = TratarNulo(cgtatuas, "C")
                THIS.this_cModelo    = TratarNulo(cModelos, "C")
                THIS.this_cNumUsuars = TratarNulo(cnumusuars, "C")
                THIS.this_cTipoECF   = TratarNulo(ctipoecfs, "C")
                THIS.this_cCodNac    = TratarNulo(cidecfs, "C")
                THIS.this_cIfCoos    = TratarNulo(cIfCoos, "C")
                THIS.this_cCROIniOps = TratarNulo(ccroiniops, "C")
                THIS.this_cVersaoSB  = TratarNulo(cversaosbs, "C")
                THIS.this_dDataSB    = TratarNulo(tdatasbs, "D")
                THIS.this_cHoraSB    = TratarNulo(chorasbs, "C")
                THIS.this_dDtCadECF  = TratarNulo(tdtcadecfs, "D")
                THIS.this_cHrCadECF  = TratarNulo(chrcadecfs, "C")
                THIS.this_cCmdRFD    = TratarNulo(ccmdgers, "C")
                IF VARTYPE(gavetas) = "L"
                    THIS.this_lGaveta = gavetas
                ELSE
                    IF VARTYPE(gavetas) = "L"
                        THIS.this_lGaveta = gavetas
                    ELSE
                        IF VARTYPE(gavetas) = "L"
                            THIS.this_lGaveta = gavetas
                        ELSE
                            IF VARTYPE(gavetas) = "L"
                                THIS.this_lGaveta = gavetas
                            ELSE
                                IF VARTYPE(gavetas) = "L"
                                    THIS.this_lGaveta = gavetas
                                ELSE
                                    IF VARTYPE(gavetas) = "L"
                                        THIS.this_lGaveta = gavetas
                                    ELSE
                                        THIS.this_lGaveta = (NVL(gavetas, 0) = 1)
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
                IF VARTYPE(impches) = "L"
                    THIS.this_lImpCheque = impches
                ELSE
                    IF VARTYPE(impches) = "L"
                        THIS.this_lImpCheque = impches
                    ELSE
                        IF VARTYPE(impches) = "L"
                            THIS.this_lImpCheque = impches
                        ELSE
                            IF VARTYPE(impches) = "L"
                                THIS.this_lImpCheque = impches
                            ELSE
                                IF VARTYPE(impches) = "L"
                                    THIS.this_lImpCheque = impches
                                ELSE
                                    IF VARTYPE(impches) = "L"
                                        THIS.this_lImpCheque = impches
                                    ELSE
                                        THIS.this_lImpCheque = (NVL(impches, 0) = 1)
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
                IF VARTYPE(Pertos) = "L"
                    THIS.this_lPerto = Pertos
                ELSE
                    IF VARTYPE(Pertos) = "L"
                        THIS.this_lPerto = Pertos
                    ELSE
                        IF VARTYPE(Pertos) = "L"
                            THIS.this_lPerto = Pertos
                        ELSE
                            IF VARTYPE(Pertos) = "L"
                                THIS.this_lPerto = Pertos
                            ELSE
                                IF VARTYPE(Pertos) = "L"
                                    THIS.this_lPerto = Pertos
                                ELSE
                                    IF VARTYPE(Pertos) = "L"
                                        THIS.this_lPerto = Pertos
                                    ELSE
                                        THIS.this_lPerto = (NVL(Pertos, 0) = 1)
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
                IF VARTYPE(bompara) = "L"
                    THIS.this_lBomPara = bompara
                ELSE
                    IF VARTYPE(bompara) = "L"
                        THIS.this_lBomPara = bompara
                    ELSE
                        IF VARTYPE(bompara) = "L"
                            THIS.this_lBomPara = bompara
                        ELSE
                            IF VARTYPE(bompara) = "L"
                                THIS.this_lBomPara = bompara
                            ELSE
                                IF VARTYPE(bompara) = "L"
                                    THIS.this_lBomPara = bompara
                                ELSE
                                    IF VARTYPE(bompara) = "L"
                                        THIS.this_lBomPara = bompara
                                    ELSE
                                        THIS.this_lBomPara = (NVL(bompara, 0) = 1)
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
                IF VARTYPE(nominal) = "L"
                    THIS.this_lNominal = nominal
                ELSE
                    IF VARTYPE(nominal) = "L"
                        THIS.this_lNominal = nominal
                    ELSE
                        IF VARTYPE(nominal) = "L"
                            THIS.this_lNominal = nominal
                        ELSE
                            IF VARTYPE(nominal) = "L"
                                THIS.this_lNominal = nominal
                            ELSE
                                IF VARTYPE(nominal) = "L"
                                    THIS.this_lNominal = nominal
                                ELSE
                                    IF VARTYPE(nominal) = "L"
                                        THIS.this_lNominal = nominal
                                    ELSE
                                        THIS.this_lNominal = (NVL(nominal, 0) = 1)
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
                IF VARTYPE(cruzado) = "L"
                    THIS.this_lCruzado = cruzado
                ELSE
                    IF VARTYPE(cruzado) = "L"
                        THIS.this_lCruzado = cruzado
                    ELSE
                        IF VARTYPE(cruzado) = "L"
                            THIS.this_lCruzado = cruzado
                        ELSE
                            IF VARTYPE(cruzado) = "L"
                                THIS.this_lCruzado = cruzado
                            ELSE
                                IF VARTYPE(cruzado) = "L"
                                    THIS.this_lCruzado = cruzado
                                ELSE
                                    IF VARTYPE(cruzado) = "L"
                                        THIS.this_lCruzado = cruzado
                                    ELSE
                                        THIS.this_lCruzado = (NVL(cruzado, 0) = 1)
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
                IF VARTYPE(ImpAtivas) = "L"
                    THIS.this_lInativa = ImpAtivas
                ELSE
                    IF VARTYPE(ImpAtivas) = "L"
                        THIS.this_lInativa = ImpAtivas
                    ELSE
                        IF VARTYPE(ImpAtivas) = "L"
                            THIS.this_lInativa = ImpAtivas
                        ELSE
                            IF VARTYPE(ImpAtivas) = "L"
                                THIS.this_lInativa = ImpAtivas
                            ELSE
                                IF VARTYPE(ImpAtivas) = "L"
                                    THIS.this_lInativa = ImpAtivas
                                ELSE
                                    IF VARTYPE(ImpAtivas) = "L"
                                        THIS.this_lInativa = ImpAtivas
                                    ELSE
                                        THIS.this_lInativa = (NVL(ImpAtivas, 0) = 1)
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
                IF VARTYPE(MemFautos) = "L"
                    THIS.this_lLeitMF = MemFautos
                ELSE
                    IF VARTYPE(MemFautos) = "L"
                        THIS.this_lLeitMF = MemFautos
                    ELSE
                        IF VARTYPE(MemFautos) = "L"
                            THIS.this_lLeitMF = MemFautos
                        ELSE
                            IF VARTYPE(MemFautos) = "L"
                                THIS.this_lLeitMF = MemFautos
                            ELSE
                                IF VARTYPE(MemFautos) = "L"
                                    THIS.this_lLeitMF = MemFautos
                                ELSE
                                    IF VARTYPE(MemFautos) = "L"
                                        THIS.this_lLeitMF = MemFautos
                                    ELSE
                                        THIS.this_lLeitMF = (NVL(MemFautos, 0) = 1)
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
                IF VARTYPE(impmfds) = "L"
                    THIS.this_lMFD = impmfds
                ELSE
                    IF VARTYPE(impmfds) = "L"
                        THIS.this_lMFD = impmfds
                    ELSE
                        IF VARTYPE(impmfds) = "L"
                            THIS.this_lMFD = impmfds
                        ELSE
                            IF VARTYPE(impmfds) = "L"
                                THIS.this_lMFD = impmfds
                            ELSE
                                IF VARTYPE(impmfds) = "L"
                                    THIS.this_lMFD = impmfds
                                ELSE
                                    IF VARTYPE(impmfds) = "L"
                                        THIS.this_lMFD = impmfds
                                    ELSE
                                        THIS.this_lMFD = (NVL(impmfds, 0) = 1)
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
                IF VARTYPE(cissqns) = "L"
                    THIS.this_lISSQN = cissqns
                ELSE
                    IF VARTYPE(cissqns) = "L"
                        THIS.this_lISSQN = cissqns
                    ELSE
                        IF VARTYPE(cissqns) = "L"
                            THIS.this_lISSQN = cissqns
                        ELSE
                            IF VARTYPE(cissqns) = "L"
                                THIS.this_lISSQN = cissqns
                            ELSE
                                IF VARTYPE(cissqns) = "L"
                                    THIS.this_lISSQN = cissqns
                                ELSE
                                    IF VARTYPE(cissqns) = "L"
                                        THIS.this_lISSQN = cissqns
                                    ELSE
                                        THIS.this_lISSQN = (NVL(cissqns, 0) = 1)
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
                THIS.this_nAutentica = NVL(Autenticas, 1)
                THIS.this_nImpBars   = NVL(nImpBars, 1)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FBIBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - INSERT em SigFiMpf
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        LOCAL loc_cDataSB, loc_cDtCadECF
        loc_lSucesso = .F.

        TRY
            loc_cDataSB   = IIF(EMPTY(THIS.this_dDataSB),   "NULL", FormatarDataSQL(THIS.this_dDataSB))
            loc_cDtCadECF = IIF(EMPTY(THIS.this_dDtCadECF), "NULL", FormatarDataSQL(THIS.this_dDtCadECF))

            loc_cSQL = "INSERT INTO SigFiMpf (" + ;
                       " cImpFabs, emps, cncaixas, cnintervs," + ;
                       " cgtinics, cgtatuas, cModelos, cnumusuars, ctipoecfs," + ;
                       " cidecfs, cIfCoos, ccroiniops, cversaosbs," + ;
                       " tdatasbs, chorasbs, tdtcadecfs, chrcadecfs, ccmdgers," + ;
                       " gavetas, impches, Pertos, bompara, nominal, cruzado," + ;
                       " ImpAtivas, MemFautos, Autenticas, impmfds, nImpBars, cissqns" + ;
                       ") VALUES (" + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodigo), 20)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmpresa), 3)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cNcaixas), 3)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cInterv), 4)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cGTInics), 30)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cGTAtuas), 30)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cModelo), 30)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cNumUsuars), 2)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cTipoECF), 7)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodNac), 6)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cIfCoos), 6)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cCROIniOps), 6)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cVersaoSB), 10)) + ", " + ;
                       loc_cDataSB + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cHoraSB), 8)) + ", " + ;
                       loc_cDtCadECF + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cHrCadECF), 8)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cCmdRFD), 3)) + ", " + ;
                       IIF(THIS.this_lGaveta,    "1", "0") + ", " + ;
                       IIF(THIS.this_lImpCheque, "1", "0") + ", " + ;
                       IIF(THIS.this_lPerto,     "1", "0") + ", " + ;
                       IIF(THIS.this_lBomPara,   "1", "0") + ", " + ;
                       IIF(THIS.this_lNominal,   "1", "0") + ", " + ;
                       IIF(THIS.this_lCruzado,   "1", "0") + ", " + ;
                       IIF(THIS.this_lInativa,   "1", "0") + ", " + ;
                       IIF(THIS.this_lLeitMF,    "1", "0") + ", " + ;
                       FormatarNumeroSQL(THIS.this_nAutentica) + ", " + ;
                       IIF(THIS.this_lMFD,       "1", "0") + ", " + ;
                       FormatarNumeroSQL(THIS.this_nImpBars) + ", " + ;
                       IIF(THIS.this_lISSQN,     "1", "0") + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir registro: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FBIBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE em SigFiMpf
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        LOCAL loc_cDataSB, loc_cDtCadECF
        loc_lSucesso = .F.

        TRY
            loc_cDataSB   = IIF(EMPTY(THIS.this_dDataSB),   "NULL", FormatarDataSQL(THIS.this_dDataSB))
            loc_cDtCadECF = IIF(EMPTY(THIS.this_dDtCadECF), "NULL", FormatarDataSQL(THIS.this_dDtCadECF))

            loc_cSQL = "UPDATE SigFiMpf SET" + ;
                       " cImpFabs   = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodigo), 20)) + "," + ;
                       " emps       = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmpresa), 3)) + "," + ;
                       " cncaixas   = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cNcaixas), 3)) + "," + ;
                       " cnintervs  = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cInterv), 4)) + "," + ;
                       " cgtinics   = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cGTInics), 30)) + "," + ;
                       " cgtatuas   = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cGTAtuas), 30)) + "," + ;
                       " cModelos   = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cModelo), 30)) + "," + ;
                       " cnumusuars = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cNumUsuars), 2)) + "," + ;
                       " ctipoecfs  = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cTipoECF), 7)) + "," + ;
                       " cidecfs    = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodNac), 6)) + "," + ;
                       " cIfCoos    = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cIfCoos), 6)) + "," + ;
                       " ccroiniops = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCROIniOps), 6)) + "," + ;
                       " cversaosbs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cVersaoSB), 10)) + "," + ;
                       " tdatasbs   = " + loc_cDataSB + "," + ;
                       " chorasbs   = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cHoraSB), 8)) + "," + ;
                       " tdtcadecfs = " + loc_cDtCadECF + "," + ;
                       " chrcadecfs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cHrCadECF), 8)) + "," + ;
                       " ccmdgers   = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCmdRFD), 3)) + "," + ;
                       " gavetas    = " + IIF(THIS.this_lGaveta,    "1", "0") + "," + ;
                       " impches    = " + IIF(THIS.this_lImpCheque, "1", "0") + "," + ;
                       " Pertos     = " + IIF(THIS.this_lPerto,     "1", "0") + "," + ;
                       " bompara    = " + IIF(THIS.this_lBomPara,   "1", "0") + "," + ;
                       " nominal    = " + IIF(THIS.this_lNominal,   "1", "0") + "," + ;
                       " cruzado    = " + IIF(THIS.this_lCruzado,   "1", "0") + "," + ;
                       " ImpAtivas  = " + IIF(THIS.this_lInativa,   "1", "0") + "," + ;
                       " MemFautos  = " + IIF(THIS.this_lLeitMF,    "1", "0") + "," + ;
                       " Autenticas = " + FormatarNumeroSQL(THIS.this_nAutentica) + "," + ;
                       " impmfds    = " + IIF(THIS.this_lMFD,       "1", "0") + "," + ;
                       " nImpBars   = " + FormatarNumeroSQL(THIS.this_nImpBars) + "," + ;
                       " cissqns    = " + IIF(THIS.this_lISSQN,     "1", "0") + ;
                       " WHERE cImpFabs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodigo), 20))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar registro: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FBIBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - DELETE em SigFiMpf com verificacao de dependencias
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_lMovimento
        loc_lSucesso  = .F.
        loc_lMovimento = .F.

        TRY
            *-- Verificar movimentos em SigMvCab
            loc_cSQL = "SELECT EmpDopNums FROM SigMvCab WHERE nEmps = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ChkMvCab")
                TABLEREVERT(.T., "cursor_4c_ChkMvCab")
                USE IN cursor_4c_ChkMvCab
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkMvCab")
            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ChkMvCab") > 0
                loc_lMovimento = .T.
            ENDIF
            IF USED("cursor_4c_ChkMvCab")
                USE IN cursor_4c_ChkMvCab
            ENDIF

            *-- Verificar movimentos em SigExMvc
            IF !loc_lMovimento
                loc_cSQL = "SELECT EmpDopNums FROM SigExMvc WHERE nEmps = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_ChkExMvc")
                    TABLEREVERT(.T., "cursor_4c_ChkExMvc")
                    USE IN cursor_4c_ChkExMvc
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkExMvc")
                IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ChkExMvc") > 0
                    loc_lMovimento = .T.
                ENDIF
                IF USED("cursor_4c_ChkExMvc")
                    USE IN cursor_4c_ChkExMvc
                ENDIF
            ENDIF

            *-- Verificar lancamentos em SigFiRX
            IF !loc_lMovimento
                loc_cSQL = "SELECT datas FROM SigFiRX WHERE serifab = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_ChkFiRX")
                    TABLEREVERT(.T., "cursor_4c_ChkFiRX")
                    USE IN cursor_4c_ChkFiRX
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkFiRX")
                IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ChkFiRX") > 0
                    loc_lMovimento = .T.
                ENDIF
                IF USED("cursor_4c_ChkFiRX")
                    USE IN cursor_4c_ChkFiRX
                ENDIF
            ENDIF

            IF loc_lMovimento
                MsgAviso("Impressora Fiscal N" + CHR(227) + "o Pode Ser Exclui" + CHR(237) + "da, Possui Movimenta" + CHR(231) + CHR(227) + "o !!!")
            ELSE
                loc_cSQL = "DELETE FROM SigFiMpf WHERE cImpFabs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodigo), 20))
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao excluir registro: " + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FBIBO.ExecutarExclusao")
            IF USED("cursor_4c_ChkMvCab")
                USE IN cursor_4c_ChkMvCab
            ENDIF
            IF USED("cursor_4c_ChkExMvc")
                USE IN cursor_4c_ChkExMvc
            ENDIF
            IF USED("cursor_4c_ChkFiRX")
                USE IN cursor_4c_ChkFiRX
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

