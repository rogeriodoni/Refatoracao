# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [ALINHAMENTO] Botao 'cmd_4c_Visualizar' tem Top=5 mas grupo usa Top=4 (diferenca de 1px)
- [ALINHAMENTO] Botao 'cmd_4c_Imprimir' tem Top=5 mas grupo usa Top=4 (diferenca de 1px)
- [ALINHAMENTO] Botao 'cmd_4c_Saida' tem Top=5 mas grupo usa Top=4 (diferenca de 1px)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' numa tela cujo dump legado NAO declara essa fonte - trocar por 'Tahoma' SO nas linhas apontadas, nunca "todas as ocorrencias" (Erro178: o legado do SIGCDPRO declara Comic Sans MS nos 8 botoes de navegacao, e a troca em massa virou regressao de PILAR 1)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopcgv.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (6247 linhas total):

*-- Linhas 39 a 47:
39: * PEstoque() legado alimenta:
40: *
41: *   aba 2 Pendencias : grade TmpPar (6 colunas), grade de formas de pagamento
42: *                      crTmpTipos com CheckBox marcavel (os 4 handlers de
43: *                      toggle + FiltrarTipos), filtro de grupo, total das
44: *                      pendencias visiveis e os botoes Documento (abre o
45: *                      FormSigMvExp) e Listagem (SigReIpd).
46: *   aba 3 Cheques    : quatro grades (dbAberto / DbFollow / DbTitulo /
47: *                      dbDevolvido), filtro de grupo, os nove totais do pe da

*-- Linhas 96 a 114:
96: *       Cadastro de Clientes (SIGCDCLI -> FormCliente), em vez de inventar a
97: *       operacao (PILAR 1) - ver a nota do bloco "EVENTOS PRINCIPAIS".
98: *
99: *   cmd_4c_Imprime + cnt_4c_SelecionaImpCad / cnt_4c_SelecionaImpressao :
100: *       transcricao de Imprime.Click - abre o painel certo (SelecionaImpCad
101: *       na visao CADASTRO, SelecionaImpressao na visao MOVIMENTO - mesma
102: *       regra de Cmd_MudaCli.Visible do legado) centralizado e com o resto
103: *       da tela desabilitado (DesabilitarControlesImpressao /
104: *       RestaurarControlesImpressao - funil unico para os 6 botoes
105: *       Saida/Visualizar/Imprimir dos dois paineis).
106: *   ImpressaoCad()/Impressao() : os dois metodos de impressao do legado,
107: *       com os FRX SIGOPCGV.frx (Impressao) e SigReGcd.frx (ImpressaoCad)
108: *       copiados para app/reports. Impressao() monta o cursor agregado
109: *       TmpRelGv com uma secao por checkbox marcado; quatro delas (Chk_
110: *       MovPend/dbConserto, Chk_ResVenda/dbTotVendas, Chk_ProdAdq/dbProduto,
111: *       Chk_Producao/dbProduc) dependem das abas Vendas/Operacoes Pend./
112: *       Producao (PProduto() legado, que falta fazer - ver nota abaixo) e
113: *       ficam guardadas por USED(): entram em acao sozinhas quando essa fase
114: *       for feita, sem precisar tocar neste metodo de novo.

*-- Linhas 219 a 227:
219:         THIS.this_cCpfInicial   = IIF(TYPE("par_cCpf")     = "C", par_cCpf,     "")
220: 
221:         IF TYPE("par_cTitulo") = "C" AND !EMPTY(par_cTitulo)
222:             THIS.Caption = par_cTitulo
223:         ENDIF
224: 
225:         RETURN DODEFAULT()
226:     ENDPROC
227: 

*-- Linhas 307 a 325:
307:     PROTECTED PROCEDURE ConfigurarPageFrame()
308:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
309:         WITH THIS.pgf_4c_Paginas
310:             .Top       = -33
311:             .Left      = -1
312:             .Width     = 1003
313:             .Height    = 635
314:             .PageCount = 2
315:             .TabStop   = .F.
316:             .Themes    = .F.
317:             .Visible   = .F.
318: 
319:             .Page1.Caption = "Consulta"
320:             .Page2.Caption = "Resultado"
321: 
322:             IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
323:                 .Page1.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
324:                 .Page2.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
325:             ENDIF

*-- Linhas 340 a 389:
340: 
341:         loc_oPg.AddObject("cnt_4c_Cabecalho", "Container")
342:         WITH loc_oPg.cnt_4c_Cabecalho
343:             .Top         = 5
344:             .Left        = -1
345:             *-- Page nao expoe Width/Height em runtime (regra #9.2): a largura
346:             *-- da faixa vem do FORM, nao da Page
347:             .Width       = THIS.Width + 2
348:             .Height      = 80
349:             .BackStyle   = 1
350:             .BackColor   = RGB(100, 100, 100)
351:             .BorderWidth = 0
352:             .Visible     = .T.
353: 
354:             .AddObject("lbl_4c_Sombra", "Label")
355:             WITH .lbl_4c_Sombra
356:                 .Top       = 17
357:                 .Left      = 10
358:                 .Width     = THIS.Width
359:                 .Height    = 46
360:                 .AutoSize  = .F.
361:                 .WordWrap  = .T.
362:                 .FontBold  = .T.
363:                 .FontName  = "Tahoma"
364:                 .FontSize  = 18
365:                 .BackStyle = 0
366:                 .ForeColor = RGB(0, 0, 0)
367:                 .Caption   = THIS.Caption
368:                 .Visible   = .T.
369:             ENDWITH
370: 
371:             .AddObject("lbl_4c_Titulo", "Label")
372:             WITH .lbl_4c_Titulo
373:                 .Top       = 18
374:                 .Left      = 10
375:                 .Width     = THIS.Width
376:                 .Height    = 46
377:                 .AutoSize  = .F.
378:                 .WordWrap  = .T.
379:                 .FontBold  = .T.
380:                 .FontName  = "Tahoma"
381:                 .FontSize  = 18
382:                 .BackStyle = 0
383:                 .ForeColor = RGB(255, 255, 255)
384:                 .Caption   = THIS.Caption
385:                 .Visible   = .T.
386:             ENDWITH
387:         ENDWITH
388: 
389:         THIS.ConfigurarOrigem()

*-- Linhas 401 a 511:
401: 
402:         loc_oPg.AddObject("cnt_4c_Origem", "Container")
403:         WITH loc_oPg.cnt_4c_Origem
404:             .Top           = 89
405:             .Left          = 12
406:             .Width         = 702
407:             .Height        = 235
408:             .BackStyle     = 0
409:             .BorderWidth   = 0
410:             .SpecialEffect = 0
411:             .BackColor     = RGB(255, 255, 255)
412:             .Visible       = .T.
413:         ENDWITH
414: 
415:         WITH loc_oPg.cnt_4c_Origem
416:             *-- Labels (classe say do legado - Alignment/Width so quando o dump declara)
417:             .AddObject("lbl_4c_Conta", "Label")
418:             WITH .lbl_4c_Conta
419:                 .Top       = 5
420:                 .Left      = 5
421:                 .Width     = 115
422:                 .Height    = 15
423:                 .Alignment = 1
424:                 .FontBold  = .T.
425:                 .FontSize  = 8
426:                 .BackStyle = 0
427:                 .ForeColor = RGB(90, 90, 90)
428:                 .Caption   = "Conta para Pesquisa"
429:                 .Visible   = .T.
430:             ENDWITH
431: 
432:             .AddObject("lbl_4c_LabelConta", "Label")
433:             WITH .lbl_4c_LabelConta
434:                 .Top       = 30
435:                 .Left      = 49
436:                 .Width     = 60
437:                 .Height    = 15
438:                 .Alignment = 0
439:                 .FontSize  = 8
440:                 .BackStyle = 0
441:                 .ForeColor = RGB(90, 90, 90)
442:                 .Caption   = "Conta"
443:                 .Visible   = .T.
444:             ENDWITH
445: 
446:             .AddObject("lbl_4c_LabelCpf", "Label")
447:             WITH .lbl_4c_LabelCpf
448:                 .Top       = 30
449:                 .Left      = 135
450:                 .Width     = 90
451:                 .Height    = 15
452:                 .Alignment = 0
453:                 .FontSize  = 8
454:                 .BackStyle = 0
455:                 .ForeColor = RGB(90, 90, 90)
456:                 .Caption   = "CPF / CGC"
457:                 .Visible   = .T.
458:             ENDWITH
459: 
460:             .AddObject("lbl_4c_LabelDConta", "Label")
461:             WITH .lbl_4c_LabelDConta
462:                 .Top       = 70
463:                 .Left      = 49
464:                 .Width     = 60
465:                 .Height    = 15
466:                 .Alignment = 0
467:                 .FontSize  = 8
468:                 .BackStyle = 0
469:                 .ForeColor = RGB(90, 90, 90)
470:                 .Caption   = "Nome"
471:                 .Visible   = .T.
472:             ENDWITH
473: 
474:             .AddObject("lbl_4c_LabelConjuge", "Label")
475:             WITH .lbl_4c_LabelConjuge
476:                 .Top       = 70
477:                 .Left      = 330
478:                 .Width     = 130
479:                 .Height    = 15
480:                 .Alignment = 0
481:                 .FontSize  = 8
482:                 .BackStyle = 0
483:                 .ForeColor = RGB(90, 90, 90)
484:                 .Caption   = "Nome do C" + CHR(244) + "njuge"
485:                 .Visible   = .T.
486:             ENDWITH
487: 
488:             .AddObject("lbl_4c_LabelTelefone", "Label")
489:             WITH .lbl_4c_LabelTelefone
490:                 .Top       = 109
491:                 .Left      = 49
492:                 .Width     = 80
493:                 .Height    = 15
494:                 .Alignment = 0
495:                 .FontSize  = 8
496:                 .BackStyle = 0
497:                 .ForeColor = RGB(90, 90, 90)
498:                 .Caption   = "Telefone"
499:                 .Visible   = .T.
500:             ENDWITH
501: 
502:             *-- Campo Conta: codigo exato (Get_conta)
503:             .AddObject("txt_4c_Conta", "TextBox")
504:             WITH .txt_4c_Conta
505:                 .Top               = 44
506:                 .Left              = 49
507:                 .Width             = 80
508:                 .Height            = 21
509:                 .Value             = ""
510:                 .InputMask         = "XXXXXXXXXX"
511:                 .MaxLength         = 10

*-- Linhas 519 a 528:
519:             *-- Campo CPF/CGC: codigo exato validado (Get_cpf)
520:             .AddObject("txt_4c_Cpf", "TextBox")
521:             WITH .txt_4c_Cpf
522:                 .Top               = 44
523:                 .Left              = 134
524:                 .Width             = 146
525:                 .Height            = 21
526:                 .Value             = ""
527:                 .MaxLength         = 20
528:                 .SpecialEffect     = 1

*-- Linhas 535 a 578:
535:             *-- Filtro de pesquisa por Nome: Iniciais (prefixo) / Qualquer Parte (contem)
536:             .AddObject("obj_4c_OptFiltro", "OptionGroup")
537:             WITH .obj_4c_OptFiltro
538:                 .Top         = 63
539:                 .Left        = 82
540:                 .Width       = 175
541:                 .Height      = 19
542:                 .ButtonCount = 2
543:                 .BackStyle   = 0
544:                 .BorderStyle = 0
545:                 .Value       = 1
546:                 WITH .Buttons(1)
547:                     .Caption   = "\<Iniciais"
548:                     .Top       = 5
549:                     .Left      = 5
550:                     .Width     = 50
551:                     .Height    = 15
552:                     .Style     = 0
553:                     .BackStyle = 0
554:                     .FontSize  = 8
555:                 ENDWITH
556:                 WITH .Buttons(2)
557:                     .Caption   = "\<Qualquer Parte"
558:                     .Top       = 5
559:                     .Left      = 62
560:                     .Width     = 91
561:                     .Height    = 15
562:                     .Style     = 0
563:                     .BackStyle = 0
564:                     .FontSize  = 8
565:                 ENDWITH
566:                 .Visible = .T.
567:             ENDWITH
568: 
569:             *-- Campo Nome: pesquisa por LIKE (Get_dconta)
570:             .AddObject("txt_4c_DConta", "TextBox")
571:             WITH .txt_4c_DConta
572:                 .Top               = 84
573:                 .Left              = 49
574:                 .Width             = 278
575:                 .Height            = 21
576:                 .Value             = ""
577:                 .MaxLength         = 40
578:                 .SpecialEffect     = 1

*-- Linhas 585 a 594:
585:             *-- Campo Conjuge: pesquisa por LIKE (GetConj)
586:             .AddObject("txt_4c_Conjuge", "TextBox")
587:             WITH .txt_4c_Conjuge
588:                 .Top               = 84
589:                 .Left              = 330
590:                 .Width             = 338
591:                 .Height            = 21
592:                 .Value             = ""
593:                 .MaxLength         = 40
594:                 .SpecialEffect     = 1

*-- Linhas 601 a 610:
601:             *-- Campo Telefone: pesquisa por LIKE (getTelefone)
602:             .AddObject("txt_4c_Telefone", "TextBox")
603:             WITH .txt_4c_Telefone
604:                 .Top               = 123
605:                 .Left              = 49
606:                 .Width             = 115
607:                 .Height            = 21
608:                 .Value             = ""
609:                 .MaxLength         = 40
610:                 .SpecialEffect     = 1

*-- Linhas 638 a 705:
638: 
639:         loc_oPg.AddObject("cmg_4c_GrpOperacao", "CommandGroup")
640:         WITH loc_oPg.cmg_4c_GrpOperacao
641:             .Top         = 3
642:             .Left        = 769
643:             .Width       = 235
644:             .Height      = 85
645:             .ButtonCount = 3
646:             .BackStyle   = 0
647:             .BorderStyle = 0
648:             .SpecialEffect = 1
649:             .BorderColor = RGB(136, 189, 188)
650:             .Themes      = .F.
651: 
652:             WITH .Buttons(1)
653:                 .Top        = 5
654:                 .Left       = 5
655:                 .Width      = 75
656:                 .Height     = 75
657:                 .FontBold   = .T.
658:                 .FontItalic = .T.
659:                 .FontName   = "Comic Sans MS"
660:                 .FontSize   = 8
661:                 .Caption    = "\<Cadastro"
662:                 .ToolTipText = "Dados Cadastrais"
663:                 .ForeColor  = RGB(90, 90, 90)
664:                 .BackColor  = RGB(255, 255, 255)
665:                 .Themes     = .F.
666:                 IF FILE(gc_4c_CaminhoIcones + "geral_contatos_60.jpg")
667:                     .Picture = gc_4c_CaminhoIcones + "geral_contatos_60.jpg"
668:                 ENDIF
669:             ENDWITH
670: 
671:             WITH .Buttons(2)
672:                 .Top        = 5
673:                 .Left       = 80
674:                 .Width      = 75
675:                 .Height     = 75
676:                 .FontBold   = .T.
677:                 .FontItalic = .T.
678:                 .FontName   = "Comic Sans MS"
679:                 .FontSize   = 8
680:                 .Caption    = "\<Movimento"
681:                 .ToolTipText = "Movimenta" + CHR(231) + CHR(227) + "o"
682:                 .ForeColor  = RGB(90, 90, 90)
683:                 .BackColor  = RGB(255, 255, 255)
684:                 .Themes     = .F.
685:                 IF FILE(gc_4c_CaminhoIcones + "geral_pastas_60.jpg")
686:                     .Picture = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
687:                 ENDIF
688:             ENDWITH
689: 
690:             WITH .Buttons(3)
691:                 .Top        = 5
692:                 .Left       = 155
693:                 .Width      = 75
694:                 .Height     = 75
695:                 .FontBold   = .T.
696:                 .FontItalic = .T.
697:                 .FontName   = "Comic Sans MS"
698:                 .FontSize   = 8
699:                 .Cancel     = .T.
700:                 .Caption    = "[ESC] Sair"
701:                 .ForeColor  = RGB(90, 90, 90)
702:                 .BackColor  = RGB(255, 255, 255)
703:                 .Themes     = .F.
704:                 IF FILE(gc_4c_CaminhoIcones + "cadastro_sair_60.jpg")
705:                     .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"

*-- Linhas 1199 a 1274:
1199: 
1200:         loc_oPg.AddObject("pgf_4c_Resultado", "PageFrame")
1201:         WITH loc_oPg.pgf_4c_Resultado
1202:             .Top           = 127
1203:             .Left          = -1
1204:             .Width         = 1003
1205:             .Height        = 476
1206:             .PageCount     = 10
1207:             *-- SpecialEffect de PageFrame eh READ-ONLY em runtime: o legado
1208:             *-- declara 2 no SCX, mas o VFP9 nao aceita a atribuicao aqui
1209:             .Tabs          = .F.
1210:             .Themes        = .F.
1211:             .Visible       = .T.
1212: 
1213:             .Page1.FontName  = "Verdana"
1214:             .Page1.FontSize  = 8
1215:             .Page1.Caption   = "Saldo"
1216:             .Page1.BackColor = RGB(255, 255, 255)
1217:             .Page1.ForeColor = RGB(36, 84, 155)
1218: 
1219:             .Page2.FontName  = "Tahoma"
1220:             .Page2.FontSize  = 8
1221:             .Page2.Caption   = "Pend" + CHR(234) + "ncias"
1222:             .Page2.BackColor = RGB(255, 255, 255)
1223:             .Page2.ForeColor = RGB(90, 90, 90)
1224: 
1225:             .Page3.FontName  = "Tahoma"
1226:             .Page3.FontSize  = 8
1227:             .Page3.Caption   = "Cheques"
1228:             .Page3.BackColor = RGB(255, 255, 255)
1229:             .Page3.ForeColor = RGB(90, 90, 90)
1230: 
1231:             .Page4.FontName  = "Tahoma"
1232:             .Page4.FontSize  = 8
1233:             .Page4.Caption   = "Cart" + CHR(227) + "o"
1234:             .Page4.BackColor = RGB(255, 255, 255)
1235:             .Page4.ForeColor = RGB(90, 90, 90)
1236: 
1237:             .Page5.FontName  = "Tahoma"
1238:             .Page5.FontSize  = 8
1239:             .Page5.Caption   = "Vendas"
1240:             .Page5.BackColor = RGB(255, 255, 255)
1241:             .Page5.ForeColor = RGB(90, 90, 90)
1242: 
1243:             .Page6.FontName  = "Tahoma"
1244:             .Page6.FontSize  = 8
1245:             .Page6.Caption   = "Estoque"
1246:             .Page6.BackColor = RGB(255, 255, 255)
1247:             .Page6.ForeColor = RGB(90, 90, 90)
1248: 
1249:             .Page7.FontName  = "Tahoma"
1250:             .Page7.FontSize  = 8
1251:             .Page7.Caption   = "Opera" + CHR(231) + CHR(245) + "es Pendentes"
1252:             .Page7.BackColor = RGB(255, 255, 255)
1253:             .Page7.ForeColor = RGB(90, 90, 90)
1254: 
1255:             .Page8.FontName  = "Tahoma"
1256:             .Page8.FontSize  = 8
1257:             .Page8.Caption   = "Produ" + CHR(231) + CHR(227) + "o"
1258:             .Page8.BackColor = RGB(255, 255, 255)
1259:             .Page8.ForeColor = RGB(90, 90, 90)
1260: 
1261:             .Page9.FontName  = "Tahoma"
1262:             .Page9.FontSize  = 8
1263:             .Page9.Caption   = "H.Cheques"
1264:             .Page9.BackColor = RGB(255, 255, 255)
1265:             .Page9.ForeColor = RGB(90, 90, 90)
1266: 
1267:             .Page10.FontName  = "Tahoma"
1268:             .Page10.FontSize  = 8
1269:             .Page10.Caption   = "Cr" + CHR(233) + "dito"
1270:             .Page10.BackColor = RGB(255, 255, 255)
1271:             .Page10.ForeColor = RGB(90, 90, 90)
1272: 
1273:             IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
1274:                 .Page1.Picture  = gc_4c_CaminhoIcones + "new_background.jpg"

*-- Linhas 1301 a 1326:
1301:         LOCAL loc_oPg
1302:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page1
1303: 
1304:         loc_oPg.AddObject("lbl_4c_Historico", "Label")
1305:         WITH loc_oPg.lbl_4c_Historico
1306:             .Top       = 90
1307:             .Left      = 11
1308:             .Width     = 160
1309:             .Height    = 15
1310:             .Alignment = 0
1311:             .FontSize  = 8
1312:             .BackStyle = 0
1313:             .ForeColor = RGB(90, 90, 90)
1314:             .Caption   = "Hist" + CHR(243) + "rico Conta Corrente"
1315:             .Visible   = .T.
1316:         ENDWITH
1317: 
1318:         loc_oPg.AddObject("grd_4c_Historico", "Grid")
1319:         WITH loc_oPg.grd_4c_Historico
1320:             .Top           = 104
1321:             .Left          = 11
1322:             .Width         = 721
1323:             .Height        = 292
1324:             .FontName      = "Courier New"
1325:             .DeleteMark    = .F.
1326:             .RecordMark    = .F.

*-- Linhas 1332 a 1392:
1332:             .Visible       = .T.
1333: 
1334:             .Columns(1).ControlSource      = "dbHistorico.emps"
1335:             .Columns(1).Header1.Caption    = "Emp"
1336:             .Columns(1).Width              = 31
1337:             .Columns(1).ReadOnly           = .T.
1338: 
1339:             .Columns(2).ControlSource      = "dbHistorico.datas"
1340:             .Columns(2).Header1.Caption    = "Data"
1341:             .Columns(2).Width              = 80
1342:             .Columns(2).ReadOnly           = .T.
1343: 
1344:             .Columns(3).ControlSource      = "dbHistorico.valors"
1345:             .Columns(3).Header1.Caption    = "Valor"
1346:             .Columns(3).Width              = 94
1347:             .Columns(3).Format             = "9,999,999.99"
1348:             .Columns(3).InputMask          = "9,999,999.99"
1349:             .Columns(3).ReadOnly           = .T.
1350: 
1351:             .Columns(4).ControlSource      = "dbHistorico.opers"
1352:             .Columns(4).Header1.Caption    = "O"
1353:             .Columns(4).Width              = 18
1354:             .Columns(4).ReadOnly           = .T.
1355: 
1356:             .Columns(5).ControlSource      = "dbHistorico.saldos"
1357:             .Columns(5).Header1.Caption    = "Saldo"
1358:             .Columns(5).Width              = 94
1359:             .Columns(5).Alignment          = 3
1360:             .Columns(5).Format             = "9,999,999.99"
1361:             .Columns(5).InputMask          = "9,999,999.99"
1362:             .Columns(5).ReadOnly           = .T.
1363: 
1364:             .Columns(6).ControlSource      = "dbHistorico.hists"
1365:             .Columns(6).Header1.Caption    = "Hist" + CHR(243) + "rico"
1366:             .Columns(6).Width              = 376
1367:             .Columns(6).ReadOnly           = .T.
1368:         ENDWITH
1369: 
1370:         loc_oPg.AddObject("lbl_4c_Saldo", "Label")
1371:         WITH loc_oPg.lbl_4c_Saldo
1372:             .Top       = 251
1373:             .Left      = 747
1374:             .Width     = 150
1375:             .Height    = 15
1376:             .Alignment = 0
1377:             .FontSize  = 8
1378:             .BackStyle = 0
1379:             .ForeColor = RGB(90, 90, 90)
1380:             .Caption   = "Saldo por Moeda"
1381:             .Visible   = .T.
1382:         ENDWITH
1383: 
1384:         loc_oPg.AddObject("grd_4c_Saldo", "Grid")
1385:         WITH loc_oPg.grd_4c_Saldo
1386:             .Top          = 265
1387:             .Left         = 747
1388:             .Width        = 242
1389:             .Height       = 131
1390:             .FontName     = "Courier New"
1391:             .DeleteMark   = .F.
1392:             .RecordMark   = .F.

*-- Linhas 1398 a 1418:
1398:             .Visible      = .T.
1399: 
1400:             .Columns(1).ControlSource   = "dbSaldo.moedas"
1401:             .Columns(1).Header1.Caption = "Moe"
1402:             .Columns(1).Width           = 70
1403:             .Columns(1).ReadOnly        = .T.
1404: 
1405:             .Columns(2).ControlSource   = "dbSaldo.saldos"
1406:             .Columns(2).Header1.Caption = "Saldo"
1407:             .Columns(2).Width           = 86
1408:             .Columns(2).Format          = "9,999,999.99"
1409:             .Columns(2).InputMask       = "9,999,999.99"
1410:             .Columns(2).ReadOnly        = .T.
1411: 
1412:             .Columns(3).ControlSource   = "dbSaldo.SaldoConta"
1413:             .Columns(3).Header1.Caption = "Dispon" + CHR(237) + "vel"
1414:             .Columns(3).Width           = 86
1415:             .Columns(3).Format          = "9,999,999.99"
1416:             .Columns(3).InputMask       = "9,999,999.99"
1417:             .Columns(3).ReadOnly        = .T.
1418:         ENDWITH

*-- Linhas 1443 a 1452:
1443:         loc_oOpt = loc_oPg.obj_4c_OptResultado
1444: 
1445:         WITH loc_oOpt
1446:             .Top           = 12
1447:             .Left          = 44
1448:             .Width         = 760
1449:             .Height        = 85
1450:             .ButtonCount   = 10
1451:             .BackStyle     = 0
1452:             .BorderStyle   = 0

*-- Linhas 1522 a 1542:
1522:             par_cCaption, par_cIcone, par_nPicPos, par_nAlign, par_lWordWrap, par_cToolTip)
1523: 
1524:         WITH par_oGrupo.Buttons(par_nIndice)
1525:             .Top        = 5
1526:             .Left       = par_nLeft
1527:             .Width      = 75
1528:             .Height     = 75
1529:             .FontBold   = .T.
1530:             .FontItalic = .T.
1531:             .FontName   = "Comic Sans MS"
1532:             .FontSize   = 8
1533:             .Style      = 1
1534:             .AutoSize   = .F.
1535:             .WordWrap   = par_lWordWrap
1536:             .Alignment  = par_nAlign
1537:             .Caption    = par_cCaption
1538:             .ForeColor  = RGB(90, 90, 90)
1539:             .BackColor  = RGB(255, 255, 255)
1540:             .Themes     = .F.
1541: 
1542:             IF par_nPicPos > 0

