# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-ASPAS] Linha 282: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "where a.Dopes = '" + loc_cDopes + "'" + ;
- [SQL-ASPAS] Linha 289: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "from SigCdPgr where Dopes = '" + loc_cDopes + "'" + ;
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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreapp.prg) - TRECHOS RELEVANTES PARA PASS SQL (2212 linhas total):

*-- Linhas 268 a 305:
268: 
269:     *--------------------------------------------------------------------------
270:     * ConfigurarFiltros - Adiciona todos os controles de filtro em Page1
271:     * Coordenadas: Top_page1 = Top_original - 85
272:     *--------------------------------------------------------------------------
273:     PROTECTED PROCEDURE ConfigurarFiltros()
274:         LOCAL loc_oPg1
275:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
276: 
277:         *-- Tipo de relatorio (Analitico/Sintetico/Fluxo de Caixa)
278:         loc_oPg1.AddObject("lbl_4c_Label2", "Label")
279:         WITH loc_oPg1.lbl_4c_Label2
280:             .Top       = 20
281:             .Left      = 64
282:             .Width     = 35
283:             .Height    = 15
284:             .Caption   = "Tipo :"
285:             .FontName  = "Tahoma"
286:             .FontSize  = 8
287:             .ForeColor = RGB(90, 90, 90)
288:             .BackStyle = 0
289:             .AutoSize  = .T.
290:             .Visible   = .T.
291:         ENDWITH
292: 
293:         loc_oPg1.AddObject("obj_4c_Opt_AnaSi", "OptionGroup")
294:         WITH loc_oPg1.obj_4c_Opt_AnaSi
295:             .Top         = 13
296:             .Left        = 92
297:             .Width       = 265
298:             .Height      = 29
299:             .ButtonCount = 3
300:             .BackStyle   = 0
301:             .BorderStyle = 0
302:             .Value       = 1
303:             .Visible     = .T.
304:             WITH .Buttons(1)
305:                 .Caption   = "Anal" + CHR(237) + "tico"

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

*-- Linhas 1131 a 1161:
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
1143: 
1144:         WITH loc_oGrd.Column1
1145:             .Width         = 17
1146:             .ControlSource = "cursor_4c_SigCdEmp.Imps"
1147:             .FontName      = "Courier New"
1148:             .Movable       = .F.
1149:             .Resizable     = .F.
1150:             .ReadOnly      = .F.
1151:             .Sparse        = .F.
1152:         ENDWITH
1153:         loc_oGrd.Column1.Header1.Caption  = ""
1154:         loc_oGrd.Column1.Header1.ForeColor = RGB(90, 90, 90)
1155:         loc_oGrd.Column1.AddObject("Check1", "CheckBox")
1156:         WITH loc_oGrd.Column1.Check1
1157:             .Alignment = 0
1158:             .Caption   = ""
1159:             .AutoSize  = .T.
1160:             .BackStyle = 0
1161:             .Visible   = .T.

*-- Linhas 1168 a 1199:
1168: 
1169:         WITH loc_oGrd.Column2
1170:             .Width         = 27
1171:             .ControlSource = "cursor_4c_SigCdEmp.cEmps"
1172:             .FontName      = "Courier New"
1173:             .Movable       = .F.
1174:             .Resizable     = .F.
1175:             .ReadOnly      = .T.
1176:         ENDWITH
1177:         loc_oGrd.Column2.Header1.Caption   = "Emp."
1178:         loc_oGrd.Column2.Header1.Alignment = 2
1179:         loc_oGrd.Column2.Header1.ForeColor = RGB(90, 90, 90)
1180:         loc_oGrd.Column2.Text1.ForeColor   = RGB(0, 0, 0)
1181: 
1182:         WITH loc_oGrd.Column3
1183:             .Width         = 263
1184:             .ControlSource = "cursor_4c_SigCdEmp.Razas"
1185:             .FontName      = "Courier New"
1186:             .Movable       = .F.
1187:             .Resizable     = .F.
1188:             .ReadOnly      = .T.
1189:         ENDWITH
1190:         loc_oGrd.Column3.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1191:         loc_oGrd.Column3.Header1.Alignment = 2
1192:         loc_oGrd.Column3.Header1.ForeColor = RGB(90, 90, 90)
1193:         loc_oGrd.Column3.Text1.ForeColor   = RGB(0, 0, 0)
1194: 
1195:         *======================================================================
1196:         *-- GRID OPERACOES DE TITULO
1197:         *======================================================================
1198:         loc_oPg1.AddObject("lbl_4c_Label4", "Label")
1199:         WITH loc_oPg1.lbl_4c_Label4

