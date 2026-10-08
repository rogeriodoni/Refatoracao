# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'VOPERS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: INTCONTS, DATAS, ICLIS, VALORS, NUMLOTES, CONTROLEATU, DOPES, COTACAOS, OPERS, VTITCC, NOPERS, ESPECIES, PROVS, CREDS, EMPDOPNUMS, FPAGS, FORMAS, INFOS, DEB, TRANSACAOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EMPDOPNCS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: INTCONTS, DATAS, ICLIS, VALORS, NUMLOTES, CONTROLEATU, DOPES, COTACAOS, OPERS, VTITCC, NOPERS, ESPECIES, PROVS, CREDS, EMPDOPNUMS, FPAGS, FORMAS, INFOS, DEB, TRANSACAOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'VALOCURS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: INTCONTS, DATAS, ICLIS, VALORS, NUMLOTES, CONTROLEATU, DOPES, COTACAOS, OPERS, VTITCC, NOPERS, ESPECIES, PROVS, CREDS, EMPDOPNUMS, FPAGS, FORMAS, INFOS, DEB, TRANSACAOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: INTCONTS, DATAS, ICLIS, VALORS, NUMLOTES, CONTROLEATU, DOPES, COTACAOS, OPERS, VTITCC, NOPERS, ESPECIES, PROVS, CREDS, EMPDOPNUMS, FPAGS, FORMAS, INFOS, DEB, TRANSACAOS

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
Insert Into Cabecalho (Empresa, Titulo, Periodo) ;
lcQuery = [Select Codigos, ContConts ] + ;
	[From SigCdGcr ] + ;
If (Thisform.poDataMgr.SqlExecute(lcQuery, 'Grupos') < 1)
Select Grupos
lcQuery = [Select Codigos, IntConts, ContConts ] + ;
	[From SigCdGcr]
If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crSigCdGcr') < 1)
Select crSigCdGcr
lcQuery = [Select Cemps ] + ;
	[From SigCdEmp]
If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crSigCdEmp') < 1)
Select crSigCdEmp
		Select crSigMvCcr
		Select crSigMvCcr
	lcQuery = [Select Emps, Dopes, Numes, Grupos, Contas, SGrupos, SContas, Datas, ] + ;
		[From SigMvCcr ] + ;
	If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crSigMvCcr') < 1)
	Select crSigMvCcr
