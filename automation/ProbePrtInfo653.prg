SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL
LOCAL lcOut, loErr, lnQtd
lcOut = ""

*-- AFONT devolve LOGICO (nao contagem) - comparar com 0 estoura?
LOCAL ARRAY laF[1]
lnQtd = AFONT(laF)
lcOut = lcOut + "AFONT retorno: tipo=" + VARTYPE(lnQtd) + " val=" + TRANSFORM(lnQtd) + CHR(13) + CHR(10)
lcOut = lcOut + "ALEN(laF,1)=" + TRANSFORM(ALEN(laF,1)) + " laF[1]=[" + TRANSFORM(laF[1]) + "]" + CHR(13)+CHR(10)
TRY
    IF lnQtd > 0
        lcOut = lcOut + "IF <logico> > 0 : NAO estourou (avaliou .T.)" + CHR(13) + CHR(10)
    ELSE
        lcOut = lcOut + "IF <logico> > 0 : NAO estourou (avaliou .F.)" + CHR(13) + CHR(10)
    ENDIF
CATCH TO loErr
    lcOut = lcOut + "IF <logico> > 0 : ERRO " + TRANSFORM(loErr.ErrorNo) + " - " + loErr.Message + CHR(13) + CHR(10)
ENDTRY

*-- APRINTERS: dimensoes reais
LOCAL ARRAY laP[1]
lnQtd = APRINTERS(laP)
lcOut = lcOut + "APRINTERS tipo=" + VARTYPE(lnQtd) + " qtd=" + TRANSFORM(lnQtd) + ;
        " ALEN(,1)=" + TRANSFORM(ALEN(laP,1)) + " ALEN(,2)=" + TRANSFORM(ALEN(laP,2)) + CHR(13)+CHR(10)
lcOut = lcOut + "  laP[1,1]=[" + TRANSFORM(laP[1,1]) + "]" + CHR(13) + CHR(10)

*-- PRTINFO(2) = codigo do tamanho de papel (DEVMODE dmPaperSize)
TRY
    lcOut = lcOut + "SET('PRINTER')=[" + SET("PRINTER") + "] GETPRINTER-default=[" + ;
            TRANSFORM(SET("PRINTER", 3)) + "]" + CHR(13) + CHR(10)
CATCH TO loErr
    lcOut = lcOut + "SET PRINTER: ERRO " + loErr.Message + CHR(13) + CHR(10)
ENDTRY
TRY
    LOCAL lnPaper
    lnPaper = PRTINFO(2)
    lcOut = lcOut + "PRTINFO(2): tipo=" + VARTYPE(lnPaper) + " val=" + TRANSFORM(lnPaper) + CHR(13) + CHR(10)
CATCH TO loErr
    lcOut = lcOut + "PRTINFO(2): ERRO " + TRANSFORM(loErr.ErrorNo) + " - " + loErr.Message + CHR(13) + CHR(10)
ENDTRY
TRY
    lcOut = lcOut + "PRTINFO(3)=" + TRANSFORM(PRTINFO(3)) + " PRTINFO(4)=" + TRANSFORM(PRTINFO(4)) + CHR(13)+CHR(10)
CATCH TO loErr
    lcOut = lcOut + "PRTINFO(3/4): ERRO " + loErr.Message + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(lcOut, "C:\4c\automation\probe_prtinfo653.txt")
QUIT
