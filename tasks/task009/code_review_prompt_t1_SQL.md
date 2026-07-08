# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (6)
- [SQL-COLUNA] Coluna 'dopoptps' em INSERT INTO SigMvCcr NAO existe. (voce quis dizer 'dopes'?) Colunas validas: autos, concs, contages, contas, contems, cotacaos, datalts, datas, dataconcs, datatrans, datexcs, docus, dopes, dtemis, emps, grupages, grupems, grupos, hists, locals, moedas, nfs, nlancs, nopers, ntrans, numes, opers, saldocs, saldons, saldos, scontas, scotacaos, sgrupos, shists, smoedas, sopers, svalors, tipos, titbans, titulos, usualts, usuexcs, valliqs, valocurs, valors, valpags, vencs, vlancs, vopers, contapgs, dopcs, numcs, cotusus, bcontas, bgrupos, borderos, hist2s, intconts, usuconcs, auditors, dtaudits, valprev, cidchaves, empdopncs, empdopnums, gruconmoes, pagos, dopotps, usupagos, titcancs, dtconfs, usuconfs, nopercancs, especienfs, jobs, impostos, tpimpostos, titpais, empccs, recor, compet, empos, oridopnums, pastas, rcontas, tpdocnf
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, EMPS, NOPERS, LNCLASSERR, ICLIS, OPERS, DOPES, EMPDOPNUMS, OK, ALTCOTS, CONTAS, GRUPOS, MOEDAS, CONTAPGS, LOPAGINA, NVALOR, SE, NUMOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, EMPS, NOPERS, LNCLASSERR, ICLIS, OPERS, DOPES, EMPDOPNUMS, OK, ALTCOTS, CONTAS, GRUPOS, MOEDAS, CONTAPGS, LOPAGINA, NVALOR, SE, NUMOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, EMPS, NOPERS, LNCLASSERR, ICLIS, OPERS, DOPES, EMPDOPNUMS, OK, ALTCOTS, CONTAS, GRUPOS, MOEDAS, CONTAPGS, LOPAGINA, NVALOR, SE, NUMOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'I' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, EMPS, NOPERS, LNCLASSERR, ICLIS, OPERS, DOPES, EMPDOPNUMS, OK, ALTCOTS, CONTAS, GRUPOS, MOEDAS, CONTAPGS, LOPAGINA, NVALOR, SE, NUMOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, EMPS, NOPERS, LNCLASSERR, ICLIS, OPERS, DOPES, EMPDOPNUMS, OK, ALTCOTS, CONTAS, GRUPOS, MOEDAS, CONTAPGS, LOPAGINA, NVALOR, SE, NUMOS

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigmvccr.prg) - TRECHOS RELEVANTES PARA PASS SQL (2655 linhas total):

*-- Linhas 51 a 69:
51:             ELSE
52:                 *-- Cursor placeholder para grid (evita erros antes do primeiro load)
53:                 IF !USED("cursor_4c_Dados")
54:                     CREATE CURSOR cursor_4c_Dados ;
55:                         (cidchaves C(20), nopers N(10,0), opers C(1), ;
56:                          datas T, contas C(10), scontas C(10), ;
57:                          hists C(50), hist2s C(50), valors N(15,2), ;
58:                          svalors N(15,2), nfs C(15), docus C(20), ;
59:                          grupos C(10), sgrupos C(10), moedas C(3), ;
60:                          smoedas C(3), concs L, emps C(3), ;
61:                          vencs T, cotacaos N(15,7), scotacaos N(15,7), ;
62:                          contapgs N(1,0), jobs C(10), dtemis T, ;
63:                          sopers C(1), tipos C(1))
64:                 ENDIF
65: 
66:                 THIS.ConfigurarPageFrame()
67:                 THIS.ConfigurarPaginaLista()
68:                 THIS.ConfigurarPaginaDados()
69:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

*-- Linhas 427 a 445:
427:             .FontName          = "Verdana"
428:             .FontSize          = 8
429:             .ReadOnly          = .T.
430:             .DeleteMark        = .F.
431:             .RecordMark        = .F.
432:             .ScrollBars        = 3
433:             .GridLines         = 3
434:             .GridLineColor     = RGB(238, 238, 238)
435:             .ColumnCount       = 11
436:             .AllowHeaderSizing = .T.
437:             .Visible           = .T.
438:         ENDWITH
439: 
440:         loc_oGrade = loc_oPagina.grd_4c_Lista
441: 
442:         *-- Column1: Data (Width=78, Alignment=2)
443:         WITH loc_oGrade.Column1
444:             .Width     = 78
445:             .Alignment = 2

*-- Linhas 1352 a 1381:
1352:                 loc_lResultado = .T.
1353:                 loc_oGrade.RecordSource = "cursor_4c_Dados"
1354: 
1355:                 *-- Definir ControlSources APOS RecordSource (CRITICO!)
1356:                 loc_oGrade.Column1.ControlSource  = "cursor_4c_Dados.datas"
1357:                 loc_oGrade.Column2.ControlSource  = "cursor_4c_Dados.opers"
1358:                 loc_oGrade.Column3.ControlSource  = "cursor_4c_Dados.contas"
1359:                 loc_oGrade.Column4.ControlSource  = "cursor_4c_Dados.scontas"
1360:                 loc_oGrade.Column5.ControlSource  = "cursor_4c_Dados.hists"
1361:                 loc_oGrade.Column6.ControlSource  = "cursor_4c_Dados.valors"
1362:                 loc_oGrade.Column7.ControlSource  = "cursor_4c_Dados.moedas"
1363:                 loc_oGrade.Column8.ControlSource  = "cursor_4c_Dados.svalors"
1364:                 loc_oGrade.Column9.ControlSource  = "cursor_4c_Dados.smoedas"
1365:                 loc_oGrade.Column10.ControlSource = "cursor_4c_Dados.nfs"
1366:                 loc_oGrade.Column11.ControlSource = "cursor_4c_Dados.docus"
1367: 
1368:                 *-- Redefinir Header1.Caption APOS RecordSource (OBRIGATORIO - Problema 32)
1369:                 loc_oGrade.Column1.Header1.Caption  = "Data"
1370:                 loc_oGrade.Column2.Header1.Caption  = "O"
1371:                 loc_oGrade.Column3.Header1.Caption  = "Conta"
1372:                 loc_oGrade.Column4.Header1.Caption  = "Contrapartida"
1373:                 loc_oGrade.Column5.Header1.Caption  = "Hist" + CHR(243) + "rico"
1374:                 loc_oGrade.Column6.Header1.Caption  = "D" + CHR(233) + "bito"
1375:                 loc_oGrade.Column7.Header1.Caption  = " "
1376:                 loc_oGrade.Column8.Header1.Caption  = "Cr" + CHR(233) + "dito"
1377:                 loc_oGrade.Column9.Header1.Caption  = ""
1378:                 loc_oGrade.Column10.Header1.Caption = "NF"
1379:                 loc_oGrade.Column11.Header1.Caption = "Documento"
1380: 
1381:                 *-- DynamicForeColor: azul para registros conciliados

