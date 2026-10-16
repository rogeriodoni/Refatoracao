# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NREGIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I, CODIGOS, SELIMP

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
	Select crSigMlItn
	.DeleteMark 	   = .f.
	.Column1.ControlSource   = 'crSigMlItn.SelImp'
	.Column2.ControlSource   = 'crSigMlItn.Codigos'
	.Column3.ControlSource   = 'crSigMlItn.Descs'
	.Column4.ControlSource   = 'crSigMlItn.Usuins'
	.Column5.ControlSource   = 'crSigMlItn.Datins'
	.Column6.ControlSource   = 'crSigMlItn.Nregis'
Select * ;
  From crSigMlCab ;
Select Codigos ;
  From crSigMlItn ;
Select csMalasSelecionadas
	lcQuery = [Select ] + lcCampo + [ From SigMlCab a Where Codigos = ?pCod Order By ] + lcCampo
	ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmp')
	Select crTmp
		Select crTmp
		Select csMalaDuplicada
Select Padr(Upper(StrTran(a.Desti + a.Ceps + a.Endes + a.Nums + a.Compls, ' ', '')), 200) as ChaveUnica, a.* ;
  From csMalaDuplicada a ;
Select * ;
  From csMalaUnificada1 ;
Select csMalaUnificada   
Select csMalaUnificada1
	If !Seek(csMalaUnificada1.ChaveUnica,'csMalaUnificada','idxmalauni')
		Insert into csMalaUnificada From Memvar
Select csMalaUnificada
	Select csMalaUnificada
	Select crSigMlCab
Insert Into crSigMlItn (Codigos, Descs, Ativos, UsuIns, DatIns, DatAlts, Ults, DtEnts, NRegis, Espelhos, Unificas) ;
	.Update('crSigMlCab')
	.Update('crSigMlItn')
Select crSigMlCab
lcQryMalc = 'Select 0 as SelImp, * From SigMlItn'
lcQryMala = 'Select * From SigMlCab Where Codigos = ?pCod'
Select crSigMlItn
	Select crSigMlItn
Select Codigos ;
  From crSigMlItn ;
Update crSigMlItn Set SelImp = This.Value

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrMlu.prg) - TRECHOS RELEVANTES PARA PASS SQL (1480 linhas total):

