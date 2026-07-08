# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, EMPS, NOPERS, LNCLASSERR, ICLIS, OPERS, DOPES, EMPDOPNUMS, OK, ALTCOTS, CONTAS, GRUPOS, MOEDAS, CONTAPGS, LOPAGINA, NVALOR, SE, NUMOS

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigmvccr.prg) - TRECHOS RELEVANTES PARA PASS SQL (2336 linhas total):

*-- Linhas 390 a 408:
390:         loc_oGrid.ColumnCount = 11
391:         loc_oGrid.GridLines   = 3
392:         loc_oGrid.RecordMark  = .F.
393:         loc_oGrid.DeleteMark  = .F.
394:         loc_oGrid.ReadOnly    = .T.
395:         loc_oGrid.FontName    = "Tahoma"
396:         loc_oGrid.FontSize    = 8
397: 
398:         *-- Larguras e headers iniciais (reconfigurados em CarregarLista apos RecordSource)
399:         loc_oGrid.Column1.Width           = 71
400:         loc_oGrid.Column1.Header1.Caption = "Data"
401:         loc_oGrid.Column2.Width           = 20
402:         loc_oGrid.Column2.Header1.Caption = "O"
403:         loc_oGrid.Column3.Width           = 90
404:         loc_oGrid.Column3.Header1.Caption = "Conta"
405:         loc_oGrid.Column4.Width           = 90
406:         loc_oGrid.Column4.Header1.Caption = "Contrapartida"
407:         loc_oGrid.Column5.Width           = 200
408:         loc_oGrid.Column5.Header1.Caption = "Hist" + CHR(243) + "rico"

*-- Linhas 1276 a 1295:
1276: 
1277:     *--------------------------------------------------------------------------
1278:     * CarregarLista - Carrega lancamentos no grid pelo periodo do filtro.
1279:     * Usa BO.BuscarPorPeriodo e reconfigura ControlSource + headers apos
1280:     * RecordSource (Problema 48: auto-bind sobrescreve ControlSource anterior).
1281:     *--------------------------------------------------------------------------
1282:     PROCEDURE CarregarLista()
1283:         LOCAL loc_lSucesso, loc_oGrid, loc_oPer, loc_dDtI, loc_dDtF
1284:         loc_lSucesso = .F.
1285: 
1286:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1287:             RETURN .T.
1288:         ENDIF
1289: 
1290:         TRY
1291:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
1292:             loc_oPer  = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.cnt_4c_Periodo
1293: 
1294:             *-- Ler datas do filtro com fallback para o mes atual
1295:             loc_dDtI = loc_oPer.txt_4c_DtInicial.Value

*-- Linhas 1309 a 1338:
1309:                 *-- RecordSource FORA de WITH (Problema 36)
1310:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
1311: 
1312:                 *-- ControlSource APOS RecordSource (Problema 48: auto-bind reseta)
1313:                 loc_oGrid.Column1.ControlSource  = "cursor_4c_Dados.Datas"
1314:                 loc_oGrid.Column2.ControlSource  = "cursor_4c_Dados.Opers"
1315:                 loc_oGrid.Column3.ControlSource  = "cursor_4c_Dados.Contas"
1316:                 loc_oGrid.Column4.ControlSource  = "cursor_4c_Dados.Scontas"
1317:                 loc_oGrid.Column5.ControlSource  = "cursor_4c_Dados.Hists"
1318:                 loc_oGrid.Column6.ControlSource  = "cursor_4c_Dados.Valors"
1319:                 loc_oGrid.Column7.ControlSource  = "cursor_4c_Dados.Svalors"
1320:                 loc_oGrid.Column8.ControlSource  = "cursor_4c_Dados.Nopers"
1321:                 loc_oGrid.Column9.ControlSource  = "cursor_4c_Dados.Nfs"
1322:                 loc_oGrid.Column10.ControlSource = "cursor_4c_Dados.Docus"
1323:                 loc_oGrid.Column11.ControlSource = "cursor_4c_Dados.Sopers"
1324: 
1325:                 *-- Redefinir headers APOS RecordSource (Problema 6/32: RecordSource reseta)
1326:                 loc_oGrid.Column1.Header1.Caption  = "Data"
1327:                 loc_oGrid.Column2.Header1.Caption  = "O"
1328:                 loc_oGrid.Column3.Header1.Caption  = "Conta"
1329:                 loc_oGrid.Column4.Header1.Caption  = "Contrapartida"
1330:                 loc_oGrid.Column5.Header1.Caption  = "Hist" + CHR(243) + "rico"
1331:                 loc_oGrid.Column6.Header1.Caption  = "D" + CHR(233) + "bito"
1332:                 loc_oGrid.Column7.Header1.Caption  = "Cr" + CHR(233) + "dito"
1333:                 loc_oGrid.Column8.Header1.Caption  = ""
1334:                 loc_oGrid.Column9.Header1.Caption  = "NF"
1335:                 loc_oGrid.Column10.Header1.Caption = "Documento"
1336:                 loc_oGrid.Column11.Header1.Caption = ""
1337: 
1338:                 *-- Redefinir larguras apos RecordSource

*-- Linhas 1415 a 1433:
1415:     *--------------------------------------------------------------------------
1416:     PROCEDURE GridAfterRowColChange(par_nColIndex)
1417:         IF USED("cursor_4c_Dados")
1418:             SELECT cursor_4c_Dados
1419:         ENDIF
1420:     ENDPROC
1421: 
1422:     *--------------------------------------------------------------------------
1423:     * BtnIncluirClick - Prepara BO para novo registro e abre Page2
1424:     *--------------------------------------------------------------------------
1425:     PROCEDURE BtnIncluirClick()
1426:         THIS.this_oBusinessObject.NovoRegistro()
1427:         THIS.this_cModoAtual = "INCLUIR"
1428:         THIS.LimparCampos()
1429:         THIS.HabilitarCampos(.T.)
1430:         THIS.AjustarBotoesPorModo()
1431:         THIS.pgf_4c_Paginas.Page2.txt_4c_Usuario.Value = gc_4c_UsuarioLogado
1432:         THIS.pgf_4c_Paginas.Page2.txt_4c_Data.Value    = DATE()
1433:         THIS.pgf_4c_Paginas.Page2.txt_4c_Venc.Value    = DATE()

*-- Linhas 1447 a 1465:
1447:             RETURN
1448:         ENDIF
1449: 
1450:         SELECT cursor_4c_Dados
1451:         loc_cEmps   = ALLTRIM(cursor_4c_Dados.Emps)
1452:         loc_nNopers = cursor_4c_Dados.Nopers
1453: 
1454:         IF EMPTY(loc_cEmps) OR loc_nNopers <= 0
1455:             MsgAviso("Registro inv" + CHR(225) + "lido.", "Aviso")
1456:             RETURN
1457:         ENDIF
1458: 
1459:         IF THIS.this_oBusinessObject.CarregarPorNopers(loc_cEmps, loc_nNopers)
1460:             THIS.this_cModoAtual = "VISUALIZAR"
1461:             THIS.BOParaForm()
1462:             THIS.HabilitarCampos(.F.)
1463:             THIS.AjustarBotoesPorModo()
1464:             THIS.AlternarPagina(2)
1465:         ELSE

