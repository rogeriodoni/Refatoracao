SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir
gcDir = "C:\4c\refatoracao\origem\correcoes\erro332_tmp\"
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
    SET PROCEDURE TO (gcDir + "SigReDdpBO.prg") ADDITIVE
    SET DATE TO BRITISH
    SET CENTURY ON
    loT = CREATEOBJECT("T332")
    L("Tipo em branco (imagem): " + loT.So("", DATE(2026,11,9)))
    L("Tipo BALANCO TESTE 09/11/2026: " + loT.So("BALANCO TESTE", DATE(2026,11,9)))
    L("Tipo BALANCO TESTE 03/11/2026: " + loT.So("BALANCO TESTE", DATE(2026,11,3)))
    loT.Mostrar("BALANCO TESTE", DATE(2026,11,9))
CATCH TO loE
    L("ERRO " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Message + " | " + loE.Procedure)
ENDTRY

PROCEDURE L(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcOut, .T.)
ENDPROC

DEFINE CLASS T332 AS SigReDdpBO
    PROCEDURE So(par_cNome, par_dData)
        LOCAL lcN
        THIS.this_cNome    = par_cNome
        THIS.this_dDtFinal = par_dData
        IF !THIS.PrepararDados()
            RETURN "SEM DADOS: " + THIS.this_cMensagemErro
        ENDIF
        lcN = "SdInicial=" + TRANSFORM(csCabecalho.SdInicial) + " | "
        SELECT TmpResult
        SET ORDER TO
        GO TOP
        SCAN
            lcN = lcN + TRANSFORM(Ordem) + "/" + Operas + "/" + ALLTRIM(IIF(EMPTY(TpOps), Nome, TpOps)) + "=" + TRANSFORM(Qtds) + "  "
        ENDSCAN
        RETURN lcN
    ENDPROC
    PROCEDURE Mostrar(par_cNome, par_dData)
        LOCAL lnT
        THIS.this_cNome    = par_cNome
        THIS.this_dDtFinal = par_dData
        IF THIS.PrepararDados()
            SELECT TmpResult
            GO TOP
            SET POINT TO "."
            SET SEPARATOR TO ","
            SET REPORTBEHAVIOR 80
            REPORT FORM (gc_4c_CaminhoReports + "SigReDdp") PREVIEW NOWAIT NOCONSOLE
            IF WEXIST("Report Designer")
                ZOOM WINDOW "Report Designer" MAX
            ENDIF
            L("PRONTO")
            lnT = SECONDS()
            DO WHILE SECONDS() - lnT < 25
                DOEVENTS
            ENDDO
        ELSE
            L("ERRO preparar: " + THIS.this_cMensagemErro)
        ENDIF
    ENDPROC
ENDDEFINE
