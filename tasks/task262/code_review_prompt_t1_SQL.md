# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (11)
- [SQL-ASPAS] Linha 495: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: loc_lcWhere = loc_lcWhere + " And Ifors = '" + loc_lcIfors + "'"
- [SQL-ASPAS] Linha 619: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: loc_lcQuery = "SELECT * FROM SigPrCpo WHERE CPros = '" + loc_pPro + "'"
- [SQL-ASPAS] Linha 740: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: loc_lcSql = "SELECT * FROM SigPrCpo WHERE Cpros = '" + loc_pPro + "'"
- [SQL-ASPAS] Linha 1024: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "Select * From SigPrFti Where Cods = '" + loc_MarkCus + "'", "TmpFtio")
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNCONTA, SITUAS, IFORS, FORALINHA, MARGEMS, ENCARGOS, CFTIOCS, 1, CGRUS, CPROS, CIDCHAVES, MATPRINCS, CODS, ACRESCS, VALORS, LNTPRECAL, ORDEM, ARREDCS, TPCALCPS, INATIVAS, PVARIAS, LMARCA, NFAIXAFINS, TIPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNCONTA, SITUAS, IFORS, FORALINHA, MARGEMS, ENCARGOS, CFTIOCS, 1, CGRUS, CPROS, CIDCHAVES, MATPRINCS, CODS, ACRESCS, VALORS, LNTPRECAL, ORDEM, ARREDCS, TPCALCPS, INATIVAS, PVARIAS, LMARCA, NFAIXAFINS, TIPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNCONTA, SITUAS, IFORS, FORALINHA, MARGEMS, ENCARGOS, CFTIOCS, 1, CGRUS, CPROS, CIDCHAVES, MATPRINCS, CODS, ACRESCS, VALORS, LNTPRECAL, ORDEM, ARREDCS, TPCALCPS, INATIVAS, PVARIAS, LMARCA, NFAIXAFINS, TIPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CUNIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNCONTA, SITUAS, IFORS, FORALINHA, MARGEMS, ENCARGOS, CFTIOCS, 1, CGRUS, CPROS, CIDCHAVES, MATPRINCS, CODS, ACRESCS, VALORS, LNTPRECAL, ORDEM, ARREDCS, TPCALCPS, INATIVAS, PVARIAS, LMARCA, NFAIXAFINS, TIPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'LINHAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNCONTA, SITUAS, IFORS, FORALINHA, MARGEMS, ENCARGOS, CFTIOCS, 1, CGRUS, CPROS, CIDCHAVES, MATPRINCS, CODS, ACRESCS, VALORS, LNTPRECAL, ORDEM, ARREDCS, TPCALCPS, INATIVAS, PVARIAS, LMARCA, NFAIXAFINS, TIPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'COLECOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNCONTA, SITUAS, IFORS, FORALINHA, MARGEMS, ENCARGOS, CFTIOCS, 1, CGRUS, CPROS, CIDCHAVES, MATPRINCS, CODS, ACRESCS, VALORS, LNTPRECAL, ORDEM, ARREDCS, TPCALCPS, INATIVAS, PVARIAS, LMARCA, NFAIXAFINS, TIPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNCONTA, SITUAS, IFORS, FORALINHA, MARGEMS, ENCARGOS, CFTIOCS, 1, CGRUS, CPROS, CIDCHAVES, MATPRINCS, CODS, ACRESCS, VALORS, LNTPRECAL, ORDEM, ARREDCS, TPCALCPS, INATIVAS, PVARIAS, LMARCA, NFAIXAFINS, TIPOS

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
lcQuery = [Select * From SigCdPro ] + ;
If (Thisform.poDataMgr.SqlExecute(lcQuery, 'CrSigCdPro') < 1)
Select CrSigCdPro
lcQuery = [Select * From SigPrCpo Where 1=0 ]
If (Thisform.poDataMgr.SqlExecute(lcQuery, [TmpPrCpo]) < 1)
Select TmpPrCpo
lcQuery = [Select * From SigPrFti ]
If (Thisform.poDataMgr.SqlExecute(lcQuery, 'CrSigPrFti') < 1)
Select CrSigPrFti
lcQuery = [Select a.*, b.Dgrus From SigPrFto a, SigCdGrp b Where ]+;
If (Thisform.poDataMgr.SqlExecute(lcQuery, 'CrSigPrFtiG') < 1)
Select CrSigPrFtiG
lcQuery = [Select a.*, b.Dpros From SigPrFto a, SigCdPro b Where ]+;
If (Thisform.poDataMgr.SqlExecute(lcQuery, 'CrSigPrFtiP') < 1)
Select CrSigPrFtiP
Select CrSigPrCpo
	Select CrSigCdPro
		loBarra.Update(.T.)
		lcQuery = [Select * From SigPrCpo Where CPros = '] + pPro + [']
		If (Thisform.poDataMgr.SqlExecute(lcQuery, [TmpCompo]) < 1)
		Select TmpCompo
				lcQuery = [Select a.PesoMs, b.CfgGerGprs ] + ;
					[From SigCdPro a, SigCdGrp b ] + ;
				If (Thisform.poDataMgr.SqlExecute(lcQuery, [LocalProCp]) < 1)
							lcQuery = [Update SigPrCpo Set Qtds = ] + Str(lnVal, 9, 3) + [ ] + ;
							If (Thisform.poDataMgr.SqlExecute(lcQuery, []) < 1)
							lcQuery = [Update SigPrCpo Set Pesos = ] + Str(lnVal, 9, 3) + [ ] + ;
							If (Thisform.poDataMgr.SqlExecute(lcQuery, []) < 1)
			Insert Into crProdutos (Cpros, DPros) Values (CrSigCdPro.Cpros, CrSigCdPro.DPros)
	Select CrSigCdPro
		lcSql = [Select * From SigPrCpo Where Cpros = ']+pPro+[']
		If Thisform.poDataMgr.SqlExecute(lcSql,'CrSigPrCpo') < 1
		Select CrSigPrCpo
		Insert Into crProdutos (Cpros, DPros, ValAnt, CustoAfs ) ;
		Select CrSigCdPro
		=Seek(CrSigCdPro.Moecs, 'crSigCdMoe', 'CMoes' )
		=Seek(CrSigCdPro.Moepcs, 'crSigCdMoe', 'CMoes' )
		=Seek(CrSigCdPro.Moedas, 'crSigCdMoe', 'CMoes' )
		=Seek(CrSigCdPro.Cgrus,'CrSigCdGrp','Cgrus')
		Select TotGrupo
		Select CrSigPrCpo
		=Seek(pPro)
			lcQuery = [Select Distinct Matprincs From SigCdPro Where MatPrincs <> Space(14) and MatPrincs = ']+CrSigPrCpo.Mats+[' ]
			If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crMatPrinc') < 1)
			Select crMatPrinc
				lcSql = [Select Custofs, MoeCusfs, Cunis, Cgrus, Moevs, cUniPs, pVens From SigCdPro ]+;
				If Thisform.poDataMgr.SqlExecute(lcSql,'CrCompoPro') < 1
				=Seek(CrSigPrCpo.Cgrus,'CrSigCdGrp','Cgrus')
				Select TotGrupo
					Insert Into TotGrupo (Grupo, Cpros, Moeda) Values (CrSigPrCpo.Cgrus, CrSigPrCpo.Mats, CrSigPrCpo.Moeds)
				=Seek(CrSigPrCpo.Moeds, 'crSigCdMoe', 'CMoes' )
				=Seek(crCompoPro.Moevs, 'crSigCdMoe', 'CMoes' )
					=Seek(CrSigPrCpo.UniCompos,'CrSigCdUni','Cunis')
					=Seek(CrSigPrCpo.Cgrus,'CrSigCdGrp','Cgrus')
						=Seek(CrSigPrCpo.Moeds, 'crSigCdMoe', 'CMoes' )
						=Seek(crCompoPro.Moevs, 'crSigCdMoe', 'CMoes' )
				=Seek(CrSigPrCpo.Moeds, 'crSigCdMoe', 'CMoes' )
				=Seek(CrSigPrCpo.Cgrus,'CrSigCdGrp','Cgrus')
					=Seek(Iif(CrSigCdGrp.BPesos=1,crCompoPro.Cunis,crCompoPro.CUniPs),'CrSigCdUni','Cunis')
					Select CrSigPrCpo
		Select CrSigCdPro
		Select CrSigPrCpo
			Select TmpPrCpo
			Select CrSigPrCpo
		Select Cgrus As Grupo, Mats As Cpros, dCompos As Dgrus, Moeds As Moeda, Pesos, Qtds, PCompos, 00000000.000 As ValGrupo, OrdTs ;
			From CrSigPrCpo ;
		Update LocalTGrupo Set ValGrupo = Iif(CrSigCdGrp.chkInstalas=2, Pesos, Qtds) * PCompos
			lcSql = [Select * From SigPrFti Where Cods = ']+MarkCus+[']
			Thisform.poDataMgr.SqlExecute(lcSql,'TmpFtio')
			Select TmpFtio
				lcSql = [Select a.*, IsNull(b.Dgrus,'') as Dgrus From SigPrFto a Left Join SigCdGrp b on a.Cgrus = b.Cgrus Where a.Cods = ']+MarkCus+[' ]+;
				Thisform.poDataMgr.SqlExecute(lcSql,'TmpFtioC')
					Select LocalTGrupo
						Select TmpFtioC
				lcSql = [Select a.*, b.Dpros From SigPrFto a, SigCdPro b Where a.Cods = ']+MarkCus+[' And ]+;
				Thisform.poDataMgr.SqlExecute(lcSql,'TmpFtioC')
				Select TmpFtioC
		=Seek(MarkVen,'CrSigPrFti','Cods')
				Select CrSigPrFtiG
				Select TotGrupo
					Select CrSigPrFtiG
				Select CrSigPrFtiP
				Select CrSigPrFtiP
		=Seek(CrSigCdPro.Cgrus,'CrSigCdGrp','Cgrus')
		=Seek(CrSigCdPro.Moecs, 'crSigCdMoe', 'CMoes' )
		=Seek(CrSigCdPro.Moepcs, 'crSigCdMoe', 'CMoes' )
		=Seek(CrSigCdPro.Moevs, 'crSigCdMoe', 'CMoes' )
		=Seek(CrSigCdPro.MoeCusfs, 'crSigCdMoe', 'CMoes' )
		=Seek(CrSigCdPro.Moedas, 'crSigCdMoe', 'CMoes' )
		=Seek(CrSigCdPro.mFtios, 'crSigCdMoe', 'CMoes' )
		=Seek(cFtioV,'CrSigPrFti','Cods')
		Select CrSigCdPro
			Select CrSigCdPro
		Select crProdutos
		loBarra.Update(.T.)
