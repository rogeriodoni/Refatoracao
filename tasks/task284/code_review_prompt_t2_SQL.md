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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEtq.prg) - TRECHOS RELEVANTES PARA PASS SQL (2569 linhas total):

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

*-- Linhas 509 a 640:
509: 			.Width            = 818
510: 			.Height           = 200
511: 			.GridLines        = 1
512: 			.DeleteMark       = .F.
513: 			.RecordMark       = .F.
514: 			.AllowRowSizing   = .F.
515: 			.HeaderHeight     = 22
516: 			.RowHeight        = 20
517: 			.FontName         = "Tahoma"
518: 			.FontSize         = 8
519: 
520: 			WITH .Columns(1)
521: 				.Header1.Caption = "C" + CHR(243) + "digo"
522: 				.Width           = 110
523: 				.ControlSource   = "cursor_4c_Etiquetas.Cpros"
524: 				.Sparse          = .F.
525: 				.AddObject("txt_4c_GrdCpros", "TextBox")
526: 				WITH .txt_4c_GrdCpros
527: 					.ControlSource = "cursor_4c_Etiquetas.Cpros"
528: 					.FontName      = "Tahoma"
529: 					.FontSize      = 8
530: 				ENDWITH
531: 				.CurrentControl = "txt_4c_GrdCpros"
532: 			ENDWITH
533: 
534: 			WITH .Columns(2)
535: 				.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
536: 				.Width           = 270
537: 				.ControlSource   = "cursor_4c_Etiquetas.DPros"
538: 				.Sparse          = .F.
539: 				.AddObject("txt_4c_GrdDpros", "TextBox")
540: 				WITH .txt_4c_GrdDpros
541: 					.ControlSource = "cursor_4c_Etiquetas.DPros"
542: 					.FontName      = "Tahoma"
543: 					.FontSize      = 8
544: 				ENDWITH
545: 				.CurrentControl = "txt_4c_GrdDpros"
546: 			ENDWITH
547: 
548: 			WITH .Columns(3)
549: 				.Header1.Caption = "Qtde"
550: 				.Width           = 65
551: 				.ControlSource   = "cursor_4c_Etiquetas.Qtds"
552: 				.Sparse          = .F.
553: 				.AddObject("txt_4c_GrdQtds", "TextBox")
554: 				WITH .txt_4c_GrdQtds
555: 					.ControlSource = "cursor_4c_Etiquetas.Qtds"
556: 					.FontName      = "Tahoma"
557: 					.FontSize      = 8
558: 				ENDWITH
559: 				.CurrentControl = "txt_4c_GrdQtds"
560: 			ENDWITH
561: 
562: 			WITH .Columns(4)
563: 				.Header1.Caption = "Refer" + CHR(234) + "ncia Fornecedor"
564: 				.Width           = 135
565: 				.ControlSource   = "cursor_4c_Etiquetas.Reffs"
566: 				.Sparse          = .F.
567: 				.AddObject("txt_4c_GrdReffs", "TextBox")
568: 				WITH .txt_4c_GrdReffs
569: 					.ControlSource = "cursor_4c_Etiquetas.Reffs"
570: 					.FontName      = "Tahoma"
571: 					.FontSize      = 8
572: 				ENDWITH
573: 				.CurrentControl = "txt_4c_GrdReffs"
574: 			ENDWITH
575: 
576: 			WITH .Columns(5)
577: 				.Header1.Caption = "Parcelas"
578: 				.Width           = 60
579: 				.ControlSource   = "cursor_4c_Etiquetas.Parcelas"
580: 				.Sparse          = .F.
581: 				.AddObject("txt_4c_GrdParcelas", "TextBox")
582: 				WITH .txt_4c_GrdParcelas
583: 					.ControlSource = "cursor_4c_Etiquetas.Parcelas"
584: 					.FontName      = "Tahoma"
585: 					.FontSize      = 8
586: 				ENDWITH
587: 				.CurrentControl = "txt_4c_GrdParcelas"
588: 			ENDWITH
589: 
590: 			WITH .Columns(6)
591: 				.Header1.Caption = "Pre" + CHR(231) + "o"
592: 				.Width           = 70
593: 				.ControlSource   = "cursor_4c_Etiquetas.PVens"
594: 				.ReadOnly        = .T.
595: 				.Sparse          = .F.
596: 				.AddObject("txt_4c_GrdPvens", "TextBox")
597: 				WITH .txt_4c_GrdPvens
598: 					.ControlSource = "cursor_4c_Etiquetas.PVens"
599: 					.FontName      = "Tahoma"
600: 					.FontSize      = 8
601: 					.ReadOnly      = .T.
602: 				ENDWITH
603: 				.CurrentControl = "txt_4c_GrdPvens"
604: 			ENDWITH
605: 
606: 			WITH .Columns(7)
607: 				.Header1.Caption = "Pre" + CHR(231) + "o De"
608: 				.Width           = 70
609: 				.ControlSource   = "cursor_4c_Etiquetas.PrecoDe"
610: 				.ReadOnly        = .T.
611: 				.Sparse          = .F.
612: 				.AddObject("txt_4c_GrdPrecoDe", "TextBox")
613: 				WITH .txt_4c_GrdPrecoDe
614: 					.ControlSource = "cursor_4c_Etiquetas.PrecoDe"
615: 					.FontName      = "Tahoma"
616: 					.FontSize      = 8
617: 					.ReadOnly      = .T.
618: 				ENDWITH
619: 				.CurrentControl = "txt_4c_GrdPrecoDe"
620: 			ENDWITH
621: 		ENDWITH
622: 
623: 		*-- Primeira linha em branco para edicao imediata
624: 		IF USED("cursor_4c_Etiquetas") AND RECCOUNT("cursor_4c_Etiquetas") = 0
625: 			SELECT cursor_4c_Etiquetas
626: 			APPEND BLANK
627: 		ENDIF
628: 
629: 		*-- BINDEVENTs
630: 		BINDEVENT(THIS.txt_4c_Emps,                  "KeyPress", THIS, "TxtEmpsKeyPress")
631: 		BINDEVENT(THIS.txt_4c_Dopes,                 "KeyPress", THIS, "TxtDopesKeyPress")
632: 		BINDEVENT(THIS.txt_4c_Cpros,                 "KeyPress", THIS, "TxtCprosKeyPress")
633: 		BINDEVENT(THIS.txt_4c_Dpros,                 "KeyPress", THIS, "TxtDprosKeyPress")
634: 		BINDEVENT(THIS.txt_4c_Qtds,                  "KeyPress", THIS, "TxtQtdsKeyPress")
635: 		BINDEVENT(THIS.txt_4c_Lpreco,                "KeyPress", THIS, "TxtLprecoKeyPress")
636: 		BINDEVENT(THIS.txt_4c_LPreco2,               "KeyPress", THIS, "TxtLPreco2KeyPress")
637: 		BINDEVENT(THIS.cmd_4c_BtnCarregar,           "Click",    THIS, "CmdBtnCarregarClick")
638: 		BINDEVENT(THIS.cmd_4c_BtnExcluir,            "Click",    THIS, "CmdBtnExcluirClick")
639: 		BINDEVENT(THIS.grd_4c_Etiquetas,             "KeyPress", THIS, "GrdEtiquetasKeyPress")
640: 		BINDEVENT(THIS.cmg_4c_BtnReport.Buttons(1), "Click",    THIS, "BtnImprimirClick")

