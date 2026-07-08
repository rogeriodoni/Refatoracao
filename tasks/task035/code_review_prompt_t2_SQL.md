# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (6)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ORDEM, ESTOS, CPROS, I, CODIGOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DATAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ORDEM, ESTOS, CPROS, I, CODIGOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CGRUS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ORDEM, ESTOS, CPROS, I, CODIGOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'LINHAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ORDEM, ESTOS, CPROS, I, CODIGOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'IFORS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ORDEM, ESTOS, CPROS, I, CODIGOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ORDEM, ESTOS, CPROS, I, CODIGOS

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES SQL
- [GRID-SQL] Campos no ControlSource que nao existem no CREATE CURSOR/SELECT
- [SQL-COLUNA] Nomes de colunas que NAO existem na tabela (validado contra banco real)
  - A mensagem mostra colunas VALIDAS - usar nome EXATO
  - Se sugere "voce quis dizer 'X'?", usar X
- [SQL-TABELA] Tabela inventada que nao existe no original
- [SQL-ASPAS] Aspas duplicadas ou concatenacao sem EscaparSQL
  - EscaparSQL() JA retorna com aspas. FormatarDataSQL() idem.
- [SQL-FILTRO-INVENTADO] Condicao WHERE inventada pela LLM - REMOVER
- [TRANSACAO-AVULSA] COMMIT/ROLLBACK sem BEGIN TRANSACTION - REMOVER

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

### LINHAS SQL/CONTROLSOURCE DO CODIGO ORIGINAL (referencia):
  DeleteMark = .F.
  DeleteMark = .F.
  DeleteMark = .F.
	Select CPros, DPros, Reffs, CGrus, Linhas, IFors, Ordem, Estos,  ;
	  From crImpressao ;
	Select CPros, Sum(Estoques) as Estoques ;
	  From crImpressao ;
	Select a.*, b.Estoques ;
	  From Selecao1 a, Selecao2 b ;
	Select Selecao
			.Column1.ControlSource   = 'csOperacoesE.SelImp'
			.Column2.ControlSource = 'csOperacoesE.Codigos'
			.Column3.ControlSource = 'csOperacoesE.Descrs'
			.Column1.ControlSource   = 'csOperacoesS.SelImp'
			.Column2.ControlSource = 'csOperacoesS.Codigos'
			.Column3.ControlSource = 'csOperacoesS.Descrs'
		Select crSigCdTom
			Insert Into csOperacoesE (SelImp, Codigos, Descrs) ;
			Insert Into csOperacoesS (SelImp, Codigos, Descrs) ;
		Select crSigCdCeg
			Insert Into csSigCdCeg From Memvar
		Select csSigCdCeg
			.Column1.ControlSource = 'csSigCdCeg.lMarca'
			.Column2.ControlSource = 'csSigCdCeg.Grupos'
			.Column3.ControlSource = 'csSigCdCeg.Contas'
	Select CPros, DPros, Reffs, CGrus, Linhas, IFors, Ordem, Estos,  ;
	  From crImpressao ;
	Select CPros, Sum(Estoques) as Estoques ;
	  From crImpressao ;
	Select a.*, b.Estoques ;
	  From Selecao1 a, Selecao2 b ;
	Select Selecao
	Select Iif(Ordem = [0000000001], CPros,  Space(14)) as Código, ;
	  From crImpressao ;
	Select CPros as Código, DPros as Descrição, Reffs as Referência, CGrus as Grp, Linhas as Linha, ;
	  From crImpressao ;
Select csExcell
	Select CPros, DPros, Reffs, CGrus, Linhas, IFors, Ordem, Estos,  ;
	  From crImpressao ;
	Select CPros, Sum(Estoques) as Estoques ;
	  From crImpressao ;
	Select a.*, b.Estoques ;
	  From Selecao1 a, Selecao2 b ;
	Select Selecao
	Select Codigos From csOperacoesE Where SelImp Into Cursor csTmpE
	Select Codigos From csOperacoesS Where SelImp Into Cursor csTmpS
	Select Codigos From csTmpE Where Codigos In (Select Codigos From csTmpS) Into Cursor csTmpDE
	Select Codigos From csTmpS Where Codigos In (Select Codigos From csTmpE) Into Cursor csTmpDS
Select csOperacoesE
	Select csOperacoesE
Select csOperacoesS
	Select csOperacoesS
Update csOperacoesS Set SelImp = (This.Value = 1)
Update csOperacoesE Set SelImp = (This.Value = 1)
Update csSigCdCeg Set lMarca = (This.Value = 1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreato.prg) - TRECHOS RELEVANTES PARA PASS SQL (2039 linhas total):

*-- Linhas 772 a 812:
772:         *-- Garantir cursores placeholder se InicializarDados foi pulado ----
773:         IF !USED("cursor_4c_OperacoesE")
774:             SET NULL ON
775:             CREATE CURSOR cursor_4c_OperacoesE (SelImp L(1), Codigos N(2,0), Descrs C(30))
776:             SET NULL OFF
777:         ENDIF
778:         IF !USED("cursor_4c_OperacoesS")
779:             SET NULL ON
780:             CREATE CURSOR cursor_4c_OperacoesS (SelImp L(1), Codigos N(2,0), Descrs C(30))
781:             SET NULL OFF
782:         ENDIF
783:         IF !USED("cursor_4c_SigCdCeg")
784:             SET NULL ON
785:             CREATE CURSOR cursor_4c_SigCdCeg (lMarca L(1), Grupos C(10), Contas C(10))
786:             SET NULL OFF
787:         ENDIF
788: 
789:         *====================================================================
790:         * Grade de Operacoes de Entrada
791:         *====================================================================
792:         loc_oCnt.AddObject("grd_4c_OperacoesE", "Grid")
793:         WITH loc_oCnt.grd_4c_OperacoesE
794:             .ColumnCount       = 3
795:             .AllowHeaderSizing = .F.
796:             .AllowRowSizing    = .F.
797:             .DeleteMark        = .F.
798:             .GridLines         = 3
799:             .HeaderHeight      = 16
800:             .Height            = 99
801:             .Left              = 46
802:             .Panel             = 1
803:             .RecordMark        = .F.
804:             .RowHeight         = 16
805:             .ScrollBars        = 2
806:             .TabStop           = .F.
807:             .Top               = 163
808:             .Width             = 275
809:             .GridLineColor     = RGB(238, 238, 238)
810:             .FontName          = "Tahoma"
811:             .FontSize          = 8
812:             .Visible           = .T.

*-- Linhas 834 a 869:
834:             .Enabled   = .T.
835:         ENDWITH
836:         loc_oGrd.Column1.CurrentControl = "chk_4c_Marca"
837:         loc_oGrd.Column1.ControlSource  = "cursor_4c_OperacoesE.SelImp"
838: 
839:         WITH loc_oGrd.Column2
840:             .Width         = 20
841:             .ControlSource = "cursor_4c_OperacoesE.Codigos"
842:             .ReadOnly      = .T.
843:             .Enabled       = .T.
844:             .Movable       = .F.
845:             .Resizable     = .F.
846:             .FontName      = "Courier New"
847:             .FontSize      = 8
848:         ENDWITH
849:         loc_oGrd.Column2.Header1.Caption  = ""
850:         loc_oGrd.Column2.Header1.ForeColor = RGB(90, 90, 90)
851: 
852:         WITH loc_oGrd.Column3
853:             .Width         = 208
854:             .ControlSource = "cursor_4c_OperacoesE.Descrs"
855:             .ReadOnly      = .T.
856:             .Enabled       = .T.
857:             .Movable       = .F.
858:             .Resizable     = .F.
859:             .FontName      = "Courier New"
860:             .FontSize      = 8
861:         ENDWITH
862:         loc_oGrd.Column3.Header1.Caption   = "Opera" + CHR(231) + CHR(245) + "es de Entrada"
863:         loc_oGrd.Column3.Header1.ForeColor  = RGB(90, 90, 90)
864:         loc_oGrd.Column3.Header1.Alignment  = 2
865: 
866:         *-- Botoes Marca/Desmarca para Entradas ----------------------------
867:         loc_oCnt.AddObject("cmd_4c_BtnGradeE", "CommandGroup")
868:         WITH loc_oCnt.cmd_4c_BtnGradeE
869:             .AutoSize    = .T.

