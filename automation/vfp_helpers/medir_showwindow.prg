*-- Mede se ShowWindow/WindowType sao atribuiveis em RUNTIME no VFP9.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cOut, loc_o, loc_oErro
loc_cOut = ""

loc_o = CREATEOBJECT("Form")

TRY
    loc_o.ShowWindow = 1
    loc_cOut = loc_cOut + "SHOWWINDOW_RUNTIME=OK (valor=" + TRANSFORM(loc_o.ShowWindow) + ")"
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "SHOWWINDOW_RUNTIME=ERRO [" + loc_oErro.Message + "]"
ENDTRY
loc_cOut = loc_cOut + CHR(13) + CHR(10)

TRY
    loc_o.WindowType = 1
    loc_cOut = loc_cOut + "WINDOWTYPE_RUNTIME=OK (valor=" + TRANSFORM(loc_o.WindowType) + ")"
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "WINDOWTYPE_RUNTIME=ERRO [" + loc_oErro.Message + "]"
ENDTRY
loc_cOut = loc_cOut + CHR(13) + CHR(10)

*-- E dentro do proprio Init da subclasse?
TRY
    loc_o = CREATEOBJECT("frmTesteSW")
    loc_cOut = loc_cOut + "SUBCLASSE_INIT_SETA_SHOWWINDOW=OK VARTYPE=" + VARTYPE(loc_o)
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "SUBCLASSE_INIT_SETA_SHOWWINDOW=ERRO [" + loc_oErro.Message + "]"
ENDTRY
loc_cOut = loc_cOut + CHR(13) + CHR(10)

STRTOFILE(loc_cOut, "C:\4c\automation\medir_showwindow.txt")
QUIT

DEFINE CLASS frmTesteSW AS Form
    ShowWindow = 0
    PROCEDURE Init()
        THIS.ShowWindow = 1
        RETURN .T.
    ENDPROC
ENDDEFINE