*-- Linhas 673 a 780:
673: 		LOCAL loc_cEmps, loc_nRet, loc_oBusca
674: 		loc_cEmps = ALLTRIM(NVL(THIS.txt_4c_Emps.Value, ""))
675: 		IF !EMPTY(loc_cEmps)
676: 			loc_nRet = SQLEXEC(gnConnHandle, ;
677: 				"SELECT TOP 1 Emps, DEmps FROM SigCdEmp WHERE RTRIM(Emps)=" + EscaparSQL(loc_cEmps), ;
678: 				"cursor_4c_BuscaEmp")
679: 			IF loc_nRet > 0 AND USED("cursor_4c_BuscaEmp") AND RECCOUNT("cursor_4c_BuscaEmp") > 0
680: 				SELECT cursor_4c_BuscaEmp
681: 				THIS.lbl_4c_DEmps.Caption = ALLTRIM(cursor_4c_BuscaEmp.DEmps)
682: 				USE IN cursor_4c_BuscaEmp
683: 				THIS.txt_4c_Dopes.SetFocus()
684: 				RETURN
685: 			ENDIF
686: 			IF USED("cursor_4c_BuscaEmp")
687: 				USE IN cursor_4c_BuscaEmp
688: 			ENDIF
689: 		ENDIF
690: 		loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
691: 			"SigCdEmp", "cursor_4c_BuscaEmp", "Emps", ;
692: 			loc_cEmps, "Empresa", .T., .T., "")
693: 		IF VARTYPE(loc_oBusca) = "O"
694: 			IF !loc_oBusca.this_lAchouRegistro
695: 				loc_oBusca.mAddColuna("Emps",  "", "C" + CHR(243) + "d.")
696: 				loc_oBusca.mAddColuna("DEmps", "", "Empresa")
697: 				loc_oBusca.Show()
698: 			ENDIF
699: 			IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
700: 				SELECT cursor_4c_BuscaEmp
701: 				THIS.txt_4c_Emps.Value     = ALLTRIM(cursor_4c_BuscaEmp.Emps)
702: 				THIS.lbl_4c_DEmps.Caption  = ALLTRIM(cursor_4c_BuscaEmp.DEmps)
703: 				USE IN cursor_4c_BuscaEmp
704: 				THIS.txt_4c_Dopes.SetFocus()
705: 			ENDIF
706: 		ENDIF
707: 	ENDPROC
708: 
709: 	*====================================================================
710: 	* TxtDopesKeyPress - Valida ou abre busca de operacao (SigCdOpe)
711: 	*====================================================================
712: 	PROCEDURE TxtDopesKeyPress(par_nKeyCode, par_nShiftAltCtrl)
713: 		IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
714: 			RETURN
715: 		ENDIF
716: 		LOCAL loc_cDopes, loc_nRet, loc_oBusca
717: 		loc_cDopes = ALLTRIM(NVL(THIS.txt_4c_Dopes.Value, ""))
718: 		IF !EMPTY(loc_cDopes)
719: 			loc_nRet = SQLEXEC(gnConnHandle, ;
720: 				"SELECT TOP 1 Dopes FROM SigCdOpe WHERE RTRIM(Dopes)=" + EscaparSQL(loc_cDopes), ;
721: 				"cursor_4c_BuscaOpe")
722: 			IF loc_nRet > 0 AND USED("cursor_4c_BuscaOpe") AND RECCOUNT("cursor_4c_BuscaOpe") > 0
723: 				USE IN cursor_4c_BuscaOpe
724: 				THIS.txt_4c_Cpros.SetFocus()
725: 				RETURN
726: 			ENDIF
727: 			IF USED("cursor_4c_BuscaOpe")
728: 				USE IN cursor_4c_BuscaOpe
729: 			ENDIF
730: 		ENDIF
731: 		loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
732: 			"SigCdOpe", "cursor_4c_BuscaOpe", "Dopes", ;
733: 			loc_cDopes, "Opera" + CHR(231) + CHR(227) + "o", .T., .T., "")
734: 		IF VARTYPE(loc_oBusca) = "O"
735: 			IF !loc_oBusca.this_lAchouRegistro
736: 				loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
737: 				loc_oBusca.Show()
738: 			ENDIF
739: 			IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
740: 				SELECT cursor_4c_BuscaOpe
741: 				THIS.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
742: 				USE IN cursor_4c_BuscaOpe
743: 				THIS.txt_4c_Cpros.SetFocus()
744: 			ENDIF
745: 		ENDIF
746: 	ENDPROC
747: 
748: 	*====================================================================
749: 	* TxtCprosKeyPress - Busca produto por codigo, EAN13 ou codigo de barras
750: 	*====================================================================
751: 	PROCEDURE TxtCprosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
752: 		IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
753: 			RETURN
754: 		ENDIF
755: 		LOCAL loc_cCodigo, loc_nRet
756: 		loc_cCodigo = ALLTRIM(NVL(THIS.txt_4c_Cpros.Value, ""))
757: 		IF !EMPTY(loc_cCodigo)
758: 			loc_nRet = SQLEXEC(gnConnHandle, ;
759: 				"SELECT TOP 1 Cpros, DPros FROM SigCdPro " + ;
760: 				"WHERE RTRIM(Cpros)=" + EscaparSQL(loc_cCodigo) + ;
761: 				" OR RTRIM(Ean13)="  + EscaparSQL(loc_cCodigo) + ;
762: 				" OR RTRIM(CBars)="  + EscaparSQL(loc_cCodigo), ;
763: 				"cursor_4c_BuscaProd")
764: 			IF loc_nRet > 0 AND USED("cursor_4c_BuscaProd") AND RECCOUNT("cursor_4c_BuscaProd") > 0
765: 				SELECT cursor_4c_BuscaProd
766: 				THIS.txt_4c_Cpros.Value = ALLTRIM(cursor_4c_BuscaProd.Cpros)
767: 				THIS.txt_4c_Dpros.Value = ALLTRIM(cursor_4c_BuscaProd.DPros)
768: 				USE IN cursor_4c_BuscaProd
769: 				THIS.txt_4c_Qtds.SetFocus()
770: 				RETURN
771: 			ENDIF
772: 			IF USED("cursor_4c_BuscaProd")
773: 				USE IN cursor_4c_BuscaProd
774: 			ENDIF
775: 		ENDIF
776: 		THIS.AbrirBuscaProdutoCodigo()
777: 	ENDPROC
778: 
779: 	*====================================================================
780: 	* TxtDprosKeyPress - Busca produto por descricao

