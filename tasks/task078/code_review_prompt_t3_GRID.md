# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 895: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREDES.prg) - TRECHOS RELEVANTES PARA PASS GRID (2111 linhas total):

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

*-- Linhas 835 a 911:
835:             .Visible   = .T.
836:         ENDWITH
837: 
838:         *-- Grid de Formas de Pagamento (RecordSource = cursor_4c_OpFp)
839:         loc_oPg.AddObject("grd_4c_Forma", "Grid")
840:         loc_oPg.grd_4c_Forma.ColumnCount = 2
841:         WITH loc_oPg.grd_4c_Forma
842:             .Top           = 221
843:             .Left          = 122
844:             .Width         = 228
845:             .Height        = 181
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
857:             .Visible       = .T.
858: 
859:             WITH .Column1
860:                 .Width           = 15
861:                 .Alignment       = 0
862:                 .Sparse          = .F.
863:                 .ReadOnly        = .F.
864:                 .Header1.Caption = ""
865:                 .AddObject("chk_4c_Marca", "CheckBox")
866:                 WITH .chk_4c_Marca
867:                     .Alignment = 0
868:                     .Caption   = ""
869:                     .Height    = 17
870:                     .Visible   = .T.
871:                 ENDWITH
872:                 .CurrentControl = "chk_4c_Marca"
873:                 .ControlSource  = "cursor_4c_OpFp.nMarca"
874:             ENDWITH
875: 
876:             WITH .Column2
877:                 .Width         = 210
878:                 .ControlSource = "cursor_4c_OpFp.fpags"
879:                 .ReadOnly      = .T.
880:                 .Header1.Caption = "Descrs"
881:                 .AddObject("txt_4c_FpNome", "TextBox")
882:                 WITH .txt_4c_FpNome
883:                     .BorderStyle = 0
884:                     .Margin      = 0
885:                     .ReadOnly    = .T.
886:                     .ForeColor   = RGB(0, 0, 0)
887:                     .BackColor   = RGB(255, 255, 255)
888:                     .Visible     = .T.
889:                 ENDWITH
890:                 .CurrentControl = "txt_4c_FpNome"
891:             ENDWITH
892:         ENDWITH
893:         IF USED("cursor_4c_OpFp")
894:             loc_oPg.grd_4c_Forma.ColumnCount = 3
895:             loc_oPg.grd_4c_Forma.RecordSource = "cursor_4c_OpFp"
896:         ENDIF
897: 
898:         *-- === BOTOES MARCAR / DESMARCAR (Top_orig=348/392) ===
899: 
900:         *-- Botao Marcar/Selecionar (Command2 do legado - geral_marcar_26.jpg)
901:         loc_oPg.AddObject("cmd_4c_Marcar", "CommandButton")
902:         WITH loc_oPg.cmd_4c_Marcar
903:             .Top          = 263
904:             .Left         = 355
905:             .Height       = 45
906:             .Width        = 45
907:             .Caption      = ""
908:             .ToolTipText  = "Selecionar"
909:             .Picture      = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
910:             .FontName     = "Verdana"
911:             .FontSize     = 8

