* Minimal diagnostic: just SET PROCEDURE TO on Formsigprcpd.prg
* No base class loading - just check if file compiles via SET PROCEDURE TO

SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

PUBLIC gn_DiagErrNo, gc_DiagErrMsg, gn_DiagErrLine, gc_DiagErrProg
gn_DiagErrNo = 0
gc_DiagErrMsg = ""
gn_DiagErrLine = 0
gc_DiagErrProg = ""

ON ERROR gn_DiagErrNo = ERROR(); gc_DiagErrMsg = MESSAGE(); gn_DiagErrLine = LINENO(); gc_DiagErrProg = PROGRAM()

* Delete any existing FXP and ERR first
IF FILE("C:\4c\projeto\app\forms\operacionais\Formsigprcpd.fxp")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\Formsigprcpd.fxp"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\Formsigprcpd.err")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\Formsigprcpd.err"
ENDIF

LOCAL loc_cResult
loc_cResult = "=== DIAG2: Minimal SET PROCEDURE TO test ===" + CHR(13) + CHR(10)
loc_cResult = loc_cResult + "Time: " + DTOC(DATE()) + " " + TIME() + CHR(13) + CHR(10) + CHR(13) + CHR(10)

* Attempt SET PROCEDURE TO
gn_DiagErrNo = 0
gc_DiagErrMsg = ""
gn_DiagErrLine = 0

SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\Formsigprcpd.prg" ADDITIVE

IF gn_DiagErrNo <> 0
    loc_cResult = loc_cResult + "ON ERROR fired during SET PROCEDURE TO:" + CHR(13) + CHR(10)
    loc_cResult = loc_cResult + "  Error #: " + TRANSFORM(gn_DiagErrNo) + CHR(13) + CHR(10)
    loc_cResult = loc_cResult + "  Message: " + gc_DiagErrMsg + CHR(13) + CHR(10)
    loc_cResult = loc_cResult + "  Line: " + TRANSFORM(gn_DiagErrLine) + CHR(13) + CHR(10)
    loc_cResult = loc_cResult + "  Program: " + gc_DiagErrProg + CHR(13) + CHR(10)
ELSE
    loc_cResult = loc_cResult + "SET PROCEDURE TO: no ON ERROR fired" + CHR(13) + CHR(10)
ENDIF

* Check if .fxp was created
IF FILE("C:\4c\projeto\app\forms\operacionais\Formsigprcpd.fxp")
    loc_cResult = loc_cResult + "FXP: CREATED (compilation OK)" + CHR(13) + CHR(10)
ELSE
    loc_cResult = loc_cResult + "FXP: NOT CREATED (compilation FAILED)" + CHR(13) + CHR(10)
ENDIF

* Check if .err was created
IF FILE("C:\4c\projeto\app\forms\operacionais\Formsigprcpd.err")
    loc_cResult = loc_cResult + "ERR file: EXISTS" + CHR(13) + CHR(10)
    loc_cResult = loc_cResult + FILETOSTR("C:\4c\projeto\app\forms\operacionais\Formsigprcpd.err") + CHR(13) + CHR(10)
ELSE
    loc_cResult = loc_cResult + "ERR file: not created" + CHR(13) + CHR(10)
ENDIF

ON ERROR

STRTOFILE(loc_cResult, "C:\4c\tasks\task167\diag2_output.txt")

QUIT
