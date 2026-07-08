# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOEDATA' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, SOPERS, OPERS, CONTAS, INTCONTS, DATAS, TIPOS, DOPES, PAGOS, EMPS, GRUPOS, MOEDAS, COPERS, RESPS, 0, EMPDOPNUMS, MOEVALS, ICLIS, BASE, MOEDS, DOPRECEB, VENDS, LINHAS, MOEDAREC, EMPDOPRECEB, CMOES, GRUCONMOES, CIDCHAVES, DATAREC

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
  ControlSource = ""
  ControlSource = ""
lcQrySigCdEmp = [Select cemps,razas From SigCdEmp Where cemps=']+_Empr+[']
		lcQuery = [Select CMoes, Cotas, FMults, Moeqs, Qtdeqs, NordRels From SigCdMoe]
		If (.poDataMgr.SqlExecute(lcQuery, [crSigCdMoe]) < 1)
		Select crSigCdMoe
		lcQuery = [Select MoedaPs From SigCdPam]
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigCdPam]) < 1)
		lcQuery = [Select Colecoes, Agrupas From SigCdCol]
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigCdCol]) < 1)
insert into dbcabecalho (NomeEmpresa, Titulo, PerComis) Values (lcNmEmpresa, lcNmTitulo, (thisform.chkPComis.Value = 1))
lcQuery = [Select a.cidchaves, b.opers, b.Acertos, b.Moedas as MoeAcertos, a.empdopnums as EmpDopReceb, a.datas as DataRec, a.grupos, a.contas, ] + ;
			[from sigmvccr a inner join sigcdpit b on a.empdopnums = b.empdopnums and a.Sopers = b.opers ] +;
				[inner join sigmvccr c on b.nopers = c.nopers and c.opers = b.opers And c.Emps = b.EmpOs ] +;
				[inner join sigmvcab e on e.empdopnums = c.empdopnums And (e.vends = a.contas Or e.resps = a.contas) ] +;
				[Inner Join SigMvPar f on b.Nopers = f.Nopers And c.Emps = f.Emps ] +;
				 [left join sigcdope o on o.Dopes = e.Dopes ] +;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdCmm') < 1)
	Select EmpDopNums, Contas from crSigCdCmm Into Cursor TmpVende
	Select * From crSigCdCmm where Contas = lcConta Into Cursor crSigCdCmm readwrite
