# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDNPS, 0, NOPS, CHKDESTS, DOPES, SERVICOS, ICLIS, CPROS, APRIORS, EMPDOPNUMS, CHKSUBN
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDNPS, 0, NOPS, CHKDESTS, DOPES, SERVICOS, ICLIS, CPROS, APRIORS, EMPDOPNUMS, CHKSUBN

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
  DeleteMark = .F.
lcSql = [Select DoppPads, DoppServs From SigCdPam ]
ThisForm.Podatamgr.Sqlexecute(lcsql,'zTmpparam')
lcQuery = [Select Numps, Dopps, cIdChaves ] + ;
			[From SigCdNec ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'OpPendente1') < 1)
lcQuery = [Select Numps, Dopps, cIdChaves ] + ;
		    [From SigCdNec ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'OpPendente2') < 1)
Select 000000 as Priors, Numps, Dopps From OpPendente1 ;
Select 000000 as Priors, Numps, Dopps From OpPendente2 ;
Select OpPendente
	oProg.Update(.t.)
	lcSql = [Select * From SigPdMvf Where Nops = ]+Str(opPendente.Numps)+[ Order by Nops, CidChaves desc]
	ThisForm.Podatamgr.Sqlexecute(lcSql,'CrTmpMfas')
	Select CrTmpMfas
	Select crSigCdOpd
	lcQuery = [Select a.Nops, Sum(a.Qtds) as Qtds, b.ContaOs, b.ContaDs, b.prazoents, b.empdopNums, b.priors, ]+;
			    [From SigOpPic a, SigMvCab b, SigCdOpe c ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmpOpi') < 1)
	Select crTmpOpi
			Select crTmpMFas
			lcSql = [Select rclis From SigCdCli Where Iclis = ']+lcCliente+[']
			ThisForm.Podatamgr.Sqlexecute(lcsql,'CrTmpcli')
			Select zTmppPcp
Select Distinct Emps, Dopes, Numes, Contas, Rclis, PrazoEnts, Priors, aPriors ;
  From zTmpPpcp ;
Select zTmpSelecao
Select zTmppPcp
Select zTmpSelecao
	.Column1.ControlSource = 'zTmpSelecao.Priors'
	.Column2.Controlsource = 'zTmpSelecao.Emps'
	.Column3.Controlsource = 'zTmpSelecao.dopes'
	.Column4.Controlsource = 'zTmpSelecao.numes'
	.Column5.Controlsource = 'zTmpSelecao.Contas'
	.Column6.Controlsource = 'zTmpSelecao.PrazoEnts'
	.Column1.ControlSource = 'zTmppPcp.nenvs'
	.Column2.Controlsource = 'zTmpPpcp.Nops'
	.Column3.Controlsource = 'zTmpPpcp.cpros'
	.Column4.Controlsource = 'zTmpppcp.Qtds'
Select zTmppPcp
Select zTmpSelecao
lcQuery = [Select FigJpgs From SigCdPro Where Cpros= ']+zTmppPcp.Cpros+[']
=ThisForm.PodataMgr.SqlExecute(lcQuery,'CrTmpPro')
Select zTmppPcp
Select zTmpSelecao
Select zTmpSelecao
Select zTmpSelecao
	lcSql = [Update SigMvCab Set Priors = ]+Str(zTmpSelecao.Priors)+[ Where EmpDopNums = ']+lcEdn+[']
	ThisForm.Podatamgr.Sqlexecute(lcsql,'')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrPcp.prg) - TRECHOS RELEVANTES PARA PASS SQL (1144 linhas total):

*-- Linhas 71 a 130:
71:                 ELSE
72:                     *-- Criar cursor base para dados PCP (zTmppPcp do legado)
73:                     SET NULL ON
74:                     CREATE CURSOR cursor_4c_PcpDados ( ;
75:                         Priors    N(6)    NULL, ;
76:                         Nenvs     N(10)   NULL, ;
77:                         Nops      N(10)   NULL, ;
78:                         Emps      C(3)    NULL, ;
79:                         Dopes     C(20)   NULL, ;
80:                         Numes     N(6)    NULL, ;
81:                         Contas    C(10)   NULL, ;
82:                         Rclis     C(40)   NULL, ;
83:                         PrazoEnts T       NULL, ;
84:                         Cpros     C(14)   NULL, ;
85:                         Qtds      N(9,3)  NULL, ;
86:                         aPriors   N(6)    NULL  ;
87:                     )
88:                     SET NULL OFF
89: 
90:                     IF !THIS.this_oBusinessObject.Processar("cursor_4c_PcpDados")
91:                         MsgErro("Erro no Processamento dos Dados...", "Erro")
92:                     ELSE
93:                         *-- Criar cursor de selecao consolidado (zTmpSelecao do legado)
94:                         SET NULL ON
95:                         SELECT DISTINCT Emps, Dopes, Numes, Contas, Rclis, ;
96:                                         PrazoEnts, Priors, aPriors ;
97:                             FROM cursor_4c_PcpDados ;
98:                             INTO CURSOR cursor_4c_Selecao READWRITE
99:                         SET NULL OFF
100: 
101:                         *-- Indexar cursor de selecao para ordenacao
102:                         SELECT cursor_4c_Selecao
103:                         INDEX ON Emps + Dopes + STR(Numes,6) TAG EmpdopNum
104:                         INDEX ON DTOS(PrazoEnts) + Emps + Dopes + STR(Numes,6) TAG Entrega
105:                         INDEX ON Contas TAG Cliente
106:                         INDEX ON STR(Priors,6) + Emps + Dopes + STR(Numes,6) TAG Prioridade
107:                         SET ORDER TO Entrega
108: 
109:                         *-- Indexar cursor de dados PCP para RELATION
110:                         SELECT cursor_4c_PcpDados
111:                         INDEX ON Emps + Dopes + STR(Numes,6) TAG EmpdopNum
112:                         GO TOP
113: 
114:                         *-- Estabelecer relacao entre cursores (como SET RELATION do legado)
115:                         SELECT cursor_4c_Selecao
116:                         GO TOP
117:                         SET RELATION TO Emps + Dopes + STR(Numes,6) INTO cursor_4c_PcpDados
118: 
119:                         *-- Montar interface visual
120:                         THIS.ConfigurarPageFrame()
121:                         THIS.ConfigurarCabecalho()
122:                         THIS.ConfigurarPaginaLista()
123:                         THIS.ConfigurarBotoes()
124:                         THIS.ConfigurarPaginaDados()
125:                         THIS.ConfigurarControlesAuxiliares()
126:                         THIS.ConfigurarImagemProduto()
127:                         THIS.TornarControlesVisiveis()
128: 
129:                         *-- Propagar titulo para labels do cabecalho
130:                         THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption

