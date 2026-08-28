# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 198: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 222: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 246: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 270: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 294: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 332: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 435: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 459: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formmtz.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2302 linhas total):

*-- Linhas 94 a 115:
94: 
95:         WITH THIS.pgf_4c_Paginas
96:             .PageCount  = 2
97:             .Top        = -29
98:             .Left       = 0
99:             .Width      = THIS.Width
100:             .Height     = THIS.Height + 29
101:             .Tabs       = .F.
102:             .Visible    = .T.
103: 
104:             *-- Imagens de fundo nas duas paginas
105:             .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
106:             .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
107: 
108:             .Page1.Caption = "Lista"
109:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
110:             .Page2.Caption = "Dados"
111:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
112:         ENDWITH
113: 
114:         *-- Configura cada pagina
115:         THIS.ConfigurarPaginaLista()

*-- Linhas 132 a 168:
132:         *--------------------------------------------------------------------------
133:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
134:         WITH loc_oPagina.cnt_4c_Cabecalho
135:             .Top         = 2
136:             .Left        = 0
137:             .Width       = THIS.Width
138:             .Height      = 80
139:             .BackColor   = RGB(100, 100, 100)
140:             .BorderWidth = 0
141:             .Visible     = .T.
142:         ENDWITH
143: 
144:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
145:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
146:             .Caption   = "Matriz de Saldos por Centro de Custo"
147:             .Top       = 15
148:             .Left      = 10
149:             .Width     = 769
150:             .Height    = 40
151:             .FontName  = "Tahoma"
152:             .FontSize  = 16
153:             .FontBold  = .T.
154:             .ForeColor = RGB(0, 0, 0)
155:             .BackStyle = 0
156:             .Visible   = .T.
157:         ENDWITH
158: 
159:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
160:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
161:             .Caption   = "Matriz de Saldos por Centro de Custo"
162:             .Top       = 18
163:             .Left      = 10
164:             .Width     = 769
165:             .Height    = 46
166:             .FontName  = "Tahoma"
167:             .FontSize  = 16
168:             .FontBold  = .T.

*-- Linhas 176 a 204:
176:         *--------------------------------------------------------------------------
177:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
178:         WITH loc_oPagina.cnt_4c_Botoes
179:             .Top         = 0
180:             .Left        = 542
181:             .Width       = 475
182:             .Height      = 85
183:             .BackStyle = 0
184:             .BorderWidth = 0
185:             .Visible     = .T.
186:         ENDWITH
187: 
188:         *-- Botao Incluir
189:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
190:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
191:             .Caption         = "Incluir"
192:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
193:             .PicturePosition = 13
194:             .Top             = 5
195:             .Left            = 5
196:             .Width           = 75
197:             .Height          = 75
198:             .FontName        = "Comic Sans MS"
199:             .FontBold        = .T.
200:             .FontItalic      = .T.
201:             .FontSize        = 8
202:             .ForeColor       = RGB(90, 90, 90)
203:             .BackColor       = RGB(255, 255, 255)
204:             .Themes          = .F.

*-- Linhas 210 a 228:
210:         ENDWITH
211: 
212:         *-- Botao Visualizar
213:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
214:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
215:             .Caption         = "Visualizar"
216:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
217:             .PicturePosition = 13
218:             .Top             = 5
219:             .Left            = 80
220:             .Width           = 75
221:             .Height          = 75
222:             .FontName        = "Comic Sans MS"
223:             .FontBold        = .T.
224:             .FontItalic      = .T.
225:             .FontSize        = 8
226:             .ForeColor       = RGB(90, 90, 90)
227:             .BackColor       = RGB(255, 255, 255)
228:             .Themes          = .F.

*-- Linhas 234 a 252:
234:         ENDWITH
235: 
236:         *-- Botao Alterar
237:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
238:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
239:             .Caption         = "Alterar"
240:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
241:             .PicturePosition = 13
242:             .Top             = 5
243:             .Left            = 155
244:             .Width           = 75
245:             .Height          = 75
246:             .FontName        = "Comic Sans MS"
247:             .FontBold        = .T.
248:             .FontItalic      = .T.
249:             .FontSize        = 8
250:             .ForeColor       = RGB(90, 90, 90)
251:             .BackColor       = RGB(255, 255, 255)
252:             .Themes          = .F.

*-- Linhas 258 a 276:
258:         ENDWITH
259: 
260:         *-- Botao Excluir
261:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
262:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
263:             .Caption         = "Excluir"
264:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
265:             .PicturePosition = 13
266:             .Top             = 5
267:             .Left            = 230
268:             .Width           = 75
269:             .Height          = 75
270:             .FontName        = "Comic Sans MS"
271:             .FontBold        = .T.
272:             .FontItalic      = .T.
273:             .FontSize        = 8
274:             .ForeColor       = RGB(90, 90, 90)
275:             .BackColor       = RGB(255, 255, 255)
276:             .Themes          = .F.

*-- Linhas 282 a 300:
282:         ENDWITH
283: 
284:         *-- Botao Buscar
285:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
286:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
287:             .Caption         = "Buscar"
288:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
289:             .PicturePosition = 13
290:             .Top             = 5
291:             .Left            = 305
292:             .Width           = 75
293:             .Height          = 75
294:             .FontName        = "Comic Sans MS"
295:             .FontBold        = .T.
296:             .FontItalic      = .T.
297:             .FontSize        = 8
298:             .ForeColor       = RGB(90, 90, 90)
299:             .BackColor       = RGB(255, 255, 255)
300:             .Themes          = .F.

*-- Linhas 310 a 338:
310:         *--------------------------------------------------------------------------
311:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
312:         WITH loc_oPagina.cnt_4c_Saida
313:             .Top         = 29
314:             .Left        = 917
315:             .Width       = 90
316:             .Height      = 85
317:             .BackStyle = 1
318:             .BackColor = RGB(255, 255, 255)
319:             .BorderWidth = 0
320:             .Visible     = .T.
321:         ENDWITH
322: 
323:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
324:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
325:             .Caption         = "Encerrar"
326:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
327:             .PicturePosition = 13
328:             .Top             = 5
329:             .Left            = 5
330:             .Width           = 75
331:             .Height          = 75
332:             .FontName        = "Comic Sans MS"
333:             .FontBold        = .T.
334:             .FontItalic      = .T.
335:             .FontSize        = 8
336:             .ForeColor       = RGB(90, 90, 90)
337:             .BackColor       = RGB(255, 255, 255)
338:             .Themes          = .F.

*-- Linhas 351 a 360:
351:         loc_oPagina.grd_4c_Lista.ColumnCount  = 7
352: 
353:         WITH loc_oPagina.grd_4c_Lista
354:             .Top                = 88
355:             .Left               = 5
356:             .Width              = 905
357:             .Height             = 480
358:             .FontName           = "Verdana"
359:             .FontSize           = 8
360:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 370 a 400:
370:             .GridLines          = 3
371:             .ReadOnly           = .T.
372:             .Visible            = .T.
373:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
374:             .Column1.Width           = 50
375:             .Column2.Header1.Caption = "Ano"
376:             .Column2.Width           = 50
377:             .Column3.Header1.Caption = "Grupo"
378:             .Column3.Width           = 80
379:             .Column4.Header1.Caption = "Conta"
380:             .Column4.Width           = 80
381:             .Column5.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
382:             .Column5.Width           = 440
383:             .Column6.Header1.Caption = "Moeda"
384:             .Column6.Width           = 60
385:             .Column7.Header1.Caption = "Valida"
386:             .Column7.Width           = 55
387:         ENDWITH
388: 
389:         *-- Vincular eventos da Page1
390:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
391:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
392:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
393:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
394:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
395:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
396: 
397:         THIS.TornarControlesVisiveis(loc_oPagina)
398:     ENDPROC
399: 
400:     *-- =========================================================================