*-- Linhas 910 a 928:
910:             .ColumnCount       = 3
911:             .AllowHeaderSizing = .F.
912:             .AllowRowSizing    = .F.
913:             .DeleteMark        = .F.
914:             .GridLines         = 3
915:             .HeaderHeight      = 16
916:             .Height            = 99
917:             .Left              = 46
918:             .Panel             = 1
919:             .RecordMark        = .F.
920:             .RowHeight         = 16
921:             .ScrollBars        = 2
922:             .TabStop           = .F.
923:             .Top               = 276
924:             .Width             = 275
925:             .GridLineColor     = RGB(238, 238, 238)
926:             .FontName          = "Tahoma"
927:             .FontSize          = 8
928:             .Visible           = .T.

*-- Linhas 950 a 985:
950:             .Enabled   = .T.
951:         ENDWITH
952:         loc_oGrd.Column1.CurrentControl = "chk_4c_Marca"
953:         loc_oGrd.Column1.ControlSource  = "cursor_4c_OperacoesS.SelImp"
954: 
955:         WITH loc_oGrd.Column2
956:             .Width         = 20
957:             .ControlSource = "cursor_4c_OperacoesS.Codigos"
958:             .ReadOnly      = .T.
959:             .Enabled       = .T.
960:             .Movable       = .F.
961:             .Resizable     = .F.
962:             .FontName      = "Courier New"
963:             .FontSize      = 8
964:         ENDWITH
965:         loc_oGrd.Column2.Header1.Caption  = ""
966:         loc_oGrd.Column2.Header1.ForeColor = RGB(90, 90, 90)
967: 
968:         WITH loc_oGrd.Column3
969:             .Width         = 208
970:             .ControlSource = "cursor_4c_OperacoesS.Descrs"
971:             .ReadOnly      = .T.
972:             .Enabled       = .T.
973:             .Movable       = .F.
974:             .Resizable     = .F.
975:             .FontName      = "Courier New"
976:             .FontSize      = 8
977:         ENDWITH
978:         loc_oGrd.Column3.Header1.Caption   = "Opera" + CHR(231) + CHR(245) + "es de Sa" + CHR(237) + "da"
979:         loc_oGrd.Column3.Header1.ForeColor  = RGB(90, 90, 90)
980:         loc_oGrd.Column3.Header1.Alignment  = 2
981: 
982:         *-- Botoes Marca/Desmarca para Saidas ------------------------------
983:         loc_oCnt.AddObject("cmd_4c_BtnGradeS", "CommandGroup")
984:         WITH loc_oCnt.cmd_4c_BtnGradeS
985:             .AutoSize    = .T.

*-- Linhas 1026 a 1044:
1026:             .ColumnCount       = 3
1027:             .AllowHeaderSizing = .F.
1028:             .AllowRowSizing    = .F.
1029:             .DeleteMark        = .F.
1030:             .GridLines         = 3
1031:             .HeaderHeight      = 16
1032:             .Height            = 211
1033:             .Left              = 421
1034:             .Panel             = 1
1035:             .RecordMark        = .F.
1036:             .RowHeight         = 16
1037:             .ScrollBars        = 2
1038:             .TabStop           = .F.
1039:             .Top               = 163
1040:             .Width             = 207
1041:             .GridLineColor     = RGB(238, 238, 238)
1042:             .FontName          = "Tahoma"
1043:             .FontSize          = 8
1044:             .Visible           = .T.

*-- Linhas 1066 a 1101:
1066:             .Enabled   = .T.
1067:         ENDWITH
1068:         loc_oGrd.Column1.CurrentControl = "chk_4c_Marca"
1069:         loc_oGrd.Column1.ControlSource  = "cursor_4c_SigCdCeg.lMarca"
1070: 
1071:         WITH loc_oGrd.Column2
1072:             .Width         = 80
1073:             .ControlSource = "cursor_4c_SigCdCeg.Grupos"
1074:             .ReadOnly      = .T.
1075:             .Enabled       = .T.
1076:             .Movable       = .F.
1077:             .Resizable     = .F.
1078:             .FontName      = "Courier New"
1079:             .FontSize      = 8
1080:         ENDWITH
1081:         loc_oGrd.Column2.Header1.Caption  = "Grupo"
1082:         loc_oGrd.Column2.Header1.ForeColor = RGB(90, 90, 90)
1083: 
1084:         WITH loc_oGrd.Column3
1085:             .Width         = 80
1086:             .ControlSource = "cursor_4c_SigCdCeg.Contas"
1087:             .ReadOnly      = .T.
1088:             .Enabled       = .T.
1089:             .Movable       = .F.
1090:             .Resizable     = .F.
1091:             .FontName      = "Courier New"
1092:             .FontSize      = 8
1093:         ENDWITH
1094:         loc_oGrd.Column3.Header1.Caption  = "Conta"
1095:         loc_oGrd.Column3.Header1.ForeColor = RGB(90, 90, 90)
1096: 
1097:         *-- Botoes Marca/Desmarca para SigCdCeg ----------------------------
1098:         loc_oCnt.AddObject("cmd_4c_BtnCeg", "CommandGroup")
1099:         WITH loc_oCnt.cmd_4c_BtnCeg
1100:             .AutoSize    = .T.
1101:             .ButtonCount = 2

