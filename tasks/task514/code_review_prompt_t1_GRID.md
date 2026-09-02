# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (5)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1395: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1525: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1873: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1969: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 2178: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormRPT.prg) - TRECHOS RELEVANTES PARA PASS GRID (3659 linhas total):

*-- Linhas 348 a 367:
348:         * Top=117: compensacao(29) + altura botoes(85) + gap(3)
349:         * 5 colunas visiveis: NmReport, Descr, Ativo, DtCriacao, DtAlteracao
350:         *----------------------------------------------------------------------
351:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
352:         WITH loc_oPagina.grd_4c_Lista
353:             .Top                = 117
354:             .Left               = 2
355:             .Width              = 995
356:             .Height             = 470
357:             .GridLines          = 3
358:             .GridLineColor      = RGB(238, 238, 238)
359:             .HighlightBackColor = RGB(255, 255, 255)
360:             .HighlightForeColor = RGB(15, 41, 104)
361:             .HighlightStyle     = 2
362:             .DeleteMark         = .F.
363:             .RecordMark         = .F.
364:             .RowHeight          = 16
365:             .ScrollBars         = 2
366:             .ReadOnly           = .T.
367:             .Visible            = .T.

*-- Linhas 690 a 708:
690:             .RowSourceType = 0
691:             .RowSource     = ""
692:             .BoundColumn   = 1
693:             .ColumnCount   = 1
694:             .ColumnWidths  = "295"
695:             .Visible       = .T.
696:         ENDWITH
697: 
698:         *-- Container de hints de teclado (F8/F9)
699:         loc_oSubPg1.AddObject("cnt_4c_Container1", "Container")
700:         WITH loc_oSubPg1.cnt_4c_Container1
701:             .Top         = 208
702:             .Left        = 395
703:             .Width       = 600
704:             .Height      = 25
705:             .BackStyle   = 0
706:             .BorderWidth = 0
707:             .Visible     = .T.
708: 

*-- Linhas 780 a 870:
780:         ENDWITH
781: 
782:         *-- Grid de resultado (Top=452, Height=148: termina em 600px)
783:         loc_oSubPg1.AddObject("grd_4c_Resultado", "Grid")
784:         WITH loc_oSubPg1.grd_4c_Resultado
785:             .Top                = 452
786:             .Left               = 2
787:             .Width              = 993
788:             .Height             = 148
789:             .GridLines          = 3
790:             .GridLineColor      = RGB(238, 238, 238)
791:             .HighlightBackColor = RGB(255, 255, 255)
792:             .HighlightForeColor = RGB(15, 41, 104)
793:             .HighlightStyle     = 2
794:             .DeleteMark         = .F.
795:             .RecordMark         = .F.
796:             .RowHeight          = 16
797:             .ScrollBars         = 3
798:             .ReadOnly           = .T.
799:             .ColumnCount        = 0
800:             .Visible            = .T.
801:         ENDWITH
802: 
803:         *-- BINDEVENTs (handlers devem ser PUBLIC)
804:         BINDEVENT(loc_oSubPg1.cnt_4c_Salva.cmd_4c_Confirmar, "Click",             THIS, "BtnSalvarClick")
805:         BINDEVENT(loc_oSubPg1.cnt_4c_Salva.cmd_4c_Cancelar,  "Click",             THIS, "BtnCancelarClick")
806:         BINDEVENT(loc_oSubPg1.cbo_4c_NmReports,              "InteractiveChange", THIS, "CboNmReportsChange")
807: 
808:         THIS.ConfigurarSubPaginaLayout()
809:         THIS.ConfigurarPgPage1()
810:         THIS.TornarControlesVisiveis(loc_oPagina)
811:     ENDPROC
812: 
813:     *==========================================================================
814:     * CarregarLista - Carrega grid da Page1 com lista de reports
815:     * Configurar ControlSource e Headers APOS RecordSource (auto-bind sobrescreve)
816:     *==========================================================================
817:     PROCEDURE CarregarLista()
818:         LOCAL loc_lSucesso, loc_oGrid
819:         loc_lSucesso = .F.
820: 
821:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
822:             RETURN .T.
823:         ENDIF
824: 
825:         TRY
826:             IF !THIS.this_oBusinessObject.Buscar("")
827:                 loc_lSucesso = .F.
828:             ELSE
829:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
830: 
831:                 *-- RecordSource e ColumnCount FORA de WITH (cria colunas imediatamente)
832:                 loc_oGrid.ColumnCount = 5
833:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
834:                 loc_oGrid.ColumnCount  = 5
835: 
836:                 *-- ControlSource APOS RecordSource (sobrepoe auto-bind)
837:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.NmReport"
838:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descr"
839:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Ativo"
840:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.DtCriacao"
841:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.DtAlteracao"
842: 
843:                 *-- Larguras das colunas
844:                 loc_oGrid.Column1.Width = 280
845:                 loc_oGrid.Column2.Width = 350
846:                 loc_oGrid.Column3.Width = 50
847:                 loc_oGrid.Column4.Width = 80
848:                 loc_oGrid.Column5.Width = 80
849: 
850:                 *-- Headers (obrigatorio reconfigurar apos RecordSource)
851:                 loc_oGrid.Column1.Header1.Caption = "Nome do Report"
852:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
853:                 loc_oGrid.Column3.Header1.Caption = "Ativo"
854:                 loc_oGrid.Column4.Header1.Caption = "Dt. Cria" + CHR(231) + CHR(227) + "o"
855:                 loc_oGrid.Column5.Header1.Caption = "Dt. Altera" + CHR(231) + CHR(227) + "o"
856: 
857:                 THIS.FormatarGridLista(loc_oGrid)
858:                 THIS.PopularComboReports()
859:                 loc_lSucesso = .T.
860:             ENDIF
861: 
862:         CATCH TO loc_oErro
863:             MsgErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, "FormRPT.CarregarLista")
864:             loc_lSucesso = .F.
865:         ENDTRY
866: 
867:         RETURN loc_lSucesso
868:     ENDPROC
869: 
870:     *==========================================================================