*-- Linhas 1569 a 1590:
1569:         loc_lCotas = .F.
1570: 
1571:         IF !EMPTY(loc_cMoeda) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
1572:             loc_cSQL = "SELECT TOP 1 cotas FROM SigCdMoe WHERE Cmoes = " + EscaparSQL(loc_cMoeda)
1573:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Moe") >= 0
1574:                 IF RECCOUNT("cursor_4c_Moe") > 0
1575:                     SELECT cursor_4c_Moe
1576:                     loc_lCotas = NVL(cursor_4c_Moe.cotas, .F.)
1577:                 ENDIF
1578:                 IF USED("cursor_4c_Moe")
1579:                     USE IN cursor_4c_Moe
1580:                 ENDIF
1581:             ENDIF
1582:         ENDIF
1583: 
1584:         loc_oPagina.txt_4c_COTACAO.Visible         = loc_lCotas
1585:         loc_oPagina.lbl_4c__Cotacao.Visible        = loc_lCotas
1586:         loc_oPagina.cmd_4c_Alteracotacao.Visible   = loc_lCotas AND THIS.this_cModoAtual = "ALTERAR"
1587:     ENDPROC
1588: 
1589:     *--------------------------------------------------------------------------
1590:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)

*-- Linhas 1626 a 1667:
1626:             RETURN
1627:         ENDIF
1628: 
1629:         SELECT cursor_4c_Dados
1630:         loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)
1631: 
1632:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
1633:             THIS.BOParaForm()
1634:             THIS.this_cModoAtual = "VISUALIZAR"
1635:             THIS.HabilitarCampos(.F.)
1636:             THIS.AlternarPagina(2)
1637:         ENDIF
1638:     ENDPROC
1639: 
1640:     *--------------------------------------------------------------------------
1641:     * BtnAlterarClick - Alterar movimento selecionado
1642:     * Legado: verifica bloqueio de periodo, conciliacao e auditoria
1643:     *--------------------------------------------------------------------------
1644:     PROCEDURE BtnAlterarClick()
1645:         LOCAL loc_cCidchaves
1646: 
1647:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1648:             MsgAviso("Nenhum registro selecionado!")
1649:             RETURN
1650:         ENDIF
1651: 
1652:         SELECT cursor_4c_Dados
1653: 
1654:         *-- Verificar se movimento esta conciliado
1655:         IF cursor_4c_Dados.concs
1656:             MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida !! Movimenta" + CHR(231) + CHR(227) + "o Conciliada !")
1657:             RETURN
1658:         ENDIF
1659: 
1660:         loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)
1661: 
1662:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
1663:             *-- Verificar se e automatico
1664:             IF THIS.this_oBusinessObject.this_lAutos
1665:                 MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida !! Movimenta" + CHR(231) + CHR(227) + "o Autom" + CHR(225) + "tica !")
1666:                 RETURN
1667:             ENDIF

*-- Linhas 1687 a 1705:
1687:             RETURN
1688:         ENDIF
1689: 
1690:         SELECT cursor_4c_Dados
1691: 
1692:         IF cursor_4c_Dados.concs
1693:             MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida !! Movimenta" + CHR(231) + CHR(227) + "o Conciliada !")
1694:             RETURN
1695:         ENDIF
1696: 
1697:         loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)
1698: 
1699:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
1700:             RETURN
1701:         ENDIF
1702: 
1703:         IF THIS.this_oBusinessObject.this_lAutos
1704:             MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida !! Movimenta" + CHR(231) + CHR(227) + "o Autom" + CHR(225) + "tica !")
1705:             RETURN

*-- Linhas 2018 a 2036:
2018:             loc_oBusca.Show()
2019: 
2020:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
2021:                 SELECT cursor_4c_BuscaGcr
2022:                 loc_oPagina.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaGcr.Codigos)
2023:                 loc_oPagina.txt_4c_Dgrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.Descrs)
2024:             ENDIF
2025: 
2026:             IF USED("cursor_4c_BuscaGcr")
2027:                 USE IN cursor_4c_BuscaGcr
2028:             ENDIF
2029:             loc_oBusca.Release()
2030: 
2031:         CATCH TO loc_oErro
2032:             MsgErro("Erro no lookup de Grupo: " + loc_oErro.Message, "Erro")
2033:         ENDTRY
2034:     ENDPROC
2035: 
2036:     *--------------------------------------------------------------------------