*-- Linhas 1329 a 1383:
1329:         loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
1330: 
1331:         IF USED("cursor_4c_OperacoesE")
1332:             SELECT Codigos FROM cursor_4c_OperacoesE WHERE SelImp INTO CURSOR cursor_4c_TmpE READWRITE
1333:             IF RECCOUNT("cursor_4c_TmpE") < 1
1334:                 MsgAviso("Nenhum Tipo de Opera" + CHR(231) + CHR(227) + "o de Entrada Foi Selecionado!!!", ;
1335:                     "Aten" + CHR(231) + CHR(227) + "o")
1336:                 IF VARTYPE(loc_oCnt.grd_4c_OperacoesE) = "O"
1337:                     loc_oCnt.grd_4c_OperacoesE.Column1.SetFocus()
1338:                 ENDIF
1339:                 IF USED("cursor_4c_TmpE")
1340:                     USE IN cursor_4c_TmpE
1341:                 ENDIF
1342:                 RETURN .F.
1343:             ENDIF
1344:         ENDIF
1345: 
1346:         IF USED("cursor_4c_OperacoesS")
1347:             SELECT Codigos FROM cursor_4c_OperacoesS WHERE SelImp INTO CURSOR cursor_4c_TmpS READWRITE
1348:             IF RECCOUNT("cursor_4c_TmpS") < 1
1349:                 MsgAviso("Nenhum Tipo de Opera" + CHR(231) + CHR(227) + "o de Sa" + CHR(237) + "da Foi Selecionado!!!", ;
1350:                     "Aten" + CHR(231) + CHR(227) + "o")
1351:                 IF VARTYPE(loc_oCnt.grd_4c_OperacoesS) = "O"
1352:                     loc_oCnt.grd_4c_OperacoesS.Column1.SetFocus()
1353:                 ENDIF
1354:                 IF USED("cursor_4c_TmpE")
1355:                     USE IN cursor_4c_TmpE
1356:                 ENDIF
1357:                 IF USED("cursor_4c_TmpS")
1358:                     USE IN cursor_4c_TmpS
1359:                 ENDIF
1360:                 RETURN .F.
1361:             ENDIF
1362:         ENDIF
1363: 
1364:         *-- Verificar intersecao E/S
1365:         IF USED("cursor_4c_TmpE") AND USED("cursor_4c_TmpS")
1366:             SELECT cursor_4c_TmpE.Codigos FROM cursor_4c_TmpE ;
1367:                 WHERE cursor_4c_TmpE.Codigos IN ;
1368:                 (SELECT cursor_4c_TmpS.Codigos FROM cursor_4c_TmpS) ;
1369:                 INTO CURSOR cursor_4c_TmpDup READWRITE
1370:             IF RECCOUNT("cursor_4c_TmpDup") > 0
1371:                 MsgAviso("Foram Selecionados Tipos de Opera" + CHR(231) + CHR(245) + "es de Entrada e Sa" + CHR(237) + "da Iguais!!!", ;
1372:                     "Aten" + CHR(231) + CHR(227) + "o")
1373:                 loc_lOK = .F.
1374:             ENDIF
1375:             IF USED("cursor_4c_TmpDup")
1376:                 USE IN cursor_4c_TmpDup
1377:             ENDIF
1378:         ENDIF
1379: 
1380:         IF USED("cursor_4c_TmpE")
1381:             USE IN cursor_4c_TmpE
1382:         ENDIF
1383:         IF USED("cursor_4c_TmpS")

*-- Linhas 1626 a 1684:
1626:             RETURN
1627:         ENDIF
1628:         IF loc_oCnt.cmd_4c_BtnGradeE.Value = 1
1629:             SELECT cursor_4c_OperacoesE
1630:             REPLACE ALL SelImp WITH .T.
1631:             GO TOP
1632:         ELSE
1633:             SELECT cursor_4c_OperacoesE
1634:             REPLACE ALL SelImp WITH .F.
1635:             GO TOP
1636:         ENDIF
1637:         loc_oCnt.grd_4c_OperacoesE.Refresh()
1638:     ENDPROC
1639: 
1640:     PROCEDURE CmdGradeSClick()
1641:         LOCAL loc_oCnt
1642:         loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
1643:         IF !USED("cursor_4c_OperacoesS")
1644:             RETURN
1645:         ENDIF
1646:         IF loc_oCnt.cmd_4c_BtnGradeS.Value = 1
1647:             SELECT cursor_4c_OperacoesS
1648:             REPLACE ALL SelImp WITH .T.
1649:             GO TOP
1650:         ELSE
1651:             SELECT cursor_4c_OperacoesS
1652:             REPLACE ALL SelImp WITH .F.
1653:             GO TOP
1654:         ENDIF
1655:         loc_oCnt.grd_4c_OperacoesS.Refresh()
1656:     ENDPROC
1657: 
1658:     PROCEDURE CmdCegClick()
1659:         LOCAL loc_oCnt
1660:         loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
1661:         IF !USED("cursor_4c_SigCdCeg")
1662:             RETURN
1663:         ENDIF
1664:         IF loc_oCnt.cmd_4c_BtnCeg.Value = 1
1665:             SELECT cursor_4c_SigCdCeg
1666:             REPLACE ALL lMarca WITH .T.
1667:             GO TOP
1668:         ELSE
1669:             SELECT cursor_4c_SigCdCeg
1670:             REPLACE ALL lMarca WITH .F.
1671:             GO TOP
1672:         ENDIF
1673:         loc_oCnt.grd_4c_SigCdCeg.Refresh()
1674:     ENDPROC
1675: 
1676:     *==========================================================================
1677:     * Lookups com FormBuscaAuxiliar
1678:     *==========================================================================
1679: 
1680:     *--------------------------------------------------------------------------
1681:     * AbrirBuscaGrupo - SigCdGrp (CGrus/DGrus)
1682:     *--------------------------------------------------------------------------
1683:     PROCEDURE AbrirBuscaGrupo()
1684:         LOCAL loc_oCnt, loc_cValor, loc_oForm

*-- Linhas 1702 a 1746:
1702: 
1703:         IF loc_oForm.this_lSelecionou
1704:             IF USED("cursor_4c_GrupoBusca")
1705:                 SELECT cursor_4c_GrupoBusca
1706:                 IF !EOF()
1707:                     loc_oCnt.txt_4c_Grupo.Value  = ALLTRIM(CGrus)
1708:                     loc_oCnt.txt_4c_DGrupo.Value = ALLTRIM(DGrus)
1709:                 ENDIF
1710:             ENDIF
1711:         ELSE
1712:             loc_oCnt.txt_4c_Grupo.Value  = ""
1713:             loc_oCnt.txt_4c_DGrupo.Value = ""
1714:         ENDIF
1715: 
1716:         IF USED("cursor_4c_GrupoBusca")
1717:             USE IN cursor_4c_GrupoBusca
1718:         ENDIF
1719:         loc_oForm.Release()
1720:         THIS.AtualizarEstadoCampos()
1721:     ENDPROC
1722: 
1723:     *--------------------------------------------------------------------------
1724:     PROTECTED PROCEDURE ValidarGrupo(par_cCodigo)
1725:         LOCAL loc_oCnt, loc_cSQL, loc_nResult
1726:         loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
1727:         loc_cSQL = "SELECT CGrus, DGrus FROM SigCdGrp WHERE CGrus = " + ;
1728:                    EscaparSQL(par_cCodigo)
1729:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoVal")
1730:         IF loc_nResult > 0
1731:             SELECT cursor_4c_GrupoVal
1732:             IF !EOF()
1733:                 loc_oCnt.txt_4c_DGrupo.Value   = ALLTRIM(DGrus)
1734:                 loc_oCnt.txt_4c_DGrupo.ReadOnly = .T.
1735:             ELSE
1736:                 USE IN cursor_4c_GrupoVal
1737:                 THIS.AbrirBuscaGrupo()
1738:                 RETURN
1739:             ENDIF
1740:             USE IN cursor_4c_GrupoVal
1741:         ELSE
1742:             MsgAviso("Erro ao buscar grupo", "Aviso")
1743:         ENDIF
1744:         THIS.AtualizarEstadoCampos()
1745:     ENDPROC
1746: 

