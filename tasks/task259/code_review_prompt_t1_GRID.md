# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (4)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 786: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 971: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1071: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 2064: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrApr.prg) - TRECHOS RELEVANTES PARA PASS GRID (2161 linhas total):

*-- Linhas 86 a 106:
86:             BINDEVENT(THIS.txt_4c_MoeVs,     "KeyPress", THIS, "TxtMoeVsKeyPress")
87:             BINDEVENT(THIS.txt_4c_MoeCusto,  "KeyPress", THIS, "TxtMoeCustoKeyPress")
88: 
89:             BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdAfterRowColChange")
90:             BINDEVENT(THIS.grd_4c_Dados, "HeaderClick",       THIS, "GrdHeaderClick")
91:             BINDEVENT(THIS.grd_4c_Dados, "KeyPress",          THIS, "GrdKeyPress")
92: 
93:             THIS.TornarControlesVisiveis(THIS)
94: 
95:             THIS.opt_4c_Tipo.Value = 1
96:             THIS.OptTipoChange()
97: 
98:             THIS.AjustarBotoesPorModo()
99: 
100:             THIS.txt_4c_GrupoIni.SetFocus()
101: 
102:             loc_lSucesso = .T.
103:                 ENDIF
104:             ENDIF
105:         CATCH TO loc_oErro
106:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;

*-- Linhas 767 a 878:
767:     *==========================================================================
768:     PROTECTED PROCEDURE ConfigurarGrade()
769:     *==========================================================================
770:         THIS.AddObject("grd_4c_Dados", "Grid")
771:         WITH THIS.grd_4c_Dados
772:             .Top           = 307
773:             .Left          = 31
774:             .Width         = 725
775:             .Height        = 247
776:             .ColumnCount   = 5
777:             .FontName      = "Tahoma"
778:             .FontSize      = 8
779:             .DeleteMark    = .F.
780:             .RecordMark    = .F.
781:             .GridLines     = 3
782:             .GridLineWidth = 1
783:             .HeaderHeight  = 17
784:             .RowHeight     = 17
785:             .ScrollBars    = 3
786:             .RecordSource  = "cursor_4c_Produtos"
787: 
788:             *-- Coluna 1: CheckBox de selecao
789:             WITH .Column1
790:                 .Width      = 25
791:                 .Movable    = .F.
792:                 .Resizable  = .F.
793:                 .Sparse     = .F.
794:                 .AddObject("Check1", "CheckBox")
795:                 .Check1.Caption = ""
796:                 .Check1.Value   = 0
797:                 .CurrentControl = "Check1"
798:                 .ControlSource  = "cursor_4c_Produtos.lMarca"
799:                 WITH .Header1
800:                     .Caption = ""
801:                     .Tag     = "1"
802:                 ENDWITH
803:             ENDWITH
804: 
805:             *-- Coluna 2: Codigo do produto
806:             WITH .Column2
807:                 .Width         = 110
808:                 .Movable       = .F.
809:                 .Resizable     = .F.
810:                 .ReadOnly      = .T.
811:                 .ControlSource = "cursor_4c_Produtos.CPros"
812:                 WITH .Header1
813:                     .Caption = "Produto"
814:                 ENDWITH
815:                 WITH .Text1
816:                     .FontName = "Verdana"
817:                     .FontSize = 8
818:                 ENDWITH
819:             ENDWITH
820: 
821:             *-- Coluna 3: Descricao (ReadOnly)
822:             WITH .Column3
823:                 .Width         = 260
824:                 .Movable       = .F.
825:                 .Resizable     = .F.
826:                 .ReadOnly      = .T.
827:                 .ControlSource = "cursor_4c_Produtos.DPros"
828:                 WITH .Header1
829:                     .Caption = "Descri" + CHR(231) + CHR(227) + "o"
830:                 ENDWITH
831:                 WITH .Text1
832:                     .FontName = "Verdana"
833:                     .FontSize = 8
834:                 ENDWITH
835:             ENDWITH
836: 
837:             *-- Coluna 4: Preco Anterior (ReadOnly)
838:             WITH .Column4
839:                 .Width         = 165
840:                 .Movable       = .F.
841:                 .Resizable     = .F.
842:                 .ReadOnly      = .T.
843:                 .ControlSource = "cursor_4c_Produtos.ValAnt"
844:                 .Alignment     = 3
845:                 WITH .Header1
846:                     .Caption = "Pre" + CHR(231) + "o Anterior"
847:                 ENDWITH
848:                 WITH .Text1
849:                     .FontName  = "Verdana"
850:                     .FontSize  = 8
851:                     .InputMask = "999,999.99"
852:                 ENDWITH
853:             ENDWITH
854: 
855:             *-- Coluna 5: Preco Atual (editavel se LibValAtu)
856:             WITH .Column5
857:                 .Width         = 165
858:                 .Movable       = .F.
859:                 .Resizable     = .F.
860:                 .ReadOnly      = !THIS.this_lLibValAtu
861:                 .ControlSource = "cursor_4c_Produtos.ValAtu"
862:                 .Alignment     = 3
863:                 WITH .Header1
864:                     .Caption = "Pre" + CHR(231) + "o Atual"
865:                     IF !THIS.this_lLibValAtu
866:                         .Picture = gc_4c_CaminhoIcones + "LOCK.BMP"
867:                     ENDIF
868:                 ENDWITH
869:                 WITH .Text1
870:                     .FontName  = "Verdana"
871:                     .FontSize  = 8
872:                     .InputMask = "999,999.99"
873:                 ENDWITH
874:             ENDWITH
875:         ENDWITH
876:     ENDPROC
877: 
878:     *==========================================================================

