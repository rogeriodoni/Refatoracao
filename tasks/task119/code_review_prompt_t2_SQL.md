# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DTBASES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNTIPO, LMARCA, EMPS, CODIGOS, APURAS, LCDATABASE, BARRAS, NUMS, CBARS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNTIPO, LMARCA, EMPS, CODIGOS, APURAS, LCDATABASE, BARRAS, NUMS, CBARS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'GRUPOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNTIPO, LMARCA, EMPS, CODIGOS, APURAS, LCDATABASE, BARRAS, NUMS, CBARS

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReIfv.prg) - TRECHOS RELEVANTES PARA PASS SQL (1919 linhas total):

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

*-- Linhas 646 a 681:
646:         *-- Grid de sele" + CHR(231) + CHR(227) + "o de Empresas (GrdEmp original: Top=266, Left=163, W=342, H=147)
647:         *   3 colunas: CheckBox(lMarca) | C" + CHR(243) + "d.(CEmps) | Nome da Empresa(DEmps)
648:         *   Vis" + CHR(237) + "vel apenas quando Tipo=2 (Sint" + CHR(233) + "tico)
649:         *   Ordem OBRIGAT" + CHR(211) + "RIA da Column1: AddObject(Check1) -> CurrentControl -> ControlSource
650:         loc_oPag.AddObject("grd_4c_Dados", "Grid")
651:         loc_oGrd = loc_oPag.grd_4c_Dados
652:         WITH loc_oGrd
653:             .Top                = 186
654:             .Left               = 163
655:             .Width              = 342
656:             .Height             = 147
657:             .ColumnCount        = 3
658:             .FontName           = "Verdana"
659:             .FontSize           = 8
660:             .HighlightStyle     = 2
661:             .HighlightBackColor = RGB(255, 255, 255)
662:             .HighlightForeColor = RGB(15, 41, 104)
663:             .GridLineColor      = RGB(238, 238, 238)
664:             .BackColor          = RGB(255, 255, 255)
665:             .ForeColor          = RGB(90, 90, 90)
666:             .DeleteMark         = .F.
667:             .RecordMark         = .F.
668:             .RowHeight          = 16
669:             .ScrollBars         = 2
670:             .Visible            = .F.
671: 
672:             WITH .Column1
673:                 .Width           = 25
674:                 .Resizable       = .F.
675:                 .Header1.Caption = ""
676:                 .AddObject("Check1", "CheckBox")
677:                 .Check1.Caption  = ""
678:                 .Check1.Value    = 0
679:                 .CurrentControl  = "Check1"
680:             ENDWITH
681: 

*-- Linhas 692 a 716:
692:             ENDWITH
693:         ENDWITH
694: 
695:         *-- RecordSource e ControlSource ap" + CHR(243) + "s WITH (evita reset de cabe" + CHR(231) + "alhos)
696:         *   ControlSource da Column1 DEPOIS de CurrentControl (regra Error 1767)
697:         IF USED("CsSigCdEmp")
698:             loc_oGrd.RecordSource          = "CsSigCdEmp"
699:             loc_oGrd.Column1.ControlSource = "CsSigCdEmp.lMarca"
700:             loc_oGrd.Column2.ControlSource = "CsSigCdEmp.CEmps"
701:             loc_oGrd.Column3.ControlSource = "CsSigCdEmp.Razas"
702:             loc_oGrd.Column2.Header1.Caption = "C" + CHR(243) + "d."
703:             loc_oGrd.Column3.Header1.Caption = "Nome da Empresa"
704:         ENDIF
705: 
706:         *-- Bot" + CHR(227) + "o Marcar Todas as Empresas (cmdSelemp original: Top=332, Left=508, W=40, H=40)
707:         loc_oPag.AddObject("cmd_4c_CmdSelemp", "CommandButton")
708:         WITH loc_oPag.cmd_4c_CmdSelemp
709:             .Top           = 252
710:             .Left          = 508
711:             .Width         = 40
712:             .Height        = 40
713:             .Caption       = ""
714:             .Picture       = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
715:             .ToolTipText   = "Marcar Todas as Empresas"
716:             .FontName      = "Tahoma"

