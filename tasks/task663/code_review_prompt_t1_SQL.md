# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDNPS, 0, NOPS, CHKDESTS, DOPES, SERVICOS, ICLIS, CPROS, APRIORS, EMPDOPNUMS, CHKSUBN

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrPcp.prg) - TRECHOS RELEVANTES PARA PASS SQL (1356 linhas total):

*-- Linhas 101 a 162:
101: 
102:                 *-- Criar cursor base para dados PCP (zTmppPcp do legado)
103:                 SET NULL ON
104:                 CREATE CURSOR cursor_4c_PcpDados ( ;
105:                     Priors    N(6)    NULL, ;
106:                     Nenvs     N(10)   NULL, ;
107:                     Nops      N(10)   NULL, ;
108:                     Emps      C(3)    NULL, ;
109:                     Dopes     C(20)   NULL, ;
110:                     Numes     N(6)    NULL, ;
111:                     Contas    C(10)   NULL, ;
112:                     Rclis     C(40)   NULL, ;
113:                     PrazoEnts T       NULL, ;
114:                     Cpros     C(14)   NULL, ;
115:                     Qtds      N(9,3)  NULL, ;
116:                     aPriors   N(6)    NULL  ;
117:                 )
118:                 SET NULL OFF
119: 
120:                 *-- Processar OPs (cursor fica vazio se BD indisponivel)
121:                 IF !THIS.this_oBusinessObject.Processar("cursor_4c_PcpDados")
122:                     MsgErro("Erro no Processamento dos Dados...", "Erro")
123:                 ENDIF
124: 
125:                 *-- Criar cursor de selecao consolidado (zTmpSelecao do legado)
126:                 SET NULL ON
127:                 SELECT DISTINCT Emps, Dopes, Numes, Contas, Rclis, ;
128:                                 PrazoEnts, Priors, aPriors ;
129:                     FROM cursor_4c_PcpDados ;
130:                     INTO CURSOR cursor_4c_Selecao READWRITE
131:                 SET NULL OFF
132: 
133:                 *-- Indexar cursor de selecao para ordenacao
134:                 SELECT cursor_4c_Selecao
135:                 INDEX ON Emps + Dopes + STR(Numes,6) TAG EmpdopNum
136:                 INDEX ON DTOS(PrazoEnts) + Emps + Dopes + STR(Numes,6) TAG Entrega
137:                 INDEX ON Contas TAG Cliente
138:                 INDEX ON STR(Priors,6) + Emps + Dopes + STR(Numes,6) TAG Prioridade
139:                 SET ORDER TO Entrega
140: 
141:                 *-- Indexar cursor de dados PCP para RELATION
142:                 SELECT cursor_4c_PcpDados
143:                 INDEX ON Emps + Dopes + STR(Numes,6) TAG EmpdopNum
144:                 GO TOP
145: 
146:                 *-- Estabelecer relacao entre cursores (como SET RELATION do legado)
147:                 SELECT cursor_4c_Selecao
148:                 GO TOP
149:                 SET RELATION TO Emps + Dopes + STR(Numes,6) INTO cursor_4c_PcpDados
150: 
151:                 *-- Montar interface visual
152:                 THIS.ConfigurarPageFrame()
153:                 THIS.ConfigurarCabecalho()
154:                 THIS.ConfigurarPaginaLista()
155:                 THIS.ConfigurarBotoes()
156:                 THIS.ConfigurarPaginaDados()
157:                 THIS.ConfigurarControlesAuxiliares()
158:                 THIS.ConfigurarImagemProduto()
159:                 THIS.TornarControlesVisiveis()
160: 
161:                 *-- Propagar titulo para labels do cabecalho
162:                 THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption

*-- Linhas 296 a 314:
296:             .ColumnCount   = 6
297:             .FontName      = "Tahoma"
298:             .FontSize      = 8
299:             .DeleteMark    = .F.
300:             .RecordMark    = .F.
301:             .ReadOnly      = .T.
302:             .RowHeight     = 16
303:             .ScrollBars    = 2
304:             .GridLineColor = RGB(238,238,238)
305:             .Visible       = .T.
306: 
307:             WITH .Column1
308:                 .Width             = 50
309:                 .Movable           = .F.
310:                 .Resizable         = .F.
311:                 .ReadOnly          = .F.
312:                 .Header1.Caption   = "Prioridade"
313:                 .Header1.Alignment = 2
314:                 .Header1.ForeColor = RGB(0,0,0)

