# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-ASPAS] Linha 650: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "Where Emps = '" + LocalEmp.Cemps + "' " + ;
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: 0, GRUPOS, CONTAS, MOEDAS, EMPS, DATAS, DATACONCS, CONCS, CEMPS, CPROS, DOPES, TIPOOPS, TPGDMIS, ATUCOMPRAS, EMPDOPNUMS, ICLIS, I, GERGDMIS, MULTCOMPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'SELECAOICL' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: 0, GRUPOS, CONTAS, MOEDAS, EMPS, DATAS, DATACONCS, CONCS, CEMPS, CPROS, DOPES, TIPOOPS, TPGDMIS, ATUCOMPRAS, EMPDOPNUMS, ICLIS, I, GERGDMIS, MULTCOMPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: 0, GRUPOS, CONTAS, MOEDAS, EMPS, DATAS, DATACONCS, CONCS, CEMPS, CPROS, DOPES, TIPOOPS, TPGDMIS, ATUCOMPRAS, EMPDOPNUMS, ICLIS, I, GERGDMIS, MULTCOMPS

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrCcc.prg) - TRECHOS RELEVANTES PARA PASS SQL (1906 linhas total):

*-- Linhas 636 a 666:
636:             .BackStyle = 0
637:             .FontBold  = .T.
638:             .FontName  = "Tahoma"
639:             .FontSize  = 8
640:             .ForeColor = RGB(0, 0, 128)
641:             .Caption   = "Op" + CHR(231) + CHR(245) + "es de Estoque"
642:             .Visible   = .T.
643:         ENDWITH
644: 
645:         loc_oCnt.AddObject("lbl_4c_EmpresaEst", "Label")
646:         WITH loc_oCnt.lbl_4c_EmpresaEst
647:             .Top       = 15
648:             .Left      = 38
649:             .Width     = 71
650:             .Height    = 15
651:             .AutoSize  = .F.
652:             .BackStyle = 0
653:             .FontName  = "Tahoma"
654:             .FontSize  = 8
655:             .Caption   = "Empresa :"
656:             .Visible   = .T.
657:         ENDWITH
658:         loc_oCnt.AddObject("txt_4c_EmpresaEst", "TextBox")
659:         WITH loc_oCnt.txt_4c_EmpresaEst
660:             .Top       = 12
661:             .Left      = 112
662:             .Width     = 38
663:             .Height    = 23
664:             .FontName  = "Tahoma"
665:             .FontSize  = 8
666:             .Value     = ""


