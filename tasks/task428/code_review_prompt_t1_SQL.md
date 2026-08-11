# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, DOPES, COPERS, TOTA
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna '1' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, DOPES, COPERS, TOTA

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFpo.prg) - TRECHOS RELEVANTES PARA PASS SQL (1303 linhas total):

*-- Linhas 256 a 274:
256:                 .Height             = 380
257:                 .FontName           = "Tahoma"
258:                 .FontSize           = 8
259:                 .DeleteMark         = .F.
260:                 .RecordMark         = .F.
261:                 .RowHeight          = 20
262:                 .GridLineColor      = RGB(200, 200, 200)
263:                 .GridLines          = 3
264:                 .HighlightStyle     = 2
265:                 .HighlightBackColor = RGB(255, 255, 255)
266:                 .HighlightForeColor = RGB(15, 41, 104)
267:                 .ScrollBars         = 2
268:                 .Visible            = .T.
269:             ENDWITH
270: 
271:             *-- BINDEVENTs para colunas de texto (F4 abre lookup de condicao de pagamento)
272:             BINDEVENT(loc_oPagina.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "GradeCol1KeyPress")
273:             BINDEVENT(loc_oPagina.grd_4c_Dados.Column5.Text1, "KeyPress", THIS, "GradeCol5KeyPress")
274:             BINDEVENT(loc_oPagina.grd_4c_Dados, "AfterRowColChange", THIS, "GradeAfterRowColChange")

