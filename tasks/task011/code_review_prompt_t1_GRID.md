# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (4)
- [MADDCOLUNA] Chamada mAddColuna com parametro numerico '120'. Assinatura correta: mAddColuna(campo, mascara, titulo) - TODOS strings. Largura NAO eh parametro.
- [MADDCOLUNA] Chamada mAddColuna com parametro numerico '120'. Assinatura correta: mAddColuna(campo, mascara, titulo) - TODOS strings. Largura NAO eh parametro.
- [MADDCOLUNA] Chamada mAddColuna com parametro numerico '80'. Assinatura correta: mAddColuna(campo, mascara, titulo) - TODOS strings. Largura NAO eh parametro.
- [MADDCOLUNA] Chamada mAddColuna com parametro numerico '60'. Assinatura correta: mAddColuna(campo, mascara, titulo) - TODOS strings. Largura NAO eh parametro.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS GRID (11392 linhas total):

*-- Linhas 456 a 541:
456: 
457:         *-- Grade principal (Grade: Left=38, Top=173+29=202, W=922, H=409, 7 colunas)
458:         *-- IMPORTANTE: RecordMark=.F., DeleteMark=.F.
459:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
460:         loc_oGrade = loc_oPagina.grd_4c_Dados
461:         WITH loc_oGrade
462:             .Top           = 202
463:             .Left          = 38
464:             .Width         = 922
465:             .Height        = 409
466:             .FontName      = "Arial"
467:             .FontSize      = 8
468:             .RecordMark    = .F.
469:             .DeleteMark    = .F.
470:             .GridLines     = 3
471:             .ReadOnly      = .T.
472:             .Themes        = .F.
473:             .ColumnCount   = 7
474:             .Visible       = .T.
475:         ENDWITH
476: 
477:         *-- Configurar colunas APOS ColumnCount (cabecalhos serao re-aplicados pos RecordSource)
478:         WITH loc_oGrade.Column1
479:             .Width     = 110
480:             .Movable   = .F.
481:             .Resizable = .F.
482:             .ReadOnly  = .T.
483:         ENDWITH
484:         WITH loc_oGrade.Column2
485:             .Width     = 408
486:             .Movable   = .F.
487:             .Resizable = .F.
488:             .ReadOnly  = .T.
489:         ENDWITH
490:         WITH loc_oGrade.Column3
491:             .Width     = 40
492:             .Movable   = .F.
493:             .Resizable = .F.
494:             .ReadOnly  = .T.
495:         ENDWITH
496:         WITH loc_oGrade.Column4
497:             .Width     = 70
498:             .Movable   = .F.
499:             .Resizable = .F.
500:             .ReadOnly  = .T.
501:         ENDWITH
502:         WITH loc_oGrade.Column5
503:             .Width     = 150
504:             .Movable   = .F.
505:             .Resizable = .F.
506:             .ReadOnly  = .T.
507:         ENDWITH
508:         WITH loc_oGrade.Column6
509:             .Width     = 100
510:             .Movable   = .F.
511:             .Resizable = .F.
512:             .ReadOnly  = .T.
513:         ENDWITH
514:         WITH loc_oGrade.Column7
515:             .Width     = 16
516:             .Alignment = 3
517:             .Movable   = .F.
518:             .Resizable = .F.
519:             .Sparse    = .F.
520:             .ReadOnly  = .T.
521:             *-- Configurar checkbox AQUI (antes de RecordSource): AddObject, Caption, CurrentControl
522:             .AddObject("Check1", "CheckBox")
523:             .Check1.Caption = ""
524:             .CurrentControl = "Check1"
525:         ENDWITH
526: 
527:         *-- Label contagem de produtos (lblProdutos: Top=584, compensado 584+29=613, Left=38)
528:         loc_oPagina.AddObject("lbl_4c_Produtos", "Label")
529:         WITH loc_oPagina.lbl_4c_Produtos
530:             .Caption   = "Produtos Selecionados : 0"
531:             .Top       = 613
532:             .Left      = 38
533:             .Width     = 160
534:             .Height    = 15
535:             .FontName  = "Tahoma"
536:             .FontSize  = 8
537:             .FontBold  = .T.
538:             .BackStyle = 0
539:             .ForeColor = RGB(90, 90, 90)
540:             .Visible   = .T.
541:         ENDWITH

*-- Linhas 1863 a 2290:
1863: 
1864:     *--------------------------------------------------------------------------
1865:     * ConfigurarPgpgComposicao - Aba "Composicao" (Page2 de pgf_4c_Dados)
1866:     * Contem: grd_4c_Compo (14 cols), grd_4c_SubCp (15 cols), grd_4c_TotGrupo (3 cols)
1867:     *         cntMtPrima + ~30 textboxes + labels + checkboxes + commandgroups
1868:     * Posicoes = valores ORIGINAIS do layout.json (Tabs=.F. -> sem deslocamento)
1869:     * par_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
1870:     *--------------------------------------------------------------------------
1871:     PROTECTED PROCEDURE ConfigurarPgpgComposicao(par_oPage)
1872:         LOCAL loc_oPg, loc_oGrd, loc_oGrd2, loc_oGrd3, loc_oCnt
1873: 
1874:         loc_oPg = par_oPage
1875: 
1876:         *-- ===================================================================
1877:         *-- CURSORS PLACEHOLDER (criar ANTES dos grids)
1878:         *-- ===================================================================
1879: 
1880:         *-- cursor_4c_Compo - composicao do produto (SIGPRCPO)
1881:         IF USED("cursor_4c_Compo")
1882:             USE IN cursor_4c_Compo
1883:         ENDIF
1884:         SET NULL OFF
1885:         CREATE CURSOR cursor_4c_Compo ( ;
1886:             mats      C(14), dcompos C(40), unicompos C(3),  ;
1887:             pcompos   N(11,3), qtds N(8,3), totas N(11,3),   ;
1888:             moeds     C(3),  obscompos C(10), etiqs C(1),    ;
1889:             qtscons   N(8,3), qtdcvs N(11,3), cunips C(3),   ;
1890:             ordems    N(2,0), tipos C(20))
1891: 
1892:         *-- cursor_4c_SubCp - sub-composicao (sigsubcp)
1893:         IF USED("cursor_4c_SubCp")
1894:             USE IN cursor_4c_SubCp
1895:         ENDIF
1896:         CREATE CURSOR cursor_4c_SubCp ( ;
1897:             mats      C(14), dcompos C(40), unicompos C(3),  ;
1898:             pcompos   N(11,3), qtds N(8,3), totas N(11,3),   ;
1899:             moeds     C(3),  obscompos C(10), etiqs C(1),    ;
1900:             qtscons   N(8,3), qtdcvs N(11,3), cunips C(3),   ;
1901:             ordems    N(2,0), matsubs C(14), codtams C(4))
1902: 
1903:         *-- cursor_4c_TotGrupo - totais por grupo (calculado)
1904:         IF USED("cursor_4c_TotGrupo")
1905:             USE IN cursor_4c_TotGrupo
1906:         ENDIF
1907:         CREATE CURSOR cursor_4c_TotGrupo ( ;
1908:             Grupo     C(3), ValGrupo N(11,3), Moeda C(3))
1909: 
1910:         *-- ===================================================================
1911:         *-- GRID grd_4c_Compo - Composicao principal (grdCompo: top=148, left=6, w=943, h=147)
1912:         *-- 14 colunas de SIGPRCPO
1913:         *-- ===================================================================
1914:         loc_oPg.AddObject("grd_4c_Compo", "Grid")
1915:         loc_oGrd = loc_oPg.grd_4c_Compo
1916:         WITH loc_oGrd
1917:             .Top         = 148
1918:             .Left        = 6
1919:             .Width       = 943
1920:             .Height      = 147
1921:             .FontName    = "Tahoma"
1922:             .FontSize    = 8
1923:             .RecordMark  = .F.
1924:             .DeleteMark  = .F.
1925:             .GridLines   = 3
1926:             .ReadOnly    = .F.
1927:             .RowHeight   = 16
1928:             .ScrollBars  = 2
1929:             .Themes      = .F.
1930:             .ColumnCount = 14
1931:             .Visible     = .T.
1932:         ENDWITH
1933: 
1934:         *-- Coluna 1: Material (mats, w=108)
1935:         WITH loc_oGrd.Column1
1936:             .Width     = 108
1937:             .Movable   = .F.
1938:             .Resizable = .F.
1939:             .InputMask = "XXXXXXXXXXXXXX"
1940:         ENDWITH
1941:         *-- Coluna 2: Descricao (dcompos, w=187)
1942:         WITH loc_oGrd.Column2
1943:             .Width     = 187
1944:             .Movable   = .F.
1945:             .Resizable = .F.
1946:         ENDWITH
1947:         *-- Coluna 3: Un (unicompos, w=24)
1948:         WITH loc_oGrd.Column3
1949:             .Width     = 24
1950:             .Movable   = .F.
1951:             .Resizable = .F.
1952:         ENDWITH
1953:         *-- Coluna 4: Valor (pcompos, w=73)
1954:         WITH loc_oGrd.Column4
1955:             .Width     = 73
1956:             .Movable   = .F.
1957:             .Resizable = .F.
1958:             .InputMask = "9999999.999"
1959:         ENDWITH
1960:         *-- Coluna 5: Qtde. (qtds, w=59)
1961:         WITH loc_oGrd.Column5
1962:             .Width     = 59
1963:             .Movable   = .F.
1964:             .Resizable = .F.
1965:             .InputMask = "9999.999"
1966:         ENDWITH
1967:         *-- Coluna 6: Total (totas, w=58)
1968:         WITH loc_oGrd.Column6
1969:             .Width     = 58
1970:             .InputMask = "9999999.999"
1971:         ENDWITH
1972:         *-- Coluna 7: Moe (moeds, w=31)
1973:         WITH loc_oGrd.Column7
1974:             .Width = 31
1975:         ENDWITH
1976:         *-- Coluna 8: Observacao (obscompos, w=80)
1977:         WITH loc_oGrd.Column8
1978:             .Width = 80
1979:         ENDWITH
1980:         *-- Coluna 9: E (etiqs, w=14)
1981:         WITH loc_oGrd.Column9
1982:             .Width     = 14
1983:             .Format    = "M"
1984:             .InputMask = "N,S"
1985:         ENDWITH
1986:         *-- Coluna 10: Consumo (qtscons, w=58)
1987:         WITH loc_oGrd.Column10
1988:             .Width     = 58
1989:             .InputMask = "99999"
1990:         ENDWITH
1991:         *-- Coluna 11: Qtde. (qtdcvs, w=59)
1992:         WITH loc_oGrd.Column11
1993:             .Width     = 59
1994:             .Movable   = .F.
1995:             .Resizable = .F.
1996:         ENDWITH
1997:         *-- Coluna 12: Un (cunips, w=24, ReadOnly)
1998:         WITH loc_oGrd.Column12
1999:             .Width     = 24
2000:             .Movable   = .F.
2001:             .Resizable = .F.
2002:             .ReadOnly  = .T.
2003:         ENDWITH
2004:         *-- Coluna 13: Ord (ordems, w=24)
2005:         WITH loc_oGrd.Column13
2006:             .Width = 24
2007:         ENDWITH
2008:         *-- Coluna 14: Tipo (tipos, w=108)
2009:         WITH loc_oGrd.Column14
2010:             .Width = 108
2011:         ENDWITH
2012: 
2013:         *-- RecordSource APOS ColumnCount (NUNCA dentro de WITH)
2014:         loc_oGrd.RecordSource = "cursor_4c_Compo"
2015: 
2016:         *-- ControlSource APOS RecordSource (obrigatorio)
2017:         loc_oGrd.Column1.ControlSource  = "cursor_4c_Compo.mats"
2018:         loc_oGrd.Column2.ControlSource  = "cursor_4c_Compo.dcompos"
2019:         loc_oGrd.Column3.ControlSource  = "cursor_4c_Compo.unicompos"
2020:         loc_oGrd.Column4.ControlSource  = "cursor_4c_Compo.pcompos"
2021:         loc_oGrd.Column5.ControlSource  = "cursor_4c_Compo.qtds"
2022:         loc_oGrd.Column6.ControlSource  = "cursor_4c_Compo.totas"
2023:         loc_oGrd.Column7.ControlSource  = "cursor_4c_Compo.moeds"
2024:         loc_oGrd.Column8.ControlSource  = "cursor_4c_Compo.obscompos"
2025:         loc_oGrd.Column9.ControlSource  = "cursor_4c_Compo.etiqs"
2026:         loc_oGrd.Column10.ControlSource = "cursor_4c_Compo.qtscons"
2027:         loc_oGrd.Column11.ControlSource = "cursor_4c_Compo.qtdcvs"
2028:         loc_oGrd.Column12.ControlSource = "cursor_4c_Compo.cunips"
2029:         loc_oGrd.Column13.ControlSource = "cursor_4c_Compo.ordems"
2030:         loc_oGrd.Column14.ControlSource = "cursor_4c_Compo.tipos"
2031: 
2032:         *-- Cabecalhos APOS RecordSource
2033:         loc_oGrd.Column1.Header1.Caption  = "Material"
2034:         loc_oGrd.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
2035:         loc_oGrd.Column3.Header1.Caption  = "Un"
2036:         loc_oGrd.Column4.Header1.Caption  = "Valor"
2037:         loc_oGrd.Column5.Header1.Caption  = "Qtde."
2038:         loc_oGrd.Column6.Header1.Caption  = "Total"
2039:         loc_oGrd.Column7.Header1.Caption  = "Moe"
2040:         loc_oGrd.Column8.Header1.Caption  = "Observa" + CHR(231) + CHR(227) + "o"
2041:         loc_oGrd.Column9.Header1.Caption  = "E"
2042:         loc_oGrd.Column10.Header1.Caption = "Consumo"
2043:         loc_oGrd.Column11.Header1.Caption = "Qtde."
2044:         loc_oGrd.Column12.Header1.Caption = "Un"
2045:         loc_oGrd.Column13.Header1.Caption = "Ord"
2046:         loc_oGrd.Column14.Header1.Caption = "Material"
2047: 
2048:         *-- Larguras re-aplicadas APOS RecordSource (RecordSource pode resetar)
2049:         loc_oGrd.Column1.Width  = 108
2050:         loc_oGrd.Column2.Width  = 187
2051:         loc_oGrd.Column3.Width  = 24
2052:         loc_oGrd.Column4.Width  = 73
2053:         loc_oGrd.Column5.Width  = 59
2054:         loc_oGrd.Column6.Width  = 58
2055:         loc_oGrd.Column7.Width  = 31
2056:         loc_oGrd.Column8.Width  = 80
2057:         loc_oGrd.Column9.Width  = 14
2058:         loc_oGrd.Column10.Width = 58
2059:         loc_oGrd.Column11.Width = 59
2060:         loc_oGrd.Column12.Width = 24
2061:         loc_oGrd.Column13.Width = 24
2062:         loc_oGrd.Column14.Width = 108
2063: 
2064:         *-- BINDEVENT grd_4c_Compo
2065:         BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GrdCompoAfterRowColChange")
2066: 
2067:         *-- ===================================================================
2068:         *-- GRID grd_4c_SubCp - Sub-composicao (grdsubcp: top=348, left=6, w=943, h=83)
2069:         *-- 15 colunas de sigsubcp
2070:         *-- ===================================================================
2071:         loc_oPg.AddObject("grd_4c_SubCp", "Grid")
2072:         loc_oGrd2 = loc_oPg.grd_4c_SubCp
2073:         WITH loc_oGrd2
2074:             .Top         = 348
2075:             .Left        = 6
2076:             .Width       = 943
2077:             .Height      = 83
2078:             .FontName    = "Tahoma"
2079:             .FontSize    = 8
2080:             .RecordMark  = .F.
2081:             .DeleteMark  = .F.
2082:             .GridLines   = 3
2083:             .ReadOnly    = .F.
2084:             .RowHeight   = 16
2085:             .ScrollBars  = 2
2086:             .Themes      = .F.
2087:             .ColumnCount = 15
2088:             .Visible     = .T.
2089:         ENDWITH
2090: 
2091:         *-- Colunas grd_4c_SubCp
2092:         WITH loc_oGrd2.Column1
2093:             .Width = 108
2094:             .Movable = .F.
2095:             .Resizable = .F.
2096:         ENDWITH
2097:         WITH loc_oGrd2.Column2
2098:             .Width = 149
2099:             .Movable = .F.
2100:             .Resizable = .F.
2101:         ENDWITH
2102:         WITH loc_oGrd2.Column3
2103:             .Width = 24
2104:             .Movable = .F.
2105:             .Resizable = .F.
2106:         ENDWITH
2107:         WITH loc_oGrd2.Column4
2108:             .Width     = 73
2109:             .Movable   = .F.
2110:             .Resizable = .F.
2111:             .InputMask = "9999999.999"
2112:         ENDWITH
2113:         WITH loc_oGrd2.Column5
2114:             .Width     = 59
2115:             .Movable   = .F.
2116:             .Resizable = .F.
2117:             .InputMask = "9999.999"
2118:         ENDWITH
2119:         WITH loc_oGrd2.Column6
2120:             .Width     = 58
2121:             .InputMask = "9999999.999"
2122:         ENDWITH
2123:         WITH loc_oGrd2.Column7
2124:             .Width = 31
2125:         ENDWITH
2126:         WITH loc_oGrd2.Column8
2127:             .Width = 80
2128:         ENDWITH
2129:         WITH loc_oGrd2.Column9
2130:             .Width     = 14
2131:             .Format    = "M"
2132:             .InputMask = "N,S"
2133:         ENDWITH
2134:         WITH loc_oGrd2.Column10
2135:             .Width     = 58
2136:             .InputMask = "99999"
2137:         ENDWITH
2138:         WITH loc_oGrd2.Column11
2139:             .Width     = 59
2140:             .Movable   = .F.
2141:             .Resizable = .F.
2142:         ENDWITH
2143:         WITH loc_oGrd2.Column12
2144:             .Width     = 24
2145:             .Movable   = .F.
2146:             .Resizable = .F.
2147:             .ReadOnly  = .T.
2148:         ENDWITH
2149:         WITH loc_oGrd2.Column13
2150:             .Width     = 24
2151:             .Format    = "K"
2152:             .InputMask = "99"
2153:         ENDWITH
2154:         WITH loc_oGrd2.Column14
2155:             .Width = 108
2156:         ENDWITH
2157:         WITH loc_oGrd2.Column15
2158:             .Width = 38
2159:         ENDWITH
2160: 
2161:         *-- RecordSource APOS ColumnCount
2162:         loc_oGrd2.RecordSource = "cursor_4c_SubCp"
2163: 
2164:         *-- ControlSource APOS RecordSource
2165:         loc_oGrd2.Column1.ControlSource  = "cursor_4c_SubCp.mats"
2166:         loc_oGrd2.Column2.ControlSource  = "cursor_4c_SubCp.dcompos"
2167:         loc_oGrd2.Column3.ControlSource  = "cursor_4c_SubCp.unicompos"
2168:         loc_oGrd2.Column4.ControlSource  = "cursor_4c_SubCp.pcompos"
2169:         loc_oGrd2.Column5.ControlSource  = "cursor_4c_SubCp.qtds"
2170:         loc_oGrd2.Column6.ControlSource  = "cursor_4c_SubCp.totas"
2171:         loc_oGrd2.Column7.ControlSource  = "cursor_4c_SubCp.moeds"
2172:         loc_oGrd2.Column8.ControlSource  = "cursor_4c_SubCp.obscompos"
2173:         loc_oGrd2.Column9.ControlSource  = "cursor_4c_SubCp.etiqs"
2174:         loc_oGrd2.Column10.ControlSource = "cursor_4c_SubCp.qtscons"
2175:         loc_oGrd2.Column11.ControlSource = "cursor_4c_SubCp.qtdcvs"
2176:         loc_oGrd2.Column12.ControlSource = "cursor_4c_SubCp.cunips"
2177:         loc_oGrd2.Column13.ControlSource = "cursor_4c_SubCp.ordems"
2178:         loc_oGrd2.Column14.ControlSource = "cursor_4c_SubCp.matsubs"
2179:         loc_oGrd2.Column15.ControlSource = "cursor_4c_SubCp.codtams"
2180: 
2181:         *-- Cabecalhos grd_4c_SubCp APOS RecordSource
2182:         loc_oGrd2.Column1.Header1.Caption  = "Material"
2183:         loc_oGrd2.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
2184:         loc_oGrd2.Column3.Header1.Caption  = "Un"
2185:         loc_oGrd2.Column4.Header1.Caption  = "Valor"
2186:         loc_oGrd2.Column5.Header1.Caption  = "Qtde."
2187:         loc_oGrd2.Column6.Header1.Caption  = "Total"
2188:         loc_oGrd2.Column7.Header1.Caption  = "Moe"
2189:         loc_oGrd2.Column8.Header1.Caption  = "Observa" + CHR(231) + CHR(227) + "o"
2190:         loc_oGrd2.Column9.Header1.Caption  = "E"
2191:         loc_oGrd2.Column10.Header1.Caption = "Consumo"
2192:         loc_oGrd2.Column11.Header1.Caption = "Qtde."
2193:         loc_oGrd2.Column12.Header1.Caption = "Un"
2194:         loc_oGrd2.Column13.Header1.Caption = "Ord"
2195:         loc_oGrd2.Column14.Header1.Caption = "Material"
2196:         loc_oGrd2.Column15.Header1.Caption = "Tam"
2197: 
2198:         *-- Larguras re-aplicadas
2199:         loc_oGrd2.Column1.Width  = 108
2200:         loc_oGrd2.Column2.Width  = 149
2201:         loc_oGrd2.Column3.Width  = 24
2202:         loc_oGrd2.Column4.Width  = 73
2203:         loc_oGrd2.Column5.Width  = 59
2204:         loc_oGrd2.Column6.Width  = 58
2205:         loc_oGrd2.Column7.Width  = 31
2206:         loc_oGrd2.Column8.Width  = 80
2207:         loc_oGrd2.Column9.Width  = 14
2208:         loc_oGrd2.Column10.Width = 58
2209:         loc_oGrd2.Column11.Width = 59
2210:         loc_oGrd2.Column12.Width = 24
2211:         loc_oGrd2.Column13.Width = 24
2212:         loc_oGrd2.Column14.Width = 108
2213:         loc_oGrd2.Column15.Width = 38
2214: 
2215:         *-- BINDEVENT grd_4c_SubCp
2216:         BINDEVENT(loc_oGrd2, "AfterRowColChange", THIS, "GrdSubCpAfterRowColChange")
2217: 
2218:         *-- ===================================================================
2219:         *-- GRID grd_4c_TotGrupo - Totais por grupo (GradeGRUPO: top=34, left=582, w=229, h=107)
2220:         *-- 3 colunas, ReadOnly
2221:         *-- ===================================================================
2222:         loc_oPg.AddObject("grd_4c_TotGrupo", "Grid")
2223:         loc_oGrd3 = loc_oPg.grd_4c_TotGrupo
2224:         WITH loc_oGrd3
2225:             .Top         = 34
2226:             .Left        = 582
2227:             .Width       = 229
2228:             .Height      = 107
2229:             .FontName    = "Courier New"
2230:             .FontSize    = 8
2231:             .RecordMark  = .F.
2232:             .DeleteMark  = .F.
2233:             .GridLines   = 3
2234:             .ReadOnly    = .T.
2235:             .RowHeight   = 17
2236:             .Themes      = .F.
2237:             .ColumnCount = 3
2238:             .Visible     = .T.
2239:         ENDWITH
2240: 
2241:         WITH loc_oGrd3.Column1
2242:             .Width     = 35
2243:             .Movable   = .F.
2244:             .Resizable = .F.
2245:             .ReadOnly  = .T.
2246:         ENDWITH
2247:         WITH loc_oGrd3.Column2
2248:             .Width     = 134
2249:             .Movable   = .F.
2250:             .Resizable = .F.
2251:             .ReadOnly  = .T.
2252:             .InputMask = "999,999,999.999"
2253:         ENDWITH
2254:         WITH loc_oGrd3.Column3
2255:             .Width     = 37
2256:             .Movable   = .F.
2257:             .Resizable = .F.
2258:             .ReadOnly  = .T.
2259:         ENDWITH
2260: 
2261:         loc_oGrd3.RecordSource = "cursor_4c_TotGrupo"
2262:         loc_oGrd3.Column1.ControlSource = "cursor_4c_TotGrupo.Grupo"
2263:         loc_oGrd3.Column2.ControlSource = "cursor_4c_TotGrupo.ValGrupo"
2264:         loc_oGrd3.Column3.ControlSource = "cursor_4c_TotGrupo.Moeda"
2265:         loc_oGrd3.Column1.Header1.Caption = "Grupo"
2266:         loc_oGrd3.Column2.Header1.Caption = "Total "
2267:         loc_oGrd3.Column3.Header1.Caption = "Moeda"
2268:         loc_oGrd3.Column1.Width = 35
2269:         loc_oGrd3.Column2.Width = 134
2270:         loc_oGrd3.Column3.Width = 37
2271: 
2272:         *-- ===================================================================
2273:         *-- CONTAINER cntMtPrima (top=511, left=752, w=242, h=108)
2274:         *-- Controles de montagem de descricao automatica
2275:         *-- ===================================================================
2276:         loc_oPg.AddObject("cnt_4c_MtPrima", "Container")
2277:         loc_oCnt = loc_oPg.cnt_4c_MtPrima
2278:         WITH loc_oCnt
2279:             .Top         = 511
2280:             .Left        = 752
2281:             .Width       = 242
2282:             .Height      = 108
2283:             .BackStyle   = 0
2284:             .BorderWidth = 0
2285:             .Visible     = .T.
2286:         ENDWITH
2287: 
2288:         *-- Label lblCompos: "Composicao :" (top=1, left=6, w=66, h=15)
2289:         loc_oCnt.AddObject("lbl_4c_LblCompos", "Label")
2290:         WITH loc_oCnt.lbl_4c_LblCompos

