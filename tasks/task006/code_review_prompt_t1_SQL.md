# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DATEXCS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, EMPS, NOPERS, LNCLASSERR, ICLIS, OPERS, DOPES, EMPDOPNUMS, OK, ALTCOTS, CONTAS, GRUPOS, MOEDAS, CONTAPGS, LOPAGINA, NVALOR, SE, NUMOS
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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigmvccr.prg) - TRECHOS RELEVANTES PARA PASS SQL (2725 linhas total):

*-- Linhas 377 a 395:
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

*-- Linhas 401 a 436:
401:             .GridLines     = 3
402:             .GridLineWidth = 1
403:             .GridColor     = RGB(200, 200, 200)
404:             .DeleteMark    = .F.
405:             .RecordMark    = .F.
406:             .Scrollbars    = 3
407:             .FontName      = "Tahoma"
408:             .FontSize      = 8
409:             .Visible       = .T.
410:         ENDWITH
411: 
412:         *-- OBRIGATORIO: ControlSources APOS RecordSource
413:         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Datas"
414:         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Opers"
415:         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Contas"
416:         loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.Scontas"
417:         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Hists"
418:         loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.Valors"
419:         loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.Svalors"
420:         loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.Nfs"
421:         loc_oGrid.Column9.ControlSource = "cursor_4c_Dados.Docus"
422: 
423:         *-- Larguras das colunas
424:         loc_oGrid.Column1.Width = 80
425:         loc_oGrid.Column2.Width = 20
426:         loc_oGrid.Column3.Width = 100
427:         loc_oGrid.Column4.Width = 100
428:         loc_oGrid.Column5.Width = 250
429:         loc_oGrid.Column6.Width = 90
430:         loc_oGrid.Column7.Width = 90
431:         loc_oGrid.Column8.Width = 65
432:         loc_oGrid.Column9.Width = 100
433: 
434:         *-- OBRIGATORIO: Headers APOS RecordSource
435:         loc_oGrid.Column1.Header1.Caption = "Data"
436:         loc_oGrid.Column2.Header1.Caption = "O"

