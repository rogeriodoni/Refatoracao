SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
LOCAL lcOut, lcPic, lcMask, lnNec, lcSt, lnI, lnN, laF[1], lcArq, lnTot, lnCampos
lcOut = "C:\4c\refatoracao\origem\correcoes\erro330_tmp\varre.txt"
STRTOFILE("frx|rec|expr|fonte|tam|estilo|mascara|largura|necessario|folga|hpos|vpos" + CHR(13) + CHR(10), lcOut)
lnN = ADIR(laF, "C:\4c\refatoracao\projeto\app\reports\*.frx")
lnTot = 0
lnCampos = 0
FOR lnI = 1 TO lnN
    lcArq = "C:\4c\refatoracao\projeto\app\reports\" + laF[lnI, 1]
    TRY
        SELECT 0
        USE (lcArq) AGAIN SHARED ALIAS frxv
        SCAN FOR objtype = 8 AND !EMPTY(picture)
            lcPic  = ALLTRIM(STRTRAN(picture, '"', ''))
            lcMask = ALLTRIM(IIF(LEFT(lcPic, 1) = "@", SUBSTR(lcPic, AT(" ", lcPic + " ") + 1), lcPic))
            IF EMPTY(lcMask) OR !("9" $ lcMask) OR CHRTRAN(lcMask, "9,.-$ ", "") != ""
                LOOP
            ENDIF
            lnCampos = lnCampos + 1
            lcSt  = IIF(BITTEST(fontstyle, 0), "B", "N")
            lnNec = TXTWIDTH(lcMask, ALLTRIM(fontface), fontsize, lcSt) * FONTMETRIC(6, ALLTRIM(fontface), fontsize, lcSt) / 96 * 10000
            IF width / lnNec < 1.25
                lnTot = lnTot + 1
                STRTOFILE(JUSTSTEM(laF[lnI, 1]) + "|" + TRANSFORM(RECNO()) + "|" + LEFT(ALLTRIM(expr), 30) + "|" + ALLTRIM(fontface) + "|" + TRANSFORM(fontsize) + "|" + lcSt + "|" + lcMask + "|" + ;
                    TRANSFORM(INT(width)) + "|" + TRANSFORM(INT(lnNec)) + "|" + TRANSFORM(ROUND(width / lnNec, 3)) + "|" + TRANSFORM(INT(hpos)) + "|" + TRANSFORM(INT(vpos)) + CHR(13) + CHR(10), lcOut, .T.)
            ENDIF
        ENDSCAN
        USE IN frxv
    CATCH TO loE
        STRTOFILE("ERRO|" + laF[lnI, 1] + "|" + loE.Message + CHR(13) + CHR(10), lcOut, .T.)
    ENDTRY
ENDFOR
STRTOFILE("TOTAL frx=" + TRANSFORM(lnN) + " campos_numericos=" + TRANSFORM(lnCampos) + " folga<1.25=" + TRANSFORM(lnTot) + CHR(13) + CHR(10), lcOut, .T.)
QUIT