*-- Linhas 907 a 925:
907:         ENDIF
908: 
909:         IF USED("CrSigCdEmp")
910:             SELECT CrSigCdEmp
911:             SET ORDER TO CEmps
912:             IF SEEK(loc_cCodigo)
913:                 THIS.pgf_4c_Paginas.Page1.txt_4c_Dempresa.Value = ALLTRIM(CrSigCdEmp.Razas)
914:                 RETURN
915:             ENDIF
916:         ENDIF
917: 
918:         THIS.AbrirBuscaEmpresa()
919:     ENDPROC
920: 
921:     *--------------------------------------------------------------------------
922:     * AbrirBuscaEmpresa - FormBuscaAuxiliar Modo 1 para selecao de empresa
923:     *   Tabela: SigCdEmp | Cod: CEmps | Desc: Razas
924:     *--------------------------------------------------------------------------
925:     PROCEDURE AbrirBuscaEmpresa()

*-- Linhas 983 a 1001:
983:         ENDIF
984: 
985:         IF USED("CrSigCdEmp")
986:             SELECT CrSigCdEmp
987:             LOCATE FOR UPPER(ALLTRIM(Razas)) = UPPER(loc_cDesc)
988:             IF FOUND()
989:                 loc_oPag.txt_4c_Empresa.Value  = ALLTRIM(CrSigCdEmp.CEmps)
990:                 loc_oPag.txt_4c_Dempresa.Value = ALLTRIM(CrSigCdEmp.Razas)
991:                 RETURN
992:             ENDIF
993:         ENDIF
994: 
995:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
996:             "SigCdEmp", "cursor_4c_BuscaEmp", "Razas", loc_cDesc, ;
997:             "Empresa")
998: 
999:         IF VARTYPE(loc_oBusca) != "O"
1000:             RETURN
1001:         ENDIF

*-- Linhas 1048 a 1066:
1048:         ENDIF
1049: 
1050:         IF USED("CsBases")
1051:             SELECT CsBases
1052:             SET ORDER TO Bases
1053:             IF SEEK(loc_cValor)
1054:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DtBase.Value = ALLTRIM(CsBases.Bases)
1055:                 RETURN
1056:             ENDIF
1057:         ENDIF
1058: 
1059:         THIS.AbrirBuscaDtBase("DtBase")
1060:     ENDPROC
1061: 
1062:     *--------------------------------------------------------------------------
1063:     * AbrirBuscaDtBase - FormBuscaAuxiliar Modo 2 sobre cursor CsBases
1064:     *   par_cCampo: "DtBase" ou "DtBasea" para indicar qual campo preencher
1065:     *--------------------------------------------------------------------------
1066:     PROCEDURE AbrirBuscaDtBase(par_cCampo)

*-- Linhas 1122 a 1140:
1122:         ENDIF
1123: 
1124:         IF USED("CsBases")
1125:             SELECT CsBases
1126:             SET ORDER TO Bases
1127:             IF SEEK(loc_cValor)
1128:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DtBasea.Value = ALLTRIM(CsBases.Bases)
1129:                 RETURN
1130:             ENDIF
1131:         ENDIF
1132: 
1133:         THIS.AbrirBuscaDtBase("DtBasea")
1134:     ENDPROC
1135: 
1136:     *--------------------------------------------------------------------------
1137:     * TeclaCdMoeda - KeyPress do campo codigo de moeda
1138:     *   F4(115): abre busca; ENTER(13)/TAB(9): valida codigo em CrSigCdMoe
1139:     *--------------------------------------------------------------------------
1140:     PROCEDURE TeclaCdMoeda(par_nKeyCode, par_nShift)