*-- Linhas 786 a 809:
786: 		LOCAL loc_cDesc, loc_nRet
787: 		loc_cDesc = ALLTRIM(NVL(THIS.txt_4c_Dpros.Value, ""))
788: 		IF !EMPTY(loc_cDesc)
789: 			loc_nRet = SQLEXEC(gnConnHandle, ;
790: 				"SELECT TOP 1 Cpros, DPros FROM SigCdPro " + ;
791: 				"WHERE RTRIM(DPros)=" + EscaparSQL(loc_cDesc), ;
792: 				"cursor_4c_BuscaProd")
793: 			IF loc_nRet > 0 AND USED("cursor_4c_BuscaProd") AND RECCOUNT("cursor_4c_BuscaProd") > 0
794: 				SELECT cursor_4c_BuscaProd
795: 				THIS.txt_4c_Cpros.Value = ALLTRIM(cursor_4c_BuscaProd.Cpros)
796: 				THIS.txt_4c_Dpros.Value = ALLTRIM(cursor_4c_BuscaProd.DPros)
797: 				USE IN cursor_4c_BuscaProd
798: 				THIS.txt_4c_Qtds.SetFocus()
799: 				RETURN
800: 			ENDIF
801: 			IF USED("cursor_4c_BuscaProd")
802: 				USE IN cursor_4c_BuscaProd
803: 			ENDIF
804: 		ENDIF
805: 		THIS.AbrirBuscaProdutoDescricao()
806: 	ENDPROC
807: 
808: 	*====================================================================
809: 	* TxtQtdsKeyPress - Valida qtde e adiciona produto ao grid

*-- Linhas 825 a 843:
825: 			THIS.txt_4c_Qtds.SetFocus()
826: 			RETURN
827: 		ENDIF
828: 		SELECT cursor_4c_Etiquetas
829: 		GO BOTTOM
830: 		IF !EMPTY(cursor_4c_Etiquetas.Cpros)
831: 			APPEND BLANK
832: 		ENDIF
833: 		REPLACE Cpros WITH loc_cCpros, ;
834: 		        DPros WITH ALLTRIM(NVL(THIS.txt_4c_Dpros.Value, "")), ;
835: 		        Qtds  WITH loc_nQtds
836: 		THIS.CarregarPrecoProduto(loc_cCpros)
837: 		IF THIS.chk_4c_Lista.Value = 1 AND !EMPTY(ALLTRIM(NVL(THIS.txt_4c_Lpreco.Value, "")))
838: 			THIS.AtualizarPrecoPorLista(loc_cCpros)
839: 		ENDIF
840: 		APPEND BLANK
841: 		THIS.txt_4c_Cpros.Value = ""
842: 		THIS.txt_4c_Dpros.Value = ""
843: 		THIS.txt_4c_Qtds.Value  = 0

*-- Linhas 855 a 899:
855: 		LOCAL loc_cLpreco, loc_nRet, loc_oBusca
856: 		loc_cLpreco = ALLTRIM(NVL(THIS.txt_4c_Lpreco.Value, ""))
857: 		IF !EMPTY(loc_cLpreco)
858: 			loc_nRet = SQLEXEC(gnConnHandle, ;
859: 				"SELECT TOP 1 LPrecos, DLPrecos FROM SigCdLpc " + ;
860: 				"WHERE RTRIM(LPrecos)=" + EscaparSQL(loc_cLpreco), ;
861: 				"cursor_4c_BuscaLpc")
862: 			IF loc_nRet > 0 AND USED("cursor_4c_BuscaLpc") AND RECCOUNT("cursor_4c_BuscaLpc") > 0
863: 				SELECT cursor_4c_BuscaLpc
864: 				THIS.txt_4c_Lpreco.Value  = ALLTRIM(cursor_4c_BuscaLpc.LPrecos)
865: 				THIS.txt_4c_LPreco2.Value = ALLTRIM(cursor_4c_BuscaLpc.DLPrecos)
866: 				USE IN cursor_4c_BuscaLpc
867: 				THIS.chk_4c_Lista.SetFocus()
868: 				RETURN
869: 			ENDIF
870: 			IF USED("cursor_4c_BuscaLpc")
871: 				USE IN cursor_4c_BuscaLpc
872: 			ENDIF
873: 		ENDIF
874: 		loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
875: 			"SigCdLpc", "cursor_4c_BuscaLpc", "LPrecos", ;
876: 			loc_cLpreco, "Lista de Pre" + CHR(231) + "os", .T., .T., "")
877: 		IF VARTYPE(loc_oBusca) = "O"
878: 			IF !loc_oBusca.this_lAchouRegistro
879: 				loc_oBusca.mAddColuna("LPrecos",  "", "C" + CHR(243) + "digo")
880: 				loc_oBusca.mAddColuna("DLPrecos", "", "Descri" + CHR(231) + CHR(227) + "o")
881: 				loc_oBusca.Show()
882: 			ENDIF
883: 			IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLpc")
884: 				SELECT cursor_4c_BuscaLpc
885: 				THIS.txt_4c_Lpreco.Value  = ALLTRIM(cursor_4c_BuscaLpc.LPrecos)
886: 				THIS.txt_4c_LPreco2.Value = ALLTRIM(cursor_4c_BuscaLpc.DLPrecos)
887: 				USE IN cursor_4c_BuscaLpc
888: 				THIS.chk_4c_Lista.SetFocus()
889: 			ENDIF
890: 		ENDIF
891: 	ENDPROC
892: 
893: 	*====================================================================
894: 	* TxtLPreco2KeyPress - ReadOnly, redireciona foco para txt_4c_Lpreco
895: 	*====================================================================
896: 	PROCEDURE TxtLPreco2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
897: 		IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
898: 			RETURN
899: 		ENDIF

