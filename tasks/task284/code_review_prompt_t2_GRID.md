# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 504: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES GRID/CURSOR
- [MADDCOLUNA] mAddColuna com parametro numerico. Assinatura: (campo, mascara, titulo) - TODOS strings
- [GRID-HEADERS] Apos RecordSource, Header1.Caption resetado para nome do campo. REDEFINIR todos os captions
- [SQLEXEC-GRID] SQLEXEC direto no cursor do Grid destroi colunas. Usar cursor temp + ZAP + APPEND
- [CREATE-CURSOR-NULL] SET NULL ON antes de CREATE CURSOR (APPEND de dados com NULL falha)
- [RECORDSOURCE-WITH] RecordSource/ColumnCount FORA do WITH block (dentro causa "Unknown member COLUMN1")
- [CURSOR-DUPLICADO] CREATE CURSOR duplicado com ordem diferente de campos
- [GRID-RECORDSOURCE-AUTOBIND] Apos .RecordSource =, REDEFINIR .ControlSource de TODAS as colunas

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEtq.prg) - TRECHOS RELEVANTES PARA PASS GRID (2569 linhas total):

*-- Linhas 45 a 73:
45: 				loc_lSucesso = .F.
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
65: 			THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
66: 			THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
67: 			THIS.TornarControlesVisiveis(THIS)
68: 
69: 			IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
70: 				THIS.this_oBusinessObject.CarregarConfiguracoes()
71: 				THIS.PopularTiposEtiqueta()
72: 				THIS.AplicarConfiguracoes()
73: 			ENDIF

*-- Linhas 490 a 622:
490: 			.Width     = 145
491: 			.Height    = 22
492: 			.Caption   = "Usar Pre" + CHR(231) + "o Produto"
493: 			.FontName  = "Tahoma"
494: 			.FontSize  = 8
495: 			.BackStyle = 0
496: 			.ForeColor = RGB(255, 255, 255)
497: 			.Value     = 0
498: 		ENDWITH
499: 
500: 		*-- Grid de Etiquetas (top=172)
501: 		THIS.AddObject("grd_4c_Etiquetas", "GridBase")
502: 		THIS.grd_4c_Etiquetas.RecordSourceType = 1
503: 		THIS.grd_4c_Etiquetas.ColumnCount = 3
504: 		THIS.grd_4c_Etiquetas.RecordSource     = "cursor_4c_Etiquetas"
505: 		THIS.grd_4c_Etiquetas.ColumnCount      = 7
506: 		WITH THIS.grd_4c_Etiquetas
507: 			.Top              = 172
508: 			.Left             = 12
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

*-- Linhas 636 a 676:
636: 		BINDEVENT(THIS.txt_4c_LPreco2,               "KeyPress", THIS, "TxtLPreco2KeyPress")
637: 		BINDEVENT(THIS.cmd_4c_BtnCarregar,           "Click",    THIS, "CmdBtnCarregarClick")
638: 		BINDEVENT(THIS.cmd_4c_BtnExcluir,            "Click",    THIS, "CmdBtnExcluirClick")
639: 		BINDEVENT(THIS.grd_4c_Etiquetas,             "KeyPress", THIS, "GrdEtiquetasKeyPress")
640: 		BINDEVENT(THIS.cmg_4c_BtnReport.Buttons(1), "Click",    THIS, "BtnImprimirClick")
641: 		BINDEVENT(THIS.cmg_4c_BtnReport.Buttons(2), "Click",    THIS, "BtnEncerrarClick")
642: 		BINDEVENT(THIS.txt_4c_Numes,                 "KeyPress", THIS, "TxtNumesKeyPress")
643: 		BINDEVENT(THIS.chk_4c_Lista,                 "Click",    THIS, "ChkListaClick")
644: 		BINDEVENT(THIS.chk_4c_Precio,                "Click",    THIS, "ChkPrecioClick")
645: 	ENDPROC
646: 
647: 	*====================================================================
648: 	* AlternarPagina - Stub (form flat, sem PageFrame)
649: 	*====================================================================
650: 	PROTECTED PROCEDURE AlternarPagina(par_nPagina)
651: 		RETURN
652: 	ENDPROC
653: 
654: 	*====================================================================
655: 	* GrdEtiquetasKeyPress - Enter na coluna 4 (Reffs) abre busca por ref
656: 	*====================================================================
657: 	PROCEDURE GrdEtiquetasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
658: 		IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
659: 			RETURN
660: 		ENDIF
661: 		IF THIS.grd_4c_Etiquetas.ActiveColumn = 4
662: 			THIS.AbrirBuscaProdutoRef()
663: 		ENDIF
664: 	ENDPROC
665: 
666: 	*====================================================================
667: 	* TxtEmpsKeyPress - Valida ou abre busca de empresa
668: 	*====================================================================
669: 	PROCEDURE TxtEmpsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
670: 		IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
671: 			RETURN
672: 		ENDIF
673: 		LOCAL loc_cEmps, loc_nRet, loc_oBusca
674: 		loc_cEmps = ALLTRIM(NVL(THIS.txt_4c_Emps.Value, ""))
675: 		IF !EMPTY(loc_cEmps)
676: 			loc_nRet = SQLEXEC(gnConnHandle, ;

*-- Linhas 692 a 711:
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

*-- Linhas 733 a 751:
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

*-- Linhas 841 a 859:
841: 		THIS.txt_4c_Cpros.Value = ""
842: 		THIS.txt_4c_Dpros.Value = ""
843: 		THIS.txt_4c_Qtds.Value  = 0
844: 		THIS.grd_4c_Etiquetas.Refresh()
845: 		THIS.txt_4c_Cpros.SetFocus()
846: 	ENDPROC
847: 
848: 	*====================================================================
849: 	* TxtLprecoKeyPress - Valida ou abre busca de lista de precos
850: 	*====================================================================
851: 	PROCEDURE TxtLprecoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
852: 		IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
853: 			RETURN
854: 		ENDIF
855: 		LOCAL loc_cLpreco, loc_nRet, loc_oBusca
856: 		loc_cLpreco = ALLTRIM(NVL(THIS.txt_4c_Lpreco.Value, ""))
857: 		IF !EMPTY(loc_cLpreco)
858: 			loc_nRet = SQLEXEC(gnConnHandle, ;
859: 				"SELECT TOP 1 LPrecos, DLPrecos FROM SigCdLpc " + ;

*-- Linhas 876 a 895:
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

*-- Linhas 911 a 930:
911: 			"Busca de Produto", .T., .T., "")
912: 		IF VARTYPE(loc_oBusca) = "O"
913: 			IF !loc_oBusca.this_lAchouRegistro
914: 				loc_oBusca.mAddColuna("Cpros", "", "C" + CHR(243) + "digo")
915: 				loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
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

*-- Linhas 936 a 955:
936: 			"Busca de Produto", .T., .T., "")
937: 		IF VARTYPE(loc_oBusca) = "O"
938: 			IF !loc_oBusca.this_lAchouRegistro
939: 				loc_oBusca.mAddColuna("Cpros", "", "C" + CHR(243) + "digo")
940: 				loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
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

