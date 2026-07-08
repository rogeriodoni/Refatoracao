# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, CHKSUBN, CIDQUERYS, OPECANCS, TIPOS, I, MOEDAS, GRUCONMOES, VENCS, NFS, DOPCS, TITCANCS, VALPRES, FPAGS, NFLXCAIXA, EMPS, LNNRTIPO, DATAS, VALORS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, CHKSUBN, CIDQUERYS, OPECANCS, TIPOS, I, MOEDAS, GRUCONMOES, VENCS, NFS, DOPCS, TITCANCS, VALPRES, FPAGS, NFLXCAIXA, EMPS, LNNRTIPO, DATAS, VALORS

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreffi.prg) - TRECHOS RELEVANTES PARA PASS SQL (2324 linhas total):

*-- Linhas 435 a 477:
435:                 .HighlightBackColor = RGB(255, 255, 255)
436:                 .HighlightForeColor = RGB(15, 41, 104)
437:                 .HighlightStyle     = 2
438:                 .DeleteMark         = .F.
439:                 .RecordMark         = .F.
440:                 .RowHeight          = 16
441:                 .ScrollBars         = 2
442: 
443:                 .Column1.Width = 25
444:                 .Column2.Width = 65
445:                 .Column3.Width = 251
446: 
447:                 *-- REGRA: AddObject("Check1") ANTES de ControlSource (evita Error 1767)
448:                 .Column1.AddObject("Check1", "CheckBox")
449:                 .Column1.Check1.Caption   = ""
450:                 .Column1.Check1.Value     = 0
451:                 .Column1.Check1.Visible   = .T.
452:                 .Column1.CurrentControl   = "Check1"
453:                 .Column1.Resizable        = .F.
454:                 .Column2.ReadOnly         = .T.
455:                 .Column3.ReadOnly         = .T.
456: 
457:                 *-- ControlSources APOS RecordSource e CurrentControl
458:                 .Column1.ControlSource = "cursor_4c_Emp.ImpEmps"
459:                 .Column2.ControlSource = "cursor_4c_Emp.Cemps"
460:                 .Column3.ControlSource = "cursor_4c_Emp.Razas"
461: 
462:                 *-- Headers SEMPRE APOS ControlSource
463:                 .Column1.Header1.Caption = ""
464:                 .Column2.Header1.Caption = ""
465:                 .Column3.Header1.Caption = ""
466: 
467:                 .Visible = .T.
468:             ENDWITH
469: 
470:             *-- Botao Marcar Empresas (original: top=169, left=720, w=40, h=40)
471:             par_oPag.AddObject("cmd_4c_MarcarEmp", "CommandButton")
472:             WITH par_oPag.cmd_4c_MarcarEmp
473:                 .Top           = 84
474:                 .Left          = 720
475:                 .Width         = 40
476:                 .Height        = 40
477:                 .Caption       = "Sel"

*-- Linhas 557 a 595:
557:                 .HighlightBackColor = RGB(255, 255, 255)
558:                 .HighlightForeColor = RGB(15, 41, 104)
559:                 .HighlightStyle     = 2
560:                 .DeleteMark         = .F.
561:                 .RecordMark         = .F.
562:                 .RowHeight          = 16
563:                 .ScrollBars         = 2
564: 
565:                 .Column1.Width = 25
566:                 .Column2.Width = 75
567:                 .Column3.Width = 96
568: 
569:                 .Column1.AddObject("Check1", "CheckBox")
570:                 .Column1.Check1.Caption   = ""
571:                 .Column1.Check1.Value     = 0
572:                 .Column1.Check1.Visible   = .T.
573:                 .Column1.CurrentControl   = "Check1"
574:                 .Column1.Resizable        = .F.
575:                 .Column2.ReadOnly         = .T.
576:                 .Column3.ReadOnly         = .T.
577: 
578:                 .Column1.ControlSource = "cursor_4c_Disp.ImpDisps"
579:                 .Column2.ControlSource = "cursor_4c_Disp.Grupos"
580:                 .Column3.ControlSource = "cursor_4c_Disp.Contas"
581: 
582:                 .Column1.Header1.Caption = ""
583:                 .Column2.Header1.Caption = ""
584:                 .Column3.Header1.Caption = ""
585: 
586:                 .Visible = .T.
587:             ENDWITH
588: 
589:             *-- Botao Marcar Disponibilidades (original: top=416, left=256, w=40, h=40)
590:             par_oPag.AddObject("cmd_4c_MarcarDisp", "CommandButton")
591:             WITH par_oPag.cmd_4c_MarcarDisp
592:                 .Top           = 331
593:                 .Left          = 256
594:                 .Width         = 40
595:                 .Height        = 40

