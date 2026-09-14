# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 728: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReCmp.prg) - TRECHOS RELEVANTES PARA PASS GRID (2716 linhas total):

*-- Linhas 272 a 309:
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
291:                         SET NULL ON
292:                         CREATE CURSOR cursor_4c_TipoMov ;
293:                             (Marca N(1), Descri C(40), Codigos N(2))
294:                         SET NULL OFF
295:                     ENDIF
296:                 ENDIF
297:             ENDIF
298: 
299:             *-- ===== ROW 1: PERIODO =====
300:             loc_oPagina.AddObject("lbl_4c_Lbl_periodo", "Label")
301:             WITH loc_oPagina.lbl_4c_Lbl_periodo
302:                 .Top       = 38
303:                 .Left      = 55
304:                 .Width     = 45
305:                 .Height    = 18
306:                 .Caption   = "Per" + CHR(237) + "odo :"
307:                 .FontName  = "Tahoma"
308:                 .FontSize  = 8
309:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 714 a 783:
714:                 .Enabled       = .F.
715:                 .SpecialEffect = 0
716:                 .Visible       = .T.
717:             ENDWITH
718: 
719:             *-- ===== GRID TIPOS DE MOVIMENTACAO (rows 5-8 direita) =====
720:             loc_oPagina.AddObject("grd_4c_Dados", "Grid")
721:             loc_oGrid = loc_oPagina.grd_4c_Dados
722:             WITH loc_oGrid
723:                 .Top                = 158
724:                 .Left               = 511
725:                 .Width              = 251
726:                 .Height             = 130
727:                 .ColumnCount        = 2
728:                 .RecordSource       = "cursor_4c_TipoMov"
729:                 .RecordSourceType   = 1
730:                 .FontName           = "Verdana"
731:                 .FontSize           = 8
732:                 .ForeColor          = RGB(90, 90, 90)
733:                 .BackColor          = RGB(255, 255, 255)
734:                 .GridLineColor      = RGB(238, 238, 238)
735:                 .HighlightBackColor = RGB(255, 255, 255)
736:                 .HighlightForeColor = RGB(15, 41, 104)
737:                 .HighlightStyle     = 2
738:                 .DeleteMark         = .F.
739:                 .RecordMark         = .F.
740:                 .RowHeight          = 16
741:                 .ScrollBars         = 2
742:                 .Themes             = .F.
743: 
744:                 *-- Column1: CheckBox para Marca (campo booleano de selecao)
745:                 WITH .Column1
746:                     .Width = 25
747:                     .Header1.Caption = ""
748:                     .AddObject("Check1", "CheckBox")
749:                     .Check1.Caption = ""
750:                     .Check1.Value = 0
751:                     .CurrentControl = "Check1"
752:                     .ControlSource = "cursor_4c_TipoMov.Marca"
753:                     .Visible = .T.
754:                 ENDWITH
755: 
756:                 *-- Column2: Descricao do tipo de movimentacao
757:                 WITH .Column2
758:                     .Width = 224
759:                     .ControlSource = "cursor_4c_TipoMov.Descri"
760:                     .ReadOnly = .T.
761:                     .Header1.Caption = "Descrs"
762:                     .Visible = .T.
763:                 ENDWITH
764: 
765:                 .Visible = .T.
766:             ENDWITH
767: 
768:             *-- Re-definir ControlSource apos RecordSource (auto-bind por ordem de campo pode sobrescrever)
769:             loc_oGrid.Column1.ControlSource = "cursor_4c_TipoMov.Marca"
770:             loc_oGrid.Column2.ControlSource = "cursor_4c_TipoMov.Descri"
771: 
772:             *-- Botoes SelTudo / Apaga (direita do grid)
773:             loc_oPagina.AddObject("cmd_4c_SelTudo", "CommandButton")
774:             WITH loc_oPagina.cmd_4c_SelTudo
775:                 .Top          = 186
776:                 .Left         = 763
777:                 .Width        = 35
778:                 .Height       = 34
779:                 .Caption      = ""
780:                 .Picture      = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
781:                 .ToolTipText  = "Selecionar Todos"
782:                 .FontName     = "Tahoma"
783:                 .FontSize     = 8

