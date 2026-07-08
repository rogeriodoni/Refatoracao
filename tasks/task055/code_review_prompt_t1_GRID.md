# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 726: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReCmp.prg) - TRECHOS RELEVANTES PARA PASS GRID (2710 linhas total):

*-- Linhas 272 a 306:
272:     *   - Grupo Estoque / Conta
273:     *   - Grande Grupo, Grupo Produto, Subgrupo
274:     *   - Situacao (optSituas), Agrupamento (optagrupa), checkboxes
275:     *   - Grid grd_4c_Dados (tipos de movimentacao com checkboxes)
276:     *   - Botoes SelTudo e Apaga
277:     * Posicoes: Top original - 85 (PageFrame.Top=85)
278:     *==========================================================================
279:     PROTECTED PROCEDURE ConfigurarPaginaLista()
280:         LOCAL loc_oPagina, loc_oGrid, loc_oErro
281:         TRY
282:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
283: 
284:             *-- Inicializar cursor de tipos de movimentacao antes de criar o grid
285:             IF VARTYPE(THIS.this_oRelatorio) = "O"
286:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
287:                     THIS.this_oRelatorio.InicializarDados()
288:                 ELSE
289:                     *-- Modo validacao UI: criar cursor vazio para o grid funcionar
290:                     IF !USED("cursor_4c_TipoMov")
291:                         CREATE CURSOR cursor_4c_TipoMov ;
292:                             (Marca N(1), Descri C(40), Codigos N(2))
293:                     ENDIF
294:                 ENDIF
295:             ENDIF
296: 
297:             *-- ===== ROW 1: PERIODO =====
298:             loc_oPagina.AddObject("lbl_4c_Lbl_periodo", "Label")
299:             WITH loc_oPagina.lbl_4c_Lbl_periodo
300:                 .Top       = 38
301:                 .Left      = 55
302:                 .Width     = 45
303:                 .Height    = 18
304:                 .Caption   = "Per" + CHR(237) + "odo :"
305:                 .FontName  = "Tahoma"
306:                 .FontSize  = 8

*-- Linhas 712 a 774:
712:                 .Enabled       = .F.
713:                 .SpecialEffect = 0
714:                 .Visible       = .T.
715:             ENDWITH
716: 
717:             *-- ===== GRID TIPOS DE MOVIMENTACAO (rows 5-8 direita) =====
718:             loc_oPagina.AddObject("grd_4c_Dados", "Grid")
719:             loc_oGrid = loc_oPagina.grd_4c_Dados
720:             WITH loc_oGrid
721:                 .Top                = 158
722:                 .Left               = 511
723:                 .Width              = 251
724:                 .Height             = 130
725:                 .ColumnCount        = 2
726:                 .RecordSource       = "cursor_4c_TipoMov"
727:                 .RecordSourceType   = 1
728:                 .FontName           = "Verdana"
729:                 .FontSize           = 8
730:                 .ForeColor          = RGB(90, 90, 90)
731:                 .BackColor          = RGB(255, 255, 255)
732:                 .GridLineColor      = RGB(238, 238, 238)
733:                 .HighlightBackColor = RGB(255, 255, 255)
734:                 .HighlightForeColor = RGB(15, 41, 104)
735:                 .HighlightStyle     = 2
736:                 .DeleteMark         = .F.
737:                 .RecordMark         = .F.
738:                 .RowHeight          = 16
739:                 .ScrollBars         = 2
740:                 .Themes             = .F.
741: 
742:                 *-- Column1: CheckBox para Marca (campo booleano de selecao)
743:                 WITH .Column1
744:                     .Width = 25
745:                     .Header1.Caption = ""
746:                     .AddObject("Check1", "CheckBox")
747:                     .Check1.Caption = ""
748:                     .Check1.Value = 0
749:                     .CurrentControl = "Check1"
750:                     .ControlSource = "cursor_4c_TipoMov.Marca"
751:                     .Visible = .T.
752:                 ENDWITH
753: 
754:                 *-- Column2: Descricao do tipo de movimentacao
755:                 WITH .Column2
756:                     .Width = 224
757:                     .ControlSource = "cursor_4c_TipoMov.Descri"
758:                     .ReadOnly = .T.
759:                     .Header1.Caption = "Tipo"
760:                     .Visible = .T.
761:                 ENDWITH
762: 
763:                 .Visible = .T.
764:             ENDWITH
765: 
766:             *-- Botoes SelTudo / Apaga (direita do grid)
767:             loc_oPagina.AddObject("cmd_4c_SelTudo", "CommandButton")
768:             WITH loc_oPagina.cmd_4c_SelTudo
769:                 .Top          = 186
770:                 .Left         = 763
771:                 .Width        = 35
772:                 .Height       = 34
773:                 .Caption      = ""
774:                 .Picture      = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"