*-- Linhas 2047 a 2070:
2047:         ENDIF
2048: 
2049:         TRY
2050:             loc_cSQL = "SELECT TOP 1 Codigos, Descrs, Classes FROM SigCdGcr" + ;
2051:                        " WHERE Codigos = " + EscaparSQL(loc_cGrupo)
2052: 
2053:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Gcr") >= 0
2054:                 IF RECCOUNT("cursor_4c_Gcr") > 0
2055:                     SELECT cursor_4c_Gcr
2056:                     loc_oPagina.txt_4c_Dgrupo.Value = ALLTRIM(cursor_4c_Gcr.Descrs)
2057:                     IF EMPTY(cursor_4c_Gcr.Classes)
2058:                         MsgAviso("Imposs" + CHR(237) + "vel Realizar Lan" + CHR(231) + "amento Neste Grupo!!!" + CHR(13) + ;
2059:                                  "A Classe do Grupo N" + CHR(227) + "o Foi Informada!!!")
2060:                     ENDIF
2061:                 ELSE
2062:                     MsgAviso("Grupo n" + CHR(227) + "o encontrado: " + loc_cGrupo)
2063:                     loc_oPagina.txt_4c_Grupo.Value  = ""
2064:                     loc_oPagina.txt_4c_Dgrupo.Value = ""
2065:                     loc_oPagina.txt_4c_Grupo.SetFocus()
2066:                 ENDIF
2067:                 IF USED("cursor_4c_Gcr")
2068:                     USE IN cursor_4c_Gcr
2069:                 ENDIF
2070:             ENDIF

*-- Linhas 2107 a 2125:
2107:             loc_oBusca.Show()
2108: 
2109:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
2110:                 SELECT cursor_4c_BuscaCli
2111:                 loc_oPagina.txt_4c_Conta.Value   = ALLTRIM(cursor_4c_BuscaCli.Iclis)
2112:                 loc_oPagina.txt_4c_Dconta.Value  = ALLTRIM(cursor_4c_BuscaCli.Rclis)
2113:             ENDIF
2114: 
2115:             IF USED("cursor_4c_BuscaCli")
2116:                 USE IN cursor_4c_BuscaCli
2117:             ENDIF
2118:             loc_oBusca.Release()
2119: 
2120:         CATCH TO loc_oErro
2121:             MsgErro("Erro no lookup de Conta: " + loc_oErro.Message, "Erro")
2122:         ENDTRY
2123:     ENDPROC
2124: 
2125:     *--------------------------------------------------------------------------

*-- Linhas 2136 a 2158:
2136:         ENDIF
2137: 
2138:         TRY
2139:             loc_cSQL = "SELECT TOP 1 Iclis, Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cConta)
2140: 
2141:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cli") >= 0
2142:                 IF RECCOUNT("cursor_4c_Cli") > 0
2143:                     SELECT cursor_4c_Cli
2144:                     loc_oPagina.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_Cli.Rclis)
2145:                 ELSE
2146:                     MsgAviso("Conta n" + CHR(227) + "o encontrada: " + loc_cConta)
2147:                     loc_oPagina.txt_4c_Conta.Value  = ""
2148:                     loc_oPagina.txt_4c_Dconta.Value = ""
2149:                     loc_oPagina.txt_4c_Conta.SetFocus()
2150:                 ENDIF
2151:                 IF USED("cursor_4c_Cli")
2152:                     USE IN cursor_4c_Cli
2153:                 ENDIF
2154:             ENDIF
2155:         CATCH TO loc_oErro
2156:             MsgErro("Erro ao validar Conta: " + loc_oErro.Message, "Erro")
2157:         ENDTRY
2158:     ENDPROC

*-- Linhas 2191 a 2209:
2191:             loc_oBusca.Show()
2192: 
2193:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
2194:                 SELECT cursor_4c_BuscaMoe
2195:                 loc_oPagina.txt_4c_MOEDA.Value = UPPER(ALLTRIM(cursor_4c_BuscaMoe.Cmoes))
2196:                 THIS.AtualizarVisibilidadeCotacao()
2197:             ENDIF
2198: 
2199:             IF USED("cursor_4c_BuscaMoe")
2200:                 USE IN cursor_4c_BuscaMoe
2201:             ENDIF
2202:             loc_oBusca.Release()
2203: 
2204:         CATCH TO loc_oErro
2205:             MsgErro("Erro no lookup de Moeda: " + loc_oErro.Message, "Erro")
2206:         ENDTRY
2207:     ENDPROC
2208: 
2209:     *==========================================================================

*-- Linhas 2240 a 2258:
2240:             loc_oBusca.Show()
2241: 
2242:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr2")
2243:                 SELECT cursor_4c_BuscaGcr2
2244:                 loc_oPagina.txt_4c_SGRUPO.Value  = ALLTRIM(cursor_4c_BuscaGcr2.Codigos)
2245:                 loc_oPagina.txt_4c_Sdgrupo.Value = ALLTRIM(cursor_4c_BuscaGcr2.Descrs)
2246:             ENDIF
2247: 
2248:             IF USED("cursor_4c_BuscaGcr2")
2249:                 USE IN cursor_4c_BuscaGcr2
2250:             ENDIF
2251:             loc_oBusca.Release()
2252: 
2253:         CATCH TO loc_oErro
2254:             MsgErro("Erro no lookup de SGrupo: " + loc_oErro.Message, "Erro")
2255:         ENDTRY
2256:     ENDPROC
2257: 
2258:     *--------------------------------------------------------------------------

*-- Linhas 2269 a 2291:
2269:         ENDIF
2270: 
2271:         TRY
2272:             loc_cSQL = "SELECT TOP 1 Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cSGrupo)
2273: 
2274:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcrS") >= 0
2275:                 IF RECCOUNT("cursor_4c_GcrS") > 0
2276:                     SELECT cursor_4c_GcrS
2277:                     loc_oPagina.txt_4c_Sdgrupo.Value = ALLTRIM(cursor_4c_GcrS.Descrs)
2278:                 ELSE
2279:                     MsgAviso("Grupo (Cr" + CHR(233) + "dito) n" + CHR(227) + "o encontrado: " + loc_cSGrupo)
2280:                     loc_oPagina.txt_4c_SGRUPO.Value  = ""
2281:                     loc_oPagina.txt_4c_Sdgrupo.Value = ""
2282:                     loc_oPagina.txt_4c_SGRUPO.SetFocus()
2283:                 ENDIF
2284:                 IF USED("cursor_4c_GcrS")
2285:                     USE IN cursor_4c_GcrS
2286:                 ENDIF
2287:             ENDIF
2288:         CATCH TO loc_oErro
2289:             MsgErro("Erro ao validar SGrupo: " + loc_oErro.Message, "Erro")
2290:         ENDTRY
2291:     ENDPROC

