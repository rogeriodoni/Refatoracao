SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET DECIMALS TO 2
SET DATE TO BRITISH
SET CENTURY ON

LOCAL loc_cOut, loc_cBO, loc_oBO, loc_nI, loc_cChave
loc_cOut = "C:\4c\automation\_probe747f2.txt"
loc_cBO  = "C:\4c\projeto\app\classes\SigOpIgmBO.prg"

STRTOFILE("=== PROBE task747 Fase 2 ===" + CHR(13) + CHR(10), loc_cOut)

*-- 1) COMPILE isolado (gera .ERR se houver erro de sintaxe)
ERASE C:\4c\projeto\app\classes\SigOpIgmBO.ERR
COMPILE (loc_cBO)
IF FILE("C:\4c\projeto\app\classes\SigOpIgmBO.ERR")
    STRTOFILE("COMPILE: ERRO" + CHR(13) + CHR(10), loc_cOut, 1)
    STRTOFILE(FILETOSTR("C:\4c\projeto\app\classes\SigOpIgmBO.ERR") + CHR(13) + CHR(10), loc_cOut, 1)
ELSE
    STRTOFILE("COMPILE: OK (sem .ERR)" + CHR(13) + CHR(10), loc_cOut, 1)
ENDIF
STRTOFILE("FXP existe: " + TRANSFORM(FILE("C:\4c\projeto\app\classes\SigOpIgmBO.FXP")) + CHR(13) + CHR(10), loc_cOut, 1)

*-- 2) Instanciar (sem conexao: PUBLIC gnConnHandle = -1)
PUBLIC gnConnHandle, gc_4c_UsuarioLogado, gb_4c_ModoTeste
gnConnHandle = -1
gc_4c_UsuarioLogado = "PROBE"
gb_4c_ModoTeste = .T.

SET PROCEDURE TO C:\4c\projeto\app\utils\functions.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\messages.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\businessbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\dataaccess.prg ADDITIVE
SET PROCEDURE TO (loc_cBO) ADDITIVE

TRY
    loc_oBO = CREATEOBJECT("SigOpIgmBO")
    STRTOFILE("CREATEOBJECT: VARTYPE=" + VARTYPE(loc_oBO) + CHR(13) + CHR(10), loc_cOut, 1)
