SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
SET DATE TO BRITISH
SET CENTURY ON
LOCAL loc_cOut, loForm, loE, loR
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste, gnConnHandle, gc_371Png
gb_4c_ModoTeste = .T.
gb_4c_ValidandoUI = .F.
gc_4c_ArquivoErroTeste = "C:\4c\refatoracao\automation\erro371\mensagens.txt"
ERASE (gc_4c_ArquivoErroTeste)
loc_cOut = ""
TRY
    CD "C:\4c\refatoracao\projeto\app\start"
    DO config.prg
    ConfigurarAmbiente()
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"
    GarantirClasse("Formsigrehpr")
    loForm = CREATEOBJECT("Formsigrehpr")
    loc_cOut = loc_cOut + "form=" + VARTYPE(loForm) + CHR(13)+CHR(10)
    SET DATASESSION TO loForm.DataSessionId
    loR = CREATEOBJECT("T371BO")
    loForm.this_oRelatorio = loR

    *-- A: EXATAMENTE a imagem (Referencia, grupo 11210, estoque/codigo vazios)
    loForm.txt_4c_DtInicial.Value = {^2000-01-01}
    loForm.txt_4c_DtFinal.Value   = {^2026-11-16}
    loForm.txt_4c_CdGrEstoque.Value = "11210"
    loForm.ValidarCdGrEstoque()
    gc_371Png = "C:\4c\refatoracao\automation\erro371\A_imagem.png"
    loForm.BtnVisualizarClick()
    loc_cOut = loc_cOut + "A) imagem [" + ALLTRIM(loForm.txt_4c_DsGrEstoque.Value) + "] emp=" + ALLTRIM(loForm.txt_4c_CdEmpresa.Value) + ;
        " medio=" + TRANSFORM(loForm.opt_4c_ImpMedio.Value) + " obs=" + TRANSFORM(loForm.opt_4c_OptObs.Value) + ": renders=" + TRANSFORM(loR.nRenders) + CHR(13)+CHR(10)

    *-- B: + estoque 1121001 + codigo T371 (custo medio Sim, obs Nao)
    loForm.txt_4c_CdEstoque.Value = "1121001"
    loForm.ValidarCdEstoque()
    loForm.txt_4c_CdCodigo.Value = "T371"
    loForm.ValidarCdCodigo()
    gc_371Png = "C:\4c\refatoracao\automation\erro371\B_T371_obsNao.png"
    loForm.BtnVisualizarClick()
    loc_cOut = loc_cOut + "B) T371 [" + ALLTRIM(loForm.txt_4c_DsEstoque.Value) + "/" + ALLTRIM(loForm.txt_4c_DsCodigo.Value) + "]: renders=" + TRANSFORM(loR.nRenders) + " " + loR.cInfo + CHR(13)+CHR(10) + loR.cLinhas

    *-- C: Observacao = Sim
    loForm.opt_4c_OptObs.Value = 1
    gc_371Png = "C:\4c\refatoracao\automation\erro371\C_T371_obsSim.png"
    loForm.BtnVisualizarClick()
    loc_cOut = loc_cOut + "C) obs Sim: renders=" + TRANSFORM(loR.nRenders) + " " + loR.cInfo + CHR(13)+CHR(10) + loR.cLinhas

    *-- D: Observacao = C/Documento
    loForm.opt_4c_OptObs.Value = 3
    gc_371Png = "C:\4c\refatoracao\automation\erro371\D_T371_obsDoc.png"
    loForm.BtnVisualizarClick()
    loc_cOut = loc_cOut + "D) obs C/Doc: renders=" + TRANSFORM(loR.nRenders) + " " + loR.cInfo + CHR(13)+CHR(10) + loR.cLinhas
    loForm.opt_4c_OptObs.Value = 2

    *-- E: Codigo de Barras 99371003
    loForm.opt_4c_NrTipo.Value = 2
    loForm.TipoAlterado()
    loForm.txt_4c_CdBarra.Value = 99371003
    loForm.ValidarCdBarra()
    gc_371Png = "C:\4c\refatoracao\automation\erro371\E_barra.png"
    loForm.BtnVisualizarClick()
    loc_cOut = loc_cOut + "E) barra [" + ALLTRIM(loForm.txt_4c_CdCodigo.Value) + "]: renders=" + TRANSFORM(loR.nRenders) + " " + loR.cInfo + CHR(13)+CHR(10) + loR.cLinhas

    SET DATASESSION TO 1
    loForm.this_oRelatorio = .NULL.
    loForm.Release()
CATCH TO loE
    loc_cOut = loc_cOut + "ERRO: " + loE.Message + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Procedure + " | " + loE.LineContents + CHR(13)+CHR(10)
ENDTRY
IF FILE(gc_4c_ArquivoErroTeste)
    loc_cOut = loc_cOut + "--- mensagens ---" + CHR(13)+CHR(10) + FILETOSTR(gc_4c_ArquivoErroTeste)
ENDIF
STRTOFILE(loc_cOut, "C:\4c\refatoracao\automation\erro371\simulacao_out.txt")
QUIT

DEFINE CLASS T371BO AS sigrehprBO
    nRenders = 0
    cInfo = ""
    cLinhas = ""
    PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
        LOCAL loL, loc_cAlias
        loc_cAlias = ALIAS()
        THIS.cInfo = "frx=" + par_cRelatorioBase + " alias=" + loc_cAlias + " regs=" + TRANSFORM(RECCOUNT(par_cCursorDados)) + ;
            " peso=" + TRANSFORM(CsCabecalho.ImpPeso) + " medio=" + TRANSFORM(CsCabecalho.ImpMedio) + " obsCab=" + TRANSFORM(CsCabecalho.Obs) + ;
            " prod=[" + ALLTRIM(IIF(TYPE("CsCabecalho.Produto") = "C", CsCabecalho.Produto, "")) + "]"
        THIS.cLinhas = ""
        SELECT (par_cCursorDados)
        SCAN
            THIS.cLinhas = THIS.cLinhas + "   " + DTOC(TTOD(datas)) + " " + opers + TRANSFORM(qtds, "9999.999") + " saldo" + TRANSFORM(sqtds, "9999.999") + ;
                " medio" + TRANSFORM(unitmeds, "99999.99") + " " + ALLTRIM(dopes) + STR(numes, 6) + ;
                " orig=" + ALLTRIM(grupoos) + "/" + ALLTRIM(contaos) + " dest=" + ALLTRIM(grupods) + "/" + ALLTRIM(contads) + ;
                " obs=[" + ALLTRIM(NVL(obs, "")) + "]" + CHR(13)+CHR(10)
        ENDSCAN
        SELECT (loc_cAlias)
        GO TOP
        IF RECCOUNT(par_cCursorDados) = 0
            RETURN .F.
        ENDIF
        SET POINT TO "."
        SET SEPARATOR TO ","
        SET REPORTBEHAVIOR 90
        loL = CREATEOBJECT("ReportListener")
        loL.ListenerType = 3
        REPORT FORM (gc_4c_CaminhoReports + par_cRelatorioBase + ".frx") OBJECT loL
        loL.OutputPage(1, gc_371Png, 104)
        THIS.cInfo = THIS.cInfo + " paginas=" + TRANSFORM(loL.PageTotal)
        THIS.nRenders = THIS.nRenders + 1
        RETURN .T.
    ENDPROC
ENDDEFINE
