SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
SET DATE TO BRITISH
SET CENTURY ON
LOCAL loc_cOut, loE, loForm, loPg, loR, loc_i, loO, loc_j
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste, gnConnHandle, gc_378Png, gc_378Info
gb_4c_ModoTeste = .T.
gb_4c_ValidandoUI = .F.
gc_4c_ArquivoErroTeste = "C:\4c\refatoracao\automation\erro378\mensagens.txt"
STRTOFILE("", gc_4c_ArquivoErroTeste)
loc_cOut = ""
TRY
    CD "C:\4c\refatoracao\projeto\app\start"
    DO config.prg
    ConfigurarAmbiente()
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"
    GarantirClasse("Formsigreimp")
    loForm = CREATEOBJECT("Formsigreimp")
    loc_cOut = loc_cOut + "form=" + VARTYPE(loForm) + " W=" + TRANSFORM(loForm.Width) + " H=" + TRANSFORM(loForm.Height) + ;
        " pgfTop=" + TRANSFORM(loForm.pgf_4c_Paginas.Top) + " botoesTopo L=" + TRANSFORM(loForm.cmg_4c_Botoes.Left) + " fim=" + TRANSFORM(loForm.cmg_4c_Botoes.Left + loForm.cmg_4c_Botoes.Width) + CHR(13)+CHR(10)
    loPg = loForm.pgf_4c_Paginas.Page1
    FOR loc_i = 1 TO loPg.ControlCount
        loO = loPg.Controls(loc_i)
        loc_cOut = loc_cOut + "   " + PADR(loO.Name, 22) + " L=" + TRANSFORM(loO.Left) + " T=" + TRANSFORM(loO.Top) + " W=" + TRANSFORM(loO.Width) + " H=" + TRANSFORM(loO.Height) + ;
            " fimX=" + TRANSFORM(loO.Left + loO.Width) + " fimY=" + TRANSFORM(loO.Top + loO.Height) + IIF(PEMSTATUS(loO, "Caption", 5), " [" + loO.Caption + "]", "")
        DO CASE
        CASE loO.BaseClass = "Grid"
            loc_cOut = loc_cOut + " cols=" + TRANSFORM(loO.Column1.Width) + "/" + TRANSFORM(loO.Column2.Width) + "/" + TRANSFORM(loO.Column3.Width) + " rs=[" + loO.RecordSource + "] linhas=" + IIF(USED(loO.RecordSource), TRANSFORM(RECCOUNT(loO.RecordSource)), "-")
        CASE INLIST(loO.BaseClass, "Commandgroup", "Optiongroup")
            FOR loc_j = 1 TO loO.ButtonCount
                loc_cOut = loc_cOut + " | " + loO.Buttons(loc_j).Caption + "@" + TRANSFORM(loO.Buttons(loc_j).Left) + "," + TRANSFORM(loO.Buttons(loc_j).Top) + " " + TRANSFORM(loO.Buttons(loc_j).Width) + "x" + TRANSFORM(loO.Buttons(loc_j).Height) + ;
                    IIF(PEMSTATUS(loO.Buttons(loc_j), "Picture", 5) AND !EMPTY(loO.Buttons(loc_j).Picture), " pic=" + JUSTFNAME(loO.Buttons(loc_j).Picture) + "(" + TRANSFORM(FILE(loO.Buttons(loc_j).Picture)) + ")", "")
            ENDFOR
        ENDCASE
        loc_cOut = loc_cOut + CHR(13)+CHR(10)
    ENDFOR

    SET DATASESSION TO loForm.DataSessionId
    loR = CREATEOBJECT("T378BO")
    loR.this_cCursorOperacoesE = loForm.this_oRelatorio.this_cCursorOperacoesE
    loR.this_cCursorOperacoesS = loForm.this_oRelatorio.this_cCursorOperacoesS
    loForm.this_oRelatorio = loR

    *-- A: como a imagem (nada marcado)
    gc_378Info = "(nao renderizou)"
    loForm.BtnVisualizarClick()
    loc_cOut = loc_cOut + "A) nada marcado: " + gc_378Info + " msg=[" + loR.this_cMensagemErro + "]" + CHR(13)+CHR(10)

    *-- Marca Entradas 5,7 / Saidas 1,4
    UPDATE cursor_4c_OperacoesE SET SelImp = INLIST(Codigos, 5, 7)
    UPDATE cursor_4c_OperacoesS SET SelImp = INLIST(Codigos, 1, 4)

    loPg.opt_4c_OptTipos.Value = 1
    gc_378Png = "C:\4c\refatoracao\automation\erro378\B_detalhado.png"
    gc_378Info = "(nao renderizou)"
    loForm.BtnVisualizarClick()
    loc_cOut = loc_cOut + "B) Detalhado E(5,7) S(1,4): " + gc_378Info + " msg=[" + loR.this_cMensagemErro + "]" + CHR(13)+CHR(10)

    loPg.opt_4c_OptTipos.Value = 2
    gc_378Png = "C:\4c\refatoracao\automation\erro378\C_resumido.png"
    gc_378Info = "(nao renderizou)"
    loForm.BtnVisualizarClick()
    loc_cOut = loc_cOut + "C) Resumido: " + gc_378Info + " msg=[" + loR.this_cMensagemErro + "]" + CHR(13)+CHR(10)

    *-- D: mesmo tipo marcado como entrada e saida (4)
    UPDATE cursor_4c_OperacoesE SET SelImp = INLIST(Codigos, 4, 7)
    gc_378Info = "(nao renderizou)"
    loForm.BtnVisualizarClick()
    loc_cOut = loc_cOut + "D) tipo 4 nas duas: " + gc_378Info + " msg=[" + loR.this_cMensagemErro + "]" + CHR(13)+CHR(10)

    SET DATASESSION TO 1
    loForm.this_oRelatorio = .NULL.
    loForm.Release()
