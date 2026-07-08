# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'HEADERHEIGHT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, I, I2, CODIGOS, NFISCALS, DOPES, EMIS, CBXSUBNS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, I, I2, CODIGOS, NFISCALS, DOPES, EMIS, CBXSUBNS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, I, I2, CODIGOS, NFISCALS, DOPES, EMIS, CBXSUBNS

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
  DeleteMark = .F.
  DeleteMark = .F.
Insert Into crCabecalho (Titulo, Subtitulo, Periodo, SubTotDia) ;
	Select csEntradas
	Select csSaidas
lcQuery = [Select ' ' as Baixas, 'E' as Movimento, n.Emis, n.NFis, n.Series, n.CFis, n.CfoSubs, n.Emps, ] + ;
		    [From SigCdOpe o, SigMvNfi n, SigCdCli c ] + ;
		  [Select ' ' as Baixas, 'S' as Movimento, n.Emis, n.NFis, n.Series, n.CFis, n.CfoSubs, n.Emps, ] + ;
		    [From SigCdOpe o, SigMvNfi n, SigCdCli c ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crDados1]) < 1)
Select crDados1
	lcQuery = [Select e.EmpDopNums, p.EmpDopNums ] + ;
				[From SigMvCab e, SigCdOpe o, SigMvPec p, SigCdOpe o2 ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crBaixas]) < 1)
	Select crBaixas
	Select * ;
	  From crDados1 ;
	Select Movimento, Sum(TotNotas) as TotNotas, Sum(ValICms) as ValICms, Sum(ICmsS) as ICmsS, Sum(ValIpis) as ValIpis ;
	  From crDados1 ;
Select crDados
		Select LocalEmp
				.DeleteMark 		= .f.
				.Column1.ControlSource   = [csOperacoes] + lcGrd + [.SelImp]
				.Column2.ControlSource 	 = [csOperacoes] + lcGrd + [.Codigos]
				.Column3.ControlSource 	 = [csOperacoes] + lcGrd + [.Descrs]
			Select crSigCdTom
				Insert Into csOperacoes&lcGrd. (SelImp, Codigos, Descrs) ;
			Select csOperacoes&lcGrd.
	Select * From csOperacoesE Where SelImp Into Cursor csEntradas
	Select * From csOperacoesS Where SelImp Into Cursor csSaidas
	Select csSaidas
		Select csEntradas
Update csOperacoesE Set SelImp = (This.Value = 1)
Update csOperacoesS Set SelImp = (This.Value = 1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreimp.prg) - TRECHOS RELEVANTES PARA PASS SQL (1701 linhas total):

*-- Linhas 112 a 130:
112: *   - config.prg: ADIR() em start/config.prg ja carrega *BO.prg e Form*.prg
113: *     automaticamente (linhas 263 e 293). Nenhuma alteracao manual necessaria.
114: *   - menu.prg: BAR 154 (separador) + BAR 155 ("Comparativo de Impostos") no
115: *     popRelatorios apos BAR 153. ON SELECTION BAR 155 -> AbrirFormsigreimp.
116: *     PROCEDURE AbrirFormsigreimp() criada no fim do menu.prg seguindo o
117: *     padrao canonico (VARTYPE = "O", Show() sem parametro, sem .Release()
118: *     apos Show, MostrarErro para excecoes).
119: *==============================================================================
120: 
121: DEFINE CLASS Formsigreimp AS FormBase
122: 
123:     *-- Dimensoes e aparencia (original 800x500 escalado para 1000x600)
124:     Height      = 600
125:     Width       = 1000
126:     DataSession = 2
127:     ShowWindow  = 1
128:     WindowType  = 1
129:     AutoCenter  = .T.
130:     BorderStyle = 2

*-- Linhas 709 a 744:
709:     * Column2: Codigo (Codigos, numerico, somente leitura)
710:     * Column3: Descricao (Descrs, char, somente leitura)
711:     * Regra: Column1.AddObject("Check1") ANTES de CurrentControl
712:     *        ControlSource APENAS no Column, NUNCA no Check1
713:     *        ControlSource definido DEPOIS de CurrentControl e RecordSource
714:     *--------------------------------------------------------------------------
715:     PROTECTED PROCEDURE ConfigurarGradeEntradas(par_oPagina)
716:         LOCAL loc_oCursor
717:         loc_oCursor = THIS.this_oRelatorio.this_cCursorOperacoesE
718: 
719:         par_oPagina.AddObject("grd_4c_OperacoesE", "Grid")
720: 
721:         WITH par_oPagina.grd_4c_OperacoesE
722:             .Top                = 173
723:             .Left               = 30
724:             .Width              = 460
725:             .Height             = 220
726:             .ColumnCount        = 3
727:             .FontName           = "Verdana"
728:             .FontSize           = 8
729:             .DeleteMark         = .F.
730:             .RecordMark         = .F.
731:             .HeaderHeight       = 0
732:             .AllowHeaderSizing  = .F.
733:             .AllowRowSizing     = .F.
734:             .Themes             = .F.
735:             .HighlightStyle     = 2
736:             .HighlightBackColor = RGB(255, 255, 255)
737:             .HighlightForeColor = RGB(15, 41, 104)
738:             .GridLineColor      = RGB(238, 238, 238)
739:             .BackColor          = RGB(255, 255, 255)
740:             .ScrollBars         = 2
741:             .RowHeight          = 16
742: 
743:             *-- Column 1: CheckBox para selecao
744:             *-- Sparse=.F. garante checkbox visivel em TODAS as linhas (nao apenas na corrente)

