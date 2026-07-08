# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CIDCHAVES, COLETORS, DOPES, DATARCS, GRUPOS, CONTAS, NUMES, EMPDOPNUMS, LCCONTA, EMPS, NOPERS, TIPOS, JOBS, REALPREVS, IMPS, OPERS, 0, VALPAGS, VENCS, I, PEANTVALUE, CODIGOS, DATAS, PAGOS, CONTAPGS

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
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  ControlSource = ""
lcQuery = [Select c.Grupos, c.Contas, d.RClis, c.Datas, c.Saldos ] + ;
			[From SigMvCcr c, SigCdCli d ] + ;
		  [Select Max(b.cIdChaves) as cIdChaves ] + ;
		    [From SigCdGcr a, SigMvCcr b ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalSaldos]) < 1)
Select LocalSaldos
	lcQuery = [Select a.Emps, a.Numes, a.EmpDopNums, a.DataRcs, a.Dopes from SigCdPgr a ] + ;
				[ Inner Join SigCdPgc b on b.EmpDopNums = a.EmpDopNums ] + ;
	lcQuery = [Select Emps, Numes, EmpDopNums, DataRcs, Dopes from SigCdPgr where Dopes = ']+lcDopes+[' and Numes = ]+Str(lnCodOper,6)
If( ThisForm.poDataMgr.SQLExecute(lcQuery,[crDados1]) < 1 )
=Seek(_Empr,[crSigCdEmp],[cEmps])
Insert into crCabecalho(Empresa,Titulo,Periodo) Values (lcEmpresa,lcTitulo,lcPeriodo)
Select crDados1
	lcQuery = [Select a.Acertos, a.Contas, a.Datas, a.Hists, a.Moedas, a.Nopers, a.Opers, a.Tipos, a.Valos, a.Vencs, a.Empos, b.RClis from SigCdPit a ] + ;
				[Inner Join SigCdCli b on b.Iclis = a.Contas ] + ;
	If( ThisForm.poDataMgr.SQLExecute(lcQuery,[crTmpPrIt]) < 1 )
	lcQuery = [Select Valos, VPags, Emps, Dopes, Numes, FPags, MoeFpgs, Vencs from SigMvPar where EmpDopNums = ']+lcEDN+[']
	If( ThisForm.poDataMgr.SQLExecute(lcQuery,[crParcPag]) < 1 )
	Select crParcPag	
	Select crTmpPrIt
		lcQuery = [Select Valors, ValPags, Moedas, Hists, Hist2s, Vencs, Titulos from SigMvCcr where Emps = ']+crTmpPrIt.EmpOs+[' and Nopers = ]+Str(crTmpPrIt.Nopers,9)		
		If( ThisForm.poDataMgr.SQLExecute(lcQuery,[crTmpMccr]) < 1 )
		lcQuery = [Select Valos, VPags, Emps, Dopes, Numes, FPags, MoeFpgs, Vencs from SigMvPar where Emps = ']+crTmpPrIt.EmpOs+[' and Nopers = ]+Str(crTmpPrIt.Nopers,9)
		If( ThisForm.poDataMgr.SQLExecute(lcQuery,[crTmpPar]) < 1 )
		Select crTmpPar	
		lcQuery = [Select Valos, FPags from SigCdPbx where Nopers = ]+Str(crTmpPrIt.Nopers,9) + [ And EmpDopNums = ']+crDados1.EmpDopNums+[']				
		If( ThisForm.poDataMgr.SQLExecute(lcQuery,[crTmpPrBx]) < 1 )
		Select crTmpPrBx
				Select crTmpMccr
		Select crTmpPrBx
		Insert into crDados(Emps, Numes, Datas, Titulos, Vencs, Debito, Credito, Acerto, Moeda, Hists, Hist2s, CondPag, VlrPago, nTotPago) Values(;
Select crDados
=Seek(_Empr,[crSigCdEmp],[cEmps])
Insert Into crCabecalho (Empresa, Titulo, SubTitulo, Periodo, SaldoIni, SaldosCab1, SaldosCab2) ;
lcQuery = [Select a.Emps, a.DopCs, a.Nopers, a.EmpDopNums, a.Contas, a.Titulos, a.Vencs, a.Opers, a.Hists, a.EspecieNFs, ] + ;
			[From SigMvCcr a Inner Join SigCdCli b on b.iClis = a.Contas ] + ;
If( ThisForm.poDataMgr.SQLExecute(lcQuery,[crDados1]) < 1 )
Select * ;
  From crSigOpOpe ;
Select crPrevs
	lcQuery = [Select a.Emps, a.DopCs, a.Nopers, a.EmpDopNums, a.Contas, a.Titulos, a.Vencs, a.Opers, a.Hists, a.EspecieNFs, ] + ;
				[From SigMvCpv a Inner Join SigCdCli b on b.iClis = a.Contas ] + ;
	If( ThisForm.poDataMgr.SQLExecute(lcQuery,[LocalPrev]) < 1 )
	Select a.* ;
	  From crDados1 a ;
	 Inner join crSigCdEmp b on b.cEmps = a.Emps ;
	 Inner join crSigOpOpe c on c.Dopes = a.DopCs ;
	 Inner Join crSigCdClc d on d.Codigos = a.Codigos ;
	Select e.* ;
	  From LocalPrev e ;
	 Inner join crSigCdEmp f on f.cEmps = e.Emps ;
	 Inner join crSigOpOpe g on g.Dopes = e.DopCs ;
	 Inner Join crSigCdClc h on h.Codigos = e.Codigos ;
	Select a.* ;
	  From crDados1 a ;
	 Inner join crSigCdEmp b on b.cEmps = a.Emps ;
	 Inner join crSigOpOpe c on c.Dopes = a.DopCs ;
	 Inner Join crSigCdClc d on d.Codigos = a.Codigos ;
Select * from crDados2 where 0=1 into cursor crDados readwrite
Select crDados2 
		lcQry = [Select vPags from SigMvPar where empdopnums = ']+crDados2.EmpDopNums+[' and Vencs = ?ldVenc]
		ThisForm.poDataMgr.SQLExecute(lcQry,[crTmpPar])
			Select crDados2
			Insert into crDados from MemVar
		Select crDados2
		Insert into crDados from MemVar
		Select crDados
			= Seek(crDados.DopCs,[crSigOpOpe],[Dopes])
		Select crRel
		Select crDados
			= Seek(crDados.DopCs,[crSigOpOpe],[Dopes])
			If not Seek(crDados.Contas,[crRel],[Conta])
			If not Seek(crDados.Emps,[crEmps],[Emps])
				Insert into crEmps(Coluna,Emps) Values (lnColuna,crDados.Emps)
		Select crRel
		Select [] as GrpSaldos, Ttod(Vencs) as Vencs, Titulos, Hists, EspecieNFs, Moedas, Valors, Opers, ;
		  From crDados ;
		Update crProcessar Set SaldoDia = 0, SaldoTot = 0, Debitos = 0, Creditos = 0
		Select crProcessar
		Select crProcessar
	Select crSigCdMoe
	Select crSigCdCot
	If ThisForm.podatamgr.SQLExecute([select 1 as Imps, cemps, razas from SigCdEmp Order by cEmps],'crSigCdEmp') < 1 Then
	Select crSigCdEmp
		.DeleteMark        = .f.
		.Column1.ControlSource   = 'crSigCdEmp.Imps'
		.Column2.ControlSource   = 'crSigCdEmp.cEmps'
		.Column3.ControlSource   = 'crSigCdEmp.Razas'
	If ThisForm.podatamgr.SQLExecute([select 1 as Imps, Dopes, Opers, RealPrevs From SigOpOpe Order by Dopes],'crSigOpOpe') < 1 Then
	Insert into crSigOpOpe(Imps,Dopes,Opers) Values(0,Space(20),[C])
		.DeleteMark        = .f.
		.Column1.ControlSource   = 'crSigOpOpe.Imps'
		.Column2.ControlSource   = 'crSigOpOpe.Dopes'
	If ThisForm.podatamgr.SQLExecute([select 1 as Imps, Codigos, Descs from SigCdClc Order by Codigos],'crSigCdClc') < 1 Then
	Insert into crSigCdClc(Imps, Codigos, Descs) Values(1,[          ],[EM BRANCO])
		.DeleteMark        = .f.
		.Column1.ControlSource   = 'crSigCdClc.Imps'
		.Column2.ControlSource   = 'crSigCdClc.Codigos'
		.Column3.ControlSource   = 'crSigCdClc.Descs'
	Select crDados
	Select grpsaldos,vencs,titulos,hists,especienfs,valors,opers,debitos,creditos,saldodia,saldotot,moedas From crProcessar ;
	Select crDados3
Select crSigCdClc
	Select crSigCdClc
Select crSigCdEmp
	Select crSigCdEmp

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreapp.prg) - TRECHOS RELEVANTES PARA PASS SQL (2220 linhas total):

