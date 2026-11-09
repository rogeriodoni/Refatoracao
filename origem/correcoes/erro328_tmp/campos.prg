SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
LOCAL lcOut, loE
lcOut = "C:\4c\refatoracao\origem\correcoes\erro328_tmp\campos.txt"
STRTOFILE("", lcOut)
TRY
    SELECT 0
    USE "C:\4c\refatoracao\projeto\app\reports\SigReCtc.frx" AGAIN SHARED ALIAS frxc
    SCAN FOR objtype = 8 AND INLIST(UPPER(ALLTRIM(expr)), "VALOR", "VALLIQ", "TAXAS", "NUMES", "TOTAL_CARTAO", "TOTAL_EMPRESA", "TOTAL_GERAL", "TOTLIQ_CARTAO", "TOTLIQ_EMPRESA", "TOTLIQ_GERAL")
        STRTOFILE(PADR(ALLTRIM(expr), 15) + " rec=" + PADL(RECNO(), 3) + " hpos=" + TRANSFORM(INT(hpos)) + " w=" + TRANSFORM(INT(width)) + ;
            " font=" + ALLTRIM(fontface) + " " + TRANSFORM(fontsize) + " style=" + TRANSFORM(fontstyle) + ;
            " picture=[" + ALLTRIM(picture) + "] fillchar=[" + fillchar + "] stretch=" + TRANSFORM(stretch) + CHR(13) + CHR(10), lcOut, .T.)
    ENDSCAN
    SCAN FOR objtype = 18
        STRTOFILE("VAR " + PADR(ALLTRIM(name), 15) + " rec=" + PADL(RECNO(), 3) + " expr=[" + ALLTRIM(expr) + "] tipo calc=" + TRANSFORM(totaltype) + " reset=" + TRANSFORM(resettotal) + CHR(13) + CHR(10), lcOut, .T.)
    ENDSCAN
    USE IN frxc
CATCH TO loE
    STRTOFILE("ERRO " + loE.Message, lcOut, .T.)
ENDTRY
QUIT