*-- Linhas 3589 a 3613:
3589:         IF USED("cursor_4c_Cmv")
3590:             USE IN cursor_4c_Cmv
3591:         ENDIF
3592:         SET NULL OFF
3593:         CREATE CURSOR cursor_4c_Cmv ( ;
3594:             datas    C(7), ;
3595:             valcuss  N(10,2), ;
3596:             moedas   C(3))
3597: 
3598:         *-- ===================================================================
3599:         *-- LABELS
3600:         *-- ===================================================================
3601: 
3602:         *-- Say16: Grupo C.C.
3603:         loc_oPg.AddObject("lbl_4c_Say16", "Label")
3604:         WITH loc_oPg.lbl_4c_Say16
3605:             .Caption  = "Grupo C.C. :"
3606:             .Top      = 165
3607:             .Left     = 138
3608:             .Width    = 63
3609:             .Height   = 15
3610:             .FontName = "Tahoma"
3611:             .FontSize = 8
3612:             .AutoSize = .F.
3613:             .Visible  = .T.

*-- Linhas 4205 a 4281:
4205:         *-- T:338, L:754, W:223, H:141, 3 colunas: Periodo / Valor Custo GR / Moe
4206:         *-- ===================================================================
4207: 
4208:         loc_oPg.AddObject("grd_4c_Dados", "Grid")
4209:         loc_oGrd = loc_oPg.grd_4c_Dados
4210:         WITH loc_oGrd
4211:             .Top         = 338
4212:             .Left        = 754
4213:             .Width       = 223
4214:             .Height      = 141
4215:             .FontName    = "Tahoma"
4216:             .FontSize    = 8
4217:             .RecordMark  = .F.
4218:             .DeleteMark  = .F.
4219:             .GridLines   = 3
4220:             .ReadOnly    = .T.
4221:             .RowHeight   = 16
4222:             .ScrollBars  = 2
4223:             .Themes      = .F.
4224:             .ColumnCount = 3
4225:             .Visible     = .T.
4226:         ENDWITH
4227: 
4228:         *-- Cabecalhos ANTES do RecordSource
4229:         loc_oGrd.Column1.Header1.Caption = "Per" + CHR(237) + "odo"
4230:         loc_oGrd.Column2.Header1.Caption = "Valor Custo GR"
4231:         loc_oGrd.Column3.Header1.Caption = "Moe"
4232: 
4233:         *-- Larguras das colunas
4234:         WITH loc_oGrd.Column1
4235:             .Width     = 60
4236:             .Movable   = .F.
4237:             .Resizable = .F.
4238:         ENDWITH
4239:         WITH loc_oGrd.Column2
4240:             .Width     = 120
4241:             .Movable   = .F.
4242:             .Resizable = .F.
4243:         ENDWITH
4244:         WITH loc_oGrd.Column3
4245:             .Width     = 40
4246:             .Movable   = .F.
4247:             .Resizable = .F.
4248:         ENDWITH
4249: 
4250:         *-- RecordSource APOS ColumnCount (NUNCA dentro de WITH)
4251:         loc_oGrd.RecordSource = "cursor_4c_Cmv"
4252: 
4253:         *-- ControlSource APOS RecordSource (obrigatorio)
4254:         loc_oGrd.Column1.ControlSource = "cursor_4c_Cmv.datas"
4255:         loc_oGrd.Column2.ControlSource = "cursor_4c_Cmv.valcuss"
4256:         loc_oGrd.Column3.ControlSource = "cursor_4c_Cmv.moedas"
4257: 
4258:         *-- Reaplica larguras apos RecordSource (RecordSource pode resetar)
4259:         loc_oGrd.Column1.Width = 60
4260:         loc_oGrd.Column2.Width = 120
4261:         loc_oGrd.Column3.Width = 40
4262: 
4263:         *-- ===================================================================
4264:         *-- TEXTBOXES - Descricao ECF, Metal/Teor, Valor Estimado, IPPT/CST
4265:         *-- ===================================================================
4266: 
4267:         *-- getDescEcfs (txt_4c_DescEcfs): T:429, L:206, W:213, H:23
4268:         loc_oPg.AddObject("txt_4c_DescEcfs", "TextBox")
4269:         WITH loc_oPg.txt_4c_DescEcfs
4270:             .Value    = ""
4271:             .Top      = 429
4272:             .Left     = 206
4273:             .Width    = 213
4274:             .Height   = 23
4275:             .FontName = "Tahoma"
4276:             .FontSize = 8
4277:             .Visible  = .T.
4278:         ENDWITH
4279: 
4280:         *-- Get_metal (txt_4c_Metal): Metal codigo - T:429, L:537, W:24, H:23
4281:         loc_oPg.AddObject("txt_4c_Metal", "TextBox")

*-- Linhas 4402 a 4437:
4402:         IF USED("cursor_4c_CustoCompo")
4403:             USE IN cursor_4c_CustoCompo
4404:         ENDIF
4405:         SET NULL OFF
4406:         CREATE CURSOR cursor_4c_CustoCompo ( ;
4407:             mats      C(14), dcompos C(40), unicompos C(3),  ;
4408:             pcompos   N(11,3), qtds N(8,3), totas N(11,3),   ;
4409:             moeds     C(3), obscompos C(10), etiqs C(1),     ;
4410:             qtscons   N(8,3), qtdcvs N(11,3), cunips C(3),   ;
4411:             CGrus     C(3), tipos C(20))
4412: 
4413:         *-- cursor_4c_TotGrupoCusto - totais por grupo custo (calculado)
4414:         IF USED("cursor_4c_TotGrupoCusto")
4415:             USE IN cursor_4c_TotGrupoCusto
4416:         ENDIF
4417:         CREATE CURSOR cursor_4c_TotGrupoCusto ( ;
4418:             Grupo     C(3), ValGrupo N(11,3), Moeda C(3))
4419: 
4420:         *-- ===================================================================
4421:         *-- COMBO cbo_4c_CmbTipos (cmbTipos: top=154, left=143, w=187, h=23)
4422:         *-- ===================================================================
4423:         loc_oPg.AddObject("cbo_4c_CmbTipos", "ComboBox")
4424:         WITH loc_oPg.cbo_4c_CmbTipos
4425:             .Top           = 154
4426:             .Left          = 143
4427:             .Width         = 187
4428:             .Height        = 23
4429:             .FontName      = "Tahoma"
4430:             .FontSize      = 8
4431:             .RowSourceType = 1
4432:             .RowSource     = ""
4433:             .Style         = 2
4434:             .SpecialEffect = 1
4435:             .Themes        = .F.
4436:             .Visible       = .T.
4437:         ENDWITH

*-- Linhas 4453 a 4617:
4453:         ENDWITH
4454: 
4455:         *-- ===================================================================
4456:         *-- GRID grd_4c_CustoCompo (grdCompo: top=178, left=34, w=813, h=230)
4457:         *-- 12 colunas de SIGPRCPO
4458:         *-- ===================================================================
4459:         loc_oPg.AddObject("grd_4c_CustoCompo", "Grid")
4460:         loc_oGrd = loc_oPg.grd_4c_CustoCompo
4461:         WITH loc_oGrd
4462:             .Top         = 178
4463:             .Left        = 34
4464:             .Width       = 813
4465:             .Height      = 230
4466:             .FontName    = "Tahoma"
4467:             .FontSize    = 8
4468:             .RecordMark  = .F.
4469:             .DeleteMark  = .F.
4470:             .GridLines   = 3
4471:             .ReadOnly    = .F.
4472:             .RowHeight   = 16
4473:             .ScrollBars  = 2
4474:             .Themes      = .F.
4475:             .ColumnCount = 12
4476:             .Visible     = .T.
4477:         ENDWITH
4478: 
4479:         *-- Coluna 1: Item (mats, w=108)
4480:         WITH loc_oGrd.Column1
4481:             .Width     = 108
4482:             .Movable   = .F.
4483:             .Resizable = .F.
4484:             .InputMask = "XXXXXXXXXXXXXX"
4485:         ENDWITH
4486:         *-- Coluna 2: Descricao (dcompos, w=187)
4487:         WITH loc_oGrd.Column2
4488:             .Width     = 187
4489:             .Movable   = .F.
4490:             .Resizable = .F.
4491:         ENDWITH
4492:         *-- Coluna 3: Un (unicompos, w=24)
4493:         WITH loc_oGrd.Column3
4494:             .Width     = 24
4495:             .Movable   = .F.
4496:             .Resizable = .F.
4497:         ENDWITH
4498:         *-- Coluna 4: Valor (pcompos, w=73)
4499:         WITH loc_oGrd.Column4
4500:             .Width     = 73
4501:             .Movable   = .F.
4502:             .Resizable = .F.
4503:             .InputMask = "9999999.999"
4504:         ENDWITH
4505:         *-- Coluna 5: Qtd (qtds, w=59)
4506:         WITH loc_oGrd.Column5
4507:             .Width     = 59
4508:             .Movable   = .F.
4509:             .Resizable = .F.
4510:             .InputMask = "9999.999"
4511:         ENDWITH
4512:         *-- Coluna 6: Total (totas, w=58)
4513:         WITH loc_oGrd.Column6
4514:             .Width     = 58
4515:             .Movable   = .F.
4516:             .Resizable = .F.
4517:             .InputMask = "9999999.999"
4518:         ENDWITH
4519:         *-- Coluna 7: Moe (moeds, w=31)
4520:         WITH loc_oGrd.Column7
4521:             .Width = 31
4522:         ENDWITH
4523:         *-- Coluna 8: Observacao (obscompos, w=80)
4524:         WITH loc_oGrd.Column8
4525:             .Width = 80
4526:         ENDWITH
4527:         *-- Coluna 9: Etiq (etiqs, w=14)
4528:         WITH loc_oGrd.Column9
4529:             .Width     = 14
4530:             .Format    = "M"
4531:             .InputMask = "N,S"
4532:         ENDWITH
4533:         *-- Coluna 10: Consumo (qtscons, w=58)
4534:         WITH loc_oGrd.Column10
4535:             .Width     = 58
4536:             .InputMask = "99999"
4537:         ENDWITH
4538:         *-- Coluna 11: Qtd (qtdcvs, w=59)
4539:         WITH loc_oGrd.Column11
4540:             .Width     = 59
4541:             .Movable   = .F.
4542:             .Resizable = .F.
4543:         ENDWITH
4544:         *-- Coluna 12: Un (cunips, w=24, ReadOnly)
4545:         WITH loc_oGrd.Column12
4546:             .Width     = 24
4547:             .Movable   = .F.
4548:             .Resizable = .F.
4549:             .ReadOnly  = .T.
4550:         ENDWITH
4551: 
4552:         *-- RecordSource APOS ColumnCount (NUNCA dentro de WITH)
4553:         loc_oGrd.RecordSource = "cursor_4c_CustoCompo"
4554: 
4555:         *-- ControlSource APOS RecordSource (obrigatorio)
4556:         loc_oGrd.Column1.ControlSource  = "cursor_4c_CustoCompo.mats"
4557:         loc_oGrd.Column2.ControlSource  = "cursor_4c_CustoCompo.dcompos"
4558:         loc_oGrd.Column3.ControlSource  = "cursor_4c_CustoCompo.unicompos"
4559:         loc_oGrd.Column4.ControlSource  = "cursor_4c_CustoCompo.pcompos"
4560:         loc_oGrd.Column5.ControlSource  = "cursor_4c_CustoCompo.qtds"
4561:         loc_oGrd.Column6.ControlSource  = "cursor_4c_CustoCompo.totas"
4562:         loc_oGrd.Column7.ControlSource  = "cursor_4c_CustoCompo.moeds"
4563:         loc_oGrd.Column8.ControlSource  = "cursor_4c_CustoCompo.obscompos"
4564:         loc_oGrd.Column9.ControlSource  = "cursor_4c_CustoCompo.etiqs"
4565:         loc_oGrd.Column10.ControlSource = "cursor_4c_CustoCompo.qtscons"
4566:         loc_oGrd.Column11.ControlSource = "cursor_4c_CustoCompo.qtdcvs"
4567:         loc_oGrd.Column12.ControlSource = "cursor_4c_CustoCompo.cunips"
4568: 
4569:         *-- Cabecalhos APOS RecordSource
4570:         loc_oGrd.Column1.Header1.Caption  = "Item"
4571:         loc_oGrd.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
4572:         loc_oGrd.Column3.Header1.Caption  = "Un"
4573:         loc_oGrd.Column4.Header1.Caption  = "Valor"
4574:         loc_oGrd.Column5.Header1.Caption  = "Qtd"
4575:         loc_oGrd.Column6.Header1.Caption  = "Total"
4576:         loc_oGrd.Column7.Header1.Caption  = "Moe"
4577:         loc_oGrd.Column8.Header1.Caption  = "Observa" + CHR(231) + CHR(227) + "o"
4578:         loc_oGrd.Column9.Header1.Caption  = "Etiq"
4579:         loc_oGrd.Column10.Header1.Caption = "Consumo"
4580:         loc_oGrd.Column11.Header1.Caption = "Qtd"
4581:         loc_oGrd.Column12.Header1.Caption = "Un"
4582: 
4583:         *-- Larguras re-aplicadas APOS RecordSource (RecordSource pode resetar)
4584:         loc_oGrd.Column1.Width  = 108
4585:         loc_oGrd.Column2.Width  = 187
4586:         loc_oGrd.Column3.Width  = 24
4587:         loc_oGrd.Column4.Width  = 73
4588:         loc_oGrd.Column5.Width  = 59
4589:         loc_oGrd.Column6.Width  = 58
4590:         loc_oGrd.Column7.Width  = 31
4591:         loc_oGrd.Column8.Width  = 80
4592:         loc_oGrd.Column9.Width  = 14
4593:         loc_oGrd.Column10.Width = 58
4594:         loc_oGrd.Column11.Width = 59
4595:         loc_oGrd.Column12.Width = 24
4596: 
4597:         *-- BINDEVENT grd_4c_CustoCompo
4598:         BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GrdCustoCompoAfterRowColChange")
4599: 
4600:         *-- ===================================================================
4601:         *-- COMMANDGROUP obj_4c_CmdgCusto (cmdgCompo: top=240, left=851, w=50, h=90)
4602:         *-- 2 botoes: Inserir, Excluir
4603:         *-- ===================================================================
4604:         loc_oPg.AddObject("obj_4c_CmdgCusto", "CommandGroup")
4605:         WITH loc_oPg.obj_4c_CmdgCusto
4606:             .ButtonCount   = 2
4607:             .BorderStyle   = 0
4608:             .Top           = 240
4609:             .Left          = 851
4610:             .Width         = 50
4611:             .Height        = 90
4612:             .BackColor     = RGB(162, 214, 242)
4613:             .Themes        = .F.
4614:             .Visible       = .T.
4615:         ENDWITH
4616:         WITH loc_oPg.obj_4c_CmdgCusto
4617:             .Buttons(1).Top           = 5

*-- Linhas 4739 a 5035:
4739:         ENDWITH
4740: 
4741:         *-- ===================================================================
4742:         *-- GRID grd_4c_GruCusto (GradeGRUPO2: top=468, left=35, w=195, h=141)
4743:         *-- 3 colunas: Grupo, Total, Moeda - ReadOnly
4744:         *-- ===================================================================
4745:         loc_oPg.AddObject("grd_4c_GruCusto", "Grid")
4746:         loc_oGrd2 = loc_oPg.grd_4c_GruCusto
4747:         WITH loc_oGrd2
4748:             .Top         = 468
4749:             .Left        = 35
4750:             .Width       = 195
4751:             .Height      = 141
4752:             .FontName    = "Courier New"
4753:             .FontSize    = 8
4754:             .RecordMark  = .F.
4755:             .DeleteMark  = .F.
4756:             .GridLines   = 3
4757:             .ReadOnly    = .T.
4758:             .RowHeight   = 17
4759:             .Themes      = .F.
4760:             .ColumnCount = 3
4761:             .Visible     = .T.
4762:         ENDWITH
4763: 
4764:         WITH loc_oGrd2.Column1
4765:             .Width     = 35
4766:             .Movable   = .F.
4767:             .Resizable = .F.
4768:             .ReadOnly  = .T.
4769:         ENDWITH
4770:         WITH loc_oGrd2.Column2
4771:             .Width     = 134
4772:             .Movable   = .F.
4773:             .Resizable = .F.
4774:             .ReadOnly  = .T.
4775:             .InputMask = "999,999,999.999"
4776:         ENDWITH
4777:         WITH loc_oGrd2.Column3
4778:             .Width     = 37
4779:             .Movable   = .F.
4780:             .Resizable = .F.
4781:             .ReadOnly  = .T.
4782:         ENDWITH
4783: 
4784:         loc_oGrd2.RecordSource = "cursor_4c_TotGrupoCusto"
4785:         loc_oGrd2.Column1.ControlSource = "cursor_4c_TotGrupoCusto.Grupo"
4786:         loc_oGrd2.Column2.ControlSource = "cursor_4c_TotGrupoCusto.ValGrupo"
4787:         loc_oGrd2.Column3.ControlSource = "cursor_4c_TotGrupoCusto.Moeda"
4788:         loc_oGrd2.Column1.Header1.Caption = "Grp"
4789:         loc_oGrd2.Column2.Header1.Caption = "Total "
4790:         loc_oGrd2.Column3.Header1.Caption = "Moe"
4791:         loc_oGrd2.Column1.Width = 35
4792:         loc_oGrd2.Column2.Width = 134
4793:         loc_oGrd2.Column3.Width = 37
4794: 
4795:     ENDPROC
4796: 
4797:     *--------------------------------------------------------------------------
4798:     * ConfigurarPgPgDadosConsP - Aba "Cons. P." (Page5 de pgf_4c_DadosInternos)
4799:     * Grid grd_4c_GrdCons (9 cols) - RecordSource: crSigPrCpo
4800:     * Ordem visual: Mats | Dcompos | Qtds | UniCompos | Grupos | Dscgrp | Ordems | QtsCons | Cats
4801:     * par_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
4802:     *--------------------------------------------------------------------------
4803:     PROTECTED PROCEDURE ConfigurarPgPgDadosConsP(par_oPage)
4804:         LOCAL loc_oPg, loc_oGrd, loc_oGrd2
4805: 
4806:         loc_oPg = par_oPage
4807: 
4808:         *-- ===================================================================
4809:         *-- CURSORS PLACEHOLDER (criar ANTES dos grids)
4810:         *-- Campos na ORDEM VISUAL das colunas (sem ColumnOrder)
4811:         *-- ===================================================================
4812: 
4813:         *-- cursor_4c_GrdCons - consumo de produto (baseado em crSigPrCpo)
4814:         *-- Ordem: Mats(cod), Dcompos(desc), Qtds(qtde RO), UniCompos(uni RO),
4815:         *--        Grupos(fase), Dscgrp(desc fase), Ordems(ord RO), QtsCons(consumo), Cats(cat)
4816:         IF USED("cursor_4c_GrdCons")
4817:             USE IN cursor_4c_GrdCons
4818:         ENDIF
4819:         SET NULL OFF
4820:         CREATE CURSOR cursor_4c_GrdCons ( ;
4821:             Mats      C(14), ;
4822:             Dcompos   C(40), ;
4823:             Qtds      N(12,4), ;
4824:             UniCompos C(3), ;
4825:             Grupos    C(3), ;
4826:             Dscgrp    C(40), ;
4827:             Ordems    N(3,0), ;
4828:             QtsCons   N(12,4), ;
4829:             Cats      C(3))
4830: 
4831:         *-- cursor_4c_GrDTEMP - tempo por agrupamento (baseado em crSigProTp)
4832:         IF USED("cursor_4c_GrDTEMP")
4833:             USE IN cursor_4c_GrDTEMP
4834:         ENDIF
4835:         CREATE CURSOR cursor_4c_GrDTEMP ( ;
4836:             agrupas   C(3), ;
4837:             pertemps  N(12,3))
4838: 
4839:         *-- ===================================================================
4840:         *-- GRID grd_4c_GrdCons
4841:         *-- Original: top=155, left=6, w=987, h=362, RowHeight=17
4842:         *-- ===================================================================
4843:         loc_oPg.AddObject("grd_4c_GrdCons", "Grid")
4844:         loc_oGrd = loc_oPg.grd_4c_GrdCons
4845:         WITH loc_oGrd
4846:             .Top         = 155
4847:             .Left        = 6
4848:             .Width       = 987
4849:             .Height      = 362
4850:             .FontName    = "Tahoma"
4851:             .FontSize    = 8
4852:             .RecordMark  = .F.
4853:             .DeleteMark  = .F.
4854:             .GridLines   = 3
4855:             .ReadOnly    = .F.
4856:             .RowHeight   = 17
4857:             .ScrollBars  = 2
4858:             .Themes      = .F.
4859:             .ColumnCount = 9
4860:             .Visible     = .T.
4861:         ENDWITH
4862: 
4863:         *-- Col1: Componente/Mats (108px, ReadOnly)
4864:         WITH loc_oGrd.Column1
4865:             .Width     = 108
4866:             .Movable   = .F.
4867:             .Resizable = .F.
4868:             .ReadOnly  = .T.
4869:         ENDWITH
4870:         *-- Col2: Descricao/Dcompos (223px, ReadOnly) - visual pos 2 (orig ColumnOrder=2)
4871:         WITH loc_oGrd.Column2
4872:             .Width     = 223
4873:             .Movable   = .F.
4874:             .Resizable = .F.
4875:             .ReadOnly  = .T.
4876:         ENDWITH
4877:         *-- Col3: Qtde./Qtds (60px, ReadOnly) - visual pos 3 (orig ColumnOrder=3)
4878:         WITH loc_oGrd.Column3
4879:             .Width     = 60
4880:             .Movable   = .F.
4881:             .Resizable = .F.
4882:             .ReadOnly  = .T.
4883:         ENDWITH
4884:         *-- Col4: Uni/UniCompos (25px, ReadOnly)
4885:         WITH loc_oGrd.Column4
4886:             .Width     = 25
4887:             .Movable   = .F.
4888:             .Resizable = .F.
4889:             .ReadOnly  = .T.
4890:         ENDWITH
4891:         *-- Col5: Fase/Grupos (105px, editavel)
4892:         WITH loc_oGrd.Column5
4893:             .Width     = 105
4894:             .Movable   = .F.
4895:             .Resizable = .F.
4896:             .Sparse    = .F.
4897:         ENDWITH
4898:         *-- Col6: Descricao fase/Dscgrp (254px, editavel)
4899:         WITH loc_oGrd.Column6
4900:             .Width     = 254
4901:             .Movable   = .F.
4902:             .Resizable = .F.
4903:         ENDWITH
4904:         *-- Col7: Ord./Ordems (35px, ReadOnly)
4905:         WITH loc_oGrd.Column7
4906:             .Width     = 35
4907:             .Movable   = .F.
4908:             .Resizable = .F.
4909:             .ReadOnly  = .T.
4910:         ENDWITH
4911:         *-- Col8: Consumo/QtsCons (60px, editavel)
4912:         WITH loc_oGrd.Column8
4913:             .Width     = 60
4914:             .Movable   = .F.
4915:             .Resizable = .F.
4916:         ENDWITH
4917:         *-- Col9: Cat./Cats (52px, editavel)
4918:         WITH loc_oGrd.Column9
4919:             .Width     = 52
4920:             .Movable   = .F.
4921:             .Resizable = .F.
4922:         ENDWITH
4923: 
4924:         *-- RecordSource APOS ColumnCount (NUNCA dentro de WITH)
4925:         loc_oGrd.RecordSource = "cursor_4c_GrdCons"
4926: 
4927:         *-- ControlSource APOS RecordSource (obrigatorio re-aplicar apos RecordSource)
4928:         loc_oGrd.Column1.ControlSource = "cursor_4c_GrdCons.Mats"
4929:         loc_oGrd.Column2.ControlSource = "cursor_4c_GrdCons.Dcompos"
4930:         loc_oGrd.Column3.ControlSource = "cursor_4c_GrdCons.Qtds"
4931:         loc_oGrd.Column4.ControlSource = "cursor_4c_GrdCons.UniCompos"
4932:         loc_oGrd.Column5.ControlSource = "cursor_4c_GrdCons.Grupos"
4933:         loc_oGrd.Column6.ControlSource = "cursor_4c_GrdCons.Dscgrp"
4934:         loc_oGrd.Column7.ControlSource = "cursor_4c_GrdCons.Ordems"
4935:         loc_oGrd.Column8.ControlSource = "cursor_4c_GrdCons.QtsCons"
4936:         loc_oGrd.Column9.ControlSource = "cursor_4c_GrdCons.Cats"
4937: 
4938:         *-- Cabecalhos APOS RecordSource
4939:         loc_oGrd.Column1.Header1.Caption = "Componente"
4940:         loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
4941:         loc_oGrd.Column3.Header1.Caption = "Qtde."
4942:         loc_oGrd.Column4.Header1.Caption = "Uni"
4943:         loc_oGrd.Column5.Header1.Caption = "Fase"
4944:         loc_oGrd.Column6.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
4945:         loc_oGrd.Column7.Header1.Caption = "Ord."
4946:         loc_oGrd.Column8.Header1.Caption = "Consumo"
4947:         loc_oGrd.Column9.Header1.Caption = "Cat."
4948: 
4949:         *-- Larguras re-aplicadas APOS RecordSource
4950:         loc_oGrd.Column1.Width = 108
4951:         loc_oGrd.Column2.Width = 223
4952:         loc_oGrd.Column3.Width = 60
4953:         loc_oGrd.Column4.Width = 25
4954:         loc_oGrd.Column5.Width = 105
4955:         loc_oGrd.Column6.Width = 254
4956:         loc_oGrd.Column7.Width = 35
4957:         loc_oGrd.Column8.Width = 60
4958:         loc_oGrd.Column9.Width = 52
4959: 
4960:         *-- BINDEVENT grd_4c_GrdCons
4961:         BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GrdConsAfterRowColChange")
4962: 
4963:         *-- ===================================================================
4964:         *-- GRID grd_4c_GrDTEMP (grDTEMP: top=519, left=821, w=172, h=107, 2 cols)
4965:         *-- ===================================================================
4966:         loc_oPg.AddObject("grd_4c_GrDTEMP", "Grid")
4967:         loc_oGrd2 = loc_oPg.grd_4c_GrDTEMP
4968:         WITH loc_oGrd2
4969:             .Top         = 519
4970:             .Left        = 821
4971:             .Width       = 172
4972:             .Height      = 107
4973:             .FontName    = "Tahoma"
4974:             .FontSize    = 8
4975:             .RecordMark  = .T.
4976:             .DeleteMark  = .F.
4977:             .GridLines   = 3
4978:             .ReadOnly    = .T.
4979:             .RowHeight   = 17
4980:             .ScrollBars  = 2
4981:             .Themes      = .F.
4982:             .ColumnCount = 2
4983:             .Visible     = .T.
4984:         ENDWITH
4985: 
4986:         *-- Col1: Agrupamento/agrupas (80px, ReadOnly)
4987:         WITH loc_oGrd2.Column1
4988:             .Width     = 80
4989:             .Movable   = .F.
4990:             .Resizable = .F.
4991:             .ReadOnly  = .T.
4992:         ENDWITH
4993:         *-- Col2: Tempo %/pertemps (60px, ReadOnly)
4994:         WITH loc_oGrd2.Column2
4995:             .Width      = 60
4996:             .Movable    = .F.
4997:             .Resizable  = .F.
4998:             .ReadOnly   = .T.
4999:             .InputMask  = "999,999,999.999"
5000:         ENDWITH
5001: 
5002:         *-- RecordSource APOS ColumnCount
5003:         loc_oGrd2.RecordSource = "cursor_4c_GrDTEMP"
5004: 
5005:         *-- ControlSource APOS RecordSource
5006:         loc_oGrd2.Column1.ControlSource = "cursor_4c_GrDTEMP.agrupas"
5007:         loc_oGrd2.Column2.ControlSource = "cursor_4c_GrDTEMP.pertemps"
5008: 
5009:         *-- Cabecalhos APOS RecordSource
5010:         loc_oGrd2.Column1.Header1.Caption = "Agrupamento"
5011:         loc_oGrd2.Column2.Header1.Caption = "Tempo %"
5012: 
5013:         *-- Larguras re-aplicadas APOS RecordSource
5014:         loc_oGrd2.Column1.Width = 80
5015:         loc_oGrd2.Column2.Width = 60
5016: 
5017:         *-- ===================================================================
5018:         *-- LABEL lbl_4c_Say7 (Say7 "Qtde Componentes :": top=523, left=25, w=105, h=15)
5019:         *-- ===================================================================
5020:         loc_oPg.AddObject("lbl_4c_Say7", "Label")
5021:         WITH loc_oPg.lbl_4c_Say7
5022:             .Caption   = "Qtde Componentes : "
5023:             .Top       = 523
5024:             .Left      = 25
5025:             .Width     = 105
5026:             .Height    = 15
5027:             .BackStyle = 0
5028:             .ForeColor = RGB(90, 90, 90)
5029:             .FontName  = "Tahoma"
5030:             .FontSize  = 8
5031:             .Visible   = .T.
5032:         ENDWITH
5033: 
5034:         *-- ===================================================================
5035:         *-- LABEL lbl_4c_Say1 (Say1 "Tempo Producao...": top=521, left=642, w=176, h=15)