*-- Linhas 980 a 1062:
980:         TRY
981:             *-- Cotacoes de moeda (indexado para BuscarCambio no BO)
982:             IF loc_lContinuar
983:                 loc_nRes = SQLEXEC(gnConnHandle, ;
984:                     "SELECT CMoes, Datas, Valos FROM SigCdCot ORDER BY CMoes, Datas", ;
985:                     "cursor_4c_SigCdCot")
986:                 IF loc_nRes > 0
987:                     SELECT cursor_4c_SigCdCot
988:                     INDEX ON CMoes + DTOS(Datas) TAG CMoeData
989:                 ENDIF
990:             ENDIF
991: 
992:             *-- Empresas
993:             IF loc_lContinuar
994:                 loc_nRes = SQLEXEC(gnConnHandle, ;
995:                     "SELECT 1 as Imps, cEmps, Razas FROM SigCdEmp ORDER BY cEmps", ;
996:                     "cursor_4c_SigCdEmp")
997:                 IF loc_nRes < 1
998:                     MsgErro("Falha na conex" + CHR(227) + "o (SigCdEmp)", "Erro")
999:                     loc_lContinuar = .F.
1000:                 ELSE
1001:                     SELECT cursor_4c_SigCdEmp
1002:                     INDEX ON cEmps TAG cEmps
1003:                 ENDIF
1004:             ENDIF
1005: 
1006:             *-- Operacoes de Titulo (inclui linha em branco para exibir opcao "nenhuma")
1007:             IF loc_lContinuar
1008:                 loc_nRes = SQLEXEC(gnConnHandle, ;
1009:                     "SELECT 1 as Imps, Dopes, Opers, RealPrevs FROM SigOpOpe ORDER BY Dopes", ;
1010:                     "cursor_4c_SigOpOpe")
1011:                 IF loc_nRes < 1
1012:                     MsgErro("Falha na conex" + CHR(227) + "o (SigOpOpe)", "Erro")
1013:                     loc_lContinuar = .F.
1014:                 ELSE
1015:                     INSERT INTO cursor_4c_SigOpOpe (Imps, Dopes, Opers) ;
1016:                         VALUES (0, SPACE(20), "C")
1017:                     GO TOP IN cursor_4c_SigOpOpe
1018:                     SELECT cursor_4c_SigOpOpe
1019:                     INDEX ON Dopes TAG Dopes
1020:                 ENDIF
1021:             ENDIF
1022: 
1023:             *-- Classificacoes (SigCdClc, inclui linha EM BRANCO marcada)
1024:             IF loc_lContinuar
1025:                 loc_nRes = SQLEXEC(gnConnHandle, ;
1026:                     "SELECT 1 as Imps, Codigos, Descs FROM SigCdClc ORDER BY Codigos", ;
1027:                     "cursor_4c_SigCdClc")
1028:                 IF loc_nRes < 1
1029:                     MsgErro("Falha na conex" + CHR(227) + "o (SigCdClc)", "Erro")
1030:                     loc_lContinuar = .F.
1031:                 ELSE
1032:                     INSERT INTO cursor_4c_SigCdClc (Imps, Codigos, Descs) ;
1033:                         VALUES (1, SPACE(10), "EM BRANCO")
1034:                     GO TOP IN cursor_4c_SigCdClc
1035:                 ENDIF
1036:             ENDIF
1037: 
1038:             *-- Moeda padrao (SigCdPam)
1039:             IF loc_lContinuar
1040:                 loc_nRes = SQLEXEC(gnConnHandle, "SELECT Moedaps FROM SigCdPam", ;
1041:                     "cursor_4c_SigCdPam")
1042:                 IF loc_nRes > 0 AND !EOF("cursor_4c_SigCdPam") AND ;
1043:                    !EMPTY(cursor_4c_SigCdPam.Moedaps)
1044:                     loc_cMoeda = ALLTRIM(cursor_4c_SigCdPam.Moedaps)
1045:                     THIS.pgf_4c_Paginas.Page1.txt_4c__cd_moeda.Value = loc_cMoeda
1046:                     loc_nRes = SQLEXEC(gnConnHandle, ;
1047:                         "SELECT DMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cMoeda), ;
1048:                         "cursor_4c_MoeDesc")
1049:                     IF loc_nRes > 0 AND !EOF("cursor_4c_MoeDesc")
1050:                         THIS.pgf_4c_Paginas.Page1.txt_4c__ds_moeda.Value = ;
1051:                             ALLTRIM(cursor_4c_MoeDesc.DMoes)
1052:                     ENDIF
1053:                     IF USED("cursor_4c_MoeDesc")
1054:                         USE IN cursor_4c_MoeDesc
1055:                     ENDIF
1056:                     IF VARTYPE(THIS.this_oRelatorio) = "O"
1057:                         LOCAL loc_nCotacao
1058:                         loc_nCotacao = THIS.this_oRelatorio.BuscarCambio(loc_cMoeda)
1059:                         THIS.this_oRelatorio.this_nVlCotacao = ;
1060:                             IIF(loc_nCotacao = 0, 1, loc_nCotacao)
1061:                     ENDIF
1062:                 ENDIF