*-- Linhas 413 a 441:
413:         *--------------------------------------------------------------------------
414:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
415:         WITH loc_oPagina.cnt_4c_BotoesAcao
416:             .Top         = 33
417:             .Left        = 842
418:             .Width       = 160
419:             .Height      = 85
420:             .BackStyle = 1
421:             .BackColor = RGB(255, 255, 255)
422:             .Visible     = .T.
423:         ENDWITH
424: 
425:         *-- Botao Confirmar (Salvar)
426:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
427:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
428:             .Caption         = "Confirmar"
429:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
430:             .PicturePosition = 13
431:             .Top             = 5
432:             .Left            = 5
433:             .Width           = 75
434:             .Height          = 75
435:             .FontName        = "Comic Sans MS"
436:             .FontBold        = .T.
437:             .FontItalic      = .T.
438:             .FontSize        = 8
439:             .ForeColor       = RGB(90, 90, 90)
440:             .BackColor       = RGB(255, 255, 255)
441:             .Themes          = .F.

*-- Linhas 447 a 465:
447:         ENDWITH
448: 
449:         *-- Botao Cancelar
450:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
451:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
452:             .Caption         = "Encerrar"
453:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
454:             .PicturePosition = 13
455:             .Top             = 5
456:             .Left            = 80
457:             .Width           = 75
458:             .Height          = 75
459:             .FontName        = "Comic Sans MS"
460:             .FontBold        = .T.
461:             .FontItalic      = .T.
462:             .FontSize        = 8
463:             .ForeColor       = RGB(90, 90, 90)
464:             .BackColor       = RGB(255, 255, 255)
465:             .Themes          = .F.

*-- Linhas 472 a 486:
472: 
473:         *--------------------------------------------------------------------------
474:         *-- Label "Codigo :" + TextBox Codigo (getCodigo)
475:         *-- Original: lbl_grupo.Top=43,Left=334 / getCodigo.Top=39,Left=382
476:         *--------------------------------------------------------------------------
477:         loc_oPagina.AddObject("lbl_4c_Lbl_grupo", "Label")
478:         WITH loc_oPagina.lbl_4c_Lbl_grupo
479:             .Caption   = "C" + CHR(243) + "digo :"
480:             .Top       = 72
481:             .Left      = 334
482:             .Width     = 42
483:             .Height    = 15
484:             .FontName  = "Tahoma"
485:             .FontSize  = 8
486:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 492 a 536:
492:         WITH loc_oPagina.txt_4c_Codigo
493:             .Value     = ""
494:             .MaxLength = 10
495:             .Top       = 68
496:             .Left      = 382
497:             .Width     = 51
498:             .Height    = 23
499:             .FontName  = "Tahoma"
500:             .FontSize  = 8
501:             .ReadOnly  = .T.
502:             .Visible   = .T.
503:         ENDWITH
504: 
505:         *--------------------------------------------------------------------------
506:         *-- CheckBox "Inativa" (Check1)
507:         *-- Original: Top=43, Left=440
508:         *--------------------------------------------------------------------------
509:         loc_oPagina.AddObject("chk_4c_Check1", "CheckBox")
510:         WITH loc_oPagina.chk_4c_Check1
511:             .Caption   = "Inativa"
512:             .Value     = 0
513:             .Top       = 72
514:             .Left      = 440
515:             .Width     = 52
516:             .Height    = 15
517:             .FontName  = "Tahoma"
518:             .FontSize  = 8
519:             .ForeColor = RGB(90, 90, 90)
520:             .Visible   = .T.
521:         ENDWITH
522: 
523:         *--------------------------------------------------------------------------
524:         *-- Label "Moeda :" + TextBox Moeda (getMoeda)
525:         *-- Original: Say2.Top=43,Left=718 / getMoeda.Top=39,Left=764
526:         *--------------------------------------------------------------------------
527:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
528:         WITH loc_oPagina.lbl_4c_Label2
529:             .Caption   = "Moeda :"
530:             .Top       = 72
531:             .Left      = 718
532:             .Width     = 41
533:             .Height    = 15
534:             .FontName  = "Tahoma"
535:             .FontSize  = 8
536:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 542 a 567:
542:         WITH loc_oPagina.txt_4c_Moeda
543:             .Value     = ""
544:             .MaxLength = 3
545:             .Top       = 68
546:             .Left      = 764
547:             .Width     = 51
548:             .Height    = 23
549:             .FontName  = "Tahoma"
550:             .FontSize  = 8
551:             .Visible   = .T.
552:         ENDWITH
553: 
554:         *--------------------------------------------------------------------------
555:         *-- Label "Ano Competencia :" + TextBox Ano (getAno)
556:         *-- Original: lbl_Ano.Top=70,Left=283 / getAno.Top=66,Left=382
557:         *--------------------------------------------------------------------------
558:         loc_oPagina.AddObject("lbl_4c_Lbl_Ano", "Label")
559:         WITH loc_oPagina.lbl_4c_Lbl_Ano
560:             .Caption   = "Ano Compet" + CHR(234) + "ncia :"
561:             .Top       = 99
562:             .Left      = 283
563:             .Width     = 93
564:             .Height    = 15
565:             .FontName  = "Tahoma"
566:             .FontSize  = 8
567:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 573 a 631:
573:         WITH loc_oPagina.txt_4c_Ano
574:             .Value     = ""
575:             .MaxLength = 4
576:             .Top       = 95
577:             .Left      = 382
578:             .Width     = 51
579:             .Height    = 23
580:             .FontName  = "Tahoma"
581:             .FontSize  = 8
582:             .Visible   = .T.
583:         ENDWITH
584: 
585:         *--------------------------------------------------------------------------
586:         *-- Label "Valor Acumulado :" + TextBox ValorTotal (readonly/calculado)
587:         *-- Original: Say1.Top=70,Left=671 / getValorTotal.Top=66,Left=764
588:         *--------------------------------------------------------------------------
589:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
590:         WITH loc_oPagina.lbl_4c_Label1
591:             .Caption   = "Valor Acumulado :"
592:             .Top       = 99
593:             .Left      = 671
594:             .Width     = 88
595:             .Height    = 15
596:             .FontName  = "Tahoma"
597:             .FontSize  = 8
598:             .ForeColor = RGB(90, 90, 90)
599:             .BackStyle = 0
600:             .Visible   = .T.
601:         ENDWITH
602: 
603:         loc_oPagina.AddObject("txt_4c_ValorTotal", "TextBox")
604:         WITH loc_oPagina.txt_4c_ValorTotal
605:             .Value     = 0
606:             .Top       = 95
607:             .Left      = 764
608:             .Width     = 108
609:             .Height    = 23
610:             .FontName  = "Tahoma"
611:             .FontSize  = 8
612:             .ReadOnly  = .T.
613:             .Visible   = .T.
614:         ENDWITH
615: 
616:         *--------------------------------------------------------------------------
617:         *-- "Centro de Custo :" + Grupo + "/" + Conta + Desc + Class3
618:         *-- Original: lblCentroCusto.Top=97,Left=288 / Get_sgrupo.Top=93,Left=382
619:         *--   Say14("/").Top=97,Left=466 / Get_sconta.Top=93,Left=473
620:         *--   Get_sdconta.Top=93,Left=554,Width=290 / Get_class3.Top=93,Left=845
621:         *--------------------------------------------------------------------------
622:         loc_oPagina.AddObject("lbl_4c_LblCentroCusto", "Label")
623:         WITH loc_oPagina.lbl_4c_LblCentroCusto
624:             .Caption   = "Centro de Custo :"
625:             .Top       = 126
626:             .Left      = 288
627:             .Width     = 88
628:             .Height    = 15
629:             .FontName  = "Tahoma"
630:             .FontSize  = 8
631:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 637 a 658:
637:         WITH loc_oPagina.txt_4c_Sgrupo
638:             .Value     = ""
639:             .MaxLength = 10
640:             .Top       = 122
641:             .Left      = 382
642:             .Width     = 82
643:             .Height    = 23
644:             .FontName  = "Tahoma"
645:             .FontSize  = 8
646:             .Visible   = .T.
647:         ENDWITH
648: 
649:         loc_oPagina.AddObject("lbl_4c_Label14", "Label")
650:         WITH loc_oPagina.lbl_4c_Label14
651:             .Caption   = "/"
652:             .Top       = 126
653:             .Left      = 466
654:             .Width     = 10
655:             .Height    = 15
656:             .FontName  = "Tahoma"
657:             .FontSize  = 8
658:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 664 a 735:
664:         WITH loc_oPagina.txt_4c_Sconta
665:             .Value     = ""
666:             .MaxLength = 20
667:             .Top       = 122
668:             .Left      = 473
669:             .Width     = 80
670:             .Height    = 23
671:             .FontName  = "Tahoma"
672:             .FontSize  = 8
673:             .Visible   = .T.
674:         ENDWITH
675: 
676:         loc_oPagina.AddObject("txt_4c_Sdconta", "TextBox")
677:         WITH loc_oPagina.txt_4c_Sdconta
678:             .Value     = ""
679:             .Top       = 122
680:             .Left      = 554
681:             .Width     = 290
682:             .Height    = 23
683:             .FontName  = "Tahoma"
684:             .FontSize  = 8
685:             .ReadOnly  = .T.
686:             .Visible   = .T.
687:         ENDWITH
688: 
689:         loc_oPagina.AddObject("txt_4c_Class3", "TextBox")
690:         WITH loc_oPagina.txt_4c_Class3
691:             .Value     = ""
692:             .MaxLength = 3
693:             .Top       = 122
694:             .Left      = 845
695:             .Width     = 27
696:             .Height    = 23
697:             .FontName  = "Tahoma"
698:             .FontSize  = 8
699:             .ReadOnly  = .T.
700:             .Visible   = .T.
701:         ENDWITH
702: 
703:         *--------------------------------------------------------------------------
704:         *-- getSaldo - exibe total saldo do registro (readonly, acima do grid)
705:         *-- Original: getSaldo.Top=109, Left=11, Width=100, Height=17
706:         *--------------------------------------------------------------------------
707:         loc_oPagina.AddObject("txt_4c_Saldo", "TextBox")
708:         WITH loc_oPagina.txt_4c_Saldo
709:             .Value     = 0
710:             .Top       = 138
711:             .Left      = 11
712:             .Width     = 100
713:             .Height    = 17
714:             .FontName  = "Tahoma"
715:             .FontSize  = 8
716:             .ReadOnly  = .T.
717:             .Visible   = .T.
718:         ENDWITH
719: 
720:         *--------------------------------------------------------------------------
721:         *-- Grade grd_4c_Dados (grdSaldos) - 28 colunas
722:         *-- Original: grdSaldos.Top=129, Left=11, Width=1045, Height=419
723:         *--------------------------------------------------------------------------
724:         LOCAL loc_oGrid
725:         loc_oGrid = .NULL.
726: 
727:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
728:         WITH loc_oPagina.grd_4c_Dados
729:             .Top         = 158     && 129+29
730:             .Left        = 11
731:             .Width       = 1045
732:             .Height      = 419
733:             .ColumnCount = 28
734:             .ReadOnly    = .T.     && HabilitarCampos gerencia
735:             .FontName    = "Tahoma"