*-- Linhas 916 a 934:
916: 				loc_oBusca.Show()
917: 			ENDIF
918: 			IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
919: 				SELECT cursor_4c_BuscaProd
920: 				THIS.txt_4c_Cpros.Value = ALLTRIM(cursor_4c_BuscaProd.Cpros)
921: 				THIS.txt_4c_Dpros.Value = ALLTRIM(cursor_4c_BuscaProd.DPros)
922: 				USE IN cursor_4c_BuscaProd
923: 				THIS.txt_4c_Qtds.SetFocus()
924: 			ENDIF
925: 		ENDIF
926: 	ENDPROC
927: 
928: 	*====================================================================
929: 	* AbrirBuscaProdutoDescricao - Picker de produto por descricao
930: 	*====================================================================
931: 	PROTECTED PROCEDURE AbrirBuscaProdutoDescricao()
932: 		LOCAL loc_oBusca
933: 		loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
934: 			"SigCdPro", "cursor_4c_BuscaProd", "DPros", ;

*-- Linhas 941 a 959:
941: 				loc_oBusca.Show()
942: 			ENDIF
943: 			IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
944: 				SELECT cursor_4c_BuscaProd
945: 				THIS.txt_4c_Cpros.Value = ALLTRIM(cursor_4c_BuscaProd.Cpros)
946: 				THIS.txt_4c_Dpros.Value = ALLTRIM(cursor_4c_BuscaProd.DPros)
947: 				USE IN cursor_4c_BuscaProd
948: 				THIS.txt_4c_Qtds.SetFocus()
949: 			ENDIF
950: 		ENDIF
951: 	ENDPROC
952: 
953: 	*====================================================================
954: 	* AbrirBuscaProdutoRef - Picker de produto por referencia (DPro2s)
955: 	*====================================================================
956: 	PROTECTED PROCEDURE AbrirBuscaProdutoRef()
957: 		LOCAL loc_cRef, loc_oBusca
958: 		loc_cRef = ""
959: 		IF USED("cursor_4c_Etiquetas") AND !EOF("cursor_4c_Etiquetas")

*-- Linhas 970 a 1023:
970: 				loc_oBusca.Show()
971: 			ENDIF
972: 			IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
973: 				SELECT cursor_4c_BuscaProd
974: 				LOCAL loc_cCpros, loc_cDPros, loc_cDPro2s
975: 				loc_cCpros  = ALLTRIM(cursor_4c_BuscaProd.Cpros)
976: 				loc_cDPros  = ALLTRIM(cursor_4c_BuscaProd.DPros)
977: 				loc_cDPro2s = ALLTRIM(cursor_4c_BuscaProd.DPro2s)
978: 				USE IN cursor_4c_BuscaProd
979: 				SELECT cursor_4c_Etiquetas
980: 				REPLACE Cpros WITH loc_cCpros, ;
981: 				        DPros WITH loc_cDPros, ;
982: 				        Reffs WITH loc_cDPro2s
983: 				THIS.CarregarPrecoProduto(loc_cCpros)
984: 				THIS.grd_4c_Etiquetas.Refresh()
985: 			ENDIF
986: 		ENDIF
987: 	ENDPROC
988: 
989: 	*====================================================================
990: 	* CarregarPrecoProduto - Carrega PVens/PrecoDe/Pesos/DPro2s na linha
991: 	*====================================================================
992: 	PROTECTED PROCEDURE CarregarPrecoProduto(par_cCpros)
993: 		LOCAL loc_nRet, loc_nPVens, loc_nPrecoDe, loc_nPesos, loc_cDPro2s
994: 		IF EMPTY(par_cCpros)
995: 			RETURN
996: 		ENDIF
997: 		loc_nRet = SQLEXEC(gnConnHandle, ;
998: 			"SELECT TOP 1 PVens, PecoDe, PesoMs, DPro2s " + ;
999: 			"FROM SigCdPro WHERE RTRIM(Cpros)=" + EscaparSQL(par_cCpros), ;
1000: 			"cursor_4c_PrecosProd")
1001: 		IF loc_nRet > 0 AND USED("cursor_4c_PrecosProd") AND RECCOUNT("cursor_4c_PrecosProd") > 0
1002: 			SELECT cursor_4c_PrecosProd
1003: 			loc_nPVens   = NVL(cursor_4c_PrecosProd.PVens,   0)
1004: 			loc_nPrecoDe = NVL(cursor_4c_PrecosProd.PecoDe,  0)
1005: 			loc_nPesos   = NVL(cursor_4c_PrecosProd.PesoMs,  0)
1006: 			loc_cDPro2s  = ALLTRIM(NVL(cursor_4c_PrecosProd.DPro2s, ""))
1007: 			USE IN cursor_4c_PrecosProd
1008: 			SELECT cursor_4c_Etiquetas
1009: 			IF THIS.chk_4c_Precio.Value = 1
1010: 				REPLACE PVens   WITH loc_nPVens, ;
1011: 				        PrecoDe WITH loc_nPrecoDe, ;
1012: 				        Pesos   WITH loc_nPesos, ;
1013: 				        DPro2s  WITH loc_cDPro2s
1014: 			ELSE
1015: 				REPLACE Pesos  WITH loc_nPesos, ;
1016: 				        DPro2s WITH loc_cDPro2s
1017: 			ENDIF
1018: 		ENDIF
1019: 		IF USED("cursor_4c_PrecosProd")
1020: 			USE IN cursor_4c_PrecosProd
1021: 		ENDIF
1022: 	ENDPROC
1023: 

