# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (2)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 859: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 2045: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREDES.prg) - TRECHOS RELEVANTES PARA PASS GRID (2110 linhas total):

*-- Linhas 19 a 37:
19: *     - opt_4c_Tipo   : 1=Detalhado, 2=Resumido
20: *     - chk_4c_Desc   : somente com desconto
21: *     - chk_4c_Lanc   : somente lancamentos
22: *     - grd_4c_Forma  : formas de pagamento (cursor_4c_OpFp)
23: *     - cmd_4c_Marcar / cmd_4c_Desmarcar
24: *==============================================================================
25: 
26: DEFINE CLASS FormSIGREDES AS FormBase
27: 
28:     *-- Dimensoes exatas do original (Width=555, Height=499)
29:     Height      = 499
30:     Width       = 555
31:     DataSession = 2
32:     ShowWindow  = 1
33:     WindowType  = 1
34:     AutoCenter  = .T.
35:     BorderStyle = 2
36:     ControlBox  = .F.
37:     MaxButton   = .F.

*-- Linhas 304 a 322:
304:     *--------------------------------------------------------------------------
305:     * ConfigurarPaginaLista - Wrapper de compatibilidade do pipeline de migracao
306:     *   FormSIGREDES eh REPORT (frmrelatorio): Page1 contem os FILTROS do
307:     *   relatorio (datas, codigos, opcoes) e a grade grd_4c_Forma de formas
308:     *   de pagamento. Todo o layout e configurado em ConfigurarFiltros().
309:     *   Esta procedure existe para satisfazer a fase 4 do pipeline (que assume
310:     *   forms CRUD com Page1=Lista) sem duplicar codigo.
311:     *--------------------------------------------------------------------------
312:     PROTECTED PROCEDURE ConfigurarPaginaLista()
313:         THIS.ConfigurarFiltros()
314:     ENDPROC
315: 
316:     *--------------------------------------------------------------------------
317:     * ConfigurarPaginaDados - RELATORIO: sem Page2 de dados CRUD.
318:     *   FormSIGREDES tem layout FLAT (PageCount=1). Todos os campos de filtro
319:     *   (Empresa, Periodo, Grupo, Conta, Categoria, Colecao, Produto, Tipo,
320:     *   Checkboxes, Grid de Formas de Pagamento) foram adicionados em
321:     *   ConfigurarFiltros() chamado de ConfigurarPaginaLista(). Este metodo
322:     *   garante visibilidade da unica page e existe para compatibilidade com

*-- Linhas 835 a 900:
835:             .Visible   = .T.
836:         ENDWITH
837: 
838:         *-- Grid de Formas de Pagamento (RecordSource = cursor_4c_OpFp)
839:         loc_oPg.AddObject("grd_4c_Forma", "Grid")
840:         WITH loc_oPg.grd_4c_Forma
841:             .Top           = 221
842:             .Left          = 122
843:             .Width         = 228
844:             .Height        = 181
845:             .ColumnCount   = 2
846:             .FontName      = "Tahoma"
847:             .AllowRowSizing = .F.
848:             .DeleteMark    = .F.
849:             .GridLines     = 3
850:             .GridLineColor = RGB(238, 238, 238)
851:             .HeaderHeight  = 18
852:             .RowHeight     = 18
853:             .ScrollBars    = 2
854:             .RecordMark    = .F.
855:             .Themes        = .F.
856: 
857:             *-- RecordSource ANTES dos ControlSources das colunas
858:             IF USED("cursor_4c_OpFp")
859:                 .RecordSource = "cursor_4c_OpFp"
860:             ENDIF
861: 
862:             .Visible       = .T.
863: 
864:             WITH .Column1
865:                 .Width           = 15
866:                 .Alignment       = 0
867:                 .Sparse          = .F.
868:                 .ReadOnly        = .F.
869:                 .Header1.Caption = ""
870:                 .AddObject("chk_4c_Marca", "CheckBox")
871:                 WITH .chk_4c_Marca
872:                     .Alignment = 0
873:                     .Caption   = ""
874:                     .Height    = 17
875:                     .Visible   = .T.
876:                 ENDWITH
877:                 .CurrentControl = "chk_4c_Marca"
878:                 .ControlSource  = "cursor_4c_OpFp.nMarca"
879:             ENDWITH
880: 
881:             WITH .Column2
882:                 .Width         = 210
883:                 .ControlSource = "cursor_4c_OpFp.fpags"
884:                 .ReadOnly      = .T.
885:                 .Header1.Caption = "Forma"
886:                 .AddObject("txt_4c_FpNome", "TextBox")
887:                 WITH .txt_4c_FpNome
888:                     .BorderStyle = 0
889:                     .Margin      = 0
890:                     .ReadOnly    = .T.
891:                     .ForeColor   = RGB(0, 0, 0)
892:                     .BackColor   = RGB(255, 255, 255)
893:                     .Visible     = .T.
894:                 ENDWITH
895:                 .CurrentControl = "txt_4c_FpNome"
896:             ENDWITH
897:         ENDWITH
898: 
899:         *-- === BOTOES MARCAR / DESMARCAR (Top_orig=348/392) ===
900: 

