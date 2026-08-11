*==============================================================================
* SIGREPESBO.PRG
* Business Object para Relatorio de Posicao de Estoque
* Herda de: RelatorioBase
*==============================================================================

DEFINE CLASS SigrepesBO AS RelatorioBase

    this_cTabela       = "SigCdPro"
    this_cCampoChave   = "CPros"
    this_cMensagemErro = ""

    PROCEDURE Init()
        DODEFAULT()
        RETURN .T.
    ENDPROC

    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ""
        IF USED(THIS.this_cTabela)
            loc_cChave = EVALUATE(THIS.this_cTabela + "." + THIS.this_cCampoChave)
        ENDIF
        RETURN loc_cChave
    ENDPROC

    PROCEDURE PrepararDados()
        RETURN .T.
    ENDPROC

    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

ENDDEFINE
