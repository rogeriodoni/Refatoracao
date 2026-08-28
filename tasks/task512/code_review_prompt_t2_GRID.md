# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1248: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormRPT.prg) - TRECHOS RELEVANTES PARA PASS GRID (2830 linhas total):

*-- Linhas 352 a 389:
352:             ENDWITH
353:             BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
354: 
355:             loc_oPagina.AddObject("grd_4c_Lista", "Grid")
356:             WITH loc_oPagina.grd_4c_Lista
357:                 .Top                = 117
358:                 .Left               = 2
359:                 .Width              = 998
360:                 .Height             = 498
361:                 .FontName           = "Verdana"
362:                 .FontSize           = 8
363:                 .ForeColor          = RGB(90, 90, 90)
364:                 .BackColor          = RGB(255, 255, 255)
365:                 .GridLineColor      = RGB(238, 238, 238)
366:                 .HighlightBackColor = RGB(255, 255, 255)
367:                 .HighlightForeColor = RGB(15, 41, 104)
368:                 .HighlightStyle     = 2
369:                 .DeleteMark         = .F.
370:                 .RecordMark         = .F.
371:                 .RowHeight          = 16
372:                 .ScrollBars         = 2
373:                 .GridLines          = 3
374:                 .ColumnCount        = 5
375:                 .Visible            = .T.
376:             ENDWITH
377: 
378:             THIS.TornarControlesVisiveis(loc_oPagina)
379:         CATCH TO loc_oErro
380:             MsgErro(loc_oErro.Message, "FormRPT.ConfigurarPaginaLista")
381:         ENDTRY
382:     ENDPROC
383: 
384:     *==========================================================================
385:     * ConfigurarPaginaDados - Page2 externa: botoes Confirmar/Cancelar + PageFrame interno
386:     *   pgf_4c_Dados.Page1 = Editor SQL (campos + editor + grade resultado)
387:     *   pgf_4c_Dados.Page2 = Designer layout (Fase 6)
388:     *==========================================================================
389:     PROTECTED PROCEDURE ConfigurarPaginaDados()

*-- Linhas 897 a 971:
897:             BINDEVENT(par_oPage.edt_4c_SqlCMD, "Change", THIS, "SqlCMDChange")
898: 
899:             *-- Grade de resultados SQL (FwGrade1_Resultado no legado)
900:             par_oPage.AddObject("grd_4c_Resultado", "Grid")
901:             WITH par_oPage.grd_4c_Resultado
902:                 .Top                = 379
903:                 .Left               = 8
904:                 .Width              = 986
905:                 .Height             = 218
906:                 .FontName           = "Verdana"
907:                 .FontSize           = 8
908:                 .ForeColor          = RGB(90, 90, 90)
909:                 .BackColor          = RGB(255, 255, 255)
910:                 .GridLineColor      = RGB(238, 238, 238)
911:                 .HighlightBackColor = RGB(255, 255, 255)
912:                 .HighlightForeColor = RGB(15, 41, 104)
913:                 .HighlightStyle     = 2
914:                 .DeleteMark         = .F.
915:                 .RecordMark         = .F.
916:                 .RowHeight          = 16
917:                 .ScrollBars         = 3
918:                 .GridLines          = 3
919:                 .ColumnCount        = 0
920:                 .ReadOnly           = .T.
921:                 .Visible            = .T.
922:             ENDWITH
923:         CATCH TO loc_oErro
924:             MsgErro(loc_oErro.Message, "FormRPT.ConfigurarEditorSQL")
925:         ENDTRY
926:     ENDPROC
927: 
928:     *==========================================================================
929:     * CarregarLista - Carrega lista de relatorios no grid
930:     *==========================================================================
931:     PROCEDURE CarregarLista()
932:         LOCAL loc_lResultado, loc_oGrid
933:         loc_lResultado = .F.
934: 
935:         TRY
936:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
937:                 loc_lResultado = .T.
938:             ELSE
939:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
940:                 IF THIS.this_oBusinessObject.Buscar("")
941:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
942: 
943:                     loc_oGrid.ColumnCount = 5
944:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
945:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.NmReport"
946:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descr"
947:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.DtCriacao"
948:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.DtAlteracao"
949:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Ativo"
950: 
951:                     *-- Redefinir headers APOS RecordSource (CRITICO - Problema 6)
952:                     loc_oGrid.Column1.Header1.Caption = "Titulo"
953:                     loc_oGrid.Column2.Header1.Caption = "Descr"
954:                     loc_oGrid.Column3.Header1.Caption = "DtCriacao"
955:                     loc_oGrid.Column4.Header1.Caption = "DtAlteracao"
956:                     loc_oGrid.Column5.Header1.Caption = "Ativo"
957: 
958:                     loc_oGrid.Column1.Width = 350
959:                     loc_oGrid.Column2.Width = 350
960:                     loc_oGrid.Column3.Width = 90
961:                     loc_oGrid.Column4.Width = 90
962:                     loc_oGrid.Column5.Width = 50
963: 
964:                     THIS.FormatarGridLista(loc_oGrid)
965: 
966:                     loc_lResultado = .T.
967:                 ENDIF
968:                 ENDIF
969:             ENDIF
970:         CATCH TO loc_oErro
971:             MsgErro(loc_oErro.Message, "FormRPT.CarregarLista")

