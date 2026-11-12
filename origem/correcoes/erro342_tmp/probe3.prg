SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gcDir = "C:\4c\origem\correcoes\erro342_tmp\"
gcOut = gcDir + "probe3.txt"
STRTOFILE("", gcOut)
LOCAL loE, loBO
TRY
    DO ("C:\4c\projeto\app\start\config.prg")
    ConfigurarAmbiente()
    *-- suprime dialogos modais: senao um MsgErro do CATCH trava o headless
    gb_4c_ModoTeste        = .T.
    gc_4c_ArquivoErroTeste = gcDir + "erros.txt"
    STRTOFILE("", gc_4c_ArquivoErroTeste)
    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"

    GarantirClasse("SIGREEQRBO")
    loBO = CREATEOBJECT("SIGREEQRBO")
    loBO.InicializarSelecao()
    SELECT Selecao
    REPLACE ALL marcas WITH 1
    GO TOP

    loBO.this_cCdEmpresa = "001"
    loBO.this_nCalcusto  = 1
    loBO.this_nRfEstoque = 2
    loBO.this_dDataSaldo = DATE(2024, 3, 14)
    L("=== MODO 2: Estoque Retroativo em 14/03/2024 ===")
    L("PrepararDados = " + TRANSFORM(loBO.PrepararDados()))
    L("msg           = [" + loBO.ObterMensagemErro() + "]")
    L("csTempoGr     = " + TRANSFORM(IIF(USED("csTempoGr"), RECCOUNT("csTempoGr"), -1)))
    L("CsTempoCp     = " + TRANSFORM(IIF(USED("CsTempoCp"), RECCOUNT("CsTempoCp"), -1)))
    L("")
    L("erros capturados:")
    IF FILE(gc_4c_ArquivoErroTeste)
        L(FILETOSTR(gc_4c_ArquivoErroTeste))
    ENDIF
CATCH TO loE
    L("ERRO " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Message + " | " + loE.Procedure)
ENDTRY
L("FIM")
QUIT
PROCEDURE L(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcOut, 1)
ENDPROC
