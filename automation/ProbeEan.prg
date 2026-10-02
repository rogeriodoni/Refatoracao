SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gnConnHandle
#DEFINE OUT "C:\4c\automation\probe_ean.txt"
LOCAL loc_oE, loc_n
STRTOFILE("inicio" + CHR(13) + CHR(10), OUT)
TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    SET PROCEDURE TO (gcCaminhoUtils + "functions.prg") ADDITIVE
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    loc_n = SQLEXEC(gnConnHandle, ;
        "SELECT COUNT(*) AS qtd FROM SigCdPro WHERE ean13 <> 0", "crQ")
    STRTOFILE("produtos com ean13 <> 0 : " + ;
        TRANSFORM(IIF(USED("crQ"), crQ.qtd, -1)) + CHR(13) + CHR(10), OUT, 1)
    loc_n = SQLEXEC(gnConnHandle, ;
        "SELECT TOP 3 cpros, ean13 FROM SigCdPro WHERE ean13 <> 0 ORDER BY cpros", "crE")
    IF USED("crE")
        SELECT crE
        SCAN
            STRTOFILE("  cpros=[" + ALLTRIM(crE.cpros) + "] ean13=" + ;
                TRANSFORM(crE.ean13) + " vartype=" + VARTYPE(crE.ean13) + ;
                " FormatarNumeroSQL=[" + FormatarNumeroSQL(crE.ean13, 0) + "]" + ;
                CHR(13) + CHR(10), OUT, 1)
        ENDSCAN
    ENDIF
    *-- tambem conferir cbars, que o legado usa como codigo de barras
    loc_n = SQLEXEC(gnConnHandle, ;
        "SELECT COUNT(*) AS qtd FROM SigCdPro WHERE cbars <> 0", "crC")
    STRTOFILE("produtos com cbars <> 0 : " + ;
        TRANSFORM(IIF(USED("crC"), crC.qtd, -1)) + CHR(13) + CHR(10), OUT, 1)
CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + CHR(13) + CHR(10), OUT, 1)
ENDTRY
STRTOFILE("fim" + CHR(13) + CHR(10), OUT, 1)
QUIT