*-- Linhas 1116 a 1134:
1116:     *--------------------------------------------------------------------------
1117:     * CarregarLista - Carrega dados na grade da Page1
1118:     * Usa cursor temporario + ZAP + APPEND para preservar colunas do Grid
1119:     * (Problema #34: SQLEXEC direto destroi cursor e colunas do Grid)
1120:     *--------------------------------------------------------------------------
1121:     PROCEDURE CarregarLista()
1122:         LOCAL loc_lResultado, loc_cSQL, loc_nResultado
1123:         LOCAL loc_cFiltro, loc_cDtI, loc_cDtF, loc_oGrid
1124:         loc_lResultado = .F.
1125: 
1126:         TRY
1127:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1128:                 loc_lResultado = .T.
1129:             ELSE
1130:                 *-- Ler datas do filtro da Page1
1131:                 IF TYPE("THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_DtInicial") = "O"
1132:                     THIS.this_dDtInicial = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_DtInicial.Value
1133:                     THIS.this_dDtFinal   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_DtFinal.Value
1134:                 ENDIF

*-- Linhas 1141 a 1197:
1141:                     loc_cFiltro = " AND a.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF
1142:                 ENDIF
1143: 
1144:                 *-- Montar SELECT (colunas identicas ao CREATE CURSOR placeholder)
1145:                 loc_cSQL = "SELECT a.Emps, a.Nopers, a.Datas, a.Opers," + ;
1146:                     " a.Contas, a.Scontas, a.Hists, a.Valors, a.Svalors," + ;
1147:                     " a.Nfs, a.Docus, a.Grupos, a.Sgrupos, a.Moedas," + ;
1148:                     " a.Smoedas, a.Hist2s, a.Shists" + ;
1149:                     " FROM SigMvCcr a" + ;
1150:                     " WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
1151:                     " AND a.DatExcs IS NULL" + loc_cFiltro + ;
1152:                     " ORDER BY a.Datas DESC, a.Nopers DESC"
1153: 
1154:                 *-- SQLEXEC em cursor TEMPORARIO para preservar colunas do Grid
1155:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp")
1156:                 IF loc_nResultado >= 0
1157:                     SELECT cursor_4c_Dados
1158:                     ZAP
1159:                     IF RECCOUNT("cursor_4c_DadosTemp") > 0
1160:                         APPEND FROM DBF("cursor_4c_DadosTemp")
1161:                     ENDIF
1162:                     IF USED("cursor_4c_DadosTemp")
1163:                         USE IN cursor_4c_DadosTemp
1164:                     ENDIF
1165:                     GO TOP IN cursor_4c_Dados
1166: 
1167:                     *-- Obter referencia ao grid e reconfigurar Headers
1168:                     IF TYPE("THIS.pgf_4c_Paginas.Page1.grd_4c_Lista") = "O"
1169:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1170: 
1171:                         *-- Reconfigurar ControlSources (OBRIGATORIO apos carregar)
1172:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Datas"
1173:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Opers"
1174:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Contas"
1175:                         loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.Scontas"
1176:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Hists"
1177:                         loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.Valors"
1178:                         loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.Svalors"
1179:                         loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.Nfs"
1180:                         loc_oGrid.Column9.ControlSource = "cursor_4c_Dados.Docus"
1181: 
1182:                         *-- Reconfigurar Headers (OBRIGATORIO apos RecordSource/ControlSource)
1183:                         loc_oGrid.Column1.Header1.Caption = "Data"
1184:                         loc_oGrid.Column2.Header1.Caption = "O"
1185:                         loc_oGrid.Column3.Header1.Caption = "Conta"
1186:                         loc_oGrid.Column4.Header1.Caption = "Contrapartida"
1187:                         loc_oGrid.Column5.Header1.Caption = "Hist" + CHR(243) + "rico"
1188:                         loc_oGrid.Column6.Header1.Caption = "D" + CHR(233) + "bito"
1189:                         loc_oGrid.Column7.Header1.Caption = "Cr" + CHR(233) + "dito"
1190:                         loc_oGrid.Column8.Header1.Caption = "NF"
1191:                         loc_oGrid.Column9.Header1.Caption = "Documento"
1192: 
1193:                         loc_oGrid.Refresh()
1194:                     ENDIF
1195: 
1196:                     loc_lResultado = .T.
1197:                 ELSE

*-- Linhas 1313 a 1331:
1313:             RETURN
1314:         ENDIF
1315: 
1316:         SELECT cursor_4c_Dados
1317:         loc_nNopers = cursor_4c_Dados.Nopers
1318: 
1319:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nNopers)
1320:             THIS.BOParaForm()
1321:             THIS.this_cModoAtual = "VISUALIZAR"
1322:             THIS.HabilitarCampos(.F.)
1323:             THIS.AlternarPagina(2)
1324:         ELSE
1325:             MsgAviso("Erro ao carregar o registro selecionado.", "Visualizar")
1326:         ENDIF
1327:     ENDPROC
1328: 
1329:     *--------------------------------------------------------------------------
1330:     * BtnAlterarClick - Alterar lancamento selecionado
1331:     *--------------------------------------------------------------------------

*-- Linhas 1337 a 1355:
1337:             RETURN
1338:         ENDIF
1339: 
1340:         SELECT cursor_4c_Dados
1341:         loc_nNopers = cursor_4c_Dados.Nopers
1342: 
1343:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nNopers)
1344:             THIS.this_oBusinessObject.EditarRegistro()
1345:             THIS.BOParaForm()
1346:             THIS.this_cModoAtual = "ALTERAR"
1347:             THIS.HabilitarCampos(.T.)
1348:             THIS.AlternarPagina(2)
1349:         ELSE
1350:             MsgAviso("Erro ao carregar o registro selecionado.", "Alterar")
1351:         ENDIF
1352:     ENDPROC
1353: 
1354:     *--------------------------------------------------------------------------
1355:     * BtnExcluirClick - Excluir lancamento selecionado

