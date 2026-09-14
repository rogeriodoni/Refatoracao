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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReIfv.prg) - TRECHOS RELEVANTES PARA PASS SQL (1922 linhas total):

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

*-- Linhas 657 a 692:
657:         *-- Grid de sele" + CHR(231) + CHR(227) + "o de Empresas (GrdEmp original: Top=266, Left=163, W=342, H=147)
658:         *   3 colunas: CheckBox(lMarca) | C" + CHR(243) + "d.(CEmps) | Nome da Empresa(DEmps)
659:         *   Vis" + CHR(237) + "vel apenas quando Tipo=2 (Sint" + CHR(233) + "tico)
660:         *   Ordem OBRIGAT" + CHR(211) + "RIA da Column1: AddObject(Check1) -> CurrentControl -> ControlSource
661:         loc_oPag.AddObject("grd_4c_Dados", "Grid")
662:         loc_oGrd = loc_oPag.grd_4c_Dados
663:         WITH loc_oGrd
664:             .Top                = 186
665:             .Left               = 163
666:             .Width              = 342
667:             .Height             = 147
668:             .ColumnCount        = 3
669:             .FontName           = "Verdana"
670:             .FontSize           = 8
671:             .HighlightStyle     = 2
672:             .HighlightBackColor = RGB(255, 255, 255)
673:             .HighlightForeColor = RGB(15, 41, 104)
674:             .GridLineColor      = RGB(238, 238, 238)
675:             .BackColor          = RGB(255, 255, 255)
676:             .ForeColor          = RGB(90, 90, 90)
677:             .DeleteMark         = .F.
678:             .RecordMark         = .F.
679:             .RowHeight          = 16
680:             .ScrollBars         = 2
681:             .Visible            = .F.
682: 
683:             WITH .Column1
684:                 .Width           = 25
685:                 .Resizable       = .F.
686:                 .Header1.Caption = ""
687:                 .AddObject("Check1", "CheckBox")
688:                 .Check1.Caption  = ""
689:                 .Check1.Value    = 0
690:                 .CurrentControl  = "Check1"
691:             ENDWITH
692: 

*-- Linhas 703 a 727:
703:             ENDWITH
704:         ENDWITH
705: 
706:         *-- RecordSource e ControlSource ap" + CHR(243) + "s WITH (evita reset de cabe" + CHR(231) + "alhos)
707:         *   ControlSource da Column1 DEPOIS de CurrentControl (regra Error 1767)
708:         IF USED("CsSigCdEmp")
709:             loc_oGrd.RecordSource          = "CsSigCdEmp"
710:             loc_oGrd.Column1.ControlSource = "CsSigCdEmp.lMarca"
711:             loc_oGrd.Column2.ControlSource = "CsSigCdEmp.CEmps"
712:             loc_oGrd.Column3.ControlSource = "CsSigCdEmp.Razas"
713:             loc_oGrd.Column2.Header1.Caption = "C" + CHR(243) + "d."
714:             loc_oGrd.Column3.Header1.Caption = "Nome da Empresa"
715:         ENDIF
716: 
717:         *-- Bot" + CHR(227) + "o Marcar Todas as Empresas (cmdSelemp original: Top=332, Left=508, W=40, H=40)
718:         loc_oPag.AddObject("cmd_4c_CmdSelemp", "CommandButton")
719:         WITH loc_oPag.cmd_4c_CmdSelemp
720:             .Top           = 247
721:             .Left          = 508
722:             .Width         = 40
723:             .Height        = 40
724:             .Caption       = ""
725:             .Picture       = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
726:             .ToolTipText   = "Marcar Todas as Empresas"
727:             .FontName      = "Tahoma"

*-- Linhas 918 a 936:
918:         ENDIF
919: 
920:         IF USED("CrSigCdEmp")
921:             SELECT CrSigCdEmp
922:             SET ORDER TO CEmps
923:             IF SEEK(loc_cCodigo)
924:                 THIS.pgf_4c_Paginas.Page1.txt_4c_Dempresa.Value = ALLTRIM(CrSigCdEmp.Razas)
925:                 RETURN
926:             ENDIF
927:         ENDIF
928: 
929:         THIS.AbrirBuscaEmpresa()
930:     ENDPROC
931: 
932:     *--------------------------------------------------------------------------
933:     * AbrirBuscaEmpresa - FormBuscaAuxiliar Modo 1 para selecao de empresa
934:     *   Tabela: SigCdEmp | Cod: CEmps | Desc: Razas
935:     *--------------------------------------------------------------------------
936:     PROCEDURE AbrirBuscaEmpresa()

