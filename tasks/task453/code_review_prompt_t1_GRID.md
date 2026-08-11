# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-HEADERS] Metodo CarregarGradeTratamento redefine RecordSource mas NAO redefine Header1.Caption. Headers ficam com nomes de campo (ex: 'Contas') ao inves de titulos legiveis (ex: 'Conta'). OBRIGATORIO redefinir TODOS os Header1.Caption APOS RecordSource.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formint.prg) - TRECHOS RELEVANTES PARA PASS GRID (4201 linhas total):

*-- Linhas 514 a 544:
514:         * Compensacao +29: Top=174
515:         * Width=905 (12+905=917=cnt_4c_Saida.Left - sem sobreposicao)
516:         * HeaderHeight=0: botoes acima servem como cabecalhos visuais
517:         * ColumnCount FORA do WITH (Problem 36)
518:         * ControlSource/DynamicBackColor: vinculados em CarregarLista() (Problem 32)
519:         * Colunas: codigos/datainis/datafims/contas/localis/localfs/grupos/cggruis/usuars/encerras
520:         * Larguras: 62+78+75+143+81+82+69+69+78+168 = 905
521:         *----------------------------------------------------------------------
522:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
523:         loc_oPagina.grd_4c_Dados.ColumnCount = 10
524:         WITH loc_oPagina.grd_4c_Dados
525:             .Top           = 174
526:             .Left          = 12
527:             .Width         = 905
528:             .Height        = 446
529:             .RecordSource  = ""
530:             .ReadOnly      = .T.
531:             .DeleteMark    = .F.
532:             .RecordMark    = .F.
533:             .GridLines     = 1
534:             .GridLineWidth = 1
535:             .GridLineColor = RGB(200, 200, 200)
536:             .HeaderHeight  = 0
537:             .RowHeight     = 20
538:             .FontName      = "Tahoma"
539:             .FontSize      = 9
540:             .ScrollBars    = 2
541:             .Visible       = .T.
542:             WITH .Column1
543:                 .Width     = 62
544:                 .Resizable = .F.

