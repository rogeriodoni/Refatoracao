SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gcOut
gcOut = "C:\4c\automation\probe755f5.txt"
STRTOFILE("PROBE F5 task755 INICIO" + CHR(13) + CHR(10), gcOut)

DO ("C:\4c\projeto\app\start\config.prg")
ConfigurarAmbiente()
GarantirClasse("FormSigOpJob")

*-- Modo teste DEPOIS do config.prg (ele reseta as flags) e com o arquivo de
*-- erro definido - sem os DOIS, MsgErro cai no MESSAGEBOX modal e o probe
*-- trava esperando um clique que nunca vem.
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe755f5_erros.txt"
STRTOFILE("", gc_4c_ArquivoErroTeste)

Log755("ambiente OK")

*-- Instancia a SUBCLASSE de probe: FormParaBO/BOParaForm/CarregarCabecalhoJob
*-- sao PROTECTED (e devem continuar - nada externo os chama no form real).
*-- Chamar PROTECTED de fora estoura Program Error modal e trava o probe;
*-- uma subclasse pode chamar os proprios metodos herdados.
LOCAL loForm, loPgf, loPg3, loC1, loC2, lnI, lcZ
loForm = CREATEOBJECT("ProbeFormSigOpJob")
Log755("CREATEOBJECT -> VARTYPE=" + VARTYPE(loForm))