### BO (C:\4c\projeto\app\classes\SigPrCccBO.prg):
*==============================================================================
* SigPrCccBO.prg - Business Object para Rec?lculo de Saldos
* Herda de: BusinessBase
* Entidade: SigPrCcc
* Tabela principal: SigOpClU (ultima compra por cliente/produto)
*==============================================================================
DEFINE CLASS SigPrCccBO AS BusinessBase

    *-- Identificacao da entidade
    this_cTabela     = "SigOpClU"
    this_cCampoChave = "CidChaves"

    *-- Filtros secao Conta Corrente (OpConta)
    this_cEmpConta     = ""
    this_cGruposConta  = ""
    this_cContasConta  = ""
    this_cMoedasConta  = ""
    this_dDataConta    = {}

    *-- Filtros secao Estoque (OpEstoque)
    this_cEmpEstoque       = ""
    this_cGruposEstoque    = ""
    this_cEstoqueEstoque   = ""
    this_cProdutoEstoque   = ""
    this_cDescricaoEstoque = ""
    this_dDataEstoque      = {}

    *-- Filtros secao Custo de Produto (OpCusto)
    this_cEmpCusto       = ""
    this_cProdutoCusto   = ""
    this_cDescricaoCusto = ""
    this_dDataCusto      = {}

    *-- Filtros secao Ultima Compra (OpCompra)
    this_cEmpCompra       = ""
    this_cProdutoCompra   = ""
    this_cDescricaoCompra = ""
    this_dDataCompra      = {}

    *-- Flags de processamento (estado dos checkboxes)
    this_lProcessarConta   = .F.
    this_lProcessarEstoque = .F.
    this_lProcessarCusto   = .F.
    this_lProcessarCompra  = .F.

    *-- Contador de registros (exibido no txt_4c_Registro)
    this_nRegistros = 0

    *-- Conexao legada para funcoes de recalculo do Framework
    this_oDataMgr = .NULL.

    *-- Campos da tabela SigOpClU (para CRUD direto)
    this_cCidchaves   = ""
    this_cCpros       = ""
    this_dDatas       = {}
    this_cDopes       = ""
    this_cEmpdopnums  = ""
    this_cEmps        = ""
    this_cIclis       = ""
    this_cMoedas      = ""
    this_nNumes       = 0
    this_nValors      = 0
    this_nQtds        = 0

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
    *  Retorna a chave primaria (CidChaves) do registro atual.
    *  Se estiver vazia (novo registro), gera nova via SYS(2015)+SYS(2015).
    *--------------------------------------------------------------------------
        IF EMPTY(THIS.this_cCidchaves)
            RETURN SYS(2015) + SYS(2015)
        ENDIF
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparDados()
    *  Limpa propriedades da tabela SigOpClU (novo registro)
    *--------------------------------------------------------------------------
        THIS.this_cCidchaves   = ""
        THIS.this_cCpros       = ""
        THIS.this_dDatas       = {}
        THIS.this_cDopes       = ""
        THIS.this_cEmpdopnums  = ""
        THIS.this_cEmps        = ""
        THIS.this_cIclis       = ""
        THIS.this_cMoedas      = ""
        THIS.this_nNumes       = 0
        THIS.this_nValors      = 0
        THIS.this_nQtds        = 0
        THIS.this_cMensagemErro = ""
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *  Carrega dados de SigOpClU do cursor para as propriedades this_*.
    *  Segue padrao canonico: SELECT (alias) + acesso direto aos campos.
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !USED(par_cAliasCursor)
                THIS.this_cMensagemErro = "Cursor '" + par_cAliasCursor + "' n" + CHR(227) + "o est" + CHR(225) + " aberto"
                loc_lSucesso = .F.
            ENDIF

            SELECT (par_cAliasCursor)

            THIS.this_cCidchaves  = TratarNulo(cidchaves,  "C")
            THIS.this_cCpros      = TratarNulo(cpros,      "C")
            THIS.this_dDatas      = TratarNulo(datas,      "D")
            THIS.this_cDopes      = TratarNulo(dopes,      "C")
            THIS.this_cEmpdopnums = TratarNulo(empdopnums, "C")
            THIS.this_cEmps       = TratarNulo(emps,       "C")
            THIS.this_cIclis      = TratarNulo(iclis,      "C")
            THIS.this_cMoedas     = TratarNulo(moedas,     "C")
            THIS.this_nNumes      = TratarNulo(numes,      "N")
            THIS.this_nValors     = TratarNulo(valors,     "N")
            THIS.this_nQtds       = TratarNulo(qtds,       "N")

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar do cursor: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
    *  Valida campos obrigatorios de SigOpClU antes de INSERT/UPDATE.
    *--------------------------------------------------------------------------
        IF EMPTY(THIS.this_cEmps)
            THIS.this_cMensagemErro = "Empresa " + CHR(233) + " obrigat" + CHR(243) + "ria"
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cDopes)
            THIS.this_cMensagemErro = "Documento " + CHR(233) + " obrigat" + CHR(243) + "rio"
            RETURN .F.
        ENDIF
        IF THIS.this_nNumes <= 0
            THIS.this_cMensagemErro = "N" + CHR(250) + "mero da opera" + CHR(231) + CHR(227) + "o " + CHR(233) + " obrigat" + CHR(243) + "rio"
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cEmpdopnums)
            THIS.this_cEmpdopnums = ALLTRIM(THIS.this_cEmps) + ALLTRIM(THIS.this_cDopes) + ;
                                    PADL(ALLTRIM(TRANSFORM(THIS.this_nNumes)), 6, "0")
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
    *  INSERT INTO SigOpClU. Gera nova CidChaves se vazia.
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cSQL, loc_nRetorno
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cCidchaves)
                THIS.this_cCidchaves = SYS(2015) + SYS(2015)
            ENDIF

            loc_cSQL = "INSERT INTO SigOpClU " + ;
                       "(cidchaves, cpros, datas, dopes, empdopnums, " + ;
                       " emps, iclis, moedas, numes, valors, qtds) " + ;
                       "VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCidchaves)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCpros))     + ", " + ;
                       IIF(EMPTY(THIS.this_dDatas), "NULL", FormatarDataSQL(THIS.this_dDatas)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDopes))     + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cEmpdopnums))+ ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cEmps))      + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cIclis))     + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cMoedas))    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumes)       + ", " + ;
                       FormatarNumeroSQL(THIS.this_nValors)      + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtds)        + ")"

            loc_nRetorno = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRetorno < 0
                THIS.this_cMensagemErro = "Falha ao inserir registro em SigOpClU"
                loc_lSucesso = .F.
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inserir: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
    *  UPDATE SigOpClU pelo cidchaves.
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cSQL, loc_nRetorno
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cCidchaves)
                THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria (cidchaves) n" + CHR(227) + "o informada"
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "UPDATE SigOpClU SET " + ;
                       "cpros = "      + EscaparSQL(ALLTRIM(THIS.this_cCpros))     + ", " + ;
                       "datas = "      + IIF(EMPTY(THIS.this_dDatas), "NULL", FormatarDataSQL(THIS.this_dDatas)) + ", " + ;
                       "dopes = "      + EscaparSQL(ALLTRIM(THIS.this_cDopes))     + ", " + ;
                       "empdopnums = " + EscaparSQL(ALLTRIM(THIS.this_cEmpdopnums))+ ", " + ;
                       "emps = "       + EscaparSQL(ALLTRIM(THIS.this_cEmps))      + ", " + ;
                       "iclis = "      + EscaparSQL(ALLTRIM(THIS.this_cIclis))     + ", " + ;
                       "moedas = "     + EscaparSQL(ALLTRIM(THIS.this_cMoedas))    + ", " + ;
                       "numes = "      + FormatarNumeroSQL(THIS.this_nNumes)       + ", " + ;
                       "valors = "     + FormatarNumeroSQL(THIS.this_nValors)      + ", " + ;
                       "qtds = "       + FormatarNumeroSQL(THIS.this_nQtds)        + " " + ;
                       "WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

            loc_nRetorno = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRetorno < 0
                THIS.this_cMensagemErro = "Falha ao atualizar registro em SigOpClU"
                loc_lSucesso = .F.
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao atualizar: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
    *  DELETE FROM SigOpClU pelo cidchaves.
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cSQL, loc_nRetorno
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cCidchaves)
                THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria (cidchaves) n" + CHR(227) + "o informada"
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "DELETE FROM SigOpClU WHERE cidchaves = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

            loc_nRetorno = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRetorno < 0
                THIS.this_cMensagemErro = "Falha ao excluir registro em SigOpClU"
                loc_lSucesso = .F.
            ELSE
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao excluir: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE InicializarConexao()
    *  Cria conexao legada para funcoes de recalculo do Framework (fSqlConector)
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF VARTYPE(THIS.this_oDataMgr) != "O" OR ISNULL(THIS.this_oDataMgr)
                THIS.this_oDataMgr = CREATEOBJECT('fSqlConector', 'RECSALDO', .T.)
                IF THIS.this_oDataMgr.pnIdConn > 0
                    THIS.this_oDataMgr.AddCursor('SigOpClU', 'CidChaves', 'CrSigOpClU')
                    THIS.this_oDataMgr.Cursorquery('SigCdPam', 'CrSigCdPam', .F., .F., ;
                        'GrupoRecs,GrupoPags,ContaRecs,ContaPags,MoeCentral')
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Imposs" + CHR(237) + "vel efetuar conex" + CHR(227) + ;
                            "o com o servidor de banco de dados.", "Erro de Conex" + CHR(227) + "o")
                ENDIF
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Processar(par_oForm)
    *  Metodo principal: executa todos os recalculos selecionados via flags
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.InicializarConexao()
                loc_lSucesso = .F.
            ELSE
                loc_lSucesso = .T.

                IF THIS.this_lProcessarConta
                    IF !THIS.ProcessarContaCorrente(par_oForm)
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF

                IF THIS.this_lProcessarEstoque
                    IF !THIS.ProcessarEstoque(par_oForm)
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF

                IF THIS.this_lProcessarCusto
                    IF !THIS.ProcessarCusto(par_oForm)
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF

                IF THIS.this_lProcessarCompra
                    IF !THIS.ProcessarUltimaCompra(par_oForm)
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarContaCorrente(par_oForm)
    *  Recalcula saldos de Conta Corrente em SigMvCcr via fRecalculaS
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cEmp, loc_cGrupo, loc_cConta, loc_cMoeda
        LOCAL loc_dData, loc_cGcm, loc_llConc, loc_cWhere, loc_cWherC
        LOCAL loc_cQuery, loc_lOk, loc_nReg, loc_oProgConta, loc_pData

        loc_lSucesso = .F.
        TRY
            loc_cEmp   = PADR(THIS.this_cEmpConta,    3)
            loc_cGrupo = PADR(THIS.this_cGruposConta, 10)
            loc_cConta = PADR(THIS.this_cContasConta, 10)
            loc_cMoeda = PADR(THIS.this_cMoedasConta,  3)
            loc_dData  = THIS.this_dDataConta
            loc_llConc = .T.
            loc_pData  = IIF(EMPTY(loc_dData), CTOD('01/01/1900'), loc_dData)
            loc_cGcm   = IIF(!EMPTY(loc_cGrupo) .AND. !EMPTY(loc_cConta) .AND. !EMPTY(loc_cMoeda), ;
                             loc_cGrupo + loc_cConta + loc_cMoeda, SPACE(23))

            loc_cWhere = "Where 0 = 0 " + ;
                IIF(!EMPTY(loc_cGrupo), "And Grupos = '" + ALLTRIM(loc_cGrupo) + "' ", " ") + ;
                IIF(!EMPTY(loc_cConta), "And Contas = '" + ALLTRIM(loc_cConta) + "' ", " ") + ;
                IIF(!EMPTY(loc_cMoeda), "And Moedas = '" + ALLTRIM(loc_cMoeda) + "' ", " ") + ;
                IIF(!EMPTY(loc_cEmp),   "And Emps = '"   + ALLTRIM(loc_cEmp)   + "' ", " ") + ;
                IIF(!EMPTY(loc_dData),  "And Datas >= "  + FormatarDataSQL(loc_dData) + " ", " ")

            loc_cWherC = "Where 0 = 0 " + ;
                IIF(!EMPTY(loc_cGrupo), "And Grupos = '"    + ALLTRIM(loc_cGrupo) + "' ", " ") + ;
                IIF(!EMPTY(loc_cConta), "And Contas = '"    + ALLTRIM(loc_cConta) + "' ", " ") + ;
                IIF(!EMPTY(loc_cMoeda), "And Moedas = '"    + ALLTRIM(loc_cMoeda) + "' ", " ") + ;
                IIF(!EMPTY(loc_cEmp),   "And Emps = '"      + ALLTRIM(loc_cEmp)   + "' ", " ") + ;
                IIF(!EMPTY(loc_dData),  "And DataConcs >= " + FormatarDataSQL(loc_dData) + " ", " ") + ;
                "And Concs = 1 "

            IF USED("TmpConta")
                USE IN TmpConta
            ENDIF
            CREATE CURSOR TmpConta (Emps C(3), Grupos C(10), Contas C(10), Moedas C(3), CidChaves C(20))
            INDEX ON CidChaves TAG CidChaves

            DO WHILE .T.
                IF !EMPTY(loc_cGcm)
                    IF EMPTY(loc_cEmp)
                        loc_cQuery = "Select Cemps From SigCdEmp"
                        IF THIS.this_oDataMgr.SqlExecute(loc_cQuery, 'TmpEmps') < 1
                            MsgErro("Falha na conex" + CHR(227) + "o (TmpEmps)", "Erro")
                            EXIT
                        ENDIF
                        SELECT TmpEmps
                        GO TOP
                        SCAN
                            INSERT INTO TmpConta (Emps, Grupos, Contas, Moedas, CidChaves) ;
                                VALUES (TmpEmps.Cemps, loc_cGrupo, loc_cConta, ;
                                        loc_cMoeda, SYS(2015)+SYS(2015))
                            SELECT TmpEmps
                        ENDSCAN
                        IF USED("TmpEmps")
                            USE IN TmpEmps
                        ENDIF
                    ELSE
                        INSERT INTO TmpConta (Emps, Grupos, Contas, Moedas, CidChaves) ;
                            VALUES (loc_cEmp, loc_cGrupo, loc_cConta, ;
                                    loc_cMoeda, SYS(2015)+SYS(2015))
                    ENDIF
                ELSE
                    loc_cQuery = "Select Distinct Emps, Grupos, Contas, Moedas, " + ;
                                 "Space(20) as CidChaves From SigMvCcr " + loc_cWhere + ;
                                 " Union all " + ;
                                 "Select Distinct Emps, Grupos, Contas, Moedas, " + ;
                                 "Space(20) as CidChaves From SigMvCcr " + loc_cWherC
                    IF THIS.this_oDataMgr.SqlExecute(loc_cQuery, 'TmpConta') < 1
                        MsgErro("Falha na conex" + CHR(227) + "o (TmpConta)", "Erro")
                        EXIT
                    ENDIF
                    SELECT TmpConta
                    REPLACE ALL CidChaves WITH SYS(2015)+SYS(2015)
                    INDEX ON CidChaves TAG Cidchaves
                ENDIF

                *-- Processa os registros de TmpConta
                DO WHILE .T.
                    SELECT * FROM TmpConta INTO CURSOR Selecao ORDER BY Emps, Grupos, Contas, Moedas
                    SELECT Selecao
                    IF RECCOUNT() = 0
                        EXIT
                    ENDIF

                    loc_nReg      = RECCOUNT('Selecao')
                    loc_oProgConta = CREATEOBJECT('fwprogressbar', ;
                        'Recalculando Saldo de Conta Corrente', loc_nReg)
                    loc_oProgConta.Titulo.FontBold = .T.
                    loc_oProgConta.Show

                    SCAN
                        loc_nReg = loc_nReg - 1
                        THIS.this_nRegistros = loc_nReg
                        IF VARTYPE(par_oForm) = "O" .AND. !ISNULL(par_oForm)
                            par_oForm.txt_4c_Registro.Value = loc_nReg
                            par_oForm.txt_4c_Registro.Refresh
                        ENDIF
                        loc_oProgConta.Update(.T.)
                        loc_oProgConta.SubTitulo.Caption = ALLTRIM(Selecao.Grupos) + " : " + ;
                            ALLTRIM(Selecao.Contas) + "-" + ALLTRIM(Selecao.Moedas)

                        =fRecalculaS(Selecao.Grupos, Selecao.Contas, loc_pData, Selecao.Moedas)
                        loc_lOk = fRecalculaS(.T., THIS.this_oDataMgr, .T.)
                        IF !loc_lOk
                            THIS.this_oDataMgr.Rollback()
                            LOOP
                        ENDIF
                        loc_lOk = (THIS.this_oDataMgr.Commit() > 0)
                        IF !loc_lOk
                            THIS.this_oDataMgr.Rollback()
                            LOOP
                        ENDIF

                        SELECT TmpConta
                        IF SEEK(Selecao.CidChaves)
                            DELETE
                        ENDIF
                    ENDSCAN

                    loc_oProgConta.Complete(.T.)
                    IF USED("Selecao")
                        USE IN Selecao
                    ENDIF
                ENDDO

                loc_lSucesso = .T.
                EXIT
            ENDDO

            IF USED("TmpConta")
                USE IN TmpConta
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarEstoque(par_oForm)
    *  Recalcula saldos de Estoque em SigMvHst via fRecalculaP
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cEstoque, loc_cEmpresa, loc_cGrupo, loc_cProduto
        LOCAL loc_dData, loc_cWhere, loc_cQuery, loc_lOk, loc_nReg, loc_oProgConta
        LOCAL loc_cEmpIni, loc_cGruIni, loc_cEstIni, loc_cEmpFin, loc_cGruFin, loc_cEstFin
        LOCAL loc_pData

        loc_lSucesso = .F.
        TRY
            loc_cEstoque = PADR(THIS.this_cEstoqueEstoque, 10)
            loc_cEmpresa = PADR(THIS.this_cEmpEstoque,     3)
            loc_cGrupo   = PADR(THIS.this_cGruposEstoque,  10)
            loc_cProduto = PADR(THIS.this_cProdutoEstoque, 14)
            loc_dData    = THIS.this_dDataEstoque
            loc_pData    = IIF(EMPTY(loc_dData), CTOD('01/01/1900'), loc_dData)

            DO CASE
                CASE !EMPTY(loc_cEmpresa) .AND. !EMPTY(loc_cGrupo) .AND. !EMPTY(loc_cEstoque)
                    loc_cWhere = "EmpGruEsts = '" + loc_cEmpresa + loc_cGrupo + loc_cEstoque + "' "
                CASE EMPTY(loc_cEmpresa) .AND. EMPTY(loc_cGrupo) .AND. EMPTY(loc_cEstoque)
                    loc_cWhere = ""
                OTHERWISE
                    loc_cEmpIni = IIF(EMPTY(loc_cEmpresa), SPACE(3),  loc_cEmpresa)
                    loc_cGruIni = IIF(EMPTY(loc_cGrupo),   SPACE(10), loc_cGrupo)
                    loc_cEstIni = IIF(EMPTY(loc_cEstoque),  SPACE(10), loc_cEstoque)
                    loc_cEmpFin = IIF(EMPTY(loc_cEmpresa), REPLICATE(CHR(254), 3),  loc_cEmpresa)
                    loc_cGruFin = IIF(EMPTY(loc_cGrupo),   REPLICATE(CHR(254), 10), loc_cGrupo)
                    loc_cEstFin = IIF(EMPTY(loc_cEstoque),  REPLICATE(CHR(254), 10), loc_cEstoque)
                    loc_cWhere  = "EmpGruEsts Between '" + ;
                                  loc_cEmpIni + loc_cGruIni + loc_cEstIni + "' And '" + ;
                                  loc_cEmpFin + loc_cGruFin + loc_cEstFin + "' "
            ENDCASE

            loc_cWhere = IIF(!EMPTY(loc_cProduto), ;
                IIF(!EMPTY(loc_cWhere), loc_cWhere + " And ", "") + ;
                " CPros = '" + ALLTRIM(loc_cProduto) + "' ", loc_cWhere)
            loc_cWhere = IIF(!EMPTY(loc_dData), ;
                IIF(!EMPTY(loc_cWhere), loc_cWhere + " And ", "") + ;
                " Datas >= " + FormatarDataSQL(loc_dData), loc_cWhere)
            loc_cWhere = IIF(!EMPTY(loc_cWhere), "Where " + loc_cWhere, "")

            loc_cQuery = "Select Distinct Emps, Grupos, Estos, Cpros, CodCors, CodTams, " + ;
                         "Space(20) as CidChaves From SigMvHst " + loc_cWhere

            DO WHILE .T.
                IF THIS.this_oDataMgr.SqlExecute(loc_cQuery, 'TmpEst') < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (TmpEst)", "Erro")
                    EXIT
                ENDIF

                SELECT TmpEst
                REPLACE ALL CidChaves WITH SYS(2015)+SYS(2015)
                INDEX ON CidChaves TAG CidChaves

                DO WHILE .T.
                    SELECT * FROM TmpEst INTO CURSOR Selecao
                    IF RECCOUNT('Selecao') = 0
                        EXIT
                    ENDIF

                    SELECT Selecao
                    loc_nReg       = RECCOUNT('Selecao')
                    loc_oProgConta = CREATEOBJECT('fwprogressbar', ;
                        'Recalculando Saldo do Estoque', loc_nReg)
                    loc_oProgConta.Titulo.FontBold = .T.
                    loc_oProgConta.Show

                    SCAN
                        loc_nReg = loc_nReg - 1
                        THIS.this_nRegistros = loc_nReg
                        IF VARTYPE(par_oForm) = "O" .AND. !ISNULL(par_oForm)
                            par_oForm.txt_4c_Registro.Value = loc_nReg
                            par_oForm.txt_4c_Registro.Refresh
                        ENDIF
                        loc_oProgConta.Update(.T.)

                        =fRecalculaP(Selecao.Emps, Selecao.Grupos, Selecao.Estos, ;
                                     Selecao.CPros, loc_pData, Selecao.CodCors, ;
                                     Selecao.CodTams, THIS.this_oDataMgr)
                        loc_lOk = fRecalculaP(.T., THIS.this_oDataMgr, .T.)
                        IF !loc_lOk
                            THIS.this_oDataMgr.Rollback()
                            LOOP
                        ENDIF
                        loc_lOk = (THIS.this_oDataMgr.Commit() > 0)
                        IF !loc_lOk
                            THIS.this_oDataMgr.Rollback()
                            LOOP
                        ENDIF

                        SELECT TmpEst
                        IF SEEK(Selecao.CidChaves)
                            DELETE
                        ENDIF
                    ENDSCAN

                    loc_oProgConta.Complete(.T., .T.)
                    IF USED("Selecao")
                        USE IN Selecao
                    ENDIF
                ENDDO

                loc_lSucesso = .T.
                EXIT
            ENDDO

            IF USED("TmpEst")
                USE IN TmpEst
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarCusto(par_oForm)
    *  Recalcula custo de produtos via fRecalculaC
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cEmp, loc_cPro, loc_dDat, loc_cQuery
        LOCAL loc_llEmp, loc_nReg, loc_lOk, loc_oCusto, loc_lParou

        loc_lSucesso = .F.
        TRY
            loc_cEmp = PADR(THIS.this_cEmpCusto,    3)
            loc_cPro = PADR(THIS.this_cProdutoCusto, 14)
            loc_dDat = THIS.this_dDataCusto

            loc_cQuery = "Select Cemps From SigCdEmp " + ;
                         "Where Not Cemps = Space(3)" + ;
                         IIF(EMPTY(loc_cEmp), "", " And Cemps = '" + ALLTRIM(loc_cEmp) + "'")

            DO WHILE .T.
                IF THIS.this_oDataMgr.SqlExecute(loc_cQuery, 'LocalEmp') < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (LocalEmp)", "Erro")
                    EXIT
                ENDIF

                loc_cQuery = "Select Calccustos From SigCdPac"
                IF THIS.this_oDataMgr.SqlExecute(loc_cQuery, 'LocalParac') < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (LocalParac)", "Erro")
                    EXIT
                ENDIF
                loc_llEmp = (LocalParac.CalcCustos <> 1)

                loc_cQuery = "Select Cpros From SigCdPro " + ;
                             "Where Not Cpros = Space(14)" + ;
                             IIF(EMPTY(loc_cPro), "", " And Cpros = '" + ALLTRIM(loc_cPro) + "'")
                IF THIS.this_oDataMgr.SqlExecute(loc_cQuery, 'LocalPro2') < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (LocalPro2)", "Erro")
                    EXIT
                ENDIF

                loc_lParou = .F.
                SELECT LocalEmp
                SCAN
                    IF loc_llEmp
                        loc_cQuery = "Select Distinct Cpros From SigMvEst " + ;
                                     "Where Emps = '" + LocalEmp.Cemps + "' " + ;
                                     "And Not Cpros = Space(14)" + ;
                                     IIF(EMPTY(loc_cPro), "", " And Cpros = '" + ALLTRIM(loc_cPro) + "'")
                        IF THIS.this_oDataMgr.SqlExecute(loc_cQuery, 'LocalPro') < 1
                            MsgErro("Falha na conex" + CHR(227) + "o (LocalPro)", "Erro")
                            loc_lParou = .T.
                            EXIT
                        ENDIF
                    ELSE
                        SELECT * FROM LocalPro2 INTO CURSOR LocalPro READWRITE
                    ENDIF

                    loc_nReg  = RECCOUNT('LocalPro')
                    loc_oCusto = CREATEOBJECT('fwprogressbar', ;
                        'Preparando Arquivo de Rec' + CHR(225) + 'lculo do Custo de Produtos', ;
                        loc_nReg)
                    loc_oCusto.Titulo.FontBold = .T.
                    loc_oCusto.Show

                    SELECT LocalPro
                    SCAN
                        loc_nReg = loc_nReg - 1
                        THIS.this_nRegistros = loc_nReg
                        IF VARTYPE(par_oForm) = "O" .AND. !ISNULL(par_oForm)
                            par_oForm.txt_4c_Registro.Value = loc_nReg
                            par_oForm.txt_4c_Registro.Refresh
                        ENDIF
                        loc_oCusto.SubTitulo.Caption = "Empresa : " + LocalEmp.Cemps + ;
                                                        " - Produto : " + LocalPro.CPros
                        loc_oCusto.Update(.T.)

                        =fRecalculaC(LocalEmp.Cemps, LocalPro.CPros, loc_dDat, THIS.this_oDataMgr)
                        loc_lOk = fRecalculaC(.T., .T., .F., THIS.this_oDataMgr, .T.)
                        IF !loc_lOk
                            THIS.this_oDataMgr.Rollback()
                            LOOP
                        ENDIF
                        loc_lOk = (THIS.this_oDataMgr.Commit() > 0)
                        IF !loc_lOk
                            THIS.this_oDataMgr.Rollback()
                            LOOP
                        ENDIF
                    ENDSCAN

                    loc_oCusto.Complete(.T., .T.)

                    IF USED("LocalPro")
                        USE IN LocalPro
                    ENDIF
                    IF !loc_llEmp
                        EXIT
                    ENDIF
                ENDSCAN

                IF USED("LocalEmp")
                    USE IN LocalEmp
                ENDIF
                IF USED("LocalPro2")
                    USE IN LocalPro2
                ENDIF
                IF USED("LocalParac")
                    USE IN LocalParac
                ENDIF

                IF !loc_lParou
                    loc_lSucesso = .T.
                ENDIF
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarUltimaCompra(par_oForm)
    *  Reconstroi SigOpClU e atualiza SigCdCli/SigCdPro com ultima compra
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cEmp, loc_cPro, loc_dDat, loc_cSql
        LOCAL loc_nReg, loc_oCusto, loc_cConta, loc_lOk
        LOCAL loc_lnCotaCentral, loc_lnCotaOperac, loc_lnValorCentral, loc_lnValor
        LOCAL loc_cMoeda, loc_ldData, loc_cUpDate

        loc_lSucesso = .F.
        TRY
            *-- Limpa cursor principal de ultima compra
            IF USED("CrSigOpClU")
                SELECT CrSigOpClU
                ZAP
            ENDIF

            loc_cEmp = PADR(THIS.this_cEmpCompra,    3)
            loc_cPro = PADR(THIS.this_cProdutoCompra, 14)
            loc_dDat = THIS.this_dDataCompra

            DO WHILE .T.
                *-- Seleciona movimentos de cabecalho com operacoes de compra
                loc_cSql = "Select a.datas, a.Emps, a.Dopes, a.Numes, a.EmpDopNums, " + ;
                           "a.Valos, a.Contads, a.ContaOs, " + ;
                           "c.GerGdmis, c.atuCompras, c.TpGdmis, b.cOpers, b.cmoes " + ;
                           "From SigMvCab a, SigCdOpe b, SigCdTom c " + ;
                           "Where a.Dopes = b.Dopes And b.TipoOps = c.Codigos And " + ;
                           "((c.GerGdmis = 1 And c.TpGdmis = 1) Or " + ;
                           "(c.GerGdmis = 2 And c.AtuCompras = 1)) " + ;
                           IIF(!EMPTY(loc_dDat), "And a.Datas >= " + FormatarDataSQL(loc_dDat) + " ", "") + ;
                           IIF(!EMPTY(loc_cEmp), "And a.Emps = '" + ALLTRIM(loc_cEmp) + "' ", "")
                IF THIS.this_oDataMgr.SqlExecute(loc_cSql, 'TprMvCab') < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (TprMvCab)", "Erro")
                    EXIT
                ENDIF

                *-- Seleciona itens dos movimentos de compra por produto
                loc_cSql = "Select Emps, Dopes, Numes, EmpDopNums, Cpros, Units, Moedas " + ;
                           "From SigMvItn " + ;
                           "Where EmpDopNums in (" + ;
                           "Select EmpDopNums From SigMvCab a, SigCdOpe b, SigCdTom c " + ;
                           "Where a.Dopes = b.Dopes And b.TipoOps = c.Codigos And " + ;
                           "c.GerGdmis = 2 And c.AtuCompras = 1 " + ;
                           IIF(!EMPTY(loc_dDat), "And a.Datas >= " + FormatarDataSQL(loc_dDat) + " ", "") + ;
                           IIF(!EMPTY(loc_cEmp), "And a.Emps = '" + ALLTRIM(loc_cEmp) + "' ", "") + ;
                           ") "
                IF THIS.this_oDataMgr.SqlExecute(loc_cSql, 'crTpmMvItn') < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (crTpmMvItn)", "Erro")
                    EXIT
                ENDIF

                *-- Carrega registros existentes em SigOpClU para verificar duplicidade
                loc_cSql = "Select EmpDopNums From SigOpClU"
                IF THIS.this_oDataMgr.SqlExecute(loc_cSql, 'LocCalcU') < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (LocCalcU)", "Erro")
                    EXIT
                ENDIF

                SELECT LocCalcU
                INDEX ON EmpDopNums TAG EmpDopNums
                SELECT TprMvCab
                INDEX ON EmpDopNums TAG EmpDopNums
                SELECT crTpmMvItn
                INDEX ON EmpDopNums TAG EmpDopNums

                loc_nReg  = RECCOUNT('TprMvCab')
                loc_oCusto = CREATEOBJECT('fwprogressbar', ;
                    'Preparando Arquivo de Atualiza' + CHR(231) + CHR(227) + ;
                    'o da Ultima Compra', loc_nReg)
                loc_oCusto.Titulo.FontBold = .T.
                loc_oCusto.Show

                SELECT TprMvCab
                SCAN
                    loc_nReg = loc_nReg - 1
                    THIS.this_nRegistros = loc_nReg
                    IF VARTYPE(par_oForm) = "O" .AND. !ISNULL(par_oForm)
                        par_oForm.txt_4c_Registro.Value = loc_nReg
                        par_oForm.txt_4c_Registro.Refresh
                    ENDIF
                    loc_oCusto.SubTitulo.Caption = TprMvCab.Emps + " " + ;
                        TprMvCab.Dopes + " " + STR(TprMvCab.Numes, 6)
                    loc_oCusto.Update(.T.)

                    IF SEEK(TprMvCab.EmpDopNums, 'LocCalcU', 'EmpdopNums')
                        LOOP
                    ENDIF

                    *-- Tipo 1: movimento de conta corrente
                    IF (TprMvCab.GerGdmis = 1 .AND. TprMvCab.TpGdmis = 1)
                        loc_cConta = IIF(TprMvCab.Copers = 1, TprMvCab.Contads, TprMvCab.Contaos)

                        IF USED("crSigCdPam") .AND. TprMvCab.CMoes # crSigCdPam.MoeCentral
                            loc_lnCotaCentral  = fBuscarCotacao(crSigCdPam.MoeCentral, ;
                                                     TprMvCab.Datas, THIS.this_oDataMgr)
                            loc_lnCotaOperac   = fBuscarCotacao(TprMvCab.CMoes, ;
                                                     TprMvCab.Datas, THIS.this_oDataMgr)
                            loc_lnValorCentral = ROUND(TprMvCab.Valos * loc_lnCotaOperac / ;
                                                       loc_lnCotaCentral, 2)
                        ELSE
                            loc_lnValorCentral = TprMvCab.Valos
                        ENDIF

                        loc_ldData = TprMvCab.Datas
                        INSERT INTO CrSigOpClU ;
                            (Emps, Dopes, Numes, EmpdopNums, iclis, Valors, Datas, Cidchaves) ;
                            VALUES (TprMvCab.Emps, TprMvCab.Dopes, TprMvCab.Numes, ;
                                    TprMvCab.EmpdopNums, loc_cConta, loc_lnValorCentral, ;
                                    loc_ldData, fUniqueIds())
                    ENDIF

                    *-- Tipo 2: movimento de itens (produtos)
                    IF (TprMvCab.GerGdmis = 2 .AND. TprMvCab.AtuCompras = 1)
                        SELECT crTpmMvItn
                        =SEEK(TprMvCab.EmpDopNums)
                        SCAN WHILE EmpdopNums = TprMvCab.EmpDopNums
                            IF EMPTY(Cpros)
                                LOOP
                            ENDIF

                            loc_cSql = "Select Cpros, UltComps From SigCdPro " + ;
                                       "Where Cpros = '" + ALLTRIM(crTpmMvItn.Cpros) + "'"
                            IF THIS.this_oDataMgr.SqlExecute(loc_cSql, 'TmpPro') < 1
                                MsgErro("Falha na conex" + CHR(227) + "o (SigCdPro)", "Erro")
                                LOOP
                            ENDIF

                            loc_ldData  = TprMvCab.Datas
                            loc_lnValor = crTpmMvItn.Units
                            loc_cMoeda  = crTpmMvItn.Moedas

                            INSERT INTO CrSigOpClU ;
                                (Emps, Dopes, Numes, empDopNums, cpros, Valors, ;
                                 Datas, Moedas, Cidchaves) ;
                                VALUES (TprMvCab.Emps, TprMvCab.Dopes, TprMvCab.Numes, ;
                                        TprMvCab.EmpdopNums, crTpmMvItn.Cpros, loc_lnValor, ;
                                        loc_ldData, loc_cMoeda, fUniqueIds())
                        ENDSCAN
                    ENDIF
                ENDSCAN

                loc_oCusto.Complete(.T., .T.)

                *-- Persiste CrSigOpClU no banco
                IF !THIS.this_oDataMgr.Update('CrSigOpClU')
                    MsgErro("Falha na conex" + CHR(227) + "o (Update CrSigOpClU)", "Erro")
                    EXIT
                ENDIF
                THIS.this_oDataMgr.Commit()

                *-- Atualiza SigCdCli: ultima compra por cliente
                loc_cSql = "Select * From SigOpClU"
                IF THIS.this_oDataMgr.SqlExecute(loc_cSql, 'CsSelecao') < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (CsSelecao)", "Erro")
                    EXIT
                ENDIF

                SELECT DISTINCT Iclis FROM CsSelecao INTO CURSOR SelecaoIclis

                loc_nReg  = RECCOUNT('SelecaoIclis')
                loc_oCusto = CREATEOBJECT('fwprogressbar', ;
                    'Atualizando Valor da Ultima Compra Clientes ', loc_nReg)
                loc_oCusto.Titulo.FontBold = .T.
                loc_oCusto.Show

                SELECT SelecaoIclis
                SCAN
                    loc_nReg = loc_nReg - 1
                    THIS.this_nRegistros = loc_nReg
                    IF VARTYPE(par_oForm) = "O" .AND. !ISNULL(par_oForm)
                        par_oForm.txt_4c_Registro.Value = loc_nReg
                        par_oForm.txt_4c_Registro.Refresh
                    ENDIF
                    loc_oCusto.SubTitulo.Caption = "Cliente " + SelecaoIclis.Iclis
                    loc_oCusto.Update(.T.)

                    loc_cConta = SelecaoIclis.Iclis

                    *-- Ultima compra pela data mais recente
                    loc_cSql = "Select Top 1 Iclis, Datas, Valors From SigOpClU " + ;
                               "Where Iclis = '" + ALLTRIM(loc_cConta) + "' Order by Datas Desc"
                    IF THIS.this_oDataMgr.SqlExecute(loc_cSql, 'LocalCalcU') < 1
                        MsgErro("Falha na conex" + CHR(227) + "o (LocalCalcU Data)", "Erro")
                        LOOP
                    ENDIF
                    loc_ldData = IIF(RECCOUNT('LocalCalcU') = 0, .NULL., LocalCalcU.Datas)
                    loc_cUpDate = "Update SigCdCli Set UltComps = " + ;
                                  IIF(ISNULL(loc_ldData), "NULL", FormatarDataSQL(loc_ldData)) + ;
                                  ", vUltComps = " + ;
                                  STR(IIF(RECCOUNT('LocalCalcU') = 0, 0, LocalCalcU.Valors), 12, 2) + ;
                                  " Where Iclis = '" + ALLTRIM(loc_cConta) + "'"
                    IF THIS.this_oDataMgr.SqlExecute(loc_cUpDate, '') < 1
                        MsgErro("Falha na conex" + CHR(227) + "o (Update SigCdCli)", "Erro")
                        LOOP
                    ENDIF

                    *-- Ultima compra pelo maior valor
                    loc_cSql = "Select Top 1 Iclis, Datas, Valors From SigOpClU " + ;
                               "Where Iclis = '" + ALLTRIM(loc_cConta) + "' Order by Valors Desc"
                    IF THIS.this_oDataMgr.SqlExecute(loc_cSql, 'LocalCalcU') < 1
                        MsgErro("Falha na conex" + CHR(227) + "o (LocalCalcU Valor)", "Erro")
                        LOOP
                    ENDIF
                    loc_ldData = IIF(RECCOUNT('LocalCalcU') = 0, .NULL., LocalCalcU.Datas)
                    loc_cUpDate = "Update SigCdCli Set dtfats = " + ;
                                  IIF(ISNULL(loc_ldData), "NULL", FormatarDataSQL(loc_ldData)) + ;
                                  ", mfats = " + ;
                                  STR(IIF(RECCOUNT('LocalCalcU') = 0, 0, LocalCalcU.Valors), 12, 2) + ;
                                  " Where Iclis = '" + ALLTRIM(loc_cConta) + "'"
                    IF THIS.this_oDataMgr.SqlExecute(loc_cUpDate, '') < 1
                        MsgErro("Falha na conex" + CHR(227) + "o (Update SigCdCli dtfats)", "Erro")
                        LOOP
                    ENDIF

                    THIS.this_oDataMgr.Commit()
                ENDSCAN

                *-- Atualiza SigCdPro: ultima compra por produto
                SELECT DISTINCT Cpros FROM CsSelecao INTO CURSOR SelecaoCpros

                loc_nReg  = RECCOUNT('SelecaoCpros')
                loc_oCusto = CREATEOBJECT('fwprogressbar', ;
                    'Atualizando Valor da Ultima Compra Produtos', loc_nReg)
                loc_oCusto.Titulo.FontBold = .T.
                loc_oCusto.Show

                SELECT SelecaoCpros
                SCAN
                    loc_nReg = loc_nReg - 1
                    THIS.this_nRegistros = loc_nReg
                    IF VARTYPE(par_oForm) = "O" .AND. !ISNULL(par_oForm)
                        par_oForm.txt_4c_Registro.Value = loc_nReg
                        par_oForm.txt_4c_Registro.Refresh
                    ENDIF
                    loc_oCusto.SubTitulo.Caption = "Produto " + SelecaoCpros.Cpros
                    loc_oCusto.Update(.T.)

                    loc_cSql = "Select Top 1 Cpros, Datas, Valors, Moedas From SigOpClU " + ;
                               "Where Cpros = '" + ALLTRIM(SelecaoCpros.Cpros) + "' " + ;
                               "Order by Datas Desc"
                    IF THIS.this_oDataMgr.SqlExecute(loc_cSql, 'LocalCalcU') < 1
                        MsgErro("Falha na conex" + CHR(227) + "o (LocalCalcU Produto)", "Erro")
                        LOOP
                    ENDIF
                    loc_ldData  = IIF(RECCOUNT('LocalCalcU') = 0, .NULL., LocalCalcU.Datas)
                    loc_lnValor = IIF(RECCOUNT('LocalCalcU') = 0, 0,     LocalCalcU.Valors)
                    loc_cMoeda  = IIF(RECCOUNT('LocalCalcU') = 0, "",    ALLTRIM(LocalCalcU.Moedas))

                    loc_cUpDate = "Update SigCdPro Set UltComps = " + ;
                                  IIF(ISNULL(loc_ldData), "NULL", FormatarDataSQL(loc_ldData)) + ;
                                  ", vUltComps = " + STR(loc_lnValor, 12, 2) + ;
                                  ", mUltComps = '" + loc_cMoeda + "'" + ;
                                  " Where Cpros = '" + ALLTRIM(SelecaoCpros.Cpros) + "'"
                    IF THIS.this_oDataMgr.SqlExecute(loc_cUpDate, '') < 1
                        MsgErro("Falha na conex" + CHR(227) + "o (Update SigCdPro)", "Erro")
                        LOOP
                    ENDIF
                    THIS.this_oDataMgr.Commit()
                ENDSCAN

                loc_oCusto.Complete(.T., .T.)

                IF USED("TprMvCab")
                    USE IN TprMvCab
                ENDIF
                IF USED("crTpmMvItn")
                    USE IN crTpmMvItn
                ENDIF
                IF USED("LocCalcU")
                    USE IN LocCalcU
                ENDIF
                IF USED("CsSelecao")
                    USE IN CsSelecao
                ENDIF
                IF USED("SelecaoIclis")
                    USE IN SelecaoIclis
                ENDIF
                IF USED("SelecaoCpros")
                    USE IN SelecaoCpros
                ENDIF

                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

