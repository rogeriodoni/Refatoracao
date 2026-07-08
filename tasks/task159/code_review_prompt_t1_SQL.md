# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (9)
- [SQL-ASPAS] Linha 341: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: loc_lcWhere = loc_lcWhere + loc_laCampo(loc_nConta) + " <= '" + loc_lcFinal + "'"
- [SQL-ASPAS] Linha 345: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: loc_lcWhere = loc_lcWhere + loc_laCampo(loc_nConta) + " >= '" + loc_lcInicio + "'"
- [SQL-ASPAS] Linha 524: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: loc_cSQL = "SELECT * FROM SigPrCpo WHERE CPros = '" + THIS.this_cPro + "'"
- [SQL-ASPAS] Linha 637: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: loc_cSQL = "SELECT * FROM SigPrCpo WHERE Cpros = '" + THIS.this_cPro + "'"
- [SQL-ASPAS] Linha 926: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: loc_cSQL = "SELECT * FROM SigPrFti WHERE Cods = '" + loc_lcMarkCus + "'"
- [SQL-ASPAS] Linha 936: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "WHERE a.Cods = '" + loc_lcMarkCus + "' " + ;
- [SQL-ASPAS] Linha 985: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "WHERE a.Cods = '" + loc_lcMarkCus + "' " + ;
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'QTDEQS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNCONTA, SITUAS, IFORS, FORALINHA, MARGEMS, ENCARGOS, CFTIOCS, 1, CGRUS, CPROS, CIDCHAVES, MATPRINCS, CODS, ACRESCS, VALORS, LNTPRECAL, ORDEM, ARREDCS, TPCALCPS, INATIVAS, PVARIAS, LMARCA, NFAIXAFINS, TIPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNCONTA, SITUAS, IFORS, FORALINHA, MARGEMS, ENCARGOS, CFTIOCS, 1, CGRUS, CPROS, CIDCHAVES, MATPRINCS, CODS, ACRESCS, VALORS, LNTPRECAL, ORDEM, ARREDCS, TPCALCPS, INATIVAS, PVARIAS, LMARCA, NFAIXAFINS, TIPOS

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprccp.prg) - TRECHOS RELEVANTES PARA PASS SQL (2623 linhas total):

*-- Linhas 327 a 361:
327:             .ForeColor     = RGB(0,0,0)
328:             .Visible       = .T.
329:         ENDWITH
330: 
331:         *-- ----------------------------------------------------------------
332:         *-- ROW 4: Subgrupo (Top=163)
333:         *-- ----------------------------------------------------------------
334:         THIS.AddObject("lbl_4c_SGruI", "Label")
335:         WITH THIS.lbl_4c_SGruI
336:             .FontName  = "Tahoma"
337:             .FontSize  = 8
338:             .BackStyle = 0
339:             .Caption   = "Subgrupo :"
340:             .Height    = 15
341:             .Left      = 88
342:             .Top       = 167
343:             .AutoSize  = .T.
344:             .ForeColor = RGB(90,90,90)
345:             .Visible   = .T.
346:         ENDWITH
347: 
348:         THIS.AddObject("txt_4c_SGruI", "TextBox")
349:         WITH THIS.txt_4c_SGruI
350:             .BorderStyle   = 1
351:             .Height        = 23
352:             .Left          = 145
353:             .MaxLength     = 6
354:             .SpecialEffect = 1
355:             .Top           = 163
356:             .Width         = 52
357:             .ForeColor     = RGB(0,0,0)
358:             .Visible       = .T.
359:         ENDWITH
360: 
361:         THIS.AddObject("lbl_4c_AteSGruI", "Label")

*-- Linhas 510 a 540:
510:             .Top       = 92
511:             .AutoSize  = .T.
512:             .ForeColor = RGB(90,90,90)
513:             .Visible   = .T.
514:         ENDWITH
515: 
516:         THIS.AddObject("txt_4c_LinhI", "TextBox")
517:         WITH THIS.txt_4c_LinhI
518:             .BorderStyle   = 1
519:             .Format        = "K"
520:             .Height        = 23
521:             .Left          = 539
522:             .MaxLength     = 10
523:             .SpecialEffect = 1
524:             .Top           = 88
525:             .Width         = 84
526:             .ForeColor     = RGB(0,0,0)
527:             .Visible       = .T.
528:         ENDWITH
529: 
530:         THIS.AddObject("lbl_4c_AteLinhI", "Label")
531:         WITH THIS.lbl_4c_AteLinhI
532:             .FontName  = "Tahoma"
533:             .FontSize  = 8
534:             .BackStyle = 0
535:             .Caption   = "at" + CHR(233)
536:             .Left      = 627
537:             .Top       = 92
538:             .AutoSize  = .T.
539:             .ForeColor = RGB(90,90,90)
540:             .Visible   = .T.