*-- Linhas 1769 a 1813:
1769: 
1770:         IF loc_oForm.this_lSelecionou
1771:             IF USED("cursor_4c_ProdBusca")
1772:                 SELECT cursor_4c_ProdBusca
1773:                 IF !EOF()
1774:                     loc_oCnt.txt_4c_CPros.Value   = ALLTRIM(CPros)
1775:                     loc_oCnt.txt_4c_DPros.Value   = ALLTRIM(DPros)
1776:                 ENDIF
1777:             ENDIF
1778:         ELSE
1779:             loc_oCnt.txt_4c_CPros.Value = ""
1780:             loc_oCnt.txt_4c_DPros.Value = ""
1781:         ENDIF
1782: 
1783:         IF USED("cursor_4c_ProdBusca")
1784:             USE IN cursor_4c_ProdBusca
1785:         ENDIF
1786:         loc_oForm.Release()
1787:         THIS.AtualizarEstadoCampos()
1788:     ENDPROC
1789: 
1790:     *--------------------------------------------------------------------------
1791:     PROTECTED PROCEDURE ValidarProduto(par_cCodigo)
1792:         LOCAL loc_oCnt, loc_cSQL, loc_nResult
1793:         loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
1794:         loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE CPros = " + ;
1795:                    EscaparSQL(par_cCodigo)
1796:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdVal")
1797:         IF loc_nResult > 0
1798:             SELECT cursor_4c_ProdVal
1799:             IF !EOF()
1800:                 loc_oCnt.txt_4c_DPros.Value   = ALLTRIM(DPros)
1801:                 loc_oCnt.txt_4c_DPros.ReadOnly = .T.
1802:             ELSE
1803:                 USE IN cursor_4c_ProdVal
1804:                 THIS.AbrirBuscaProduto()
1805:                 RETURN
1806:             ENDIF
1807:             USE IN cursor_4c_ProdVal
1808:         ELSE
1809:             MsgAviso("Erro ao buscar produto", "Aviso")
1810:         ENDIF
1811:         THIS.AtualizarEstadoCampos()
1812:     ENDPROC
1813: 

*-- Linhas 1836 a 1880:
1836: 
1837:         IF loc_oForm.this_lSelecionou
1838:             IF USED("cursor_4c_LinBusca")
1839:                 SELECT cursor_4c_LinBusca
1840:                 IF !EOF()
1841:                     loc_oCnt.txt_4c_Linha.Value = ALLTRIM(Linhas)
1842:                     loc_oCnt.txt_4c_DLin.Value  = ALLTRIM(Descs)
1843:                 ENDIF
1844:             ENDIF
1845:         ELSE
1846:             loc_oCnt.txt_4c_Linha.Value = ""
1847:             loc_oCnt.txt_4c_DLin.Value  = ""
1848:         ENDIF
1849: 
1850:         IF USED("cursor_4c_LinBusca")
1851:             USE IN cursor_4c_LinBusca
1852:         ENDIF
1853:         loc_oForm.Release()
1854:         THIS.AtualizarEstadoCampos()
1855:     ENDPROC
1856: 
1857:     *--------------------------------------------------------------------------
1858:     PROTECTED PROCEDURE ValidarLinha(par_cCodigo)
1859:         LOCAL loc_oCnt, loc_cSQL, loc_nResult
1860:         loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
1861:         loc_cSQL = "SELECT Linhas, Descs FROM SigCdLin WHERE Linhas = " + ;
1862:                    EscaparSQL(par_cCodigo)
1863:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LinVal")
1864:         IF loc_nResult > 0
1865:             SELECT cursor_4c_LinVal
1866:             IF !EOF()
1867:                 loc_oCnt.txt_4c_DLin.Value   = ALLTRIM(Descs)
1868:                 loc_oCnt.txt_4c_DLin.ReadOnly = .T.
1869:             ELSE
1870:                 USE IN cursor_4c_LinVal
1871:                 THIS.AbrirBuscaLinha()
1872:                 RETURN
1873:             ENDIF
1874:             USE IN cursor_4c_LinVal
1875:         ELSE
1876:             MsgAviso("Erro ao buscar linha", "Aviso")
1877:         ENDIF
1878:         THIS.AtualizarEstadoCampos()
1879:     ENDPROC
1880: 

*-- Linhas 1903 a 1947:
1903: 
1904:         IF loc_oForm.this_lSelecionou
1905:             IF USED("cursor_4c_FornBusca")
1906:                 SELECT cursor_4c_FornBusca
1907:                 IF !EOF()
1908:                     loc_oCnt.txt_4c_Fornecedor.Value  = ALLTRIM(iclis)
1909:                     loc_oCnt.txt_4c_DFornecedor.Value = ALLTRIM(nomes)
1910:                 ENDIF
1911:             ENDIF
1912:         ELSE
1913:             loc_oCnt.txt_4c_Fornecedor.Value  = ""
1914:             loc_oCnt.txt_4c_DFornecedor.Value = ""
1915:         ENDIF
1916: 
1917:         IF USED("cursor_4c_FornBusca")
1918:             USE IN cursor_4c_FornBusca
1919:         ENDIF
1920:         loc_oForm.Release()
1921:         THIS.AtualizarEstadoCampos()
1922:     ENDPROC
1923: 
1924:     *--------------------------------------------------------------------------
1925:     PROTECTED PROCEDURE ValidarFornecedor(par_cCodigo)
1926:         LOCAL loc_oCnt, loc_cSQL, loc_nResult
1927:         loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
1928:         loc_cSQL = "SELECT iclis, nomes FROM SIGCDCLI WHERE iclis = " + ;
1929:                    EscaparSQL(par_cCodigo)
1930:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FornVal")
1931:         IF loc_nResult > 0
1932:             SELECT cursor_4c_FornVal
1933:             IF !EOF()
1934:                 loc_oCnt.txt_4c_DFornecedor.Value   = ALLTRIM(nomes)
1935:                 loc_oCnt.txt_4c_DFornecedor.ReadOnly = .T.
1936:             ELSE
1937:                 USE IN cursor_4c_FornVal
1938:                 THIS.AbrirBuscaFornecedor()
1939:                 RETURN
1940:             ENDIF
1941:             USE IN cursor_4c_FornVal
1942:         ELSE
1943:             MsgAviso("Erro ao buscar fornecedor", "Aviso")
1944:         ENDIF
1945:         THIS.AtualizarEstadoCampos()
1946:     ENDPROC
1947: 


### BO (C:\4c\projeto\app\classes\sigreatoBO.prg):
*==============================================================================
* SIGREATOBO.PRG
* Business Object - Relatorio de Analise de Estoque Por Tipo de Operacao
*
* Herda de RelatorioBase
* Tabelas: SigMvHst (movimentos), SigCdOpe (operacoes), SigCdTom (tipos),
*          SigCdPro (produtos), SigCdGrp (grupos), SigCdCeg (contas estoque)
* Relatorios: SigReAto.frx (sem imagem) / SigReAtu.frx (com imagem)
*==============================================================================

