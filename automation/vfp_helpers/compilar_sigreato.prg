SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
=SYS(2335, 0)

LOCAL loc_cBO, loc_cForm, loc_lOK

loc_cBO   = "C:\4c\projeto\app\classes\sigreatoBO.prg"
loc_cForm = "C:\4c\projeto\app\forms\relatorios\Formsigreato.prg"

loc_lOK = .T.

? "=== COMPILANDO sigreatoBO.prg ==="
IF FILE(FORCEEXT(loc_cBO, "fxp"))
    DELETE FILE (FORCEEXT(loc_cBO, "fxp"))
ENDIF
COMPILE (loc_cBO)
IF FILE(FORCEEXT(loc_cBO, "err"))
    ? "ERRO BO: " + FILETOSTR(FORCEEXT(loc_cBO, "err"))
    loc_lOK = .F.
ELSE
    ? "BO OK"
ENDIF

? "=== COMPILANDO Formsigreato.prg ==="
IF FILE(FORCEEXT(loc_cForm, "fxp"))
    DELETE FILE (FORCEEXT(loc_cForm, "fxp"))
ENDIF
COMPILE (loc_cForm)
IF FILE(FORCEEXT(loc_cForm, "err"))
    ? "ERRO FORM: " + FILETOSTR(FORCEEXT(loc_cForm, "err"))
    loc_lOK = .F.
ELSE
    ? "FORM OK"
ENDIF

IF loc_lOK
    ? "STATUS: SUCESSO"
ELSE
    ? "STATUS: ERRO"
ENDIF

QUIT
