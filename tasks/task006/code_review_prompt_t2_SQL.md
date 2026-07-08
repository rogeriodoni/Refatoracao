# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, EMPS, NOPERS, LNCLASSERR, ICLIS, OPERS, DOPES, EMPDOPNUMS, OK, ALTCOTS, CONTAS, GRUPOS, MOEDAS, CONTAPGS, LOPAGINA, NVALOR, SE, NUMOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'JOBS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, EMPS, NOPERS, LNCLASSERR, ICLIS, OPERS, DOPES, EMPDOPNUMS, OK, ALTCOTS, CONTAS, GRUPOS, MOEDAS, CONTAPGS, LOPAGINA, NVALOR, SE, NUMOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, EMPS, NOPERS, LNCLASSERR, ICLIS, OPERS, DOPES, EMPDOPNUMS, OK, ALTCOTS, CONTAS, GRUPOS, MOEDAS, CONTAPGS, LOPAGINA, NVALOR, SE, NUMOS

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
  Pagina.Lista.Grade.Column1.ControlSource = ""
  Pagina.Lista.Grade.Column2.ControlSource = ""
  Pagina.Lista.Grade.Column3.ControlSource = ""
  Pagina.Lista.Grade.Column4.ControlSource = ""
  Pagina.Lista.Grade.Column5.ControlSource = ""
  Pagina.Lista.Grade.Column6.ControlSource = ""
  Pagina.Lista.Grade.Column7.ControlSource = ""
  Pagina.Lista.Grade.Column8.ControlSource = ""
  ControlSource = "craltcc.nfs"
  ControlSource = "craltcc.docus"
  ControlSource = "craltcc.opers"
  ControlSource = "craltcc.valors"
  ControlSource = "craltcc.grupos"
  ControlSource = "craltcc.contas"
  ControlSource = "craltcc.cotacaos"
  ControlSource = "craltcc.usualts"
  ControlSource = "craltcc.hist2s"
  ControlSource = "craltcc.hists"
  ControlSource = "craltcc.sopers"
  ControlSource = "craltcc.svalors"
  ControlSource = "craltcc.sgrupos"
  ControlSource = "craltcc.scontas"
  ControlSource = "craltcc.moedas"
  ControlSource = "craltcc.scotacaos"
  ControlSource = "craltcc.smoedas"
  ControlSource = "craltcc.contapgs"
  ControlSource = ""
  ControlSource = ""
  ControlSource = "craltcc.datas"
  ControlSource = "craltcc.vencs"
  ControlSource = "craltcc.dtemis"
  ControlSource = "craltcc.Jobs"
select craltcc
select craltcc
Select Craltcc
lcQuery = [Select * ] + ;
		    [From SigMvCcr ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigMvCcr]) < 1)
Select crSigMvCcr
Update crSigMvCcr Set DtAudits = Nvl(DtAudits, Ctot([]))
	.Column1.ControlSource = [Ttod(crSigMvCcr.Datas)]
	.Column2.ControlSource = [crSigMvCcr.Contas]
	.Column3.ControlSource = [crSigMvCcr.SContas]
	.Column4.ControlSource = [crSigMvCcr.Hists]
	.Column5.ControlSource = [crSigMvCcr.Valors]
	.Column6.ControlSource = [crSigMvCcr.SValors]
	.Column7.ControlSource = [crSigMvCcr.SMoedas]
	.Column8.ControlSource = [crSigMvCcr.Moedas]
	.Column9.ControlSource = [crSigMvCcr.Nfs]
	.Column10.ControlSource= [crSigMvCcr.Docus]
	.Column11.ControlSource= [crSigMvCcr.Opers]
Select crSigMvCcr
If ThisForm.podatamgr.Update('Craltcc')
Select crSigMvCcr
lcUpdate = [Update SigMvCcr ] + ;
lnErro1 = ThisForm.podatamgr.SqlExecute(lcUpdate,'')
	lcDelete = [Delete From SigMvCcr Where Emps = '] + pEmp + [' And NOpers = ] + Str(pNop)
	lnClassErr = ThisForm.podatamgr.SqlExecute(lcDelete,'')
Select CrSigMvCcr
lcUpdate = [Update SigMvCcr Set DatExcs = ?pDat, UsuExcs = '] + Usuar + [' ] + ;
lnErro1 = ThisForm.podatamgr.SqlExecute(lcUpdate,'')
	lcDelete = [Delete From SigMvCcr Where Emps = '] + pEmp + [' And Nopers = ] + Str(pNop)
	lnClassErr = ThisForm.podatamgr.SqlExecute(lcDelete,'')
	If ThisForm.podatamgr.Update('Craltcc')
	lcQueryCli     = [Select a.Iclis, a.Rclis, a.Concilias From SigCdCli a Where a.Iclis = ?lcCliente ]
	lcQueryAltc    = [Select * From SigMvCcr Where Emps = ?pEmp and Nopers = ?pNoper] && And Opers = 'D']
	lcQueryParam   = [Select a.gesind,a.moedetqs,a.grupoests,a.contaests,a.transfres,a.empmasters, a.SaldConcs, ]+;
					   [From SigCdPam a]
	lcQuery = [Select * From SigCdCot]
	If (.poDataMgr.SqlExecute(lcQuery, [crSigCdCot]) < 1)
	Select crSigCdCot
	lcQuery = [Select * From SigCdMoe]
	If (.poDataMgr.SqlExecute(lcQuery, [crSigCdMoe]) < 1)
	Select crSigCdMoe
	lcQuery = [Select * From SigCdUsu]
	If (.poDataMgr.SqlExecute(lcQuery, [crSigCdUsu]) < 1)
	Select crSigCdUsu
	lcQuery = [Select * From SigCdCrg]
	If (.poDataMgr.SqlExecute(lcQuery, [crSigCdCrg]) < 1)
	Select crSigCdCrg
	lcQuery = [Select Codigos, Descrs, Classes From SigCdGcr]
	If (.poDataMgr.SqlExecute(lcQuery, [crSigCdGcr]) < 1)
	Select crSigCdGcr
		=Seek(crSigCdPam2.GrupoPags, [crSigCdGcr], [Codigos])
