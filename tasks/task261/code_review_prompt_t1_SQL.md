# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (7)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: 0, GRUPOS, CONTAS, MOEDAS, EMPS, DATAS, DATACONCS, CONCS, CEMPS, CPROS, DOPES, TIPOOPS, TPGDMIS, ATUCOMPRAS, EMPDOPNUMS, ICLIS, I, GERGDMIS, MULTCOMPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna '1' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: 0, GRUPOS, CONTAS, MOEDAS, EMPS, DATAS, DATACONCS, CONCS, CEMPS, CPROS, DOPES, TIPOOPS, TPGDMIS, ATUCOMPRAS, EMPDOPNUMS, ICLIS, I, GERGDMIS, MULTCOMPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ESTOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: 0, GRUPOS, CONTAS, MOEDAS, EMPS, DATAS, DATACONCS, CONCS, CEMPS, CPROS, DOPES, TIPOOPS, TPGDMIS, ATUCOMPRAS, EMPDOPNUMS, ICLIS, I, GERGDMIS, MULTCOMPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'OPERS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: 0, GRUPOS, CONTAS, MOEDAS, EMPS, DATAS, DATACONCS, CONCS, CEMPS, CPROS, DOPES, TIPOOPS, TPGDMIS, ATUCOMPRAS, EMPDOPNUMS, ICLIS, I, GERGDMIS, MULTCOMPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'UNITS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: 0, GRUPOS, CONTAS, MOEDAS, EMPS, DATAS, DATACONCS, CONCS, CEMPS, CPROS, DOPES, TIPOOPS, TPGDMIS, ATUCOMPRAS, EMPDOPNUMS, ICLIS, I, GERGDMIS, MULTCOMPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'QTDS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: 0, GRUPOS, CONTAS, MOEDAS, EMPS, DATAS, DATACONCS, CONCS, CEMPS, CPROS, DOPES, TIPOOPS, TPGDMIS, ATUCOMPRAS, EMPDOPNUMS, ICLIS, I, GERGDMIS, MULTCOMPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CUSTOFSMEDIO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: 0, GRUPOS, CONTAS, MOEDAS, EMPS, DATAS, DATACONCS, CONCS, CEMPS, CPROS, DOPES, TIPOOPS, TPGDMIS, ATUCOMPRAS, EMPDOPNUMS, ICLIS, I, GERGDMIS, MULTCOMPS

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrCcc.prg) - TRECHOS RELEVANTES PARA PASS SQL (2058 linhas total):