lnOldSel = Select()
Select CrProdutos
lcQuery = [Select * From SigCdCcp Where Inativas <> 1]
If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crSigCdCcp') < 1)
Select crSigCdCcp
	Select CrProdutos
	Select crSigCdCcp
		Select CrProdutos
			Delete For PVarias < lnVaria
			Delete For PVarias > lnVaria
	Select crSigCdCcp
Select(lnOldSel)
	Select * From CrProdutos Where lMarca = 1 Order By CPros Into Cursor CsProdutos ReadWrite
	Select CsProdutos
	Select CsProdutos
		loBarra.Update(.T.,'Produto: ' + CsProdutos.CPros)
		If Seek(CsProdutos.CPros,'CrSigCdPro','CPros')
			Select CrSigCdPro
			Insert Into GrSigCdPro From Memvar
			lcSql = [Select * From SigCdPro Where Cpros = ']+m.cpros+[']
			If ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpPro2') < 1
			Select TmpPro2
			Insert Into CrSigCdPrc From MemVar
			If ThisForm.poDataMgr.SqlExecute([Select * From SigPrCpo Where CPros = ']+m.CPros+[' ],'TmpCompo') < 1
			Select TmpCompo
				Insert Into CrSigPrCp2 From MemVar
			If ThisForm.poDataMgr.SqlExecute([Delete From SigPrPrt Where CPros = '] + m.CPros + [' ], []) < 1
			Select TmpPrCpo
			=Seek(m.cpros)
				Insert Into GrSigPrCpo From Memvar
		Select CsProdutos
		Select grSigCdPro
			lcQrySGru  = [Select * From SigCdPsg Where CGrus = ']+grSigCdPro.cGrus+[' Order By nFaixaFins]
			If (ThisForm.poDatamgr.SqlExecute(lcQrySGru,'csSigCdPsg') < 1)
			Select csSigCdPsg
					Select grSigCdPro
					Select grSigCdPro
	loBarraFim.Update(.T.,'SigCdPro (1/4)...')
	llOk = ThisForm.poDataMgr.Update('grSigCdPro')
		loBarraFim.Update(.T.,'SigCdPrc (2/4)...')
		llOk = ThisForm.poDataMgr.Update('CrSigCdPrc')
		loBarraFim.Update(.T.,'SigPrCp2 (3/4)...')
		llOk = ThisForm.poDataMgr.Update('CrSigPrCp2')
		loBarraFim.Update(.T.,'SigPrCpo (4/4)...')
		llOk = ThisForm.poDataMgr.Update('grSigPrCpo')
		lcSql = [Select * From SigCdMoe ]
		ThisForm.Podatamgr.Sqlexecute(lcSql,'CrSigCdMoe')
		lcSql = [Select * From SigCdCot ]
		ThisForm.Podatamgr.Sqlexecute(lcSql,'CrSigCdCot')
		lcSql = [Select * From SigCdGrp ]
		ThisForm.Podatamgr.Sqlexecute(lcSql,'CrSigCdGrp')
		lcSql = [Select * From SigCdUni ]
		ThisForm.Podatamgr.Sqlexecute(lcSql,'CrSigCdUni')
		Select CrSigCdGrp
		Select CrSigCdUni
		Select CrSigCdCot
		Select CrSigCdMoe
		Select CrProdutos
			.Column1.ControlSource = 'CrProdutos.lMarca'
			.Column2.ControlSource = 'CrProdutos.CPros'
			.Column3.ControlSource = 'CrProdutos.DPros'
			.Column4.ControlSource = 'CrProdutos.ValAnt'
			.Column5.ControlSource = 'CrProdutos.ValAtu'
			.Column6.ControlSource = 'CrProdutos.pVarias'
			.Column7.ControlSource = 'CrProdutos.CustoAfs'
			.Column8.ControlSource = 'CrProdutos.CustoFs'
			.Column9.ControlSource = 'CrProdutos.cVarias'
