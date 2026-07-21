# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (9)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DPROS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, NSITUAS, USUACESS, USUARIOS, NTPIMPRES, LNIMP, ETIQDUPS, LPRECOS, 0, QTDS, CIMPS, GRUPOS, CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EAN13' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, NSITUAS, USUACESS, USUARIOS, NTPIMPRES, LNIMP, ETIQDUPS, LPRECOS, 0, QTDS, CIMPS, GRUPOS, CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CBARS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, NSITUAS, USUACESS, USUARIOS, NTPIMPRES, LNIMP, ETIQDUPS, LPRECOS, 0, QTDS, CIMPS, GRUPOS, CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CUNIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, NSITUAS, USUACESS, USUARIOS, NTPIMPRES, LNIMP, ETIQDUPS, LPRECOS, 0, QTDS, CIMPS, GRUPOS, CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EMPDOPNUMS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, NSITUAS, USUACESS, USUARIOS, NTPIMPRES, LNIMP, ETIQDUPS, LPRECOS, 0, QTDS, CIMPS, GRUPOS, CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, NSITUAS, USUACESS, USUARIOS, NTPIMPRES, LNIMP, ETIQDUPS, LPRECOS, 0, QTDS, CIMPS, GRUPOS, CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, NSITUAS, USUACESS, USUARIOS, NTPIMPRES, LNIMP, ETIQDUPS, LPRECOS, 0, QTDS, CIMPS, GRUPOS, CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NUMES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, NSITUAS, USUACESS, USUARIOS, NTPIMPRES, LNIMP, ETIQDUPS, LPRECOS, 0, QTDS, CIMPS, GRUPOS, CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna '6' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, NSITUAS, USUACESS, USUARIOS, NTPIMPRES, LNIMP, ETIQDUPS, LPRECOS, 0, QTDS, CIMPS, GRUPOS, CPROS

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
  Column1.ControlSource = "dbimpressao.cpros"
  Column2.ControlSource = "dbimpressao.dpros"
  Column3.ControlSource = "dbimpressao.qtds"
  Column4.ControlSource = "dbimpressao.Dpro2s"
  Column5.ControlSource = "dbimpressao.parcelas"
  Column6.ControlSource = "dbimpressao.PVens"
  Column7.ControlSource = "dbimpressao.PrecoDe"
  ControlSource = "dbimpressao.cpros"
  ControlSource = "dbimpressao.dpros"
  ControlSource = "dbimpressao.qtds"
  ControlSource = "dbimpressao.reffs"
  ControlSource = ""
				Insert Into crImpre	(impres) Values(Upper(laPrinters(lnI, 1)))
		Select crSigCdTpe
		Select crSigCdTpe
		lcSql = [Select b.Impres ] + ;
				  [From SigSyImp a, SigCdmp b ] + ;
				[Select c.Impres ] + ;
				  [From SigCdAcG a, SigSyImp b, SigCdmp c ] + ;
		If ThisForm.podatamgr.sqlexecute(lcSql,'crTmpCimp') <= 0
		Select crTmpCImp
			Select Distinct Impres ;
			  From crTmpCImp ;
			lcQuery = [Select Distinct Impres ] + ;
					    [From SigCdmp ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigCdmp]) < 1)
		Select crSigCdmp
		SELECT PADR(ALLTRIM(a.Impres),15)+' '+ALLTRIM(b.impres) as IDupla, b.impres, a.impres as impresS from crSigCdmp a, crImpre b where ALLTRIM(UPPER(a.impres)) like '%'+ALLTRIM(UPPER(b.impres))+'%' ;
		SELECT * FROM crImp order by 1 into cursor crImpreV
		SELECT crImpreV
	Select CPros From dbImpressao Where Not Empty(Cpros) Into Cursor TmpDig
			Select LocalLPreI
				Insert Into dbImpressao (Cpros, DPros, Qtds, QtdeEtiq, Obs, PVens, empos, PrecoDe) ;
	Select dbImpressao
	Select crSigCdUni
	lcQuery = [Select LPrecos, CPros, DPros, PVens, PrecoDe, VencIs, VencFs ] + ;
			    [From SigCdLpi ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalLPreI') < 1)
	Select LocalLPreI
Select dbImpressao
If Not Seek(cChave)
Select CPros From dbImpressao Where Not Empty(Cpros) Into Cursor TmpDig
		Select LocalEestI
			Insert Into dbImpressao (Cpros, DPros, Qtds, QtdeEtiq, Obs, PVens, empos, empdopnums, citens, Pesos, PrecoDe) ;
	Select dbImpressao
		lcQuery = [Select LPrecos, CPros, DPros, PVens, PrecoDe, VencIs, VencFs ] + ;
				    [From SigCdLpi ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalLPreI') < 1)
		Select LocalLPreI
Select dbImpressao
Select dbImpressao
Delete
Select dbImpressao
Select * From DbImpressao Where 0=1 Into Cursor crOrdenado ReadWrite
Select dbImpressao
Delete From dbImpressao Where Qtds <= 0 
Select DbImpressao
	Insert Into crOrdenado From Memvar
Select crOrdenado
	Insert Into DbImpressao From Memvar
Select dbImpressao

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEtq.prg) - TRECHOS RELEVANTES PARA PASS SQL (2565 linhas total):

*-- Linhas 46 a 64:
46: 			ENDIF
47: 
48: 			SET NULL ON
49: 			CREATE CURSOR cursor_4c_Etiquetas ;
50: 				(Cpros C(14) NULL, DPros C(40) NULL, Reffs C(40) NULL, ;
51: 				 Qtds N(10,3) NULL, QtdeEtiq N(10,3) NULL, ;
52: 				 Pedido C(30) NULL, Obs C(10) NULL, PVens N(12,2) NULL, ;
53: 				 PrecoDe N(12,2) NULL, Parcelas N(2,0) NULL, ;
54: 				 Cpros2 C(14) NULL, Cpros3 C(14) NULL, Cpros4 C(14) NULL, ;
55: 				 empos C(3) NULL, empdopnums C(29) NULL, ;
56: 				 citens N(10,0) NULL, Pesos N(12,2) NULL, ;
57: 				 CodTams C(4) NULL, DPro2s C(45) NULL)
58: 			SET NULL OFF
59: 
60: 			INDEX ON Cpros TAG Cpros
61: 			INDEX ON RECNO() TAG Registros
62: 			SET ORDER TO
63: 
64: 			THIS.ConfigurarPageFrame()

*-- Linhas 505 a 636:
505: 			.RecordSourceType = 1
506: 			.ColumnCount      = 7
507: 			.GridLines        = 1
508: 			.DeleteMark       = .F.
509: 			.RecordMark       = .F.
510: 			.AllowRowSizing   = .F.
511: 			.HeaderHeight     = 22
512: 			.RowHeight        = 20
513: 			.FontName         = "Tahoma"
514: 			.FontSize         = 8
515: 
516: 			WITH .Columns(1)
517: 				.Header1.Caption = "C" + CHR(243) + "digo"
518: 				.Width           = 110
519: 				.ControlSource   = "cursor_4c_Etiquetas.Cpros"
520: 				.Sparse          = .F.
521: 				.AddObject("txt_4c_GrdCpros", "TextBox")
522: 				WITH .txt_4c_GrdCpros
523: 					.ControlSource = "cursor_4c_Etiquetas.Cpros"
524: 					.FontName      = "Tahoma"
525: 					.FontSize      = 8
526: 				ENDWITH
527: 				.CurrentControl = "txt_4c_GrdCpros"
528: 			ENDWITH
529: 
530: 			WITH .Columns(2)
531: 				.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
532: 				.Width           = 270
533: 				.ControlSource   = "cursor_4c_Etiquetas.DPros"
534: 				.Sparse          = .F.
535: 				.AddObject("txt_4c_GrdDpros", "TextBox")
536: 				WITH .txt_4c_GrdDpros
537: 					.ControlSource = "cursor_4c_Etiquetas.DPros"
538: 					.FontName      = "Tahoma"
539: 					.FontSize      = 8
540: 				ENDWITH
541: 				.CurrentControl = "txt_4c_GrdDpros"
542: 			ENDWITH
543: 
544: 			WITH .Columns(3)
545: 				.Header1.Caption = "Qtde"
546: 				.Width           = 65
547: 				.ControlSource   = "cursor_4c_Etiquetas.Qtds"
548: 				.Sparse          = .F.
549: 				.AddObject("txt_4c_GrdQtds", "TextBox")
550: 				WITH .txt_4c_GrdQtds
551: 					.ControlSource = "cursor_4c_Etiquetas.Qtds"
552: 					.FontName      = "Tahoma"
553: 					.FontSize      = 8
554: 				ENDWITH
555: 				.CurrentControl = "txt_4c_GrdQtds"
556: 			ENDWITH
557: 
558: 			WITH .Columns(4)
559: 				.Header1.Caption = "Refer" + CHR(234) + "ncia"
560: 				.Width           = 135
561: 				.ControlSource   = "cursor_4c_Etiquetas.Reffs"
562: 				.Sparse          = .F.
563: 				.AddObject("txt_4c_GrdReffs", "TextBox")
564: 				WITH .txt_4c_GrdReffs
565: 					.ControlSource = "cursor_4c_Etiquetas.Reffs"
566: 					.FontName      = "Tahoma"
567: 					.FontSize      = 8
568: 				ENDWITH
569: 				.CurrentControl = "txt_4c_GrdReffs"
570: 			ENDWITH
571: 
572: 			WITH .Columns(5)
573: 				.Header1.Caption = "Parcelas"
574: 				.Width           = 60
575: 				.ControlSource   = "cursor_4c_Etiquetas.Parcelas"
576: 				.Sparse          = .F.
577: 				.AddObject("txt_4c_GrdParcelas", "TextBox")
578: 				WITH .txt_4c_GrdParcelas
579: 					.ControlSource = "cursor_4c_Etiquetas.Parcelas"
580: 					.FontName      = "Tahoma"
581: 					.FontSize      = 8
582: 				ENDWITH
583: 				.CurrentControl = "txt_4c_GrdParcelas"
584: 			ENDWITH
585: 
586: 			WITH .Columns(6)
587: 				.Header1.Caption = "P.Venda"
588: 				.Width           = 70
589: 				.ControlSource   = "cursor_4c_Etiquetas.PVens"
590: 				.ReadOnly        = .T.
591: 				.Sparse          = .F.
592: 				.AddObject("txt_4c_GrdPvens", "TextBox")
593: 				WITH .txt_4c_GrdPvens
594: 					.ControlSource = "cursor_4c_Etiquetas.PVens"
595: 					.FontName      = "Tahoma"
596: 					.FontSize      = 8
597: 					.ReadOnly      = .T.
598: 				ENDWITH
599: 				.CurrentControl = "txt_4c_GrdPvens"
600: 			ENDWITH
601: 
602: 			WITH .Columns(7)
603: 				.Header1.Caption = "Pre" + CHR(231) + "o De"
604: 				.Width           = 70
605: 				.ControlSource   = "cursor_4c_Etiquetas.PrecoDe"
606: 				.ReadOnly        = .T.
607: 				.Sparse          = .F.
608: 				.AddObject("txt_4c_GrdPrecoDe", "TextBox")
609: 				WITH .txt_4c_GrdPrecoDe
610: 					.ControlSource = "cursor_4c_Etiquetas.PrecoDe"
611: 					.FontName      = "Tahoma"
612: 					.FontSize      = 8
613: 					.ReadOnly      = .T.
614: 				ENDWITH
615: 				.CurrentControl = "txt_4c_GrdPrecoDe"
616: 			ENDWITH
617: 		ENDWITH
618: 
619: 		*-- Primeira linha em branco para edicao imediata
620: 		IF USED("cursor_4c_Etiquetas") AND RECCOUNT("cursor_4c_Etiquetas") = 0
621: 			SELECT cursor_4c_Etiquetas
622: 			APPEND BLANK
623: 		ENDIF
624: 
625: 		*-- BINDEVENTs
626: 		BINDEVENT(THIS.txt_4c_Emps,                  "KeyPress", THIS, "TxtEmpsKeyPress")
627: 		BINDEVENT(THIS.txt_4c_Dopes,                 "KeyPress", THIS, "TxtDopesKeyPress")
628: 		BINDEVENT(THIS.txt_4c_Cpros,                 "KeyPress", THIS, "TxtCprosKeyPress")
629: 		BINDEVENT(THIS.txt_4c_Dpros,                 "KeyPress", THIS, "TxtDprosKeyPress")
630: 		BINDEVENT(THIS.txt_4c_Qtds,                  "KeyPress", THIS, "TxtQtdsKeyPress")
631: 		BINDEVENT(THIS.txt_4c_Lpreco,                "KeyPress", THIS, "TxtLprecoKeyPress")
632: 		BINDEVENT(THIS.txt_4c_LPreco2,               "KeyPress", THIS, "TxtLPreco2KeyPress")
633: 		BINDEVENT(THIS.cmd_4c_BtnCarregar,           "Click",    THIS, "CmdBtnCarregarClick")
634: 		BINDEVENT(THIS.cmd_4c_BtnExcluir,            "Click",    THIS, "CmdBtnExcluirClick")
635: 		BINDEVENT(THIS.grd_4c_Etiquetas,             "KeyPress", THIS, "GrdEtiquetasKeyPress")
636: 		BINDEVENT(THIS.cmg_4c_BtnReport.Buttons(1), "Click",    THIS, "BtnImprimirClick")

*-- Linhas 669 a 776:
669: 		LOCAL loc_cEmps, loc_nRet, loc_oBusca
670: 		loc_cEmps = ALLTRIM(NVL(THIS.txt_4c_Emps.Value, ""))
671: 		IF !EMPTY(loc_cEmps)
672: 			loc_nRet = SQLEXEC(gnConnHandle, ;
673: 				"SELECT TOP 1 Emps, DEmps FROM SigCdEmp WHERE RTRIM(Emps)=" + EscaparSQL(loc_cEmps), ;
674: 				"cursor_4c_BuscaEmp")
675: 			IF loc_nRet > 0 AND USED("cursor_4c_BuscaEmp") AND RECCOUNT("cursor_4c_BuscaEmp") > 0
676: 				SELECT cursor_4c_BuscaEmp
677: 				THIS.lbl_4c_DEmps.Caption = ALLTRIM(cursor_4c_BuscaEmp.DEmps)
678: 				USE IN cursor_4c_BuscaEmp
679: 				THIS.txt_4c_Dopes.SetFocus()
680: 				RETURN
681: 			ENDIF
682: 			IF USED("cursor_4c_BuscaEmp")
683: 				USE IN cursor_4c_BuscaEmp
684: 			ENDIF
685: 		ENDIF
686: 		loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
687: 			"SigCdEmp", "cursor_4c_BuscaEmp", "Emps", ;
688: 			loc_cEmps, "Empresa", .T., .T., "")
689: 		IF VARTYPE(loc_oBusca) = "O"
690: 			IF !loc_oBusca.this_lAchouRegistro
691: 				loc_oBusca.mAddColuna("Emps",  "", "C" + CHR(243) + "d.")
692: 				loc_oBusca.mAddColuna("DEmps", "", "Empresa")
693: 				loc_oBusca.Show()
694: 			ENDIF
695: 			IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
696: 				SELECT cursor_4c_BuscaEmp
697: 				THIS.txt_4c_Emps.Value     = ALLTRIM(cursor_4c_BuscaEmp.Emps)
698: 				THIS.lbl_4c_DEmps.Caption  = ALLTRIM(cursor_4c_BuscaEmp.DEmps)
699: 				USE IN cursor_4c_BuscaEmp
700: 				THIS.txt_4c_Dopes.SetFocus()
701: 			ENDIF
702: 		ENDIF
703: 	ENDPROC
704: 
705: 	*====================================================================
706: 	* TxtDopesKeyPress - Valida ou abre busca de operacao (SigCdOpe)
707: 	*====================================================================
708: 	PROCEDURE TxtDopesKeyPress(par_nKeyCode, par_nShiftAltCtrl)
709: 		IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
710: 			RETURN
711: 		ENDIF
712: 		LOCAL loc_cDopes, loc_nRet, loc_oBusca
713: 		loc_cDopes = ALLTRIM(NVL(THIS.txt_4c_Dopes.Value, ""))
714: 		IF !EMPTY(loc_cDopes)
715: 			loc_nRet = SQLEXEC(gnConnHandle, ;
716: 				"SELECT TOP 1 Dopes FROM SigCdOpe WHERE RTRIM(Dopes)=" + EscaparSQL(loc_cDopes), ;
717: 				"cursor_4c_BuscaOpe")
718: 			IF loc_nRet > 0 AND USED("cursor_4c_BuscaOpe") AND RECCOUNT("cursor_4c_BuscaOpe") > 0
719: 				USE IN cursor_4c_BuscaOpe
720: 				THIS.txt_4c_Cpros.SetFocus()
721: 				RETURN
722: 			ENDIF
723: 			IF USED("cursor_4c_BuscaOpe")
724: 				USE IN cursor_4c_BuscaOpe
725: 			ENDIF
726: 		ENDIF
727: 		loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
728: 			"SigCdOpe", "cursor_4c_BuscaOpe", "Dopes", ;
729: 			loc_cDopes, "Opera" + CHR(231) + CHR(227) + "o", .T., .T., "")
730: 		IF VARTYPE(loc_oBusca) = "O"
731: 			IF !loc_oBusca.this_lAchouRegistro
732: 				loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
733: 				loc_oBusca.Show()
734: 			ENDIF
735: 			IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
736: 				SELECT cursor_4c_BuscaOpe
737: 				THIS.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
738: 				USE IN cursor_4c_BuscaOpe
739: 				THIS.txt_4c_Cpros.SetFocus()
740: 			ENDIF
741: 		ENDIF
742: 	ENDPROC
743: 
744: 	*====================================================================
745: 	* TxtCprosKeyPress - Busca produto por codigo, EAN13 ou codigo de barras
746: 	*====================================================================
747: 	PROCEDURE TxtCprosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
748: 		IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
749: 			RETURN
750: 		ENDIF
751: 		LOCAL loc_cCodigo, loc_nRet
752: 		loc_cCodigo = ALLTRIM(NVL(THIS.txt_4c_Cpros.Value, ""))
753: 		IF !EMPTY(loc_cCodigo)
754: 			loc_nRet = SQLEXEC(gnConnHandle, ;
755: 				"SELECT TOP 1 Cpros, DPros FROM SigCdPro " + ;
756: 				"WHERE RTRIM(Cpros)=" + EscaparSQL(loc_cCodigo) + ;
757: 				" OR RTRIM(Ean13)="  + EscaparSQL(loc_cCodigo) + ;
758: 				" OR RTRIM(CBars)="  + EscaparSQL(loc_cCodigo), ;
759: 				"cursor_4c_BuscaProd")
760: 			IF loc_nRet > 0 AND USED("cursor_4c_BuscaProd") AND RECCOUNT("cursor_4c_BuscaProd") > 0
761: 				SELECT cursor_4c_BuscaProd
762: 				THIS.txt_4c_Cpros.Value = ALLTRIM(cursor_4c_BuscaProd.Cpros)
763: 				THIS.txt_4c_Dpros.Value = ALLTRIM(cursor_4c_BuscaProd.DPros)
764: 				USE IN cursor_4c_BuscaProd
765: 				THIS.txt_4c_Qtds.SetFocus()
766: 				RETURN
767: 			ENDIF
768: 			IF USED("cursor_4c_BuscaProd")
769: 				USE IN cursor_4c_BuscaProd
770: 			ENDIF
771: 		ENDIF
772: 		THIS.AbrirBuscaProdutoCodigo()
773: 	ENDPROC
774: 
775: 	*====================================================================
776: 	* TxtDprosKeyPress - Busca produto por descricao

