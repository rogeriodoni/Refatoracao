# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, CHKSUBN, CIDQUERYS, OPECANCS, TIPOS, I, MOEDAS, GRUCONMOES, VENCS, NFS, DOPCS, TITCANCS, VALPRES, FPAGS, NFLXCAIXA, EMPS, LNNRTIPO, DATAS, VALORS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, CHKSUBN, CIDQUERYS, OPECANCS, TIPOS, I, MOEDAS, GRUCONMOES, VENCS, NFS, DOPCS, TITCANCS, VALPRES, FPAGS, NFLXCAIXA, EMPS, LNNRTIPO, DATAS, VALORS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'VALPAGS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, CHKSUBN, CIDQUERYS, OPECANCS, TIPOS, I, MOEDAS, GRUCONMOES, VENCS, NFS, DOPCS, TITCANCS, VALPRES, FPAGS, NFLXCAIXA, EMPS, LNNRTIPO, DATAS, VALORS

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
  DeleteMark = .F.
  DeleteMark = .F.
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
lcQuery = [select a.empdopnums, sum(e.valos) as valos, sum(e.vpags) as vpags from SigMvCab a ] + ;
		  [inner join SigMvItn b on b.empdopnums = a.empdopnums ] + ;
		  [inner join SigCdOpe c on c.dopes = b.dopes ] + ;		  
		  [inner join SigMvPec d on d.codigos = ] + ;
		  [inner join SigMvPar e on e.empdopnums = d.empdopnums ] + ;
If ThisForm.poDataMgr.SqlExecute(lcQuery,[crSldPend]) < 1
lcQryGTmpD = [Select * From SigTempR Where cIdQuerys = '] + pIds + [']
		Select .f. as SeleOp, Dopes, RealPrevs, Opers ;
		  From TempSigOpOpe Where OpeCancs <> 1 ;
		Select crSigOpOpe
		 		Delete In crSigOpOpe
		Select .f. as ImpEmps, Cemps, Razas ;
		  From TempEmp ;
		Select cEmp
		If Seek(_Empr, 'CEmp', 'Cemps')
		Select .t. as ImpDisps, Grupos, Contas ;
		  From TmpSigCdDis Where Tipos in (0,1) ;
		Select cDisp
		Select crSigCdMoe
		Select crSigCdCot
		Select crSigCdRec
			.Column1.ControlSource = 'cEmp.ImpEmps'
			.Column2.ControlSource = 'cEmp.Cemps'
			.Column3.ControlSource = 'cEmp.Razas'
			.Column1.ControlSource = 'cDisp.ImpDisps'
			.Column2.ControlSource = 'cDisp.Grupos'
			.Column3.ControlSource = 'cDisp.Contas'
			.Column1.ControlSource = 'crSigOpOpe.SeleOp'
			.Column2.ControlSource = 'crSigOpOpe.Dopes'
			.Column3.ControlSource = 'crSigOpOpe.Opers'
		lcSql = [Select TitOpcS, TitOpcN, TitOpcA From SigCdPac]
		If ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalParac') < 1
		Select LocalParac
Insert Into csCabecalho (nm_empresa,nm_titulo,nm_periodo,cb_empresa,cb_Moe_Ref,ConsidAtra) ;
Select crSigOpOpe
	loBarra.Update(.T.)
		lcQuery = [Insert Into SigTempR (Dopes, ValPres, cIdQuerys, cIdChaves) ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - SigTempR)')