*-- Linhas 1030 a 1117:
1030: 		IF EMPTY(loc_cLpreco) OR EMPTY(par_cCpros)
1031: 			RETURN
1032: 		ENDIF
1033: 		loc_nRet = SQLEXEC(gnConnHandle, ;
1034: 			"SELECT TOP 1 PVens, PrecoDe FROM SigCdLpi " + ;
1035: 			"WHERE RTRIM(LPrecos)=" + EscaparSQL(loc_cLpreco) + ;
1036: 			" AND RTRIM(CPros)=" + EscaparSQL(par_cCpros), ;
1037: 			"cursor_4c_PrecoLista")
1038: 		IF loc_nRet > 0 AND USED("cursor_4c_PrecoLista") AND RECCOUNT("cursor_4c_PrecoLista") > 0
1039: 			SELECT cursor_4c_PrecoLista
1040: 			LOCAL loc_nPVens, loc_nPrecoDe
1041: 			loc_nPVens   = NVL(cursor_4c_PrecoLista.PVens,   0)
1042: 			loc_nPrecoDe = NVL(cursor_4c_PrecoLista.PrecoDe, 0)
1043: 			USE IN cursor_4c_PrecoLista
1044: 			SELECT cursor_4c_Etiquetas
1045: 			REPLACE PVens   WITH loc_nPVens, ;
1046: 			        PrecoDe WITH loc_nPrecoDe
1047: 		ENDIF
1048: 		IF USED("cursor_4c_PrecoLista")
1049: 			USE IN cursor_4c_PrecoLista
1050: 		ENDIF
1051: 	ENDPROC
1052: 
1053: 	*====================================================================
1054: 	* CarregarItensDaLista - Popula grid com todos itens de SigCdLpi
1055: 	*====================================================================
1056: 	PROTECTED PROCEDURE CarregarItensDaLista()
1057: 		LOCAL loc_cLpreco, loc_nRet
1058: 		loc_cLpreco = ALLTRIM(NVL(THIS.txt_4c_Lpreco.Value, ""))
1059: 		IF EMPTY(loc_cLpreco)
1060: 			MsgAviso("Informe a lista de pre" + CHR(231) + "os.", "Aten" + CHR(231) + CHR(227) + "o")
1061: 			THIS.txt_4c_Lpreco.SetFocus()
1062: 			RETURN
1063: 		ENDIF
1064: 		loc_nRet = SQLEXEC(gnConnHandle, ;
1065: 			"SELECT i.CPros AS iCPros, p.DPros AS iDPros, p.DPro2s AS iDPro2s, " + ;
1066: 			" i.PVens AS iPVens, i.PrecoDe AS iPrecoDe, p.PesoMs AS iPesoMs " + ;
1067: 			"FROM SigCdLpi i " + ;
1068: 			"INNER JOIN SigCdPro p ON RTRIM(p.Cpros)=RTRIM(i.CPros) " + ;
1069: 			"WHERE RTRIM(i.LPrecos)=" + EscaparSQL(loc_cLpreco) + ;
1070: 			" ORDER BY i.CPros", ;
1071: 			"cursor_4c_ItensList")
1072: 		IF loc_nRet <= 0 OR !USED("cursor_4c_ItensList") OR RECCOUNT("cursor_4c_ItensList") = 0
1073: 			IF USED("cursor_4c_ItensList")
1074: 				USE IN cursor_4c_ItensList
1075: 			ENDIF
1076: 			MsgAviso("Nenhum item encontrado para a lista selecionada.", "Aten" + CHR(231) + CHR(227) + "o")
1077: 			RETURN
1078: 		ENDIF
1079: 		LOCAL loc_cCpros, loc_cDPros, loc_cDPro2s, loc_nPVens, loc_nPrecoDe, loc_nPesos
1080: 		SELECT cursor_4c_Etiquetas
1081: 		ZAP
1082: 		SELECT cursor_4c_ItensList
1083: 		SCAN
1084: 			loc_cCpros   = ALLTRIM(cursor_4c_ItensList.iCPros)
1085: 			loc_cDPros   = ALLTRIM(cursor_4c_ItensList.iDPros)
1086: 			loc_cDPro2s  = ALLTRIM(cursor_4c_ItensList.iDPro2s)
1087: 			loc_nPVens   = NVL(cursor_4c_ItensList.iPVens,   0)
1088: 			loc_nPrecoDe = NVL(cursor_4c_ItensList.iPrecoDe, 0)
1089: 			loc_nPesos   = NVL(cursor_4c_ItensList.iPesoMs,  0)
1090: 			SELECT cursor_4c_Etiquetas
1091: 			APPEND BLANK
1092: 			REPLACE Cpros   WITH loc_cCpros, ;
1093: 			        DPros   WITH loc_cDPros, ;
1094: 			        DPro2s  WITH loc_cDPro2s, ;
1095: 			        PVens   WITH loc_nPVens, ;
1096: 			        PrecoDe WITH loc_nPrecoDe, ;
1097: 			        Pesos   WITH loc_nPesos, ;
1098: 			        Qtds    WITH 1
1099: 			SELECT cursor_4c_ItensList
1100: 		ENDSCAN
1101: 		USE IN cursor_4c_ItensList
1102: 		SELECT cursor_4c_Etiquetas
1103: 		APPEND BLANK
1104: 		GO TOP
1105: 		THIS.grd_4c_Etiquetas.Refresh()
1106: 	ENDPROC
1107: 
1108: 	*====================================================================
1109: 	* CmdBtnCarregarClick - Carrega itens de SigMvItn por empresa/operacao
1110: 	*====================================================================
1111: 	PROCEDURE CmdBtnCarregarClick()
1112: 		LOCAL loc_cEmps, loc_cDopes, loc_nNumes, loc_cLpreco, loc_nRet
1113: 		loc_cEmps   = ALLTRIM(NVL(THIS.txt_4c_Emps.Value,  ""))
1114: 		loc_cDopes  = ALLTRIM(NVL(THIS.txt_4c_Dopes.Value, ""))
1115: 		loc_nNumes  = IIF(PEMSTATUS(THIS, "txt_4c_Numes", 5) AND VARTYPE(THIS.txt_4c_Numes) = "O", ;
1116: 		                  NVL(THIS.txt_4c_Numes.Value, 0), 0)
1117: 		loc_cLpreco = ALLTRIM(NVL(THIS.txt_4c_Lpreco.Value,""))

