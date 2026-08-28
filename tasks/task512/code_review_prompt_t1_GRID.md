# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1237: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormRPT.prg) - TRECHOS RELEVANTES PARA PASS GRID (2802 linhas total):

*-- Linhas 349 a 386:
349:             ENDWITH
350:             BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
351: 
352:             loc_oPagina.AddObject("grd_4c_Lista", "Grid")
353:             WITH loc_oPagina.grd_4c_Lista
354:                 .Top                = 117
355:                 .Left               = 2
356:                 .Width              = 998
357:                 .Height             = 498
358:                 .FontName           = "Verdana"
359:                 .FontSize           = 8
360:                 .ForeColor          = RGB(90, 90, 90)
361:                 .BackColor          = RGB(255, 255, 255)
362:                 .GridLineColor      = RGB(238, 238, 238)
363:                 .HighlightBackColor = RGB(255, 255, 255)
364:                 .HighlightForeColor = RGB(15, 41, 104)
365:                 .HighlightStyle     = 2
366:                 .DeleteMark         = .F.
367:                 .RecordMark         = .F.
368:                 .RowHeight          = 16
369:                 .ScrollBars         = 2
370:                 .GridLines          = 3
371:                 .ColumnCount        = 5
372:                 .Visible            = .T.
373:             ENDWITH
374: 
375:             THIS.TornarControlesVisiveis(loc_oPagina)
376:         CATCH TO loc_oErro
377:             MsgErro(loc_oErro.Message, "FormRPT.ConfigurarPaginaLista")
378:         ENDTRY
379:     ENDPROC
380: 
381:     *==========================================================================
382:     * ConfigurarPaginaDados - Page2 externa: botoes Confirmar/Cancelar + PageFrame interno
383:     *   pgf_4c_Dados.Page1 = Editor SQL (campos + editor + grade resultado)
384:     *   pgf_4c_Dados.Page2 = Designer layout (Fase 6)
385:     *==========================================================================
386:     PROTECTED PROCEDURE ConfigurarPaginaDados()

*-- Linhas 894 a 968:
894:             BINDEVENT(par_oPage.edt_4c_SqlCMD, "Change", THIS, "SqlCMDChange")
895: 
896:             *-- Grade de resultados SQL (FwGrade1_Resultado no legado)
897:             par_oPage.AddObject("grd_4c_Resultado", "Grid")
898:             WITH par_oPage.grd_4c_Resultado
899:                 .Top                = 379
900:                 .Left               = 8
901:                 .Width              = 986
902:                 .Height             = 218
903:                 .FontName           = "Verdana"
904:                 .FontSize           = 8
905:                 .ForeColor          = RGB(90, 90, 90)
906:                 .BackColor          = RGB(255, 255, 255)
907:                 .GridLineColor      = RGB(238, 238, 238)
908:                 .HighlightBackColor = RGB(255, 255, 255)
909:                 .HighlightForeColor = RGB(15, 41, 104)
910:                 .HighlightStyle     = 2
911:                 .DeleteMark         = .F.
912:                 .RecordMark         = .F.
913:                 .RowHeight          = 16
914:                 .ScrollBars         = 3
915:                 .GridLines          = 3
916:                 .ColumnCount        = 0
917:                 .ReadOnly           = .T.
918:                 .Visible            = .T.
919:             ENDWITH
920:         CATCH TO loc_oErro
921:             MsgErro(loc_oErro.Message, "FormRPT.ConfigurarEditorSQL")
922:         ENDTRY
923:     ENDPROC
924: 
925:     *==========================================================================
926:     * CarregarLista - Carrega lista de relatorios no grid
927:     *==========================================================================
928:     PROCEDURE CarregarLista()
929:         LOCAL loc_lResultado, loc_oGrid
930:         loc_lResultado = .F.
931: 
932:         TRY
933:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
934:                 loc_lResultado = .T.
935:             ELSE
936:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
937:                 IF THIS.this_oBusinessObject.Buscar("")
938:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
939: 
940:                     loc_oGrid.ColumnCount = 5
941:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
942:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.NmReport"
943:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descr"
944:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.DtCriacao"
945:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.DtAlteracao"
946:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Ativo"
947: 
948:                     *-- Redefinir headers APOS RecordSource (CRITICO - Problema 6)
949:                     loc_oGrid.Column1.Header1.Caption = "Nome do Relat" + CHR(243) + "rio"
950:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
951:                     loc_oGrid.Column3.Header1.Caption = "Cria" + CHR(231) + CHR(227) + "o"
952:                     loc_oGrid.Column4.Header1.Caption = "Altera" + CHR(231) + CHR(227) + "o"
953:                     loc_oGrid.Column5.Header1.Caption = "Ativo"
954: 
955:                     loc_oGrid.Column1.Width = 350
956:                     loc_oGrid.Column2.Width = 350
957:                     loc_oGrid.Column3.Width = 90
958:                     loc_oGrid.Column4.Width = 90
959:                     loc_oGrid.Column5.Width = 50
960: 
961:                     THIS.FormatarGridLista(loc_oGrid)
962: 
963:                     loc_lResultado = .T.
964:                 ENDIF
965:                 ENDIF
966:             ENDIF
967:         CATCH TO loc_oErro
968:             MsgErro(loc_oErro.Message, "FormRPT.CarregarLista")