*-- Linhas 1362 a 1380:
1362:             RETURN
1363:         ENDIF
1364: 
1365:         SELECT cursor_4c_Dados
1366:         loc_nNopers = cursor_4c_Dados.Nopers
1367: 
1368:         loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste lan" + CHR(231) + "amento?", ;
1369:             "Excluir Lan" + CHR(231) + "amento")
1370:         IF loc_lConfirma
1371:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nNopers)
1372:                 IF THIS.this_oBusinessObject.Excluir()
1373:                     MsgSucesso("Lan" + CHR(231) + "amento exclu" + CHR(237) + "do com sucesso!")
1374:                     THIS.CarregarLista()
1375:                 ENDIF
1376:             ELSE
1377:                 MsgAviso("Erro ao carregar o registro para exclus" + CHR(227) + "o.", "Excluir")
1378:             ENDIF
1379:         ENDIF
1380:     ENDPROC

*-- Linhas 1398 a 1416:
1398:             RETURN
1399:         ENDIF
1400: 
1401:         SELECT cursor_4c_Dados
1402:         loc_nNopers = cursor_4c_Dados.Nopers
1403: 
1404:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nNopers)
1405:             loc_cDope = ALLTRIM(THIS.this_oBusinessObject.this_cDopes)
1406: 
1407:             IF EMPTY(loc_cDope)
1408:                 *-- Sem documento de origem: exibir apenas o lancamento atual
1409:                 THIS.BOParaForm()
1410:                 THIS.this_cModoAtual = "VISUALIZAR"
1411:                 THIS.HabilitarCampos(.F.)
1412:                 THIS.AlternarPagina(2)
1413:             ELSE
1414:                 *-- Lancamento tem documento de origem (programacao/pagamento)
1415:                 *-- Abrir visualizacao do lancamento na Page2
1416:                 THIS.BOParaForm()

*-- Linhas 1666 a 1686:
1666:     PROTECTED PROCEDURE AbrirLookupGrupo(par_lSide)
1667:         LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao, loc_oPg2, loc_cFiltroEmps
1668:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1669:         loc_cFiltroEmps = "Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
1670: 
1671:         *-- MODO 1: Init faz SELECT * FROM SigCdGcr com filtro de empresa
1672:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1673:             "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", "", ;
1674:             "Busca de Grupos - Conta Corrente", .F., .F., loc_cFiltroEmps)
1675: 
1676:         IF VARTYPE(loc_oBusca) = "O"
1677:             *-- mAddColuna(campo, mascara, titulo) - 3 params, todos strings
1678:             loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1679:             loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1680:             loc_oBusca.Show()
1681: 
1682:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
1683:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
1684:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
1685: 
1686:                 IF !par_lSide

*-- Linhas 1742 a 1763:
1742:         ENDIF
1743: 
1744:         TRY
1745:             loc_nResultado = SQLEXEC(gnConnHandle, ;
1746:                 "SELECT Codigos, Descrs FROM SigCdGcr" + ;
1747:                 " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
1748:                 " AND Codigos = " + EscaparSQL(loc_cCodigo), ;
1749:                 "cursor_4c_BuscaGrupo")
1750: 
1751:             IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
1752:                 IF VARTYPE(loc_oDesc) = "O"
1753:                     loc_oDesc.Value = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
1754:                 ENDIF
1755:             ELSE
1756:                 MsgAviso("Grupo n" + CHR(227) + "o encontrado: " + loc_cCodigo, ;
1757:                     "Grupo")
1758:                 loc_oCod.Value = ""
1759:                 IF VARTYPE(loc_oDesc) = "O"
1760:                     loc_oDesc.Value = ""
1761:                 ENDIF
1762:             ENDIF
1763: 

*-- Linhas 1798 a 1832:
1798:             loc_cGrupo = ""
1799:         ENDIF
1800: 
1801:         *-- MODO 2: Pre-popular cursor via SQLEXEC (query com JOIN)
1802:         loc_cSQL = "SELECT DISTINCT s.Contas, c.Descrs" + ;
1803:             " FROM SigMvSlc s" + ;
1804:             " LEFT JOIN SigCdCcr c ON c.Contas = s.Contas" + ;
1805:             "  AND c.Emps = s.Emps" + ;
1806:             " WHERE s.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
1807:         IF !EMPTY(loc_cGrupo)
1808:             loc_cSQL = loc_cSQL + ;
1809:                 " AND s.Grupos = " + EscaparSQL(loc_cGrupo)
1810:         ENDIF
1811:         loc_cSQL = loc_cSQL + " ORDER BY s.Contas"
1812: 
1813:         IF USED("cursor_4c_BuscaConta")
1814:             USE IN cursor_4c_BuscaConta
1815:         ENDIF
1816: 
1817:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")
1818: 
1819:         IF loc_nResultado < 0 OR !USED("cursor_4c_BuscaConta") OR RECCOUNT("cursor_4c_BuscaConta") = 0
1820:             MsgAviso("Nenhuma conta encontrada para o grupo selecionado.", "Busca de Contas")
1821:             IF USED("cursor_4c_BuscaConta")
1822:                 USE IN cursor_4c_BuscaConta
1823:             ENDIF
1824:             RETURN
1825:         ENDIF
1826: 
1827:         *-- Cria FormBuscaAuxiliar sem params (MODO 2: cursor ja populado)
1828:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1829: 
1830:         IF VARTYPE(loc_oBusca) = "O"
1831:             loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaConta"
1832: 