*-- Linhas 400 a 418:
400:             .ColumnCount   = 4
401:             .FontName      = "Tahoma"
402:             .FontSize      = 8
403:             .DeleteMark    = .F.
404:             .RecordMark    = .F.
405:             .ReadOnly      = .T.
406:             .RowHeight     = 16
407:             .ScrollBars    = 2
408:             .GridLineColor = RGB(238,238,238)
409:             .Visible       = .T.
410: 
411:             WITH .Column1
412:                 .Width             = 80
413:                 .Movable           = .F.
414:                 .Resizable         = .F.
415:                 .ReadOnly          = .T.
416:                 .Header1.Caption   = "Envelope"
417:                 .Header1.Alignment = 2
418:                 .Header1.ForeColor = RGB(0,0,0)

*-- Linhas 662 a 710:
662:     ENDPROC
663: 
664:     *==========================================================================
665:     * CarregarGrades - Configura RecordSource/ControlSource e popula combo
666:     *==========================================================================
667:     PROTECTED PROCEDURE CarregarGrades
668:         LOCAL loc_lSucesso, loc_oErro
669:         loc_lSucesso = .F.
670: 
671:         TRY
672:             IF !USED("cursor_4c_Selecao") OR !USED("cursor_4c_PcpDados")
673:                 MsgErro("Cursores de dados n" + CHR(227) + "o inicializados.", "Erro")
674:             ELSE
675:                 *-- Vincular grade principal ao cursor de selecao
676:                 THIS.grd_4c_Dados.ColumnCount  = 6
677:                 THIS.grd_4c_Dados.RecordSource = "cursor_4c_Selecao"
678:                 WITH THIS.grd_4c_Dados
679:                     .Column1.ControlSource = "cursor_4c_Selecao.Priors"
680:                     .Column2.ControlSource = "cursor_4c_Selecao.Emps"
681:                     .Column3.ControlSource = "cursor_4c_Selecao.Dopes"
682:                     .Column4.ControlSource = "cursor_4c_Selecao.Numes"
683:                     .Column5.ControlSource = "cursor_4c_Selecao.Contas"
684:                     .Column6.ControlSource = "cursor_4c_Selecao.PrazoEnts"
685:                     .Refresh()
686:                 ENDWITH
687: 
688:                 *-- Vincular grade de itens ao cursor de dados PCP
689:                 THIS.grd_4c_Itens.ColumnCount  = 4
690:                 THIS.grd_4c_Itens.RecordSource = "cursor_4c_PcpDados"
691:                 WITH THIS.grd_4c_Itens
692:                     .Column1.ControlSource = "cursor_4c_PcpDados.Nenvs"
693:                     .Column2.ControlSource = "cursor_4c_PcpDados.Nops"
694:                     .Column3.ControlSource = "cursor_4c_PcpDados.Cpros"
695:                     .Column4.ControlSource = "cursor_4c_PcpDados.Qtds"
696:                     .Refresh()
697:                 ENDWITH
698: 
699:                 *-- Larguras, legendas e editabilidade POR ULTIMO: BtnVisualizarClick
700:                 *-- destroi (USE IN) e recria os cursores antes de rechamar este
701:                 *-- metodo, e RecordSource sobre cursor recriado devolve as colunas
702:                 *-- ao default 90 com Header "Header1" (regra #41 / Problema 48).
703:                 WITH THIS.grd_4c_Dados
704:                     .Column1.Width = 50
705:                     .Column2.Width = 31
706:                     .Column3.Width = 150
707:                     .Column4.Width = 52
708:                     .Column5.Width = 80
709:                     .Column6.Width = 80
710:                     .Column1.Header1.Caption = "Prioridade"

*-- Linhas 741 a 761:
741:                 ENDWITH
742: 
743:                 *-- Posicionar e atualizar painel de info
744:                 SELECT cursor_4c_PcpDados
745:                 GO TOP
746:                 SELECT cursor_4c_Selecao
747:                 GO TOP
748:                 THIS.grd_4c_Dados.SetFocus()
749:                 THIS.GrdDadosAfterRowColChange(1)
750: 
751:                 loc_lSucesso = .T.
752:             ENDIF
753:         CATCH TO loc_oErro
754:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
755:                     " PROC=" + loc_oErro.Procedure, ;
756:                     "Erro FormSigPrPcp.CarregarGrades")
757:         ENDTRY
758: 
759:         RETURN loc_lSucesso
760:     ENDPROC
761: 

