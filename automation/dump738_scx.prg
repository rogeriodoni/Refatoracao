SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lcOut, lnI, lcProp, lcTab, lcPos, lcLin
lcOut = ""
USE "C:\4c\tasks\task738\sigopgar.scx" ALIAS csScx
SELECT csScx
lnI = 0
SCAN
    lnI = lnI + 1
    lcProp = ALLTRIM(csScx.Properties)
    lcTab  = ""
    lnPos  = ATC("TabIndex =", lcProp)
    IF lnPos > 0
        lcLin = SUBSTR(lcProp, lnPos, 30)
        IF AT(CHR(13), lcLin) > 0
            lcLin = LEFT(lcLin, AT(CHR(13), lcLin) - 1)
        ENDIF
        lcTab = ALLTRIM(lcLin)
    ENDIF
    lcOut = lcOut + TRANSFORM(lnI) + "|" + ;
            ALLTRIM(NVL(csScx.ObjName, "")) + "|" + ;
            ALLTRIM(NVL(csScx.Parent, "")) + "|" + ;
            ALLTRIM(NVL(csScx.BaseClass, "")) + "|" + ;
            ALLTRIM(NVL(csScx.Class, "")) + "|" + ;
            lcTab + CHR(13) + CHR(10)
ENDSCAN
USE IN csScx
STRTOFILE(lcOut, "C:\4c\automation\dump738_scx.txt")
QUIT
