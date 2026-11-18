* ProbeF5StcDados.prg - quanta linha existe em SigFiSit / SigFiSii?
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cOut, loc_cRel, loc_nH, loc_cConn, loc_nR

loc_cOut = "C:\4c\automation\_f5stc_dados.txt"
loc_cRel = ""

loc_cConn = "DRIVER={SQL Server};SERVER=192.168.200.10;DATABASE=DB_MBAHIA;" + ;
            "UID=4control;PWD=f2016jstcr%@"
loc_nH = SQLSTRINGCONNECT(loc_cConn)
loc_cRel = loc_cRel + "handle = " + TRANSFORM(loc_nH) + CHR(13) + CHR(10)

IF loc_nH > 0
    loc_nR = SQLEXEC(loc_nH, "SELECT COUNT(*) AS n FROM SigFiSit", "c1")
    loc_cRel = loc_cRel + "SigFiSit  ret=" + TRANSFORM(loc_nR) + ;
        " n=" + IIF(loc_nR > 0, TRANSFORM(c1.n), "?") + CHR(13) + CHR(10)

    loc_nR = SQLEXEC(loc_nH, "SELECT COUNT(*) AS n FROM SigFiSii", "c2")
    loc_cRel = loc_cRel + "SigFiSii  ret=" + TRANSFORM(loc_nR) + ;
        " n=" + IIF(loc_nR > 0, TRANSFORM(c2.n), "?") + CHR(13) + CHR(10)

    loc_nR = SQLEXEC(loc_nH, "SELECT COUNT(*) AS n FROM SigFiSit a " + ;
        "INNER JOIN SigFiSii b ON a.carqmovs = b.carqmovs", "c3")
    loc_cRel = loc_cRel + "JOIN      ret=" + TRANSFORM(loc_nR) + ;
        " n=" + IIF(loc_nR > 0, TRANSFORM(c3.n), "?") + CHR(13) + CHR(10)

    IF loc_nR <= 0
        loc_cRel = loc_cRel + "erro: " + MESSAGE() + CHR(13) + CHR(10)
    ENDIF

    =SQLDISCONNECT(loc_nH)
ENDIF

STRTOFILE(loc_cRel, loc_cOut)
QUIT
