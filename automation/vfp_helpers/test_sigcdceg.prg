SET SAFETY OFF
SET TALK OFF
DO C:\4c\projeto\app\start\config.prg
lcConn = ObterStringConexao()
PUBLIC gnConnHandle
gnConnHandle = SQLSTRINGCONNECT(lcConn)
IF gnConnHandle > 0
    LOCAL loc_nRes
    loc_nRes = SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS Total FROM SigCdCeg", "curTest")
    IF loc_nRes >= 0 AND USED("curTest")
        STRTOFILE("SigCdCeg tem " + TRANSFORM(curTest.Total) + " registros" + CHR(13), "C:\4c\automation\vfp_helpers\test_sigcdceg.log")
        USE IN curTest
    ELSE
        STRTOFILE("SQLEXEC erro: " + TRANSFORM(loc_nRes) + CHR(13), "C:\4c\automation\vfp_helpers\test_sigcdceg.log")
    ENDIF
    SQLDISCONNECT(gnConnHandle)
ELSE
    STRTOFILE("Falha conexao" + CHR(13), "C:\4c\automation\vfp_helpers\test_sigcdceg.log")
ENDIF
QUIT
