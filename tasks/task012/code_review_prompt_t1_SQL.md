# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (5)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DATEXCS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, EMPS, NOPERS, LNCLASSERR, ICLIS, OPERS, DOPES, EMPDOPNUMS, OK, ALTCOTS, CONTAS, GRUPOS, MOEDAS, CONTAPGS, LOPAGINA, NVALOR, SE, NUMOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, EMPS, NOPERS, LNCLASSERR, ICLIS, OPERS, DOPES, EMPDOPNUMS, OK, ALTCOTS, CONTAS, GRUPOS, MOEDAS, CONTAPGS, LOPAGINA, NVALOR, SE, NUMOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, EMPS, NOPERS, LNCLASSERR, ICLIS, OPERS, DOPES, EMPDOPNUMS, OK, ALTCOTS, CONTAS, GRUPOS, MOEDAS, CONTAPGS, LOPAGINA, NVALOR, SE, NUMOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, EMPS, NOPERS, LNCLASSERR, ICLIS, OPERS, DOPES, EMPDOPNUMS, OK, ALTCOTS, CONTAS, GRUPOS, MOEDAS, CONTAPGS, LOPAGINA, NVALOR, SE, NUMOS
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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigmvccr.prg) - TRECHOS RELEVANTES PARA PASS SQL (2983 linhas total):

*-- Linhas 433 a 451:
433:             * O grid usa cursor_4c_Grade; os dados vem via ZAP+APPEND em CarregarLista()
434:             *--------------------------------------------------------------------
435:             SET NULL ON
436:             CREATE CURSOR cursor_4c_Grade ( ;
437:                 Datas      T, ;
438:                 Opers      C(1), ;
439:                 Contas     C(10), ;
440:                 Scontas    C(10), ;
441:                 Hists      C(60), ;
442:                 Valors     N(11,2), ;
443:                 Svalors    N(11,2), ;
444:                 Concs      L, ;
445:                 Autos      L, ;
446:                 Nfs        C(10), ;
447:                 Docus      C(10), ;
448:                 Nopers     N(7,0), ;
449:                 Cidchaves  C(20) ;
450:             )
451:             SET NULL OFF

*-- Linhas 468 a 527:
468:             loc_oGrid.HighlightBackColor = RGB(255, 255, 255)
469:             loc_oGrid.HighlightForeColor = RGB(15, 41, 104)
470:             loc_oGrid.HighlightStyle   = 2
471:             loc_oGrid.DeleteMark       = .F.
472:             loc_oGrid.RecordMark       = .F.
473:             loc_oGrid.RowHeight        = 16
474:             loc_oGrid.ScrollBars       = 2
475:             loc_oGrid.GridLines        = 3
476:             loc_oGrid.Visible          = .T.
477: 
478:             *-- ColumnCount e RecordSource FORA de WITH (evita "Unknown member COLUMN1")
479:             loc_oGrid.ColumnCount  = 11
480:             loc_oGrid.RecordSource = "cursor_4c_Grade"
481: 
482:             *-- ControlSource APOS RecordSource (evita auto-bind por posicao)
483:             loc_oGrid.Column1.ControlSource  = "cursor_4c_Grade.Datas"
484:             loc_oGrid.Column2.ControlSource  = "cursor_4c_Grade.Opers"
485:             loc_oGrid.Column3.ControlSource  = "cursor_4c_Grade.Contas"
486:             loc_oGrid.Column4.ControlSource  = "cursor_4c_Grade.Scontas"
487:             loc_oGrid.Column5.ControlSource  = "cursor_4c_Grade.Hists"
488:             loc_oGrid.Column6.ControlSource  = "cursor_4c_Grade.Valors"
489:             loc_oGrid.Column7.ControlSource  = "cursor_4c_Grade.Svalors"
490:             loc_oGrid.Column8.ControlSource  = "cursor_4c_Grade.Concs"
491:             loc_oGrid.Column9.ControlSource  = "cursor_4c_Grade.Autos"
492:             loc_oGrid.Column10.ControlSource = "cursor_4c_Grade.Nfs"
493:             loc_oGrid.Column11.ControlSource = "cursor_4c_Grade.Docus"
494: 
495:             *-- Larguras das colunas
496:             loc_oGrid.Column1.Width  = 65     && Data
497:             loc_oGrid.Column2.Width  = 20     && O (D/C)
498:             loc_oGrid.Column3.Width  = 80     && Conta
499:             loc_oGrid.Column4.Width  = 80     && Contrapartida
500:             loc_oGrid.Column5.Width  = 225    && Historico
501:             loc_oGrid.Column6.Width  = 100    && Debito
502:             loc_oGrid.Column7.Width  = 100    && Credito
503:             loc_oGrid.Column8.Width  = 20     && [blank/Concs]
504:             loc_oGrid.Column9.Width  = 20     && [space/Autos]
505:             loc_oGrid.Column10.Width = 80     && NF
506:             loc_oGrid.Column11.Width = 80     && Documento
507: 
508:             *-- Alinhamento
509:             loc_oGrid.Column6.Alignment = 1   && Right para Debito
510:             loc_oGrid.Column7.Alignment = 1   && Right para Credito
511: 
512:             *-- Headers (APOS RecordSource e ControlSource - OBRIGATORIO)
513:             loc_oGrid.Column1.Header1.Caption  = "Data"
514:             loc_oGrid.Column2.Header1.Caption  = "O"
515:             loc_oGrid.Column3.Header1.Caption  = "Conta"
516:             loc_oGrid.Column4.Header1.Caption  = "Contrapartida"
517:             loc_oGrid.Column5.Header1.Caption  = "Hist" + CHR(243) + "rico"
518:             loc_oGrid.Column6.Header1.Caption  = "D" + CHR(233) + "bito"
519:             loc_oGrid.Column7.Header1.Caption  = "Cr" + CHR(233) + "dito"
520:             loc_oGrid.Column8.Header1.Caption  = ""
521:             loc_oGrid.Column9.Header1.Caption  = " "
522:             loc_oGrid.Column10.Header1.Caption = "NF"
523:             loc_oGrid.Column11.Header1.Caption = "Documento"
524: 
525:             *--------------------------------------------------------------------
526:             * BINDEVENTs para botoes
527:             *--------------------------------------------------------------------

