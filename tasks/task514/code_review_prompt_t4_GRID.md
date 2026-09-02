# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (5)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1401: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1542: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1895: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1991: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 2200: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormRPT.prg) - TRECHOS RELEVANTES PARA PASS GRID (3685 linhas total):

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
701:             .Top         = 170
702:             .Left        = 326
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
851:                 loc_oGrid.Column1.Header1.Caption = "T" + CHR(237) + "tulo"
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

*-- Linhas 1385 a 1421:
1385:                 IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
1386:                 MsgAviso("Sem conex" + CHR(227) + "o com o banco de dados.")
1387:             ELSE
1388:                 loc_oGrid = loc_oSubPg1.grd_4c_Resultado
1389:                 loc_oGrid.RecordSource = ""
1390:                 IF USED("cursor_4c_ResultadoTemp")
1391:                     USE IN cursor_4c_ResultadoTemp
1392:                 ENDIF
1393:                 IF USED("cursor_4c_Resultado")
1394:                     USE IN cursor_4c_Resultado
1395:                 ENDIF
1396:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ResultadoTemp")
1397:                 IF loc_nRes >= 0 AND USED("cursor_4c_ResultadoTemp")
1398:                     SELECT * FROM cursor_4c_ResultadoTemp INTO CURSOR cursor_4c_Resultado READWRITE
1399:                     USE IN cursor_4c_ResultadoTemp
1400:                     loc_oGrid.ColumnCount  = 0
1401:                     loc_oGrid.RecordSource = "cursor_4c_Resultado"
1402:                     *-- Reconfigurar ControlSource apos auto-bind (sobrepoe vinculo por posicao)
1403:                     loc_nTotalCols = FCOUNT("cursor_4c_Resultado")
1404:                     FOR loc_j = 1 TO loc_nTotalCols
1405:                         loc_oGrid.Columns(loc_j).ControlSource = "cursor_4c_Resultado." + FIELD(loc_j, "cursor_4c_Resultado")
1406:                         loc_oGrid.Columns(loc_j).Header1.Caption = FIELD(loc_j, "cursor_4c_Resultado")
1407:                     NEXT
1408:                 ELSE
1409:                     MsgErro("Erro ao executar SQL:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1410:                 ENDIF
1411:                 ENDIF
1412:             ENDIF
1413: 
1414:         CATCH TO loc_oErro
1415:             MsgErro("Erro ao executar SQL:" + CHR(13) + loc_oErro.Message, "FormRPT.BtnExecutarSQLClick")
1416:         ENDTRY
1417:     ENDPROC
1418: 
1419:     *==========================================================================
1420:     * BtnProcessarClick - Seta variaveis de data e executa SQL (FASE 9)
1421:     * Chamado pelo botao Processar (cmd_4c_Processar) dentro do cabecalho

*-- Linhas 1524 a 1562:
1524:                         "WHERE object_id = object_id(" + EscaparSQL(loc_cTabela) + ") " + ;
1525:                         "ORDER BY c.Column_ID"
1526: 
1527:                     loc_oGrid = loc_oSubPg1.grd_4c_Resultado
1528:                     loc_oGrid.RecordSource = ""
1529:                     IF USED("cursor_4c_ResultadoTemp")
1530:                         USE IN cursor_4c_ResultadoTemp
1531:                     ENDIF
1532:                     IF USED("cursor_4c_Resultado")
1533:                         USE IN cursor_4c_Resultado
1534:                     ENDIF
1535: 
1536:                     loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ResultadoTemp")
1537: 
1538:                     IF loc_nRes >= 0 AND USED("cursor_4c_ResultadoTemp")
1539:                         SELECT * FROM cursor_4c_ResultadoTemp INTO CURSOR cursor_4c_Resultado READWRITE
1540:                         USE IN cursor_4c_ResultadoTemp
1541:                         loc_oGrid.ColumnCount  = 0
1542:                         loc_oGrid.RecordSource = "cursor_4c_Resultado"
1543:                         *-- Reconfigurar ControlSource apos auto-bind (sobrepoe vinculo por posicao)
1544:                         loc_nTotalCols = FCOUNT("cursor_4c_Resultado")
1545:                         FOR loc_j = 1 TO loc_nTotalCols
1546:                             loc_oGrid.Columns(loc_j).ControlSource = "cursor_4c_Resultado." + FIELD(loc_j, "cursor_4c_Resultado")
1547:                             loc_oGrid.Columns(loc_j).Header1.Caption = FIELD(loc_j, "cursor_4c_Resultado")
1548:                         NEXT
1549:                         loc_lOK = .T.
1550:                     ELSE
1551:                         MsgErro("Tabela '" + loc_cTabela + "' n" + CHR(227) + "o encontrada.", "Estrutura")
1552:                     ENDIF
1553: 
1554:                     loc_oSubPg1.obj_4c_OleRTF_SqlCMD.SetFocus()
1555:                     ENDIF
1556:                     ENDIF
1557:                 ENDIF
1558: 
1559:             ENDIF
1560:         CATCH TO loc_oErro
1561:             MsgErro("Erro ao buscar estrutura:" + CHR(13) + loc_oErro.Message, "FormRPT.BtnEstruturaClick")
1562:         ENDTRY

*-- Linhas 1647 a 1693:
1647:             USE IN cursor_4c_LstCampos
1648:         ENDIF
1649: 
1650:         SET NULL ON
1651:         CREATE CURSOR cursor_4c_PropsTitulo ( ;
1652:             LblCaption M(4), LblFonte M(4), LblBtFonte C(1), LblBtCor I(10), ;
1653:             LblAlinhar C(6), LblTamCmp I(5), LblTipoCmp C(1), ArrayID I(5), ;
1654:             Orientation I(1), PaperSize I(1) ;
1655:         )
1656:         APPEND BLANK
1657:         REPLACE Orientation WITH 1, PaperSize WITH 9
1658:         REPLACE LblCaption WITH "", LblFonte WITH "Tahoma,10,N", LblBtFonte WITH ""
1659:         REPLACE LblBtCor WITH 0, LblAlinhar WITH "Left", LblTamCmp WITH 90, LblTipoCmp WITH "C"
1660: 
1661:         CREATE CURSOR cursor_4c_PropsGrp ( ;
1662:             NmCampo C(40), LblCaption M(4), LblFonte M(4), LblBtFonte C(1), ;
1663:             LblBtCor I(10), LblAlinhar C(6), LblTamCmp I(5), LblTipoCmp C(1), ArrayID I(5) ;
1664:         )
1665:         APPEND BLANK
1666:         REPLACE NmCampo WITH "", LblCaption WITH "Campo de SubTotal"
1667:         REPLACE LblFonte WITH "Tahoma,8,N", LblBtFonte WITH ""
1668:         REPLACE LblBtCor WITH 0, LblAlinhar WITH "Left", LblTamCmp WITH 10, LblTipoCmp WITH "C"
1669: 
1670:         CREATE CURSOR cursor_4c_PropsCampos ( ;
1671:             NmCampo C(40), TpCampo C(10), CkOutRPT I(1), CkFiltro I(1), ;
1672:             CkSubTot I(1), CkTotal I(1), LblCaption M(4), LblFonte M(4), ;
1673:             LblBtFonte C(1), LblBtCor I(10), LblAlinhar C(6), LblTamCmp I(5), ;
1674:             LblTipoCmp C(1), ArrayID I(5) ;
1675:         )
1676: 
1677:         CREATE CURSOR cursor_4c_LstCampos ( NmCampo C(40), TpCampo C(10) )
1678:         SET NULL OFF
1679:     ENDPROC
1680: 
1681:     *==========================================================================
1682:     * ConfigurarSubPaginaLayout - Constroi controles da Sub-Page2 (Layout FRX)
1683:     * Coordenadas originais do SCX + 29 (compensa pgf_4c_Dados.Top=-29)
1684:     *==========================================================================
1685:     PROTECTED PROCEDURE ConfigurarSubPaginaLayout()
1686:         LOCAL loc_oSubPg2, loc_i
1687:         LOCAL loc_aPaperSize(41)
1688:         loc_oSubPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
1689: 
1690:         *-- Container de botoes (CmdGrp_Acoes: Top=8+29=37)
1691:         loc_oSubPg2.AddObject("cnt_4c_BotoesLayout", "Container")
1692:         WITH loc_oSubPg2.cnt_4c_BotoesLayout
1693:             .Top         = 37

*-- Linhas 1758 a 1776:
1758:             .Width         = 348
1759:             .Height        = 24
1760:             .Style         = 2
1761:             .ColumnCount   = 2
1762:             .BoundColumn   = 2
1763:             .ColumnWidths  = "300,48"
1764:             .ControlSource = "cursor_4c_PropsTitulo.PaperSize"
1765:             .FontName      = "Tahoma"
1766:             .FontSize      = 8
1767:             .Visible       = .T.
1768:         ENDWITH
1769: 
1770:         *-- Preencher 41 tamanhos de papel (legado laPaperSize)
1771:         loc_aPaperSize[01] = "Letter, 8 1/2 x 11 in"
1772:         loc_aPaperSize[02] = "Letter Small, 8 1/2 x 11 in"
1773:         loc_aPaperSize[03] = "Tabloid, 11 x 17 in"
1774:         loc_aPaperSize[04] = "Ledger, 17 x 11 in"
1775:         loc_aPaperSize[05] = "Legal, 8 1/2 x 14 in"
1776:         loc_aPaperSize[06] = "Statement, 5 1/2 x 8 1/2 in"

*-- Linhas 1881 a 2345:
1881:             .Width     = 560
1882:             .Height    = 16
1883:             .FontName  = "Tahoma"
1884:             .FontSize  = 8
1885:             .FontBold  = .T.
1886:             .BackStyle = 0
1887:             .Visible   = .T.
1888:         ENDWITH
1889: 
1890:         *-- Grid: Propriedades do Titulo do Relatorio (grd_4c_PropsTitulo)
1891:         loc_oSubPg2.AddObject("grd_4c_PropsTitulo", "Grid")
1892:         loc_oSubPg2.grd_4c_PropsTitulo.ColumnCount      = 5
1893:         loc_oSubPg2.grd_4c_PropsTitulo.RecordSourceType  = 1
1894:         loc_oSubPg2.grd_4c_PropsTitulo.ColumnCount = 3
1895:         loc_oSubPg2.grd_4c_PropsTitulo.RecordSource      = "cursor_4c_PropsTitulo"
1896:         WITH loc_oSubPg2.grd_4c_PropsTitulo
1897:             .Top          = 209
1898:             .Left         = 4
1899:             .Width        = 990
1900:             .Height       = 65
1901:             .GridLines    = 1
1902:             .HeaderHeight = 18
1903:             .RowHeight    = 20
1904:             .ReadOnly     = .F.
1905:             .Visible      = .T.
1906:             .DeleteMark   = .F.
1907:             .RecordMark   = .F.
1908:             .ScrollBars   = 2
1909: 
1910:             WITH .Column1
1911:                 .Header1.Caption = "Titulo"
1912:                 .ControlSource   = "cursor_4c_PropsTitulo.LblCaption"
1913:                 .Width           = 120
1914:                 .Sparse          = .F.
1915:                 .AddObject("Edit1", "EditBox")
1916:                 .CurrentControl  = "Edit1"
1917:                 WITH .Edit1
1918:                     .Visible = .T.
1919:                     .Width   = 118
1920:                     .Height  = 40
1921:                 ENDWITH
1922:             ENDWITH
1923: 
1924:             WITH .Column2
1925:                 .Header1.Caption = "Fonte"
1926:                 .ControlSource   = "cursor_4c_PropsTitulo.LblFonte"
1927:                 .Width           = 300
1928:                 .Sparse          = .F.
1929:                 .AddObject("Edit1", "EditBox")
1930:                 .CurrentControl  = "Edit1"
1931:                 WITH .Edit1
1932:                     .Visible = .T.
1933:                     .Width   = 298
1934:                     .Height  = 40
1935:                 ENDWITH
1936:             ENDWITH
1937: 
1938:             WITH .Column3
1939:                 .Header1.Caption = "Fte"
1940:                 .ControlSource   = "cursor_4c_PropsTitulo.LblBtFonte"
1941:                 .Width           = 60
1942:                 .Sparse          = .F.
1943:                 .AddObject("Command1", "CommandButton")
1944:                 .CurrentControl  = "Command1"
1945:                 WITH .Command1
1946:                     .Caption = "..."
1947:                     .Visible = .T.
1948:                     .Width   = 55
1949:                     .Height  = 18
1950:                 ENDWITH
1951:             ENDWITH
1952: 
1953:             WITH .Column4
1954:                 .Header1.Caption = "Cor"
1955:                 .ControlSource   = "cursor_4c_PropsTitulo.LblBtCor"
1956:                 .Width           = 60
1957:                 .Sparse          = .F.
1958:                 .AddObject("Command1", "CommandButton")
1959:                 .CurrentControl  = "Command1"
1960:                 WITH .Command1
1961:                     .Caption = "..."
1962:                     .Visible = .T.
1963:                     .Width   = 55
1964:                     .Height  = 18
1965:                 ENDWITH
1966:             ENDWITH
1967: 
1968:             WITH .Column5
1969:                 .Header1.Caption = "Alinhar"
1970:                 .ControlSource   = "cursor_4c_PropsTitulo.LblAlinhar"
1971:                 .Width           = 450
1972:                 .Sparse          = .F.
1973:                 .AddObject("Combo1", "ComboBox")
1974:                 .CurrentControl  = "Combo1"
1975:                 WITH .Combo1
1976:                     .RowSourceType = 1
1977:                     .RowSource     = "Left,Center,Right"
1978:                     .Style         = 2
1979:                     .Visible       = .T.
1980:                     .Width         = 445
1981:                     .Height        = 21
1982:                 ENDWITH
1983:             ENDWITH
1984:         ENDWITH
1985: 
1986:         *-- Grid: Propriedades dos Campos (grd_4c_PropsCampos)
1987:         loc_oSubPg2.AddObject("grd_4c_PropsCampos", "Grid")
1988:         loc_oSubPg2.grd_4c_PropsCampos.ColumnCount      = 12
1989:         loc_oSubPg2.grd_4c_PropsCampos.RecordSourceType  = 1
1990:         loc_oSubPg2.grd_4c_PropsCampos.ColumnCount = 3
1991:         loc_oSubPg2.grd_4c_PropsCampos.RecordSource      = "cursor_4c_PropsCampos"
1992:         WITH loc_oSubPg2.grd_4c_PropsCampos
1993:             .Top          = 287
1994:             .Left         = 4
1995:             .Width        = 990
1996:             .Height       = 238
1997:             .GridLines    = 1
1998:             .HeaderHeight = 18
1999:             .RowHeight    = 20
2000:             .ReadOnly     = .F.
2001:             .Visible      = .T.
2002:             .DeleteMark   = .F.
2003:             .RecordMark   = .F.
2004:             .ScrollBars   = 3
2005: 
2006:             WITH .Column1
2007:                 .Header1.Caption = "Campo"
2008:                 .ControlSource   = "cursor_4c_PropsCampos.NmCampo"
2009:                 .Width           = 100
2010:                 .ReadOnly        = .T.
2011:                 .Sparse          = .F.
2012:                 .AddObject("Text1", "TextBox")
2013:                 .CurrentControl  = "Text1"
2014:                 WITH .Text1
2015:                     .ReadOnly = .T.
2016:                     .Visible  = .T.
2017:                     .Width    = 98
2018:                 ENDWITH
2019:             ENDWITH
2020: 
2021:             WITH .Column2
2022:                 .Header1.Caption = "Tipo"
2023:                 .ControlSource   = "cursor_4c_PropsCampos.TpCampo"
2024:                 .Width           = 75
2025:                 .ReadOnly        = .T.
2026:                 .Sparse          = .F.
2027:                 .AddObject("Text1", "TextBox")
2028:                 .CurrentControl  = "Text1"
2029:                 WITH .Text1
2030:                     .ReadOnly = .T.
2031:                     .Visible  = .T.
2032:                     .Width    = 73
2033:                 ENDWITH
2034:             ENDWITH
2035: 
2036:             WITH .Column3
2037:                 .Header1.Caption = "Sa" + CHR(237) + "da Rel."
2038:                 .ControlSource   = "cursor_4c_PropsCampos.CkOutRPT"
2039:                 .Width           = 65
2040:                 .Sparse          = .F.
2041:                 .AddObject("Check1", "CheckBox")
2042:                 .CurrentControl  = "Check1"
2043:                 WITH .Check1
2044:                     .Caption = ""
2045:                     .Visible = .T.
2046:                     .Width   = 60
2047:                     .Height  = 17
2048:                 ENDWITH
2049:             ENDWITH
2050: 
2051:             WITH .Column4
2052:                 .Header1.Caption = "Filtro"
2053:                 .ControlSource   = "cursor_4c_PropsCampos.CkFiltro"
2054:                 .Width           = 55
2055:                 .Sparse          = .F.
2056:                 .AddObject("Check1", "CheckBox")
2057:                 .CurrentControl  = "Check1"
2058:                 WITH .Check1
2059:                     .Caption = ""
2060:                     .Visible = .T.
2061:                     .Width   = 50
2062:                     .Height  = 17
2063:                 ENDWITH
2064:             ENDWITH
2065: 
2066:             WITH .Column5
2067:                 .Header1.Caption = "SubTot"
2068:                 .ControlSource   = "cursor_4c_PropsCampos.CkSubTot"
2069:                 .Width           = 60
2070:                 .Sparse          = .F.
2071:                 .AddObject("Check1", "CheckBox")
2072:                 .CurrentControl  = "Check1"
2073:                 WITH .Check1
2074:                     .Caption = ""
2075:                     .Visible = .T.
2076:                     .Width   = 55
2077:                     .Height  = 17
2078:                 ENDWITH
2079:             ENDWITH
2080: 
2081:             WITH .Column6
2082:                 .Header1.Caption = "Total"
2083:                 .ControlSource   = "cursor_4c_PropsCampos.CkTotal"
2084:                 .Width           = 55
2085:                 .Sparse          = .F.
2086:                 .AddObject("Check1", "CheckBox")
2087:                 .CurrentControl  = "Check1"
2088:                 WITH .Check1
2089:                     .Caption = ""
2090:                     .Visible = .T.
2091:                     .Width   = 50
2092:                     .Height  = 17
2093:                 ENDWITH
2094:             ENDWITH
2095: 
2096:             WITH .Column7
2097:                 .Header1.Caption = "Titulo do Campo"
2098:                 .ControlSource   = "cursor_4c_PropsCampos.LblCaption"
2099:                 .Width           = 140
2100:                 .Sparse          = .F.
2101:                 .AddObject("Edit1", "EditBox")
2102:                 .CurrentControl  = "Edit1"
2103:                 WITH .Edit1
2104:                     .Visible = .T.
2105:                     .Width   = 138
2106:                     .Height  = 40
2107:                 ENDWITH
2108:             ENDWITH
2109: 
2110:             WITH .Column8
2111:                 .Header1.Caption = "Fonte"
2112:                 .ControlSource   = "cursor_4c_PropsCampos.LblFonte"
2113:                 .Width           = 190
2114:                 .Sparse          = .F.
2115:                 .AddObject("Edit1", "EditBox")
2116:                 .CurrentControl  = "Edit1"
2117:                 WITH .Edit1
2118:                     .Visible = .T.
2119:                     .Width   = 188
2120:                     .Height  = 40
2121:                 ENDWITH
2122:             ENDWITH
2123: 
2124:             WITH .Column9
2125:                 .Header1.Caption = "Fte"
2126:                 .ControlSource   = "cursor_4c_PropsCampos.LblBtFonte"
2127:                 .Width           = 50
2128:                 .Sparse          = .F.
2129:                 .AddObject("Command1", "CommandButton")
2130:                 .CurrentControl  = "Command1"
2131:                 WITH .Command1
2132:                     .Caption = "..."
2133:                     .Visible = .T.
2134:                     .Width   = 46
2135:                     .Height  = 18
2136:                 ENDWITH
2137:             ENDWITH
2138: 
2139:             WITH .Column10
2140:                 .Header1.Caption = "Cor"
2141:                 .ControlSource   = "cursor_4c_PropsCampos.LblBtCor"
2142:                 .Width           = 50
2143:                 .Sparse          = .F.
2144:                 .AddObject("Command1", "CommandButton")
2145:                 .CurrentControl  = "Command1"
2146:                 WITH .Command1
2147:                     .Caption = "..."
2148:                     .Visible = .T.
2149:                     .Width   = 46
2150:                     .Height  = 18
2151:                 ENDWITH
2152:             ENDWITH
2153: 
2154:             WITH .Column11
2155:                 .Header1.Caption = "Alinhar"
2156:                 .ControlSource   = "cursor_4c_PropsCampos.LblAlinhar"
2157:                 .Width           = 80
2158:                 .Sparse          = .F.
2159:                 .AddObject("Combo1", "ComboBox")
2160:                 .CurrentControl  = "Combo1"
2161:                 WITH .Combo1
2162:                     .RowSourceType = 1
2163:                     .RowSource     = "Left,Center,Right"
2164:                     .Style         = 2
2165:                     .Visible       = .T.
2166:                     .Width         = 77
2167:                     .Height        = 21
2168:                 ENDWITH
2169:             ENDWITH
2170: 
2171:             WITH .Column12
2172:                 .Header1.Caption = "Tam."
2173:                 .ControlSource   = "cursor_4c_PropsCampos.LblTamCmp"
2174:                 .Width           = 70
2175:                 .Sparse          = .F.
2176:                 .AddObject("Spinner1", "Spinner")
2177:                 .CurrentControl  = "Spinner1"
2178:                 WITH .Spinner1
2179:                     .SpinnerLowValue  = 0
2180:                     .SpinnerHighValue = 9999
2181:                     .Increment        = 1
2182:                     .Visible          = .T.
2183:                     .Width            = 66
2184:                     .Height           = 21
2185:                 ENDWITH
2186:             ENDWITH
2187:         ENDWITH
2188: 
2189:         *-- DynamicBackColor: cinza escuro para SubTot/Total em campos nao-numericos
2190:         loc_oSubPg2.grd_4c_PropsCampos.Column5.DynamicBackColor = ;
2191:             "IIF(InList(cursor_4c_PropsCampos.LblTipoCmp,'N','U'),RGB(239,239,239),RGB(209,209,209))"
2192:         loc_oSubPg2.grd_4c_PropsCampos.Column6.DynamicBackColor = ;
2193:             "IIF(InList(cursor_4c_PropsCampos.LblTipoCmp,'N','U'),RGB(239,239,239),RGB(209,209,209))"
2194: 
2195:         *-- Grid: Propriedades do Grupo (grd_4c_PropsGrp)
2196:         loc_oSubPg2.AddObject("grd_4c_PropsGrp", "Grid")
2197:         loc_oSubPg2.grd_4c_PropsGrp.ColumnCount      = 7
2198:         loc_oSubPg2.grd_4c_PropsGrp.RecordSourceType  = 1
2199:         loc_oSubPg2.grd_4c_PropsGrp.ColumnCount = 3
2200:         loc_oSubPg2.grd_4c_PropsGrp.RecordSource      = "cursor_4c_PropsGrp"
2201:         WITH loc_oSubPg2.grd_4c_PropsGrp
2202:             .Top          = 558
2203:             .Left         = 4
2204:             .Width        = 989
2205:             .Height       = 67
2206:             .GridLines    = 1
2207:             .HeaderHeight = 18
2208:             .RowHeight    = 20
2209:             .ReadOnly     = .F.
2210:             .Visible      = .T.
2211:             .DeleteMark   = .F.
2212:             .RecordMark   = .F.
2213:             .ScrollBars   = 2
2214: 
2215:             WITH .Column1
2216:                 .Header1.Caption = "Grupo"
2217:                 .ControlSource   = "cursor_4c_PropsGrp.NmCampo"
2218:                 .Width           = 180
2219:                 .Sparse          = .F.
2220:                 .AddObject("Combo1", "ComboBox")
2221:                 .CurrentControl  = "Combo1"
2222:                 WITH .Combo1
2223:                     .RowSourceType = 2
2224:                     .RowSource     = "cursor_4c_LstCampos.NmCampo"
2225:                     .BoundColumn   = 1
2226:                     .Style         = 0
2227:                     .Visible       = .T.
2228:                     .Width         = 177
2229:                     .Height        = 21
2230:                 ENDWITH
2231:             ENDWITH
2232: 
2233:             WITH .Column2
2234:                 .Header1.Caption = "Titulo do Campo"
2235:                 .ControlSource   = "cursor_4c_PropsGrp.LblCaption"
2236:                 .Width           = 180
2237:                 .Sparse          = .F.
2238:                 .AddObject("Edit1", "EditBox")
2239:                 .CurrentControl  = "Edit1"
2240:                 WITH .Edit1
2241:                     .Visible = .T.
2242:                     .Width   = 178
2243:                     .Height  = 40
2244:                 ENDWITH
2245:             ENDWITH
2246: 
2247:             WITH .Column3
2248:                 .Header1.Caption = "Fonte"
2249:                 .ControlSource   = "cursor_4c_PropsGrp.LblFonte"
2250:                 .Width           = 200
2251:                 .Sparse          = .F.
2252:                 .AddObject("Edit1", "EditBox")
2253:                 .CurrentControl  = "Edit1"
2254:                 WITH .Edit1
2255:                     .Visible = .T.
2256:                     .Width   = 198
2257:                     .Height  = 40
2258:                 ENDWITH
2259:             ENDWITH
2260: 
2261:             WITH .Column4
2262:                 .Header1.Caption = "Fte"
2263:                 .ControlSource   = "cursor_4c_PropsGrp.LblBtFonte"
2264:                 .Width           = 80
2265:                 .Sparse          = .F.
2266:                 .AddObject("Command1", "CommandButton")
2267:                 .CurrentControl  = "Command1"
2268:                 WITH .Command1
2269:                     .Caption = "..."
2270:                     .Visible = .T.
2271:                     .Width   = 76
2272:                     .Height  = 18
2273:                 ENDWITH
2274:             ENDWITH
2275: 
2276:             WITH .Column5
2277:                 .Header1.Caption = "Cor"
2278:                 .ControlSource   = "cursor_4c_PropsGrp.LblBtCor"
2279:                 .Width           = 80
2280:                 .Sparse          = .F.
2281:                 .AddObject("Command1", "CommandButton")
2282:                 .CurrentControl  = "Command1"
2283:                 WITH .Command1
2284:                     .Caption = "..."
2285:                     .Visible = .T.
2286:                     .Width   = 76
2287:                     .Height  = 18
2288:                 ENDWITH
2289:             ENDWITH
2290: 
2291:             WITH .Column6
2292:                 .Header1.Caption = "Alinhar"
2293:                 .ControlSource   = "cursor_4c_PropsGrp.LblAlinhar"
2294:                 .Width           = 100
2295:                 .Sparse          = .F.
2296:                 .AddObject("Combo1", "ComboBox")
2297:                 .CurrentControl  = "Combo1"
2298:                 WITH .Combo1
2299:                     .RowSourceType = 1
2300:                     .RowSource     = "Left,Center,Right"
2301:                     .Style         = 2
2302:                     .Visible       = .T.
2303:                     .Width         = 97
2304:                     .Height        = 21
2305:                 ENDWITH
2306:             ENDWITH
2307: 
2308:             WITH .Column7
2309:                 .Header1.Caption = "Tam."
2310:                 .ControlSource   = "cursor_4c_PropsGrp.LblTamCmp"
2311:                 .Width           = 169
2312:                 .Sparse          = .F.
2313:                 .AddObject("Spinner1", "Spinner")
2314:                 .CurrentControl  = "Spinner1"
2315:                 WITH .Spinner1
2316:                     .SpinnerLowValue  = 0
2317:                     .SpinnerHighValue = 9999
2318:                     .Increment        = 1
2319:                     .Visible          = .T.
2320:                     .Width            = 165
2321:                     .Height           = 21
2322:                 ENDWITH
2323:             ENDWITH
2324:         ENDWITH
2325: 
2326:         *-- BINDEVENTs (handlers devem ser PUBLIC)
2327:         LOCAL loc_oGrdTIT, loc_oGrdCMPs, loc_oGrdGRP
2328:         loc_oGrdTIT  = loc_oSubPg2.grd_4c_PropsTitulo
2329:         loc_oGrdCMPs = loc_oSubPg2.grd_4c_PropsCampos
2330:         loc_oGrdGRP  = loc_oSubPg2.grd_4c_PropsGrp
2331: 
2332:         BINDEVENT(loc_oSubPg2.cnt_4c_BotoesLayout.cmd_4c_VoltarLayout, "Click", THIS, "BtnVoltarLayoutClick")
2333:         BINDEVENT(loc_oSubPg2.cnt_4c_BotoesLayout.cmd_4c_GerarLayout,  "Click", THIS, "BtnGerarLayoutClick")
2334:         BINDEVENT(loc_oSubPg2.opt_4c_Orientacao, "InteractiveChange",   THIS, "OrientacaoChanged")
2335:         BINDEVENT(loc_oGrdTIT.Column3.Command1,   "Click",              THIS, "BtnFonteTITClick")
2336:         BINDEVENT(loc_oGrdTIT.Column4.Command1,   "Click",              THIS, "BtnCorTITClick")
2337:         BINDEVENT(loc_oGrdCMPs.Column5.Check1,    "When",               THIS, "ChkSubTotalWhen")
2338:         BINDEVENT(loc_oGrdCMPs.Column6.Check1,    "When",               THIS, "ChkTotalFinalWhen")
2339:         BINDEVENT(loc_oGrdCMPs.Column7.Edit1,     "KeyPress",          THIS, "EdtCaptionCMPsLostFocus")
2340:         BINDEVENT(loc_oGrdCMPs.Column9.Command1,  "Click",              THIS, "BtnFonteCMPsClick")
2341:         BINDEVENT(loc_oGrdCMPs.Column10.Command1, "Click",              THIS, "BtnCorCMPsClick")
2342:         BINDEVENT(loc_oGrdGRP.Column1.Combo1,     "InteractiveChange",  THIS, "ComboNmCampoGRPInteractiveChange")
2343:         BINDEVENT(loc_oGrdGRP.Column4.Command1,   "Click",              THIS, "BtnFonteGRPClick")
2344:         BINDEVENT(loc_oGrdGRP.Column5.Command1,   "Click",              THIS, "BtnCorGRPClick")
2345:     ENDPROC

*-- Linhas 2385 a 2419:
2385:         loc_cFonteNova = GETFONT(loc_cFontName, loc_nFontSize, loc_cFontStyle)
2386:         IF !EMPTY(loc_cFonteNova)
2387:             REPLACE LblFonte WITH loc_cFonteNova
2388:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsTitulo.Refresh()
2389:         ENDIF
2390:     ENDPROC
2391: 
2392:     *==========================================================================
2393:     * BtnCorTITClick - Seleciona cor do texto para o Titulo do Relatorio
2394:     *==========================================================================
2395:     PROCEDURE BtnCorTITClick()
2396:         LOCAL loc_nCor
2397:         IF !USED("cursor_4c_PropsTitulo")
2398:             RETURN
2399:         ENDIF
2400:         loc_nCor = GETCOLOR()
2401:         IF loc_nCor >= 0
2402:             SELECT cursor_4c_PropsTitulo
2403:             REPLACE LblBtCor WITH loc_nCor
2404:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsTitulo.Refresh()
2405:         ENDIF
2406:     ENDPROC
2407: 
2408:     *==========================================================================
2409:     * ChkSubTotalWhen - Valida se o campo suporta subtotal (somente numericos)
2410:     *==========================================================================
2411:     PROCEDURE ChkSubTotalWhen()
2412:         LOCAL loc_lPermite
2413:         loc_lPermite = .F.
2414:         IF USED("cursor_4c_PropsCampos") AND !EOF("cursor_4c_PropsCampos")
2415:             loc_lPermite = (cursor_4c_PropsCampos.LblTipoCmp $ "NU")
2416:         ENDIF
2417:         RETURN loc_lPermite
2418:     ENDPROC
2419: 

*-- Linhas 2446 a 2499:
2446:         IF loc_nTam > 0
2447:             SELECT cursor_4c_PropsCampos
2448:             REPLACE LblTamCmp WITH loc_nTam
2449:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsCampos.Refresh()
2450:         ENDIF
2451:     ENDPROC
2452: 
2453:     *==========================================================================
2454:     * BtnFonteCMPsClick - Seleciona fonte para coluna de Campos
2455:     *==========================================================================
2456:     PROCEDURE BtnFonteCMPsClick()
2457:         LOCAL loc_cFonteAtual, loc_cFontName, loc_nFontSize, loc_cFontStyle, loc_nFontStyle
2458:         LOCAL loc_cFonteNova
2459:         IF !USED("cursor_4c_PropsCampos") OR EOF("cursor_4c_PropsCampos")
2460:             RETURN
2461:         ENDIF
2462:         SELECT cursor_4c_PropsCampos
2463:         loc_cFonteAtual = ALLTRIM(NVL(cursor_4c_PropsCampos.LblFonte, "Tahoma,8,N"))
2464:         THIS.DetalharFonte(loc_cFonteAtual, @loc_cFontName, @loc_nFontSize, @loc_cFontStyle, @loc_nFontStyle)
2465:         loc_cFonteNova = GETFONT(loc_cFontName, loc_nFontSize, loc_cFontStyle)
2466:         IF !EMPTY(loc_cFonteNova)
2467:             REPLACE LblFonte WITH loc_cFonteNova
2468:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsCampos.Refresh()
2469:         ENDIF
2470:     ENDPROC
2471: 
2472:     *==========================================================================
2473:     * BtnCorCMPsClick - Seleciona cor do texto para coluna de Campos
2474:     *==========================================================================
2475:     PROCEDURE BtnCorCMPsClick()
2476:         LOCAL loc_nCor
2477:         IF !USED("cursor_4c_PropsCampos") OR EOF("cursor_4c_PropsCampos")
2478:             RETURN
2479:         ENDIF
2480:         loc_nCor = GETCOLOR()
2481:         IF loc_nCor >= 0
2482:             SELECT cursor_4c_PropsCampos
2483:             REPLACE LblBtCor WITH loc_nCor
2484:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsCampos.Refresh()
2485:         ENDIF
2486:     ENDPROC
2487: 
2488:     *==========================================================================
2489:     * ComboNmCampoGRPInteractiveChange - Atualiza LblTam ao selecionar campo do grupo
2490:     *==========================================================================
2491:     PROCEDURE ComboNmCampoGRPInteractiveChange()
2492:         LOCAL loc_cNmCampo, loc_cTpCampo, loc_cFonte, loc_nTam
2493:         IF !USED("cursor_4c_PropsGrp") OR EOF("cursor_4c_PropsGrp")
2494:             RETURN
2495:         ENDIF
2496:         loc_cNmCampo = ALLTRIM(NVL(cursor_4c_PropsGrp.NmCampo, ""))
2497:         IF EMPTY(loc_cNmCampo) OR !USED("cursor_4c_LstCampos")
2498:             RETURN
2499:         ENDIF

*-- Linhas 2506 a 2561:
2506:             loc_nTam   = THIS.Calc_TamCampo(loc_cTpCampo, loc_cFonte)
2507:             IF loc_nTam > 0
2508:                 REPLACE LblTamCmp WITH loc_nTam
2509:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsGrp.Refresh()
2510:             ENDIF
2511:         ENDIF
2512:         SELECT cursor_4c_PropsGrp
2513:     ENDPROC
2514: 
2515:     *==========================================================================
2516:     * BtnFonteGRPClick - Seleciona fonte para coluna do Grupo
2517:     *==========================================================================
2518:     PROCEDURE BtnFonteGRPClick()
2519:         LOCAL loc_cFonteAtual, loc_cFontName, loc_nFontSize, loc_cFontStyle, loc_nFontStyle
2520:         LOCAL loc_cFonteNova
2521:         IF !USED("cursor_4c_PropsGrp") OR EOF("cursor_4c_PropsGrp")
2522:             RETURN
2523:         ENDIF
2524:         SELECT cursor_4c_PropsGrp
2525:         loc_cFonteAtual = ALLTRIM(NVL(cursor_4c_PropsGrp.LblFonte, "Tahoma,8,N"))
2526:         THIS.DetalharFonte(loc_cFonteAtual, @loc_cFontName, @loc_nFontSize, @loc_cFontStyle, @loc_nFontStyle)
2527:         loc_cFonteNova = GETFONT(loc_cFontName, loc_nFontSize, loc_cFontStyle)
2528:         IF !EMPTY(loc_cFonteNova)
2529:             REPLACE LblFonte WITH loc_cFonteNova
2530:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsGrp.Refresh()
2531:         ENDIF
2532:     ENDPROC
2533: 
2534:     *==========================================================================
2535:     * BtnCorGRPClick - Seleciona cor do texto para coluna do Grupo
2536:     *==========================================================================
2537:     PROCEDURE BtnCorGRPClick()
2538:         LOCAL loc_nCor
2539:         IF !USED("cursor_4c_PropsGrp") OR EOF("cursor_4c_PropsGrp")
2540:             RETURN
2541:         ENDIF
2542:         loc_nCor = GETCOLOR()
2543:         IF loc_nCor >= 0
2544:             SELECT cursor_4c_PropsGrp
2545:             REPLACE LblBtCor WITH loc_nCor
2546:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsGrp.Refresh()
2547:         ENDIF
2548:     ENDPROC
2549: 
2550:     *==========================================================================
2551:     * Calc_TamCampo - Calcula largura em pixels baseado no tipo e fonte do campo
2552:     * par_cTpCampo: ex "varchar(50)", par_cFonte: "FontName,Size,Style"
2553:     *==========================================================================
2554:     PROCEDURE Calc_TamCampo(par_cTpCampo, par_cFonte)
2555:         LOCAL loc_lcTipo, loc_cTpWrk, loc_nFieldWidth, loc_nTam
2556:         LOCAL loc_cFontName, loc_nFontSize, loc_cFontStyle, loc_nFontStyle
2557:         LOCAL loc_nFontWidth
2558: 
2559:         loc_lcTipo      = UPPER(LEFT(ALLTRIM(par_cTpCampo), 1))
2560:         loc_cTpWrk      = STRTRAN(STRTRAN(STRTRAN(par_cTpCampo, loc_lcTipo, ""), "(", ""), ")", "")
2561:         loc_nFieldWidth = INT(VAL(ALLTRIM(loc_cTpWrk)))

