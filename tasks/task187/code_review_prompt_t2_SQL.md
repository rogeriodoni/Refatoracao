# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (5)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GLOBALIZAS, ACESSO, CODTGOPS, RNOPS, OPERS, CITEM2, EMPDOPNUMS, QTBAIXAS, CPROS, NUMPS, DOPES, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GLOBALIZAS, ACESSO, CODTGOPS, RNOPS, OPERS, CITEM2, EMPDOPNUMS, QTBAIXAS, CPROS, NUMPS, DOPES, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CGRUS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GLOBALIZAS, ACESSO, CODTGOPS, RNOPS, OPERS, CITEM2, EMPDOPNUMS, QTBAIXAS, CPROS, NUMPS, DOPES, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GLOBALIZAS, ACESSO, CODTGOPS, RNOPS, OPERS, CITEM2, EMPDOPNUMS, QTBAIXAS, CPROS, NUMPS, DOPES, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GLOBALIZAS, ACESSO, CODTGOPS, RNOPS, OPERS, CITEM2, EMPDOPNUMS, QTBAIXAS, CPROS, NUMPS, DOPES, CITENS

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
		lcQuery = [Select b.OpeGops, b.CodTgOps, a.Dopes, a.NDopes, a.Globalizas, a.Reservas, a.Opers, 0 as  Acesso, b.chkObs, c.carcompos ] + ;
				    [From SigCdOpe a Left Join SigOpCdd b On b.dopes = a.dopes ] + ;
				    [Left Join SigOpCdc c On a.dopes = c.dopes ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpOper2') < 1)
		Select TmpOper2
		Select * From TmpOper2 Into Cursor TmpOper ReadWrite
		Select TmpOper
		lcSql = [Select 0 as Acesso, * From SigInTgo ]
		If (ThisForm.poDataMgr.SqlExecute(lcSql, 'TmpTpGop') < 1)
		Select TmpTpGop
		Select * From TmpTpGop Where Acesso = 1 Into Cursor CrTmpTpGop ReadWrite
		Select CrTmpTpGop
Select crSigCdPam
Select TmpOper
=Seek(_lcTpGOp,'CrTmpTpGOp')
Insert Into DbParam (CodTgOps, OpZers, EntPes ) Values ;
Select TmpOper
	lcQuery = [Select Emps, Dopes, Numes, Datas, PrazoEnts, GrupoOs, ] + ;
			    [From SigMvCab ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TempEest') < 1)
	Select TempEest
		oProg.Update(.t.)
		Select TempEestI
			lcQuery = [Select * ] + ;
					    [From SigMvIts ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TempEsti2') < 1)
			Select TempEsti2
				Select TempEesti
					Insert Into TmpItens (Emps, Dopes, Numes, CPros, Qtds, Saldo, Obs, Peso, Linhas, Citens, Notas, Dpros, Reffs) ;
						lcQuery = [Select Sum(qtds) as total from SigPrMtz where Cpros = ?TempEestI.CPros]
						If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigPrMtz') < 1)
						Select crSigPrMtz
						If Not Seek(TempEestI.Cpros, 'Produtos', 'CPros')
							Insert Into Produtos (Cpros, DPros) Values (TempEestI.Cpros, crSigCdPro.Dpros)
				Select TempEsti2
						Insert Into TmpItens (Emps, Dopes, Numes, CPros, Qtds, Saldo, Obs, Peso, Linhas, ;
							lcQuery = [Select Sum(qtds) as total from SigPrMtz where Cpros = ?TempEestI.CPros]
							If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigPrMtz') < 1)
							Select crSigPrMtz
							If Not Seek(TempEestI.Cpros, 'Produtos', 'CPros')
								Insert Into Produtos (Cpros, DPros) Values (TempEestI.Cpros, crSigCdPro.Dpros)
			Insert Into TmpCabec (Flag, Emps, Dopes, Numes, Grupo, Conta, Grupov, Contav, Datas, Entregas, ;
Select TmpOper
	Select * From TmpOper Where CodTgOps = lcCodigo Into Cursor xTmpOper ReadWrite
	Select * From TmpOper Into Cursor xTmpOper ReadWrite
Select xTmpOper
If Not Empty(This.Value) And Not Seek(This.Value, 'xTmpOper', 'Dopes')
	lcSql = [Select Numps From SigOpPic Where Numps = ]+Str(This.Value)
	If (ThisForm.poDataMgr.SqlExecute(lcSql, 'TmpOpi') < 1)
If Not Empty(This.Value) And Not Seek(This.Value, 'crTmpTpGop', 'Codigos')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGlo.prg) - TRECHOS RELEVANTES PARA PASS SQL (1989 linhas total):

*-- Linhas 99 a 117:
99:             *-- Determinar visibilidade futura do Chec_pedra (criado na Fase 4)
100:             *-- Condicao original: DopEmphs E DopReqcs E DopPedcs E TransfRes preenchidos
101:             IF USED("crSigCdPam") AND NOT EOF("crSigCdPam")
102:                 SELECT crSigCdPam
103:                 THIS.this_lMostrarChkPedra = ;
104:                     (NOT EMPTY(ALLTRIM(crSigCdPam.DopEmphs)) AND ;
105:                      NOT EMPTY(ALLTRIM(crSigCdPam.DopReqcs)) AND ;
106:                      NOT EMPTY(ALLTRIM(crSigCdPam.DopPedcs)) AND ;
107:                      NOT EMPTY(ALLTRIM(crSigCdPam.TransfRes)))
108:             ENDIF
109: 
110:             *-- Carregar empresa padrao e popular BO
111:             loc_cEmp = ALLTRIM(go_4c_Sistema.cCodEmpresa)
112:             THIS.this_oBusinessObject.CarregarEmpresa(loc_cEmp)
113: 
114:             *-- Montar estrutura visual do form
115:             THIS.ConfigurarCabecalho()
116:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
117:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption  = THIS.Caption

*-- Linhas 282 a 300:
282:         LOCAL loc_lGlobAutos2
283:         loc_lGlobAutos2 = .F.
284:         IF USED("crSigCdPam") AND NOT EOF("crSigCdPam")
285:             SELECT crSigCdPam
286:             loc_lGlobAutos2 = (crSigCdPam.GlobAutos = 2 AND NOT THIS.this_lReserva)
287:         ENDIF
288: 
289:         *-- Container1 legado: Tipo de O.P. - habilitado so no modo GerPorTp
290:         THIS.AddObject("cnt_4c_TipoOp", "Container")
291:         WITH THIS.cnt_4c_TipoOp
292:             .Top         = 164
293:             .Left        = 139
294:             .Width       = 346
295:             .Height      = 25
296:             .BackStyle   = 0
297:             .BorderWidth = 0
298:             .Enabled     = THIS.this_lGerPorTp
299:             .Visible     = .T.
300:         ENDWITH

*-- Linhas 973 a 991:
973: 
974:             *-- Previsao de entrega: data atual + PrevProds dias (parametro SigCdPam)
975:             IF USED("crSigCdPam") AND NOT EOF("crSigCdPam")
976:                 SELECT crSigCdPam
977:                 THIS.cnt_4c_Previsao.txt_4c_Previsao.Value = DATE() + crSigCdPam.PrevProds
978:             ENDIF
979: 
980:             *-- Data de geracao: data atual (apenas se nao modo automatico)
981:             IF NOT THIS.this_lAutomatico
982:                 THIS.cnt_4c_Previsao.txt_4c_Geracao.Value = DATE()
983:             ENDIF
984: 
985:             *-- Checkbox pedras: visibilidade calculada em InicializarForm
986:             THIS.cnt_4c_Empresa.chk_4c_NaoEmpPedra.Visible = THIS.this_lMostrarChkPedra
987: 
988:             *-- Tipo de OP: pre-selecionar se GerPorTp e apenas 1 tipo disponivel
989:             IF THIS.this_lGerPorTp AND NOT EMPTY(THIS.this_oBusinessObject.this_cTpGOp)
990:                 THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value = THIS.this_oBusinessObject.this_cTpGOp
991:             ENDIF

*-- Linhas 1045 a 1063:
1045: 
1046:         *-- Validar numero OP manual (GlobAutos=2)
1047:         IF USED("crSigCdPam") AND NOT EOF("crSigCdPam")
1048:             SELECT crSigCdPam
1049:             loc_nGlobAutos = crSigCdPam.GlobAutos
1050:             IF loc_nGlobAutos = 2 AND NOT THIS.this_lReserva
1051:                 IF THIS.cnt_4c_Op.txt_4c_Nop.Value = 0
1052:                     MsgAviso("O N" + CHR(250) + "mero da OP " + CHR(233) + " Manual e Deve Ser Preenchido!!!", "Aviso")
1053:                     THIS.cnt_4c_Op.txt_4c_Nop.SetFocus
1054:                     RETURN
1055:                 ENDIF
1056:             ENDIF
1057:         ENDIF
1058: 
1059:         *-- Validar tipo de OP (obrigatorio no modo GerPorTp)
1060:         IF THIS.this_lGerPorTp AND EMPTY(ALLTRIM(THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value))
1061:             MsgAviso("O Tipo de Gera" + CHR(231) + CHR(227) + "o da OP " + CHR(233) + ;
1062:                      " Obrigat" + CHR(243) + "rio ser Preenchido!!!", "Aviso")
1063:             THIS.cnt_4c_TipoOp.txt_4c_TpGOp.SetFocus

*-- Linhas 1126 a 1170:
1126:         loc_cVal = ALLTRIM(THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value)
1127:         *-- Tentar SEEK direto antes de abrir picker
1128:         IF NOT EMPTY(loc_cVal) AND USED("CrTmpTpGop")
1129:             SELECT CrTmpTpGop
1130:             IF SEEK(loc_cVal, "CrTmpTpGop", "Codigos")
1131:                 RETURN
1132:             ENDIF
1133:         ENDIF
1134:         IF NOT USED("CrTmpTpGop")
1135:             MsgAviso("Tipos de O.P. n" + CHR(227) + "o carregados.", "Aviso")
1136:             RETURN
1137:         ENDIF
1138:         *-- Pre-popular cursor e abrir picker
1139:         IF USED("cursor_4c_TpGOp")
1140:             USE IN cursor_4c_TpGOp
1141:         ENDIF
1142:         SELECT Codigos, Descs FROM CrTmpTpGop INTO CURSOR cursor_4c_TpGOp READWRITE
1143:         SELECT cursor_4c_TpGOp
1144:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1145:         IF VARTYPE(loc_oBusca) = "O"
1146:             WITH loc_oBusca
1147:                 .this_cCursorDestino = "cursor_4c_TpGOp"
1148:                 .this_cTitulo        = "Tipos de Gera" + CHR(231) + CHR(227) + "o de OP"
1149:                 .this_cCampoBusca    = "Codigos"
1150:                 .this_cValorBusca    = loc_cVal
1151:                 .mAddColuna("Codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1152:                 .mAddColuna("Descs",   "                              ", "Descri" + CHR(231) + CHR(227) + "o")
1153:                 .Show()
1154:                 IF .this_lSelecionou
1155:                     SELECT cursor_4c_TpGOp
1156:                     THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value = ALLTRIM(cursor_4c_TpGOp.Codigos)
1157:                 ELSE
1158:                     THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value = ""
1159:                 ENDIF
1160:             ENDWITH
1161:             loc_oBusca = .NULL.
1162:         ENDIF
1163:     ENDPROC
1164: 
1165:     *--------------------------------------------------------------------------
1166:     * TxtOperacaoKeyPress - lookup operacao (TmpOper - cursor VFP local)
1167:     *--------------------------------------------------------------------------
1168:     PROCEDURE TxtOperacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1169:         LOCAL loc_cVal, loc_cTpGOp, loc_oBusca
1170:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115

*-- Linhas 1187 a 1227:
1187:         ENDIF
1188:         IF THIS.this_lGerPorTp
1189:             loc_cTpGOp = ALLTRIM(THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value)
1190:             SELECT Dopes, NDopes FROM TmpOper WHERE CodTgOps = loc_cTpGOp INTO CURSOR cursor_4c_Oper READWRITE
1191:         ELSE
1192:             SELECT Dopes, NDopes FROM TmpOper INTO CURSOR cursor_4c_Oper READWRITE
1193:         ENDIF
1194:         SELECT cursor_4c_Oper
1195:         INDEX ON Dopes TAG Dopes
1196:         *-- Tentar SEEK direto
1197:         IF SEEK(loc_cVal, "cursor_4c_Oper", "Dopes")
1198:             RETURN
1199:         ENDIF
1200:         *-- Abrir picker
1201:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1202:         IF VARTYPE(loc_oBusca) = "O"
1203:             WITH loc_oBusca
1204:                 .this_cCursorDestino = "cursor_4c_Oper"
1205:                 .this_cTitulo        = "Cadastro de Opera" + CHR(231) + CHR(245) + "es"
1206:                 .this_cCampoBusca    = "Dopes"
1207:                 .this_cValorBusca    = loc_cVal
1208:                 .mAddColuna("Dopes",  "", "Opera" + CHR(231) + CHR(227) + "o")
1209:                 .mAddColuna("NDopes", "XXXXXX", "C" + CHR(243) + "digo")
1210:                 .Show()
1211:                 IF .this_lSelecionou
1212:                     SELECT cursor_4c_Oper
1213:                     THIS.cnt_4c_Operacao.txt_4c_Operacao.Value = ALLTRIM(cursor_4c_Oper.Dopes)
1214:                 ELSE
1215:                     THIS.cnt_4c_Operacao.txt_4c_Operacao.Value   = ""
1216:                     THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value  = 0
1217:                     THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value  = 0
1218:                 ENDIF
1219:             ENDWITH
1220:             loc_oBusca = .NULL.
1221:         ENDIF
1222:     ENDPROC
1223: 
1224:     *--------------------------------------------------------------------------
1225:     * TxtOperacaoiKeyPress - auto-popula faixa final quando faixa inicial preenchida
1226:     *--------------------------------------------------------------------------
1227:     PROCEDURE TxtOperacaoiKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 1252 a 1270:
1252:                 .mAddColuna("descrs",  "                              ", "Descri" + CHR(231) + CHR(227) + "o")
1253:                 .Show()
1254:                 IF .this_lSelecionou
1255:                     SELECT cursor_4c_GrpConta
1256:                     THIS.cnt_4c_Conta.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_GrpConta.codigos)
1257:                 ELSE
1258:                     THIS.cnt_4c_Conta.txt_4c_Grupo.Value = ""
1259:                 ENDIF
1260:             ENDWITH
1261:             loc_oBusca = .NULL.
1262:         ENDIF
1263:     ENDPROC
1264: 
1265:     *--------------------------------------------------------------------------
1266:     * TxtContaKeyPress - lookup conta por codigo IClis (SigCdCli)
1267:     *--------------------------------------------------------------------------
1268:     PROCEDURE TxtContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1269:         LOCAL loc_cVal, loc_oBusca
1270:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115

*-- Linhas 1280 a 1298:
1280:                 .mAddColuna("RClis", "                                        ", "Nome")
1281:                 .Show()
1282:                 IF .this_lSelecionou
1283:                     SELECT cursor_4c_CliConta
1284:                     THIS.cnt_4c_Conta.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_CliConta.IClis)
1285:                     THIS.cnt_4c_Conta.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_CliConta.RClis)
1286:                 ELSE
1287:                     THIS.cnt_4c_Conta.txt_4c_Conta.Value  = ""
1288:                     THIS.cnt_4c_Conta.txt_4c_Dconta.Value = ""
1289:                 ENDIF
1290:             ENDWITH
1291:             loc_oBusca = .NULL.
1292:         ENDIF
1293:     ENDPROC
1294: 
1295:     *--------------------------------------------------------------------------
1296:     * TxtDcontaKeyPress - lookup conta por nome RClis (apenas quando Conta vazia)
1297:     *--------------------------------------------------------------------------
1298:     PROCEDURE TxtDcontaKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 1313 a 1331:
1313:                 .mAddColuna("RClis", "                                        ", "Nome")
1314:                 .Show()
1315:                 IF .this_lSelecionou
1316:                     SELECT cursor_4c_CliDconta
1317:                     THIS.cnt_4c_Conta.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_CliDconta.IClis)
1318:                     THIS.cnt_4c_Conta.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_CliDconta.RClis)
1319:                 ELSE
1320:                     THIS.cnt_4c_Conta.txt_4c_Conta.Value  = ""
1321:                     THIS.cnt_4c_Conta.txt_4c_Dconta.Value = ""
1322:                 ENDIF
1323:             ENDWITH
1324:             loc_oBusca = .NULL.
1325:         ENDIF
1326:     ENDPROC
1327: 
1328:     *--------------------------------------------------------------------------
1329:     * TxtGrupoRespKeyPress - lookup grupo contabil (SigCdGcr) para Vendedor
1330:     *--------------------------------------------------------------------------
1331:     PROCEDURE TxtGrupoRespKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 1343 a 1361:
1343:                 .mAddColuna("descrs",  "                              ", "Descri" + CHR(231) + CHR(227) + "o")
1344:                 .Show()
1345:                 IF .this_lSelecionou
1346:                     SELECT cursor_4c_GrpResp
1347:                     THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value = ALLTRIM(cursor_4c_GrpResp.codigos)
1348:                 ELSE
1349:                     THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value = ""
1350:                 ENDIF
1351:             ENDWITH
1352:             loc_oBusca = .NULL.
1353:         ENDIF
1354:     ENDPROC
1355: 
1356:     *--------------------------------------------------------------------------
1357:     * TxtContaRespKeyPress - lookup vendedor por codigo IClis (SigCdCli)
1358:     *--------------------------------------------------------------------------
1359:     PROCEDURE TxtContaRespKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1360:         LOCAL loc_cVal, loc_oBusca
1361:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115