*-- Linhas 590 a 608:
590:                 .Alignment = 0
591:             ENDWITH
592:         ENDWITH
593:         BINDEVENT(loc_oPagina.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
594: 
595:         THIS.TornarControlesVisiveis(loc_oPagina)
596:     ENDPROC
597: 
598:     *===========================================================================
599:     * ConfigurarPaginaDados - Configura Page2 (Filtros para selecao do inventario)
600:     * Original: Grupo_Salva.Left=821, Top=10, Width=160, Height=85
601:     * Com compensacao +29: Top=39
602:     *===========================================================================
603:     PROTECTED PROCEDURE ConfigurarPaginaDados()
604:         LOCAL loc_oPagina
605:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
606: 
607:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
608:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 1607 a 1698:
1607:         BINDEVENT(loc_oCnt.txt_4c_DPro,       "KeyPress", THIS, "GetDProLostFocus")
1608: 
1609:         *==========================================================================
1610:         *-- grd_4c_Dados (GrdBalanco): Top=210+29=239, Left=17, W=972, H=364
1611:         *-- RecordSource definido fora do WITH (evita "Unknown member COLUMN1")
1612:         *==========================================================================
1613:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
1614:         loc_oGrid = loc_oPagina.grd_4c_Dados
1615:         loc_oGrid.RecordSource = ""
1616:         loc_oGrid.ColumnCount  = 10
1617: 
1618:         WITH loc_oGrid
1619:             .Top         = 239
1620:             .Left        = 17
1621:             .Width       = 972
1622:             .Height      = 364
1623:             .Visible     = .F.
1624:             .ReadOnly    = .F.
1625:             .FontName    = "Tahoma"
1626:             .FontSize    = 9
1627:             .GridLines   = 1
1628:             .DeleteMark  = .F.
1629:             .RecordMark  = .F.
1630:             .HeaderHeight = 21
1631:             .RowHeight    = 20
1632:         ENDWITH
1633: 
1634:         WITH loc_oGrid.Column1
1635:             .Width = 120
1636:             .ReadOnly = .T.
1637:             .Header1.Caption = "Produto"
1638:         ENDWITH
1639:         WITH loc_oGrid.Column2
1640:             .Width = 80 
1641:             .ReadOnly = .T.
1642:             .Header1.Caption = "Data"
1643:         ENDWITH
1644:         WITH loc_oGrid.Column3
1645:             .Width = 100
1646:             .ReadOnly = .T.
1647:             .Header1.Caption = "Barra"
1648:         ENDWITH
1649:         WITH loc_oGrid.Column4
1650:             .Width = 80 
1651:             .ReadOnly = .T.
1652:             .Header1.Caption = "Barra Novo"
1653:         ENDWITH
1654:         WITH loc_oGrid.Column5
1655:             .Width = 65 
1656:             .ReadOnly = .T.
1657:             .Header1.Caption = "Apurado"
1658:         ENDWITH
1659:         WITH loc_oGrid.Column6
1660:             .Width = 65 
1661:             .ReadOnly = .T.
1662:             .Header1.Caption = "Estoque"
1663:         ENDWITH
1664:         WITH loc_oGrid.Column7
1665:             .Width = 65 
1666:             .ReadOnly = .T.
1667:             .Header1.Caption = "Diferen" + CHR(231) + "a"
1668:         ENDWITH
1669:         WITH loc_oGrid.Column8
1670:             .Width = 80 
1671:             .ReadOnly = .F.
1672:             .Sparse = .F.
1673:             .Header1.Caption = "Ocorrencia"
1674:         ENDWITH
1675:         WITH loc_oGrid.Column9
1676:             .Width = 20 
1677:             .ReadOnly = .T.
1678:             .Header1.Caption = "T"
1679:         ENDWITH
1680:         WITH loc_oGrid.Column10
1681:             .Width = 70 
1682:             .ReadOnly = .T.
1683:             .Header1.Caption = "Dif.Peso"
1684:         ENDWITH
1685: 
1686:         BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GrdBalancoAfterRowColChange")
1687:         BINDEVENT(loc_oGrid.Column8.Text1, "When",      THIS, "GrdColOcorWhen")
1688:         BINDEVENT(loc_oGrid.Column8.Text1, "Valid",     THIS, "GrdColOcorValid")
1689:         BINDEVENT(loc_oGrid.Column8.Text1, "KeyPress", THIS, "GrdColOcorLostFocus")
1690: 
1691:         *==========================================================================
1692:         *-- cnt_4c__Custo2 (painel Novo Barra): Top=210+29=239
1693:         *==========================================================================
1694:         loc_oPagina.AddObject("cnt_4c__Custo2", "Container")
1695:         WITH loc_oPagina.cnt_4c__Custo2
1696:             .Top = 239
1697:             .Left = 17
1698:             .Width = 972

*-- Linhas 2358 a 2400:
2358:                         "Formint.CarregarLista")
2359:                 ELSE
2360:                     LOCAL loc_oGrid
2361:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
2362:                     *-- Vincular cursor ao grid (Problem 32: ControlSource apos RecordSource)
2363:                     loc_oGrid.ColumnCount = 10
2364:                     loc_oGrid.RecordSource           = "cursor_4c_Dados"
2365:                     loc_oGrid.Column1.ControlSource  = "cursor_4c_Dados.codigos"
2366:                     loc_oGrid.Column2.ControlSource  = "cursor_4c_Dados.datainis"
2367:                     loc_oGrid.Column3.ControlSource  = "cursor_4c_Dados.datafims"
2368:                     loc_oGrid.Column4.ControlSource  = "cursor_4c_Dados.contas"
2369:                     loc_oGrid.Column5.ControlSource  = "cursor_4c_Dados.localis"
2370:                     loc_oGrid.Column6.ControlSource  = "cursor_4c_Dados.localfs"
2371:                     loc_oGrid.Column7.ControlSource  = "cursor_4c_Dados.grupos"
2372:                     loc_oGrid.Column8.ControlSource  = "cursor_4c_Dados.cggruis"
2373:                     loc_oGrid.Column9.ControlSource  = "cursor_4c_Dados.usuars"
2374:                     loc_oGrid.Column10.ControlSource = "cursor_4c_Dados.encerras"
2375:                     *-- Problem 6/32: Headers DEVEM ser redefinidos apos RecordSource
2376:                     loc_oGrid.Column1.Header1.Caption  = "C" + CHR(243) + "digo"
2377:                     loc_oGrid.Column2.Header1.Caption  = "Inicial"
2378:                     loc_oGrid.Column3.Header1.Caption  = "Final"
2379:                     loc_oGrid.Column4.Header1.Caption  = "Conta"
2380:                     loc_oGrid.Column5.Header1.Caption  = "Local Ini."
2381:                     loc_oGrid.Column6.Header1.Caption  = "Local Fin."
2382:                     loc_oGrid.Column7.Header1.Caption  = "Grupo"
2383:                     loc_oGrid.Column8.Header1.Caption  = "Gde.Grupo"
2384:                     loc_oGrid.Column9.Header1.Caption  = "Usu" + CHR(225) + "rio"
2385:                     loc_oGrid.Column10.Header1.Caption = "Encerrado"
2386:                     *-- Larguras aproximadas do original
2387:                     loc_oGrid.Column1.Width  = 60
2388:                     loc_oGrid.Column2.Width  = 75
2389:                     loc_oGrid.Column3.Width  = 75
2390:                     loc_oGrid.Column4.Width  = 70
2391:                     loc_oGrid.Column5.Width  = 80
2392:                     loc_oGrid.Column6.Width  = 80
2393:                     loc_oGrid.Column7.Width  = 70
2394:                     loc_oGrid.Column8.Width  = 66
2395:                     loc_oGrid.Column9.Width  = 78
2396:                     loc_oGrid.Column10.Width = 70
2397:                     THIS.FormatarGridLista(loc_oGrid)
2398:                     *-- Capturar selecao inicial (primeiro registro)
2399:                     IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
2400:                         GO TOP IN cursor_4c_Dados

