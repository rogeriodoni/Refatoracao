# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CALCFECS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, 1, CMOES, DATAS, GRUPOS, CONTAS, MOEDAS, EMPDOPNUMS, ICLIS, DOPES, HISTS, NOPERS, LNVALA, COTACAOS, NOTAS, VLCOMI
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, 1, CMOES, DATAS, GRUPOS, CONTAS, MOEDAS, EMPDOPNUMS, ICLIS, DOPES, HISTS, NOPERS, LNVALA, COTACAOS, NOTAS, VLCOMI
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'GRUFALS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, 1, CMOES, DATAS, GRUPOS, CONTAS, MOEDAS, EMPDOPNUMS, ICLIS, DOPES, HISTS, NOPERS, LNVALA, COTACAOS, NOTAS, VLCOMI

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
lcQrySigCdOpe = [Select ordes,dopes,cmoes,copers,ccomis,comcargs,vendas,calcfecs,relfechas,caixas From SigCdOpe ] + ;
lcQrySigCdEmp = [Select cemps,razas From SigCdEmp Where cemps=']+_Empr+[']
lcQrySigMvPar = [Select * From SigMvPar Where 1=0 ]
lcQrySigCdMoe = [Select cmoes,dmoes,cotas,datatrans,fmults,nordrels,disfpres,valadics,grumoes,moeqs,qtdeqs,submoes ]+;
			  [ From SigCdMoe ] + ;
lcQrySigCdCot = [Select cmoes,datas,horas,valos,cidchaves,usuars,dtalts From SigCdCot ]+;
		Select crSigCdOpe
		Select crSigCdMoe
		lcSql = [Select DMoes From SigCdMoe where cmoes = 'R  ']
		If ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalMoe') < 1
		Select LocalMoe
		Select crSigCdCot
		lcQuery = [Select Fpags, Descs, Infos, FPComiss ] + ;
			        [From SigOpFp ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigOpFp') < 1)
		Select crSigOpFp
		lcQuery = [Select CCargs, Comis ] + ;
	    		    [From SigCdCrg ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdCrg') < 1)
		Select crSigCdCrg
insert into dbcabecalho (NomeEmpresa,Titulo) Values (lcNmEmpresa,lcNmTitulo)
lcQuery = [Select * from SigCdCmm where datas Between ?pDtI And ?pDtF ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdCmm') < 1)
select crSigCdCmm
	lcQuery = [Select Emps, Dopes, Datas, Numes, Notas, Valos, GrVends, Vends, EmpDopNums, ContaDs ] + ;
			    [From SigMvCab ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigMvCab') < 1)
		Select crAnalitico
		lcQuery = [Select RClis ] + ;
		    		[From SigCdCli ] + ; 
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalCli') < 1)
		lcQuery = [Select RClis ] + ;
		    		[From SigCdCli ] + ; 
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalCli') < 1)
		select Localcli
		lcQuery = [Select calcfecs ] + ;
		    		[From SigCdope ] + ; 
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalOpe') < 1)
			SELECT crAnalitico
			lcQuery = [Select b.acertos as vlPago, a.cotacaos, a.moedas, b.moedas as moepit  ]+;
					   [From sigmvCcr a, sigcdpit b  ] + ; 
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalPag') < 1)
					SELECT localPag
					SELECT localPag
	Select crSigCdCmm
	Select crAnalitico
		lcQuery = [Select a.EmpDopNums, a.Codigos, a.Emps, o.Dopes, Right(a.Codigos, 6) as Numes ] + ;
					[From SigMvPec a, SigMvCab b, SigCdOpe o ] + ;
						 [Not a.EmpDopNums In (Select n.EmpDopNums From SigMvNfi n ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalSub]) < 1)
		Select LocalSub
			lcQuery = [Select b.NFis, b.EmpDopNums ] + ;
						[From SigMvNfi b ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalNF]) < 1)
			Select LocalNF
		Delete From crAnalitico Where Notas = Space(6)
		Delete From crAnalitico Where Not Notas = Space(6)
	DELETE From crAnalitico Where vlcomi = 0	&&vlcomi-vlpago=0
Select crAnalitico

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrecor.prg) - TRECHOS RELEVANTES PARA PASS SQL (1576 linhas total):

*-- Linhas 762 a 784:
762:             loc_oPagina.txt_4c__ds_estoque.Value   = ""
763:             *-- Moeda padrao: R$ (identico ao Init do legado que inicializava com 'R')
764:             loc_oPagina.txt_4c__cd_moeda.Value = "R"
765:             loc_nResultMoe = SQLEXEC(gnConnHandle, ;
766:                 "SELECT cmoes, dmoes FROM SigCdMoe WHERE RTRIM(cmoes) = 'R'", ;
767:                 "cursor_4c_MoeInit")
768:             IF loc_nResultMoe > 0
769:                 SELECT cursor_4c_MoeInit
770:                 GO TOP
771:                 IF !EOF()
772:                     loc_oPagina.txt_4c__ds_moeda.Value = ALLTRIM(dmoes)
773:                 ELSE
774:                     loc_oPagina.txt_4c__ds_moeda.Value = ""
775:                 ENDIF
776:                 USE IN cursor_4c_MoeInit
777:             ELSE
778:                 IF USED("cursor_4c_MoeInit")
779:                     USE IN cursor_4c_MoeInit
780:                 ENDIF
781:                 loc_oPagina.txt_4c__ds_moeda.Value = ""
782:             ENDIF
783:             loc_oPagina.obj_4c_OptSNA.Value        = 3
784:             loc_oPagina.obj_4c_OptTipo.Value       = 1

*-- Linhas 896 a 914:
896:             IF THIS.this_oRelatorio.PrepararDados()
897:                 IF USED("cursor_4c_Analitico")
898:                     loc_cArq = ADDBS(SYS(2023)) + "sigrecor_" + DTOS(DATE()) + ".xls"
899:                     SELECT cursor_4c_Analitico
900:                     SET SAFETY OFF
901:                     COPY TO (loc_cArq) TYPE XL5
902:                     SET SAFETY ON
903:                     MsgInfo("Arquivo gerado:" + CHR(13) + loc_cArq, "Excel")
904:                 ELSE
905:                     MsgAviso("Nenhum dado para exportar.", "Excel")
906:                 ENDIF
907:             ELSE
908:                 MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Excel")
909:             ENDIF
910:         CATCH TO loc_oErro
911:             MsgErro(loc_oErro.Message, "BtnExcelClick")
912:         ENDTRY
913:     ENDPROC
914: 

