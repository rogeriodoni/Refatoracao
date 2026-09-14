# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (7)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, CUNIS, CPROS, EMPGRUESTS, SQTDS, EMPS, GRUPOS, ESTOS, DATAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCRS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, CUNIS, CPROS, EMPGRUESTS, SQTDS, EMPS, GRUPOS, ESTOS, DATAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, CUNIS, CPROS, EMPGRUESTS, SQTDS, EMPS, GRUPOS, ESTOS, DATAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RCLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, CUNIS, CPROS, EMPGRUESTS, SQTDS, EMPS, GRUPOS, ESTOS, DATAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DUNIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, CUNIS, CPROS, EMPGRUESTS, SQTDS, EMPS, GRUPOS, ESTOS, DATAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, CUNIS, CPROS, EMPGRUESTS, SQTDS, EMPS, GRUPOS, ESTOS, DATAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, CUNIS, CPROS, EMPGRUESTS, SQTDS, EMPS, GRUPOS, ESTOS, DATAS

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
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select cemps,razas From SigCdEmp where cemps = ']+_Empr+[' ],'CrSigCdEmp')
Select CrSigCdEmp
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select * From SigCdMoe ],'CrSigCdMoe')
Select CrSigCdMoe
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select * From SigCdCot ],'CrSigCdCot')
Select CrSigCdCot
	Insert Into dbCabecalho (NomeEmpresa,Titulo,SubTitulo,Cabecalho) Values (lcNomeEmpresa,lcTitulo,lcSubTitulo,cCabecalho)
		lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select a.cpros,a.cunis,c.dunis,a.linhas,b.tpcustos,a.pesoms,a.pvens,]+;
		[From SigCdPro a ]+;
		[Left Join SigCdLin b On b.linhas = a.linhas ]+;
		[Left Join SigCdUni c On c.cunis = a.cunis ]+;
		Select CrSigCdPro
			loBarra.Update(.T.,'Produto: ' + CrSigCdPro.cpros)
				lnQueryOk = ThisForm.poDatamgr.SqlExecute([Select sqtds From SigMvEst ]+;
				Select TmpSaldo
					Select CrSigCdPro
					Select SigMvHst
						Select CrSigCdPro
					lStrQuery = [Select Top 1 SQtds,Datas From SigMvHst ]+;
					If ThisForm.poDatamgr.SqlExecute(lStrQuery,'TmpSaldo') < 1
					Select TmpSaldo
						Select CrSigCdPro
			Select TempMoe
			=Seek(CrSigCdPro.moevs,'TempMoe','cmoes')
			Select TempMoe
			=Seek(lcMoeda,'TempMoe','cmoes')
			Select TempMoe
			=Seek(CrSigCdPro.moecusfs,'TempMoe','cmoes')
			Select TempMoe
			=Seek(CrSigCdPro.moepvs,'TempMoe','cmoes')
			Select dbRelat
			=Seek(CrSigCdPro.cunis + lcFatVens,'dbRelat','cunis')
			Select CrSigCdPro
			lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select cpros,sqtds,cidchaves From SigMvEst ]+;
			lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select cpros From SigMvHst ]+;
		Select TmpSaldo
				loBarra.Update(.T.,'Produto: ' + TmpSaldo.cpros)
				lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select a.cpros,a.cunis,c.dunis,a.linhas,b.tpcustos,a.pesoms,a.pvens,]+;
				[From SigCdPro a ]+;
				[Left Join SigCdLin b On b.linhas = a.linhas ]+;
				[Left Join SigCdUni c On c.cunis = a.cunis ]+;
						Select SigMvHst
							Select CrSigCdPro
						lStrQuery = [Select Top 1 SQtds From SigMvHst ]+;
						If ThisForm.poDatamgr.SqlExecute(lStrQuery,'TmpHis') < 1
						Select TmpHis
							Select TmpSaldo
				Select TempMoe
				=Seek(TmpPro.moevs,'TempMoe','cmoes')
				Select TempMoe
				=Seek(lcMoeda,'TempMoe','cmoes')
				Select TempMoe
				=Seek(TmpPro.moecusfs,'TempMoe','cmoes')
				Select TempMoe
				=Seek(TmpPro.moepvs,'TempMoe','cmoes')
				Select dbRelat
				=Seek(TmpPro.cunis + lcFatVens,'dbRelat','cunis')
				Select TmpSaldo
	Select dbRelat
		loBarraRel.Update(.T.)
		Insert Into dbRelatorio (Detalhe) Values (cDetalhe)
	loBarraRel.Update(.T.)
	Insert Into dbRelatorio (Detalhe) Values (cTotal)
	loBarraRel.Update(.T.)
	Insert Into dbRelatorio (Detalhe) Values (cTotal)
		Select TempMoe
			Insert Into dbRelatorio (Detalhe) Values ('')
			Insert Into dbRelatorio (Detalhe) Values ('')
			Insert Into dbRelatorio (Detalhe) Values (cDetalhe)
			Insert Into dbRelatorio (Detalhe) Values ('')
			Insert Into dbRelatorio (Detalhe) Values (cDetalhe)
			Insert Into dbRelatorio (Detalhe) value (cDetalhe)
				Insert Into dbRelatorio (Detalhe) Values (cDetalhe)
	loBarraRel.Update(.T.)
	Select dbRelatorio

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreeun.prg) - TRECHOS RELEVANTES PARA PASS SQL (1604 linhas total):

*-- Linhas 819 a 837:
819:             ENDIF
820:             loc_cArquivo = PUTFILE("Salvar como...", "SigReEun", "XLS")
821:             IF !EMPTY(loc_cArquivo)
822:                 SELECT (loc_cCursor)
823:                 COPY TO (loc_cArquivo) TYPE XLS
824:                 MsgInfo("Arquivo exportado com sucesso:" + CHR(13) + ;
825:                     loc_cArquivo, "Excel")
826:             ENDIF
827:         CATCH TO loc_oErro
828:             MsgErro(loc_oErro.Message + CHR(13) + ;
829:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
830:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
831:         ENDTRY
832:     ENDPROC
833: 
834:     *--------------------------------------------------------------------------
835:     * BtnSairClick - Fecha o formulario
836:     *--------------------------------------------------------------------------
837:     PROCEDURE BtnSairClick()

*-- Linhas 1014 a 1036:
1014:             THIS.AtualizarEstadoCamposDescricao()
1015:             RETURN
1016:         ENDIF
1017:         loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr" + ;
1018:             " WHERE Codigos = " + EscaparSQL(loc_cValor)
1019:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrEstVal")
1020:         IF loc_nResult > 0
1021:             SELECT cursor_4c_GrEstVal
1022:             IF !EOF()
1023:                 loc_oPg.txt_4c_DsGrestoque.Value = ALLTRIM(cursor_4c_GrEstVal.Descrs)
1024:             ELSE
1025:                 loc_oPg.txt_4c_DsGrestoque.Value = ""
1026:                 THIS.AbrirBuscaCdGrEst()
1027:             ENDIF
1028:         ELSE
1029:             loc_oPg.txt_4c_DsGrestoque.Value = ""
1030:             THIS.AbrirBuscaCdGrEst()
1031:         ENDIF
1032:         IF USED("cursor_4c_GrEstVal")
1033:             USE IN cursor_4c_GrEstVal
1034:         ENDIF
1035:         THIS.AtualizarEstadoCamposDescricao()
1036:     ENDPROC

*-- Linhas 1046 a 1068:
1046:             THIS.AtualizarEstadoCamposDescricao()
1047:             RETURN
1048:         ENDIF
1049:         loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr" + ;
1050:             " WHERE Descrs LIKE " + EscaparSQL(loc_cValor + "%")
1051:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrEstVal2")
1052:         IF loc_nResult > 0
1053:             SELECT cursor_4c_GrEstVal2
1054:             IF !EOF()
1055:                 loc_oPg.txt_4c_CdGrestoque.Value = ALLTRIM(cursor_4c_GrEstVal2.Codigos)
1056:                 loc_oPg.txt_4c_DsGrestoque.Value = ALLTRIM(cursor_4c_GrEstVal2.Descrs)
1057:             ELSE
1058:                 THIS.AbrirBuscaDsGrEst()
1059:             ENDIF
1060:         ELSE
1061:             THIS.AbrirBuscaDsGrEst()
1062:         ENDIF
1063:         IF USED("cursor_4c_GrEstVal2")
1064:             USE IN cursor_4c_GrEstVal2
1065:         ENDIF
1066:         THIS.AtualizarEstadoCamposDescricao()
1067:     ENDPROC
1068: 

*-- Linhas 1076 a 1094:
1076:         loc_oPg    = THIS.pgf_4c_Paginas.Page1
1077:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdEstoque.Value)
1078:         loc_cGrupo = ALLTRIM(loc_oPg.txt_4c_CdGrestoque.Value)
1079:         loc_cWhere = IIF(EMPTY(loc_cGrupo), "", "Grupos = " + EscaparSQL(loc_cGrupo))
1080:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1081:             "SigCdCli", "cursor_4c_BuscaEstoque", "iclis", loc_cValor, ;
1082:             "Sele" + CHR(231) + CHR(227) + "o de Estoque", ;
1083:             .F., .T., loc_cWhere)
1084:         IF VARTYPE(loc_oBusca) = "O"
1085:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1086:                 loc_oPg.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_BuscaEstoque.iclis)
1087:                 loc_oPg.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_BuscaEstoque.rclis)
1088:             ELSE
1089:                 IF !loc_oBusca.this_lAchouRegistro
1090:                     loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1091:                     loc_oBusca.mAddColuna("rclis", "", "Nome")
1092:                     loc_oBusca.Show()
1093:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEstoque")
1094:                         loc_oPg.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_BuscaEstoque.iclis)

*-- Linhas 1109 a 1127:
1109:         loc_oPg    = THIS.pgf_4c_Paginas.Page1
1110:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsEstoque.Value)
1111:         loc_cGrupo = ALLTRIM(loc_oPg.txt_4c_CdGrestoque.Value)
1112:         loc_cWhere = IIF(EMPTY(loc_cGrupo), "", "Grupos = " + EscaparSQL(loc_cGrupo))
1113:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1114:             "SigCdCli", "cursor_4c_BuscaEstoque", "rclis", loc_cValor, ;
1115:             "Sele" + CHR(231) + CHR(227) + "o de Estoque", ;
1116:             .F., .T., loc_cWhere)
1117:         IF VARTYPE(loc_oBusca) = "O"
1118:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1119:                 loc_oPg.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_BuscaEstoque.rclis)
1120:                 loc_oPg.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_BuscaEstoque.iclis)
1121:             ELSE
1122:                 IF !loc_oBusca.this_lAchouRegistro
1123:                     loc_oBusca.mAddColuna("rclis", "", "Nome")
1124:                     loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1125:                     loc_oBusca.Show()
1126:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEstoque")
1127:                         loc_oPg.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_BuscaEstoque.rclis)

*-- Linhas 1147 a 1172:
1147:             THIS.AtualizarEstadoCamposDescricao()
1148:             RETURN
1149:         ENDIF
1150:         loc_cSQL = "SELECT iclis, rclis FROM SigCdCli WHERE iclis = " + ;
1151:             EscaparSQL(loc_cValor)
1152:         IF !EMPTY(loc_cGrupo)
1153:             loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(loc_cGrupo)
1154:         ENDIF
1155:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EstVal")
1156:         IF loc_nResult > 0
1157:             SELECT cursor_4c_EstVal
1158:             IF !EOF()
1159:                 loc_oPg.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_EstVal.rclis)
1160:             ELSE
1161:                 loc_oPg.txt_4c_DsEstoque.Value = ""
1162:                 THIS.AbrirBuscaCdEstoque()
1163:             ENDIF
1164:         ELSE
1165:             loc_oPg.txt_4c_DsEstoque.Value = ""
1166:             THIS.AbrirBuscaCdEstoque()
1167:         ENDIF
1168:         IF USED("cursor_4c_EstVal")
1169:             USE IN cursor_4c_EstVal
1170:         ENDIF
1171:         THIS.AtualizarEstadoCamposDescricao()
1172:     ENDPROC

*-- Linhas 1181 a 1206:
1181:             THIS.AtualizarEstadoCamposDescricao()
1182:             RETURN
1183:         ENDIF
1184:         loc_cSQL = "SELECT iclis, rclis FROM SigCdCli WHERE rclis LIKE " + ;
1185:             EscaparSQL(loc_cValor + "%")
1186:         IF !EMPTY(loc_cGrupo)
1187:             loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(loc_cGrupo)
1188:         ENDIF
1189:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EstVal2")
1190:         IF loc_nResult > 0
1191:             SELECT cursor_4c_EstVal2
1192:             IF !EOF()
1193:                 loc_oPg.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_EstVal2.iclis)
1194:                 loc_oPg.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_EstVal2.rclis)
1195:             ELSE
1196:                 THIS.AbrirBuscaDsEstoque()
1197:             ENDIF
1198:         ELSE
1199:             THIS.AbrirBuscaDsEstoque()
1200:         ENDIF
1201:         IF USED("cursor_4c_EstVal2")
1202:             USE IN cursor_4c_EstVal2
1203:         ENDIF
1204:         THIS.AtualizarEstadoCamposDescricao()
1205:     ENDPROC
1206: 

