* Diagnostic: capture exact error during SET PROCEDURE TO for Formsigprcpd
* Uses ON ERROR handler (fires even in SYS(2335,0) mode)

SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

* Output file
LOCAL loc_cOutput
loc_cOutput = "C:\4c\tasks\task167\diag_setproc_output.txt"

* Error capture variables
PUBLIC gn_DiagErrNo, gc_DiagErrMsg, gc_DiagErrProg, gn_DiagErrLine
gn_DiagErrNo = 0
gc_DiagErrMsg = ""
gc_DiagErrProg = ""
gn_DiagErrLine = 0

ON ERROR gn_DiagErrNo = ERROR(); gc_DiagErrMsg = MESSAGE(); gc_DiagErrProg = PROGRAM(); gn_DiagErrLine = LINENO()

LOCAL loc_cResult, loc_cStep
loc_cResult = "=== DIAGNOSTIC: SET PROCEDURE TO para Formsigprcpd ===" + CHR(13) + CHR(10)
loc_cResult = loc_cResult + "Inicio: " + DATETIME() + CHR(13) + CHR(10) + CHR(13) + CHR(10)

* Step 1: Load formbase
loc_cStep = "Step 1: SET PROCEDURE TO formbase.prg"
loc_cResult = loc_cResult + loc_cStep + CHR(13) + CHR(10)
gn_DiagErrNo = 0; gc_DiagErrMsg = ""; gn_DiagErrLine = 0
SET PROCEDURE TO "C:\4c\projeto\app\classes\formbase.prg" ADDITIVE
IF gn_DiagErrNo <> 0
    loc_cResult = loc_cResult + "  ERRO " + TRANSFORM(gn_DiagErrNo) + ": " + gc_DiagErrMsg + " [linha " + TRANSFORM(gn_DiagErrLine) + "]" + CHR(13) + CHR(10)
ELSE
    loc_cResult = loc_cResult + "  OK" + CHR(13) + CHR(10)
ENDIF

* Step 2: Load businessbase
loc_cStep = "Step 2: SET PROCEDURE TO businessbase.prg"
loc_cResult = loc_cResult + loc_cStep + CHR(13) + CHR(10)
gn_DiagErrNo = 0; gc_DiagErrMsg = ""; gn_DiagErrLine = 0
SET PROCEDURE TO "C:\4c\projeto\app\classes\businessbase.prg" ADDITIVE
IF gn_DiagErrNo <> 0
    loc_cResult = loc_cResult + "  ERRO " + TRANSFORM(gn_DiagErrNo) + ": " + gc_DiagErrMsg + " [linha " + TRANSFORM(gn_DiagErrLine) + "]" + CHR(13) + CHR(10)
ELSE
    loc_cResult = loc_cResult + "  OK" + CHR(13) + CHR(10)
ENDIF

* Step 3: Load dataaccess
loc_cStep = "Step 3: SET PROCEDURE TO dataaccess.prg"
loc_cResult = loc_cResult + loc_cStep + CHR(13) + CHR(10)
gn_DiagErrNo = 0; gc_DiagErrMsg = ""; gn_DiagErrLine = 0
SET PROCEDURE TO "C:\4c\projeto\app\classes\dataaccess.prg" ADDITIVE
IF gn_DiagErrNo <> 0
    loc_cResult = loc_cResult + "  ERRO " + TRANSFORM(gn_DiagErrNo) + ": " + gc_DiagErrMsg + " [linha " + TRANSFORM(gn_DiagErrLine) + "]" + CHR(13) + CHR(10)
ELSE
    loc_cResult = loc_cResult + "  OK" + CHR(13) + CHR(10)
ENDIF

* Step 4: Load gridbase
loc_cStep = "Step 4: SET PROCEDURE TO gridbase.prg"
loc_cResult = loc_cResult + loc_cStep + CHR(13) + CHR(10)
gn_DiagErrNo = 0; gc_DiagErrMsg = ""; gn_DiagErrLine = 0
SET PROCEDURE TO "C:\4c\projeto\app\classes\gridbase.prg" ADDITIVE
IF gn_DiagErrNo <> 0
    loc_cResult = loc_cResult + "  ERRO " + TRANSFORM(gn_DiagErrNo) + ": " + gc_DiagErrMsg + " [linha " + TRANSFORM(gn_DiagErrLine) + "]" + CHR(13) + CHR(10)
ELSE
    loc_cResult = loc_cResult + "  OK" + CHR(13) + CHR(10)
ENDIF

* Step 5: Load sigprcpdBO
loc_cStep = "Step 5: SET PROCEDURE TO sigprcpdBO.prg"
loc_cResult = loc_cResult + loc_cStep + CHR(13) + CHR(10)
gn_DiagErrNo = 0; gc_DiagErrMsg = ""; gn_DiagErrLine = 0
SET PROCEDURE TO "C:\4c\projeto\app\classes\sigprcpdBO.prg" ADDITIVE
IF gn_DiagErrNo <> 0
    loc_cResult = loc_cResult + "  ERRO " + TRANSFORM(gn_DiagErrNo) + ": " + gc_DiagErrMsg + " [linha " + TRANSFORM(gn_DiagErrLine) + "]" + CHR(13) + CHR(10)
