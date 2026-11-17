SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gcOut
gcOut = "C:\4c\automation\probe784f5.txt"
STRTOFILE("PROBE F5 task784 (FormSigOpPdt) INICIO" + CHR(13) + CHR(10), gcOut)

DO ("C:\4c\projeto\app\start\config.prg")
ConfigurarAmbiente()
GarantirClasse("FormSigOpPdt")

*-- Modo teste DEPOIS do config.prg (ele reseta as flags) e com o arquivo de
*-- erro definido - sem os DOIS, MsgErro cai no MESSAGEBOX modal e o probe
*-- trava esperando um clique que nunca vem.
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe784f5_erros.txt"
STRTOFILE("", gc_4c_ArquivoErroTeste)

Log784("ambiente OK")

LOCAL loForm
loForm = CREATEOBJECT("FormSigOpPdt")
Log784("CREATEOBJECT -> VARTYPE=" + VARTYPE(loForm))

IF VARTYPE(loForm) = "O"
    Log784("Form: W=" + TRANSFORM(loForm.Width) + " H=" + TRANSFORM(loForm.Height) + ;
        " Caption=[" + loForm.Caption + "]" + ;
        " OpEscolha=[" + loForm.this_cOpEscolha + "]")

    Log784("--- FASE 5: MOLDURAS (dump: Shape2 339/73/168/39, Shape1 7/672/27/41) ---")
    DumpShp(loForm.shp_4c_Shape2, "shp_4c_Shape2")
    DumpShp(loForm.shp_4c_Shape1, "shp_4c_Shape1")

    Log784("--- FASE 5: CAMPO DE BUSCA (dump: Say 350/83/89/15, Get 347/186/48/23) ---")
    DumpLbl(loForm.lbl_4c__Procura, "lbl_4c__Procura")
    DumpTxt(loForm.txt_4c_Procura,  "txt_4c_Procura")

    *-- Regra #30: filho fora da area do pai eh RECORTADO (sem erro e sem log).
    Log784("--- RECORTE (limites do form: W=" + TRANSFORM(loForm.Width) + ;
        " H=" + TRANSFORM(loForm.Height) + ") ---")
    Log784("  Shape2 fim: Left+W=" + TRANSFORM(loForm.shp_4c_Shape2.Left + loForm.shp_4c_Shape2.Width) + ;
        " Top+H=" + TRANSFORM(loForm.shp_4c_Shape2.Top + loForm.shp_4c_Shape2.Height))
    Log784("  Shape1 fim: Left+W=" + TRANSFORM(loForm.shp_4c_Shape1.Left + loForm.shp_4c_Shape1.Width) + ;
        " Top+H=" + TRANSFORM(loForm.shp_4c_Shape1.Top + loForm.shp_4c_Shape1.Height))
    Log784("  Say fim: Left+W=" + TRANSFORM(loForm.lbl_4c__Procura.Left + loForm.lbl_4c__Procura.Width) + ;
        " | Get Left=" + TRANSFORM(loForm.txt_4c_Procura.Left) + ;
        " (sobreposicao se Say fim > Get Left - regra #28)")
    Log784("  Get fim: Left+W=" + TRANSFORM(loForm.txt_4c_Procura.Left + loForm.txt_4c_Procura.Width) + ;
        " Top+H=" + TRANSFORM(loForm.txt_4c_Procura.Top + loForm.txt_4c_Procura.Height))
    Log784("  Busca dentro de Shape2? Shape2=" + ;
        TRANSFORM(loForm.shp_4c_Shape2.Left) + ".." + ;
        TRANSFORM(loForm.shp_4c_Shape2.Left + loForm.shp_4c_Shape2.Width) + " x " + ;
        TRANSFORM(loForm.shp_4c_Shape2.Top) + ".." + ;
        TRANSFORM(loForm.shp_4c_Shape2.Top + loForm.shp_4c_Shape2.Height))

    *-- AjustarBotoesPorModo agora encontra os DOIS controles novos (antes os
    *-- ramos lbl_4c__Procura/txt_4c_Procura estavam mortos no PEMSTATUS).
    Log784("--- AjustarBotoesPorModo: modo INSERIR (tela completa) ---")
    loForm.AjustarBotoesPorModo()
    Log784("  SelTudo=" + TRANSFORM(loForm.cmd_4c_SelTudo.Visible) + ;
        " Apaga=" + TRANSFORM(loForm.cmd_4c_Apaga.Visible) + ;
        " Ok=" + TRANSFORM(loForm.cmd_4c_Ok.Visible) + ;
        " Say=" + TRANSFORM(loForm.lbl_4c__Procura.Visible) + ;
        " Get=" + TRANSFORM(loForm.txt_4c_Procura.Visible))

    loForm.this_cOpEscolha = "ALTERAR"
    loForm.AjustarBotoesPorModo()
    Log784("--- modo ALTERAR (legado esconde os 4) ---")
    Log784("  SelTudo=" + TRANSFORM(loForm.cmd_4c_SelTudo.Visible) + ;
        " Apaga=" + TRANSFORM(loForm.cmd_4c_Apaga.Visible) + ;
        " Ok=" + TRANSFORM(loForm.cmd_4c_Ok.Visible) + ;
        " Say=" + TRANSFORM(loForm.lbl_4c__Procura.Visible) + ;
        " Get=" + TRANSFORM(loForm.txt_4c_Procura.Visible))

    Log784("Controles no form (raiz): " + TRANSFORM(loForm.ControlCount))
    ListaRaiz(loForm)

    loForm.Release()
    Log784("Release OK")
