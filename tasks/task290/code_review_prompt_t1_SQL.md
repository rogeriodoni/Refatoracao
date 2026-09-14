# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (15)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GLOBALIZAS, ACESSO, CODTGOPS, RNOPS, OPERS, CITEM2, EMPDOPNUMS, QTBAIXAS, CPROS, NUMPS, DOPES, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GLOBALIZAS, ACESSO, CODTGOPS, RNOPS, OPERS, CITEM2, EMPDOPNUMS, QTBAIXAS, CPROS, NUMPS, DOPES, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DATAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GLOBALIZAS, ACESSO, CODTGOPS, RNOPS, OPERS, CITEM2, EMPDOPNUMS, QTBAIXAS, CPROS, NUMPS, DOPES, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PRAZOENTS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GLOBALIZAS, ACESSO, CODTGOPS, RNOPS, OPERS, CITEM2, EMPDOPNUMS, QTBAIXAS, CPROS, NUMPS, DOPES, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'GRUPOOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GLOBALIZAS, ACESSO, CODTGOPS, RNOPS, OPERS, CITEM2, EMPDOPNUMS, QTBAIXAS, CPROS, NUMPS, DOPES, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'GRUPODS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GLOBALIZAS, ACESSO, CODTGOPS, RNOPS, OPERS, CITEM2, EMPDOPNUMS, QTBAIXAS, CPROS, NUMPS, DOPES, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTAOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GLOBALIZAS, ACESSO, CODTGOPS, RNOPS, OPERS, CITEM2, EMPDOPNUMS, QTBAIXAS, CPROS, NUMPS, DOPES, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTADS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GLOBALIZAS, ACESSO, CODTGOPS, RNOPS, OPERS, CITEM2, EMPDOPNUMS, QTBAIXAS, CPROS, NUMPS, DOPES, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'GRVENDS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GLOBALIZAS, ACESSO, CODTGOPS, RNOPS, OPERS, CITEM2, EMPDOPNUMS, QTBAIXAS, CPROS, NUMPS, DOPES, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'VENDS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GLOBALIZAS, ACESSO, CODTGOPS, RNOPS, OPERS, CITEM2, EMPDOPNUMS, QTBAIXAS, CPROS, NUMPS, DOPES, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NOPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GLOBALIZAS, ACESSO, CODTGOPS, RNOPS, OPERS, CITEM2, EMPDOPNUMS, QTBAIXAS, CPROS, NUMPS, DOPES, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CGRUS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GLOBALIZAS, ACESSO, CODTGOPS, RNOPS, OPERS, CITEM2, EMPDOPNUMS, QTBAIXAS, CPROS, NUMPS, DOPES, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GLOBALIZAS, ACESSO, CODTGOPS, RNOPS, OPERS, CITEM2, EMPDOPNUMS, QTBAIXAS, CPROS, NUMPS, DOPES, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GLOBALIZAS, ACESSO, CODTGOPS, RNOPS, OPERS, CITEM2, EMPDOPNUMS, QTBAIXAS, CPROS, NUMPS, DOPES, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GLOBALIZAS, ACESSO, CODTGOPS, RNOPS, OPERS, CITEM2, EMPDOPNUMS, QTBAIXAS, CPROS, NUMPS, DOPES, CITENS

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGlo.prg) - TRECHOS RELEVANTES PARA PASS SQL (1733 linhas total):

*-- Linhas 135 a 153:
135: 
136:                     *-- Calcular visibilidade do chk_pedra (antes de criar controles)
137:                     IF USED("cursor_4c_CrSigCdPam") AND NOT EOF("cursor_4c_CrSigCdPam")
138:                         SELECT cursor_4c_CrSigCdPam
139:                         THIS.this_lMostrarChkPedra = ;
140:                             (NOT EMPTY(ALLTRIM(cursor_4c_CrSigCdPam.DopEmphs)) AND ;
141:                              NOT EMPTY(ALLTRIM(cursor_4c_CrSigCdPam.DopReqcs)) AND ;
142:                              NOT EMPTY(ALLTRIM(cursor_4c_CrSigCdPam.DopPedcs)) AND ;
143:                              NOT EMPTY(ALLTRIM(cursor_4c_CrSigCdPam.TransfRes)))
144:                     ENDIF
145: 
146:                     *-- Montar estrutura visual do form
147:                     THIS.ConfigurarCabecalho()
148:                     THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
149:                     THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
150:                     THIS.ConfigurarShape()
151:                     THIS.ConfigurarPaginaLista()
152:                     THIS.TornarControlesVisiveis()
153:                     THIS.PopularCamposIniciais()