*-- Linhas 623 a 653:
623:             .AutoSize  = .T.
624:             .ForeColor = RGB(90,90,90)
625:             .Visible   = .T.
626:         ENDWITH
627: 
628:         THIS.AddObject("txt_4c_MrkI", "TextBox")
629:         WITH THIS.txt_4c_MrkI
630:             .Alignment     = 3
631:             .BorderStyle   = 1
632:             .Value         = 0
633:             .Format        = "K"
634:             .Height        = 23
635:             .InputMask     = "999.99"
636:             .Left          = 539
637:             .MaxLength     = 0
638:             .SpecialEffect = 1
639:             .Top           = 138
640:             .Width         = 84
641:             .ForeColor     = RGB(0,0,0)
642:             .Visible       = .T.
643:         ENDWITH
644: 
645:         THIS.AddObject("lbl_4c_AteMrkI", "Label")
646:         WITH THIS.lbl_4c_AteMrkI
647:             .FontName  = "Tahoma"
648:             .FontSize  = 8
649:             .BackStyle = 0
650:             .Caption   = "at" + CHR(233)
651:             .Left      = 627
652:             .Top       = 142
653:             .AutoSize  = .T.

*-- Linhas 912 a 952:
912:             .Buttons(3).Themes      = .F.
913:         ENDWITH
914:     ENDPROC
915: 
916:     *==========================================================================
917:     PROTECTED PROCEDURE ConfigurarPaginaDados
918:     *==========================================================================
919:         *-- Linha separadora
920:         THIS.AddObject("lin_4c_Sep", "Line")
921:         WITH THIS.lin_4c_Sep
922:             .Height = 0
923:             .Left   = 13
924:             .Top    = 258
925:             .Width  = 738
926:             .Visible= .T.
927:         ENDWITH
928: 
929:         *-- Label "Dados" (titulo secao)
930:         THIS.AddObject("lbl_4c_SecDados", "Label")
931:         WITH THIS.lbl_4c_SecDados
932:             .FontBold  = .T.
933:             .FontName  = "Tahoma"
934:             .FontSize  = 12
935:             .BackStyle = 0
936:             .Caption   = "Dados"
937:             .Height    = 21
938:             .Left      = 12
939:             .Top       = 270
940:             .AutoSize  = .T.
941:             .ForeColor = RGB(90,90,90)
942:             .Visible   = .T.
943:         ENDWITH
944: 
945:         *-- Label "Recalcula :" e OptionGroup Recalc (8 opcoes)
946:         THIS.AddObject("lbl_4c_Recalcula", "Label")
947:         WITH THIS.lbl_4c_Recalcula
948:             .FontName  = "Tahoma"
949:             .FontSize  = 8
950:             .BackStyle = 0
951:             .Caption   = "Recalcula :"
952:             .Left      = 89

*-- Linhas 971 a 1001:
971:             .Buttons(1).FontSize    = 8
972:             .Buttons(1).Caption     = "\<Composi" + CHR(231) + CHR(227) + "o"
973:             .Buttons(1).Left        = 5
974:             .Buttons(1).Top         = 5
975:             .Buttons(1).AutoSize    = .T.
976:             .Buttons(1).ForeColor   = RGB(90,90,90)
977:             .Buttons(1).Themes      = .F.
978:             .Buttons(2).FontName    = "Tahoma"
979:             .Buttons(2).FontSize    = 8
980:             .Buttons(2).Caption     = "Custo \<Venda"
981:             .Buttons(2).Left        = 98
982:             .Buttons(2).Top         = 5
983:             .Buttons(2).AutoSize    = .T.
984:             .Buttons(2).ForeColor   = RGB(90,90,90)
985:             .Buttons(2).Themes      = .F.
986:             .Buttons(3).FontName    = "Tahoma"
987:             .Buttons(3).FontSize    = 8
988:             .Buttons(3).Caption     = "\<Ambos"
989:             .Buttons(3).Height      = 15
990:             .Buttons(3).Left        = 213
991:             .Buttons(3).Top         = 5
992:             .Buttons(3).Width       = 50
993:             .Buttons(3).AutoSize    = .T.
994:             .Buttons(3).ForeColor   = RGB(90,90,90)
995:             .Buttons(3).Themes      = .F.
996:             .Buttons(4).FontName    = "Tahoma"
997:             .Buttons(4).FontSize    = 8
998:             .Buttons(4).Caption     = "Peso Componentes"
999:             .Buttons(4).Height      = 15
1000:             .Buttons(4).Left        = 312
1001:             .Buttons(4).Top         = 4