*-- Linhas 1131 a 1164:
1131:             .FontSize          = 8
1132:             .AllowHeaderSizing = .F.
1133:             .AllowRowSizing    = .F.
1134:             .DeleteMark        = .F.
1135:             .RecordMark        = .F.
1136:             .RowHeight         = 17
1137:             .ScrollBars        = 2
1138:             .GridLineColor     = RGB(238, 238, 238)
1139:             .ReadOnly          = .F.
1140:             .RecordSource      = "cursor_4c_SigCdEmp"
1141:             .Visible           = .T.
1142:         ENDWITH
1143:         loc_oGrd.Column1.ControlSource = "cursor_4c_SigCdEmp.Imps"
1144:         loc_oGrd.Column2.ControlSource = "cursor_4c_SigCdEmp.cEmps"
1145:         loc_oGrd.Column3.ControlSource = "cursor_4c_SigCdEmp.Razas"
1146: 
1147:         WITH loc_oGrd.Column1
1148:             .Width         = 17
1149:             .ControlSource = "cursor_4c_SigCdEmp.Imps"
1150:             .FontName      = "Courier New"
1151:             .Movable       = .F.
1152:             .Resizable     = .F.
1153:             .ReadOnly      = .F.
1154:             .Sparse        = .F.
1155:         ENDWITH
1156:         loc_oGrd.Column1.Header1.Caption  = ""
1157:         loc_oGrd.Column1.Header1.ForeColor = RGB(90, 90, 90)
1158:         loc_oGrd.Column1.AddObject("Check1", "CheckBox")
1159:         WITH loc_oGrd.Column1.Check1
1160:             .Alignment = 0
1161:             .Caption   = ""
1162:             .AutoSize  = .T.
1163:             .BackStyle = 0
1164:             .Visible   = .T.

