# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PESOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NENVS, EMPDNPS, CIDCHAVES, NOPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'FATORS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NENVS, EMPDNPS, CIDCHAVES, NOPS

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
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  ControlSource = ""
Select xMFas
Delete All For Nenvs = TmpPends.Numes
Select xOpi
Delete All For Nenvs = TmpPends.Numes
Select xPesa
Delete All For Nenvs = TmpPends.Numes
Select xNensi
Delete All For Nenvs = TmpPends.Numes
lcSql = [Select CidChaves From SigCdNec where EmpDNps = '] + _Nivel + [']
If (ThisForm.poDataMgr.SqlExecute(lcSql, 'LocalNens') < 1)
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Desmarca - Update - SigCdNec)')
Select LocalNens
	lcQuery = [Update SigCdNec Set ChkSubn = ?pNot Where CidChaves = '] + LocalNens.CidChaves + [']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Desmarca - Update - SigCdNec)')
Select TmpOperacao
	Insert Into TmpOperacao (Codigos) Values (0) 
If Seek(_NumNivel, 'TmpOperacao', 'Codigos')
	Select TmpPends
	Select TmpPends
Select TmpOperacao
Insert Into TmpOperacao (Codigos) Values (_NumNivel)
Select LocalMFas
	Select TempMFas
		lcSql = [Select CidChaves From SigCdNec Where EmpDnPs = '] + _Empr + _CheckBaixa + Str(_Nops, 10) + [']
		If (ThisForm.poDataMgr.SqlExecute(lcSql, 'LocalNens2') < 1)
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Marca - Update - SigCdNec)')
		Select LocalNens2
			lcQuery = [Update SigCdNec Set ChkSubn = ?pTru Where CidChaves = '] +LocalNens2.CidChaves + [']
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
				=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Marca - Update - SigCdNec)')
	Select LocalOpi
		Insert Into xOpi (Nops, Oper, Qtds, CPros, Indiv, Amarra, Nenvs, Emps, Dopes, Numes) ;
		Insert Into xPesa (Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, Dopes, Numes, Nops) ;
	Insert Into xMFas (Emps, Dopps, Numps, Datars, Datas, Usuars, Opers, Grupoos, Contaos, Grupods, ;
	Select LocalNensi
	lcQuery = [Select CMats, Qtds, Pesos ] + ;
			    [From SigCdNei ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalNensi') < 1)
	Select LocalNensi
		Insert Into xNensi (Emps, Dopps, Numps, Nops, NEnvs, CMats, CDescs, CUnis, ;
		Select xNensi
		If Not Seek(_Operacao + Space(10))
			Insert Into xNensi (Nops, Nenvs, Visivel, Rateio, CUnis) ;
	Select LocalCompo
		Insert Into xNensi (Emps, Dopps, Numps, Nops, NEnvs, CMats, CDescs, CUnis, CGrus,;
		If Not Seek(_Operacao + LocalCompo.Mats, 'xNensi', 'NEnvCMat')
			Insert Into xNensi (Nops, Nenvs, CMats, CDescs, CUnis, CGrus, Visivel, Rateio, FlagIncs, Cats) ;
	Select TmpNens
	Select TmpNens
Select TmpOperacao
Delete All For Empty(Codigos)
lcQuery = [Select Emps, Dopps, Numps, Datas, ChkSubn ] + ;
		    [From SigCdNec ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalNens') < 1)
Select LocalNens
	If LocalNens.ChkSubn And Not Seek(_NumNivel * 10000000000 + Numps, 'TmpOperacao', 'Codigos')
	Select LocalMFas
	_Flag = Seek(_NumNivel * 10000000000 + LocalNens.Numps, 'TmpOperacao', 'Codigos')
	Insert Into TmpPends (Flag, Emps, Dopes, Numes, Datas, Origem, Destino, CPros) ;
This.Grade.seleciona.ControlSource 	= 'TmpPends.Flag'
This.Grade.operacao.ControlSource 	= 'TmpPends.Dopes'
This.Grade.codigo.ControlSource 	= 'TmpPends.Numes'
This.Grade.data.ControlSource 		= 'TmpPends.Datas'
This.Grade.grupo.ControlSource 		= 'TmpPends.Origem'
This.Grade.conta.ControlSource 		= 'TmpPends.Destino'
This.Grade.column8.ControlSource 	= 'TmpPends.CPros'
Select TmpPends
Select TmpPends

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpMpd.prg) - TRECHOS RELEVANTES PARA PASS SQL (1360 linhas total):

*-- Linhas 132 a 150:
132: *             mGravaDados) nem botao de busca - os TRES commandbutton da
133: *             tela sao ok/SELTUDO/APAGA. A gravacao desta tela nao tem
134: *             botao por natureza: cada marcacao/desmarcacao ja persiste na
135: *             hora (SigOpMpdBO.Atualizar -> UPDATE SigCdNec.ChkSubn),
136: *             exatamente como no legado, e por isso tambem nao existe o
137: *             que "cancelar" - BtnCancelarClick cai na mesma saida do OK.
138: *
139: * Parametros de Init (equivalentes ao legado "With ThisForm,
140: * ThisForm.DataSessionId, ThisForm.poDataMgr"):
141: *   par_oFormPai - pForm/ParentForm: form chamador (SIGCDEPD/FormEpd).
142: *                  Guardado em this_oFormPai para o OK reabilita-lo
143: *                  (legado: ThisForm.ParentForm.Enabled = .t.) e para ler
144: *                  o modo atual em this_cModoAtual (equivalente a
145: *                  "Op_Escolha = ThisForm.ParentForm.pcEscolha" do Init
146: *                  legado, usado pelo Visible/When de SelTudo/Apaga na
147: *                  Fase 4: legado Inlist(Op_Escolha,'INSERIR','ALTERAR')
148: *                  equivale aqui a INLIST(this_cModoAtual,"INCLUIR",
149: *                  "ALTERAR") - FormEpd usa this_cModoAtual com os
150: *                  valores padrao do projeto, nao os termos Fortyus).

*-- Linhas 333 a 351:
333:     *--------------------------------------------------------------------------
334:     * ConfigurarGrade - grade de selecao das pendencias (legado: SIGOPMPD.
335:     * Grade, classe fwgrade, ColumnCount=8). So a ESTRUTURA (colunas,
336:     * fontes, CheckBox embutido) - RecordSource/ControlSource ficam em
337:     * CarregarGrade(), chamado DEPOIS do cursor existir (regra #41).
338:     *
339:     * ColumnOrder reproduz o dump: visualmente a ordem eh seleciona,
340:     * empresa, operacao, codigo, data, Column8 (Produto, ColumnOrder=6),
341:     * Grupo/Origem (Column6, ColumnOrder=7), Conta/Destino (Column7,
342:     * ColumnOrder=8) - o Produto aparece ANTES de Origem/Destino apesar
343:     * de ser fisicamente a Column8.
344:     *
345:     * Column4 "codigo" substitui a classe Ingrid1 (framework.vcx, seek
346:     * incremental por cordertag/cseektag) por TextBox comum: nenhum outro
347:     * metodo deste dialogo depende do seek incremental, so do foco
348:     * inicial (THIS.CarregarGrade() faz SetFocus nela, equivalente a
349:     * "ThisForm.Grade.Codigo.Ingrid1.SetFocus" do fim do Init legado).
350:     *--------------------------------------------------------------------------
351:     PROTECTED PROCEDURE ConfigurarGrade()

*-- Linhas 360 a 389:
360:             .FontName          = "Tahoma"
361:             .FontSize          = 8
362:             .AllowHeaderSizing = .F.
363:             .DeleteMark        = .F.
364:             .RecordMark        = .F.
365:             .ScrollBars        = 2
366:             *-- Grid.ReadOnly propaga para as colunas - por isso vem ANTES
367:             *-- delas (regra do projeto)
368:             .ReadOnly          = .F.
369:             .Visible           = .T.
370:         ENDWITH
371: 
372:         *-- Column1 "seleciona" - CheckBox embutido (regra #18: AddObject +
373:         *-- CurrentControl + Sparse obrigatorios). Legado: fwcheckbox1,
374:         *-- ControlSource = TmpPends.Flag, editavel SO em modo INCLUIR
375:         *-- (When do legado: Return (Op_Escolha = 'INSERIR'))
376:         WITH THIS.grd_4c_Grade.Column1
377:             .Width     = 15
378:             .FontName  = "Tahoma"
379:             .FontSize  = 9
380:             .Movable   = .F.
381:             .Resizable = .F.
382:             *-- valor de NASCIMENTO; a autoridade sobre esta propriedade eh
383:             *-- THIS.HabilitarCampos(), que a reafirma depois de cada bind
384:             *-- de RecordSource (que a reseta) - ver CarregarGrade()
385:             .ReadOnly  = (THIS.this_cModoAtual != "INCLUIR")
386:         ENDWITH
387:         THIS.grd_4c_Grade.Column1.AddObject("chk_4c_Selecionar", "CheckBox")
388:         WITH THIS.grd_4c_Grade.Column1.chk_4c_Selecionar
389:             .Caption   = ""

*-- Linhas 698 a 720:
698:     *--------------------------------------------------------------------------
699:     * CarregarGrade - funil UNICO de carga + vinculo da grade. Chama
700:     * SigOpMpdBO.CarregarPendencias() (recria TmpPends do zero - mesma
701:     * semantica do "Create Cursor TmpPends" do Init legado) e so DEPOIS
702:     * liga RecordSource/ControlSource (regra #41 - Column.ControlSource de
703:     * cursor que ainda nao existe derruba o Init).
704:     *
705:     * Ordem obrigatoria: RecordSource -> ControlSource -> Width ->
706:     * Header1.Caption -> CurrentControl/Sparse/ReadOnly do CheckBox
707:     * (RecordSource reseta largura, titulo e as props da Column1 - mesma
708:     * regra do CarregarDados de FormSigOpLrC / Problema 48 do FormCor).
709:     *
710:     * Bypass de SQL em modo teste/ValidarUIFidelity (TmpNens/TmpOperacao,
711:     * cursores do form pai, nao existem em instanciacao headless) - a
712:     * grade fica com a ESTRUTURA montada (ColumnCount=8) mas sem dado
713:     * nenhum, o que eh suficiente para validacao de UI.
714:     *--------------------------------------------------------------------------
715:     PROCEDURE CarregarGrade()
716:         LOCAL loc_lSucesso, loc_lBypassTeste, loc_oGrade, loc_cCursor, loc_oErro
717:         loc_lSucesso = .F.
718: 
719:         TRY
720:             loc_lBypassTeste = (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;

*-- Linhas 735 a 760:
735: 
736:             IF USED(loc_cCursor)
737:                 loc_oGrade.RecordSource          = loc_cCursor
738:                 loc_oGrade.Column1.ControlSource = loc_cCursor + ".Flag"
739:                 loc_oGrade.Column2.ControlSource = loc_cCursor + ".Emps"
740:                 loc_oGrade.Column3.ControlSource = loc_cCursor + ".Dopes"
741:                 loc_oGrade.Column4.ControlSource = loc_cCursor + ".Numes"
742:                 loc_oGrade.Column5.ControlSource = loc_cCursor + ".Datas"
743:                 loc_oGrade.Column6.ControlSource = loc_cCursor + ".Origem"
744:                 loc_oGrade.Column7.ControlSource = loc_cCursor + ".Destino"
745:                 loc_oGrade.Column8.ControlSource = loc_cCursor + ".CPros"
746: 
747:                 loc_oGrade.Column1.Width = 15
748:                 loc_oGrade.Column2.Width = 25
749:                 loc_oGrade.Column3.Width = 125
750:                 loc_oGrade.Column4.Width = 70
751:                 loc_oGrade.Column5.Width = 60
752:                 loc_oGrade.Column6.Width = 120
753:                 loc_oGrade.Column7.Width = 120
754:                 loc_oGrade.Column8.Width = 103
755: 
756:                 loc_oGrade.Column1.Header1.Caption = ""
757:                 loc_oGrade.Column2.Header1.Caption = "Emp"
758:                 loc_oGrade.Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
759:                 loc_oGrade.Column4.Header1.Caption = "C" + CHR(243) + "d"
760:                 loc_oGrade.Column5.Header1.Caption = "Data"

*-- Linhas 771 a 789:
771:                 *-- legado, que sem isto ficava editavel depois da carga
772:                 THIS.HabilitarCampos(.T.)
773: 
774:                 SELECT (loc_cCursor)
775:                 GO TOP
776:                 loc_oGrade.Refresh()
777: 
778:                 *-- Legado: ThisForm.Grade.Codigo.Ingrid1.SetFocus
779:                 IF loc_oGrade.ColumnCount >= 4
780:                     loc_oGrade.SetFocus()
781:                     loc_oGrade.ActiveColumn = 4
782:                 ENDIF
783: 
784:                 loc_lSucesso = .T.
785:             ENDIF
786:         CATCH TO loc_oErro
787:             MsgErro(loc_oErro.Message + CHR(13) + ;
788:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
789:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpMpd.CarregarGrade")

*-- Linhas 909 a 1036:
909:     *         This.Value = ThisForm.Marca()
910:     *     EndIf
911:     *
912:     * O ControlSource ja gravou o novo valor em TmpPends.Flag ANTES deste
913:     * handler disparar (mesma premissa do legado). Em .T. (marcando),
914:     * Marcar() pode recusar (pendencia duplicada/ja usada) - nesse caso
915:     * desfaz o Flag (equivalente a "This.Value = ThisForm.Marca()", que
916:     * reatribui .F. quando a marcacao falha). Em .F. (desmarcando), o
917:     * legado nao usa o retorno de Desmarca().
918:     *--------------------------------------------------------------------------
919:     PROCEDURE ChkSelecionarInteractiveChange()
920:         LOCAL loc_cAlias, loc_lNovoValor, loc_lResultado, loc_oErro
921: 
922:         TRY
923:             loc_cAlias = THIS.this_oBusinessObject.this_cCursorPends
924: 
925:             IF USED(loc_cAlias)
926:                 SELECT (loc_cAlias)
927:                 loc_lNovoValor = ConverterParaLogico(Flag)
928: 
929:                 *-- TELA -> BO: linha corrente da grade (unico "campo" deste
930:                 *-- dialogo) + contador Amarra do form pai
931:                 THIS.FormParaBO()
932: 
933:                 IF loc_lNovoValor
934:                     THIS.ResetarSugestoesBO()
935:                     loc_lResultado = THIS.this_oBusinessObject.Marcar(.F.)
936: 
937:                     IF loc_lResultado
938:                         THIS.AplicarSugestoesAoFormPai()
939:                     ELSE
940:                         SELECT (loc_cAlias)
941:                         REPLACE Flag WITH .F.
942:                     ENDIF
943:                 ELSE
944:                     THIS.this_oBusinessObject.Desmarcar()
945:                     *-- legado desmarca: recalcula ThisForm.parentform.
946:                     *-- EditaOrigem e so entao repinta a pagina do pai
947:                     THIS.AplicarPermissaoOrigemAoFormPai()
948:                 ENDIF
949: 
950:                 SELECT (loc_cAlias)
951:                 THIS.grd_4c_Grade.Refresh()
952:             ENDIF
953:         CATCH TO loc_oErro
954:             MsgErro(loc_oErro.Message + CHR(13) + ;
955:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
956:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpMpd.ChkSelecionarInteractiveChange")
957:         ENDTRY
958:     ENDPROC
959: 
960:     *--------------------------------------------------------------------------
961:     * CmdSelTudoClick - legado: SELTUDO.Click
962:     *     Select TmpPends
963:     *     Scan For Not Flag
964:     *         Replace Flag With ThisForm.Marca(.t.)
965:     *     EndScan
966:     *     ThisForm.Grade.Refresh
967:     *--------------------------------------------------------------------------
968:     PROCEDURE CmdSelTudoClick()
969:         LOCAL loc_cAlias, loc_lResultado, loc_oErro
970: 
971:         TRY
972:             loc_cAlias = THIS.this_oBusinessObject.this_cCursorPends
973: 
974:             IF USED(loc_cAlias)
975:                 SELECT (loc_cAlias)
976:                 SCAN FOR !Flag
977:                     THIS.FormParaBO()
978:                     THIS.ResetarSugestoesBO()
979:                     loc_lResultado = THIS.this_oBusinessObject.Marcar(.T.)
980: 
981:                     IF loc_lResultado
982:                         THIS.AplicarSugestoesAoFormPai()
983:                     ENDIF
984: 
985:                     SELECT (loc_cAlias)
986:                     REPLACE Flag WITH loc_lResultado
987:                 ENDSCAN
988: 
989:                 THIS.grd_4c_Grade.Refresh()
990:             ENDIF
991:         CATCH TO loc_oErro
992:             MsgErro(loc_oErro.Message + CHR(13) + ;
993:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
994:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpMpd.CmdSelTudoClick")
995:         ENDTRY
996:     ENDPROC
997: 
998:     *--------------------------------------------------------------------------
999:     * CmdApagaClick - legado: APAGA.Click
1000:     *     Select TmpPends
1001:     *     Scan For Flag
1002:     *         Replace Flag With .f.
1003:     *         =ThisForm.Desmarca()
1004:     *     EndScan
1005:     *     ThisForm.Grade.Refresh
1006:     *--------------------------------------------------------------------------
1007:     PROCEDURE CmdApagaClick()
1008:         LOCAL loc_cAlias, loc_oErro
1009: 
1010:         TRY
1011:             loc_cAlias = THIS.this_oBusinessObject.this_cCursorPends
1012: 
1013:             IF USED(loc_cAlias)
1014:                 SELECT (loc_cAlias)
1015:                 SCAN FOR Flag
1016:                     SELECT (loc_cAlias)
1017:                     REPLACE Flag WITH .F.
1018:                     THIS.FormParaBO()
1019:                     THIS.this_oBusinessObject.Desmarcar()
1020:                     THIS.AplicarPermissaoOrigemAoFormPai()
1021:                     SELECT (loc_cAlias)
1022:                 ENDSCAN
1023: 
1024:                 THIS.grd_4c_Grade.Refresh()
1025:             ENDIF
1026:         CATCH TO loc_oErro
1027:             MsgErro(loc_oErro.Message + CHR(13) + ;
1028:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1029:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpMpd.CmdApagaClick")
1030:         ENDTRY
1031:     ENDPROC
1032: 
1033:     *--------------------------------------------------------------------------
1034:     * CmdOkClick - legado: SIGOPMPD.ok.Click
1035:     *     ThisForm.ParentForm.Enabled = .t.
1036:     *     ThisForm.Release

*-- Linhas 1064 a 1082:
1064:     * BtnCancelarClick - nome canonico do projeto para "sair sem gravar".
1065:     * Nesta tela nao existe o que cancelar: nao ha botao de gravar porque
1066:     * cada marcacao/desmarcacao JA persistiu na hora (SigOpMpdBO.Atualizar
1067:     * -> UPDATE SigCdNec.ChkSubn, mais as linhas gravadas/apagadas nos
1068:     * cursores do form pai), exatamente como no legado - que tambem nao
1069:     * oferece caminho de descarte. Logo "cancelar" aqui eh fechar, e o
1070:     * handler delega ao mesmo funil de saida em vez de dar ao usuario a
1071:     * impressao falsa de que algo seria desfeito.
1072:     *--------------------------------------------------------------------------
1073:     PROCEDURE BtnCancelarClick()
1074:         THIS.FecharDialogo()
1075:     ENDPROC
1076: 
1077:     *--------------------------------------------------------------------------
1078:     * CarregarLista - nome canonico do projeto para o carregador da lista
1079:     * (eh por ele que o harness de teste automatizado entra:
1080:     * utils\TesteAutomatico.prg chama THIS.oForm.CarregarLista() de FORA da
1081:     * classe, por isso PUBLIC - metodo PROTECTED falharia em runtime).
1082:     * Delega ao funil unico desta tela, CarregarGrade(), que eh quem popula

*-- Linhas 1094 a 1112:
1094:     *
1095:     * O unico "campo" deste dialogo eh a LINHA CORRENTE da grade de
1096:     * selecao: as oito colunas (Flag/Emps/Dopes/Numes/Datas/Origem/Destino/
1097:     * CPros) estao ligadas por ControlSource direto ao cursor TmpPends, e eh
1098:     * dessa linha que Marcar()/Desmarcar() partem. CarregarDoCursor() copia
1099:     * a linha para as properties de linha corrente do BO
1100:     * (this_lFlag/this_cEmps/.../this_cCPros).
1101:     *
1102:     * Leva tambem o contador Amarra, que no legado vive no form PAI
1103:     * (ThisForm.ParentForm.Amarra, somado 1 a cada item de fase gravado em
1104:     * xOpi/xPesa dentro de marca) e aqui vive em SigOpMpdBO.this_nAmarra -
1105:     * ler o valor do pai ANTES de marcar eh o que mantem a numeracao
1106:     * continua entre o que o pai gravou e o que este dialogo grava. O pai
1107:     * atual (Formepd) ainda nao declara a property, por isso o PEMSTATUS:
1108:     * sem ela o BO segue com o proprio contador, que eh o comportamento
1109:     * documentado no cabecalho de SigOpMpdBO.prg.
1110:     *--------------------------------------------------------------------------
1111:     PROTECTED PROCEDURE FormParaBO()
1112:         LOCAL loc_oBO, loc_cAlias

*-- Linhas 1132 a 1150:
1132:     * (PROTECTED, como lah).
1133:     *
1134:     * Nao repete mapeamento de campo: as oito colunas da grade leem o
1135:     * cursor por ControlSource, entao o que sobra para espelhar eh o estado
1136:     * que o BO calculou e nao esta no cursor. Fica aqui so o que eh seguro
1137:     * nos DOIS caminhos (marcar e desmarcar):
1138:     *   1. Amarra de volta ao form pai (ver nota em FormParaBO);
1139:     *   2. Refresh da pagina de dados do pai - a ultima linha tanto de
1140:     *      marca() quanto de desmarca() no legado.
1141:     *
1142:     * O Refresh da PROPRIA grade NAO entra aqui de proposito: no legado ele
1143:     * eh UM, no fim de cada Click (ThisForm.Grade.Refresh depois do Scan),
1144:     * nunca por linha marcada. Chamado por linha, ele cairia DENTRO do SCAN
1145:     * de SelTudo/Apaga - e repintar a grade com o ponteiro do proprio
1146:     * RecordSource em varredura eh risco gratuito. Os handlers e
1147:     * CarregarGrade() continuam donos desse Refresh.
1148:     *
1149:     * O que eh especifico de UM caminho mora no metodo daquele caminho e
1150:     * chama este no fim, na mesma ordem do legado:

*-- Linhas 1169 a 1187:
1169: 
1170:     *--------------------------------------------------------------------------
1171:     * AplicarPermissaoOrigemAoFormPai - legado, fim de desmarca():
1172:     *     Select TmpOperacao
1173:     *     _RecnoAnt = Recno()
1174:     *     Go Top
1175:     *     ThisForm.parentform.EditaOrigem = .t.
1176:     *     Scan For Not Empty(Codigos)
1177:     *         ThisForm.parentform.EditaOrigem = .f.
1178:     *         Exit
1179:     *     EndScan
1180:     *
1181:     * A varredura em si ja esta em SigOpMpdBO.DesmarcarExec(), que deixa o
1182:     * resultado em this_lPermiteEditarOrigem (o BO nao referencia Form -
1183:     * PILAR 3). Este metodo eh a outra metade: levar esse valor ao form
1184:     * pai. Sem ele o recalculo morria no BO e a trava de edicao da conta de
1185:     * Origem nunca chegava a tela - defeito fechado nesta fase.
1186:     *
1187:     * O pai atual (Formepd) ainda nao declara a property equivalente a

*-- Linhas 1298 a 1325:
1298:     *
1299:     * Esta tela nao tem TextBox de dados para limpar: o estado "de campo"
1300:     * dela eh a linha corrente que o BO guarda (this_lFlag/this_cEmps/.../
1301:     * this_cCPros), o par (chave, valor) do proximo UPDATE
1302:     * (this_cCidChavesAtual/this_lChkSubn) e as sugestoes calculadas pela
1303:     * ultima marcacao. Chamado por CarregarGrade() ANTES de recarregar:
1304:     * CarregarPendencias() RECRIA TmpPends do zero, e estado de uma carga
1305:     * anterior sobrevivendo a isso aplicaria no form pai sugestao de uma
1306:     * pendencia que ja nao esta na tela, ou faria o proximo Atualizar()
1307:     * gravar sobre o CidChaves antigo.
1308:     *
1309:     * NAO limpa a coluna Flag das linhas: marcacao nao eh rascunho de
1310:     * tela - cada uma ja virou UPDATE em SigCdNec.ChkSubn e linhas nos
1311:     * cursores do form pai. Quem desmarca eh Desmarcar(), nunca uma
1312:     * limpeza de campos.
1313:     *--------------------------------------------------------------------------
1314:     PROTECTED PROCEDURE LimparCampos()
1315:         LOCAL loc_oBO
1316: 
1317:         loc_oBO = THIS.this_oBusinessObject
1318: 
1319:         IF VARTYPE(loc_oBO) = "O"
1320:             loc_oBO.this_lFlag    = .F.
1321:             loc_oBO.this_cEmps    = ""
1322:             loc_oBO.this_cDopes   = ""
1323:             loc_oBO.this_nNumes   = 0
1324:             loc_oBO.this_dDatas   = {}
1325:             loc_oBO.this_cOrigem  = ""