*-- Linhas 5096 a 5255:
5096: 
5097:     *--------------------------------------------------------------------------
5098:     * ConfigurarPgPgDadosFaseP - Aba "Fases P." (Page4 de pgf_4c_Dados)
5099:     * Grid grd_4c_FasePro (5 cols: Ordem|Fase|Utilizacao|Uni.Produtiva|Material)
5100:     * Grid grd_4c_Matrizes (3 cols: Matriz|Local|Qtde)
5101:     * Campos: Qmin, CodGarras, Conquilha, PesoBris, PesoMetal, PesoPdrs, Cor, Tam
5102:     * ImgFigJpg (foto do processo), ImgBorracha (foto da matriz)
5103:     * par_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
5104:     *--------------------------------------------------------------------------
5105:     PROTECTED PROCEDURE ConfigurarPgPgDadosFaseP(par_oPage)
5106:         LOCAL loc_oPg, loc_oGrd, loc_oGrd2
5107: 
5108:         loc_oPg = par_oPage
5109: 
5110:         *-- ===================================================================
5111:         *-- CURSORS PLACEHOLDER (criar ANTES dos grids)
5112:         *-- Campos na ORDEM VISUAL das colunas (sem ColumnOrder)
5113:         *-- ===================================================================
5114: 
5115:         *-- cursor_4c_Fase - fases de processo (baseado em crSigCdPrf)
5116:         *-- Ordem visual: Ordems | Grupos | Descrs | UniPrdts | TpMats
5117:         IF USED("cursor_4c_Fase")
5118:             USE IN cursor_4c_Fase
5119:         ENDIF
5120:         SET NULL OFF
5121:         CREATE CURSOR cursor_4c_Fase ( ;
5122:             Ordems    N(3,0), ;
5123:             Grupos    C(10), ;
5124:             Descrs    C(40), ;
5125:             UniPrdts  C(10), ;
5126:             TpMats    C(3), ;
5127:             FigProcs  M, ;
5128:             FkChaves  C(30), ;
5129:             GrpOrdem  C(12))
5130: 
5131:         *-- cursor_4c_Matrizes - matrizes do produto (baseado em crSigPrMtz)
5132:         *-- Ordem visual: CMats | Locals | QMatz
5133:         IF USED("cursor_4c_Matrizes")
5134:             USE IN cursor_4c_Matrizes
5135:         ENDIF
5136:         SET NULL OFF
5137:         CREATE CURSOR cursor_4c_Matrizes ( ;
5138:             CMats     C(14), ;
5139:             Locals    C(20), ;
5140:             QMatz     N(5,2), ;
5141:             CPros     C(14), ;
5142:             cIdChaves C(30), ;
5143:             DPros     C(40))
5144:         *-- Linha vazia placeholder (grdMatrizes sempre tem ao menos 1 linha)
5145:         INSERT INTO cursor_4c_Matrizes (CMats, Locals, QMatz, CPros, cIdChaves, DPros) ;
5146:             VALUES ("", "", 0, "", "", "")
5147: 
5148:         *-- ===================================================================
5149:         *-- GRID grd_4c_FasePro (GradFase: top=152, left=527, w=420, h=312, 5 cols)
5150:         *-- crSigCdPrf: Ordems N(3), Grupos C(10), Descrs C(40), UniPrdts C(10), TpMats C(3)
5151:         *-- ===================================================================
5152:         loc_oPg.AddObject("grd_4c_FasePro", "Grid")
5153:         loc_oGrd = loc_oPg.grd_4c_FasePro
5154:         WITH loc_oGrd
5155:             .Top         = 152
5156:             .Left        = 527
5157:             .Width       = 420
5158:             .Height      = 312
5159:             .FontName    = "Tahoma"
5160:             .FontSize    = 8
5161:             .RecordMark  = .F.
5162:             .DeleteMark  = .F.
5163:             .GridLines   = 3
5164:             .ReadOnly    = .F.
5165:             .RowHeight   = 17
5166:             .ScrollBars  = 2
5167:             .Themes      = .F.
5168:             .ColumnCount = 5
5169:             .Visible     = .T.
5170:         ENDWITH
5171: 
5172:         *-- Col1: Ordem/Ordems (40px)
5173:         WITH loc_oGrd.Column1
5174:             .Width     = 40
5175:             .Movable   = .F.
5176:             .Resizable = .F.
5177:         ENDWITH
5178:         *-- Col2: Fase/Grupos (70px, editavel)
5179:         WITH loc_oGrd.Column2
5180:             .Width     = 70
5181:             .Movable   = .F.
5182:             .Resizable = .F.
5183:             .Sparse    = .F.
5184:         ENDWITH
5185:         *-- Col3: Utilizacao/Descrs (165px, ReadOnly - preenchida pelo lookup da Col2)
5186:         WITH loc_oGrd.Column3
5187:             .Width     = 165
5188:             .Movable   = .F.
5189:             .Resizable = .F.
5190:             .ReadOnly  = .T.
5191:         ENDWITH
5192:         *-- Col4: Uni. Produtiva/UniPrdts (100px, editavel)
5193:         WITH loc_oGrd.Column4
5194:             .Width     = 100
5195:             .Movable   = .F.
5196:             .Resizable = .F.
5197:             .Sparse    = .F.
5198:         ENDWITH
5199:         *-- Col5: Material/TpMats (45px, editavel)
5200:         WITH loc_oGrd.Column5
5201:             .Width     = 45
5202:             .Movable   = .F.
5203:             .Resizable = .F.
5204:             .Sparse    = .F.
5205:         ENDWITH
5206: 
5207:         *-- RecordSource APOS ColumnCount (NUNCA dentro de WITH)
5208:         loc_oGrd.RecordSource = "cursor_4c_Fase"
5209: 
5210:         *-- ControlSource APOS RecordSource (obrigatorio re-aplicar apos RecordSource)
5211:         loc_oGrd.Column1.ControlSource = "cursor_4c_Fase.Ordems"
5212:         loc_oGrd.Column2.ControlSource = "cursor_4c_Fase.Grupos"
5213:         loc_oGrd.Column3.ControlSource = "cursor_4c_Fase.Descrs"
5214:         loc_oGrd.Column4.ControlSource = "cursor_4c_Fase.UniPrdts"
5215:         loc_oGrd.Column5.ControlSource = "cursor_4c_Fase.TpMats"
5216: 
5217:         *-- Cabecalhos APOS RecordSource
5218:         loc_oGrd.Column1.Header1.Caption = "Ordem"
5219:         loc_oGrd.Column2.Header1.Caption = "Fase"
5220:         loc_oGrd.Column3.Header1.Caption = "Utiliza" + CHR(231) + CHR(227) + "o"
5221:         loc_oGrd.Column4.Header1.Caption = "Uni. Produtiva"
5222:         loc_oGrd.Column5.Header1.Caption = "Material"
5223: 
5224:         *-- Larguras re-aplicadas APOS RecordSource
5225:         loc_oGrd.Column1.Width = 40
5226:         loc_oGrd.Column2.Width = 70
5227:         loc_oGrd.Column3.Width = 165
5228:         loc_oGrd.Column4.Width = 100
5229:         loc_oGrd.Column5.Width = 45
5230: 
5231:         *-- BINDEVENT grd_4c_FasePro
5232:         BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GrdFaseAfterRowColChange")
5233:         BINDEVENT(loc_oGrd.Column2.Text1, "Valid", THIS, "FaseGrdCol2Valid")
5234:         BINDEVENT(loc_oGrd.Column4.Text1, "Valid", THIS, "FaseGrdCol4Valid")
5235:         BINDEVENT(loc_oGrd.Column5.Text1, "Valid", THIS, "FaseGrdCol5Valid")
5236: 
5237:         *-- ===================================================================
5238:         *-- COMMANDBUTTON cmd_4c_Incluir (inserir: top=152, left=950, 30x30)
5239:         *-- ===================================================================
5240:         loc_oPg.AddObject("cmd_4c_InsFase", "CommandButton")
5241:         WITH loc_oPg.cmd_4c_InsFase
5242:             .Top             = 152
5243:             .Left            = 950
5244:             .Width           = 30
5245:             .Height          = 30
5246:             .Caption         = ""
5247:             .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
5248:             .PicturePosition = 13
5249:             .ToolTipText     = "Inserir Fase"
5250:             .FontName        = "Tahoma"
5251:             .FontSize        = 8
5252:             .Themes          = .F.
5253:             .SpecialEffect   = 0
5254:             .BackColor       = RGB(255, 255, 255)
5255:             .Visible         = .T.

*-- Linhas 5813 a 5900:
5813:         ENDWITH
5814: 
5815:         *-- ===================================================================
5816:         *-- GRID grd_4c_Matrizes (grdMatrizes: top=380, left=7, w=246, h=240, 3 cols)
5817:         *-- crSigPrMtz: CMats C(14) | Locals C(20) | QMatz N(5,2)
5818:         *-- ===================================================================
5819:         loc_oPg.AddObject("grd_4c_Matrizes", "Grid")
5820:         loc_oGrd2 = loc_oPg.grd_4c_Matrizes
5821:         WITH loc_oGrd2
5822:             .Top         = 380
5823:             .Left        = 7
5824:             .Width       = 246
5825:             .Height      = 240
5826:             .FontName    = "Tahoma"
5827:             .FontSize    = 8
5828:             .RecordMark  = .F.
5829:             .DeleteMark  = .F.
5830:             .GridLines   = 3
5831:             .ReadOnly    = .F.
5832:             .RowHeight   = 17
5833:             .ScrollBars  = 2
5834:             .Themes      = .F.
5835:             .ColumnCount = 3
5836:             .Visible     = .T.
5837:         ENDWITH
5838: 
5839:         *-- Col1: Matriz/CMats (80px, editavel com lookup)
5840:         WITH loc_oGrd2.Column1
5841:             .Width     = 80
5842:             .Movable   = .F.
5843:             .Resizable = .F.
5844:             .Sparse    = .F.
5845:         ENDWITH
5846:         *-- Col2: Local/Locals (116px, ReadOnly)
5847:         WITH loc_oGrd2.Column2
5848:             .Width     = 116
5849:             .Movable   = .F.
5850:             .Resizable = .F.
5851:             .ReadOnly  = .T.
5852:         ENDWITH
5853:         *-- Col3: Qtde/QMatz (50px, editavel)
5854:         WITH loc_oGrd2.Column3
5855:             .Width     = 50
5856:             .Movable   = .F.
5857:             .Resizable = .F.
5858:         ENDWITH
5859: 
5860:         *-- RecordSource APOS ColumnCount (NUNCA dentro de WITH)
5861:         loc_oGrd2.RecordSource = "cursor_4c_Matrizes"
5862: 
5863:         *-- ControlSource APOS RecordSource
5864:         loc_oGrd2.Column1.ControlSource = "cursor_4c_Matrizes.CMats"
5865:         loc_oGrd2.Column2.ControlSource = "cursor_4c_Matrizes.Locals"
5866:         loc_oGrd2.Column3.ControlSource = "cursor_4c_Matrizes.QMatz"
5867: 
5868:         *-- Cabecalhos APOS RecordSource
5869:         loc_oGrd2.Column1.Header1.Caption = "Matriz"
5870:         loc_oGrd2.Column2.Header1.Caption = "Local"
5871:         loc_oGrd2.Column3.Header1.Caption = "Qtde"
5872: 
5873:         *-- Larguras re-aplicadas APOS RecordSource
5874:         loc_oGrd2.Column1.Width = 80
5875:         loc_oGrd2.Column2.Width = 116
5876:         loc_oGrd2.Column3.Width = 50
5877: 
5878:         *-- BINDEVENT grd_4c_Matrizes
5879:         BINDEVENT(loc_oGrd2, "AfterRowColChange", THIS, "GrdMatrizesAfterRowColChange")
5880:         BINDEVENT(loc_oGrd2.Column1.Text1, "Valid", THIS, "MatrizGrdCol1Valid")
5881: 
5882:         *-- ===================================================================
5883:         *-- COMMANDBUTTON cmd_4c_BtnInsereMtx (btnInsereMtx: top=380, left=258, 30x30)
5884:         *-- ===================================================================
5885:         loc_oPg.AddObject("cmd_4c_BtnInsereMtx", "CommandButton")
5886:         WITH loc_oPg.cmd_4c_BtnInsereMtx
5887:             .Top             = 380
5888:             .Left            = 258
5889:             .Width           = 30
5890:             .Height          = 30
5891:             .Caption         = ""
5892:             .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
5893:             .PicturePosition = 13
5894:             .ToolTipText     = "Inserir Matriz"
5895:             .FontName        = "Tahoma"
5896:             .FontSize        = 8
5897:             .Themes          = .F.
5898:             .SpecialEffect   = 0
5899:             .BackColor       = RGB(255, 255, 255)
5900:             .Visible         = .T.

*-- Linhas 5951 a 6091:
5951: 
5952:     *--------------------------------------------------------------------------
5953:     * ConfigurarPgpgDesigner - Aba "Designer" (Page7 do pgf_4c_Dados)
5954:     * Controles: grd_4c_Designer (4 cols tarefas), obj_4c_GetObsTarefas,
5955:     *            cmd_4c_BtnIniTarefa, cmd_4c_BtnFimTarefa,
5956:     *            grd_4c_Arquivos (1 col), cmd_4c_BtnInsArqs/OpnArqs/ExcArqs,
5957:     *            shp_4c_Shape1, img_4c_ImgArqJpg
5958:     * par_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
5959:     *--------------------------------------------------------------------------
5960:     PROTECTED PROCEDURE ConfigurarPgpgDesigner(par_oPage)
5961:         LOCAL loc_oPg, loc_oGrd, loc_oGrd2
5962: 
5963:         loc_oPg = par_oPage
5964: 
5965:         *-- ===================================================================
5966:         *-- CURSORS PLACEHOLDER (criar ANTES dos grids)
5967:         *-- Campos na ORDEM VISUAL das colunas (sem ColumnOrder)
5968:         *-- ===================================================================
5969: 
5970:         *-- cursor_4c_Tarefas - tarefas do designer (baseado em crSigPrTar)
5971:         *-- Ordem visual: DtInis | DtFims | Usuars | Tarefas
5972:         IF USED("cursor_4c_Tarefas")
5973:             USE IN cursor_4c_Tarefas
5974:         ENDIF
5975:         SET NULL OFF
5976:         CREATE CURSOR cursor_4c_Tarefas ( ;
5977:             DtInis      T, ;
5978:             DtFims      T, ;
5979:             Usuars      C(10), ;
5980:             Tarefas     C(10), ;
5981:             ObsTarefas  M, ;
5982:             CPros       C(14), ;
5983:             pkChaves    C(30))
5984: 
5985:         *-- cursor_4c_Arquivos - arquivos do designer (baseado em crSigPrArq)
5986:         IF USED("cursor_4c_Arquivos")
5987:             USE IN cursor_4c_Arquivos
5988:         ENDIF
5989:         SET NULL OFF
5990:         CREATE CURSOR cursor_4c_Arquivos ( ;
5991:             Arquivos    C(254), ;
5992:             CPros       C(14), ;
5993:             pkChaves    C(30))
5994: 
5995:         *-- ===================================================================
5996:         *-- GRID grd_4c_Designer (grdDesigner: top=160, left=10, w=495, h=238, 4 cols)
5997:         *-- crSigPrTar: DtInis T | DtFims T | Usuars C(10) | Tarefas C(10)
5998:         *-- ===================================================================
5999:         loc_oPg.AddObject("grd_4c_Designer", "Grid")
6000:         loc_oGrd = loc_oPg.grd_4c_Designer
6001:         WITH loc_oGrd
6002:             .Top         = 160
6003:             .Left        = 10
6004:             .Width       = 495
6005:             .Height      = 238
6006:             .FontName    = "Tahoma"
6007:             .FontSize    = 8
6008:             .RecordMark  = .F.
6009:             .DeleteMark  = .F.
6010:             .GridLines   = 3
6011:             .ReadOnly    = .F.
6012:             .RowHeight   = 17
6013:             .ScrollBars  = 2
6014:             .Themes      = .F.
6015:             .ColumnCount = 4
6016:             .Visible     = .T.
6017:         ENDWITH
6018: 
6019:         *-- Col1: Data de Inicio/DtInis (120px, ReadOnly)
6020:         WITH loc_oGrd.Column1
6021:             .Width     = 120
6022:             .Movable   = .F.
6023:             .Resizable = .F.
6024:             .ReadOnly  = .T.
6025:         ENDWITH
6026:         *-- Col2: Data de Conclusao/DtFims (120px, ReadOnly)
6027:         WITH loc_oGrd.Column2
6028:             .Width     = 120
6029:             .Movable   = .F.
6030:             .Resizable = .F.
6031:             .ReadOnly  = .T.
6032:         ENDWITH
6033:         *-- Col3: Usuario/Usuars (100px, ReadOnly)
6034:         WITH loc_oGrd.Column3
6035:             .Width     = 100
6036:             .Movable   = .F.
6037:             .Resizable = .F.
6038:             .ReadOnly  = .T.
6039:         ENDWITH
6040:         *-- Col4: Tarefa/Tarefas (155px, editavel via lookup)
6041:         WITH loc_oGrd.Column4
6042:             .Width     = 155
6043:             .Movable   = .F.
6044:             .Resizable = .F.
6045:             .Sparse    = .F.
6046:         ENDWITH
6047: 
6048:         *-- RecordSource APOS ColumnCount (NUNCA dentro de WITH)
6049:         loc_oGrd.RecordSource = "cursor_4c_Tarefas"
6050: 
6051:         *-- ControlSource APOS RecordSource (obrigatorio re-aplicar apos RecordSource)
6052:         loc_oGrd.Column1.ControlSource = "cursor_4c_Tarefas.DtInis"
6053:         loc_oGrd.Column2.ControlSource = "cursor_4c_Tarefas.DtFims"
6054:         loc_oGrd.Column3.ControlSource = "cursor_4c_Tarefas.Usuars"
6055:         loc_oGrd.Column4.ControlSource = "cursor_4c_Tarefas.Tarefas"
6056: 
6057:         *-- Cabecalhos APOS RecordSource
6058:         loc_oGrd.Column1.Header1.Caption = "Data de In" + CHR(237) + "cio"
6059:         loc_oGrd.Column2.Header1.Caption = "Data de Conclus" + CHR(227) + "o"
6060:         loc_oGrd.Column3.Header1.Caption = "Usu" + CHR(225) + "rio"
6061:         loc_oGrd.Column4.Header1.Caption = "Tarefa"
6062: 
6063:         *-- Larguras re-aplicadas APOS RecordSource
6064:         loc_oGrd.Column1.Width = 120
6065:         loc_oGrd.Column2.Width = 120
6066:         loc_oGrd.Column3.Width = 100
6067:         loc_oGrd.Column4.Width = 155
6068: 
6069:         *-- BINDEVENT grd_4c_Designer
6070:         BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GrdDesignerAfterRowColChange")
6071:         BINDEVENT(loc_oGrd.Column4.Text1, "Valid", THIS, "DesignerCol4Valid")
6072: 
6073:         *-- ===================================================================
6074:         *-- LABEL lbl_4c_Say31 ("Observacao da Tarefa": top=144, left=583)
6075:         *-- ===================================================================
6076:         loc_oPg.AddObject("lbl_4c_Say31", "Label")
6077:         WITH loc_oPg.lbl_4c_Say31
6078:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o da Tarefa"
6079:             .Top       = 144
6080:             .Left      = 583
6081:             .Width     = 120
6082:             .Height    = 15
6083:             .BackStyle = 0
6084:             .ForeColor = RGB(90, 90, 90)
6085:             .FontName  = "Tahoma"
6086:             .FontSize  = 8
6087:             .Visible   = .T.
6088:         ENDWITH
6089: 
6090:         *-- ===================================================================
6091:         *-- EDITBOX obj_4c_GetObsTarefas (getObsTarefas: top=160, left=584, w=407, h=238)