*-- Linhas 1381 a 1411:
1381: 
1382:             IF EMPTY(loc_cSQL)
1383:                 MsgAviso("Informe o SQL antes de executar.")
1384:             ELSE
1385:                 IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
1386:                 MsgAviso("Sem conex" + CHR(227) + "o com o banco de dados.")
1387:             ELSE
1388:                 IF USED("cursor_4c_Resultado")
1389:                     USE IN cursor_4c_Resultado
1390:                 ENDIF
1391:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Resultado")
1392:                 IF loc_nRes >= 0 AND USED("cursor_4c_Resultado")
1393:                     loc_oGrid = loc_oSubPg1.grd_4c_Resultado
1394:                     loc_oGrid.ColumnCount = 3
1395:                     loc_oGrid.RecordSource = "cursor_4c_Resultado"
1396:                     loc_oGrid.ColumnCount  = FCOUNT("cursor_4c_Resultado")
1397:                 ELSE
1398:                     MsgErro("Erro ao executar SQL:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1399:                 ENDIF
1400:                 ENDIF
1401:             ENDIF
1402: 
1403:         CATCH TO loc_oErro
1404:             MsgErro("Erro ao executar SQL:" + CHR(13) + loc_oErro.Message, "FormRPT.BtnExecutarSQLClick")
1405:         ENDTRY
1406:     ENDPROC
1407: 
1408:     *==========================================================================
1409:     * BtnProcessarClick - Seta variaveis de data e executa SQL (FASE 9)
1410:     * Chamado pelo botao Processar (cmd_4c_Processar) dentro do cabecalho
1411:     *==========================================================================

*-- Linhas 1511 a 1541:
1511:                         "FROM sys.all_Columns c " + ;
1512:                         "JOIN sys.types t ON t.System_Type_ID = c.System_Type_ID " + ;
1513:                         "WHERE object_id = object_id(" + EscaparSQL(loc_cTabela) + ") " + ;
1514:                         "ORDER BY c.Column_ID"
1515: 
1516:                     IF USED("cursor_4c_Resultado")
1517:                         USE IN cursor_4c_Resultado
1518:                     ENDIF
1519: 
1520:                     loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Resultado")
1521: 
1522:                     IF loc_nRes >= 0 AND USED("cursor_4c_Resultado")
1523:                         loc_oGrid = loc_oSubPg1.grd_4c_Resultado
1524:                         loc_oGrid.ColumnCount = 3
1525:                         loc_oGrid.RecordSource = "cursor_4c_Resultado"
1526:                         loc_oGrid.ColumnCount  = FCOUNT("cursor_4c_Resultado")
1527:                         loc_lOK = .T.
1528:                     ELSE
1529:                         MsgErro("Tabela '" + loc_cTabela + "' n" + CHR(227) + "o encontrada.", "Estrutura")
1530:                     ENDIF
1531: 
1532:                     loc_oSubPg1.obj_4c_OleRTF_SqlCMD.SetFocus()
1533:                     ENDIF
1534:                     ENDIF
1535:                 ENDIF
1536: 
1537:             ENDIF
1538:         CATCH TO loc_oErro
1539:             MsgErro("Erro ao buscar estrutura:" + CHR(13) + loc_oErro.Message, "FormRPT.BtnEstruturaClick")
1540:         ENDTRY
1541: 

*-- Linhas 1625 a 1671:
1625:             USE IN cursor_4c_LstCampos
1626:         ENDIF
1627: 
1628:         SET NULL ON
1629:         CREATE CURSOR cursor_4c_PropsTitulo ( ;
1630:             LblCaption M(4), LblFonte M(4), LblBtFonte C(1), LblBtCor I(10), ;
1631:             LblAlinhar C(6), LblTamCmp I(5), LblTipoCmp C(1), ArrayID I(5), ;
1632:             Orientation I(1), PaperSize I(1) ;
1633:         )
1634:         APPEND BLANK
1635:         REPLACE Orientation WITH 1, PaperSize WITH 9
1636:         REPLACE LblCaption WITH "", LblFonte WITH "Tahoma,10,N", LblBtFonte WITH ""
1637:         REPLACE LblBtCor WITH 0, LblAlinhar WITH "Left", LblTamCmp WITH 90, LblTipoCmp WITH "C"
1638: 
1639:         CREATE CURSOR cursor_4c_PropsGrp ( ;
1640:             NmCampo C(40), LblCaption M(4), LblFonte M(4), LblBtFonte C(1), ;
1641:             LblBtCor I(10), LblAlinhar C(6), LblTamCmp I(5), LblTipoCmp C(1), ArrayID I(5) ;
1642:         )
1643:         APPEND BLANK
1644:         REPLACE NmCampo WITH "", LblCaption WITH "Campo de SubTotal"
1645:         REPLACE LblFonte WITH "Tahoma,8,N", LblBtFonte WITH ""
1646:         REPLACE LblBtCor WITH 0, LblAlinhar WITH "Left", LblTamCmp WITH 10, LblTipoCmp WITH "C"
1647: 
1648:         CREATE CURSOR cursor_4c_PropsCampos ( ;
1649:             NmCampo C(40), TpCampo C(10), CkOutRPT I(1), CkFiltro I(1), ;
1650:             CkSubTot I(1), CkTotal I(1), LblCaption M(4), LblFonte M(4), ;
1651:             LblBtFonte C(1), LblBtCor I(10), LblAlinhar C(6), LblTamCmp I(5), ;
1652:             LblTipoCmp C(1), ArrayID I(5) ;
1653:         )
1654: 
1655:         CREATE CURSOR cursor_4c_LstCampos ( NmCampo C(40), TpCampo C(10) )
1656:         SET NULL OFF
1657:     ENDPROC
1658: 
1659:     *==========================================================================
1660:     * ConfigurarSubPaginaLayout - Constroi controles da Sub-Page2 (Layout FRX)
1661:     * Coordenadas originais do SCX + 29 (compensa pgf_4c_Dados.Top=-29)
1662:     *==========================================================================
1663:     PROTECTED PROCEDURE ConfigurarSubPaginaLayout()
1664:         LOCAL loc_oSubPg2, loc_i
1665:         LOCAL loc_aPaperSize(41)
1666:         loc_oSubPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
1667: 
1668:         *-- Container de botoes (CmdGrp_Acoes: Top=8+29=37)
1669:         loc_oSubPg2.AddObject("cnt_4c_BotoesLayout", "Container")
1670:         WITH loc_oSubPg2.cnt_4c_BotoesLayout
1671:             .Top         = 37

*-- Linhas 1736 a 1754:
1736:             .Width         = 348
1737:             .Height        = 24
1738:             .Style         = 2
1739:             .ColumnCount   = 2
1740:             .BoundColumn   = 2
1741:             .ColumnWidths  = "300,48"
1742:             .ControlSource = "cursor_4c_PropsTitulo.PaperSize"
1743:             .FontName      = "Tahoma"
1744:             .FontSize      = 8
1745:             .Visible       = .T.
1746:         ENDWITH
1747: 
1748:         *-- Preencher 41 tamanhos de papel (legado laPaperSize)
1749:         loc_aPaperSize[01] = "Letter, 8 1/2 x 11 in"
1750:         loc_aPaperSize[02] = "Letter Small, 8 1/2 x 11 in"
1751:         loc_aPaperSize[03] = "Tabloid, 11 x 17 in"
1752:         loc_aPaperSize[04] = "Ledger, 17 x 11 in"
1753:         loc_aPaperSize[05] = "Legal, 8 1/2 x 14 in"
1754:         loc_aPaperSize[06] = "Statement, 5 1/2 x 8 1/2 in"

*-- Linhas 1859 a 2323:
1859:             .Width     = 560
1860:             .Height    = 16
1861:             .FontName  = "Tahoma"
1862:             .FontSize  = 8
1863:             .FontBold  = .T.
1864:             .BackStyle = 0
1865:             .Visible   = .T.
1866:         ENDWITH
1867: 
1868:         *-- Grid: Propriedades do Titulo do Relatorio (grd_4c_PropsTitulo)
1869:         loc_oSubPg2.AddObject("grd_4c_PropsTitulo", "Grid")
1870:         loc_oSubPg2.grd_4c_PropsTitulo.ColumnCount     = 5
1871:         loc_oSubPg2.grd_4c_PropsTitulo.RecordSourceType = 1
1872:         loc_oSubPg2.grd_4c_PropsTitulo.ColumnCount = 3
1873:         loc_oSubPg2.grd_4c_PropsTitulo.RecordSource     = "cursor_4c_PropsTitulo"
1874:         WITH loc_oSubPg2.grd_4c_PropsTitulo
1875:             .Top          = 209
1876:             .Left         = 4
1877:             .Width        = 990
1878:             .Height       = 65
1879:             .GridLines    = 1
1880:             .HeaderHeight = 18
1881:             .RowHeight    = 20
1882:             .ReadOnly     = .F.
1883:             .Visible      = .T.
1884:             .DeleteMark   = .F.
1885:             .RecordMark   = .F.
1886:             .ScrollBars   = 2
1887: 
1888:             WITH .Column1
1889:                 .Header1.Caption = "T" + CHR(237) + "tulo"
1890:                 .ControlSource   = "cursor_4c_PropsTitulo.LblCaption"
1891:                 .Width           = 120
1892:                 .Sparse          = .F.
1893:                 .AddObject("Edit1", "EditBox")
1894:                 .CurrentControl  = "Edit1"
1895:                 WITH .Edit1
1896:                     .Visible = .T.
1897:                     .Width   = 118
1898:                     .Height  = 40
1899:                 ENDWITH
1900:             ENDWITH
1901: 
1902:             WITH .Column2
1903:                 .Header1.Caption = "Fonte"
1904:                 .ControlSource   = "cursor_4c_PropsTitulo.LblFonte"
1905:                 .Width           = 300
1906:                 .Sparse          = .F.
1907:                 .AddObject("Edit1", "EditBox")
1908:                 .CurrentControl  = "Edit1"
1909:                 WITH .Edit1
1910:                     .Visible = .T.
1911:                     .Width   = 298
1912:                     .Height  = 40
1913:                 ENDWITH
1914:             ENDWITH
1915: 
1916:             WITH .Column3
1917:                 .Header1.Caption = "Fte"
1918:                 .ControlSource   = "cursor_4c_PropsTitulo.LblBtFonte"
1919:                 .Width           = 60
1920:                 .Sparse          = .F.
1921:                 .AddObject("Command1", "CommandButton")
1922:                 .CurrentControl  = "Command1"
1923:                 WITH .Command1
1924:                     .Caption = "..."
1925:                     .Visible = .T.
1926:                     .Width   = 55
1927:                     .Height  = 18
1928:                 ENDWITH
1929:             ENDWITH
1930: 
1931:             WITH .Column4
1932:                 .Header1.Caption = "Cor"
1933:                 .ControlSource   = "cursor_4c_PropsTitulo.LblBtCor"
1934:                 .Width           = 60
1935:                 .Sparse          = .F.
1936:                 .AddObject("Command1", "CommandButton")
1937:                 .CurrentControl  = "Command1"
1938:                 WITH .Command1
1939:                     .Caption = "..."
1940:                     .Visible = .T.
1941:                     .Width   = 55
1942:                     .Height  = 18
1943:                 ENDWITH
1944:             ENDWITH
1945: 
1946:             WITH .Column5
1947:                 .Header1.Caption = "Alinhar"
1948:                 .ControlSource   = "cursor_4c_PropsTitulo.LblAlinhar"
1949:                 .Width           = 450
1950:                 .Sparse          = .F.
1951:                 .AddObject("Combo1", "ComboBox")
1952:                 .CurrentControl  = "Combo1"
1953:                 WITH .Combo1
1954:                     .RowSourceType = 1
1955:                     .RowSource     = "Left,Center,Right"
1956:                     .Style         = 2
1957:                     .Visible       = .T.
1958:                     .Width         = 445
1959:                     .Height        = 21
1960:                 ENDWITH
1961:             ENDWITH
1962:         ENDWITH
1963: 
1964:         *-- Grid: Propriedades dos Campos (grd_4c_PropsCampos)
1965:         loc_oSubPg2.AddObject("grd_4c_PropsCampos", "Grid")
1966:         loc_oSubPg2.grd_4c_PropsCampos.ColumnCount      = 12
1967:         loc_oSubPg2.grd_4c_PropsCampos.RecordSourceType  = 1
1968:         loc_oSubPg2.grd_4c_PropsCampos.ColumnCount = 3
1969:         loc_oSubPg2.grd_4c_PropsCampos.RecordSource      = "cursor_4c_PropsCampos"
1970:         WITH loc_oSubPg2.grd_4c_PropsCampos
1971:             .Top          = 287
1972:             .Left         = 4
1973:             .Width        = 990
1974:             .Height       = 238
1975:             .GridLines    = 1
1976:             .HeaderHeight = 18
1977:             .RowHeight    = 20
1978:             .ReadOnly     = .F.
1979:             .Visible      = .T.
1980:             .DeleteMark   = .F.
1981:             .RecordMark   = .F.
1982:             .ScrollBars   = 3
1983: 
1984:             WITH .Column1
1985:                 .Header1.Caption = "Campo"
1986:                 .ControlSource   = "cursor_4c_PropsCampos.NmCampo"
1987:                 .Width           = 100
1988:                 .ReadOnly        = .T.
1989:                 .Sparse          = .F.
1990:                 .AddObject("Text1", "TextBox")
1991:                 .CurrentControl  = "Text1"
1992:                 WITH .Text1
1993:                     .ReadOnly = .T.
1994:                     .Visible  = .T.
1995:                     .Width    = 98
1996:                 ENDWITH
1997:             ENDWITH
1998: 
1999:             WITH .Column2
2000:                 .Header1.Caption = "Tipo"
2001:                 .ControlSource   = "cursor_4c_PropsCampos.TpCampo"
2002:                 .Width           = 75
2003:                 .ReadOnly        = .T.
2004:                 .Sparse          = .F.
2005:                 .AddObject("Text1", "TextBox")
2006:                 .CurrentControl  = "Text1"
2007:                 WITH .Text1
2008:                     .ReadOnly = .T.
2009:                     .Visible  = .T.
2010:                     .Width    = 73
2011:                 ENDWITH
2012:             ENDWITH
2013: 
2014:             WITH .Column3
2015:                 .Header1.Caption = "Sa" + CHR(237) + "da Rel."
2016:                 .ControlSource   = "cursor_4c_PropsCampos.CkOutRPT"
2017:                 .Width           = 65
2018:                 .Sparse          = .F.
2019:                 .AddObject("Check1", "CheckBox")
2020:                 .CurrentControl  = "Check1"
2021:                 WITH .Check1
2022:                     .Caption = ""
2023:                     .Visible = .T.
2024:                     .Width   = 60
2025:                     .Height  = 17
2026:                 ENDWITH
2027:             ENDWITH
2028: 
2029:             WITH .Column4
2030:                 .Header1.Caption = "Filtro"
2031:                 .ControlSource   = "cursor_4c_PropsCampos.CkFiltro"
2032:                 .Width           = 55
2033:                 .Sparse          = .F.
2034:                 .AddObject("Check1", "CheckBox")
2035:                 .CurrentControl  = "Check1"
2036:                 WITH .Check1
2037:                     .Caption = ""
2038:                     .Visible = .T.
2039:                     .Width   = 50
2040:                     .Height  = 17
2041:                 ENDWITH
2042:             ENDWITH
2043: 
2044:             WITH .Column5
2045:                 .Header1.Caption = "SubTot"
2046:                 .ControlSource   = "cursor_4c_PropsCampos.CkSubTot"
2047:                 .Width           = 60
2048:                 .Sparse          = .F.
2049:                 .AddObject("Check1", "CheckBox")
2050:                 .CurrentControl  = "Check1"
2051:                 WITH .Check1
2052:                     .Caption = ""
2053:                     .Visible = .T.
2054:                     .Width   = 55
2055:                     .Height  = 17
2056:                 ENDWITH
2057:             ENDWITH
2058: 
2059:             WITH .Column6
2060:                 .Header1.Caption = "Total"
2061:                 .ControlSource   = "cursor_4c_PropsCampos.CkTotal"
2062:                 .Width           = 55
2063:                 .Sparse          = .F.
2064:                 .AddObject("Check1", "CheckBox")
2065:                 .CurrentControl  = "Check1"
2066:                 WITH .Check1
2067:                     .Caption = ""
2068:                     .Visible = .T.
2069:                     .Width   = 50
2070:                     .Height  = 17
2071:                 ENDWITH
2072:             ENDWITH
2073: 
2074:             WITH .Column7
2075:                 .Header1.Caption = "T" + CHR(237) + "tulo do Campo"
2076:                 .ControlSource   = "cursor_4c_PropsCampos.LblCaption"
2077:                 .Width           = 140
2078:                 .Sparse          = .F.
2079:                 .AddObject("Edit1", "EditBox")
2080:                 .CurrentControl  = "Edit1"
2081:                 WITH .Edit1
2082:                     .Visible = .T.
2083:                     .Width   = 138
2084:                     .Height  = 40
2085:                 ENDWITH
2086:             ENDWITH
2087: 
2088:             WITH .Column8
2089:                 .Header1.Caption = "Fonte"
2090:                 .ControlSource   = "cursor_4c_PropsCampos.LblFonte"
2091:                 .Width           = 190
2092:                 .Sparse          = .F.
2093:                 .AddObject("Edit1", "EditBox")
2094:                 .CurrentControl  = "Edit1"
2095:                 WITH .Edit1
2096:                     .Visible = .T.
2097:                     .Width   = 188
2098:                     .Height  = 40
2099:                 ENDWITH
2100:             ENDWITH
2101: 
2102:             WITH .Column9
2103:                 .Header1.Caption = "Fte"
2104:                 .ControlSource   = "cursor_4c_PropsCampos.LblBtFonte"
2105:                 .Width           = 50
2106:                 .Sparse          = .F.
2107:                 .AddObject("Command1", "CommandButton")
2108:                 .CurrentControl  = "Command1"
2109:                 WITH .Command1
2110:                     .Caption = "..."
2111:                     .Visible = .T.
2112:                     .Width   = 46
2113:                     .Height  = 18
2114:                 ENDWITH
2115:             ENDWITH
2116: 
2117:             WITH .Column10
2118:                 .Header1.Caption = "Cor"
2119:                 .ControlSource   = "cursor_4c_PropsCampos.LblBtCor"
2120:                 .Width           = 50
2121:                 .Sparse          = .F.
2122:                 .AddObject("Command1", "CommandButton")
2123:                 .CurrentControl  = "Command1"
2124:                 WITH .Command1
2125:                     .Caption = "..."
2126:                     .Visible = .T.
2127:                     .Width   = 46
2128:                     .Height  = 18
2129:                 ENDWITH
2130:             ENDWITH
2131: 
2132:             WITH .Column11
2133:                 .Header1.Caption = "Alinhar"
2134:                 .ControlSource   = "cursor_4c_PropsCampos.LblAlinhar"
2135:                 .Width           = 80
2136:                 .Sparse          = .F.
2137:                 .AddObject("Combo1", "ComboBox")
2138:                 .CurrentControl  = "Combo1"
2139:                 WITH .Combo1
2140:                     .RowSourceType = 1
2141:                     .RowSource     = "Left,Center,Right"
2142:                     .Style         = 2
2143:                     .Visible       = .T.
2144:                     .Width         = 77
2145:                     .Height        = 21
2146:                 ENDWITH
2147:             ENDWITH
2148: 
2149:             WITH .Column12
2150:                 .Header1.Caption = "Tam."
2151:                 .ControlSource   = "cursor_4c_PropsCampos.LblTamCmp"
2152:                 .Width           = 70
2153:                 .Sparse          = .F.
2154:                 .AddObject("Spinner1", "Spinner")
2155:                 .CurrentControl  = "Spinner1"
2156:                 WITH .Spinner1
2157:                     .SpinnerLowValue  = 0
2158:                     .SpinnerHighValue = 9999
2159:                     .Increment        = 1
2160:                     .Visible          = .T.
2161:                     .Width            = 66
2162:                     .Height           = 21
2163:                 ENDWITH
2164:             ENDWITH
2165:         ENDWITH
2166: 
2167:         *-- DynamicBackColor: cinza escuro para SubTot/Total em campos nao-numericos
2168:         loc_oSubPg2.grd_4c_PropsCampos.Column5.DynamicBackColor = ;
2169:             "IIF(InList(cursor_4c_PropsCampos.LblTipoCmp,'N','U'),RGB(239,239,239),RGB(209,209,209))"
2170:         loc_oSubPg2.grd_4c_PropsCampos.Column6.DynamicBackColor = ;
2171:             "IIF(InList(cursor_4c_PropsCampos.LblTipoCmp,'N','U'),RGB(239,239,239),RGB(209,209,209))"
2172: 
2173:         *-- Grid: Propriedades do Grupo (grd_4c_PropsGrp)
2174:         loc_oSubPg2.AddObject("grd_4c_PropsGrp", "Grid")
2175:         loc_oSubPg2.grd_4c_PropsGrp.ColumnCount      = 7
2176:         loc_oSubPg2.grd_4c_PropsGrp.RecordSourceType  = 1
2177:         loc_oSubPg2.grd_4c_PropsGrp.ColumnCount = 3
2178:         loc_oSubPg2.grd_4c_PropsGrp.RecordSource      = "cursor_4c_PropsGrp"
2179:         WITH loc_oSubPg2.grd_4c_PropsGrp
2180:             .Top          = 558
2181:             .Left         = 4
2182:             .Width        = 989
2183:             .Height       = 67
2184:             .GridLines    = 1
2185:             .HeaderHeight = 18
2186:             .RowHeight    = 20
2187:             .ReadOnly     = .F.
2188:             .Visible      = .T.
2189:             .DeleteMark   = .F.
2190:             .RecordMark   = .F.
2191:             .ScrollBars   = 2
2192: 
2193:             WITH .Column1
2194:                 .Header1.Caption = "Grupo"
2195:                 .ControlSource   = "cursor_4c_PropsGrp.NmCampo"
2196:                 .Width           = 180
2197:                 .Sparse          = .F.
2198:                 .AddObject("Combo1", "ComboBox")
2199:                 .CurrentControl  = "Combo1"
2200:                 WITH .Combo1
2201:                     .RowSourceType = 2
2202:                     .RowSource     = "cursor_4c_LstCampos.NmCampo"
2203:                     .BoundColumn   = 1
2204:                     .Style         = 0
2205:                     .Visible       = .T.
2206:                     .Width         = 177
2207:                     .Height        = 21
2208:                 ENDWITH
2209:             ENDWITH
2210: 
2211:             WITH .Column2
2212:                 .Header1.Caption = "T" + CHR(237) + "tulo do Campo"
2213:                 .ControlSource   = "cursor_4c_PropsGrp.LblCaption"
2214:                 .Width           = 180
2215:                 .Sparse          = .F.
2216:                 .AddObject("Edit1", "EditBox")
2217:                 .CurrentControl  = "Edit1"
2218:                 WITH .Edit1
2219:                     .Visible = .T.
2220:                     .Width   = 178
2221:                     .Height  = 40
2222:                 ENDWITH
2223:             ENDWITH
2224: 
2225:             WITH .Column3
2226:                 .Header1.Caption = "Fonte"
2227:                 .ControlSource   = "cursor_4c_PropsGrp.LblFonte"
2228:                 .Width           = 200
2229:                 .Sparse          = .F.
2230:                 .AddObject("Edit1", "EditBox")
2231:                 .CurrentControl  = "Edit1"
2232:                 WITH .Edit1
2233:                     .Visible = .T.
2234:                     .Width   = 198
2235:                     .Height  = 40
2236:                 ENDWITH
2237:             ENDWITH
2238: 
2239:             WITH .Column4
2240:                 .Header1.Caption = "Fte"
2241:                 .ControlSource   = "cursor_4c_PropsGrp.LblBtFonte"
2242:                 .Width           = 80
2243:                 .Sparse          = .F.
2244:                 .AddObject("Command1", "CommandButton")
2245:                 .CurrentControl  = "Command1"
2246:                 WITH .Command1
2247:                     .Caption = "..."
2248:                     .Visible = .T.
2249:                     .Width   = 76
2250:                     .Height  = 18
2251:                 ENDWITH
2252:             ENDWITH
2253: 
2254:             WITH .Column5
2255:                 .Header1.Caption = "Cor"
2256:                 .ControlSource   = "cursor_4c_PropsGrp.LblBtCor"
2257:                 .Width           = 80
2258:                 .Sparse          = .F.
2259:                 .AddObject("Command1", "CommandButton")
2260:                 .CurrentControl  = "Command1"
2261:                 WITH .Command1
2262:                     .Caption = "..."
2263:                     .Visible = .T.
2264:                     .Width   = 76
2265:                     .Height  = 18
2266:                 ENDWITH
2267:             ENDWITH
2268: 
2269:             WITH .Column6
2270:                 .Header1.Caption = "Alinhar"
2271:                 .ControlSource   = "cursor_4c_PropsGrp.LblAlinhar"
2272:                 .Width           = 100
2273:                 .Sparse          = .F.
2274:                 .AddObject("Combo1", "ComboBox")
2275:                 .CurrentControl  = "Combo1"
2276:                 WITH .Combo1
2277:                     .RowSourceType = 1
2278:                     .RowSource     = "Left,Center,Right"
2279:                     .Style         = 2
2280:                     .Visible       = .T.
2281:                     .Width         = 97
2282:                     .Height        = 21
2283:                 ENDWITH
2284:             ENDWITH
2285: 
2286:             WITH .Column7
2287:                 .Header1.Caption = "Tam."
2288:                 .ControlSource   = "cursor_4c_PropsGrp.LblTamCmp"
2289:                 .Width           = 169
2290:                 .Sparse          = .F.
2291:                 .AddObject("Spinner1", "Spinner")
2292:                 .CurrentControl  = "Spinner1"
2293:                 WITH .Spinner1
2294:                     .SpinnerLowValue  = 0
2295:                     .SpinnerHighValue = 9999
2296:                     .Increment        = 1
2297:                     .Visible          = .T.
2298:                     .Width            = 165
2299:                     .Height           = 21
2300:                 ENDWITH
2301:             ENDWITH
2302:         ENDWITH
2303: 
2304:         *-- BINDEVENTs (handlers devem ser PUBLIC)
2305:         LOCAL loc_oGrdTIT, loc_oGrdCMPs, loc_oGrdGRP
2306:         loc_oGrdTIT  = loc_oSubPg2.grd_4c_PropsTitulo
2307:         loc_oGrdCMPs = loc_oSubPg2.grd_4c_PropsCampos
2308:         loc_oGrdGRP  = loc_oSubPg2.grd_4c_PropsGrp
2309: 
2310:         BINDEVENT(loc_oSubPg2.cnt_4c_BotoesLayout.cmd_4c_VoltarLayout, "Click", THIS, "BtnVoltarLayoutClick")
2311:         BINDEVENT(loc_oSubPg2.cnt_4c_BotoesLayout.cmd_4c_GerarLayout,  "Click", THIS, "BtnGerarLayoutClick")
2312:         BINDEVENT(loc_oSubPg2.opt_4c_Orientacao, "InteractiveChange",   THIS, "OrientacaoChanged")
2313:         BINDEVENT(loc_oGrdTIT.Column3.Command1,   "Click",              THIS, "BtnFonteTITClick")
2314:         BINDEVENT(loc_oGrdTIT.Column4.Command1,   "Click",              THIS, "BtnCorTITClick")
2315:         BINDEVENT(loc_oGrdCMPs.Column5.Check1,    "When",               THIS, "ChkSubTotalWhen")
2316:         BINDEVENT(loc_oGrdCMPs.Column6.Check1,    "When",               THIS, "ChkTotalFinalWhen")
2317:         BINDEVENT(loc_oGrdCMPs.Column7.Edit1,     "KeyPress",          THIS, "EdtCaptionCMPsLostFocus")
2318:         BINDEVENT(loc_oGrdCMPs.Column9.Command1,  "Click",              THIS, "BtnFonteCMPsClick")
2319:         BINDEVENT(loc_oGrdCMPs.Column10.Command1, "Click",              THIS, "BtnCorCMPsClick")
2320:         BINDEVENT(loc_oGrdGRP.Column1.Combo1,     "InteractiveChange",  THIS, "ComboNmCampoGRPInteractiveChange")
2321:         BINDEVENT(loc_oGrdGRP.Column4.Command1,   "Click",              THIS, "BtnFonteGRPClick")
2322:         BINDEVENT(loc_oGrdGRP.Column5.Command1,   "Click",              THIS, "BtnCorGRPClick")
2323:     ENDPROC

*-- Linhas 2363 a 2397:
2363:         loc_cFonteNova = GETFONT(loc_cFontName, loc_nFontSize, loc_cFontStyle)
2364:         IF !EMPTY(loc_cFonteNova)
2365:             REPLACE LblFonte WITH loc_cFonteNova
2366:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsTitulo.Refresh()
2367:         ENDIF
2368:     ENDPROC
2369: 
2370:     *==========================================================================
2371:     * BtnCorTITClick - Seleciona cor do texto para o Titulo do Relatorio
2372:     *==========================================================================
2373:     PROCEDURE BtnCorTITClick()
2374:         LOCAL loc_nCor
2375:         IF !USED("cursor_4c_PropsTitulo")
2376:             RETURN
2377:         ENDIF
2378:         loc_nCor = GETCOLOR()
2379:         IF loc_nCor >= 0
2380:             SELECT cursor_4c_PropsTitulo
2381:             REPLACE LblBtCor WITH loc_nCor
2382:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsTitulo.Refresh()
2383:         ENDIF
2384:     ENDPROC
2385: 
2386:     *==========================================================================
2387:     * ChkSubTotalWhen - Valida se o campo suporta subtotal (somente numericos)
2388:     *==========================================================================
2389:     PROCEDURE ChkSubTotalWhen()
2390:         LOCAL loc_lPermite
2391:         loc_lPermite = .F.
2392:         IF USED("cursor_4c_PropsCampos") AND !EOF("cursor_4c_PropsCampos")
2393:             loc_lPermite = (cursor_4c_PropsCampos.LblTipoCmp $ "NU")
2394:         ENDIF
2395:         RETURN loc_lPermite
2396:     ENDPROC
2397: 

*-- Linhas 2424 a 2477:
2424:         IF loc_nTam > 0
2425:             SELECT cursor_4c_PropsCampos
2426:             REPLACE LblTamCmp WITH loc_nTam
2427:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsCampos.Refresh()
2428:         ENDIF
2429:     ENDPROC
2430: 
2431:     *==========================================================================
2432:     * BtnFonteCMPsClick - Seleciona fonte para coluna de Campos
2433:     *==========================================================================
2434:     PROCEDURE BtnFonteCMPsClick()
2435:         LOCAL loc_cFonteAtual, loc_cFontName, loc_nFontSize, loc_cFontStyle, loc_nFontStyle
2436:         LOCAL loc_cFonteNova
2437:         IF !USED("cursor_4c_PropsCampos") OR EOF("cursor_4c_PropsCampos")
2438:             RETURN
2439:         ENDIF
2440:         SELECT cursor_4c_PropsCampos
2441:         loc_cFonteAtual = ALLTRIM(NVL(cursor_4c_PropsCampos.LblFonte, "Tahoma,8,N"))
2442:         THIS.DetalharFonte(loc_cFonteAtual, @loc_cFontName, @loc_nFontSize, @loc_cFontStyle, @loc_nFontStyle)
2443:         loc_cFonteNova = GETFONT(loc_cFontName, loc_nFontSize, loc_cFontStyle)
2444:         IF !EMPTY(loc_cFonteNova)
2445:             REPLACE LblFonte WITH loc_cFonteNova
2446:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsCampos.Refresh()
2447:         ENDIF
2448:     ENDPROC
2449: 
2450:     *==========================================================================
2451:     * BtnCorCMPsClick - Seleciona cor do texto para coluna de Campos
2452:     *==========================================================================
2453:     PROCEDURE BtnCorCMPsClick()
2454:         LOCAL loc_nCor
2455:         IF !USED("cursor_4c_PropsCampos") OR EOF("cursor_4c_PropsCampos")
2456:             RETURN
2457:         ENDIF
2458:         loc_nCor = GETCOLOR()
2459:         IF loc_nCor >= 0
2460:             SELECT cursor_4c_PropsCampos
2461:             REPLACE LblBtCor WITH loc_nCor
2462:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsCampos.Refresh()
2463:         ENDIF
2464:     ENDPROC
2465: 
2466:     *==========================================================================
2467:     * ComboNmCampoGRPInteractiveChange - Atualiza LblTam ao selecionar campo do grupo
2468:     *==========================================================================
2469:     PROCEDURE ComboNmCampoGRPInteractiveChange()
2470:         LOCAL loc_cNmCampo, loc_cTpCampo, loc_cFonte, loc_nTam
2471:         IF !USED("cursor_4c_PropsGrp") OR EOF("cursor_4c_PropsGrp")
2472:             RETURN
2473:         ENDIF
2474:         loc_cNmCampo = ALLTRIM(NVL(cursor_4c_PropsGrp.NmCampo, ""))
2475:         IF EMPTY(loc_cNmCampo) OR !USED("cursor_4c_LstCampos")
2476:             RETURN
2477:         ENDIF

*-- Linhas 2484 a 2539:
2484:             loc_nTam   = THIS.Calc_TamCampo(loc_cTpCampo, loc_cFonte)
2485:             IF loc_nTam > 0
2486:                 REPLACE LblTamCmp WITH loc_nTam
2487:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsGrp.Refresh()
2488:             ENDIF
2489:         ENDIF
2490:         SELECT cursor_4c_PropsGrp
2491:     ENDPROC
2492: 
2493:     *==========================================================================
2494:     * BtnFonteGRPClick - Seleciona fonte para coluna do Grupo
2495:     *==========================================================================
2496:     PROCEDURE BtnFonteGRPClick()
2497:         LOCAL loc_cFonteAtual, loc_cFontName, loc_nFontSize, loc_cFontStyle, loc_nFontStyle
2498:         LOCAL loc_cFonteNova
2499:         IF !USED("cursor_4c_PropsGrp") OR EOF("cursor_4c_PropsGrp")
2500:             RETURN
2501:         ENDIF
2502:         SELECT cursor_4c_PropsGrp
2503:         loc_cFonteAtual = ALLTRIM(NVL(cursor_4c_PropsGrp.LblFonte, "Tahoma,8,N"))
2504:         THIS.DetalharFonte(loc_cFonteAtual, @loc_cFontName, @loc_nFontSize, @loc_cFontStyle, @loc_nFontStyle)
2505:         loc_cFonteNova = GETFONT(loc_cFontName, loc_nFontSize, loc_cFontStyle)
2506:         IF !EMPTY(loc_cFonteNova)
2507:             REPLACE LblFonte WITH loc_cFonteNova
2508:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsGrp.Refresh()
2509:         ENDIF
2510:     ENDPROC
2511: 
2512:     *==========================================================================
2513:     * BtnCorGRPClick - Seleciona cor do texto para coluna do Grupo
2514:     *==========================================================================
2515:     PROCEDURE BtnCorGRPClick()
2516:         LOCAL loc_nCor
2517:         IF !USED("cursor_4c_PropsGrp") OR EOF("cursor_4c_PropsGrp")
2518:             RETURN
2519:         ENDIF
2520:         loc_nCor = GETCOLOR()
2521:         IF loc_nCor >= 0
2522:             SELECT cursor_4c_PropsGrp
2523:             REPLACE LblBtCor WITH loc_nCor
2524:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsGrp.Refresh()
2525:         ENDIF
2526:     ENDPROC
2527: 
2528:     *==========================================================================
2529:     * Calc_TamCampo - Calcula largura em pixels baseado no tipo e fonte do campo
2530:     * par_cTpCampo: ex "varchar(50)", par_cFonte: "FontName,Size,Style"
2531:     *==========================================================================
2532:     PROCEDURE Calc_TamCampo(par_cTpCampo, par_cFonte)
2533:         LOCAL loc_lcTipo, loc_cTpWrk, loc_nFieldWidth, loc_nTam
2534:         LOCAL loc_cFontName, loc_nFontSize, loc_cFontStyle, loc_nFontStyle
2535:         LOCAL loc_nFontWidth
2536: 
2537:         loc_lcTipo      = UPPER(LEFT(ALLTRIM(par_cTpCampo), 1))
2538:         loc_cTpWrk      = STRTRAN(STRTRAN(STRTRAN(par_cTpCampo, loc_lcTipo, ""), "(", ""), ")", "")
2539:         loc_nFieldWidth = INT(VAL(ALLTRIM(loc_cTpWrk)))