*-- Linhas 803 a 860:
803:             RETURN
804:         ENDIF
805:         THIS.LockScreen = .T.
806:         SELECT cursor_4c_Selecao
807:         THIS.txt_4c_Cliente.Value = NVL(cursor_4c_Selecao.Rclis, "")
808:         THIS.txt_4c_Cliente.Refresh()
809:         SELECT cursor_4c_PcpDados
810:         GO TOP
811:         THIS.grd_4c_Itens.Refresh()
812:         THIS.img_4c_FigJpg.Visible = .F.
813:         THIS.img_4c_FigJpg.Picture = ""
814:         SELECT cursor_4c_Selecao
815:         THIS.txt_4c_Info.Value = NVL(cursor_4c_Selecao.Emps, "") + " " + ;
816:             ALLTRIM(NVL(cursor_4c_Selecao.Dopes, "")) + " " + ;
817:             STR(NVL(cursor_4c_Selecao.Numes, 0), 6)
818:         THIS.LockScreen = .F.
819:     ENDPROC
820: 
821:     *==========================================================================
822:     * GrdItensAfterRowColChange - Carrega foto do produto ao mudar linha nos itens
823:     *==========================================================================
824:     PROCEDURE GrdItensAfterRowColChange
825:         LPARAMETERS par_nColIndex
826:         LOCAL loc_cCpros
827:         IF !USED("cursor_4c_PcpDados")
828:             RETURN
829:         ENDIF
830:         THIS.LockScreen = .T.
831:         THIS.img_4c_FigJpg.Visible = .F.
832:         THIS.img_4c_FigJpg.Picture = ""
833:         THIS.shp_4c_Shape4.Visible = .F.
834:         SELECT cursor_4c_PcpDados
835:         IF !EOF("cursor_4c_PcpDados")
836:             loc_cCpros = NVL(cursor_4c_PcpDados.Cpros, "")
837:             IF !EMPTY(loc_cCpros)
838:                 IF THIS.this_oBusinessObject.ObterImagemProduto(loc_cCpros, THIS.this_cArquivoTempImg)
839:                     THIS.img_4c_FigJpg.Picture = THIS.this_cArquivoTempImg
840:                     THIS.img_4c_FigJpg.Visible = .T.
841:                     THIS.shp_4c_Shape4.Visible = .T.
842:                 ENDIF
843:             ENDIF
844:         ENDIF
845:         SELECT cursor_4c_PcpDados
846:         THIS.LockScreen = .F.
847:     ENDPROC
848: 
849:     *==========================================================================
850:     * GrdDadosCol1LostFocus - TAB na coluna Prioridade salta para grade de itens
851:     * Legado: SIGPRPCP.Grade.Column1.Text1.LostFocus
852:     *     If Lastkey() = 9 / ThisForm.GradeItem.SetFocus / EndIf
853:     * LostFocus nao recebe parametro (regra #3: a assinatura segue o evento).
854:     * LASTKEY() so vale no LostFocus: dentro de KeyPress ele devolve a tecla
855:     * ANTERIOR, e o salto entre grades nunca acontecia.
856:     *==========================================================================
857:     PROCEDURE GrdDadosCol1LostFocus
858:         IF THIS.this_lTrocandoGrade
859:             RETURN
860:         ENDIF

*-- Linhas 888 a 968:
888:         IF !USED("cursor_4c_Selecao")
889:             RETURN
890:         ENDIF
891:         SELECT cursor_4c_Selecao
892:         SET RELATION TO
893:         SET ORDER TO
894:         DO CASE
895:             CASE ALLTRIM(THIS.cbo_4c_Ordenacao.Value) = "Prazo Entrega"
896:                 SET ORDER TO Entrega
897:             CASE ALLTRIM(THIS.cbo_4c_Ordenacao.Value) = "Cliente"
898:                 SET ORDER TO Cliente
899:             CASE ALLTRIM(THIS.cbo_4c_Ordenacao.Value) = "Operacao"
900:                 SET ORDER TO EmpDopNum
901:             CASE ALLTRIM(THIS.cbo_4c_Ordenacao.Value) = "Prioridade"
902:                 SET ORDER TO Prioridade
903:         ENDCASE
904:         SELECT cursor_4c_Selecao
905:         SET RELATION TO Emps + Dopes + STR(Numes,6) INTO cursor_4c_PcpDados
906:         THIS.grd_4c_Dados.Refresh()
907:     ENDPROC
908: 
909:     *==========================================================================
910:     * ValidarPrioridades - Regra do unico campo digitavel da tela (Priors)
911:     *
912:     * O legado nao tem Valid na celula: a regra que governa a coluna Prioridade
913:     * mora no Salva.Click (SIGPRPCP.Salva), transcrita aqui linha a linha:
914:     *
915:     *     Select zTmpSelecao
916:     *     Scan
917:     *         Scatter Memvar
918:     *         If m.Priors = 0 And m.aPriors = 0
919:     *             Loop
920:     *         Endif
921:     *         ...Update SigMvCab Set Priors = ...
922:     *     EndScan
923:     *
924:     * Ou seja: so vai ao banco a linha cuja prioridade digitada (Priors) OU a
925:     * prioridade ja gravada (aPriors) seja diferente de zero. Sem nenhuma linha
926:     * nessa condicao o Scan do legado roda em vazio, da Commit e fecha a tela -
927:     * o usuario sai achando que gravou. Aqui a ausencia de linha elegivel eh
928:     * avisada e a gravacao eh abortada antes de abrir transacao.
929:     *
930:     * A faixa 0..99 NAO vem do legado (a InputMask "999999" da celula aceita 6
931:     * digitos, transcrita fielmente): vem do SCHEMA - SigMvCab.priors eh
932:     * numeric(2,0). Sem a checagem, digitar 100 faz o UPDATE estourar overflow
933:     * no meio da transacao e o usuario recebe o erro cru do SQL Server. O
934:     * resultado liquido eh o mesmo do legado (nada eh gravado), com mensagem
935:     * legivel e com o cursor posicionado na linha ofensora.
936:     *
937:     * PUBLIC: a Fase 7/8 (BtnSalvarClick) chama este metodo de fora.
938:     *==========================================================================
939:     PROCEDURE ValidarPrioridades()
940:         LOCAL loc_lValido, loc_nRegAtual, loc_nElegiveis, loc_nPriors
941:         LOCAL loc_cOpInvalida, loc_nRegInvalido, loc_oErro
942: 
943:         loc_lValido      = .F.
944:         loc_nElegiveis   = 0
945:         loc_nRegInvalido = 0
946:         loc_cOpInvalida  = ""
947: 
948:         TRY
949:             IF !USED("cursor_4c_Selecao")
950:                 MsgAviso("Dados de sele" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
951:                          "o dispon" + CHR(237) + "veis.", "Aten" + CHR(231) + CHR(227) + "o")
952:             ELSE
953:                 SELECT cursor_4c_Selecao
954:                 loc_nRegAtual = RECNO("cursor_4c_Selecao")
955: 
956:                 SCAN
957:                     loc_nPriors = NVL(cursor_4c_Selecao.Priors, 0)
958: 
959:                     *-- Criterio do Salva.Click legado: Priors = 0 E aPriors = 0 -> pula
960:                     IF loc_nPriors <> 0 OR NVL(cursor_4c_Selecao.aPriors, 0) <> 0
961:                         loc_nElegiveis = loc_nElegiveis + 1
962:                     ENDIF
963: 
964:                     *-- Faixa da coluna destino SigMvCab.priors numeric(2,0)
965:                     IF loc_nRegInvalido = 0 AND (loc_nPriors < 0 OR loc_nPriors > 99)
966:                         loc_nRegInvalido = RECNO("cursor_4c_Selecao")
967:                         loc_cOpInvalida  = NVL(cursor_4c_Selecao.Emps, "") + " " + ;
968:                                            ALLTRIM(NVL(cursor_4c_Selecao.Dopes, "")) + " " + ;

*-- Linhas 1007 a 1025:
1007:     *==========================================================================
1008:     * BtnConfirmarClick - Grava prioridades no banco (Salva.Click do legado)
1009:     *
1010:     * Legado: MessageBox('Confirma Gravacao dos Dados!!!') -> Scan -> Update ->
1011:     *         Commit -> ThisForm.Release.
1012:     * A validacao do campo digitavel (ValidarPrioridades) roda ANTES do
1013:     * MessageBox: perguntar "Confirma Gravacao" para em seguida recusar a
1014:     * gravacao faria o usuario responder por uma acao que nao pode acontecer.
1015:     *==========================================================================
1016:     PROCEDURE BtnConfirmarClick
1017:         IF !THIS.ValidarPrioridades()
1018:             RETURN
1019:         ENDIF
1020:         IF !MsgConfirma("Confirma Grava" + CHR(231) + CHR(227) + "o dos Dados!!!")
1021:             RETURN
1022:         ENDIF
1023:         IF THIS.this_oBusinessObject.GravarPrioridades("cursor_4c_Selecao")
1024:             THIS.Release()
1025:         ENDIF

*-- Linhas 1049 a 1067:
1049:                 loc_lProsseguir = .F.
1050:             ENDIF
1051:             IF loc_lProsseguir
1052:                 SELECT cursor_4c_Selecao
1053:                 GO TOP
1054:                 THIS.grd_4c_Dados.Refresh()
1055:                 THIS.GrdDadosAfterRowColChange(1)
1056:                 THIS.grd_4c_Dados.SetFocus()
1057:                 THIS.grd_4c_Dados.ActivateCell(1, 1)
1058:             ENDIF
1059:         CATCH TO loc_oErro
1060:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1061:                     "Erro BtnIncluir")
1062:         ENDTRY
1063:     ENDPROC
1064: 
1065:     *==========================================================================
1066:     * BtnAlterarClick - Edita prioridade da linha selecionada na grade principal
1067:     * Mapeamento OPERACIONAL: "alterar" = editar a coluna Priors da linha corrente

