# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, CGRUS, CORES, TAMS, EMPS, ICLIS, EXISTES, PCESCOLHA, GESIND
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODTAMS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, CGRUS, CORES, TAMS, EMPS, ICLIS, EXISTES, PCESCOLHA, GESIND
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODCORES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, CGRUS, CORES, TAMS, EMPS, ICLIS, EXISTES, PCESCOLHA, GESIND

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigprcom.prg) - TRECHOS RELEVANTES PARA PASS SQL (2452 linhas total):

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
466:             *-- Legado: cpros(108), dpros(285), ifors(75), reffs(150), sgrus(45)
467:             .Column1.Width = 100
468:             .Column2.Width = 360
469:             .Column3.Width = 100
470:             .Column4.Width = 165
471:             .Column5.Width = 65
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

*-- Linhas 1157 a 1254:
1157:             .Width        = 387
1158:             .Height       = 472
1159:             .ReadOnly     = .F.
1160:             .DeleteMark   = .F.
1161:             .RecordMark   = .F.
1162:             .GridLines    = 1
1163:             .HeaderHeight = 20
1164:             .RowHeight    = 19
1165:             .FontName     = "Tahoma"
1166:             .FontSize     = 8
1167:             .Visible      = .T.
1168: 
1169:             WITH .Column1
1170:                 .ControlSource = ""
1171:                 .Width         = 40
1172:                 .Sparse        = .F.
1173:                 WITH .Header1
1174:                     .Caption  = "Empresa"
1175:                     .FontName = "Tahoma"
1176:                     .FontSize = 8
1177:                     .FontBold = .T.
1178:                 ENDWITH
1179:                 WITH .Text1
1180:                     .Value    = ""
1181:                     .FontName = "Tahoma"
1182:                     .FontSize = 8
1183:                 ENDWITH
1184:             ENDWITH
1185: 
1186:             WITH .Column2
1187:                 .ControlSource = ""
1188:                 .Width         = 65
1189:                 .Sparse        = .F.
1190:                 WITH .Header1
1191:                     .Caption  = "Qtde.M" + CHR(225) + "x."
1192:                     .FontName = "Tahoma"
1193:                     .FontSize = 8
1194:                     .FontBold = .T.
1195:                 ENDWITH
1196:                 WITH .Text1
1197:                     .Value    = 0
1198:                     .Format   = "9999.99"
1199:                     .FontName = "Tahoma"
1200:                     .FontSize = 8
1201:                 ENDWITH
1202:             ENDWITH
1203: 
1204:             WITH .Column3
1205:                 .ControlSource = ""
1206:                 .Width         = 55
1207:                 .Sparse        = .F.
1208:                 WITH .Header1
1209:                     .Caption  = "Tam."
1210:                     .FontName = "Tahoma"
1211:                     .FontSize = 8
1212:                     .FontBold = .T.
1213:                 ENDWITH
1214:                 WITH .Text1
1215:                     .Value    = ""
1216:                     .FontName = "Tahoma"
1217:                     .FontSize = 8
1218:                 ENDWITH
1219:             ENDWITH
1220: 
1221:             WITH .Column4
1222:                 .ControlSource = ""
1223:                 .Width         = 55
1224:                 .Sparse        = .F.
1225:                 WITH .Header1
1226:                     .Caption  = "Cor"
1227:                     .FontName = "Tahoma"
1228:                     .FontSize = 8
1229:                     .FontBold = .T.
1230:                 ENDWITH
1231:                 WITH .Text1
1232:                     .Value    = ""
1233:                     .FontName = "Tahoma"
1234:                     .FontSize = 8
1235:                 ENDWITH
1236:             ENDWITH
1237: 
1238:             WITH .Column5
1239:                 .ControlSource = ""
1240:                 .Width         = 172
1241:                 .Sparse        = .F.
1242:                 WITH .Header1
1243:                     .Caption  = "Departamento"
1244:                     .FontName = "Tahoma"
1245:                     .FontSize = 8
1246:                     .FontBold = .T.
1247:                 ENDWITH
1248:                 WITH .Text1
1249:                     .Value    = ""
1250:                     .FontName = "Tahoma"
1251:                     .FontSize = 8
1252:                 ENDWITH
1253:             ENDWITH
1254:         ENDWITH