*-- Linhas 1129 a 1161:
1129: 
1130:             IF VARTYPE(loc_cFiltro) = "C"
1131:                 IF THIS.this_oBusinessObject.Buscar(ALLTRIM(loc_cFiltro))
1132:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1133: 
1134:                     loc_oGrid.ColumnCount = 5
1135:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1136:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.NmReport"
1137:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descr"
1138:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.DtCriacao"
1139:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.DtAlteracao"
1140:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Ativo"
1141: 
1142:                     loc_oGrid.Column1.Header1.Caption = "Nome do Relat" + CHR(243) + "rio"
1143:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1144:                     loc_oGrid.Column3.Header1.Caption = "Cria" + CHR(231) + CHR(227) + "o"
1145:                     loc_oGrid.Column4.Header1.Caption = "Altera" + CHR(231) + CHR(227) + "o"
1146:                     loc_oGrid.Column5.Header1.Caption = "Ativo"
1147: 
1148:                     loc_oGrid.Column1.Width = 350
1149:                     loc_oGrid.Column2.Width = 350
1150:                     loc_oGrid.Column3.Width = 90
1151:                     loc_oGrid.Column4.Width = 90
1152:                     loc_oGrid.Column5.Width = 50
1153: 
1154:                     THIS.FormatarGridLista(loc_oGrid)
1155:                     loc_oGrid.Refresh()
1156:                 ENDIF
1157:             ENDIF
1158:         CATCH TO loc_oErro
1159:             MsgErro(loc_oErro.Message, "FormRPT.BtnBuscarClick")
1160:         ENDTRY
1161:     ENDPROC

