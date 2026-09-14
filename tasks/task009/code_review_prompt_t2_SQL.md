# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (5)
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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigmvccr.prg) - TRECHOS RELEVANTES PARA PASS SQL (2658 linhas total):

*-- Linhas 52 a 70:
52:                 *-- Cursor placeholder para grid (evita erros antes do primeiro load)
53:                 IF !USED("cursor_4c_Dados")
54:                     SET NULL ON
55:                     CREATE CURSOR cursor_4c_Dados ;
56:                         (cidchaves C(20), nopers N(10,0), opers C(1), ;
57:                          datas T, contas C(10), scontas C(10), ;
58:                          hists C(50), hist2s C(50), valors N(15,2), ;
59:                          svalors N(15,2), nfs C(15), docus C(20), ;
60:                          grupos C(10), sgrupos C(10), moedas C(3), ;
61:                          smoedas C(3), concs L, emps C(3), ;
62:                          vencs T, cotacaos N(15,7), scotacaos N(15,7), ;
63:                          contapgs N(1,0), jobs C(10), dtemis T, ;
64:                          sopers C(1), tipos C(1))
65:                     SET NULL OFF
66:                 ENDIF
67: 
68:                 THIS.ConfigurarPageFrame()
69:                 THIS.ConfigurarPaginaLista()
70:                 THIS.ConfigurarPaginaDados()

*-- Linhas 429 a 447:
429:             .FontName          = "Verdana"
430:             .FontSize          = 8
431:             .ReadOnly          = .T.
432:             .DeleteMark        = .F.
433:             .RecordMark        = .F.
434:             .ScrollBars        = 3
435:             .GridLines         = 3
436:             .GridLineColor     = RGB(238, 238, 238)
437:             .AllowHeaderSizing = .T.
438:             .Visible           = .T.
439:         ENDWITH
440:         loc_oPagina.grd_4c_Lista.ColumnCount = 11
441: 
442:         loc_oGrade = loc_oPagina.grd_4c_Lista
443: 
444:         *-- Column1: Data (Width=78, Alignment=2)
445:         WITH loc_oGrade.Column1
446:             .Width     = 78
447:             .Alignment = 2

*-- Linhas 1354 a 1383:
1354:                 loc_lResultado = .T.
1355:                 loc_oGrade.RecordSource = "cursor_4c_Dados"
1356: 
1357:                 *-- Definir ControlSources APOS RecordSource (CRITICO!)
1358:                 loc_oGrade.Column1.ControlSource  = "cursor_4c_Dados.datas"
1359:                 loc_oGrade.Column2.ControlSource  = "cursor_4c_Dados.opers"
1360:                 loc_oGrade.Column3.ControlSource  = "cursor_4c_Dados.contas"
1361:                 loc_oGrade.Column4.ControlSource  = "cursor_4c_Dados.scontas"
1362:                 loc_oGrade.Column5.ControlSource  = "cursor_4c_Dados.hists"
1363:                 loc_oGrade.Column6.ControlSource  = "cursor_4c_Dados.valors"
1364:                 loc_oGrade.Column7.ControlSource  = "cursor_4c_Dados.moedas"
1365:                 loc_oGrade.Column8.ControlSource  = "cursor_4c_Dados.svalors"
1366:                 loc_oGrade.Column9.ControlSource  = "cursor_4c_Dados.smoedas"
1367:                 loc_oGrade.Column10.ControlSource = "cursor_4c_Dados.nfs"
1368:                 loc_oGrade.Column11.ControlSource = "cursor_4c_Dados.docus"
1369: 
1370:                 *-- Redefinir Header1.Caption APOS RecordSource (OBRIGATORIO - Problema 32)
1371:                 loc_oGrade.Column1.Header1.Caption  = "Data"
1372:                 loc_oGrade.Column2.Header1.Caption  = "O"
1373:                 loc_oGrade.Column3.Header1.Caption  = "Conta"
1374:                 loc_oGrade.Column4.Header1.Caption  = "Contrapartida"
1375:                 loc_oGrade.Column5.Header1.Caption  = "Hist" + CHR(243) + "rico"
1376:                 loc_oGrade.Column6.Header1.Caption  = "D" + CHR(233) + "bito"
1377:                 loc_oGrade.Column7.Header1.Caption  = ""
1378:                 loc_oGrade.Column8.Header1.Caption  = "Cr" + CHR(233) + "dito"
1379:                 loc_oGrade.Column9.Header1.Caption  = ""
1380:                 loc_oGrade.Column10.Header1.Caption = "NF"
1381:                 loc_oGrade.Column11.Header1.Caption = "Documento"
1382: 
1383:                 *-- DynamicForeColor: azul para registros conciliados

