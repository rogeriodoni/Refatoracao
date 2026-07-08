# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [FONTNAME-ERRADO] Linha 245: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 267: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 290: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrecrf.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1688 linhas total):

*-- Linhas 82 a 90:
82:         loc_lSucesso   = .F.
83:         loc_lContinuar = .T.
84:         TRY
85:             THIS.Caption = "Rela" + CHR(231) + CHR(227) + "o de Contagem por " + ;
86:                            "Refer" + CHR(234) + "ncia"
87: 
88:             IF TYPE("gc_4c_CaminhoIcones") = "U"
89:                 gc_4c_CaminhoIcones = ""
90:             ENDIF

*-- Linhas 126 a 135:
126:                 *-- Inicializar filtros com valores padrao (data = hoje)
127:                 THIS.LimparCampos()
128: 
129:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
130:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
131: 
132:                 THIS.Visible = .T.
133:                 loc_lSucesso = .T.
134:             ENDIF
135:         CATCH TO loc_oErro

*-- Linhas 149 a 190:
149:     PROTECTED PROCEDURE ConfigurarCabecalho()
150:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
151:         WITH THIS.cnt_4c_Cabecalho
152:             .Top         = 0
153:             .Left        = 0
154:             .Width       = THIS.Width
155:             .Height      = 80
156:             .BackStyle   = 1
157:             .BackColor   = RGB(100, 100, 100)
158:             .BorderWidth = 0
159:             .Visible     = .T.
160: 
161:             *-- Sombra deslocada 2px para efeito 3D do texto branco
162:             .AddObject("lbl_4c_Sombra", "Label")
163:             WITH .lbl_4c_Sombra
164:                 .Top       = 22
165:                 .Left      = 22
166:                 .Width     = THIS.Width
167:                 .Height    = 30
168:                 .Caption   = "Rela" + CHR(231) + CHR(227) + "o de Contagem por " + ;
169:                              "Refer" + CHR(234) + "ncia"
170:                 .FontName  = "Tahoma"
171:                 .FontSize  = 14
172:                 .FontBold  = .T.
173:                 .ForeColor = RGB(0, 0, 0)
174:                 .BackStyle = 0
175:                 .Visible   = .T.
176:             ENDWITH
177: 
178:             *-- Titulo em branco (sobre a sombra)
179:             .AddObject("lbl_4c_Titulo", "Label")
180:             WITH .lbl_4c_Titulo
181:                 .Top       = 20
182:                 .Left      = 20
183:                 .Width     = THIS.Width
184:                 .Height    = 30
185:                 .Caption   = "Rela" + CHR(231) + CHR(227) + "o de Contagem por " + ;
186:                              "Refer" + CHR(234) + "ncia"
187:                 .FontName  = "Tahoma"
188:                 .FontSize  = 14
189:                 .FontBold  = .T.
190:                 .ForeColor = RGB(255, 255, 255)

*-- Linhas 196 a 229:
196: 
197:     *--------------------------------------------------------------------------
198:     * ConfigurarBotoes - CommandGroup com botoes de relatorio (btnReport area)
199:     *   Original: btnReport.Top=0, Left=528, ButtonCount=4
200:     *   Botoes: Visualizar(6), Imprimir(72), DocExcel(138), Sair(204) - W=65
201:     *   Eventos Click vinculados em ConfigurarPaginaDados (Fase 7/8).
202:     *--------------------------------------------------------------------------
203:     PROTECTED PROCEDURE ConfigurarBotoes()
204:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
205:         WITH THIS.cmg_4c_Botoes
206:             .Top           = 0
207:             .Left          = 529
208:             .Width         = 273
209:             .Height        = 80
210:             .ButtonCount   = 4
211:             .BackStyle     = 0
212:             .BorderStyle   = 0
213:             .BorderColor   = RGB(136, 189, 188)
214:             .SpecialEffect = 1
215:             .Themes        = .F.
216:             .Visible       = .T.
217: 
218:             *-- Visualizar (preview em tela)
219:             WITH .Buttons(1)
220:                 .Top             = 5
221:                 .Left            = 5
222:                 .Width           = 65
223:                 .Height          = 70
224:                 .Caption         = "Visualizar"
225:                 .FontBold        = .T.
226:                 .FontItalic      = .T.
227:                 .BackColor       = RGB(255, 255, 255)
228:                 .ForeColor       = RGB(90, 90, 90)
229:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 237 a 251:
237: 
238:             *-- Imprimir (impressora com dialogo)
239:             WITH .Buttons(2)
240:                 .Top             = 5
241:                 .Left            = 71
242:                 .Width           = 65
243:                 .Height          = 70
244:                 .Caption         = "Imprimir"
245:                 .FontName        = "Comic Sans MS"
246:                 .FontBold        = .T.
247:                 .FontItalic      = .T.
248:                 .FontSize        = 8
249:                 .BackColor       = RGB(255, 255, 255)
250:                 .ForeColor       = RGB(90, 90, 90)
251:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"

*-- Linhas 259 a 273:
259: 
260:             *-- Excel (documento)
261:             WITH .Buttons(3)
262:                 .Top             = 5
263:                 .Left            = 137
264:                 .Width           = 65
265:                 .Height          = 70
266:                 .Caption         = "Excel"
267:                 .FontName        = "Comic Sans MS"
268:                 .FontBold        = .T.
269:                 .FontItalic      = .T.
270:                 .FontSize        = 8
271:                 .BackColor       = RGB(255, 255, 255)
272:                 .ForeColor       = RGB(90, 90, 90)
273:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"