Select CrProdutos
lcSql = [Select FigJpgs From SigCdPro Where Cpros = ']+lcCodPro+[']
If ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpPro') < 1
Select TmpPro
	Select CrProdutos
		Select CrProdutos
			Delete For PVarias < lnVaria
			Delete For PVarias > lnVaria
	lcSql = [Select Cods, Descs, Moedas, Acrescs From SigPrFti ]
	ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpFtio')
	Select TmpFtio
	If Not Seek(This.Value,'TmpFtio','Cods')
Select crprodutos
lcSql = [Select a.cpros,a.FigJpgs From SigCdPro a Where a.cpros = ']+lcCodPro+[' ]
ThisForm.Podatamgr.Sqlexecute(lcsql,'CrTmpPro')
		Delete File (lcArquivo)
Update CrProdutos Set lMarca = 1
Update CrProdutos Set lMarca = 0
	lcSql = [Select Cods, Descs, Moedas, Acrescs From SigPrFti ] + lcFiltro
	ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpFtio')
	Select TmpFtio
	If Not Seek(This.Value,'TmpFtio','Cods')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprccp.prg) - TRECHOS RELEVANTES PARA PASS SQL (3021 linhas total):

*-- Linhas 481 a 511:
481:             .MaxLength     = 10
482:             .SpecialEffect = 1
483:             .Format        = "K"
484:             .Value         = ""
485:         ENDWITH
486: 
487:         THIS.AddObject("lbl_4c_ColiAte", "Label")
488:         WITH THIS.lbl_4c_ColiAte
489:             .Top       = 117
490:             .Left      = 627
491:             .FontName  = "Tahoma"
492:             .FontSize  = 8
493:             .BackStyle = 0
494:             .Caption   = "at" + CHR(233)
495:             .ForeColor = RGB(90, 90, 90)
496:         ENDWITH
497: 
498:         THIS.AddObject("txt_4c_Colf", "TextBox")
499:         WITH THIS.txt_4c_Colf
500:             .Top           = 113
501:             .Left          = 649
502:             .Width         = 84
503:             .Height        = 23
504:             .FontName      = "Tahoma"
505:             .FontSize      = 8
506:             .MaxLength     = 10
507:             .SpecialEffect = 1
508:             .Format        = "K"
509:             .Value         = ""
510:         ENDWITH
511: 

*-- Linhas 605 a 635:
605:             .Left          = 649
606:             .Width         = 84
607:             .Height        = 23
608:             .FontName      = "Tahoma"
609:             .FontSize      = 8
610:             .SpecialEffect = 1
611:             .InputMask     = "999.99"
612:             .Format        = "K"
613:             .Value         = 0
614:         ENDWITH
615: 
616:         *-- Subgrupo (esquerda)
617:         THIS.AddObject("lbl_4c_Subgrupo", "Label")
618:         WITH THIS.lbl_4c_Subgrupo
619:             .Top       = 167
620:             .Left      = 88
621:             .Width     = 55
622:             .Height    = 15
623:             .FontName  = "Tahoma"
624:             .FontSize  = 8
625:             .BackStyle = 0
626:             .Caption   = "Subgrupo :"
627:             .ForeColor = RGB(90, 90, 90)
628:         ENDWITH
629: 
630:         THIS.AddObject("txt_4c_SgruI", "TextBox")
631:         WITH THIS.txt_4c_SgruI
632:             .Top           = 163
633:             .Left          = 145
634:             .Width         = 52
635:             .Height        = 23

*-- Linhas 726 a 756:
726:             .Height    = 15
727:             .FontName  = "Tahoma"
728:             .FontSize  = 8
729:             .BackStyle = 0
730:             .Caption   = "Unidade :"
731:             .ForeColor = RGB(90, 90, 90)
732:         ENDWITH
733: 
734:         THIS.AddObject("txt_4c_CUnii", "TextBox")
735:         WITH THIS.txt_4c_CUnii
736:             .Top           = 189
737:             .Left          = 145
738:             .Width         = 31
739:             .Height        = 23
740:             .FontName      = "Tahoma"
741:             .FontSize      = 8
742:             .MaxLength     = 3
743:             .SpecialEffect = 1
744:             .Value         = ""
745:         ENDWITH
746: 
747:         THIS.AddObject("lbl_4c_UnidadeAte", "Label")
748:         WITH THIS.lbl_4c_UnidadeAte
749:             .Top       = 193
750:             .Left      = 179
751:             .FontName  = "Tahoma"
752:             .FontSize  = 8
753:             .BackStyle = 0
754:             .Caption   = "at" + CHR(233)
755:             .ForeColor = RGB(90, 90, 90)
756:         ENDWITH

*-- Linhas 1010 a 1040:
1010:                 .Caption   = "Todos"
1011:                 .WordWrap        = .T.
1012:                 .FontName        = "Comic Sans MS"
1013:                 .FontSize        = 8
1014:                 .Left      = 152
1015:                 .Top       = 2
1016:                 .Width     = 61
1017:                 .Height    = 17
1018:                 .AutoSize  = .F.
1019:                 .ForeColor = RGB(90, 90, 90)
1020:                 .Themes    = .F.
1021:             ENDWITH
1022:         ENDWITH
1023:     ENDPROC
1024: 
1025:     *==========================================================================
1026:     PROTECTED PROCEDURE ConfigurarDados()
1027:     *==========================================================================
1028:         *-- Label secao Dados
1029:         THIS.AddObject("lbl_4c_SecDados", "Label")
1030:         WITH THIS.lbl_4c_SecDados
1031:             .Top       = 270
1032:             .Left      = 12
1033:             .Width     = 52
1034:             .Height    = 21
1035:             .AutoSize  = .T.
1036:             .FontName  = "Tahoma"
1037:             .FontSize  = 12
1038:             .FontBold  = .T.
1039:             .BackStyle = 0
1040:             .Caption   = "Dados"

