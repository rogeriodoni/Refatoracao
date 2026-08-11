*==============================================================
* SIGBLCTABO.prg
* Business Object - Processamento de Bloqueio de Contas
* Herda de BusinessBase
* Migrado de SIGBLCTA.SCX
*==============================================================

DEFINE CLASS SIGBLCTABO AS BusinessBase

    *-- Tabela principal afetada pelo processamento
    this_cTabela      = "SigCdCli"
    this_cCampoChave  = "IClis"
    this_cMensagemErro = ""

    *============================================================
    PROCEDURE Init
    *============================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF DODEFAULT()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *============================================================
    PROCEDURE Destroy
    *============================================================
        DODEFAULT()
    ENDPROC

    *============================================================
    PROCEDURE ObterChavePrimaria
    *============================================================
        RETURN ALLTRIM(THIS.this_cCampoChave)
    ENDPROC

    *============================================================
    PROCEDURE Buscar
    *============================================================
    LPARAMETERS par_cFiltro
        *-- Consultas executadas diretamente no form (OPERACIONAL)
        RETURN .T.
    ENDPROC

ENDDEFINE
