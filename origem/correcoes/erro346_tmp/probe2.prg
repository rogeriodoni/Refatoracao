SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gcDir = "C:\4c\origem\correcoes\erro346_tmp\"
gcOut = gcDir + "probe2.txt"
STRTOFILE("", gcOut)
LOCAL loE, loF, loB
TRY
    DO ("C:\4c\projeto\app\start\config.prg")
    ConfigurarAmbiente()
    gb_4c_ModoTeste        = .T.
    gc_4c_ArquivoErroTeste = gcDir + "erros2.txt"
    STRTOFILE("", gc_4c_ArquivoErroTeste)
    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"
    GarantirClasse("FormSigReEsp")
    loF = CREATEOBJECT("FormSigReEsp")
    SET DATASESSION TO loF.DataSessionId
    loB = loF.this_oRelatorio
    WITH loB
        .this_dDtInicial = DATE(2000,1,1)
        .this_dDtFinal   = DATE(2026,11,11)
        .this_nPeriodo   = 1
        .this_nCdTpOpe   = 7
        .this_nFiltro    = 3
        .this_nAnaSin    = 2
        .this_lTpOpe     = .F.
    ENDWITH
    L("PrepararDados = " + TRANSFORM(loB.PrepararDados()))
    L("csRelatorio   = " + TRANSFORM(IIF(USED("csRelatorio"), RECCOUNT("csRelatorio"), -1)))
    L("FRX SigReEsp  = " + TRANSFORM(FILE(gc_4c_CaminhoReports + "SigReEsp.frx")))
    L("FRX SigReEs2  = " + TRANSFORM(FILE(gc_4c_CaminhoReports + "SigReEs2.frx")))
    IF USED("csRelatorio") AND RECCOUNT("csRelatorio") > 0
        SELECT csRelatorio
        GO TOP
        loB.ReportFormIsolado(gc_4c_CaminhoReports + "SigReEsp.frx", "ASCII", gcDir + "render.txt")
        L("render SigReEsp = " + TRANSFORM(FILE(gcDir + "render.txt")))
    ENDIF
    L("erros: [" + FILETOSTR(gc_4c_ArquivoErroTeste) + "]")
CATCH TO loE
    L("ERRO " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Message + " | " + loE.Procedure)
ENDTRY
L("FIM")
QUIT
PROCEDURE L(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcOut, 1)
ENDPROC