*-- Linhas 1373 a 1535:
1373:                 .Check1.Caption = ""
1374:                 .Check1.Value   = 0
1375:                 .CurrentControl = "Check1"
1376:                 .ControlSource  = "cursor_4c_Produtos.lMarca"
1377:                 WITH .Header1
1378:                     .Caption   = ""
1379:                     .FontName  = "Tahoma"
1380:                     .FontSize  = 8
1381:                     .Alignment = 2
1382:                     .ForeColor = RGB(36, 84, 155)
1383:                 ENDWITH
1384:             ENDWITH
1385: 
1386:             *-- Column2: CPros
1387:             WITH .Column2
1388:                 .Width         = 108
1389:                 .Movable       = .F.
1390:                 .Resizable     = .F.
1391:                 .FontName      = "Tahoma"
1392:                 .FontSize      = 8
1393:                 .ControlSource = "cursor_4c_Produtos.CPros"
1394:                 WITH .Header1
1395:                     .Caption   = "Produto"
1396:                     .FontName  = "Tahoma"
1397:                     .FontSize  = 8
1398:                     .Alignment = 2
1399:                     .ForeColor = RGB(36, 84, 155)
1400:                 ENDWITH
1401:             ENDWITH
1402: 
1403:             *-- Column3: DPros
1404:             WITH .Column3
1405:                 .Width         = 290
1406:                 .Movable       = .F.
1407:                 .Resizable     = .F.
1408:                 .FontName      = "Tahoma"
1409:                 .FontSize      = 8
1410:                 .ControlSource = "cursor_4c_Produtos.DPros"
1411:                 WITH .Header1
1412:                     .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1413:                     .FontName  = "Tahoma"
1414:                     .FontSize  = 8
1415:                     .Alignment = 2
1416:                     .ForeColor = RGB(36, 84, 155)
1417:                 ENDWITH
1418:             ENDWITH
1419: 
1420:             *-- Column4: ValAnt
1421:             WITH .Column4
1422:                 .Width         = 80
1423:                 .Movable       = .F.
1424:                 .Resizable     = .F.
1425:                 .FontName      = "Tahoma"
1426:                 .FontSize      = 8
1427:                 .InputMask     = "999,999,999.99"
1428:                 .ControlSource = "cursor_4c_Produtos.ValAnt"
1429:                 WITH .Header1
1430:                     .Caption   = "Venda Ant."
1431:                     .FontName  = "Tahoma"
1432:                     .FontSize  = 8
1433:                     .Alignment = 2
1434:                     .ForeColor = RGB(36, 84, 155)
1435:                 ENDWITH
1436:             ENDWITH
1437: 
1438:             *-- Column5: ValAtu
1439:             WITH .Column5
1440:                 .Width         = 80
1441:                 .Movable       = .F.
1442:                 .Resizable     = .F.
1443:                 .FontName      = "Tahoma"
1444:                 .FontSize      = 8
1445:                 .InputMask     = "999,999,999.99"
1446:                 .ControlSource = "cursor_4c_Produtos.ValAtu"
1447:                 WITH .Header1
1448:                     .Caption   = "Venda Atual"
1449:                     .FontName  = "Tahoma"
1450:                     .FontSize  = 8
1451:                     .Alignment = 2
1452:                     .ForeColor = RGB(36, 84, 155)
1453:                 ENDWITH
1454:             ENDWITH
1455: 
1456:             *-- Column6: PVarias (ReadOnly)
1457:             WITH .Column6
1458:                 .Width         = 80
1459:                 .Movable       = .F.
1460:                 .Resizable     = .F.
1461:                 .ReadOnly      = .T.
1462:                 .FontName      = "Tahoma"
1463:                 .FontSize      = 8
1464:                 .InputMask     = "999,999.99"
1465:                 .ControlSource = "cursor_4c_Produtos.PVarias"
1466:                 WITH .Header1
1467:                     .Caption   = "Varia" + CHR(231) + CHR(227) + "o (%)"
1468:                     .FontName  = "Tahoma"
1469:                     .FontSize  = 8
1470:                     .Alignment = 2
1471:                     .ForeColor = RGB(36, 84, 155)
1472:                 ENDWITH
1473:             ENDWITH
1474: 
1475:             *-- Column7: CustoAfs (ReadOnly)
1476:             WITH .Column7
1477:                 .Width         = 80
1478:                 .Movable       = .F.
1479:                 .Resizable     = .F.
1480:                 .ReadOnly      = .T.
1481:                 .FontName      = "Tahoma"
1482:                 .FontSize      = 8
1483:                 .InputMask     = "999,999,999.9999"
1484:                 .ControlSource = "cursor_4c_Produtos.CustoAfs"
1485:                 WITH .Header1
1486:                     .Caption   = "Custo Ant."
1487:                     .FontName  = "Tahoma"
1488:                     .FontSize  = 8
1489:                     .Alignment = 2
1490:                 ENDWITH
1491:             ENDWITH
1492: 
1493:             *-- Column8: CustoFs (ReadOnly)
1494:             WITH .Column8
1495:                 .Width         = 80
1496:                 .Movable       = .F.
1497:                 .Resizable     = .F.
1498:                 .ReadOnly      = .T.
1499:                 .FontName      = "Tahoma"
1500:                 .FontSize      = 8
1501:                 .InputMask     = "999,999,999.9999"
1502:                 .ControlSource = "cursor_4c_Produtos.CustoFs"
1503:                 WITH .Header1
1504:                     .Caption   = "Custo Atual"
1505:                     .FontName  = "Tahoma"
1506:                     .FontSize  = 8
1507:                     .Alignment = 2
1508:                 ENDWITH
1509:             ENDWITH
1510: 
1511:             *-- Column9: CVarias (ReadOnly)
1512:             WITH .Column9
1513:                 .Width         = 80
1514:                 .Movable       = .F.
1515:                 .Resizable     = .F.
1516:                 .ReadOnly      = .T.
1517:                 .FontName      = "Tahoma"
1518:                 .FontSize      = 8
1519:                 .InputMask     = "999,999.99"
1520:                 .ControlSource = "cursor_4c_Produtos.CVarias"
1521:                 WITH .Header1
1522:                     .Caption   = "Varia" + CHR(231) + CHR(227) + "o (%)"
1523:                     .FontName  = "Tahoma"
1524:                     .FontSize  = 8
1525:                     .Alignment = 2
1526:                 ENDWITH
1527:             ENDWITH
1528:         ENDWITH
1529:     ENDPROC
1530: 
1531:     *==========================================================================
1532:     PROCEDURE TornarControlesVisiveis(par_oContainer)
1533:     *==========================================================================
1534:         LOCAL loc_i, loc_oControl
1535:         FOR loc_i = 1 TO par_oContainer.ControlCount

*-- Linhas 1600 a 1618:
1600:         TRY
1601:             *-- Zera cursor de produtos (grid principal)
1602:             IF USED("cursor_4c_Produtos")
1603:                 SELECT cursor_4c_Produtos
1604:                 ZAP
1605:             ENDIF
1606: 
1607:             *-- Limpa filtros (textboxes de sele" + CHR(231) + CHR(227) + "o)
1608:             THIS.txt_4c_CFornecs.Value = ""
1609:             THIS.txt_4c_DFornecs.Value = ""
1610:             THIS.txt_4c_MercI.Value    = ""
1611:             THIS.txt_4c_MercF.Value    = ""
1612:             THIS.txt_4c_CGrui.Value    = ""
1613:             THIS.txt_4c_CGruf.Value    = ""
1614:             THIS.txt_4c_SgruI.Value    = ""
1615:             THIS.txt_4c_SgruF.Value    = ""
1616:             THIS.txt_4c_CUnii.Value    = ""
1617:             THIS.txt_4c_CUnif.Value    = ""
1618:             THIS.txt_4c_Lini.Value     = ""

*-- Linhas 1680 a 1698:
1680:                 CASE loc_nPagina = 2
1681:                     *-- Modo DADOS/GRID: foco no grid apos processamento
1682:                     IF USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
1683:                         SELECT cursor_4c_Produtos
1684:                         SET ORDER TO CPros
1685:                         GO TOP
1686:                         THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
1687:                         THIS.cmd_4c_Imprimir.Enabled          = .T.
1688:                         THIS.grd_4c_Produto.SetFocus()
1689:                     ELSE
1690:                         MsgAviso("Nenhum produto para exibir. Execute o processamento primeiro.")
1691:                         THIS.txt_4c_CFornecs.SetFocus()
1692:                     ENDIF
1693:                 OTHERWISE
1694:                     THIS.ConfigurarPaginaLista()
1695:             ENDCASE
1696: 
1697:             THIS.Refresh()
1698:         CATCH TO loc_oErro

