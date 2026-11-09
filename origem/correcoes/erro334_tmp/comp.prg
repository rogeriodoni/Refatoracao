SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
LOCAL lcOut, lnN, laF[1], lnI, lcErr
lcOut = "C:\4c\refatoracao\origem\correcoes\erro334_tmp\comp.txt"
STRTOFILE("", lcOut)
lnN = ADIR(laF, "C:\4c\refatoracao\origem\correcoes\erro334_tmp\comp\*.prg")
FOR lnI = 1 TO lnN
    COMPILE ("C:\4c\refatoracao\origem\correcoes\erro334_tmp\comp\" + laF[lnI, 1])
    lcErr = "C:\4c\refatoracao\origem\correcoes\erro334_tmp\comp\" + JUSTSTEM(laF[lnI, 1]) + ".err"
    STRTOFILE(PADR(laF[lnI, 1], 24) + IIF(FILE(lcErr), "ERROS:" + CHR(13) + CHR(10) + FILETOSTR(lcErr), "OK") + CHR(13) + CHR(10), lcOut, .T.)
ENDFOR
QUIT
