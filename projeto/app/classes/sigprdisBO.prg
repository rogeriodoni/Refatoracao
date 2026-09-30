*====================================================================
* sigprdisBO.prg
*
* Business Object do formulario SIGPRDIS (Distribuicao de Produtos)
* Tabela: SigPrDis
* Herda de: BusinessBase
*
* MIGRACAO MULTI-FASE (8 fases) - FASE 1/8: Propriedades e Init
* Fases seguintes completam CarregarDoCursor(), Inserir(), Atualizar(),
* ExecutarExclusao(), Buscar(), CarregarPorCodigo() e ObterChavePrimaria().
*====================================================================

DEFINE CLASS sigprdisBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigPrDis)
    this_cCidChave         = ""    && cidchaves     char(20)  - PK (Fortyus)
    this_cCodigo           = ""    && codigos       char(10)  - Codigo do lote de distribuicao
    this_cCodProduto       = ""    && cpros         char(14)  - Codigo do produto
    this_cCodCor           = ""    && codcors       char(4)   - Codigo da cor
    this_cCodTamanho       = ""    && codtams       char(4)   - Codigo do tamanho
    this_dData             = {}    && datas         datetime  - Data da distribuicao
    this_dDataAlteracao    = {}    && dtalts        datetime  - Data da ultima alteracao
    this_cEmpDopNum        = ""    && empdopnums    char(29)  - Empresa+Documento+Numero de origem
    this_cOriDopNum        = ""    && oridopnums    char(29)  - Empresa+Documento+Numero original
    this_cEmpDestino       = ""    && empds         char(3)   - Empresa de destino
    this_cEmpGrupoEstab    = ""    && empgruests    char(23)  - Empresa+Grupo+Estabelecimento
    this_cLocal            = ""    && locals        char(10)  - Local de estoque
    this_nQtdOrigem        = 0     && qtdos         numeric(10,2) - Quantidade de origem
    this_nQtd              = 0     && qtds          numeric(10,2) - Quantidade distribuida
    this_cUsuario          = ""    && usuars        char(10)  - Usuario de inclusao
    this_cUsuarioAlteracao = ""    && usualts       char(10)  - Usuario de alteracao

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrDis"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "sigprdisBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