*-- Linhas 281 a 296:
281: 
282:             *-- Encerrar (fechar form - Cancel=.T. dispara no ESC)
283:             WITH .Buttons(4)
284:                 .Top             = 5
285:                 .Left            = 203
286:                 .Width           = 65
287:                 .Height          = 70
288:                 .Caption         = "Encerrar"
289:                 .Cancel          = .T.
290:                 .FontName        = "Comic Sans MS"
291:                 .FontBold        = .T.
292:                 .FontItalic      = .T.
293:                 .FontSize        = 8
294:                 .BackColor       = RGB(255, 255, 255)
295:                 .ForeColor       = RGB(90, 90, 90)
296:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"

*-- Linhas 318 a 333:
318:         *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
319:         loc_oPgf.PageCount = 1
320: 
321:         loc_oPgf.Top    = 85
322:         loc_oPgf.Left   = -1
323:         loc_oPgf.Width  = THIS.Width + 2
324:         loc_oPgf.Height = THIS.Height - 85
325:         loc_oPgf.Tabs   = .F.
326: 
327:         *-- Configurar Page1 (FORA de qualquer WITH - usar referencia direta)
328:         loc_oPgf.Page1.Caption   = "Filtros"
329:         loc_oPgf.Page1.FontName  = "Tahoma"
330:         loc_oPgf.Page1.FontSize  = 8
331:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
332:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
333:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 347 a 355:
347:     *   CRUD esta seria a pagina de Lista; aqui eh a pagina de Filtros do REPORT.
348:     *
349:     *   Migrado do layout flat do SIGRECNT (form de 800x269).
350:     *   Posicoes top = original - 85 (PageFrame.Top=85).
351:     *   Linha 1: Data (txt_4c_Datas) + Codigo referencia (txt_4c_Codigo)
352:     *   Linha 2: Vendedor - codigo (txt_4c_Conta) + descricao (txt_4c_DConta)
353:     *   Linha 3: Grupo Estoque - cod (txt_4c_Cd_GrEstoque) + ds (txt_4c_Ds_GrEstoque)
354:     *   Linha 4: Conta Estoque - cod (txt_4c_Cd_Estoque) + ds (txt_4c_Ds_Estoque)
355:     *   Linha 5: Produto - cod (txt_4c__Produto) + ds (txt_4c__descricao)

*-- Linhas 361 a 418:
361: 
362:         *--------------------------------------------------------------------
363:         *-- Linha 1: Data e Codigo de referencia
364:         *   Original: Label1.top=99 GetDatas.top=95 Label3.top=98 GetCods.top=94
365:         *--------------------------------------------------------------------
366:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
367:         WITH loc_oPagina.lbl_4c_Label1
368:             .Top       = 14
369:             .Left      = 220
370:             .Width     = 32
371:             .Height    = 15
372:             .Caption   = "Data :"
373:             .FontName  = "Tahoma"
374:             .FontSize  = 8
375:             .BackStyle = 0
376:             .ForeColor = RGB(90, 90, 90)
377:             .Visible   = .T.
378:         ENDWITH
379: 
380:         loc_oPagina.AddObject("txt_4c_Datas", "TextBox")
381:         WITH loc_oPagina.txt_4c_Datas
382:             .Top           = 10
383:             .Left          = 256
384:             .Width         = 80
385:             .Height        = 24
386:             .Value         = {}
387:             .Alignment     = 3
388:             .FontName      = "Tahoma"
389:             .FontSize      = 8
390:             .ForeColor     = RGB(0, 0, 0)
391:             .BackColor     = RGB(255, 255, 255)
392:             .SpecialEffect = 1
393:             .Visible       = .T.
394:         ENDWITH
395: 
396:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
397:         WITH loc_oPagina.lbl_4c_Label3
398:             .Top       = 13
399:             .Left      = 387
400:             .Width     = 42
401:             .Height    = 15
402:             .Caption   = "C" + CHR(243) + "digo :"
403:             .FontName  = "Tahoma"
404:             .FontSize  = 8
405:             .BackStyle = 0
406:             .ForeColor = RGB(90, 90, 90)
407:             .Visible   = .T.
408:         ENDWITH
409: 
410:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
411:         WITH loc_oPagina.txt_4c_Codigo
412:             .Top           = 9
413:             .Left          = 432
414:             .Width         = 54
415:             .Height        = 24
416:             .Value         = ""
417:             .FontName      = "Tahoma"
418:             .FontSize      = 8

*-- Linhas 424 a 453:
424: 
425:         *--------------------------------------------------------------------
426:         *-- Linha 2: Vendedor - codigo + descricao
427:         *   Original: Label2.top=126 getConta.top=121 getDConta.top=121
428:         *   getDConta.When = "Return Empty(ThisForm.getConta.Value)"
429:         *   -> habilitado apenas quando getConta estiver vazio
430:         *--------------------------------------------------------------------
431:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
432:         WITH loc_oPagina.lbl_4c_Label2
433:             .Top       = 41
434:             .Left      = 197
435:             .Width     = 55
436:             .Height    = 15
437:             .Caption   = "Vendedor :"
438:             .FontName  = "Tahoma"
439:             .FontSize  = 8
440:             .BackStyle = 0
441:             .ForeColor = RGB(90, 90, 90)
442:             .Visible   = .T.
443:         ENDWITH
444: 
445:         loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
446:         WITH loc_oPagina.txt_4c_Conta
447:             .Top           = 36
448:             .Left          = 256
449:             .Width         = 80
450:             .Height        = 24
451:             .Value         = ""
452:             .FontName      = "Tahoma"
453:             .FontSize      = 8