*-- Linhas 1571 a 1592:
1571:         loc_lCotas = .F.
1572: 
1573:         IF !EMPTY(loc_cMoeda) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
1574:             loc_cSQL = "SELECT TOP 1 cotas FROM SigCdMoe WHERE Cmoes = " + EscaparSQL(loc_cMoeda)
1575:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Moe") >= 0
1576:                 IF RECCOUNT("cursor_4c_Moe") > 0
1577:                     SELECT cursor_4c_Moe
1578:                     loc_lCotas = NVL(cursor_4c_Moe.cotas, .F.)
1579:                 ENDIF
1580:                 IF USED("cursor_4c_Moe")
1581:                     USE IN cursor_4c_Moe
1582:                 ENDIF
1583:             ENDIF
1584:         ENDIF
1585: 
1586:         loc_oPagina.txt_4c_COTACAO.Visible         = loc_lCotas
1587:         loc_oPagina.lbl_4c__Cotacao.Visible        = loc_lCotas
1588:         loc_oPagina.cmd_4c_Alteracotacao.Visible   = loc_lCotas AND THIS.this_cModoAtual = "ALTERAR"
1589:     ENDPROC
1590: 
1591:     *--------------------------------------------------------------------------
1592:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)

*-- Linhas 1628 a 1669:
1628:             RETURN
1629:         ENDIF
1630: 
1631:         SELECT cursor_4c_Dados
1632:         loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)
1633: 
1634:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
1635:             THIS.BOParaForm()
1636:             THIS.this_cModoAtual = "VISUALIZAR"
1637:             THIS.HabilitarCampos(.F.)
1638:             THIS.AlternarPagina(2)
1639:         ENDIF
1640:     ENDPROC
1641: 
1642:     *--------------------------------------------------------------------------
1643:     * BtnAlterarClick - Alterar movimento selecionado
1644:     * Legado: verifica bloqueio de periodo, conciliacao e auditoria
1645:     *--------------------------------------------------------------------------
1646:     PROCEDURE BtnAlterarClick()
1647:         LOCAL loc_cCidchaves
1648: 
1649:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1650:             MsgAviso("Nenhum registro selecionado!")
1651:             RETURN
1652:         ENDIF
1653: 
1654:         SELECT cursor_4c_Dados
1655: 
1656:         *-- Verificar se movimento esta conciliado
1657:         IF cursor_4c_Dados.concs
1658:             MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida !! Movimenta" + CHR(231) + CHR(227) + "o Conciliada !")
1659:             RETURN
1660:         ENDIF
1661: 
1662:         loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)
1663: 
1664:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
1665:             *-- Verificar se e automatico
1666:             IF THIS.this_oBusinessObject.this_lAutos
1667:                 MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida !! Movimenta" + CHR(231) + CHR(227) + "o Autom" + CHR(225) + "tica !")
1668:                 RETURN
1669:             ENDIF

