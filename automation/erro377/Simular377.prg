SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
SET DATE TO BRITISH
SET CENTURY ON
LOCAL loc_cOut, loE
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste, gnConnHandle, gc_377Png, gc_377Info
gb_4c_ModoTeste = .T.
gb_4c_ValidandoUI = .F.
gc_4c_ArquivoErroTeste = "C:\4c\refatoracao\automation\erro377\mensagens.txt"
STRTOFILE("", gc_4c_ArquivoErroTeste)
loc_cOut = ""
TRY
    CD "C:\4c\refatoracao\projeto\app\start"
    DO config.prg
    ConfigurarAmbiente()
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"
    GarantirClasse("Formsigreimc")

    *-- A: pelo menu, sem empresa/serie, nota 1 a 99999 (a imagem)
    loc_cOut = loc_cOut + Cenario(.F., "", "", {}, {}, "", "1", "99999", "A_menu", "A) menu, nota 1 a 99999 (a imagem)", .T.)
    *-- B: como a Carta de Correcao chama - uma nota so
    loc_cOut = loc_cOut + Cenario(.T., "001", "1", {^2024-03-01}, {^2024-03-31}, "", "000032", "000032", "B_nf32", "B) 001/1 NF 000032", .F.)
    *-- C: faixa 000032 a 000034 (000034 sem correcao)
    loc_cOut = loc_cOut + Cenario(.T., "001", "1", {^2024-03-01}, {^2024-03-31}, "", "000032", "000034", "C_faixa", "C) 001/1 NF 000032 a 000034", .F.)
    *-- D: digitando sem zeros a esquerda (1 a 99999) - comparacao de texto
    loc_cOut = loc_cOut + Cenario(.T., "001", "1", {^2024-03-01}, {^2024-03-31}, "", "1", "99999", "D_semzeros", "D) 001/1 nota 1 a 99999", .F.)
CATCH TO loE
    loc_cOut = loc_cOut + "ERRO: " + loE.Message + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Procedure + " | " + loE.LineContents + CHR(13)+CHR(10)
ENDTRY
STRTOFILE(loc_cOut, "C:\4c\refatoracao\automation\erro377\simulacao_out.txt")
QUIT