*-- Linhas 1574 a 1639:
1574:         loc_oCnt = loc_oPg.cnt_4c_Periodo
1575: 
1576:         WITH loc_oCnt
1577:             .Top         = 120
1578:             .Left        = -1
1579:             .Width       = 252
1580:             .Height      = 36
1581:             .BackStyle   = 0
1582:             .BorderWidth = 0
1583:             .Visible     = .T.
1584:         ENDWITH
1585: 
1586:         loc_oCnt.AddObject("lbl_4c_Periodo", "Label")
1587:         WITH loc_oCnt.lbl_4c_Periodo
1588:             .Top       = 10
1589:             .Left      = 16
1590:             .Width     = 48
1591:             .Height    = 17
1592:             .AutoSize  = .F.
1593:             .Alignment = 0
1594:             .FontName  = "Tahoma"
1595:             .FontSize  = 8
1596:             .BackStyle = 0
1597:             .ForeColor = RGB(90, 90, 90)
1598:             .Caption   = "Per" + CHR(237) + "o\<do : "
1599:             .Visible   = .T.
1600:         ENDWITH
1601: 
1602:         loc_oCnt.AddObject("txt_4c_DtInicial", "TextBox")
1603:         WITH loc_oCnt.txt_4c_DtInicial
1604:             .Top           = 8
1605:             .Left          = 66
1606:             .Width         = 80
1607:             .Height        = 21
1608:             .Value         = {}
1609:             .Format        = "K"
1610:             .ForeColor     = RGB(0, 0, 0)
1611:             .SpecialEffect = 1
1612:             .Visible       = .T.
1613:         ENDWITH
1614: 
1615:         loc_oCnt.AddObject("lbl_4c_PeriodoAte", "Label")
1616:         WITH loc_oCnt.lbl_4c_PeriodoAte
1617:             .Top       = 10
1618:             .Left      = 149
1619:             .Width     = 10
1620:             .Height    = 17
1621:             .AutoSize  = .F.
1622:             .Alignment = 0
1623:             .FontName  = "Tahoma"
1624:             .FontSize  = 8
1625:             .BackStyle = 0
1626:             .ForeColor = RGB(90, 90, 90)
1627:             .Caption   = CHR(224)
1628:             .Visible   = .T.
1629:         ENDWITH
1630: 
1631:         loc_oCnt.AddObject("txt_4c_DtFinal", "TextBox")
1632:         WITH loc_oCnt.txt_4c_DtFinal
1633:             .Top           = 8
1634:             .Left          = 160
1635:             .Width         = 80
1636:             .Height        = 21
1637:             .Value         = {}
1638:             .Format        = "K"
1639:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 1670 a 1698:
1670:         *-- Cmd_MudaCli: "Cadastro"
1671:         loc_oPg.AddObject("cmg_4c_MudaCli", "CommandGroup")
1672:         WITH loc_oPg.cmg_4c_MudaCli
1673:             .Top           = 12
1674:             .Left          = 794
1675:             .Width         = 85
1676:             .Height        = 85
1677:             .ButtonCount   = 1
1678:             .BackStyle     = 0
1679:             .BorderStyle   = 0
1680:             .SpecialEffect = 1
1681:             .BorderColor   = RGB(136, 189, 188)
1682:             .Themes        = .F.
1683: 
1684:             WITH .Buttons(1)
1685:                 .Top         = 5
1686:                 .Left        = 5
1687:                 .Width       = 75
1688:                 .Height      = 75
1689:                 .FontBold    = .T.
1690:                 .FontItalic  = .T.
1691:                 .FontName    = "Comic Sans MS"
1692:                 .FontSize    = 8
1693:                 .Caption     = "\<Cadastro"
1694:                 .ToolTipText = "Dados Cadastrais"
1695:                 .ForeColor   = RGB(90, 90, 90)
1696:                 .BackColor   = RGB(255, 255, 255)
1697:                 .Themes      = .F.
1698:                 IF FILE(gc_4c_CaminhoIcones + "geral_contatos_60.jpg")

*-- Linhas 1706 a 1734:
1706:         *-- Cmd_MudaMov: "Movimento"
1707:         loc_oPg.AddObject("cmg_4c_MudaMov", "CommandGroup")
1708:         WITH loc_oPg.cmg_4c_MudaMov
1709:             .Top           = 12
1710:             .Left          = 794
1711:             .Width         = 85
1712:             .Height        = 85
1713:             .ButtonCount   = 1
1714:             .BackStyle     = 0
1715:             .BorderStyle   = 0
1716:             .SpecialEffect = 1
1717:             .BorderColor   = RGB(136, 189, 188)
1718:             .Themes        = .F.
1719: 
1720:             WITH .Buttons(1)
1721:                 .Top         = 5
1722:                 .Left        = 5
1723:                 .Width       = 75
1724:                 .Height      = 75
1725:                 .FontBold    = .T.
1726:                 .FontItalic  = .T.
1727:                 .FontName    = "Comic Sans MS"
1728:                 .FontSize    = 8
1729:                 .Caption     = "\<Movimento"
1730:                 .ToolTipText = "Movimenta" + CHR(231) + CHR(227) + "o"
1731:                 .ForeColor   = RGB(90, 90, 90)
1732:                 .BackColor   = RGB(255, 255, 255)
1733:                 .Themes      = .F.
1734:                 IF FILE(gc_4c_CaminhoIcones + "geral_pastas_60.jpg")