*-- Linhas 2701 a 2786:
2701:     ENDPROC
2702: 
2703:     *===========================================================================
2704:     * CarregarGradeTratamento - Carrega grade de itens do inventario selecionado
2705:     *===========================================================================
2706:     PROTECTED PROCEDURE CarregarGradeTratamento()
2707:         LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_oGrid, loc_oPg3
2708:         LOCAL loc_nTotCOc, loc_nTotSOc
2709:         loc_lResultado = .F.
2710: 
2711:         TRY
2712:             IF THIS.this_nCodigoSel <= 0
2713:                 MsgAviso("Nenhum invent" + CHR(225) + "rio selecionado", ;
2714:                     "Formint.CarregarGradeTratamento")
2715:             ELSE
2716:                 IF USED("cursor_4c_Tratamento")
2717:                     USE IN cursor_4c_Tratamento
2718:                 ENDIF
2719: 
2720:                 loc_cSQL = "SELECT a.Produto, a.Datatrans AS Datas, a.Barras, a.Barra2s AS BarraNovos," + ;
2721:                     " a.Apurado, a.Estoque, a.Falta AS Faltas, a.Ocorrencia," + ;
2722:                     " a.Tipos, a.PesReals, a.CCustos, a.Obs, a.Obs2s," + ;
2723:                     " a.Usuars, a.CIdChaves, a.Emps, a.Codigos" + ;
2724:                     " FROM SigIvTrT a" + ;
2725:                     " WHERE a.Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa)) + ;
2726:                     " AND a.Codigos = " + TRANSFORM(THIS.this_nCodigoSel) + ;
2727:                     " ORDER BY a.Barras"
2728: 
2729:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Tratamento")
2730: 
2731:                 IF loc_nResult < 0
2732:                     MostrarErro("Erro ao carregar itens:" + CHR(13) + ;
2733:                         CapturarErroSQL(), "Formint.CarregarGradeTratamento")
2734:                 ELSE
2735:                     loc_oPg3  = THIS.pgf_4c_Paginas.Page3
2736:                     loc_oGrid = loc_oPg3.grd_4c_Dados
2737: 
2738:                     *-- Vincular cursor ao grid
2739:                     loc_oGrid.ColumnCount = 10
2740:                     loc_oGrid.RecordSource = "cursor_4c_Tratamento"
2741:                     loc_oGrid.Column1.ControlSource  = "cursor_4c_Tratamento.Produto"
2742:                     loc_oGrid.Column2.ControlSource  = "cursor_4c_Tratamento.Datas"
2743:                     loc_oGrid.Column3.ControlSource  = "cursor_4c_Tratamento.Barras"
2744:                     loc_oGrid.Column4.ControlSource  = "cursor_4c_Tratamento.BarraNovos"
2745:                     loc_oGrid.Column5.ControlSource  = "cursor_4c_Tratamento.Apurado"
2746:                     loc_oGrid.Column6.ControlSource  = "cursor_4c_Tratamento.Estoque"
2747:                     loc_oGrid.Column7.ControlSource  = "cursor_4c_Tratamento.Faltas"
2748:                     loc_oGrid.Column8.ControlSource  = "cursor_4c_Tratamento.Ocorrencia"
2749:                     loc_oGrid.Column9.ControlSource  = "cursor_4c_Tratamento.Tipos"
2750:                     loc_oGrid.Column10.ControlSource = "cursor_4c_Tratamento.PesReals"
2751: 
2752:                     *-- Ajuste dinamico da coluna Dif.Peso (trtporpeso)
2753:                     LOCAL loc_nTrtPeso
2754:                     loc_nTrtPeso = 0
2755:                     IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
2756:                         loc_nTrtPeso = TratarNulo(cursor_4c_Dados.trtporpeso, "N")
2757:                     ENDIF
2758:                     IF loc_nTrtPeso = 1
2759:                         loc_oGrid.Column10.Width = 70
2760:                     ELSE
2761:                         loc_oGrid.Column10.Width = 0
2762:                     ENDIF
2763: 
2764:                     *-- Calcular totais iniciais de ocorrencias
2765:                     loc_nTotCOc = 0
2766:                     loc_nTotSOc = 0
2767:                     IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
2768:                         SELECT cursor_4c_Tratamento
2769:                         GO TOP
2770:                         SCAN
2771:                             IF !EMPTY(ALLTRIM(cursor_4c_Tratamento.Ocorrencia))
2772:                                 loc_nTotCOc = loc_nTotCOc + 1
2773:                             ELSE
2774:                                 loc_nTotSOc = loc_nTotSOc + 1
2775:                             ENDIF
2776:                         ENDSCAN
2777:                     ENDIF
2778: 
2779:                     WITH loc_oPg3.cnt_4c__CCusto1.cnt_4c__Total
2780:                         .txt_4c_TotCOc.Value = loc_nTotCOc
2781:                         .txt_4c_TotSOc.Value = loc_nTotSOc
2782:                         .Visible     = .T.
2783:                     ENDWITH
2784: 
2785:                     *-- Exibir grid e painel de controles
2786:                     loc_oPg3.cnt_4c__CCusto1.Visible = .T.

