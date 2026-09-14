# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (3)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 798: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 913: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1028: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreato.prg) - TRECHOS RELEVANTES PARA PASS GRID (2030 linhas total):

*-- Linhas 13 a 33:
13: *   - optImagem (1=Com Imagem, 2=Sem Imagem)
14: *   - optTipos  (1=Analitico, 2=Sintetico)
15: *   - optDiferencas (1=Ignorar, 2=Sem Diferenca, 3=Positiva, 4=Negativa)
16: *   - grd_4c_OperacoesE + cmd_4c_BtnGradeE (tipos de entrada)
17: *   - grd_4c_OperacoesS + cmd_4c_BtnGradeS (tipos de saida)
18: *   - grd_4c_SigCdCeg   + cmd_4c_BtnCeg   (contas de estoque)
19: *==============================================================================
20: 
21: DEFINE CLASS FormSigreato AS FormBase
22: 
23:     *-- Dimensoes EXATAS baseadas no original SIGREATO.SCX
24:     Height      = 510
25:     Width       = 800
26:     DataSession = 2
27:     ShowWindow  = 1
28:     WindowType  = 1
29:     AutoCenter  = .T.
30:     BorderStyle = 2
31:     ControlBox  = .F.
32:     Closable    = .F.
33:     MaxButton   = .F.

*-- Linhas 761 a 824:
761: 
762:     *--------------------------------------------------------------------------
763:     * ConfigurarGrades - Cria as 3 grades com botoes de marca/desmarca:
764:     *   grd_4c_OperacoesE + cmd_4c_BtnGradeE (tipos de entrada)
765:     *   grd_4c_OperacoesS + cmd_4c_BtnGradeS (tipos de saida)
766:     *   grd_4c_SigCdCeg   + cmd_4c_BtnCeg   (contas de estoque)
767:     *--------------------------------------------------------------------------
768:     PROTECTED PROCEDURE ConfigurarGrades()
769:         LOCAL loc_oCnt, loc_oGrd
770:         loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
771: 
772:         *-- Garantir cursores placeholder se InicializarDados foi pulado ----
773:         IF !USED("cursor_4c_OperacoesE")
774:             CREATE CURSOR cursor_4c_OperacoesE (SelImp L(1), Codigos N(2,0), Descrs C(30))
775:         ENDIF
776:         IF !USED("cursor_4c_OperacoesS")
777:             CREATE CURSOR cursor_4c_OperacoesS (SelImp L(1), Codigos N(2,0), Descrs C(30))
778:         ENDIF
779:         IF !USED("cursor_4c_SigCdCeg")
780:             CREATE CURSOR cursor_4c_SigCdCeg (lMarca L(1), Grupos C(10), Contas C(10))
781:         ENDIF
782: 
783:         *====================================================================
784:         * Grade de Operacoes de Entrada
785:         *====================================================================
786:         loc_oCnt.AddObject("grd_4c_OperacoesE", "Grid")
787:         WITH loc_oCnt.grd_4c_OperacoesE
788:             .ColumnCount       = 3
789:             .AllowHeaderSizing = .F.
790:             .AllowRowSizing    = .F.
791:             .DeleteMark        = .F.
792:             .GridLines         = 3
793:             .HeaderHeight      = 16
794:             .Height            = 99
795:             .Left              = 46
796:             .Panel             = 1
797:             .RecordMark        = .F.
798:             .RecordSource      = "cursor_4c_OperacoesE"
799:             .RowHeight         = 16
800:             .ScrollBars        = 2
801:             .TabStop           = .F.
802:             .Top               = 163
803:             .Width             = 275
804:             .GridLineColor     = RGB(238, 238, 238)
805:             .FontName          = "Tahoma"
806:             .FontSize          = 8
807:             .Visible           = .T.
808:         ENDWITH
809:         loc_oGrd = loc_oCnt.grd_4c_OperacoesE
810: 
811:         WITH loc_oGrd.Column1
812:             .Width         = 15
813:             .Sparse        = .F.
814:             .Alignment     = 0
815:             .Enabled       = .T.
816:             .ReadOnly      = .F.
817:             .Movable       = .F.
818:             .Resizable     = .F.
819:             .FontName      = "Tahoma"
820:             .FontSize      = 8
821:         ENDWITH
822:         loc_oGrd.Column1.AddObject("chk_4c_Marca", "CheckBox")
823:         WITH loc_oGrd.Column1.chk_4c_Marca
824:             .Caption   = ""

