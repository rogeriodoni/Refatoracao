*==============================================================================
* RELATORIOBASE.PRG
* Classe base para Business Objects de Relatorios (tipo frmrelatorio)
*
* Herda de Custom
* Fornece estrutura padrao para BOs de relatorios
*==============================================================================

DEFINE CLASS RelatorioBase AS Custom

    *-- Propriedades padrao
    this_cTabela        = ""
    this_cCampoChave    = ""
    this_cMensagemErro  = ""
    this_oDataAccess    = .NULL.

    *--------------------------------------------------------------------------
    * Init - Construtor base
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Hook para preparar dados do relatorio
    * Subclasses devem sobrescrever
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria do registro atual
    * Subclasses devem sobrescrever
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao de auditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.this_oDataAccess = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE
