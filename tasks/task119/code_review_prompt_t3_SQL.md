# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DTBASES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNTIPO, LMARCA, EMPS, CODIGOS, APURAS, LCDATABASE, BARRAS, NUMS, CBARS

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
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  DeleteMark = .F.
=Seek(_Empr,'CrSigCdEmp','CEmps')
	Insert Into CsCabecalho (Empresa,Titulo,SubTitulo,DtBase) ;
	Insert Into CsCabecalho (Empresa,Titulo,SubTitulo,DtBase,DtBaseA) ;
If ThisForm.poDataMgr.SqlExecute([Select * From SigCdBal ],'CsBal') < 1
Select CsBal
	Select *,Left(Dtos(DtBases),6) As Bases From CsBal ;
	Select * From CsSigCdEmp Where lMarca = 1 Into Cursor CsEmps
	Select a.*,Left(Dtos(a.DtBases),6) As Bases ;
	From CsBal a, CsEmps b ;
	Select Balancos
		loBarra.Update(.T.,'Balanço nº ' + Alltrim(Str(Balancos.Codigos,4)))
		lStrQuery = [Select a.Emps,a.Codigos,a.Tipos,a.Produto,a.Barras,a.Apurado,a.Estoque,a.Falta,a.Sobra,a.Ocorrencia,a.Obs,]+;
					[From SigIvTrT a ]+;
					[Left Join SigCdPro b On b.CPros = a.Produto ]+;
					[Left Join SigOpEtq c On c.CBars = a.Barras ]+;
		If ThisForm.poDataMgr.SqlExecute(lStrQuery,'Tratamento') < 1
		Select Tratamento
		Select Tratamento
			loBarra2.Update(.T.)
			=Seek('O' + m.Ocorrencia,'CrSigBaOco','TipCods')
			=Seek(m.MoeCusFs,'CrSigCdMoe','CMoes')
			Insert Into CsRelatorio From MemVar
			Select Tratamento
		Select Balancos
		Select Balancos
			loBarra.Update(.T.,'Empresa: ' + Alltrim(Balancos.Emps) + ' / Balanço nº ' + Alltrim(Str(Balancos.Codigos,4)))
			lStrQuery = [Select a.Emps,a.Codigos,a.Tipos,a.Produto,a.Barras,a.Apurado,a.Estoque,a.Falta,a.Sobra,]+;
						[From SigIvTrT a ]+;
						[Left Join SigCdPro b On b.CPros = a.Produto ]+;
			If ThisForm.poDataMgr.SqlExecute(lStrQuery,'Tratamento') < 1
			Select Tratamento
			Select CsRelatorio
				Insert Into CsRelatorio (Emps) Values (Balancos.Emps)
			Select a.*,b.Lancas,b.Opers ;
			From Tratamento a, CrSigBaOco b ;
			Select Consulta
				loBarra2.Update(.T.)
				Select CsRelatorio
				Select Consulta
				=Seek(m.MoeCusFs,'CrSigCdMoe','CMoes')
				Select CsRelatorio
					Insert Into CsRelatorio (Emps) Values ( Balancos.Emps)
				Select Consulta	
			Select Balancos
		Select Balancos
			loBarra.Update(.T.,'Balanço nº ' + Alltrim(Str(Balancos.Codigos,4)))
			lStrQuery = [Select a.Emps,a.Codigos,a.Tipos,a.Produto,a.Barras,a.Apurado,a.Estoque,a.Falta,a.Sobra,]+;
						[From SigIvTrT a ]+;
						[Left Join SigCdPro b On b.CPros = a.Produto ]+;
			If ThisForm.poDataMgr.SqlExecute(lStrQuery,'Tratamento') < 1
			Select Tratamento
			Select Tratamento
				loBarra2.Update(.T.)
				=Seek('O' + Tratamento.Ocorrencia,'CrSigBaOco','TipCods')
				Insert Into CsRelatorio (Emps,DtBals,DtBases,Ocorrencia,DesOco,Obss ) ;
				Select Tratamento
			Select Balancos
Select CsRelatorio
If ThisForm.poDataMgr.SqlExecute([Select * From SigCdEmp ],'CrSigCdEmp') < 1
Select CrSigCdEmp
If ThisForm.poDataMgr.SqlExecute([Select * From SigCdMoe ],'CrSigCdMoe') < 1
Select CrSigCdMoe
If ThisForm.poDataMgr.SqlExecute([Select * From SigCdCot ],'CrSigCdCot') < 1
Select CrSigCdCot
If ThisForm.poDataMgr.SqlExecute([Select * From SigBaOco ],'CrSigBaOco') < 1
Select CrSigBaOco
Insert Into TmpBase (Bases) Values ('  /    ')
If ThisForm.poDataMgr.SqlExecute([Select DtBases From SigCdBal Where Not DtBases Is Null ],'TmpBal') < 1
Select Subst(DtoS(DtBases),5,2) + '/' + Left(DtoS(DtBases),4) As Bases ;
From TmpBal ;
Select Bases From TmpBase ;
Select CsBases
Select Iif(Ativas = 1, 1, 0) As lMarca,CEmps,Razas,Ativas,Nums ;
From CrSigCdEmp ;
Select CsSigCdEmp
	.Column1.ControlSource = 'CsSigCdEmp.lMarca'
	.Column2.ControlSource = 'CsSigCdEmp.CEmps'
	.Column3.ControlSource = 'CsSigCdEmp.Razas'
			Select CsSigCdEmp
			Select CsSigCdEmp
	If Seek(This.Value,'CsBases','Bases')
	If Seek(This.Value,'CsBases','Bases')
	lStrQuery = [Select CBars From SigOpEtq Where CBars = ]+Alltrim(Str(lnProd,8))+[ ]
	If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpEti') < 1
	Select TmpEti
Select CsSigCdEmp
Update CsSigCdEmp Set lMarca = 0
Select CsSigCdEmp
Update CsSigCdEmp Set lMarca = 1

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReIfv.prg) - TRECHOS RELEVANTES PARA PASS SQL (1920 linhas total):

*-- Linhas 87 a 105:
87:             ENDIF
88: 
89:             *-- Carregar cursores auxiliares (CrSigCdEmp, CsBases, etc.)
90:             *   Equivalente ao Init() original que fazia SqlExecute de SigCdEmp.
91:             *   Pulado em modo de valida" + CHR(231) + CHR(227) + "o de UI (sem conex" + CHR(227) + "o SQL).
92:             IF loc_lContinuar AND ;
93:                (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
94:                 IF !THIS.this_oRelatorio.CarregarDadosAuxiliares()
95:                     MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
96:                     loc_lContinuar = .F.
97:                 ENDIF
98:             ENDIF
99: 
100:             IF loc_lContinuar
101:                 *-- Cabe" + CHR(231) + "alho escuro com t" + CHR(237) + "tulo (equivalente a cntSombra)
102:                 THIS.ConfigurarCabecalho()
103: 
104:                 *-- Bot" + CHR(245) + "es do relat" + CHR(243) + "rio (Visualizar / Imprimir / Excel / Encerrar)
105:                 THIS.ConfigurarBotoes()

*-- Linhas 655 a 690:
655:         *-- Grid de sele" + CHR(231) + CHR(227) + "o de Empresas (GrdEmp original: Top=266, Left=163, W=342, H=147)
656:         *   3 colunas: CheckBox(lMarca) | C" + CHR(243) + "d.(CEmps) | Nome da Empresa(DEmps)
657:         *   Vis" + CHR(237) + "vel apenas quando Tipo=2 (Sint" + CHR(233) + "tico)
658:         *   Ordem OBRIGAT" + CHR(211) + "RIA da Column1: AddObject(Check1) -> CurrentControl -> ControlSource
659:         loc_oPag.AddObject("grd_4c_Dados", "Grid")
660:         loc_oGrd = loc_oPag.grd_4c_Dados
661:         WITH loc_oGrd
662:             .Top                = 186
663:             .Left               = 163
664:             .Width              = 342
665:             .Height             = 147
666:             .ColumnCount        = 3
667:             .FontName           = "Verdana"
668:             .FontSize           = 8
669:             .HighlightStyle     = 2
670:             .HighlightBackColor = RGB(255, 255, 255)
671:             .HighlightForeColor = RGB(15, 41, 104)
672:             .GridLineColor      = RGB(238, 238, 238)
673:             .BackColor          = RGB(255, 255, 255)
674:             .ForeColor          = RGB(90, 90, 90)
675:             .DeleteMark         = .F.
676:             .RecordMark         = .F.
677:             .RowHeight          = 16
678:             .ScrollBars         = 2
679:             .Visible            = .F.
680: 
681:             WITH .Column1
682:                 .Width           = 25
683:                 .Resizable       = .F.
684:                 .Header1.Caption = ""
685:                 .AddObject("Check1", "CheckBox")
686:                 .Check1.Caption  = ""
687:                 .Check1.Value    = 0
688:                 .CurrentControl  = "Check1"
689:             ENDWITH
690: 

*-- Linhas 701 a 725:
701:             ENDWITH
702:         ENDWITH
703: 
704:         *-- RecordSource e ControlSource ap" + CHR(243) + "s WITH (evita reset de cabe" + CHR(231) + "alhos)
705:         *   ControlSource da Column1 DEPOIS de CurrentControl (regra Error 1767)
706:         IF USED("CsSigCdEmp")
707:             loc_oGrd.RecordSource          = "CsSigCdEmp"
708:             loc_oGrd.Column1.ControlSource = "CsSigCdEmp.lMarca"
709:             loc_oGrd.Column2.ControlSource = "CsSigCdEmp.CEmps"
710:             loc_oGrd.Column3.ControlSource = "CsSigCdEmp.Razas"
711:             loc_oGrd.Column2.Header1.Caption = "C" + CHR(243) + "d."
712:             loc_oGrd.Column3.Header1.Caption = "Nome da Empresa"
713:         ENDIF
714: 
715:         *-- Bot" + CHR(227) + "o Marcar Todas as Empresas (cmdSelemp original: Top=332, Left=508, W=40, H=40)
716:         loc_oPag.AddObject("cmd_4c_CmdSelemp", "CommandButton")
717:         WITH loc_oPag.cmd_4c_CmdSelemp
718:             .Top           = 252
719:             .Left          = 508
720:             .Width         = 40
721:             .Height        = 40
722:             .Caption       = ""
723:             .Picture       = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
724:             .ToolTipText   = "Marcar Todas as Empresas"
725:             .FontName      = "Tahoma"

*-- Linhas 916 a 934:
916:         ENDIF
917: 
918:         IF USED("CrSigCdEmp")
919:             SELECT CrSigCdEmp
920:             SET ORDER TO CEmps
921:             IF SEEK(loc_cCodigo)
922:                 THIS.pgf_4c_Paginas.Page1.txt_4c_Dempresa.Value = ALLTRIM(CrSigCdEmp.Razas)
923:                 RETURN
924:             ENDIF
925:         ENDIF
926: 
927:         THIS.AbrirBuscaEmpresa()
928:     ENDPROC
929: 
930:     *--------------------------------------------------------------------------
931:     * AbrirBuscaEmpresa - FormBuscaAuxiliar Modo 1 para selecao de empresa
932:     *   Tabela: SigCdEmp | Cod: CEmps | Desc: Razas
933:     *--------------------------------------------------------------------------
934:     PROCEDURE AbrirBuscaEmpresa()

*-- Linhas 992 a 1010:
992:         ENDIF
993: 
994:         IF USED("CrSigCdEmp")
995:             SELECT CrSigCdEmp
996:             LOCATE FOR UPPER(ALLTRIM(Razas)) = UPPER(loc_cDesc)
997:             IF FOUND()
998:                 loc_oPag.txt_4c_Empresa.Value  = ALLTRIM(CrSigCdEmp.CEmps)
999:                 loc_oPag.txt_4c_Dempresa.Value = ALLTRIM(CrSigCdEmp.Razas)
1000:                 RETURN
1001:             ENDIF
1002:         ENDIF
1003: 
1004:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1005:             "SigCdEmp", "cursor_4c_BuscaEmp", "Razas", loc_cDesc, ;
1006:             "Empresa")
1007: 
1008:         IF VARTYPE(loc_oBusca) != "O"
1009:             RETURN
1010:         ENDIF

*-- Linhas 1057 a 1075:
1057:         ENDIF
1058: 
1059:         IF USED("CsBases")
1060:             SELECT CsBases
1061:             SET ORDER TO Bases
1062:             IF SEEK(loc_cValor)
1063:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DtBase.Value = ALLTRIM(CsBases.Bases)
1064:                 RETURN
1065:             ENDIF
1066:         ENDIF
1067: 
1068:         THIS.AbrirBuscaDtBase("DtBase")
1069:     ENDPROC
1070: 
1071:     *--------------------------------------------------------------------------
1072:     * AbrirBuscaDtBase - FormBuscaAuxiliar Modo 2 sobre cursor CsBases
1073:     *   par_cCampo: "DtBase" ou "DtBasea" para indicar qual campo preencher
1074:     *--------------------------------------------------------------------------
1075:     PROCEDURE AbrirBuscaDtBase(par_cCampo)

*-- Linhas 1131 a 1149:
1131:         ENDIF
1132: 
1133:         IF USED("CsBases")
1134:             SELECT CsBases
1135:             SET ORDER TO Bases
1136:             IF SEEK(loc_cValor)
1137:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DtBasea.Value = ALLTRIM(CsBases.Bases)
1138:                 RETURN
1139:             ENDIF
1140:         ENDIF
1141: 
1142:         THIS.AbrirBuscaDtBase("DtBasea")
1143:     ENDPROC
1144: 
1145:     *--------------------------------------------------------------------------
1146:     * TeclaCdMoeda - KeyPress do campo codigo de moeda
1147:     *   F4(115): abre busca; ENTER(13)/TAB(9): valida codigo em CrSigCdMoe
1148:     *--------------------------------------------------------------------------
1149:     PROCEDURE TeclaCdMoeda(par_nKeyCode, par_nShift)