*-- Linhas 541 a 682:
541: 
542:     *--------------------------------------------------------------------------
543:     * CarregarGrade - Carrega dados de SigOpFpo em cursor_4c_Dados e configura
544:     * a grade. Usa CREATE CURSOR para manter cursor editavel (APPEND BLANK/REPLACE
545:     * funcionam sem restricoes, ao contrario de cursor de SQLEXEC direto).
546:     *--------------------------------------------------------------------------
547:     PROTECTED PROCEDURE CarregarGrade()
548:         LOCAL loc_lResultado, loc_oGrid, loc_cSQL, loc_nResultado, loc_oErro
549:         loc_lResultado = .F.
550: 
551:         TRY
552:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
553: 
554:             loc_cSQL = "SELECT CidChaves, Dopes, FPags, Obrigs, Autos, Contabs," + ;
555:                        " FPagss, BlqAltExc" + ;
556:                        " FROM SigOpFpo" + ;
557:                        " WHERE Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopes)) + ;
558:                        " ORDER BY FPags"
559: 
560:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp")
561: 
562:             IF loc_nResultado < 0
563:                 MsgErro(CapturarErroSQL(), "Erro ao carregar grade")
564:             ELSE
565:                 *-- Criar ou reinicializar cursor editavel para a grade (Problema 34/35)
566:                 IF !USED("cursor_4c_Dados")
567:                     SET NULL ON
568:                     CREATE CURSOR cursor_4c_Dados (;
569:                         CidChaves C(20), Dopes C(20), FPags C(12), ;
570:                         Obrigs    N(1,0), Autos N(1,0), Contabs N(1,0), ;
571:                         FPagss    C(12),  BlqAltExc N(1,0))
572:                     SET NULL OFF
573:                 ELSE
574:                     ZAP IN cursor_4c_Dados
575:                 ENDIF
576: 
577:                 IF RECCOUNT("cursor_4c_DadosTemp") > 0
578:                     APPEND FROM DBF("cursor_4c_DadosTemp")
579:                 ENDIF
580:                 GO TOP IN cursor_4c_Dados
581: 
582:                 *-- Carregar cursor de lookup de condicoes de pagamento (crSigOpFp)
583:                 THIS.this_oBusinessObject.BuscarCondicoesPagamento()
584: 
585:                 *-- RecordSource e ColumnCount FORA do WITH (Problema 36)
586:                 loc_oGrid.ColumnCount = 3
587:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
588:                 loc_oGrid.ColumnCount  = 5
589: 
590:                 *-- Configurar colunas APOS RecordSource (Problema 48)
591:                 WITH loc_oGrid
592:                     .Column1.ControlSource   = "cursor_4c_Dados.FPags"
593:                     .Column1.Width           = 230
594:                     .Column1.Sparse          = .T.
595:                     .Column1.Header1.Caption = "Condi" + CHR(231) + CHR(227) + "o Pagto"
596:                     .Column1.Text1.MaxLength = 12
597: 
598:                     .Column2.ControlSource   = "cursor_4c_Dados.Obrigs"
599:                     .Column2.Width           = 42
600:                     .Column2.Sparse          = .F.
601:                     .AddObject("Check1", "CheckBox")
602:                     .Check1.Caption = ""
603:                     .Check1.Alignment = 0
604:                     .Check1.ReadOnly  = .F.
605:                     .Check1.Visible   = .T.
606:                     .Check1.Top       = 9
607:                     .Check1.Left      = 2
608:                     .Check1.Height    = 17
609:                     .Check1.Width     = 22
610:                     .Column2.CurrentControl  = "Check1"
611:                     .Column2.Header1.Caption = "O"
612:                     .Column2.Check1.Alignment = 0
613:                     .Column2.Check1.ReadOnly  = .F.
614:                     .Column2.Check1.Visible   = .T.
615:                     .Column2.Check1.Top       = 9
616:                     .Column2.Check1.Left      = 2
617:                     .Column2.Check1.Height    = 17
618:                     .Column2.Check1.Width     = 22
619:                     .Column2.Check1.Caption   = ""
620: 
621:                     .Column3.ControlSource   = "cursor_4c_Dados.Autos"
622:                     .Column3.Width           = 42
623:                     .Column3.Sparse          = .F.
624:                     .AddObject("Check1", "CheckBox")
625:                     .Check1.Caption = ""
626:                     .Check1.Alignment = 0
627:                     .Check1.ReadOnly  = .F.
628:                     .Check1.Visible   = .T.
629:                     .Check1.Top       = 9
630:                     .Check1.Left      = 2
631:                     .Check1.Height    = 17
632:                     .Check1.Width     = 22
633:                     .Column3.CurrentControl  = "Check1"
634:                     .Column3.Header1.Caption = "A"
635:                     .Column3.Check1.Alignment = 0
636:                     .Column3.Check1.ReadOnly  = .F.
637:                     .Column3.Check1.Visible   = .T.
638:                     .Column3.Check1.Top       = 9
639:                     .Column3.Check1.Left      = 2
640:                     .Column3.Check1.Height    = 17
641:                     .Column3.Check1.Width     = 22
642:                     .Column3.Check1.Caption   = ""
643: 
644:                     .Column4.ControlSource   = "cursor_4c_Dados.Contabs"
645:                     .Column4.Width           = 42
646:                     .Column4.Sparse          = .F.
647:                     .AddObject("Check1", "CheckBox")
648:                     .Check1.Caption = ""
649:                     .Check1.Alignment = 0
650:                     .Check1.ReadOnly  = .F.
651:                     .Check1.Visible   = .T.
652:                     .Check1.Top       = 9
653:                     .Check1.Left      = 2
654:                     .Check1.Height    = 17
655:                     .Check1.Width     = 22
656:                     .Column4.CurrentControl  = "Check1"
657:                     .Column4.Header1.Caption = "C"
658:                     .Column4.Check1.Alignment = 0
659:                     .Column4.Check1.ReadOnly  = .F.
660:                     .Column4.Check1.Visible   = .T.
661:                     .Column4.Check1.Top       = 9
662:                     .Column4.Check1.Left      = 2
663:                     .Column4.Check1.Height    = 17
664:                     .Column4.Check1.Width     = 22
665:                     .Column4.Check1.Caption   = ""
666: 
667:                     .Column5.ControlSource   = "cursor_4c_Dados.FPagss"
668:                     .Column5.Width           = 230
669:                     .Column5.Sparse          = .T.
670:                     .Column5.Header1.Caption = "Substituir"
671:                     .Column5.Text1.MaxLength = 12
672: 
673:                     *-- Cores das colunas CheckBox (fidelidade visual PILAR 1)
674:                     .Column2.BackColor = RGB(216, 39, 70)
675:                     .Column3.BackColor = RGB(0, 0, 128)
676:                     .Column4.BackColor = RGB(0, 128, 255)
677: 
678:                     *-- Propriedades visuais dos Headers (PILAR 1)
679:                     .Column1.Header1.FontBold  = .T.
680:                     .Column1.Header1.ForeColor = RGB(90, 90, 90)
681:                     .Column1.Header1.Alignment = 2
682:                     .Column2.Header1.FontBold  = .T.

