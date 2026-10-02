SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gnConnHandle
#DEFINE OUT "C:\4c\automation\probe_colsfiscal.txt"
LOCAL loc_oE, loc_n
STRTOFILE("inicio" + CHR(13) + CHR(10), OUT)
TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    SET PROCEDURE TO (gcCaminhoUtils + "functions.prg") ADDITIVE
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    loc_n = SQLEXEC(gnConnHandle, ;
        "SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH AS CLEN," + ;
        " NUMERIC_PRECISION AS NP, NUMERIC_SCALE AS NS, IS_NULLABLE AS NULAVEL" + ;
        " FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'SIGCDPRO'" + ;
        " AND COLUMN_NAME IN ('codimppro','dcodimppro','codnacpro','coddcr'," + ;
        "'tpcodpro','clfiscals','origmercs','tptribs','sittricms','codservs'," + ;
        "'teors','metals','descfis','valors','moedas','icms','descecfs'," + ;
        "'aliqipis','extipi','iats','gruccus','contaccus')" + ;
        " ORDER BY COLUMN_NAME", "crF")
    STRTOFILE("SQLEXEC=" + TRANSFORM(loc_n) + " achadas=" + ;
        TRANSFORM(IIF(USED("crF"), RECCOUNT("crF"), -1)) + " de 22" + CHR(13) + CHR(10), OUT, 1)
    IF USED("crF")
        SELECT crF
        SCAN
            STRTOFILE(PADR(ALLTRIM(crF.COLUMN_NAME), 14) + " " + ;
                PADR(ALLTRIM(crF.DATA_TYPE), 10) + " len=" + ;
                PADL(TRANSFORM(NVL(crF.CLEN, -1)), 6) + " " + ;
                PADL(TRANSFORM(NVL(crF.NP, -1)), 3) + "," + ;
                PADR(TRANSFORM(NVL(crF.NS, -1)), 3) + " null=" + ;
                ALLTRIM(crF.NULAVEL) + CHR(13) + CHR(10), OUT, 1)
        ENDSCAN
    ENDIF
CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + CHR(13) + CHR(10), OUT, 1)
ENDTRY
STRTOFILE("fim" + CHR(13) + CHR(10), OUT, 1)
QUIT