*-- Linhas 994 a 1012:
994:         ENDIF
995: 
996:         IF USED("CrSigCdEmp")
997:             SELECT CrSigCdEmp
998:             LOCATE FOR UPPER(ALLTRIM(Razas)) = UPPER(loc_cDesc)
999:             IF FOUND()
1000:                 loc_oPag.txt_4c_Empresa.Value  = ALLTRIM(CrSigCdEmp.CEmps)
1001:                 loc_oPag.txt_4c_Dempresa.Value = ALLTRIM(CrSigCdEmp.Razas)
1002:                 RETURN
1003:             ENDIF
1004:         ENDIF
1005: 
1006:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1007:             "SigCdEmp", "cursor_4c_BuscaEmp", "Razas", loc_cDesc, ;
1008:             "Empresa")
1009: 
1010:         IF VARTYPE(loc_oBusca) != "O"
1011:             RETURN
1012:         ENDIF

*-- Linhas 1059 a 1077:
1059:         ENDIF
1060: 
1061:         IF USED("CsBases")
1062:             SELECT CsBases
1063:             SET ORDER TO Bases
1064:             IF SEEK(loc_cValor)
1065:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DtBase.Value = ALLTRIM(CsBases.Bases)
1066:                 RETURN
1067:             ENDIF
1068:         ENDIF
1069: 
1070:         THIS.AbrirBuscaDtBase("DtBase")
1071:     ENDPROC
1072: 
1073:     *--------------------------------------------------------------------------
1074:     * AbrirBuscaDtBase - FormBuscaAuxiliar Modo 2 sobre cursor CsBases
1075:     *   par_cCampo: "DtBase" ou "DtBasea" para indicar qual campo preencher
1076:     *--------------------------------------------------------------------------
1077:     PROCEDURE AbrirBuscaDtBase(par_cCampo)

*-- Linhas 1133 a 1151:
1133:         ENDIF
1134: 
1135:         IF USED("CsBases")
1136:             SELECT CsBases
1137:             SET ORDER TO Bases
1138:             IF SEEK(loc_cValor)
1139:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DtBasea.Value = ALLTRIM(CsBases.Bases)
1140:                 RETURN
1141:             ENDIF
1142:         ENDIF
1143: 
1144:         THIS.AbrirBuscaDtBase("DtBasea")
1145:     ENDPROC
1146: 
1147:     *--------------------------------------------------------------------------
1148:     * TeclaCdMoeda - KeyPress do campo codigo de moeda
1149:     *   F4(115): abre busca; ENTER(13)/TAB(9): valida codigo em CrSigCdMoe
1150:     *--------------------------------------------------------------------------
1151:     PROCEDURE TeclaCdMoeda(par_nKeyCode, par_nShift)

*-- Linhas 1172 a 1190:
1172:         ENDIF
1173: 
1174:         IF USED("CrSigCdMoe")
1175:             SELECT CrSigCdMoe
1176:             SET ORDER TO CMoes
1177:             IF SEEK(loc_cCodigo)
1178:                 loc_oPag.txt_4c__ds_moeda.Value = ALLTRIM(CrSigCdMoe.DMoes)
1179:                 RETURN
1180:             ENDIF
1181:         ENDIF
1182: 
1183:         THIS.AbrirBuscaMoeda()
1184:     ENDPROC
1185: 
1186:     *--------------------------------------------------------------------------
1187:     * AbrirBuscaMoeda - FormBuscaAuxiliar para selecao de moeda
1188:     *   Tabela: SigCdMoe | Cod: CMoes | Desc: DMoes
1189:     *--------------------------------------------------------------------------
1190:     PROCEDURE AbrirBuscaMoeda()

*-- Linhas 1247 a 1265:
1247:         ENDIF
1248: 
1249:         IF USED("CrSigCdMoe")
1250:             SELECT CrSigCdMoe
1251:             LOCATE FOR UPPER(ALLTRIM(DMoes)) = UPPER(loc_cDesc)
1252:             IF FOUND()
1253:                 loc_oPag.txt_4c__cd_moeda.Value = ALLTRIM(CrSigCdMoe.CMoes)
1254:                 loc_oPag.txt_4c__ds_moeda.Value = ALLTRIM(CrSigCdMoe.DMoes)
1255:                 RETURN
1256:             ENDIF
1257:         ENDIF
1258: 
1259:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1260:             "SigCdMoe", "cursor_4c_BuscaMoe", "DMoes", loc_cDesc, ;
1261:             "Moeda")
1262: 
1263:         IF VARTYPE(loc_oBusca) != "O"
1264:             RETURN
1265:         ENDIF

