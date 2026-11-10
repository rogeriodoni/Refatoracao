SET SAFETY OFF
SET RESOURCE OFF
LOCAL loc_cOut
loc_cOut = ""
COMPILE "C:\4c\projeto\app\classes\SigOpLclBO.prg"
COMPILE "C:\4c\projeto\app\utils\fxmltocursor.prg"
COMPILE "C:\4c\projeto\app\start\config.prg"
loc_cOut = loc_cOut + "BO   fxp=" + TRANSFORM(FILE("C:\4c\projeto\app\classes\SigOpLclBO.fxp")) + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "WRAP fxp=" + TRANSFORM(FILE("C:\4c\projeto\app\utils\fxmltocursor.fxp")) + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "CFG  fxp=" + TRANSFORM(FILE("C:\4c\projeto\app\start\config.fxp")) + CHR(13) + CHR(10)
IF FILE("C:\4c\projeto\app\classes\SigOpLclBO.ERR")
    loc_cOut = loc_cOut + "--- BO ERR ---" + CHR(13) + CHR(10) + FILETOSTR("C:\4c\projeto\app\classes\SigOpLclBO.ERR")
ENDIF
IF FILE("C:\4c\projeto\app\utils\fxmltocursor.ERR")
    loc_cOut = loc_cOut + "--- WRAP ERR ---" + CHR(13) + CHR(10) + FILETOSTR("C:\4c\projeto\app\utils\fxmltocursor.ERR")
ENDIF
IF FILE("C:\4c\projeto\app\start\config.ERR")
    loc_cOut = loc_cOut + "--- CFG ERR ---" + CHR(13) + CHR(10) + FILETOSTR("C:\4c\projeto\app\start\config.ERR")
ENDIF
STRTOFILE(loc_cOut, "C:\4c\automation\compila_f2b.txt")
QUIT