*-- Linhas 1076 a 1094:
1076:                 loc_lProsseguir = .F.
1077:             ENDIF
1078:             IF loc_lProsseguir
1079:                 SELECT cursor_4c_Selecao
1080:                 IF EOF() OR BOF()
1081:                     GO TOP
1082:                 ENDIF
1083:                 loc_nLinha = THIS.grd_4c_Dados.RelativeRow
1084:                 IF loc_nLinha < 1
1085:                     loc_nLinha = 1
1086:                 ENDIF
1087:                 THIS.grd_4c_Dados.SetFocus()
1088:                 THIS.grd_4c_Dados.ActivateCell(loc_nLinha, 1)
1089:             ENDIF
1090:         CATCH TO loc_oErro
1091:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1092:                     "Erro BtnAlterar")
1093:         ENDTRY
1094:     ENDPROC

*-- Linhas 1111 a 1176:
1111: 
1112:             *-- Encerrar relacao e cursores para reprocessar
1113:                 IF USED("cursor_4c_Selecao")
1114:                     SELECT cursor_4c_Selecao
1115:                     SET RELATION TO
1116:                     USE IN cursor_4c_Selecao
1117:                 ENDIF
1118:                 IF USED("cursor_4c_PcpDados")
1119:                     USE IN cursor_4c_PcpDados
1120:                 ENDIF
1121: 
1122:             *-- Recriar cursor base
1123:                 SET NULL ON
1124:                 CREATE CURSOR cursor_4c_PcpDados ( ;
1125:                     Priors    N(6)    NULL, ;
1126:                     Nenvs     N(10)   NULL, ;
1127:                     Nops      N(10)   NULL, ;
1128:                     Emps      C(3)    NULL, ;
1129:                     Dopes     C(20)   NULL, ;
1130:                     Numes     N(6)    NULL, ;
1131:                     Contas    C(10)   NULL, ;
1132:                     Rclis     C(40)   NULL, ;
1133:                     PrazoEnts T       NULL, ;
1134:                     Cpros     C(14)   NULL, ;
1135:                     Qtds      N(9,3)  NULL, ;
1136:                     aPriors   N(6)    NULL  ;
1137:                 )
1138:                 SET NULL OFF
1139: 
1140:                 IF THIS.this_oBusinessObject.Processar("cursor_4c_PcpDados")
1141:                     *-- Recriar cursor de selecao consolidado
1142:                     SET NULL ON
1143:                     SELECT DISTINCT Emps, Dopes, Numes, Contas, Rclis, ;
1144:                                     PrazoEnts, Priors, aPriors ;
1145:                         FROM cursor_4c_PcpDados ;
1146:                         INTO CURSOR cursor_4c_Selecao READWRITE
1147:                     SET NULL OFF
1148:     
1149:                     *-- Reindexar
1150:                     SELECT cursor_4c_Selecao
1151:                     INDEX ON Emps + Dopes + STR(Numes,6) TAG EmpdopNum
1152:                     INDEX ON DTOS(PrazoEnts) + Emps + Dopes + STR(Numes,6) TAG Entrega
1153:                     INDEX ON Contas TAG Cliente
1154:                     INDEX ON STR(Priors,6) + Emps + Dopes + STR(Numes,6) TAG Prioridade
1155:                     SET ORDER TO Entrega
1156:     
1157:                     SELECT cursor_4c_PcpDados
1158:                     INDEX ON Emps + Dopes + STR(Numes,6) TAG EmpdopNum
1159:                     GO TOP
1160:     
1161:                     SELECT cursor_4c_Selecao
1162:                     GO TOP
1163:                     SET RELATION TO Emps + Dopes + STR(Numes,6) INTO cursor_4c_PcpDados
1164:     
1165:                     *-- Revincular grids aos cursores recriados
1166:                     THIS.CarregarGrades()
1167:                     MsgInfo("Dados recarregados com sucesso.", "Visualizar")
1168:                 ELSE
1169:                     MsgErro("Falha ao reprocessar dados PCP.", "Erro Visualizar")
1170:                 ENDIF
1171: 
1172:                 THIS.LockScreen = .F.
1173:             ENDIF
1174:         CATCH TO loc_oErro
1175:             THIS.LockScreen = .F.
1176:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;