*-- Linhas 1313 a 1335:
1313:             RETURN
1314:         ENDIF
1315: 
1316:         loc_cSQL    = "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cCodigo)
1317:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValGrEst")
1318: 
1319:         IF loc_nResult > 0
1320:             SELECT cursor_4c_ValGrEst
1321:             IF !EOF()
1322:                 loc_oPag.txt_4c__Ds_GrEstoque.Value = ALLTRIM(cursor_4c_ValGrEst.descrs)
1323:                 USE IN cursor_4c_ValGrEst
1324:                 RETURN
1325:             ENDIF
1326:             IF USED("cursor_4c_ValGrEst")
1327:                 USE IN cursor_4c_ValGrEst
1328:             ENDIF
1329:         ENDIF
1330: 
1331:         THIS.AbrirBuscaGrEstoque()
1332:     ENDPROC
1333: 
1334:     *--------------------------------------------------------------------------
1335:     * AbrirBuscaGrEstoque - FormBuscaAuxiliar para selecao do grupo de estoque

*-- Linhas 1395 a 1418:
1395:             RETURN
1396:         ENDIF
1397: 
1398:         loc_cSQL    = "SELECT codigos, descrs FROM SigCdGcr WHERE UPPER(descrs) LIKE '%" + ;
1399:                       UPPER(STRTRAN(loc_cDesc, "'", "''")) + "%'"
1400:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValGrEst")
1401: 
1402:         IF loc_nResult > 0
1403:             SELECT cursor_4c_ValGrEst
1404:             IF !EOF() AND RECCOUNT("cursor_4c_ValGrEst") = 1
1405:                 loc_oPag.txt_4c__Cd_GrEstoque.Value = ALLTRIM(cursor_4c_ValGrEst.codigos)
1406:                 loc_oPag.txt_4c__Ds_GrEstoque.Value = ALLTRIM(cursor_4c_ValGrEst.descrs)
1407:                 USE IN cursor_4c_ValGrEst
1408:                 RETURN
1409:             ENDIF
1410:             IF USED("cursor_4c_ValGrEst")
1411:                 USE IN cursor_4c_ValGrEst
1412:             ENDIF
1413:         ENDIF
1414: 
1415:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1416:             "SigCdGcr", "cursor_4c_BuscaGrEst", "descrs", loc_cDesc, ;
1417:             "Grupo de Estoque")
1418: 

*-- Linhas 1471 a 1493:
1471:             RETURN
1472:         ENDIF
1473: 
1474:         loc_cSQL    = "SELECT DISTINCT Contas FROM SigCdBal"
1475:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValEst")
1476: 
1477:         IF loc_nResult > 0
1478:             SELECT cursor_4c_ValEst
1479:             IF !EOF()
1480:                 loc_oPag.txt_4c_Ds_Estoque.Value = ALLTRIM(cursor_4c_ValEst.Contas)
1481:                 USE IN cursor_4c_ValEst
1482:                 RETURN
1483:             ENDIF
1484:             IF USED("cursor_4c_ValEst")
1485:                 USE IN cursor_4c_ValEst
1486:             ENDIF
1487:         ENDIF
1488: 
1489:         THIS.AbrirBuscaEstoque()
1490:     ENDPROC
1491: 
1492:     *--------------------------------------------------------------------------
1493:     * AbrirBuscaEstoque - FormBuscaAuxiliar para selecao de conta de estoque

*-- Linhas 1499 a 1525:
1499:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
1500:         loc_cGrupo = ALLTRIM(loc_oPag.txt_4c__Cd_GrEstoque.Value)
1501: 
1502:         loc_cSQL = "SELECT DISTINCT Contas FROM SigCdBal ORDER BY Contas"
1503:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEst")
1504: 
1505:         IF loc_nResult < 1
1506:             MsgErro("Erro ao buscar contas de estoque", "Erro")
1507:             RETURN
1508:         ENDIF
1509: 
1510:         SELECT cursor_4c_BuscaEst
1511:         GO TOP
1512: 
1513:         IF EOF()
1514:             MsgAviso("Nenhuma conta encontrada" + ;
1515:                 IIF(!EMPTY(loc_cGrupo), " para o grupo " + loc_cGrupo, "") + ".", ;
1516:                 "Busca")
1517:             USE IN cursor_4c_BuscaEst
1518:             RETURN
1519:         ENDIF
1520: 
1521:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1522:         IF VARTYPE(loc_oBusca) != "O"
1523:             MsgErro("Erro ao abrir busca de contas", "Erro")
1524:             USE IN cursor_4c_BuscaEst
1525:             RETURN

