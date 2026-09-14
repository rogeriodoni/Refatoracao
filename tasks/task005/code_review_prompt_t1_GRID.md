# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 511: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES GRID/CURSOR
- [MADDCOLUNA] mAddColuna com parametro numerico. Assinatura: (campo, mascara, titulo) - TODOS strings
- [GRID-HEADERS] Apos RecordSource, Header1.Caption resetado para nome do campo. REDEFINIR todos os captions
- [SQLEXEC-GRID] SQLEXEC direto no cursor do Grid destroi colunas. Usar cursor temp + ZAP + APPEND
- [CREATE-CURSOR-NULL] SET NULL ON antes de CREATE CURSOR (APPEND de dados com NULL falha)
- [RECORDSOURCE-WITH] RecordSource/ColumnCount FORA do WITH block (dentro causa "Unknown member COLUMN1")
- [CURSOR-DUPLICADO] CREATE CURSOR duplicado com ordem diferente de campos
- [GRID-RECORDSOURCE-AUTOBIND] Apos .RecordSource =, REDEFINIR .ControlSource de TODAS as colunas

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS GRID (5661 linhas total):

*-- Linhas 471 a 596:
471:         *----------------------------------------------------------------------
472:         *-- Grid lista principal (Grade: Top=173+29=202, Left=38, W=922, H=409)
473:         *-- 7 colunas: cpros, dpros, cgrus, subgru, reffs, usuario, inativo(chk)
474:         *-- Conteudo detalhado (colunas, ControlSource): FASE 4
475:         *----------------------------------------------------------------------
476:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
477:         WITH loc_oPagina.grd_4c_Lista
478:             .Top             = 202
479:             .Left            = 38
480:             .Width           = 922
481:             .Height          = 409
482:             .FontName        = "Tahoma"
483:             .FontSize        = 8
484:             .GridLines       = 1
485:             .GridLineColor   = RGB(200, 200, 200)
486:             .HeaderHeight    = 23
487:             .RowHeight       = 20
488:             .DeleteMark      = .F.
489:             .RecordMark      = .F.
490:             .Themes          = .F.
491:             .ReadOnly        = .T.
492:             .ColumnCount     = 0
493:             .Visible         = .T.
494:         ENDWITH
495:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "GrdListaDblClick")
496: 
497:         *-- Criar cursor placeholder ANTES do RecordSource (evita auto-bind errado)
498:         *-- Campos: cpros, dpros, cgrus, sgrus, reffs, colecoes, ImpEtiqs(L), Situas(N)
499:         IF USED("cursor_4c_Lista")
500:             USE IN cursor_4c_Lista
501:         ENDIF
502:         SET NULL ON
503:         CREATE CURSOR cursor_4c_Lista ;
504:             (cpros C(25), dpros C(80), cgrus C(5), sgrus C(5), ;
505:              reffs C(25), colecoes C(20), ImpEtiqs L, Situas N(1,0))
506:         SET NULL OFF
507: 
508:         *-- RecordSource + ColumnCount OBRIGATORIAMENTE FORA do WITH (regra VFP9)
509:         LOCAL loc_oGrid
510:         loc_oGrid = loc_oPagina.grd_4c_Lista
511:         loc_oGrid.RecordSource = "cursor_4c_Lista"
512:         loc_oGrid.ColumnCount  = 7
513: 
514:         *-- Coluna 1: Produto (CPros) - 100px
515:         WITH loc_oGrid.Column1
516:             .ControlSource   = "cursor_4c_Lista.cpros"
517:             .Width           = 100
518:             .ReadOnly        = .T.
519:             .Header1.Caption = "Produto"
520:             .DynamicForeColor = "IIF(cursor_4c_Lista.Situas=1,RGB(0,0,0),RGB(255,0,0))"
521:         ENDWITH
522: 
523:         *-- Coluna 2: Descricao (DPros) - 305px
524:         WITH loc_oGrid.Column2
525:             .ControlSource   = "cursor_4c_Lista.dpros"
526:             .Width           = 305
527:             .ReadOnly        = .T.
528:             .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
529:             .DynamicForeColor = "IIF(cursor_4c_Lista.Situas=1,RGB(0,0,0),RGB(255,0,0))"
530:         ENDWITH
531: 
532:         *-- Coluna 3: Grupo (CGrus) - 65px
533:         WITH loc_oGrid.Column3
534:             .ControlSource   = "cursor_4c_Lista.cgrus"
535:             .Width           = 65
536:             .ReadOnly        = .T.
537:             .Header1.Caption = "Grupo"
538:             .DynamicForeColor = "IIF(cursor_4c_Lista.Situas=1,RGB(0,0,0),RGB(255,0,0))"
539:         ENDWITH
540: 
541:         *-- Coluna 4: Subgrupo (SGrus) - 65px
542:         WITH loc_oGrid.Column4
543:             .ControlSource   = "cursor_4c_Lista.sgrus"
544:             .Width           = 65
545:             .ReadOnly        = .T.
546:             .Header1.Caption = "Subgrp."
547:             .DynamicForeColor = "IIF(cursor_4c_Lista.Situas=1,RGB(0,0,0),RGB(255,0,0))"
548:         ENDWITH
549: 
550:         *-- Coluna 5: Ref. Fornecedor (Reffs) - 155px
551:         WITH loc_oGrid.Column5
552:             .ControlSource   = "cursor_4c_Lista.reffs"
553:             .Width           = 155
554:             .ReadOnly        = .T.
555:             .Header1.Caption = "Ref. Fornecedor"
556:             .DynamicForeColor = "IIF(cursor_4c_Lista.Situas=1,RGB(0,0,0),RGB(255,0,0))"
557:         ENDWITH
558: 
559:         *-- Coluna 6: Grp.Venda (Colecoes) - 150px
560:         WITH loc_oGrid.Column6
561:             .ControlSource   = "cursor_4c_Lista.colecoes"
562:             .Width           = 150
563:             .ReadOnly        = .T.
564:             .Header1.Caption = "Grp.Venda"
565:             .DynamicForeColor = "IIF(cursor_4c_Lista.Situas=1,RGB(0,0,0),RGB(255,0,0))"
566:         ENDWITH
567: 
568:         *-- Coluna 7: ImpEtiqs CheckBox ("I") - 30px
569:         *-- OBRIGATORIO: AddObject ANTES de CurrentControl ANTES de ControlSource
570:         loc_oGrid.Column7.AddObject("Check1", "CheckBox")
571:         loc_oGrid.Column7.CurrentControl    = "Check1"
572:         loc_oGrid.Column7.ControlSource     = "cursor_4c_Lista.ImpEtiqs"
573:         loc_oGrid.Column7.Width             = 30
574:         loc_oGrid.Column7.ReadOnly          = .T.
575:         loc_oGrid.Column7.Header1.Caption   = "I"
576:         WITH loc_oGrid.Column7.Check1
577:             .Caption   = ""
578:             .BackStyle = 0
579:             .Enabled   = .F.
580:             .Themes    = .F.
581:         ENDWITH
582: 
583:         *-- Label contador de registros (lblProdutos: Top=584+29=613 mas limitado)
584:         loc_oPagina.AddObject("lbl_4c_Contador", "Label")
585:         WITH loc_oPagina.lbl_4c_Contador
586:             .Caption   = "Produtos Selecionados : 0"
587:             .Top       = 613
588:             .Left      = 38
589:             .Width     = 200
590:             .Height    = 15
591:             .FontName  = "Tahoma"
592:             .FontSize  = 8
593:             .BackStyle = 0
594:             .ForeColor = RGB(60, 60, 60)
595:             .Visible   = .T.
596:         ENDWITH

*-- Linhas 3273 a 3322:
3273:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Temp_Pro")
3274: 
3275:                 IF loc_nResult > 0
3276:                     *-- ZAP + APPEND mantem RecordSource do grid intacto (nao destroi colunas)
3277:                     SELECT cursor_4c_Lista
3278:                     ZAP
3279:                     IF RECCOUNT("cursor_4c_Temp_Pro") > 0
3280:                         APPEND FROM DBF("cursor_4c_Temp_Pro")
3281:                     ENDIF
3282:                     IF USED("cursor_4c_Temp_Pro")
3283:                         USE IN cursor_4c_Temp_Pro
3284:                     ENDIF
3285:                     GO TOP IN cursor_4c_Lista
3286:                 ELSE
3287:                     AERROR(loc_aErros)
3288:                     MsgErro("Erro ao consultar produtos:" + CHR(13) + ;
3289:                         TRANSFORM(loc_aErros(1, 2)), "Erro SQL")
3290:                     IF USED("cursor_4c_Temp_Pro")
3291:                         USE IN cursor_4c_Temp_Pro
3292:                     ENDIF
3293:                 ENDIF
3294: 
3295:                 *-- Atualizar contador
3296:                 IF PEMSTATUS(loc_oPg1, "lbl_4c_Contador", 5)
3297:                     loc_oPg1.lbl_4c_Contador.Caption = "Produtos Selecionados : " + ;
3298:                         TRANSFORM(RECCOUNT("cursor_4c_Lista"))
3299:                 ENDIF
3300: 
3301:                 *-- Refresh grid
3302:                 loc_oGrid = loc_oPg1.grd_4c_Lista
3303:                 IF PEMSTATUS(loc_oGrid, "Refresh", 5)
3304:                     loc_oGrid.Refresh()
3305:                 ENDIF
3306: 
3307:                 loc_lSucesso = .T.
3308:             ENDIF
3309:         CATCH TO loc_oErro
3310:             MsgErro("Erro ao carregar lista de produtos:" + CHR(13) + loc_oErro.Message, "Erro")
3311:         ENDTRY
3312: 
3313:         RETURN loc_lSucesso
3314:     ENDPROC
3315: 
3316:     *--------------------------------------------------------------------------
3317:     * BOParaForm - Transfere dados do BO para os campos do formulario
3318:     * FASE 5: Implementar apos adicionar campos em ConfigurarPaginaDados
3319:     *--------------------------------------------------------------------------
3320:     PROTECTED PROCEDURE BOParaForm()
3321:         LOCAL loc_oPg1, loc_oBO
3322:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1

