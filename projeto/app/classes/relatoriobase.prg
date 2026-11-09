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
    * ReportFormIsolado - Executa REPORT FORM com o locale/motor dos FRX legados
    *   FRXs Fortyus (VFP6/7/8) foram desenhados com SET POINT "." e motor de
    *   relatorio 80. O app roda com POINT "," / SEPARATOR "." e
    *   REPORTBEHAVIOR 90 (config.prg): sem isolar, o motor 90 remede as
    *   fontes e os campos numericos saem como "*****" (Erro28 / Erro328).
    *   Restaura os SETs mesmo em erro (FINALLY) e, apos PREVIEW, recria o
    *   menu (Erro63: a toolbar do preview corrompe o _MSYSMENU).
    *   Metodo (e nao funcao) de proposito: FRX que usa "this.name" precisa de
    *   THIS = BO, e PRIVATEs declaradas pelo chamador seguem visiveis aqui.
    *   par_cFRX     : caminho do .frx (com ou sem extensao)
    *   par_cModo    : "PREVIEW" | "PRINTER_PROMPT" | "PRINTER" | "ASCII"
    *   par_cArquivo : arquivo de saida (so para "ASCII")
    *--------------------------------------------------------------------------
    PROCEDURE ReportFormIsolado(par_cFRX, par_cModo, par_cArquivo, par_lDecimalVirgula)
        *-- par_lDecimalVirgula (opcional): FRX que o proprio legado imprimia
        *   com SET POINT TO "," / SEPARATOR "." (ex.: SigReDp7)
        LOCAL loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig
        loc_cPointOrig    = SET("POINT")
        loc_cSepOrig      = SET("SEPARATOR")
        loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
        TRY
            IF VARTYPE(par_lDecimalVirgula) = "L" AND par_lDecimalVirgula
                SET POINT TO ","
                SET SEPARATOR TO "."
            ELSE
                SET POINT TO "."
                SET SEPARATOR TO ","
            ENDIF
            SET REPORTBEHAVIOR 80
            DO CASE
                CASE par_cModo == "PREVIEW"
                    REPORT FORM (par_cFRX) PREVIEW NOCONSOLE
                CASE par_cModo == "PRINTER_PROMPT"
                    REPORT FORM (par_cFRX) TO PRINTER PROMPT NOCONSOLE
                CASE par_cModo == "PRINTER"
                    REPORT FORM (par_cFRX) TO PRINTER NOCONSOLE
                CASE par_cModo == "ASCII"
                    REPORT FORM (par_cFRX) TO FILE (par_cArquivo) ASCII NOCONSOLE
            ENDCASE
        FINALLY
            SET POINT TO (loc_cPointOrig)
            SET SEPARATOR TO (loc_cSepOrig)
            SET REPORTBEHAVIOR (loc_nBehaviorOrig)
        ENDTRY

        IF par_cModo == "PREVIEW"
            TRY
                SET SYSMENU TO DEFAULT
                RELEASE POPUP popArquivo, popCadastros, popMovimentos, popRelatorios, popFerramentas, popAjuda
                CriarMenuPrincipal()
            CATCH
                *-- CriarMenuPrincipal fora do escopo (teste automatizado) - silencioso
            ENDTRY
        ENDIF
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