*-- Linhas 1278 a 1300:
1278:             THIS.AtualizarEstadoCamposDescricao()
1279:             RETURN
1280:         ENDIF
1281:         loc_cSQL = "SELECT cunis, dunis FROM SigCdUni WHERE cunis = " + ;
1282:             EscaparSQL(loc_cValor)
1283:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UnidVal")
1284:         IF loc_nResult > 0
1285:             SELECT cursor_4c_UnidVal
1286:             IF !EOF()
1287:                 loc_oPg.txt_4c_DsUnidade.Value = ALLTRIM(cursor_4c_UnidVal.dunis)
1288:             ELSE
1289:                 loc_oPg.txt_4c_DsUnidade.Value = ""
1290:                 THIS.AbrirBuscaCdUnidade()
1291:             ENDIF
1292:         ELSE
1293:             loc_oPg.txt_4c_DsUnidade.Value = ""
1294:             THIS.AbrirBuscaCdUnidade()
1295:         ENDIF
1296:         IF USED("cursor_4c_UnidVal")
1297:             USE IN cursor_4c_UnidVal
1298:         ENDIF
1299:         THIS.AtualizarEstadoCamposDescricao()
1300:     ENDPROC

*-- Linhas 1308 a 1330:
1308:             THIS.AtualizarEstadoCamposDescricao()
1309:             RETURN
1310:         ENDIF
1311:         loc_cSQL = "SELECT cunis, dunis FROM SigCdUni WHERE dunis LIKE " + ;
1312:             EscaparSQL(loc_cValor + "%")
1313:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UnidVal2")
1314:         IF loc_nResult > 0
1315:             SELECT cursor_4c_UnidVal2
1316:             IF !EOF()
1317:                 loc_oPg.txt_4c_CdUnidade.Value = ALLTRIM(cursor_4c_UnidVal2.cunis)
1318:                 loc_oPg.txt_4c_DsUnidade.Value = ALLTRIM(cursor_4c_UnidVal2.dunis)
1319:             ELSE
1320:                 THIS.AbrirBuscaDsUnidade()
1321:             ENDIF
1322:         ELSE
1323:             THIS.AbrirBuscaDsUnidade()
1324:         ENDIF
1325:         IF USED("cursor_4c_UnidVal2")
1326:             USE IN cursor_4c_UnidVal2
1327:         ENDIF
1328:         THIS.AtualizarEstadoCamposDescricao()
1329:     ENDPROC
1330: 

*-- Linhas 1402 a 1424:
1402:             THIS.AtualizarEstadoCamposDescricao()
1403:             RETURN
1404:         ENDIF
1405:         loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe WHERE cmoes = " + ;
1406:             EscaparSQL(loc_cValor)
1407:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeVal")
1408:         IF loc_nResult > 0
1409:             SELECT cursor_4c_MoeVal
1410:             IF !EOF()
1411:                 loc_oPg.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_MoeVal.dmoes)
1412:             ELSE
1413:                 loc_oPg.txt_4c_DsMoeda.Value = ""
1414:                 THIS.AbrirBuscaCdMoeda()
1415:             ENDIF
1416:         ELSE
1417:             loc_oPg.txt_4c_DsMoeda.Value = ""
1418:             THIS.AbrirBuscaCdMoeda()
1419:         ENDIF
1420:         IF USED("cursor_4c_MoeVal")
1421:             USE IN cursor_4c_MoeVal
1422:         ENDIF
1423:         THIS.AtualizarEstadoCamposDescricao()
1424:     ENDPROC

*-- Linhas 1432 a 1454:
1432:             THIS.AtualizarEstadoCamposDescricao()
1433:             RETURN
1434:         ENDIF
1435:         loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe WHERE dmoes LIKE " + ;
1436:             EscaparSQL(loc_cValor + "%")
1437:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeVal2")
1438:         IF loc_nResult > 0
1439:             SELECT cursor_4c_MoeVal2
1440:             IF !EOF()
1441:                 loc_oPg.txt_4c_CdMoeda.Value = ALLTRIM(cursor_4c_MoeVal2.cmoes)
1442:                 loc_oPg.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_MoeVal2.dmoes)
1443:             ELSE
1444:                 THIS.AbrirBuscaDsMoeda()
1445:             ENDIF
1446:         ELSE
1447:             THIS.AbrirBuscaDsMoeda()
1448:         ENDIF
1449:         IF USED("cursor_4c_MoeVal2")
1450:             USE IN cursor_4c_MoeVal2
1451:         ENDIF
1452:         THIS.AtualizarEstadoCamposDescricao()
1453:     ENDPROC
1454: 


### BO (C:\4c\projeto\app\classes\sigreeunBO.prg):
*==============================================================================
* SIGREEUNBO.PRG
* Business Object para Relatorio: Posicao de Estoque por Unidade
*
* Formulario original: SIGREEUN.SCX (frmrelatorio)
* Herda de: RelatorioBase
*
* Filtros do relatorio:
*   - Grupo de Estoque (get_cd_grestoque / get_ds_grestoque)
*   - Estoque        (get_cd_estoque   / get_ds_estoque)
*   - Unidade        (get_grupo        / get_grupo_desc)  -> SigCdUni (cunis/dunis)
*   - Data           (get_data)
*   - Moeda          (get_moeda        / get_moeda_desc)  -> SigCdMoe (cmoes/dmoes)
*   - Data Cotacao   (get_dt_cotacao)
*   - Imprimir Cotacao (opt_dados_cotacao, 1=Sim/2=Nao)
*   - Fator de Venda   (Opc_fator,       1=Sim/2=Nao)
*==============================================================================

