SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir
gcDir = "C:\4c\refatoracao\origem\correcoes\erro333_tmp\"
gcOut = gcDir + "calib.txt"
STRTOFILE("", gcOut)
LOCAL loE, loT
TRY
    _SCREEN.Visible = .T.
    _SCREEN.WindowState = 2
    DO ("C:\4c\refatoracao\projeto\app\start\config.prg")
    ConfigurarAmbiente()
    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"
    SET PROCEDURE TO (gcDir + "SIGREDESBO.prg") ADDITIVE
    SET DATE TO BRITISH
    SET CENTURY ON
    loT = CREATEOBJECT("T333")
    loT.InicializarFiltros()
    loT.this_nOpcao = 2
    loT.Mostrar()
CATCH TO loE
    L("ERRO " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Message + " | " + loE.Procedure)
ENDTRY

PROCEDURE L(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcOut, .T.)
ENDPROC

DEFINE CLASS T333 AS SIGREDESBO
    PROCEDURE Mostrar()
        LOCAL lnT, lcN, lcFrx
        L("visao=" + TRANSFORM(THIS.this_nOpcao) + " periodo " + DTOC(THIS.this_dDtInicial) + " a " + DTOC(THIS.this_dDtFinal))
        IF !THIS.PrepararDados()
            L("SEM DADOS: " + THIS.this_cMensagemErro)
            RETURN
        ENDIF
        lcN = ""
        SELECT csRelatorio
        SCAN
            IF THIS.this_nOpcao = 1
                lcN = lcN + ALLTRIM(NVL(cpros, "")) + "(totas=" + TRANSFORM(NVL(totas, 0)) + " desct%=" + TRANSFORM(NVL(desct, 0)) + " realiz=" + TRANSFORM(NVL(realizado, 0)) + " cota=" + TRANSFORM(NVL(valcota, 0)) + ") "
            ELSE
                lcN = lcN + "[tipo " + tipo + " " + ALLTRIM(emps) + "/" + ALLTRIM(repre) + " cota=" + TRANSFORM(valcota) + " realiz=" + TRANSFORM(realizadoV) + " saldo=" + TRANSFORM(saldoV) + "] "
            ENDIF
        ENDSCAN
        L("linhas=" + TRANSFORM(RECCOUNT("csRelatorio")) + " " + lcN)
        lcFrx = IIF(THIS.this_nOpcao = 1, "SigReDes", "SigReDe1")
        SELECT csRelatorio
        GO TOP
        SET POINT TO "."
        SET SEPARATOR TO ","
        SET REPORTBEHAVIOR 80
        REPORT FORM (gc_4c_CaminhoReports + lcFrx) PREVIEW NOWAIT NOCONSOLE
        IF WEXIST("Report Designer")
            ZOOM WINDOW "Report Designer" MAX
        ENDIF
        L("PRONTO " + lcFrx)
        lnT = SECONDS()
        DO WHILE SECONDS() - lnT < 25
            DOEVENTS
        ENDDO
    ENDPROC
ENDDEFINE