*-- Linhas 1161 a 1179:
1161:         ENDIF
1162: 
1163:         IF USED("CrSigCdMoe")
1164:             SELECT CrSigCdMoe
1165:             SET ORDER TO CMoes
1166:             IF SEEK(loc_cCodigo)
1167:                 loc_oPag.txt_4c__ds_moeda.Value = ALLTRIM(CrSigCdMoe.DMoes)
1168:                 RETURN
1169:             ENDIF
1170:         ENDIF
1171: 
1172:         THIS.AbrirBuscaMoeda()
1173:     ENDPROC
1174: 
1175:     *--------------------------------------------------------------------------
1176:     * AbrirBuscaMoeda - FormBuscaAuxiliar para selecao de moeda
1177:     *   Tabela: SigCdMoe | Cod: CMoes | Desc: DMoes
1178:     *--------------------------------------------------------------------------
1179:     PROCEDURE AbrirBuscaMoeda()

*-- Linhas 1236 a 1254:
1236:         ENDIF
1237: 
1238:         IF USED("CrSigCdMoe")
1239:             SELECT CrSigCdMoe
1240:             LOCATE FOR UPPER(ALLTRIM(DMoes)) = UPPER(loc_cDesc)
1241:             IF FOUND()
1242:                 loc_oPag.txt_4c__cd_moeda.Value = ALLTRIM(CrSigCdMoe.CMoes)
1243:                 loc_oPag.txt_4c__ds_moeda.Value = ALLTRIM(CrSigCdMoe.DMoes)
1244:                 RETURN
1245:             ENDIF
1246:         ENDIF
1247: 
1248:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1249:             "SigCdMoe", "cursor_4c_BuscaMoe", "DMoes", loc_cDesc, ;
1250:             "Moeda")
1251: 
1252:         IF VARTYPE(loc_oBusca) != "O"
1253:             RETURN
1254:         ENDIF

*-- Linhas 1302 a 1324:
1302:             RETURN
1303:         ENDIF
1304: 
1305:         loc_cSQL    = "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cCodigo)
1306:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValGrEst")
1307: 
1308:         IF loc_nResult > 0
1309:             SELECT cursor_4c_ValGrEst
1310:             IF !EOF()
1311:                 loc_oPag.txt_4c__Ds_GrEstoque.Value = ALLTRIM(cursor_4c_ValGrEst.descrs)
1312:                 USE IN cursor_4c_ValGrEst
1313:                 RETURN
1314:             ENDIF
1315:             IF USED("cursor_4c_ValGrEst")
1316:                 USE IN cursor_4c_ValGrEst
1317:             ENDIF
1318:         ENDIF
1319: 
1320:         THIS.AbrirBuscaGrEstoque()
1321:     ENDPROC
1322: 
1323:     *--------------------------------------------------------------------------
1324:     * AbrirBuscaGrEstoque - FormBuscaAuxiliar para selecao do grupo de estoque

*-- Linhas 1384 a 1407:
1384:             RETURN
1385:         ENDIF
1386: 
1387:         loc_cSQL    = "SELECT codigos, descrs FROM SigCdGcr WHERE UPPER(descrs) LIKE '%" + ;
1388:                       UPPER(STRTRAN(loc_cDesc, "'", "''")) + "%'"
1389:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValGrEst")
1390: 
1391:         IF loc_nResult > 0
1392:             SELECT cursor_4c_ValGrEst
1393:             IF !EOF() AND RECCOUNT("cursor_4c_ValGrEst") = 1
1394:                 loc_oPag.txt_4c__Cd_GrEstoque.Value = ALLTRIM(cursor_4c_ValGrEst.codigos)
1395:                 loc_oPag.txt_4c__Ds_GrEstoque.Value = ALLTRIM(cursor_4c_ValGrEst.descrs)
1396:                 USE IN cursor_4c_ValGrEst
1397:                 RETURN
1398:             ENDIF
1399:             IF USED("cursor_4c_ValGrEst")
1400:                 USE IN cursor_4c_ValGrEst
1401:             ENDIF
1402:         ENDIF
1403: 
1404:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1405:             "SigCdGcr", "cursor_4c_BuscaGrEst", "descrs", loc_cDesc, ;
1406:             "Grupo de Estoque")
1407: 