*-- Linhas 6103 a 6126:
6103:             .ScrollBars    = 2
6104:             .ReadOnly      = .F.
6105:             .Themes        = .F.
6106:             .ControlSource = "cursor_4c_Tarefas.ObsTarefas"
6107:             .Visible       = .T.
6108:         ENDWITH
6109: 
6110:         *-- ===================================================================
6111:         *-- COMMANDBUTTON cmd_4c_BtnIniTarefa (btnIniTarefa: top=161, left=509, w=42, h=42)
6112:         *-- When: InList(pcEscolha, INSERIR, ALTERAR)
6113:         *-- Click: Valida tarefa aberta + insere nova linha em cursor_4c_Tarefas
6114:         *-- ===================================================================
6115:         loc_oPg.AddObject("cmd_4c_BtnIniTarefa", "CommandButton")
6116:         WITH loc_oPg.cmd_4c_BtnIniTarefa
6117:             .Top             = 161
6118:             .Left            = 509
6119:             .Width           = 42
6120:             .Height          = 42
6121:             .Caption         = ""
6122:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_32.jpg"
6123:             .PicturePosition = 13
6124:             .ToolTipText     = "Iniciar Tarefa"
6125:             .FontName        = "Tahoma"
6126:             .FontSize        = 8

*-- Linhas 6156 a 6222:
6156:         BINDEVENT(loc_oPg.cmd_4c_BtnFimTarefa, "Click", THIS, "BtnFimTarefaClick")
6157: 
6158:         *-- ===================================================================
6159:         *-- GRID grd_4c_Arquivos (grdArquivos: top=415, left=10, w=495, h=202, 1 col)
6160:         *-- crSigPrArq: Arquivos C(254)
6161:         *-- ===================================================================
6162:         loc_oPg.AddObject("grd_4c_Arquivos", "Grid")
6163:         loc_oGrd2 = loc_oPg.grd_4c_Arquivos
6164:         WITH loc_oGrd2
6165:             .Top         = 415
6166:             .Left        = 10
6167:             .Width       = 495
6168:             .Height      = 202
6169:             .FontName    = "Tahoma"
6170:             .FontSize    = 8
6171:             .RecordMark  = .F.
6172:             .DeleteMark  = .F.
6173:             .GridLines   = 3
6174:             .ReadOnly    = .F.
6175:             .RowHeight   = 17
6176:             .ScrollBars  = 2
6177:             .Themes      = .F.
6178:             .ColumnCount = 1
6179:             .Visible     = .T.
6180:         ENDWITH
6181: 
6182:         *-- Col1: Arquivos (495px, editavel)
6183:         WITH loc_oGrd2.Column1
6184:             .Width     = 495
6185:             .Movable   = .F.
6186:             .Resizable = .F.
6187:             .Sparse    = .F.
6188:         ENDWITH
6189: 
6190:         *-- RecordSource APOS ColumnCount (NUNCA dentro de WITH)
6191:         loc_oGrd2.RecordSource = "cursor_4c_Arquivos"
6192: 
6193:         *-- ControlSource APOS RecordSource (obrigatorio re-aplicar apos RecordSource)
6194:         loc_oGrd2.Column1.ControlSource = "cursor_4c_Arquivos.Arquivos"
6195: 
6196:         *-- Cabecalho APOS RecordSource
6197:         loc_oGrd2.Column1.Header1.Caption = "Arquivos Para Designer"
6198: 
6199:         *-- Largura re-aplicada APOS RecordSource
6200:         loc_oGrd2.Column1.Width = 495
6201: 
6202:         *-- BINDEVENT grd_4c_Arquivos
6203:         BINDEVENT(loc_oGrd2, "AfterRowColChange", THIS, "GrdArquivosAfterRowColChange")
6204: 
6205:         *-- ===================================================================
6206:         *-- COMMANDBUTTON cmd_4c_BtnInsArqs (btnInsArqs: top=416, left=509, w=42, h=42)
6207:         *-- When: InList(pcEscolha, INSERIR, ALTERAR)
6208:         *-- Click: GetFile -> Insert Into cursor_4c_Arquivos
6209:         *-- ===================================================================
6210:         loc_oPg.AddObject("cmd_4c_BtnInsArqs", "CommandButton")
6211:         WITH loc_oPg.cmd_4c_BtnInsArqs
6212:             .Top             = 416
6213:             .Left            = 509
6214:             .Width           = 42
6215:             .Height          = 42
6216:             .Caption         = ""
6217:             .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
6218:             .PicturePosition = 13
6219:             .ToolTipText     = "Inserir Arquivo"
6220:             .FontName        = "Tahoma"
6221:             .FontSize        = 8
6222:             .Themes          = .F.

*-- Linhas 6309 a 6562:
6309:     ENDPROC
6310: 
6311:     *--------------------------------------------------------------------------
6312:     * GrdDesignerAfterRowColChange - Handler AfterRowColChange do grd_4c_Designer
6313:     * Atualiza exibicao da observacao da tarefa selecionada
6314:     *--------------------------------------------------------------------------
6315:     PROCEDURE GrdDesignerAfterRowColChange(par_nColIndex)
6316:         LOCAL loc_oPg
6317:         TRY
6318:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
6319:             IF PEMSTATUS(loc_oPg, "obj_4c_GetObsTarefas", 5)
6320:                 loc_oPg.obj_4c_GetObsTarefas.Refresh()
6321:             ENDIF
6322:         CATCH TO loc_oErro
6323:             MsgErro(loc_oErro.Message, "Erro")
6324:         ENDTRY
6325:     ENDPROC
6326: 
6327:     *--------------------------------------------------------------------------
6328:     * DesignerCol4Valid - Valid do Column4 (Tarefa) do grd_4c_Designer
6329:     * Lookup: SigCdCad (CodCads, DesCads) - catalogo de tarefas designer
6330:     *--------------------------------------------------------------------------
6331:     PROCEDURE DesignerCol4Valid(par_nColIndex)
6332:         LOCAL loc_lResultado, loc_oLookup, loc_oGrd, loc_cCodigo, loc_lcSQL
6333:         loc_lResultado = .T.
6334:         TRY
6335:             loc_oGrd    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer
6336:             loc_cCodigo = ALLTRIM(NVL(loc_oGrd.Column4.Text1.Value, ""))
6337:             IF EMPTY(loc_cCodigo)
6338:                 loc_lResultado = loc_lResultado
6339:             ENDIF
6340:             loc_lcSQL = "SELECT CodCads, DesCads FROM SigCdCad WHERE CodCads = " + EscaparSQL(loc_cCodigo)
6341:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValTarefas") <= 0 OR EOF("cursor_4c_ValTarefas")
6342:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
6343:                 loc_oLookup.mAddColuna("CodCads", "C" + CHR(243) + "digo", 80)
6344:                 loc_oLookup.mAddColuna("DesCads", "Descri" + CHR(231) + CHR(227) + "o", 220)
6345:                 loc_oLookup.cTabela     = "SigCdCad"
6346:                 loc_oLookup.cCampoChave = "CodCads"
6347:                 loc_oLookup.cFiltroIni  = loc_cCodigo
6348:                 loc_oLookup.Show()
6349:                 IF loc_oLookup.this_lSelecionou
6350:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
6351:                 ELSE
6352:                     loc_cCodigo = ""
6353:                 ENDIF
6354:             ENDIF
6355:             IF USED("cursor_4c_ValTarefas")
6356:                 USE IN cursor_4c_ValTarefas
6357:             ENDIF
6358:             IF USED("cursor_4c_Tarefas") AND !EOF("cursor_4c_Tarefas")
6359:                 SELECT cursor_4c_Tarefas
6360:                 REPLACE Tarefas WITH PADR(loc_cCodigo, 10) IN cursor_4c_Tarefas
6361:                 loc_oGrd.Column4.Text1.Value = loc_cCodigo
6362:             ENDIF
6363:         CATCH TO loc_oErro
6364:             MsgErro(loc_oErro.Message, "Erro")
6365:         ENDTRY
6366:         RETURN loc_lResultado
6367:     ENDPROC
6368: 
6369:     *--------------------------------------------------------------------------
6370:     * GrdArquivosAfterRowColChange - Handler AfterRowColChange do grd_4c_Arquivos
6371:     * Exibe preview de imagem se arquivo for JPG/ICO/BMP/JPEG
6372:     *--------------------------------------------------------------------------
6373:     PROCEDURE GrdArquivosAfterRowColChange(par_nColIndex)
6374:         LOCAL loc_lcArq, loc_oPg, loc_nPonto
6375:         TRY
6376:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
6377:             CLEAR RESOURCES
6378:             loc_oPg.img_4c_ImgArqJpg.Picture = ""
6379:             loc_oPg.img_4c_ImgArqJpg.Visible = .F.
6380:             IF !USED("cursor_4c_Arquivos") OR EOF("cursor_4c_Arquivos")
6381:                 RETURN
6382:             ENDIF
6383:             loc_lcArq  = ALLTRIM(cursor_4c_Arquivos.Arquivos)
6384:             loc_nPonto = AT(".", loc_lcArq)
6385:             IF !EMPTY(loc_lcArq) AND loc_nPonto > 0 AND ;
6386:                 INLIST(ALLTRIM(UPPER(SUBSTR(loc_lcArq, loc_nPonto, 5))), ".JPG", ".ICO", ".BMP", ".JPEG")
6387:                 loc_oPg.img_4c_ImgArqJpg.Picture = loc_lcArq
6388:                 loc_oPg.img_4c_ImgArqJpg.Visible = .T.
6389:             ENDIF
6390:         CATCH TO loc_oErro
6391:             MsgErro(loc_oErro.Message, "Erro")
6392:         ENDTRY
6393:     ENDPROC
6394: 
6395:     *--------------------------------------------------------------------------
6396:     * BtnIniTarefaClick - Inicia nova tarefa no grd_4c_Designer
6397:     * Valida: sem tarefa aberta para o usuario + sem tarefa sem codigo
6398:     *--------------------------------------------------------------------------
6399:     PROCEDURE BtnIniTarefaClick()
6400:         LOCAL loc_lResultado, loc_oGrd, loc_tDataHora
6401:         loc_lResultado = .F.
6402:         TRY
6403:             IF !USED("cursor_4c_Tarefas")
6404:                 loc_lResultado = loc_lResultado
6405:             ENDIF
6406:             loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer
6407: 
6408:             *-- Validar: nao pode ter tarefa aberta (DtFims vazia) para este usuario
6409:             SELECT cursor_4c_Tarefas
6410:             GO TOP IN cursor_4c_Tarefas
6411:             LOCATE FOR ALLTRIM(Usuars) = ALLTRIM(gc_4c_UsuarioLogado) AND EMPTY(DtFims)
6412:             IF !EOF("cursor_4c_Tarefas")
6413:                 MsgAviso("Existe Uma Tarefa N" + CHR(227) + "o Encerrada Para Esse Usu" + CHR(225) + "rio!!!")
6414:                 loc_oGrd.Column4.SetFocus()
6415:                 loc_lResultado = loc_lResultado
6416:             ENDIF
6417: 
6418:             *-- Validar: nao pode ter tarefa com codigo vazio para este usuario
6419:             SELECT cursor_4c_Tarefas
6420:             GO TOP IN cursor_4c_Tarefas
6421:             LOCATE FOR ALLTRIM(Usuars) = ALLTRIM(gc_4c_UsuarioLogado) AND EMPTY(Tarefas)
6422:             IF !EOF("cursor_4c_Tarefas")
6423:                 MsgAviso("Existe Uma Tarefa Ainda N" + CHR(227) + "o Informada!!!")
6424:                 loc_oGrd.Column4.SetFocus()
6425:                 loc_lResultado = loc_lResultado
6426:             ENDIF
6427: 
6428:             *-- Inserir nova linha com DtInis = agora, DtFims = vazio ({})
6429:             loc_tDataHora = DATETIME()
6430:             INSERT INTO cursor_4c_Tarefas (DtInis, DtFims, Usuars, Tarefas, CPros, pkChaves) ;
6431:                 VALUES (loc_tDataHora, {}, ;
6432:                         PADR(gc_4c_UsuarioLogado, 10), PADR("", 10), ;
6433:                         PADR(THIS.this_oBusinessObject.this_cCpros, 14), "")
6434: 
6435:             SELECT cursor_4c_Tarefas
6436:             GO BOTTOM IN cursor_4c_Tarefas
6437:             loc_oGrd.Refresh()
6438:             loc_oGrd.Column4.SetFocus()
6439:             loc_lResultado = .T.
6440:         CATCH TO loc_oErro
6441:             MsgErro(loc_oErro.Message, "Erro")
6442:         ENDTRY
6443:         RETURN loc_lResultado
6444:     ENDPROC
6445: 
6446:     *--------------------------------------------------------------------------
6447:     * BtnFimTarefaClick - Finaliza tarefa corrente no grd_4c_Designer
6448:     * Valida: tarefa pertence ao usuario + nao esta ja finalizada
6449:     *--------------------------------------------------------------------------
6450:     PROCEDURE BtnFimTarefaClick()
6451:         LOCAL loc_lResultado, loc_oGrd, loc_tDataHora
6452:         loc_lResultado = .F.
6453:         TRY
6454:             IF !USED("cursor_4c_Tarefas") OR EOF("cursor_4c_Tarefas") OR BOF("cursor_4c_Tarefas")
6455:                 loc_lResultado = loc_lResultado
6456:             ENDIF
6457:             loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer
6458: 
6459:             *-- Validar: tarefa deve pertencer ao usuario logado
6460:             IF ALLTRIM(cursor_4c_Tarefas.Usuars) <> ALLTRIM(gc_4c_UsuarioLogado)
6461:                 MsgAviso("Essa Tarefa N" + CHR(227) + "o Pertence a Esse Usu" + CHR(225) + "rio!!!")
6462:                 loc_oGrd.Column4.SetFocus()
6463:                 loc_lResultado = loc_lResultado
6464:             ENDIF
6465: 
6466:             *-- Validar: tarefa nao pode estar ja finalizada
6467:             IF !EMPTY(cursor_4c_Tarefas.DtFims)
6468:                 MsgAviso("Essa Tarefa J" + CHR(225) + " Se Encontra Finalizada!!!")
6469:                 loc_oGrd.Column4.SetFocus()
6470:                 loc_lResultado = loc_lResultado
6471:             ENDIF
6472: 
6473:             *-- Registrar data/hora de finalizacao
6474:             loc_tDataHora = DATETIME()
6475:             SELECT cursor_4c_Tarefas
6476:             REPLACE DtFims WITH loc_tDataHora IN cursor_4c_Tarefas
6477: 
6478:             loc_oGrd.Refresh()
6479:             loc_lResultado = .T.
6480:         CATCH TO loc_oErro
6481:             MsgErro(loc_oErro.Message, "Erro")
6482:         ENDTRY
6483:         RETURN loc_lResultado
6484:     ENDPROC
6485: 
6486:     *--------------------------------------------------------------------------
6487:     * BtnInsArqsClick - Insere arquivo no grd_4c_Arquivos via dialog GetFile
6488:     *--------------------------------------------------------------------------
6489:     PROCEDURE BtnInsArqsClick()
6490:         LOCAL loc_lResultado, loc_lcArq, loc_oGrd
6491:         loc_lResultado = .F.
6492:         TRY
6493:             loc_oGrd  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Arquivos
6494:             loc_lcArq = GETFILE("", "Selecione o Arquivo", "Selecione o Arquivo", 0, ;
6495:                 "Sele" + CHR(231) + CHR(227) + "o de Arquivos")
6496:             IF !EMPTY(loc_lcArq)
6497:                 INSERT INTO cursor_4c_Arquivos (CPros, pkChaves, Arquivos) ;
6498:                     VALUES (PADR(THIS.this_oBusinessObject.this_cCpros, 14), "", UPPER(loc_lcArq))
6499:                 loc_oGrd.Refresh()
6500:             ENDIF
6501:             loc_lResultado = .T.
6502:         CATCH TO loc_oErro
6503:             MsgErro(loc_oErro.Message, "Erro")
6504:         ENDTRY
6505:         RETURN loc_lResultado
6506:     ENDPROC
6507: 
6508:     *--------------------------------------------------------------------------
6509:     * BtnOpnArqsClick - Abre arquivo selecionado no grd_4c_Arquivos com Shell
6510:     *--------------------------------------------------------------------------
6511:     PROCEDURE BtnOpnArqsClick()
6512:         LOCAL loc_lResultado, loc_lcArq, loc_oApp
6513:         loc_lResultado = .F.
6514:         TRY
6515:             IF !USED("cursor_4c_Arquivos") OR EOF("cursor_4c_Arquivos")
6516:                 loc_lResultado = loc_lResultado
6517:             ENDIF
6518:             loc_lcArq = ALLTRIM(cursor_4c_Arquivos.Arquivos)
6519:             IF !EMPTY(loc_lcArq) AND FILE(loc_lcArq)
6520:                 loc_oApp = CREATEOBJECT("Shell.Application")
6521:                 loc_oApp.Open(loc_lcArq)
6522:                 loc_lResultado = .T.
6523:             ELSE
6524:                 MsgAviso("Arquivo N" + CHR(227) + "o Encontrado!!!")
6525:             ENDIF
6526:         CATCH TO loc_oErro
6527:             MsgErro(loc_oErro.Message, "Erro")
6528:         ENDTRY
6529:         RETURN loc_lResultado
6530:     ENDPROC
6531: 
6532:     *--------------------------------------------------------------------------
6533:     * BtnExcArqsClick - Exclui arquivo selecionado do grd_4c_Arquivos
6534:     *--------------------------------------------------------------------------
6535:     PROCEDURE BtnExcArqsClick()
6536:         LOCAL loc_lResultado, loc_oGrd
6537:         loc_lResultado = .F.
6538:         TRY
6539:             IF !USED("cursor_4c_Arquivos") OR EOF("cursor_4c_Arquivos") OR BOF("cursor_4c_Arquivos")
6540:                 loc_lResultado = loc_lResultado
6541:             ENDIF
6542:             loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Arquivos
6543:             IF !EMPTY(cursor_4c_Arquivos.Arquivos)
6544:                 SELECT cursor_4c_Arquivos
6545:                 DELETE IN cursor_4c_Arquivos
6546:                 IF !EOF("cursor_4c_Arquivos")
6547:                     SKIP IN cursor_4c_Arquivos
6548:                 ENDIF
6549:                 IF EOF("cursor_4c_Arquivos")
6550:                     GO BOTTOM IN cursor_4c_Arquivos
6551:                 ENDIF
6552:                 PACK IN cursor_4c_Arquivos
6553:             ENDIF
6554:             loc_oGrd.Refresh()
6555:             loc_lResultado = .T.
6556:         CATCH TO loc_oErro
6557:             MsgErro(loc_oErro.Message, "Erro")
6558:         ENDTRY
6559:         RETURN loc_lResultado
6560:     ENDPROC
6561: 
6562:     *--------------------------------------------------------------------------

*-- Linhas 6583 a 6640:
6583:     ENDPROC
6584: 
6585:     *--------------------------------------------------------------------------
6586:     * GrdConsAfterRowColChange - Handler AfterRowColChange do grd_4c_GrdCons
6587:     *--------------------------------------------------------------------------
6588:     PROCEDURE GrdConsAfterRowColChange(par_nColIndex)
6589:         IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
6590:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
6591:         ENDIF
6592:     ENDPROC
6593: 
6594:     *--------------------------------------------------------------------------
6595:     * GrdFaseAfterRowColChange - Handler AfterRowColChange do grd_4c_FasePro
6596:     * Carrega imagem FigProcs do campo memo na img_4c_ImgFigJpg
6597:     *--------------------------------------------------------------------------
6598:     PROCEDURE GrdFaseAfterRowColChange(par_nColIndex)
6599:         LOCAL loc_oPage, loc_lcArquivo
6600:         TRY
6601:             IF USED("cursor_4c_Fase") AND !EOF("cursor_4c_Fase")
6602:                 loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
6603:                 loc_lcArquivo = SYS(2023) + "\" + go_4c_Sistema.Sys2015Tmp + SYS(2015) + ".jpg"
6604:                 CLEAR RESOURCES
6605:                 loc_oPage.img_4c_ImgFigJpg.Picture = ""
6606:                 loc_oPage.img_4c_ImgFigJpg.Visible = .F.
6607:                 IF !EMPTY(cursor_4c_Fase.FigProcs) AND !ISNULL(cursor_4c_Fase.FigProcs)
6608:                     IF STRTOFILE(cursor_4c_Fase.FigProcs, loc_lcArquivo) > 0
6609:                         loc_oPage.img_4c_ImgFigJpg.Visible = .T.
6610:                         loc_oPage.img_4c_ImgFigJpg.Picture = loc_lcArquivo
6611:                     ENDIF
6612:                 ENDIF
6613:             ENDIF
6614:         CATCH TO loc_oErro
6615:             MsgErro(loc_oErro.Message, "Erro")
6616:         ENDTRY
6617:     ENDPROC
6618: 
6619:     *--------------------------------------------------------------------------
6620:     * GrdMatrizesAfterRowColChange - Handler AfterRowColChange do grd_4c_Matrizes
6621:     * Carrega imagem do produto matriz na img_4c_ImgBorracha via SQL
6622:     *--------------------------------------------------------------------------
6623:     PROCEDURE GrdMatrizesAfterRowColChange(par_nColIndex)
6624:         LOCAL loc_oPage, loc_lcArquivo, loc_lcSQL
6625:         TRY
6626:             IF USED("cursor_4c_Matrizes") AND !EOF("cursor_4c_Matrizes")
6627:                 loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
6628:                 loc_lcArquivo = SYS(2023) + "\" + go_4c_Sistema.Sys2015Tmp + SYS(2015) + ".jpg"
6629:                 CLEAR RESOURCES
6630:                 loc_oPage.img_4c_ImgBorracha.Picture = ""
6631:                 loc_oPage.img_4c_ImgBorracha.Visible = .F.
6632:                 IF !EMPTY(cursor_4c_Matrizes.CMats)
6633:                     loc_lcSQL = "SELECT FigProcs FROM SigCdPro WHERE CPros = '" + ;
6634:                         EscaparSQL(ALLTRIM(cursor_4c_Matrizes.CMats))
6635:                     IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_BorrachaImg") > 0
6636:                         IF !EOF("cursor_4c_BorrachaImg")
6637:                             IF !EMPTY(cursor_4c_BorrachaImg.FigProcs) AND !ISNULL(cursor_4c_BorrachaImg.FigProcs)
6638:                                 IF STRTOFILE(cursor_4c_BorrachaImg.FigProcs, loc_lcArquivo) > 0
6639:                                     loc_oPage.img_4c_ImgBorracha.Visible = .T.
6640:                                     loc_oPage.img_4c_ImgBorracha.Picture = loc_lcArquivo

*-- Linhas 6646 a 6669:
6646:                         ENDIF
6647:                     ENDIF
6648:                 ENDIF
6649:                 loc_oPage.grd_4c_Matrizes.Refresh()
6650:             ENDIF
6651:         CATCH TO loc_oErro
6652:             MsgErro(loc_oErro.Message, "Erro")
6653:         ENDTRY
6654:     ENDPROC
6655: 
6656:     *--------------------------------------------------------------------------
6657:     * ImgFigJpgClick - Click na imagem -> amplia em zoom (SigOpZom)
6658:     *--------------------------------------------------------------------------
6659:     PROCEDURE ImgFigJpgClick()
6660:         LOCAL loc_lcArquivo
6661:         TRY
6662:             IF USED("cursor_4c_Fase") AND !EOF("cursor_4c_Fase")
6663:                 loc_lcArquivo = SYS(2023) + "\" + go_4c_Sistema.Sys2015Tmp + SYS(2015) + ".jpg"
6664:                 IF !EMPTY(cursor_4c_Fase.FigProcs) AND !ISNULL(cursor_4c_Fase.FigProcs)
6665:                     STRTOFILE(cursor_4c_Fase.FigProcs, loc_lcArquivo)
6666:                     IF FILE(loc_lcArquivo)
6667:                         DO FORM SigOpZom WITH loc_lcArquivo, .F.
6668:                     ENDIF
6669:                 ENDIF

