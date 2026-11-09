SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir
gcDir = "C:\4c\refatoracao\origem\correcoes\erro328_tmp\"
gcOut = gcDir + "png.txt"
STRTOFILE("", gcOut)
LOCAL loE, loT
TRY
    DO ("C:\4c\refatoracao\projeto\app\start\config.prg")
    ConfigurarAmbiente()
    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"
    SET PROCEDURE TO (gcDir + "sigrectcBO.prg") ADDITIVE
    SET DATE TO BRITISH
    SET CENTURY ON
    loT = CREATEOBJECT("T328P")
    loT.this_dDtInicial = DATE(2000,1,1)
    loT.this_dDtFinal   = DATE(2026,11,9)
    loT.this_lEntrada = .T.
    loT.this_lReceber = .T.
    loT.this_lDepositar = .T.
    loT.this_lBaixa = .T.
    STRTOFILE("A (SETs do app: POINT , SEP . BEHAVIOR 90): " + loT.Png(",", ".", 90, gcDir + "relA") + CHR(13)+CHR(10), gcOut, .T.)
    STRTOFILE("B (isolado: POINT . SEP , BEHAVIOR 80):    " + loT.Png(".", ",", 80, gcDir + "relB") + CHR(13)+CHR(10), gcOut, .T.)
CATCH TO loE
    STRTOFILE("ERRO " + loE.Message + " " + TRANSFORM(loE.LineNo) + CHR(13)+CHR(10), gcOut, .T.)
ENDTRY
QUIT

DEFINE CLASS T328P AS sigrectcBO
    PROCEDURE Png(par_cPoint, par_cSep, par_nBeh, par_cArq)
        LOCAL loL, loE2, lcR
        PRIVATE dDtInicial, dDtFinal
        dDtInicial = THIS.this_dDtInicial
        dDtFinal   = THIS.this_dDtFinal
        lcR = ""
        TRY
            IF THIS.PrepararDados()
                SELECT (THIS.this_cCursorDados)
                GO TOP
                SET POINT TO (par_cPoint)
                SET SEPARATOR TO (par_cSep)
                SET REPORTBEHAVIOR (par_nBeh)
                loL = CREATEOBJECT("ReportListener")
                loL.ListenerType = 3
                REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) OBJECT loL NOCONSOLE
                loL.OutputPage(1, par_cArq + ".png", 104)
                lcR = "paginas=" + TRANSFORM(loL.PageTotal) + " png=" + TRANSFORM(FILE(par_cArq + ".png"))
            ENDIF
        CATCH TO loE2
            lcR = "ERRO " + TRANSFORM(loE2.ErrorNo) + " " + loE2.Message
        ENDTRY
        RETURN lcR
    ENDPROC
ENDDEFINE