*-- Linhas 1742 a 1805:
1742:         *-- grp_operacao da pagina Resultado: "Voltar"
1743:         loc_oPg.AddObject("cmg_4c_Voltar", "CommandGroup")
1744:         WITH loc_oPg.cmg_4c_Voltar
1745:             .Top           = 12
1746:             .Left          = 869
1747:             .Width         = 85
1748:             .Height        = 85
1749:             .ButtonCount   = 1
1750:             .BackStyle     = 0
1751:             .BorderStyle   = 0
1752:             .SpecialEffect = 1
1753:             .BorderColor   = RGB(136, 189, 188)
1754:             .Value         = 1
1755:             .Themes        = .F.
1756: 
1757:             WITH .Buttons(1)
1758:                 .Top        = 5
1759:                 .Left       = 5
1760:                 .Width      = 75
1761:                 .Height     = 75
1762:                 .FontBold   = .T.
1763:                 .FontItalic = .T.
1764:                 .FontName   = "Comic Sans MS"
1765:                 .FontSize   = 8
1766:                 .Cancel     = .T.
1767:                 .Caption    = "Voltar"
1768:                 .ForeColor  = RGB(90, 90, 90)
1769:                 .BackColor  = RGB(255, 255, 255)
1770:                 .Themes     = .F.
1771:                 IF FILE(gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg")
1772:                     .Picture = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
1773:                 ENDIF
1774:             ENDWITH
1775: 
1776:             .Visible = .T.
1777:         ENDWITH
1778: 
1779:         *-- Saldo de cashback do cliente (lblSaldoCash / getSaldoCash)
1780:         loc_oPg.AddObject("lbl_4c_SaldoCash", "Label")
1781:         WITH loc_oPg.lbl_4c_SaldoCash
1782:             .Top       = 97
1783:             .Left      = 49
1784:             .Width     = 59
1785:             .Height    = 21
1786:             .AutoSize  = .F.
1787:             .Alignment = 0
1788:             .FontBold  = .T.
1789:             .FontName  = "Tahoma"
1790:             .FontSize  = 12
1791:             .BackStyle = 0
1792:             .ForeColor = RGB(0, 0, 0)
1793:             .Caption   = "Saldo: "
1794:             .Visible   = .F.
1795:         ENDWITH
1796: 
1797:         loc_oPg.AddObject("txt_4c_SaldoCash", "TextBox")
1798:         WITH loc_oPg.txt_4c_SaldoCash
1799:             .Top               = 96
1800:             .Left              = 105
1801:             .Width             = 100
1802:             .Height            = 23
1803:             .Value             = ""
1804:             .FontName          = "Tahoma"
1805:             .FontSize          = 8

*-- Linhas 1825 a 2489:
1825:         LOCAL loc_oPg
1826:         loc_oPg = THIS.pgf_4c_Paginas.Page2
1827: 
1828:         loc_oPg.AddObject("cmd_4c_Imprime", "CommandButton")
1829:         WITH loc_oPg.cmd_4c_Imprime
1830:             .Top             = 134
1831:             .Left            = 858
1832:             .Width           = 137
1833:             .Height          = 37
1834:             .FontBold        = .T.
1835:             .FontItalic      = .T.
1836:             .FontName        = "Comic Sans MS"
1837:             .FontSize        = 8
1838:             .Caption         = "     \<Imprimir"
1839:             .ToolTipText     = "Impress" + CHR(227) + "o"
1840:             .PicturePosition = 1
1841:             .ForeColor       = RGB(90, 90, 90)
1842:             .BackColor       = RGB(255, 255, 255)
1843:             .Themes          = .F.
1844:             IF FILE(gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg")
1845:                 .Picture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
1846:             ENDIF
1847:             .Visible = .T.
1848:         ENDWITH
1849:         BINDEVENT(loc_oPg.cmd_4c_Imprime, "Click", THIS, "BtnImprimeClick")
1850: 
1851:         THIS.ConfigurarPainelImpressaoCadastro(loc_oPg)
1852:         THIS.ConfigurarPainelImpressaoMovimento(loc_oPg)
1853:     ENDPROC
1854: 
1855:     *==========================================================================
1856:     * ConfigurarPainelImpressaoCadastro - SelecionaImpCad do legado: painel
1857:     * simples (5 checkboxes) usado quando Imprime eh acionado na visao
1858:     * CADASTRO.
1859:     *==========================================================================
1860:     PROTECTED PROCEDURE ConfigurarPainelImpressaoCadastro(par_oPg)
1861:         LOCAL loc_oCnt
1862:         par_oPg.AddObject("cnt_4c_SelecionaImpCad", "Container")
1863:         loc_oCnt = par_oPg.cnt_4c_SelecionaImpCad
1864: 
1865:         WITH loc_oCnt
1866:             .Top           = 213
1867:             .Left          = 270
1868:             .Width         = 458
1869:             .Height        = 178
1870:             .SpecialEffect = 0
1871:             .BackColor     = RGB(255, 255, 255)
1872:             IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
1873:                 .Picture = gc_4c_CaminhoIcones + "new_background.jpg"
1874:             ENDIF
1875:             .Visible = .F.
1876:         ENDWITH
1877: 
1878:         loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
1879:         WITH loc_oCnt.lbl_4c_Titulo
1880:             .Top       = 6
1881:             .Left      = 5
1882:             .Width     = 226
1883:             .Height    = 17
1884:             .AutoSize  = .F.
1885:             .FontBold  = .T.
1886:             .FontName  = "Tahoma"
1887:             .FontSize  = 8
1888:             .BackStyle = 0
1889:             .ForeColor = RGB(90, 90, 90)
1890:             .Caption   = "Impress" + CHR(227) + "o da Consulta (Cadastro)"
1891:             .Visible   = .T.
1892:         ENDWITH
1893: 
1894:         loc_oCnt.AddObject("chk_4c_Generico", "CheckBox")
1895:         WITH loc_oCnt.chk_4c_Generico
1896:             .Top       = 37
1897:             .Left      = 18
1898:             .Width     = 99
1899:             .Height    = 15
1900:             .AutoSize  = .T.
1901:             .Alignment = 0
1902:             .BackStyle = 0
1903:             .FontName  = "Tahoma"
1904:             .FontSize  = 8
1905:             .ForeColor = RGB(90, 90, 90)
1906:             .Caption   = "Dados do Cliente"
1907:             .Value     = 1
1908:             .Visible   = .T.
1909:         ENDWITH
1910: 
1911:         loc_oCnt.AddObject("chk_4c_Pessoais", "CheckBox")
1912:         WITH loc_oCnt.chk_4c_Pessoais
1913:             .Top       = 61
1914:             .Left      = 18
1915:             .Width     = 92
1916:             .Height    = 15
1917:             .AutoSize  = .T.
1918:             .Alignment = 0
1919:             .BackStyle = 0
1920:             .FontName  = "Tahoma"
1921:             .FontSize  = 8
1922:             .ForeColor = RGB(90, 90, 90)
1923:             .Caption   = "Dados Pessoais"
1924:             .Value     = 1
1925:             .Visible   = .T.
1926:         ENDWITH
1927: 
1928:         loc_oCnt.AddObject("chk_4c_Bancarias", "CheckBox")
1929:         WITH loc_oCnt.chk_4c_Bancarias
1930:             .Top       = 85
1931:             .Left      = 18
1932:             .Width     = 124
1933:             .Height    = 15
1934:             .AutoSize  = .T.
1935:             .Alignment = 0
1936:             .BackStyle = 0
1937:             .FontName  = "Tahoma"
1938:             .FontSize  = 8
1939:             .ForeColor = RGB(90, 90, 90)
1940:             .Caption   = "Refer" + CHR(234) + "ncias Banc" + CHR(225) + "rias"
1941:             .Value     = 1
1942:             .Visible   = .T.
1943:         ENDWITH
1944: 
1945:         loc_oCnt.AddObject("chk_4c_Followup", "CheckBox")
1946:         WITH loc_oCnt.chk_4c_Followup
1947:             .Top       = 109
1948:             .Left      = 18
1949:             .Width     = 64
1950:             .Height    = 15
1951:             .AutoSize  = .T.
1952:             .Alignment = 0
1953:             .BackStyle = 0
1954:             .FontName  = "Tahoma"
1955:             .FontSize  = 8
1956:             .ForeColor = RGB(90, 90, 90)
1957:             .Caption   = "Follow-up"
1958:             .Value     = 1
1959:             .Visible   = .T.
1960:         ENDWITH
1961: 
1962:         loc_oCnt.AddObject("chk_4c_Impressora", "CheckBox")
1963:         WITH loc_oCnt.chk_4c_Impressora
1964:             .Top       = 133
1965:             .Left      = 18
1966:             .Width     = 126
1967:             .Height    = 15
1968:             .AutoSize  = .T.
1969:             .Alignment = 0
1970:             .BackStyle = 0
1971:             .FontName  = "Tahoma"
1972:             .FontSize  = 8
1973:             .ForeColor = RGB(90, 90, 90)
1974:             .Caption   = "Impressora 40 colunas"
1975:             .Value     = 1
1976:             .Visible   = .T.
1977:         ENDWITH
1978: 
1979:         loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
1980:         WITH loc_oCnt.cmd_4c_Visualizar
1981:             .Top             = 5
1982:             .Left            = 231
1983:             .Width           = 75
1984:             .Height          = 75
1985:             .FontBold        = .T.
1986:             .FontItalic      = .T.
1987:             .FontName        = "Comic Sans MS"
1988:             .PicturePosition = 13
1989:             .Caption         = "V" + CHR(237) + "deo"
1990:             .ForeColor       = RGB(90, 90, 90)
1991:             .BackColor       = RGB(255, 255, 255)
1992:             .Themes          = .F.
1993:             IF FILE(gc_4c_CaminhoIcones + "relatorio_video_26.jpg")
1994:                 .Picture = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
1995:             ENDIF
1996:             .Visible = .T.
1997:         ENDWITH
1998: 
1999:         loc_oCnt.AddObject("cmd_4c_Imprimir", "CommandButton")
2000:         WITH loc_oCnt.cmd_4c_Imprimir
2001:             .Top             = 5
2002:             .Left            = 306
2003:             .Width           = 75
2004:             .Height          = 75
2005:             .FontBold        = .T.
2006:             .FontItalic      = .T.
2007:             .FontName        = "Comic Sans MS"
2008:             .WordWrap        = .F.
2009:             .PicturePosition = 13
2010:             .Caption         = " Impressora    "
2011:             .ForeColor       = RGB(90, 90, 90)
2012:             .BackColor       = RGB(255, 255, 255)
2013:             .Themes          = .F.
2014:             IF FILE(gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg")
2015:                 .Picture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
2016:             ENDIF
2017:             .Visible = .T.
2018:         ENDWITH
2019: 
2020:         loc_oCnt.AddObject("cmd_4c_Saida", "CommandButton")
2021:         WITH loc_oCnt.cmd_4c_Saida
2022:             .Top        = 5
2023:             .Left        = 379
2024:             .Width       = 75
2025:             .Height      = 75
2026:             .FontBold    = .T.
2027:             .FontItalic  = .T.
2028:             .FontName    = "Comic Sans MS"
2029:             .FontSize    = 8
2030:             .Cancel      = .T.
2031:             .Caption     = "Encerrar"
2032:             .ForeColor   = RGB(90, 90, 90)
2033:             .BackColor   = RGB(255, 255, 255)
2034:             .Themes      = .F.
2035:             IF FILE(gc_4c_CaminhoIcones + "cadastro_sair_60.jpg")
2036:                 .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
2037:             ENDIF
2038:             .Visible = .T.
2039:         ENDWITH
2040: 
2041:         BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnImpCadVisualizarClick")
2042:         BINDEVENT(loc_oCnt.cmd_4c_Imprimir,   "Click", THIS, "BtnImpCadImprimirClick")
2043:         BINDEVENT(loc_oCnt.cmd_4c_Saida,      "Click", THIS, "BtnImpCadSaidaClick")
2044:     ENDPROC
2045: 
2046:     *==========================================================================
2047:     * ConfigurarPainelImpressaoMovimento - SelecionaImpress?o do legado:
2048:     * painel completo (14 checkboxes + periodo de produtos adquiridos) usado
2049:     * quando Imprime eh acionado na visao MOVIMENTO.
2050:     *==========================================================================
2051:     PROTECTED PROCEDURE ConfigurarPainelImpressaoMovimento(par_oPg)
2052:         LOCAL loc_oCnt, loc_oProd
2053:         par_oPg.AddObject("cnt_4c_SelecionaImpressao", "Container")
2054:         loc_oCnt = par_oPg.cnt_4c_SelecionaImpressao
2055: 
2056:         WITH loc_oCnt
2057:             .Top           = 145
2058:             .Left          = 295
2059:             .Width         = 409
2060:             .Height        = 315
2061:             .SpecialEffect = 0
2062:             .BackColor     = RGB(255, 255, 255)
2063:             IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
2064:                 .Picture = gc_4c_CaminhoIcones + "new_background.jpg"
2065:             ENDIF
2066:             .Visible = .F.
2067:         ENDWITH
2068: 
2069:         loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
2070:         WITH loc_oCnt.lbl_4c_Titulo
2071:             .Top       = 12
2072:             .Left      = 10
2073:             .Width     = 132
2074:             .Height    = 15
2075:             .AutoSize  = .T.
2076:             .FontBold  = .T.
2077:             .FontName  = "Tahoma"
2078:             .FontSize  = 8
2079:             .BackStyle = 0
2080:             .ForeColor = RGB(90, 90, 90)
2081:             .Caption   = "Impress" + CHR(227) + "o da Consulta"
2082:             .Visible   = .T.
2083:         ENDWITH
2084: 
2085:         loc_oCnt.AddObject("chk_4c_Saldo", "CheckBox")
2086:         WITH loc_oCnt.chk_4c_Saldo
2087:             .Top       = 88
2088:             .Left      = 10
2089:             .Width     = 137
2090:             .Height    = 15
2091:             .AutoSize  = .T.
2092:             .Alignment = 0
2093:             .BackStyle = 0
2094:             .FontName  = "Tahoma"
2095:             .FontSize  = 8
2096:             .ForeColor = RGB(90, 90, 90)
2097:             .Caption   = "Saldo de Conta Corrente"
2098:             .Value     = 0
2099:             .Visible   = .T.
2100:         ENDWITH
2101: 
2102:         loc_oCnt.AddObject("chk_4c_Limite", "CheckBox")
2103:         WITH loc_oCnt.chk_4c_Limite
2104:             .Top       = 112
2105:             .Left      = 10
2106:             .Width     = 98
2107:             .Height    = 15
2108:             .AutoSize  = .T.
2109:             .Alignment = 0
2110:             .BackStyle = 0
2111:             .FontName  = "Tahoma"
2112:             .FontSize  = 8
2113:             .ForeColor = RGB(90, 90, 90)
2114:             .Caption   = "Limite de Cr" + CHR(233) + "dito"
2115:             .Value     = 0
2116:             .Visible   = .T.
2117:         ENDWITH
2118: 
2119:         loc_oCnt.AddObject("chk_4c_ChqPend", "CheckBox")
2120:         WITH loc_oCnt.chk_4c_ChqPend
2121:             .Top       = 136
2122:             .Left      = 10
2123:             .Width     = 114
2124:             .Height    = 15
2125:             .AutoSize  = .T.
2126:             .Alignment = 0
2127:             .BackStyle = 0
2128:             .FontName  = "Tahoma"
2129:             .FontSize  = 8
2130:             .ForeColor = RGB(90, 90, 90)
2131:             .Caption   = "Cheques Pendentes"
2132:             .Value     = 0
2133:             .Visible   = .T.
2134:         ENDWITH
2135: 
2136:         loc_oCnt.AddObject("chk_4c_ChqDev", "CheckBox")
2137:         WITH loc_oCnt.chk_4c_ChqDev
2138:             .Top       = 162
2139:             .Left      = 10
2140:             .Width     = 115
2141:             .Height    = 15
2142:             .AutoSize  = .T.
2143:             .Alignment = 0
2144:             .BackStyle = 0
2145:             .FontName  = "Tahoma"
2146:             .FontSize  = 8
2147:             .ForeColor = RGB(90, 90, 90)
2148:             .Caption   = "Cheques Devolvidos"
2149:             .Value     = 0
2150:             .Visible   = .T.
2151:         ENDWITH
2152: 
2153:         loc_oCnt.AddObject("chk_4c_ChqDep", "CheckBox")
2154:         WITH loc_oCnt.chk_4c_ChqDep
2155:             .Top       = 185
2156:             .Left      = 10
2157:             .Width     = 122
2158:             .Height    = 15
2159:             .AutoSize  = .T.
2160:             .Alignment = 0
2161:             .BackStyle = 0
2162:             .FontName  = "Tahoma"
2163:             .FontSize  = 8
2164:             .ForeColor = RGB(90, 90, 90)
2165:             .Caption   = "Cheques Depositados"
2166:             .Value     = 0
2167:             .Visible   = .T.
2168:         ENDWITH
2169: 
2170:         loc_oCnt.AddObject("chk_4c_Negociado", "CheckBox")
2171:         WITH loc_oCnt.chk_4c_Negociado
2172:             .Top       = 208
2173:             .Left      = 10
2174:             .Width     = 118
2175:             .Height    = 15
2176:             .AutoSize  = .T.
2177:             .Alignment = 0
2178:             .BackStyle = 0
2179:             .FontName  = "Tahoma"
2180:             .FontSize  = 8
2181:             .ForeColor = RGB(90, 90, 90)
2182:             .Caption   = "Cheques Negociados"
2183:             .Value     = 0
2184:             .Visible   = .T.
2185:         ENDWITH
2186: 
2187:         loc_oCnt.AddObject("chk_4c_Cartao", "CheckBox")
2188:         WITH loc_oCnt.chk_4c_Cartao
2189:             .Top       = 229
2190:             .Left      = 10
2191:             .Width     = 109
2192:             .Height    = 15
2193:             .AutoSize  = .T.
2194:             .Alignment = 0
2195:             .BackStyle = 0
2196:             .FontName  = "Tahoma"
2197:             .FontSize  = 8
2198:             .ForeColor = RGB(90, 90, 90)
2199:             .Caption   = "Cart" + CHR(245) + "es em Aberto"
2200:             .Value     = 0
2201:             .Visible   = .T.
2202:         ENDWITH
2203: 
2204:         loc_oCnt.AddObject("chk_4c_Pend", "CheckBox")
2205:         WITH loc_oCnt.chk_4c_Pend
2206:             .Top       = 250
2207:             .Left      = 10
2208:             .Width     = 72
2209:             .Height    = 15
2210:             .AutoSize  = .T.
2211:             .Alignment = 0
2212:             .BackStyle = 0
2213:             .FontName  = "Tahoma"
2214:             .FontSize  = 8
2215:             .ForeColor = RGB(90, 90, 90)
2216:             .Caption   = "Pend" + CHR(234) + "ncias"
2217:             .Value     = 0
2218:             .Visible   = .T.
2219:         ENDWITH
2220: 
2221:         loc_oCnt.AddObject("chk_4c_Estoque", "CheckBox")
2222:         WITH loc_oCnt.chk_4c_Estoque
2223:             .Top       = 271
2224:             .Left      = 10
2225:             .Width     = 111
2226:             .Height    = 15
2227:             .AutoSize  = .T.
2228:             .Alignment = 0
2229:             .BackStyle = 0
2230:             .FontName  = "Tahoma"
2231:             .FontSize  = 8
2232:             .ForeColor = RGB(90, 90, 90)
2233:             .Caption   = "Posi" + CHR(231) + CHR(227) + "o de Estoque"
2234:             .Value     = 0
2235:             .Visible   = .T.
2236:         ENDWITH
2237: 
2238:         loc_oCnt.AddObject("chk_4c_MovPend", "CheckBox")
2239:         WITH loc_oCnt.chk_4c_MovPend
2240:             .Top       = 135
2241:             .Left      = 191
2242:             .Width     = 146
2243:             .Height    = 15
2244:             .AutoSize  = .T.
2245:             .Alignment = 0
2246:             .BackStyle = 0
2247:             .FontName  = "Tahoma"
2248:             .FontSize  = 8
2249:             .ForeColor = RGB(90, 90, 90)
2250:             .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es Pendentes"
2251:             .Value     = 0
2252:             .Visible   = .T.
2253:         ENDWITH
2254: 
2255:         loc_oCnt.AddObject("chk_4c_Imp40", "CheckBox")
2256:         WITH loc_oCnt.chk_4c_Imp40
2257:             .Top       = 159
2258:             .Left      = 191
2259:             .Width     = 126
2260:             .Height    = 15
2261:             .AutoSize  = .T.
2262:             .Alignment = 0
2263:             .BackStyle = 0
2264:             .FontName  = "Tahoma"
2265:             .FontSize  = 8
2266:             .ForeColor = RGB(90, 90, 90)
2267:             .Caption   = "Impressora 40 colunas"
2268:             .Value     = 0
2269:             .Visible   = .T.
2270:         ENDWITH
2271: 
2272:         loc_oCnt.AddObject("chk_4c_ResVenda", "CheckBox")
2273:         WITH loc_oCnt.chk_4c_ResVenda
2274:             .Top       = 183
2275:             .Left      = 191
2276:             .Width     = 130
2277:             .Height    = 15
2278:             .AutoSize  = .T.
2279:             .Alignment = 0
2280:             .BackStyle = 0
2281:             .FontName  = "Tahoma"
2282:             .FontSize  = 8
2283:             .ForeColor = RGB(90, 90, 90)
2284:             .Caption   = "Resumo Mensal Vendas"
2285:             .Value     = 1
2286:             .Visible   = .T.
2287:         ENDWITH
2288: 
2289:         loc_oCnt.AddObject("chk_4c_ProdAdq", "CheckBox")
2290:         WITH loc_oCnt.chk_4c_ProdAdq
2291:             .Top       = 209
2292:             .Left      = 191
2293:             .Width     = 173
2294:             .Height    = 15
2295:             .AutoSize  = .T.
2296:             .Alignment = 0
2297:             .BackStyle = 0
2298:             .FontName  = "Tahoma"
2299:             .FontSize  = 8
2300:             .ForeColor = RGB(90, 90, 90)
2301:             .Caption   = "Produtos Adquiridos Pelo Cliente"
2302:             .Value     = 1
2303:             .Visible   = .T.
2304:         ENDWITH
2305: 
2306:         loc_oCnt.AddObject("chk_4c_Producao", "CheckBox")
2307:         WITH loc_oCnt.chk_4c_Producao
2308:             .Top       = 232
2309:             .Left      = 191
2310:             .Width     = 180
2311:             .Height    = 15
2312:             .AutoSize  = .T.
2313:             .Alignment = 0
2314:             .BackStyle = 0
2315:             .FontName  = "Tahoma"
2316:             .FontSize  = 8
2317:             .ForeColor = RGB(90, 90, 90)
2318:             .Caption   = "Posi" + CHR(231) + CHR(227) + "o de Produtos em Produ" + ;
2319:                 CHR(231) + CHR(227) + "o"
2320:             .Value     = 0
2321:             .Visible   = .T.
2322:         ENDWITH
2323: 
2324:         loc_oCnt.AddObject("cnt_4c_ProdAdq", "Container")
2325:         WITH loc_oCnt.cnt_4c_ProdAdq
2326:             .Top           = 255
2327:             .Left          = 199
2328:             .Width         = 191
2329:             .Height        = 47
2330:             .SpecialEffect = 0
2331:             .BackColor     = RGB(255, 255, 255)
2332:             .Visible       = .T.
2333:         ENDWITH
2334:         loc_oProd = loc_oCnt.cnt_4c_ProdAdq
2335: 
2336:         loc_oProd.AddObject("lbl_4c_Titulo", "Label")
2337:         WITH loc_oProd.lbl_4c_Titulo
2338:             .Top       = 3
2339:             .Left      = 6
2340:             .Width     = 150
2341:             .Height    = 15
2342:             .AutoSize  = .T.
2343:             .FontName  = "Tahoma"
2344:             .FontSize  = 8
2345:             .BackStyle = 0
2346:             .ForeColor = RGB(90, 90, 90)
2347:             .Caption   = "Prod.Adquirido No Per" + CHR(237) + "odo de :"
2348:             .Visible   = .T.
2349:         ENDWITH
2350: 
2351:         loc_oProd.AddObject("txt_4c_DtInicial", "TextBox")
2352:         WITH loc_oProd.txt_4c_DtInicial
2353:             .Top           = 20
2354:             .Left          = 7
2355:             .Width         = 80
2356:             .Height        = 23
2357:             .Value         = {}
2358:             .Format        = "K"
2359:             .ForeColor     = RGB(0, 0, 0)
2360:             .SpecialEffect = 1
2361:             .Visible       = .T.
2362:         ENDWITH
2363: 
2364:         loc_oProd.AddObject("lbl_4c_PeriodoAte", "Label")
2365:         WITH loc_oProd.lbl_4c_PeriodoAte
2366:             .Top       = 23
2367:             .Left      = 92
2368:             .Width     = 10
2369:             .Height    = 15
2370:             .AutoSize  = .T.
2371:             .FontName  = "Tahoma"
2372:             .FontSize  = 8
2373:             .BackStyle = 0
2374:             .ForeColor = RGB(90, 90, 90)
2375:             .Caption   = "a"
2376:             .Visible   = .T.
2377:         ENDWITH
2378: 
2379:         loc_oProd.AddObject("txt_4c_DtFinal", "TextBox")
2380:         WITH loc_oProd.txt_4c_DtFinal
2381:             .Top           = 20
2382:             .Left          = 104
2383:             .Width         = 80
2384:             .Height        = 23
2385:             .Value         = {}
2386:             .Format        = "K"
2387:             .ForeColor     = RGB(0, 0, 0)
2388:             .SpecialEffect = 1
2389:             .Visible       = .T.
2390:         ENDWITH
2391: 
2392:         loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
2393:         WITH loc_oCnt.cmd_4c_Visualizar
2394:             .Top             = 4
2395:             .Left            = 179
2396:             .Width           = 75
2397:             .Height          = 75
2398:             .FontBold        = .T.
2399:             .FontItalic      = .T.
2400:             .FontName        = "Comic Sans MS"
2401:             .WordWrap        = .F.
2402:             .PicturePosition = 13
2403:             .Caption         = "    V" + CHR(237) + "deo            "
2404:             .ForeColor       = RGB(90, 90, 90)
2405:             .BackColor       = RGB(255, 255, 255)
2406:             .Themes          = .F.
2407:             IF FILE(gc_4c_CaminhoIcones + "relatorio_video_26.jpg")
2408:                 .Picture = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
2409:             ENDIF
2410:             .Visible = .T.
2411:         ENDWITH
2412: 
2413:         loc_oCnt.AddObject("cmd_4c_Imprimir", "CommandButton")
2414:         WITH loc_oCnt.cmd_4c_Imprimir
2415:             .Top             = 4
2416:             .Left            = 254
2417:             .Width           = 75
2418:             .Height          = 75
2419:             .FontBold        = .T.
2420:             .FontItalic      = .T.
2421:             .FontName        = "Comic Sans MS"
2422:             .WordWrap        = .F.
2423:             .PicturePosition = 13
2424:             .Caption         = " Impressora    "
2425:             .ForeColor       = RGB(90, 90, 90)
2426:             .BackColor       = RGB(255, 255, 255)
2427:             .Themes          = .F.
2428:             IF FILE(gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg")
2429:                 .Picture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
2430:             ENDIF
2431:             .Visible = .T.
2432:         ENDWITH
2433: 
2434:         loc_oCnt.AddObject("cmd_4c_Saida", "CommandButton")
2435:         WITH loc_oCnt.cmd_4c_Saida
2436:             .Top             = 4
2437:             .Left            = 329
2438:             .Width           = 75
2439:             .Height          = 75
2440:             .FontBold        = .T.
2441:             .FontItalic      = .T.
2442:             .FontName        = "Comic Sans MS"
2443:             .FontSize        = 8
2444:             .Cancel          = .T.
2445:             .PicturePosition = 13
2446:             .Caption         = "Encerrar"
2447:             .ForeColor       = RGB(90, 90, 90)
2448:             .BackColor       = RGB(255, 255, 255)
2449:             .Themes          = .F.
2450:             IF FILE(gc_4c_CaminhoIcones + "cadastro_sair_60.jpg")
2451:                 .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
2452:             ENDIF
2453:             .Visible = .T.
2454:         ENDWITH
2455: 
2456:         BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnImpMovVisualizarClick")
2457:         BINDEVENT(loc_oCnt.cmd_4c_Imprimir,   "Click", THIS, "BtnImpMovImprimirClick")
2458:         BINDEVENT(loc_oCnt.cmd_4c_Saida,      "Click", THIS, "BtnImpMovSaidaClick")
2459:     ENDPROC
2460: 
2461:     *==========================================================================
2462:     * BtnImprimeClick - Imprime.Click do legado: centraliza o painel de
2463:     * impressao correto (SelecionaImpressao na visao MOVIMENTO,
2464:     * SelecionaImpCad na visao CADASTRO - distincao por cmg_4c_MudaCli.
2465:     * Visible, regra #40: so um dos dois MudaCli/MudaMov fica visivel por
2466:     * vez, e MudaCli visivel = visao MOVIMENTO em curso) e desabilita o
2467:     * resto da tela enquanto o painel esta aberto.
2468:     *==========================================================================
2469:     PROCEDURE BtnImprimeClick()
2470:         LOCAL loc_oPg, loc_oPainel, loc_nLeft, loc_nTop
2471: 
2472:         loc_oPg = THIS.pgf_4c_Paginas.Page2
2473:         loc_oPg.cmd_4c_Imprime.Enabled = .F.
2474: 
2475:         loc_oPainel = IIF(loc_oPg.cmg_4c_MudaCli.Visible, ;
2476:             loc_oPg.cnt_4c_SelecionaImpressao, loc_oPg.cnt_4c_SelecionaImpCad)
2477: 
2478:         loc_nLeft = INT(THIS.Width - loc_oPainel.Width)
2479:         loc_nLeft = IIF(loc_nLeft > 0, INT(loc_nLeft / 2), 0)
2480:         loc_nTop  = INT(THIS.Height - loc_oPainel.Height)
2481:         loc_nTop  = IIF(loc_nTop > 0, INT(loc_nTop / 2), 0)
2482: 
2483:         loc_oPainel.Left    = loc_nLeft
2484:         loc_oPainel.Top     = loc_nTop
2485:         loc_oPainel.Visible = .T.
2486:         loc_oPainel.ZOrder(0)
2487: 
2488:         THIS.DesabilitarControlesImpressao()
2489:     ENDPROC

*-- Linhas 2521 a 2529:
2521:         loc_oPg.cmg_4c_MudaMov.Enabled = .T.
2522:         loc_oPg.cmg_4c_MudaCli.Enabled = .T.
2523:         loc_oPg.cmg_4c_Voltar.Enabled  = .T.
2524:         loc_oPg.cmd_4c_Imprime.Enabled = .T.
2525:     ENDPROC
2526: 
2527:     *==========================================================================
2528:     * BtnImpCadSaidaClick / BtnImpCadVisualizarClick / BtnImpCadImprimirClick
2529:     * Saida/Visualizar/Imprimir.Click do SelecionaImpCad legado.

*-- Linhas 2785 a 2793:
2785:             loc_oPg.cmg_4c_MudaCli.Enabled = loc_lMovimento
2786: 
2787:             *-- Saldo de cashback acompanha a visao cadastral
2788:             loc_oPg.lbl_4c_SaldoCash.Visible = !loc_lMovimento
2789:             loc_oPg.txt_4c_SaldoCash.Visible = !loc_lMovimento
2790: 
2791:             IF loc_lMovimento
2792:                 *-- Abre na aba 1 (Saldo), como o legado faz com ResultPageToSet
2793:                 IF loc_oPg.obj_4c_OptResultado.Value < 1

*-- Linhas 2901 a 2909:
2901:     * Processa()/PCartao()/PEstoque() do legado:
2902:     *
2903:     *   aba 2 Pendencias  - grade TmpPar + grade de formas de pagamento
2904:     *                       (crTmpTipos, com CheckBox marcavel) + total
2905:     *   aba 3 Cheques     - quatro grades (aberto / follow-up / titulos /
2906:     *                       devolvidos) + os nove totais do pe da pagina
2907:     *   aba 4 Cartao      - grade TmpCart (cartoes em aberto)
2908:     *   aba 6 Estoque     - grade dbEstoque (produtos em poder do cliente)
2909:     *

*-- Linhas 2927 a 3011:
2927:     * ConfigurarAbaPendencias - Aba 2 (Result.Pendencias do legado):
2928:     *
2929:     *   Grd_Pendente -> grd_4c_Pendentes  (TmpPar, 6 colunas)
2930:     *   grdTipos     -> grd_4c_TiposPend  (crTmpTipos, CheckBox marcavel)
2931:     *   Cmb_Grupo    -> cbo_4c_GrupoPend  (filtro de grupo)
2932:     *   getTotPends  -> txt_4c_TotPend    (total do que esta visivel na grade)
2933:     *   Anexa        -> cmd_4c_AnexaPend  (abre o documento da pendencia)
2934:     *   CmdImpPend   -> cmd_4c_ImpPend    (listagem SigReIpd)
2935:     *
2936:     * As colunas sao declaradas na ordem de ColumnOrder do dump (vencto, O,
2937:     * valor, moeda, tipo, historico), que eh a ordem em que o legado as mostra.
2938:     *==========================================================================
2939:     PROTECTED PROCEDURE ConfigurarAbaPendencias()
2940:         LOCAL loc_oPg, loc_oGrid
2941:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page2
2942: 
2943:         loc_oPg.AddObject("shp_4c_Pendencias", "Shape")
2944:         WITH loc_oPg.shp_4c_Pendencias
2945:             .Top         = 42
2946:             .Left        = 18
2947:             .Width       = 735
2948:             .Height      = 413
2949:             .BackStyle   = 0
2950:             .BorderColor = RGB(90, 90, 90)
2951:             .Visible     = .T.
2952:         ENDWITH
2953: 
2954:         loc_oPg.AddObject("lbl_4c_GrupoPend", "Label")
2955:         WITH loc_oPg.lbl_4c_GrupoPend
2956:             .Top       = 53
2957:             .Left      = 42
2958:             .Width     = 41
2959:             .Height    = 15
2960:             .AutoSize  = .F.
2961:             .Alignment = 0
2962:             .FontName  = "Tahoma"
2963:             .FontSize  = 8
2964:             .BackStyle = 0
2965:             .ForeColor = RGB(90, 90, 90)
2966:             .Caption   = "Grupo : "
2967:             .Visible   = .T.
2968:         ENDWITH
2969: 
2970:         loc_oPg.AddObject("cbo_4c_GrupoPend", "ComboBox")
2971:         WITH loc_oPg.cbo_4c_GrupoPend
2972:             .Top           = 49
2973:             .Left          = 85
2974:             .Width         = 300
2975:             .Height        = 24
2976:             .Style         = 2
2977:             .RowSourceType = 0
2978:             .FontName      = "Tahoma"
2979:             .FontSize      = 8
2980:             .ForeColor     = RGB(0, 0, 0)
2981:             .BackColor     = RGB(255, 255, 255)
2982:             .Visible       = .T.
2983:         ENDWITH
2984: 
2985:         loc_oPg.AddObject("lbl_4c_FormaPagto", "Label")
2986:         WITH loc_oPg.lbl_4c_FormaPagto
2987:             .Top       = 41
2988:             .Left      = 813
2989:             .Width     = 70
2990:             .Height    = 15
2991:             .AutoSize  = .F.
2992:             .Alignment = 0
2993:             .FontName  = "Tahoma"
2994:             .FontSize  = 8
2995:             .BackStyle = 0
2996:             .ForeColor = RGB(90, 90, 90)
2997:             .Caption   = "Forma Pagto:"
2998:             .Visible   = .T.
2999:         ENDWITH
3000: 
3001:         *-- Grade das pendencias (TmpPar)
3002:         loc_oPg.AddObject("grd_4c_Pendentes", "Grid")
3003:         loc_oGrid = loc_oPg.grd_4c_Pendentes
3004:         WITH loc_oGrid
3005:             .Top               = 77
3006:             .Left              = 22
3007:             .Width             = 725
3008:             .Height            = 346
3009:             .AllowHeaderSizing = .F.
3010:             .AllowRowSizing    = .F.
3011:             .DeleteMark        = .F.

*-- Linhas 3019 a 3077:
3019: 
3020:             *-- ColumnOrder 1 - vencimento (o legado nao sobrepoe a largura)
3021:             .Columns(1).ControlSource   = "TmpPar.vencs"
3022:             .Columns(1).Header1.Caption = "Vecto"
3023:             .Columns(1).Movable         = .F.
3024:             .Columns(1).Resizable       = .F.
3025:             .Columns(1).ReadOnly        = .T.
3026: 
3027:             *-- ColumnOrder 2 - natureza do lancamento (sem cabecalho no legado)
3028:             .Columns(2).ControlSource   = "TmpPar.Opers"
3029:             .Columns(2).Header1.Caption = ""
3030:             .Columns(2).Width           = 19
3031:             .Columns(2).Movable         = .F.
3032:             .Columns(2).Resizable       = .F.
3033:             .Columns(2).ReadOnly        = .T.
3034: 
3035:             .Columns(3).ControlSource   = "TmpPar.Valos"
3036:             .Columns(3).Header1.Caption = "Valor"
3037:             .Columns(3).Width           = 77
3038:             .Columns(3).Movable         = .F.
3039:             .Columns(3).Resizable       = .F.
3040:             .Columns(3).ReadOnly        = .T.
3041: 
3042:             .Columns(4).ControlSource   = "TmpPar.Moefpgs"
3043:             .Columns(4).Header1.Caption = "Moe"
3044:             .Columns(4).Width           = 30
3045:             .Columns(4).Movable         = .F.
3046:             .Columns(4).Resizable       = .F.
3047:             .Columns(4).ReadOnly        = .T.
3048: 
3049:             .Columns(5).ControlSource   = "TmpPar.FPags"
3050:             .Columns(5).Header1.Caption = "Tipo"
3051:             .Columns(5).Width           = 100
3052:             .Columns(5).Movable         = .F.
3053:             .Columns(5).Resizable       = .F.
3054:             .Columns(5).ReadOnly        = .T.
3055: 
3056:             .Columns(6).ControlSource   = "TmpPar.Hists"
3057:             .Columns(6).Header1.Caption = "Hist" + CHR(243) + "rico"
3058:             .Columns(6).Width           = 360
3059:             .Columns(6).Movable         = .F.
3060:             .Columns(6).Resizable       = .F.
3061:             .Columns(6).ReadOnly        = .T.
3062:         ENDWITH
3063: 
3064:         *-- Grade das formas de pagamento marcaveis (crTmpTipos). A coluna 1 eh
3065:         *-- um CheckBox de verdade: Column.AddObject sozinho NAO exibe o
3066:         *-- controle - precisa de CurrentControl, e de Sparse = .F. para
3067:         *-- aparecer em TODAS as linhas (regra #18)
3068:         loc_oPg.AddObject("grd_4c_TiposPend", "Grid")
3069:         loc_oGrid = loc_oPg.grd_4c_TiposPend
3070:         WITH loc_oGrid
3071:             .Top               = 59
3072:             .Left              = 812
3073:             .Width             = 133
3074:             .Height            = 105
3075:             .FontSize          = 8
3076:             .AllowHeaderSizing = .F.
3077:             .AllowRowSizing    = .F.

*-- Linhas 3086 a 3130:
3086:             .Visible           = .T.
3087:         ENDWITH
3088: 
3089:         loc_oGrid.Columns(1).AddObject("chk_4c_TipoPend", "CheckBox")
3090:         WITH loc_oGrid.Columns(1).chk_4c_TipoPend
3091:             .Top       = 9
3092:             .Left      = 2
3093:             .Width     = 22
3094:             .Height    = 17
3095:             .FontName  = "Arial"
3096:             .FontSize  = 8
3097:             .Alignment = 0
3098:             .Caption   = ""
3099:             .ReadOnly  = .F.
3100:             .Value     = 0
3101:             .Visible   = .T.
3102:         ENDWITH
3103: 
3104:         WITH loc_oGrid
3105:             .Columns(1).CurrentControl   = "chk_4c_TipoPend"
3106:             .Columns(1).Sparse           = .F.
3107:             .Columns(1).ControlSource    = "crTmpTipos.Listas"
3108:             .Columns(1).Header1.Caption  = ""
3109:             .Columns(1).Width            = 15
3110:             .Columns(1).Movable          = .F.
3111:             .Columns(1).Resizable        = .F.
3112:             *-- Column.ReadOnly DEPOIS do Grid.ReadOnly (o do grid propaga)
3113:             .Columns(1).ReadOnly         = .F.
3114: 
3115:             .Columns(2).ControlSource    = "crTmpTipos.fPags"
3116:             .Columns(2).Header1.Caption  = "Tipos"
3117:             .Columns(2).Width            = 95
3118:             .Columns(2).FontName         = "Arial"
3119:             .Columns(2).FontSize         = 8
3120:             .Columns(2).Movable          = .F.
3121:             .Columns(2).Resizable        = .F.
3122:             .Columns(2).ReadOnly         = .T.
3123:         ENDWITH
3124: 
3125:         *-- CheckBox de grade nao alterna pelo binding nativo: os quatro
3126:         *-- handlers (Click/MouseDown suprimem o toggle padrao, MouseUp e
3127:         *-- KeyPress alternam por codigo) sao obrigatorios
3128:         BINDEVENT(loc_oGrid.Columns(1).chk_4c_TipoPend, "Click", ;
3129:             THIS, "ChkTipoPendClick")
3130:         BINDEVENT(loc_oGrid.Columns(1).chk_4c_TipoPend, "MouseDown", ;

*-- Linhas 3137 a 3146:
3137:         *-- Total das pendencias visiveis (getTotPends)
3138:         loc_oPg.AddObject("txt_4c_TotPend", "TextBox")
3139:         WITH loc_oPg.txt_4c_TotPend
3140:             .Top           = 427
3141:             .Left          = 56
3142:             .Width         = 150
3143:             .Height        = 23
3144:             .FontName      = "Tahoma"
3145:             .FontSize      = 8
3146:             .Value         = 0

*-- Linhas 3156 a 3203:
3156:         *-- DisabledPicture + Themes = .T. para o icone desenhar sempre, e o
3157:         *-- botao NUNCA eh desabilitado em runtime - a condicao que o legado
3158:         *-- usava para habilitar/desabilitar vive dentro do proprio handler.
3159:         loc_oPg.AddObject("cmd_4c_AnexaPend", "CommandButton")
3160:         WITH loc_oPg.cmd_4c_AnexaPend
3161:             .Top             = 180
3162:             .Left            = 835
3163:             .Width           = 40
3164:             .Height          = 40
3165:             .FontName        = "Verdana"
3166:             .FontSize        = 8
3167:             .Caption         = ""
3168:             .Picture         = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
3169:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
3170:             .ToolTipText     = "Documento"
3171:             .ForeColor       = RGB(36, 84, 155)
3172:             .BackColor       = RGB(255, 255, 255)
3173:             .Themes          = .T.
3174:             .Visible         = .T.
3175:         ENDWITH
3176: 
3177:         loc_oPg.AddObject("cmd_4c_ImpPend", "CommandButton")
3178:         WITH loc_oPg.cmd_4c_ImpPend
3179:             .Top             = 180
3180:             .Left            = 875
3181:             .Width           = 40
3182:             .Height          = 40
3183:             .FontName        = "Verdana"
3184:             .FontSize        = 8
3185:             .Caption         = ""
3186:             .Picture         = gc_4c_CaminhoIcones + "geral_impressora_normal_32.jpg"
3187:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_impressora_normal_32.jpg"
3188:             .ToolTipText     = "Listagem"
3189:             .ForeColor       = RGB(36, 84, 155)
3190:             .BackColor       = RGB(255, 255, 255)
3191:             .Themes          = .T.
3192:             .Visible         = .T.
3193:         ENDWITH
3194: 
3195:         BINDEVENT(loc_oPg.cbo_4c_GrupoPend, "InteractiveChange", ;
3196:             THIS, "CboGrupoPendInteractiveChange")
3197:         BINDEVENT(loc_oPg.cmd_4c_AnexaPend, "Click", THIS, "BtnAnexaPendClick")
3198:         BINDEVENT(loc_oPg.cmd_4c_ImpPend,   "Click", THIS, "BtnImpPendClick")
3199:     ENDPROC
3200: 
3201:     *==========================================================================
3202:     * ConfigurarAbaCheques - Aba 3 (Result.Cheque do legado). Tem quatro grades
3203:     * e doze campos somente-leitura:

*-- Linhas 3230 a 3303:
3230:         *-- Legenda de cor da grade de cheques em aberto
3231:         loc_oPg.AddObject("shp_4c_LegendaDevolvido", "Shape")
3232:         WITH loc_oPg.shp_4c_LegendaDevolvido
3233:             .Top           = 65
3234:             .Left          = 295
3235:             .Width         = 14
3236:             .Height        = 14
3237:             .BackStyle     = 1
3238:             .SpecialEffect = 0
3239:             .BackColor     = RGB(255, 0, 0)
3240:             .Visible       = .T.
3241:         ENDWITH
3242: 
3243:         loc_oPg.AddObject("shp_4c_LegendaFollowup", "Shape")
3244:         WITH loc_oPg.shp_4c_LegendaFollowup
3245:             .Top           = 65
3246:             .Left          = 196
3247:             .Width         = 14
3248:             .Height        = 14
3249:             .BackStyle     = 1
3250:             .SpecialEffect = 0
3251:             .BackColor     = RGB(220, 255, 220)
3252:             .Visible       = .T.
3253:         ENDWITH
3254: 
3255:         *-- Rotulos
3256:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_GrupoCheque",  36,  16,  41, 15, "Grupo : ")
3257:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_ChequeAberto", 65,  11,  97, 15, ;
3258:             "Cheques em Aberto")
3259:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_ChequeFollow", 65, 499, 100, 15, ;
3260:             "FollowUp do Cheque")
3261:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_LegFollowup",  64, 211,  69, 15, ;
3262:             "Com FollowUp")
3263:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_LegDevolvido", 64, 310,  49, 15, ;
3264:             "Devolvido")
3265:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_ChequeTitulo", 204, 13, 148, 15, ;
3266:             "Cheques Negociados ( titulos )")
3267:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_ChequeDevolv", 206, 499, 158, 15, ;
3268:             "Hist" + CHR(243) + "rico de Cheques Devolvidos")
3269:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_HistChqDev",  234, 891, 75, 15, ;
3270:             "Hist. Chq Dev -")
3271:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_MoedaHist",   234, 981, 15, 15, "R$")
3272:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_ContasRec",   329, 508, 98, 15, ;
3273:             "Contas a Receber - ")
3274:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_MoedaConta",  328, 608, 15, 15, "R$")
3275:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_ObsNegoc",    327,  11, 109, 15, ;
3276:             "Obs. Chq. Negociados")
3277:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_LimiteCred",  349, 520, 89, 15, ;
3278:             "Limite de Cr" + CHR(233) + "dito :")
3279:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_ChqAVencer",  371, 531, 78, 15, ;
3280:             "Chqs " + CHR(224) + " Vencer :")
3281:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_ChqVencidos", 393, 531, 78, 15, ;
3282:             "Chqs Vencidos :")
3283:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_ChqDevolv",   417, 521, 88, 15, ;
3284:             "Chqs Devolvidos :")
3285:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_SaldoCC",     371, 783, 56, 15, ;
3286:             "Saldo C/C :")
3287:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_ChqNegoc",    351, 748, 91, 15, ;
3288:             "Chqs Negociados :")
3289:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_VlEstoque",   393, 750, 89, 15, ;
3290:             "Valor em Estoque:")
3291:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_LimiteDisp",  416, 752, 87, 15, ;
3292:             "Limite Dispon" + CHR(237) + "vel :")
3293: 
3294:         *-- Filtro de grupo
3295:         loc_oPg.AddObject("cbo_4c_GrupoCheque", "ComboBox")
3296:         WITH loc_oPg.cbo_4c_GrupoCheque
3297:             .Top           = 32
3298:             .Left          = 59
3299:             .Width         = 188
3300:             .Height        = 24
3301:             .Style         = 2
3302:             .RowSourceType = 0
3303:             .FontName      = "Tahoma"

