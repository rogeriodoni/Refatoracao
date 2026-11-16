SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
SET DATE TO BRITISH
SET CENTURY ON
LOCAL loc_cOut, loForm, loE, loR
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste, gnConnHandle, gc_374Png, gc_374Info
gb_4c_ModoTeste = .T.
gb_4c_ValidandoUI = .F.
gc_4c_ArquivoErroTeste = "C:\4c\refatoracao\automation\erro374\mensagens.txt"
STRTOFILE("", gc_4c_ArquivoErroTeste)
loc_cOut = ""
TRY
    CD "C:\4c\refatoracao\projeto\app\start"
    DO config.prg
    ConfigurarAmbiente()
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"
    GarantirClasse("FormSigReIdt")

    *-- A: como na imagem - aberto pelo menu, sem titulo
    loForm = CREATEOBJECT("FormSigReIdt", "", "", "", "", 0, "")
    loc_cOut = loc_cOut + "A) menu sem parametros: form=" + VARTYPE(loForm) + " caption=[" + loForm.Caption + "] W=" + TRANSFORM(loForm.Width) + " H=" + TRANSFORM(loForm.Height) + CHR(13)+CHR(10)
    loc_cOut = loc_cOut + Geo(loForm)
    loR = CREATEOBJECT("T374BO")
    loForm.this_oRelatorio = loR
    gc_374Info = "(nao renderizou)"
    loForm.BtnVisualizarClick()
    loc_cOut = loc_cOut + "   visualizar: " + gc_374Info + " msgErro=[" + loR.this_cMensagemErro + "]" + CHR(13)+CHR(10)
    loc_cOut = loc_cOut + "   aviso=[" + LerLog() + "]" + CHR(13)+CHR(10)
    loForm.this_oRelatorio = .NULL.
    loForm.Release()

    *-- B..E: chamado como a tela de Titulos chama (iDoc)
    loForm = CREATEOBJECT("FormSigReIdt", "", "001", "CONTAS A PAGAR", "T374/01", 374001, "")
    loc_cOut = loc_cOut + "titulo: caption=[" + loForm.Caption + "]" + CHR(13)+CHR(10)
    SET DATASESSION TO loForm.DataSessionId
    loR = CREATEOBJECT("T374BO")
    loForm.this_oRelatorio = loR

    loc_cOut = loc_cOut + Rodar(loForm, 2, 3, "B_autorizacao", "B) Autorizacao de Gasto / Nenhum (padrao da imagem)")
    loc_cOut = loc_cOut + Rodar(loForm, 1, 3, "C_titulo", "C) Titulo / Nenhum")
    loc_cOut = loc_cOut + Rodar(loForm, 1, 2, "D_titulo_agrupada", "D) Titulo / Agrupada")
    loc_cOut = loc_cOut + Rodar(loForm, 1, 1, "E_titulo_sim", "E) Titulo / Recorrencia Sim")

    SET DATASESSION TO 1
    loForm.this_oRelatorio = .NULL.
    loForm.Release()
CATCH TO loE
    loc_cOut = loc_cOut + "ERRO: " + loE.Message + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Procedure + " | " + loE.LineContents + CHR(13)+CHR(10)
ENDTRY
IF .F.
    loc_cOut = loc_cOut + "--- mensagens ---" + CHR(13)+CHR(10) + FILETOSTR(gc_4c_ArquivoErroTeste)
ENDIF
STRTOFILE(loc_cOut, "C:\4c\refatoracao\automation\erro374\simulacao_out.txt")
QUIT

FUNCTION Rodar(par_oForm, par_nTipo, par_nAgrupa, par_cPng, par_cTit)
    gc_374Png = "C:\4c\refatoracao\automation\erro374\" + par_cPng + ".png"
    gc_374Info = "(nao renderizou)"
    par_oForm.obj_4c_OptTipo.Value = par_nTipo
    par_oForm.obj_4c_OptAgrupa.Value = par_nAgrupa
    par_oForm.BtnVisualizarClick()
    RETURN par_cTit + ": " + gc_374Info + CHR(13)+CHR(10)
