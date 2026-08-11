# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, DOPES, COPERS, TOTA

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
  Column1.ControlSource = ""
		.AddCursor('SigOpFpo','CidChaves','crSigOpFpo','fpags',.f.,[Select * From SigOpFpo Where Dopes = ?crSigCdOpe.Dopes Order by Dopes])
		Select crSigOpFp
	.DeleteMark = .f.
	.Column1.ControlSource = 'crSigOpFpO.Fpags'
	.Column2.ControlSource = 'crSigOpFpO.Obrigs'
	.Column3.ControlSource = 'crSigOpFpO.Autos'
	.Column4.ControlSource = 'crSigOpFpO.Contabs'
	.Column5.ControlSource = 'crSigOpFpO.Fpagss'
Select crSigOpFpO
Select crSigOpFpo
		Select crSigOpFpO
			SELECT crSigOpFpo
		Select crSigOpFpO
	Select crSigOpFpo
Select crSigOpFpo
	Select crSigOpFpo
Select crSigOpFpo
	Select crSigOpFpo
Select crSigOpFpo
	Select a.* From CrSigOpFp a Into Cursor CsFpagto
	Select CsFpagto
Select crSigOpFpO
	Delete
Select FPags, sum(1) as TT From crSigOpFpo Where Dopes = crSigCdOpe.Dopes GROUP by 1 Into cursor Totais
Select Totais
	Select crSigOpFpo
			Delete
		m.lnErro1 = Iif(.poDataMgr.UpDate('crSigOpFpo'),1,-1)
Select crSigOpFpO

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormFpo.prg) - TRECHOS RELEVANTES PARA PASS SQL (1308 linhas total):

*-- Linhas 261 a 279:
261:                 .Height             = 380
262:                 .FontName           = "Tahoma"
263:                 .FontSize           = 8
264:                 .DeleteMark         = .F.
265:                 .RecordMark         = .F.
266:                 .RowHeight          = 20
267:                 .GridLineColor      = RGB(200, 200, 200)
268:                 .GridLines          = 3
269:                 .HighlightStyle     = 2
270:                 .HighlightBackColor = RGB(255, 255, 255)
271:                 .HighlightForeColor = RGB(15, 41, 104)
272:                 .ScrollBars         = 2
273:                 .Visible            = .T.
274:             ENDWITH
275: 
276:             *-- BINDEVENTs para colunas de texto (F4 abre lookup de condicao de pagamento)
277:             BINDEVENT(loc_oPagina.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "GradeCol1KeyPress")
278:             BINDEVENT(loc_oPagina.grd_4c_Dados.Column5.Text1, "KeyPress", THIS, "GradeCol5KeyPress")
279:             BINDEVENT(loc_oPagina.grd_4c_Dados, "AfterRowColChange", THIS, "GradeAfterRowColChange")