*-- Linhas 782 a 805:
782: 		LOCAL loc_cDesc, loc_nRet
783: 		loc_cDesc = ALLTRIM(NVL(THIS.txt_4c_Dpros.Value, ""))
784: 		IF !EMPTY(loc_cDesc)
785: 			loc_nRet = SQLEXEC(gnConnHandle, ;
786: 				"SELECT TOP 1 Cpros, DPros FROM SigCdPro " + ;
787: 				"WHERE RTRIM(DPros)=" + EscaparSQL(loc_cDesc), ;
788: 				"cursor_4c_BuscaProd")
789: 			IF loc_nRet > 0 AND USED("cursor_4c_BuscaProd") AND RECCOUNT("cursor_4c_BuscaProd") > 0
790: 				SELECT cursor_4c_BuscaProd
791: 				THIS.txt_4c_Cpros.Value = ALLTRIM(cursor_4c_BuscaProd.Cpros)
792: 				THIS.txt_4c_Dpros.Value = ALLTRIM(cursor_4c_BuscaProd.DPros)
793: 				USE IN cursor_4c_BuscaProd
794: 				THIS.txt_4c_Qtds.SetFocus()
795: 				RETURN
796: 			ENDIF
797: 			IF USED("cursor_4c_BuscaProd")
798: 				USE IN cursor_4c_BuscaProd
799: 			ENDIF
800: 		ENDIF
801: 		THIS.AbrirBuscaProdutoDescricao()
802: 	ENDPROC
803: 
804: 	*====================================================================
805: 	* TxtQtdsKeyPress - Valida qtde e adiciona produto ao grid

*-- Linhas 821 a 839:
821: 			THIS.txt_4c_Qtds.SetFocus()
822: 			RETURN
823: 		ENDIF
824: 		SELECT cursor_4c_Etiquetas
825: 		GO BOTTOM
826: 		IF !EMPTY(cursor_4c_Etiquetas.Cpros)
827: 			APPEND BLANK
828: 		ENDIF
829: 		REPLACE Cpros WITH loc_cCpros, ;
830: 		        DPros WITH ALLTRIM(NVL(THIS.txt_4c_Dpros.Value, "")), ;
831: 		        Qtds  WITH loc_nQtds
832: 		THIS.CarregarPrecoProduto(loc_cCpros)
833: 		IF THIS.chk_4c_Lista.Value = 1 AND !EMPTY(ALLTRIM(NVL(THIS.txt_4c_Lpreco.Value, "")))
834: 			THIS.AtualizarPrecoPorLista(loc_cCpros)
835: 		ENDIF
836: 		APPEND BLANK
837: 		THIS.txt_4c_Cpros.Value = ""
838: 		THIS.txt_4c_Dpros.Value = ""
839: 		THIS.txt_4c_Qtds.Value  = 0