*-- Linhas 1171 a 1202:
1171: 
1172:         WITH loc_oGrd.Column2
1173:             .Width         = 27
1174:             .ControlSource = "cursor_4c_SigCdEmp.cEmps"
1175:             .FontName      = "Courier New"
1176:             .Movable       = .F.
1177:             .Resizable     = .F.
1178:             .ReadOnly      = .T.
1179:         ENDWITH
1180:         loc_oGrd.Column2.Header1.Caption   = "Emp."
1181:         loc_oGrd.Column2.Header1.Alignment = 2
1182:         loc_oGrd.Column2.Header1.ForeColor = RGB(90, 90, 90)
1183:         loc_oGrd.Column2.Text1.ForeColor   = RGB(0, 0, 0)
1184: 
1185:         WITH loc_oGrd.Column3
1186:             .Width         = 263
1187:             .ControlSource = "cursor_4c_SigCdEmp.Razas"
1188:             .FontName      = "Courier New"
1189:             .Movable       = .F.
1190:             .Resizable     = .F.
1191:             .ReadOnly      = .T.
1192:         ENDWITH
1193:         loc_oGrd.Column3.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1194:         loc_oGrd.Column3.Header1.Alignment = 2
1195:         loc_oGrd.Column3.Header1.ForeColor = RGB(90, 90, 90)
1196:         loc_oGrd.Column3.Text1.ForeColor   = RGB(0, 0, 0)
1197: 
1198:         *======================================================================
1199:         *-- GRID OPERACOES DE TITULO
1200:         *======================================================================
1201:         loc_oPg1.AddObject("lbl_4c_Label4", "Label")
1202:         WITH loc_oPg1.lbl_4c_Label4