*-- Linhas 3311 a 3320:
3311:         loc_oPg.AddObject("grd_4c_ChequeAberto", "Grid")
3312:         loc_oGrid = loc_oPg.grd_4c_ChequeAberto
3313:         WITH loc_oGrid
3314:             .Top          = 79
3315:             .Left         = 11
3316:             .Width        = 471
3317:             .Height       = 86
3318:             .FontName     = "Courier New"
3319:             .DeleteMark   = .F.
3320:             .RecordMark   = .F.

*-- Linhas 3329 a 3375:
3329:             .Visible      = .T.
3330: 
3331:             .Columns(1).ControlSource   = "dbAberto.vencs"
3332:             .Columns(1).Header1.Caption = "Vencimento"
3333:             .Columns(1).Width           = 80
3334:             .Columns(1).ReadOnly        = .T.
3335: 
3336:             .Columns(2).ControlSource   = "dbAberto.bancos"
3337:             .Columns(2).Header1.Caption = "Bco."
3338:             .Columns(2).Width           = 38
3339:             .Columns(2).Alignment       = 1
3340:             .Columns(2).ReadOnly        = .T.
3341: 
3342:             .Columns(3).ControlSource   = "dbAberto.agencias"
3343:             .Columns(3).Header1.Caption = "Ag."
3344:             .Columns(3).Width           = 45
3345:             .Columns(3).Alignment       = 1
3346:             .Columns(3).ReadOnly        = .T.
3347: 
3348:             .Columns(4).ControlSource   = "dbAberto.ncontas"
3349:             .Columns(4).Header1.Caption = "Conta"
3350:             .Columns(4).Width           = 100
3351:             .Columns(4).ReadOnly        = .T.
3352: 
3353:             .Columns(5).ControlSource   = "dbAberto.ncheques"
3354:             .Columns(5).Header1.Caption = "Cheque"
3355:             .Columns(5).Width           = 65
3356:             .Columns(5).Alignment       = 1
3357:             .Columns(5).ReadOnly        = .T.
3358: 
3359:             .Columns(6).ControlSource   = "dbAberto.valors"
3360:             .Columns(6).Header1.Caption = "Valor"
3361:             .Columns(6).Width           = 115
3362:             .Columns(6).ReadOnly        = .T.
3363:         ENDWITH
3364: 
3365:         *-- Follow-up do cheque corrente (DbFollow)
3366:         loc_oPg.AddObject("grd_4c_ChequeFollowup", "Grid")
3367:         loc_oGrid = loc_oPg.grd_4c_ChequeFollowup
3368:         WITH loc_oGrid
3369:             .Top          = 79
3370:             .Left         = 499
3371:             .Width        = 471
3372:             .Height       = 86
3373:             .FontName     = "Courier New"
3374:             .DeleteMark   = .F.
3375:             .RecordMark   = .F.