*-- Linhas 312 a 330:
312:         LOCAL loc_lGlobAutos2
313:         loc_lGlobAutos2 = .F.
314:         IF USED("cursor_4c_CrSigCdPam") AND NOT EOF("cursor_4c_CrSigCdPam")
315:             SELECT cursor_4c_CrSigCdPam
316:             loc_lGlobAutos2 = (cursor_4c_CrSigCdPam.GlobAutos = 2 AND NOT THIS.this_lReserva)
317:         ENDIF
318: 
319:         *-- Container1 legado: Tipo de O.P.
320:         THIS.AddObject("cnt_4c_TipoOp", "Container")
321:         WITH THIS.cnt_4c_TipoOp
322:             .Top         = 164
323:             .Left        = 139
324:             .Width       = 346
325:             .Height      = 25
326:             .BackStyle   = 0
327:             .BorderWidth = 0
328:             .Enabled     = THIS.this_lGerPorTp
329:             .Visible     = .T.
330:         ENDWITH

*-- Linhas 989 a 1037:
989:             IF USED("cursor_4c_TmpEmpInit")
990:                 USE IN cursor_4c_TmpEmpInit
991:             ENDIF
992:             IF SQLEXEC(gnConnHandle, ;
993:                "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cEmp), ;
994:                "cursor_4c_TmpEmpInit") >= 1
995:                 IF RECCOUNT("cursor_4c_TmpEmpInit") > 0
996:                     SELECT cursor_4c_TmpEmpInit
997:                     loc_cRazas = ALLTRIM(cursor_4c_TmpEmpInit.Razas)
998:                 ENDIF
999:                 USE IN cursor_4c_TmpEmpInit
1000:             ENDIF
1001:             THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = loc_cEmp
1002:             THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = loc_cRazas
1003: 
1004:             *-- Previsao de entrega: data atual + PrevProds dias
1005:             IF USED("cursor_4c_CrSigCdPam") AND NOT EOF("cursor_4c_CrSigCdPam")
1006:                 SELECT cursor_4c_CrSigCdPam
1007:                 THIS.cnt_4c_Previsao.txt_4c_Previsao.Value = DATE() + cursor_4c_CrSigCdPam.PrevProds
1008:             ENDIF
1009: 
1010:             *-- Data de geracao: data atual (apenas se nao modo automatico)
1011:             IF NOT THIS.this_lAutomatico
1012:                 THIS.cnt_4c_Previsao.txt_4c_Geracao.Value = DATE()
1013:             ENDIF
1014: 
1015:             *-- Visibilidade do checkbox pedras
1016:             THIS.cnt_4c_Empresa.chk_4c_NaoEmpPedra.Visible = THIS.this_lMostrarChkPedra
1017: 
1018:             *-- Pre-selecionar tipo de OP se GerPorTp e houver apenas 1 tipo disponivel
1019:             IF THIS.this_lGerPorTp AND ;
1020:                USED("cursor_4c_CrTmpTpGop") AND ;
1021:                RECCOUNT("cursor_4c_CrTmpTpGop") = 1
1022:                 SELECT cursor_4c_CrTmpTpGop
1023:                 GO TOP
1024:                 THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value = ALLTRIM(cursor_4c_CrTmpTpGop.Codigos)
1025:             ENDIF
1026:         CATCH TO loc_oErro
1027:             MsgErro("Erro ao popular campos: " + loc_oErro.Message, "Erro")
1028:         ENDTRY
1029:     ENDPROC
1030: 
1031:     *--------------------------------------------------------------------------
1032:     * ConfigurarEventos - registra handlers via BINDEVENT (metodos PUBLIC)
1033:     *--------------------------------------------------------------------------
1034:     PROTECTED PROCEDURE ConfigurarEventos()
1035:         BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "CmdProcessarClick")
1036:         BINDEVENT(THIS.cmd_4c_Cancelar,  "Click", THIS, "CmdCancelarClick")
1037:         BINDEVENT(THIS.cnt_4c_TipoOp.txt_4c_TpGOp,          "KeyPress", THIS, "TxtTpGOpKeyPress")

