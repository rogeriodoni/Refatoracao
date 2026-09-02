# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (5)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1401: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1536: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1883: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1979: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 2188: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormRPT.prg) - TRECHOS RELEVANTES PARA PASS GRID (3673 linhas total):

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

*-- Linhas 1385 a 1417:
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
1402:                 ELSE
1403:                     MsgErro("Erro ao executar SQL:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1404:                 ENDIF
1405:                 ENDIF
1406:             ENDIF
1407: 
1408:         CATCH TO loc_oErro
1409:             MsgErro("Erro ao executar SQL:" + CHR(13) + loc_oErro.Message, "FormRPT.BtnExecutarSQLClick")
1410:         ENDTRY
1411:     ENDPROC
1412: 
1413:     *==========================================================================
1414:     * BtnProcessarClick - Seta variaveis de data e executa SQL (FASE 9)
1415:     * Chamado pelo botao Processar (cmd_4c_Processar) dentro do cabecalho
1416:     *==========================================================================
1417:     PROCEDURE BtnProcessarClick()

*-- Linhas 1518 a 1552:
1518:                         "WHERE object_id = object_id(" + EscaparSQL(loc_cTabela) + ") " + ;
1519:                         "ORDER BY c.Column_ID"
1520: 
1521:                     loc_oGrid = loc_oSubPg1.grd_4c_Resultado
1522:                     loc_oGrid.RecordSource = ""
1523:                     IF USED("cursor_4c_ResultadoTemp")
1524:                         USE IN cursor_4c_ResultadoTemp
1525:                     ENDIF
1526:                     IF USED("cursor_4c_Resultado")
1527:                         USE IN cursor_4c_Resultado
1528:                     ENDIF
1529: 
1530:                     loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ResultadoTemp")
1531: 
1532:                     IF loc_nRes >= 0 AND USED("cursor_4c_ResultadoTemp")
1533:                         SELECT * FROM cursor_4c_ResultadoTemp INTO CURSOR cursor_4c_Resultado READWRITE
1534:                         USE IN cursor_4c_ResultadoTemp
1535:                         loc_oGrid.ColumnCount  = 0
1536:                         loc_oGrid.RecordSource = "cursor_4c_Resultado"
1537:                         loc_lOK = .T.
1538:                     ELSE
1539:                         MsgErro("Tabela '" + loc_cTabela + "' n" + CHR(227) + "o encontrada.", "Estrutura")
1540:                     ENDIF
1541: 
1542:                     loc_oSubPg1.obj_4c_OleRTF_SqlCMD.SetFocus()
1543:                     ENDIF
1544:                     ENDIF
1545:                 ENDIF
1546: 
1547:             ENDIF
1548:         CATCH TO loc_oErro
1549:             MsgErro("Erro ao buscar estrutura:" + CHR(13) + loc_oErro.Message, "FormRPT.BtnEstruturaClick")
1550:         ENDTRY
1551: 
1552:         RETURN loc_lOK

*-- Linhas 1635 a 1681:
1635:             USE IN cursor_4c_LstCampos
1636:         ENDIF
1637: 
1638:         SET NULL ON
1639:         CREATE CURSOR cursor_4c_PropsTitulo ( ;
1640:             LblCaption M(4), LblFonte M(4), LblBtFonte C(1), LblBtCor I(10), ;
1641:             LblAlinhar C(6), LblTamCmp I(5), LblTipoCmp C(1), ArrayID I(5), ;
1642:             Orientation I(1), PaperSize I(1) ;
1643:         )
1644:         APPEND BLANK
1645:         REPLACE Orientation WITH 1, PaperSize WITH 9
1646:         REPLACE LblCaption WITH "", LblFonte WITH "Tahoma,10,N", LblBtFonte WITH ""
1647:         REPLACE LblBtCor WITH 0, LblAlinhar WITH "Left", LblTamCmp WITH 90, LblTipoCmp WITH "C"
1648: 
1649:         CREATE CURSOR cursor_4c_PropsGrp ( ;
1650:             NmCampo C(40), LblCaption M(4), LblFonte M(4), LblBtFonte C(1), ;
1651:             LblBtCor I(10), LblAlinhar C(6), LblTamCmp I(5), LblTipoCmp C(1), ArrayID I(5) ;
1652:         )
1653:         APPEND BLANK
1654:         REPLACE NmCampo WITH "", LblCaption WITH "Campo de SubTotal"
1655:         REPLACE LblFonte WITH "Tahoma,8,N", LblBtFonte WITH ""
1656:         REPLACE LblBtCor WITH 0, LblAlinhar WITH "Left", LblTamCmp WITH 10, LblTipoCmp WITH "C"
1657: 
1658:         CREATE CURSOR cursor_4c_PropsCampos ( ;
1659:             NmCampo C(40), TpCampo C(10), CkOutRPT I(1), CkFiltro I(1), ;
1660:             CkSubTot I(1), CkTotal I(1), LblCaption M(4), LblFonte M(4), ;
1661:             LblBtFonte C(1), LblBtCor I(10), LblAlinhar C(6), LblTamCmp I(5), ;
1662:             LblTipoCmp C(1), ArrayID I(5) ;
1663:         )
1664: 
1665:         CREATE CURSOR cursor_4c_LstCampos ( NmCampo C(40), TpCampo C(10) )
1666:         SET NULL OFF
1667:     ENDPROC
1668: 
1669:     *==========================================================================
1670:     * ConfigurarSubPaginaLayout - Constroi controles da Sub-Page2 (Layout FRX)
1671:     * Coordenadas originais do SCX + 29 (compensa pgf_4c_Dados.Top=-29)
1672:     *==========================================================================
1673:     PROTECTED PROCEDURE ConfigurarSubPaginaLayout()
1674:         LOCAL loc_oSubPg2, loc_i
1675:         LOCAL loc_aPaperSize(41)
1676:         loc_oSubPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
1677: 
1678:         *-- Container de botoes (CmdGrp_Acoes: Top=8+29=37)
1679:         loc_oSubPg2.AddObject("cnt_4c_BotoesLayout", "Container")
1680:         WITH loc_oSubPg2.cnt_4c_BotoesLayout
1681:             .Top         = 37

*-- Linhas 1746 a 1764:
1746:             .Width         = 348
1747:             .Height        = 24
1748:             .Style         = 2
1749:             .ColumnCount   = 2
1750:             .BoundColumn   = 2
1751:             .ColumnWidths  = "300,48"
1752:             .ControlSource = "cursor_4c_PropsTitulo.PaperSize"
1753:             .FontName      = "Tahoma"
1754:             .FontSize      = 8
1755:             .Visible       = .T.
1756:         ENDWITH
1757: 
1758:         *-- Preencher 41 tamanhos de papel (legado laPaperSize)
1759:         loc_aPaperSize[01] = "Letter, 8 1/2 x 11 in"
1760:         loc_aPaperSize[02] = "Letter Small, 8 1/2 x 11 in"
1761:         loc_aPaperSize[03] = "Tabloid, 11 x 17 in"
1762:         loc_aPaperSize[04] = "Ledger, 17 x 11 in"
1763:         loc_aPaperSize[05] = "Legal, 8 1/2 x 14 in"
1764:         loc_aPaperSize[06] = "Statement, 5 1/2 x 8 1/2 in"

*-- Linhas 1869 a 2333:
1869:             .Width     = 560
1870:             .Height    = 16
1871:             .FontName  = "Tahoma"
1872:             .FontSize  = 8
1873:             .FontBold  = .T.
1874:             .BackStyle = 0
1875:             .Visible   = .T.
1876:         ENDWITH
1877: 
1878:         *-- Grid: Propriedades do Titulo do Relatorio (grd_4c_PropsTitulo)
1879:         loc_oSubPg2.AddObject("grd_4c_PropsTitulo", "Grid")
1880:         loc_oSubPg2.grd_4c_PropsTitulo.ColumnCount      = 5
1881:         loc_oSubPg2.grd_4c_PropsTitulo.RecordSourceType  = 1
1882:         loc_oSubPg2.grd_4c_PropsTitulo.ColumnCount = 3
1883:         loc_oSubPg2.grd_4c_PropsTitulo.RecordSource      = "cursor_4c_PropsTitulo"
1884:         WITH loc_oSubPg2.grd_4c_PropsTitulo
1885:             .Top          = 209
1886:             .Left         = 4
1887:             .Width        = 990
1888:             .Height       = 65
1889:             .GridLines    = 1
1890:             .HeaderHeight = 18
1891:             .RowHeight    = 20
1892:             .ReadOnly     = .F.
1893:             .Visible      = .T.
1894:             .DeleteMark   = .F.
1895:             .RecordMark   = .F.
1896:             .ScrollBars   = 2
1897: 
1898:             WITH .Column1
1899:                 .Header1.Caption = "Titulo"
1900:                 .ControlSource   = "cursor_4c_PropsTitulo.LblCaption"
1901:                 .Width           = 120
1902:                 .Sparse          = .F.
1903:                 .AddObject("Edit1", "EditBox")
1904:                 .CurrentControl  = "Edit1"
1905:                 WITH .Edit1
1906:                     .Visible = .T.
1907:                     .Width   = 118
1908:                     .Height  = 40
1909:                 ENDWITH
1910:             ENDWITH
1911: 
1912:             WITH .Column2
1913:                 .Header1.Caption = "Fonte"
1914:                 .ControlSource   = "cursor_4c_PropsTitulo.LblFonte"
1915:                 .Width           = 300
1916:                 .Sparse          = .F.
1917:                 .AddObject("Edit1", "EditBox")
1918:                 .CurrentControl  = "Edit1"
1919:                 WITH .Edit1
1920:                     .Visible = .T.
1921:                     .Width   = 298
1922:                     .Height  = 40
1923:                 ENDWITH
1924:             ENDWITH
1925: 
1926:             WITH .Column3
1927:                 .Header1.Caption = "Fte"
1928:                 .ControlSource   = "cursor_4c_PropsTitulo.LblBtFonte"
1929:                 .Width           = 60
1930:                 .Sparse          = .F.
1931:                 .AddObject("Command1", "CommandButton")
1932:                 .CurrentControl  = "Command1"
1933:                 WITH .Command1
1934:                     .Caption = "..."
1935:                     .Visible = .T.
1936:                     .Width   = 55
1937:                     .Height  = 18
1938:                 ENDWITH
1939:             ENDWITH
1940: 
1941:             WITH .Column4
1942:                 .Header1.Caption = "Cor"
1943:                 .ControlSource   = "cursor_4c_PropsTitulo.LblBtCor"
1944:                 .Width           = 60
1945:                 .Sparse          = .F.
1946:                 .AddObject("Command1", "CommandButton")
1947:                 .CurrentControl  = "Command1"
1948:                 WITH .Command1
1949:                     .Caption = "..."
1950:                     .Visible = .T.
1951:                     .Width   = 55
1952:                     .Height  = 18
1953:                 ENDWITH
1954:             ENDWITH
1955: 
1956:             WITH .Column5
1957:                 .Header1.Caption = "Alinhar"
1958:                 .ControlSource   = "cursor_4c_PropsTitulo.LblAlinhar"
1959:                 .Width           = 450
1960:                 .Sparse          = .F.
1961:                 .AddObject("Combo1", "ComboBox")
1962:                 .CurrentControl  = "Combo1"
1963:                 WITH .Combo1
1964:                     .RowSourceType = 1
1965:                     .RowSource     = "Left,Center,Right"
1966:                     .Style         = 2
1967:                     .Visible       = .T.
1968:                     .Width         = 445
1969:                     .Height        = 21
1970:                 ENDWITH
1971:             ENDWITH
1972:         ENDWITH
1973: 
1974:         *-- Grid: Propriedades dos Campos (grd_4c_PropsCampos)
1975:         loc_oSubPg2.AddObject("grd_4c_PropsCampos", "Grid")
1976:         loc_oSubPg2.grd_4c_PropsCampos.ColumnCount      = 12
1977:         loc_oSubPg2.grd_4c_PropsCampos.RecordSourceType  = 1
1978:         loc_oSubPg2.grd_4c_PropsCampos.ColumnCount = 3
1979:         loc_oSubPg2.grd_4c_PropsCampos.RecordSource      = "cursor_4c_PropsCampos"
1980:         WITH loc_oSubPg2.grd_4c_PropsCampos
1981:             .Top          = 287
1982:             .Left         = 4
1983:             .Width        = 990
1984:             .Height       = 238
1985:             .GridLines    = 1
1986:             .HeaderHeight = 18
1987:             .RowHeight    = 20
1988:             .ReadOnly     = .F.
1989:             .Visible      = .T.
1990:             .DeleteMark   = .F.
1991:             .RecordMark   = .F.
1992:             .ScrollBars   = 3
1993: 
1994:             WITH .Column1
1995:                 .Header1.Caption = "Campo"
1996:                 .ControlSource   = "cursor_4c_PropsCampos.NmCampo"
1997:                 .Width           = 100
1998:                 .ReadOnly        = .T.
1999:                 .Sparse          = .F.
2000:                 .AddObject("Text1", "TextBox")
2001:                 .CurrentControl  = "Text1"
2002:                 WITH .Text1
2003:                     .ReadOnly = .T.
2004:                     .Visible  = .T.
2005:                     .Width    = 98
2006:                 ENDWITH
2007:             ENDWITH
2008: 
2009:             WITH .Column2
2010:                 .Header1.Caption = "Tipo"
2011:                 .ControlSource   = "cursor_4c_PropsCampos.TpCampo"
2012:                 .Width           = 75
2013:                 .ReadOnly        = .T.
2014:                 .Sparse          = .F.
2015:                 .AddObject("Text1", "TextBox")
2016:                 .CurrentControl  = "Text1"
2017:                 WITH .Text1
2018:                     .ReadOnly = .T.
2019:                     .Visible  = .T.
2020:                     .Width    = 73
2021:                 ENDWITH
2022:             ENDWITH
2023: 
2024:             WITH .Column3
2025:                 .Header1.Caption = "Sa" + CHR(237) + "da Rel."
2026:                 .ControlSource   = "cursor_4c_PropsCampos.CkOutRPT"
2027:                 .Width           = 65
2028:                 .Sparse          = .F.
2029:                 .AddObject("Check1", "CheckBox")
2030:                 .CurrentControl  = "Check1"
2031:                 WITH .Check1
2032:                     .Caption = ""
2033:                     .Visible = .T.
2034:                     .Width   = 60
2035:                     .Height  = 17
2036:                 ENDWITH
2037:             ENDWITH
2038: 
2039:             WITH .Column4
2040:                 .Header1.Caption = "Filtro"
2041:                 .ControlSource   = "cursor_4c_PropsCampos.CkFiltro"
2042:                 .Width           = 55
2043:                 .Sparse          = .F.
2044:                 .AddObject("Check1", "CheckBox")
2045:                 .CurrentControl  = "Check1"
2046:                 WITH .Check1
2047:                     .Caption = ""
2048:                     .Visible = .T.
2049:                     .Width   = 50
2050:                     .Height  = 17
2051:                 ENDWITH
2052:             ENDWITH
2053: 
2054:             WITH .Column5
2055:                 .Header1.Caption = "SubTot"
2056:                 .ControlSource   = "cursor_4c_PropsCampos.CkSubTot"
2057:                 .Width           = 60
2058:                 .Sparse          = .F.
2059:                 .AddObject("Check1", "CheckBox")
2060:                 .CurrentControl  = "Check1"
2061:                 WITH .Check1
2062:                     .Caption = ""
2063:                     .Visible = .T.
2064:                     .Width   = 55
2065:                     .Height  = 17
2066:                 ENDWITH
2067:             ENDWITH
2068: 
2069:             WITH .Column6
2070:                 .Header1.Caption = "Total"
2071:                 .ControlSource   = "cursor_4c_PropsCampos.CkTotal"
2072:                 .Width           = 55
2073:                 .Sparse          = .F.
2074:                 .AddObject("Check1", "CheckBox")
2075:                 .CurrentControl  = "Check1"
2076:                 WITH .Check1
2077:                     .Caption = ""
2078:                     .Visible = .T.
2079:                     .Width   = 50
2080:                     .Height  = 17
2081:                 ENDWITH
2082:             ENDWITH
2083: 
2084:             WITH .Column7
2085:                 .Header1.Caption = "Titulo do Campo"
2086:                 .ControlSource   = "cursor_4c_PropsCampos.LblCaption"
2087:                 .Width           = 140
2088:                 .Sparse          = .F.
2089:                 .AddObject("Edit1", "EditBox")
2090:                 .CurrentControl  = "Edit1"
2091:                 WITH .Edit1
2092:                     .Visible = .T.
2093:                     .Width   = 138
2094:                     .Height  = 40
2095:                 ENDWITH
2096:             ENDWITH
2097: 
2098:             WITH .Column8
2099:                 .Header1.Caption = "Fonte"
2100:                 .ControlSource   = "cursor_4c_PropsCampos.LblFonte"
2101:                 .Width           = 190
2102:                 .Sparse          = .F.
2103:                 .AddObject("Edit1", "EditBox")
2104:                 .CurrentControl  = "Edit1"
2105:                 WITH .Edit1
2106:                     .Visible = .T.
2107:                     .Width   = 188
2108:                     .Height  = 40
2109:                 ENDWITH
2110:             ENDWITH
2111: 
2112:             WITH .Column9
2113:                 .Header1.Caption = "Fte"
2114:                 .ControlSource   = "cursor_4c_PropsCampos.LblBtFonte"
2115:                 .Width           = 50
2116:                 .Sparse          = .F.
2117:                 .AddObject("Command1", "CommandButton")
2118:                 .CurrentControl  = "Command1"
2119:                 WITH .Command1
2120:                     .Caption = "..."
2121:                     .Visible = .T.
2122:                     .Width   = 46
2123:                     .Height  = 18
2124:                 ENDWITH
2125:             ENDWITH
2126: 
2127:             WITH .Column10
2128:                 .Header1.Caption = "Cor"
2129:                 .ControlSource   = "cursor_4c_PropsCampos.LblBtCor"
2130:                 .Width           = 50
2131:                 .Sparse          = .F.
2132:                 .AddObject("Command1", "CommandButton")
2133:                 .CurrentControl  = "Command1"
2134:                 WITH .Command1
2135:                     .Caption = "..."
2136:                     .Visible = .T.
2137:                     .Width   = 46
2138:                     .Height  = 18
2139:                 ENDWITH
2140:             ENDWITH
2141: 
2142:             WITH .Column11
2143:                 .Header1.Caption = "Alinhar"
2144:                 .ControlSource   = "cursor_4c_PropsCampos.LblAlinhar"
2145:                 .Width           = 80
2146:                 .Sparse          = .F.
2147:                 .AddObject("Combo1", "ComboBox")
2148:                 .CurrentControl  = "Combo1"
2149:                 WITH .Combo1
2150:                     .RowSourceType = 1
2151:                     .RowSource     = "Left,Center,Right"
2152:                     .Style         = 2
2153:                     .Visible       = .T.
2154:                     .Width         = 77
2155:                     .Height        = 21
2156:                 ENDWITH
2157:             ENDWITH
2158: 
2159:             WITH .Column12
2160:                 .Header1.Caption = "Tam."
2161:                 .ControlSource   = "cursor_4c_PropsCampos.LblTamCmp"
2162:                 .Width           = 70
2163:                 .Sparse          = .F.
2164:                 .AddObject("Spinner1", "Spinner")
2165:                 .CurrentControl  = "Spinner1"
2166:                 WITH .Spinner1
2167:                     .SpinnerLowValue  = 0
2168:                     .SpinnerHighValue = 9999
2169:                     .Increment        = 1
2170:                     .Visible          = .T.
2171:                     .Width            = 66
2172:                     .Height           = 21
2173:                 ENDWITH
2174:             ENDWITH
2175:         ENDWITH
2176: 
2177:         *-- DynamicBackColor: cinza escuro para SubTot/Total em campos nao-numericos
2178:         loc_oSubPg2.grd_4c_PropsCampos.Column5.DynamicBackColor = ;
2179:             "IIF(InList(cursor_4c_PropsCampos.LblTipoCmp,'N','U'),RGB(239,239,239),RGB(209,209,209))"
2180:         loc_oSubPg2.grd_4c_PropsCampos.Column6.DynamicBackColor = ;
2181:             "IIF(InList(cursor_4c_PropsCampos.LblTipoCmp,'N','U'),RGB(239,239,239),RGB(209,209,209))"
2182: 
2183:         *-- Grid: Propriedades do Grupo (grd_4c_PropsGrp)
2184:         loc_oSubPg2.AddObject("grd_4c_PropsGrp", "Grid")
2185:         loc_oSubPg2.grd_4c_PropsGrp.ColumnCount      = 7
2186:         loc_oSubPg2.grd_4c_PropsGrp.RecordSourceType  = 1
2187:         loc_oSubPg2.grd_4c_PropsGrp.ColumnCount = 3
2188:         loc_oSubPg2.grd_4c_PropsGrp.RecordSource      = "cursor_4c_PropsGrp"
2189:         WITH loc_oSubPg2.grd_4c_PropsGrp
2190:             .Top          = 558
2191:             .Left         = 4
2192:             .Width        = 989
2193:             .Height       = 67
2194:             .GridLines    = 1
2195:             .HeaderHeight = 18
2196:             .RowHeight    = 20
2197:             .ReadOnly     = .F.
2198:             .Visible      = .T.
2199:             .DeleteMark   = .F.
2200:             .RecordMark   = .F.
2201:             .ScrollBars   = 2
2202: 
2203:             WITH .Column1
2204:                 .Header1.Caption = "Grupo"
2205:                 .ControlSource   = "cursor_4c_PropsGrp.NmCampo"
2206:                 .Width           = 180
2207:                 .Sparse          = .F.
2208:                 .AddObject("Combo1", "ComboBox")
2209:                 .CurrentControl  = "Combo1"
2210:                 WITH .Combo1
2211:                     .RowSourceType = 2
2212:                     .RowSource     = "cursor_4c_LstCampos.NmCampo"
2213:                     .BoundColumn   = 1
2214:                     .Style         = 0
2215:                     .Visible       = .T.
2216:                     .Width         = 177
2217:                     .Height        = 21
2218:                 ENDWITH
2219:             ENDWITH
2220: 
2221:             WITH .Column2
2222:                 .Header1.Caption = "Titulo do Campo"
2223:                 .ControlSource   = "cursor_4c_PropsGrp.LblCaption"
2224:                 .Width           = 180
2225:                 .Sparse          = .F.
2226:                 .AddObject("Edit1", "EditBox")
2227:                 .CurrentControl  = "Edit1"
2228:                 WITH .Edit1
2229:                     .Visible = .T.
2230:                     .Width   = 178
2231:                     .Height  = 40
2232:                 ENDWITH
2233:             ENDWITH
2234: 
2235:             WITH .Column3
2236:                 .Header1.Caption = "Fonte"
2237:                 .ControlSource   = "cursor_4c_PropsGrp.LblFonte"
2238:                 .Width           = 200
2239:                 .Sparse          = .F.
2240:                 .AddObject("Edit1", "EditBox")
2241:                 .CurrentControl  = "Edit1"
2242:                 WITH .Edit1
2243:                     .Visible = .T.
2244:                     .Width   = 198
2245:                     .Height  = 40
2246:                 ENDWITH
2247:             ENDWITH
2248: 
2249:             WITH .Column4
2250:                 .Header1.Caption = "Fte"
2251:                 .ControlSource   = "cursor_4c_PropsGrp.LblBtFonte"
2252:                 .Width           = 80
2253:                 .Sparse          = .F.
2254:                 .AddObject("Command1", "CommandButton")
2255:                 .CurrentControl  = "Command1"
2256:                 WITH .Command1
2257:                     .Caption = "..."
2258:                     .Visible = .T.
2259:                     .Width   = 76
2260:                     .Height  = 18
2261:                 ENDWITH
2262:             ENDWITH
2263: 
2264:             WITH .Column5
2265:                 .Header1.Caption = "Cor"
2266:                 .ControlSource   = "cursor_4c_PropsGrp.LblBtCor"
2267:                 .Width           = 80
2268:                 .Sparse          = .F.
2269:                 .AddObject("Command1", "CommandButton")
2270:                 .CurrentControl  = "Command1"
2271:                 WITH .Command1
2272:                     .Caption = "..."
2273:                     .Visible = .T.
2274:                     .Width   = 76
2275:                     .Height  = 18
2276:                 ENDWITH
2277:             ENDWITH
2278: 
2279:             WITH .Column6
2280:                 .Header1.Caption = "Alinhar"
2281:                 .ControlSource   = "cursor_4c_PropsGrp.LblAlinhar"
2282:                 .Width           = 100
2283:                 .Sparse          = .F.
2284:                 .AddObject("Combo1", "ComboBox")
2285:                 .CurrentControl  = "Combo1"
2286:                 WITH .Combo1
2287:                     .RowSourceType = 1
2288:                     .RowSource     = "Left,Center,Right"
2289:                     .Style         = 2
2290:                     .Visible       = .T.
2291:                     .Width         = 97
2292:                     .Height        = 21
2293:                 ENDWITH
2294:             ENDWITH
2295: 
2296:             WITH .Column7
2297:                 .Header1.Caption = "Tam."
2298:                 .ControlSource   = "cursor_4c_PropsGrp.LblTamCmp"
2299:                 .Width           = 169
2300:                 .Sparse          = .F.
2301:                 .AddObject("Spinner1", "Spinner")
2302:                 .CurrentControl  = "Spinner1"
2303:                 WITH .Spinner1
2304:                     .SpinnerLowValue  = 0
2305:                     .SpinnerHighValue = 9999
2306:                     .Increment        = 1
2307:                     .Visible          = .T.
2308:                     .Width            = 165
2309:                     .Height           = 21
2310:                 ENDWITH
2311:             ENDWITH
2312:         ENDWITH
2313: 
2314:         *-- BINDEVENTs (handlers devem ser PUBLIC)
2315:         LOCAL loc_oGrdTIT, loc_oGrdCMPs, loc_oGrdGRP
2316:         loc_oGrdTIT  = loc_oSubPg2.grd_4c_PropsTitulo
2317:         loc_oGrdCMPs = loc_oSubPg2.grd_4c_PropsCampos
2318:         loc_oGrdGRP  = loc_oSubPg2.grd_4c_PropsGrp
2319: 
2320:         BINDEVENT(loc_oSubPg2.cnt_4c_BotoesLayout.cmd_4c_VoltarLayout, "Click", THIS, "BtnVoltarLayoutClick")
2321:         BINDEVENT(loc_oSubPg2.cnt_4c_BotoesLayout.cmd_4c_GerarLayout,  "Click", THIS, "BtnGerarLayoutClick")
2322:         BINDEVENT(loc_oSubPg2.opt_4c_Orientacao, "InteractiveChange",   THIS, "OrientacaoChanged")
2323:         BINDEVENT(loc_oGrdTIT.Column3.Command1,   "Click",              THIS, "BtnFonteTITClick")
2324:         BINDEVENT(loc_oGrdTIT.Column4.Command1,   "Click",              THIS, "BtnCorTITClick")
2325:         BINDEVENT(loc_oGrdCMPs.Column5.Check1,    "When",               THIS, "ChkSubTotalWhen")
2326:         BINDEVENT(loc_oGrdCMPs.Column6.Check1,    "When",               THIS, "ChkTotalFinalWhen")
2327:         BINDEVENT(loc_oGrdCMPs.Column7.Edit1,     "KeyPress",          THIS, "EdtCaptionCMPsLostFocus")
2328:         BINDEVENT(loc_oGrdCMPs.Column9.Command1,  "Click",              THIS, "BtnFonteCMPsClick")
2329:         BINDEVENT(loc_oGrdCMPs.Column10.Command1, "Click",              THIS, "BtnCorCMPsClick")
2330:         BINDEVENT(loc_oGrdGRP.Column1.Combo1,     "InteractiveChange",  THIS, "ComboNmCampoGRPInteractiveChange")
2331:         BINDEVENT(loc_oGrdGRP.Column4.Command1,   "Click",              THIS, "BtnFonteGRPClick")
2332:         BINDEVENT(loc_oGrdGRP.Column5.Command1,   "Click",              THIS, "BtnCorGRPClick")
2333:     ENDPROC

*-- Linhas 2373 a 2407:
2373:         loc_cFonteNova = GETFONT(loc_cFontName, loc_nFontSize, loc_cFontStyle)
2374:         IF !EMPTY(loc_cFonteNova)
2375:             REPLACE LblFonte WITH loc_cFonteNova
2376:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsTitulo.Refresh()
2377:         ENDIF
2378:     ENDPROC
2379: 
2380:     *==========================================================================
2381:     * BtnCorTITClick - Seleciona cor do texto para o Titulo do Relatorio
2382:     *==========================================================================
2383:     PROCEDURE BtnCorTITClick()
2384:         LOCAL loc_nCor
2385:         IF !USED("cursor_4c_PropsTitulo")
2386:             RETURN
2387:         ENDIF
2388:         loc_nCor = GETCOLOR()
2389:         IF loc_nCor >= 0
2390:             SELECT cursor_4c_PropsTitulo
2391:             REPLACE LblBtCor WITH loc_nCor
2392:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsTitulo.Refresh()
2393:         ENDIF
2394:     ENDPROC
2395: 
2396:     *==========================================================================
2397:     * ChkSubTotalWhen - Valida se o campo suporta subtotal (somente numericos)
2398:     *==========================================================================
2399:     PROCEDURE ChkSubTotalWhen()
2400:         LOCAL loc_lPermite
2401:         loc_lPermite = .F.
2402:         IF USED("cursor_4c_PropsCampos") AND !EOF("cursor_4c_PropsCampos")
2403:             loc_lPermite = (cursor_4c_PropsCampos.LblTipoCmp $ "NU")
2404:         ENDIF
2405:         RETURN loc_lPermite
2406:     ENDPROC
2407: 

*-- Linhas 2434 a 2487:
2434:         IF loc_nTam > 0
2435:             SELECT cursor_4c_PropsCampos
2436:             REPLACE LblTamCmp WITH loc_nTam
2437:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsCampos.Refresh()
2438:         ENDIF
2439:     ENDPROC
2440: 
2441:     *==========================================================================
2442:     * BtnFonteCMPsClick - Seleciona fonte para coluna de Campos
2443:     *==========================================================================
2444:     PROCEDURE BtnFonteCMPsClick()
2445:         LOCAL loc_cFonteAtual, loc_cFontName, loc_nFontSize, loc_cFontStyle, loc_nFontStyle
2446:         LOCAL loc_cFonteNova
2447:         IF !USED("cursor_4c_PropsCampos") OR EOF("cursor_4c_PropsCampos")
2448:             RETURN
2449:         ENDIF
2450:         SELECT cursor_4c_PropsCampos
2451:         loc_cFonteAtual = ALLTRIM(NVL(cursor_4c_PropsCampos.LblFonte, "Tahoma,8,N"))
2452:         THIS.DetalharFonte(loc_cFonteAtual, @loc_cFontName, @loc_nFontSize, @loc_cFontStyle, @loc_nFontStyle)
2453:         loc_cFonteNova = GETFONT(loc_cFontName, loc_nFontSize, loc_cFontStyle)
2454:         IF !EMPTY(loc_cFonteNova)
2455:             REPLACE LblFonte WITH loc_cFonteNova
2456:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsCampos.Refresh()
2457:         ENDIF
2458:     ENDPROC
2459: 
2460:     *==========================================================================
2461:     * BtnCorCMPsClick - Seleciona cor do texto para coluna de Campos
2462:     *==========================================================================
2463:     PROCEDURE BtnCorCMPsClick()
2464:         LOCAL loc_nCor
2465:         IF !USED("cursor_4c_PropsCampos") OR EOF("cursor_4c_PropsCampos")
2466:             RETURN
2467:         ENDIF
2468:         loc_nCor = GETCOLOR()
2469:         IF loc_nCor >= 0
2470:             SELECT cursor_4c_PropsCampos
2471:             REPLACE LblBtCor WITH loc_nCor
2472:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsCampos.Refresh()
2473:         ENDIF
2474:     ENDPROC
2475: 
2476:     *==========================================================================
2477:     * ComboNmCampoGRPInteractiveChange - Atualiza LblTam ao selecionar campo do grupo
2478:     *==========================================================================
2479:     PROCEDURE ComboNmCampoGRPInteractiveChange()
2480:         LOCAL loc_cNmCampo, loc_cTpCampo, loc_cFonte, loc_nTam
2481:         IF !USED("cursor_4c_PropsGrp") OR EOF("cursor_4c_PropsGrp")
2482:             RETURN
2483:         ENDIF
2484:         loc_cNmCampo = ALLTRIM(NVL(cursor_4c_PropsGrp.NmCampo, ""))
2485:         IF EMPTY(loc_cNmCampo) OR !USED("cursor_4c_LstCampos")
2486:             RETURN
2487:         ENDIF

*-- Linhas 2494 a 2549:
2494:             loc_nTam   = THIS.Calc_TamCampo(loc_cTpCampo, loc_cFonte)
2495:             IF loc_nTam > 0
2496:                 REPLACE LblTamCmp WITH loc_nTam
2497:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsGrp.Refresh()
2498:             ENDIF
2499:         ENDIF
2500:         SELECT cursor_4c_PropsGrp
2501:     ENDPROC
2502: 
2503:     *==========================================================================
2504:     * BtnFonteGRPClick - Seleciona fonte para coluna do Grupo
2505:     *==========================================================================
2506:     PROCEDURE BtnFonteGRPClick()
2507:         LOCAL loc_cFonteAtual, loc_cFontName, loc_nFontSize, loc_cFontStyle, loc_nFontStyle
2508:         LOCAL loc_cFonteNova
2509:         IF !USED("cursor_4c_PropsGrp") OR EOF("cursor_4c_PropsGrp")
2510:             RETURN
2511:         ENDIF
2512:         SELECT cursor_4c_PropsGrp
2513:         loc_cFonteAtual = ALLTRIM(NVL(cursor_4c_PropsGrp.LblFonte, "Tahoma,8,N"))
2514:         THIS.DetalharFonte(loc_cFonteAtual, @loc_cFontName, @loc_nFontSize, @loc_cFontStyle, @loc_nFontStyle)
2515:         loc_cFonteNova = GETFONT(loc_cFontName, loc_nFontSize, loc_cFontStyle)
2516:         IF !EMPTY(loc_cFonteNova)
2517:             REPLACE LblFonte WITH loc_cFonteNova
2518:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsGrp.Refresh()
2519:         ENDIF
2520:     ENDPROC
2521: 
2522:     *==========================================================================
2523:     * BtnCorGRPClick - Seleciona cor do texto para coluna do Grupo
2524:     *==========================================================================
2525:     PROCEDURE BtnCorGRPClick()
2526:         LOCAL loc_nCor
2527:         IF !USED("cursor_4c_PropsGrp") OR EOF("cursor_4c_PropsGrp")
2528:             RETURN
2529:         ENDIF
2530:         loc_nCor = GETCOLOR()
2531:         IF loc_nCor >= 0
2532:             SELECT cursor_4c_PropsGrp
2533:             REPLACE LblBtCor WITH loc_nCor
2534:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_PropsGrp.Refresh()
2535:         ENDIF
2536:     ENDPROC
2537: 
2538:     *==========================================================================
2539:     * Calc_TamCampo - Calcula largura em pixels baseado no tipo e fonte do campo
2540:     * par_cTpCampo: ex "varchar(50)", par_cFonte: "FontName,Size,Style"
2541:     *==========================================================================
2542:     PROCEDURE Calc_TamCampo(par_cTpCampo, par_cFonte)
2543:         LOCAL loc_lcTipo, loc_cTpWrk, loc_nFieldWidth, loc_nTam
2544:         LOCAL loc_cFontName, loc_nFontSize, loc_cFontStyle, loc_nFontStyle
2545:         LOCAL loc_nFontWidth
2546: 
2547:         loc_lcTipo      = UPPER(LEFT(ALLTRIM(par_cTpCampo), 1))
2548:         loc_cTpWrk      = STRTRAN(STRTRAN(STRTRAN(par_cTpCampo, loc_lcTipo, ""), "(", ""), ")", "")
2549:         loc_nFieldWidth = INT(VAL(ALLTRIM(loc_cTpWrk)))

