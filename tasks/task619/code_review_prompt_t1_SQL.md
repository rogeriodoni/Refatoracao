# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna '1' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, GRUPOS, CPROS, LINHAS, QMINS, SITUAS, DOPES, GLOBALIZAS, EMPDOPNUMS, DIFPRODS, ESTOS, SQTDS, GRUPODS, CONTADS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, GRUPOS, CPROS, LINHAS, QMINS, SITUAS, DOPES, GLOBALIZAS, EMPDOPNUMS, DIFPRODS, ESTOS, SQTDS, GRUPODS, CONTADS

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
lcQryEest = [Select * From SigMvCab]
lcQryEesti = [Select * From SigMvItn]
lcQrySigCdLin = [Select descs,linhas,pedidos From SigCdLin Order By descs,linhas,pedidos ]
		Select crSigCdLin
	Select crSigCdLin
	If !Seek( This.Value )
	Select crSigCdLin
	If !Seek( This.Value )
Select crSigCdLin
If !Seek( lcLinha )
	lcQuery = [	Select E.Emps, E.Grupos, E.Estos, E.CPros, E.SQtds,]+;
			  [ From SigMvEst E, SigCdPro P ]+;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTemp1') < 1)
	lcQuery = [ Select CPros, QMins, IFors, PVens, Moevs, Dpros ]+;
		[	From SigCdPro ]+;
		[		Not In (Select empgruests+Cpros as Chave From SigMvEst ) ]
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTemp2') < 1)
	Select Emps, Grupos, Estos, CPros, SQtds, QMins, QMins - SQtds As DifProds, IFors, PVens, Moevs, Dpros ;
		From crTemp1 ;
	Select lcEmpresa as Emps, lcGrupo as Grupos, lcConta as Estos, CPros, 000000000.00 as SQtds, QMins,;
		From CrTemp2 ;
	lcQuery = [ Select E.Emps, E.Grupos, E.Estos, E.CPros, E.SQtds, ]+;
			  [ From SigMvEst E, SigCdPro P ]+;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTemp3') < 1)
	Select Emps, Grupos, Estos, CPros, SQtds, 0 as QMins,;
		From crTemp3 ;