*-- Linhas 957 a 990:
957:     ENDPROC
958: 
959:     *==========================================================================
960:     * BtnProcessarClick - Calcula novos precos e preenche o grid
961:     *==========================================================================
962:     PROCEDURE BtnProcessarClick()
963:         LOCAL loc_lSucesso, loc_oErro
964:         loc_lSucesso = .F.
965: 
966:         TRY
967:             THIS.FormParaBO()
968:             loc_lSucesso = THIS.this_oBusinessObject.ProcessarReajuste()
969:             IF loc_lSucesso
970:                 THIS.grd_4c_Dados.ColumnCount = 3
971:                 THIS.grd_4c_Dados.RecordSource = "cursor_4c_Produtos"
972:                 THIS.grd_4c_Dados.Refresh()
973:                 THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
974:                 THIS.cmg_4c_Botoes.Refresh()
975:                 THIS.grd_4c_Dados.Column1.SetFocus()
976:             ENDIF
977:         CATCH TO loc_oErro
978:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
979:                     " PROC=" + loc_oErro.Procedure, "Erro BtnProcessarClick")
980:         ENDTRY
981:     ENDPROC
982: 
983:     *==========================================================================
984:     * BtnAtualizarClick - Grava alteracoes no banco de dados
985:     *==========================================================================
986:     PROCEDURE BtnAtualizarClick()
987:         LOCAL loc_llImpEtiq, loc_lSucesso, loc_oErro
988:         loc_lSucesso = .F.
989: 
990:         TRY

*-- Linhas 1046 a 1091:
1046: 
1047:         TRY
1048:             IF !USED("cursor_4c_Produtos")
1049:                 CREATE CURSOR cursor_4c_Produtos ( ;
1050:                     lMarca  N(1) NULL, ;
1051:                     CPros   C(14) NULL, ;
1052:                     DPros   C(40) NULL, ;
1053:                     ValAnt  N(14,4) NULL, ;
1054:                     ValAtu  N(14,4) NULL, ;
1055:                     fCustos N(9,4) NULL, ;
1056:                     MoePcs  C(3) NULL, ;
1057:                     CustoFs N(14,4) NULL, ;
1058:                     Manual  N(1) NULL)
1059:                 INDEX ON CPros TAG CPros
1060:             ENDIF
1061: 
1062:             INSERT INTO cursor_4c_Produtos ;
1063:                 (lMarca, CPros, DPros, ValAtu, ValAnt, fCustos, MoePcs, CustoFs, Manual) ;
1064:                 VALUES (0, SPACE(14), SPACE(40), 0, 0, 0, "   ", 0, 0)
1065: 
1066:             SELECT cursor_4c_Produtos
1067:             SET ORDER TO
1068:             GO BOTTOM
1069: 
1070:             THIS.grd_4c_Dados.ColumnCount = 3
1071:             THIS.grd_4c_Dados.RecordSource            = "cursor_4c_Produtos"
1072:             THIS.grd_4c_Dados.Column1.Check1.ReadOnly = .T.
1073:             THIS.grd_4c_Dados.Column2.ReadOnly        = .F.
1074:             THIS.grd_4c_Dados.Refresh()
1075:             THIS.grd_4c_Dados.SetFocus()
1076:             THIS.grd_4c_Dados.ActivateCell(RECNO("cursor_4c_Produtos"), 2)
1077:         CATCH TO loc_oErro
1078:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1079:                     " PROC=" + loc_oErro.Procedure, "Erro BtnIncluirClick")
1080:         ENDTRY
1081:     ENDPROC
1082: 
1083:     *==========================================================================
1084:     * BtnAlterarClick - Recalcula precos (alterar base de calculo)
1085:     * Delega para BtnProcessarClick que executa o processamento principal
1086:     *==========================================================================
1087:     PROCEDURE BtnAlterarClick()
1088:         LOCAL loc_oErro
1089: 
1090:         TRY
1091:             THIS.BtnProcessarClick()