*-- Linhas 3113 a 3245:
3113:             IF USED("cursor_4c_Dados")
3114:                 SELECT cursor_4c_Dados
3115:                 INDEX ON codigos TAG _proc
3116:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
3117:                 loc_oGrid.SetFocus()
3118:                 loc_oGrid.ActiveColumn = 1
3119:             ENDIF
3120:         CATCH TO loException
3121:             MsgErro("Erro ao ordenar por processo:" + CHR(13) + loException.Message, ;
3122:                 "Formint.CmdProcessoClick")
3123:         ENDTRY
3124:     ENDPROC
3125: 
3126:     *===========================================================================
3127:     * CmdPeriodoClick - Ordena grid por periodo (datainis)
3128:     *===========================================================================
3129:     PROCEDURE CmdPeriodoClick()
3130:         LOCAL loc_oGrid
3131:         TRY
3132:             IF USED("cursor_4c_Dados")
3133:                 SELECT cursor_4c_Dados
3134:                 INDEX ON DTOS(datainis) TAG _perio
3135:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
3136:                 loc_oGrid.SetFocus()
3137:                 loc_oGrid.ActiveColumn = 2
3138:             ENDIF
3139:         CATCH TO loException
3140:             MsgErro("Erro ao ordenar por per" + CHR(237) + "odo:" + CHR(13) + loException.Message, ;
3141:                 "Formint.CmdPeriodoClick")
3142:         ENDTRY
3143:     ENDPROC
3144: 
3145:     *===========================================================================
3146:     * CmdEstoqueClick - Ordena grid por estoque (contas)
3147:     *===========================================================================
3148:     PROCEDURE CmdEstoqueClick()
3149:         LOCAL loc_oGrid
3150:         TRY
3151:             IF USED("cursor_4c_Dados")
3152:                 SELECT cursor_4c_Dados
3153:                 INDEX ON ALLTRIM(contas) TAG _esto
3154:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
3155:                 loc_oGrid.SetFocus()
3156:                 loc_oGrid.ActiveColumn = 4
3157:             ENDIF
3158:         CATCH TO loException
3159:             MsgErro("Erro ao ordenar por estoque:" + CHR(13) + loException.Message, ;
3160:                 "Formint.CmdEstoqueClick")
3161:         ENDTRY
3162:     ENDPROC
3163: 
3164:     *===========================================================================
3165:     * CmdLocalClick - Ordena grid por local inicial (localis)
3166:     *===========================================================================
3167:     PROCEDURE CmdLocalClick()
3168:         LOCAL loc_oGrid
3169:         TRY
3170:             IF USED("cursor_4c_Dados")
3171:                 SELECT cursor_4c_Dados
3172:                 INDEX ON ALLTRIM(localis) TAG _loca
3173:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
3174:                 loc_oGrid.SetFocus()
3175:                 loc_oGrid.ActiveColumn = 5
3176:             ENDIF
3177:         CATCH TO loException
3178:             MsgErro("Erro ao ordenar por local:" + CHR(13) + loException.Message, ;
3179:                 "Formint.CmdLocalClick")
3180:         ENDTRY
3181:     ENDPROC
3182: 
3183:     *===========================================================================
3184:     * CmdGrupoClick - Ordena grid por grupo (grupos)
3185:     *===========================================================================
3186:     PROCEDURE CmdGrupoClick()
3187:         LOCAL loc_oGrid
3188:         TRY
3189:             IF USED("cursor_4c_Dados")
3190:                 SELECT cursor_4c_Dados
3191:                 INDEX ON ALLTRIM(grupos) TAG _gru
3192:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
3193:                 loc_oGrid.SetFocus()
3194:                 loc_oGrid.ActiveColumn = 7
3195:             ENDIF
3196:         CATCH TO loException
3197:             MsgErro("Erro ao ordenar por grupo:" + CHR(13) + loException.Message, ;
3198:                 "Formint.CmdGrupoClick")
3199:         ENDTRY
3200:     ENDPROC
3201: 
3202:     *===========================================================================
3203:     * CmdGGrupoClick - Ordena grid por grande grupo (cggruis)
3204:     *===========================================================================
3205:     PROCEDURE CmdGGrupoClick()
3206:         LOCAL loc_oGrid
3207:         TRY
3208:             IF USED("cursor_4c_Dados")
3209:                 SELECT cursor_4c_Dados
3210:                 INDEX ON ALLTRIM(cggruis) TAG _ggru
3211:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
3212:                 loc_oGrid.SetFocus()
3213:                 loc_oGrid.ActiveColumn = 8
3214:             ENDIF
3215:         CATCH TO loException
3216:             MsgErro("Erro ao ordenar por grande grupo:" + CHR(13) + loException.Message, ;
3217:                 "Formint.CmdGGrupoClick")
3218:         ENDTRY
3219:     ENDPROC
3220: 
3221:     *===========================================================================
3222:     * CmdUsuarioClick - Ordena grid por usuario (usuars)
3223:     *===========================================================================
3224:     PROCEDURE CmdUsuarioClick()
3225:         LOCAL loc_oGrid
3226:         TRY
3227:             IF USED("cursor_4c_Dados")
3228:                 SELECT cursor_4c_Dados
3229:                 INDEX ON ALLTRIM(usuars) TAG _usu
3230:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
3231:                 loc_oGrid.SetFocus()
3232:                 loc_oGrid.ActiveColumn = 9
3233:             ENDIF
3234:         CATCH TO loException
3235:             MsgErro("Erro ao ordenar por usu" + CHR(225) + "rio:" + CHR(13) + loException.Message, ;
3236:                 "Formint.CmdUsuarioClick")
3237:         ENDTRY
3238:     ENDPROC
3239: 
3240:     *===========================================================================
3241:     * Destroy - Libera recursos ao fechar
3242:     *===========================================================================
3243:     PROCEDURE Destroy()
3244:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
3245:             THIS.this_oBusinessObject = .NULL.

