# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (5)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'GRUCONTAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DOPES, CLICKORIDES, CONTADS, CONTAOS, EMPDOPNUMS, ICLIS, SITUAS, GRUPODS, UMOVS, NUMS, TIPOOPS, OBSORIGS, OBSDESTS, EXIBSITS, BLQDESCS, GRCLIS, TIPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'GRUPOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DOPES, CLICKORIDES, CONTADS, CONTAOS, EMPDOPNUMS, ICLIS, SITUAS, GRUPODS, UMOVS, NUMS, TIPOOPS, OBSORIGS, OBSDESTS, EXIBSITS, BLQDESCS, GRCLIS, TIPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DOPES, CLICKORIDES, CONTADS, CONTAOS, EMPDOPNUMS, ICLIS, SITUAS, GRUPODS, UMOVS, NUMS, TIPOOPS, OBSORIGS, OBSDESTS, EXIBSITS, BLQDESCS, GRCLIS, TIPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'FPAGS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DOPES, CLICKORIDES, CONTADS, CONTAOS, EMPDOPNUMS, ICLIS, SITUAS, GRUPODS, UMOVS, NUMS, TIPOOPS, OBSORIGS, OBSDESTS, EXIBSITS, BLQDESCS, GRCLIS, TIPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DOPES, CLICKORIDES, CONTADS, CONTAOS, EMPDOPNUMS, ICLIS, SITUAS, GRUPODS, UMOVS, NUMS, TIPOOPS, OBSORIGS, OBSDESTS, EXIBSITS, BLQDESCS, GRCLIS, TIPOS

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
  ControlSource = ""
  ControlSource = ""
lcSql = [Select Dopes,TipoOps,Nivels,LimCres,ObsOrigs,ObsDests,ExibSits From SigCdOpe Where Dopes = ']+ThisForm.Operacao+[']
If ThisForm.ParentForm.PodataMgr.Sqlexecute(lcsql,'LocalOpe') < 1
Select TprMvCab
	lcSql = [Select * From SigOpPed ]
	If ThisForm.ParentForm.PodataMgr.Sqlexecute(lcsql,'LocalOpePd') < 1
	Select DbOpera
		lStrQuery = [Select Dopes,OpPends From SigCdOpe ]
		If ThisForm.ParentForm.poDataMgr.SqlExecute(lStrQuery, 'CrTmpOpe') < 1
		Select CrTmpOpe
		lStrQuery = [Select a.dopes, a.EmpDopNums, a.ChkPagos, a.ChkSubn, a.Utilizados,a.Valos From SigMvCab a, SigOpPed b ]+;
					[Select a.dopes, a.EmpDopNums, a.ChkPagos, a.ChkSubn, a.Utilizados,a.Valos From SigMvCab a, SigOpPed b ]+;
		If ThisForm.ParentForm.poDataMgr.SqlExecute(lStrQuery, 'CrTprMvCab') < 1
		Select a.dopes,a.empDopNums,a.Valos, a.ChkSubn From CrTprMvCab a, LocalOpePd b Where a.Dopes = b.Dopes And ;
		Select CrConserto2
			lcSql = [Select Dopes, Moedas, Sum( ( Qtds-QtBaixas ) * (Units+ValRats) ) as Totas From SigMvItn ]+;
			ThisForm.ParentForm.PodataMgr.Sqlexecute(lcSql,'lCredEesti')
				Select lCredEesti
					If Not Seek(lCredEesti.Dopes,'DbOpera')
						Insert Into DbOpera (Dopes,Totas) Values (lCredEesti.Dopes,0)
	 				If Not Seek(CrConserto2.Dopes,'DbOpera')
						Insert Into DbOpera (Dopes,Totas) Values (CrConserto2.Dopes,0)
	lcSql = [Select Rclis From SigCdCli where Iclis = ']+_Conta+[']
	If ThisForm.ParentForm.PodataMgr.Sqlexecute(lcSql,'CrTmpCli') < 1
	lcSql = [Select distinct GrupoDs From SigOpFp Where Situas = 'S' And GrupoDs <> ' ' ]
	If ThisForm.ParentForm.PodataMgr.SqlExecute(lcSql,'LocFpg') < 1
	Select CrTmpSccr
	lcQuery = [Select b.grclis, b.iclis, sum(b.valors) as Valors, b.fpags ]+;
			  [From SigCqChm a, SigChe b, SigCdOpt c Where ]+;
	If ThisForm.ParentForm.PodataMgr.SqlExecute(lcQuery,'Cheques') < 1
	Select Cheques
	lcQuery = [Select sum( (b.Qtds - b.QtBaixas) * b.Units ) as Totas, b.Moedas, a.Dopes From SigMvCab a, SigMvItn b, SigCdOpe c ]+;
	If ThisForm.ParentForm.PodataMgr.SqlExecute(lcQuery,'Pendencia') < 1
	Select Pendencia
	Select DbOpera
		.Column1.ControlSource = "DbOpera.Dopes"
		.Column2.ControlSource = "DbOpera.Totas"
		lcSql = [Select Obs,Situas,VultComps,UltComps,Nascs,Codigos  From SigCdCli Where Iclis = ']+_contaO+[']
		lcSql = [Select Obs,Situas,VultComps,UltComps,Nascs,Codigos  From SigCdCli Where Iclis = ']+_contaD+[']
	=ThisForm.ParentForm.Podatamgr.Sqlexecute(lcSql,'CrTmpcli')
		lcSql = [Select Obs,Situas,VultComps,UltComps,Nascs,Codigos,DtnCons,DtCasas  From SigCdCli Where Iclis = ']+_contaO+[']
		lcSql = [Select Obs,Situas,VultComps,UltComps,Nascs,Codigos,DtnCons,DtCasas  From SigCdCli Where Iclis = ']+_contaD+[']
	=ThisForm.ParentForm.Podatamgr.Sqlexecute(lcSql,'CrTmpcli')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpLrC.prg) - TRECHOS RELEVANTES PARA PASS SQL (1884 linhas total):