*-- Linhas 764 a 791:
764:             .Column3.Width    = 360
765:             .Column3.ReadOnly = .T.
766: 
767:             *-- RecordSource apos CurrentControl (pode resetar ControlSources)
768:             IF USED(loc_oCursor)
769:                 .RecordSource = loc_oCursor
770:             ENDIF
771: 
772:             *-- ControlSources apos RecordSource e apos CurrentControl
773:             IF USED(loc_oCursor)
774:                 .Column1.ControlSource = loc_oCursor + ".SelImp"
775:                 .Column2.ControlSource = loc_oCursor + ".Codigos"
776:                 .Column3.ControlSource = loc_oCursor + ".Descrs"
777:             ENDIF
778: 
779:             *-- Headers (ocultos por HeaderHeight=0, mantidos para referencia)
780:             .Column1.Header1.Caption = ""
781:             .Column2.Header1.Caption = ""
782:             .Column3.Header1.Caption = "C" + CHR(243) + "digos"
783: 
784:             .FontName = "Verdana"
785:             .FontSize = 8
786: 
787:             .Visible = .T.
788:         ENDWITH
789:     ENDPROC
790: 
791:     *--------------------------------------------------------------------------

*-- Linhas 806 a 824:
806:             .ColumnCount        = 3
807:             .FontName           = "Verdana"
808:             .FontSize           = 8
809:             .DeleteMark         = .F.
810:             .RecordMark         = .F.
811:             .HeaderHeight       = 0
812:             .AllowHeaderSizing  = .F.
813:             .AllowRowSizing     = .F.
814:             .Themes             = .F.
815:             .HighlightStyle     = 2
816:             .HighlightBackColor = RGB(255, 255, 255)
817:             .HighlightForeColor = RGB(15, 41, 104)
818:             .GridLineColor      = RGB(238, 238, 238)
819:             .BackColor          = RGB(255, 255, 255)
820:             .ScrollBars         = 2
821:             .RowHeight          = 16
822: 
823:             *-- Sparse=.F. garante checkbox visivel em TODAS as linhas
824:             .Column1.Width = 30

*-- Linhas 846 a 866:
846:             ENDIF
847: 
848:             IF USED(loc_oCursor)
849:                 .Column1.ControlSource = loc_oCursor + ".SelImp"
850:                 .Column2.ControlSource = loc_oCursor + ".Codigos"
851:                 .Column3.ControlSource = loc_oCursor + ".Descrs"
852:             ENDIF
853: 
854:             *-- Headers (ocultos por HeaderHeight=0, mantidos para referencia)
855:             .Column1.Header1.Caption = ""
856:             .Column2.Header1.Caption = ""
857:             .Column3.Header1.Caption = "C" + CHR(243) + "digos"
858: 
859:             .FontName = "Verdana"
860:             .FontSize = 8
861: 
862:             .Visible = .T.
863:         ENDWITH
864:     ENDPROC
865: 
866:     *--------------------------------------------------------------------------

*-- Linhas 1048 a 1071:
1048:             IF !EMPTY(loc_cCodEmpresa)
1049:                 THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value = loc_cCodEmpresa
1050: 
1051:                 loc_cSQL = "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Cemps = " + ;
1052:                     EscaparSQL(loc_cCodEmpresa)
1053:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpIni")
1054: 
1055:                 IF loc_nResult > 0
1056:                     SELECT cursor_4c_EmpIni
1057:                     IF !EOF()
1058:                         THIS.pgf_4c_Paginas.Page1.txt_4c_DEmpresa.Value = ;
1059:                             ALLTRIM(cursor_4c_EmpIni.Razas)
1060:                     ENDIF
1061:                     IF USED("cursor_4c_EmpIni")
1062:                         USE IN cursor_4c_EmpIni
1063:                     ENDIF
1064:                 ENDIF
1065:             ENDIF
1066:         CATCH TO loc_oErro
1067:             MsgErro(loc_oErro.Message, "Erro")
1068:         ENDTRY
1069:     ENDPROC
1070: 
1071:     *--------------------------------------------------------------------------

*-- Linhas 1092 a 1116:
1092: 
1093:         *-- Refresh grids para garantir ultimo estado do CheckBox no cursor
1094:         IF USED(loc_cCursorE) AND VARTYPE(loc_oPagina.grd_4c_OperacoesE) = "O"
1095:             SELECT (loc_cCursorE)
1096:             GO BOTTOM
1097:             loc_oPagina.grd_4c_OperacoesE.Refresh()
1098:             GO TOP
1099:         ENDIF
1100:         IF USED(loc_cCursorS) AND VARTYPE(loc_oPagina.grd_4c_OperacoesS) = "O"
1101:             SELECT (loc_cCursorS)
1102:             GO BOTTOM
1103:             loc_oPagina.grd_4c_OperacoesS.Refresh()
1104:             GO TOP
1105:         ENDIF
1106: 
1107:         THIS.FormParaRelatorio()
1108:         IF THIS.this_oRelatorio.ValidarFiltros()
1109:             IF !THIS.this_oRelatorio.Visualizar()
1110:                 MsgAviso(THIS.this_oRelatorio.ObterMensagemErro(), ;
1111:                     "Relat" + CHR(243) + "rio")
1112:             ENDIF
1113:         ELSE
1114:             MsgAviso(THIS.this_oRelatorio.ObterMensagemErro(), ;
1115:                 "Filtros Inv" + CHR(225) + "lidos")
1116:         ENDIF

