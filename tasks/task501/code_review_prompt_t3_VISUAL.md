# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (6)
- [GRID-HEADER] Header Caption 'Processo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Emp, Local, Operação no Destino, Produto, Dias, Margem Mín., Margem Máx., GGpr, Operação na Origem, Uni, Cta.Origem, Cta.Destino, Sem Ítens, Fiscal, % Produto / $, Op Itens, % Compos., G.Grp., Grupo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Emp, Local, Operação no Destino, Produto, Dias, Margem Mín., Margem Máx., GGpr, Operação na Origem, Uni, Cta.Origem, Cta.Destino, Sem Ítens, Fiscal, % Produto / $, Op Itens, % Compos., G.Grp., Grupo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Processo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Emp, Local, Operação no Destino, Produto, Dias, Margem Mín., Margem Máx., GGpr, Operação na Origem, Uni, Cta.Origem, Cta.Destino, Sem Ítens, Fiscal, % Produto / $, Op Itens, % Compos., G.Grp., Grupo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Emp, Local, Operação no Destino, Produto, Dias, Margem Mín., Margem Máx., GGpr, Operação na Origem, Uni, Cta.Origem, Cta.Destino, Sem Ítens, Fiscal, % Produto / $, Op Itens, % Compos., G.Grp., Grupo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Processo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Emp, Local, Operação no Destino, Produto, Dias, Margem Mín., Margem Máx., GGpr, Operação na Origem, Uni, Cta.Origem, Cta.Destino, Sem Ítens, Fiscal, % Produto / $, Op Itens, % Compos., G.Grp., Grupo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Emp, Local, Operação no Destino, Produto, Dias, Margem Mín., Margem Máx., GGpr, Operação na Origem, Uni, Cta.Origem, Cta.Destino, Sem Ítens, Fiscal, % Produto / $, Op Itens, % Compos., G.Grp., Grupo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formprc.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (3929 linhas total):