*-- Linhas 1113 a 1131:
1113:                             "Visualizar")
1114:                 ELSE
1115:                     THIS.GrdAfterRowColChange(2)
1116:                     THIS.grd_4c_Dados.Refresh()
1117:                     IF PEMSTATUS(THIS, "img_4c_Foto", 5)
1118:                         THIS.img_4c_Foto.Refresh()
1119:                     ENDIF
1120:                 ENDIF
1121:             ENDIF
1122:         CATCH TO loc_oErro
1123:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1124:                     " PROC=" + loc_oErro.Procedure, "Erro BtnVisualizarClick")
1125:         ENDTRY
1126:     ENDPROC
1127: 
1128:     *==========================================================================
1129:     * BtnExcluirClick - Remove produtos marcados/selecionados do grid
1130:     * (nao exclui do banco - apenas remove do cursor de pre-processamento)
1131:     *==========================================================================

*-- Linhas 1162 a 1180:
1162:                 IF loc_nRemovidos > 0
1163:                     SELECT cursor_4c_Produtos
1164:                     GO TOP
1165:                     THIS.grd_4c_Dados.Refresh()
1166:                     THIS.Refresh()
1167:                 ENDIF
1168:             ENDIF
1169:         CATCH TO loc_oErro
1170:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1171:                     " PROC=" + loc_oErro.Procedure, "Erro BtnExcluirClick")
1172:         ENDTRY
1173:     ENDPROC
1174: 
1175:     *==========================================================================
1176:     * OptTipoChange - Controla visibilidade de campos por tipo de reajuste
1177:     *==========================================================================
1178:     PROCEDURE OptTipoChange()
1179:         LOCAL loc_nTipo
1180:         loc_nTipo = THIS.opt_4c_Tipo.Value

*-- Linhas 1279 a 1316:
1279:             THIS.txt_4c_Moeda.Enabled                 = .F.
1280:             THIS.txt_4c_MarkUp1.Enabled               = .F.
1281:             THIS.cmg_4c_Botoes.Buttons(1).Enabled     = .F.
1282:             THIS.grd_4c_Dados.Column1.Check1.ReadOnly = .T.
1283:             THIS.grd_4c_Dados.Column2.ReadOnly        = .F.
1284:             THIS.grd_4c_Dados.Refresh()
1285:         ELSE
1286:             *-- Modo Auditado OFF: limpar grid e restaurar filtros
1287:             IF USED("cursor_4c_Produtos")
1288:                 DELETE FROM cursor_4c_Produtos
1289:                 SELECT cursor_4c_Produtos
1290:                 SET ORDER TO CPros
1291:                 GO TOP
1292:             ENDIF
1293:             THIS.txt_4c_GrupoIni.Enabled              = .T.
1294:             THIS.txt_4c_GrupoFim.Enabled              = .T.
1295:             THIS.txt_4c_Colecao.Enabled               = .T.
1296:             THIS.txt_4c_Moeda.Enabled                 = .T.
1297:             THIS.txt_4c_MarkUp1.Enabled               = .T.
1298:             THIS.cmg_4c_Botoes.Buttons(1).Enabled     = .T.
1299:             THIS.grd_4c_Dados.Column1.Check1.ReadOnly = .F.
1300:             THIS.grd_4c_Dados.Column2.ReadOnly        = .T.
1301:             THIS.grd_4c_Dados.Refresh()
1302:             THIS.txt_4c_GrupoIni.SetFocus()
1303:         ENDIF
1304:         THIS.cmg_4c_Botoes.Refresh()
1305:     ENDPROC
1306: 
1307:     *==========================================================================
1308:     * GrdAfterRowColChange - foto do produto + rastrear edicao manual do preco
1309:     *==========================================================================
1310:     PROCEDURE GrdAfterRowColChange(par_nColIndex)
1311:         LOCAL loc_cArqFig, loc_cSQL, loc_cFoto, loc_oErro
1312: 
1313:         TRY
1314:             IF USED("cursor_4c_Produtos")
1315:                 SELECT cursor_4c_Produtos
1316:                 IF EOF("cursor_4c_Produtos")