*-- Linhas 1480 a 1498:
1480:             RETURN
1481:         ENDIF
1482: 
1483:         SELECT cursor_4c_Dados
1484:         loc_cEmps   = ALLTRIM(cursor_4c_Dados.Emps)
1485:         loc_nNopers = cursor_4c_Dados.Nopers
1486: 
1487:         IF EMPTY(loc_cEmps) OR loc_nNopers <= 0
1488:             MsgAviso("Registro inv" + CHR(225) + "lido.", "Aviso")
1489:             RETURN
1490:         ENDIF
1491: 
1492:         IF THIS.this_oBusinessObject.CarregarPorNopers(loc_cEmps, loc_nNopers)
1493:             THIS.this_oBusinessObject.EditarRegistro()
1494:             THIS.this_cModoAtual = "ALTERAR"
1495:             THIS.BOParaForm()
1496:             THIS.HabilitarCampos(.T.)
1497:             THIS.AjustarBotoesPorModo()
1498:             THIS.AlternarPagina(2)

*-- Linhas 1515 a 1533:
1515:             RETURN
1516:         ENDIF
1517: 
1518:         SELECT cursor_4c_Dados
1519:         loc_cEmps   = ALLTRIM(cursor_4c_Dados.Emps)
1520:         loc_nNopers = cursor_4c_Dados.Nopers
1521: 
1522:         IF EMPTY(loc_cEmps) OR loc_nNopers <= 0
1523:             MsgAviso("Registro inv" + CHR(225) + "lido.", "Aviso")
1524:             RETURN
1525:         ENDIF
1526: 
1527:         loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste lan" + CHR(231) + "amento?", ;
1528:             "Confirmar Exclus" + CHR(227) + "o")
1529: 
1530:         IF !loc_lConfirma
1531:             RETURN
1532:         ENDIF
1533: 

*-- Linhas 1882 a 1900:
1882:                         loc_oBusca.Show()
1883:                     ENDIF
1884:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaJob")
1885:                         SELECT cursor_4c_BuscaJob
1886:                         loc_oPg2.txt_4c_Job.Value  = ALLTRIM(cursor_4c_BuscaJob.Iclis)
1887:                         loc_oPg2.txt_4c_DJob.Value = ALLTRIM(cursor_4c_BuscaJob.Rclis)
1888:                     ENDIF
1889:                     loc_oBusca.Release()
1890:                 ENDIF
1891:             CATCH TO loc_oErro
1892:                 MsgErro("Erro ao buscar Job: " + loc_oErro.Message, "Erro")
1893:             ENDTRY
1894: 
1895:             IF USED("cursor_4c_BuscaJob")
1896:                 USE IN cursor_4c_BuscaJob
1897:             ENDIF
1898:         ENDIF
1899:     ENDPROC
1900: 

*-- Linhas 1919 a 1937:
1919:                         loc_oBusca.Show()
1920:                     ENDIF
1921:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
1922:                         SELECT cursor_4c_BuscaGrupo
1923:                         loc_oPg2.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
1924:                         loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
1925:                     ENDIF
1926:                     loc_oBusca.Release()
1927:                 ENDIF
1928:             CATCH TO loc_oErro
1929:                 MsgErro("Erro ao buscar Grupo: " + loc_oErro.Message, "Erro")
1930:             ENDTRY
1931: 
1932:             IF USED("cursor_4c_BuscaGrupo")
1933:                 USE IN cursor_4c_BuscaGrupo
1934:             ENDIF
1935:         ENDIF
1936:     ENDPROC
1937: 

*-- Linhas 1947 a 1980:
1947: 
1948:             loc_cFiltro = ""
1949:             IF !EMPTY(loc_cGrupo)
1950:                 loc_cFiltro = "grupos = " + EscaparSQL(loc_cGrupo)
1951:             ENDIF
1952: 
1953:             TRY
1954:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1955:                     "SigCdCli", "cursor_4c_BuscaConta", "Iclis", loc_cConta, ;
1956:                     "Conta Corrente", .F., .T., loc_cFiltro)
1957: 
1958:                 IF VARTYPE(loc_oBusca) = "O"
1959:                     IF !loc_oBusca.this_lAchouRegistro
1960:                         loc_oBusca.mAddColuna("Iclis", "", "Conta")
1961:                         loc_oBusca.mAddColuna("Rclis", "", "Nome")
1962:                         loc_oBusca.Show()
1963:                     ENDIF
1964:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1965:                         SELECT cursor_4c_BuscaConta
1966:                         loc_oPg2.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.Iclis)
1967:                         loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.Rclis)
1968:                     ENDIF
1969:                     loc_oBusca.Release()
1970:                 ENDIF
1971:             CATCH TO loc_oErro
1972:                 MsgErro("Erro ao buscar Conta: " + loc_oErro.Message, "Erro")
1973:             ENDTRY
1974: 
1975:             IF USED("cursor_4c_BuscaConta")
1976:                 USE IN cursor_4c_BuscaConta
1977:             ENDIF
1978:         ENDIF
1979:     ENDPROC
1980: 

*-- Linhas 2008 a 2026:
2008:                         loc_oBusca.Show()
2009:                     ENDIF
2010:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
2011:                         SELECT cursor_4c_BuscaMoeda
2012:                         loc_oPg2.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)
2013:                     ENDIF
2014:                     loc_oBusca.Release()
2015:                 ENDIF
2016:             CATCH TO loc_oErro
2017:                 MsgErro("Erro ao buscar Moeda: " + loc_oErro.Message, "Erro")
2018:             ENDTRY
2019: 
2020:             IF USED("cursor_4c_BuscaMoeda")
2021:                 USE IN cursor_4c_BuscaMoeda
2022:             ENDIF
2023:         ENDIF
2024:     ENDPROC
2025: 
2026:     *--------------------------------------------------------------------------

*-- Linhas 2085 a 2103:
2085:                         loc_oBusca.Show()
2086:                     ENDIF
2087:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSGrupo")
2088:                         SELECT cursor_4c_BuscaSGrupo
2089:                         loc_oPg2.txt_4c_SGrupo.Value  = ALLTRIM(cursor_4c_BuscaSGrupo.Codigos)
2090:                         loc_oPg2.txt_4c_SDGrupo.Value = ALLTRIM(cursor_4c_BuscaSGrupo.Descrs)
2091:                     ENDIF
2092:                     loc_oBusca.Release()
2093:                 ENDIF
2094:             CATCH TO loc_oErro
2095:                 MsgErro("Erro ao buscar SGrupo: " + loc_oErro.Message, "Erro")
2096:             ENDTRY
2097: 
2098:             IF USED("cursor_4c_BuscaSGrupo")
2099:                 USE IN cursor_4c_BuscaSGrupo
2100:             ENDIF
2101:         ENDIF
2102:     ENDPROC
2103: 