*-- Linhas 1294 a 1317:
1294:                         loc_oGrid.ColumnCount = 5
1295:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
1296: 
1297:                         *-- ControlSource de cada coluna (identico ao legado)
1298:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cpros"
1299:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.dpros"
1300:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.ifors"
1301:                         loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.reffs"
1302:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.sgrus"
1303: 
1304:                         *-- Headers: OBRIGATORIO re-setar apos RecordSource (VFP9 reseta)
1305:                         *-- Identicos ao legado (pColuna: Produto, Descricao, Fornecedor, Referencia, Sub Grp)
1306:                         loc_oGrid.Column1.Header1.Caption = "Produto"
1307:                         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1308:                         loc_oGrid.Column3.Header1.Caption = "Fornecedor"
1309:                         loc_oGrid.Column4.Header1.Caption = "Refer" + CHR(234) + "ncia"
1310:                         loc_oGrid.Column5.Header1.Caption = "Sub Grp"
1311: 
1312:                         THIS.FormatarGridLista(loc_oGrid)
1313:                         loc_lResultado = .T.
1314:                     ENDIF
1315:                 ENDIF
1316:             ENDIF
1317: 

*-- Linhas 1505 a 1524:
1505:                 ELSE
1506:                     IF MsgConfirma("Excluir todos os m" + CHR(225) + "ximos do produto " + loc_cCpros + "?", ;
1507:                             "Confirmar Exclus" + CHR(227) + "o")
1508:                         loc_nResult = SQLEXEC(gnConnHandle, ;
1509:                             "DELETE FROM SigCdMax WHERE cpros = " + EscaparSQL(PADR(loc_cCpros, 14)))
1510:                         IF loc_nResult > 0
1511:                             MsgInfo("M" + CHR(225) + "ximos exclu" + CHR(237) + "dos com sucesso.", "Sucesso")
1512:                             THIS.CarregarLista()
1513:                             loc_lResultado = .T.
1514:                         ELSE
1515:                             MsgErro("Erro ao excluir m" + CHR(225) + "ximos do produto.", "Erro")
1516:                         ENDIF
1517:                     ENDIF
1518:                 ENDIF
1519:             ELSE
1520:                 MsgAviso("Nenhum produto na lista.", "Aten" + CHR(231) + CHR(227) + "o")
1521:             ENDIF
1522:         CATCH TO loc_oErro
1523:             MsgErro("Erro em BtnExcluirClick: " + loc_oErro.Message, "Erro")
1524:         ENDTRY

*-- Linhas 1665 a 1688:
1665:                             *-- RecordSource FORA de WITH (Problema 36)
1666:                             loc_oGrid.ColumnCount = 6
1667:                             loc_oGrid.RecordSource = "cursor_4c_Copia"
1668:                             loc_oGrid.Column1.ControlSource = "cursor_4c_Copia.marcas"
1669:                             loc_oGrid.Column2.ControlSource = "cursor_4c_Copia.cpros"
1670:                             loc_oGrid.Column3.ControlSource = "cursor_4c_Copia.qmaxs"
1671:                             loc_oGrid.Column4.ControlSource = "cursor_4c_Copia.codtams"
1672:                             loc_oGrid.Column5.ControlSource = "cursor_4c_Copia.codcores"
1673:                             loc_oGrid.Column6.ControlSource = "cursor_4c_Copia.deptos"
1674: 
1675:                             *-- Headers: re-setar apos RecordSource (VFP9 reseta)
1676:                             loc_oGrid.Column1.Header1.Caption = ""
1677:                             loc_oGrid.Column2.Header1.Caption = "Produto"
1678:                             loc_oGrid.Column3.Header1.Caption = "Qtde. M" + CHR(225) + "x."
1679:                             loc_oGrid.Column4.Header1.Caption = "Tam"
1680:                             loc_oGrid.Column5.Header1.Caption = "Cor"
1681:                             loc_oGrid.Column6.Header1.Caption = "Departamento"
1682: 
1683:                             GO TOP IN cursor_4c_Copia
1684:                             loc_lResultado = .T.
1685:                         ELSE
1686:                             MsgAviso("Nenhum produto encontrado para c" + CHR(243) + "pia.", "Aviso")
1687:                         ENDIF
1688:                     ELSE