*-- Linhas 1240 a 1273:
1240:             .FontSize          = 8
1241:             .AllowHeaderSizing = .F.
1242:             .AllowRowSizing    = .F.
1243:             .DeleteMark        = .F.
1244:             .RecordMark        = .F.
1245:             .HeaderHeight      = 17
1246:             .RowHeight         = 17
1247:             .ScrollBars        = 2
1248:             .GridLineColor     = RGB(238, 238, 238)
1249:             .ReadOnly          = .F.
1250:             .RecordSource      = "cursor_4c_SigOpOpe"
1251:             .Visible           = .T.
1252:         ENDWITH
1253:         loc_oGrd.Column1.ControlSource = "cursor_4c_SigOpOpe.Imps"
1254:         loc_oGrd.Column2.ControlSource = "cursor_4c_SigOpOpe.Dopes"
1255: 
1256:         WITH loc_oGrd.Column1
1257:             .Width         = 17
1258:             .ControlSource = "cursor_4c_SigOpOpe.Imps"
1259:             .Alignment     = 0
1260:             .FontName      = "Courier New"
1261:             .Movable       = .F.
1262:             .Resizable     = .F.
1263:             .ReadOnly      = .F.
1264:             .Sparse        = .F.
1265:             .Enabled       = .T.
1266:         ENDWITH
1267:         loc_oGrd.Column1.Header1.Caption  = ""
1268:         loc_oGrd.Column1.Header1.ForeColor = RGB(90, 90, 90)
1269:         loc_oGrd.Column1.AddObject("check12", "CheckBox")
1270:         WITH loc_oGrd.Column1.check12
1271:             .Alignment = 0
1272:             .Caption   = ""
1273:             .AutoSize  = .T.

*-- Linhas 1283 a 1301:
1283: 
1284:         WITH loc_oGrd.Column2
1285:             .Width         = 283
1286:             .ControlSource = "cursor_4c_SigOpOpe.Dopes"
1287:             .FontName      = "Courier New"
1288:             .Movable       = .F.
1289:             .Resizable     = .F.
1290:             .ReadOnly      = .T.
1291:             .Enabled       = .T.
1292:         ENDWITH
1293:         loc_oGrd.Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1294:         loc_oGrd.Column2.Header1.Alignment = 2
1295:         loc_oGrd.Column2.Header1.ForeColor = RGB(90, 90, 90)
1296:         loc_oGrd.Column2.Text1.ForeColor   = RGB(0, 0, 0)
1297:         loc_oGrd.Column2.Text1.BackColor   = RGB(255, 255, 255)
1298:         loc_oGrd.Column2.Text1.ReadOnly    = .T.
1299: 
1300:         *======================================================================
1301:         *-- GRID CLASSIFICACOES

