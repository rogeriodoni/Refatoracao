SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gcL307T
gcL307T = "C:\4c\automation\probe_erro307_tom.txt"
STRTOFILE("A: inicio" + CHR(13) + CHR(10), gcL307T)
LOCAL loc_cConn, loc_nH, loc_oE
=SQLSETPROP(0, "ConnectTimeOut", 15)
=SQLSETPROP(0, "DispLogin", 3)
=SQLSETPROP(0, "DispWarnings", .F.)
loc_cConn = "DRIVER={SQL Server};SERVER=192.168.200.10;DATABASE=DB_MBAHIA;UID=4control;PWD=f2016jstcr%@;"
TRY
    loc_nH = SQLSTRINGCONNECT(loc_cConn)
    L307T("B: handle = " + TRANSFORM(loc_nH))
    IF loc_nH > 0
        IF SQLEXEC(loc_nH, "SELECT Codigos, Descrs FROM SigCdTom ORDER BY Codigos", "cur_t") > 0
            L307T("C: SigCdTom -> " + TRANSFORM(RECCOUNT("cur_t")) + " linhas")
            SELECT cur_t
            SCAN
                L307T("   [" + PADL(ALLTRIM(TRANSFORM(cur_t.Codigos)), 2, "0") + "-" + ;
                      ALLTRIM(cur_t.Descrs) + "]")
            ENDSCAN
            USE IN cur_t
        ELSE
            LOCAL ARRAY laE[1]
            IF AERROR(laE) > 0
                L307T("C: SigCdTom -> ERRO: " + ALLTRIM(TRANSFORM(laE[2])))
            ENDIF
        ENDIF
        *-- que valores de Menus existem de fato nos dados?
        IF SQLEXEC(loc_nH, "SELECT DISTINCT Menus FROM SigCdOpe ORDER BY Menus", "cur_m") > 0
            L307T("D: valores DISTINTOS de Menus em SigCdOpe (" + TRANSFORM(RECCOUNT("cur_m")) + "):")
            SELECT cur_m
            SCAN
                L307T("   [" + ALLTRIM(cur_m.Menus) + "]")
            ENDSCAN
            USE IN cur_m
        ENDIF
        *-- e de SubMenus
        IF SQLEXEC(loc_nH, "SELECT DISTINCT SubMenus FROM SigCdOpe ORDER BY SubMenus", "cur_s") > 0
            L307T("E: valores DISTINTOS de SubMenus (" + TRANSFORM(RECCOUNT("cur_s")) + "):")
            SELECT cur_s
            SCAN
                L307T("   [" + ALLTRIM(cur_s.SubMenus) + "]")
            ENDSCAN
            USE IN cur_s
        ENDIF
        *-- e de TipoOps
        IF SQLEXEC(loc_nH, "SELECT DISTINCT TipoOps FROM SigCdOpe ORDER BY TipoOps", "cur_o") > 0
            L307T("F: valores DISTINTOS de TipoOps (" + TRANSFORM(RECCOUNT("cur_o")) + "):")
            SELECT cur_o
            SCAN
                L307T("   [" + TRANSFORM(cur_o.TipoOps) + "]")
            ENDSCAN
            USE IN cur_o
        ENDIF
        =SQLDISCONNECT(loc_nH)
    ENDIF
CATCH TO loc_oE
    L307T("EXCEPTION: " + loc_oE.Message)
ENDTRY
STRTOFILE("Z: fim" + CHR(13) + CHR(10), gcL307T, 1)
QUIT

PROCEDURE L307T(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcL307T, 1)
ENDPROC
