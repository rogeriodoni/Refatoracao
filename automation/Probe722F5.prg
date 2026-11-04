SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gcOut
gcOut = "C:\4c\automation\probe722f5.txt"
STRTOFILE("PROBE F5 INICIO" + CHR(13) + CHR(10), gcOut)

DO ("C:\4c\projeto\app\start\config.prg")
ConfigurarAmbiente()
GarantirClasse("FormSigOpDmp")
Log722("ambiente OK")

LOCAL loForm, loPg2, lnI, lcZ
loForm = CREATEOBJECT("FormSigOpDmp")
Log722("CREATEOBJECT -> VARTYPE=" + VARTYPE(loForm))

IF VARTYPE(loForm) = "O"
    loPg2 = loForm.pgf_4c_Paginas.Page2

    lcZ = ""
    FOR lnI = 1 TO loPg2.ControlCount
        lcZ = lcZ + IIF(EMPTY(lcZ), "", " | ") + UPPER(loPg2.Controls(lnI).Name)
    ENDFOR
    Log722("Page2 z-order (" + TRANSFORM(loPg2.ControlCount) + "): " + lcZ)

    Log722("Existem? lbl_4c_Nome="  + TRANSFORM(PEMSTATUS(loPg2, "lbl_4c_Nome", 5)) + ;
           " txt_4c_Nome="   + TRANSFORM(PEMSTATUS(loPg2, "txt_4c_Nome", 5)) + ;
           " lbl_4c_Grupo="  + TRANSFORM(PEMSTATUS(loPg2, "lbl_4c_Grupo", 5)) + ;
           " txt_4c_Grupo="  + TRANSFORM(PEMSTATUS(loPg2, "txt_4c_Grupo", 5)) + ;
           " txt_4c_DGrupo=" + TRANSFORM(PEMSTATUS(loPg2, "txt_4c_DGrupo", 5)))

    DumpLbl(loPg2.lbl_4c_Nome,  "lbl_4c_Nome")
    DumpTxt(loPg2.txt_4c_Nome,  "txt_4c_Nome")
    DumpLbl(loPg2.lbl_4c_Grupo, "lbl_4c_Grupo")
    DumpTxt(loPg2.txt_4c_Grupo, "txt_4c_Grupo")
    DumpTxt(loPg2.txt_4c_DGrupo,"txt_4c_DGrupo")

    *-- Faixa do cabecalho vai ate Top=109: nenhum campo pode ficar abaixo
    Log722("Faixa: Top=" + TRANSFORM(loPg2.cnt_4c_Cabecalho.Top) + ;
           " Height=" + TRANSFORM(loPg2.cnt_4c_Cabecalho.Height) + ;
           " fim=" + TRANSFORM(loPg2.cnt_4c_Cabecalho.Top + loPg2.cnt_4c_Cabecalho.Height))

    *-- Format "K!" forca MAIUSCULA? Teste por atribuicao e leitura de volta
    loPg2.txt_4c_Grupo.Value = "abc"
    loPg2.txt_4c_Nome.Value  = "demo um"
    Log722("Atribuicao: txt_4c_Grupo.Value=[" + loPg2.txt_4c_Grupo.Value + "]" + ;
           " txt_4c_Nome.Value=[" + loPg2.txt_4c_Nome.Value + "]")

    *-- Sobreposicao label x campo (regras #23/#28): fim do label < Left do campo
    Log722("Sobreposicao: lbl_4c_Nome fim=" + TRANSFORM(loPg2.lbl_4c_Nome.Left + loPg2.lbl_4c_Nome.Width) + ;
           " txt_4c_Nome Left=" + TRANSFORM(loPg2.txt_4c_Nome.Left) + ;
           " | lbl_4c_Grupo fim=" + TRANSFORM(loPg2.lbl_4c_Grupo.Left + loPg2.lbl_4c_Grupo.Width) + ;
           " txt_4c_Grupo Left=" + TRANSFORM(loPg2.txt_4c_Grupo.Left) + ;
           " | txt_4c_Grupo fim=" + TRANSFORM(loPg2.txt_4c_Grupo.Left + loPg2.txt_4c_Grupo.Width) + ;
           " txt_4c_DGrupo Left=" + TRANSFORM(loPg2.txt_4c_DGrupo.Left))

    *-- Funil de volta continua intacto
    loForm.this_cModoAtual = "INCLUIR"
    loForm.AlternarPagina(2)
    Log722("AlternarPagina(2): ActivePage=" + TRANSFORM(loForm.pgf_4c_Paginas.ActivePage))
    loForm.BtnCancelarClick()
    Log722("BtnCancelarClick: ActivePage=" + TRANSFORM(loForm.pgf_4c_Paginas.ActivePage) + ;
           " Modo=" + loForm.this_cModoAtual + ;
           " Incluir.Enabled=" + TRANSFORM(loForm.pgf_4c_Paginas.Page1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled))

    loForm.Release()
    Log722("Release OK")
ENDIF

Log722("PROBE F5 FIM")
QUIT

PROCEDURE DumpLbl(par_o, par_cNome)
    Log722(par_cNome + ": Caption=[" + par_o.Caption + "] Top=" + TRANSFORM(par_o.Top) + ;
        " Left=" + TRANSFORM(par_o.Left) + " W=" + TRANSFORM(par_o.Width) + ;
        " H=" + TRANSFORM(par_o.Height) + " AutoSize=" + TRANSFORM(par_o.AutoSize) + ;
        " Align=" + TRANSFORM(par_o.Alignment) + " BackStyle=" + TRANSFORM(par_o.BackStyle) + ;
        " Fore=" + TRANSFORM(par_o.ForeColor) + " Font=" + par_o.FontName + "/" + ;
        TRANSFORM(par_o.FontSize) + " TabIndex=" + TRANSFORM(par_o.TabIndex) + ;
        " Visible=" + TRANSFORM(par_o.Visible))
ENDPROC

PROCEDURE DumpTxt(par_o, par_cNome)
    Log722(par_cNome + ": Top=" + TRANSFORM(par_o.Top) + " Left=" + TRANSFORM(par_o.Left) + ;
        " W=" + TRANSFORM(par_o.Width) + " H=" + TRANSFORM(par_o.Height) + ;
        " MaxLength=" + TRANSFORM(par_o.MaxLength) + " Format=[" + par_o.Format + "]" + ;
        " InputMask=[" + par_o.InputMask + "]" + ;
        " Font=" + par_o.FontName + "/" + TRANSFORM(par_o.FontSize) + ;
        " CtrlSrc=[" + par_o.ControlSource + "]" + ;
        " VType=" + VARTYPE(par_o.Value) + ;
        " TabIndex=" + TRANSFORM(par_o.TabIndex) + ;
        " Visible=" + TRANSFORM(par_o.Visible))
ENDPROC

PROCEDURE Log722(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gcOut, 1)
ENDPROC
