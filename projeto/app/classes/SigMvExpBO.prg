*====================================================================
* SigMvExpBO.prg
*
* Business Object para o formulario operacional SigMvExp
* (despachante de movimentacao - abre SigMvCab no modo Entrada/
*  Conferencia(Caixa)/Alteracao conforme o Tipo de operacao)
* Tabela: SigMvCab
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigMvExpBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigMvCab / parametros de despacho)
    this_cDope      = ""    && dopes char(20) - codigo da operacao (Dope)
    this_cTipo      = ""    && opers char(1) - tipo de movimento: E=Entrada, C=Conferencia(Caixa), A=Alteracao
    this_nNume      = 0     && numes numeric(6,0) - numero do movimento
    this_cEmp       = ""    && emps char(3) - empresa
    this_nCaixa     = 0     && codigo do caixa (contexto de conferencia)
    this_cGrupoOper = ""    && grupo de operacoes associado ao Dope
    this_lMacro     = .F.   && indica se a chamada veio de execucao via macro
    this_lErro      = .F.   && indica se houve erro na inicializacao/processamento

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMvCab"
            THIS.this_cCampoChave = "numes"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigMvExpBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - identifica o despacho corrente para auditoria
    *
    * Este BO NAO grava em SigMvCab: ele apenas despacha (Do Form SigMvCab)
    * conforme o Tipo de operacao (E=Entrada, C=Conferencia/Caixa,
    * A=Alteracao), reproduzindo Procedure Click do legado (linhas 167-180
    * de SigMvExp_form_codigo_fonte.txt). Quem faz o INSERT/UPDATE real do
    * movimento e o form/BO de SigMvCab, aberto por THIS via DO FORM.
    * Por isso Inserir()/Atualizar()/CarregarDoCursor() permanecem os da
    * BusinessBase (nao ha registro proprio deste BO para inserir/atualizar/
    * carregar) - sobrescreve-los aqui seria fabricar CRUD que a tela nao
    * executa. ObterChavePrimaria e sobrescrito porque identifica o
    * despacho (Dope+Numero+Empresa) caso RegistrarAuditoria venha a ser
    * chamado por quem consumir este BO.
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cDope) + "|" + TRANSFORM(THIS.this_nNume) + "|" + ALLTRIM(THIS.this_cEmp)
    ENDPROC

ENDDEFINE
