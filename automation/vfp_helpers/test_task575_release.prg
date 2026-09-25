SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL

LOCAL loc_cRes, loc_oPai, loc_oErro
loc_cRes = ""

TRY
    loc_oPai = CREATEOBJECT("frmPaiTeste")
    loc_cRes = loc_cRes + "criado VARTYPE=" + VARTYPE(loc_oPai) + CHR(13)
    loc_oPai.Show()
    loc_cRes = loc_cRes + "Show() retornou; VARTYPE apos=" + VARTYPE(loc_oPai) + CHR(13)
    loc_cRes = loc_cRes + "trace=[" + gcTrace + "]" + CHR(13)
CATCH TO loc_oErro
    loc_cRes = loc_cRes + "EXCEPTION: " + loc_oErro.Message + ;
        " Linha=" + TRANSFORM(loc_oErro.LineNo) + " Proc=" + loc_oErro.Procedure + CHR(13)
    loc_cRes = loc_cRes + "trace=[" + gcTrace + "]" + CHR(13)
ENDTRY

STRTOFILE(loc_cRes, "C:\4c\automation\vfp_helpers\test_task575_release_result.txt")
QUIT

DEFINE CLASS frmFilhoTeste AS Form
    WindowType = 1
    Caption    = "filho"
    PROCEDURE Activate()
        gcTrace = gcTrace + "filho-activate;"
        THIS.Release()
    ENDPROC
ENDDEFINE

DEFINE CLASS frmPaiTeste AS Form
    WindowType   = 1
    TitleBar     = 0
    ControlBox   = .F.
    Movable      = .F.
    lDespachado  = .F.

    PROCEDURE Init()
        PUBLIC gcTrace
        gcTrace = ""
    ENDPROC

    PROCEDURE Activate()
        THIS.Despachar()
    ENDPROC

    PROCEDURE Despachar()
        LOCAL loc_oFilho
        IF THIS.lDespachado
            RETURN
        ENDIF
        THIS.lDespachado = .T.
        gcTrace = gcTrace + "pai-despachar;"

        loc_oFilho = .NULL.
        TRY
            loc_oFilho = CREATEOBJECT("frmFilhoTeste")
        CATCH
            loc_oFilho = .NULL.
        ENDTRY

        IF VARTYPE(loc_oFilho) = "O"
            loc_oFilho.Show()
            gcTrace = gcTrace + "pos-show-filho;"
        ENDIF

        THIS.Release()
        gcTrace = gcTrace + "pos-release-pai;"
    ENDPROC
ENDDEFINE