lcQuery = [Select a.Grupos, a.Contas, a.Moedas, b.cContabs ] + ;
		    [From SigMvSlc a inner join SigCdCli b on b.iclis = a.Contas ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigMvSlc') < 1)
Select a.Grupos, a.Contas, 000000000.00 as Saldos, a.Moedas, 1 as Fase, cContabs, ;
  From crSigMvSlc a, cDisp b ;
Select csTemporario
	lcQuery = [Select Top 1 Nfs, SaldoCs, Saldos, cIdChaves ] + ;
				[From SigMvCcr ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigMvCcr') < 1)
	Select crSigMvCcr
	Select CsTemporario
	If Seek(m.Moedas, 'crSigCdMoe', 'CMoes')
		Insert Into CsRelatorio (Grupos, Contas, Moedas, Saldos, Fase, DsMoedas, Vl_Convertido ) Values ;
	lStrQuery = [Select a.Moedas, a.Vencs, a.Opers, a.Grupos, a.Contas, a.DopCs, a.Valors, a.Hists, a.Hist2s, a.ValPags, ] +;
				[a.Emps, a.NOpers, a.CIdChaves, 0 as nPrevs, a.EmpDopNums, a.EmpDopNcs From SigMvCcr a, SigTempR b ] + ;
	If ThisForm.poDataMgr.SQLExecute(lStrQuery,'crAtrasos1') < 1
	lStrQuery = [Select b.cMoes, c.MoedaPs, d.Vencs, b.Opers, b.aptpfats, b.DigItens, a.grupoos, a.contaos,] + ;
				[a.ValInis,a.Vars,e.nFlxCaixa,a.EmpDopNums from SigMvCab a inner join SigCdOpe b ] + ;
				[on b.Dopes = a.Dopes inner join SigCdPam c on 1 = 1 inner join SigMvPar d on d.EmpDopNums = a.EmpDopNums ] + ;
				[inner join SigCdTom e on e.Codigos = b.TipoOps ]+;
				[left join SigOpFpo o on o.Dopes = d.Dopes and o.fPags = d.fPags ] + ;
	If ThisForm.poDataMgr.SQLExecute(lStrQuery,'crDadosAux') < 1
	Select crDadosAux
			Insert into crAtrasos2 from MemVar	
	Select * from crAtrasos1;
	Select * from crAtrasos2 ;
	Select a.Moedas, Nvl(a.Vencs, Ctot('')) as Vencs, a.Opers, a.Grupos, a.Contas, a.Dopcs, a.Valors, ;
	  From crAtrasos a, cEmp b ;
	Select TmpCcPag
	Select Distinct Contas ;
	  From csTemporario ;
	Select csContas
		loBarra.Update(.T.)
			Insert Into crSigCdCli (IClis, RClis) Values (csContas.Contas, TmpCli.RClis)
	Select csTemporario
	=Seek('', 'csTemporario', 'Chave1s')
		oProg.Update(.t.)
		If Seek(Moedas, 'crSigCdMoe', 'CMoes')
		If Seek(csTemporario.Contas, 'crSigCdCli', 'IClis')
		If ((Seek(m.Grupos, 'TmpCcPag') or (m.nPrevs = 1)) And (m.Opers = 'C') And ((lnNrTipo = 1) or (lnNrTipo = 3))) Or ;
		   ((m.Opers = 'D') And ((lnNrTipo = 2) or (lnNrTipo = 3)) And (Seek(m.Grupos, 'crSigCdRec', 'Grupos') or (m.nPrevs = 1)) )
			Insert Into csRelatorio From Memvar
lStrQuery = [Select a.Moedas,]+Iif(lntpData=1,[a.Vencs],[a.Datas as Vencs])+[,a.Opers,a.Grupos,a.Contas,a.DopCs,]+;
			[From SigMvCcr a,SigTempR b ]+;
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'CrDados1') < 1
lStrQuery = [Select a.Moedas,]+Iif(lntpData=1,[a.Vencs],[a.Datas as Vencs])+[,a.Opers,a.Grupos,a.Contas,a.DopCs,]+;
			[From SigMvCcr a ]+;
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'CrDados3') < 1
	lStrQuery = [Select b.cMoes, c.MoedaPs,] + Iif(lnTpData=1,[d.Vencs],[d.Datas as Vencs])+[, b.Opers, b.ApTpFats, b.DigItens, a.grupoos,a.contaos,] + ;
				[a.ValInis,a.Vars,e.nFlxCaixa,a.EmpDopNums from SigMvCab a inner join SigCdOpe b ] + ;
				[on b.Dopes = a.Dopes inner join SigCdPam c on 1 = 1 inner join SigMvPar d on d.EmpDopNums = a.EmpDopNums ] + ;
				[inner join SigCdTom e on e.Codigos = b.TipoOps ]+;
				[left join SigOpFpo o on o.Dopes = d.Dopes and o.fPags = d.fPags ]+;
	If ThisForm.poDataMgr.SQLExecute(lStrQuery,'crDadosAux') < 1
	Select crDadosAux
			Insert into crDados5 from MemVar	
	lStrQuery = [Select a.Moedas,]+Iif(lntpData=1,[a.Vencs],[a.Datas as Vencs])+[,a.Opers,a.Grupos,a.Contas,a.DopCs,]+;
				[From SigMvCpv a,SigTempR b ]+;
	If ThisForm.poDataMgr.SqlExecute(lStrQuery,'CrDados2') < 1
	lStrQuery = [Select a.Moedas,]+Iif(lntpData=1,[a.Vencs],[a.Datas as Vencs])+[,a.Opers,a.Grupos,a.Contas,a.DopCs,]+;
				[From SigMvCpv a ]+;
	If ThisForm.poDataMgr.SqlExecute(lStrQuery,'CrDados4') < 1
	Select * From CrDados1 ;
	Select * From CrDados3 ;
	Select * From CrDados2 ;
	Select * From CrDados4 ;
	Select * From CrDados5 ;
	Select * From CrDados1 ;
	Select * From CrDados3 ;
	Select * From CrDados5 ;