*-- Linhas 1132 a 1260:
1132: 			ENDIF
1133: 			RETURN
1134: 		ENDIF
1135: 		loc_nRet = SQLEXEC(gnConnHandle, ;
1136: 			"SELECT i.CPros AS iCPros, p.DPros AS iDPros, p.DPro2s AS iDPro2s, " + ;
1137: 			" i.Qtds AS iQtds, i.Citens AS iCitens, i.Numes AS iNumes, " + ;
1138: 			" i.Emps AS iEmps, i.Dopes AS iDopes, " + ;
1139: 			" p.PVens AS iPVens, p.PecoDe AS iPecoDe, p.PesoMs AS iPesoMs " + ;
1140: 			"FROM SigMvItn i " + ;
1141: 			"LEFT JOIN SigCdPro p ON RTRIM(p.Cpros)=RTRIM(i.CPros) " + ;
1142: 			"WHERE RTRIM(i.Emps)=" + EscaparSQL(loc_cEmps) + ;
1143: 			" AND RTRIM(i.Dopes)=" + EscaparSQL(loc_cDopes) + ;
1144: 			" AND i.Numes = " + FormatarNumeroSQL(loc_nNumes, 0) + ;
1145: 			" ORDER BY i.CPros", ;
1146: 			"cursor_4c_SigMvItn")
1147: 		IF loc_nRet <= 0 OR !USED("cursor_4c_SigMvItn") OR RECCOUNT("cursor_4c_SigMvItn") = 0
1148: 			IF USED("cursor_4c_SigMvItn")
1149: 				USE IN cursor_4c_SigMvItn
1150: 			ENDIF
1151: 			MsgAviso("Nenhum item encontrado para empresa/opera" + CHR(231) + CHR(227) + "o informada.", ;
1152: 			         "Aten" + CHR(231) + CHR(227) + "o")
1153: 			RETURN
1154: 		ENDIF
1155: 		LOCAL loc_cCpros, loc_cDPros, loc_cDPro2s
1156: 		LOCAL loc_nQtds, loc_nCitens, loc_nNumes
1157: 		LOCAL loc_cIEmps, loc_cIDopes
1158: 		LOCAL loc_nPVens, loc_nPrecoDe, loc_nPesos
1159: 		LOCAL loc_cEmpDoNum, loc_nRetLpi
1160: 		SELECT cursor_4c_Etiquetas
1161: 		ZAP
1162: 		SELECT cursor_4c_SigMvItn
1163: 		SCAN
1164: 			loc_cCpros   = ALLTRIM(cursor_4c_SigMvItn.iCPros)
1165: 			loc_cDPros   = ALLTRIM(NVL(cursor_4c_SigMvItn.iDPros,  ""))
1166: 			loc_cDPro2s  = ALLTRIM(NVL(cursor_4c_SigMvItn.iDPro2s, ""))
1167: 			loc_nQtds    = NVL(cursor_4c_SigMvItn.iQtds,    0)
1168: 			loc_nCitens  = NVL(cursor_4c_SigMvItn.iCitens,  0)
1169: 			loc_nNumes   = NVL(cursor_4c_SigMvItn.iNumes,   0)
1170: 			loc_cIEmps   = ALLTRIM(NVL(cursor_4c_SigMvItn.iEmps,   ""))
1171: 			loc_cIDopes  = ALLTRIM(NVL(cursor_4c_SigMvItn.iDopes,  ""))
1172: 			loc_nPVens   = NVL(cursor_4c_SigMvItn.iPVens,   0)
1173: 			loc_nPrecoDe = NVL(cursor_4c_SigMvItn.iPecoDe,  0)
1174: 			loc_nPesos   = NVL(cursor_4c_SigMvItn.iPesoMs,  0)
1175: 			*-- Aplica lista de precos se habilitada
1176: 			IF THIS.chk_4c_Lista.Value = 1 AND !EMPTY(loc_cLpreco)
1177: 				loc_nRetLpi = SQLEXEC(gnConnHandle, ;
1178: 					"SELECT TOP 1 PVens, PrecoDe FROM SigCdLpi " + ;
1179: 					"WHERE RTRIM(LPrecos)=" + EscaparSQL(loc_cLpreco) + ;
1180: 					" AND RTRIM(CPros)=" + EscaparSQL(loc_cCpros), ;
1181: 					"cursor_4c_Lpi")
1182: 				IF loc_nRetLpi > 0 AND USED("cursor_4c_Lpi") AND RECCOUNT("cursor_4c_Lpi") > 0
1183: 					SELECT cursor_4c_Lpi
1184: 					loc_nPVens   = NVL(cursor_4c_Lpi.PVens,   loc_nPVens)
1185: 					loc_nPrecoDe = NVL(cursor_4c_Lpi.PrecoDe, loc_nPrecoDe)
1186: 				ENDIF
1187: 				IF USED("cursor_4c_Lpi")
1188: 					USE IN cursor_4c_Lpi
1189: 				ENDIF
1190: 			ENDIF
1191: 			loc_cEmpDoNum = PADR(loc_cIEmps, 3) + PADR(loc_cIDopes, 20) + STR(loc_nNumes, 6, 0)
1192: 			SELECT cursor_4c_Etiquetas
1193: 			APPEND BLANK
1194: 			REPLACE Cpros      WITH loc_cCpros, ;
1195: 			        DPros      WITH loc_cDPros, ;
1196: 			        DPro2s     WITH loc_cDPro2s, ;
1197: 			        Qtds       WITH loc_nQtds, ;
1198: 			        citens     WITH loc_nCitens, ;
1199: 			        empos      WITH LEFT(loc_cIEmps, 3), ;
1200: 			        empdopnums WITH loc_cEmpDoNum, ;
1201: 			        PVens      WITH loc_nPVens, ;
1202: 			        PrecoDe    WITH loc_nPrecoDe, ;
1203: 			        Pesos      WITH loc_nPesos, ;
1204: 			        Pedido     WITH LEFT(TRANSFORM(loc_nNumes), 30)
1205: 			SELECT cursor_4c_SigMvItn
1206: 		ENDSCAN
1207: 		USE IN cursor_4c_SigMvItn
1208: 		SELECT cursor_4c_Etiquetas
1209: 		APPEND BLANK
1210: 		GO TOP
1211: 		THIS.grd_4c_Etiquetas.Refresh()
1212: 	ENDPROC
1213: 
1214: 	*====================================================================
1215: 	* CmdBtnExcluirClick - Remove linha selecionada do grid
1216: 	*====================================================================
1217: 	PROCEDURE CmdBtnExcluirClick()
1218: 		IF !USED("cursor_4c_Etiquetas") OR RECCOUNT("cursor_4c_Etiquetas") <= 1
1219: 			RETURN
1220: 		ENDIF
1221: 		SELECT cursor_4c_Etiquetas
1222: 		IF EOF() OR BOF() OR EMPTY(cursor_4c_Etiquetas.Cpros)
1223: 			RETURN
1224: 		ENDIF
1225: 		DELETE
1226: 		PACK
1227: 		IF RECCOUNT("cursor_4c_Etiquetas") = 0
1228: 			APPEND BLANK
1229: 		ENDIF
1230: 		GO TOP
1231: 		THIS.grd_4c_Etiquetas.Refresh()
1232: 	ENDPROC
1233: 
1234: 	*====================================================================
1235: 	* BtnIncluirClick - Adiciona linha em branco no grid para o usuario
1236: 	* preencher manualmente (produto/quantidade). Adaptacao CRUD do
1237: 	* fluxo OPERACIONAL: nao ha modo de edicao separado, o grid eh
1238: 	* editavel diretamente.
1239: 	*====================================================================
1240: 	PROCEDURE BtnIncluirClick()
1241: 		IF !USED("cursor_4c_Etiquetas")
1242: 			MsgAviso("Grid n" + CHR(227) + "o inicializado.", "Aten" + CHR(231) + CHR(227) + "o")
1243: 			RETURN
1244: 		ENDIF
1245: 		SELECT cursor_4c_Etiquetas
1246: 		*-- Se ja existe linha em branco no final, apenas posiciona nela
1247: 		GO BOTTOM
1248: 		IF EMPTY(cursor_4c_Etiquetas.Cpros)
1249: 			THIS.grd_4c_Etiquetas.Refresh()
1250: 			THIS.grd_4c_Etiquetas.SetFocus()
1251: 			RETURN
1252: 		ENDIF
1253: 		*-- Adiciona nova linha em branco para digitacao
1254: 		APPEND BLANK
1255: 		GO BOTTOM
1256: 		THIS.grd_4c_Etiquetas.Refresh()
1257: 		THIS.grd_4c_Etiquetas.SetFocus()
1258: 	ENDPROC
1259: 
1260: 	*====================================================================