*-- Linhas 1888 a 1909:
1888:         ENDIF
1889: 
1890:         TRY
1891:             loc_nResultado = SQLEXEC(gnConnHandle, ;
1892:                 "SELECT Contas, Descrs FROM SigCdCcr" + ;
1893:                 " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
1894:                 " AND Contas = " + EscaparSQL(loc_cCodigo), ;
1895:                 "cursor_4c_BuscaConta")
1896: 
1897:             IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_BuscaConta") > 0
1898:                 IF VARTYPE(loc_oDesc) = "O"
1899:                     loc_oDesc.Value = ALLTRIM(cursor_4c_BuscaConta.Descrs)
1900:                 ENDIF
1901:             ELSE
1902:                 MsgAviso("Conta n" + CHR(227) + "o encontrada: " + loc_cCodigo, ;
1903:                     "Conta")
1904:                 loc_oCod.Value = ""
1905:                 IF VARTYPE(loc_oDesc) = "O"
1906:                     loc_oDesc.Value = ""
1907:                 ENDIF
1908:             ENDIF
1909: 

*-- Linhas 1939 a 1960:
1939:         ENDIF
1940: 
1941:         TRY
1942:             loc_nResultado = SQLEXEC(gnConnHandle, ;
1943:                 "SELECT Jobs, Descrs FROM SigCdJob" + ;
1944:                 " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
1945:                 " AND Jobs = " + EscaparSQL(loc_cCodigo), ;
1946:                 "cursor_4c_BuscaJob")
1947: 
1948:             IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_BuscaJob") > 0
1949:                 IF TYPE("loc_oPg2.txt_4c_DJob") = "O"
1950:                     loc_oPg2.txt_4c_DJob.Value = ALLTRIM(cursor_4c_BuscaJob.Descrs)
1951:                 ENDIF
1952:             ELSE
1953:                 IF TYPE("loc_oPg2.txt_4c_DJob") = "O"
1954:                     loc_oPg2.txt_4c_DJob.Value = ""
1955:                 ENDIF
1956:             ENDIF
1957: 
1958:             IF USED("cursor_4c_BuscaJob")
1959:                 USE IN cursor_4c_BuscaJob
1960:             ENDIF

*-- Linhas 2075 a 2095:
2075:         ENDIF
2076: 
2077:         TRY
2078:             loc_nResultado = SQLEXEC(gnConnHandle, ;
2079:                 "SELECT CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + ;
2080:                 EscaparSQL(loc_cCodigo), ;
2081:                 "cursor_4c_ValMoeda")
2082: 
2083:             IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ValMoeda") > 0
2084:                 *-- Moeda valida: forcar codigo correto (maiusculo conforme banco)
2085:                 loc_oPg2.Controls(loc_cTxtMoeda).Value = ALLTRIM(cursor_4c_ValMoeda.CMoes)
2086:                 IF USED("cursor_4c_ValMoeda")
2087:                     USE IN cursor_4c_ValMoeda
2088:                 ENDIF
2089:                 *-- Atualizar cotacao para a nova moeda
2090:                 THIS.AtualizarCotacaoParaMoeda(loc_cCodigo, loc_cTxtCotacao, par_lSide)
2091:             ELSE
2092:                 *-- Moeda nao encontrada: abrir lookup para selecao
2093:                 IF USED("cursor_4c_ValMoeda")
2094:                     USE IN cursor_4c_ValMoeda
2095:                 ENDIF