*-- Linhas 1171 a 1208:
1171:                     REPLACE nMarca WITH 1
1172:                 ENDSCAN
1173:                 GO TOP
1174:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Forma.Refresh()
1175:             ENDIF
1176:         CATCH TO loc_oErro
1177:             MsgErro(loc_oErro.Message, "Erro")
1178:         ENDTRY
1179:     ENDPROC
1180: 
1181:     *--------------------------------------------------------------------------
1182:     * DesmarcarClick - Desmarca todas as formas de pagamento no grid
1183:     *--------------------------------------------------------------------------
1184:     PROCEDURE DesmarcarClick()
1185:         TRY
1186:             IF USED("cursor_4c_OpFp")
1187:                 SELECT cursor_4c_OpFp
1188:                 GO TOP
1189:                 SCAN
1190:                     REPLACE nMarca WITH 0
1191:                 ENDSCAN
1192:                 GO TOP
1193:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Forma.Refresh()
1194:             ENDIF
1195:         CATCH TO loc_oErro
1196:             MsgErro(loc_oErro.Message, "Erro")
1197:         ENDTRY
1198:     ENDPROC
1199: 
1200:     *==========================================================================
1201:     * HANDLERS DE TECLADO (PUBLIC - contrato BINDEVENT)
1202:     * F4=115, ENTER=13, TAB=9, ESC=27
1203:     *==========================================================================
1204: 
1205:     PROCEDURE TeclaEmpresa(par_nKeyCode, par_nShiftAltCtrl)
1206:         IF par_nKeyCode = 115
1207:             THIS.AbrirBuscaEmpresa()
1208:         ENDIF

*-- Linhas 1539 a 1558:
1539:                 loc_oPg.txt_4c_DesEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
1540:             ELSE
1541:                 IF !loc_oBusca.this_lAchouRegistro
1542:                     loc_oBusca.mAddColuna("cEmps", "XXX", "C" + CHR(243) + "digo")
1543:                     loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
1544:                     loc_oBusca.Show()
1545:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
1546:                         loc_oPg.txt_4c_Empresa.Value    = ALLTRIM(cursor_4c_BuscaEmp.cEmps)
1547:                         loc_oPg.txt_4c_DesEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
1548:                     ELSE
1549:                         loc_oPg.txt_4c_Empresa.Value    = ""
1550:                         loc_oPg.txt_4c_DesEmpresa.Value = ""
1551:                     ENDIF
1552:                 ENDIF
1553:             ENDIF
1554:             loc_oBusca.Release()
1555:         ENDIF
1556:         IF USED("cursor_4c_BuscaEmp")
1557:             USE IN cursor_4c_BuscaEmp
1558:         ENDIF

*-- Linhas 1575 a 1594:
1575:                 loc_oPg.txt_4c_DesEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
1576:             ELSE
1577:                 IF !loc_oBusca.this_lAchouRegistro
1578:                     loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
1579:                     loc_oBusca.mAddColuna("cEmps", "XXX", "C" + CHR(243) + "digo")
1580:                     loc_oBusca.Show()
1581:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
1582:                         loc_oPg.txt_4c_Empresa.Value    = ALLTRIM(cursor_4c_BuscaEmp.cEmps)
1583:                         loc_oPg.txt_4c_DesEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
1584:                     ELSE
1585:                         loc_oPg.txt_4c_Empresa.Value    = ""
1586:                         loc_oPg.txt_4c_DesEmpresa.Value = ""
1587:                     ENDIF
1588:                 ENDIF
1589:             ENDIF
1590:             loc_oBusca.Release()
1591:         ENDIF
1592:         IF USED("cursor_4c_BuscaEmp")
1593:             USE IN cursor_4c_BuscaEmp
1594:         ENDIF

