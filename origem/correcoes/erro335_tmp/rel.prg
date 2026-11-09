SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir
gcDir = "C:\4c\refatoracao\origem\correcoes\erro335_tmp\"
gcOut = gcDir + "calib.txt"
STRTOFILE("", gcOut)
LOCAL loE, loT, lnT
TRY
    _SCREEN.Visible = .T.
    _SCREEN.WindowState = 2
    DO ("C:\4c\refatoracao\projeto\app\start\config.prg")
    ConfigurarAmbiente()
    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"
    SET PROCEDURE TO (gcDir + "relatoriobase.prg"), (gcDir + "sigredocBO.prg") ADDITIVE
    SET DATE TO BRITISH
    SET CENTURY ON
    loT = CREATEOBJECT("sigredocBO")
    loT.CarregarEmpresas()
    UPDATE (loT.this_cCursorEmpresas) SET Marca = 1 WHERE ALLTRIM(cEmps) == "001"
    loT.this_cDopes     = "VENDA"
    loT.this_nOperacaoI = 201
    loT.this_nOperacaoF = 205
    loT.this_nReimp     = 0
    loT.this_nAgrupa    = 2
    IF loT.PrepararDados()
        L("TmpRelat=" + TRANSFORM(RECCOUNT("TmpRelat")) + " docs=" + TRANSFORM(RECCOUNT("TprMvCab")))
        SELECT TmpRelat
        GO TOP
        SET POINT TO "."
        SET SEPARATOR TO ","
        SET REPORTBEHAVIOR 80
        REPORT FORM (loT.this_cArquivoFRX) PREVIEW NOWAIT NOCONSOLE
        IF WEXIST("Report Designer")
            ZOOM WINDOW "Report Designer" MAX
        ENDIF
        L("PRONTO")
        lnT = SECONDS()
        DO WHILE SECONDS() - lnT < 25
            DOEVENTS
        ENDDO
    ELSE
        L("FALHOU [" + loT.this_cMensagemErro + "] alias=" + ALIAS() + " empresas=" + loT.this_cCursorEmpresas + " used=" + TRANSFORM(USED(loT.this_cCursorEmpresas)))
    ENDIF
CATCH TO loE
    L("ERRO " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Message + " | " + loE.Procedure)
ENDTRY

PROCEDURE L(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcOut, .T.)
ENDPROC

FUNCTION MsgErro(par_cMsg, par_cTit)
    L("MsgErro: [" + TRANSFORM(par_cMsg) + "] " + TRANSFORM(par_cTit))
ENDFUNC
FUNCTION MsgAviso(par_cMsg, par_cTit)
    L("MsgAviso: [" + TRANSFORM(par_cMsg) + "]")
ENDFUNC