Select CrDados
Select a.Moedas, Nvl(a.Vencs, Ctot('')) as Vencs, a.Opers, a.Grupos, a.Contas, a.Dopcs, a.Valors, ;
  From crDados a, cEmp b ;
Select TmpCcPag
Select Distinct Contas ;
  From csTemporario ;
Select csContas
	loBarra.Update(.T.)
		Insert Into crSigCdCli (IClis, RClis) Values (csContas.Contas, TmpCli.RClis)
Select csTemporario
=Seek('', 'csTemporario', 'Chave1s')
	oProg.Update(.t.)
	If Seek(Moedas, 'crSigCdMoe', 'CMoes')
	If Seek(csTemporario.Contas, 'crSigCdCli', 'IClis')
	If ((Seek(m.Grupos, 'TmpCcPag') or (m.nPrevs = 1)) And (m.Opers = 'C') And ((lnNrTipo = 1) or (lnNrTipo = 3))) Or ;
	   ((m.Opers = 'D') And ((lnNrTipo = 2) or (lnNrTipo = 3)) And (Seek(m.Grupos, 'crSigCdRec', 'Grupos') or (m.nPrevs = 1)) )
		Insert Into csRelatorio From Memvar
Select csRelatorio
	loBarra.Update(.T.)
Select csRelatorio
Update crSigOpOpe Set SeleOp = .f.
Update crSigOpOpe Set SeleOp = .t.
	Select CrSigOpOpe
Select CrSigOpOpe
Update CEmp Set ImpEmps = .f.
Update CEmp Set ImpEmps = .t.
	Select cEmp
Select cEmp
	Select cDisp
Select cDisp
Update cDisp Set ImpDisps = .f.
Update cDisp Set ImpDisps = .t.

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreffi.prg) - TRECHOS RELEVANTES PARA PASS SQL (2325 linhas total):

*-- Linhas 431 a 478:
431:                 .HighlightBackColor = RGB(255, 255, 255)
432:                 .HighlightForeColor = RGB(15, 41, 104)
433:                 .HighlightStyle     = 2
434:                 .DeleteMark         = .F.
435:                 .RecordMark         = .F.
436:                 .RowHeight          = 16
437:                 .ScrollBars         = 2
438: 
439:                 .Column1.Width = 25
440:                 .Column2.Width = 65
441:                 .Column3.Width = 251
442: 
443:                 *-- REGRA: AddObject("Check1") ANTES de ControlSource (evita Error 1767)
444:                 .Column1.AddObject("Check1", "CheckBox")
445:                 .Column1.Check1.Caption   = ""
446:                 .Column1.Check1.Value     = 0
447:                 .Column1.Check1.Visible   = .T.
448:                 .Column1.CurrentControl   = "Check1"
449:                 .Column1.Resizable        = .F.
450:                 .Column2.ReadOnly         = .T.
451:                 .Column3.ReadOnly         = .T.
452: 
453:                 *-- RecordSource antes de ControlSource (reseta headers automaticamente)
454:                 IF USED("cursor_4c_Emp")
455:                     .RecordSource = "cursor_4c_Emp"
456:                 ENDIF
457: 
458:                 *-- ControlSources APOS RecordSource e CurrentControl
459:                 .Column1.ControlSource = "cursor_4c_Emp.ImpEmps"
460:                 .Column2.ControlSource = "cursor_4c_Emp.Cemps"
461:                 .Column3.ControlSource = "cursor_4c_Emp.Razas"
462: 
463:                 *-- Headers SEMPRE APOS ControlSource
464:                 .Column1.Header1.Caption = ""
465:                 .Column2.Header1.Caption = "C" + CHR(243) + "digo"
466:                 .Column3.Header1.Caption = "Raz" + CHR(227) + "o Social"
467: 
468:                 .Visible = .T.
469:             ENDWITH
470: 
471:             *-- Botao Marcar Empresas (original: top=169, left=720, w=40, h=40)
472:             par_oPag.AddObject("cmd_4c_MarcarEmp", "CommandButton")
473:             WITH par_oPag.cmd_4c_MarcarEmp
474:                 .Top           = 84
475:                 .Left          = 720
476:                 .Width         = 40
477:                 .Height        = 40
478:                 .Caption       = "Sel"