*-- Linhas 1460 a 1486:
1460:             RETURN
1461:         ENDIF
1462: 
1463:         loc_cSQL = "SELECT DISTINCT Contas FROM SigCdBal WHERE Contas = " + EscaparSQL(loc_cCodigo)
1464:         IF !EMPTY(loc_cGrupo)
1465:             loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(loc_cGrupo)
1466:         ENDIF
1467: 
1468:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValEst")
1469: 
1470:         IF loc_nResult > 0
1471:             SELECT cursor_4c_ValEst
1472:             IF !EOF()
1473:                 loc_oPag.txt_4c_Ds_Estoque.Value = ALLTRIM(cursor_4c_ValEst.Contas)
1474:                 USE IN cursor_4c_ValEst
1475:                 RETURN
1476:             ENDIF
1477:             IF USED("cursor_4c_ValEst")
1478:                 USE IN cursor_4c_ValEst
1479:             ENDIF
1480:         ENDIF
1481: 
1482:         THIS.AbrirBuscaEstoque()
1483:     ENDPROC
1484: 
1485:     *--------------------------------------------------------------------------
1486:     * AbrirBuscaEstoque - FormBuscaAuxiliar para selecao de conta de estoque

*-- Linhas 1492 a 1522:
1492:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
1493:         loc_cGrupo = ALLTRIM(loc_oPag.txt_4c__Cd_GrEstoque.Value)
1494: 
1495:         loc_cSQL = "SELECT DISTINCT Contas FROM SigCdBal WHERE Contas IS NOT NULL AND LEN(RTRIM(Contas)) > 0"
1496:         IF !EMPTY(loc_cGrupo)
1497:             loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(loc_cGrupo)
1498:         ENDIF
1499:         loc_cSQL    = loc_cSQL + " ORDER BY Contas"
1500:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEst")
1501: 
1502:         IF loc_nResult < 1
1503:             MsgErro("Erro ao buscar contas de estoque", "Erro")
1504:             RETURN
1505:         ENDIF
1506: 
1507:         SELECT cursor_4c_BuscaEst
1508:         GO TOP
1509: 
1510:         IF EOF()
1511:             MsgAviso("Nenhuma conta encontrada" + ;
1512:                 IIF(!EMPTY(loc_cGrupo), " para o grupo " + loc_cGrupo, "") + ".", ;
1513:                 "Busca")
1514:             USE IN cursor_4c_BuscaEst
1515:             RETURN
1516:         ENDIF
1517: 
1518:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1519:         IF VARTYPE(loc_oBusca) != "O"
1520:             MsgErro("Erro ao abrir busca de contas", "Erro")
1521:             USE IN cursor_4c_BuscaEst
1522:             RETURN

*-- Linhas 1579 a 1612:
1579:     *--------------------------------------------------------------------------
1580:     * ValidarIBarra - Valida numero de etiqueta em SigOpEtq (campo CBars)
1581:     *   Equivalente ao Valid original de GetiBarra:
1582:     *   Select CBars From SigOpEtq Where CBars = nBarra -> se nao achar avisa
1583:     *--------------------------------------------------------------------------
1584:     PROCEDURE ValidarIBarra()
1585:         LOCAL loc_nBarra, loc_cSQL, loc_nResult, loc_oPag
1586:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
1587:         loc_nBarra = loc_oPag.txt_4c_IBarra.Value
1588: 
1589:         IF loc_nBarra = 0
1590:             RETURN
1591:         ENDIF
1592: 
1593:         loc_cSQL    = "SELECT CBars FROM SigOpEtq WHERE CBars = " + ALLTRIM(STR(loc_nBarra, 8))
1594:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValBarra")
1595: 
1596:         IF loc_nResult > 0
1597:             SELECT cursor_4c_ValBarra
1598:             IF EOF()
1599:                 IF USED("cursor_4c_ValBarra")
1600:                     USE IN cursor_4c_ValBarra
1601:                 ENDIF
1602:                 MsgAviso("Etiqueta n" + CHR(227) + "o Encontrada !!!", ;
1603:                     "Valida" + CHR(231) + CHR(227) + "o")
1604:                 loc_oPag.txt_4c_IBarra.Value = 0
1605:                 RETURN
1606:             ENDIF
1607:             IF USED("cursor_4c_ValBarra")
1608:                 USE IN cursor_4c_ValBarra
1609:             ENDIF
1610:         ELSE
1611:             MsgErro("Erro ao validar n" + CHR(250) + "mero de etiqueta", "Erro")
1612:         ENDIF