*-- Linhas 1699 a 1732:
1699:             THIS.this_oRelatorio.MarcarTodos()
1700:         ENDIF
1701:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
1702:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Dados", 5)
1703:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
1704:             ENDIF
1705:         ENDIF
1706:     ENDPROC
1707: 
1708:     *==========================================================================
1709:     * BtnApagaClick - Desmarca todos os tipos de movimentacao no grid
1710:     *==========================================================================
1711:     PROCEDURE BtnApagaClick()
1712:         IF VARTYPE(THIS.this_oRelatorio) = "O"
1713:             THIS.this_oRelatorio.DesmarcarTodos()
1714:         ENDIF
1715:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
1716:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Dados", 5)
1717:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
1718:             ENDIF
1719:         ENDIF
1720:     ENDPROC
1721: 
1722:     *==========================================================================
1723:     * TxtOperacaoKeyPress - F4=115 abre busca; ENTER=13/TAB=9 valida
1724:     *==========================================================================
1725:     PROCEDURE TxtOperacaoKeyPress(par_nKeyCode, par_nShift)
1726:         IF par_nKeyCode = 115
1727:             THIS.AbrirBuscaOperacao()
1728:         ELSE
1729:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1730:             THIS.ValidarOperacao()
1731:             ENDIF
1732:         ENDIF

*-- Linhas 1790 a 1809:
1790:                     ENDIF
1791:                 ELSE
1792:                     IF !loc_oBusca.this_lAchouRegistro
1793:                     loc_oBusca.mAddColuna("Dopes",  "", "C" + CHR(243) + "digo")
1794:                     loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1795:                     loc_oBusca.Show()
1796:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
1797:                         SELECT cursor_4c_BuscaOpe
1798:                         IF PEMSTATUS(loc_oPg, "txt_4c__operacao", 5)
1799:                             loc_oPg.txt_4c__operacao.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
1800:                             IF PEMSTATUS(loc_oPg, "chk_4c_Chkservico", 5)
1801:                                 loc_oPg.chk_4c_Chkservico.Enabled = .T.
1802:                             ENDIF
1803:                         ENDIF
1804:                     ENDIF
1805:                     ENDIF
1806:                 ENDIF
1807:                 loc_oBusca.Release()
1808:             ENDIF
1809:             IF USED("cursor_4c_BuscaOpe")

*-- Linhas 1892 a 1911:
1892:                     ENDIF
1893:                 ELSE
1894:                     IF !loc_oBusca.this_lAchouRegistro
1895:                     loc_oBusca.mAddColuna("Codigos", "XXX", "C" + CHR(243) + "digo")
1896:                     loc_oBusca.mAddColuna("Descrs",  "",    "Descri" + CHR(231) + CHR(227) + "o")
1897:                     loc_oBusca.Show()
1898:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaObs")
1899:                         SELECT cursor_4c_BuscaObs
1900:                         IF PEMSTATUS(loc_oPg, "txt_4c_CodObs", 5)
1901:                             loc_oPg.txt_4c_CodObs.Value = cursor_4c_BuscaObs.Codigos
1902:                         ENDIF
1903:                         IF PEMSTATUS(loc_oPg, "txt_4c_DesObs", 5)
1904:                             loc_oPg.txt_4c_DesObs.Value = ALLTRIM(cursor_4c_BuscaObs.Descrs)
1905:                             loc_oPg.txt_4c_DesObs.Enabled = .T.
1906:                         ENDIF
1907:                     ENDIF
1908:                     ENDIF
1909:                 ENDIF
1910:                 loc_oBusca.Release()
1911:             ENDIF

*-- Linhas 1968 a 1987:
1968:                     ENDIF
1969:                 ELSE
1970:                     IF !loc_oBusca.this_lAchouRegistro
1971:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1972:                     loc_oBusca.mAddColuna("Codigos", "XXX", "C" + CHR(243) + "digo")
1973:                     loc_oBusca.Show()
1974:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaObsD")
1975:                         SELECT cursor_4c_BuscaObsD
1976:                         IF PEMSTATUS(loc_oPg, "txt_4c_CodObs", 5)
1977:                             loc_oPg.txt_4c_CodObs.Value = cursor_4c_BuscaObsD.Codigos
1978:                         ENDIF
1979:                         IF PEMSTATUS(loc_oPg, "txt_4c_DesObs", 5)
1980:                             loc_oPg.txt_4c_DesObs.Value = ALLTRIM(cursor_4c_BuscaObsD.Descrs)
1981:                         ENDIF
1982:                     ENDIF
1983:                     ENDIF
1984:                 ENDIF
1985:                 loc_oBusca.Release()
1986:             ENDIF
1987:             IF USED("cursor_4c_BuscaObsD")