*-- Linhas 851 a 895:
851: 		LOCAL loc_cLpreco, loc_nRet, loc_oBusca
852: 		loc_cLpreco = ALLTRIM(NVL(THIS.txt_4c_Lpreco.Value, ""))
853: 		IF !EMPTY(loc_cLpreco)
854: 			loc_nRet = SQLEXEC(gnConnHandle, ;
855: 				"SELECT TOP 1 LPrecos, DLPrecos FROM SigCdLpc " + ;
856: 				"WHERE RTRIM(LPrecos)=" + EscaparSQL(loc_cLpreco), ;
857: 				"cursor_4c_BuscaLpc")
858: 			IF loc_nRet > 0 AND USED("cursor_4c_BuscaLpc") AND RECCOUNT("cursor_4c_BuscaLpc") > 0
859: 				SELECT cursor_4c_BuscaLpc
860: 				THIS.txt_4c_Lpreco.Value  = ALLTRIM(cursor_4c_BuscaLpc.LPrecos)
861: 				THIS.txt_4c_LPreco2.Value = ALLTRIM(cursor_4c_BuscaLpc.DLPrecos)
862: 				USE IN cursor_4c_BuscaLpc
863: 				THIS.chk_4c_Lista.SetFocus()
864: 				RETURN
865: 			ENDIF
866: 			IF USED("cursor_4c_BuscaLpc")
867: 				USE IN cursor_4c_BuscaLpc
868: 			ENDIF
869: 		ENDIF
870: 		loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
871: 			"SigCdLpc", "cursor_4c_BuscaLpc", "LPrecos", ;
872: 			loc_cLpreco, "Lista de Pre" + CHR(231) + "os", .T., .T., "")
873: 		IF VARTYPE(loc_oBusca) = "O"
874: 			IF !loc_oBusca.this_lAchouRegistro
875: 				loc_oBusca.mAddColuna("LPrecos",  "", "C" + CHR(243) + "digo")
876: 				loc_oBusca.mAddColuna("DLPrecos", "", "Descri" + CHR(231) + CHR(227) + "o")
877: 				loc_oBusca.Show()
878: 			ENDIF
879: 			IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLpc")
880: 				SELECT cursor_4c_BuscaLpc
881: 				THIS.txt_4c_Lpreco.Value  = ALLTRIM(cursor_4c_BuscaLpc.LPrecos)
882: 				THIS.txt_4c_LPreco2.Value = ALLTRIM(cursor_4c_BuscaLpc.DLPrecos)
883: 				USE IN cursor_4c_BuscaLpc
884: 				THIS.chk_4c_Lista.SetFocus()
885: 			ENDIF
886: 		ENDIF
887: 	ENDPROC
888: 
889: 	*====================================================================
890: 	* TxtLPreco2KeyPress - ReadOnly, redireciona foco para txt_4c_Lpreco
891: 	*====================================================================
892: 	PROCEDURE TxtLPreco2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
893: 		IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
894: 			RETURN
895: 		ENDIF

*-- Linhas 912 a 930:
912: 				loc_oBusca.Show()
913: 			ENDIF
914: 			IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
915: 				SELECT cursor_4c_BuscaProd
916: 				THIS.txt_4c_Cpros.Value = ALLTRIM(cursor_4c_BuscaProd.Cpros)
917: 				THIS.txt_4c_Dpros.Value = ALLTRIM(cursor_4c_BuscaProd.DPros)
918: 				USE IN cursor_4c_BuscaProd
919: 				THIS.txt_4c_Qtds.SetFocus()
920: 			ENDIF
921: 		ENDIF
922: 	ENDPROC
923: 
924: 	*====================================================================
925: 	* AbrirBuscaProdutoDescricao - Picker de produto por descricao
926: 	*====================================================================
927: 	PROTECTED PROCEDURE AbrirBuscaProdutoDescricao()
928: 		LOCAL loc_oBusca
929: 		loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
930: 			"SigCdPro", "cursor_4c_BuscaProd", "DPros", ;

*-- Linhas 937 a 955:
937: 				loc_oBusca.Show()
938: 			ENDIF
939: 			IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
940: 				SELECT cursor_4c_BuscaProd
941: 				THIS.txt_4c_Cpros.Value = ALLTRIM(cursor_4c_BuscaProd.Cpros)
942: 				THIS.txt_4c_Dpros.Value = ALLTRIM(cursor_4c_BuscaProd.DPros)
943: 				USE IN cursor_4c_BuscaProd
944: 				THIS.txt_4c_Qtds.SetFocus()
945: 			ENDIF
946: 		ENDIF
947: 	ENDPROC
948: 
949: 	*====================================================================
950: 	* AbrirBuscaProdutoRef - Picker de produto por referencia (DPro2s)
951: 	*====================================================================
952: 	PROTECTED PROCEDURE AbrirBuscaProdutoRef()
953: 		LOCAL loc_cRef, loc_oBusca
954: 		loc_cRef = ""
955: 		IF USED("cursor_4c_Etiquetas") AND !EOF("cursor_4c_Etiquetas")

*-- Linhas 966 a 1019:
966: 				loc_oBusca.Show()
967: 			ENDIF
968: 			IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
969: 				SELECT cursor_4c_BuscaProd
970: 				LOCAL loc_cCpros, loc_cDPros, loc_cDPro2s
971: 				loc_cCpros  = ALLTRIM(cursor_4c_BuscaProd.Cpros)
972: 				loc_cDPros  = ALLTRIM(cursor_4c_BuscaProd.DPros)
973: 				loc_cDPro2s = ALLTRIM(cursor_4c_BuscaProd.DPro2s)
974: 				USE IN cursor_4c_BuscaProd
975: 				SELECT cursor_4c_Etiquetas
976: 				REPLACE Cpros WITH loc_cCpros, ;
977: 				        DPros WITH loc_cDPros, ;
978: 				        Reffs WITH loc_cDPro2s
979: 				THIS.CarregarPrecoProduto(loc_cCpros)
980: 				THIS.grd_4c_Etiquetas.Refresh()
981: 			ENDIF
982: 		ENDIF
983: 	ENDPROC
984: 
985: 	*====================================================================
986: 	* CarregarPrecoProduto - Carrega PVens/PrecoDe/Pesos/DPro2s na linha
987: 	*====================================================================
988: 	PROTECTED PROCEDURE CarregarPrecoProduto(par_cCpros)
989: 		LOCAL loc_nRet, loc_nPVens, loc_nPrecoDe, loc_nPesos, loc_cDPro2s
990: 		IF EMPTY(par_cCpros)
991: 			RETURN
992: 		ENDIF
993: 		loc_nRet = SQLEXEC(gnConnHandle, ;
994: 			"SELECT TOP 1 PVens, PecoDe, PesoMs, DPro2s " + ;
995: 			"FROM SigCdPro WHERE RTRIM(Cpros)=" + EscaparSQL(par_cCpros), ;
996: 			"cursor_4c_PrecosProd")
997: 		IF loc_nRet > 0 AND USED("cursor_4c_PrecosProd") AND RECCOUNT("cursor_4c_PrecosProd") > 0
998: 			SELECT cursor_4c_PrecosProd
999: 			loc_nPVens   = NVL(cursor_4c_PrecosProd.PVens,   0)
1000: 			loc_nPrecoDe = NVL(cursor_4c_PrecosProd.PecoDe,  0)
1001: 			loc_nPesos   = NVL(cursor_4c_PrecosProd.PesoMs,  0)
1002: 			loc_cDPro2s  = ALLTRIM(NVL(cursor_4c_PrecosProd.DPro2s, ""))
1003: 			USE IN cursor_4c_PrecosProd
1004: 			SELECT cursor_4c_Etiquetas
1005: 			IF THIS.chk_4c_Precio.Value = 1
1006: 				REPLACE PVens   WITH loc_nPVens, ;
1007: 				        PrecoDe WITH loc_nPrecoDe, ;
1008: 				        Pesos   WITH loc_nPesos, ;
1009: 				        DPro2s  WITH loc_cDPro2s
1010: 			ELSE
1011: 				REPLACE Pesos  WITH loc_nPesos, ;
1012: 				        DPro2s WITH loc_cDPro2s
1013: 			ENDIF
1014: 		ENDIF
1015: 		IF USED("cursor_4c_PrecosProd")
1016: 			USE IN cursor_4c_PrecosProd
1017: 		ENDIF
1018: 	ENDPROC
1019: 