*-- Linhas 1775 a 1793:
1775:                 RETURN
1776:             ENDIF
1777: 
1778:             SELECT cursor_4c_Produtos
1779:             IF EOF() OR EMPTY(cursor_4c_Produtos.CPros)
1780:                 MsgAviso("Selecione um produto no grid para visualizar.", "Aviso")
1781:                 THIS.grd_4c_Produto.SetFocus()
1782:                 RETURN
1783:             ENDIF
1784: 
1785:             *-- Renderiza figura do produto corrente (mesma logica do AfterRowColChange)
1786:             THIS.GrdAfterRowColChange(1)
1787:             THIS.img_4c_Produto.Visible = .T.
1788:             THIS.img_4c_Produto.Refresh()
1789:         CATCH TO loc_oErro
1790:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1791:                     "Erro BtnVisualizarClick")
1792:         ENDTRY
1793:     ENDPROC

*-- Linhas 1807 a 1852:
1807:                 RETURN
1808:             ENDIF
1809: 
1810:             SELECT cursor_4c_Produtos
1811:             COUNT FOR lMarca = 1 TO loc_nMarcados
1812: 
1813:             IF loc_nMarcados > 0
1814:                 IF !MsgConfirma("Remover " + TRANSFORM(loc_nMarcados) + ;
1815:                                 " produto(s) marcado(s) do rec" + CHR(225) + ;
1816:                                 "lculo?", ;
1817:                                 "Confirma" + CHR(231) + CHR(227) + "o")
1818:                     RETURN
1819:                 ENDIF
1820:                 SELECT cursor_4c_Produtos
1821:                 DELETE FOR lMarca = 1
1822:                 PACK
1823:             ELSE
1824:                 IF EOF() OR EMPTY(cursor_4c_Produtos.CPros)
1825:                     MsgAviso("Selecione um produto no grid ou marque na primeira coluna.", ;
1826:                              "Aviso")
1827:                     THIS.grd_4c_Produto.SetFocus()
1828:                     RETURN
1829:                 ENDIF
1830:                 loc_cCodPro = ALLTRIM(cursor_4c_Produtos.CPros)
1831:                 IF !MsgConfirma("Remover o produto " + loc_cCodPro + ;
1832:                                 " do rec" + CHR(225) + "lculo?", ;
1833:                                 "Confirma" + CHR(231) + CHR(227) + "o")
1834:                     RETURN
1835:                 ENDIF
1836:                 SELECT cursor_4c_Produtos
1837:                 DELETE
1838:                 PACK
1839:             ENDIF
1840: 
1841:             *-- Se cursor ficou vazio, desabilita Atualizar/Imprimir
1842:             IF RECCOUNT("cursor_4c_Produtos") = 0
1843:                 THIS.cmg_4c_Botoes.Buttons(2).Enabled = .F.
1844:                 THIS.cmd_4c_Imprimir.Enabled          = .F.
1845:                 THIS.img_4c_Produto.Visible           = .F.
1846:                 THIS.img_4c_Produto.Picture           = ""
1847:             ENDIF
1848: 
1849:             THIS.grd_4c_Produto.Refresh()
1850:         CATCH TO loc_oErro
1851:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1852:                     "Erro BtnExcluirClick")

*-- Linhas 1870 a 1893:
1870: 
1871:             IF THIS.this_oBusinessObject.Processar()
1872:                 loc_nVaria = THIS.txt_4c_Variacao.Value
1873:                 SELECT cursor_4c_Produtos
1874:                 IF loc_nVaria > 0
1875:                     DELETE FOR PVarias < loc_nVaria
1876:                 ENDIF
1877:                 IF loc_nVaria < 0
1878:                     DELETE FOR PVarias > loc_nVaria
1879:                 ENDIF
1880:                 SET ORDER TO CPros
1881:                 GO TOP
1882:                 THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
1883:                 THIS.cmg_4c_Botoes.Buttons(2).Refresh()
1884:                 THIS.cmd_4c_Imprimir.Enabled = .T.
1885:                 THIS.cmd_4c_Imprimir.Refresh()
1886:                 THIS.grd_4c_Produto.Column1.SetFocus()
1887:                 THIS.grd_4c_Produto.Refresh()
1888:                 loc_lSucesso = .T.
1889:             ENDIF
1890:         CATCH TO loc_oErro
1891:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro BtnProcessarClick")
1892:         ENDTRY
1893:         RETURN loc_lSucesso

*-- Linhas 1937 a 1990:
1937:     *==========================================================================
1938:         LOCAL loc_oErro
1939:         TRY
1940:             UPDATE cursor_4c_Produtos SET lMarca = 1
1941:             THIS.grd_4c_Produto.Refresh()
1942:         CATCH TO loc_oErro
1943:             MsgErro(loc_oErro.Message, "Erro BtnSelTudoClick")
1944:         ENDTRY
1945:     ENDPROC
1946: 
1947:     *==========================================================================
1948:     PROCEDURE BtnDesmarcarClick()
1949:     *==========================================================================
1950:         LOCAL loc_oErro
1951:         TRY
1952:             UPDATE cursor_4c_Produtos SET lMarca = 0
1953:             THIS.grd_4c_Produto.Refresh()
1954:         CATCH TO loc_oErro
1955:             MsgErro(loc_oErro.Message, "Erro BtnDesmarcarClick")
1956:         ENDTRY
1957:     ENDPROC
1958: 
1959:     *==========================================================================
1960:     PROCEDURE GrdAfterRowColChange(par_nColIndex)
1961:     *==========================================================================
1962:         LOCAL loc_cArquivo, loc_cCodPro, loc_cSQL, loc_cFoto, loc_oErro
1963:         TRY
1964:             IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
1965:                 RETURN
1966:             ENDIF
1967:             loc_cArquivo = SYS(2023) + "\TempCj.jpg"
1968:             SELECT cursor_4c_Produtos
1969:             loc_cCodPro = ALLTRIM(cursor_4c_Produtos.CPros)
1970:             loc_cSQL    = "SELECT FigJpgs FROM SigCdPro WHERE Cpros = " + EscaparSQL(loc_cCodPro)
1971:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpFig") < 1
1972:                 THIS.img_4c_Produto.Visible = .F.
1973:                 RETURN
1974:             ENDIF
1975:             SELECT cursor_4c_TmpFig
1976:             THIS.img_4c_Produto.Visible  = .F.
1977:             THIS.img_4c_Produto.Picture  = ""
1978:             IF !ISNULL(cursor_4c_TmpFig.FigJpgs) AND !EMPTY(cursor_4c_TmpFig.FigJpgs)
1979:                 loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_TmpFig.FigJpgs, ;
1980:                     "data:image/png;base64,", ""), "data:image/jpeg;base64,", ""), ;
1981:                     "data:image/jpg;base64,", ""), 14)
1982:                 STRTOFILE(loc_cFoto, loc_cArquivo)
1983:                 THIS.img_4c_Produto.Picture = loc_cArquivo
1984:                 THIS.img_4c_Produto.Visible = .T.
1985:             ENDIF
1986:             IF USED("cursor_4c_TmpFig")
1987:                 USE IN cursor_4c_TmpFig
1988:             ENDIF
1989:         CATCH TO loc_oErro
1990:             IF USED("cursor_4c_TmpFig")

