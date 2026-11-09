SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcDir, gcOut
gcDir = "C:\4c\refatoracao\origem\correcoes\erro330_tmp\"
gcOut = gcDir + "calib.txt"
STRTOFILE("", gcOut)
LOCAL loE, lnV0, lnRow, lnCol, lnC, lnR, lnNec, lnW, lcSt, lcLbl, laFont[8,3], laRat[8], lcMask, lnT
laFont[1,1] = "Verdana"
laFont[1,2] = 7
laFont[1,3] = "N"
laFont[2,1] = "Verdana"
laFont[2,2] = 8
laFont[2,3] = "N"
laFont[3,1] = "Verdana"
laFont[3,2] = 8
laFont[3,3] = "B"
laFont[4,1] = "Verdana"
laFont[4,2] = 7
laFont[4,3] = "B"
laFont[5,1] = "Arial"
laFont[5,2] = 7
laFont[5,3] = "N"
laFont[6,1] = "Arial"
laFont[6,2] = 8
laFont[6,3] = "N"
laFont[7,1] = "Arial"
laFont[7,2] = 8
laFont[7,3] = "B"
laFont[8,1] = "Arial"
laFont[8,2] = 9
laFont[8,3] = "N"
laRat[1] = 0.85
laRat[2] = 0.90
laRat[3] = 0.95
laRat[4] = 1.00
laRat[5] = 1.05
laRat[6] = 1.10
laRat[7] = 1.15
laRat[8] = 1.20
lcMask = "999,999,999.99"
TRY
    _SCREEN.Visible = .T.
    _SCREEN.WindowState = 2
    CREATE CURSOR crCalib (v N(13,2))
    INSERT INTO crCalib VALUES (4298.50)
    CREATE REPORT (gcDir + "calibP") FROM crCalib
    SELECT 0
    USE (gcDir + "calibP.frx") EXCLUSIVE ALIAS fc
    LOCATE FOR objtype = 8 AND UPPER(ALLTRIM(expr)) == "V"
    lnV0 = vpos
    SCATTER MEMVAR MEMO
    DELETE
    REPLACE height WITH 70000 FOR objtype = 9 AND objcode = 4
    lnRow = 0
    FOR lnC = 1 TO 8
        lcSt = laFont[lnC, 3]
        lnNec = TXTWIDTH(lcMask, laFont[lnC,1], laFont[lnC,2], lcSt) * FONTMETRIC(6, laFont[lnC,1], laFont[lnC,2], lcSt) / 96 * 10000
        lnCol = IIF(lnC <= 4, 0, 1)
        FOR lnR = 1 TO 8
            lnW = ROUND(lnNec * laRat[lnR], 0)
            lnT = lnV0 + (((lnC - 1) % 4) * 8 + (lnR - 1)) * 1900
            *-- rotulo
            m.expr = "'" + laFont[lnC,1] + " " + TRANSFORM(laFont[lnC,2]) + lcSt + " folga " + TRANSFORM(laRat[lnR]) + "'"
            m.picture = ""
            m.fillchar = "C"
            m.fontface = "Verdana"
            m.fontsize = 7
            m.fontstyle = 0
            m.hpos = 2000 + lnCol * 55000
            m.vpos = lnT
            m.width = 20000
            m.height = 1500
            m.uniqueid = SYS(2015)
            APPEND BLANK
            GATHER MEMVAR MEMO
            *-- campo numerico em teste
            m.expr = "v"
            m.picture = '"' + lcMask + '"'
            m.fillchar = "N"
            m.fontface = laFont[lnC,1]
            m.fontsize = laFont[lnC,2]
            m.fontstyle = IIF(lcSt = "B", 1, 0)
            m.hpos = 23000 + lnCol * 55000
            m.width = lnW
            m.uniqueid = SYS(2015)
            APPEND BLANK
            GATHER MEMVAR MEMO
        ENDFOR
    ENDFOR
    PACK
    GO TOP
    REPLACE expr WITH STRTRAN(expr, "ORIENTATION=0", "ORIENTATION=1")
    USE IN fc
    SELECT crCalib
    SET POINT TO "."
    SET SEPARATOR TO ","
    SET REPORTBEHAVIOR 80
    REPORT FORM (gcDir + "calibP") PREVIEW NOWAIT NOCONSOLE
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