*-- Linhas 1129 a 1153:
1129: 
1130:         *-- Refresh grids para garantir ultimo estado do CheckBox no cursor
1131:         IF USED(loc_cCursorE) AND VARTYPE(loc_oPagina.grd_4c_OperacoesE) = "O"
1132:             SELECT (loc_cCursorE)
1133:             GO BOTTOM
1134:             loc_oPagina.grd_4c_OperacoesE.Refresh()
1135:             GO TOP
1136:         ENDIF
1137:         IF USED(loc_cCursorS) AND VARTYPE(loc_oPagina.grd_4c_OperacoesS) = "O"
1138:             SELECT (loc_cCursorS)
1139:             GO BOTTOM
1140:             loc_oPagina.grd_4c_OperacoesS.Refresh()
1141:             GO TOP
1142:         ENDIF
1143: 
1144:         THIS.FormParaRelatorio()
1145:         IF THIS.this_oRelatorio.ValidarFiltros()
1146:             IF !THIS.this_oRelatorio.Imprimir()
1147:                 MsgAviso(THIS.this_oRelatorio.ObterMensagemErro(), ;
1148:                     "Relat" + CHR(243) + "rio")
1149:             ENDIF
1150:         ELSE
1151:             MsgAviso(THIS.this_oRelatorio.ObterMensagemErro(), ;
1152:                 "Filtros Inv" + CHR(225) + "lidos")
1153:         ENDIF

*-- Linhas 1174 a 1210:
1174:         loc_lMarcar = (loc_oPagina.cmg_4c_BtnGradeE.Value = 1)
1175: 
1176:         IF USED(loc_cCursor)
1177:             SELECT (loc_cCursor)
1178:             REPLACE ALL SelImp WITH loc_lMarcar
1179:             GO TOP
1180:             loc_oPagina.grd_4c_OperacoesE.Refresh()
1181:         ENDIF
1182:     ENDPROC
1183: 
1184:     *--------------------------------------------------------------------------
1185:     * CmgGradeSClick - Marcar ou desmarcar todos os tipos de Saidas
1186:     * Handler BINDEVENT do cmg_4c_BtnGradeS - deve ser PUBLIC
1187:     *--------------------------------------------------------------------------
1188:     PROCEDURE CmgGradeSClick()
1189:         LOCAL loc_oPagina, loc_cCursor, loc_lMarcar
1190:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1191:         loc_cCursor = THIS.this_oRelatorio.this_cCursorOperacoesS
1192:         loc_lMarcar = (loc_oPagina.cmg_4c_BtnGradeS.Value = 1)
1193: 
1194:         IF USED(loc_cCursor)
1195:             SELECT (loc_cCursor)
1196:             REPLACE ALL SelImp WITH loc_lMarcar
1197:             GO TOP
1198:             loc_oPagina.grd_4c_OperacoesS.Refresh()
1199:         ENDIF
1200:     ENDPROC
1201: 
1202:     *--------------------------------------------------------------------------
1203:     * TeclaEmpresa - KeyPress no campo codigo empresa
1204:     * F4(115): abre lookup  |  ENTER(13)/TAB(9): valida codigo digitado
1205:     * Handler BINDEVENT - deve ser PUBLIC
1206:     *--------------------------------------------------------------------------
1207:     PROCEDURE TeclaEmpresa(par_nKeyCode, par_nShift)
1208:         IF par_nKeyCode = 115
1209:             THIS.AbrirBuscaEmpresa()
1210:         ELSE

*-- Linhas 1375 a 1398:
1375:         ENDIF
1376: 
1377:         TRY
1378:             loc_cSQL = "SELECT TOP 1 Cemps, Razas FROM SigCdEmp " + ;
1379:                 "WHERE Cemps = " + EscaparSQL(loc_cCodigo)
1380:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
1381: 
1382:             IF loc_nResult > 0
1383:                 SELECT cursor_4c_EmpVal
1384:                 IF !EOF()
1385:                     loc_oPagina.txt_4c_Empresa.Value  = ALLTRIM(cursor_4c_EmpVal.Cemps)
1386:                     loc_oPagina.txt_4c_DEmpresa.Value = ALLTRIM(cursor_4c_EmpVal.Razas)
1387:                 ELSE
1388:                     MsgAviso("Empresa n" + CHR(227) + "o encontrada!", "Empresa")
1389:                     loc_oPagina.txt_4c_Empresa.Value  = ""
1390:                     loc_oPagina.txt_4c_DEmpresa.Value = ""
1391:                     THIS.AbrirBuscaEmpresa()
1392:                 ENDIF
1393:                 IF USED("cursor_4c_EmpVal")
1394:                     USE IN cursor_4c_EmpVal
1395:                 ENDIF
1396:             ENDIF
1397:         CATCH TO loc_oErro
1398:             MsgErro(loc_oErro.Message, "Erro")