*-- Linhas 2324 a 2342:
2324:             loc_oBusca.Show()
2325: 
2326:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli2")
2327:                 SELECT cursor_4c_BuscaCli2
2328:                 loc_oPagina.txt_4c_SCONTA.Value  = ALLTRIM(cursor_4c_BuscaCli2.Iclis)
2329:                 loc_oPagina.txt_4c_SDCONTA.Value = ALLTRIM(cursor_4c_BuscaCli2.Rclis)
2330:             ENDIF
2331: 
2332:             IF USED("cursor_4c_BuscaCli2")
2333:                 USE IN cursor_4c_BuscaCli2
2334:             ENDIF
2335:             loc_oBusca.Release()
2336: 
2337:         CATCH TO loc_oErro
2338:             MsgErro("Erro no lookup de SConta: " + loc_oErro.Message, "Erro")
2339:         ENDTRY
2340:     ENDPROC
2341: 
2342:     *--------------------------------------------------------------------------

*-- Linhas 2353 a 2375:
2353:         ENDIF
2354: 
2355:         TRY
2356:             loc_cSQL = "SELECT TOP 1 Iclis, Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cSConta)
2357: 
2358:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliS") >= 0
2359:                 IF RECCOUNT("cursor_4c_CliS") > 0
2360:                     SELECT cursor_4c_CliS
2361:                     loc_oPagina.txt_4c_SDCONTA.Value = ALLTRIM(cursor_4c_CliS.Rclis)
2362:                 ELSE
2363:                     MsgAviso("Conta (Cr" + CHR(233) + "dito) n" + CHR(227) + "o encontrada: " + loc_cSConta)
2364:                     loc_oPagina.txt_4c_SCONTA.Value  = ""
2365:                     loc_oPagina.txt_4c_SDCONTA.Value = ""
2366:                     loc_oPagina.txt_4c_SCONTA.SetFocus()
2367:                 ENDIF
2368:                 IF USED("cursor_4c_CliS")
2369:                     USE IN cursor_4c_CliS
2370:                 ENDIF
2371:             ENDIF
2372:         CATCH TO loc_oErro
2373:             MsgErro("Erro ao validar SConta: " + loc_oErro.Message, "Erro")
2374:         ENDTRY
2375:     ENDPROC

*-- Linhas 2408 a 2426:
2408:             loc_oBusca.Show()
2409: 
2410:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe2")
2411:                 SELECT cursor_4c_BuscaMoe2
2412:                 loc_oPagina.txt_4c_Smoeda.Value = UPPER(ALLTRIM(cursor_4c_BuscaMoe2.Cmoes))
2413:                 THIS.AtualizarVisibilidadeSCotacao()
2414:             ENDIF
2415: 
2416:             IF USED("cursor_4c_BuscaMoe2")
2417:                 USE IN cursor_4c_BuscaMoe2
2418:             ENDIF
2419:             loc_oBusca.Release()
2420: 
2421:         CATCH TO loc_oErro
2422:             MsgErro("Erro no lookup de SMoeda: " + loc_oErro.Message, "Erro")
2423:         ENDTRY
2424:     ENDPROC
2425: 
2426:     *--------------------------------------------------------------------------

*-- Linhas 2435 a 2456:
2435:         loc_lCotas  = .F.
2436: 
2437:         IF !EMPTY(loc_cSMoeda) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
2438:             loc_cSQL = "SELECT TOP 1 cotas FROM SigCdMoe WHERE Cmoes = " + EscaparSQL(loc_cSMoeda)
2439:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeS") >= 0
2440:                 IF RECCOUNT("cursor_4c_MoeS") > 0
2441:                     SELECT cursor_4c_MoeS
2442:                     loc_lCotas = NVL(cursor_4c_MoeS.cotas, .F.)
2443:                 ENDIF
2444:                 IF USED("cursor_4c_MoeS")
2445:                     USE IN cursor_4c_MoeS
2446:                 ENDIF
2447:             ENDIF
2448:         ENDIF
2449: 
2450:         loc_oPagina.txt_4c_SCOTACAO.Visible       = loc_lCotas
2451:         loc_oPagina.lbl_4c__sCotacao.Visible      = loc_lCotas
2452:         loc_oPagina.cmd_4c_Alterascotacao.Visible = loc_lCotas AND THIS.this_cModoAtual = "ALTERAR"
2453:     ENDPROC
2454: 
2455:     *==========================================================================
2456:     * HANDLERS DE LOOKUP - JOB

*-- Linhas 2486 a 2504:
2486:             loc_oBusca.Show()
2487: 
2488:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaJob")
2489:                 SELECT cursor_4c_BuscaJob
2490:                 loc_oPagina.txt_4c_Job.Value  = ALLTRIM(cursor_4c_BuscaJob.Iclis)
2491:                 loc_oPagina.txt_4c_DJob.Value = ALLTRIM(cursor_4c_BuscaJob.Rclis)
2492:             ENDIF
2493: 
2494:             IF USED("cursor_4c_BuscaJob")
2495:                 USE IN cursor_4c_BuscaJob
2496:             ENDIF
2497:             loc_oBusca.Release()
2498: 
2499:         CATCH TO loc_oErro
2500:             MsgErro("Erro no lookup de Job: " + loc_oErro.Message, "Erro")
2501:         ENDTRY
2502:     ENDPROC
2503: 
2504:     *--------------------------------------------------------------------------

*-- Linhas 2515 a 2537:
2515:         ENDIF
2516: 
2517:         TRY
2518:             loc_cSQL = "SELECT TOP 1 Iclis, Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cJob)
2519: 
2520:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Job") >= 0
2521:                 IF RECCOUNT("cursor_4c_Job") > 0
2522:                     SELECT cursor_4c_Job
2523:                     loc_oPagina.txt_4c_DJob.Value = ALLTRIM(cursor_4c_Job.Rclis)
2524:                 ELSE
2525:                     MsgAviso("Job n" + CHR(227) + "o encontrado: " + loc_cJob)
2526:                     loc_oPagina.txt_4c_Job.Value  = ""
2527:                     loc_oPagina.txt_4c_DJob.Value = ""
2528:                     loc_oPagina.txt_4c_Job.SetFocus()
2529:                 ENDIF
2530:                 IF USED("cursor_4c_Job")
2531:                     USE IN cursor_4c_Job
2532:                 ENDIF
2533:             ENDIF
2534:         CATCH TO loc_oErro
2535:             MsgErro("Erro ao validar Job: " + loc_oErro.Message, "Erro")
2536:         ENDTRY
2537:     ENDPROC