*-- Linhas 1503 a 1549:
1503:                 loc_dInicio = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_DtInicial.Value
1504:                 loc_dFim    = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_DtFinal.Value
1505: 
1506:                 loc_cWhere = " WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
1507:                              " AND a.Datexcs IS NULL"
1508: 
1509:                 IF !EMPTY(loc_dInicio) AND !EMPTY(loc_dFim)
1510:                     loc_cWhere = loc_cWhere + ;
1511:                         " AND a.Datas >= " + FormatarDataSQL(loc_dInicio) + ;
1512:                         " AND a.Datas < DATEADD(day, 1, " + FormatarDataSQL(loc_dFim) + ")"
1513:                 ENDIF
1514: 
1515:                 loc_cSQL = "SELECT a.Datas, a.Opers, a.Contas, a.Scontas," + ;
1516:                            " a.Hists, a.Valors, a.Svalors, a.Concs, a.Autos," + ;
1517:                            " a.Nfs, a.Docus, a.Nopers, a.Cidchaves" + ;
1518:                            " FROM SigMvCcr a" + ;
1519:                            loc_cWhere + ;
1520:                            " ORDER BY a.Datas, a.Nopers"
1521: 
1522:                 IF USED("cursor_4c_DadosTemp")
1523:                     USE IN cursor_4c_DadosTemp
1524:                 ENDIF
1525: 
1526:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp")
1527: 
1528:                 IF loc_nResult < 0
1529:                     MsgErro("Erro ao carregar movimentos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1530:                 ELSE
1531:                     *-- ZAP + APPEND: preserva colunas do grid (nao destroi cursor_4c_Grade)
1532:                     ZAP IN cursor_4c_Grade
1533:                     SELECT cursor_4c_Grade
1534:                     APPEND FROM DBF("cursor_4c_DadosTemp")
1535:                     USE IN cursor_4c_DadosTemp
1536: 
1537:                     IF USED("cursor_4c_Grade")
1538:                         GO TOP IN cursor_4c_Grade
1539:                     ENDIF
1540: 
1541:                     *-- Reconfigurar headers (seguranca apos operacoes no cursor)
1542:                     loc_oGrid.Column1.Header1.Caption  = "Data"
1543:                     loc_oGrid.Column2.Header1.Caption  = "O"
1544:                     loc_oGrid.Column3.Header1.Caption  = "Conta"
1545:                     loc_oGrid.Column4.Header1.Caption  = "Contrapartida"
1546:                     loc_oGrid.Column5.Header1.Caption  = "Hist" + CHR(243) + "rico"
1547:                     loc_oGrid.Column6.Header1.Caption  = "D" + CHR(233) + "bito"
1548:                     loc_oGrid.Column7.Header1.Caption  = "Cr" + CHR(233) + "dito"
1549:                     loc_oGrid.Column8.Header1.Caption  = ""

*-- Linhas 1619 a 1637:
1619:             IF !USED("cursor_4c_Grade") OR EOF("cursor_4c_Grade") OR BOF("cursor_4c_Grade")
1620:                 MsgAviso("Nenhum registro selecionado.", "Visualizar")
1621:             ELSE
1622:                 SELECT cursor_4c_Grade
1623:                 loc_cChave = ALLTRIM(cursor_4c_Grade.Cidchaves)
1624: 
1625:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1626:                     THIS.this_cModoAtual = "VISUALIZAR"
1627:                     THIS.BOParaForm()
1628:                     THIS.pgf_4c_Paginas.ActivePage = 2
1629:                 ELSE
1630:                     MsgErro("Registro nao encontrado.", "Visualizar")
1631:                 ENDIF
1632:             ENDIF
1633:         CATCH TO loc_oErro
1634:             MsgErro(loc_oErro.Message, "BtnVisualizarClick")
1635:         ENDTRY
1636:     ENDPROC
1637: 

*-- Linhas 1644 a 1662:
1644:             IF !USED("cursor_4c_Grade") OR EOF("cursor_4c_Grade") OR BOF("cursor_4c_Grade")
1645:                 MsgAviso("Nenhum registro selecionado.", "Alterar")
1646:             ELSE
1647:                 SELECT cursor_4c_Grade
1648:                 loc_cChave = ALLTRIM(cursor_4c_Grade.Cidchaves)
1649: 
1650:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1651:                     THIS.this_oBusinessObject.EditarRegistro()
1652:                     THIS.this_cModoAtual = "ALTERAR"
1653:                     THIS.BOParaForm()
1654:                     THIS.pgf_4c_Paginas.ActivePage = 2
1655:                 ELSE
1656:                     MsgErro("Registro nao encontrado.", "Alterar")
1657:                 ENDIF
1658:             ENDIF
1659:         CATCH TO loc_oErro
1660:             MsgErro(loc_oErro.Message, "BtnAlterarClick")
1661:         ENDTRY
1662:     ENDPROC

*-- Linhas 1670 a 1688:
1670:             IF !USED("cursor_4c_Grade") OR EOF("cursor_4c_Grade") OR BOF("cursor_4c_Grade")
1671:                 MsgAviso("Nenhum registro selecionado.", "Excluir")
1672:             ELSE
1673:                 SELECT cursor_4c_Grade
1674:                 loc_cChave = ALLTRIM(cursor_4c_Grade.Cidchaves)
1675: 
1676:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1677:                     loc_lConfirmou = MsgConfirma( ;
1678:                         "Confirma a exclus" + CHR(227) + "o do movimento " + loc_cChave + "?", ;
1679:                         "Excluir")
1680: 
1681:                     IF loc_lConfirmou
1682:                         IF THIS.this_oBusinessObject.Excluir()
1683:                             MsgSucesso("Movimento exclu" + CHR(237) + "do com sucesso!")
1684:                             THIS.CarregarLista()
1685:                         ENDIF
1686:                     ENDIF
1687:                 ELSE
1688:                     MsgErro("Registro nao encontrado.", "Excluir")

*-- Linhas 1724 a 1742:
1724:             IF !USED("cursor_4c_Grade") OR EOF("cursor_4c_Grade") OR BOF("cursor_4c_Grade")
1725:                 MsgAviso("Selecione um registro para ver o movimento.", "Movimento")
1726:             ELSE
1727:                 SELECT cursor_4c_Grade
1728:                 loc_cChave = ALLTRIM(cursor_4c_Grade.Cidchaves)
1729: 
1730:                 IF EMPTY(loc_cChave)
1731:                     MsgAviso("Registro sem chave de opera" + CHR(231) + CHR(227) + "o.", "Movimento")
1732:                 ELSE
1733:                     THIS.this_cModoAtual = "VISUALIZAR"
1734:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1735:                         THIS.BOParaForm()
1736:                         THIS.pgf_4c_Paginas.ActivePage = 2
1737:                     ENDIF
1738:                 ENDIF
1739:             ENDIF
1740:         CATCH TO loc_oErro
1741:             MsgErro(loc_oErro.Message, "BtnMovimentoClick")
1742:         ENDTRY

*-- Linhas 1997 a 2095:
1997:             *-- Descricao Grupo esquerdo (SigCdGcr.codigos/descrs)
1998:             loc_cCod = ALLTRIM(par_oBO.this_cGrupos)
1999:             IF !EMPTY(loc_cCod)
2000:                 loc_nRes = SQLEXEC(gnConnHandle, ;
2001:                     "SELECT TOP 1 descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cCod), ;
2002:                     "cursor_4c_TmpDesc")
2003:                 IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpDesc") > 0
2004:                     SELECT cursor_4c_TmpDesc
2005:                     loc_oPagina.txt_4c_DGrupo.Value = PADR(ALLTRIM(NVL(descrs, "")), 40)
2006:                 ELSE
2007:                     loc_oPagina.txt_4c_DGrupo.Value = SPACE(40)
2008:                 ENDIF
2009:                 IF USED("cursor_4c_TmpDesc")
2010:                     USE IN cursor_4c_TmpDesc
2011:                 ENDIF
2012:             ELSE
2013:                 loc_oPagina.txt_4c_DGrupo.Value = SPACE(40)
2014:             ENDIF
2015: 
2016:             *-- Descricao Conta esquerdo (SigCdCli: Iclis=codigo, Rclis=nome)
2017:             loc_cCod = ALLTRIM(par_oBO.this_cContas)
2018:             IF !EMPTY(loc_cCod)
2019:                 loc_nRes = SQLEXEC(gnConnHandle, ;
2020:                     "SELECT TOP 1 Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cCod), ;
2021:                     "cursor_4c_TmpDesc")
2022:                 IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpDesc") > 0
2023:                     SELECT cursor_4c_TmpDesc
2024:                     loc_oPagina.txt_4c_DcConta.Value = PADR(ALLTRIM(NVL(Rclis, "")), 40)
2025:                 ELSE
2026:                     loc_oPagina.txt_4c_DcConta.Value = SPACE(40)
2027:                 ENDIF
2028:                 IF USED("cursor_4c_TmpDesc")
2029:                     USE IN cursor_4c_TmpDesc
2030:                 ENDIF
2031:             ELSE
2032:                 loc_oPagina.txt_4c_DcConta.Value = SPACE(40)
2033:             ENDIF
2034: 
2035:             *-- Descricao Grupo direito
2036:             loc_cCod = ALLTRIM(par_oBO.this_cSgrupos)
2037:             IF !EMPTY(loc_cCod)
2038:                 loc_nRes = SQLEXEC(gnConnHandle, ;
2039:                     "SELECT TOP 1 descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cCod), ;
2040:                     "cursor_4c_TmpDesc")
2041:                 IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpDesc") > 0
2042:                     SELECT cursor_4c_TmpDesc
2043:                     loc_oPagina.txt_4c_SDGrupo.Value = PADR(ALLTRIM(NVL(descrs, "")), 40)
2044:                 ELSE
2045:                     loc_oPagina.txt_4c_SDGrupo.Value = SPACE(40)
2046:                 ENDIF
2047:                 IF USED("cursor_4c_TmpDesc")
2048:                     USE IN cursor_4c_TmpDesc
2049:                 ENDIF
2050:             ELSE
2051:                 loc_oPagina.txt_4c_SDGrupo.Value = SPACE(40)
2052:             ENDIF
2053: 
2054:             *-- Descricao Conta direito (SigCdCli: Iclis=codigo, Rclis=nome)
2055:             loc_cCod = ALLTRIM(par_oBO.this_cScontas)
2056:             IF !EMPTY(loc_cCod)
2057:                 loc_nRes = SQLEXEC(gnConnHandle, ;
2058:                     "SELECT TOP 1 Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cCod), ;
2059:                     "cursor_4c_TmpDesc")
2060:                 IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpDesc") > 0
2061:                     SELECT cursor_4c_TmpDesc
2062:                     loc_oPagina.txt_4c_SDcConta.Value = PADR(ALLTRIM(NVL(Rclis, "")), 40)
2063:                 ELSE
2064:                     loc_oPagina.txt_4c_SDcConta.Value = SPACE(40)
2065:                 ENDIF
2066:                 IF USED("cursor_4c_TmpDesc")
2067:                     USE IN cursor_4c_TmpDesc
2068:                 ENDIF
2069:             ELSE
2070:                 loc_oPagina.txt_4c_SDcConta.Value = SPACE(40)
2071:             ENDIF
2072: 
2073:             *-- Descricao Job (SigCdCli: Iclis=codigo, Rclis=nome - mesmo que Conta)
2074:             loc_cCod = ALLTRIM(par_oBO.this_cJobs)
2075:             IF !EMPTY(loc_cCod)
2076:                 loc_nRes = SQLEXEC(gnConnHandle, ;
2077:                     "SELECT TOP 1 Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cCod), ;
2078:                     "cursor_4c_TmpDesc")
2079:                 IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpDesc") > 0
2080:                     SELECT cursor_4c_TmpDesc
2081:                     loc_oPagina.txt_4c_DJob.Value = PADR(ALLTRIM(NVL(Rclis, "")), 40)
2082:                 ELSE
2083:                     loc_oPagina.txt_4c_DJob.Value = SPACE(40)
2084:                 ENDIF
2085:                 IF USED("cursor_4c_TmpDesc")
2086:                     USE IN cursor_4c_TmpDesc
2087:                 ENDIF
2088:             ELSE
2089:                 loc_oPagina.txt_4c_DJob.Value = SPACE(40)
2090:             ENDIF
2091: 
2092:         CATCH TO loc_oErro
2093:             MsgErro(loc_oErro.Message, "CarregarDescricoesGruposConta")
2094:         ENDTRY
2095:     ENDPROC

*-- Linhas 2224 a 2252:
2224:             IF VARTYPE(loc_oBusca) = "O"
2225:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2226:                     IF USED("cursor_4c_Busca")
2227:                         SELECT cursor_4c_Busca
2228:                         loc_oPagina.txt_4c_Grupo.Value  = PADR(ALLTRIM(cursor_4c_Busca.codigos), 10)
2229:                         loc_oPagina.txt_4c_DGrupo.Value = PADR(ALLTRIM(cursor_4c_Busca.descrs), 40)
2230:                     ENDIF
2231:                 ELSE
2232:                     IF !loc_oBusca.this_lAchouRegistro
2233:                         loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
2234:                         loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
2235:                         loc_oBusca.Show()
2236:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
2237:                             SELECT cursor_4c_Busca
2238:                             loc_oPagina.txt_4c_Grupo.Value  = PADR(ALLTRIM(cursor_4c_Busca.codigos), 10)
2239:                             loc_oPagina.txt_4c_DGrupo.Value = PADR(ALLTRIM(cursor_4c_Busca.descrs), 40)
2240:                         ENDIF
2241:                     ENDIF
2242:                 ENDIF
2243:                 loc_oBusca.Release()
2244:             ENDIF
2245: 
2246:             IF USED("cursor_4c_Busca")
2247:                 USE IN cursor_4c_Busca
2248:             ENDIF
2249: 
2250:         CATCH TO loc_oErro
2251:             MsgErro(loc_oErro.Message, "AbrirLookupGrupo")
2252:         ENDTRY

*-- Linhas 2268 a 2296:
2268:             IF VARTYPE(loc_oBusca) = "O"
2269:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2270:                     IF USED("cursor_4c_Busca")
2271:                         SELECT cursor_4c_Busca
2272:                         loc_oPagina.txt_4c_SGrupo.Value  = PADR(ALLTRIM(cursor_4c_Busca.codigos), 10)
2273:                         loc_oPagina.txt_4c_SDGrupo.Value = PADR(ALLTRIM(cursor_4c_Busca.descrs), 40)
2274:                     ENDIF
2275:                 ELSE
2276:                     IF !loc_oBusca.this_lAchouRegistro
2277:                         loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
2278:                         loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
2279:                         loc_oBusca.Show()
2280:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
2281:                             SELECT cursor_4c_Busca
2282:                             loc_oPagina.txt_4c_SGrupo.Value  = PADR(ALLTRIM(cursor_4c_Busca.codigos), 10)
2283:                             loc_oPagina.txt_4c_SDGrupo.Value = PADR(ALLTRIM(cursor_4c_Busca.descrs), 40)
2284:                         ENDIF
2285:                     ENDIF
2286:                 ENDIF
2287:                 loc_oBusca.Release()
2288:             ENDIF
2289: 
2290:             IF USED("cursor_4c_Busca")
2291:                 USE IN cursor_4c_Busca
2292:             ENDIF
2293: 
2294:         CATCH TO loc_oErro
2295:             MsgErro(loc_oErro.Message, "AbrirLookupSGrupo")
2296:         ENDTRY

*-- Linhas 2313 a 2341:
2313:             IF VARTYPE(loc_oBusca) = "O"
2314:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2315:                     IF USED("cursor_4c_Busca")
2316:                         SELECT cursor_4c_Busca
2317:                         loc_oPagina.txt_4c_Conta.Value   = PADR(ALLTRIM(cursor_4c_Busca.Iclis), 10)
2318:                         loc_oPagina.txt_4c_DcConta.Value = PADR(ALLTRIM(cursor_4c_Busca.Rclis), 40)
2319:                     ENDIF
2320:                 ELSE
2321:                     IF !loc_oBusca.this_lAchouRegistro
2322:                         loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
2323:                         loc_oBusca.mAddColuna("Rclis", "", "Descri" + CHR(231) + CHR(227) + "o")
2324:                         loc_oBusca.Show()
2325:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
2326:                             SELECT cursor_4c_Busca
2327:                             loc_oPagina.txt_4c_Conta.Value   = PADR(ALLTRIM(cursor_4c_Busca.Iclis), 10)
2328:                             loc_oPagina.txt_4c_DcConta.Value = PADR(ALLTRIM(cursor_4c_Busca.Rclis), 40)
2329:                         ENDIF
2330:                     ENDIF
2331:                 ENDIF
2332:                 loc_oBusca.Release()
2333:             ENDIF
2334: 
2335:             IF USED("cursor_4c_Busca")
2336:                 USE IN cursor_4c_Busca
2337:             ENDIF
2338: 
2339:         CATCH TO loc_oErro
2340:             MsgErro(loc_oErro.Message, "AbrirLookupConta")
2341:         ENDTRY

*-- Linhas 2357 a 2385:
2357:             IF VARTYPE(loc_oBusca) = "O"
2358:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2359:                     IF USED("cursor_4c_Busca")
2360:                         SELECT cursor_4c_Busca
2361:                         loc_oPagina.txt_4c_SConta.Value   = PADR(ALLTRIM(cursor_4c_Busca.Iclis), 10)
2362:                         loc_oPagina.txt_4c_SDcConta.Value = PADR(ALLTRIM(cursor_4c_Busca.Rclis), 40)
2363:                     ENDIF
2364:                 ELSE
2365:                     IF !loc_oBusca.this_lAchouRegistro
2366:                         loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
2367:                         loc_oBusca.mAddColuna("Rclis", "", "Descri" + CHR(231) + CHR(227) + "o")
2368:                         loc_oBusca.Show()
2369:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
2370:                             SELECT cursor_4c_Busca
2371:                             loc_oPagina.txt_4c_SConta.Value   = PADR(ALLTRIM(cursor_4c_Busca.Iclis), 10)
2372:                             loc_oPagina.txt_4c_SDcConta.Value = PADR(ALLTRIM(cursor_4c_Busca.Rclis), 40)
2373:                         ENDIF
2374:                     ENDIF
2375:                 ENDIF
2376:                 loc_oBusca.Release()
2377:             ENDIF
2378: 
2379:             IF USED("cursor_4c_Busca")
2380:                 USE IN cursor_4c_Busca
2381:             ENDIF
2382: 
2383:         CATCH TO loc_oErro
2384:             MsgErro(loc_oErro.Message, "AbrirLookupSConta")
2385:         ENDTRY

*-- Linhas 2401 a 2428:
2401:             IF VARTYPE(loc_oBusca) = "O"
2402:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2403:                     IF USED("cursor_4c_Busca")
2404:                         SELECT cursor_4c_Busca
2405:                         loc_oPagina.txt_4c_Moeda.Value = PADR(ALLTRIM(cursor_4c_Busca.cmoes), 3)
2406:                     ENDIF
2407:                 ELSE
2408:                     IF !loc_oBusca.this_lAchouRegistro
2409:                         loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
2410:                         loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
2411:                         loc_oBusca.Show()
2412:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
2413:                             SELECT cursor_4c_Busca
2414:                             loc_oPagina.txt_4c_Moeda.Value = PADR(ALLTRIM(cursor_4c_Busca.cmoes), 3)
2415:                         ENDIF
2416:                     ENDIF
2417:                 ENDIF
2418:                 loc_oBusca.Release()
2419:             ENDIF
2420: 
2421:             IF USED("cursor_4c_Busca")
2422:                 USE IN cursor_4c_Busca
2423:             ENDIF
2424: 
2425:         CATCH TO loc_oErro
2426:             MsgErro(loc_oErro.Message, "AbrirLookupMoeda")
2427:         ENDTRY
2428:     ENDPROC

*-- Linhas 2443 a 2470:
2443:             IF VARTYPE(loc_oBusca) = "O"
2444:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2445:                     IF USED("cursor_4c_Busca")
2446:                         SELECT cursor_4c_Busca
2447:                         loc_oPagina.txt_4c_SMoeda.Value = PADR(ALLTRIM(cursor_4c_Busca.cmoes), 3)
2448:                     ENDIF
2449:                 ELSE
2450:                     IF !loc_oBusca.this_lAchouRegistro
2451:                         loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
2452:                         loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
2453:                         loc_oBusca.Show()
2454:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
2455:                             SELECT cursor_4c_Busca
2456:                             loc_oPagina.txt_4c_SMoeda.Value = PADR(ALLTRIM(cursor_4c_Busca.cmoes), 3)
2457:                         ENDIF
2458:                     ENDIF
2459:                 ENDIF
2460:                 loc_oBusca.Release()
2461:             ENDIF
2462: 
2463:             IF USED("cursor_4c_Busca")
2464:                 USE IN cursor_4c_Busca
2465:             ENDIF
2466: 
2467:         CATCH TO loc_oErro
2468:             MsgErro(loc_oErro.Message, "AbrirLookupSMoeda")
2469:         ENDTRY
2470:     ENDPROC

*-- Linhas 2485 a 2513:
2485:             IF VARTYPE(loc_oBusca) = "O"
2486:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2487:                     IF USED("cursor_4c_Busca")
2488:                         SELECT cursor_4c_Busca
2489:                         loc_oPagina.txt_4c_Job.Value  = PADR(ALLTRIM(cursor_4c_Busca.Iclis), 10)
2490:                         loc_oPagina.txt_4c_DJob.Value = PADR(ALLTRIM(cursor_4c_Busca.Rclis), 40)
2491:                     ENDIF
2492:                 ELSE
2493:                     IF !loc_oBusca.this_lAchouRegistro
2494:                         loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
2495:                         loc_oBusca.mAddColuna("Rclis", "", "Descri" + CHR(231) + CHR(227) + "o")
2496:                         loc_oBusca.Show()
2497:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
2498:                             SELECT cursor_4c_Busca
2499:                             loc_oPagina.txt_4c_Job.Value  = PADR(ALLTRIM(cursor_4c_Busca.Iclis), 10)
2500:                             loc_oPagina.txt_4c_DJob.Value = PADR(ALLTRIM(cursor_4c_Busca.Rclis), 40)
2501:                         ENDIF
2502:                     ENDIF
2503:                 ENDIF
2504:                 loc_oBusca.Release()
2505:             ENDIF
2506: 
2507:             IF USED("cursor_4c_Busca")
2508:                 USE IN cursor_4c_Busca
2509:             ENDIF
2510: 
2511:         CATCH TO loc_oErro
2512:             MsgErro(loc_oErro.Message, "AbrirLookupJob")
2513:         ENDTRY

*-- Linhas 2527 a 2549:
2527:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
2528:             loc_cCod    = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
2529:             IF !EMPTY(loc_cCod)
2530:                 loc_nRes = SQLEXEC(gnConnHandle, ;
2531:                     "SELECT TOP 1 descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cCod), ;
2532:                     "cursor_4c_TmpGrupo")
2533:                 IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpGrupo") > 0
2534:                     SELECT cursor_4c_TmpGrupo
2535:                     loc_oPagina.txt_4c_DGrupo.Value = PADR(ALLTRIM(NVL(descrs, "")), 40)
2536:                 ELSE
2537:                     loc_oPagina.txt_4c_DGrupo.Value = SPACE(40)
2538:                     MsgAviso("Grupo n" + CHR(227) + "o encontrado: " + loc_cCod, "Grupo")
2539:                     loc_oPagina.txt_4c_Grupo.Value = SPACE(10)
2540:                 ENDIF
2541:                 IF USED("cursor_4c_TmpGrupo")
2542:                     USE IN cursor_4c_TmpGrupo
2543:                 ENDIF
2544:             ELSE
2545:                 loc_oPagina.txt_4c_DGrupo.Value = SPACE(40)
2546:             ENDIF
2547:         CATCH TO loc_oErro
2548:             MsgErro(loc_oErro.Message, "GrupoLostFocus")
2549:         ENDTRY

*-- Linhas 2567 a 2589:
2567:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
2568:             loc_cCod    = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
2569:             IF !EMPTY(loc_cCod)
2570:                 loc_nRes = SQLEXEC(gnConnHandle, ;
2571:                     "SELECT TOP 1 Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cCod), ;
2572:                     "cursor_4c_TmpConta")
2573:                 IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpConta") > 0
2574:                     SELECT cursor_4c_TmpConta
2575:                     loc_oPagina.txt_4c_DcConta.Value = PADR(ALLTRIM(NVL(Rclis, "")), 40)
2576:                 ELSE
2577:                     loc_oPagina.txt_4c_DcConta.Value = SPACE(40)
2578:                     MsgAviso("Conta n" + CHR(227) + "o encontrada: " + loc_cCod, "Conta")
2579:                     loc_oPagina.txt_4c_Conta.Value = SPACE(10)
2580:                 ENDIF
2581:                 IF USED("cursor_4c_TmpConta")
2582:                     USE IN cursor_4c_TmpConta
2583:                 ENDIF
2584:             ELSE
2585:                 loc_oPagina.txt_4c_DcConta.Value = SPACE(40)
2586:             ENDIF
2587:         CATCH TO loc_oErro
2588:             MsgErro(loc_oErro.Message, "ContaLostFocus")
2589:         ENDTRY

*-- Linhas 2607 a 2626:
2607:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
2608:             loc_cCod    = ALLTRIM(loc_oPagina.txt_4c_Moeda.Value)
2609:             IF !EMPTY(loc_cCod)
2610:                 loc_nRes = SQLEXEC(gnConnHandle, ;
2611:                     "SELECT TOP 1 cmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cCod), ;
2612:                     "cursor_4c_TmpMoeda")
2613:                 IF loc_nRes <= 0 OR RECCOUNT("cursor_4c_TmpMoeda") = 0
2614:                     MsgAviso("Moeda n" + CHR(227) + "o encontrada: " + loc_cCod, "Moeda")
2615:                     loc_oPagina.txt_4c_Moeda.Value = SPACE(3)
2616:                 ENDIF
2617:                 IF USED("cursor_4c_TmpMoeda")
2618:                     USE IN cursor_4c_TmpMoeda
2619:                 ENDIF
2620:             ENDIF
2621:         CATCH TO loc_oErro
2622:             MsgErro(loc_oErro.Message, "MoedaLostFocus")
2623:         ENDTRY
2624:     ENDPROC
2625: 
2626:     *--------------------------------------------------------------------------

*-- Linhas 2641 a 2663:
2641:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
2642:             loc_cCod    = ALLTRIM(loc_oPagina.txt_4c_SGrupo.Value)
2643:             IF !EMPTY(loc_cCod)
2644:                 loc_nRes = SQLEXEC(gnConnHandle, ;
2645:                     "SELECT TOP 1 descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cCod), ;
2646:                     "cursor_4c_TmpSGrupo")
2647:                 IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpSGrupo") > 0
2648:                     SELECT cursor_4c_TmpSGrupo
2649:                     loc_oPagina.txt_4c_SDGrupo.Value = PADR(ALLTRIM(NVL(descrs, "")), 40)
2650:                 ELSE
2651:                     loc_oPagina.txt_4c_SDGrupo.Value = SPACE(40)
2652:                     MsgAviso("Grupo n" + CHR(227) + "o encontrado: " + loc_cCod, "Grupo")
2653:                     loc_oPagina.txt_4c_SGrupo.Value = SPACE(10)
2654:                 ENDIF
2655:                 IF USED("cursor_4c_TmpSGrupo")
2656:                     USE IN cursor_4c_TmpSGrupo
2657:                 ENDIF
2658:             ELSE
2659:                 loc_oPagina.txt_4c_SDGrupo.Value = SPACE(40)
2660:             ENDIF
2661:         CATCH TO loc_oErro
2662:             MsgErro(loc_oErro.Message, "SGrupoLostFocus")
2663:         ENDTRY

*-- Linhas 2681 a 2703:
2681:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
2682:             loc_cCod    = ALLTRIM(loc_oPagina.txt_4c_SConta.Value)
2683:             IF !EMPTY(loc_cCod)
2684:                 loc_nRes = SQLEXEC(gnConnHandle, ;
2685:                     "SELECT TOP 1 Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cCod), ;
2686:                     "cursor_4c_TmpSConta")
2687:                 IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpSConta") > 0
2688:                     SELECT cursor_4c_TmpSConta
2689:                     loc_oPagina.txt_4c_SDcConta.Value = PADR(ALLTRIM(NVL(Rclis, "")), 40)
2690:                 ELSE
2691:                     loc_oPagina.txt_4c_SDcConta.Value = SPACE(40)
2692:                     MsgAviso("Conta n" + CHR(227) + "o encontrada: " + loc_cCod, "Conta")
2693:                     loc_oPagina.txt_4c_SConta.Value = SPACE(10)
2694:                 ENDIF
2695:                 IF USED("cursor_4c_TmpSConta")
2696:                     USE IN cursor_4c_TmpSConta
2697:                 ENDIF
2698:             ELSE
2699:                 loc_oPagina.txt_4c_SDcConta.Value = SPACE(40)
2700:             ENDIF
2701:         CATCH TO loc_oErro
2702:             MsgErro(loc_oErro.Message, "SContaLostFocus")
2703:         ENDTRY

*-- Linhas 2721 a 2740:
2721:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
2722:             loc_cCod    = ALLTRIM(loc_oPagina.txt_4c_SMoeda.Value)
2723:             IF !EMPTY(loc_cCod)
2724:                 loc_nRes = SQLEXEC(gnConnHandle, ;
2725:                     "SELECT TOP 1 cmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cCod), ;
2726:                     "cursor_4c_TmpSMoeda")
2727:                 IF loc_nRes <= 0 OR RECCOUNT("cursor_4c_TmpSMoeda") = 0
2728:                     MsgAviso("Moeda n" + CHR(227) + "o encontrada: " + loc_cCod, "Moeda")
2729:                     loc_oPagina.txt_4c_SMoeda.Value = SPACE(3)
2730:                 ENDIF
2731:                 IF USED("cursor_4c_TmpSMoeda")
2732:                     USE IN cursor_4c_TmpSMoeda
2733:                 ENDIF
2734:             ENDIF
2735:         CATCH TO loc_oErro
2736:             MsgErro(loc_oErro.Message, "SMoedaLostFocus")
2737:         ENDTRY
2738:     ENDPROC
2739: 
2740:     *--------------------------------------------------------------------------

*-- Linhas 2755 a 2777:
2755:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
2756:             loc_cCod    = ALLTRIM(loc_oPagina.txt_4c_Job.Value)
2757:             IF !EMPTY(loc_cCod)
2758:                 loc_nRes = SQLEXEC(gnConnHandle, ;
2759:                     "SELECT TOP 1 Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cCod), ;
2760:                     "cursor_4c_TmpJob")
2761:                 IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpJob") > 0
2762:                     SELECT cursor_4c_TmpJob
2763:                     loc_oPagina.txt_4c_DJob.Value = PADR(ALLTRIM(NVL(Rclis, "")), 40)
2764:                 ELSE
2765:                     loc_oPagina.txt_4c_DJob.Value = SPACE(40)
2766:                     MsgAviso("Job n" + CHR(227) + "o encontrado: " + loc_cCod, "Job")
2767:                     loc_oPagina.txt_4c_Job.Value = SPACE(10)
2768:                 ENDIF
2769:                 IF USED("cursor_4c_TmpJob")
2770:                     USE IN cursor_4c_TmpJob
2771:                 ENDIF
2772:             ELSE
2773:                 loc_oPagina.txt_4c_DJob.Value = SPACE(40)
2774:             ENDIF
2775:         CATCH TO loc_oErro
2776:             MsgErro(loc_oErro.Message, "JobLostFocus")
2777:         ENDTRY


### BO (C:\4c\projeto\app\classes\sigmvccrBO.prg):
*==============================================================================
* sigmvccrBO.prg - Business Object para Movimentos de Conta Corrente
* Data: 2026-04-11
* Tabela: SigMvCcr | PK: cidchaves (clustered)
* Operacao principal: nopers (numero da operacao)
*==============================================================================

DEFINE CLASS sigmvccrBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - campos BIT (logico)
    *--------------------------------------------------------------------------
    this_lAutos   = .F.    && autos   BIT - Lancamento automatico
    this_lConcs   = .F.    && concs   BIT - Conciliado

    *--------------------------------------------------------------------------
    * Propriedades - campos CHAR
    *--------------------------------------------------------------------------
    this_cEmps        = ""    && emps        CHAR(3)  - Empresa (FK)
    this_cEmpccs      = ""    && empccs      CHAR(3)  - Empresa contra-partida
    this_cEmpos       = ""    && empos       CHAR(3)  - Empresa origem

    this_cCidchaves   = ""    && cidchaves   CHAR(20) - Chave unica (PK)
    this_cGruconmoes  = ""    && gruconmoes  CHAR(23) - Grupos+Contas+Moedas (computado)
    this_cEmpdopncs   = ""    && empdopncs   CHAR(29) - Emps+Dopes+Numcs
    this_cEmpdopnums  = ""    && empdopnums  CHAR(29) - Emps+Dopes+Numes
    this_cDopotps     = ""    && dopotps     CHAR(23) - Dopes+Opers+Tipos+Pagos

    this_cDopes       = ""    && dopes       CHAR(20) - Operacao debito
    this_cDopcs       = ""    && dopcs       CHAR(20) - Operacao credito
    this_cVopers      = ""    && vopers      CHAR(13) - Operacao estendida
    this_cOpers       = ""    && opers       CHAR(1)  - Tipo D/C (debito/credito)
    this_cSopers      = ""    && sopers      CHAR(1)  - Tipo D/C contra-partida
    this_cTipos       = ""    && tipos       CHAR(1)  - Tipo de lancamento
    this_cPagos       = ""    && pagos       CHAR(1)  - Pago (S/N)

    this_cGrupos      = ""    && grupos      CHAR(10) - Grupo debito
    this_cContas      = ""    && contas      CHAR(10) - Conta debito
    this_cMoedas      = ""    && moedas      CHAR(3)  - Moeda debito
    this_cSgrupos     = ""    && sgrupos     CHAR(10) - Grupo credito
    this_cScontas     = ""    && scontas     CHAR(10) - Conta credito
    this_cSmoedas     = ""    && smoedas     CHAR(3)  - Moeda credito

    this_cContages    = ""    && contages    CHAR(10) - Conta gerencial
    this_cGrupages    = ""    && grupages    CHAR(10) - Grupo gerencial
    this_cContems     = ""    && contems     CHAR(10) - Conta empresa
    this_cGrupems     = ""    && grupems     CHAR(10) - Grupo empresa
    this_cLocals      = ""    && locals      CHAR(10) - Local
    this_cBcontas     = ""    && bcontas     CHAR(10) - Conta bancaria
    this_cBgrupos     = ""    && bgrupos     CHAR(10) - Grupo bancario
    this_cRcontas     = ""    && rcontas     CHAR(10) - Conta referencia
    this_cVlancs      = ""    && vlancs      CHAR(10) - Vinculo lancamento

    this_cNfs         = ""    && nfs         CHAR(10) - Numero nota fiscal
    this_cDocus       = ""    && docus       CHAR(10) - Documento
    this_cEspecienfs  = ""    && especienfs  CHAR(6)  - Especie NF
    this_cTpdocnf     = ""    && tpdocnf     CHAR(2)  - Tipo documento NF
    this_cTitulos     = ""    && titulos     CHAR(10) - Titulo
    this_cTitbans     = ""    && titbans     CHAR(12) - Titulo bancario
    this_cTitpais     = ""    && titpais     CHAR(10) - Titulo pai

    this_cHists       = ""    && hists       CHAR(60) - Historico
    this_cHist2s      = ""    && hist2s      CHAR(80) - Historico 2
    this_cShists      = ""    && shists      CHAR(40) - Historico complementar

    this_cJobs        = ""    && jobs        CHAR(10) - Job/Projeto
    this_cCompet      = ""    && compet      CHAR(7)  - Competencia (AAAAMM)
    this_cOridopnums  = ""    && oridopnums  CHAR(29) - Operacao origem
    this_cCotusus     = ""    && cotusus     CHAR(10) - Cotacao usuario

    this_cUsualts     = ""    && usualts     CHAR(10) - Usuario alteracao
    this_cUsuexcs     = ""    && usuexcs     CHAR(10) - Usuario exclusao
    this_cUsuconcs    = ""    && usuconcs    CHAR(10) - Usuario conciliacao
    this_cAuditors    = ""    && auditors    CHAR(10) - Auditor
    this_cUsuconfs    = ""    && usuconfs    CHAR(10) - Usuario confirmacao
    this_cUsupagos    = ""    && usupagos    CHAR(10) - Usuario pagamento

    this_cPastas      = ""    && pastas      TEXT     - Pasta (memo)

    *--------------------------------------------------------------------------
    * Propriedades - campos NUMERIC
    *--------------------------------------------------------------------------
    this_nNopers      = 0     && nopers      NUMERIC(7,0)   - Numero operacao
    this_nNumes       = 0     && numes       NUMERIC(6,0)   - Numero debito
    this_nNumcs       = 0     && numcs       NUMERIC(6,0)   - Numero credito
    this_nNlancs      = 0     && nlancs      NUMERIC(6,0)   - Numero lancamento
    this_nNtrans      = 0     && ntrans      NUMERIC(6,0)   - Numero transferencia
    this_nBorderos    = 0     && borderos    NUMERIC(6,0)   - Bordereau
    this_nIntconts    = 0     && intconts    NUMERIC(6,0)   - Integracao contabil
    this_nNopercancs  = 0     && nopercancs  NUMERIC(7,0)   - Numero operacao cancelada

    this_nCotacaos    = 0     && cotacaos    NUMERIC(15,7)  - Cotacao debito
    this_nScotacaos   = 0     && scotacaos   NUMERIC(15,7)  - Cotacao credito

    this_nValors      = 0     && valors      NUMERIC(11,2)  - Valor debito
    this_nSvalors     = 0     && svalors     NUMERIC(11,2)  - Valor credito
    this_nValliqs     = 0     && valliqs     NUMERIC(11,2)  - Valor liquido
    this_nValocurs    = 0     && valocurs    NUMERIC(11,2)  - Valor ocorrencia
    this_nValpags     = 0     && valpags     NUMERIC(11,2)  - Valor pago
    this_nValprev     = 0     && valprev     NUMERIC(11,2)  - Valor previsto
    this_nImpostos    = 0     && impostos    NUMERIC(11,2)  - Impostos

    this_nSaldos      = 0     && saldos      NUMERIC(15,2)  - Saldo geral
    this_nSaldocs     = 0     && saldocs     NUMERIC(15,2)  - Saldo credito
    this_nSaldons     = 0     && saldons     NUMERIC(15,2)  - Saldo debito

    this_nContapgs    = 0     && contapgs    NUMERIC(1,0)   - Opcao conta (0=Global/1=Cred/2=Deb)
    this_nTitcancs    = 0     && titcancs    NUMERIC(1,0)   - Titulo cancelado
    this_nTpimpostos  = 0     && tpimpostos  NUMERIC(2,0)   - Tipo imposto
    this_nRecor       = 0     && recor       NUMERIC(1,0)   - Recorrencia

    *--------------------------------------------------------------------------
    * Propriedades - campos DATETIME
    *--------------------------------------------------------------------------
    this_dDatas     = {}      && datas       DATETIME - Data lancamento
    this_dVencs     = {}      && vencs       DATETIME - Data vencimento
    this_dDtemis    = {}      && dtemis      DATETIME - Data emissao
    this_dDatalts   = {}      && datalts     DATETIME - Data alteracao
    this_dDatexcs   = {}      && datexcs     DATETIME - Data exclusao
    this_dDataconcs = {}      && dataconcs   DATETIME - Data conciliacao
    this_dDatatrans = {}      && datatrans   DATETIME - Data transferencia
    this_dDtaudits  = {}      && dtaudits    DATETIME - Data auditoria
    this_dDtconfs   = {}      && dtconfs     DATETIME - Data confirmacao

    *--------------------------------------------------------------------------
    * Propriedades de filtro para Buscar()
    *--------------------------------------------------------------------------
    this_dFiltroInicio = {}   && Data inicial do filtro de periodo
    this_dFiltroFim    = {}   && Data final do filtro de periodo

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
    * ObterChavePrimaria - Retorna chave para auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista movimentos de conta corrente com filtro de periodo
    * par_cFiltro: clausula WHERE adicional (opcional)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cWhere = " WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                         " AND a.Datexcs IS NULL"

            IF !EMPTY(THIS.this_dFiltroInicio) AND !EMPTY(THIS.this_dFiltroFim)
                loc_cWhere = loc_cWhere + ;
                    " AND a.Datas >= " + FormatarDataSQL(THIS.this_dFiltroInicio) + ;
                    " AND a.Datas < DATEADD(day, 1, " + FormatarDataSQL(THIS.this_dFiltroFim) + ")"
            ENDIF

            IF !EMPTY(par_cFiltro)
                loc_cWhere = loc_cWhere + " AND " + par_cFiltro
            ENDIF

            loc_cSQL = "SELECT a.Emps, a.Nopers, a.Datas, a.Vencs, a.Dtemis," + ;
                       " a.Grupos, a.Contas, a.Moedas, a.Opers," + ;
                       " a.Sgrupos, a.Scontas, a.Smoedas, a.Sopers," + ;
                       " a.Valors, a.Svalors, a.Cotacaos, a.Scotacaos," + ;
                       " a.Hists, a.Hist2s, a.Shists, a.Nfs, a.Docus," + ;
                       " a.Cidchaves, a.Autos, a.Concs," + ;
                       " a.Vopers, a.Dopes, a.Dopcs," + ;
                       " a.Jobs, a.Usualts, a.Contapgs," + ;
                       " a.Saldos, a.Saldocs, a.Saldons" + ;
                       " FROM SigMvCcr a" + ;
                       loc_cWhere + ;
                       " ORDER BY a.Datas, a.Nopers"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult < 0
                MsgErro("Erro ao buscar movimentos de conta corrente:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvccrBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo cidchaves (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.Emps, a.Nopers, a.Datas, a.Vencs, a.Dtemis," + ;
                       " a.Grupos, a.Contas, a.Moedas, a.Opers," + ;
                       " a.Sgrupos, a.Scontas, a.Smoedas, a.Sopers," + ;
                       " a.Valors, a.Svalors, a.Cotacaos, a.Scotacaos," + ;
                       " a.Hists, a.Hist2s, a.Shists, a.Nfs, a.Docus," + ;
                       " a.Cidchaves, a.Autos, a.Concs, a.Pagos," + ;
                       " a.Vopers, a.Dopes, a.Dopcs," + ;
                       " a.Jobs, a.Usualts, a.Contapgs," + ;
                       " a.Saldos, a.Saldocs, a.Saldons," + ;
                       " a.Valliqs, a.Valocurs, a.Valpags, a.Valprev," + ;
                       " a.Impostos, a.Tpimpostos," + ;
                       " a.Nlancs, a.Ntrans, a.Numes, a.Numcs," + ;
                       " a.Borderos, a.Intconts, a.Nopercancs," + ;
                       " a.Titulos, a.Titbans, a.Titpais," + ;
                       " a.Contages, a.Grupages, a.Contems, a.Grupems," + ;
                       " a.Locals, a.Bcontas, a.Bgrupos, a.Rcontas," + ;
                       " a.Vlancs, a.Cotusus, a.Compet," + ;
                       " a.Empccs, a.Empos, a.Oridopnums," + ;
                       " a.Datalts, a.Datexcs, a.Dataconcs, a.Datatrans," + ;
                       " a.Dtaudits, a.Dtconfs," + ;
                       " a.Usualts, a.Usuexcs, a.Usuconcs, a.Auditors," + ;
                       " a.Usuconfs, a.Usupagos," + ;
                       " a.Tipos, a.Gruconmoes, a.Empdopncs, a.Empdopnums," + ;
                       " a.Dopotps, a.Titcancs, a.Especienfs, a.Tpdocnf," + ;
                       " a.Recor" + ;
                       " FROM SigMvCcr a" + ;
                       " WHERE a.Cidchaves = " + EscaparSQL(par_cCodigo)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvccrBO.CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    * SEMPRE usar SELECT (par_cAliasCursor) antes de acessar campos
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cCidchaves   = TratarNulo(cidchaves, "C")
                THIS.this_cEmps        = TratarNulo(emps, "C")
                THIS.this_nNopers      = TratarNulo(nopers, "N")
                THIS.this_dDatas       = TratarNulo(datas, "D")
                THIS.this_dVencs       = TratarNulo(vencs, "D")
                THIS.this_dDtemis      = TratarNulo(dtemis, "D")

                THIS.this_cGrupos      = TratarNulo(grupos, "C")
                THIS.this_cContas      = TratarNulo(contas, "C")
                THIS.this_cMoedas      = TratarNulo(moedas, "C")
                THIS.this_cOpers       = TratarNulo(opers, "C")
                THIS.this_cSgrupos     = TratarNulo(sgrupos, "C")
                THIS.this_cScontas     = TratarNulo(scontas, "C")
                THIS.this_cSmoedas     = TratarNulo(smoedas, "C")
                THIS.this_cSopers      = TratarNulo(sopers, "C")

                THIS.this_nValors      = TratarNulo(valors, "N")
                THIS.this_nSvalors     = TratarNulo(svalors, "N")
                THIS.this_nCotacaos    = TratarNulo(cotacaos, "N")
                THIS.this_nScotacaos   = TratarNulo(scotacaos, "N")

                THIS.this_cHists       = TratarNulo(hists, "C")
                THIS.this_cHist2s      = TratarNulo(hist2s, "C")
                THIS.this_cShists      = TratarNulo(shists, "C")
                THIS.this_cNfs         = TratarNulo(nfs, "C")
                THIS.this_cDocus       = TratarNulo(docus, "C")

                THIS.this_lAutos       = (IIF(VARTYPE(autos) = "L", autos, (NVL(autos, 0) = 1)))
                THIS.this_lConcs       = (IIF(VARTYPE(concs) = "L", concs, (NVL(concs, 0) = 1)))
                THIS.this_cPagos       = TratarNulo(pagos, "C")

                THIS.this_cVopers      = TratarNulo(vopers, "C")
                THIS.this_cDopes       = TratarNulo(dopes, "C")
                THIS.this_cDopcs       = TratarNulo(dopcs, "C")
                THIS.this_cJobs        = TratarNulo(jobs, "C")
                THIS.this_cUsualts     = TratarNulo(usualts, "C")
                THIS.this_nContapgs    = TratarNulo(contapgs, "N")

                THIS.this_nSaldos      = TratarNulo(saldos, "N")
                THIS.this_nSaldocs     = TratarNulo(saldocs, "N")
                THIS.this_nSaldons     = TratarNulo(saldons, "N")

                *-- Campos adicionais (presentes apenas em CarregarPorCodigo)
                IF PEMSTATUS((par_cAliasCursor), "nlancs", 8)
                    THIS.this_nNlancs    = TratarNulo(nlancs, "N")
                    THIS.this_nNtrans    = TratarNulo(ntrans, "N")
                    THIS.this_nNumes     = TratarNulo(numes, "N")
                    THIS.this_nNumcs     = TratarNulo(numcs, "N")
                    THIS.this_nBorderos  = TratarNulo(borderos, "N")
                    THIS.this_nIntconts  = TratarNulo(intconts, "N")
                    THIS.this_cTitulos   = TratarNulo(titulos, "C")
                    THIS.this_cTitbans   = TratarNulo(titbans, "C")
                    THIS.this_cTitpais   = TratarNulo(titpais, "C")
                    THIS.this_cContages  = TratarNulo(contages, "C")
                    THIS.this_cGrupages  = TratarNulo(grupages, "C")
                    THIS.this_cContems   = TratarNulo(contems, "C")
                    THIS.this_cGrupems   = TratarNulo(grupems, "C")
                    THIS.this_cLocals    = TratarNulo(locals, "C")
                    THIS.this_cBcontas   = TratarNulo(bcontas, "C")
                    THIS.this_cBgrupos   = TratarNulo(bgrupos, "C")
                    THIS.this_cRcontas   = TratarNulo(rcontas, "C")
                    THIS.this_cVlancs    = TratarNulo(vlancs, "C")
                    THIS.this_cCotusus   = TratarNulo(cotusus, "C")
                    THIS.this_cCompet    = TratarNulo(compet, "C")
                    THIS.this_cEmpccs    = TratarNulo(empccs, "C")
                    THIS.this_cEmpos     = TratarNulo(empos, "C")
                    THIS.this_cOridopnums = TratarNulo(oridopnums, "C")
                    THIS.this_dDatalts   = TratarNulo(datalts, "D")
                    THIS.this_dDatexcs   = TratarNulo(datexcs, "D")
                    THIS.this_dDataconcs = TratarNulo(dataconcs, "D")
                    THIS.this_dDatatrans = TratarNulo(datatrans, "D")
                    THIS.this_dDtaudits  = TratarNulo(dtaudits, "D")
                    THIS.this_dDtconfs   = TratarNulo(dtconfs, "D")
                    THIS.this_cUsuexcs   = TratarNulo(usuexcs, "C")
                    THIS.this_cUsuconcs  = TratarNulo(usuconcs, "C")
                    THIS.this_cAuditors  = TratarNulo(auditors, "C")
                    THIS.this_cUsuconfs  = TratarNulo(usuconfs, "C")
                    THIS.this_cUsupagos  = TratarNulo(usupagos, "C")
                    THIS.this_cTipos     = TratarNulo(tipos, "C")
                    THIS.this_cGruconmoes = TratarNulo(gruconmoes, "C")
                    THIS.this_cEmpdopncs  = TratarNulo(empdopncs, "C")
                    THIS.this_cEmpdopnums = TratarNulo(empdopnums, "C")
                    THIS.this_cDopotps    = TratarNulo(dopotps, "C")
                    THIS.this_nTitcancs   = TratarNulo(titcancs, "N")
                    THIS.this_cEspecienfs = TratarNulo(especienfs, "C")
                    THIS.this_cTpdocnf    = TratarNulo(tpdocnf, "C")
                    THIS.this_nRecor      = TratarNulo(recor, "N")
                    THIS.this_nNopercancs = TratarNulo(nopercancs, "N")
                    THIS.this_nValliqs    = TratarNulo(valliqs, "N")
                    THIS.this_nValocurs   = TratarNulo(valocurs, "N")
                    THIS.this_nValpags    = TratarNulo(valpags, "N")
                    THIS.this_nValprev    = TratarNulo(valprev, "N")
                    THIS.this_nImpostos   = TratarNulo(impostos, "N")
                    THIS.this_nTpimpostos = TratarNulo(tpimpostos, "N")
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvccrBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro em SigMvCcr
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_nNopers, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Obter proximo nopers para a empresa
            loc_cSQL = "SELECT ISNULL(MAX(Nopers), 0) + 1 AS ProxNopers" + ;
                       " FROM SigMvCcr WITH (UPDLOCK, HOLDLOCK)" + ;
                       " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

            IF USED("cursor_4c_ProxNoper")
                USE IN cursor_4c_ProxNoper
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProxNoper")

            IF loc_nResult < 0 OR RECCOUNT("cursor_4c_ProxNoper") = 0
                MsgErro("Erro ao obter numero de operacao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                IF USED("cursor_4c_ProxNoper")
                    USE IN cursor_4c_ProxNoper
                ENDIF
                loc_lSucesso = .F.
            ENDIF

            SELECT cursor_4c_ProxNoper
            loc_nNopers = cursor_4c_ProxNoper.ProxNopers
            THIS.this_nNopers = loc_nNopers

            IF USED("cursor_4c_ProxNoper")
                USE IN cursor_4c_ProxNoper
            ENDIF

            *-- Gerar cidchaves: YYYYMMDD + nopers 6 digitos
            THIS.this_cCidchaves = DTOS(THIS.this_dDatas) + ;
                PADL(ALLTRIM(STR(loc_nNopers, 7, 0)), 7, "0")

            *-- Campos computados
            THIS.this_cGruconmoes  = ALLTRIM(THIS.this_cGrupos) + ;
                ALLTRIM(THIS.this_cContas) + ALLTRIM(THIS.this_cMoedas)
            THIS.this_cEmpdopncs   = ALLTRIM(go_4c_Sistema.cCodEmpresa) + ;
                ALLTRIM(THIS.this_cDopcs) + ALLTRIM(STR(THIS.this_nNumcs, 6, 0))
            THIS.this_cEmpdopnums  = ALLTRIM(go_4c_Sistema.cCodEmpresa) + ;
                ALLTRIM(THIS.this_cDopes) + ALLTRIM(STR(THIS.this_nNumes, 6, 0))
            THIS.this_cDopotps     = ALLTRIM(THIS.this_cDopes) + ;
                ALLTRIM(THIS.this_cOpers) + ALLTRIM(THIS.this_cTipos) + ;
                ALLTRIM(THIS.this_cPagos)

            *-- INSERT com colunas sem duplicatas (82 colunas)
            loc_cSQL = "INSERT INTO SigMvCcr (" + ;
                       " Emps, Nopers, Cidchaves, Datas, Vencs, Dtemis," + ;
                       " Grupos, Contas, Moedas, Opers," + ;
                       " Sgrupos, Scontas, Smoedas, Sopers," + ;
                       " Valors, Svalors, Cotacaos, Scotacaos," + ;
                       " Hists, Hist2s, Shists, Nfs, Docus," + ;
                       " Autos, Concs, Pagos, Tipos," + ;
                       " Vopers, Dopes, Dopcs, Jobs, Contapgs," + ;
                       " Saldos, Saldocs, Saldons," + ;
                       " Valliqs, Valocurs, Valpags, Valprev, Impostos, Tpimpostos," + ;
                       " Nlancs, Ntrans, Numes, Numcs, Borderos, Intconts, Nopercancs," + ;
                       " Titulos, Titbans, Titpais, Titcancs," + ;
                       " Contages, Grupages, Contems, Grupems," + ;
                       " Locals, Bcontas, Bgrupos, Rcontas, Vlancs, Cotusus," + ;
                       " Compet, Empccs, Empos, Oridopnums, Tpdocnf, Especienfs, Recor," + ;
                       " Gruconmoes, Empdopncs, Empdopnums, Dopotps," + ;
                       " Usualts, Usuexcs, Usuconcs, Auditors, Usuconfs, Usupagos" + ;
                       ") VALUES ("

            *-- Valores linha 1: chaves e datas (6 valores)
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(go_4c_Sistema.cCodEmpresa) + "," + ;
                FormatarNumeroSQL(THIS.this_nNopers) + "," + ;
                EscaparSQL(THIS.this_cCidchaves) + "," + ;
                FormatarDataSQL(THIS.this_dDatas) + "," + ;
                FormatarDataSQL(THIS.this_dVencs) + "," + ;
                FormatarDataSQL(THIS.this_dDtemis) + ","

            *-- Valores linha 2: grupos, contas, moedas, operacoes (8 valores)
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(THIS.this_cGrupos) + "," + ;
                EscaparSQL(THIS.this_cContas) + "," + ;
                EscaparSQL(THIS.this_cMoedas) + "," + ;
                EscaparSQL(THIS.this_cOpers) + "," + ;
                EscaparSQL(THIS.this_cSgrupos) + "," + ;
                EscaparSQL(THIS.this_cScontas) + "," + ;
                EscaparSQL(THIS.this_cSmoedas) + "," + ;
                EscaparSQL(THIS.this_cSopers) + ","

            *-- Valores linha 3: valores e cotacoes (4 valores)
            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nValors) + "," + ;
                FormatarNumeroSQL(THIS.this_nSvalors) + "," + ;
                FormatarNumeroSQL(THIS.this_nCotacaos) + "," + ;
                FormatarNumeroSQL(THIS.this_nScotacaos) + ","

            *-- Valores linha 4: historico, nf, documento (5 valores)
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(THIS.this_cHists) + "," + ;
                EscaparSQL(THIS.this_cHist2s) + "," + ;
                EscaparSQL(THIS.this_cShists) + "," + ;
                EscaparSQL(THIS.this_cNfs) + "," + ;
                EscaparSQL(THIS.this_cDocus) + ","

            *-- Valores linha 5: flags, tipos, operacoes (11 valores)
            loc_cSQL = loc_cSQL + ;
                IIF(THIS.this_lAutos, "1", "0") + "," + ;
                IIF(THIS.this_lConcs, "1", "0") + "," + ;
                EscaparSQL(THIS.this_cPagos) + "," + ;
                EscaparSQL(THIS.this_cTipos) + "," + ;
                EscaparSQL(THIS.this_cVopers) + "," + ;
                EscaparSQL(THIS.this_cDopes) + "," + ;
                EscaparSQL(THIS.this_cDopcs) + "," + ;
                EscaparSQL(THIS.this_cJobs) + "," + ;
                FormatarNumeroSQL(THIS.this_nContapgs) + ","

            *-- Valores linha 6: saldos (3 valores)
            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nSaldos) + "," + ;
                FormatarNumeroSQL(THIS.this_nSaldocs) + "," + ;
                FormatarNumeroSQL(THIS.this_nSaldons) + ","

            *-- Valores linha 7: valores complementares e numeradores (13 valores)
            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nValliqs) + "," + ;
                FormatarNumeroSQL(THIS.this_nValocurs) + "," + ;
                FormatarNumeroSQL(THIS.this_nValpags) + "," + ;
                FormatarNumeroSQL(THIS.this_nValprev) + "," + ;
                FormatarNumeroSQL(THIS.this_nImpostos) + "," + ;
                FormatarNumeroSQL(THIS.this_nTpimpostos) + "," + ;
                FormatarNumeroSQL(THIS.this_nNlancs) + "," + ;
                FormatarNumeroSQL(THIS.this_nNtrans) + "," + ;
                FormatarNumeroSQL(THIS.this_nNumes) + "," + ;
                FormatarNumeroSQL(THIS.this_nNumcs) + "," + ;
                FormatarNumeroSQL(THIS.this_nBorderos) + "," + ;
                FormatarNumeroSQL(THIS.this_nIntconts) + "," + ;
                FormatarNumeroSQL(THIS.this_nNopercancs) + ","

            *-- Valores linha 8: titulos (4 valores)
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(THIS.this_cTitulos) + "," + ;
                EscaparSQL(THIS.this_cTitbans) + "," + ;
                EscaparSQL(THIS.this_cTitpais) + "," + ;
                FormatarNumeroSQL(THIS.this_nTitcancs) + ","

            *-- Valores linha 9: contas gerenciais (6 valores)
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(THIS.this_cContages) + "," + ;
                EscaparSQL(THIS.this_cGrupages) + "," + ;
                EscaparSQL(THIS.this_cContems) + "," + ;
                EscaparSQL(THIS.this_cGrupems) + "," + ;
                EscaparSQL(THIS.this_cLocals) + "," + ;
                EscaparSQL(THIS.this_cBcontas) + "," + ;
                EscaparSQL(THIS.this_cBgrupos) + "," + ;
                EscaparSQL(THIS.this_cRcontas) + "," + ;
                EscaparSQL(THIS.this_cVlancs) + "," + ;
                EscaparSQL(THIS.this_cCotusus) + ","

            *-- Valores linha 10: empresa/compet e campos computados (17 valores)
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(THIS.this_cCompet) + "," + ;
                EscaparSQL(THIS.this_cEmpccs) + "," + ;
                EscaparSQL(THIS.this_cEmpos) + "," + ;
                EscaparSQL(THIS.this_cOridopnums) + "," + ;
                EscaparSQL(THIS.this_cTpdocnf) + "," + ;
                EscaparSQL(THIS.this_cEspecienfs) + "," + ;
                FormatarNumeroSQL(THIS.this_nRecor) + "," + ;
                EscaparSQL(THIS.this_cGruconmoes) + "," + ;
                EscaparSQL(THIS.this_cEmpdopncs) + "," + ;
                EscaparSQL(THIS.this_cEmpdopnums) + "," + ;
                EscaparSQL(THIS.this_cDopotps) + ","

            *-- Valores linha 11: usuarios de auditoria (6 valores)
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
                EscaparSQL("") + "," + ;
                EscaparSQL("") + "," + ;
                EscaparSQL("") + "," + ;
                EscaparSQL("") + "," + ;
                EscaparSQL("") + ;
                ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

            IF loc_nResult < 0
                MsgErro("Erro ao inserir movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
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

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente em SigMvCcr
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Campos computados
            THIS.this_cGruconmoes  = ALLTRIM(THIS.this_cGrupos) + ;
                ALLTRIM(THIS.this_cContas) + ALLTRIM(THIS.this_cMoedas)
            THIS.this_cEmpdopncs   = ALLTRIM(go_4c_Sistema.cCodEmpresa) + ;
                ALLTRIM(THIS.this_cDopcs) + ALLTRIM(STR(THIS.this_nNumcs, 6, 0))
            THIS.this_cEmpdopnums  = ALLTRIM(go_4c_Sistema.cCodEmpresa) + ;
                ALLTRIM(THIS.this_cDopes) + ALLTRIM(STR(THIS.this_nNumes, 6, 0))
            THIS.this_cDopotps     = ALLTRIM(THIS.this_cDopes) + ;
                ALLTRIM(THIS.this_cOpers) + ALLTRIM(THIS.this_cTipos) + ;
                ALLTRIM(THIS.this_cPagos)

            loc_cSQL = "UPDATE SigMvCcr SET" + ;
                       " Datas = " + FormatarDataSQL(THIS.this_dDatas) + "," + ;
                       " Vencs = " + FormatarDataSQL(THIS.this_dVencs) + "," + ;
                       " Dtemis = " + FormatarDataSQL(THIS.this_dDtemis) + "," + ;
                       " Grupos = " + EscaparSQL(THIS.this_cGrupos) + "," + ;
                       " Contas = " + EscaparSQL(THIS.this_cContas) + "," + ;
                       " Moedas = " + EscaparSQL(THIS.this_cMoedas) + "," + ;
                       " Opers = " + EscaparSQL(THIS.this_cOpers) + "," + ;
                       " Sgrupos = " + EscaparSQL(THIS.this_cSgrupos) + "," + ;
                       " Scontas = " + EscaparSQL(THIS.this_cScontas) + "," + ;
                       " Smoedas = " + EscaparSQL(THIS.this_cSmoedas) + "," + ;
                       " Sopers = " + EscaparSQL(THIS.this_cSopers) + ","

            loc_cSQL = loc_cSQL + ;
                       " Valors = " + FormatarNumeroSQL(THIS.this_nValors) + "," + ;
                       " Svalors = " + FormatarNumeroSQL(THIS.this_nSvalors) + "," + ;
                       " Cotacaos = " + FormatarNumeroSQL(THIS.this_nCotacaos) + "," + ;
                       " Scotacaos = " + FormatarNumeroSQL(THIS.this_nScotacaos) + "," + ;
                       " Hists = " + EscaparSQL(THIS.this_cHists) + "," + ;
                       " Hist2s = " + EscaparSQL(THIS.this_cHist2s) + "," + ;
                       " Shists = " + EscaparSQL(THIS.this_cShists) + "," + ;
                       " Nfs = " + EscaparSQL(THIS.this_cNfs) + "," + ;
                       " Docus = " + EscaparSQL(THIS.this_cDocus) + ","

            loc_cSQL = loc_cSQL + ;
                       " Contapgs = " + FormatarNumeroSQL(THIS.this_nContapgs) + "," + ;
                       " Jobs = " + EscaparSQL(THIS.this_cJobs) + "," + ;
                       " Vopers = " + EscaparSQL(THIS.this_cVopers) + "," + ;
                       " Dopes = " + EscaparSQL(THIS.this_cDopes) + "," + ;
                       " Dopcs = " + EscaparSQL(THIS.this_cDopcs) + "," + ;
                       " Gruconmoes = " + EscaparSQL(THIS.this_cGruconmoes) + "," + ;
                       " Empdopncs = " + EscaparSQL(THIS.this_cEmpdopncs) + "," + ;
                       " Empdopnums = " + EscaparSQL(THIS.this_cEmpdopnums) + "," + ;
                       " Dopotps = " + EscaparSQL(THIS.this_cDopotps) + "," + ;
                       " Usualts = " + EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
                       " Datalts = GETDATE()" + ;
                       " WHERE Cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
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

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro de SigMvCcr por cidchaves
    * Nota: Registra data/usuario de exclusao antes de deletar fisicamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Marcar exclusao logica primeiro (DatExcs/UsuExcs)
            loc_cSQL = "UPDATE SigMvCcr SET" + ;
                       " Datexcs = GETDATE()," + ;
                       " Usuexcs = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                       " WHERE Cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdExc")

            IF loc_nResult < 0
                MsgErro("Erro ao marcar exclusao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_UpdExc")
                    USE IN cursor_4c_UpdExc
                ENDIF

                *-- Exclusao fisica
                loc_cSQL = "DELETE FROM SigMvCcr" + ;
                           " WHERE Cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Delete")

                IF loc_nResult < 0
                    MsgErro("Erro ao excluir movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    THIS.RegistrarAuditoria("DELETE")
                    IF USED("cursor_4c_Delete")
                        USE IN cursor_4c_Delete
                    ENDIF
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvccrBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