*-- Linhas 3285 a 3303:
3285:                 .Refresh()
3286:             ENDWITH
3287: 
3288:             WITH THIS.pgf_4c_Paginas.Page3.grd_4c_Dados
3289:                 .Column8.ReadOnly       = .F.
3290:                 .Column8.Text1.ReadOnly = .F.
3291:                 .Refresh()
3292:             ENDWITH
3293:         ENDIF
3294:     ENDPROC
3295: 
3296:     *===========================================================================
3297:     * GrdColOcorWhen - Salva valor atual antes da edicao (Column8)
3298:     *===========================================================================
3299:     PROCEDURE GrdColOcorWhen()
3300:         IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
3301:             THIS.this_cOldValue = ALLTRIM(TratarNulo(cursor_4c_Tratamento.Ocorrencia, "C"))
3302:         ENDIF
3303:     ENDPROC

*-- Linhas 3310 a 3337:
3310:         loc_lResultado = .T.
3311: 
3312:         TRY
3313:             loc_oGrid = THIS.pgf_4c_Paginas.Page3.grd_4c_Dados
3314:             loc_cOcor = ALLTRIM(loc_oGrid.Column8.Text1.Value)
3315: 
3316:             WITH THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1
3317:                 .cmd_4c_BarraNovo.Visible = .F.
3318:             ENDWITH
3319: 
3320:             IF !EMPTY(loc_cOcor) AND loc_cOcor != THIS.this_cOldValue
3321:                 loc_lResultado = THIS.AbrirLookupOcorrencia("O", "<>", loc_cOcor, ;
3322:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Column8.Text1)
3323:             ENDIF
3324: 
3325:             *-- Atualizar usuario no painel
3326:             IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
3327:                 THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.txt_4c_Usuars.Value = ;
3328:                     ALLTRIM(gc_4c_UsuarioLogado)
3329:             ENDIF
3330:         CATCH TO loException
3331:             MsgErro("Erro em GrdColOcorValid:" + CHR(13) + ;
3332:                 loException.Message + CHR(13) + ;
3333:                 "Linha: " + TRANSFORM(loException.LineNo), ;
3334:                 "Formint.GrdColOcorValid")
3335:             loc_lResultado = .F.
3336:         ENDTRY
3337: 

