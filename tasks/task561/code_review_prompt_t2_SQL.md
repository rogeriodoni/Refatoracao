# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (6)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, EMPS, NOPERS, LNCLASSERR, ICLIS, OPERS, DOPES, EMPDOPNUMS, OK, ALTCOTS, CONTAS, GRUPOS, MOEDAS, CONTAPGS, LOPAGINA, NVALOR, SE, NUMOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ADICIONA' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, EMPS, NOPERS, LNCLASSERR, ICLIS, OPERS, DOPES, EMPDOPNUMS, OK, ALTCOTS, CONTAS, GRUPOS, MOEDAS, CONTAPGS, LOPAGINA, NVALOR, SE, NUMOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna '1' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, EMPS, NOPERS, LNCLASSERR, ICLIS, OPERS, DOPES, EMPDOPNUMS, OK, ALTCOTS, CONTAS, GRUPOS, MOEDAS, CONTAPGS, LOPAGINA, NVALOR, SE, NUMOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, EMPS, NOPERS, LNCLASSERR, ICLIS, OPERS, DOPES, EMPDOPNUMS, OK, ALTCOTS, CONTAS, GRUPOS, MOEDAS, CONTAPGS, LOPAGINA, NVALOR, SE, NUMOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, EMPS, NOPERS, LNCLASSERR, ICLIS, OPERS, DOPES, EMPDOPNUMS, OK, ALTCOTS, CONTAS, GRUPOS, MOEDAS, CONTAPGS, LOPAGINA, NVALOR, SE, NUMOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'COTACAOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, EMPS, NOPERS, LNCLASSERR, ICLIS, OPERS, DOPES, EMPDOPNUMS, OK, ALTCOTS, CONTAS, GRUPOS, MOEDAS, CONTAPGS, LOPAGINA, NVALOR, SE, NUMOS

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigmvccr.prg) - TRECHOS RELEVANTES PARA PASS SQL (2555 linhas total):

*-- Linhas 409 a 427:
409:             .ColumnCount        = 11
410:             .RecordSourceType   = 1
411:             .ReadOnly           = .T.
412:             .DeleteMark         = .F.
413:             .RecordMark         = .F.
414:             .ScrollBars         = 2
415:             .GridLines          = 3
416:             .GridLineColor      = RGB(238, 238, 238)
417:             .HighlightBackColor = RGB(255, 255, 255)
418:             .HighlightForeColor = RGB(15, 41, 104)
419:             .HighlightStyle     = 2
420:             .RowHeight          = 16
421:             .FontName           = "Tahoma"
422:             .FontSize           = 8
423:             .Visible            = .T.
424: 
425:             .Column1.Width      = 78
426:             .Column1.Alignment  = 2
427:             .Column1.FontSize   = 8

*-- Linhas 1376 a 1394:
1376:         ENDWITH
1377: 
1378:         *-- OptionGroup Lancar Contas (legado Opcao_conta: Option1="Sim"
1379:         *-- Value=0, Option2="Nao" Value=1 - ControlSource craltcc.contapgs)
1380:         loc_oPagina.AddObject("obj_4c_Opcao_conta", "OptionGroup")
1381:         WITH loc_oPagina.obj_4c_Opcao_conta
1382:             .Top         = 385
1383:             .Left        = 844
1384:             .Width       = 99
1385:             .Height      = 27
1386:             .ButtonCount = 2
1387:             .BackStyle   = 0
1388:             .BorderStyle = 0
1389:             .Visible     = .T.
1390:         ENDWITH
1391:         WITH loc_oPagina.obj_4c_Opcao_conta.Buttons(1)
1392:             .Caption   = "Sim"
1393:             .Value     = 0
1394:             .Left      = 5

*-- Linhas 1435 a 1496:
1435:                     USE IN cursor_4c_Dados
1436:                 ENDIF
1437:                 SET NULL ON
1438:                 CREATE CURSOR cursor_4c_Dados ;
1439:                     (cidchaves C(20), datas T, contas C(10), scontas C(10), hists C(60), ;
1440:                      valors N(11,2), svalors N(11,2), smoedas C(3), moedas C(3), ;
1441:                      nfs C(10), docus C(10), opers C(1))
1442:                 SET NULL OFF
1443:                 SET DATASESSION TO (loc_nDsAtual)
1444:                 loc_lResultado = .T.
1445:             ELSE
1446:                 loc_oPeriodo = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.cnt_4c__periodo
1447: 
1448:                 loc_dDtI = loc_oPeriodo.txt_4c_Dt_inicial.Value
1449:                 loc_dDtF = loc_oPeriodo.txt_4c_Dt_final.Value
1450: 
1451:                 IF EMPTY(loc_dDtI)
1452:                     loc_dDtI = DATE()
1453:                 ENDIF
1454:                 IF EMPTY(loc_dDtF)
1455:                     loc_dDtF = DATE()
1456:                 ENDIF
1457: 
1458:                 loc_tDtF = DATETIME(YEAR(loc_dDtF), MONTH(loc_dDtF), DAY(loc_dDtF), 23, 59, 59)
1459: 
1460:                 loc_cFiltro = "AND a.datas BETWEEN " + FormatarDataSQL(loc_dDtI) + ;
1461:                     " AND " + FormatarDataSQL(loc_tDtF)
1462: 
1463:                 IF !THIS.this_oBusinessObject.Buscar(loc_cFiltro)
1464:                     loc_lResultado = .F.
1465:                 ELSE
1466:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1467:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1468: 
1469:                     loc_oGrid.Column1.ControlSource  = "TTOD(cursor_4c_Dados.datas)"
1470:                     loc_oGrid.Column2.ControlSource  = "cursor_4c_Dados.contas"
1471:                     loc_oGrid.Column3.ControlSource  = "cursor_4c_Dados.scontas"
1472:                     loc_oGrid.Column4.ControlSource  = "cursor_4c_Dados.hists"
1473:                     loc_oGrid.Column5.ControlSource  = "cursor_4c_Dados.valors"
1474:                     loc_oGrid.Column6.ControlSource  = "cursor_4c_Dados.svalors"
1475:                     loc_oGrid.Column7.ControlSource  = "cursor_4c_Dados.smoedas"
1476:                     loc_oGrid.Column8.ControlSource  = "cursor_4c_Dados.moedas"
1477:                     loc_oGrid.Column9.ControlSource  = "cursor_4c_Dados.nfs"
1478:                     loc_oGrid.Column10.ControlSource = "cursor_4c_Dados.docus"
1479:                     loc_oGrid.Column11.ControlSource = "cursor_4c_Dados.opers"
1480: 
1481:                     *-- RecordSource/ControlSource resetam os cabecalhos (CLAUDE.md
1482:                     *-- FORMCOR_LICOES Problema 2) - reconfigurar SEMPRE apos
1483:                     loc_oGrid.Column1.Header1.Caption  = "Data"
1484:                     loc_oGrid.Column2.Header1.Caption  = "Conta"
1485:                     loc_oGrid.Column3.Header1.Caption  = "Contrapartida"
1486:                     loc_oGrid.Column4.Header1.Caption  = "Hist" + CHR(243) + "rico"
1487:                     loc_oGrid.Column5.Header1.Caption  = "D" + CHR(233) + "bito"
1488:                     loc_oGrid.Column6.Header1.Caption  = "Cr" + CHR(233) + "dito"
1489:                     loc_oGrid.Column7.Header1.Caption  = ""
1490:                     loc_oGrid.Column8.Header1.Caption  = " "
1491:                     loc_oGrid.Column9.Header1.Caption  = "NF"
1492:                     loc_oGrid.Column10.Header1.Caption = "Documento"
1493:                     loc_oGrid.Column11.Header1.Caption = "O"
1494: 
1495:                     IF USED("cursor_4c_Dados")
1496:                         GO TOP IN cursor_4c_Dados