*-- Linhas 1170 a 1188:
1170:         ENDIF
1171: 
1172:         IF USED("CrSigCdMoe")
1173:             SELECT CrSigCdMoe
1174:             SET ORDER TO CMoes
1175:             IF SEEK(loc_cCodigo)
1176:                 loc_oPag.txt_4c__ds_moeda.Value = ALLTRIM(CrSigCdMoe.DMoes)
1177:                 RETURN
1178:             ENDIF
1179:         ENDIF
1180: 
1181:         THIS.AbrirBuscaMoeda()
1182:     ENDPROC
1183: 
1184:     *--------------------------------------------------------------------------
1185:     * AbrirBuscaMoeda - FormBuscaAuxiliar para selecao de moeda
1186:     *   Tabela: SigCdMoe | Cod: CMoes | Desc: DMoes
1187:     *--------------------------------------------------------------------------
1188:     PROCEDURE AbrirBuscaMoeda()

*-- Linhas 1245 a 1263:
1245:         ENDIF
1246: 
1247:         IF USED("CrSigCdMoe")
1248:             SELECT CrSigCdMoe
1249:             LOCATE FOR UPPER(ALLTRIM(DMoes)) = UPPER(loc_cDesc)
1250:             IF FOUND()
1251:                 loc_oPag.txt_4c__cd_moeda.Value = ALLTRIM(CrSigCdMoe.CMoes)
1252:                 loc_oPag.txt_4c__ds_moeda.Value = ALLTRIM(CrSigCdMoe.DMoes)
1253:                 RETURN
1254:             ENDIF
1255:         ENDIF
1256: 
1257:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1258:             "SigCdMoe", "cursor_4c_BuscaMoe", "DMoes", loc_cDesc, ;
1259:             "Moeda")
1260: 
1261:         IF VARTYPE(loc_oBusca) != "O"
1262:             RETURN
1263:         ENDIF

*-- Linhas 1311 a 1333:
1311:             RETURN
1312:         ENDIF
1313: 
1314:         loc_cSQL    = "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cCodigo)
1315:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValGrEst")
1316: 
1317:         IF loc_nResult > 0
1318:             SELECT cursor_4c_ValGrEst
1319:             IF !EOF()
1320:                 loc_oPag.txt_4c__Ds_GrEstoque.Value = ALLTRIM(cursor_4c_ValGrEst.descrs)
1321:                 USE IN cursor_4c_ValGrEst
1322:                 RETURN
1323:             ENDIF
1324:             IF USED("cursor_4c_ValGrEst")
1325:                 USE IN cursor_4c_ValGrEst
1326:             ENDIF
1327:         ENDIF
1328: 
1329:         THIS.AbrirBuscaGrEstoque()
1330:     ENDPROC
1331: 
1332:     *--------------------------------------------------------------------------
1333:     * AbrirBuscaGrEstoque - FormBuscaAuxiliar para selecao do grupo de estoque

*-- Linhas 1393 a 1416:
1393:             RETURN
1394:         ENDIF
1395: 
1396:         loc_cSQL    = "SELECT codigos, descrs FROM SigCdGcr WHERE UPPER(descrs) LIKE '%" + ;
1397:                       UPPER(STRTRAN(loc_cDesc, "'", "''")) + "%'"
1398:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValGrEst")
1399: 
1400:         IF loc_nResult > 0
1401:             SELECT cursor_4c_ValGrEst
1402:             IF !EOF() AND RECCOUNT("cursor_4c_ValGrEst") = 1
1403:                 loc_oPag.txt_4c__Cd_GrEstoque.Value = ALLTRIM(cursor_4c_ValGrEst.codigos)
1404:                 loc_oPag.txt_4c__Ds_GrEstoque.Value = ALLTRIM(cursor_4c_ValGrEst.descrs)
1405:                 USE IN cursor_4c_ValGrEst
1406:                 RETURN
1407:             ENDIF
1408:             IF USED("cursor_4c_ValGrEst")
1409:                 USE IN cursor_4c_ValGrEst
1410:             ENDIF
1411:         ENDIF
1412: 
1413:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1414:             "SigCdGcr", "cursor_4c_BuscaGrEst", "descrs", loc_cDesc, ;
1415:             "Grupo de Estoque")
1416: 

*-- Linhas 1469 a 1491:
1469:             RETURN
1470:         ENDIF
1471: 
1472:         loc_cSQL    = "SELECT DISTINCT Contas FROM SigCdBal"
1473:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValEst")
1474: 
1475:         IF loc_nResult > 0
1476:             SELECT cursor_4c_ValEst
1477:             IF !EOF()
1478:                 loc_oPag.txt_4c_Ds_Estoque.Value = ALLTRIM(cursor_4c_ValEst.Contas)
1479:                 USE IN cursor_4c_ValEst
1480:                 RETURN
1481:             ENDIF
1482:             IF USED("cursor_4c_ValEst")
1483:                 USE IN cursor_4c_ValEst
1484:             ENDIF
1485:         ENDIF
1486: 
1487:         THIS.AbrirBuscaEstoque()
1488:     ENDPROC
1489: 
1490:     *--------------------------------------------------------------------------
1491:     * AbrirBuscaEstoque - FormBuscaAuxiliar para selecao de conta de estoque

*-- Linhas 1497 a 1523:
1497:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
1498:         loc_cGrupo = ALLTRIM(loc_oPag.txt_4c__Cd_GrEstoque.Value)
1499: 
1500:         loc_cSQL = "SELECT DISTINCT Contas FROM SigCdBal ORDER BY Contas"
1501:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEst")
1502: 
1503:         IF loc_nResult < 1
1504:             MsgErro("Erro ao buscar contas de estoque", "Erro")
1505:             RETURN
1506:         ENDIF
1507: 
1508:         SELECT cursor_4c_BuscaEst
1509:         GO TOP
1510: 
1511:         IF EOF()
1512:             MsgAviso("Nenhuma conta encontrada" + ;
1513:                 IIF(!EMPTY(loc_cGrupo), " para o grupo " + loc_cGrupo, "") + ".", ;
1514:                 "Busca")
1515:             USE IN cursor_4c_BuscaEst
1516:             RETURN
1517:         ENDIF
1518: 
1519:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1520:         IF VARTYPE(loc_oBusca) != "O"
1521:             MsgErro("Erro ao abrir busca de contas", "Erro")
1522:             USE IN cursor_4c_BuscaEst
1523:             RETURN

