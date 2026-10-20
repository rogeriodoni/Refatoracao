SET SAFETY OFF
SET RESOURCE OFF
LOCAL loc_cLog, loc_oF, loc_oErr, loc_lOk
loc_cLog = ""

loc_oF = CREATEOBJECT("frmTesteBind")
IF VARTYPE(loc_oF) != "O"
    loc_cLog = loc_cLog + "CREATEOBJECT falhou" + CHR(13) + CHR(10)
ELSE
    loc_cLog = loc_cLog + "form criado OK" + CHR(13) + CHR(10)
    *-- bind com delegate INEXISTENTE
    TRY
        loc_lOk = BINDEVENT(loc_oF.cmd1, "Click", loc_oF, "NaoExisteEsteMetodo")
        loc_cLog = loc_cLog + "BIND delegate inexistente: SEM ERRO, retorno=" + TRANSFORM(loc_lOk) + CHR(13) + CHR(10)
    CATCH TO loc_oErr
        loc_cLog = loc_cLog + "BIND delegate inexistente: ERRO -> " + loc_oErr.Message + CHR(13) + CHR(10)
    ENDTRY
    *-- disparar o Click para ver o que acontece no FIRE
    TRY
        loc_oF.cmd1.Click()
        loc_cLog = loc_cLog + "FIRE do Click: SEM ERRO" + CHR(13) + CHR(10)
    CATCH TO loc_oErr
        loc_cLog = loc_cLog + "FIRE do Click: ERRO -> " + loc_oErr.Message + CHR(13) + CHR(10)
    ENDTRY
    *-- bind com delegate EXISTENTE
    TRY
        loc_lOk = BINDEVENT(loc_oF.cmd1, "Click", loc_oF, "MetodoQueExiste")
        loc_cLog = loc_cLog + "BIND delegate existente: SEM ERRO, retorno=" + TRANSFORM(loc_lOk) + CHR(13) + CHR(10)
    CATCH TO loc_oErr
        loc_cLog = loc_cLog + "BIND delegate existente: ERRO -> " + loc_oErr.Message + CHR(13) + CHR(10)
    ENDTRY
ENDIF

STRTOFILE(loc_cLog, "C:\4c\automation\tmp652\medir_bindevent.txt")
QUIT

DEFINE CLASS frmTesteBind AS Form
    PROCEDURE Init()
        THIS.AddObject("cmd1", "CommandButton")
        THIS.cmd1.Visible = .T.
        RETURN .T.
    ENDPROC
    PROCEDURE MetodoQueExiste()
        RETURN .T.
    ENDPROC
ENDDEFINE