*-- Linhas 1028 a 1050:
1028:             RETURN
1029:         ENDIF
1030:         TRY
1031:             loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr" + ;
1032:                        " WHERE codigos = " + EscaparSQL(loc_cCod)
1033:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrVal")
1034:             IF loc_nResult > 0
1035:                 SELECT cursor_4c_GrVal
1036:                 GO TOP
1037:                 IF !EOF()
1038:                     loc_oPagina.txt_4c__Ds_GrEstoque.Value = ALLTRIM(descrs)
1039:                 ELSE
1040:                     loc_oPagina.txt_4c__Ds_GrEstoque.Value = ""
1041:                     USE IN cursor_4c_GrVal
1042:                     THIS.AbrirBuscaCdGrEstoque()
1043:                     RETURN
1044:                 ENDIF
1045:                 USE IN cursor_4c_GrVal
1046:             ENDIF
1047:         CATCH TO loc_oErro
1048:             MsgErro(loc_oErro.Message, "ValidarCdGrEstoque")
1049:         ENDTRY
1050:     ENDPROC

*-- Linhas 1081 a 1106:
1081:             RETURN
1082:         ENDIF
1083:         TRY
1084:             loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr" + ;
1085:                        " WHERE codigos = " + EscaparSQL(loc_cCod)
1086:             IF !EMPTY(loc_cGrupo)
1087:                 loc_cSQL = loc_cSQL + " AND grufals = " + EscaparSQL(loc_cGrupo)
1088:             ENDIF
1089:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CntVal")
1090:             IF loc_nResult > 0
1091:                 SELECT cursor_4c_CntVal
1092:                 GO TOP
1093:                 IF !EOF()
1094:                     loc_oPagina.txt_4c__ds_estoque.Value = ALLTRIM(descrs)
1095:                 ELSE
1096:                     loc_oPagina.txt_4c__ds_estoque.Value = ""
1097:                     USE IN cursor_4c_CntVal
1098:                     THIS.AbrirBuscaCdEstoque()
1099:                     RETURN
1100:                 ENDIF
1101:                 USE IN cursor_4c_CntVal
1102:             ENDIF
1103:         CATCH TO loc_oErro
1104:             MsgErro(loc_oErro.Message, "ValidarCdEstoque")
1105:         ENDTRY
1106:     ENDPROC

*-- Linhas 1134 a 1161:
1134:                 "Grupos")
1135:             IF VARTYPE(loc_oBusca) = "O"
1136:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1137:                     SELECT cursor_4c_BuscaGr
1138:                     loc_oPagina.txt_4c__Cd_GrEstoque.Value = ALLTRIM(codigos)
1139:                     loc_oPagina.txt_4c__Ds_GrEstoque.Value = ALLTRIM(descrs)
1140:                 ELSE
1141:                     IF !loc_oBusca.this_lAchouRegistro
1142:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
1143:                     loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1144:                     loc_oBusca.Show()
1145:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGr")
1146:                         SELECT cursor_4c_BuscaGr
1147:                         loc_oPagina.txt_4c__Cd_GrEstoque.Value = ALLTRIM(codigos)
1148:                         loc_oPagina.txt_4c__Ds_GrEstoque.Value = ALLTRIM(descrs)
1149:                     ENDIF
1150:                     ENDIF
1151:                 ENDIF
1152:                 loc_oBusca.Release()
1153:             ENDIF
1154:             IF USED("cursor_4c_BuscaGr")
1155:                 USE IN cursor_4c_BuscaGr
1156:             ENDIF
1157:         CATCH TO loc_oErro
1158:             MsgErro(loc_oErro.Message, "AbrirBuscaCdGrEstoque")
1159:         ENDTRY
1160:     ENDPROC
1161: 

*-- Linhas 1173 a 1200:
1173:                 "Grupos")
1174:             IF VARTYPE(loc_oBusca) = "O"
1175:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1176:                     SELECT cursor_4c_BuscaGr
1177:                     loc_oPagina.txt_4c__Cd_GrEstoque.Value = ALLTRIM(codigos)
1178:                     loc_oPagina.txt_4c__Ds_GrEstoque.Value = ALLTRIM(descrs)
1179:                 ELSE
1180:                     IF !loc_oBusca.this_lAchouRegistro
1181:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
1182:                     loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1183:                     loc_oBusca.Show()
1184:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGr")
1185:                         SELECT cursor_4c_BuscaGr
1186:                         loc_oPagina.txt_4c__Cd_GrEstoque.Value = ALLTRIM(codigos)
1187:                         loc_oPagina.txt_4c__Ds_GrEstoque.Value = ALLTRIM(descrs)
1188:                     ENDIF
1189:                     ENDIF
1190:                 ENDIF
1191:                 loc_oBusca.Release()
1192:             ENDIF
1193:             IF USED("cursor_4c_BuscaGr")
1194:                 USE IN cursor_4c_BuscaGr
1195:             ENDIF
1196:         CATCH TO loc_oErro
1197:             MsgErro(loc_oErro.Message, "AbrirBuscaDsGrEstoque")
1198:         ENDTRY
1199:     ENDPROC
1200: 