*-- Linhas 676 a 714:
676:                 .HighlightBackColor = RGB(255, 255, 255)
677:                 .HighlightForeColor = RGB(15, 41, 104)
678:                 .HighlightStyle     = 2
679:                 .DeleteMark         = .F.
680:                 .RecordMark         = .F.
681:                 .RowHeight          = 16
682:                 .ScrollBars         = 2
683: 
684:                 .Column1.Width = 25
685:                 .Column2.Width = 65
686:                 .Column3.Width = 187
687: 
688:                 .Column1.AddObject("Check1", "CheckBox")
689:                 .Column1.Check1.Caption   = ""
690:                 .Column1.Check1.Value     = 0
691:                 .Column1.Check1.Visible   = .T.
692:                 .Column1.CurrentControl   = "Check1"
693:                 .Column1.Resizable        = .F.
694:                 .Column2.ReadOnly         = .T.
695:                 .Column3.ReadOnly         = .T.
696: 
697:                 .Column1.ControlSource = "cursor_4c_Oper.SeleOp"
698:                 .Column2.ControlSource = "cursor_4c_Oper.Dopes"
699:                 .Column3.ControlSource = "cursor_4c_Oper.Opers"
700: 
701:                 .Column1.Header1.Caption = ""
702:                 .Column2.Header1.Caption = ""
703:                 .Column3.Header1.Caption = ""
704: 
705:                 .Visible = .T.
706:             ENDWITH
707: 
708:             *-- Botao Marcar Operacoes (original: top=363, left=659, w=40, h=40)
709:             par_oPag.AddObject("cmd_4c_MarcarOpe", "CommandButton")
710:             WITH par_oPag.cmd_4c_MarcarOpe
711:                 .Top           = 278
712:                 .Left          = 659
713:                 .Width         = 40
714:                 .Height        = 40

*-- Linhas 894 a 912:
894:             loc_cCursorRel = THIS.this_oRelatorio.this_cCursorRelatorio
895:             IF USED(loc_cCursorRel)
896:                 loc_cArquivo = gc_4c_CaminhoBase + "FluxoFinanceiroAnalitico.xls"
897:                 SELECT (loc_cCursorRel)
898:                 COPY TO (loc_cArquivo) TYPE XLS
899:                 MsgInfo("Arquivo exportado com sucesso:" + CHR(13) + loc_cArquivo, "Excel")
900:             ELSE
901:                 MsgAviso("Nenhum dado para exportar.", "Excel")
902:             ENDIF
903:         CATCH TO loc_oErro
904:             MsgErro(loc_oErro.Message, "BtnExcelClick")
905:         ENDTRY
906:     ENDPROC
907: 
908:     *--------------------------------------------------------------------------
909:     * BtnIncluirClick - Acao CRUD nao aplicavel em formulario de relatorio
910:     *   Mantido pela interface padrao; redireciona ao usuario para gerar relatorio.
911:     *--------------------------------------------------------------------------
912:     PROCEDURE BtnIncluirClick()

*-- Linhas 1856 a 1874:
1856:             ENDIF
1857:             IF loc_oForm.this_lSelecionou
1858:                 IF USED("cursor_4c_BuscaMoe")
1859:                     SELECT cursor_4c_BuscaMoe
1860:                     GO TOP
1861:                     IF !EOF()
1862:                         par_oPag.txt_4c__cd_moeda.Value    = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
1863:                         par_oPag.txt_4c__ds_moeda.Value    = ALLTRIM(cursor_4c_BuscaMoe.DMoes)
1864:                         par_oPag.txt_4c__ds_moeda.ReadOnly = .T.
1865:                     ENDIF
1866:                 ENDIF
1867:             ELSE
1868:                 par_oPag.txt_4c__cd_moeda.Value    = ""
1869:                 par_oPag.txt_4c__ds_moeda.Value    = ""
1870:                 par_oPag.txt_4c__ds_moeda.ReadOnly = .F.
1871:             ENDIF
1872:             IF USED("cursor_4c_BuscaMoe")
1873:                 USE IN cursor_4c_BuscaMoe
1874:             ENDIF

*-- Linhas 1911 a 1929:
1911:             ENDIF
1912:             IF loc_oForm.this_lSelecionou
1913:                 IF USED("cursor_4c_BuscaMoeD")
1914:                     SELECT cursor_4c_BuscaMoeD
1915:                     GO TOP
1916:                     IF !EOF()
1917:                         par_oPag.txt_4c__cd_moeda.Value    = ALLTRIM(cursor_4c_BuscaMoeD.CMoes)
1918:                         par_oPag.txt_4c__ds_moeda.Value    = ALLTRIM(cursor_4c_BuscaMoeD.DMoes)
1919:                         par_oPag.txt_4c__ds_moeda.ReadOnly = .T.
1920:                     ENDIF
1921:                 ENDIF
1922:             ELSE
1923:                 par_oPag.txt_4c__cd_moeda.Value = ""
1924:                 par_oPag.txt_4c__ds_moeda.Value = ""
1925:             ENDIF
1926:             IF USED("cursor_4c_BuscaMoeD")
1927:                 USE IN cursor_4c_BuscaMoeD
1928:             ENDIF
1929:             loc_oForm.Release()