*-- Linhas 964 a 999:
964: 			loc_cRef, "Busca por Refer" + CHR(234) + "ncia", .T., .T., "")
965: 		IF VARTYPE(loc_oBusca) = "O"
966: 			IF !loc_oBusca.this_lAchouRegistro
967: 				loc_oBusca.mAddColuna("Cpros",  "", "C" + CHR(243) + "digo")
968: 				loc_oBusca.mAddColuna("DPros",  "", "Descri" + CHR(231) + CHR(227) + "o")
969: 				loc_oBusca.mAddColuna("DPro2s", "", "Refer" + CHR(234) + "ncia")
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
998: 			"SELECT TOP 1 PVens, PrecoDe, PesoMs, DPro2s " + ;
999: 			"FROM SigCdPro WHERE RTRIM(Cpros)=" + EscaparSQL(par_cCpros), ;

*-- Linhas 1102 a 1120:
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
1118: 		IF EMPTY(loc_cEmps)
1119: 			MsgAviso("Informe a empresa.", "Aten" + CHR(231) + CHR(227) + "o")
1120: 			THIS.txt_4c_Emps.SetFocus()

*-- Linhas 1208 a 1296:
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
1261: 	* BtnAlterarClick - Coloca o foco no campo Cpros (produto) da linha
1262: 	* corrente do grid, permitindo alterar quantidade/produto. Adaptacao
1263: 	* CRUD do fluxo OPERACIONAL - a edicao eh inline no grid.
1264: 	*====================================================================
1265: 	PROCEDURE BtnAlterarClick()
1266: 		IF !USED("cursor_4c_Etiquetas") OR RECCOUNT("cursor_4c_Etiquetas") = 0
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
1286: 	*====================================================================
1287: 	* BtnVisualizarClick - Reposiciona no topo do grid, atualiza contagem
1288: 	* e mostra resumo dos itens carregados. Adaptacao CRUD do fluxo
1289: 	* OPERACIONAL - equivale a visualizar a lista selecionada.
1290: 	*====================================================================
1291: 	PROCEDURE BtnVisualizarClick()
1292: 		LOCAL loc_nTotal, loc_nQtdTotal, loc_cMensagem
1293: 		IF !USED("cursor_4c_Etiquetas") OR RECCOUNT("cursor_4c_Etiquetas") = 0
1294: 			MsgAviso("Nenhum item na lista.", "Aten" + CHR(231) + CHR(227) + "o")
1295: 			RETURN
1296: 		ENDIF

*-- Linhas 1302 a 1321:
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
1313: 	* BtnExcluirClick - Remove linha selecionada do grid (com confirmacao).
1314: 	* Delega para CmdBtnExcluirClick que faz a exclusao efetiva.
1315: 	*====================================================================
1316: 	PROCEDURE BtnExcluirClick()
1317: 		IF !USED("cursor_4c_Etiquetas") OR RECCOUNT("cursor_4c_Etiquetas") <= 1
1318: 			MsgAviso("Nenhum item para excluir.", "Aten" + CHR(231) + CHR(227) + "o")
1319: 			RETURN
1320: 		ENDIF
1321: 		SELECT cursor_4c_Etiquetas

*-- Linhas 1440 a 1458:
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
1455: 	*====================================================================
1456: 	PROTECTED PROCEDURE ConfigurarPaginaDados()
1457: 
1458: 		*-- Label titulo secao (sobre o grid)

*-- Linhas 2516 a 2552:
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
2550: 	*====================================================================
2551: 	PROCEDURE BtnBuscarClick()
2552: 		THIS.CarregarItensDaLista()

