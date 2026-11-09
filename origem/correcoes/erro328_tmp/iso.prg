SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir
gcDir = "C:\4c\refatoracao\origem\correcoes\erro328_tmp\"
gcOut = gcDir + "iso.txt"
STRTOFILE("", gcOut)
LOCAL loE, loT
TRY
    DO ("C:\4c\refatoracao\projeto\app\start\config.prg")
    ConfigurarAmbiente()
    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"
    SET PROCEDURE TO (gcDir + "relatoriobase.prg"), (gcDir + "sigrectcBO.prg") ADDITIVE
    SET DATE TO BRITISH
    SET CENTURY ON
    loT = CREATEOBJECT("T328I")
    loT.this_dDtInicial = DATE(2000,1,1)
    loT.this_dDtFinal   = DATE(2026,11,9)
    STORE .T. TO loT.this_lEntrada, loT.this_lReceber, loT.this_lDepositar, loT.this_lBaixa
    SET POINT TO ","
    SET SEPARATOR TO "."
    SET REPORTBEHAVIOR 90
    L("SETs antes: POINT=[" + SET("POINT") + "] SEP=[" + SET("SEPARATOR") + "] BEH=" + TRANSFORM(SET("REPORTBEHAVIOR")))
    L("cru:      " + loT.Gerar(.F., gcDir + "cru.txt"))
    L("isolado:  " + loT.Gerar(.T., gcDir + "iso_rel.txt"))
    L("SETs depois: POINT=[" + SET("POINT") + "] SEP=[" + SET("SEPARATOR") + "] BEH=" + TRANSFORM(SET("REPORTBEHAVIOR")))
CATCH TO loE
    L("ERRO " + loE.Message + " " + TRANSFORM(loE.LineNo))
ENDTRY
QUIT

PROCEDURE L(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcOut, .T.)
ENDPROC

DEFINE CLASS T328I AS sigrectcBO
    PROCEDURE Gerar(par_lIsolado, par_cArq)
        LOCAL loE2, lcR
        PRIVATE dDtInicial, dDtFinal
        dDtInicial = THIS.this_dDtInicial
        dDtFinal   = THIS.this_dDtFinal
        lcR = ""
        TRY
            IF THIS.PrepararDados()
                SELECT (THIS.this_cCursorDados)
                GO TOP
                IF par_lIsolado
                    THIS.ReportFormIsolado(gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio, "ASCII", par_cArq)
                ELSE
                    REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) TO FILE (par_cArq) ASCII NOCONSOLE
                ENDIF
                lcR = "asteriscos=" + TRANSFORM(OCCURS("*", FILETOSTR(par_cArq)))
            ENDIF
        CATCH TO loE2
            lcR = "ERRO " + TRANSFORM(loE2.ErrorNo) + " " + loE2.Message
        ENDTRY
        RETURN lcR
    ENDPROC
ENDDEFINE