DEFINE CLASS sigreeunBO AS RelatorioBase

    *-- Filtro: Grupo de Estoque (empgruests - parte grupo)
    this_cCdGrestoque  = ""
    this_cDsGrestoque  = ""

    *-- Filtro: Estoque (empgruests - parte estoque)
    this_cCdEstoque    = ""
    this_cDsEstoque    = ""

    *-- Filtro: Unidade de Produto (SigCdUni: cunis / dunis)
    this_cGrupo        = ""
    this_cGrupoDesc    = ""

    *-- Filtro: Data de referencia da posicao
    this_dData         = {}

    *-- Filtro: Moeda para conversao de valores (SigCdMoe: cmoes / dmoes)
    this_cMoeda        = ""
    this_cMoedaDesc    = ""

    *-- Filtro: Data da cotacao da moeda
    this_dDtCotacao    = {}

    *-- Filtro: Imprimir tabela de cotacoes? (1=Sim / 2=Nao)
    this_nDadosCotacao = 1

    *-- Filtro: Agrupar por fator de venda? (1=Sim / 2=Nao)
    this_nOpcFator     = 1

    *-- Controle interno
    this_cCursorDados  = "cursor_4c_sigreeunDados"

    *--------------------------------------------------------------------------
    * Init - Configura tabela principal e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "cpros"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Verifica campos obrigatorios antes do processamento
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFiltros()
        IF EMPTY(THIS.this_dData)
            THIS.this_cMensagemErro = "Data " + CHR(233) + " obrigat" + CHR(243) + "ria!"
            RETURN .F.
        ENDIF
        IF EMPTY(ALLTRIM(THIS.this_cMoeda))
            THIS.this_cMensagemErro = "Moeda " + CHR(233) + " obrigat" + CHR(243) + "ria!"
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_dDtCotacao)
            THIS.this_cMensagemErro = "Data da Cota" + CHR(231) + CHR(227) + "o " + ;
                CHR(233) + " obrigat" + CHR(243) + "ria!"
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarCotacao - Acumula taxa de cambio de uma moeda em cursor_4c_TempMoe
    * Equivalente ao bloco Seek/Append Blank de TempMoe no processamento original
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarCotacao(par_cMoeda, par_dData)
        IF EMPTY(ALLTRIM(NVL(par_cMoeda, "")))
            RETURN
        ENDIF
        SELECT cursor_4c_TempMoe
        SET ORDER TO cmoes
        IF !SEEK(par_cMoeda, "cursor_4c_TempMoe", "cmoes")
            APPEND BLANK
            REPLACE cursor_4c_TempMoe.cmoes   WITH par_cMoeda
            REPLACE cursor_4c_TempMoe.cotacao WITH fBuscarCotacao(ALLTRIM(par_cMoeda), par_dData)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Prepara cursores para o relatorio de posicao de estoque
    *                 por unidade.
    * Equivalente ao metodo 'processamento' do form legado SIGREEUN.
    *
    * Cria cursores:
    *   dbCabecalho  (NomeEmpresa, Titulo, SubTitulo, Cabecalho) - lido pelo FRX
    *   dbRelatorio  (Detalhe)                                    - lido pelo FRX
    * Cursores intermediarios (sufixo Ru=com unidade, All=sem unidade):
    *   cursor_4c_TempMoe    - cotacoes de moeda acumuladas
    *   cursor_4c_dbRelat    - totais por unidade + fator de venda
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_lFalhou
        LOCAL loc_cNomeEmpresa, loc_cTitulo, loc_cSubTitulo, loc_cCabecalho
        LOCAL loc_lcGrupo, loc_lcEstoque, loc_lcUnid
        LOCAL loc_ldData, loc_lcMoeda, loc_lcDescMoeda, loc_ldDtCotacao
        LOCAL loc_lDadosCotacao, loc_lnFator
        LOCAL loc_llPosAtu
        LOCAL loc_lcGrEstIni, loc_lcGrEstFim, loc_lcEstIni, loc_lcEstFim
        LOCAL loc_lcEGEInis, loc_lcEGEFims
        LOCAL loc_cSQL
        LOCAL loc_lcCodPro, loc_lnValor, loc_lnCusto, loc_lnValFat
        LOCAL loc_lcFatVens, loc_lnSqtds
        LOCAL loc_nTotQtds, loc_nTotCusto, loc_nTotVenda
        LOCAL loc_cDetalhe, loc_cTotal
        LOCAL lcData

        loc_lSucesso = .F.
        loc_lFalhou  = .F.

        TRY
            *-- 1. Validar filtros obrigatorios
            IF !THIS.ValidarFiltros()
                loc_lFalhou = .T.
            ENDIF

            *-- 2. Inicializar variaveis e cursores
            IF !loc_lFalhou
                loc_lcGrupo       = ALLTRIM(THIS.this_cCdGrestoque)
                loc_lcEstoque     = ALLTRIM(THIS.this_cCdEstoque)
                loc_lcUnid        = ALLTRIM(THIS.this_cGrupo)
                loc_ldData        = THIS.this_dData
                loc_lcMoeda       = ALLTRIM(THIS.this_cMoeda)
                loc_lcDescMoeda   = ALLTRIM(THIS.this_cMoedaDesc)
                loc_ldDtCotacao   = THIS.this_dDtCotacao
                loc_lDadosCotacao = THIS.this_nDadosCotacao
                loc_lnFator       = THIS.this_nOpcFator
                loc_llPosAtu      = (loc_ldData = DATE())
                lcData            = fDtoSQL(loc_ldData, "23:59:59")

                *-- Buscar nome da empresa
                loc_cNomeEmpresa = ""
                IF SQLEXEC(gnConnHandle, ;
                    "SELECT razas FROM SigCdEmp WHERE cemps = " + ;
                    EscaparSQL(go_4c_Sistema.cCodEmpresa), ;
                    "cursor_4c_sigEmpReeun") > 0
                    SELECT cursor_4c_sigEmpReeun
                    IF !EOF()
                        loc_cNomeEmpresa = ALLTRIM(razas)
                    ENDIF
                    USE IN cursor_4c_sigEmpReeun
                ENDIF

                *-- Montar textos do relatorio
                loc_cTitulo    = "Posi" + CHR(231) + CHR(227) + ;
                    "o de Estoque p/ Unidade de Produto em " + DTOC(loc_ldData)
                loc_cSubTitulo = IIF(EMPTY(loc_lcMoeda), "", "Valores em " + loc_lcDescMoeda)

                loc_cCabecalho = PADC("Cod", 3, "_") + " "
                loc_cCabecalho = loc_cCabecalho + ;
                    PADC("Descri" + CHR(231) + CHR(227) + "o", 20, "_") + " "
                loc_cCabecalho = loc_cCabecalho + PADC("Fator de Venda", 14, "_") + " "
                loc_cCabecalho = loc_cCabecalho + PADC("Qtde.",          10, "_") + " "
                loc_cCabecalho = loc_cCabecalho + PADC("Vl.Custo",       17, "_") + " "
                loc_cCabecalho = loc_cCabecalho + PADC("Vl.Venda",       17, "_")

                *-- Cursor de cabecalho para o FRX (nome EXATO original: dbCabecalho)
                IF USED("dbCabecalho")
                    USE IN dbCabecalho
                ENDIF
                CREATE CURSOR dbCabecalho ;
                    (NomeEmpresa C(80), Titulo C(80), SubTitulo C(80), Cabecalho C(200))
                INSERT INTO dbCabecalho (NomeEmpresa, Titulo, SubTitulo, Cabecalho) ;
                    VALUES (loc_cNomeEmpresa, loc_cTitulo, loc_cSubTitulo, loc_cCabecalho)

                *-- Cursor de detalhes para o FRX (nome EXATO original: dbRelatorio)
                IF USED("dbRelatorio")
                    USE IN dbRelatorio
                ENDIF
                CREATE CURSOR dbRelatorio (Detalhe C(200))

                *-- Cursor de cotacoes acumuladas por moeda
                IF USED("cursor_4c_TempMoe")
                    USE IN cursor_4c_TempMoe
                ENDIF
                SET NULL ON
                CREATE CURSOR cursor_4c_TempMoe (cmoes C(3), cotacao N(14,4))
                SET NULL OFF
                INDEX ON cmoes TAG cmoes

                *-- Cursor de totais por unidade + fator de venda
                IF USED("cursor_4c_dbRelat")
                    USE IN cursor_4c_dbRelat
                ENDIF
                SET NULL ON
                CREATE CURSOR cursor_4c_dbRelat ;
                    (cunis C(3), dunis C(20), qtds N(10,3), ;
                     vends N(15,2), custs N(15,2), fatvens C(3))
                SET NULL OFF
                INDEX ON cunis + fatvens TAG cunis
                INDEX ON dunis + fatvens TAG descrs

                *-- Montar ranges de empgruests para filtros
                loc_lcGrEstIni = IIF(!EMPTY(loc_lcGrupo), ;
                    PADR(loc_lcGrupo, 10), SPACE(10))
                loc_lcGrEstFim = IIF(!EMPTY(loc_lcGrupo), ;
                    PADR(loc_lcGrupo, 10), REPLICATE(CHR(254), 10))
                loc_lcEstIni   = IIF(!EMPTY(loc_lcEstoque), ;
                    PADR(loc_lcEstoque, 10), SPACE(10))
                loc_lcEstFim   = IIF(!EMPTY(loc_lcEstoque), ;
                    PADR(loc_lcEstoque, 10), REPLICATE(CHR(254), 10))
                loc_lcEGEInis  = go_4c_Sistema.cCodEmpresa + loc_lcGrEstIni + loc_lcEstIni
                loc_lcEGEFims  = go_4c_Sistema.cCodEmpresa + loc_lcGrEstFim + loc_lcEstFim
            ENDIF

            *-- ==================================================================
            *-- CAMINHO 1: Com filtro de unidade (lcUnid preenchido)
            *-- ==================================================================
            IF !loc_lFalhou AND !EMPTY(loc_lcUnid)

                WAIT WINDOW "Aguarde! Selecionando Produtos..." NOWAIT

                loc_cSQL = "SELECT a.cpros, a.cunis, c.dunis, a.linhas, " + ;
                    "b.tpcustos, a.pesoms, a.pvens, a.moevs, " + ;
                    "a.fvendas, a.moepvs, a.custofs, a.moecusfs " + ;
                    "FROM SigCdPro a " + ;
                    "LEFT JOIN SigCdLin b ON b.linhas = a.linhas " + ;
                    "LEFT JOIN SigCdUni c ON c.cunis  = a.cunis " + ;
                    "WHERE a.cunis = " + EscaparSQL(loc_lcUnid)

                IF USED("cursor_4c_SigCdProRu")
                    USE IN cursor_4c_SigCdProRu
                ENDIF
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdProRu") < 1
                    THIS.this_cMensagemErro = "Erro ao consultar SigCdPro (unidade " + ;
                        loc_lcUnid + ")"
                    loc_lFalhou = .T.
                ENDIF

                IF !loc_lFalhou
                    SELECT cursor_4c_SigCdProRu
                    GO TOP
                    SCAN WHILE !loc_lFalhou
                        loc_lcCodPro = cursor_4c_SigCdProRu.cpros

                        IF USED("cursor_4c_TmpSaldoRu")
                            USE IN cursor_4c_TmpSaldoRu
                        ENDIF

                        IF loc_llPosAtu
                            *-- Posicao atual: buscar em SigMvEst
                            loc_cSQL = "SELECT sqtds FROM SigMvEst " + ;
                                "WHERE cpros = " + EscaparSQL(ALLTRIM(loc_lcCodPro)) + ;
                                " AND empgruests BETWEEN " + ;
                                EscaparSQL(loc_lcEGEInis) + ;
                                " AND " + EscaparSQL(loc_lcEGEFims)

                            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpSaldoRu") < 1
                                THIS.this_cMensagemErro = "Erro ao consultar SigMvEst"
                                loc_lFalhou = .T.
                                LOOP
                            ENDIF
                            SELECT cursor_4c_TmpSaldoRu
                            GO TOP
                            IF EOF() OR cursor_4c_TmpSaldoRu.sqtds = 0
                                SELECT cursor_4c_SigCdProRu
                                LOOP
                            ENDIF
                            loc_lnSqtds = cursor_4c_TmpSaldoRu.sqtds
                        ELSE
                            *-- Posicao historica: buscar em SigMvHst
                            loc_cSQL = "SELECT TOP 1 SQtds FROM SigMvHst " + ;
                                "WHERE CPros = " + EscaparSQL(ALLTRIM(loc_lcCodPro)) + ;
                                " AND EmpGruEsts BETWEEN " + ;
                                EscaparSQL(loc_lcEGEInis) + ;
                                " AND " + EscaparSQL(loc_lcEGEFims) + ;
                                " AND Datas <= ?lcData ORDER BY CIdChaves DESC"

                            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpSaldoRu") < 1
                                THIS.this_cMensagemErro = "Erro ao consultar SigMvHst (historico)"
                                loc_lFalhou = .T.
                                LOOP
                            ENDIF
                            SELECT cursor_4c_TmpSaldoRu
                            GO TOP
                            IF EOF() OR cursor_4c_TmpSaldoRu.SQtds = 0
                                SELECT cursor_4c_SigCdProRu
                                LOOP
                            ENDIF
                            loc_lnSqtds = cursor_4c_TmpSaldoRu.SQtds
                        ENDIF

                        *-- Calcular valor de venda convertido para moeda selecionada
                        loc_lnValor = cursor_4c_SigCdProRu.pvens * loc_lnSqtds
                        loc_lnValor = loc_lnValor * ;
                            fBuscarCotacao(cursor_4c_SigCdProRu.moevs, loc_ldData) / ;
                            fBuscarCotacao(loc_lcMoeda, loc_ldData)

                        *-- Calcular custo convertido (tipo 2 = pesoms * custofs)
                        loc_lnCusto = cursor_4c_SigCdProRu.custofs
                        IF NVL(cursor_4c_SigCdProRu.tpcustos, "") = "2"
                            loc_lnCusto = cursor_4c_SigCdProRu.pesoms * cursor_4c_SigCdProRu.custofs
                        ENDIF
                        loc_lnCusto = loc_lnCusto * loc_lnSqtds * ;
                            fBuscarCotacao(cursor_4c_SigCdProRu.moecusfs, loc_ldData) / ;
                            fBuscarCotacao(loc_lcMoeda, loc_ldData)

                        *-- Aplicar fator de venda
                        loc_lnValFat = IIF(cursor_4c_SigCdProRu.fvendas = 0, 1, ;
                            cursor_4c_SigCdProRu.fvendas * ;
                            fBuscarCotacao(cursor_4c_SigCdProRu.moepvs, loc_ldData))
                        loc_lnValor = loc_lnValor * loc_lnValFat

                        *-- Registrar cotacoes das moedas utilizadas
                        THIS.RegistrarCotacao(cursor_4c_SigCdProRu.moevs,    loc_ldData)
                        THIS.RegistrarCotacao(THIS.this_cMoeda,               loc_ldData)
                        THIS.RegistrarCotacao(cursor_4c_SigCdProRu.moecusfs, loc_ldData)
                        THIS.RegistrarCotacao(cursor_4c_SigCdProRu.moepvs,   loc_ldData)

                        *-- Fator de agrupamento por moeda do preco de venda
                        IF loc_lnFator = 1
                            loc_lcFatVens = cursor_4c_SigCdProRu.moepvs
                        ELSE
                            loc_lcFatVens = "   "
                        ENDIF

                        *-- Acumular totais por unidade em cursor_4c_dbRelat
                        SELECT cursor_4c_dbRelat
                        SET ORDER TO cunis
                        IF !SEEK(cursor_4c_SigCdProRu.cunis + loc_lcFatVens, ;
                                 "cursor_4c_dbRelat", "cunis")
                            APPEND BLANK
                            REPLACE cursor_4c_dbRelat.cunis   WITH cursor_4c_SigCdProRu.cunis
                            REPLACE cursor_4c_dbRelat.fatvens WITH loc_lcFatVens
                            REPLACE cursor_4c_dbRelat.dunis   WITH NVL(cursor_4c_SigCdProRu.dunis, "")
                        ENDIF
                        REPLACE cursor_4c_dbRelat.qtds  WITH cursor_4c_dbRelat.qtds  + loc_lnSqtds
                        REPLACE cursor_4c_dbRelat.vends WITH cursor_4c_dbRelat.vends + loc_lnValor
                        REPLACE cursor_4c_dbRelat.custs WITH cursor_4c_dbRelat.custs + loc_lnCusto

                        SELECT cursor_4c_SigCdProRu
                    ENDSCAN
                ENDIF

                WAIT CLEAR

                IF USED("cursor_4c_SigCdProRu")
                    USE IN cursor_4c_SigCdProRu
                ENDIF
                IF USED("cursor_4c_TmpSaldoRu")
                    USE IN cursor_4c_TmpSaldoRu
                ENDIF

            *-- ==================================================================
            *-- CAMINHO 2: Sem filtro de unidade (todos os produtos em estoque)
            *-- ==================================================================
            ELSE
                IF !loc_lFalhou

                WAIT WINDOW "Aguarde! Selecionando Produtos..." NOWAIT

                IF USED("cursor_4c_TmpSaldoAll")
                    USE IN cursor_4c_TmpSaldoAll
                ENDIF

                IF loc_llPosAtu
                    *-- Posicao atual: buscar todos os produtos em SigMvEst
                    loc_cSQL = "SELECT cpros, sqtds, cidchaves FROM SigMvEst " + ;
                        "WHERE empgruests BETWEEN " + ;
                        EscaparSQL(loc_lcEGEInis) + " AND " + EscaparSQL(loc_lcEGEFims) + ;
                        " GROUP BY cidchaves, cpros, sqtds"
                ELSE
                    *-- Posicao historica: buscar produtos distintos em SigMvHst
                    loc_cSQL = "SELECT cpros FROM SigMvHst " + ;
                        "WHERE empgruests BETWEEN " + ;
                        EscaparSQL(loc_lcEGEInis) + " AND " + EscaparSQL(loc_lcEGEFims) + ;
                        " GROUP BY cpros"
                ENDIF

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpSaldoAll") < 1
                    THIS.this_cMensagemErro = "Erro ao selecionar produtos em estoque"
                    loc_lFalhou = .T.
                ENDIF

                IF !loc_lFalhou
                    SELECT cursor_4c_TmpSaldoAll
                    GO TOP
                    IF !EOF()
                        SCAN WHILE !loc_lFalhou
                            loc_lcCodPro = cursor_4c_TmpSaldoAll.cpros

                            *-- Buscar dados do produto em SigCdPro
                            IF USED("cursor_4c_TmpProAll")
                                USE IN cursor_4c_TmpProAll
                            ENDIF
                            loc_cSQL = "SELECT a.cpros, a.cunis, c.dunis, a.linhas, " + ;
                                "b.tpcustos, a.pesoms, a.pvens, a.moevs, " + ;
                                "a.fvendas, a.moepvs, a.custofs, a.moecusfs " + ;
                                "FROM SigCdPro a " + ;
                                "LEFT JOIN SigCdLin b ON b.linhas = a.linhas " + ;
                                "LEFT JOIN SigCdUni c ON c.cunis  = a.cunis " + ;
                                "WHERE a.cpros = " + EscaparSQL(ALLTRIM(loc_lcCodPro))

                            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpProAll") < 1
                                THIS.this_cMensagemErro = "Erro ao buscar produto " + ;
                                    ALLTRIM(loc_lcCodPro)
                                loc_lFalhou = .T.
                                LOOP
                            ENDIF

                            SELECT cursor_4c_TmpProAll
                            GO TOP
                            IF EOF()
                                SELECT cursor_4c_TmpSaldoAll
                                LOOP
                            ENDIF

                            *-- Quantidade: atual de TmpSaldoAll ou historica de SigMvHst
                            IF loc_llPosAtu
                                loc_lnSqtds = cursor_4c_TmpSaldoAll.sqtds
                            ELSE
                                IF USED("cursor_4c_TmpHisAll")
                                    USE IN cursor_4c_TmpHisAll
                                ENDIF
                                loc_cSQL = "SELECT TOP 1 SQtds FROM SigMvHst " + ;
                                    "WHERE CPros = " + EscaparSQL(ALLTRIM(loc_lcCodPro)) + ;
                                    " AND EmpGruEsts BETWEEN " + ;
                                    EscaparSQL(loc_lcEGEInis) + ;
                                    " AND " + EscaparSQL(loc_lcEGEFims) + ;
                                    " AND datas <= ?lcData ORDER BY CIdChaves DESC"

                                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpHisAll") < 1
                                    THIS.this_cMensagemErro = "Erro ao consultar historico"
                                    loc_lFalhou = .T.
                                    LOOP
                                ENDIF
                                SELECT cursor_4c_TmpHisAll
                                GO TOP
                                IF EOF()
                                    SELECT cursor_4c_TmpSaldoAll
                                    LOOP
                                ENDIF
                                loc_lnSqtds = cursor_4c_TmpHisAll.SQtds
                            ENDIF

                            *-- Calcular valor de venda convertido
                            loc_lnValor = cursor_4c_TmpProAll.pvens * loc_lnSqtds
                            loc_lnValor = loc_lnValor * ;
                                fBuscarCotacao(cursor_4c_TmpProAll.moevs, loc_ldData) / ;
                                fBuscarCotacao(loc_lcMoeda, loc_ldData)

                            *-- Calcular custo convertido
                            loc_lnCusto = cursor_4c_TmpProAll.custofs
                            IF NVL(cursor_4c_TmpProAll.tpcustos, "") = "2"
                                loc_lnCusto = cursor_4c_TmpProAll.pesoms * cursor_4c_TmpProAll.custofs
                            ENDIF
                            loc_lnCusto = loc_lnCusto * loc_lnSqtds * ;
                                fBuscarCotacao(cursor_4c_TmpProAll.moecusfs, loc_ldData) / ;
                                fBuscarCotacao(loc_lcMoeda, loc_ldData)

                            *-- Aplicar fator de venda
                            loc_lnValFat = IIF(cursor_4c_TmpProAll.fvendas = 0, 1, ;
                                cursor_4c_TmpProAll.fvendas * ;
                                fBuscarCotacao(cursor_4c_TmpProAll.moepvs, loc_ldData))
                            loc_lnValor = loc_lnValor * loc_lnValFat

                            *-- Registrar cotacoes das moedas utilizadas
                            THIS.RegistrarCotacao(cursor_4c_TmpProAll.moevs,    loc_ldData)
                            THIS.RegistrarCotacao(THIS.this_cMoeda,              loc_ldData)
                            THIS.RegistrarCotacao(cursor_4c_TmpProAll.moecusfs, loc_ldData)
                            THIS.RegistrarCotacao(cursor_4c_TmpProAll.moepvs,   loc_ldData)

                            *-- Fator de agrupamento
                            IF loc_lnFator = 1
                                loc_lcFatVens = cursor_4c_TmpProAll.moepvs
                            ELSE
                                loc_lcFatVens = "   "
                            ENDIF

                            *-- Acumular em cursor_4c_dbRelat
                            SELECT cursor_4c_dbRelat
                            SET ORDER TO cunis
                            IF !SEEK(cursor_4c_TmpProAll.cunis + loc_lcFatVens, ;
                                     "cursor_4c_dbRelat", "cunis")
                                APPEND BLANK
                                REPLACE cursor_4c_dbRelat.cunis   WITH cursor_4c_TmpProAll.cunis
                                REPLACE cursor_4c_dbRelat.fatvens WITH loc_lcFatVens
                                REPLACE cursor_4c_dbRelat.dunis   WITH NVL(cursor_4c_TmpProAll.dunis, "")
                            ENDIF
                            REPLACE cursor_4c_dbRelat.qtds  WITH cursor_4c_dbRelat.qtds  + loc_lnSqtds
                            REPLACE cursor_4c_dbRelat.vends WITH cursor_4c_dbRelat.vends + loc_lnValor
                            REPLACE cursor_4c_dbRelat.custs WITH cursor_4c_dbRelat.custs + loc_lnCusto

                            SELECT cursor_4c_TmpSaldoAll
                        ENDSCAN
                    ENDIF
                ENDIF

                WAIT CLEAR

                IF USED("cursor_4c_TmpSaldoAll")
                    USE IN cursor_4c_TmpSaldoAll
                ENDIF
                IF USED("cursor_4c_TmpProAll")
                    USE IN cursor_4c_TmpProAll
                ENDIF
                IF USED("cursor_4c_TmpHisAll")
                    USE IN cursor_4c_TmpHisAll
                ENDIF

                ENDIF
            ENDIF

            *-- ==================================================================
            *-- FORMATACAO FINAL: cursor_4c_dbRelat -> dbRelatorio
            *-- ==================================================================
            IF !loc_lFalhou

                loc_nTotQtds  = 0
                loc_nTotCusto = 0
                loc_nTotVenda = 0

                SELECT cursor_4c_dbRelat
                GO TOP
                SCAN
                    loc_cDetalhe = PADR(cursor_4c_dbRelat.cunis, 3) + " "
                    loc_cDetalhe = loc_cDetalhe + PADR(cursor_4c_dbRelat.dunis, 20) + " "
                    loc_cDetalhe = loc_cDetalhe + PADC(cursor_4c_dbRelat.fatvens, 14) + " "
                    loc_cDetalhe = loc_cDetalhe + ;
                        PADL(TRANSFORM(cursor_4c_dbRelat.qtds,  "999999.999"), 10) + " "
                    loc_cDetalhe = loc_cDetalhe + ;
                        PADL(TRANSFORM(cursor_4c_dbRelat.custs, "99,999,999,999.99"), 17) + " "
                    loc_cDetalhe = loc_cDetalhe + ;
                        PADL(TRANSFORM(cursor_4c_dbRelat.vends, "99,999,999,999.99"), 17)
                    INSERT INTO dbRelatorio (Detalhe) VALUES (loc_cDetalhe)

                    loc_nTotQtds  = loc_nTotQtds  + cursor_4c_dbRelat.qtds
                    loc_nTotCusto = loc_nTotCusto + cursor_4c_dbRelat.custs
                    loc_nTotVenda = loc_nTotVenda + cursor_4c_dbRelat.vends
                ENDSCAN

                *-- Linha separadora de totais
                loc_cTotal = SPACE(40) + ;
                    REPLICATE("_", 10) + " " + ;
                    REPLICATE("_", 17) + " " + ;
                    REPLICATE("_", 17) + " "
                INSERT INTO dbRelatorio (Detalhe) VALUES (loc_cTotal)

                *-- Linha de totais gerais
                loc_cTotal = PADL("Total : ", 40)
                loc_cTotal = loc_cTotal + ;
                    PADL(TRANSFORM(loc_nTotQtds,  "999999.999"), 10) + " "
                loc_cTotal = loc_cTotal + ;
                    PADL(TRANSFORM(loc_nTotCusto, "99,999,999,999.99"), 17) + " "
                loc_cTotal = loc_cTotal + ;
                    PADL(TRANSFORM(loc_nTotVenda, "99,999,999,999.99"), 17) + " "
                INSERT INTO dbRelatorio (Detalhe) VALUES (loc_cTotal)

                *-- Secao de cotacoes (se solicitado e com moeda preenchida)
                IF loc_lDadosCotacao = 1 AND !EMPTY(loc_lcMoeda)
                    SELECT cursor_4c_TempMoe
                    GO TOP
                    IF !EOF()
                        INSERT INTO dbRelatorio (Detalhe) VALUES ("")
                        INSERT INTO dbRelatorio (Detalhe) VALUES ("")

                        loc_cDetalhe = "Cota" + CHR(231) + CHR(227) + ;
                            "es de " + DTOC(loc_ldDtCotacao)
                        INSERT INTO dbRelatorio (Detalhe) VALUES (loc_cDetalhe)
                        INSERT INTO dbRelatorio (Detalhe) VALUES ("")

                        loc_cDetalhe = PADC("Moeda", 5) + " " + ;
                            PADC("Cota" + CHR(231) + CHR(227) + "o", 14)
                        INSERT INTO dbRelatorio (Detalhe) VALUES (loc_cDetalhe)

                        loc_cDetalhe = REPLICATE("_", 5) + " " + REPLICATE("_", 14)
                        INSERT INTO dbRelatorio (Detalhe) VALUES (loc_cDetalhe)

                        SCAN
                            loc_cDetalhe = PADR(cursor_4c_TempMoe.cmoes, 5) + " "
                            loc_cDetalhe = loc_cDetalhe + ;
                                PADL(TRANSFORM(cursor_4c_TempMoe.cotacao, "999,999,999.99"), 14)
                            INSERT INTO dbRelatorio (Detalhe) VALUES (loc_cDetalhe)
                        ENDSCAN
                    ENDIF
                ENDIF

                SELECT dbRelatorio
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        WAIT CLEAR
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros do relatorio a partir de um cursor.
    *                    Usado quando se deseja restaurar uma configuracao
    *                    salva de filtros (ex: ultima execucao do relatorio).
    *
    * O cursor passado deve conter as colunas: cdgrestoque, dsgrestoque,
    * cdestoque, dsestoque, cunis, dunis, datafiltro, cmoes, dmoes,
    * dtcotacao, dadoscotacao, opcfator.
    *
    * Como relatorios nao tem registro fixo (sao parametrizados), este
    * metodo opera sobre o registro corrente do cursor de filtros salvos.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(NVL(par_cAliasCursor, "")))
            THIS.this_cMensagemErro = "Cursor de origem n" + CHR(227) + ;
                "o informado."
            RETURN .F.
        ENDIF

        IF !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor " + ALLTRIM(par_cAliasCursor) + ;
                " n" + CHR(227) + "o est" + CHR(225) + " aberto."
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)
            IF EOF()
                THIS.this_cMensagemErro = "Cursor " + ALLTRIM(par_cAliasCursor) + ;
                    " est" + CHR(225) + " vazio."
                loc_lSucesso = .F.
            ENDIF

            *-- Grupo de Estoque (campos cdgrestoque/dsgrestoque opcionais)
            IF TYPE("cdgrestoque") = "C"
                THIS.this_cCdGrestoque = TratarNulo(cdgrestoque, "C")
            ENDIF
            IF TYPE("dsgrestoque") = "C"
                THIS.this_cDsGrestoque = TratarNulo(dsgrestoque, "C")
            ENDIF

            *-- Estoque (cdestoque/dsestoque opcionais)
            IF TYPE("cdestoque") = "C"
                THIS.this_cCdEstoque = TratarNulo(cdestoque, "C")
            ENDIF
            IF TYPE("dsestoque") = "C"
                THIS.this_cDsEstoque = TratarNulo(dsestoque, "C")
            ENDIF

            *-- Unidade (cunis/dunis opcionais)
            IF TYPE("cunis") = "C"
                THIS.this_cGrupo     = TratarNulo(cunis, "C")
            ENDIF
            IF TYPE("dunis") = "C"
                THIS.this_cGrupoDesc = TratarNulo(dunis, "C")
            ENDIF

            *-- Data de referencia
            IF TYPE("datafiltro") = "D"
                THIS.this_dData = NVL(datafiltro, {})
            ENDIF

            *-- Moeda (cmoes/dmoes opcionais)
            IF TYPE("cmoes") = "C"
                THIS.this_cMoeda     = TratarNulo(cmoes, "C")
            ENDIF
            IF TYPE("dmoes") = "C"
                THIS.this_cMoedaDesc = TratarNulo(dmoes, "C")
            ENDIF

            *-- Data da cotacao
            IF TYPE("dtcotacao") = "D"
                THIS.this_dDtCotacao = NVL(dtcotacao, {})
            ENDIF

            *-- Opcoes numericas (1=Sim / 2=Nao)
            IF TYPE("dadoscotacao") = "N"
                THIS.this_nDadosCotacao = NVL(dadoscotacao, 1)
            ENDIF
            IF TYPE("opcfator") = "N"
                THIS.this_nOpcFator = NVL(opcfator, 1)
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar filtros do cursor: " + ;
                loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - BLOQUEADO: relatorio nao persiste dados
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: relat" + CHR(243) + ;
            "rios n" + CHR(227) + "o gravam registros."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - BLOQUEADO: relatorio nao persiste dados
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: relat" + CHR(243) + ;
            "rios n" + CHR(227) + "o alteram registros."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha todos os cursores abertos pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("dbCabecalho")
            USE IN dbCabecalho
        ENDIF
        IF USED("dbRelatorio")
            USE IN dbRelatorio
        ENDIF
        IF USED("cursor_4c_TempMoe")
            USE IN cursor_4c_TempMoe
        ENDIF
        IF USED("cursor_4c_dbRelat")
            USE IN cursor_4c_dbRelat
        ENDIF
        IF USED("cursor_4c_sigEmpReeun")
            USE IN cursor_4c_sigEmpReeun
        ENDIF
        IF USED("cursor_4c_SigCdProRu")
            USE IN cursor_4c_SigCdProRu
        ENDIF
        IF USED("cursor_4c_TmpSaldoRu")
            USE IN cursor_4c_TmpSaldoRu
        ENDIF
        IF USED("cursor_4c_TmpSaldoAll")
            USE IN cursor_4c_TmpSaldoAll
        ENDIF
        IF USED("cursor_4c_TmpProAll")
            USE IN cursor_4c_TmpProAll
        ENDIF
        IF USED("cursor_4c_TmpHisAll")
            USE IN cursor_4c_TmpHisAll
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

