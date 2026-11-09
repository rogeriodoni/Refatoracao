SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcDir, gcOut
gcDir = "C:\4c\refatoracao\origem\correcoes\erro330_tmp\"
gcOut = gcDir + "calib.txt"
STRTOFILE("", gcOut)
LOCAL loE, lnV0, lnC, lnR, lnNec, lnW, lnT, lcMask, laTipo[5,4], laRat[8]
*-- expr, estilo, rotulo, coluna
laTipo[1,1] = "v"
laTipo[1,2] = 1
laTipo[1,3] = "campo 8B"
laTipo[1,4] = 0
laTipo[2,1] = "nSoma"
laTipo[2,2] = 1
laTipo[2,3] = "SUM 8B"
laTipo[2,4] = 0
laTipo[3,1] = "v*1"
laTipo[3,2] = 1
laTipo[3,3] = "v*1 8B"
laTipo[3,4] = 1
laTipo[4,1] = "nSoma"
laTipo[4,2] = 0
laTipo[4,3] = "SUM 8N"
laTipo[4,4] = 1
laRat[1] = 0.85
laRat[2] = 0.95
laRat[3] = 1.00
laRat[4] = 1.05
laRat[5] = 1.10
laRat[6] = 1.15
laRat[7] = 1.20
laRat[8] = 1.30
lcMask = "999,999,999.99"
TRY
    _SCREEN.Visible = .T.
    _SCREEN.WindowState = 2
    CREATE CURSOR crCalib (v N(13,2))
    INSERT INTO crCalib VALUES (4298.50)
    CREATE REPORT (gcDir + "calib2") FROM crCalib
    *-- molde de variavel de relatorio (SUM) tirado do SigReCtc
    SELECT 0
    USE "C:\4c\refatoracao\projeto\app\reports\SigReCtc.frx" AGAIN SHARED ALIAS fsrc
    LOCATE FOR objtype = 18
    SCATTER MEMVAR MEMO
    USE IN fsrc
    m.name = "nSoma"
    m.expr = "v"
    m.totaltype = 2
    m.resettotal = 1
    m.uniqueid = SYS(2015)
    SELECT 0
    USE (gcDir + "calib2.frx") EXCLUSIVE ALIAS fc
    APPEND BLANK
    GATHER MEMVAR MEMO
    LOCATE FOR objtype = 8 AND UPPER(ALLTRIM(expr)) == "V"
    lnV0 = vpos
    SCATTER MEMVAR MEMO
    DELETE
    REPLACE height WITH 70000 FOR objtype = 9 AND objcode = 4
    FOR lnC = 1 TO 4
        lnNec = TXTWIDTH(lcMask, "Verdana", 8, IIF(laTipo[lnC,2] = 1, "B", "N")) * FONTMETRIC(6, "Verdana", 8, IIF(laTipo[lnC,2] = 1, "B", "N")) / 96 * 10000
        FOR lnR = 1 TO 8
            lnW = ROUND(lnNec * laRat[lnR], 0)
            lnT = lnV0 + (IIF(lnC % 2 = 1, 0, 9) + (lnR - 1)) * 1900
            m.expr = "'" + laTipo[lnC,3] + " folga " + TRANSFORM(laRat[lnR]) + " w=" + TRANSFORM(lnW) + "'"
            m.picture = ""
            m.fillchar = "C"
            m.fontface = "Verdana"
            m.fontsize = 7
            m.fontstyle = 0
            m.hpos = 2000 + laTipo[lnC,4] * 55000
            m.vpos = lnT
            m.width = 22000
            m.height = 1500
            m.uniqueid = SYS(2015)
            APPEND BLANK
            GATHER MEMVAR MEMO
            m.expr = laTipo[lnC,1]
            m.picture = '"' + lcMask + '"'
            m.fillchar = "N"
            m.fontface = "Verdana"
            m.fontsize = 8
            m.fontstyle = laTipo[lnC,2]
            m.hpos = 25000 + laTipo[lnC,4] * 55000
            m.width = lnW
            m.uniqueid = SYS(2015)
            APPEND BLANK
            GATHER MEMVAR MEMO
        ENDFOR
    ENDFOR
    PACK
    USE IN fc
    SELECT crCalib
    SET POINT TO "."
    SET SEPARATOR TO ","
    SET REPORTBEHAVIOR 80
    REPORT FORM (gcDir + "calib2") PREVIEW NOWAIT NOCONSOLE
    IF WEXIST("Report Designer")
        ZOOM WINDOW "Report Designer" MAX
    ENDIF
    STRTOFILE("PRONTO" + CHR(13) + CHR(10), gcOut, .T.)
    lnT = SECONDS()
    DO WHILE SECONDS() - lnT < 25
        DOEVENTS
    ENDDO
CATCH TO loE
    STRTOFILE("ERRO " + loE.Message + " " + TRANSFORM(loE.LineNo) + CHR(13) + CHR(10), gcOut, .T.)
ENDTRY