*-- Linhas 733 a 751:
733: 
734:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
735: 
736:             SELECT cursor_4c_Dados
737:             APPEND BLANK
738:             REPLACE Dopes     WITH ALLTRIM(THIS.this_cDopes)
739:             REPLACE FPags     WITH ""
740:             REPLACE Obrigs    WITH 0
741:             REPLACE Autos     WITH 0
742:             REPLACE Contabs   WITH 0
743:             REPLACE FPagss    WITH ""
744:             REPLACE BlqAltExc WITH 0
745:             GO BOTTOM IN cursor_4c_Dados
746: 
747:             loc_oGrid.Refresh()
748:             loc_oGrid.Column1.SetFocus()
749:         CATCH TO loc_oErro
750:             MsgErro(loc_oErro.Message, "Erro em BtnInserirClick")
751:         ENDTRY

*-- Linhas 768 a 787:
768: 
769:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
770: 
771:             SELECT cursor_4c_Dados
772:             DELETE
773:             SKIP
774:             IF EOF("cursor_4c_Dados")
775:                 SKIP -1
776:             ENDIF
777: 
778:             loc_oGrid.Refresh()
779:         CATCH TO loc_oErro
780:             MsgErro(loc_oErro.Message, "Erro em BtnExcluirClick")
781:         ENDTRY
782:     ENDPROC
783: 
784:     *--------------------------------------------------------------------------
785:     * BtnEncerrarClick - Valida, salva e fecha (cmdSair no legado)
786:     * Logica: valida duplicatas via BO.SalvarLote, fecha form se sucesso
787:     *--------------------------------------------------------------------------

*-- Linhas 809 a 827:
809: 
810:         TRY
811:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND !BOF("cursor_4c_Dados")
812:                 SELECT cursor_4c_Dados
813:                 IF VARTYPE(BlqAltExc) = "L"
814:                     loc_lBloqueado = BlqAltExc
815:                 ELSE
816:                     loc_lBloqueado = (NVL(BlqAltExc, 0) = 1)
817:                 ENDIF
818: 
819:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Botoes", 5)
820:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
821:                         THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled = !loc_lBloqueado
822:                     ENDIF
823:                 ENDIF
824:             ENDIF
825:         CATCH TO loc_oErro
826:             MsgErro(loc_oErro.Message, "Erro em GradeAfterRowColChange")
827:         ENDTRY

*-- Linhas 882 a 900:
882: 
883:                 IF loc_oBusca.this_lSelecionou AND USED("crSigOpFp")
884:                     IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
885:                         SELECT cursor_4c_Dados
886:                         IF loc_cCampoDestino = "FPags"
887:                             REPLACE FPags  WITH ALLTRIM(crSigOpFp.FPags)
888:                         ELSE
889:                             REPLACE FPagss WITH ALLTRIM(crSigOpFp.FPags)
890:                         ENDIF
891:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
892:                     ENDIF
893:                 ENDIF
894: 
895:                 loc_oBusca.Release()
896:             ELSE
897:                 MsgErro("Erro ao criar FormBuscaAuxiliar", "Lookup")
898:             ENDIF
899:         CATCH TO loc_oErro
900:             MsgErro(loc_oErro.Message, "Erro em AbrirLookupFPags")

