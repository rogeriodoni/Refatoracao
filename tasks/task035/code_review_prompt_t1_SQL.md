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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreato.prg) - TRECHOS RELEVANTES PARA PASS SQL (2030 linhas total):

*-- Linhas 771 a 806:
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

*-- Linhas 827 a 862:
827:             .Enabled   = .T.
828:         ENDWITH
829:         loc_oGrd.Column1.CurrentControl = "chk_4c_Marca"
830:         loc_oGrd.Column1.ControlSource  = "cursor_4c_OperacoesE.SelImp"
831: 
832:         WITH loc_oGrd.Column2
833:             .Width         = 20
834:             .ControlSource = "cursor_4c_OperacoesE.Codigos"
835:             .ReadOnly      = .T.
836:             .Enabled       = .T.
837:             .Movable       = .F.
838:             .Resizable     = .F.
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

*-- Linhas 903 a 921:
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

*-- Linhas 942 a 977:
942:             .Enabled   = .T.
943:         ENDWITH
944:         loc_oGrd.Column1.CurrentControl = "chk_4c_Marca"
945:         loc_oGrd.Column1.ControlSource  = "cursor_4c_OperacoesS.SelImp"
946: 
947:         WITH loc_oGrd.Column2
948:             .Width         = 20
949:             .ControlSource = "cursor_4c_OperacoesS.Codigos"
950:             .ReadOnly      = .T.
951:             .Enabled       = .T.
952:             .Movable       = .F.
953:             .Resizable     = .F.
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

*-- Linhas 1018 a 1036:
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

*-- Linhas 1057 a 1092:
1057:             .Enabled   = .T.
1058:         ENDWITH
1059:         loc_oGrd.Column1.CurrentControl = "chk_4c_Marca"
1060:         loc_oGrd.Column1.ControlSource  = "cursor_4c_SigCdCeg.lMarca"
1061: 
1062:         WITH loc_oGrd.Column2
1063:             .Width         = 80
1064:             .ControlSource = "cursor_4c_SigCdCeg.Grupos"
1065:             .ReadOnly      = .T.
1066:             .Enabled       = .T.
1067:             .Movable       = .F.
1068:             .Resizable     = .F.
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

*-- Linhas 1320 a 1374:
1320:         loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
1321: 
1322:         IF USED("cursor_4c_OperacoesE")
1323:             SELECT Codigos FROM cursor_4c_OperacoesE WHERE SelImp INTO CURSOR cursor_4c_TmpE READWRITE
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
1359:                 (SELECT cursor_4c_TmpS.Codigos FROM cursor_4c_TmpS) ;
1360:                 INTO CURSOR cursor_4c_TmpDup READWRITE
1361:             IF RECCOUNT("cursor_4c_TmpDup") > 0
1362:                 MsgAviso("Foram Selecionados Tipos de Opera" + CHR(231) + CHR(245) + "es de Entrada e Sa" + CHR(237) + "da Iguais!!!", ;
1363:                     "Aten" + CHR(231) + CHR(227) + "o")
1364:                 loc_lOK = .F.
1365:             ENDIF
1366:             IF USED("cursor_4c_TmpDup")
1367:                 USE IN cursor_4c_TmpDup
1368:             ENDIF
1369:         ENDIF
1370: 
1371:         IF USED("cursor_4c_TmpE")
1372:             USE IN cursor_4c_TmpE
1373:         ENDIF
1374:         IF USED("cursor_4c_TmpS")

*-- Linhas 1617 a 1675:
1617:             RETURN
1618:         ENDIF
1619:         IF loc_oCnt.cmd_4c_BtnGradeE.Value = 1
1620:             SELECT cursor_4c_OperacoesE
1621:             REPLACE ALL SelImp WITH .T.
1622:             GO TOP
1623:         ELSE
1624:             SELECT cursor_4c_OperacoesE
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

*-- Linhas 1693 a 1737:
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
1707:         IF USED("cursor_4c_GrupoBusca")
1708:             USE IN cursor_4c_GrupoBusca
1709:         ENDIF
1710:         loc_oForm.Release()
1711:         THIS.AtualizarEstadoCampos()
1712:     ENDPROC
1713: 
1714:     *--------------------------------------------------------------------------
1715:     PROTECTED PROCEDURE ValidarGrupo(par_cCodigo)
1716:         LOCAL loc_oCnt, loc_cSQL, loc_nResult
1717:         loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
1718:         loc_cSQL = "SELECT CGrus, DGrus FROM SigCdGrp WHERE CGrus = " + ;
1719:                    EscaparSQL(par_cCodigo)
1720:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoVal")
1721:         IF loc_nResult > 0
1722:             SELECT cursor_4c_GrupoVal
1723:             IF !EOF()
1724:                 loc_oCnt.txt_4c_DGrupo.Value   = ALLTRIM(DGrus)
1725:                 loc_oCnt.txt_4c_DGrupo.ReadOnly = .T.
1726:             ELSE
1727:                 USE IN cursor_4c_GrupoVal
1728:                 THIS.AbrirBuscaGrupo()
1729:                 RETURN
1730:             ENDIF
1731:             USE IN cursor_4c_GrupoVal
1732:         ELSE
1733:             MsgAviso("Erro ao buscar grupo", "Aviso")
1734:         ENDIF
1735:         THIS.AtualizarEstadoCampos()
1736:     ENDPROC
1737: 