*-- Linhas 839 a 872:
839:             .FontName      = "Courier New"
840:             .FontSize      = 8
841:         ENDWITH
842:         loc_oGrd.Column2.Header1.Caption  = ""
843:         loc_oGrd.Column2.Header1.ForeColor = RGB(90, 90, 90)
844: 
845:         WITH loc_oGrd.Column3
846:             .Width         = 208
847:             .ControlSource = "cursor_4c_OperacoesE.Descrs"
848:             .ReadOnly      = .T.
849:             .Enabled       = .T.
850:             .Movable       = .F.
851:             .Resizable     = .F.
852:             .FontName      = "Courier New"
853:             .FontSize      = 8
854:         ENDWITH
855:         loc_oGrd.Column3.Header1.Caption   = "Opera" + CHR(231) + CHR(245) + "es de Entrada"
856:         loc_oGrd.Column3.Header1.ForeColor  = RGB(90, 90, 90)
857:         loc_oGrd.Column3.Header1.Alignment  = 2
858: 
859:         *-- Botoes Marca/Desmarca para Entradas ----------------------------
860:         loc_oCnt.AddObject("cmd_4c_BtnGradeE", "CommandGroup")
861:         WITH loc_oCnt.cmd_4c_BtnGradeE
862:             .AutoSize    = .T.
863:             .ButtonCount = 2
864:             .BackStyle   = 0
865:             .BorderStyle = 0
866:             .Value       = 1
867:             .Height      = 90
868:             .Left        = 321
869:             .Top         = 168
870:             .Width       = 50
871:             .Visible     = .T.
872:         ENDWITH

*-- Linhas 898 a 939:
898:         *====================================================================
899:         * Grade de Operacoes de Saida
900:         *====================================================================
901:         loc_oCnt.AddObject("grd_4c_OperacoesS", "Grid")
902:         WITH loc_oCnt.grd_4c_OperacoesS
903:             .ColumnCount       = 3
904:             .AllowHeaderSizing = .F.
905:             .AllowRowSizing    = .F.
906:             .DeleteMark        = .F.
907:             .GridLines         = 3
908:             .HeaderHeight      = 16
909:             .Height            = 99
910:             .Left              = 46
911:             .Panel             = 1
912:             .RecordMark        = .F.
913:             .RecordSource      = "cursor_4c_OperacoesS"
914:             .RowHeight         = 16
915:             .ScrollBars        = 2
916:             .TabStop           = .F.
917:             .Top               = 276
918:             .Width             = 275
919:             .GridLineColor     = RGB(238, 238, 238)
920:             .FontName          = "Tahoma"
921:             .FontSize          = 8
922:             .Visible           = .T.
923:         ENDWITH
924:         loc_oGrd = loc_oCnt.grd_4c_OperacoesS
925: 
926:         WITH loc_oGrd.Column1
927:             .Width         = 15
928:             .Sparse        = .F.
929:             .Alignment     = 0
930:             .Enabled       = .T.
931:             .ReadOnly      = .F.
932:             .Movable       = .F.
933:             .Resizable     = .F.
934:             .FontName      = "Tahoma"
935:             .FontSize      = 8
936:         ENDWITH
937:         loc_oGrd.Column1.AddObject("chk_4c_marca2", "CheckBox")
938:         WITH loc_oGrd.Column1.chk_4c_marca2
939:             .Caption   = ""

