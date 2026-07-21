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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEtq.prg) - TRECHOS RELEVANTES PARA PASS GRID (2565 linhas total):

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
65: 			THIS.TornarControlesVisiveis(THIS)
66: 
67: 			IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
68: 				THIS.this_oBusinessObject.CarregarConfiguracoes()
69: 				THIS.PopularTiposEtiqueta()
70: 				THIS.AplicarConfiguracoes()
71: 			ENDIF
72: 
73: 			loc_lSucesso = .T.

*-- Linhas 490 a 618:
490: 			.FontName  = "Tahoma"
491: 			.FontSize  = 8
492: 			.BackStyle = 0
493: 			.ForeColor = RGB(255, 255, 255)
494: 			.Value     = 0
495: 		ENDWITH
496: 
497: 		*-- Grid de Etiquetas (top=172)
498: 		THIS.AddObject("grd_4c_Etiquetas", "GridBase")
499: 		WITH THIS.grd_4c_Etiquetas
500: 			.Top              = 172
501: 			.Left             = 12
502: 			.Width            = 818
503: 			.Height           = 200
504: 			.RecordSource     = "cursor_4c_Etiquetas"
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

*-- Linhas 632 a 672:
632: 		BINDEVENT(THIS.txt_4c_LPreco2,               "KeyPress", THIS, "TxtLPreco2KeyPress")
633: 		BINDEVENT(THIS.cmd_4c_BtnCarregar,           "Click",    THIS, "CmdBtnCarregarClick")
634: 		BINDEVENT(THIS.cmd_4c_BtnExcluir,            "Click",    THIS, "CmdBtnExcluirClick")
635: 		BINDEVENT(THIS.grd_4c_Etiquetas,             "KeyPress", THIS, "GrdEtiquetasKeyPress")
636: 		BINDEVENT(THIS.cmg_4c_BtnReport.Buttons(1), "Click",    THIS, "BtnImprimirClick")
637: 		BINDEVENT(THIS.cmg_4c_BtnReport.Buttons(2), "Click",    THIS, "BtnEncerrarClick")
638: 		BINDEVENT(THIS.txt_4c_Numes,                 "KeyPress", THIS, "TxtNumesKeyPress")
639: 		BINDEVENT(THIS.chk_4c_Lista,                 "Click",    THIS, "ChkListaClick")
640: 		BINDEVENT(THIS.chk_4c_Precio,                "Click",    THIS, "ChkPrecioClick")
641: 	ENDPROC
642: 
643: 	*====================================================================
644: 	* AlternarPagina - Stub (form flat, sem PageFrame)
645: 	*====================================================================
646: 	PROTECTED PROCEDURE AlternarPagina(par_nPagina)
647: 		RETURN
648: 	ENDPROC
649: 
650: 	*====================================================================
651: 	* GrdEtiquetasKeyPress - Enter na coluna 4 (Reffs) abre busca por ref
652: 	*====================================================================
653: 	PROCEDURE GrdEtiquetasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
654: 		IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
655: 			RETURN
656: 		ENDIF
657: 		IF THIS.grd_4c_Etiquetas.ActiveColumn = 4
658: 			THIS.AbrirBuscaProdutoRef()
659: 		ENDIF
660: 	ENDPROC
661: 
662: 	*====================================================================
663: 	* TxtEmpsKeyPress - Valida ou abre busca de empresa
664: 	*====================================================================
665: 	PROCEDURE TxtEmpsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
666: 		IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
667: 			RETURN
668: 		ENDIF
669: 		LOCAL loc_cEmps, loc_nRet, loc_oBusca
670: 		loc_cEmps = ALLTRIM(NVL(THIS.txt_4c_Emps.Value, ""))
671: 		IF !EMPTY(loc_cEmps)
672: 			loc_nRet = SQLEXEC(gnConnHandle, ;

*-- Linhas 688 a 707:
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

*-- Linhas 729 a 747:
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

*-- Linhas 837 a 855:
837: 		THIS.txt_4c_Cpros.Value = ""
838: 		THIS.txt_4c_Dpros.Value = ""
839: 		THIS.txt_4c_Qtds.Value  = 0
840: 		THIS.grd_4c_Etiquetas.Refresh()
841: 		THIS.txt_4c_Cpros.SetFocus()
842: 	ENDPROC
843: 
844: 	*====================================================================
845: 	* TxtLprecoKeyPress - Valida ou abre busca de lista de precos
846: 	*====================================================================
847: 	PROCEDURE TxtLprecoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
848: 		IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
849: 			RETURN
850: 		ENDIF
851: 		LOCAL loc_cLpreco, loc_nRet, loc_oBusca
852: 		loc_cLpreco = ALLTRIM(NVL(THIS.txt_4c_Lpreco.Value, ""))
853: 		IF !EMPTY(loc_cLpreco)
854: 			loc_nRet = SQLEXEC(gnConnHandle, ;
855: 				"SELECT TOP 1 LPrecos, DLPrecos FROM SigCdLpc " + ;

*-- Linhas 872 a 891:
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

*-- Linhas 907 a 926:
907: 			"Busca de Produto", .T., .T., "")
908: 		IF VARTYPE(loc_oBusca) = "O"
909: 			IF !loc_oBusca.this_lAchouRegistro
910: 				loc_oBusca.mAddColuna("Cpros", "", "C" + CHR(243) + "digo")
911: 				loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
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

*-- Linhas 932 a 951:
932: 			"Busca de Produto", .T., .T., "")
933: 		IF VARTYPE(loc_oBusca) = "O"
934: 			IF !loc_oBusca.this_lAchouRegistro
935: 				loc_oBusca.mAddColuna("Cpros", "", "C" + CHR(243) + "digo")
936: 				loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
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

