*=============================================================================*
* SIGPRCICBO.prg - Business Object para Escolha de Icones de Programas
*=============================================================================*
* Herda de: BusinessBase
* Form associado: FormSIGPRCIC.prg (forms\operacionais\)
* Descricao: Gerencia selecao de icones para programas/menus.
*            Opera sobre cursores em memoria (crProg1/crProg2/crSigSyIco1)
*            compartilhados via DataSession do form pai.
*            Nao possui tabela SQL Server propria.
*=============================================================================*

DEFINE CLASS SIGPRCICBO AS BusinessBase

    *-- Chave do programa cujo icone sera alterado (pkChaves de crProg1/crProg2)
    this_cIdChaves      = ""

    *-- Nome/descricao do programa (crProg2.descricaos)
    this_cPrograma      = ""

    *-- Icone atual do programa ao abrir (crProg2.barrapict)
    this_cArqIconeAtual = ""

    *-- Icone selecionado pelo usuario (carqicones da linha corrente do grid)
    this_cArqIcone      = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa BO sem tabela SQL propria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor crProg2
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cPrograma      = TratarNulo(descricaos, "C")
            THIS.this_cArqIconeAtual = TratarNulo(barrapict,  "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorChave - Localiza programa por pkChaves em crProg2 e carrega propriedades
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorChave(par_cIdChaves)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        THIS.this_cIdChaves = ALLTRIM(par_cIdChaves)

        TRY
            IF USED("crProg2") AND SEEK(THIS.this_cIdChaves, "crProg2", "pkChaves")
                SELECT crProg2
                THIS.this_cPrograma      = TratarNulo(descricaos, "C")
                THIS.this_cArqIconeAtual = TratarNulo(barrapict,  "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SelecionarIcone - Aplica icone escolhido nos cursores crProg1 e crProg2
    *   via VFP REPLACE (esta BO nao usa SQLEXEC - opera em cursores em memoria)
    *--------------------------------------------------------------------------
    PROCEDURE SelecionarIcone(par_cArqIcone)
        LOCAL loc_lSucesso, loc_cArqIcone

        loc_lSucesso  = .F.
        loc_cArqIcone = LOWER(ALLTRIM(par_cArqIcone))

        IF loc_cArqIcone == "< nenhum >"
            loc_cArqIcone = ""
        ENDIF

        THIS.this_cArqIcone = loc_cArqIcone

        TRY
            IF USED("crProg1") AND SEEK(THIS.this_cIdChaves, "crProg1", "pkChaves")
                SELECT crProg1
                REPLACE barrapict WITH loc_cArqIcone, ;
                        barraforms WITH IIF(!EMPTY(barraforms), barraforms, crProg1.programas) ;
                        IN ("crProg1")
            ENDIF

            IF USED("crProg2") AND SEEK(THIS.this_cIdChaves, "crProg2", "pkChaves")
                SELECT crProg2
                REPLACE barrapict WITH loc_cArqIcone, ;
                        barraforms WITH IIF(!EMPTY(barraforms), barraforms, crProg2.programas) ;
                        IN ("crProg2")
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel: esta BO opera sobre cursores VFP, nao SQL Server
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Delega para SelecionarIcone com o icone ja carregado em this_cArqIcone
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN THIS.SelecionarIcone(THIS.this_cArqIcone)
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificador do programa (pkChaves)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cIdChaves
    ENDPROC

ENDDEFINE