*-- Linhas 1760 a 1804:
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
1774:         IF USED("cursor_4c_ProdBusca")
1775:             USE IN cursor_4c_ProdBusca
1776:         ENDIF
1777:         loc_oForm.Release()
1778:         THIS.AtualizarEstadoCampos()
1779:     ENDPROC
1780: 
1781:     *--------------------------------------------------------------------------
1782:     PROTECTED PROCEDURE ValidarProduto(par_cCodigo)
1783:         LOCAL loc_oCnt, loc_cSQL, loc_nResult
1784:         loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
1785:         loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE CPros = " + ;
1786:                    EscaparSQL(par_cCodigo)
1787:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdVal")
1788:         IF loc_nResult > 0
1789:             SELECT cursor_4c_ProdVal
1790:             IF !EOF()
1791:                 loc_oCnt.txt_4c_DPros.Value   = ALLTRIM(DPros)
1792:                 loc_oCnt.txt_4c_DPros.ReadOnly = .T.
1793:             ELSE
1794:                 USE IN cursor_4c_ProdVal
1795:                 THIS.AbrirBuscaProduto()
1796:                 RETURN
1797:             ENDIF
1798:             USE IN cursor_4c_ProdVal
1799:         ELSE
1800:             MsgAviso("Erro ao buscar produto", "Aviso")
1801:         ENDIF
1802:         THIS.AtualizarEstadoCampos()
1803:     ENDPROC
1804: 

*-- Linhas 1827 a 1871:
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
1841:         IF USED("cursor_4c_LinBusca")
1842:             USE IN cursor_4c_LinBusca
1843:         ENDIF
1844:         loc_oForm.Release()
1845:         THIS.AtualizarEstadoCampos()
1846:     ENDPROC
1847: 
1848:     *--------------------------------------------------------------------------
1849:     PROTECTED PROCEDURE ValidarLinha(par_cCodigo)
1850:         LOCAL loc_oCnt, loc_cSQL, loc_nResult
1851:         loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
1852:         loc_cSQL = "SELECT Linhas, Descs FROM SigCdLin WHERE Linhas = " + ;
1853:                    EscaparSQL(par_cCodigo)
1854:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LinVal")
1855:         IF loc_nResult > 0
1856:             SELECT cursor_4c_LinVal
1857:             IF !EOF()
1858:                 loc_oCnt.txt_4c_DLin.Value   = ALLTRIM(Descs)
1859:                 loc_oCnt.txt_4c_DLin.ReadOnly = .T.
1860:             ELSE
1861:                 USE IN cursor_4c_LinVal
1862:                 THIS.AbrirBuscaLinha()
1863:                 RETURN
1864:             ENDIF
1865:             USE IN cursor_4c_LinVal
1866:         ELSE
1867:             MsgAviso("Erro ao buscar linha", "Aviso")
1868:         ENDIF
1869:         THIS.AtualizarEstadoCampos()
1870:     ENDPROC
1871: 

*-- Linhas 1894 a 1938:
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
1908:         IF USED("cursor_4c_FornBusca")
1909:             USE IN cursor_4c_FornBusca
1910:         ENDIF
1911:         loc_oForm.Release()
1912:         THIS.AtualizarEstadoCampos()
1913:     ENDPROC
1914: 
1915:     *--------------------------------------------------------------------------
1916:     PROTECTED PROCEDURE ValidarFornecedor(par_cCodigo)
1917:         LOCAL loc_oCnt, loc_cSQL, loc_nResult
1918:         loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
1919:         loc_cSQL = "SELECT iclis, nomes FROM SIGCDCLI WHERE iclis = " + ;
1920:                    EscaparSQL(par_cCodigo)
1921:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FornVal")
1922:         IF loc_nResult > 0
1923:             SELECT cursor_4c_FornVal
1924:             IF !EOF()
1925:                 loc_oCnt.txt_4c_DFornecedor.Value   = ALLTRIM(nomes)
1926:                 loc_oCnt.txt_4c_DFornecedor.ReadOnly = .T.
1927:             ELSE
1928:                 USE IN cursor_4c_FornVal
1929:                 THIS.AbrirBuscaFornecedor()
1930:                 RETURN
1931:             ENDIF
1932:             USE IN cursor_4c_FornVal
1933:         ELSE
1934:             MsgAviso("Erro ao buscar fornecedor", "Aviso")
1935:         ENDIF
1936:         THIS.AtualizarEstadoCampos()
1937:     ENDPROC
1938: 


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
            CREATE CURSOR cursor_4c_OperacoesE (SelImp L(1), Codigos N(2,0), Descrs C(30))
            INDEX ON Codigos TAG Codigos

            IF USED("cursor_4c_OperacoesS")
                USE IN cursor_4c_OperacoesS
            ENDIF
            CREATE CURSOR cursor_4c_OperacoesS (SelImp L(1), Codigos N(2,0), Descrs C(30))
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
            CREATE CURSOR cursor_4c_SigCdCeg (lMarca L(1), Grupos C(10), Contas C(10))
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

