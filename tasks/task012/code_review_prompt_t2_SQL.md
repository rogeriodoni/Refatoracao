# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigmvccr.prg) - TRECHOS RELEVANTES PARA PASS SQL (2982 linhas total):

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
521:             loc_oGrid.Column9.Header1.Caption  = ""
522:             loc_oGrid.Column10.Header1.Caption = "NF"
523:             loc_oGrid.Column11.Header1.Caption = "Documento"
524: 
525:             *--------------------------------------------------------------------
526:             * BINDEVENTs para botoes
527:             *--------------------------------------------------------------------

*-- Linhas 1503 a 1548:
1503:                 loc_dInicio = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_DtInicial.Value
1504:                 loc_dFim    = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_DtFinal.Value
1505: 
1506:                 loc_cWhere = " WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
1507: 
1508:                 IF !EMPTY(loc_dInicio) AND !EMPTY(loc_dFim)
1509:                     loc_cWhere = loc_cWhere + ;
1510:                         " AND a.Datas >= " + FormatarDataSQL(loc_dInicio) + ;
1511:                         " AND a.Datas < DATEADD(day, 1, " + FormatarDataSQL(loc_dFim) + ")"
1512:                 ENDIF
1513: 
1514:                 loc_cSQL = "SELECT a.Datas, a.Opers, a.Contas, a.Scontas," + ;
1515:                            " a.Hists, a.Valors, a.Svalors, a.Concs, a.Autos," + ;
1516:                            " a.Nfs, a.Docus, a.Nopers, a.Cidchaves" + ;
1517:                            " FROM SigMvCcr a" + ;
1518:                            loc_cWhere + ;
1519:                            " ORDER BY a.Datas, a.Nopers"
1520: 
1521:                 IF USED("cursor_4c_DadosTemp")
1522:                     USE IN cursor_4c_DadosTemp
1523:                 ENDIF
1524: 
1525:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp")
1526: 
1527:                 IF loc_nResult < 0
1528:                     MsgErro("Erro ao carregar movimentos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1529:                 ELSE
1530:                     *-- ZAP + APPEND: preserva colunas do grid (nao destroi cursor_4c_Grade)
1531:                     ZAP IN cursor_4c_Grade
1532:                     SELECT cursor_4c_Grade
1533:                     APPEND FROM DBF("cursor_4c_DadosTemp")
1534:                     USE IN cursor_4c_DadosTemp
1535: 
1536:                     IF USED("cursor_4c_Grade")
1537:                         GO TOP IN cursor_4c_Grade
1538:                     ENDIF
1539: 
1540:                     *-- Reconfigurar headers (seguranca apos operacoes no cursor)
1541:                     loc_oGrid.Column1.Header1.Caption  = "Data"
1542:                     loc_oGrid.Column2.Header1.Caption  = "O"
1543:                     loc_oGrid.Column3.Header1.Caption  = "Conta"
1544:                     loc_oGrid.Column4.Header1.Caption  = "Contrapartida"
1545:                     loc_oGrid.Column5.Header1.Caption  = "Hist" + CHR(243) + "rico"
1546:                     loc_oGrid.Column6.Header1.Caption  = "D" + CHR(233) + "bito"
1547:                     loc_oGrid.Column7.Header1.Caption  = "Cr" + CHR(233) + "dito"
1548:                     loc_oGrid.Column8.Header1.Caption  = ""

*-- Linhas 1618 a 1636:
1618:             IF !USED("cursor_4c_Grade") OR EOF("cursor_4c_Grade") OR BOF("cursor_4c_Grade")
1619:                 MsgAviso("Nenhum registro selecionado.", "Visualizar")
1620:             ELSE
1621:                 SELECT cursor_4c_Grade
1622:                 loc_cChave = ALLTRIM(cursor_4c_Grade.Cidchaves)
1623: 
1624:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1625:                     THIS.this_cModoAtual = "VISUALIZAR"
1626:                     THIS.BOParaForm()
1627:                     THIS.pgf_4c_Paginas.ActivePage = 2
1628:                 ELSE
1629:                     MsgErro("Registro nao encontrado.", "Visualizar")
1630:                 ENDIF
1631:             ENDIF
1632:         CATCH TO loc_oErro
1633:             MsgErro(loc_oErro.Message, "BtnVisualizarClick")
1634:         ENDTRY
1635:     ENDPROC
1636: 

*-- Linhas 1643 a 1661:
1643:             IF !USED("cursor_4c_Grade") OR EOF("cursor_4c_Grade") OR BOF("cursor_4c_Grade")
1644:                 MsgAviso("Nenhum registro selecionado.", "Alterar")
1645:             ELSE
1646:                 SELECT cursor_4c_Grade
1647:                 loc_cChave = ALLTRIM(cursor_4c_Grade.Cidchaves)
1648: 
1649:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1650:                     THIS.this_oBusinessObject.EditarRegistro()
1651:                     THIS.this_cModoAtual = "ALTERAR"
1652:                     THIS.BOParaForm()
1653:                     THIS.pgf_4c_Paginas.ActivePage = 2
1654:                 ELSE
1655:                     MsgErro("Registro nao encontrado.", "Alterar")
1656:                 ENDIF
1657:             ENDIF
1658:         CATCH TO loc_oErro
1659:             MsgErro(loc_oErro.Message, "BtnAlterarClick")
1660:         ENDTRY
1661:     ENDPROC

*-- Linhas 1669 a 1687:
1669:             IF !USED("cursor_4c_Grade") OR EOF("cursor_4c_Grade") OR BOF("cursor_4c_Grade")
1670:                 MsgAviso("Nenhum registro selecionado.", "Excluir")
1671:             ELSE
1672:                 SELECT cursor_4c_Grade
1673:                 loc_cChave = ALLTRIM(cursor_4c_Grade.Cidchaves)
1674: 
1675:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1676:                     loc_lConfirmou = MsgConfirma( ;
1677:                         "Confirma a exclus" + CHR(227) + "o do movimento " + loc_cChave + "?", ;
1678:                         "Excluir")
1679: 
1680:                     IF loc_lConfirmou
1681:                         IF THIS.this_oBusinessObject.Excluir()
1682:                             MsgSucesso("Movimento exclu" + CHR(237) + "do com sucesso!")
1683:                             THIS.CarregarLista()
1684:                         ENDIF
1685:                     ENDIF
1686:                 ELSE
1687:                     MsgErro("Registro nao encontrado.", "Excluir")

*-- Linhas 1723 a 1741:
1723:             IF !USED("cursor_4c_Grade") OR EOF("cursor_4c_Grade") OR BOF("cursor_4c_Grade")
1724:                 MsgAviso("Selecione um registro para ver o movimento.", "Movimento")
1725:             ELSE
1726:                 SELECT cursor_4c_Grade
1727:                 loc_cChave = ALLTRIM(cursor_4c_Grade.Cidchaves)
1728: 
1729:                 IF EMPTY(loc_cChave)
1730:                     MsgAviso("Registro sem chave de opera" + CHR(231) + CHR(227) + "o.", "Movimento")
1731:                 ELSE
1732:                     THIS.this_cModoAtual = "VISUALIZAR"
1733:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1734:                         THIS.BOParaForm()
1735:                         THIS.pgf_4c_Paginas.ActivePage = 2
1736:                     ENDIF
1737:                 ENDIF
1738:             ENDIF
1739:         CATCH TO loc_oErro
1740:             MsgErro(loc_oErro.Message, "BtnMovimentoClick")
1741:         ENDTRY

*-- Linhas 1996 a 2094:
1996:             *-- Descricao Grupo esquerdo (SigCdGcr.codigos/descrs)
1997:             loc_cCod = ALLTRIM(par_oBO.this_cGrupos)
1998:             IF !EMPTY(loc_cCod)
1999:                 loc_nRes = SQLEXEC(gnConnHandle, ;
2000:                     "SELECT TOP 1 descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cCod), ;
2001:                     "cursor_4c_TmpDesc")
2002:                 IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpDesc") > 0
2003:                     SELECT cursor_4c_TmpDesc
2004:                     loc_oPagina.txt_4c_DGrupo.Value = PADR(ALLTRIM(NVL(descrs, "")), 40)
2005:                 ELSE
2006:                     loc_oPagina.txt_4c_DGrupo.Value = SPACE(40)
2007:                 ENDIF
2008:                 IF USED("cursor_4c_TmpDesc")
2009:                     USE IN cursor_4c_TmpDesc
2010:                 ENDIF
2011:             ELSE
2012:                 loc_oPagina.txt_4c_DGrupo.Value = SPACE(40)
2013:             ENDIF
2014: 
2015:             *-- Descricao Conta esquerdo (SigCdCli: Iclis=codigo, Rclis=nome)
2016:             loc_cCod = ALLTRIM(par_oBO.this_cContas)
2017:             IF !EMPTY(loc_cCod)
2018:                 loc_nRes = SQLEXEC(gnConnHandle, ;
2019:                     "SELECT TOP 1 Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cCod), ;
2020:                     "cursor_4c_TmpDesc")
2021:                 IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpDesc") > 0
2022:                     SELECT cursor_4c_TmpDesc
2023:                     loc_oPagina.txt_4c_DcConta.Value = PADR(ALLTRIM(NVL(Rclis, "")), 40)
2024:                 ELSE
2025:                     loc_oPagina.txt_4c_DcConta.Value = SPACE(40)
2026:                 ENDIF
2027:                 IF USED("cursor_4c_TmpDesc")
2028:                     USE IN cursor_4c_TmpDesc
2029:                 ENDIF
2030:             ELSE
2031:                 loc_oPagina.txt_4c_DcConta.Value = SPACE(40)
2032:             ENDIF
2033: 
2034:             *-- Descricao Grupo direito
2035:             loc_cCod = ALLTRIM(par_oBO.this_cSgrupos)
2036:             IF !EMPTY(loc_cCod)
2037:                 loc_nRes = SQLEXEC(gnConnHandle, ;
2038:                     "SELECT TOP 1 descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cCod), ;
2039:                     "cursor_4c_TmpDesc")
2040:                 IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpDesc") > 0
2041:                     SELECT cursor_4c_TmpDesc
2042:                     loc_oPagina.txt_4c_SDGrupo.Value = PADR(ALLTRIM(NVL(descrs, "")), 40)
2043:                 ELSE
2044:                     loc_oPagina.txt_4c_SDGrupo.Value = SPACE(40)
2045:                 ENDIF
2046:                 IF USED("cursor_4c_TmpDesc")
2047:                     USE IN cursor_4c_TmpDesc
2048:                 ENDIF
2049:             ELSE
2050:                 loc_oPagina.txt_4c_SDGrupo.Value = SPACE(40)
2051:             ENDIF
2052: 
2053:             *-- Descricao Conta direito (SigCdCli: Iclis=codigo, Rclis=nome)
2054:             loc_cCod = ALLTRIM(par_oBO.this_cScontas)
2055:             IF !EMPTY(loc_cCod)
2056:                 loc_nRes = SQLEXEC(gnConnHandle, ;
2057:                     "SELECT TOP 1 Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cCod), ;
2058:                     "cursor_4c_TmpDesc")
2059:                 IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpDesc") > 0
2060:                     SELECT cursor_4c_TmpDesc
2061:                     loc_oPagina.txt_4c_SDcConta.Value = PADR(ALLTRIM(NVL(Rclis, "")), 40)
2062:                 ELSE
2063:                     loc_oPagina.txt_4c_SDcConta.Value = SPACE(40)
2064:                 ENDIF
2065:                 IF USED("cursor_4c_TmpDesc")
2066:                     USE IN cursor_4c_TmpDesc
2067:                 ENDIF
2068:             ELSE
2069:                 loc_oPagina.txt_4c_SDcConta.Value = SPACE(40)
2070:             ENDIF
2071: 
2072:             *-- Descricao Job (SigCdCli: Iclis=codigo, Rclis=nome - mesmo que Conta)
2073:             loc_cCod = ALLTRIM(par_oBO.this_cJobs)
2074:             IF !EMPTY(loc_cCod)
2075:                 loc_nRes = SQLEXEC(gnConnHandle, ;
2076:                     "SELECT TOP 1 Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cCod), ;
2077:                     "cursor_4c_TmpDesc")
2078:                 IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpDesc") > 0
2079:                     SELECT cursor_4c_TmpDesc
2080:                     loc_oPagina.txt_4c_DJob.Value = PADR(ALLTRIM(NVL(Rclis, "")), 40)
2081:                 ELSE
2082:                     loc_oPagina.txt_4c_DJob.Value = SPACE(40)
2083:                 ENDIF
2084:                 IF USED("cursor_4c_TmpDesc")
2085:                     USE IN cursor_4c_TmpDesc
2086:                 ENDIF
2087:             ELSE
2088:                 loc_oPagina.txt_4c_DJob.Value = SPACE(40)
2089:             ENDIF
2090: 
2091:         CATCH TO loc_oErro
2092:             MsgErro(loc_oErro.Message, "CarregarDescricoesGruposConta")
2093:         ENDTRY
2094:     ENDPROC

*-- Linhas 2223 a 2251:
2223:             IF VARTYPE(loc_oBusca) = "O"
2224:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2225:                     IF USED("cursor_4c_Busca")
2226:                         SELECT cursor_4c_Busca
2227:                         loc_oPagina.txt_4c_Grupo.Value  = PADR(ALLTRIM(cursor_4c_Busca.codigos), 10)
2228:                         loc_oPagina.txt_4c_DGrupo.Value = PADR(ALLTRIM(cursor_4c_Busca.descrs), 40)
2229:                     ENDIF
2230:                 ELSE
2231:                     IF !loc_oBusca.this_lAchouRegistro
2232:                         loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
2233:                         loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
2234:                         loc_oBusca.Show()
2235:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
2236:                             SELECT cursor_4c_Busca
2237:                             loc_oPagina.txt_4c_Grupo.Value  = PADR(ALLTRIM(cursor_4c_Busca.codigos), 10)
2238:                             loc_oPagina.txt_4c_DGrupo.Value = PADR(ALLTRIM(cursor_4c_Busca.descrs), 40)
2239:                         ENDIF
2240:                     ENDIF
2241:                 ENDIF
2242:                 loc_oBusca.Release()
2243:             ENDIF
2244: 
2245:             IF USED("cursor_4c_Busca")
2246:                 USE IN cursor_4c_Busca
2247:             ENDIF
2248: 
2249:         CATCH TO loc_oErro
2250:             MsgErro(loc_oErro.Message, "AbrirLookupGrupo")
2251:         ENDTRY

*-- Linhas 2267 a 2295:
2267:             IF VARTYPE(loc_oBusca) = "O"
2268:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2269:                     IF USED("cursor_4c_Busca")
2270:                         SELECT cursor_4c_Busca
2271:                         loc_oPagina.txt_4c_SGrupo.Value  = PADR(ALLTRIM(cursor_4c_Busca.codigos), 10)
2272:                         loc_oPagina.txt_4c_SDGrupo.Value = PADR(ALLTRIM(cursor_4c_Busca.descrs), 40)
2273:                     ENDIF
2274:                 ELSE
2275:                     IF !loc_oBusca.this_lAchouRegistro
2276:                         loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
2277:                         loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
2278:                         loc_oBusca.Show()
2279:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
2280:                             SELECT cursor_4c_Busca
2281:                             loc_oPagina.txt_4c_SGrupo.Value  = PADR(ALLTRIM(cursor_4c_Busca.codigos), 10)
2282:                             loc_oPagina.txt_4c_SDGrupo.Value = PADR(ALLTRIM(cursor_4c_Busca.descrs), 40)
2283:                         ENDIF
2284:                     ENDIF
2285:                 ENDIF
2286:                 loc_oBusca.Release()
2287:             ENDIF
2288: 
2289:             IF USED("cursor_4c_Busca")
2290:                 USE IN cursor_4c_Busca
2291:             ENDIF
2292: 
2293:         CATCH TO loc_oErro
2294:             MsgErro(loc_oErro.Message, "AbrirLookupSGrupo")
2295:         ENDTRY

*-- Linhas 2312 a 2340:
2312:             IF VARTYPE(loc_oBusca) = "O"
2313:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2314:                     IF USED("cursor_4c_Busca")
2315:                         SELECT cursor_4c_Busca
2316:                         loc_oPagina.txt_4c_Conta.Value   = PADR(ALLTRIM(cursor_4c_Busca.Iclis), 10)
2317:                         loc_oPagina.txt_4c_DcConta.Value = PADR(ALLTRIM(cursor_4c_Busca.Rclis), 40)
2318:                     ENDIF
2319:                 ELSE
2320:                     IF !loc_oBusca.this_lAchouRegistro
2321:                         loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
2322:                         loc_oBusca.mAddColuna("Rclis", "", "Descri" + CHR(231) + CHR(227) + "o")
2323:                         loc_oBusca.Show()
2324:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
2325:                             SELECT cursor_4c_Busca
2326:                             loc_oPagina.txt_4c_Conta.Value   = PADR(ALLTRIM(cursor_4c_Busca.Iclis), 10)
2327:                             loc_oPagina.txt_4c_DcConta.Value = PADR(ALLTRIM(cursor_4c_Busca.Rclis), 40)
2328:                         ENDIF
2329:                     ENDIF
2330:                 ENDIF
2331:                 loc_oBusca.Release()
2332:             ENDIF
2333: 
2334:             IF USED("cursor_4c_Busca")
2335:                 USE IN cursor_4c_Busca
2336:             ENDIF
2337: 
2338:         CATCH TO loc_oErro
2339:             MsgErro(loc_oErro.Message, "AbrirLookupConta")
2340:         ENDTRY

*-- Linhas 2356 a 2384:
2356:             IF VARTYPE(loc_oBusca) = "O"
2357:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2358:                     IF USED("cursor_4c_Busca")
2359:                         SELECT cursor_4c_Busca
2360:                         loc_oPagina.txt_4c_SConta.Value   = PADR(ALLTRIM(cursor_4c_Busca.Iclis), 10)
2361:                         loc_oPagina.txt_4c_SDcConta.Value = PADR(ALLTRIM(cursor_4c_Busca.Rclis), 40)
2362:                     ENDIF
2363:                 ELSE
2364:                     IF !loc_oBusca.this_lAchouRegistro
2365:                         loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
2366:                         loc_oBusca.mAddColuna("Rclis", "", "Descri" + CHR(231) + CHR(227) + "o")
2367:                         loc_oBusca.Show()
2368:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
2369:                             SELECT cursor_4c_Busca
2370:                             loc_oPagina.txt_4c_SConta.Value   = PADR(ALLTRIM(cursor_4c_Busca.Iclis), 10)
2371:                             loc_oPagina.txt_4c_SDcConta.Value = PADR(ALLTRIM(cursor_4c_Busca.Rclis), 40)
2372:                         ENDIF
2373:                     ENDIF
2374:                 ENDIF
2375:                 loc_oBusca.Release()
2376:             ENDIF
2377: 
2378:             IF USED("cursor_4c_Busca")
2379:                 USE IN cursor_4c_Busca
2380:             ENDIF
2381: 
2382:         CATCH TO loc_oErro
2383:             MsgErro(loc_oErro.Message, "AbrirLookupSConta")
2384:         ENDTRY

*-- Linhas 2400 a 2427:
2400:             IF VARTYPE(loc_oBusca) = "O"
2401:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2402:                     IF USED("cursor_4c_Busca")
2403:                         SELECT cursor_4c_Busca
2404:                         loc_oPagina.txt_4c_Moeda.Value = PADR(ALLTRIM(cursor_4c_Busca.cmoes), 3)
2405:                     ENDIF
2406:                 ELSE
2407:                     IF !loc_oBusca.this_lAchouRegistro
2408:                         loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
2409:                         loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
2410:                         loc_oBusca.Show()
2411:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
2412:                             SELECT cursor_4c_Busca
2413:                             loc_oPagina.txt_4c_Moeda.Value = PADR(ALLTRIM(cursor_4c_Busca.cmoes), 3)
2414:                         ENDIF
2415:                     ENDIF
2416:                 ENDIF
2417:                 loc_oBusca.Release()
2418:             ENDIF
2419: 
2420:             IF USED("cursor_4c_Busca")
2421:                 USE IN cursor_4c_Busca
2422:             ENDIF
2423: 
2424:         CATCH TO loc_oErro
2425:             MsgErro(loc_oErro.Message, "AbrirLookupMoeda")
2426:         ENDTRY
2427:     ENDPROC

*-- Linhas 2442 a 2469:
2442:             IF VARTYPE(loc_oBusca) = "O"
2443:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2444:                     IF USED("cursor_4c_Busca")
2445:                         SELECT cursor_4c_Busca
2446:                         loc_oPagina.txt_4c_SMoeda.Value = PADR(ALLTRIM(cursor_4c_Busca.cmoes), 3)
2447:                     ENDIF
2448:                 ELSE
2449:                     IF !loc_oBusca.this_lAchouRegistro
2450:                         loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
2451:                         loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
2452:                         loc_oBusca.Show()
2453:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
2454:                             SELECT cursor_4c_Busca
2455:                             loc_oPagina.txt_4c_SMoeda.Value = PADR(ALLTRIM(cursor_4c_Busca.cmoes), 3)
2456:                         ENDIF
2457:                     ENDIF
2458:                 ENDIF
2459:                 loc_oBusca.Release()
2460:             ENDIF
2461: 
2462:             IF USED("cursor_4c_Busca")
2463:                 USE IN cursor_4c_Busca
2464:             ENDIF
2465: 
2466:         CATCH TO loc_oErro
2467:             MsgErro(loc_oErro.Message, "AbrirLookupSMoeda")
2468:         ENDTRY
2469:     ENDPROC

*-- Linhas 2484 a 2512:
2484:             IF VARTYPE(loc_oBusca) = "O"
2485:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2486:                     IF USED("cursor_4c_Busca")
2487:                         SELECT cursor_4c_Busca
2488:                         loc_oPagina.txt_4c_Job.Value  = PADR(ALLTRIM(cursor_4c_Busca.Iclis), 10)
2489:                         loc_oPagina.txt_4c_DJob.Value = PADR(ALLTRIM(cursor_4c_Busca.Rclis), 40)
2490:                     ENDIF
2491:                 ELSE
2492:                     IF !loc_oBusca.this_lAchouRegistro
2493:                         loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
2494:                         loc_oBusca.mAddColuna("Rclis", "", "Descri" + CHR(231) + CHR(227) + "o")
2495:                         loc_oBusca.Show()
2496:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
2497:                             SELECT cursor_4c_Busca
2498:                             loc_oPagina.txt_4c_Job.Value  = PADR(ALLTRIM(cursor_4c_Busca.Iclis), 10)
2499:                             loc_oPagina.txt_4c_DJob.Value = PADR(ALLTRIM(cursor_4c_Busca.Rclis), 40)
2500:                         ENDIF
2501:                     ENDIF
2502:                 ENDIF
2503:                 loc_oBusca.Release()
2504:             ENDIF
2505: 
2506:             IF USED("cursor_4c_Busca")
2507:                 USE IN cursor_4c_Busca
2508:             ENDIF
2509: 
2510:         CATCH TO loc_oErro
2511:             MsgErro(loc_oErro.Message, "AbrirLookupJob")
2512:         ENDTRY

*-- Linhas 2526 a 2548:
2526:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
2527:             loc_cCod    = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
2528:             IF !EMPTY(loc_cCod)
2529:                 loc_nRes = SQLEXEC(gnConnHandle, ;
2530:                     "SELECT TOP 1 descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cCod), ;
2531:                     "cursor_4c_TmpGrupo")
2532:                 IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpGrupo") > 0
2533:                     SELECT cursor_4c_TmpGrupo
2534:                     loc_oPagina.txt_4c_DGrupo.Value = PADR(ALLTRIM(NVL(descrs, "")), 40)
2535:                 ELSE
2536:                     loc_oPagina.txt_4c_DGrupo.Value = SPACE(40)
2537:                     MsgAviso("Grupo n" + CHR(227) + "o encontrado: " + loc_cCod, "Grupo")
2538:                     loc_oPagina.txt_4c_Grupo.Value = SPACE(10)
2539:                 ENDIF
2540:                 IF USED("cursor_4c_TmpGrupo")
2541:                     USE IN cursor_4c_TmpGrupo
2542:                 ENDIF
2543:             ELSE
2544:                 loc_oPagina.txt_4c_DGrupo.Value = SPACE(40)
2545:             ENDIF
2546:         CATCH TO loc_oErro
2547:             MsgErro(loc_oErro.Message, "GrupoLostFocus")
2548:         ENDTRY

*-- Linhas 2566 a 2588:
2566:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
2567:             loc_cCod    = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
2568:             IF !EMPTY(loc_cCod)
2569:                 loc_nRes = SQLEXEC(gnConnHandle, ;
2570:                     "SELECT TOP 1 Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cCod), ;
2571:                     "cursor_4c_TmpConta")
2572:                 IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpConta") > 0
2573:                     SELECT cursor_4c_TmpConta
2574:                     loc_oPagina.txt_4c_DcConta.Value = PADR(ALLTRIM(NVL(Rclis, "")), 40)
2575:                 ELSE
2576:                     loc_oPagina.txt_4c_DcConta.Value = SPACE(40)
2577:                     MsgAviso("Conta n" + CHR(227) + "o encontrada: " + loc_cCod, "Conta")
2578:                     loc_oPagina.txt_4c_Conta.Value = SPACE(10)
2579:                 ENDIF
2580:                 IF USED("cursor_4c_TmpConta")
2581:                     USE IN cursor_4c_TmpConta
2582:                 ENDIF
2583:             ELSE
2584:                 loc_oPagina.txt_4c_DcConta.Value = SPACE(40)
2585:             ENDIF
2586:         CATCH TO loc_oErro
2587:             MsgErro(loc_oErro.Message, "ContaLostFocus")
2588:         ENDTRY

*-- Linhas 2606 a 2625:
2606:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
2607:             loc_cCod    = ALLTRIM(loc_oPagina.txt_4c_Moeda.Value)
2608:             IF !EMPTY(loc_cCod)
2609:                 loc_nRes = SQLEXEC(gnConnHandle, ;
2610:                     "SELECT TOP 1 cmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cCod), ;
2611:                     "cursor_4c_TmpMoeda")
2612:                 IF loc_nRes <= 0 OR RECCOUNT("cursor_4c_TmpMoeda") = 0
2613:                     MsgAviso("Moeda n" + CHR(227) + "o encontrada: " + loc_cCod, "Moeda")
2614:                     loc_oPagina.txt_4c_Moeda.Value = SPACE(3)
2615:                 ENDIF
2616:                 IF USED("cursor_4c_TmpMoeda")
2617:                     USE IN cursor_4c_TmpMoeda
2618:                 ENDIF
2619:             ENDIF
2620:         CATCH TO loc_oErro
2621:             MsgErro(loc_oErro.Message, "MoedaLostFocus")
2622:         ENDTRY
2623:     ENDPROC
2624: 
2625:     *--------------------------------------------------------------------------

*-- Linhas 2640 a 2662:
2640:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
2641:             loc_cCod    = ALLTRIM(loc_oPagina.txt_4c_SGrupo.Value)
2642:             IF !EMPTY(loc_cCod)
2643:                 loc_nRes = SQLEXEC(gnConnHandle, ;
2644:                     "SELECT TOP 1 descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cCod), ;
2645:                     "cursor_4c_TmpSGrupo")
2646:                 IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpSGrupo") > 0
2647:                     SELECT cursor_4c_TmpSGrupo
2648:                     loc_oPagina.txt_4c_SDGrupo.Value = PADR(ALLTRIM(NVL(descrs, "")), 40)
2649:                 ELSE
2650:                     loc_oPagina.txt_4c_SDGrupo.Value = SPACE(40)
2651:                     MsgAviso("Grupo n" + CHR(227) + "o encontrado: " + loc_cCod, "Grupo")
2652:                     loc_oPagina.txt_4c_SGrupo.Value = SPACE(10)
2653:                 ENDIF
2654:                 IF USED("cursor_4c_TmpSGrupo")
2655:                     USE IN cursor_4c_TmpSGrupo
2656:                 ENDIF
2657:             ELSE
2658:                 loc_oPagina.txt_4c_SDGrupo.Value = SPACE(40)
2659:             ENDIF
2660:         CATCH TO loc_oErro
2661:             MsgErro(loc_oErro.Message, "SGrupoLostFocus")
2662:         ENDTRY

*-- Linhas 2680 a 2702:
2680:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
2681:             loc_cCod    = ALLTRIM(loc_oPagina.txt_4c_SConta.Value)
2682:             IF !EMPTY(loc_cCod)
2683:                 loc_nRes = SQLEXEC(gnConnHandle, ;
2684:                     "SELECT TOP 1 Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cCod), ;
2685:                     "cursor_4c_TmpSConta")
2686:                 IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpSConta") > 0
2687:                     SELECT cursor_4c_TmpSConta
2688:                     loc_oPagina.txt_4c_SDcConta.Value = PADR(ALLTRIM(NVL(Rclis, "")), 40)
2689:                 ELSE
2690:                     loc_oPagina.txt_4c_SDcConta.Value = SPACE(40)
2691:                     MsgAviso("Conta n" + CHR(227) + "o encontrada: " + loc_cCod, "Conta")
2692:                     loc_oPagina.txt_4c_SConta.Value = SPACE(10)
2693:                 ENDIF
2694:                 IF USED("cursor_4c_TmpSConta")
2695:                     USE IN cursor_4c_TmpSConta
2696:                 ENDIF
2697:             ELSE
2698:                 loc_oPagina.txt_4c_SDcConta.Value = SPACE(40)
2699:             ENDIF
2700:         CATCH TO loc_oErro
2701:             MsgErro(loc_oErro.Message, "SContaLostFocus")
2702:         ENDTRY

*-- Linhas 2720 a 2739:
2720:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
2721:             loc_cCod    = ALLTRIM(loc_oPagina.txt_4c_SMoeda.Value)
2722:             IF !EMPTY(loc_cCod)
2723:                 loc_nRes = SQLEXEC(gnConnHandle, ;
2724:                     "SELECT TOP 1 cmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cCod), ;
2725:                     "cursor_4c_TmpSMoeda")
2726:                 IF loc_nRes <= 0 OR RECCOUNT("cursor_4c_TmpSMoeda") = 0
2727:                     MsgAviso("Moeda n" + CHR(227) + "o encontrada: " + loc_cCod, "Moeda")
2728:                     loc_oPagina.txt_4c_SMoeda.Value = SPACE(3)
2729:                 ENDIF
2730:                 IF USED("cursor_4c_TmpSMoeda")
2731:                     USE IN cursor_4c_TmpSMoeda
2732:                 ENDIF
2733:             ENDIF
2734:         CATCH TO loc_oErro
2735:             MsgErro(loc_oErro.Message, "SMoedaLostFocus")
2736:         ENDTRY
2737:     ENDPROC
2738: 
2739:     *--------------------------------------------------------------------------

*-- Linhas 2754 a 2776:
2754:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
2755:             loc_cCod    = ALLTRIM(loc_oPagina.txt_4c_Job.Value)
2756:             IF !EMPTY(loc_cCod)
2757:                 loc_nRes = SQLEXEC(gnConnHandle, ;
2758:                     "SELECT TOP 1 Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cCod), ;
2759:                     "cursor_4c_TmpJob")
2760:                 IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpJob") > 0
2761:                     SELECT cursor_4c_TmpJob
2762:                     loc_oPagina.txt_4c_DJob.Value = PADR(ALLTRIM(NVL(Rclis, "")), 40)
2763:                 ELSE
2764:                     loc_oPagina.txt_4c_DJob.Value = SPACE(40)
2765:                     MsgAviso("Job n" + CHR(227) + "o encontrado: " + loc_cCod, "Job")
2766:                     loc_oPagina.txt_4c_Job.Value = SPACE(10)
2767:                 ENDIF
2768:                 IF USED("cursor_4c_TmpJob")
2769:                     USE IN cursor_4c_TmpJob
2770:                 ENDIF
2771:             ELSE
2772:                 loc_oPagina.txt_4c_DJob.Value = SPACE(40)
2773:             ENDIF
2774:         CATCH TO loc_oErro
2775:             MsgErro(loc_oErro.Message, "JobLostFocus")
2776:         ENDTRY


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
            loc_cWhere = " WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

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