*-- Linhas 1170 a 1207:
1170:                     REPLACE nMarca WITH 1
1171:                 ENDSCAN
1172:                 GO TOP
1173:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Forma.Refresh()
1174:             ENDIF
1175:         CATCH TO loc_oErro
1176:             MsgErro(loc_oErro.Message, "Erro")
1177:         ENDTRY
1178:     ENDPROC
1179: 
1180:     *--------------------------------------------------------------------------
1181:     * DesmarcarClick - Desmarca todas as formas de pagamento no grid
1182:     *--------------------------------------------------------------------------
1183:     PROCEDURE DesmarcarClick()
1184:         TRY
1185:             IF USED("cursor_4c_OpFp")
1186:                 SELECT cursor_4c_OpFp
1187:                 GO TOP
1188:                 SCAN
1189:                     REPLACE nMarca WITH 0
1190:                 ENDSCAN
1191:                 GO TOP
1192:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Forma.Refresh()
1193:             ENDIF
1194:         CATCH TO loc_oErro
1195:             MsgErro(loc_oErro.Message, "Erro")
1196:         ENDTRY
1197:     ENDPROC
1198: 
1199:     *==========================================================================
1200:     * HANDLERS DE TECLADO (PUBLIC - contrato BINDEVENT)
1201:     * F4=115, ENTER=13, TAB=9, ESC=27
1202:     *==========================================================================
1203: 
1204:     PROCEDURE TeclaEmpresa(par_nKeyCode, par_nShiftAltCtrl)
1205:         IF par_nKeyCode = 115
1206:             THIS.AbrirBuscaEmpresa()
1207:         ENDIF

*-- Linhas 1538 a 1557:
1538:                 loc_oPg.txt_4c_DesEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
1539:             ELSE
1540:                 IF !loc_oBusca.this_lAchouRegistro
1541:                     loc_oBusca.mAddColuna("cEmps", "XXX", "C" + CHR(243) + "digo")
1542:                     loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
1543:                     loc_oBusca.Show()
1544:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
1545:                         loc_oPg.txt_4c_Empresa.Value    = ALLTRIM(cursor_4c_BuscaEmp.cEmps)
1546:                         loc_oPg.txt_4c_DesEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
1547:                     ELSE
1548:                         loc_oPg.txt_4c_Empresa.Value    = ""
1549:                         loc_oPg.txt_4c_DesEmpresa.Value = ""
1550:                     ENDIF
1551:                 ENDIF
1552:             ENDIF
1553:             loc_oBusca.Release()
1554:         ENDIF
1555:         IF USED("cursor_4c_BuscaEmp")
1556:             USE IN cursor_4c_BuscaEmp
1557:         ENDIF

*-- Linhas 1574 a 1593:
1574:                 loc_oPg.txt_4c_DesEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
1575:             ELSE
1576:                 IF !loc_oBusca.this_lAchouRegistro
1577:                     loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
1578:                     loc_oBusca.mAddColuna("cEmps", "XXX", "C" + CHR(243) + "digo")
1579:                     loc_oBusca.Show()
1580:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
1581:                         loc_oPg.txt_4c_Empresa.Value    = ALLTRIM(cursor_4c_BuscaEmp.cEmps)
1582:                         loc_oPg.txt_4c_DesEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
1583:                     ELSE
1584:                         loc_oPg.txt_4c_Empresa.Value    = ""
1585:                         loc_oPg.txt_4c_DesEmpresa.Value = ""
1586:                     ENDIF
1587:                 ENDIF
1588:             ENDIF
1589:             loc_oBusca.Release()
1590:         ENDIF
1591:         IF USED("cursor_4c_BuscaEmp")
1592:             USE IN cursor_4c_BuscaEmp
1593:         ENDIF

*-- Linhas 1610 a 1629:
1610:                 loc_oPg.txt_4c_DGru.Value = ALLTRIM(cursor_4c_BuscaGru.descrs)
1611:             ELSE
1612:                 IF !loc_oBusca.this_lAchouRegistro
1613:                     loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1614:                     loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1615:                     loc_oBusca.Show()
1616:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGru")
1617:                         loc_oPg.txt_4c_CGru.Value = ALLTRIM(cursor_4c_BuscaGru.codigos)
1618:                         loc_oPg.txt_4c_DGru.Value = ALLTRIM(cursor_4c_BuscaGru.descrs)
1619:                     ELSE
1620:                         loc_oPg.txt_4c_CGru.Value = ""
1621:                         loc_oPg.txt_4c_DGru.Value = ""
1622:                     ENDIF
1623:                 ENDIF
1624:             ENDIF
1625:             loc_oBusca.Release()
1626:         ENDIF
1627:         IF USED("cursor_4c_BuscaGru")
1628:             USE IN cursor_4c_BuscaGru
1629:         ENDIF