Select crSigMvCcr
	oProg.Update(.T.)
	lcQuery = [Select IClis, Razaos, RClis, Cpfs ] + ;
		[From SigCdCli ] + ;
	If (Thisform.poDataMgr.SqlExecute(lcQuery, 'LocalCli') < 1)
	lcQuery = [Select IClis, RClis, Razaos, Cpfs, IntConts, CContabs,TpHists,Hists ] + ;
		[From SigCdCli ] + ;
	If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crSigCdCli') < 1)
	Select Grupos
	Select crSigCdGcr
	Select crSigCdEmp
	Select crSigMvCcr
			Select SemConta
			Select crSigMvCcr
		Select LoteProc
		Select crSigMvCcr
	Select MovAux
	Select crSigMvCcr
	Select TmpMccr
			Select LoteProc
			lcQuery = [Select Emps, NumOs ] + ;
				[From SigCqChm ] + ;
			If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crSigCqChm') < 1)
				Select crSigCqChm
					Select crSigMvCcr
					If !Seek(Controle,'crSigMvCcr','VOpers')
						=Seek(Controle,'crSigMvCcr','VOpers')
					Select crSigMvCcr
								Select crSigCdGcr
								lcQuery = [Select IClis, RClis, Razaos, Cpfs ] + ;
									[From SigCdCli ] + ;
								If (Thisform.poDataMgr.SqlExecute(lcQuery, 'LocalCli') < 1)
								lcQuery = [Select CContabs, IClis, RClis, Razaos, Cpfs,TpHists,Hists ] + ;
									[From SigCdCli ] + ;
								If (Thisform.poDataMgr.SqlExecute(lcQuery, 'TmpCli') < 1)
										Select SemConta
								Select crSigMvCcr
								Select MovAux
							Select crSigMvCcr
					Select crSigCqChm
				Select crSigCqChm
					Select TmpMccr
								Select crSigCdGcr
								lcQuery = [Select IClis, RClis, Razaos, Cpfs ] + ;
									[From SigCdCli ] + ;
								If (Thisform.poDataMgr.SqlExecute(lcQuery, 'LocalCli') < 1)
								lcQuery = [Select CContabs, IClis, RClis, Razaos, Cpfs,TpHists,Hists ] + ;
									[From SigCdCli ] + ;
								If (Thisform.poDataMgr.SqlExecute(lcQuery, 'TmpCli') < 1)
										Select SemConta
								Select TmpMccr
								Select MovAux
					Select crSigCqChm
			Select crSigMvCcr
				Select crSigMvCcr
				=Seek(Controle,'crSigMvCcr','NOpers')
					If Seek(crSigMvCcr.Grupos,'Grupos','Codigos')
						Select crSigCdGcr
						lcQuery = [Select IClis, RClis, Razaos, Cpfs ] + ;
							[From SigCdCli ] + ;
						If (Thisform.poDataMgr.SqlExecute(lcQuery, 'LocalCli') < 1)
						lcQuery = [Select CContabs, IClis, RClis, Razaos, Cpfs,TpHists,Hists ] + ;
							[From SigCdCli ] + ;
						If (Thisform.poDataMgr.SqlExecute(lcQuery, 'TmpCli') < 1)
								Select SemConta
						Select crSigMvCcr
						Select MovAux
					Select crSigMvCcr
				Select TmpMccr
					If Seek(TmpMccr.Grupos, 'Grupos', 'Codigos')
						Select crSigCdGcr
						lcQuery = [Select IClis, RClis, Razaos, Cpfs ] + ;
							[From SigCdCli ] + ;
						If (Thisform.poDataMgr.SqlExecute(lcQuery, 'LocalCli') < 1)
						lcQuery = [Select CContabs, IClis, RClis, Razaos, Cpfs,TpHists,Hists ] + ;
							[From SigCdCli ] + ;
						If (Thisform.poDataMgr.SqlExecute(lcQuery, 'TmpCli') < 1)
								Select SemConta
						Select TmpMccr
						Select MovAux
			Select crSigMvCcr
				Select crSigCdPit
					Select crSigMvCcr
					If Seek(pNop,'crSigMvCcr','NOPers')
						Select crSigMvCcr
						=Seek(lcKey,'crSigMvCcr','EmpDopNcs')
								Select crSigMvCcr
							Select SemConta
						Select SemConta
					Select crSigCdPit
				Select crSigCdPit
					lcQuery = [Select * ] + ;
						[From SigMvCcr ] + ;
					If (Thisform.poDataMgr.SqlExecute(lcQuery, 'TmpMccr1') < 1)
					lcqueryesp = [select provs from SigCdEsp where especies=']+TmpMccr1.ESPECIENFS+[']
					If (Thisform.poDataMgr.SqlExecute(lcqueryesp , 'TmpEspes') < 1)
					Select TmpMccr1
						Select TmpMccr
								Select TmpMccr
							Select SemConta
						Select SemConta
					Select crSigCdPit
			Select crSigMvCcr
				Select crSigCdPit
					Select crSigMvCcr
					If Seek(pNop,'crSigMvCcr','NOpers')
						Select crSigMvCcr
						=Seek(lcKey,'crSigMvCcr','EmpDopNcs')
								Select crSigCdGcr
								lcQuery = [Select IClis, RClis, Razaos, Cpfs ] + ;
									[From SigCdCli ] + ;
								If (Thisform.poDataMgr.SqlExecute(lcQuery, 'LocalCli') < 1)
								lcQuery = [Select CContabs, IClis, RClis, Razaos, Cpfs,TpHists,Hists ] + ;
									[From SigCdCli ] + ;
								If (Thisform.poDataMgr.SqlExecute(lcQuery, 'TmpCli') < 1)
										Select SemConta
										Select crSigMvCcr
								Select crSigMvCcr
								Select MovAux
							Select crSigMvCcr
					Select crSigCdPit
				Select crSigCdPit
					lcQuery = [Select * ] + ;
						[From SigMvCcr ] + ;
					If (Thisform.poDataMgr.SqlExecute(lcQuery, 'TmpMccr1') < 1)
					lcqueryesp = [select provs from SigCdEsp where especies=']+TmpMccr1.ESPECIENFS+[']
					If (Thisform.poDataMgr.SqlExecute(lcqueryesp , 'TmpEspes') < 1)
					Select TmpMccr1
						Select TmpMccr
								Select crSigCdGcr
								lcQuery = [Select Ccontabs, IClis, RClis, Razaos, Cpfs, TpHists, Hists ] + ;
									[From SigCdCli ] + ;
								If (Thisform.poDataMgr.SqlExecute(lcQuery, 'LocalCli') < 1)
								lcQuery = [Select CContabs, IClis, RClis, Razaos, Cpfs, TpHists, Hists ] + ;
									[From SigCdCli ] + ;
								If (Thisform.poDataMgr.SqlExecute(lcQuery, 'TmpCli') < 1)
								lcQuery = [Select numeros ] + ;
									[From SigMvPar A, SigOpFp B, SigCdFrm C ] + ;
								If (Thisform.poDataMgr.SqlExecute(lcQuery, 'TmpPar') < 1)
											Select SemConta
											Select TmpMccr
											Select SemConta
											Select TmpMccr
								Select TmpMccr
									lcQuery = [Select CContabs, IClis, RClis, Razaos, Cpfs,TpHists,Hists ] + ;
										[From SigCdCli ] + ;
									If (Thisform.poDataMgr.SqlExecute(lcQuery, 'TmpCliPrit') < 1)
									lcQuery = [Select CContabs, IClis, RClis, Razaos, Cpfs,TpHists,Hists ] + ;
										[From SigCdCli ] + ;
									If (Thisform.poDataMgr.SqlExecute(lcQuery, 'TmpCliCONTEMS') < 1)
								Select MovAux
				Select MovAux
	Select crSigMvCcr
		Delete For EmpDopnums=lcChave