lcQuery = [Select a.* From SigCdCmm a Inner Join ] +;
			  [(Select Distinct c.EmpDopNums ] +;
				[From SigMvCcr a Inner Join SigCdPit b on a.EmpDopNums = b.EmpDopNums and a.Sopers = b.opers ] +;
					[Inner Join SigMvCcr c on b.Nopers = c.Nopers and c.Opers = b.Opers ] +;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crCmm') < 1)
Select a.* From crSigCdCmm a Inner Join crCmm b On a.EmpDopNums = b.EmpDopNums And a.IntConts = b.IntConts ;
	Select EmpDopReceb, DataRec, MoedaRec, EmpDopNums, Opers, Sum(Acertos) as Acertos, MoeAcertos, Grupos, Contas, Max(Valors) as Comissaos, ;
		From crSigCdCmm a ;
	Select EmpDopReceb, DataRec, MoedaRec, EmpDopNums, Opers, Acertos, MoeAcertos, Grupos, Contas, Sum(Valors) as Comissaos, ;
		From crSigCdCmm a ;
Select crSigCdCmm
	oProg.Update(.t.)
	Select crCmm
	Select crAnalitico
	lcQuery = [Select Moeds, Moevals From SigMvMov Where EmpDopNums = '] + crSigCdCmm.EmpDopNums + [' and Moevals <> 0]
	If ThisForm.poDataMgr.SqlExecute(lcQuery,'crCotMov') < 1
	lcQuery = [Select RClis From SigCdCli Where IClis = '] + crSigCdCmm.ContaCli + [']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalCli') < 1)
	lcQuery = [Select RClis From SigCdCli Where IClis = '] + crSigCdCmm.Contas + [']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalCli') < 1)
	select Localcli
    Select TmpVende
	=Seek(lcCdMoeda, [crSigCdMoe], [Cmoes])
		=Seek(lcMoeMov, [crSigCdMoe], [Cmoes])
		Select crCotMov
		Select crCotMov
		=Seek(crSigCdCmm.MoedaRec, [crSigCdMoe], [Cmoes])
		=Seek(crSigCdCmm.MoeAcertos, [crSigCdMoe], [Cmoes])
		Select crCotMov
	Select crAnalitico
	Select crCmm
			=Seek(crCmm.Moedas, [crSigCdMoe], [Cmoes])
			Select crCotMov
			Select crCotMov
			Select crAnalitico				
				Insert Into crAnalitico From Memvar
			Select crAnalitico
			Select crAnalitico
				Insert Into crAnalitico(Vends, Datas, Linhas, EmpDopNums, Moedas, MoedaRec) Values ;
			Select crAnalitico
				Insert into crAnalitico(Vends, Datas, Linhas, EmpDopNums, Moedas, MoedaRec, MoeAcertos) ;
		Select crAnalitico
		Select crAnalitico
		Select crAnalitico
			Insert into crAnalitico(Vends, Datas, Linhas, EmpDopNums, Moedas, MoedaRec, MoeAcertos) ;
		Select crAnalitico
		Select crAnalitico
			Insert into crAnalitico(Vends, Datas, Linhas, EmpDopNums, Moedas, MoedaRec, MoeAcertos, ValInis, VlComis) ;
Select crAnalitico
	If thisform.podatamgr.SqlExecute([Select Cmoes from SigCdMoe],[TmpMoe]) < 1
		Delete From TmpMoe where Cmoes <> lcCdMoeda
	Select Distinct Contas from TmpVende into cursor TmpVende
	Select TmpVende
		If thisform.podatamgr.SqlExecute([Select Grupos from SigCdCli where Iclis = '] + TmpVende.Contas + ['],[TmpCli]) < 1
		Select TmpMoe
			lcQuery = [Select Top 1 Nfs, SaldoCs, Saldos, cIdChaves ] + ;
						[From SigMvCcr ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigMvCcr') < 1)
			Select crSigMvCcr
				Insert into crAnalitico(Vends, DataRec, VlBaixas, EmpDopNums,Moedas) Values (TmpVende.Contas,pDat,crSigMvCcr.Saldos,[   Saldo Anterior],TmpMoe.Cmoes)
Select crAnalitico

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrecop.prg) - TRECHOS RELEVANTES PARA PASS SQL (1602 linhas total):

*-- Linhas 901 a 926:
901:             ENDIF
902: 
903:             IF !EMPTY(loc_cCodEmp)
904:                 loc_cSQL = "SELECT cemps, razas FROM SigCdEmp WHERE cemps = " + ;
905:                            EscaparSQL(PADR(loc_cCodEmp, 3))
906:                 IF USED("cursor_4c_EmpInit")
907:                     USE IN cursor_4c_EmpInit
908:                 ENDIF
909:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpInit")
910:                 IF loc_nRes > 0 AND !EOF("cursor_4c_EmpInit")
911:                     SELECT cursor_4c_EmpInit
912:                     loc_cNmEmp = ALLTRIM(cursor_4c_EmpInit.razas)
913:                 ENDIF
914:                 IF USED("cursor_4c_EmpInit")
915:                     USE IN cursor_4c_EmpInit
916:                 ENDIF
917:             ENDIF
918: 
919:             WITH loc_oPagina
920:                 .txt_4c_DtInicial.Value    = DATE()
921:                 .txt_4c_DtFinal.Value      = DATE()
922:                 .txt_4c_CdEmpresa.Value    = loc_cCodEmp
923:                 .txt_4c_DsEmpresa.Value    = loc_cNmEmp
924:                 .txt_4c_CdGrEstoque.Value  = ""
925:                 .txt_4c_DsGrEstoque.Value  = ""
926:                 .txt_4c_CdEstoque.Value    = ""

*-- Linhas 1223 a 1248:
1223:             IF EMPTY(loc_cValor)
1224:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = ""
1225:             ELSE
1226:                 loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe " + ;
1227:                            "WHERE cmoes = " + EscaparSQL(PADR(loc_cValor, 3))
1228:                 IF USED("cursor_4c_MoeVal")
1229:                     USE IN cursor_4c_MoeVal
1230:                 ENDIF
1231:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeVal")
1232:                 IF loc_nResult > 0 AND !EOF("cursor_4c_MoeVal")
1233:                     SELECT cursor_4c_MoeVal
1234:                     THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value = ;
1235:                         ALLTRIM(cursor_4c_MoeVal.cmoes)
1236:                     THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = ;
1237:                         ALLTRIM(cursor_4c_MoeVal.dmoes)
1238:                 ELSE
1239:                     THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value = ""
1240:                     THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = ""
1241:                     THIS.AbrirBuscaMoeda("cmoes")
1242:                 ENDIF
1243:                 IF USED("cursor_4c_MoeVal")
1244:                     USE IN cursor_4c_MoeVal
1245:                 ENDIF
1246:             ENDIF
1247:         CATCH TO loc_oErro
1248:             MsgErro(loc_oErro.Message, "ValidarCdMoeda")

*-- Linhas 1279 a 1304:
1279:             IF EMPTY(loc_cValor)
1280:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DsEmpresa.Value = ""
1281:             ELSE
1282:                 loc_cSQL = "SELECT cemps, razas FROM SigCdEmp " + ;
1283:                            "WHERE cemps = " + EscaparSQL(PADR(loc_cValor, 3))
1284:                 IF USED("cursor_4c_EmpVal")
1285:                     USE IN cursor_4c_EmpVal
1286:                 ENDIF
1287:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
1288:                 IF loc_nResult > 0 AND !EOF("cursor_4c_EmpVal")
1289:                     SELECT cursor_4c_EmpVal
1290:                     THIS.pgf_4c_Paginas.Page1.txt_4c_CdEmpresa.Value = ;
1291:                         ALLTRIM(cursor_4c_EmpVal.cemps)
1292:                     THIS.pgf_4c_Paginas.Page1.txt_4c_DsEmpresa.Value = ;
1293:                         ALLTRIM(cursor_4c_EmpVal.razas)
1294:                 ELSE
1295:                     THIS.pgf_4c_Paginas.Page1.txt_4c_CdEmpresa.Value = ""
1296:                     THIS.pgf_4c_Paginas.Page1.txt_4c_DsEmpresa.Value = ""
1297:                     THIS.AbrirBuscaEmpresa("cemps")
1298:                 ENDIF
1299:                 IF USED("cursor_4c_EmpVal")
1300:                     USE IN cursor_4c_EmpVal
1301:                 ENDIF
1302:             ENDIF
1303:         CATCH TO loc_oErro
1304:             MsgErro(loc_oErro.Message, "ValidarCdEmpresa")

*-- Linhas 1342 a 1360:
1342: 
1343:                 IF loc_oBusca.this_lSelecionou
1344:                     IF USED("cursor_4c_BuscaMoe")
1345:                         SELECT cursor_4c_BuscaMoe
1346:                         loc_oPagina.txt_4c_CdMoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.cmoes)
1347:                         loc_oPagina.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.dmoes)
1348:                     ENDIF
1349:                 ELSE
1350:                     IF loc_cCampo = "cmoes"
1351:                         loc_oPagina.txt_4c_CdMoeda.Value = ""
1352:                     ENDIF
1353:                     loc_oPagina.txt_4c_DsMoeda.Value = ""
1354:                 ENDIF
1355: 
1356:                 IF USED("cursor_4c_BuscaMoe")
1357:                     USE IN cursor_4c_BuscaMoe
1358:                 ENDIF
1359:                 loc_oBusca.Release()
1360:             ENDIF

*-- Linhas 1400 a 1418:
1400: 
1401:                 IF loc_oBusca.this_lSelecionou
1402:                     IF USED("cursor_4c_BuscaEmp")
1403:                         SELECT cursor_4c_BuscaEmp
1404:                         loc_oPagina.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.cemps)
1405:                         loc_oPagina.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.razas)
1406:                     ENDIF
1407:                 ELSE
1408:                     IF loc_cCampo = "cemps"
1409:                         loc_oPagina.txt_4c_CdEmpresa.Value = ""
1410:                     ENDIF
1411:                     loc_oPagina.txt_4c_DsEmpresa.Value = ""
1412:                 ENDIF
1413: 
1414:                 IF USED("cursor_4c_BuscaEmp")
1415:                     USE IN cursor_4c_BuscaEmp
1416:                 ENDIF
1417:                 loc_oBusca.Release()
1418:             ENDIF

