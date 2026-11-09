SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
LOCAL lcOut, lcV, laV[2], lnI
lcOut = "C:\4c\refatoracao\origem\correcoes\erro335_tmp\vcx.txt"
STRTOFILE("", lcOut)
laV[1] = "C:\4c\refatoracao\Framework\framework.vcx"
laV[2] = "C:\4c\refatoracao\Framework\classresp.vcx"
FOR lnI = 1 TO 2
    SELECT 0
    USE (laV[lnI]) AGAIN SHARED ALIAS vv
    SCAN FOR ATC("fwbusca", objname + class) > 0 AND EMPTY(parent)
        STRTOFILE(JUSTFNAME(laV[lnI]) + " classe=[" + ALLTRIM(objname) + "] base=[" + ALLTRIM(class) + "] lib=[" + ALLTRIM(classloc) + "]" + CHR(13) + CHR(10), lcOut, .T.)
    ENDSCAN
    USE IN vv
ENDFOR
QUIT