CATCH TO loE
    loc_cOut = loc_cOut + "ERRO: " + loE.Message + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Procedure + " | " + loE.LineContents + CHR(13)+CHR(10)
ENDTRY
STRTOFILE(loc_cOut, "C:\4c\refatoracao\automation\erro378\simulacao_out.txt")
QUIT

DEFINE CLASS T378BO AS sigreimpBO
    PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
        LOCAL loL, loc_c, loErrR
        loc_c = "frx=" + par_cRelatorioBase + " regs=" + TRANSFORM(RECCOUNT(par_cCursorDados)) + " cab=[" + ALLTRIM(crCabecalho.Subtitulo) + " | " + ALLTRIM(crCabecalho.Periodo) + "]"
        SELECT (par_cCursorDados)
        SCAN
            loc_c = loc_c + CHR(13)+CHR(10) + "     " + Movimento + IIF(TYPE("NFis") = "C", " " + NFis + " " + DTOC(TTOD(Emis)) + " " + ALLTRIM(CFis) + " " + ALLTRIM(CliFors) + " bx=[" + Baixas + "]", "") + ;
                " total=" + TRANSFORM(TotNotas) + " icms=" + TRANSFORM(ValICms) + " st=" + TRANSFORM(ICmsS) + " ipi=" + TRANSFORM(ValIpis)
        ENDSCAN
        GO TOP
        SET POINT TO "."
        SET SEPARATOR TO ","
        SET REPORTBEHAVIOR 90
        loL = CREATEOBJECT("ReportListener")
        loL.ListenerType = 3
        TRY
            REPORT FORM (gc_4c_CaminhoReports + par_cRelatorioBase + ".frx") OBJECT loL
            loL.OutputPage(1, gc_378Png, 104)
            loc_c = loc_c + CHR(13)+CHR(10) + "     paginas=" + TRANSFORM(loL.PageTotal)
        CATCH TO loErrR
            loc_c = loc_c + " ERRO REPORT: " + loErrR.Message
        ENDTRY
        gc_378Info = loc_c
        RETURN .T.
    ENDPROC
ENDDEFINE