*-- Linhas 1693 a 1726:
1693:             THIS.this_oRelatorio.MarcarTodos()
1694:         ENDIF
1695:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
1696:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Dados", 5)
1697:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
1698:             ENDIF
1699:         ENDIF
1700:     ENDPROC
1701: 
1702:     *==========================================================================
1703:     * BtnApagaClick - Desmarca todos os tipos de movimentacao no grid
1704:     *==========================================================================
1705:     PROCEDURE BtnApagaClick()
1706:         IF VARTYPE(THIS.this_oRelatorio) = "O"
1707:             THIS.this_oRelatorio.DesmarcarTodos()
1708:         ENDIF
1709:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
1710:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Dados", 5)
1711:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
1712:             ENDIF
1713:         ENDIF
1714:     ENDPROC
1715: 
1716:     *==========================================================================
1717:     * TxtOperacaoKeyPress - F4=115 abre busca; ENTER=13/TAB=9 valida
1718:     *==========================================================================
1719:     PROCEDURE TxtOperacaoKeyPress(par_nKeyCode, par_nShift)
1720:         IF par_nKeyCode = 115
1721:             THIS.AbrirBuscaOperacao()
1722:         ELSE
1723:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1724:             THIS.ValidarOperacao()
1725:             ENDIF
1726:         ENDIF

*-- Linhas 1784 a 1803:
1784:                     ENDIF
1785:                 ELSE
1786:                     IF !loc_oBusca.this_lAchouRegistro
1787:                     loc_oBusca.mAddColuna("Dopes",  "", "C" + CHR(243) + "digo")
1788:                     loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1789:                     loc_oBusca.Show()
1790:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
1791:                         SELECT cursor_4c_BuscaOpe
1792:                         IF PEMSTATUS(loc_oPg, "txt_4c__operacao", 5)
1793:                             loc_oPg.txt_4c__operacao.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
1794:                             IF PEMSTATUS(loc_oPg, "chk_4c_Chkservico", 5)
1795:                                 loc_oPg.chk_4c_Chkservico.Enabled = .T.
1796:                             ENDIF
1797:                         ENDIF
1798:                     ENDIF
1799:                     ENDIF
1800:                 ENDIF
1801:                 loc_oBusca.Release()
1802:             ENDIF
1803:             IF USED("cursor_4c_BuscaOpe")

*-- Linhas 1886 a 1905:
1886:                     ENDIF
1887:                 ELSE
1888:                     IF !loc_oBusca.this_lAchouRegistro
1889:                     loc_oBusca.mAddColuna("Codigos", "XXX", "C" + CHR(243) + "digo")
1890:                     loc_oBusca.mAddColuna("Descrs",  "",    "Descri" + CHR(231) + CHR(227) + "o")
1891:                     loc_oBusca.Show()
1892:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaObs")
1893:                         SELECT cursor_4c_BuscaObs
1894:                         IF PEMSTATUS(loc_oPg, "txt_4c_CodObs", 5)
1895:                             loc_oPg.txt_4c_CodObs.Value = cursor_4c_BuscaObs.Codigos
1896:                         ENDIF
1897:                         IF PEMSTATUS(loc_oPg, "txt_4c_DesObs", 5)
1898:                             loc_oPg.txt_4c_DesObs.Value = ALLTRIM(cursor_4c_BuscaObs.Descrs)
1899:                             loc_oPg.txt_4c_DesObs.Enabled = .T.
1900:                         ENDIF
1901:                     ENDIF
1902:                     ENDIF
1903:                 ENDIF
1904:                 loc_oBusca.Release()
1905:             ENDIF

*-- Linhas 1962 a 1981:
1962:                     ENDIF
1963:                 ELSE
1964:                     IF !loc_oBusca.this_lAchouRegistro
1965:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1966:                     loc_oBusca.mAddColuna("Codigos", "XXX", "C" + CHR(243) + "digo")
1967:                     loc_oBusca.Show()
1968:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaObsD")
1969:                         SELECT cursor_4c_BuscaObsD
1970:                         IF PEMSTATUS(loc_oPg, "txt_4c_CodObs", 5)
1971:                             loc_oPg.txt_4c_CodObs.Value = cursor_4c_BuscaObsD.Codigos
1972:                         ENDIF
1973:                         IF PEMSTATUS(loc_oPg, "txt_4c_DesObs", 5)
1974:                             loc_oPg.txt_4c_DesObs.Value = ALLTRIM(cursor_4c_BuscaObsD.Descrs)
1975:                         ENDIF
1976:                     ENDIF
1977:                     ENDIF
1978:                 ENDIF
1979:                 loc_oBusca.Release()
1980:             ENDIF
1981:             IF USED("cursor_4c_BuscaObsD")