*-- Linhas 954 a 987:
954:             .FontName      = "Courier New"
955:             .FontSize      = 8
956:         ENDWITH
957:         loc_oGrd.Column2.Header1.Caption  = ""
958:         loc_oGrd.Column2.Header1.ForeColor = RGB(90, 90, 90)
959: 
960:         WITH loc_oGrd.Column3
961:             .Width         = 208
962:             .ControlSource = "cursor_4c_OperacoesS.Descrs"
963:             .ReadOnly      = .T.
964:             .Enabled       = .T.
965:             .Movable       = .F.
966:             .Resizable     = .F.
967:             .FontName      = "Courier New"
968:             .FontSize      = 8
969:         ENDWITH
970:         loc_oGrd.Column3.Header1.Caption   = "Opera" + CHR(231) + CHR(245) + "es de Sa" + CHR(237) + "da"
971:         loc_oGrd.Column3.Header1.ForeColor  = RGB(90, 90, 90)
972:         loc_oGrd.Column3.Header1.Alignment  = 2
973: 
974:         *-- Botoes Marca/Desmarca para Saidas ------------------------------
975:         loc_oCnt.AddObject("cmd_4c_BtnGradeS", "CommandGroup")
976:         WITH loc_oCnt.cmd_4c_BtnGradeS
977:             .AutoSize    = .T.
978:             .ButtonCount = 2
979:             .BackStyle   = 0
980:             .BorderStyle = 0
981:             .Value       = 1
982:             .Height      = 90
983:             .Left        = 321
984:             .Top         = 282
985:             .Width       = 50
986:             .Visible     = .T.
987:         ENDWITH

*-- Linhas 1013 a 1054:
1013:         *====================================================================
1014:         * Grade de Contas de Estoque (SigCdCeg)
1015:         *====================================================================
1016:         loc_oCnt.AddObject("grd_4c_SigCdCeg", "Grid")
1017:         WITH loc_oCnt.grd_4c_SigCdCeg
1018:             .ColumnCount       = 3
1019:             .AllowHeaderSizing = .F.
1020:             .AllowRowSizing    = .F.
1021:             .DeleteMark        = .F.
1022:             .GridLines         = 3
1023:             .HeaderHeight      = 16
1024:             .Height            = 211
1025:             .Left              = 421
1026:             .Panel             = 1
1027:             .RecordMark        = .F.
1028:             .RecordSource      = "cursor_4c_SigCdCeg"
1029:             .RowHeight         = 16
1030:             .ScrollBars        = 2
1031:             .TabStop           = .F.
1032:             .Top               = 163
1033:             .Width             = 207
1034:             .GridLineColor     = RGB(238, 238, 238)
1035:             .FontName          = "Tahoma"
1036:             .FontSize          = 8
1037:             .Visible           = .T.
1038:         ENDWITH
1039:         loc_oGrd = loc_oCnt.grd_4c_SigCdCeg
1040: 
1041:         WITH loc_oGrd.Column1
1042:             .Width         = 15
1043:             .Sparse        = .F.
1044:             .Alignment     = 0
1045:             .Enabled       = .T.
1046:             .ReadOnly      = .F.
1047:             .Movable       = .F.
1048:             .Resizable     = .F.
1049:             .FontName      = "Tahoma"
1050:             .FontSize      = 8
1051:         ENDWITH
1052:         loc_oGrd.Column1.AddObject("chk_4c_marca3", "CheckBox")
1053:         WITH loc_oGrd.Column1.chk_4c_marca3
1054:             .Caption   = ""

*-- Linhas 1069 a 1101:
1069:             .FontName      = "Courier New"
1070:             .FontSize      = 8
1071:         ENDWITH
1072:         loc_oGrd.Column2.Header1.Caption  = "Grupo"
1073:         loc_oGrd.Column2.Header1.ForeColor = RGB(90, 90, 90)
1074: 
1075:         WITH loc_oGrd.Column3
1076:             .Width         = 80
1077:             .ControlSource = "cursor_4c_SigCdCeg.Contas"
1078:             .ReadOnly      = .T.
1079:             .Enabled       = .T.
1080:             .Movable       = .F.
1081:             .Resizable     = .F.
1082:             .FontName      = "Courier New"
1083:             .FontSize      = 8
1084:         ENDWITH
1085:         loc_oGrd.Column3.Header1.Caption  = "Conta"
1086:         loc_oGrd.Column3.Header1.ForeColor = RGB(90, 90, 90)
1087: 
1088:         *-- Botoes Marca/Desmarca para SigCdCeg ----------------------------
1089:         loc_oCnt.AddObject("cmd_4c_BtnCeg", "CommandGroup")
1090:         WITH loc_oCnt.cmd_4c_BtnCeg
1091:             .AutoSize    = .T.
1092:             .ButtonCount = 2
1093:             .BackStyle   = 0
1094:             .BorderStyle = 0
1095:             .Value       = 1
1096:             .Height      = 90
1097:             .Left        = 632
1098:             .Top         = 225
1099:             .Width       = 50
1100:             .Visible     = .T.
1101:         ENDWITH