Select TmpMinimo
lcQuery = [Select I.CPros, I.Qtds, I.QtBxProds, I.empdopnums, E.empdopnums, E.Grupods, E.Contads, E.Dopes, E.Emps, ] + ;
		  [	From SigMvCab E, SigMvItn I, SigCdOpe O ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTemp4') < 1)
Select CPros, Sum(Qtds - QtBxProds) As Produzindo ;
  From crTemp4 ;
Select TmpPedidos
Select TmpMinimo
Select M.CPros, M.IFors, M.PVens, M.Moevs, M.Dpros,;
	From TmpMinimo M Left Join TmpPedidos P On M.CPros = P.CPros ;
Select TmpProd
Select TmpProd
Select TmpProd
	loBarra.Update( .t. )
		lcQuery = [Select Dopes, GruOrigs, Opers ] + ;
		    [ From SigCdOpe ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdOpe') < 1)
		Select TmpProd
		Insert Into crSigMvCab ( Emps, Dopes, Numes, Datas, Datars, MascNum,;
		Select crSigMvCab
	Insert Into crSigMvItn ( Emps, Dopes, Numes, CItens, CPros, Qtds, Units, Moedas, opers, totas, dpros, EmpDopNums, CidChaves, DtAlts ) ;
	Select crSigMvCab
Select Min(Datas) as Datas From CrSigMvCab Into Cursor TmpGdm
If Not ThisForm.poDataMgr.Update('crSigMvCab')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvCab)')
If Not ThisForm.poDataMgr.Update('crSigMvItn')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvItn)')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGmi.prg) - TRECHOS RELEVANTES PARA PASS SQL (1351 linhas total):

*-- Linhas 824 a 846:
824:                 ENDIF
825: 
826:                 loc_cCampo = IIF(par_cModo = "C", "Cemps", "Razas")
827:                 loc_cSQL   = "SELECT Cemps, Razas FROM SigCdEmp WHERE " + loc_cCampo + " = " + EscaparSQL(loc_cValor)
828:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpresaVal")
829: 
830:                 IF loc_nResultado > 0 AND USED("cursor_4c_EmpresaVal") AND !EOF("cursor_4c_EmpresaVal")
831:                     SELECT cursor_4c_EmpresaVal
832:                     THIS.txt_4c__cd_empresa.Value = ALLTRIM(cursor_4c_EmpresaVal.Cemps)
833:                     THIS.txt_4c__ds_empresa.Value = ALLTRIM(cursor_4c_EmpresaVal.Razas)
834:                 ELSE
835:                     THIS.AbrirLookupEmpresa(loc_cValor)
836:                 ENDIF
837: 
838:                 IF USED("cursor_4c_EmpresaVal")
839:                     USE IN cursor_4c_EmpresaVal
840:                 ENDIF
841:             ENDIF
842:         CATCH TO loc_oErro
843:             MsgErro(loc_oErro.Message + CHR(13) + ;
844:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
845:                 "Procedure: " + loc_oErro.Procedure, "Erro em ValidarEmpresa")
846:         ENDTRY

*-- Linhas 1013 a 1054:
1013:     *--------------------------------------------------------------------------
1014:     * ValidarLinha - Transcricao de SIGPRGMI.Get_Linha.Valid: campo vazio
1015:     * limpa os dois campos (codigo + descricao); preenchido tenta match
1016:     * exato em SigCdLin.Linhas (equivalente ao "Select crSigCdLin / Set
1017:     * Order to Linhas / Seek(This.Value)" legado) e, sem match, abre o
1018:     * mesmo lookup que o F4 (equivalente ao fwBuscaSel do legado).
1019:     *--------------------------------------------------------------------------
1020:     PROCEDURE ValidarLinha()
1021:         LOCAL loc_cValor, loc_cSQL, loc_nResultado, loc_oErro
1022: 
1023:         IF VARTYPE(THIS.txt_4c_Linha) != "O" OR VARTYPE(THIS.txt_4c_DLinha) != "O"
1024:             RETURN
1025:         ENDIF
1026: 
1027:         TRY
1028:             loc_cValor = ALLTRIM(THIS.txt_4c_Linha.Value)
1029:             IF EMPTY(loc_cValor)
1030:                 THIS.txt_4c_Linha.Value  = ""
1031:                 THIS.txt_4c_DLinha.Value = ""
1032:             ELSE
1033:                 IF USED("cursor_4c_LinhaVal")
1034:                     USE IN cursor_4c_LinhaVal
1035:                 ENDIF
1036:                 loc_cSQL = "SELECT Linhas, Descs FROM SigCdLin WHERE Linhas = " + EscaparSQL(loc_cValor)
1037:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LinhaVal")
1038:                 IF loc_nResultado > 0 AND USED("cursor_4c_LinhaVal") AND !EOF("cursor_4c_LinhaVal")
1039:                     SELECT cursor_4c_LinhaVal
1040:                     THIS.txt_4c_Linha.Value  = ALLTRIM(cursor_4c_LinhaVal.Linhas)
1041:                     THIS.txt_4c_DLinha.Value = ALLTRIM(cursor_4c_LinhaVal.Descs)
1042:                 ELSE
1043:                     THIS.AbrirLookupLinha(loc_cValor)
1044:                 ENDIF
1045:                 IF USED("cursor_4c_LinhaVal")
1046:                     USE IN cursor_4c_LinhaVal
1047:                 ENDIF
1048:             ENDIF
1049:         CATCH TO loc_oErro
1050:             MsgErro(loc_oErro.Message + CHR(13) + ;
1051:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1052:                 "Procedure: " + loc_oErro.Procedure, "Erro em ValidarLinha")
1053:         ENDTRY
1054:     ENDPROC

*-- Linhas 1074 a 1095:
1074:                 IF USED("cursor_4c_LinhaVal")
1075:                     USE IN cursor_4c_LinhaVal
1076:                 ENDIF
1077:                 loc_cSQL = "SELECT Linhas, Descs FROM SigCdLin WHERE Descs = " + EscaparSQL(loc_cValor)
1078:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LinhaVal")
1079:                 IF loc_nResultado > 0 AND USED("cursor_4c_LinhaVal") AND !EOF("cursor_4c_LinhaVal")
1080:                     SELECT cursor_4c_LinhaVal
1081:                     THIS.txt_4c_Linha.Value  = ALLTRIM(cursor_4c_LinhaVal.Linhas)
1082:                     THIS.txt_4c_DLinha.Value = ALLTRIM(cursor_4c_LinhaVal.Descs)
1083:                 ELSE
1084:                     THIS.AbrirLookupLinha(loc_cValor)
1085:                 ENDIF
1086:                 IF USED("cursor_4c_LinhaVal")
1087:                     USE IN cursor_4c_LinhaVal
1088:                 ENDIF
1089:             ENDIF
1090:         CATCH TO loc_oErro
1091:             MsgErro(loc_oErro.Message + CHR(13) + ;
1092:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1093:                 "Procedure: " + loc_oErro.Procedure, "Erro em ValidarDLinha")
1094:         ENDTRY
1095:     ENDPROC


### BO (C:\4c\projeto\app\classes\SigPrGmiBO.prg):
*============================================================================
* SigPrGmiBO.prg - Business Object para Geracao de Pedido de Estoque Minimo
*
* Form legado: SIGPRGMI (form generico, OPERACIONAL - sem CRUD de registro)
* Tabelas manipuladas pelo processamento (Processa.Click do legado):
*   SigMvCab  (cabecalho do movimento/pedido gerado)
*   SigMvItn  (itens do movimento/pedido gerado)
*   SigCdLin  (linhas de producao - lookup)
*   SigCdEmp  (empresas - lookup, Cemps/Razas)
*   SigCdCli  (contas de estoque / grupos de estoque - lookup via fAcessoContas/fAcessoContab)
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
* Completado em: Fase 2 - CarregarDoCursor/ValidarDados/Inserir/
*                ObterChavePrimaria/RegistrarAuditoria + logica real do
*                Processa.Click legado (geracao do pedido de estoque minimo)
*
* NOTA DE ARQUITETURA - Inserir()/Atualizar():
* Este processo SO GERA pedidos novos (SigMvCab/SigMvItn); o legado nao tem
* equivalente de "alterar" um pedido ja gerado atraves desta tela. O form
* (Fase 3+) chama NovoRegistro() + FormParaBO() + Salvar() a cada clique em
* "Processar" - this_lNovoRegistro fica sempre .T., entao Salvar() sempre
* delega a Inserir() (nunca a Atualizar()). Por isso Atualizar() e
* ExecutarExclusao() permanecem SEM override: o comportamento padrao herdado
* de BusinessBase (recusar a operacao) ja eh o correto, porque esses dois
* caminhos nunca sao acionados por este form.
*============================================================================

DEFINE CLASS SigPrGmiBO AS BusinessBase

    *==========================================================================
    * Propriedades - criterios de filtro/processamento (Get_* do form legado)
    * Este form NAO cadastra um registro unico: ele dispara um PROCESSAMENTO
    * (geracao de pedido de estoque minimo) a partir destes criterios.
    *==========================================================================
    this_cCdEmpresa   = ""    && char(3)  - Codigo da empresa (SigCdEmp.Cemps)
    this_cDsEmpresa   = ""    && char(40) - Descricao da empresa (SigCdEmp.Razas, exibicao)

    this_cCdGrEstoque = ""    && char     - Codigo do Grupo de Estoque (SigCdCli, lookup fAcessoContab)
    this_cDsGrEstoque = ""    && char     - Descricao do Grupo de Estoque (exibicao)

    this_cCdEstoque   = ""    && char     - Codigo da Conta de Estoque (SigCdCli, lookup fAcessoContas)
    this_cDsEstoque   = ""    && char     - Descricao da Conta de Estoque (exibicao)

    this_cLinha       = ""    && char     - Codigo da Linha de Producao (SigCdLin.Linhas)
    this_cDLinha      = ""    && char     - Descricao da Linha de Producao (SigCdLin.Descs)

    this_cNegativo    = "N"   && char(1)  - Somente Negativos (S/N)
    this_dDatai       = {}    && date     - Data de Geracao do pedido

    *==========================================================================
    * Resultado do lookup de Linha (SigCdLin.Pedidos) - a operacao usada para
    * gerar os pedidos (equivalente a "lcOperacao" do Processa.Click legado).
    * Resolvido em CarregarDoCursor() (apos picker) e revalidado em
    * ValidarDados() (o legado faz a MESMA conferencia de novo no Click, sem
    * confiar no que a tela ja tinha resolvido no Valid).
    *==========================================================================
    this_cOperacaoGerada = ""   && char(20) - SigCdLin.Pedidos da linha escolhida

    *==========================================================================
    * Propriedade de controle de UI (consistente com ProdutoBO/outros BOs do
    * projeto): o form faz SetFocus no controle indicado quando ValidarDados
    * recusa a operacao.
    *==========================================================================
    this_cCampoFoco = ""

    *==========================================================================
    * Propriedade interna de auditoria - a chave do cabecalho (SigMvCab.
    * CidChaves) RECEM-GERADO, usada por ObterChavePrimaria()/
    * RegistrarAuditoria() dentro do laco de Inserir() (mais de um cabecalho
    * pode ser gerado numa unica execucao - um por fornecedor distinto).
    *==========================================================================
    this_cCidChavesAtual = ""

    *==========================================================================
    * Propriedades de controle do processamento (resultado da ultima execucao)
    *==========================================================================
    this_nItensGerados = 0    && Quantidade de itens incluidos no(s) pedido(s) gerado(s)
    this_cNumeroPedido  = ""  && Numero (Numes) do ULTIMO cabecalho gerado na ultima execucao

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMvCab"
            THIS.this_cCampoChave = "cidchaves"
            THIS.this_dDatai      = DATE()
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - chave do ULTIMO cabecalho (SigMvCab.CidChaves)
    * gravado por Inserir(); usada por RegistrarAuditoria(), chamado DENTRO do
    * laco de geracao (um registro de auditoria por cabecalho criado, ja que
    * um unico Processar pode gerar varios cabecalhos - um por fornecedor).
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChavesAtual
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - carrega o resultado do picker/seek de Linha de
    * Producao (cursor com as colunas Linhas/Descs/Pedidos de SigCdLin,
    * equivalente ao "This.Parent.Get_Linha.Value = crSigCdLin.Linhas /
    * This.Parent.Get_dLinha.Value = crSigCdLin.Descs" do Get_Linha.Valid /
    * Get_DLinha.Valid legado).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            IF !EOF()
                THIS.this_cLinha          = PADR(ALLTRIM(TratarNulo(Linhas, "")), 10)
                THIS.this_cDLinha         = ALLTRIM(TratarNulo(Descs, ""))
                THIS.this_cOperacaoGerada = PADR(ALLTRIM(TratarNulo(Pedidos, "")), 20)
                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarDados - transcricao dos IsEmpty()/Seek() do inicio do
    * Processa.Click legado. O legado usa Messagebox()+SetFocus; aqui
    * this_cMensagemErro + this_cCampoFoco (o form faz o SetFocus) - quem
    * EXIBE a mensagem eh BusinessBase.Salvar()/ExibirFalha (regra do
    * CLAUDE.md: falha nunca eh muda).
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido, loc_cLinha, loc_nResultado, loc_oErro

        loc_lValido = .T.
        THIS.this_cCampoFoco = ""

        IF EMPTY(ALLTRIM(THIS.this_cCdEmpresa))
            THIS.this_cMensagemErro = CHR(201) + " obrigat" + CHR(243) + "rio informar a Empresa..."
            THIS.this_cCampoFoco    = "txt_4c__cd_empresa"
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cCdGrEstoque))
            THIS.this_cMensagemErro = CHR(201) + " obrigat" + CHR(243) + "rio informar o Grupo..."
            THIS.this_cCampoFoco    = "txt_4c__Cd_GrEstoque"
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cCdEstoque))
            THIS.this_cMensagemErro = CHR(201) + " obrigat" + CHR(243) + "rio informar a Conta..."
            THIS.this_cCampoFoco    = "txt_4c__cd_estoque"
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cLinha))
            THIS.this_cMensagemErro = CHR(201) + " obrigat" + CHR(243) + "rio informar a Linha..."
            THIS.this_cCampoFoco    = "txt_4c_Linha"
            loc_lValido = .F.
        ENDIF

        *-- Select crSigCdLin / Set Order to Linhas / If !Seek(lcLinha) ...
        *-- Endif / If IsEmpty(crSigCdLin.Pedidos) ... Endif - revalidado aqui
        *-- sem confiar no que o picker/Valid ja tinha resolvido.
        *-- TRY/CATCH proprio: SQLEXEC com gnConnHandle invalido DISPARA
        *-- excecao em vez de devolver -1 (nao chegaria no IF abaixo).
        IF loc_lValido
            loc_cLinha = PADR(ALLTRIM(THIS.this_cLinha), 10)

            TRY
                IF USED("cursor_4c_LinhaChk")
                    USE IN cursor_4c_LinhaChk
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT descs, linhas, pedidos FROM SigCdLin WHERE linhas = " + ;
                    EscaparSQL(loc_cLinha), "cursor_4c_LinhaChk")

                IF loc_nResultado < 0 OR !USED("cursor_4c_LinhaChk") OR EOF("cursor_4c_LinhaChk")
                    THIS.this_cMensagemErro = "Esta Linha de Produ" + CHR(231) + CHR(227) + "o n" + ;
                        CHR(227) + "o est" + CHR(225) + " cadastrada..."
                    THIS.this_cCampoFoco    = "txt_4c_Linha"
                    loc_lValido = .F.
                ELSE
                    IF EMPTY(ALLTRIM(TratarNulo(cursor_4c_LinhaChk.pedidos, "")))
                        THIS.this_cMensagemErro = "Esta Linha de Produ" + CHR(231) + CHR(227) + "o n" + ;
                            CHR(227) + "o possui uma Opera" + CHR(231) + CHR(227) + "o cadastrada..."
                        THIS.this_cCampoFoco    = "txt_4c_Linha"
                        loc_lValido = .F.
                    ELSE
                        THIS.this_cOperacaoGerada = PADR(ALLTRIM(cursor_4c_LinhaChk.pedidos), 20)
                    ENDIF
                ENDIF

                IF USED("cursor_4c_LinhaChk")
                    USE IN cursor_4c_LinhaChk
                ENDIF
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                THIS.this_cCampoFoco    = "txt_4c_Linha"
                loc_lValido = .F.
            ENDTRY
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * Inserir - transcricao de SIGPRGMI.Processa.Click. Gera o(s) pedido(s)
    * de estoque minimo (SigMvCab/SigMvItn) a partir dos criterios (Empresa/
    * Grupo/Conta/Linha/Negativo/Data) ja validados por ValidarDados().
    *
    * Arquitetura: os cabecalhos/itens sao acumulados em cursores LOCAIS com
    * a estrutura COMPLETA das tabelas reais (AbrirCursorTabela), igual ao
    * padrao ja usado em SigPrGlxBO/SigPrGlpBO - garante cobertura de TODA
    * coluna NOT NULL sem enumerar ~140 colunas a mao (regra #22 do
    * CLAUDE.md) - e so ao final sao persistidos via PersistirCursor +
    * SQLCOMMIT/SQLROLLBACK (a conexao nasce em modo manual - Transactions=2
    * - sem nenhum commit implicito; ver memoria feedback_conexao_sql_
    * transactions_2_sem_commit).
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lErro, loc_cEmpresa, loc_cGrupo, loc_cConta, loc_cLinha, ;
            loc_cOperacao, loc_dData, loc_cSQL, loc_cChaveEst, ;
            loc_cFornece, loc_nItens, loc_nNumero, loc_cEmpDopNums, loc_cGruOrigs, ;
            loc_nOpers, loc_nTotalReg, loc_oProg, loc_oErro

        loc_lErro = .F.
        THIS.this_nItensGerados = 0
        THIS.this_cNumeroPedido = ""

        loc_cEmpresa  = PADR(ALLTRIM(THIS.this_cCdEmpresa), 3)
        loc_cGrupo    = PADR(ALLTRIM(THIS.this_cCdGrEstoque), 10)
        loc_cConta    = PADR(ALLTRIM(THIS.this_cCdEstoque), 10)
        loc_cLinha    = PADR(ALLTRIM(THIS.this_cLinha), 10)
        loc_cOperacao = PADR(ALLTRIM(THIS.this_cOperacaoGerada), 20)
        loc_dData     = THIS.this_dDatai

        TRY
            *-- 1) monta crTemp1/crTemp2 (ou crTemp3) e TmpMinimo, conforme o
            *-- criterio "Somente Negativos"
            IF UPPER(ALLTRIM(THIS.this_cNegativo)) != "S"

                loc_cSQL = "SELECT E.Emps, E.Grupos, E.Estos, E.CPros, E.SQtds, " + ;
                    "P.QMins, P.IFors, P.PVens, P.Moevs, P.Dpros " + ;
                    "FROM SigMvEst E, SigCdPro P " + ;
                    "WHERE E.Emps = " + EscaparSQL(loc_cEmpresa) + ;
                    " AND E.Grupos = " + EscaparSQL(loc_cGrupo) + ;
                    " AND E.Estos = " + EscaparSQL(loc_cConta) + ;
                    " AND E.CPros = P.CPros AND E.SQtds < P.QMins" + ;
                    " AND P.Linhas = " + EscaparSQL(loc_cLinha) + ;
                    " AND P.Situas = 1 AND P.QMins > 0"

                IF !THIS.ExecutarSQL(loc_cSQL, "cursor_4c_Temp1", "crTemp1")
                    loc_lErro = .T.
                ENDIF

                *-- Chave POSICIONAL (regra #42 do CLAUDE.md): empgruests eh
                *-- char(23) = emps(3)+grupos(10)+estos(10) - PADR explicito,
                *-- nunca ALLTRIM/concatenacao direta das partes.
                IF !loc_lErro
                    loc_cChaveEst = PADR(loc_cEmpresa, 3) + PADR(loc_cGrupo, 10) + PADR(loc_cConta, 10)

                    loc_cSQL = "SELECT CPros, QMins, IFors, PVens, Moevs, Dpros " + ;
                        "FROM SigCdPro " + ;
                        "WHERE Linhas = " + EscaparSQL(loc_cLinha) + ;
                        " AND QMins > 0 AND Situas = 1" + ;
                        " AND " + EscaparSQL(loc_cChaveEst) + " + CPros NOT IN " + ;
                        "(SELECT empgruests + CPros FROM SigMvEst)"

                    IF !THIS.ExecutarSQL(loc_cSQL, "cursor_4c_Temp2", "crTemp2")
                        loc_lErro = .T.
                    ENDIF
                ENDIF

                IF !loc_lErro
                    IF USED("cursor_4c_Minimo")
                        USE IN cursor_4c_Minimo
                    ENDIF

                    SELECT Emps, Grupos, Estos, CPros, SQtds, QMins, QMins - SQtds AS DifProds, ;
                            IFors, PVens, Moevs, Dpros ;
                        FROM cursor_4c_Temp1 ;
                        WHERE Emps = m.loc_cEmpresa AND Grupos = m.loc_cGrupo AND Estos = m.loc_cConta ;
                            AND SQtds < QMins AND QMins > 0 ;
                        UNION ALL ;
                        SELECT PADR(m.loc_cEmpresa, 3) AS Emps, PADR(m.loc_cGrupo, 10) AS Grupos, ;
                                PADR(m.loc_cConta, 10) AS Estos, CPros, 00000000.000 AS SQtds, ;
                                QMins, QMins AS DifProds, IFors, PVens, Moevs, Dpros ;
                        FROM cursor_4c_Temp2 ;
                        INTO CURSOR cursor_4c_Minimo READWRITE
                ENDIF

            ELSE

                loc_cSQL = "SELECT E.Emps, E.Grupos, E.Estos, E.CPros, E.SQtds, " + ;
                    "P.IFors, P.PVens, P.Moevs, P.Dpros " + ;
                    "FROM SigMvEst E, SigCdPro P " + ;
                    "WHERE E.Emps = " + EscaparSQL(loc_cEmpresa) + ;
                    " AND E.Grupos = " + EscaparSQL(loc_cGrupo) + ;
                    " AND E.Estos = " + EscaparSQL(loc_cConta) + ;
                    " AND E.CPros = P.CPros AND E.SQtds < 0" + ;
                    " AND P.Linhas = " + EscaparSQL(loc_cLinha) + ;
                    " AND P.Situas = 1"

                IF !THIS.ExecutarSQL(loc_cSQL, "cursor_4c_Temp3", "crTemp3")
                    loc_lErro = .T.
                ENDIF

                IF !loc_lErro
                    IF USED("cursor_4c_Minimo")
                        USE IN cursor_4c_Minimo
                    ENDIF

                    SELECT Emps, Grupos, Estos, CPros, SQtds, 0 AS QMins, ABS(SQtds) AS DifProds, ;
                            IFors, PVens, Moevs, Dpros ;
                        FROM cursor_4c_Temp3 ;
                        INTO CURSOR cursor_4c_Minimo READWRITE
                ENDIF

            ENDIF

            IF !loc_lErro
                SELECT cursor_4c_Minimo
                GO TOP
                IF EOF()
                    THIS.this_cMensagemErro = "Nenhum produto selecionado..."
                    loc_lErro = .T.
                ENDIF
            ENDIF

            *-- 2) TmpPedidos (producao ja em andamento) e TmpProd (saldo que
            *-- realmente falta produzir)
            IF !loc_lErro
                loc_cSQL = "SELECT I.CPros, I.Qtds, I.QtBxProds " + ;
                    "FROM SigMvCab E, SigMvItn I, SigCdOpe O " + ;
                    "WHERE E.Dopes = O.Dopes AND E.Emps = " + EscaparSQL(loc_cEmpresa) + ;
                    " AND (O.Globalizas = 1 OR O.Globalizas = 2)" + ;
                    " AND E.Grupods = " + EscaparSQL(loc_cGrupo) + ;
                    " AND E.Contads = " + EscaparSQL(loc_cConta) + ;
                    " AND E.EmpDopNums = I.EmpDopNums"

                IF !THIS.ExecutarSQL(loc_cSQL, "cursor_4c_Temp4", "crTemp4")
                    loc_lErro = .T.
                ENDIF
            ENDIF

            IF !loc_lErro
                IF USED("cursor_4c_Pedidos")
                    USE IN cursor_4c_Pedidos
                ENDIF

                SELECT CPros, SUM(Qtds - QtBxProds) AS Produzindo ;
                    FROM cursor_4c_Temp4 ;
                    GROUP BY CPros ;
                    INTO CURSOR cursor_4c_Pedidos READWRITE

                SELECT cursor_4c_Pedidos
                INDEX ON CPros TAG CPros

                SELECT cursor_4c_Minimo
                INDEX ON IFors + CPros TAG ForProd

                IF USED("cursor_4c_Prod")
                    USE IN cursor_4c_Prod
                ENDIF

                SELECT M.CPros, M.IFors, M.PVens, M.Moevs, M.Dpros, ;
                        M.DifProds - IIF(ISNULL(P.Produzindo), 0, P.Produzindo) AS Qtds ;
                    FROM cursor_4c_Minimo M LEFT JOIN cursor_4c_Pedidos P ON M.CPros = P.CPros ;
                    WHERE M.DifProds > IIF(ISNULL(P.Produzindo), 0, P.Produzindo) ;
                    INTO CURSOR cursor_4c_Prod READWRITE

                SELECT cursor_4c_Prod
                GO TOP
                IF EOF()
                    THIS.this_cMensagemErro = "Nenhum produto selecionado..."
                    loc_lErro = .T.
                ELSE
                    INDEX ON IFors + CPros TAG ForProd
                    COUNT TO loc_nTotalReg
                ENDIF
            ENDIF

            *-- 3) cursores destino (cabecalho/itens) com a estrutura REAL e
            *-- COMPLETA das tabelas - nasce vazio, igual ao "Select crXxx /
            *-- Zap" do topo do processamento legado
            IF !loc_lErro
                IF !THIS.AbrirCursorTabela("cursor_4c_MvCab", "SigMvCab")
                    loc_lErro = .T.
                ENDIF
            ENDIF
            IF !loc_lErro
                IF !THIS.AbrirCursorTabela("cursor_4c_MvItn", "SigMvItn")
                    loc_lErro = .T.
                ENDIF
            ENDIF

            *-- 4) laco principal - um cabecalho por fornecedor (IFors)
            *-- distinto, itens sequenciais dentro de cada cabecalho
            IF !loc_lErro
                loc_oProg = CREATEOBJECT("fwprogressbar", "Processando Pedidos...", loc_nTotalReg)
                loc_oProg.Show()

                loc_cFornece = REPLICATE(CHR(255), 10)
                loc_nItens   = 0
                loc_nNumero  = 0
                loc_nOpers   = 0

                SELECT cursor_4c_Prod
                SCAN
                    loc_oProg.Update(.T.)

                    IF loc_cFornece != cursor_4c_Prod.IFors
                        loc_nNumero  = fGerUniqueKey(ALLTRIM(loc_cOperacao) + loc_cEmpresa)
                        loc_cFornece = cursor_4c_Prod.IFors

                        IF loc_nNumero = 0
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                "N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar o n" + ;
                                CHR(250) + "mero do pedido."
                            loc_lErro = .T.
                            EXIT
                        ENDIF

                        IF USED("cursor_4c_SigCdOpe")
                            USE IN cursor_4c_SigCdOpe
                        ENDIF

                        IF !THIS.ExecutarSQL( ;
                                "SELECT Dopes, GruOrigs, Opers FROM SigCdOpe WHERE Dopes = " + ;
                                EscaparSQL(loc_cOperacao), "cursor_4c_SigCdOpe", "crSigCdOpe")
                            loc_lErro = .T.
                            EXIT
                        ENDIF

                        loc_cGruOrigs = "ESTOQUE"
                        loc_nOpers    = 0
                        IF USED("cursor_4c_SigCdOpe") AND !EOF("cursor_4c_SigCdOpe")
                            IF !EMPTY(ALLTRIM(TratarNulo(cursor_4c_SigCdOpe.GruOrigs, "")))
                                loc_cGruOrigs = ALLTRIM(cursor_4c_SigCdOpe.GruOrigs)
                            ENDIF
                            loc_nOpers = TratarNulo(cursor_4c_SigCdOpe.Opers, 0)
                        ENDIF

                        *-- EmpDopNums eh chave POSICIONAL (regra #42): char(29)
                        *-- = emps(3) + dopes(20) + Str(numes,6) - PADR explicito.
                        loc_cEmpDopNums = PADR(loc_cEmpresa, 3) + PADR(loc_cOperacao, 20) + STR(loc_nNumero, 6)

                        SELECT cursor_4c_MvCab
                        APPEND BLANK
                        REPLACE Emps       WITH loc_cEmpresa, ;
                                Dopes      WITH PADR(loc_cOperacao, 20), ;
                                Numes      WITH loc_nNumero, ;
                                Datas      WITH loc_dData, ;
                                Datars     WITH loc_dData, ;
                                MascNum    WITH ALLTRIM(fGerMascara(loc_nNumero)), ;
                                Grupoos    WITH PADR(loc_cGruOrigs, 10), ;
                                Contaos    WITH PADR(loc_cFornece, 10), ;
                                Grupods    WITH PADR(loc_cGrupo, 10), ;
                                Contads    WITH PADR(loc_cConta, 10), ;
                                Usuars     WITH PADR(ALLTRIM(TratarNulo(gc_4c_UsuarioLogado, "")), 10), ;
                                EmpDopNums WITH loc_cEmpDopNums, ;
                                CidChaves  WITH fUniqueIds(), ;
                                DtAlts     WITH DATE()

                        THIS.this_cCidChavesAtual = ALLTRIM(cursor_4c_MvCab.CidChaves)
                        THIS.RegistrarAuditoria("INSERT")
                        THIS.this_cNumeroPedido = TRANSFORM(loc_nNumero)

                        loc_nItens = 0
                    ENDIF

                    loc_nItens = loc_nItens + 1

                    SELECT cursor_4c_MvItn
                    APPEND BLANK
                    REPLACE Emps       WITH loc_cEmpresa, ;
                            Dopes      WITH PADR(loc_cOperacao, 20), ;
                            Numes      WITH loc_nNumero, ;
                            CItens     WITH loc_nItens, ;
                            CPros      WITH cursor_4c_Prod.CPros, ;
                            Qtds       WITH cursor_4c_Prod.Qtds, ;
                            Units      WITH cursor_4c_Prod.PVens, ;
                            Moedas     WITH cursor_4c_Prod.Moevs, ;
                            opers      WITH IIF(loc_nOpers = 1, "E", "S"), ;
                            totas      WITH (cursor_4c_Prod.Qtds * cursor_4c_Prod.PVens), ;
                            dpros      WITH cursor_4c_Prod.Dpros, ;
                            EmpDopNums WITH loc_cEmpDopNums, ;
                            CidChaves  WITH fUniqueIds(), ;
                            DtAlts     WITH DATE()

                    SELECT cursor_4c_MvCab
                    REPLACE ValInis WITH ValInis + (cursor_4c_Prod.PVens * cursor_4c_Prod.Qtds), ;
                            Valos   WITH Valos   + (cursor_4c_Prod.PVens * cursor_4c_Prod.Qtds), ;
                            DtAlts  WITH DATE()

                    THIS.this_nItensGerados = THIS.this_nItensGerados + 1

                    SELECT cursor_4c_Prod
                ENDSCAN

                loc_oProg.Complete(.T.)
                loc_oProg = .NULL.
            ENDIF

            *-- 5) persiste os dois cursores locais nas tabelas reais e fecha
            *-- a transacao manual (Transactions = 2) - um unico commit cobre
            *-- os dois PersistirCursor + os RegistrarAuditoria do laco acima
            IF !loc_lErro
                IF !THIS.PersistirCursor("cursor_4c_MvCab", "SigMvCab")
                    loc_lErro = .T.
                ENDIF
            ENDIF
            IF !loc_lErro
                IF !THIS.PersistirCursor("cursor_4c_MvItn", "SigMvItn")
                    loc_lErro = .T.
                ENDIF
            ENDIF

            IF !loc_lErro
                IF SQLCOMMIT(gnConnHandle) < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                        "(Commit) " + CapturarErroSQL()
                    loc_lErro = .T.
                ENDIF
            ENDIF

            IF loc_lErro
                = SQLROLLBACK(gnConnHandle)
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lErro = .T.
            = SQLROLLBACK(gnConnHandle)
        ENDTRY

        *-- limpeza dos cursores temporarios (regra #1: fora do TRY/CATCH so
        *-- por causa do RETURN; aqui eh so organizacao)
        IF USED("cursor_4c_Temp1")
            USE IN cursor_4c_Temp1
        ENDIF
        IF USED("cursor_4c_Temp2")
            USE IN cursor_4c_Temp2
        ENDIF
        IF USED("cursor_4c_Temp3")
            USE IN cursor_4c_Temp3
        ENDIF
        IF USED("cursor_4c_Temp4")
            USE IN cursor_4c_Temp4
        ENDIF
        IF USED("cursor_4c_Minimo")
            USE IN cursor_4c_Minimo
        ENDIF
        IF USED("cursor_4c_Pedidos")
            USE IN cursor_4c_Pedidos
        ENDIF
        IF USED("cursor_4c_Prod")
            USE IN cursor_4c_Prod
        ENDIF
        IF USED("cursor_4c_SigCdOpe")
            USE IN cursor_4c_SigCdOpe
        ENDIF
        IF USED("cursor_4c_MvCab")
            USE IN cursor_4c_MvCab
        ENDIF
        IF USED("cursor_4c_MvItn")
            USE IN cursor_4c_MvItn
        ENDIF

        RETURN !loc_lErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarSQL - SQLEXEC pass-through preservando a area de trabalho
    * corrente (o chamador pode estar no meio de um SCAN de outro cursor).
    * Mesmo helper generico ja usado em SigPrGlxBO/SigPrGlpBO.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarSQL(par_cSQL, par_cCursor, par_cRotulo)
        LOCAL loc_nRet, loc_lOk, loc_cAliasAnt

        loc_cAliasAnt = ALIAS()

        IF VARTYPE(par_cCursor) = "C" AND !EMPTY(par_cCursor)
            IF USED(par_cCursor)
                USE IN (par_cCursor)
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, par_cSQL, par_cCursor)
        ELSE
            loc_nRet = SQLEXEC(gnConnHandle, par_cSQL)
        ENDIF

        IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF

        loc_lOk = (loc_nRet >= 0)

        IF !loc_lOk
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "(" + TRANSFORM(par_cRotulo) + ") " + CapturarErroSQL()
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * AbrirCursorTabela - cria (ou recria VAZIO) um cursor READWRITE com a
    * estrutura COMPLETA da tabela informada - garante que PersistirCursor()
    * cubra toda coluna NOT NULL da tabela destino (regra #22 do CLAUDE.md).
    * Mesmo helper generico ja usado em SigPrGlxBO/SigPrGlpBO.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION AbrirCursorTabela(par_cCursor, par_cTabela)
        LOCAL loc_nRet, loc_lOk
        loc_lOk = .F.

        IF USED(par_cCursor)
            USE IN (par_cCursor)
        ENDIF
        IF USED("cursor_4c_Estrut")
            USE IN cursor_4c_Estrut
        ENDIF

        loc_nRet = SQLEXEC(gnConnHandle, ;
            "SELECT * FROM " + par_cTabela + " WHERE 1 = 0", "cursor_4c_Estrut")

        IF loc_nRet >= 0 AND USED("cursor_4c_Estrut")
            SELECT * FROM cursor_4c_Estrut WHERE .F. INTO CURSOR (par_cCursor) READWRITE
            USE IN cursor_4c_Estrut
            loc_lOk = USED(par_cCursor)
        ENDIF

        IF !loc_lOk
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "(estrutura de " + par_cTabela + ") " + CapturarErroSQL()
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValorSQLDeCampo - formata UM campo do cursor para o VALUES do INSERT,
    * pelo TIPO VFP do campo (nunca por palpite de nome) - helpers canonicos
    * do projeto, que ja devolvem COM aspas. Mesmo helper generico ja usado
    * em SigPrGlxBO/SigPrGlpBO.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValorSQLDeCampo(par_cCursor, par_cCampo, par_cTipo, par_nDec)
        LOCAL loc_uValor, loc_cRet

        loc_uValor = EVALUATE(par_cCursor + "." + par_cCampo)

        DO CASE
            CASE par_cTipo $ "CMVQ"
                loc_cRet = EscaparSQL(TratarNulo(loc_uValor, ""))
            CASE par_cTipo $ "NFIBY"
                loc_cRet = FormatarNumeroSQL(TratarNulo(loc_uValor, 0), par_nDec)
            CASE par_cTipo = "L"
                loc_cRet = IIF(TratarNulo(loc_uValor, .F.), "1", "0")
            CASE par_cTipo $ "DT"
                loc_cRet = FormatarDataSQL(TratarNulo(loc_uValor, {}))
            OTHERWISE
                loc_cRet = "NULL"
        ENDCASE

        RETURN loc_cRet
    ENDFUNC

    *--------------------------------------------------------------------------
    * PersistirCursor - grava em par_cTabela, linha a linha, TODAS as colunas
    * do cursor (que AbrirCursorTabela criou com a estrutura completa da
    * tabela). Mesmo helper generico ja usado em SigPrGlxBO/SigPrGlpBO.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION PersistirCursor(par_cCursor, par_cTabela)
        LOCAL loc_lOk, loc_nI, loc_nCampos, loc_cCols, loc_cVals, loc_cSQL, loc_nRet
        LOCAL ARRAY loc_aCampos[1, 18]

        loc_lOk = .T.

        IF !USED(par_cCursor) OR RECCOUNT(par_cCursor) = 0
            RETURN .T.
        ENDIF

        loc_nCampos = AFIELDS(loc_aCampos, par_cCursor)
        loc_cCols   = ""
        FOR loc_nI = 1 TO loc_nCampos
            loc_cCols = loc_cCols + IIF(loc_nI = 1, "", ", ") + LOWER(ALLTRIM(loc_aCampos[loc_nI, 1]))
        ENDFOR

        SELECT (par_cCursor)
        GO TOP
        SCAN
            loc_cVals = ""
            FOR loc_nI = 1 TO loc_nCampos
                loc_cVals = loc_cVals + IIF(loc_nI = 1, "", ", ") + ;
                    THIS.ValorSQLDeCampo(par_cCursor, ALLTRIM(loc_aCampos[loc_nI, 1]), ;
                        loc_aCampos[loc_nI, 2], loc_aCampos[loc_nI, 4])
            ENDFOR

            loc_cSQL = "INSERT INTO " + par_cTabela + " (" + loc_cCols + ") VALUES (" + loc_cVals + ")"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet < 0
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                    "(Update - " + par_cCursor + ") " + CapturarErroSQL()
                loc_lOk = .F.
                EXIT
            ENDIF
        ENDSCAN

        RETURN loc_lOk
    ENDFUNC

ENDDEFINE

