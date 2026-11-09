LPARAMETERS par_cModo
*-- par_cModo: "SIMULAR" (so lista) | "APLICAR" (grava no FRX)
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
LOCAL lcOut, lnN, laF[1], lnI, lcArq, lcPic, lcMask, lcSt, lnNec, lnLim, lnNovo, lnDelta, lnAlt, lnFrxAlt, loE, lnCampos, lcLin
lcOut = "C:\4c\refatoracao\origem\correcoes\erro330_tmp\corrige_" + LOWER(par_cModo) + ".txt"
STRTOFILE("frx|rec|expr|fonte|estilo|mascara|folga|limite|largura|nova|alinh" + CHR(13) + CHR(10), lcOut)
lnN = ADIR(laF, "C:\4c\refatoracao\projeto\app\reports\*.frx")
lnAlt = 0
lnFrxAlt = 0
lnCampos = 0
FOR lnI = 1 TO lnN
    lcArq = "C:\4c\refatoracao\projeto\app\reports\" + laF[lnI, 1]
    TRY
        SELECT 0
        IF par_cModo == "APLICAR"
            USE (lcArq) EXCLUSIVE ALIAS frxc
        ELSE
            USE (lcArq) AGAIN SHARED ALIAS frxc
        ENDIF
        lnLinhasFrx = 0
        SCAN FOR objtype = 8 AND fillchar = "N" AND !stretch AND !EMPTY(picture)
            lcPic  = ALLTRIM(STRTRAN(picture, '"', ''))
            lcMask = ALLTRIM(IIF(LEFT(lcPic, 1) = "@", SUBSTR(lcPic, AT(" ", lcPic + " ") + 1), lcPic))
            IF EMPTY(lcMask) OR !("9" $ lcMask) OR CHRTRAN(lcMask, "9,.-$ ", "") != ""
                LOOP
            ENDIF
            lnCampos = lnCampos + 1
            lcSt  = IIF(BITTEST(fontstyle, 0), "B", "N")
            lnNec = TXTWIDTH(lcMask, ALLTRIM(fontface), fontsize, lcSt) * FONTMETRIC(6, ALLTRIM(fontface), fontsize, lcSt) / 96 * 10000
            lnLim = LimiteFonte(ALLTRIM(fontface), fontsize, lcSt)
            IF width / lnNec >= lnLim
                LOOP
            ENDIF
            lnNovo  = CEILING(lnNec * (lnLim + 0.03))
            lnDelta = lnNovo - width
            STRTOFILE(JUSTSTEM(laF[lnI, 1]) + "|" + TRANSFORM(RECNO()) + "|" + LEFT(ALLTRIM(expr), 25) + "|" + ALLTRIM(fontface) + " " + TRANSFORM(fontsize) + "|" + lcSt + "|" + lcMask + "|" + ;
                TRANSFORM(ROUND(width / lnNec, 3)) + "|" + TRANSFORM(lnLim) + "|" + TRANSFORM(INT(width)) + "|" + TRANSFORM(lnNovo) + "|" + TRANSFORM(offset) + CHR(13) + CHR(10), lcOut, .T.)
            lnAlt = lnAlt + 1
            lnLinhasFrx = lnLinhasFrx + 1
            IF par_cModo == "APLICAR"
                DO CASE
                    CASE offset = 1          && direita: cresce para a esquerda
                        REPLACE hpos WITH MAX(0, hpos - lnDelta), width WITH lnNovo
                    CASE offset = 2          && centro: cresce para os dois lados
                        REPLACE hpos WITH MAX(0, hpos - lnDelta / 2), width WITH lnNovo
                    OTHERWISE                && esquerda: cresce para a direita
                        REPLACE width WITH lnNovo
                ENDCASE
            ENDIF
        ENDSCAN
        IF lnLinhasFrx > 0
            lnFrxAlt = lnFrxAlt + 1
        ENDIF
        USE IN frxc
    CATCH TO loE
        STRTOFILE("ERRO|" + laF[lnI, 1] + "|" + loE.Message + CHR(13) + CHR(10), lcOut, .T.)
        IF USED("frxc")
            USE IN frxc
        ENDIF
    ENDTRY
ENDFOR
STRTOFILE("TOTAL frx=" + TRANSFORM(lnN) + " campos_numericos_sem_stretch=" + TRANSFORM(lnCampos) + " campos_abaixo_do_limite=" + TRANSFORM(lnAlt) + " frx_afetados=" + TRANSFORM(lnFrxAlt) + CHR(13) + CHR(10), lcOut, .T.)
QUIT

*-- Folga minima (largura do campo / largura da mascara em pixels de tela)
*-- medida no PREVIEW REAL do motor 80 (Erro330, calibS/calibT). Fonte nao
*-- calibrada: 1.25 (conservador).
FUNCTION LimiteFonte(par_cFonte, par_nTam, par_cEst)
    LOCAL lcK
    lcK = UPPER(par_cFonte) + "|" + TRANSFORM(par_nTam) + "|" + par_cEst
    DO CASE
        CASE INLIST(lcK, "VERDANA|7|N", "COURIER NEW|10|N", "ARIAL NARROW|7|N")
            RETURN 1.00
        CASE lcK == "COURIER NEW|9|B"
            RETURN 1.05
        CASE INLIST(lcK, "VERDANA|8|N", "VERDANA|8|B", "ARIAL|8|N", "ARIAL|8|B", "ARIAL|9|N")
            RETURN 1.10
        CASE lcK == "ARIAL|7|N"
            RETURN 1.15
        CASE lcK == "VERDANA|7|B"
            RETURN 1.25
    ENDCASE
    RETURN 1.25
ENDFUNC
