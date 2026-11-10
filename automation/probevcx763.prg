SET SAFETY OFF
SET RESOURCE OFF
LOCAL loc_cOut
loc_cOut = ""
USE "C:\4c\Framework\framework.vcx" ALIAS vcxlib IN 0 SHARED
SELECT vcxlib
SCAN FOR UPPER(ALLTRIM(ObjName)) $ "FWBTNP,FWBTNG"
    loc_cOut = loc_cOut + "ObjName=[" + ALLTRIM(ObjName) + "] Parent=[" + ALLTRIM(Parent) + ;
        "] Class=[" + ALLTRIM(Class) + "]" + CHR(13)+CHR(10)
    loc_cOut = loc_cOut + ALLTRIM(Properties) + CHR(13)+CHR(10)
    loc_cOut = loc_cOut + "-----------------------------------------" + CHR(13)+CHR(10)
ENDSCAN
USE IN vcxlib
STRTOFILE(loc_cOut, "C:\4c\automation\probevcx763_out.txt")
QUIT
