SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gnConnHandle
#DEFINE OUT "C:\4c\automation\probe_colsgrp.txt"
LOCAL loc_oE, loc_n
STRTOFILE("inicio" + CHR(13) + CHR(10), OUT)
TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    SET PROCEDURE TO (gcCaminhoUtils + "functions.prg") ADDITIVE
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    loc_n = SQLEXEC(gnConnHandle, ;
        "SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH AS CLEN" + ;
        " FROM INFORMATION_SCHEMA.COLUMNS" + ;
        " WHERE (TABLE_NAME = 'SIGCDGRP' AND COLUMN_NAME IN ('cunips','cfggergprs','cgrus','dgrus'))" + ;
        "    OR (TABLE_NAME = 'SIGCDPAM' AND COLUMN_NAME IN ('cunis','codprods'))" + ;
        " ORDER BY TABLE_NAME, COLUMN_NAME", "crC")
    STRTOFILE("SQLEXEC=" + TRANSFORM(loc_n) + " linhas=" + ;
        TRANSFORM(IIF(USED("crC"), RECCOUNT("crC"), -1)) + CHR(13) + CHR(10), OUT, 1)
    IF USED("crC")
        SELECT crC
        SCAN
            STRTOFILE(PADR(ALLTRIM(crC.TABLE_NAME), 10) + " " + ;
                PADR(ALLTRIM(crC.COLUMN_NAME), 14) + " " + ;
                PADR(ALLTRIM(crC.DATA_TYPE), 10) + " len=" + ;
                TRANSFORM(NVL(crC.CLEN, -1)) + CHR(13) + CHR(10), OUT, 1)
        ENDSCAN
    ENDIF
    loc_n = SQLEXEC(gnConnHandle, ;
        "SELECT TOP 3 cgrus, cunips, cfggergprs FROM SigCdGrp ORDER BY cgrus", "crG")
    IF USED("crG")
        SELECT crG
        SCAN
            STRTOFILE("  GRP [" + ALLTRIM(crG.cgrus) + "] cunips=[" + ;
                ALLTRIM(NVL(crG.cunips, "")) + "] cfg(11,3)=[" + ;
                SUBSTR(ALLTRIM(NVL(crG.cfggergprs, "")) + SPACE(40), 11, 3) + "]" + ;
                CHR(13) + CHR(10), OUT, 1)
        ENDSCAN
    ENDIF
    loc_n = SQLEXEC(gnConnHandle, "SELECT TOP 1 cunis FROM SigCdPam", "crP")
    IF USED("crP") AND RECCOUNT("crP") > 0
        STRTOFILE("  PAM cunis=[" + ALLTRIM(NVL(crP.cunis, "")) + "]" + CHR(13) + CHR(10), OUT, 1)
    ENDIF
CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + CHR(13) + CHR(10), OUT, 1)
ENDTRY
STRTOFILE("fim" + CHR(13) + CHR(10), OUT, 1)
QUIT
