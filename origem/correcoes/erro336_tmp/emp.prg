SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir
gcDir = "C:\4c\refatoracao\origem\correcoes\erro336_tmp\"
gcOut = gcDir + "calib.txt"
STRTOFILE("", gcOut)
LOCAL loE, loForm, lnT, lcC
TRY
    _SCREEN.Visible = .T.
    _SCREEN.WindowState = 2
    DO ("C:\4c\refatoracao\projeto\app\start\config.prg")
    ConfigurarAmbiente()
    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"
    SET PROCEDURE TO (gcDir + "relatoriobase.prg"), (gcDir + "sigredocBO.prg"), (gcDir + "Formsigredoc.prg") ADDITIVE
    loForm = CREATEOBJECT("Formsigredoc")
    loForm.Visible = .T.
    SET DATASESSION TO loForm.DataSessionId
    lcC = loForm.this_oRelatorio.this_cCursorEmpresas
    L("icones: sel=" + TRANSFORM(FILE(loForm.pgf_4c_Paginas.Page1.cmd_4c_SelecionarTodas.Picture)) + " desm=" + TRANSFORM(FILE(loForm.pgf_4c_Paginas.Page1.cmd_4c_DesmarcarTodas.Picture)))
    L("inicio: " + Marcas(lcC))
    loForm.TgEmps1KeyPress(13, 0)
    L("checkbox (clique na 001): " + Marcas(lcC))
    loForm.TgEmps1KeyPress(13, 0)
    L("checkbox de novo: " + Marcas(lcC))
    loForm.CmdSelecionarTodasClick()
    L("botao Selecionar: " + Marcas(lcC))
    loForm.CmdDesmarcarTodasClick()
    L("botao Desmarcar: " + Marcas(lcC))
    loForm.CmdSelecionarTodasClick()
    L("PRONTO")
    lnT = SECONDS()
    DO WHILE SECONDS() - lnT < 25
        DOEVENTS
    ENDDO
CATCH TO loE
    L("ERRO " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Message + " | " + loE.Procedure)
ENDTRY

FUNCTION Marcas(par_c)
    LOCAL lcR
    lcR = ""
    SELECT (par_c)
    SCAN
        lcR = lcR + ALLTRIM(cEmps) + "=" + TRANSFORM(Marca) + " "
    ENDSCAN
    GO TOP
    RETURN lcR
ENDFUNC

PROCEDURE L(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcOut, .T.)
ENDPROC
