SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
SET DATE TO BRITISH
SET CENTURY ON
LOCAL loc_cOut, loForm, loE, loBO, loc_oPg, loc_nI, loc_oA, loL
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste = .T.
gb_4c_ValidandoUI = .F.
gc_4c_ArquivoErroTeste = "C:\4c\refatoracao\automation\erro366\mensagens.txt"
loc_cOut = ""
TRY
    CD "C:\4c\refatoracao\projeto\app\start"
    DO config.prg
    ConfigurarAmbiente()
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"
    GarantirClasse("FormSIGREHCP")
    loForm = CREATEOBJECT("FormSIGREHCP")
    loc_cOut = loc_cOut + "form=" + VARTYPE(loForm) + " calccustos=" + TRANSFORM(loForm.this_oRelatorio.this_nCalcCustos) + CHR(13)+CHR(10)
    loc_oPg = loForm.pgf_4c_Paginas.Page1
    FOR loc_nI = 1 TO loc_oPg.ControlCount
        loc_oA = loc_oPg.Controls(loc_nI)
        loc_cOut = loc_cOut + PADR(loc_oA.Name, 20) + " T=" + PADL(loc_oA.Top,4) + " L=" + PADL(loc_oA.Left,4) + " W=" + PADL(loc_oA.Width,4) + " vis=" + TRANSFORM(loc_oA.Visible) + CHR(13)+CHR(10)
    ENDFOR
    SET DATASESSION TO loForm.DataSessionId
    loBO = loForm.this_oRelatorio
    loBO.this_dDtInicial = {^2023-11-01}
    loBO.this_dDtFinal   = {^2024-03-31}
    loBO.this_nTipoImps  = 1
    loBO.this_cCPros = "036"
    loc_cOut = loc_cOut + "== produto 036: PrepararDados=" + TRANSFORM(loBO.PrepararDados()) + " regs=" + TRANSFORM(RECCOUNT("crImpressao")) + " frx=" + JUSTFNAME(loBO.ObterCaminhoRelatorio()) + CHR(13)+CHR(10)
    SELECT crImpressao
    SCAN
        loc_cOut = loc_cOut + DTOC(Datas) + " " + PADR(Dopes,20) + STR(Numes,6) + " " + Opers + " qtd=" + TRANSFORM(Qtds) + " saldo=" + TRANSFORM(Sqtds) + " unit=" + TRANSFORM(Units) + " medio=" + TRANSFORM(UnitMeds) + " icms=" + TRANSFORM(AliqIcms) + " NF=" + NFis + CHR(13)+CHR(10)
    ENDSCAN
    loc_cOut = loc_cOut + "cab: " + ALLTRIM(crCabecalho.Titulo) + " | " + ALLTRIM(crCabecalho.SubTit) + " | " + ALLTRIM(crCabecalho.Empresa) + CHR(13)+CHR(10)
    loR = CREATEOBJECT("T366BO")
    loc_cOut = loc_cOut + "render=" + TRANSFORM(loR.Renderizar(loBO.ObterCaminhoRelatorio(), "C:\4c\refatoracao\automation\erro366\rel_036.png")) + CHR(13)+CHR(10)
    loR = .NULL.
    *-- todos os produtos
    loBO.this_cCPros = ""
    loc_cOut = loc_cOut + "== todos: PrepararDados=" + TRANSFORM(loBO.PrepararDados()) + " regs=" + TRANSFORM(RECCOUNT("crImpressao")) + CHR(13)+CHR(10)
    *-- Modelo 3
    loBO.this_nTipoImps = 2
    loc_cOut = loc_cOut + "== modelo 3: PrepararDados=" + TRANSFORM(loBO.PrepararDados()) + " regs=" + TRANSFORM(RECCOUNT("crImpressao")) + " frx=" + JUSTFNAME(loBO.ObterCaminhoRelatorio()) + " cab=" + ALLTRIM(crCabecalho.Titulo) + CHR(13)+CHR(10)
    SET DATASESSION TO 1
    loForm.Release()
CATCH TO loE
    loc_cOut = loc_cOut + "ERRO: " + loE.Message + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Procedure + " | " + loE.LineContents + CHR(13)+CHR(10)
ENDTRY
STRTOFILE(loc_cOut, "C:\4c\refatoracao\automation\erro366\simulacao_out.txt")
QUIT

DEFINE CLASS T366BO AS SIGREHCPBO
    PROCEDURE Renderizar(par_cFrx, par_cPng)
        LOCAL loL
        SELECT crImpressao
        GO TOP
        SET POINT TO ","
        SET SEPARATOR TO "."
        SET REPORTBEHAVIOR 90
        loL = CREATEOBJECT("ReportListener")
        loL.ListenerType = 3
        REPORT FORM (par_cFrx) OBJECT loL
        loL.OutputPage(1, par_cPng, 104)
        RETURN loL.PageTotal
    ENDPROC
ENDDEFINE