*-- Linhas 1803 a 1825:
1803:                 ELSE
1804:                     *-- Remover linhas com empresa vazia do cursor de maximos (limpeza antes de salvar)
1805:                     IF USED("cursor_4c_Max") AND RECCOUNT("cursor_4c_Max") > 0
1806:                         SELECT cursor_4c_Max
1807:                         GO TOP
1808:                         SCAN
1809:                             IF EMPTY(ALLTRIM(cursor_4c_Max.emps))
1810:                                 DELETE IN cursor_4c_Max
1811:                             ENDIF
1812:                         ENDSCAN
1813:                     ENDIF
1814: 
1815:                     IF THIS.this_oBusinessObject.SalvarGradeMax(PADR(loc_cCpros, 14))
1816:                         MsgInfo("M" + CHR(225) + "ximos salvos com sucesso.", "Sucesso")
1817:                         IF !EMPTY(THIS.this_cPExterno)
1818:                             THIS.Release()
1819:                         ELSE
1820:                             THIS.AlternarPagina(1)
1821:                             THIS.CarregarLista()
1822:                         ENDIF
1823:                         loc_lResultado = .T.
1824:                     ELSE
1825:                         MsgErro("Erro ao salvar m" + CHR(225) + "ximos: " + ;

*-- Linhas 1922 a 1954:
1922:         ENDIF
1923: 
1924:         TRY
1925:             loc_cSQL = "SELECT p.cpros, p.dpros, p.cgrus, g.dgrus," + ;
1926:                        " p.ifors, c.Rclis AS rclis, p.reffs, p.Situas, p.varias" + ;
1927:                        " FROM SigCdPro p" + ;
1928:                        " LEFT JOIN SigCdGrp g ON g.cgrus = p.cgrus" + ;
1929:                        " LEFT JOIN SigCdCli c ON c.Iclis = p.ifors" + ;
1930:                        " WHERE p.cpros = " + EscaparSQL(PADR(ALLTRIM(par_cCpros), 14))
1931: 
1932:             IF USED("cursor_4c_ProdInfo")
1933:                 USE IN cursor_4c_ProdInfo
1934:             ENDIF
1935: 
1936:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdInfo")
1937: 
1938:             IF loc_nResult > 0 AND USED("cursor_4c_ProdInfo") AND RECCOUNT("cursor_4c_ProdInfo") > 0
1939:                 SELECT cursor_4c_ProdInfo
1940:                 GO TOP
1941: 
1942:                 loc_oPagina.txt_4c__produto.Value = ALLTRIM(cursor_4c_ProdInfo.cpros)
1943:                 loc_oPagina.txt_4c_Dpro.Value     = ALLTRIM(cursor_4c_ProdInfo.dpros)
1944:                 loc_oPagina.txt_4c_Cgru.Value     = ALLTRIM(cursor_4c_ProdInfo.cgrus)
1945:                 loc_oPagina.txt_4c_Dgru.Value     = TratarNulo(cursor_4c_ProdInfo.dgrus, "C")
1946: 
1947:                 THIS.this_nTipoEstos = NVL(cursor_4c_ProdInfo.varias, 0)
1948:                 THIS.this_lTemTam    = INLIST(THIS.this_nTipoEstos, 1, 3)
1949:                 THIS.this_lTemCor    = INLIST(THIS.this_nTipoEstos, 2, 3)
1950: 
1951:                 loc_oPagina.obj_4c_Opc_situacao.Value = IIF(NVL(cursor_4c_ProdInfo.Situas, 1) = 2, 2, 1)
1952: 
1953:                 loc_oPagina.txt_4c_Ifor.Value = ALLTRIM(TratarNulo(cursor_4c_ProdInfo.ifors, "C"))
1954:                 loc_oPagina.txt_4c_Dfor.Value = ALLTRIM(TratarNulo(cursor_4c_ProdInfo.rclis, "C"))

*-- Linhas 2019 a 2053:
2019:                     USE IN cursor_4c_Max
2020:                 ENDIF
2021:                 SET NULL ON
2022:                 CREATE CURSOR cursor_4c_Max (cidchaves C(20), emps C(3), qmaxs N(7,2), ;
2023:                     codtams C(4), codcores C(4), deptos C(10), ordems C(1))
2024:                 SET NULL OFF
2025:                 loc_lResultado = .T.
2026:             ENDIF
2027: 
2028:             IF loc_lResultado AND USED("cursor_4c_Max")
2029:                 loc_oGrid = loc_oPagina.grd_4c_Gradei
2030: 
2031:                 *-- RecordSource e ControlSources FORA de WITH (Problema 36)
2032:                 loc_oGrid.ColumnCount = 5
2033:                 loc_oGrid.RecordSource               = "cursor_4c_Max"
2034:                 loc_oGrid.Column1.ControlSource      = "cursor_4c_Max.emps"
2035:                 loc_oGrid.Column2.ControlSource      = "cursor_4c_Max.qmaxs"
2036:                 loc_oGrid.Column3.ControlSource      = "cursor_4c_Max.codtams"
2037:                 loc_oGrid.Column4.ControlSource      = "cursor_4c_Max.codcores"
2038:                 loc_oGrid.Column5.ControlSource      = "cursor_4c_Max.deptos"
2039: 
2040:                 *-- Headers OBRIGATORIO re-setar apos RecordSource (VFP9 reseta)
2041:                 loc_oGrid.Column1.Header1.Caption = "Emp"
2042:                 loc_oGrid.Column2.Header1.Caption = "Qtde. M" + CHR(225) + "xima"
2043:                 loc_oGrid.Column3.Header1.Caption = "Tamanho"
2044:                 loc_oGrid.Column4.Header1.Caption = "Cor"
2045:                 loc_oGrid.Column5.Header1.Caption = "Departamento"
2046: 
2047:                 GO TOP IN cursor_4c_Max
2048:                 loc_oGrid.Refresh()
2049: 
2050:                 IF RECCOUNT("cursor_4c_Max") = 0
2051:                     THIS.GradeINovaLinha()
2052:                 ENDIF
2053:             ENDIF

*-- Linhas 2075 a 2131:
2075:             loc_cEmps = IIF(!EMPTY(ALLTRIM(go_4c_Sistema.cCodEmpresa)), ;
2076:                 PADR(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3), SPACE(3))
2077: 
2078:             INSERT INTO cursor_4c_Max ;
2079:                 (cidchaves, emps, qmaxs, codtams, codcores, deptos, ordems) ;
2080:                 VALUES (SPACE(20), loc_cEmps, 0, SPACE(4), SPACE(4), SPACE(10), SPACE(1))
2081: 
2082:             GO BOTTOM IN cursor_4c_Max
2083:             THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.Refresh()
2084:             THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.SetFocus()
2085:             THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.DoScroll(2)
2086:         CATCH TO loc_oErro
2087:             MsgErro("Erro em GradeINovaLinha: " + loc_oErro.Message, "Erro")
2088:         ENDTRY
2089:     ENDPROC
2090: 
2091:     *--------------------------------------------------------------------------
2092:     * GradeIAfterRowColChange - Ajusta colunas de variacao; adiciona linha ao final
2093:     *--------------------------------------------------------------------------
2094:     PROCEDURE GradeIAfterRowColChange(par_nColIndex)
2095:         TRY
2096:             THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.Column3.ReadOnly = !THIS.this_lTemTam
2097:             THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.Column4.ReadOnly = !THIS.this_lTemCor
2098: 
2099:             IF USED("cursor_4c_Max") AND INLIST(THIS.this_cPCEscolha, "INSERIR", "ALTERAR")
2100:                 SELECT cursor_4c_Max
2101:                 IF EOF()
2102:                     THIS.GradeINovaLinha()
2103:                 ENDIF
2104:             ENDIF
2105:         CATCH TO loc_oErro
2106:             MsgErro("Erro em GradeIAfterRowColChange: " + loc_oErro.Message, "Erro")
2107:         ENDTRY
2108:     ENDPROC
2109: 
2110:     *--------------------------------------------------------------------------
2111:     * QmaxsLostFocus - Valida quantidade maxima (nao pode ser negativa)
2112:     *--------------------------------------------------------------------------
2113:     PROCEDURE QmaxsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2114:         TRY
2115:             IF USED("cursor_4c_Max") AND !EOF("cursor_4c_Max") AND !BOF("cursor_4c_Max")
2116:                 SELECT cursor_4c_Max
2117:                 IF NVL(cursor_4c_Max.qmaxs, 0) < 0
2118:                     REPLACE cursor_4c_Max.qmaxs WITH 0
2119:                 ENDIF
2120:             ENDIF
2121:         CATCH TO loc_oErro
2122:             MsgErro("Erro em QmaxsLostFocus: " + loc_oErro.Message, "Erro")
2123:         ENDTRY
2124:     ENDPROC
2125: 
2126:     *--------------------------------------------------------------------------
2127:     * TamKeyPress - F4 abre lookup SigCdTam para coluna de tamanho
2128:     *--------------------------------------------------------------------------
2129:     PROCEDURE TamKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2130:         IF !INLIST(par_nKeyCode, 13, 9, 115)
2131:             RETURN

*-- Linhas 2159 a 2177:
2159: 
2160:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTam")
2161:                     IF USED("cursor_4c_Max") AND !EOF("cursor_4c_Max") AND !BOF("cursor_4c_Max")
2162:                         SELECT cursor_4c_Max
2163:                         REPLACE codtams WITH PADR(ALLTRIM(cursor_4c_BuscaTam.ctams), 4)
2164:                     ENDIF
2165:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.Refresh()
2166:                 ENDIF
2167: 
2168:                 loc_oBusca.Release()
2169:             ENDIF
2170: 
2171:             IF USED("cursor_4c_BuscaTam")
2172:                 USE IN cursor_4c_BuscaTam
2173:             ENDIF
2174:         CATCH TO loc_oErro
2175:             MsgErro("Erro ao buscar tamanho: " + loc_oErro.Message, "Erro")
2176:         ENDTRY
2177:     ENDPROC

*-- Linhas 2212 a 2230:
2212: 
2213:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCor")
2214:                     IF USED("cursor_4c_Max") AND !EOF("cursor_4c_Max") AND !BOF("cursor_4c_Max")
2215:                         SELECT cursor_4c_Max
2216:                         REPLACE codcores WITH PADR(ALLTRIM(cursor_4c_BuscaCor.ccors), 4)
2217:                     ENDIF
2218:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.Refresh()
2219:                 ENDIF
2220: 
2221:                 loc_oBusca.Release()
2222:             ENDIF
2223: 
2224:             IF USED("cursor_4c_BuscaCor")
2225:                 USE IN cursor_4c_BuscaCor
2226:             ENDIF
2227:         CATCH TO loc_oErro
2228:             MsgErro("Erro ao buscar cor: " + loc_oErro.Message, "Erro")
2229:         ENDTRY
2230:     ENDPROC

*-- Linhas 2265 a 2283:
2265: 
2266:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDpt")
2267:                     IF USED("cursor_4c_Max") AND !EOF("cursor_4c_Max") AND !BOF("cursor_4c_Max")
2268:                         SELECT cursor_4c_Max
2269:                         REPLACE deptos WITH PADR(ALLTRIM(cursor_4c_BuscaDpt.codigos), 10)
2270:                     ENDIF
2271:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.Refresh()
2272:                 ENDIF
2273: 
2274:                 loc_oBusca.Release()
2275:             ENDIF
2276: 
2277:             IF USED("cursor_4c_BuscaDpt")
2278:                 USE IN cursor_4c_BuscaDpt
2279:             ENDIF
2280:         CATCH TO loc_oErro
2281:             MsgErro("Erro ao buscar departamento: " + loc_oErro.Message, "Erro")
2282:         ENDTRY
2283:     ENDPROC

*-- Linhas 2312 a 2343:
2312:                 RETURN
2313:             ENDIF
2314: 
2315:             SELECT cursor_4c_Max
2316:             IF !EOF() AND !BOF()
2317:                 loc_cEmps = ALLTRIM(TratarNulo(cursor_4c_Max.emps, "C"))
2318:             ENDIF
2319: 
2320:             IF EMPTY(loc_cEmps)
2321:                 loc_cEmps = ALLTRIM(go_4c_Sistema.cCodEmpresa)
2322:             ENDIF
2323: 
2324:             SELECT cursor_4c_Max
2325:             GO TOP
2326:             SCAN
2327:                 IF ALLTRIM(cursor_4c_Max.emps) = loc_cEmps
2328:                     DELETE
2329:                 ENDIF
2330:             ENDSCAN
2331:             PACK
2332: 
2333:             IF RECCOUNT("cursor_4c_Max") = 0
2334:                 THIS.GradeINovaLinha()
2335:             ENDIF
2336: 
2337:             THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.Refresh()
2338:         CATCH TO loc_oErro
2339:             MsgErro("Erro em BtnExcluirGradeClick: " + loc_oErro.Message, "Erro")
2340:         ENDTRY
2341:     ENDPROC
2342: 
2343:     *--------------------------------------------------------------------------


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
                    " p.reffs, p.situas, p.sgrus" + ;
                    " FROM SigCdPro p" + ;
                    " LEFT JOIN SigCdGrp g ON g.cgrus = p.cgrus" + ;
                    " ORDER BY p.cpros"
            ELSE
                loc_cSQL = "SELECT p.cpros, p.dpros, p.cgrus, g.dgrus, p.ifors," + ;
                    " p.reffs, p.situas, p.sgrus" + ;
                    " FROM SigCdPro p" + ;
                    " LEFT JOIN SigCdGrp g ON g.cgrus = p.cgrus" + ;
                    " WHERE p.cpros LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                    " OR p.ifors LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
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
            IF USED("cursor_4c_CopiaTemp")
                USE IN cursor_4c_CopiaTemp
            ENDIF

            loc_cSQL = "SELECT o.cpros AS cpros, o.emps AS emps, o.qmaxs AS qmaxs," + ;
                " o.codtams AS codtams, o.codcores AS codcores, o.deptos AS deptos," + ;
                " CASE WHEN d.cidchaves IS NOT NULL THEN 1 ELSE 0 END AS existes," + ;
                " CAST(0 AS INT) AS marcas" + ;
                " FROM SigCdMax o" + ;
                " LEFT JOIN SigCdMax d ON d.cpros = o.cpros" + ;
                " AND d.emps = " + LEFT(EscaparSQL(par_cEmpDs), 7) + ;
                " AND d.codtams = o.codtams AND d.codcores = o.codcores" + ;
                " WHERE o.emps = " + LEFT(EscaparSQL(par_cEmpOs), 7) + ;
                IIF(!EMPTY(ALLTRIM(par_cCPros)), " AND o.cpros = " + EscaparSQL(par_cCPros), "") + ;
                " ORDER BY o.codtams, o.codcores, o.deptos"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CopiaTemp")
            IF loc_nResult < 0
                MsgErro("Erro ao carregar c" + CHR(243) + "pia:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                *-- Criar cursor local editavel (SQLEXEC cria cursor somente leitura)
                *-- Necessario para permitir REPLACE ALL marcas no form
                SET NULL ON
                CREATE CURSOR cursor_4c_Copia (cpros C(14), emps C(3), qmaxs N(7,2), ;
                    codtams C(4), codcores C(4), deptos C(10), existes N(1,0), marcas N(1,0))
                SET NULL OFF

                IF USED("cursor_4c_CopiaTemp") AND RECCOUNT("cursor_4c_CopiaTemp") > 0
                    APPEND FROM DBF("cursor_4c_CopiaTemp")
                ENDIF

                IF USED("cursor_4c_CopiaTemp")
                    USE IN cursor_4c_CopiaTemp
                ENDIF

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