*-- Linhas 1237 a 1403:
1237:             .Width         = 935
1238:             .RecordSource  = "cursor_4c_Dados"
1239:             .RecordMark    = .F.
1240:             .DeleteMark    = .F.
1241:             .Visible       = .T.
1242: 
1243:             *-- Column1: Checkbox (lMarca)
1244:             .Column1.Alignment     = 3
1245:             .Column1.Width         = 17
1246:             .Column1.Movable       = .F.
1247:             .Column1.Resizable     = .F.
1248:             .Column1.Sparse        = .F.
1249:             .Column1.Header1.Caption   = ""
1250:             .Column1.Header1.Alignment = 2
1251:             .Column1.Header1.ForeColor = RGB(36,84,155)
1252:             .Column1.RemoveObject("Text1")
1253:             .Column1.AddObject("chk_4c_Marca", "CheckBox")
1254:             WITH .Column1.chk_4c_Marca
1255:                 .Caption = ""
1256:                 .Width   = 17
1257:                 .Height  = 17
1258:                 .Value   = 0
1259:                 .Visible = .T.
1260:             ENDWITH
1261:             .Column1.CurrentControl = "chk_4c_Marca"
1262:             .Column1.ControlSource  = "cursor_4c_Dados.lMarca"
1263: 
1264:             *-- Column2: CPros (Produto)
1265:             .Column2.FontName      = "Tahoma"
1266:             .Column2.FontSize      = 8
1267:             .Column2.Width         = 108
1268:             .Column2.Movable       = .F.
1269:             .Column2.Resizable     = .F.
1270:             .Column2.ControlSource = "cursor_4c_Dados.CPros"
1271:             .Column2.Header1.Caption   = "Produto"
1272:             .Column2.Header1.Alignment = 2
1273:             .Column2.Header1.ForeColor = RGB(36,84,155)
1274:             .Column2.Text1.BorderStyle = 0
1275:             .Column2.Text1.Margin      = 0
1276:             .Column2.Text1.ReadOnly    = .T.
1277: 
1278:             *-- Column3: DPros (Descricao)
1279:             .Column3.FontName      = "Tahoma"
1280:             .Column3.FontSize      = 8
1281:             .Column3.Width         = 290
1282:             .Column3.Movable       = .F.
1283:             .Column3.Resizable     = .F.
1284:             .Column3.ControlSource = "cursor_4c_Dados.DPros"
1285:             .Column3.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1286:             .Column3.Header1.Alignment = 2
1287:             .Column3.Header1.ForeColor = RGB(36,84,155)
1288:             .Column3.Text1.Margin      = 0
1289:             .Column3.Text1.ReadOnly    = .T.
1290: 
1291:             *-- Column4: ValAnt (Venda Ant.)
1292:             .Column4.FontName      = "Tahoma"
1293:             .Column4.FontSize      = 8
1294:             .Column4.Width         = 80
1295:             .Column4.Movable       = .F.
1296:             .Column4.Resizable     = .F.
1297:             .Column4.ControlSource = "cursor_4c_Dados.ValAnt"
1298:             .Column4.Header1.Caption   = "Venda Ant."
1299:             .Column4.Header1.Alignment = 2
1300:             .Column4.Header1.ForeColor = RGB(36,84,155)
1301:             WITH .Column4.Text1
1302:                 .InputMask  = "999,999,999.99"
1303:                 .Margin     = 0
1304:                 .ReadOnly   = .T.
1305:             ENDWITH
1306: 
1307:             *-- Column5: ValAtu (Venda Atual)
1308:             .Column5.FontName      = "Tahoma"
1309:             .Column5.FontSize      = 8
1310:             .Column5.Width         = 80
1311:             .Column5.Movable       = .F.
1312:             .Column5.Resizable     = .F.
1313:             .Column5.ControlSource = "cursor_4c_Dados.ValAtu"
1314:             .Column5.Header1.Caption   = "Venda Atual"
1315:             .Column5.Header1.Alignment = 2
1316:             .Column5.Header1.ForeColor = RGB(36,84,155)
1317:             WITH .Column5.Text1
1318:                 .InputMask  = "999,999,999.99"
1319:                 .Margin     = 0
1320:                 .ReadOnly   = .T.
1321:             ENDWITH
1322: 
1323:             *-- Column6: PVarias (Variacao %)
1324:             .Column6.FontName      = "Tahoma"
1325:             .Column6.FontSize      = 8
1326:             .Column6.Width         = 80
1327:             .Column6.Movable       = .F.
1328:             .Column6.Resizable     = .F.
1329:             .Column6.ReadOnly      = .T.
1330:             .Column6.ControlSource = "cursor_4c_Dados.PVarias"
1331:             .Column6.Header1.Caption   = "Varia" + CHR(231) + CHR(227) + "o (%)"
1332:             .Column6.Header1.Alignment = 2
1333:             .Column6.Header1.ForeColor = RGB(36,84,155)
1334:             WITH .Column6.Text1
1335:                 .BorderStyle = 0
1336:                 .Margin      = 0
1337:                 .ReadOnly    = .T.
1338:                 .InputMask   = "999,999.99"
1339:                 .ForeColor   = RGB(0,0,0)
1340:                 .BackColor   = RGB(255,255,255)
1341:             ENDWITH
1342: 
1343:             *-- Column7: CustoAfs (Custo Ant.)
1344:             .Column7.FontName      = "Tahoma"
1345:             .Column7.FontSize      = 8
1346:             .Column7.Width         = 80
1347:             .Column7.Movable       = .F.
1348:             .Column7.Resizable     = .F.
1349:             .Column7.ReadOnly      = .T.
1350:             .Column7.ControlSource = "cursor_4c_Dados.CustoAfs"
1351:             .Column7.Header1.Caption   = "Custo Ant."
1352:             .Column7.Header1.Alignment = 2
1353:             WITH .Column7.Text1
1354:                 .BorderStyle = 0
1355:                 .Margin      = 0
1356:                 .ReadOnly    = .T.
1357:                 .InputMask   = "999,999,999.9999"
1358:                 .ForeColor   = RGB(0,0,0)
1359:                 .BackColor   = RGB(255,255,255)
1360:             ENDWITH
1361: 
1362:             *-- Column8: CustoFs (Custo Atual)
1363:             .Column8.FontName      = "Tahoma"
1364:             .Column8.FontSize      = 8
1365:             .Column8.Width         = 80
1366:             .Column8.Movable       = .F.
1367:             .Column8.Resizable     = .F.
1368:             .Column8.ReadOnly      = .T.
1369:             .Column8.ControlSource = "cursor_4c_Dados.CustoFs"
1370:             .Column8.Header1.Caption   = "Custo Atual"
1371:             .Column8.Header1.Alignment = 2
1372:             WITH .Column8.Text1
1373:                 .BorderStyle = 0
1374:                 .Margin      = 0
1375:                 .ReadOnly    = .T.
1376:                 .InputMask   = "999,999,999.9999"
1377:                 .ForeColor   = RGB(0,0,0)
1378:                 .BackColor   = RGB(255,255,255)
1379:             ENDWITH
1380: 
1381:             *-- Column9: CVarias (Variacao Custo %)
1382:             .Column9.FontName      = "Tahoma"
1383:             .Column9.FontSize      = 8
1384:             .Column9.Width         = 80
1385:             .Column9.Movable       = .F.
1386:             .Column9.Resizable     = .F.
1387:             .Column9.ReadOnly      = .T.
1388:             .Column9.ControlSource = "cursor_4c_Dados.CVarias"
1389:             .Column9.Header1.Caption   = "Varia" + CHR(231) + CHR(227) + "o Cto (%)"
1390:             .Column9.Header1.Alignment = 2
1391:             WITH .Column9.Text1
1392:                 .BorderStyle = 0
1393:                 .Margin      = 0
1394:                 .ReadOnly    = .T.
1395:                 .InputMask   = "999,999.99"
1396:                 .ForeColor   = RGB(0,0,0)
1397:                 .BackColor   = RGB(255,255,255)
1398:             ENDWITH
1399: 
1400:             .Refresh
1401:         ENDWITH
1402:     ENDPROC
1403: 