*-- Linhas 1580 a 1613:
1580:     *--------------------------------------------------------------------------
1581:     * ValidarIBarra - Valida numero de etiqueta em SigOpEtq (campo CBars)
1582:     *   Equivalente ao Valid original de GetiBarra:
1583:     *   Select CBars From SigOpEtq Where CBars = nBarra -> se nao achar avisa
1584:     *--------------------------------------------------------------------------
1585:     PROCEDURE ValidarIBarra()
1586:         LOCAL loc_nBarra, loc_cSQL, loc_nResult, loc_oPag
1587:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
1588:         loc_nBarra = loc_oPag.txt_4c_IBarra.Value
1589: 
1590:         IF loc_nBarra = 0
1591:             RETURN
1592:         ENDIF
1593: 
1594:         loc_cSQL    = "SELECT CBars FROM SigOpEtq WHERE CBars = " + ALLTRIM(STR(loc_nBarra, 8))
1595:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValBarra")
1596: 
1597:         IF loc_nResult > 0
1598:             SELECT cursor_4c_ValBarra
1599:             IF EOF()
1600:                 IF USED("cursor_4c_ValBarra")
1601:                     USE IN cursor_4c_ValBarra
1602:                 ENDIF
1603:                 MsgAviso("Etiqueta n" + CHR(227) + "o Encontrada !!!", ;
1604:                     "Valida" + CHR(231) + CHR(227) + "o")
1605:                 loc_oPag.txt_4c_IBarra.Value = 0
1606:                 RETURN
1607:             ENDIF
1608:             IF USED("cursor_4c_ValBarra")
1609:                 USE IN cursor_4c_ValBarra
1610:             ENDIF
1611:         ELSE
1612:             MsgErro("Erro ao validar n" + CHR(250) + "mero de etiqueta", "Erro")
1613:         ENDIF

*-- Linhas 1744 a 1779:
1744: 
1745:     *--------------------------------------------------------------------------
1746:     * CmdSelempClick - Marca todas as empresas no grid (lMarca=1)
1747:     *   Equivalente ao cmdSelemp.Click original: Update CsSigCdEmp Set lMarca=1
1748:     *--------------------------------------------------------------------------
1749:     PROCEDURE CmdSelempClick()
1750:         IF USED("CsSigCdEmp")
1751:             SELECT CsSigCdEmp
1752:             REPLACE ALL lMarca WITH 1
1753:             GO TOP
1754:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh
1755:         ENDIF
1756:     ENDPROC
1757: 
1758:     *--------------------------------------------------------------------------
1759:     * CmdApgEmpClick - Desmarca todas as empresas no grid (lMarca=0)
1760:     *   Equivalente ao CmdApgEmp.Click original: Update CsSigCdEmp Set lMarca=0
1761:     *--------------------------------------------------------------------------
1762:     PROCEDURE CmdApgEmpClick()
1763:         IF USED("CsSigCdEmp")
1764:             SELECT CsSigCdEmp
1765:             REPLACE ALL lMarca WITH 0
1766:             GO TOP
1767:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh
1768:         ENDIF
1769:     ENDPROC
1770: 
1771:     *==========================================================================
1772:     * COMPATIBILIDADE CRUD (mapeamento semantico de botoes para form REPORT)
1773:     *   Form REPORT (frmrelatorio) nao possui operacoes CRUD nativas. Estes
1774:     *   metodos existem para compatibilidade com o pipeline generico do sistema
1775:     *   e mapeiam acoes CRUD para operacoes equivalentes no contexto de relatorio:
1776:     *     - BtnIncluirClick  -> Visualizar (gera e exibe o relatorio)
1777:     *     - BtnAlterarClick  -> LimparCampos + foco no 1o filtro (reset edicao)
1778:     *     - BtnExcluirClick  -> LimparCampos (limpa filtros = "remove" selecao)
1779:     *==========================================================================

*-- Linhas 1895 a 1915:
1895: 
1896:         IF USED("CsSigCdEmp")
1897:             loc_oGrd.RecordSource          = "CsSigCdEmp"
1898:             loc_oGrd.Column1.ControlSource = "CsSigCdEmp.lMarca"
1899:             loc_oGrd.Column2.ControlSource = "CsSigCdEmp.CEmps"
1900:             loc_oGrd.Column3.ControlSource = "CsSigCdEmp.Razas"
1901:             loc_oGrd.Column2.Header1.Caption = "C" + CHR(243) + "d."
1902:             loc_oGrd.Column3.Header1.Caption = "Nome da Empresa"
1903:             loc_oGrd.Refresh
1904:         ENDIF
1905:     ENDPROC
1906: 
1907:     *--------------------------------------------------------------------------
1908:     * AjustarBotoesPorModo - Em REPORT os botoes do CommandGroup ficam sempre
1909:     *   habilitados (nao ha modo INCLUIR/ALTERAR/VISUALIZAR como no CRUD)
1910:     *--------------------------------------------------------------------------
1911:     PROCEDURE AjustarBotoesPorModo()
1912:         IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
1913:             THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
1914:             THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
1915:             THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.


### BO (C:\4c\projeto\app\classes\SigReIfvBO.prg):
*==============================================================================
* SIGREIFVBO.PRG
* Business Object para Relatorio de Fechamento de Inventario
* Herda de RelatorioBase
*
* Relatorio original: SIGREIFV.SCX (frmrelatorio)
* FRX: SigReIf1 (Analitico), SigReIf0 (Sintetico), SigReIf9 (Consulta Barra)
*==============================================================================