*-- Linhas 1575 a 1609:
1575:     * AvisarPrimeiroLancamento - Legado (ChkRegister('SigMvSlc', laCampo))
1576:     * avisa quando Grupo+Conta+Moeda ainda nao tem nenhum lancamento em
1577:     * SigMvSlc. Na arquitetura nova nao existe ThisForm.podatamgr, entao a
1578:     * checagem eh feita direto via SQLEXEC.
1579:     *===========================================================================
1580:     PROTECTED PROCEDURE AvisarPrimeiroLancamento(par_cGrupo, par_cConta, par_cMoeda)
1581:         LOCAL loc_nResult
1582: 
1583:         IF EMPTY(par_cGrupo) OR EMPTY(par_cConta) OR EMPTY(par_cMoeda)
1584:             RETURN
1585:         ENDIF
1586: 
1587:         IF USED("cursor_4c_ChkReg")
1588:             USE IN cursor_4c_ChkReg
1589:         ENDIF
1590: 
1591:         loc_nResult = SQLEXEC(gnConnHandle, "SELECT TOP 1 Grupos FROM SigMvSlc" + ;
1592:             " WHERE Grupos = " + EscaparSQL(par_cGrupo) + ;
1593:             " AND Contas = " + EscaparSQL(par_cConta) + ;
1594:             " AND Moedas = " + EscaparSQL(par_cMoeda), "cursor_4c_ChkReg")
1595: 
1596:         IF loc_nResult >= 0 AND (!USED("cursor_4c_ChkReg") OR RECCOUNT("cursor_4c_ChkReg") = 0)
1597:             MsgAviso("Aten" + CHR(231) + CHR(227) + "o !!! Primeiro Lan" + CHR(231) + "amento deste Grupo/Conta/Moeda")
1598:         ENDIF
1599: 
1600:         IF USED("cursor_4c_ChkReg")
1601:             USE IN cursor_4c_ChkReg
1602:         ENDIF
1603:     ENDPROC
1604: 
1605:     *===========================================================================
1606:     * ValidarGrupo - LostFocus de txt_4c_Grupo (legado: Get_grupo.Valid)
1607:     * Usa fAcessoContab (ja portada em utils/functions.prg) para validar
1608:     * acesso e preencher a descricao; depois confere se o grupo tem Classe
1609:     * cadastrada (sem Classe, o lancamento eh bloqueado no legado).