*-- Linhas 2066 a 2085:
2066:                     ENDIF
2067:                 ELSE
2068:                     IF !loc_oBusca.this_lAchouRegistro
2069:                     loc_oBusca.mAddColuna("Cemps", "XXX", "C" + CHR(243) + "digo")
2070:                     loc_oBusca.mAddColuna("Razas", "",    "Raz" + CHR(227) + "o Social")
2071:                     loc_oBusca.Show()
2072:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
2073:                         SELECT cursor_4c_BuscaEmp
2074:                         IF PEMSTATUS(loc_oPg, "txt_4c__empresa", 5)
2075:                             loc_oPg.txt_4c__empresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
2076:                         ENDIF
2077:                         IF PEMSTATUS(loc_oPg, "txt_4c__empresa_desc", 5)
2078:                             loc_oPg.txt_4c__empresa_desc.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
2079:                             loc_oPg.txt_4c__empresa_desc.Enabled = .T.
2080:                         ENDIF
2081:                     ENDIF
2082:                     ENDIF
2083:                 ENDIF
2084:                 loc_oBusca.Release()
2085:             ENDIF

*-- Linhas 2207 a 2226:
2207:                     ENDIF
2208:                 ELSE
2209:                     IF !loc_oBusca.this_lAchouRegistro
2210:                     loc_oBusca.mAddColuna("codigos", "",  "C" + CHR(243) + "digo")
2211:                     loc_oBusca.mAddColuna("descs",   "",  "Descri" + CHR(231) + CHR(227) + "o")
2212:                     loc_oBusca.Show()
2213:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGGru")
2214:                         SELECT cursor_4c_BuscaGGru
2215:                         IF PEMSTATUS(loc_oPg, "txt_4c__cd_ggrupo", 5)
2216:                             loc_oPg.txt_4c__cd_ggrupo.Value = ;
2217:                                 ALLTRIM(STR(cursor_4c_BuscaGGru.codigos, 2))
2218:                         ENDIF
2219:                         IF PEMSTATUS(loc_oPg, "txt_4c__ds_ggrupo", 5)
2220:                             loc_oPg.txt_4c__ds_ggrupo.Value = ALLTRIM(cursor_4c_BuscaGGru.descs)
2221:                             loc_oPg.txt_4c__ds_ggrupo.Enabled = .T.
2222:                         ENDIF
2223:                     ENDIF
2224:                     ENDIF
2225:                 ENDIF
2226:                 loc_oBusca.Release()

*-- Linhas 2282 a 2301:
2282:                         ENDIF
2283:                     ELSE
2284:                         IF !loc_oBusca.this_lAchouRegistro
2285:                         loc_oBusca.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
2286:                         loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
2287:                         loc_oBusca.Show()
2288:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGGruD")
2289:                             SELECT cursor_4c_BuscaGGruD
2290:                             IF PEMSTATUS(loc_oPg, "txt_4c__cd_ggrupo", 5)
2291:                                 loc_oPg.txt_4c__cd_ggrupo.Value = ;
2292:                                     ALLTRIM(STR(cursor_4c_BuscaGGruD.codigos, 2))
2293:                             ENDIF
2294:                             IF PEMSTATUS(loc_oPg, "txt_4c__ds_ggrupo", 5)
2295:                                 loc_oPg.txt_4c__ds_ggrupo.Value = ;
2296:                                     ALLTRIM(cursor_4c_BuscaGGruD.descs)
2297:                             ENDIF
2298:                         ENDIF
2299:                         ENDIF
2300:                     ENDIF
2301:                     loc_oBusca.Release()

*-- Linhas 2384 a 2403:
2384:                     ENDIF
2385:                 ELSE
2386:                     IF !loc_oBusca.this_lAchouRegistro
2387:                     loc_oBusca.mAddColuna("CGrus", "XXX", "C" + CHR(243) + "digo")
2388:                     loc_oBusca.mAddColuna("DGrus", "",    "Descri" + CHR(231) + CHR(227) + "o")
2389:                     loc_oBusca.Show()
2390:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGru")
2391:                         SELECT cursor_4c_BuscaGru
2392:                         IF PEMSTATUS(loc_oPg, "txt_4c__grupo", 5)
2393:                             loc_oPg.txt_4c__grupo.Value = ALLTRIM(cursor_4c_BuscaGru.CGrus)
2394:                         ENDIF
2395:                         IF PEMSTATUS(loc_oPg, "txt_4c__grupo_desc", 5)
2396:                             loc_oPg.txt_4c__grupo_desc.Value = ALLTRIM(cursor_4c_BuscaGru.DGrus)
2397:                             loc_oPg.txt_4c__grupo_desc.Enabled = .T.
2398:                         ENDIF
2399:                     ENDIF
2400:                     ENDIF
2401:                 ENDIF
2402:                 loc_oBusca.Release()
2403:             ENDIF