*-- Linhas 2006 a 2026:
2006:                 THIS.txt_4c_DFornecs.Value = ""
2007:                 RETURN
2008:             ENDIF
2009:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + ;
2010:                        EscaparSQL(loc_cVal), "cursor_4c_TmpFor") > 0
2011:                 SELECT cursor_4c_TmpFor
2012:                 IF !EOF("cursor_4c_TmpFor")
2013:                     THIS.txt_4c_CFornecs.Value = ALLTRIM(cursor_4c_TmpFor.IClis)
2014:                     THIS.txt_4c_DFornecs.Value = ALLTRIM(cursor_4c_TmpFor.RClis)
2015:                     USE IN cursor_4c_TmpFor
2016:                     RETURN
2017:                 ENDIF
2018:                 USE IN cursor_4c_TmpFor
2019:             ENDIF
2020:             THIS.AbrirBuscaFornecedor()
2021:         CATCH TO loc_oErro
2022:             IF USED("cursor_4c_TmpFor")
2023:                 USE IN cursor_4c_TmpFor
2024:             ENDIF
2025:             MsgErro(loc_oErro.Message, "Erro TxtCFornecKeyPress")
2026:         ENDTRY

*-- Linhas 2068 a 2088:
2068:             IF EMPTY(ALLTRIM(THIS.txt_4c_MercI.Value))
2069:                 RETURN
2070:             ENDIF
2071:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Codigos, Descs FROM SigCdGpr WHERE Codigos = " + ;
2072:                        EscaparSQL(ALLTRIM(THIS.txt_4c_MercI.Value)), "cursor_4c_TmpGGr") > 0
2073:                 SELECT cursor_4c_TmpGGr
2074:                 IF !EOF("cursor_4c_TmpGGr")
2075:                     THIS.txt_4c_MercI.Value = ALLTRIM(cursor_4c_TmpGGr.Codigos)
2076:                     USE IN cursor_4c_TmpGGr
2077:                     RETURN
2078:                 ENDIF
2079:                 USE IN cursor_4c_TmpGGr
2080:             ENDIF
2081:             THIS.AbrirBuscaGrandeGrupo(.T.)
2082:         CATCH TO loc_oErro
2083:             IF USED("cursor_4c_TmpGGr")
2084:                 USE IN cursor_4c_TmpGGr
2085:             ENDIF
2086:             MsgErro(loc_oErro.Message, "Erro TxtMercIKeyPress")
2087:         ENDTRY
2088:     ENDPROC

*-- Linhas 2096 a 2116:
2096:             IF EMPTY(ALLTRIM(THIS.txt_4c_MercF.Value))
2097:                 RETURN
2098:             ENDIF
2099:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Codigos, Descs FROM SigCdGpr WHERE Codigos = " + ;
2100:                        EscaparSQL(ALLTRIM(THIS.txt_4c_MercF.Value)), "cursor_4c_TmpGGr") > 0
2101:                 SELECT cursor_4c_TmpGGr
2102:                 IF !EOF("cursor_4c_TmpGGr")
2103:                     THIS.txt_4c_MercF.Value = ALLTRIM(cursor_4c_TmpGGr.Codigos)
2104:                     USE IN cursor_4c_TmpGGr
2105:                     RETURN
2106:                 ENDIF
2107:                 USE IN cursor_4c_TmpGGr
2108:             ENDIF
2109:             THIS.AbrirBuscaGrandeGrupo(.F.)
2110:         CATCH TO loc_oErro
2111:             IF USED("cursor_4c_TmpGGr")
2112:                 USE IN cursor_4c_TmpGGr
2113:             ENDIF
2114:             MsgErro(loc_oErro.Message, "Erro TxtMercFKeyPress")
2115:         ENDTRY
2116:     ENDPROC

*-- Linhas 2160 a 2180:
2160:             IF EMPTY(ALLTRIM(THIS.txt_4c_CGrui.Value))
2161:                 RETURN
2162:             ENDIF
2163:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CGrus, DGrus FROM SigCdGrp WHERE CGrus = " + ;
2164:                        EscaparSQL(ALLTRIM(THIS.txt_4c_CGrui.Value)), "cursor_4c_TmpGrp") > 0
2165:                 SELECT cursor_4c_TmpGrp
2166:                 IF !EOF("cursor_4c_TmpGrp")
2167:                     THIS.txt_4c_CGrui.Value = ALLTRIM(cursor_4c_TmpGrp.CGrus)
2168:                     USE IN cursor_4c_TmpGrp
2169:                     RETURN
2170:                 ENDIF
2171:                 USE IN cursor_4c_TmpGrp
2172:             ENDIF
2173:             THIS.AbrirBuscaGrupo(.T.)
2174:         CATCH TO loc_oErro
2175:             IF USED("cursor_4c_TmpGrp")
2176:                 USE IN cursor_4c_TmpGrp
2177:             ENDIF
2178:             MsgErro(loc_oErro.Message, "Erro TxtCGruiKeyPress")
2179:         ENDTRY
2180:     ENDPROC

*-- Linhas 2188 a 2208:
2188:             IF EMPTY(ALLTRIM(THIS.txt_4c_CGruf.Value))
2189:                 RETURN
2190:             ENDIF
2191:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CGrus, DGrus FROM SigCdGrp WHERE CGrus = " + ;
2192:                        EscaparSQL(ALLTRIM(THIS.txt_4c_CGruf.Value)), "cursor_4c_TmpGrp") > 0
2193:                 SELECT cursor_4c_TmpGrp
2194:                 IF !EOF("cursor_4c_TmpGrp")
2195:                     THIS.txt_4c_CGruf.Value = ALLTRIM(cursor_4c_TmpGrp.CGrus)
2196:                     USE IN cursor_4c_TmpGrp
2197:                     RETURN
2198:                 ENDIF
2199:                 USE IN cursor_4c_TmpGrp
2200:             ENDIF
2201:             THIS.AbrirBuscaGrupo(.F.)
2202:         CATCH TO loc_oErro
2203:             IF USED("cursor_4c_TmpGrp")
2204:                 USE IN cursor_4c_TmpGrp
2205:             ENDIF
2206:             MsgErro(loc_oErro.Message, "Erro TxtCGrufKeyPress")
2207:         ENDTRY
2208:     ENDPROC

*-- Linhas 2252 a 2272:
2252:             IF EMPTY(ALLTRIM(THIS.txt_4c_SgruI.Value))
2253:                 RETURN
2254:             ENDIF
2255:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Codigos, Descricaos FROM SigCdPsg WHERE Codigos = " + ;
2256:                        EscaparSQL(ALLTRIM(THIS.txt_4c_SgruI.Value)), "cursor_4c_TmpSgr") > 0
2257:                 SELECT cursor_4c_TmpSgr
2258:                 IF !EOF("cursor_4c_TmpSgr")
2259:                     THIS.txt_4c_SgruI.Value = ALLTRIM(cursor_4c_TmpSgr.Codigos)
2260:                     USE IN cursor_4c_TmpSgr
2261:                     RETURN
2262:                 ENDIF
2263:                 USE IN cursor_4c_TmpSgr
2264:             ENDIF
2265:             THIS.AbrirBuscaSubgrupo(.T.)
2266:         CATCH TO loc_oErro
2267:             IF USED("cursor_4c_TmpSgr")
2268:                 USE IN cursor_4c_TmpSgr
2269:             ENDIF
2270:             MsgErro(loc_oErro.Message, "Erro TxtSgruIKeyPress")
2271:         ENDTRY
2272:     ENDPROC

