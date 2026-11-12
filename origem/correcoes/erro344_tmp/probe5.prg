SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gcDir = "C:\4c\origem\correcoes\erro344_tmp\"
gcOut = gcDir + "probe5.txt"
STRTOFILE("", gcOut)
LOCAL loE, loF, loPag, loVB
TRY
    DO ("C:\4c\projeto\app\start\config.prg")
    ConfigurarAmbiente()
    gb_4c_ModoTeste        = .T.
    gc_4c_ArquivoErroTeste = gcDir + "erros5.txt"
    STRTOFILE("", gc_4c_ArquivoErroTeste)
    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"

    L("=== FRX no projeto ===")
    L("SigReEq1.frx = " + TRANSFORM(FILE(gc_4c_CaminhoReports + "SigReEq1.frx")) + ;
      "   .frt = " + TRANSFORM(FILE(gc_4c_CaminhoReports + "SigReEq1.frt")))
    L("SigReEq2.frx = " + TRANSFORM(FILE(gc_4c_CaminhoReports + "SigReEq2.frx")) + ;
      "   .frt = " + TRANSFORM(FILE(gc_4c_CaminhoReports + "SigReEq2.frt")))

    GarantirClasse("FormSIGREEQR")
    loF = CREATEOBJECT("FormSIGREEQR")
    SET DATASESSION TO loF.DataSessionId
    loPag = loF.pgf_4c_Paginas.Page1
    loF.CmdSelTudoClick()
    loF.this_oRelatorio.this_cCdEmpresa = "001"
    loF.this_oRelatorio.this_nRfEstoque = 1
    loF.this_oRelatorio.this_nCalcusto  = 1
    L("")
    L("Atualizar = " + TRANSFORM(loF.this_oRelatorio.Atualizar()))
    L("csTempoGr = " + TRANSFORM(RECCOUNT("csTempoGr")) + "   CsTempoCp = " + TRANSFORM(RECCOUNT("CsTempoCp")))

    GarantirClasse("SigReEqTBO")
    loVB = CREATEOBJECT("SigReEqTBO")
    L("")
    L("=== SINTETICO (Opt = 2 -> SigReEq2 sobre csTempoGr) ===")
    loVB.DefinirOpcao(2)
    loVB.ReportFormIsolado(gc_4c_CaminhoReports + "SigReEq2.frx", "ASCII", gcDir + "rel_sintetico.txt")
    L("gerou = " + TRANSFORM(FILE(gcDir + "rel_sintetico.txt")))

    L("")
    L("=== ANALITICO (Opt = 1 -> SigReEq1 sobre CsTempoCp, ordem Imprimir) ===")
    SELECT CsTempoCp
    SET ORDER TO Imprimir
    GO TOP
    loVB.ReportFormIsolado(gc_4c_CaminhoReports + "SigReEq1.frx", "ASCII", gcDir + "rel_analitico.txt")
    L("gerou = " + TRANSFORM(FILE(gcDir + "rel_analitico.txt")))

    L("")
    L("erros: [" + FILETOSTR(gc_4c_ArquivoErroTeste) + "]")
CATCH TO loE
    L("ERRO " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Message + " | " + loE.Procedure)
ENDTRY
L("FIM")
QUIT
PROCEDURE L(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcOut, 1)
ENDPROC
