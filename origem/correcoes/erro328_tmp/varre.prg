SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
LOCAL lcOut, lcF, lcPic, lcMask, lnNec, lcSt, lnI, lnMaxDir
lcOut = "C:\4c\refatoracao\origem\correcoes\erro328_tmp\varre.txt"
STRTOFILE("", lcOut)
DIMENSION laF[7]
laF[1] = "SigReCtc"
laF[2] = "SigReCrP"
laF[3] = "SigReCrf"
laF[4] = "SigReCpr"
laF[5] = "SigReCPM"
laF[6] = "SigReC2P"
laF[7] = "SigReIag"
FOR lnI = 1 TO ALEN(laF)
    SELECT 0
    USE ("C:\4c\refatoracao\projeto\app\reports\" + laF[lnI] + ".frx") AGAIN SHARED ALIAS frxv
    CALCULATE MAX(hpos + width) FOR objtype = 8 TO lnMaxDir
    STRTOFILE("== " + laF[lnI] + "  (maior borda direita=" + TRANSFORM(INT(lnMaxDir)) + ")" + CHR(13) + CHR(10), lcOut, .T.)
    SCAN FOR objtype = 8 AND fillchar = "N"
        lcPic  = ALLTRIM(STRTRAN(picture, '"', ''))
        lcMask = ALLTRIM(IIF(LEFT(lcPic, 1) = "@", SUBSTR(lcPic, AT(" ", lcPic + " ") + 1), lcPic))
        IF EMPTY(lcMask)
            LOOP
        ENDIF
        lcSt  = IIF(BITTEST(fontstyle, 0), "B", "N")
        lnNec = ROUND(TXTWIDTH(lcMask, ALLTRIM(fontface), fontsize, lcSt) * FONTMETRIC(6, ALLTRIM(fontface), fontsize, lcSt) / 96 * 10000, 0)
        IF lnNec > width
            STRTOFILE("  ESTOURA rec=" + PADL(RECNO(), 3) + " " + PADR(ALLTRIM(expr), 16) + " " + ALLTRIM(fontface) + " " + TRANSFORM(fontsize) + lcSt + ;
                " mascara=[" + lcMask + "] precisa=" + TRANSFORM(lnNec) + " tem=" + TRANSFORM(INT(width)) + " hpos=" + TRANSFORM(INT(hpos)) + " vpos=" + TRANSFORM(INT(vpos)) + CHR(13) + CHR(10), lcOut, .T.)
        ENDIF
    ENDSCAN
    USE IN frxv
ENDFOR
QUIT