*-- Linhas 264 a 282:
264:             .ColumnCount   = 6
265:             .FontName      = "Tahoma"
266:             .FontSize      = 8
267:             .DeleteMark    = .F.
268:             .RecordMark    = .F.
269:             .ReadOnly      = .T.
270:             .RowHeight     = 16
271:             .ScrollBars    = 2
272:             .GridLineColor = RGB(238,238,238)
273:             .Visible       = .T.
274: 
275:             WITH .Column1
276:                 .Width             = 50
277:                 .Movable           = .F.
278:                 .Resizable         = .F.
279:                 .ReadOnly          = .F.
280:                 .Header1.Caption   = "Prioridade"
281:                 .Header1.Alignment = 2
282:                 .Header1.ForeColor = RGB(0,0,0)

*-- Linhas 368 a 386:
368:             .ColumnCount   = 4
369:             .FontName      = "Tahoma"
370:             .FontSize      = 8
371:             .DeleteMark    = .F.
372:             .RecordMark    = .F.
373:             .ReadOnly      = .T.
374:             .RowHeight     = 16
375:             .ScrollBars    = 2
376:             .GridLineColor = RGB(238,238,238)
377:             .Visible       = .T.
378: 
379:             WITH .Column1
380:                 .Width             = 80
381:                 .Movable           = .F.
382:                 .Resizable         = .F.
383:                 .ReadOnly          = .T.
384:                 .Header1.Caption   = "Envelope"
385:                 .Header1.Alignment = 2
386:                 .Header1.ForeColor = RGB(0,0,0)

*-- Linhas 623 a 688:
623:     ENDPROC
624: 
625:     *==========================================================================
626:     * CarregarGrades - Configura RecordSource/ControlSource e popula combo
627:     *==========================================================================
628:     PROTECTED PROCEDURE CarregarGrades
629:         LOCAL loc_lSucesso, loc_oErro
630:         loc_lSucesso = .F.
631: 
632:         TRY
633:             IF !USED("cursor_4c_Selecao") OR !USED("cursor_4c_PcpDados")
634:                 MsgErro("Cursores de dados n" + CHR(227) + "o inicializados.", "Erro")
635:             ELSE
636:                 *-- Vincular grade principal ao cursor de selecao
637:                 THIS.grd_4c_Dados.ColumnCount  = 6
638:                 THIS.grd_4c_Dados.RecordSource = "cursor_4c_Selecao"
639:                 WITH THIS.grd_4c_Dados
640:                     .Column1.ControlSource = "cursor_4c_Selecao.Priors"
641:                     .Column2.ControlSource = "cursor_4c_Selecao.Emps"
642:                     .Column3.ControlSource = "cursor_4c_Selecao.Dopes"
643:                     .Column4.ControlSource = "cursor_4c_Selecao.Numes"
644:                     .Column5.ControlSource = "cursor_4c_Selecao.Contas"
645:                     .Column6.ControlSource = "cursor_4c_Selecao.PrazoEnts"
646:                     .Refresh()
647:                 ENDWITH
648: 
649:                 *-- Vincular grade de itens ao cursor de dados PCP
650:                 THIS.grd_4c_Itens.ColumnCount  = 4
651:                 THIS.grd_4c_Itens.RecordSource = "cursor_4c_PcpDados"
652:                 WITH THIS.grd_4c_Itens
653:                     .Column1.ControlSource = "cursor_4c_PcpDados.Nenvs"
654:                     .Column2.ControlSource = "cursor_4c_PcpDados.Nops"
655:                     .Column3.ControlSource = "cursor_4c_PcpDados.Cpros"
656:                     .Column4.ControlSource = "cursor_4c_PcpDados.Qtds"
657:                     .Refresh()
658:                 ENDWITH
659: 
660:                 *-- Popular combo de ordenacao (itens sem acento, como no legado)
661:                 WITH THIS.cbo_4c_Ordenacao
662:                     .Clear()
663:                     .AddItem("Operacao")
664:                     .AddItem("Cliente")
665:                     .AddItem("Prazo Entrega")
666:                     .AddItem("Prioridade")
667:                     .Value = "Prazo Entrega"
668:                 ENDWITH
669: 
670:                 *-- Posicionar e atualizar painel de info
671:                 SELECT cursor_4c_PcpDados
672:                 GO TOP
673:                 SELECT cursor_4c_Selecao
674:                 GO TOP
675:                 THIS.grd_4c_Dados.SetFocus()
676:                 THIS.GrdDadosAfterRowColChange(1)
677: 
678:                 loc_lSucesso = .T.
679:             ENDIF
680:         CATCH TO loc_oErro
681:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
682:                     " PROC=" + loc_oErro.Procedure, ;
683:                     "Erro FormSigPrPcp.CarregarGrades")
684:         ENDTRY
685: 
686:         RETURN loc_lSucesso
687:     ENDPROC
688: 

