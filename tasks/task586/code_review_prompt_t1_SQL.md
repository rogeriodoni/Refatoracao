# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: 0, GRUPOS, CONTAS, MOEDAS, EMPS, DATAS, DATACONCS, CONCS, CEMPS, CPROS, DOPES, TIPOOPS, TPGDMIS, ATUCOMPRAS, EMPDOPNUMS, ICLIS, I, GERGDMIS, MULTCOMPS

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
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
		ProgSel.Update(.T.)
				lcQuery = [ Select Cemps From SigCdEmp ]
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpEmps') < 1)
				Select TmpEmps
					Insert into TmpConta (Emps, Grupos,Contas,Moedas,CidChaves) Values ;
					Select TmpEmps
				Insert into TmpConta (Emps,Grupos,Contas,Moedas,CidChaves) Values ;
			lcQuery = [ Select Distinct Emps, Grupos, Contas, Moedas, Space(20) as CidChaves From SigMvCcr ]+lcWhere+;
					  [ Select Distinct Emps, Grupos, Contas, Moedas, Space(20) as CidChaves From SigMvCcr ]+lcWherc
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpConta') < 1)
			Select TmpConta
			Select * From TmpConta Into Cursor Selecao Order by Emps,Grupos,Contas,Moedas
			Select Selecao
				ProgConta.Update( .t. )
				Select TmpConta
				If Seek(Selecao.CidChaves)
					Delete
		lcQuery = [ Select Distinct Emps, Grupos, Estos, Cpros, CodCors, CodTams, Space(20) as CidChaves From SigMvHst ]+lcWhere
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpEst') < 1)
		Select TmpEst
			Select * From TmpEst Into Cursor Selecao
			Select Selecao
			Select Selecao
				ProgConta.Update( .t. )
				Select TmpEst
				If Seek(Selecao.CidChaves)
					Delete
		lcQuery = [Select Cemps ] + ;
				    [From SigCdEmp ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalEmp') < 1)
		lcQuery = [Select Calccustos From SigCdPac ]
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalParac') < 1)
		lcQuery = [Select Cpros ] + ;
				    [From SigCdPro ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalPro2') < 1)
		Select LocalEmp
				lcQuery = [Select Distinct Cpros ] + ;
				    [From SigMvEst ] + ;
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalPro') < 1)
				Select * From LocalPro2 Into Cursor LocalPro ReadWrite
			Select LocalPro
				loCusto.Update(.t.)
		Select CrSigOpClU
		lcSql = [Select a.datas,a.Emps,a.Dopes,a.Numes,a.EmpDopNums,a.Valos,a.Contads,a.ContaOs,]+;
				[From SigMvCab a, SigCdOpe b, SigCdTom c ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcSql, 'TprMvCab') < 1)
		lcSql = [Select Emps, Dopes, Numes, EmpDopNums, Cpros, Units, Moedas From SigMvItn ]+;
				[Where EmpDopNums in (Select EmpDopNums	From SigMvCab a, SigCdOpe b, SigCdTom c ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcSql, 'crTpmMvItn') < 1)
		lcSql = [Select EmpDopNums From SigOpClU ]
		If (ThisForm.poDataMgr.SqlExecute(lcSql, 'LocCalcU') < 1)
		Select LocCalcU
		Select TprMvCab
		Select crTpmMvItn
		Select TprMvCab
			loCusto.Update(.t.)
			If Seek(TprMvCab.EmpDopNums,'LocCalcU','EmpdopNums')
				Insert Into CrSigOpClU (Emps,Dopes,Numes,EmpdopNums,iclis,Valors,Datas,Cidchaves) Values ;
				Select crTpmMvItn
				=Seek(TprMvCab.EmpDopNums)
					lcSql = [Select Cpros, UltComps From SigCdPro Where Cpros = ']+crTpmMvItn.Cpros+[']
					If thisform.Podatamgr.sqlexecute(lcsql,'TmpPro') < 1
						MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Select SigCdPro)')
					Insert Into CrSigOpClU (Emps,Dopes,Numes,empDopNums,cpros,Valors,Datas,Moedas,Cidchaves) Values ;
		If Not ThisForm.Podatamgr.Update('CrSigOpClU')
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update CrSigOpClU)')
		lcSql = [Select * From SigOpClU ]
		ThisForm.Podatamgr.Sqlexecute(lcSql,'CsSelecao')
		Select Distinct Iclis From CsSelecao Into Cursor Selecao
		Select Selecao
			loCusto.Update(.t.)
			lcSql = [Select Top 1 Iclis,Datas,Valors From SigOpClU Where Iclis = ']+lcConta+[' ]+;
			If ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalCalcU') < 1
			lcUpDate = [UpDate SigCdCli Set UltComps = ?llData, vUltComps = ]+Str(LocalCalcU.Valors,12,2)+[ Where Iclis = ']+lcConta+[']
			If ThisForm.podatamgr.SqlExecute(lcUpDate,'') < 1
				MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigCdCli)')
			lcSql = [Select Top 1 Iclis,Datas,Valors From SigOpClU Where Iclis = ']+lcConta+[' ]+;
			If ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalCalcU') < 1
			lcUpDate = [UpDate SigCdCli Set dtfats = ?llData, mfats = ]+Str(LocalCalcU.Valors,12,2)+[ Where Iclis = ']+lcConta+[']
			If ThisForm.podatamgr.SqlExecute(lcUpDate,'') < 1
				MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigCdCli 2)')
		Select Distinct Cpros From CsSelecao Into Cursor Selecao
		Select Selecao
			loCusto.Update(.t.)
			lcSql = [Select Top 1 Cpros,Datas,Valors,Moedas From SigOpClU Where Cpros = ']+Selecao.Cpros+[' ]+;
			If ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalCalcU') < 1
			lcUpDate = [UpDate SigCdPro Set UltComps = ?llData, vUltComps = ]+Str(lnValor,12,2)+[, ]+;
			If ThisForm.podatamgr.SqlExecute(lcUpDate,'') < 1
				MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigCdPro)')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrCcc.prg) - TRECHOS RELEVANTES PARA PASS SQL (2054 linhas total):

