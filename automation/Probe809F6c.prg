*==============================================================================
* Probe809F6c.prg - mede se o delegate ligado ao evento "When" por BINDEVENT
* REALMENTE DISPARA (o Probe809F6 provou que o bind EXISTE; isto prova que
* ele EXECUTA).
*
* Metodo: o efeito colateral dos When desta fase eh SET CONFIRM OFF/ON, que
* eh observavel por SET("CONFIRM"). Aciona-se o evento nativo do controle
* (obj.When()) com SET CONFIRM ON e confere-se se virou OFF.
*
* Tambem mede o par de volta (LostFocus -> SET CONFIRM ON) e o caso em que o
* When do legado NAO desliga o confirm (GetParcela com resposta ja valida,
* que em vez disso enfileira TAB).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado

#DEFINE OUT3 "C:\4c\automation\probe_809f6c.txt"

LOCAL loc_oE, loc_oForm, loc_cRel

loc_cRel = "=== PROBE Fase 6c - o delegate de When DISPARA? ===" + CHR(13) + CHR(10)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gb_4c_ModoTeste        = .T.
    gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_809f6c.txt"
    gc_4c_UsuarioLogado    = "TESTE"
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "sigoptefBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\Formsigoptef.prg") ADDITIVE
    gnConnHandle = -1
    loc_oForm = CREATEOBJECT("Formsigoptef")
    loc_cRel = loc_cRel + "[1] form VARTYPE=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10)
CATCH TO loc_oE
    loc_cRel = loc_cRel + "[1] FALHA: " + loc_oE.Message + " LN=" + TRANSFORM(loc_oE.LineNo) + CHR(13) + CHR(10)
ENDTRY

IF VARTYPE(loc_oForm) = "O"
    *-- GetDigitos.When com campo VAZIO: deve desligar o CONFIRM
    TRY
        SET CONFIRM ON
        loc_oForm.txt_4c_Digitos.Value = ""
        loc_oForm.txt_4c_Digitos.When()
        loc_cRel = loc_cRel + "[2] Digitos vazio   : When() -> CONFIRM=" + SET("CONFIRM") + ;
            "   (esperado OFF = delegate DISPAROU)" + CHR(13) + CHR(10)
    CATCH TO loc_oE
        loc_cRel = loc_cRel + "[2] EXCECAO: " + loc_oE.Message + CHR(13) + CHR(10)
    ENDTRY

    *-- GetDigitos.LostFocus: par de volta, religa o CONFIRM
    TRY
        loc_oForm.txt_4c_Digitos.LostFocus()
        loc_cRel = loc_cRel + "[3] Digitos         : LostFocus() -> CONFIRM=" + SET("CONFIRM") + ;
            "   (esperado ON)" + CHR(13) + CHR(10)
    CATCH TO loc_oE
        loc_cRel = loc_cRel + "[3] EXCECAO: " + loc_oE.Message + CHR(13) + CHR(10)
    ENDTRY

    *-- GetDigitos.When com campo PREENCHIDO: o legado NAO desliga o confirm
    TRY
        SET CONFIRM ON
        loc_oForm.txt_4c_Digitos.Value = "1234"
        loc_oForm.txt_4c_Digitos.When()
        loc_cRel = loc_cRel + "[4] Digitos '1234'  : When() -> CONFIRM=" + SET("CONFIRM") + ;
            "   (esperado ON - o IF do legado nao entra)" + CHR(13) + CHR(10)
        loc_oForm.txt_4c_Digitos.Value = ""
    CATCH TO loc_oE
        loc_cRel = loc_cRel + "[4] EXCECAO: " + loc_oE.Message + CHR(13) + CHR(10)
    ENDTRY

    *-- Text1.When: desliga sempre (linha unica no legado)
    TRY
        SET CONFIRM ON
        loc_oForm.txt_4c_Text1.When()
        loc_cRel = loc_cRel + "[5] Text1           : When() -> CONFIRM=" + SET("CONFIRM") + ;
            "   (esperado OFF)" + CHR(13) + CHR(10)
        loc_oForm.txt_4c_Text1.LostFocus()
        loc_cRel = loc_cRel + "[6] Text1           : LostFocus() -> CONFIRM=" + SET("CONFIRM") + ;
            "   (esperado ON)" + CHR(13) + CHR(10)
    CATCH TO loc_oE
        loc_cRel = loc_cRel + "[5/6] EXCECAO: " + loc_oE.Message + CHR(13) + CHR(10)
    ENDTRY

    *-- GetCodSeg.When vazio: desliga
    TRY
        SET CONFIRM ON
        loc_oForm.txt_4c_Codigo.Value = ""
        loc_oForm.txt_4c_Codigo.When()
        loc_cRel = loc_cRel + "[7] CodSeg vazio    : When() -> CONFIRM=" + SET("CONFIRM") + ;
            "   (esperado OFF)" + CHR(13) + CHR(10)
    CATCH TO loc_oE
        loc_cRel = loc_cRel + "[7] EXCECAO: " + loc_oE.Message + CHR(13) + CHR(10)
    ENDTRY

    *-- GetParcela.When com resposta JA valida: o legado NAO desliga o
    *-- confirm; enfileira TAB. CLEAR TYPEAHEAD no fim para nao vazar tecla.
    TRY
        SET CONFIRM ON
        loc_oForm.txt_4c_Parcela.Value = "1"
        loc_oForm.txt_4c_Parcela.When()
        loc_cRel = loc_cRel + "[8] Parcela '1'     : When() -> CONFIRM=" + SET("CONFIRM") + ;
            "   (esperado ON - ramo do ELSE, que enfileira TAB)" + CHR(13) + CHR(10)
        CLEAR TYPEAHEAD
        SET CONFIRM ON
        loc_oForm.txt_4c_Parcela.Value = ""
        loc_oForm.txt_4c_Parcela.When()
        loc_cRel = loc_cRel + "[9] Parcela vazio   : When() -> CONFIRM=" + SET("CONFIRM") + ;
            "   (esperado OFF - ramo do IF)" + CHR(13) + CHR(10)
        CLEAR TYPEAHEAD
    CATCH TO loc_oE
        loc_cRel = loc_cRel + "[8/9] EXCECAO: " + loc_oE.Message + CHR(13) + CHR(10)
    ENDTRY

    SET CONFIRM ON

    TRY
        loc_oForm.Release()
    CATCH TO loc_oE
    ENDTRY
ENDIF

loc_cRel = loc_cRel + "=== FIM ===" + CHR(13) + CHR(10)
STRTOFILE(loc_cRel, OUT3)
QUIT