*-- Linhas 1417 a 1440:
1417:         ENDIF
1418: 
1419:         TRY
1420:             loc_cSQL = "SELECT TOP 1 IClis, Razaos FROM SigCdCli " + ;
1421:                 "WHERE IClis = " + EscaparSQL(loc_cCodigo)
1422:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CntVal")
1423: 
1424:             IF loc_nResult > 0
1425:                 SELECT cursor_4c_CntVal
1426:                 IF !EOF()
1427:                     loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_CntVal.IClis)
1428:                     loc_oPagina.txt_4c_DConta.Value = ALLTRIM(cursor_4c_CntVal.Razaos)
1429:                 ELSE
1430:                     MsgAviso("Conta n" + CHR(227) + "o encontrada!", "Conta")
1431:                     loc_oPagina.txt_4c_Conta.Value  = ""
1432:                     loc_oPagina.txt_4c_DConta.Value = ""
1433:                     THIS.AbrirBuscaConta()
1434:                 ENDIF
1435:                 IF USED("cursor_4c_CntVal")
1436:                     USE IN cursor_4c_CntVal
1437:                 ENDIF
1438:             ENDIF
1439:         CATCH TO loc_oErro
1440:             MsgErro(loc_oErro.Message, "Erro")

*-- Linhas 1511 a 1582:
1511:         loc_cCursor = THIS.this_oRelatorio.this_cCursorOperacoesE
1512: 
1513:         IF !EMPTY(loc_cCursor) AND USED(loc_cCursor)
1514:             SELECT (loc_cCursor)
1515:             IF !EOF() AND !BOF()
1516:                 REPLACE SelImp WITH !SelImp IN (loc_cCursor)
1517:                 THIS.pgf_4c_Paginas.Page1.grd_4c_OperacoesE.Refresh()
1518:             ENDIF
1519:         ENDIF
1520:     ENDPROC
1521: 
1522:     *--------------------------------------------------------------------------
1523:     * CheckGradeEKeyPress - Toggle SelImp via ENTER (13) ou ESPACO (32)
1524:     * Replica KeyPress do original (grdOperacoesE.Column1.Check1).
1525:     * Handler BINDEVENT - deve ser PUBLIC.
1526:     *--------------------------------------------------------------------------
1527:     PROCEDURE CheckGradeEKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1528:         LOCAL loc_cCursor
1529:         IF par_nKeyCode = 13 OR par_nKeyCode = 32
1530:             loc_cCursor = THIS.this_oRelatorio.this_cCursorOperacoesE
1531:             IF !EMPTY(loc_cCursor) AND USED(loc_cCursor)
1532:                 SELECT (loc_cCursor)
1533:                 IF !EOF() AND !BOF()
1534:                     REPLACE SelImp WITH !SelImp IN (loc_cCursor)
1535:                     THIS.pgf_4c_Paginas.Page1.grd_4c_OperacoesE.Refresh()
1536:                 ENDIF
1537:             ENDIF
1538:         ENDIF
1539:     ENDPROC
1540: 
1541:     *--------------------------------------------------------------------------
1542:     * CheckGradeSClick - Toggle SelImp no registro corrente da grade Saidas
1543:     * Handler BINDEVENT - deve ser PUBLIC.
1544:     *--------------------------------------------------------------------------
1545:     PROCEDURE CheckGradeSClick()
1546:         LOCAL loc_cCursor
1547:         loc_cCursor = THIS.this_oRelatorio.this_cCursorOperacoesS
1548: 
1549:         IF !EMPTY(loc_cCursor) AND USED(loc_cCursor)
1550:             SELECT (loc_cCursor)
1551:             IF !EOF() AND !BOF()
1552:                 REPLACE SelImp WITH !SelImp IN (loc_cCursor)
1553:                 THIS.pgf_4c_Paginas.Page1.grd_4c_OperacoesS.Refresh()
1554:             ENDIF
1555:         ENDIF
1556:     ENDPROC
1557: 
1558:     *--------------------------------------------------------------------------
1559:     * CheckGradeSKeyPress - Toggle SelImp via ENTER (13) ou ESPACO (32)
1560:     * Handler BINDEVENT - deve ser PUBLIC.
1561:     *--------------------------------------------------------------------------
1562:     PROCEDURE CheckGradeSKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1563:         LOCAL loc_cCursor
1564:         IF par_nKeyCode = 13 OR par_nKeyCode = 32
1565:             loc_cCursor = THIS.this_oRelatorio.this_cCursorOperacoesS
1566:             IF !EMPTY(loc_cCursor) AND USED(loc_cCursor)
1567:                 SELECT (loc_cCursor)
1568:                 IF !EOF() AND !BOF()
1569:                     REPLACE SelImp WITH !SelImp IN (loc_cCursor)
1570:                     THIS.pgf_4c_Paginas.Page1.grd_4c_OperacoesS.Refresh()
1571:                 ENDIF
1572:             ENDIF
1573:         ENDIF
1574:     ENDPROC
1575: 
1576:     *--------------------------------------------------------------------------
1577:     * ConfigurarValoresIniciaisFiltros - Garante defaults consistentes para
1578:     * todos os filtros, espelhando o bloco do Init do form original:
1579:     *   getDtInicial.Value = Date()
1580:     *   getDtFinal.Value   = Date()
1581:     *   getEmpresa.Value   = _Empr (resolvido por InicializarEmpresa)
1582:     *   getDEmpresa.Value  = []  (resolvido por InicializarEmpresa)