*-- Linhas 1192 a 1210:
1192:                 loc_lProsseguir = .F.
1193:             ENDIF
1194:             IF loc_lProsseguir
1195:                 SELECT cursor_4c_Selecao
1196:                 IF EOF() OR BOF()
1197:                     MsgAviso("Selecione uma linha na grade antes de zerar a prioridade.", ;
1198:                              "Aviso")
1199:                     loc_lProsseguir = .F.
1200:                 ENDIF
1201:             ENDIF
1202:             IF loc_lProsseguir
1203:                 IF NVL(cursor_4c_Selecao.Priors, 0) = 0
1204:                     MsgAviso("A prioridade desta opera" + CHR(231) + CHR(227) + ;
1205:                              "o j" + CHR(225) + " est" + CHR(225) + " zerada.", "Aviso")
1206:                     loc_lProsseguir = .F.
1207:                 ENDIF
1208:             ENDIF
1209:             IF loc_lProsseguir
1210:                 IF !MsgConfirma("Zerar prioridade da opera" + CHR(231) + CHR(227) + "o selecionada?")

*-- Linhas 1307 a 1325:
1307:                 loc_lProsseguir = .F.
1308:             ENDIF
1309:             IF loc_lProsseguir
1310:                 SELECT cursor_4c_Selecao
1311:                 GO TOP
1312:                 THIS.grd_4c_Dados.Refresh()
1313:                 THIS.GrdDadosAfterRowColChange(1)
1314:                 THIS.grd_4c_Dados.SetFocus()
1315:             ENDIF
1316:         CATCH TO loc_oErro
1317:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1318:                     "Erro BtnBuscar")
1319:         ENDTRY
1320:     ENDPROC
1321: 
1322:     *==========================================================================
1323:     * BtnSalvarClick - Alias de BtnConfirmarClick (padrao FormBase)
1324:     *==========================================================================
1325:     PROCEDURE BtnSalvarClick()