*-- Linhas 3384 a 3407:
3384:             .Visible      = .T.
3385: 
3386:             .Columns(1).ControlSource   = "DbFollow.Datas"
3387:             .Columns(1).Header1.Caption = "Data"
3388:             .Columns(1).Width           = 78
3389:             .Columns(1).ReadOnly        = .T.
3390: 
3391:             .Columns(2).ControlSource   = "DbFollow.Hists"
3392:             .Columns(2).Header1.Caption = "Hist" + CHR(243) + "rico"
3393:             .Columns(2).Width           = 370
3394:             .Columns(2).ReadOnly        = .T.
3395:         ENDWITH
3396: 
3397:         *-- Cheques negociados / titulos (DbTitulo)
3398:         loc_oPg.AddObject("grd_4c_ChequeTitulo", "Grid")
3399:         loc_oGrid = loc_oPg.grd_4c_ChequeTitulo
3400:         WITH loc_oGrid
3401:             .Top          = 219
3402:             .Left         = 11
3403:             .Width        = 471
3404:             .Height       = 86
3405:             .FontName     = "Courier New"
3406:             .DeleteMark   = .F.
3407:             .RecordMark   = .F.

*-- Linhas 3416 a 3459:
3416:             .Visible      = .T.
3417: 
3418:             .Columns(1).ControlSource   = "DbTitulo.Titulos"
3419:             .Columns(1).Header1.Caption = "Titulo"
3420:             .Columns(1).Width           = 80
3421:             .Columns(1).ReadOnly        = .T.
3422: 
3423:             .Columns(2).ControlSource   = "DbTitulo.Vencs"
3424:             .Columns(2).Header1.Caption = "Vencto"
3425:             .Columns(2).Width           = 80
3426:             .Columns(2).ReadOnly        = .T.
3427: 
3428:             .Columns(3).ControlSource   = "DbTitulo.Valors"
3429:             .Columns(3).Header1.Caption = "Valor"
3430:             .Columns(3).Width           = 85
3431:             .Columns(3).ReadOnly        = .T.
3432: 
3433:             .Columns(4).ControlSource   = "DbTitulo.ValPags"
3434:             .Columns(4).Header1.Caption = "V.Pago"
3435:             .Columns(4).Width           = 85
3436:             .Columns(4).ReadOnly        = .T.
3437: 
3438:             .Columns(5).ControlSource   = "DbTitulo.Saldos"
3439:             .Columns(5).Header1.Caption = "Saldo"
3440:             .Columns(5).Width           = 80
3441:             .Columns(5).ReadOnly        = .T.
3442: 
3443:             .Columns(6).ControlSource   = "DbTitulo.Moedas"
3444:             .Columns(6).Header1.Caption = "Moe"
3445:             .Columns(6).Width           = 28
3446:             .Columns(6).ReadOnly        = .T.
3447:         ENDWITH
3448: 
3449:         *-- Historico de cheques devolvidos (dbDevolvido)
3450:         loc_oPg.AddObject("grd_4c_ChequeDevolvido", "Grid")
3451:         loc_oGrid = loc_oPg.grd_4c_ChequeDevolvido
3452:         WITH loc_oGrid
3453:             .Top          = 220
3454:             .Left         = 499
3455:             .Width        = 386
3456:             .Height       = 86
3457:             .FontName     = "Courier New"
3458:             .DeleteMark   = .F.
3459:             .RecordMark   = .F.