*-- Linhas 2280 a 2300:
2280:             IF EMPTY(ALLTRIM(THIS.txt_4c_SgruF.Value))
2281:                 RETURN
2282:             ENDIF
2283:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Codigos, Descricaos FROM SigCdPsg WHERE Codigos = " + ;
2284:                        EscaparSQL(ALLTRIM(THIS.txt_4c_SgruF.Value)), "cursor_4c_TmpSgr") > 0
2285:                 SELECT cursor_4c_TmpSgr
2286:                 IF !EOF("cursor_4c_TmpSgr")
2287:                     THIS.txt_4c_SgruF.Value = ALLTRIM(cursor_4c_TmpSgr.Codigos)
2288:                     USE IN cursor_4c_TmpSgr
2289:                     RETURN
2290:                 ENDIF
2291:                 USE IN cursor_4c_TmpSgr
2292:             ENDIF
2293:             THIS.AbrirBuscaSubgrupo(.F.)
2294:         CATCH TO loc_oErro
2295:             IF USED("cursor_4c_TmpSgr")
2296:                 USE IN cursor_4c_TmpSgr
2297:             ENDIF
2298:             MsgErro(loc_oErro.Message, "Erro TxtSgruFKeyPress")
2299:         ENDTRY
2300:     ENDPROC

*-- Linhas 2344 a 2364:
2344:             IF EMPTY(ALLTRIM(THIS.txt_4c_CUnii.Value))
2345:                 RETURN
2346:             ENDIF
2347:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CUnis, DUnis FROM SigCdUni WHERE CUnis = " + ;
2348:                        EscaparSQL(ALLTRIM(THIS.txt_4c_CUnii.Value)), "cursor_4c_TmpUni") > 0
2349:                 SELECT cursor_4c_TmpUni
2350:                 IF !EOF("cursor_4c_TmpUni")
2351:                     THIS.txt_4c_CUnii.Value = ALLTRIM(cursor_4c_TmpUni.CUnis)
2352:                     USE IN cursor_4c_TmpUni
2353:                     RETURN
2354:                 ENDIF
2355:                 USE IN cursor_4c_TmpUni
2356:             ENDIF
2357:             THIS.AbrirBuscaUnidade(.T.)
2358:         CATCH TO loc_oErro
2359:             IF USED("cursor_4c_TmpUni")
2360:                 USE IN cursor_4c_TmpUni
2361:             ENDIF
2362:             MsgErro(loc_oErro.Message, "Erro TxtCUniiKeyPress")
2363:         ENDTRY
2364:     ENDPROC

*-- Linhas 2372 a 2392:
2372:             IF EMPTY(ALLTRIM(THIS.txt_4c_CUnif.Value))
2373:                 RETURN
2374:             ENDIF
2375:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CUnis, DUnis FROM SigCdUni WHERE CUnis = " + ;
2376:                        EscaparSQL(ALLTRIM(THIS.txt_4c_CUnif.Value)), "cursor_4c_TmpUni") > 0
2377:                 SELECT cursor_4c_TmpUni
2378:                 IF !EOF("cursor_4c_TmpUni")
2379:                     THIS.txt_4c_CUnif.Value = ALLTRIM(cursor_4c_TmpUni.CUnis)
2380:                     USE IN cursor_4c_TmpUni
2381:                     RETURN
2382:                 ENDIF
2383:                 USE IN cursor_4c_TmpUni
2384:             ENDIF
2385:             THIS.AbrirBuscaUnidade(.F.)
2386:         CATCH TO loc_oErro
2387:             IF USED("cursor_4c_TmpUni")
2388:                 USE IN cursor_4c_TmpUni
2389:             ENDIF
2390:             MsgErro(loc_oErro.Message, "Erro TxtCUnifKeyPress")
2391:         ENDTRY
2392:     ENDPROC

*-- Linhas 2436 a 2456:
2436:             IF EMPTY(ALLTRIM(THIS.txt_4c_Lini.Value))
2437:                 RETURN
2438:             ENDIF
2439:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Linhas, Descs FROM SigCdLin WHERE Linhas = " + ;
2440:                        EscaparSQL(ALLTRIM(THIS.txt_4c_Lini.Value)), "cursor_4c_TmpLin") > 0
2441:                 SELECT cursor_4c_TmpLin
2442:                 IF !EOF("cursor_4c_TmpLin")
2443:                     THIS.txt_4c_Lini.Value = ALLTRIM(cursor_4c_TmpLin.Linhas)
2444:                     USE IN cursor_4c_TmpLin
2445:                     RETURN
2446:                 ENDIF
2447:                 USE IN cursor_4c_TmpLin
2448:             ENDIF
2449:             THIS.AbrirBuscaLinha(.T.)
2450:         CATCH TO loc_oErro
2451:             IF USED("cursor_4c_TmpLin")
2452:                 USE IN cursor_4c_TmpLin
2453:             ENDIF
2454:             MsgErro(loc_oErro.Message, "Erro TxtLiniKeyPress")
2455:         ENDTRY
2456:     ENDPROC

*-- Linhas 2464 a 2484:
2464:             IF EMPTY(ALLTRIM(THIS.txt_4c_Linf.Value))
2465:                 RETURN
2466:             ENDIF
2467:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Linhas, Descs FROM SigCdLin WHERE Linhas = " + ;
2468:                        EscaparSQL(ALLTRIM(THIS.txt_4c_Linf.Value)), "cursor_4c_TmpLin") > 0
2469:                 SELECT cursor_4c_TmpLin
2470:                 IF !EOF("cursor_4c_TmpLin")
2471:                     THIS.txt_4c_Linf.Value = ALLTRIM(cursor_4c_TmpLin.Linhas)
2472:                     USE IN cursor_4c_TmpLin
2473:                     RETURN
2474:                 ENDIF
2475:                 USE IN cursor_4c_TmpLin
2476:             ENDIF
2477:             THIS.AbrirBuscaLinha(.F.)
2478:         CATCH TO loc_oErro
2479:             IF USED("cursor_4c_TmpLin")
2480:                 USE IN cursor_4c_TmpLin
2481:             ENDIF
2482:             MsgErro(loc_oErro.Message, "Erro TxtLinfKeyPress")
2483:         ENDTRY
2484:     ENDPROC

*-- Linhas 2528 a 2548:
2528:             IF EMPTY(ALLTRIM(THIS.txt_4c_Coli.Value))
2529:                 RETURN
2530:             ENDIF
2531:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Colecoes, Descs FROM SigCdCol WHERE Colecoes = " + ;
2532:                        EscaparSQL(ALLTRIM(THIS.txt_4c_Coli.Value)), "cursor_4c_TmpCol") > 0
2533:                 SELECT cursor_4c_TmpCol
2534:                 IF !EOF("cursor_4c_TmpCol")
2535:                     THIS.txt_4c_Coli.Value = ALLTRIM(cursor_4c_TmpCol.Colecoes)
2536:                     USE IN cursor_4c_TmpCol
2537:                     RETURN
2538:                 ENDIF
2539:                 USE IN cursor_4c_TmpCol
2540:             ENDIF
2541:             THIS.AbrirBuscaColecao(.T.)
2542:         CATCH TO loc_oErro
2543:             IF USED("cursor_4c_TmpCol")
2544:                 USE IN cursor_4c_TmpCol
2545:             ENDIF
2546:             MsgErro(loc_oErro.Message, "Erro TxtColiKeyPress")
2547:         ENDTRY
2548:     ENDPROC