*-- Linhas 1965 a 1983:
1965:             ENDIF
1966:             IF loc_oForm.this_lSelecionou
1967:                 IF USED("cursor_4c_BuscaMoeC")
1968:                     SELECT cursor_4c_BuscaMoeC
1969:                     GO TOP
1970:                     IF !EOF()
1971:                         par_oPag.txt_4c_MoeConv.Value      = ALLTRIM(cursor_4c_BuscaMoeC.CMoes)
1972:                         par_oPag.txt_4c_DMoeConv.Value     = ALLTRIM(cursor_4c_BuscaMoeC.DMoes)
1973:                         par_oPag.txt_4c_DMoeConv.ReadOnly  = .T.
1974:                     ENDIF
1975:                 ENDIF
1976:             ELSE
1977:                 par_oPag.txt_4c_MoeConv.Value      = ""
1978:                 par_oPag.txt_4c_DMoeConv.Value     = ""
1979:                 par_oPag.txt_4c_DMoeConv.ReadOnly  = .F.
1980:             ENDIF
1981:             IF USED("cursor_4c_BuscaMoeC")
1982:                 USE IN cursor_4c_BuscaMoeC
1983:             ENDIF

*-- Linhas 2020 a 2038:
2020:             ENDIF
2021:             IF loc_oForm.this_lSelecionou
2022:                 IF USED("cursor_4c_BuscaMoeCD")
2023:                     SELECT cursor_4c_BuscaMoeCD
2024:                     GO TOP
2025:                     IF !EOF()
2026:                         par_oPag.txt_4c_MoeConv.Value      = ALLTRIM(cursor_4c_BuscaMoeCD.CMoes)
2027:                         par_oPag.txt_4c_DMoeConv.Value     = ALLTRIM(cursor_4c_BuscaMoeCD.DMoes)
2028:                         par_oPag.txt_4c_DMoeConv.ReadOnly  = .T.
2029:                     ENDIF
2030:                 ENDIF
2031:             ELSE
2032:                 par_oPag.txt_4c_MoeConv.Value  = ""
2033:                 par_oPag.txt_4c_DMoeConv.Value = ""
2034:             ENDIF
2035:             IF USED("cursor_4c_BuscaMoeCD")
2036:                 USE IN cursor_4c_BuscaMoeCD
2037:             ENDIF
2038:             loc_oForm.Release()

*-- Linhas 2275 a 2324:
2275:                     loc_oGrd.ColumnCount = 3
2276:                     loc_oGrd.RecordSource = "cursor_4c_Emp"
2277:                 ENDIF
2278:                 loc_oGrd.Column1.ControlSource  = "cursor_4c_Emp.ImpEmps"
2279:                 loc_oGrd.Column2.ControlSource  = "cursor_4c_Emp.Cemps"
2280:                 loc_oGrd.Column3.ControlSource  = "cursor_4c_Emp.Razas"
2281:                 loc_oGrd.Column1.Header1.Caption = ""
2282:                 loc_oGrd.Column2.Header1.Caption = ""
2283:                 loc_oGrd.Column3.Header1.Caption = ""
2284:                 loc_oGrd.Refresh()
2285:             ENDIF
2286: 
2287:             *-- Atualizar grid de disponibilidades
2288:             IF VARTYPE(loc_oPag.grd_4c_Disps) = "O"
2289:                 loc_oGrd = loc_oPag.grd_4c_Disps
2290:                 IF USED("cursor_4c_Disp")
2291:                     loc_oGrd.ColumnCount = 3
2292:                     loc_oGrd.RecordSource = "cursor_4c_Disp"
2293:                 ENDIF
2294:                 loc_oGrd.Column1.ControlSource  = "cursor_4c_Disp.ImpDisps"
2295:                 loc_oGrd.Column2.ControlSource  = "cursor_4c_Disp.Grupos"
2296:                 loc_oGrd.Column3.ControlSource  = "cursor_4c_Disp.Contas"
2297:                 loc_oGrd.Column1.Header1.Caption = ""
2298:                 loc_oGrd.Column2.Header1.Caption = ""
2299:                 loc_oGrd.Column3.Header1.Caption = ""
2300:                 loc_oGrd.Refresh()
2301:             ENDIF
2302: 
2303:             *-- Atualizar grid de operacoes de titulos
2304:             IF VARTYPE(loc_oPag.grd_4c_Oper) = "O"
2305:                 loc_oGrd = loc_oPag.grd_4c_Oper
2306:                 IF USED("cursor_4c_Oper")
2307:                     loc_oGrd.ColumnCount = 3
2308:                     loc_oGrd.RecordSource = "cursor_4c_Oper"
2309:                 ENDIF
2310:                 loc_oGrd.Column1.ControlSource  = "cursor_4c_Oper.SeleOp"
2311:                 loc_oGrd.Column2.ControlSource  = "cursor_4c_Oper.Dopes"
2312:                 loc_oGrd.Column3.ControlSource  = "cursor_4c_Oper.Opers"
2313:                 loc_oGrd.Column1.Header1.Caption = ""
2314:                 loc_oGrd.Column2.Header1.Caption = ""
2315:                 loc_oGrd.Column3.Header1.Caption = ""
2316:                 loc_oGrd.Refresh()
2317:             ENDIF
2318: 
2319:         CATCH TO loc_oErro
2320:             MsgErro(loc_oErro.Message, "CarregarLista")
2321:         ENDTRY
2322:     ENDPROC
2323: 
2324: ENDDEFINE

