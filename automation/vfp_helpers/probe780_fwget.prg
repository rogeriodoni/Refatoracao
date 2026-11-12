SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcSaida, lcArq
lcSaida = ""
lcArq   = "C:\4c\automation\vfp_helpers\probe780_fwget_out.txt"

TRY
    USE "C:\4c\Framework\framework.vcx" ALIAS vcxFw IN 0 SHARED
    SELECT vcxFw
    lcSaida = lcSaida + "RECCOUNT=" + TRANSFORM(RECCOUNT("vcxFw")) + CHR(13) + CHR(10)
    GO TOP
    SCAN
        IF UPPER(ALLTRIM(NVL(vcxFw.ObjName, ""))) == "FWGET"
            lcSaida = lcSaida + "=== REC " + TRANSFORM(RECNO()) + " ObjName=[" + ;
                      ALLTRIM(NVL(vcxFw.ObjName,"")) + "] Parent=[" + ALLTRIM(NVL(vcxFw.Parent,"")) + ;
                      "] Class=[" + ALLTRIM(NVL(vcxFw.Class,"")) + "] BaseCls=[" + ;
                      ALLTRIM(NVL(vcxFw.BaseClass,"")) + "]" + CHR(13) + CHR(10)
            lcSaida = lcSaida + ALLTRIM(NVL(vcxFw.Properties,"<vazio>")) + CHR(13) + CHR(10)
        ENDIF
    ENDSCAN
    USE IN vcxFw
CATCH TO loErr
    lcSaida = lcSaida + "ERRO: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(lcSaida, lcArq)
QUIT