*-- Linhas 1267 a 1285:
1267: 			MsgAviso("Nenhum item para alterar.", "Aten" + CHR(231) + CHR(227) + "o")
1268: 			RETURN
1269: 		ENDIF
1270: 		SELECT cursor_4c_Etiquetas
1271: 		IF EOF() OR BOF()
1272: 			GO TOP
1273: 		ENDIF
1274: 		THIS.grd_4c_Etiquetas.Refresh()
1275: 		THIS.grd_4c_Etiquetas.SetFocus()
1276: 		*-- Tenta focar na primeira coluna editavel (Cpros)
1277: 		IF PEMSTATUS(THIS.grd_4c_Etiquetas, "Column1", 5) AND ;
1278: 		   VARTYPE(THIS.grd_4c_Etiquetas.Column1) = "O"
1279: 			IF PEMSTATUS(THIS.grd_4c_Etiquetas.Column1, "Text1", 5) AND ;
1280: 			   VARTYPE(THIS.grd_4c_Etiquetas.Column1.Text1) = "O"
1281: 				THIS.grd_4c_Etiquetas.Column1.Text1.SetFocus()
1282: 			ENDIF
1283: 		ENDIF
1284: 	ENDPROC
1285: 

*-- Linhas 1294 a 1312:
1294: 			MsgAviso("Nenhum item na lista.", "Aten" + CHR(231) + CHR(227) + "o")
1295: 			RETURN
1296: 		ENDIF
1297: 		SELECT cursor_4c_Etiquetas
1298: 		loc_nTotal    = 0
1299: 		loc_nQtdTotal = 0
1300: 		SCAN FOR !EMPTY(cursor_4c_Etiquetas.Cpros)
1301: 			loc_nTotal    = loc_nTotal + 1
1302: 			loc_nQtdTotal = loc_nQtdTotal + NVL(cursor_4c_Etiquetas.Qtds, 0)
1303: 		ENDSCAN
1304: 		GO TOP
1305: 		THIS.grd_4c_Etiquetas.Refresh()
1306: 		THIS.grd_4c_Etiquetas.SetFocus()
1307: 		loc_cMensagem = "Itens selecionados: " + TRANSFORM(loc_nTotal) + CHR(13) + ;
1308: 		                "Quantidade total: " + TRANSFORM(loc_nQtdTotal, "@Z 9,999,999.999")
1309: 		MsgInfo(loc_cMensagem, "Resumo da Sele" + CHR(231) + CHR(227) + "o")
1310: 	ENDPROC
1311: 
1312: 	*====================================================================