*-- Linhas 1721 a 1744:
1721:             *-- Filtrar por variacao
1722:             loc_nVaria = THIS.txt_4c_Variacao.Value
1723:             IF USED("cursor_4c_Dados")
1724:                 SELECT cursor_4c_Dados
1725:                 IF loc_nVaria > 0
1726:                     DELETE FOR PVarias < loc_nVaria
1727:                 ENDIF
1728:                 IF loc_nVaria < 0
1729:                     DELETE FOR PVarias > loc_nVaria
1730:                 ENDIF
1731:                 SET ORDER TO CPros
1732:                 GO TOP
1733:             ENDIF
1734:             THIS.cmd_4c_Atualizar.Enabled = .T.
1735:             THIS.cmd_4c_Imprimir.Enabled  = .T.
1736:             THIS.grd_4c_Produto.Refresh
1737:         ENDIF
1738:     ENDPROC
1739: 
1740:     PROCEDURE BtnAtualizarClick
1741:         THIS.this_oBusinessObject.AtualizarPrecos(.F.)
1742:     ENDPROC
1743: 
1744:     PROCEDURE BtnEncerrarClick

*-- Linhas 1751 a 1807:
1751: 
1752:     PROCEDURE BtnSelTudoClick
1753:         IF USED("cursor_4c_Dados")
1754:             UPDATE cursor_4c_Dados SET lMarca = 1
1755:             THIS.grd_4c_Produto.Refresh
1756:         ENDIF
1757:     ENDPROC
1758: 
1759:     PROCEDURE BtnDesmarcarClick
1760:         IF USED("cursor_4c_Dados")
1761:             UPDATE cursor_4c_Dados SET lMarca = 0
1762:             THIS.grd_4c_Produto.Refresh
1763:         ENDIF
1764:     ENDPROC
1765: 
1766:     *==========================================================================
1767:     * HANDLER - OpcRecalc mudou
1768:     *==========================================================================
1769:     PROCEDURE OpcRecalcMudou
1770:         THIS.AtualizarEstadoCampos()
1771:     ENDPROC
1772: 
1773:     *==========================================================================
1774:     * HANDLER - Grid AfterRowColChange
1775:     *==========================================================================
1776:     PROCEDURE GrdAfterRowColChange(par_nColIndex)
1777:         LOCAL loc_cCodPro, loc_cSql, loc_cArq, loc_cFoto
1778:         loc_cCodPro = ""
1779: 
1780:         IF USED("cursor_4c_Dados")
1781:             SELECT cursor_4c_Dados
1782:             loc_cCodPro = ALLTRIM(NVL(cursor_4c_Dados.CPros, ""))
1783:         ENDIF
1784: 
1785:         THIS.img_4c_FigJpg.Visible  = .F.
1786:         THIS.img_4c_FigJpg.Picture  = ""
1787: 
1788:         IF !EMPTY(loc_cCodPro) AND gnConnHandle > 0
1789:             loc_cSql = "SELECT FigJpgs FROM SigCdPro WHERE Cpros = " + EscaparSQL(loc_cCodPro)
1790:             IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_FigTemp") >= 1
1791:                 IF RECCOUNT("cursor_4c_FigTemp") > 0
1792:                     SELECT cursor_4c_FigTemp
1793:                     GO TOP
1794:                     IF !ISNULL(cursor_4c_FigTemp.FigJpgs) AND !EMPTY(cursor_4c_FigTemp.FigJpgs)
1795:                         loc_cArq  = SYS(2023) + "\TempCj.jpg"
1796:                         loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_FigTemp.FigJpgs, ;
1797:                                     "data:image/png;base64,", ""), ;
1798:                                     "data:image/jpeg;base64,", ""), ;
1799:                                     "data:image/jpg;base64,", ""), 14)
1800:                         STRTOFILE(loc_cFoto, loc_cArq, 0)
1801:                         THIS.img_4c_FigJpg.Picture = loc_cArq
1802:                         THIS.img_4c_FigJpg.Visible = .T.
1803:                     ENDIF
1804:                 ENDIF
1805:                 IF USED("cursor_4c_FigTemp")
1806:                     USE IN cursor_4c_FigTemp
1807:                 ENDIF