*-- Linhas 546 a 687:
546: 
547:     *--------------------------------------------------------------------------
548:     * CarregarGrade - Carrega dados de SigOpFpo em cursor_4c_Dados e configura
549:     * a grade. Usa CREATE CURSOR para manter cursor editavel (APPEND BLANK/REPLACE
550:     * funcionam sem restricoes, ao contrario de cursor de SQLEXEC direto).
551:     *--------------------------------------------------------------------------
552:     PROTECTED PROCEDURE CarregarGrade()
553:         LOCAL loc_lResultado, loc_oGrid, loc_cSQL, loc_nResultado, loc_oErro
554:         loc_lResultado = .F.
555: 
556:         TRY
557:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
558: 
559:             loc_cSQL = "SELECT CidChaves, Dopes, FPags, Obrigs, Autos, Contabs," + ;
560:                        " FPagss, BlqAltExc" + ;
561:                        " FROM SigOpFpo" + ;
562:                        " WHERE Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopes)) + ;
563:                        " ORDER BY FPags"
564: 
565:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp")
566: 
567:             IF loc_nResultado < 0
568:                 MsgErro(CapturarErroSQL(), "Erro ao carregar grade")
569:             ELSE
570:                 *-- Criar ou reinicializar cursor editavel para a grade (Problema 34/35)
571:                 IF !USED("cursor_4c_Dados")
572:                     SET NULL ON
573:                     CREATE CURSOR cursor_4c_Dados (;
574:                         CidChaves C(20), Dopes C(20), FPags C(12), ;
575:                         Obrigs    N(1,0), Autos N(1,0), Contabs N(1,0), ;
576:                         FPagss    C(12),  BlqAltExc N(1,0))
577:                     SET NULL OFF
578:                 ELSE
579:                     ZAP IN cursor_4c_Dados
580:                 ENDIF
581: 
582:                 IF RECCOUNT("cursor_4c_DadosTemp") > 0
583:                     APPEND FROM DBF("cursor_4c_DadosTemp")
584:                 ENDIF
585:                 GO TOP IN cursor_4c_Dados
586: 
587:                 *-- Carregar cursor de lookup de condicoes de pagamento (crSigOpFp)
588:                 THIS.this_oBusinessObject.BuscarCondicoesPagamento()
589: 
590:                 *-- RecordSource e ColumnCount FORA do WITH (Problema 36)
591:                 loc_oGrid.ColumnCount = 3
592:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
593:                 loc_oGrid.ColumnCount  = 5
594: 
595:                 *-- Configurar colunas APOS RecordSource (Problema 48)
596:                 WITH loc_oGrid
597:                     .Column1.ControlSource   = "cursor_4c_Dados.FPags"
598:                     .Column1.Width           = 230
599:                     .Column1.Sparse          = .T.
600:                     .Column1.Header1.Caption = "Condi" + CHR(231) + CHR(227) + "o Pagto"
601:                     .Column1.Text1.MaxLength = 12
602: 
603:                     .Column2.ControlSource   = "cursor_4c_Dados.Obrigs"
604:                     .Column2.Width           = 42
605:                     .Column2.Sparse          = .F.
606:                     .AddObject("Check1", "CheckBox")
607:                     .Check1.Caption = ""
608:                     .Check1.Alignment = 0
609:                     .Check1.ReadOnly  = .F.
610:                     .Check1.Visible   = .T.
611:                     .Check1.Top       = 9
612:                     .Check1.Left      = 2
613:                     .Check1.Height    = 17
614:                     .Check1.Width     = 22
615:                     .Column2.CurrentControl  = "Check1"
616:                     .Column2.Header1.Caption = "O"
617:                     .Column2.Check1.Alignment = 0
618:                     .Column2.Check1.ReadOnly  = .F.
619:                     .Column2.Check1.Visible   = .T.
620:                     .Column2.Check1.Top       = 9
621:                     .Column2.Check1.Left      = 2
622:                     .Column2.Check1.Height    = 17
623:                     .Column2.Check1.Width     = 22
624:                     .Column2.Check1.Caption   = ""
625: 
626:                     .Column3.ControlSource   = "cursor_4c_Dados.Autos"
627:                     .Column3.Width           = 42
628:                     .Column3.Sparse          = .F.
629:                     .AddObject("Check1", "CheckBox")
630:                     .Check1.Caption = ""
631:                     .Check1.Alignment = 0
632:                     .Check1.ReadOnly  = .F.
633:                     .Check1.Visible   = .T.
634:                     .Check1.Top       = 9
635:                     .Check1.Left      = 2
636:                     .Check1.Height    = 17
637:                     .Check1.Width     = 22
638:                     .Column3.CurrentControl  = "Check1"
639:                     .Column3.Header1.Caption = "A"
640:                     .Column3.Check1.Alignment = 0
641:                     .Column3.Check1.ReadOnly  = .F.
642:                     .Column3.Check1.Visible   = .T.
643:                     .Column3.Check1.Top       = 9
644:                     .Column3.Check1.Left      = 2
645:                     .Column3.Check1.Height    = 17
646:                     .Column3.Check1.Width     = 22
647:                     .Column3.Check1.Caption   = ""
648: 
649:                     .Column4.ControlSource   = "cursor_4c_Dados.Contabs"
650:                     .Column4.Width           = 42
651:                     .Column4.Sparse          = .F.
652:                     .AddObject("Check1", "CheckBox")
653:                     .Check1.Caption = ""
654:                     .Check1.Alignment = 0
655:                     .Check1.ReadOnly  = .F.
656:                     .Check1.Visible   = .T.
657:                     .Check1.Top       = 9
658:                     .Check1.Left      = 2
659:                     .Check1.Height    = 17
660:                     .Check1.Width     = 22
661:                     .Column4.CurrentControl  = "Check1"
662:                     .Column4.Header1.Caption = "C"
663:                     .Column4.Check1.Alignment = 0
664:                     .Column4.Check1.ReadOnly  = .F.
665:                     .Column4.Check1.Visible   = .T.
666:                     .Column4.Check1.Top       = 9
667:                     .Column4.Check1.Left      = 2
668:                     .Column4.Check1.Height    = 17
669:                     .Column4.Check1.Width     = 22
670:                     .Column4.Check1.Caption   = ""
671: 
672:                     .Column5.ControlSource   = "cursor_4c_Dados.FPagss"
673:                     .Column5.Width           = 230
674:                     .Column5.Sparse          = .T.
675:                     .Column5.Header1.Caption = "Substituir"
676:                     .Column5.Text1.MaxLength = 12
677: 
678:                     *-- Cores das colunas CheckBox (fidelidade visual PILAR 1)
679:                     .Column2.BackColor = RGB(216, 39, 70)
680:                     .Column3.BackColor = RGB(0, 0, 128)
681:                     .Column4.BackColor = RGB(0, 128, 255)
682: 
683:                     *-- Propriedades visuais dos Headers (PILAR 1)
684:                     .Column1.Header1.FontBold  = .T.
685:                     .Column1.Header1.ForeColor = RGB(90, 90, 90)
686:                     .Column1.Header1.Alignment = 2
687:                     .Column2.Header1.FontBold  = .T.

