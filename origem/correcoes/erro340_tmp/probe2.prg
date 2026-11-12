SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir
gcDir = "C:\4c\origem\correcoes\erro340_tmp\"
gcOut = gcDir + "probe2.txt"
STRTOFILE("", gcOut)
LOCAL loE, loBO
TRY
    DO ("C:\4c\projeto\app\start\config.prg")
    ConfigurarAmbiente()
    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"
    GarantirClasse("sigreeqeBO")
    loBO = CREATEOBJECT("sigreeqeBO")
    loBO.this_cTabela = "FEITIO VD"
    loBO.this_cGrupo  = ""
    loBO.this_cConta  = ""
    L("PrepararDados = " + TRANSFORM(loBO.PrepararDados()))
    L("CsRelatorio   = " + TRANSFORM(RECCOUNT("CsRelatorio")))
    SELECT CsRelatorio
    GO TOP
    L("estrutura CBars: tipo=" + TYPE("CsRelatorio.CBars") + " len=" + TRANSFORM(LEN(CsRelatorio.CBars)))
    L("valor topo     : [" + CsRelatorio.CBars + "]")

    *-- Teste A: como esta (STR right-aligned)
    SELECT CsRelatorio
    GO TOP
    loBO.ReportFormIsolado(gc_4c_CaminhoReports + "SigReEqe", "ASCII", gcDir + "render_A.txt")

    *-- Teste B: mesmo cursor com CBars sem padding a esquerda
    SELECT CsRelatorio
    REPLACE ALL CBars WITH PADR(ALLTRIM(CBars), 14)
    GO TOP
    L("valor topo B   : [" + CsRelatorio.CBars + "]")
    loBO.ReportFormIsolado(gc_4c_CaminhoReports + "SigReEqe", "ASCII", gcDir + "render_B.txt")
CATCH TO loE
    L("ERRO " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Message + " | " + loE.Procedure)
ENDTRY
L("FIM")
QUIT
PROCEDURE L(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcOut, 1)
ENDPROC