*-- Linhas 460 a 469:
460: 
461:         loc_oPagina.AddObject("txt_4c_DConta", "TextBox")
462:         WITH loc_oPagina.txt_4c_DConta
463:             .Top           = 36
464:             .Left          = 338
465:             .Width         = 290
466:             .Height        = 24
467:             .Value         = ""
468:             .FontName      = "Tahoma"
469:             .FontSize      = 8

*-- Linhas 476 a 504:
476: 
477:         *--------------------------------------------------------------------
478:         *-- Linha 3: Grupo de Estoque - codigo + descricao
479:         *   Original: Say1.top=152 Get_Cd_GrEstoque.top=148 Get_Ds_GrEstoque.top=148
480:         *   Say1 mapeado como lbl_4c_Label_GrEstoque (evita conflito com Label1)
481:         *--------------------------------------------------------------------
482:         loc_oPagina.AddObject("lbl_4c_Label_GrEstoque", "Label")
483:         WITH loc_oPagina.lbl_4c_Label_GrEstoque
484:             .Top       = 67
485:             .Left      = 172
486:             .Width     = 80
487:             .Height    = 15
488:             .Caption   = "Grupo Estoque :"
489:             .FontName  = "Tahoma"
490:             .FontSize  = 8
491:             .BackStyle = 0
492:             .ForeColor = RGB(90, 90, 90)
493:             .Visible   = .T.
494:         ENDWITH
495: 
496:         loc_oPagina.AddObject("txt_4c_Cd_GrEstoque", "TextBox")
497:         WITH loc_oPagina.txt_4c_Cd_GrEstoque
498:             .Top           = 63
499:             .Left          = 256
500:             .Width         = 80
501:             .Height        = 23
502:             .Value         = ""
503:             .FontName      = "Tahoma"
504:             .FontSize      = 8

*-- Linhas 512 a 521:
512: 
513:         loc_oPagina.AddObject("txt_4c_Ds_GrEstoque", "TextBox")
514:         WITH loc_oPagina.txt_4c_Ds_GrEstoque
515:             .Top           = 63
516:             .Left          = 338
517:             .Width         = 290
518:             .Height        = 23
519:             .Value         = ""
520:             .FontName      = "Tahoma"
521:             .FontSize      = 8

*-- Linhas 529 a 557:
529: 
530:         *--------------------------------------------------------------------
531:         *-- Linha 4: Conta de Estoque - codigo + descricao
532:         *   Original: lbl_estoque.top=178 Get_Cd_Estoque.top=174 Get_Ds_Estoque.top=174
533:         *   Get_Ds_Estoque.When habilitado apenas quando Get_Cd_Estoque estiver vazio
534:         *--------------------------------------------------------------------
535:         loc_oPagina.AddObject("lbl_4c_Lbl_estoque", "Label")
536:         WITH loc_oPagina.lbl_4c_Lbl_estoque
537:             .Top       = 93
538:             .Left      = 172
539:             .Width     = 80
540:             .Height    = 15
541:             .Caption   = "Conta Estoque :"
542:             .FontName  = "Tahoma"
543:             .FontSize  = 8
544:             .BackStyle = 0
545:             .ForeColor = RGB(90, 90, 90)
546:             .Visible   = .T.
547:         ENDWITH
548: 
549:         loc_oPagina.AddObject("txt_4c_Cd_Estoque", "TextBox")
550:         WITH loc_oPagina.txt_4c_Cd_Estoque
551:             .Top           = 89
552:             .Left          = 256
553:             .Width         = 80
554:             .Height        = 23
555:             .Value         = ""
556:             .FontName      = "Tahoma"
557:             .FontSize      = 8

*-- Linhas 565 a 574:
565: 
566:         loc_oPagina.AddObject("txt_4c_Ds_Estoque", "TextBox")
567:         WITH loc_oPagina.txt_4c_Ds_Estoque
568:             .Top           = 89
569:             .Left          = 338
570:             .Width         = 290
571:             .Height        = 23
572:             .Value         = ""
573:             .FontName      = "Tahoma"
574:             .FontSize      = 8

*-- Linhas 582 a 610:
582: 
583:         *--------------------------------------------------------------------
584:         *-- Linha 5: Produto - codigo + descricao
585:         *   Original: lbl_codigo.top=204 get_Produto.top=200 get_descricao.top=200
586:         *   Nomes com duplo underscore conforme mapeamento.json
587:         *--------------------------------------------------------------------
588:         loc_oPagina.AddObject("lbl_4c_Lbl_codigo", "Label")
589:         WITH loc_oPagina.lbl_4c_Lbl_codigo
590:             .Top       = 119
591:             .Left      = 205
592:             .Width     = 47
593:             .Height    = 15
594:             .Caption   = "Produto :"
595:             .FontName  = "Tahoma"
596:             .FontSize  = 8
597:             .BackStyle = 0
598:             .ForeColor = RGB(90, 90, 90)
599:             .Visible   = .T.
600:         ENDWITH
601: 
602:         loc_oPagina.AddObject("txt_4c__Produto", "TextBox")
603:         WITH loc_oPagina.txt_4c__Produto
604:             .Top           = 115
605:             .Left          = 256
606:             .Width         = 108
607:             .Height        = 23
608:             .Value         = ""
609:             .FontName      = "Tahoma"
610:             .FontSize      = 8