*-- Linhas 738 a 756:
738: 
739:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
740: 
741:             SELECT cursor_4c_Dados
742:             APPEND BLANK
743:             REPLACE Dopes     WITH ALLTRIM(THIS.this_cDopes)
744:             REPLACE FPags     WITH ""
745:             REPLACE Obrigs    WITH 0
746:             REPLACE Autos     WITH 0
747:             REPLACE Contabs   WITH 0
748:             REPLACE FPagss    WITH ""
749:             REPLACE BlqAltExc WITH 0
750:             GO BOTTOM IN cursor_4c_Dados
751: 
752:             loc_oGrid.Refresh()
753:             loc_oGrid.Column1.SetFocus()
754:         CATCH TO loc_oErro
755:             MsgErro(loc_oErro.Message, "Erro em BtnInserirClick")
756:         ENDTRY

*-- Linhas 773 a 792:
773: 
774:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
775: 
776:             SELECT cursor_4c_Dados
777:             DELETE
778:             SKIP
779:             IF EOF("cursor_4c_Dados")
780:                 SKIP -1
781:             ENDIF
782: 
783:             loc_oGrid.Refresh()
784:         CATCH TO loc_oErro
785:             MsgErro(loc_oErro.Message, "Erro em BtnExcluirClick")
786:         ENDTRY
787:     ENDPROC
788: 
789:     *--------------------------------------------------------------------------
790:     * BtnEncerrarClick - Valida, salva e fecha (cmdSair no legado)
791:     * Logica: valida duplicatas via BO.SalvarLote, fecha form se sucesso
792:     *--------------------------------------------------------------------------

*-- Linhas 814 a 832:
814: 
815:         TRY
816:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND !BOF("cursor_4c_Dados")
817:                 SELECT cursor_4c_Dados
818:                 IF VARTYPE(BlqAltExc) = "L"
819:                     loc_lBloqueado = BlqAltExc
820:                 ELSE
821:                     loc_lBloqueado = (NVL(BlqAltExc, 0) = 1)
822:                 ENDIF
823: 
824:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Botoes", 5)
825:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
826:                         THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled = !loc_lBloqueado
827:                     ENDIF
828:                 ENDIF
829:             ENDIF
830:         CATCH TO loc_oErro
831:             MsgErro(loc_oErro.Message, "Erro em GradeAfterRowColChange")
832:         ENDTRY

*-- Linhas 887 a 905:
887: 
888:                 IF loc_oBusca.this_lSelecionou AND USED("crSigOpFp")
889:                     IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
890:                         SELECT cursor_4c_Dados
891:                         IF loc_cCampoDestino = "FPags"
892:                             REPLACE FPags  WITH ALLTRIM(crSigOpFp.FPags)
893:                         ELSE
894:                             REPLACE FPagss WITH ALLTRIM(crSigOpFp.FPags)
895:                         ENDIF
896:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
897:                     ENDIF
898:                 ENDIF
899: 
900:                 loc_oBusca.Release()
901:             ELSE
902:                 MsgErro("Erro ao criar FormBuscaAuxiliar", "Lookup")
903:             ENDIF
904:         CATCH TO loc_oErro
905:             MsgErro(loc_oErro.Message, "Erro em AbrirLookupFPags")