*-- Linhas 2113 a 2146:
2113: 
2114:             loc_cFiltro = ""
2115:             IF !EMPTY(loc_cSGrupo)
2116:                 loc_cFiltro = "grupos = " + EscaparSQL(loc_cSGrupo)
2117:             ENDIF
2118: 
2119:             TRY
2120:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2121:                     "SigCdCli", "cursor_4c_BuscaSConta", "Iclis", loc_cSConta, ;
2122:                     "Conta Corrente", .F., .T., loc_cFiltro)
2123: 
2124:                 IF VARTYPE(loc_oBusca) = "O"
2125:                     IF !loc_oBusca.this_lAchouRegistro
2126:                         loc_oBusca.mAddColuna("Iclis", "", "Conta")
2127:                         loc_oBusca.mAddColuna("Rclis", "", "Nome")
2128:                         loc_oBusca.Show()
2129:                     ENDIF
2130:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSConta")
2131:                         SELECT cursor_4c_BuscaSConta
2132:                         loc_oPg2.txt_4c_SConta.Value  = ALLTRIM(cursor_4c_BuscaSConta.Iclis)
2133:                         loc_oPg2.txt_4c_SDConta.Value = ALLTRIM(cursor_4c_BuscaSConta.Rclis)
2134:                     ENDIF
2135:                     loc_oBusca.Release()
2136:                 ENDIF
2137:             CATCH TO loc_oErro
2138:                 MsgErro("Erro ao buscar SConta: " + loc_oErro.Message, "Erro")
2139:             ENDTRY
2140: 
2141:             IF USED("cursor_4c_BuscaSConta")
2142:                 USE IN cursor_4c_BuscaSConta
2143:             ENDIF
2144:         ENDIF
2145:     ENDPROC
2146: 

*-- Linhas 2203 a 2221:
2203:                         loc_oBusca.Show()
2204:                     ENDIF
2205:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSMoeda")
2206:                         SELECT cursor_4c_BuscaSMoeda
2207:                         loc_oPg2.txt_4c_SMoeda.Value = ALLTRIM(cursor_4c_BuscaSMoeda.CMoes)
2208:                     ENDIF
2209:                     loc_oBusca.Release()
2210:                 ENDIF
2211:             CATCH TO loc_oErro
2212:                 MsgErro("Erro ao buscar SMoeda: " + loc_oErro.Message, "Erro")
2213:             ENDTRY
2214: 
2215:             IF USED("cursor_4c_BuscaSMoeda")
2216:                 USE IN cursor_4c_BuscaSMoeda
2217:             ENDIF
2218:         ENDIF
2219:     ENDPROC
2220: 
2221:     *--------------------------------------------------------------------------


### BO (C:\4c\projeto\app\classes\sigmvccrBO.prg):
*******************************************************************************
* sigmvccrBO.prg - Business Object para Conta Corrente Geral
* Tabela : SigMvCcr
* Herda de: BusinessBase
* PK      : Cidchaves (char 20, clustered)
* Chave negocio: Emps + Nopers
* Fase   : 2/8 - Metodos CRUD completos
*******************************************************************************

