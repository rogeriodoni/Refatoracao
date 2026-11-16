SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
SET DATE TO BRITISH
SET CENTURY ON
LOCAL loc_cOut, loForm, loE, loR, loPg, loc_i
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste, gnConnHandle, gc_375Png, gc_375Info
gb_4c_ModoTeste = .T.
gb_4c_ValidandoUI = .F.
gc_4c_ArquivoErroTeste = "C:\4c\refatoracao\automation\erro375\mensagens.txt"
STRTOFILE("", gc_4c_ArquivoErroTeste)
loc_cOut = ""
TRY
    CD "C:\4c\refatoracao\projeto\app\start"
    DO config.prg
    ConfigurarAmbiente()
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"
    GarantirClasse("FormSigReIfp")
    loForm = CREATEOBJECT("FormSigReIfp")
    loPg = loForm.pgf_4c_Paginas.Page1
    loc_cOut = loc_cOut + "form=" + VARTYPE(loForm) + " W=" + TRANSFORM(loForm.Width) + " H=" + TRANSFORM(loForm.Height) + CHR(13)+CHR(10) + Geo(loPg)
    SET DATASESSION TO loForm.DataSessionId
    loR = CREATEOBJECT("T375BO")
    loForm.this_oRelatorio = loR

    loPg.txt_4c__dt_inicial.Value = {^2000-01-01}
    loPg.txt_4c__dt_final.Value   = {^2026-11-16}
    FOR loc_i = 1 TO 7
        loPg.obj_4c_NivImprs.Value = loc_i
        loc_cOut = loc_cOut + Rodar(loForm, loR, "N" + TRANSFORM(loc_i), "Tipo " + TRANSFORM(loc_i))
    ENDFOR

    *-- Tipo 7 com os filtros
    loPg.obj_4c_NivImprs.Value = 7
    loPg.txt_4c__tpmat.Value = "LIMALHA OURO"
    loPg.txt_4c__ifor.Value  = "F000000029"
    loPg.txt_4c_CdGrupo.Value = "11101"
    loc_cOut = loc_cOut + Rodar(loForm, loR, "N7_filtros", "Tipo 7 LIMALHA OURO/F000000029/11101")
    loPg.txt_4c__tpmat.Value = ""
    loPg.txt_4c__ifor.Value  = ""
    loPg.txt_4c_CdGrupo.Value = ""

    *-- Tipo 0 (spinner aceita 0)
    loPg.obj_4c_NivImprs.Value = 0
    loc_cOut = loc_cOut + Rodar(loForm, loR, "N0", "Tipo 0")

    *-- Periodo sem lancamentos
    loPg.obj_4c_NivImprs.Value = 1
    loPg.txt_4c__dt_inicial.Value = {^2000-01-01}
    loPg.txt_4c__dt_final.Value   = {^2000-12-31}
    loc_cOut = loc_cOut + Rodar(loForm, loR, "Vazio", "Periodo 2000 (sem lancamentos)")

    SET DATASESSION TO 1
    loForm.this_oRelatorio = .NULL.
    loForm.Release()
CATCH TO loE
    loc_cOut = loc_cOut + "ERRO: " + loE.Message + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Procedure + " | " + loE.LineContents + CHR(13)+CHR(10)
ENDTRY
STRTOFILE(loc_cOut, "C:\4c\refatoracao\automation\erro375\simulacao_out.txt")
QUIT

FUNCTION Rodar(par_oForm, par_oR, par_cPng, par_cTit)
    gc_375Png = "C:\4c\refatoracao\automation\erro375\" + par_cPng + ".png"
    gc_375Info = "(nao renderizou)"
    par_oR.this_cMensagemErro = ""
    par_oForm.BtnVisualizarClick()
    RETURN par_cTit + ": " + gc_375Info + IIF(EMPTY(par_oR.this_cMensagemErro), "", " msg=[" + par_oR.this_cMensagemErro + "]") + CHR(13)+CHR(10)
ENDFUNC

FUNCTION Geo(par_oPg)
    LOCAL loc_c, loc_i, loc_o
    loc_c = ""
    FOR loc_i = 1 TO par_oPg.ControlCount
        loc_o = par_oPg.Controls(loc_i)
        loc_c = loc_c + "   " + PADR(loc_o.Name, 26) + " L=" + TRANSFORM(loc_o.Left) + " T=" + TRANSFORM(loc_o.Top) + ;
            " W=" + TRANSFORM(loc_o.Width) + " H=" + TRANSFORM(loc_o.Height) + ;
            IIF(PEMSTATUS(loc_o, "Caption", 5), " [" + loc_o.Caption + "]", "") + ;
            IIF(PEMSTATUS(loc_o, "Enabled", 5), " en=" + TRANSFORM(loc_o.Enabled), "") + CHR(13)+CHR(10)
    ENDFOR
    RETURN loc_c
ENDFUNC

DEFINE CLASS T375BO AS SigReIfpBO
    PROCEDURE ExecutarReport(par_cFrx, par_cModo)
        LOCAL loL, loc_c
        loc_c = JUSTSTEM(par_cFrx) + " regs=" + TRANSFORM(RECCOUNT("TmpRelat")) + " cab=[" + ALLTRIM(dbCabecalho.NomeEmpresa) + " | " + ALLTRIM(dbCabecalho.SubTitulo) + " | " + ALLTRIM(dbCabecalho.Periodos) + "]"
        SELECT TmpRelat
        SET ORDER TO
        SCAN
            loc_c = loc_c + CHR(13)+CHR(10) + "     " + ;
                IIF(EMPTY(Operacs), "", PADR(Operacs, 26) + TRANSFORM(Totas, "999,999.99")) + ;
                IIF(EMPTY(Grupos) AND EMPTY(Contas), "", "grp=" + ALLTRIM(Grupos) + " " + ALLTRIM(Dgrupos) + " cta=" + ALLTRIM(Contas) + " " + ALLTRIM(Rclis)) + ;
                IIF(falhags + Recupgs + Trabs = 0, "", " trab=" + TRANSFORM(Trabs) + " falha=" + TRANSFORM(falhags) + " recup=" + TRANSFORM(Recupgs) + " perda=" + TRANSFORM(Perdags) + ;
                    " %f=" + TRANSFORM(Falhaps) + " %r=" + TRANSFORM(Recupps) + " %p=" + TRANSFORM(Perdaps)) + ;
                IIF(EMPTY(TpOps), "", " tp=" + ALLTRIM(TpOps) + " bruto=" + TRANSFORM(Pesbs) + " ccob=" + TRANSFORM(recCcobs) + " scob=" + TRANSFORM(RecScobs) + " %=" + TRANSFORM(recpesos) + IIF(EMPTY(Datas), "", " " + DTOC(Datas)))
        ENDSCAN
        GO TOP
        SET POINT TO "."
        SET SEPARATOR TO ","
        SET REPORTBEHAVIOR 90
        loL = CREATEOBJECT("ReportListener")
        loL.ListenerType = 3
        REPORT FORM (par_cFrx) OBJECT loL
        loL.OutputPage(1, gc_375Png, 104)
        gc_375Info = loc_c + CHR(13)+CHR(10) + "     paginas=" + TRANSFORM(loL.PageTotal)
    ENDPROC
ENDDEFINE