*-- Linhas 136 a 154:
136:                 *-- Processa() e, nao acendendo painel, tenta o lado oposto).
137:                 *-- Vem DEPOIS da montagem visual porque pinta a tela, e sob
138:                 *-- guarda porque o harness de teste instancia o form SEM
139:                 *-- parametro algum e sem conexao - sem a guarda o SQLEXEC do
140:                 *-- BO abriria dialogo e travaria o teste. A guarda NUNCA
141:                 *-- derruba o InicializarForm: parametro ausente nao eh falha
142:                 *-- de inicializacao, so significa que nao ha o que processar.
143:                 loc_lBypassTeste = (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
144:                     (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
145: 
146:                 IF !loc_lBypassTeste AND !EMPTY(THIS.this_cOperacao) AND ;
147:                         TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
148:                     THIS.ProcessarAberturaDialogo()
149:                 ENDIF
150: 
151:                 loc_lSucesso = .T.
152:             ELSE
153:                 MsgErro("Falha ao criar SigOpLrCBO.", "Erro em InicializarForm")
154:             ENDIF

*-- Linhas 942 a 1003:
942:     * CriarCursorGrade - cria o cursor que alimenta a grade, com a MESMA
943:     * estrutura e NA MESMA ORDEM de campos que SigOpLrCBO usa em
944:     * CarregarMovimentosPendentes (dopes C(20), totas N(12,2)) - divergir a
945:     * ordem faz o INSERT casar coluna errada em silencio.
946:     * Legado: PROCEDURE Load -> Create Cursor DbOpera (dopes c(20), totas n(12,2))
947:     * O BO reaproveita este mesmo alias (IF !USED() ... ELSE ZAP), por isso o
948:     * vinculo da grade sobrevive a recarga.
949:     *==========================================================================
950:     PROTECTED PROCEDURE CriarCursorGrade()
951:         LOCAL loc_oErro
952: 
953:         TRY
954:             IF !USED(THIS.this_cCursorGrade)
955:                 CREATE CURSOR (THIS.this_cCursorGrade) (dopes C(20), totas N(12,2))
956:                 SELECT (THIS.this_cCursorGrade)
957:                 INDEX ON dopes TAG dopes
958:             ENDIF
959:         CATCH TO loc_oErro
960:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
961:                 CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em CriarCursorGrade")
962:         ENDTRY
963:     ENDPROC
964: 
965:     *==========================================================================
966:     * ConfigurarGrade - grade dos movimentos em aberto da conta analisada.
967:     * Legado: SIGOPLRC.Container1.Grade (Top=53, Left=295, Width=434,
968:     * Height=195, ColumnCount=2, Verdana 8, ReadOnly, RowHeight=16,
969:     * ScrollBars=2, DeleteMark=.F.). Somente leitura - o usuario apenas
970:     * consulta o que ja esta em aberto; nao ha coluna editavel.
971:     * NAO liga RecordSource/ControlSource aqui: o vinculo (e a largura das
972:     * colunas, que o RecordSource reseta para o default) fica em CarregarDados.
973:     *==========================================================================
974:     PROTECTED PROCEDURE ConfigurarGrade(par_oContainer)
975:         par_oContainer.AddObject("grd_4c_Dados", "Grid")
976: 
977:         WITH par_oContainer.grd_4c_Dados
978:             .Top         = 53
979:             .Left        = 295
980:             .Width       = 434
981:             .Height      = 195
982:             .ColumnCount = 2
983:             .FontName    = "Verdana"
984:             .FontSize    = 8
985:             .RowHeight   = 16
986:             .ScrollBars  = 2
987:             .Enabled     = .T.
988:             .DeleteMark  = .F.
989:             .RecordMark  = .F.
990:             *-- Grid.ReadOnly propaga para as colunas, por isso vem ANTES delas
991:             .ReadOnly    = .T.
992:         ENDWITH
993: 
994:         WITH par_oContainer.grd_4c_Dados.Column1
995:             .FontName = "Verdana"
996:             .FontSize = 8
997:             .Enabled  = .T.
998:             .ReadOnly = .T.
999:         ENDWITH
1000: 
1001:         WITH par_oContainer.grd_4c_Dados.Column1.Header1
1002:             .FontName  = "Verdana"
1003:             .FontSize  = 8

*-- Linhas 1039 a 1099:
1039: 
1040:     *==========================================================================
1041:     * CarregarDados - FUNIL UNICO de vinculo e repintura da grade. Legado:
1042:     * bloco final de Processa() -> Select DbOpera / Go Top / With Grade
1043:     * .RecordSource / .Column1.ControlSource / .Column2.ControlSource / .Refresh
1044:     *
1045:     * Tem de ser chamado em TODO caminho que popula o cursor (carga inicial e
1046:     * cada reprocessamento por troca do lado da conta): popular o cursor NAO
1047:     * repinta a grade sozinho - sem GO TOP + Refresh a grade fica visualmente
1048:     * vazia com o cursor cheio, e o sintoma ("a tela nao traz dados") manda o
1049:     * diagnostico para o SQL.
1050:     *
1051:     * E tem de ser chamado DEPOIS de acender cnt_4c_Container1: Refresh em
1052:     * controle dentro de container oculto nao pinta. Quem reprocessa o lado da
1053:     * conta acende o painel primeiro e so entao chama este funil.
1054:     *
1055:     * A ordem eh obrigatoria: ColumnCount -> RecordSource -> ControlSource ->
1056:     * Width -> Header1.Caption. RecordSource recalcula a largura das colunas
1057:     * para o default e zera os captions, entao largura e titulo tem de ser
1058:     * reaplicados DEPOIS dele.
1059:     *==========================================================================
1060:     PROCEDURE CarregarDados()
1061:         LOCAL loc_lSucesso, loc_oGrade, loc_oErro
1062:         loc_lSucesso = .F.
1063: 
1064:         TRY
1065:             THIS.CriarCursorGrade()
1066: 
1067:             IF USED(THIS.this_cCursorGrade) AND ;
1068:                PEMSTATUS(THIS.cnt_4c_Container1, "grd_4c_Dados", 5)
1069: 
1070:                 loc_oGrade = THIS.cnt_4c_Container1.grd_4c_Dados
1071: 
1072:                 loc_oGrade.ColumnCount = 2
1073:                 loc_oGrade.RecordSource = THIS.this_cCursorGrade
1074:                 loc_oGrade.Column1.ControlSource = THIS.this_cCursorGrade + ".dopes"
1075:                 loc_oGrade.Column2.ControlSource = THIS.this_cCursorGrade + ".totas"
1076: 
1077:                 *-- Larguras e titulos DEPOIS do RecordSource (ele reseta ambos)
1078:                 loc_oGrade.Column1.Width = 290
1079:                 loc_oGrade.Column2.Width = 112
1080:                 loc_oGrade.Column1.Header1.Caption = "Movimenta" + CHR(231) + CHR(245) + ;
1081:                     "es Pendentes"
1082:                 loc_oGrade.Column2.Header1.Caption = "Valor"
1083: 
1084:                 SELECT (THIS.this_cCursorGrade)
1085:                 GO TOP
1086:                 loc_oGrade.Refresh()
1087: 
1088:                 loc_lSucesso = .T.
1089:             ENDIF
1090:         CATCH TO loc_oErro
1091:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
1092:                 CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDados")
1093:         ENDTRY
1094: 
1095:         RETURN loc_lSucesso
1096:     ENDPROC
1097: 
1098:     *==========================================================================
1099:     * AtualizarContainer2 - exibe (ou esconde) o bloco "Observacao da Conta"