IF VARTYPE(loForm) = "O"
    loPgf = loForm.pgf_4c_Job
    Log755("PageFrame: PageCount=" + TRANSFORM(loPgf.PageCount) + ;
           " Tabs=" + TRANSFORM(loPgf.Tabs) + ;
           " Top=" + TRANSFORM(loPgf.Top) + " W=" + TRANSFORM(loPgf.Width) + ;
           " H=" + TRANSFORM(loPgf.Height) + ;
           " PageWidth=" + TRANSFORM(loPgf.PageWidth) + ;
           " PageHeight=" + TRANSFORM(loPgf.PageHeight) + ;
           " Visible=" + TRANSFORM(loPgf.Visible))

    FOR lnI = 1 TO 6
        lcZ = "Page" + TRANSFORM(lnI)
        Log755("  " + lcZ + ": Caption=[" + EVALUATE("loPgf." + lcZ + ".Caption") + "]" + ;
            " PageOrder=" + TRANSFORM(EVALUATE("loPgf." + lcZ + ".PageOrder")) + ;
            " Fore=" + TRANSFORM(EVALUATE("loPgf." + lcZ + ".ForeColor")) + ;
            " Back=" + TRANSFORM(EVALUATE("loPgf." + lcZ + ".BackColor")) + ;
            " Pic=[" + JUSTFNAME(EVALUATE("loPgf." + lcZ + ".Picture")) + "]" + ;
            " Ctrls=" + TRANSFORM(EVALUATE("loPgf." + lcZ + ".ControlCount")))
    ENDFOR

    Log755("--- CABECALHO (raiz) ---")
    DumpTxt(loForm.txt_4c_Cab001, "txt_4c_Cab001")
    DumpTxt(loForm.txt_4c_Cab002, "txt_4c_Cab002")
    DumpTxt(loForm.txt_4c_Cab005, "txt_4c_Cab005")
    DumpTxt(loForm.txt_4c_Cab006, "txt_4c_Cab006")
    DumpTxt(loForm.txt_4c_Cab010, "txt_4c_Cab010")
    DumpLbl(loForm.lbl_4c_LblCab001, "lbl_4c_LblCab001")
    DumpLbl(loForm.lbl_4c_Lbl_Extra, "lbl_4c_Lbl_Extra")
    DumpLbl(loForm.lbl_4c_Label3,    "lbl_4c_Label3")
    Log755("chk_4c_Get_Extra: Top=" + TRANSFORM(loForm.chk_4c_Get_Extra.Top) + ;
        " Left=" + TRANSFORM(loForm.chk_4c_Get_Extra.Left) + ;
        " W=" + TRANSFORM(loForm.chk_4c_Get_Extra.Width) + ;
        " H=" + TRANSFORM(loForm.chk_4c_Get_Extra.Height) + ;
        " VType=" + VARTYPE(loForm.chk_4c_Get_Extra.Value) + ;
        " Fore=" + TRANSFORM(loForm.chk_4c_Get_Extra.ForeColor) + ;
        " Visible=" + TRANSFORM(loForm.chk_4c_Get_Extra.Visible))
    Log755("obj_4c_GetCabContatos: Top=" + TRANSFORM(loForm.obj_4c_GetCabContatos.Top) + ;
        " Left=" + TRANSFORM(loForm.obj_4c_GetCabContatos.Left) + ;
        " W=" + TRANSFORM(loForm.obj_4c_GetCabContatos.Width) + ;
        " H=" + TRANSFORM(loForm.obj_4c_GetCabContatos.Height) + ;
        " Font=" + loForm.obj_4c_GetCabContatos.FontName + ;
        " Visible=" + TRANSFORM(loForm.obj_4c_GetCabContatos.Visible))

    Log755("Recorte cabecalho: maior fundo=" + ;
        TRANSFORM(MAX(loForm.txt_4c_Cab010.Top + loForm.txt_4c_Cab010.Height, ;
                      loForm.obj_4c_GetCabContatos.Top + loForm.obj_4c_GetCabContatos.Height)) + ;
        " (limite pgf.Top=" + TRANSFORM(loPgf.Top) + ")")
    Log755("Recorte direita: contatos fim=" + ;
        TRANSFORM(loForm.obj_4c_GetCabContatos.Left + loForm.obj_4c_GetCabContatos.Width) + ;
        " CmdRetornar Left=" + TRANSFORM(loForm.obj_4c_CmdRetornar.Left) + ;
        " Form.Width=" + TRANSFORM(loForm.Width))

    Log755("--- PAGE3 / EQUIPES ---")
    loPg3 = loPgf.Page3
    loC1  = loPg3.cnt_4c_Emp1
    loC2  = loPg3.cnt_4c_Emp2
    Log755("cnt_4c_Emp1: Top=" + TRANSFORM(loC1.Top) + " Left=" + TRANSFORM(loC1.Left) + ;
        " W=" + TRANSFORM(loC1.Width) + " H=" + TRANSFORM(loC1.Height) + ;
        " BackStyle=" + TRANSFORM(loC1.BackStyle) + " Ctrls=" + TRANSFORM(loC1.ControlCount))
    Log755("cnt_4c_Emp2: Top=" + TRANSFORM(loC2.Top) + " Left=" + TRANSFORM(loC2.Left) + ;
        " W=" + TRANSFORM(loC2.Width) + " H=" + TRANSFORM(loC2.Height) + ;
        " BackStyle=" + TRANSFORM(loC2.BackStyle) + " Ctrls=" + TRANSFORM(loC2.ControlCount))

    DumpTxt(loC1.txt_4c__01_024,  "Emp1.txt_4c__01_024")
    DumpTxt(loC1.txt_4c__01_024a, "Emp1.txt_4c__01_024a")
    DumpLbl(loC1.lbl_4c_Lbl_01_026, "Emp1.lbl_4c_Lbl_01_026")
    DumpTxt(loC2.txt_4c__01_037,  "Emp2.txt_4c__01_037")
    DumpTxt(loC2.txt_4c__01_037a, "Emp2.txt_4c__01_037a")
    DumpLbl(loC2.lbl_4c_Lbl_01_037, "Emp2.lbl_4c_Lbl_01_037")

    Log755("Recorte Emp1: codigo fim=" + ;
        TRANSFORM(loC1.txt_4c__01_024.Left + loC1.txt_4c__01_024.Width) + ;
        " (limite W=" + TRANSFORM(loC1.Width) + ") | ultima linha fundo=" + ;
        TRANSFORM(loC1.txt_4c__01_030.Top + loC1.txt_4c__01_030.Height) + ;
        " (limite H=" + TRANSFORM(loC1.Height) + ")")
    Log755("Recorte Emp2 Left+W=" + TRANSFORM(loC2.Left + loC2.Width) + ;
        " (limite PageWidth=" + TRANSFORM(loPgf.PageWidth) + ")")
    Log755("Sobrep. Emp1 linha 024: nome fim=" + ;
        TRANSFORM(loC1.txt_4c__01_024a.Left + loC1.txt_4c__01_024a.Width) + ;
        " codigo Left=" + TRANSFORM(loC1.txt_4c__01_024.Left))

    Log755("--- PAGE3 / TIPOS ---")
    Log755("lin_4c_Line1: Top=" + TRANSFORM(loPg3.lin_4c_Line1.Top) + ;
        " Left=" + TRANSFORM(loPg3.lin_4c_Line1.Left) + ;
        " W=" + TRANSFORM(loPg3.lin_4c_Line1.Width) + ;
        " H=" + TRANSFORM(loPg3.lin_4c_Line1.Height) + ;
        " Visible=" + TRANSFORM(loPg3.lin_4c_Line1.Visible))
    FOR lnI = 38 TO 44
        lcZ = "chk_4c_Get_01_0" + TRANSFORM(lnI)
        Log755("  " + lcZ + ": Top=" + TRANSFORM(EVALUATE("loPg3." + lcZ + ".Top")) + ;
            " Left=" + TRANSFORM(EVALUATE("loPg3." + lcZ + ".Left")) + ;
            " W=" + TRANSFORM(EVALUATE("loPg3." + lcZ + ".Width")) + ;
            " VType=" + VARTYPE(EVALUATE("loPg3." + lcZ + ".Value")) + ;
            " Visible=" + TRANSFORM(EVALUATE("loPg3." + lcZ + ".Visible")))
    ENDFOR
    Log755("Recorte tipos: ultimo fundo=" + ;
        TRANSFORM(loPg3.chk_4c_Get_01_041.Top + loPg3.chk_4c_Get_01_041.Height) + ;
        " (limite PageHeight=" + TRANSFORM(loPgf.PageHeight) + ")")

    Log755("TextBox na tela (recursivo): " + TRANSFORM(ContaTextBox(loForm)))

    Log755("--- FormParaBO / BOParaForm ---")
    loC1.txt_4c__01_024.Value = "0000000123"
    loC2.txt_4c__01_037.Value = "0000000999"
    loPg3.chk_4c_Get_01_039.Value = 1
    loForm.chk_4c_Get_Extra.Value = 1
    loForm.TesteFormParaBO()
    Log755("pos FormParaBO: Jb024=[" + loForm.this_oBusinessObject.this_cJb024 + "]" + ;
        " Jb037=[" + loForm.this_oBusinessObject.this_cJb037 + "]" + ;
        " Jb039=" + TRANSFORM(loForm.this_oBusinessObject.this_nJb039) + ;
        " Jb072=" + TRANSFORM(loForm.this_oBusinessObject.this_nJb072))

    loC1.txt_4c__01_024.Value = ""
    loC2.txt_4c__01_037.Value = ""
    loPg3.chk_4c_Get_01_039.Value = 0
    loForm.chk_4c_Get_Extra.Value = 0
    loForm.TesteBOParaForm()
    Log755("pos BOParaForm: txt024=[" + loC1.txt_4c__01_024.Value + "]" + ;
        " txt037=[" + loC2.txt_4c__01_037.Value + "]" + ;
        " chk039=" + TRANSFORM(loPg3.chk_4c_Get_01_039.Value) + ;
        " chkExtra=" + TRANSFORM(loForm.chk_4c_Get_Extra.Value))

    loForm.TesteCarregarCabecalho()
    Log755("CarregarCabecalhoJob OK: Cab001=[" + loForm.txt_4c_Cab001.Value + "]")

    loForm.Release()
    Log755("Release OK")