*-- Linhas 2060 a 2079:
2060:                     ENDIF
2061:                 ELSE
2062:                     IF !loc_oBusca.this_lAchouRegistro
2063:                     loc_oBusca.mAddColuna("Cemps", "XXX", "C" + CHR(243) + "digo")
2064:                     loc_oBusca.mAddColuna("Razas", "",    "Raz" + CHR(227) + "o Social")
2065:                     loc_oBusca.Show()
2066:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
2067:                         SELECT cursor_4c_BuscaEmp
2068:                         IF PEMSTATUS(loc_oPg, "txt_4c__empresa", 5)
2069:                             loc_oPg.txt_4c__empresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
2070:                         ENDIF
2071:                         IF PEMSTATUS(loc_oPg, "txt_4c__empresa_desc", 5)
2072:                             loc_oPg.txt_4c__empresa_desc.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
2073:                             loc_oPg.txt_4c__empresa_desc.Enabled = .T.
2074:                         ENDIF
2075:                     ENDIF
2076:                     ENDIF
2077:                 ENDIF
2078:                 loc_oBusca.Release()
2079:             ENDIF

*-- Linhas 2201 a 2220:
2201:                     ENDIF
2202:                 ELSE
2203:                     IF !loc_oBusca.this_lAchouRegistro
2204:                     loc_oBusca.mAddColuna("codigos", "",  "C" + CHR(243) + "digo")
2205:                     loc_oBusca.mAddColuna("descs",   "",  "Descri" + CHR(231) + CHR(227) + "o")
2206:                     loc_oBusca.Show()
2207:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGGru")
2208:                         SELECT cursor_4c_BuscaGGru
2209:                         IF PEMSTATUS(loc_oPg, "txt_4c__cd_ggrupo", 5)
2210:                             loc_oPg.txt_4c__cd_ggrupo.Value = ;
2211:                                 ALLTRIM(STR(cursor_4c_BuscaGGru.codigos, 2))
2212:                         ENDIF
2213:                         IF PEMSTATUS(loc_oPg, "txt_4c__ds_ggrupo", 5)
2214:                             loc_oPg.txt_4c__ds_ggrupo.Value = ALLTRIM(cursor_4c_BuscaGGru.descs)
2215:                             loc_oPg.txt_4c__ds_ggrupo.Enabled = .T.
2216:                         ENDIF
2217:                     ENDIF
2218:                     ENDIF
2219:                 ENDIF
2220:                 loc_oBusca.Release()

*-- Linhas 2276 a 2295:
2276:                         ENDIF
2277:                     ELSE
2278:                         IF !loc_oBusca.this_lAchouRegistro
2279:                         loc_oBusca.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
2280:                         loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
2281:                         loc_oBusca.Show()
2282:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGGruD")
2283:                             SELECT cursor_4c_BuscaGGruD
2284:                             IF PEMSTATUS(loc_oPg, "txt_4c__cd_ggrupo", 5)
2285:                                 loc_oPg.txt_4c__cd_ggrupo.Value = ;
2286:                                     ALLTRIM(STR(cursor_4c_BuscaGGruD.codigos, 2))
2287:                             ENDIF
2288:                             IF PEMSTATUS(loc_oPg, "txt_4c__ds_ggrupo", 5)
2289:                                 loc_oPg.txt_4c__ds_ggrupo.Value = ;
2290:                                     ALLTRIM(cursor_4c_BuscaGGruD.descs)
2291:                             ENDIF
2292:                         ENDIF
2293:                         ENDIF
2294:                     ENDIF
2295:                     loc_oBusca.Release()

*-- Linhas 2378 a 2397:
2378:                     ENDIF
2379:                 ELSE
2380:                     IF !loc_oBusca.this_lAchouRegistro
2381:                     loc_oBusca.mAddColuna("CGrus", "XXX", "C" + CHR(243) + "digo")
2382:                     loc_oBusca.mAddColuna("DGrus", "",    "Descri" + CHR(231) + CHR(227) + "o")
2383:                     loc_oBusca.Show()
2384:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGru")
2385:                         SELECT cursor_4c_BuscaGru
2386:                         IF PEMSTATUS(loc_oPg, "txt_4c__grupo", 5)
2387:                             loc_oPg.txt_4c__grupo.Value = ALLTRIM(cursor_4c_BuscaGru.CGrus)
2388:                         ENDIF
2389:                         IF PEMSTATUS(loc_oPg, "txt_4c__grupo_desc", 5)
2390:                             loc_oPg.txt_4c__grupo_desc.Value = ALLTRIM(cursor_4c_BuscaGru.DGrus)
2391:                             loc_oPg.txt_4c__grupo_desc.Enabled = .T.
2392:                         ENDIF
2393:                     ENDIF
2394:                     ENDIF
2395:                 ENDIF
2396:                 loc_oBusca.Release()
2397:             ENDIF