*-- Linhas 1610 a 1634:
1610:         loc_cCursorS = THIS.this_oRelatorio.this_cCursorOperacoesS
1611: 
1612:         IF !EMPTY(loc_cCursorE) AND USED(loc_cCursorE)
1613:             SELECT (loc_cCursorE)
1614:             REPLACE ALL SelImp WITH .F.
1615:             GO TOP
1616:         ENDIF
1617: 
1618:         IF !EMPTY(loc_cCursorS) AND USED(loc_cCursorS)
1619:             SELECT (loc_cCursorS)
1620:             REPLACE ALL SelImp WITH .F.
1621:             GO TOP
1622:         ENDIF
1623:     ENDPROC
1624: 
1625:     *--------------------------------------------------------------------------
1626:     * AtualizarVisibilidadeFiltros - Sincroniza Enabled dos campos de descricao
1627:     * com a presenca de codigo correspondente. Replica os eventos When do
1628:     * original (getDEmpresa.When e getDConta.When):
1629:     *   - txt_4c_DEmpresa.Enabled = EMPTY(txt_4c_Empresa.Value)
1630:     *   - txt_4c_DConta.Enabled   = EMPTY(txt_4c_Conta.Value)
1631:     *--------------------------------------------------------------------------
1632:     PROTECTED PROCEDURE AtualizarVisibilidadeFiltros()
1633:         LOCAL loc_oPagina
1634:         loc_oPagina = THIS.pgf_4c_Paginas.Page1


### BO (C:\4c\projeto\app\classes\sigreimpBO.prg):
*==============================================================================
* SIGREIMPBO.PRG
* Business Object - Relatorio Comparativo de Impostos
*
* Herda de RelatorioBase (NAO de BusinessBase)
* Form original: SIGREIMP.SCX (frmrelatorio)
* Relatorios: SigReIp1 (Detalhado), SigReIp2 (Resumido)
*==============================================================================