*-- Linhas 730 a 787:
730:             RETURN
731:         ENDIF
732:         THIS.LockScreen = .T.
733:         SELECT cursor_4c_Selecao
734:         THIS.txt_4c_Cliente.Value = NVL(cursor_4c_Selecao.Rclis, "")
735:         THIS.txt_4c_Cliente.Refresh()
736:         SELECT cursor_4c_PcpDados
737:         GO TOP
738:         THIS.grd_4c_Itens.Refresh()
739:         THIS.img_4c_FigJpg.Visible = .F.
740:         THIS.img_4c_FigJpg.Picture = ""
741:         SELECT cursor_4c_Selecao
742:         THIS.txt_4c_Info.Value = NVL(cursor_4c_Selecao.Emps, "") + " " + ;
743:             ALLTRIM(NVL(cursor_4c_Selecao.Dopes, "")) + " " + ;
744:             STR(NVL(cursor_4c_Selecao.Numes, 0), 6)
745:         THIS.LockScreen = .F.
746:     ENDPROC
747: 
748:     *==========================================================================
749:     * GrdItensAfterRowColChange - Carrega foto do produto ao mudar linha nos itens
750:     *==========================================================================
751:     PROCEDURE GrdItensAfterRowColChange
752:         LPARAMETERS par_nColIndex
753:         LOCAL loc_cCpros
754:         IF !USED("cursor_4c_PcpDados")
755:             RETURN
756:         ENDIF
757:         THIS.LockScreen = .T.
758:         THIS.img_4c_FigJpg.Visible = .F.
759:         THIS.img_4c_FigJpg.Picture = ""
760:         THIS.shp_4c_Shape4.Visible = .F.
761:         SELECT cursor_4c_PcpDados
762:         IF !EOF("cursor_4c_PcpDados")
763:             loc_cCpros = NVL(cursor_4c_PcpDados.Cpros, "")
764:             IF !EMPTY(loc_cCpros)
765:                 IF THIS.this_oBusinessObject.ObterImagemProduto(loc_cCpros, THIS.this_cArquivoTempImg)
766:                     THIS.img_4c_FigJpg.Picture = THIS.this_cArquivoTempImg
767:                     THIS.img_4c_FigJpg.Visible = .T.
768:                     THIS.shp_4c_Shape4.Visible = .T.
769:                 ENDIF
770:             ENDIF
771:         ENDIF
772:         SELECT cursor_4c_PcpDados
773:         THIS.LockScreen = .F.
774:     ENDPROC
775: 
776:     *==========================================================================
777:     * GrdDadosCol1LostFocus - TAB na coluna Prioridade salta para grade de itens
778:     *==========================================================================
779:     PROCEDURE GrdDadosCol1LostFocus
780:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
781:         IF LASTKEY() = 9
782:             THIS.grd_4c_Itens.SetFocus()
783:         ENDIF
784:     ENDPROC
785: 
786:     *==========================================================================
787:     * GrdItensCol1LostFocus - TAB na coluna Envelope retorna para grade principal

*-- Linhas 800 a 831:
800:         IF !USED("cursor_4c_Selecao")
801:             RETURN
802:         ENDIF
803:         SELECT cursor_4c_Selecao
804:         SET RELATION TO
805:         SET ORDER TO
806:         DO CASE
807:             CASE ALLTRIM(THIS.cbo_4c_Ordenacao.Value) = "Prazo Entrega"
808:                 SET ORDER TO Entrega
809:             CASE ALLTRIM(THIS.cbo_4c_Ordenacao.Value) = "Cliente"
810:                 SET ORDER TO Cliente
811:             CASE ALLTRIM(THIS.cbo_4c_Ordenacao.Value) = "Operacao"
812:                 SET ORDER TO EmpDopNum
813:             CASE ALLTRIM(THIS.cbo_4c_Ordenacao.Value) = "Prioridade"
814:                 SET ORDER TO Prioridade
815:         ENDCASE
816:         SELECT cursor_4c_Selecao
817:         SET RELATION TO Emps + Dopes + STR(Numes,6) INTO cursor_4c_PcpDados
818:         THIS.grd_4c_Dados.Refresh()
819:     ENDPROC
820: 
821:     *==========================================================================
822:     * BtnConfirmarClick - Grava prioridades no banco (Salva.Click do legado)
823:     *==========================================================================
824:     PROCEDURE BtnConfirmarClick
825:         IF !USED("cursor_4c_Selecao")
826:             MsgAviso("Dados de sele" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + "veis.")
827:             RETURN
828:         ENDIF
829:         IF !MsgConfirma("Confirma Grava" + CHR(231) + CHR(227) + "o dos Dados!!!")
830:             RETURN
831:         ENDIF

*-- Linhas 856 a 874:
856:                          "es para priorizar.", "Aviso")
857:                 RETURN
858:             ENDIF
859:             SELECT cursor_4c_Selecao
860:             GO TOP
861:             THIS.grd_4c_Dados.Refresh()
862:             THIS.GrdDadosAfterRowColChange(1)
863:             THIS.grd_4c_Dados.SetFocus()
864:             THIS.grd_4c_Dados.ActivateCell(1, 1)
865:         CATCH TO loc_oErro
866:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
867:                     "Erro BtnIncluir")
868:         ENDTRY
869:     ENDPROC
870: 
871:     *==========================================================================
872:     * BtnAlterarClick - Edita prioridade da linha selecionada na grade principal
873:     * Mapeamento OPERACIONAL: "alterar" = editar a coluna Priors da linha corrente
874:     *==========================================================================