lcQuery = [Select NDopes, RealPrevs ] + ;
		    [From SigOpOpe ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigOpOpe') < 1)
lcQuery = [Select cIdChaves ] + ;
		    [From SigCdPgr ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crAchou') < 1)
	lcQuery = [Select cIdChaves ] + ;
			    [From SigMvCab ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crAchou') < 1)
	lcQuery = [Select cIdChaves ] + ;
			    [From SigCqChm ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crAchou') < 1)
Select CrSigCdPam
Select crSigMvCcr
	Select CrAltcc
Select crAltCC
		Select CrAltcc
	Select CrAltcc
Select crAltCC
=Seek(crAltcc.Moedas, [crSigCdMoe], [CMoes])
=Seek(Padr(Alltrim(Usuar), 10), [crSigCdUsu], [Usuarios])
llAltCot = ((Not Seek(crSigCdUsu.CCargs, [crSigCdCrg], [CCargs]) Or crSigCdCrg.AltCots <> [S] ) And ;
=Seek( CrAltcc.SMoedas, 'crSigCdMoe', 'CMoes' )
llAltcot = ((Not Seek(crSigCdUsu.CCargs, [crSigCdCrg], [CCargs]) Or crSigCdCrg.AltCots <> [S] ) And ;
select CrAltcc
		Select CrAltCc
		Select CrAltcc
		=Seek(M.Grupos, [crSigCdGcr], [Codigos])
		=seek(M.sgrupos, [crSigCdGcr], [Codigos])
		Select CrSigCdCli
		Select CrSigCdCli
		Select CrSigCdCli
	select CrAltcc
	Thisform.Podatamgr.Sqlexecute([select contas from SigOpCls where contas = ?contaori and grupos = ?grupoori and moedas = 'R'],'Tmpcalcs')
Select CrAltcc
lcQueryLog = [Select GruConMoes + ' ' + rtrim(ltrim(convert(varchar(20),valors))) +' / '+ Cidchaves as nRecNo From SigMvCcr Where Nopers = ?lnNopers]
	lnErro0 = ThisForm.podatamgr.SqlExecute([Select CidChaves as nRecNo From SigMvCcr Where Nopers = ?lnNopers],'CsLog')
		Select csLog
	If ThisForm.podatamgr.SqlExecute(lcQueryLog,'CsLog') > 0
		Select csLog
Select CrAltCc
	If ThisForm.podatamgr.SqlExecute(lcQueryLog,'CsLog') > 0
		Select csLog
Select CrSigMvCcr
	select CrSigMvCcr
ThisForm.podatamgr.SqlExecute([Select NDopes, RealPrevs From SigOpOpe Where ]+;
	=Seek(This.Value, [crSigCdGcr], [Codigos])
Select CrAltcc
		ThisForm.podatamgr.sqlexecute([select saldos from SigMvSlc where contas = ?cconta and grupos = ?cgrupo and moedas = 'R'],'crSigMvSlc')
=Seek(Padr(Alltrim(Usuar), 10), [crSigCdUsu], [Usuarios])
=Seek(ThisForm.Pagina.Dados.Get_Moeda.Value, [crSigCdMoe], [CMoes])
Ok = (Seek(crSigCdUsu.CCargs, [crSigCdCrg], [CCargs]) And ;
	=Seek(This.Value, [crSigCdGcr], [Codigos])
Select crSigCdMoe
If !Seek( This.Value )
			Select crSigCdCot
=Seek(Padr(Alltrim(Usuar), 10), [crSigCdUsu], [Usuarios])
llCota = ((Not Seek(crSigCdUsu.CCargs, [crSigCdCrg], [CCargs]) Or crSigCdCrg.AltCots <> [S]) And ;
=Seek(Padr(Alltrim(Usuar), 10), [crSigCdUsu], [Usuarios])
=Seek( ThisForm.Pagina.Dados.Get_sMoeda.Value, 'crSigCdMoe', 'CMoes' )
Ok = (Seek(crSigCdUsu.CCargs, [crSigCdCrg], [CCargs]) And ;
Select crSigCdMoe
If !Seek( This.Value )
			Select crSigCdCot
=Seek(Padr(Alltrim(Usuar), 10), [crSigCdUsu], [Usuarios])
llCota = ((Not Seek(crSigCdUsu.CCargs, [crSigCdCrg], [CCargs]) Or crSigCdCrg.AltCots <> [S]) And ;
Select CrAltcc

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigmvccr.prg) - TRECHOS RELEVANTES PARA PASS SQL (2726 linhas total):

*-- Linhas 377 a 431:
377: 
378:         *-- Cursor placeholder para o Grid (SET NULL ON para aceitar NULLs do SQL Server)
379:         SET NULL ON
380:         CREATE CURSOR cursor_4c_Dados ( ;
381:             Emps    C(3),  Nopers N(9,0), Datas  T,      Opers   C(1), ;
382:             Contas  C(10), Scontas C(10), Hists  C(40),  Valors  N(14,2), ;
383:             Svalors N(14,2), Nfs C(15),   Docus  C(20), ;
384:             Grupos  C(10), Sgrupos C(10), Moedas C(3),   Smoedas C(3), ;
385:             Hist2s  C(40), Shists  C(40))
386:         SET NULL OFF
387: 
388:         *-- Grid de lista de lancamentos (Top = 114 + 36 = 150)
389:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
390:         loc_oGrid = loc_oPagina.grd_4c_Lista
391: 
392:         *-- CRITICO: RecordSource e ColumnCount FORA do WITH para criar colunas imediatamente
393:         loc_oGrid.RecordSource = "cursor_4c_Dados"
394:         loc_oGrid.ColumnCount  = 9
395: 
396:         *-- OBRIGATORIO: ControlSources IMEDIATAMENTE APOS RecordSource/ColumnCount (antes do WITH)
397:         *-- Evita auto-bind por ordem de campos do cursor
398:         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Datas"
399:         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Opers"
400:         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Contas"
401:         loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.Scontas"
402:         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Hists"
403:         loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.Valors"
404:         loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.Svalors"
405:         loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.Nfs"
406:         loc_oGrid.Column9.ControlSource = "cursor_4c_Dados.Docus"
407: 
408:         WITH loc_oGrid
409:             .Top           = 150
410:             .Left          = 0
411:             .Width         = 1003
412:             .Height        = 448
413:             .GridLines     = 3
414:             .GridLineWidth = 1
415:             .GridColor     = RGB(200, 200, 200)
416:             .DeleteMark    = .F.
417:             .RecordMark    = .F.
418:             .Scrollbars    = 3
419:             .FontName      = "Tahoma"
420:             .FontSize      = 8
421:             .Visible       = .T.
422:         ENDWITH
423: 
424:         *-- Larguras das colunas
425:         loc_oGrid.Column1.Width = 80
426:         loc_oGrid.Column2.Width = 20
427:         loc_oGrid.Column3.Width = 100
428:         loc_oGrid.Column4.Width = 100
429:         loc_oGrid.Column5.Width = 250
430:         loc_oGrid.Column6.Width = 90
431:         loc_oGrid.Column7.Width = 90

*-- Linhas 1117 a 1135:
1117:     *--------------------------------------------------------------------------
1118:     * CarregarLista - Carrega dados na grade da Page1
1119:     * Usa cursor temporario + ZAP + APPEND para preservar colunas do Grid
1120:     * (Problema #34: SQLEXEC direto destroi cursor e colunas do Grid)
1121:     *--------------------------------------------------------------------------
1122:     PROCEDURE CarregarLista()
1123:         LOCAL loc_lResultado, loc_cSQL, loc_nResultado
1124:         LOCAL loc_cFiltro, loc_cDtI, loc_cDtF, loc_oGrid
1125:         loc_lResultado = .F.
1126: 
1127:         TRY
1128:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1129:                 loc_lResultado = .T.
1130:             ELSE
1131:                 *-- Ler datas do filtro da Page1
1132:                 IF TYPE("THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_DtInicial") = "O"
1133:                     THIS.this_dDtInicial = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_DtInicial.Value
1134:                     THIS.this_dDtFinal   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_DtFinal.Value
1135:                 ENDIF

*-- Linhas 1142 a 1198:
1142:                     loc_cFiltro = " AND a.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF
1143:                 ENDIF
1144: 
1145:                 *-- Montar SELECT (colunas identicas ao CREATE CURSOR placeholder)
1146:                 loc_cSQL = "SELECT a.Emps, a.Nopers, a.Datas, a.Opers," + ;
1147:                     " a.Contas, a.Scontas, a.Hists, a.Valors, a.Svalors," + ;
1148:                     " a.Nfs, a.Docus, a.Grupos, a.Sgrupos, a.Moedas," + ;
1149:                     " a.Smoedas, a.Hist2s, a.Shists" + ;
1150:                     " FROM SigMvCcr a" + ;
1151:                     " WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
1152:                     loc_cFiltro + ;
1153:                     " ORDER BY a.Datas DESC, a.Nopers DESC"
1154: 
1155:                 *-- SQLEXEC em cursor TEMPORARIO para preservar colunas do Grid
1156:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp")
1157:                 IF loc_nResultado >= 0
1158:                     SELECT cursor_4c_Dados
1159:                     ZAP
1160:                     IF RECCOUNT("cursor_4c_DadosTemp") > 0
1161:                         APPEND FROM DBF("cursor_4c_DadosTemp")
1162:                     ENDIF
1163:                     IF USED("cursor_4c_DadosTemp")
1164:                         USE IN cursor_4c_DadosTemp
1165:                     ENDIF
1166:                     GO TOP IN cursor_4c_Dados
1167: 
1168:                     *-- Obter referencia ao grid e reconfigurar Headers
1169:                     IF TYPE("THIS.pgf_4c_Paginas.Page1.grd_4c_Lista") = "O"
1170:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1171: 
1172:                         *-- Reconfigurar ControlSources (OBRIGATORIO apos carregar)
1173:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Datas"
1174:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Opers"
1175:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Contas"
1176:                         loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.Scontas"
1177:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Hists"
1178:                         loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.Valors"
1179:                         loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.Svalors"
1180:                         loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.Nfs"
1181:                         loc_oGrid.Column9.ControlSource = "cursor_4c_Dados.Docus"
1182: 
1183:                         *-- Reconfigurar Headers (OBRIGATORIO apos RecordSource/ControlSource)
1184:                         loc_oGrid.Column1.Header1.Caption = "Data"
1185:                         loc_oGrid.Column2.Header1.Caption = "O"
1186:                         loc_oGrid.Column3.Header1.Caption = "Conta"
1187:                         loc_oGrid.Column4.Header1.Caption = "Contrapartida"
1188:                         loc_oGrid.Column5.Header1.Caption = "Hist" + CHR(243) + "rico"
1189:                         loc_oGrid.Column6.Header1.Caption = "D" + CHR(233) + "bito"
1190:                         loc_oGrid.Column7.Header1.Caption = "Cr" + CHR(233) + "dito"
1191:                         loc_oGrid.Column8.Header1.Caption = "NF"
1192:                         loc_oGrid.Column9.Header1.Caption = "Documento"
1193: 
1194:                         loc_oGrid.Refresh()
1195:                     ENDIF
1196: 
1197:                     loc_lResultado = .T.
1198:                 ELSE

*-- Linhas 1314 a 1332:
1314:             RETURN
1315:         ENDIF
1316: 
1317:         SELECT cursor_4c_Dados
1318:         loc_nNopers = cursor_4c_Dados.Nopers
1319: 
1320:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nNopers)
1321:             THIS.BOParaForm()
1322:             THIS.this_cModoAtual = "VISUALIZAR"
1323:             THIS.HabilitarCampos(.F.)
1324:             THIS.AlternarPagina(2)
1325:         ELSE
1326:             MsgAviso("Erro ao carregar o registro selecionado.", "Visualizar")
1327:         ENDIF
1328:     ENDPROC
1329: 
1330:     *--------------------------------------------------------------------------
1331:     * BtnAlterarClick - Alterar lancamento selecionado
1332:     *--------------------------------------------------------------------------

*-- Linhas 1338 a 1356:
1338:             RETURN
1339:         ENDIF
1340: 
1341:         SELECT cursor_4c_Dados
1342:         loc_nNopers = cursor_4c_Dados.Nopers
1343: 
1344:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nNopers)
1345:             THIS.this_oBusinessObject.EditarRegistro()
1346:             THIS.BOParaForm()
1347:             THIS.this_cModoAtual = "ALTERAR"
1348:             THIS.HabilitarCampos(.T.)
1349:             THIS.AlternarPagina(2)
1350:         ELSE
1351:             MsgAviso("Erro ao carregar o registro selecionado.", "Alterar")
1352:         ENDIF
1353:     ENDPROC
1354: 
1355:     *--------------------------------------------------------------------------
1356:     * BtnExcluirClick - Excluir lancamento selecionado

*-- Linhas 1363 a 1381:
1363:             RETURN
1364:         ENDIF
1365: 
1366:         SELECT cursor_4c_Dados
1367:         loc_nNopers = cursor_4c_Dados.Nopers
1368: 
1369:         loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste lan" + CHR(231) + "amento?", ;
1370:             "Excluir Lan" + CHR(231) + "amento")
1371:         IF loc_lConfirma
1372:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nNopers)
1373:                 IF THIS.this_oBusinessObject.Excluir()
1374:                     MsgSucesso("Lan" + CHR(231) + "amento exclu" + CHR(237) + "do com sucesso!")
1375:                     THIS.CarregarLista()
1376:                 ENDIF
1377:             ELSE
1378:                 MsgAviso("Erro ao carregar o registro para exclus" + CHR(227) + "o.", "Excluir")
1379:             ENDIF
1380:         ENDIF
1381:     ENDPROC

*-- Linhas 1399 a 1417:
1399:             RETURN
1400:         ENDIF
1401: 
1402:         SELECT cursor_4c_Dados
1403:         loc_nNopers = cursor_4c_Dados.Nopers
1404: 
1405:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nNopers)
1406:             loc_cDope = ALLTRIM(THIS.this_oBusinessObject.this_cDopes)
1407: 
1408:             IF EMPTY(loc_cDope)
1409:                 *-- Sem documento de origem: exibir apenas o lancamento atual
1410:                 THIS.BOParaForm()
1411:                 THIS.this_cModoAtual = "VISUALIZAR"
1412:                 THIS.HabilitarCampos(.F.)
1413:                 THIS.AlternarPagina(2)
1414:             ELSE
1415:                 *-- Lancamento tem documento de origem (programacao/pagamento)
1416:                 *-- Abrir visualizacao do lancamento na Page2
1417:                 THIS.BOParaForm()

*-- Linhas 1667 a 1687:
1667:     PROTECTED PROCEDURE AbrirLookupGrupo(par_lSide)
1668:         LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao, loc_oPg2, loc_cFiltroEmps
1669:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1670:         loc_cFiltroEmps = "Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
1671: 
1672:         *-- MODO 1: Init faz SELECT * FROM SigCdGcr com filtro de empresa
1673:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1674:             "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", "", ;
1675:             "Busca de Grupos - Conta Corrente", .F., .F., loc_cFiltroEmps)
1676: 
1677:         IF VARTYPE(loc_oBusca) = "O"
1678:             *-- mAddColuna(campo, mascara, titulo) - 3 params, todos strings
1679:             loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1680:             loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1681:             loc_oBusca.Show()
1682: 
1683:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
1684:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
1685:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
1686: 
1687:                 IF !par_lSide

*-- Linhas 1743 a 1764:
1743:         ENDIF
1744: 
1745:         TRY
1746:             loc_nResultado = SQLEXEC(gnConnHandle, ;
1747:                 "SELECT Codigos, Descrs FROM SigCdGcr" + ;
1748:                 " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
1749:                 " AND Codigos = " + EscaparSQL(loc_cCodigo), ;
1750:                 "cursor_4c_BuscaGrupo")
1751: 
1752:             IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
1753:                 IF VARTYPE(loc_oDesc) = "O"
1754:                     loc_oDesc.Value = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
1755:                 ENDIF
1756:             ELSE
1757:                 MsgAviso("Grupo n" + CHR(227) + "o encontrado: " + loc_cCodigo, ;
1758:                     "Grupo")
1759:                 loc_oCod.Value = ""
1760:                 IF VARTYPE(loc_oDesc) = "O"
1761:                     loc_oDesc.Value = ""
1762:                 ENDIF
1763:             ENDIF
1764: 

*-- Linhas 1799 a 1833:
1799:             loc_cGrupo = ""
1800:         ENDIF
1801: 
1802:         *-- MODO 2: Pre-popular cursor via SQLEXEC (query com JOIN)
1803:         loc_cSQL = "SELECT DISTINCT s.Contas, c.Descrs" + ;
1804:             " FROM SigMvSlc s" + ;
1805:             " LEFT JOIN SigCdCcr c ON c.Contas = s.Contas" + ;
1806:             "  AND c.Emps = s.Emps" + ;
1807:             " WHERE s.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
1808:         IF !EMPTY(loc_cGrupo)
1809:             loc_cSQL = loc_cSQL + ;
1810:                 " AND s.Grupos = " + EscaparSQL(loc_cGrupo)
1811:         ENDIF
1812:         loc_cSQL = loc_cSQL + " ORDER BY s.Contas"
1813: 
1814:         IF USED("cursor_4c_BuscaConta")
1815:             USE IN cursor_4c_BuscaConta
1816:         ENDIF
1817: 
1818:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")
1819: 
1820:         IF loc_nResultado < 0 OR !USED("cursor_4c_BuscaConta") OR RECCOUNT("cursor_4c_BuscaConta") = 0
1821:             MsgAviso("Nenhuma conta encontrada para o grupo selecionado.", "Busca de Contas")
1822:             IF USED("cursor_4c_BuscaConta")
1823:                 USE IN cursor_4c_BuscaConta
1824:             ENDIF
1825:             RETURN
1826:         ENDIF
1827: 
1828:         *-- Cria FormBuscaAuxiliar sem params (MODO 2: cursor ja populado)
1829:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1830: 
1831:         IF VARTYPE(loc_oBusca) = "O"
1832:             loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaConta"
1833: 

*-- Linhas 1889 a 1910:
1889:         ENDIF
1890: 
1891:         TRY
1892:             loc_nResultado = SQLEXEC(gnConnHandle, ;
1893:                 "SELECT Contas, Descrs FROM SigCdCcr" + ;
1894:                 " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
1895:                 " AND Contas = " + EscaparSQL(loc_cCodigo), ;
1896:                 "cursor_4c_BuscaConta")
1897: 
1898:             IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_BuscaConta") > 0
1899:                 IF VARTYPE(loc_oDesc) = "O"
1900:                     loc_oDesc.Value = ALLTRIM(cursor_4c_BuscaConta.Descrs)
1901:                 ENDIF
1902:             ELSE
1903:                 MsgAviso("Conta n" + CHR(227) + "o encontrada: " + loc_cCodigo, ;
1904:                     "Conta")
1905:                 loc_oCod.Value = ""
1906:                 IF VARTYPE(loc_oDesc) = "O"
1907:                     loc_oDesc.Value = ""
1908:                 ENDIF
1909:             ENDIF
1910: 

*-- Linhas 1940 a 1961:
1940:         ENDIF
1941: 
1942:         TRY
1943:             loc_nResultado = SQLEXEC(gnConnHandle, ;
1944:                 "SELECT Jobs, Descrs FROM SigCdJob" + ;
1945:                 " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
1946:                 " AND Jobs = " + EscaparSQL(loc_cCodigo), ;
1947:                 "cursor_4c_BuscaJob")
1948: 
1949:             IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_BuscaJob") > 0
1950:                 IF TYPE("loc_oPg2.txt_4c_DJob") = "O"
1951:                     loc_oPg2.txt_4c_DJob.Value = ALLTRIM(cursor_4c_BuscaJob.Descrs)
1952:                 ENDIF
1953:             ELSE
1954:                 IF TYPE("loc_oPg2.txt_4c_DJob") = "O"
1955:                     loc_oPg2.txt_4c_DJob.Value = ""
1956:                 ENDIF
1957:             ENDIF
1958: 
1959:             IF USED("cursor_4c_BuscaJob")
1960:                 USE IN cursor_4c_BuscaJob
1961:             ENDIF

*-- Linhas 2076 a 2096:
2076:         ENDIF
2077: 
2078:         TRY
2079:             loc_nResultado = SQLEXEC(gnConnHandle, ;
2080:                 "SELECT CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + ;
2081:                 EscaparSQL(loc_cCodigo), ;
2082:                 "cursor_4c_ValMoeda")
2083: 
2084:             IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ValMoeda") > 0
2085:                 *-- Moeda valida: forcar codigo correto (maiusculo conforme banco)
2086:                 loc_oPg2.Controls(loc_cTxtMoeda).Value = ALLTRIM(cursor_4c_ValMoeda.CMoes)
2087:                 IF USED("cursor_4c_ValMoeda")
2088:                     USE IN cursor_4c_ValMoeda
2089:                 ENDIF
2090:                 *-- Atualizar cotacao para a nova moeda
2091:                 THIS.AtualizarCotacaoParaMoeda(loc_cCodigo, loc_cTxtCotacao, par_lSide)
2092:             ELSE
2093:                 *-- Moeda nao encontrada: abrir lookup para selecao
2094:                 IF USED("cursor_4c_ValMoeda")
2095:                     USE IN cursor_4c_ValMoeda
2096:                 ENDIF

*-- Linhas 2107 a 2147:
2107:     *--------------------------------------------------------------------------
2108:     * AtualizarCotacaoParaMoeda - Busca cotacao atual de uma moeda (SigCdCot)
2109:     * e atualiza o campo de cotacao correspondente.
2110:     * No legado: Select crSigCdCot / Set Order to Cotacaos Descending / Skip -1
2111:     *--------------------------------------------------------------------------
2112:     PROTECTED PROCEDURE AtualizarCotacaoParaMoeda(par_cMoeda, par_cTxtCotacao, par_lSide)
2113:         LOCAL loc_nResultado, loc_nCotacao, loc_oPg2
2114:         LOCAL loc_nValor, loc_nOutraCotacao
2115:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2116: 
2117:         IF EMPTY(par_cMoeda) OR par_cMoeda = "R"
2118:             *-- Real: cotacao = 1 (moeda padrao)
2119:             IF TYPE("loc_oPg2." + par_cTxtCotacao) = "O"
2120:                 loc_oPg2.Controls(par_cTxtCotacao).Value = 1
2121:             ENDIF
2122:             *-- Recalcular SVALOR
2123:             THIS.RecalcularSValor()
2124:             RETURN
2125:         ENDIF
2126: 
2127:         TRY
2128:             *-- Buscar cotacao mais recente em SigCdCot
2129:             loc_nResultado = SQLEXEC(gnConnHandle, ;
2130:                 "SELECT TOP 1 Cotacaos FROM SigCdCot" + ;
2131:                 " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
2132:                 " AND Moedas = " + EscaparSQL(par_cMoeda) + ;
2133:                 " ORDER BY Datas DESC, Cotacaos DESC", ;
2134:                 "cursor_4c_Cotacao")
2135: 
2136:             IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Cotacao") > 0
2137:                 loc_nCotacao = cursor_4c_Cotacao.Cotacaos
2138:                 IF TYPE("loc_oPg2." + par_cTxtCotacao) = "O"
2139:                     loc_oPg2.Controls(par_cTxtCotacao).Value = loc_nCotacao
2140:                 ENDIF
2141:             ENDIF
2142: 
2143:             IF USED("cursor_4c_Cotacao")
2144:                 USE IN cursor_4c_Cotacao
2145:             ENDIF
2146: 
2147:             *-- Recalcular SVALOR apos mudanca de cotacao

*-- Linhas 2476 a 2497:
2476:             loc_oPg2.txt_4c_DJob.Value = ""
2477:             IF !EMPTY(loc_cJob)
2478:                 TRY
2479:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
2480:                         "SELECT Jobs, Descrs FROM SigCdJob" + ;
2481:                         " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
2482:                         " AND Jobs = " + EscaparSQL(loc_cJob), ;
2483:                         "cursor_4c_BoJob")
2484:                     IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_BoJob") > 0
2485:                         loc_oPg2.txt_4c_DJob.Value = ALLTRIM(cursor_4c_BoJob.Descrs)
2486:                     ENDIF
2487:                     IF USED("cursor_4c_BoJob")
2488:                         USE IN cursor_4c_BoJob
2489:                     ENDIF
2490:                 CATCH TO loException
2491:                     IF USED("cursor_4c_BoJob")
2492:                         USE IN cursor_4c_BoJob
2493:                     ENDIF
2494:                     MsgErro("Erro ao buscar descri" + CHR(231) + CHR(227) + "o do Job: " + ;
2495:                         loException.Message, "Erro")
2496:                 ENDTRY
2497:             ENDIF

*-- Linhas 2511 a 2532:
2511:             loc_oPg2.txt_4c_Dgrupo.Value = ""
2512:             IF !EMPTY(loc_cGrupo)
2513:                 TRY
2514:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
2515:                         "SELECT Codigos, Descrs FROM SigCdGcr" + ;
2516:                         " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
2517:                         " AND Codigos = " + EscaparSQL(loc_cGrupo), ;
2518:                         "cursor_4c_BoGrupo")
2519:                     IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_BoGrupo") > 0
2520:                         loc_oPg2.txt_4c_Dgrupo.Value = ALLTRIM(cursor_4c_BoGrupo.Descrs)
2521:                     ENDIF
2522:                     IF USED("cursor_4c_BoGrupo")
2523:                         USE IN cursor_4c_BoGrupo
2524:                     ENDIF
2525:                 CATCH TO loException
2526:                     IF USED("cursor_4c_BoGrupo")
2527:                         USE IN cursor_4c_BoGrupo
2528:                     ENDIF
2529:                     MsgErro("Erro ao buscar descri" + CHR(231) + CHR(227) + "o do Grupo: " + ;
2530:                         loException.Message, "Erro")
2531:                 ENDTRY
2532:             ENDIF

*-- Linhas 2541 a 2562:
2541:             loc_oPg2.txt_4c_Dconta.Value = ""
2542:             IF !EMPTY(loc_cConta)
2543:                 TRY
2544:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
2545:                         "SELECT Contas, Descrs FROM SigCdCcr" + ;
2546:                         " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
2547:                         " AND Contas = " + EscaparSQL(loc_cConta), ;
2548:                         "cursor_4c_BoConta")
2549:                     IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_BoConta") > 0
2550:                         loc_oPg2.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BoConta.Descrs)
2551:                     ENDIF
2552:                     IF USED("cursor_4c_BoConta")
2553:                         USE IN cursor_4c_BoConta
2554:                     ENDIF
2555:                 CATCH TO loException
2556:                     IF USED("cursor_4c_BoConta")
2557:                         USE IN cursor_4c_BoConta
2558:                     ENDIF
2559:                     MsgErro("Erro ao buscar descri" + CHR(231) + CHR(227) + "o da Conta: " + ;
2560:                         loException.Message, "Erro")
2561:                 ENDTRY
2562:             ENDIF

*-- Linhas 2587 a 2608:
2587:             loc_oPg2.txt_4c_Sdgrupo.Value = ""
2588:             IF !EMPTY(loc_cSGrupo)
2589:                 TRY
2590:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
2591:                         "SELECT Codigos, Descrs FROM SigCdGcr" + ;
2592:                         " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
2593:                         " AND Codigos = " + EscaparSQL(loc_cSGrupo), ;
2594:                         "cursor_4c_BoSGrupo")
2595:                     IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_BoSGrupo") > 0
2596:                         loc_oPg2.txt_4c_Sdgrupo.Value = ALLTRIM(cursor_4c_BoSGrupo.Descrs)
2597:                     ENDIF
2598:                     IF USED("cursor_4c_BoSGrupo")
2599:                         USE IN cursor_4c_BoSGrupo
2600:                     ENDIF
2601:                 CATCH TO loException
2602:                     IF USED("cursor_4c_BoSGrupo")
2603:                         USE IN cursor_4c_BoSGrupo
2604:                     ENDIF
2605:                     MsgErro("Erro ao buscar descri" + CHR(231) + CHR(227) + "o do Grupo Credito: " + ;
2606:                         loException.Message, "Erro")
2607:                 ENDTRY
2608:             ENDIF