*-- Linhas 1026 a 1113:
1026: 		IF EMPTY(loc_cLpreco) OR EMPTY(par_cCpros)
1027: 			RETURN
1028: 		ENDIF
1029: 		loc_nRet = SQLEXEC(gnConnHandle, ;
1030: 			"SELECT TOP 1 PVens, PrecoDe FROM SigCdLpi " + ;
1031: 			"WHERE RTRIM(LPrecos)=" + EscaparSQL(loc_cLpreco) + ;
1032: 			" AND RTRIM(CPros)=" + EscaparSQL(par_cCpros), ;
1033: 			"cursor_4c_PrecoLista")
1034: 		IF loc_nRet > 0 AND USED("cursor_4c_PrecoLista") AND RECCOUNT("cursor_4c_PrecoLista") > 0
1035: 			SELECT cursor_4c_PrecoLista
1036: 			LOCAL loc_nPVens, loc_nPrecoDe
1037: 			loc_nPVens   = NVL(cursor_4c_PrecoLista.PVens,   0)
1038: 			loc_nPrecoDe = NVL(cursor_4c_PrecoLista.PrecoDe, 0)
1039: 			USE IN cursor_4c_PrecoLista
1040: 			SELECT cursor_4c_Etiquetas
1041: 			REPLACE PVens   WITH loc_nPVens, ;
1042: 			        PrecoDe WITH loc_nPrecoDe
1043: 		ENDIF
1044: 		IF USED("cursor_4c_PrecoLista")
1045: 			USE IN cursor_4c_PrecoLista
1046: 		ENDIF
1047: 	ENDPROC
1048: 
1049: 	*====================================================================
1050: 	* CarregarItensDaLista - Popula grid com todos itens de SigCdLpi
1051: 	*====================================================================
1052: 	PROTECTED PROCEDURE CarregarItensDaLista()
1053: 		LOCAL loc_cLpreco, loc_nRet
1054: 		loc_cLpreco = ALLTRIM(NVL(THIS.txt_4c_Lpreco.Value, ""))
1055: 		IF EMPTY(loc_cLpreco)
1056: 			MsgAviso("Informe a lista de pre" + CHR(231) + "os.", "Aten" + CHR(231) + CHR(227) + "o")
1057: 			THIS.txt_4c_Lpreco.SetFocus()
1058: 			RETURN
1059: 		ENDIF
1060: 		loc_nRet = SQLEXEC(gnConnHandle, ;
1061: 			"SELECT i.CPros AS iCPros, p.DPros AS iDPros, p.DPro2s AS iDPro2s, " + ;
1062: 			" i.PVens AS iPVens, i.PrecoDe AS iPrecoDe, p.PesoMs AS iPesoMs " + ;
1063: 			"FROM SigCdLpi i " + ;
1064: 			"INNER JOIN SigCdPro p ON RTRIM(p.Cpros)=RTRIM(i.CPros) " + ;
1065: 			"WHERE RTRIM(i.LPrecos)=" + EscaparSQL(loc_cLpreco) + ;
1066: 			" ORDER BY i.CPros", ;
1067: 			"cursor_4c_ItensList")
1068: 		IF loc_nRet <= 0 OR !USED("cursor_4c_ItensList") OR RECCOUNT("cursor_4c_ItensList") = 0
1069: 			IF USED("cursor_4c_ItensList")
1070: 				USE IN cursor_4c_ItensList
1071: 			ENDIF
1072: 			MsgAviso("Nenhum item encontrado para a lista selecionada.", "Aten" + CHR(231) + CHR(227) + "o")
1073: 			RETURN
1074: 		ENDIF
1075: 		LOCAL loc_cCpros, loc_cDPros, loc_cDPro2s, loc_nPVens, loc_nPrecoDe, loc_nPesos
1076: 		SELECT cursor_4c_Etiquetas
1077: 		ZAP
1078: 		SELECT cursor_4c_ItensList
1079: 		SCAN
1080: 			loc_cCpros   = ALLTRIM(cursor_4c_ItensList.iCPros)
1081: 			loc_cDPros   = ALLTRIM(cursor_4c_ItensList.iDPros)
1082: 			loc_cDPro2s  = ALLTRIM(cursor_4c_ItensList.iDPro2s)
1083: 			loc_nPVens   = NVL(cursor_4c_ItensList.iPVens,   0)
1084: 			loc_nPrecoDe = NVL(cursor_4c_ItensList.iPrecoDe, 0)
1085: 			loc_nPesos   = NVL(cursor_4c_ItensList.iPesoMs,  0)
1086: 			SELECT cursor_4c_Etiquetas
1087: 			APPEND BLANK
1088: 			REPLACE Cpros   WITH loc_cCpros, ;
1089: 			        DPros   WITH loc_cDPros, ;
1090: 			        DPro2s  WITH loc_cDPro2s, ;
1091: 			        PVens   WITH loc_nPVens, ;
1092: 			        PrecoDe WITH loc_nPrecoDe, ;
1093: 			        Pesos   WITH loc_nPesos, ;
1094: 			        Qtds    WITH 1
1095: 			SELECT cursor_4c_ItensList
1096: 		ENDSCAN
1097: 		USE IN cursor_4c_ItensList
1098: 		SELECT cursor_4c_Etiquetas
1099: 		APPEND BLANK
1100: 		GO TOP
1101: 		THIS.grd_4c_Etiquetas.Refresh()
1102: 	ENDPROC
1103: 
1104: 	*====================================================================
1105: 	* CmdBtnCarregarClick - Carrega itens de SigMvItn por empresa/operacao
1106: 	*====================================================================
1107: 	PROCEDURE CmdBtnCarregarClick()
1108: 		LOCAL loc_cEmps, loc_cDopes, loc_nNumes, loc_cLpreco, loc_nRet
1109: 		loc_cEmps   = ALLTRIM(NVL(THIS.txt_4c_Emps.Value,  ""))
1110: 		loc_cDopes  = ALLTRIM(NVL(THIS.txt_4c_Dopes.Value, ""))
1111: 		loc_nNumes  = IIF(PEMSTATUS(THIS, "txt_4c_Numes", 5) AND VARTYPE(THIS.txt_4c_Numes) = "O", ;
1112: 		                  NVL(THIS.txt_4c_Numes.Value, 0), 0)
1113: 		loc_cLpreco = ALLTRIM(NVL(THIS.txt_4c_Lpreco.Value,""))

*-- Linhas 1128 a 1256:
1128: 			ENDIF
1129: 			RETURN
1130: 		ENDIF
1131: 		loc_nRet = SQLEXEC(gnConnHandle, ;
1132: 			"SELECT i.CPros AS iCPros, p.DPros AS iDPros, p.DPro2s AS iDPro2s, " + ;
1133: 			" i.Qtds AS iQtds, i.Citens AS iCitens, i.Numes AS iNumes, " + ;
1134: 			" i.Emps AS iEmps, i.Dopes AS iDopes, " + ;
1135: 			" p.PVens AS iPVens, p.PecoDe AS iPecoDe, p.PesoMs AS iPesoMs " + ;
1136: 			"FROM SigMvItn i " + ;
1137: 			"LEFT JOIN SigCdPro p ON RTRIM(p.Cpros)=RTRIM(i.CPros) " + ;
1138: 			"WHERE RTRIM(i.Emps)=" + EscaparSQL(loc_cEmps) + ;
1139: 			" AND RTRIM(i.Dopes)=" + EscaparSQL(loc_cDopes) + ;
1140: 			" AND i.Numes = " + FormatarNumeroSQL(loc_nNumes, 0) + ;
1141: 			" ORDER BY i.CPros", ;
1142: 			"cursor_4c_SigMvItn")
1143: 		IF loc_nRet <= 0 OR !USED("cursor_4c_SigMvItn") OR RECCOUNT("cursor_4c_SigMvItn") = 0
1144: 			IF USED("cursor_4c_SigMvItn")
1145: 				USE IN cursor_4c_SigMvItn
1146: 			ENDIF
1147: 			MsgAviso("Nenhum item encontrado para empresa/opera" + CHR(231) + CHR(227) + "o informada.", ;
1148: 			         "Aten" + CHR(231) + CHR(227) + "o")
1149: 			RETURN
1150: 		ENDIF
1151: 		LOCAL loc_cCpros, loc_cDPros, loc_cDPro2s
1152: 		LOCAL loc_nQtds, loc_nCitens, loc_nNumes
1153: 		LOCAL loc_cIEmps, loc_cIDopes
1154: 		LOCAL loc_nPVens, loc_nPrecoDe, loc_nPesos
1155: 		LOCAL loc_cEmpDoNum, loc_nRetLpi
1156: 		SELECT cursor_4c_Etiquetas
1157: 		ZAP
1158: 		SELECT cursor_4c_SigMvItn
1159: 		SCAN
1160: 			loc_cCpros   = ALLTRIM(cursor_4c_SigMvItn.iCPros)
1161: 			loc_cDPros   = ALLTRIM(NVL(cursor_4c_SigMvItn.iDPros,  ""))
1162: 			loc_cDPro2s  = ALLTRIM(NVL(cursor_4c_SigMvItn.iDPro2s, ""))
1163: 			loc_nQtds    = NVL(cursor_4c_SigMvItn.iQtds,    0)
1164: 			loc_nCitens  = NVL(cursor_4c_SigMvItn.iCitens,  0)
1165: 			loc_nNumes   = NVL(cursor_4c_SigMvItn.iNumes,   0)
1166: 			loc_cIEmps   = ALLTRIM(NVL(cursor_4c_SigMvItn.iEmps,   ""))
1167: 			loc_cIDopes  = ALLTRIM(NVL(cursor_4c_SigMvItn.iDopes,  ""))
1168: 			loc_nPVens   = NVL(cursor_4c_SigMvItn.iPVens,   0)
1169: 			loc_nPrecoDe = NVL(cursor_4c_SigMvItn.iPecoDe,  0)
1170: 			loc_nPesos   = NVL(cursor_4c_SigMvItn.iPesoMs,  0)
1171: 			*-- Aplica lista de precos se habilitada
1172: 			IF THIS.chk_4c_Lista.Value = 1 AND !EMPTY(loc_cLpreco)
1173: 				loc_nRetLpi = SQLEXEC(gnConnHandle, ;
1174: 					"SELECT TOP 1 PVens, PrecoDe FROM SigCdLpi " + ;
1175: 					"WHERE RTRIM(LPrecos)=" + EscaparSQL(loc_cLpreco) + ;
1176: 					" AND RTRIM(CPros)=" + EscaparSQL(loc_cCpros), ;
1177: 					"cursor_4c_Lpi")
1178: 				IF loc_nRetLpi > 0 AND USED("cursor_4c_Lpi") AND RECCOUNT("cursor_4c_Lpi") > 0
1179: 					SELECT cursor_4c_Lpi
1180: 					loc_nPVens   = NVL(cursor_4c_Lpi.PVens,   loc_nPVens)
1181: 					loc_nPrecoDe = NVL(cursor_4c_Lpi.PrecoDe, loc_nPrecoDe)
1182: 				ENDIF
1183: 				IF USED("cursor_4c_Lpi")
1184: 					USE IN cursor_4c_Lpi
1185: 				ENDIF
1186: 			ENDIF
1187: 			loc_cEmpDoNum = PADR(loc_cIEmps, 3) + PADR(loc_cIDopes, 20) + STR(loc_nNumes, 6, 0)
1188: 			SELECT cursor_4c_Etiquetas
1189: 			APPEND BLANK
1190: 			REPLACE Cpros      WITH loc_cCpros, ;
1191: 			        DPros      WITH loc_cDPros, ;
1192: 			        DPro2s     WITH loc_cDPro2s, ;
1193: 			        Qtds       WITH loc_nQtds, ;
1194: 			        citens     WITH loc_nCitens, ;
1195: 			        empos      WITH LEFT(loc_cIEmps, 3), ;
1196: 			        empdopnums WITH loc_cEmpDoNum, ;
1197: 			        PVens      WITH loc_nPVens, ;
1198: 			        PrecoDe    WITH loc_nPrecoDe, ;
1199: 			        Pesos      WITH loc_nPesos, ;
1200: 			        Pedido     WITH LEFT(TRANSFORM(loc_nNumes), 30)
1201: 			SELECT cursor_4c_SigMvItn
1202: 		ENDSCAN
1203: 		USE IN cursor_4c_SigMvItn
1204: 		SELECT cursor_4c_Etiquetas
1205: 		APPEND BLANK
1206: 		GO TOP
1207: 		THIS.grd_4c_Etiquetas.Refresh()
1208: 	ENDPROC
1209: 
1210: 	*====================================================================
1211: 	* CmdBtnExcluirClick - Remove linha selecionada do grid
1212: 	*====================================================================
1213: 	PROCEDURE CmdBtnExcluirClick()
1214: 		IF !USED("cursor_4c_Etiquetas") OR RECCOUNT("cursor_4c_Etiquetas") <= 1
1215: 			RETURN
1216: 		ENDIF
1217: 		SELECT cursor_4c_Etiquetas
1218: 		IF EOF() OR BOF() OR EMPTY(cursor_4c_Etiquetas.Cpros)
1219: 			RETURN
1220: 		ENDIF
1221: 		DELETE
1222: 		PACK
1223: 		IF RECCOUNT("cursor_4c_Etiquetas") = 0
1224: 			APPEND BLANK
1225: 		ENDIF
1226: 		GO TOP
1227: 		THIS.grd_4c_Etiquetas.Refresh()
1228: 	ENDPROC
1229: 
1230: 	*====================================================================
1231: 	* BtnIncluirClick - Adiciona linha em branco no grid para o usuario
1232: 	* preencher manualmente (produto/quantidade). Adaptacao CRUD do
1233: 	* fluxo OPERACIONAL: nao ha modo de edicao separado, o grid eh
1234: 	* editavel diretamente.
1235: 	*====================================================================
1236: 	PROCEDURE BtnIncluirClick()
1237: 		IF !USED("cursor_4c_Etiquetas")
1238: 			MsgAviso("Grid n" + CHR(227) + "o inicializado.", "Aten" + CHR(231) + CHR(227) + "o")
1239: 			RETURN
1240: 		ENDIF
1241: 		SELECT cursor_4c_Etiquetas
1242: 		*-- Se ja existe linha em branco no final, apenas posiciona nela
1243: 		GO BOTTOM
1244: 		IF EMPTY(cursor_4c_Etiquetas.Cpros)
1245: 			THIS.grd_4c_Etiquetas.Refresh()
1246: 			THIS.grd_4c_Etiquetas.SetFocus()
1247: 			RETURN
1248: 		ENDIF
1249: 		*-- Adiciona nova linha em branco para digitacao
1250: 		APPEND BLANK
1251: 		GO BOTTOM
1252: 		THIS.grd_4c_Etiquetas.Refresh()
1253: 		THIS.grd_4c_Etiquetas.SetFocus()
1254: 	ENDPROC
1255: 
1256: 	*====================================================================