DEFINE CLASS sigreimpBO AS RelatorioBase

    *-- Identificacao (nao aplicavel em relatorio, requerido pela base)
    this_cTabela        = ""
    this_cCampoChave    = ""

    *-- Filtros de data (getDtInicial / getDtFinal)
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Filtro de empresa (getEmpresa / getDEmpresa)
    this_cEmpresa       = ""
    this_cDEmpresa      = ""

    *-- Filtro de conta (getConta / getDConta)
    this_cConta         = ""
    this_cDConta        = ""

    *-- Opcoes de relatorio (chkSubTotDat / optTipos)
    this_lSubTotDat     = .F.
    this_nTipos         = 1

    *-- Nomes dos cursores de trabalho
    this_cCursorOperacoesE  = "cursor_4c_OperacoesE"
    this_cCursorOperacoesS  = "cursor_4c_OperacoesS"
    this_cCursorDados       = "cursor_4c_Dados"
    this_cCursorCabecalho   = "cursor_4c_Cabecalho"

    *-- Mensagem de erro
    this_cMensagemErro  = ""

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.this_oDataAccess = .NULL.
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    FUNCTION ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarTiposOperacoes - Popula cursores de operacoes a partir de SigCdTom
    * Chamado no InicializarForm do Form antes de exibir os grids
    *--------------------------------------------------------------------------
    PROCEDURE CarregarTiposOperacoes()
        LOCAL loc_lSucesso, loc_cCursorE, loc_cCursorS
        LOCAL loc_cSQL, loc_nResult, loc_nCodigos, loc_cDescrs

        loc_lSucesso = .F.
        loc_cCursorE = THIS.this_cCursorOperacoesE
        loc_cCursorS = THIS.this_cCursorOperacoesS

        TRY
            *-- Criar ou zerar cursor de entradas
            IF !USED(loc_cCursorE)
                CREATE CURSOR (loc_cCursorE) (SelImp l(1), Codigos n(2), Descrs c(30))
            ELSE
                ZAP IN (loc_cCursorE)
            ENDIF

            *-- Criar ou zerar cursor de saidas
            IF !USED(loc_cCursorS)
                CREATE CURSOR (loc_cCursorS) (SelImp l(1), Codigos n(2), Descrs c(30))
            ELSE
                ZAP IN (loc_cCursorS)
            ENDIF

            *-- Buscar tipos de operacoes de SigCdTom
            loc_cSQL    = "SELECT Codigos, Descrs FROM SigCdTom ORDER BY Codigos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TiposOp")

            IF loc_nResult > 0
                SELECT cursor_4c_TiposOp
                SCAN
                    loc_nCodigos = cursor_4c_TiposOp.Codigos
                    loc_cDescrs  = ALLTRIM(cursor_4c_TiposOp.Descrs)

                    SELECT (loc_cCursorE)
                    APPEND BLANK
                    REPLACE SelImp  WITH .F.
                    REPLACE Codigos WITH loc_nCodigos
                    REPLACE Descrs  WITH loc_cDescrs

                    SELECT (loc_cCursorS)
                    APPEND BLANK
                    REPLACE SelImp  WITH .F.
                    REPLACE Codigos WITH loc_nCodigos
                    REPLACE Descrs  WITH loc_cDescrs
                ENDSCAN

                IF USED("cursor_4c_TiposOp")
                    USE IN cursor_4c_TiposOp
                ENDIF

                SELECT (loc_cCursorE)
                GO TOP
                SELECT (loc_cCursorS)
                GO TOP

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao carregar tipos de opera" + ;
                    CHR(231) + CHR(245) + "es (SigCdTom)"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida filtros antes de gerar relatorio
    * Retorna .T. se valido, .F. caso contrario (this_cMensagemErro preenchido)
    *--------------------------------------------------------------------------
    FUNCTION ValidarFiltros()
        LOCAL loc_lValido, loc_cCursorE, loc_cCursorS
        LOCAL loc_nContE, loc_nContS, loc_lConflito
        LOCAL loc_nCodSaida, loc_cDescSaida

        loc_lValido    = .F.
        loc_lConflito  = .F.
        loc_cCursorE   = THIS.this_cCursorOperacoesE
        loc_cCursorS   = THIS.this_cCursorOperacoesS
        loc_nCodSaida  = 0
        loc_cDescSaida = ""

        TRY
            IF EMPTY(THIS.this_dDtInicial)
                THIS.this_cMensagemErro = "Data Inicial Inv" + CHR(225) + "lida!!!"

            ELSE
                IF EMPTY(THIS.this_dDtFinal)
                THIS.this_cMensagemErro = "Data Final Inv" + CHR(225) + "lida!!!"

            ELSE
                IF THIS.this_dDtFinal < THIS.this_dDtInicial
                THIS.this_cMensagemErro = "Data Final Menor Que a Inicial!!!"

            ELSE
                *-- Contar entradas selecionadas
                loc_nContE = 0
                IF USED(loc_cCursorE)
                    SELECT (loc_cCursorE)
                    GO TOP
                    SCAN
                        IF SelImp
                            loc_nContE = loc_nContE + 1
                        ENDIF
                    ENDSCAN
                ENDIF

                IF loc_nContE = 0
                    THIS.this_cMensagemErro = "Nenhum Tipo Operacional de Entrada Foi Selecionado!!!"

                ELSE
                    *-- Contar saidas selecionadas
                    loc_nContS = 0
                    IF USED(loc_cCursorS)
                        SELECT (loc_cCursorS)
                        GO TOP
                        SCAN
                            IF SelImp
                                loc_nContS = loc_nContS + 1
                            ENDIF
                        ENDSCAN
                    ENDIF

                    IF loc_nContS = 0
                        THIS.this_cMensagemErro = "Nenhum Tipo Operacional de Sa" + ;
                            CHR(237) + "da Foi Selecionado!!!"

                    ELSE
                        *-- Verificar conflito: mesmo codigo em entrada e saida
                        IF USED(loc_cCursorS)
                            SELECT (loc_cCursorS)
                            GO TOP
                            SCAN
                                IF SelImp AND !loc_lConflito
                                    loc_nCodSaida  = Codigos
                                    loc_cDescSaida = Descrs
                                    IF USED(loc_cCursorE)
                                        SELECT (loc_cCursorE)
                                        GO TOP
                                        LOCATE FOR Codigos = loc_nCodSaida AND SelImp
                                        IF !EOF()
                                            loc_lConflito = .T.
                                            THIS.this_cMensagemErro = "O Tipo Operacional " + ;
                                                ALLTRIM(loc_cDescSaida) + " Foi" + ;
                                                " Selecionado Como Entrada e Sa" + CHR(237) + ;
                                                "da. Verifique!!!"
                                        ENDIF
                                        SELECT (loc_cCursorS)
                                    ENDIF
                                ENDIF
                            ENDSCAN
                        ENDIF

                        IF !loc_lConflito
                            loc_lValido = .T.
                        ENDIF
                    ENDIF
                ENDIF
                ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa queries e prepara cursores para o relatorio
    * Replica logica do PROCEDURE processamento do SIGREIMP.SCX original
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cCursorE, loc_cCursorS
        LOCAL loc_cDtInicialSQL, loc_cDtFinalSQL
        LOCAL loc_cEtiquetaEmp, loc_cEtiquetaCta
        LOCAL loc_cWrE, loc_cWrS, loc_nContE, loc_nContS, loc_nCodigo
        LOCAL loc_cQuery, loc_nResult
        LOCAL loc_cEmpresaFiltro, loc_cContaFiltro
        LOCAL loc_cEmpDopNums, loc_cQueryBaixas, loc_nResultBaixas

        loc_lSucesso = .F.
        loc_cCursorE = THIS.this_cCursorOperacoesE
        loc_cCursorS = THIS.this_cCursorOperacoesS

        TRY
            *-- Formatar datas para SQL Server
            loc_cDtInicialSQL = FormatarDataSQL(THIS.this_dDtInicial)
            loc_cDtFinalSQL   = "'" + ;
                PADL(TRANSFORM(YEAR(THIS.this_dDtFinal)),  4, "0") + "-" + ;
                PADL(TRANSFORM(MONTH(THIS.this_dDtFinal)), 2, "0") + "-" + ;
                PADL(TRANSFORM(DAY(THIS.this_dDtFinal)),   2, "0") + " 23:59:59'"

            *-- Montar etiquetas descritivas para o cabecalho
            IF EMPTY(THIS.this_cEmpresa)
                loc_cEtiquetaEmp = "Global"
            ELSE
                loc_cEtiquetaEmp = ALLTRIM(THIS.this_cEmpresa) + "-" + ALLTRIM(THIS.this_cDEmpresa)
            ENDIF

            IF EMPTY(THIS.this_cConta)
                loc_cEtiquetaCta = "Global"
            ELSE
                loc_cEtiquetaCta = ALLTRIM(THIS.this_cConta) + "-" + ALLTRIM(THIS.this_cDConta)
            ENDIF

            *-- Criar / zerar cursor de cabecalho do relatorio
            IF USED(THIS.this_cCursorCabecalho)
                ZAP IN (THIS.this_cCursorCabecalho)
            ELSE
                CREATE CURSOR (THIS.this_cCursorCabecalho) ;
                    (Titulo c(200), Subtitulo c(200), Periodo c(200), SubTotDia l(1))
            ENDIF
            SELECT (THIS.this_cCursorCabecalho)
            APPEND BLANK
            REPLACE Titulo    WITH "Relat" + CHR(243) + "rio Comparativo de Impostos"
            REPLACE Subtitulo WITH "Empresa: " + loc_cEtiquetaEmp + ;
                " - Conta: " + loc_cEtiquetaCta
            REPLACE Periodo   WITH "Per" + CHR(237) + "odo: " + ;
                DTOC(THIS.this_dDtInicial) + " a " + DTOC(THIS.this_dDtFinal)
            REPLACE SubTotDia WITH THIS.this_lSubTotDat
            GO TOP IN (THIS.this_cCursorCabecalho)

            *-- Construir lista de codigos de Entrada selecionados
            loc_cWrE   = ""
            loc_nContE = 0
            IF USED(loc_cCursorE)
                SELECT (loc_cCursorE)
                GO TOP
                SCAN
                    IF SelImp
                        loc_nCodigo = Codigos
                        IF EMPTY(loc_cWrE)
                            loc_cWrE = ALLTRIM(STR(loc_nCodigo, 2))
                        ELSE
                            loc_cWrE = loc_cWrE + ", " + ALLTRIM(STR(loc_nCodigo, 2))
                        ENDIF
                        loc_nContE = loc_nContE + 1
                    ENDIF
                ENDSCAN
            ENDIF

            IF loc_nContE > 1
                loc_cWrE = "IN (" + loc_cWrE + ")"
            ELSE
                loc_cWrE = "= " + loc_cWrE
            ENDIF

            *-- Construir lista de codigos de Saida selecionados
            loc_cWrS   = ""
            loc_nContS = 0
            IF USED(loc_cCursorS)
                SELECT (loc_cCursorS)
                GO TOP
                SCAN
                    IF SelImp
                        loc_nCodigo = Codigos
                        IF EMPTY(loc_cWrS)
                            loc_cWrS = ALLTRIM(STR(loc_nCodigo, 2))
                        ELSE
                            loc_cWrS = loc_cWrS + ", " + ALLTRIM(STR(loc_nCodigo, 2))
                        ENDIF
                        loc_nContS = loc_nContS + 1
                    ENDIF
                ENDSCAN
            ENDIF

            IF loc_nContS > 1
                loc_cWrS = "IN (" + loc_cWrS + ")"
            ELSE
                loc_cWrS = "= " + loc_cWrS
            ENDIF

            *-- Filtros opcionais de empresa e conta para SQL
            IF EMPTY(THIS.this_cEmpresa)
                loc_cEmpresaFiltro = ""
            ELSE
                loc_cEmpresaFiltro = "n.Emps = " + EscaparSQL(THIS.this_cEmpresa) + " AND "
            ENDIF

            IF EMPTY(THIS.this_cConta)
                loc_cContaFiltro = ""
            ELSE
                loc_cContaFiltro = "c.IClis = " + EscaparSQL(THIS.this_cConta) + " AND "
            ENDIF

            *-- Query principal: UNION ALL de Entradas e Saidas (replica lcQuery do original)
            loc_cQuery = ;
                "SELECT ' ' AS Baixas, 'E' AS Movimento, " + ;
                "n.Emis, n.NFis, n.Series, n.CFis, n.CfoSubs, n.Emps, " + ;
                "n.TotNotas, n.ValICms, n.ICmsS, n.ValIpis, " + ;
                "n.CliFors, c.Razaos, c.Estas, n.EmpDopNums " + ;
                "FROM SigCdOpe o, SigMvNfi n, SigCdCli c " + ;
                "WHERE o.TipoOps " + loc_cWrE + " AND " + ;
                "o.NFiscals IN (1, 2) AND " + ;
                "o.Dopes = n.Dopes AND " + ;
                "n.Emis BETWEEN " + loc_cDtInicialSQL + " AND " + loc_cDtFinalSQL + ;
                " AND " + loc_cEmpresaFiltro + ;
                "LEFT(n.CliFors, 10) = c.IClis AND " + ;
                loc_cContaFiltro + "n.Cancelas = 0 " + ;
                "UNION ALL " + ;
                "SELECT ' ' AS Baixas, 'S' AS Movimento, " + ;
                "n.Emis, n.NFis, n.Series, n.CFis, n.CfoSubs, n.Emps, " + ;
                "n.TotNotas, n.ValICms, n.ICmsS, n.ValIpis, " + ;
                "n.CliFors, c.Razaos, c.Estas, n.EmpDopNums " + ;
                "FROM SigCdOpe o, SigMvNfi n, SigCdCli c " + ;
                "WHERE o.TipoOps " + loc_cWrS + " AND " + ;
                "o.NFiscals IN (1, 2) AND " + ;
                "o.Dopes = n.Dopes AND " + ;
                "n.Emis BETWEEN " + loc_cDtInicialSQL + " AND " + loc_cDtFinalSQL + ;
                " AND " + loc_cEmpresaFiltro + ;
                "LEFT(n.CliFors, 10) = c.IClis AND " + ;
                loc_cContaFiltro + "n.Cancelas = 0"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_Dados1")

            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + "o ao buscar dados"

            ELSE
                *-- Processar baixas: para cada nota, verificar em SigMvCab/SigMvPec
                SELECT cursor_4c_Dados1
                GO TOP
                SCAN
                    loc_cEmpDopNums  = ALLTRIM(cursor_4c_Dados1.EmpDopNums)

                    loc_cQueryBaixas = ;
                        "SELECT e.EmpDopNums, p.EmpDopNums " + ;
                        "FROM SigMvCab e, SigCdOpe o, SigMvPec p, SigCdOpe o2 " + ;
                        "WHERE e.EmpDopNums = " + EscaparSQL(loc_cEmpDopNums) + ;
                        " AND o.Dopes = e.Dopes" + ;
                        " AND (1000000 * o.NDopes) + e.Numes = p.Codigos" + ;
                        " AND p.Dopes = o2.Dopes" + ;
                        " AND o2.CBxSubns = 1"

                    loc_nResultBaixas = SQLEXEC(gnConnHandle, loc_cQueryBaixas, "cursor_4c_Baixas")

                    IF loc_nResultBaixas > 0
                        SELECT cursor_4c_Baixas
                        GO TOP IN cursor_4c_Baixas
                        IF !EOF("cursor_4c_Baixas")
                            SELECT cursor_4c_Dados1
                            REPLACE Baixas WITH "X"
                        ENDIF
                        IF USED("cursor_4c_Baixas")
                            USE IN cursor_4c_Baixas
                        ENDIF
                        SELECT cursor_4c_Dados1
                    ENDIF
                ENDSCAN

                *-- Criar cursor final conforme tipo de relatorio
                IF USED(THIS.this_cCursorDados)
                    USE IN (THIS.this_cCursorDados)
                ENDIF

                IF THIS.this_nTipos = 1
                    *-- Detalhado: todos os registros ordenados
                    SELECT * FROM cursor_4c_Dados1 ;
                        INTO CURSOR (THIS.this_cCursorDados) READWRITE ;
                        ORDER BY Movimento, Emis, NFis, Series
                ELSE
                    *-- Resumido: agrupado por movimento, excluindo baixas
                    SELECT Movimento, ;
                           SUM(TotNotas) AS TotNotas, ;
                           SUM(ValICms)  AS ValICms, ;
                           SUM(ICmsS)    AS ICmsS, ;
                           SUM(ValIpis)  AS ValIpis ;
                        FROM cursor_4c_Dados1 ;
                        WHERE EMPTY(Baixas) ;
                        INTO CURSOR (THIS.this_cCursorDados) READWRITE ;
                        GROUP BY Movimento ;
                        ORDER BY Movimento
                ENDIF

                IF USED("cursor_4c_Dados1")
                    USE IN cursor_4c_Dados1
                ENDIF

                SELECT (THIS.this_cCursorDados)
                GO TOP

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Gera relatorio em preview na tela
    *--------------------------------------------------------------------------
    FUNCTION Visualizar()
        LOCAL loc_lSucesso, loc_cRelatorio
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nTipos = 1
                    loc_cRelatorio = gc_4c_CaminhoReports + "SigReIp1.frx"
                ELSE
                    loc_cRelatorio = gc_4c_CaminhoReports + "SigReIp2.frx"
                ENDIF
                REPORT FORM (loc_cRelatorio) PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Imprimir - Envia relatorio para impressora com dialogo de selecao
    *--------------------------------------------------------------------------
    FUNCTION Imprimir()
        LOCAL loc_lSucesso, loc_cRelatorio
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nTipos = 1
                    loc_cRelatorio = gc_4c_CaminhoReports + "SigReIp1.frx"
                ELSE
                    loc_cRelatorio = gc_4c_CaminhoReports + "SigReIp2.frx"
                ENDIF
                REPORT FORM (loc_cRelatorio) TO PRINT PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