*-- Linhas 6686 a 6866:
6686:                 RETURN
6687:             ENDIF
6688:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
6689:             loc_oPage.grd_4c_FasePro.SetFocus()
6690:             loc_lcFigura = GETPICT("Formato Jpeg:JPG;Formato Bitmap:BMP", "Nome do Arquivo:", "Selecionar")
6691:             IF !EMPTY(loc_lcFigura)
6692:                 loc_lcArquivo = SYS(2023) + "\" + go_4c_Sistema.Sys2015Tmp + SYS(2015) + ".jpg"
6693:                 CLEAR RESOURCES
6694:                 SELECT cursor_4c_Fase
6695:                 REPLACE FigProcs WITH FILETOSTR(loc_lcFigura) IN cursor_4c_Fase
6696:                 IF STRTOFILE(cursor_4c_Fase.FigProcs, loc_lcArquivo) > 0
6697:                     loc_oPage.img_4c_ImgFigJpg.Visible = .T.
6698:                     loc_oPage.img_4c_ImgFigJpg.Picture = loc_lcArquivo
6699:                 ENDIF
6700:             ENDIF
6701:         CATCH TO loc_oErro
6702:             MsgErro(loc_oErro.Message, "Erro")
6703:         ENDTRY
6704:     ENDPROC
6705: 
6706:     *--------------------------------------------------------------------------
6707:     * CmdgFigCamClick - Captura foto via camera (reutiliza logica de GetPict)
6708:     *--------------------------------------------------------------------------
6709:     PROCEDURE CmdgFigCamClick()
6710:         THIS.CmdgFiguraClick()
6711:     ENDPROC
6712: 
6713:     *--------------------------------------------------------------------------
6714:     * FaseInserirClick - Insere nova linha no grd_4c_FasePro
6715:     *--------------------------------------------------------------------------
6716:     PROCEDURE FaseInserirClick()
6717:         LOCAL loc_lResultado, loc_nOrdem, loc_oPage
6718:         loc_lResultado = .F.
6719:         TRY
6720:             IF !USED("cursor_4c_Fase")
6721:                 loc_lResultado = loc_lResultado
6722:             ENDIF
6723:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
6724:             SELECT cursor_4c_Fase
6725:             IF !EOF("cursor_4c_Fase")
6726:                 IF EMPTY(cursor_4c_Fase.Grupos)
6727:                     loc_oPage.grd_4c_FasePro.SetFocus()
6728:                     loc_lResultado = loc_lResultado
6729:                 ENDIF
6730:                 loc_nOrdem = cursor_4c_Fase.Ordems
6731:             ELSE
6732:                 loc_nOrdem = 0
6733:             ENDIF
6734:             *-- Incrementa ordens dos registros apos o atual
6735:             SELECT cursor_4c_Fase
6736:             SCAN FOR Ordems > loc_nOrdem
6737:                 REPLACE Ordems WITH cursor_4c_Fase.Ordems + 1 IN cursor_4c_Fase
6738:             ENDSCAN
6739:             *-- Insere nova linha com ordem logo apos o atual
6740:             INSERT INTO cursor_4c_Fase (Ordems, Grupos, Descrs, UniPrdts, TpMats, FkChaves) ;
6741:                 VALUES (loc_nOrdem + 1, "", "", "", "", "")
6742:             GO TOP IN cursor_4c_Fase
6743:             LOCATE FOR Ordems = loc_nOrdem + 1 AND EMPTY(Grupos)
6744:             loc_oPage.grd_4c_FasePro.Refresh()
6745:             loc_oPage.grd_4c_FasePro.SetFocus()
6746:             loc_lResultado = .T.
6747:         CATCH TO loc_oErro
6748:             MsgErro(loc_oErro.Message, "Erro")
6749:         ENDTRY
6750:         RETURN loc_lResultado
6751:     ENDPROC
6752: 
6753:     *--------------------------------------------------------------------------
6754:     * FaseExcluirClick - Exclui linha atual do grd_4c_FasePro
6755:     *--------------------------------------------------------------------------
6756:     PROCEDURE FaseExcluirClick()
6757:         LOCAL loc_lResultado, loc_oPage
6758:         loc_lResultado = .F.
6759:         TRY
6760:             IF !USED("cursor_4c_Fase") OR EOF("cursor_4c_Fase") OR BOF("cursor_4c_Fase")
6761:                 loc_lResultado = loc_lResultado
6762:             ENDIF
6763:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
6764:             SELECT cursor_4c_Fase
6765:             DELETE IN cursor_4c_Fase
6766:             IF !EOF("cursor_4c_Fase")
6767:                 SKIP IN cursor_4c_Fase
6768:             ENDIF
6769:             IF EOF("cursor_4c_Fase")
6770:                 GO BOTTOM IN cursor_4c_Fase
6771:             ENDIF
6772:             PACK IN cursor_4c_Fase
6773:             loc_oPage.grd_4c_FasePro.Refresh()
6774:             loc_oPage.grd_4c_FasePro.SetFocus()
6775:             loc_oPage.grd_4c_FasePro.Column2.SetFocus()
6776:             loc_lResultado = .T.
6777:         CATCH TO loc_oErro
6778:             MsgErro(loc_oErro.Message, "Erro")
6779:         ENDTRY
6780:         RETURN loc_lResultado
6781:     ENDPROC
6782: 
6783:     *--------------------------------------------------------------------------
6784:     * FaseAlternativaClick - Insere fase alternativa (mesma ordem do atual)
6785:     *--------------------------------------------------------------------------
6786:     PROCEDURE FaseAlternativaClick()
6787:         LOCAL loc_lResultado, loc_nOrdem, loc_oPage
6788:         loc_lResultado = .F.
6789:         TRY
6790:             IF !USED("cursor_4c_Fase")
6791:                 loc_lResultado = loc_lResultado
6792:             ENDIF
6793:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
6794:             SELECT cursor_4c_Fase
6795:             IF EOF("cursor_4c_Fase") OR BOF("cursor_4c_Fase")
6796:                 loc_oPage.grd_4c_FasePro.SetFocus()
6797:                 loc_lResultado = loc_lResultado
6798:             ENDIF
6799:             loc_nOrdem = cursor_4c_Fase.Ordems
6800:             *-- Insere linha alternativa com mesma ordem (alternativa ao atual)
6801:             INSERT INTO cursor_4c_Fase (Ordems, Grupos, Descrs, UniPrdts, TpMats, FkChaves) ;
6802:                 VALUES (loc_nOrdem, "", "", "", "", "")
6803:             GO TOP IN cursor_4c_Fase
6804:             LOCATE FOR Ordems = loc_nOrdem AND EMPTY(Grupos)
6805:             loc_oPage.grd_4c_FasePro.Refresh()
6806:             loc_oPage.grd_4c_FasePro.SetFocus()
6807:             loc_lResultado = .T.
6808:         CATCH TO loc_oErro
6809:             MsgErro(loc_oErro.Message, "Erro")
6810:         ENDTRY
6811:         RETURN loc_lResultado
6812:     ENDPROC
6813: 
6814:     *--------------------------------------------------------------------------
6815:     * CmdFichaClick - Abre Ficha Tecnica do produto
6816:     *--------------------------------------------------------------------------
6817:     PROCEDURE CmdFichaClick()
6818:         LOCAL loc_lResultado
6819:         loc_lResultado = .F.
6820:         TRY
6821:             MsgAviso("Ficha T" + CHR(233) + "cnica n" + CHR(227) + "o dispon" + CHR(237) + "vel nesta vers" + CHR(227) + "o.", ;
6822:                 "Ficha T" + CHR(233) + "cnica")
6823:         CATCH TO loc_oErro
6824:             MsgErro(loc_oErro.Message, "Erro")
6825:         ENDTRY
6826:         RETURN loc_lResultado
6827:     ENDPROC
6828: 
6829:     *--------------------------------------------------------------------------
6830:     * FaseGrdCol2Valid - Valid do Column2 (Fase/Grupos) do grd_4c_FasePro
6831:     * Lookup: SigCdGcr (Codigos / Descrs)
6832:     *--------------------------------------------------------------------------
6833:     PROCEDURE FaseGrdCol2Valid(par_nColIndex)
6834:         LOCAL loc_lResultado, loc_oLookup, loc_oGrd, loc_cCodigo, loc_cDescr, loc_lcSQL
6835:         loc_lResultado = .T.
6836:         TRY
6837:             loc_oGrd    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_FasePro
6838:             loc_cCodigo = ALLTRIM(NVL(loc_oGrd.Column2.Text1.Value, ""))
6839:             IF EMPTY(loc_cCodigo)
6840:                 loc_lResultado = loc_lResultado
6841:             ENDIF
6842:             loc_lcSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cCodigo)
6843:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValGcr") <= 0 OR EOF("cursor_4c_ValGcr")
6844:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
6845:                 loc_oLookup.mAddColuna("Codigos", "C" + CHR(243) + "digo",       60)
6846:                 loc_oLookup.mAddColuna("Descrs",  "Descri" + CHR(231) + CHR(227) + "o", 200)
6847:                 loc_oLookup.cTabela     = "SigCdGcr"
6848:                 loc_oLookup.cCampoChave = "Codigos"
6849:                 loc_oLookup.cFiltroIni  = loc_cCodigo
6850:                 loc_oLookup.Show()
6851:                 IF loc_oLookup.this_lSelecionou
6852:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
6853:                     loc_lcSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cCodigo)
6854:                     IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValGcr") > 0 AND !EOF("cursor_4c_ValGcr")
6855:                         loc_cDescr = ALLTRIM(NVL(cursor_4c_ValGcr.Descrs, ""))
6856:                     ELSE
6857:                         loc_cDescr = ""
6858:                     ENDIF
6859:                 ELSE
6860:                     loc_cCodigo = ""
6861:                     loc_cDescr  = ""
6862:                 ENDIF
6863:                 IF USED("cursor_4c_ValGcr")
6864:                     USE IN cursor_4c_ValGcr
6865:                 ENDIF
6866:             ELSE

*-- Linhas 6873 a 7023:
6873:                 SELECT cursor_4c_Fase
6874:                 REPLACE Grupos WITH PADR(loc_cCodigo, 10) IN cursor_4c_Fase
6875:                 REPLACE Descrs WITH PADR(loc_cDescr,  40) IN cursor_4c_Fase
6876:                 loc_oGrd.Column2.Text1.Value = loc_cCodigo
6877:                 loc_oGrd.Column3.Text1.Value = loc_cDescr
6878:             ENDIF
6879:         CATCH TO loc_oErro
6880:             MsgErro(loc_oErro.Message, "Erro")
6881:         ENDTRY
6882:         RETURN loc_lResultado
6883:     ENDPROC
6884: 
6885:     *--------------------------------------------------------------------------
6886:     * FaseGrdCol4Valid - Valid do Column4 (Uni. Produtiva/UniPrdts) do grd_4c_FasePro
6887:     * Lookup: SigCdUpd (UniPrdts) filtrado pelo Grupo atual
6888:     *--------------------------------------------------------------------------
6889:     PROCEDURE FaseGrdCol4Valid(par_nColIndex)
6890:         LOCAL loc_lResultado, loc_oLookup, loc_oGrd, loc_cCodigo, loc_cGrupo, loc_lcSQL
6891:         loc_lResultado = .T.
6892:         TRY
6893:             loc_oGrd    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_FasePro
6894:             loc_cCodigo = ALLTRIM(NVL(loc_oGrd.Column4.Text1.Value, ""))
6895:             IF EMPTY(loc_cCodigo)
6896:                 loc_lResultado = loc_lResultado
6897:             ENDIF
6898:             loc_cGrupo = ""
6899:             IF USED("cursor_4c_Fase") AND !EOF("cursor_4c_Fase")
6900:                 loc_cGrupo = ALLTRIM(cursor_4c_Fase.Grupos)
6901:             ENDIF
6902:             IF !EMPTY(loc_cGrupo)
6903:                 loc_lcSQL = "SELECT UniPrdts FROM SigCdUpd WHERE Codigos = " + EscaparSQL(loc_cGrupo)
6904:             ELSE
6905:                 loc_lcSQL = "SELECT UniPrdts FROM SigCdUpd"
6906:             ENDIF
6907:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValUpd") <= 0
6908:                 IF USED("cursor_4c_ValUpd")
6909:                     USE IN cursor_4c_ValUpd
6910:                 ENDIF
6911:                 loc_lResultado = loc_lResultado
6912:             ENDIF
6913:             SELECT cursor_4c_ValUpd
6914:             LOCATE FOR ALLTRIM(UniPrdts) = loc_cCodigo
6915:             IF EOF("cursor_4c_ValUpd")
6916:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
6917:                 loc_oLookup.mAddColuna("UniPrdts", "Uni. Produtiva", 120)
6918:                 loc_oLookup.cTabela     = "SigCdUpd"
6919:                 loc_oLookup.cCampoChave = "UniPrdts"
6920:                 loc_oLookup.cFiltroIni  = loc_cCodigo
6921:                 loc_oLookup.Show()
6922:                 IF loc_oLookup.this_lSelecionou
6923:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
6924:                 ELSE
6925:                     loc_cCodigo = ""
6926:                 ENDIF
6927:             ENDIF
6928:             IF USED("cursor_4c_ValUpd")
6929:                 USE IN cursor_4c_ValUpd
6930:             ENDIF
6931:             IF USED("cursor_4c_Fase") AND !EOF("cursor_4c_Fase")
6932:                 SELECT cursor_4c_Fase
6933:                 REPLACE UniPrdts WITH PADR(loc_cCodigo, 10) IN cursor_4c_Fase
6934:                 loc_oGrd.Column4.Text1.Value = loc_cCodigo
6935:             ENDIF
6936:         CATCH TO loc_oErro
6937:             MsgErro(loc_oErro.Message, "Erro")
6938:         ENDTRY
6939:         RETURN loc_lResultado
6940:     ENDPROC
6941: 
6942:     *--------------------------------------------------------------------------
6943:     * FaseGrdCol5Valid - Valid do Column5 (Material/TpMats) do grd_4c_FasePro
6944:     * Lookup: SigOpOpt (Cods / Descs)
6945:     *--------------------------------------------------------------------------
6946:     PROCEDURE FaseGrdCol5Valid(par_nColIndex)
6947:         LOCAL loc_lResultado, loc_oLookup, loc_oGrd, loc_cCodigo, loc_lcSQL
6948:         loc_lResultado = .T.
6949:         TRY
6950:             loc_oGrd    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_FasePro
6951:             loc_cCodigo = ALLTRIM(NVL(loc_oGrd.Column5.Text1.Value, ""))
6952:             IF EMPTY(loc_cCodigo)
6953:                 loc_lResultado = loc_lResultado
6954:             ENDIF
6955:             loc_lcSQL = "SELECT Cods, Descs FROM SigOpOpt WHERE Cods = " + EscaparSQL(loc_cCodigo)
6956:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValOpt") <= 0 OR EOF("cursor_4c_ValOpt")
6957:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
6958:                 loc_oLookup.mAddColuna("Cods",  "C" + CHR(243) + "digo",       60)
6959:                 loc_oLookup.mAddColuna("Descs", "Descri" + CHR(231) + CHR(227) + "o", 200)
6960:                 loc_oLookup.cTabela     = "SigOpOpt"
6961:                 loc_oLookup.cCampoChave = "Cods"
6962:                 loc_oLookup.cFiltroIni  = loc_cCodigo
6963:                 loc_oLookup.Show()
6964:                 IF loc_oLookup.this_lSelecionou
6965:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
6966:                 ELSE
6967:                     loc_cCodigo = ""
6968:                 ENDIF
6969:             ENDIF
6970:             IF USED("cursor_4c_ValOpt")
6971:                 USE IN cursor_4c_ValOpt
6972:             ENDIF
6973:             IF USED("cursor_4c_Fase") AND !EOF("cursor_4c_Fase")
6974:                 SELECT cursor_4c_Fase
6975:                 REPLACE TpMats WITH PADR(loc_cCodigo, 3) IN cursor_4c_Fase
6976:                 loc_oGrd.Column5.Text1.Value = loc_cCodigo
6977:             ENDIF
6978:             loc_oGrd.Refresh()
6979:         CATCH TO loc_oErro
6980:             MsgErro(loc_oErro.Message, "Erro")
6981:         ENDTRY
6982:         RETURN loc_lResultado
6983:     ENDPROC
6984: 
6985:     *--------------------------------------------------------------------------
6986:     * ValidarAcabamento - LostFocus do txt_4c_CodAcb
6987:     * Lookup: SigCdAca (Cods / Descrs) -> preenche txt_4c_Dacb
6988:     *--------------------------------------------------------------------------
6989:     PROCEDURE ValidarAcabamento()
6990:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_cDescr, loc_lcSQL
6991:         loc_lResultado = .T.
6992:         TRY
6993:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
6994:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_CodAcb.Value, ""))
6995:             IF EMPTY(loc_cCodigo)
6996:                 loc_oPage.txt_4c_Dacb.Value = ""
6997:                 loc_lResultado = loc_lResultado
6998:             ENDIF
6999:             loc_lcSQL = "SELECT Cods, Descrs FROM SigCdAca WHERE Cods = " + EscaparSQL(loc_cCodigo)
7000:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValAca") <= 0 OR EOF("cursor_4c_ValAca")
7001:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
7002:                 loc_oLookup.mAddColuna("Cods",  "C" + CHR(243) + "digo",       60)
7003:                 loc_oLookup.mAddColuna("Descrs", "Descri" + CHR(231) + CHR(227) + "o", 200)
7004:                 loc_oLookup.cTabela     = "SigCdAca"
7005:                 loc_oLookup.cCampoChave = "Cods"
7006:                 loc_oLookup.cFiltroIni  = loc_cCodigo
7007:                 loc_oLookup.Show()
7008:                 IF loc_oLookup.this_lSelecionou
7009:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
7010:                     loc_lcSQL = "SELECT Cods, Descrs FROM SigCdAca WHERE Cods = " + EscaparSQL(loc_cCodigo)
7011:                     IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValAca") > 0 AND !EOF("cursor_4c_ValAca")
7012:                         loc_cDescr = ALLTRIM(NVL(cursor_4c_ValAca.Descrs, ""))
7013:                     ELSE
7014:                         loc_cDescr = ""
7015:                     ENDIF
7016:                 ELSE
7017:                     loc_cCodigo = ""
7018:                     loc_cDescr  = ""
7019:                 ENDIF
7020:             ELSE
7021:                 loc_cDescr = ALLTRIM(NVL(cursor_4c_ValAca.Descrs, ""))
7022:             ENDIF
7023:             IF USED("cursor_4c_ValAca")

*-- Linhas 7050 a 7073:
7050:                 LOCATE FOR ALLTRIM(conquilhas) = loc_cValor
7051:                 IF EOF("cursor_4c_ValCnq")
7052:                     loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
7053:                     loc_oLookup.mAddColuna("conquilhas", "Conquilhas", 120)
7054:                     loc_oLookup.cTabela     = "SigCdCnq"
7055:                     loc_oLookup.cCampoChave = "conquilhas"
7056:                     loc_oLookup.cFiltroIni  = loc_cValor
7057:                     loc_oLookup.Show()
7058:                     IF loc_oLookup.this_lSelecionou
7059:                         loc_cValor = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
7060:                     ELSE
7061:                         loc_cValor = ""
7062:                     ENDIF
7063:                 ENDIF
7064:                 IF USED("cursor_4c_ValCnq")
7065:                     USE IN cursor_4c_ValCnq
7066:                 ENDIF
7067:             ENDIF
7068:             loc_oPage.txt_4c_Conquilha.Value = loc_cValor
7069:         CATCH TO loc_oErro
7070:             MsgErro(loc_oErro.Message, "Erro")
7071:         ENDTRY
7072:         RETURN loc_lResultado
7073:     ENDPROC

*-- Linhas 7088 a 7112:
7088:             loc_lcSQL = "SELECT Cods FROM SigCdCor WHERE Cods = " + EscaparSQL(loc_cCodigo)
7089:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValCor") <= 0 OR EOF("cursor_4c_ValCor")
7090:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
7091:                 loc_oLookup.mAddColuna("Cods",  "C" + CHR(243) + "digo",       60)
7092:                 loc_oLookup.mAddColuna("Descs", "Descri" + CHR(231) + CHR(227) + "o", 200)
7093:                 loc_oLookup.cTabela     = "SigCdCor"
7094:                 loc_oLookup.cCampoChave = "Cods"
7095:                 loc_oLookup.cFiltroIni  = loc_cCodigo
7096:                 loc_oLookup.Show()
7097:                 IF loc_oLookup.this_lSelecionou
7098:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
7099:                 ELSE
7100:                     loc_cCodigo = ""
7101:                 ENDIF
7102:             ENDIF
7103:             IF USED("cursor_4c_ValCor")
7104:                 USE IN cursor_4c_ValCor
7105:             ENDIF
7106:             loc_oPage.txt_4c_Cor.Value = loc_cCodigo
7107:             loc_oPage.txt_4c_Cor.Refresh()
7108:         CATCH TO loc_oErro
7109:             MsgErro(loc_oErro.Message, "Erro")
7110:         ENDTRY
7111:         RETURN loc_lResultado
7112:     ENDPROC

*-- Linhas 7127 a 7268:
7127:             loc_lcSQL = "SELECT Cods FROM SigCdTam WHERE Cods = " + EscaparSQL(loc_cCodigo)
7128:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValTam") <= 0 OR EOF("cursor_4c_ValTam")
7129:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
7130:                 loc_oLookup.mAddColuna("Cods",  "C" + CHR(243) + "digo",       60)
7131:                 loc_oLookup.mAddColuna("Descs", "Descri" + CHR(231) + CHR(227) + "o", 200)
7132:                 loc_oLookup.cTabela     = "SigCdTam"
7133:                 loc_oLookup.cCampoChave = "Cods"
7134:                 loc_oLookup.cFiltroIni  = loc_cCodigo
7135:                 loc_oLookup.Show()
7136:                 IF loc_oLookup.this_lSelecionou
7137:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
7138:                 ELSE
7139:                     loc_cCodigo = ""
7140:                 ENDIF
7141:             ENDIF
7142:             IF USED("cursor_4c_ValTam")
7143:                 USE IN cursor_4c_ValTam
7144:             ENDIF
7145:             loc_oPage.txt_4c_Tam.Value = loc_cCodigo
7146:             loc_oPage.txt_4c_Tam.Refresh()
7147:         CATCH TO loc_oErro
7148:             MsgErro(loc_oErro.Message, "Erro")
7149:         ENDTRY
7150:         RETURN loc_lResultado
7151:     ENDPROC
7152: 
7153:     *--------------------------------------------------------------------------
7154:     * BtnInsereMtxClick - Insere nova linha no grd_4c_Matrizes
7155:     *--------------------------------------------------------------------------
7156:     PROCEDURE BtnInsereMtxClick()
7157:         LOCAL loc_lResultado, loc_oPage
7158:         loc_lResultado = .F.
7159:         TRY
7160:             IF !USED("cursor_4c_Matrizes")
7161:                 loc_lResultado = loc_lResultado
7162:             ENDIF
7163:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
7164:             SELECT cursor_4c_Matrizes
7165:             *-- Localiza linha vazia (placeholder); se nao houver, insere uma nova
7166:             GO TOP IN cursor_4c_Matrizes
7167:             LOCATE FOR EMPTY(cursor_4c_Matrizes.CMats)
7168:             IF EOF("cursor_4c_Matrizes")
7169:                 INSERT INTO cursor_4c_Matrizes (CMats, Locals, QMatz, CPros, cIdChaves, DPros) ;
7170:                     VALUES ("", "", 0, "", "", "")
7171:             ENDIF
7172:             loc_oPage.grd_4c_Matrizes.Refresh()
7173:             loc_oPage.grd_4c_Matrizes.SetFocus()
7174:             loc_oPage.grd_4c_Matrizes.Column1.SetFocus()
7175:             loc_lResultado = .T.
7176:         CATCH TO loc_oErro
7177:             MsgErro(loc_oErro.Message, "Erro")
7178:         ENDTRY
7179:         RETURN loc_lResultado
7180:     ENDPROC
7181: 
7182:     *--------------------------------------------------------------------------
7183:     * BtnExcluiMtzClick - Exclui linha atual do grd_4c_Matrizes
7184:     * Garante sempre ao menos uma linha vazia no cursor
7185:     *--------------------------------------------------------------------------
7186:     PROCEDURE BtnExcluiMtzClick()
7187:         LOCAL loc_lResultado, loc_oPage
7188:         loc_lResultado = .F.
7189:         TRY
7190:             IF !USED("cursor_4c_Matrizes") OR EOF("cursor_4c_Matrizes")
7191:                 loc_lResultado = loc_lResultado
7192:             ENDIF
7193:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
7194:             SELECT cursor_4c_Matrizes
7195:             DELETE IN cursor_4c_Matrizes
7196:             PACK IN cursor_4c_Matrizes
7197:             *-- Garante sempre ao menos uma linha vazia
7198:             GO TOP IN cursor_4c_Matrizes
7199:             LOCATE FOR EMPTY(cursor_4c_Matrizes.CMats)
7200:             IF EOF("cursor_4c_Matrizes")
7201:                 INSERT INTO cursor_4c_Matrizes (CMats, Locals, QMatz, CPros, cIdChaves, DPros) ;
7202:                     VALUES ("", "", 0, "", "", "")
7203:             ENDIF
7204:             loc_oPage.grd_4c_Matrizes.Refresh()
7205:             loc_oPage.grd_4c_Matrizes.SetFocus()
7206:             loc_oPage.grd_4c_Matrizes.Column1.SetFocus()
7207:             loc_lResultado = .T.
7208:         CATCH TO loc_oErro
7209:             MsgErro(loc_oErro.Message, "Erro")
7210:         ENDTRY
7211:         RETURN loc_lResultado
7212:     ENDPROC
7213: 
7214:     *--------------------------------------------------------------------------
7215:     * MatrizGrdCol1Valid - Valid do Column1 (Matriz/CMats) do grd_4c_Matrizes
7216:     * Lookup: SigCdPro (CPros / DPros) - produto usado como matriz
7217:     *--------------------------------------------------------------------------
7218:     PROCEDURE MatrizGrdCol1Valid(par_nColIndex)
7219:         LOCAL loc_lResultado, loc_oLookup, loc_oGrd, loc_cCodigo, loc_lcSQL
7220:         loc_lResultado = .T.
7221:         TRY
7222:             loc_oGrd    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_Matrizes
7223:             loc_cCodigo = ALLTRIM(NVL(loc_oGrd.Column1.Text1.Value, ""))
7224:             IF EMPTY(loc_cCodigo)
7225:                 loc_lResultado = loc_lResultado
7226:             ENDIF
7227:             loc_lcSQL = "SELECT CPros, DPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCodigo)
7228:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValMtz") <= 0 OR EOF("cursor_4c_ValMtz")
7229:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
7230:                 loc_oLookup.mAddColuna("CPros", "Matriz",                       80)
7231:                 loc_oLookup.mAddColuna("DPros", "Descri" + CHR(231) + CHR(227) + "o", 200)
7232:                 loc_oLookup.cTabela     = "SigCdPro"
7233:                 loc_oLookup.cCampoChave = "CPros"
7234:                 loc_oLookup.cFiltroIni  = loc_cCodigo
7235:                 loc_oLookup.Show()
7236:                 IF loc_oLookup.this_lSelecionou
7237:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
7238:                 ELSE
7239:                     loc_cCodigo = ""
7240:                 ENDIF
7241:             ENDIF
7242:             IF USED("cursor_4c_ValMtz")
7243:                 USE IN cursor_4c_ValMtz
7244:             ENDIF
7245:             IF USED("cursor_4c_Matrizes") AND !EOF("cursor_4c_Matrizes")
7246:                 SELECT cursor_4c_Matrizes
7247:                 REPLACE CMats WITH PADR(loc_cCodigo, 14) IN cursor_4c_Matrizes
7248:                 loc_oGrd.Column1.Text1.Value = loc_cCodigo
7249:                 loc_oGrd.Refresh()
7250:             ENDIF
7251:         CATCH TO loc_oErro
7252:             MsgErro(loc_oErro.Message, "Erro")
7253:         ENDTRY
7254:         RETURN loc_lResultado
7255:     ENDPROC
7256: 
7257:     *--------------------------------------------------------------------------
7258:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
7259:     * par_oContainer: container a processar (Page1, Page2, etc.)
7260:     *--------------------------------------------------------------------------
7261:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
7262:         LOCAL loc_nI, loc_oObjeto, loc_nP
7263: 
7264:         FOR loc_nI = 1 TO par_oContainer.ControlCount
7265:             loc_oObjeto = par_oContainer.Controls(loc_nI)
7266: 
7267:             IF VARTYPE(loc_oObjeto) = "O"
7268:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)

