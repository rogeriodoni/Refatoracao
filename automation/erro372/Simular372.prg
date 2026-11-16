SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
SET DATE TO BRITISH
SET CENTURY ON
LOCAL loc_cOut, loForm, loE, loR, loc_cCenario
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste, gnConnHandle, gc_372Png
gb_4c_ModoTeste = .T.
gb_4c_ValidandoUI = .F.
gc_4c_ArquivoErroTeste = "C:\4c\refatoracao\automation\erro372\mensagens.txt"
ERASE (gc_4c_ArquivoErroTeste)
loc_cOut = ""
TRY
    CD "C:\4c\refatoracao\projeto\app\start"
    DO config.prg
    ConfigurarAmbiente()
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"
    GarantirClasse("Formsigrehtc")
    loForm = CREATEOBJECT("Formsigrehtc")
    loc_cOut = loc_cOut + "form=" + VARTYPE(loForm) + " W=" + TRANSFORM(loForm.Width) + " H=" + TRANSFORM(loForm.Height) + CHR(13)+CHR(10)
    loc_cOut = loc_cOut + Geo(loForm) + CHR(13)+CHR(10)
    SET DATASESSION TO loForm.DataSessionId
    loR = CREATEOBJECT("T372BO")
    loForm.this_oRelatorio = loR

    *-- Grupo: valida contra SigCdGcr (codigo existente, nao abre picker)
    loForm.txt_4c_CdGrEstoque.Value = "11102"
    loForm.ValidarCdGrEstoque()
    loc_cOut = loc_cOut + "Grupo 11102 -> [" + ALLTRIM(loForm.txt_4c_DsGrEstoque.Value) + "]" + CHR(13)+CHR(10)
    loForm.txt_4c_CdContas.Value = "1110200001"
    loForm.ValidarCdContas()
    loc_cOut = loc_cOut + "Conta 1110200001 -> [" + ALLTRIM(loForm.txt_4c_DsContas.Value) + "]" + CHR(13)+CHR(10)
    loForm.txt_4c_CdGrEstoque.Value = ""
    loForm.ValidarCdGrEstoque()
    loForm.txt_4c_CdContas.Value = ""
    loForm.ValidarCdContas()

    loForm.txt_4c__dt_inicial.Value = {^2000-01-01}
    loForm.txt_4c__dt_final.Value   = {^2026-11-16}

    loc_cOut = loc_cOut + Rodar(loForm, loR, "A_imagem", "A) imagem (Emitido/Validos/Mov/Copia)")

    loForm.obj_4c_Op_Cancelado.Value = 2
    loc_cOut = loc_cOut + Rodar(loForm, loR, "B_cancelados", "B) Cancelados")

    loForm.obj_4c_Op_Cancelado.Value = 3
    loc_cOut = loc_cOut + Rodar(loForm, loR, "C_todos", "C) Todos")

    loForm.obj_4c_Op_Cancelado.Value = 1
    loForm.obj_4c_Op_Ordem.Value = 3
    loc_cOut = loc_cOut + Rodar(loForm, loR, "D_conta", "D) Validos ordem por Conta")

    loForm.obj_4c_Op_Ordem.Value = 1
    loForm.obj_4c_OptDatas.Value = 2
    loForm.txt_4c__dt_inicial.Value = {^2026-11-01}
    loForm.txt_4c__dt_final.Value   = {^2026-11-30}
    loc_cOut = loc_cOut + Rodar(loForm, loR, "E_venc", "E) Vencimento 01/11 a 30/11/2026")

    loForm.obj_4c_OptDatas.Value = 1
    loForm.txt_4c__dt_inicial.Value = {^2000-01-01}
    loForm.txt_4c__dt_final.Value   = {^2026-11-16}
    loForm.txt_4c_CdGrEstoque.Value = "11101"
    loForm.ValidarCdGrEstoque()
    loc_cOut = loc_cOut + Rodar(loForm, loR, "F_grupo11101", "F) Grupo 11101")

    SET DATASESSION TO 1
    loForm.this_oRelatorio = .NULL.
    loForm.Release()
CATCH TO loE
    loc_cOut = loc_cOut + "ERRO: " + loE.Message + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Procedure + " | " + loE.LineContents + CHR(13)+CHR(10)
ENDTRY
IF FILE(gc_4c_ArquivoErroTeste)
    loc_cOut = loc_cOut + "--- mensagens ---" + CHR(13)+CHR(10) + FILETOSTR(gc_4c_ArquivoErroTeste)
ENDIF
STRTOFILE(loc_cOut, "C:\4c\refatoracao\automation\erro372\simulacao_out.txt")
QUIT

FUNCTION Rodar(par_oForm, par_oR, par_cPng, par_cTit)
    LOCAL loc_c
    gc_372Png = "C:\4c\refatoracao\automation\erro372\" + par_cPng + ".png"
    par_oR.cInfo = "(nao renderizou)"
    par_oR.cLinhas = ""
    par_oForm.BtnVisualizarClick()
    loc_c = par_cTit + ": " + par_oR.cInfo + CHR(13)+CHR(10) + par_oR.cLinhas
    RETURN loc_c
ENDFUNC

FUNCTION Geo(par_oForm)
    LOCAL loc_c, loc_i, loc_o
    loc_c = ""
    FOR loc_i = 1 TO par_oForm.ControlCount
        loc_o = par_oForm.Controls(loc_i)
        IF INLIST(loc_o.BaseClass, "Label", "Textbox", "Optiongroup")
            loc_c = loc_c + "  " + PADR(loc_o.Name, 26) + " L=" + TRANSFORM(loc_o.Left) + " T=" + TRANSFORM(loc_o.Top) + ;
                " W=" + TRANSFORM(loc_o.Width) + " H=" + TRANSFORM(loc_o.Height) + CHR(13)+CHR(10)
        ENDIF
    ENDFOR
    RETURN loc_c
ENDFUNC

DEFINE CLASS T372BO AS sigrehtcBO
    cInfo = ""
    cLinhas = ""
    PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
        LOCAL loL, loc_nTot
        loc_nTot = 0
        THIS.cLinhas = ""
        SELECT Resultado
        SCAN
            THIS.cLinhas = THIS.cLinhas + "   cop " + STR(NCopias, 6) + " " + DTOC(Datas) + " v" + DTOC(Vencs) + " " + Grupos + "/" + Contas + ;
                " " + ALLTRIM(Cheques) + TRANSFORM(Valors, "999,999.99") + " item" + TRANSFORM(Valos, "999,999.99") + ;
                " canc=" + TRANSFORM(Cancelas) + " fav=[" + ALLTRIM(Favos) + "] hist=[" + ALLTRIM(Hists) + "] TotCon=" + TRANSFORM(TotCon) + CHR(13)+CHR(10)
        ENDSCAN
        GO TOP
        THIS.cInfo = "regs=" + TRANSFORM(RECCOUNT("Resultado")) + " | " + ALLTRIM(Titulo1s) + " | " + ALLTRIM(Periodos) + " | " + ALLTRIM(Ordem)
        SET POINT TO "."
        SET SEPARATOR TO ","
        SET REPORTBEHAVIOR 90
        loL = CREATEOBJECT("ReportListener")
        loL.ListenerType = 3
        REPORT FORM (gc_4c_CaminhoReports + par_cRelatorioBase + ".frx") OBJECT loL
        loL.OutputPage(1, gc_372Png, 104)
        THIS.cInfo = THIS.cInfo + " | paginas=" + TRANSFORM(loL.PageTotal)
        RETURN .T.
    ENDPROC
ENDDEFINE
