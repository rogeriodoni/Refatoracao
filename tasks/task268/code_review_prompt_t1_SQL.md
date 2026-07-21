# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (11)
- [GRID-SQL] Campo 'marcas' usado em ControlSource de cursor_4c_Copia mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'qmaxs' usado em ControlSource de cursor_4c_Copia mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'codtams' usado em ControlSource de cursor_4c_Copia mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'codcores' usado em ControlSource de cursor_4c_Copia mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'deptos' usado em ControlSource de cursor_4c_Copia mas NAO aparece no SELECT SQL
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DPROS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, CGRUS, CORES, TAMS, EMPS, ICLIS, EXISTES, PCESCOLHA, GESIND
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'REFFS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, CGRUS, CORES, TAMS, EMPS, ICLIS, EXISTES, PCESCOLHA, GESIND
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, CGRUS, CORES, TAMS, EMPS, ICLIS, EXISTES, PCESCOLHA, GESIND
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODTAMS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, CGRUS, CORES, TAMS, EMPS, ICLIS, EXISTES, PCESCOLHA, GESIND
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODCORES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, CGRUS, CORES, TAMS, EMPS, ICLIS, EXISTES, PCESCOLHA, GESIND
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DEPTOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, CGRUS, CORES, TAMS, EMPS, ICLIS, EXISTES, PCESCOLHA, GESIND

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
Select CrSigCdMax
	.Column1.ControlSource = 'CrSigCdMax.emps'
	.Column2.ControlSource = 'CrSigCdMax.Qmaxs'
	.Column3.ControlSource = 'CrSigCdMax.codtams'
	.Column4.ControlSource = 'CrSigCdMax.codcores'
	.Column5.ControlSource = 'CrSigCdMax.Deptos'
Insert Into CrSigCdMax (cpros,cidchaves) Values (ThisForm.Pagina.Dados.Get_Produto.Value,fUniqueIds())
Select CrSigCdMax
Select CrSigCdMax
	lStrQuery = [Select b.cores,b.tams,b.tipoestos From SigCdPro a, SigCdGrp b ]+;
	If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpProGru') < 1
	Select TmpProGru
lcQProds  = [Select a.cpros,b.dpros,b.ifors,b.reffs,b.cgrus,b.sgrus,b.situas,c.rclis,g.dgrus ]+;
			[From SigCdMax a ]+;
			[Inner Join SigCdPro b On b.cpros = a.cpros ]+;
			[Left Join SigCdCli c On b.ifors = c.iclis ]+;
			[Left Join SigCdGrp g On b.cgrus = g.cgrus ]+;
LcQprCom  = [Select a.*,b.dpros,b.ifors,b.reffs,b.cgrus,b.situas,c.rclis,g.dgrus ]+;
			[From SigCdMax a, SigCdPro b ]+;
			[Left Join SigCdCli c On b.ifors = c.iclis ]+;
			[Left Join SigCdGrp g On b.cgrus = g.cgrus ]+;
