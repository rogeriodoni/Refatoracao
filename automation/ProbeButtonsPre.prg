*==============================================================================
* ProbeButtonsPre.prg - se os QUATRO padroes de acesso a Buttons(N) funcionam
* (medido em ProbeButtonsWith.prg), o que de fato quebrava no Erro42?
* Hipotese: a PRE-CONDICAO - indice fora do ButtonCount vigente.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_oT, loc_cOut
loc_cOut = "PROBE pre-condicao de Buttons(N) - " + TTOC(DATETIME()) + CHR(13) + CHR(10)

loc_oT   = CREATEOBJECT("ProbeHost2")
loc_cOut = loc_cOut + "ButtonCount default de OptionGroup via AddObject = " + ;
           TRANSFORM(loc_oT.ContagemDefault()) + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "A Buttons(1) ANTES de setar ButtonCount ........ " + loc_oT.TestarAntes()     + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "B Buttons(3) com ButtonCount = 2 .............. " + loc_oT.TestarForaDoAlcance() + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "C Buttons(3) DEPOIS de ButtonCount = 3 ........ " + loc_oT.TestarDepoisDeCrescer() + CHR(13) + CHR(10)

STRTOFILE(loc_cOut, "C:\4c\automation\probe_buttons_pre_result.txt")
QUIT

DEFINE CLASS ProbeHost2 AS Form
    PROCEDURE Init()
        THIS.AddObject("opt_4c_A", "OptionGroup")
        THIS.AddObject("opt_4c_B", "OptionGroup")
        THIS.AddObject("opt_4c_C", "OptionGroup")
    ENDPROC

    PROCEDURE ContagemDefault()
        RETURN THIS.opt_4c_A.ButtonCount
    ENDPROC

    PROCEDURE TestarAntes()
        LOCAL loc_c, loc_oE
        TRY
            WITH THIS.opt_4c_A
                WITH .Buttons(1)
                    .Caption = "X"
                ENDWITH
            ENDWITH
            loc_c = "OK    B1=[" + THIS.opt_4c_A.Buttons(1).Caption + "]"
        CATCH TO loc_oE
            loc_c = "FALHOU -> " + loc_oE.Message
        ENDTRY
        RETURN loc_c
    ENDPROC

    PROCEDURE TestarForaDoAlcance()
        LOCAL loc_c, loc_oE
        TRY
            THIS.opt_4c_B.ButtonCount = 2
            WITH THIS.opt_4c_B
                WITH .Buttons(3)
                    .Caption = "X"
                ENDWITH
            ENDWITH
            loc_c = "OK (inesperado)"
        CATCH TO loc_oE
            loc_c = "FALHOU -> " + loc_oE.Message
        ENDTRY
        RETURN loc_c
    ENDPROC

    PROCEDURE TestarDepoisDeCrescer()
        LOCAL loc_c, loc_oE
        TRY
            THIS.opt_4c_C.ButtonCount = 3
            WITH THIS.opt_4c_C
                WITH .Buttons(3)
                    .Caption = "Terceiro"
                ENDWITH
            ENDWITH
            loc_c = "OK    B3=[" + THIS.opt_4c_C.Buttons(3).Caption + "]"
        CATCH TO loc_oE
            loc_c = "FALHOU -> " + loc_oE.Message
        ENDTRY
        RETURN loc_c
    ENDPROC
ENDDEFINE