*-- Linhas 1214 a 1241:
1214:                 "Contas")
1215:             IF VARTYPE(loc_oBusca) = "O"
1216:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1217:                     SELECT cursor_4c_BuscaCnt
1218:                     loc_oPagina.txt_4c__cd_estoque.Value = ALLTRIM(codigos)
1219:                     loc_oPagina.txt_4c__ds_estoque.Value = ALLTRIM(descrs)
1220:                 ELSE
1221:                     IF !loc_oBusca.this_lAchouRegistro
1222:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
1223:                     loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1224:                     loc_oBusca.Show()
1225:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCnt")
1226:                         SELECT cursor_4c_BuscaCnt
1227:                         loc_oPagina.txt_4c__cd_estoque.Value = ALLTRIM(codigos)
1228:                         loc_oPagina.txt_4c__ds_estoque.Value = ALLTRIM(descrs)
1229:                     ENDIF
1230:                     ENDIF
1231:                 ENDIF
1232:                 loc_oBusca.Release()
1233:             ENDIF
1234:             IF USED("cursor_4c_BuscaCnt")
1235:                 USE IN cursor_4c_BuscaCnt
1236:             ENDIF
1237:         CATCH TO loc_oErro
1238:             MsgErro(loc_oErro.Message, "AbrirBuscaCdEstoque")
1239:         ENDTRY
1240:     ENDPROC
1241: 

*-- Linhas 1254 a 1281:
1254:                 "Contas")
1255:             IF VARTYPE(loc_oBusca) = "O"
1256:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1257:                     SELECT cursor_4c_BuscaCnt
1258:                     loc_oPagina.txt_4c__cd_estoque.Value = ALLTRIM(codigos)
1259:                     loc_oPagina.txt_4c__ds_estoque.Value = ALLTRIM(descrs)
1260:                 ELSE
1261:                     IF !loc_oBusca.this_lAchouRegistro
1262:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
1263:                     loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1264:                     loc_oBusca.Show()
1265:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCnt")
1266:                         SELECT cursor_4c_BuscaCnt
1267:                         loc_oPagina.txt_4c__cd_estoque.Value = ALLTRIM(codigos)
1268:                         loc_oPagina.txt_4c__ds_estoque.Value = ALLTRIM(descrs)
1269:                     ENDIF
1270:                     ENDIF
1271:                 ENDIF
1272:                 loc_oBusca.Release()
1273:             ENDIF
1274:             IF USED("cursor_4c_BuscaCnt")
1275:                 USE IN cursor_4c_BuscaCnt
1276:             ENDIF
1277:         CATCH TO loc_oErro
1278:             MsgErro(loc_oErro.Message, "AbrirBuscaDsEstoque")
1279:         ENDTRY
1280:     ENDPROC
1281: 

*-- Linhas 1326 a 1348:
1326:             RETURN
1327:         ENDIF
1328:         TRY
1329:             loc_cSQL    = "SELECT cmoes, dmoes FROM SigCdMoe WHERE RTRIM(cmoes) = " + ;
1330:                           EscaparSQL(loc_cCod)
1331:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeVal")
1332:             IF loc_nResult > 0
1333:                 SELECT cursor_4c_MoeVal
1334:                 GO TOP
1335:                 IF !EOF()
1336:                     loc_oPagina.txt_4c__cd_moeda.Value = ALLTRIM(cmoes)
1337:                     loc_oPagina.txt_4c__ds_moeda.Value = ALLTRIM(dmoes)
1338:                 ELSE
1339:                     loc_oPagina.txt_4c__ds_moeda.Value = ""
1340:                     USE IN cursor_4c_MoeVal
1341:                     THIS.AbrirBuscaCdMoeda()
1342:                     RETURN
1343:                 ENDIF
1344:                 USE IN cursor_4c_MoeVal
1345:             ENDIF
1346:         CATCH TO loc_oErro
1347:             MsgErro(loc_oErro.Message, "ValidarCdMoeda")
1348:         ENDTRY

*-- Linhas 1377 a 1404:
1377:                 "Moedas")
1378:             IF VARTYPE(loc_oBusca) = "O"
1379:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1380:                     SELECT cursor_4c_BuscaMoe
1381:                     loc_oPagina.txt_4c__cd_moeda.Value = ALLTRIM(cmoes)
1382:                     loc_oPagina.txt_4c__ds_moeda.Value = ALLTRIM(dmoes)
1383:                 ELSE
1384:                     IF !loc_oBusca.this_lAchouRegistro
1385:                     loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
1386:                     loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1387:                     loc_oBusca.Show()
1388:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
1389:                         SELECT cursor_4c_BuscaMoe
1390:                         loc_oPagina.txt_4c__cd_moeda.Value = ALLTRIM(cmoes)
1391:                         loc_oPagina.txt_4c__ds_moeda.Value = ALLTRIM(dmoes)
1392:                     ENDIF
1393:                     ENDIF
1394:                 ENDIF
1395:                 loc_oBusca.Release()
1396:             ENDIF
1397:             IF USED("cursor_4c_BuscaMoe")
1398:                 USE IN cursor_4c_BuscaMoe
1399:             ENDIF
1400:         CATCH TO loc_oErro
1401:             MsgErro(loc_oErro.Message, "AbrirBuscaCdMoeda")
1402:         ENDTRY
1403:     ENDPROC
1404: 

*-- Linhas 1416 a 1443:
1416:                 "Moedas")
1417:             IF VARTYPE(loc_oBusca) = "O"
1418:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1419:                     SELECT cursor_4c_BuscaMoe
1420:                     loc_oPagina.txt_4c__cd_moeda.Value = ALLTRIM(cmoes)
1421:                     loc_oPagina.txt_4c__ds_moeda.Value = ALLTRIM(dmoes)
1422:                 ELSE
1423:                     IF !loc_oBusca.this_lAchouRegistro
1424:                     loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1425:                     loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
1426:                     loc_oBusca.Show()
1427:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
1428:                         SELECT cursor_4c_BuscaMoe
1429:                         loc_oPagina.txt_4c__cd_moeda.Value = ALLTRIM(cmoes)
1430:                         loc_oPagina.txt_4c__ds_moeda.Value = ALLTRIM(dmoes)
1431:                     ENDIF
1432:                     ENDIF
1433:                 ENDIF
1434:                 loc_oBusca.Release()
1435:             ENDIF
1436:             IF USED("cursor_4c_BuscaMoe")
1437:                 USE IN cursor_4c_BuscaMoe
1438:             ENDIF
1439:         CATCH TO loc_oErro
1440:             MsgErro(loc_oErro.Message, "AbrirBuscaDsMoeda")
1441:         ENDTRY
1442:     ENDPROC
1443: 