*-- Linhas 7328 a 7379:
7328: 
7329:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados") > 0
7330:                 LOCAL loc_oGrd
7331:                 loc_oGrd = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
7332: 
7333:                 *-- RecordSource FORA de WITH (causa erro se acessar .Column dentro do WITH)
7334:                 loc_oGrd.RecordSource = "cursor_4c_Dados"
7335: 
7336:                 *-- Definir ControlSource (OBRIGATORIO apos RecordSource)
7337:                 loc_oGrd.Column1.ControlSource = "cursor_4c_Dados.cpros"
7338:                 loc_oGrd.Column2.ControlSource = "cursor_4c_Dados.dpros"
7339:                 loc_oGrd.Column3.ControlSource = "cursor_4c_Dados.cgrus"
7340:                 loc_oGrd.Column4.ControlSource = "cursor_4c_Dados.cods"
7341:                 loc_oGrd.Column5.ControlSource = "cursor_4c_Dados.reffs"
7342:                 loc_oGrd.Column6.ControlSource = "cursor_4c_Dados.usuincs"
7343:                 loc_oGrd.Column7.ControlSource = "cursor_4c_Dados.situas"
7344: 
7345:                 *-- Re-aplicar larguras e cabecalhos (RecordSource reseta esses valores)
7346:                 loc_oGrd.Column1.Width = 110
7347:                 loc_oGrd.Column2.Width = 408
7348:                 loc_oGrd.Column3.Width = 40
7349:                 loc_oGrd.Column4.Width = 70
7350:                 loc_oGrd.Column5.Width = 150
7351:                 loc_oGrd.Column6.Width = 100
7352:                 loc_oGrd.Column7.Width = 16
7353:                 loc_oGrd.Column1.Header1.Caption = "Produto"
7354:                 loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
7355:                 loc_oGrd.Column3.Header1.Caption = "Grupo"
7356:                 loc_oGrd.Column4.Header1.Caption = "Subgrp."
7357:                 loc_oGrd.Column5.Header1.Caption = "Ref. Fornecedor"
7358:                 loc_oGrd.Column6.Header1.Caption = "Usu" + CHR(225) + "rio"
7359:                 loc_oGrd.Column7.Header1.Caption = "I"
7360: 
7361:                 THIS.FormatarGridLista(loc_oGrd)
7362:                 THIS.AtualizarContagemProdutos()
7363:                 loc_lResultado = .T.
7364:             ELSE
7365:                 MsgErro(CapturarErroSQL(), "Erro ao carregar produtos")
7366:             ENDIF
7367: 
7368:         CATCH TO loc_oErro
7369:             MsgErro(loc_oErro.Message, "Erro ao carregar lista de produtos")
7370:         ENDTRY
7371: 
7372:         RETURN loc_lResultado
7373:     ENDPROC
7374: 
7375:     *--------------------------------------------------------------------------
7376:     * MontarFiltro - Monta clausula WHERE baseada nos filtros da tela
7377:     *--------------------------------------------------------------------------
7378:     PROTECTED FUNCTION MontarFiltro()
7379:         LOCAL loc_cWhere, loc_cCgru, loc_dDtIni, loc_dDtFim, loc_nSitua

*-- Linhas 7424 a 7451:
7424: 
7425:     *--------------------------------------------------------------------------
7426:     * FormatarGridLista - Formata visual do grid (FontName/Size)
7427:     * RecordSource + ControlSource ja definidos em CarregarLista
7428:     *--------------------------------------------------------------------------
7429:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
7430:         WITH par_oGrid
7431:             IF .ColumnCount > 0
7432:                 .FontName = "Arial"
7433:                 .FontSize = 8
7434:             ENDIF
7435:         ENDWITH
7436:     ENDPROC
7437: 
7438:     *--------------------------------------------------------------------------
7439:     * AtualizarContagemProdutos - Atualiza label de contagem
7440:     *--------------------------------------------------------------------------
7441:     PROTECTED PROCEDURE AtualizarContagemProdutos()
7442:         LOCAL loc_nTotal
7443:         loc_nTotal = 0
7444: 
7445:         TRY
7446:             IF USED("cursor_4c_Dados")
7447:                 loc_nTotal = RECCOUNT("cursor_4c_Dados")
7448:             ENDIF
7449:             THIS.pgf_4c_Paginas.Page1.lbl_4c_Produtos.Caption = ;
7450:                 "Produtos Selecionados : " + TRANSFORM(loc_nTotal)
7451:         CATCH TO loc_oErro

*-- Linhas 7581 a 7606:
7581:         IF USED("cursor_4c_Cmv")
7582:             USE IN cursor_4c_Cmv
7583:         ENDIF
7584:         SET NULL OFF
7585:         CREATE CURSOR cursor_4c_Cmv (datas C(7), valcuss N(10,2), moedas C(3))
7586:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.grd_4c_Dados.Refresh()
7587: 
7588:         IF EMPTY(par_cCpros)
7589:             RETURN
7590:         ENDIF
7591: 
7592:         TRY
7593:             *-- Fase 5+6: colunas corretas de SigCdPro (linhas=linha, colecoes=col.venda)
7594:             loc_cSQL = "SELECT p.dpros, ISNULL(p.dpro2s,'') AS dpro2s, " + ;
7595:                 "ISNULL(p.cbars,'') AS cbars, " + ;
7596:                 "ISNULL(p.cgrus,'') AS cgrus, " + ;
7597:                 "ISNULL(p.linhas,'') AS linhas, " + ;
7598:                 "ISNULL(p.colecoes,'') AS colecoes, " + ;
7599:                 "ISNULL(p.ifors,'') AS ifors, ISNULL(p.reffs,'') AS reffs, " + ;
7600:                 "ISNULL(p.codcors,'') AS codcors, ISNULL(p.codtams,'') AS codtams, " + ;
7601:                 "ISNULL(p.codfinp,'') AS codfinp, ISNULL(p.codacbs,'') AS codacbs, " + ;
7602:                 "ISNULL(p.cclass,'') AS cclass, ISNULL(p.locals,'') AS locals, " + ;
7603:                 "ISNULL(p.cunis,'') AS cunis, ISNULL(p.cunips,'') AS cunips, " + ;
7604:                 "ISNULL(p.moecs,'') AS moecs, ISNULL(p.moepvs,'') AS moepvs, " + ;
7605:                 "ISNULL(p.moevs,'') AS moevs, " + ;
7606:                 "ISNULL(p.custofs,0) AS custofs, ISNULL(p.pvens,0) AS pvens, " + ;

*-- Linhas 8209 a 8255:
8209:                 IF USED("cursor_4c_Cmv")
8210:                     USE IN cursor_4c_Cmv
8211:                 ENDIF
8212:                 SET NULL OFF
8213:                 CREATE CURSOR cursor_4c_Cmv (datas C(7), valcuss N(10,2), moedas C(3))
8214:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CmvTemp") > 0
8215:                     IF !EOF("cursor_4c_CmvTemp")
8216:                         SELECT cursor_4c_CmvTemp
8217:                         GO TOP
8218:                         SCAN
8219:                             LOCAL loc_cDatas, loc_nValcuss, loc_cMoedas
8220:                             loc_cDatas   = ALLTRIM(cursor_4c_CmvTemp.datas)
8221:                             loc_nValcuss = cursor_4c_CmvTemp.valcuss
8222:                             loc_cMoedas  = ALLTRIM(cursor_4c_CmvTemp.moedas)
8223:                             INSERT INTO cursor_4c_Cmv (datas, valcuss, moedas) ;
8224:                                 VALUES (loc_cDatas, loc_nValcuss, loc_cMoedas)
8225:                         ENDSCAN
8226:                     ENDIF
8227:                     IF USED("cursor_4c_CmvTemp")
8228:                         USE IN cursor_4c_CmvTemp
8229:                     ENDIF
8230:                 ENDIF
8231:                 SELECT cursor_4c_Cmv
8232:                 IF RECCOUNT() > 0
8233:                     GO TOP
8234:                 ENDIF
8235:                 loc_oPg3.grd_4c_Dados.Refresh()
8236:             ENDIF
8237: 
8238:         CATCH TO loc_oErro
8239:             MsgErro(loc_oErro.Message, "Erro ao carregar dados fiscais")
8240:         ENDTRY
8241:     ENDPROC
8242: 
8243:     *--------------------------------------------------------------------------
8244:     * HabilitarCampos - Habilita/desabilita campos editaveis conforme modo
8245:     *--------------------------------------------------------------------------
8246:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
8247:         LOCAL loc_oPg, loc_lReadOnly, loc_cBgEdit, loc_cBgRO
8248:         loc_oPg      = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8249:         loc_lReadOnly = !par_lHabilitar
8250:         loc_cBgEdit  = RGB(255, 255, 255)
8251:         loc_cBgRO    = RGB(224, 235, 235)
8252: 
8253:         TRY
8254:             *-- Fase 5: Campos editaveis basicos
8255:             loc_oPg.txt_4c_Cpros.ReadOnly  = loc_lReadOnly

*-- Linhas 8637 a 8676:
8637: 
8638:         TRY
8639:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", "cursor_4c_Busca", "cpros", "", "Busca de Produto")
8640:             loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
8641:             loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
8642:             loc_oBusca.mAddColuna("cgrus", "", "Grupo")
8643:             loc_oBusca.Show()
8644: 
8645:             IF loc_oBusca.this_lSelecionou
8646:                 IF USED("cursor_4c_Busca")
8647:                     SELECT cursor_4c_Busca
8648:                     loc_cCpros = ALLTRIM(cpros)
8649:                     USE IN cursor_4c_Busca
8650:                 ENDIF
8651: 
8652:                 *-- Posiciona grid na linha do produto selecionado
8653:                 IF !EMPTY(loc_cCpros) AND USED("cursor_4c_Dados")
8654:                     SELECT cursor_4c_Dados
8655:                     LOCATE FOR ALLTRIM(cpros) = loc_cCpros
8656:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
8657:                 ENDIF
8658:             ENDIF
8659: 
8660:             IF VARTYPE(loc_oBusca) = "O"
8661:                 loc_oBusca.Release()
8662:                 loc_oBusca = .NULL.
8663:             ENDIF
8664:         CATCH TO loc_oErro
8665:             MsgErro(loc_oErro.Message, "Erro ao procurar produto")
8666:         ENDTRY
8667:     ENDPROC
8668: 
8669:     *--------------------------------------------------------------------------
8670:     * BtnSalvarClick - Acao do botao Salvar
8671:     *--------------------------------------------------------------------------
8672:     PROCEDURE BtnSalvarClick()
8673:         LOCAL loc_oPg
8674: 
8675:         *-- Validar campos obrigatorios
8676:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

*-- Linhas 8947 a 9088:
8947: 
8948:         TRY
8949:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", "cursor_4c_Busca", "cpros", "", "Busca de Produto")
8950:             loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
8951:             loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
8952:             loc_oBusca.mAddColuna("cgrus", "", "Grupo")
8953:             loc_oBusca.Show()
8954: 
8955:             IF loc_oBusca.this_lSelecionou
8956:                 IF USED("cursor_4c_Busca")
8957:                     SELECT cursor_4c_Busca
8958:                     loc_oPg.txt_4c_Cpros.Value = ALLTRIM(cpros)
8959:                     loc_oPg.txt_4c_Dpros.Value = ALLTRIM(dpros)
8960:                     USE IN cursor_4c_Busca
8961:                 ENDIF
8962:             ENDIF
8963: 
8964:             loc_oBusca.Release()
8965:             loc_oBusca = .NULL.
8966:         CATCH TO loc_oErro
8967:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de produto")
8968:         ENDTRY
8969:     ENDPROC
8970: 
8971:     *--------------------------------------------------------------------------
8972:     * AbrirLookupGrupo - Abre busca de grupo (SigCdGrp)
8973:     *--------------------------------------------------------------------------
8974:     PROCEDURE AbrirLookupGrupo()
8975:         LOCAL loc_oBusca, loc_oPg
8976:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8977: 
8978:         TRY
8979:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGrp", "cursor_4c_Busca", "cgrus", "", "Busca de Grupo")
8980:             loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
8981:             loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
8982:             loc_oBusca.Show()
8983: 
8984:             IF loc_oBusca.this_lSelecionou
8985:                 IF USED("cursor_4c_Busca")
8986:                     SELECT cursor_4c_Busca
8987:                     loc_oPg.txt_4c_Cgrus.Value       = ALLTRIM(cgrus)
8988:                     loc_oPg.txt_4c_DgruDisplay.Value = ALLTRIM(dgrus)
8989:                     USE IN cursor_4c_Busca
8990:                 ENDIF
8991:             ENDIF
8992: 
8993:             loc_oBusca.Release()
8994:             loc_oBusca = .NULL.
8995:         CATCH TO loc_oErro
8996:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de grupo")
8997:         ENDTRY
8998:     ENDPROC
8999: 
9000:     *--------------------------------------------------------------------------
9001:     * AbrirLookupLin - Abre busca de linha (SigCdLin)
9002:     *--------------------------------------------------------------------------
9003:     PROCEDURE AbrirLookupLin()
9004:         LOCAL loc_oBusca, loc_oPg
9005:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9006: 
9007:         TRY
9008:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdLin", "cursor_4c_Busca", "clins", "", "Busca de Linha")
9009:             loc_oBusca.mAddColuna("clins", "", "C" + CHR(243) + "digo")
9010:             loc_oBusca.mAddColuna("dlins", "", "Descri" + CHR(231) + CHR(227) + "o")
9011:             loc_oBusca.Show()
9012: 
9013:             IF loc_oBusca.this_lSelecionou
9014:                 IF USED("cursor_4c_Busca")
9015:                     SELECT cursor_4c_Busca
9016:                     loc_oPg.txt_4c_Lin.Value          = ALLTRIM(clins)
9017:                     loc_oPg.txt_4c_DLinDisplay.Value  = ALLTRIM(dlins)
9018:                     USE IN cursor_4c_Busca
9019:                 ENDIF
9020:             ENDIF
9021: 
9022:             loc_oBusca.Release()
9023:             loc_oBusca = .NULL.
9024:         CATCH TO loc_oErro
9025:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de linha")
9026:         ENDTRY
9027:     ENDPROC
9028: 
9029:     *--------------------------------------------------------------------------
9030:     * AbrirLookupCol - Abre busca de grupo de venda (SigCdCol)
9031:     *--------------------------------------------------------------------------
9032:     PROCEDURE AbrirLookupCol()
9033:         LOCAL loc_oBusca, loc_oPg
9034:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9035: 
9036:         TRY
9037:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCol", "cursor_4c_Busca", "ccols", "", "Busca de Grupo de Venda")
9038:             loc_oBusca.mAddColuna("ccols", "", "C" + CHR(243) + "digo")
9039:             loc_oBusca.mAddColuna("dcols", "", "Descri" + CHR(231) + CHR(227) + "o")
9040:             loc_oBusca.Show()
9041: 
9042:             IF loc_oBusca.this_lSelecionou
9043:                 IF USED("cursor_4c_Busca")
9044:                     SELECT cursor_4c_Busca
9045:                     loc_oPg.txt_4c_Col.Value          = ALLTRIM(ccols)
9046:                     loc_oPg.txt_4c_DColDisplay.Value  = ALLTRIM(dcols)
9047:                     USE IN cursor_4c_Busca
9048:                 ENDIF
9049:             ENDIF
9050: 
9051:             loc_oBusca.Release()
9052:             loc_oBusca = .NULL.
9053:         CATCH TO loc_oErro
9054:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de grupo de venda")
9055:         ENDTRY
9056:     ENDPROC
9057: 
9058:     *--------------------------------------------------------------------------
9059:     * AbrirLookupIfor - Abre busca de fornecedor (SigCdCli)
9060:     *--------------------------------------------------------------------------
9061:     PROCEDURE AbrirLookupIfor()
9062:         LOCAL loc_oBusca, loc_oPg
9063:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9064: 
9065:         TRY
9066:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", "cursor_4c_Busca", "Iclis", "", "Busca de Fornecedor")
9067:             loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
9068:             loc_oBusca.mAddColuna("Rclis", "", "Nome")
9069:             loc_oBusca.Show()
9070: 
9071:             IF loc_oBusca.this_lSelecionou
9072:                 IF USED("cursor_4c_Busca")
9073:                     SELECT cursor_4c_Busca
9074:                     loc_oPg.txt_4c_Ifor.Value         = ALLTRIM(Iclis)
9075:                     loc_oPg.txt_4c_DforDisplay.Value  = ALLTRIM(Rclis)
9076:                     USE IN cursor_4c_Busca
9077:                 ENDIF
9078:             ENDIF
9079: 
9080:             loc_oBusca.Release()
9081:             loc_oBusca = .NULL.
9082:         CATCH TO loc_oErro
9083:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de fornecedor")
9084:         ENDTRY
9085:     ENDPROC
9086: 
9087:     *==========================================================================
9088:     * HANDLERS DE KEYPRESS - FASE 6 (novos campos com lookup)

*-- Linhas 9445 a 9469:
9445:         ENDCASE
9446:         TRY
9447:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
9448:             loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo", .T.)
9449:             loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o", .F.)
9450:             loc_oBusca.this_cTabela    = "SigCdMoe"
9451:             loc_oBusca.this_cCampoBusca = "cmoes"
9452:             loc_oBusca.this_cValorInicial = ALLTRIM(loc_oTxt.Value)
9453:             loc_oBusca.Show()
9454:             IF loc_oBusca.this_lSelecionou
9455:                 loc_oTxt.Value = ALLTRIM(loc_oBusca.this_cCodigoSelecionado)
9456:             ENDIF
9457:             IF USED("cursor_4c_BuscaAuxMoe")
9458:                 USE IN cursor_4c_BuscaAuxMoe
9459:             ENDIF
9460:             loc_oBusca.Release()
9461:         CATCH TO loc_oErro
9462:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de moeda")
9463:         ENDTRY
9464:     ENDPROC
9465: 
9466:     *--------------------------------------------------------------------------
9467:     * CalcPrecoComposicao - Recalcula precos baseado nos valores de custo/margem
9468:     * Equivalente ao CalcPreco/CalcPreMoe do legado (stub - logica completa no BO)
9469:     *--------------------------------------------------------------------------

*-- Linhas 9506 a 9529:
9506:         LOCAL loc_oPg, loc_nBtn, loc_oGrd
9507:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9508:         loc_nBtn = loc_oPg.obj_4c_CmdgCompo.Value
9509:         loc_oGrd = loc_oPg.grd_4c_Compo
9510: 
9511:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9512:             RETURN
9513:         ENDIF
9514: 
9515:         DO CASE
9516:         CASE loc_nBtn = 1
9517:             *-- Inserir item de composicao
9518:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9519:                 MsgAviso("Selecione o modo Incluir ou Alterar para inserir itens.", "Aten" + CHR(231) + CHR(227) + "o")
9520:                 RETURN
9521:             ENDIF
9522:             IF USED("cursor_4c_Compo")
9523:                 SELECT cursor_4c_Compo
9524:                 APPEND BLANK
9525:                 loc_oGrd.Refresh()
9526:             ENDIF
9527: 
9528:         CASE loc_nBtn = 2
9529:             *-- Excluir item de composicao

*-- Linhas 9565 a 9588:
9565:         LOCAL loc_oPg, loc_nBtn, loc_oGrd
9566:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9567:         loc_nBtn = loc_oPg.obj_4c_CmdgSubCp.Value
9568:         loc_oGrd = loc_oPg.grd_4c_SubCp
9569: 
9570:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9571:             RETURN
9572:         ENDIF
9573: 
9574:         DO CASE
9575:         CASE loc_nBtn = 1
9576:             *-- Inserir item de sub-composicao
9577:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9578:                 MsgAviso("Selecione o modo Incluir ou Alterar para inserir itens.", "Aten" + CHR(231) + CHR(227) + "o")
9579:                 RETURN
9580:             ENDIF
9581:             IF USED("cursor_4c_SubCp")
9582:                 SELECT cursor_4c_SubCp
9583:                 APPEND BLANK
9584:                 loc_oGrd.Refresh()
9585:             ENDIF
9586: 
9587:         CASE loc_nBtn = 2
9588:             *-- Excluir item de sub-composicao

*-- Linhas 9648 a 9671:
9648:         LOCAL loc_oPg, loc_nBtn, loc_oGrd
9649:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
9650:         loc_nBtn = loc_oPg.obj_4c_CmdgCusto.Value
9651:         loc_oGrd = loc_oPg.grd_4c_CustoCompo
9652: 
9653:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9654:             RETURN
9655:         ENDIF
9656: 
9657:         DO CASE
9658:         CASE loc_nBtn = 1
9659:             *-- Inserir item de composicao custo
9660:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9661:                 MsgAviso("Selecione o modo Incluir ou Alterar para inserir itens.", "Aten" + CHR(231) + CHR(227) + "o")
9662:                 RETURN
9663:             ENDIF
9664:             IF USED("cursor_4c_CustoCompo")
9665:                 SELECT cursor_4c_CustoCompo
9666:                 APPEND BLANK
9667:                 loc_oGrd.Refresh()
9668:             ENDIF
9669: 
9670:         CASE loc_nBtn = 2
9671:             *-- Excluir item de composicao custo

*-- Linhas 9702 a 9725:
9702:         IF USED("cursor_4c_CustoCompo")
9703:             GO TOP IN cursor_4c_CustoCompo
9704:         ENDIF
9705:         loc_oPg.grd_4c_CustoCompo.Refresh()
9706:     ENDPROC
9707: 
9708:     *==========================================================================
9709:     * VALIDACOES - FASE 6
9710:     *==========================================================================
9711: 
9712:     *--------------------------------------------------------------------------
9713:     * ValidarCor - Valida e carrega tooltip da cor (SigCdCor)
9714:     *--------------------------------------------------------------------------
9715:     PROTECTED PROCEDURE ValidarCor()
9716:         LOCAL loc_cCodCor, loc_oPg
9717:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9718:         loc_cCodCor = ALLTRIM(loc_oPg.txt_4c_Cor.Value)
9719:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9720:             RETURN
9721:         ENDIF
9722:         THIS.CarregarDescCor(loc_cCodCor)
9723:     ENDPROC
9724: 
9725:     *--------------------------------------------------------------------------