*-- Linhas 1379 a 1422:
1379:         IF par_nColIndex != 1 OR !USED("cursor_4c_Produtos")
1380:             RETURN
1381:         ENDIF
1382:         IF THIS.grd_4c_Dados.Column1.Header1.Tag = "0"
1383:             UPDATE cursor_4c_Produtos SET lMarca = 1
1384:             THIS.grd_4c_Dados.Column1.Header1.Tag = "1"
1385:         ELSE
1386:             UPDATE cursor_4c_Produtos SET lMarca = 0
1387:             THIS.grd_4c_Dados.Column1.Header1.Tag = "0"
1388:         ENDIF
1389:         THIS.grd_4c_Dados.Refresh()
1390:         THIS.Refresh()
1391:     ENDPROC
1392: 
1393:     *==========================================================================
1394:     * GrdKeyPress - Em modo Auditado, dispara lookup de produto ao Enter/Tab/F4
1395:     *==========================================================================
1396:     PROCEDURE GrdKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1397:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1398:             RETURN
1399:         ENDIF
1400:         IF THIS.chk_4c_Auditado.Value != 1
1401:             RETURN
1402:         ENDIF
1403:         IF THIS.grd_4c_Dados.ActiveColumn != 2
1404:             RETURN
1405:         ENDIF
1406:         LOCAL loc_cVal
1407:         loc_cVal = ALLTRIM(NVL(THIS.grd_4c_Dados.Column2.Text1.Value, ""))
1408:         IF !EMPTY(loc_cVal)
1409:             THIS.AtualizarLinhaGrid(loc_cVal)
1410:         ENDIF
1411:     ENDPROC
1412: 
1413:     *==========================================================================
1414:     * AtualizarLinhaGrid - Calcula preco para produto e preenche linha do grid
1415:     * Chamado no modo Auditado quando usuario digita codigo de produto
1416:     *==========================================================================
1417:     PROTECTED PROCEDURE AtualizarLinhaGrid(par_cCPros)
1418:         LOCAL loc_oBO, loc_nTipo, loc_nVariacao, loc_nMarkUp2
1419:         LOCAL loc_nValAtu, loc_nCotId, loc_nCotVd, loc_nPven
1420:         LOCAL loc_cMoePcs, loc_nFCustos, loc_nCustoFs, loc_oErro
1421: 
1422:         TRY

*-- Linhas 1499 a 1517:
1499:                     VALUES (0, SPACE(14), SPACE(40), 0, 0, 0, "   ", 0, 0)
1500:             ENDIF
1501:             SELECT cursor_4c_Produtos
1502:             THIS.grd_4c_Dados.Refresh()
1503:             KEYBOARD "{DNARROW}"
1504: 
1505:                     IF USED("cursor_4c_BuscaProSingle")
1506:                         USE IN cursor_4c_BuscaProSingle
1507:                     ENDIF
1508:                 ELSE
1509:                     IF USED("cursor_4c_BuscaProSingle")
1510:                         USE IN cursor_4c_BuscaProSingle
1511:                     ENDIF
1512:                 ENDIF
1513:             ELSE
1514:                 MsgAviso("Produto n" + CHR(227) + "o encontrado: " + par_cCPros, "Produto")
1515:                 IF USED("cursor_4c_BuscaProSingle")
1516:                     USE IN cursor_4c_BuscaProSingle
1517:                 ENDIF