ELSE
    Log784("FALHA: CREATEOBJECT nao devolveu objeto")
ENDIF

Log784("PROBE F5 FIM")
QUIT

PROCEDURE ListaRaiz(par_oForm)
    LOCAL loc_nI, loc_o
    FOR loc_nI = 1 TO par_oForm.ControlCount
        loc_o = par_oForm.Controls(loc_nI)
        Log784("  [" + TRANSFORM(loc_nI) + "] " + loc_o.Name + " (" + loc_o.BaseClass + ")" + ;
            " Top=" + TRANSFORM(loc_o.Top) + " Left=" + TRANSFORM(loc_o.Left) + ;
            " W=" + TRANSFORM(loc_o.Width) + " H=" + TRANSFORM(loc_o.Height) + ;
            " Visible=" + TRANSFORM(loc_o.Visible))
    ENDFOR
ENDPROC

PROCEDURE DumpShp(par_o, par_cNome)
    Log784(par_cNome + ": Top=" + TRANSFORM(par_o.Top) + " Left=" + TRANSFORM(par_o.Left) + ;
        " W=" + TRANSFORM(par_o.Width) + " H=" + TRANSFORM(par_o.Height) + ;
        " BackStyle=" + TRANSFORM(par_o.BackStyle) + ;
        " BorderStyle=" + TRANSFORM(par_o.BorderStyle) + ;
        " BorderColor=" + TRANSFORM(par_o.BorderColor) + ;
        " Curvature=" + TRANSFORM(par_o.Curvature) + ;
        " Visible=" + TRANSFORM(par_o.Visible))
ENDPROC

PROCEDURE DumpLbl(par_o, par_cNome)
    Log784(par_cNome + ": Caption=[" + par_o.Caption + "] Top=" + TRANSFORM(par_o.Top) + ;
        " Left=" + TRANSFORM(par_o.Left) + " W=" + TRANSFORM(par_o.Width) + ;
        " H=" + TRANSFORM(par_o.Height) + " AutoSize=" + TRANSFORM(par_o.AutoSize) + ;
        " Align=" + TRANSFORM(par_o.Alignment) + " BackStyle=" + TRANSFORM(par_o.BackStyle) + ;
        " Fore=" + TRANSFORM(par_o.ForeColor) + ;
        " Font=" + par_o.FontName + "/" + TRANSFORM(par_o.FontSize) + ;
        " TabIndex=" + TRANSFORM(par_o.TabIndex) + " Visible=" + TRANSFORM(par_o.Visible))
ENDPROC

PROCEDURE DumpTxt(par_o, par_cNome)
    Log784(par_cNome + ": Top=" + TRANSFORM(par_o.Top) + " Left=" + TRANSFORM(par_o.Left) + ;
        " W=" + TRANSFORM(par_o.Width) + " H=" + TRANSFORM(par_o.Height) + ;
        " MaxLength=" + TRANSFORM(par_o.MaxLength) + ;
        " Align=" + TRANSFORM(par_o.Alignment) + ;
        " Format=[" + par_o.Format + "] InputMask=[" + par_o.InputMask + "]" + ;
        " VType=" + VARTYPE(par_o.Value) + " Value=" + TRANSFORM(par_o.Value) + ;
        " Font=" + par_o.FontName + "/" + TRANSFORM(par_o.FontSize) + ;
        " TabIndex=" + TRANSFORM(par_o.TabIndex) + " Visible=" + TRANSFORM(par_o.Visible))
ENDPROC

PROCEDURE Log784(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gcOut, 1)
ENDPROC
