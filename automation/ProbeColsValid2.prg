SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gnConnHandle
#DEFINE OUT "C:\4c\automation\probe_colsvalid2.txt"
LOCAL loc_oE, loc_n
STRTOFILE("inicio" + CHR(13) + CHR(10), OUT)
TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    SET PROCEDURE TO (gcCaminhoUtils + "functions.prg") ADDITIVE
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    loc_n = SQLEXEC(gnConnHandle, ;
        "SELECT COLUMN_NAME, DATA_TYPE, NUMERIC_PRECISION AS NP, NUMERIC_SCALE AS NS," + ;
        " CHARACTER_MAXIMUM_LENGTH AS CLEN" + ;
        " FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'SIGCDPRO'" + ;
        " AND COLUMN_NAME IN ('ean13','conjunts','locals','cunis','cunips'," + ;
        "'ifors','pvens','moevs','fvendas','moepvs','valors','moedas','situas'," + ;
        "'cclass','pesoms','pcuss','fcustos','custofs','margems','pvideals','markupa')" + ;
        " ORDER BY COLUMN_NAME", "crX")
    STRTOFILE("SQLEXEC=" + TRANSFORM(loc_n) + " achadas=" + ;
        TRANSFORM(IIF(USED("crX"), RECCOUNT("crX"), -1)) + " de 21" + CHR(13) + CHR(10), OUT, 1)
    IF USED("crX")
        SELECT crX
        SCAN
            STRTOFILE("  " + PADR(ALLTRIM(crX.COLUMN_NAME), 12) + " " + ;
                PADR(ALLTRIM(crX.DATA_TYPE), 9) + " " + ;
                PADL(TRANSFORM(NVL(crX.NP, -1)), 3) + "," + ;
                PADR(TRANSFORM(NVL(crX.NS, -1)), 3) + " len=" + ;
                TRANSFORM(NVL(crX.CLEN, -1)) + CHR(13) + CHR(10), OUT, 1)
        ENDSCAN
    ENDIF
    FOR loc_i = 1 TO 3
        loc_cT = IIF(loc_i = 1, "SIGMVITN", IIF(loc_i = 2, "SIGMVHST", "SIGPRCPO"))
        loc_n = SQLEXEC(gnConnHandle, ;
            "SELECT COUNT(*) AS qtd FROM INFORMATION_SCHEMA.COLUMNS" + ;
            " WHERE TABLE_NAME = '" + loc_cT + "' AND COLUMN_NAME IN ('cpros','mats')", "crT")
        STRTOFILE("tabela " + PADR(loc_cT, 10) + " colunas cpros/mats = " + ;
            TRANSFORM(IIF(USED("crT"), crT.qtd, -1)) + CHR(13) + CHR(10), OUT, 1)
    ENDFOR
CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + CHR(13) + CHR(10), OUT, 1)
ENDTRY
STRTOFILE("fim" + CHR(13) + CHR(10), OUT, 1)
QUIT