*-- Linhas 2617 a 2638:
2617:             loc_oPg2.txt_4c_Sdconta.Value = ""
2618:             IF !EMPTY(loc_cSConta)
2619:                 TRY
2620:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
2621:                         "SELECT Contas, Descrs FROM SigCdCcr" + ;
2622:                         " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
2623:                         " AND Contas = " + EscaparSQL(loc_cSConta), ;
2624:                         "cursor_4c_BoSConta")
2625:                     IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_BoSConta") > 0
2626:                         loc_oPg2.txt_4c_Sdconta.Value = ALLTRIM(cursor_4c_BoSConta.Descrs)
2627:                     ENDIF
2628:                     IF USED("cursor_4c_BoSConta")
2629:                         USE IN cursor_4c_BoSConta
2630:                     ENDIF
2631:                 CATCH TO loException
2632:                     IF USED("cursor_4c_BoSConta")
2633:                         USE IN cursor_4c_BoSConta
2634:                     ENDIF
2635:                     MsgErro("Erro ao buscar descri" + CHR(231) + CHR(227) + "o da Conta Credito: " + ;
2636:                         loException.Message, "Erro")
2637:                 ENDTRY
2638:             ENDIF


### BO (C:\4c\projeto\app\classes\sigmvccrBO.prg):
*==============================================================================
* sigmvccrBO.prg - Business Object para Conta Corrente Geral
* Tabela: SigMvCcr
* Fase 1/8: Propriedades e Init()
*==============================================================================