*-- Linhas 960 a 995:
960: 			loc_cRef, "Busca por Refer" + CHR(234) + "ncia", .T., .T., "")
961: 		IF VARTYPE(loc_oBusca) = "O"
962: 			IF !loc_oBusca.this_lAchouRegistro
963: 				loc_oBusca.mAddColuna("Cpros",  "", "C" + CHR(243) + "digo")
964: 				loc_oBusca.mAddColuna("DPros",  "", "Descri" + CHR(231) + CHR(227) + "o")
965: 				loc_oBusca.mAddColuna("DPro2s", "", "Refer" + CHR(234) + "ncia")
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

*-- Linhas 1098 a 1116:
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
1114: 		IF EMPTY(loc_cEmps)
1115: 			MsgAviso("Informe a empresa.", "Aten" + CHR(231) + CHR(227) + "o")
1116: 			THIS.txt_4c_Emps.SetFocus()

*-- Linhas 1204 a 1292:
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
1257: 	* BtnAlterarClick - Coloca o foco no campo Cpros (produto) da linha
1258: 	* corrente do grid, permitindo alterar quantidade/produto. Adaptacao
1259: 	* CRUD do fluxo OPERACIONAL - a edicao eh inline no grid.
1260: 	*====================================================================
1261: 	PROCEDURE BtnAlterarClick()
1262: 		IF !USED("cursor_4c_Etiquetas") OR RECCOUNT("cursor_4c_Etiquetas") = 0
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
1282: 	*====================================================================
1283: 	* BtnVisualizarClick - Reposiciona no topo do grid, atualiza contagem
1284: 	* e mostra resumo dos itens carregados. Adaptacao CRUD do fluxo
1285: 	* OPERACIONAL - equivale a visualizar a lista selecionada.
1286: 	*====================================================================
1287: 	PROCEDURE BtnVisualizarClick()
1288: 		LOCAL loc_nTotal, loc_nQtdTotal, loc_cMensagem
1289: 		IF !USED("cursor_4c_Etiquetas") OR RECCOUNT("cursor_4c_Etiquetas") = 0
1290: 			MsgAviso("Nenhum item na lista.", "Aten" + CHR(231) + CHR(227) + "o")
1291: 			RETURN
1292: 		ENDIF

*-- Linhas 1298 a 1317:
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
1309: 	* BtnExcluirClick - Remove linha selecionada do grid (com confirmacao).
1310: 	* Delega para CmdBtnExcluirClick que faz a exclusao efetiva.
1311: 	*====================================================================
1312: 	PROCEDURE BtnExcluirClick()
1313: 		IF !USED("cursor_4c_Etiquetas") OR RECCOUNT("cursor_4c_Etiquetas") <= 1
1314: 			MsgAviso("Nenhum item para excluir.", "Aten" + CHR(231) + CHR(227) + "o")
1315: 			RETURN
1316: 		ENDIF
1317: 		SELECT cursor_4c_Etiquetas

*-- Linhas 1436 a 1454:
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
1451: 	*====================================================================
1452: 	PROTECTED PROCEDURE ConfigurarPaginaDados()
1453: 
1454: 		*-- Label titulo secao (sobre o grid)

*-- Linhas 2512 a 2548:
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
2546: 	*====================================================================
2547: 	PROCEDURE BtnBuscarClick()
2548: 		THIS.CarregarItensDaLista()

