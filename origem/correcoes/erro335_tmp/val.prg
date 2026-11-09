SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir
gcDir = "C:\4c\refatoracao\origem\correcoes\erro335_tmp\"
gcOut = gcDir + "calib.txt"
STRTOFILE("", gcOut)
LOCAL loE, loForm
TRY
    _SCREEN.Visible = .T.
    _SCREEN.WindowState = 2
    DO ("C:\4c\refatoracao\projeto\app\start\config.prg")
    ConfigurarAmbiente()
    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"
    gc_4c_UsuarioLogado = "4CONTROL"
    DO CriarObjectConnLegado IN ("C:\4c\refatoracao\projeto\app\start\main.prg") WITH ObterStringConexao()
    SET PROCEDURE TO (gcDir + "relatoriobase.prg"), (gcDir + "sigredocBO.prg"), (gcDir + "Formsigredoc.prg") ADDITIVE
    loForm = CREATEOBJECT("Formsigredoc")
    L("form=" + VARTYPE(loForm) + " classlib=[" + SET("CLASSLIB") + "]")
    loForm.Visible = .T.
    loForm.pgf_4c_Paginas.Page1.txt_4c_Dopes.Value = "V"
    L("PRONTO")
    loForm.ValidarOperacao()
    L("depois: Operacao=[" + loForm.pgf_4c_Paginas.Page1.txt_4c_Dopes.Value + "] classlib=[" + SET("CLASSLIB") + "]")
CATCH TO loE
    L("ERRO " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Message + " | " + loE.Procedure)
ENDTRY

PROCEDURE L(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcOut, .T.)
ENDPROC
