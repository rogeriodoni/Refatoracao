# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna '2' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNTIPOIMP, MOEDAS, GRUCONMOES, SALDOS, VENCS, TITCANCS, VALPRES, DOPCS, CIDQUERYS, FPAGS, NFLXCAIXA, CHKSUBN, REALPREVS, I, LNIDX, FASE, OPECANCS, TIPOS, CREXCEL
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DATAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNTIPOIMP, MOEDAS, GRUCONMOES, SALDOS, VENCS, TITCANCS, VALPRES, DOPCS, CIDQUERYS, FPAGS, NFLXCAIXA, CHKSUBN, REALPREVS, I, LNIDX, FASE, OPECANCS, TIPOS, CREXCEL

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
  DeleteMark = .F.
  SelectedForeColor = 255,255,255
  ControlSource = ""
  DeleteMark = .F.
  DeleteMark = .F.
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
Insert Into csCabecalho (nm_empresa, nm_titulo, nm_periodo, cb_empresa, cb_moeda, cb_moe_ref, ConsidAtra) ;
			INSERT INTO crPeriodos Values(ThisForm.GoDayOfWeek(ldDtAux,7))
			INSERT INTO crPeriodos Values(ldDtAux)
		INSERT INTO crPeriodos Values(ldDtFinal)
Select crSigOpOpe
	loBarra.Update(.T.)
		lcQuery = [Insert Into SigTempR (Dopes, ValPres, cIdQuerys, cIdChaves) ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - SigTempR)')