*-- Linhas 554 a 596:
554:                 .HighlightBackColor = RGB(255, 255, 255)
555:                 .HighlightForeColor = RGB(15, 41, 104)
556:                 .HighlightStyle     = 2
557:                 .DeleteMark         = .F.
558:                 .RecordMark         = .F.
559:                 .RowHeight          = 16
560:                 .ScrollBars         = 2
561: 
562:                 .Column1.Width = 25
563:                 .Column2.Width = 75
564:                 .Column3.Width = 96
565: 
566:                 .Column1.AddObject("Check1", "CheckBox")
567:                 .Column1.Check1.Caption   = ""
568:                 .Column1.Check1.Value     = 0
569:                 .Column1.Check1.Visible   = .T.
570:                 .Column1.CurrentControl   = "Check1"
571:                 .Column1.Resizable        = .F.
572:                 .Column2.ReadOnly         = .T.
573:                 .Column3.ReadOnly         = .T.
574: 
575:                 IF USED("cursor_4c_Disp")
576:                     .RecordSource = "cursor_4c_Disp"
577:                 ENDIF
578: 
579:                 .Column1.ControlSource = "cursor_4c_Disp.ImpDisps"
580:                 .Column2.ControlSource = "cursor_4c_Disp.Grupos"
581:                 .Column3.ControlSource = "cursor_4c_Disp.Contas"
582: 
583:                 .Column1.Header1.Caption = ""
584:                 .Column2.Header1.Caption = "Grupo"
585:                 .Column3.Header1.Caption = "Conta"
586: 
587:                 .Visible = .T.
588:             ENDWITH
589: 
590:             *-- Botao Marcar Disponibilidades (original: top=416, left=256, w=40, h=40)
591:             par_oPag.AddObject("cmd_4c_MarcarDisp", "CommandButton")
592:             WITH par_oPag.cmd_4c_MarcarDisp
593:                 .Top           = 331
594:                 .Left          = 256
595:                 .Width         = 40
596:                 .Height        = 40

*-- Linhas 673 a 715:
673:                 .HighlightBackColor = RGB(255, 255, 255)
674:                 .HighlightForeColor = RGB(15, 41, 104)
675:                 .HighlightStyle     = 2
676:                 .DeleteMark         = .F.
677:                 .RecordMark         = .F.
678:                 .RowHeight          = 16
679:                 .ScrollBars         = 2
680: 
681:                 .Column1.Width = 25
682:                 .Column2.Width = 65
683:                 .Column3.Width = 187
684: 
685:                 .Column1.AddObject("Check1", "CheckBox")
686:                 .Column1.Check1.Caption   = ""
687:                 .Column1.Check1.Value     = 0
688:                 .Column1.Check1.Visible   = .T.
689:                 .Column1.CurrentControl   = "Check1"
690:                 .Column1.Resizable        = .F.
691:                 .Column2.ReadOnly         = .T.
692:                 .Column3.ReadOnly         = .T.
693: 
694:                 IF USED("cursor_4c_Oper")
695:                     .RecordSource = "cursor_4c_Oper"
696:                 ENDIF
697: 
698:                 .Column1.ControlSource = "cursor_4c_Oper.SeleOp"
699:                 .Column2.ControlSource = "cursor_4c_Oper.Dopes"
700:                 .Column3.ControlSource = "cursor_4c_Oper.Opers"
701: 
702:                 .Column1.Header1.Caption = ""
703:                 .Column2.Header1.Caption = "C" + CHR(243) + "digo"
704:                 .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
705: 
706:                 .Visible = .T.
707:             ENDWITH
708: 
709:             *-- Botao Marcar Operacoes (original: top=363, left=659, w=40, h=40)
710:             par_oPag.AddObject("cmd_4c_MarcarOpe", "CommandButton")
711:             WITH par_oPag.cmd_4c_MarcarOpe
712:                 .Top           = 278
713:                 .Left          = 659
714:                 .Width         = 40
715:                 .Height        = 40