*-- Linhas 1818 a 1856:
1818:         loc_cCodPro = ""
1819: 
1820:         IF USED("cursor_4c_Dados")
1821:             SELECT cursor_4c_Dados
1822:             loc_cCodPro = ALLTRIM(NVL(cursor_4c_Dados.CPros, ""))
1823:         ENDIF
1824: 
1825:         IF !EMPTY(loc_cCodPro) AND gnConnHandle > 0
1826:             loc_cSql = "SELECT cpros, FigJpgs FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCodPro)
1827:             IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_FigZoom") >= 1
1828:                 IF RECCOUNT("cursor_4c_FigZoom") > 0
1829:                     SELECT cursor_4c_FigZoom
1830:                     GO TOP
1831:                     IF !EMPTY(cursor_4c_FigZoom.FigJpgs) AND !ISNULL(cursor_4c_FigZoom.FigJpgs)
1832:                         loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_FigZoom.FigJpgs, ;
1833:                                     "data:image/png;base64,", ""), ;
1834:                                     "data:image/jpeg;base64,", ""), ;
1835:                                     "data:image/jpg;base64,", ""), 14)
1836:                         STRTOFILE(loc_cFoto, loc_cArq, 0)
1837:                         IF FILE(loc_cArq)
1838:                             DO FORM SigOpZom WITH loc_cArq, ;
1839:                                 "Produto : " + loc_cCodPro + " - " + ALLTRIM(NVL(cursor_4c_FigZoom.cpros, "")), ;
1840:                                 " "
1841:                             DELETE FILE (loc_cArq)
1842:                         ENDIF
1843:                     ENDIF
1844:                 ENDIF
1845:                 IF USED("cursor_4c_FigZoom")
1846:                     USE IN cursor_4c_FigZoom
1847:                 ENDIF
1848:             ENDIF
1849:         ENDIF
1850:     ENDPROC
1851: 
1852:     *==========================================================================
1853:     * VALIDADORES
1854:     *==========================================================================
1855:     PROCEDURE ValidarReajuste
1856:         IF THIS.txt_4c_Reajuste.Value > 0

