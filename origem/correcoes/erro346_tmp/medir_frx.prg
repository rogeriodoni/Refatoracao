SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lcOut, lcP, lnNec, lnCx, lnFolga, lnI, lcArq, lnF, lcFonte, lnTam
lcOut = "arquivo  campo                caixa(pol) picture              texto(pol) folga" + CHR(13)+CHR(10)
LOCAL ARRAY laA[2]
laA[1] = "SigReEsp"
laA[2] = "SigReEs2"
FOR lnI = 1 TO 2
    lcArq = laA[lnI]
    IF !FILE("C:\4c\projeto\app\reports\" + lcArq + ".frx")
        lcOut = lcOut + lcArq + " : ARQUIVO NAO EXISTE" + CHR(13)+CHR(10)
        LOOP
    ENDIF
    USE ("C:\4c\projeto\app\reports\" + lcArq + ".frx") IN 0 ALIAS frx SHARED
    SELECT frx
    SCAN FOR OBJTYPE = 8 AND ATC("9", PICTURE) > 0
        lcFonte = ALLTRIM(frx.FONTFACE)
        lnTam   = frx.FONTSIZE
        IF EMPTY(lcFonte)
            lcFonte = "Verdana"
        ENDIF
        IF lnTam = 0
            lnTam = 8
        ENDIF
        lnF   = FONTMETRIC(6, lcFonte, lnTam)
        lcP   = ALLTRIM(PICTURE)
        lcP   = STRTRAN(lcP, '"', '')
        lcP   = STRTRAN(lcP, "@Z ", "")
        lcP   = STRTRAN(lcP, "@R ", "")
        lcP   = ALLTRIM(lcP)
        lnNec = TXTWIDTH(lcP, lcFonte, lnTam) * lnF / 96
        lnCx  = frx.WIDTH / 10000
        lnFolga = IIF(lnNec = 0, 999, (lnCx - lnNec) / lnNec * 100)
        lcOut = lcOut + PADR(lcArq, 9) + PADR(LEFT(ALLTRIM(frx.EXPR), 20), 21) + ;
            PADR(TRANSFORM(ROUND(lnCx, 4)), 11) + PADR(lcP, 21) + ;
            PADR(TRANSFORM(ROUND(lnNec, 4)), 11) + ;
            TRANSFORM(ROUND(lnFolga, 1)) + "%" + ;
            IIF(lnFolga >= 11, "  OK", "  <<< RISCO DE *****") + CHR(13)+CHR(10)
    ENDSCAN
    USE IN frx
ENDFOR
STRTOFILE(lcOut, "C:\4c\origem\correcoes\erro346_tmp\medir_frx.txt")
QUIT