*-- Linhas 3468 a 3504:
3468:             .Visible      = .T.
3469: 
3470:             .Columns(1).ControlSource   = "dbDevolvido.vencs"
3471:             .Columns(1).Header1.Caption = "Vencimento"
3472:             .Columns(1).Width           = 80
3473:             .Columns(1).ReadOnly        = .T.
3474: 
3475:             .Columns(2).ControlSource   = "dbDevolvido.bancos"
3476:             .Columns(2).Header1.Caption = "Bco."
3477:             .Columns(2).Width           = 31
3478:             .Columns(2).Alignment       = 1
3479:             .Columns(2).ReadOnly        = .T.
3480: 
3481:             .Columns(3).ControlSource   = "dbDevolvido.agencias"
3482:             .Columns(3).Header1.Caption = "Ag."
3483:             .Columns(3).Width           = 38
3484:             .Columns(3).Alignment       = 1
3485:             .Columns(3).ReadOnly        = .T.
3486: 
3487:             .Columns(4).ControlSource   = "dbDevolvido.ncontas"
3488:             .Columns(4).Header1.Caption = "Conta"
3489:             .Columns(4).Width           = 80
3490:             .Columns(4).ReadOnly        = .T.
3491: 
3492:             .Columns(5).ControlSource   = "dbDevolvido.ncheques"
3493:             .Columns(5).Header1.Caption = "Cheque"
3494:             .Columns(5).Width           = 52
3495:             .Columns(5).Alignment       = 1
3496:             .Columns(5).ReadOnly        = .T.
3497: 
3498:             .Columns(6).ControlSource   = "dbDevolvido.valors"
3499:             .Columns(6).Header1.Caption = "Valor"
3500:             .Columns(6).Width           = 80
3501:             .Columns(6).ReadOnly        = .T.
3502:         ENDWITH
3503: 
3504:         *-- Campos somente-leitura: total da grade de aberto, historico de

*-- Linhas 3535 a 3550:
3535: 
3536:         THIS.AdicionarMolduraAba(loc_oPg, "shp_4c_CartaoAberto", 56, 132, 735, 274)
3537: 
3538:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_CartaoAberto", 57, 139, 93, 15, ;
3539:             "Cart" + CHR(245) + "es em Aberto")
3540: 
3541:         loc_oPg.AddObject("grd_4c_Cartao", "Grid")
3542:         loc_oGrid = loc_oPg.grd_4c_Cartao
3543:         WITH loc_oGrid
3544:             .Top          = 72
3545:             .Left         = 137
3546:             .Width        = 725
3547:             .Height       = 254
3548:             .FontName     = "Courier New"
3549:             .DeleteMark   = .F.
3550:             .RecordMark   = .F.

*-- Linhas 3558 a 3596:
3558:             .Visible      = .T.
3559: 
3560:             .Columns(1).ControlSource   = "TmpCart.vencs"
3561:             .Columns(1).Header1.Caption = "Vencimento"
3562:             .Columns(1).Width           = 75
3563:             .Columns(1).Alignment       = 0
3564:             .Columns(1).ReadOnly        = .T.
3565: 
3566:             .Columns(2).ControlSource   = "TmpCart.fpags"
3567:             .Columns(2).Header1.Caption = "Cart" + CHR(227) + "o"
3568:             .Columns(2).Width           = 100
3569:             .Columns(2).Alignment       = 0
3570:             .Columns(2).ReadOnly        = .T.
3571: 
3572:             .Columns(3).ControlSource   = "TmpCart.nocreditos"
3573:             .Columns(3).Header1.Caption = "Cr" + CHR(233) + "dito"
3574:             .Columns(3).Width           = 80
3575:             .Columns(3).Alignment       = 0
3576:             .Columns(3).ReadOnly        = .T.
3577: 
3578:             .Columns(4).ControlSource   = "TmpCart.cartaos"
3579:             .Columns(4).Header1.Caption = "N" + CHR(186) + " Cart" + CHR(227) + "o"
3580:             .Columns(4).Width           = 120
3581:             .Columns(4).Alignment       = 0
3582:             .Columns(4).ReadOnly        = .T.
3583: 
3584:             .Columns(5).ControlSource   = "TmpCart.valos"
3585:             .Columns(5).Header1.Caption = "Valor"
3586:             .Columns(5).Width           = 110
3587:             .Columns(5).Alignment       = 3
3588:             .Columns(5).ReadOnly        = .T.
3589: 
3590:             .Columns(6).ControlSource   = "TmpCart.datas"
3591:             .Columns(6).Header1.Caption = "Data"
3592:             .Columns(6).Width           = 75
3593:             .Columns(6).Alignment       = 0
3594:             .Columns(6).ReadOnly        = .T.
3595:         ENDWITH
3596:     ENDPROC

*-- Linhas 3610 a 3623:
3610: 
3611:         THIS.AdicionarMolduraAba(loc_oPg, "shp_4c_EstoqueProduto", 86, 303, 392, 361)
3612: 
3613:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_GrupoEstoque", 60, 307, 41, 15, "Grupo : ")
3614: 
3615:         loc_oPg.AddObject("cbo_4c_GrupoEstoque", "ComboBox")
3616:         WITH loc_oPg.cbo_4c_GrupoEstoque
3617:             .Top           = 56
3618:             .Left          = 350
3619:             .Width         = 300
3620:             .Height        = 24
3621:             .Style         = 2
3622:             .RowSourceType = 0
3623:             .FontName      = "Tahoma"

*-- Linhas 3630 a 3639:
3630:         loc_oPg.AddObject("grd_4c_Estoque", "Grid")
3631:         loc_oGrid = loc_oPg.grd_4c_Estoque
3632:         WITH loc_oGrid
3633:             .Top          = 92
3634:             .Left         = 308
3635:             .Width        = 381
3636:             .Height       = 347
3637:             .FontName     = "Courier New"
3638:             .DeleteMark   = .F.
3639:             .RecordMark   = .F.

*-- Linhas 3647 a 3667:
3647:             .Visible      = .T.
3648: 
3649:             .Columns(1).ControlSource   = "dbEstoque.cpros"
3650:             .Columns(1).Header1.Caption = "Produto"
3651:             .Columns(1).Width           = 108
3652:             .Columns(1).Alignment       = 3
3653:             .Columns(1).ReadOnly        = .T.
3654: 
3655:             .Columns(2).ControlSource   = "dbEstoque.sqtds"
3656:             .Columns(2).Header1.Caption = "Qtde."
3657:             .Columns(2).Width           = 100
3658:             .Columns(2).Alignment       = 3
3659:             .Columns(2).InputMask       = "999,999,999.99"
3660:             .Columns(2).ReadOnly        = .T.
3661: 
3662:             .Columns(3).Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
3663:             .Columns(3).Width           = 150
3664:             .Columns(3).Alignment       = 3
3665:             .Columns(3).ReadOnly        = .T.
3666:         ENDWITH
3667: 

*-- Linhas 3688 a 3697:
3688:         loc_oPg.AddObject("grd_4c_HistCheque", "Grid")
3689:         loc_oGrid = loc_oPg.grd_4c_HistCheque
3690:         WITH loc_oGrid
3691:             .Top          = 57
3692:             .Left         = 152
3693:             .Width        = 696
3694:             .Height       = 124
3695:             .FontName     = "Courier New"
3696:             .DeleteMark   = .F.
3697:             .RecordMark   = .F.