*-- Linhas 1898 a 1919:
1898:             ENDIF
1899:             *-- Buscar descricao
1900:             IF gnConnHandle > 0
1901:                 loc_cSql = "SELECT Nomes FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cCod)
1902:                 IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_FornTmp") >= 1
1903:                     IF RECCOUNT("cursor_4c_FornTmp") > 0
1904:                         SELECT cursor_4c_FornTmp
1905:                         GO TOP
1906:                         loc_cDesc = ALLTRIM(NVL(cursor_4c_FornTmp.Nomes, ""))
1907:                     ENDIF
1908:                     IF USED("cursor_4c_FornTmp")
1909:                         USE IN cursor_4c_FornTmp
1910:                     ENDIF
1911:                 ENDIF
1912:             ENDIF
1913:             THIS.txt_4c_DFornecs.Value = loc_cDesc
1914:         ELSE
1915:             THIS.txt_4c_CFornecs.Value = ""
1916:             THIS.txt_4c_DFornecs.Value = ""
1917:         ENDIF
1918:     ENDPROC
1919: 

*-- Linhas 1939 a 1957:
1939:             IF !loc_oForm.this_lAchouRegistro
1940:             loc_oForm.mAddColuna(par_cChave, "", "C" + CHR(243) + "digo")
1941:             IF USED(par_cAlias)
1942:                 SELECT (par_cAlias)
1943:                 IF FCOUNT() > 1
1944:                     loc_oForm.mAddColuna(FIELD(2), "", "Descri" + CHR(231) + CHR(227) + "o")
1945:                 ENDIF
1946:             ENDIF
1947:             loc_oForm.Show()
1948:             IF loc_oForm.this_lSelecionou AND USED(par_cAlias)
1949:                 par_oCampo.Value = ALLTRIM(EVALUATE(par_cAlias + "." + par_cChave))
1950:             ENDIF
1951:             ENDIF
1952:         ENDIF
1953: 
1954:         IF USED(par_cAlias)
1955:             USE IN (par_cAlias)
1956:         ENDIF
1957:         loc_oForm.Release()