*-- Linhas 947 a 1040:
947:         IF INLIST(par_nKeyCode, 13, 32)
948:             TRY
949:                 IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND !BOF("cursor_4c_Dados")
950:                     SELECT cursor_4c_Dados
951:                     REPLACE Obrigs WITH IIF(cursor_4c_Dados.Obrigs = 1, 0, 1)
952:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
953:                 ENDIF
954:             CATCH TO loc_oErro
955:                 MsgErro(loc_oErro.Message, "Erro em GradeCol2CheckKeyPress")
956:             ENDTRY
957:         ENDIF
958:     ENDPROC
959: 
960:     *--------------------------------------------------------------------------
961:     * GradeCol3CheckKeyPress - KeyPress no CheckBox da coluna Auto (Column3)
962:     * Enter (13) ou Space (32) alterna Autos do registro atual (mirror do KeyPress legado)
963:     *--------------------------------------------------------------------------
964:     PROCEDURE GradeCol3CheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
965:         LOCAL loc_oErro
966:         IF INLIST(par_nKeyCode, 13, 32)
967:             TRY
968:                 IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND !BOF("cursor_4c_Dados")
969:                     SELECT cursor_4c_Dados
970:                     REPLACE Autos WITH IIF(cursor_4c_Dados.Autos = 1, 0, 1)
971:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
972:                 ENDIF
973:             CATCH TO loc_oErro
974:                 MsgErro(loc_oErro.Message, "Erro em GradeCol3CheckKeyPress")
975:             ENDTRY
976:         ENDIF
977:     ENDPROC
978: 
979:     *--------------------------------------------------------------------------
980:     * GradeCol4CheckKeyPress - KeyPress no CheckBox da coluna Nao Contabilizar (Column4)
981:     * Enter (13) ou Space (32) alterna Contabs do registro atual (mirror do KeyPress legado)
982:     *--------------------------------------------------------------------------
983:     PROCEDURE GradeCol4CheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
984:         LOCAL loc_oErro
985:         IF INLIST(par_nKeyCode, 13, 32)
986:             TRY
987:                 IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND !BOF("cursor_4c_Dados")
988:                     SELECT cursor_4c_Dados
989:                     REPLACE Contabs WITH IIF(cursor_4c_Dados.Contabs = 1, 0, 1)
990:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
991:                 ENDIF
992:             CATCH TO loc_oErro
993:                 MsgErro(loc_oErro.Message, "Erro em GradeCol4CheckKeyPress")
994:             ENDTRY
995:         ENDIF
996:     ENDPROC
997: 
998:     *--------------------------------------------------------------------------
999:     * GradeCol1TextLostFocus - LostFocus na coluna FPags (Column1.Text1)
1000:     * Quando FPags esta vazio, redireciona foco para botao Encerrar
1001:     * (mirror do LostFocus original: "If IsEmpty(This.Value): Thisform.cmdSair.SetFocus")
1002:     *--------------------------------------------------------------------------
1003:     PROCEDURE GradeCol1TextLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1004:         LOCAL loc_oErro
1005:         TRY
1006:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1007:                 SELECT cursor_4c_Dados
1008:                 IF EMPTY(ALLTRIM(cursor_4c_Dados.FPags))
1009:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes.cmd_4c_Encerrar.SetFocus()
1010:                 ENDIF
1011:             ENDIF
1012:         CATCH TO loc_oErro
1013:             MsgErro(loc_oErro.Message, "Erro em GradeCol1TextLostFocus")
1014:         ENDTRY
1015:     ENDPROC
1016: 
1017:     *--------------------------------------------------------------------------
1018:     * GradeCol1HeaderClick - Click no Header da coluna FPags (Column1.Header1)
1019:     * Reordena cursor_4c_Dados por FPags (mirror do Click legado no Header1)
1020:     *--------------------------------------------------------------------------
1021:     PROCEDURE GradeCol1HeaderClick()
1022:         LOCAL loc_oErro
1023:         TRY
1024:             IF USED("cursor_4c_Dados")
1025:                 SELECT cursor_4c_Dados
1026:                 INDEX ON FPags TAG FPags COMPACT
1027:                 SET ORDER TO TAG FPags IN cursor_4c_Dados
1028:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
1029:             ENDIF
1030:         CATCH TO loc_oErro
1031:             MsgErro(loc_oErro.Message, "Erro em GradeCol1HeaderClick")
1032:         ENDTRY
1033:     ENDPROC
1034: 
1035:     *--------------------------------------------------------------------------
1036:     * BtnIncluirClick - Alias canonico do fluxo "Incluir" (append blank na grade)
1037:     * Form OPERACIONAL: sem Page2/CRUD separado; edicao acontece inline na grade.
1038:     * Reusa a logica de BtnInserirClick (equivalente ao cmdInserir legado).
1039:     *--------------------------------------------------------------------------
1040:     PROCEDURE BtnIncluirClick()