*-- Linhas 1263 a 1281:
1263: 			MsgAviso("Nenhum item para alterar.", "Aten" + CHR(231) + CHR(227) + "o")
1264: 			RETURN
1265: 		ENDIF
1266: 		SELECT cursor_4c_Etiquetas
1267: 		IF EOF() OR BOF()
1268: 			GO TOP
1269: 		ENDIF
1270: 		THIS.grd_4c_Etiquetas.Refresh()
1271: 		THIS.grd_4c_Etiquetas.SetFocus()
1272: 		*-- Tenta focar na primeira coluna editavel (Cpros)
1273: 		IF PEMSTATUS(THIS.grd_4c_Etiquetas, "Column1", 5) AND ;
1274: 		   VARTYPE(THIS.grd_4c_Etiquetas.Column1) = "O"
1275: 			IF PEMSTATUS(THIS.grd_4c_Etiquetas.Column1, "Text1", 5) AND ;
1276: 			   VARTYPE(THIS.grd_4c_Etiquetas.Column1.Text1) = "O"
1277: 				THIS.grd_4c_Etiquetas.Column1.Text1.SetFocus()
1278: 			ENDIF
1279: 		ENDIF
1280: 	ENDPROC
1281: 

*-- Linhas 1290 a 1308:
1290: 			MsgAviso("Nenhum item na lista.", "Aten" + CHR(231) + CHR(227) + "o")
1291: 			RETURN
1292: 		ENDIF
1293: 		SELECT cursor_4c_Etiquetas
1294: 		loc_nTotal    = 0
1295: 		loc_nQtdTotal = 0
1296: 		SCAN FOR !EMPTY(cursor_4c_Etiquetas.Cpros)
1297: 			loc_nTotal    = loc_nTotal + 1
1298: 			loc_nQtdTotal = loc_nQtdTotal + NVL(cursor_4c_Etiquetas.Qtds, 0)
1299: 		ENDSCAN
1300: 		GO TOP
1301: 		THIS.grd_4c_Etiquetas.Refresh()
1302: 		THIS.grd_4c_Etiquetas.SetFocus()
1303: 		loc_cMensagem = "Itens selecionados: " + TRANSFORM(loc_nTotal) + CHR(13) + ;
1304: 		                "Quantidade total: " + TRANSFORM(loc_nQtdTotal, "@Z 9,999,999.999")
1305: 		MsgInfo(loc_cMensagem, "Resumo da Sele" + CHR(231) + CHR(227) + "o")
1306: 	ENDPROC
1307: 
1308: 	*====================================================================

*-- Linhas 1314 a 1356:
1314: 			MsgAviso("Nenhum item para excluir.", "Aten" + CHR(231) + CHR(227) + "o")
1315: 			RETURN
1316: 		ENDIF
1317: 		SELECT cursor_4c_Etiquetas
1318: 		IF EOF() OR BOF() OR EMPTY(cursor_4c_Etiquetas.Cpros)
1319: 			MsgAviso("Selecione um item v" + CHR(225) + "lido para excluir.", ;
1320: 			         "Aten" + CHR(231) + CHR(227) + "o")
1321: 			RETURN
1322: 		ENDIF
1323: 		IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do item selecionado?", ;
1324: 		                "Confirma" + CHR(231) + CHR(227) + "o")
1325: 			RETURN
1326: 		ENDIF
1327: 		THIS.CmdBtnExcluirClick()
1328: 	ENDPROC
1329: 
1330: 	*====================================================================
1331: 	* BtnImprimirClick - Coleta parametros dos controles e chama BO
1332: 	*====================================================================
1333: 	PROCEDURE BtnImprimirClick()
1334: 		IF !USED("cursor_4c_Etiquetas")
1335: 			MsgAviso("Nenhum item na lista.", "Aten" + CHR(231) + CHR(227) + "o")
1336: 			RETURN
1337: 		ENDIF
1338: 		SELECT cursor_4c_Etiquetas
1339: 		LOCATE FOR EMPTY(cursor_4c_Etiquetas.Cpros)
1340: 		IF FOUND()
1341: 			DELETE
1342: 			PACK
1343: 		ENDIF
1344: 		IF RECCOUNT("cursor_4c_Etiquetas") = 0
1345: 			MsgAviso("Nenhum produto adicionado para impress" + CHR(227) + "o.", ;
1346: 			         "Aten" + CHR(231) + CHR(227) + "o")
1347: 			APPEND BLANK
1348: 			RETURN
1349: 		ENDIF
1350: 		GO TOP
1351: 
1352: 		*-- Coleta parametros dos controles de configuracao
1353: 		LOCAL loc_nImpPreco, loc_lImpSepar, loc_lImpPeso, loc_lCompo
1354: 		LOCAL loc_nTpEti, loc_nTpImp, loc_nAjVerts, loc_nAjHorzs
1355: 		LOCAL loc_nAjDenss, loc_nAjVelos, loc_cNomeImp, loc_nOrdem
1356: 		LOCAL loc_cLp1, loc_cLp2

*-- Linhas 1432 a 1450:
1432: 				loc_cLp1, loc_cLp2)
1433: 		ENDIF
1434: 
1435: 		SELECT cursor_4c_Etiquetas
1436: 		IF RECCOUNT("cursor_4c_Etiquetas") = 0 OR !EMPTY(cursor_4c_Etiquetas.Cpros)
1437: 			APPEND BLANK
1438: 		ENDIF
1439: 		THIS.grd_4c_Etiquetas.Refresh()
1440: 	ENDPROC
1441: 
1442: 	*====================================================================
1443: 	* BtnEncerrarClick - Fecha o formulario
1444: 	*====================================================================
1445: 	PROCEDURE BtnEncerrarClick()
1446: 		THIS.Release()
1447: 	ENDPROC
1448: 
1449: 	*====================================================================
1450: 	* ConfigurarPaginaDados - Secao inferior: tipo etiqueta e impressora

*-- Linhas 2102 a 2132:
2102: 		IF !USED("cursor_4c_TiposEtq")
2103: 			RETURN
2104: 		ENDIF
2105: 		SELECT cursor_4c_TiposEtq
2106: 		LOCAL loc_nCount, loc_nTopo, loc_i, loc_cCaption
2107: 		loc_nCount = RECCOUNT("cursor_4c_TiposEtq")
2108: 		IF loc_nCount = 0
2109: 			RETURN
2110: 		ENDIF
2111: 		*-- Adiciona botoes conforme tipos retornados pelo BO (1 por linha)
2112: 		WITH THIS.obj_4c_Opt_Tipo
2113: 			.ButtonCount = loc_nCount
2114: 			loc_nTopo    = 10
2115: 			GO TOP IN cursor_4c_TiposEtq
2116: 			FOR loc_i = 1 TO loc_nCount
2117: 				SELECT cursor_4c_TiposEtq
2118: 				loc_cCaption = ALLTRIM(NVL(cursor_4c_TiposEtq.cEtiquetas, "Tipo " + TRANSFORM(loc_i)))
2119: 				WITH .Buttons(loc_i)
2120: 					.BackStyle = 0
2121: 					.Caption   = loc_cCaption
2122: 					.Tag       = TRANSFORM(NVL(cursor_4c_TiposEtq.nTipos, loc_i))
2123: 					.Height    = 16
2124: 					.Left      = 9
2125: 					.Style     = 0
2126: 					.Top       = loc_nTopo
2127: 					.Width     = 197
2128: 					.ForeColor = RGB(90, 90, 90)
2129: 				ENDWITH
2130: 				loc_nTopo = loc_nTopo + 18
2131: 				SKIP IN cursor_4c_TiposEtq
2132: 			ENDFOR

*-- Linhas 2507 a 2545:
2507: 			THIS.txt_4c_Qtds.Value = 0
2508: 		ENDIF
2509: 		IF USED("cursor_4c_Etiquetas")
2510: 			SELECT cursor_4c_Etiquetas
2511: 			ZAP
2512: 			APPEND BLANK
2513: 			GO TOP
2514: 		ENDIF
2515: 		IF PEMSTATUS(THIS, "grd_4c_Etiquetas", 5) AND VARTYPE(THIS.grd_4c_Etiquetas) = "O"
2516: 			THIS.grd_4c_Etiquetas.Refresh()
2517: 		ENDIF
2518: 		IF PEMSTATUS(THIS, "txt_4c_Emps", 5) AND VARTYPE(THIS.txt_4c_Emps) = "O"
2519: 			THIS.txt_4c_Emps.SetFocus()
2520: 		ENDIF
2521: 	ENDPROC
2522: 
2523: 	*====================================================================
2524: 	* CarregarLista - Reposiciona no topo e atualiza grid (OPERACIONAL)
2525: 	*====================================================================
2526: 	PROCEDURE CarregarLista()
2527: 		IF !USED("cursor_4c_Etiquetas")
2528: 			RETURN
2529: 		ENDIF
2530: 		SELECT cursor_4c_Etiquetas
2531: 		GO TOP
2532: 		IF PEMSTATUS(THIS, "grd_4c_Etiquetas", 5) AND VARTYPE(THIS.grd_4c_Etiquetas) = "O"
2533: 			THIS.grd_4c_Etiquetas.Refresh()
2534: 		ENDIF
2535: 	ENDPROC
2536: 
2537: 	*====================================================================
2538: 	* AjustarBotoesPorModo - Stub (OPERACIONAL nao tem modos CRUD)
2539: 	*====================================================================
2540: 	PROCEDURE AjustarBotoesPorModo()
2541: 		RETURN
2542: 	ENDPROC
2543: 
2544: 	*====================================================================
2545: 	* BtnBuscarClick - Carrega itens da lista por empresa/operacao/numes