*-- Linhas 1006 a 1024:
1006:         IF EMPTY(loc_cGrupo)
1007:             RETURN ""
1008:         ENDIF
1009:         RETURN "Grupos = " + EscaparSQL(loc_cGrupo)
1010:     ENDPROC
1011: 
1012:     *==========================================================================
1013:     * AbrirLookupSimples - abre o picker canonico (FormBuscaAuxiliar via
1014:     * AbrirLookupCanonico, herdado de FormBase) SEM checagem previa - usado
1015:     * por F4 e DblClick, que sempre abrem a busca (regra CLAUDE.md: "F4
1016:     * sempre abre lookup direto").
1017:     *==========================================================================
1018:     PROTECTED PROCEDURE AbrirLookupSimples(par_oTxtCod, par_cTabela, par_cCampoCod, ;
1019:             par_cCampoDesc, par_cTitulo, par_cFiltroExtra)
1020:         THIS.AbrirLookupCanonico(par_cTabela, par_cCampoCod, par_cCampoDesc, ;
1021:             par_cTitulo, ALLTRIM(par_oTxtCod.Value), par_oTxtCod, .NULL., par_cFiltroExtra)
1022:     ENDPROC
1023: 
1024:     *==========================================================================

*-- Linhas 1038 a 1068:
1038:         ENDIF
1039: 
1040:         IF USED(loc_cCursor)
1041:             USE IN SELECT(loc_cCursor)
1042:         ENDIF
1043:         loc_cSQL = "SELECT " + par_cCampoCod + " FROM " + par_cTabela + ;
1044:             " WHERE " + par_cCampoCod + " = " + EscaparSQL(loc_cValor) + ;
1045:             IIF(EMPTY(par_cFiltroExtra), "", " AND (" + par_cFiltroExtra + ")")
1046:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)
1047: 
1048:         IF loc_nResult > 0 AND USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
1049:             USE IN SELECT(loc_cCursor)
1050:             RETURN
1051:         ENDIF
1052:         IF USED(loc_cCursor)
1053:             USE IN SELECT(loc_cCursor)
1054:         ENDIF
1055: 
1056:         THIS.AbrirLookupSimples(par_oTxtCod, par_cTabela, par_cCampoCod, ;
1057:             par_cCampoDesc, par_cTitulo, par_cFiltroExtra)
1058:     ENDPROC
1059: 
1060:     *==========================================================================
1061:     * AbrirLookupProduto / ValidarLookupProduto - lookup bidirecional de
1062:     * Produto (SigCdPro.CPros/DPros), usado tanto pelo campo Codigo quanto
1063:     * pelo campo Descricao (igual ao legado: Get_Produto.Valid e
1064:     * Get_Descs.Valid abrem a MESMA busca e preenchem os DOIS campos).
1065:     *==========================================================================
1066:     PROTECTED PROCEDURE AbrirLookupProduto(par_oTxtDigitado, par_oTxtCod, par_oTxtDesc)
1067:         THIS.AbrirLookupCanonico("SigCdPro", "CPros", "DPros", ;
1068:             "Sele" + CHR(231) + CHR(227) + "o de Produto", ;

*-- Linhas 1083 a 1117:
1083:         ENDIF
1084: 
1085:         IF USED(loc_cCursor)
1086:             USE IN SELECT(loc_cCursor)
1087:         ENDIF
1088:         loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE " + ;
1089:             par_cCampoDigitado + " = " + EscaparSQL(loc_cValor)
1090:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)
1091: 
1092:         IF loc_nResult > 0 AND USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
1093:             par_oTxtCod.Value  = ALLTRIM(cursor_4c_ChkProduto.CPros)
1094:             par_oTxtDesc.Value = ALLTRIM(cursor_4c_ChkProduto.DPros)
1095:             USE IN SELECT(loc_cCursor)
1096:             *-- Achou pelo valor exato: Produto acabou de ficar preenchido,
1097:             *-- entao a Descricao deixa de aceitar digitacao (When legado)
1098:             THIS.AplicarWhenDescricaoPorCampo(par_oTxtCod)
1099:             RETURN
1100:         ENDIF
1101:         IF USED(loc_cCursor)
1102:             USE IN SELECT(loc_cCursor)
1103:         ENDIF
1104: 
1105:         THIS.AbrirLookupProduto(par_oTxtDigitado, par_oTxtCod, par_oTxtDesc)
1106:     ENDPROC
1107: 
1108:     *==========================================================================
1109:     * AplicarWhenDescricao - transcreve o "PROCEDURE When / Return(Empty(
1110:     * This.Parent.Get_Produto.Value))" que os TRES Get_Descs do legado tem
1111:     * (OpEstoque, OpCusto e OpCompra): a Descricao so aceita digitacao
1112:     * enquanto o Produto esta em branco - assim que o codigo do produto eh
1113:     * preenchido (digitado ou trazido pelo picker), a Descricao vira apenas
1114:     * exibicao do que o lookup devolveu, e voltar a digitar nela so eh
1115:     * possivel limpando o Produto.
1116:     *
1117:     * Nao da para migrar o When por BINDEVENT (o VFP descarta o retorno do