*-- Linhas 1342 a 1375:
1342:             .FontSize          = 8
1343:             .AllowHeaderSizing = .F.
1344:             .AllowRowSizing    = .F.
1345:             .DeleteMark        = .F.
1346:             .RecordMark        = .F.
1347:             .RowHeight         = 17
1348:             .ScrollBars        = 2
1349:             .GridLineColor     = RGB(238, 238, 238)
1350:             .ReadOnly          = .F.
1351:             .RecordSource      = "cursor_4c_SigCdClc"
1352:             .Visible           = .T.
1353:         ENDWITH
1354:         loc_oGrd.Column1.ControlSource = "cursor_4c_SigCdClc.Imps"
1355:         loc_oGrd.Column2.ControlSource = "cursor_4c_SigCdClc.Codigos"
1356:         loc_oGrd.Column3.ControlSource = "cursor_4c_SigCdClc.Descs"
1357: 
1358:         WITH loc_oGrd.Column1
1359:             .Width         = 19
1360:             .ControlSource = "cursor_4c_SigCdClc.Imps"
1361:             .FontName      = "Courier New"
1362:             .Movable       = .F.
1363:             .Resizable     = .F.
1364:             .ReadOnly      = .F.
1365:             .Sparse        = .F.
1366:         ENDWITH
1367:         loc_oGrd.Column1.Header1.Caption  = ""
1368:         loc_oGrd.Column1.Header1.ForeColor = RGB(90, 90, 90)
1369:         loc_oGrd.Column1.AddObject("check13", "CheckBox")
1370:         WITH loc_oGrd.Column1.check13
1371:             .Alignment = 0
1372:             .Caption   = ""
1373:             .AutoSize  = .T.
1374:             .BackStyle = 0
1375:             .Visible   = .T.

*-- Linhas 1382 a 1414:
1382: 
1383:         WITH loc_oGrd.Column2
1384:             .Width         = 80
1385:             .ControlSource = "cursor_4c_SigCdClc.Codigos"
1386:             .FontName      = "Courier New"
1387:             .Movable       = .F.
1388:             .Resizable     = .F.
1389:             .ReadOnly      = .T.
1390:         ENDWITH
1391:         loc_oGrd.Column2.Header1.Caption   = "C" + CHR(243) + "digo"
1392:         loc_oGrd.Column2.Header1.Alignment = 2
1393:         loc_oGrd.Column2.Header1.ForeColor = RGB(90, 90, 90)
1394:         loc_oGrd.Column2.Text1.ForeColor   = RGB(0, 0, 0)
1395:         loc_oGrd.Column2.Text1.ReadOnly    = .F.
1396: 
1397:         WITH loc_oGrd.Column3
1398:             .Width         = 452
1399:             .ControlSource = "cursor_4c_SigCdClc.Descs"
1400:             .FontName      = "Courier New"
1401:             .Movable       = .F.
1402:             .Resizable     = .F.
1403:             .ReadOnly      = .T.
1404:         ENDWITH
1405:         loc_oGrd.Column3.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1406:         loc_oGrd.Column3.Header1.Alignment = 2
1407:         loc_oGrd.Column3.Header1.ForeColor = RGB(90, 90, 90)
1408:         loc_oGrd.Column3.Text1.ForeColor   = RGB(0, 0, 0)
1409:         loc_oGrd.Column3.Text1.BackColor   = RGB(255, 255, 255)
1410:         loc_oGrd.Column3.Text1.ReadOnly    = .T.
1411: 
1412:     ENDPROC
1413: 
1414:     *--------------------------------------------------------------------------