*-- Linhas 1132 a 1164:
1132: 
1133:             IF VARTYPE(loc_cFiltro) = "C"
1134:                 IF THIS.this_oBusinessObject.Buscar(ALLTRIM(loc_cFiltro))
1135:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1136: 
1137:                     loc_oGrid.ColumnCount = 5
1138:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1139:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.NmReport"
1140:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descr"
1141:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.DtCriacao"
1142:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.DtAlteracao"
1143:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Ativo"
1144: 
1145:                     loc_oGrid.Column1.Header1.Caption = "Titulo"
1146:                     loc_oGrid.Column2.Header1.Caption = "Descr"
1147:                     loc_oGrid.Column3.Header1.Caption = "DtCriacao"
1148:                     loc_oGrid.Column4.Header1.Caption = "DtAlteracao"
1149:                     loc_oGrid.Column5.Header1.Caption = "Ativo"
1150: 
1151:                     loc_oGrid.Column1.Width = 350
1152:                     loc_oGrid.Column2.Width = 350
1153:                     loc_oGrid.Column3.Width = 90
1154:                     loc_oGrid.Column4.Width = 90
1155:                     loc_oGrid.Column5.Width = 50
1156: 
1157:                     THIS.FormatarGridLista(loc_oGrid)
1158:                     loc_oGrid.Refresh()
1159:                 ENDIF
1160:             ENDIF
1161:         CATCH TO loc_oErro
1162:             MsgErro(loc_oErro.Message, "FormRPT.BtnBuscarClick")
1163:         ENDTRY
1164:     ENDPROC