*-- Linhas 2452 a 2471:
2452:                         ENDIF
2453:                     ELSE
2454:                         IF !loc_oBusca.this_lAchouRegistro
2455:                         loc_oBusca.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
2456:                         loc_oBusca.mAddColuna("CGrus", "XXX", "C" + CHR(243) + "digo")
2457:                         loc_oBusca.Show()
2458:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGruD")
2459:                             SELECT cursor_4c_BuscaGruD
2460:                             IF PEMSTATUS(loc_oPg, "txt_4c__grupo", 5)
2461:                                 loc_oPg.txt_4c__grupo.Value = ALLTRIM(cursor_4c_BuscaGruD.CGrus)
2462:                             ENDIF
2463:                             IF PEMSTATUS(loc_oPg, "txt_4c__grupo_desc", 5)
2464:                                 loc_oPg.txt_4c__grupo_desc.Value = ALLTRIM(cursor_4c_BuscaGruD.DGrus)
2465:                             ENDIF
2466:                         ENDIF
2467:                         ENDIF
2468:                     ENDIF
2469:                     loc_oBusca.Release()
2470:                 ENDIF
2471:                 IF USED("cursor_4c_BuscaGruD")

*-- Linhas 2557 a 2578:
2557:                     ENDIF
2558:                 ELSE
2559:                     IF !loc_oBusca.this_lAchouRegistro
2560:                     loc_oBusca.mAddColuna("Codigos",    "XXXXXXXXXX", "Sub-Grupo")
2561:                     loc_oBusca.mAddColuna("Descricaos", "XXXXXXXXXXXXXXXXXXXX", ;
2562:                         "Descri" + CHR(231) + CHR(227) + "o")
2563:                     loc_oBusca.mAddColuna("CGrus", "XXXXXXXXXX", "Grupo")
2564:                     loc_oBusca.Show()
2565:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSGru")
2566:                         SELECT cursor_4c_BuscaSGru
2567:                         IF PEMSTATUS(loc_oPg, "txt_4c__cd_sgrupo", 5)
2568:                             loc_oPg.txt_4c__cd_sgrupo.Value = ;
2569:                                 ALLTRIM(cursor_4c_BuscaSGru.Codigos)
2570:                         ENDIF
2571:                         IF PEMSTATUS(loc_oPg, "txt_4c__ds_sgrupo", 5)
2572:                             loc_oPg.txt_4c__ds_sgrupo.Value = ;
2573:                                 ALLTRIM(cursor_4c_BuscaSGru.Descricaos)
2574:                             loc_oPg.txt_4c__ds_sgrupo.Enabled = .T.
2575:                         ENDIF
2576:                     ENDIF
2577:                     ENDIF
2578:                 ENDIF

*-- Linhas 2631 a 2652:
2631:                         ENDIF
2632:                     ELSE
2633:                         IF !loc_oBusca.this_lAchouRegistro
2634:                         loc_oBusca.mAddColuna("Descricaos", "XXXXXXXXXXXXXXXXXXXX", ;
2635:                             "Descri" + CHR(231) + CHR(227) + "o")
2636:                         loc_oBusca.mAddColuna("Codigos",    "XXXXXXXXXX", "Sub-Grupo")
2637:                         loc_oBusca.mAddColuna("CGrus",      "XXXXXXXXXX", "Grupo")
2638:                         loc_oBusca.Show()
2639:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSGruD")
2640:                             SELECT cursor_4c_BuscaSGruD
2641:                             IF PEMSTATUS(loc_oPg, "txt_4c__cd_sgrupo", 5)
2642:                                 loc_oPg.txt_4c__cd_sgrupo.Value = ;
2643:                                     ALLTRIM(cursor_4c_BuscaSGruD.Codigos)
2644:                             ENDIF
2645:                             IF PEMSTATUS(loc_oPg, "txt_4c__ds_sgrupo", 5)
2646:                                 loc_oPg.txt_4c__ds_sgrupo.Value = ;
2647:                                     ALLTRIM(cursor_4c_BuscaSGruD.Descricaos)
2648:                             ENDIF
2649:                         ENDIF
2650:                         ENDIF
2651:                     ENDIF
2652:                     loc_oBusca.Release()