*-- Linhas 3346 a 3364:
3346: 
3347:         TRY
3348:             IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
3349:                 loc_cNovo  = ALLTRIM(THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Column8.Text1.Value)
3350:                 loc_oTotal = THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.cnt_4c__Total
3351:                 loc_nCOc   = loc_oTotal.txt_4c_TotCOc.Value
3352:                 loc_nSOc   = loc_oTotal.txt_4c_TotSOc.Value
3353: 
3354:                 IF !EMPTY(THIS.this_cOldValue) AND EMPTY(loc_cNovo)
3355:                     loc_nCOc = loc_nCOc - 1
3356:                     loc_nSOc = loc_nSOc + 1
3357:                 ELSE
3358:                     IF EMPTY(THIS.this_cOldValue) AND !EMPTY(loc_cNovo)
3359:                         loc_nCOc = loc_nCOc + 1
3360:                         loc_nSOc = loc_nSOc - 1
3361:                     ENDIF
3362:                 ENDIF
3363: 
3364:                 loc_oTotal.txt_4c_TotCOc.Value = MAX(0, loc_nCOc)

*-- Linhas 3387 a 3406:
3387:         IF !EMPTY(THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.edt_4c_ObsCnt1.Value)
3388:             THIS.this_cObsAnterior = ALLTRIM(THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.edt_4c_ObsCnt1.Value)
3389:         ENDIF
3390:         THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.SetFocus()
3391:         THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Column8.Text1.SetFocus()
3392:     ENDPROC
3393: 
3394:     *===========================================================================
3395:     * BtnSobraClick - Exibe painel de insercao de item de sobra
3396:     *===========================================================================
3397:     PROCEDURE BtnSobraClick()
3398:         LOCAL loc_oCnt
3399:         TRY
3400:             loc_oCnt = THIS.pgf_4c_Paginas.Page3.cnt_4c__Inserir
3401:             WITH loc_oCnt
3402:                 .Visible = .T.
3403:                 .cmd_4c_CntInsere.Enabled = .F.
3404:                 .txt_4c_IBarra.Value = ""
3405:                 .txt_4c_ICCusto.Value = ""
3406:                 .txt_4c_IOcor.Value = ""

*-- Linhas 3423 a 3441:
3423:             loc_oPg3 = THIS.pgf_4c_Paginas.Page3
3424:             WITH loc_oPg3
3425:                 .cnt_4c__CCusto1.Visible   = .F.
3426:                 .grd_4c_Dados.Visible      = .F.
3427:                 .cnt_4c__Procurar.Visible  = .T.
3428:                 .cnt_4c__Procurar.Refresh()
3429:                 .cnt_4c__Procurar.txt_4c_GetBusca.Value = ""
3430:                 .cnt_4c__Procurar.txt_4c_GetBusca.SetFocus()
3431:             ENDWITH
3432:         CATCH TO loException
3433:             MsgErro("Erro em BtnProcurarCntClick:" + CHR(13) + loException.Message, ;
3434:                 "Formint.BtnProcurarCntClick")
3435:         ENDTRY
3436:     ENDPROC
3437: 
3438:     *===========================================================================
3439:     * BtnBarraNovoCntClick - Exibe painel de novo barra
3440:     *===========================================================================
3441:     PROCEDURE BtnBarraNovoCntClick()

*-- Linhas 3472 a 3490:
3472: 
3473:             IF loc_lConfirmar
3474:                 THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.Visible  = .F.
3475:                 THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Visible      = .F.
3476:                 THIS.pgf_4c_Paginas.ActivePage = 1
3477:                 THIS.this_cModoAtual = "LISTA"
3478:                 THIS.CarregarLista()
3479:             ENDIF
3480:         CATCH TO loException
3481:             MsgErro("Erro em BtnCancelaCntClick:" + CHR(13) + loException.Message, ;
3482:                 "Formint.BtnCancelaCntClick")
3483:         ENDTRY
3484:     ENDPROC
3485: 
3486:     *===========================================================================
3487:     * BtnSairCntClick - Salva tratamento (se Caption="Grava") ou volta para Page1
3488:     *===========================================================================
3489:     PROCEDURE BtnSairCntClick()
3490:         LOCAL loc_lResultado, loc_cCaption, loc_cSQL, loc_nResult, loc_lValido

*-- Linhas 3506 a 3524:
3506:                             MsgAviso("Existem lan" + CHR(231) + "amentos com Ocorr" + CHR(234) + ;
3507:                                 "ncia sem Observa" + CHR(231) + CHR(227) + "o !!!", ;
3508:                                 "Valida" + CHR(231) + CHR(227) + "o")
3509:                             THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Column8.Text1.SetFocus()
3510:                             loc_lValido = .F.
3511:                             EXIT
3512:                         ENDIF
3513:                     ENDSCAN
3514: 
3515:                     IF loc_lValido
3516:                         *-- Gravar cada linha na tabela SigIvTrT
3517:                         SELECT cursor_4c_Tratamento
3518:                         GO TOP
3519:                         SCAN
3520:                             loc_cSQL = "UPDATE SigIvTrT SET" + ;
3521:                                 " Ocorrencia = " + EscaparSQL(ALLTRIM(cursor_4c_Tratamento.Ocorrencia)) + ;
3522:                                 ", Obs = " + EscaparSQL(ALLTRIM(cursor_4c_Tratamento.Obs)) + ;
3523:                                 ", Obs2s = " + EscaparSQL(ALLTRIM(cursor_4c_Tratamento.Obs2s)) + ;
3524:                                 ", Usuars = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ;