Select Transacaos, Sum(Val(Debs)/100) As Deb, Sum(Val(Creds)/100) As Cred From MovAux Group By Transacaos Into Cursor Dif1
Select Transacaos From Dif1 Where Deb <> Cred Into Cursor dif2
Select * From MovAux Where Transacaos In ( Select Transacaos From dif2 ) Into Cursor diferenca
Select SemConta
	Select MovAux
	Select MovAux
		lcQuery = [Select DirContabv, GrupoPags, GrupoRecs, MoedaCheqs ] + ;
				    [From SigCdPam]
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdPam') < 1)
		lcQuery = [Select CfgHisICs ] + ;
				    [From SigCdPac]
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdPac') < 1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrIct.prg) - TRECHOS RELEVANTES PARA PASS SQL (1482 linhas total):

*-- Linhas 137 a 155:
137:     DataSession  = 2
138: 
139:     *-- Guarda de reentrancia do botao Processar (Fase 7/8). O BO exibe
140:     *-- fwprogressbar durante ConciliarMovimento(), e cada Update()/Refresh()
141:     *-- devolve a vez ao VFP: sem este guard um segundo clique em Processar
142:     *-- entraria em BtnProcessarClick com o primeiro processamento ainda
143:     *-- rodando, disputando os mesmos cursores (cursor_4c_MovAux/SemConta/...).
144:     this_lProcessando = .F.
145: 
146:     *-- WindowType = 1 eh canonico do projeto, NAO transcricao: o SCX herda o
147:     *-- default 0 (modeless) do baseclass form, mas o menu.prg abre a tela com
148:     *-- CREATEOBJECT + variavel LOCAL + Show(), e com modeless o Show()
149:     *-- retorna na hora, a LOCAL sai de escopo e o form eh destruido (pisca e
150:     *-- some) - mesmo raciocinio de FormSigPrGf1.
151: 
152:     *==========================================================================
153:     * Init - Sem parametros recebidos do chamador (form aberto direto pelo
154:     * menu, popMovimentos). DODEFAULT() encadeia para FormBase.Init(), que
155:     *==========================================================================