*-- Linhas 1073 a 1091:
1073: 
1074:         *-- Validar numero OP manual (GlobAutos=2)
1075:         IF USED("cursor_4c_CrSigCdPam") AND NOT EOF("cursor_4c_CrSigCdPam")
1076:             SELECT cursor_4c_CrSigCdPam
1077:             loc_nGlobAutos = cursor_4c_CrSigCdPam.GlobAutos
1078:             IF loc_nGlobAutos = 2 AND NOT THIS.this_lReserva
1079:                 IF THIS.cnt_4c_Op.txt_4c_Nop.Value = 0
1080:                     MsgAviso("O N" + CHR(250) + "mero da OP " + CHR(233) + " Manual e Deve Ser Preenchido!!!")
1081:                     THIS.cnt_4c_Op.txt_4c_Nop.SetFocus
1082:                     RETURN
1083:                 ENDIF
1084:             ENDIF
1085:         ENDIF
1086: 
1087:         *-- Validar tipo de OP (obrigatorio no modo GerPorTp)
1088:         IF THIS.this_lGerPorTp AND EMPTY(ALLTRIM(THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value))
1089:             MsgAviso("O Tipo de Gera" + CHR(231) + CHR(227) + "o da OP " + CHR(233) + ;
1090:                      " Obrigat" + CHR(243) + "rio ser Preenchido!!!")
1091:             THIS.cnt_4c_TipoOp.txt_4c_TpGOp.SetFocus

*-- Linhas 1300 a 1343:
1300:         loc_cVal = ALLTRIM(THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value)
1301:         *-- Tentar SEEK direto antes de abrir picker
1302:         IF NOT EMPTY(loc_cVal) AND USED("cursor_4c_CrTmpTpGop")
1303:             SELECT cursor_4c_CrTmpTpGop
1304:             IF SEEK(loc_cVal, "cursor_4c_CrTmpTpGop", "Codigos")
1305:                 RETURN
1306:             ENDIF
1307:         ENDIF
1308:         IF NOT USED("cursor_4c_CrTmpTpGop")
1309:             MsgAviso("Tipos de O.P. n" + CHR(227) + "o carregados.")
1310:             RETURN
1311:         ENDIF
1312:         IF USED("cursor_4c_TpGOp")
1313:             USE IN cursor_4c_TpGOp
1314:         ENDIF
1315:         SELECT Codigos, Descs FROM cursor_4c_CrTmpTpGop INTO CURSOR cursor_4c_TpGOp READWRITE
1316:         SELECT cursor_4c_TpGOp
1317:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1318:         IF VARTYPE(loc_oBusca) = "O"
1319:             WITH loc_oBusca
1320:                 .this_cCursorDestino = "cursor_4c_TpGOp"
1321:                 .this_cTitulo        = "Tipos de Gera" + CHR(231) + CHR(227) + "o de OP"
1322:                 .this_cCampoBusca    = "Codigos"
1323:                 .this_cValorBusca    = loc_cVal
1324:                 .mAddColuna("Codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1325:                 .mAddColuna("Descs",   "                              ", "Descri" + CHR(231) + CHR(227) + "o")
1326:                 .Show()
1327:                 IF .this_lSelecionou
1328:                     SELECT cursor_4c_TpGOp
1329:                     THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value = ALLTRIM(cursor_4c_TpGOp.Codigos)
1330:                 ELSE
1331:                     THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value = ""
1332:                 ENDIF
1333:             ENDWITH
1334:             loc_oBusca = .NULL.
1335:         ENDIF
1336:     ENDPROC
1337: 
1338:     *--------------------------------------------------------------------------
1339:     * TxtOperacaoKeyPress - lookup operacao (cursor_4c_TmpOper - VFP local)
1340:     *--------------------------------------------------------------------------
1341:     PROCEDURE TxtOperacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1342:         LOCAL loc_cVal, loc_cTpGOp, loc_oBusca
1343:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115

*-- Linhas 1359 a 1400:
1359:         ENDIF
1360:         IF THIS.this_lGerPorTp
1361:             loc_cTpGOp = ALLTRIM(THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value)
1362:             SELECT Dopes, NDopes FROM cursor_4c_TmpOper ;
1363:                 WHERE CodTgOps = m.loc_cTpGOp ;
1364:                 INTO CURSOR cursor_4c_Oper READWRITE
1365:         ELSE
1366:             SELECT Dopes, NDopes FROM cursor_4c_TmpOper INTO CURSOR cursor_4c_Oper READWRITE
1367:         ENDIF
1368:         SELECT cursor_4c_Oper
1369:         INDEX ON Dopes TAG Dopes
1370:         *-- Tentar SEEK direto
1371:         IF SEEK(loc_cVal, "cursor_4c_Oper", "Dopes")
1372:             RETURN
1373:         ENDIF
1374:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1375:         IF VARTYPE(loc_oBusca) = "O"
1376:             WITH loc_oBusca
1377:                 .this_cCursorDestino = "cursor_4c_Oper"
1378:                 .this_cTitulo        = "Cadastro de Opera" + CHR(231) + CHR(245) + "es"
1379:                 .this_cCampoBusca    = "Dopes"
1380:                 .this_cValorBusca    = loc_cVal
1381:                 .mAddColuna("Dopes",  "", "Opera" + CHR(231) + CHR(227) + "o")
1382:                 .mAddColuna("NDopes", "XXXXXX", "C" + CHR(243) + "digo")
1383:                 .Show()
1384:                 IF .this_lSelecionou
1385:                     SELECT cursor_4c_Oper
1386:                     THIS.cnt_4c_Operacao.txt_4c_Operacao.Value = ALLTRIM(cursor_4c_Oper.Dopes)
1387:                 ELSE
1388:                     THIS.cnt_4c_Operacao.txt_4c_Operacao.Value  = ""
1389:                     THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value = 0
1390:                     THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value = 0
1391:                 ENDIF
1392:             ENDWITH
1393:             loc_oBusca = .NULL.
1394:         ENDIF
1395:     ENDPROC
1396: 
1397:     *--------------------------------------------------------------------------
1398:     * TxtOperacaoiKeyPress - auto-popula faixa final quando faixa inicial preenchida
1399:     *--------------------------------------------------------------------------
1400:     PROCEDURE TxtOperacaoiKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 1425 a 1443:
1425:                 .mAddColuna("descrs",  "                              ", "Descri" + CHR(231) + CHR(227) + "o")
1426:                 .Show()
1427:                 IF .this_lSelecionou
1428:                     SELECT cursor_4c_GrpConta
1429:                     THIS.cnt_4c_Conta.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_GrpConta.codigos)
1430:                 ELSE
1431:                     THIS.cnt_4c_Conta.txt_4c_Grupo.Value = ""
1432:                 ENDIF
1433:             ENDWITH
1434:             loc_oBusca = .NULL.
1435:         ENDIF
1436:     ENDPROC
1437: 
1438:     *--------------------------------------------------------------------------
1439:     * TxtContaKeyPress - lookup conta por codigo IClis (SigCdCli)
1440:     *--------------------------------------------------------------------------
1441:     PROCEDURE TxtContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1442:         LOCAL loc_cVal, loc_oBusca
1443:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115

*-- Linhas 1453 a 1471:
1453:                 .mAddColuna("RClis", "                                        ", "Nome")
1454:                 .Show()
1455:                 IF .this_lSelecionou
1456:                     SELECT cursor_4c_CliConta
1457:                     THIS.cnt_4c_Conta.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_CliConta.IClis)
1458:                     THIS.cnt_4c_Conta.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_CliConta.RClis)
1459:                 ELSE
1460:                     THIS.cnt_4c_Conta.txt_4c_Conta.Value  = ""
1461:                     THIS.cnt_4c_Conta.txt_4c_Dconta.Value = ""
1462:                 ENDIF
1463:             ENDWITH
1464:             loc_oBusca = .NULL.
1465:         ENDIF
1466:     ENDPROC
1467: 
1468:     *--------------------------------------------------------------------------
1469:     * TxtDcontaKeyPress - lookup conta por nome RClis (apenas quando Conta vazia)
1470:     *--------------------------------------------------------------------------
1471:     PROCEDURE TxtDcontaKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 1486 a 1504:
1486:                 .mAddColuna("RClis", "                                        ", "Nome")
1487:                 .Show()
1488:                 IF .this_lSelecionou
1489:                     SELECT cursor_4c_CliDconta
1490:                     THIS.cnt_4c_Conta.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_CliDconta.IClis)
1491:                     THIS.cnt_4c_Conta.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_CliDconta.RClis)
1492:                 ELSE
1493:                     THIS.cnt_4c_Conta.txt_4c_Conta.Value  = ""
1494:                     THIS.cnt_4c_Conta.txt_4c_Dconta.Value = ""
1495:                 ENDIF
1496:             ENDWITH
1497:             loc_oBusca = .NULL.
1498:         ENDIF
1499:     ENDPROC
1500: 
1501:     *--------------------------------------------------------------------------
1502:     * TxtGrupoRespKeyPress - lookup grupo contabil (SigCdGcr) para Vendedor
1503:     *--------------------------------------------------------------------------
1504:     PROCEDURE TxtGrupoRespKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 1516 a 1534:
1516:                 .mAddColuna("descrs",  "                              ", "Descri" + CHR(231) + CHR(227) + "o")
1517:                 .Show()
1518:                 IF .this_lSelecionou
1519:                     SELECT cursor_4c_GrpResp
1520:                     THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value = ALLTRIM(cursor_4c_GrpResp.codigos)
1521:                 ELSE
1522:                     THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value = ""
1523:                 ENDIF
1524:             ENDWITH
1525:             loc_oBusca = .NULL.
1526:         ENDIF
1527:     ENDPROC
1528: 
1529:     *--------------------------------------------------------------------------
1530:     * TxtContaRespKeyPress - lookup vendedor por codigo IClis (SigCdCli)
1531:     *--------------------------------------------------------------------------
1532:     PROCEDURE TxtContaRespKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1533:         LOCAL loc_cVal, loc_oBusca
1534:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115