*-- Linhas 2556 a 2576:
2556:             IF EMPTY(ALLTRIM(THIS.txt_4c_Colf.Value))
2557:                 RETURN
2558:             ENDIF
2559:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Colecoes, Descs FROM SigCdCol WHERE Colecoes = " + ;
2560:                        EscaparSQL(ALLTRIM(THIS.txt_4c_Colf.Value)), "cursor_4c_TmpCol") > 0
2561:                 SELECT cursor_4c_TmpCol
2562:                 IF !EOF("cursor_4c_TmpCol")
2563:                     THIS.txt_4c_Colf.Value = ALLTRIM(cursor_4c_TmpCol.Colecoes)
2564:                     USE IN cursor_4c_TmpCol
2565:                     RETURN
2566:                 ENDIF
2567:                 USE IN cursor_4c_TmpCol
2568:             ENDIF
2569:             THIS.AbrirBuscaColecao(.F.)
2570:         CATCH TO loc_oErro
2571:             IF USED("cursor_4c_TmpCol")
2572:                 USE IN cursor_4c_TmpCol
2573:             ENDIF
2574:             MsgErro(loc_oErro.Message, "Erro TxtColfKeyPress")
2575:         ENDTRY
2576:     ENDPROC

*-- Linhas 2620 a 2640:
2620:             IF EMPTY(ALLTRIM(THIS.txt_4c_Moedai.Value))
2621:                 RETURN
2622:             ENDIF
2623:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + ;
2624:                        EscaparSQL(ALLTRIM(THIS.txt_4c_Moedai.Value)), "cursor_4c_TmpMoe") > 0
2625:                 SELECT cursor_4c_TmpMoe
2626:                 IF !EOF("cursor_4c_TmpMoe")
2627:                     THIS.txt_4c_Moedai.Value = ALLTRIM(cursor_4c_TmpMoe.CMoes)
2628:                     USE IN cursor_4c_TmpMoe
2629:                     RETURN
2630:                 ENDIF
2631:                 USE IN cursor_4c_TmpMoe
2632:             ENDIF
2633:             THIS.AbrirBuscaMoeda(.T.)
2634:         CATCH TO loc_oErro
2635:             IF USED("cursor_4c_TmpMoe")
2636:                 USE IN cursor_4c_TmpMoe
2637:             ENDIF
2638:             MsgErro(loc_oErro.Message, "Erro TxtMoedaiKeyPress")
2639:         ENDTRY
2640:     ENDPROC

*-- Linhas 2648 a 2668:
2648:             IF EMPTY(ALLTRIM(THIS.txt_4c_Moedaf.Value))
2649:                 RETURN
2650:             ENDIF
2651:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + ;
2652:                        EscaparSQL(ALLTRIM(THIS.txt_4c_Moedaf.Value)), "cursor_4c_TmpMoe") > 0
2653:                 SELECT cursor_4c_TmpMoe
2654:                 IF !EOF("cursor_4c_TmpMoe")
2655:                     THIS.txt_4c_Moedaf.Value = ALLTRIM(cursor_4c_TmpMoe.CMoes)
2656:                     USE IN cursor_4c_TmpMoe
2657:                     RETURN
2658:                 ENDIF
2659:                 USE IN cursor_4c_TmpMoe
2660:             ENDIF
2661:             THIS.AbrirBuscaMoeda(.F.)
2662:         CATCH TO loc_oErro
2663:             IF USED("cursor_4c_TmpMoe")
2664:                 USE IN cursor_4c_TmpMoe
2665:             ENDIF
2666:             MsgErro(loc_oErro.Message, "Erro TxtMoedafKeyPress")
2667:         ENDTRY
2668:     ENDPROC

*-- Linhas 2712 a 2732:
2712:             IF EMPTY(ALLTRIM(THIS.txt_4c_Feitio.Value))
2713:                 RETURN
2714:             ENDIF
2715:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Cods, Descs FROM SigPrFti WHERE Cods = " + ;
2716:                        EscaparSQL(ALLTRIM(THIS.txt_4c_Feitio.Value)), "cursor_4c_TmpFti") > 0
2717:                 SELECT cursor_4c_TmpFti
2718:                 IF !EOF("cursor_4c_TmpFti")
2719:                     THIS.txt_4c_Feitio.Value = ALLTRIM(cursor_4c_TmpFti.Cods)
2720:                     USE IN cursor_4c_TmpFti
2721:                     RETURN
2722:                 ENDIF
2723:                 USE IN cursor_4c_TmpFti
2724:             ENDIF
2725:             THIS.AbrirBuscaFeitio()
2726:         CATCH TO loc_oErro
2727:             IF USED("cursor_4c_TmpFti")
2728:                 USE IN cursor_4c_TmpFti
2729:             ENDIF
2730:             MsgErro(loc_oErro.Message, "Erro TxtFeitioKeyPress")
2731:         ENDTRY
2732:     ENDPROC

*-- Linhas 2772 a 2792:
2772:             IF EMPTY(ALLTRIM(THIS.txt_4c_NewMkp.Value))
2773:                 RETURN
2774:             ENDIF
2775:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Cods, Descs FROM SigPrFti WHERE Cods = " + ;
2776:                        EscaparSQL(ALLTRIM(THIS.txt_4c_NewMkp.Value)) + " AND Tipos = 1", "cursor_4c_TmpNMkp") > 0
2777:                 SELECT cursor_4c_TmpNMkp
2778:                 IF !EOF("cursor_4c_TmpNMkp")
2779:                     THIS.txt_4c_NewMkp.Value = ALLTRIM(cursor_4c_TmpNMkp.Cods)
2780:                     USE IN cursor_4c_TmpNMkp
2781:                     RETURN
2782:                 ENDIF
2783:                 USE IN cursor_4c_TmpNMkp
2784:             ENDIF
2785:             THIS.AbrirBuscaNewMkp()
2786:         CATCH TO loc_oErro
2787:             IF USED("cursor_4c_TmpNMkp")
2788:                 USE IN cursor_4c_TmpNMkp
2789:             ENDIF
2790:             MsgErro(loc_oErro.Message, "Erro TxtNewMkpKeyPress")
2791:         ENDTRY
2792:     ENDPROC

*-- Linhas 2950 a 2979:
2950:         loc_lSucesso = .F.
2951:         TRY
2952:             IF USED("cursor_4c_Produtos")
2953:                 SELECT cursor_4c_Produtos
2954:                 ZAP
2955:             ENDIF
2956:             THIS.FormParaBO()
2957:             IF THIS.this_oBusinessObject.Processar()
2958:                 loc_nVaria = THIS.txt_4c_Variacao.Value
2959:                 SELECT cursor_4c_Produtos
2960:                 IF loc_nVaria > 0
2961:                     DELETE FOR PVarias < loc_nVaria
2962:                 ENDIF
2963:                 IF loc_nVaria < 0
2964:                     DELETE FOR PVarias > loc_nVaria
2965:                 ENDIF
2966:                 SET ORDER TO CPros
2967:                 GO TOP
2968:                 THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
2969:                 THIS.cmd_4c_Imprimir.Enabled          = .T.
2970:                 THIS.grd_4c_Produto.Refresh()
2971:                 loc_lSucesso = .T.
2972:             ENDIF
2973:         CATCH TO loc_oErro
2974:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
2975:                 "Erro CarregarLista")
2976:         ENDTRY
2977:         RETURN loc_lSucesso
2978:     ENDPROC
2979: 