*-- Linhas 1631 a 1649:
1631:             IF USED("cursor_4c_ValGrp")
1632:                 USE IN cursor_4c_ValGrp
1633:             ENDIF
1634:             SQLEXEC(gnConnHandle, "SELECT Codigos, Classes FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cValor), "cursor_4c_ValGrp")
1635: 
1636:             IF !USED("cursor_4c_ValGrp") OR RECCOUNT("cursor_4c_ValGrp") = 0 OR EMPTY(NVL(cursor_4c_ValGrp.Classes, ""))
1637:                 MsgErro("Imposs" + CHR(237) + "vel Realizar Lan" + CHR(231) + "amento Neste Grupo!!!" + CHR(13) + ;
1638:                     "A Classe do Grupo N" + CHR(227) + "o Foi Informada!!!", "Aten" + CHR(231) + CHR(227) + "o")
1639:                 loc_oPg.txt_4c_Grupo.Value = ""
1640:                 loc_oPg.txt_4c_Dgrupo.Value = ""
1641:                 THIS.this_cUltimoGrupoValidado = ""
1642:             ENDIF
1643: 
1644:             IF USED("cursor_4c_ValGrp")
1645:                 USE IN cursor_4c_ValGrp
1646:             ENDIF
1647:         ENDIF
1648: 
1649:         THIS.AvisarPrimeiroLancamento(ALLTRIM(loc_oPg.txt_4c_Grupo.Value), ALLTRIM(loc_oPg.txt_4c_Conta.Value), ALLTRIM(loc_oPg.txt_4c_MOEDA.Value))

*-- Linhas 1707 a 1737:
1707:         IF USED("cursor_4c_ResGrp")
1708:             USE IN cursor_4c_ResGrp
1709:         ENDIF
1710:         SQLEXEC(gnConnHandle, "SELECT Grupos FROM SigCdCli WHERE IClis = " + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Conta.Value)), "cursor_4c_ResGrp")
1711:         IF USED("cursor_4c_ResGrp") AND RECCOUNT("cursor_4c_ResGrp") > 0 AND !EMPTY(NVL(cursor_4c_ResGrp.Grupos, ""))
1712:             loc_oPg.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_ResGrp.Grupos)
1713:         ENDIF
1714:         IF USED("cursor_4c_ResGrp")
1715:             USE IN cursor_4c_ResGrp
1716:         ENDIF
1717: 
1718:         IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Grupo.Value))
1719:             IF USED("cursor_4c_ResGrpD")
1720:                 USE IN cursor_4c_ResGrpD
1721:             ENDIF
1722:             SQLEXEC(gnConnHandle, "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Grupo.Value)), "cursor_4c_ResGrpD")
1723:             IF USED("cursor_4c_ResGrpD") AND RECCOUNT("cursor_4c_ResGrpD") > 0 AND !EMPTY(NVL(cursor_4c_ResGrpD.Descrs, ""))
1724:                 loc_oPg.txt_4c_Dgrupo.Value = ALLTRIM(cursor_4c_ResGrpD.Descrs)
1725:             ENDIF
1726:             IF USED("cursor_4c_ResGrpD")
1727:                 USE IN cursor_4c_ResGrpD
1728:             ENDIF
1729:         ENDIF
1730:     ENDPROC
1731: 
1732:     *===========================================================================
1733:     * ValidarSGrupo / ValidarSConta / ValidarSDconta - espelho do painel D
1734:     * para a contrapartida (legado: Get_SGRUPO/Get_SCONTA/Get_SDCONTA.Valid)
1735:     *===========================================================================
1736:     PROCEDURE ValidarSGrupo(par_nKeyCode, par_nShiftAltCtrl)
1737:         LOCAL loc_oPg, loc_cValor

*-- Linhas 1756 a 1774:
1756:             IF USED("cursor_4c_ValSGrp")
1757:                 USE IN cursor_4c_ValSGrp
1758:             ENDIF
1759:             SQLEXEC(gnConnHandle, "SELECT Codigos, Classes FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cValor), "cursor_4c_ValSGrp")
1760: 
1761:             IF !USED("cursor_4c_ValSGrp") OR RECCOUNT("cursor_4c_ValSGrp") = 0 OR EMPTY(NVL(cursor_4c_ValSGrp.Classes, ""))
1762:                 MsgErro("Imposs" + CHR(237) + "vel Realizar Lan" + CHR(231) + "amento Neste Grupo!!!" + CHR(13) + ;
1763:                     "A Classe do Grupo N" + CHR(227) + "o Foi Informada!!!", "Aten" + CHR(231) + CHR(227) + "o")
1764:                 loc_oPg.txt_4c_SGRUPO.Value = ""
1765:                 loc_oPg.txt_4c_Sdgrupo.Value = ""
1766:                 THIS.this_cUltimoSGrupoValidado = ""
1767:             ENDIF
1768: 
1769:             IF USED("cursor_4c_ValSGrp")
1770:                 USE IN cursor_4c_ValSGrp
1771:             ENDIF
1772:         ENDIF
1773: 
1774:         THIS.AvisarPrimeiroLancamento(ALLTRIM(loc_oPg.txt_4c_SGRUPO.Value), ALLTRIM(loc_oPg.txt_4c_SCONTA.Value), ALLTRIM(loc_oPg.txt_4c_Smoeda.Value))

*-- Linhas 1823 a 1853:
1823:         IF USED("cursor_4c_ResSGrp")
1824:             USE IN cursor_4c_ResSGrp
1825:         ENDIF
1826:         SQLEXEC(gnConnHandle, "SELECT Grupos FROM SigCdCli WHERE IClis = " + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_SCONTA.Value)), "cursor_4c_ResSGrp")
1827:         IF USED("cursor_4c_ResSGrp") AND RECCOUNT("cursor_4c_ResSGrp") > 0 AND !EMPTY(NVL(cursor_4c_ResSGrp.Grupos, ""))
1828:             loc_oPg.txt_4c_SGRUPO.Value = ALLTRIM(cursor_4c_ResSGrp.Grupos)
1829:         ENDIF
1830:         IF USED("cursor_4c_ResSGrp")
1831:             USE IN cursor_4c_ResSGrp
1832:         ENDIF
1833: 
1834:         IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_SGRUPO.Value))
1835:             IF USED("cursor_4c_ResSGrpD")
1836:                 USE IN cursor_4c_ResSGrpD
1837:             ENDIF
1838:             SQLEXEC(gnConnHandle, "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_SGRUPO.Value)), "cursor_4c_ResSGrpD")
1839:             IF USED("cursor_4c_ResSGrpD") AND RECCOUNT("cursor_4c_ResSGrpD") > 0 AND !EMPTY(NVL(cursor_4c_ResSGrpD.Descrs, ""))
1840:                 loc_oPg.txt_4c_Sdgrupo.Value = ALLTRIM(cursor_4c_ResSGrpD.Descrs)
1841:             ENDIF
1842:             IF USED("cursor_4c_ResSGrpD")
1843:                 USE IN cursor_4c_ResSGrpD
1844:             ENDIF
1845:         ENDIF
1846:     ENDPROC
1847: 
1848:     *===========================================================================
1849:     * ValidarJob / (txt_4c_DJob eh so leitura) - legado: getJob.Valid
1850:     * chamada original tem argumentos extras (.f. x7, 10) que a assinatura
1851:     * portada de fAcessoContas nao aceita - usados so os 6 primeiros, que
1852:     * cobrem o essencial (usuario/grupo/tipo/valor/origem/destino)
1853:     *===========================================================================

*-- Linhas 1908 a 1926:
1908:         IF USED("cursor_4c_ValMoe")
1909:             USE IN cursor_4c_ValMoe
1910:         ENDIF
1911:         SQLEXEC(gnConnHandle, "SELECT CMoes, Cotas FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cValor), "cursor_4c_ValMoe")
1912: 
1913:         IF !USED("cursor_4c_ValMoe") OR RECCOUNT("cursor_4c_ValMoe") = 0
1914:             IF USED("cursor_4c_ValMoe")
1915:                 USE IN cursor_4c_ValMoe
1916:             ENDIF
1917:             IF par_cLado == "D"
1918:                 THIS.AbrirLookupMoeda()
1919:             ELSE
1920:                 THIS.AbrirLookupSMoeda()
1921:             ENDIF
1922:             RETURN
1923:         ENDIF
1924: 
1925:         loc_lCotas = ConverterParaLogico(cursor_4c_ValMoe.Cotas)
1926:         loc_cValor = ALLTRIM(cursor_4c_ValMoe.CMoes)

*-- Linhas 1939 a 1959:
1939:             IF USED("cursor_4c_ValCot")
1940:                 USE IN cursor_4c_ValCot
1941:             ENDIF
1942:             SQLEXEC(gnConnHandle, "SELECT TOP 1 Valos FROM SigCdCot" + ;
1943:                 " WHERE Moedas = " + EscaparSQL(loc_cValor) + ;
1944:                 " AND Cotacaos <= " + FormatarDataSQL(loc_dData) + ;
1945:                 " ORDER BY Cotacaos DESC", "cursor_4c_ValCot")
1946:             IF USED("cursor_4c_ValCot") AND RECCOUNT("cursor_4c_ValCot") > 0
1947:                 loc_nCotacao = cursor_4c_ValCot.Valos
1948:             ENDIF
1949:             IF USED("cursor_4c_ValCot")
1950:                 USE IN cursor_4c_ValCot
1951:             ENDIF
1952:         ENDIF
1953: 
1954:         IF par_cLado == "D"
1955:             loc_oPg.txt_4c_COTACAO.Value = loc_nCotacao
1956:             IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Smoeda.Value))
1957:                 loc_oPg.txt_4c_Smoeda.Value   = loc_oPg.txt_4c_MOEDA.Value
1958:                 loc_oPg.txt_4c_SCOTACAO.Value = loc_oPg.txt_4c_COTACAO.Value
1959:             ENDIF

