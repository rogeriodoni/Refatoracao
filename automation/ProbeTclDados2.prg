SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
=SQLSETPROP(0, "ConnectTimeOut", 20)
=SQLSETPROP(0, "DispLogin", 3)
=SQLSETPROP(0, "DispWarnings", .F.)

LOCAL loc_nH, loc_cRes, loc_nR
loc_cRes = ""
loc_nH = SQLSTRINGCONNECT("Driver={SQL Server};Server=192.168.200.10;Database=DB_MBAHIA;Uid=4control;Pwd=f2016jstcr%@;")
IF loc_nH <= 0
    loc_cRes = "SEM CONEXAO"
ELSE
    loc_nR = SQLEXEC(loc_nH, "SELECT COUNT(*) AS total, MIN(LEN(RTRIM(LTRIM(classes)))) AS minlen, " + ;
        "MAX(LEN(RTRIM(LTRIM(classes)))) AS maxlen, MAX(LEN(RTRIM(classes))) AS maxlen_sem_ltrim, " + ;
        "SUM(CASE WHEN classes <> LTRIM(classes) THEN 1 ELSE 0 END) AS com_espaco_esq, " + ;
        "MIN(nivels) AS minniv, MAX(nivels) AS maxniv FROM SigCdCss", "cAgg")
    IF loc_nR > 0
        SELECT cAgg
        loc_cRes = loc_cRes + "SigCdCss: total=" + TRANSFORM(cAgg.total) + ;
            "  len min=" + TRANSFORM(cAgg.minlen) + " max=" + TRANSFORM(cAgg.maxlen) + ;
            " (sem LTRIM max=" + TRANSFORM(cAgg.maxlen_sem_ltrim) + ")" + ;
            "  com espaco a esquerda=" + TRANSFORM(cAgg.com_espaco_esq) + ;
            "  nivels de " + TRANSFORM(cAgg.minniv) + " a " + TRANSFORM(cAgg.maxniv) + CHR(13)+CHR(10)
    ENDIF

    *-- a coluna e char(10)? confirma no INFORMATION_SCHEMA
    loc_nR = SQLEXEC(loc_nH, "SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, NUMERIC_PRECISION " + ;
        "FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'SigCdCss' ORDER BY ORDINAL_POSITION", "cCol")
    IF loc_nR > 0
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + "COLUNAS de SigCdCss:" + CHR(13)+CHR(10)
        SELECT cCol
        SCAN
            loc_cRes = loc_cRes + "  " + PADR(RTRIM(cCol.COLUMN_NAME),14) + PADR(RTRIM(cCol.DATA_TYPE),10) + ;
                "len=" + TRANSFORM(NVL(cCol.CHARACTER_MAXIMUM_LENGTH,0)) + CHR(13)+CHR(10)
        ENDSCAN
    ENDIF

    *-- TODOS os registros, para o usuario conferir
    loc_nR = SQLEXEC(loc_nH, "SELECT classes, nivels, descrs FROM SigCdCss ORDER BY classes", "cAll")
    IF loc_nR > 0
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + "TODOS os registros:" + CHR(13)+CHR(10)
        SELECT cAll
        SCAN
            loc_cRes = loc_cRes + "  [" + RTRIM(cAll.classes) + "]" + ;
                SPACE(6 - MIN(6,LEN(RTRIM(cAll.classes)))) + ;
                " len=" + TRANSFORM(LEN(RTRIM(cAll.classes))) + ;
                " nivel=" + TRANSFORM(cAll.nivels) + "  " + RTRIM(cAll.descrs) + CHR(13)+CHR(10)
        ENDSCAN
    ENDIF
    =SQLDISCONNECT(loc_nH)
ENDIF
STRTOFILE(loc_cRes, "C:\4c\automation\probe_tcl_dados2.txt")
QUIT
