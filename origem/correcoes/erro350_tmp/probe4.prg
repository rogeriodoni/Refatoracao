SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gcDir = "C:\4c\origem\correcoes\erro350_tmp\"
gcOut = gcDir + "probe4.txt"
STRTOFILE("", gcOut)
gc_4c_ArquivoErroTeste = gcDir + "erros4.txt"
LOCAL loE, loF, loB, loPg
TRY
    DO ("C:\4c\projeto\app\start\config.prg")
    ConfigurarAmbiente()
    gb_4c_ModoTeste = .T.
    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"
    GarantirClasse("Formsigreeun")
    loF = CREATEOBJECT("Formsigreeun")
    SET DATASESSION TO loF.DataSessionId
    loB  = loF.this_oRelatorio
    loPg = loF.pgf_4c_Paginas.Page1
    loPg.txt_4c_CdMoeda.Value   = "R"
    loPg.txt_4c_DsMoeda.Value   = "REAIS"
    loPg.txt_4c_Data.Value      = DATE(2026, 11, 11)
    loPg.txt_4c_DtCotacao.Value = DATE(2026, 11, 11)

    SET COVERAGE TO (gcDir + "cobertura.txt")
    loF.BtnVisualizarClick()
    SET COVERAGE TO

    L("msg = [" + loB.ObterMensagemErro() + "]")
CATCH TO loE
    SET COVERAGE TO
    L("ERRO GERAL " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Message)
ENDTRY
L("FIM")
QUIT
PROCEDURE L(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcOut, 1)
ENDPROC
