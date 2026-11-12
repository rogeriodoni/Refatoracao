*==============================================================================
* PROBE Erro340 - Posicao de Etiquetas (Formsigreeqe / sigreeqeBO)
* Simulacao headless do clique em "Visualizar".
* NAO grava nada no banco: so le, e usa override em memoria para simular
* a configuracao ausente.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)

PUBLIC gcOut, gcDir
gcDir = "C:\4c\origem\correcoes\erro340_tmp\"
gcOut = gcDir + "probe.txt"
STRTOFILE("", gcOut)

LOCAL loE, loBO, loForm, lnR

TRY
    DO ("C:\4c\projeto\app\start\config.prg")
    ConfigurarAmbiente()
    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    L("conn=" + TRANSFORM(gnConnHandle))
    go_4c_Sistema.cCodEmpresa = "001"

    *-------------------------------------------------------------------
    L("")
    L("=== 1. FORM abre? ===")
    GarantirClasse("Formsigreeqe")
    loForm = CREATEOBJECT("Formsigreeqe")
    L("form        = " + VARTYPE(loForm))
    IF VARTYPE(loForm) = "O"
        L("caption     = [" + loForm.Caption + "]")
    ENDIF

    *-------------------------------------------------------------------
    L("")
    L("=== 2. ESTADO DO BO NO INIT (causa da mensagem) ===")
    GarantirClasse("sigreeqeBO")
    loBO = CREATEOBJECT("sigreeqeBO")
    L("this_cEmpresa    = [" + TRANSFORM(loBO.this_cEmpresa) + "]")
    L("this_cDesEmpresa = [" + TRANSFORM(loBO.this_cDesEmpresa) + "]")
    L("this_cGrupo      = [" + TRANSFORM(loBO.this_cGrupo) + "]")
    L("this_cConta      = [" + TRANSFORM(loBO.this_cConta) + "]")
    L("this_cTabela     = [" + TRANSFORM(loBO.this_cTabela) + "]   <<< vazio = mensagem do Erro340")

    L("ValidarFiltros() = " + TRANSFORM(loBO.ValidarFiltros()) + ;
      "  msg=[" + loBO.ObterMensagemErro() + "]")

    *-------------------------------------------------------------------
    L("")
    L("=== 3. POR QUE this_cTabela ESTA VAZIO (consulta do legado) ===")
    lnR = SQLEXEC(gnConnHandle, ;
        "SELECT a.Emps, a.CodTabDs, b.Descrs FROM SigOpTde a, SigOpTdz b" + ;
        " WHERE a.Emps = '001' AND a.Padraos = 1 AND b.Codigos = a.CodTabDs", "cTd")
    L("SQLEXEC=" + TRANSFORM(lnR) + "  linhas=" + TRANSFORM(IIF(USED("cTd"), RECCOUNT("cTd"), -1)))
    IF USED("cTd")
        USE IN cTd
    ENDIF
    lnR = SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS n FROM SigOpTde WHERE Emps='001'", "cA")
    L("SigOpTde p/ empresa 001         : " + TRANSFORM(IIF(USED("cA"), cA.n, -1)))
    IF USED("cA")
        USE IN cA
    ENDIF
    lnR = SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS n FROM SigOpTde WHERE Padraos=1", "cB")
    L("SigOpTde com Padraos=1 (qualquer): " + TRANSFORM(IIF(USED("cB"), cB.n, -1)))
    IF USED("cB")
        USE IN cB
    ENDIF
    lnR = SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS n FROM SigOpTdz", "cC")
    L("SigOpTdz (tabelas de desconto)   : " + TRANSFORM(IIF(USED("cC"), cC.n, -1)))
    IF USED("cC")
        USE IN cC
    ENDIF

    *-------------------------------------------------------------------
    L("")
    L("=== 4. SIMULACAO: com a tabela de desconto preenchida (em memoria) ===")
    L("    override this_cTabela = 'FEITIO VD' (unica linha de SigOpTdz)")
    loBO.this_cTabela = "FEITIO VD"
    L("ValidarFiltros() = " + TRANSFORM(loBO.ValidarFiltros()) + ;
      "  msg=[" + loBO.ObterMensagemErro() + "]")
    L("PrepararDados()  = " + TRANSFORM(loBO.PrepararDados()) + ;
      "  msg=[" + loBO.ObterMensagemErro() + "]")
    L("CsRelatorio      = " + TRANSFORM(IIF(USED("CsRelatorio"), RECCOUNT("CsRelatorio"), -1)) + " linhas")

    *-------------------------------------------------------------------
    L("")
    L("=== 5. SIMULACAO: sem o filtro grupo/conta do SigCdPam ===")
    L("    SigCdPam.ContaEsts=[" + loBO.this_cConta + "] x SigOpEtq.Contas reais")
    lnR = SQLEXEC(gnConnHandle, ;
        "SELECT DISTINCT Grupos, Contas FROM SigOpEtq WHERE EmpOs='001'", "cE")
    IF USED("cE")
        SELECT cE
        SCAN
            L("    SigOpEtq: Grupos=[" + cE.Grupos + "] Contas=[" + cE.Contas + "]")
        ENDSCAN
        USE IN cE
    ENDIF
    loBO.this_cGrupo = ""
    loBO.this_cConta = ""
    L("PrepararDados()  = " + TRANSFORM(loBO.PrepararDados()) + ;
      "  msg=[" + loBO.ObterMensagemErro() + "]")
    L("CsRelatorio      = " + TRANSFORM(IIF(USED("CsRelatorio"), RECCOUNT("CsRelatorio"), -1)) + " linhas")
    IF USED("CsRelatorio") AND RECCOUNT("CsRelatorio") > 0
        SELECT CsRelatorio
        GO TOP
        LOCAL lnI
        FOR lnI = 1 TO MIN(5, RECCOUNT("CsRelatorio"))
            L("    [" + CsRelatorio.CBars + "] [" + CsRelatorio.DPros + "] " + ;
              TRANSFORM(CsRelatorio.Units) + " ST=" + CsRelatorio.SitTribs + ;
              " Aliq=" + TRANSFORM(CsRelatorio.Aliqs))
            SKIP
        ENDFOR
        GO TOP
    ENDIF

    *-------------------------------------------------------------------
    L("")
    L("=== 6. FRX: arquivo existe e renderiza? ===")
    L("gc_4c_CaminhoReports = [" + gc_4c_CaminhoReports + "]")
    L("SigReEqe.frx existe  = " + TRANSFORM(FILE(gc_4c_CaminhoReports + "SigReEqe.frx")))
    L("SigReEqe.frt existe  = " + TRANSFORM(FILE(gc_4c_CaminhoReports + "SigReEqe.frt")))
    IF FILE(gc_4c_CaminhoReports + "SigReEqe.frx") AND USED("CsRelatorio") AND RECCOUNT("CsRelatorio") > 0
        SELECT CsRelatorio
        GO TOP
        loBO.ReportFormIsolado(gc_4c_CaminhoReports + "SigReEqe", "ASCII", gcDir + "render.txt")
        L("render.txt gerado    = " + TRANSFORM(FILE(gcDir + "render.txt")))
    ENDIF

CATCH TO loE
    L("ERRO " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + ;
      " " + loE.Message + " | " + loE.Procedure)
ENDTRY

L("")
L("FIM")
QUIT

PROCEDURE L(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcOut, 1)
ENDPROC