*-- Linhas 1324 a 1358:
1324:             IF RECCOUNT("cursor_4c_TmpE") < 1
1325:                 MsgAviso("Nenhum Tipo de Opera" + CHR(231) + CHR(227) + "o de Entrada Foi Selecionado!!!", ;
1326:                     "Aten" + CHR(231) + CHR(227) + "o")
1327:                 IF VARTYPE(loc_oCnt.grd_4c_OperacoesE) = "O"
1328:                     loc_oCnt.grd_4c_OperacoesE.Column1.SetFocus()
1329:                 ENDIF
1330:                 IF USED("cursor_4c_TmpE")
1331:                     USE IN cursor_4c_TmpE
1332:                 ENDIF
1333:                 RETURN .F.
1334:             ENDIF
1335:         ENDIF
1336: 
1337:         IF USED("cursor_4c_OperacoesS")
1338:             SELECT Codigos FROM cursor_4c_OperacoesS WHERE SelImp INTO CURSOR cursor_4c_TmpS READWRITE
1339:             IF RECCOUNT("cursor_4c_TmpS") < 1
1340:                 MsgAviso("Nenhum Tipo de Opera" + CHR(231) + CHR(227) + "o de Sa" + CHR(237) + "da Foi Selecionado!!!", ;
1341:                     "Aten" + CHR(231) + CHR(227) + "o")
1342:                 IF VARTYPE(loc_oCnt.grd_4c_OperacoesS) = "O"
1343:                     loc_oCnt.grd_4c_OperacoesS.Column1.SetFocus()
1344:                 ENDIF
1345:                 IF USED("cursor_4c_TmpE")
1346:                     USE IN cursor_4c_TmpE
1347:                 ENDIF
1348:                 IF USED("cursor_4c_TmpS")
1349:                     USE IN cursor_4c_TmpS
1350:                 ENDIF
1351:                 RETURN .F.
1352:             ENDIF
1353:         ENDIF
1354: 
1355:         *-- Verificar intersecao E/S
1356:         IF USED("cursor_4c_TmpE") AND USED("cursor_4c_TmpS")
1357:             SELECT cursor_4c_TmpE.Codigos FROM cursor_4c_TmpE ;
1358:                 WHERE cursor_4c_TmpE.Codigos IN ;

*-- Linhas 1625 a 1679:
1625:             REPLACE ALL SelImp WITH .F.
1626:             GO TOP
1627:         ENDIF
1628:         loc_oCnt.grd_4c_OperacoesE.Refresh()
1629:     ENDPROC
1630: 
1631:     PROCEDURE CmdGradeSClick()
1632:         LOCAL loc_oCnt
1633:         loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
1634:         IF !USED("cursor_4c_OperacoesS")
1635:             RETURN
1636:         ENDIF
1637:         IF loc_oCnt.cmd_4c_BtnGradeS.Value = 1
1638:             SELECT cursor_4c_OperacoesS
1639:             REPLACE ALL SelImp WITH .T.
1640:             GO TOP
1641:         ELSE
1642:             SELECT cursor_4c_OperacoesS
1643:             REPLACE ALL SelImp WITH .F.
1644:             GO TOP
1645:         ENDIF
1646:         loc_oCnt.grd_4c_OperacoesS.Refresh()
1647:     ENDPROC
1648: 
1649:     PROCEDURE CmdCegClick()
1650:         LOCAL loc_oCnt
1651:         loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
1652:         IF !USED("cursor_4c_SigCdCeg")
1653:             RETURN
1654:         ENDIF
1655:         IF loc_oCnt.cmd_4c_BtnCeg.Value = 1
1656:             SELECT cursor_4c_SigCdCeg
1657:             REPLACE ALL lMarca WITH .T.
1658:             GO TOP
1659:         ELSE
1660:             SELECT cursor_4c_SigCdCeg
1661:             REPLACE ALL lMarca WITH .F.
1662:             GO TOP
1663:         ENDIF
1664:         loc_oCnt.grd_4c_SigCdCeg.Refresh()
1665:     ENDPROC
1666: 
1667:     *==========================================================================
1668:     * Lookups com FormBuscaAuxiliar
1669:     *==========================================================================
1670: 
1671:     *--------------------------------------------------------------------------
1672:     * AbrirBuscaGrupo - SigCdGrp (CGrus/DGrus)
1673:     *--------------------------------------------------------------------------
1674:     PROCEDURE AbrirBuscaGrupo()
1675:         LOCAL loc_oCnt, loc_cValor, loc_oForm
1676:         loc_oCnt  = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
1677:         loc_cValor = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)
1678:         IF EMPTY(loc_cValor)
1679:             loc_cValor = ALLTRIM(loc_oCnt.txt_4c_DGrupo.Value)