*-- Linhas 1049 a 1067:
1049: 
1050:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
1051: 
1052:             SELECT cursor_4c_Dados
1053:             APPEND BLANK
1054:             REPLACE Dopes     WITH ALLTRIM(THIS.this_cDopes)
1055:             REPLACE FPags     WITH ""
1056:             REPLACE Obrigs    WITH 0
1057:             REPLACE Autos     WITH 0
1058:             REPLACE Contabs   WITH 0
1059:             REPLACE FPagss    WITH ""
1060:             REPLACE BlqAltExc WITH 0
1061:             GO BOTTOM IN cursor_4c_Dados
1062: 
1063:             THIS.this_cModoAtual = "INCLUIR"
1064:             loc_oGrid.Refresh()
1065:             loc_oGrid.Column1.SetFocus()
1066:         CATCH TO loc_oErro
1067:             MsgErro(loc_oErro.Message, "Erro em BtnIncluirClick")

*-- Linhas 1087 a 1105:
1087:                 RETURN
1088:             ENDIF
1089: 
1090:             SELECT cursor_4c_Dados
1091:             IF NVL(cursor_4c_Dados.BlqAltExc, 0) = 1
1092:                 MsgAviso("Registro bloqueado para altera" + CHR(231) + CHR(227) + "o.", "")
1093:                 RETURN
1094:             ENDIF
1095: 
1096:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
1097: 
1098:             THIS.this_cModoAtual = "ALTERAR"
1099:             loc_oGrid.Refresh()
1100:             loc_oGrid.SetFocus()
1101:             loc_oGrid.ActivateCell(RECNO("cursor_4c_Dados"), 1)
1102:         CATCH TO loc_oErro
1103:             MsgErro(loc_oErro.Message, "Erro em BtnAlterarClick")
1104:         ENDTRY
1105:     ENDPROC

*-- Linhas 1119 a 1137:
1119:             ENDIF
1120: 
1121:             IF EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
1122:                 SELECT cursor_4c_Dados
1123:                 GO TOP
1124:             ENDIF
1125: 
1126:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
1127: 
1128:             THIS.this_cModoAtual = "VISUALIZAR"
1129:             loc_oGrid.Refresh()
1130:             loc_oGrid.SetFocus()
1131:             loc_oGrid.ActivateCell(RECNO("cursor_4c_Dados"), 1)
1132:         CATCH TO loc_oErro
1133:             MsgErro(loc_oErro.Message, "Erro em BtnVisualizarClick")
1134:         ENDTRY
1135:     ENDPROC
1136: 
1137:     *--------------------------------------------------------------------------

*-- Linhas 1191 a 1209:
1191:         ENDIF
1192: 
1193:         TRY
1194:             SELECT cursor_4c_Dados
1195:             THIS.this_oBusinessObject.this_cCidChaves = ALLTRIM(NVL(CidChaves, ""))
1196:             THIS.this_oBusinessObject.this_cDopes     = ALLTRIM(NVL(Dopes,    ""))
1197:             THIS.this_oBusinessObject.this_cFPags     = ALLTRIM(NVL(FPags,    ""))
1198:             THIS.this_oBusinessObject.this_nObrigs    = NVL(Obrigs,    0)
1199:             THIS.this_oBusinessObject.this_nAutos     = NVL(Autos,     0)
1200:             THIS.this_oBusinessObject.this_nContabs   = NVL(Contabs,   0)
1201:             THIS.this_oBusinessObject.this_cFPagss    = ALLTRIM(NVL(FPagss,   ""))
1202:             THIS.this_oBusinessObject.this_nBlqAltExc = NVL(BlqAltExc, 0)
1203:             loc_lResultado = .T.
1204:         CATCH TO loc_oErro
1205:             MsgErro(loc_oErro.Message, "Erro em FormParaBO")
1206:         ENDTRY
1207: 
1208:         RETURN loc_lResultado
1209:     ENDPROC