*-- Linhas 51 a 69:
51: *  - O que esta fase entregou de verdade nos eventos dos botoes:
52: *      . MarcarTodasAs() - funil unico dos DOIS botoes do cmdBtnGrade, que no
53: *        legado compartilham UM Click so (o indice do botao eh o proprio valor
54: *        gravado), com UPDATE-SQL no lugar de REPLACE ALL para nao jogar o
55: *        ponteiro do cursor em EOF e fazer a grade saltar para o fim.
56: *      . BtnProcessarClick() - reabilitacao INCONDICIONAL do botao Processar
57: *        depois do ENDTRY, equivalente aos quatro "This.Enabled = .t." que o
58: *        legado repete em cada caminho de saida do cmdProcessar.Click.
59: *      . ValidarProcessamento() - TRY/CATCH que REPROVA quando a validacao nao
60: *        consegue concluir, em vez de deixar o Program Error cru do VFP subir.
61: *
62: * FASE 8 (eventos auxiliares e consolidacao final):
63: *  - RENOMEADOS para o nome CANONICO do projeto, que eh o VERBO da acao e nao
64: *    o nome do objeto legado: CmdProcessarClick -> BtnProcessarClick (botao de
65: *    acao, Caption "\<Processar", objeto legado cmdProcessar/btnProcessar) e
66: *    CmdSairClick -> BtnEncerrarClick (Caption "Encerrar", objeto legado
67: *    btnsair). CmdSelTudoClick/CmdApagaTudoClick FICAM com o prefixo Cmd: nao
68: *    sao acao da tela, sao os dois botoes que marcam/desmarcam a grade, e esse
69: *    eh o nome que o projeto ja usa para eles (FormSigPrSlp, Formsigrecmc,

*-- Linhas 100 a 118:
100: *    AjustarBotoesPorModo. Implementar o metodo aqui seria ou um no-op (stub)
101: *    ou a invencao de um estado desabilitado que o legado nao tem.
102: *  - BtnBuscarClick(): a tela nao tem busca. A grade carrega a tabela inteira
103: *    ("Select 0 as SelImp, * From SigMlItn", sem Where no Init legado) e a
104: *    ordenacao por clique no cabecalho ja esta em OrdenarGrade/GradeHeader*Click.
105: *==============================================================================
106: 
107: DEFINE CLASS FormSigPrMlu AS FormBase
108: 
109:     *-- Dimensoes (PILAR 1: identico ao legado SIGPRMLU.SCX)
110:     Width       = 794
111:     Height      = 533
112:     AutoCenter  = .T.
113:     TitleBar    = 0
114:     ShowWindow  = 1
115:     WindowType  = 1
116:     ControlBox  = .F.
117:     Closable    = .F.
118:     MaxButton   = .F.

*-- Linhas 215 a 256:
215:     * ConfigurarGridDados - Grade "grdselecoes" do legado: lista as malas
216:     * diretas cadastradas (SigMlItn), com checkbox de selecao na Column1
217:     * (SelImp) para escolher quais malas serao unificadas pelo cmd_4c_Processar.
218:     * ControlSource/RecordSource ficam para CarregarLista() - cursor_4c_Dados
219:     * ainda nao existe aqui (regra #41 do CLAUDE.md).
220:     * Original: grdselecoes Top=159 Left=49 Width=660 Height=324
221:     *==========================================================================
222:     PROTECTED PROCEDURE ConfigurarGridDados()
223:     *==========================================================================
224:         LOCAL loc_oGrid
225: 
226:         THIS.AddObject("grd_4c_Dados", "Grid")
227:         loc_oGrid = THIS.grd_4c_Dados
228: 
229:         WITH loc_oGrid
230:             .Top               = 159
231:             .Left              = 49
232:             .Width             = 660
233:             .Height            = 324
234:             .ColumnCount       = 6
235:             .FontName          = "Tahoma"
236:             .FontSize          = 8
237:             .HeaderHeight      = 16
238:             .RowHeight         = 16
239:             .AllowHeaderSizing = .F.
240:             .AllowRowSizing    = .F.
241:             .DeleteMark        = .F.
242:             .RecordMark        = .F.
243:             .ReadOnly          = .F.
244:             .ScrollBars        = 2
245:             .GridLineColor     = RGB(238, 238, 238)
246:             .Visible           = .T.
247:         ENDWITH
248: 
249:         *-- Column1: checkbox de marcacao (SelImp). Pattern #185/#186
250:         *-- (Erro146): CheckBox de Column exige AddObject + CurrentControl +
251:         *-- Sparse = .F., e NAO alterna sem os 4 handlers de evento abaixo.
252:         WITH loc_oGrid.Column1
253:             .Width     = 15
254:             .ReadOnly  = .F.
255:             .Sparse    = .F.
256:             .Movable   = .F.

*-- Linhas 566 a 586:
566:         TRY
567:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
568: 
569:             *-- DataSession=2 nasce no default do VFP (regra #9.4) - SET DELETED
570:             *-- nao herda o SET do config.prg
571:             SET DELETED ON
572: 
573:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrMluBO")
574: 
575:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
576:                 THIS.ConfigurarCabecalho()
577:                 THIS.ConfigurarGridDados()
578:                 THIS.ConfigurarBotoesAcao()
579:                 THIS.ConfigurarContainerNova()
580: 
581:                 THIS.TornarControlesVisiveis(THIS)
582: 
583:                 *-- Estado inicial pelo funil unico: a tela nasce em "LISTA"
584:                 *-- (grade disponivel para selecao, Processar liberado)
585:                 THIS.this_cModoAtual = "LISTA"
586:                 THIS.AjustarBotoesPorModo()

*-- Linhas 609 a 666:
609:     * as malas diretas cadastradas e liga a grade. O cursor precisa ser
610:     * READWRITE porque a Column1 (chk_4c_Check1) grava SelImp por linha
611:     * (regra do CLAUDE.md: Grid com coluna editavel exige cursor READWRITE -
612:     * SQLEXEC() cria cursor somente-leitura).
613:     *==========================================================================
614:     PROCEDURE CarregarLista()
615:     *==========================================================================
616:         LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
617: 
618:         loc_lSucesso = .F.
619: 
620:         IF USED("cursor_4c_DadosTmp")
621:             USE IN cursor_4c_DadosTmp
622:         ENDIF
623: 
624:         loc_cSQL = "SELECT 0 AS SelImp, codigos AS Codigos, descs AS Descs, " + ;
625:             "usuins AS UsuIns, datins AS DatIns, nregis AS NRegis FROM SigMlItn"
626: 
627:         SET NULL ON
628:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
629:         SET NULL OFF
630: 
631:         IF loc_nResultado >= 0
632:             IF USED("cursor_4c_Dados")
633:                 USE IN cursor_4c_Dados
634:             ENDIF
635: 
636:             SELECT * FROM cursor_4c_DadosTmp INTO CURSOR cursor_4c_Dados READWRITE
637:             USE IN cursor_4c_DadosTmp
638: 
639:             SELECT cursor_4c_Dados
640:             INDEX ON Codigos TAG Codigos
641:             INDEX ON Descs   TAG Descs
642:             INDEX ON UsuIns  TAG UsuIns
643:             INDEX ON DatIns  TAG DatIns
644: 
645:             THIS.grd_4c_Dados.RecordSource = ""
646:             THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Dados.SelImp"
647:             THIS.grd_4c_Dados.Column2.ControlSource = "cursor_4c_Dados.Codigos"
648:             THIS.grd_4c_Dados.Column3.ControlSource = "cursor_4c_Dados.Descs"
649:             THIS.grd_4c_Dados.Column4.ControlSource = "cursor_4c_Dados.UsuIns"
650:             THIS.grd_4c_Dados.Column5.ControlSource = "cursor_4c_Dados.DatIns"
651:             THIS.grd_4c_Dados.Column6.ControlSource = "cursor_4c_Dados.NRegis"
652:             THIS.grd_4c_Dados.RecordSource = "cursor_4c_Dados"
653: 
654:             *-- RecordSource reseta Width/Header/CurrentControl - reconfigurar
655:             *-- IMEDIATAMENTE depois (CLAUDE.md "Problema 48")
656:             THIS.grd_4c_Dados.Column1.CurrentControl = "chk_4c_Check1"
657:             THIS.grd_4c_Dados.Column1.Sparse         = .F.
658:             THIS.grd_4c_Dados.Column1.ReadOnly        = .F.
659:             THIS.grd_4c_Dados.Column1.Width           = 15
660:             THIS.grd_4c_Dados.Column1.Header1.Caption = ""
661:             THIS.grd_4c_Dados.Column2.Width           = 80
662:             THIS.grd_4c_Dados.Column2.Header1.Caption = "C" + CHR(243) + "digo"
663:             THIS.grd_4c_Dados.Column3.Width           = 260
664:             THIS.grd_4c_Dados.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
665:             THIS.grd_4c_Dados.Column4.Width           = 120
666:             THIS.grd_4c_Dados.Column4.Header1.Caption = "Usu" + CHR(225) + "rio"

*-- Linhas 704 a 722:
704:         ENDCASE
705: 
706:         IF USED("cursor_4c_Dados")
707:             SELECT cursor_4c_Dados
708:             SET ORDER TO TAG (loc_cTag)
709:             GO TOP
710:         ENDIF
711: 
712:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
713:             FOR loc_nI = 1 TO THIS.grd_4c_Dados.ColumnCount
714:                 loc_cCaminho = "THIS.grd_4c_Dados.Column" + ALLTRIM(STR(loc_nI, 2)) + ".Header1.BackColor"
715:                 STORE IIF(THIS.this_nGridOrder = loc_nI, RGB(220, 255, 220), THIS.BackColor) TO (loc_cCaminho)
716:             ENDFOR
717:             THIS.grd_4c_Dados.Refresh()
718:         ENDIF
719:     ENDPROC
720: 
721:     *==========================================================================
722:     * GradeHeader*Click - Disparados pelo clique nos cabecalhos das colunas

*-- Linhas 764 a 782:
764:     PROCEDURE ChkSelecaoToggle()
765:     *==========================================================================
766:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
767:             SELECT cursor_4c_Dados
768:             REPLACE SelImp WITH IIF(NVL(SelImp, 0) = 1, 0, 1)
769:             THIS.grd_4c_Dados.Refresh()
770:         ENDIF
771:     ENDPROC
772: 
773:     PROCEDURE ChkSelecaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
774:     *==========================================================================
775:         IF INLIST(par_nKeyCode, 13, 32)
776:             THIS.ChkSelecaoToggle()
777:             NODEFAULT
778:         ENDIF
779:     ENDPROC
780: 
781:     *-- MouseDown apenas SUPRIME o toggle nativo (legado: "NoDefault" e nada
782:     *-- mais). Quem alterna eh o MouseUp - o legado chama "This.KeyPress(13,0)"

*-- Linhas 811 a 863:
811:     * MarcarTodasAs - Funil UNICO dos dois botoes do cmdBtnGrade legado. No
812:     * SCX os dois sao um CommandGroup com ButtonCount = 2 e UM Click so:
813:     *
814:     *     Update crSigMlItn Set SelImp = This.Value
815:     *     ThisForm.grdSelecoes.Refresh
816:     *
817:     * O unico dado que muda entre btnMarcar e btnDesmarcar e o "This.Value"
818:     * do grupo, isto e o INDICE do botao clicado - 1 no primeiro e 2 no
819:     * segundo. Por isso os dois handlers abaixo apenas chamam este metodo com
820:     * o indice correspondente, em vez de duplicar a logica.
821:     *
822:     * O valor 2 do botao Desmarcar e transcricao LITERAL (regra #17): o
823:     * legado nao grava 0 ao desmarcar, grava o indice do botao, e != 1 ja
824:     * basta para a linha sair do filtro "SelImp = 1" usado em
825:     * ValidarProcessamento/ProcessarUnificacao.
826:     *
827:     * UPDATE-SQL e nao REPLACE ALL: o legado usa "Update ... Set" porque
828:     * REPLACE ALL percorre o cursor inteiro e deixa o ponteiro em EOF - a
829:     * grade saltaria para o fim e perderia a linha corrente a cada clique nos
830:     * botoes, divergencia visivel que o legado nao tem. O RECNO() e salvo e
831:     * restaurado porque a grade continua ancorada no ponteiro do cursor
832:     * (regra #21a), e fechamos com Refresh como o legado.
833:     *
834:     * "m.par_nValor" com prefixo m. e obrigatorio: em comando SQL do VFP um
835:     * identificador solto e resolvido primeiro como COLUNA do cursor.
836:     *==========================================================================
837:     PROTECTED PROCEDURE MarcarTodasAs(par_nValor)
838:     *==========================================================================
839:         LOCAL loc_nRec, loc_oErro
840: 
841:         TRY
842:             IF USED("cursor_4c_Dados")
843:                 SELECT cursor_4c_Dados
844:                 loc_nRec = RECNO()
845: 
846:                 UPDATE cursor_4c_Dados SET SelImp = m.par_nValor
847: 
848:                 SELECT cursor_4c_Dados
849:                 IF BETWEEN(loc_nRec, 1, RECCOUNT("cursor_4c_Dados"))
850:                     GO loc_nRec
851:                 ELSE
852:                     GO TOP
853:                 ENDIF
854: 
855:                 THIS.grd_4c_Dados.Refresh()
856:             ENDIF
857:         CATCH TO loc_oErro
858:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
859:                 "Procedure: " + loc_oErro.Procedure, "Erro em MarcarTodasAs")
860:         ENDTRY
861:     ENDPROC
862: 
863:     *==========================================================================

*-- Linhas 894 a 917:
894:     *   2) Reccount('csTmp') = 1   -> "Apenas Uma Mala Direta Com Registros..." -> grade
895:     *   3) IsEmpty(getNova.Value)  -> "Nome da Unificacao Invalido!!!..."        -> campo
896:     *
897:     * O csTmp do legado ("Select Codigos From crSigMlItn Where (SelImp = 1)
898:     * And (NRegis > 0) Into Cursor csTmp") so existe para ser contado: aqui o
899:     * equivalente eh o COUNT FOR sobre cursor_4c_Dados, sem criar cursor.
900:     *
901:     * O TEXTBOX eh a FONTE UNICA do nome - o legado le
902:     * ThisForm.cntNova.getNova.Value direto, inclusive no Insert e na mensagem
903:     * final de conclusao. O espelho para a property do BO eh feito aqui, DEPOIS
904:     * de validar, para que nenhum caminho grave o nome ANTIGO quando o usuario
905:     * limpa o campo entre duas unificacoes.
906:     *
907:     * PUBLIC de proposito: chamado de FORA da classe pelo handler do botao
908:     * (BINDEVENT descarta retorno de delegate, por isso o guard eh chamado em
909:     * codigo) e pelos harnesses de teste - regras #3 e #51 do CLAUDE.md.
910:     *
911:     * Retorna .T. quando os tres guards passam.
912:     *==========================================================================
913:     PROCEDURE ValidarProcessamento()
914:     *==========================================================================
915:         LOCAL loc_lValido, loc_nSelecionadas, loc_oErro
916: 
917:         loc_lValido       = .T.

*-- Linhas 925 a 943:
925:         *-- loc_lValido e ha um RETURN unico DEPOIS do ENDTRY.
926:         TRY
927:             IF USED("cursor_4c_Dados")
928:                 SELECT cursor_4c_Dados
929:                 GO TOP
930:                 COUNT FOR NVL(SelImp, 0) = 1 AND NVL(NRegis, 0) > 0 TO loc_nSelecionadas
931:             ENDIF
932: 
933:             DO CASE
934:                 CASE loc_nSelecionadas < 1
935:                     MsgAviso("Nenhuma Mala Direta Com Registros Foi Selecionada Para Unifica" + ;
936:                         CHR(231) + CHR(227) + "o!!!", "Aten" + CHR(231) + CHR(227) + "o")
937:                     THIS.grd_4c_Dados.SetFocus()
938:                     loc_lValido = .F.
939: 
940:                 CASE loc_nSelecionadas = 1
941:                     MsgAviso("Apenas Uma Mala Direta Com Registros Foi Selecionada Para Ser Unificada!!!" + CHR(13) + ;
942:                         "N" + CHR(227) + "o " + CHR(233) + " Poss" + CHR(237) + ;
943:                         "vel Unificar Apenas Uma Mala Direta, Selecione Ao Menos Duas!!!", ;

*-- Linhas 989 a 1007:
989:         TRY
990:             THIS.grd_4c_Dados.Refresh()
991:             IF USED("cursor_4c_Dados")
992:                 SELECT cursor_4c_Dados
993:                 GO TOP
994:             ENDIF
995:             THIS.grd_4c_Dados.Refresh()
996: 
997:             THIS.this_cModoAtual = "PROCESSANDO"
998:             THIS.AjustarBotoesPorModo()
999: 
1000:             IF THIS.ValidarProcessamento()
1001:                 IF MsgConfirma("Confirma a Unifica" + CHR(231) + CHR(227) + "o das Malas Diretas?", ;
1002:                     "Confirma" + CHR(231) + CHR(227) + "o")
1003:                     THIS.ProcessarUnificacao()
1004:                 ENDIF
1005:             ENDIF
1006:         CATCH TO loc_oErro
1007:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

*-- Linhas 1070 a 1220:
1070:             ENDIF
1071: 
1072:             SET NULL ON
1073:             CREATE CURSOR cursor_4c_Unificada (ChaveUnica C(200), Cidchaves C(20), ;
1074:                 IClis C(10) NULL, Codigos C(10) NULL, Bairs C(40) NULL, Ceps C(9) NULL, ;
1075:                 Compls C(25) NULL, Estas C(2) NULL, Faxs C(20) NULL, Grupos C(10) NULL, ;
1076:                 Mes C(2) NULL, Nums C(10) NULL, Rclis C(50) NULL, Tel1S C(20) NULL, ;
1077:                 Tel2S C(20) NULL, Cidas C(30) NULL, Endes C(60) NULL, Nascs T NULL, ;
1078:                 Profiss C(20) NULL, Sexos C(1) NULL, Ultcomps T NULL, Aptos N(6, 0) NULL, ;
1079:                 Opdest N(1, 0) NULL, Desti C(50) NULL, Opini N(1, 0) NULL, Dtncons T NULL, ;
1080:                 Conjuges C(60) NULL, Dtcasas T NULL, Situas C(3) NULL, Dataincs T NULL, ;
1081:                 Opani N(1, 0) NULL, Quebras C(40) NULL, Cpfs C(20) NULL)
1082:             SET NULL OFF
1083:             INDEX ON ChaveUnica TAG ChaveUnica
1084: 
1085:             *-- Malas marcadas com registros (equivalente a "Select Codigos
1086:             *-- From crSigMlItn Where SelImp = 1 And NRegis > 0")
1087:             IF USED("cursor_4c_MalasSel")
1088:                 USE IN cursor_4c_MalasSel
1089:             ENDIF
1090:             SELECT Codigos FROM cursor_4c_Dados WHERE SelImp = 1 AND NRegis > 0 ;
1091:                 INTO CURSOR cursor_4c_MalasSel
1092: 
1093:             SELECT cursor_4c_MalasSel
1094:             SCAN
1095:                 IF loc_lErroInsercao
1096:                     EXIT
1097:                 ENDIF
1098: 
1099:                 loc_cCodMala = ALLTRIM(cursor_4c_MalasSel.Codigos)
1100: 
1101:                 loc_cSQL = "SELECT iclis, codigos, bairs, ceps, compls, estas, faxs, " + ;
1102:                     "grupos, mes, nums, rclis, tel1s, tel2s, cidas, endes, nascs, " + ;
1103:                     "profiss, sexos, ultcomps, aptos, opdest, desti, opini, dtncons, " + ;
1104:                     "conjuges, dtcasas, situas, dataincs, opani, quebras, cpfs " + ;
1105:                     "FROM SigMlCab WHERE codigos = " + EscaparSQL(PADR(loc_cCodMala, 10))
1106: 
1107:                 IF USED("cursor_4c_MlCabTmp")
1108:                     USE IN cursor_4c_MlCabTmp
1109:                 ENDIF
1110: 
1111:                 SET NULL ON
1112:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MlCabTmp")
1113:                 SET NULL OFF
1114: 
1115:                 IF loc_nResultado >= 0
1116:                     loc_nTotalOrigem = loc_nTotalOrigem + RECCOUNT("cursor_4c_MlCabTmp")
1117: 
1118:                     SELECT cursor_4c_MlCabTmp
1119:                     SCAN
1120:                         SCATTER MEMVAR MEMO
1121:                         loc_cChaveUnica = PADR(UPPER(STRTRAN(NVL(m.desti, "") + NVL(m.ceps, "") + ;
1122:                             NVL(m.endes, "") + NVL(m.nums, "") + NVL(m.compls, ""), " ", "")), 200)
1123: 
1124:                         IF !SEEK(loc_cChaveUnica, "cursor_4c_Unificada", "ChaveUnica")
1125:                             m.ChaveUnica = loc_cChaveUnica
1126:                             m.Cidchaves  = LEFT(fUniqueIds(), 20)
1127:                             m.Codigos    = PADR(loc_cCodigoNovo, 10)
1128:                             INSERT INTO cursor_4c_Unificada FROM MEMVAR
1129:                         ENDIF
1130:                     ENDSCAN
1131: 
1132:                     USE IN cursor_4c_MlCabTmp
1133:                 ENDIF
1134:             ENDSCAN
1135: 
1136:             USE IN cursor_4c_MalasSel
1137: 
1138:             loc_nTotalUnificado = RECCOUNT("cursor_4c_Unificada")
1139: 
1140:             *-- Grava cada registro deduplicado em SigMlCab (equivalente ao
1141:             *-- .Update('crSigMlCab') do legado - aqui linha a linha via
1142:             *-- SQLEXEC, pois a arquitetura nova nao usa cursor remoto
1143:             *-- editavel). desdtcom/teldtcom sao NOT NULL sem DEFAULT (regra
1144:             *-- #22) e o legado tambem os deixa em branco (nunca aparecem no
1145:             *-- lcCampo copiado).
1146:             SELECT cursor_4c_Unificada
1147:             SCAN
1148:                 IF loc_lErroInsercao
1149:                     EXIT
1150:                 ENDIF
1151: 
1152:                 loc_cSQL = "INSERT INTO SigMlCab (" + ;
1153:                     "cidchaves, iclis, codigos, bairs, ceps, compls, estas, faxs, " + ;
1154:                     "grupos, mes, nums, rclis, tel1s, tel2s, cidas, endes, nascs, " + ;
1155:                     "profiss, sexos, ultcomps, aptos, opdest, desti, opini, dtncons, " + ;
1156:                     "conjuges, dtcasas, situas, dataincs, opani, quebras, cpfs, " + ;
1157:                     "desdtcom, teldtcom) VALUES (" + ;
1158:                     EscaparSQL(LEFT(ALLTRIM(cursor_4c_Unificada.Cidchaves), 20)) + ", " + ;
1159:                     EscaparSQL(LEFT(NVL(cursor_4c_Unificada.IClis, ""), 10)) + ", " + ;
1160:                     EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Codigos, ""), 10)) + ", " + ;
1161:                     EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Bairs, ""), 40)) + ", " + ;
1162:                     EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Ceps, ""), 9)) + ", " + ;
1163:                     EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Compls, ""), 25)) + ", " + ;
1164:                     EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Estas, ""), 2)) + ", " + ;
1165:                     EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Faxs, ""), 20)) + ", " + ;
1166:                     EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Grupos, ""), 10)) + ", " + ;
1167:                     EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Mes, ""), 2)) + ", " + ;
1168:                     EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Nums, ""), 10)) + ", " + ;
1169:                     EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Rclis, ""), 50)) + ", " + ;
1170:                     EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Tel1S, ""), 20)) + ", " + ;
1171:                     EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Tel2S, ""), 20)) + ", " + ;
1172:                     EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Cidas, ""), 30)) + ", " + ;
1173:                     EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Endes, ""), 60)) + ", " + ;
1174:                     FormatarDataSQL(cursor_4c_Unificada.Nascs) + ", " + ;
1175:                     EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Profiss, ""), 20)) + ", " + ;
1176:                     EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Sexos, ""), 1)) + ", " + ;
1177:                     FormatarDataSQL(cursor_4c_Unificada.Ultcomps) + ", " + ;
1178:                     FormatarNumeroSQL(NVL(cursor_4c_Unificada.Aptos, 0), 0) + ", " + ;
1179:                     FormatarNumeroSQL(NVL(cursor_4c_Unificada.Opdest, 0), 0) + ", " + ;
1180:                     EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Desti, ""), 50)) + ", " + ;
1181:                     FormatarNumeroSQL(NVL(cursor_4c_Unificada.Opini, 0), 0) + ", " + ;
1182:                     FormatarDataSQL(cursor_4c_Unificada.Dtncons) + ", " + ;
1183:                     EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Conjuges, ""), 60)) + ", " + ;
1184:                     FormatarDataSQL(cursor_4c_Unificada.Dtcasas) + ", " + ;
1185:                     EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Situas, ""), 3)) + ", " + ;
1186:                     FormatarDataSQL(cursor_4c_Unificada.Dataincs) + ", " + ;
1187:                     FormatarNumeroSQL(NVL(cursor_4c_Unificada.Opani, 0), 0) + ", " + ;
1188:                     EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Quebras, ""), 40)) + ", " + ;
1189:                     EscaparSQL(LEFT(NVL(cursor_4c_Unificada.Cpfs, ""), 20)) + ", " + ;
1190:                     EscaparSQL("") + ", " + EscaparSQL("") + ")"
1191: 
1192:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
1193:                 IF loc_nResultado < 0
1194:                     loc_lErroInsercao = .T.
1195:                 ENDIF
1196:             ENDSCAN
1197: 
1198:             USE IN cursor_4c_Unificada
1199: 
1200:             IF loc_lErroInsercao
1201:                 IF loc_lSnapshotOk
1202:                     MsgErro("Erro ao gravar os registros unificados:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1203:                 ENDIF
1204:             ELSE
1205:                 *-- Cabecalho da mala nova (equivalente ao "Insert Into
1206:                 *-- crSigMlItn" do legado) - reusa o BO ja existente
1207:                 THIS.this_oBusinessObject.NovoRegistro()
1208:                 THIS.this_oBusinessObject.this_cCodigos            = loc_cCodigoNovo
1209:                 THIS.this_oBusinessObject.this_cDescs              = loc_cNomeUnificacao
1210:                 THIS.this_oBusinessObject.this_cUsuIns             = gc_4c_UsuarioLogado
1211:                 THIS.this_oBusinessObject.this_dDatIns             = DATETIME()
1212:                 THIS.this_oBusinessObject.this_nNRegis             = loc_nTotalUnificado
1213:                 THIS.this_oBusinessObject.this_cUnificas           = loc_cUnificas
1214:                 THIS.this_oBusinessObject.this_cNomeUnificacao      = PADR(loc_cNomeUnificacao, 20)
1215:                 THIS.this_oBusinessObject.this_cCodigoGerado        = loc_cCodigoNovo
1216:                 THIS.this_oBusinessObject.this_nTotalRegistrosOrigem = loc_nTotalOrigem
1217:                 THIS.this_oBusinessObject.this_cCodigosSelecionados  = loc_cUnificas
1218:                 THIS.this_oBusinessObject.this_nTotalMalasSelecionadas = loc_nMalasSelecionadas
1219: 
1220:                 IF THIS.this_oBusinessObject.Salvar()

*-- Linhas 1267 a 1285:
1267:     * Nao eh convencao importada de form CRUD: o bloco EXISTE no legado, so
1268:     * nao tem esse nome. O cmdProcessar.Click le a tela em dois pontos -
1269:     * "ThisForm.cntNova.getNova.Value" (nome da unificacao) e o
1270:     * "Select Codigos From crSigMlItn Where (SelImp = 1) And (NRegis > 0)"
1271:     * (malas marcadas) - e o Processamento legado reusa os dois. Aqui os dois
1272:     * viram UMA leitura, gravada nas properties do BO, e nenhum outro metodo
1273:     * volta a tocar no TextBox nem a recontar a grade.
1274:     *
1275:     * PROTECTED obrigatoriamente: FormBase declara FormParaBO como PROTECTED e
1276:     * VFP9 nao permite ALARGAR o escopo de metodo herdado.
1277:     *
1278:     * O RECNO eh salvo e restaurado porque a grade continua ancorada no
1279:     * ponteiro do cursor (regra #21a) - o SCAN abaixo deixaria o ponteiro em
1280:     * EOF e a grade saltaria para o fim a cada clique em Processar.
1281:     *
1282:     * Retorna .T. quando a transferencia concluiu.
1283:     *==========================================================================
1284:     PROTECTED PROCEDURE FormParaBO()
1285:     *==========================================================================

*-- Linhas 1294 a 1330:
1294:         TRY
1295:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1296:                 IF USED("cursor_4c_Dados")
1297:                     SELECT cursor_4c_Dados
1298:                     loc_nRec = RECNO()
1299: 
1300:                     SCAN FOR NVL(SelImp, 0) = 1 AND NVL(NRegis, 0) > 0
1301:                         loc_cCodigos = loc_cCodigos + ALLTRIM(cursor_4c_Dados.Codigos) + "; "
1302:                         loc_nMalas   = loc_nMalas + 1
1303:                     ENDSCAN
1304: 
1305:                     SELECT cursor_4c_Dados
1306:                     IF BETWEEN(loc_nRec, 1, RECCOUNT("cursor_4c_Dados"))
1307:                         GO loc_nRec
1308:                     ELSE
1309:                         GO TOP
1310:                     ENDIF
1311:                 ENDIF
1312: 
1313:                 *-- MaxLength = 20 no SCX e SigMlItn.descs eh char(30): PADR em
1314:                 *-- 20 preserva a largura que o campo aceita, igual ao
1315:                 *-- Alltrim(getNova.Value) do Insert legado.
1316:                 THIS.this_oBusinessObject.this_cNomeUnificacao = ;
1317:                     PADR(ALLTRIM(THIS.cnt_4c_Nova.txt_4c_Nova.Value), 20)
1318: 
1319:                 THIS.this_oBusinessObject.this_cCodigosSelecionados    = loc_cCodigos
1320:                 THIS.this_oBusinessObject.this_nTotalMalasSelecionadas = loc_nMalas
1321: 
1322:                 loc_lSucesso = .T.
1323:             ENDIF
1324:         CATCH TO loc_oErro
1325:             loc_lSucesso = .F.
1326:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1327:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormParaBO")
1328:         ENDTRY
1329: 
1330:         RETURN loc_lSucesso

*-- Linhas 1361 a 1380:
1361:     *
1362:     * A GRADE nao eh tocada aqui de proposito: o legado desmarca as malas
1363:     * refazendo a consulta ("ThisForm.poDataMgr.Requery('crSigMlItn')" sobre
1364:     * "Select 0 as SelImp, * From SigMlItn"), e no migrado quem reproduz isso
1365:     * eh CarregarLista, cujo SELECT tambem traz "0 AS SelImp". Desmarcar aqui
1366:     * tambem duplicaria a regra em dois lugares.
1367:     *
1368:     * PROTECTED obrigatoriamente - FormBase declara LimparCampos como PROTECTED.
1369:     *==========================================================================
1370:     PROTECTED PROCEDURE LimparCampos()
1371:     *==========================================================================
1372:         LOCAL loc_oErro
1373: 
1374:         TRY
1375:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1376:                 THIS.this_oBusinessObject.LimparDados()
1377:             ENDIF
1378: 
1379:             THIS.BOParaForm()
1380:         CATCH TO loc_oErro


### BO (C:\4c\projeto\app\classes\SigPrMluBO.prg):
*============================================================================
* SigPrMluBO.prg - Business Object para Unificacao de Mala Direta (SIGPRMLU)
*
* Form OPERACIONAL (SIGPRMLU / FormSigPrMlu): lista as malas diretas
* cadastradas (SigMlItn, grid com checkbox de selecao), permite ao usuario
* marcar duas ou mais e "Processar" a unificacao delas numa mala NOVA:
*   - gera um codigo novo (equivalente a Substr(Sys(2015),3,10) do legado)
*   - duplica, deduplicando por chave logica (Desti+Ceps+Endes+Nums+Compls),
*     os registros de SigMlCab (Where Codigos = <malaSelecionada>) na mala
*     nova
*   - insere o cabecalho da mala nova em SigMlItn (Codigos/Descs/Ativos/
*     UsuIns/DatIns/NRegis/Espelhos/Unificas)
*
* this_cTabela/this_cCampoChave apontam para SigMlItn (cabecalho da mala,
* entidade listada na grade principal do form - equivalente ao
* AddCursor('SigMlItn', 'Codigos', 'crSigMlItn', ...) do Init legado).
* SigMlCab (registros/clientes dentro de cada mala, PK cidchaves) e
* manipulada em bloco durante o Processamento (Fase 2+), sem mapeamento
* propriedade-a-propriedade, pois o legado faz Select * / Scatter Memvar /
* Gather Memvar (copia integral do registro, nao campo a campo).
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigPrMluBO AS BusinessBase

    *==========================================================================
    * Propriedades de registro - espelham as colunas de SigMlItn (docs/
    * schema.sql) efetivamente usadas pelo SIGPRMLU.scx (cabecalho da mala
    * direta exibido na grade e gravado ao final da unificacao). As demais
    * colunas de SigMlItn (filtros de geracao da mala: anivfs/cepfs/faixafs/
    * opsexs/etc.) pertencem ao cadastro de Mala Direta (outro form) e NAO
    * sao tocadas por SIGPRMLU - nao sao declaradas aqui.
    *==========================================================================
    this_cCodigos    = SPACE(10)  && SigMlItn.codigos  - char(10) NOT NULL (PK) - grdselecoes.Column2
    this_cDescs      = SPACE(30)  && SigMlItn.descs    - char(30) NOT NULL - grdselecoes.Column3 / nome da unificacao
    this_lAtivos     = .F.        && SigMlItn.ativos   - bit NOT NULL - sempre .T. na mala resultante da unificacao
    this_cUsuIns     = SPACE(10)  && SigMlItn.usuins   - char(10) NOT NULL - grdselecoes.Column4 (Usuar do legado)
    this_dDatIns     = {}         && SigMlItn.datins   - datetime NULL - grdselecoes.Column5 (DateTime() na gravacao)
    this_dDatAlts    = {}         && SigMlItn.datalts  - datetime NULL - nao gravado por este form (.NULL. no Insert legado)
    this_dUlts       = {}         && SigMlItn.ults     - datetime NULL - nao gravado por este form (.NULL. no Insert legado)
    this_dDtEnts     = {}         && SigMlItn.dtents   - datetime NULL - nao gravado por este form (.NULL. no Insert legado)
    this_nNRegis     = 0          && SigMlItn.nregis   - numeric(8,0) NOT NULL - grdselecoes.Column6 (Reccount da mala unificada)
    this_cEspelhos   = SPACE(8)   && SigMlItn.espelhos - char(8) NOT NULL - origem fixa 'SigPrMlu' (Insert legado)
    this_cUnificas   = ""         && SigMlItn.unificas - text NULL - lista "codigo1; codigo2; " das malas de origem

    *==========================================================================
    * Estado de processamento - nao sao colunas persistidas isoladamente;
    * controlam a unificacao (Processamento() legado) e espelham o estado da
    * tela (txt_4c_Nova/getNova e os resultados intermediarios do calculo)
    *==========================================================================
    this_cNomeUnificacao        = SPACE(20)  && cntNova.getNova.Value - MaxLength=20 no SCX legado
    this_cCodigoGerado          = SPACE(10)  && lcNew  - Substr(Sys(2015),3,10), codigo da mala resultante
    this_nTotalRegistrosOrigem  = 0          && lnTot  - soma de Reccount('crTmp') de cada mala selecionada
    this_cCodigosSelecionados   = ""         && lcUni  - "codigo1; codigo2; " das malas marcadas (SelImp = 1)
    this_nTotalMalasSelecionadas = 0         && Reccount('csMalasSelecionadas') - quantidade de malas marcadas

    *==========================================================================
    * Init - Inicializa o Business Object configurando a tabela/chave
    * primaria de referencia (SigMlItn/codigos - equivalente ao AddCursor(
    * 'SigMlItn', 'Codigos', 'crSigMlItn', ...) do Init legado, que define
    * qual entidade a grade principal do form lista e processa)
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMlItn"
            THIS.this_cCampoChave = "codigos"

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia as colunas do cursor (crSigMlItn, populado via
    * SQLEXEC/AddCursor equivalente) para as propriedades this_* deste BO.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cCodigos  = TratarNulo(codigos, "")
            THIS.this_cDescs    = TratarNulo(descs, "")
            IF VARTYPE(ativos) = "L"
                THIS.this_lAtivos = TratarNulo(ativos, .F.)
            ELSE
                THIS.this_lAtivos = (TratarNulo(ativos, 0) = 1)
            ENDIF
            THIS.this_cUsuIns   = TratarNulo(usuins, "")
            THIS.this_dDatIns   = TratarNulo(datins, {})
            THIS.this_dDatAlts  = TratarNulo(datalts, {})
            THIS.this_dUlts     = TratarNulo(ults, {})
            THIS.this_dDtEnts   = TratarNulo(dtents, {})
            THIS.this_nNRegis   = TratarNulo(nregis, 0)
            THIS.this_cEspelhos = TratarNulo(espelhos, "")
            THIS.this_cUnificas = TratarNulo(unificas, "")

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - INSERT do cabecalho da mala direta unificada em SigMlItn
    * (equivalente ao "Insert Into crSigMlItn (Codigos, Descs, Ativos, UsuIns,
    * DatIns, DatAlts, Ults, DtEnts, NRegis, Espelhos, Unificas) Values (...)"
    * do Processamento legado).
    *
    * SigMlItn tem dezenas de colunas NOT NULL sem DEFAULT que pertencem aos
    * FILTROS de geracao de mala direta (cadastro de Mala Direta - outro form)
    * e NUNCA sao tocadas pelo SIGPRMLU. O legado grava o registro INTEIRO
    * (AddCursor sem query = Select * + Gather Memvar/TableUpdate), entao essas
    * colunas vao em branco/zero junto das que a tela de fato edita. A lista
    * abaixo vem do docs/schema.sql (regra #22 do CLAUDE.md - a lista de
    * colunas NOT NULL vem do SCHEMA, nunca do dump do legado).
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro, loc_cIdChaves
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCodigos))
                THIS.this_cCodigoGerado = PADR(SUBSTR(SYS(2015), 3, 10), 10)
                THIS.this_cCodigos      = THIS.this_cCodigoGerado
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cUsuIns))
                THIS.this_cUsuIns = gc_4c_UsuarioLogado
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cEspelhos))
                THIS.this_cEspelhos = "SigPrMlu"
            ENDIF

            * Legado grava Ativos = .t. incondicionalmente na mala resultante
            THIS.this_lAtivos = .T.

            loc_cIdChaves = fUniqueIds()

            loc_cSQL = "INSERT INTO SigMlItn (" + ;
                "anivfs, anivis, ativos, cadas, cemps, cepfs, cepis, cidades, " + ;
                "ckanis, ckcads, ckceps, ckcids, ckemps, ckests, ckfnoms, cknomes, " + ;
                "ckprofs, ckrsocs, cksexs, ckults, codigos, datins, demps, descs, " + ;
                "destis, espelhos, ests, faixafs, faixais, nomes, nregis, opsexs, " + ;
                "optceps, optnrs, optults, profs, rsocs, usualts, usuins, ckclass, " + ;
                "cksituas, classifis, classifss, situas, ckregis, cksitua, opsitua, regifs, " + ;
                "regiis, situa, linhas, ckcivils, opanis, ckdtents, cklinhas, tabufs, " + ;
                "opcivis, bairs, ckbairs, estados, unificas, ckvends, vends, cidchaves, " + ;
                "ckidade, idadefs, idadeis, opidade, cparents, ckdtatus, opendes, cktlmk, " + ;
                "optlmk, ckncomp, ckultcom, ckpais, paises, ckmov, dopes, endigual, " + ;
                "valosf, valosi, ckconjuge, conjuge, ckpubls, cksegs, fpubls, codsegs" + ;
                ") VALUES (" + ;
                EscaparSQL("") + ", " + EscaparSQL("") + ", " + IIF(THIS.this_lAtivos, "1", "0") + ", " + ;
                    EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                    EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                "0, 0, 0, 0, 0, 0, 0, 0, " + ;
                "0, 0, 0, 0, " + ;
                    EscaparSQL(PADR(ALLTRIM(THIS.this_cCodigos), 10)) + ", " + ;
                    FormatarDataSQL(IIF(EMPTY(THIS.this_dDatIns), DATETIME(), THIS.this_dDatIns)) + ", " + ;
                    EscaparSQL("") + ", " + ;
                    EscaparSQL(PADR(ALLTRIM(THIS.this_cDescs), 30)) + ", " + ;
                "0, " + EscaparSQL(PADR(ALLTRIM(THIS.this_cEspelhos), 8)) + ", " + ;
                    EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                    FormatarNumeroSQL(THIS.this_nNRegis, 0) + ", 0, " + ;
                "0, 0, 0, " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                    EscaparSQL(PADR(ALLTRIM(gc_4c_UsuarioLogado), 10)) + ", " + ;
                    EscaparSQL(PADR(ALLTRIM(THIS.this_cUsuIns), 10)) + ", 0, " + ;
                "0, " + EscaparSQL("") + ", " + EscaparSQL("") + ", 0, 0, 0, 0, " + EscaparSQL("") + ", " + ;
                EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", 0, 0, 0, 0, " + EscaparSQL("") + ", " + ;
                "0, " + EscaparSQL("") + ", 0, " + EscaparSQL("") + ", " + ;
                    EscaparSQL(NVL(THIS.this_cUnificas, "")) + ", 0, " + EscaparSQL("") + ", " + ;
                    EscaparSQL(LEFT(loc_cIdChaves, 20)) + ", " + ;
                "0, 0, 0, 0, " + EscaparSQL("") + ", 0, 0, 0, " + ;
                "0, 0, 0, 0, " + EscaparSQL("") + ", 0, " + EscaparSQL("") + ", 0, " + ;
                FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", 0, " + EscaparSQL("") + ", 0, 0, " + ;
                    EscaparSQL("") + ", " + EscaparSQL("") + ;
                ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir mala direta unificada:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir mala direta unificada:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE do cabecalho da mala direta em SigMlItn (apenas as
    * colunas que este form mantem - as demais colunas NOT NULL de SigMlItn
    * pertencem ao cadastro de Mala Direta e nao sao alteradas aqui)
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCodigos))
                MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o definido para atualiza" + ;
                    CHR(231) + CHR(227) + "o", "SigPrMluBO.Atualizar")
            ELSE
                loc_cSQL = "UPDATE SigMlItn SET " + ;
                    "descs = "    + EscaparSQL(PADR(ALLTRIM(THIS.this_cDescs), 30)) + ", " + ;
                    "ativos = "   + IIF(THIS.this_lAtivos, "1", "0") + ", " + ;
                    "nregis = "   + FormatarNumeroSQL(THIS.this_nNRegis, 0) + ", " + ;
                    "unificas = " + EscaparSQL(NVL(THIS.this_cUnificas, "")) + ", " + ;
                    "usualts = "  + EscaparSQL(PADR(ALLTRIM(gc_4c_UsuarioLogado), 10)) + ", " + ;
                    "datalts = GETDATE() " + ;
                    "WHERE codigos = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cCodigos), 10))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao atualizar mala direta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar mala direta:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LimparDados - Zera as properties deste BO. Sobrescreve o stub da
    * BusinessBase (que limpa apenas this_cMensagemErro) porque este form NAO
    * eh modal-por-registro como o legado: ele fica aberto e o usuario pode
    * fazer uma unificacao depois da outra. Sem o reset, o estado da anterior
    * (nome, codigo gerado, totais e a lista de malas de origem) sobrevive na
    * instancia e qualquer caminho que deixe de reatribuir uma dessas
    * properties gravaria o valor da unificacao PASSADA - o mesmo risco de
    * ciclo de vida da regra #32 do CLAUDE.md.
    *
    * PUBLIC (sem modificador) obrigatoriamente: LimparDados eh PUBLIC na
    * BusinessBase, o Form a chama de fora em LimparCampos, e VFP9 nao permite
    * REDUZIR o escopo sem quebrar o chamador (regra #51).
    *==========================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        *-- Colunas de SigMlItn mantidas por este form
        THIS.this_cCodigos  = SPACE(10)
        THIS.this_cDescs    = SPACE(30)
        THIS.this_lAtivos   = .F.
        THIS.this_cUsuIns   = SPACE(10)
        THIS.this_dDatIns   = {}
        THIS.this_dDatAlts  = {}
        THIS.this_dUlts     = {}
        THIS.this_dDtEnts   = {}
        THIS.this_nNRegis   = 0
        THIS.this_cEspelhos = SPACE(8)
        THIS.this_cUnificas = ""

        *-- Estado de processamento (espelho da tela e resultados do calculo)
        THIS.this_cNomeUnificacao          = SPACE(20)
        THIS.this_cCodigoGerado            = SPACE(10)
        THIS.this_nTotalRegistrosOrigem    = 0
        THIS.this_cCodigosSelecionados     = ""
        THIS.this_nTotalMalasSelecionadas  = 0

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna o codigo (char(10), PK de SigMlItn) do
    * registro atual
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigos)
    ENDPROC

ENDDEFINE