*-- Linhas 3551 a 3569:
3551: 
3552:             IF loc_lResultado
3553:                 THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.Visible = .F.
3554:                 THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Visible     = .F.
3555:                 THIS.pgf_4c_Paginas.ActivePage = 1
3556:                 THIS.this_cModoAtual = "LISTA"
3557:                 THIS.CarregarLista()
3558:             ENDIF
3559:         CATCH TO loException
3560:             MsgErro("Erro em BtnSairCntClick:" + CHR(13) + ;
3561:                 loException.Message + CHR(13) + ;
3562:                 "Linha: " + TRANSFORM(loException.LineNo), ;
3563:                 "Formint.BtnSairCntClick")
3564:         ENDTRY
3565: 
3566:         RETURN loc_lResultado
3567:     ENDPROC
3568: 
3569:     *===========================================================================

*-- Linhas 3593 a 3633:
3593:     *===========================================================================
3594:     PROCEDURE BtnBNCancelaClick()
3595:         THIS.pgf_4c_Paginas.Page3.cnt_4c__Custo2.Visible = .F.
3596:         THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Refresh()
3597:     ENDPROC
3598: 
3599:     *===========================================================================
3600:     * BtnBNSairClick - Confirma novo barra e habilita botao Grava
3601:     *===========================================================================
3602:     PROCEDURE BtnBNSairClick()
3603:         LOCAL loc_oCnt2, loc_cObs2s
3604:         TRY
3605:             loc_oCnt2 = THIS.pgf_4c_Paginas.Page3.cnt_4c__Custo2
3606:             loc_cObs2s = ALLTRIM(loc_oCnt2.edt_4c_BNObs.Value)
3607: 
3608:             IF !EMPTY(loc_cObs2s) AND USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
3609:                 SELECT cursor_4c_Tratamento
3610:                 REPLACE cursor_4c_Tratamento.Obs2s WITH loc_cObs2s
3611:                 REPLACE cursor_4c_Tratamento.BarraNovos WITH ALLTRIM(loc_oCnt2.txt_4c_GetBarNovo.Value)
3612:             ENDIF
3613: 
3614:             loc_oCnt2.Visible = .F.
3615:             THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.cmd_4c_CancelaCnt.Visible = .T.
3616:             THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.cmd_4c_SairCnt.Caption    = "\<Grava"
3617:             THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Refresh()
3618:             THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Column8.Text1.SetFocus()
3619:         CATCH TO loException
3620:             MsgErro("Erro em BtnBNSairClick:" + CHR(13) + loException.Message, ;
3621:                 "Formint.BtnBNSairClick")
3622:         ENDTRY
3623:     ENDPROC
3624: 
3625:     *===========================================================================
3626:     * GetTOcorCntTratValid - Lookup de Ocorrencia no painel TratOcor (Tipos='O')
3627:     *===========================================================================
3628:     PROCEDURE GetTOcorCntTratValid()
3629:         LOCAL loc_lResultado, loc_oTxt
3630:         loc_lResultado = .T.
3631: 
3632:         TRY
3633:             loc_oTxt = THIS.pgf_4c_Paginas.Page3.cnt_4c_TratOcor.txt_4c_TOcor

*-- Linhas 3699 a 3717:
3699:                     loc_oCnt.Visible = .F.
3700:                     THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.cmd_4c_CancelaCnt.Visible = .T.
3701:                     THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.cmd_4c_SairCnt.Caption    = "\<Grava"
3702:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Refresh()
3703:                     loc_lResultado = .T.
3704:                 ENDIF
3705:             ENDIF
3706:         CATCH TO loException
3707:             MsgErro("Erro em BtnTratOcorClick:" + CHR(13) + ;
3708:                 loException.Message + CHR(13) + ;
3709:                 "Linha: " + TRANSFORM(loException.LineNo), ;
3710:                 "Formint.BtnTratOcorClick")
3711:         ENDTRY
3712: 
3713:         RETURN loc_lResultado
3714:     ENDPROC
3715: 
3716:     *===========================================================================
3717:     * BtnTOCancelaClick - Cancela painel TratOcor e volta para Page1

