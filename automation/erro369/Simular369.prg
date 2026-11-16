SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
SET DATE TO BRITISH
SET CENTURY ON
LOCAL loc_cOut, loForm, loE, loR
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste, gnConnHandle, gc_369Png
gb_4c_ModoTeste = .T.
gb_4c_ValidandoUI = .F.
gc_4c_ArquivoErroTeste = "C:\4c\refatoracao\automation\erro369\mensagens.txt"
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
    loc_cOut = loc_cOut + "form=" + VARTYPE(loForm) + " W=" + TRANSFORM(loForm.Width) + " H=" + TRANSFORM(loForm.Height) + CHR(13)+CHR(10)
    SET DATASESSION TO loForm.DataSessionId
    loR = CREATEOBJECT("T369BO")
    loForm.this_oRelatorio = loR

    *-- Cenario A: Referencia com Codigo vazio (o da imagem)
    loForm.txt_4c_DtInicial.Value = {^2000-01-01}
    loForm.txt_4c_DtFinal.Value   = {^2026-11-13}
    gc_369Png = "C:\4c\refatoracao\automation\erro369\A_vazio.png"
    loForm.BtnVisualizarClick()
    loc_cOut = loc_cOut + "A) Ref vazio: msgErro=[" + loR.this_cMensagemErro + "] renders=" + TRANSFORM(loR.nRenders) + CHR(13)+CHR(10)

    *-- Cenario B: Referencia, grupo 11210 / estoque 1121001 / produto 210
    loForm.txt_4c_CdGrEstoque.Value = "11210"
    loForm.ValidarCdGrEstoque()
    loForm.txt_4c_CdEstoque.Value = "1121001"
    loForm.ValidarCdEstoque()
    loForm.txt_4c_CdCodigo.Value = "210"
    loForm.ValidarCdCodigo()
    gc_369Png = "C:\4c\refatoracao\automation\erro369\B_ref210.png"
    loForm.BtnVisualizarClick()
    loc_cOut = loc_cOut + "B) Ref 210 [" + ALLTRIM(loForm.txt_4c_DsGrEstoque.Value) + "/" + ALLTRIM(loForm.txt_4c_DsEstoque.Value) + "/" + ALLTRIM(loForm.txt_4c_DsCodigo.Value) + "]: renders=" + TRANSFORM(loR.nRenders) + " " + loR.cInfo + CHR(13)+CHR(10)

    *-- Cenario C: Geral por Referencia
    loForm.opt_4c_NrTipo.Value = 3
    loForm.TipoAlterado()
    gc_369Png = "C:\4c\refatoracao\automation\erro369\C_geral.png"
    loForm.BtnVisualizarClick()
    loc_cOut = loc_cOut + "C) Geral: renders=" + TRANSFORM(loR.nRenders) + " " + loR.cInfo + CHR(13)+CHR(10)

    SET DATASESSION TO 1
    loForm.this_oRelatorio = .NULL.
    loForm.Release()
CATCH TO loE
    loc_cOut = loc_cOut + "ERRO: " + loE.Message + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Procedure + " | " + loE.LineContents + CHR(13)+CHR(10)
ENDTRY
IF FILE(gc_4c_ArquivoErroTeste)
    loc_cOut = loc_cOut + "--- mensagens ---" + CHR(13)+CHR(10) + FILETOSTR(gc_4c_ArquivoErroTeste)
ENDIF
STRTOFILE(loc_cOut, "C:\4c\refatoracao\automation\erro369\simulacao_out.txt")
QUIT

DEFINE CLASS T369BO AS sigrehprBO
    nRenders = 0
    cInfo = ""
    PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
        LOCAL loL, loc_cAlias
        loc_cAlias = ALIAS()
        THIS.cInfo = "frx=" + par_cRelatorioBase + " alias=" + loc_cAlias + " regs=" + TRANSFORM(RECCOUNT(par_cCursorDados)) + ;
            " peso=" + TRANSFORM(CsCabecalho.ImpPeso) + " prod=[" + ALLTRIM(IIF(TYPE("CsCabecalho.Produto") = "C", CsCabecalho.Produto, "")) + "]"
        IF RECCOUNT(par_cCursorDados) = 0
            RETURN .F.
        ENDIF
        SET POINT TO "."
        SET SEPARATOR TO ","
        SET REPORTBEHAVIOR 90
        loL = CREATEOBJECT("ReportListener")
        loL.ListenerType = 3
        REPORT FORM (gc_4c_CaminhoReports + par_cRelatorioBase + ".frx") OBJECT loL
        loL.OutputPage(1, gc_369Png, 104)
        THIS.cInfo = THIS.cInfo + " paginas=" + TRANSFORM(loL.PageTotal)
        THIS.nRenders = THIS.nRenders + 1
        RETURN .T.
    ENDPROC
ENDDEFINE