*-- Linhas 2446 a 2465:
2446:                         ENDIF
2447:                     ELSE
2448:                         IF !loc_oBusca.this_lAchouRegistro
2449:                         loc_oBusca.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
2450:                         loc_oBusca.mAddColuna("CGrus", "XXX", "C" + CHR(243) + "digo")
2451:                         loc_oBusca.Show()
2452:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGruD")
2453:                             SELECT cursor_4c_BuscaGruD
2454:                             IF PEMSTATUS(loc_oPg, "txt_4c__grupo", 5)
2455:                                 loc_oPg.txt_4c__grupo.Value = ALLTRIM(cursor_4c_BuscaGruD.CGrus)
2456:                             ENDIF
2457:                             IF PEMSTATUS(loc_oPg, "txt_4c__grupo_desc", 5)
2458:                                 loc_oPg.txt_4c__grupo_desc.Value = ALLTRIM(cursor_4c_BuscaGruD.DGrus)
2459:                             ENDIF
2460:                         ENDIF
2461:                         ENDIF
2462:                     ENDIF
2463:                     loc_oBusca.Release()
2464:                 ENDIF
2465:                 IF USED("cursor_4c_BuscaGruD")

*-- Linhas 2551 a 2572:
2551:                     ENDIF
2552:                 ELSE
2553:                     IF !loc_oBusca.this_lAchouRegistro
2554:                     loc_oBusca.mAddColuna("Codigos",    "XXXXXXXXXX", "Sub-Grupo")
2555:                     loc_oBusca.mAddColuna("Descricaos", "XXXXXXXXXXXXXXXXXXXX", ;
2556:                         "Descri" + CHR(231) + CHR(227) + "o")
2557:                     loc_oBusca.mAddColuna("CGrus", "XXXXXXXXXX", "Grupo")
2558:                     loc_oBusca.Show()
2559:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSGru")
2560:                         SELECT cursor_4c_BuscaSGru
2561:                         IF PEMSTATUS(loc_oPg, "txt_4c__cd_sgrupo", 5)
2562:                             loc_oPg.txt_4c__cd_sgrupo.Value = ;
2563:                                 ALLTRIM(cursor_4c_BuscaSGru.Codigos)
2564:                         ENDIF
2565:                         IF PEMSTATUS(loc_oPg, "txt_4c__ds_sgrupo", 5)
2566:                             loc_oPg.txt_4c__ds_sgrupo.Value = ;
2567:                                 ALLTRIM(cursor_4c_BuscaSGru.Descricaos)
2568:                             loc_oPg.txt_4c__ds_sgrupo.Enabled = .T.
2569:                         ENDIF
2570:                     ENDIF
2571:                     ENDIF
2572:                 ENDIF

*-- Linhas 2625 a 2646:
2625:                         ENDIF
2626:                     ELSE
2627:                         IF !loc_oBusca.this_lAchouRegistro
2628:                         loc_oBusca.mAddColuna("Descricaos", "XXXXXXXXXXXXXXXXXXXX", ;
2629:                             "Descri" + CHR(231) + CHR(227) + "o")
2630:                         loc_oBusca.mAddColuna("Codigos",    "XXXXXXXXXX", "Sub-Grupo")
2631:                         loc_oBusca.mAddColuna("CGrus",      "XXXXXXXXXX", "Grupo")
2632:                         loc_oBusca.Show()
2633:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSGruD")
2634:                             SELECT cursor_4c_BuscaSGruD
2635:                             IF PEMSTATUS(loc_oPg, "txt_4c__cd_sgrupo", 5)
2636:                                 loc_oPg.txt_4c__cd_sgrupo.Value = ;
2637:                                     ALLTRIM(cursor_4c_BuscaSGruD.Codigos)
2638:                             ENDIF
2639:                             IF PEMSTATUS(loc_oPg, "txt_4c__ds_sgrupo", 5)
2640:                                 loc_oPg.txt_4c__ds_sgrupo.Value = ;
2641:                                     ALLTRIM(cursor_4c_BuscaSGruD.Descricaos)
2642:                             ENDIF
2643:                         ENDIF
2644:                         ENDIF
2645:                     ENDIF
2646:                     loc_oBusca.Release()