*-- Linhas 1237 a 1268:
1237:             .FontSize          = 8
1238:             .AllowHeaderSizing = .F.
1239:             .AllowRowSizing    = .F.
1240:             .DeleteMark        = .F.
1241:             .RecordMark        = .F.
1242:             .HeaderHeight      = 17
1243:             .RowHeight         = 17
1244:             .ScrollBars        = 2
1245:             .GridLineColor     = RGB(238, 238, 238)
1246:             .ReadOnly          = .F.
1247:             .RecordSource      = "cursor_4c_SigOpOpe"
1248:             .Visible           = .T.
1249:         ENDWITH
1250: 
1251:         WITH loc_oGrd.Column1
1252:             .Width         = 17
1253:             .ControlSource = "cursor_4c_SigOpOpe.Imps"
1254:             .Alignment     = 0
1255:             .FontName      = "Courier New"
1256:             .Movable       = .F.
1257:             .Resizable     = .F.
1258:             .ReadOnly      = .F.
1259:             .Sparse        = .F.
1260:             .Enabled       = .T.
1261:         ENDWITH
1262:         loc_oGrd.Column1.Header1.Caption  = ""
1263:         loc_oGrd.Column1.Header1.ForeColor = RGB(90, 90, 90)
1264:         loc_oGrd.Column1.AddObject("check12", "CheckBox")
1265:         WITH loc_oGrd.Column1.check12
1266:             .Alignment = 0
1267:             .Caption   = ""
1268:             .AutoSize  = .T.

*-- Linhas 1278 a 1296:
1278: 
1279:         WITH loc_oGrd.Column2
1280:             .Width         = 283
1281:             .ControlSource = "cursor_4c_SigOpOpe.Dopes"
1282:             .FontName      = "Courier New"
1283:             .Movable       = .F.
1284:             .Resizable     = .F.
1285:             .ReadOnly      = .T.
1286:             .Enabled       = .T.
1287:         ENDWITH
1288:         loc_oGrd.Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1289:         loc_oGrd.Column2.Header1.Alignment = 2
1290:         loc_oGrd.Column2.Header1.ForeColor = RGB(90, 90, 90)
1291:         loc_oGrd.Column2.Text1.ForeColor   = RGB(0, 0, 0)
1292:         loc_oGrd.Column2.Text1.BackColor   = RGB(255, 255, 255)
1293:         loc_oGrd.Column2.Text1.ReadOnly    = .T.
1294: 
1295:         *======================================================================
1296:         *-- GRID CLASSIFICACOES

*-- Linhas 1337 a 1367:
1337:             .FontSize          = 8
1338:             .AllowHeaderSizing = .F.
1339:             .AllowRowSizing    = .F.
1340:             .DeleteMark        = .F.
1341:             .RecordMark        = .F.
1342:             .RowHeight         = 17
1343:             .ScrollBars        = 2
1344:             .GridLineColor     = RGB(238, 238, 238)
1345:             .ReadOnly          = .F.
1346:             .RecordSource      = "cursor_4c_SigCdClc"
1347:             .Visible           = .T.
1348:         ENDWITH
1349: 
1350:         WITH loc_oGrd.Column1
1351:             .Width         = 19
1352:             .ControlSource = "cursor_4c_SigCdClc.Imps"
1353:             .FontName      = "Courier New"
1354:             .Movable       = .F.
1355:             .Resizable     = .F.
1356:             .ReadOnly      = .F.
1357:             .Sparse        = .F.
1358:         ENDWITH
1359:         loc_oGrd.Column1.Header1.Caption  = ""
1360:         loc_oGrd.Column1.Header1.ForeColor = RGB(90, 90, 90)
1361:         loc_oGrd.Column1.AddObject("check13", "CheckBox")
1362:         WITH loc_oGrd.Column1.check13
1363:             .Alignment = 0
1364:             .Caption   = ""
1365:             .AutoSize  = .T.
1366:             .BackStyle = 0
1367:             .Visible   = .T.

*-- Linhas 1374 a 1406:
1374: 
1375:         WITH loc_oGrd.Column2
1376:             .Width         = 80
1377:             .ControlSource = "cursor_4c_SigCdClc.Codigos"
1378:             .FontName      = "Courier New"
1379:             .Movable       = .F.
1380:             .Resizable     = .F.
1381:             .ReadOnly      = .T.
1382:         ENDWITH
1383:         loc_oGrd.Column2.Header1.Caption   = "C" + CHR(243) + "digo"
1384:         loc_oGrd.Column2.Header1.Alignment = 2
1385:         loc_oGrd.Column2.Header1.ForeColor = RGB(90, 90, 90)
1386:         loc_oGrd.Column2.Text1.ForeColor   = RGB(0, 0, 0)
1387:         loc_oGrd.Column2.Text1.ReadOnly    = .F.
1388: 
1389:         WITH loc_oGrd.Column3
1390:             .Width         = 452
1391:             .ControlSource = "cursor_4c_SigCdClc.Descs"
1392:             .FontName      = "Courier New"
1393:             .Movable       = .F.
1394:             .Resizable     = .F.
1395:             .ReadOnly      = .T.
1396:         ENDWITH
1397:         loc_oGrd.Column3.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1398:         loc_oGrd.Column3.Header1.Alignment = 2
1399:         loc_oGrd.Column3.Header1.ForeColor = RGB(90, 90, 90)
1400:         loc_oGrd.Column3.Text1.ForeColor   = RGB(0, 0, 0)
1401:         loc_oGrd.Column3.Text1.BackColor   = RGB(255, 255, 255)
1402:         loc_oGrd.Column3.Text1.ReadOnly    = .T.
1403: 
1404:     ENDPROC
1405: 
1406:     *--------------------------------------------------------------------------