*-- Linhas 942 a 1035:
942:         IF INLIST(par_nKeyCode, 13, 32)
943:             TRY
944:                 IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND !BOF("cursor_4c_Dados")
945:                     SELECT cursor_4c_Dados
946:                     REPLACE Obrigs WITH IIF(cursor_4c_Dados.Obrigs = 1, 0, 1)
947:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
948:                 ENDIF
949:             CATCH TO loc_oErro
950:                 MsgErro(loc_oErro.Message, "Erro em GradeCol2CheckKeyPress")
951:             ENDTRY
952:         ENDIF
953:     ENDPROC
954: 
955:     *--------------------------------------------------------------------------
956:     * GradeCol3CheckKeyPress - KeyPress no CheckBox da coluna Auto (Column3)
957:     * Enter (13) ou Space (32) alterna Autos do registro atual (mirror do KeyPress legado)
958:     *--------------------------------------------------------------------------
959:     PROCEDURE GradeCol3CheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
960:         LOCAL loc_oErro
961:         IF INLIST(par_nKeyCode, 13, 32)
962:             TRY
963:                 IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND !BOF("cursor_4c_Dados")
964:                     SELECT cursor_4c_Dados
965:                     REPLACE Autos WITH IIF(cursor_4c_Dados.Autos = 1, 0, 1)
966:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
967:                 ENDIF
968:             CATCH TO loc_oErro
969:                 MsgErro(loc_oErro.Message, "Erro em GradeCol3CheckKeyPress")
970:             ENDTRY
971:         ENDIF
972:     ENDPROC
973: 
974:     *--------------------------------------------------------------------------
975:     * GradeCol4CheckKeyPress - KeyPress no CheckBox da coluna Nao Contabilizar (Column4)
976:     * Enter (13) ou Space (32) alterna Contabs do registro atual (mirror do KeyPress legado)
977:     *--------------------------------------------------------------------------
978:     PROCEDURE GradeCol4CheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
979:         LOCAL loc_oErro
980:         IF INLIST(par_nKeyCode, 13, 32)
981:             TRY
982:                 IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND !BOF("cursor_4c_Dados")
983:                     SELECT cursor_4c_Dados
984:                     REPLACE Contabs WITH IIF(cursor_4c_Dados.Contabs = 1, 0, 1)
985:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
986:                 ENDIF
987:             CATCH TO loc_oErro
988:                 MsgErro(loc_oErro.Message, "Erro em GradeCol4CheckKeyPress")
989:             ENDTRY
990:         ENDIF
991:     ENDPROC
992: 
993:     *--------------------------------------------------------------------------
994:     * GradeCol1TextLostFocus - LostFocus na coluna FPags (Column1.Text1)
995:     * Quando FPags esta vazio, redireciona foco para botao Encerrar
996:     * (mirror do LostFocus original: "If IsEmpty(This.Value): Thisform.cmdSair.SetFocus")
997:     *--------------------------------------------------------------------------
998:     PROCEDURE GradeCol1TextLostFocus(par_nKeyCode, par_nShiftAltCtrl)
999:         LOCAL loc_oErro
1000:         TRY
1001:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1002:                 SELECT cursor_4c_Dados
1003:                 IF EMPTY(ALLTRIM(cursor_4c_Dados.FPags))
1004:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes.cmd_4c_Encerrar.SetFocus()
1005:                 ENDIF
1006:             ENDIF
1007:         CATCH TO loc_oErro
1008:             MsgErro(loc_oErro.Message, "Erro em GradeCol1TextLostFocus")
1009:         ENDTRY
1010:     ENDPROC
1011: 
1012:     *--------------------------------------------------------------------------
1013:     * GradeCol1HeaderClick - Click no Header da coluna FPags (Column1.Header1)
1014:     * Reordena cursor_4c_Dados por FPags (mirror do Click legado no Header1)
1015:     *--------------------------------------------------------------------------
1016:     PROCEDURE GradeCol1HeaderClick()
1017:         LOCAL loc_oErro
1018:         TRY
1019:             IF USED("cursor_4c_Dados")
1020:                 SELECT cursor_4c_Dados
1021:                 INDEX ON FPags TAG FPags COMPACT
1022:                 SET ORDER TO TAG FPags IN cursor_4c_Dados
1023:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
1024:             ENDIF
1025:         CATCH TO loc_oErro
1026:             MsgErro(loc_oErro.Message, "Erro em GradeCol1HeaderClick")
1027:         ENDTRY
1028:     ENDPROC
1029: 
1030:     *--------------------------------------------------------------------------
1031:     * BtnIncluirClick - Alias canonico do fluxo "Incluir" (append blank na grade)
1032:     * Form OPERACIONAL: sem Page2/CRUD separado; edicao acontece inline na grade.
1033:     * Reusa a logica de BtnInserirClick (equivalente ao cmdInserir legado).
1034:     *--------------------------------------------------------------------------
1035:     PROCEDURE BtnIncluirClick()

*-- Linhas 1044 a 1062:
1044: 
1045:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
1046: 
1047:             SELECT cursor_4c_Dados
1048:             APPEND BLANK
1049:             REPLACE Dopes     WITH ALLTRIM(THIS.this_cDopes)
1050:             REPLACE FPags     WITH ""
1051:             REPLACE Obrigs    WITH 0
1052:             REPLACE Autos     WITH 0
1053:             REPLACE Contabs   WITH 0
1054:             REPLACE FPagss    WITH ""
1055:             REPLACE BlqAltExc WITH 0
1056:             GO BOTTOM IN cursor_4c_Dados
1057: 
1058:             THIS.this_cModoAtual = "INCLUIR"
1059:             loc_oGrid.Refresh()
1060:             loc_oGrid.Column1.SetFocus()
1061:         CATCH TO loc_oErro
1062:             MsgErro(loc_oErro.Message, "Erro em BtnIncluirClick")

