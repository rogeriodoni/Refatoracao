*==============================================================================
* SIGREG LABO.PRG
* Business Object para formulario operacional SigReGla
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS SigReGlaBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Identificacao da entidade
    * Form OPERACIONAL sem tabela CRUD - sem chave primaria
    *--------------------------------------------------------------------------
    this_cTabela     = ""
    this_cCampoChave = ""

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT("")
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    * Form operacional sem campos CRUD - implementacao vazia
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da chave primaria
    * Form operacional sem tabela CRUD
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro
    * Form operacional sem tabela CRUD - nao ha insercao
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .T.

        TRY
            THIS.RegistrarAuditoria("I")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente
    * Form operacional sem tabela CRUD - nao ha atualizacao
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .T.

        TRY
            THIS.RegistrarAuditoria("A")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