*-- Linhas 9863 a 10165:
9863:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9864:                 "SigCdCor", "cursor_4c_BuscaCor", "cods", ;
9865:                 ALLTRIM(loc_oPg.txt_4c_Cor.Value), "Busca de Cor")
9866:             loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
9867:             loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9868:             loc_oBusca.Show()
9869:             IF loc_oBusca.this_lSelecionou
9870:                 IF USED("cursor_4c_BuscaCor")
9871:                     SELECT cursor_4c_BuscaCor
9872:                     loc_oPg.txt_4c_Cor.Value = ALLTRIM(cods)
9873:                     USE IN cursor_4c_BuscaCor
9874:                 ENDIF
9875:             ENDIF
9876:             loc_oBusca.Release()
9877:             loc_oBusca = .NULL.
9878:         CATCH TO loc_oErro
9879:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de cor")
9880:         ENDTRY
9881:     ENDPROC
9882: 
9883:     *--------------------------------------------------------------------------
9884:     * AbrirLookupTam - Abre busca de tamanho (SigCdTam)
9885:     *--------------------------------------------------------------------------
9886:     PROCEDURE AbrirLookupTam()
9887:         LOCAL loc_oBusca, loc_oPg
9888:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9889:         TRY
9890:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9891:                 "SigCdTam", "cursor_4c_BuscaTam", "cods", ;
9892:                 ALLTRIM(loc_oPg.txt_4c_Tam.Value), "Busca de Tamanho")
9893:             loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
9894:             loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9895:             loc_oBusca.Show()
9896:             IF loc_oBusca.this_lSelecionou
9897:                 IF USED("cursor_4c_BuscaTam")
9898:                     SELECT cursor_4c_BuscaTam
9899:                     loc_oPg.txt_4c_Tam.Value = ALLTRIM(cods)
9900:                     USE IN cursor_4c_BuscaTam
9901:                 ENDIF
9902:             ENDIF
9903:             loc_oBusca.Release()
9904:             loc_oBusca = .NULL.
9905:         CATCH TO loc_oErro
9906:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de tamanho")
9907:         ENDTRY
9908:     ENDPROC
9909: 
9910:     *--------------------------------------------------------------------------
9911:     * AbrirLookupFinP - Abre busca de ficha de produto (SigCdFip)
9912:     *--------------------------------------------------------------------------
9913:     PROCEDURE AbrirLookupFinP()
9914:         LOCAL loc_oBusca, loc_oPg
9915:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9916:         TRY
9917:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9918:                 "SigCdFip", "cursor_4c_BuscaFinP", "cods", ;
9919:                 ALLTRIM(loc_oPg.txt_4c_CodFinP.Value), "Busca de Ficha")
9920:             loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
9921:             loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9922:             loc_oBusca.Show()
9923:             IF loc_oBusca.this_lSelecionou
9924:                 IF USED("cursor_4c_BuscaFinP")
9925:                     SELECT cursor_4c_BuscaFinP
9926:                     loc_oPg.txt_4c_CodFinP.Value  = ALLTRIM(cods)
9927:                     loc_oPg.txt_4c_DesFinP.Value  = ALLTRIM(descs)
9928:                     USE IN cursor_4c_BuscaFinP
9929:                 ENDIF
9930:             ENDIF
9931:             loc_oBusca.Release()
9932:             loc_oBusca = .NULL.
9933:         CATCH TO loc_oErro
9934:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de ficha")
9935:         ENDTRY
9936:     ENDPROC
9937: 
9938:     *--------------------------------------------------------------------------
9939:     * AbrirLookupAcb - Abre busca de acabamento (SigCdAca)
9940:     *--------------------------------------------------------------------------
9941:     PROCEDURE AbrirLookupAcb()
9942:         LOCAL loc_oBusca, loc_oPg
9943:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9944:         TRY
9945:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9946:                 "SigCdAca", "cursor_4c_BuscaAcb", "cods", ;
9947:                 ALLTRIM(loc_oPg.txt_4c_CodAcb.Value), "Busca de Acabamento")
9948:             loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
9949:             loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
9950:             loc_oBusca.Show()
9951:             IF loc_oBusca.this_lSelecionou
9952:                 IF USED("cursor_4c_BuscaAcb")
9953:                     SELECT cursor_4c_BuscaAcb
9954:                     loc_oPg.txt_4c_CodAcb.Value       = ALLTRIM(cods)
9955:                     loc_oPg.txt_4c_DacbDisplay.Value  = ALLTRIM(descrs)
9956:                     USE IN cursor_4c_BuscaAcb
9957:                 ENDIF
9958:             ENDIF
9959:             loc_oBusca.Release()
9960:             loc_oBusca = .NULL.
9961:         CATCH TO loc_oErro
9962:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de acabamento")
9963:         ENDTRY
9964:     ENDPROC
9965: 
9966:     *--------------------------------------------------------------------------
9967:     * AbrirLookupClass - Abre busca de classificacao (SIGCDCLS)
9968:     *--------------------------------------------------------------------------
9969:     PROCEDURE AbrirLookupClass()
9970:         LOCAL loc_oBusca, loc_oPg
9971:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9972:         TRY
9973:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9974:                 "SIGCDCLS", "cursor_4c_BuscaClass", "cods", ;
9975:                 ALLTRIM(loc_oPg.txt_4c_Class.Value), ;
9976:                 "Busca de Classifica" + CHR(231) + CHR(227) + "o")
9977:             loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
9978:             loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9979:             loc_oBusca.Show()
9980:             IF loc_oBusca.this_lSelecionou
9981:                 IF USED("cursor_4c_BuscaClass")
9982:                     SELECT cursor_4c_BuscaClass
9983:                     loc_oPg.txt_4c_Class.Value         = ALLTRIM(cods)
9984:                     loc_oPg.txt_4c_DClassDisplay.Value = ALLTRIM(descs)
9985:                     USE IN cursor_4c_BuscaClass
9986:                 ENDIF
9987:             ENDIF
9988:             loc_oBusca.Release()
9989:             loc_oBusca = .NULL.
9990:         CATCH TO loc_oErro
9991:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de classifica" + CHR(231) + CHR(227) + "o")
9992:         ENDTRY
9993:     ENDPROC
9994: 
9995:     *--------------------------------------------------------------------------
9996:     * AbrirLookupLocal - Abre busca de local (SigPrLcl)
9997:     *--------------------------------------------------------------------------
9998:     PROCEDURE AbrirLookupLocal()
9999:         LOCAL loc_oBusca, loc_oPg
10000:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
10001:         TRY
10002:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10003:                 "SigPrLcl", "cursor_4c_BuscaLocal", "codigos", ;
10004:                 ALLTRIM(loc_oPg.txt_4c_Local.Value), "Busca de Local")
10005:             loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
10006:             loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10007:             loc_oBusca.Show()
10008:             IF loc_oBusca.this_lSelecionou
10009:                 IF USED("cursor_4c_BuscaLocal")
10010:                     SELECT cursor_4c_BuscaLocal
10011:                     loc_oPg.txt_4c_Local.Value = ALLTRIM(codigos)
10012:                     USE IN cursor_4c_BuscaLocal
10013:                 ENDIF
10014:             ENDIF
10015:             loc_oBusca.Release()
10016:             loc_oBusca = .NULL.
10017:         CATCH TO loc_oErro
10018:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de local")
10019:         ENDTRY
10020:     ENDPROC
10021: 
10022:     *--------------------------------------------------------------------------
10023:     * AbrirLookupUni - Abre busca de unidade (SigCdUni) para campo Cuni
10024:     *--------------------------------------------------------------------------
10025:     PROCEDURE AbrirLookupUni()
10026:         LOCAL loc_oBusca, loc_oPg
10027:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
10028:         TRY
10029:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10030:                 "SigCdUni", "cursor_4c_BuscaUni", "cunis", ;
10031:                 ALLTRIM(loc_oPg.txt_4c_Cuni.Value), "Busca de Unidade")
10032:             loc_oBusca.mAddColuna("cunis", "", "C" + CHR(243) + "digo")
10033:             loc_oBusca.mAddColuna("dunis", "", "Descri" + CHR(231) + CHR(227) + "o")
10034:             loc_oBusca.Show()
10035:             IF loc_oBusca.this_lSelecionou
10036:                 IF USED("cursor_4c_BuscaUni")
10037:                     SELECT cursor_4c_BuscaUni
10038:                     loc_oPg.txt_4c_Cuni.Value          = ALLTRIM(cunis)
10039:                     loc_oPg.txt_4c_DuniDisplay.Value   = ALLTRIM(dunis)
10040:                     USE IN cursor_4c_BuscaUni
10041:                 ENDIF
10042:             ENDIF
10043:             loc_oBusca.Release()
10044:             loc_oBusca = .NULL.
10045:         CATCH TO loc_oErro
10046:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de unidade")
10047:         ENDTRY
10048:     ENDPROC
10049: 
10050:     *--------------------------------------------------------------------------
10051:     * AbrirLookupUniP - Abre busca de unidade de pedido (SigCdUni) para campo Cunip
10052:     *--------------------------------------------------------------------------
10053:     PROCEDURE AbrirLookupUniP()
10054:         LOCAL loc_oBusca, loc_oPg
10055:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
10056:         TRY
10057:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10058:                 "SigCdUni", "cursor_4c_BuscaUniP", "cunis", ;
10059:                 ALLTRIM(loc_oPg.txt_4c_Cunip.Value), "Busca de Uni.Pedido")
10060:             loc_oBusca.mAddColuna("cunis", "", "C" + CHR(243) + "digo")
10061:             loc_oBusca.mAddColuna("dunis", "", "Descri" + CHR(231) + CHR(227) + "o")
10062:             loc_oBusca.Show()
10063:             IF loc_oBusca.this_lSelecionou
10064:                 IF USED("cursor_4c_BuscaUniP")
10065:                     SELECT cursor_4c_BuscaUniP
10066:                     loc_oPg.txt_4c_Cunip.Value          = ALLTRIM(cunis)
10067:                     loc_oPg.txt_4c_DunipDisplay.Value   = ALLTRIM(dunis)
10068:                     USE IN cursor_4c_BuscaUniP
10069:                 ENDIF
10070:             ENDIF
10071:             loc_oBusca.Release()
10072:             loc_oBusca = .NULL.
10073:         CATCH TO loc_oErro
10074:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de unidade de pedido")
10075:         ENDTRY
10076:     ENDPROC
10077: 
10078:     *--------------------------------------------------------------------------
10079:     * AbrirLookupMctotal - Abre busca de moeda custo (SigCdMoe)
10080:     *--------------------------------------------------------------------------
10081:     PROCEDURE AbrirLookupMctotal()
10082:         LOCAL loc_oBusca, loc_oPg
10083:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
10084:         TRY
10085:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10086:                 "SigCdMoe", "cursor_4c_BuscaMoe", "cmoes", ;
10087:                 ALLTRIM(loc_oPg.txt_4c_Mctotal.Value), "Busca de Moeda (Custo)")
10088:             loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
10089:             loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
10090:             loc_oBusca.Show()
10091:             IF loc_oBusca.this_lSelecionou
10092:                 IF USED("cursor_4c_BuscaMoe")
10093:                     SELECT cursor_4c_BuscaMoe
10094:                     loc_oPg.txt_4c_Mctotal.Value = ALLTRIM(cmoes)
10095:                     THIS.CarregarDescMoe(ALLTRIM(cmoes), "total")
10096:                     USE IN cursor_4c_BuscaMoe
10097:                 ENDIF
10098:             ENDIF
10099:             loc_oBusca.Release()
10100:             loc_oBusca = .NULL.
10101:         CATCH TO loc_oErro
10102:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de moeda")
10103:         ENDTRY
10104:     ENDPROC
10105: 
10106:     *--------------------------------------------------------------------------
10107:     * AbrirLookupMpvenda - Abre busca de moeda P.Venda (SigCdMoe)
10108:     *--------------------------------------------------------------------------
10109:     PROCEDURE AbrirLookupMpvenda()
10110:         LOCAL loc_oBusca, loc_oPg
10111:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
10112:         TRY
10113:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10114:                 "SigCdMoe", "cursor_4c_BuscaMoe", "cmoes", ;
10115:                 ALLTRIM(loc_oPg.txt_4c_Mpvenda.Value), "Busca de Moeda (P.Venda)")
10116:             loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
10117:             loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
10118:             loc_oBusca.Show()
10119:             IF loc_oBusca.this_lSelecionou
10120:                 IF USED("cursor_4c_BuscaMoe")
10121:                     SELECT cursor_4c_BuscaMoe
10122:                     loc_oPg.txt_4c_Mpvenda.Value = ALLTRIM(cmoes)
10123:                     THIS.CarregarDescMoe(ALLTRIM(cmoes), "pvenda")
10124:                     USE IN cursor_4c_BuscaMoe
10125:                 ENDIF
10126:             ENDIF
10127:             loc_oBusca.Release()
10128:             loc_oBusca = .NULL.
10129:         CATCH TO loc_oErro
10130:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de moeda")
10131:         ENDTRY
10132:     ENDPROC
10133: 
10134:     *--------------------------------------------------------------------------
10135:     * AbrirLookupMfvenda - Abre busca de moeda F.Venda (SigCdMoe)
10136:     *--------------------------------------------------------------------------
10137:     PROCEDURE AbrirLookupMfvenda()
10138:         LOCAL loc_oBusca, loc_oPg
10139:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
10140:         TRY
10141:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10142:                 "SigCdMoe", "cursor_4c_BuscaMoe", "cmoes", ;
10143:                 ALLTRIM(loc_oPg.txt_4c_Mfvenda.Value), "Busca de Moeda (F.Venda)")
10144:             loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
10145:             loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
10146:             loc_oBusca.Show()
10147:             IF loc_oBusca.this_lSelecionou
10148:                 IF USED("cursor_4c_BuscaMoe")
10149:                     SELECT cursor_4c_BuscaMoe
10150:                     loc_oPg.txt_4c_Mfvenda.Value = ALLTRIM(cmoes)
10151:                     THIS.CarregarDescMoe(ALLTRIM(cmoes), "fvenda")
10152:                     USE IN cursor_4c_BuscaMoe
10153:                 ENDIF
10154:             ENDIF
10155:             loc_oBusca.Release()
10156:             loc_oBusca = .NULL.
10157:         CATCH TO loc_oErro
10158:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de moeda")
10159:         ENDTRY
10160:     ENDPROC
10161: 
10162:     *==========================================================================
10163:     * HANDLERS - FASE 13: pgDadosFiscais
10164:     *==========================================================================
10165: 

*-- Linhas 10194 a 10218:
10194:             loc_lcSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10195:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValGruccus") <= 0 OR EOF("cursor_4c_ValGruccus")
10196:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
10197:                 loc_oLookup.mAddColuna("Codigos", "C" + CHR(243) + "digo",       80)
10198:                 loc_oLookup.mAddColuna("Descrs",  "Descri" + CHR(231) + CHR(227) + "o", 200)
10199:                 loc_oLookup.cTabela     = "SigCdGcr"
10200:                 loc_oLookup.cCampoChave = "Codigos"
10201:                 loc_oLookup.cFiltroIni  = loc_cCodigo
10202:                 loc_oLookup.Show()
10203:                 IF loc_oLookup.this_lSelecionou
10204:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
10205:                 ELSE
10206:                     loc_cCodigo = ""
10207:                 ENDIF
10208:             ELSE
10209:                 SELECT cursor_4c_ValGruccus
10210:                 loc_oPage.txt_4c_Dgruccus.Value = ALLTRIM(Descrs)
10211:             ENDIF
10212:             IF USED("cursor_4c_ValGruccus")
10213:                 USE IN cursor_4c_ValGruccus
10214:             ENDIF
10215:             IF !EMPTY(loc_cCodigo)
10216:                 loc_oPage.txt_4c_Gruccus.Value = loc_cCodigo
10217:                 loc_oPage.txt_4c_Gruccus.Refresh()
10218:                 *-- Recarregar descricao se veio do lookup

*-- Linhas 10247 a 10271:
10247:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10248:                 "SigCdGcr", "cursor_4c_BuscaGruccus", "Codigos", ;
10249:                 ALLTRIM(loc_oPg.txt_4c_Gruccus.Value), "Busca de Grupo C.C.")
10250:             loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
10251:             loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
10252:             loc_oBusca.Show()
10253:             IF loc_oBusca.this_lSelecionou
10254:                 IF USED("cursor_4c_BuscaGruccus")
10255:                     SELECT cursor_4c_BuscaGruccus
10256:                     loc_oPg.txt_4c_Gruccus.Value  = ALLTRIM(Codigos)
10257:                     loc_oPg.txt_4c_Dgruccus.Value = ALLTRIM(Descrs)
10258:                     USE IN cursor_4c_BuscaGruccus
10259:                 ENDIF
10260:             ENDIF
10261:             loc_oBusca.Release()
10262:             loc_oBusca = .NULL.
10263:         CATCH TO loc_oErro
10264:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de grupo C.C.")
10265:         ENDTRY
10266:     ENDPROC
10267: 
10268:     *--------------------------------------------------------------------------
10269:     * TxtDgruccusKeyPress - KeyPress em txt_4c_Dgruccus (F4 abre lookup por descricao)
10270:     *--------------------------------------------------------------------------
10271:     PROCEDURE TxtDgruccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 10284 a 10308:
10284:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10285:                 "SigCdGcr", "cursor_4c_BuscaGruccus", "Descrs", ;
10286:                 ALLTRIM(loc_oPg.txt_4c_Dgruccus.Value), "Busca de Grupo C.C.")
10287:             loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
10288:             loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
10289:             loc_oBusca.Show()
10290:             IF loc_oBusca.this_lSelecionou
10291:                 IF USED("cursor_4c_BuscaGruccus")
10292:                     SELECT cursor_4c_BuscaGruccus
10293:                     loc_oPg.txt_4c_Gruccus.Value  = ALLTRIM(Codigos)
10294:                     loc_oPg.txt_4c_Dgruccus.Value = ALLTRIM(Descrs)
10295:                     USE IN cursor_4c_BuscaGruccus
10296:                 ENDIF
10297:             ENDIF
10298:             loc_oBusca.Release()
10299:             loc_oBusca = .NULL.
10300:         CATCH TO loc_oErro
10301:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de grupo C.C.")
10302:         ENDTRY
10303:     ENDPROC
10304: 
10305:     *--------------------------------------------------------------------------
10306:     * TxtContaccusKeyPress - KeyPress em txt_4c_Contaccus (F4 abre lookup SigCdCli)
10307:     *--------------------------------------------------------------------------
10308:     PROCEDURE TxtContaccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 10370 a 10394:
10370:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10371:                 "SigCdCli", "cursor_4c_BuscaContaccus", "IClis", ;
10372:                 ALLTRIM(loc_oPg.txt_4c_Contaccus.Value), "Busca de Conta C.C.")
10373:             loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
10374:             loc_oBusca.mAddColuna("Rclis", "", "Nome")
10375:             loc_oBusca.Show()
10376:             IF loc_oBusca.this_lSelecionou
10377:                 IF USED("cursor_4c_BuscaContaccus")
10378:                     SELECT cursor_4c_BuscaContaccus
10379:                     loc_oPg.txt_4c_Contaccus.Value  = ALLTRIM(IClis)
10380:                     loc_oPg.txt_4c_Dcontaccus.Value = ALLTRIM(Rclis)
10381:                     USE IN cursor_4c_BuscaContaccus
10382:                 ENDIF
10383:             ENDIF
10384:             loc_oBusca.Release()
10385:             loc_oBusca = .NULL.
10386:         CATCH TO loc_oErro
10387:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de conta C.C.")
10388:         ENDTRY
10389:     ENDPROC
10390: 
10391:     *--------------------------------------------------------------------------
10392:     * TxtDcontaccusKeyPress - KeyPress em txt_4c_Dcontaccus (F4 abre lookup por nome)
10393:     *--------------------------------------------------------------------------
10394:     PROCEDURE TxtDcontaccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 10407 a 10431:
10407:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10408:                 "SigCdCli", "cursor_4c_BuscaContaccus", "Rclis", ;
10409:                 ALLTRIM(loc_oPg.txt_4c_Dcontaccus.Value), "Busca de Conta C.C.")
10410:             loc_oBusca.mAddColuna("Rclis", "", "Nome")
10411:             loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
10412:             loc_oBusca.Show()
10413:             IF loc_oBusca.this_lSelecionou
10414:                 IF USED("cursor_4c_BuscaContaccus")
10415:                     SELECT cursor_4c_BuscaContaccus
10416:                     loc_oPg.txt_4c_Contaccus.Value  = ALLTRIM(IClis)
10417:                     loc_oPg.txt_4c_Dcontaccus.Value = ALLTRIM(Rclis)
10418:                     USE IN cursor_4c_BuscaContaccus
10419:                 ENDIF
10420:             ENDIF
10421:             loc_oBusca.Release()
10422:             loc_oBusca = .NULL.
10423:         CATCH TO loc_oErro
10424:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de conta C.C.")
10425:         ENDTRY
10426:     ENDPROC
10427: 
10428:     *--------------------------------------------------------------------------
10429:     * TxtClfiscalKeyPress - KeyPress em txt_4c_Clfiscal (F4 abre lookup SigCdClf)
10430:     *--------------------------------------------------------------------------
10431:     PROCEDURE TxtClfiscalKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 10454 a 10478:
10454:             loc_lcSQL = "SELECT Codigos, Descricaos FROM SigCdClf WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10455:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValClf") <= 0 OR EOF("cursor_4c_ValClf")
10456:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
10457:                 loc_oLookup.mAddColuna("Codigos",    "C" + CHR(243) + "digo",       100)
10458:                 loc_oLookup.mAddColuna("Descricaos", "Descri" + CHR(231) + CHR(227) + "o", 300)
10459:                 loc_oLookup.cTabela     = "SigCdClf"
10460:                 loc_oLookup.cCampoChave = "Codigos"
10461:                 loc_oLookup.cFiltroIni  = loc_cCodigo
10462:                 loc_oLookup.Show()
10463:                 IF loc_oLookup.this_lSelecionou
10464:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
10465:                 ELSE
10466:                     loc_cCodigo = ""
10467:                 ENDIF
10468:             ELSE
10469:                 SELECT cursor_4c_ValClf
10470:                 loc_oPage.txt_4c_Dclfiscal.Value = ALLTRIM(Descricaos)
10471:             ENDIF
10472:             IF USED("cursor_4c_ValClf")
10473:                 USE IN cursor_4c_ValClf
10474:             ENDIF
10475:             loc_oPage.txt_4c_Clfiscal.Value = loc_cCodigo
10476:             IF !EMPTY(loc_cCodigo) AND EMPTY(loc_oPage.txt_4c_Dclfiscal.Value)
10477:                 *-- Recarregar descricao apos lookup
10478:                 loc_lcSQL = "SELECT Descricaos FROM SigCdClf WHERE Codigos = " + EscaparSQL(loc_cCodigo)

*-- Linhas 10502 a 10526:
10502:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10503:                 "SigCdClf", "cursor_4c_BuscaClf", "Codigos", ;
10504:                 ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value), "Busca de Classifica" + CHR(231) + CHR(227) + "o Fiscal")
10505:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10506:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10507:             loc_oBusca.Show()
10508:             IF loc_oBusca.this_lSelecionou
10509:                 IF USED("cursor_4c_BuscaClf")
10510:                     SELECT cursor_4c_BuscaClf
10511:                     loc_oPg.txt_4c_Clfiscal.Value  = ALLTRIM(Codigos)
10512:                     loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(Descricaos)
10513:                     USE IN cursor_4c_BuscaClf
10514:                 ENDIF
10515:             ENDIF
10516:             loc_oBusca.Release()
10517:             loc_oBusca = .NULL.
10518:         CATCH TO loc_oErro
10519:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de classifica" + CHR(231) + CHR(227) + "o fiscal")
10520:         ENDTRY
10521:     ENDPROC
10522: 
10523:     *--------------------------------------------------------------------------
10524:     * TxtDclfiscalKeyPress - KeyPress em txt_4c_Dclfiscal (F4 busca reversa)
10525:     *--------------------------------------------------------------------------
10526:     PROCEDURE TxtDclfiscalKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 10539 a 10563:
10539:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10540:                 "SigCdClf", "cursor_4c_BuscaClf", "Descricaos", ;
10541:                 ALLTRIM(loc_oPg.txt_4c_Dclfiscal.Value), "Busca de Classifica" + CHR(231) + CHR(227) + "o Fiscal")
10542:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10543:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10544:             loc_oBusca.Show()
10545:             IF loc_oBusca.this_lSelecionou
10546:                 IF USED("cursor_4c_BuscaClf")
10547:                     SELECT cursor_4c_BuscaClf
10548:                     loc_oPg.txt_4c_Clfiscal.Value  = ALLTRIM(Codigos)
10549:                     loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(Descricaos)
10550:                     USE IN cursor_4c_BuscaClf
10551:                 ENDIF
10552:             ENDIF
10553:             loc_oBusca.Release()
10554:             loc_oBusca = .NULL.
10555:         CATCH TO loc_oErro
10556:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de classifica" + CHR(231) + CHR(227) + "o fiscal")
10557:         ENDTRY
10558:     ENDPROC
10559: 
10560:     *--------------------------------------------------------------------------
10561:     * TxtOrigmercKeyPress - KeyPress em txt_4c_Origmerc (F4 abre lookup SigCdOrg)
10562:     *--------------------------------------------------------------------------
10563:     PROCEDURE TxtOrigmercKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 10586 a 10610:
10586:             loc_lcSQL = "SELECT Codigos, Descricaos FROM SigCdOrg WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10587:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValOrg") <= 0 OR EOF("cursor_4c_ValOrg")
10588:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
10589:                 loc_oLookup.mAddColuna("Codigos",    "C" + CHR(243) + "digo",       60)
10590:                 loc_oLookup.mAddColuna("Descricaos", "Descri" + CHR(231) + CHR(227) + "o", 200)
10591:                 loc_oLookup.cTabela     = "SigCdOrg"
10592:                 loc_oLookup.cCampoChave = "Codigos"
10593:                 loc_oLookup.cFiltroIni  = loc_cCodigo
10594:                 loc_oLookup.Show()
10595:                 IF loc_oLookup.this_lSelecionou
10596:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
10597:                 ELSE
10598:                     loc_cCodigo = ""
10599:                 ENDIF
10600:             ELSE
10601:                 SELECT cursor_4c_ValOrg
10602:                 loc_oPage.txt_4c_Dorigmerc.Value = ALLTRIM(Descricaos)
10603:             ENDIF
10604:             IF USED("cursor_4c_ValOrg")
10605:                 USE IN cursor_4c_ValOrg
10606:             ENDIF
10607:             loc_oPage.txt_4c_Origmerc.Value = loc_cCodigo
10608:             IF !EMPTY(loc_cCodigo) AND EMPTY(loc_oPage.txt_4c_Dorigmerc.Value)
10609:                 loc_lcSQL = "SELECT Descricaos FROM SigCdOrg WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10610:                 IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValOrg2") > 0 AND !EOF("cursor_4c_ValOrg2")