DEFINE CLASS SigReIfvBO AS RelatorioBase

    *-- Identificacao
    this_cTabela        = ""
    this_cCampoChave    = ""
    this_cTituloRel     = "Relat" + CHR(243) + "rio de Fechamento de Invent" + CHR(225) + "rio"

    *-- Filtros: tipo de relatorio
    *-- 1 = Analitico (empresa unica)
    *-- 2 = Sintetico (multiplas empresas via grid)
    *-- 3 = Consulta Barra (por numero de etiqueta)
    this_nTipo          = 1

    *-- Filtros: datas (formato MM/YYYY - InputMask "99/9999")
    this_cDtBase        = ""
    this_cDtBaseA       = ""

    *-- Filtros: empresa (codigo + descricao)
    this_cCdEmpresa     = ""
    this_cDsEmpresa     = ""

    *-- Filtros: moeda (codigo + descricao)
    this_cCdMoeda       = ""
    this_cDsMoeda       = ""

    *-- Filtros: grupo de estoque/contabilidade (codigo + descricao)
    this_cCdGrEstoque   = ""
    this_cDsGrEstoque   = ""

    *-- Filtros: conta de estoque (codigo + descricao)
    this_cCdEstoque     = ""
    this_cDsEstoque     = ""

    *-- Filtros: numero de barra/etiqueta (apenas tipo 3)
    this_nIBarra        = 0

    *-- Nomes dos arquivos FRX por tipo
    this_cFrxAnalitico     = "SigReIf1"
    this_cFrxSintetico     = "SigReIf0"
    this_cFrxConsultaBarra = "SigReIf9"

    *--------------------------------------------------------------------------
    * Init - Inicializa BO do relatorio de fechamento de inventario
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDadosAuxiliares - Carrega cursores auxiliares para o relatorio
    * Deve ser chamado pelo Form durante InicializarForm()
    * Carrega: CrSigCdEmp, CrSigCdMoe, CrSigCdCot, CrSigBaOco, CsBases
    * Cria: CsSigCdEmp (cursor editavel para grid de selecao de empresas)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDadosAuxiliares()
        LOCAL loc_lSucesso, loc_oErro, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED("CrSigCdEmp")
                USE IN CrSigCdEmp
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigCdEmp", "CrSigCdEmp")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar empresas (CrSigCdEmp)"
                loc_lSucesso = .F.
            ENDIF
            SELECT CrSigCdEmp
            INDEX ON CEmps TAG CEmps
            GO TOP

            IF USED("CrSigCdMoe")
                USE IN CrSigCdMoe
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigCdMoe", "CrSigCdMoe")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar moedas (CrSigCdMoe)"
                loc_lSucesso = .F.
            ENDIF
            SELECT CrSigCdMoe
            INDEX ON CMoes TAG CMoes
            GO TOP

            IF USED("CrSigCdCot")
                USE IN CrSigCdCot
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigCdCot", "CrSigCdCot")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar cota" + CHR(231) + CHR(245) + "es (CrSigCdCot)"
                loc_lSucesso = .F.
            ENDIF
            SELECT CrSigCdCot
            INDEX ON CMoes + DTOS(TTOD(Datas)) TAG CMoeData
            GO TOP

            IF USED("CrSigBaOco")
                USE IN CrSigBaOco
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigBaOco", "CrSigBaOco")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar ocorr" + CHR(234) + "ncias (CrSigBaOco)"
                loc_lSucesso = .F.
            ENDIF
            SELECT CrSigBaOco
            INDEX ON Tipos + Codigos TAG TipCods
            GO TOP

            *-- CsBases: datas base disponiveis (para lookup de data base no form)
            IF USED("cursor_4c_IfvTmpBase")
                USE IN cursor_4c_IfvTmpBase
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_IfvTmpBase (Bases c(7))
            INSERT INTO cursor_4c_IfvTmpBase (Bases) VALUES ("  /    ")

            IF USED("cursor_4c_IfvTmpBal")
                USE IN cursor_4c_IfvTmpBal
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT DtBases FROM SigCdBal WHERE DtBases IS NOT NULL", ;
                "cursor_4c_IfvTmpBal")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar bases (SigCdBal)"
                loc_lSucesso = .F.
            ENDIF

            IF USED("CsBases")
                USE IN CsBases
            ENDIF
            SELECT SUBSTR(DTOS(DtBases),5,2) + "/" + LEFT(DTOS(DtBases),4) AS Bases ;
            FROM cursor_4c_IfvTmpBal ;
            GROUP BY 1 ;
            UNION ALL ;
            SELECT Bases FROM cursor_4c_IfvTmpBase ;
            GROUP BY 1 ;
            INTO CURSOR CsBases READWRITE

            SET NULL OFF
            SELECT CsBases
            INDEX ON Bases TAG Bases
            GO TOP

            IF USED("cursor_4c_IfvTmpBal")
                USE IN cursor_4c_IfvTmpBal
            ENDIF
            IF USED("cursor_4c_IfvTmpBase")
                USE IN cursor_4c_IfvTmpBase
            ENDIF

            *-- CsSigCdEmp: cursor editavel para grid de selecao de empresas (tipo 2)
            IF USED("CsSigCdEmp")
                USE IN CsSigCdEmp
            ENDIF
            SELECT IIF(Ativas = 1, 1, 0) AS lMarca, CEmps, Razas, Ativas, Nums ;
            FROM CrSigCdEmp ;
            WHERE !EMPTY(CEmps) AND !EMPTY(Razas) ;
            INTO CURSOR CsSigCdEmp READWRITE

            SELECT CsSigCdEmp
            INDEX ON Razas TAG Razas
            INDEX ON CEmps TAG CEmps
            GO TOP

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta os cursores de dados para o relatorio
    * Equivalente ao PROCEDURE processamento do sistema legado
    * Resultado: cursores CsCabecalho e CsRelatorio prontos para REPORT FORM
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cDtBase, loc_cDtBaseA, loc_nTipo
        LOCAL loc_cEmp, loc_cMoe, loc_cGrupo, loc_cConta, loc_nBarra
        LOCAL loc_nResult, loc_cNomeEmpresa, loc_cEmpresaCab
        LOCAL loc_cTitulo, loc_cSubTitulo, loc_lProcess

        loc_lSucesso = .F.
        TRY
            loc_cDtBase  = RIGHT(ALLTRIM(THIS.this_cDtBase), 4)  + LEFT(ALLTRIM(THIS.this_cDtBase), 2)
            loc_cDtBaseA = RIGHT(ALLTRIM(THIS.this_cDtBaseA), 4) + LEFT(ALLTRIM(THIS.this_cDtBaseA), 2)
            loc_nTipo    = THIS.this_nTipo
            loc_cEmp     = ALLTRIM(THIS.this_cCdEmpresa)
            loc_cMoe     = ALLTRIM(THIS.this_cCdMoeda)
            loc_cGrupo   = ALLTRIM(THIS.this_cCdGrEstoque)
            loc_cConta   = ALLTRIM(THIS.this_cCdEstoque)
            loc_nBarra   = THIS.this_nIBarra

            loc_cNomeEmpresa = ""
            IF USED("CrSigCdEmp")
                IF SEEK(go_4c_Sistema.cCodEmpresa, "CrSigCdEmp", "CEmps")
                    loc_cNomeEmpresa = ALLTRIM(CrSigCdEmp.Razas)
                ENDIF
            ENDIF
            loc_cEmpresaCab = ALLTRIM(go_4c_Sistema.cCodEmpresa) + " - " + loc_cNomeEmpresa

            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
            CREATE CURSOR CsCabecalho (;
                Empresa   c(80), ;
                Titulo    c(80), ;
                SubTitulo c(80), ;
                DtBase    c(7),  ;
                DtBaseA   c(7)   ;
            )

            IF loc_nTipo = 3
                INSERT INTO CsCabecalho (Empresa, Titulo, SubTitulo, DtBase) ;
                VALUES (loc_cEmpresaCab, ;
                        "Consulta Barra", ;
                        ALLTRIM(STR(loc_nBarra, 8)), ;
                        THIS.this_cDtBase)
            ELSE
                loc_cTitulo = "Invent" + CHR(225) + "rio Data Base " + THIS.this_cDtBase
                IF loc_nTipo = 1
                    loc_cSubTitulo = "Lj: " + loc_cEmp + "   " + ;
                                     "Anal" + CHR(237) + "tico de Apura" + CHR(231) + CHR(227) + "o - " + loc_cMoe
                ELSE
                    loc_cSubTitulo = "Sint" + CHR(233) + "tico - " + loc_cMoe
                ENDIF
                INSERT INTO CsCabecalho (Empresa, Titulo, SubTitulo, DtBase, DtBaseA) ;
                VALUES (loc_cEmpresaCab, loc_cTitulo, loc_cSubTitulo, ;
                        THIS.this_cDtBase, THIS.this_cDtBaseA)
            ENDIF

            IF USED("CsBal")
                USE IN CsBal
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigCdBal", "CsBal")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar balan" + CHR(231) + "o (CsBal)"
                loc_lSucesso = .F.
            ENDIF
            SELECT CsBal
            GO TOP

            IF USED("Balancos")
                USE IN Balancos
            ENDIF

            IF loc_nTipo <> 2
                SELECT *, LEFT(DTOS(DtBases),6) AS Bases ;
                FROM CsBal ;
                WHERE IIF(loc_nTipo = 1, Emps = loc_cEmp, .T.) ;
                ORDER BY Emps ;
                INTO CURSOR Balancos
            ELSE
                IF USED("cursor_4c_IfvEmps")
                    USE IN cursor_4c_IfvEmps
                ENDIF
                SELECT * FROM CsSigCdEmp WHERE lMarca = 1 INTO CURSOR cursor_4c_IfvEmps

                SELECT a.*, LEFT(DTOS(a.DtBases),6) AS Bases ;
                FROM CsBal a, cursor_4c_IfvEmps b ;
                WHERE a.Emps = b.CEmps ;
                ORDER BY a.Emps ;
                INTO CURSOR Balancos

                IF USED("cursor_4c_IfvEmps")
                    USE IN cursor_4c_IfvEmps
                ENDIF
            ENDIF

            DO CASE
                CASE loc_nTipo = 1
                    loc_lProcess = THIS.ProcessarAnalitico(loc_cDtBase, loc_cDtBaseA, loc_cMoe)
                CASE loc_nTipo = 2
                    loc_lProcess = THIS.ProcessarSintetico(loc_cDtBase, loc_cDtBaseA, loc_cMoe)
                OTHERWISE
                    loc_lProcess = THIS.ProcessarConsultaBarra(loc_cDtBase, loc_cMoe, loc_nBarra)
            ENDCASE

            IF loc_lProcess
                SELECT CsRelatorio
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            WAIT CLEAR
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_cFrx
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cFrx = gc_4c_CaminhoReports + THIS.ObterFrxAtual()
                REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_cFrx
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cFrx = gc_4c_CaminhoReports + THIS.ObterFrxAtual()
                REPORT FORM (loc_cFrx) TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterFrxAtual - Retorna nome do arquivo FRX conforme tipo selecionado
    *--------------------------------------------------------------------------
    PROCEDURE ObterFrxAtual()
        DO CASE
            CASE THIS.this_nTipo = 1
                RETURN THIS.this_cFrxAnalitico
            CASE THIS.this_nTipo = 2
                RETURN THIS.this_cFrxSintetico
            OTHERWISE
                RETURN THIS.this_cFrxConsultaBarra
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCambio - Retorna cotacao da moeda na data informada
    * Equivalente a fCarregarCambio() do sistema legado
    * Busca a cotacao mais recente <= par_dData para a moeda informada
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarCambio(par_cMoeda, par_dData)
        LOCAL loc_nCotacao, loc_cMoeda
        loc_nCotacao = 1
        loc_cMoeda   = ALLTRIM(par_cMoeda)
        IF USED("CrSigCdCot") AND !EMPTY(loc_cMoeda) AND !EMPTY(par_dData)
            SELECT CrSigCdCot
            SET ORDER TO CMoeData
            IF SEEK(loc_cMoeda + DTOS(par_dData))
                loc_nCotacao = CrSigCdCot.Valos
            ELSE
                SKIP -1
                IF !BOF() AND ALLTRIM(CrSigCdCot.CMoes) = loc_cMoeda AND ;
                   TTOD(CrSigCdCot.Datas) <= par_dData
                    loc_nCotacao = CrSigCdCot.Valos
                ENDIF
            ENDIF
        ENDIF
        RETURN IIF(loc_nCotacao = 0, 1, loc_nCotacao)
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarAnalitico - Processa relatorio analitico empresa unica (Tipo 1)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarAnalitico(par_cDtBase, par_cDtBaseA, par_cMoe)
        LOCAL loc_nResult, loc_cSQL, loc_nCotaMCC, loc_nCotaMoe, loc_nQtdeQs, loc_lAchou

        IF USED("CsRelatorio")
            USE IN CsRelatorio
        ENDIF
        CREATE CURSOR CsRelatorio (;
            Ocorrencia c(10),   Barras     n(8),    Barra2s   n(8),    ;
            CCustos    n(12,2), CCusto2s   n(12,2), DifCustos n(12,2), ;
            Ocor2s     c(10),   DesOco     c(40),   Obs2s     m,       ;
            DPros      c(40),   Pesos      n(12,2)  ;
        )
        INDEX ON Ocorrencia + STR(Barras,8) TAG Produto

        WAIT WINDOW "Aguarde! Abrindo o Balan" + CHR(231) + "o..." NOWAIT

        SELECT Balancos
        GO TOP
        SCAN
            IF USED("Tratamento")
                USE IN Tratamento
            ENDIF

            loc_cSQL = "SELECT a.Emps,a.Codigos,a.Tipos,a.Produto,a.Barras," + ;
                       "a.Apurado,a.Estoque,a.Falta,a.Sobra,a.Ocorrencia,a.Obs," + ;
                       "a.PesReals,a.CCustos,a.Barra2s,a.Ocor2s,a.Obs2s,a.CCusto2s," + ;
                       "a.Peso2s,a.CItens,a.Usuars,a.CIdChaves," + ;
                       "b.CPros,b.DPros,b.MoecusFs,c.CBars,c.Pesos " + ;
                       "FROM SigIvTrT a " + ;
                       "LEFT JOIN SigCdPro b ON b.CPros = a.Produto " + ;
                       "LEFT JOIN SigOpEtq c ON c.CBars = a.Barras " + ;
                       "WHERE a.Emps = '" + ALLTRIM(Balancos.Emps) + "' " + ;
                       "AND a.Codigos = " + ALLTRIM(STR(Balancos.Codigos,4)) + " " + ;
                       "ORDER BY a.Emps,a.Codigos,a.Tipos,a.Produto,a.Barras," + ;
                       "a.Apurado,a.Estoque,a.Falta,a.Sobra,a.Ocorrencia," + ;
                       "a.PesReals,a.CCustos,a.Barra2s,a.Ocor2s,a.CCusto2s," + ;
                       "a.Peso2s,a.CItens,a.Usuars,a.CIdChaves," + ;
                       "b.CPros,b.DPros,b.MoecusFs,c.CBars,c.Pesos"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "Tratamento")
            IF loc_nResult < 1
                WAIT CLEAR
                MsgErro("Falha na conex" + CHR(227) + "o (Tratamento)", "Erro")
                RETURN .F.
            ENDIF

            SELECT Tratamento
            GO TOP
            IF EOF()
                SELECT Balancos
                LOOP
            ENDIF

            WAIT WINDOW "Analisando o Tratamento..." NOWAIT

            SELECT Tratamento
            GO TOP
            SCAN
                SCATTER MEMVAR MEMO

                loc_lAchou = SEEK("O" + m.Ocorrencia, "CrSigBaOco", "TipCods")
                IF CrSigBaOco.Apuras <> "S"
                    LOOP
                ENDIF

                m.DPros  = IIF(EMPTY(m.Obs), m.DPros, m.Obs)
                m.DesOco = CrSigBaOco.Descrs

                m.MoeCusFs = NVL(m.MoeCusFs, " ")
                loc_lAchou = SEEK(m.MoeCusFs, "CrSigCdMoe", "CMoes")
                IF !EMPTY(CrSigCdMoe.MoeQs)
                    m.Moedas    = CrSigCdMoe.MoeQs
                    loc_nQtdeQs = IIF(CrSigCdMoe.QtdeQs = 0, 1, CrSigCdMoe.QtdeQs)
                ELSE
                    m.Moedas    = m.MoeCusFs
                    loc_nQtdeQs = 1
                ENDIF

                m.CCustos  = m.CCustos  * loc_nQtdeQs
                m.CCusto2s = m.CCusto2s * loc_nQtdeQs

                IF m.Moedas <> par_cMoe
                    loc_nCotaMCC = THIS.CarregarCambio(par_cMoe,  DATE())
                    loc_nCotaMoe = THIS.CarregarCambio(m.Moedas,  DATE())
                    m.CCustos  = ROUND(m.CCustos  * loc_nCotaMoe / loc_nCotaMCC, 2)
                    m.CCusto2s = ROUND(m.CCusto2s * loc_nCotaMoe / loc_nCotaMCC, 2)
                ENDIF

                m.CCustos   = m.CCustos  * IIF(CrSigBaOco.Opers = "DB", -1, 1)
                m.CCusto2s  = m.CCusto2s * IIF(CrSigBaOco.Opers = "DB", -1, 1)
                m.DifCustos = (m.CCustos - m.CCusto2s)
                m.Obs2s     = NVL(m.Obs2s, "")
                m.Pesos     = NVL(m.Pesos, 0)

                INSERT INTO CsRelatorio FROM MEMVAR

                SELECT Tratamento
            ENDSCAN

            SELECT Balancos
        ENDSCAN

        WAIT CLEAR
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarSintetico - Processa relatorio sintetico multi-empresa (Tipo 2)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarSintetico(par_cDtBase, par_cDtBaseA, par_cMoe)
        LOCAL loc_nResult, loc_cSQL, loc_lAchou
        LOCAL loc_nCotaMCC, loc_nCotaMoe, loc_nQtdeQs
        LOCAL loc_cDataBase, loc_nColuna, loc_nQtde, loc_nDif
        LOCAL loc_cCusto, loc_cQtde

        IF USED("CsRelatorio")
            USE IN CsRelatorio
        ENDIF
        CREATE CURSOR CsRelatorio (;
            Emps    c(3),    DtBals  d(8),    ;
            Qtde1   n(12,2), Custo1  n(12,2), ;
            Qtde2   n(12,2), Custo2  n(12,2), ;
            Qtde3   n(12,2), Custo3  n(12,2), ;
            Custo3d n(12,2), Dif3d   n(12,2), ;
            Qtde4   n(12,2), Custo4  n(12,2), ;
            Qtde5   n(12,2), Custo5  n(12,2), ;
            Contac  n(12,2)  ;
        )
        INDEX ON Emps TAG Emps

        WAIT WINDOW "Aguarde! Abrindo o Balan" + CHR(231) + "o..." NOWAIT

        SELECT Balancos
        GO TOP
        SCAN
            loc_cDataBase = Balancos.Bases
            IF USED("Tratamento")
                USE IN Tratamento
            ENDIF

            loc_cSQL = "SELECT a.Emps,a.Codigos,a.Tipos,a.Produto,a.Barras," + ;
                       "a.Apurado,a.Estoque,a.Falta,a.Sobra,a.Ocorrencia,a.Obs," + ;
                       "a.PesReals,a.CCustos,a.Barra2s,a.Ocor2s,a.Obs2s,a.CCusto2s," + ;
                       "a.Peso2s,a.CItens,a.Usuars,a.CIdChaves," + ;
                       "b.CPros,b.DPros,b.MoecusFs " + ;
                       "FROM SigIvTrT a " + ;
                       "LEFT JOIN SigCdPro b ON b.CPros = a.Produto " + ;
                       "WHERE a.Emps = '" + ALLTRIM(Balancos.Emps) + "' " + ;
                       "AND a.Codigos = " + ALLTRIM(STR(Balancos.Codigos,4)) + " " + ;
                       "ORDER BY a.Emps,a.Codigos,a.Tipos,a.Produto,a.Barras," + ;
                       "a.Apurado,a.Estoque,a.Falta,a.Sobra,a.Ocorrencia," + ;
                       "a.PesReals,a.CCustos,a.Barra2s,a.Ocor2s,a.CCusto2s," + ;
                       "a.Peso2s,a.CItens,a.Usuars,a.CIdChaves," + ;
                       "b.CPros,b.DPros,b.MoecusFs"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "Tratamento")
            IF loc_nResult < 1
                WAIT CLEAR
                MsgErro("Falha na conex" + CHR(227) + "o (Tratamento)", "Erro")
                RETURN .F.
            ENDIF

            SELECT Tratamento
            GO TOP
            IF EOF()
                SELECT Balancos
                LOOP
            ENDIF

            SELECT CsRelatorio
            SEEK Balancos.Emps
            IF EOF()
                INSERT INTO CsRelatorio (Emps) VALUES (ALLTRIM(Balancos.Emps))
            ENDIF
            IF loc_cDataBase = par_cDtBase
                REPLACE DtBals WITH Balancos.DataInis IN CsRelatorio
            ENDIF

            IF USED("cursor_4c_IfvConsulta")
                USE IN cursor_4c_IfvConsulta
            ENDIF
            SELECT a.*, b.Lancas, b.Opers ;
            FROM Tratamento a, CrSigBaOco b ;
            WHERE "O" + a.Ocorrencia = b.Tipos + b.Codigos AND b.Apuras = "S" ;
            INTO CURSOR cursor_4c_IfvConsulta

            WAIT WINDOW "Analisando o Tratamento..." NOWAIT

            SELECT cursor_4c_IfvConsulta
            GO TOP
            SCAN
                SELECT CsRelatorio
                SCATTER MEMVAR BLANK

                SELECT cursor_4c_IfvConsulta
                SCATTER MEMVAR MEMO

                m.MoeCusFs = NVL(m.MoeCusFs, " ")
                loc_lAchou = SEEK(m.MoeCusFs, "CrSigCdMoe", "CMoes")
                IF !EMPTY(CrSigCdMoe.MoeQs)
                    m.Moedas    = CrSigCdMoe.MoeQs
                    loc_nQtdeQs = IIF(CrSigCdMoe.QtdeQs = 0, 1, CrSigCdMoe.QtdeQs)
                ELSE
                    m.Moedas    = m.MoeCusFs
                    loc_nQtdeQs = 1
                ENDIF

                m.CCustos  = m.CCustos  * loc_nQtdeQs
                m.CCusto2s = m.CCusto2s * loc_nQtdeQs

                IF m.Moedas <> par_cMoe
                    loc_nCotaMCC = THIS.CarregarCambio(par_cMoe, DATE())
                    loc_nCotaMoe = THIS.CarregarCambio(m.Moedas, DATE())
                    m.CCustos  = ROUND(m.CCustos  * loc_nCotaMoe / loc_nCotaMCC, 2)
                    m.CCusto2s = ROUND(m.CCusto2s * loc_nCotaMoe / loc_nCotaMCC, 2)
                ENDIF

                m.CCustos  = m.CCustos  * IIF(m.Opers = "DB", -1, 1)
                m.CCusto2s = m.CCusto2s * IIF(m.Opers = "DB", -1, 1)

                loc_nDif    = (m.CCustos - m.CCusto2s)
                loc_nColuna = 0

                DO CASE
                    CASE m.Ocorrencia = "FB"
                        IF loc_cDataBase = par_cDtBase
                            loc_nColuna = 2
                        ELSE
                            loc_nColuna = 1
                        ENDIF
                    CASE m.Ocorrencia = "ET" AND loc_cDataBase = par_cDtBase
                        loc_nColuna = 3
                    CASE m.Ocorrencia = "SB" AND loc_cDataBase = par_cDtBase
                        loc_nColuna = 4
                    CASE m.Ocorrencia = "FE" AND loc_cDataBase = par_cDtBase
                        loc_nColuna = 5
                ENDCASE

                IF loc_nColuna = 0
                    SELECT cursor_4c_IfvConsulta
                    LOOP
                ENDIF

                loc_cCusto = "Custo" + STR(loc_nColuna, 1)
                loc_cQtde  = "Qtde"  + STR(loc_nColuna, 1)
                loc_nQtde  = m.Falta + m.Sobra

                SELECT CsRelatorio
                SEEK ALLTRIM(Balancos.Emps)
                IF EOF()
                    INSERT INTO CsRelatorio (Emps) VALUES (ALLTRIM(Balancos.Emps))
                ENDIF
                IF loc_cDataBase = par_cDtBase
                    REPLACE DtBals WITH Balancos.DataInis IN CsRelatorio
                ENDIF
                REPLACE &loc_cCusto. WITH &loc_cCusto. + m.CCustos, ;
                        &loc_cQtde.  WITH &loc_cQtde.  + IIF(loc_nQtde = 0, m.Apurado, (m.Falta + m.Sobra))

                IF m.Ocorrencia = "ET"
                    REPLACE Custo3d WITH Custo3d + m.CCusto2s, ;
                            Dif3d   WITH Custo3  - Custo3d
                ENDIF

                IF m.Lancas = "S" AND loc_nColuna <> 1
                    REPLACE Contac WITH Contac + loc_nDif IN CsRelatorio
                ENDIF

                SELECT cursor_4c_IfvConsulta
            ENDSCAN

            IF USED("cursor_4c_IfvConsulta")
                USE IN cursor_4c_IfvConsulta
            ENDIF

            SELECT Balancos
        ENDSCAN

        WAIT CLEAR
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarConsultaBarra - Processa consulta por numero de barra (Tipo 3)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarConsultaBarra(par_cDtBase, par_cMoe, par_nBarra)
        LOCAL loc_nResult, loc_cSQL, loc_cDataBase, loc_cObss, loc_lAchou

        IF USED("CsRelatorio")
            USE IN CsRelatorio
        ENDIF
        CREATE CURSOR CsRelatorio (;
            Emps       c(3),  ;
            DtBals     d(8),  ;
            DtBases    c(7),  ;
            Ocorrencia c(10), ;
            DesOco     c(40), ;
            Obss       m      ;
        )
        INDEX ON Emps + DtBases TAG Emps

        WAIT WINDOW "Aguarde! Abrindo o Balan" + CHR(231) + "o..." NOWAIT

        SELECT Balancos
        GO TOP
        SCAN
            loc_cDataBase = RIGHT(Balancos.Bases,2) + "/" + LEFT(Balancos.Bases,4)

            IF USED("Tratamento")
                USE IN Tratamento
            ENDIF

            loc_cSQL = "SELECT a.Emps,a.Codigos,a.Tipos,a.Produto,a.Barras," + ;
                       "a.Apurado,a.Estoque,a.Falta,a.Sobra,a.Ocorrencia,a.Obs," + ;
                       "a.PesReals,a.CCustos,a.Barra2s,a.Ocor2s,a.Obs2s,a.CCusto2s," + ;
                       "a.Peso2s,a.CItens,a.Usuars,a.CIdChaves," + ;
                       "b.CPros,b.DPros " + ;
                       "FROM SigIvTrT a " + ;
                       "LEFT JOIN SigCdPro b ON b.CPros = a.Produto " + ;
                       "WHERE a.Emps = '" + ALLTRIM(Balancos.Emps) + "' " + ;
                       "AND a.Codigos = " + ALLTRIM(STR(Balancos.Codigos,4)) + " " + ;
                       "AND a.Barras = " + ALLTRIM(STR(par_nBarra, 8)) + " " + ;
                       "ORDER BY a.Emps,a.Codigos,a.Tipos,a.Produto,a.Barras," + ;
                       "a.Apurado,a.Estoque,a.Falta,a.Sobra,a.Ocorrencia," + ;
                       "a.PesReals,a.CCustos,a.Barra2s,a.Ocor2s,a.CCusto2s," + ;
                       "a.Peso2s,a.CItens,a.Usuars,a.CIdChaves," + ;
                       "b.CPros,b.DPros"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "Tratamento")
            IF loc_nResult < 1
                WAIT CLEAR
                MsgErro("Falha na conex" + CHR(227) + "o (Tratamento)", "Erro")
                RETURN .F.
            ENDIF

            SELECT Tratamento
            GO TOP
            IF EOF()
                SELECT Balancos
                LOOP
            ENDIF

            WAIT WINDOW "Analisando o Tratamento..." NOWAIT

            SELECT Tratamento
            GO TOP
            SCAN
                loc_lAchou = SEEK("O" + Tratamento.Ocorrencia, "CrSigBaOco", "TipCods")
                loc_cObss = IIF(EMPTY(Tratamento.Obs), ;
                               NVL(Tratamento.DPros, ""), ;
                               NVL(Tratamento.Obs, ""))

                INSERT INTO CsRelatorio (Emps, DtBals, DtBases, Ocorrencia, DesOco, Obss) ;
                VALUES (ALLTRIM(Balancos.Emps), Balancos.DataInis, loc_cDataBase, ;
                        ALLTRIM(Tratamento.Ocorrencia), ALLTRIM(CrSigBaOco.Descrs), loc_cObss)

                SELECT Tratamento
            ENDSCAN

            SELECT Balancos
        ENDSCAN

        WAIT CLEAR
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

ENDDEFINE