### BO (C:\4c\projeto\app\classes\sigrecorBO.prg):
*==============================================================================
* SIGRECORBO.PRG
* Business Object para Relatorio de Comissao por Vendedor (filtro PenPag)
*
* Herda de RelatorioBase
* Tabela principal: SigCdCmm
*==============================================================================

DEFINE CLASS sigrecorBO AS RelatorioBase

    *-- Filtros: periodo
    this_dDtInicial   = {}
    this_dDtFinal     = {}

    *-- Filtros: moeda
    this_cCdMoeda     = ""
    this_cDsMoeda     = ""

    *-- Filtros: grupo de estoque/contabilidade
    this_cCdGrEstoque = ""
    this_cDsGrEstoque = ""

    *-- Filtros: conta de estoque/contabilidade
    this_cCdEstoque   = ""
    this_cDsEstoque   = ""

    *-- Opcoes do relatorio
    *-- this_nOptTipo: 1=Analitico  2=Sintetico  3=Resumo
    this_nOptTipo     = 1

    *-- this_nOptSNA: 1=Sim  2=Nao  3=Ambos  (default=3)
    this_nOptSNA      = 3

    *-- this_nOptQuebras: 1=Datas  2=Data+Movimentacao  3=Cliente
    this_nOptQuebras  = 1

    *-- this_nOptPenPag: 0=Nao  1=Sim (PenPag: pagamento em aberto)
    this_nOptPenPag   = 0

    *-- Cursores de saida do relatorio
    this_cCursorAnalitico = "cursor_4c_Analitico"
    this_cCursorCabecalho = "cursor_4c_Cabecalho"

    *--------------------------------------------------------------------------
    * Init - Inicializa BO do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdCmm"
        THIS.this_cCampoChave = "EmpDopNums"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave logica do relatorio (filtros aplicados)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ALLTRIM(THIS.this_cTabela) + "|" + ;
                     DTOS(THIS.this_dDtInicial) + "|" + ;
                     DTOS(THIS.this_dDtFinal) + "|" + ;
                     ALLTRIM(THIS.this_cCdMoeda) + "|" + ;
                     ALLTRIM(THIS.this_cCdGrEstoque) + "|" + ;
                     ALLTRIM(THIS.this_cCdEstoque) + "|" + ;
                     STR(THIS.this_nOptTipo, 1) + "|" + ;
                     STR(THIS.this_nOptSNA, 1) + "|" + ;
                     STR(THIS.this_nOptQuebras, 1) + "|" + ;
                     STR(THIS.this_nOptPenPag, 1)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros do relatorio a partir de cursor
    * Permite restaurar configuracao de filtros salva previamente.
    * par_cAliasCursor: alias do cursor com colunas DtInicial, DtFinal,
    *   CdMoeda, DsMoeda, CdGrEstoque, DsGrEstoque, CdEstoque, DsEstoque,
    *   OptTipo, OptSNA, OptQuebras, OptPenPag
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErr, loc_cAlias
        loc_lSucesso = .F.

        IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor de par" + CHR(226) + "metros n" + ;
                                      CHR(227) + "o dispon" + CHR(237) + "vel: " + ;
                                      TRANSFORM(par_cAliasCursor)
            RETURN .F.
        ENDIF

        loc_cAlias = par_cAliasCursor

        TRY
            SELECT (loc_cAlias)
            IF !EOF()
                IF TYPE(loc_cAlias + ".DtInicial") = "D"
                    THIS.this_dDtInicial = EVALUATE(loc_cAlias + ".DtInicial")
                ENDIF
                IF TYPE(loc_cAlias + ".DtFinal") = "D"
                    THIS.this_dDtFinal = EVALUATE(loc_cAlias + ".DtFinal")
                ENDIF
                IF TYPE(loc_cAlias + ".CdMoeda") = "C"
                    THIS.this_cCdMoeda = EVALUATE(loc_cAlias + ".CdMoeda")
                ENDIF
                IF TYPE(loc_cAlias + ".DsMoeda") = "C"
                    THIS.this_cDsMoeda = EVALUATE(loc_cAlias + ".DsMoeda")
                ENDIF
                IF TYPE(loc_cAlias + ".CdGrEstoque") = "C"
                    THIS.this_cCdGrEstoque = EVALUATE(loc_cAlias + ".CdGrEstoque")
                ENDIF
                IF TYPE(loc_cAlias + ".DsGrEstoque") = "C"
                    THIS.this_cDsGrEstoque = EVALUATE(loc_cAlias + ".DsGrEstoque")
                ENDIF
                IF TYPE(loc_cAlias + ".CdEstoque") = "C"
                    THIS.this_cCdEstoque = EVALUATE(loc_cAlias + ".CdEstoque")
                ENDIF
                IF TYPE(loc_cAlias + ".DsEstoque") = "C"
                    THIS.this_cDsEstoque = EVALUATE(loc_cAlias + ".DsEstoque")
                ENDIF
                IF TYPE(loc_cAlias + ".OptTipo") = "N"
                    THIS.this_nOptTipo = EVALUATE(loc_cAlias + ".OptTipo")
                ENDIF
                IF TYPE(loc_cAlias + ".OptSNA") = "N"
                    THIS.this_nOptSNA = EVALUATE(loc_cAlias + ".OptSNA")
                ENDIF
                IF TYPE(loc_cAlias + ".OptQuebras") = "N"
                    THIS.this_nOptQuebras = EVALUATE(loc_cAlias + ".OptQuebras")
                ENDIF
                IF TYPE(loc_cAlias + ".OptPenPag") = "N"
                    THIS.this_nOptPenPag = EVALUATE(loc_cAlias + ".OptPenPag")
                ENDIF
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Cursor de par" + CHR(226) + ;
                                          "metros vazio"
            ENDIF
        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Registra execucao do relatorio em LogAuditoria
    * Para relatorios, "Inserir" significa registrar nova execucao,
    * permitindo rastrear quem rodou qual relatorio e quando.
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_oErr
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.RegistrarAuditoria("REPORT_RUN")
            IF !loc_lSucesso
                THIS.this_cMensagemErro = "Falha ao registrar execu" + ;
                                          CHR(231) + CHR(227) + "o do relat" + ;
                                          CHR(243) + "rio em LogAuditoria"
            ENDIF
        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "Inserir")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Registra reexecucao do relatorio em LogAuditoria
    * Para relatorios, "Atualizar" significa registrar uma reexecucao
    * (usuario alterou filtros e gerou o relatorio novamente).
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_oErr
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.RegistrarAuditoria("REPORT_RERUN")
            IF !loc_lSucesso
                THIS.this_cMensagemErro = "Falha ao registrar reexecu" + ;
                                          CHR(231) + CHR(227) + "o do relat" + ;
                                          CHR(243) + "rio em LogAuditoria"
            ENDIF
        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "Atualizar")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa dados do relatorio de Comissao por Vendedor
    * Replica logica do procedimento 'processamento' do legado SIGRECOR
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lResultado, loc_lErroNoScan, loc_oErro
        LOCAL loc_nResult, loc_cSQL
        LOCAL loc_cMoeda, loc_nCot1, loc_nCot
        LOCAL loc_cGrupo, loc_cConta, loc_cCdMoeda, loc_cDsMoeda
        LOCAL loc_nTip, loc_nOpt, loc_nPenPag
        LOCAL loc_cNmEmpresa, loc_cNmTitulo
        LOCAL loc_cCta, loc_cNvends
        LOCAL loc_nReg, loc_nValA, loc_nValR
        LOCAL loc_nComiAtual, loc_cHistPat, loc_cEdn

        loc_lResultado  = .F.
        loc_lErroNoScan = .F.

        TRY
            loc_cMoeda   = "AU"
            loc_nCot1    = THIS.BuscarCotacao(loc_cMoeda, DATE())
            loc_cGrupo   = PADR(THIS.this_cCdGrEstoque, 10)
            loc_cConta   = PADR(THIS.this_cCdEstoque, 10)
            loc_cCdMoeda = ALLTRIM(THIS.this_cCdMoeda)
            loc_cDsMoeda = ALLTRIM(THIS.this_cDsMoeda)
            loc_nTip     = THIS.this_nOptTipo
            loc_nOpt     = THIS.this_nOptSNA
            loc_nPenPag  = THIS.this_nOptPenPag

            *-- Busca nome da empresa
            loc_cNmEmpresa = ""
            loc_cSQL = "SELECT razas FROM SigCdEmp" + ;
                       " WHERE cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp")
            IF loc_nResult > 0
                SELECT cursor_4c_Emp
                GO TOP
                IF !EOF()
                    loc_cNmEmpresa = ALLTRIM(razas)
                ENDIF
                USE IN cursor_4c_Emp
            ENDIF

            *-- Monta titulo do relatorio
            loc_cNmTitulo = "Comiss" + CHR(227) + "o em " + PROPER(loc_cDsMoeda) + ;
                            " de " + DTOC(THIS.this_dDtInicial) + ;
                            " " + CHR(224) + " " + DTOC(THIS.this_dDtFinal) + " - " + ;
                            IIF(loc_nTip = 1, "Anal" + CHR(237) + "tico", ;
                                IIF(loc_nTip = 2, "Sint" + CHR(233) + "tico", "Resumido")) + ;
                            " - Op" + CHR(231) + CHR(227) + "o: " + ;
                            IIF(loc_nOpt = 1, "Sim", ;
                                IIF(loc_nOpt = 2, "N" + CHR(227) + "o", "Ambos"))

            *-- Cursor cabecalho
            IF USED("cursor_4c_Cabecalho")
                USE IN cursor_4c_Cabecalho
            ENDIF
            CREATE CURSOR cursor_4c_Cabecalho (NomeEmpresa C(80), Titulo C(80))
            INSERT INTO cursor_4c_Cabecalho (NomeEmpresa, Titulo) ;
                VALUES (loc_cNmEmpresa, loc_cNmTitulo)

            *-- Cursor analitico de saida
            IF USED("cursor_4c_Analitico")
                USE IN cursor_4c_Analitico
            ENDIF
            CREATE CURSOR cursor_4c_Analitico ;
                (Vends C(10), NVends C(50), Comis N(9,4), Valos N(12,4), ;
                 Datas D(8), EmpDopNums C(29), ContaDs C(10), RClis C(40), ;
                 Notas C(6), Dopes C(20), VlBaixas N(12,4), moedas C(3), ;
                 VlPago N(12,4), VlComi N(12,4), VlPagoR N(12,4), VlComiR N(12,4))

            *-- Indice conforme tipo e quebra de relatorio
            DO CASE
                CASE (loc_nTip = 1)
                    IF THIS.this_nOptQuebras <> 3
                        INDEX ON Vends + DTOS(Datas) + EmpDopNums + moedas TAG VendDatas
                    ELSE
                        INDEX ON Vends + RClis + moedas TAG VendDatas
                    ENDIF
                CASE (loc_nTip = 2)
                    INDEX ON Vends + moedas TAG VendDatas
                OTHERWISE
                    INDEX ON Vends + DTOS(Datas) + Dopes + moedas TAG VendDatas
            ENDCASE

            *-- Query principal em SigCdCmm com filtros de periodo/grupo/conta/moeda
            loc_cSQL = "SELECT * FROM SigCdCmm" + ;
                       " WHERE datas BETWEEN " + FormatarDataSQL(THIS.this_dDtInicial) + ;
                       " AND " + FormatarDataSQL(THIS.this_dDtFinal)
            IF !EMPTY(ALLTRIM(loc_cGrupo))
                loc_cSQL = loc_cSQL + " AND grupos = " + EscaparSQL(loc_cGrupo)
            ENDIF
            IF !EMPTY(ALLTRIM(loc_cConta))
                loc_cSQL = loc_cSQL + " AND contas = " + EscaparSQL(loc_cConta)
            ENDIF
            IF !EMPTY(loc_cCdMoeda)
                loc_cSQL = loc_cSQL + " AND moedas = " + EscaparSQL(loc_cCdMoeda)
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cmm")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados de comiss" + CHR(227) + "o"
                loc_lErroNoScan = .T.
            ENDIF

            *-- SCAN principal: processa cada registro de comissao
            IF !loc_lErroNoScan
                SELECT cursor_4c_Cmm
                SCAN WHILE !loc_lErroNoScan

                    *-- Busca cabecalho do movimento correspondente
                    loc_cSQL = "SELECT Emps, Dopes, Datas, Numes, Notas, Valos," + ;
                               " GrVends, Vends, EmpDopNums, ContaDs FROM SigMvCab" + ;
                               " WHERE EmpDopNums = " + ;
                               EscaparSQL(ALLTRIM(cursor_4c_Cmm.EmpDopNums)) + ;
                               " ORDER BY Emps, Dopes, Datas, Numes, Notas," + ;
                               " Valos, GrVends, Vends, EmpDopNums, ContaDs"
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCab")
                    IF loc_nResult < 0
                        THIS.this_cMensagemErro = "Erro ao buscar SigMvCab"
                        loc_lErroNoScan = .T.
                        EXIT
                    ENDIF

                    IF !EOF("cursor_4c_MvCab")
                        SELECT cursor_4c_Analitico
                        APPEND BLANK

                        *-- Busca descricao para ContaDs do movimento
                        loc_cSQL = "SELECT RClis FROM SigCdCli WHERE IClis = " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_MvCab.ContaDs))
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cli1")
                        IF loc_nResult < 0
                            THIS.this_cMensagemErro = "Erro ao buscar SigCdCli (ContaDs)"
                            loc_lErroNoScan = .T.
                            EXIT
                        ENDIF
                        loc_cCta = ""
                        SELECT cursor_4c_Cli1
                        IF !EOF()
                            loc_cCta = ALLTRIM(RClis)
                        ENDIF
                        USE IN cursor_4c_Cli1

                        *-- Busca nome do vendedor via Contas da comissao
                        loc_cSQL = "SELECT RClis FROM SigCdCli WHERE IClis = " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Cmm.Contas))
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cli2")
                        IF loc_nResult < 0
                            THIS.this_cMensagemErro = "Erro ao buscar SigCdCli (Contas)"
                            loc_lErroNoScan = .T.
                            EXIT
                        ENDIF
                        loc_cNvends = ""
                        SELECT cursor_4c_Cli2
                        GO TOP
                        IF !EOF()
                            loc_cNvends = ALLTRIM(RClis)
                        ENDIF
                        USE IN cursor_4c_Cli2

                        SELECT cursor_4c_Analitico
                        REPLACE Vends  WITH cursor_4c_Cmm.Contas, ;
                                NVends WITH loc_cNvends IN cursor_4c_Analitico

                        *-- Verifica se operacao e estorno de comissao
                        loc_cSQL = "SELECT calcfecs FROM SigCdOpe WHERE dopes = " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Cmm.dopes))
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ope")
                        IF loc_nResult < 0
                            THIS.this_cMensagemErro = "Erro ao buscar SigCdOpe"
                            loc_lErroNoScan = .T.
                            EXIT
                        ENDIF
                        SELECT cursor_4c_Ope
                        IF !EOF() AND cursor_4c_Ope.calcfecs = 1
                            SELECT cursor_4c_Cmm
                            REPLACE bases     WITH -cursor_4c_Cmm.bases     IN cursor_4c_Cmm
                            REPLACE comissaos WITH -cursor_4c_Cmm.comissaos IN cursor_4c_Cmm
                        ENDIF
                        USE IN cursor_4c_Ope

                        *-- Processamento de PenPag (pagamento em aberto)
                        IF loc_nPenPag = 1
                            loc_nReg = RECNO("cursor_4c_Analitico")
                            SELECT cursor_4c_Analitico
                            LOCATE FOR EmpDopNums = cursor_4c_Cmm.EmpDopNums
                            IF !FOUND()
                                GO loc_nReg
                            ELSE
                                REPLACE VlComi WITH VlComi + VlPago IN cursor_4c_Analitico
                            ENDIF

                            *-- Busca valor ja pago ao vendedor via lancamentos
                            loc_cHistPat = ALLTRIM(cursor_4c_Cmm.emps) + ;
                                           ALLTRIM(cursor_4c_Cmm.dopes) + " " + ;
                                           ALLTRIM(STR(cursor_4c_Cmm.numes))
                            loc_cSQL = "SELECT b.acertos AS vlPago, a.cotacaos," + ;
                                       " a.moedas, b.moedas AS moepit" + ;
                                       " FROM sigmvCcr a, sigcdpit b" + ;
                                       " WHERE a.nopers = b.nopers" + ;
                                       " AND a.grupos = " + ;
                                       EscaparSQL(ALLTRIM(cursor_4c_Cmm.grupos)) + ;
                                       " AND a.contas = " + ;
                                       EscaparSQL(ALLTRIM(cursor_4c_Cmm.Contas)) + ;
                                       " AND b.grupos = " + ;
                                       EscaparSQL(ALLTRIM(cursor_4c_Cmm.grupos)) + ;
                                       " AND b.contas = " + ;
                                       EscaparSQL(ALLTRIM(cursor_4c_Cmm.Contas)) + ;
                                       " AND b.hists LIKE '" + loc_cHistPat + "%'"
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pag")
                            IF loc_nResult < 0
                                THIS.this_cMensagemErro = "Erro ao buscar pagamentos"
                                loc_lErroNoScan = .T.
                                EXIT
                            ENDIF

                            loc_nCot = THIS.BuscarCotacao(loc_cMoeda, DATE())

                            IF ALLTRIM(cursor_4c_Cmm.moedas) = loc_cMoeda
                                IF RECCOUNT("cursor_4c_Pag") = 0
                                    SELECT cursor_4c_Analitico
                                    REPLACE VlComi WITH VlComi + cursor_4c_Cmm.comissaos ;
                                            IN cursor_4c_Analitico
                                    REPLACE VlPago WITH 0.00 IN cursor_4c_Analitico
                                ELSE
                                    loc_nValA = 0.00
                                    SELECT cursor_4c_Pag
                                    SCAN
                                        loc_nValA = loc_nValA + ;
                                            IIF(ALLTRIM(cursor_4c_Pag.moedas) = loc_cMoeda, ;
                                                cursor_4c_Pag.vlPago, ;
                                                ROUND(cursor_4c_Pag.vlPago / ;
                                                      cursor_4c_Pag.cotacaos, 2))
                                    ENDSCAN
                                    SELECT cursor_4c_Analitico
                                    DO CASE
                                        CASE cursor_4c_Cmm.comissaos < 0
                                            REPLACE VlComi WITH VlComi + ;
                                                cursor_4c_Cmm.comissaos + loc_nValA ;
                                                IN cursor_4c_Analitico
                                            REPLACE VlPago WITH loc_nValA ;
                                                IN cursor_4c_Analitico
                                        CASE cursor_4c_Cmm.comissaos > 0
                                            REPLACE VlComi WITH VlComi + ;
                                                cursor_4c_Cmm.comissaos - loc_nValA ;
                                                IN cursor_4c_Analitico
                                            REPLACE VlPago WITH loc_nValA ;
                                                IN cursor_4c_Analitico
                                    ENDCASE
                                ENDIF
                            ELSE
                                IF RECCOUNT("cursor_4c_Pag") = 0
                                    SELECT cursor_4c_Analitico
                                    REPLACE VlComi WITH VlComi + ;
                                        ROUND(cursor_4c_Cmm.comissaos / loc_nCot, 2) ;
                                        IN cursor_4c_Analitico
                                    REPLACE VlPago WITH 0.00 IN cursor_4c_Analitico
                                ELSE
                                    loc_nValA = 0.00
                                    loc_nValR = 0.00
                                    SELECT cursor_4c_Pag
                                    SCAN
                                        loc_nValA = loc_nValA + ;
                                            IIF(ALLTRIM(cursor_4c_Pag.moedas) = loc_cMoeda, ;
                                                cursor_4c_Pag.vlPago, ;
                                                ROUND(cursor_4c_Pag.vlPago / ;
                                                      cursor_4c_Pag.cotacaos, 2))
                                        loc_nValR = loc_nValR + ;
                                            IIF(ALLTRIM(cursor_4c_Pag.moedas) = loc_cMoeda, ;
                                                ROUND(cursor_4c_Pag.vlPago * ;
                                                      cursor_4c_Pag.cotacaos, 2), ;
                                                cursor_4c_Pag.vlPago)
                                    ENDSCAN
                                    SELECT cursor_4c_Analitico
                                    DO CASE
                                        CASE cursor_4c_Cmm.comissaos < 0
                                            REPLACE VlComi WITH VlComi + ;
                                                ROUND((cursor_4c_Cmm.comissaos + ;
                                                       loc_nValR) / loc_nCot, 2) ;
                                                IN cursor_4c_Analitico
                                            REPLACE VlPago WITH loc_nValA ;
                                                IN cursor_4c_Analitico
                                        CASE cursor_4c_Cmm.comissaos > 0
                                            REPLACE VlComi WITH VlComi + ;
                                                ROUND((cursor_4c_Cmm.comissaos - ;
                                                       loc_nValR) / loc_nCot, 2) ;
                                                IN cursor_4c_Analitico
                                            REPLACE VlPago WITH loc_nValA ;
                                                IN cursor_4c_Analitico
                                    ENDCASE
                                ENDIF
                            ENDIF
                            IF USED("cursor_4c_Pag")
                                USE IN cursor_4c_Pag
                            ENDIF
                        ENDIF

                        *-- Preenche campos conforme tipo de relatorio
                        IF (loc_nTip = 1)
                            SELECT cursor_4c_Analitico
                            REPLACE Datas      WITH cursor_4c_MvCab.Datas, ;
                                    EmpDopNums WITH cursor_4c_MvCab.EmpDopNums, ;
                                    Notas      WITH cursor_4c_MvCab.Notas, ;
                                    ContaDs    WITH cursor_4c_MvCab.ContaDs, ;
                                    RClis      WITH loc_cCta IN cursor_4c_Analitico
                        ENDIF
                        IF (loc_nTip = 3)
                            SELECT cursor_4c_Analitico
                            REPLACE Datas WITH cursor_4c_MvCab.Datas, ;
                                    Dopes WITH cursor_4c_MvCab.Dopes IN cursor_4c_Analitico
                        ENDIF

                        IF USED("cursor_4c_MvCab")
                            USE IN cursor_4c_MvCab
                        ENDIF
                    ELSE
                        IF USED("cursor_4c_MvCab")
                            USE IN cursor_4c_MvCab
                        ENDIF
                    ENDIF

                    *-- Acumula valores base no cursor analitico (sempre executa)
                    loc_nComiAtual = cursor_4c_Cmm.comissaos
                    SELECT cursor_4c_Analitico
                    REPLACE valos    WITH valos + cursor_4c_Cmm.bases     IN cursor_4c_Analitico
                    REPLACE comis    WITH comis + loc_nComiAtual           IN cursor_4c_Analitico
                    REPLACE vlbaixas WITH vlbaixas + cursor_4c_Cmm.Baixas IN cursor_4c_Analitico
                    REPLACE moedas   WITH cursor_4c_Cmm.moedas            IN cursor_4c_Analitico
                    SELECT cursor_4c_Cmm

                ENDSCAN

                IF USED("cursor_4c_Cmm")
                    USE IN cursor_4c_Cmm
                ENDIF
            ENDIF

            *-- Pos-processamento tipo Analitico: busca numeros de NF nos subnivels
            IF !loc_lErroNoScan AND (loc_nTip = 1)
                SELECT cursor_4c_Analitico
                SET ORDER TO
                GO TOP
                SCAN WHILE !loc_lErroNoScan
                    loc_cSQL = "SELECT a.EmpDopNums, a.Codigos, a.Emps," + ;
                               " o.Dopes, RIGHT(a.Codigos, 6) AS Numes" + ;
                               " FROM SigMvPec a, SigMvCab b, SigCdOpe o" + ;
                               " WHERE a.EmpDopNums = b.EmpDopNums" + ;
                               " AND LEFT(a.Codigos, 3) = o.NDopes" + ;
                               " AND a.EmpDopNums = " + ;
                               EscaparSQL(ALLTRIM(cursor_4c_Analitico.EmpDopNums)) + ;
                               " AND a.EmpDopNums NOT IN" + ;
                               " (SELECT n.EmpDopNums FROM SigMvNfi n" + ;
                               " WHERE n.EmpDopNums = " + ;
                               EscaparSQL(ALLTRIM(cursor_4c_Analitico.EmpDopNums)) + ")"
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Sub")
                    IF loc_nResult < 0
                        THIS.this_cMensagemErro = "Erro ao buscar SigMvPec"
                        loc_lErroNoScan = .T.
                        EXIT
                    ENDIF

                    SELECT cursor_4c_Sub
                    GO TOP
                    IF !EOF()
                        loc_cEdn = ALLTRIM(cursor_4c_Sub.Emps) + ;
                                   ALLTRIM(cursor_4c_Sub.Dopes) + ;
                                   STR(INT(VAL(ALLTRIM(cursor_4c_Sub.Numes))), 6)
                        loc_cSQL = "SELECT b.NFis, b.EmpDopNums FROM SigMvNfi b" + ;
                                   " WHERE b.EmpDopNums = " + EscaparSQL(loc_cEdn)
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NF")
                        IF loc_nResult < 0
                            THIS.this_cMensagemErro = "Erro ao buscar SigMvNfi"
                            loc_lErroNoScan = .T.
                            USE IN cursor_4c_Sub
                            EXIT
                        ENDIF
                        SELECT cursor_4c_NF
                        GO TOP
                        IF !EOF()
                            SELECT cursor_4c_Analitico
                            REPLACE EmpDopNums WITH cursor_4c_NF.EmpDopNums, ;
                                    Notas      WITH cursor_4c_NF.NFis IN cursor_4c_Analitico
                        ENDIF
                        IF USED("cursor_4c_NF")
                            USE IN cursor_4c_NF
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_Sub")
                        USE IN cursor_4c_Sub
                    ENDIF
                    SELECT cursor_4c_Analitico
                ENDSCAN
            ENDIF

            *-- Aplica filtros SNA (Sim/Nao/Ambos) e filtro PenPag
            IF !loc_lErroNoScan
                SELECT cursor_4c_Analitico
                DO CASE
                    CASE (loc_nOpt = 1)
                        DELETE FROM cursor_4c_Analitico WHERE EMPTY(Notas)
                    CASE (loc_nOpt = 2)
                        DELETE FROM cursor_4c_Analitico WHERE !EMPTY(Notas)
                ENDCASE

                IF loc_nPenPag = 1
                    DELETE FROM cursor_4c_Analitico WHERE VlComi = 0
                ENDIF

                SELECT cursor_4c_Analitico
                SET ORDER TO VendDatas
                GO TOP

                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lResultado, loc_cFrx, loc_cSep, loc_cPto, loc_oErro
        loc_lResultado = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cFrx = THIS.ObterFRXParaImprimir()
                loc_cSep = SET("Separator")
                loc_cPto = SET("Point")
                SET POINT TO ","
                SET SEPARATOR TO "."
                REPORT FORM (loc_cFrx) TO PRINTER NOCONSOLE
                SET POINT TO (loc_cPto)
                SET SEPARATOR TO (loc_cSep)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe preview do relatorio na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lResultado, loc_cFrx, loc_cSep, loc_cPto, loc_oErro
        loc_lResultado = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cFrx = THIS.ObterFRXParaVisualizar()
                loc_cSep = SET("Separator")
                loc_cPto = SET("Point")
                SET POINT TO ","
                SET SEPARATOR TO "."
                REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE
                SET POINT TO (loc_cPto)
                SET SEPARATOR TO (loc_cSep)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterFRXParaImprimir - Seleciona FRX conforme opcoes de impressao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterFRXParaImprimir()
        IF THIS.this_nOptPenPag = 1
            RETURN "SigReCr11"
        ENDIF
        DO CASE
            CASE THIS.this_nOptTipo = 1
                IF THIS.this_nOptQuebras = 1
                    RETURN "SigReCr1"
                ELSE
                    RETURN "SigReCr2"
                ENDIF
            CASE THIS.this_nOptTipo = 2
                RETURN "SigReCr3"
            OTHERWISE
                RETURN "SigReCr4"
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterFRXParaVisualizar - Seleciona FRX conforme opcoes de preview
    * (opcao de quebra 3 = SigReCr6, exclusivo para preview)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterFRXParaVisualizar()
        IF THIS.this_nOptPenPag = 1
            RETURN "SigReCr11"
        ENDIF
        DO CASE
            CASE THIS.this_nOptTipo = 1
                DO CASE
                    CASE THIS.this_nOptQuebras = 1
                        RETURN "SigReCr1"
                    CASE THIS.this_nOptQuebras = 2
                        RETURN "SigReCr2"
                    OTHERWISE
                        RETURN "SigReCr6"
                ENDCASE
            CASE THIS.this_nOptTipo = 2
                RETURN "SigReCr3"
            OTHERWISE
                RETURN "SigReCr4"
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarCotacao - Busca cotacao mais recente da moeda ate a data informada
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BuscarCotacao(par_cMoeda, par_dData)
        LOCAL loc_nResult, loc_nCotacao, loc_cSQL, loc_oErro
        loc_nCotacao = 1.00
        TRY
            loc_cSQL = "SELECT TOP 1 valos FROM SigCdCot" + ;
                       " WHERE cmoes = " + EscaparSQL(ALLTRIM(par_cMoeda)) + ;
                       " AND datas <= " + FormatarDataSQL(par_dData) + ;
                       " ORDER BY datas DESC, horas DESC"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CotBusca")
            IF loc_nResult > 0
                SELECT cursor_4c_CotBusca
                GO TOP
                IF !EOF()
                    loc_nCotacao = NVL(valos, 1.00)
                ENDIF
                USE IN cursor_4c_CotBusca
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_nCotacao
    ENDPROC

ENDDEFINE