*-- Linhas 2106 a 2146:
2106:     *--------------------------------------------------------------------------
2107:     * AtualizarCotacaoParaMoeda - Busca cotacao atual de uma moeda (SigCdCot)
2108:     * e atualiza o campo de cotacao correspondente.
2109:     * No legado: Select crSigCdCot / Set Order to Cotacaos Descending / Skip -1
2110:     *--------------------------------------------------------------------------
2111:     PROTECTED PROCEDURE AtualizarCotacaoParaMoeda(par_cMoeda, par_cTxtCotacao, par_lSide)
2112:         LOCAL loc_nResultado, loc_nCotacao, loc_oPg2
2113:         LOCAL loc_nValor, loc_nOutraCotacao
2114:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2115: 
2116:         IF EMPTY(par_cMoeda) OR par_cMoeda = "R"
2117:             *-- Real: cotacao = 1 (moeda padrao)
2118:             IF TYPE("loc_oPg2." + par_cTxtCotacao) = "O"
2119:                 loc_oPg2.Controls(par_cTxtCotacao).Value = 1
2120:             ENDIF
2121:             *-- Recalcular SVALOR
2122:             THIS.RecalcularSValor()
2123:             RETURN
2124:         ENDIF
2125: 
2126:         TRY
2127:             *-- Buscar cotacao mais recente em SigCdCot
2128:             loc_nResultado = SQLEXEC(gnConnHandle, ;
2129:                 "SELECT TOP 1 Cotacaos FROM SigCdCot" + ;
2130:                 " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
2131:                 " AND Moedas = " + EscaparSQL(par_cMoeda) + ;
2132:                 " ORDER BY Datas DESC, Cotacaos DESC", ;
2133:                 "cursor_4c_Cotacao")
2134: 
2135:             IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Cotacao") > 0
2136:                 loc_nCotacao = cursor_4c_Cotacao.Cotacaos
2137:                 IF TYPE("loc_oPg2." + par_cTxtCotacao) = "O"
2138:                     loc_oPg2.Controls(par_cTxtCotacao).Value = loc_nCotacao
2139:                 ENDIF
2140:             ENDIF
2141: 
2142:             IF USED("cursor_4c_Cotacao")
2143:                 USE IN cursor_4c_Cotacao
2144:             ENDIF
2145: 
2146:             *-- Recalcular SVALOR apos mudanca de cotacao

*-- Linhas 2475 a 2496:
2475:             loc_oPg2.txt_4c_DJob.Value = ""
2476:             IF !EMPTY(loc_cJob)
2477:                 TRY
2478:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
2479:                         "SELECT Jobs, Descrs FROM SigCdJob" + ;
2480:                         " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
2481:                         " AND Jobs = " + EscaparSQL(loc_cJob), ;
2482:                         "cursor_4c_BoJob")
2483:                     IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_BoJob") > 0
2484:                         loc_oPg2.txt_4c_DJob.Value = ALLTRIM(cursor_4c_BoJob.Descrs)
2485:                     ENDIF
2486:                     IF USED("cursor_4c_BoJob")
2487:                         USE IN cursor_4c_BoJob
2488:                     ENDIF
2489:                 CATCH TO loException
2490:                     IF USED("cursor_4c_BoJob")
2491:                         USE IN cursor_4c_BoJob
2492:                     ENDIF
2493:                     MsgErro("Erro ao buscar descri" + CHR(231) + CHR(227) + "o do Job: " + ;
2494:                         loException.Message, "Erro")
2495:                 ENDTRY
2496:             ENDIF

*-- Linhas 2510 a 2531:
2510:             loc_oPg2.txt_4c_Dgrupo.Value = ""
2511:             IF !EMPTY(loc_cGrupo)
2512:                 TRY
2513:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
2514:                         "SELECT Codigos, Descrs FROM SigCdGcr" + ;
2515:                         " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
2516:                         " AND Codigos = " + EscaparSQL(loc_cGrupo), ;
2517:                         "cursor_4c_BoGrupo")
2518:                     IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_BoGrupo") > 0
2519:                         loc_oPg2.txt_4c_Dgrupo.Value = ALLTRIM(cursor_4c_BoGrupo.Descrs)
2520:                     ENDIF
2521:                     IF USED("cursor_4c_BoGrupo")
2522:                         USE IN cursor_4c_BoGrupo
2523:                     ENDIF
2524:                 CATCH TO loException
2525:                     IF USED("cursor_4c_BoGrupo")
2526:                         USE IN cursor_4c_BoGrupo
2527:                     ENDIF
2528:                     MsgErro("Erro ao buscar descri" + CHR(231) + CHR(227) + "o do Grupo: " + ;
2529:                         loException.Message, "Erro")
2530:                 ENDTRY
2531:             ENDIF

