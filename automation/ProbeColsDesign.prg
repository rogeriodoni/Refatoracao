SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gnConnHandle
#DEFINE OUT "C:\4c\automation\probe_colsdesign.txt"
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
        " AND COLUMN_NAME IN ('deslacto','crialacto','dtapramo','obsinsp'," + ;
        "'chkfunds','qtdcpnts','ultcomps','varias','cravcers','volumes'," + ;
        "'qtminfabs','markupa','montadescs','compos','casas','digimaxs','ordcompos')" + ;
        " ORDER BY COLUMN_NAME", "crD")
    STRTOFILE("SQLEXEC=" + TRANSFORM(loc_n) + " achadas=" + ;
        TRANSFORM(IIF(USED("crD"), RECCOUNT("crD"), -1)) + " de 17" + CHR(13) + CHR(10), OUT, 1)
    IF USED("crD")
        SELECT crD
        SCAN
            STRTOFILE(PADR(ALLTRIM(crD.COLUMN_NAME), 14) + " " + ;
                PADR(ALLTRIM(crD.DATA_TYPE), 10) + " len=" + ;
                PADL(TRANSFORM(NVL(crD.CLEN, -1)), 6) + " " + ;
                PADL(TRANSFORM(NVL(crD.NP, -1)), 3) + "," + ;
                PADR(TRANSFORM(NVL(crD.NS, -1)), 3) + " null=" + ;
                ALLTRIM(crD.NULAVEL) + CHR(13) + CHR(10), OUT, 1)
        ENDSCAN
    ENDIF
CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + CHR(13) + CHR(10), OUT, 1)
ENDTRY
STRTOFILE("fim" + CHR(13) + CHR(10), OUT, 1)
QUIT
