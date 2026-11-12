SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lcOut, lnF, lcP, lnNec, lnCx, lnFolga
lcOut = "arquivo  campo      hpos    fim   caixa(pol) picture              texto(pol)  folga" + CHR(13)+CHR(10)
lnF = FONTMETRIC(6, "Verdana", 8)
LOCAL lnI, lcArq
FOR lnI = 1 TO 2
    lcArq = "SigReEq" + TRANSFORM(lnI)
    USE ("C:\4c\projeto\app\reports\" + lcArq + ".frx") IN 0 ALIAS frx SHARED
    SELECT frx
    SCAN FOR OBJTYPE = 8 AND INLIST(ALLTRIM(EXPR), "tPesos", "tQtds", "VlVenda", "Vlcusto")
        lcP   = STRTRAN(STRTRAN(ALLTRIM(PICTURE), '"', ''), "@Z ", "")
        lnNec = TXTWIDTH(lcP, "Verdana", 8) * lnF / 96
        lnCx  = WIDTH / 10000
        lnFolga = (lnCx - lnNec) / lnNec * 100
        lcOut = lcOut + PADR(lcArq, 9) + PADR(ALLTRIM(EXPR), 11) + ;
            PADL(INT(HPOS), 6) + PADL(INT(HPOS + WIDTH), 7) + "   " + ;
            PADR(TRANSFORM(ROUND(lnCx, 4)), 11) + PADR(lcP, 21) + ;
            PADR(TRANSFORM(ROUND(lnNec, 4)), 12) + ;
            TRANSFORM(ROUND(lnFolga, 1)) + "%" + ;
            IIF(lnFolga >= 11, "  OK", "  <<< ABAIXO DE 11%") + CHR(13)+CHR(10)
    ENDSCAN
    USE IN frx
ENDFOR
STRTOFILE(lcOut, "C:\4c\origem\correcoes\erro345_tmp\conferir.txt")
QUIT