DEFINE CLASS sigreatoBO AS RelatorioBase

    *-- Filtros de periodo
    this_dDtInicial            = {}
    this_dDtFinal              = {}

    *-- Filtro de grupo (SigCdGrp - CGrus/DGrus, MaxLength=3)
    this_cGrupo                = ""
    this_cDGrupo               = ""

    *-- Filtro de produto (SigCdPro - CPros/DPros, MaxLength=14)
    this_cCPros                = ""
    this_cDPros                = ""

    *-- Filtro de linha (SigCdLin - Linhas/Descs, MaxLength=10)
    this_cLin                  = ""
    this_cDLin                 = ""

    *-- Filtro de fornecedor (MaxLength=10 codigo, MaxLength=40 descricao)
    this_cFornecedor           = ""
    this_cDFornecedor          = ""

    *-- Opcao de imagem: .T.=Com Imagem (optImagem.Value=1), .F.=Sem Imagem
    this_lImagem               = .F.

    *-- Tipo de relatorio: 1=Analitico, 2=Sintetico (optTipos)
    this_nTipos                = 1

    *-- Filtro de diferencas: 1=Ignorar, 2=Sem Diferenca, 3=Positiva, 4=Negativa
    this_nDiferenca            = 1

    *-- Mensagem de validacao de parametros (TrataErro do legado)
    this_cTrataErro            = ""

    *-- Cursor principal de saida do relatorio
    this_cCursorDados          = "crImpressao"

    *-- Nomes dos cursores de referencia carregados em InicializarDados
    this_cCursorOperacoesE     = "cursor_4c_OperacoesE"
    this_cCursorOperacoesS     = "cursor_4c_OperacoesS"
    this_cCursorSigCdCeg       = "cursor_4c_SigCdCeg"

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO com valores padrao identicos ao legado
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_dDtInicial = DATE()
        THIS.this_dDtFinal   = DATE()
        THIS.this_nTipos     = 1
        THIS.this_nDiferenca = 1
        THIS.this_lImagem    = .F.
        THIS.this_cTrataErro = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores de referencia
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_aCursors(7), loc_nI
        loc_aCursors(1) = "cursor_4c_OperacoesE"
        loc_aCursors(2) = "cursor_4c_OperacoesS"
        loc_aCursors(3) = "cursor_4c_SigCdCeg"
        loc_aCursors(4) = "crImpressao"
        loc_aCursors(5) = "cursor_4c_Prods"
        loc_aCursors(6) = "cursor_4c_Entradas"
        loc_aCursors(7) = "cursor_4c_Saidas"
        FOR loc_nI = 1 TO 7
            IF USED(loc_aCursors(loc_nI))
                USE IN (loc_aCursors(loc_nI))
            ENDIF
        ENDFOR
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarDados - Carrega cursores de referencia usados pelo Form
    * Chamado no InicializarForm() do Formsigreato.
    * Cria:
    *   cursor_4c_OperacoesE : SelImp L, Codigos N(2), Descrs C(30)
    *     pre-seleciona Codigos=3 (entrada padrao)
    *   cursor_4c_OperacoesS : SelImp L, Codigos N(2), Descrs C(30)
    *     pre-seleciona Codigos=6 (saida padrao)
    *   cursor_4c_SigCdCeg   : lMarca L, Grupos C(10), Contas C(10)
    *     todos com lMarca=.F. (usuario marca quais incluir)
    *--------------------------------------------------------------------------
    PROCEDURE InicializarDados()
        LOCAL loc_lSucesso, loc_nResult, loc_oErro

        loc_lSucesso = .F.

        TRY
            *-- 1. Tipos de operacao (SigCdTom) -> cursor_4c_OperacoesE e cursor_4c_OperacoesS
            IF USED("cursor_4c_TomTmp")
                USE IN cursor_4c_TomTmp
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Codigos, Descrs FROM SigCdTom ORDER BY Codigos", ;
                "cursor_4c_TomTmp")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar Tipos de Opera" + CHR(231) + CHR(245) + "es"
                loc_lSucesso = .F.
            ENDIF

            IF USED("cursor_4c_OperacoesE")
                USE IN cursor_4c_OperacoesE
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_OperacoesE (SelImp L(1), Codigos N(2,0), Descrs C(30))
            SET NULL OFF
            INDEX ON Codigos TAG Codigos

            IF USED("cursor_4c_OperacoesS")
                USE IN cursor_4c_OperacoesS
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_OperacoesS (SelImp L(1), Codigos N(2,0), Descrs C(30))
            SET NULL OFF
            INDEX ON Codigos TAG Codigos

            SELECT cursor_4c_TomTmp
            GO TOP
            SCAN
                *-- Tipos=3 pre-selecionados em Entrada, Tipos=6 em Saida (padrao legado)
                INSERT INTO cursor_4c_OperacoesE (SelImp, Codigos, Descrs) ;
                    VALUES (cursor_4c_TomTmp.Codigos = 3, cursor_4c_TomTmp.Codigos, ;
                            ALLTRIM(cursor_4c_TomTmp.Descrs))
                INSERT INTO cursor_4c_OperacoesS (SelImp, Codigos, Descrs) ;
                    VALUES (cursor_4c_TomTmp.Codigos = 6, cursor_4c_TomTmp.Codigos, ;
                            ALLTRIM(cursor_4c_TomTmp.Descrs))
            ENDSCAN
            USE IN cursor_4c_TomTmp

            GO TOP IN cursor_4c_OperacoesE
            GO TOP IN cursor_4c_OperacoesS

            *-- 2. Contas de estoque (SigCdCeg) -> cursor_4c_SigCdCeg
            IF USED("cursor_4c_CegTmp")
                USE IN cursor_4c_CegTmp
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Grupos, Contas FROM SigCdCeg ORDER BY Grupos, Contas", ;
                "cursor_4c_CegTmp")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar Contas de Estoque (SigCdCeg)"
                loc_lSucesso = .F.
            ENDIF

            IF USED("cursor_4c_SigCdCeg")
                USE IN cursor_4c_SigCdCeg
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_SigCdCeg (lMarca L(1), Grupos C(10), Contas C(10))
            SET NULL OFF
            INDEX ON Grupos + Contas TAG GruContas

            SELECT cursor_4c_CegTmp
            GO TOP
            SCAN
                INSERT INTO cursor_4c_SigCdCeg (lMarca, Grupos, Contas) ;
                    VALUES (.F., ALLTRIM(cursor_4c_CegTmp.Grupos), ALLTRIM(cursor_4c_CegTmp.Contas))
            ENDSCAN
            USE IN cursor_4c_CegTmp

            SELECT cursor_4c_SigCdCeg
            SET ORDER TO TAG GruContas
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em InicializarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarParametros - Valida entradas antes de PrepararDados
    * Preenche this_cTrataErro com identificador do erro (equivale ao
    * ValidaBotoes/loObj.TrataErro do legado).
    * Retorna .T. se OK, .F. se ha erro (mensagem em this_cTrataErro).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarParametros()
        THIS.this_cTrataErro = ""

        IF EMPTY(THIS.this_dDtInicial)
            THIS.this_cTrataErro = "DataInicial"
            THIS.this_cMensagemErro = "Data Inicial Inv" + CHR(225) + "lida!!!"
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_dDtFinal)
            THIS.this_cTrataErro = "DataFinal"
            THIS.this_cMensagemErro = "Data Final Inv" + CHR(225) + "lida!!!"
            RETURN .F.
        ENDIF

        IF THIS.this_dDtFinal < THIS.this_dDtInicial
            THIS.this_cTrataErro = "Final < Inicial"
            THIS.this_cMensagemErro = "A Data Final N" + CHR(227) + "o Pode Ser Menor Que a Inicial!!!"
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarListaTipos - Constroi string "(cod1,cod2,...)" de Codigos marcados
    * par_cCursor: nome do cursor (cursor_4c_OperacoesE ou cursor_4c_OperacoesS)
    * Retorna string IN ex: "(3,6)" ou "" se nenhum selecionado
    *--------------------------------------------------------------------------
    PROCEDURE MontarListaTipos(par_cCursor)
        LOCAL loc_cLista

        loc_cLista = ""

        IF !USED(par_cCursor)
            RETURN ""
        ENDIF

        SELECT (par_cCursor)
        GO TOP
        SCAN
            IF SelImp
                loc_cLista = loc_cLista + IIF(EMPTY(loc_cLista), "", ",") + ;
                             ALLTRIM(STR(Codigos, 2))
            ENDIF
        ENDSCAN

        IF !EMPTY(loc_cLista)
            loc_cLista = "(" + loc_cLista + ")"
        ENDIF

        RETURN loc_cLista
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarListaContas - Constroi string de contas marcadas em cursor_4c_SigCdCeg
    * Retorna string IN ex: "('GRP1ACC1','GRP2ACC2')" ou "" se nenhuma marcada
    *--------------------------------------------------------------------------
    PROCEDURE MontarListaContas()
        LOCAL loc_cLista

        loc_cLista = ""

        IF !USED("cursor_4c_SigCdCeg")
            RETURN ""
        ENDIF

        SELECT cursor_4c_SigCdCeg
        GO TOP
        SCAN
            IF lMarca
                loc_cLista = loc_cLista + IIF(EMPTY(loc_cLista), "", ",") + ;
                             "'" + ALLTRIM(Grupos) + ALLTRIM(Contas) + "'"
            ENDIF
        ENDSCAN

        IF !EMPTY(loc_cLista)
            loc_cLista = "(" + loc_cLista + ")"
        ENDIF

        RETURN loc_cLista
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa processamento completo gerando cursor crImpressao
    *
    * Estrutura de crImpressao (por produto):
    *   Linha header (Ordem='0000000001'): dados do produto, Entradas, Saidas
    *   Linhas conta (Ordem='0000000002',...): Estos=Grupo+Conta, Estoques=saldo liq
    *   Linha total  (Estos='Total :   '): soma de Estoques, Diferencas
    *
    * Entradas = soma Qtds em SigMvHst onde TipoOps (via SigCdOpe) in E-selecionados
    * Saidas   = soma Qtds em SigMvHst onde TipoOps (via SigCdOpe) in S-selecionados
    * Estoques = saldo liquido por conta (SigMvHst: E+qtd, S-qtd) no periodo
    * Diferencas = Entradas - Saidas - SUM(Estoques por conta)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cEmp, loc_cDtI, loc_cDtF
        LOCAL loc_cInCodE, loc_cInCodS, loc_cInContas
        LOCAL loc_nResult, loc_cSQL, loc_cWhere
        LOCAL loc_nEntradas, loc_nSaidas, loc_nTotalEst, loc_nDif
        LOCAL loc_nOrdem, loc_cCPros
        LOCAL loc_nEstCount, loc_nEstLine

        loc_lSucesso = .F.

        TRY
            *-- Validar parametros
            IF !THIS.ValidarParametros()
                loc_lSucesso = .F.
            ENDIF

            loc_cEmp = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            loc_cDtI = FormatarDataSQL(THIS.this_dDtInicial)
            loc_cDtF = FormatarDataSQL(THIS.this_dDtFinal)

            *-- Montar listas de tipos selecionados
            loc_cInCodE = THIS.MontarListaTipos("cursor_4c_OperacoesE")
            IF EMPTY(loc_cInCodE)
                THIS.this_cMensagemErro = "Nenhum Tipo de Opera" + CHR(231) + CHR(227) + ;
                                          "o de Entrada Foi Selecionado!!!"
                loc_lSucesso = .F.
            ENDIF

            loc_cInCodS = THIS.MontarListaTipos("cursor_4c_OperacoesS")
            IF EMPTY(loc_cInCodS)
                THIS.this_cMensagemErro = "Nenhum Tipo de Opera" + CHR(231) + CHR(227) + ;
                                          "o de Sa" + CHR(237) + "da Foi Selecionado!!!"
                loc_lSucesso = .F.
            ENDIF

            loc_cInContas = THIS.MontarListaContas()

            *-- Recriar crImpressao
            IF USED("crImpressao")
                USE IN crImpressao
            ENDIF
            CREATE CURSOR crImpressao (CPros C(14), DPros C(40), Reffs C(15), ;
                CGrus C(3), Linhas C(10), IFors C(10), Ordem C(10), ;
                Estos C(30), Imagem M, Pvens N(14,2), Moevs C(3), ;
                Entradas N(14,3), Saidas N(14,3), Grupos C(30), ;
                Margems N(9,6), Estoques N(14,3), Diferencas N(14,3))

            *-- Limpar cursores temporarios de execucao anterior
            LOCAL loc_aTmp(4), loc_nT
            loc_aTmp(1) = "cursor_4c_Prods"
            loc_aTmp(2) = "cursor_4c_Entradas"
            loc_aTmp(3) = "cursor_4c_Saidas"
            loc_aTmp(4) = "cursor_4c_EstContas"
            FOR loc_nT = 1 TO 4
                IF USED(loc_aTmp(loc_nT))
                    USE IN (loc_aTmp(loc_nT))
                ENDIF
            ENDFOR

            *-- Query 1: Produtos com movimentos no periodo (E ou S selecionados)
            loc_cSQL = "SELECT DISTINCT p.CPros, p.DPros, p.Reffs, p.CGrus, p.Linhas," + ;
                       " p.IFors, p.Pvens, p.Moevs, p.Margems," + ;
                       " ISNULL(g.DGrus,'') AS DGrus" + ;
                       " FROM SigCdPro p" + ;
                       " LEFT JOIN SigCdGrp g ON g.CGrus = p.CGrus" + ;
                       " WHERE p.CPros IN" + ;
                       " (SELECT h.Cpros FROM SigMvHst h" + ;
                       " INNER JOIN SigCdOpe o ON h.Dopes = o.Dopes" + ;
                       " WHERE h.Emps = " + EscaparSQL(loc_cEmp) + ;
                       " AND h.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF + ;
                       " AND CAST(o.TipoOps AS INT) IN " + loc_cInCodE + ;
                       " UNION" + ;
                       " SELECT h.Cpros FROM SigMvHst h" + ;
                       " INNER JOIN SigCdOpe o ON h.Dopes = o.Dopes" + ;
                       " WHERE h.Emps = " + EscaparSQL(loc_cEmp) + ;
                       " AND h.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF + ;
                       " AND CAST(o.TipoOps AS INT) IN " + loc_cInCodS + ")"

            *-- Filtros adicionais de produto
            IF !EMPTY(ALLTRIM(THIS.this_cGrupo))
                loc_cSQL = loc_cSQL + ;
                           " AND p.CGrus = " + EscaparSQL(ALLTRIM(THIS.this_cGrupo))
            ENDIF
            IF !EMPTY(ALLTRIM(THIS.this_cCPros))
                loc_cSQL = loc_cSQL + ;
                           " AND p.CPros = " + EscaparSQL(ALLTRIM(THIS.this_cCPros))
            ENDIF
            IF !EMPTY(ALLTRIM(THIS.this_cLin))
                loc_cSQL = loc_cSQL + ;
                           " AND p.Linhas = " + EscaparSQL(ALLTRIM(THIS.this_cLin))
            ENDIF
            IF !EMPTY(ALLTRIM(THIS.this_cFornecedor))
                loc_cSQL = loc_cSQL + ;
                           " AND p.IFors = " + EscaparSQL(ALLTRIM(THIS.this_cFornecedor))
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY p.DPros, p.CPros"

            WAIT WINDOW "Selecionando produtos..." NOWAIT
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Prods")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar produtos"
                loc_lSucesso = .F.
            ENDIF

            *-- Query 2: Total Entradas por produto (tipos E selecionados)
            loc_cSQL = "SELECT h.Cpros, SUM(h.Qtds) AS Total" + ;
                       " FROM SigMvHst h" + ;
                       " INNER JOIN SigCdOpe o ON h.Dopes = o.Dopes" + ;
                       " WHERE h.Emps = " + EscaparSQL(loc_cEmp) + ;
                       " AND h.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF + ;
                       " AND CAST(o.TipoOps AS INT) IN " + loc_cInCodE + ;
                       " GROUP BY h.Cpros"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Entradas")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao calcular entradas"
                loc_lSucesso = .F.
            ENDIF
            IF USED("cursor_4c_Entradas")
                SELECT cursor_4c_Entradas
                INDEX ON Cpros TAG Cpros
            ENDIF

            *-- Query 3: Total Saidas por produto (tipos S selecionados)
            loc_cSQL = "SELECT h.Cpros, SUM(h.Qtds) AS Total" + ;
                       " FROM SigMvHst h" + ;
                       " INNER JOIN SigCdOpe o ON h.Dopes = o.Dopes" + ;
                       " WHERE h.Emps = " + EscaparSQL(loc_cEmp) + ;
                       " AND h.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF + ;
                       " AND CAST(o.TipoOps AS INT) IN " + loc_cInCodS + ;
                       " GROUP BY h.Cpros"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Saidas")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao calcular sa" + CHR(237) + "das"
                loc_lSucesso = .F.
            ENDIF
            IF USED("cursor_4c_Saidas")
                SELECT cursor_4c_Saidas
                INDEX ON Cpros TAG Cpros
            ENDIF

            *-- Query 4: Saldo liquido por produto/conta no periodo
            loc_cSQL = "SELECT h.Cpros, h.Grupos, h.Estos," + ;
                       " SUM(IIF(h.Opers='E', h.Qtds, -h.Qtds)) AS Estoques" + ;
                       " FROM SigMvHst h" + ;
                       " WHERE h.Emps = " + EscaparSQL(loc_cEmp) + ;
                       " AND h.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF

            IF !EMPTY(loc_cInContas)
                loc_cSQL = loc_cSQL + ;
                           " AND (RTRIM(h.Grupos) + RTRIM(h.Estos)) IN " + loc_cInContas
            ENDIF
            loc_cSQL = loc_cSQL + " GROUP BY h.Cpros, h.Grupos, h.Estos" + ;
                                  " ORDER BY h.Cpros, h.Grupos, h.Estos"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EstContas")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao calcular saldo de estoques"
                loc_lSucesso = .F.
            ENDIF
            IF USED("cursor_4c_EstContas")
                SELECT cursor_4c_EstContas
                INDEX ON Cpros TAG Cpros
                GO TOP
            ENDIF

            *-- Iterar produtos e montar crImpressao
            WAIT WINDOW "Processando relat" + CHR(243) + "rio..." NOWAIT

            SELECT cursor_4c_Prods
            GO TOP

            SCAN
                loc_cCPros = PADR(ALLTRIM(cursor_4c_Prods.CPros), 14)

                *-- Entradas deste produto
                loc_nEntradas = 0
                IF USED("cursor_4c_Entradas")
                    SELECT cursor_4c_Entradas
                    IF SEEK(loc_cCPros, "cursor_4c_Entradas", "Cpros")
                        loc_nEntradas = NVL(cursor_4c_Entradas.Total, 0)
                    ENDIF
                ENDIF

                *-- Saidas deste produto
                loc_nSaidas = 0
                IF USED("cursor_4c_Saidas")
                    SELECT cursor_4c_Saidas
                    IF SEEK(loc_cCPros, "cursor_4c_Saidas", "Cpros")
                        loc_nSaidas = NVL(cursor_4c_Saidas.Total, 0)
                    ENDIF
                ENDIF

                *-- Linhas de conta para este produto
                LOCAL loc_aEst(1,3)
                loc_nEstCount = 0
                loc_nTotalEst = 0

                IF USED("cursor_4c_EstContas")
                    SELECT cursor_4c_EstContas
                    LOCATE FOR Cpros = loc_cCPros
                    SCAN WHILE Cpros = loc_cCPros
                        loc_nEstCount = loc_nEstCount + 1
                        DIMENSION loc_aEst(loc_nEstCount, 3)
                        loc_aEst[loc_nEstCount, 1] = ALLTRIM(cursor_4c_EstContas.Grupos)
                        loc_aEst[loc_nEstCount, 2] = ALLTRIM(cursor_4c_EstContas.Estos)
                        loc_aEst[loc_nEstCount, 3] = NVL(cursor_4c_EstContas.Estoques, 0)
                        loc_nTotalEst = loc_nTotalEst + NVL(cursor_4c_EstContas.Estoques, 0)
                    ENDSCAN
                ENDIF

                *-- Diferenca = Entradas - Saidas - SomEstoques
                loc_nDif = loc_nEntradas - loc_nSaidas - loc_nTotalEst

                *-- Aplicar filtro optDiferencas
                DO CASE
                    CASE THIS.this_nDiferenca = 2
                        IF ABS(loc_nDif) > 0.001
                            LOOP
                        ENDIF
                    CASE THIS.this_nDiferenca = 3
                        IF loc_nDif <= 0.001
                            LOOP
                        ENDIF
                    CASE THIS.this_nDiferenca = 4
                        IF loc_nDif >= -0.001
                            LOOP
                        ENDIF
                ENDCASE

                *-- Linha header do produto (Ordem='0000000001')
                SELECT crImpressao
                INSERT INTO crImpressao (CPros, DPros, Reffs, CGrus, Linhas, IFors, ;
                    Ordem, Pvens, Moevs, Entradas, Saidas, Grupos, Margems) ;
                    VALUES (loc_cCPros, ;
                        PADR(ALLTRIM(cursor_4c_Prods.DPros), 40), ;
                        PADR(ALLTRIM(cursor_4c_Prods.Reffs), 15), ;
                        PADR(ALLTRIM(cursor_4c_Prods.CGrus), 3), ;
                        PADR(ALLTRIM(cursor_4c_Prods.Linhas), 10), ;
                        PADR(ALLTRIM(cursor_4c_Prods.IFors), 10), ;
                        "0000000001", ;
                        NVL(cursor_4c_Prods.Pvens, 0), ;
                        PADR(ALLTRIM(cursor_4c_Prods.Moevs), 3), ;
                        loc_nEntradas, loc_nSaidas, ;
                        PADR(ALLTRIM(cursor_4c_Prods.DGrus), 30), ;
                        NVL(cursor_4c_Prods.Margems, 0))

                *-- Linhas de conta (Ordem='0000000002', '0000000003', ...)
                loc_nOrdem = 2
                FOR loc_nEstLine = 1 TO loc_nEstCount
                    SELECT crImpressao
                    INSERT INTO crImpressao (CPros, Ordem, Estos, Estoques) ;
                        VALUES (loc_cCPros, ;
                            PADL(ALLTRIM(STR(loc_nOrdem)), 10, "0"), ;
                            PADR(loc_aEst[loc_nEstLine,1] + " " + ;
                                 loc_aEst[loc_nEstLine,2], 30), ;
                            loc_aEst[loc_nEstLine,3])
                    loc_nOrdem = loc_nOrdem + 1
                ENDFOR

                *-- Linha total (Estos='Total :   ')
                SELECT crImpressao
                INSERT INTO crImpressao (CPros, Ordem, Estos, Estoques, Diferencas) ;
                    VALUES (loc_cCPros, ;
                        "9999999999", ;
                        PADR("Total :   ", 30), ;
                        loc_nTotalEst, loc_nDif)

            ENDSCAN

            WAIT CLEAR

            SELECT crImpressao
            GO TOP

            loc_lSucesso = (RECCOUNT("crImpressao") > 0)
            IF !loc_lSucesso
                THIS.this_cMensagemErro = "Nenhum dado encontrado para os filtros informados"
            ENDIF

        CATCH TO loc_oErro
            WAIT CLEAR
            MsgErro(loc_oErro.Message, "Erro em PrepararDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarCursorExcel - Prepara cursor csExcell para exportacao
    * Analogo ao evento "documentoexcel" do legado.
    * Chama PrepararDados antes de montar o cursor de exportacao.
    *--------------------------------------------------------------------------
    PROCEDURE MontarCursorExcel()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            IF USED("csExcell")
                USE IN csExcell
            ENDIF

            IF THIS.this_nTipos = 1
                *-- Analitico: linha por produto/conta com IIF para suprimir valores nas linhas de conta
                SELECT IIF(crImpressao.Ordem = "0000000001", ALLTRIM(crImpressao.CPros), ;
                           SPACE(14)) AS Codigo, ;
                       IIF(crImpressao.Ordem = "0000000001", ALLTRIM(crImpressao.DPros), ;
                           SPACE(40)) AS Descricao, ;
                       IIF(crImpressao.Ordem = "0000000001", ALLTRIM(crImpressao.Reffs), ;
                           SPACE(15)) AS Referencia, ;
                       IIF(crImpressao.Ordem = "0000000001", ALLTRIM(crImpressao.CGrus), ;
                           SPACE(3)) AS Grp, ;
                       IIF(crImpressao.Ordem = "0000000001", ALLTRIM(crImpressao.Linhas), ;
                           SPACE(10)) AS Linha, ;
                       IIF(crImpressao.Ordem = "0000000001", ALLTRIM(crImpressao.IFors), ;
                           SPACE(10)) AS Fornecedor, ;
                       IIF(crImpressao.Ordem = "0000000001", crImpressao.Margems, 0) AS Markup, ;
                       IIF(crImpressao.Ordem = "0000000001", crImpressao.Entradas, 0) AS Entradas, ;
                       IIF(crImpressao.Ordem = "0000000001", crImpressao.Saidas, 0) AS Saidas, ;
                       IIF(crImpressao.Ordem = "0000000001", ;
                           crImpressao.Entradas - crImpressao.Saidas, 0) AS Saldo, ;
                       ALLTRIM(crImpressao.Grupos) AS Grupos, ;
                       ALLTRIM(crImpressao.Estos) AS Contas, ;
                       crImpressao.Estoques AS Qtde, ;
                       IIF(ALLTRIM(crImpressao.Estos) = "Total :   ", crImpressao.Diferencas, ;
                           0) AS Diferencas ;
                  FROM crImpressao ;
                  INTO CURSOR csExcell READWRITE
            ELSE
                *-- Sintetico: apenas linha header por produto
                SELECT ALLTRIM(crImpressao.CPros) AS Codigo, ;
                       ALLTRIM(crImpressao.DPros) AS Descricao, ;
                       ALLTRIM(crImpressao.Reffs) AS Referencia, ;
                       ALLTRIM(crImpressao.CGrus) AS Grp, ;
                       ALLTRIM(crImpressao.Linhas) AS Linha, ;
                       ALLTRIM(crImpressao.IFors) AS Fornecedor, ;
                       crImpressao.Margems AS Markup, ;
                       crImpressao.Entradas AS Entradas, ;
                       crImpressao.Saidas AS Saidas, ;
                       crImpressao.Entradas - crImpressao.Saidas AS Saldo, ;
                       crImpressao.Estoques AS Qtde, ;
                       crImpressao.Diferencas AS Diferencas ;
                  FROM crImpressao ;
                 WHERE crImpressao.Estos = PADR("Total :   ", 30) ;
                  INTO CURSOR csExcell READWRITE
            ENDIF

            SELECT csExcell
            GO TOP
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao montar cursor Excel")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro, loc_cFRX
        LOCAL loc_cCursorSel1, loc_cCursorSel2

        loc_lSucesso = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            IF THIS.this_lImagem
                *-- Com imagem: monta Selecao intermediaria
                THIS.MontarSelecaoComImagem()
                loc_cFRX = gc_4c_CaminhoReports + "SigReAtu"
                SELECT Selecao
                GO TOP
            ELSE
                loc_cFRX = gc_4c_CaminhoReports + "SigReAto"
                SELECT crImpressao
                GO TOP
            ENDIF

            REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao visualizar relat" + CHR(243) + "rio")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro, loc_cFRX

        loc_lSucesso = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            IF THIS.this_lImagem
                THIS.MontarSelecaoComImagem()
                loc_cFRX = gc_4c_CaminhoReports + "SigReAtu"
                SELECT Selecao
                GO TOP
            ELSE
                loc_cFRX = gc_4c_CaminhoReports + "SigReAto"
                SELECT crImpressao
                GO TOP
            ENDIF

            REPORT FORM (loc_cFRX) TO PRINT PROMPT NOCONSOLE
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao imprimir relat" + CHR(243) + "rio")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarSelecaoComImagem - Prepara cursor Selecao para SigReAtu.frx
    * Equivale ao bloco "If (optImagem.Value=1)" dos eventos impressao/visualizacao
    * do legado. Usa crImpressao (deve estar populado por PrepararDados).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarSelecaoComImagem()
        LOCAL loc_oErro
        TRY
            IF USED("Selecao1")
                USE IN Selecao1
            ENDIF
            IF USED("Selecao2")
                USE IN Selecao2
            ENDIF
            IF USED("Selecao")
                USE IN Selecao
            ENDIF

            SELECT CPros, DPros, Reffs, CGrus, Linhas, IFors, Ordem, Estos, ;
                   Imagem, Pvens, Moevs, Entradas, Saidas, Grupos, Margems ;
              FROM crImpressao ;
             WHERE Ordem = "0000000001" ;
              INTO CURSOR Selecao1

            SELECT CPros, SUM(Estoques) AS Estoques ;
              FROM crImpressao ;
             WHERE ALLTRIM(Estos) = "Total :   " ;
             GROUP BY CPros ;
              INTO CURSOR Selecao2

            SELECT a.*, b.Estoques ;
              FROM Selecao1 a, Selecao2 b ;
             WHERE a.CPros = b.CPros ;
             ORDER BY a.CPros ;
              INTO CURSOR Selecao READWRITE

            SELECT Selecao
            GO TOP
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em MontarSelecaoComImagem")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro da ultima operacao
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave composta de filtros para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN DTOC(THIS.this_dDtInicial) + "|" + DTOC(THIS.this_dDtFinal) + "|" + ;
               ALLTRIM(THIS.this_cGrupo) + "|" + ALLTRIM(THIS.this_cCPros) + "|" + ;
               ALLTRIM(THIS.this_cLin) + "|" + ALLTRIM(THIS.this_cFornecedor) + "|" + ;
               STR(THIS.this_nTipos, 1) + "|" + STR(THIS.this_nDiferenca, 1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ExportarExcel - Prepara dados e exporta cursor para planilha Excel (XL5)
    *   Usa PUTFILE para escolha interativa do arquivo destino.
    *--------------------------------------------------------------------------
    PROCEDURE ExportarExcel()
        LOCAL loc_lResultado, loc_cArquivo, loc_lSafetyEra
        loc_lResultado = .F.
        TRY
            IF THIS.MontarCursorExcel()
                loc_cArquivo = PUTFILE("Exportar para Excel", "AnEstTpOpe.xls", "xls")
                IF !EMPTY(loc_cArquivo)
                    IF LOWER(RIGHT(loc_cArquivo, 4)) != ".xls"
                        loc_cArquivo = loc_cArquivo + ".xls"
                    ENDIF
                    SELECT csExcell
                    loc_lSafetyEra = (SET("SAFETY") = "ON")
                    SET SAFETY OFF
                    COPY TO (loc_cArquivo) TYPE XL5
                    IF loc_lSafetyEra
                        SET SAFETY ON
                    ENDIF
                    THIS.RegistrarAuditoria("EXCEL")
                    MsgInfo("Arquivo exportado com sucesso!", ;
                            "Informa" + CHR(231) + CHR(227) + "o")
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao exportar: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("csExcell")
            USE IN csExcell
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Nao aplicavel a relatorios
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel a relatorios
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                                  "o aplic" + CHR(225) + "vel a relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel a relatorios
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                                  "o aplic" + CHR(225) + "vel a relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

ENDDEFINE