*-- Linhas 880 a 898:
880:                          "es para alterar.", "Aviso")
881:                 RETURN
882:             ENDIF
883:             SELECT cursor_4c_Selecao
884:             IF EOF() OR BOF()
885:                 GO TOP
886:             ENDIF
887:             loc_nLinha = THIS.grd_4c_Dados.RelativeRow
888:             IF loc_nLinha < 1
889:                 loc_nLinha = 1
890:             ENDIF
891:             THIS.grd_4c_Dados.SetFocus()
892:             THIS.grd_4c_Dados.ActivateCell(loc_nLinha, 1)
893:         CATCH TO loc_oErro
894:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
895:                     "Erro BtnAlterar")
896:         ENDTRY
897:     ENDPROC
898: 

*-- Linhas 912 a 977:
912: 
913:             *-- Encerrar relacao e cursores para reprocessar
914:             IF USED("cursor_4c_Selecao")
915:                 SELECT cursor_4c_Selecao
916:                 SET RELATION TO
917:                 USE IN cursor_4c_Selecao
918:             ENDIF
919:             IF USED("cursor_4c_PcpDados")
920:                 USE IN cursor_4c_PcpDados
921:             ENDIF
922: 
923:             *-- Recriar cursor base
924:             SET NULL ON
925:             CREATE CURSOR cursor_4c_PcpDados ( ;
926:                 Priors    N(6)    NULL, ;
927:                 Nenvs     N(10)   NULL, ;
928:                 Nops      N(10)   NULL, ;
929:                 Emps      C(3)    NULL, ;
930:                 Dopes     C(20)   NULL, ;
931:                 Numes     N(6)    NULL, ;
932:                 Contas    C(10)   NULL, ;
933:                 Rclis     C(40)   NULL, ;
934:                 PrazoEnts T       NULL, ;
935:                 Cpros     C(14)   NULL, ;
936:                 Qtds      N(9,3)  NULL, ;
937:                 aPriors   N(6)    NULL  ;
938:             )
939:             SET NULL OFF
940: 
941:             IF THIS.this_oBusinessObject.Processar("cursor_4c_PcpDados")
942:                 *-- Recriar cursor de selecao consolidado
943:                 SET NULL ON
944:                 SELECT DISTINCT Emps, Dopes, Numes, Contas, Rclis, ;
945:                                 PrazoEnts, Priors, aPriors ;
946:                     FROM cursor_4c_PcpDados ;
947:                     INTO CURSOR cursor_4c_Selecao READWRITE
948:                 SET NULL OFF
949: 
950:                 *-- Reindexar
951:                 SELECT cursor_4c_Selecao
952:                 INDEX ON Emps + Dopes + STR(Numes,6) TAG EmpdopNum
953:                 INDEX ON DTOS(PrazoEnts) + Emps + Dopes + STR(Numes,6) TAG Entrega
954:                 INDEX ON Contas TAG Cliente
955:                 INDEX ON STR(Priors,6) + Emps + Dopes + STR(Numes,6) TAG Prioridade
956:                 SET ORDER TO Entrega
957: 
958:                 SELECT cursor_4c_PcpDados
959:                 INDEX ON Emps + Dopes + STR(Numes,6) TAG EmpdopNum
960:                 GO TOP
961: 
962:                 SELECT cursor_4c_Selecao
963:                 GO TOP
964:                 SET RELATION TO Emps + Dopes + STR(Numes,6) INTO cursor_4c_PcpDados
965: 
966:                 *-- Revincular grids aos cursores recriados
967:                 THIS.CarregarGrades()
968:                 MsgInfo("Dados recarregados com sucesso.", "Visualizar")
969:             ELSE
970:                 MsgErro("Falha ao reprocessar dados PCP.", "Erro Visualizar")
971:             ENDIF
972: 
973:             THIS.LockScreen = .F.
974:         CATCH TO loc_oErro
975:             THIS.LockScreen = .F.
976:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
977:                     "Erro BtnVisualizar")

*-- Linhas 990 a 1008:
990:                          "es para atualizar.", "Aviso")
991:                 RETURN
992:             ENDIF
993:             SELECT cursor_4c_Selecao
994:             IF EOF() OR BOF()
995:                 MsgAviso("Selecione uma linha na grade antes de zerar a prioridade.", ;
996:                          "Aviso")
997:                 RETURN
998:             ENDIF
999:             IF NVL(cursor_4c_Selecao.Priors, 0) = 0
1000:                 MsgAviso("A prioridade desta opera" + CHR(231) + CHR(227) + ;
1001:                          "o j" + CHR(225) + " est" + CHR(225) + " zerada.", "Aviso")
1002:                 RETURN
1003:             ENDIF
1004:             IF !MsgConfirma("Zerar prioridade da opera" + CHR(231) + CHR(227) + "o selecionada?")
1005:                 RETURN
1006:             ENDIF
1007:             REPLACE cursor_4c_Selecao.Priors WITH 0
1008:             THIS.grd_4c_Dados.Refresh()