*-- Linhas 1220 a 1238:
1220:         ENDIF
1221: 
1222:         TRY
1223:             SELECT cursor_4c_Dados
1224:             REPLACE CidChaves WITH ALLTRIM(THIS.this_oBusinessObject.this_cCidChaves)
1225:             REPLACE Dopes     WITH ALLTRIM(THIS.this_oBusinessObject.this_cDopes)
1226:             REPLACE FPags     WITH ALLTRIM(THIS.this_oBusinessObject.this_cFPags)
1227:             REPLACE Obrigs    WITH THIS.this_oBusinessObject.this_nObrigs
1228:             REPLACE Autos     WITH THIS.this_oBusinessObject.this_nAutos
1229:             REPLACE Contabs   WITH THIS.this_oBusinessObject.this_nContabs
1230:             REPLACE FPagss    WITH ALLTRIM(THIS.this_oBusinessObject.this_cFPagss)
1231:             REPLACE BlqAltExc WITH THIS.this_oBusinessObject.this_nBlqAltExc
1232:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
1233:             loc_lResultado = .T.
1234:         CATCH TO loc_oErro
1235:             MsgErro(loc_oErro.Message, "Erro em BOParaForm")
1236:         ENDTRY
1237: 
1238:         RETURN loc_lResultado


### BO (C:\4c\projeto\app\classes\FpoBO.prg):
*==============================================================================
* FpoBO.prg - Business Object de Condicao de Pagamento Por Operacao
* Tabela: SigOpFpo
* PK: cidchaves
*==============================================================================