*-- Linhas 944 a 970:
944:     *==========================================================================
945:     * AposProcessar - fecho do PROCEDURE processamento legado:
946:     *
947:     *     Select SemConta / Set Order to Conta / Go Top
948:     *     If Not Eof()
949:     *         ThisForm.cntBotoes.Top     = ThisForm.btnReport.Top - 2
950:     *         ThisForm.btnReport.Enabled = .F.
951:     *         ThisForm.Get_Datai.Enabled = .F.
952:     *         ThisForm.Get_Dataf.Enabled = .F.
953:     *         ThisForm.cntBotoes.Visible = .T.
954:     *     Else
955:     *         Select MovAux / Go Top
956:     *         If !Eof()
957:     *             Messagebox('Nenhuma Inconsistencia Foi Encontrada!!!', 32, 'ATENCAO')
958:     *         Else
959:     *             Messagebox('Nao Existe Movimentacao no Periodo!!!', 32, 'ATENCAO')
960:     *         Endif
961:     *         ThisForm.Gravar
962:     *     Endif
963:     *
964:     * "ThisForm.btnReport" (o grupo Processar/Encerrar) eh
965:     * THIS.cnt_4c_BotoesAcao.obj_4c_CmdGProcessar; "ThisForm.cntBotoes" eh
966:     * THIS.cnt_4c_Botoes. this_lPossuiInconsistencia/this_lPossuiMovimento
967:     * sao a FONTE UNICA (BO, Fase 2) - o Form so le, nunca recalcula.
968:     *==========================================================================
969:     PROTECTED PROCEDURE AposProcessar()
970:         *-- Dialogo das DIFERENCAS primeiro, na ordem EXATA do legado: no