*-- Linhas 1318 a 1360:
1318: 			MsgAviso("Nenhum item para excluir.", "Aten" + CHR(231) + CHR(227) + "o")
1319: 			RETURN
1320: 		ENDIF
1321: 		SELECT cursor_4c_Etiquetas
1322: 		IF EOF() OR BOF() OR EMPTY(cursor_4c_Etiquetas.Cpros)
1323: 			MsgAviso("Selecione um item v" + CHR(225) + "lido para excluir.", ;
1324: 			         "Aten" + CHR(231) + CHR(227) + "o")
1325: 			RETURN
1326: 		ENDIF
1327: 		IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do item selecionado?", ;
1328: 		                "Confirma" + CHR(231) + CHR(227) + "o")
1329: 			RETURN
1330: 		ENDIF
1331: 		THIS.CmdBtnExcluirClick()
1332: 	ENDPROC
1333: 
1334: 	*====================================================================
1335: 	* BtnImprimirClick - Coleta parametros dos controles e chama BO
1336: 	*====================================================================
1337: 	PROCEDURE BtnImprimirClick()
1338: 		IF !USED("cursor_4c_Etiquetas")
1339: 			MsgAviso("Nenhum item na lista.", "Aten" + CHR(231) + CHR(227) + "o")
1340: 			RETURN
1341: 		ENDIF
1342: 		SELECT cursor_4c_Etiquetas
1343: 		LOCATE FOR EMPTY(cursor_4c_Etiquetas.Cpros)
1344: 		IF FOUND()
1345: 			DELETE
1346: 			PACK
1347: 		ENDIF
1348: 		IF RECCOUNT("cursor_4c_Etiquetas") = 0
1349: 			MsgAviso("Nenhum produto adicionado para impress" + CHR(227) + "o.", ;
1350: 			         "Aten" + CHR(231) + CHR(227) + "o")
1351: 			APPEND BLANK
1352: 			RETURN
1353: 		ENDIF
1354: 		GO TOP
1355: 
1356: 		*-- Coleta parametros dos controles de configuracao
1357: 		LOCAL loc_nImpPreco, loc_lImpSepar, loc_lImpPeso, loc_lCompo
1358: 		LOCAL loc_nTpEti, loc_nTpImp, loc_nAjVerts, loc_nAjHorzs
1359: 		LOCAL loc_nAjDenss, loc_nAjVelos, loc_cNomeImp, loc_nOrdem
1360: 		LOCAL loc_cLp1, loc_cLp2

*-- Linhas 1436 a 1454:
1436: 				loc_cLp1, loc_cLp2)
1437: 		ENDIF
1438: 
1439: 		SELECT cursor_4c_Etiquetas
1440: 		IF RECCOUNT("cursor_4c_Etiquetas") = 0 OR !EMPTY(cursor_4c_Etiquetas.Cpros)
1441: 			APPEND BLANK
1442: 		ENDIF
1443: 		THIS.grd_4c_Etiquetas.Refresh()
1444: 	ENDPROC
1445: 
1446: 	*====================================================================
1447: 	* BtnEncerrarClick - Fecha o formulario
1448: 	*====================================================================
1449: 	PROCEDURE BtnEncerrarClick()
1450: 		THIS.Release()
1451: 	ENDPROC
1452: 
1453: 	*====================================================================
1454: 	* ConfigurarPaginaDados - Secao inferior: tipo etiqueta e impressora

*-- Linhas 2106 a 2136:
2106: 		IF !USED("cursor_4c_TiposEtq")
2107: 			RETURN
2108: 		ENDIF
2109: 		SELECT cursor_4c_TiposEtq
2110: 		LOCAL loc_nCount, loc_nTopo, loc_i, loc_cCaption
2111: 		loc_nCount = RECCOUNT("cursor_4c_TiposEtq")
2112: 		IF loc_nCount = 0
2113: 			RETURN
2114: 		ENDIF
2115: 		*-- Adiciona botoes conforme tipos retornados pelo BO (1 por linha)
2116: 		WITH THIS.obj_4c_Opt_Tipo
2117: 			.ButtonCount = loc_nCount
2118: 			loc_nTopo    = 10
2119: 			GO TOP IN cursor_4c_TiposEtq
2120: 			FOR loc_i = 1 TO loc_nCount
2121: 				SELECT cursor_4c_TiposEtq
2122: 				loc_cCaption = ALLTRIM(NVL(cursor_4c_TiposEtq.cEtiquetas, "Tipo " + TRANSFORM(loc_i)))
2123: 				WITH .Buttons(loc_i)
2124: 					.BackStyle = 0
2125: 					.Caption   = loc_cCaption
2126: 					.Tag       = TRANSFORM(NVL(cursor_4c_TiposEtq.nTipos, loc_i))
2127: 					.Height    = 16
2128: 					.Left      = 9
2129: 					.Style     = 0
2130: 					.Top       = loc_nTopo
2131: 					.Width     = 197
2132: 					.ForeColor = RGB(90, 90, 90)
2133: 				ENDWITH
2134: 				loc_nTopo = loc_nTopo + 18
2135: 				SKIP IN cursor_4c_TiposEtq
2136: 			ENDFOR

*-- Linhas 2511 a 2549:
2511: 			THIS.txt_4c_Qtds.Value = 0
2512: 		ENDIF
2513: 		IF USED("cursor_4c_Etiquetas")
2514: 			SELECT cursor_4c_Etiquetas
2515: 			ZAP
2516: 			APPEND BLANK
2517: 			GO TOP
2518: 		ENDIF
2519: 		IF PEMSTATUS(THIS, "grd_4c_Etiquetas", 5) AND VARTYPE(THIS.grd_4c_Etiquetas) = "O"
2520: 			THIS.grd_4c_Etiquetas.Refresh()
2521: 		ENDIF
2522: 		IF PEMSTATUS(THIS, "txt_4c_Emps", 5) AND VARTYPE(THIS.txt_4c_Emps) = "O"
2523: 			THIS.txt_4c_Emps.SetFocus()
2524: 		ENDIF
2525: 	ENDPROC
2526: 
2527: 	*====================================================================
2528: 	* CarregarLista - Reposiciona no topo e atualiza grid (OPERACIONAL)
2529: 	*====================================================================
2530: 	PROCEDURE CarregarLista()
2531: 		IF !USED("cursor_4c_Etiquetas")
2532: 			RETURN
2533: 		ENDIF
2534: 		SELECT cursor_4c_Etiquetas
2535: 		GO TOP
2536: 		IF PEMSTATUS(THIS, "grd_4c_Etiquetas", 5) AND VARTYPE(THIS.grd_4c_Etiquetas) = "O"
2537: 			THIS.grd_4c_Etiquetas.Refresh()
2538: 		ENDIF
2539: 	ENDPROC
2540: 
2541: 	*====================================================================
2542: 	* AjustarBotoesPorModo - Stub (OPERACIONAL nao tem modos CRUD)
2543: 	*====================================================================
2544: 	PROCEDURE AjustarBotoesPorModo()
2545: 		RETURN
2546: 	ENDPROC
2547: 
2548: 	*====================================================================
2549: 	* BtnBuscarClick - Carrega itens da lista por empresa/operacao/numes


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