*-- Linhas 2554 a 2572:
2554: 
2555:         TRY
2556:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND !EOF("cursor_4c_Dados")
2557:                 SELECT cursor_4c_Dados
2558:                 *-- A visibilidade do Anexa depende de tabelas de outros modulos
2559:                 *-- Simplificado: sempre ocultar (sem acesso a SigCdPgr/SigMvCab/SigCqChm)
2560:                 loc_lMostraAnexa = .F.
2561:             ENDIF
2562:         CATCH TO loc_oErro
2563:             *-- Nao mostrar erro em AfterRowColChange (pode disparar frequentemente)
2564:             loc_lMostraAnexa = .F.
2565:         ENDTRY
2566: 
2567:         loc_oPagina.cmd_4c_Anexa.Visible    = loc_lMostraAnexa
2568:         loc_oPagina.shp_4c_ShpAnexa.Visible = loc_lMostraAnexa
2569:     ENDPROC
2570: 
2571:     *==========================================================================
2572:     * UTILITARIOS


### BO (C:\4c\projeto\app\classes\sigmvccrBO.prg):
*==============================================================================
* sigmvccrBO.prg - Business Object para Movimentos de Conta Corrente Geral
*
* Tabela principal : SigMvCcr
* Chave primaria   : Emps + Nopers (composta)
* Herda de         : BusinessBase
*
* FASE 1/8 - Declaracoes de propriedades e Init()
* Fases seguintes adicionarao: CarregarDoCursor, Inserir, Atualizar,
*   ExecutarExclusao, Buscar, CarregarPorCodigo
*==============================================================================