*-- Linhas 3705 a 3765:
3705:             .Visible      = .T.
3706: 
3707:             .Columns(1).ControlSource   = "dbCheqHist.Vencs"
3708:             .Columns(1).Header1.Caption = "Vencimento"
3709:             .Columns(1).Width           = 75
3710:             .Columns(1).ReadOnly        = .T.
3711: 
3712:             .Columns(2).ControlSource   = "dbCheqHist.Bancos"
3713:             .Columns(2).Header1.Caption = "Banco"
3714:             .Columns(2).Width           = 50
3715:             .Columns(2).ReadOnly        = .T.
3716: 
3717:             .Columns(3).ControlSource   = "dbCheqHist.Agencias"
3718:             .Columns(3).Header1.Caption = "Agencia"
3719:             .Columns(3).Width           = 55
3720:             .Columns(3).ReadOnly        = .T.
3721: 
3722:             .Columns(4).ControlSource   = "dbCheqHist.NContas"
3723:             .Columns(4).Header1.Caption = "Conta"
3724:             .Columns(4).Width           = 70
3725:             .Columns(4).ReadOnly        = .T.
3726: 
3727:             .Columns(5).ControlSource   = "dbCheqHist.NCheques"
3728:             .Columns(5).Header1.Caption = "N" + CHR(186) + "mero"
3729:             .Columns(5).Width           = 60
3730:             .Columns(5).ReadOnly        = .T.
3731: 
3732:             .Columns(6).ControlSource   = "dbCheqHist.Valors"
3733:             .Columns(6).Header1.Caption = "Valor"
3734:             .Columns(6).Width           = 75
3735:             .Columns(6).Alignment       = 3
3736:             .Columns(6).InputMask       = "999,999,999.99"
3737:             .Columns(6).ReadOnly        = .T.
3738: 
3739:             .Columns(7).ControlSource   = "dbCheqHist.GruCarts"
3740:             .Columns(7).Header1.Caption = "Grupo Carteira"
3741:             .Columns(7).Width           = 70
3742:             .Columns(7).ReadOnly        = .T.
3743: 
3744:             .Columns(8).ControlSource   = "dbCheqHist.ConCarts"
3745:             .Columns(8).Header1.Caption = "Conta Carteira"
3746:             .Columns(8).Width           = 70
3747:             .Columns(8).ReadOnly        = .T.
3748: 
3749:             .Columns(9).ControlSource   = "dbCheqHist.Emps"
3750:             .Columns(9).Header1.Caption = "Emp"
3751:             .Columns(9).Width           = 40
3752:             .Columns(9).ReadOnly        = .T.
3753: 
3754:             .Columns(10).ControlSource   = "dbCheqHist.Numeros"
3755:             .Columns(10).Header1.Caption = "Arquivo"
3756:             .Columns(10).Width           = 60
3757:             .Columns(10).ReadOnly        = .T.
3758: 
3759:             .Columns(11).ControlSource   = "dbCheqHist.DiasP"
3760:             .Columns(11).Header1.Caption = "Dias Pag."
3761:             .Columns(11).Width           = 55
3762:             .Columns(11).Alignment       = 3
3763:             .Columns(11).ReadOnly        = .T.
3764: 
3765:             *-- SetAll('DynamicForeColor'/'DynamicBackColor', ...) do legado:

*-- Linhas 3775 a 3784:
3775:         loc_oPg.AddObject("grd_4c_MovCheque", "Grid")
3776:         loc_oGrid = loc_oPg.grd_4c_MovCheque
3777:         WITH loc_oGrid
3778:             .Top          = 182
3779:             .Left         = 152
3780:             .Width        = 696
3781:             .Height       = 90
3782:             .FontName     = "Courier New"
3783:             .DeleteMark   = .F.
3784:             .RecordMark   = .F.

*-- Linhas 3792 a 3850:
3792:             .Visible      = .T.
3793: 
3794:             .Columns(1).ControlSource   = "dbCheqMovim.Codigos"
3795:             .Columns(1).Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
3796:             .Columns(1).Width           = 80
3797:             .Columns(1).ReadOnly        = .T.
3798: 
3799:             .Columns(2).ControlSource   = "dbCheqMovim.Nalineas"
3800:             .Columns(2).Header1.Caption = "Alinea"
3801:             .Columns(2).Width           = 60
3802:             .Columns(2).ReadOnly        = .T.
3803: 
3804:             .Columns(3).ControlSource   = "dbCheqMovim.Dtents"
3805:             .Columns(3).Header1.Caption = "Entrada"
3806:             .Columns(3).Width           = 80
3807:             .Columns(3).ReadOnly        = .T.
3808: 
3809:             .Columns(4).ControlSource   = "dbCheqMovim.Gruorigs"
3810:             .Columns(4).Header1.Caption = "Grupo/Origem"
3811:             .Columns(4).Width           = 80
3812:             .Columns(4).ReadOnly        = .T.
3813: 
3814:             .Columns(5).ControlSource   = "dbCheqMovim.Conorigs"
3815:             .Columns(5).Header1.Caption = "Conta/Origem"
3816:             .Columns(5).Width           = 80
3817:             .Columns(5).ReadOnly        = .T.
3818: 
3819:             .Columns(6).ControlSource   = "dbCheqMovim.Grupos"
3820:             .Columns(6).Header1.Caption = "Grupo/Destino"
3821:             .Columns(6).Width           = 80
3822:             .Columns(6).ReadOnly        = .T.
3823: 
3824:             .Columns(7).ControlSource   = "dbCheqMovim.Contas"
3825:             .Columns(7).Header1.Caption = "Conta/Destino"
3826:             .Columns(7).Width           = 80
3827:             .Columns(7).ReadOnly        = .T.
3828: 
3829:             .Columns(8).ControlSource   = "dbCheqMovim.Numlotes"
3830:             .Columns(8).Header1.Caption = "Lote"
3831:             .Columns(8).Width           = 70
3832:             .Columns(8).ReadOnly        = .T.
3833: 
3834:             .Columns(9).ControlSource   = "dbCheqMovim.Protocolos"
3835:             .Columns(9).Header1.Caption = "Protocolo"
3836:             .Columns(9).Width           = 86
3837:             .Columns(9).ReadOnly        = .T.
3838:         ENDWITH
3839: 
3840:         *-- GradeProrrog (dbCheqProrrog) - prorrogacoes do cheque selecionado
3841:         loc_oPg.AddObject("grd_4c_ProrrogCheque", "Grid")
3842:         loc_oGrid = loc_oPg.grd_4c_ProrrogCheque
3843:         WITH loc_oGrid
3844:             .Top          = 273
3845:             .Left         = 735
3846:             .Width        = 113
3847:             .Height       = 84
3848:             .FontName     = "Courier New"
3849:             .DeleteMark   = .F.
3850:             .RecordMark   = .F.

*-- Linhas 3858 a 3885:
3858:             .Visible      = .T.
3859: 
3860:             .Columns(1).ControlSource   = "dbCheqProrrog.Vencs"
3861:             .Columns(1).Header1.Caption = "Prorroga" + CHR(231) + CHR(245) + "es"
3862:             .Columns(1).Width           = 108
3863:             .Columns(1).ReadOnly        = .T.
3864:         ENDWITH
3865: 
3866:         *-- Follow-up da linha corrente (Cnt_Followup.UltFollowup)
3867:         loc_oPg.AddObject("cnt_4c_Followup", "Container")
3868:         WITH loc_oPg.cnt_4c_Followup
3869:             .Top       = 273
3870:             .Left      = 151
3871:             .Width     = 561
3872:             .Height    = 43
3873:             .BackStyle = 0
3874:             .Visible   = .T.
3875:         ENDWITH
3876:         THIS.AdicionarRotuloAba(loc_oPg.cnt_4c_Followup, "lbl_4c_Followup", 1, 8, 54, 15, "Follow_up:")
3877:         loc_oPg.cnt_4c_Followup.AddObject("txt_4c_UltFollowup", "TextBox")
3878:         WITH loc_oPg.cnt_4c_Followup.txt_4c_UltFollowup
3879:             .Top           = 19
3880:             .Left          = 5
3881:             .Width         = 550
3882:             .Height        = 20
3883:             .Value         = ""
3884:             .ReadOnly      = .T.
3885:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 3891 a 3950:
3891:         *-- ficam so por fidelidade estrutural, sem BINDEVENT.
3892:         loc_oPg.AddObject("cnt_4c_DescricaoCheque", "Container")
3893:         WITH loc_oPg.cnt_4c_DescricaoCheque
3894:             .Top       = 319
3895:             .Left      = 151
3896:             .Width     = 457
3897:             .Height    = 46
3898:             .BackStyle = 0
3899:             .Visible   = .F.
3900:         ENDWITH
3901:         THIS.AdicionarRotuloAba(loc_oPg.cnt_4c_DescricaoCheque, "lbl_4c_Origem", 4, 9, 46, 15, "Origem :")
3902:         THIS.AdicionarRotuloAba(loc_oPg.cnt_4c_DescricaoCheque, "lbl_4c_Destino", 24, 7, 48, 15, "Destino :")
3903:         loc_oPg.cnt_4c_DescricaoCheque.AddObject("txt_4c_DescOrigem", "TextBox")
3904:         WITH loc_oPg.cnt_4c_DescricaoCheque.txt_4c_DescOrigem
3905:             .Top     = 3
3906:             .Left    = 57
3907:             .Width   = 386
3908:             .Height  = 20
3909:             .Value   = ""
3910:             .Visible = .T.
3911:         ENDWITH
3912:         loc_oPg.cnt_4c_DescricaoCheque.AddObject("txt_4c_DescDestino", "TextBox")
3913:         WITH loc_oPg.cnt_4c_DescricaoCheque.txt_4c_DescDestino
3914:             .Top     = 22
3915:             .Left    = 57
3916:             .Width   = 386
3917:             .Height  = 20
3918:             .Value   = ""
3919:             .Visible = .T.
3920:         ENDWITH
3921: 
3922:         loc_oPg.AddObject("cnt_4c_PeriodoCheque", "Container")
3923:         WITH loc_oPg.cnt_4c_PeriodoCheque
3924:             .Top       = 368
3925:             .Left      = 151
3926:             .Width     = 280
3927:             .Height    = 36
3928:             .BackStyle = 0
3929:             .Visible   = .F.
3930:         ENDWITH
3931:         THIS.AdicionarRotuloAba(loc_oPg.cnt_4c_PeriodoCheque, "lbl_4c_PeriodoCheque", 10, 26, 67, 15, "Vencimento : ")
3932:         THIS.AdicionarRotuloAba(loc_oPg.cnt_4c_PeriodoCheque, "lbl_4c_PeriodoChequeA", 10, 180, 8, 15, "a")
3933:         loc_oPg.cnt_4c_PeriodoCheque.AddObject("txt_4c_PeriodoCheqIni", "TextBox")
3934:         WITH loc_oPg.cnt_4c_PeriodoCheque.txt_4c_PeriodoCheqIni
3935:             .Top     = 6
3936:             .Left    = 95
3937:             .Width   = 80
3938:             .Height  = 21
3939:             .Value   = {}
3940:             .Visible = .T.
3941:         ENDWITH
3942:         loc_oPg.cnt_4c_PeriodoCheque.AddObject("txt_4c_PeriodoCheqFim", "TextBox")
3943:         WITH loc_oPg.cnt_4c_PeriodoCheque.txt_4c_PeriodoCheqFim
3944:             .Top     = 6
3945:             .Left    = 192
3946:             .Width   = 80
3947:             .Height  = 21
3948:             .Value   = {}
3949:             .Visible = .T.
3950:         ENDWITH