### BO (C:\4c\projeto\app\classes\SigPrEtqBO.prg):
*==============================================================================
* SigPrEtqBO.prg - Business Object para Impressao de Etiquetas Selecionadas
* Herda de: BusinessBase
*==============================================================================
DEFINE CLASS SigPrEtqBO AS BusinessBase

    *-- Identificacao (sem tabela primaria - form OPERACIONAL)
    this_cTabela      = ""
    this_cCampoChave  = ""

    *-- Filtros do cabecalho (campos de selecao do form)
    this_cEmps        = ""    && Empresa (C3)
    this_cDopes       = ""    && Operacao (C20)
    this_nNumes       = 0     && Numero da operacao (N6)
    this_cLpreco      = ""    && Lista de Precos 1 (C30)
    this_cLpreco2     = ""    && Lista de Precos 2 (C30)

    *-- Configuracoes de impressao (lidas de SigCdPam / SigCdPac)
    this_nTpEti       = 0     && Tipo de etiqueta selecionado
    this_nTpImp       = 1     && Tipo de impressora (1=Allegro, 2=ZPL, 3=EPL)
    this_nAjVerts     = 0     && Ajuste vertical
    this_nAjHorzs     = 0     && Ajuste horizontal
    this_nAjDenss     = 20    && Densidade
    this_nAjVelos     = 1     && Velocidade
    this_cNomeImp     = ""    && Nome da impressora selecionada
    this_nMaxTpEtis   = 7     && Maximo de tipos de etiqueta (de SigCdPam)
    this_nTpEtiPadrao = 1     && Tipo padrao (TpEtiPads em SigCdPam)

    *-- Opcoes de impressao selecionadas pelo usuario
    this_nImpPreco    = 1     && Opcao de preco (1=Sim, 2=Nao, 3=Ideal, 4=Atual, 5=PrecoDe/Por, 6=Parcelamento)
    this_lImpSepar    = .T.   && Imprimir separadora (opt_separador)
    this_lImpPeso     = .T.   && Imprimir peso (opt_peso)
    this_lCompo       = .T.   && Imprimir composicao (optCompos)
    this_nOrdem       = 1     && Ordenacao (1=Produto, 2=Nenhuma)

    *-- Estado interno
    this_lCarregouItens = .F. && Flag: itens foram carregados no cursor
    this_cBop           = ""  && Codigo BOP para impressao (Ndopes padded + Numes padded)

    *-- Item corrente do grid (cursor_4c_Etiquetas - campos de dbImpressao)
    this_cItemCpros      = ""    && Codigo produto (C14)
    this_cItemDpros      = ""    && Descricao produto (C40)
    this_cItemDpro2s     = ""    && Descritivo/Referencia fornecedor (C45)
    this_cItemReffs      = ""    && Referencia interna (C40)
    this_nItemQtds       = 0     && Quantidade (N10,3)
    this_nItemQtdeEtiq   = 0     && Quantidade de etiquetas (N10,3)
    this_cItemObs        = ""    && Observacao/codigo lista de precos (C10)
    this_cItemPedido     = ""    && Pedido (C30)
    this_nItemPvens      = 0     && Preco de venda (N12,2)
    this_nItemPrecoDe    = 0     && Preco DE (N12,2)
    this_nItemParcelas   = 0     && Parcelas (N2,0)
    this_cItemEmpos      = ""    && Empresa (C3)
    this_cItemEmpdopnums = ""    && Chave EmpDopNums (C29)
    this_nItemCitens     = 0     && Numero do item/citens (N10)
    this_nItemPesos      = 0     && Peso medio (N12,2)
    this_cItemCodTams    = ""    && Codigo tamanho (C4)
    this_cItemCpros2     = ""    && Produto alternativo 2 (C14)
    this_cItemCpros3     = ""    && Produto alternativo 3 (C14)
    this_cItemCpros4     = ""    && Produto alternativo 4 (C14)

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna codigo do produto atual como chave de auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cItemCpros)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarConfiguracoes - Le SigCdPam e SigCdPac para configurar impressora
    * Retorna .T. se leu com sucesso
    *--------------------------------------------------------------------------
    FUNCTION CarregarConfiguracoes()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            LOCAL loc_cSql, loc_cCpos

            loc_cCpos = "nMaxTpEtis, TpEtiPads, nMaxImpEti, ImpEtis, TpInstalas, AjVerts, AjHorzs, TpCBars"
            loc_cSql = "SELECT " + loc_cCpos + " FROM SigCdPam"

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_Pam") > 0
                IF USED("cursor_4c_Pam") AND !EOF("cursor_4c_Pam")
                    SELECT cursor_4c_Pam
                    GO TOP
                    THIS.this_nMaxTpEtis   = NVL(cursor_4c_Pam.nMaxTpEtis, 7)
                    THIS.this_nTpEtiPadrao = NVL(cursor_4c_Pam.TpEtiPads, 1)
                    THIS.this_nAjVerts     = NVL(cursor_4c_Pam.AjVerts, 0)
                    THIS.this_nAjHorzs     = NVL(cursor_4c_Pam.AjHorzs, 0)
                    THIS.this_nTpImp       = IIF(NVL(cursor_4c_Pam.ImpEtis, 0) <> 0, NVL(cursor_4c_Pam.ImpEtis, 1), 1)
                ENDIF
            ENDIF

            LOCAL loc_cSqlPac
            loc_cSqlPac = "SELECT AjDens, AjVelos, EtqSeps FROM SigCdPac"

            IF SQLEXEC(gnConnHandle, loc_cSqlPac, "cursor_4c_Pac") > 0
                IF USED("cursor_4c_Pac") AND !EOF("cursor_4c_Pac")
                    SELECT cursor_4c_Pac
                    GO TOP
                    THIS.this_nAjDenss = IIF(EMPTY(cursor_4c_Pac.AjDens), 20, NVL(cursor_4c_Pac.AjDens, 20))
                    THIS.this_nAjVelos = IIF(EMPTY(cursor_4c_Pac.AjVelos), 1, NVL(cursor_4c_Pac.AjVelos, 1))
                    THIS.this_lImpSepar = (NVL(cursor_4c_Pac.EtqSeps, 1) = 1)
                ENDIF
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar configura" + CHR(231) + CHR(245) + "es")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarTiposEtiqueta - Le SigCdTpe e retorna cursor cursor_4c_TiposEtq
    * Retorna contagem de tipos ativos ou -1 em erro
    *--------------------------------------------------------------------------
    FUNCTION CarregarTiposEtiqueta()
        LOCAL loc_nTipos, loc_oErro
        loc_nTipos = -1

        TRY
            LOCAL loc_cSql
            loc_cSql = "SELECT nTipos, cEtiquetas, cOrdems, nSituas " + ;
                       "FROM SigCdTpe " + ;
                       "WHERE nSituas = 1 " + ;
                       "ORDER BY cOrdems, cEtiquetas"

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_TiposEtq") > 0
                IF USED("cursor_4c_TiposEtq")
                    loc_nTipos = RECCOUNT("cursor_4c_TiposEtq")
                ELSE
                    loc_nTipos = 0
                ENDIF
            ELSE
                loc_nTipos = 0
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar tipos de etiqueta")
            loc_nTipos = -1
        ENDTRY

        RETURN loc_nTipos
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarImpressoras - Le impressoras do sistema e do Windows
    * Preenche cursor_4c_Impressoras com IDupla, impres, impresS
    * Retorna contagem de impressoras ou -1 em erro
    *--------------------------------------------------------------------------
    FUNCTION CarregarImpressoras()
        LOCAL loc_nImpressoras, loc_oErro
        loc_nImpressoras = -1

        TRY
            LOCAL loc_cSql, loc_cSqlGrupo

            *-- Impressoras do sistema autorizadas ao usuario via usuario direto
            loc_cSql = "SELECT b.Impres " + ;
                       "FROM SigSyImp a, SigCdmp b " + ;
                       "WHERE a.UsuAcess = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                       " AND a.CImps = b.Impres AND b.nTpImpres = 2 " + ;
                       "UNION ALL " + ;
                       "SELECT c.Impres " + ;
                       "FROM SigCdAcG a, SigSyImp b, SigCdmp c " + ;
                       "WHERE a.Usuarios = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                       " AND a.Grupos = b.GrAcess " + ;
                       "AND b.CImps = c.Impres AND c.nTpImpres = 2"

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_TmpCimp") <= 0
                *-- Fallback: todas as impressoras de etiqueta
                LOCAL loc_cSqlAll
                loc_cSqlAll = "SELECT DISTINCT Impres FROM SigCdmp WHERE nTpImpres = 2 ORDER BY Impres"
                IF SQLEXEC(gnConnHandle, loc_cSqlAll, "cursor_4c_TmpCimp") < 1
                    loc_nImpressoras = 0
                    loc_lSucesso = loc_nImpressoras
                ENDIF
            ENDIF

            *-- Obtem impressoras distintas autorizadas
            IF USED("cursor_4c_TmpCimp") AND RECCOUNT("cursor_4c_TmpCimp") > 0
                SELECT DISTINCT Impres FROM cursor_4c_TmpCimp ORDER BY Impres INTO CURSOR cursor_4c_SigCdmp READWRITE
            ELSE
                LOCAL loc_cSqlAll2
                loc_cSqlAll2 = "SELECT DISTINCT Impres FROM SigCdmp WHERE nTpImpres = 2 ORDER BY Impres"
                IF SQLEXEC(gnConnHandle, loc_cSqlAll2, "cursor_4c_SigCdmp") < 1
                    loc_nImpressoras = 0
                    loc_lSucesso = loc_nImpressoras
                ENDIF
            ENDIF

            IF USED("cursor_4c_TmpCimp")
                USE IN cursor_4c_TmpCimp
            ENDIF

            loc_nImpressoras = IIF(USED("cursor_4c_SigCdmp"), RECCOUNT("cursor_4c_SigCdmp"), 0)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar impressoras")
            loc_nImpressoras = -1
        ENDTRY

        RETURN loc_nImpressoras
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarProdutoPorCodigo - Busca produto por CPros em SigCdPro
    * Preenche cursor_4c_Produto com dados do produto
    * Retorna .T. se encontrou
    *--------------------------------------------------------------------------
    FUNCTION BuscarProdutoPorCodigo(par_cCodigo)
        LOCAL loc_lEncontrou, loc_oErro
        loc_lEncontrou = .F.

        TRY
            IF USED("cursor_4c_Produto")
                USE IN cursor_4c_Produto
            ENDIF

            LOCAL loc_cSql
            loc_cSql = "SELECT CPros, DPros, Dpro2s, PVens, PrecoDe, PesoMs, CUnis, Ean13, CBars " + ;
                       "FROM SigCdPro " + ;
                       "WHERE CPros = " + EscaparSQL(PADR(par_cCodigo, 14))

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_Produto") > 0
                IF USED("cursor_4c_Produto") AND !EOF("cursor_4c_Produto")
                    loc_lEncontrou = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar produto")
        ENDTRY

        RETURN loc_lEncontrou
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarProdutoPorDescricao - Busca produto por DPros em SigCdPro
    * Preenche cursor_4c_ProdutoBusca
    * Retorna .T. se encontrou exato, .F. se abriu picker
    *--------------------------------------------------------------------------
    FUNCTION BuscarProdutoPorDescricao(par_cDescricao)
        LOCAL loc_lEncontrou, loc_oErro
        loc_lEncontrou = .F.

        TRY
            IF USED("cursor_4c_ProdutoBusca")
                USE IN cursor_4c_ProdutoBusca
            ENDIF

            LOCAL loc_cSql
            loc_cSql = "SELECT TOP 1 CPros, DPros, Dpro2s " + ;
                       "FROM SigCdPro " + ;
                       "WHERE DPros = " + EscaparSQL(par_cDescricao)

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_ProdutoBusca") > 0
                IF USED("cursor_4c_ProdutoBusca") AND !EOF("cursor_4c_ProdutoBusca")
                    loc_lEncontrou = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar produto por descri" + CHR(231) + CHR(227) + "o")
        ENDTRY

        RETURN loc_lEncontrou
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarProdutoPorEan - Busca produto por EAN13/codigo de barras
    * Retorna CPros encontrado ou "" se nao encontrou
    *--------------------------------------------------------------------------
    FUNCTION BuscarProdutoPorEan(par_nEan)
        LOCAL loc_cCodigo, loc_oErro
        loc_cCodigo = ""

        TRY
            LOCAL loc_cSql
            loc_cSql = "SELECT CPros FROM SigCdPro WHERE Ean13 = " + FormatarNumeroSQL(par_nEan, 0)

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_ProdEan") > 0
                IF USED("cursor_4c_ProdEan") AND !EOF("cursor_4c_ProdEan")
                    loc_cCodigo = ALLTRIM(cursor_4c_ProdEan.CPros)
                ENDIF
            ENDIF

            IF USED("cursor_4c_ProdEan")
                USE IN cursor_4c_ProdEan
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar EAN")
        ENDTRY

        RETURN loc_cCodigo
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarProdutoPorCodigoBarras - Busca por CBars (codigo de barras numerico)
    * Retorna CPros encontrado ou "" se nao encontrou
    *--------------------------------------------------------------------------
    FUNCTION BuscarProdutoPorCodigoBarras(par_nCBars)
        LOCAL loc_cCodigo, loc_oErro
        loc_cCodigo = ""

        TRY
            LOCAL loc_cSql
            loc_cSql = "SELECT CPros FROM SigCdPro WHERE CBars = " + FormatarNumeroSQL(INT(VAL(TRANSFORM(par_nCBars))), 0)

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_ProdCBars") > 0
                IF USED("cursor_4c_ProdCBars") AND !EOF("cursor_4c_ProdCBars")
                    loc_cCodigo = ALLTRIM(cursor_4c_ProdCBars.CPros)
                ENDIF
            ENDIF

            IF USED("cursor_4c_ProdCBars")
                USE IN cursor_4c_ProdCBars
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar por c" + CHR(243) + "digo de barras")
        ENDTRY

        RETURN loc_cCodigo
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarUnidadeProduto - Verifica se produto usa etiqueta individual
    * Retorna .T. se produto PODE ser impresso em etiqueta selecionada
    * Retorna .F. se deve usar reimp. individual (Etiqs='S' e EtiqDups<>1)
    *--------------------------------------------------------------------------
    FUNCTION ValidarUnidadeProduto(par_cCpros, par_cCUnis)
        LOCAL loc_lPermitido, loc_oErro
        loc_lPermitido = .T.

        TRY
            IF EMPTY(par_cCUnis)
                loc_lSucesso = .T.
            ENDIF

            LOCAL loc_cSql
            loc_cSql = "SELECT Etiqs, EtiqDups FROM SigCdUni WHERE CUnis = " + EscaparSQL(par_cCUnis)

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_Unidade") > 0
                IF USED("cursor_4c_Unidade") AND !EOF("cursor_4c_Unidade")
                    SELECT cursor_4c_Unidade
                    IF ALLTRIM(cursor_4c_Unidade.Etiqs) = "S" AND NVL(cursor_4c_Unidade.EtiqDups, 0) <> 1
                        loc_lPermitido = .F.
                    ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_Unidade")
                USE IN cursor_4c_Unidade
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar unidade do produto")
        ENDTRY

        RETURN loc_lPermitido
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarListaPrecos - Busca em SigCdLpc por codigo de lista
    * Preenche cursor_4c_ListaPrecos
    * Retorna .T. se encontrou
    *--------------------------------------------------------------------------
    FUNCTION BuscarListaPrecos(par_cLista)
        LOCAL loc_lEncontrou, loc_oErro
        loc_lEncontrou = .F.

        TRY
            IF USED("cursor_4c_ListaPrecos")
                USE IN cursor_4c_ListaPrecos
            ENDIF

            LOCAL loc_cSql
            loc_cSql = "SELECT LPrecos FROM SigCdLpc WHERE LPrecos = " + EscaparSQL(par_cLista)

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_ListaPrecos") > 0
                IF USED("cursor_4c_ListaPrecos") AND !EOF("cursor_4c_ListaPrecos")
                    loc_lEncontrou = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar lista de pre" + CHR(231) + "os")
        ENDTRY

        RETURN loc_lEncontrou
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarItensDaLista - Carrega itens de SigCdLpi para dbImpressao
    * par_cLista: codigo da lista de precos (C30)
    * Preenche cursor cursor_4c_ItensDaLista
    * Retorna contagem de itens carregados
    *--------------------------------------------------------------------------
    FUNCTION CarregarItensDaLista(par_cLista)
        LOCAL loc_nItens, loc_oErro
        loc_nItens = 0

        TRY
            IF USED("cursor_4c_ItensDaLista")
                USE IN cursor_4c_ItensDaLista
            ENDIF

            LOCAL loc_cSql
            loc_cSql = "SELECT LPrecos, CPros, DPros, PVens, Precode, VencIs, VencFs " + ;
                       "FROM SigCdLpi " + ;
                       "WHERE LPrecos = " + EscaparSQL(PADR(par_cLista, 30))

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_ItensDaLista") > 0
                IF USED("cursor_4c_ItensDaLista")
                    loc_nItens = RECCOUNT("cursor_4c_ItensDaLista")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar itens da lista de pre" + CHR(231) + "os")
        ENDTRY

        RETURN loc_nItens
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarPrecoListaPorProduto - Busca preco de lista especifica para produto
    * Retorna .T. se encontrou registro valido
    *--------------------------------------------------------------------------
    FUNCTION BuscarPrecoListaPorProduto(par_cLista, par_cCpros)
        LOCAL loc_lEncontrou, loc_oErro
        loc_lEncontrou = .F.

        TRY
            IF USED("cursor_4c_PrecoLista")
                USE IN cursor_4c_PrecoLista
            ENDIF

            LOCAL loc_cSql
            loc_cSql = "SELECT LPrecos, CPros, DPros, PVens, PrecoDe, VencIs, VencFs " + ;
                       "FROM SigCdLpi " + ;
                       "WHERE LPrecos = " + EscaparSQL(PADR(par_cLista, 30)) + ;
                       " AND CPros = " + EscaparSQL(PADR(par_cCpros, 14))

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_PrecoLista") > 0
                IF USED("cursor_4c_PrecoLista") AND !EOF("cursor_4c_PrecoLista")
                    loc_lEncontrou = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar pre" + CHR(231) + "o da lista")
        ENDTRY

        RETURN loc_lEncontrou
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarItensDaOperacao - Carrega itens de SigMvItn por EmpDopNums
    * par_cEdn: chave concatenada Emps(3)+Dopes(20)+Numes(6)
    * Preenche cursor_4c_ItensOp
    * Retorna contagem de itens ou -1 em erro
    *--------------------------------------------------------------------------
    FUNCTION CarregarItensDaOperacao(par_cEdn)
        LOCAL loc_nItens, loc_oErro
        loc_nItens = -1

        TRY
            IF USED("cursor_4c_ItensOp")
                USE IN cursor_4c_ItensOp
            ENDIF

            LOCAL loc_cSql
            loc_cSql = "SELECT CPros, DPros, Units, Qtds, Citens " + ;
                       "FROM SigMvItn " + ;
                       "WHERE EmpDopNums = " + EscaparSQL(par_cEdn)

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_ItensOp") > 0
                IF USED("cursor_4c_ItensOp")
                    loc_nItens = RECCOUNT("cursor_4c_ItensOp")
                ELSE
                    loc_nItens = 0
                ENDIF
            ELSE
                loc_nItens = 0
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar itens da opera" + CHR(231) + CHR(227) + "o")
            loc_nItens = -1
        ENDTRY

        RETURN loc_nItens
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarDadosProdutoParaImpressao - Le PVens, PrecoDe, PesoMs de SigCdPro
    * Retorna .T. se encontrou
    *--------------------------------------------------------------------------
    FUNCTION BuscarDadosProdutoParaImpressao(par_cCpros)
        LOCAL loc_lEncontrou, loc_oErro
        loc_lEncontrou = .F.

        TRY
            IF USED("cursor_4c_DadosProd")
                USE IN cursor_4c_DadosProd
            ENDIF

            LOCAL loc_cSql
            loc_cSql = "SELECT PVens, PrecoDe, PesoMs " + ;
                       "FROM SigCdPro " + ;
                       "WHERE CPros = " + EscaparSQL(PADR(par_cCpros, 14))

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_DadosProd") > 0
                IF USED("cursor_4c_DadosProd") AND !EOF("cursor_4c_DadosProd")
                    loc_lEncontrou = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar dados do produto para impress" + CHR(227) + "o")
        ENDTRY

        RETURN loc_lEncontrou
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarNumeracaoOperacao - Busca NDopes em SigCdOpe para montar lcBop
    * par_cDopes: codigo da operacao (C20)
    * Retorna NDopes ou "" se nao encontrou
    *--------------------------------------------------------------------------
    FUNCTION BuscarNumeracaoOperacao(par_cDopes)
        LOCAL loc_cNDopes, loc_oErro
        loc_cNDopes = ""

        TRY
            LOCAL loc_cSql
            loc_cSql = "SELECT NDopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(par_cDopes)

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_Ope") > 0
                IF USED("cursor_4c_Ope") AND !EOF("cursor_4c_Ope")
                    loc_cNDopes = ALLTRIM(NVL(cursor_4c_Ope.NDopes, ""))
                ENDIF
            ENDIF

            IF USED("cursor_4c_Ope")
                USE IN cursor_4c_Ope
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar opera" + CHR(231) + CHR(227) + "o")
        ENDTRY

        RETURN loc_cNDopes
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarCodigoBop - Monta codigo BOP para chamada SigOpEtq
    * par_cDopes: operacao, par_nNumes: numero
    * Seta this_cBop e retorna valor
    *--------------------------------------------------------------------------
    FUNCTION MontarCodigoBop(par_cDopes, par_nNumes)
        LOCAL loc_cBop, loc_cNDopes

        loc_cBop = ""

        IF !EMPTY(par_cDopes) AND par_nNumes > 0
            loc_cNDopes = THIS.BuscarNumeracaoOperacao(par_cDopes)
            IF !EMPTY(loc_cNDopes)
                loc_cBop = PADL(loc_cNDopes, 4, "0") + PADL(TRANSFORM(par_nNumes), 6, "0")
            ENDIF
        ENDIF

        THIS.this_cBop = loc_cBop
        RETURN loc_cBop
    ENDFUNC

    *--------------------------------------------------------------------------
    * FecharCursoresTemporarios - Fecha cursores auxiliares usados durante carga
    *--------------------------------------------------------------------------
    PROCEDURE FecharCursoresTemporarios()
        LOCAL loc_aCursores(15), loc_i

        loc_aCursores(1)  = "cursor_4c_Pam"
        loc_aCursores(2)  = "cursor_4c_Pac"
        loc_aCursores(3)  = "cursor_4c_TiposEtq"
        loc_aCursores(4)  = "cursor_4c_SigCdmp"
        loc_aCursores(5)  = "cursor_4c_TmpCimp"
        loc_aCursores(6)  = "cursor_4c_Produto"
        loc_aCursores(7)  = "cursor_4c_ProdutoBusca"
        loc_aCursores(8)  = "cursor_4c_ProdEan"
        loc_aCursores(9)  = "cursor_4c_ProdCBars"
        loc_aCursores(10) = "cursor_4c_Unidade"
        loc_aCursores(11) = "cursor_4c_ListaPrecos"
        loc_aCursores(12) = "cursor_4c_ItensDaLista"
        loc_aCursores(13) = "cursor_4c_PrecoLista"
        loc_aCursores(14) = "cursor_4c_ItensOp"
        loc_aCursores(15) = "cursor_4c_DadosProd"

        FOR loc_i = 1 TO 15
            IF USED(loc_aCursores(loc_i))
                USE IN (loc_aCursores(loc_i))
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia TODAS as 19 colunas do cursor para propriedades
    * par_cAlias: nome do cursor (normalmente "cursor_4c_Etiquetas")
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAlias)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAlias)
            SELECT (par_cAlias)
            THIS.this_cItemCpros      = ALLTRIM(NVL(Cpros,      ""))
            THIS.this_cItemDpros      = ALLTRIM(NVL(DPros,      ""))
            THIS.this_cItemDpro2s     = ALLTRIM(NVL(DPro2s,     ""))
            THIS.this_cItemReffs      = ALLTRIM(NVL(Reffs,      ""))
            THIS.this_nItemQtds       = NVL(Qtds,       0)
            THIS.this_nItemQtdeEtiq   = NVL(QtdeEtiq,   0)
            THIS.this_cItemObs        = ALLTRIM(NVL(Obs,        ""))
            THIS.this_cItemPedido     = ALLTRIM(NVL(Pedido,     ""))
            THIS.this_nItemPvens      = NVL(PVens,      0)
            THIS.this_nItemPrecoDe    = NVL(PrecoDe,    0)
            THIS.this_nItemParcelas   = NVL(Parcelas,   0)
            THIS.this_cItemEmpos      = ALLTRIM(NVL(empos,      ""))
            THIS.this_cItemEmpdopnums = ALLTRIM(NVL(empdopnums, ""))
            THIS.this_nItemCitens     = NVL(citens,     0)
            THIS.this_nItemPesos      = NVL(Pesos,      0)
            THIS.this_cItemCodTams    = ALLTRIM(NVL(CodTams,    ""))
            THIS.this_cItemCpros2     = ALLTRIM(NVL(Cpros2,     ""))
            THIS.this_cItemCpros3     = ALLTRIM(NVL(Cpros3,     ""))
            THIS.this_cItemCpros4     = ALLTRIM(NVL(Cpros4,     ""))
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida propriedades do item antes de Inserir/Atualizar
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarDados()
        THIS.this_cMensagemErro = ""

        IF EMPTY(ALLTRIM(THIS.this_cItemCpros))
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo do produto n" + CHR(227) + "o informado."
            RETURN .F.
        ENDIF

        IF THIS.this_nItemQtds <= 0
            THIS.this_cMensagemErro = "Quantidade inv" + CHR(225) + "lida. Informe valor maior que zero."
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO cursor_4c_Etiquetas com todos os campos do item
    * Equivalente ao Insert Into dbImpressao do legado
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ENDIF

            IF !USED("cursor_4c_Etiquetas")
                THIS.this_cMensagemErro = "Cursor de etiquetas n" + CHR(227) + "o est" + CHR(225) + " aberto."
                loc_lSucesso = .F.
            ENDIF

            INSERT INTO cursor_4c_Etiquetas ;
                (Cpros, DPros, Reffs, Qtds, QtdeEtiq, ;
                 Pedido, Obs, PVens, PrecoDe, Parcelas, ;
                 Cpros2, Cpros3, Cpros4, empos, empdopnums, ;
                 citens, Pesos, CodTams, DPro2s) ;
                VALUES ;
                (PADR(THIS.this_cItemCpros, 14), ;
                 LEFT(THIS.this_cItemDpros, 40), ;
                 LEFT(THIS.this_cItemReffs, 40), ;
                 THIS.this_nItemQtds, ;
                 THIS.this_nItemQtdeEtiq, ;
                 LEFT(THIS.this_cItemPedido, 30), ;
                 LEFT(THIS.this_cItemObs, 10), ;
                 THIS.this_nItemPvens, ;
                 THIS.this_nItemPrecoDe, ;
                 INT(THIS.this_nItemParcelas), ;
                 PADR(THIS.this_cItemCpros2, 14), ;
                 PADR(THIS.this_cItemCpros3, 14), ;
                 PADR(THIS.this_cItemCpros4, 14), ;
                 LEFT(THIS.this_cItemEmpos, 3), ;
                 LEFT(THIS.this_cItemEmpdopnums, 29), ;
                 THIS.this_nItemCitens, ;
                 THIS.this_nItemPesos, ;
                 LEFT(THIS.this_cItemCodTams, 4), ;
                 LEFT(THIS.this_cItemDpro2s, 45))

            THIS.RegistrarAuditoria("INCLUIR")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao inserir etiqueta")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - REPLACE na linha corrente de cursor_4c_Etiquetas
    * Equivalente ao Replace ... In dbImpressao do legado
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ENDIF

            IF !USED("cursor_4c_Etiquetas")
                THIS.this_cMensagemErro = "Cursor de etiquetas n" + CHR(227) + "o est" + CHR(225) + " aberto."
                loc_lSucesso = .F.
            ENDIF

            SELECT cursor_4c_Etiquetas
            REPLACE Cpros      WITH PADR(THIS.this_cItemCpros, 14), ;
                    DPros      WITH LEFT(THIS.this_cItemDpros, 40), ;
                    Reffs      WITH LEFT(THIS.this_cItemReffs, 40), ;
                    Qtds       WITH THIS.this_nItemQtds, ;
                    QtdeEtiq   WITH THIS.this_nItemQtdeEtiq, ;
                    Pedido     WITH LEFT(THIS.this_cItemPedido, 30), ;
                    Obs        WITH LEFT(THIS.this_cItemObs, 10), ;
                    PVens      WITH THIS.this_nItemPvens, ;
                    PrecoDe    WITH THIS.this_nItemPrecoDe, ;
                    Parcelas   WITH INT(THIS.this_nItemParcelas), ;
                    Cpros2     WITH PADR(THIS.this_cItemCpros2, 14), ;
                    Cpros3     WITH PADR(THIS.this_cItemCpros3, 14), ;
                    Cpros4     WITH PADR(THIS.this_cItemCpros4, 14), ;
                    empos      WITH LEFT(THIS.this_cItemEmpos, 3), ;
                    empdopnums WITH LEFT(THIS.this_cItemEmpdopnums, 29), ;
                    citens     WITH THIS.this_nItemCitens, ;
                    Pesos      WITH THIS.this_nItemPesos, ;
                    CodTams    WITH LEFT(THIS.this_cItemCodTams, 4), ;
                    DPro2s     WITH LEFT(THIS.this_cItemDpro2s, 45) ;
                    IN cursor_4c_Etiquetas

            THIS.RegistrarAuditoria("ALTERAR")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao atualizar etiqueta")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * PrepararImpressao - Orquestra a impressao de etiquetas
    * Chamado pelo Form apos confirmacao do usuario (Imprime.Click)
    * Reordena cursor, monta lcBop e chama SigOpEtq (funcao legado)
    * par_nImpPreco: opcao de preco (1=Sim,2=Nao,3=Ideal,4=Atual,5=PrecoDe/Por,6=Parcelamento)
    * par_lImpSepar: .T. = imprimir separadora
    * par_lImpPeso : .T. = imprimir peso
    * par_lCompo   : .T. = imprimir composicao
    * par_nTpEti   : tipo de etiqueta (INT do .Tag do botao Opt_Tipo selecionado)
    * par_nTpImp   : tipo de impressora (1=Allegro, 2=ZPL, 3=EPL)
    * par_nAjVerts : ajuste vertical
    * par_nAjHorzs : ajuste horizontal
    * par_nAjDenss : densidade
    * par_nAjVelos : velocidade
    * par_cNomeImp : nome da impressora (de crImpreV.impres)
    * par_nOrdem   : ordenacao (1=Produto, 2=Nenhuma/por insercao)
    * par_cLp1     : lista de precos 1 (get_lpreco)
    * par_cLp2     : lista de precos 2 (getLPreco2)
    * Retorna .T. se impressao concluida
    *--------------------------------------------------------------------------
    FUNCTION PrepararImpressao(par_nImpPreco, par_lImpSepar, par_lImpPeso, par_lCompo, ;
                                par_nTpEti, par_nTpImp, par_nAjVerts, par_nAjHorzs, ;
                                par_nAjDenss, par_nAjVelos, par_cNomeImp, ;
                                par_nOrdem, par_cLp1, par_cLp2)
        LOCAL loc_lSucesso, loc_oErro, loc_cBop, loc_nItens
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Etiquetas")
                THIS.this_cMensagemErro = "Sem itens para imprimir."
                loc_lSucesso = .F.
            ENDIF

            *-- Remove itens com quantidade zero ou negativa
            SELECT cursor_4c_Etiquetas
            DELETE FROM cursor_4c_Etiquetas WHERE Qtds <= 0

            *-- Conta itens validos
            SELECT cursor_4c_Etiquetas
            loc_nItens = 0
            COUNT TO loc_nItens FOR !DELETED()

            IF loc_nItens = 0
                THIS.this_cMensagemErro = "Nenhum item v" + CHR(225) + "lido para imprimir."
                loc_lSucesso = .F.
            ENDIF

            *-- Reordena cursor conforme opcao (1=por Produto, 2=por insercao)
            IF par_nOrdem = 1
                SELECT cursor_4c_Etiquetas
                SET ORDER TO Cpros
            ELSE
                SELECT cursor_4c_Etiquetas
                SET ORDER TO Registros
            ENDIF

            *-- Copia para cursor ordenado preservando a ordem escolhida
            SELECT * FROM cursor_4c_Etiquetas WHERE !DELETED() ;
                INTO CURSOR cursor_4c_EtqOrdenado READWRITE

            SET ORDER TO

            SELECT cursor_4c_Etiquetas
            ZAP

            SELECT cursor_4c_EtqOrdenado
            SCAN
                SCATTER MEMVAR MEMO
                SELECT cursor_4c_Etiquetas
                INSERT INTO cursor_4c_Etiquetas FROM MEMVAR
            ENDSCAN

            IF USED("cursor_4c_EtqOrdenado")
                USE IN cursor_4c_EtqOrdenado
            ENDIF

            *-- Monta codigo BOP se operacao e numero informados
            loc_cBop = ""
            IF !EMPTY(THIS.this_cDopes) AND THIS.this_nNumes > 0
                loc_cBop = THIS.MontarCodigoBop(THIS.this_cDopes, THIS.this_nNumes)
            ENDIF

            *-- Posiciona no cursor_4c_Etiquetas (SigOpEtq usa area de trabalho corrente)
            SELECT cursor_4c_Etiquetas
            GO TOP

            *-- Chama funcao de impressao do sistema legado (dbImpressao=cursor_4c_Etiquetas)
            =SigOpEtq(gnConnHandle, par_nImpPreco, par_lImpSepar, par_nTpEti, par_nTpImp, ;
                      par_nAjVerts, par_nAjHorzs, par_nAjDenss, .F., .F., .F., ;
                      par_cNomeImp, .F., .F., par_nAjVelos, par_lImpPeso, ;
                      loc_cBop, par_cLp1, par_cLp2, .F., .F., par_lCompo)

            THIS.RegistrarAuditoria("IMPRIMIR")

            *-- Limpa grid apos impressao bem-sucedida
            SELECT cursor_4c_Etiquetas
            ZAP
            APPEND BLANK IN cursor_4c_Etiquetas
            GO TOP IN cursor_4c_Etiquetas

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao imprimir etiquetas")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

