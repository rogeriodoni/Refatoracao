SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gcDir = "C:\4c\origem\correcoes\erro350_tmp\"
gcOut = gcDir + "probe.txt"
STRTOFILE("", gcOut)
LOCAL loE, loF, loB
TRY
    DO ("C:\4c\projeto\app\start\config.prg")
    ConfigurarAmbiente()
    gb_4c_ModoTeste        = .T.
    gc_4c_ArquivoErroTeste = gcDir + "erros.txt"
    STRTOFILE("", gc_4c_ArquivoErroTeste)
    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"

    GarantirClasse("Formsigreeun")
    loF = CREATEOBJECT("Formsigreeun")
    L("form = " + VARTYPE(loF))
    IF VARTYPE(loF) = "O"
        L("Caption = [" + loF.Caption + "]")
        SET DATASESSION TO loF.DataSessionId
        loB = loF.this_oRelatorio
        L("BO = " + VARTYPE(loB))
        L("")
XXX
        TRY
            L("retorno = " + TRANSFORM(loB.PrepararDados()))
            L("msg     = [" + loB.ObterMensagemErro() + "]")
        CATCH TO loE
            L("EXCECAO " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + ;
              " " + loE.Message + " | proc=" + loE.Procedure)
        ENDTRY
        L("")
        L("cursores abertos relevantes:")
        L("   this_cCursorDados = [" + loB.this_cCursorDados + "] USED=" + ;
          TRANSFORM(IIF(EMPTY(loB.this_cCursorDados), .F., USED(loB.this_cCursorDados))))
    ENDIF
    L("")
    L("erros capturados: [" + FILETOSTR(gc_4c_ArquivoErroTeste) + "]")
CATCH TO loE
    L("ERRO GERAL " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Message + " | " + loE.Procedure)
ENDTRY
L("FIM")
QUIT
PROCEDURE L(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcOut, 1)
ENDPROC
