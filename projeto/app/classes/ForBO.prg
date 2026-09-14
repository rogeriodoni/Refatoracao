*====================================================================
* ForBO.prg
*
* Business Object para Cadastro de Formas de Pagamento
* Tabela: SigCdFrm
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS ForBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdFrm)
    this_cFormas = ""    && formas char(12) - PK (Forma de Pagamento)
    this_cInfos  = ""    && infos  char(1)  - Inf. Complementar (FK SigPrInf)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdFrm"
            THIS.this_cCampoChave = "formas"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "ForBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
