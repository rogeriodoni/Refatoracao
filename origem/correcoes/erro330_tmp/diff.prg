SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
LOCAL lcOut, lnI, lcCampo, luA, luB, laA[1], laB[1], lnN
lcOut = "C:\4c\refatoracao\origem\correcoes\erro330_tmp\diff.txt"
STRTOFILE("", lcOut)
*-- campo total_cartao (SigReCtc original do Erro328) x campo nSoma bold (calib2)
SELECT 0
USE "C:\4c\refatoracao\origem\correcoes\erro330_tmp\origctc.frx" AGAIN SHARED ALIAS fa
LOCATE FOR objtype = 8 AND UPPER(ALLTRIM(expr)) == "TOTAL_CARTAO"
SCATTER TO laA MEMO
lnN = FCOUNT()
DIMENSION laNomes[lnN]
FOR lnI = 1 TO lnN
    laNomes[lnI] = FIELD(lnI)
ENDFOR
LOCATE FOR objtype = 18 AND UPPER(ALLTRIM(name)) == "TOTAL_CARTAO"
SCATTER TO laVA MEMO
SELECT 0
USE "C:\4c\refatoracao\origem\correcoes\erro330_tmp\calib2.frx" AGAIN SHARED ALIAS fb
LOCATE FOR objtype = 8 AND UPPER(ALLTRIM(expr)) == "NSOMA" AND fontstyle = 1
SCATTER TO laB MEMO
LOCATE FOR objtype = 18
SCATTER TO laVB MEMO
STRTOFILE("--- CAMPO: coluna | SigReCtc.total_cartao | calib2.nSoma" + CHR(13) + CHR(10), lcOut, .T.)
FOR lnI = 1 TO lnN
    IF !(TRANSFORM(laA[lnI]) == TRANSFORM(laB[lnI]))
        STRTOFILE(PADR(laNomes[lnI], 12) + " | " + LEFT(CHRTRAN(TRANSFORM(laA[lnI]), CHR(13)+CHR(10)+CHR(0), "  ."), 60) + " | " + LEFT(CHRTRAN(TRANSFORM(laB[lnI]), CHR(13)+CHR(10)+CHR(0), "  ."), 60) + CHR(13) + CHR(10), lcOut, .T.)
    ENDIF
ENDFOR
STRTOFILE("--- VARIAVEL" + CHR(13) + CHR(10), lcOut, .T.)
FOR lnI = 1 TO lnN
    IF !(TRANSFORM(laVA[lnI]) == TRANSFORM(laVB[lnI]))
        STRTOFILE(PADR(laNomes[lnI], 12) + " | " + LEFT(CHRTRAN(TRANSFORM(laVA[lnI]), CHR(13)+CHR(10)+CHR(0), "  ."), 60) + " | " + LEFT(CHRTRAN(TRANSFORM(laVB[lnI]), CHR(13)+CHR(10)+CHR(0), "  ."), 60) + CHR(13) + CHR(10), lcOut, .T.)
    ENDIF
ENDFOR
QUIT