*-- Linhas 1570 a 1589:
1570:                 "cursor_4c_BuscaGrp", "CGrus", loc_cVal, ;
1571:                 "Grupos de Produto", .T., .T., "")
1572:             IF VARTYPE(loc_oBA) = "O"
1573:                 loc_oBA.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
1574:                 loc_oBA.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
1575:                 loc_oBA.Show()
1576:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
1577:                     SELECT cursor_4c_BuscaGrp
1578:                     GO TOP
1579:                     par_oTxtAlvo.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
1580:                     IF VARTYPE(par_oTxtFim) = "O" AND EMPTY(ALLTRIM(par_oTxtFim.Value))
1581:                         par_oTxtFim.Value = par_oTxtAlvo.Value
1582:                     ENDIF
1583:                 ELSE
1584:                     par_oTxtAlvo.Value = ""
1585:                 ENDIF
1586:                 IF USED("cursor_4c_BuscaGrp")
1587:                     USE IN cursor_4c_BuscaGrp
1588:                 ENDIF
1589:             ENDIF

*-- Linhas 1624 a 1643:
1624:                 "cursor_4c_BuscaCol", "Colecoes", loc_cVal, ;
1625:                 "Cole" + CHR(231) + CHR(245) + "es", .T., .T., "")
1626:             IF VARTYPE(loc_oBA) = "O"
1627:                 loc_oBA.mAddColuna("Colecoes", "", "C" + CHR(243) + "digo")
1628:                 loc_oBA.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1629:                 loc_oBA.Show()
1630:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaCol")
1631:                     SELECT cursor_4c_BuscaCol
1632:                     GO TOP
1633:                     THIS.txt_4c_Colecao.Value = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
1634:                 ELSE
1635:                     THIS.txt_4c_Colecao.Value = ""
1636:                 ENDIF
1637:                 IF USED("cursor_4c_BuscaCol")
1638:                     USE IN cursor_4c_BuscaCol
1639:                 ENDIF
1640:             ENDIF
1641:         CATCH TO loc_oErro
1642:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1643:                     " PROC=" + loc_oErro.Procedure, "Erro TxtColecaoKeyPress")

*-- Linhas 1681 a 1700:
1681:                 "cursor_4c_BuscaConta", "IClis", loc_cVal, ;
1682:                 "Sele" + CHR(231) + CHR(227) + "o de Fornecedor", .T., .T., loc_cFiltroBA)
1683:             IF VARTYPE(loc_oBA) = "O"
1684:                 loc_oBA.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
1685:                 loc_oBA.mAddColuna("RClis", "", "Nome")
1686:                 loc_oBA.Show()
1687:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1688:                     SELECT cursor_4c_BuscaConta
1689:                     GO TOP
1690:                     THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
1691:                     THIS.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
1692:                 ELSE
1693:                     THIS.txt_4c_Conta.Value  = ""
1694:                     THIS.txt_4c_DConta.Value = ""
1695:                 ENDIF
1696:                 IF USED("cursor_4c_BuscaConta")
1697:                     USE IN cursor_4c_BuscaConta
1698:                 ENDIF
1699:             ENDIF
1700:         CATCH TO loc_oErro

*-- Linhas 1743 a 1762:
1743:                 "cursor_4c_BuscaConta", "RClis", loc_cVal, ;
1744:                 "Sele" + CHR(231) + CHR(227) + "o de Fornecedor", .T., .T., loc_cFiltroBA)
1745:             IF VARTYPE(loc_oBA) = "O"
1746:                 loc_oBA.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
1747:                 loc_oBA.mAddColuna("RClis", "", "Nome")
1748:                 loc_oBA.Show()
1749:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1750:                     SELECT cursor_4c_BuscaConta
1751:                     GO TOP
1752:                     THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
1753:                     THIS.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
1754:                 ELSE
1755:                     THIS.txt_4c_DConta.Value = ""
1756:                 ENDIF
1757:                 IF USED("cursor_4c_BuscaConta")
1758:                     USE IN cursor_4c_BuscaConta
1759:                 ENDIF
1760:             ENDIF
1761:         CATCH TO loc_oErro
1762:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;

