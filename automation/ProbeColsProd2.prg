SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gnConnHandle
#DEFINE OUT "C:\4c\automation\probe_colsprod2.txt"
LOCAL loc_oE, loc_n, loc_c, loc_cLista, loc_i
LOCAL ARRAY loc_aCols[43]
loc_aCols[1]="AtivoSite"
loc_aCols[2]="BrcEsp"
loc_aCols[3]="Categoria"
loc_aCols[4]="CnjLacto"
loc_aCols[5]="codAcbs"
loc_aCols[6]="CodCors"
loc_aCols[7]="CodCtgSite"
loc_aCols[8]="CodDptSite"
loc_aCols[9]="CodMacro"
loc_aCols[10]="CodTams"
loc_aCols[11]="consigs"
loc_aCols[12]="DispEnc"
loc_aCols[13]="DPro3s"
loc_aCols[14]="dpro4s"
loc_aCols[15]="dsccompras"
loc_aCols[16]="DtLacto"
loc_aCols[17]="DtSituas"
loc_aCols[18]="encoms"
loc_aCols[19]="espessus"
loc_aCols[20]="fabrproprs"
loc_aCols[21]="FimDtLacto"
loc_aCols[22]="ForaLinha"
loc_aCols[23]="Lancamento"
loc_aCols[24]="mostruario"
loc_aCols[25]="ObrTamSer"
loc_aCols[26]="obscompras"
loc_aCols[27]="obsMkt"
loc_aCols[28]="OrigemLac"
loc_aCols[29]="pesobs"
loc_aCols[30]="pesoms"
loc_aCols[31]="ProdNovo"
loc_aCols[32]="ProdOff"
loc_aCols[33]="prodwebs"
loc_aCols[34]="qmins"
loc_aCols[35]="SegFem"
loc_aCols[36]="SegInf"
loc_aCols[37]="SegKids"
loc_aCols[38]="SegMasc"
loc_aCols[39]="SegUni"
loc_aCols[40]="SemConsulta"
loc_aCols[41]="tamhs"
loc_aCols[42]="tamls"
loc_aCols[43]="tamps"
STRTOFILE("inicio" + CHR(13)+CHR(10), OUT)
TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    SET PROCEDURE TO (gcCaminhoUtils + "functions.prg") ADDITIVE
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    loc_cLista = ""
    FOR loc_i = 1 TO ALEN(loc_aCols)
        loc_cLista = loc_cLista + IIF(EMPTY(loc_cLista), "", ",") + "'" + loc_aCols[loc_i] + "'"
    ENDFOR
    loc_c = "SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH AS CLEN," + ;
        " NUMERIC_PRECISION AS NP, NUMERIC_SCALE AS NS, IS_NULLABLE AS NULAVEL" + ;
        " FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'SIGCDPRO'" + ;
        " AND COLUMN_NAME IN (" + loc_cLista + ") ORDER BY COLUMN_NAME"
    loc_n = SQLEXEC(gnConnHandle, loc_c, "crCols")
    STRTOFILE("SQLEXEC=" + TRANSFORM(loc_n) + " achadas=" + ;
        TRANSFORM(IIF(USED("crCols"), RECCOUNT("crCols"), -1)) + " de " + ;
        TRANSFORM(ALEN(loc_aCols)) + CHR(13)+CHR(10), OUT, 1)
    IF USED("crCols")
        SELECT crCols
        SCAN
            STRTOFILE(PADR(ALLTRIM(crCols.COLUMN_NAME), 14) + " " + ;
                PADR(ALLTRIM(crCols.DATA_TYPE), 9) + " len=" + ;
                PADL(TRANSFORM(NVL(crCols.CLEN, -1)), 6) + " " + ;
                PADL(TRANSFORM(NVL(crCols.NP, -1)), 3) + "," + ;
                PADR(TRANSFORM(NVL(crCols.NS, -1)), 3) + " null=" + ;
                ALLTRIM(crCols.NULAVEL) + CHR(13)+CHR(10), OUT, 1)
        ENDSCAN
        STRTOFILE(CHR(13)+CHR(10) + "=== NAO EXISTEM ===" + CHR(13)+CHR(10), OUT, 1)
        FOR loc_i = 1 TO ALEN(loc_aCols)
            SELECT crCols
            LOCATE FOR UPPER(ALLTRIM(COLUMN_NAME)) == UPPER(loc_aCols[loc_i])
            IF !FOUND()
                STRTOFILE("   " + loc_aCols[loc_i] + CHR(13)+CHR(10), OUT, 1)
            ENDIF
        ENDFOR
    ENDIF
CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + " linha " + TRANSFORM(loc_oE.LineNo) + CHR(13)+CHR(10), OUT, 1)
ENDTRY
STRTOFILE("fim" + CHR(13)+CHR(10), OUT, 1)
QUIT