*-- Linhas 1689 a 1707:
1689:             RETURN
1690:         ENDIF
1691: 
1692:         SELECT cursor_4c_Dados
1693: 
1694:         IF cursor_4c_Dados.concs
1695:             MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida !! Movimenta" + CHR(231) + CHR(227) + "o Conciliada !")
1696:             RETURN
1697:         ENDIF
1698: 
1699:         loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)
1700: 
1701:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
1702:             RETURN
1703:         ENDIF
1704: 
1705:         IF THIS.this_oBusinessObject.this_lAutos
1706:             MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida !! Movimenta" + CHR(231) + CHR(227) + "o Autom" + CHR(225) + "tica !")
1707:             RETURN

*-- Linhas 2020 a 2038:
2020:             loc_oBusca.Show()
2021: 
2022:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
2023:                 SELECT cursor_4c_BuscaGcr
2024:                 loc_oPagina.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaGcr.Codigos)
2025:                 loc_oPagina.txt_4c_Dgrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.Descrs)
2026:             ENDIF
2027: 
2028:             IF USED("cursor_4c_BuscaGcr")
2029:                 USE IN cursor_4c_BuscaGcr
2030:             ENDIF
2031:             loc_oBusca.Release()
2032: 
2033:         CATCH TO loc_oErro
2034:             MsgErro("Erro no lookup de Grupo: " + loc_oErro.Message, "Erro")
2035:         ENDTRY
2036:     ENDPROC
2037: 
2038:     *--------------------------------------------------------------------------

*-- Linhas 2049 a 2072:
2049:         ENDIF
2050: 
2051:         TRY
2052:             loc_cSQL = "SELECT TOP 1 Codigos, Descrs, Classes FROM SigCdGcr" + ;
2053:                        " WHERE Codigos = " + EscaparSQL(loc_cGrupo)
2054: 
2055:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Gcr") >= 0
2056:                 IF RECCOUNT("cursor_4c_Gcr") > 0
2057:                     SELECT cursor_4c_Gcr
2058:                     loc_oPagina.txt_4c_Dgrupo.Value = ALLTRIM(cursor_4c_Gcr.Descrs)
2059:                     IF EMPTY(cursor_4c_Gcr.Classes)
2060:                         MsgAviso("Imposs" + CHR(237) + "vel Realizar Lan" + CHR(231) + "amento Neste Grupo!!!" + CHR(13) + ;
2061:                                  "A Classe do Grupo N" + CHR(227) + "o Foi Informada!!!")
2062:                     ENDIF
2063:                 ELSE
2064:                     MsgAviso("Grupo n" + CHR(227) + "o encontrado: " + loc_cGrupo)
2065:                     loc_oPagina.txt_4c_Grupo.Value  = ""
2066:                     loc_oPagina.txt_4c_Dgrupo.Value = ""
2067:                     loc_oPagina.txt_4c_Grupo.SetFocus()
2068:                 ENDIF
2069:                 IF USED("cursor_4c_Gcr")
2070:                     USE IN cursor_4c_Gcr
2071:                 ENDIF
2072:             ENDIF

*-- Linhas 2109 a 2127:
2109:             loc_oBusca.Show()
2110: 
2111:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
2112:                 SELECT cursor_4c_BuscaCli
2113:                 loc_oPagina.txt_4c_Conta.Value   = ALLTRIM(cursor_4c_BuscaCli.Iclis)
2114:                 loc_oPagina.txt_4c_Dconta.Value  = ALLTRIM(cursor_4c_BuscaCli.Rclis)
2115:             ENDIF
2116: 
2117:             IF USED("cursor_4c_BuscaCli")
2118:                 USE IN cursor_4c_BuscaCli
2119:             ENDIF
2120:             loc_oBusca.Release()
2121: 
2122:         CATCH TO loc_oErro
2123:             MsgErro("Erro no lookup de Conta: " + loc_oErro.Message, "Erro")
2124:         ENDTRY
2125:     ENDPROC
2126: 
2127:     *--------------------------------------------------------------------------