*-- Linhas 3947 a 4009:
3947:                     loc_oCnt.cmd_4c_CntInsere.Enabled = .F.
3948:                     loc_oCnt.txt_4c_IBarra.SetFocus()
3949: 
3950:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Refresh()
3951:                     loc_lResultado = .T.
3952:                 ENDIF
3953:             ENDIF
3954:         CATCH TO loException
3955:             MsgErro("Erro em CntInsereClick:" + CHR(13) + ;
3956:                 loException.Message + CHR(13) + ;
3957:                 "Linha: " + TRANSFORM(loException.LineNo), ;
3958:                 "Formint.CntInsereClick")
3959:         ENDTRY
3960: 
3961:         RETURN loc_lResultado
3962:     ENDPROC
3963: 
3964:     *===========================================================================
3965:     * CntSairInsClick - Fecha painel Inserir e volta ao grid
3966:     *===========================================================================
3967:     PROCEDURE CntSairInsClick()
3968:         THIS.pgf_4c_Paginas.Page3.cnt_4c__Inserir.Visible = .F.
3969:         THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.SetFocus()
3970:         THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Column8.Text1.SetFocus()
3971:     ENDPROC
3972: 
3973:     *===========================================================================
3974:     * GetBuscaValid - Busca item por barra no grid de tratamento
3975:     *===========================================================================
3976:     PROCEDURE GetBuscaValid(par_nKeyCode, par_nShiftAltCtrl)
3977:         LOCAL loc_lResultado, loc_cBarra, loc_oPr
3978:         loc_lResultado = .T.
3979: 
3980:         TRY
3981:             loc_oPr    = THIS.pgf_4c_Paginas.Page3.cnt_4c__Procurar
3982:             loc_cBarra = ALLTRIM(loc_oPr.txt_4c_GetBusca.Value)
3983: 
3984:             IF !EMPTY(loc_cBarra) AND USED("cursor_4c_Tratamento")
3985:                 SELECT cursor_4c_Tratamento
3986:                 GO TOP
3987:                 LOCATE FOR ALLTRIM(TRANSFORM(cursor_4c_Tratamento.Barras)) = loc_cBarra
3988:                 IF FOUND()
3989:                     *-- Mostrar grid e painel, ocultar procurar
3990:                     loc_oPr.Visible = .F.
3991:                     THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.Visible = .T.
3992:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Visible    = .T.
3993:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Refresh()
3994:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.SetFocus()
3995:                 ELSE
3996:                     MsgAviso("Barra '" + loc_cBarra + "' n" + CHR(227) + "o encontrada.", ;
3997:                         "Busca")
3998:                 ENDIF
3999:             ENDIF
4000:         CATCH TO loException
4001:             MsgErro("Erro em GetBuscaValid:" + CHR(13) + loException.Message, ;
4002:                 "Formint.GetBuscaValid")
4003:             loc_lResultado = .F.
4004:         ENDTRY
4005: 
4006:         RETURN loc_lResultado
4007:     ENDPROC
4008: 
4009:     *===========================================================================

*-- Linhas 4036 a 4055:
4036:                 loc_cFiltro)            ;   && Filtro (sem WHERE)
4037: 
4038:             IF VARTYPE(loc_oLookup) = "O"
4039:                 loc_oLookup.mAddColuna("Codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
4040:                 loc_oLookup.mAddColuna("Descrs",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4041:                 loc_oLookup.Show()
4042: 
4043:                 IF loc_oLookup.this_lSelecionou
4044:                     par_oTxt.Value = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
4045:                     par_oTxt.Refresh()
4046:                 ELSE
4047:                     loc_lResultado = .F.
4048:                 ENDIF
4049: 
4050:                 IF USED("cursor_4c_BuscaOcorr")
4051:                     USE IN cursor_4c_BuscaOcorr
4052:                 ENDIF
4053:                 loc_oLookup = .NULL.
4054:             ELSE
4055:                 MsgErro("Erro ao criar FormBuscaAuxiliar.", "Formint.AbrirLookupOcorrencia")

*-- Linhas 4084 a 4103:
4084:                 "Tipos = 'O' AND Autos = 'S'")
4085: 
4086:             IF VARTYPE(loc_oLookup) = "O"
4087:                 loc_oLookup.mAddColuna("Codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
4088:                 loc_oLookup.mAddColuna("Descrs",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4089:                 loc_oLookup.Show()
4090: 
4091:                 IF loc_oLookup.this_lSelecionou
4092:                     par_oTxt.Value = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
4093:                     par_oTxt.Refresh()
4094:                 ELSE
4095:                     loc_lResultado = .F.
4096:                 ENDIF
4097: 
4098:                 loc_oLookup = .NULL.
4099:             ELSE
4100:                 MsgErro("Erro ao criar FormBuscaAuxiliar.", "Formint.AbrirLookupOcorrenciaBaixaAuto")
4101:                 loc_lResultado = .F.
4102:             ENDIF
4103:         CATCH TO loException