*-- Linhas 1338 a 1356:
1338:     *==========================================================================
1339:         *-- Encerrar relacao entre cursores antes de fechar
1340:         IF USED("cursor_4c_Selecao")
1341:             SELECT cursor_4c_Selecao
1342:             SET RELATION TO
1343:             USE IN cursor_4c_Selecao
1344:         ENDIF
1345:         IF USED("cursor_4c_PcpDados")
1346:             USE IN cursor_4c_PcpDados
1347:         ENDIF
1348:         *-- Remover arquivo temporario de imagem de produto
1349:         IF !EMPTY(THIS.this_cArquivoTempImg) AND FILE(THIS.this_cArquivoTempImg)
1350:             ERASE (THIS.this_cArquivoTempImg)
1351:         ENDIF
1352:         THIS.this_oBusinessObject = .NULL.
1353:         DODEFAULT()
1354:     ENDPROC
1355: 
1356: ENDDEFINE


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
    * MontarEmpDopNums - Monta a chave POSICIONAL EmpDopNums char(29)
    *
    * Legado (SIGPRPCP.Salva.Click):
    *     lcEdn = m.Emps + m.Dopes + Str(m.Numes,6)
    * Sem ALLTRIM: o padding FAZ PARTE da chave. Pelo schema,
    * SigMvCab.emps eh char(3), dopes eh char(20) e numes eh numeric(6,0),
    * somando exatamente os 29 de SigMvCab.empdopnums char(29).
    *
    * As properties this_cEmps/this_cDopes sao guardadas com ALLTRIM (vem de
    * CarregarDoCursor), entao o PADR tem de ser explicito aqui - concatenar as
    * partes aparadas produz uma chave curta que o WHERE nunca casa: o UPDATE
    * roda sem erro, afeta ZERO linha e a gravacao nao acontece (regra #42).
    *--------------------------------------------------------------------------
    FUNCTION MontarEmpDopNums(par_cEmps, par_cDopes, par_nNumes)
        RETURN PADR(NVL(par_cEmps, ""), 3) + ;
               PADR(NVL(par_cDopes, ""), 20) + ;
               STR(NVL(par_nNumes, 0), 6)
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave concatenada do registro corrente
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.MontarEmpDopNums(THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes)
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
            THIS.this_cEmpDopNum = THIS.MontarEmpDopNums(THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes)
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

    *==========================================================================
    * Inserir() / ExecutarExclusao() - decisao de arquitetura: o legado
    * (SIGPRPCP.Salva.Click) so executa Update SigMvCab Set Priors = ... -
    * nao ha Insert nem Delete em tabela nenhuma neste formulario, que apenas
    * reprioriza Ordens de Producao ja existentes (vindas de SigCdNec/
    * SigPdMvf/SigOpPic). O comportamento padrao herdado de BusinessBase para
    * Inserir()/ExecutarExclusao() permanece correto aqui e NAO e sobrescrito.
    * A gravacao real esta em Atualizar() (registro unico) e
    * GravarPrioridades() (lote, espelhando o Scan do Salva.Click legado).
    *==========================================================================

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
                THIS.this_cEmps   = ALLTRIM(NVL(Emps, ""))
                THIS.this_cDopes  = ALLTRIM(NVL(Dopes, ""))
                THIS.this_nNumes  = NVL(Numes, 0)
                THIS.this_nPriors = loc_nPriors
                loc_cEdn    = THIS.MontarEmpDopNums(THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes)

                loc_cSQL = "Update SigMvCab Set Priors = " + ;
                           FormatarNumeroSQL(loc_nPriors, 0) + ;
                           " Where EmpDopNums = " + EscaparSQL(loc_cEdn)

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                    loc_lSucesso = .F.
                    EXIT
                ENDIF

                *-- Audita cada OP cuja prioridade foi alterada (chave corrente)
                THIS.RegistrarAuditoria("ATUALIZAR")
            ENDSCAN

            IF loc_lSucesso
                SQLEXEC(gnConnHandle, "COMMIT")
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