lcQCopia  = [Select 1 As marcas,0 As existes,a.cpros,a.emps,a.Qmaxs,a.codtams,a.codcores,a.cidchaves ]+;
			[From SigCdMax a ]+;
 				[(Select b.cpros + b.codtams + b.codcores As cprotamcores From SigCdMax b ]+;
			[Select 0 As marcas,1 As existes,a.cpros,a.emps,a.Qmaxs,a.codtams,a.codcores,a.cidchaves ]+;
			[From SigCdMax a ]+;
 				[(Select b.cpros + b.codtams + b.codcores As cprotamcores From SigCdMax b ]+;
			[Select 0 As marcas,2 As existes,a.cpros,a.emps,a.Qmaxs,a.codtams,a.codcores,a.cidchaves ]+;
			[From SigCdMax a ]+;
 				[(Select b.cpros + b.codtams + b.codcores As cprotamcores From SigCdMax b ]+;
If ThisForm.poDataMgr.SqlExecute([Select gesind From SigCdPam ],'CrSigCdPam') < 1
ThisForm.poDataMgr.Update('CrSigCdMax')
Select CrSigCdMax
Delete From CrSigCdMax
Delete From CrSigCdMax
ThisForm.poDataMgr.Update('CrSigCdMax')
ThisForm.poDataMgr.Update('CrSigCdMax')
Select CrProdutos
Select Distinct cpros,dpros,cgrus,dgrus,ifors,rclis,reffs,Qmaxs,situas ;
  From CrSigCdMax ;
	Insert Into CsCabec (cpros,dpros,cgrus,dgrus,ifors,rclis,reffs,Qmaxs,situas) ;
Select CrSigCdMax
	lStrQuery = [Select rclis From SigCdCli Where iclis = ']+ThisForm.pcIFors+[']
	If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpIFors') < 1
	lStrQuery = [Select Dgrus From SigCdGrp Where CGrus = ']+ThisForm.pcCGrus+[']
	If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpCGrus') < 1
	Select CrSigCdMax
	Insert Into CrSigCdMax (cpros,cidchaves) Values (ThisForm.pcCPros,fUniqueIds())
	Select CrSigCdMax
	Insert Into CsCabec (cpros,dpros,ifors,rclis,cgrus,dgrus,reffs,situas) ;
		Select CrSigCdMax
	Select CrSigCdMax
			Delete
	Select CrSigCdMax
		Insert Into CrSigCdMax (cpros,cidchaves) Values (Thisform.pagina.dados.get_Produto.Value,fUniqueIds())
		Select CrSigCdMax
Select CsCopia
		Insert Into CrSigCdMax (cpros,emps,Qmaxs,codtams,codcores,cidchaves,Deptos) ;
ThisForm.poDataMgr.Update('CrSigCdMax')
	Select CsCopia
	Select CsCopia
		.Column1.ControlSource = 'CsCopia.marcas'
		.Column2.ControlSource = 'CsCopia.cpros'
		.Column3.ControlSource = 'CsCopia.Qmaxs'
		.Column4.ControlSource = 'CsCopia.codtams'
		.Column5.ControlSource = 'CsCopia.codcores'
		.Column6.ControlSource = 'CsCopia.Deptos'
Select CsCopia
Update CsCopia Set Marcas = 1 Where existes = 0
Select CsCopia
Update CsCopia Set Marcas = 0 Where existes = 0
		lStrQuery = [Select a.cpros,a.dpros,a.cgrus,a.ifors,a.reffs,a.situas,c.rclis,g.dgrus ]+;
					[From SigCdPro a ]+;
					[Left Join SigCdGrp g On g.cgrus = a.cgrus ]+;
					[Left Join SigCdCli c On c.iclis = a.ifors ]+;
		If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpPro') < 1
		Select TmpPro
			Select CrSigCdMax
		Insert Into CrSigCdMax (cpros,cidchaves) Values (TmpPro.cpros,fUniqueIds())
		Select CrSigCdMax
		Insert Into CsCabec (cpros,dpros,ifors,rclis,cgrus,dgrus,reffs,situas) ;
Select CrSigCdMax
Delete From CrSigCdMax Where emps = lcEmps
Select CrSigCdMax
	Insert Into CrSigCdMax (cpros,cidchaves) Values (This.Parent.Get_Produto.Value,fUniqueIds())
Select CrSigCdMax
	Select CrSigCdMax
		lStrQuery = [Select a.cpros,a.dpros,a.cgrus,a.ifors,a.reffs,a.situas,c.rclis,g.dgrus ]+;
					[From SigCdPro a ]+;
					[Left Join SigCdGrp g On g.cgrus = a.cgrus ]+;
					[Left Join SigCdCli c On c.iclis = a.ifors ]+;
		If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpPro') < 1
		Select TmpPro
			Select CrSigCdMax
		Insert Into CrSigCdMax (cpros,cidchaves) Values (TmpPro.cpros,fUniqueIds())
		Select CrSigCdMax
		Insert Into CsCabec (cpros,dpros,ifors,rclis,cgrus,dgrus,reffs,situas) ;

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigprcom.prg) - TRECHOS RELEVANTES PARA PASS SQL (2444 linhas total):

*-- Linhas 455 a 473:
455:             .HighlightBackColor = RGB(255, 255, 255)
456:             .HighlightForeColor = RGB(15, 41, 104)
457:             .HighlightStyle     = 2
458:             .DeleteMark         = .F.
459:             .RecordMark         = .F.
460:             .RowHeight          = 16
461:             .ScrollBars         = 2
462:             .GridLines          = 3
463:             .ReadOnly           = .T.
464:             .Visible            = .T.
465:             *-- Larguras das colunas (headers configurados em CarregarLista)
466:             .Column1.Width = 100
467:             .Column2.Width = 360
468:             .Column3.Width = 65
469:             .Column4.Width = 100
470:             .Column5.Width = 165
471:             .Column6.Width = 50
472:         ENDWITH
473: 

*-- Linhas 642 a 660:
642:             .BackColor        = RGB(255, 255, 255)
643:             .GridLineColor    = RGB(238, 238, 238)
644:             .HighlightStyle   = 2
645:             .DeleteMark       = .F.
646:             .RecordMark       = .F.
647:             .RowHeight        = 16
648:             .ScrollBars       = 2
649:             .GridLines        = 3
650:             .Visible          = .T.
651:             *-- Column1: CheckBox de selecao (Sparse=.F. obrigatorio para mostrar em todas as linhas)
652:             .Column1.Width    = 30
653:             .Column1.Sparse   = .F.
654:             *-- Column2..6: campos de dados
655:             .Column2.Width    = 70
656:             .Column3.Width    = 65
657:             .Column4.Width    = 50
658:             .Column5.Width    = 50
659:             .Column6.Width    = 120
660:             *-- Headers (serao reconfigurados em BtnProcessarCopiaClick apos RecordSource)

*-- Linhas 1160 a 1257:
1160:             .Width        = 387
1161:             .Height       = 472
1162:             .ReadOnly     = .F.
1163:             .DeleteMark   = .F.
1164:             .RecordMark   = .F.
1165:             .GridLines    = 1
1166:             .HeaderHeight = 20
1167:             .RowHeight    = 19
1168:             .FontName     = "Tahoma"
1169:             .FontSize     = 8
1170:             .Visible      = .T.
1171: 
1172:             WITH .Column1
1173:                 .ControlSource = ""
1174:                 .Width         = 40
1175:                 .Sparse        = .F.
1176:                 WITH .Header1
1177:                     .Caption  = "Empresa"
1178:                     .FontName = "Tahoma"
1179:                     .FontSize = 8
1180:                     .FontBold = .T.
1181:                 ENDWITH
1182:                 WITH .Text1
1183:                     .Value    = ""
1184:                     .FontName = "Tahoma"
1185:                     .FontSize = 8
1186:                 ENDWITH
1187:             ENDWITH
1188: 
1189:             WITH .Column2
1190:                 .ControlSource = ""
1191:                 .Width         = 65
1192:                 .Sparse        = .F.
1193:                 WITH .Header1
1194:                     .Caption  = "Qtde.M" + CHR(225) + "x."
1195:                     .FontName = "Tahoma"
1196:                     .FontSize = 8
1197:                     .FontBold = .T.
1198:                 ENDWITH
1199:                 WITH .Text1
1200:                     .Value    = 0
1201:                     .Format   = "9999.99"
1202:                     .FontName = "Tahoma"
1203:                     .FontSize = 8
1204:                 ENDWITH
1205:             ENDWITH
1206: 
1207:             WITH .Column3
1208:                 .ControlSource = ""
1209:                 .Width         = 55
1210:                 .Sparse        = .F.
1211:                 WITH .Header1
1212:                     .Caption  = "Tam."
1213:                     .FontName = "Tahoma"
1214:                     .FontSize = 8
1215:                     .FontBold = .T.
1216:                 ENDWITH
1217:                 WITH .Text1
1218:                     .Value    = ""
1219:                     .FontName = "Tahoma"
1220:                     .FontSize = 8
1221:                 ENDWITH
1222:             ENDWITH
1223: 
1224:             WITH .Column4
1225:                 .ControlSource = ""
1226:                 .Width         = 55
1227:                 .Sparse        = .F.
1228:                 WITH .Header1
1229:                     .Caption  = "Cor"
1230:                     .FontName = "Tahoma"
1231:                     .FontSize = 8
1232:                     .FontBold = .T.
1233:                 ENDWITH
1234:                 WITH .Text1
1235:                     .Value    = ""
1236:                     .FontName = "Tahoma"
1237:                     .FontSize = 8
1238:                 ENDWITH
1239:             ENDWITH
1240: 
1241:             WITH .Column5
1242:                 .ControlSource = ""
1243:                 .Width         = 172
1244:                 .Sparse        = .F.
1245:                 WITH .Header1
1246:                     .Caption  = "Departamento"
1247:                     .FontName = "Tahoma"
1248:                     .FontSize = 8
1249:                     .FontBold = .T.
1250:                 ENDWITH
1251:                 WITH .Text1
1252:                     .Value    = ""
1253:                     .FontName = "Tahoma"
1254:                     .FontSize = 8
1255:                 ENDWITH
1256:             ENDWITH
1257:         ENDWITH

*-- Linhas 1296 a 1320:
1296:                         loc_oGrid.ColumnCount = 6
1297:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
1298: 
1299:                         *-- ControlSource de cada coluna
1300:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cpros"
1301:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.dpros"
1302:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.cgrus"
1303:                         loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.ifors"
1304:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.reffs"
1305:                         loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.situas"
1306: 
1307:                         *-- Headers: OBRIGATORIO re-setar apos RecordSource (VFP9 reseta)
1308:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1309:                         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1310:                         loc_oGrid.Column3.Header1.Caption = "Grupo"
1311:                         loc_oGrid.Column4.Header1.Caption = "Fornecedor"
1312:                         loc_oGrid.Column5.Header1.Caption = "Refer" + CHR(234) + "ncia"
1313:                         loc_oGrid.Column6.Header1.Caption = "St"
1314: 
1315:                         THIS.FormatarGridLista(loc_oGrid)
1316:                         loc_lResultado = .T.
1317:                     ENDIF
1318:                 ENDIF
1319:             ENDIF
1320: 

*-- Linhas 1380 a 1401:
1380: 
1381:         IF USED("cursor_4c_Max")
1382:             USE IN cursor_4c_Max
1383:         ENDIF
1384: 
1385:         IF USED("cursor_4c_Copia")
1386:             USE IN cursor_4c_Copia
1387:         ENDIF
1388: 
1389:         DODEFAULT()
1390:     ENDPROC
1391: 
1392:     *--------------------------------------------------------------------------
1393:     * AlternarPagina - Navega entre Page1 (lista) e Page2 (dados)
1394:     *--------------------------------------------------------------------------
1395:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1396:         TRY
1397:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1398:             IF par_nPagina = 1
1399:                 THIS.this_cModoAtual = "LISTA"
1400:             ELSE
1401:                 THIS.this_cModoAtual = "DADOS"

*-- Linhas 1497 a 1516:
1497:                 ELSE
1498:                     IF MsgConfirma("Excluir todos os m" + CHR(225) + "ximos do produto " + loc_cCpros + "?", ;
1499:                             "Confirmar Exclus" + CHR(227) + "o")
1500:                         loc_nResult = SQLEXEC(gnConnHandle, ;
1501:                             "DELETE FROM SigCdMax WHERE cpros = " + EscaparSQL(PADR(loc_cCpros, 14)))
1502:                         IF loc_nResult > 0
1503:                             MsgInfo("M" + CHR(225) + "ximos exclu" + CHR(237) + "dos com sucesso.", "Sucesso")
1504:                             THIS.CarregarLista()
1505:                             loc_lResultado = .T.
1506:                         ELSE
1507:                             MsgErro("Erro ao excluir m" + CHR(225) + "ximos do produto.", "Erro")
1508:                         ENDIF
1509:                     ENDIF
1510:                 ENDIF
1511:             ELSE
1512:                 MsgAviso("Nenhum produto na lista.", "Aten" + CHR(231) + CHR(227) + "o")
1513:             ENDIF
1514:         CATCH TO loc_oErro
1515:             MsgErro("Erro em BtnExcluirClick: " + loc_oErro.Message, "Erro")
1516:         ENDTRY

*-- Linhas 1592 a 1613:
1592:                 loc_oPagina.cnt_4c_Copia.txt_4c_EmpOs.Value   = ""
1593:                 loc_oPagina.cnt_4c_Copia.txt_4c_EmpDs.Value   = ""
1594:                 loc_oPagina.cnt_4c_Copia.txt_4c_Produto.Value = ""
1595:                 loc_oPagina.cnt_4c_Copia.txt_4c_EmpDs.Enabled = .F.
1596: 
1597:                 IF USED("cursor_4c_Copia")
1598:                     USE IN cursor_4c_Copia
1599:                 ENDIF
1600:                 loc_oPagina.cnt_4c_Copia.grd_4c_DadosCopia.RecordSource = ""
1601: 
1602:                 loc_oPagina.cnt_4c_Copia.Visible = .T.
1603:                 loc_oPagina.cnt_4c_Copia.txt_4c_EmpOs.SetFocus()
1604:             ENDIF
1605:         CATCH TO loc_oErro
1606:             MsgErro("Erro em BtnCopiarClick: " + loc_oErro.Message, "Erro")
1607:         ENDTRY
1608:     ENDPROC
1609: 
1610:     *--------------------------------------------------------------------------
1611:     * EmpOsLostFocus - Habilita txt_4c_EmpDs quando EmpOs estiver preenchida
1612:     *--------------------------------------------------------------------------
1613:     PROCEDURE EmpOsLostFocus()

*-- Linhas 1649 a 1690:
1649:             ELSE
1650:                 IF EMPTY(loc_cEmpDs)
1651:                     MsgAviso("Informe a Empresa Destino.", "Aten" + CHR(231) + CHR(227) + "o")
1652:                 ELSE
1653:                     IF THIS.this_oBusinessObject.CarregarCopiaParaCursor(PADR(loc_cProduto, 14), PADR(loc_cEmpOs, 3), PADR(loc_cEmpDs, 3))
1654:                         IF USED("cursor_4c_Copia") AND RECCOUNT("cursor_4c_Copia") > 0
1655:                             loc_oGrid = loc_oPagina.cnt_4c_Copia.grd_4c_DadosCopia
1656: 
1657:                             *-- RecordSource FORA de WITH (Problema 36)
1658:                             loc_oGrid.ColumnCount = 6
1659:                             loc_oGrid.RecordSource = "cursor_4c_Copia"
1660:                             loc_oGrid.Column1.ControlSource = "cursor_4c_Copia.marcas"
1661:                             loc_oGrid.Column2.ControlSource = "cursor_4c_Copia.cpros"
1662:                             loc_oGrid.Column3.ControlSource = "cursor_4c_Copia.qmaxs"
1663:                             loc_oGrid.Column4.ControlSource = "cursor_4c_Copia.codtams"
1664:                             loc_oGrid.Column5.ControlSource = "cursor_4c_Copia.codcores"
1665:                             loc_oGrid.Column6.ControlSource = "cursor_4c_Copia.deptos"
1666: 
1667:                             *-- Headers: re-setar apos RecordSource (VFP9 reseta)
1668:                             loc_oGrid.Column1.Header1.Caption = ""
1669:                             loc_oGrid.Column2.Header1.Caption = "Produto"
1670:                             loc_oGrid.Column3.Header1.Caption = "Qtde. M" + CHR(225) + "x."
1671:                             loc_oGrid.Column4.Header1.Caption = "Tam"
1672:                             loc_oGrid.Column5.Header1.Caption = "Cor"
1673:                             loc_oGrid.Column6.Header1.Caption = "Departamento"
1674: 
1675:                             GO TOP IN cursor_4c_Copia
1676:                             loc_lResultado = .T.
1677:                         ELSE
1678:                             MsgAviso("Nenhum produto encontrado para c" + CHR(243) + "pia.", "Aviso")
1679:                         ENDIF
1680:                     ELSE
1681:                         MsgErro("Erro ao carregar dados: " + THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
1682:                     ENDIF
1683:                 ENDIF
1684:             ENDIF
1685:         CATCH TO loc_oErro
1686:             MsgErro("Erro em BtnProcessarCopiaClick: " + loc_oErro.Message, "Erro")
1687:         ENDTRY
1688: 
1689:         RETURN loc_lResultado
1690:     ENDPROC

*-- Linhas 1701 a 1726:
1701: 
1702:         TRY
1703:             loc_cEmpOs = ALLTRIM(loc_oPagina.cnt_4c_Copia.txt_4c_EmpOs.Value)
1704:             loc_cEmpDs = ALLTRIM(loc_oPagina.cnt_4c_Copia.txt_4c_EmpDs.Value)
1705: 
1706:             IF !USED("cursor_4c_Copia") OR RECCOUNT("cursor_4c_Copia") = 0
1707:                 MsgAviso("Processe os dados antes de confirmar a c" + CHR(243) + "pia.", "Aten" + CHR(231) + CHR(227) + "o")
1708:             ELSE
1709:                 IF MsgConfirma("Confirmar c" + CHR(243) + "pia dos m" + CHR(225) + "ximos de " + ;
1710:                         loc_cEmpOs + " para " + loc_cEmpDs + "?", "Confirmar C" + CHR(243) + "pia")
1711:                     IF THIS.this_oBusinessObject.CopiarMaxEntreEmpresas(PADR(loc_cEmpDs, 3), "cursor_4c_Copia")
1712:                         MsgInfo("C" + CHR(243) + "pia realizada com sucesso.", "Sucesso")
1713:                         THIS.BtnSairCopiaClick()
1714:                         loc_lResultado = .T.
1715:                     ELSE
1716:                         MsgErro("Erro ao copiar m" + CHR(225) + "ximos: " + ;
1717:                             THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
1718:                     ENDIF
1719:                 ENDIF
1720:             ENDIF
1721:         CATCH TO loc_oErro
1722:             MsgErro("Erro em BtnConfirmarCopiaClick: " + loc_oErro.Message, "Erro")
1723:         ENDTRY
1724: 
1725:         RETURN loc_lResultado
1726:     ENDPROC

*-- Linhas 1737 a 1785:
1737:             loc_oPagina.grd_4c_Lista.Visible      = .T.
1738:             loc_oPagina.cnt_4c_Botoes.Visible     = .T.
1739:             loc_oPagina.cnt_4c_Saida.Visible      = .T.
1740:             loc_oPagina.cmd_4c_BtnCopiar.Visible  = .T.
1741: 
1742:             IF USED("cursor_4c_Copia")
1743:                 USE IN cursor_4c_Copia
1744:             ENDIF
1745:         CATCH TO loc_oErro
1746:             MsgErro("Erro em BtnSairCopiaClick: " + loc_oErro.Message, "Erro")
1747:         ENDTRY
1748:     ENDPROC
1749: 
1750:     *--------------------------------------------------------------------------
1751:     * BtnMarcarCopiaClick - Marca todos os itens para copia
1752:     *--------------------------------------------------------------------------
1753:     PROCEDURE BtnMarcarCopiaClick()
1754:         TRY
1755:             IF USED("cursor_4c_Copia") AND RECCOUNT("cursor_4c_Copia") > 0
1756:                 REPLACE ALL marcas WITH 1 IN cursor_4c_Copia
1757:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Copia.grd_4c_DadosCopia.Refresh()
1758:             ENDIF
1759:         CATCH TO loc_oErro
1760:             MsgErro("Erro em BtnMarcarCopiaClick: " + loc_oErro.Message, "Erro")
1761:         ENDTRY
1762:     ENDPROC
1763: 
1764:     *--------------------------------------------------------------------------
1765:     * BtnDesmarcarCopiaClick - Desmarca todos os itens da copia
1766:     *--------------------------------------------------------------------------
1767:     PROCEDURE BtnDesmarcarCopiaClick()
1768:         TRY
1769:             IF USED("cursor_4c_Copia") AND RECCOUNT("cursor_4c_Copia") > 0
1770:                 REPLACE ALL marcas WITH 0 IN cursor_4c_Copia
1771:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Copia.grd_4c_DadosCopia.Refresh()
1772:             ENDIF
1773:         CATCH TO loc_oErro
1774:             MsgErro("Erro em BtnDesmarcarCopiaClick: " + loc_oErro.Message, "Erro")
1775:         ENDTRY
1776:     ENDPROC
1777: 
1778:     *--------------------------------------------------------------------------
1779:     * BtnSalvarClick - Confirma e salva os maximos do produto (Grupo_Salva.Confirmar)
1780:     * Logica: valida produto, limpa linhas vazias do cursor, salva via BO
1781:     *--------------------------------------------------------------------------
1782:     PROCEDURE BtnSalvarClick()
1783:         LOCAL loc_lResultado, loc_oPagina, loc_cCpros
1784:         loc_lResultado = .F.
1785:         loc_oPagina    = THIS.pgf_4c_Paginas.Page2

*-- Linhas 1795 a 1817:
1795:                 ELSE
1796:                     *-- Remover linhas com empresa vazia do cursor de maximos (limpeza antes de salvar)
1797:                     IF USED("cursor_4c_Max") AND RECCOUNT("cursor_4c_Max") > 0
1798:                         SELECT cursor_4c_Max
1799:                         GO TOP
1800:                         SCAN
1801:                             IF EMPTY(ALLTRIM(cursor_4c_Max.emps))
1802:                                 DELETE IN cursor_4c_Max
1803:                             ENDIF
1804:                         ENDSCAN
1805:                     ENDIF
1806: 
1807:                     IF THIS.this_oBusinessObject.SalvarGradeMax(PADR(loc_cCpros, 14))
1808:                         MsgInfo("M" + CHR(225) + "ximos salvos com sucesso.", "Sucesso")
1809:                         IF !EMPTY(THIS.this_cPExterno)
1810:                             THIS.Release()
1811:                         ELSE
1812:                             THIS.AlternarPagina(1)
1813:                             THIS.CarregarLista()
1814:                         ENDIF
1815:                         loc_lResultado = .T.
1816:                     ELSE
1817:                         MsgErro("Erro ao salvar m" + CHR(225) + "ximos: " + ;

*-- Linhas 1914 a 1946:
1914:         ENDIF
1915: 
1916:         TRY
1917:             loc_cSQL = "SELECT p.cpros, p.dpros, p.cgrus, g.dgrus," + ;
1918:                        " p.ifors, c.Rclis AS rclis, p.reffs, p.Situas, p.varias" + ;
1919:                        " FROM SigCdPro p" + ;
1920:                        " LEFT JOIN SigCdGrp g ON g.cgrus = p.cgrus" + ;
1921:                        " LEFT JOIN SigCdCli c ON c.Iclis = p.ifors" + ;
1922:                        " WHERE p.cpros = " + EscaparSQL(PADR(ALLTRIM(par_cCpros), 14))
1923: 
1924:             IF USED("cursor_4c_ProdInfo")
1925:                 USE IN cursor_4c_ProdInfo
1926:             ENDIF
1927: 
1928:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdInfo")
1929: 
1930:             IF loc_nResult > 0 AND USED("cursor_4c_ProdInfo") AND RECCOUNT("cursor_4c_ProdInfo") > 0
1931:                 SELECT cursor_4c_ProdInfo
1932:                 GO TOP
1933: 
1934:                 loc_oPagina.txt_4c__produto.Value = ALLTRIM(cursor_4c_ProdInfo.cpros)
1935:                 loc_oPagina.txt_4c_Dpro.Value     = ALLTRIM(cursor_4c_ProdInfo.dpros)
1936:                 loc_oPagina.txt_4c_Cgru.Value     = ALLTRIM(cursor_4c_ProdInfo.cgrus)
1937:                 loc_oPagina.txt_4c_Dgru.Value     = TratarNulo(cursor_4c_ProdInfo.dgrus, "C")
1938: 
1939:                 THIS.this_nTipoEstos = NVL(cursor_4c_ProdInfo.varias, 0)
1940:                 THIS.this_lTemTam    = INLIST(THIS.this_nTipoEstos, 1, 3)
1941:                 THIS.this_lTemCor    = INLIST(THIS.this_nTipoEstos, 2, 3)
1942: 
1943:                 loc_oPagina.obj_4c_Opc_situacao.Value = IIF(NVL(cursor_4c_ProdInfo.Situas, 1) = 2, 2, 1)
1944: 
1945:                 loc_oPagina.txt_4c_Ifor.Value = ALLTRIM(TratarNulo(cursor_4c_ProdInfo.ifors, "C"))
1946:                 loc_oPagina.txt_4c_Dfor.Value = ALLTRIM(TratarNulo(cursor_4c_ProdInfo.rclis, "C"))

*-- Linhas 2011 a 2045:
2011:                     USE IN cursor_4c_Max
2012:                 ENDIF
2013:                 SET NULL ON
2014:                 CREATE CURSOR cursor_4c_Max (cidchaves C(20), emps C(3), qmaxs N(7,2), ;
2015:                     codtams C(4), codcores C(4), deptos C(10), ordems C(1))
2016:                 SET NULL OFF
2017:                 loc_lResultado = .T.
2018:             ENDIF
2019: 
2020:             IF loc_lResultado AND USED("cursor_4c_Max")
2021:                 loc_oGrid = loc_oPagina.grd_4c_Gradei
2022: 
2023:                 *-- RecordSource e ControlSources FORA de WITH (Problema 36)
2024:                 loc_oGrid.ColumnCount = 5
2025:                 loc_oGrid.RecordSource               = "cursor_4c_Max"
2026:                 loc_oGrid.Column1.ControlSource      = "cursor_4c_Max.emps"
2027:                 loc_oGrid.Column2.ControlSource      = "cursor_4c_Max.qmaxs"
2028:                 loc_oGrid.Column3.ControlSource      = "cursor_4c_Max.codtams"
2029:                 loc_oGrid.Column4.ControlSource      = "cursor_4c_Max.codcores"
2030:                 loc_oGrid.Column5.ControlSource      = "cursor_4c_Max.deptos"
2031: 
2032:                 *-- Headers OBRIGATORIO re-setar apos RecordSource (VFP9 reseta)
2033:                 loc_oGrid.Column1.Header1.Caption = "Empresa"
2034:                 loc_oGrid.Column2.Header1.Caption = "Qtde.M" + CHR(225) + "x."
2035:                 loc_oGrid.Column3.Header1.Caption = "Tam."
2036:                 loc_oGrid.Column4.Header1.Caption = "Cor"
2037:                 loc_oGrid.Column5.Header1.Caption = "Departamento"
2038: 
2039:                 GO TOP IN cursor_4c_Max
2040:                 loc_oGrid.Refresh()
2041: 
2042:                 IF RECCOUNT("cursor_4c_Max") = 0
2043:                     THIS.GradeINovaLinha()
2044:                 ENDIF
2045:             ENDIF

*-- Linhas 2067 a 2123:
2067:             loc_cEmps = IIF(!EMPTY(ALLTRIM(go_4c_Sistema.cCodEmpresa)), ;
2068:                 PADR(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3), SPACE(3))
2069: 
2070:             INSERT INTO cursor_4c_Max ;
2071:                 (cidchaves, emps, qmaxs, codtams, codcores, deptos, ordems) ;
2072:                 VALUES (SPACE(20), loc_cEmps, 0, SPACE(4), SPACE(4), SPACE(10), SPACE(1))
2073: 
2074:             GO BOTTOM IN cursor_4c_Max
2075:             THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.Refresh()
2076:             THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.SetFocus()
2077:             THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.DoScroll(2)
2078:         CATCH TO loc_oErro
2079:             MsgErro("Erro em GradeINovaLinha: " + loc_oErro.Message, "Erro")
2080:         ENDTRY
2081:     ENDPROC
2082: 
2083:     *--------------------------------------------------------------------------
2084:     * GradeIAfterRowColChange - Ajusta colunas de variacao; adiciona linha ao final
2085:     *--------------------------------------------------------------------------
2086:     PROCEDURE GradeIAfterRowColChange(par_nColIndex)
2087:         TRY
2088:             THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.Column3.ReadOnly = !THIS.this_lTemTam
2089:             THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.Column4.ReadOnly = !THIS.this_lTemCor
2090: 
2091:             IF USED("cursor_4c_Max") AND INLIST(THIS.this_cPCEscolha, "INSERIR", "ALTERAR")
2092:                 SELECT cursor_4c_Max
2093:                 IF EOF()
2094:                     THIS.GradeINovaLinha()
2095:                 ENDIF
2096:             ENDIF
2097:         CATCH TO loc_oErro
2098:             MsgErro("Erro em GradeIAfterRowColChange: " + loc_oErro.Message, "Erro")
2099:         ENDTRY
2100:     ENDPROC
2101: 
2102:     *--------------------------------------------------------------------------
2103:     * QmaxsLostFocus - Valida quantidade maxima (nao pode ser negativa)
2104:     *--------------------------------------------------------------------------
2105:     PROCEDURE QmaxsLostFocus()
2106:         TRY
2107:             IF USED("cursor_4c_Max") AND !EOF("cursor_4c_Max") AND !BOF("cursor_4c_Max")
2108:                 SELECT cursor_4c_Max
2109:                 IF NVL(cursor_4c_Max.qmaxs, 0) < 0
2110:                     REPLACE cursor_4c_Max.qmaxs WITH 0
2111:                 ENDIF
2112:             ENDIF
2113:         CATCH TO loc_oErro
2114:             MsgErro("Erro em QmaxsLostFocus: " + loc_oErro.Message, "Erro")
2115:         ENDTRY
2116:     ENDPROC
2117: 
2118:     *--------------------------------------------------------------------------
2119:     * TamKeyPress - F4 abre lookup SigCdTam para coluna de tamanho
2120:     *--------------------------------------------------------------------------
2121:     PROCEDURE TamKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2122:         IF !INLIST(par_nKeyCode, 13, 9, 115)
2123:             RETURN

*-- Linhas 2151 a 2169:
2151: 
2152:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTam")
2153:                     IF USED("cursor_4c_Max") AND !EOF("cursor_4c_Max") AND !BOF("cursor_4c_Max")
2154:                         SELECT cursor_4c_Max
2155:                         REPLACE codtams WITH PADR(ALLTRIM(cursor_4c_BuscaTam.ctams), 4)
2156:                     ENDIF
2157:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.Refresh()
2158:                 ENDIF
2159: 
2160:                 loc_oBusca.Release()
2161:             ENDIF
2162: 
2163:             IF USED("cursor_4c_BuscaTam")
2164:                 USE IN cursor_4c_BuscaTam
2165:             ENDIF
2166:         CATCH TO loc_oErro
2167:             MsgErro("Erro ao buscar tamanho: " + loc_oErro.Message, "Erro")
2168:         ENDTRY
2169:     ENDPROC

*-- Linhas 2204 a 2222:
2204: 
2205:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCor")
2206:                     IF USED("cursor_4c_Max") AND !EOF("cursor_4c_Max") AND !BOF("cursor_4c_Max")
2207:                         SELECT cursor_4c_Max
2208:                         REPLACE codcores WITH PADR(ALLTRIM(cursor_4c_BuscaCor.ccors), 4)
2209:                     ENDIF
2210:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.Refresh()
2211:                 ENDIF
2212: 
2213:                 loc_oBusca.Release()
2214:             ENDIF
2215: 
2216:             IF USED("cursor_4c_BuscaCor")
2217:                 USE IN cursor_4c_BuscaCor
2218:             ENDIF
2219:         CATCH TO loc_oErro
2220:             MsgErro("Erro ao buscar cor: " + loc_oErro.Message, "Erro")
2221:         ENDTRY
2222:     ENDPROC

*-- Linhas 2257 a 2275:
2257: 
2258:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDpt")
2259:                     IF USED("cursor_4c_Max") AND !EOF("cursor_4c_Max") AND !BOF("cursor_4c_Max")
2260:                         SELECT cursor_4c_Max
2261:                         REPLACE deptos WITH PADR(ALLTRIM(cursor_4c_BuscaDpt.codigos), 10)
2262:                     ENDIF
2263:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.Refresh()
2264:                 ENDIF
2265: 
2266:                 loc_oBusca.Release()
2267:             ENDIF
2268: 
2269:             IF USED("cursor_4c_BuscaDpt")
2270:                 USE IN cursor_4c_BuscaDpt
2271:             ENDIF
2272:         CATCH TO loc_oErro
2273:             MsgErro("Erro ao buscar departamento: " + loc_oErro.Message, "Erro")
2274:         ENDTRY
2275:     ENDPROC

*-- Linhas 2304 a 2335:
2304:                 RETURN
2305:             ENDIF
2306: 
2307:             SELECT cursor_4c_Max
2308:             IF !EOF() AND !BOF()
2309:                 loc_cEmps = ALLTRIM(TratarNulo(cursor_4c_Max.emps, "C"))
2310:             ENDIF
2311: 
2312:             IF EMPTY(loc_cEmps)
2313:                 loc_cEmps = ALLTRIM(go_4c_Sistema.cCodEmpresa)
2314:             ENDIF
2315: 
2316:             SELECT cursor_4c_Max
2317:             GO TOP
2318:             SCAN
2319:                 IF ALLTRIM(cursor_4c_Max.emps) = loc_cEmps
2320:                     DELETE
2321:                 ENDIF
2322:             ENDSCAN
2323:             PACK
2324: 
2325:             IF RECCOUNT("cursor_4c_Max") = 0
2326:                 THIS.GradeINovaLinha()
2327:             ENDIF
2328: 
2329:             THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.Refresh()
2330:         CATCH TO loc_oErro
2331:             MsgErro("Erro em BtnExcluirGradeClick: " + loc_oErro.Message, "Erro")
2332:         ENDTRY
2333:     ENDPROC
2334: 
2335:     *--------------------------------------------------------------------------


### BO (C:\4c\projeto\app\classes\sigprcomBO.prg):
*==============================================================================
* sigprcomBO.prg - Business Object para Estoque M" + CHR(225) + "ximo (SigCdMax)
* Herda de BusinessBase
*==============================================================================
DEFINE CLASS sigprcomBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - Tabela SigCdMax (linha corrente da grade de estoque)
    *--------------------------------------------------------------------------
    this_cCidChaves  = ""   && char(20) - PK
    this_cCodCores   = ""   && char(4)  - C" + CHR(243) + "digo da Cor
    this_cCodTams    = ""   && char(4)  - C" + CHR(243) + "digo do Tamanho
    this_cCPros      = ""   && char(14) - C" + CHR(243) + "digo do Produto (FK SigCdPro)
    this_cEmps       = ""   && char(3)  - Empresa
    this_cOrdems     = ""   && char(1)  - Ordem
    this_nQmaxs      = 0    && numeric(7,2) - Quantidade M" + CHR(225) + "xima
    this_cDeptos     = ""   && char(10) - Departamento (FK SigCdDpt)

    *--------------------------------------------------------------------------
    * Propriedades - Informa" + CHR(231) + CHR(245) + "es do Produto (SigCdPro - leitura)
    *--------------------------------------------------------------------------
    this_cDPros      = ""   && char(65) - Descri" + CHR(231) + CHR(227) + "o do Produto
    this_cCGrus      = ""   && char(3)  - C" + CHR(243) + "digo do Grupo
    this_cDGrus      = ""   && Descri" + CHR(231) + CHR(227) + "o do Grupo (join SigCdGrp)
    this_cIFors      = ""   && char(10) - C" + CHR(243) + "digo do Fornecedor
    this_cRClis      = ""   && Raz" + CHR(227) + "o do Fornecedor (join SigCdCli)
    this_cReffs      = ""   && char(40) - Refer" + CHR(234) + "ncia do Produto
    this_nSituas     = 0    && numeric(1,0) - Situa" + CHR(231) + CHR(227) + "o (1=ativo, 2=inativo)

    *--------------------------------------------------------------------------
    * Propriedades - Caracter" + CHR(237) + "sticas de varia" + CHR(231) + CHR(227) + "o do produto
    *--------------------------------------------------------------------------
    this_lTemCor     = .F.  && Produto possui varia" + CHR(231) + CHR(227) + "o de Cor
    this_lTemTam     = .F.  && Produto possui varia" + CHR(231) + CHR(227) + "o de Tamanho
    this_nTipoEstos  = 0    && Tipo de Estoque (0=sem, 1=tam, 2=cor, 3=tam+cor)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave prim" + CHR(225) + "ria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdMax"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK do registro corrente (auditoria)
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - L" + CHR(234) + " linha de SigCdMax de um cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            THIS.this_cCodCores  = TratarNulo(codcores,  "C")
            THIS.this_cCodTams   = TratarNulo(codtams,   "C")
            THIS.this_cCPros     = TratarNulo(cpros,     "C")
            THIS.this_cEmps      = TratarNulo(emps,      "C")
            THIS.this_cOrdems    = TratarNulo(ordems,    "C")
            THIS.this_nQmaxs     = TratarNulo(qmaxs,     "N")
            THIS.this_cDeptos    = TratarNulo(deptos,    "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Pesquisa produtos em SigCdPro para a lista (Page1)
    * par_cFiltro: filtro livre por cpros/dpros/ifors/reffs
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            IF EMPTY(par_cFiltro)
                loc_cSQL = "SELECT p.cpros, p.dpros, p.cgrus, g.dgrus, p.ifors," + ;
                    " p.reffs, p.situas" + ;
                    " FROM SigCdPro p" + ;
                    " LEFT JOIN SigCdGrp g ON g.cgrus = p.cgrus" + ;
                    " ORDER BY p.cpros"
            ELSE
                loc_cSQL = "SELECT p.cpros, p.dpros, p.cgrus, g.dgrus, p.ifors," + ;
                    " p.reffs, p.situas" + ;
                    " FROM SigCdPro p" + ;
                    " LEFT JOIN SigCdGrp g ON g.cgrus = p.cgrus" + ;
                    " WHERE p.cpros LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                    " OR p.dpros LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                    " OR p.ifors LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                    " OR p.reffs LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                    " ORDER BY p.cpros"
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult < 0
                MsgErro("Erro ao buscar produtos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega produto + SigCdMax do produto
    * par_cCPros: c" + CHR(243) + "digo do produto
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCPros)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_nVarias
        loc_lResultado = .F.

        IF EMPTY(par_cCPros)
            MsgAviso("C" + CHR(243) + "digo do produto n" + CHR(227) + "o informado!")
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_Produto")
                USE IN cursor_4c_Produto
            ENDIF

            loc_cSQL = "SELECT p.cpros, p.dpros, p.cgrus, g.dgrus, p.ifors," + ;
                " c.rclis, p.reffs, p.situas, p.codcors, p.codtams, p.varias" + ;
                " FROM SigCdPro p" + ;
                " LEFT JOIN SigCdGrp g ON g.cgrus = p.cgrus" + ;
                " LEFT JOIN SigCdCli c ON c.iclis = p.ifors" + ;
                " WHERE p.cpros = " + EscaparSQL(par_cCPros)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Produto")

            IF loc_nResult < 0
                MsgErro("Erro ao carregar produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                IF !USED("cursor_4c_Produto") OR RECCOUNT("cursor_4c_Produto") = 0
                MsgErro("Produto n" + CHR(227) + "o encontrado!", "Aviso")
                loc_lResultado = .F.
            ELSE
                SELECT cursor_4c_Produto
                GO TOP

                THIS.this_cCPros     = ALLTRIM(TratarNulo(cpros,  "C"))
                THIS.this_cDPros     = ALLTRIM(TratarNulo(dpros,  "C"))
                THIS.this_cCGrus     = ALLTRIM(TratarNulo(cgrus,  "C"))
                THIS.this_cDGrus     = ALLTRIM(TratarNulo(dgrus,  "C"))
                THIS.this_cIFors     = ALLTRIM(TratarNulo(ifors,  "C"))
                THIS.this_cRClis     = ALLTRIM(TratarNulo(rclis,  "C"))
                THIS.this_cReffs     = ALLTRIM(TratarNulo(reffs,  "C"))
                THIS.this_nSituas    = TratarNulo(situas, "N")
                THIS.this_lNovoRegistro = .F.

                loc_nVarias = TratarNulo(varias, "N")
                DO CASE
                    CASE loc_nVarias = 0
                        THIS.this_nTipoEstos = 0
                        THIS.this_lTemCor    = .F.
                        THIS.this_lTemTam    = .F.
                    CASE loc_nVarias = 1
                        THIS.this_nTipoEstos = 1
                        THIS.this_lTemTam    = .T.
                        THIS.this_lTemCor    = .F.
                    CASE loc_nVarias = 2
                        THIS.this_nTipoEstos = 2
                        THIS.this_lTemCor    = .T.
                        THIS.this_lTemTam    = .F.
                    CASE loc_nVarias = 3
                        THIS.this_nTipoEstos = 3
                        THIS.this_lTemTam    = .T.
                        THIS.this_lTemCor    = .T.
                    OTHERWISE
                        THIS.this_nTipoEstos = 0
                        THIS.this_lTemCor    = .F.
                        THIS.this_lTemTam    = .F.
                ENDCASE

                IF USED("cursor_4c_Produto")
                    USE IN cursor_4c_Produto
                ENDIF

                loc_lResultado = THIS.CarregarMaxPorProduto(par_cCPros)
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarMaxPorProduto - Carrega SigCdMax de um produto em cursor_4c_Max
    * Cria cursor local EDITAVEL (SQLEXEC retorna cursor somente leitura)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarMaxPorProduto(par_cCPros)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Max")
                USE IN cursor_4c_Max
            ENDIF
            IF USED("cursor_4c_MaxTemp")
                USE IN cursor_4c_MaxTemp
            ENDIF

            loc_cSQL = "SELECT m.cidchaves, m.emps, m.qmaxs, m.codtams," + ;
                " m.codcores, m.deptos, m.ordems" + ;
                " FROM SigCdMax m" + ;
                " WHERE m.cpros = " + EscaparSQL(par_cCPros) + ;
                " ORDER BY m.emps, m.codtams, m.codcores, m.deptos"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxTemp")
            IF loc_nResult < 0
                MsgErro("Erro ao carregar estoque m" + CHR(225) + "ximo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                *-- Criar cursor local editavel (SQLEXEC cria cursor somente leitura)
                SET NULL ON
                CREATE CURSOR cursor_4c_Max (cidchaves C(20), emps C(3), qmaxs N(7,2), ;
                    codtams C(4), codcores C(4), deptos C(10), ordems C(1))
                SET NULL OFF

                IF USED("cursor_4c_MaxTemp") AND RECCOUNT("cursor_4c_MaxTemp") > 0
                    APPEND FROM DBF("cursor_4c_MaxTemp")
                ENDIF

                IF USED("cursor_4c_MaxTemp")
                    USE IN cursor_4c_MaxTemp
                ENDIF

                GO TOP IN cursor_4c_Max
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CarregarMaxPorProduto:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT de um registro em SigCdMax (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cChave
        loc_lResultado = .F.

        TRY
            loc_cChave               = fUniqueIds()
            THIS.this_cCidChaves     = loc_cChave

            loc_cSQL = "INSERT INTO SigCdMax" + ;
                " (cidchaves, cpros, emps, qmaxs, codtams, codcores, deptos, ordems)" + ;
                " VALUES (" + ;
                EscaparSQL(loc_cChave) + ", " + ;
                EscaparSQL(THIS.this_cCPros) + ", " + ;
                LEFT(EscaparSQL(THIS.this_cEmps), 7) + ", " + ;
                FormatarNumeroSQL(THIS.this_nQmaxs) + ", " + ;
                LEFT(EscaparSQL(THIS.this_cCodTams), 8) + ", " + ;
                LEFT(EscaparSQL(THIS.this_cCodCores), 8) + ", " + ;
                LEFT(EscaparSQL(THIS.this_cDeptos), 14) + ", " + ;
                EscaparSQL(THIS.this_cOrdems) + ;
                ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
            IF loc_nResult < 0
                MsgErro("Erro ao inserir estoque m" + CHR(225) + "ximo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        IF USED("cursor_4c_Ins")
            USE IN cursor_4c_Ins
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE de um registro de SigCdMax (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF EMPTY(THIS.this_cCidChaves)
                MsgErro("Chave do registro n" + CHR(227) + "o definida!", "Erro")
                loc_lResultado = .F.
            ELSE
                loc_cSQL = "UPDATE SigCdMax SET" + ;
                    " qmaxs = " + FormatarNumeroSQL(THIS.this_nQmaxs) + "," + ;
                    " codtams = " + LEFT(EscaparSQL(THIS.this_cCodTams), 8) + "," + ;
                    " codcores = " + LEFT(EscaparSQL(THIS.this_cCodCores), 8) + "," + ;
                    " deptos = " + LEFT(EscaparSQL(THIS.this_cDeptos), 14) + "," + ;
                    " emps = " + LEFT(EscaparSQL(THIS.this_cEmps), 7) + "," + ;
                    " ordems = " + EscaparSQL(THIS.this_cOrdems) + ;
                    " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
                IF loc_nResult < 0
                    MsgErro("Erro ao atualizar estoque m" + CHR(225) + "ximo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lResultado = .F.
                ELSE
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lResultado = .T.
                ENDIF

                IF USED("cursor_4c_Upd")
                    USE IN cursor_4c_Upd
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de SigCdMax (PROTECTED)
    * Deleta por cidchaves OU por cpros+emps dependendo do contexto
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF !EMPTY(THIS.this_cCidChaves)
                loc_cSQL = "DELETE FROM SigCdMax WHERE cidchaves = " + ;
                    EscaparSQL(THIS.this_cCidChaves)
            ELSE
                IF !EMPTY(THIS.this_cCPros) AND !EMPTY(THIS.this_cEmps)
                loc_cSQL = "DELETE FROM SigCdMax WHERE cpros = " + ;
                    EscaparSQL(THIS.this_cCPros) + ;
                    " AND emps = " + LEFT(EscaparSQL(THIS.this_cEmps), 7)
            ELSE
                MsgErro("Nenhuma chave definida para exclus" + CHR(227) + "o!", "Erro")
                loc_lResultado = .F.
                ENDIF
            ENDIF

            IF !EMPTY(loc_cSQL)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
                IF loc_nResult < 0
                    MsgErro("Erro ao excluir estoque m" + CHR(225) + "ximo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lResultado = .F.
                ELSE
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ENDIF

                IF USED("cursor_4c_Del")
                    USE IN cursor_4c_Del
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarGradeMax - Persiste cursor_4c_Max no banco (replace by delete+insert)
    * Chamado pelo form ap" + CHR(243) + "s edi" + CHR(231) + CHR(227) + "o da grade para o produto par_cCPros
    *--------------------------------------------------------------------------
    PROCEDURE SalvarGradeMax(par_cCPros)
        LOCAL loc_lResultado, loc_nResult
        LOCAL loc_cChaveNova, loc_cInsSQL
        loc_lResultado = .F.

        IF EMPTY(par_cCPros)
            MsgAviso("C" + CHR(243) + "digo do produto n" + CHR(227) + "o definido!")
            RETURN .F.
        ENDIF

        IF !USED("cursor_4c_Max")
            MsgErro("Cursor de estoque m" + CHR(225) + "ximo n" + CHR(227) + "o dispon" + CHR(237) + "vel!", "Erro")
            RETURN .F.
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigCdMax WHERE cpros = " + EscaparSQL(par_cCPros) + ;
                " AND emps <> ''", ;
                "cursor_4c_DelAll")

            IF loc_nResult < 0
                MsgErro("Erro ao limpar estoque m" + CHR(225) + "ximo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                IF USED("cursor_4c_DelAll")
                    USE IN cursor_4c_DelAll
                ENDIF

                SELECT cursor_4c_Max
                GO TOP
                loc_lResultado = .T.

                DO WHILE !EOF("cursor_4c_Max") AND loc_lResultado
                    IF !EMPTY(ALLTRIM(cursor_4c_Max.emps))
                        loc_cChaveNova = fUniqueIds()

                        loc_cInsSQL = "INSERT INTO SigCdMax" + ;
                            " (cidchaves, cpros, emps, qmaxs, codtams, codcores, deptos, ordems)" + ;
                            " VALUES (" + ;
                            EscaparSQL(loc_cChaveNova) + ", " + ;
                            EscaparSQL(par_cCPros) + ", " + ;
                            LEFT(EscaparSQL(ALLTRIM(cursor_4c_Max.emps)), 7) + ", " + ;
                            FormatarNumeroSQL(cursor_4c_Max.qmaxs) + ", " + ;
                            LEFT(EscaparSQL(ALLTRIM(cursor_4c_Max.codtams)), 8) + ", " + ;
                            LEFT(EscaparSQL(ALLTRIM(cursor_4c_Max.codcores)), 8) + ", " + ;
                            LEFT(EscaparSQL(ALLTRIM(cursor_4c_Max.deptos)), 14) + ", " + ;
                            EscaparSQL(ALLTRIM(cursor_4c_Max.ordems)) + ;
                            ")"

                        loc_nResult = SQLEXEC(gnConnHandle, loc_cInsSQL, "cursor_4c_InsLinha")
                        IF loc_nResult < 0
                            MsgErro("Erro ao salvar linha de estoque:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lResultado = .F.
                        ELSE
                            IF USED("cursor_4c_InsLinha")
                                USE IN cursor_4c_InsLinha
                            ENDIF
                        ENDIF
                    ENDIF

                    IF loc_lResultado
                        SKIP IN cursor_4c_Max
                    ENDIF
                ENDDO

                IF loc_lResultado
                    THIS.RegistrarAuditoria("UPDATE")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em SalvarGradeMax:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCopiaParaCursor - Popula cursor_4c_Copia com dados da empresa origem
    * para a funcionalidade de c" + CHR(243) + "pia entre empresas (cntCopia)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarCopiaParaCursor(par_cCPros, par_cEmpOs, par_cEmpDs)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        IF EMPTY(par_cEmpOs)
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_Copia")
                USE IN cursor_4c_Copia
            ENDIF

            loc_cSQL = "SELECT o.cpros, o.emps, o.qmaxs, o.codtams, o.codcores," + ;
                " o.deptos," + ;
                " CASE WHEN d.cidchaves IS NOT NULL THEN 1 ELSE 0 END AS existes," + ;
                " CAST(0 AS INT) AS marcas" + ;
                " FROM SigCdMax o" + ;
                " LEFT JOIN SigCdMax d ON d.cpros = o.cpros" + ;
                " AND d.emps = " + LEFT(EscaparSQL(par_cEmpDs), 7) + ;
                " AND d.codtams = o.codtams AND d.codcores = o.codcores" + ;
                " AND d.deptos = o.deptos" + ;
                " WHERE o.emps = " + LEFT(EscaparSQL(par_cEmpOs), 7) + ;
                IIF(!EMPTY(ALLTRIM(par_cCPros)), " AND o.cpros = " + EscaparSQL(par_cCPros), "") + ;
                " ORDER BY o.codtams, o.codcores, o.deptos"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Copia")
            IF loc_nResult < 0
                MsgErro("Erro ao carregar c" + CHR(243) + "pia:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                IF USED("cursor_4c_Copia")
                    GO TOP IN cursor_4c_Copia
                ENDIF
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CarregarCopiaParaCursor:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CopiarMaxEntreEmpresas - Insere em SigCdMax os registros marcados do cursor
    * de c" + CHR(243) + "pia para a empresa destino
    * par_cEmpDs: empresa destino
    * par_cCursorCopia: nome do cursor com registros marcados (marcas=1, existes=0)
    *--------------------------------------------------------------------------
    PROCEDURE CopiarMaxEntreEmpresas(par_cEmpDs, par_cCursorCopia)
        LOCAL loc_lResultado, loc_nResult, loc_nCopias
        LOCAL loc_cChaveNova, loc_cCopSQL
        LOCAL loc_cCPros, loc_cEmps, loc_nQmaxs, loc_cCodTams
        LOCAL loc_cCodCores, loc_cDeptos, loc_nMarcas, loc_nExistes
        loc_lResultado = .F.
        loc_nCopias    = 0

        IF EMPTY(par_cEmpDs) OR EMPTY(par_cCursorCopia)
            MsgErro("Par" + CHR(226) + "metros inv" + CHR(225) + "lidos em CopiarMaxEntreEmpresas!", "Erro")
            RETURN .F.
        ENDIF

        IF !USED(par_cCursorCopia)
            MsgErro("Cursor de c" + CHR(243) + "pia n" + CHR(227) + "o dispon" + CHR(237) + "vel!", "Erro")
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cCursorCopia)
            GO TOP
            loc_lResultado = .T.

            DO WHILE !EOF() AND loc_lResultado
                loc_nMarcas  = TratarNulo(marcas,   "N")
                loc_nExistes = TratarNulo(existes,  "N")

                IF loc_nMarcas = 1 AND loc_nExistes = 0
                    loc_cCPros    = ALLTRIM(TratarNulo(cpros,    "C"))
                    loc_cEmps     = ALLTRIM(TratarNulo(emps,     "C"))
                    loc_nQmaxs    = TratarNulo(qmaxs,    "N")
                    loc_cCodTams  = ALLTRIM(TratarNulo(codtams,  "C"))
                    loc_cCodCores = ALLTRIM(TratarNulo(codcores, "C"))
                    loc_cDeptos   = ALLTRIM(TratarNulo(deptos,   "C"))

                    loc_cChaveNova = fUniqueIds()

                    loc_cCopSQL = "INSERT INTO SigCdMax" + ;
                        " (cpros, emps, qmaxs, codtams, codcores, cidchaves, deptos, ordems)" + ;
                        " VALUES (" + ;
                        EscaparSQL(loc_cCPros) + ", " + ;
                        LEFT(EscaparSQL(par_cEmpDs), 7) + ", " + ;
                        FormatarNumeroSQL(loc_nQmaxs) + ", " + ;
                        LEFT(EscaparSQL(loc_cCodTams), 8) + ", " + ;
                        LEFT(EscaparSQL(loc_cCodCores), 8) + ", " + ;
                        EscaparSQL(loc_cChaveNova) + ", " + ;
                        LEFT(EscaparSQL(loc_cDeptos), 14) + ", " + ;
                        "' ')"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cCopSQL, "cursor_4c_CopIns")
                    IF loc_nResult >= 0
                        loc_nCopias = loc_nCopias + 1
                        IF USED("cursor_4c_CopIns")
                            USE IN cursor_4c_CopIns
                        ENDIF
                    ELSE
                        MsgErro("Erro ao copiar linha:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        IF USED("cursor_4c_CopIns")
                            USE IN cursor_4c_CopIns
                        ENDIF
                        loc_lResultado = .F.
                    ENDIF

                    SELECT (par_cCursorCopia)
                ENDIF

                IF loc_lResultado
                    SKIP
                ENDIF
            ENDDO

            IF loc_lResultado
                MsgInfo("Foram copiados " + ALLTRIM(STR(loc_nCopias)) + ;
                    " registros para " + ALLTRIM(par_cEmpDs) + "!", ;
                    "C" + CHR(243) + "pia Conclu" + CHR(237) + "da")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CopiarMaxEntreEmpresas:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