*-- Linhas 2138 a 2160:
2138:         ENDIF
2139: 
2140:         TRY
2141:             loc_cSQL = "SELECT TOP 1 Iclis, Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cConta)
2142: 
2143:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cli") >= 0
2144:                 IF RECCOUNT("cursor_4c_Cli") > 0
2145:                     SELECT cursor_4c_Cli
2146:                     loc_oPagina.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_Cli.Rclis)
2147:                 ELSE
2148:                     MsgAviso("Conta n" + CHR(227) + "o encontrada: " + loc_cConta)
2149:                     loc_oPagina.txt_4c_Conta.Value  = ""
2150:                     loc_oPagina.txt_4c_Dconta.Value = ""
2151:                     loc_oPagina.txt_4c_Conta.SetFocus()
2152:                 ENDIF
2153:                 IF USED("cursor_4c_Cli")
2154:                     USE IN cursor_4c_Cli
2155:                 ENDIF
2156:             ENDIF
2157:         CATCH TO loc_oErro
2158:             MsgErro("Erro ao validar Conta: " + loc_oErro.Message, "Erro")
2159:         ENDTRY
2160:     ENDPROC

*-- Linhas 2193 a 2211:
2193:             loc_oBusca.Show()
2194: 
2195:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
2196:                 SELECT cursor_4c_BuscaMoe
2197:                 loc_oPagina.txt_4c_MOEDA.Value = UPPER(ALLTRIM(cursor_4c_BuscaMoe.Cmoes))
2198:                 THIS.AtualizarVisibilidadeCotacao()
2199:             ENDIF
2200: 
2201:             IF USED("cursor_4c_BuscaMoe")
2202:                 USE IN cursor_4c_BuscaMoe
2203:             ENDIF
2204:             loc_oBusca.Release()
2205: 
2206:         CATCH TO loc_oErro
2207:             MsgErro("Erro no lookup de Moeda: " + loc_oErro.Message, "Erro")
2208:         ENDTRY
2209:     ENDPROC
2210: 
2211:     *==========================================================================

*-- Linhas 2242 a 2260:
2242:             loc_oBusca.Show()
2243: 
2244:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr2")
2245:                 SELECT cursor_4c_BuscaGcr2
2246:                 loc_oPagina.txt_4c_SGRUPO.Value  = ALLTRIM(cursor_4c_BuscaGcr2.Codigos)
2247:                 loc_oPagina.txt_4c_Sdgrupo.Value = ALLTRIM(cursor_4c_BuscaGcr2.Descrs)
2248:             ENDIF
2249: 
2250:             IF USED("cursor_4c_BuscaGcr2")
2251:                 USE IN cursor_4c_BuscaGcr2
2252:             ENDIF
2253:             loc_oBusca.Release()
2254: 
2255:         CATCH TO loc_oErro
2256:             MsgErro("Erro no lookup de SGrupo: " + loc_oErro.Message, "Erro")
2257:         ENDTRY
2258:     ENDPROC
2259: 
2260:     *--------------------------------------------------------------------------

*-- Linhas 2271 a 2293:
2271:         ENDIF
2272: 
2273:         TRY
2274:             loc_cSQL = "SELECT TOP 1 Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cSGrupo)
2275: 
2276:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcrS") >= 0
2277:                 IF RECCOUNT("cursor_4c_GcrS") > 0
2278:                     SELECT cursor_4c_GcrS
2279:                     loc_oPagina.txt_4c_Sdgrupo.Value = ALLTRIM(cursor_4c_GcrS.Descrs)
2280:                 ELSE
2281:                     MsgAviso("Grupo (Cr" + CHR(233) + "dito) n" + CHR(227) + "o encontrado: " + loc_cSGrupo)
2282:                     loc_oPagina.txt_4c_SGRUPO.Value  = ""
2283:                     loc_oPagina.txt_4c_Sdgrupo.Value = ""
2284:                     loc_oPagina.txt_4c_SGRUPO.SetFocus()
2285:                 ENDIF
2286:                 IF USED("cursor_4c_GcrS")
2287:                     USE IN cursor_4c_GcrS
2288:                 ENDIF
2289:             ENDIF
2290:         CATCH TO loc_oErro
2291:             MsgErro("Erro ao validar SGrupo: " + loc_oErro.Message, "Erro")
2292:         ENDTRY
2293:     ENDPROC