*-- Linhas 1082 a 1100:
1082:                 RETURN
1083:             ENDIF
1084: 
1085:             SELECT cursor_4c_Dados
1086:             IF NVL(cursor_4c_Dados.BlqAltExc, 0) = 1
1087:                 MsgAviso("Registro bloqueado para altera" + CHR(231) + CHR(227) + "o.", "")
1088:                 RETURN
1089:             ENDIF
1090: 
1091:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
1092: 
1093:             THIS.this_cModoAtual = "ALTERAR"
1094:             loc_oGrid.Refresh()
1095:             loc_oGrid.SetFocus()
1096:             loc_oGrid.ActivateCell(RECNO("cursor_4c_Dados"), 1)
1097:         CATCH TO loc_oErro
1098:             MsgErro(loc_oErro.Message, "Erro em BtnAlterarClick")
1099:         ENDTRY
1100:     ENDPROC

*-- Linhas 1114 a 1132:
1114:             ENDIF
1115: 
1116:             IF EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
1117:                 SELECT cursor_4c_Dados
1118:                 GO TOP
1119:             ENDIF
1120: 
1121:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
1122: 
1123:             THIS.this_cModoAtual = "VISUALIZAR"
1124:             loc_oGrid.Refresh()
1125:             loc_oGrid.SetFocus()
1126:             loc_oGrid.ActivateCell(RECNO("cursor_4c_Dados"), 1)
1127:         CATCH TO loc_oErro
1128:             MsgErro(loc_oErro.Message, "Erro em BtnVisualizarClick")
1129:         ENDTRY
1130:     ENDPROC
1131: 
1132:     *--------------------------------------------------------------------------

*-- Linhas 1186 a 1204:
1186:         ENDIF
1187: 
1188:         TRY
1189:             SELECT cursor_4c_Dados
1190:             THIS.this_oBusinessObject.this_cCidChaves = ALLTRIM(NVL(CidChaves, ""))
1191:             THIS.this_oBusinessObject.this_cDopes     = ALLTRIM(NVL(Dopes,    ""))
1192:             THIS.this_oBusinessObject.this_cFPags     = ALLTRIM(NVL(FPags,    ""))
1193:             THIS.this_oBusinessObject.this_nObrigs    = NVL(Obrigs,    0)
1194:             THIS.this_oBusinessObject.this_nAutos     = NVL(Autos,     0)
1195:             THIS.this_oBusinessObject.this_nContabs   = NVL(Contabs,   0)
1196:             THIS.this_oBusinessObject.this_cFPagss    = ALLTRIM(NVL(FPagss,   ""))
1197:             THIS.this_oBusinessObject.this_nBlqAltExc = NVL(BlqAltExc, 0)
1198:             loc_lResultado = .T.
1199:         CATCH TO loc_oErro
1200:             MsgErro(loc_oErro.Message, "Erro em FormParaBO")
1201:         ENDTRY
1202: 
1203:         RETURN loc_lResultado
1204:     ENDPROC

*-- Linhas 1215 a 1233:
1215:         ENDIF
1216: 
1217:         TRY
1218:             SELECT cursor_4c_Dados
1219:             REPLACE CidChaves WITH ALLTRIM(THIS.this_oBusinessObject.this_cCidChaves)
1220:             REPLACE Dopes     WITH ALLTRIM(THIS.this_oBusinessObject.this_cDopes)
1221:             REPLACE FPags     WITH ALLTRIM(THIS.this_oBusinessObject.this_cFPags)
1222:             REPLACE Obrigs    WITH THIS.this_oBusinessObject.this_nObrigs
1223:             REPLACE Autos     WITH THIS.this_oBusinessObject.this_nAutos
1224:             REPLACE Contabs   WITH THIS.this_oBusinessObject.this_nContabs
1225:             REPLACE FPagss    WITH ALLTRIM(THIS.this_oBusinessObject.this_cFPagss)
1226:             REPLACE BlqAltExc WITH THIS.this_oBusinessObject.this_nBlqAltExc
1227:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
1228:             loc_lResultado = .T.
1229:         CATCH TO loc_oErro
1230:             MsgErro(loc_oErro.Message, "Erro em BOParaForm")
1231:         ENDTRY
1232: 
1233:         RETURN loc_lResultado


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
            loc_cWhere = "WHERE 1=1"

            IF !EMPTY(ALLTRIM(THIS.this_cDopesAtual))
                loc_cWhere = loc_cWhere + ;
                    " AND Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopesAtual))
            ENDIF

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = loc_cWhere + " AND " + par_cFiltro
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
                WHERE !EMPTY(ALLTRIM(FPags)) ORDER BY 1 ;
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