*-- Linhas 2540 a 2561:
2540:             loc_oPg2.txt_4c_Dconta.Value = ""
2541:             IF !EMPTY(loc_cConta)
2542:                 TRY
2543:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
2544:                         "SELECT Contas, Descrs FROM SigCdCcr" + ;
2545:                         " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
2546:                         " AND Contas = " + EscaparSQL(loc_cConta), ;
2547:                         "cursor_4c_BoConta")
2548:                     IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_BoConta") > 0
2549:                         loc_oPg2.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BoConta.Descrs)
2550:                     ENDIF
2551:                     IF USED("cursor_4c_BoConta")
2552:                         USE IN cursor_4c_BoConta
2553:                     ENDIF
2554:                 CATCH TO loException
2555:                     IF USED("cursor_4c_BoConta")
2556:                         USE IN cursor_4c_BoConta
2557:                     ENDIF
2558:                     MsgErro("Erro ao buscar descri" + CHR(231) + CHR(227) + "o da Conta: " + ;
2559:                         loException.Message, "Erro")
2560:                 ENDTRY
2561:             ENDIF

*-- Linhas 2586 a 2607:
2586:             loc_oPg2.txt_4c_Sdgrupo.Value = ""
2587:             IF !EMPTY(loc_cSGrupo)
2588:                 TRY
2589:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
2590:                         "SELECT Codigos, Descrs FROM SigCdGcr" + ;
2591:                         " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
2592:                         " AND Codigos = " + EscaparSQL(loc_cSGrupo), ;
2593:                         "cursor_4c_BoSGrupo")
2594:                     IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_BoSGrupo") > 0
2595:                         loc_oPg2.txt_4c_Sdgrupo.Value = ALLTRIM(cursor_4c_BoSGrupo.Descrs)
2596:                     ENDIF
2597:                     IF USED("cursor_4c_BoSGrupo")
2598:                         USE IN cursor_4c_BoSGrupo
2599:                     ENDIF
2600:                 CATCH TO loException
2601:                     IF USED("cursor_4c_BoSGrupo")
2602:                         USE IN cursor_4c_BoSGrupo
2603:                     ENDIF
2604:                     MsgErro("Erro ao buscar descri" + CHR(231) + CHR(227) + "o do Grupo Credito: " + ;
2605:                         loException.Message, "Erro")
2606:                 ENDTRY
2607:             ENDIF

*-- Linhas 2616 a 2637:
2616:             loc_oPg2.txt_4c_Sdconta.Value = ""
2617:             IF !EMPTY(loc_cSConta)
2618:                 TRY
2619:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
2620:                         "SELECT Contas, Descrs FROM SigCdCcr" + ;
2621:                         " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
2622:                         " AND Contas = " + EscaparSQL(loc_cSConta), ;
2623:                         "cursor_4c_BoSConta")
2624:                     IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_BoSConta") > 0
2625:                         loc_oPg2.txt_4c_Sdconta.Value = ALLTRIM(cursor_4c_BoSConta.Descrs)
2626:                     ENDIF
2627:                     IF USED("cursor_4c_BoSConta")
2628:                         USE IN cursor_4c_BoSConta
2629:                     ENDIF
2630:                 CATCH TO loException
2631:                     IF USED("cursor_4c_BoSConta")
2632:                         USE IN cursor_4c_BoSConta
2633:                     ENDIF
2634:                     MsgErro("Erro ao buscar descri" + CHR(231) + CHR(227) + "o da Conta Credito: " + ;
2635:                         loException.Message, "Erro")
2636:                 ENDTRY
2637:             ENDIF


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
                " WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                " AND a.DatExcs IS NULL"

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
            THIS.this_lAutos      = (IIF(VARTYPE(Autos) = "L", Autos, (NVL(Autos, 0) = 1)))
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