*-- Linhas 2326 a 2344:
2326:             loc_oBusca.Show()
2327: 
2328:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli2")
2329:                 SELECT cursor_4c_BuscaCli2
2330:                 loc_oPagina.txt_4c_SCONTA.Value  = ALLTRIM(cursor_4c_BuscaCli2.Iclis)
2331:                 loc_oPagina.txt_4c_SDCONTA.Value = ALLTRIM(cursor_4c_BuscaCli2.Rclis)
2332:             ENDIF
2333: 
2334:             IF USED("cursor_4c_BuscaCli2")
2335:                 USE IN cursor_4c_BuscaCli2
2336:             ENDIF
2337:             loc_oBusca.Release()
2338: 
2339:         CATCH TO loc_oErro
2340:             MsgErro("Erro no lookup de SConta: " + loc_oErro.Message, "Erro")
2341:         ENDTRY
2342:     ENDPROC
2343: 
2344:     *--------------------------------------------------------------------------

*-- Linhas 2355 a 2377:
2355:         ENDIF
2356: 
2357:         TRY
2358:             loc_cSQL = "SELECT TOP 1 Iclis, Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cSConta)
2359: 
2360:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliS") >= 0
2361:                 IF RECCOUNT("cursor_4c_CliS") > 0
2362:                     SELECT cursor_4c_CliS
2363:                     loc_oPagina.txt_4c_SDCONTA.Value = ALLTRIM(cursor_4c_CliS.Rclis)
2364:                 ELSE
2365:                     MsgAviso("Conta (Cr" + CHR(233) + "dito) n" + CHR(227) + "o encontrada: " + loc_cSConta)
2366:                     loc_oPagina.txt_4c_SCONTA.Value  = ""
2367:                     loc_oPagina.txt_4c_SDCONTA.Value = ""
2368:                     loc_oPagina.txt_4c_SCONTA.SetFocus()
2369:                 ENDIF
2370:                 IF USED("cursor_4c_CliS")
2371:                     USE IN cursor_4c_CliS
2372:                 ENDIF
2373:             ENDIF
2374:         CATCH TO loc_oErro
2375:             MsgErro("Erro ao validar SConta: " + loc_oErro.Message, "Erro")
2376:         ENDTRY
2377:     ENDPROC

*-- Linhas 2410 a 2428:
2410:             loc_oBusca.Show()
2411: 
2412:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe2")
2413:                 SELECT cursor_4c_BuscaMoe2
2414:                 loc_oPagina.txt_4c_Smoeda.Value = UPPER(ALLTRIM(cursor_4c_BuscaMoe2.Cmoes))
2415:                 THIS.AtualizarVisibilidadeSCotacao()
2416:             ENDIF
2417: 
2418:             IF USED("cursor_4c_BuscaMoe2")
2419:                 USE IN cursor_4c_BuscaMoe2
2420:             ENDIF
2421:             loc_oBusca.Release()
2422: 
2423:         CATCH TO loc_oErro
2424:             MsgErro("Erro no lookup de SMoeda: " + loc_oErro.Message, "Erro")
2425:         ENDTRY
2426:     ENDPROC
2427: 
2428:     *--------------------------------------------------------------------------