*-- Linhas 1371 a 1389:
1371:                 .mAddColuna("RClis", "                                        ", "Nome")
1372:                 .Show()
1373:                 IF .this_lSelecionou
1374:                     SELECT cursor_4c_CliResp
1375:                     THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = ALLTRIM(cursor_4c_CliResp.IClis)
1376:                     THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ALLTRIM(cursor_4c_CliResp.RClis)
1377:                 ELSE
1378:                     THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = ""
1379:                     THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ""
1380:                 ENDIF
1381:             ENDWITH
1382:             loc_oBusca = .NULL.
1383:         ENDIF
1384:     ENDPROC
1385: 
1386:     *--------------------------------------------------------------------------
1387:     * TxtDcontaRespKeyPress - lookup vendedor por nome RClis (apenas quando ContaResp vazia)
1388:     *--------------------------------------------------------------------------
1389:     PROCEDURE TxtDcontaRespKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 1404 a 1422:
1404:                 .mAddColuna("RClis", "                                        ", "Nome")
1405:                 .Show()
1406:                 IF .this_lSelecionou
1407:                     SELECT cursor_4c_CliDcontaResp
1408:                     THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = ALLTRIM(cursor_4c_CliDcontaResp.IClis)
1409:                     THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ALLTRIM(cursor_4c_CliDcontaResp.RClis)
1410:                 ELSE
1411:                     THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = ""
1412:                     THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ""
1413:                 ENDIF
1414:             ENDWITH
1415:             loc_oBusca = .NULL.
1416:         ENDIF
1417:     ENDPROC
1418: 
1419:     *--------------------------------------------------------------------------
1420:     * TxtCdEmpresaKeyPress - lookup empresa por codigo Cemps (SigCdEmp)
1421:     *   Apenas se AlterEmp = .T.
1422:     *--------------------------------------------------------------------------