*-- Linhas 1795 a 1813:
1795:                 "cursor_4c_BuscaPromo", "Promos", loc_cVal, ;
1796:                 "Promo" + CHR(231) + CHR(227) + "o", .T., .T., "")
1797:             IF VARTYPE(loc_oBA) = "O"
1798:                 loc_oBA.mAddColuna("Promos", "", "Promo" + CHR(231) + CHR(227) + "o")
1799:                 loc_oBA.Show()
1800:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaPromo")
1801:                     SELECT cursor_4c_BuscaPromo
1802:                     GO TOP
1803:                     THIS.txt_4c_Promo.Value = ALLTRIM(cursor_4c_BuscaPromo.Promos)
1804:                 ELSE
1805:                     THIS.txt_4c_Promo.Value = ""
1806:                 ENDIF
1807:                 IF USED("cursor_4c_BuscaPromo")
1808:                     USE IN cursor_4c_BuscaPromo
1809:                 ENDIF
1810:             ENDIF
1811:         CATCH TO loc_oErro
1812:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1813:                     " PROC=" + loc_oErro.Procedure, "Erro TxtPromoKeyPress")

*-- Linhas 1841 a 1860:
1841:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", ;
1842:                 "cursor_4c_BuscaMoe", "CMoes", loc_cVal, "Moedas", .T., .T., "")
1843:             IF VARTYPE(loc_oBA) = "O"
1844:                 loc_oBA.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
1845:                 loc_oBA.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1846:                 loc_oBA.Show()
1847:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
1848:                     SELECT cursor_4c_BuscaMoe
1849:                     GO TOP
1850:                     par_oTxt.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
1851:                 ELSE
1852:                     par_oTxt.Value = ""
1853:                 ENDIF
1854:                 IF USED("cursor_4c_BuscaMoe")
1855:                     USE IN cursor_4c_BuscaMoe
1856:                 ENDIF
1857:             ENDIF
1858:         CATCH TO loc_oErro
1859:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1860:                     " PROC=" + loc_oErro.Procedure, "Erro AbrirBuscaMoeda")

*-- Linhas 1933 a 1952:
1933:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigPrFti", ;
1934:                 "cursor_4c_BuscaFtio", "Cods", loc_cVal, "Feitio", .T., .T., "")
1935:             IF VARTYPE(loc_oBA) = "O"
1936:                 loc_oBA.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
1937:                 loc_oBA.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1938:                 loc_oBA.Show()
1939:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaFtio")
1940:                     SELECT cursor_4c_BuscaFtio
1941:                     GO TOP
1942:                     THIS.txt_4c_CFtios.Value = ALLTRIM(cursor_4c_BuscaFtio.Cods)
1943:                 ELSE
1944:                     THIS.txt_4c_CFtios.Value = ""
1945:                 ENDIF
1946:                 IF USED("cursor_4c_BuscaFtio")
1947:                     USE IN cursor_4c_BuscaFtio
1948:                 ENDIF
1949:             ENDIF
1950:         CATCH TO loc_oErro
1951:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1952:                     " PROC=" + loc_oErro.Procedure, "Erro TxtCFtiosKeyPress")