lcQuery = [Select a.Grupos, a.Contas, a.Moedas, b.cContabs ] + ;
		    [From SigMvSlc a Inner Join SigCdCli b on b.iClis = a.Contas ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigMvSlc') < 1)
Select a.Grupos, a.Contas, 000000000.00 as Saldos, a.Moedas, 1 as Fase, cContabs, ;
  From crSigMvSlc a, cDisp b ;
Select csTemporario
	lcQuery = [Select Top 1 Nfs, SaldoCs, Saldos, cIdChaves ] + ;
				[From SigMvCcr ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigMvCcr') < 1)
	Select crSigMvCcr
Select csTemporario
Delete From csTemporario Where Saldos = 0
Select csTemporario
	oProg.Update( .t. )
	Insert Into csRelatorio From MemVar
oTotal.Update(.t.)
	lcQuery = [Select a.Grupos, a.Emps, a.DopCs, a.Opers, a.Moedas, a.Valors, a.ValPags, a.Nfs ] + ;
				[From SigMvCcr a, SigTempR b ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigMvCcr') < 1)
	Select csRelatorio
	Select crSigMvCcr
		oProg.Update( .t. )
		If (Seek(Emps, 'cEmp', 'CEmps') And cEmp.ImpEmps) And ;
		   (Dopcs = Space(20) Or (Seek(Dopcs, 'crSigOpOpe', 'Dopes') And crSigOpOpe.SeleOp)) And ;
			   Seek(crSigMvCcr.Grupos, 'crSigCdPag', 'Grupos') And ;
			   Seek(crSigMvCcr.Grupos, 'crSigCdRec', 'Grupos') And ;
	lcQuery = [Select b.cMoes, c.MoedaPs, b.Opers, b.DigItens, a.Emps, a.Dopes, a.Numes, ] + ;
				[e.nFlxCaixa from SigMvCab a inner join SigCdOpe b ] + ;
				[on b.Dopes = a.Dopes inner join SigCdPam c on 1 = 1 inner join SigMvPar d on d.EmpDopNums = a.EmpDopNums ] + ;
				[inner join SigCdTom e on e.Codigos = b.TipoOps ]+;
				[left join SigOpFpo o on o.Dopes = d.Dopes and o.fPags = d.fPags ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigMvCab') < 1)
	Select crSigMvCab
		oProg.Update(.t.)
		If (Seek(m.Emps, 'cEmp', 'CEmps') And cEmp.ImpEmps)
	oTotal.Update(.t.)
lcQuery = [Select a.Vencs, a.Emps, a.Dopcs, a.Grupos, a.Contas, a.Opers, a.Moedas, a.Valors, a.ValPags, a.Nfs, a.cIdChaves ] + ;
		    [From SigMvCcr a, SigTempR b ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crDados1') < 1)
lcQuery = [Select a.Vencs, a.Emps, a.Dopcs, a.Grupos, a.Contas, a.Opers, a.Moedas, a.Valors, a.ValPags, a.Nfs, a.cIdChaves ] + ;
		    [From SigMvCcr a ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crDados2') < 1)
Select * from crDados1 ;
Select * from crDados2 ;
Select crSigMvCcr
	oProg.Update( .t. )
	If (Seek(Emps, 'cEmp', 'CEmps') And cEmp.ImpEmps) And ;
	   (Dopcs = Space(20) Or (Seek(Dopcs, 'crSigOpOpe', 'Dopes') And crSigOpOpe.SeleOp)) And ;
		Insert Into csTemporariox (Vencs, Grupos, Contas, Opers, Moedas, Valors, Tipo) ;
oTotal.Update(.t.)
lcQuery = [Select b.cMoes, c.MoedaPs, d.Vencs, b.Opers, b.DigItens, a.grupoos, a.contaos, a.Numes, ] + ;
			[a.ValInis, a.Vars, e.nFlxCaixa from SigMvCab a inner join SigCdOpe b ] + ;
			[on b.Dopes = a.Dopes inner join SigCdPam c on 1 = 1 inner join SigMvPar d on d.EmpDopNums = a.EmpDopNums ] + ;
			[inner join SigCdTom e on e.Codigos = b.TipoOps ]+;
			[left join SigOpFpo o on o.Dopes = d.Dopes and o.fPags = d.fPags ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigMvCab') < 1)
Select crSigMvCab
	oProg.Update(.t.)
	If (Seek(m.Emps, 'cEmp', 'CEmps') And cEmp.ImpEmps) and (m.Valors > 0)
		Insert Into csTemporariox (Vencs, Grupos, Contas, Opers, Moedas, Valors, Tipo) ;
oTotal.Update(.t.)
	lcQuery = [Select a.Vencs, a.Emps, a.Dopcs, a.Grupos, a.Contas, a.Opers, a.Moedas, a.Valors, a.ValPags, a.Nfs, a.cIdChaves ] + ;
			    [From SigMvCpv a, SigTempR b ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crDados1') < 1)
	lcQuery = [Select a.Vencs, a.Emps, a.Dopcs, a.Grupos, a.Contas, a.Opers, a.Moedas, a.Valors, a.ValPags, a.Nfs, a.cIdChaves ] + ;
			    [From SigMvCpv a ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crDados2') < 1)
	Select * from crDados1 ;
	Select * from crDados2 ;
	Select crSigMvCpv
		oProg.Update(.t.)
		If (Seek(Emps, 'cEmp', 'CEmps') And cEmp.ImpEmps) And ;
		   (Dopcs = Space(20) Or (Seek(Dopcs, 'crSigOpOpe', 'Dopes') And crSigOpOpe.SeleOp)) And ;
			Insert Into csTemporariox (Vencs, Grupos, Contas, Opers, Moedas, Valors, Tipo) ;
oTotal.Update(.t.)
	Select Vencs, Grupos, Opers, Moedas, Tipo, Sum(Valors) as Valors ;
	  From csTemporariox ;
	Select csTemporario
		oProg.Update( .t. )
			Insert Into csRelatorio (Vencs, Pags, Recs, do_Dia, Acumulado, Saldo, Fase, PrevPags, PrevRecs) ;
			   Seek(csTemporario.Grupos, 'crSigCdPag', 'Grupos') And ;
			   Seek(csTemporario.Grupos, 'crSigCdRec', 'Grupos') And ;
				 Not Empty(csTemporario.Grupos) And Seek(csTemporario.Grupos, 'crSigCdPag', 'Grupos')
				   Seek(csTemporario.Grupos, 'crSigCdRec', 'Grupos') And ;
	oTotal.Update(.t.)
		Insert Into csRelatorio(Vencs, Pags, Recs, do_Dia, Acumulado, Saldo, Fase, PrevPags, PrevRecs) ;
		SELECT * FROM csRelatorio WHERE Fase = 2 AND NOT EMPTY(Vencs) INTO CURSOR crAux
		SELECT crAux
	Select Vencs, Max(Grupos) as Grupos, Contas, Opers, Moedas, Sum(Valors) as Valors ;
	  From csTemporariox ;
	Select Max(Vencs) as Vencs, Grupos, Contas, Opers, Max(Moedas) as Moedas, Sum(Valors) as Valors ;
	  From csTemporario ;
		oProg.Update(.t.)
		   Seek(csTemporariox.Grupos, 'crSigCdPag', 'Grupos') And ;
		   Seek(csTemporariox.Grupos, 'crSigCdRec', 'Grupos') And ;
		Insert Into csRelatorio(Contas, Pags, Recs, Saldo, Fase, DsContas) ;
	SELECT crRel
	Select csRelatorio
	Select .f. as SeleOp, Dopes, RealPrevs, Opers ;
	  From TmpSigOpOpe ;
	Select crSigOpOpe
	Select .f. as ImpEmps, Cemps, Razas ;
	  From TmpSigCdEmp ;
	Select cEmp
	If Seek(_Empr, 'cEmp', 'Cemps')
	Select .t. as ImpDisps, Grupos, Contas ;
	  From TmpSigCdDis Where Tipos in (0,1) ;
	Select cDisp
	Select crSigCdPag
	Select crSigCdRec
	Select crSigCdMoe
	Select crSigCdCot
		.Column1.ControlSource = 'cEmp.ImpEmps'
		.Column2.ControlSource = 'cEmp.Cemps'
		.Column3.ControlSource = 'cEmp.Razas'
		.Column1.ControlSource = 'cDisp.ImpDisps'
		.Column2.ControlSource = 'cDisp.Grupos'
		.Column3.ControlSource = 'cDisp.Contas'
		.Column1.ControlSource = 'crSigOpOpe.SeleOp'
		.Column2.ControlSource = 'crSigOpOpe.Dopes'
	SELECT ' ' as Titulo, dData1 as Coluna1, dData2 as Coluna2, dData3 as Coluna3, dData4 as Coluna4,;
		   FROM crRel ;
	SELECT 'Saldo no início da '+Tipo as Titulo, STR(nSaldoIni1,12,2) as Coluna1, STR(nSaldoIni2,12,2) as Coluna2, STR(nSaldoIni3,12,2) as Coluna3, STR(nSaldoIni4,12,2) as Coluna4,;
		   FROM crRel ;
	SELECT 'Recebimentos estimados' as Titulo, STR(nRecEst1,12,2) as Coluna1, STR(nRecEst2,12,2) as Coluna2, STR(nRecEst3,12,2) as Coluna3, STR(nRecEst4,12,2) as Coluna4,;
		   FROM crRel ; 
	SELECT 'Recebimentos confirmados' as Titulo, STR(nRecConf1,12,2) as Coluna1, STR(nRecConf2,12,2) as Coluna2, STR(nRecConf3,12,2) as Coluna3, STR(nRecConf4,12,2) as Coluna4,;
		   FROM crRel ;
	SELECT ' ' as Titulo, STR((nRecEst1+nRecConf1),12,2) as Coluna1, STR((nRecEst2+nRecConf2),12,2) as Coluna2, STR((nRecEst3+nRecConf3),12,2) as Coluna3, STR((nRecEst4+nRecConf4),12,2) as Coluna4,;
		   FROM crRel ; 
	SELECT 'Pagamentos estimados' as Titulo, STR(nPagEst1,12,2) as Coluna1, STR(nPagEst2,12,2) as Coluna2, STR(nPagEst3,12,2) as Coluna3, STR(nPagEst4,12,2) as Coluna4,;
		   FROM crRel ; 
	SELECT 'Pagamentos confirmados' as Titulo, STR(nPagConf1,12,2) as Coluna1, STR(nPagConf2,12,2) as Coluna2, STR(nPagConf3,12,2) as Coluna3, STR(nPagConf4,12,2) as Coluna4,;
		   FROM crRel ;
	SELECT ' ' as Titulo, STR((nPagEst1+nPagConf1),12,2) as Coluna1, STR((nPagEst2+nPagConf2),12,2) as Coluna2, STR((nPagEst3+nPagConf3),12,2) as Coluna3, STR((nPagEst4+nPagConf4),12,2) as Coluna4,;
		   FROM crRel ;
	SELECT 'Saldo no final da '+Tipo as Titulo, STR(nSaldoFin1,12,2) as Coluna1, STR(nSaldoFin2,12,2) as Coluna2, STR(nSaldoFin3,12,2) as Coluna3, STR(nSaldoFin4,12,2) as Coluna4,;
		   FROM crRel ;
Update crSigOpOpe Set SeleOp = .f.
Update crSigOpOpe Set SeleOp = .t.
Select crSigOpOpe
	Select crSigOpOpe
Update cEmp Set ImpEmps = .f.
Update cEmp Set ImpEmps = .t.
Select cEmp
	Select cEmp
Select cDisp
	Select cDisp
Update cDisp Set ImpDisps = .f.
Update cDisp Set ImpDisps = .t.

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreffn.prg) - TRECHOS RELEVANTES PARA PASS SQL (2109 linhas total):

*-- Linhas 379 a 397:
379:                 .HighlightStyle     = 2
380:                 .AllowHeaderSizing  = .F.
381:                 .AllowRowSizing     = .F.
382:                 .DeleteMark         = .F.
383:                 .RecordMark         = .F.
384:                 .HeaderHeight       = 0
385:                 .ScrollBars         = 2
386:                 .RowHeight          = 16
387: 
388:                 .Column1.Width = 15
389:                 .Column2.Width = 30
390:                 .Column3.Width = 289
391: 
392:                 .Column1.AddObject("Check1", "CheckBox")
393:                 .Column1.Check1.Caption   = ""
394:                 .Column1.Check1.Value     = 0
395:                 .Column1.Check1.Visible   = .T.
396:                 .Column1.CurrentControl   = "Check1"
397:                 .Column1.Resizable        = .F.

*-- Linhas 403 a 423:
403:                 .Column3.Movable          = .F.
404:                 .Column3.Resizable        = .F.
405: 
406:                 .Column1.ControlSource = "cEmp.ImpEmps"
407:                 .Column2.ControlSource = "cEmp.Cemps"
408:                 .Column3.ControlSource = "cEmp.Razas"
409: 
410:                 .Column1.Header1.Caption = ""
411:                 .Column2.Header1.Caption = ""
412:                 .Column3.Header1.Caption = ""
413: 
414:                 .Visible = .T.
415:             ENDWITH
416: 
417:             *-- Botao Marcar Empresas (original: top=239, left=669)
418:             par_oPag.AddObject("cmd_4c_MarcarEmp", "CommandButton")
419:             WITH par_oPag.cmd_4c_MarcarEmp
420:                 .Top           = 239
421:                 .Left          = 669
422:                 .Width         = 40
423:                 .Height        = 40

*-- Linhas 507 a 525:
507:                 .HighlightStyle     = 2
508:                 .AllowHeaderSizing  = .F.
509:                 .AllowRowSizing     = .F.
510:                 .DeleteMark         = .F.
511:                 .RecordMark         = .F.
512:                 .HeaderHeight       = 0
513:                 .ScrollBars         = 2
514:                 .RowHeight          = 16
515: 
516:                 .Column1.Width = 15
517:                 .Column2.Width = 79
518:                 .Column3.Width = 79
519: 
520:                 .Column1.AddObject("Check1", "CheckBox")
521:                 .Column1.Check1.Caption   = ""
522:                 .Column1.Check1.Value     = 0
523:                 .Column1.Check1.Visible   = .T.
524:                 .Column1.CurrentControl   = "Check1"
525:                 .Column1.Resizable        = .F.

*-- Linhas 531 a 551:
531:                 .Column3.Movable          = .F.
532:                 .Column3.Resizable        = .F.
533: 
534:                 .Column1.ControlSource = "cDisp.ImpDisps"
535:                 .Column2.ControlSource = "cDisp.Grupos"
536:                 .Column3.ControlSource = "cDisp.Contas"
537: 
538:                 .Column1.Header1.Caption = ""
539:                 .Column2.Header1.Caption = ""
540:                 .Column3.Header1.Caption = ""
541: 
542:                 .Visible = .T.
543:             ENDWITH
544: 
545:             *-- Botao Marcar Disponibilidades (original: top=448, left=275)
546:             par_oPag.AddObject("cmd_4c_MarcarDisp", "CommandButton")
547:             WITH par_oPag.cmd_4c_MarcarDisp
548:                 .Top           = 448
549:                 .Left          = 275
550:                 .Width         = 40
551:                 .Height        = 40

*-- Linhas 635 a 675:
635:                 .HighlightStyle     = 2
636:                 .AllowHeaderSizing  = .F.
637:                 .AllowRowSizing     = .F.
638:                 .DeleteMark         = .F.
639:                 .RecordMark         = .F.
640:                 .HeaderHeight       = 0
641:                 .ScrollBars         = 2
642:                 .RowHeight          = 16
643: 
644:                 .Column1.Width = 15
645:                 .Column2.Width = 220
646: 
647:                 .Column1.AddObject("Check1", "CheckBox")
648:                 .Column1.Check1.Caption   = ""
649:                 .Column1.Check1.Value     = 0
650:                 .Column1.Check1.Visible   = .T.
651:                 .Column1.CurrentControl   = "Check1"
652:                 .Column1.Resizable        = .F.
653:                 .Column1.Sparse           = .F.
654:                 .Column2.ReadOnly         = .T.
655:                 .Column2.Movable          = .F.
656:                 .Column2.Resizable        = .F.
657:                 .Column2.BackColor        = RGB(255, 255, 255)
658: 
659:                 .Column1.ControlSource = "crSigOpOpe.SeleOp"
660:                 .Column2.ControlSource = "crSigOpOpe.Dopes"
661: 
662:                 .Column1.Header1.Caption = ""
663:                 .Column2.Header1.Caption = ""
664: 
665:                 .Visible = .T.
666:             ENDWITH
667: 
668:             *-- Botao Marcar Operacoes (original: top=446, left=642)
669:             par_oPag.AddObject("cmd_4c_MarcarOpe", "CommandButton")
670:             WITH par_oPag.cmd_4c_MarcarOpe
671:                 .Top           = 446
672:                 .Left          = 642
673:                 .Width         = 40
674:                 .Height        = 40
675:                 .Caption       = "Sel"

*-- Linhas 1723 a 1741:
1723:             ENDIF
1724:             IF loc_oForm.this_lSelecionou
1725:                 IF USED("cursor_4c_BuscaMoe")
1726:                     SELECT cursor_4c_BuscaMoe
1727:                     GO TOP
1728:                     IF !EOF()
1729:                         par_oPag.txt_4c__cd_moeda.Value    = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
1730:                         par_oPag.txt_4c__ds_moeda.Value    = ALLTRIM(cursor_4c_BuscaMoe.DMoes)
1731:                         par_oPag.txt_4c__ds_moeda.ReadOnly = .T.
1732:                         *-- Atualiza cotacao automaticamente
1733:                         IF VARTYPE(THIS.this_oRelatorio) = "O"
1734:                             par_oPag.txt_4c_cotacao.Value = ;
1735:                                 THIS.this_oRelatorio.BuscarCotacaoAtual( ;
1736:                                     ALLTRIM(cursor_4c_BuscaMoe.CMoes))
1737:                         ENDIF
1738:                     ENDIF
1739:                 ENDIF
1740:             ELSE
1741:                 par_oPag.txt_4c__cd_moeda.Value    = ""

*-- Linhas 1784 a 1802:
1784:             ENDIF
1785:             IF loc_oForm.this_lSelecionou
1786:                 IF USED("cursor_4c_BuscaMoeD")
1787:                     SELECT cursor_4c_BuscaMoeD
1788:                     GO TOP
1789:                     IF !EOF()
1790:                         par_oPag.txt_4c__cd_moeda.Value    = ALLTRIM(cursor_4c_BuscaMoeD.CMoes)
1791:                         par_oPag.txt_4c__ds_moeda.Value    = ALLTRIM(cursor_4c_BuscaMoeD.DMoes)
1792:                         par_oPag.txt_4c__ds_moeda.ReadOnly = .T.
1793:                         IF VARTYPE(THIS.this_oRelatorio) = "O"
1794:                             par_oPag.txt_4c_cotacao.Value = ;
1795:                                 THIS.this_oRelatorio.BuscarCotacaoAtual( ;
1796:                                     ALLTRIM(cursor_4c_BuscaMoeD.CMoes))
1797:                         ENDIF
1798:                     ENDIF
1799:                 ENDIF
1800:             ELSE
1801:                 par_oPag.txt_4c__cd_moeda.Value = ""
1802:                 par_oPag.txt_4c__ds_moeda.Value = ""

*-- Linhas 1843 a 1861:
1843:             ENDIF
1844:             IF loc_oForm.this_lSelecionou
1845:                 IF USED("cursor_4c_BuscaMoeL")
1846:                     SELECT cursor_4c_BuscaMoeL
1847:                     GO TOP
1848:                     IF !EOF()
1849:                         par_oPag.txt_4c_cd_moedl.Value    = ALLTRIM(cursor_4c_BuscaMoeL.CMoes)
1850:                         par_oPag.txt_4c_ds_moedl.Value    = ALLTRIM(cursor_4c_BuscaMoeL.DMoes)
1851:                         par_oPag.txt_4c_ds_moedl.ReadOnly = .T.
1852:                     ENDIF
1853:                 ENDIF
1854:             ELSE
1855:                 par_oPag.txt_4c_cd_moedl.Value    = ""
1856:                 par_oPag.txt_4c_ds_moedl.Value    = ""
1857:                 par_oPag.txt_4c_ds_moedl.ReadOnly = .F.
1858:             ENDIF
1859:             IF USED("cursor_4c_BuscaMoeL")
1860:                 USE IN cursor_4c_BuscaMoeL
1861:             ENDIF

*-- Linhas 1896 a 1914:
1896:             ENDIF
1897:             IF loc_oForm.this_lSelecionou
1898:                 IF USED("cursor_4c_BuscaMoeLD")
1899:                     SELECT cursor_4c_BuscaMoeLD
1900:                     GO TOP
1901:                     IF !EOF()
1902:                         par_oPag.txt_4c_cd_moedl.Value    = ALLTRIM(cursor_4c_BuscaMoeLD.CMoes)
1903:                         par_oPag.txt_4c_ds_moedl.Value    = ALLTRIM(cursor_4c_BuscaMoeLD.DMoes)
1904:                         par_oPag.txt_4c_ds_moedl.ReadOnly = .T.
1905:                     ENDIF
1906:                 ENDIF
1907:             ELSE
1908:                 par_oPag.txt_4c_cd_moedl.Value = ""
1909:                 par_oPag.txt_4c_ds_moedl.Value = ""
1910:             ENDIF
1911:             IF USED("cursor_4c_BuscaMoeLD")
1912:                 USE IN cursor_4c_BuscaMoeLD
1913:             ENDIF
1914:             loc_oForm.Release()