*-- Linhas 1743 a 1778:
1743: 
1744:     *--------------------------------------------------------------------------
1745:     * CmdSelempClick - Marca todas as empresas no grid (lMarca=1)
1746:     *   Equivalente ao cmdSelemp.Click original: Update CsSigCdEmp Set lMarca=1
1747:     *--------------------------------------------------------------------------
1748:     PROCEDURE CmdSelempClick()
1749:         IF USED("CsSigCdEmp")
1750:             SELECT CsSigCdEmp
1751:             REPLACE ALL lMarca WITH 1
1752:             GO TOP
1753:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh
1754:         ENDIF
1755:     ENDPROC
1756: 
1757:     *--------------------------------------------------------------------------
1758:     * CmdApgEmpClick - Desmarca todas as empresas no grid (lMarca=0)
1759:     *   Equivalente ao CmdApgEmp.Click original: Update CsSigCdEmp Set lMarca=0
1760:     *--------------------------------------------------------------------------
1761:     PROCEDURE CmdApgEmpClick()
1762:         IF USED("CsSigCdEmp")
1763:             SELECT CsSigCdEmp
1764:             REPLACE ALL lMarca WITH 0
1765:             GO TOP
1766:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh
1767:         ENDIF
1768:     ENDPROC
1769: 
1770:     *==========================================================================
1771:     * COMPATIBILIDADE CRUD (mapeamento semantico de botoes para form REPORT)
1772:     *   Form REPORT (frmrelatorio) nao possui operacoes CRUD nativas. Estes
1773:     *   metodos existem para compatibilidade com o pipeline generico do sistema
1774:     *   e mapeiam acoes CRUD para operacoes equivalentes no contexto de relatorio:
1775:     *     - BtnIncluirClick  -> Visualizar (gera e exibe o relatorio)
1776:     *     - BtnAlterarClick  -> LimparCampos + foco no 1o filtro (reset edicao)
1777:     *     - BtnExcluirClick  -> LimparCampos (limpa filtros = "remove" selecao)
1778:     *==========================================================================

*-- Linhas 1894 a 1914:
1894: 
1895:         IF USED("CsSigCdEmp")
1896:             loc_oGrd.RecordSource          = "CsSigCdEmp"
1897:             loc_oGrd.Column1.ControlSource = "CsSigCdEmp.lMarca"
1898:             loc_oGrd.Column2.ControlSource = "CsSigCdEmp.CEmps"
1899:             loc_oGrd.Column3.ControlSource = "CsSigCdEmp.Razas"
1900:             loc_oGrd.Column2.Header1.Caption = "C" + CHR(243) + "d."
1901:             loc_oGrd.Column3.Header1.Caption = "Nome da Empresa"
1902:             loc_oGrd.Refresh
1903:         ENDIF
1904:     ENDPROC
1905: 
1906:     *--------------------------------------------------------------------------
1907:     * AjustarBotoesPorModo - Em REPORT os botoes do CommandGroup ficam sempre
1908:     *   habilitados (nao ha modo INCLUIR/ALTERAR/VISUALIZAR como no CRUD)
1909:     *--------------------------------------------------------------------------
1910:     PROCEDURE AjustarBotoesPorModo()
1911:         IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
1912:             THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
1913:             THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
1914:             THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.


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