*-- Linhas 1646 a 1665:
1646:                 loc_oPg.txt_4c_DGru.Value = ALLTRIM(cursor_4c_BuscaGru.descrs)
1647:             ELSE
1648:                 IF !loc_oBusca.this_lAchouRegistro
1649:                     loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1650:                     loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1651:                     loc_oBusca.Show()
1652:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGru")
1653:                         loc_oPg.txt_4c_CGru.Value = ALLTRIM(cursor_4c_BuscaGru.codigos)
1654:                         loc_oPg.txt_4c_DGru.Value = ALLTRIM(cursor_4c_BuscaGru.descrs)
1655:                     ELSE
1656:                         loc_oPg.txt_4c_CGru.Value = ""
1657:                         loc_oPg.txt_4c_DGru.Value = ""
1658:                     ENDIF
1659:                 ENDIF
1660:             ENDIF
1661:             loc_oBusca.Release()
1662:         ENDIF
1663:         IF USED("cursor_4c_BuscaGru")
1664:             USE IN cursor_4c_BuscaGru
1665:         ENDIF

*-- Linhas 1682 a 1701:
1682:                 loc_oPg.txt_4c_DVend.Value = ALLTRIM(cursor_4c_BuscaVend.RClis)
1683:             ELSE
1684:                 IF !loc_oBusca.this_lAchouRegistro
1685:                     loc_oBusca.mAddColuna("IClis", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1686:                     loc_oBusca.mAddColuna("RClis", "", "Nome")
1687:                     loc_oBusca.Show()
1688:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaVend")
1689:                         loc_oPg.txt_4c_Vend.Value  = ALLTRIM(cursor_4c_BuscaVend.IClis)
1690:                         loc_oPg.txt_4c_DVend.Value = ALLTRIM(cursor_4c_BuscaVend.RClis)
1691:                     ELSE
1692:                         loc_oPg.txt_4c_Vend.Value  = ""
1693:                         loc_oPg.txt_4c_DVend.Value = ""
1694:                     ENDIF
1695:                 ENDIF
1696:             ENDIF
1697:             loc_oBusca.Release()
1698:         ENDIF
1699:         IF USED("cursor_4c_BuscaVend")
1700:             USE IN cursor_4c_BuscaVend
1701:         ENDIF

*-- Linhas 1718 a 1737:
1718:                 loc_oPg.txt_4c_DVend.Value = ALLTRIM(cursor_4c_BuscaVend.RClis)
1719:             ELSE
1720:                 IF !loc_oBusca.this_lAchouRegistro
1721:                     loc_oBusca.mAddColuna("RClis", "", "Nome")
1722:                     loc_oBusca.mAddColuna("IClis", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1723:                     loc_oBusca.Show()
1724:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaVend")
1725:                         loc_oPg.txt_4c_Vend.Value  = ALLTRIM(cursor_4c_BuscaVend.IClis)
1726:                         loc_oPg.txt_4c_DVend.Value = ALLTRIM(cursor_4c_BuscaVend.RClis)
1727:                     ELSE
1728:                         loc_oPg.txt_4c_Vend.Value  = ""
1729:                         loc_oPg.txt_4c_DVend.Value = ""
1730:                     ENDIF
1731:                 ENDIF
1732:             ENDIF
1733:             loc_oBusca.Release()
1734:         ENDIF
1735:         IF USED("cursor_4c_BuscaVend")
1736:             USE IN cursor_4c_BuscaVend
1737:         ENDIF

*-- Linhas 1754 a 1773:
1754:                 loc_oPg.txt_4c_CateD.Value = ALLTRIM(cursor_4c_BuscaCate.descrs)
1755:             ELSE
1756:                 IF !loc_oBusca.this_lAchouRegistro
1757:                     loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1758:                     loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1759:                     loc_oBusca.Show()
1760:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCate")
1761:                         loc_oPg.txt_4c_Cate.Value  = ALLTRIM(cursor_4c_BuscaCate.codigos)
1762:                         loc_oPg.txt_4c_CateD.Value = ALLTRIM(cursor_4c_BuscaCate.descrs)
1763:                     ELSE
1764:                         loc_oPg.txt_4c_Cate.Value  = ""
1765:                         loc_oPg.txt_4c_CateD.Value = ""
1766:                     ENDIF
1767:                 ENDIF
1768:             ENDIF
1769:             loc_oBusca.Release()
1770:         ENDIF
1771:         IF USED("cursor_4c_BuscaCate")
1772:             USE IN cursor_4c_BuscaCate
1773:         ENDIF

*-- Linhas 1790 a 1809:
1790:                 loc_oPg.txt_4c_CateD.Value = ALLTRIM(cursor_4c_BuscaCate.descrs)
1791:             ELSE
1792:                 IF !loc_oBusca.this_lAchouRegistro
1793:                     loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1794:                     loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1795:                     loc_oBusca.Show()
1796:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCate")
1797:                         loc_oPg.txt_4c_Cate.Value  = ALLTRIM(cursor_4c_BuscaCate.codigos)
1798:                         loc_oPg.txt_4c_CateD.Value = ALLTRIM(cursor_4c_BuscaCate.descrs)
1799:                     ELSE
1800:                         loc_oPg.txt_4c_Cate.Value  = ""
1801:                         loc_oPg.txt_4c_CateD.Value = ""
1802:                     ENDIF
1803:                 ENDIF
1804:             ENDIF
1805:             loc_oBusca.Release()
1806:         ENDIF
1807:         IF USED("cursor_4c_BuscaCate")
1808:             USE IN cursor_4c_BuscaCate
1809:         ENDIF

*-- Linhas 1826 a 1845:
1826:                 loc_oPg.txt_4c_ColeD.Value = ALLTRIM(cursor_4c_BuscaCole.descricaos)
1827:             ELSE
1828:                 IF !loc_oBusca.this_lAchouRegistro
1829:                     loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1830:                     loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
1831:                     loc_oBusca.Show()
1832:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCole")
1833:                         loc_oPg.txt_4c_Cole.Value  = ALLTRIM(cursor_4c_BuscaCole.codigos)
1834:                         loc_oPg.txt_4c_ColeD.Value = ALLTRIM(cursor_4c_BuscaCole.descricaos)
1835:                     ELSE
1836:                         loc_oPg.txt_4c_Cole.Value  = ""
1837:                         loc_oPg.txt_4c_ColeD.Value = ""
1838:                     ENDIF
1839:                 ENDIF
1840:             ENDIF
1841:             loc_oBusca.Release()
1842:         ENDIF
1843:         IF USED("cursor_4c_BuscaCole")
1844:             USE IN cursor_4c_BuscaCole
1845:         ENDIF

*-- Linhas 1862 a 1881:
1862:                 loc_oPg.txt_4c_ColeD.Value = ALLTRIM(cursor_4c_BuscaCole.descricaos)
1863:             ELSE
1864:                 IF !loc_oBusca.this_lAchouRegistro
1865:                     loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
1866:                     loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1867:                     loc_oBusca.Show()
1868:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCole")
1869:                         loc_oPg.txt_4c_Cole.Value  = ALLTRIM(cursor_4c_BuscaCole.codigos)
1870:                         loc_oPg.txt_4c_ColeD.Value = ALLTRIM(cursor_4c_BuscaCole.descricaos)
1871:                     ELSE
1872:                         loc_oPg.txt_4c_Cole.Value  = ""
1873:                         loc_oPg.txt_4c_ColeD.Value = ""
1874:                     ENDIF
1875:                 ENDIF
1876:             ENDIF
1877:             loc_oBusca.Release()
1878:         ENDIF
1879:         IF USED("cursor_4c_BuscaCole")
1880:             USE IN cursor_4c_BuscaCole
1881:         ENDIF

*-- Linhas 1898 a 1917:
1898:                 loc_oPg.txt_4c_ProdD.Value = ALLTRIM(cursor_4c_BuscaProd.DPros)
1899:             ELSE
1900:                 IF !loc_oBusca.this_lAchouRegistro
1901:                     loc_oBusca.mAddColuna("CPros", "XXXXXXXXXXXXXX", "C" + CHR(243) + "digo")
1902:                     loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
1903:                     loc_oBusca.Show()
1904:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
1905:                         loc_oPg.txt_4c_Prod.Value  = ALLTRIM(cursor_4c_BuscaProd.CPros)
1906:                         loc_oPg.txt_4c_ProdD.Value = ALLTRIM(cursor_4c_BuscaProd.DPros)
1907:                     ELSE
1908:                         loc_oPg.txt_4c_Prod.Value  = ""
1909:                         loc_oPg.txt_4c_ProdD.Value = ""
1910:                     ENDIF
1911:                 ENDIF
1912:             ENDIF
1913:             loc_oBusca.Release()
1914:         ENDIF
1915:         IF USED("cursor_4c_BuscaProd")
1916:             USE IN cursor_4c_BuscaProd
1917:         ENDIF

*-- Linhas 1934 a 1953:
1934:                 loc_oPg.txt_4c_ProdD.Value = ALLTRIM(cursor_4c_BuscaProd.DPros)
1935:             ELSE
1936:                 IF !loc_oBusca.this_lAchouRegistro
1937:                     loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
1938:                     loc_oBusca.mAddColuna("CPros", "XXXXXXXXXXXXXX", "C" + CHR(243) + "digo")
1939:                     loc_oBusca.Show()
1940:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
1941:                         loc_oPg.txt_4c_Prod.Value  = ALLTRIM(cursor_4c_BuscaProd.CPros)
1942:                         loc_oPg.txt_4c_ProdD.Value = ALLTRIM(cursor_4c_BuscaProd.DPros)
1943:                     ELSE
1944:                         loc_oPg.txt_4c_Prod.Value  = ""
1945:                         loc_oPg.txt_4c_ProdD.Value = ""
1946:                     ENDIF
1947:                 ENDIF
1948:             ENDIF
1949:             loc_oBusca.Release()
1950:         ENDIF
1951:         IF USED("cursor_4c_BuscaProd")
1952:             USE IN cursor_4c_BuscaProd
1953:         ENDIF

*-- Linhas 2040 a 2062:
2040:         TRY
2041:             IF VARTYPE(THIS.this_oRelatorio) = "O"
2042:                 IF USED("cursor_4c_OpFp")
2043:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Forma.ColumnCount = 2
2044:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Forma.RecordSource = "cursor_4c_OpFp"
2045:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Forma.Column1.ControlSource = "cursor_4c_OpFp.nMarca"
2046:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Forma.Column2.ControlSource = "cursor_4c_OpFp.fpags"
2047:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Forma.Refresh()
2048:                 ENDIF
2049:             ENDIF
2050:             loc_lSucesso = .T.
2051:         CATCH TO loc_oErro
2052:             MsgErro(loc_oErro.Message, "Erro")
2053:         ENDTRY
2054:         RETURN loc_lSucesso
2055:     ENDPROC
2056: 
2057:     *--------------------------------------------------------------------------
2058:     * AjustarBotoesPorModo - Em FormSIGREDES (REPORT), os botoes de relatorio
2059:     *   (Visualizar/Imprimir/Excel/Encerrar) ficam sempre habilitados.
2060:     *--------------------------------------------------------------------------
2061:     PROTECTED PROCEDURE AjustarBotoesPorModo()
2062:         TRY

