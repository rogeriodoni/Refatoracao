SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir
gcDir = "C:\4c\refatoracao\origem\correcoes\erro335_tmp\"
gcOut = gcDir + "calib.txt"
STRTOFILE("", gcOut)
LOCAL loE, loTxt
TRY
    _SCREEN.Visible = .T.
    _SCREEN.WindowState = 2
    DO ("C:\4c\refatoracao\projeto\app\start\config.prg")
    ConfigurarAmbiente()
    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"
    DO CriarObjectConnLegado IN ("C:\4c\refatoracao\projeto\app\start\main.prg") WITH ObterStringConexao()
    L("ObjectConn=" + IIF(PEMSTATUS(go_4c_Sistema, "ObjectConn", 5), VARTYPE(go_4c_Sistema.ObjectConn), "sem prop"))
    L("classlib antes=[" + SET("CLASSLIB") + "]")
    SET CLASSLIB TO (gc_4c_CaminhoFramework + "framework.vcx") ADDITIVE
    L("classlib com framework=[" + SET("CLASSLIB") + "]")
    loTxt = CREATEOBJECT("TextBox")
    loTxt.Value = "V"
    L("PRONTO")
    fAcessoMovmto("4CONTROL", "V", loTxt)
    L("voltou valor=[" + TRANSFORM(loTxt.Value) + "]")
CATCH TO loE
    L("ERRO " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Message + " | " + loE.Procedure)
ENDTRY

PROCEDURE L(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcOut, .T.)
ENDPROC