*-- Linhas 2437 a 2458:
2437:         loc_lCotas  = .F.
2438: 
2439:         IF !EMPTY(loc_cSMoeda) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
2440:             loc_cSQL = "SELECT TOP 1 cotas FROM SigCdMoe WHERE Cmoes = " + EscaparSQL(loc_cSMoeda)
2441:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeS") >= 0
2442:                 IF RECCOUNT("cursor_4c_MoeS") > 0
2443:                     SELECT cursor_4c_MoeS
2444:                     loc_lCotas = NVL(cursor_4c_MoeS.cotas, .F.)
2445:                 ENDIF
2446:                 IF USED("cursor_4c_MoeS")
2447:                     USE IN cursor_4c_MoeS
2448:                 ENDIF
2449:             ENDIF
2450:         ENDIF
2451: 
2452:         loc_oPagina.txt_4c_SCOTACAO.Visible       = loc_lCotas
2453:         loc_oPagina.lbl_4c__sCotacao.Visible      = loc_lCotas
2454:         loc_oPagina.cmd_4c_Alterascotacao.Visible = loc_lCotas AND THIS.this_cModoAtual = "ALTERAR"
2455:     ENDPROC
2456: 
2457:     *==========================================================================
2458:     * HANDLERS DE LOOKUP - JOB

*-- Linhas 2488 a 2506:
2488:             loc_oBusca.Show()
2489: 
2490:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaJob")
2491:                 SELECT cursor_4c_BuscaJob
2492:                 loc_oPagina.txt_4c_Job.Value  = ALLTRIM(cursor_4c_BuscaJob.Iclis)
2493:                 loc_oPagina.txt_4c_DJob.Value = ALLTRIM(cursor_4c_BuscaJob.Rclis)
2494:             ENDIF
2495: 
2496:             IF USED("cursor_4c_BuscaJob")
2497:                 USE IN cursor_4c_BuscaJob
2498:             ENDIF
2499:             loc_oBusca.Release()
2500: 
2501:         CATCH TO loc_oErro
2502:             MsgErro("Erro no lookup de Job: " + loc_oErro.Message, "Erro")
2503:         ENDTRY
2504:     ENDPROC
2505: 
2506:     *--------------------------------------------------------------------------

*-- Linhas 2517 a 2539:
2517:         ENDIF
2518: 
2519:         TRY
2520:             loc_cSQL = "SELECT TOP 1 Iclis, Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cJob)
2521: 
2522:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Job") >= 0
2523:                 IF RECCOUNT("cursor_4c_Job") > 0
2524:                     SELECT cursor_4c_Job
2525:                     loc_oPagina.txt_4c_DJob.Value = ALLTRIM(cursor_4c_Job.Rclis)
2526:                 ELSE
2527:                     MsgAviso("Job n" + CHR(227) + "o encontrado: " + loc_cJob)
2528:                     loc_oPagina.txt_4c_Job.Value  = ""
2529:                     loc_oPagina.txt_4c_DJob.Value = ""
2530:                     loc_oPagina.txt_4c_Job.SetFocus()
2531:                 ENDIF
2532:                 IF USED("cursor_4c_Job")
2533:                     USE IN cursor_4c_Job
2534:                 ENDIF
2535:             ENDIF
2536:         CATCH TO loc_oErro
2537:             MsgErro("Erro ao validar Job: " + loc_oErro.Message, "Erro")
2538:         ENDTRY
2539:     ENDPROC

*-- Linhas 2556 a 2574:
2556: 
2557:         TRY
2558:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND !EOF("cursor_4c_Dados")
2559:                 SELECT cursor_4c_Dados
2560:                 *-- A visibilidade do Anexa depende de tabelas de outros modulos
2561:                 *-- Simplificado: sempre ocultar (sem acesso a SigCdPgr/SigMvCab/SigCqChm)
2562:                 loc_lMostraAnexa = .F.
2563:             ENDIF
2564:         CATCH TO loc_oErro
2565:             *-- Nao mostrar erro em AfterRowColChange (pode disparar frequentemente)
2566:             loc_lMostraAnexa = .F.
2567:         ENDTRY
2568: 
2569:         loc_oPagina.cmd_4c_Anexa.Visible    = loc_lMostraAnexa
2570:         loc_oPagina.shp_4c_ShpAnexa.Visible = loc_lMostraAnexa
2571:     ENDPROC
2572: 
2573:     *==========================================================================
2574:     * UTILITARIOS


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
                    " empdopncs, empdopnums, dopotps," + ;
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