*-- Linhas 2271 a 2289:
2271: 
2272:     *===========================================================================
2273:     * BtnSalvarClick - Confirma a inclusao/alteracao do lancamento (Confirmar)
2274:     * Salvar() do BusinessBase decide INSERT/UPDATE sozinho (this_lNovoRegistro
2275:     * ja foi setado por NovoRegistro()/EditarRegistro() nos botoes de origem)
2276:     *===========================================================================
2277:     PROCEDURE BtnSalvarClick()
2278:         THIS.FormParaBO()
2279: 
2280:         IF THIS.this_oBusinessObject.Salvar()
2281:             MsgInfo("Lan" + CHR(231) + "amento salvo com sucesso!", "Confirmar")
2282:             THIS.AlternarPagina(1)
2283:         ELSE
2284:             IF !THIS.this_oBusinessObject.this_lErroExibido
2285:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o lan" + CHR(231) + "amento.", "Confirmar")
2286:             ENDIF
2287:         ENDIF
2288:     ENDPROC
2289: 


### BO (C:\4c\projeto\app\classes\sigmvccrBO.prg):
*====================================================================
* sigmvccrBO.prg
*
* Business Object para Conta Corrente Geral
* Tabela: SigMvCcr
* Chave: cidchaves (PK Fortyus)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS sigmvccrBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigMvCcr)
    this_cCidchaves    = ""    && cidchaves   char(20)   - PK
    this_lAutos        = .F.   && autos       bit
    this_lConcs        = .F.   && concs       bit
    this_cContages     = ""    && contages    char(10)
    this_cContas       = ""    && contas      char(10)
    this_cContems      = ""    && contems     char(10)
    this_nCotacaos     = 0     && cotacaos    numeric(15,7)
    this_dDatalts      = {}    && datalts     datetime
    this_dDatas        = {}    && datas       datetime
    this_dDataconcs    = {}    && dataconcs   datetime
    this_dDatatrans    = {}    && datatrans   datetime
    this_dDatexcs      = {}    && datexcs     datetime
    this_cDocus        = ""    && docus       char(10)
    this_cDopes        = ""    && dopes       char(20)
    this_dDtemis       = {}    && dtemis      datetime
    this_cEmps         = ""    && emps        char(3)
    this_cGrupages     = ""    && grupages    char(10)
    this_cGrupems      = ""    && grupems     char(10)
    this_cGrupos       = ""    && grupos      char(10)
    this_cHists        = ""    && hists       char(60)
    this_cLocals       = ""    && locals      char(10)
    this_cMoedas       = ""    && moedas      char(3)
    this_cNfs          = ""    && nfs         char(10)
    this_nNlancs       = 0     && nlancs      numeric(6,0)
    this_nNopers       = 0     && nopers      numeric(7,0)
    this_nNtrans       = 0     && ntrans      numeric(6,0)
    this_nNumes        = 0     && numes       numeric(6,0)
    this_cOpers        = ""    && opers       char(1) - D/C
    this_nSaldocs      = 0     && saldocs     numeric(15,2)
    this_nSaldons      = 0     && saldons     numeric(15,2)
    this_nSaldos       = 0     && saldos      numeric(15,2)
    this_cScontas      = ""    && scontas     char(10)
    this_nScotacaos    = 0     && scotacaos   numeric(15,7)
    this_cSgrupos      = ""    && sgrupos     char(10)
    this_cShists       = ""    && shists      char(40)
    this_cSmoedas      = ""    && smoedas     char(3)
    this_cSopers       = ""    && sopers      char(1) - D/C
    this_nSvalors      = 0     && svalors     numeric(11,2)
    this_cTipos        = ""    && tipos       char(1)
    this_cTitbans      = ""    && titbans     char(12)
    this_cTitulos      = ""    && titulos     char(10)
    this_cUsualts      = ""    && usualts     char(10)
    this_cUsuexcs      = ""    && usuexcs     char(10)
    this_nValliqs      = 0     && valliqs     numeric(11,2)
    this_nValocurs     = 0     && valocurs    numeric(11,2)
    this_nValors       = 0     && valors      numeric(11,2)
    this_nValpags      = 0     && valpags     numeric(11,2)
    this_dVencs        = {}    && vencs       datetime
    this_cVlancs       = ""    && vlancs      char(10)
    this_cVopers       = ""    && vopers      char(13)
    this_nContapgs     = 0     && contapgs    numeric(1,0)
    this_cDopcs        = ""    && dopcs       char(20)
    this_nNumcs        = 0     && numcs       numeric(6,0)
    this_cCotusus      = ""    && cotusus     char(10)
    this_cBcontas      = ""    && bcontas     char(10)
    this_cBgrupos      = ""    && bgrupos     char(10)
    this_nBorderos     = 0     && borderos    numeric(6,0)
    this_cHist2s       = ""    && hist2s      char(80)
    this_nIntconts     = 0     && intconts    numeric(6,0)
    this_cUsuconcs     = ""    && usuconcs    char(10)
    this_cAuditors     = ""    && auditors    char(10)
    this_dDtaudits     = {}    && dtaudits    datetime
    this_nValprev      = 0     && valprev     numeric(11,2)
    this_cEmpdopncs    = ""    && empdopncs   char(29)
    this_cEmpdopnums   = ""    && empdopnums  char(29)
    this_cGruconmoes   = ""    && gruconmoes  char(23)
    this_cPagos        = ""    && pagos       char(1)
    this_cDopotps      = ""    && dopotps     char(23)
    this_cUsupagos     = ""    && usupagos    char(10)
    this_nTitcancs     = 0     && titcancs    numeric(1,0)
    this_dDtconfs      = {}    && dtconfs     datetime
    this_cUsuconfs     = ""    && usuconfs    char(10)
    this_nNopercancs   = 0     && nopercancs  numeric(7,0)
    this_cEspecienfs   = ""    && especienfs  char(6)
    this_cJobs         = ""    && jobs        char(10)
    this_nImpostos     = 0     && impostos    numeric(11,2)
    this_nTpimpostos   = 0     && tpimpostos  numeric(2,0)
    this_cTitpais      = ""    && titpais     char(10)
    this_cEmpccs       = ""    && empccs      char(3)
    this_nRecor        = 0     && recor       numeric(1,0)
    this_cCompet       = ""    && compet      char(7)
    this_cEmpos        = ""    && empos       char(3)
    this_cOridopnums   = ""    && oridopnums  char(29)
    this_cPastas       = ""    && pastas      text
    this_cRcontas      = ""    && rcontas     char(10)
    this_cTpdocnf      = ""    && tpdocnf     char(2)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMvCcr"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "sigmvccrBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna a chave primaria (cidchaves) para
    * uso em RegistrarAuditoria()
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas do cursor SQL para as
    * propriedades do BO. SEMPRE usar SELECT (par_cAliasCursor) antes de
    * acessar os campos (regra #8 CLAUDE.md).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cCidchaves = TratarNulo(cidchaves, "C")
                IF VARTYPE(autos) = "L"
                    THIS.this_lAutos = autos
                ELSE
                    THIS.this_lAutos = (NVL(autos, 0) = 1)
                ENDIF
                IF VARTYPE(concs) = "L"
                    THIS.this_lConcs = concs
                ELSE
                    THIS.this_lConcs = (NVL(concs, 0) = 1)
                ENDIF
                THIS.this_cContages = TratarNulo(contages, "C")
                THIS.this_cContas = TratarNulo(contas, "C")
                THIS.this_cContems = TratarNulo(contems, "C")
                THIS.this_nCotacaos = TratarNulo(cotacaos, "N")
                THIS.this_dDatalts = TratarNulo(datalts, "D")
                THIS.this_dDatas = TratarNulo(datas, "D")
                THIS.this_dDataconcs = TratarNulo(dataconcs, "D")
                THIS.this_dDatatrans = TratarNulo(datatrans, "D")
                THIS.this_dDatexcs = TratarNulo(datexcs, "D")
                THIS.this_cDocus = TratarNulo(docus, "C")
                THIS.this_cDopes = TratarNulo(dopes, "C")
                THIS.this_dDtemis = TratarNulo(dtemis, "D")
                THIS.this_cEmps = TratarNulo(emps, "C")
                THIS.this_cGrupages = TratarNulo(grupages, "C")
                THIS.this_cGrupems = TratarNulo(grupems, "C")
                THIS.this_cGrupos = TratarNulo(grupos, "C")
                THIS.this_cHists = TratarNulo(hists, "C")
                THIS.this_cLocals = TratarNulo(locals, "C")
                THIS.this_cMoedas = TratarNulo(moedas, "C")
                THIS.this_cNfs = TratarNulo(nfs, "C")
                THIS.this_nNlancs = TratarNulo(nlancs, "N")
                THIS.this_nNopers = TratarNulo(nopers, "N")
                THIS.this_nNtrans = TratarNulo(ntrans, "N")
                THIS.this_nNumes = TratarNulo(numes, "N")
                THIS.this_cOpers = TratarNulo(opers, "C")
                THIS.this_nSaldocs = TratarNulo(saldocs, "N")
                THIS.this_nSaldons = TratarNulo(saldons, "N")
                THIS.this_nSaldos = TratarNulo(saldos, "N")
                THIS.this_cScontas = TratarNulo(scontas, "C")
                THIS.this_nScotacaos = TratarNulo(scotacaos, "N")
                THIS.this_cSgrupos = TratarNulo(sgrupos, "C")
                THIS.this_cShists = TratarNulo(shists, "C")
                THIS.this_cSmoedas = TratarNulo(smoedas, "C")
                THIS.this_cSopers = TratarNulo(sopers, "C")
                THIS.this_nSvalors = TratarNulo(svalors, "N")
                THIS.this_cTipos = TratarNulo(tipos, "C")
                THIS.this_cTitbans = TratarNulo(titbans, "C")
                THIS.this_cTitulos = TratarNulo(titulos, "C")
                THIS.this_cUsualts = TratarNulo(usualts, "C")
                THIS.this_cUsuexcs = TratarNulo(usuexcs, "C")
                THIS.this_nValliqs = TratarNulo(valliqs, "N")
                THIS.this_nValocurs = TratarNulo(valocurs, "N")
                THIS.this_nValors = TratarNulo(valors, "N")
                THIS.this_nValpags = TratarNulo(valpags, "N")
                THIS.this_dVencs = TratarNulo(vencs, "D")
                THIS.this_cVlancs = TratarNulo(vlancs, "C")
                THIS.this_cVopers = TratarNulo(vopers, "C")
                THIS.this_nContapgs = TratarNulo(contapgs, "N")
                THIS.this_cDopcs = TratarNulo(dopcs, "C")
                THIS.this_nNumcs = TratarNulo(numcs, "N")
                THIS.this_cCotusus = TratarNulo(cotusus, "C")
                THIS.this_cBcontas = TratarNulo(bcontas, "C")
                THIS.this_cBgrupos = TratarNulo(bgrupos, "C")
                THIS.this_nBorderos = TratarNulo(borderos, "N")
                THIS.this_cHist2s = TratarNulo(hist2s, "C")
                THIS.this_nIntconts = TratarNulo(intconts, "N")
                THIS.this_cUsuconcs = TratarNulo(usuconcs, "C")
                THIS.this_cAuditors = TratarNulo(auditors, "C")
                THIS.this_dDtaudits = TratarNulo(dtaudits, "D")
                THIS.this_nValprev = TratarNulo(valprev, "N")
                THIS.this_cEmpdopncs = TratarNulo(empdopncs, "C")
                THIS.this_cEmpdopnums = TratarNulo(empdopnums, "C")
                THIS.this_cGruconmoes = TratarNulo(gruconmoes, "C")
                THIS.this_cPagos = TratarNulo(pagos, "C")
                THIS.this_cDopotps = TratarNulo(dopotps, "C")
                THIS.this_cUsupagos = TratarNulo(usupagos, "C")
                THIS.this_nTitcancs = TratarNulo(titcancs, "N")
                THIS.this_dDtconfs = TratarNulo(dtconfs, "D")
                THIS.this_cUsuconfs = TratarNulo(usuconfs, "C")
                THIS.this_nNopercancs = TratarNulo(nopercancs, "N")
                THIS.this_cEspecienfs = TratarNulo(especienfs, "C")
                THIS.this_cJobs = TratarNulo(jobs, "C")
                THIS.this_nImpostos = TratarNulo(impostos, "N")
                THIS.this_nTpimpostos = TratarNulo(tpimpostos, "N")
                THIS.this_cTitpais = TratarNulo(titpais, "C")
                THIS.this_cEmpccs = TratarNulo(empccs, "C")
                THIS.this_nRecor = TratarNulo(recor, "N")
                THIS.this_cCompet = TratarNulo(compet, "C")
                THIS.this_cEmpos = TratarNulo(empos, "C")
                THIS.this_cOridopnums = TratarNulo(oridopnums, "C")
                THIS.this_cPastas = TratarNulo(pastas, "C")
                THIS.this_cRcontas = TratarNulo(rcontas, "C")
                THIS.this_cTpdocnf = TratarNulo(tpdocnf, "C")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvccrBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro em SigMvCcr
    * PK (cidchaves) gerada via fUniqueIds() se ainda nao preenchida
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(NVL(THIS.this_cCidchaves, "")))
                THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)
            ENDIF

            *-- Campo computado: Grupos + Contas + Moedas (chave de grupo/conta/moeda)
            THIS.this_cGruconmoes = PADR(THIS.this_cGrupos, 10) + PADR(THIS.this_cContas, 10) + PADR(THIS.this_cMoedas, 3)

            *-- Campos computados: Emps + Dopes + Numes/Numcs (chave de movimentacao)
            THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)
            THIS.this_cEmpdopncs = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumcs, 6)

            *-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
            *-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
            *-- com limite de 8192 caracteres ("Line is too long" em runtime).
            loc_cSQL = "INSERT INTO SigMvCcr ("
            loc_cSQL = loc_cSQL + "cidchaves, autos, concs, contages, contas, contems, cotacaos, datalts,"
            loc_cSQL = loc_cSQL + "datas, dataconcs, datatrans, datexcs, docus, dopes, dtemis, emps,"
            loc_cSQL = loc_cSQL + "grupages, grupems, grupos, hists, locals, moedas, nfs, nlancs,"
            loc_cSQL = loc_cSQL + "nopers, ntrans, numes, opers, saldocs, saldons, saldos, scontas,"
            loc_cSQL = loc_cSQL + "scotacaos, sgrupos, shists, smoedas, sopers, svalors, tipos, titbans,"
            loc_cSQL = loc_cSQL + "titulos, usualts, usuexcs, valliqs, valocurs, valors, valpags, vencs,"
            loc_cSQL = loc_cSQL + "vlancs, vopers, contapgs, dopcs, numcs, cotusus, bcontas, bgrupos,"
            loc_cSQL = loc_cSQL + "borderos, hist2s, intconts, usuconcs, auditors, dtaudits, valprev, empdopncs,"
            loc_cSQL = loc_cSQL + "empdopnums, gruconmoes, pagos, dopotps, usupagos, titcancs, dtconfs, usuconfs,"
            loc_cSQL = loc_cSQL + "nopercancs, especienfs, jobs, impostos, tpimpostos, titpais, empccs, recor,"
            loc_cSQL = loc_cSQL + "compet, empos, oridopnums, pastas, rcontas, tpdocnf"
            loc_cSQL = loc_cSQL + ") VALUES ("
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCidchaves, 20)) + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lAutos, 1, 0) + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lConcs, 1, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cContages, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cContas, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cContems, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCotacaos, 7) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatalts) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatas) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDataconcs) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatatrans) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatexcs) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDocus, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtemis) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrupages, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrupems, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cHists, 60)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cLocals, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMoedas, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNfs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNlancs, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNopers, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNtrans, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cOpers, 1)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSaldocs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSaldons, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSaldos, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cScontas, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nScotacaos, 7) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cSgrupos, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cShists, 40)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cSmoedas, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cSopers, 1)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSvalors, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTipos, 1)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTitbans, 12)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTitulos, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsualts, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsuexcs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValliqs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValocurs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValors, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValpags, 2) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dVencs) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cVlancs, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cVopers, 13)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nContapgs, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopcs, 20)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumcs, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCotusus, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cBcontas, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cBgrupos, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nBorderos, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cHist2s, 80)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nIntconts, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsuconcs, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cAuditors, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtaudits) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValprev, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpdopncs, 29)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGruconmoes, 23)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cPagos, 1)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopotps, 23)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsupagos, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTitcancs, 0) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtconfs) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsuconfs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNopercancs, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEspecienfs, 6)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cJobs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nImpostos, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTpimpostos, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTitpais, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpccs, 3)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nRecor, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCompet, 7)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpos, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cOridopnums, 29)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cPastas) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cRcontas, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTpdocnf, 2)) + ")"

            IF USED("cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

            IF loc_nResult < 0
                MsgErro("Erro ao inserir lancamento de conta corrente:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                IF USED("cursor_4c_Insert")
                    USE IN cursor_4c_Insert
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvccrBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente em SigMvCcr (por cidchaves)
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Campo computado: Grupos + Contas + Moedas (chave de grupo/conta/moeda)
            THIS.this_cGruconmoes = PADR(THIS.this_cGrupos, 10) + PADR(THIS.this_cContas, 10) + PADR(THIS.this_cMoedas, 3)

            *-- Campos computados: Emps + Dopes + Numes/Numcs (chave de movimentacao)
            THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)
            THIS.this_cEmpdopncs = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumcs, 6)

            *-- Data de alteracao
            THIS.this_dDatalts = DATETIME()

            *-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
            *-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
            *-- com limite de 8192 caracteres ("Line is too long" em runtime).
            loc_cSQL = "UPDATE SigMvCcr SET"
            loc_cSQL = loc_cSQL + " autos = " + IIF(THIS.this_lAutos, 1, 0) + ","
            loc_cSQL = loc_cSQL + " concs = " + IIF(THIS.this_lConcs, 1, 0) + ","
            loc_cSQL = loc_cSQL + " contages = " + EscaparSQL(LEFT(THIS.this_cContages, 10)) + ","
            loc_cSQL = loc_cSQL + " contas = " + EscaparSQL(LEFT(THIS.this_cContas, 10)) + ","
            loc_cSQL = loc_cSQL + " contems = " + EscaparSQL(LEFT(THIS.this_cContems, 10)) + ","
            loc_cSQL = loc_cSQL + " cotacaos = " + FormatarNumeroSQL(THIS.this_nCotacaos, 7) + ","
            loc_cSQL = loc_cSQL + " datalts = " + FormatarDataSQL(THIS.this_dDatalts) + ","
            loc_cSQL = loc_cSQL + " datas = " + FormatarDataSQL(THIS.this_dDatas) + ","
            loc_cSQL = loc_cSQL + " dataconcs = " + FormatarDataSQL(THIS.this_dDataconcs) + ","
            loc_cSQL = loc_cSQL + " datatrans = " + FormatarDataSQL(THIS.this_dDatatrans) + ","
            loc_cSQL = loc_cSQL + " datexcs = " + FormatarDataSQL(THIS.this_dDatexcs) + ","
            loc_cSQL = loc_cSQL + " docus = " + EscaparSQL(LEFT(THIS.this_cDocus, 10)) + ","
            loc_cSQL = loc_cSQL + " dopes = " + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
            loc_cSQL = loc_cSQL + " dtemis = " + FormatarDataSQL(THIS.this_dDtemis) + ","
            loc_cSQL = loc_cSQL + " emps = " + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
            loc_cSQL = loc_cSQL + " grupages = " + EscaparSQL(LEFT(THIS.this_cGrupages, 10)) + ","
            loc_cSQL = loc_cSQL + " grupems = " + EscaparSQL(LEFT(THIS.this_cGrupems, 10)) + ","
            loc_cSQL = loc_cSQL + " grupos = " + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + ","
            loc_cSQL = loc_cSQL + " hists = " + EscaparSQL(LEFT(THIS.this_cHists, 60)) + ","
            loc_cSQL = loc_cSQL + " locals = " + EscaparSQL(LEFT(THIS.this_cLocals, 10)) + ","
            loc_cSQL = loc_cSQL + " moedas = " + EscaparSQL(LEFT(THIS.this_cMoedas, 3)) + ","
            loc_cSQL = loc_cSQL + " nfs = " + EscaparSQL(LEFT(THIS.this_cNfs, 10)) + ","
            loc_cSQL = loc_cSQL + " nlancs = " + FormatarNumeroSQL(THIS.this_nNlancs, 0) + ","
            loc_cSQL = loc_cSQL + " nopers = " + FormatarNumeroSQL(THIS.this_nNopers, 0) + ","
            loc_cSQL = loc_cSQL + " ntrans = " + FormatarNumeroSQL(THIS.this_nNtrans, 0) + ","
            loc_cSQL = loc_cSQL + " numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
            loc_cSQL = loc_cSQL + " opers = " + EscaparSQL(LEFT(THIS.this_cOpers, 1)) + ","
            loc_cSQL = loc_cSQL + " saldocs = " + FormatarNumeroSQL(THIS.this_nSaldocs, 2) + ","
            loc_cSQL = loc_cSQL + " saldons = " + FormatarNumeroSQL(THIS.this_nSaldons, 2) + ","
            loc_cSQL = loc_cSQL + " saldos = " + FormatarNumeroSQL(THIS.this_nSaldos, 2) + ","
            loc_cSQL = loc_cSQL + " scontas = " + EscaparSQL(LEFT(THIS.this_cScontas, 10)) + ","
            loc_cSQL = loc_cSQL + " scotacaos = " + FormatarNumeroSQL(THIS.this_nScotacaos, 7) + ","
            loc_cSQL = loc_cSQL + " sgrupos = " + EscaparSQL(LEFT(THIS.this_cSgrupos, 10)) + ","
            loc_cSQL = loc_cSQL + " shists = " + EscaparSQL(LEFT(THIS.this_cShists, 40)) + ","
            loc_cSQL = loc_cSQL + " smoedas = " + EscaparSQL(LEFT(THIS.this_cSmoedas, 3)) + ","
            loc_cSQL = loc_cSQL + " sopers = " + EscaparSQL(LEFT(THIS.this_cSopers, 1)) + ","
            loc_cSQL = loc_cSQL + " svalors = " + FormatarNumeroSQL(THIS.this_nSvalors, 2) + ","
            loc_cSQL = loc_cSQL + " tipos = " + EscaparSQL(LEFT(THIS.this_cTipos, 1)) + ","
            loc_cSQL = loc_cSQL + " titbans = " + EscaparSQL(LEFT(THIS.this_cTitbans, 12)) + ","
            loc_cSQL = loc_cSQL + " titulos = " + EscaparSQL(LEFT(THIS.this_cTitulos, 10)) + ","
            loc_cSQL = loc_cSQL + " usualts = " + EscaparSQL(LEFT(THIS.this_cUsualts, 10)) + ","
            loc_cSQL = loc_cSQL + " usuexcs = " + EscaparSQL(LEFT(THIS.this_cUsuexcs, 10)) + ","
            loc_cSQL = loc_cSQL + " valliqs = " + FormatarNumeroSQL(THIS.this_nValliqs, 2) + ","
            loc_cSQL = loc_cSQL + " valocurs = " + FormatarNumeroSQL(THIS.this_nValocurs, 2) + ","
            loc_cSQL = loc_cSQL + " valors = " + FormatarNumeroSQL(THIS.this_nValors, 2) + ","
            loc_cSQL = loc_cSQL + " valpags = " + FormatarNumeroSQL(THIS.this_nValpags, 2) + ","
            loc_cSQL = loc_cSQL + " vencs = " + FormatarDataSQL(THIS.this_dVencs) + ","
            loc_cSQL = loc_cSQL + " vlancs = " + EscaparSQL(LEFT(THIS.this_cVlancs, 10)) + ","
            loc_cSQL = loc_cSQL + " vopers = " + EscaparSQL(LEFT(THIS.this_cVopers, 13)) + ","
            loc_cSQL = loc_cSQL + " contapgs = " + FormatarNumeroSQL(THIS.this_nContapgs, 0) + ","
            loc_cSQL = loc_cSQL + " dopcs = " + EscaparSQL(LEFT(THIS.this_cDopcs, 20)) + ","
            loc_cSQL = loc_cSQL + " numcs = " + FormatarNumeroSQL(THIS.this_nNumcs, 0) + ","
            loc_cSQL = loc_cSQL + " cotusus = " + EscaparSQL(LEFT(THIS.this_cCotusus, 10)) + ","
            loc_cSQL = loc_cSQL + " bcontas = " + EscaparSQL(LEFT(THIS.this_cBcontas, 10)) + ","
            loc_cSQL = loc_cSQL + " bgrupos = " + EscaparSQL(LEFT(THIS.this_cBgrupos, 10)) + ","
            loc_cSQL = loc_cSQL + " borderos = " + FormatarNumeroSQL(THIS.this_nBorderos, 0) + ","
            loc_cSQL = loc_cSQL + " hist2s = " + EscaparSQL(LEFT(THIS.this_cHist2s, 80)) + ","
            loc_cSQL = loc_cSQL + " intconts = " + FormatarNumeroSQL(THIS.this_nIntconts, 0) + ","
            loc_cSQL = loc_cSQL + " usuconcs = " + EscaparSQL(LEFT(THIS.this_cUsuconcs, 10)) + ","
            loc_cSQL = loc_cSQL + " auditors = " + EscaparSQL(LEFT(THIS.this_cAuditors, 10)) + ","
            loc_cSQL = loc_cSQL + " dtaudits = " + FormatarDataSQL(THIS.this_dDtaudits) + ","
            loc_cSQL = loc_cSQL + " valprev = " + FormatarNumeroSQL(THIS.this_nValprev, 2) + ","
            loc_cSQL = loc_cSQL + " empdopncs = " + EscaparSQL(LEFT(THIS.this_cEmpdopncs, 29)) + ","
            loc_cSQL = loc_cSQL + " empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ","
            loc_cSQL = loc_cSQL + " gruconmoes = " + EscaparSQL(LEFT(THIS.this_cGruconmoes, 23)) + ","
            loc_cSQL = loc_cSQL + " pagos = " + EscaparSQL(LEFT(THIS.this_cPagos, 1)) + ","
            loc_cSQL = loc_cSQL + " dopotps = " + EscaparSQL(LEFT(THIS.this_cDopotps, 23)) + ","
            loc_cSQL = loc_cSQL + " usupagos = " + EscaparSQL(LEFT(THIS.this_cUsupagos, 10)) + ","
            loc_cSQL = loc_cSQL + " titcancs = " + FormatarNumeroSQL(THIS.this_nTitcancs, 0) + ","
            loc_cSQL = loc_cSQL + " dtconfs = " + FormatarDataSQL(THIS.this_dDtconfs) + ","
            loc_cSQL = loc_cSQL + " usuconfs = " + EscaparSQL(LEFT(THIS.this_cUsuconfs, 10)) + ","
            loc_cSQL = loc_cSQL + " nopercancs = " + FormatarNumeroSQL(THIS.this_nNopercancs, 0) + ","
            loc_cSQL = loc_cSQL + " especienfs = " + EscaparSQL(LEFT(THIS.this_cEspecienfs, 6)) + ","
            loc_cSQL = loc_cSQL + " jobs = " + EscaparSQL(LEFT(THIS.this_cJobs, 10)) + ","
            loc_cSQL = loc_cSQL + " impostos = " + FormatarNumeroSQL(THIS.this_nImpostos, 2) + ","
            loc_cSQL = loc_cSQL + " tpimpostos = " + FormatarNumeroSQL(THIS.this_nTpimpostos, 0) + ","
            loc_cSQL = loc_cSQL + " titpais = " + EscaparSQL(LEFT(THIS.this_cTitpais, 10)) + ","
            loc_cSQL = loc_cSQL + " empccs = " + EscaparSQL(LEFT(THIS.this_cEmpccs, 3)) + ","
            loc_cSQL = loc_cSQL + " recor = " + FormatarNumeroSQL(THIS.this_nRecor, 0) + ","
            loc_cSQL = loc_cSQL + " compet = " + EscaparSQL(LEFT(THIS.this_cCompet, 7)) + ","
            loc_cSQL = loc_cSQL + " empos = " + EscaparSQL(LEFT(THIS.this_cEmpos, 3)) + ","
            loc_cSQL = loc_cSQL + " oridopnums = " + EscaparSQL(LEFT(THIS.this_cOridopnums, 29)) + ","
            loc_cSQL = loc_cSQL + " pastas = " + EscaparSQL(THIS.this_cPastas) + ","
            loc_cSQL = loc_cSQL + " rcontas = " + EscaparSQL(LEFT(THIS.this_cRcontas, 10)) + ","
            loc_cSQL = loc_cSQL + " tpdocnf = " + EscaparSQL(LEFT(THIS.this_cTpdocnf, 2))
            loc_cSQL = loc_cSQL + " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar lancamento de conta corrente:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                IF USED("cursor_4c_Update")
                    USE IN cursor_4c_Update
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvccrBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Lista lancamentos de conta corrente com filtro opcional
    * par_cFiltro: condicoes WHERE adicionais (ex: "AND a.datas BETWEEN ...")
    * Popula cursor_4c_Dados (usado pelo grd_4c_Lista do form)
    *====================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.datas, a.contas, a.scontas, a.hists," + ;
                " a.valors, a.svalors, a.smoedas, a.moedas, a.nfs, a.docus, a.opers" + ;
                " FROM SigMvCcr a WHERE 1 = 1"

            IF !EMPTY(ALLTRIM(NVL(par_cFiltro, "")))
                loc_cSQL = loc_cSQL + " " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.emps, a.datas"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult < 0
                MsgErro("Erro ao buscar lancamentos de conta corrente:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em sigmvccrBO.Buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarPorCodigo - Carrega um lancamento pela chave primaria (cidchaves)
    *====================================================================
    FUNCTION CarregarPorCodigo(par_cChave)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT * FROM SigMvCcr WHERE cidchaves = " + EscaparSQL(ALLTRIM(par_cChave))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
            ELSE
                MsgErro("Lan" + CHR(231) + "amento n" + CHR(227) + "o encontrado.", "Erro")
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em sigmvccrBO.CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ExecutarExclusao - Exclui lancamento (por cidchaves)
    * Legado (msv_excluir): marca DatExcs/UsuExcs antes de excluir fisicamente
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigMvCcr SET datexcs = " + GETDATE() + ;
                ", usuexcs = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

            IF USED("cursor_4c_ExcUpd")
                USE IN cursor_4c_ExcUpd
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ExcUpd")

            IF loc_nResult < 0
                MsgErro("Erro ao marcar exclus" + CHR(227) + "o do lan" + CHR(231) + "amento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_ExcUpd")
                    USE IN cursor_4c_ExcUpd
                ENDIF

                loc_cSQL = "DELETE FROM SigMvCcr WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

                IF USED("cursor_4c_ExcDel")
                    USE IN cursor_4c_ExcDel
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ExcDel")

                IF loc_nResult < 0
                    MsgErro("Erro ao excluir lan" + CHR(231) + "amento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ENDIF

                IF USED("cursor_4c_ExcDel")
                    USE IN cursor_4c_ExcDel
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em sigmvccrBO.ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