DEFINE CLASS sigmvccrBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Identificacao da tabela (nomes CORRETOS do BusinessBase)
    *--------------------------------------------------------------------------
    this_cTabela      = "SigMvCcr"
    this_cCampoChave  = "Nopers"

    *--------------------------------------------------------------------------
    * Chave primaria composta: Emps + Nopers
    *--------------------------------------------------------------------------
    this_cEmps        = ""    && C(3)  - Empresa (parte 1 da PK)
    this_nNopers      = 0     && N     - Numero da Operacao (parte 2 da PK)

    *--------------------------------------------------------------------------
    * Operacao e vinculo com outros documentos
    *--------------------------------------------------------------------------
    this_cOpers       = ""    && C(1)  - Tipo: D=Debito / C=Credito
    this_cSopers      = ""    && C(1)  - Contra-operacao: C/D (espelho)
    this_cDopes       = ""    && C     - Tipo documento debito vinculado
    this_nNumes       = 0     && N     - Numero documento debito vinculado
    this_cDopcs       = ""    && C     - Tipo documento credito vinculado
    this_nNumcs       = 0     && N     - Numero documento credito vinculado
    this_cVOpers      = ""    && C     - Vinculo de operacao externa

    *--------------------------------------------------------------------------
    * Datas
    *--------------------------------------------------------------------------
    this_dDatas       = {}    && T     - Data do lancamento
    this_dVencs       = {}    && T     - Data de vencimento
    this_dDtEmiss     = {}    && T     - Data de emissao
    this_dDatAlts     = {}    && T     - Data de alteracao
    this_dDatExcs     = {}    && T     - Data de exclusao

    *--------------------------------------------------------------------------
    * Lado Debito
    *--------------------------------------------------------------------------
    this_cGrupos      = ""    && C     - Grupo debito
    this_cContas      = ""    && C     - Conta debito
    this_cMoedas      = ""    && C     - Moeda debito
    this_nCotacaos    = 0     && N     - Cotacao debito
    this_nValors      = 0     && N     - Valor debito

    *--------------------------------------------------------------------------
    * Lado Credito (S = S-side / contra-partida)
    *--------------------------------------------------------------------------
    this_cSgrupos     = ""    && C     - Grupo credito
    this_cScontas     = ""    && C     - Conta credito
    this_cSmoedas     = ""    && C     - Moeda credito
    this_nScotacaos   = 0     && N     - Cotacao credito
    this_nSvalors     = 0     && N     - Valor credito

    *--------------------------------------------------------------------------
    * Historico e documentacao
    *--------------------------------------------------------------------------
    this_cHists       = ""    && C     - Historico linha 1
    this_cHist2s      = ""    && C     - Historico linha 2
    this_cNotas       = ""    && C     - Numero da nota fiscal
    this_cDocus       = ""    && C     - Numero do documento

    *--------------------------------------------------------------------------
    * Job / Centro de custo
    *--------------------------------------------------------------------------
    this_cJobs        = ""    && C     - Codigo do job (conta tipo 10)

    *--------------------------------------------------------------------------
    * Campos de controle interno
    *--------------------------------------------------------------------------
    this_lAutos       = .F.   && L     - Flag auto-lancamento
    this_cGruconmoes  = ""    && C     - Concatenacao Grupo+Conta+Moeda
    this_cCidchaves   = ""    && C     - Chave unica do registro (gerada por fGerUniqueKey)
    this_cCotUsus     = ""    && C     - Cotacao definida manualmente pelo usuario
    this_nContapgs    = 0     && N     - Opcao Lancar Contas (0=Nao)
    this_nConcs       = 0     && N     - Flag conciliado

    *--------------------------------------------------------------------------
    * Auditoria
    *--------------------------------------------------------------------------
    this_cUsualts     = ""    && C     - Usuario que fez a ultima alteracao
    this_cUsuExcs     = ""    && C     - Usuario que fez a exclusao

    *--------------------------------------------------------------------------
    * Propriedades de exibicao (lookup - nao armazenadas na tabela SigMvCcr)
    *--------------------------------------------------------------------------
    this_cDGrupos     = ""    && C     - Descricao do grupo debito (SigCdGcr)
    this_cDContas     = ""    && C     - Descricao da conta debito
    this_cDSgrupos    = ""    && C     - Descricao do grupo credito (SigCdGcr)
    this_cDScontas    = ""    && C     - Descricao da conta credito
    this_cUsuario     = ""    && C     - Nome/login do usuario logado (exibicao)
    this_cDJobs       = ""    && C     - Descricao do job (conta tipo 10)

    *--------------------------------------------------------------------------
    * Propriedades de filtro para Buscar() - periodo
    *--------------------------------------------------------------------------
    this_dDtInicial   = {}    && D     - Data inicial para filtro de periodo
    this_dDtFinal     = {}    && D     - Data final para filtro de periodo

    *==========================================================================
    * METODOS
    *==========================================================================

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigMvCcr"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Lista movimentos de conta corrente filtrados por periodo e WHERE
    * par_cFiltro: clausula WHERE adicional (ex: "a.Datas BETWEEN '...' AND '...'")
    *              Se vazio, usa this_dDtInicial e this_dDtFinal como filtro
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_cWhere
        LOCAL loc_cDtI, loc_cDtF
        loc_lResultado = .F.

        IF VARTYPE(par_cFiltro) != "C"
            par_cFiltro = ""
        ENDIF

        TRY
            IF !EMPTY(par_cFiltro)
                loc_cWhere = " WHERE " + par_cFiltro
            ELSE
                *-- Usar datas do BO como filtro
                IF !EMPTY(THIS.this_dDtInicial) AND !EMPTY(THIS.this_dDtFinal)
                    loc_cDtI = FormatarDataSQL(THIS.this_dDtInicial)
                    loc_cDtF = FormatarDataSQL(THIS.this_dDtFinal)
                ELSE
                    *-- Padrao: mes atual
                    loc_cDtI = FormatarDataSQL(DATE() - DAY(DATE()) + 1)
                    loc_cDtF = FormatarDataSQL(DATE())
                ENDIF
                loc_cWhere = " WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                             " AND a.Opers = 'D'" + ;
                             " AND a.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.nopers, a.opers, a.datas," + ;
                       " a.contas, a.scontas, a.hists, a.hist2s," + ;
                       " a.valors, a.svalors, a.nfs, a.docus," + ;
                       " a.grupos, a.sgrupos, a.moedas, a.smoedas," + ;
                       " a.concs, a.emps, a.vencs, a.cotacaos," + ;
                       " a.scotacaos, a.contapgs, a.jobs, a.dtemis," + ;
                       " a.sopers, a.tipos" + ;
                       " FROM SigMvCcr a" + loc_cWhere + ;
                       " ORDER BY a.datas, a.nopers"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados") >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar movimentos: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Buscar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo cidchaves (chave primaria)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCidchaves)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.emps, a.nopers, a.opers, a.sopers," + ;
                       " a.dopes, a.numes, a.dopcs, a.numcs, a.vopers," + ;
                       " a.datas, a.vencs, a.dtemis, a.datalts, a.datexcs," + ;
                       " a.grupos, a.contas, a.moedas, a.cotacaos, a.valors," + ;
                       " a.sgrupos, a.scontas, a.smoedas, a.scotacaos, a.svalors," + ;
                       " a.hists, a.hist2s, a.nfs, a.docus, a.jobs," + ;
                       " a.autos, a.gruconmoes, a.cotusus, a.contapgs, a.concs," + ;
                       " a.usualts, a.usuexcs" + ;
                       " FROM SigMvCcr a" + ;
                       " WHERE a.cidchaves = " + EscaparSQL(par_cCidchaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega") >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MsgErro("Erro ao carregar registro: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Transfere dados do cursor para propriedades do BO
    * OBRIGATORIO: SELECT (par_cAliasCursor) antes de acessar campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidchaves   = ALLTRIM(TratarNulo(cidchaves,   "C"))
            THIS.this_cEmps        = ALLTRIM(TratarNulo(emps,        "C"))
            THIS.this_nNopers      = TratarNulo(nopers,      "N")
            THIS.this_cOpers       = ALLTRIM(TratarNulo(opers,       "C"))
            THIS.this_cSopers      = ALLTRIM(TratarNulo(sopers,      "C"))
            THIS.this_cDopes       = ALLTRIM(TratarNulo(dopes,       "C"))
            THIS.this_nNumes       = TratarNulo(numes,       "N")
            THIS.this_cDopcs       = ALLTRIM(TratarNulo(dopcs,       "C"))
            THIS.this_nNumcs       = TratarNulo(numcs,       "N")
            THIS.this_cVOpers      = ALLTRIM(TratarNulo(vopers,      "C"))
            THIS.this_dDatas       = TratarNulo(datas,       "D")
            THIS.this_dVencs       = TratarNulo(vencs,       "D")
            THIS.this_dDtEmiss     = TratarNulo(dtemis,      "D")
            THIS.this_dDatAlts     = TratarNulo(datalts,     "D")
            THIS.this_dDatExcs     = TratarNulo(datexcs,     "D")
            THIS.this_cGrupos      = ALLTRIM(TratarNulo(grupos,      "C"))
            THIS.this_cContas      = ALLTRIM(TratarNulo(contas,      "C"))
            THIS.this_cMoedas      = ALLTRIM(TratarNulo(moedas,      "C"))
            THIS.this_nCotacaos    = TratarNulo(cotacaos,    "N")
            THIS.this_nValors      = TratarNulo(valors,      "N")
            THIS.this_cSgrupos     = ALLTRIM(TratarNulo(sgrupos,     "C"))
            THIS.this_cScontas     = ALLTRIM(TratarNulo(scontas,     "C"))
            THIS.this_cSmoedas     = ALLTRIM(TratarNulo(smoedas,     "C"))
            THIS.this_nScotacaos   = TratarNulo(scotacaos,   "N")
            THIS.this_nSvalors     = TratarNulo(svalors,     "N")
            THIS.this_cHists       = ALLTRIM(TratarNulo(hists,       "C"))
            THIS.this_cHist2s      = ALLTRIM(TratarNulo(hist2s,      "C"))
            THIS.this_cNotas       = ALLTRIM(TratarNulo(nfs,         "C"))
            THIS.this_cDocus       = ALLTRIM(TratarNulo(docus,       "C"))
            THIS.this_cJobs        = ALLTRIM(TratarNulo(jobs,        "C"))
            THIS.this_lAutos       = (TratarNulo(autos,      "N") = 1)
            THIS.this_cGruconmoes  = ALLTRIM(TratarNulo(gruconmoes,  "C"))
            THIS.this_cCotUsus     = ALLTRIM(TratarNulo(cotusus,     "C"))
            THIS.this_nContapgs    = TratarNulo(contapgs,    "N")
            THIS.this_nConcs       = TratarNulo(concs,       "N")
            THIS.this_cUsualts     = ALLTRIM(TratarNulo(usualts,     "C"))
            THIS.this_cUsuExcs     = ALLTRIM(TratarNulo(usuexcs,     "C"))
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo movimento de conta corrente
    * Gera nopers sequencial e cidchaves = DTOS(datas)+PADL(nopers,12,'0')
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nNopers, loc_cCidchaves
        LOCAL loc_cDtDados, loc_cDtVencs, loc_cDtEmis, loc_nRes
        loc_lResultado = .F.

        *-- Validacoes fora do TRY
        IF EMPTY(THIS.this_cGrupos) OR EMPTY(THIS.this_cContas)
            MsgErro("Grupo e Conta (D" + CHR(233) + "bito) s" + CHR(227) + "o obrigat" + ;
                    CHR(243) + "rios.", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_cSgrupos) OR EMPTY(THIS.this_cScontas)
            MsgErro("Grupo e Conta (Cr" + CHR(233) + "dito) s" + CHR(227) + "o obrigat" + ;
                    CHR(243) + "rios.", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_cOpers)
            MsgErro("O tipo de opera" + CHR(231) + CHR(227) + "o (D/C) " + CHR(233) + ;
                    " obrigat" + CHR(243) + "rio.", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            *-- Gerar proximo nopers para a empresa
            loc_cSQL = "SELECT ISNULL(MAX(nopers), 0) + 1 AS proxNopers" + ;
                       " FROM SigMvCcr WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NextNoper") >= 0
                SELECT cursor_4c_NextNoper
                loc_nNopers = cursor_4c_NextNoper.proxNopers
                IF USED("cursor_4c_NextNoper")
                    USE IN cursor_4c_NextNoper
                ENDIF

                *-- Gerar cidchaves: DTOS(datas) + PADL(nopers,12,'0')
                loc_cDtDados = DTOS(IIF(EMPTY(THIS.this_dDatas), DATE(), THIS.this_dDatas))
                loc_cCidchaves = loc_cDtDados + PADL(TRANSFORM(loc_nNopers), 12, "0")
                THIS.this_cCidchaves = loc_cCidchaves
                THIS.this_nNopers    = loc_nNopers

                *-- Formatar datas para SQL
                loc_cDtDados = FormatarDataSQL(THIS.this_dDatas)
                loc_cDtVencs = FormatarDataSQL(THIS.this_dVencs)
                loc_cDtEmis  = FormatarDataSQL(THIS.this_dDtEmiss)

                *-- gruconmoes = grupos + contas + moedas
                THIS.this_cGruconmoes = ALLTRIM(THIS.this_cGrupos) + ;
                                        ALLTRIM(THIS.this_cContas) + ;
                                        ALLTRIM(THIS.this_cMoedas)

                *-- Montar INSERT com todos os campos NOT NULL da tabela
                loc_cSQL = "INSERT INTO SigMvCcr" + ;
                    " (cidchaves, emps, nopers, opers, sopers," + ;
                    " datas, vencs, dtemis," + ;
                    " grupos, contas, moedas, cotacaos, valors," + ;
                    " sgrupos, scontas, smoedas, scotacaos, svalors," + ;
                    " hists, hist2s, nfs, docus, jobs," + ;
                    " contapgs, concs, autos, usualts, usuexcs," + ;
                    " gruconmoes, cotusus, tipos, shists," + ;
                    " dopes, numes, dopcs, numcs, vopers," + ;
                    " contages, contems, saldocs, saldons, saldos," + ;
                    " valliqs, valocurs, valpags, vlancs," + ;
                    " bcontas, bgrupos, borderos, intconts, nlancs, ntrans," + ;
                    " usuconcs, auditors, valprev," + ;
                    " empdopncs, empdopnums, dopoptps," + ;
                    " pagos, usupagos, titcancs, usuconfs," + ;
                    " nopercancs, especienfs, impostos, tpimpostos, titpais," + ;
                    " empccs, locals, titbans, titulos, grupages, grupems)" + ;
                    " VALUES (" + ;
                    EscaparSQL(loc_cCidchaves) + "," + ;
                    EscaparSQL(go_4c_Sistema.cCodEmpresa) + "," + ;
                    FormatarNumeroSQL(loc_nNopers) + "," + ;
                    EscaparSQL(THIS.this_cOpers) + "," + ;
                    EscaparSQL(THIS.this_cSopers) + "," + ;
                    loc_cDtDados + "," + loc_cDtVencs + "," + loc_cDtEmis + "," + ;
                    EscaparSQL(THIS.this_cGrupos) + "," + ;
                    EscaparSQL(THIS.this_cContas) + "," + ;
                    EscaparSQL(THIS.this_cMoedas) + "," + ;
                    FormatarNumeroSQL(THIS.this_nCotacaos) + "," + ;
                    FormatarNumeroSQL(THIS.this_nValors) + "," + ;
                    EscaparSQL(THIS.this_cSgrupos) + "," + ;
                    EscaparSQL(THIS.this_cScontas) + "," + ;
                    EscaparSQL(THIS.this_cSmoedas) + "," + ;
                    FormatarNumeroSQL(THIS.this_nScotacaos) + "," + ;
                    FormatarNumeroSQL(THIS.this_nSvalors) + "," + ;
                    EscaparSQL(THIS.this_cHists) + "," + ;
                    EscaparSQL(THIS.this_cHist2s) + "," + ;
                    EscaparSQL(THIS.this_cNotas) + "," + ;
                    EscaparSQL(THIS.this_cDocus) + "," + ;
                    EscaparSQL(THIS.this_cJobs) + "," + ;
                    FormatarNumeroSQL(THIS.this_nContapgs) + "," + ;
                    FormatarNumeroSQL(THIS.this_nConcs) + "," + ;
                    IIF(THIS.this_lAutos, "1", "0") + "," + ;
                    EscaparSQL(gc_4c_UsuarioLogado) + ",''" + "," + ;
                    EscaparSQL(THIS.this_cGruconmoes) + "," + ;
                    EscaparSQL(THIS.this_cCotUsus) + ",''" + "," + ;
                    "''" + "," + ;
                    EscaparSQL(THIS.this_cDopes) + "," + ;
                    FormatarNumeroSQL(THIS.this_nNumes) + "," + ;
                    EscaparSQL(THIS.this_cDopcs) + "," + ;
                    FormatarNumeroSQL(THIS.this_nNumcs) + "," + ;
                    EscaparSQL(THIS.this_cVOpers) + "," + ;
                    "'','',0,0,0," + ;
                    "0,0,0,''" + "," + ;
                    "'','',0,0,0,0," + ;
                    "'','',0," + ;
                    "'','',''" + "," + ;
                    "'','',0,''," + ;
                    "0,'',0,0,''" + "," + ;
                    EscaparSQL(go_4c_Sistema.cCodEmpresa) + ",'','','','','')"

                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nRes >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao inserir movimento: " + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao gerar n" + CHR(250) + "mero de opera" + CHR(231) + CHR(227) + "o: " + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Inserir: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza movimento de conta corrente existente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nRes
        LOCAL loc_cDtDados, loc_cDtVencs, loc_cDtEmis
        loc_lResultado = .F.

        *-- Validacoes fora do TRY
        IF EMPTY(THIS.this_cCidchaves)
            MsgErro("Chave do registro n" + CHR(227) + "o informada para atualiza" + ;
                    CHR(231) + CHR(227) + "o.", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_cGrupos) OR EMPTY(THIS.this_cContas)
            MsgErro("Grupo e Conta (D" + CHR(233) + "bito) s" + CHR(227) + "o obrigat" + ;
                    CHR(243) + "rios.", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            *-- Formatar datas para SQL
            loc_cDtDados = FormatarDataSQL(THIS.this_dDatas)
            loc_cDtVencs = FormatarDataSQL(THIS.this_dVencs)
            loc_cDtEmis  = FormatarDataSQL(THIS.this_dDtEmiss)

            *-- Recalcular gruconmoes
            THIS.this_cGruconmoes = ALLTRIM(THIS.this_cGrupos) + ;
                                    ALLTRIM(THIS.this_cContas) + ;
                                    ALLTRIM(THIS.this_cMoedas)

            loc_cSQL = "UPDATE SigMvCcr SET" + ;
                " opers       = " + EscaparSQL(THIS.this_cOpers) + "," + ;
                " sopers      = " + EscaparSQL(THIS.this_cSopers) + "," + ;
                " datas       = " + loc_cDtDados + "," + ;
                " vencs       = " + loc_cDtVencs + "," + ;
                " dtemis      = " + loc_cDtEmis + "," + ;
                " grupos      = " + EscaparSQL(THIS.this_cGrupos) + "," + ;
                " contas      = " + EscaparSQL(THIS.this_cContas) + "," + ;
                " moedas      = " + EscaparSQL(THIS.this_cMoedas) + "," + ;
                " cotacaos    = " + FormatarNumeroSQL(THIS.this_nCotacaos) + "," + ;
                " valors      = " + FormatarNumeroSQL(THIS.this_nValors) + "," + ;
                " sgrupos     = " + EscaparSQL(THIS.this_cSgrupos) + "," + ;
                " scontas     = " + EscaparSQL(THIS.this_cScontas) + "," + ;
                " smoedas     = " + EscaparSQL(THIS.this_cSmoedas) + "," + ;
                " scotacaos   = " + FormatarNumeroSQL(THIS.this_nScotacaos) + "," + ;
                " svalors     = " + FormatarNumeroSQL(THIS.this_nSvalors) + "," + ;
                " hists       = " + EscaparSQL(THIS.this_cHists) + "," + ;
                " hist2s      = " + EscaparSQL(THIS.this_cHist2s) + "," + ;
                " nfs         = " + EscaparSQL(THIS.this_cNotas) + "," + ;
                " docus       = " + EscaparSQL(THIS.this_cDocus) + "," + ;
                " jobs        = " + EscaparSQL(THIS.this_cJobs) + "," + ;
                " contapgs    = " + FormatarNumeroSQL(THIS.this_nContapgs) + "," + ;
                " cotusus     = " + EscaparSQL(THIS.this_cCotUsus) + "," + ;
                " gruconmoes  = " + EscaparSQL(THIS.this_cGruconmoes) + "," + ;
                " dopes       = " + EscaparSQL(THIS.this_cDopes) + "," + ;
                " numes       = " + FormatarNumeroSQL(THIS.this_nNumes) + "," + ;
                " dopcs       = " + EscaparSQL(THIS.this_cDopcs) + "," + ;
                " numcs       = " + FormatarNumeroSQL(THIS.this_nNumcs) + "," + ;
                " vopers      = " + EscaparSQL(THIS.this_cVOpers) + "," + ;
                " datalts     = GETDATE()," + ;
                " usualts     = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRes >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar movimento: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui movimento: marca DatExcs e deleta o registro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nRes
        loc_lResultado = .F.

        TRY
            *-- Primeiro: marcar data/usuario de exclusao (soft delete marker)
            loc_cSQL = "UPDATE SigMvCcr" + ;
                       " SET datexcs = GETDATE()," + ;
                       " usuexcs = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRes < 0
                MsgErro("Erro ao marcar exclus" + CHR(227) + "o: " + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                *-- Segundo: deletar o registro definitivamente
                loc_cSQL = "DELETE FROM SigMvCcr" + ;
                           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)
                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nRes >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir movimento: " + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ExecutarExclusao: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