*-- Linhas 10633 a 10657:
10633:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10634:                 "SigCdOrg", "cursor_4c_BuscaOrg", "Codigos", ;
10635:                 ALLTRIM(loc_oPg.txt_4c_Origmerc.Value), "Busca de Origem da Mercadoria")
10636:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10637:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10638:             loc_oBusca.Show()
10639:             IF loc_oBusca.this_lSelecionou
10640:                 IF USED("cursor_4c_BuscaOrg")
10641:                     SELECT cursor_4c_BuscaOrg
10642:                     loc_oPg.txt_4c_Origmerc.Value  = ALLTRIM(Codigos)
10643:                     loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(Descricaos)
10644:                     USE IN cursor_4c_BuscaOrg
10645:                 ENDIF
10646:             ENDIF
10647:             loc_oBusca.Release()
10648:             loc_oBusca = .NULL.
10649:         CATCH TO loc_oErro
10650:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de origem da mercadoria")
10651:         ENDTRY
10652:     ENDPROC
10653: 
10654:     *--------------------------------------------------------------------------
10655:     * TxtDorigmercKeyPress - KeyPress em txt_4c_Dorigmerc (F4 busca reversa)
10656:     *--------------------------------------------------------------------------
10657:     PROCEDURE TxtDorigmercKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 10670 a 10694:
10670:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10671:                 "SigCdOrg", "cursor_4c_BuscaOrg", "Descricaos", ;
10672:                 ALLTRIM(loc_oPg.txt_4c_Dorigmerc.Value), "Busca de Origem da Mercadoria")
10673:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10674:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10675:             loc_oBusca.Show()
10676:             IF loc_oBusca.this_lSelecionou
10677:                 IF USED("cursor_4c_BuscaOrg")
10678:                     SELECT cursor_4c_BuscaOrg
10679:                     loc_oPg.txt_4c_Origmerc.Value  = ALLTRIM(Codigos)
10680:                     loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(Descricaos)
10681:                     USE IN cursor_4c_BuscaOrg
10682:                 ENDIF
10683:             ENDIF
10684:             loc_oBusca.Release()
10685:             loc_oBusca = .NULL.
10686:         CATCH TO loc_oErro
10687:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de origem da mercadoria")
10688:         ENDTRY
10689:     ENDPROC
10690: 
10691:     *--------------------------------------------------------------------------
10692:     * TxtSittricmKeyPress - KeyPress em txt_4c_Sittricm (F4 abre lookup SigCdIcm)
10693:     *--------------------------------------------------------------------------
10694:     PROCEDURE TxtSittricmKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 10717 a 10741:
10717:             loc_lcSQL = "SELECT Codigos, Descricaos FROM SigCdIcm WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10718:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValIcm") <= 0 OR EOF("cursor_4c_ValIcm")
10719:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
10720:                 loc_oLookup.mAddColuna("Codigos",    "C" + CHR(243) + "digo",       60)
10721:                 loc_oLookup.mAddColuna("Descricaos", "Descri" + CHR(231) + CHR(227) + "o", 250)
10722:                 loc_oLookup.cTabela     = "SigCdIcm"
10723:                 loc_oLookup.cCampoChave = "Codigos"
10724:                 loc_oLookup.cFiltroIni  = loc_cCodigo
10725:                 loc_oLookup.Show()
10726:                 IF loc_oLookup.this_lSelecionou
10727:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
10728:                 ELSE
10729:                     loc_cCodigo = ""
10730:                 ENDIF
10731:             ELSE
10732:                 SELECT cursor_4c_ValIcm
10733:                 loc_oPage.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
10734:             ENDIF
10735:             IF USED("cursor_4c_ValIcm")
10736:                 USE IN cursor_4c_ValIcm
10737:             ENDIF
10738:             loc_oPage.txt_4c_Sittricm.Value = loc_cCodigo
10739:             IF !EMPTY(loc_cCodigo) AND EMPTY(loc_oPage.txt_4c_Dsittricm.Value)
10740:                 loc_lcSQL = "SELECT Descricaos FROM SigCdIcm WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10741:                 IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValIcm2") > 0 AND !EOF("cursor_4c_ValIcm2")

*-- Linhas 10764 a 10788:
10764:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10765:                 "SigCdIcm", "cursor_4c_BuscaIcm", "Codigos", ;
10766:                 ALLTRIM(loc_oPg.txt_4c_Sittricm.Value), "Busca de Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS")
10767:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10768:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10769:             loc_oBusca.Show()
10770:             IF loc_oBusca.this_lSelecionou
10771:                 IF USED("cursor_4c_BuscaIcm")
10772:                     SELECT cursor_4c_BuscaIcm
10773:                     loc_oPg.txt_4c_Sittricm.Value  = ALLTRIM(Codigos)
10774:                     loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
10775:                     USE IN cursor_4c_BuscaIcm
10776:                 ENDIF
10777:             ENDIF
10778:             loc_oBusca.Release()
10779:             loc_oBusca = .NULL.
10780:         CATCH TO loc_oErro
10781:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de situa" + CHR(231) + CHR(227) + "o tribut" + CHR(225) + "ria ICMS")
10782:         ENDTRY
10783:     ENDPROC
10784: 
10785:     *--------------------------------------------------------------------------
10786:     * TxtDsittricmKeyPress - KeyPress em txt_4c_Dsittricm (F4 busca reversa)
10787:     *--------------------------------------------------------------------------
10788:     PROCEDURE TxtDsittricmKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 10801 a 10825:
10801:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10802:                 "SigCdIcm", "cursor_4c_BuscaIcm", "Descricaos", ;
10803:                 ALLTRIM(loc_oPg.txt_4c_Dsittricm.Value), "Busca de Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS")
10804:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10805:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10806:             loc_oBusca.Show()
10807:             IF loc_oBusca.this_lSelecionou
10808:                 IF USED("cursor_4c_BuscaIcm")
10809:                     SELECT cursor_4c_BuscaIcm
10810:                     loc_oPg.txt_4c_Sittricm.Value  = ALLTRIM(Codigos)
10811:                     loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
10812:                     USE IN cursor_4c_BuscaIcm
10813:                 ENDIF
10814:             ENDIF
10815:             loc_oBusca.Release()
10816:             loc_oBusca = .NULL.
10817:         CATCH TO loc_oErro
10818:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de situa" + CHR(231) + CHR(227) + "o tribut" + CHR(225) + "ria ICMS")
10819:         ENDTRY
10820:     ENDPROC
10821: 
10822:     *--------------------------------------------------------------------------
10823:     * TxtCodServsKeyPress - KeyPress em txt_4c_CodServs (F4 abre lookup SigCdIcm)
10824:     *--------------------------------------------------------------------------
10825:     PROCEDURE TxtCodServsKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 10847 a 10871:
10847:             loc_lcSQL = "SELECT Codigos, Descricaos FROM SigCdIcm WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10848:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValCodServs") <= 0 OR EOF("cursor_4c_ValCodServs")
10849:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
10850:                 loc_oLookup.mAddColuna("Codigos",    "C" + CHR(243) + "digo",       60)
10851:                 loc_oLookup.mAddColuna("Descricaos", "Descri" + CHR(231) + CHR(227) + "o", 250)
10852:                 loc_oLookup.cTabela     = "SigCdIcm"
10853:                 loc_oLookup.cCampoChave = "Codigos"
10854:                 loc_oLookup.cFiltroIni  = loc_cCodigo
10855:                 loc_oLookup.Show()
10856:                 IF loc_oLookup.this_lSelecionou
10857:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
10858:                 ELSE
10859:                     loc_cCodigo = ""
10860:                 ENDIF
10861:             ELSE
10862:                 *-- Get_CodServs preenche txt_4c_Sittricm (conforme original)
10863:                 SELECT cursor_4c_ValCodServs
10864:                 loc_oPage.txt_4c_Sittricm.Value  = ALLTRIM(Codigos)
10865:                 loc_oPage.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
10866:                 loc_oPage.txt_4c_Sittricm.Refresh()
10867:                 loc_oPage.txt_4c_Dsittricm.Refresh()
10868:             ENDIF
10869:             IF USED("cursor_4c_ValCodServs")
10870:                 USE IN cursor_4c_ValCodServs
10871:             ENDIF

*-- Linhas 10887 a 10911:
10887:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10888:                 "SigCdIcm", "cursor_4c_BuscaIcm", "Codigos", ;
10889:                 ALLTRIM(loc_oPg.txt_4c_CodServs.Value), "Busca de C" + CHR(243) + "digo de Servi" + CHR(231) + "os")
10890:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10891:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10892:             loc_oBusca.Show()
10893:             IF loc_oBusca.this_lSelecionou
10894:                 IF USED("cursor_4c_BuscaIcm")
10895:                     SELECT cursor_4c_BuscaIcm
10896:                     loc_oPg.txt_4c_CodServs.Value  = ALLTRIM(Codigos)
10897:                     loc_oPg.txt_4c_Sittricm.Value  = ALLTRIM(Codigos)
10898:                     loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
10899:                     USE IN cursor_4c_BuscaIcm
10900:                 ENDIF
10901:             ENDIF
10902:             loc_oBusca.Release()
10903:             loc_oBusca = .NULL.
10904:         CATCH TO loc_oErro
10905:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de c" + CHR(243) + "digo de servi" + CHR(231) + "os")
10906:         ENDTRY
10907:     ENDPROC
10908: 
10909:     *--------------------------------------------------------------------------
10910:     * TxtTpTribKeyPress - KeyPress em txt_4c_TpTrib (F4 abre lookup SigPrTri)
10911:     *--------------------------------------------------------------------------

*-- Linhas 10934 a 10958:
10934:             loc_lcSQL = "SELECT Tipos FROM SigPrTri WHERE Tipos = " + EscaparSQL(loc_cCodigo)
10935:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValTrib") <= 0 OR EOF("cursor_4c_ValTrib")
10936:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
10937:                 loc_oLookup.mAddColuna("Tipos", "Tipo",       60)
10938:                 loc_oLookup.mAddColuna("Descs", "Descri" + CHR(231) + CHR(227) + "o", 200)
10939:                 loc_oLookup.cTabela     = "SigPrTri"
10940:                 loc_oLookup.cCampoChave = "Tipos"
10941:                 loc_oLookup.cFiltroIni  = loc_cCodigo
10942:                 loc_oLookup.Show()
10943:                 IF loc_oLookup.this_lSelecionou
10944:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
10945:                 ELSE
10946:                     loc_cCodigo = ""
10947:                 ENDIF
10948:             ENDIF
10949:             IF USED("cursor_4c_ValTrib")
10950:                 USE IN cursor_4c_ValTrib
10951:             ENDIF
10952:             loc_oPage.txt_4c_TpTrib.Value = loc_cCodigo
10953:             loc_oPage.txt_4c_TpTrib.Refresh()
10954:         CATCH TO loc_oErro
10955:             MsgErro(loc_oErro.Message, "Erro")
10956:         ENDTRY
10957:         RETURN loc_lResultado
10958:     ENDPROC

*-- Linhas 10967 a 10991:
10967:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10968:                 "SigPrTri", "cursor_4c_BuscaTrib", "Tipos", ;
10969:                 ALLTRIM(loc_oPg.txt_4c_TpTrib.Value), "Busca de Tipo de Tributa" + CHR(231) + CHR(227) + "o")
10970:             loc_oBusca.mAddColuna("Tipos", "", "Tipo")
10971:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
10972:             loc_oBusca.Show()
10973:             IF loc_oBusca.this_lSelecionou
10974:                 IF USED("cursor_4c_BuscaTrib")
10975:                     SELECT cursor_4c_BuscaTrib
10976:                     loc_oPg.txt_4c_TpTrib.Value = ALLTRIM(Tipos)
10977:                     USE IN cursor_4c_BuscaTrib
10978:                 ENDIF
10979:             ENDIF
10980:             loc_oBusca.Release()
10981:             loc_oBusca = .NULL.
10982:         CATCH TO loc_oErro
10983:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de tipo de tributa" + CHR(231) + CHR(227) + "o")
10984:         ENDTRY
10985:     ENDPROC
10986: 
10987:     *--------------------------------------------------------------------------
10988:     * ValidarIat - LostFocus em txt_4c_Iat
10989:     * Valida: deve ser 'A' (Arredondamento) ou 'T' (Truncamento) ou vazio
10990:     *--------------------------------------------------------------------------
10991:     PROCEDURE ValidarIat()

*-- Linhas 11067 a 11091:
11067:             loc_lcSQL = "SELECT cmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cCodigo)
11068:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValMvalor") <= 0 OR EOF("cursor_4c_ValMvalor")
11069:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
11070:                 loc_oLookup.mAddColuna("cmoes", "C" + CHR(243) + "digo",       60)
11071:                 loc_oLookup.mAddColuna("dmoes", "Descri" + CHR(231) + CHR(227) + "o", 200)
11072:                 loc_oLookup.cTabela     = "SigCdMoe"
11073:                 loc_oLookup.cCampoChave = "cmoes"
11074:                 loc_oLookup.cFiltroIni  = loc_cCodigo
11075:                 loc_oLookup.Show()
11076:                 IF loc_oLookup.this_lSelecionou
11077:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
11078:                 ELSE
11079:                     loc_cCodigo = ""
11080:                 ENDIF
11081:             ENDIF
11082:             IF USED("cursor_4c_ValMvalor")
11083:                 USE IN cursor_4c_ValMvalor
11084:             ENDIF
11085:             loc_oPage.txt_4c_Mvalor.Value = loc_cCodigo
11086:             loc_oPage.txt_4c_Mvalor.Refresh()
11087:         CATCH TO loc_oErro
11088:             MsgErro(loc_oErro.Message, "Erro")
11089:         ENDTRY
11090:         RETURN loc_lResultado
11091:     ENDPROC

*-- Linhas 11100 a 11124:
11100:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11101:                 "SigCdMoe", "cursor_4c_BuscaMvalor", "cmoes", ;
11102:                 ALLTRIM(loc_oPg.txt_4c_Mvalor.Value), "Busca de Moeda")
11103:             loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
11104:             loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11105:             loc_oBusca.Show()
11106:             IF loc_oBusca.this_lSelecionou
11107:                 IF USED("cursor_4c_BuscaMvalor")
11108:                     SELECT cursor_4c_BuscaMvalor
11109:                     loc_oPg.txt_4c_Mvalor.Value = ALLTRIM(cmoes)
11110:                     USE IN cursor_4c_BuscaMvalor
11111:                 ENDIF
11112:             ENDIF
11113:             loc_oBusca.Release()
11114:             loc_oBusca = .NULL.
11115:         CATCH TO loc_oErro
11116:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de moeda")
11117:         ENDTRY
11118:     ENDPROC
11119: 
11120:     *--------------------------------------------------------------------------
11121:     * TxtMetalKeyPress - KeyPress em txt_4c_Metal (F4 abre lookup metal)
11122:     *--------------------------------------------------------------------------
11123:     PROCEDURE TxtMetalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11124:         IF par_nKeyCode = 115

*-- Linhas 11138 a 11162:
11138:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11139:                     "TmpMTal", "cursor_4c_BuscaMetal", "Codigos", ;
11140:                     ALLTRIM(loc_oPg.txt_4c_Metal.Value), "Busca de Metal")
11141:                 loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
11142:                 loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
11143:                 loc_oBusca.Show()
11144:                 IF loc_oBusca.this_lSelecionou
11145:                     IF USED("cursor_4c_BuscaMetal")
11146:                         SELECT cursor_4c_BuscaMetal
11147:                         loc_oPg.txt_4c_Metal.Value   = ALLTRIM(Codigos)
11148:                         loc_oPg.txt_4c_DesMetal.Value = ALLTRIM(Descs)
11149:                         USE IN cursor_4c_BuscaMetal
11150:                     ENDIF
11151:                 ENDIF
11152:                 loc_oBusca.Release()
11153:                 loc_oBusca = .NULL.
11154:             ENDIF
11155:         CATCH TO loc_oErro
11156:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de metal")
11157:         ENDTRY
11158:     ENDPROC
11159: 
11160:     *--------------------------------------------------------------------------
11161:     * TxtTeorKeyPress - KeyPress em txt_4c_Teor (F4 abre lookup teor)
11162:     *--------------------------------------------------------------------------

*-- Linhas 11178 a 11202:
11178:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11179:                     "TmpTeor", "cursor_4c_BuscaTeor", "Codigos", ;
11180:                     ALLTRIM(loc_oPg.txt_4c_Teor.Value), "Busca de Teor")
11181:                 loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
11182:                 loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
11183:                 loc_oBusca.Show()
11184:                 IF loc_oBusca.this_lSelecionou
11185:                     IF USED("cursor_4c_BuscaTeor")
11186:                         SELECT cursor_4c_BuscaTeor
11187:                         loc_oPg.txt_4c_Teor.Value   = ALLTRIM(Codigos)
11188:                         loc_oPg.txt_4c_DesTeor.Value = ALLTRIM(Descs)
11189:                         USE IN cursor_4c_BuscaTeor
11190:                     ENDIF
11191:                 ENDIF
11192:                 loc_oBusca.Release()
11193:                 loc_oBusca = .NULL.
11194:             ENDIF
11195:         CATCH TO loc_oErro
11196:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de teor")
11197:         ENDTRY
11198:     ENDPROC
11199: 
11200:     *--------------------------------------------------------------------------
11201:     * CmdBtnDescFisClick - Click em cmd_4c_BtnDescFis
11202:     * Gera descricao fiscal a partir da composicao do produto (campo DescFis em SigCdPro)


### BO (C:\4c\projeto\app\classes\ProdutoBO.prg):
*==============================================================================
* ProdutoBO.prg - Business Object para Produtos
* Tabela: SigPrFtp
*==============================================================================
DEFINE CLASS ProdutoBO AS BusinessBase

  *-- Propriedades da tabela SigPrFtp
  this_cCgrus    = ""   && char(3)   - Grupo
  this_cCods     = ""   && char(2)   - Codigo
  this_nCoefs    = 0    && numeric(6,4) - Coeficiente
  this_cCpros    = ""   && char(14)  - Codigo do Produto
  this_cPkchaves = ""   && char(20)  - Chave Primaria
  this_nValors   = 0    && numeric(10,2) - Valor

  *===========================================================================
  FUNCTION Init()
  *===========================================================================
    THIS.this_cTabela     = "SigPrFtp"
    THIS.this_cCampoChave = "cpros"

    RETURN DODEFAULT()
  ENDFUNC

  *===========================================================================
  FUNCTION ObterChavePrimaria()
  *===========================================================================
    RETURN THIS.this_cCpros
  ENDFUNC

  *===========================================================================
  FUNCTION CarregarDoCursor(par_cAliasCursor)
  *===========================================================================
    LOCAL loc_lResultado
    loc_lResultado = .F.

    TRY
      SELECT (par_cAliasCursor)
      THIS.this_cCgrus    = ALLTRIM(cgrus)
      THIS.this_cCods     = ALLTRIM(cods)
      THIS.this_nCoefs    = coefs
      THIS.this_cCpros    = ALLTRIM(cpros)
      THIS.this_cPkchaves = ALLTRIM(pkchaves)
      THIS.this_nValors   = valors
      loc_lResultado = .T.
    CATCH TO loc_oErro
      MsgErro(loc_oErro.Message, "Erro ao carregar cursor")
    ENDTRY

    RETURN loc_lResultado
  ENDFUNC

  *===========================================================================
  FUNCTION Buscar(par_cFiltro)
  *===========================================================================
    LOCAL loc_lResultado, loc_cSQL
    loc_lResultado = .F.

    TRY
      IF EMPTY(par_cFiltro)
        loc_cSQL = "SELECT * FROM SigPrFtp ORDER BY cpros"
      ELSE
        loc_cSQL = "SELECT * FROM SigPrFtp WHERE " + par_cFiltro + " ORDER BY cpros"
      ENDIF

      IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados") > 0
        loc_lResultado = .T.
      ENDIF
    CATCH TO loc_oErro
      MsgErro(loc_oErro.Message, "Erro ao buscar produtos")
    ENDTRY

    RETURN loc_lResultado
  ENDFUNC

  *===========================================================================
  FUNCTION CarregarPorCodigo(par_cCodigo)
  *===========================================================================
    LOCAL loc_lResultado, loc_cSQL
    loc_lResultado = .F.

    TRY
      loc_cSQL = "SELECT * FROM SigPrFtp WHERE cpros = " + EscaparSQL(par_cCodigo)

      IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Registro") > 0
        IF !EOF("cursor_4c_Registro")
          loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Registro")
        ENDIF
      ENDIF
    CATCH TO loc_oErro
      MsgErro(loc_oErro.Message, "Erro ao carregar produto")
    ENDTRY

    RETURN loc_lResultado
  ENDFUNC

  *===========================================================================
  PROTECTED PROCEDURE Inserir()
  *===========================================================================
    LOCAL loc_lResultado, loc_cSQL
    loc_lResultado = .F.

    TRY
      loc_cSQL = "INSERT INTO SigPrFtp (cgrus, cods, coefs, cpros, pkchaves, valors) VALUES (" + ;
        EscaparSQL(THIS.this_cCgrus)    + ", " + ;
        EscaparSQL(THIS.this_cCods)     + ", " + ;
        FormatarNumeroSQL(THIS.this_nCoefs)   + ", " + ;
        EscaparSQL(THIS.this_cCpros)    + ", " + ;
        EscaparSQL(THIS.this_cPkchaves) + ", " + ;
        FormatarNumeroSQL(THIS.this_nValors)  + ")"

      IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
        loc_lResultado = .T.
        THIS.RegistrarAuditoria("I")
      ENDIF
    CATCH TO loc_oErro
      MsgErro(loc_oErro.Message, "Erro ao inserir produto")
    ENDTRY

    RETURN loc_lResultado
  ENDFUNC

  *===========================================================================
  PROTECTED PROCEDURE Atualizar()
  *===========================================================================
    LOCAL loc_lResultado, loc_cSQL
    loc_lResultado = .F.

    TRY
      loc_cSQL = "UPDATE SigPrFtp SET " + ;
        "cgrus = "   + EscaparSQL(THIS.this_cCgrus)          + ", " + ;
        "cods = "    + EscaparSQL(THIS.this_cCods)           + ", " + ;
        "coefs = "   + FormatarNumeroSQL(THIS.this_nCoefs)   + ", " + ;
        "cpros = "   + EscaparSQL(THIS.this_cCpros)          + ", " + ;
        "valors = "  + FormatarNumeroSQL(THIS.this_nValors)  + ;
        " WHERE cpros = " + EscaparSQL(THIS.this_cCpros)

      IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
        loc_lResultado = .T.
        THIS.RegistrarAuditoria("A")
      ENDIF
    CATCH TO loc_oErro
      MsgErro(loc_oErro.Message, "Erro ao atualizar produto")
    ENDTRY

    RETURN loc_lResultado
  ENDFUNC

  *===========================================================================
  PROTECTED FUNCTION ExecutarExclusao()
  *===========================================================================
    LOCAL loc_lResultado, loc_cSQL
    loc_lResultado = .F.

    TRY
      THIS.RegistrarAuditoria("E")

      loc_cSQL = "DELETE FROM SigPrFtp WHERE cpros = " + EscaparSQL(THIS.this_cCpros)

      IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
        loc_lResultado = .T.
      ENDIF
    CATCH TO loc_oErro
      MsgErro(loc_oErro.Message, "Erro ao excluir produto")
    ENDTRY

    RETURN loc_lResultado
  ENDFUNC

ENDDEFINE