*-- Linhas 1438 a 1456:
1438:                 .mAddColuna("Razas", "                                        ", "Raz" + CHR(227) + "o Social")
1439:                 .Show()
1440:                 IF .this_lSelecionou
1441:                     SELECT cursor_4c_Emp
1442:                     THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_Emp.Cemps)
1443:                     THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_Emp.Razas)
1444:                 ELSE
1445:                     THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = ""
1446:                     THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = ""
1447:                 ENDIF
1448:             ENDWITH
1449:             loc_oBusca = .NULL.
1450:         ENDIF
1451:     ENDPROC
1452: 
1453:     *--------------------------------------------------------------------------
1454:     * TxtDsEmpresaKeyPress - lookup empresa por razao social Razas (SigCdEmp)
1455:     *   Apenas se AlterEmp = .T. e CdEmpresa vazio
1456:     *--------------------------------------------------------------------------

*-- Linhas 1475 a 1493:
1475:                 .mAddColuna("Razas", "                                        ", "Raz" + CHR(227) + "o Social")
1476:                 .Show()
1477:                 IF .this_lSelecionou
1478:                     SELECT cursor_4c_EmpDs
1479:                     THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_EmpDs.Cemps)
1480:                     THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpDs.Razas)
1481:                 ELSE
1482:                     THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = ""
1483:                     THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = ""
1484:                 ENDIF
1485:             ENDWITH
1486:             loc_oBusca = .NULL.
1487:         ENDIF
1488:     ENDPROC
1489: 
1490:     *--------------------------------------------------------------------------
1491:     * TxtNopKeyPress - valida numero de OP: nao pode ja existir em SigOpPic
1492:     *--------------------------------------------------------------------------
1493:     PROCEDURE TxtNopKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 1559 a 1577:
1559:         LOCAL loc_lGlobAutos2
1560:         loc_lGlobAutos2 = .F.
1561:         IF USED("crSigCdPam") AND NOT EOF("crSigCdPam")
1562:             SELECT crSigCdPam
1563:             loc_lGlobAutos2 = (crSigCdPam.GlobAutos = 2 AND NOT THIS.this_lReserva)
1564:         ENDIF
1565: 
1566:         *-- 1. Cabecalho cinza (idempotente)
1567:         IF NOT PEMSTATUS(THIS, "cnt_4c_Cabecalho", 5)
1568:             THIS.ConfigurarCabecalho()
1569:         ENDIF
1570: 
1571:         *-- 2. Shape decorativo
1572:         IF NOT PEMSTATUS(THIS, "shp_4c_Shape3", 5)
1573:             THIS.ConfigurarShape()
1574:         ENDIF
1575: 
1576:         *-- 3. Botoes principais (Processar / Encerrar)
1577:         IF NOT PEMSTATUS(THIS, "cmd_4c_Processar", 5)


### BO (C:\4c\projeto\app\classes\SigPrGloBO.prg):
*==============================================================================
* SigPrGloBO.prg - Business Object para Processamento de O.P.
* Data: 2026-07-03
* Tabela: SigMvCab (principal - registros processados)
* Legado: SigPrGlo.SCX (form operacional)
*==============================================================================