*-- Linhas 1544 a 1562:
1544:                 .mAddColuna("RClis", "                                        ", "Nome")
1545:                 .Show()
1546:                 IF .this_lSelecionou
1547:                     SELECT cursor_4c_CliResp
1548:                     THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = ALLTRIM(cursor_4c_CliResp.IClis)
1549:                     THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ALLTRIM(cursor_4c_CliResp.RClis)
1550:                 ELSE
1551:                     THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = ""
1552:                     THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ""
1553:                 ENDIF
1554:             ENDWITH
1555:             loc_oBusca = .NULL.
1556:         ENDIF
1557:     ENDPROC
1558: 
1559:     *--------------------------------------------------------------------------
1560:     * TxtDcontaRespKeyPress - lookup vendedor por nome RClis (apenas quando ContaResp vazia)
1561:     *--------------------------------------------------------------------------
1562:     PROCEDURE TxtDcontaRespKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 1577 a 1595:
1577:                 .mAddColuna("RClis", "                                        ", "Nome")
1578:                 .Show()
1579:                 IF .this_lSelecionou
1580:                     SELECT cursor_4c_CliDcontaResp
1581:                     THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = ALLTRIM(cursor_4c_CliDcontaResp.IClis)
1582:                     THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ALLTRIM(cursor_4c_CliDcontaResp.RClis)
1583:                 ELSE
1584:                     THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = ""
1585:                     THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ""
1586:                 ENDIF
1587:             ENDWITH
1588:             loc_oBusca = .NULL.
1589:         ENDIF
1590:     ENDPROC
1591: 
1592:     *--------------------------------------------------------------------------
1593:     * TxtCdEmpresaKeyPress - lookup empresa por codigo Cemps (SigCdEmp)
1594:     * Apenas se AlterEmp = .T.
1595:     *--------------------------------------------------------------------------

*-- Linhas 1611 a 1629:
1611:                 .mAddColuna("Razas", "                                        ", "Raz" + CHR(227) + "o Social")
1612:                 .Show()
1613:                 IF .this_lSelecionou
1614:                     SELECT cursor_4c_Emp
1615:                     THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_Emp.Cemps)
1616:                     THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_Emp.Razas)
1617:                 ELSE
1618:                     THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = ""
1619:                     THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = ""
1620:                 ENDIF
1621:             ENDWITH
1622:             loc_oBusca = .NULL.
1623:         ENDIF
1624:     ENDPROC
1625: 
1626:     *--------------------------------------------------------------------------
1627:     * TxtDsEmpresaKeyPress - lookup empresa por razao social Razas (SigCdEmp)
1628:     * Apenas se AlterEmp = .T. e CdEmpresa vazio
1629:     *--------------------------------------------------------------------------

*-- Linhas 1648 a 1666:
1648:                 .mAddColuna("Razas", "                                        ", "Raz" + CHR(227) + "o Social")
1649:                 .Show()
1650:                 IF .this_lSelecionou
1651:                     SELECT cursor_4c_EmpDs
1652:                     THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_EmpDs.Cemps)
1653:                     THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpDs.Razas)
1654:                 ELSE
1655:                     THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = ""
1656:                     THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = ""
1657:                 ENDIF
1658:             ENDWITH
1659:             loc_oBusca = .NULL.
1660:         ENDIF
1661:     ENDPROC
1662: 
1663:     *--------------------------------------------------------------------------
1664:     * TxtNopKeyPress - valida numero de OP (nao pode ja existir em SigOpPic)
1665:     *--------------------------------------------------------------------------
1666:     PROCEDURE TxtNopKeyPress(par_nKeyCode, par_nShiftAltCtrl)