CATCH TO loErr
    STRTOFILE("CREATEOBJECT FALHOU: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + CHR(13) + CHR(10), loc_cOut, 1)
ENDTRY

IF VARTYPE(loc_oBO) = "O"
    *-- 3) Chave posicional: tem de dar 29 chars (3 + 20 + 6)
    loc_cChave = loc_oBO.MontarChaveEmpDnCrds("001", "MALOTE", 3)
    STRTOFILE("CHAVE LEN=" + TRANSFORM(LEN(loc_cChave)) + " [" + loc_cChave + "]" + CHR(13) + CHR(10), loc_cOut, 1)

    *-- DefinirParametros
    loc_oBO.DefinirParametros("001", "MALOTE", 3, .T., 0)
    STRTOFILE("PARAM Emps=[" + loc_oBO.this_cEmps + "] Dopes=[" + loc_oBO.this_cDopes + "] Numes=" + ;
        TRANSFORM(loc_oBO.this_nNumes) + " ChkImpDoc=" + TRANSFORM(loc_oBO.this_lChkImpDoc) + ;
        " ChaveLen=" + TRANSFORM(LEN(loc_oBO.this_cChaveEmpDnCrds)) + CHR(13) + CHR(10), loc_cOut, 1)

    *-- 4) Cursor da grade
    STRTOFILE("CriarCursorMovimentacoes=" + TRANSFORM(loc_oBO.CriarCursorMovimentacoes()) + ;
        " USED=" + TRANSFORM(USED("cursor_4c_Pgto")) + CHR(13) + CHR(10), loc_cOut, 1)
    IF USED("cursor_4c_Pgto")
        STRTOFILE("  FCOUNT=" + TRANSFORM(FCOUNT("cursor_4c_Pgto")) + ;
            " Buffering=" + TRANSFORM(CURSORGETPROP("Buffering", "cursor_4c_Pgto")) + CHR(13) + CHR(10), loc_cOut, 1)
        SELECT cursor_4c_Pgto
        FOR loc_nI = 1 TO FCOUNT()
            STRTOFILE("  campo " + TRANSFORM(loc_nI) + ": " + FIELD(loc_nI) + " " + TYPE(FIELD(loc_nI)) + CHR(13) + CHR(10), loc_cOut, 1)
        ENDFOR
        *-- idempotencia (2a chamada faz ZAP e NAO pode pendurar)
        STRTOFILE("CriarCursorMovimentacoes 2a vez=" + TRANSFORM(loc_oBO.CriarCursorMovimentacoes()) + CHR(13) + CHR(10), loc_cOut, 1)

        *-- REPLACE numa linha inserida a mao (prova READWRITE)
        INSERT INTO cursor_4c_Pgto (Marca, Obs, Printed, Valos, Emps, Dopes, Numes, Valdevs, Docus) ;
            VALUES (.T., PADR("MALOTE", 20) + " " + STR(3, 6), .F., 150.50, "001", PADR("MALOTE", 20), 3, 0, 1)
        GO TOP
        STRTOFILE("CarregarDoCursor=" + TRANSFORM(loc_oBO.CarregarDoCursor("cursor_4c_Pgto")) + ;
            " LinhaEmps=[" + loc_oBO.this_cLinhaEmps + "] LinhaDopes=[" + loc_oBO.this_cLinhaDopes + ;
            "] Numes=" + TRANSFORM(loc_oBO.this_nLinhaNumes) + " Valos=" + TRANSFORM(loc_oBO.this_nLinhaValos) + ;
            " Docus=" + TRANSFORM(loc_oBO.this_nLinhaDocus) + " Marca=" + TRANSFORM(loc_oBO.this_lLinhaMarca) + ;
            " Obs=[" + loc_oBO.this_cLinhaObs + "]" + CHR(13) + CHR(10), loc_cOut, 1)
        STRTOFILE("  ObsLen=" + TRANSFORM(LEN(loc_oBO.this_cLinhaObs)) + CHR(13) + CHR(10), loc_cOut, 1)
        STRTOFILE("ContarMarcadas=" + TRANSFORM(loc_oBO.ContarMarcadas()) + " RECNO=" + TRANSFORM(RECNO("cursor_4c_Pgto")) + CHR(13) + CHR(10), loc_cOut, 1)
        STRTOFILE("MarcarLinhaComoImpressa=" + TRANSFORM(loc_oBO.MarcarLinhaComoImpressa()) + ;
            " Marca=" + TRANSFORM(cursor_4c_Pgto.Marca) + " Printed=" + TRANSFORM(cursor_4c_Pgto.Printed) + CHR(13) + CHR(10), loc_cOut, 1)
        STRTOFILE("ContarMarcadas apos=" + TRANSFORM(loc_oBO.ContarMarcadas()) + CHR(13) + CHR(10), loc_cOut, 1)
        STRTOFILE("ValidarDados=" + TRANSFORM(loc_oBO.ValidarDados()) + CHR(13) + CHR(10), loc_cOut, 1)
    ENDIF

    *-- 5) Do Case do boleto (sem banco: so as properties)
    loc_oBO.this_cConfigGers = ""
    loc_oBO.this_nBolItes = 3
    STRTOFILE("ResolverTipoBoleto BolItes=3 -> " + TRANSFORM(loc_oBO.ResolverTipoBoleto()) + " (esperado 11)" + CHR(13) + CHR(10), loc_cOut, 1)
    loc_oBO.this_nBolItes = 4
    STRTOFILE("ResolverTipoBoleto BolItes=4 -> " + TRANSFORM(loc_oBO.ResolverTipoBoleto()) + " (esperado 13)" + CHR(13) + CHR(10), loc_cOut, 1)
    loc_oBO.this_nBolItes = 5
    STRTOFILE("ResolverTipoBoleto BolItes=5 -> " + TRANSFORM(loc_oBO.ResolverTipoBoleto()) + " (esperado 14)" + CHR(13) + CHR(10), loc_cOut, 1)
    loc_oBO.this_nBolItes = 6
    STRTOFILE("ResolverTipoBoleto BolItes=6 -> " + TRANSFORM(loc_oBO.ResolverTipoBoleto()) + " (esperado 16)" + CHR(13) + CHR(10), loc_cOut, 1)
    loc_oBO.this_nBolItes = 7
    STRTOFILE("ResolverTipoBoleto BolItes=7 -> " + TRANSFORM(loc_oBO.ResolverTipoBoleto()) + " (esperado 17)" + CHR(13) + CHR(10), loc_cOut, 1)
    loc_oBO.this_nBolItes = 8
    STRTOFILE("ResolverTipoBoleto BolItes=8 -> " + TRANSFORM(loc_oBO.ResolverTipoBoleto()) + " (esperado 18)" + CHR(13) + CHR(10), loc_cOut, 1)
    loc_oBO.this_nBolItes = 1
    STRTOFILE("ResolverTipoBoleto BolItes=1 -> " + TRANSFORM(loc_oBO.ResolverTipoBoleto()) + " (esperado 3)" + CHR(13) + CHR(10), loc_cOut, 1)
    loc_oBO.this_cConfigGers = PADR("", 232) + "22" + SPACE(16)
    STRTOFILE("ResolverTipoBoleto ConfigGers[233..234]='22' -> " + TRANSFORM(loc_oBO.ResolverTipoBoleto()) + " (esperado 22)" + CHR(13) + CHR(10), loc_cOut, 1)
    loc_oBO.this_cConfigGers = ""

    *-- 6) Visibilidade do botao Boleto
    FOR loc_nI = 0 TO 4
        loc_oBO.this_nVenBols = loc_nI
        STRTOFILE("DeveExibirBotaoBoleto VenBols=" + TRANSFORM(loc_nI) + " -> " + TRANSFORM(loc_oBO.DeveExibirBotaoBoleto()) + CHR(13) + CHR(10), loc_cOut, 1)
    ENDFOR

    *-- 7) Metodo PROTECTED nao pode ser chamado de fora (regra #51)
    STRTOFILE("PEMSTATUS ObterChavePrimaria protected(2)=" + TRANSFORM(PEMSTATUS(loc_oBO, "ObterChavePrimaria", 2)) + CHR(13) + CHR(10), loc_cOut, 1)
    STRTOFILE("PEMSTATUS CarregarDoCursor protected(2)=" + TRANSFORM(PEMSTATUS(loc_oBO, "CarregarDoCursor", 2)) + CHR(13) + CHR(10), loc_cOut, 1)
    STRTOFILE("PEMSTATUS ValidarDados protected(2)=" + TRANSFORM(PEMSTATUS(loc_oBO, "ValidarDados", 2)) + CHR(13) + CHR(10), loc_cOut, 1)
    STRTOFILE("PEMSTATUS Buscar protected(2)=" + TRANSFORM(PEMSTATUS(loc_oBO, "Buscar", 2)) + CHR(13) + CHR(10), loc_cOut, 1)
    STRTOFILE("PEMSTATUS ImprimirDocumentoDaLinha protected(2)=" + TRANSFORM(PEMSTATUS(loc_oBO, "ImprimirDocumentoDaLinha", 2)) + CHR(13) + CHR(10), loc_cOut, 1)

    *-- 8) Destroy fecha os cursores
    loc_oBO = .NULL.
    STRTOFILE("apos Destroy: USED(cursor_4c_Pgto)=" + TRANSFORM(USED("cursor_4c_Pgto")) + CHR(13) + CHR(10), loc_cOut, 1)
ENDIF

STRTOFILE("=== FIM ===" + CHR(13) + CHR(10), loc_cOut, 1)
QUIT