*-- Linhas 50 a 58:
50:         loc_lResultado = .F.
51: 
52:         TRY
53:             THIS.Caption = "Cadastro de Movimenta" + CHR(231) + CHR(245) + "es Para C" + CHR(243) + "pia"
54: 
55:             THIS.this_oBusinessObject = CREATEOBJECT("prcBO")
56: 
57:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
58:                 MsgErro("Erro ao criar prcBO!" + CHR(13) + ;

*-- Linhas 88 a 100:
88:                 *-- Propaga caption para labels de titulo
89:                 loc_oCab = THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho
90:                 IF VARTYPE(loc_oCab) = "O"
91:                     IF VARTYPE(loc_oCab.lbl_4c_Sombra) = "O"
92:                         loc_oCab.lbl_4c_Sombra.Caption = THIS.Caption
93:                     ENDIF
94:                     IF VARTYPE(loc_oCab.lbl_4c_Titulo) = "O"
95:                         loc_oCab.lbl_4c_Titulo.Caption = THIS.Caption
96:                     ENDIF
97:                 ENDIF
98: 
99:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
100:                     THIS.CarregarLista()

*-- Linhas 120 a 135:
120:     PROTECTED PROCEDURE ConfigurarPageFrame()
121:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
122:         WITH THIS.pgf_4c_Paginas
123:             .Top       = -29
124:             .Left      = 0
125:             .Width     = THIS.Width
126:             .Height    = THIS.Height + 29
127:             .PageCount = 2
128:             .Tabs      = .F.
129:             .Page1.Caption = "Lista"
130:             .Page2.Caption = "Dados"
131:             .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
132:             .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
133:             .Visible   = .T.
134:         ENDWITH
135:     ENDPROC

*-- Linhas 146 a 181:
146:         *-- Cabecalho escuro com titulo
147:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
148:         WITH loc_oPagina.cnt_4c_Cabecalho
149:             .Top         = 30
150:             .Left        = 0
151:             .Width       = THIS.Width
152:             .Height      = 80
153:             .BackColor   = RGB(100, 100, 100)
154:             .BorderWidth = 0
155:             .Visible     = .T.
156: 
157:             .AddObject("lbl_4c_Sombra", "Label")
158:             WITH .lbl_4c_Sombra
159:                 .Caption   = THIS.Caption
160:                 .Top       = 15
161:                 .Left      = 10
162:                 .Width     = THIS.Width
163:                 .Height    = 40
164:                 .FontName  = "Tahoma"
165:                 .FontSize  = 16
166:                 .FontBold  = .T.
167:                 .ForeColor = RGB(0, 0, 0)
168:                 .BackStyle = 0
169:                 .Visible   = .T.
170:             ENDWITH
171: 
172:             .AddObject("lbl_4c_Titulo", "Label")
173:             WITH .lbl_4c_Titulo
174:                 .Caption   = THIS.Caption
175:                 .Top       = 18
176:                 .Left      = 10
177:                 .Width     = THIS.Width
178:                 .Height    = 46
179:                 .FontName  = "Tahoma"
180:                 .FontSize  = 16
181:                 .FontBold  = .T.

*-- Linhas 188 a 211:
188:         *-- Container botoes CRUD
189:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
190:         WITH loc_oPagina.cnt_4c_Botoes
191:             .Top         = 29
192:             .Left        = 542
193:             .Width       = 390
194:             .Height      = 85
195:             .BackStyle   = 1
196:             .BackColor   = RGB(53, 53, 53)
197:             .BorderWidth = 0
198:             .Visible     = .T.
199: 
200:             .AddObject("cmd_4c_Incluir", "CommandButton")
201:             WITH .cmd_4c_Incluir
202:                 .Caption         = "Incluir"
203:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
204:                 .PicturePosition = 13
205:                 .Top             = 5
206:                 .Left            =  542
207:                 .Width           = 75
208:                 .Height          = 75
209:                 .BackColor       = RGB(255, 255, 255)
210:                 .ForeColor       = RGB(90, 90, 90)
211:                 .FontName        = "Tahoma"

*-- Linhas 219 a 233:
219:                 .Visible         = .T.
220:             ENDWITH
221: 
222:             .AddObject("cmd_4c_Visualizar", "CommandButton")
223:             WITH .cmd_4c_Visualizar
224:                 .Caption         = "Visualizar"
225:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
226:                 .PicturePosition = 13
227:                 .Top             = 5
228:                 .Left            =  542
229:                 .Width           = 75
230:                 .Height          = 75
231:                 .BackColor       = RGB(255, 255, 255)
232:                 .ForeColor       = RGB(90, 90, 90)
233:                 .FontName        = "Tahoma"

*-- Linhas 242 a 256:
242:                 .Visible         = .T.
243:             ENDWITH
244: 
245:             .AddObject("cmd_4c_Alterar", "CommandButton")
246:             WITH .cmd_4c_Alterar
247:                 .Caption         = "Alterar"
248:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
249:                 .PicturePosition = 13
250:                 .Top             = 5
251:                 .Left            =  542
252:                 .Width           = 75
253:                 .Height          = 75
254:                 .BackColor       = RGB(255, 255, 255)
255:                 .ForeColor       = RGB(90, 90, 90)
256:                 .FontName        = "Tahoma"

*-- Linhas 265 a 279:
265:                 .Visible         = .T.
266:             ENDWITH
267: 
268:             .AddObject("cmd_4c_Excluir", "CommandButton")
269:             WITH .cmd_4c_Excluir
270:                 .Caption         = "Excluir"
271:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
272:                 .PicturePosition = 13
273:                 .Top             = 5
274:                 .Left            =  542
275:                 .Width           = 75
276:                 .Height          = 75
277:                 .BackColor       = RGB(255, 255, 255)
278:                 .ForeColor       = RGB(90, 90, 90)
279:                 .FontName        = "Tahoma"

*-- Linhas 288 a 302:
288:                 .Visible         = .T.
289:             ENDWITH
290: 
291:             .AddObject("cmd_4c_Buscar", "CommandButton")
292:             WITH .cmd_4c_Buscar
293:                 .Caption         = "Buscar"
294:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
295:                 .PicturePosition = 13
296:                 .Top             = 5
297:                 .Left            =  542
298:                 .Width           = 75
299:                 .Height          = 75
300:                 .BackColor       = RGB(255, 255, 255)
301:                 .ForeColor       = RGB(90, 90, 90)
302:                 .FontName        = "Tahoma"

*-- Linhas 315 a 337:
315:         *-- Container Saida canonico (CLAUDE.md regra #10)
316:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
317:         WITH loc_oPagina.cnt_4c_Saida
318:             .Top         = 29
319:             .Left        = 917
320:             .Width       = 90
321:             .Height      = 85
322:             .BackStyle   = 0
323:             .BorderWidth = 0
324:             .Visible     = .T.
325: 
326:             .AddObject("cmd_4c_Encerrar", "CommandButton")
327:             WITH .cmd_4c_Encerrar
328:                 .Caption         = "Encerrar"
329:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
330:                 .PicturePosition = 13
331:                 .Top             = 5
332:                 .Left            = 917
333:                 .Width           = 75
334:                 .Height          = 75
335:                 .BackColor       = RGB(255, 255, 255)
336:                 .ForeColor       = RGB(90, 90, 90)
337:                 .FontName        = "Tahoma"

*-- Linhas 351 a 360:
351:         loc_oPagina.grd_4c_Lista.ColumnCount = 3
352:         loc_oPagina.grd_4c_Lista.RecordSource = ""
353:         WITH loc_oPagina.grd_4c_Lista
354:             .Top                = 150
355:             .Left               = 12
356:             .Width              = 932
357:             .Height             = 470
358:             .FontName           = "Verdana"
359:             .FontSize           = 8
360:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 372 a 395:
372:             .Visible            = .T.
373:             .Column1.Width      = 200
374:             .Column1.ReadOnly   = .T.
375:             .Column1.Header1.Caption = "Processo"
376:             .Column2.Width      = 60
377:             .Column2.ReadOnly   = .T.
378:             .Column2.Header1.Caption = "Emp"
379:             .Column3.Width      = 80
380:             .Column3.ReadOnly   = .T.
381:             .Column3.Header1.Caption = "C" + CHR(243) + "digo"
382:         ENDWITH
383: 
384:         *-- BINDEVENTs
385:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
386:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
387:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
388:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
389:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
390:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
391: 
392:         THIS.TornarControlesVisiveis(loc_oPagina)
393:     ENDPROC
394: 
395:     *==========================================================================

*-- Linhas 404 a 426:
404:         *-- Container botoes Confirmar/Cancelar
405:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
406:         WITH loc_oPagina.cnt_4c_BotoesAcao
407:             .Top         = 38
408:             .Left        = 819
409:             .Width       = 160
410:             .Height      = 85
411:             .BackStyle   = 0
412:             .BorderWidth = 0
413:             .Visible     = .T.
414: 
415:             .AddObject("cmd_4c_Confirmar", "CommandButton")
416:             WITH .cmd_4c_Confirmar
417:                 .Caption         = "Confirmar"
418:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
419:                 .PicturePosition = 13
420:                 .Top             = 5
421:                 .Left            = 5
422:                 .Width           = 75
423:                 .Height          = 75
424:                 .BackColor       = RGB(255, 255, 255)
425:                 .ForeColor       = RGB(90, 90, 90)
426:                 .FontName        = "Tahoma"

*-- Linhas 434 a 448:
434:                 .Visible         = .T.
435:             ENDWITH
436: 
437:             .AddObject("cmd_4c_Cancelar", "CommandButton")
438:             WITH .cmd_4c_Cancelar
439:                 .Caption         = "Encerrar"
440:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
441:                 .PicturePosition = 13
442:                 .Top             = 5
443:                 .Left            = 85
444:                 .Width           = 75
445:                 .Height          = 75
446:                 .BackColor       = RGB(255, 255, 255)
447:                 .ForeColor       = RGB(90, 90, 90)
448:                 .FontName        = "Tahoma"

*-- Linhas 461 a 794:
461:         *-- Shape2: box ao redor dos campos de cabecalho
462:         loc_oPagina.AddObject("shp_4c_Shape2", "Shape")
463:         WITH loc_oPagina.shp_4c_Shape2
464:             .Top           = 36
465:             .Left          = 187
466:             .Width         = 613
467:             .Height        = 110
468:             .BackStyle     = 0
469:             .SpecialEffect = 1
470:             .BorderColor   = RGB(136, 189, 188)
471:             .Visible       = .T.
472:         ENDWITH
473: 
474:         *-- Campos cabecalho - Processo
475:         loc_oPagina.AddObject("lbl_4c_Processo", "Label")
476:         WITH loc_oPagina.lbl_4c_Processo
477:             .Caption   = "Processo :"
478:             .Top       = 40
479:             .Left      = 192
480:             .FontName  = "Tahoma"
481:             .FontSize  = 8
482:             .ForeColor = RGB(90, 90, 90)
483:             .BackStyle = 0
484:             .Visible   = .T.
485:         ENDWITH
486: 
487:         loc_oPagina.AddObject("txt_4c_Processos", "TextBox")
488:         WITH loc_oPagina.txt_4c_Processos
489:             .Value         = ""
490:             .Top           = 51
491:             .Left          = 192
492:             .Width         = 150
493:             .Height        = 21
494:             .MaxLength     = 20
495:             .FontName      = "Tahoma"
496:             .FontSize      = 8
497:             .SpecialEffect = 1
498:             .Themes        = .F.
499:             .Visible       = .T.
500:         ENDWITH
501: 
502:         *-- Codigo (ReadOnly)
503:         loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
504:         WITH loc_oPagina.lbl_4c_Codigo
505:             .Caption   = "C" + CHR(243) + "digo :"
506:             .Top       = 40
507:             .Left      = 344
508:             .FontName  = "Tahoma"
509:             .FontSize  = 8
510:             .ForeColor = RGB(90, 90, 90)
511:             .BackStyle = 0
512:             .Visible   = .T.
513:         ENDWITH
514: 
515:         loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
516:         WITH loc_oPagina.txt_4c_Codigos
517:             .Value         = .F.
518:             .Top           = 51
519:             .Left          = 343
520:             .Width         = 52
521:             .Height        = 21
522:             .InputMask     = "999999"
523:             .ReadOnly      = .T.
524:             .Enabled       = .F.
525:             .SpecialEffect = 1
526:             .Themes        = .F.
527:             .Visible       = .T.
528:         ENDWITH
529: 
530:         *-- Impressora
531:         loc_oPagina.AddObject("lbl_4c_Imprimir", "Label")
532:         WITH loc_oPagina.lbl_4c_Imprimir
533:             .Caption   = "Impressora :"
534:             .Top       = 77
535:             .Left      = 361
536:             .FontName  = "Tahoma"
537:             .FontSize  = 8
538:             .ForeColor = RGB(90, 90, 90)
539:             .BackStyle = 0
540:             .Visible   = .T.
541:         ENDWITH
542: 
543:         loc_oPagina.AddObject("obj_4c_OptImprimir", "OptionGroup")
544:         WITH loc_oPagina.obj_4c_OptImprimir
545:             .Top          = 88
546:             .Left         = 361
547:             .Width        = 89
548:             .Height       = 23
549:             .ButtonCount  = 2
550:             .BackStyle    = 0
551:             .BorderStyle  = 0
552:             .Value        = 2
553:             .Visible      = .T.
554:             .Buttons(1).Caption   = "Sim"
555:             .Buttons(1).Value     = .T.
556:             .Buttons(1).Width     = 40
557:             .Buttons(1).Left      = 0
558:             .Buttons(1).Top       = 0
559:             .Buttons(1).AutoSize  = .F.
560:             .Buttons(1).ForeColor = RGB(90, 90, 90)
561:             .Buttons(1).Themes    = .F.
562:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
563:             .Buttons(2).Value     = 2
564:             .Buttons(2).Width     = 43
565:             .Buttons(2).Left      = 40
566:             .Buttons(2).Top       = 0
567:             .Buttons(2).AutoSize  = .F.
568:             .Buttons(2).ForeColor = RGB(90, 90, 90)
569:             .Buttons(2).Themes    = .F.
570:         ENDWITH
571: 
572:         *-- Ordenar por
573:         loc_oPagina.AddObject("lbl_4c_Ordenar", "Label")
574:         WITH loc_oPagina.lbl_4c_Ordenar
575:             .Caption   = "Ordenar por :"
576:             .Top       = 77
577:             .Left      = 490
578:             .FontName  = "Tahoma"
579:             .FontSize  = 8
580:             .ForeColor = RGB(90, 90, 90)
581:             .BackStyle = 0
582:             .Visible   = .T.
583:         ENDWITH
584: 
585:         loc_oPagina.AddObject("obj_4c_OptOrdems", "OptionGroup")
586:         WITH loc_oPagina.obj_4c_OptOrdems
587:             .Top          = 88
588:             .Left         = 490
589:             .Width        = 70
590:             .Height       = 23
591:             .ButtonCount  = 2
592:             .BackStyle    = 0
593:             .BorderStyle  = 0
594:             .Value        = 1
595:             .Visible      = .T.
596:             .Buttons(1).Caption   = "Op"
597:             .Buttons(1).Value     = .T.
598:             .Buttons(1).Width     = 30
599:             .Buttons(1).Left      = 0
600:             .Buttons(1).Top       = 0
601:             .Buttons(1).AutoSize  = .F.
602:             .Buttons(1).ForeColor = RGB(90, 90, 90)
603:             .Buttons(1).Themes    = .F.
604:             .Buttons(2).Caption   = "Dest"
605:             .Buttons(2).Value     = 5
606:             .Buttons(2).Width     = 38
607:             .Buttons(2).Left      = 30
608:             .Buttons(2).Top       = 0
609:             .Buttons(2).AutoSize  = .F.
610:             .Buttons(2).ForeColor = RGB(90, 90, 90)
611:             .Buttons(2).Themes    = .F.
612:         ENDWITH
613: 
614:         *-- Dados Fiscais
615:         loc_oPagina.AddObject("lbl_4c_Fiscal", "Label")
616:         WITH loc_oPagina.lbl_4c_Fiscal
617:             .Caption   = "Dados Fiscais :"
618:             .Top       = 112
619:             .Left      = 192
620:             .FontName  = "Tahoma"
621:             .FontSize  = 8
622:             .ForeColor = RGB(90, 90, 90)
623:             .BackStyle = 0
624:             .Visible   = .T.
625:         ENDWITH
626: 
627:         loc_oPagina.AddObject("obj_4c_OptFiscal", "OptionGroup")
628:         WITH loc_oPagina.obj_4c_OptFiscal
629:             .Top          = 123
630:             .Left         = 192
631:             .Width        = 81
632:             .Height       = 23
633:             .ButtonCount  = 2
634:             .BackStyle    = 0
635:             .BorderStyle  = 0
636:             .Value        = 2
637:             .Visible      = .T.
638:             .Buttons(1).Caption   = "Sim"
639:             .Buttons(1).Value     = .T.
640:             .Buttons(1).Width     = 35
641:             .Buttons(1).Left      = 0
642:             .Buttons(1).Top       = 0
643:             .Buttons(1).AutoSize  = .F.
644:             .Buttons(1).ForeColor = RGB(90, 90, 90)
645:             .Buttons(1).Themes    = .F.
646:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
647:             .Buttons(2).Value     = 2
648:             .Buttons(2).Width     = 40
649:             .Buttons(2).Left      = 35
650:             .Buttons(2).Top       = 0
651:             .Buttons(2).AutoSize  = .F.
652:             .Buttons(2).ForeColor = RGB(90, 90, 90)
653:             .Buttons(2).Themes    = .F.
654:         ENDWITH
655: 
656:         *-- Arquivos de Log
657:         loc_oPagina.AddObject("lbl_4c_Logs", "Label")
658:         WITH loc_oPagina.lbl_4c_Logs
659:             .Caption   = "Arquivos de Log :"
660:             .Top       = 112
661:             .Left      = 368
662:             .FontName  = "Tahoma"
663:             .FontSize  = 8
664:             .ForeColor = RGB(90, 90, 90)
665:             .BackStyle = 0
666:             .Visible   = .T.
667:         ENDWITH
668: 
669:         loc_oPagina.AddObject("obj_4c_OptLogs", "OptionGroup")
670:         WITH loc_oPagina.obj_4c_OptLogs
671:             .Top          = 123
672:             .Left         = 365
673:             .Width        = 90
674:             .Height       = 23
675:             .ButtonCount  = 2
676:             .BackStyle    = 0
677:             .BorderStyle  = 0
678:             .Value        = 2
679:             .Visible      = .T.
680:             .Buttons(1).Caption   = "Sim"
681:             .Buttons(1).Value     = .T.
682:             .Buttons(1).Width     = 40
683:             .Buttons(1).Left      = 0
684:             .Buttons(1).Top       = 0
685:             .Buttons(1).AutoSize  = .F.
686:             .Buttons(1).ForeColor = RGB(90, 90, 90)
687:             .Buttons(1).Themes    = .F.
688:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
689:             .Buttons(2).Value     = 2
690:             .Buttons(2).Width     = 44
691:             .Buttons(2).Left      = 40
692:             .Buttons(2).Top       = 0
693:             .Buttons(2).AutoSize  = .F.
694:             .Buttons(2).ForeColor = RGB(90, 90, 90)
695:             .Buttons(2).Themes    = .F.
696:         ENDWITH
697: 
698:         *-- Apagar Dados Origem
699:         loc_oPagina.AddObject("lbl_4c_Apagar", "Label")
700:         WITH loc_oPagina.lbl_4c_Apagar
701:             .Caption   = "Apagar Dados Origem :"
702:             .Top       = 112
703:             .Left      = 490
704:             .FontName  = "Tahoma"
705:             .FontSize  = 8
706:             .ForeColor = RGB(90, 90, 90)
707:             .BackStyle = 0
708:             .Visible   = .T.
709:         ENDWITH
710: 
711:         loc_oPagina.AddObject("obj_4c_OptApagar", "OptionGroup")
712:         WITH loc_oPagina.obj_4c_OptApagar
713:             .Top          = 122
714:             .Left         = 490
715:             .Width        = 249
716:             .Height       = 23
717:             .ButtonCount  = 4
718:             .BackStyle    = 0
719:             .BorderStyle  = 0
720:             .Value        = 1
721:             .Visible      = .T.
722:             .Buttons(1).Caption   = "Ambos"
723:             .Buttons(1).Value     = .T.
724:             .Buttons(1).Width     = 50
725:             .Buttons(1).Left      = 0
726:             .Buttons(1).Top       = 0
727:             .Buttons(1).AutoSize  = .F.
728:             .Buttons(1).ForeColor = RGB(90, 90, 90)
729:             .Buttons(1).Themes    = .F.
730:             .Buttons(2).Caption   = "S" + CHR(243) + " Dados"
731:             .Buttons(2).Value     = 2
732:             .Buttons(2).Width     = 62
733:             .Buttons(2).Left      = 50
734:             .Buttons(2).Top       = 0
735:             .Buttons(2).AutoSize  = .F.
736:             .Buttons(2).ForeColor = RGB(90, 90, 90)
737:             .Buttons(2).Themes    = .F.
738:             .Buttons(3).Caption   = "S" + CHR(243) + " Fiscais"
739:             .Buttons(3).Value     = 3
740:             .Buttons(3).Width     = 65
741:             .Buttons(3).Left      = 112
742:             .Buttons(3).Top       = 0
743:             .Buttons(3).AutoSize  = .F.
744:             .Buttons(3).ForeColor = RGB(90, 90, 90)
745:             .Buttons(3).Themes    = .F.
746:             .Buttons(4).Caption   = "Nenhum"
747:             .Buttons(4).Value     = 4
748:             .Buttons(4).Width     = 58
749:             .Buttons(4).Left      = 177
750:             .Buttons(4).Top       = 0
751:             .Buttons(4).AutoSize  = .F.
752:             .Buttons(4).ForeColor = RGB(90, 90, 90)
753:             .Buttons(4).Themes    = .F.
754:         ENDWITH
755: 
756:         *-- Container botoes insercao/exclusao de linhas (cmdgCompo)
757:         loc_oPagina.AddObject("cnt_4c_CompoOp", "Container")
758:         WITH loc_oPagina.cnt_4c_CompoOp
759:             .Top         = 36
760:             .Left        = 7
761:             .Width       = 173
762:             .Height      = 110
763:             .BackStyle   = 1
764:             .BackColor   = RGB(53, 53, 53)
765:             .BorderWidth = 0
766:             .Visible     = .T.
767: 
768:             .AddObject("cmd_4c_CompoInserir", "CommandButton")
769:             WITH .cmd_4c_CompoInserir
770:                 .Caption         = "Inserir Linha"
771:                 .Top             = 10
772:                 .Left            = 5
773:                 .Width           = 160
774:                 .Height          = 40
775:                 .BackColor       = RGB(255, 255, 255)
776:                 .ForeColor       = RGB(90, 90, 90)
777:                 .FontName        = "Tahoma"
778:                 .FontSize        = 8
779:                 .FontBold        = .T.
780:                 .SpecialEffect   = 0
781:                 .MousePointer    = 15
782:                 .Visible         = .T.
783:             ENDWITH
784: 
785:             .AddObject("cmd_4c_CompoExcluir", "CommandButton")
786:             WITH .cmd_4c_CompoExcluir
787:                 .Caption         = "Excluir Linha"
788:                 .Top             = 60
789:                 .Left            = 5
790:                 .Width           = 160
791:                 .Height          = 40
792:                 .BackColor       = RGB(255, 255, 255)
793:                 .ForeColor       = RGB(90, 90, 90)
794:                 .FontName        = "Tahoma"

*-- Linhas 803 a 812:
803:         *-- Shape1: box ao redor do grdDestinos
804:         loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
805:         WITH loc_oPagina.shp_4c_Shape1
806:             .Top           = 155
807:             .Left          = 8
808:             .Width         = 791
809:             .Height        = 263
810:             .BackStyle     = 0
811:             .SpecialEffect = 1
812:             .BorderColor   = RGB(136, 189, 188)

*-- Linhas 818 a 827:
818:         loc_oPagina.grd_4c_Destinos.ColumnCount = 18
819:         loc_oPagina.grd_4c_Destinos.RecordSource = "csDestinos"
820:         WITH loc_oPagina.grd_4c_Destinos
821:             .Top                = 162
822:             .Left               = 15
823:             .Width              = 779
824:             .Height             = 189
825:             .FontName           = "Verdana"
826:             .FontSize           = 8
827:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 841 a 970:
841:             *-- Col1: EmpDs
842:             .Column1.Width          = 40
843:             .Column1.ControlSource  = "csDestinos.EmpDs"
844:             .Column1.Header1.Caption = "Emp"
845: 
846:             *-- Col2: Drives
847:             .Column2.Width          = 80
848:             .Column2.ControlSource  = "csDestinos.Drives"
849:             .Column2.Header1.Caption = "Local"
850: 
851:             *-- Col3: DopeDs
852:             .Column3.Width          = 80
853:             .Column3.ControlSource  = "csDestinos.DopeDs"
854:             .Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o no Destino"
855: 
856:             *-- Col4: TpProdutos
857:             .Column4.Width          = 45
858:             .Column4.ControlSource  = "csDestinos.TpProdutos"
859:             .Column4.Alignment      = 2
860:             .Column4.Header1.Caption = "Produto"
861: 
862:             *-- Col5: Dias
863:             .Column5.Width          = 35
864:             .Column5.ControlSource  = "csDestinos.Dias"
865:             .Column5.Alignment      = 2
866:             .Column5.Header1.Caption = "Dias"
867: 
868:             *-- Col6: PctMins
869:             .Column6.Width          = 75
870:             .Column6.ControlSource  = "csDestinos.PctMins"
871:             .Column6.Alignment      = 2
872:             .Column6.Header1.Caption = "Margem M" + CHR(237) + "n."
873: 
874:             *-- Col7: PctMaxs
875:             .Column7.Width          = 75
876:             .Column7.ControlSource  = "csDestinos.PctMaxs"
877:             .Column7.Alignment      = 2
878:             .Column7.Header1.Caption = "Margem M" + CHR(225) + "x."
879: 
880:             *-- Col8: GdeGrupos
881:             .Column8.Width          = 40
882:             .Column8.ControlSource  = "csDestinos.GdeGrupos"
883:             .Column8.Header1.Caption = "GGpr"
884: 
885:             *-- Col9: Emps (origem)
886:             .Column9.Width          = 35
887:             .Column9.ControlSource  = "csDestinos.Emps"
888:             .Column9.Header1.Caption = "Emp"
889: 
890:             *-- Col10: Dopes (operacao origem)
891:             .Column10.Width          = 75
892:             .Column10.ControlSource  = "csDestinos.Dopes"
893:             .Column10.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o na Origem"
894: 
895:             *-- Col11: CUnis
896:             .Column11.Width          = 35
897:             .Column11.ControlSource  = "csDestinos.CUnis"
898:             .Column11.Header1.Caption = "Uni"
899: 
900:             *-- Col12: Origems
901:             .Column12.Width          = 70
902:             .Column12.ControlSource  = "csDestinos.Origems"
903:             .Column12.Header1.Caption = "Cta.Origem"
904: 
905:             *-- Col13: Destinos
906:             .Column13.Width          = 70
907:             .Column13.ControlSource  = "csDestinos.Destinos"
908:             .Column13.Header1.Caption = "Cta.Destino"
909: 
910:             *-- Col14: SemItens (CheckBox)
911:             .Column14.Width          = 55
912:             .Column14.ControlSource  = "csDestinos.SemItens"
913:             .Column14.Sparse         = .F.
914:             .Column14.Header1.Caption = "Sem " + CHR(205) + "tens"
915:             .Column14.AddObject("Check1", "CheckBox")
916:             WITH .Column14.Check1
917:                 .Alignment  = 0
918:                 .ReadOnly   = .F.
919:                 .Visible    = .T.
920:                 .Top        = 9
921:                 .Left       = 2
922:                 .Height     = 17
923:                 .Width      = 22
924:             ENDWITH
925: 
926:             *-- Col15: Fiscais (CheckBox)
927:             .Column15.Width          = 45
928:             .Column15.ControlSource  = "csDestinos.Fiscais"
929:             .Column15.Sparse         = .F.
930:             .Column15.Header1.Caption = "Fiscal"
931:             .Column15.AddObject("Check1", "CheckBox")
932:             WITH .Column15.Check1
933:                 .Alignment  = 0
934:                 .ReadOnly   = .F.
935:                 .Visible    = .T.
936:                 .Top        = 9
937:                 .Left       = 2
938:                 .Height     = 17
939:                 .Width      = 22
940:             ENDWITH
941: 
942:             *-- Col16: PctCopias
943:             .Column16.Width          = 70
944:             .Column16.ControlSource  = "csDestinos.PctCopias"
945:             .Column16.Alignment      = 2
946:             .Column16.Header1.Caption = "% Produto / $"
947: 
948:             *-- Col17: OpItens
949:             .Column17.Width          = 50
950:             .Column17.ControlSource  = "csDestinos.OpItens"
951:             .Column17.Header1.Caption = "Op Itens"
952: 
953:             *-- Col18: pctcomps
954:             .Column18.Width          = 60
955:             .Column18.ControlSource  = "csDestinos.pctcomps"
956:             .Column18.Alignment      = 2
957:             .Column18.Header1.Caption = "% Compos."
958:         ENDWITH
959: 
960:         *-- Botao copiar linha atual do grdDestinos
961:         loc_oPagina.AddObject("cmd_4c_CopOpe", "CommandButton")
962:         WITH loc_oPagina.cmd_4c_CopOpe
963:             .Caption       = "Copiar"
964:             .Top           = 325
965:             .Left          = 738
966:             .Width         = 55
967:             .Height        = 59
968:             .BackColor     = RGB(255, 255, 255)
969:             .ForeColor     = RGB(90, 90, 90)
970:             .FontName      = "Tahoma"

*-- Linhas 976 a 2256:
976:         ENDWITH
977: 
978:         *-- Labels linha GruConOs / GruConDs
979:         loc_oPagina.AddObject("chk_4c_ChkHelp", "CheckBox")
980:         WITH loc_oPagina.chk_4c_ChkHelp
981:             .Caption     = ""
982:             .Top         = 358
983:             .Left        = 24
984:             .Width       = 26
985:             .Height      = 26
986:             .BackStyle   = 0
987:             .Visible     = .T.
988:         ENDWITH
989: 
990:         loc_oPagina.AddObject("lbl_4c_Origem", "Label")
991:         WITH loc_oPagina.lbl_4c_Origem
992:             .Caption   = "Origem :"
993:             .Top       = 356
994:             .Left      = 62
995:             .FontName  = "Tahoma"
996:             .FontSize  = 8
997:             .ForeColor = RGB(90, 90, 90)
998:             .BackStyle = 0
999:             .Visible   = .T.
1000:         ENDWITH
1001: 
1002:         loc_oPagina.AddObject("obj_4c_OptGruConOs", "OptionGroup")
1003:         WITH loc_oPagina.obj_4c_OptGruConOs
1004:             .Top          = 357
1005:             .Left         = 105
1006:             .Width        = 567
1007:             .Height       = 15
1008:             .ButtonCount  = 5
1009:             .BackStyle    = 0
1010:             .BorderStyle  = 0
1011:             .Value        = 1
1012:             .Visible      = .T.
1013:             .Buttons(1).Caption   = "Produtos"
1014:             .Buttons(1).Value     = .T.
1015:             .Buttons(1).Width     = 65
1016:             .Buttons(1).Left      = 0
1017:             .Buttons(1).Top       = 0
1018:             .Buttons(1).AutoSize  = .F.
1019:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1020:             .Buttons(1).Themes    = .F.
1021:             .Buttons(2).Caption   = "Serv." + CHR(47) + "Prod."
1022:             .Buttons(2).Value     = 2
1023:             .Buttons(2).Width     = 75
1024:             .Buttons(2).Left      = 65
1025:             .Buttons(2).Top       = 0
1026:             .Buttons(2).AutoSize  = .F.
1027:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1028:             .Buttons(2).Themes    = .F.
1029:             .Buttons(3).Caption   = "Servi" + CHR(231) + "os"
1030:             .Buttons(3).Value     = 3
1031:             .Buttons(3).Width     = 65
1032:             .Buttons(3).Left      = 140
1033:             .Buttons(3).Top       = 0
1034:             .Buttons(3).AutoSize  = .F.
1035:             .Buttons(3).ForeColor = RGB(90, 90, 90)
1036:             .Buttons(3).Themes    = .F.
1037:             .Buttons(4).Caption   = "S/N.Fiscal"
1038:             .Buttons(4).Value     = 4
1039:             .Buttons(4).Width     = 75
1040:             .Buttons(4).Left      = 205
1041:             .Buttons(4).Top       = 0
1042:             .Buttons(4).AutoSize  = .F.
1043:             .Buttons(4).ForeColor = RGB(90, 90, 90)
1044:             .Buttons(4).Themes    = .F.
1045:             .Buttons(5).Caption   = "Todos"
1046:             .Buttons(5).Value     = 5
1047:             .Buttons(5).Width     = 55
1048:             .Buttons(5).Left      = 280
1049:             .Buttons(5).Top       = 0
1050:             .Buttons(5).AutoSize  = .F.
1051:             .Buttons(5).ForeColor = RGB(90, 90, 90)
1052:             .Buttons(5).Themes    = .F.
1053:         ENDWITH
1054: 
1055:         loc_oPagina.AddObject("lbl_4c_Destino", "Label")
1056:         WITH loc_oPagina.lbl_4c_Destino
1057:             .Caption   = "Destino :"
1058:             .Top       = 375
1059:             .Left      = 60
1060:             .FontName  = "Tahoma"
1061:             .FontSize  = 8
1062:             .ForeColor = RGB(90, 90, 90)
1063:             .BackStyle = 0
1064:             .Visible   = .T.
1065:         ENDWITH
1066: 
1067:         loc_oPagina.AddObject("obj_4c_OptGruConDs", "OptionGroup")
1068:         WITH loc_oPagina.obj_4c_OptGruConDs
1069:             .Top          = 374
1070:             .Left         = 106
1071:             .Width        = 519
1072:             .Height       = 18
1073:             .ButtonCount  = 4
1074:             .BackStyle    = 0
1075:             .BorderStyle  = 0
1076:             .Value        = 1
1077:             .Visible      = .T.
1078:             .Buttons(1).Caption   = "Produtos"
1079:             .Buttons(1).Value     = .T.
1080:             .Buttons(1).Width     = 65
1081:             .Buttons(1).Left      = 0
1082:             .Buttons(1).Top       = 0
1083:             .Buttons(1).AutoSize  = .F.
1084:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1085:             .Buttons(1).Themes    = .F.
1086:             .Buttons(2).Caption   = "Serv." + CHR(47) + "Prod."
1087:             .Buttons(2).Value     = 2
1088:             .Buttons(2).Width     = 75
1089:             .Buttons(2).Left      = 65
1090:             .Buttons(2).Top       = 0
1091:             .Buttons(2).AutoSize  = .F.
1092:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1093:             .Buttons(2).Themes    = .F.
1094:             .Buttons(3).Caption   = "Servi" + CHR(231) + "os"
1095:             .Buttons(3).Value     = 3
1096:             .Buttons(3).Width     = 65
1097:             .Buttons(3).Left      = 140
1098:             .Buttons(3).Top       = 0
1099:             .Buttons(3).AutoSize  = .F.
1100:             .Buttons(3).ForeColor = RGB(90, 90, 90)
1101:             .Buttons(3).Themes    = .F.
1102:             .Buttons(4).Caption   = "Todos"
1103:             .Buttons(4).Value     = 4
1104:             .Buttons(4).Width     = 55
1105:             .Buttons(4).Left      = 205
1106:             .Buttons(4).Top       = 0
1107:             .Buttons(4).AutoSize  = .F.
1108:             .Buttons(4).ForeColor = RGB(90, 90, 90)
1109:             .Buttons(4).Themes    = .F.
1110:         ENDWITH
1111: 
1112:         *-- ======= SHAPES DELIMITADORES DAS SECOES DE OPCOES =======
1113:         loc_oPagina.AddObject("shp_4c_Shape3", "Shape")
1114:         WITH loc_oPagina.shp_4c_Shape3
1115:             .Top = 427
1116:             .Left = 8
1117:             .Width = 323
1118:             .Height = 126
1119:             .BackStyle = 0
1120:             .SpecialEffect = 1
1121:             .BorderColor = RGB(136, 189, 188)
1122:             .Visible = .T.
1123:         ENDWITH
1124: 
1125:         loc_oPagina.AddObject("shp_4c_Shape4", "Shape")
1126:         WITH loc_oPagina.shp_4c_Shape4
1127:             .Top = 427
1128:             .Left = 340
1129:             .Width = 252
1130:             .Height = 127
1131:             .BackStyle = 0
1132:             .SpecialEffect = 1
1133:             .BorderColor = RGB(136, 189, 188)
1134:             .Visible = .T.
1135:         ENDWITH
1136: 
1137:         loc_oPagina.AddObject("shp_4c_Shape5", "Shape")
1138:         WITH loc_oPagina.shp_4c_Shape5
1139:             .Top = 427
1140:             .Left = 600
1141:             .Width = 252
1142:             .Height = 82
1143:             .BackStyle = 0
1144:             .SpecialEffect = 1
1145:             .BorderColor = RGB(136, 189, 188)
1146:             .Visible = .T.
1147:         ENDWITH
1148: 
1149:         loc_oPagina.AddObject("shp_4c_Shape6", "Shape")
1150:         WITH loc_oPagina.shp_4c_Shape6
1151:             .Top = 513
1152:             .Left = 600
1153:             .Width = 358
1154:             .Height = 71
1155:             .BackStyle = 0
1156:             .SpecialEffect = 1
1157:             .BorderColor = RGB(136, 189, 188)
1158:             .Visible = .T.
1159:         ENDWITH
1160: 
1161:         *-- ======= SECAO ESQUERDA (Shape3) - opcoes do item =======
1162: 
1163:         loc_oPagina.AddObject("lbl_4c_Agrupar", "Label")
1164:         WITH loc_oPagina.lbl_4c_Agrupar
1165:             .Caption = "Agrupar Itens :"
1166:             .Top = 428
1167:             .Left = 8
1168:             .FontName = "Tahoma"
1169:             .FontSize = 8
1170:             .ForeColor = RGB(90,90,90)
1171:             .BackStyle = 0
1172:             .Visible = .T.
1173:         ENDWITH
1174: 
1175:         loc_oPagina.AddObject("obj_4c_OptAgrupar", "OptionGroup")
1176:         WITH loc_oPagina.obj_4c_OptAgrupar
1177:             .Top = 427
1178:             .Left = 121
1179:             .Width = 163
1180:             .Height = 19
1181:             .ButtonCount = 3
1182:             .BackStyle = 0
1183:             .BorderStyle = 0
1184:             .Value = 1
1185:             .Visible = .T.
1186:             .Buttons(1).Caption   = "Sim"
1187:             .Buttons(1).Value     = .T.
1188:             .Buttons(1).Width     = 40
1189:             .Buttons(1).Left      = 0
1190:             .Buttons(1).Top       = 0
1191:             .Buttons(1).AutoSize  = .F.
1192:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1193:             .Buttons(1).Themes    = .F.
1194:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1195:             .Buttons(2).Value     = 2
1196:             .Buttons(2).Width     = 40
1197:             .Buttons(2).Left      = 40
1198:             .Buttons(2).Top       = 0
1199:             .Buttons(2).AutoSize  = .F.
1200:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1201:             .Buttons(2).Themes    = .F.
1202:             .Buttons(3).Caption   = "Divis" + CHR(227) + "o"
1203:             .Buttons(3).Value     = 3
1204:             .Buttons(3).Width     = 70
1205:             .Buttons(3).Left      = 80
1206:             .Buttons(3).Top       = 0
1207:             .Buttons(3).AutoSize  = .F.
1208:             .Buttons(3).ForeColor = RGB(90, 90, 90)
1209:             .Buttons(3).Themes    = .F.
1210:         ENDWITH
1211: 
1212:         loc_oPagina.AddObject("lbl_4c_Custos", "Label")
1213:         WITH loc_oPagina.lbl_4c_Custos
1214:             .Caption = "Calcular Custos :"
1215:             .Top = 446
1216:             .Left = 12
1217:             .FontName = "Tahoma"
1218:             .FontSize = 8
1219:             .ForeColor = RGB(90,90,90)
1220:             .BackStyle = 0
1221:             .Visible = .T.
1222:         ENDWITH
1223: 
1224:         loc_oPagina.AddObject("obj_4c_OptCustos", "OptionGroup")
1225:         WITH loc_oPagina.obj_4c_OptCustos
1226:             .Top = 414
1227:             .Left = 121
1228:             .Width = 80
1229:             .Height = 18
1230:             .ButtonCount = 2
1231:             .BackStyle = 0
1232:             .BorderStyle = 0
1233:             .Value = 2
1234:             .Visible = .T.
1235:             .Buttons(1).Caption   = "Sim"
1236:             .Buttons(1).Value     = .T.
1237:             .Buttons(1).Width     = 35
1238:             .Buttons(1).Left      = 0
1239:             .Buttons(1).Top       = 0
1240:             .Buttons(1).AutoSize  = .F.
1241:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1242:             .Buttons(1).Themes    = .F.
1243:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1244:             .Buttons(2).Value     = 2
1245:             .Buttons(2).Width     = 40
1246:             .Buttons(2).Left      = 35
1247:             .Buttons(2).Top       = 0
1248:             .Buttons(2).AutoSize  = .F.
1249:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1250:             .Buttons(2).Themes    = .F.
1251:         ENDWITH
1252: 
1253:         loc_oPagina.AddObject("lbl_4c_Impostos", "Label")
1254:         WITH loc_oPagina.lbl_4c_Impostos
1255:             .Caption = "Calcula Impostos :"
1256:             .Top = 462
1257:             .Left = 12
1258:             .FontName = "Tahoma"
1259:             .FontSize = 8
1260:             .ForeColor = RGB(90,90,90)
1261:             .BackStyle = 0
1262:             .Visible = .T.
1263:         ENDWITH
1264: 
1265:         loc_oPagina.AddObject("obj_4c_OptImpostos", "OptionGroup")
1266:         WITH loc_oPagina.obj_4c_OptImpostos
1267:             .Top = 429
1268:             .Left = 121
1269:             .Width = 80
1270:             .Height = 18
1271:             .ButtonCount = 2
1272:             .BackStyle = 0
1273:             .BorderStyle = 0
1274:             .Value = 2
1275:             .Visible = .T.
1276:             .Buttons(1).Caption   = "Sim"
1277:             .Buttons(1).Value     = .T.
1278:             .Buttons(1).Width     = 35
1279:             .Buttons(1).Left      = 0
1280:             .Buttons(1).Top       = 0
1281:             .Buttons(1).AutoSize  = .F.
1282:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1283:             .Buttons(1).Themes    = .F.
1284:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1285:             .Buttons(2).Value     = 2
1286:             .Buttons(2).Width     = 40
1287:             .Buttons(2).Left      = 35
1288:             .Buttons(2).Top       = 0
1289:             .Buttons(2).AutoSize  = .F.
1290:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1291:             .Buttons(2).Themes    = .F.
1292:         ENDWITH
1293: 
1294:         loc_oPagina.AddObject("lbl_4c_Imagem", "Label")
1295:         WITH loc_oPagina.lbl_4c_Imagem
1296:             .Caption = "Copia Imagem :"
1297:             .Top = 476
1298:             .Left = 12
1299:             .FontName = "Tahoma"
1300:             .FontSize = 8
1301:             .ForeColor = RGB(90,90,90)
1302:             .BackStyle = 0
1303:             .Visible = .T.
1304:         ENDWITH
1305: 
1306:         loc_oPagina.AddObject("obj_4c_OptImagem", "OptionGroup")
1307:         WITH loc_oPagina.obj_4c_OptImagem
1308:             .Top = 474
1309:             .Left = 121
1310:             .Width = 122
1311:             .Height = 19
1312:             .ButtonCount = 2
1313:             .BackStyle = 0
1314:             .BorderStyle = 0
1315:             .Value = 2
1316:             .Visible = .T.
1317:             .Buttons(1).Caption   = "Sim"
1318:             .Buttons(1).Value     = .T.
1319:             .Buttons(1).Width     = 35
1320:             .Buttons(1).Left      = 0
1321:             .Buttons(1).Top       = 0
1322:             .Buttons(1).AutoSize  = .F.
1323:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1324:             .Buttons(1).Themes    = .F.
1325:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1326:             .Buttons(2).Value     = 2
1327:             .Buttons(2).Width     = 40
1328:             .Buttons(2).Left      = 35
1329:             .Buttons(2).Top       = 0
1330:             .Buttons(2).AutoSize  = .F.
1331:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1332:             .Buttons(2).Themes    = .F.
1333:         ENDWITH
1334: 
1335:         loc_oPagina.AddObject("lbl_4c_OriCompos", "Label")
1336:         WITH loc_oPagina.lbl_4c_OriCompos
1337:             .Caption = "Componentes Origem :"
1338:             .Top = 491
1339:             .Left = 12
1340:             .FontName = "Tahoma"
1341:             .FontSize = 8
1342:             .ForeColor = RGB(90,90,90)
1343:             .BackStyle = 0
1344:             .Visible = .T.
1345:         ENDWITH
1346: 
1347:         loc_oPagina.AddObject("obj_4c_OptOriCompos", "OptionGroup")
1348:         WITH loc_oPagina.obj_4c_OptOriCompos
1349:             .Top = 489
1350:             .Left = 121
1351:             .Width = 121
1352:             .Height = 19
1353:             .ButtonCount = 2
1354:             .BackStyle = 0
1355:             .BorderStyle = 0
1356:             .Value = 1
1357:             .Visible = .T.
1358:             .Buttons(1).Caption   = "Origem"
1359:             .Buttons(1).Value     = .T.
1360:             .Buttons(1).Width     = 55
1361:             .Buttons(1).Left      = 0
1362:             .Buttons(1).Top       = 0
1363:             .Buttons(1).AutoSize  = .F.
1364:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1365:             .Buttons(1).Themes    = .F.
1366:             .Buttons(2).Caption   = "Destino"
1367:             .Buttons(2).Value     = 2
1368:             .Buttons(2).Width     = 60
1369:             .Buttons(2).Left      = 55
1370:             .Buttons(2).Top       = 0
1371:             .Buttons(2).AutoSize  = .F.
1372:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1373:             .Buttons(2).Themes    = .F.
1374:         ENDWITH
1375: 
1376:         loc_oPagina.AddObject("lbl_4c_NovoCod", "Label")
1377:         WITH loc_oPagina.lbl_4c_NovoCod
1378:             .Caption = "Novo C" + CHR(243) + "digo :"
1379:             .Top = 506
1380:             .Left = 12
1381:             .FontName = "Tahoma"
1382:             .FontSize = 8
1383:             .ForeColor = RGB(90,90,90)
1384:             .BackStyle = 0
1385:             .Visible = .T.
1386:         ENDWITH
1387: 
1388:         loc_oPagina.AddObject("obj_4c_OptNovoCodigo", "OptionGroup")
1389:         WITH loc_oPagina.obj_4c_OptNovoCodigo
1390:             .Top = 504
1391:             .Left = 121
1392:             .Width = 121
1393:             .Height = 19
1394:             .ButtonCount = 2
1395:             .BackStyle = 0
1396:             .BorderStyle = 0
1397:             .Value = 2
1398:             .Visible = .T.
1399:             .Buttons(1).Caption   = "Sim"
1400:             .Buttons(1).Value     = .T.
1401:             .Buttons(1).Width     = 35
1402:             .Buttons(1).Left      = 0
1403:             .Buttons(1).Top       = 0
1404:             .Buttons(1).AutoSize  = .F.
1405:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1406:             .Buttons(1).Themes    = .F.
1407:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1408:             .Buttons(2).Value     = 2
1409:             .Buttons(2).Width     = 40
1410:             .Buttons(2).Left      = 35
1411:             .Buttons(2).Top       = 0
1412:             .Buttons(2).AutoSize  = .F.
1413:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1414:             .Buttons(2).Themes    = .F.
1415:         ENDWITH
1416: 
1417:         loc_oPagina.AddObject("lbl_4c_CorTamanho", "Label")
1418:         WITH loc_oPagina.lbl_4c_CorTamanho
1419:             .Caption = "Copia Cor/Tam :"
1420:             .Top = 524
1421:             .Left = 12
1422:             .FontName = "Tahoma"
1423:             .FontSize = 8
1424:             .ForeColor = RGB(90,90,90)
1425:             .BackStyle = 0
1426:             .Visible = .T.
1427:         ENDWITH
1428: 
1429:         loc_oPagina.AddObject("obj_4c_OptCorTamanho", "OptionGroup")
1430:         WITH loc_oPagina.obj_4c_OptCorTamanho
1431:             .Top = 520
1432:             .Left = 121
1433:             .Width = 121
1434:             .Height = 19
1435:             .ButtonCount = 2
1436:             .BackStyle = 0
1437:             .BorderStyle = 0
1438:             .Value = 2
1439:             .Visible = .T.
1440:             .Buttons(1).Caption   = "Sim"
1441:             .Buttons(1).Value     = .T.
1442:             .Buttons(1).Width     = 35
1443:             .Buttons(1).Left      = 0
1444:             .Buttons(1).Top       = 0
1445:             .Buttons(1).AutoSize  = .F.
1446:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1447:             .Buttons(1).Themes    = .F.
1448:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1449:             .Buttons(2).Value     = 2
1450:             .Buttons(2).Width     = 40
1451:             .Buttons(2).Left      = 35
1452:             .Buttons(2).Top       = 0
1453:             .Buttons(2).AutoSize  = .F.
1454:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1455:             .Buttons(2).Themes    = .F.
1456:         ENDWITH
1457: 
1458:         loc_oPagina.AddObject("lbl_4c_MoeTrat", "Label")
1459:         WITH loc_oPagina.lbl_4c_MoeTrat
1460:             .Caption = "Tratamento Moedas :"
1461:             .Top = 539
1462:             .Left = 12
1463:             .FontName = "Tahoma"
1464:             .FontSize = 8
1465:             .ForeColor = RGB(90,90,90)
1466:             .BackStyle = 0
1467:             .Visible = .T.
1468:         ENDWITH
1469: 
1470:         loc_oPagina.AddObject("obj_4c_OptMoevals", "OptionGroup")
1471:         WITH loc_oPagina.obj_4c_OptMoevals
1472:             .Top = 532
1473:             .Left = 121
1474:             .Width = 193
1475:             .Height = 24
1476:             .ButtonCount = 3
1477:             .BackStyle = 0
1478:             .BorderStyle = 0
1479:             .Value = 1
1480:             .Visible = .T.
1481:             .Buttons(1).Caption   = "Sim"
1482:             .Buttons(1).Value     = .T.
1483:             .Buttons(1).Width     = 35
1484:             .Buttons(1).Left      = 0
1485:             .Buttons(1).Top       = 0
1486:             .Buttons(1).AutoSize  = .F.
1487:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1488:             .Buttons(1).Themes    = .F.
1489:             .Buttons(2).Caption   = "Divis" + CHR(227) + "o"
1490:             .Buttons(2).Value     = 3
1491:             .Buttons(2).Width     = 60
1492:             .Buttons(2).Left      = 35
1493:             .Buttons(2).Top       = 0
1494:             .Buttons(2).AutoSize  = .F.
1495:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1496:             .Buttons(2).Themes    = .F.
1497:             .Buttons(3).Caption   = "N" + CHR(227) + "o"
1498:             .Buttons(3).Value     = 2
1499:             .Buttons(3).Width     = 40
1500:             .Buttons(3).Left      = 95
1501:             .Buttons(3).Top       = 0
1502:             .Buttons(3).AutoSize  = .F.
1503:             .Buttons(3).ForeColor = RGB(90, 90, 90)
1504:             .Buttons(3).Themes    = .F.
1505:         ENDWITH
1506: 
1507:         *-- ======= SECAO MEIO (Shape4) - Empresa destino + outros =======
1508: 
1509:         loc_oPagina.AddObject("lbl_4c_EmpDests", "Label")
1510:         WITH loc_oPagina.lbl_4c_EmpDests
1511:             .Caption = "Empresa Destino :"
1512:             .Top = 428
1513:             .Left = 352
1514:             .FontName = "Tahoma"
1515:             .FontSize = 8
1516:             .ForeColor = RGB(90,90,90)
1517:             .BackStyle = 0
1518:             .Visible = .T.
1519:         ENDWITH
1520: 
1521:         loc_oPagina.AddObject("obj_4c_OptEmpDests", "OptionGroup")
1522:         WITH loc_oPagina.obj_4c_OptEmpDests
1523:             .Top = 364
1524:             .Left = 102
1525:             .Width = 130
1526:             .Height = 19
1527:             .ButtonCount = 3
1528:             .BackStyle = 0
1529:             .BorderStyle = 0
1530:             .Value = 1
1531:             .Visible = .T.
1532:             .Buttons(1).Caption   = "Igual"
1533:             .Buttons(1).Value     = .T.
1534:             .Buttons(1).Width     = 42
1535:             .Buttons(1).Left      = 0
1536:             .Buttons(1).Top       = 0
1537:             .Buttons(1).AutoSize  = .F.
1538:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1539:             .Buttons(1).Themes    = .F.
1540:             .Buttons(2).Caption   = "Drive"
1541:             .Buttons(2).Value     = 2
1542:             .Buttons(2).Width     = 42
1543:             .Buttons(2).Left      = 42
1544:             .Buttons(2).Top       = 0
1545:             .Buttons(2).AutoSize  = .F.
1546:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1547:             .Buttons(2).Themes    = .F.
1548:             .Buttons(3).Caption   = "Config."
1549:             .Buttons(3).Value     = 3
1550:             .Buttons(3).Width     = 46
1551:             .Buttons(3).Left      = 84
1552:             .Buttons(3).Top       = 0
1553:             .Buttons(3).AutoSize  = .F.
1554:             .Buttons(3).ForeColor = RGB(90, 90, 90)
1555:             .Buttons(3).Themes    = .F.
1556:         ENDWITH
1557: 
1558:         loc_oPagina.AddObject("lbl_4c_Franquia", "Label")
1559:         WITH loc_oPagina.lbl_4c_Franquia
1560:             .Caption = "Franquias :"
1561:             .Top = 429
1562:             .Left = 350
1563:             .FontName = "Tahoma"
1564:             .FontSize = 8
1565:             .ForeColor = RGB(90,90,90)
1566:             .BackStyle = 0
1567:             .Visible = .T.
1568:         ENDWITH
1569: 
1570:         loc_oPagina.AddObject("obj_4c_OptFranquia", "OptionGroup")
1571:         WITH loc_oPagina.obj_4c_OptFranquia
1572:             .Top = 427
1573:             .Left = 494
1574:             .Width = 86
1575:             .Height = 18
1576:             .ButtonCount = 2
1577:             .BackStyle = 0
1578:             .BorderStyle = 0
1579:             .Value = 2
1580:             .Visible = .T.
1581:             .Buttons(1).Caption   = "Sim"
1582:             .Buttons(1).Value     = .T.
1583:             .Buttons(1).Width     = 35
1584:             .Buttons(1).Left      = 0
1585:             .Buttons(1).Top       = 0
1586:             .Buttons(1).AutoSize  = .F.
1587:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1588:             .Buttons(1).Themes    = .F.
1589:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1590:             .Buttons(2).Value     = 2
1591:             .Buttons(2).Width     = 40
1592:             .Buttons(2).Left      = 35
1593:             .Buttons(2).Top       = 0
1594:             .Buttons(2).AutoSize  = .F.
1595:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1596:             .Buttons(2).Themes    = .F.
1597:         ENDWITH
1598: 
1599:         loc_oPagina.AddObject("lbl_4c_MontaObs", "Label")
1600:         WITH loc_oPagina.lbl_4c_MontaObs
1601:             .Caption = "Nota+Data na Obs do" + CHR(205) + "tem :"
1602:             .Top = 476
1603:             .Left = 350
1604:             .FontName = "Tahoma"
1605:             .FontSize = 8
1606:             .ForeColor = RGB(90,90,90)
1607:             .BackStyle = 0
1608:             .Visible = .T.
1609:         ENDWITH
1610: 
1611:         loc_oPagina.AddObject("obj_4c_OptMontaObs", "OptionGroup")
1612:         WITH loc_oPagina.obj_4c_OptMontaObs
1613:             .Top = 475
1614:             .Left = 494
1615:             .Width = 87
1616:             .Height = 18
1617:             .ButtonCount = 2
1618:             .BackStyle = 0
1619:             .BorderStyle = 0
1620:             .Value = 2
1621:             .Visible = .T.
1622:             .Buttons(1).Caption   = "Sim"
1623:             .Buttons(1).Value     = .T.
1624:             .Buttons(1).Width     = 35
1625:             .Buttons(1).Left      = 0
1626:             .Buttons(1).Top       = 0
1627:             .Buttons(1).AutoSize  = .F.
1628:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1629:             .Buttons(1).Themes    = .F.
1630:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1631:             .Buttons(2).Value     = 2
1632:             .Buttons(2).Width     = 40
1633:             .Buttons(2).Left      = 35
1634:             .Buttons(2).Top       = 0
1635:             .Buttons(2).AutoSize  = .F.
1636:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1637:             .Buttons(2).Themes    = .F.
1638:         ENDWITH
1639: 
1640:         loc_oPagina.AddObject("lbl_4c_Barras", "Label")
1641:         WITH loc_oPagina.lbl_4c_Barras
1642:             .Caption = "C" + CHR(243) + "d.Barras :"
1643:             .Top = 492
1644:             .Left = 352
1645:             .FontName = "Tahoma"
1646:             .FontSize = 8
1647:             .ForeColor = RGB(90,90,90)
1648:             .BackStyle = 0
1649:             .Visible = .T.
1650:         ENDWITH
1651: 
1652:         loc_oPagina.AddObject("obj_4c_OptBarras", "OptionGroup")
1653:         WITH loc_oPagina.obj_4c_OptBarras
1654:             .Top = 491
1655:             .Left = 656
1656:             .Width = 80
1657:             .Height = 18
1658:             .ButtonCount = 2
1659:             .BackStyle = 0
1660:             .BorderStyle = 0
1661:             .Value = 2
1662:             .Visible = .T.
1663:             .Buttons(1).Caption   = "Sim"
1664:             .Buttons(1).Value     = .T.
1665:             .Buttons(1).Width     = 35
1666:             .Buttons(1).Left      = 0
1667:             .Buttons(1).Top       = 0
1668:             .Buttons(1).AutoSize  = .F.
1669:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1670:             .Buttons(1).Themes    = .F.
1671:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1672:             .Buttons(2).Value     = 2
1673:             .Buttons(2).Width     = 40
1674:             .Buttons(2).Left      = 35
1675:             .Buttons(2).Top       = 0
1676:             .Buttons(2).AutoSize  = .F.
1677:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1678:             .Buttons(2).Themes    = .F.
1679:         ENDWITH
1680: 
1681:         loc_oPagina.AddObject("lbl_4c_DesItens", "Label")
1682:         WITH loc_oPagina.lbl_4c_DesItens
1683:             .Caption = "Descri" + CHR(231) + CHR(227) + "o do" + CHR(205) + "tem :"
1684:             .Top = 509
1685:             .Left = 350
1686:             .FontName = "Tahoma"
1687:             .FontSize = 8
1688:             .ForeColor = RGB(90,90,90)
1689:             .BackStyle = 0
1690:             .Visible = .T.
1691:         ENDWITH
1692: 
1693:         loc_oPagina.AddObject("obj_4c_OptDesItens", "OptionGroup")
1694:         WITH loc_oPagina.obj_4c_OptDesItens
1695:             .Top = 431
1696:             .Left = 494
1697:             .Width = 80
1698:             .Height = 18
1699:             .ButtonCount = 2
1700:             .BackStyle = 0
1701:             .BorderStyle = 0
1702:             .Value = 2
1703:             .Visible = .T.
1704:             .Buttons(1).Caption   = "Sim"
1705:             .Buttons(1).Value     = .T.
1706:             .Buttons(1).Width     = 35
1707:             .Buttons(1).Left      = 0
1708:             .Buttons(1).Top       = 0
1709:             .Buttons(1).AutoSize  = .F.
1710:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1711:             .Buttons(1).Themes    = .F.
1712:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1713:             .Buttons(2).Value     = 2
1714:             .Buttons(2).Width     = 40
1715:             .Buttons(2).Left      = 35
1716:             .Buttons(2).Top       = 0
1717:             .Buttons(2).AutoSize  = .F.
1718:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1719:             .Buttons(2).Themes    = .F.
1720:         ENDWITH
1721: 
1722:         loc_oPagina.AddObject("lbl_4c_Globaliza", "Label")
1723:         WITH loc_oPagina.lbl_4c_Globaliza
1724:             .Caption = "Globaliza :"
1725:             .Top = 528
1726:             .Left = 359
1727:             .FontName = "Tahoma"
1728:             .FontSize = 8
1729:             .ForeColor = RGB(90,90,90)
1730:             .BackStyle = 0
1731:             .Visible = .T.
1732:         ENDWITH
1733: 
1734:         loc_oPagina.AddObject("obj_4c_OptGlobaliza", "OptionGroup")
1735:         WITH loc_oPagina.obj_4c_OptGlobaliza
1736:             .Top = 526
1737:             .Left = 656
1738:             .Width = 80
1739:             .Height = 18
1740:             .ButtonCount = 2
1741:             .BackStyle = 0
1742:             .BorderStyle = 0
1743:             .Value = 2
1744:             .Visible = .T.
1745:             .Buttons(1).Caption   = "Sim"
1746:             .Buttons(1).Value     = .T.
1747:             .Buttons(1).Width     = 35
1748:             .Buttons(1).Left      = 0
1749:             .Buttons(1).Top       = 0
1750:             .Buttons(1).AutoSize  = .F.
1751:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1752:             .Buttons(1).Themes    = .F.
1753:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1754:             .Buttons(2).Value     = 2
1755:             .Buttons(2).Width     = 40
1756:             .Buttons(2).Left      = 35
1757:             .Buttons(2).Top       = 0
1758:             .Buttons(2).AutoSize  = .F.
1759:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1760:             .Buttons(2).Themes    = .F.
1761:         ENDWITH
1762: 
1763:         loc_oPagina.AddObject("lbl_4c_ChkCons", "Label")
1764:         WITH loc_oPagina.lbl_4c_ChkCons
1765:             .Caption = "Chk. Conserto :"
1766:             .Top = 546
1767:             .Left = 351
1768:             .FontName = "Tahoma"
1769:             .FontSize = 8
1770:             .ForeColor = RGB(90,90,90)
1771:             .BackStyle = 0
1772:             .Visible = .T.
1773:         ENDWITH
1774: 
1775:         loc_oPagina.AddObject("obj_4c_OptChkCons", "OptionGroup")
1776:         WITH loc_oPagina.obj_4c_OptChkCons
1777:             .Top = 461
1778:             .Left = 494
1779:             .Width = 80
1780:             .Height = 18
1781:             .ButtonCount = 2
1782:             .BackStyle = 0
1783:             .BorderStyle = 0
1784:             .Value = 2
1785:             .Visible = .T.
1786:             .Buttons(1).Caption   = "Sim"
1787:             .Buttons(1).Value     = .T.
1788:             .Buttons(1).Width     = 35
1789:             .Buttons(1).Left      = 0
1790:             .Buttons(1).Top       = 0
1791:             .Buttons(1).AutoSize  = .F.
1792:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1793:             .Buttons(1).Themes    = .F.
1794:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1795:             .Buttons(2).Value     = 2
1796:             .Buttons(2).Width     = 40
1797:             .Buttons(2).Left      = 35
1798:             .Buttons(2).Top       = 0
1799:             .Buttons(2).AutoSize  = .F.
1800:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1801:             .Buttons(2).Themes    = .F.
1802:         ENDWITH
1803: 
1804:         *-- ======= SECAO DIREITA AREA 1 (Shape5) =======
1805: 
1806:         loc_oPagina.AddObject("lbl_4c_Mccrs", "Label")
1807:         WITH loc_oPagina.lbl_4c_Mccrs
1808:             .Caption = "Copiar Mov.de Cc. :"
1809:             .Top = 432
1810:             .Left = 624
1811:             .FontName = "Tahoma"
1812:             .FontSize = 8
1813:             .ForeColor = RGB(90,90,90)
1814:             .BackStyle = 0
1815:             .Visible = .T.
1816:         ENDWITH
1817: 
1818:         loc_oPagina.AddObject("obj_4c_OptMccrs", "OptionGroup")
1819:         WITH loc_oPagina.obj_4c_OptMccrs
1820:             .Top = 432
1821:             .Left = 750
1822:             .Width = 87
1823:             .Height = 18
1824:             .ButtonCount = 2
1825:             .BackStyle = 0
1826:             .BorderStyle = 0
1827:             .Value = 2
1828:             .Visible = .T.
1829:             .Buttons(1).Caption   = "Sim"
1830:             .Buttons(1).Value     = .T.
1831:             .Buttons(1).Width     = 35
1832:             .Buttons(1).Left      = 0
1833:             .Buttons(1).Top       = 0
1834:             .Buttons(1).AutoSize  = .F.
1835:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1836:             .Buttons(1).Themes    = .F.
1837:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1838:             .Buttons(2).Value     = 2
1839:             .Buttons(2).Width     = 40
1840:             .Buttons(2).Left      = 35
1841:             .Buttons(2).Top       = 0
1842:             .Buttons(2).AutoSize  = .F.
1843:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1844:             .Buttons(2).Themes    = .F.
1845:         ENDWITH
1846: 
1847:         loc_oPagina.AddObject("lbl_4c_Cheques", "Label")
1848:         WITH loc_oPagina.lbl_4c_Cheques
1849:             .Caption = "Copiar Mov.de Cheques :"
1850:             .Top = 447
1851:             .Left = 624
1852:             .FontName = "Tahoma"
1853:             .FontSize = 8
1854:             .ForeColor = RGB(90,90,90)
1855:             .BackStyle = 0
1856:             .Visible = .T.
1857:         ENDWITH
1858: 
1859:         loc_oPagina.AddObject("obj_4c_OptCheques", "OptionGroup")
1860:         WITH loc_oPagina.obj_4c_OptCheques
1861:             .Top = 447
1862:             .Left = 750
1863:             .Width = 87
1864:             .Height = 18
1865:             .ButtonCount = 2
1866:             .BackStyle = 0
1867:             .BorderStyle = 0
1868:             .Value = 2
1869:             .Visible = .T.
1870:             .Buttons(1).Caption   = "Sim"
1871:             .Buttons(1).Value     = .T.
1872:             .Buttons(1).Width     = 35
1873:             .Buttons(1).Left      = 0
1874:             .Buttons(1).Top       = 0
1875:             .Buttons(1).AutoSize  = .F.
1876:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1877:             .Buttons(1).Themes    = .F.
1878:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1879:             .Buttons(2).Value     = 2
1880:             .Buttons(2).Width     = 40
1881:             .Buttons(2).Left      = 35
1882:             .Buttons(2).Top       = 0
1883:             .Buttons(2).AutoSize  = .F.
1884:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1885:             .Buttons(2).Themes    = .F.
1886:         ENDWITH
1887: 
1888:         loc_oPagina.AddObject("lbl_4c_Recalculos", "Label")
1889:         WITH loc_oPagina.lbl_4c_Recalculos
1890:             .Caption = "Recalcular Saldos/Custos :"
1891:             .Top = 462
1892:             .Left = 613
1893:             .FontName = "Tahoma"
1894:             .FontSize = 8
1895:             .ForeColor = RGB(90,90,90)
1896:             .BackStyle = 0
1897:             .Visible = .T.
1898:         ENDWITH
1899: 
1900:         loc_oPagina.AddObject("obj_4c_OptRecalculos", "OptionGroup")
1901:         WITH loc_oPagina.obj_4c_OptRecalculos
1902:             .Top = 462
1903:             .Left = 750
1904:             .Width = 87
1905:             .Height = 18
1906:             .ButtonCount = 2
1907:             .BackStyle = 0
1908:             .BorderStyle = 0
1909:             .Value = 2
1910:             .Visible = .T.
1911:             .Buttons(1).Caption   = "Sim"
1912:             .Buttons(1).Value     = .T.
1913:             .Buttons(1).Width     = 35
1914:             .Buttons(1).Left      = 0
1915:             .Buttons(1).Top       = 0
1916:             .Buttons(1).AutoSize  = .F.
1917:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1918:             .Buttons(1).Themes    = .F.
1919:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1920:             .Buttons(2).Value     = 2
1921:             .Buttons(2).Width     = 40
1922:             .Buttons(2).Left      = 35
1923:             .Buttons(2).Top       = 0
1924:             .Buttons(2).AutoSize  = .F.
1925:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1926:             .Buttons(2).Themes    = .F.
1927:         ENDWITH
1928: 
1929:         loc_oPagina.AddObject("lbl_4c_MantProds", "Label")
1930:         WITH loc_oPagina.lbl_4c_MantProds
1931:             .Caption = "Mantem Prods. Destino :"
1932:             .Top = 477
1933:             .Left = 617
1934:             .FontName = "Tahoma"
1935:             .FontSize = 8
1936:             .ForeColor = RGB(90,90,90)
1937:             .BackStyle = 0
1938:             .Visible = .T.
1939:         ENDWITH
1940: 
1941:         loc_oPagina.AddObject("obj_4c_OptMantProds", "OptionGroup")
1942:         WITH loc_oPagina.obj_4c_OptMantProds
1943:             .Top = 476
1944:             .Left = 750
1945:             .Width = 87
1946:             .Height = 18
1947:             .ButtonCount = 2
1948:             .BackStyle = 0
1949:             .BorderStyle = 0
1950:             .Value = 2
1951:             .Visible = .T.
1952:             .Buttons(1).Caption   = "Sim"
1953:             .Buttons(1).Value     = .T.
1954:             .Buttons(1).Width     = 35
1955:             .Buttons(1).Left      = 0
1956:             .Buttons(1).Top       = 0
1957:             .Buttons(1).AutoSize  = .F.
1958:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1959:             .Buttons(1).Themes    = .F.
1960:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1961:             .Buttons(2).Value     = 2
1962:             .Buttons(2).Width     = 40
1963:             .Buttons(2).Left      = 35
1964:             .Buttons(2).Top       = 0
1965:             .Buttons(2).AutoSize  = .F.
1966:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1967:             .Buttons(2).Themes    = .F.
1968:         ENDWITH
1969: 
1970:         loc_oPagina.AddObject("lbl_4c_MantemMats", "Label")
1971:         WITH loc_oPagina.lbl_4c_MantemMats
1972:             .Caption = "Mantem Mat. Prima :"
1973:             .Top = 492
1974:             .Left = 623
1975:             .FontName = "Tahoma"
1976:             .FontSize = 8
1977:             .ForeColor = RGB(90,90,90)
1978:             .BackStyle = 0
1979:             .Visible = .T.
1980:         ENDWITH
1981: 
1982:         loc_oPagina.AddObject("obj_4c_OptMantemMats", "OptionGroup")
1983:         WITH loc_oPagina.obj_4c_OptMantemMats
1984:             .Top = 491
1985:             .Left = 494
1986:             .Width = 87
1987:             .Height = 18
1988:             .ButtonCount = 2
1989:             .BackStyle = 0
1990:             .BorderStyle = 0
1991:             .Value = 2
1992:             .Visible = .T.
1993:             .Buttons(1).Caption   = "Sim"
1994:             .Buttons(1).Value     = .T.
1995:             .Buttons(1).Width     = 35
1996:             .Buttons(1).Left      = 0
1997:             .Buttons(1).Top       = 0
1998:             .Buttons(1).AutoSize  = .F.
1999:             .Buttons(1).ForeColor = RGB(90, 90, 90)
2000:             .Buttons(1).Themes    = .F.
2001:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2002:             .Buttons(2).Value     = 2
2003:             .Buttons(2).Width     = 40
2004:             .Buttons(2).Left      = 35
2005:             .Buttons(2).Top       = 0
2006:             .Buttons(2).AutoSize  = .F.
2007:             .Buttons(2).ForeColor = RGB(90, 90, 90)
2008:             .Buttons(2).Themes    = .F.
2009:         ENDWITH
2010: 
2011:         loc_oPagina.AddObject("lbl_4c_MantDPros", "Label")
2012:         WITH loc_oPagina.lbl_4c_MantDPros
2013:             .Caption = "Mantem Desc. Produto :"
2014:             .Top = 507
2015:             .Left = 615
2016:             .FontName = "Tahoma"
2017:             .FontSize = 8
2018:             .ForeColor = RGB(90,90,90)
2019:             .BackStyle = 0
2020:             .Visible = .T.
2021:         ENDWITH
2022: 
2023:         loc_oPagina.AddObject("obj_4c_OptMantDPros", "OptionGroup")
2024:         WITH loc_oPagina.obj_4c_OptMantDPros
2025:             .Top = 462
2026:             .Left = 750
2027:             .Width = 87
2028:             .Height = 18
2029:             .ButtonCount = 2
2030:             .BackStyle = 0
2031:             .BorderStyle = 0
2032:             .Value = 2
2033:             .Visible = .T.
2034:             .Buttons(1).Caption   = "Sim"
2035:             .Buttons(1).Value     = .T.
2036:             .Buttons(1).Width     = 35
2037:             .Buttons(1).Left      = 0
2038:             .Buttons(1).Top       = 0
2039:             .Buttons(1).AutoSize  = .F.
2040:             .Buttons(1).ForeColor = RGB(90, 90, 90)
2041:             .Buttons(1).Themes    = .F.
2042:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2043:             .Buttons(2).Value     = 2
2044:             .Buttons(2).Width     = 40
2045:             .Buttons(2).Left      = 35
2046:             .Buttons(2).Top       = 0
2047:             .Buttons(2).AutoSize  = .F.
2048:             .Buttons(2).ForeColor = RGB(90, 90, 90)
2049:             .Buttons(2).Themes    = .F.
2050:         ENDWITH
2051: 
2052:         *-- ======= SECAO DIREITA AREA 2 (Shape6) =======
2053: 
2054:         loc_oPagina.AddObject("lbl_4c_Situacao", "Label")
2055:         WITH loc_oPagina.lbl_4c_Situacao
2056:             .Caption = "Situa" + CHR(231) + CHR(227) + "o :"
2057:             .Top = 518
2058:             .Left = 606
2059:             .FontName = "Tahoma"
2060:             .FontSize = 8
2061:             .ForeColor = RGB(90,90,90)
2062:             .BackStyle = 0
2063:             .Visible = .T.
2064:         ENDWITH
2065: 
2066:         loc_oPagina.AddObject("obj_4c_OptSituas", "OptionGroup")
2067:         WITH loc_oPagina.obj_4c_OptSituas
2068:             .Top = 516
2069:             .Left = 660
2070:             .Width = 130
2071:             .Height = 18
2072:             .ButtonCount = 3
2073:             .BackStyle = 0
2074:             .BorderStyle = 0
2075:             .Value = 1
2076:             .Visible = .T.
2077:             .Buttons(1).Caption   = "Igual"
2078:             .Buttons(1).Value     = .T.
2079:             .Buttons(1).Width     = 40
2080:             .Buttons(1).Left      = 0
2081:             .Buttons(1).Top       = 0
2082:             .Buttons(1).AutoSize  = .F.
2083:             .Buttons(1).ForeColor = RGB(90, 90, 90)
2084:             .Buttons(1).Themes    = .F.
2085:             .Buttons(2).Caption   = "Aberto"
2086:             .Buttons(2).Value     = 2
2087:             .Buttons(2).Width     = 50
2088:             .Buttons(2).Left      = 40
2089:             .Buttons(2).Top       = 0
2090:             .Buttons(2).AutoSize  = .F.
2091:             .Buttons(2).ForeColor = RGB(90, 90, 90)
2092:             .Buttons(2).Themes    = .F.
2093:             .Buttons(3).Caption   = "Fech."
2094:             .Buttons(3).Value     = 3
2095:             .Buttons(3).Width     = 40
2096:             .Buttons(3).Left      = 90
2097:             .Buttons(3).Top       = 0
2098:             .Buttons(3).AutoSize  = .F.
2099:             .Buttons(3).ForeColor = RGB(90, 90, 90)
2100:             .Buttons(3).Themes    = .F.
2101:         ENDWITH
2102: 
2103:         loc_oPagina.AddObject("lbl_4c_Delets", "Label")
2104:         WITH loc_oPagina.lbl_4c_Delets
2105:             .Caption = "Deletar Mov. :"
2106:             .Top = 536
2107:             .Left = 615
2108:             .FontName = "Tahoma"
2109:             .FontSize = 8
2110:             .ForeColor = RGB(90,90,90)
2111:             .BackStyle = 0
2112:             .Visible = .T.
2113:         ENDWITH
2114: 
2115:         loc_oPagina.AddObject("obj_4c_OptDelets", "OptionGroup")
2116:         WITH loc_oPagina.obj_4c_OptDelets
2117:             .Top = 416
2118:             .Left = 494
2119:             .Width = 110
2120:             .Height = 18
2121:             .ButtonCount = 3
2122:             .BackStyle = 0
2123:             .BorderStyle = 0
2124:             .Value = 1
2125:             .Visible = .T.
2126:             .Buttons(1).Caption   = "N" + CHR(227) + "o"
2127:             .Buttons(1).Value     = .T.
2128:             .Buttons(1).Width     = 35
2129:             .Buttons(1).Left      = 0
2130:             .Buttons(1).Top       = 0
2131:             .Buttons(1).AutoSize  = .F.
2132:             .Buttons(1).ForeColor = RGB(90, 90, 90)
2133:             .Buttons(1).Themes    = .F.
2134:             .Buttons(2).Caption   = "Sim"
2135:             .Buttons(2).Value     = 2
2136:             .Buttons(2).Width     = 35
2137:             .Buttons(2).Left      = 35
2138:             .Buttons(2).Top       = 0
2139:             .Buttons(2).AutoSize  = .F.
2140:             .Buttons(2).ForeColor = RGB(90, 90, 90)
2141:             .Buttons(2).Themes    = .F.
2142:             .Buttons(3).Caption   = "Dest."
2143:             .Buttons(3).Value     = 3
2144:             .Buttons(3).Width     = 40
2145:             .Buttons(3).Left      = 70
2146:             .Buttons(3).Top       = 0
2147:             .Buttons(3).AutoSize  = .F.
2148:             .Buttons(3).ForeColor = RGB(90, 90, 90)
2149:             .Buttons(3).Themes    = .F.
2150:         ENDWITH
2151: 
2152:         loc_oPagina.AddObject("lbl_4c_MovMZeros", "Label")
2153:         WITH loc_oPagina.lbl_4c_MovMZeros
2154:             .Caption = "Mv c/ Qt/Val > 0 :"
2155:             .Top = 554
2156:             .Left = 614
2157:             .FontName = "Tahoma"
2158:             .FontSize = 8
2159:             .ForeColor = RGB(90,90,90)
2160:             .BackStyle = 0
2161:             .Visible = .T.
2162:         ENDWITH
2163: 
2164:         loc_oPagina.AddObject("obj_4c_OptMovMZeros", "OptionGroup")
2165:         WITH loc_oPagina.obj_4c_OptMovMZeros
2166:             .Top = 491
2167:             .Left = 494
2168:             .Width = 80
2169:             .Height = 18
2170:             .ButtonCount = 2
2171:             .BackStyle = 0
2172:             .BorderStyle = 0
2173:             .Value = 2
2174:             .Visible = .T.
2175:             .Buttons(1).Caption   = "Sim"
2176:             .Buttons(1).Value     = .T.
2177:             .Buttons(1).Width     = 35
2178:             .Buttons(1).Left      = 0
2179:             .Buttons(1).Top       = 0
2180:             .Buttons(1).AutoSize  = .F.
2181:             .Buttons(1).ForeColor = RGB(90, 90, 90)
2182:             .Buttons(1).Themes    = .F.
2183:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2184:             .Buttons(2).Value     = 2
2185:             .Buttons(2).Width     = 40
2186:             .Buttons(2).Left      = 35
2187:             .Buttons(2).Top       = 0
2188:             .Buttons(2).AutoSize  = .F.
2189:             .Buttons(2).ForeColor = RGB(90, 90, 90)
2190:             .Buttons(2).Themes    = .F.
2191:         ENDWITH
2192: 
2193:         loc_oPagina.AddObject("lbl_4c_MovcParc", "Label")
2194:         WITH loc_oPagina.lbl_4c_MovcParc
2195:             .Caption = "Mv c/ Parcelas :"
2196:             .Top = 569
2197:             .Left = 616
2198:             .FontName = "Tahoma"
2199:             .FontSize = 8
2200:             .ForeColor = RGB(90,90,90)
2201:             .BackStyle = 0
2202:             .Visible = .T.
2203:         ENDWITH
2204: 
2205:         loc_oPagina.AddObject("obj_4c_OptMovcParc", "OptionGroup")
2206:         WITH loc_oPagina.obj_4c_OptMovcParc
2207:             .Top = 506
2208:             .Left = 494
2209:             .Width = 80
2210:             .Height = 18
2211:             .ButtonCount = 2
2212:             .BackStyle = 0
2213:             .BorderStyle = 0
2214:             .Value = 2
2215:             .Visible = .T.
2216:             .Buttons(1).Caption   = "Sim"
2217:             .Buttons(1).Value     = .T.
2218:             .Buttons(1).Width     = 35
2219:             .Buttons(1).Left      = 0
2220:             .Buttons(1).Top       = 0
2221:             .Buttons(1).AutoSize  = .F.
2222:             .Buttons(1).ForeColor = RGB(90, 90, 90)
2223:             .Buttons(1).Themes    = .F.
2224:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2225:             .Buttons(2).Value     = 2
2226:             .Buttons(2).Width     = 40
2227:             .Buttons(2).Left      = 35
2228:             .Buttons(2).Top       = 0
2229:             .Buttons(2).AutoSize  = .F.
2230:             .Buttons(2).ForeColor = RGB(90, 90, 90)
2231:             .Buttons(2).Themes    = .F.
2232:         ENDWITH
2233: 
2234:         *-- ======= TOLERANCIAS =======
2235:         loc_oPagina.AddObject("lbl_4c_Tolerancia", "Label")
2236:         WITH loc_oPagina.lbl_4c_Tolerancia
2237:             .Caption = "Toler" + CHR(226) + "ncias (%) :"
2238:             .Top     = 556
2239:             .Left    = 8
2240:             .FontName  = "Tahoma"
2241:             .FontSize  = 8
2242:             .ForeColor = RGB(90, 90, 90)
2243:             .BackStyle = 0
2244:             .Visible   = .T.
2245:         ENDWITH
2246: 
2247:         loc_oPagina.AddObject("txt_4c_Toleras", "TextBox")
2248:         WITH loc_oPagina.txt_4c_Toleras
2249:             .Value         = .F.
2250:             .Top           = 554
2251:             .Left          = 90
2252:             .Width         = 80
2253:             .Height        = 21
2254:             .InputMask     = "999999999.99"
2255:             .Alignment     = 2
2256:             .FontName      = "Tahoma"

*-- Linhas 2263 a 2301:
2263:         *-- ======= GRID grd_4c_DestinoG (grupos do item selecionado) =======
2264:         loc_oPagina.AddObject("cnt_4c_CompoG", "Container")
2265:         WITH loc_oPagina.cnt_4c_CompoG
2266:             .Top         = 394
2267:             .Left        = 800
2268:             .Width       = 180
2269:             .Height      = 85
2270:             .BackStyle   = 1
2271:             .BackColor   = RGB(53, 53, 53)
2272:             .BorderWidth = 0
2273:             .Visible     = .T.
2274: 
2275:             .AddObject("cmd_4c_GrpInserir", "CommandButton")
2276:             WITH .cmd_4c_GrpInserir
2277:                 .Caption         = "Inserir Grupo"
2278:                 .Top             = 5
2279:                 .Left            = 5
2280:                 .Width           = 165
2281:                 .Height          = 35
2282:                 .BackColor       = RGB(255, 255, 255)
2283:                 .ForeColor       = RGB(90, 90, 90)
2284:                 .FontName        = "Tahoma"
2285:                 .FontSize        = 8
2286:                 .FontBold        = .T.
2287:                 .SpecialEffect   = 0
2288:                 .MousePointer    = 15
2289:                 .Visible         = .T.
2290:             ENDWITH
2291: 
2292:             .AddObject("cmd_4c_GrpExcluir", "CommandButton")
2293:             WITH .cmd_4c_GrpExcluir
2294:                 .Caption         = "Excluir Grupo"
2295:                 .Top             = 45
2296:                 .Left            = 5
2297:                 .Width           = 165
2298:                 .Height          = 35
2299:                 .BackColor       = RGB(255, 255, 255)
2300:                 .ForeColor       = RGB(90, 90, 90)
2301:                 .FontName        = "Tahoma"

*-- Linhas 2307 a 2354:
2307:             ENDWITH
2308:         ENDWITH
2309: 
2310:         loc_oPagina.AddObject("lbl_4c_Merc", "Label")
2311:         WITH loc_oPagina.lbl_4c_Merc
2312:             .Caption = "Merc"
2313:             .Top = 393
2314:             .Left = 800
2315:             .FontName = "Tahoma"
2316:             .FontSize = 8
2317:             .ForeColor = RGB(90,90,90)
2318:             .BackStyle = 0
2319:             .Visible = .T.
2320:         ENDWITH
2321:         loc_oPagina.AddObject("lbl_4c_CUni", "Label")
2322:         WITH loc_oPagina.lbl_4c_CUni
2323:             .Caption = "Uni"
2324:             .Top = 393
2325:             .Left = 850
2326:             .FontName = "Tahoma"
2327:             .FontSize = 8
2328:             .ForeColor = RGB(90,90,90)
2329:             .BackStyle = 0
2330:             .Visible = .T.
2331:         ENDWITH
2332:         loc_oPagina.AddObject("lbl_4c_CGru", "Label")
2333:         WITH loc_oPagina.lbl_4c_CGru
2334:             .Caption = "Grupo"
2335:             .Top = 393
2336:             .Left = 893
2337:             .FontName = "Tahoma"
2338:             .FontSize = 8
2339:             .ForeColor = RGB(90,90,90)
2340:             .BackStyle = 0
2341:             .Visible = .T.
2342:         ENDWITH
2343: 
2344:         loc_oPagina.AddObject("grd_4c_DestinoG", "Grid")
2345:         loc_oPagina.grd_4c_DestinoG.ColumnCount = 3
2346:         loc_oPagina.grd_4c_DestinoG.RecordSource = "csDestinoG"
2347:         WITH loc_oPagina.grd_4c_DestinoG
2348:             .Top                = 408
2349:             .Left               = 800
2350:             .Width              = 175
2351:             .Height             = 160
2352:             .FontName           = "Verdana"
2353:             .FontSize           = 8
2354:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 2366 a 2395:
2366:             .Visible            = .T.
2367:             .Column1.Width         = 40
2368:             .Column1.ControlSource = "csDestinoG.Mercs"
2369:             .Column1.Header1.Caption = "G.Grp."
2370:             .Column2.Width         = 40
2371:             .Column2.ControlSource = "csDestinoG.CUnis"
2372:             .Column2.Header1.Caption = "Uni"
2373:             .Column3.Width         = 55
2374:             .Column3.ControlSource = "csDestinoG.Cgrus"
2375:             .Column3.Header1.Caption = "Grupo"
2376:         ENDWITH
2377: 
2378:         *-- BINDEVENTs Page2
2379:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
2380:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
2381:         BINDEVENT(loc_oPagina.cnt_4c_CompoOp.cmd_4c_CompoInserir, "Click", THIS, "BtnCompoInserirClick")
2382:         BINDEVENT(loc_oPagina.cnt_4c_CompoOp.cmd_4c_CompoExcluir, "Click", THIS, "BtnCompoExcluirClick")
2383:         BINDEVENT(loc_oPagina.cnt_4c_CompoG.cmd_4c_GrpInserir,    "Click", THIS, "BtnGrpInserirClick")
2384:         BINDEVENT(loc_oPagina.cnt_4c_CompoG.cmd_4c_GrpExcluir,    "Click", THIS, "BtnGrpExcluirClick")
2385:         BINDEVENT(loc_oPagina.grd_4c_Destinos, "AfterRowColChange", THIS, "GrdDestinosAfterRowColChange")
2386:         BINDEVENT(loc_oPagina.grd_4c_Destinos, "KeyPress", THIS, "GrdDestinosKeyPress")
2387:         BINDEVENT(loc_oPagina.grd_4c_Destinos, "DblClick", THIS, "GrdDestinosDblClick")
2388:         BINDEVENT(loc_oPagina.grd_4c_DestinoG, "KeyPress", THIS, "GrdDestinoGKeyPress")
2389:         BINDEVENT(loc_oPagina.grd_4c_DestinoG, "DblClick", THIS, "GrdDestinoGDblClick")
2390:         BINDEVENT(loc_oPagina.cmd_4c_CopOpe, "Click", THIS, "BtnCopOpeClick")
2391: 
2392:         THIS.TornarControlesVisiveis(loc_oPagina)
2393:     ENDPROC
2394: 
2395:     *==========================================================================

*-- Linhas 2416 a 2426:
2416:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.processos"
2417:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.emps"
2418:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.codigos"
2419:                         loc_oGrid.Column1.Header1.Caption = "Processo"
2420:                         loc_oGrid.Column2.Header1.Caption = "Emp"
2421:                         loc_oGrid.Column3.Header1.Caption = "C" + CHR(243) + "digo"
2422:                         THIS.FormatarGridLista(loc_oGrid)
2423:                     ENDIF
2424:                     loc_lResultado = .T.
2425:                 ENDIF
2426:             ENDIF

*-- Linhas 2883 a 2892:
2883: 
2884:         *-- Botao confirmar
2885:         IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
2886:             IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
2887:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditar
2888:             ENDIF
2889:         ENDIF
2890:     ENDPROC
2891: 
2892:     *==========================================================================

*-- Linhas 2968 a 2979:
2968:             loc_oPg2.txt_4c_Processos.Value = ""
2969:         ENDIF
2970:         IF PEMSTATUS(loc_oPg2, "txt_4c_Codigos", 5)
2971:             loc_oPg2.txt_4c_Codigos.Value = .F.
2972:         ENDIF
2973:         IF PEMSTATUS(loc_oPg2, "txt_4c_Toleras", 5)
2974:             loc_oPg2.txt_4c_Toleras.Value = .F.
2975:         ENDIF
2976:         IF PEMSTATUS(loc_oPg2, "obj_4c_OptFiscal", 5)
2977:             loc_oPg2.obj_4c_OptFiscal.Value = 2
2978:         ENDIF
2979:         IF PEMSTATUS(loc_oPg2, "obj_4c_OptImprimir", 5)

*-- Linhas 3202 a 3212:
3202:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.processos"
3203:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.emps"
3204:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.codigos"
3205:                         loc_oGrid.Column1.Header1.Caption = "Processo"
3206:                         loc_oGrid.Column2.Header1.Caption = "Emp"
3207:                         loc_oGrid.Column3.Header1.Caption = "C" + CHR(243) + "digo"
3208:                         THIS.FormatarGridLista(loc_oGrid)
3209:                     ENDIF
3210:                 ENDIF
3211:             ELSE
3212:                 THIS.CarregarLista()


### BO (C:\4c\projeto\app\classes\prcBO.prg):
*==============================================================================
* prcBO.prg - Business Object: Cadastro de Movimenta" + CHR(231) + CHR(245) + "es Para C" + CHR(243) + "pia
* Tabela principal : SigPcOoP (PK: codigos numeric(6,0))
* Tabelas filhas   : SigPcOoI (cidchaves PK), SigPcOog (cidchaves PK)
* Herda de         : BusinessBase (app\classes\businessbase.prg)
* Task             : task501
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

DEFINE CLASS prcBO AS BusinessBase

    *-- Campos da tabela SigPcOoP
    this_cProcessos  = ""   && processos  CHAR(20)    - nome/chave do processo
    this_cEmps       = ""   && emps       CHAR(3)     - empresa
    this_cDopes      = ""   && dopes      CHAR(20)    - operacao
    this_nCodigos    = 0    && codigos    NUM(6,0)    - PK
    this_nNotas      = 0    && notas      NUM(1,0)
    this_nOrdems     = 0    && ordems     NUM(1,0)
    this_nApagar     = 0    && apagar     NUM(1,0)
    this_nFiscal     = 0    && fiscal     NUM(1,0)
    this_nImprimir   = 0    && imprimir   NUM(1,0)
    this_nLogs       = 0    && logs       NUM(1,0)
    this_nToleras    = 0    && toleras    NUM(11,2)
    this_cClass      = ""   && class      CHAR(15)
    this_cGrupo      = ""   && grupo      CHAR(15)

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPcOoP"
            THIS.this_cCampoChave = "codigos"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "prcBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    FUNCTION ObterChavePrimaria()
    *==========================================================================
        RETURN TRANSFORM(THIS.this_nCodigos)
    ENDFUNC

    *==========================================================================
    * Buscar - SELECT lista para o grid
    * par_cFiltro: condicao WHERE adicional (sem WHERE) ou "" para todos
    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cWhere
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cWhere = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = "SELECT processos, emps, codigos" + ;
                       " FROM SigPcOoP" + loc_cWhere + ;
                       " ORDER BY processos"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar processos de c" + CHR(243) + "pia:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em prcBO.Buscar:" + CHR(13) + loc_oErro.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pelo codigos (PK)
    *==========================================================================
    FUNCTION CarregarPorCodigo(par_nCodigos)
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Registro")
                USE IN cursor_4c_Registro
            ENDIF

            loc_cSQL = "SELECT processos, emps, dopes, codigos, notas, ordems," + ;
                       " apagar, fiscal, imprimir, logs, toleras, class AS tclass, grupo" + ;
                       " FROM SigPcOoP" + ;
                       " WHERE codigos = " + FormatarNumeroSQL(par_nCodigos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Registro")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Registro") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Registro")
            ENDIF

            IF USED("cursor_4c_Registro")
                USE IN cursor_4c_Registro
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em prcBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Popula propriedades do BO a partir do cursor
    *==========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cProcessos = TratarNulo(processos, "")
                THIS.this_cEmps      = TratarNulo(emps,      "")
                THIS.this_cDopes     = TratarNulo(dopes,     "")
                THIS.this_nCodigos   = TratarNulo(codigos,   0)
                THIS.this_nNotas     = TratarNulo(notas,     0)
                THIS.this_nOrdems    = TratarNulo(ordems,    0)
                THIS.this_nApagar    = TratarNulo(apagar,    0)
                THIS.this_nFiscal    = TratarNulo(fiscal,    0)
                THIS.this_nImprimir  = TratarNulo(imprimir,  0)
                THIS.this_nLogs      = TratarNulo(logs,      0)
                THIS.this_nToleras   = TratarNulo(toleras,   0)
                THIS.this_cClass     = TratarNulo(tclass,    "")
                THIS.this_cGrupo     = TratarNulo(grupo,     "")
                THIS.this_lNovoRegistro = .F.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em prcBO.CarregarDoCursor:" + CHR(13) + loc_oErro.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    PROTECTED FUNCTION Inserir()
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_nCodigos = THIS.ObterProxCodigos()

            loc_cSQL = "INSERT INTO SigPcOoP" + ;
                       " (processos, emps, dopes, codigos, notas, ordems," + ;
                       "  apagar, fiscal, imprimir, logs, toleras, class, grupo)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cProcessos)           + ", " + ;
                       EscaparSQL(THIS.this_cEmps)                + ", " + ;
                       EscaparSQL(THIS.this_cDopes)               + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCodigos)      + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNotas)        + ", " + ;
                       FormatarNumeroSQL(THIS.this_nOrdems)       + ", " + ;
                       FormatarNumeroSQL(THIS.this_nApagar)       + ", " + ;
                       FormatarNumeroSQL(THIS.this_nFiscal)       + ", " + ;
                       FormatarNumeroSQL(THIS.this_nImprimir)     + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLogs)         + ", " + ;
                       FormatarNumeroSQL(THIS.this_nToleras)      + ", " + ;
                       EscaparSQL(THIS.this_cClass)               + ", " + ;
                       EscaparSQL(THIS.this_cGrupo)               + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir processo de c" + CHR(243) + "pia:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em prcBO.Inserir:" + CHR(13) + loc_oErro.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    PROTECTED FUNCTION Atualizar()
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigPcOoP SET" + ;
                       " processos = " + EscaparSQL(THIS.this_cProcessos)       + ", " + ;
                       " emps      = " + EscaparSQL(THIS.this_cEmps)            + ", " + ;
                       " dopes     = " + EscaparSQL(THIS.this_cDopes)           + ", " + ;
                       " notas     = " + FormatarNumeroSQL(THIS.this_nNotas)    + ", " + ;
                       " ordems    = " + FormatarNumeroSQL(THIS.this_nOrdems)   + ", " + ;
                       " apagar    = " + FormatarNumeroSQL(THIS.this_nApagar)   + ", " + ;
                       " fiscal    = " + FormatarNumeroSQL(THIS.this_nFiscal)   + ", " + ;
                       " imprimir  = " + FormatarNumeroSQL(THIS.this_nImprimir) + ", " + ;
                       " logs      = " + FormatarNumeroSQL(THIS.this_nLogs)     + ", " + ;
                       " toleras   = " + FormatarNumeroSQL(THIS.this_nToleras)  + ", " + ;
                       " class     = " + EscaparSQL(THIS.this_cClass)           + ", " + ;
                       " grupo     = " + EscaparSQL(THIS.this_cGrupo)           + ;
                       " WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar processo de c" + CHR(243) + "pia:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em prcBO.Atualizar:" + CHR(13) + loc_oErro.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExecutarExclusao - Exclui em cascata: OoI -> OoG -> SigCdPrg -> OoP
    *==========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cProc
        loc_lSucesso = .F.

        TRY
            loc_cProc = ALLTRIM(THIS.this_cProcessos)

            loc_cSQL = "DELETE FROM SigPcOoI WHERE processos = " + EscaparSQL(loc_cProc)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult < 0
                MsgErro("Erro ao excluir itens SigPcOoI:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_cSQL = "DELETE FROM SigPcOog WHERE processos = " + EscaparSQL(loc_cProc)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult < 0
                    MsgErro("Erro ao excluir grupos SigPcOog:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    *-- Remove entrada em SigCdPrg (erro nao critico)
                    loc_cSQL = "DELETE FROM SigCdPrg" + ;
                               " WHERE programas = " + EscaparSQL(PADR("SIGCDPRC", 15)) + ;
                               " AND parametros = " + EscaparSQL(PADL(TRANSFORM(THIS.this_nCodigos), 10, "0"))
                    SQLEXEC(gnConnHandle, loc_cSQL)

                    loc_cSQL = "DELETE FROM SigPcOoP WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResult >= 0
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lSucesso = .T.
                    ELSE
                        MsgErro("Erro ao excluir SigPcOoP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em prcBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ObterProxCodigos - Gera proximo codigos (MAX+1) em SigPcOoP
    *==========================================================================
    PROTECTED FUNCTION ObterProxCodigos()
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_nProx
        loc_nProx = 1

        TRY
            IF USED("cursor_4c_MaxCod")
                USE IN cursor_4c_MaxCod
            ENDIF

            loc_cSQL = "SELECT ISNULL(MAX(codigos), 0) + 1 AS proxcod FROM SigPcOoP"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxCod")

            IF loc_nResult > 0 AND !EOF("cursor_4c_MaxCod")
                loc_nProx = cursor_4c_MaxCod.proxcod
            ENDIF

            IF USED("cursor_4c_MaxCod")
                USE IN cursor_4c_MaxCod
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em prcBO.ObterProxCodigos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_nProx
    ENDFUNC

    *==========================================================================
    * SalvarItens - Persiste csDestinos e csDestinoG no banco
    * par_cProcessos : nome do processo
    * par_nCodigos   : PK do processo
    *==========================================================================
    FUNCTION SalvarItens(par_cProcessos, par_nCodigos)
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cCidChaves, loc_cFkChaves
        loc_lSucesso = .F.

        TRY
            *-- Limpa filhos anteriores
            loc_cSQL = "DELETE FROM SigPcOoI WHERE processos = " + EscaparSQL(par_cProcessos)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult < 0
                MsgErro("Erro ao limpar SigPcOoI:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_cSQL = "DELETE FROM SigPcOog WHERE processos = " + EscaparSQL(par_cProcessos)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult < 0
                    MsgErro("Erro ao limpar SigPcOog:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    IF USED("csDestinos")
                        SELECT csDestinos
                        SCAN
                            loc_cCidChaves = fUniqueIds()
                            loc_cFkChaves  = loc_cCidChaves

                            loc_cSQL = "INSERT INTO SigPcOoI" + ;
                                " (processos, emps, dopes, codigos, drives, empds," + ;
                                "  dopeds, tpprodutos, dias, gruconos, gruconds," + ;
                                "  agrupar, pctmins, pctmaxs, custos, imagem, barras," + ;
                                "  novocods, empdests, gdegrupos, cidchaves," + ;
                                "  franquias, oricompos, cunis, mccrs, delets, chkcons," + ;
                                "  cortams, desitens, destinos, montaobs, origems," + ;
                                "  semitens, situas, cheques, mantemmats, mantprods," + ;
                                "  recalculos, mantdpros, fiscais, impostos, pctcopias," + ;
                                "  movcparc, movmzeros, opitens, pctcomps, globalizas, moevals, atucli)" + ;
                                " VALUES (" + ;
                                EscaparSQL(par_cProcessos)                              + ", " + ;
                                EscaparSQL(ALLTRIM(csDestinos.Emps))                   + ", " + ;
                                EscaparSQL(ALLTRIM(csDestinos.Dopes))                  + ", " + ;
                                FormatarNumeroSQL(par_nCodigos)                        + ", " + ;
                                EscaparSQL(ALLTRIM(csDestinos.Drives))                 + ", " + ;
                                EscaparSQL(ALLTRIM(csDestinos.EmpDs))                  + ", " + ;
                                EscaparSQL(ALLTRIM(csDestinos.DopeDs))                 + ", " + ;
                                FormatarNumeroSQL(csDestinos.TpProdutos)               + ", " + ;
                                FormatarNumeroSQL(csDestinos.Dias)                     + ", " + ;
                                FormatarNumeroSQL(csDestinos.GruconOs)                 + ", " + ;
                                FormatarNumeroSQL(csDestinos.GruconDs)                 + ", " + ;
                                FormatarNumeroSQL(csDestinos.Agrupar)                  + ", " + ;
                                FormatarNumeroSQL(csDestinos.PctMins)                  + ", " + ;
                                FormatarNumeroSQL(csDestinos.PctMaxs)                  + ", " + ;
                                FormatarNumeroSQL(csDestinos.Custos)                   + ", " + ;
                                FormatarNumeroSQL(csDestinos.Imagem)                   + ", " + ;
                                FormatarNumeroSQL(csDestinos.Barras)                   + ", " + ;
                                FormatarNumeroSQL(csDestinos.NovoCods)                 + ", " + ;
                                FormatarNumeroSQL(csDestinos.EmpDests)                 + ", " + ;
                                EscaparSQL(ALLTRIM(csDestinos.GdeGrupos))              + ", " + ;
                                EscaparSQL(loc_cCidChaves)                             + ", " + ;
                                FormatarNumeroSQL(csDestinos.Franquias)                + ", " + ;
                                FormatarNumeroSQL(csDestinos.OriCompos)                + ", " + ;
                                EscaparSQL(ALLTRIM(csDestinos.CUnis))                  + ", " + ;
                                FormatarNumeroSQL(csDestinos.Mccrs)                    + ", " + ;
                                FormatarNumeroSQL(csDestinos.Delets)                   + ", " + ;
                                FormatarNumeroSQL(csDestinos.ChkCons)                  + ", " + ;
                                FormatarNumeroSQL(csDestinos.CorTams)                  + ", " + ;
                                FormatarNumeroSQL(csDestinos.DesItens)                 + ", " + ;
                                EscaparSQL(ALLTRIM(csDestinos.Destinos))               + ", " + ;
                                FormatarNumeroSQL(csDestinos.MontaObs)                 + ", " + ;
                                EscaparSQL(ALLTRIM(csDestinos.Origems))                + ", " + ;
                                FormatarNumeroSQL(csDestinos.SemItens)                 + ", " + ;
                                FormatarNumeroSQL(csDestinos.Situas)                   + ", " + ;
                                FormatarNumeroSQL(csDestinos.Cheques)                  + ", " + ;
                                FormatarNumeroSQL(csDestinos.MantemMats)               + ", " + ;
                                FormatarNumeroSQL(csDestinos.MantProds)                + ", " + ;
                                FormatarNumeroSQL(csDestinos.Recalculos)               + ", " + ;
                                FormatarNumeroSQL(csDestinos.MantDPros)                + ", " + ;
                                FormatarNumeroSQL(csDestinos.Fiscais)                  + ", " + ;
                                FormatarNumeroSQL(csDestinos.Impostos)                 + ", " + ;
                                FormatarNumeroSQL(csDestinos.PctCopias)                + ", " + ;
                                FormatarNumeroSQL(csDestinos.MovcParc)                 + ", " + ;
                                FormatarNumeroSQL(csDestinos.MovMZeros)                + ", " + ;
                                EscaparSQL(ALLTRIM(csDestinos.OpItens))                + ", " + ;
                                FormatarNumeroSQL(csDestinos.pctcomps)                 + ", " + ;
                                FormatarNumeroSQL(csDestinos.Globalizas)               + ", " + ;
                                FormatarNumeroSQL(csDestinos.MoeVals)                  + ", " + ;
                                "0)"

                            SQLEXEC(gnConnHandle, loc_cSQL)

                            *-- Grupos correspondentes do csDestinoG
                            IF USED("csDestinoG")
                                LOCAL loc_cIdRef
                                loc_cIdRef = ALLTRIM(csDestinos.cIdChaves)
                                SELECT csDestinoG
                                SCAN FOR ALLTRIM(csDestinoG.fkChaves) == loc_cIdRef ;
                                        AND (!EMPTY(ALLTRIM(csDestinoG.Mercs)) OR !EMPTY(ALLTRIM(csDestinoG.Cgrus)))
                                    loc_cSQL = "INSERT INTO SigPcOog" + ;
                                        " (processos, cidchaves, cunis, fkchaves, mercs, cgrus)" + ;
                                        " VALUES (" + ;
                                        EscaparSQL(par_cProcessos)                           + ", " + ;
                                        EscaparSQL(fUniqueIds())                              + ", " + ;
                                        EscaparSQL(ALLTRIM(csDestinoG.CUnis))                + ", " + ;
                                        EscaparSQL(loc_cFkChaves)                             + ", " + ;
                                        EscaparSQL(ALLTRIM(csDestinoG.Mercs))                + ", " + ;
                                        EscaparSQL(ALLTRIM(csDestinoG.Cgrus))                + ")"
                                    SQLEXEC(gnConnHandle, loc_cSQL)
                                ENDSCAN
                                SELECT csDestinos
                            ENDIF
                        ENDSCAN
                        loc_lSucesso = .T.
                    ELSE
                        MsgErro("Cursor csDestinos n" + CHR(227) + "o encontrado.", "Erro")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em prcBO.SalvarItens:" + CHR(13) + loc_oErro.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * AtualizarSigCdPrg - Registra/atualiza entrada em SigCdPrg
    *==========================================================================
    FUNCTION AtualizarSigCdPrg(par_cProcessos, par_nCodigos)
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cProg, loc_cParam
        loc_lSucesso = .F.

        TRY
            loc_cProg  = PADR("SIGCDPRC", 15)
            loc_cParam = PADL(TRANSFORM(par_nCodigos), 10, "0")

            loc_cSQL = "DELETE FROM SigCdPrg" + ;
                       " WHERE programas = " + EscaparSQL(loc_cProg) + ;
                       " AND parametros = " + EscaparSQL(loc_cParam)
            SQLEXEC(gnConnHandle, loc_cSQL)

            loc_cSQL = "INSERT INTO SigCdPrg (programas, parametros, descricaos)" + ;
                       " VALUES (" + ;
                       EscaparSQL(loc_cProg)                   + ", " + ;
                       EscaparSQL(loc_cParam)                  + ", " + ;
                       EscaparSQL(ALLTRIM(par_cProcessos))     + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar SigCdPrg:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em prcBO.AtualizarSigCdPrg:" + CHR(13) + loc_oErro.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

