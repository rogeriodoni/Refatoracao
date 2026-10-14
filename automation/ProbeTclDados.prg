SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

=SQLSETPROP(0, "ConnectTimeOut", 20)
=SQLSETPROP(0, "DispLogin", 3)
=SQLSETPROP(0, "DispWarnings", .F.)

LOCAL loc_cConn, loc_nH, loc_cRes, loc_nR
loc_cRes = ""
loc_cConn = "Driver={SQL Server};Server=192.168.200.10;Database=DB_MBAHIA;Uid=4control;Pwd=f2016jstcr%@;"

loc_nH = SQLSTRINGCONNECT(loc_cConn)
IF loc_nH <= 0
    loc_cRes = "SEM CONEXAO com 192.168.200.10 (handle=" + TRANSFORM(loc_nH) + ")" + CHR(13)+CHR(10)
    LOCAL ARRAY laE(1)
    IF AERROR(laE) > 0
        loc_cRes = loc_cRes + "  " + TRANSFORM(laE(2)) + CHR(13)+CHR(10)
    ENDIF
ELSE
    loc_cRes = "CONECTADO (handle=" + TRANSFORM(loc_nH) + ")" + CHR(13)+CHR(10)

    loc_nR = SQLEXEC(loc_nH, "SELECT nivels, LEN(RTRIM(classes)) AS tam, COUNT(*) AS qtd " + ;
        "FROM SigCdCss GROUP BY nivels, LEN(RTRIM(classes)) ORDER BY nivels, tam", "cDist")
    IF loc_nR > 0
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + "DISTRIBUICAO nivel x tamanho da classe:" + CHR(13)+CHR(10)
        loc_cRes = loc_cRes + "  nivel  tam  qtd" + CHR(13)+CHR(10)
        SELECT cDist
        SCAN
            loc_cRes = loc_cRes + "  " + PADL(TRANSFORM(cDist.nivels),5) + PADL(TRANSFORM(cDist.tam),5) + ;
                PADL(TRANSFORM(cDist.qtd),5) + CHR(13)+CHR(10)
        ENDSCAN
    ELSE
        loc_cRes = loc_cRes + "FALHA na query de distribuicao" + CHR(13)+CHR(10)
    ENDIF

    loc_nR = SQLEXEC(loc_nH, "SELECT TOP 25 classes, nivels, descrs FROM SigCdCss " + ;
        "ORDER BY LEN(RTRIM(classes)) DESC, classes", "cTop")
    IF loc_nR > 0
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + "MAIORES classes:" + CHR(13)+CHR(10)
        SELECT cTop
        SCAN
            loc_cRes = loc_cRes + "  [" + RTRIM(cTop.classes) + "] len=" + ;
                PADL(TRANSFORM(LEN(RTRIM(cTop.classes))),2) + " nivel=" + TRANSFORM(cTop.nivels) + ;
                "  " + RTRIM(cTop.descrs) + CHR(13)+CHR(10)
        ENDSCAN
    ENDIF

    =SQLDISCONNECT(loc_nH)
ENDIF

STRTOFILE(loc_cRes, "C:\4c\automation\probe_tcl_dados.txt")
QUIT