*-- Linhas 2157 a 2180:
2157:         loc_cVal = ALLTRIM(THIS.txt_4c_Feitio.Value)
2158: 
2159:         IF gnConnHandle > 0
2160:             loc_cSql = "SELECT Cods, Descs, Moedas, Acrescs FROM SigPrFti"
2161:             IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_FtiBus") >= 1
2162:                 IF !USED("cursor_4c_FtiBus")
2163:                     RETURN
2164:                 ENDIF
2165:                 SELECT cursor_4c_FtiBus
2166:                 INDEX ON Cods TAG Cods ADDITIVE
2167: 
2168:                 IF !SEEK(loc_cVal, "cursor_4c_FtiBus", "Cods")
2169:                     loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2170:                         "SigPrFti", "cursor_4c_FtiBus2", "Cods", loc_cVal, "Feitios")
2171:                     IF !ISNULL(loc_oForm)
2172:                         loc_oForm.mAddColuna("Cods",  "", "Cod")
2173:                         loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
2174:                         loc_oForm.Show()
2175:                         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_FtiBus2")
2176:                             THIS.txt_4c_Feitio.Value = ALLTRIM(cursor_4c_FtiBus2.Cods)
2177:                         ENDIF
2178:                         IF USED("cursor_4c_FtiBus2")
2179:                             USE IN cursor_4c_FtiBus2
2180:                         ENDIF

*-- Linhas 2205 a 2228:
2205:         loc_cVal = ALLTRIM(THIS.txt_4c_NewMkp.Value)
2206: 
2207:         IF gnConnHandle > 0
2208:             loc_cSql = "SELECT Cods, Descs, Moedas, Acrescs FROM SigPrFti WHERE Tipos = 1"
2209:             IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_MkpBus") >= 1
2210:                 IF !USED("cursor_4c_MkpBus")
2211:                     RETURN
2212:                 ENDIF
2213:                 SELECT cursor_4c_MkpBus
2214:                 INDEX ON Cods TAG Cods ADDITIVE
2215: 
2216:                 IF !SEEK(loc_cVal, "cursor_4c_MkpBus", "Cods")
2217:                     loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2218:                         "SigPrFti", "cursor_4c_MkpBus2", "Cods", loc_cVal, "Feitios")
2219:                     IF !ISNULL(loc_oForm)
2220:                         loc_oForm.mAddColuna("Cods",  "", "Cod")
2221:                         loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
2222:                         loc_oForm.Show()
2223:                         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_MkpBus2")
2224:                             THIS.txt_4c_NewMkp.Value = ALLTRIM(cursor_4c_MkpBus2.Cods)
2225:                         ENDIF
2226:                         IF USED("cursor_4c_MkpBus2")
2227:                             USE IN cursor_4c_MkpBus2
2228:                         ENDIF

*-- Linhas 2294 a 2312:
2294:     *==========================================================================
2295:     PROCEDURE BtnCancelarClick
2296:         IF USED("cursor_4c_Dados")
2297:             SELECT cursor_4c_Dados
2298:             ZAP
2299:             THIS.grd_4c_Produto.Refresh
2300:         ENDIF
2301:         THIS.this_oBusinessObject.this_lProcessado = .F.
2302:         THIS.cmd_4c_Atualizar.Enabled = .F.
2303:         THIS.cmd_4c_Imprimir.Enabled  = .F.
2304:     ENDPROC
2305: 
2306:     *==========================================================================
2307:     * CarregarLista - Override de FormBase (form OPERACIONAL nao tem lista CRUD)
2308:     *==========================================================================
2309:     PROCEDURE CarregarLista
2310:         RETURN
2311:     ENDPROC
2312: 

*-- Linhas 2459 a 2477:
2459: 
2460:         *-- Cursor de resultados
2461:         IF USED("cursor_4c_Dados")
2462:             SELECT cursor_4c_Dados
2463:             ZAP
2464:             THIS.grd_4c_Produto.Refresh
2465:         ENDIF
2466: 
2467:         *-- Imagem
2468:         THIS.img_4c_FigJpg.Visible = .F.
2469:         THIS.img_4c_FigJpg.Picture = ""
2470: 
2471:         *-- Reset do estado de processamento
2472:         THIS.this_oBusinessObject.this_lProcessado = .F.
2473:         THIS.cmd_4c_Atualizar.Enabled = .F.
2474:         THIS.cmd_4c_Imprimir.Enabled  = .F.
2475: 
2476:         THIS.AtualizarEstadoCampos()
2477:     ENDPROC