DEFINE CLASS sigmvccrBO AS BusinessBase

    *-- Chave primaria composta: Emps + Nopers (cidchaves = chave unica gerada)
    this_cEmps        = ""    && Empresa (3)
    this_nNopers      = 0     && Numero da operacao (PK numerico)
    this_cCidChaves   = ""    && Chave unica gerada (cidchaves C20)

    *-- Datas
    this_dDatas       = {}    && Data do lancamento
    this_dVencs       = {}    && Vencimento
    this_dDtemis      = {}    && Data de emissao (dtemis)
    this_dDatAlts     = {}    && Data de alteracao (datalts)
    this_dDatExcs     = {}    && Data de exclusao (datexcs)
    this_dDatatrans   = {}    && Data de transacao

    *-- Movimento debito (lado esquerdo - Get_grupo/Get_conta)
    this_cOpers       = ""    && Operacao D/C (opers)
    this_cGrupos      = ""    && Grupo conta corrente debito (grupos)
    this_cContas      = ""    && Conta corrente debito (contas)
    this_cMoedas      = ""    && Moeda (moedas)
    this_nCotacaos    = 0     && Cotacao (cotacaos)
    this_nValors      = 0     && Valor (valors)
    this_cCotUsus     = ""    && Cotacao usurio - alteracao manual (cotusus)

    *-- Movimento credito/contrapartida (lado direito - Get_sgrupo/Get_sconta)
    this_cSOpers      = ""    && Operacao contrapartida D/C (sopers)
    this_cSGrupos     = ""    && Grupo conta corrente credito (sgrupos)
    this_cSContas     = ""    && Conta corrente credito (scontas)
    this_cSMoedas     = ""    && Moeda contrapartida (smoedas)
    this_nSCotacaos   = 0     && Cotacao contrapartida (scotacaos)
    this_nSValors     = 0     && Valor contrapartida (svalors)

    *-- Identificacao do lancamento
    this_cNfs         = ""    && Nota fiscal (nfs)
    this_cDocus       = ""    && Documento (docus)
    this_cHists       = ""    && Historico (hists)
    this_cHist2s      = ""    && Historico complementar (hist2s)
    this_cShists      = ""    && Historico contrapartida (shists)
    this_cUsualts     = ""    && Usuario do lancamento (usualts)
    this_cUsuExcs     = ""    && Usuario de exclusao (usuexcs)
    this_nContaPgs    = 0     && Tipo conta pagamento - opcao_conta (contapgs)

    *-- Job (centro de custo)
    this_cJobs        = ""    && Codigo do job (jobs)

    *-- Controle interno e auditoria
    this_lAutos       = .F.   && Flag de processamento automatico (autos)
    this_cGruConMoes  = ""    && Chave composta grupos+contas+moedas (gruconmoes)
    this_nNumes       = 0     && Numero (numes)
    this_cDopcs       = ""    && Documento contrapartida (dopcs)
    this_nNumcs       = 0     && Numero contrapartida (numcs)
    this_cVOpers      = ""    && Codigo operacao com empresa (vopers)
    this_cDopes       = ""    && Codigo do tipo de operacao (dopes)
    this_nNtrans      = 0     && Numero de transacao (ntrans)
    this_nNlancs      = 0     && Numero de lancamento (nlancs)

    *-- Conciliacao
    this_nConcs       = 0     && Flag conciliado (concs)
    this_dDataConcs   = {}    && Data de conciliacao (dataconcs)
    this_cUsuConcs    = ""    && Usuario conciliacao (usuconcs)

    *-- Saldos calculados (somente leitura na grade)
    this_nSaldos      = 0     && Saldo (saldos)
    this_nValLiqs     = 0     && Valor liquido (valliqs)
    this_nValPags     = 0     && Valor pago (valpags)
    this_nValPrev     = 0     && Valor previsto (valprev)
    this_nValOcurs    = 0     && Valor em outra moeda (valocurs)

    *-- Campos adicionais da tabela
    this_cTipos       = ""    && Tipo (tipos)
    this_cTitulos     = ""    && Titulo (titulos)
    this_cTitBans     = ""    && Titulo bancario (titbans)
    this_cLocals      = ""    && Local (locals)
    this_cGrupAges    = ""    && Grupo agencia (grupages)
    this_cGrupEms     = ""    && Grupo empresa (grupems)
    this_cContAges    = ""    && Conta agencia (contages)
    this_cContEms     = ""    && Conta empresa (contems)
    this_cBContas     = ""    && B contas (bcontas)
    this_cBGrupos     = ""    && B grupos (bgrupos)
    this_cBorderos    = ""    && Borderdo (borderos)
    this_nIntConts    = 0     && Integracao contabil (intconts)
    this_cAuditors    = ""    && Auditor (auditors)
    this_dDtAudits    = {}    && Data auditoria (dtaudits)
    this_cEmpDopNcs   = ""    && Empresa+doc+nc (empdopncs)
    this_nEmpDopNums  = 0     && Empresa+doc+num (empdopnums)
    this_nPagos       = 0     && Pago flag (pagos)
    this_cDopotps     = ""    && Tipo pagamento (dopotps)
    this_cUsuPagos    = ""    && Usuario pagamento (usupagos)
    this_cTitCancs    = ""    && Titulo cancelado (titcancs)
    this_dDtConfs     = {}    && Data confirmacao (dtconfs)
    this_cUsuConfs    = ""    && Usuario confirmacao (usuconfs)
    this_nNOperCancs  = 0     && Numero operacao cancelada (nopercancs)
    this_cEspecieNfs  = ""    && Especie nota fiscal (especienfs)
    this_nImpostos    = 0     && Impostos (impostos)
    this_cTpImpostos  = ""    && Tipo impostos (tpimpostos)
    this_cTitPais     = ""    && Titulo pais (titpais)
    this_cEmpCcs      = ""    && Empresa conta corrente (empccs)
    this_nRecor       = 0     && Recorrencia (recor)
    this_cCompet      = ""    && Competencia (compet)
    this_cEmpos       = ""    && Empresa origem (empos)
    this_nOriDopNums  = 0     && Origem documento num (oridopnums)
    this_cRContas     = ""    && Rota contas (rcontas)
    this_cTpDocNf     = ""    && Tipo documento NF (tpdocnf)
    this_nSaldocs     = 0     && Saldo documentos (saldocs)
    this_nSaldons     = 0     && Saldo notas (saldons)
    this_nVlancs      = 0     && Valor lancamentos (vlancs)

    *===========================================================================
    PROCEDURE Init()
    *===========================================================================
        DODEFAULT()
        THIS.this_cTabela     = "SigMvCcr"
        THIS.this_cCampoChave = "Nopers"
        RETURN .T.
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
    *===========================================================================
    * Retorna identificador para auditoria (empresa + numero operacao)
        RETURN ALLTRIM(THIS.this_cEmps) + "-" + TRANSFORM(THIS.this_nNopers)
    ENDPROC

    *===========================================================================
    PROCEDURE Buscar(par_cFiltro)
    *===========================================================================
    *-- Busca lancamentos por empresa e filtro adicional (ex: periodo de datas)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT a.Emps, a.Nopers, a.Datas, a.Opers, a.Grupos, a.Contas," + ;
                " a.Moedas, a.Cotacaos, a.Valors, a.Hists, a.Hist2s, a.Shists," + ;
                " a.Nfs, a.Docus, a.Sgrupos, a.Scontas, a.Smoedas, a.Scotacaos," + ;
                " a.Svalors, a.Sopers, a.Vencs, a.Dtemis, a.Usualts, a.Jobs," + ;
                " a.Contapgs, a.Concs, a.Dataconcs, a.Usuconcs, a.Datalts," + ;
                " a.Dopes, a.Numes, a.Dopcs, a.Numcs, a.Vopers, a.CidChaves," + ;
                " a.Autos, a.GruConMoes, a.Ntrans, a.Nlancs, a.CotUsus" + ;
                " FROM SigMvCcr a" + ;
                " WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " AND " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.Datas, a.Nopers"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar lan" + CHR(231) + "amentos:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Buscar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    PROCEDURE CarregarPorCodigo(par_nNopers)
    *===========================================================================
    *-- Carrega lancamento pelo numero de operacao (Nopers)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.Emps, a.Nopers, a.Datas, a.Opers, a.Grupos, a.Contas," + ;
                " a.Moedas, a.Cotacaos, a.Valors, a.Hists, a.Hist2s, a.Shists," + ;
                " a.Nfs, a.Docus, a.Sgrupos, a.Scontas, a.Smoedas, a.Scotacaos," + ;
                " a.Svalors, a.Sopers, a.Vencs, a.Dtemis, a.Usualts, a.Jobs," + ;
                " a.Contapgs, a.Concs, a.Dataconcs, a.Usuconcs, a.Datalts," + ;
                " a.Dopes, a.Numes, a.Dopcs, a.Numcs, a.Vopers, a.CidChaves," + ;
                " a.Autos, a.GruConMoes, a.Ntrans, a.Nlancs, a.CotUsus" + ;
                " FROM SigMvCcr a" + ;
                " WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                " AND a.Nopers = " + TRANSFORM(par_nNopers)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarPorCodigo: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *===========================================================================
    *-- Mapeia campos do cursor para propriedades this_*
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cEmps       = TratarNulo(Emps, "C")
            THIS.this_nNopers     = TratarNulo(Nopers, "N")
            THIS.this_dDatas      = IIF(ISNULL(Datas)  .OR. EMPTY(Datas),  {}, TTOD(Datas))
            THIS.this_dVencs      = IIF(ISNULL(Vencs)  .OR. EMPTY(Vencs),  {}, TTOD(Vencs))
            THIS.this_dDtemis     = IIF(ISNULL(Dtemis) .OR. EMPTY(Dtemis), {}, TTOD(Dtemis))
            THIS.this_cOpers      = TratarNulo(Opers, "C")
            THIS.this_cGrupos     = TratarNulo(Grupos, "C")
            THIS.this_cContas     = TratarNulo(Contas, "C")
            THIS.this_cMoedas     = TratarNulo(Moedas, "C")
            THIS.this_nCotacaos   = TratarNulo(Cotacaos, "N")
            THIS.this_nValors     = TratarNulo(Valors, "N")
            THIS.this_cSOpers     = TratarNulo(Sopers, "C")
            THIS.this_cSGrupos    = TratarNulo(Sgrupos, "C")
            THIS.this_cSContas    = TratarNulo(Scontas, "C")
            THIS.this_cSMoedas    = TratarNulo(Smoedas, "C")
            THIS.this_nSCotacaos  = TratarNulo(Scotacaos, "N")
            THIS.this_nSValors    = TratarNulo(Svalors, "N")
            THIS.this_cNfs        = TratarNulo(Nfs, "C")
            THIS.this_cDocus      = TratarNulo(Docus, "C")
            THIS.this_cHists      = TratarNulo(Hists, "C")
            THIS.this_cHist2s     = TratarNulo(Hist2s, "C")
            THIS.this_cShists     = TratarNulo(Shists, "C")
            THIS.this_cUsualts    = TratarNulo(Usualts, "C")
            THIS.this_cJobs       = TratarNulo(Jobs, "C")
            THIS.this_nContaPgs   = TratarNulo(Contapgs, "N")
            THIS.this_nConcs      = TratarNulo(Concs, "N")
            THIS.this_cGruConMoes = TratarNulo(GruConMoes, "C")
            THIS.this_cCidChaves  = TratarNulo(CidChaves, "C")
            THIS.this_lAutos      = (IIF(VARTYPE(Autos) = "L", Autos, (IIF(VARTYPE(Autos) = "L", Autos, (IIF(VARTYPE(Autos) = "L", Autos, (NVL(Autos, 0) = 1)))))))
            THIS.this_cDopes      = TratarNulo(Dopes, "C")
            THIS.this_nNumes      = TratarNulo(Numes, "N")
            THIS.this_cDopcs      = TratarNulo(Dopcs, "C")
            THIS.this_nNumcs      = TratarNulo(Numcs, "N")
            THIS.this_cVOpers     = TratarNulo(Vopers, "C")
            THIS.this_nNtrans     = TratarNulo(Ntrans, "N")
            THIS.this_nNlancs     = TratarNulo(Nlancs, "N")
            THIS.this_cCotUsus    = TratarNulo(CotUsus, "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE Inserir()
    *===========================================================================
    *-- Insere novo lancamento em SigMvCcr gerando Nopers sequencial
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        LOCAL loc_nProxNopers, loc_cCidChaves, loc_cGruConMoes
        LOCAL loc_cDataLanc, loc_cDataVenc, loc_cDataEmis
        loc_lResultado = .F.
        loc_nProxNopers = 0

        TRY
            *-- 1. Obter proximo Nopers para a empresa
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT ISNULL(MAX(Nopers), 0) + 1 AS ProxNopers" + ;
                " FROM SigMvCcr WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa), ;
                "cursor_4c_ProxN")
            IF loc_nResultado < 0 OR RECCOUNT("cursor_4c_ProxN") = 0
                MsgErro("Erro ao gerar n" + CHR(250) + "mero de opera" + CHR(231) + CHR(227) + "o.", "Erro")
            ELSE
                SELECT cursor_4c_ProxN
                loc_nProxNopers = cursor_4c_ProxN.ProxNopers
                USE IN cursor_4c_ProxN

                THIS.this_nNopers    = loc_nProxNopers
                THIS.this_cEmps      = go_4c_Sistema.cCodEmpresa
                THIS.this_cUsualts   = gc_4c_UsuarioLogado
                THIS.this_lAutos     = .F.

                *-- 2. Calcular campos derivados (padrao do legado)
                THIS.this_cGruConMoes = ALLTRIM(THIS.this_cGrupos) + ;
                    ALLTRIM(THIS.this_cContas) + ALLTRIM(THIS.this_cMoedas)
                THIS.this_cCidChaves  = DTOS(THIS.this_dDatas) + ;
                    TRANSFORM(loc_nProxNopers, "@L 999999")

                *-- 3. Formatar datas para SQL
                loc_cDataLanc = IIF(EMPTY(THIS.this_dDatas), "NULL", ;
                    "'" + DTOS(THIS.this_dDatas) + "'")
                loc_cDataVenc = IIF(EMPTY(THIS.this_dVencs), "NULL", ;
                    "'" + DTOS(THIS.this_dVencs) + "'")
                loc_cDataEmis = IIF(EMPTY(THIS.this_dDtemis), "NULL", ;
                    "'" + DTOS(THIS.this_dDtemis) + "'")

                *-- 4. Montar INSERT
                loc_cSQL = "INSERT INTO SigMvCcr (" + ;
                    "Emps, Nopers, CidChaves, Datas, Vencs, Dtemis," + ;
                    " Opers, Grupos, Contas, Moedas, Cotacaos, Valors," + ;
                    " Sopers, Sgrupos, Scontas, Smoedas, Scotacaos, Svalors," + ;
                    " Nfs, Docus, Hists, Hist2s, Shists, Usualts, Jobs," + ;
                    " Contapgs, GruConMoes, Autos, Datalts, CotUsus) VALUES (" + ;
                    EscaparSQL(THIS.this_cEmps) + "," + ;
                    TRANSFORM(THIS.this_nNopers) + "," + ;
                    EscaparSQL(THIS.this_cCidChaves) + "," + ;
                    loc_cDataLanc + "," + ;
                    loc_cDataVenc + "," + ;
                    loc_cDataEmis + "," + ;
                    EscaparSQL(THIS.this_cOpers) + "," + ;
                    EscaparSQL(THIS.this_cGrupos) + "," + ;
                    EscaparSQL(THIS.this_cContas) + "," + ;
                    EscaparSQL(THIS.this_cMoedas) + "," + ;
                    FormatarNumeroSQL(THIS.this_nCotacaos) + "," + ;
                    FormatarNumeroSQL(THIS.this_nValors) + "," + ;
                    EscaparSQL(THIS.this_cSOpers) + "," + ;
                    EscaparSQL(THIS.this_cSGrupos) + "," + ;
                    EscaparSQL(THIS.this_cSContas) + "," + ;
                    EscaparSQL(THIS.this_cSMoedas) + "," + ;
                    FormatarNumeroSQL(THIS.this_nSCotacaos) + "," + ;
                    FormatarNumeroSQL(THIS.this_nSValors) + "," + ;
                    EscaparSQL(THIS.this_cNfs) + "," + ;
                    EscaparSQL(THIS.this_cDocus) + "," + ;
                    EscaparSQL(THIS.this_cHists) + "," + ;
                    EscaparSQL(THIS.this_cHist2s) + "," + ;
                    EscaparSQL(THIS.this_cShists) + "," + ;
                    EscaparSQL(THIS.this_cUsualts) + "," + ;
                    EscaparSQL(THIS.this_cJobs) + "," + ;
                    TRANSFORM(THIS.this_nContaPgs) + "," + ;
                    EscaparSQL(THIS.this_cGruConMoes) + "," + ;
                    IIF(THIS.this_lAutos, "1", "0") + "," + ;
                    "GETDATE()," + ;
                    EscaparSQL(THIS.this_cCotUsus) + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao inserir lan" + CHR(231) + "amento:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Inserir: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_ProxN")
            USE IN cursor_4c_ProxN
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE Atualizar()
    *===========================================================================
    *-- Atualiza lancamento existente em SigMvCcr
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        LOCAL loc_cDataLanc, loc_cDataVenc, loc_cDataEmis
        loc_lResultado = .F.

        TRY
            *-- Recalcular campos derivados
            THIS.this_cGruConMoes = ALLTRIM(THIS.this_cGrupos) + ;
                ALLTRIM(THIS.this_cContas) + ALLTRIM(THIS.this_cMoedas)

            *-- Formatar datas
            loc_cDataLanc = IIF(EMPTY(THIS.this_dDatas), "NULL", ;
                "'" + DTOS(THIS.this_dDatas) + "'")
            loc_cDataVenc = IIF(EMPTY(THIS.this_dVencs), "NULL", ;
                "'" + DTOS(THIS.this_dVencs) + "'")
            loc_cDataEmis = IIF(EMPTY(THIS.this_dDtemis), "NULL", ;
                "'" + DTOS(THIS.this_dDtemis) + "'")

            loc_cSQL = "UPDATE SigMvCcr SET" + ;
                " Datas = "      + loc_cDataLanc + "," + ;
                " Vencs = "      + loc_cDataVenc + "," + ;
                " Dtemis = "     + loc_cDataEmis + "," + ;
                " Opers = "      + EscaparSQL(THIS.this_cOpers) + "," + ;
                " Grupos = "     + EscaparSQL(THIS.this_cGrupos) + "," + ;
                " Contas = "     + EscaparSQL(THIS.this_cContas) + "," + ;
                " Moedas = "     + EscaparSQL(THIS.this_cMoedas) + "," + ;
                " Cotacaos = "   + FormatarNumeroSQL(THIS.this_nCotacaos) + "," + ;
                " Valors = "     + FormatarNumeroSQL(THIS.this_nValors) + "," + ;
                " Sopers = "     + EscaparSQL(THIS.this_cSOpers) + "," + ;
                " Sgrupos = "    + EscaparSQL(THIS.this_cSGrupos) + "," + ;
                " Scontas = "    + EscaparSQL(THIS.this_cSContas) + "," + ;
                " Smoedas = "    + EscaparSQL(THIS.this_cSMoedas) + "," + ;
                " Scotacaos = "  + FormatarNumeroSQL(THIS.this_nSCotacaos) + "," + ;
                " Svalors = "    + FormatarNumeroSQL(THIS.this_nSValors) + "," + ;
                " Nfs = "        + EscaparSQL(THIS.this_cNfs) + "," + ;
                " Docus = "      + EscaparSQL(THIS.this_cDocus) + "," + ;
                " Hists = "      + EscaparSQL(THIS.this_cHists) + "," + ;
                " Hist2s = "     + EscaparSQL(THIS.this_cHist2s) + "," + ;
                " Shists = "     + EscaparSQL(THIS.this_cShists) + "," + ;
                " Jobs = "       + EscaparSQL(THIS.this_cJobs) + "," + ;
                " Contapgs = "   + TRANSFORM(THIS.this_nContaPgs) + "," + ;
                " GruConMoes = " + EscaparSQL(THIS.this_cGruConMoes) + "," + ;
                " CotUsus = "    + EscaparSQL(THIS.this_cCotUsus) + "," + ;
                " Datalts = GETDATE()" + ;
                " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                " AND Nopers = " + TRANSFORM(THIS.this_nNopers)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar lan" + CHR(231) + "amento:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Atualizar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
    *===========================================================================
    *-- Exclui lancamento: marca DatExcs/UsuExcs e depois deleta fisicamente
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- 1. Marcar data/usuario de exclusao (padrao do legado)
            loc_cSQL = "UPDATE SigMvCcr" + ;
                " SET DatExcs = GETDATE(), UsuExcs = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                " AND Nopers = " + TRANSFORM(THIS.this_nNopers)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                *-- 2. Excluir fisicamente o registro
                loc_cSQL = "DELETE FROM SigMvCcr" + ;
                    " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                    " AND Nopers = " + TRANSFORM(THIS.this_nNopers)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir lan" + CHR(231) + "amento:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao marcar exclus" + CHR(227) + "o:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em ExecutarExclusao: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