DEFINE CLASS SigPrGloBO AS BusinessBase

    *--------------------------------------------------------------------------
    *-- Modo de operacao (passados via parametros na abertura do form)
    *--------------------------------------------------------------------------
    this_lReserva     = .F.    && Modo reserva automatica (_Reserva)
    this_lAutomatico  = .F.    && Modo automatico (_Autom)
    this_lPorDestino  = .F.    && Por destino (_PorDestino)
    this_lGerPorTp    = .F.    && Gerar por tipo de OP (pTipo)
    this_lAlterEmp    = .T.    && Permite alterar empresa (AlterEmp)

    *--------------------------------------------------------------------------
    *-- Filtros de periodo de emissao
    *--------------------------------------------------------------------------
    this_dDataei      = {}     && Data emissao inicial (GetDataei)
    this_dDataef      = {}     && Data emissao final (GetDataef)

    *--------------------------------------------------------------------------
    *-- Filtros de periodo de previsao de entrega
    *--------------------------------------------------------------------------
    this_dDatapi      = {}     && Data previsao entrega inicial (GetDatapi)
    this_dDatapf      = {}     && Data previsao entrega final (GetDatapf)

    *--------------------------------------------------------------------------
    *-- Filtro de operacao
    *--------------------------------------------------------------------------
    this_cOperacao    = ""     && Codigo da operacao (Get_Operacao)
    this_nOperacaoi   = 0      && Numero OP inicial - faixa (Get_Operacaoi)
    this_nOperacaof   = 0      && Numero OP final - faixa (Get_Operacaof)

    *--------------------------------------------------------------------------
    *-- Conta / Movimentacao (cliente)
    *--------------------------------------------------------------------------
    this_cGrupoConta  = ""     && Grupo da conta (Conta.Get_grupo)
    this_cConta       = ""     && Conta (Conta.Get_conta)
    this_cDconta      = ""     && Descricao da conta (Conta.Get_dconta)

    *--------------------------------------------------------------------------
    *-- Responsavel / Vendedor
    *--------------------------------------------------------------------------
    this_cGrupoResp   = ""     && Grupo do responsavel (Responsavel.Get_grupo)
    this_cContaResp   = ""     && Conta do responsavel (Responsavel.Get_conta)
    this_cDcontaResp  = ""     && Descricao do responsavel (Responsavel.Get_dconta)

    *--------------------------------------------------------------------------
    *-- Empresa
    *--------------------------------------------------------------------------
    this_cCdEmpresa   = ""     && Codigo da empresa (Empresa.get_cd_empresa)
    this_cDsEmpresa   = ""     && Razao social da empresa (Empresa.get_ds_empresa)
    this_nNaoEmpPedra = 0      && Nao empenhar pedras: 0=nao, 1=sim (Empresa.Chec_pedra)

    *--------------------------------------------------------------------------
    *-- Tipo de geracao de OP
    *--------------------------------------------------------------------------
    this_cTpGOp       = ""     && Codigo do tipo de geracao (Container1.Get_TpGOp)

    *--------------------------------------------------------------------------
    *-- Previsao de entrega e data de geracao
    *--------------------------------------------------------------------------
    this_dPrevisao    = {}     && Data de previsao de entrega (Cnt_Previsao.GetPrevisao)
    this_dGeracao     = {}     && Data de geracao (Cnt_Previsao.GetGeracao)

    *--------------------------------------------------------------------------
    *-- Numero da OP manual (GlobAutos = 2)
    *--------------------------------------------------------------------------
    this_nNop         = 0      && Numero da OP manual (Cnt_Op.GetNop)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = "Numes"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - carrega propriedades a partir de cursor com registros de OP
    * Usado quando o form recarrega um contexto ja gerado a partir de SigOpPic
    * ou de cursor temporario TmpCabec/TmpItens. Popula filtros base.
    * Retorna .T. se pelo menos os campos essenciais foram carregados.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(par_cAliasCursor) OR NOT USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)
        IF EOF()
            RETURN .F.
        ENDIF

        *-- Empresa (todos os cursores relevantes tem coluna Emps)
        IF TYPE(par_cAliasCursor + ".Emps") = "C"
            THIS.this_cCdEmpresa = NVL(ALLTRIM(EVALUATE(par_cAliasCursor + ".Emps")), "")
            loc_lSucesso = .T.
        ENDIF

        *-- Operacao (Dopes) e movimento (Numes) - opcionais conforme cursor origem
        IF TYPE(par_cAliasCursor + ".Dopes") = "C"
            THIS.this_cOperacao  = NVL(ALLTRIM(EVALUATE(par_cAliasCursor + ".Dopes")), "")
            THIS.this_nOperacaoi = 0
            THIS.this_nOperacaof = 0
        ENDIF
        IF TYPE(par_cAliasCursor + ".Datas") = "D"
            THIS.this_dGeracao = NVL(EVALUATE(par_cAliasCursor + ".Datas"), DATE())
        ENDIF
        IF TYPE(par_cAliasCursor + ".Entregas") = "D"
            THIS.this_dPrevisao = NVL(EVALUATE(par_cAliasCursor + ".Entregas"), DATE())
        ENDIF
        IF TYPE(par_cAliasCursor + ".Grupo") = "C"
            THIS.this_cGrupoConta = NVL(ALLTRIM(EVALUATE(par_cAliasCursor + ".Grupo")), "")
        ENDIF
        IF TYPE(par_cAliasCursor + ".Conta") = "C"
            THIS.this_cConta = NVL(ALLTRIM(EVALUATE(par_cAliasCursor + ".Conta")), "")
        ENDIF
        IF TYPE(par_cAliasCursor + ".DConta") = "C"
            THIS.this_cDconta = NVL(ALLTRIM(EVALUATE(par_cAliasCursor + ".DConta")), "")
        ENDIF
        IF TYPE(par_cAliasCursor + ".Grupov") = "C"
            THIS.this_cGrupoResp = NVL(ALLTRIM(EVALUATE(par_cAliasCursor + ".Grupov")), "")
        ENDIF
        IF TYPE(par_cAliasCursor + ".Contav") = "C"
            THIS.this_cContaResp = NVL(ALLTRIM(EVALUATE(par_cAliasCursor + ".Contav")), "")
        ENDIF
        IF TYPE(par_cAliasCursor + ".Numes") = "N"
            THIS.this_nNop = NVL(EVALUATE(par_cAliasCursor + ".Numes"), 0)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarDataHoraSQL - retorna 'YYYY-MM-DD HH:MM:SS' com aspas simples
    * par_cHora: ex "23:59:59" ou "00:00:00"
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarDataHoraSQL(par_dData, par_cHora)
        LOCAL loc_cBase
        IF EMPTY(par_dData) OR VARTYPE(par_dData) != "D"
            RETURN "NULL"
        ENDIF
        *-- FormatarDataSQL retorna 'YYYY-MM-DD' (12 chars, com aspas)
        *-- Remove aspas de fechamento e adiciona hora
        loc_cBase = FormatarDataSQL(par_dData)
        RETURN SUBSTR(loc_cBase, 1, LEN(loc_cBase)-1) + " " + par_cHora + "'"
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros - carrega dados de configuracao para o processamento
    * Cria cursores: crSigCdPam, crSigCdPac, TmpOper, CrTmpTpGop
    * par_lGerPorTp: .T. se modo de geracao por tipo de OP
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametros(par_lGerPorTp)
        LOCAL loc_lSucesso, loc_cSQL, loc_cCampos, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Parametros de OP (SigCdPam)
            loc_cCampos = "DopEmphs, DopReqcs, DopPedcs, DopComps, TransfRes, GrPadClis, " + ;
                          "DoppPads, DopTrfCps, GrPadVens, PrevProds, GrupoEsts, ContaEsts, " + ;
                          "GruReservs, ConReservs, AgrupEmph, DoppServs, mascnums, GruEstps, " + ;
                          "ConEstps, transfencs, Ouros, GruConfs, ConConfs, GlobAutos, " + ;
                          "DopEntAus, TpOpEntAus, AutComps"
            loc_cSQL = "SELECT " + loc_cCampos + " FROM SigCdPam"
            IF USED("crSigCdPam")
                USE IN crSigCdPam
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdPam") < 1
                MsgErro("Falha ao carregar par" + CHR(226) + "metros de OP (SigCdPam).", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Parametros de componentes (SigCdPac)
            loc_cSQL = "SELECT * FROM SigCdPac"
            IF USED("crSigCdPac")
                USE IN crSigCdPac
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdPac") < 1
                MsgErro("Falha ao carregar par" + CHR(226) + "metros de componentes (SigCdPac).", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Operacoes disponiveis (SigCdOpe + SigOpCdd + SigOpCdc -> TmpOper)
            loc_cSQL = "SELECT b.OpeGops, b.CodTgOps, a.Dopes, a.NDopes, a.Globalizas, " + ;
                       "a.Reservas, a.Opers, 0 AS Acesso, b.chkObs, c.carcompos " + ;
                       "FROM SigCdOpe a " + ;
                       "LEFT JOIN SigOpCdd b ON b.dopes = a.dopes " + ;
                       "LEFT JOIN SigOpCdc c ON a.dopes = c.dopes " + ;
                       "WHERE a.Globalizas IN (1, 2)"
            IF USED("TmpOper2")
                USE IN TmpOper2
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpOper2") < 1
                MsgErro("Falha ao carregar opera" + CHR(231) + CHR(245) + "es (SigCdOpe).", "Erro")
                loc_lSucesso = .F.
            ENDIF
            *-- Normalizar NULLs nos campos opcionais
            SELECT TmpOper2
            SCAN
                REPLACE CodTgOps WITH NVL(CodTgOps, " "), ;
                        OpeGops  WITH NVL(OpeGops, " ") IN TmpOper2
            ENDSCAN
            *-- Mover para TmpOper com indice
            IF USED("TmpOper")
                USE IN TmpOper
            ENDIF
            SELECT * FROM TmpOper2 INTO CURSOR TmpOper READWRITE
            USE IN TmpOper2
            SELECT TmpOper
            INDEX ON Dopes TAG Dopes
            GO TOP
            IF EOF()
                MsgAviso("Nenhuma Opera" + CHR(231) + CHR(227) + "o Configurada Para Processar " + ;
                         "Ordem de Produ" + CHR(231) + CHR(227) + "o!!!", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            *-- Tipos de OP com filtro de acesso (SigInTgo -> CrTmpTpGop)
            loc_cSQL = "SELECT 0 AS Acesso, * FROM SigInTgo"
            IF USED("TmpTpGop")
                USE IN TmpTpGop
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpTpGop") < 1
                MsgErro("Falha ao carregar tipos de OP (SigInTgo).", "Erro")
                loc_lSucesso = .F.
            ENDIF
            SELECT TmpTpGop
            SCAN
                IF fChecaAcesso("SIGPRGLOT", ALLTRIM(TmpTpGop.Codigos))
                    REPLACE Acesso WITH 1 IN TmpTpGop
                ENDIF
            ENDSCAN
            IF USED("CrTmpTpGop")
                USE IN CrTmpTpGop
            ENDIF
            SELECT * FROM TmpTpGop WHERE Acesso = 1 INTO CURSOR CrTmpTpGop READWRITE
            USE IN TmpTpGop
            SELECT CrTmpTpGop
            INDEX ON Codigos TAG Codigos
            GO TOP

            *-- Auto-selecionar tipo se GerPorTp e so ha um disponivel
            IF par_lGerPorTp AND RECCOUNT("CrTmpTpGop") = 1
                THIS.this_cTpGOp = ALLTRIM(CrTmpTpGop.Codigos)
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar par" + CHR(226) + "metros: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarEmpresa - carrega dados da empresa pelo codigo
    * Popula this_cCdEmpresa e this_cDsEmpresa
    *--------------------------------------------------------------------------
    PROCEDURE CarregarEmpresa(par_cCodEmp)
        LOCAL loc_cSQL, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(ALLTRIM(par_cCodEmp))
            IF USED("TempEmp")
                USE IN TempEmp
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "TempEmp") >= 1
                SELECT TempEmp
                IF NOT EOF()
                    THIS.this_cCdEmpresa = ALLTRIM(TempEmp.Cemps)
                    THIS.this_cDsEmpresa = ALLTRIM(TempEmp.Razas)
                    loc_lSucesso = .T.
                ENDIF
                USE IN TempEmp
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar empresa: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarNumeroOP - verifica se numero de OP ja existe em SigOpPic
    * Retorna .T. se DISPONIVEL (nao existe), .F. se JA EXISTE ou erro
    *--------------------------------------------------------------------------
    PROCEDURE ValidarNumeroOP(par_nNop)
        LOCAL loc_cSQL, loc_lDisponivel, loc_oErro
        loc_lDisponivel = .T.

        TRY
            loc_cSQL = "SELECT Numps FROM SigOpPic WHERE Numps = " + TRANSFORM(par_nNop)
            IF USED("TmpOpi")
                USE IN TmpOpi
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpOpi") >= 1
                IF RECCOUNT("TmpOpi") > 0
                    loc_lDisponivel = .F.
                ENDIF
                USE IN TmpOpi
            ELSE
                loc_lDisponivel = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar n" + CHR(250) + "mero de OP: " + loc_oErro.Message, "Erro")
            loc_lDisponivel = .F.
        ENDTRY

        RETURN loc_lDisponivel
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararCursoresProcessamento - cria cursores temporarios para Processar
    * TmpCabec, TmpItens, DBParam, SelPedra, Produtos
    *--------------------------------------------------------------------------
    PROCEDURE PrepararCursoresProcessamento()
        LOCAL loc_oErro
        TRY
            IF USED("DBParam")
                USE IN DBParam
            ENDIF
            IF USED("TmpCabec")
                USE IN TmpCabec
            ENDIF
            IF USED("TmpItens")
                USE IN TmpItens
            ENDIF
            IF USED("SelPedra")
                USE IN SelPedra
            ENDIF
            IF USED("Produtos")
                USE IN Produtos
            ENDIF

            SET NULL ON
            CREATE CURSOR DBParam (CodTgOps C(10) NULL, OpZers N(1,0) NULL, EntPes N(1,0) NULL)
            SET NULL OFF

            SET NULL ON
            CREATE CURSOR TmpCabec (Flag L, Emps C(3), Dopes C(20), Numes N(6,0), ;
                                     Grupo C(10), Conta C(10), Datas D NULL, ;
                                     Entregas D NULL, Grupov C(10), Contav C(10), ;
                                     Obs M NULL, Peso N(12,2), ;
                                     GrupoDs C(10), ContaDs C(10), DConta C(40), ;
                                     Notas C(6), Jobs C(10))
            SET NULL OFF
            INDEX ON DTOS(Entregas) + Emps + Dopes + STR(Numes,6) TAG Entrega
            INDEX ON Emps + Dopes + STR(Numes,6) TAG Empdopnum
            SET ORDER TO TAG Empdopnum

            SET NULL ON
            CREATE CURSOR SelPedra (Cpros C(14), Dpros C(40), Cunis C(3), ;
                                     Qtds N(12,3), Cpro2s C(14))
            SET NULL OFF

            CREATE CURSOR Produtos (Cpros C(14), Dpros C(40), cmats C(14))
            INDEX ON Cpros TAG Cpros

            SET NULL ON
            CREATE CURSOR TmpItens (Emps C(3), Dopes C(20), Numes N(6,0), ;
                                     CPros C(14), Qtds N(12,3), Saldo N(12,3), ;
                                     Peso N(9,3), Obs M NULL, Linhas C(10), ;
                                     CodCors C(4), CodTams C(4), Citens N(10,0), ;
                                     Notas C(6), dpros C(40), Reffs C(40))
            SET NULL OFF
            INDEX ON Linhas + Cpros TAG LinPro
            INDEX ON Cpros TAG Cpros
            INDEX ON Emps + Dopes + STR(Numes,6) TAG Empdopnum
            SET ORDER TO TAG Empdopnum

        CATCH TO loc_oErro
            MsgErro("Erro ao preparar cursores de processamento: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarOrdens - logica principal de processamento de OP
    * Usa this_* properties definidas pela form para os filtros.
    * Popula TmpCabec e TmpItens para uso pelo form SigPrGl2.
    * Retorna .T. se ha registros a processar, .F. caso contrario.
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarOrdens()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_Conde, loc_Condp, loc_cSQL
        LOCAL loc_cDateiSQL, loc_cDatefSQL, loc_cDatepiSQL, loc_cDatepfSQL
        LOCAL loc_Dopp, loc_lcTpGOp, loc_lcEmp
        LOCAL loc_Grupo, loc_Conta, loc_GrupoV, loc_ContaV
        LOCAL loc_GrupoG, loc_ContaG, loc_GrupoD, loc_ContaD
        LOCAL loc_Operacao, loc_Operacaoi, loc_Operacaof
        LOCAL loc_TPeso, loc_Processa, loc_Saldo, loc_Peso
        LOCAL loc_lcEdn, loc_lcCpo, loc_oProg, loc_xBaixa, loc_lnQtdTb
        LOCAL loc_pItn, loc_cDConta

        loc_lSucesso = .F.

        TRY
            THIS.PrepararCursoresProcessamento()

            *-- Coletar filtros das propriedades do BO
            SELECT crSigCdPam
            loc_Dopp       = crSigCdPam.DoppPads
            loc_lcTpGOp    = THIS.this_cTpGOp
            loc_lcEmp      = IIF(EMPTY(THIS.this_cCdEmpresa), go_4c_Sistema.cCodEmpresa, THIS.this_cCdEmpresa)
            loc_Grupo      = THIS.this_cGrupoConta
            loc_Conta      = THIS.this_cConta
            loc_GrupoV     = THIS.this_cGrupoResp
            loc_ContaV     = THIS.this_cContaResp
            loc_Operacao   = THIS.this_cOperacao
            loc_Operacaoi  = THIS.this_nOperacaoi
            loc_Operacaof  = THIS.this_nOperacaof

            *-- Carregar operacao padrao (SigCdOpd)
            loc_cSQL = "SELECT * FROM SigCdOpd WHERE Dopps = " + EscaparSQL(ALLTRIM(loc_Dopp))
            IF USED("crSigCdOpd")
                USE IN crSigCdOpd
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdOpd") < 1
                MsgErro("Falha ao carregar opera" + CHR(231) + CHR(227) + "o padr" + CHR(227) + "o (SigCdOpd).", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Formatar datas para SQL
            loc_cDateiSQL  = IIF(EMPTY(THIS.this_dDataei), "NULL", FormatarDataSQL(THIS.this_dDataei))
            loc_cDatefSQL  = IIF(EMPTY(THIS.this_dDataef), "NULL", THIS.FormatarDataHoraSQL(THIS.this_dDataef, "23:59:59"))
            loc_cDatepiSQL = IIF(EMPTY(THIS.this_dDatapi), "NULL", FormatarDataSQL(THIS.this_dDatapi))
            loc_cDatepfSQL = IIF(EMPTY(THIS.this_dDatapf), "NULL", THIS.FormatarDataHoraSQL(THIS.this_dDatapf, "23:59:59"))

            *-- Condicao de periodo de emissao
            IF EMPTY(THIS.this_dDataef)
                loc_Conde = ""
            ELSE
                IF EMPTY(THIS.this_dDataei)
                loc_Conde = "Datas <= " + loc_cDatefSQL + " AND "
            ELSE
                loc_Conde = "Datas BETWEEN " + loc_cDateiSQL + " AND " + loc_cDatefSQL + " AND "
                ENDIF
            ENDIF

            *-- Condicao de periodo de previsao de entrega
            IF EMPTY(THIS.this_dDatapi)
                IF EMPTY(THIS.this_dDatapf)
                    loc_Condp = ""
                ELSE
                    loc_Condp = "PrazoEnts <= " + loc_cDatepfSQL + " AND "
                ENDIF
            ELSE
                IF EMPTY(THIS.this_dDatapf)
                    loc_Condp = "PrazoEnts >= " + loc_cDatepiSQL + " AND "
                ELSE
                    loc_Condp = "PrazoEnts BETWEEN " + loc_cDatepiSQL + " AND " + loc_cDatepfSQL + " AND "
                ENDIF
            ENDIF

            *-- Inserir parametros de geracao em DBParam
            IF SEEK(ALLTRIM(loc_lcTpGOp), "CrTmpTpGop", "Codigos")
                INSERT INTO DBParam (CodTgOps, OpZers, EntPes) ;
                    VALUES (loc_lcTpGOp, ;
                            IIF(THIS.this_lGerPorTp, CrTmpTpGop.OpZers, crSigCdPac.OpZers), ;
                            IIF(THIS.this_lGerPorTp, CrTmpTpGop.EntPes, 0))
            ELSE
                INSERT INTO DBParam (CodTgOps, OpZers, EntPes) ;
                    VALUES (loc_lcTpGOp, crSigCdPac.OpZers, 0)
            ENDIF

            *-- Verificar operacoes dispon?veis
            SELECT TmpOper
            GO TOP
            IF EOF()
                MsgAviso("Nenhuma Opera" + CHR(231) + CHR(227) + "o Configurada Para Processar " + ;
                         "Ordem de Produ" + CHR(231) + CHR(227) + "o!!!", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            *-- Aplicar filtro de operacao especifica
            SET ORDER TO TAG Dopes IN TmpOper
            IF NOT EMPTY(loc_Operacao)
                SET KEY TO loc_Operacao IN TmpOper
            ENDIF

            *-- Iterar operacoes
            SELECT TmpOper
            SCAN
                IF THIS.this_lGerPorTp AND ALLTRIM(TmpOper.CodTgOps) <> ALLTRIM(loc_lcTpGOp)
                    LOOP
                ENDIF

                *-- Montar SQL para buscar movimentos desta operacao
                loc_cSQL = "SELECT Emps, Dopes, Numes, Datas, PrazoEnts, GrupoOs, " + ;
                           "ContaOs, GrupoDs, ContaDs, GrVends, Vends, Obses, rNops, Notas, Jobs " + ;
                           "FROM SigMvCab " + ;
                           "WHERE " + loc_Conde + loc_Condp + ;
                           "Emps = " + EscaparSQL(ALLTRIM(loc_lcEmp)) + " AND " + ;
                           "Dopes = " + EscaparSQL(ALLTRIM(TmpOper.Dopes)) + " AND "

                *-- Filtros de conta (cliente/destino conforme Globalizas)
                IF NOT EMPTY(loc_Grupo)
                    IF TmpOper.Globalizas = 1
                        loc_cSQL = loc_cSQL + "GrupoOs = " + EscaparSQL(ALLTRIM(loc_Grupo)) + " AND "
                    ENDIF
                    IF TmpOper.Globalizas = 2
                        loc_cSQL = loc_cSQL + "GrupoDs = " + EscaparSQL(ALLTRIM(loc_Grupo)) + " AND "
                    ENDIF
                ENDIF
                IF NOT EMPTY(loc_Conta)
                    IF TmpOper.Globalizas = 1
                        loc_cSQL = loc_cSQL + "ContaOs = " + EscaparSQL(ALLTRIM(loc_Conta)) + " AND "
                    ENDIF
                    IF TmpOper.Globalizas = 2
                        loc_cSQL = loc_cSQL + "ContaDs = " + EscaparSQL(ALLTRIM(loc_Conta)) + " AND "
                    ENDIF
                ENDIF
                *-- Filtros de vendedor (Responsavel)
                IF NOT EMPTY(loc_GrupoV)
                    loc_cSQL = loc_cSQL + "GrVends = " + EscaparSQL(ALLTRIM(loc_GrupoV)) + " AND "
                ENDIF
                IF NOT EMPTY(loc_ContaV)
                    loc_cSQL = loc_cSQL + "Vends = " + EscaparSQL(ALLTRIM(loc_ContaV)) + " AND "
                ENDIF
                *-- Apenas movimentos sem OP gerada
                loc_cSQL = loc_cSQL + "Nops = 0"

                IF USED("TempEest")
                    USE IN TempEest
                ENDIF
                IF SQLEXEC(gnConnHandle, loc_cSQL, "TempEest") < 1
                    MsgErro("Falha na conex" + CHR(227) + "o ao buscar movimentos (TempEest).", "Erro")
                    loc_lSucesso = .F.
                ENDIF

                *-- Barra de progresso por operacao
                SELECT TempEest
                loc_oProg = CREATEOBJECT("fwprogressbar", ;
                    "Processando Opera" + CHR(231) + CHR(227) + "o " + ALLTRIM(TmpOper.Dopes) + "...", ;
                    RECCOUNT())
                loc_oProg.Show()

                SCAN
                    loc_oProg.Update(.T.)

                    *-- Filtrar por faixa de numero de OP se especificada
                    IF NOT EMPTY(loc_Operacao)
                        IF loc_Operacaoi != 0 AND loc_Operacaof != 0 AND ;
                           NOT BETWEEN(TempEest.Numes, loc_Operacaoi, loc_Operacaof)
                            LOOP
                        ENDIF
                    ENDIF

                    *-- Grupo/Conta conforme tipo de globalizacao
                    IF TmpOper.Globalizas = 1
                        loc_GrupoG = ALLTRIM(TempEest.GrupoOs)
                        loc_ContaG = ALLTRIM(TempEest.ContaOs)
                    ELSE
                        loc_GrupoG = ALLTRIM(TempEest.GrupoDs)
                        loc_ContaG = ALLTRIM(TempEest.ContaDs)
                    ENDIF

                    *-- Pular movimentos com reserva automatica ja processada
                    IF THIS.this_lReserva AND TempEest.rNops > 0
                        LOOP
                    ENDIF

                    loc_TPeso    = 0
                    loc_Processa = .F.

                    *-- Buscar itens do movimento (SigMvItn)
                    loc_lcEdn = TempEest.Emps + TempEest.Dopes + STR(TempEest.Numes, 6)
                    loc_lcCpo = "CPros, CItens, Qtds, QtBaixas, QtProds, Pesos, " + ;
                                "Emps, Dopes, Numes, Obs, Notas, Dpros, Opers, Citem2"
                    loc_cSQL = "SELECT " + loc_lcCpo + " FROM SigMvItn " + ;
                               "WHERE EmpDopNums = " + EscaparSQL(loc_lcEdn)
                    IF USED("TempEestI")
                        USE IN TempEestI
                    ENDIF
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "TempEestI") < 1
                        MsgErro("Falha ao buscar itens do movimento (TempEestI).", "Erro")
                        loc_lSucesso = .F.
                    ENDIF

                    SELECT TempEestI
                    SCAN
                        *-- Filtrar por operacao interna se OPers = 3
                        IF TmpOper.OPers = 3 AND NOT EMPTY(TmpOper.OpeGops) AND ;
                           ALLTRIM(TempEestI.Opers) <> ALLTRIM(TmpOper.OpeGops)
                            LOOP
                        ENDIF
                        *-- Pular componentes de sub-montagem se carcompos = 5
                        IF TmpOper.carcompos = 5 AND TempEestI.Citem2 <> 0
                            LOOP
                        ENDIF

                        *-- Carregar dados do produto
                        loc_cSQL = "SELECT Pesoms, Linhas, QtdCpnts, DPros, Reffs, Cgrus " + ;
                                   "FROM SigCdPro WHERE CPros = " + EscaparSQL(ALLTRIM(TempEestI.CPros))
                        IF USED("crSigCdPro")
                            USE IN crSigCdPro
                        ENDIF
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdPro") < 1
                            MsgErro("Falha ao carregar produto (SigCdPro).", "Erro")
                            loc_lSucesso = .F.
                        ENDIF

                        *-- Carregar grupo do produto
                        loc_cSQL = "SELECT GeraTubs FROM SigCdGrp " + ;
                                   "WHERE CGrus = " + EscaparSQL(ALLTRIM(crSigCdPro.CGrus))
                        IF USED("crSigCdGrp")
                            USE IN crSigCdGrp
                        ENDIF
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdGrp") < 1
                            MsgErro("Falha ao carregar grupo do produto (SigCdGrp).", "Erro")
                            loc_lSucesso = .F.
                        ENDIF

                        loc_pItn   = TempEestI.CItens
                        loc_lnQtdTb = 0

                        *-- Buscar sub-itens (SigMvIts)
                        loc_cSQL = "SELECT * FROM SigMvIts " + ;
                                   "WHERE EmpDopNums = " + EscaparSQL(loc_lcEdn) + ;
                                   " AND CItens = " + FormatarNumeroSQL(loc_pItn)
                        IF USED("TempEsti2")
                            USE IN TempEsti2
                        ENDIF
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "TempEsti2") < 1
                            MsgErro("Falha ao buscar sub-itens (TempEsti2).", "Erro")
                            loc_lSucesso = .F.
                        ENDIF

                        SELECT TempEsti2
                        GO TOP
                        IF EOF("TempEsti2")
                            *-- Sem sub-itens: processar item principal
                            SELECT TempEestI
                            loc_xBaixa = IIF(QtBaixas > 0 AND QtBaixas >= QtProds, ;
                                             QtBaixas - QtProds, 0) + QtProds
                            loc_Saldo  = TempEestI.Qtds - loc_xBaixa
                            loc_Peso   = IIF(EMPTY(TempEestI.Pesos), crSigCdPro.Pesoms, TempEestI.Pesos)
                            IF loc_Saldo <> 0
                                INSERT INTO TmpItens ;
                                    (Emps, Dopes, Numes, CPros, Qtds, Saldo, Obs, Peso, ;
                                     Linhas, Citens, Notas, Dpros, Reffs) ;
                                    VALUES (TempEestI.Emps, TempEestI.Dopes, TempEestI.Numes, ;
                                            TempEestI.CPros, TempEestI.Qtds, loc_Saldo, ;
                                            TempEestI.Obs, loc_Peso, crSigCdPro.Linhas, ;
                                            TempEestI.Citens, TempEestI.Notas, TempEestI.Dpros, ;
                                            crSigCdPro.Reffs)
                                loc_TPeso    = loc_TPeso + (loc_Peso * loc_Saldo)
                                loc_Processa = .T.
                                *-- Verificar qtd de tubos por grupo
                                IF crSigCdGrp.GeraTubs <> 2
                                    loc_lnQtdTb = crSigCdPro.QtdCpnts
                                ELSE
                                    loc_cSQL = "SELECT SUM(qtds) AS total FROM SigPrMtz " + ;
                                               "WHERE Cpros = " + EscaparSQL(ALLTRIM(TempEestI.CPros))
                                    IF USED("crSigPrMtz")
                                        USE IN crSigPrMtz
                                    ENDIF
                                    IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigPrMtz") >= 1
                                        SELECT crSigPrMtz
                                        loc_lnQtdTb = NVL(crSigPrMtz.total, 0)
                                    ENDIF
                                ENDIF
                                IF loc_lnQtdTb = 0
                                    SELECT Produtos
                                    IF NOT SEEK(ALLTRIM(TempEestI.Cpros), "Produtos", "CPros")
                                        INSERT INTO Produtos (Cpros, DPros) ;
                                            VALUES (TempEestI.Cpros, crSigCdPro.Dpros)
                                    ENDIF
                                ENDIF
                            ENDIF
                        ELSE
                            *-- Com sub-itens: processar cada sub-item
                            SELECT TempEsti2
                            SCAN
                                loc_xBaixa = IIF(QtBaixas > 0 AND QtBaixas >= QtProds, ;
                                                 QtBaixas - QtProds, 0) + QtProds
                                loc_Saldo  = TempEsti2.Qtds - loc_xBaixa
                                loc_Peso   = IIF(EMPTY(TempEsti2.Pesos), crSigCdPro.Pesoms, TempEsti2.Pesos)
                                IF loc_Saldo <> 0
                                    INSERT INTO TmpItens ;
                                        (Emps, Dopes, Numes, CPros, Qtds, Saldo, Obs, Peso, ;
                                         Linhas, CodCors, CodTams, Citens, Notas, Dpros, Reffs) ;
                                        VALUES (TempEsti2.Emps, TempEsti2.Dopes, TempEsti2.Numes, ;
                                                TempEsti2.CPros, TempEsti2.Qtds, loc_Saldo, ;
                                                TempEestI.Obs, loc_Peso, crSigCdPro.Linhas, ;
                                                TempEsti2.CodCors, TempEsti2.CodTams, ;
                                                TempEestI.Citens, TempEestI.Notas, TempEestI.Dpros, ;
                                                crSigCdPro.Reffs)
                                    loc_TPeso    = loc_TPeso + (loc_Peso * loc_Saldo)
                                    loc_Processa = .T.
                                    *-- Verificar qtd de tubos por grupo
                                    IF crSigCdGrp.GeraTubs <> 2
                                        loc_lnQtdTb = crSigCdPro.QtdCpnts
                                    ELSE
                                        loc_cSQL = "SELECT SUM(qtds) AS total FROM SigPrMtz " + ;
                                                   "WHERE Cpros = " + EscaparSQL(ALLTRIM(TempEestI.CPros))
                                        IF USED("crSigPrMtz")
                                            USE IN crSigPrMtz
                                        ENDIF
                                        IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigPrMtz") >= 1
                                            SELECT crSigPrMtz
                                            loc_lnQtdTb = NVL(crSigPrMtz.total, 0)
                                        ENDIF
                                    ENDIF
                                    IF loc_lnQtdTb = 0
                                        SELECT Produtos
                                        IF NOT SEEK(ALLTRIM(TempEestI.Cpros), "Produtos", "CPros")
                                            INSERT INTO Produtos (Cpros, DPros) ;
                                                VALUES (TempEestI.Cpros, crSigCdPro.Dpros)
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDSCAN
                        ENDIF
                    ENDSCAN

                    *-- Inserir cabecalho se ha itens para processar neste movimento
                    IF loc_Processa
                        *-- Destino: preferencia pelo SigCdOpd, fallback para o movimento
                        loc_GrupoD = IIF(EMPTY(crSigCdOpd.GruDests), ;
                                         ALLTRIM(TempEest.GrupoDs), ALLTRIM(crSigCdOpd.GruDests))
                        loc_ContaD = IIF(EMPTY(crSigCdOpd.ConDests), ;
                                         ALLTRIM(TempEest.ContaDs), ALLTRIM(crSigCdOpd.ConDests))

                        *-- Buscar razao social do cliente
                        loc_cSQL = "SELECT TOP 1 RClis FROM SigCdCli " + ;
                                   "WHERE IClis = " + EscaparSQL(loc_ContaG)
                        IF USED("LocalCli")
                            USE IN LocalCli
                        ENDIF
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "LocalCli") < 1
                            MsgErro("Falha ao buscar cliente (SigCdCli).", "Erro")
                            loc_lSucesso = .F.
                        ENDIF
                        SELECT LocalCli
                        loc_cDConta = IIF(EOF(), "", ALLTRIM(LocalCli.RClis))
                        USE IN LocalCli

                        INSERT INTO TmpCabec ;
                            (Flag, Emps, Dopes, Numes, Grupo, Conta, Grupov, Contav, ;
                             Datas, Entregas, Peso, Obs, GrupoDs, ContaDs, DConta, ;
                             Notas, Jobs) ;
                            VALUES (.T., TempEest.Emps, TempEest.Dopes, TempEest.Numes, ;
                                    loc_GrupoG, loc_ContaG, ;
                                    ALLTRIM(TempEest.GrVends), ALLTRIM(TempEest.Vends), ;
                                    TempEest.Datas, TempEest.PrazoEnts, ;
                                    loc_TPeso, TempEest.Obses, ;
                                    loc_GrupoD, loc_ContaD, loc_cDConta, ;
                                    ALLTRIM(TempEest.Notas), ALLTRIM(TempEest.Jobs))
                    ENDIF
                ENDSCAN

                loc_oProg.Complete()

                IF USED("TempEest")
                    USE IN TempEest
                ENDIF
            ENDSCAN

            *-- Limpar filtro de operacao
            IF NOT EMPTY(loc_Operacao)
                SET KEY TO IN TmpOper
            ENDIF

            *-- Posicionar cursores no inicio
            GO TOP IN TmpCabec
            GO TOP IN TmpItens

            *-- Verificar se ha registros para processar
            loc_lSucesso = NOT EOF("TmpItens") AND NOT EOF("TmpCabec")
            IF NOT loc_lSucesso
                MsgAviso("Nenhum Item Selecionado Para Processar!!!", "Aviso")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao processar ordens: " + loc_oErro.Message + ;
                    " Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - retorna chave identificadora do contexto de processamento
    * Formato: Emp + TpGOp + Numps (evita colisao entre empresas/tipos)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ALLTRIM(THIS.this_cCdEmpresa) + "|" + ;
                     ALLTRIM(THIS.this_cTpGOp) + "|" + ;
                     TRANSFORM(THIS.this_nNop)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - grava uma OP gerada em SigOpPic (Ordens de Producao)
    * Chamada apos usuario confirmar selecao em SigPrGl2.
    * par_nNumps: numero da OP a gravar
    * par_cDope: operacao (Dopes) do item
    * par_cCpro: codigo do produto
    * par_nQtds: quantidade da OP
    * par_nNumes: numero do movimento origem (SigMvCab.Numes)
    * par_cCodTgOp: tipo de geracao (opcional; usa this_cTpGOp se vazio)
    * Retorna .T. em caso de sucesso
    *--------------------------------------------------------------------------
    PROCEDURE Inserir(par_nNumps, par_cDope, par_cCpro, par_nQtds, par_nNumes, par_cCodTgOp)
        LOCAL loc_lSucesso, loc_cSQL, loc_cEmp, loc_cDopp
        LOCAL loc_cCodTgOp, loc_cIdChave, loc_dGeracao, loc_dPrev
        LOCAL loc_cEmpDopNums, loc_cEmpDopNops, loc_cEmpDnps
        LOCAL loc_cUsuario, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Validar parametros obrigatorios
            IF EMPTY(par_nNumps) OR par_nNumps <= 0
                MsgErro("N" + CHR(250) + "mero da OP inv" + CHR(225) + "lido para inser" + CHR(231) + CHR(227) + "o.", "Erro")
                loc_lSucesso = .F.
            ENDIF
            IF EMPTY(ALLTRIM(par_cDope))
                MsgErro("Opera" + CHR(231) + CHR(227) + "o (Dopes) obrigat" + CHR(243) + "ria para inser" + CHR(231) + CHR(227) + "o.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Verificar duplicidade antes de inserir
            IF NOT THIS.ValidarNumeroOP(par_nNumps)
                MsgAviso("N" + CHR(250) + "mero de OP " + TRANSFORM(par_nNumps) + " j" + CHR(225) + " existe em SigOpPic.", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            *-- Preparar valores
            loc_cEmp      = ALLTRIM(THIS.this_cCdEmpresa)
            IF EMPTY(loc_cEmp)
                loc_cEmp = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            ENDIF
            loc_dGeracao  = IIF(EMPTY(THIS.this_dGeracao), DATE(), THIS.this_dGeracao)
            loc_dPrev     = IIF(EMPTY(THIS.this_dPrevisao), loc_dGeracao, THIS.this_dPrevisao)
            loc_cCodTgOp  = IIF(EMPTY(ALLTRIM(par_cCodTgOp)), ALLTRIM(THIS.this_cTpGOp), ALLTRIM(par_cCodTgOp))
            loc_cUsuario  = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")

            *-- Recuperar Dopp da operacao padrao (usa CarregarParametros previamente)
            loc_cDopp = ""
            IF USED("crSigCdPam")
                SELECT crSigCdPam
                loc_cDopp = ALLTRIM(crSigCdPam.DoppPads)
            ENDIF

            *-- Composicao das chaves compostas (padrao do sistema)
            loc_cEmpDopNums = loc_cEmp + ALLTRIM(par_cDope) + PADL(TRANSFORM(par_nNumes), 6, "0")
            loc_cEmpDopNops = loc_cEmp + ALLTRIM(par_cDope) + PADL(TRANSFORM(par_nNumps), 10, "0")
            loc_cEmpDnps    = loc_cEmp + PADL(TRANSFORM(par_nNumps), 10, "0")
            loc_cIdChave    = loc_cEmp + PADL(TRANSFORM(par_nNumps), 10, "0")

            *-- Montar INSERT em SigOpPic (colunas NOT NULL preenchidas)
            loc_cSQL = "INSERT INTO SigOpPic " + ;
                       "(cIdChaves, Emps, Dopes, Dopps, Nops, Numes, Numps, " + ;
                       " Datas, Datap, Datages, Cpros, Empds, Locals, Ntrans, " + ;
                       " Seqdivs, CodCors, CodTams, Divs, Imprs, Usuars, Nopmaes, " + ;
                       " Pesos, CodBarras, QtdCpnts, QtdTubos, iImprs, Moedas, Units, " + ;
                       " Nfunds, Dpros, Empdnps, EmpDopNops, EmpDopNums, Notas, " + ;
                       " CodTgOps, Citens, Qtds) VALUES ("
            loc_cSQL = loc_cSQL + ;
                       EscaparSQL(loc_cIdChave) + ", " + ;
                       EscaparSQL(loc_cEmp) + ", " + ;
                       EscaparSQL(ALLTRIM(par_cDope)) + ", " + ;
                       EscaparSQL(loc_cDopp) + ", " + ;
                       FormatarNumeroSQL(par_nNumps) + ", " + ;
                       FormatarNumeroSQL(par_nNumes) + ", " + ;
                       FormatarNumeroSQL(par_nNumps) + ", " + ;
                       FormatarDataSQL(loc_dGeracao) + ", " + ;
                       FormatarDataSQL(loc_dPrev) + ", " + ;
                       FormatarDataSQL(loc_dGeracao) + ", " + ;
                       EscaparSQL(ALLTRIM(par_cCpro)) + ", " + ;
                       EscaparSQL(loc_cEmp) + ", " + ;
                       EscaparSQL("") + ", " + ;
                       "0, 0, "
            loc_cSQL = loc_cSQL + ;
                       EscaparSQL("") + ", " + ;
                       EscaparSQL("") + ", " + ;
                       "0, 0, " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       "0, 0, 0, 0, 0, 0, " + ;
                       EscaparSQL("") + ", " + ;
                       "0, 0, " + ;
                       EscaparSQL("") + ", " + ;
                       EscaparSQL(loc_cEmpDnps) + ", " + ;
                       EscaparSQL(loc_cEmpDopNops) + ", " + ;
                       EscaparSQL(loc_cEmpDopNums) + ", " + ;
                       EscaparSQL("") + ", " + ;
                       EscaparSQL(loc_cCodTgOp) + ", " + ;
                       "0, " + ;
                       FormatarNumeroSQL(par_nQtds) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                MsgErro("Falha ao gravar OP em SigOpPic (n" + CHR(250) + "mero " + TRANSFORM(par_nNumps) + ").", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Auditoria da insercao
            THIS.RegistrarAuditoria("INCLUIR")

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro("Erro ao inserir OP: " + loc_oErro.Message + ;
                    " Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - vincula movimento origem (SigMvCab) ao numero da OP gerada
    * Em modo Reserva: atualiza rNops (reserva). Modo normal: atualiza Nops.
    * par_cEmp: empresa do movimento
    * par_cDope: operacao do movimento
    * par_nNumes: numero do movimento
    * par_nNumps: numero da OP gerada
    * Retorna .T. em caso de sucesso
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar(par_cEmp, par_cDope, par_nNumes, par_nNumps)
        LOCAL loc_lSucesso, loc_cSQL, loc_cEmpDopNums, loc_cCampo
        LOCAL loc_dAlt, loc_cUsuario, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Validar parametros
            IF EMPTY(par_nNumps) OR par_nNumps <= 0
                MsgErro("N" + CHR(250) + "mero da OP inv" + CHR(225) + "lido para atualiza" + CHR(231) + CHR(227) + "o.", "Erro")
                loc_lSucesso = .F.
            ENDIF
            IF EMPTY(ALLTRIM(par_cEmp)) OR EMPTY(ALLTRIM(par_cDope)) OR par_nNumes <= 0
                MsgErro("Chave do movimento (Emp/Dope/Numes) obrigat" + CHR(243) + "ria.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Campo destino: rNops em reserva automatica, Nops caso contrario
            loc_cCampo = IIF(THIS.this_lReserva, "rNops", "Nops")

            *-- Chave composta EmpDopNums
            loc_cEmpDopNums = ALLTRIM(par_cEmp) + ALLTRIM(par_cDope) + PADL(TRANSFORM(par_nNumes), 6, "0")

            *-- Dados de auditoria embutidos no proprio UPDATE
            loc_dAlt     = DATE()
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")

            loc_cSQL = "UPDATE SigMvCab SET " + loc_cCampo + " = " + FormatarNumeroSQL(par_nNumps)
            IF NOT THIS.this_lReserva
                loc_cSQL = loc_cSQL + ", Dtalts = " + FormatarDataSQL(loc_dAlt) + ;
                           ", Usualts = " + EscaparSQL(loc_cUsuario)
            ENDIF
            loc_cSQL = loc_cSQL + " WHERE EmpDopNums = " + EscaparSQL(loc_cEmpDopNums)

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                MsgErro("Falha ao atualizar movimento " + loc_cEmpDopNums + " com OP " + TRANSFORM(par_nNumps) + ".", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Auditoria da atualizacao
            THIS.RegistrarAuditoria("ALTERAR")

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar movimento: " + loc_oErro.Message + ;
                    " Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