*-- Linhas 895 a 913:
895:             loc_cCursorRel = THIS.this_oRelatorio.this_cCursorRelatorio
896:             IF USED(loc_cCursorRel)
897:                 loc_cArquivo = gc_4c_CaminhoBase + "FluxoFinanceiroAnalitico.xls"
898:                 SELECT (loc_cCursorRel)
899:                 COPY TO (loc_cArquivo) TYPE XLS
900:                 MsgInfo("Arquivo exportado com sucesso:" + CHR(13) + loc_cArquivo, "Excel")
901:             ELSE
902:                 MsgAviso("Nenhum dado para exportar.", "Excel")
903:             ENDIF
904:         CATCH TO loc_oErro
905:             MsgErro(loc_oErro.Message, "BtnExcelClick")
906:         ENDTRY
907:     ENDPROC
908: 
909:     *--------------------------------------------------------------------------
910:     * BtnIncluirClick - Acao CRUD nao aplicavel em formulario de relatorio
911:     *   Mantido pela interface padrao; redireciona ao usuario para gerar relatorio.
912:     *--------------------------------------------------------------------------
913:     PROCEDURE BtnIncluirClick()

*-- Linhas 1857 a 1875:
1857:             ENDIF
1858:             IF loc_oForm.this_lSelecionou
1859:                 IF USED("cursor_4c_BuscaMoe")
1860:                     SELECT cursor_4c_BuscaMoe
1861:                     GO TOP
1862:                     IF !EOF()
1863:                         par_oPag.txt_4c__cd_moeda.Value    = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
1864:                         par_oPag.txt_4c__ds_moeda.Value    = ALLTRIM(cursor_4c_BuscaMoe.DMoes)
1865:                         par_oPag.txt_4c__ds_moeda.ReadOnly = .T.
1866:                     ENDIF
1867:                 ENDIF
1868:             ELSE
1869:                 par_oPag.txt_4c__cd_moeda.Value    = ""
1870:                 par_oPag.txt_4c__ds_moeda.Value    = ""
1871:                 par_oPag.txt_4c__ds_moeda.ReadOnly = .F.
1872:             ENDIF
1873:             IF USED("cursor_4c_BuscaMoe")
1874:                 USE IN cursor_4c_BuscaMoe
1875:             ENDIF

*-- Linhas 1912 a 1930:
1912:             ENDIF
1913:             IF loc_oForm.this_lSelecionou
1914:                 IF USED("cursor_4c_BuscaMoeD")
1915:                     SELECT cursor_4c_BuscaMoeD
1916:                     GO TOP
1917:                     IF !EOF()
1918:                         par_oPag.txt_4c__cd_moeda.Value    = ALLTRIM(cursor_4c_BuscaMoeD.CMoes)
1919:                         par_oPag.txt_4c__ds_moeda.Value    = ALLTRIM(cursor_4c_BuscaMoeD.DMoes)
1920:                         par_oPag.txt_4c__ds_moeda.ReadOnly = .T.
1921:                     ENDIF
1922:                 ENDIF
1923:             ELSE
1924:                 par_oPag.txt_4c__cd_moeda.Value = ""
1925:                 par_oPag.txt_4c__ds_moeda.Value = ""
1926:             ENDIF
1927:             IF USED("cursor_4c_BuscaMoeD")
1928:                 USE IN cursor_4c_BuscaMoeD
1929:             ENDIF
1930:             loc_oForm.Release()

*-- Linhas 1966 a 1984:
1966:             ENDIF
1967:             IF loc_oForm.this_lSelecionou
1968:                 IF USED("cursor_4c_BuscaMoeC")
1969:                     SELECT cursor_4c_BuscaMoeC
1970:                     GO TOP
1971:                     IF !EOF()
1972:                         par_oPag.txt_4c_MoeConv.Value      = ALLTRIM(cursor_4c_BuscaMoeC.CMoes)
1973:                         par_oPag.txt_4c_DMoeConv.Value     = ALLTRIM(cursor_4c_BuscaMoeC.DMoes)
1974:                         par_oPag.txt_4c_DMoeConv.ReadOnly  = .T.
1975:                     ENDIF
1976:                 ENDIF
1977:             ELSE
1978:                 par_oPag.txt_4c_MoeConv.Value      = ""
1979:                 par_oPag.txt_4c_DMoeConv.Value     = ""
1980:                 par_oPag.txt_4c_DMoeConv.ReadOnly  = .F.
1981:             ENDIF
1982:             IF USED("cursor_4c_BuscaMoeC")
1983:                 USE IN cursor_4c_BuscaMoeC
1984:             ENDIF

