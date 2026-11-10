SET SAFETY OFF
SET RESOURCE OFF
LOCAL loc_cOut
loc_cOut = ""
COMPILE FILE "C:\4c\projeto\app\classes\SigOpLclBO.prg"
COMPILE FILE "C:\4c\projeto\app\utils\fxmltocursor.prg"
COMPILE FILE "C:\4c\projeto\app\start\config.prg"
loc_cOut = loc_cOut + "BO   fxp=" + TRANSFORM(FILE("C:\4c\projeto\app\classes\SigOpLclBO.fxp")) + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "WRAP fxp=" + TRANSFORM(FILE("C:\4c\projeto\app\utils\fxmltocursor.fxp")) + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "CFG  fxp=" + TRANSFORM(FILE("C:\4c\projeto\app\start\config.fxp")) + CHR(13) + CHR(10)
IF FILE("C:\4c\projeto\app\classes\SigOpLclBO.err")
    loc_cOut = loc_cOut + "--- BO ERR ---" + CHR(13) + CHR(10) + FILETOSTR("C:\4c\projeto\app\classes\SigOpLclBO.err")
ENDIF
IF FILE("C:\4c\projeto\app\utils\fxmltocursor.err")
    loc_cOut = loc_cOut + "--- WRAP ERR ---" + CHR(13) + CHR(10) + FILETOSTR("C:\4c\projeto\app\utils\fxmltocursor.err")
ENDIF
IF FILE("C:\4c\projeto\app\start\config.err")
    loc_cOut = loc_cOut + "--- CFG ERR ---" + CHR(13) + CHR(10) + FILETOSTR("C:\4c\projeto\app\start\config.err")
ENDIF
STRTOFILE(loc_cOut, "C:\4c\automation\compila_f2.txt")
QUIT