DEFINE CLASS FpoBO AS BusinessBase

    *-- Propriedades da tabela SigOpFpo
    this_cCidChaves  = ""    && PK char(20) - chave unica gerada
    this_cDopes      = ""    && char(20) - codigo da operacao (FK SigCdOpe)
    this_cFPags      = ""    && char(12) - condicao de pagamento (FK SigOpFp)
    this_nObrigs     = 0     && numeric(1,0) - obrigatorio (0/1)
    this_nAutos      = 0     && numeric(1,0) - so automatico (0/1)
    this_nContabs    = 0     && numeric(1,0) - nao contabilizar (0/1)
    this_cFPagss     = ""    && char(12) - condicao substituta
    this_nBlqAltExc  = 0     && numeric(1,0) - bloqueado para alterar/excluir (0/1)

    *-- Contexto de operacao corrente (preenchido pelo Form antes de Buscar)
    this_cDopesAtual = ""    && codigo da operacao em edicao

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigOpFpo"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves  = TratarNulo(CidChaves, "C")
            THIS.this_cDopes      = TratarNulo(Dopes,     "C")
            THIS.this_cFPags      = TratarNulo(FPags,     "C")
            THIS.this_nObrigs     = TratarNulo(Obrigs,    "N")
            THIS.this_nAutos      = TratarNulo(Autos,     "N")
            THIS.this_nContabs    = TratarNulo(Contabs,   "N")
            THIS.this_cFPagss     = TratarNulo(FPagss,    "C")
            THIS.this_nBlqAltExc  = TratarNulo(BlqAltExc, "N")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo CidChaves (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cChave)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT CidChaves, Dopes, FPags, Obrigs, Autos, Contabs," + ;
                       " FPagss, BlqAltExc" + ;
                       " FROM SigOpFpo" + ;
                       " WHERE CidChaves = " + EscaparSQL(ALLTRIM(par_cChave))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CarregaFpo")
            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_CarregaFpo") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_CarregaFpo")
                IF loc_lResultado
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Registro n" + CHR(227) + "o encontrado"
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro - CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_CarregaFpo")
            USE IN cursor_4c_CarregaFpo
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega registros de SigOpFpo filtrados por Dopes
    * Retorna cursor_4c_Dados com as condicoes de pagamento da operacao
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_cWhere
        loc_lResultado = .F.

        TRY
            loc_cWhere = ""

            IF !EMPTY(ALLTRIM(THIS.this_cDopesAtual))
                loc_cWhere = "WHERE Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopesAtual))
            ENDIF

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                IF EMPTY(loc_cWhere)
                    loc_cWhere = "WHERE " + par_cFiltro
                ELSE
                    loc_cWhere = loc_cWhere + " AND " + par_cFiltro
                ENDIF
            ENDIF

            loc_cSQL = "SELECT CidChaves, Dopes, FPags, Obrigs, Autos, Contabs," + ;
                       " FPagss, BlqAltExc" + ;
                       " FROM SigOpFpo " + loc_cWhere + ;
                       " ORDER BY FPags"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro - Buscar")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro - Buscar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarCondicoesPagamento - Carrega SigOpFp disponivel em crSigOpFp
    * Usado pelo lookup do campo FPags no grid
    *--------------------------------------------------------------------------
    PROCEDURE BuscarCondicoesPagamento()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT FPags, Fparcs, Situas FROM SigOpFp ORDER BY FPags"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigOpFp")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro - BuscarCondicoesPagamento")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro - BuscarCondicoesPagamento")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDuplicados - Valida se ha FPags duplicados no cursor
    * Retorna .T. se valido (sem duplicatas), .F. se ha duplicatas
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDuplicados(par_cCursorDados)
        LOCAL loc_lResultado, loc_cFPagsAnt, loc_cFPagsAtual
        loc_lResultado = .T.

        IF !USED(par_cCursorDados)
            RETURN .T.
        ENDIF

        TRY
            *-- Ordena copia do cursor por FPags para detectar adjacentes iguais
            SELECT FPags FROM (par_cCursorDados) ;
                WHERE !EMPTY(ALLTRIM(FPags)) ORDER BY FPags ;
                INTO CURSOR cursor_4c_SortFpo

            IF USED("cursor_4c_SortFpo")
                SELECT cursor_4c_SortFpo
                GO TOP
                loc_cFPagsAnt = ""
                SCAN
                    loc_cFPagsAtual = ALLTRIM(FPags)
                    IF loc_cFPagsAtual == loc_cFPagsAnt
                        MsgAviso("Condi" + CHR(231) + CHR(227) + "o de Pagamento " + ;
                            loc_cFPagsAtual + " Digitada em Duplicidade!!!!", ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lResultado = .F.
                        EXIT
                    ENDIF
                    loc_cFPagsAnt = loc_cFPagsAtual
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro - ValidarDuplicados")
            loc_lResultado = .F.
        ENDTRY

        IF USED("cursor_4c_SortFpo")
            USE IN cursor_4c_SortFpo
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarLote - Salva todos os registros do grid de volta ao SigOpFpo
    * par_cDopes: codigo da operacao
    * par_cCursorDados: alias do cursor com os dados do grid (ex: crSigOpFpo)
    * Logica: valida duplicatas, gera chaves, delete+insert atomico no SQL Server
    *--------------------------------------------------------------------------
    PROCEDURE SalvarLote(par_cDopes, par_cCursorDados)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        LOCAL loc_cCidChaves, loc_lTransacaoAberta, loc_lErroInsert
        loc_lResultado    = .F.
        loc_lTransacaoAberta = .F.
        loc_lErroInsert   = .F.

        *-- Validacoes de entrada ANTES do TRY (retornos validos aqui)
        IF EMPTY(ALLTRIM(par_cDopes))
            MsgAviso("C" + CHR(243) + "digo da opera" + CHR(231) + CHR(227) + ;
                "o n" + CHR(227) + "o informado", "")
            RETURN .F.
        ENDIF

        IF !USED(par_cCursorDados)
            MsgAviso("Cursor de dados n" + CHR(227) + "o encontrado", "")
            RETURN .F.
        ENDIF

        IF !THIS.ValidarDuplicados(par_cCursorDados)
            RETURN .F.
        ENDIF

        TRY
            *-- Gerar CidChaves para linhas novas (FPags nao vazio, CidChaves vazio)
            SELECT (par_cCursorDados)
            GO TOP
            SCAN
                IF !EMPTY(ALLTRIM(FPags)) AND EMPTY(ALLTRIM(CidChaves))
                    loc_cCidChaves = fUniqueIds()
                    REPLACE CidChaves WITH loc_cCidChaves IN (par_cCursorDados)
                ENDIF
            ENDSCAN

            *-- Abrir transacao atomica
            loc_nResultado = SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
            IF loc_nResultado >= 0
                loc_lTransacaoAberta = .T.

                *-- Deletar todos os registros existentes da operacao
                loc_cSQL = "DELETE FROM SigOpFpo WHERE Dopes = " + ;
                    EscaparSQL(ALLTRIM(par_cDopes))
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    *-- Reinserir as linhas validas (com FPags preenchido)
                    SELECT (par_cCursorDados)
                    GO TOP
                    SCAN WHILE !loc_lErroInsert
                        IF !EMPTY(ALLTRIM(FPags))
                            THIS.this_cCidChaves = ALLTRIM(CidChaves)
                            THIS.this_cDopes     = ALLTRIM(Dopes)
                            THIS.this_cFPags     = ALLTRIM(FPags)
                            THIS.this_nObrigs    = NVL(Obrigs, 0)
                            THIS.this_nAutos     = NVL(Autos, 0)
                            THIS.this_nContabs   = NVL(Contabs, 0)
                            THIS.this_cFPagss    = ALLTRIM(NVL(FPagss, ""))
                            THIS.this_nBlqAltExc = NVL(BlqAltExc, 0)
                            IF !THIS.Inserir()
                                loc_lErroInsert = .T.
                            ENDIF
                        ENDIF
                    ENDSCAN
                ELSE
                    THIS.this_cMensagemErro = CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro ao excluir registros anteriores")
                    loc_lErroInsert = .T.
                ENDIF

                IF !loc_lErroInsert
                    loc_nResultado = SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                    IF loc_nResultado >= 0
                        loc_lTransacaoAberta = .F.
                        THIS.RegistrarAuditoria("UPDATE")
                        loc_lResultado = .T.
                    ELSE
                        THIS.this_cMensagemErro = CapturarErroSQL()
                        MsgErro(THIS.this_cMensagemErro, "Erro - SalvarLote COMMIT")
                    ENDIF
                ENDIF

                IF loc_lTransacaoAberta
                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                ENDIF
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro - SalvarLote BEGIN TRANSACTION")
            ENDIF

        CATCH TO loc_oErro
            IF loc_lTransacaoAberta
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            ENDIF
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro - SalvarLote")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT de um unico registro em SigOpFpo
    * Chamado por SalvarLote e por BusinessBase.Salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF

            loc_cSQL = "INSERT INTO SigOpFpo" + ;
                " (CidChaves, Dopes, FPags, Obrigs, Autos, Contabs, FPagss, BlqAltExc)" + ;
                " VALUES (" + ;
                EscaparSQL(THIS.this_cCidChaves)  + ", " + ;
                EscaparSQL(THIS.this_cDopes)       + ", " + ;
                EscaparSQL(THIS.this_cFPags)       + ", " + ;
                FormatarNumeroSQL(THIS.this_nObrigs)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nAutos)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nContabs)  + ", " + ;
                EscaparSQL(THIS.this_cFPagss)      + ", " + ;
                FormatarNumeroSQL(THIS.this_nBlqAltExc) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro - Inserir")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro - Inserir")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE de um registro em SigOpFpo pelo CidChaves
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigOpFpo SET" + ;
                " Dopes    = " + EscaparSQL(THIS.this_cDopes)          + ", " + ;
                " FPags    = " + EscaparSQL(THIS.this_cFPags)          + ", " + ;
                " Obrigs   = " + FormatarNumeroSQL(THIS.this_nObrigs)  + ", " + ;
                " Autos    = " + FormatarNumeroSQL(THIS.this_nAutos)   + ", " + ;
                " Contabs  = " + FormatarNumeroSQL(THIS.this_nContabs) + ", " + ;
                " FPagss   = " + EscaparSQL(THIS.this_cFPagss)         + ", " + ;
                " BlqAltExc= " + FormatarNumeroSQL(THIS.this_nBlqAltExc) + ;
                " WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro - Atualizar")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro - Atualizar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de um registro de SigOpFpo pelo CidChaves
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigOpFpo" + ;
                " WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro - ExecutarExclusao")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro - ExecutarExclusao")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