*-- Linhas 999 a 1052:
999:     * superficie de BO morta eh exatamente o sintoma. Legado
1000:     * (SigPrIct_form_codigo_fonte.txt, fim do PROCEDURE processamento):
1001:     *
1002:     *     Select Transacaos, Sum(Val(Debs)/100) As Deb, Sum(Val(Creds)/100) As Cred ;
1003:     *         From MovAux Group By Transacaos Into Cursor Dif1
1004:     *     Select Transacaos From Dif1 Where Deb <> Cred Into Cursor dif2
1005:     *     Select * From MovAux Where Transacaos In ( Select Transacaos From dif2 ) ;
1006:     *         Into Cursor diferenca
1007:     *     If Reccount() > 0 And Messagebox("Visualizar as diferencas na Tela?",4+32,"Visualizar") = 6
1008:     *         Do Form SigReDif With Thisform.DataSessionId
1009:     *     Endif
1010:     *
1011:     * O "Reccount() > 0" do legado mede o cursor "diferenca" (alias corrente
1012:     * logo depois do Into Cursor), que aqui eh this_lPossuiDiferenca - FONTE
1013:     * UNICA no BO (PILAR 3), o Form nunca recalcula.
1014:     *
1015:     * MsgConfirma devolve LOGICAL (regra #7 - NUNCA comparar com 6) e exibe
1016:     * Sim/Nao com icone de pergunta, equivalente ao 4+32 do legado; o titulo
1017:     * "Visualizar" eh o do legado. Em modo de teste MsgConfirma devolve .F.,
1018:     * entao o harness headless nunca chega a abrir a tela filha (Show() de
1019:     * form modal travaria a execucao).
1020:     *
1021:     * ALIAS DE CONTRATO (movaux/dif2): SigReDifBO.PrepararDados le os alias de
1022:     * nome LITERAL "movaux" e "dif2" na data session do chamador
1023:     * (IF !USED("movaux") OR !USED("dif2") -> recusa com MsgErro) e monta o
1024:     * crGrid com "Select *, 99999999.99 As Deb1s, 99999999.99 As Cred1s From
1025:     * movaux Where Transacaos In (Select Transacaos From dif2)". Os nomes
1026:     * pertencem AO CONSUMIDOR, nao a arquitetura nova, logo NAO levam prefixo
1027:     * cursor_4c_ - mesma razao de SemConta/Cabecalho em
1028:     * PrepararCursoresRelatorio(). Montados aqui a partir dos cursores do BO:
1029:     *   movaux = cursor_4c_MovAux           (ObterCursorMovimento)
1030:     *   dif2   = Transacaos DISTINTAS de cursor_4c_Diferenca
1031:     *            (ObterCursorDiferencas). Equivalente EXATO ao dif2 legado,
1032:     *            porque "diferenca" E' MovAux filtrado por esse mesmo dif2 -
1033:     *            toda Transacaos de dif2 tem pelo menos uma linha em MovAux
1034:     *            (dif2 nasce de um Group By sobre MovAux). Reconstruir eh
1035:     *            necessario porque VerificarDiferencas() FECHA cursor_4c_Dif2
1036:     *            ao terminar.
1037:     * O "Select *" do crGrid exige que movaux NAO tenha Deb1s/Cred1s -
1038:     * cursor_4c_MovAux nao tem (PrepararCursoresProcesso, Fase 2).
1039:     *
1040:     * DataSessionId: este form tem DataSession = 2 (sessao privada) e
1041:     * FormSigReDif.Init(par_nDataSessionId) faz "THIS.DataSessionId =
1042:     * par_nDataSessionId" para ENTRAR nesta sessao e alcancar os dois alias -
1043:     * transcricao de "Do Form SigReDif With Thisform.DataSessionId".
1044:     *
1045:     * Show() FORA do TRY (regra #29): FormSigReDif eh modal (WindowType = 1),
1046:     * logo o Show() BLOQUEIA e todo o uso da tela filha rodaria dentro do
1047:     * bloco - qualquer erro de runtime la dentro saltaria para este CATCH, a
1048:     * referencia LOCAL cairia e a tela filha fecharia sozinha.
1049:     *
1050:     * Os alias de contrato sao fechados DEPOIS do Show() (a tela filha eh
1051:     * modal, portanto ja terminou) e tambem em Destroy(), porque o CATCH pode
1052:     * deixar algum deles aberto.

*-- Linhas 1081 a 1100:
1081:                 *-- Antes de montar: nao herdar alias de um processamento anterior
1082:                 THIS.LiberarCursoresDiferencas()
1083: 
1084:                 SELECT * FROM (loc_cCursorMov) INTO CURSOR movaux READWRITE
1085:                 SELECT DISTINCT Transacaos FROM (loc_cCursorDif) INTO CURSOR dif2 READWRITE
1086: 
1087:                 loc_lPronto = USED("movaux") AND USED("dif2")
1088:             ELSE
1089:                 MsgAviso("Cursores de diferen" + CHR(231) + "a n" + CHR(227) + ;
1090:                     "o dispon" + CHR(237) + "veis - reprocesse o per" + ;
1091:                     CHR(237) + "odo.", "Visualizar")
1092:             ENDIF
1093: 
1094:             IF loc_lPronto
1095:                 loc_oForm = CREATEOBJECT("FormSigReDif", THIS.DataSessionId)
1096:             ENDIF
1097:         CATCH TO loc_oErro
1098:             loc_lPronto = .F.
1099:             loc_oForm   = .NULL.
1100:             MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 1116 a 1134:
1116:     * LiberarCursoresDiferencas - fecha os alias de CONTRATO da tela de
1117:     * diferencas: movaux/dif2 (montados por ExibirDiferencas) e crGrid, que
1118:     * SigReDifBO.PrepararDados cria DENTRO desta data session (ele faz
1119:     * "SET DATASESSION TO (this_nDataSessionId)" antes do SELECT, entao o
1120:     * cursor fica aqui, nao na sessao da tela filha). Chamado em tres pontos:
1121:     * antes de montar, depois do Show() e em Destroy().
1122:     *==========================================================================
1123:     PROTECTED PROCEDURE LiberarCursoresDiferencas()
1124:         IF USED("movaux")
1125:             USE IN movaux
1126:         ENDIF
1127:         IF USED("dif2")
1128:             USE IN dif2
1129:         ENDIF
1130:         IF USED("crGrid")
1131:             USE IN crGrid
1132:         ENDIF
1133:     ENDPROC
1134: 

*-- Linhas 1255 a 1320:
1255:     *               (this_oBusinessObject.ObterCursorInconsistencias()).
1256:     *   Cabecalho - titulo/periodo do cabecalho impresso, equivalente a:
1257:     *       Thisform.poDataMgr.CursorQuery('SigCdEmp','crSigCdEmp','Cemps',_Empr,'Razas')
1258:     *       Create Cursor Cabecalho (Empresa c(80), Titulo c(80), SubTit c(80), Periodo c(80))
1259:     *       Insert Into Cabecalho (Empresa, Titulo, Periodo) Values ;
1260:     *           (_Empr + ' - ' + crSigCdEmp.Razas, ;
1261:     *            'Relatorio de Inconsistencias de Integracao Contabil', ;
1262:     *            'Periodo: ' + Dtoc(IniPer) + ' a ' + Dtoc(FinPer))
1263:     *   "_Empr" (legado) = go_4c_Sistema.cCodEmpresa (CLAUDE.md - _EMPR nunca
1264:     *   usado direto). this_dDataI/this_dDataF (BO) sao a FONTE UNICA do
1265:     *   periodo - o mesmo que ValidarPeriodo()/Processar() ja usaram.
1266:     *==========================================================================
1267:     PROTECTED FUNCTION PrepararCursoresRelatorio()
1268:         LOCAL loc_cCursorOrigem, loc_cSQL, loc_nResultado, loc_cRazao
1269: 
1270:         loc_cCursorOrigem = THIS.this_oBusinessObject.ObterCursorInconsistencias()
1271: 
1272:         IF !USED(loc_cCursorOrigem) OR RECCOUNT(loc_cCursorOrigem) = 0
1273:             MsgAviso("Nenhuma inconsist" + CHR(234) + "ncia dispon" + CHR(237) + ;
1274:                 "vel para o relat" + CHR(243) + "rio.")
1275:             RETURN .F.
1276:         ENDIF
1277: 
1278:         IF USED("SemConta")
1279:             USE IN SemConta
1280:         ENDIF
1281:         *-- ORDER BY Contas, DataS reproduz o "Select SemConta / Set Order to Conta" que
1282:         *-- o legado executa ANTES do If Not Eof() (o TAG Conta eh
1283:         *-- "Contas + Dtos(DataS)"): o SigPrIct.frx imprime na ordem do indice, e
1284:         *-- um SELECT sem ORDER BY entregaria a ordem de INSERCAO.
1285:         SELECT * FROM (loc_cCursorOrigem) ORDER BY Contas, DataS ;
1286:             INTO CURSOR SemConta READWRITE
1287: 
1288:         loc_cRazao = ""
1289:         IF USED("cursor_4c_EmpRelatorio")
1290:             USE IN cursor_4c_EmpRelatorio
1291:         ENDIF
1292:         loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
1293:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpRelatorio")
1294:         IF loc_nResultado >= 1 AND USED("cursor_4c_EmpRelatorio") AND !EOF("cursor_4c_EmpRelatorio")
1295:             loc_cRazao = ALLTRIM(TratarNulo(cursor_4c_EmpRelatorio.Razas, ""))
1296:         ENDIF
1297:         IF USED("cursor_4c_EmpRelatorio")
1298:             USE IN cursor_4c_EmpRelatorio
1299:         ENDIF
1300: 
1301:         IF USED("Cabecalho")
1302:             USE IN Cabecalho
1303:         ENDIF
1304:         CREATE CURSOR Cabecalho (Empresa C(80), Titulo C(80), SubTit C(80), Periodo C(80))
1305:         INSERT INTO Cabecalho (Empresa, Titulo, Periodo) VALUES ;
1306:             (ALLTRIM(go_4c_Sistema.cCodEmpresa) + " - " + loc_cRazao, ;
1307:              "Relat" + CHR(243) + "rio de Inconsist" + CHR(234) + "ncias de Integra" + ;
1308:                 CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil", ;
1309:              "Per" + CHR(237) + "odo: " + DTOC(THIS.this_oBusinessObject.this_dDataI) + ;
1310:                 " " + CHR(224) + " " + DTOC(THIS.this_oBusinessObject.this_dDataF))
1311: 
1312:         RETURN .T.
1313:     ENDFUNC
1314: 
1315:     *==========================================================================
1316:     * ExecutarReportForm - helper canonico de REPORT FORM (mesmo padrao de
1317:     * FormSigPrFem/FormSIGPGCNB/FormSIGPRCNB - CorretorAutomatico #117/#147):
1318:     *   1. guard de EXISTENCIA do FRX (o legado usa "Report Form SIGPRICT"
1319:     *      BARE, o VFP9 procuraria o arquivo no diretorio corrente);
1320:     *   2. guard de cursor VAZIO (preview em branco nao diz nada ao usuario);

*-- Linhas 1341 a 1359:
1341:                     "Aten" + CHR(231) + CHR(227) + "o")
1342:                 RETURN .F.
1343:             ENDIF
1344:             SELECT (par_cCursorDados)
1345:             GO TOP
1346:         ENDIF
1347: 
1348:         loc_cPointOrig    = SET("POINT")
1349:         loc_cSepOrig      = SET("SEPARATOR")
1350:         loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
1351:         SET POINT TO "."
1352:         SET SEPARATOR TO ","
1353:         SET REPORTBEHAVIOR 80
1354: 
1355:         DO CASE
1356:             CASE par_cModo == "PREVIEW"
1357:                 REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
1358:             CASE par_cModo == "PRINTER_PROMPT"
1359:                 REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE

