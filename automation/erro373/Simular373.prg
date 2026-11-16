SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
SET DATE TO BRITISH
SET CENTURY ON
LOCAL loc_cOut, loForm, loE, loPg
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste, gnConnHandle, gc_373Png, gc_373Info
gb_4c_ModoTeste = .T.
gb_4c_ValidandoUI = .F.
gc_4c_ArquivoErroTeste = "C:\4c\refatoracao\automation\erro373\mensagens.txt"
ERASE (gc_4c_ArquivoErroTeste)
loc_cOut = ""
TRY
    CD "C:\4c\refatoracao\projeto\app\start"
    DO config.prg
    ConfigurarAmbiente()
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"

    *-- Prova da causa: COPY MEMO de memo NULL
    SQLEXEC(gnConnHandle, "SELECT FigJpgs FROM SigCdCli WHERE iclis = 'T373000002'", "tNull")
    TRY
        COPY MEMO tNull.FigJpgs TO (ADDBS(SYS(2023)) + "t373null.jpg")
        loc_cOut = loc_cOut + "COPY MEMO de NULL: OK" + CHR(13)+CHR(10)
    CATCH TO loE
        loc_cOut = loc_cOut + "COPY MEMO de NULL: ERRO [" + loE.Message + "]  EMPTY(NULL)=" + TRANSFORM(EMPTY(tNull.FigJpgs)) + CHR(13)+CHR(10)
    ENDTRY
    USE IN tNull

    GarantirClasse("FormSIGREIDC")
    loForm = CREATEOBJECT("T373Form")
    loc_cOut = loc_cOut + "form=" + VARTYPE(loForm) + " W=" + TRANSFORM(loForm.Width) + " H=" + TRANSFORM(loForm.Height) + CHR(13)+CHR(10)
    loPg = loForm.pgf_4c_Paginas.Page1
    loc_cOut = loc_cOut + Geo(loForm, loPg)
    SET DATASESSION TO loForm.DataSessionId

    *-- A: EXATAMENTE a imagem (tudo em branco, Linha 1, Coluna 1, sem logo)
    loc_cOut = loc_cOut + Rodar(loForm, "A_imagem", "A) imagem")

    *-- B: Imprimir Logotipo
    loPg.chk_4c_OptLogo.Value = 1
    loc_cOut = loc_cOut + Rodar(loForm, "B_logo", "B) com logotipo")
    loPg.chk_4c_OptLogo.Value = 0

    *-- C: Grupo 11210, Linha 2 (5 etiquetas em branco antes)
    loPg.txt_4c_CdGrupo.Value = "11210"
    loPg.txt_4c_Linha.Value = 2
    loc_cOut = loc_cOut + Rodar(loForm, "C_grupo_linha2", "C) grupo 11210 linha 2")
    loPg.txt_4c_Linha.Value = 1

    *-- D: so a conta com foto
    loPg.txt_4c_CdGrupo.Value = ""
    loPg.txt_4c_CdConta.Value = "T373000001"
    loc_cOut = loc_cOut + Rodar(loForm, "D_conta_foto", "D) conta T373000001")

    SET DATASESSION TO 1
    loForm.Release()
CATCH TO loE
    loc_cOut = loc_cOut + "ERRO: " + loE.Message + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Procedure + " | " + loE.LineContents + CHR(13)+CHR(10)
ENDTRY
IF FILE(gc_4c_ArquivoErroTeste)
    loc_cOut = loc_cOut + "--- mensagens ---" + CHR(13)+CHR(10) + FILETOSTR(gc_4c_ArquivoErroTeste)
ENDIF
STRTOFILE(loc_cOut, "C:\4c\refatoracao\automation\erro373\simulacao_out.txt")
QUIT

FUNCTION Rodar(par_oForm, par_cPng, par_cTit)
    gc_373Png = "C:\4c\refatoracao\automation\erro373\" + par_cPng + ".png"
    gc_373Info = "(nao renderizou)"
    par_oForm.BtnVisualizarClick()
    RETURN par_cTit + ": " + gc_373Info + CHR(13)+CHR(10)
ENDFUNC

FUNCTION Geo(par_oForm, par_oPg)
    LOCAL loc_c, loc_i, loc_o
    loc_c = "  pgf Top=" + TRANSFORM(par_oForm.pgf_4c_Paginas.Top) + CHR(13)+CHR(10)
    FOR loc_i = 1 TO par_oPg.ControlCount
        loc_o = par_oPg.Controls(loc_i)
        loc_c = loc_c + "  " + PADR(loc_o.Name, 22) + " L=" + TRANSFORM(loc_o.Left) + " T(form)=" + TRANSFORM(loc_o.Top + par_oForm.pgf_4c_Paginas.Top) + ;
            " W=" + TRANSFORM(loc_o.Width) + " H=" + TRANSFORM(loc_o.Height) + CHR(13)+CHR(10)
    ENDFOR
    RETURN loc_c
ENDFUNC

DEFINE CLASS T373Form AS FormSIGREIDC
    PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
        LOCAL loL, loc_c, loc_cFoto, loc_cOrig
        loc_c = "regs=" + TRANSFORM(RECCOUNT("cIde")) + " ordem=" + ORDER("cIde") + " emp=[" + ALLTRIM(cIde.cEmpresas) + "]"
        loc_cOrig = FILETOSTR("C:\4c\refatoracao\vbmp\BRA.jpg")
        SELECT cIde
        SCAN
            loc_cFoto = ""
            IF !EMPTY(cArqJpgs) AND FILE(ALLTRIM(cArqJpgs))
                loc_cFoto = " foto=" + TRANSFORM(LEN(FILETOSTR(ALLTRIM(cArqJpgs)))) + "b igual_ao_original=" + TRANSFORM(FILETOSTR(ALLTRIM(cArqJpgs)) == loc_cOrig)
            ENDIF
            loc_c = loc_c + CHR(13)+CHR(10) + "     " + IIF(lBrancos, "(branco)", PADR(ALLTRIM(cContas), 11) + PADR(ALLTRIM(cDcontas), 42) + "grp=" + ALLTRIM(cGrupos) + ;
                IIF(EMPTY(gLogos), "", " logo=" + TRANSFORM(LEN(FILETOSTR(ALLTRIM(gLogos)))) + "b ini=[" + LEFT(FILETOSTR(ALLTRIM(gLogos)), 10) + "]") + loc_cFoto)
        ENDSCAN
        GO TOP
        SET POINT TO "."
        SET SEPARATOR TO ","
        SET REPORTBEHAVIOR 90
        loL = CREATEOBJECT("ReportListener")
        loL.ListenerType = 3
        REPORT FORM (gc_4c_CaminhoReports + par_cRelatorioBase + ".frx") OBJECT loL
        loL.OutputPage(1, gc_373Png, 104)
        gc_373Info = loc_c + CHR(13)+CHR(10) + "     paginas=" + TRANSFORM(loL.PageTotal)
        RETURN .T.
    ENDPROC
ENDDEFINE