DEFINE CLASS sigmvccrBO AS BusinessBase

    *===========================================================================
    * IDENTIFICACAO DO REGISTRO
    *===========================================================================
    this_cEmps           = ""    && Empresa (C3)
    this_nNopers         = 0     && Numero da operacao (N7)
    this_cCidChaves      = ""    && Chave unica - PK (C20)

    *===========================================================================
    * DATAS
    *===========================================================================
    this_dDatas          = {}    && Data do lancamento (T NULL)
    this_dVencs          = {}    && Vencimento (T NULL)
    this_dDtEmis         = {}    && Data de emissao - coluna Dtemis (T NULL)
    this_dDatalts        = {}    && Data da alteracao (T NULL)
    this_dDatExcs        = {}    && Data da exclusao logica (T NULL)
    this_dDataConcs      = {}    && Data de conciliacao (T NULL)
    this_dDataTrans      = {}    && Data de transferencia (T NULL)

    *===========================================================================
    * OPERACAO PRINCIPAL (lado debito/credito)
    *===========================================================================
    this_cOpers          = ""    && Operacao D/C (C1)
    this_cGrupos         = ""    && Grupo conta corrente - ref SigCdGcr.Codigos (C10)
    this_cDGrupos        = ""    && Descricao do grupo (derivada via fAcessoContab) (C50)
    this_cContas         = ""    && Conta corrente (C10)
    this_cDContas        = ""    && Descricao da conta (derivada) (C50)
    this_cMoedas         = ""    && Moeda - ref SigCdMoe.CMoes (C3)
    this_nValors         = 0     && Valor do lancamento (N11,2)
    this_nCotacaos       = 0     && Cotacao / cambio (N15,7)

    *===========================================================================
    * OPERACAO SIMETRICA (contrapartida)
    *===========================================================================
    this_cSopers         = ""    && Operacao simetrica D/C (C1)
    this_cSGrupos        = ""    && Grupo simetrico - ref SigCdGcr.Codigos (C10)
    this_cSDGrupos       = ""    && Descricao grupo simetrico (derivada) (C50)
    this_cSContas        = ""    && Conta simetrica (C10)
    this_cSDContas       = ""    && Descricao conta simetrica (derivada) (C50)
    this_cSMoedas        = ""    && Moeda simetrica - ref SigCdMoe.CMoes (C3)
    this_nSValors        = 0     && Valor simetrico (N11,2)
    this_nSCotacaos      = 0     && Cotacao simetrica (N15,7)
    this_cShists         = ""    && Historico simetrico (C40) - coluna Shists

    *===========================================================================
    * HISTORICO E DOCUMENTOS
    *===========================================================================
    this_cHists          = ""    && Historico principal (C60 NULL)
    this_cHist2s         = ""    && Historico complementar (C80 NULL) - coluna Hist2s
    this_cNotas          = ""    && Nota fiscal - coluna Nfs (C10)
    this_cDocus          = ""    && Documento (C10)

    *===========================================================================
    * JOB
    *===========================================================================
    this_cJobs           = ""    && Job (conta tipo 10) - coluna Jobs (C10)
    this_cDJobs          = ""    && Descricao do job (derivada via fAcessoContas) (C50)

    *===========================================================================
    * AUDITORIA E CONTROLE
    *===========================================================================
    this_cUsualts        = ""    && Usuario da alteracao (C10)
    this_cUsuExcs        = ""    && Usuario da exclusao logica (C10)
    this_lAutos          = .F.   && Flag automatico (bit)
    this_lConcs          = .F.   && Flag conciliado (bit)
    this_cUsuConcs       = ""    && Usuario da conciliacao (C10)
    this_cAuditors       = ""    && Auditor (C10)
    this_dDtAudits       = {}    && Data de auditoria (T NULL)

    *===========================================================================
    * CAMPOS INTERNOS DO SISTEMA LEGADO
    *===========================================================================
    this_cVopers         = ""    && Operacao vinculada (C13)
    this_nNumes          = 0     && Numero vinculado - nota pagamento (N6)
    this_cDopes          = ""    && Documento de operacao (C20)
    this_cDopcs          = ""    && Documento de operacao complementar (C20)
    this_nNumcs          = 0     && Numero complementar (N6)
    this_cCotUsus        = ""    && Cotacao informada pelo usuario (C10)
    this_nContaPgs       = 0     && Lancar contas: 0=Nao, outros=Sim (N1)
    this_cGruConMoes     = ""    && Grupo+Conta+Moeda concatenados (C23)
    this_nNlancs         = 0     && Numero de lancamentos (N6)
    this_nNtrans         = 0     && Numero de transacao (N6)
    this_cLocals         = ""    && Local (C10)
    this_cContages       = ""    && Conta de agencia (C10)
    this_cContems        = ""    && Conta empresa (C10)
    this_cTipos          = ""    && Tipo (C1)
    this_cVlancs         = ""    && Valor de lancamento referencia (C10)
    this_cTitulos        = ""    && Titulo vinculado (C10)
    this_cTitBans        = ""    && Titulo bancario (C12)
    this_cGrupages       = ""    && Grupo de agencia (C10)
    this_cGrupems        = ""    && Grupo empresa (C10)
    this_cBContas        = ""    && Banco conta (C10)
    this_cBGrupos        = ""    && Banco grupo (C10)
    this_nBorderos       = 0     && Numero do border? (N6)
    this_nIntConts       = 0     && Numero de integracao (N6)
    this_nSaldos         = 0     && Saldo (N15,2)
    this_nSaldoNs        = 0     && Saldo novo (N15,2)
    this_nSaldoCs        = 0     && Saldo credito (N15,2)
    this_nValpags        = 0     && Valor pago (N11,2)
    this_nValliqs        = 0     && Valor liquido (N11,2)
    this_nValocurs       = 0     && Valor outra moeda (N11,2)
    this_nValprev        = 0     && Valor previsto (N11,2)
    this_cEmpdopncs      = ""    && Emps+Dopes+Numcs composto (C29)
    this_cEmpdopnums     = ""    && Emps+Dopes+Numes composto (C29)
    this_cPagos          = ""    && Flag pago (C1)
    this_cDopotps        = ""    && Documento operacao tipo (C23)
    this_cUsupagos       = ""    && Usuario do pagamento (C10)
    this_nTitcancs       = 0     && Titulo cancelado (N1)
    this_dDtConfs        = {}    && Data de confirmacao (T NULL)
    this_cUsuConfs       = ""    && Usuario de confirmacao (C10)
    this_nNopercancs     = 0     && Nopers cancelado (N7)
    this_cEspecienfs     = ""    && Especie da NF (C6)
    this_nImpostos       = 0     && Impostos (N11,2)
    this_nTpimpostos     = 0     && Tipo de imposto (N2)
    this_cTitPais        = ""    && Titulo pai (C10)
    this_cEmpccs         = ""    && Empresa CC (C3)
    this_nRecor          = 0     && Recorrente (N1)
    this_cCompet         = ""    && Competencia (C7)
    this_cEmpos          = ""    && Empresa operacao (C3)
    this_cOridopnums     = ""    && Documento origem (C29)
    this_cRContas        = ""    && Conta referencia (C10)
    this_cTpdocnf        = ""    && Tipo documento NF (C2)

    *===========================================================================
    * EXIBICAO SOMENTE (derivadas, sem coluna direta no banco)
    *===========================================================================
    this_cUsuarioDisplay = ""    && Usuario logado (somente leitura - get_Usuario)

    *===========================================================================
    * INIT - Configura tabela e campo chave
    *===========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigMvCcr"
        THIS.this_cCampoChave = "Cidchaves"
        RETURN .T.
    ENDPROC

    *===========================================================================
    * OBTERCHAVEPRIMARIA - Retorna chave para registro de auditoria
    *===========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *===========================================================================
    * BUSCAR - Lista lancamentos filtrados (sem filtro de periodo)
    * par_cFiltro: filtro SQL adicional (ex: "Contas = '001'" - sem AND)
    * Cria cursor cursor_4c_Dados com colunas do grid
    *===========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cEmps, loc_cExtra
        loc_lSucesso = .F.

        TRY
            loc_cEmps  = go_4c_Sistema.cCodEmpresa
            loc_cExtra = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                loc_cExtra = " AND " + par_cFiltro
            ENDIF

            loc_cSQL = "SELECT a.Emps, a.Nopers, a.Cidchaves," + ;
                " a.Datas, a.Vencs, a.Dtemis," + ;
                " a.Opers, a.Grupos, a.Contas, a.Moedas, a.Valors, a.Cotacaos," + ;
                " a.Sopers, a.Sgrupos, a.Scontas, a.Smoedas, a.Svalors, a.Scotacaos," + ;
                " a.Hists, a.Hist2s, a.Shists, a.Nfs, a.Docus," + ;
                " a.Jobs, a.Tipos, a.Usualts, a.Usuexcs," + ;
                " a.Concs, a.Contapgs, a.Datexcs," + ;
                " a.Dopes, a.Dopcs, a.Numes, a.Numcs," + ;
                " a.Cotusus, a.Gruconmoes, a.Vopers, a.Vlancs" + ;
                " FROM SigMvCcr a" + ;
                " WHERE a.Emps = " + EscaparSQL(loc_cEmps) + ;
                loc_cExtra + ;
                " ORDER BY a.Datas DESC, a.Nopers DESC"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult < 0
                MsgErro("Erro ao buscar lan" + CHR(231) + "amentos:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ELSE
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Buscar: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * BUSCARPORPERIODO - Lista lancamentos filtrados por intervalo de datas
    * par_dDtInicial : data inicial (inclusive)
    * par_dDtFinal   : data final   (inclusive)
    * par_cFiltroExtra: filtro SQL adicional opcional (sem AND)
    * Cria cursor cursor_4c_Dados com colunas do grid
    *===========================================================================
    FUNCTION BuscarPorPeriodo(par_dDtInicial, par_dDtFinal, par_cFiltroExtra)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        LOCAL loc_cEmps, loc_cDtI, loc_cDtF, loc_cExtra
        loc_lSucesso = .F.

        TRY
            loc_cEmps  = go_4c_Sistema.cCodEmpresa
            loc_cDtI   = FormatarDataSQL(par_dDtInicial)
            loc_cDtF   = FormatarDataSQL(par_dDtFinal)
            loc_cExtra = ""
            IF VARTYPE(par_cFiltroExtra) = "C" AND !EMPTY(par_cFiltroExtra)
                loc_cExtra = " AND " + par_cFiltroExtra
            ENDIF

            loc_cSQL = "SELECT a.Emps, a.Nopers, a.Cidchaves," + ;
                " a.Datas, a.Vencs, a.Dtemis," + ;
                " a.Opers, a.Grupos, a.Contas, a.Moedas, a.Valors, a.Cotacaos," + ;
                " a.Sopers, a.Sgrupos, a.Scontas, a.Smoedas, a.Svalors, a.Scotacaos," + ;
                " a.Hists, a.Hist2s, a.Shists, a.Nfs, a.Docus," + ;
                " a.Jobs, a.Tipos, a.Usualts, a.Usuexcs," + ;
                " a.Concs, a.Contapgs, a.Datexcs," + ;
                " a.Dopes, a.Dopcs, a.Numes, a.Numcs," + ;
                " a.Cotusus, a.Gruconmoes, a.Vopers, a.Vlancs" + ;
                " FROM SigMvCcr a" + ;
                " WHERE a.Emps = " + EscaparSQL(loc_cEmps) + ;
                "   AND a.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF + ;
                loc_cExtra + ;
                " ORDER BY a.Datas, a.Nopers"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult < 0
                MsgErro("Erro ao buscar lan" + CHR(231) + "amentos:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ELSE
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BuscarPorPeriodo: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * CARREGARPORCODIGO - Carrega lancamento pela PK (Cidchaves)
    * par_cCodigo: valor de Cidchaves
    *===========================================================================
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.Emps, a.Nopers, a.Cidchaves," + ;
                " a.Datas, a.Vencs, a.Dtemis, a.Datalts, a.Datexcs, a.Dataconcs," + ;
                " a.Opers, a.Grupos, a.Contas, a.Moedas, a.Valors, a.Cotacaos," + ;
                " a.Sopers, a.Sgrupos, a.Scontas, a.Smoedas, a.Svalors, a.Scotacaos," + ;
                " a.Hists, a.Hist2s, a.Shists, a.Nfs, a.Docus," + ;
                " a.Jobs, a.Tipos, a.Vlancs," + ;
                " a.Usualts, a.Usuexcs, a.Autos, a.Concs," + ;
                " a.Usuconcs, a.Auditors, a.Dtaudits," + ;
                " a.Contapgs, a.Vopers, a.Numes, a.Dopes, a.Dopcs, a.Numcs," + ;
                " a.Cotusus, a.Gruconmoes, a.Locals, a.Contages, a.Contems," + ;
                " a.Titulos, a.Titbans, a.Grupages, a.Grupems," + ;
                " a.Bcontas, a.Bgrupos, a.Borderos, a.Intconts," + ;
                " a.Saldos, a.Saldons, a.Saldocs, a.Valpags, a.Valliqs, a.Valocurs, a.Valprev," + ;
                " a.Empdopncs, a.Empdopnums, a.Pagos, a.Dopotps, a.Usupagos," + ;
                " a.Titcancs, a.Dtconfs, a.Usuconfs, a.Nopercancs, a.Especienfs," + ;
                " a.Impostos, a.Tpimpostos, a.Titpais, a.Empccs, a.Recor," + ;
                " a.Compet, a.Empos, a.Oridopnums, a.Rcontas, a.Tpdocnf," + ;
                " a.Nlancs, a.Ntrans" + ;
                " FROM SigMvCcr a" + ;
                " WHERE a.Cidchaves = " + EscaparSQL(par_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult < 0
                MsgErro("Erro ao carregar lan" + CHR(231) + "amento:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ELSE
                IF RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                loc_lSucesso = .F.
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * CARREGARPORNOPERS - Carrega lancamento pela chave de negocio (Emps + Nopers)
    * par_cEmps  : empresa
    * par_nNopers: numero da operacao
    *===========================================================================
    FUNCTION CarregarPorNopers(par_cEmps, par_nNopers)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.Emps, a.Nopers, a.Cidchaves," + ;
                " a.Datas, a.Vencs, a.Dtemis, a.Datalts, a.Datexcs, a.Dataconcs," + ;
                " a.Opers, a.Grupos, a.Contas, a.Moedas, a.Valors, a.Cotacaos," + ;
                " a.Sopers, a.Sgrupos, a.Scontas, a.Smoedas, a.Svalors, a.Scotacaos," + ;
                " a.Hists, a.Hist2s, a.Shists, a.Nfs, a.Docus," + ;
                " a.Jobs, a.Tipos, a.Vlancs," + ;
                " a.Usualts, a.Usuexcs, a.Autos, a.Concs," + ;
                " a.Usuconcs, a.Auditors, a.Dtaudits," + ;
                " a.Contapgs, a.Vopers, a.Numes, a.Dopes, a.Dopcs, a.Numcs," + ;
                " a.Cotusus, a.Gruconmoes, a.Locals, a.Contages, a.Contems," + ;
                " a.Titulos, a.Titbans, a.Grupages, a.Grupems," + ;
                " a.Bcontas, a.Bgrupos, a.Borderos, a.Intconts," + ;
                " a.Saldos, a.Saldons, a.Saldocs, a.Valpags, a.Valliqs, a.Valocurs, a.Valprev," + ;
                " a.Empdopncs, a.Empdopnums, a.Pagos, a.Dopotps, a.Usupagos," + ;
                " a.Titcancs, a.Dtconfs, a.Usuconfs, a.Nopercancs, a.Especienfs," + ;
                " a.Impostos, a.Tpimpostos, a.Titpais, a.Empccs, a.Recor," + ;
                " a.Compet, a.Empos, a.Oridopnums, a.Rcontas, a.Tpdocnf," + ;
                " a.Nlancs, a.Ntrans" + ;
                " FROM SigMvCcr a" + ;
                " WHERE a.Emps = " + EscaparSQL(par_cEmps) + ;
                "   AND a.Nopers = " + FormatarNumeroSQL(par_nNopers)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult < 0
                MsgErro("Erro ao carregar:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ELSE
                IF RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                loc_lSucesso = .F.
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorNopers: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * CARREGARDOCURSOR - Transfere dados do cursor para as propriedades this_*
    * par_cAliasCursor: nome do cursor (deve estar selecionado ou existir)
    *===========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cCidChaves  = TratarNulo(Cidchaves,  "C")
                THIS.this_cEmps       = TratarNulo(Emps,       "C")
                THIS.this_nNopers     = TratarNulo(Nopers,     "N")
                THIS.this_dDatas      = TratarNulo(Datas,      "D")
                THIS.this_dVencs      = TratarNulo(Vencs,      "D")
                THIS.this_dDtEmis     = TratarNulo(Dtemis,     "D")
                THIS.this_cOpers      = TratarNulo(Opers,      "C")
                THIS.this_cGrupos     = TratarNulo(Grupos,     "C")
                THIS.this_cContas     = TratarNulo(Contas,     "C")
                THIS.this_cMoedas     = TratarNulo(Moedas,     "C")
                THIS.this_nValors     = TratarNulo(Valors,     "N")
                THIS.this_nCotacaos   = TratarNulo(Cotacaos,   "N")
                THIS.this_cSopers     = TratarNulo(Sopers,     "C")
                THIS.this_cSGrupos    = TratarNulo(Sgrupos,    "C")
                THIS.this_cSContas    = TratarNulo(Scontas,    "C")
                THIS.this_cSMoedas    = TratarNulo(Smoedas,    "C")
                THIS.this_nSValors    = TratarNulo(Svalors,    "N")
                THIS.this_nSCotacaos  = TratarNulo(Scotacaos,  "N")
                THIS.this_cShists     = TratarNulo(Shists,     "C")
                THIS.this_cHists      = TratarNulo(Hists,      "C")
                THIS.this_cNotas      = TratarNulo(Nfs,        "C")
                THIS.this_cDocus      = TratarNulo(Docus,      "C")
                THIS.this_cJobs       = TratarNulo(Jobs,       "C")
                THIS.this_cTipos      = TratarNulo(Tipos,      "C")
                THIS.this_cUsualts    = TratarNulo(Usualts,    "C")
                THIS.this_cUsuExcs    = TratarNulo(Usuexcs,    "C")
                THIS.this_lAutos      = (NVL(Autos,  0) = 1)
                THIS.this_lConcs      = (NVL(Concs,  0) = 1)
                THIS.this_nContaPgs   = TratarNulo(Contapgs,  "N")
                THIS.this_cVopers     = TratarNulo(Vopers,    "C")
                THIS.this_nNumes      = TratarNulo(Numes,     "N")
                THIS.this_cDopes      = TratarNulo(Dopes,     "C")
                THIS.this_cDopcs      = TratarNulo(Dopcs,     "C")
                THIS.this_nNumcs      = TratarNulo(Numcs,     "N")
                THIS.this_cCotUsus    = TratarNulo(Cotusus,   "C")
                THIS.this_cGruConMoes = TratarNulo(Gruconmoes,"C")
                THIS.this_cVlancs     = TratarNulo(Vlancs,    "C")

                *-- Campos opcionais (apenas em carregamento completo - CarregarPorCodigo)
                IF TYPE("Hist2s") != "U"
                    THIS.this_cHist2s = TratarNulo(Hist2s, "C")
                ENDIF
                IF TYPE("Datalts") != "U"
                    THIS.this_dDatalts = TratarNulo(Datalts, "D")
                ENDIF
                IF TYPE("Datexcs") != "U"
                    THIS.this_dDatExcs = TratarNulo(Datexcs, "D")
                ENDIF
                IF TYPE("Dataconcs") != "U"
                    THIS.this_dDataConcs = TratarNulo(Dataconcs, "D")
                ENDIF
                IF TYPE("Usuconcs") != "U"
                    THIS.this_cUsuConcs = TratarNulo(Usuconcs, "C")
                ENDIF
                IF TYPE("Auditors") != "U"
                    THIS.this_cAuditors = TratarNulo(Auditors, "C")
                ENDIF
                IF TYPE("Dtaudits") != "U"
                    THIS.this_dDtAudits = TratarNulo(Dtaudits, "D")
                ENDIF
                IF TYPE("Locals") != "U"
                    THIS.this_cLocals = TratarNulo(Locals, "C")
                ENDIF
                IF TYPE("Contages") != "U"
                    THIS.this_cContages = TratarNulo(Contages, "C")
                ENDIF
                IF TYPE("Contems") != "U"
                    THIS.this_cContems = TratarNulo(Contems, "C")
                ENDIF
                IF TYPE("Titulos") != "U"
                    THIS.this_cTitulos = TratarNulo(Titulos, "C")
                ENDIF
                IF TYPE("Titbans") != "U"
                    THIS.this_cTitBans = TratarNulo(Titbans, "C")
                ENDIF
                IF TYPE("Grupages") != "U"
                    THIS.this_cGrupages = TratarNulo(Grupages, "C")
                ENDIF
                IF TYPE("Grupems") != "U"
                    THIS.this_cGrupems = TratarNulo(Grupems, "C")
                ENDIF
                IF TYPE("Bcontas") != "U"
                    THIS.this_cBContas = TratarNulo(Bcontas, "C")
                ENDIF
                IF TYPE("Bgrupos") != "U"
                    THIS.this_cBGrupos = TratarNulo(Bgrupos, "C")
                ENDIF
                IF TYPE("Borderos") != "U"
                    THIS.this_nBorderos = TratarNulo(Borderos, "N")
                ENDIF
                IF TYPE("Intconts") != "U"
                    THIS.this_nIntConts = TratarNulo(Intconts, "N")
                ENDIF
                IF TYPE("Saldos") != "U"
                    THIS.this_nSaldos = TratarNulo(Saldos, "N")
                ENDIF
                IF TYPE("Saldons") != "U"
                    THIS.this_nSaldoNs = TratarNulo(Saldons, "N")
                ENDIF
                IF TYPE("Saldocs") != "U"
                    THIS.this_nSaldoCs = TratarNulo(Saldocs, "N")
                ENDIF
                IF TYPE("Valpags") != "U"
                    THIS.this_nValpags = TratarNulo(Valpags, "N")
                ENDIF
                IF TYPE("Valliqs") != "U"
                    THIS.this_nValliqs = TratarNulo(Valliqs, "N")
                ENDIF
                IF TYPE("Valocurs") != "U"
                    THIS.this_nValocurs = TratarNulo(Valocurs, "N")
                ENDIF
                IF TYPE("Valprev") != "U"
                    THIS.this_nValprev = TratarNulo(Valprev, "N")
                ENDIF
                IF TYPE("Empdopncs") != "U"
                    THIS.this_cEmpdopncs = TratarNulo(Empdopncs, "C")
                ENDIF
                IF TYPE("Empdopnums") != "U"
                    THIS.this_cEmpdopnums = TratarNulo(Empdopnums, "C")
                ENDIF
                IF TYPE("Pagos") != "U"
                    THIS.this_cPagos = TratarNulo(Pagos, "C")
                ENDIF
                IF TYPE("Dopotps") != "U"
                    THIS.this_cDopotps = TratarNulo(Dopotps, "C")
                ENDIF
                IF TYPE("Usupagos") != "U"
                    THIS.this_cUsupagos = TratarNulo(Usupagos, "C")
                ENDIF
                IF TYPE("Titcancs") != "U"
                    THIS.this_nTitcancs = TratarNulo(Titcancs, "N")
                ENDIF
                IF TYPE("Dtconfs") != "U"
                    THIS.this_dDtConfs = TratarNulo(Dtconfs, "D")
                ENDIF
                IF TYPE("Usuconfs") != "U"
                    THIS.this_cUsuConfs = TratarNulo(Usuconfs, "C")
                ENDIF
                IF TYPE("Nopercancs") != "U"
                    THIS.this_nNopercancs = TratarNulo(Nopercancs, "N")
                ENDIF
                IF TYPE("Especienfs") != "U"
                    THIS.this_cEspecienfs = TratarNulo(Especienfs, "C")
                ENDIF
                IF TYPE("Impostos") != "U"
                    THIS.this_nImpostos = TratarNulo(Impostos, "N")
                ENDIF
                IF TYPE("Tpimpostos") != "U"
                    THIS.this_nTpimpostos = TratarNulo(Tpimpostos, "N")
                ENDIF
                IF TYPE("Titpais") != "U"
                    THIS.this_cTitPais = TratarNulo(Titpais, "C")
                ENDIF
                IF TYPE("Empccs") != "U"
                    THIS.this_cEmpccs = TratarNulo(Empccs, "C")
                ENDIF
                IF TYPE("Recor") != "U"
                    THIS.this_nRecor = TratarNulo(Recor, "N")
                ENDIF
                IF TYPE("Compet") != "U"
                    THIS.this_cCompet = TratarNulo(Compet, "C")
                ENDIF
                IF TYPE("Empos") != "U"
                    THIS.this_cEmpos = TratarNulo(Empos, "C")
                ENDIF
                IF TYPE("Oridopnums") != "U"
                    THIS.this_cOridopnums = TratarNulo(Oridopnums, "C")
                ENDIF
                IF TYPE("Rcontas") != "U"
                    THIS.this_cRContas = TratarNulo(Rcontas, "C")
                ENDIF
                IF TYPE("Tpdocnf") != "U"
                    THIS.this_cTpdocnf = TratarNulo(Tpdocnf, "C")
                ENDIF
                IF TYPE("Nlancs") != "U"
                    THIS.this_nNlancs = TratarNulo(Nlancs, "N")
                ENDIF
                IF TYPE("Ntrans") != "U"
                    THIS.this_nNtrans = TratarNulo(Ntrans, "N")
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarDoCursor: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * GERARNEXTNOPER - Gera o proximo numero de operacao para a empresa corrente
    * Retorna 0 em caso de erro
    *===========================================================================
    PROTECTED FUNCTION GerarNextNoper()
        LOCAL loc_cSQL, loc_nResult, loc_nProxNoper
        loc_nProxNoper = 0

        TRY
            loc_cSQL = "SELECT ISNULL(MAX(Nopers), 0) + 1 AS ProxNoper" + ;
                " FROM SigMvCcr" + ;
                " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProxNoper")

            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ProxNoper") > 0
                SELECT cursor_4c_ProxNoper
                loc_nProxNoper = TratarNulo(ProxNoper, "N")
            ENDIF

            IF USED("cursor_4c_ProxNoper")
                USE IN cursor_4c_ProxNoper
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao gerar pr" + CHR(243) + "ximo noper: " + loc_oErro.Message, "Erro")
            loc_nProxNoper = 0
        ENDTRY

        RETURN loc_nProxNoper
    ENDFUNC

    *===========================================================================
    * INSERIR - Insere novo lancamento em SigMvCcr
    * Gera automaticamente: Nopers, Cidchaves, Gruconmoes, Emps
    *===========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        LOCAL loc_nNopers, loc_cCidChaves, loc_cGruConMoes
        loc_lSucesso = .F.

        TRY
            *-- Gera proximo nopers
            loc_nNopers = THIS.GerarNextNoper()
            IF loc_nNopers <= 0
                MsgErro("Erro ao gerar n" + CHR(250) + "mero de opera" + CHR(231) + CHR(227) + "o!", "Erro")
                loc_lSucesso = .F.
            ELSE
                *-- Gera cidchaves: AAAAMMDD + 6 digitos do nopers (formato do legado)
                loc_cCidChaves = DTOS(IIF(EMPTY(THIS.this_dDatas), DATE(), THIS.this_dDatas)) + ;
                    PADL(LTRIM(STR(loc_nNopers)), 6, "0")

            *-- Gera gruconmoes (grupos+contas+moedas concatenados)
            loc_cGruConMoes = PADR(ALLTRIM(THIS.this_cGrupos), 10) + ;
                PADR(ALLTRIM(THIS.this_cContas), 10) + ;
                PADR(ALLTRIM(THIS.this_cMoedas), 3)

            *-- Atualiza propriedades geradas
            THIS.this_nNopers     = loc_nNopers
            THIS.this_cCidChaves  = loc_cCidChaves
            THIS.this_cGruConMoes = loc_cGruConMoes
            THIS.this_cEmps       = go_4c_Sistema.cCodEmpresa
            THIS.this_lAutos      = .F.
            THIS.this_cUsualts    = gc_4c_UsuarioLogado
            THIS.this_dDatalts    = DATETIME()

            loc_cSQL = "INSERT INTO SigMvCcr (" + ;
                "Emps, Nopers, Cidchaves," + ;
                " Datas, Vencs, Dtemis," + ;
                " Opers, Grupos, Contas, Moedas, Valors, Cotacaos," + ;
                " Sopers, Sgrupos, Scontas, Smoedas, Svalors, Scotacaos," + ;
                " Hists, Hist2s, Shists, Nfs, Docus," + ;
                " Jobs, Tipos, Vlancs," + ;
                " Usualts, Datalts, Autos, Concs," + ;
                " Usuconcs, Auditors," + ;
                " Contapgs, Vopers, Numes, Dopes, Dopcs, Numcs," + ;
                " Cotusus, Gruconmoes," + ;
                " Locals, Contages, Contems," + ;
                " Titulos, Titbans, Grupages, Grupems," + ;
                " Bcontas, Bgrupos, Borderos, Intconts," + ;
                " Saldos, Saldons, Saldocs, Valpags, Valliqs, Valocurs, Valprev," + ;
                " Empdopncs, Empdopnums, Pagos, Dopotps, Usupagos," + ;
                " Titcancs, Usuconfs, Nopercancs, Especienfs," + ;
                " Impostos, Tpimpostos, Titpais, Empccs, Recor," + ;
                " Compet, Empos, Oridopnums, Rcontas, Tpdocnf," + ;
                " Nlancs, Ntrans, Usuexcs" + ;
                ") VALUES (" + ;
                EscaparSQL(THIS.this_cEmps) + "," + ;
                FormatarNumeroSQL(THIS.this_nNopers) + "," + ;
                EscaparSQL(loc_cCidChaves) + "," + ;
                IIF(EMPTY(THIS.this_dDatas), "NULL", FormatarDataSQL(THIS.this_dDatas)) + "," + ;
                IIF(EMPTY(THIS.this_dVencs), "NULL", FormatarDataSQL(THIS.this_dVencs)) + "," + ;
                IIF(EMPTY(THIS.this_dDtEmis), "NULL", FormatarDataSQL(THIS.this_dDtEmis)) + "," + ;
                EscaparSQL(THIS.this_cOpers) + "," + ;
                EscaparSQL(THIS.this_cGrupos) + "," + ;
                EscaparSQL(THIS.this_cContas) + "," + ;
                EscaparSQL(THIS.this_cMoedas) + "," + ;
                FormatarNumeroSQL(THIS.this_nValors) + "," + ;
                FormatarNumeroSQL(THIS.this_nCotacaos) + "," + ;
                EscaparSQL(THIS.this_cSopers) + "," + ;
                EscaparSQL(THIS.this_cSGrupos) + "," + ;
                EscaparSQL(THIS.this_cSContas) + "," + ;
                EscaparSQL(THIS.this_cSMoedas) + "," + ;
                FormatarNumeroSQL(THIS.this_nSValors) + "," + ;
                FormatarNumeroSQL(THIS.this_nSCotacaos) + "," + ;
                EscaparSQL(THIS.this_cHists) + "," + ;
                EscaparSQL(THIS.this_cHist2s) + "," + ;
                EscaparSQL(THIS.this_cShists) + "," + ;
                EscaparSQL(THIS.this_cNotas) + "," + ;
                EscaparSQL(THIS.this_cDocus) + "," + ;
                EscaparSQL(THIS.this_cJobs) + "," + ;
                EscaparSQL(THIS.this_cTipos) + "," + ;
                EscaparSQL(THIS.this_cVlancs) + "," + ;
                EscaparSQL(THIS.this_cUsualts) + "," + ;
                FormatarDataSQL(THIS.this_dDatalts) + "," + ;
                IIF(THIS.this_lAutos, "1", "0") + "," + ;
                IIF(THIS.this_lConcs, "1", "0") + "," + ;
                EscaparSQL(THIS.this_cUsuConcs) + "," + ;
                EscaparSQL(THIS.this_cAuditors) + "," + ;
                FormatarNumeroSQL(THIS.this_nContaPgs) + "," + ;
                EscaparSQL(THIS.this_cVopers) + "," + ;
                FormatarNumeroSQL(THIS.this_nNumes) + "," + ;
                EscaparSQL(THIS.this_cDopes) + "," + ;
                EscaparSQL(THIS.this_cDopcs) + "," + ;
                FormatarNumeroSQL(THIS.this_nNumcs) + "," + ;
                EscaparSQL(THIS.this_cCotUsus) + "," + ;
                EscaparSQL(loc_cGruConMoes) + "," + ;
                EscaparSQL(THIS.this_cLocals) + "," + ;
                EscaparSQL(THIS.this_cContages) + "," + ;
                EscaparSQL(THIS.this_cContems) + "," + ;
                EscaparSQL(THIS.this_cTitulos) + "," + ;
                EscaparSQL(THIS.this_cTitBans) + "," + ;
                EscaparSQL(THIS.this_cGrupages) + "," + ;
                EscaparSQL(THIS.this_cGrupems) + "," + ;
                EscaparSQL(THIS.this_cBContas) + "," + ;
                EscaparSQL(THIS.this_cBGrupos) + "," + ;
                FormatarNumeroSQL(THIS.this_nBorderos) + "," + ;
                FormatarNumeroSQL(THIS.this_nIntConts) + "," + ;
                FormatarNumeroSQL(THIS.this_nSaldos) + "," + ;
                FormatarNumeroSQL(THIS.this_nSaldoNs) + "," + ;
                FormatarNumeroSQL(THIS.this_nSaldoCs) + "," + ;
                FormatarNumeroSQL(THIS.this_nValpags) + "," + ;
                FormatarNumeroSQL(THIS.this_nValliqs) + "," + ;
                FormatarNumeroSQL(THIS.this_nValocurs) + "," + ;
                FormatarNumeroSQL(THIS.this_nValprev) + "," + ;
                EscaparSQL(THIS.this_cEmpdopncs) + "," + ;
                EscaparSQL(THIS.this_cEmpdopnums) + "," + ;
                EscaparSQL(THIS.this_cPagos) + "," + ;
                EscaparSQL(THIS.this_cDopotps) + "," + ;
                EscaparSQL(THIS.this_cUsupagos) + "," + ;
                FormatarNumeroSQL(THIS.this_nTitcancs) + "," + ;
                EscaparSQL(THIS.this_cUsuConfs) + "," + ;
                FormatarNumeroSQL(THIS.this_nNopercancs) + "," + ;
                EscaparSQL(THIS.this_cEspecienfs) + "," + ;
                FormatarNumeroSQL(THIS.this_nImpostos) + "," + ;
                FormatarNumeroSQL(THIS.this_nTpimpostos) + "," + ;
                EscaparSQL(THIS.this_cTitPais) + "," + ;
                EscaparSQL(THIS.this_cEmpccs) + "," + ;
                FormatarNumeroSQL(THIS.this_nRecor) + "," + ;
                EscaparSQL(THIS.this_cCompet) + "," + ;
                EscaparSQL(THIS.this_cEmpos) + "," + ;
                EscaparSQL(THIS.this_cOridopnums) + "," + ;
                EscaparSQL(THIS.this_cRContas) + "," + ;
                EscaparSQL(THIS.this_cTpdocnf) + "," + ;
                FormatarNumeroSQL(THIS.this_nNlancs) + "," + ;
                FormatarNumeroSQL(THIS.this_nNtrans) + "," + ;
                EscaparSQL(THIS.this_cUsuExcs) + ;
                ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao inserir lan" + CHR(231) + "amento:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Inserir: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * ATUALIZAR - Atualiza lancamento existente identificado por Emps + Nopers
    * Atualiza apenas os campos editaveis pelo usuario na interface
    *===========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cGruConMoes
        loc_lSucesso = .F.

        TRY
            THIS.this_cUsualts    = gc_4c_UsuarioLogado
            THIS.this_dDatalts    = DATETIME()

            loc_cGruConMoes = PADR(ALLTRIM(THIS.this_cGrupos), 10) + ;
                PADR(ALLTRIM(THIS.this_cContas), 10) + ;
                PADR(ALLTRIM(THIS.this_cMoedas), 3)
            THIS.this_cGruConMoes = loc_cGruConMoes

            loc_cSQL = "UPDATE SigMvCcr SET" + ;
                " Datas      = " + IIF(EMPTY(THIS.this_dDatas), "NULL", FormatarDataSQL(THIS.this_dDatas)) + "," + ;
                " Vencs      = " + IIF(EMPTY(THIS.this_dVencs), "NULL", FormatarDataSQL(THIS.this_dVencs)) + "," + ;
                " Dtemis     = " + IIF(EMPTY(THIS.this_dDtEmis), "NULL", FormatarDataSQL(THIS.this_dDtEmis)) + "," + ;
                " Opers      = " + EscaparSQL(THIS.this_cOpers) + "," + ;
                " Grupos     = " + EscaparSQL(THIS.this_cGrupos) + "," + ;
                " Contas     = " + EscaparSQL(THIS.this_cContas) + "," + ;
                " Moedas     = " + EscaparSQL(THIS.this_cMoedas) + "," + ;
                " Valors     = " + FormatarNumeroSQL(THIS.this_nValors) + "," + ;
                " Cotacaos   = " + FormatarNumeroSQL(THIS.this_nCotacaos) + "," + ;
                " Sopers     = " + EscaparSQL(THIS.this_cSopers) + "," + ;
                " Sgrupos    = " + EscaparSQL(THIS.this_cSGrupos) + "," + ;
                " Scontas    = " + EscaparSQL(THIS.this_cSContas) + "," + ;
                " Smoedas    = " + EscaparSQL(THIS.this_cSMoedas) + "," + ;
                " Svalors    = " + FormatarNumeroSQL(THIS.this_nSValors) + "," + ;
                " Scotacaos  = " + FormatarNumeroSQL(THIS.this_nSCotacaos) + "," + ;
                " Hists      = " + EscaparSQL(THIS.this_cHists) + "," + ;
                " Hist2s     = " + EscaparSQL(THIS.this_cHist2s) + "," + ;
                " Shists     = " + EscaparSQL(THIS.this_cShists) + "," + ;
                " Nfs        = " + EscaparSQL(THIS.this_cNotas) + "," + ;
                " Docus      = " + EscaparSQL(THIS.this_cDocus) + "," + ;
                " Jobs       = " + EscaparSQL(THIS.this_cJobs) + "," + ;
                " Usualts    = " + EscaparSQL(THIS.this_cUsualts) + "," + ;
                " Datalts    = " + FormatarDataSQL(THIS.this_dDatalts) + "," + ;
                " Contapgs   = " + FormatarNumeroSQL(THIS.this_nContaPgs) + "," + ;
                " Cotusus    = " + EscaparSQL(THIS.this_cCotUsus) + "," + ;
                " Gruconmoes = " + EscaparSQL(loc_cGruConMoes) + ;
                " WHERE Emps   = " + EscaparSQL(THIS.this_cEmps) + ;
                "   AND Nopers = " + FormatarNumeroSQL(THIS.this_nNopers)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar lan" + CHR(231) + "amento:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * EXECUTAREXCLUSAO - Exclusao logica: marca Datexcs + Usuexcs (sem DELETE fisico)
    * Compativel com o legado (que usava UPDATE SigMvCcr SET DatExcs/UsuExcs)
    *===========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_dAgora
        loc_lSucesso = .F.

        TRY
            loc_dAgora = DATETIME()

            loc_cSQL = "UPDATE SigMvCcr SET" + ;
                " Datexcs = " + FormatarDataSQL(loc_dAgora) + "," + ;
                " Usuexcs = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                " WHERE Emps   = " + EscaparSQL(THIS.this_cEmps) + ;
                "   AND Nopers = " + FormatarNumeroSQL(THIS.this_nNopers)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao excluir lan" + CHR(231) + "amento:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ELSE
                THIS.this_dDatExcs = loc_dAgora
                THIS.this_cUsuExcs = gc_4c_UsuarioLogado
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ExecutarExclusao: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