*-- Linhas 618 a 627:
618: 
619:         loc_oPagina.AddObject("txt_4c__descricao", "TextBox")
620:         WITH loc_oPagina.txt_4c__descricao
621:             .Top           = 115
622:             .Left          = 367
623:             .Width         = 261
624:             .Height        = 23
625:             .Value         = ""
626:             .FontName      = "Tahoma"
627:             .FontSize      = 8

*-- Linhas 635 a 721:
635: 
636:         *--------------------------------------------------------------------
637:         *-- Linha 6: Localizacoes - label + OptionGroup 4 opcoes
638:         *   Original: Label4.top=228 OptLocal.top=223 Width=347 Height=26
639:         *   btnReport.Click verifica Value <> 4 para exigir data
640:         *   Opcao 4 = relatorio sem exigencia de data
641:         *--------------------------------------------------------------------
642:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
643:         WITH loc_oPagina.lbl_4c_Label4
644:             .Top       = 143
645:             .Left      = 184
646:             .Width     = 68
647:             .Height    = 15
648:             .Caption   = "Localiza" + CHR(231) + CHR(245) + "es :"
649:             .FontName  = "Tahoma"
650:             .FontSize  = 8
651:             .BackStyle = 0
652:             .ForeColor = RGB(90, 90, 90)
653:             .Visible   = .T.
654:         ENDWITH
655: 
656:         loc_oPagina.AddObject("obj_4c_OptLocal", "OptionGroup")
657:         WITH loc_oPagina.obj_4c_OptLocal
658:             .Top         = 138
659:             .Left        = 252
660:             .Width       = 347
661:             .Height      = 26
662:             .ButtonCount = 4
663:             .BackStyle   = 0
664:             .BorderStyle = 0
665:             .Visible     = .T.
666:             .Value       = 4
667: 
668:             WITH .Buttons(1)
669:                 .Caption   = "Todas"
670:                 .BackStyle = 0
671:                 .ForeColor = RGB(90, 90, 90)
672:                 .AutoSize  = .T.
673:                 .Left      = 5
674:                 .Top       = 5
675:                 .Width     = 47
676:                 .Themes    = .F.
677:                 .Visible   = .T.
678:             ENDWITH
679: 
680:             WITH .Buttons(2)
681:                 .Caption   = "Somente Lidos"
682:                 .FontName  = "Tahoma"
683:                 .FontSize  = 8
684:                 .BackStyle = 0
685:                 .ForeColor = RGB(90, 90, 90)
686:                 .AutoSize  = .T.
687:                 .Left      = 74
688:                 .Top       = 6
689:                 .Width     = 87
690:                 .Themes    = .F.
691:                 .Visible   = .T.
692:             ENDWITH
693: 
694:             WITH .Buttons(3)
695:                 .Caption   = "N" + CHR(227) + "o Lidos"
696:                 .FontName  = "Tahoma"
697:                 .FontSize  = 8
698:                 .BackStyle = 0
699:                 .ForeColor = RGB(90, 90, 90)
700:                 .AutoSize  = .T.
701:                 .Left      = 191
702:                 .Top       = 6
703:                 .Width     = 64
704:                 .Themes    = .F.
705:                 .Visible   = .T.
706:             ENDWITH
707: 
708:             WITH .Buttons(4)
709:                 .Caption   = "Diferen" + CHR(231) + "as"
710:                 .FontName  = "Tahoma"
711:                 .FontSize  = 8
712:                 .BackStyle = 0
713:                 .ForeColor = RGB(90, 90, 90)
714:                 .AutoSize  = .T.
715:                 .Left      = 273
716:                 .Top       = 5
717:                 .Width     = 69
718:                 .Themes    = .F.
719:                 .Visible   = .T.
720:             ENDWITH
721:         ENDWITH

*-- Linhas 1608 a 1643:
1608:                 loc_oPagina.txt_4c_Datas.Value = IIF(EMPTY(.this_dData), DATE(), .this_dData)
1609:             ENDIF
1610:             IF VARTYPE(loc_oPagina.txt_4c_Codigo) = "O"
1611:                 loc_oPagina.txt_4c_Codigo.Value = .this_cCods
1612:             ENDIF
1613:             IF VARTYPE(loc_oPagina.txt_4c_Conta) = "O"
1614:                 loc_oPagina.txt_4c_Conta.Value = .this_cConta
1615:             ENDIF
1616:             IF VARTYPE(loc_oPagina.txt_4c_DConta) = "O"
1617:                 loc_oPagina.txt_4c_DConta.Value = .this_cDConta
1618:             ENDIF
1619:             IF VARTYPE(loc_oPagina.txt_4c_Cd_GrEstoque) = "O"
1620:                 loc_oPagina.txt_4c_Cd_GrEstoque.Value = .this_cCdGrEstoque
1621:             ENDIF
1622:             IF VARTYPE(loc_oPagina.txt_4c_Ds_GrEstoque) = "O"
1623:                 loc_oPagina.txt_4c_Ds_GrEstoque.Value = .this_cDsGrEstoque
1624:             ENDIF
1625:             IF VARTYPE(loc_oPagina.txt_4c_Cd_Estoque) = "O"
1626:                 loc_oPagina.txt_4c_Cd_Estoque.Value = .this_cCdEstoque
1627:             ENDIF
1628:             IF VARTYPE(loc_oPagina.txt_4c_Ds_Estoque) = "O"
1629:                 loc_oPagina.txt_4c_Ds_Estoque.Value = .this_cDsEstoque
1630:             ENDIF
1631:             IF VARTYPE(loc_oPagina.txt_4c__Produto) = "O"
1632:                 loc_oPagina.txt_4c__Produto.Value = .this_cProduto
1633:             ENDIF
1634:             IF VARTYPE(loc_oPagina.txt_4c__descricao) = "O"
1635:                 loc_oPagina.txt_4c__descricao.Value = .this_cDsProduto
1636:             ENDIF
1637:             IF VARTYPE(loc_oPagina.obj_4c_OptLocal) = "O"
1638:                 loc_oPagina.obj_4c_OptLocal.Value = .this_nOptLocal
1639:             ENDIF
1640:         ENDWITH
1641:     ENDPROC
1642: 
1643:     *--------------------------------------------------------------------------