*-- Linhas 2021 a 2039:
2021:             ENDIF
2022:             IF loc_oForm.this_lSelecionou
2023:                 IF USED("cursor_4c_BuscaMoeCD")
2024:                     SELECT cursor_4c_BuscaMoeCD
2025:                     GO TOP
2026:                     IF !EOF()
2027:                         par_oPag.txt_4c_MoeConv.Value      = ALLTRIM(cursor_4c_BuscaMoeCD.CMoes)
2028:                         par_oPag.txt_4c_DMoeConv.Value     = ALLTRIM(cursor_4c_BuscaMoeCD.DMoes)
2029:                         par_oPag.txt_4c_DMoeConv.ReadOnly  = .T.
2030:                     ENDIF
2031:                 ENDIF
2032:             ELSE
2033:                 par_oPag.txt_4c_MoeConv.Value  = ""
2034:                 par_oPag.txt_4c_DMoeConv.Value = ""
2035:             ENDIF
2036:             IF USED("cursor_4c_BuscaMoeCD")
2037:                 USE IN cursor_4c_BuscaMoeCD
2038:             ENDIF
2039:             loc_oForm.Release()

*-- Linhas 2276 a 2325:
2276:                     loc_oGrd.ColumnCount = 3
2277:                     loc_oGrd.RecordSource = "cursor_4c_Emp"
2278:                 ENDIF
2279:                 loc_oGrd.Column1.ControlSource  = "cursor_4c_Emp.ImpEmps"
2280:                 loc_oGrd.Column2.ControlSource  = "cursor_4c_Emp.Cemps"
2281:                 loc_oGrd.Column3.ControlSource  = "cursor_4c_Emp.Razas"
2282:                 loc_oGrd.Column1.Header1.Caption = ""
2283:                 loc_oGrd.Column2.Header1.Caption = "C" + CHR(243) + "digo"
2284:                 loc_oGrd.Column3.Header1.Caption = "Raz" + CHR(227) + "o Social"
2285:                 loc_oGrd.Refresh()
2286:             ENDIF
2287: 
2288:             *-- Atualizar grid de disponibilidades
2289:             IF VARTYPE(loc_oPag.grd_4c_Disps) = "O"
2290:                 loc_oGrd = loc_oPag.grd_4c_Disps
2291:                 IF USED("cursor_4c_Disp")
2292:                     loc_oGrd.ColumnCount = 3
2293:                     loc_oGrd.RecordSource = "cursor_4c_Disp"
2294:                 ENDIF
2295:                 loc_oGrd.Column1.ControlSource  = "cursor_4c_Disp.ImpDisps"
2296:                 loc_oGrd.Column2.ControlSource  = "cursor_4c_Disp.Grupos"
2297:                 loc_oGrd.Column3.ControlSource  = "cursor_4c_Disp.Contas"
2298:                 loc_oGrd.Column1.Header1.Caption = ""
2299:                 loc_oGrd.Column2.Header1.Caption = "Grupo"
2300:                 loc_oGrd.Column3.Header1.Caption = "Conta"
2301:                 loc_oGrd.Refresh()
2302:             ENDIF
2303: 
2304:             *-- Atualizar grid de operacoes de titulos
2305:             IF VARTYPE(loc_oPag.grd_4c_Oper) = "O"
2306:                 loc_oGrd = loc_oPag.grd_4c_Oper
2307:                 IF USED("cursor_4c_Oper")
2308:                     loc_oGrd.ColumnCount = 3
2309:                     loc_oGrd.RecordSource = "cursor_4c_Oper"
2310:                 ENDIF
2311:                 loc_oGrd.Column1.ControlSource  = "cursor_4c_Oper.SeleOp"
2312:                 loc_oGrd.Column2.ControlSource  = "cursor_4c_Oper.Dopes"
2313:                 loc_oGrd.Column3.ControlSource  = "cursor_4c_Oper.Opers"
2314:                 loc_oGrd.Column1.Header1.Caption = ""
2315:                 loc_oGrd.Column2.Header1.Caption = "C" + CHR(243) + "digo"
2316:                 loc_oGrd.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2317:                 loc_oGrd.Refresh()
2318:             ENDIF
2319: 
2320:         CATCH TO loc_oErro
2321:             MsgErro(loc_oErro.Message, "CarregarLista")
2322:         ENDTRY
2323:     ENDPROC
2324: 
2325: ENDDEFINE