*-- Linhas 1098 a 1163:
1098:                 loc_oBO.this_cMoedaConta = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_TxtMoedas.Value)
1099:                 loc_oBO.this_dDataConta  = THIS.cnt_4c_OpConta.txt_4c_TxtData.Value
1100:                 IF VARTYPE(loc_oProgress) = "O"
1101:                     loc_oProgress.Update("Recalculando Conta Corrente...")
1102:                 ENDIF
1103:                 IF loc_oBO.RecalcularSaldosConta()
1104:                     loc_lAlgum = .T.
1105:                 ENDIF
1106:                 THIS.txt_4c_Registro.Value = loc_oBO.this_nRegistros
1107:                 DOEVENTS
1108:             ENDIF
1109: 
1110:             *-- Recalcular Estoque
1111:             IF THIS.chk_4c_Estoque.Value = 1
1112:                 loc_oBO.this_cEmpEst   = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_Empresa.Value)
1113:                 loc_oBO.this_cGrupoEst = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_TxtGrupos.Value)
1114:                 loc_oBO.this_cEstoque  = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_Estoque.Value)
1115:                 loc_oBO.this_cProdEst  = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_Produto.Value)
1116:                 loc_oBO.this_dDataEst  = THIS.cnt_4c_OpEstoque.txt_4c_TxtData.Value
1117:                 IF VARTYPE(loc_oProgress) = "O"
1118:                     loc_oProgress.Update("Recalculando Estoque...")
1119:                 ENDIF
1120:                 IF loc_oBO.RecalcularSaldosEstoque()
1121:                     loc_lAlgum = .T.
1122:                 ENDIF
1123:                 THIS.txt_4c_Registro.Value = loc_oBO.this_nRegistros
1124:                 DOEVENTS
1125:             ENDIF
1126: 
1127:             *-- Recalcular Custo de Produto
1128:             IF THIS.chk_4c_BtnCusto.Value = 1
1129:                 loc_oBO.this_cEmpCusto  = ALLTRIM(THIS.cnt_4c_OpCusto.txt_4c_Empresa.Value)
1130:                 loc_oBO.this_cProdCusto = ALLTRIM(THIS.cnt_4c_OpCusto.txt_4c_Produto.Value)
1131:                 loc_oBO.this_dDataCusto = THIS.cnt_4c_OpCusto.txt_4c_TxtData.Value
1132:                 IF VARTYPE(loc_oProgress) = "O"
1133:                     loc_oProgress.Update("Recalculando Custo de Produto...")
1134:                 ENDIF
1135:                 IF loc_oBO.RecalcularSaldosCusto()
1136:                     loc_lAlgum = .T.
1137:                 ENDIF
1138:                 THIS.txt_4c_Registro.Value = loc_oBO.this_nRegistros
1139:                 DOEVENTS
1140:             ENDIF
1141: 
1142:             *-- Recalcular Ultima Compra
1143:             IF THIS.chk_4c_BtnCompra.Value = 1
1144:                 loc_oBO.this_cEmpCompra  = ALLTRIM(THIS.cnt_4c_OpCompra.txt_4c_Empresa.Value)
1145:                 loc_oBO.this_cProdCompra = ALLTRIM(THIS.cnt_4c_OpCompra.txt_4c_Produto.Value)
1146:                 loc_oBO.this_dDataCompra = THIS.cnt_4c_OpCompra.txt_4c_TxtData.Value
1147:                 IF VARTYPE(loc_oProgress) = "O"
1148:                     loc_oProgress.Update(CHR(218) + "ltima Compra...")
1149:                 ENDIF
1150:                 IF loc_oBO.RecalcularSaldosCompra()
1151:                     loc_lAlgum = .T.
1152:                 ENDIF
1153:                 THIS.txt_4c_Registro.Value = loc_oBO.this_nRegistros
1154:                 DOEVENTS
1155:             ENDIF
1156: 
1157:             IF loc_lAlgum
1158:                 THIS.lbl_4c_LblEnd.Visible = .T.
1159:             ENDIF
1160: 
1161:             loc_lSucesso = .T.
1162:         CATCH TO loc_oErro
1163:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;


### BO (C:\4c\projeto\app\classes\SigPrCccBO.prg):
*==============================================================================
* SigPrCccBO.prg - Business Object para Recalculo de Saldos
* Herda de BusinessBase
* Tabela principal: SigOpClU (Ultima Compra por Cliente/Produto)
* Fases 1-2/8: Propriedades, Init e metodos de recalculo completos
*==============================================================================