*-- Linhas 1223 a 1257:
1223:             ENDIF
1224: 
1225:             IF loc_lProsseguir
1226:                 IF USED("cursor_4c_SqlResult")
1227:                     USE IN cursor_4c_SqlResult
1228:                 ENDIF
1229: 
1230:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SqlResult")
1231: 
1232:                 IF loc_nResultado >= 0
1233:                     loc_oGrid = loc_oPage.grd_4c_Resultado
1234:                     loc_nCols = AFIELDS(laFields, "cursor_4c_SqlResult")
1235: 
1236:                     loc_oGrid.ColumnCount = 3
1237:                     loc_oGrid.RecordSource = "cursor_4c_SqlResult"
1238:                     loc_oGrid.ColumnCount  = loc_nCols
1239: 
1240:                     FOR loc_nI = 1 TO loc_nCols
1241:                         loc_oGrid.Columns(loc_nI).ControlSource = "cursor_4c_SqlResult." + laFields[loc_nI, 1]
1242:                         loc_oGrid.Columns(loc_nI).Header1.Caption = laFields[loc_nI, 1]
1243:                         loc_oGrid.Columns(loc_nI).Width = 100
1244:                     ENDFOR
1245: 
1246:                     loc_oPage.lbl_4c_SqlAlterado.Caption = ""
1247:                     THIS.this_oBusinessObject.this_cSqlQuery = loc_cSQL
1248:                     loc_oGrid.Refresh()
1249: 
1250:                     MsgInfo(ALLTRIM(STR(RECCOUNT("cursor_4c_SqlResult"))) + ;
1251:                             " registro(s) retornado(s).")
1252:                 ELSE
1253:                     MsgErro("Erro ao executar SQL:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1254:                 ENDIF
1255:             ENDIF
1256:         CATCH TO loc_oErro
1257:             MsgErro(loc_oErro.Message, "FormRPT.BtnProcessarClick")

*-- Linhas 1388 a 1411:
1388: 
1389:                 *-- Vincula cursores as grades do designer
1390:                 loc_oDesignerPage = loc_oPgfDados.Page2
1391:                 loc_oDesignerPage.grd_4c_TIT.RecordSource  = "CrsProps_Titulo"
1392:                 loc_oDesignerPage.grd_4c_CMPs.RecordSource = "CrsProps_Campos"
1393:                 loc_oDesignerPage.grd_4c_GRP.RecordSource  = "CrsProps_GRP"
1394:                 loc_oDesignerPage.grd_4c_TIT.Refresh()
1395:                 loc_oDesignerPage.grd_4c_CMPs.Refresh()
1396:                 loc_oDesignerPage.grd_4c_GRP.Refresh()
1397: 
1398:                 *-- Navega para o Designer (Page2 do pgf_4c_Dados)
1399:                 loc_oPgfDados.ActivePage = 2
1400:             ENDIF
1401:         CATCH TO loc_oErro
1402:             MsgErro(loc_oErro.Message, "FormRPT.BtnLayoutClick")
1403:         ENDTRY
1404:     ENDPROC
1405: 
1406:     *==========================================================================
1407:     * SqlCMDChange - Marca asterisco quando SQL e editado (evento BINDEVENT)
1408:     *==========================================================================
1409:     PROCEDURE SqlCMDChange()
1410:         TRY
1411:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1.lbl_4c_SqlAlterado.Caption = "*"

*-- Linhas 1522 a 1540:
1522:                     .RowSourceType = 2
1523:                     .RowSource     = "cursor_4c_ReportNomes"
1524:                     .BoundColumn   = 1
1525:                     .ColumnCount   = 1
1526:                 ENDWITH
1527:             ENDIF
1528:         CATCH TO loc_oErro
1529:             MsgErro(loc_oErro.Message, "FormRPT.PopularComboReports")
1530:         ENDTRY
1531:     ENDPROC
1532: 
1533:     *==========================================================================
1534:     * ConfigurarDesignerLayout - Page2 interna (Designer de Layout do Relatorio)
1535:     * Fase 5 Parte 2: botoes Voltar/SalvarRPT, labels, orientacao, tamanho papel
1536:     * Coords: direto do SCX Pageframe1.Page2 (sem ajuste - simetria dos dois Top=-29)
1537:     *==========================================================================
1538:     PROTECTED PROCEDURE ConfigurarDesignerLayout(par_oPage)
1539:         TRY
1540:             *-- Container botoes de acao do designer (CmdGrp_Acoes no legado - 2 botoes)

*-- Linhas 1670 a 1688:
1670:                 .FontName      = "Tahoma"
1671:                 .FontSize      = 8
1672:                 .RowSourceType = 0
1673:                 .ColumnCount   = 1
1674:                 .BoundColumn   = 1
1675:                 .Visible       = .T.
1676:             ENDWITH
1677:             THIS.PopularCboTamPapel(par_oPage.cbo_4c_TamPapel)
1678: 
1679:             *-- Label nome do relatorio (Lbl_Nm_Relatorio no legado)
1680:             par_oPage.AddObject("lbl_4c_NmRelatorio", "Label")
1681:             WITH par_oPage.lbl_4c_NmRelatorio
1682:                 .Top       = 131
1683:                 .Left      = 10
1684:                 .Width     = 540
1685:                 .Height    = 22
1686:                 .Caption   = ""
1687:                 .FontName  = "Tahoma"
1688:                 .FontSize  = 10

*-- Linhas 1825 a 2155:
1825: 
1826:     *==========================================================================
1827:     * ConfigurarGradesDesigner - Fase 6: 3 grades da Page2 interna (Designer)
1828:     * grd_4c_TIT (5 cols/Top=180), grd_4c_CMPs (12 cols/Top=258), grd_4c_GRP (7 cols/Top=529)
1829:     * RecordSource definido em runtime quando cursor de dados e carregado
1830:     *==========================================================================
1831:     PROTECTED PROCEDURE ConfigurarGradesDesigner(par_oPage)
1832:         LOCAL loc_oGrd, loc_oCol
1833:         TRY
1834:             *=== GRADE 1: grd_4c_TIT (FwGrade1_TIT) - titulo/cabecalho, 5 colunas ===
1835:             par_oPage.AddObject("grd_4c_TIT", "Grid")
1836:             loc_oGrd = par_oPage.grd_4c_TIT
1837:             WITH loc_oGrd
1838:                 .Top              = 180
1839:                 .Left             = 4
1840:                 .Width            = 990
1841:                 .Height           = 65
1842:                 .ColumnCount      = 5
1843:                 .RecordSourceType = 1
1844:                 .RecordSource     = ""
1845:                 .GridLines        = 1
1846:                 .HeaderHeight     = 25
1847:                 .RowHeight        = 30
1848:                 .DeleteMark       = .F.
1849:                 .RecordMark       = .F.
1850:                 .ScrollBars       = 2
1851:                 .Visible          = .T.
1852:             ENDWITH
1853: 
1854:             *- Col1: LblCaption - "Titulo" (EditBox)
1855:             loc_oCol = loc_oGrd.Column1
1856:             loc_oCol.Header1.Caption = "T" + CHR(237) + "tulo"
1857:             loc_oCol.Width  = 300
1858:             loc_oCol.Sparse = .F.
1859:             loc_oCol.AddObject("edt_4c_TitCaption", "EditBox")
1860:             loc_oCol.CurrentControl = "edt_4c_TitCaption"
1861:             WITH loc_oCol.edt_4c_TitCaption
1862:                 .Width      = 298
1863:                 .Height     = 28
1864:                 .ScrollBars = 0
1865:             ENDWITH
1866: 
1867:             *- Col2: LblFonte - "Fonte" (EditBox - string "FontName,Size,Style")
1868:             loc_oCol = loc_oGrd.Column2
1869:             loc_oCol.Header1.Caption = "Fonte"
1870:             loc_oCol.Width  = 230
1871:             loc_oCol.Sparse = .F.
1872:             loc_oCol.AddObject("edt_4c_TitFonte", "EditBox")
1873:             loc_oCol.CurrentControl = "edt_4c_TitFonte"
1874:             WITH loc_oCol.edt_4c_TitFonte
1875:                 .Width      = 228
1876:                 .Height     = 28
1877:                 .ScrollBars = 0
1878:             ENDWITH
1879: 
1880:             *- Col3: BtFonte - "Fte" (CommandButton - abre dialogo GETFONT)
1881:             loc_oCol = loc_oGrd.Column3
1882:             loc_oCol.Header1.Caption = "Fte"
1883:             loc_oCol.Width  = 80
1884:             loc_oCol.Sparse = .F.
1885:             loc_oCol.AddObject("cmd_4c_FonteTIT", "CommandButton")
1886:             loc_oCol.CurrentControl = "cmd_4c_FonteTIT"
1887:             WITH loc_oCol.cmd_4c_FonteTIT
1888:                 .Caption       = "..."
1889:                 .Width         = 75
1890:                 .Height        = 25
1891:                 .SpecialEffect = 0
1892:                 .FontName      = "Tahoma"
1893:                 .FontSize      = 8
1894:             ENDWITH
1895:             BINDEVENT(loc_oCol.cmd_4c_FonteTIT, "Click", THIS, "BtnFonteTITClick")
1896: 
1897:             *- Col4: BtCor - "Cor" (CommandButton - abre GETCOLOR)
1898:             loc_oCol = loc_oGrd.Column4
1899:             loc_oCol.Header1.Caption = "Cor"
1900:             loc_oCol.Width  = 80
1901:             loc_oCol.Sparse = .F.
1902:             loc_oCol.AddObject("cmd_4c_CorTIT", "CommandButton")
1903:             loc_oCol.CurrentControl = "cmd_4c_CorTIT"
1904:             WITH loc_oCol.cmd_4c_CorTIT
1905:                 .Caption       = "..."
1906:                 .Width         = 75
1907:                 .Height        = 25
1908:                 .SpecialEffect = 0
1909:                 .FontName      = "Tahoma"
1910:                 .FontSize      = 8
1911:             ENDWITH
1912:             BINDEVENT(loc_oCol.cmd_4c_CorTIT, "Click", THIS, "BtnCorTITClick")
1913: 
1914:             *- Col5: LblAlinhar - "Alinhar" (ComboBox Esq./Cen./Dir.)
1915:             loc_oCol = loc_oGrd.Column5
1916:             loc_oCol.Header1.Caption = "Alinhar"
1917:             loc_oCol.Width  = 300
1918:             loc_oCol.Sparse = .F.
1919:             loc_oCol.AddObject("cbo_4c_AlinharTIT", "ComboBox")
1920:             loc_oCol.CurrentControl = "cbo_4c_AlinharTIT"
1921:             WITH loc_oCol.cbo_4c_AlinharTIT
1922:                 .Style         = 2
1923:                 .RowSourceType = 1
1924:                 .RowSource     = "Esq.,Cen.,Dir."
1925:                 .Width         = 120
1926:                 .Height        = 24
1927:                 .FontName      = "Tahoma"
1928:                 .FontSize      = 8
1929:             ENDWITH
1930: 
1931:             *=== GRADE 2: grd_4c_CMPs (FwGrade2_CMPs) - campos do relatorio, 12 colunas ===
1932:             par_oPage.AddObject("grd_4c_CMPs", "Grid")
1933:             loc_oGrd = par_oPage.grd_4c_CMPs
1934:             WITH loc_oGrd
1935:                 .Top              = 258
1936:                 .Left             = 4
1937:                 .Width            = 990
1938:                 .Height           = 238
1939:                 .ColumnCount      = 12
1940:                 .RecordSourceType = 1
1941:                 .RecordSource     = ""
1942:                 .GridLines        = 1
1943:                 .HeaderHeight     = 25
1944:                 .RowHeight        = 30
1945:                 .DeleteMark       = .F.
1946:                 .RecordMark       = .F.
1947:                 .ScrollBars       = 3
1948:                 .Visible          = .T.
1949:             ENDWITH
1950: 
1951:             *- Col1: NmCampo - "Campo" (TextBox, readonly - nome do campo do SQL)
1952:             loc_oCol = loc_oGrd.Column1
1953:             loc_oCol.Header1.Caption = "Campo"
1954:             loc_oCol.Width    = 140
1955:             loc_oCol.Sparse   = .F.
1956:             loc_oCol.ReadOnly = .T.
1957:             loc_oCol.AddObject("txt_4c_NmCampo", "TextBox")
1958:             loc_oCol.CurrentControl = "txt_4c_NmCampo"
1959:             WITH loc_oCol.txt_4c_NmCampo
1960:                 .Width     = 138
1961:                 .Height    = 23
1962:                 .ReadOnly  = .T.
1963:                 .BackColor = RGB(240, 240, 240)
1964:                 .FontName  = "Tahoma"
1965:                 .FontSize  = 8
1966:             ENDWITH
1967: 
1968:             *- Col2: TpCampo - "Tipo" (TextBox, readonly - tipo do campo)
1969:             loc_oCol = loc_oGrd.Column2
1970:             loc_oCol.Header1.Caption = "Tipo"
1971:             loc_oCol.Width    = 75
1972:             loc_oCol.Sparse   = .F.
1973:             loc_oCol.ReadOnly = .T.
1974:             loc_oCol.AddObject("txt_4c_TpCampo", "TextBox")
1975:             loc_oCol.CurrentControl = "txt_4c_TpCampo"
1976:             WITH loc_oCol.txt_4c_TpCampo
1977:                 .Width     = 73
1978:                 .Height    = 23
1979:                 .ReadOnly  = .T.
1980:                 .BackColor = RGB(240, 240, 240)
1981:                 .FontName  = "Tahoma"
1982:                 .FontSize  = 8
1983:             ENDWITH
1984: 
1985:             *- Col3: CkOutRPT - "Saida Rel." (CheckBox - inclui campo na saida do relatorio)
1986:             loc_oCol = loc_oGrd.Column3
1987:             loc_oCol.Header1.Caption = "Sa" + CHR(237) + "da Rel."
1988:             loc_oCol.Width  = 60
1989:             loc_oCol.Sparse = .F.
1990:             loc_oCol.AddObject("chk_4c_SaidaRPT", "CheckBox")
1991:             loc_oCol.CurrentControl = "chk_4c_SaidaRPT"
1992:             WITH loc_oCol.chk_4c_SaidaRPT
1993:                 .Caption   = ""
1994:                 .Alignment = 0
1995:                 .ReadOnly  = .F.
1996:                 .Visible   = .T.
1997:                 .Top       = 9
1998:                 .Left      = 2
1999:                 .Height    = 17
2000:                 .Width     = 22
2001:             ENDWITH
2002: 
2003:             *- Col4: CkFiltro - "Filtro" (CheckBox - habilita como filtro)
2004:             loc_oCol = loc_oGrd.Column4
2005:             loc_oCol.Header1.Caption = "Filtro"
2006:             loc_oCol.Width  = 50
2007:             loc_oCol.Sparse = .F.
2008:             loc_oCol.AddObject("chk_4c_CkFiltro", "CheckBox")
2009:             loc_oCol.CurrentControl = "chk_4c_CkFiltro"
2010:             WITH loc_oCol.chk_4c_CkFiltro
2011:                 .Caption   = ""
2012:                 .Alignment = 0
2013:                 .ReadOnly  = .F.
2014:                 .Visible   = .T.
2015:                 .Top       = 9
2016:                 .Left      = 2
2017:                 .Height    = 17
2018:                 .Width     = 22
2019:             ENDWITH
2020: 
2021:             *- Col5: CkSubTot - "SubTot" (CheckBox - subtotalizar)
2022:             loc_oCol = loc_oGrd.Column5
2023:             loc_oCol.Header1.Caption = "SubTot"
2024:             loc_oCol.Width  = 55
2025:             loc_oCol.Sparse = .F.
2026:             loc_oCol.AddObject("chk_4c_CkSubTot", "CheckBox")
2027:             loc_oCol.CurrentControl = "chk_4c_CkSubTot"
2028:             WITH loc_oCol.chk_4c_CkSubTot
2029:                 .Caption   = ""
2030:                 .Alignment = 0
2031:                 .ReadOnly  = .F.
2032:                 .Visible   = .T.
2033:                 .Top       = 9
2034:                 .Left      = 2
2035:                 .Height    = 17
2036:                 .Width     = 22
2037:             ENDWITH
2038: 
2039:             *- Col6: CkTotal - "Total" (CheckBox - total final)
2040:             loc_oCol = loc_oGrd.Column6
2041:             loc_oCol.Header1.Caption = "Total"
2042:             loc_oCol.Width  = 50
2043:             loc_oCol.Sparse = .F.
2044:             loc_oCol.AddObject("chk_4c_CkTotal", "CheckBox")
2045:             loc_oCol.CurrentControl = "chk_4c_CkTotal"
2046:             WITH loc_oCol.chk_4c_CkTotal
2047:                 .Caption   = ""
2048:                 .Alignment = 0
2049:                 .ReadOnly  = .F.
2050:                 .Visible   = .T.
2051:                 .Top       = 9
2052:                 .Left      = 2
2053:                 .Height    = 17
2054:                 .Width     = 22
2055:             ENDWITH
2056: 
2057:             *- Col7: LblCaption - "Titulo do Campo" (EditBox - rotulo da coluna no relatorio)
2058:             loc_oCol = loc_oGrd.Column7
2059:             loc_oCol.Header1.Caption = "T" + CHR(237) + "tulo do Campo"
2060:             loc_oCol.Width  = 130
2061:             loc_oCol.Sparse = .F.
2062:             loc_oCol.AddObject("edt_4c_LblCaption", "EditBox")
2063:             loc_oCol.CurrentControl = "edt_4c_LblCaption"
2064:             WITH loc_oCol.edt_4c_LblCaption
2065:                 .Width      = 128
2066:                 .Height     = 28
2067:                 .ScrollBars = 0
2068:                 .FontName   = "Tahoma"
2069:                 .FontSize   = 8
2070:             ENDWITH
2071: 
2072:             *- Col8: LblFonte - "Fonte" (EditBox - fonte da coluna)
2073:             loc_oCol = loc_oGrd.Column8
2074:             loc_oCol.Header1.Caption = "Fonte"
2075:             loc_oCol.Width  = 130
2076:             loc_oCol.Sparse = .F.
2077:             loc_oCol.AddObject("edt_4c_LblFonte", "EditBox")
2078:             loc_oCol.CurrentControl = "edt_4c_LblFonte"
2079:             WITH loc_oCol.edt_4c_LblFonte
2080:                 .Width      = 128
2081:                 .Height     = 28
2082:                 .ScrollBars = 0
2083:                 .FontName   = "Tahoma"
2084:                 .FontSize   = 8
2085:             ENDWITH
2086: 
2087:             *- Col9: LblBtFonte - "Fte" (CommandButton - abre GETFONT)
2088:             loc_oCol = loc_oGrd.Column9
2089:             loc_oCol.Header1.Caption = "Fte"
2090:             loc_oCol.Width  = 65
2091:             loc_oCol.Sparse = .F.
2092:             loc_oCol.AddObject("cmd_4c_FonteCMP", "CommandButton")
2093:             loc_oCol.CurrentControl = "cmd_4c_FonteCMP"
2094:             WITH loc_oCol.cmd_4c_FonteCMP
2095:                 .Caption       = "..."
2096:                 .Width         = 60
2097:                 .Height        = 25
2098:                 .SpecialEffect = 0
2099:                 .FontName      = "Tahoma"
2100:                 .FontSize      = 8
2101:             ENDWITH
2102:             BINDEVENT(loc_oCol.cmd_4c_FonteCMP, "Click", THIS, "BtnFonteCMPClick")
2103: 
2104:             *- Col10: LblBtCor - "Cor" (CommandButton - abre GETCOLOR)
2105:             loc_oCol = loc_oGrd.Column10
2106:             loc_oCol.Header1.Caption = "Cor"
2107:             loc_oCol.Width  = 65
2108:             loc_oCol.Sparse = .F.
2109:             loc_oCol.AddObject("cmd_4c_CorCMP", "CommandButton")
2110:             loc_oCol.CurrentControl = "cmd_4c_CorCMP"
2111:             WITH loc_oCol.cmd_4c_CorCMP
2112:                 .Caption       = "..."
2113:                 .Width         = 60
2114:                 .Height        = 25
2115:                 .SpecialEffect = 0
2116:                 .FontName      = "Tahoma"
2117:                 .FontSize      = 8
2118:             ENDWITH
2119:             BINDEVENT(loc_oCol.cmd_4c_CorCMP, "Click", THIS, "BtnCorCMPClick")
2120: 
2121:             *- Col11: LblAlinhar - "Alinhar" (ComboBox)
2122:             loc_oCol = loc_oGrd.Column11
2123:             loc_oCol.Header1.Caption = "Alinhar"
2124:             loc_oCol.Width  = 80
2125:             loc_oCol.Sparse = .F.
2126:             loc_oCol.AddObject("cbo_4c_AlinharCMP", "ComboBox")
2127:             loc_oCol.CurrentControl = "cbo_4c_AlinharCMP"
2128:             WITH loc_oCol.cbo_4c_AlinharCMP
2129:                 .Style         = 2
2130:                 .RowSourceType = 1
2131:                 .RowSource     = "Esq.,Cen.,Dir."
2132:                 .Width         = 75
2133:                 .Height        = 24
2134:                 .FontName      = "Tahoma"
2135:                 .FontSize      = 8
2136:             ENDWITH
2137: 
2138:             *- Col12: LblTamCmp - "Tam." (Spinner - tamanho da fonte)
2139:             loc_oCol = loc_oGrd.Column12
2140:             loc_oCol.Header1.Caption = "Tam."
2141:             loc_oCol.Width  = 90
2142:             loc_oCol.Sparse = .F.
2143:             loc_oCol.AddObject("spn_4c_TamCMP", "Spinner")
2144:             loc_oCol.CurrentControl = "spn_4c_TamCMP"
2145:             WITH loc_oCol.spn_4c_TamCMP
2146:                 .Width            = 85
2147:                 .Height           = 24
2148:                 .SpinnerLowValue  = 6
2149:                 .SpinnerHighValue = 72
2150:                 .Increment        = 1
2151:             ENDWITH
2152: 
2153:             *=== Label "Totalizar pelo Campo:..." (Lbl_CmpGrupo) ===
2154:             par_oPage.AddObject("lbl_4c_CmpGrupo", "Label")
2155:             WITH par_oPage.lbl_4c_CmpGrupo

*-- Linhas 2165 a 2410:
2165:                 .Visible   = .T.
2166:             ENDWITH
2167: 
2168:             *=== GRADE 3: grd_4c_GRP (FwGrade3_GRP) - grupos/totalizacao, 7 colunas ===
2169:             par_oPage.AddObject("grd_4c_GRP", "Grid")
2170:             loc_oGrd = par_oPage.grd_4c_GRP
2171:             WITH loc_oGrd
2172:                 .Top              = 529
2173:                 .Left             = 4
2174:                 .Width            = 989
2175:                 .Height           = 67
2176:                 .ColumnCount      = 7
2177:                 .RecordSourceType = 1
2178:                 .RecordSource     = ""
2179:                 .GridLines        = 1
2180:                 .HeaderHeight     = 25
2181:                 .RowHeight        = 30
2182:                 .DeleteMark       = .F.
2183:                 .RecordMark       = .F.
2184:                 .ScrollBars       = 2
2185:                 .Visible          = .T.
2186:             ENDWITH
2187: 
2188:             *- Col1: NmCampo - "Grupo" (ComboBox - escolhe campo do SQL como agrupador)
2189:             loc_oCol = loc_oGrd.Column1
2190:             loc_oCol.Header1.Caption = "Grupo"
2191:             loc_oCol.Width  = 200
2192:             loc_oCol.Sparse = .F.
2193:             loc_oCol.AddObject("cbo_4c_NmCampoGRP", "ComboBox")
2194:             loc_oCol.CurrentControl = "cbo_4c_NmCampoGRP"
2195:             WITH loc_oCol.cbo_4c_NmCampoGRP
2196:                 .Style         = 2
2197:                 .RowSourceType = 1
2198:                 .RowSource     = ""
2199:                 .Width         = 195
2200:                 .Height        = 24
2201:                 .FontName      = "Tahoma"
2202:                 .FontSize      = 8
2203:             ENDWITH
2204: 
2205:             *- Col2: LblCaption - "Titulo do Campo" (EditBox)
2206:             loc_oCol = loc_oGrd.Column2
2207:             loc_oCol.Header1.Caption = "T" + CHR(237) + "tulo do Campo"
2208:             loc_oCol.Width  = 160
2209:             loc_oCol.Sparse = .F.
2210:             loc_oCol.AddObject("edt_4c_GrpCaption", "EditBox")
2211:             loc_oCol.CurrentControl = "edt_4c_GrpCaption"
2212:             WITH loc_oCol.edt_4c_GrpCaption
2213:                 .Width      = 158
2214:                 .Height     = 28
2215:                 .ScrollBars = 0
2216:                 .FontName   = "Tahoma"
2217:                 .FontSize   = 8
2218:             ENDWITH
2219: 
2220:             *- Col3: LblFonte - "Fonte" (EditBox)
2221:             loc_oCol = loc_oGrd.Column3
2222:             loc_oCol.Header1.Caption = "Fonte"
2223:             loc_oCol.Width  = 160
2224:             loc_oCol.Sparse = .F.
2225:             loc_oCol.AddObject("edt_4c_GrpFonte", "EditBox")
2226:             loc_oCol.CurrentControl = "edt_4c_GrpFonte"
2227:             WITH loc_oCol.edt_4c_GrpFonte
2228:                 .Width      = 158
2229:                 .Height     = 28
2230:                 .ScrollBars = 0
2231:                 .FontName   = "Tahoma"
2232:                 .FontSize   = 8
2233:             ENDWITH
2234: 
2235:             *- Col4: LblBtFonte - "Fte" (CommandButton - abre GETFONT)
2236:             loc_oCol = loc_oGrd.Column4
2237:             loc_oCol.Header1.Caption = "Fte"
2238:             loc_oCol.Width  = 80
2239:             loc_oCol.Sparse = .F.
2240:             loc_oCol.AddObject("cmd_4c_FonteGRP", "CommandButton")
2241:             loc_oCol.CurrentControl = "cmd_4c_FonteGRP"
2242:             WITH loc_oCol.cmd_4c_FonteGRP
2243:                 .Caption       = "..."
2244:                 .Width         = 75
2245:                 .Height        = 25
2246:                 .SpecialEffect = 0
2247:                 .FontName      = "Tahoma"
2248:                 .FontSize      = 8
2249:             ENDWITH
2250:             BINDEVENT(loc_oCol.cmd_4c_FonteGRP, "Click", THIS, "BtnFonteGRPClick")
2251: 
2252:             *- Col5: BtCor - "Cor" (CommandButton - abre GETCOLOR)
2253:             loc_oCol = loc_oGrd.Column5
2254:             loc_oCol.Header1.Caption = "Cor"
2255:             loc_oCol.Width  = 80
2256:             loc_oCol.Sparse = .F.
2257:             loc_oCol.AddObject("cmd_4c_CorGRP", "CommandButton")
2258:             loc_oCol.CurrentControl = "cmd_4c_CorGRP"
2259:             WITH loc_oCol.cmd_4c_CorGRP
2260:                 .Caption       = "..."
2261:                 .Width         = 75
2262:                 .Height        = 25
2263:                 .SpecialEffect = 0
2264:                 .FontName      = "Tahoma"
2265:                 .FontSize      = 8
2266:             ENDWITH
2267:             BINDEVENT(loc_oCol.cmd_4c_CorGRP, "Click", THIS, "BtnCorGRPClick")
2268: 
2269:             *- Col6: LblAlinhar - "Alinhar" (ComboBox)
2270:             loc_oCol = loc_oGrd.Column6
2271:             loc_oCol.Header1.Caption = "Alinhar"
2272:             loc_oCol.Width  = 160
2273:             loc_oCol.Sparse = .F.
2274:             loc_oCol.AddObject("cbo_4c_AlinharGRP", "ComboBox")
2275:             loc_oCol.CurrentControl = "cbo_4c_AlinharGRP"
2276:             WITH loc_oCol.cbo_4c_AlinharGRP
2277:                 .Style         = 2
2278:                 .RowSourceType = 1
2279:                 .RowSource     = "Esq.,Cen.,Dir."
2280:                 .Width         = 155
2281:                 .Height        = 24
2282:                 .FontName      = "Tahoma"
2283:                 .FontSize      = 8
2284:             ENDWITH
2285: 
2286:             *- Col7: LblTamCmp - "Tam." (Spinner)
2287:             loc_oCol = loc_oGrd.Column7
2288:             loc_oCol.Header1.Caption = "Tam."
2289:             loc_oCol.Width  = 149
2290:             loc_oCol.Sparse = .F.
2291:             loc_oCol.AddObject("spn_4c_TamGRP", "Spinner")
2292:             loc_oCol.CurrentControl = "spn_4c_TamGRP"
2293:             WITH loc_oCol.spn_4c_TamGRP
2294:                 .Width            = 120
2295:                 .Height           = 24
2296:                 .SpinnerLowValue  = 6
2297:                 .SpinnerHighValue = 72
2298:                 .Increment        = 1
2299:             ENDWITH
2300: 
2301:         CATCH TO loc_oErro
2302:             MsgErro(loc_oErro.Message, "FormRPT.ConfigurarGradesDesigner")
2303:         ENDTRY
2304:     ENDPROC
2305: 
2306:     *==========================================================================
2307:     * BtnFonteTITClick - Abre GETFONT para o campo TpFonte da grade grd_4c_TIT
2308:     *==========================================================================
2309:     PROCEDURE BtnFonteTITClick()
2310:         LOCAL loc_cFonte
2311:         TRY
2312:             loc_cFonte = GETFONT()
2313:             IF !EMPTY(loc_cFonte) AND USED("CrsProps_Titulo") AND !EOF("CrsProps_Titulo")
2314:                 REPLACE CrsProps_Titulo.LblFonte WITH loc_cFonte IN CrsProps_Titulo
2315:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_TIT.Refresh()
2316:             ENDIF
2317:         CATCH TO loc_oErro
2318:             MsgErro(loc_oErro.Message, "FormRPT.BtnFonteTITClick")
2319:         ENDTRY
2320:     ENDPROC
2321: 
2322:     *==========================================================================
2323:     * BtnCorTITClick - Abre GETCOLOR para o campo LblBtCor da grade grd_4c_TIT
2324:     *==========================================================================
2325:     PROCEDURE BtnCorTITClick()
2326:         LOCAL loc_nCor
2327:         TRY
2328:             loc_nCor = GETCOLOR()
2329:             IF loc_nCor >= 0 AND USED("CrsProps_Titulo") AND !EOF("CrsProps_Titulo")
2330:                 REPLACE CrsProps_Titulo.LblBtCor WITH loc_nCor IN CrsProps_Titulo
2331:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_TIT.Refresh()
2332:             ENDIF
2333:         CATCH TO loc_oErro
2334:             MsgErro(loc_oErro.Message, "FormRPT.BtnCorTITClick")
2335:         ENDTRY
2336:     ENDPROC
2337: 
2338:     *==========================================================================
2339:     * BtnFonteCMPClick - Abre GETFONT para LblFonte da linha atual de grd_4c_CMPs
2340:     *==========================================================================
2341:     PROCEDURE BtnFonteCMPClick()
2342:         LOCAL loc_cFonte
2343:         TRY
2344:             loc_cFonte = GETFONT()
2345:             IF !EMPTY(loc_cFonte) AND USED("CrsProps_Campos") AND !EOF("CrsProps_Campos")
2346:                 REPLACE CrsProps_Campos.LblFonte WITH loc_cFonte IN CrsProps_Campos
2347:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_CMPs.Refresh()
2348:             ENDIF
2349:         CATCH TO loc_oErro
2350:             MsgErro(loc_oErro.Message, "FormRPT.BtnFonteCMPClick")
2351:         ENDTRY
2352:     ENDPROC
2353: 
2354:     *==========================================================================
2355:     * BtnCorCMPClick - Abre GETCOLOR para LblBtCor da linha atual de grd_4c_CMPs
2356:     *==========================================================================
2357:     PROCEDURE BtnCorCMPClick()
2358:         LOCAL loc_nCor
2359:         TRY
2360:             loc_nCor = GETCOLOR()
2361:             IF loc_nCor >= 0 AND USED("CrsProps_Campos") AND !EOF("CrsProps_Campos")
2362:                 REPLACE CrsProps_Campos.LblBtCor WITH loc_nCor IN CrsProps_Campos
2363:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_CMPs.Refresh()
2364:             ENDIF
2365:         CATCH TO loc_oErro
2366:             MsgErro(loc_oErro.Message, "FormRPT.BtnCorCMPClick")
2367:         ENDTRY
2368:     ENDPROC
2369: 
2370:     *==========================================================================
2371:     * BtnFonteGRPClick - Abre GETFONT para LblFonte da linha atual de grd_4c_GRP
2372:     *==========================================================================
2373:     PROCEDURE BtnFonteGRPClick()
2374:         LOCAL loc_cFonte
2375:         TRY
2376:             loc_cFonte = GETFONT()
2377:             IF !EMPTY(loc_cFonte) AND USED("CrsProps_GRP") AND !EOF("CrsProps_GRP")
2378:                 REPLACE CrsProps_GRP.LblFonte WITH loc_cFonte IN CrsProps_GRP
2379:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_GRP.Refresh()
2380:             ENDIF
2381:         CATCH TO loc_oErro
2382:             MsgErro(loc_oErro.Message, "FormRPT.BtnFonteGRPClick")
2383:         ENDTRY
2384:     ENDPROC
2385: 
2386:     *==========================================================================
2387:     * BtnCorGRPClick - Abre GETCOLOR para LblBtCor da linha atual de grd_4c_GRP
2388:     *==========================================================================
2389:     PROCEDURE BtnCorGRPClick()
2390:         LOCAL loc_nCor
2391:         TRY
2392:             loc_nCor = GETCOLOR()
2393:             IF loc_nCor >= 0 AND USED("CrsProps_GRP") AND !EOF("CrsProps_GRP")
2394:                 REPLACE CrsProps_GRP.LblBtCor WITH loc_nCor IN CrsProps_GRP
2395:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_GRP.Refresh()
2396:             ENDIF
2397:         CATCH TO loc_oErro
2398:             MsgErro(loc_oErro.Message, "FormRPT.BtnCorGRPClick")
2399:         ENDTRY
2400:     ENDPROC
2401: 
2402:     *==========================================================================
2403:     * FormatarGridLista - Formata visual do grid da lista
2404:     *==========================================================================
2405:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
2406:         WITH par_oGrid
2407:             .FontName = "Verdana"
2408:             .FontSize = 8
2409:         ENDWITH
2410:     ENDPROC

*-- Linhas 2503 a 2561:
2503:             IF USED("CrsProps_Titulo")
2504:                 USE IN CrsProps_Titulo
2505:             ENDIF
2506:             CREATE CURSOR CrsProps_Titulo ( ;
2507:                 NmCampo    C(40),  ;
2508:                 TpCampo    C(10),  ;
2509:                 CkOutRPT   I,      ;
2510:                 CkFiltro   I,      ;
2511:                 CkSubTot   I,      ;
2512:                 CkTotal    I,      ;
2513:                 LblCaption C(200), ;
2514:                 LblFonte   C(50),  ;
2515:                 LblBtFonte C(1),   ;
2516:                 LblBtCor   I,      ;
2517:                 LblAlinhar C(6),   ;
2518:                 LblTamCmp  I,      ;
2519:                 LblTipoCmp C(1)    ;
2520:             )
2521: 
2522:             *-- Cursor de campos do relatorio
2523:             IF USED("CrsProps_Campos")
2524:                 USE IN CrsProps_Campos
2525:             ENDIF
2526:             CREATE CURSOR CrsProps_Campos ( ;
2527:                 NmCampo    C(40),  ;
2528:                 TpCampo    C(10),  ;
2529:                 CkOutRPT   I,      ;
2530:                 CkFiltro   I,      ;
2531:                 CkSubTot   I,      ;
2532:                 CkTotal    I,      ;
2533:                 LblCaption C(200), ;
2534:                 LblFonte   C(50),  ;
2535:                 LblBtFonte C(1),   ;
2536:                 LblBtCor   I,      ;
2537:                 LblAlinhar C(6),   ;
2538:                 LblTamCmp  I,      ;
2539:                 LblTipoCmp C(1)    ;
2540:             )
2541: 
2542:             *-- Cursor de agrupamento do relatorio
2543:             IF USED("CrsProps_GRP")
2544:                 USE IN CrsProps_GRP
2545:             ENDIF
2546:             CREATE CURSOR CrsProps_GRP ( ;
2547:                 NmCampo    C(40),  ;
2548:                 TpCampo    C(10),  ;
2549:                 LblCaption C(200), ;
2550:                 LblFonte   C(50),  ;
2551:                 LblBtFonte C(1),   ;
2552:                 LblBtCor   I,      ;
2553:                 LblAlinhar C(6),   ;
2554:                 LblTamCmp  I       ;
2555:             )
2556:         CATCH TO loc_oErro
2557:             MsgErro(loc_oErro.Message, "FormRPT.CriarCursoresDesigner")
2558:         ENDTRY
2559:     ENDPROC
2560: 
2561:     *==========================================================================