*-- Linhas 1582 a 1615:
1582:     *--------------------------------------------------------------------------
1583:     * ValidarIBarra - Valida numero de etiqueta em SigOpEtq (campo CBars)
1584:     *   Equivalente ao Valid original de GetiBarra:
1585:     *   Select CBars From SigOpEtq Where CBars = nBarra -> se nao achar avisa
1586:     *--------------------------------------------------------------------------
1587:     PROCEDURE ValidarIBarra()
1588:         LOCAL loc_nBarra, loc_cSQL, loc_nResult, loc_oPag
1589:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
1590:         loc_nBarra = loc_oPag.txt_4c_IBarra.Value
1591: 
1592:         IF loc_nBarra = 0
1593:             RETURN
1594:         ENDIF
1595: 
1596:         loc_cSQL    = "SELECT CBars FROM SigOpEtq WHERE CBars = " + ALLTRIM(STR(loc_nBarra, 8))
1597:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValBarra")
1598: 
1599:         IF loc_nResult > 0
1600:             SELECT cursor_4c_ValBarra
1601:             IF EOF()
1602:                 IF USED("cursor_4c_ValBarra")
1603:                     USE IN cursor_4c_ValBarra
1604:                 ENDIF
1605:                 MsgAviso("Etiqueta n" + CHR(227) + "o Encontrada !!!", ;
1606:                     "Valida" + CHR(231) + CHR(227) + "o")
1607:                 loc_oPag.txt_4c_IBarra.Value = 0
1608:                 RETURN
1609:             ENDIF
1610:             IF USED("cursor_4c_ValBarra")
1611:                 USE IN cursor_4c_ValBarra
1612:             ENDIF
1613:         ELSE
1614:             MsgErro("Erro ao validar n" + CHR(250) + "mero de etiqueta", "Erro")
1615:         ENDIF

*-- Linhas 1746 a 1781:
1746: 
1747:     *--------------------------------------------------------------------------
1748:     * CmdSelempClick - Marca todas as empresas no grid (lMarca=1)
1749:     *   Equivalente ao cmdSelemp.Click original: Update CsSigCdEmp Set lMarca=1
1750:     *--------------------------------------------------------------------------
1751:     PROCEDURE CmdSelempClick()
1752:         IF USED("CsSigCdEmp")
1753:             SELECT CsSigCdEmp
1754:             REPLACE ALL lMarca WITH 1
1755:             GO TOP
1756:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh
1757:         ENDIF
1758:     ENDPROC
1759: 
1760:     *--------------------------------------------------------------------------
1761:     * CmdApgEmpClick - Desmarca todas as empresas no grid (lMarca=0)
1762:     *   Equivalente ao CmdApgEmp.Click original: Update CsSigCdEmp Set lMarca=0
1763:     *--------------------------------------------------------------------------
1764:     PROCEDURE CmdApgEmpClick()
1765:         IF USED("CsSigCdEmp")
1766:             SELECT CsSigCdEmp
1767:             REPLACE ALL lMarca WITH 0
1768:             GO TOP
1769:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh
1770:         ENDIF
1771:     ENDPROC
1772: 
1773:     *==========================================================================
1774:     * COMPATIBILIDADE CRUD (mapeamento semantico de botoes para form REPORT)
1775:     *   Form REPORT (frmrelatorio) nao possui operacoes CRUD nativas. Estes
1776:     *   metodos existem para compatibilidade com o pipeline generico do sistema
1777:     *   e mapeiam acoes CRUD para operacoes equivalentes no contexto de relatorio:
1778:     *     - BtnIncluirClick  -> Visualizar (gera e exibe o relatorio)
1779:     *     - BtnAlterarClick  -> LimparCampos + foco no 1o filtro (reset edicao)
1780:     *     - BtnExcluirClick  -> LimparCampos (limpa filtros = "remove" selecao)
1781:     *==========================================================================

*-- Linhas 1897 a 1917:
1897: 
1898:         IF USED("CsSigCdEmp")
1899:             loc_oGrd.RecordSource          = "CsSigCdEmp"
1900:             loc_oGrd.Column1.ControlSource = "CsSigCdEmp.lMarca"
1901:             loc_oGrd.Column2.ControlSource = "CsSigCdEmp.CEmps"
1902:             loc_oGrd.Column3.ControlSource = "CsSigCdEmp.Razas"
1903:             loc_oGrd.Column2.Header1.Caption = "C" + CHR(243) + "d."
1904:             loc_oGrd.Column3.Header1.Caption = "Nome da Empresa"
1905:             loc_oGrd.Refresh
1906:         ENDIF
1907:     ENDPROC
1908: 
1909:     *--------------------------------------------------------------------------
1910:     * AjustarBotoesPorModo - Em REPORT os botoes do CommandGroup ficam sempre
1911:     *   habilitados (nao ha modo INCLUIR/ALTERAR/VISUALIZAR como no CRUD)
1912:     *--------------------------------------------------------------------------
1913:     PROCEDURE AjustarBotoesPorModo()
1914:         IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
1915:             THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
1916:             THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
1917:             THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.


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

