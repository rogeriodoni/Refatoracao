*==============================================================================
* SIGATCRPBO.PRG
* Business Object para Analitico de Atendimentos/Pendencias
* Tipo: REPORT
* Herda de RelatorioBase
*==============================================================================

DEFINE CLASS sigatcrpBO AS RelatorioBase

    *-- Propriedades
    this_cTabela       = "SigCdSOs"
    this_cCampoChave   = "NumOs"
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Retorna .T. (processamento feito no Form)
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

ENDDEFINE
