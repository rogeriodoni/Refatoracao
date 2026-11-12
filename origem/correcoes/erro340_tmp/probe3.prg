SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir
gcDir = "C:\4c\origem\correcoes\erro340_tmp\"
gcOut = gcDir + "probe3.txt"
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
    L("=== ESTADO APOS A CARGA DO BANCO (sem override) ===")
    L("this_cEmpresa  = [" + loBO.this_cEmpresa + "]")
    L("this_cTabela   = [" + loBO.this_cTabela + "]   <<< era vazio no erro340")
    L("this_cGrupo    = [" + loBO.this_cGrupo + "]")
    L("this_cConta    = [" + loBO.this_cConta + "]")
    L("ValidarFiltros = " + TRANSFORM(loBO.ValidarFiltros()) + "  <<< passava .F. no erro340")
    L("")
    L("=== Visualizar() com a ContaEsts ATUAL (1121017307) ===")
    L("PrepararDados  = " + TRANSFORM(loBO.PrepararDados()))
    L("msg            = [" + loBO.ObterMensagemErro() + "]")
    L("CsRelatorio    = " + TRANSFORM(IIF(USED("CsRelatorio"), RECCOUNT("CsRelatorio"), -1)) + " linhas")
    L("")
    L("=== o mesmo com ContaEsts = 1121001 (o que a tela de Parametros faria) ===")
    loBO.this_cConta = "1121001"
    L("PrepararDados  = " + TRANSFORM(loBO.PrepararDados()))
    L("msg            = [" + loBO.ObterMensagemErro() + "]")
    L("CsRelatorio    = " + TRANSFORM(IIF(USED("CsRelatorio"), RECCOUNT("CsRelatorio"), -1)) + " linhas")
    IF USED("CsRelatorio") AND RECCOUNT("CsRelatorio") > 0
        SELECT CsRelatorio
        GO TOP
        L("1a linha       : [" + CsRelatorio.CBars + "] [" + ALLTRIM(CsRelatorio.DPros) + "] " + TRANSFORM(CsRelatorio.Units))
        GO TOP
        loBO.ReportFormIsolado(gc_4c_CaminhoReports + "SigReEqe", "ASCII", gcDir + "render_final.txt")
        L("FRX renderizou = " + TRANSFORM(FILE(gcDir + "render_final.txt")))
    ENDIF
CATCH TO loE
    L("ERRO " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Message + " | " + loE.Procedure)
ENDTRY
L("FIM")
QUIT
PROCEDURE L(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcOut, 1)
ENDPROC