*-- Linhas 743 a 1109:
743: 
744:         *-- Coluna 1 - Grupos
745:         WITH loc_oGrid.Column1
746:             .Header1.Caption = "Grupo"
747:             .Width           = 65
748:         ENDWITH
749: 
750:         *-- Coluna 2 - Contas
751:         WITH loc_oGrid.Column2
752:             .Header1.Caption = "Conta"
753:             .Width           = 65
754:         ENDWITH
755: 
756:         *-- Coluna 3 - Janeiro
757:         WITH loc_oGrid.Column3
758:             .Header1.Caption = "Janeiro"
759:             .Width           = 70
760:         ENDWITH
761: 
762:         *-- Coluna 4 - Fevereiro
763:         WITH loc_oGrid.Column4
764:             .Header1.Caption = "Fevereiro"
765:             .Width           = 70
766:         ENDWITH
767: 
768:         *-- Coluna 5 - Marco
769:         WITH loc_oGrid.Column5
770:             .Header1.Caption = "Mar" + CHR(231) + "o"
771:             .Width           = 70
772:         ENDWITH
773: 
774:         *-- Coluna 6 - Abril
775:         WITH loc_oGrid.Column6
776:             .Header1.Caption = "Abril"
777:             .Width           = 70
778:         ENDWITH
779: 
780:         *-- Coluna 7 - Maio
781:         WITH loc_oGrid.Column7
782:             .Header1.Caption = "Maio"
783:             .Width           = 70
784:         ENDWITH
785: 
786:         *-- Coluna 8 - Junho
787:         WITH loc_oGrid.Column8
788:             .Header1.Caption = "Junho"
789:             .Width           = 70
790:         ENDWITH
791: 
792:         *-- Coluna 9 - Julho
793:         WITH loc_oGrid.Column9
794:             .Header1.Caption = "Julho"
795:             .Width           = 70
796:         ENDWITH
797: 
798:         *-- Coluna 10 - Agosto
799:         WITH loc_oGrid.Column10
800:             .Header1.Caption = "Agosto"
801:             .Width           = 70
802:         ENDWITH
803: 
804:         *-- Coluna 11 - Setembro
805:         WITH loc_oGrid.Column11
806:             .Header1.Caption = "Setembro"
807:             .Width           = 70
808:         ENDWITH
809: 
810:         *-- Coluna 12 - Outubro
811:         WITH loc_oGrid.Column12
812:             .Header1.Caption = "Outubro"
813:             .Width           = 70
814:         ENDWITH
815: 
816:         *-- Coluna 13 - Novembro
817:         WITH loc_oGrid.Column13
818:             .Header1.Caption = "Novembro"
819:             .Width           = 70
820:         ENDWITH
821: 
822:         *-- Coluna 14 - Dezembro
823:         WITH loc_oGrid.Column14
824:             .Header1.Caption = "Dezembro"
825:             .Width           = 70
826:         ENDWITH
827: 
828:         *-- Coluna 15 - Total (calculado, readonly)
829:         WITH loc_oGrid.Column15
830:             .Header1.Caption = "Total"
831:             .Width           = 85
832:             .ReadOnly        = .T.
833:         ENDWITH
834: 
835:         *-- Colunas 16-27: Acumulados mensais (readonly)
836:         WITH loc_oGrid.Column16
837:             .Header1.Caption = ""
838:             .Width           = 75
839:             .ReadOnly        = .T.
840:         ENDWITH
841: 
842:         WITH loc_oGrid.Column17
843:             .Header1.Caption = ""
844:             .Width           = 75
845:             .ReadOnly        = .T.
846:         ENDWITH
847: 
848:         WITH loc_oGrid.Column18
849:             .Header1.Caption = ""
850:             .Width           = 75
851:             .ReadOnly        = .T.
852:         ENDWITH
853: 
854:         WITH loc_oGrid.Column19
855:             .Header1.Caption = ""
856:             .Width           = 75
857:             .ReadOnly        = .T.
858:         ENDWITH
859: 
860:         WITH loc_oGrid.Column20
861:             .Header1.Caption = ""
862:             .Width           = 75
863:             .ReadOnly        = .T.
864:         ENDWITH
865: 
866:         WITH loc_oGrid.Column21
867:             .Header1.Caption = ""
868:             .Width           = 75
869:             .ReadOnly        = .T.
870:         ENDWITH
871: 
872:         WITH loc_oGrid.Column22
873:             .Header1.Caption = ""
874:             .Width           = 75
875:             .ReadOnly        = .T.
876:         ENDWITH
877: 
878:         WITH loc_oGrid.Column23
879:             .Header1.Caption = ""
880:             .Width           = 75
881:             .ReadOnly        = .T.
882:         ENDWITH
883: 
884:         WITH loc_oGrid.Column24
885:             .Header1.Caption = ""
886:             .Width           = 75
887:             .ReadOnly        = .T.
888:         ENDWITH
889: 
890:         WITH loc_oGrid.Column25
891:             .Header1.Caption = ""
892:             .Width           = 75
893:             .ReadOnly        = .T.
894:         ENDWITH
895: 
896:         WITH loc_oGrid.Column26
897:             .Header1.Caption = ""
898:             .Width           = 75
899:             .ReadOnly        = .T.
900:         ENDWITH
901: 
902:         WITH loc_oGrid.Column27
903:             .Header1.Caption = ""
904:             .Width           = 75
905:             .ReadOnly        = .T.
906:         ENDWITH
907: 
908:         *-- Coluna 28 - Valida (CheckBox)
909:         WITH loc_oGrid.Column28
910:             .Header1.Caption = "Valida"
911:             .Width           = 45
912:             .Sparse          = .F.
913:         ENDWITH
914: 
915:         loc_oGrid.Column28.AddObject("chk_4c_Valida", "CheckBox")
916:         WITH loc_oGrid.Column28.chk_4c_Valida
917:             .Caption   = ""
918:             .Alignment = 0
919:             .ReadOnly  = .F.
920:             .Visible   = .T.
921:             .Top       = 25
922:             .Left      = 31
923:             .Height    = 17
924:             .Width     = 22
925:         ENDWITH
926: 
927:         *--------------------------------------------------------------------------
928:         *-- Container botoes Inserir/Excluir linha (cmdInsFtc)
929:         *-- Original: cmdInsFtc.Top=253, Left=1055, Width=50, Height=90
930:         *--------------------------------------------------------------------------
931:         loc_oPagina.AddObject("cnt_4c_InsFtc", "Container")
932:         WITH loc_oPagina.cnt_4c_InsFtc
933:             .Top         = 282     && 253+29
934:             .Left        = 1055
935:             .Width       = 45
936:             .Height      = 90
937:             .BackStyle = 1
938:             .BackColor = RGB(255, 255, 255)
939:             .Visible     = .T.
940:         ENDWITH
941: 
942:         loc_oPagina.cnt_4c_InsFtc.AddObject("cmd_4c_InserirLinha", "CommandButton")
943:         WITH loc_oPagina.cnt_4c_InsFtc.cmd_4c_InserirLinha
944:             .Caption       = "+"
945:             .Top           = 5
946:             .Left          = 2
947:             .Width         = 40
948:             .Height        = 36
949:             .FontName      = "Tahoma"
950:             .FontSize      = 12
951:             .FontBold      = .T.
952:             .ForeColor     = RGB(0, 128, 0)
953:             .SpecialEffect = 0
954:             .Visible       = .T.
955:         ENDWITH
956: 
957:         loc_oPagina.cnt_4c_InsFtc.AddObject("cmd_4c_ExcluirLinha", "CommandButton")
958:         WITH loc_oPagina.cnt_4c_InsFtc.cmd_4c_ExcluirLinha
959:             .Caption       = "-"
960:             .Top           = 49
961:             .Left          = 2
962:             .Width         = 40
963:             .Height        = 36
964:             .FontName      = "Tahoma"
965:             .FontSize      = 14
966:             .FontBold      = .T.
967:             .ForeColor     = RGB(192, 0, 0)
968:             .SpecialEffect = 0
969:             .Visible       = .T.
970:         ENDWITH
971: 
972:         *--------------------------------------------------------------------------
973:         *-- Shape separador (Shape3)
974:         *-- Original: Shape3.Top=569, Left=5, Width=504, Height=2
975:         *--------------------------------------------------------------------------
976:         loc_oPagina.AddObject("shp_4c_Shape3", "Shape")
977:         WITH loc_oPagina.shp_4c_Shape3
978:             .Top         = 598     && 569+29
979:             .Left        = 5
980:             .Width       = 504
981:             .Height      = 2
982:             .BackStyle   = 1
983:             .BackColor   = RGB(128, 128, 128)
984:             .BorderStyle = 0
985:             .Visible     = .T.
986:         ENDWITH
987: 
988:         *--------------------------------------------------------------------------
989:         *-- Campos de Auditoria (readonly)
990:         *-- Original: Say20.Top=553, Say24/Say25.Top=578, Get_DtIncs/etc.Top=574
991:         *--------------------------------------------------------------------------
992:         loc_oPagina.AddObject("lbl_4c_Label20", "Label")
993:         WITH loc_oPagina.lbl_4c_Label20
994:             .Caption   = "Data / Usu" + CHR(225) + "rio"
995:             .Top       = 582     && 553+29
996:             .Left      = 11
997:             .Width     = 84
998:             .Height    = 15
999:             .FontName  = "Tahoma"
1000:             .FontSize  = 8
1001:             .ForeColor = RGB(90, 90, 90)
1002:             .BackStyle = 0
1003:             .Visible   = .T.
1004:         ENDWITH
1005: 
1006:         loc_oPagina.AddObject("lbl_4c_Label24", "Label")
1007:         WITH loc_oPagina.lbl_4c_Label24
1008:             .Caption   = "Inclus" + CHR(227) + "o :"
1009:             .Top       = 607     && 578+29
1010:             .Left      = 10
1011:             .Width     = 49
1012:             .Height    = 15
1013:             .FontName  = "Tahoma"
1014:             .FontSize  = 8
1015:             .ForeColor = RGB(90, 90, 90)
1016:             .BackStyle = 0
1017:             .Visible   = .T.
1018:         ENDWITH
1019: 
1020:         loc_oPagina.AddObject("txt_4c_DtIncs", "TextBox")
1021:         WITH loc_oPagina.txt_4c_DtIncs
1022:             .Value     = {}
1023:             .Top       = 603     && 574+29
1024:             .Left      = 67
1025:             .Width     = 79
1026:             .Height    = 23
1027:             .FontName  = "Tahoma"
1028:             .FontSize  = 8
1029:             .ReadOnly  = .T.
1030:             .Visible   = .T.
1031:         ENDWITH
1032: 
1033:         loc_oPagina.AddObject("txt_4c_Usuario", "TextBox")
1034:         WITH loc_oPagina.txt_4c_Usuario
1035:             .Value     = ""
1036:             .MaxLength = 20
1037:             .Top       = 603     && 574+29
1038:             .Left      = 148
1039:             .Width     = 79
1040:             .Height    = 23
1041:             .FontName  = "Tahoma"
1042:             .FontSize  = 8
1043:             .ReadOnly  = .T.
1044:             .Visible   = .T.
1045:         ENDWITH
1046: 
1047:         loc_oPagina.AddObject("lbl_4c_Label25", "Label")
1048:         WITH loc_oPagina.lbl_4c_Label25
1049:             .Caption   = "Altera" + CHR(231) + CHR(227) + "o :"
1050:             .Top       = 607     && 578+29
1051:             .Left      = 251
1052:             .Width     = 55
1053:             .Height    = 15
1054:             .FontName  = "Tahoma"
1055:             .FontSize  = 8
1056:             .ForeColor = RGB(90, 90, 90)
1057:             .BackStyle = 0
1058:             .Visible   = .T.
1059:         ENDWITH
1060: 
1061:         loc_oPagina.AddObject("txt_4c_DataAlts", "TextBox")
1062:         WITH loc_oPagina.txt_4c_DataAlts
1063:             .Value     = {}
1064:             .Top       = 603     && 574+29
1065:             .Left      = 319
1066:             .Width     = 79
1067:             .Height    = 23
1068:             .FontName  = "Tahoma"
1069:             .FontSize  = 8
1070:             .ReadOnly  = .T.
1071:             .Visible   = .T.
1072:         ENDWITH
1073: 
1074:         loc_oPagina.AddObject("txt_4c_UsuaAlts", "TextBox")
1075:         WITH loc_oPagina.txt_4c_UsuaAlts
1076:             .Value     = ""
1077:             .MaxLength = 20
1078:             .Top       = 603     && 574+29
1079:             .Left      = 400
1080:             .Width     = 79
1081:             .Height    = 23
1082:             .FontName  = "Tahoma"
1083:             .FontSize  = 8
1084:             .ReadOnly  = .T.
1085:             .Visible   = .T.
1086:         ENDWITH
1087: 
1088:         *-- Vincular eventos Page2 (botoes Salvar/Cancelar)
1089:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
1090:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
1091: 
1092:         *-- Vincular validacao/lookup campos header
1093:         BINDEVENT(loc_oPagina.txt_4c_Ano,    "KeyPress", THIS, "ValidarAnoMtz")
1094:         BINDEVENT(loc_oPagina.txt_4c_Sgrupo, "KeyPress", THIS, "ValidarGrupoMtz")
1095:         BINDEVENT(loc_oPagina.txt_4c_Sconta, "KeyPress", THIS, "ValidarContaMtz")
1096:         BINDEVENT(loc_oPagina.txt_4c_Moeda,  "KeyPress", THIS, "ValidarMoedaMtz")
1097:         BINDEVENT(loc_oPagina.txt_4c_Sgrupo, "KeyPress",  THIS, "TeclaF4Sgrupo")
1098:         BINDEVENT(loc_oPagina.txt_4c_Sconta, "KeyPress",  THIS, "TeclaF4Sconta")
1099:         BINDEVENT(loc_oPagina.txt_4c_Moeda,  "KeyPress",  THIS, "TeclaF4Moeda")
1100: 
1101:         *-- Vincular eventos da grade e botoes de linha
1102:         BINDEVENT(loc_oPagina.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
1103:         BINDEVENT(loc_oPagina.cnt_4c_InsFtc.cmd_4c_InserirLinha, "Click", THIS, "BtnInserirLinhaClick")
1104:         BINDEVENT(loc_oPagina.cnt_4c_InsFtc.cmd_4c_ExcluirLinha, "Click", THIS, "BtnExcluirLinhaClick")
1105: 
1106:         THIS.TornarControlesVisiveis(loc_oPagina)
1107:     ENDPROC
1108: 
1109:     *-- =========================================================================

*-- Linhas 1130 a 1144:
1130:                 loc_oGrid.Column5.ControlSource   = "cursor_4c_Dados.sDContas"
1131:                 loc_oGrid.Column6.ControlSource   = "cursor_4c_Dados.Moeda"
1132:                 loc_oGrid.Column7.ControlSource   = "cursor_4c_Dados.Inativas"
1133:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1134:                 loc_oGrid.Column2.Header1.Caption = "Ano"
1135:                 loc_oGrid.Column3.Header1.Caption = "Grupo"
1136:                 loc_oGrid.Column4.Header1.Caption = "Conta"
1137:                 loc_oGrid.Column5.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1138:                 loc_oGrid.Column6.Header1.Caption = "Moeda"
1139:                 loc_oGrid.Column7.Header1.Caption = "Valida"
1140:                 THIS.FormatarGridLista(loc_oGrid)
1141:                 loc_lResultado = .T.
1142:             ENDIF
1143: 
1144:         CATCH TO loc_oErro

*-- Linhas 1307 a 1316:
1307:             ENDIF
1308: 
1309:             *-- Botoes Confirmar/Cancelar
1310:             loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEdicao
1311:             loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = par_lHabilitar
1312: 
1313:             *-- Campos readonly sempre
1314:             loc_oPagina.txt_4c_Sdconta.ReadOnly    = .T.
1315:             loc_oPagina.txt_4c_ValorTotal.ReadOnly = .T.
1316:             loc_oPagina.txt_4c_DtIncs.ReadOnly     = .T.

*-- Linhas 1333 a 1345:
1333:         TRY
1334:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1335:             IF THIS.this_cModoAtual = "VISUALIZAR"
1336:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
1337:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1338:             ELSE
1339:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
1340:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1341:             ENDIF
1342:         CATCH TO loc_oErro
1343:             MsgErro(loc_oErro.Message, "Formmtz.AjustarBotoesPorModo")
1344:         ENDTRY
1345:     ENDPROC

*-- Linhas 1514 a 1528:
1514:                             loc_oGrid.Column5.ControlSource   = "cursor_4c_Dados.sDContas"
1515:                             loc_oGrid.Column6.ControlSource   = "cursor_4c_Dados.Moeda"
1516:                             loc_oGrid.Column7.ControlSource   = "cursor_4c_Dados.Inativas"
1517:                             loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1518:                             loc_oGrid.Column2.Header1.Caption = "Ano"
1519:                             loc_oGrid.Column3.Header1.Caption = "Grupo"
1520:                             loc_oGrid.Column4.Header1.Caption = "Conta"
1521:                             loc_oGrid.Column5.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1522:                             loc_oGrid.Column6.Header1.Caption = "Moeda"
1523:                             loc_oGrid.Column7.Header1.Caption = "Valida"
1524:                             THIS.FormatarGridLista(loc_oGrid)
1525:                         ENDIF
1526:                     ENDIF
1527:                 ENDIF
1528: 


### BO (C:\4c\projeto\app\classes\mtzBO.prg):
*******************************************************************************
* mtzBO.prg - Business Object: Matriz de Saldos por Centro de Custo
* Tabela principal : SigCdMtz  (cabecalho da matriz)
* Tabela detalhe   : SigCdMtI  (linhas de centro de custo / meses)
* Herda de         : BusinessBase
*******************************************************************************

DEFINE CLASS mtzBO AS BusinessBase

    *-- =========================================================================
    *-- PROPRIEDADES: SigCdMtz (cabecalho)
    *-- =========================================================================

    *-- Chave usuario (char 3 - gerada por GerarProximoCodigo na insercao)
    this_cCodigo    = ""

    *-- Ano de competencia da matriz (char 4, ex: "2026")
    this_cAno       = ""

    *-- Grupo de conta corrente (SigCdGcr.Codigos)
    this_cSGrupos   = ""

    *-- Conta de centro de custo (SigCdCli.IClis)
    this_cSContas   = ""

    *-- Flag inativa (0=ativa / 1=inativa -> convertido para .T./.F.)
    this_lInativas  = .F.

    *-- Moeda da matriz (SigCdMoe.CMoes, char 4)
    this_cMoeda     = ""

    *-- Auditoria de inclusao
    this_tDtIncs    = {}
    this_cUsuIncs   = ""

    *-- Auditoria de alteracao
    this_tDtAlts    = {}
    this_cUsuAlts   = ""

    *-- =========================================================================
    *-- PROPRIEDADES DERIVADAS / AUXILIARES (nao armazenadas diretamente)
    *-- =========================================================================

    *-- Descricao da conta - derivada do JOIN: SigCdCli.rclis AS sDContas
    *-- Nao existe como coluna em SigCdMtz; carregada via SELECT com JOIN
    this_cSDesconta = ""

    *-- Valor total acumulado dos meses de SigCdMtI (calculado, exibicao)
    this_nValorTotal = 0

    *-- =========================================================================
    *-- INIT
    *-- =========================================================================

    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigCdMtz"
            THIS.this_cCampoChave = "Codigo"

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- OBTER CHAVE PRIMARIA (requerido pelo sistema de auditoria)
    *-- =========================================================================

    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDFUNC

    *-- =========================================================================
    *-- NOVO REGISTRO - Gera codigo unico para insercao
    *-- =========================================================================

    FUNCTION NovoRegistro()
        LOCAL loc_lResultado, loc_nProximo
        loc_lResultado = DODEFAULT()

        IF loc_lResultado
            TRY
                loc_nProximo = THIS.GerarProximoCodigo()
                IF loc_nProximo > 0
                    THIS.this_cCodigo = ALLTRIM(STR(loc_nProximo, 3))
                ELSE
                    MsgErro("Imposs" + CHR(237) + "vel gerar c" + CHR(243) + "digo para nova matriz.", "mtzBO.NovoRegistro")
                    loc_lResultado = .F.
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "mtzBO.NovoRegistro")
                loc_lResultado = .F.
            ENDTRY
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- GERAR PROXIMO CODIGO (PROTECTED) - MAX(Codigo)+1 em SigCdMtz
    *-- =========================================================================

    PROTECTED FUNCTION GerarProximoCodigo()
        LOCAL loc_cSQL, loc_nResult, loc_nProximo
        loc_nProximo = 0

        TRY
            loc_cSQL = "SELECT ISNULL(MAX(CAST(LTRIM(Codigo) AS INT)), 0) + 1 AS ProximoCodigo" + ;
                       " FROM SigCdMtz" + ;
                       " WHERE ISNUMERIC(LTRIM(Codigo)) = 1"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ProxCod")
                TABLEREVERT(.T., "cursor_4c_ProxCod")
                USE IN cursor_4c_ProxCod
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProxCod")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ProxCod") > 0
                SELECT cursor_4c_ProxCod
                loc_nProximo = NVL(ProximoCodigo, 1)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.GerarProximoCodigo")
        ENDTRY

        IF USED("cursor_4c_ProxCod")
            USE IN cursor_4c_ProxCod
        ENDIF

        RETURN loc_nProximo
    ENDFUNC

    *-- =========================================================================
    *-- BUSCAR - SELECT para grid Page1 (lista de matrizes)
    *-- =========================================================================

    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.Codigo, a.Ano, a.sGrupos, a.sContas," + ;
                       " b.rclis AS sDContas, a.Moeda, a.Inativas," + ;
                       " a.DtIncs, a.UsuIncs" + ;
                       " FROM SigCdMtz a" + ;
                       " LEFT JOIN SigCdCli b ON a.sContas = b.IClis" + ;
                       " ORDER BY a.Ano, a.sGrupos, a.sContas"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = "SELECT a.Codigo, a.Ano, a.sGrupos, a.sContas," + ;
                           " b.rclis AS sDContas, a.Moeda, a.Inativas," + ;
                           " a.DtIncs, a.UsuIncs" + ;
                           " FROM SigCdMtz a" + ;
                           " LEFT JOIN SigCdCli b ON a.sContas = b.IClis" + ;
                           " WHERE " + par_cFiltro + ;
                           " ORDER BY a.Ano, a.sGrupos, a.sContas"
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro(CapturarErroSQL(), "mtzBO.Buscar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.Buscar")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- CARREGAR POR CODIGO - Carrega registro SigCdMtz no BO
    *-- =========================================================================

    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.Codigo, a.Ano, a.sGrupos, a.sContas," + ;
                       " b.rclis AS sDContas, a.Moeda, a.Inativas," + ;
                       " a.DtIncs, a.UsuIncs, a.DtAlts, a.UsuAlts, a.CidChaves" + ;
                       " FROM SigCdMtz a" + ;
                       " LEFT JOIN SigCdCli b ON a.sContas = b.IClis" + ;
                       " WHERE a.Codigo = " + EscaparSQL(par_cCodigo)

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
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- CARREGAR DO CURSOR - Mapeia cursor para propriedades do BO
    *-- =========================================================================

    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo    = TratarNulo(Codigo, "C")
            THIS.this_cAno       = TratarNulo(Ano, "C")
            THIS.this_cSGrupos   = TratarNulo(sGrupos, "C")
            THIS.this_cSContas   = TratarNulo(sContas, "C")
            THIS.this_cSDesconta = TratarNulo(sDContas, "C")
            THIS.this_cMoeda     = TratarNulo(Moeda, "C")
            IF VARTYPE(Inativas) = "L"
                THIS.this_lInativas = Inativas
            ELSE
                THIS.this_lInativas = (NVL(Inativas, 0) = 1)
            ENDIF
            THIS.this_tDtIncs    = TratarNulo(DtIncs, "T")
            THIS.this_cUsuIncs   = TratarNulo(UsuIncs, "C")
            THIS.this_tDtAlts    = TratarNulo(DtAlts, "T")
            THIS.this_cUsuAlts   = TratarNulo(UsuAlts, "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- CARREGAR DETALHE - Carrega SigCdMtI para cursor_4c_MtI (grid Page2)
    *-- =========================================================================

    FUNCTION CarregarDetalhe(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_MtI")
                USE IN cursor_4c_MtI
            ENDIF

            loc_cSQL = "SELECT a.Codigo, a.CidChaves, a.Grupos, a.Contas," + ;
                       " a.Val_Jan, a.Val_Fev, a.Val_Mar, a.Val_Abr," + ;
                       " a.Val_Mai, a.Val_Jun, a.Val_Jul, a.Val_Ago," + ;
                       " a.Val_Set, a.Val_Out, a.Val_Nov, a.Val_Dez," + ;
                       " a.Acm_Jan, a.Acm_Fev, a.Acm_Mar, a.Acm_Abr," + ;
                       " a.Acm_Mai, a.Acm_Jun, a.Acm_Jul, a.Acm_Ago," + ;
                       " a.Acm_Set, a.Acm_Out, a.Acm_Nov, a.Acm_Dez," + ;
                       " (a.Val_Jan+a.Val_Fev+a.Val_Mar+a.Val_Abr+a.Val_Mai+a.Val_Jun+" + ;
                       "  a.Val_Jul+a.Val_Ago+a.Val_Set+a.Val_Out+a.Val_Nov+a.Val_Dez)" + ;
                       " AS Total, a.ChkValida" + ;
                       " FROM SigCdMtI a" + ;
                       " WHERE a.Codigo = " + EscaparSQL(par_cCodigo) + ;
                       " ORDER BY a.Grupos, a.Contas"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_MtI")
                TABLEREVERT(.T., "cursor_4c_MtI")
                USE IN cursor_4c_MtI
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MtI")
            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro(CapturarErroSQL(), "mtzBO.CarregarDetalhe")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.CarregarDetalhe")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- CRIAR CURSOR DETALHE VAZIO - Cria cursor_4c_MtI vazio para insercao
    *-- =========================================================================

    FUNCTION CriarCursorDetalheVazio(par_cCodigo)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_MtI")
                USE IN cursor_4c_MtI
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_MtI ( ;
                Codigo    C(3), ;
                CidChaves C(36), ;
                Grupos    C(10), ;
                Contas    C(10), ;
                Val_Jan   N(14,2), ;
                Val_Fev   N(14,2), ;
                Val_Mar   N(14,2), ;
                Val_Abr   N(14,2), ;
                Val_Mai   N(14,2), ;
                Val_Jun   N(14,2), ;
                Val_Jul   N(14,2), ;
                Val_Ago   N(14,2), ;
                Val_Set   N(14,2), ;
                Val_Out   N(14,2), ;
                Val_Nov   N(14,2), ;
                Val_Dez   N(14,2), ;
                Acm_Jan   N(14,2), ;
                Acm_Fev   N(14,2), ;
                Acm_Mar   N(14,2), ;
                Acm_Abr   N(14,2), ;
                Acm_Mai   N(14,2), ;
                Acm_Jun   N(14,2), ;
                Acm_Jul   N(14,2), ;
                Acm_Ago   N(14,2), ;
                Acm_Set   N(14,2), ;
                Acm_Out   N(14,2), ;
                Acm_Nov   N(14,2), ;
                Acm_Dez   N(14,2), ;
                Total     N(18,2), ;
                ChkValida L ;
            )
            SET NULL OFF

            *-- Adiciona linha em branco inicial para o usuario comecar a inserir
            INSERT INTO cursor_4c_MtI (Codigo, CidChaves, Grupos, Contas, ;
                Val_Jan, Val_Fev, Val_Mar, Val_Abr, Val_Mai, Val_Jun, ;
                Val_Jul, Val_Ago, Val_Set, Val_Out, Val_Nov, Val_Dez, ;
                Acm_Jan, Acm_Fev, Acm_Mar, Acm_Abr, Acm_Mai, Acm_Jun, ;
                Acm_Jul, Acm_Ago, Acm_Set, Acm_Out, Acm_Nov, Acm_Dez, ;
                Total, ChkValida) ;
                VALUES (par_cCodigo, "", "", "", ;
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ;
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ;
                0, .F.)

            GO TOP IN cursor_4c_MtI
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.CriarCursorDetalheVazio")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- INSERIR LINHA DETALHE - Adiciona linha em branco no cursor_4c_MtI
    *-- =========================================================================

    FUNCTION InserirLinhaDetalhe(par_cCodigo)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_MtI")
                *-- Verifica se ja existe uma linha vazia (sem Grupos e Contas)
                SELECT cursor_4c_MtI
                GO TOP
                LOCATE FOR EMPTY(ALLTRIM(Grupos)) AND EMPTY(ALLTRIM(Contas))
                IF !FOUND()
                    INSERT INTO cursor_4c_MtI (Codigo, CidChaves, Grupos, Contas, ;
                        Val_Jan, Val_Fev, Val_Mar, Val_Abr, Val_Mai, Val_Jun, ;
                        Val_Jul, Val_Ago, Val_Set, Val_Out, Val_Nov, Val_Dez, ;
                        Acm_Jan, Acm_Fev, Acm_Mar, Acm_Abr, Acm_Mai, Acm_Jun, ;
                        Acm_Jul, Acm_Ago, Acm_Set, Acm_Out, Acm_Nov, Acm_Dez, ;
                        Total, ChkValida) ;
                        VALUES (par_cCodigo, "", "", "", ;
                        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ;
                        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ;
                        0, .F.)
                ENDIF
                GO BOTTOM IN cursor_4c_MtI
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.InserirLinhaDetalhe")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- EXCLUIR LINHA DETALHE - Remove linha atual do cursor_4c_MtI
    *-- =========================================================================

    FUNCTION ExcluirLinhaDetalhe()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_MtI") AND !EOF("cursor_4c_MtI")
                SELECT cursor_4c_MtI
                IF !EOF()
                    DELETE
                ENDIF
                IF !EOF()
                    SKIP
                    SKIP -1
                ENDIF
                GO BOTTOM IN cursor_4c_MtI
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.ExcluirLinhaDetalhe")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- ATUALIZAR TOTAL - Calcula Total na linha do cursor_4c_MtI
    *-- =========================================================================

    FUNCTION AtualizarTotal(par_cChave)
        LOCAL loc_nTotal, loc_nTotalGeral, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_MtI")
                IF !EMPTY(ALLTRIM(par_cChave))
                    SELECT cursor_4c_MtI
                    LOCATE FOR ALLTRIM(CidChaves) == ALLTRIM(par_cChave)
                    IF FOUND()
                        loc_nTotal = NVL(Val_Jan, 0) + NVL(Val_Fev, 0) + NVL(Val_Mar, 0) + ;
                                     NVL(Val_Abr, 0) + NVL(Val_Mai, 0) + NVL(Val_Jun, 0) + ;
                                     NVL(Val_Jul, 0) + NVL(Val_Ago, 0) + NVL(Val_Set, 0) + ;
                                     NVL(Val_Out, 0) + NVL(Val_Nov, 0) + NVL(Val_Dez, 0)
                        REPLACE Total WITH loc_nTotal IN cursor_4c_MtI ;
                            FOR ALLTRIM(CidChaves) == ALLTRIM(par_cChave)
                    ENDIF
                ENDIF

                *-- Calcula total geral de todas as linhas
                SELECT SUM(NVL(Total, 0)) AS TotalGeral FROM cursor_4c_MtI INTO CURSOR cursor_4c_TmpTot READWRITE
                SELECT cursor_4c_TmpTot
                THIS.this_nValorTotal = NVL(TotalGeral, 0)
                USE IN cursor_4c_TmpTot

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.AtualizarTotal")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- VALIDAR DUPLICATAS - Verifica Grupos+Contas duplicados no cursor_4c_MtI
    *-- =========================================================================

    FUNCTION ValidarDuplicatas()
        LOCAL loc_lValido, loc_lResultado
        loc_lValido = .T.
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_MtI")
                SELECT COUNT(*) AS Qtds, Grupos, Contas ;
                    FROM cursor_4c_MtI ;
                    WHERE !EMPTY(ALLTRIM(Contas)) AND !EMPTY(ALLTRIM(Grupos)) ;
                    GROUP BY Grupos, Contas ;
                    HAVING COUNT(*) >= 2 ;
                    INTO CURSOR cursor_4c_Dup READWRITE

                SELECT cursor_4c_Dup
                IF RECCOUNT("cursor_4c_Dup") > 0
                    MsgErro("H" + CHR(225) + " registros duplicados na grade de Contas, Verifique.", "Aviso")
                    loc_lValido = .F.
                ENDIF

                IF USED("cursor_4c_Dup")
                    USE IN cursor_4c_Dup
                ENDIF
                loc_lResultado = loc_lValido
            ELSE
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.ValidarDuplicatas")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- INSERIR (PROTECTED) - INSERT SigCdMtz + SigCdMtI via cursor_4c_MtI
    *-- =========================================================================

    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdMtz" + ;
                       " (Codigo, Ano, sGrupos, sContas, Moeda, Inativas," + ;
                       "  DtIncs, UsuIncs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigo) + "," + ;
                       EscaparSQL(THIS.this_cAno) + "," + ;
                       EscaparSQL(THIS.this_cSGrupos) + "," + ;
                       EscaparSQL(THIS.this_cSContas) + "," + ;
                       EscaparSQL(THIS.this_cMoeda) + "," + ;
                       IIF(THIS.this_lInativas, "1", "0") + "," + ;
                       "GETDATE()," + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_lResultado = THIS.SalvarDetalhe(THIS.this_cCodigo, .T.)
                IF loc_lResultado
                    THIS.RegistrarAuditoria("INSERT")
                ENDIF
            ELSE
                MsgErro(CapturarErroSQL(), "mtzBO.Inserir")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.Inserir")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- ATUALIZAR (PROTECTED) - UPDATE SigCdMtz + re-inserir SigCdMtI
    *-- =========================================================================

    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdMtz SET" + ;
                       " Ano = " + EscaparSQL(THIS.this_cAno) + "," + ;
                       " sGrupos = " + EscaparSQL(THIS.this_cSGrupos) + "," + ;
                       " sContas = " + EscaparSQL(THIS.this_cSContas) + "," + ;
                       " Moeda = " + EscaparSQL(THIS.this_cMoeda) + "," + ;
                       " Inativas = " + IIF(THIS.this_lInativas, "1", "0") + "," + ;
                       " DtAlts = GETDATE()," + ;
                       " UsuAlts = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                       " WHERE Codigo = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_lResultado = THIS.SalvarDetalhe(THIS.this_cCodigo, .F.)
                IF loc_lResultado
                    THIS.RegistrarAuditoria("UPDATE")
                ENDIF
            ELSE
                MsgErro(CapturarErroSQL(), "mtzBO.Atualizar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.Atualizar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- EXECUTAR EXCLUSAO (PROTECTED) - DELETE SigCdMtz + SigCdMtI
    *-- =========================================================================

    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- DELETE SigCdMtI (detalhe) primeiro por FK
            loc_cSQL = "DELETE FROM SigCdMtI WHERE Codigo = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                loc_cSQL = "DELETE FROM SigCdMtz WHERE Codigo = " + EscaparSQL(THIS.this_cCodigo)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro(CapturarErroSQL(), "mtzBO.ExecutarExclusao (SigCdMtz)")
                ENDIF
            ELSE
                MsgErro(CapturarErroSQL(), "mtzBO.ExecutarExclusao (SigCdMtI)")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- SALVAR DETALHE (PROTECTED) - INSERT SigCdMtI a partir de cursor_4c_MtI
    *-- =========================================================================

    PROTECTED FUNCTION SalvarDetalhe(par_cCodigo, par_lSomenteInserir)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        LOCAL loc_cGrupos, loc_cContas, loc_cChave
        LOCAL loc_nJan, loc_nFev, loc_nMar, loc_nAbr, loc_nMai, loc_nJun
        LOCAL loc_nJul, loc_nAgo, loc_nSet, loc_nOut, loc_nNov, loc_nDez
        loc_lResultado = .F.

        TRY
            IF !par_lSomenteInserir
                loc_cSQL = "DELETE FROM SigCdMtI WHERE Codigo = " + EscaparSQL(par_cCodigo)
                SQLEXEC(gnConnHandle, loc_cSQL)
            ENDIF

            loc_lResultado = .T.

            IF USED("cursor_4c_MtI")
                SELECT cursor_4c_MtI
                GO TOP
                SCAN FOR !EMPTY(ALLTRIM(Grupos)) AND !EMPTY(ALLTRIM(Contas))
                    loc_cGrupos = ALLTRIM(Grupos)
                    loc_cContas = ALLTRIM(Contas)
                    loc_cChave  = ALLTRIM(CidChaves)
                    loc_nJan    = NVL(Val_Jan, 0)
                    loc_nFev    = NVL(Val_Fev, 0)
                    loc_nMar    = NVL(Val_Mar, 0)
                    loc_nAbr    = NVL(Val_Abr, 0)
                    loc_nMai    = NVL(Val_Mai, 0)
                    loc_nJun    = NVL(Val_Jun, 0)
                    loc_nJul    = NVL(Val_Jul, 0)
                    loc_nAgo    = NVL(Val_Ago, 0)
                    loc_nSet    = NVL(Val_Set, 0)
                    loc_nOut    = NVL(Val_Out, 0)
                    loc_nNov    = NVL(Val_Nov, 0)
                    loc_nDez    = NVL(Val_Dez, 0)

                    IF EMPTY(loc_cChave)
                        loc_cChave = ALLTRIM(SYS(2015)) + ALLTRIM(STR(SECONDS(), 10, 0))
                    ENDIF

                    loc_cSQL = "INSERT INTO SigCdMtI" + ;
                               " (Codigo, CidChaves, Grupos, Contas," + ;
                               "  Val_Jan, Val_Fev, Val_Mar, Val_Abr," + ;
                               "  Val_Mai, Val_Jun, Val_Jul, Val_Ago," + ;
                               "  Val_Set, Val_Out, Val_Nov, Val_Dez)" + ;
                               " VALUES (" + ;
                               EscaparSQL(par_cCodigo) + "," + ;
                               EscaparSQL(loc_cChave) + "," + ;
                               EscaparSQL(loc_cGrupos) + "," + ;
                               EscaparSQL(loc_cContas) + "," + ;
                               FormatarNumeroSQL(loc_nJan) + "," + ;
                               FormatarNumeroSQL(loc_nFev) + "," + ;
                               FormatarNumeroSQL(loc_nMar) + "," + ;
                               FormatarNumeroSQL(loc_nAbr) + "," + ;
                               FormatarNumeroSQL(loc_nMai) + "," + ;
                               FormatarNumeroSQL(loc_nJun) + "," + ;
                               FormatarNumeroSQL(loc_nJul) + "," + ;
                               FormatarNumeroSQL(loc_nAgo) + "," + ;
                               FormatarNumeroSQL(loc_nSet) + "," + ;
                               FormatarNumeroSQL(loc_nOut) + "," + ;
                               FormatarNumeroSQL(loc_nNov) + "," + ;
                               FormatarNumeroSQL(loc_nDez) + ")"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResult < 0
                        MsgErro(CapturarErroSQL(), "mtzBO.SalvarDetalhe (linha " + loc_cGrupos + "/" + loc_cContas + ")")
                        loc_lResultado = .F.
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.SalvarDetalhe")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- VERIFICAR DUPLICADO - Verifica se Ano+Grupo+Conta ja existe em SigCdMtz
    *-- =========================================================================

    FUNCTION VerificarDuplicado(par_cAno, par_cGrupo, par_cConta)
        LOCAL loc_cSQL, loc_nResult, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS Qtd FROM SigCdMtz" + ;
                       " WHERE Ano = " + EscaparSQL(par_cAno) + ;
                       " AND sGrupos = " + EscaparSQL(par_cGrupo) + ;
                       " AND sContas = " + EscaparSQL(par_cConta)

            IF !EMPTY(ALLTRIM(THIS.this_cCodigo)) AND !THIS.this_lNovoRegistro
                loc_cSQL = loc_cSQL + ;
                           " AND Codigo <> " + EscaparSQL(THIS.this_cCodigo)
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ChkMtz")
                TABLEREVERT(.T., "cursor_4c_ChkMtz")
                USE IN cursor_4c_ChkMtz
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkMtz")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ChkMtz") > 0
                SELECT cursor_4c_ChkMtz
                loc_lExiste = (NVL(Qtd, 0) > 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.VerificarDuplicado")
        ENDTRY

        IF USED("cursor_4c_ChkMtz")
            USE IN cursor_4c_ChkMtz
        ENDIF

        RETURN loc_lExiste
    ENDFUNC

    *-- =========================================================================
    *-- DESTRUIR - Fecha cursores abertos pelo BO
    *-- =========================================================================

    PROCEDURE Destroy()
        IF USED("cursor_4c_MtI")
            USE IN cursor_4c_MtI
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

