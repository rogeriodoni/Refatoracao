SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gcDir = "C:\4c\origem\correcoes\erro350_tmp\"
gcOut = gcDir + "probe5.txt"
STRTOFILE("", gcOut)
gc_4c_ArquivoErroTeste = gcDir + "erros5.txt"
LOCAL loE, loF, loB, loPg, lnI
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

    *-- so prepara os dados (sem o Show modal)
    loB.this_cMoeda     = "R"
    loB.this_cMoedaDesc = "REAIS"
    loB.this_dData      = DATE(2026, 11, 11)
    loB.this_dDtCotacao = DATE(2026, 11, 11)
    L("PrepararDados = " + TRANSFORM(loB.PrepararDados()))
    L("msg           = [" + loB.ObterMensagemErro() + "]")
    L("dbRelatorio   = " + TRANSFORM(IIF(USED("dbRelatorio"), RECCOUNT("dbRelatorio"), -1)) + " linhas")
    L("dbCabecalho   = " + TRANSFORM(IIF(USED("dbCabecalho"), RECCOUNT("dbCabecalho"), -1)))
    IF USED("dbRelatorio") AND RECCOUNT("dbRelatorio") > 0
        SELECT dbRelatorio
        GO TOP
        FOR lnI = 1 TO MIN(8, RECCOUNT("dbRelatorio"))
            L("   " + RTRIM(dbRelatorio.Detalhe))
            SKIP
        ENDFOR
        GO TOP
        L("")
        L("FRX SigReEun.frx = " + TRANSFORM(FILE(gc_4c_CaminhoReports + "SigReEun.frx")))
        loB.ReportFormIsolado(gc_4c_CaminhoReports + "SigReEun.frx", "ASCII", gcDir + "render.txt")
        L("render gerado    = " + TRANSFORM(FILE(gcDir + "render.txt")))
    ENDIF
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