*-- Linhas 3721 a 3745:
3721:         TRY
3722:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3723:             IF !ISNULL(loc_oBusca)
3724:                 loc_oBusca.mAddColuna("cpros", "XXXXXXXXXXXXXX",                             "Produto")
3725:                 loc_oBusca.mAddColuna("dpros", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
3726:                 loc_oBusca.Caption = "Buscar Produto"
3727:                 loc_oBusca.Show()
3728:                 IF loc_oBusca.this_lSelecionou
3729:                     loc_cCod = ALLTRIM(loc_oBusca.this_cCodigoSelecionado)
3730:                 ENDIF
3731:                 IF USED("cursor_4c_Busca")
3732:                     USE IN cursor_4c_Busca
3733:                 ENDIF
3734:                 loc_oBusca.Release()
3735:             ENDIF
3736:         CATCH TO loc_oErro
3737:             MsgErro("Erro na busca de produto:" + CHR(13) + loc_oErro.Message, "Erro")
3738:         ENDTRY
3739:         loc_oBusca = .NULL.
3740:         IF !EMPTY(loc_cCod)
3741:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
3742:             loc_oPg1.txt_4c_Cpro.Value = loc_cCod
3743:         ENDIF
3744:     ENDPROC
3745: 

*-- Linhas 4394 a 4418:
4394:         TRY
4395:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4396:             IF !ISNULL(loc_oBusca)
4397:                 loc_oBusca.mAddColuna("cgrus", "XXXXX",                                  "Grupo")
4398:                 loc_oBusca.mAddColuna("dgrus", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4399:                 loc_oBusca.Caption = "Buscar Grupo de Produto"
4400:                 loc_oBusca.Show()
4401:                 IF loc_oBusca.this_lSelecionou
4402:                     loc_cCgru = ALLTRIM(loc_oBusca.this_cCodigoSelecionado)
4403:                     IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4404:                         loc_cSQL    = "SELECT ISNULL(DGrus,'') AS DGrus FROM SigCdGrp " + ;
4405:                                       "WHERE CGrus = " + EscaparSQL(PADR(loc_cCgru, 3))
4406:                         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruL")
4407:                         IF loc_nResult > 0 AND RECCOUNT("cursor_4c_GruL") > 0
4408:                             loc_cDgru = ALLTRIM(cursor_4c_GruL.DGrus)
4409:                         ENDIF
4410:                         IF USED("cursor_4c_GruL")
4411:                             USE IN cursor_4c_GruL
4412:                         ENDIF
4413:                     ENDIF
4414:                 ENDIF
4415:                 IF USED("cursor_4c_Busca")
4416:                     USE IN cursor_4c_Busca
4417:                 ENDIF
4418:                 loc_oBusca.Release()

*-- Linhas 4439 a 4463:
4439:         TRY
4440:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4441:             IF !ISNULL(loc_oBusca)
4442:                 loc_oBusca.mAddColuna("linhas", "XXXXXXXXXX",                               "Linha")
4443:                 loc_oBusca.mAddColuna("descs",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4444:                 loc_oBusca.Caption = "Buscar Linha"
4445:                 loc_oBusca.Show()
4446:                 IF loc_oBusca.this_lSelecionou
4447:                     loc_cLin = ALLTRIM(loc_oBusca.this_cCodigoSelecionado)
4448:                     IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4449:                         loc_cSQL    = "SELECT ISNULL(Descs,'') AS Descs FROM SigCdLin " + ;
4450:                                       "WHERE Linhas = " + EscaparSQL(PADR(loc_cLin, 10))
4451:                         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LinL")
4452:                         IF loc_nResult > 0 AND RECCOUNT("cursor_4c_LinL") > 0
4453:                             loc_cDLin = ALLTRIM(cursor_4c_LinL.Descs)
4454:                         ENDIF
4455:                         IF USED("cursor_4c_LinL")
4456:                             USE IN cursor_4c_LinL
4457:                         ENDIF
4458:                     ENDIF
4459:                 ENDIF
4460:                 IF USED("cursor_4c_Busca")
4461:                     USE IN cursor_4c_Busca
4462:                 ENDIF
4463:                 loc_oBusca.Release()

*-- Linhas 4484 a 4508:
4484:         TRY
4485:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4486:             IF !ISNULL(loc_oBusca)
4487:                 loc_oBusca.mAddColuna("colecoes", "XXXXXXXXXX",                               "Cole" + CHR(231) + CHR(227) + "o")
4488:                 loc_oBusca.mAddColuna("descs",    "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4489:                 loc_oBusca.Caption = "Buscar Grupo de Venda"
4490:                 loc_oBusca.Show()
4491:                 IF loc_oBusca.this_lSelecionou
4492:                     loc_cCol = ALLTRIM(loc_oBusca.this_cCodigoSelecionado)
4493:                     IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4494:                         loc_cSQL    = "SELECT ISNULL(Descs,'') AS Descs FROM SIGCDCOL " + ;
4495:                                       "WHERE Colecoes = " + EscaparSQL(PADR(loc_cCol, 10))
4496:                         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ColL")
4497:                         IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ColL") > 0
4498:                             loc_cDCol = ALLTRIM(cursor_4c_ColL.Descs)
4499:                         ENDIF
4500:                         IF USED("cursor_4c_ColL")
4501:                             USE IN cursor_4c_ColL
4502:                         ENDIF
4503:                     ENDIF
4504:                 ENDIF
4505:                 IF USED("cursor_4c_Busca")
4506:                     USE IN cursor_4c_Busca
4507:                 ENDIF
4508:                 loc_oBusca.Release()

*-- Linhas 4529 a 4553:
4529:         TRY
4530:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4531:             IF !ISNULL(loc_oBusca)
4532:                 loc_oBusca.mAddColuna("iclis", "XXXXXXXXXX",                               "Fornecedor")
4533:                 loc_oBusca.mAddColuna("rclis", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Raz" + CHR(227) + "o Social")
4534:                 loc_oBusca.Caption = "Buscar Fornecedor"
4535:                 loc_oBusca.Show()
4536:                 IF loc_oBusca.this_lSelecionou
4537:                     loc_cIfor = ALLTRIM(loc_oBusca.this_cCodigoSelecionado)
4538:                     IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4539:                         loc_cSQL    = "SELECT ISNULL(RClis,'') AS RClis FROM SIGCDCLI " + ;
4540:                                       "WHERE IClis = " + EscaparSQL(PADR(loc_cIfor, 10))
4541:                         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_IforL")
4542:                         IF loc_nResult > 0 AND RECCOUNT("cursor_4c_IforL") > 0
4543:                             loc_cDfor = ALLTRIM(cursor_4c_IforL.RClis)
4544:                         ENDIF
4545:                         IF USED("cursor_4c_IforL")
4546:                             USE IN cursor_4c_IforL
4547:                         ENDIF
4548:                     ENDIF
4549:                 ENDIF
4550:                 IF USED("cursor_4c_Busca")
4551:                     USE IN cursor_4c_Busca
4552:                 ENDIF
4553:                 loc_oBusca.Release()

*-- Linhas 4573 a 4597:
4573:         TRY
4574:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4575:             IF !ISNULL(loc_oBusca)
4576:                 loc_oBusca.mAddColuna("cods",  "XXXX",                                      "Cor")
4577:                 loc_oBusca.mAddColuna("descs", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4578:                 loc_oBusca.Caption = "Buscar Cor"
4579:                 loc_oBusca.Show()
4580:                 IF loc_oBusca.this_lSelecionou
4581:                     loc_cCod = ALLTRIM(loc_oBusca.this_cCodigoSelecionado)
4582:                 ENDIF
4583:                 IF USED("cursor_4c_Busca")
4584:                     USE IN cursor_4c_Busca
4585:                 ENDIF
4586:                 loc_oBusca.Release()
4587:             ENDIF
4588:         CATCH TO loc_oErro
4589:             MsgErro("Erro na busca de cor:" + CHR(13) + loc_oErro.Message, "Erro")
4590:         ENDTRY
4591:         loc_oBusca = .NULL.
4592:         IF !EMPTY(loc_cCod)
4593:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4594:             loc_oPg1.txt_4c_Cor.Value = loc_cCod
4595:         ENDIF
4596:     ENDPROC
4597: 

*-- Linhas 4605 a 4629:
4605:         TRY
4606:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4607:             IF !ISNULL(loc_oBusca)
4608:                 loc_oBusca.mAddColuna("cods",  "XXXX",                                      "Tamanho")
4609:                 loc_oBusca.mAddColuna("descs", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4610:                 loc_oBusca.Caption = "Buscar Tamanho"
4611:                 loc_oBusca.Show()
4612:                 IF loc_oBusca.this_lSelecionou
4613:                     loc_cCod = ALLTRIM(loc_oBusca.this_cCodigoSelecionado)
4614:                 ENDIF
4615:                 IF USED("cursor_4c_Busca")
4616:                     USE IN cursor_4c_Busca
4617:                 ENDIF
4618:                 loc_oBusca.Release()
4619:             ENDIF
4620:         CATCH TO loc_oErro
4621:             MsgErro("Erro na busca de tamanho:" + CHR(13) + loc_oErro.Message, "Erro")
4622:         ENDTRY
4623:         loc_oBusca = .NULL.
4624:         IF !EMPTY(loc_cCod)
4625:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4626:             loc_oPg1.txt_4c_Tam.Value = loc_cCod
4627:         ENDIF
4628:     ENDPROC
4629: 

*-- Linhas 4638 a 4662:
4638:         TRY
4639:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4640:             IF !ISNULL(loc_oBusca)
4641:                 loc_oBusca.mAddColuna("pkchave", "XXX",                                      "Modelo")
4642:                 loc_oBusca.mAddColuna("descs",   "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4643:                 loc_oBusca.Caption = "Buscar Modelo"
4644:                 loc_oBusca.Show()
4645:                 IF loc_oBusca.this_lSelecionou
4646:                     loc_cCod = ALLTRIM(loc_oBusca.this_cCodigoSelecionado)
4647:                     IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4648:                         loc_cSQL    = "SELECT ISNULL(Descs,'') AS Descs FROM sigcdmod " + ;
4649:                                       "WHERE Codigos = " + EscaparSQL(PADR(loc_cCod, 3))
4650:                         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ModL")
4651:                         IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ModL") > 0
4652:                             loc_cDes = ALLTRIM(cursor_4c_ModL.Descs)
4653:                         ENDIF
4654:                         IF USED("cursor_4c_ModL")
4655:                             USE IN cursor_4c_ModL
4656:                         ENDIF
4657:                     ENDIF
4658:                 ENDIF
4659:                 IF USED("cursor_4c_Busca")
4660:                     USE IN cursor_4c_Busca
4661:                 ENDIF
4662:                 loc_oBusca.Release()

*-- Linhas 4683 a 4707:
4683:         TRY
4684:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4685:             IF !ISNULL(loc_oBusca)
4686:                 loc_oBusca.mAddColuna("cods",   "XXX",                                      "Acabamento")
4687:                 loc_oBusca.mAddColuna("descrs", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4688:                 loc_oBusca.Caption = "Buscar Acabamento"
4689:                 loc_oBusca.Show()
4690:                 IF loc_oBusca.this_lSelecionou
4691:                     loc_cCod = ALLTRIM(loc_oBusca.this_cCodigoSelecionado)
4692:                     IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4693:                         loc_cSQL    = "SELECT ISNULL(Descrs,'') AS Descrs FROM SigCdAca " + ;
4694:                                       "WHERE Cods = " + EscaparSQL(PADR(loc_cCod, 3))
4695:                         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AcaL")
4696:                         IF loc_nResult > 0 AND RECCOUNT("cursor_4c_AcaL") > 0
4697:                             loc_cDes = ALLTRIM(cursor_4c_AcaL.Descrs)
4698:                         ENDIF
4699:                         IF USED("cursor_4c_AcaL")
4700:                             USE IN cursor_4c_AcaL
4701:                         ENDIF
4702:                     ENDIF
4703:                 ENDIF
4704:                 IF USED("cursor_4c_Busca")
4705:                     USE IN cursor_4c_Busca
4706:                 ENDIF
4707:                 loc_oBusca.Release()

*-- Linhas 4727 a 4751:
4727:         TRY
4728:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4729:             IF !ISNULL(loc_oBusca)
4730:                 loc_oBusca.mAddColuna("cpros", "XXXXXXXXXXXXXX",                             "Produto")
4731:                 loc_oBusca.mAddColuna("dpros", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4732:                 loc_oBusca.Caption = "Buscar Produto Equivalente"
4733:                 loc_oBusca.Show()
4734:                 IF loc_oBusca.this_lSelecionou
4735:                     loc_cCod = ALLTRIM(loc_oBusca.this_cCodigoSelecionado)
4736:                 ENDIF
4737:                 IF USED("cursor_4c_Busca")
4738:                     USE IN cursor_4c_Busca
4739:                 ENDIF
4740:                 loc_oBusca.Release()
4741:             ENDIF
4742:         CATCH TO loc_oErro
4743:             MsgErro("Erro na busca de produto equivalente:" + CHR(13) + loc_oErro.Message, "Erro")
4744:         ENDTRY
4745:         loc_oBusca = .NULL.
4746:         IF !EMPTY(loc_cCod)
4747:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4748:             loc_oPg1.txt_4c_CProEq.Value = loc_cCod
4749:         ENDIF
4750:     ENDPROC
4751: 

*-- Linhas 4760 a 4784:
4760:         TRY
4761:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4762:             IF !ISNULL(loc_oBusca)
4763:                 loc_oBusca.mAddColuna("Cods",  "XXXXX",                                    "Cod")
4764:                 loc_oBusca.mAddColuna("Descs", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4765:                 loc_oBusca.Caption = "Buscar Classifica" + CHR(231) + CHR(227) + "o"
4766:                 loc_oBusca.Show()
4767:                 IF loc_oBusca.this_lSelecionou
4768:                     loc_cCod = ALLTRIM(loc_oBusca.this_cCodigoSelecionado)
4769:                     IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4770:                         loc_cSQL    = "SELECT ISNULL(Descs,'') AS Descs FROM SigCdCls " + ;
4771:                                       "WHERE Cods = " + EscaparSQL(PADR(loc_cCod, 3))
4772:                         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClsL")
4773:                         IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ClsL") > 0
4774:                             loc_cDesc = ALLTRIM(cursor_4c_ClsL.Descs)
4775:                         ENDIF
4776:                         IF USED("cursor_4c_ClsL")
4777:                             USE IN cursor_4c_ClsL
4778:                         ENDIF
4779:                     ENDIF
4780:                 ENDIF
4781:                 IF USED("cursor_4c_Busca")
4782:                     USE IN cursor_4c_Busca
4783:                 ENDIF
4784:                 loc_oBusca.Release()

*-- Linhas 4804 a 4828:
4804:         TRY
4805:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4806:             IF !ISNULL(loc_oBusca)
4807:                 loc_oBusca.mAddColuna("Codigos",    "XXXXXXXXXX",                               "Cod")
4808:                 loc_oBusca.mAddColuna("Descricaos", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4809:                 loc_oBusca.Caption = "Buscar Local de Estoque"
4810:                 loc_oBusca.Show()
4811:                 IF loc_oBusca.this_lSelecionou
4812:                     loc_cCod = ALLTRIM(loc_oBusca.this_cCodigoSelecionado)
4813:                 ENDIF
4814:                 IF USED("cursor_4c_Busca")
4815:                     USE IN cursor_4c_Busca
4816:                 ENDIF
4817:                 loc_oBusca.Release()
4818:             ENDIF
4819:         CATCH TO loc_oErro
4820:             MsgErro("Erro na busca de local de estoque:" + CHR(13) + loc_oErro.Message, "Erro")
4821:         ENDTRY
4822:         loc_oBusca = .NULL.
4823:         IF !EMPTY(loc_cCod)
4824:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4825:             loc_oPg1.txt_4c_Local.Value = loc_cCod
4826:         ENDIF
4827:     ENDPROC
4828: 

*-- Linhas 4837 a 4861:
4837:         TRY
4838:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4839:             IF !ISNULL(loc_oBusca)
4840:                 loc_oBusca.mAddColuna("CUnis", "XXXXX",                                    "Unidade")
4841:                 loc_oBusca.mAddColuna("DUnis", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4842:                 loc_oBusca.Caption = "Buscar Unidade"
4843:                 loc_oBusca.Show()
4844:                 IF loc_oBusca.this_lSelecionou
4845:                     loc_cCod = ALLTRIM(loc_oBusca.this_cCodigoSelecionado)
4846:                     IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4847:                         loc_cSQL    = "SELECT ISNULL(DUnis,'') AS DUnis FROM SigCdUni " + ;
4848:                                       "WHERE CUnis = " + EscaparSQL(PADR(loc_cCod, 3))
4849:                         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UniL")
4850:                         IF loc_nResult > 0 AND RECCOUNT("cursor_4c_UniL") > 0
4851:                             loc_cDesc = ALLTRIM(cursor_4c_UniL.DUnis)
4852:                         ENDIF
4853:                         IF USED("cursor_4c_UniL")
4854:                             USE IN cursor_4c_UniL
4855:                         ENDIF
4856:                     ENDIF
4857:                 ENDIF
4858:                 IF USED("cursor_4c_Busca")
4859:                     USE IN cursor_4c_Busca
4860:                 ENDIF
4861:                 loc_oBusca.Release()

*-- Linhas 4882 a 4906:
4882:         TRY
4883:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4884:             IF !ISNULL(loc_oBusca)
4885:                 loc_oBusca.mAddColuna("CUnis", "XXXXX",                                    "Unidade")
4886:                 loc_oBusca.mAddColuna("DUnis", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4887:                 loc_oBusca.Caption = "Buscar Unidade de Pauta"
4888:                 loc_oBusca.Show()
4889:                 IF loc_oBusca.this_lSelecionou
4890:                     loc_cCod = ALLTRIM(loc_oBusca.this_cCodigoSelecionado)
4891:                     IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4892:                         loc_cSQL    = "SELECT ISNULL(DUnis,'') AS DUnis FROM SigCdUni " + ;
4893:                                       "WHERE CUnis = " + EscaparSQL(PADR(loc_cCod, 3))
4894:                         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UnipL")
4895:                         IF loc_nResult > 0 AND RECCOUNT("cursor_4c_UnipL") > 0
4896:                             loc_cDesc = ALLTRIM(cursor_4c_UnipL.DUnis)
4897:                         ENDIF
4898:                         IF USED("cursor_4c_UnipL")
4899:                             USE IN cursor_4c_UnipL
4900:                         ENDIF
4901:                     ENDIF
4902:                 ENDIF
4903:                 IF USED("cursor_4c_Busca")
4904:                     USE IN cursor_4c_Busca
4905:                 ENDIF
4906:                 loc_oBusca.Release()

*-- Linhas 4926 a 4950:
4926:         TRY
4927:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4928:             IF !ISNULL(loc_oBusca)
4929:                 loc_oBusca.mAddColuna("CMoes", "XXXXX",                                    "Moeda")
4930:                 loc_oBusca.mAddColuna("DMoes", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4931:                 loc_oBusca.Caption = "Buscar Moeda (Custo)"
4932:                 loc_oBusca.Show()
4933:                 IF loc_oBusca.this_lSelecionou
4934:                     loc_cCod = ALLTRIM(loc_oBusca.this_cCodigoSelecionado)
4935:                 ENDIF
4936:                 IF USED("cursor_4c_Busca")
4937:                     USE IN cursor_4c_Busca
4938:                 ENDIF
4939:                 loc_oBusca.Release()
4940:             ENDIF
4941:         CATCH TO loc_oErro
4942:             MsgErro("Erro na busca de moeda:" + CHR(13) + loc_oErro.Message, "Erro")
4943:         ENDTRY
4944:         loc_oBusca = .NULL.
4945:         IF !EMPTY(loc_cCod)
4946:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4947:             loc_oPg1.txt_4c_Mctotal.Value = loc_cCod
4948:         ENDIF
4949:     ENDPROC
4950: 

*-- Linhas 4958 a 4982:
4958:         TRY
4959:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4960:             IF !ISNULL(loc_oBusca)
4961:                 loc_oBusca.mAddColuna("CMoes", "XXXXX",                                    "Moeda")
4962:                 loc_oBusca.mAddColuna("DMoes", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4963:                 loc_oBusca.Caption = "Buscar Moeda (Pre" + CHR(231) + "o Venda)"
4964:                 loc_oBusca.Show()
4965:                 IF loc_oBusca.this_lSelecionou
4966:                     loc_cCod = ALLTRIM(loc_oBusca.this_cCodigoSelecionado)
4967:                 ENDIF
4968:                 IF USED("cursor_4c_Busca")
4969:                     USE IN cursor_4c_Busca
4970:                 ENDIF
4971:                 loc_oBusca.Release()
4972:             ENDIF
4973:         CATCH TO loc_oErro
4974:             MsgErro("Erro na busca de moeda:" + CHR(13) + loc_oErro.Message, "Erro")
4975:         ENDTRY
4976:         loc_oBusca = .NULL.
4977:         IF !EMPTY(loc_cCod)
4978:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4979:             loc_oPg1.txt_4c_Mpvenda.Value = loc_cCod
4980:         ENDIF
4981:     ENDPROC
4982: 

*-- Linhas 4990 a 5014:
4990:         TRY
4991:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4992:             IF !ISNULL(loc_oBusca)
4993:                 loc_oBusca.mAddColuna("CMoes", "XXXXX",                                    "Moeda")
4994:                 loc_oBusca.mAddColuna("DMoes", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4995:                 loc_oBusca.Caption = "Buscar Moeda (Fator Venda)"
4996:                 loc_oBusca.Show()
4997:                 IF loc_oBusca.this_lSelecionou
4998:                     loc_cCod = ALLTRIM(loc_oBusca.this_cCodigoSelecionado)
4999:                 ENDIF
5000:                 IF USED("cursor_4c_Busca")
5001:                     USE IN cursor_4c_Busca
5002:                 ENDIF
5003:                 loc_oBusca.Release()
5004:             ENDIF
5005:         CATCH TO loc_oErro
5006:             MsgErro("Erro na busca de moeda:" + CHR(13) + loc_oErro.Message, "Erro")
5007:         ENDTRY
5008:         loc_oBusca = .NULL.
5009:         IF !EMPTY(loc_cCod)
5010:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
5011:             loc_oPg1.txt_4c_Mfvenda.Value = loc_cCod
5012:         ENDIF
5013:     ENDPROC
5014: 

*-- Linhas 5281 a 5306:
5281:         TRY
5282:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
5283:             IF !ISNULL(loc_oBusca)
5284:                 loc_oBusca.mAddColuna("cpros",  "XXXXXXXXXXXXXXXXXXXXXXXXXX", "Produto")
5285:                 loc_oBusca.mAddColuna("dpros",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
5286:                 loc_oBusca.mAddColuna("cgrus",  "XXXXX", "Grupo")
5287:                 loc_oBusca.Caption = "Buscar Produto"
5288:                 loc_oBusca.Show()
5289:                 IF loc_oBusca.this_lSelecionou
5290:                     loc_cCodigo = ALLTRIM(loc_oBusca.this_cCodigoSelecionado)
5291:                 ENDIF
5292:                 IF USED("cursor_4c_Busca")
5293:                     USE IN cursor_4c_Busca
5294:                 ENDIF
5295:                 loc_oBusca.Release()
5296:             ENDIF
5297:         CATCH TO loc_oErro
5298:             MsgErro("Erro na busca de produtos:" + CHR(13) + loc_oErro.Message, "Erro")
5299:         ENDTRY
5300:         loc_oBusca = .NULL.
5301:         IF !EMPTY(loc_cCodigo)
5302:             THIS.CarregarLista()
5303:         ENDIF
5304:     ENDPROC
5305: 
5306:     *--------------------------------------------------------------------------

*-- Linhas 5402 a 5426:
5402:         TRY
5403:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
5404:             IF !ISNULL(loc_oBusca)
5405:                 loc_oBusca.mAddColuna("cgrus", "XXXXX",                                     "Grupo")
5406:                 loc_oBusca.mAddColuna("dgrus", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
5407:                 loc_oBusca.Caption = "Buscar Grupo de Produto"
5408:                 loc_oBusca.Show()
5409:                 IF loc_oBusca.this_lSelecionou
5410:                     loc_cCgru = ALLTRIM(loc_oBusca.this_cCodigoSelecionado)
5411:                     IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
5412:                         loc_cSQL = "SELECT ISNULL(DGrus,'') AS DGrus FROM SigCdGrp " + ;
5413:                                    "WHERE CGrus = " + EscaparSQL(PADR(loc_cCgru, 3))
5414:                         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruLookup")
5415:                         IF loc_nResult > 0 AND RECCOUNT("cursor_4c_GruLookup") > 0
5416:                             loc_cDgru = ALLTRIM(cursor_4c_GruLookup.DGrus)
5417:                         ENDIF
5418:                         IF USED("cursor_4c_GruLookup")
5419:                             USE IN cursor_4c_GruLookup
5420:                         ENDIF
5421:                     ENDIF
5422:                 ENDIF
5423:                 IF USED("cursor_4c_Busca")
5424:                     USE IN cursor_4c_Busca
5425:                 ENDIF
5426:                 loc_oBusca.Release()

*-- Linhas 5475 a 5498:
5475:     *--------------------------------------------------------------------------
5476:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
5477:         WITH par_oGrid
5478:             IF .ColumnCount > 0
5479:                 .FontName = "Tahoma"
5480:                 .FontSize = 8
5481:             ENDIF
5482:         ENDWITH
5483:     ENDPROC
5484: 
5485:     *--------------------------------------------------------------------------
5486:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
5487:     * Filtro por nome evita tornar visiveis containers flutuantes (Visible=.F.)
5488:     *--------------------------------------------------------------------------
5489:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
5490:         LOCAL loc_nI, loc_oObjeto
5491: 
5492:         FOR loc_nI = 1 TO par_oContainer.ControlCount
5493:             loc_oObjeto = par_oContainer.Controls(loc_nI)
5494: 
5495:             IF VARTYPE(loc_oObjeto) = "O"
5496:                 *-- Nao tornar visiveis containers flutuantes (iniciam com cnt_4c_Float)
5497:                 IF LEFT(LOWER(loc_oObjeto.Name), 13) != "cnt_4c_float_"
5498:                     IF PEMSTATUS(loc_oObjeto, "Visible", 5)


### BO (C:\4c\projeto\app\classes\ProdutoBO.prg):
*==============================================================================
* ProdutoBO.prg - Business Object para Cadastro de Produtos
* Tabela: SigCdPro | PK: cpros (C14)
* Data: 2026-04-09
*==============================================================================

DEFINE CLASS ProdutoBO AS BusinessBase

    *-- Identificacao
    this_cCpros     = ""   && C(14) - Codigo do produto (PK)
    this_cDpros     = ""   && C(65) - Descricao principal
    this_cDpro2s    = ""   && C(45) - Descricao secundaria (descritivo)

    *-- Classificacao/grupo
    this_cCgrus     = ""   && C(3)  - Grupo
    this_cSgrus     = ""   && C(6)  - Subgrupo
    this_cLinhas    = ""   && C(10) - Linha
    this_cColecoes  = ""   && C(10) - Colecao / Grupo de Venda
    this_cMercs     = ""   && C(3)  - Mercado
    this_cIdecpros  = ""   && C(3)  - Identificador
    this_cCclass    = ""   && C(3)  - Classificacao

    *-- Fornecedor
    this_cIfors     = ""   && C(10) - Codigo do fornecedor
    this_cReffs     = ""   && C(40) - Referencia do fornecedor

    *-- Codigos produto
    this_cCodfinp   = ""   && C(3)  - Codigo do modelo (finishing product)
    this_cCodacbs   = ""   && C(3)  - Codigo do acabamento
    this_cCodcors   = ""   && C(4)  - Codigo da cor
    this_cCodtams   = ""   && C(4)  - Codigo do tamanho
    this_cCproeqs   = ""   && C(14) - Produto equivalente

    *-- Status e datas
    this_nSituas    = 1    && N(1)  - Status: 1=Ativo, 2=Inativo
    this_dDatas     = {}   && Date  - Data do status
    this_dDtincs    = {}   && Date  - Data de inclusao (read-only)
    this_cUsuincs   = ""   && C(10) - Usuario de inclusao

    *-- Codigos de barra
    this_nCbars     = 0    && N(14,0) - Codigo de barra
    this_nEan13     = 0    && N(13,0) - EAN13/GTIN

    *-- Quantidades e lotes
    this_nLtminsv   = 0    && N(9,3) - Lote minimo de venda
    this_nQmins     = 0    && N(9,3) - Quantidade minima
    this_nQtped     = 0    && N(9,3) - Quantidade de pedido

    *-- Unidades
    this_cCunis     = ""   && C(3)  - Unidade (1)
    this_cCunips    = ""   && C(3)  - Unidade (2)

    *-- Pesos e dimensoes
    this_nPesobs    = 0    && N(7,3) - Peso bruto
    this_nPesoms    = 0    && N(8,3) - Peso medio/liquido

    *-- Localizacao
    this_cLocals    = ""   && C(10) - Local

    *-- Precos e custos
    this_nPvens     = 0    && N(11,5) - Preco de venda
    this_nFvendas   = 0    && N(7,3)  - Fator de venda
    this_nPcuss     = 0    && N(11,5) - Preco de custo
    this_cMoecs     = ""   && C(3)   - Moeda de custo
    this_cMoepvs    = ""   && C(3)   - Moeda de venda

    *-- Ultima compra
    this_dUltcomps  = {}   && Date  - Data da ultima compra
    this_nVultcomps = 0    && N(11,2) - Valor da ultima compra
    this_cMultcomps = ""   && C(3)   - Moeda da ultima compra
    this_nQultcomp  = 0    && N(9,3) - Qtde da ultima compra

    *-- Dias de garantia
    this_nDiasinas  = 0    && N(5,0) - Dias de garantia/inatividade

    *-- Checkboxes
    this_nConsigs   = 0    && N(1) - Consignado
    this_nFabrproprs= 0    && N(1) - Fabricacao propria
    this_nEncoms    = 0    && N(1) - Encomenda
    this_nChkfunds  = 0    && N(1) - Fundo

    *-- Observacoes
    this_cObspeds   = ""   && C(30) - Observacao 1
    this_cObspes    = ""   && C(30) - Observacao 2
    this_cObsetqs   = ""   && C(10) - Observacao componente

    *-- Memos (text fields)
    this_cDpro3s    = ""   && text  - Descricao completa
    this_cDsccompras= ""   && text  - Descricao compra
    this_cObscompras= ""   && text  - Observacao compra

    *-- Variacao e web
    this_nVarias    = 0    && N(1) - Variacao (0=nenhum, 1=cor-tam)
    this_nWebpros   = 0    && N(1) - Produto web (0=nenhum, 1=sim, 2=nao, 3=destaque)

    *-- Dimensoes
    this_nTamhs     = 0    && N(5,2) - Altura
    this_nTamls     = 0    && N(5,2) - Largura
    this_nTamps     = 0    && N(5,2) - Profundidade
    this_nVolumes   = 0    && N(3,0) - Volumes
    this_nTents     = 0    && N(3,0) - Entradas

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        DODEFAULT()
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "cpros"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN THIS.this_cCpros
    ENDPROC

    *--------------------------------------------------------------------------
    * NovoRegistro - Limpa propriedades para inclusao
    *--------------------------------------------------------------------------
    PROCEDURE NovoRegistro()
        DODEFAULT()
        THIS.this_cCpros      = ""
        THIS.this_cDpros      = ""
        THIS.this_cDpro2s     = ""
        THIS.this_cCgrus      = ""
        THIS.this_cSgrus      = ""
        THIS.this_cLinhas     = ""
        THIS.this_cColecoes   = ""
        THIS.this_cMercs      = ""
        THIS.this_cIdecpros   = ""
        THIS.this_cCclass     = ""
        THIS.this_cIfors      = ""
        THIS.this_cReffs      = ""
        THIS.this_cCodfinp    = ""
        THIS.this_cCodacbs    = ""
        THIS.this_cCodcors    = ""
        THIS.this_cCodtams    = ""
        THIS.this_cCproeqs    = ""
        THIS.this_nSituas     = 1
        THIS.this_dDatas      = DATE()
        THIS.this_dDtincs     = DATE()
        THIS.this_cUsuincs    = gc_4c_UsuarioLogado
        THIS.this_nCbars      = 0
        THIS.this_nEan13      = 0
        THIS.this_nLtminsv    = 0
        THIS.this_nQmins      = 0
        THIS.this_nQtped      = 0
        THIS.this_cCunis      = ""
        THIS.this_cCunips     = ""
        THIS.this_nPesobs     = 0
        THIS.this_nPesoms     = 0
        THIS.this_cLocals     = ""
        THIS.this_nPvens      = 0
        THIS.this_nFvendas    = 1
        THIS.this_nPcuss      = 0
        THIS.this_cMoecs      = ""
        THIS.this_cMoepvs     = ""
        THIS.this_dUltcomps   = {}
        THIS.this_nVultcomps  = 0
        THIS.this_cMultcomps  = ""
        THIS.this_nQultcomp   = 0
        THIS.this_nDiasinas   = 0
        THIS.this_nConsigs    = 0
        THIS.this_nFabrproprs = 0
        THIS.this_nEncoms     = 0
        THIS.this_nChkfunds   = 0
        THIS.this_cObspeds    = ""
        THIS.this_cObspes     = ""
        THIS.this_cObsetqs    = ""
        THIS.this_cDpro3s     = ""
        THIS.this_cDsccompras = ""
        THIS.this_cObscompras = ""
        THIS.this_nVarias     = 0
        THIS.this_nWebpros    = 0
        THIS.this_nTamhs      = 0
        THIS.this_nTamls      = 0
        THIS.this_nTamps      = 0
        THIS.this_nVolumes    = 0
        THIS.this_nTents      = 0
    ENDPROC

    *--------------------------------------------------------------------------
    * EditarRegistro - Prepara para edicao (dados ja carregados via CarregarPorCodigo)
    *--------------------------------------------------------------------------
    PROCEDURE EditarRegistro()
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega cursor_4c_Dados com registros conforme filtro
    * par_cFiltro: "" = todos | "WHERE ..." = com filtro
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nRet, loc_aErros(1)
        loc_lResultado = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                loc_lResultado = .T.
            ELSE
                loc_cSQL = "SELECT " + ;
                    "ISNULL(CPros,'')       AS cpros, " + ;
                    "ISNULL(DPros,'')       AS dpros, " + ;
                    "ISNULL(DPro2s,'')      AS dpro2s, " + ;
                    "ISNULL(CGrus,'')       AS cgrus, " + ;
                    "ISNULL(SGrus,'')       AS sgrus, " + ;
                    "ISNULL(Linhas,'')      AS linhas, " + ;
                    "ISNULL(Colecoes,'')    AS colecoes, " + ;
                    "ISNULL(Mercs,'')       AS mercs, " + ;
                    "ISNULL(IdeCPros,'')    AS idecpros, " + ;
                    "ISNULL(CClass,'')      AS cclass, " + ;
                    "ISNULL(IFors,'')       AS ifors, " + ;
                    "ISNULL(Reffs,'')       AS reffs, " + ;
                    "ISNULL(CodFinP,'')     AS codfinp, " + ;
                    "ISNULL(CodAcbs,'')     AS codacbs, " + ;
                    "ISNULL(CodCors,'')     AS codcors, " + ;
                    "ISNULL(CodTams,'')     AS codtams, " + ;
                    "ISNULL(CProEqs,'')     AS cproeqs, " + ;
                    "ISNULL(Situas,1)       AS situas, " + ;
                    "ISNULL(Datas,GETDATE()) AS datas, " + ;
                    "ISNULL(DtIncs,GETDATE()) AS dtincs, " + ;
                    "ISNULL(UsuIncs,'')     AS usuincs, " + ;
                    "ISNULL(CBars,0)        AS cbars, " + ;
                    "ISNULL(EAN13,0)        AS ean13, " + ;
                    "ISNULL(LtMinsV,0)      AS ltminsv, " + ;
                    "ISNULL(QMins,0)        AS qmins, " + ;
                    "ISNULL(QtPed,0)        AS qtped, " + ;
                    "ISNULL(Locals,'')      AS locals, " + ;
                    "ISNULL(CUnis,'')       AS cunis, " + ;
                    "ISNULL(CUniPs,'')      AS cunips, " + ;
                    "ISNULL(PesoBS,0)       AS pesobs, " + ;
                    "ISNULL(PesoMs,0)       AS pesoms, " + ;
                    "ISNULL(PVens,0)        AS pvens, " + ;
                    "ISNULL(FVendas,1)      AS fvendas, " + ;
                    "ISNULL(PCuss,0)        AS pcuss, " + ;
                    "ISNULL(MoECs,'')       AS moecs, " + ;
                    "ISNULL(MoePVs,'')      AS moepvs, " + ;
                    "ISNULL(UltComps,NULL)  AS ultcomps, " + ;
                    "ISNULL(VultComps,0)    AS vultcomps, " + ;
                    "ISNULL(MultComps,'')   AS multcomps, " + ;
                    "ISNULL(qtdultcomp,0)   AS qultcomp, " + ;
                    "ISNULL(DiasINas,0)     AS diasinas, " + ;
                    "ISNULL(ConSigs,0)      AS consigs, " + ;
                    "ISNULL(FabrProprs,0)   AS fabrproprs, " + ;
                    "ISNULL(EnComs,0)       AS encoms, " + ;
                    "ISNULL(ChkFunds,0)     AS chkfunds, " + ;
                    "ISNULL(ObsPeds,'')     AS obspeds, " + ;
                    "ISNULL(ObsPes,'')      AS obspes, " + ;
                    "ISNULL(ObsEtqs,'')     AS obsetqs, " + ;
                    "ISNULL(DPro3s,'')      AS dpro3s, " + ;
                    "ISNULL(DscCompras,'')  AS dsccompras, " + ;
                    "ISNULL(ObsCompras,'')  AS obscompras, " + ;
                    "ISNULL(Varias,0)       AS varias, " + ;
                    "ISNULL(prodwebs,0)     AS webpros, " + ;
                    "ISNULL(TamHs,0)        AS tamhs, " + ;
                    "ISNULL(TamLs,0)        AS tamls, " + ;
                    "ISNULL(TamPs,0)        AS tamps, " + ;
                    "ISNULL(Volumes,0)      AS volumes, " + ;
                    "ISNULL(TEnts,0)        AS tents " + ;
                    "FROM SigCdPro " + par_cFiltro + " ORDER BY CPros"

                IF USED("cursor_4c_Temp_Dados")
                    USE IN cursor_4c_Temp_Dados
                ENDIF
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Temp_Dados")

                IF loc_nRet > 0
                    IF USED("cursor_4c_Dados")
                        USE IN cursor_4c_Dados
                    ENDIF
                    SELECT cursor_4c_Temp_Dados
                    IF RECCOUNT() > 0
                        SELECT * FROM cursor_4c_Temp_Dados INTO CURSOR cursor_4c_Dados READWRITE
                        SELECT cursor_4c_Dados
                    ELSE
                        SET NULL ON
                        CREATE CURSOR cursor_4c_Dados ;
                            (cpros C(14), dpros C(65), dpro2s C(45), cgrus C(3), sgrus C(6), ;
                             linhas C(10), colecoes C(10), mercs C(3), idecpros C(3), cclass C(3), ;
                             ifors C(10), reffs C(40), codfinp C(3), codacbs C(3), codcors C(4), ;
                             codtams C(4), cproeqs C(14), situas N(1,0), datas D, dtincs D, ;
                             usuincs C(10), cbars N(14,0), ean13 N(13,0), ltminsv N(9,3), ;
                             qmins N(9,3), qtped N(9,3), locals C(10), cunis C(3), cunips C(3), ;
                             pesobs N(7,3), pesoms N(8,3), pvens N(11,5), fvendas N(7,3), ;
                             pcuss N(11,5), moecs C(3), moepvs C(3), ultcomps D, ;
                             vultcomps N(11,2), multcomps C(3), qultcomp N(9,3), ;
                             diasinas N(5,0), consigs N(1,0), fabrproprs N(1,0), ;
                             encoms N(1,0), chkfunds N(1,0), obspeds C(30), obspes C(30), ;
                             obsetqs C(10), dpro3s C(254), dsccompras C(254), obscompras C(254), ;
                             varias N(1,0), webpros N(1,0), tamhs N(5,2), tamls N(5,2), ;
                             tamps N(5,2), volumes N(3,0), tents N(3,0))
                        SET NULL OFF
                    ENDIF
                    IF USED("cursor_4c_Temp_Dados")
                        USE IN cursor_4c_Temp_Dados
                    ENDIF
                    loc_lResultado = .T.
                ELSE
                    AERROR(loc_aErros)
                    THIS.this_cMensagemErro = "Erro SQL ao buscar produtos: " + TRANSFORM(loc_aErros(1,2))
                    IF USED("cursor_4c_Temp_Dados")
                        USE IN cursor_4c_Temp_Dados
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao buscar produtos")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega dados de um produto pelo codigo
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nRet, loc_aErros(1)
        loc_lResultado = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                loc_lResultado = .T.
            ELSE
                loc_cSQL = "SELECT " + ;
                    "ISNULL(CPros,'')       AS cpros, " + ;
                    "ISNULL(DPros,'')       AS dpros, " + ;
                    "ISNULL(DPro2s,'')      AS dpro2s, " + ;
                    "ISNULL(CGrus,'')       AS cgrus, " + ;
                    "ISNULL(SGrus,'')       AS sgrus, " + ;
                    "ISNULL(Linhas,'')      AS linhas, " + ;
                    "ISNULL(Colecoes,'')    AS colecoes, " + ;
                    "ISNULL(Mercs,'')       AS mercs, " + ;
                    "ISNULL(IdeCPros,'')    AS idecpros, " + ;
                    "ISNULL(CClass,'')      AS cclass, " + ;
                    "ISNULL(IFors,'')       AS ifors, " + ;
                    "ISNULL(Reffs,'')       AS reffs, " + ;
                    "ISNULL(CodFinP,'')     AS codfinp, " + ;
                    "ISNULL(CodAcbs,'')     AS codacbs, " + ;
                    "ISNULL(CodCors,'')     AS codcors, " + ;
                    "ISNULL(CodTams,'')     AS codtams, " + ;
                    "ISNULL(CProEqs,'')     AS cproeqs, " + ;
                    "ISNULL(Situas,1)       AS situas, " + ;
                    "CONVERT(date,ISNULL(Datas,GETDATE())) AS datas, " + ;
                    "CONVERT(date,ISNULL(DtIncs,GETDATE())) AS dtincs, " + ;
                    "ISNULL(UsuIncs,'')     AS usuincs, " + ;
                    "ISNULL(CBars,0)        AS cbars, " + ;
                    "ISNULL(EAN13,0)        AS ean13, " + ;
                    "ISNULL(LtMinsV,0)      AS ltminsv, " + ;
                    "ISNULL(QMins,0)        AS qmins, " + ;
                    "ISNULL(QtPed,0)        AS qtped, " + ;
                    "ISNULL(Locals,'')      AS locals, " + ;
                    "ISNULL(CUnis,'')       AS cunis, " + ;
                    "ISNULL(CUniPs,'')      AS cunips, " + ;
                    "ISNULL(PesoBS,0)       AS pesobs, " + ;
                    "ISNULL(PesoMs,0)       AS pesoms, " + ;
                    "ISNULL(PVens,0)        AS pvens, " + ;
                    "ISNULL(FVendas,1)      AS fvendas, " + ;
                    "ISNULL(PCuss,0)        AS pcuss, " + ;
                    "ISNULL(MoECs,'')       AS moecs, " + ;
                    "ISNULL(MoePVs,'')      AS moepvs, " + ;
                    "CONVERT(date,ISNULL(UltComps,NULL)) AS ultcomps, " + ;
                    "ISNULL(VultComps,0)    AS vultcomps, " + ;
                    "ISNULL(MultComps,'')   AS multcomps, " + ;
                    "ISNULL(qtdultcomp,0)   AS qultcomp, " + ;
                    "ISNULL(DiasINas,0)     AS diasinas, " + ;
                    "ISNULL(ConSigs,0)      AS consigs, " + ;
                    "ISNULL(FabrProprs,0)   AS fabrproprs, " + ;
                    "ISNULL(EnComs,0)       AS encoms, " + ;
                    "ISNULL(ChkFunds,0)     AS chkfunds, " + ;
                    "ISNULL(ObsPeds,'')     AS obspeds, " + ;
                    "ISNULL(ObsPes,'')      AS obspes, " + ;
                    "ISNULL(ObsEtqs,'')     AS obsetqs, " + ;
                    "ISNULL(CONVERT(varchar(2000),DPro3s),'')     AS dpro3s, " + ;
                    "ISNULL(CONVERT(varchar(2000),DscCompras),'') AS dsccompras, " + ;
                    "ISNULL(CONVERT(varchar(2000),ObsCompras),'') AS obscompras, " + ;
                    "ISNULL(Varias,0)       AS varias, " + ;
                    "ISNULL(prodwebs,0)     AS webpros, " + ;
                    "ISNULL(TamHs,0)        AS tamhs, " + ;
                    "ISNULL(TamLs,0)        AS tamls, " + ;
                    "ISNULL(TamPs,0)        AS tamps, " + ;
                    "ISNULL(Volumes,0)      AS volumes, " + ;
                    "ISNULL(TEnts,0)        AS tents " + ;
                    "FROM SigCdPro " + ;
                    "WHERE CPros = " + EscaparSQL(ALLTRIM(par_cCodigo))

                IF USED("cursor_4c_CarregaPro")
                    USE IN cursor_4c_CarregaPro
                ENDIF
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CarregaPro")

                IF loc_nRet > 0 AND RECCOUNT("cursor_4c_CarregaPro") > 0
                    THIS.CarregarDoCursor("cursor_4c_CarregaPro")
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Produto n" + CHR(227) + "o encontrado: " + ALLTRIM(par_cCodigo)
                ENDIF

                IF USED("cursor_4c_CarregaPro")
                    USE IN cursor_4c_CarregaPro
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao carregar produto")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Popula propriedades a partir de cursor ativo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        SELECT (par_cAliasCursor)
        THIS.this_cCpros      = ALLTRIM(cpros)
        THIS.this_cDpros      = ALLTRIM(dpros)
        THIS.this_cDpro2s     = ALLTRIM(dpro2s)
        THIS.this_cCgrus      = ALLTRIM(cgrus)
        THIS.this_cSgrus      = ALLTRIM(sgrus)
        THIS.this_cLinhas     = ALLTRIM(linhas)
        THIS.this_cColecoes   = ALLTRIM(colecoes)
        THIS.this_cMercs      = ALLTRIM(mercs)
        THIS.this_cIdecpros   = ALLTRIM(idecpros)
        THIS.this_cCclass     = ALLTRIM(cclass)
        THIS.this_cIfors      = ALLTRIM(ifors)
        THIS.this_cReffs      = ALLTRIM(reffs)
        THIS.this_cCodfinp    = ALLTRIM(codfinp)
        THIS.this_cCodacbs    = ALLTRIM(codacbs)
        THIS.this_cCodcors    = ALLTRIM(codcors)
        THIS.this_cCodtams    = ALLTRIM(codtams)
        THIS.this_cCproeqs    = ALLTRIM(cproeqs)
        THIS.this_nSituas     = NVL(situas, 1)
        THIS.this_dDatas      = IIF(EMPTY(datas), DATE(), datas)
        THIS.this_dDtincs     = IIF(EMPTY(dtincs), DATE(), dtincs)
        THIS.this_cUsuincs    = ALLTRIM(usuincs)
        THIS.this_nCbars      = NVL(cbars, 0)
        THIS.this_nEan13      = NVL(ean13, 0)
        THIS.this_nLtminsv    = NVL(ltminsv, 0)
        THIS.this_nQmins      = NVL(qmins, 0)
        THIS.this_nQtped      = NVL(qtped, 0)
        THIS.this_cLocals     = ALLTRIM(locals)
        THIS.this_cCunis      = ALLTRIM(cunis)
        THIS.this_cCunips     = ALLTRIM(cunips)
        THIS.this_nPesobs     = NVL(pesobs, 0)
        THIS.this_nPesoms     = NVL(pesoms, 0)
        THIS.this_nPvens      = NVL(pvens, 0)
        THIS.this_nFvendas    = NVL(fvendas, 1)
        THIS.this_nPcuss      = NVL(pcuss, 0)
        THIS.this_cMoecs      = ALLTRIM(moecs)
        THIS.this_cMoepvs     = ALLTRIM(moepvs)
        THIS.this_dUltcomps   = IIF(EMPTY(ultcomps), {}, ultcomps)
        THIS.this_nVultcomps  = NVL(vultcomps, 0)
        THIS.this_cMultcomps  = ALLTRIM(multcomps)
        THIS.this_nQultcomp   = NVL(qultcomp, 0)
        THIS.this_nDiasinas   = NVL(diasinas, 0)
        THIS.this_nConsigs    = NVL(consigs, 0)
        THIS.this_nFabrproprs = NVL(fabrproprs, 0)
        THIS.this_nEncoms     = NVL(encoms, 0)
        THIS.this_nChkfunds   = NVL(chkfunds, 0)
        THIS.this_cObspeds    = ALLTRIM(obspeds)
        THIS.this_cObspes     = ALLTRIM(obspes)
        THIS.this_cObsetqs    = ALLTRIM(obsetqs)
        THIS.this_cDpro3s     = ALLTRIM(dpro3s)
        THIS.this_cDsccompras = ALLTRIM(dsccompras)
        THIS.this_cObscompras = ALLTRIM(obscompras)
        THIS.this_nVarias     = NVL(varias, 0)
        THIS.this_nWebpros    = NVL(webpros, 0)
        THIS.this_nTamhs      = NVL(tamhs, 0)
        THIS.this_nTamls      = NVL(tamls, 0)
        THIS.this_nTamps      = NVL(tamps, 0)
        THIS.this_nVolumes    = NVL(volumes, 0)
        THIS.this_nTents      = NVL(tents, 0)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo produto em SigCdPro
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nRet
        loc_lResultado = .F.

        TRY
            *-- Verificar codigo duplicado
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                LOCAL loc_nExiste
                loc_nExiste = 0
                SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS nExiste FROM SigCdPro WHERE CPros = " + ;
                    EscaparSQL(THIS.this_cCpros), "cursor_4c_ChkPro")
                IF USED("cursor_4c_ChkPro")
                    SELECT cursor_4c_ChkPro
                    loc_nExiste = nExiste
                    USE IN cursor_4c_ChkPro
                ENDIF
                IF loc_nExiste > 0
                    THIS.this_cMensagemErro = "Produto j" + CHR(225) + " existe: " + ALLTRIM(THIS.this_cCpros)
                    loc_lResultado = .F.
                ENDIF
            ENDIF

            loc_cSQL = THIS.MontarSQL_INSERT()
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                LOCAL loc_aErros(1)
                AERROR(loc_aErros)
                THIS.this_cMensagemErro = "Erro ao inserir produto: " + TRANSFORM(loc_aErros(1,2))
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao inserir produto")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza produto existente
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nRet
        loc_lResultado = .F.

        TRY
            loc_cSQL = THIS.MontarSQL_UPDATE()
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                LOCAL loc_aErros(1)
                AERROR(loc_aErros)
                THIS.this_cMensagemErro = "Erro ao atualizar produto: " + TRANSFORM(loc_aErros(1,2))
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao atualizar produto")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove produto (chamado por Excluir() da BusinessBase)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_nRet
        loc_lResultado = .F.

        TRY
            loc_nRet = SQLEXEC(gnConnHandle, "DELETE FROM SigCdPro WHERE CPros = " + ;
                EscaparSQL(THIS.this_cCpros))
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao excluir produto."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao excluir produto")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarSQL_INSERT - Gera SQL de insercao (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarSQL_INSERT()
        LOCAL loc_cSQL
        loc_cSQL = "INSERT INTO SigCdPro " + ;
            "(CPros, DPros, DPro2s, CGrus, SGrus, Linhas, Colecoes, Mercs, IdeCPros, CClass, " + ;
            " IFors, Reffs, CodFinP, CodAcbs, CodCors, CodTams, CProEqs, Situas, Datas, DtIncs, " + ;
            " UsuIncs, CBars, EAN13, LtMinsV, QMins, QtPed, Locals, CUnis, CUniPs, PesoBS, PesoMs, " + ;
            " PVens, FVendas, PCuss, MoECs, MoePVs, UltComps, VultComps, MultComps, qtdultcomp, " + ;
            " DiasINas, ConSigs, FabrProprs, EnComs, ChkFunds, ObsPeds, ObsPes, " + ;
            " ObsEtqs, DPro3s, DscCompras, ObsCompras, Varias, prodwebs, TamHs, TamLs, TamPs, " + ;
            " Volumes, TEnts) " + ;
            "VALUES (" + ;
            EscaparSQL(THIS.this_cCpros)                     + ", " + ;
            EscaparSQL(THIS.this_cDpros)                     + ", " + ;
            EscaparSQL(THIS.this_cDpro2s)                    + ", " + ;
            EscaparSQL(PADR(THIS.this_cCgrus,3))             + ", " + ;
            EscaparSQL(PADR(THIS.this_cSgrus,6))             + ", " + ;
            EscaparSQL(PADR(THIS.this_cLinhas,10))           + ", " + ;
            EscaparSQL(PADR(THIS.this_cColecoes,10))         + ", " + ;
            EscaparSQL(PADR(THIS.this_cMercs,3))             + ", " + ;
            EscaparSQL(PADR(THIS.this_cIdecpros,3))          + ", " + ;
            EscaparSQL(PADR(THIS.this_cCclass,3))            + ", " + ;
            EscaparSQL(PADR(THIS.this_cIfors,10))            + ", " + ;
            EscaparSQL(THIS.this_cReffs)                     + ", " + ;
            EscaparSQL(PADR(THIS.this_cCodfinp,3))           + ", " + ;
            EscaparSQL(PADR(THIS.this_cCodacbs,3))           + ", " + ;
            EscaparSQL(PADR(THIS.this_cCodcors,4))           + ", " + ;
            EscaparSQL(PADR(THIS.this_cCodtams,4))           + ", " + ;
            EscaparSQL(THIS.this_cCproeqs)                   + ", " + ;
            FormatarNumeroSQL(THIS.this_nSituas)              + ", " + ;
            FormatarDataSQL(THIS.this_dDatas)                 + ", " + ;
            FormatarDataSQL(DATE())                           + ", " + ;
            EscaparSQL(gc_4c_UsuarioLogado)                  + ", " + ;
            FormatarNumeroSQL(THIS.this_nCbars)               + ", " + ;
            FormatarNumeroSQL(THIS.this_nEan13)               + ", " + ;
            FormatarNumeroSQL(THIS.this_nLtminsv)             + ", " + ;
            FormatarNumeroSQL(THIS.this_nQmins)               + ", " + ;
            FormatarNumeroSQL(THIS.this_nQtped)               + ", " + ;
            EscaparSQL(PADR(THIS.this_cLocals,10))           + ", " + ;
            EscaparSQL(PADR(THIS.this_cCunis,3))             + ", " + ;
            EscaparSQL(PADR(THIS.this_cCunips,3))            + ", " + ;
            FormatarNumeroSQL(THIS.this_nPesobs)              + ", " + ;
            FormatarNumeroSQL(THIS.this_nPesoms)              + ", " + ;
            FormatarNumeroSQL(THIS.this_nPvens)               + ", " + ;
            FormatarNumeroSQL(THIS.this_nFvendas)             + ", " + ;
            FormatarNumeroSQL(THIS.this_nPcuss)               + ", " + ;
            EscaparSQL(PADR(THIS.this_cMoecs,3))             + ", " + ;
            EscaparSQL(PADR(THIS.this_cMoepvs,3))            + ", " + ;
            FormatarDataSQL(THIS.this_dUltcomps)              + ", " + ;
            FormatarNumeroSQL(THIS.this_nVultcomps)           + ", " + ;
            EscaparSQL(PADR(THIS.this_cMultcomps,3))          + ", " + ;
            FormatarNumeroSQL(THIS.this_nQultcomp)            + ", " + ;
            FormatarNumeroSQL(THIS.this_nDiasinas)            + ", " + ;
            FormatarNumeroSQL(THIS.this_nConsigs)             + ", " + ;
            FormatarNumeroSQL(THIS.this_nFabrproprs)          + ", " + ;
            FormatarNumeroSQL(THIS.this_nEncoms)              + ", " + ;
            FormatarNumeroSQL(THIS.this_nChkfunds)            + ", " + ;
            EscaparSQL(THIS.this_cObspeds)                   + ", " + ;
            EscaparSQL(THIS.this_cObspes)                    + ", " + ;
            EscaparSQL(THIS.this_cObsetqs)                   + ", " + ;
            EscaparSQL(THIS.this_cDpro3s)                    + ", " + ;
            EscaparSQL(THIS.this_cDsccompras)                + ", " + ;
            EscaparSQL(THIS.this_cObscompras)                + ", " + ;
            FormatarNumeroSQL(THIS.this_nVarias)              + ", " + ;
            FormatarNumeroSQL(THIS.this_nWebpros)             + ", " + ;
            FormatarNumeroSQL(THIS.this_nTamhs)               + ", " + ;
            FormatarNumeroSQL(THIS.this_nTamls)               + ", " + ;
            FormatarNumeroSQL(THIS.this_nTamps)               + ", " + ;
            FormatarNumeroSQL(THIS.this_nVolumes)             + ", " + ;
            FormatarNumeroSQL(THIS.this_nTents)               + ")"

        RETURN loc_cSQL
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarSQL_UPDATE - Gera SQL de atualizacao (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarSQL_UPDATE()
        LOCAL loc_cSQL
        loc_cSQL = "UPDATE SigCdPro SET " + ;
            "DPros = "       + EscaparSQL(THIS.this_cDpros)              + ", " + ;
            "DPro2s = "      + EscaparSQL(THIS.this_cDpro2s)             + ", " + ;
            "CGrus = "       + EscaparSQL(PADR(THIS.this_cCgrus,3))      + ", " + ;
            "SGrus = "       + EscaparSQL(PADR(THIS.this_cSgrus,6))      + ", " + ;
            "Linhas = "      + EscaparSQL(PADR(THIS.this_cLinhas,10))    + ", " + ;
            "Colecoes = "    + EscaparSQL(PADR(THIS.this_cColecoes,10))  + ", " + ;
            "Mercs = "       + EscaparSQL(PADR(THIS.this_cMercs,3))      + ", " + ;
            "IdeCPros = "    + EscaparSQL(PADR(THIS.this_cIdecpros,3))   + ", " + ;
            "CClass = "      + EscaparSQL(PADR(THIS.this_cCclass,3))     + ", " + ;
            "IFors = "       + EscaparSQL(PADR(THIS.this_cIfors,10))     + ", " + ;
            "Reffs = "       + EscaparSQL(THIS.this_cReffs)              + ", " + ;
            "CodFinP = "     + EscaparSQL(PADR(THIS.this_cCodfinp,3))    + ", " + ;
            "CodAcbs = "     + EscaparSQL(PADR(THIS.this_cCodacbs,3))    + ", " + ;
            "CodCors = "     + EscaparSQL(PADR(THIS.this_cCodcors,4))    + ", " + ;
            "CodTams = "     + EscaparSQL(PADR(THIS.this_cCodtams,4))    + ", " + ;
            "CProEqs = "     + EscaparSQL(THIS.this_cCproeqs)            + ", " + ;
            "Situas = "      + FormatarNumeroSQL(THIS.this_nSituas)       + ", " + ;
            "Datas = "       + FormatarDataSQL(THIS.this_dDatas)          + ", " + ;
            "CBars = "       + FormatarNumeroSQL(THIS.this_nCbars)        + ", " + ;
            "EAN13 = "       + FormatarNumeroSQL(THIS.this_nEan13)        + ", " + ;
            "LtMinsV = "     + FormatarNumeroSQL(THIS.this_nLtminsv)      + ", " + ;
            "QMins = "       + FormatarNumeroSQL(THIS.this_nQmins)        + ", " + ;
            "QtPed = "       + FormatarNumeroSQL(THIS.this_nQtped)       + ", " + ;
            "Locals = "      + EscaparSQL(PADR(THIS.this_cLocals,10))    + ", " + ;
            "CUnis = "       + EscaparSQL(PADR(THIS.this_cCunis,3))      + ", " + ;
            "CUniPs = "      + EscaparSQL(PADR(THIS.this_cCunips,3))     + ", " + ;
            "PesoBS = "      + FormatarNumeroSQL(THIS.this_nPesobs)       + ", " + ;
            "PesoMs = "      + FormatarNumeroSQL(THIS.this_nPesoms)       + ", " + ;
            "PVens = "       + FormatarNumeroSQL(THIS.this_nPvens)        + ", " + ;
            "FVendas = "     + FormatarNumeroSQL(THIS.this_nFvendas)      + ", " + ;
            "PCuss = "       + FormatarNumeroSQL(THIS.this_nPcuss)        + ", " + ;
            "MoECs = "       + EscaparSQL(PADR(THIS.this_cMoecs,3))      + ", " + ;
            "MoePVs = "      + EscaparSQL(PADR(THIS.this_cMoepvs,3))     + ", " + ;
            "UltComps = "    + FormatarDataSQL(THIS.this_dUltcomps)       + ", " + ;
            "VultComps = "   + FormatarNumeroSQL(THIS.this_nVultcomps)    + ", " + ;
            "MultComps = "   + EscaparSQL(PADR(THIS.this_cMultcomps,3))   + ", " + ;
            "qtdultcomp = "  + FormatarNumeroSQL(THIS.this_nQultcomp)     + ", " + ;
            "DiasINas = "    + FormatarNumeroSQL(THIS.this_nDiasinas)     + ", " + ;
            "ConSigs = "     + FormatarNumeroSQL(THIS.this_nConsigs)      + ", " + ;
            "FabrProprs = "  + FormatarNumeroSQL(THIS.this_nFabrproprs)   + ", " + ;
            "EnComs = "      + FormatarNumeroSQL(THIS.this_nEncoms)       + ", " + ;
            "ChkFunds = "    + FormatarNumeroSQL(THIS.this_nChkfunds)    + ", " + ;
            "ObsPeds = "     + EscaparSQL(THIS.this_cObspeds)            + ", " + ;
            "ObsPes = "      + EscaparSQL(THIS.this_cObspes)             + ", " + ;
            "ObsEtqs = "     + EscaparSQL(THIS.this_cObsetqs)            + ", " + ;
            "DPro3s = "      + EscaparSQL(THIS.this_cDpro3s)             + ", " + ;
            "DscCompras = "  + EscaparSQL(THIS.this_cDsccompras)         + ", " + ;
            "ObsCompras = "  + EscaparSQL(THIS.this_cObscompras)         + ", " + ;
            "Varias = "      + FormatarNumeroSQL(THIS.this_nVarias)       + ", " + ;
            "prodwebs = "    + FormatarNumeroSQL(THIS.this_nWebpros)      + ", " + ;
            "TamHs = "       + FormatarNumeroSQL(THIS.this_nTamhs)        + ", " + ;
            "TamLs = "       + FormatarNumeroSQL(THIS.this_nTamls)        + ", " + ;
            "TamPs = "       + FormatarNumeroSQL(THIS.this_nTamps)        + ", " + ;
            "Volumes = "     + FormatarNumeroSQL(THIS.this_nVolumes)      + ", " + ;
            "TEnts = "       + FormatarNumeroSQL(THIS.this_nTents)        + " " + ;
            "WHERE CPros = " + EscaparSQL(THIS.this_cCpros)

        RETURN loc_cSQL
    ENDPROC

ENDDEFINE