*-- Linhas 1979 a 2087:
1979: 
1980:         loc_lJaConfigurado = PEMSTATUS(THIS, "cnt_4c_Cabecalho", 5) ;
1981:                          AND PEMSTATUS(THIS, "cmg_4c_Botoes", 5) ;
1982:                          AND PEMSTATUS(THIS, "grd_4c_Dados", 5)
1983: 
1984:         IF !loc_lJaConfigurado
1985:             THIS.ConfigurarCabecalho()
1986:             THIS.ConfigurarBotoes()
1987:             THIS.ConfigurarFiltros()
1988:             THIS.ConfigurarGrade()
1989:         ENDIF
1990: 
1991:         IF PEMSTATUS(THIS, "cnt_4c_Cabecalho", 5)
1992:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
1993:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
1994:         ENDIF
1995: 
1996:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND USED("cursor_4c_Produtos")
1997:             SELECT cursor_4c_Produtos
1998:             GO TOP
1999:             THIS.grd_4c_Dados.Refresh()
2000:         ENDIF
2001:     ENDPROC
2002: 
2003:     *==========================================================================
2004:     * AlternarPagina - Form OPERACIONAL nao usa PageFrame com Page1/Page2.
2005:     * Todos os controles (filtros + grade + botoes) convivem no mesmo layout.
2006:     * O metodo mantem a assinatura padrao do pipeline reposicionando o foco
2007:     * no primeiro controle relevante (filtro ou grade) conforme par_nPagina.
2008:     *==========================================================================
2009:     PROCEDURE AlternarPagina(par_nPagina)
2010:         LOCAL loc_nPagina
2011: 
2012:         loc_nPagina = IIF(VARTYPE(par_nPagina) = "N" AND par_nPagina > 0, par_nPagina, 1)
2013: 
2014:         DO CASE
2015:         CASE loc_nPagina = 1
2016:             IF PEMSTATUS(THIS, "txt_4c_GrupoIni", 5) AND THIS.txt_4c_GrupoIni.Enabled
2017:                 THIS.txt_4c_GrupoIni.SetFocus()
2018:             ENDIF
2019:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND USED("cursor_4c_Produtos")
2020:                 SELECT cursor_4c_Produtos
2021:                 GO TOP
2022:                 THIS.grd_4c_Dados.Refresh()
2023:             ENDIF
2024:         CASE loc_nPagina = 2
2025:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND THIS.grd_4c_Dados.Enabled
2026:                 THIS.grd_4c_Dados.SetFocus()
2027:             ENDIF
2028:         ENDCASE
2029: 
2030:         RETURN .T.
2031:     ENDPROC
2032: 
2033:     *==========================================================================
2034:     * CarregarLista - Inicializa o cursor do grid com estrutura vazia
2035:     * Form OPERACIONAL: dados sao populados via BtnProcessarClick, nao aqui.
2036:     *==========================================================================
2037:     PROCEDURE CarregarLista()
2038:         LOCAL loc_lSucesso, loc_oErro
2039:         loc_lSucesso = .F.
2040: 
2041:         TRY
2042:             SET NULL ON
2043:             IF USED("cursor_4c_Produtos")
2044:                 IF TABLEREVERT(.T., "cursor_4c_Produtos")
2045:                 ENDIF
2046:                 USE IN cursor_4c_Produtos
2047:             ENDIF
2048: 
2049:             CREATE CURSOR cursor_4c_Produtos ( ;
2050:                 lMarca  N(1) NULL, ;
2051:                 CPros   C(14) NULL, ;
2052:                 DPros   C(40) NULL, ;
2053:                 ValAnt  N(14,4) NULL, ;
2054:                 ValAtu  N(14,4) NULL, ;
2055:                 fCustos N(9,4) NULL, ;
2056:                 MoePcs  C(3) NULL, ;
2057:                 CustoFs N(14,4) NULL, ;
2058:                 Manual  N(1) NULL)
2059:             INDEX ON CPros TAG CPros
2060:             SET NULL OFF
2061: 
2062:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2063:                 THIS.grd_4c_Dados.ColumnCount = 5
2064:                 THIS.grd_4c_Dados.RecordSource = "cursor_4c_Produtos"
2065:                 THIS.grd_4c_Dados.Refresh()
2066:             ENDIF
2067: 
2068:             THIS.AjustarBotoesPorModo()
2069: 
2070:             loc_lSucesso = .T.
2071:         CATCH TO loc_oErro
2072:             SET NULL OFF
2073:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
2074:                     " PROC=" + loc_oErro.Procedure, "Erro CarregarLista FormSigPrApr")
2075:         ENDTRY
2076: 
2077:         RETURN loc_lSucesso
2078:     ENDPROC
2079: 
2080:     *==========================================================================
2081:     * LimparCampos - Reseta todos os campos de filtro e esvazia o grid
2082:     *==========================================================================
2083:     PROCEDURE LimparCampos()
2084:         THIS.txt_4c_GrupoIni.Value  = ""
2085:         THIS.txt_4c_GrupoFim.Value  = ""
2086:         THIS.txt_4c_Colecao.Value   = ""
2087:         THIS.txt_4c_Conta.Value     = ""