*-- Linhas 1722 a 1741:
1722:                 THIS.pgf_4c_Paginas.Page1.txt_4c__ds_moeda.Value = ""
1723:                 THIS.this_oRelatorio.this_nVlCotacao = 1
1724:             ELSE
1725:                 loc_nRes = SQLEXEC(gnConnHandle, ;
1726:                     "SELECT CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cValor), ;
1727:                     "cursor_4c_ValidaMoeda")
1728:                 IF loc_nRes > 0 AND !EOF("cursor_4c_ValidaMoeda")
1729:                     THIS.pgf_4c_Paginas.Page1.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_ValidaMoeda.CMoes)
1730:                     THIS.pgf_4c_Paginas.Page1.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_ValidaMoeda.DMoes)
1731:                     loc_nCotacao = THIS.this_oRelatorio.BuscarCambio(loc_cValor)
1732:                     THIS.this_oRelatorio.this_nVlCotacao = IIF(loc_nCotacao = 0, 1, loc_nCotacao)
1733:                 ELSE
1734:                     THIS.AbrirBuscaMoeda()
1735:                 ENDIF
1736:                 IF USED("cursor_4c_ValidaMoeda")
1737:                     USE IN cursor_4c_ValidaMoeda
1738:                 ENDIF
1739:             ENDIF
1740:         ENDIF
1741:     ENDPROC

*-- Linhas 1815 a 1834:
1815:             IF EMPTY(loc_cValor)
1816:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupo.Value = ""
1817:             ELSE
1818:                 loc_nRes = SQLEXEC(gnConnHandle, ;
1819:                     "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cValor), ;
1820:                     "cursor_4c_ValidaGrupo")
1821:                 IF loc_nRes > 0 AND !EOF("cursor_4c_ValidaGrupo")
1822:                     THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_ValidaGrupo.Codigos)
1823:                     THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_ValidaGrupo.Descrs)
1824:                 ELSE
1825:                     THIS.AbrirBuscaGrupo()
1826:                 ENDIF
1827:                 IF USED("cursor_4c_ValidaGrupo")
1828:                     USE IN cursor_4c_ValidaGrupo
1829:                 ENDIF
1830:             ENDIF
1831:         ENDIF
1832:     ENDPROC
1833: 
1834:     FUNCTION DGrupoWhen()

*-- Linhas 1896 a 1919:
1896:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DConta.Value = ""
1897:             ELSE
1898:                 loc_cGrupo = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value)
1899:                 loc_cSQL   = "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + ;
1900:                     EscaparSQL(PADR(loc_cValor, 10))
1901:                 IF !EMPTY(loc_cGrupo)
1902:                     loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(loc_cGrupo)
1903:                 ENDIF
1904:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaConta")
1905:                 IF loc_nRes > 0 AND !EOF("cursor_4c_ValidaConta")
1906:                     THIS.pgf_4c_Paginas.Page1.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_ValidaConta.IClis)
1907:                     THIS.pgf_4c_Paginas.Page1.txt_4c_DConta.Value = ALLTRIM(cursor_4c_ValidaConta.RClis)
1908:                 ELSE
1909:                     THIS.AbrirBuscaConta()
1910:                 ENDIF
1911:                 IF USED("cursor_4c_ValidaConta")
1912:                     USE IN cursor_4c_ValidaConta
1913:                 ENDIF
1914:             ENDIF
1915:         ENDIF
1916:     ENDPROC
1917: 
1918:     FUNCTION DContaWhen()
1919:         RETURN EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_Conta.Value)

*-- Linhas 1979 a 1999:
1979:             IF EMPTY(loc_cValor)
1980:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DJobs.Value = ""
1981:             ELSE
1982:                 loc_nRes = SQLEXEC(gnConnHandle, ;
1983:                     "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + ;
1984:                     EscaparSQL(PADR(loc_cValor, 10)), ;
1985:                     "cursor_4c_ValidaJobs")
1986:                 IF loc_nRes > 0 AND !EOF("cursor_4c_ValidaJobs")
1987:                     THIS.pgf_4c_Paginas.Page1.txt_4c__Jobs.Value = ALLTRIM(cursor_4c_ValidaJobs.IClis)
1988:                     THIS.pgf_4c_Paginas.Page1.txt_4c_DJobs.Value = ALLTRIM(cursor_4c_ValidaJobs.RClis)
1989:                 ELSE
1990:                     THIS.AbrirBuscaJobs()
1991:                 ENDIF
1992:                 IF USED("cursor_4c_ValidaJobs")
1993:                     USE IN cursor_4c_ValidaJobs
1994:                 ENDIF
1995:             ENDIF
1996:         ENDIF
1997:     ENDPROC
1998: 
1999:     FUNCTION DJobsWhen()