ENDFUNC

FUNCTION LerLog()
    LOCAL loc_nH, loc_c
    loc_c = "(sem leitura)"
    loc_nH = FOPEN(gc_4c_ArquivoErroTeste, 0)
    IF loc_nH >= 0
        loc_c = CHRTRAN(FREAD(loc_nH, 4000), CHR(13)+CHR(10), "  ")
        FCLOSE(loc_nH)
    ENDIF
    RETURN loc_c
ENDFUNC

FUNCTION Geo(par_oForm)
    LOCAL loc_c, loc_i, loc_o, loc_j
    loc_c = ""
    FOR loc_i = 1 TO par_oForm.ControlCount
        loc_o = par_oForm.Controls(loc_i)
        IF INLIST(loc_o.BaseClass, "Label", "Optiongroup")
            loc_c = loc_c + "   " + PADR(loc_o.Name, 24) + " L=" + TRANSFORM(loc_o.Left) + " T=" + TRANSFORM(loc_o.Top) + " W=" + TRANSFORM(loc_o.Width) + " H=" + TRANSFORM(loc_o.Height)
            IF loc_o.BaseClass = "Optiongroup"
                FOR loc_j = 1 TO loc_o.ButtonCount
                    loc_c = loc_c + " | " + loc_o.Buttons(loc_j).Caption + "@" + TRANSFORM(loc_o.Buttons(loc_j).Left)
                ENDFOR
                loc_c = loc_c + " val=" + TRANSFORM(loc_o.Value)
            ELSE
                loc_c = loc_c + " [" + loc_o.Caption + "]"
            ENDIF
            loc_c = loc_c + CHR(13)+CHR(10)
        ENDIF
    ENDFOR
    RETURN loc_c
ENDFUNC

DEFINE CLASS T374BO AS SigReIdtBO
    PROCEDURE ReportFormIsolado(par_cFRX, par_cModo, par_cArquivo, par_lDecimalVirgula)
        LOCAL loL, loc_c
        loc_c = "frx=" + JUSTSTEM(par_cFRX) + " alias=" + ALIAS() + " regs=" + TRANSFORM(RECCOUNT("crDBImp")) + " ContaTran=[" + pc_4c_ContaTran + "]"
        SELECT crDBImp
        SCAN
            loc_c = loc_c + CHR(13)+CHR(10) + "     " + ALLTRIM(Titulo) + " venc=" + DTOC(dtVencs) + " port=" + ALLTRIM(Grupo) + "/" + ALLTRIM(Conta) + " [" + ALLTRIM(dConta) + "]" + ;
                " cc=" + ALLTRIM(sGrupos) + "/" + ALLTRIM(sContas) + " [" + ALLTRIM(sdConta) + "]" + ;
                " Valor=" + TRANSFORM(Valor) + " Valorc=" + TRANSFORM(Valorc) + " obsd=[" + ALLTRIM(Obss) + "] hist=[" + ALLTRIM(Hists) + "]" + ;
                IIF(EMPTY(Recors), "", CHR(13)+CHR(10) + "       recors=" + STRTRAN(ALLTRIM(Recors), CHR(13)+CHR(10), " || "))
        ENDSCAN
        GO TOP
        SET POINT TO "."
        SET SEPARATOR TO ","
        SET REPORTBEHAVIOR 90
        loL = CREATEOBJECT("ReportListener")
        loL.ListenerType = 3
        REPORT FORM (par_cFRX) OBJECT loL
        loL.OutputPage(1, gc_374Png, 104)
        gc_374Info = loc_c + CHR(13)+CHR(10) + "     paginas=" + TRANSFORM(loL.PageTotal)
    ENDPROC
ENDDEFINE