*-- Linhas 1611 a 1630:
1611:                 loc_oPg.txt_4c_DGru.Value = ALLTRIM(cursor_4c_BuscaGru.descrs)
1612:             ELSE
1613:                 IF !loc_oBusca.this_lAchouRegistro
1614:                     loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1615:                     loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1616:                     loc_oBusca.Show()
1617:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGru")
1618:                         loc_oPg.txt_4c_CGru.Value = ALLTRIM(cursor_4c_BuscaGru.codigos)
1619:                         loc_oPg.txt_4c_DGru.Value = ALLTRIM(cursor_4c_BuscaGru.descrs)
1620:                     ELSE
1621:                         loc_oPg.txt_4c_CGru.Value = ""
1622:                         loc_oPg.txt_4c_DGru.Value = ""
1623:                     ENDIF
1624:                 ENDIF
1625:             ENDIF
1626:             loc_oBusca.Release()
1627:         ENDIF
1628:         IF USED("cursor_4c_BuscaGru")
1629:             USE IN cursor_4c_BuscaGru
1630:         ENDIF

*-- Linhas 1647 a 1666:
1647:                 loc_oPg.txt_4c_DGru.Value = ALLTRIM(cursor_4c_BuscaGru.descrs)
1648:             ELSE
1649:                 IF !loc_oBusca.this_lAchouRegistro
1650:                     loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1651:                     loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1652:                     loc_oBusca.Show()
1653:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGru")
1654:                         loc_oPg.txt_4c_CGru.Value = ALLTRIM(cursor_4c_BuscaGru.codigos)
1655:                         loc_oPg.txt_4c_DGru.Value = ALLTRIM(cursor_4c_BuscaGru.descrs)
1656:                     ELSE
1657:                         loc_oPg.txt_4c_CGru.Value = ""
1658:                         loc_oPg.txt_4c_DGru.Value = ""
1659:                     ENDIF
1660:                 ENDIF
1661:             ENDIF
1662:             loc_oBusca.Release()
1663:         ENDIF
1664:         IF USED("cursor_4c_BuscaGru")
1665:             USE IN cursor_4c_BuscaGru
1666:         ENDIF