ELSE
    Log755("FALHA: CREATEOBJECT nao devolveu objeto")
ENDIF

Log755("PROBE F5 FIM")
QUIT

FUNCTION ContaTextBox(par_oPai)
    LOCAL loc_nI, loc_nTot, loc_o, loc_nP
    loc_nTot = 0
    FOR loc_nI = 1 TO par_oPai.ControlCount
        loc_o = par_oPai.Controls(loc_nI)
        IF UPPER(loc_o.BaseClass) = "TEXTBOX"
            loc_nTot = loc_nTot + 1
        ENDIF
        IF UPPER(loc_o.BaseClass) = "PAGEFRAME"
            FOR loc_nP = 1 TO loc_o.PageCount
                loc_nTot = loc_nTot + ContaTextBox(loc_o.Pages(loc_nP))
            ENDFOR
        ELSE
            IF PEMSTATUS(loc_o, "ControlCount", 5) AND loc_o.ControlCount > 0
                loc_nTot = loc_nTot + ContaTextBox(loc_o)
            ENDIF
        ENDIF
    ENDFOR
    RETURN loc_nTot
ENDFUNC

PROCEDURE DumpLbl(par_o, par_cNome)
    Log755(par_cNome + ": Caption=[" + par_o.Caption + "] Top=" + TRANSFORM(par_o.Top) + ;
        " Left=" + TRANSFORM(par_o.Left) + " W=" + TRANSFORM(par_o.Width) + ;
        " H=" + TRANSFORM(par_o.Height) + " AutoSize=" + TRANSFORM(par_o.AutoSize) + ;
        " Align=" + TRANSFORM(par_o.Alignment) + " BackStyle=" + TRANSFORM(par_o.BackStyle) + ;
        " Fore=" + TRANSFORM(par_o.ForeColor) + " Bold=" + TRANSFORM(par_o.FontBold) + ;
        " TabIndex=" + TRANSFORM(par_o.TabIndex) + " Visible=" + TRANSFORM(par_o.Visible))
ENDPROC

PROCEDURE DumpTxt(par_o, par_cNome)
    Log755(par_cNome + ": Top=" + TRANSFORM(par_o.Top) + " Left=" + TRANSFORM(par_o.Left) + ;
        " W=" + TRANSFORM(par_o.Width) + " H=" + TRANSFORM(par_o.Height) + ;
        " MaxLength=" + TRANSFORM(par_o.MaxLength) + ;
        " Enabled=" + TRANSFORM(par_o.Enabled) + ;
        " Format=[" + par_o.Format + "] InputMask=[" + par_o.InputMask + "]" + ;
        " SpecEff=" + TRANSFORM(par_o.SpecialEffect) + ;
        " VType=" + VARTYPE(par_o.Value) + ;
        " TabIndex=" + TRANSFORM(par_o.TabIndex) + " Visible=" + TRANSFORM(par_o.Visible))
ENDPROC

PROCEDURE Log755(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gcOut, 1)
ENDPROC

DEFINE CLASS ProbeFormSigOpJob AS FormSigOpJob
    PROCEDURE TesteFormParaBO()
        THIS.FormParaBO()
    ENDPROC
    PROCEDURE TesteBOParaForm()
        THIS.BOParaForm()
    ENDPROC
    PROCEDURE TesteCarregarCabecalho()
        THIS.CarregarCabecalhoJob()
    ENDPROC
ENDDEFINE