*-- Linhas 1096 a 1114:
1096:                 MsgAviso("N" + CHR(227) + "o existem opera" + CHR(231) + CHR(245) + "es para exibir.")
1097:                 RETURN
1098:             ENDIF
1099:             SELECT cursor_4c_Selecao
1100:             GO TOP
1101:             THIS.grd_4c_Dados.Refresh()
1102:             THIS.GrdDadosAfterRowColChange(1)
1103:             THIS.grd_4c_Dados.SetFocus()
1104:         CATCH TO loc_oErro
1105:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1106:                     "Erro BtnBuscar")
1107:         ENDTRY
1108:     ENDPROC
1109: 
1110:     *==========================================================================
1111:     * BtnSalvarClick - Alias de BtnConfirmarClick (padrao FormBase)
1112:     *==========================================================================
1113:     PROCEDURE BtnSalvarClick()
1114:         THIS.BtnConfirmarClick()

*-- Linhas 1126 a 1144:
1126:     *==========================================================================
1127:         *-- Encerrar relacao entre cursores antes de fechar
1128:         IF USED("cursor_4c_Selecao")
1129:             SELECT cursor_4c_Selecao
1130:             SET RELATION TO
1131:             USE IN cursor_4c_Selecao
1132:         ENDIF
1133:         IF USED("cursor_4c_PcpDados")
1134:             USE IN cursor_4c_PcpDados
1135:         ENDIF
1136:         *-- Remover arquivo temporario de imagem de produto
1137:         IF !EMPTY(THIS.this_cArquivoTempImg) AND FILE(THIS.this_cArquivoTempImg)
1138:             ERASE (THIS.this_cArquivoTempImg)
1139:         ENDIF
1140:         THIS.this_oBusinessObject = .NULL.
1141:         DODEFAULT()
1142:     ENDPROC
1143: 
1144: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrPcpBO.prg):
*==============================================================================
* SigPrPcpBO.prg - Business Object: Priorizacao de Operacoes para PCP
* Tabela principal: SigMvCab (UPDATE Priors)
* Formulario: FormSigPrPcp.prg
*==============================================================================
DEFINE CLASS SigPrPcpBO AS BusinessBase

    *-- Tabela e chave (alvo do UPDATE de prioridades)
    this_cTabela      = "SigMvCab"
    this_cCampoChave  = "EmpDopNums"

    *-- Parametros de configuracao (lidos de SigCdPam)
    this_cOperacao    = ""   && DoppPads - tipo de operacao para planejamento
    this_cServico     = ""   && DoppServs - tipo de servico para planejamento

    *-- Registro corrente do cursor zTmpSelecao / zTmppPcp
    this_nPriors      = 0    && Priors n(6)   - prioridade atual (editavel)
    this_nNenvs       = 0    && nenvs n(10)   - numero envelope
    this_nNops        = 0    && Nops n(10)    - numero OP (SigPdMvf.NOps)
    this_cEmps        = ""   && Emps c(3)     - codigo empresa
    this_cDopes       = ""   && Dopes c(20)   - codigo operacao
    this_nNumes       = 0    && Numes n(6)    - numero da ordem de producao
    this_cContas      = ""   && Contas c(10)  - codigo conta/cliente (SigCdCli.Iclis)
    this_cRclis       = ""   && Rclis c(40)   - razao social do cliente
    this_tPrazoEnts   = {}   && PrazoEnts T   - prazo de entrega (DateTime)
    this_cCpros       = ""   && Cpros c(14)   - codigo do produto (SigCdPro)
    this_nQtds        = 0    && Qtds n(9,3)   - quantidade da OP
    this_nAPriors     = 0    && aPriors n(6)  - prioridade original antes de editar

    *-- Chave concatenada usada em INDEX e RELATION
    this_cEmpDopNum   = ""   && Emps + Dopes + Str(Numes,6)

    *-- Contexto de processamento (SigCdOpd)
    this_cNivels      = ""   && Nivels - nivel da operacao (SigCdOpd)
    this_nChkDests    = 0    && ChkDests n(1,0) - flag destino (SigCdOpd): 3=ignorar

    *-- Dados do item de grade (SigOpPic + SigMvCab + SigCdOpe)
    this_cContaOs     = ""   && ContaOs c(10) - conta origem (SigMvCab)
    this_cContaDs     = ""   && ContaDs c(10) - conta destino (SigMvCab)
    this_nGlobalizas  = 0    && Globalizas n(1,0) - flag globalizacao (SigCdOpe)
    this_nServicos    = 0    && Servicos n(1,0)   - flag servico (SigCdOpe)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave; chama BusinessBase.Init via DODEFAULT
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = "EmpDopNums"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave concatenada do registro corrente
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cEmps + THIS.this_cDopes + STR(THIS.this_nNumes, 6)
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterConfiguracaoPam - Le DoppPads e DoppServs de SigCdPam
    * Popula: this_cOperacao, this_cServico
    *--------------------------------------------------------------------------
    FUNCTION ObterConfiguracaoPam()
        LOCAL loc_cSQL, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "Select DoppPads, DoppServs From SigCdPam"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam") > 0
                IF USED("cursor_4c_Pam") AND RECCOUNT("cursor_4c_Pam") > 0
                    SELECT cursor_4c_Pam
                    THIS.this_cOperacao = ALLTRIM(NVL(DoppPads, ""))
                    THIS.this_cServico  = ALLTRIM(NVL(DoppServs, ""))
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_Pam")
            USE IN cursor_4c_Pam
        ENDIF
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades this_* a partir de cursor
    * par_cAliasCursor: alias do cursor (zTmppPcp ou zTmpSelecao)
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nPriors    = NVL(Priors, 0)
            THIS.this_nNenvs     = NVL(Nenvs, 0)
            THIS.this_nNops      = NVL(Nops, 0)
            THIS.this_cEmps      = ALLTRIM(NVL(Emps, ""))
            THIS.this_cDopes     = ALLTRIM(NVL(Dopes, ""))
            THIS.this_nNumes     = NVL(Numes, 0)
            THIS.this_cContas    = ALLTRIM(NVL(Contas, ""))
            THIS.this_cRclis     = ALLTRIM(NVL(Rclis, ""))
            THIS.this_tPrazoEnts = NVL(PrazoEnts, {})
            THIS.this_cCpros     = ALLTRIM(NVL(Cpros, ""))
            THIS.this_nQtds      = NVL(Qtds, 0)
            THIS.this_nAPriors   = NVL(aPriors, 0)
            THIS.this_cEmpDopNum = THIS.this_cEmps + THIS.this_cDopes + STR(THIS.this_nNumes, 6)
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Processar - Processa OPs em aberto e popula cursor destino (zTmppPcp)
    * Requer: ObterConfiguracaoPam() chamado antes
    * par_cCursorDestino: cursor criado pelo Form (estrutura zTmppPcp)
    *--------------------------------------------------------------------------
    FUNCTION Processar(par_cCursorDestino)
        LOCAL loc_lSucesso, loc_lAbortar, loc_cSQL, loc_oErro, loc_oProg
        LOCAL loc_cEmpresa, loc_lEnvelope, loc_nEnv, loc_cCliente, loc_cRclis
        LOCAL loc_cOpCompara, loc_nPop
        LOCAL loc_nMfasNops, loc_nMfasNenvs, loc_nMfasNumps
        LOCAL loc_nPriors, loc_cEmps, loc_cDopes, loc_nNumes
        LOCAL loc_tPrazoEnts, loc_cCpros, loc_nQtds

        loc_lSucesso  = .F.
        loc_lAbortar  = .F.
        loc_cEmpresa  = go_4c_Sistema.cCodEmpresa

        TRY
            IF USED(par_cCursorDestino)
                SELECT (par_cCursorDestino)
                ZAP
            ENDIF

            *-- Buscar OPs em aberto de Operacao (DoppPads) em SigCdNec
            loc_cSQL = "Select Numps, Dopps, cIdChaves From SigCdNec " + ;
                       "Where EmpDNps Between " + ;
                       EscaparSQL(loc_cEmpresa + THIS.this_cOperacao + STR(0,10)) + ;
                       " And " + ;
                       EscaparSQL(loc_cEmpresa + THIS.this_cOperacao + "9999999999") + ;
                       " And ChkSubn = 0 Order By Numps, Dopps, cIdChaves"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpPend1") < 1
                loc_lAbortar = .T.
                MsgErro("Favor Reinicializar o Processo!!!", ;
                        "Falha na Conex" + CHR(227) + "o (OpPendente1)")
            ENDIF

            IF !loc_lAbortar
                *-- Buscar OPs em aberto de Servico (DoppServs) em SigCdNec
                loc_cSQL = "Select Numps, Dopps, cIdChaves From SigCdNec " + ;
                           "Where EmpDNps Between " + ;
                           EscaparSQL(loc_cEmpresa + THIS.this_cServico + STR(0,10)) + ;
                           " And " + ;
                           EscaparSQL(loc_cEmpresa + THIS.this_cServico + "9999999999") + ;
                           " And ChkSubn = 0 And 0=1 Order By Numps, Dopps, cIdChaves"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpPend2") < 1
                    loc_lAbortar = .T.
                    MsgErro("Favor Reinicializar o Processo!!!", ;
                            "Falha na Conex" + CHR(227) + "o (OpPendente2)")
                ENDIF
            ENDIF

            IF !loc_lAbortar
                *-- Unir cursores de Operacao e Servico
                SELECT 0 AS Priors, Numps, Dopps FROM cursor_4c_OpPend1 ;
                    UNION ALL ;
                    SELECT 0 AS Priors, Numps, Dopps FROM cursor_4c_OpPend2 ;
                    INTO CURSOR cursor_4c_OpPendente READWRITE

                IF USED("cursor_4c_OpPend1")
                    USE IN cursor_4c_OpPend1
                ENDIF
                IF USED("cursor_4c_OpPend2")
                    USE IN cursor_4c_OpPend2
                ENDIF

                SELECT cursor_4c_OpPendente
                loc_oProg = CREATEOBJECT("fwprogressbar", "Processando Ops ...", RECCOUNT())
                loc_oProg.Show()

                SCAN
                    loc_oProg.Update(.T.)

                    *-- Buscar movimentos de producao (SigPdMvf)
                    loc_cSQL = "Select * From SigPdMvf Where Nops = " + ;
                               FormatarNumeroSQL(cursor_4c_OpPendente.Numps, 0) + ;
                               " Order by Nops, CidChaves desc"
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMfas")

                    IF !USED("cursor_4c_TmpMfas") OR RECCOUNT("cursor_4c_TmpMfas") = 0
                        IF USED("cursor_4c_TmpMfas")
                            USE IN cursor_4c_TmpMfas
                        ENDIF
                        LOOP
                    ENDIF

                    SELECT cursor_4c_TmpMfas
                    GO TOP
                    IF EMPTY(NVL(cursor_4c_TmpMfas.GrupoDs, ""))
                        USE IN cursor_4c_TmpMfas
                        LOOP
                    ENDIF

                    *-- Salvar valores de TmpMfas antes de trocar work area
                    loc_nMfasNops  = NVL(cursor_4c_TmpMfas.Nops, 0)
                    loc_nMfasNenvs = NVL(cursor_4c_TmpMfas.Nenvs, 0)
                    loc_nMfasNumps = NVL(cursor_4c_TmpMfas.Numps, 0)
                    loc_nPop       = loc_nMfasNops

                    loc_cOpCompara = IIF(ALLTRIM(NVL(cursor_4c_OpPendente.Dopps, "")) = ;
                                        ALLTRIM(THIS.this_cOperacao), ;
                                        THIS.this_cOperacao, THIS.this_cServico)

                    *-- Buscar dados da operacao em SigCdOpd
                    loc_cSQL = "Select * From SigCdOpd Where Dopps = " + ;
                               EscaparSQL(ALLTRIM(cursor_4c_TmpMfas.Dopps))
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdOpd")

                    IF !USED("cursor_4c_SigCdOpd") OR RECCOUNT("cursor_4c_SigCdOpd") = 0
                        IF USED("cursor_4c_SigCdOpd")
                            USE IN cursor_4c_SigCdOpd
                        ENDIF
                        USE IN cursor_4c_TmpMfas
                        LOOP
                    ENDIF

                    SELECT cursor_4c_SigCdOpd
                    IF NVL(cursor_4c_SigCdOpd.ChkDests, 0) = 3
                        USE IN cursor_4c_SigCdOpd
                        USE IN cursor_4c_TmpMfas
                        LOOP
                    ENDIF

                    loc_lEnvelope = (ALLTRIM(NVL(cursor_4c_SigCdOpd.Nivels, "")) <> ;
                                    ALLTRIM(loc_cOpCompara) OR ;
                                    NVL(cursor_4c_SigCdOpd.ChkDests, 0) = 1)
                    USE IN cursor_4c_SigCdOpd

                    *-- Query principal: SigOpPic + SigMvCab + SigCdOpe agrupados
                    loc_cSQL = "Select a.Nops, Sum(a.Qtds) as Qtds, b.ContaOs, b.ContaDs, " + ;
                               "b.prazoents, b.empdopNums, b.priors, b.Emps, b.Dopes, b.Numes, " + ;
                               "c.Globalizas, c.Servicos, a.cpros " + ;
                               "From SigOpPic a, SigMvCab b, SigCdOpe c " + ;
                               "Where a.Nops = " + FormatarNumeroSQL(loc_nPop, 0) + ;
                               " And a.EmpDopNums = b.EmpDopNums " + ;
                               "And b.Dopes = c.Dopes " + ;
                               "Group by a.Nops, b.ContaOs, b.ContaDs, b.prazoents, " + ;
                               "b.empdopnums, b.priors, b.emps, b.dopes, " + ;
                               "b.numes, c.globalizas, c.Servicos, a.cpros"

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpi") < 1
                        USE IN cursor_4c_TmpMfas
                        loc_lAbortar = .T.
                        MsgErro("Favor Reinicializar o Processo!!!", ;
                                "Falha na Conex" + CHR(227) + "o (crTmpOpi)")
                        EXIT
                    ENDIF

                    *-- Processar cada item da OP
                    SELECT cursor_4c_TmpOpi
                    SCAN
                        IF NVL(cursor_4c_TmpOpi.Qtds, 0) <> 0
                            *-- Calcular numero do envelope
                            IF loc_lEnvelope
                                loc_nEnv = loc_nMfasNenvs
                                IF loc_nMfasNenvs = loc_nMfasNops
                                    loc_nEnv = loc_nMfasNumps
                                ENDIF
                            ELSE
                                loc_nEnv = 0
                            ENDIF
                            loc_nEnv = IIF(loc_nEnv = 0, loc_nMfasNops, loc_nEnv)

                            *-- Globalizas=1 ou Servicos=1: usa ContaOs; senao ContaDs
                            IF NVL(cursor_4c_TmpOpi.Globalizas, 0) = 1 OR ;
                               NVL(cursor_4c_TmpOpi.Servicos, 0) = 1
                                loc_cCliente = ALLTRIM(NVL(cursor_4c_TmpOpi.ContaOs, ""))
                            ELSE
                                loc_cCliente = ALLTRIM(NVL(cursor_4c_TmpOpi.ContaDs, ""))
                            ENDIF

                            *-- Buscar razao social do cliente em SigCdCli
                            loc_cSQL = "Select rclis From SigCdCli Where Iclis = " + ;
                                       EscaparSQL(loc_cCliente)
                            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCli")
                            loc_cRclis = ""
                            IF USED("cursor_4c_TmpCli") AND RECCOUNT("cursor_4c_TmpCli") > 0
                                SELECT cursor_4c_TmpCli
                                loc_cRclis = ALLTRIM(NVL(rclis, ""))
                            ENDIF
                            IF USED("cursor_4c_TmpCli")
                                USE IN cursor_4c_TmpCli
                            ENDIF

                            *-- Capturar valores de TmpOpi para o REPLACE
                            SELECT cursor_4c_TmpOpi
                            loc_nPriors    = NVL(cursor_4c_TmpOpi.Priors, 0)
                            loc_cEmps      = ALLTRIM(NVL(cursor_4c_TmpOpi.Emps, ""))
                            loc_cDopes     = ALLTRIM(NVL(cursor_4c_TmpOpi.Dopes, ""))
                            loc_nNumes     = NVL(cursor_4c_TmpOpi.Numes, 0)
                            loc_tPrazoEnts = NVL(cursor_4c_TmpOpi.PrazoEnts, {})
                            loc_cCpros     = ALLTRIM(NVL(cursor_4c_TmpOpi.Cpros, ""))
                            loc_nQtds      = NVL(cursor_4c_TmpOpi.Qtds, 0)

                            *-- Inserir no cursor destino
                            SELECT (par_cCursorDestino)
                            APPEND BLANK
                            REPLACE Priors    WITH loc_nPriors, ;
                                    Nenvs     WITH loc_nEnv, ;
                                    Nops      WITH loc_nMfasNops, ;
                                    Emps      WITH loc_cEmps, ;
                                    Dopes     WITH loc_cDopes, ;
                                    Numes     WITH loc_nNumes, ;
                                    Contas    WITH loc_cCliente, ;
                                    Rclis     WITH LEFT(loc_cRclis, 40), ;
                                    PrazoEnts WITH loc_tPrazoEnts, ;
                                    Cpros     WITH loc_cCpros, ;
                                    Qtds      WITH loc_nQtds, ;
                                    aPriors   WITH loc_nPriors
                        ENDIF
                    ENDSCAN

                    IF USED("cursor_4c_TmpOpi")
                        USE IN cursor_4c_TmpOpi
                    ENDIF
                    IF USED("cursor_4c_TmpMfas")
                        USE IN cursor_4c_TmpMfas
                    ENDIF
                ENDSCAN

                IF VARTYPE(loc_oProg) = "O"
                    loc_oProg.Complete()
                    loc_oProg = .NULL.
                ENDIF

                IF !loc_lAbortar
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        *-- Limpeza de cursores temporarios
        IF USED("cursor_4c_OpPend1")
            USE IN cursor_4c_OpPend1
        ENDIF
        IF USED("cursor_4c_OpPend2")
            USE IN cursor_4c_OpPend2
        ENDIF
        IF USED("cursor_4c_OpPendente")
            USE IN cursor_4c_OpPendente
        ENDIF
        IF USED("cursor_4c_TmpMfas")
            USE IN cursor_4c_TmpMfas
        ENDIF
        IF USED("cursor_4c_SigCdOpd")
            USE IN cursor_4c_SigCdOpd
        ENDIF
        IF USED("cursor_4c_TmpOpi")
            USE IN cursor_4c_TmpOpi
        ENDIF
        IF USED("cursor_4c_TmpCli")
            USE IN cursor_4c_TmpCli
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza prioridade de uma OP individual em SigMvCab
    * Usa: this_nPriors, this_cEmps, this_cDopes, this_nNumes
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "Update SigMvCab Set Priors = " + ;
                       FormatarNumeroSQL(THIS.this_nPriors, 0) + ;
                       " Where EmpDopNums = " + ;
                       EscaparSQL(THIS.ObterChavePrimaria())
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * GravarPrioridades - Grava todas as prioridades alteradas em lote
    * par_cCursorSelecao: cursor com os registros (ex: "zTmpSelecao")
    * Ignora registros onde Priors=0 E aPriors=0 (sem alteracao)
    *--------------------------------------------------------------------------
    FUNCTION GravarPrioridades(par_cCursorSelecao)
        LOCAL loc_lSucesso, loc_lTransacao, loc_cSQL, loc_oErro
        LOCAL loc_cEdn, loc_nPriors

        loc_lSucesso   = .T.
        loc_lTransacao = .F.

        TRY
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
            loc_lTransacao = .T.

            SELECT (par_cCursorSelecao)
            GO TOP
            SCAN
                IF NVL(Priors, 0) = 0 AND NVL(aPriors, 0) = 0
                    LOOP
                ENDIF

                loc_nPriors = NVL(Priors, 0)
                loc_cEdn    = ALLTRIM(NVL(Emps, "")) + ;
                              ALLTRIM(NVL(Dopes, "")) + ;
                              STR(NVL(Numes, 0), 6)

                loc_cSQL = "Update SigMvCab Set Priors = " + ;
                           FormatarNumeroSQL(loc_nPriors, 0) + ;
                           " Where EmpDopNums = " + EscaparSQL(loc_cEdn)

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                    loc_lSucesso = .F.
                    EXIT
                ENDIF
            ENDSCAN

            IF loc_lSucesso
                SQLEXEC(gnConnHandle, "COMMIT")
                THIS.RegistrarAuditoria("GRAVARPRIORIDADES")
            ELSE
                SQLEXEC(gnConnHandle, "ROLLBACK")
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel completar " + ;
                        "o processamento (commit). Tente novamente!!", ;
                        "Falha na Grava" + CHR(231) + CHR(227) + "o")
            ENDIF

        CATCH TO loc_oErro
            IF loc_lTransacao
                SQLEXEC(gnConnHandle, "ROLLBACK")
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterImagemProduto - Busca e grava imagem Base64 de SigCdPro em arquivo
    * par_cCpros: codigo do produto
    * par_cArquivoDestino: caminho completo do arquivo temporario
    * Retorna: .T. se imagem obtida e gravada com sucesso
    *--------------------------------------------------------------------------
    FUNCTION ObterImagemProduto(par_cCpros, par_cArquivoDestino)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro, loc_cFoto
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "Select FigJpgs From SigCdPro Where Cpros = " + ;
                       EscaparSQL(par_cCpros)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPro") > 0
                IF USED("cursor_4c_TmpPro") AND RECCOUNT("cursor_4c_TmpPro") > 0
                    SELECT cursor_4c_TmpPro
                    IF !EMPTY(NVL(cursor_4c_TmpPro.FigJpgs, ""))
                        loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN( ;
                                    cursor_4c_TmpPro.FigJpgs, ;
                                    "data:image/png;base64,", ""), ;
                                    "data:image/jpeg;base64,", ""), ;
                                    "data:image/jpg;base64,", ""), 14)
                        IF STRTOFILE(loc_cFoto, par_cArquivoDestino) > 0
                            loc_lSucesso = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_TmpPro")
            USE IN cursor_4c_TmpPro
        ENDIF
        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