*-- Linhas 1683 a 1702:
1683:                 loc_oPg.txt_4c_DVend.Value = ALLTRIM(cursor_4c_BuscaVend.RClis)
1684:             ELSE
1685:                 IF !loc_oBusca.this_lAchouRegistro
1686:                     loc_oBusca.mAddColuna("IClis", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1687:                     loc_oBusca.mAddColuna("RClis", "", "Nome")
1688:                     loc_oBusca.Show()
1689:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaVend")
1690:                         loc_oPg.txt_4c_Vend.Value  = ALLTRIM(cursor_4c_BuscaVend.IClis)
1691:                         loc_oPg.txt_4c_DVend.Value = ALLTRIM(cursor_4c_BuscaVend.RClis)
1692:                     ELSE
1693:                         loc_oPg.txt_4c_Vend.Value  = ""
1694:                         loc_oPg.txt_4c_DVend.Value = ""
1695:                     ENDIF
1696:                 ENDIF
1697:             ENDIF
1698:             loc_oBusca.Release()
1699:         ENDIF
1700:         IF USED("cursor_4c_BuscaVend")
1701:             USE IN cursor_4c_BuscaVend
1702:         ENDIF

*-- Linhas 1719 a 1738:
1719:                 loc_oPg.txt_4c_DVend.Value = ALLTRIM(cursor_4c_BuscaVend.RClis)
1720:             ELSE
1721:                 IF !loc_oBusca.this_lAchouRegistro
1722:                     loc_oBusca.mAddColuna("RClis", "", "Nome")
1723:                     loc_oBusca.mAddColuna("IClis", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1724:                     loc_oBusca.Show()
1725:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaVend")
1726:                         loc_oPg.txt_4c_Vend.Value  = ALLTRIM(cursor_4c_BuscaVend.IClis)
1727:                         loc_oPg.txt_4c_DVend.Value = ALLTRIM(cursor_4c_BuscaVend.RClis)
1728:                     ELSE
1729:                         loc_oPg.txt_4c_Vend.Value  = ""
1730:                         loc_oPg.txt_4c_DVend.Value = ""
1731:                     ENDIF
1732:                 ENDIF
1733:             ENDIF
1734:             loc_oBusca.Release()
1735:         ENDIF
1736:         IF USED("cursor_4c_BuscaVend")
1737:             USE IN cursor_4c_BuscaVend
1738:         ENDIF

*-- Linhas 1755 a 1774:
1755:                 loc_oPg.txt_4c_CateD.Value = ALLTRIM(cursor_4c_BuscaCate.descrs)
1756:             ELSE
1757:                 IF !loc_oBusca.this_lAchouRegistro
1758:                     loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1759:                     loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1760:                     loc_oBusca.Show()
1761:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCate")
1762:                         loc_oPg.txt_4c_Cate.Value  = ALLTRIM(cursor_4c_BuscaCate.codigos)
1763:                         loc_oPg.txt_4c_CateD.Value = ALLTRIM(cursor_4c_BuscaCate.descrs)
1764:                     ELSE
1765:                         loc_oPg.txt_4c_Cate.Value  = ""
1766:                         loc_oPg.txt_4c_CateD.Value = ""
1767:                     ENDIF
1768:                 ENDIF
1769:             ENDIF
1770:             loc_oBusca.Release()
1771:         ENDIF
1772:         IF USED("cursor_4c_BuscaCate")
1773:             USE IN cursor_4c_BuscaCate
1774:         ENDIF

*-- Linhas 1791 a 1810:
1791:                 loc_oPg.txt_4c_CateD.Value = ALLTRIM(cursor_4c_BuscaCate.descrs)
1792:             ELSE
1793:                 IF !loc_oBusca.this_lAchouRegistro
1794:                     loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1795:                     loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1796:                     loc_oBusca.Show()
1797:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCate")
1798:                         loc_oPg.txt_4c_Cate.Value  = ALLTRIM(cursor_4c_BuscaCate.codigos)
1799:                         loc_oPg.txt_4c_CateD.Value = ALLTRIM(cursor_4c_BuscaCate.descrs)
1800:                     ELSE
1801:                         loc_oPg.txt_4c_Cate.Value  = ""
1802:                         loc_oPg.txt_4c_CateD.Value = ""
1803:                     ENDIF
1804:                 ENDIF
1805:             ENDIF
1806:             loc_oBusca.Release()
1807:         ENDIF
1808:         IF USED("cursor_4c_BuscaCate")
1809:             USE IN cursor_4c_BuscaCate
1810:         ENDIF

*-- Linhas 1827 a 1846:
1827:                 loc_oPg.txt_4c_ColeD.Value = ALLTRIM(cursor_4c_BuscaCole.descricaos)
1828:             ELSE
1829:                 IF !loc_oBusca.this_lAchouRegistro
1830:                     loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1831:                     loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
1832:                     loc_oBusca.Show()
1833:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCole")
1834:                         loc_oPg.txt_4c_Cole.Value  = ALLTRIM(cursor_4c_BuscaCole.codigos)
1835:                         loc_oPg.txt_4c_ColeD.Value = ALLTRIM(cursor_4c_BuscaCole.descricaos)
1836:                     ELSE
1837:                         loc_oPg.txt_4c_Cole.Value  = ""
1838:                         loc_oPg.txt_4c_ColeD.Value = ""
1839:                     ENDIF
1840:                 ENDIF
1841:             ENDIF
1842:             loc_oBusca.Release()
1843:         ENDIF
1844:         IF USED("cursor_4c_BuscaCole")
1845:             USE IN cursor_4c_BuscaCole
1846:         ENDIF

*-- Linhas 1863 a 1882:
1863:                 loc_oPg.txt_4c_ColeD.Value = ALLTRIM(cursor_4c_BuscaCole.descricaos)
1864:             ELSE
1865:                 IF !loc_oBusca.this_lAchouRegistro
1866:                     loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
1867:                     loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1868:                     loc_oBusca.Show()
1869:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCole")
1870:                         loc_oPg.txt_4c_Cole.Value  = ALLTRIM(cursor_4c_BuscaCole.codigos)
1871:                         loc_oPg.txt_4c_ColeD.Value = ALLTRIM(cursor_4c_BuscaCole.descricaos)
1872:                     ELSE
1873:                         loc_oPg.txt_4c_Cole.Value  = ""
1874:                         loc_oPg.txt_4c_ColeD.Value = ""
1875:                     ENDIF
1876:                 ENDIF
1877:             ENDIF
1878:             loc_oBusca.Release()
1879:         ENDIF
1880:         IF USED("cursor_4c_BuscaCole")
1881:             USE IN cursor_4c_BuscaCole
1882:         ENDIF

*-- Linhas 1899 a 1918:
1899:                 loc_oPg.txt_4c_ProdD.Value = ALLTRIM(cursor_4c_BuscaProd.DPros)
1900:             ELSE
1901:                 IF !loc_oBusca.this_lAchouRegistro
1902:                     loc_oBusca.mAddColuna("CPros", "XXXXXXXXXXXXXX", "C" + CHR(243) + "digo")
1903:                     loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
1904:                     loc_oBusca.Show()
1905:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
1906:                         loc_oPg.txt_4c_Prod.Value  = ALLTRIM(cursor_4c_BuscaProd.CPros)
1907:                         loc_oPg.txt_4c_ProdD.Value = ALLTRIM(cursor_4c_BuscaProd.DPros)
1908:                     ELSE
1909:                         loc_oPg.txt_4c_Prod.Value  = ""
1910:                         loc_oPg.txt_4c_ProdD.Value = ""
1911:                     ENDIF
1912:                 ENDIF
1913:             ENDIF
1914:             loc_oBusca.Release()
1915:         ENDIF
1916:         IF USED("cursor_4c_BuscaProd")
1917:             USE IN cursor_4c_BuscaProd
1918:         ENDIF

*-- Linhas 1935 a 1954:
1935:                 loc_oPg.txt_4c_ProdD.Value = ALLTRIM(cursor_4c_BuscaProd.DPros)
1936:             ELSE
1937:                 IF !loc_oBusca.this_lAchouRegistro
1938:                     loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
1939:                     loc_oBusca.mAddColuna("CPros", "XXXXXXXXXXXXXX", "C" + CHR(243) + "digo")
1940:                     loc_oBusca.Show()
1941:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
1942:                         loc_oPg.txt_4c_Prod.Value  = ALLTRIM(cursor_4c_BuscaProd.CPros)
1943:                         loc_oPg.txt_4c_ProdD.Value = ALLTRIM(cursor_4c_BuscaProd.DPros)
1944:                     ELSE
1945:                         loc_oPg.txt_4c_Prod.Value  = ""
1946:                         loc_oPg.txt_4c_ProdD.Value = ""
1947:                     ENDIF
1948:                 ENDIF
1949:             ENDIF
1950:             loc_oBusca.Release()
1951:         ENDIF
1952:         IF USED("cursor_4c_BuscaProd")
1953:             USE IN cursor_4c_BuscaProd
1954:         ENDIF

*-- Linhas 2031 a 2061:
2031:         ENDTRY
2032:     ENDPROC
2033: 
2034:     *--------------------------------------------------------------------------
2035:     * CarregarLista - Em FormSIGREDES (REPORT), recarrega o cursor de formas
2036:     *   de pagamento no grid quando necessario.
2037:     *--------------------------------------------------------------------------
2038:     PROCEDURE CarregarLista()
2039:         LOCAL loc_lSucesso
2040:         loc_lSucesso = .F.
2041:         TRY
2042:             IF VARTYPE(THIS.this_oRelatorio) = "O"
2043:                 IF USED("cursor_4c_OpFp")
2044:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Forma.ColumnCount = 3
2045:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Forma.RecordSource = "cursor_4c_OpFp"
2046:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Forma.Refresh()
2047:                 ENDIF
2048:             ENDIF
2049:             loc_lSucesso = .T.
2050:         CATCH TO loc_oErro
2051:             MsgErro(loc_oErro.Message, "Erro")
2052:         ENDTRY
2053:         RETURN loc_lSucesso
2054:     ENDPROC
2055: 
2056:     *--------------------------------------------------------------------------
2057:     * AjustarBotoesPorModo - Em FormSIGREDES (REPORT), os botoes de relatorio
2058:     *   (Visualizar/Imprimir/Excel/Encerrar) ficam sempre habilitados.
2059:     *--------------------------------------------------------------------------
2060:     PROTECTED PROCEDURE AjustarBotoesPorModo()
2061:         TRY