DEFINE CLASS SigPrCccBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Configuracao da entidade
    *--------------------------------------------------------------------------
    this_cTabela     = "SigOpClU"
    this_cCampoChave = "CidChaves"

    *--------------------------------------------------------------------------
    * Secao Conta Corrente (OpConta) - recalcula SigMvCcr
    *--------------------------------------------------------------------------
    this_cEmpConta    = ""    && Get_Empresa C(3)  - empresa filtro
    this_cGrupoConta  = ""    && txtGrupos   C(10) - grupo de conta
    this_cConta       = ""    && txtContas   C(10) - conta corrente
    this_cMoedaConta  = ""    && txtMoedas   C(3)  - moeda
    this_dDataConta   = {}    && txtData     D     - data a partir de

    *--------------------------------------------------------------------------
    * Secao Estoque (OpEstoque) - recalcula SigMvHst
    *--------------------------------------------------------------------------
    this_cEmpEst      = ""    && Get_Empresa C(3)  - empresa filtro
    this_cGrupoEst    = ""    && txtGrupos   C(10) - grupo do deposito
    this_cEstoque     = ""    && Get_Estoque C(10) - codigo do deposito/estoque
    this_cProdEst     = ""    && Get_Produto C(14) - codigo do produto
    this_cDescProdEst = ""    && Get_Descs   C(40) - descricao do produto
    this_dDataEst     = {}    && txtData     D     - data a partir de

    *--------------------------------------------------------------------------
    * Secao Custo de Produto (OpCusto) - recalcula custo em SigCdPro
    *--------------------------------------------------------------------------
    this_cEmpCusto      = ""  && Get_Empresa C(3)  - empresa filtro
    this_cProdCusto     = ""  && Get_Produto C(14) - codigo do produto
    this_cDescProdCusto = ""  && Get_Descs   C(40) - descricao do produto
    this_dDataCusto     = {}  && txtData     D     - data a partir de

    *--------------------------------------------------------------------------
    * Secao Ultima Compra (OpCompra) - atualiza SigOpClU, SigCdCli, SigCdPro
    *--------------------------------------------------------------------------
    this_cEmpCompra      = "" && Get_Empresa C(3)  - empresa filtro
    this_cProdCompra     = "" && Get_Produto C(14) - codigo do produto
    this_cDescProdCompra = "" && Get_Descs   C(40) - descricao do produto
    this_dDataCompra     = {} && txtData     D     - data a partir de

    *--------------------------------------------------------------------------
    * Parametros do sistema (carregados de SigCdPam em InicializarDados)
    *--------------------------------------------------------------------------
    this_cMoeCentral  = ""    && MoeCentral  C(3)  - moeda central para cotacao
    this_cGrupoRecs   = ""    && GrupoRecs   C(10) - grupo recebimentos C.C.
    this_cGrupoPags   = ""    && GrupoPags   C(10) - grupo pagamentos C.C.
    this_cContaRecs   = ""    && ContaRecs   C(10) - conta recebimentos C.C.
    this_cContaPags   = ""    && ContaPags   C(10) - conta pagamentos C.C.

    *--------------------------------------------------------------------------
    * Estado do processamento
    *--------------------------------------------------------------------------
    this_nRegistros   = 0     && Get_Registro N    - contador de registros processados
    this_lProcessando = .F.   && .T. enquanto Processa.Click estiver rodando

    *--------------------------------------------------------------------------
    * Propriedades de linha - SigOpClU (CRUD)
    *--------------------------------------------------------------------------
    this_cChaves     = ""    && cidchaves  C(20) PK
    this_cCpros      = ""    && cpros      C(14)
    this_dDatas      = {}    && datas      datetime
    this_cDopes      = ""    && dopes      C(20)
    this_cEmpDopNums = ""    && empdopnums C(29)
    this_cEmps       = ""    && emps       C(3)
    this_cIclis      = ""    && iclis      C(10)
    this_cMoedas     = ""    && moedas     C(3)
    this_nNumes      = 0     && numes      N(6,0)
    this_nValors     = 0     && valors     N(13,2)
    this_nQtds       = 0     && qtds       N(12,0)

    *==========================================================================
    * Init - Configura tabela principal e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            THIS.this_cTabela     = "SigOpClU"
            THIS.this_cCampoChave = "CidChaves"

            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCccBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarDados - carrega parametros de SigCdPam no BO
    *==========================================================================
    PROCEDURE InicializarDados()
        LOCAL loc_lSucesso, loc_cSQL

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT GrupoRecs, GrupoPags, ContaRecs, ContaPags, MoeCentral " + ;
                       "FROM SigCdPam"

            IF SQLEXEC(gnConnHandle, m.loc_cSQL, "cursor_4c_Pam") > 0
                IF USED("cursor_4c_Pam") AND RECCOUNT("cursor_4c_Pam") > 0
                    SELECT cursor_4c_Pam
                    THIS.this_cGrupoRecs  = NVL(GrupoRecs,  "")
                    THIS.this_cGrupoPags  = NVL(GrupoPags,  "")
                    THIS.this_cContaRecs  = NVL(ContaRecs,  "")
                    THIS.this_cContaPags  = NVL(ContaPags,  "")
                    THIS.this_cMoeCentral = NVL(MoeCentral, "")
                ENDIF
                IF USED("cursor_4c_Pam")
                    USE IN cursor_4c_Pam
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao carregar par" + CHR(226) + "metros de SigCdPam.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCccBO.InicializarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - carrega colunas de SigOpClU do cursor informado
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cChaves     = NVL(cidchaves,  SPACE(20))
            THIS.this_cCpros      = NVL(cpros,      SPACE(14))
            THIS.this_dDatas      = NVL(datas,      {})
            THIS.this_cDopes      = NVL(dopes,      SPACE(20))
            THIS.this_cEmpDopNums = NVL(empdopnums, SPACE(29))
            THIS.this_cEmps       = NVL(emps,       SPACE(3))
            THIS.this_cIclis      = NVL(iclis,      SPACE(10))
            THIS.this_cMoedas     = NVL(moedas,     SPACE(3))
            THIS.this_nNumes      = NVL(numes,      0)
            THIS.this_nValors     = NVL(valors,     0)
            THIS.this_nQtds       = NVL(qtds,       0)
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *==========================================================================
    * Inserir - insere um registro em SigOpClU
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL

        loc_lSucesso = .F.

        TRY
            THIS.this_cChaves = SYS(2015) + SYS(2015)

            loc_cSQL = "INSERT INTO SigOpClU " + ;
                "(cidchaves, cpros, datas, dopes, empdopnums, " + ;
                " emps, iclis, moedas, numes, valors, qtds) " + ;
                "VALUES (" + ;
                EscaparSQL(LEFT(THIS.this_cChaves, 20))     + ", " + ;
                EscaparSQL(LEFT(THIS.this_cCpros, 14))      + ", " + ;
                FormatarDataSQL(THIS.this_dDatas)            + ", " + ;
                EscaparSQL(LEFT(THIS.this_cDopes, 20))      + ", " + ;
                EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cEmps, 3))        + ", " + ;
                EscaparSQL(LEFT(THIS.this_cIclis, 10))      + ", " + ;
                EscaparSQL(LEFT(THIS.this_cMoedas, 3))      + ", " + ;
                FormatarNumeroSQL(THIS.this_nNumes, 0)      + ", " + ;
                FormatarNumeroSQL(THIS.this_nValors, 2)     + ", " + ;
                FormatarNumeroSQL(THIS.this_nQtds, 0)       + ")"

            IF SQLEXEC(gnConnHandle, m.loc_cSQL) > 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir registro em SigOpClU.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCccBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - atualiza registro em SigOpClU pela chave cidchaves
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigOpClU SET " + ;
                "cpros      = " + EscaparSQL(LEFT(THIS.this_cCpros, 14))      + ", " + ;
                "datas      = " + FormatarDataSQL(THIS.this_dDatas)            + ", " + ;
                "dopes      = " + EscaparSQL(LEFT(THIS.this_cDopes, 20))      + ", " + ;
                "empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + ", " + ;
                "emps       = " + EscaparSQL(LEFT(THIS.this_cEmps, 3))        + ", " + ;
                "iclis      = " + EscaparSQL(LEFT(THIS.this_cIclis, 10))      + ", " + ;
                "moedas     = " + EscaparSQL(LEFT(THIS.this_cMoedas, 3))      + ", " + ;
                "numes      = " + FormatarNumeroSQL(THIS.this_nNumes, 0)      + ", " + ;
                "valors     = " + FormatarNumeroSQL(THIS.this_nValors, 2)     + ", " + ;
                "qtds       = " + FormatarNumeroSQL(THIS.this_nQtds, 0)       + " " + ;
                "WHERE cidchaves = " + EscaparSQL(THIS.this_cChaves)

            IF SQLEXEC(gnConnHandle, m.loc_cSQL) > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar registro em SigOpClU.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCccBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - retorna cidchaves do registro atual (para auditoria)
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cChaves
    ENDPROC

    *==========================================================================
    * RecalcularSaldosConta - recalcula saldos em SigMvCcr
    * Processa movimentos em ordem cronologica e atualiza saldos acumulados
    *==========================================================================
    PROCEDURE RecalcularSaldosConta()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere
        LOCAL loc_nSaldo, loc_nRecs, loc_cKeyAnt, loc_cKey

        loc_lSucesso = .F.
        loc_nRecs    = 0

        TRY
            loc_cWhere = " WHERE 1=1"
            IF !EMPTY(THIS.this_cEmpConta)
                loc_cWhere = loc_cWhere + " AND emps = " + EscaparSQL(THIS.this_cEmpConta)
            ENDIF
            IF !EMPTY(THIS.this_cGrupoConta)
                loc_cWhere = loc_cWhere + " AND grupos = " + EscaparSQL(THIS.this_cGrupoConta)
            ENDIF
            IF !EMPTY(THIS.this_cConta)
                loc_cWhere = loc_cWhere + " AND contas = " + EscaparSQL(THIS.this_cConta)
            ENDIF
            IF !EMPTY(THIS.this_cMoedaConta)
                loc_cWhere = loc_cWhere + " AND moedas = " + EscaparSQL(THIS.this_cMoedaConta)
            ENDIF
            IF !EMPTY(THIS.this_dDataConta)
                loc_cWhere = loc_cWhere + " AND datas >= " + FormatarDataSQL(THIS.this_dDataConta)
            ENDIF

            loc_cSQL = "SELECT cidchaves, emps, grupos, contas, moedas, " + ;
                       "       datas, numes, opers, valors " + ;
                       "FROM SigMvCcr" + m.loc_cWhere + ;
                       " ORDER BY emps, grupos, contas, moedas, datas, numes"

            IF SQLEXEC(gnConnHandle, m.loc_cSQL, "cursor_4c_CcrRec") > 0
                IF USED("cursor_4c_CcrRec") AND RECCOUNT("cursor_4c_CcrRec") > 0
                    loc_nSaldo  = 0
                    loc_cKeyAnt = ""
                    SELECT cursor_4c_CcrRec
                    SCAN
                        loc_cKey = ALLTRIM(emps) + ALLTRIM(grupos) + ALLTRIM(contas) + ALLTRIM(moedas)
                        IF loc_cKey != loc_cKeyAnt
                            loc_nSaldo  = 0
                            loc_cKeyAnt = loc_cKey
                        ENDIF
                        IF UPPER(ALLTRIM(opers)) = "E"
                            loc_nSaldo = loc_nSaldo + valors
                        ELSE
                            loc_nSaldo = loc_nSaldo - valors
                        ENDIF
                        loc_cSQL = "UPDATE SigMvCcr SET saldos = " + ;
                                   FormatarNumeroSQL(m.loc_nSaldo, 2) + ;
                                   " WHERE cidchaves = " + EscaparSQL(cidchaves)
                        SQLEXEC(gnConnHandle, m.loc_cSQL)
                        loc_nRecs = loc_nRecs + 1
                    ENDSCAN
                    THIS.this_nRegistros = THIS.this_nRegistros + loc_nRecs
                ENDIF
                IF USED("cursor_4c_CcrRec")
                    USE IN cursor_4c_CcrRec
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao buscar registros de SigMvCcr.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCccBO.RecalcularSaldosConta")
            IF USED("cursor_4c_CcrRec")
                USE IN cursor_4c_CcrRec
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * RecalcularSaldosEstoque - recalcula sqtds em SigMvHst
    * Processa movimentos em ordem e atualiza saldo acumulado de quantidade
    *==========================================================================
    PROCEDURE RecalcularSaldosEstoque()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere
        LOCAL loc_nSqtds, loc_nRecs, loc_cKeyAnt, loc_cKey

        loc_lSucesso = .F.
        loc_nRecs    = 0

        TRY
            loc_cWhere = " WHERE 1=1"
            IF !EMPTY(THIS.this_cEmpEst)
                loc_cWhere = loc_cWhere + " AND emps = " + EscaparSQL(THIS.this_cEmpEst)
            ENDIF
            IF !EMPTY(THIS.this_cGrupoEst)
                loc_cWhere = loc_cWhere + " AND grupos = " + EscaparSQL(THIS.this_cGrupoEst)
            ENDIF
            IF !EMPTY(THIS.this_cEstoque)
                loc_cWhere = loc_cWhere + " AND estos = " + EscaparSQL(THIS.this_cEstoque)
            ENDIF
            IF !EMPTY(THIS.this_cProdEst)
                loc_cWhere = loc_cWhere + " AND cpros = " + EscaparSQL(THIS.this_cProdEst)
            ENDIF
            IF !EMPTY(THIS.this_dDataEst)
                loc_cWhere = loc_cWhere + " AND datas >= " + FormatarDataSQL(THIS.this_dDataEst)
            ENDIF

            loc_cSQL = "SELECT cidchaves, cpros, emps, grupos, estos, " + ;
                       "       datas, numes, opers, qtds, sqtds " + ;
                       "FROM SigMvHst" + m.loc_cWhere + ;
                       " ORDER BY cpros, emps, grupos, estos, datas, numes"

            IF SQLEXEC(gnConnHandle, m.loc_cSQL, "cursor_4c_HstRec") > 0
                IF USED("cursor_4c_HstRec") AND RECCOUNT("cursor_4c_HstRec") > 0
                    loc_nSqtds  = 0
                    loc_cKeyAnt = ""
                    SELECT cursor_4c_HstRec
                    SCAN
                        loc_cKey = ALLTRIM(cpros) + ALLTRIM(emps) + ALLTRIM(grupos) + ALLTRIM(estos)
                        IF loc_cKey != loc_cKeyAnt
                            loc_nSqtds  = 0
                            loc_cKeyAnt = loc_cKey
                        ENDIF
                        IF UPPER(ALLTRIM(opers)) = "E"
                            loc_nSqtds = loc_nSqtds + qtds
                        ELSE
                            loc_nSqtds = loc_nSqtds - qtds
                        ENDIF
                        loc_cSQL = "UPDATE SigMvHst SET sqtds = " + ;
                                   FormatarNumeroSQL(m.loc_nSqtds, 3) + ;
                                   " WHERE cidchaves = " + EscaparSQL(cidchaves)
                        SQLEXEC(gnConnHandle, m.loc_cSQL)
                        loc_nRecs = loc_nRecs + 1
                    ENDSCAN
                    THIS.this_nRegistros = THIS.this_nRegistros + loc_nRecs
                ENDIF
                IF USED("cursor_4c_HstRec")
                    USE IN cursor_4c_HstRec
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao buscar registros de SigMvHst.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCccBO.RecalcularSaldosEstoque")
            IF USED("cursor_4c_HstRec")
                USE IN cursor_4c_HstRec
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * RecalcularSaldosCusto - recalcula custofs em SigCdPro
    * Media ponderada de custo a partir dos movimentos de entrada em SigMvHst
    *==========================================================================
    PROCEDURE RecalcularSaldosCusto()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nRecs

        loc_lSucesso = .F.
        loc_nRecs    = 0

        TRY
            loc_cWhere = " WHERE opers = 'E' AND units > 0 AND qtds > 0"
            IF !EMPTY(THIS.this_cEmpCusto)
                loc_cWhere = loc_cWhere + " AND emps = " + EscaparSQL(THIS.this_cEmpCusto)
            ENDIF
            IF !EMPTY(THIS.this_cProdCusto)
                loc_cWhere = loc_cWhere + " AND cpros = " + EscaparSQL(THIS.this_cProdCusto)
            ENDIF
            IF !EMPTY(THIS.this_dDataCusto)
                loc_cWhere = loc_cWhere + " AND datas >= " + FormatarDataSQL(THIS.this_dDataCusto)
            ENDIF

            loc_cSQL = "SELECT cpros, " + ;
                       "       SUM(qtds * units) / NULLIF(SUM(qtds), 0) AS custofsMedio " + ;
                       "FROM SigMvHst" + m.loc_cWhere + ;
                       " GROUP BY cpros"

            IF SQLEXEC(gnConnHandle, m.loc_cSQL, "cursor_4c_CustoRec") > 0
                IF USED("cursor_4c_CustoRec") AND RECCOUNT("cursor_4c_CustoRec") > 0
                    SELECT cursor_4c_CustoRec
                    SCAN
                        IF !ISNULL(custofsMedio) AND custofsMedio > 0
                            loc_cSQL = "UPDATE SigCdPro SET custofs = " + ;
                                       FormatarNumeroSQL(custofsMedio, 3) + ;
                                       " WHERE cpros = " + EscaparSQL(cpros)
                            SQLEXEC(gnConnHandle, m.loc_cSQL)
                            loc_nRecs = loc_nRecs + 1
                        ENDIF
                    ENDSCAN
                    THIS.this_nRegistros = THIS.this_nRegistros + loc_nRecs
                ENDIF
                IF USED("cursor_4c_CustoRec")
                    USE IN cursor_4c_CustoRec
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao calcular custo de produto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCccBO.RecalcularSaldosCusto")
            IF USED("cursor_4c_CustoRec")
                USE IN cursor_4c_CustoRec
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * RecalcularSaldosCompra - atualiza SigOpClU com ultima compra por produto
    * Localiza a entrada mais recente em SigMvHst e atualiza SigOpClU
    *==========================================================================
    PROCEDURE RecalcularSaldosCompra()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nRecs
        LOCAL loc_cChkSQL, loc_cUpSQL, loc_cPros, loc_cEmps

        loc_lSucesso = .F.
        loc_nRecs    = 0

        TRY
            loc_cWhere = " WHERE opers = 'E'"
            IF !EMPTY(THIS.this_cEmpCompra)
                loc_cWhere = loc_cWhere + " AND emps = " + EscaparSQL(THIS.this_cEmpCompra)
            ENDIF
            IF !EMPTY(THIS.this_cProdCompra)
                loc_cWhere = loc_cWhere + " AND cpros = " + EscaparSQL(THIS.this_cProdCompra)
            ENDIF
            IF !EMPTY(THIS.this_dDataCompra)
                loc_cWhere = loc_cWhere + " AND datas >= " + FormatarDataSQL(THIS.this_dDataCompra)
            ENDIF

            loc_cSQL = "SELECT cpros, emps, " + ;
                       "       MAX(datas) AS ultimaData, " + ;
                       "       MAX(numes) AS ultimoNume " + ;
                       "FROM SigMvHst" + m.loc_cWhere + ;
                       " GROUP BY cpros, emps"

            IF SQLEXEC(gnConnHandle, m.loc_cSQL, "cursor_4c_CompraGrp") > 0
                IF USED("cursor_4c_CompraGrp") AND RECCOUNT("cursor_4c_CompraGrp") > 0
                    SELECT cursor_4c_CompraGrp
                    SCAN
                        loc_cPros = ALLTRIM(cpros)
                        loc_cEmps = ALLTRIM(emps)

                        *-- Busca detalhe do movimento mais recente
                        loc_cSQL = "SELECT TOP 1 cidchaves, cpros, emps, datas, numes, " + ;
                                   "            valors, qtds, moedas, dopes, empdopnums " + ;
                                   "FROM SigMvHst " + ;
                                   "WHERE cpros = " + EscaparSQL(m.loc_cPros) + ;
                                   "  AND emps = "  + EscaparSQL(m.loc_cEmps) + ;
                                   "  AND opers = 'E' " + ;
                                   "ORDER BY datas DESC, numes DESC"

                        IF SQLEXEC(gnConnHandle, m.loc_cSQL, "cursor_4c_CompraUlt") > 0
                            IF USED("cursor_4c_CompraUlt") AND RECCOUNT("cursor_4c_CompraUlt") > 0
                                SELECT cursor_4c_CompraUlt

                                *-- Verificar se ja existe registro em SigOpClU
                                loc_cChkSQL = "SELECT cidchaves FROM SigOpClU " + ;
                                              "WHERE cpros = " + EscaparSQL(m.loc_cPros) + ;
                                              "  AND emps = "  + EscaparSQL(m.loc_cEmps)
                                IF SQLEXEC(gnConnHandle, m.loc_cChkSQL, "cursor_4c_CompraChk") > 0
                                    IF USED("cursor_4c_CompraChk") AND RECCOUNT("cursor_4c_CompraChk") > 0
                                        *-- UPDATE
                                        SELECT cursor_4c_CompraUlt
                                        loc_cUpSQL = "UPDATE SigOpClU SET " + ;
                                            "datas      = " + FormatarDataSQL(datas)          + ", " + ;
                                            "numes      = " + FormatarNumeroSQL(numes, 0)     + ", " + ;
                                            "valors     = " + FormatarNumeroSQL(valors, 2)    + ", " + ;
                                            "qtds       = " + FormatarNumeroSQL(qtds, 0)      + ", " + ;
                                            "moedas     = " + EscaparSQL(LEFT(moedas, 3))     + ", " + ;
                                            "dopes      = " + EscaparSQL(LEFT(dopes, 20))     + ", " + ;
                                            "empdopnums = " + EscaparSQL(LEFT(empdopnums, 29))+ " " + ;
                                            "WHERE cpros = " + EscaparSQL(m.loc_cPros) + ;
                                            "  AND emps = "  + EscaparSQL(m.loc_cEmps)
                                        SQLEXEC(gnConnHandle, m.loc_cUpSQL)
                                    ELSE
                                        *-- INSERT novo
                                        SELECT cursor_4c_CompraUlt
                                        THIS.this_cCpros      = LEFT(cpros, 14)
                                        THIS.this_cEmps       = LEFT(emps, 3)
                                        THIS.this_dDatas      = datas
                                        THIS.this_nNumes      = numes
                                        THIS.this_nValors     = valors
                                        THIS.this_nQtds       = qtds
                                        THIS.this_cMoedas     = LEFT(moedas, 3)
                                        THIS.this_cDopes      = LEFT(dopes, 20)
                                        THIS.this_cEmpDopNums = LEFT(empdopnums, 29)
                                        THIS.this_cIclis      = SPACE(10)
                                        THIS.Inserir()
                                    ENDIF
                                    IF USED("cursor_4c_CompraChk")
                                        USE IN cursor_4c_CompraChk
                                    ENDIF
                                    loc_nRecs = loc_nRecs + 1
                                ENDIF
                            ENDIF
                            IF USED("cursor_4c_CompraUlt")
                                USE IN cursor_4c_CompraUlt
                            ENDIF
                        ENDIF
                    ENDSCAN
                    THIS.this_nRegistros = THIS.this_nRegistros + loc_nRecs
                ENDIF
                IF USED("cursor_4c_CompraGrp")
                    USE IN cursor_4c_CompraGrp
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao buscar movimentos de compra.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCccBO.RecalcularSaldosCompra")
            IF USED("cursor_4c_CompraGrp")
                USE IN cursor_4c_CompraGrp
            ENDIF
            IF USED("cursor_4c_CompraUlt")
                USE IN cursor_4c_CompraUlt
            ENDIF
            IF USED("cursor_4c_CompraChk")
                USE IN cursor_4c_CompraChk
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