*-- Linhas 1226 a 1268:
1226:             ENDIF
1227: 
1228:             IF loc_lProsseguir
1229:                 loc_oGrid = loc_oPage.grd_4c_Resultado
1230:                 loc_oGrid.ColumnCount = 0
1231:                 IF USED("cursor_4c_SqlResult")
1232:                     USE IN cursor_4c_SqlResult
1233:                 ENDIF
1234:                 IF USED("cursor_4c_SqlResultTemp")
1235:                     USE IN cursor_4c_SqlResultTemp
1236:                 ENDIF
1237: 
1238:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SqlResultTemp")
1239: 
1240:                 IF loc_nResultado >= 0
1241:                     loc_nCols = AFIELDS(laFields, "cursor_4c_SqlResultTemp")
1242:                     SELECT * FROM cursor_4c_SqlResultTemp INTO CURSOR cursor_4c_SqlResult READWRITE
1243:                     IF USED("cursor_4c_SqlResultTemp")
1244:                         USE IN cursor_4c_SqlResultTemp
1245:                     ENDIF
1246: 
1247:                     loc_oGrid.ColumnCount = 3
1248:                     loc_oGrid.RecordSource = "cursor_4c_SqlResult"
1249:                     loc_oGrid.ColumnCount  = loc_nCols
1250: 
1251:                     FOR loc_nI = 1 TO loc_nCols
1252:                         loc_oGrid.Columns(loc_nI).ControlSource = "cursor_4c_SqlResult." + laFields[loc_nI, 1]
1253:                         loc_oGrid.Columns(loc_nI).Header1.Caption = laFields[loc_nI, 1]
1254:                         loc_oGrid.Columns(loc_nI).Width = 100
1255:                     ENDFOR
1256: 
1257:                     loc_oPage.lbl_4c_SqlAlterado.Caption = ""
1258:                     THIS.this_oBusinessObject.this_cSqlQuery = loc_cSQL
1259:                     loc_oGrid.Refresh()
1260: 
1261:                     MsgInfo(ALLTRIM(STR(RECCOUNT("cursor_4c_SqlResult"))) + ;
1262:                             " registro(s) retornado(s).")
1263:                 ELSE
1264:                     MsgErro("Erro ao executar SQL:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1265:                 ENDIF
1266:             ENDIF
1267:         CATCH TO loc_oErro
1268:             MsgErro(loc_oErro.Message, "FormRPT.BtnProcessarClick")

*-- Linhas 1413 a 1436:
1413: 
1414:                 *-- Vincula cursores as grades do designer
1415:                 loc_oDesignerPage = loc_oPgfDados.Page2
1416:                 loc_oDesignerPage.grd_4c_TIT.RecordSource  = "CrsProps_Titulo"
1417:                 loc_oDesignerPage.grd_4c_CMPs.RecordSource = "CrsProps_Campos"
1418:                 loc_oDesignerPage.grd_4c_GRP.RecordSource  = "CrsProps_GRP"
1419:                 loc_oDesignerPage.grd_4c_TIT.Refresh()
1420:                 loc_oDesignerPage.grd_4c_CMPs.Refresh()
1421:                 loc_oDesignerPage.grd_4c_GRP.Refresh()
1422: 
1423:                 *-- Navega para o Designer (Page2 do pgf_4c_Dados)
1424:                 loc_oPgfDados.ActivePage = 2
1425:             ENDIF
1426:         CATCH TO loc_oErro
1427:             MsgErro(loc_oErro.Message, "FormRPT.BtnLayoutClick")
1428:         ENDTRY
1429:     ENDPROC
1430: 
1431:     *==========================================================================
1432:     * SqlCMDChange - Marca asterisco quando SQL e editado (evento BINDEVENT)
1433:     *==========================================================================
1434:     PROCEDURE SqlCMDChange()
1435:         TRY
1436:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1.lbl_4c_SqlAlterado.Caption = "*"

*-- Linhas 1547 a 1565:
1547:                     .RowSourceType = 2
1548:                     .RowSource     = "cursor_4c_ReportNomes"
1549:                     .BoundColumn   = 1
1550:                     .ColumnCount   = 1
1551:                 ENDWITH
1552:             ENDIF
1553:         CATCH TO loc_oErro
1554:             MsgErro(loc_oErro.Message, "FormRPT.PopularComboReports")
1555:         ENDTRY
1556:     ENDPROC
1557: 
1558:     *==========================================================================
1559:     * ConfigurarDesignerLayout - Page2 interna (Designer de Layout do Relatorio)
1560:     * Fase 5 Parte 2: botoes Voltar/SalvarRPT, labels, orientacao, tamanho papel
1561:     * Coords: direto do SCX Pageframe1.Page2 (sem ajuste - simetria dos dois Top=-29)
1562:     *==========================================================================
1563:     PROTECTED PROCEDURE ConfigurarDesignerLayout(par_oPage)
1564:         TRY
1565:             *-- Container botoes de acao do designer (CmdGrp_Acoes no legado - 2 botoes)

*-- Linhas 1695 a 1713:
1695:                 .FontName      = "Tahoma"
1696:                 .FontSize      = 8
1697:                 .RowSourceType = 0
1698:                 .ColumnCount   = 1
1699:                 .BoundColumn   = 1
1700:                 .Visible       = .T.
1701:             ENDWITH
1702:             THIS.PopularCboTamPapel(par_oPage.cbo_4c_TamPapel)
1703: 
1704:             *-- Label nome do relatorio (Lbl_Nm_Relatorio no legado)
1705:             par_oPage.AddObject("lbl_4c_NmRelatorio", "Label")
1706:             WITH par_oPage.lbl_4c_NmRelatorio
1707:                 .Top       = 131
1708:                 .Left      = 10
1709:                 .Width     = 540
1710:                 .Height    = 22
1711:                 .Caption   = ""
1712:                 .FontName  = "Tahoma"
1713:                 .FontSize  = 10

*-- Linhas 1850 a 2180:
1850: 
1851:     *==========================================================================
1852:     * ConfigurarGradesDesigner - Fase 6: 3 grades da Page2 interna (Designer)
1853:     * grd_4c_TIT (5 cols/Top=180), grd_4c_CMPs (12 cols/Top=258), grd_4c_GRP (7 cols/Top=529)
1854:     * RecordSource definido em runtime quando cursor de dados e carregado
1855:     *==========================================================================
1856:     PROTECTED PROCEDURE ConfigurarGradesDesigner(par_oPage)
1857:         LOCAL loc_oGrd, loc_oCol
1858:         TRY
1859:             *=== GRADE 1: grd_4c_TIT (FwGrade1_TIT) - titulo/cabecalho, 5 colunas ===
1860:             par_oPage.AddObject("grd_4c_TIT", "Grid")
1861:             loc_oGrd = par_oPage.grd_4c_TIT
1862:             WITH loc_oGrd
1863:                 .Top              = 180
1864:                 .Left             = 4
1865:                 .Width            = 990
1866:                 .Height           = 65
1867:                 .ColumnCount      = 5
1868:                 .RecordSourceType = 1
1869:                 .RecordSource     = ""
1870:                 .GridLines        = 1
1871:                 .HeaderHeight     = 25
1872:                 .RowHeight        = 30
1873:                 .DeleteMark       = .F.
1874:                 .RecordMark       = .F.
1875:                 .ScrollBars       = 2
1876:                 .Visible          = .T.
1877:             ENDWITH
1878: 
1879:             *- Col1: LblCaption - "Titulo" (EditBox)
1880:             loc_oCol = loc_oGrd.Column1
1881:             loc_oCol.Header1.Caption = "Titulo"
1882:             loc_oCol.Width  = 300
1883:             loc_oCol.Sparse = .F.
1884:             loc_oCol.AddObject("edt_4c_TitCaption", "EditBox")
1885:             loc_oCol.CurrentControl = "edt_4c_TitCaption"
1886:             WITH loc_oCol.edt_4c_TitCaption
1887:                 .Width      = 298
1888:                 .Height     = 28
1889:                 .ScrollBars = 0
1890:             ENDWITH
1891: 
1892:             *- Col2: LblFonte - "Fonte" (EditBox - string "FontName,Size,Style")
1893:             loc_oCol = loc_oGrd.Column2
1894:             loc_oCol.Header1.Caption = "Fonte"
1895:             loc_oCol.Width  = 230
1896:             loc_oCol.Sparse = .F.
1897:             loc_oCol.AddObject("edt_4c_TitFonte", "EditBox")
1898:             loc_oCol.CurrentControl = "edt_4c_TitFonte"
1899:             WITH loc_oCol.edt_4c_TitFonte
1900:                 .Width      = 228
1901:                 .Height     = 28
1902:                 .ScrollBars = 0
1903:             ENDWITH
1904: 
1905:             *- Col3: BtFonte - "Fte" (CommandButton - abre dialogo GETFONT)
1906:             loc_oCol = loc_oGrd.Column3
1907:             loc_oCol.Header1.Caption = "Fte"
1908:             loc_oCol.Width  = 80
1909:             loc_oCol.Sparse = .F.
1910:             loc_oCol.AddObject("cmd_4c_FonteTIT", "CommandButton")
1911:             loc_oCol.CurrentControl = "cmd_4c_FonteTIT"
1912:             WITH loc_oCol.cmd_4c_FonteTIT
1913:                 .Caption       = "..."
1914:                 .Width         = 75
1915:                 .Height        = 25
1916:                 .SpecialEffect = 0
1917:                 .FontName      = "Tahoma"
1918:                 .FontSize      = 8
1919:             ENDWITH
1920:             BINDEVENT(loc_oCol.cmd_4c_FonteTIT, "Click", THIS, "BtnFonteTITClick")
1921: 
1922:             *- Col4: BtCor - "Cor" (CommandButton - abre GETCOLOR)
1923:             loc_oCol = loc_oGrd.Column4
1924:             loc_oCol.Header1.Caption = "Cor"
1925:             loc_oCol.Width  = 80
1926:             loc_oCol.Sparse = .F.
1927:             loc_oCol.AddObject("cmd_4c_CorTIT", "CommandButton")
1928:             loc_oCol.CurrentControl = "cmd_4c_CorTIT"
1929:             WITH loc_oCol.cmd_4c_CorTIT
1930:                 .Caption       = "..."
1931:                 .Width         = 75
1932:                 .Height        = 25
1933:                 .SpecialEffect = 0
1934:                 .FontName      = "Tahoma"
1935:                 .FontSize      = 8
1936:             ENDWITH
1937:             BINDEVENT(loc_oCol.cmd_4c_CorTIT, "Click", THIS, "BtnCorTITClick")
1938: 
1939:             *- Col5: LblAlinhar - "Alinhar" (ComboBox Esq./Cen./Dir.)
1940:             loc_oCol = loc_oGrd.Column5
1941:             loc_oCol.Header1.Caption = "Alinhar"
1942:             loc_oCol.Width  = 300
1943:             loc_oCol.Sparse = .F.
1944:             loc_oCol.AddObject("cbo_4c_AlinharTIT", "ComboBox")
1945:             loc_oCol.CurrentControl = "cbo_4c_AlinharTIT"
1946:             WITH loc_oCol.cbo_4c_AlinharTIT
1947:                 .Style         = 2
1948:                 .RowSourceType = 1
1949:                 .RowSource     = "Esq.,Cen.,Dir."
1950:                 .Width         = 120
1951:                 .Height        = 24
1952:                 .FontName      = "Tahoma"
1953:                 .FontSize      = 8
1954:             ENDWITH
1955: 
1956:             *=== GRADE 2: grd_4c_CMPs (FwGrade2_CMPs) - campos do relatorio, 12 colunas ===
1957:             par_oPage.AddObject("grd_4c_CMPs", "Grid")
1958:             loc_oGrd = par_oPage.grd_4c_CMPs
1959:             WITH loc_oGrd
1960:                 .Top              = 258
1961:                 .Left             = 4
1962:                 .Width            = 990
1963:                 .Height           = 238
1964:                 .ColumnCount      = 12
1965:                 .RecordSourceType = 1
1966:                 .RecordSource     = ""
1967:                 .GridLines        = 1
1968:                 .HeaderHeight     = 25
1969:                 .RowHeight        = 30
1970:                 .DeleteMark       = .F.
1971:                 .RecordMark       = .F.
1972:                 .ScrollBars       = 3
1973:                 .Visible          = .T.
1974:             ENDWITH
1975: 
1976:             *- Col1: NmCampo - "Campo" (TextBox, readonly - nome do campo do SQL)
1977:             loc_oCol = loc_oGrd.Column1
1978:             loc_oCol.Header1.Caption = "Campo"
1979:             loc_oCol.Width    = 140
1980:             loc_oCol.Sparse   = .F.
1981:             loc_oCol.ReadOnly = .T.
1982:             loc_oCol.AddObject("txt_4c_NmCampo", "TextBox")
1983:             loc_oCol.CurrentControl = "txt_4c_NmCampo"
1984:             WITH loc_oCol.txt_4c_NmCampo
1985:                 .Width     = 138
1986:                 .Height    = 23
1987:                 .ReadOnly  = .T.
1988:                 .BackColor = RGB(240, 240, 240)
1989:                 .FontName  = "Tahoma"
1990:                 .FontSize  = 8
1991:             ENDWITH
1992: 
1993:             *- Col2: TpCampo - "Tipo" (TextBox, readonly - tipo do campo)
1994:             loc_oCol = loc_oGrd.Column2
1995:             loc_oCol.Header1.Caption = "Tipo"
1996:             loc_oCol.Width    = 75
1997:             loc_oCol.Sparse   = .F.
1998:             loc_oCol.ReadOnly = .T.
1999:             loc_oCol.AddObject("txt_4c_TpCampo", "TextBox")
2000:             loc_oCol.CurrentControl = "txt_4c_TpCampo"
2001:             WITH loc_oCol.txt_4c_TpCampo
2002:                 .Width     = 73
2003:                 .Height    = 23
2004:                 .ReadOnly  = .T.
2005:                 .BackColor = RGB(240, 240, 240)
2006:                 .FontName  = "Tahoma"
2007:                 .FontSize  = 8
2008:             ENDWITH
2009: 
2010:             *- Col3: CkOutRPT - "Saida Rel." (CheckBox - inclui campo na saida do relatorio)
2011:             loc_oCol = loc_oGrd.Column3
2012:             loc_oCol.Header1.Caption = "Sa" + CHR(237) + "da Rel."
2013:             loc_oCol.Width  = 60
2014:             loc_oCol.Sparse = .F.
2015:             loc_oCol.AddObject("chk_4c_SaidaRPT", "CheckBox")
2016:             loc_oCol.CurrentControl = "chk_4c_SaidaRPT"
2017:             WITH loc_oCol.chk_4c_SaidaRPT
2018:                 .Caption   = ""
2019:                 .Alignment = 0
2020:                 .ReadOnly  = .F.
2021:                 .Visible   = .T.
2022:                 .Top       = 9
2023:                 .Left      = 2
2024:                 .Height    = 17
2025:                 .Width     = 22
2026:             ENDWITH
2027: 
2028:             *- Col4: CkFiltro - "Filtro" (CheckBox - habilita como filtro)
2029:             loc_oCol = loc_oGrd.Column4
2030:             loc_oCol.Header1.Caption = "Filtro"
2031:             loc_oCol.Width  = 50
2032:             loc_oCol.Sparse = .F.
2033:             loc_oCol.AddObject("chk_4c_CkFiltro", "CheckBox")
2034:             loc_oCol.CurrentControl = "chk_4c_CkFiltro"
2035:             WITH loc_oCol.chk_4c_CkFiltro
2036:                 .Caption   = ""
2037:                 .Alignment = 0
2038:                 .ReadOnly  = .F.
2039:                 .Visible   = .T.
2040:                 .Top       = 9
2041:                 .Left      = 2
2042:                 .Height    = 17
2043:                 .Width     = 22
2044:             ENDWITH
2045: 
2046:             *- Col5: CkSubTot - "SubTot" (CheckBox - subtotalizar)
2047:             loc_oCol = loc_oGrd.Column5
2048:             loc_oCol.Header1.Caption = "SubTot"
2049:             loc_oCol.Width  = 55
2050:             loc_oCol.Sparse = .F.
2051:             loc_oCol.AddObject("chk_4c_CkSubTot", "CheckBox")
2052:             loc_oCol.CurrentControl = "chk_4c_CkSubTot"
2053:             WITH loc_oCol.chk_4c_CkSubTot
2054:                 .Caption   = ""
2055:                 .Alignment = 0
2056:                 .ReadOnly  = .F.
2057:                 .Visible   = .T.
2058:                 .Top       = 9
2059:                 .Left      = 2
2060:                 .Height    = 17
2061:                 .Width     = 22
2062:             ENDWITH
2063: 
2064:             *- Col6: CkTotal - "Total" (CheckBox - total final)
2065:             loc_oCol = loc_oGrd.Column6
2066:             loc_oCol.Header1.Caption = "Total"
2067:             loc_oCol.Width  = 50
2068:             loc_oCol.Sparse = .F.
2069:             loc_oCol.AddObject("chk_4c_CkTotal", "CheckBox")
2070:             loc_oCol.CurrentControl = "chk_4c_CkTotal"
2071:             WITH loc_oCol.chk_4c_CkTotal
2072:                 .Caption   = ""
2073:                 .Alignment = 0
2074:                 .ReadOnly  = .F.
2075:                 .Visible   = .T.
2076:                 .Top       = 9
2077:                 .Left      = 2
2078:                 .Height    = 17
2079:                 .Width     = 22
2080:             ENDWITH
2081: 
2082:             *- Col7: LblCaption - "Titulo do Campo" (EditBox - rotulo da coluna no relatorio)
2083:             loc_oCol = loc_oGrd.Column7
2084:             loc_oCol.Header1.Caption = "Titulo do Campo"
2085:             loc_oCol.Width  = 130
2086:             loc_oCol.Sparse = .F.
2087:             loc_oCol.AddObject("edt_4c_LblCaption", "EditBox")
2088:             loc_oCol.CurrentControl = "edt_4c_LblCaption"
2089:             WITH loc_oCol.edt_4c_LblCaption
2090:                 .Width      = 128
2091:                 .Height     = 28
2092:                 .ScrollBars = 0
2093:                 .FontName   = "Tahoma"
2094:                 .FontSize   = 8
2095:             ENDWITH
2096: 
2097:             *- Col8: LblFonte - "Fonte" (EditBox - fonte da coluna)
2098:             loc_oCol = loc_oGrd.Column8
2099:             loc_oCol.Header1.Caption = "Fonte"
2100:             loc_oCol.Width  = 130
2101:             loc_oCol.Sparse = .F.
2102:             loc_oCol.AddObject("edt_4c_LblFonte", "EditBox")
2103:             loc_oCol.CurrentControl = "edt_4c_LblFonte"
2104:             WITH loc_oCol.edt_4c_LblFonte
2105:                 .Width      = 128
2106:                 .Height     = 28
2107:                 .ScrollBars = 0
2108:                 .FontName   = "Tahoma"
2109:                 .FontSize   = 8
2110:             ENDWITH
2111: 
2112:             *- Col9: LblBtFonte - "Fte" (CommandButton - abre GETFONT)
2113:             loc_oCol = loc_oGrd.Column9
2114:             loc_oCol.Header1.Caption = "Fte"
2115:             loc_oCol.Width  = 65
2116:             loc_oCol.Sparse = .F.
2117:             loc_oCol.AddObject("cmd_4c_FonteCMP", "CommandButton")
2118:             loc_oCol.CurrentControl = "cmd_4c_FonteCMP"
2119:             WITH loc_oCol.cmd_4c_FonteCMP
2120:                 .Caption       = "..."
2121:                 .Width         = 60
2122:                 .Height        = 25
2123:                 .SpecialEffect = 0
2124:                 .FontName      = "Tahoma"
2125:                 .FontSize      = 8
2126:             ENDWITH
2127:             BINDEVENT(loc_oCol.cmd_4c_FonteCMP, "Click", THIS, "BtnFonteCMPClick")
2128: 
2129:             *- Col10: LblBtCor - "Cor" (CommandButton - abre GETCOLOR)
2130:             loc_oCol = loc_oGrd.Column10
2131:             loc_oCol.Header1.Caption = "Cor"
2132:             loc_oCol.Width  = 65
2133:             loc_oCol.Sparse = .F.
2134:             loc_oCol.AddObject("cmd_4c_CorCMP", "CommandButton")
2135:             loc_oCol.CurrentControl = "cmd_4c_CorCMP"
2136:             WITH loc_oCol.cmd_4c_CorCMP
2137:                 .Caption       = "..."
2138:                 .Width         = 60
2139:                 .Height        = 25
2140:                 .SpecialEffect = 0
2141:                 .FontName      = "Tahoma"
2142:                 .FontSize      = 8
2143:             ENDWITH
2144:             BINDEVENT(loc_oCol.cmd_4c_CorCMP, "Click", THIS, "BtnCorCMPClick")
2145: 
2146:             *- Col11: LblAlinhar - "Alinhar" (ComboBox)
2147:             loc_oCol = loc_oGrd.Column11
2148:             loc_oCol.Header1.Caption = "Alinhar"
2149:             loc_oCol.Width  = 80
2150:             loc_oCol.Sparse = .F.
2151:             loc_oCol.AddObject("cbo_4c_AlinharCMP", "ComboBox")
2152:             loc_oCol.CurrentControl = "cbo_4c_AlinharCMP"
2153:             WITH loc_oCol.cbo_4c_AlinharCMP
2154:                 .Style         = 2
2155:                 .RowSourceType = 1
2156:                 .RowSource     = "Esq.,Cen.,Dir."
2157:                 .Width         = 75
2158:                 .Height        = 24
2159:                 .FontName      = "Tahoma"
2160:                 .FontSize      = 8
2161:             ENDWITH
2162: 
2163:             *- Col12: LblTamCmp - "Tam." (Spinner - tamanho da fonte)
2164:             loc_oCol = loc_oGrd.Column12
2165:             loc_oCol.Header1.Caption = "Tam."
2166:             loc_oCol.Width  = 90
2167:             loc_oCol.Sparse = .F.
2168:             loc_oCol.AddObject("spn_4c_TamCMP", "Spinner")
2169:             loc_oCol.CurrentControl = "spn_4c_TamCMP"
2170:             WITH loc_oCol.spn_4c_TamCMP
2171:                 .Width            = 85
2172:                 .Height           = 24
2173:                 .SpinnerLowValue  = 6
2174:                 .SpinnerHighValue = 72
2175:                 .Increment        = 1
2176:             ENDWITH
2177: 
2178:             *=== Label "Totalizar pelo Campo:..." (Lbl_CmpGrupo) ===
2179:             par_oPage.AddObject("lbl_4c_CmpGrupo", "Label")
2180:             WITH par_oPage.lbl_4c_CmpGrupo

*-- Linhas 2190 a 2435:
2190:                 .Visible   = .T.
2191:             ENDWITH
2192: 
2193:             *=== GRADE 3: grd_4c_GRP (FwGrade3_GRP) - grupos/totalizacao, 7 colunas ===
2194:             par_oPage.AddObject("grd_4c_GRP", "Grid")
2195:             loc_oGrd = par_oPage.grd_4c_GRP
2196:             WITH loc_oGrd
2197:                 .Top              = 529
2198:                 .Left             = 4
2199:                 .Width            = 989
2200:                 .Height           = 67
2201:                 .ColumnCount      = 7
2202:                 .RecordSourceType = 1
2203:                 .RecordSource     = ""
2204:                 .GridLines        = 1
2205:                 .HeaderHeight     = 25
2206:                 .RowHeight        = 30
2207:                 .DeleteMark       = .F.
2208:                 .RecordMark       = .F.
2209:                 .ScrollBars       = 2
2210:                 .Visible          = .T.
2211:             ENDWITH
2212: 
2213:             *- Col1: NmCampo - "Grupo" (ComboBox - escolhe campo do SQL como agrupador)
2214:             loc_oCol = loc_oGrd.Column1
2215:             loc_oCol.Header1.Caption = "Grupo"
2216:             loc_oCol.Width  = 200
2217:             loc_oCol.Sparse = .F.
2218:             loc_oCol.AddObject("cbo_4c_NmCampoGRP", "ComboBox")
2219:             loc_oCol.CurrentControl = "cbo_4c_NmCampoGRP"
2220:             WITH loc_oCol.cbo_4c_NmCampoGRP
2221:                 .Style         = 2
2222:                 .RowSourceType = 1
2223:                 .RowSource     = ""
2224:                 .Width         = 195
2225:                 .Height        = 24
2226:                 .FontName      = "Tahoma"
2227:                 .FontSize      = 8
2228:             ENDWITH
2229: 
2230:             *- Col2: LblCaption - "Titulo do Campo" (EditBox)
2231:             loc_oCol = loc_oGrd.Column2
2232:             loc_oCol.Header1.Caption = "Titulo do Campo"
2233:             loc_oCol.Width  = 160
2234:             loc_oCol.Sparse = .F.
2235:             loc_oCol.AddObject("edt_4c_GrpCaption", "EditBox")
2236:             loc_oCol.CurrentControl = "edt_4c_GrpCaption"
2237:             WITH loc_oCol.edt_4c_GrpCaption
2238:                 .Width      = 158
2239:                 .Height     = 28
2240:                 .ScrollBars = 0
2241:                 .FontName   = "Tahoma"
2242:                 .FontSize   = 8
2243:             ENDWITH
2244: 
2245:             *- Col3: LblFonte - "Fonte" (EditBox)
2246:             loc_oCol = loc_oGrd.Column3
2247:             loc_oCol.Header1.Caption = "Fonte"
2248:             loc_oCol.Width  = 160
2249:             loc_oCol.Sparse = .F.
2250:             loc_oCol.AddObject("edt_4c_GrpFonte", "EditBox")
2251:             loc_oCol.CurrentControl = "edt_4c_GrpFonte"
2252:             WITH loc_oCol.edt_4c_GrpFonte
2253:                 .Width      = 158
2254:                 .Height     = 28
2255:                 .ScrollBars = 0
2256:                 .FontName   = "Tahoma"
2257:                 .FontSize   = 8
2258:             ENDWITH
2259: 
2260:             *- Col4: LblBtFonte - "Fte" (CommandButton - abre GETFONT)
2261:             loc_oCol = loc_oGrd.Column4
2262:             loc_oCol.Header1.Caption = "Fte"
2263:             loc_oCol.Width  = 80
2264:             loc_oCol.Sparse = .F.
2265:             loc_oCol.AddObject("cmd_4c_FonteGRP", "CommandButton")
2266:             loc_oCol.CurrentControl = "cmd_4c_FonteGRP"
2267:             WITH loc_oCol.cmd_4c_FonteGRP
2268:                 .Caption       = "..."
2269:                 .Width         = 75
2270:                 .Height        = 25
2271:                 .SpecialEffect = 0
2272:                 .FontName      = "Tahoma"
2273:                 .FontSize      = 8
2274:             ENDWITH
2275:             BINDEVENT(loc_oCol.cmd_4c_FonteGRP, "Click", THIS, "BtnFonteGRPClick")
2276: 
2277:             *- Col5: BtCor - "Cor" (CommandButton - abre GETCOLOR)
2278:             loc_oCol = loc_oGrd.Column5
2279:             loc_oCol.Header1.Caption = "Cor"
2280:             loc_oCol.Width  = 80
2281:             loc_oCol.Sparse = .F.
2282:             loc_oCol.AddObject("cmd_4c_CorGRP", "CommandButton")
2283:             loc_oCol.CurrentControl = "cmd_4c_CorGRP"
2284:             WITH loc_oCol.cmd_4c_CorGRP
2285:                 .Caption       = "..."
2286:                 .Width         = 75
2287:                 .Height        = 25
2288:                 .SpecialEffect = 0
2289:                 .FontName      = "Tahoma"
2290:                 .FontSize      = 8
2291:             ENDWITH
2292:             BINDEVENT(loc_oCol.cmd_4c_CorGRP, "Click", THIS, "BtnCorGRPClick")
2293: 
2294:             *- Col6: LblAlinhar - "Alinhar" (ComboBox)
2295:             loc_oCol = loc_oGrd.Column6
2296:             loc_oCol.Header1.Caption = "Alinhar"
2297:             loc_oCol.Width  = 160
2298:             loc_oCol.Sparse = .F.
2299:             loc_oCol.AddObject("cbo_4c_AlinharGRP", "ComboBox")
2300:             loc_oCol.CurrentControl = "cbo_4c_AlinharGRP"
2301:             WITH loc_oCol.cbo_4c_AlinharGRP
2302:                 .Style         = 2
2303:                 .RowSourceType = 1
2304:                 .RowSource     = "Esq.,Cen.,Dir."
2305:                 .Width         = 155
2306:                 .Height        = 24
2307:                 .FontName      = "Tahoma"
2308:                 .FontSize      = 8
2309:             ENDWITH
2310: 
2311:             *- Col7: LblTamCmp - "Tam." (Spinner)
2312:             loc_oCol = loc_oGrd.Column7
2313:             loc_oCol.Header1.Caption = "Tam."
2314:             loc_oCol.Width  = 149
2315:             loc_oCol.Sparse = .F.
2316:             loc_oCol.AddObject("spn_4c_TamGRP", "Spinner")
2317:             loc_oCol.CurrentControl = "spn_4c_TamGRP"
2318:             WITH loc_oCol.spn_4c_TamGRP
2319:                 .Width            = 120
2320:                 .Height           = 24
2321:                 .SpinnerLowValue  = 6
2322:                 .SpinnerHighValue = 72
2323:                 .Increment        = 1
2324:             ENDWITH
2325: 
2326:         CATCH TO loc_oErro
2327:             MsgErro(loc_oErro.Message, "FormRPT.ConfigurarGradesDesigner")
2328:         ENDTRY
2329:     ENDPROC
2330: 
2331:     *==========================================================================
2332:     * BtnFonteTITClick - Abre GETFONT para o campo TpFonte da grade grd_4c_TIT
2333:     *==========================================================================
2334:     PROCEDURE BtnFonteTITClick()
2335:         LOCAL loc_cFonte
2336:         TRY
2337:             loc_cFonte = GETFONT()
2338:             IF !EMPTY(loc_cFonte) AND USED("CrsProps_Titulo") AND !EOF("CrsProps_Titulo")
2339:                 REPLACE CrsProps_Titulo.LblFonte WITH loc_cFonte IN CrsProps_Titulo
2340:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_TIT.Refresh()
2341:             ENDIF
2342:         CATCH TO loc_oErro
2343:             MsgErro(loc_oErro.Message, "FormRPT.BtnFonteTITClick")
2344:         ENDTRY
2345:     ENDPROC
2346: 
2347:     *==========================================================================
2348:     * BtnCorTITClick - Abre GETCOLOR para o campo LblBtCor da grade grd_4c_TIT
2349:     *==========================================================================
2350:     PROCEDURE BtnCorTITClick()
2351:         LOCAL loc_nCor
2352:         TRY
2353:             loc_nCor = GETCOLOR()
2354:             IF loc_nCor >= 0 AND USED("CrsProps_Titulo") AND !EOF("CrsProps_Titulo")
2355:                 REPLACE CrsProps_Titulo.LblBtCor WITH loc_nCor IN CrsProps_Titulo
2356:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_TIT.Refresh()
2357:             ENDIF
2358:         CATCH TO loc_oErro
2359:             MsgErro(loc_oErro.Message, "FormRPT.BtnCorTITClick")
2360:         ENDTRY
2361:     ENDPROC
2362: 
2363:     *==========================================================================
2364:     * BtnFonteCMPClick - Abre GETFONT para LblFonte da linha atual de grd_4c_CMPs
2365:     *==========================================================================
2366:     PROCEDURE BtnFonteCMPClick()
2367:         LOCAL loc_cFonte
2368:         TRY
2369:             loc_cFonte = GETFONT()
2370:             IF !EMPTY(loc_cFonte) AND USED("CrsProps_Campos") AND !EOF("CrsProps_Campos")
2371:                 REPLACE CrsProps_Campos.LblFonte WITH loc_cFonte IN CrsProps_Campos
2372:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_CMPs.Refresh()
2373:             ENDIF
2374:         CATCH TO loc_oErro
2375:             MsgErro(loc_oErro.Message, "FormRPT.BtnFonteCMPClick")
2376:         ENDTRY
2377:     ENDPROC
2378: 
2379:     *==========================================================================
2380:     * BtnCorCMPClick - Abre GETCOLOR para LblBtCor da linha atual de grd_4c_CMPs
2381:     *==========================================================================
2382:     PROCEDURE BtnCorCMPClick()
2383:         LOCAL loc_nCor
2384:         TRY
2385:             loc_nCor = GETCOLOR()
2386:             IF loc_nCor >= 0 AND USED("CrsProps_Campos") AND !EOF("CrsProps_Campos")
2387:                 REPLACE CrsProps_Campos.LblBtCor WITH loc_nCor IN CrsProps_Campos
2388:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_CMPs.Refresh()
2389:             ENDIF
2390:         CATCH TO loc_oErro
2391:             MsgErro(loc_oErro.Message, "FormRPT.BtnCorCMPClick")
2392:         ENDTRY
2393:     ENDPROC
2394: 
2395:     *==========================================================================
2396:     * BtnFonteGRPClick - Abre GETFONT para LblFonte da linha atual de grd_4c_GRP
2397:     *==========================================================================
2398:     PROCEDURE BtnFonteGRPClick()
2399:         LOCAL loc_cFonte
2400:         TRY
2401:             loc_cFonte = GETFONT()
2402:             IF !EMPTY(loc_cFonte) AND USED("CrsProps_GRP") AND !EOF("CrsProps_GRP")
2403:                 REPLACE CrsProps_GRP.LblFonte WITH loc_cFonte IN CrsProps_GRP
2404:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_GRP.Refresh()
2405:             ENDIF
2406:         CATCH TO loc_oErro
2407:             MsgErro(loc_oErro.Message, "FormRPT.BtnFonteGRPClick")
2408:         ENDTRY
2409:     ENDPROC
2410: 
2411:     *==========================================================================
2412:     * BtnCorGRPClick - Abre GETCOLOR para LblBtCor da linha atual de grd_4c_GRP
2413:     *==========================================================================
2414:     PROCEDURE BtnCorGRPClick()
2415:         LOCAL loc_nCor
2416:         TRY
2417:             loc_nCor = GETCOLOR()
2418:             IF loc_nCor >= 0 AND USED("CrsProps_GRP") AND !EOF("CrsProps_GRP")
2419:                 REPLACE CrsProps_GRP.LblBtCor WITH loc_nCor IN CrsProps_GRP
2420:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_GRP.Refresh()
2421:             ENDIF
2422:         CATCH TO loc_oErro
2423:             MsgErro(loc_oErro.Message, "FormRPT.BtnCorGRPClick")
2424:         ENDTRY
2425:     ENDPROC
2426: 
2427:     *==========================================================================
2428:     * FormatarGridLista - Formata visual do grid da lista
2429:     *==========================================================================
2430:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
2431:         WITH par_oGrid
2432:             .FontName = "Verdana"
2433:             .FontSize = 8
2434:         ENDWITH
2435:     ENDPROC

*-- Linhas 2531 a 2589:
2531:             IF USED("CrsProps_Titulo")
2532:                 USE IN CrsProps_Titulo
2533:             ENDIF
2534:             CREATE CURSOR CrsProps_Titulo ( ;
2535:                 NmCampo    C(40),  ;
2536:                 TpCampo    C(10),  ;
2537:                 CkOutRPT   I,      ;
2538:                 CkFiltro   I,      ;
2539:                 CkSubTot   I,      ;
2540:                 CkTotal    I,      ;
2541:                 LblCaption C(200), ;
2542:                 LblFonte   C(50),  ;
2543:                 LblBtFonte C(1),   ;
2544:                 LblBtCor   I,      ;
2545:                 LblAlinhar C(6),   ;
2546:                 LblTamCmp  I,      ;
2547:                 LblTipoCmp C(1)    ;
2548:             )
2549: 
2550:             *-- Cursor de campos do relatorio
2551:             IF USED("CrsProps_Campos")
2552:                 USE IN CrsProps_Campos
2553:             ENDIF
2554:             CREATE CURSOR CrsProps_Campos ( ;
2555:                 NmCampo    C(40),  ;
2556:                 TpCampo    C(10),  ;
2557:                 CkOutRPT   I,      ;
2558:                 CkFiltro   I,      ;
2559:                 CkSubTot   I,      ;
2560:                 CkTotal    I,      ;
2561:                 LblCaption C(200), ;
2562:                 LblFonte   C(50),  ;
2563:                 LblBtFonte C(1),   ;
2564:                 LblBtCor   I,      ;
2565:                 LblAlinhar C(6),   ;
2566:                 LblTamCmp  I,      ;
2567:                 LblTipoCmp C(1)    ;
2568:             )
2569: 
2570:             *-- Cursor de agrupamento do relatorio
2571:             IF USED("CrsProps_GRP")
2572:                 USE IN CrsProps_GRP
2573:             ENDIF
2574:             CREATE CURSOR CrsProps_GRP ( ;
2575:                 NmCampo    C(40),  ;
2576:                 TpCampo    C(10),  ;
2577:                 LblCaption C(200), ;
2578:                 LblFonte   C(50),  ;
2579:                 LblBtFonte C(1),   ;
2580:                 LblBtCor   I,      ;
2581:                 LblAlinhar C(6),   ;
2582:                 LblTamCmp  I       ;
2583:             )
2584:         CATCH TO loc_oErro
2585:             MsgErro(loc_oErro.Message, "FormRPT.CriarCursoresDesigner")
2586:         ENDTRY
2587:     ENDPROC
2588: 
2589:     *==========================================================================

