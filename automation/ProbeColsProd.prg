SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gnConnHandle
#DEFINE OUT "C:\4c\automation\probe_colsprod.txt"
LOCAL loc_oE, loc_n, loc_c
STRTOFILE("inicio" + CHR(13)+CHR(10), OUT)
TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    SET PROCEDURE TO (gcCaminhoUtils + "functions.prg") ADDITIVE
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    STRTOFILE("conn=" + TRANSFORM(gnConnHandle) + CHR(13)+CHR(10), OUT, 1)
    loc_c = "SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, NUMERIC_PRECISION," + ;
        " NUMERIC_SCALE, IS_NULLABLE FROM INFORMATION_SCHEMA.COLUMNS" + ;
        " WHERE TABLE_NAME = 'SIGCDPRO' AND COLUMN_NAME IN (" + ;
        "'cnjlacto','dpro4s','dpro3s','dsccompras','obscompras','obsmkt'," + ;
        "'codctgsite','coddptsite','ativosite','semconsulta','categoria'," + ;
        "'codmacro','obrtamser','qmins','dtsituas','lancamento','origemlac'," + ;
        "'dtlacto','fimdtlacto','cor','tam','codacb','pesobs','pmedio'," + ;
        "'consig','fabrpropr','encoms','naocomprar','produtonovo'," + ;
        "'mostruario','off','masculino','feminino','unissex','baby','kids'," + ;
        "'colecoes','dclass','caracteristica') ORDER BY COLUMN_NAME"
    loc_n = SQLEXEC(gnConnHandle, loc_c, "crCols")
    STRTOFILE("SQLEXEC=" + TRANSFORM(loc_n) + " linhas=" + ;
        TRANSFORM(IIF(USED("crCols"), RECCOUNT("crCols"), -1)) + CHR(13)+CHR(10), OUT, 1)
    IF USED("crCols")
        SELECT crCols
        SCAN
            STRTOFILE(PADR(ALLTRIM(crCols.COLUMN_NAME), 16) + " " + ;
                PADR(ALLTRIM(crCols.DATA_TYPE), 10) + " len=" + ;
                PADL(TRANSFORM(NVL(crCols.CHARACTER_MAXIMUM_LENGTH, -1)), 5) + " prec=" + ;
                PADL(TRANSFORM(NVL(crCols.NUMERIC_PRECISION, -1)), 4) + "," + ;
                TRANSFORM(NVL(crCols.NUMERIC_SCALE, -1)) + " null=" + ;
                ALLTRIM(crCols.IS_NULLABLE) + CHR(13)+CHR(10), OUT, 1)
        ENDSCAN
    ENDIF
CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + " linha " + TRANSFORM(loc_oE.LineNo) + CHR(13)+CHR(10), OUT, 1)
ENDTRY
STRTOFILE("fim" + CHR(13)+CHR(10), OUT, 1)
QUIT