*-- Linhas 3962 a 4141:
3962:         LOCAL loc_oPg, loc_oCns, loc_oGrid
3963:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page10
3964: 
3965:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_SituacaoCredito", 53, 3, 996, 47, "CLIENTE")
3966:         loc_oPg.lbl_4c_SituacaoCredito.FontName = "Tahoma"
3967:         loc_oPg.lbl_4c_SituacaoCredito.FontSize = 10
3968:         loc_oPg.lbl_4c_SituacaoCredito.FontBold = .T.
3969:         loc_oPg.lbl_4c_SituacaoCredito.ForeColor = RGB(0, 0, 255)
3970: 
3971:         loc_oPg.AddObject("pgf_4c_Credito", "PageFrame")
3972:         WITH loc_oPg.pgf_4c_Credito
3973:             .Top       = 96
3974:             .Left      = 0
3975:             .Width     = 1003
3976:             .Height    = 408
3977:             .PageCount = 1
3978:             .Tabs      = .F.
3979:             .Themes    = .F.
3980:             .Visible   = .T.
3981:             .Page1.Caption = "Consultas"
3982:         ENDWITH
3983:         loc_oCns = loc_oPg.pgf_4c_Credito.Page1
3984: 
3985:         *-- Cnt_banco
3986:         loc_oCns.AddObject("cnt_4c_CreditoBanco", "Container")
3987:         WITH loc_oCns.cnt_4c_CreditoBanco
3988:             .Top       = 273
3989:             .Left      = 170
3990:             .Width     = 479
3991:             .Height    = 40
3992:             .BackStyle = 0
3993:             .Visible   = .T.
3994:         ENDWITH
3995:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoBanco, "lbl_4c_Bco",   1, 6,   30, 15, "Bco")
3996:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoBanco, "lbl_4c_Age",   1, 43,  40, 15, "Ag" + CHR(234) + "ncia")
3997:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoBanco, "lbl_4c_Cta",   1, 95,  40, 15, "Conta")
3998:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoBanco, "lbl_4c_NumI",  1, 173, 65, 15, "Num.Inicial")
3999:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoBanco, "lbl_4c_NumF",  1, 265, 60, 15, "Num.Final")
4000:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoBanco, "lbl_4c_Serie", 1, 357, 40, 15, "S" + CHR(233) + "rie")
4001:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoBanco, "lbl_4c_DtAb",  1, 408, 70, 15, "Dt Abertura")
4002:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoBanco, "lbl_4c_Dig1",  0, 238, 24, 17, "Dig.")
4003:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoBanco, "lbl_4c_Dig2",  0, 327, 24, 17, "Dig.")
4004: 
4005:         WITH loc_oCns.cnt_4c_CreditoBanco
4006:             .AddObject("txt_4c_CBancos", "TextBox")
4007:             .txt_4c_CBancos.Top           = 13
4008:             .txt_4c_CBancos.Left          = 3
4009:             .txt_4c_CBancos.Width         = 36
4010:             .txt_4c_CBancos.Height        = 23
4011:             .txt_4c_CBancos.Value         = ""
4012:             .txt_4c_CBancos.ControlSource = "dbCredito.Cbancos"
4013:             .txt_4c_CBancos.Visible       = .T.
4014: 
4015:             .AddObject("txt_4c_CAgencias", "TextBox")
4016:             .txt_4c_CAgencias.Top           = 13
4017:             .txt_4c_CAgencias.Left          = 47
4018:             .txt_4c_CAgencias.Width         = 38
4019:             .txt_4c_CAgencias.Height        = 23
4020:             .txt_4c_CAgencias.Value         = ""
4021:             .txt_4c_CAgencias.ControlSource = "dbCredito.Cagencias"
4022:             .txt_4c_CAgencias.Visible       = .T.
4023: 
4024:             .AddObject("txt_4c_CContas", "TextBox")
4025:             .txt_4c_CContas.Top           = 13
4026:             .txt_4c_CContas.Left          = 92
4027:             .txt_4c_CContas.Width         = 80
4028:             .txt_4c_CContas.Height        = 23
4029:             .txt_4c_CContas.Value         = ""
4030:             .txt_4c_CContas.ControlSource = "dbCredito.Ccontas"
4031:             .txt_4c_CContas.Visible       = .T.
4032: 
4033:             .AddObject("txt_4c_CCheInis", "TextBox")
4034:             .txt_4c_CCheInis.Top           = 13
4035:             .txt_4c_CCheInis.Left          = 177
4036:             .txt_4c_CCheInis.Width         = 52
4037:             .txt_4c_CCheInis.Height        = 23
4038:             .txt_4c_CCheInis.Value         = ""
4039:             .txt_4c_CCheInis.ControlSource = "dbCredito.Ccheinis"
4040:             .txt_4c_CCheInis.Visible       = .T.
4041: 
4042:             .AddObject("txt_4c_CDigInis", "TextBox")
4043:             .txt_4c_CDigInis.Top           = 13
4044:             .txt_4c_CDigInis.Left          = 240
4045:             .txt_4c_CDigInis.Width         = 17
4046:             .txt_4c_CDigInis.Height        = 23
4047:             .txt_4c_CDigInis.Value         = ""
4048:             .txt_4c_CDigInis.ControlSource = "dbCredito.Cdiginis"
4049:             .txt_4c_CDigInis.Visible       = .T.
4050: 
4051:             .AddObject("txt_4c_CCheFins", "TextBox")
4052:             .txt_4c_CCheFins.Top           = 13
4053:             .txt_4c_CCheFins.Left          = 268
4054:             .txt_4c_CCheFins.Width         = 52
4055:             .txt_4c_CCheFins.Height        = 23
4056:             .txt_4c_CCheFins.Value         = ""
4057:             .txt_4c_CCheFins.ControlSource = "dbCredito.Cchefins"
4058:             .txt_4c_CCheFins.Visible       = .T.
4059: 
4060:             .AddObject("txt_4c_CDigFins", "TextBox")
4061:             .txt_4c_CDigFins.Top           = 13
4062:             .txt_4c_CDigFins.Left          = 329
4063:             .txt_4c_CDigFins.Width         = 17
4064:             .txt_4c_CDigFins.Height        = 23
4065:             .txt_4c_CDigFins.Value         = ""
4066:             .txt_4c_CDigFins.ControlSource = "dbCredito.Cdigfins"
4067:             .txt_4c_CDigFins.Visible       = .T.
4068: 
4069:             .AddObject("txt_4c_CSeries", "TextBox")
4070:             .txt_4c_CSeries.Top           = 13
4071:             .txt_4c_CSeries.Left          = 354
4072:             .txt_4c_CSeries.Width         = 52
4073:             .txt_4c_CSeries.Height        = 23
4074:             .txt_4c_CSeries.Value         = ""
4075:             .txt_4c_CSeries.ControlSource = "dbCredito.Cseries"
4076:             .txt_4c_CSeries.Visible       = .T.
4077: 
4078:             .AddObject("txt_4c_CDAberts", "TextBox")
4079:             .txt_4c_CDAberts.Top           = 13
4080:             .txt_4c_CDAberts.Left          = 413
4081:             .txt_4c_CDAberts.Width         = 59
4082:             .txt_4c_CDAberts.Height        = 23
4083:             .txt_4c_CDAberts.Value         = ""
4084:             .txt_4c_CDAberts.ControlSource = "dbCredito.Cdaberts"
4085:             .txt_4c_CDAberts.Visible       = .T.
4086:         ENDWITH
4087: 
4088:         *-- Cnt_Valor
4089:         loc_oCns.AddObject("cnt_4c_CreditoValor", "Container")
4090:         WITH loc_oCns.cnt_4c_CreditoValor
4091:             .Top       = 230
4092:             .Left      = 170
4093:             .Width     = 372
4094:             .Height    = 40
4095:             .BackStyle = 0
4096:             .Visible   = .T.
4097:         ENDWITH
4098:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoValor, "lbl_4c_ValorCredito", 0, 166, 39, 17, "Valor")
4099:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoValor, "lbl_4c_DtVenc",       0, 272, 83, 15, "Data Vencimento")
4100:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoValor, "lbl_4c_CpfCredito",   0, 11,  43, 15, "C.P.F. : ")
4101:         WITH loc_oCns.cnt_4c_CreditoValor
4102:             .AddObject("txt_4c_NrCpf", "TextBox")
4103:             .txt_4c_NrCpf.Top           = 12
4104:             .txt_4c_NrCpf.Left          = 8
4105:             .txt_4c_NrCpf.Width         = 150
4106:             .txt_4c_NrCpf.Height        = 23
4107:             .txt_4c_NrCpf.Value         = ""
4108:             .txt_4c_NrCpf.ControlSource = "dbCredito.Ccpfs"
4109:             .txt_4c_NrCpf.Visible       = .T.
4110: 
4111:             .AddObject("txt_4c_Valor", "TextBox")
4112:             .txt_4c_Valor.Top           = 12
4113:             .txt_4c_Valor.Left          = 166
4114:             .txt_4c_Valor.Width         = 108
4115:             .txt_4c_Valor.Height        = 23
4116:             .txt_4c_Valor.Value         = 0
4117:             .txt_4c_Valor.ControlSource = "dbCredito.Nvalors"
4118:             .txt_4c_Valor.InputMask     = "999,999,999.99"
4119:             .txt_4c_Valor.Visible       = .T.
4120: 
4121:             .AddObject("txt_4c_DtVenc", "TextBox")
4122:             .txt_4c_DtVenc.Top           = 12
4123:             .txt_4c_DtVenc.Left          = 281
4124:             .txt_4c_DtVenc.Width         = 80
4125:             .txt_4c_DtVenc.Height        = 23
4126:             .txt_4c_DtVenc.Value         = {}
4127:             .txt_4c_DtVenc.ControlSource = "dbCredito.Dvencs"
4128:             .txt_4c_DtVenc.Visible       = .T.
4129:         ENDWITH
4130: 
4131:         *-- Grade (crSigFiCp)
4132:         loc_oCns.AddObject("grd_4c_Credito", "Grid")
4133:         loc_oGrid = loc_oCns.grd_4c_Credito
4134:         WITH loc_oGrid
4135:             .Top          = 45
4136:             .Left         = 170
4137:             .Width        = 658
4138:             .Height       = 182
4139:             .FontName     = "Courier New"
4140:             .DeleteMark   = .F.
4141:             .RecordMark   = .F.

*-- Linhas 4149 a 4231:
4149:             .Visible      = .T.
4150: 
4151:             .Columns(1).ControlSource = "dbCredito.Tipos"
4152:             .Columns(1).Header1.Caption = ""
4153:             .Columns(1).Width = 30
4154:             .Columns(1).ReadOnly = .T.
4155: 
4156:             .Columns(2).ControlSource = "dbCredito.Usuars"
4157:             .Columns(2).Header1.Caption = "Usu" + CHR(225) + "rio"
4158:             .Columns(2).Width = 100
4159:             .Columns(2).ReadOnly = .T.
4160: 
4161:             .Columns(3).ControlSource = "dbCredito.Emps"
4162:             .Columns(3).Header1.Caption = "Emp"
4163:             .Columns(3).Width = 50
4164:             .Columns(3).ReadOnly = .T.
4165: 
4166:             .Columns(4).ControlSource = "dbCredito.Datas"
4167:             .Columns(4).Header1.Caption = "Data / Hora"
4168:             .Columns(4).Width = 120
4169:             .Columns(4).ReadOnly = .T.
4170: 
4171:             .Columns(5).ControlSource = "dbCredito.Dopes"
4172:             .Columns(5).Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
4173:             .Columns(5).Width = 160
4174:             .Columns(5).ReadOnly = .T.
4175: 
4176:             .Columns(6).ControlSource = "dbCredito.Numes"
4177:             .Columns(6).Header1.Caption = "No. Oper"
4178:             .Columns(6).Width = 100
4179:             .Columns(6).ReadOnly = .T.
4180:         ENDWITH
4181: 
4182:         *-- Cnt_Docs
4183:         loc_oCns.AddObject("cnt_4c_CreditoDocs", "Container")
4184:         WITH loc_oCns.cnt_4c_CreditoDocs
4185:             .Top       = 230
4186:             .Left      = 545
4187:             .Width     = 185
4188:             .Height    = 40
4189:             .BackStyle = 0
4190:             .Visible   = .T.
4191:         ENDWITH
4192:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoDocs, "lbl_4c_TipoDocto", 1, 11, 53, 15, "Tipo Docto")
4193:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoDocs, "lbl_4c_DataDocto", 1, 97, 25, 15, "Data")
4194:         WITH loc_oCns.cnt_4c_CreditoDocs
4195:             .AddObject("obj_4c_OptDocs", "OptionGroup")
4196:             WITH .obj_4c_OptDocs
4197:                 .Top           = 15
4198:                 .Left          = 5
4199:                 .Width         = 89
4200:                 .Height        = 25
4201:                 .ButtonCount   = 2
4202:                 .BackStyle     = 0
4203:                 .BorderStyle   = 0
4204:                 .ControlSource = "dbCredito.NChkDocs"
4205:                 WITH .Buttons(1)
4206:                     .Caption   = "RG"
4207:                     .Top       = 5
4208:                     .Left      = 5
4209:                     .BackStyle = 0
4210:                     .FontSize  = 8
4211:                 ENDWITH
4212:                 WITH .Buttons(2)
4213:                     .Caption   = "CNH"
4214:                     .Top       = 5
4215:                     .Left      = 45
4216:                     .Height    = 15
4217:                     .BackStyle = 0
4218:                     .FontSize  = 8
4219:                 ENDWITH
4220:                 .Visible = .T.
4221:             ENDWITH
4222: 
4223:             .AddObject("txt_4c_DataDoc", "TextBox")
4224:             WITH .txt_4c_DataDoc
4225:                 .Top           = 14
4226:                 .Left          = 95
4227:                 .Width         = 85
4228:                 .Height        = 23
4229:                 .Value         = {}
4230:                 .ControlSource = "dbCredito.TdDocs"
4231:                 .Visible       = .T.

*-- Linhas 4245 a 4254:
4245: 
4246:         *-- Membro alcancado por NOME: EVALUATE na leitura (regra #15/#34)
4247:         WITH EVALUATE("par_oPagina." + par_cNome)
4248:             .Top         = par_nTop
4249:             .Left        = par_nLeft
4250:             .Width       = par_nWidth
4251:             .Height      = par_nHeight
4252:             .BackStyle   = 0
4253:             .BorderColor = RGB(90, 90, 90)
4254:             .Visible     = .T.

*-- Linhas 4267 a 4285:
4267:         par_oPagina.AddObject(par_cNome, "Label")
4268: 
4269:         WITH EVALUATE("par_oPagina." + par_cNome)
4270:             .Top       = par_nTop
4271:             .Left      = par_nLeft
4272:             .Width     = par_nWidth
4273:             .Height    = par_nHeight
4274:             .AutoSize  = .F.
4275:             .Alignment = 0
4276:             .FontName  = "Tahoma"
4277:             .FontSize  = 8
4278:             .BackStyle = 0
4279:             .ForeColor = RGB(90, 90, 90)
4280:             .Caption   = par_cCaption
4281:             .Visible   = .T.
4282:         ENDWITH
4283:     ENDPROC
4284: 
4285:     *==========================================================================

*-- Linhas 4293 a 4302:
4293:         par_oPagina.AddObject(par_cNome, "TextBox")
4294: 
4295:         WITH EVALUATE("par_oPagina." + par_cNome)
4296:             .Top           = par_nTop
4297:             .Left          = par_nLeft
4298:             .Width         = par_nWidth
4299:             .Height        = par_nHeight
4300:             .FontName      = "Tahoma"
4301:             .FontSize      = 8
4302:             .ReadOnly      = .T.

*-- Linhas 4470 a 4478:
4470:     * 0=1" no legado) - eh o que diz ao usuario que o filtro excluiu tudo.
4471:     * O filtro de grupo (SET KEY) e o de tipos (SET FILTER) sao independentes e
4472:     * convivem, como no legado.
4473:     * PUBLIC: chamado pelos handlers do CheckBox e pelo harness de teste.
4474:     *==========================================================================
4475:     PROCEDURE FiltrarTipos()
4476:         LOCAL loc_cTipos, loc_oAba, loc_oErro
4477: 
4478:         TRY

*-- Linhas 4542 a 4550:
4542:     ENDPROC
4543: 
4544:     *==========================================================================
4545:     * ChkTipoPendMouseDown - Suprime o toggle nativo do CheckBox (NoDefault do
4546:     * MouseDown legado): quem alterna o valor eh o MouseUp/KeyPress.
4547:     *==========================================================================
4548:     PROCEDURE ChkTipoPendMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
4549:         NODEFAULT
4550:     ENDPROC

*-- Linhas 5383 a 5392:
5383:                 *-- Moeda do limite de credito nos dois rotulos "R$" do legado
5384:                 loc_cMoeda = ALLTRIM(loc_oBO.this_cMoedaPadrao)
5385:                 IF !EMPTY(loc_cMoeda)
5386:                     loc_oAba.lbl_4c_MoedaConta.Caption = loc_cMoeda
5387:                     loc_oAba.lbl_4c_MoedaHist.Caption  = loc_cMoeda
5388:                 ENDIF
5389: 
5390:                 loc_oAba.Refresh()
5391:             ENDIF
5392:         CATCH TO loc_oErro

*-- Linhas 5571 a 5579:
5571:                 loc_cNums = ALLTRIM(dbCheqHist.Nums)
5572: 
5573:                 IF !EMPTY(loc_cNums)
5574:                     THIS.Caption = "Hist" + CHR(243) + "rico de Cheques de: " + ;
5575:                         ALLTRIM(loc_oBO.this_cConta) + " - " + ;
5576:                         ALLTRIM(loc_oBO.this_cDescConta) + " / " + ALLTRIM(loc_oBO.this_cCpf)
5577: 
5578:                     loc_oBO.CarregarMovimentoCheque(loc_cNums)
5579: 

*-- Linhas 5622 a 5633:
5622:                 loc_oAba.pgf_4c_Credito.Page1.grd_4c_Credito.Refresh()
5623: 
5624:                 IF VARTYPE(loc_oBO) = "O"
5625:                     loc_oAba.lbl_4c_SituacaoCredito.Caption = ;
5626:                         IIF(EMPTY(loc_oBO.this_cLabelSituacaoCredito), ;
5627:                             "CLIENTE", ALLTRIM(loc_oBO.this_cLabelSituacaoCredito))
5628:                     loc_oAba.lbl_4c_SituacaoCredito.ForeColor = ;
5629:                         IIF(loc_oBO.this_lSituacaoVermelha, RGB(255, 0, 0), RGB(0, 0, 255))
5630:                 ENDIF
5631:             ENDIF
5632:         CATCH TO loc_oErro
5633:             MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 6074 a 6103:
6074:                 loc_nLeft    = 769
6075: 
6076:                 IF !loc_lCadastro
6077:                     loc_oGrp.Buttons(2).Left = 5
6078:                     loc_oGrp.Buttons(3).Left = 80
6079:                     loc_nLargura = loc_nLargura - 81
6080:                     loc_nLeft    = loc_nLeft + 81
6081:                 ENDIF
6082: 
6083:                 IF !loc_lMovimenta
6084:                     loc_oGrp.Buttons(3).Left = IIF(loc_lCadastro, 80, 5)
6085:                     loc_nLargura = loc_nLargura - 81
6086:                     loc_nLeft    = loc_nLeft + 81
6087:                 ENDIF
6088: 
6089:                 loc_oGrp.Width = loc_nLargura
6090:                 loc_oGrp.Left  = loc_nLeft
6091:             ENDIF
6092: 
6093:             *-- Pagina Resultado
6094:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
6095: 
6096:             IF PEMSTATUS(loc_oPg2, "cmd_4c_Imprime", 5)
6097:                 loc_oPg2.cmd_4c_Imprime.Visible = (loc_lResultado AND loc_lImprimir)
6098:                 loc_oPg2.cmd_4c_Imprime.Enabled = loc_oPg2.cmd_4c_Imprime.Visible
6099:             ENDIF
6100: 
6101:             IF PEMSTATUS(loc_oPg2, "cmg_4c_MudaCli", 5)
6102:                 loc_oPg2.cmg_4c_MudaCli.Visible = ;
6103:                     (loc_lResultado AND loc_lVisaoMov AND loc_lCadastro)