*-- Linhas 1730 a 1749:
1730:                 THIS.pgf_4c_Paginas.Page1.txt_4c__ds_moeda.Value = ""
1731:                 THIS.this_oRelatorio.this_nVlCotacao = 1
1732:             ELSE
1733:                 loc_nRes = SQLEXEC(gnConnHandle, ;
1734:                     "SELECT CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cValor), ;
1735:                     "cursor_4c_ValidaMoeda")
1736:                 IF loc_nRes > 0 AND !EOF("cursor_4c_ValidaMoeda")
1737:                     THIS.pgf_4c_Paginas.Page1.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_ValidaMoeda.CMoes)
1738:                     THIS.pgf_4c_Paginas.Page1.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_ValidaMoeda.DMoes)
1739:                     loc_nCotacao = THIS.this_oRelatorio.BuscarCambio(loc_cValor)
1740:                     THIS.this_oRelatorio.this_nVlCotacao = IIF(loc_nCotacao = 0, 1, loc_nCotacao)
1741:                 ELSE
1742:                     THIS.AbrirBuscaMoeda()
1743:                 ENDIF
1744:                 IF USED("cursor_4c_ValidaMoeda")
1745:                     USE IN cursor_4c_ValidaMoeda
1746:                 ENDIF
1747:             ENDIF
1748:         ENDIF
1749:     ENDPROC

*-- Linhas 1823 a 1842:
1823:             IF EMPTY(loc_cValor)
1824:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupo.Value = ""
1825:             ELSE
1826:                 loc_nRes = SQLEXEC(gnConnHandle, ;
1827:                     "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cValor), ;
1828:                     "cursor_4c_ValidaGrupo")
1829:                 IF loc_nRes > 0 AND !EOF("cursor_4c_ValidaGrupo")
1830:                     THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_ValidaGrupo.Codigos)
1831:                     THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_ValidaGrupo.Descrs)
1832:                 ELSE
1833:                     THIS.AbrirBuscaGrupo()
1834:                 ENDIF
1835:                 IF USED("cursor_4c_ValidaGrupo")
1836:                     USE IN cursor_4c_ValidaGrupo
1837:                 ENDIF
1838:             ENDIF
1839:         ENDIF
1840:     ENDPROC
1841: 
1842:     FUNCTION DGrupoWhen()

*-- Linhas 1904 a 1927:
1904:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DConta.Value = ""
1905:             ELSE
1906:                 loc_cGrupo = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value)
1907:                 loc_cSQL   = "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + ;
1908:                     EscaparSQL(PADR(loc_cValor, 10))
1909:                 IF !EMPTY(loc_cGrupo)
1910:                     loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(loc_cGrupo)
1911:                 ENDIF
1912:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaConta")
1913:                 IF loc_nRes > 0 AND !EOF("cursor_4c_ValidaConta")
1914:                     THIS.pgf_4c_Paginas.Page1.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_ValidaConta.IClis)
1915:                     THIS.pgf_4c_Paginas.Page1.txt_4c_DConta.Value = ALLTRIM(cursor_4c_ValidaConta.RClis)
1916:                 ELSE
1917:                     THIS.AbrirBuscaConta()
1918:                 ENDIF
1919:                 IF USED("cursor_4c_ValidaConta")
1920:                     USE IN cursor_4c_ValidaConta
1921:                 ENDIF
1922:             ENDIF
1923:         ENDIF
1924:     ENDPROC
1925: 
1926:     FUNCTION DContaWhen()
1927:         RETURN EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_Conta.Value)

*-- Linhas 1987 a 2007:
1987:             IF EMPTY(loc_cValor)
1988:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DJobs.Value = ""
1989:             ELSE
1990:                 loc_nRes = SQLEXEC(gnConnHandle, ;
1991:                     "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + ;
1992:                     EscaparSQL(PADR(loc_cValor, 10)), ;
1993:                     "cursor_4c_ValidaJobs")
1994:                 IF loc_nRes > 0 AND !EOF("cursor_4c_ValidaJobs")
1995:                     THIS.pgf_4c_Paginas.Page1.txt_4c__Jobs.Value = ALLTRIM(cursor_4c_ValidaJobs.IClis)
1996:                     THIS.pgf_4c_Paginas.Page1.txt_4c_DJobs.Value = ALLTRIM(cursor_4c_ValidaJobs.RClis)
1997:                 ELSE
1998:                     THIS.AbrirBuscaJobs()
1999:                 ENDIF
2000:                 IF USED("cursor_4c_ValidaJobs")
2001:                     USE IN cursor_4c_ValidaJobs
2002:                 ENDIF
2003:             ENDIF
2004:         ENDIF
2005:     ENDPROC
2006: 
2007:     FUNCTION DJobsWhen()

