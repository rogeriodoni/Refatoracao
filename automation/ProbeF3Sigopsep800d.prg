SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_CaminhoFramework, gc_4c_CaminhoIcones, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste    = .T.
gb_4c_ValidandoUI  = .T.
gc_4c_CaminhoFramework = "C:\4c\Framework\"
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gc_4c_ArquivoErroTeste = "C:\4c\automation\_erro_f3_sigopsep800d.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cSaida, loc_oForm, loc_oErro, loc_oCab, loc_oFormPaiFake
loc_cOut = "C:\4c\automation\probe_f3_sigopsep800d.txt"
loc_cSaida = "START" + CHR(13) + CHR(10)
STRTOFILE(loc_cSaida, loc_cOut)

TRY
    SET PROCEDURE TO "C:\4c\projeto\app\utils\messages.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\utils\functions.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\dataaccess.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\businessbase.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\formbase.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\sigopsepBO.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\Formsigopsep.prg" ADDITIVE
    loc_cSaida = loc_cSaida + "1 PROCS_LOADED" + CHR(13) + CHR(10)
    STRTOFILE(loc_cSaida, loc_cOut)

    loc_oFormPaiFake = CREATEOBJECT("Form")
    loc_oFormPaiFake.Enabled = .F.
    loc_cSaida = loc_cSaida + "2 PAI_CRIADO" + CHR(13) + CHR(10)
    STRTOFILE(loc_cSaida, loc_cOut)

    loc_oForm = CREATEOBJECT("Formsigopsep", loc_oFormPaiFake)
    loc_cSaida = loc_cSaida + "3 CREATEOBJECT=[" + VARTYPE(loc_oForm) + "]" + CHR(13) + CHR(10)
    STRTOFILE(loc_cSaida, loc_cOut)

    IF VARTYPE(loc_oForm) = "O"
        loc_cSaida = loc_cSaida + "4 BaseClass=[" + loc_oForm.BaseClass + "]" + CHR(13) + CHR(10)
        STRTOFILE(loc_cSaida, loc_cOut)

        loc_cSaida = loc_cSaida + "5 Caption=[" + loc_oForm.Caption + "]" + CHR(13) + CHR(10)
        STRTOFILE(loc_cSaida, loc_cOut)

        loc_cSaida = loc_cSaida + "6 Width=[" + TRANSFORM(loc_oForm.Width) + "]" + CHR(13) + CHR(10)
        STRTOFILE(loc_cSaida, loc_cOut)

        loc_cSaida = loc_cSaida + "7 ControlCount=[" + TRANSFORM(loc_oForm.ControlCount) + "]" + CHR(13) + CHR(10)
        STRTOFILE(loc_cSaida, loc_cOut)

        loc_cSaida = loc_cSaida + "8 PEMSTATUS cnt_4c_Sombra=[" + TRANSFORM(PEMSTATUS(loc_oForm, "cnt_4c_Sombra", 5)) + "]" + CHR(13) + CHR(10)
        STRTOFILE(loc_cSaida, loc_cOut)

        IF PEMSTATUS(loc_oForm, "cnt_4c_Sombra", 5)
            loc_oCab = loc_oForm.cnt_4c_Sombra
            loc_cSaida = loc_cSaida + "9 loc_oCab_atribuido=[" + VARTYPE(loc_oCab) + "]" + CHR(13) + CHR(10)
            STRTOFILE(loc_cSaida, loc_cOut)

            loc_cSaida = loc_cSaida + "10 cnt_Visible=[" + TRANSFORM(loc_oCab.Visible) + "]" + CHR(13) + CHR(10)
            STRTOFILE(loc_cSaida, loc_cOut)

            loc_cSaida = loc_cSaida + "11 cnt_BackColor=[" + TRANSFORM(loc_oCab.BackColor) + "]" + CHR(13) + CHR(10)
            STRTOFILE(loc_cSaida, loc_cOut)

            loc_cSaida = loc_cSaida + "12 lbl_Sombra_Caption=[" + loc_oCab.lbl_4c_Sombra.Caption + "]" + CHR(13) + CHR(10)
            STRTOFILE(loc_cSaida, loc_cOut)

            loc_cSaida = loc_cSaida + "13 lbl_Titulo_Caption=[" + loc_oCab.lbl_4c_Titulo.Caption + "]" + CHR(13) + CHR(10)
            STRTOFILE(loc_cSaida, loc_cOut)
        ENDIF

        loc_cSaida = loc_cSaida + "14 Picture=[" + loc_oForm.Picture + "]" + CHR(13) + CHR(10)
        STRTOFILE(loc_cSaida, loc_cOut)

        loc_cSaida = loc_cSaida + "15 PictureExiste=[" + IIF(FILE(loc_oForm.Picture), "SIM", "NAO") + "]" + CHR(13) + CHR(10)
        STRTOFILE(loc_cSaida, loc_cOut)

        loc_oForm.Release()
        loc_cSaida = loc_cSaida + "16 RELEASE_OK PaiEnabled=[" + TRANSFORM(loc_oFormPaiFake.Enabled) + "]" + CHR(13) + CHR(10)
        STRTOFILE(loc_cSaida, loc_cOut)

        loc_oFormPaiFake.Release()
        loc_cSaida = loc_cSaida + "17 PAI_RELEASE_OK" + CHR(13) + CHR(10)
        STRTOFILE(loc_cSaida, loc_cOut)
    ENDIF
CATCH TO loc_oErro
    loc_cSaida = loc_cSaida + "ERRO: " + loc_oErro.Message + " | LN=" + ;
        TRANSFORM(loc_oErro.LineNo) + " | PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10)
    STRTOFILE(loc_cSaida, loc_cOut)
ENDTRY

loc_cSaida = loc_cSaida + "FIM" + CHR(13) + CHR(10)
STRTOFILE(loc_cSaida, loc_cOut)

QUIT