### BO (C:\4c\projeto\app\classes\sigrecrfBO.prg):
*==============================================================================
* SIGRECRFBO.PRG
* Business Object para Relatorio de Contagem por Referencia
*
* Herda de: RelatorioBase
* Form: Formsigrecrf.prg
* Relatorio original: sigrecrf.SCX / SigReCrf.FRX
*==============================================================================

DEFINE CLASS sigrecrfBO AS RelatorioBase

    *-- Identificacao do relatorio
    this_cArquivoRelatorio  = "SigReCrf"
    this_cTituloRelatorio   = ""

    *-- Filtros de parametro do formulario
    this_dData              = {}
    this_cConta             = ""
    this_cDConta            = ""
    this_cCods              = ""
    this_cProduto           = ""
    this_cDsProduto         = ""
    this_cCdGrEstoque       = ""
    this_cDsGrEstoque       = ""
    this_cCdEstoque         = ""
    this_cDsEstoque         = ""
    this_nOptLocal          = 4

    *-- Estado / controle
    this_cGrPadVens         = ""
    this_lAcessoSomentesDif = .F.

    *-- Cursor principal gerado por PrepararDados
    this_cCursorDados       = "crRel"

    *--------------------------------------------------------------------------
    * Init - Carrega GrPadVens de SigCdPam
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_nResult, loc_oErro
        loc_lSucesso = .F.

        THIS.this_cTabela          = ""
        THIS.this_cCampoChave      = ""
        THIS.this_cTituloRelatorio = "Rela" + CHR(231) + CHR(227) + "o de Contagem por Referencia"
        THIS.this_nOptLocal        = 4

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 GrPadVens FROM SigCdPam", ;
                "cursor_4c_SigrecrfPam")

            IF loc_nResult > 0
                SELECT cursor_4c_SigrecrfPam
                IF !EOF()
                    THIS.this_cGrPadVens = ALLTRIM(GrPadVens)
                ENDIF
                USE IN cursor_4c_SigrecrfPam
            ENDIF

            IF EMPTY(THIS.this_cGrPadVens)
                THIS.this_cMensagemErro = "O Grupo Padr" + CHR(227) + "o de Vendedores n" + ;
                    CHR(227) + "o est" + CHR(225) + " configurado nos par" + CHR(226) + ;
                    "metros do sistema. Configure antes de prosseguir."
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecrfBO.Init")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        IF !loc_lSucesso
            RETURN .F.
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa queries e monta cursor crRel para REPORT FORM
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nResult, loc_oErro
        LOCAL loc_cEmpresa, loc_cVends, loc_cCods, loc_cPro, loc_cGrupo, loc_cConta, loc_nLocal
        LOCAL loc_cNomeEmpresa, loc_cTitulo2

        loc_lSucesso = .F.

        TRY
            loc_cVends   = ALLTRIM(THIS.this_cConta)
            loc_nLocal   = THIS.this_nOptLocal
            loc_cCods    = ALLTRIM(THIS.this_cCods)
            loc_cPro     = ALLTRIM(THIS.this_cProduto)
            loc_cGrupo   = ALLTRIM(THIS.this_cCdGrEstoque)
            loc_cConta   = ALLTRIM(THIS.this_cCdEstoque)
            loc_cEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa)

            *-- Limpar cursores de execucao anterior
            IF USED("csRel")
                USE IN csRel
            ENDIF
            IF USED("crRel")
                USE IN crRel
            ENDIF
            IF USED("crTmpCrf")
                USE IN crTmpCrf
            ENDIF
            IF USED("crSigCdCrf")
                USE IN crSigCdCrf
            ENDIF
            IF USED("csCabecalho")
                USE IN csCabecalho
            ENDIF
            IF USED("csTotLocal")
                USE IN csTotLocal
            ENDIF

            *-- Validar data (obrigatoria exceto para Diferencas - OptLocal=4)
            IF loc_nLocal <> 4 AND EMPTY(THIS.this_dData)
                THIS.this_cMensagemErro = "Data inv" + CHR(225) + "lida!"
                loc_lSucesso = .F.
            ENDIF

            *-- Montar cabecalho do relatorio
            CREATE CURSOR csCabecalho (NomeEmpresa C(80), Titulo C(200), Titulo2 C(200), Figura C(10))

            loc_cNomeEmpresa = loc_cEmpresa
            loc_cTitulo2     = ""

            IF !EMPTY(go_4c_Sistema.cEmpresa)
                loc_cNomeEmpresa = loc_cEmpresa + " - " + ALLTRIM(go_4c_Sistema.cEmpresa)
            ENDIF

            IF !EMPTY(loc_cVends)
                loc_cTitulo2 = "Vendedor - " + loc_cVends + " " + ALLTRIM(THIS.this_cDConta)
            ENDIF

            INSERT INTO csCabecalho (NomeEmpresa, Titulo, Titulo2) ;
                VALUES (loc_cNomeEmpresa, THIS.this_cTituloRelatorio, loc_cTitulo2)

            *--------------------------------------------------------------
            *-- QUERY 1: Contagens - sigcdcrf JOIN sigcdcri
            *--------------------------------------------------------------
            loc_cWhere = "a.Emps = " + EscaparSQL(loc_cEmpresa)

            IF !EMPTY(THIS.this_dData)
                loc_cWhere = loc_cWhere + ;
                    " And CAST(a.Datas AS DATE) = " + FormatarDataSQL(THIS.this_dData)
            ENDIF
            IF !EMPTY(loc_cCods)
                loc_cWhere = loc_cWhere + " And A.Cods = " + EscaparSQL(loc_cCods)
            ENDIF
            IF !EMPTY(loc_cVends)
                loc_cWhere = loc_cWhere + " And A.Vends = " + EscaparSQL(loc_cVends)
            ENDIF
            IF !EMPTY(loc_cPro)
                loc_cWhere = loc_cWhere + " And b.cpros = " + EscaparSQL(loc_cPro)
            ENDIF
            IF !EMPTY(loc_cGrupo)
                loc_cWhere = loc_cWhere + " And b.grupos = " + EscaparSQL(loc_cGrupo)
            ENDIF
            IF !EMPTY(loc_cConta)
                loc_cWhere = loc_cWhere + " And b.estos = " + EscaparSQL(loc_cConta)
            ENDIF

            loc_cSQL = "Select a.cods, a.datas, a.vends, a.emps, " + ;
                       "b.cpros, b.grupos, b.estos, b.qtds, b.estoque " + ;
                       "from sigcdcrf a " + ;
                       "join sigcdcri b on a.cods = b.cods " + ;
                       "Where " + loc_cWhere

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCrf")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao buscar contagens (crSigCdCrf)"
                loc_lSucesso = .F.
            ENDIF

            IF RECCOUNT("crSigCdCrf") = 0
                THIS.this_cMensagemErro = "Nenhum registro encontrado para os filtros informados."
                loc_lSucesso = .F.
            ENDIF

            SELECT crSigCdCrf
            INDEX ON Emps + Grupos + Estos + Cpros TAG Produto
            GO TOP

            *--------------------------------------------------------------
            *-- QUERY 2: Estoque - SigMvEst JOIN SigCdpro/SigCdCli/SigCtCtg
            *--------------------------------------------------------------
            loc_cWhere = "a.emps = " + EscaparSQL(loc_cEmpresa)
            IF !EMPTY(loc_cPro)
                loc_cWhere = loc_cWhere + " And a.cpros = " + EscaparSQL(loc_cPro)
            ENDIF
            IF !EMPTY(loc_cGrupo)
                loc_cWhere = loc_cWhere + " And a.grupos = " + EscaparSQL(loc_cGrupo)
            ENDIF
            IF !EMPTY(loc_cConta)
                loc_cWhere = loc_cWhere + " And a.estos = " + EscaparSQL(loc_cConta)
            ENDIF

            loc_cSQL = "Select a.Emps, a.Grupos, a.Estos, a.cpros, " + ;
                       "sum(sqtds) as qtde, convert(numeric(5,0),0) as QtdCtg, b.dpros as Descr " + ;
                       "From SigMvEst a " + ;
                       "Join SigCdpro b on a.CPros = b.Cpros " + ;
                       "Join SigCdCli c on a.Estos = c.Iclis " + ;
                       "join SigCtCtg d on a.empgruests = d.empresa + d.grupos + d.contas " + ;
                       "Where " + loc_cWhere + ;
                       " And b.cunis = 'UN'" + ;
                       " group by a.Emps, a.Grupos, a.Estos, b.dpros, a.cpros" + ;
                       " Having sum(sqtds) <> 0" + ;
                       " order by a.Emps, a.Grupos, a.Estos, a.cpros"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crTmpCrf")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao buscar estoque (crTmpCrf)"
                loc_lSucesso = .F.
            ENDIF

            *-- Remover de crTmpCrf itens ausentes em crSigCdCrf
            SELECT crTmpCrf
            GO TOP
            SCAN
                IF !SEEK(crTmpCrf.Emps + crTmpCrf.Grupos + crTmpCrf.Estos + crTmpCrf.Cpros, ;
                         "crSigCdCrf", "Produto")
                    DELETE
                ENDIF
                SELECT crTmpCrf
            ENDSCAN

            *-- Agregar crTmpCrf por produto
            SELECT crTmpCrf
            SELECT Emps, grupos, estos, cpros, Sum(Qtde) As Qtds ;
                From crTmpCrf ;
                Where NOT DELETED() ;
                Group By Emps, grupos, estos, cpros ;
                Into Cursor csTotLocal READWRITE

            IF RECCOUNT("csTotLocal") = 0
                THIS.this_cMensagemErro = "Nenhum item de estoque encontrado para os filtros."
                loc_lSucesso = .F.
            ENDIF

            SELECT csTotLocal
            INDEX ON Emps + Grupos + Estos + Cpros TAG Produtos
            GO TOP

            *--------------------------------------------------------------
            *-- Aplicar filtro Localizacoes (OptLocal 1=Todas 2=Lidos 3=NaoLidos 4=Diferencas)
            *--------------------------------------------------------------
            DO CASE
            CASE loc_nLocal = 1
                SELECT DISTINCT a.DataS, ;
                    NVL(a.Emps,'') As emps, NVL(a.grupos,'') as grupos, ;
                    NVL(a.estos,'') as estos, NVL(a.cpros,'') as cpros, ;
                    NVL(a.Qtds,0) As Qtds, NVL(a.vends,'') As vends, ;
                    NVL(b.emps,'') As empsest, NVL(b.grupos,'') As gruposest, ;
                    NVL(b.estos,'') as estosest, NVL(b.cpros,'') as cprosest, ;
                    NVL(b.Qtde,0) As Qtde, NVL(b.Descr,'') as Descr ;
                    From crTmpCrf b ;
                    FULL OUTER JOIN crSigCdCrf a ;
                    On a.emps = b.emps And a.grupos = b.grupos ;
                    And a.estos = b.estos And a.cpros = b.cpros ;
                    Into Cursor csRel READWRITE

            CASE loc_nLocal = 2
                SELECT DISTINCT a.DataS, ;
                    NVL(a.Emps,'') As emps, NVL(a.grupos,'') as grupos, ;
                    NVL(a.estos,'') as estos, NVL(a.cpros,'') as cpros, ;
                    NVL(a.Qtds,0) As Qtds, NVL(a.vends,'') As vends, ;
                    NVL(b.emps,'') As empsest, NVL(b.grupos,'') As gruposest, ;
                    NVL(b.estos,'') as estosest, NVL(b.cpros,'') as cprosest, ;
                    NVL(b.Qtde,0) As Qtde, NVL(b.Descr,'') as Descr ;
                    From crSigCdCrf a ;
                    LEFT JOIN crTmpCrf b ;
                    On a.emps = b.emps And a.grupos = b.grupos ;
                    And a.estos = b.estos And a.cpros = b.cpros ;
                    Where NVL(a.Qtds,0) <> 0 ;
                    Into Cursor csRel READWRITE

            CASE loc_nLocal = 3
                SELECT DISTINCT a.DataS, ;
                    NVL(a.Emps,'') As emps, NVL(a.grupos,'') as grupos, ;
                    NVL(a.estos,'') as estos, NVL(a.cpros,'') as cpros, ;
                    NVL(a.Qtds,0) As Qtds, NVL(a.vends,'') As vends, ;
                    NVL(b.emps,'') As empsest, NVL(b.grupos,'') As gruposest, ;
                    NVL(b.estos,'') as estosest, NVL(b.cpros,'') as cprosest, ;
                    NVL(b.Qtde,0) As Qtde, NVL(b.Descr,'') as Descr ;
                    From crTmpCrf b ;
                    LEFT JOIN crSigCdCrf a ;
                    On a.emps = b.emps And a.grupos = b.grupos ;
                    And a.estos = b.estos And a.cpros = b.cpros ;
                    Where NVL(a.Qtds,0) = 0 ;
                    Into Cursor csRel READWRITE

            CASE loc_nLocal = 4
                SELECT a.DataS, ;
                    NVL(a.Emps,'') As emps, NVL(a.grupos,'') as grupos, ;
                    NVL(a.estos,'') as estos, NVL(a.cpros,'') as cpros, ;
                    NVL(a.Qtds,0) As Qtds, NVL(a.vends,'') As vends, ;
                    NVL(b.emps,'') As empsest, NVL(b.grupos,'') As gruposest, ;
                    NVL(b.estos,'') as estosest, NVL(b.cpros,'') as cprosest, ;
                    NVL(b.Qtde,0) As Qtde, NVL(b.Descr,'') as Descr ;
                    From crTmpCrf b ;
                    LEFT JOIN crSigCdCrf a ;
                    On a.emps = b.emps And a.grupos = b.grupos ;
                    And a.estos = b.estos And a.cpros = b.cpros ;
                    Where NVL(a.Qtds,0) <> NVL(b.Qtde,0) ;
                    Into Cursor csRel READWRITE
            ENDCASE

            *-- Agregacao final -> crRel (cursor do REPORT FORM)
            SELECT DataS, Emps, grupos, estos, cpros, Vends, empsest, Descr, ;
                Sum(Qtds) As Qtds, Sum(Qtde) As Qtde ;
                From csRel ;
                Group By DataS, Emps, grupos, estos, cpros, Vends, empsest, Descr ;
                Into Cursor crRel READWRITE

            SELECT crRel
            INDEX ON Vends + Emps + grupos + estos + cpros TAG Locals
            GO TOP

            *-- Limpar cursores intermediarios
            IF USED("csRel")
                USE IN csRel
            ENDIF
            IF USED("csTotLocal")
                USE IN csTotLocal
            ENDIF
            IF USED("crTmpCrf")
                USE IN crTmpCrf
            ENDIF
            IF USED("crSigCdCrf")
                USE IN crSigCdCrf
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "PrepararDados")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                    PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Visualizar")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime relatorio com dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                    TO PRINT PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Imprimir")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarExcel - Exporta relatorio para planilha Excel via REPORT FORM XML
    *--------------------------------------------------------------------------
    PROCEDURE GerarExcel()
        LOCAL loc_lSucesso, loc_cArquivo, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cArquivo = SYS(5) + CURDIR() + "SigReCrf_" + ;
                               STRTRAN(DTOC(DATE()), "/", "") + ".xls"
                REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                    TO FILE &loc_cArquivo NOPREVIEW NOCONSOLE ASCII
                IF FILE(loc_cArquivo)
                    MsgInfo("Arquivo gerado:" + CHR(13) + loc_cArquivo, "Excel")
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "GerarExcel")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarVendedores - Busca lista de vendedores para lookup no form
    * Popula cursor_4c_SigrecrfVends com iclis, rclis, grupos, situas, Cpfs
    * Filtra por GrPadVens, Emps, acesso do usuario (SigCdAcJ)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarVendedores()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_SigrecrfVends")
                USE IN cursor_4c_SigrecrfVends
            ENDIF

            loc_cSQL = "Select a.iclis, a.rclis, a.grupos, a.situas, a.Cpfs " + ;
                       "From SigCdCli a " + ;
                       "Inner Join SigCdGcr b On a.Grupos = b.Codigos " + ;
                       "And (b.Coletors <> 10 Or (b.Coletors = 10 " + ;
                       "And a.IClis Not In (" + ;
                       "Select Distinct c.Jobs From SigCdAcJ c " + ;
                       "Where c.Jobs Not In (" + ;
                       "Select Distinct d.Jobs From SigCdAcJ d " + ;
                       "Where d.Usuars = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ;
                       ")))) " + ;
                       "And a.grupos = " + EscaparSQL(THIS.this_cGrPadVens) + ;
                       " And a.Inativas <> 2" + ;
                       " And a.Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrfVends")
            IF loc_nResult > 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao buscar vendedores"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BuscarVendedores")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarProduto - Busca produto em SigCdPro para lookup no form
    * par_cFiltro: valor digitado
    * par_cTipo:   "C"=por codigo (cpros), "N"=por descricao (dpros)
    * Popula cursor_4c_SigrecrfPro com cpros, dpros
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProduto(par_cFiltro, par_cTipo)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cCampo, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_SigrecrfPro")
                USE IN cursor_4c_SigrecrfPro
            ENDIF

            IF ALLTRIM(par_cTipo) = "C"
                loc_cCampo = "cpros"
            ELSE
                loc_cCampo = "dpros"
            ENDIF

            loc_cSQL = "Select cpros, dpros " + ;
                       "From SigCdPro " + ;
                       "Where " + loc_cCampo + " LIKE " + ;
                       EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                       " Order By dpros"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrfPro")
            IF loc_nResult > 0
                SELECT cursor_4c_SigrecrfPro
                GO TOP
                loc_lSucesso = !EOF()
            ELSE
                THIS.this_cMensagemErro = "Falha ao buscar produto"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BuscarProduto")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros default a partir de um cursor de
    * parametros (ex: SigCdPam). Para o relatorio de Contagem por Referencia,
    * o unico parametro persistido eh GrPadVens, usado no lookup de vendedor.
    * Retorna .T. se carregou com sucesso, .F. caso contrario.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor de par" + CHR(226) + "metros n" + CHR(227) + ;
                                       "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)
            GO TOP
            IF !EOF()
                IF TYPE("&par_cAliasCursor..GrPadVens") = "C"
                    THIS.this_cGrPadVens = ALLTRIM(NVL(EVALUATE(par_cAliasCursor + ".GrPadVens"), ""))
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Operacao nao aplicavel em BO de relatorio. O relatorio de
    * Contagem por Referencia eh apenas leitura: consulta SigCdCrf/SigCdCrI/
    * SigMvEst e gera preview via REPORT FORM. Retorna .F. para satisfazer
    * contrato de BO e sinalizar que operacao nao se aplica.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de inser" + CHR(231) + ;
            CHR(227) + "o n" + CHR(227) + "o se aplica ao relat" + CHR(243) + "rio de " + ;
            "Contagem por Refer" + CHR(234) + "ncia (somente leitura)."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Operacao nao aplicavel em BO de relatorio. Vide observacao
    * em Inserir(). Retorna .F. e seta this_cMensagemErro.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de atualiza" + CHR(231) + ;
            CHR(227) + "o n" + CHR(227) + "o se aplica ao relat" + CHR(243) + "rio de " + ;
            "Contagem por Refer" + CHR(234) + "ncia (somente leitura)."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificador do relatorio (composto por
    * data, empresa, vendedor e filtro de localizacao) para fins de auditoria.
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "RELCRF|" + ;
                     IIF(EMPTY(THIS.this_dData), "        ", DTOS(THIS.this_dData)) + "|" + ;
                     ALLTRIM(go_4c_Sistema.cCodEmpresa) + "|" + ;
                     ALLTRIM(THIS.this_cConta) + "|" + ;
                     ALLTRIM(THIS.this_cCods) + "|" + ;
                     ALLTRIM(THIS.this_cProduto) + "|" + ;
                     ALLTRIM(THIS.this_cCdGrEstoque) + "|" + ;
                     ALLTRIM(THIS.this_cCdEstoque) + "|" + ;
                     TRANSFORM(THIS.this_nOptLocal)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("crRel")
            USE IN crRel
        ENDIF
        IF USED("csCabecalho")
            USE IN csCabecalho
        ENDIF
        IF USED("cursor_4c_SigrecrfVends")
            USE IN cursor_4c_SigrecrfVends
        ENDIF
        IF USED("cursor_4c_SigrecrfPro")
            USE IN cursor_4c_SigrecrfPro
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