*-- Linhas 1687 a 1706:
1687:             RETURN
1688:         ENDIF
1689: 
1690:         loc_oForm.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
1691:         loc_oForm.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
1692:         loc_oForm.Show()
1693: 
1694:         IF loc_oForm.this_lSelecionou
1695:             IF USED("cursor_4c_GrupoBusca")
1696:                 SELECT cursor_4c_GrupoBusca
1697:                 IF !EOF()
1698:                     loc_oCnt.txt_4c_Grupo.Value  = ALLTRIM(CGrus)
1699:                     loc_oCnt.txt_4c_DGrupo.Value = ALLTRIM(DGrus)
1700:                 ENDIF
1701:             ENDIF
1702:         ELSE
1703:             loc_oCnt.txt_4c_Grupo.Value  = ""
1704:             loc_oCnt.txt_4c_DGrupo.Value = ""
1705:         ENDIF
1706: 

*-- Linhas 1754 a 1773:
1754:             RETURN
1755:         ENDIF
1756: 
1757:         loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
1758:         loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
1759:         loc_oForm.Show()
1760: 
1761:         IF loc_oForm.this_lSelecionou
1762:             IF USED("cursor_4c_ProdBusca")
1763:                 SELECT cursor_4c_ProdBusca
1764:                 IF !EOF()
1765:                     loc_oCnt.txt_4c_CPros.Value   = ALLTRIM(CPros)
1766:                     loc_oCnt.txt_4c_DPros.Value   = ALLTRIM(DPros)
1767:                 ENDIF
1768:             ENDIF
1769:         ELSE
1770:             loc_oCnt.txt_4c_CPros.Value = ""
1771:             loc_oCnt.txt_4c_DPros.Value = ""
1772:         ENDIF
1773: 

*-- Linhas 1821 a 1840:
1821:             RETURN
1822:         ENDIF
1823: 
1824:         loc_oForm.mAddColuna("Linhas", "", "C" + CHR(243) + "digo")
1825:         loc_oForm.mAddColuna("Descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1826:         loc_oForm.Show()
1827: 
1828:         IF loc_oForm.this_lSelecionou
1829:             IF USED("cursor_4c_LinBusca")
1830:                 SELECT cursor_4c_LinBusca
1831:                 IF !EOF()
1832:                     loc_oCnt.txt_4c_Linha.Value = ALLTRIM(Linhas)
1833:                     loc_oCnt.txt_4c_DLin.Value  = ALLTRIM(Descs)
1834:                 ENDIF
1835:             ENDIF
1836:         ELSE
1837:             loc_oCnt.txt_4c_Linha.Value = ""
1838:             loc_oCnt.txt_4c_DLin.Value  = ""
1839:         ENDIF
1840: 

*-- Linhas 1888 a 1907:
1888:             RETURN
1889:         ENDIF
1890: 
1891:         loc_oForm.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1892:         loc_oForm.mAddColuna("nomes", "", "Nome")
1893:         loc_oForm.Show()
1894: 
1895:         IF loc_oForm.this_lSelecionou
1896:             IF USED("cursor_4c_FornBusca")
1897:                 SELECT cursor_4c_FornBusca
1898:                 IF !EOF()
1899:                     loc_oCnt.txt_4c_Fornecedor.Value  = ALLTRIM(iclis)
1900:                     loc_oCnt.txt_4c_DFornecedor.Value = ALLTRIM(nomes)
1901:                 ENDIF
1902:             ENDIF
1903:         ELSE
1904:             loc_oCnt.txt_4c_Fornecedor.Value  = ""
1905:             loc_oCnt.txt_4c_DFornecedor.Value = ""
1906:         ENDIF
1907: 