FUNCTION Cenario(par_lParams, par_cEmp, par_cSerie, par_dDe, par_dAte, par_cEdn, par_cIni, par_cFim, par_cPng, par_cTit, par_lGeo)
    LOCAL loForm, loR, loOrig, loc_c, loE2, loPg, loc_i, loO
    loc_c = par_cTit + ": "
    TRY
        IF par_lParams
            loForm = CREATEOBJECT("Formsigreimc", par_cEmp, par_cSerie, par_dDe, par_dAte, par_cEdn, par_cIni, par_cFim)
        ELSE
            loForm = CREATEOBJECT("Formsigreimc")
        ENDIF
        loc_c = loc_c + "form=" + VARTYPE(loForm)
        IF VARTYPE(loForm) = "O"
            loPg = loForm.pgf_4c_Paginas.Page1
            loc_c = loc_c + " emp=[" + loForm.this_cEmp + "] serie=[" + loForm.this_cSerie + "] de=" + DTOC(loForm.this_dEmisDe) + " ate=" + DTOC(loForm.this_dEmisAte)
            IF par_lGeo
                loc_c = loc_c + " W=" + TRANSFORM(loForm.Width) + " H=" + TRANSFORM(loForm.Height) + " pgfTop=" + TRANSFORM(loForm.pgf_4c_Paginas.Top)
                FOR loc_i = 1 TO loPg.ControlCount
                    loO = loPg.Controls(loc_i)
                    loc_c = loc_c + CHR(13)+CHR(10) + "     " + PADR(loO.Name, 22) + " L=" + TRANSFORM(loO.Left) + " T(form)=" + TRANSFORM(loO.Top + loForm.pgf_4c_Paginas.Top) + ;
                        " W=" + TRANSFORM(loO.Width) + " H=" + TRANSFORM(loO.Height) + IIF(PEMSTATUS(loO, "Caption", 5), " [" + loO.Caption + "]", "") + ;
                        IIF(PEMSTATUS(loO, "Value", 5), " val=[" + TRANSFORM(loO.Value) + "]", "")
                ENDFOR
            ENDIF
            loPg.txt_4c_NotaIni.Value = par_cIni
            loPg.txt_4c_NotaFim.Value = par_cFim
            SET DATASESSION TO loForm.DataSessionId
            loOrig = loForm.this_oRelatorio
            loR = CREATEOBJECT("T377BO")
            loR.this_nCopias = loOrig.this_nCopias
            loForm.this_oRelatorio = loR
            gc_377Png = "C:\4c\refatoracao\automation\erro377\" + par_cPng + ".png"
            gc_377Info = "(nao renderizou)"
            loForm.BtnVisualizarClick()
            loc_c = loc_c + CHR(13)+CHR(10) + "     copias=" + TRANSFORM(loPg.txt_4c_Copias.Value) + " " + gc_377Info + IIF(EMPTY(loR.this_cMensagemErro), "", " msg=[" + loR.this_cMensagemErro + "]")
            SET DATASESSION TO 1
            loForm.this_oRelatorio = .NULL.
            loForm.Release()
        ENDIF
    CATCH TO loE2
        loc_c = loc_c + " ERRO: " + loE2.Message + " linha " + TRANSFORM(loE2.LineNo) + " " + loE2.Procedure
    ENDTRY
    RETURN loc_c + CHR(13)+CHR(10)
ENDFUNC

DEFINE CLASS T377BO AS sigreimcBO
    PROCEDURE PrepararDados()
        LOCAL loc_l, loc_nErr
        loc_l = DODEFAULT()
        gc_377Info = "PrepararDados=" + TRANSFORM(loc_l) + " emp=[" + THIS.this_cEmp + "] serie=[" + THIS.this_cSerie + "] ini=[" + THIS.this_cNotaIni + "] fim=[" + THIS.this_cNotaFim + "] msg=[" + THIS.this_cMensagemErro + "] XCorNf=" + IIF(USED("XCorNf"), TRANSFORM(RECCOUNT("XCorNf")), "nao")
        RETURN loc_l
    ENDPROC
    PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
        LOCAL loL, loc_c
        loc_c = "frx=" + par_cRelatorioBase + " alias=" + ALIAS() + " regs=" + TRANSFORM(RECCOUNT("XCorNf"))
        SELECT XCorNf
        SCAN
            loc_c = loc_c + CHR(13)+CHR(10) + "       NF " + cnfis + " via " + TRANSFORM(numvias) + " ocor " + TRANSFORM(noccors) + " " + ALLTRIM(cdescrs) + " | " + ALLTRIM(rclis) + " | " + ALLTRIM(endes) + " " + ALLTRIM(cidas) + "/" + estas
        ENDSCAN
        GO TOP
        SET POINT TO "."
        SET SEPARATOR TO ","
        SET REPORTBEHAVIOR 90
        loL = CREATEOBJECT("ReportListener")
        loL.ListenerType = 3
        TRY
            REPORT FORM (gc_4c_CaminhoReports + par_cRelatorioBase + ".frx") OBJECT loL
        CATCH TO loErrR
            gc_377Info = loc_c + " ERRO REPORT: " + loErrR.Message
            RETURN .F.
        ENDTRY
        loL.OutputPage(1, gc_377Png, 104)
        gc_377Info = loc_c + CHR(13)+CHR(10) + "     paginas=" + TRANSFORM(loL.PageTotal)
        RETURN .T.
    ENDPROC
ENDDEFINE

DEFINE CLASS T377BOx AS Custom
ENDDEFINE