ELSE
    loc_cResult = loc_cResult + "  OK" + CHR(13) + CHR(10)
ENDIF

* Step 6: Load Formsigprcpd - THE KEY STEP
loc_cStep = "Step 6: SET PROCEDURE TO Formsigprcpd.prg"
loc_cResult = loc_cResult + loc_cStep + CHR(13) + CHR(10)
gn_DiagErrNo = 0; gc_DiagErrMsg = ""; gn_DiagErrLine = 0
SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\Formsigprcpd.prg" ADDITIVE
IF gn_DiagErrNo <> 0
    loc_cResult = loc_cResult + "  ERRO " + TRANSFORM(gn_DiagErrNo) + ": " + gc_DiagErrMsg + " [linha " + TRANSFORM(gn_DiagErrLine) + "]" + CHR(13) + CHR(10)
    loc_cResult = loc_cResult + "  Programa: " + gc_DiagErrProg + CHR(13) + CHR(10)
ELSE
    loc_cResult = loc_cResult + "  OK - verificando se classe foi registrada..." + CHR(13) + CHR(10)
    * Try CREATEOBJECT
    gn_DiagErrNo = 0; gc_DiagErrMsg = ""
    LOCAL loc_oForm
    loc_oForm = .NULL.
    TRY
        loc_oForm = CREATEOBJECT("Formsigprcpd")
        IF VARTYPE(loc_oForm) = "O"
            loc_cResult = loc_cResult + "  CREATEOBJECT: SUCESSO!" + CHR(13) + CHR(10)
        ELSE
            loc_cResult = loc_cResult + "  CREATEOBJECT: retornou nao-objeto" + CHR(13) + CHR(10)
        ENDIF
    CATCH TO loc_oErr
        loc_cResult = loc_cResult + "  CREATEOBJECT ERRO: " + loc_oErr.Message + CHR(13) + CHR(10)
    ENDTRY
    IF VARTYPE(loc_oForm) = "O"
        loc_oForm = .NULL.
    ENDIF
ENDIF

* Check .err file for compilation errors
loc_cStep = "Step 7: Verificar arquivo .err"
loc_cResult = loc_cResult + CHR(13) + CHR(10) + loc_cStep + CHR(13) + CHR(10)
LOCAL loc_cErrFile
loc_cErrFile = "C:\4c\projeto\app\forms\operacionais\Formsigprcpd.err"
IF FILE(loc_cErrFile)
    loc_cResult = loc_cResult + "  .err EXISTE! Conteudo:" + CHR(13) + CHR(10)
    loc_cResult = loc_cResult + FILETOSTR(loc_cErrFile) + CHR(13) + CHR(10)
ELSE
    loc_cResult = loc_cResult + "  .err nao existe" + CHR(13) + CHR(10)
ENDIF

* Also check classes dir
loc_cErrFile = "C:\4c\projeto\app\classes\sigprcpdBO.err"
IF FILE(loc_cErrFile)
    loc_cResult = loc_cResult + "  sigprcpdBO.err EXISTE! Conteudo:" + CHR(13) + CHR(10)
    loc_cResult = loc_cResult + FILETOSTR(loc_cErrFile) + CHR(13) + CHR(10)
ELSE
    loc_cResult = loc_cResult + "  sigprcpdBO.err nao existe" + CHR(13) + CHR(10)
ENDIF

* Step 8: Check FXP creation
loc_cStep = "Step 8: Verificar criacao de .fxp"
loc_cResult = loc_cResult + CHR(13) + CHR(10) + loc_cStep + CHR(13) + CHR(10)
IF FILE("C:\4c\projeto\app\forms\operacionais\Formsigprcpd.fxp")
    loc_cResult = loc_cResult + "  Formsigprcpd.fxp FOI CRIADO (compilacao OK)" + CHR(13) + CHR(10)
ELSE
    loc_cResult = loc_cResult + "  Formsigprcpd.fxp NAO FOI CRIADO (compilacao FALHOU)" + CHR(13) + CHR(10)
ENDIF
IF FILE("C:\4c\projeto\app\classes\sigprcpdBO.fxp")
    loc_cResult = loc_cResult + "  sigprcpdBO.fxp FOI CRIADO (compilacao OK)" + CHR(13) + CHR(10)
ELSE
    loc_cResult = loc_cResult + "  sigprcpdBO.fxp NAO FOI CRIADO (compilacao FALHOU)" + CHR(13) + CHR(10)
ENDIF

ON ERROR
loc_cResult = loc_cResult + CHR(13) + CHR(10) + "Fim: " + DATETIME() + CHR(13) + CHR(10)
STRTOFILE(loc_cResult, loc_cOutput)

QUIT
