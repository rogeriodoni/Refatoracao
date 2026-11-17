*==============================================================================
* ProbeF4Task796.prg - Prova da Fase 4 de FormSigOpRob (task796)
*
* Mede, em VFP9 de verdade:
*   1. COMPILE do BO e do Form (FXP presente / ERR ausente)
*   2. CREATEOBJECT com os 3 argumentos do "Do Form ... With" legado
*   3. Geometria e propriedades do EditBox e do CommandGroup contra o dump
*   4. Escopo PUBLIC dos metodos que sao alvo de BINDEVENT / do chamador
*   5. BINDEVENT efetivamente registrado no Click do botao (AEVENTS)
*   6. Comportamento do Encerrar: pai reabilitado e form VIVO (Hide, nao Release)
*   7. Release do CHAMADOR encerrando o objeto
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_f4_task796.txt"

LOCAL loc_cOut, loc_oForm, loc_oErro, loc_oPai, loc_oCmg, loc_oEdt
LOCAL loc_cTexto, loc_nEv, loc_cFrm, loc_cBO
loc_cOut = "C:\4c\automation\probe_f4_task796.txt"
STRTOFILE("INICIO" + CHR(13) + CHR(10), loc_cOut)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gb_4c_ModoTeste   = .T.
    gb_4c_ValidandoUI = .T.

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
                 "," + gcCaminhoForms + "," + gcCaminhoIcones)

    loc_cBO  = gcCaminhoClasses + "SigOpRobBO.prg"
    loc_cFrm = gcCaminhoForms + "operacionais\FormSigOpRob.prg"

    *-- (1) COMPILE ---------------------------------------------------------
    COMPILE (loc_cBO)
    COMPILE (loc_cFrm)
    STRTOFILE("== 1. COMPILE ==" + CHR(13) + CHR(10) + ;
        "BO  FXP=" + IIF(FILE(FORCEEXT(loc_cBO, "fxp")), "SIM", "NAO") + ;
            " ERR=" + IIF(FILE(FORCEEXT(loc_cBO, "err")), "SIM", "NAO") + CHR(13) + CHR(10) + ;
        "FRM FXP=" + IIF(FILE(FORCEEXT(loc_cFrm, "fxp")), "SIM", "NAO") + ;
            " ERR=" + IIF(FILE(FORCEEXT(loc_cFrm, "err")), "SIM", "NAO") + CHR(13) + CHR(10) + ;
        IIF(FILE(FORCEEXT(loc_cFrm, "err")), FILETOSTR(FORCEEXT(loc_cFrm, "err")), "") + ;
        IIF(FILE(FORCEEXT(loc_cBO, "err")), FILETOSTR(FORCEEXT(loc_cBO, "err")), ""), loc_cOut, 1)

    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (loc_cBO)  ADDITIVE
    SET PROCEDURE TO (loc_cFrm) ADDITIVE

    *-- (2) CREATEOBJECT com os 3 argumentos do legado ----------------------
    loc_cTexto = "Linha 1 do historico" + CHR(13) + CHR(10) + "Linha 2 do historico"
    loc_oPai   = CREATEOBJECT("Form")
    loc_oPai.Enabled = .F.          && o pai se desabilita antes de abrir

    loc_oForm = CREATEOBJECT("FormSigOpRob", "Historico", loc_cTexto, loc_oPai)

    STRTOFILE(CHR(13) + CHR(10) + "== 2. INSTANCIACAO ==" + CHR(13) + CHR(10) + ;
        "VARTYPE=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10), loc_cOut, 1)

    IF VARTYPE(loc_oForm) = "O"
        STRTOFILE("BaseClass=" + loc_oForm.BaseClass + ;
            " Caption=[" + loc_oForm.Caption + "]" + ;
            " WxH=" + TRANSFORM(loc_oForm.Width) + "x" + TRANSFORM(loc_oForm.Height) + ;
            " WindowType=" + TRANSFORM(loc_oForm.WindowType) + ;
            " ControlCount=" + TRANSFORM(loc_oForm.ControlCount) + CHR(13) + CHR(10), loc_cOut, 1)

        *-- (3) EditBox e CommandGroup contra o dump -------------------------
        loc_oEdt = loc_oForm.obj_4c_Edit1
        loc_oCmg = loc_oForm.cmg_4c_Commandgroup1

        STRTOFILE(CHR(13) + CHR(10) + "== 3. CONTROLES ==" + CHR(13) + CHR(10) + ;
            "EDIT  T/L/W/H=" + TRANSFORM(loc_oEdt.Top) + "/" + TRANSFORM(loc_oEdt.Left) + ;
                "/" + TRANSFORM(loc_oEdt.Width) + "/" + TRANSFORM(loc_oEdt.Height) + ;
                " ReadOnly=" + TRANSFORM(loc_oEdt.ReadOnly) + ;
                " Visible=" + TRANSFORM(loc_oEdt.Visible) + ;
                " TipoValue=" + VARTYPE(loc_oEdt.Value) + ;
                " LenValue=" + TRANSFORM(LEN(loc_oEdt.Value)) + ;
                " ValueOK=" + TRANSFORM(loc_oEdt.Value == loc_cTexto) + CHR(13) + CHR(10) + ;
            "CMG   T/L/W/H=" + TRANSFORM(loc_oCmg.Top) + "/" + TRANSFORM(loc_oCmg.Left) + ;
                "/" + TRANSFORM(loc_oCmg.Width) + "/" + TRANSFORM(loc_oCmg.Height) + ;
                " AutoSize=" + TRANSFORM(loc_oCmg.AutoSize) + ;
                " ButtonCount=" + TRANSFORM(loc_oCmg.ButtonCount) + ;
                " BackStyle=" + TRANSFORM(loc_oCmg.BackStyle) + ;
                " BorderStyle=" + TRANSFORM(loc_oCmg.BorderStyle) + ;
                " SpecialEffect=" + TRANSFORM(loc_oCmg.SpecialEffect) + ;
                " Visible=" + TRANSFORM(loc_oCmg.Visible) + CHR(13) + CHR(10) + ;
            "BTN   T/L/W/H=" + TRANSFORM(loc_oCmg.Buttons(1).Top) + "/" + ;
                TRANSFORM(loc_oCmg.Buttons(1).Left) + "/" + ;
                TRANSFORM(loc_oCmg.Buttons(1).Width) + "/" + ;
                TRANSFORM(loc_oCmg.Buttons(1).Height) + ;
                " Caption=[" + loc_oCmg.Buttons(1).Caption + "]" + ;
                " Cancel=" + TRANSFORM(loc_oCmg.Buttons(1).Cancel) + ;
                " Themes=" + TRANSFORM(loc_oCmg.Buttons(1).Themes) + ;
                " Font=" + loc_oCmg.Buttons(1).FontName + CHR(13) + CHR(10) + ;
            "PIC   existe=" + IIF(FILE(loc_oCmg.Buttons(1).Picture), "SIM", "NAO") + ;
                " [" + loc_oCmg.Buttons(1).Picture + "]" + CHR(13) + CHR(10) + ;
            "FAIXA existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "cnt_4c_Sombra", 5)) + ;
                " TituloCaption=[" + loc_oForm.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption + "]" + ;
                CHR(13) + CHR(10), loc_cOut, 1)

        *-- (4) escopo dos metodos (2 = Protected; tem de ser .F.) -----------
        STRTOFILE(CHR(13) + CHR(10) + "== 4. ESCOPO (Protected? tem de ser .F.) ==" + CHR(13) + CHR(10) + ;
            "CmdSairClick   existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "CmdSairClick", 5)) + ;
                " protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "CmdSairClick", 2)) + CHR(13) + CHR(10) + ;
            "FecharDialogo  existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "FecharDialogo", 5)) + ;
                " protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "FecharDialogo", 2)) + CHR(13) + CHR(10), loc_cOut, 1)

        *-- (5) BINDEVENT registrado no Click do botao -----------------------
        *-- AEVENTS recebe DOIS argumentos; o nome do evento eh a COLUNA 3
        LOCAL ARRAY loc_aEv[1]
        LOCAL loc_nI, loc_cBind
        loc_nEv   = AEVENTS(loc_aEv, loc_oCmg.Buttons(1))
        loc_cBind = ""
        FOR loc_nI = 1 TO loc_nEv
            IF UPPER(ALLTRIM(loc_aEv[loc_nI, 3])) == "CLICK"
                loc_cBind = loc_cBind + " [col3=" + ALLTRIM(loc_aEv[loc_nI, 3]) + ;
                            " delegate=" + ALLTRIM(loc_aEv[loc_nI, 4]) + "]"
            ENDIF
        ENDFOR
        STRTOFILE(CHR(13) + CHR(10) + "== 5. BINDEVENT ==" + CHR(13) + CHR(10) + ;
            "AEVENTS(Buttons(1)) linhas=" + TRANSFORM(loc_nEv) + ;
            " Click:" + IIF(EMPTY(loc_cBind), "NENHUM", loc_cBind) + CHR(13) + CHR(10), loc_cOut, 1)

        *-- (6) Encerrar: pai reabilitado e form VIVO (Hide, nao Release) ----
        STRTOFILE(CHR(13) + CHR(10) + "== 6. ENCERRAR ==" + CHR(13) + CHR(10) + ;
            "ANTES  pai.Enabled=" + TRANSFORM(loc_oPai.Enabled) + CHR(13) + CHR(10), loc_cOut, 1)

        loc_oForm.CmdSairClick()

        STRTOFILE("DEPOIS pai.Enabled=" + TRANSFORM(loc_oPai.Enabled) + ;
            " form VARTYPE=" + VARTYPE(loc_oForm) + ;
            " form.Visible=" + TRANSFORM(loc_oForm.Visible) + CHR(13) + CHR(10), loc_cOut, 1)

        *-- (7) Release do CHAMADOR ------------------------------------------
        loc_oForm.Release()
        STRTOFILE(CHR(13) + CHR(10) + "== 7. RELEASE DO CHAMADOR ==" + CHR(13) + CHR(10) + ;
            "VARTYPE pos-Release=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10), loc_cOut, 1)
    ENDIF

    *-- (8) sem pai e sem argumento: nao pode estourar ----------------------
    loc_oForm = CREATEOBJECT("FormSigOpRob")
    STRTOFILE(CHR(13) + CHR(10) + "== 8. SEM ARGUMENTOS ==" + CHR(13) + CHR(10) + ;
        "VARTYPE=" + VARTYPE(loc_oForm) + ;
        IIF(VARTYPE(loc_oForm) = "O", ;
            " Caption=[" + loc_oForm.Caption + "] LenTexto=" + ;
            TRANSFORM(LEN(loc_oForm.obj_4c_Edit1.Value)), "") + CHR(13) + CHR(10), loc_cOut, 1)
    IF VARTYPE(loc_oForm) = "O"
        loc_oForm.CmdSairClick()
        STRTOFILE("Encerrar sem pai: OK, VARTYPE=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10), loc_cOut, 1)
        loc_oForm.Release()
    ENDIF

    STRTOFILE(CHR(13) + CHR(10) + "FIM OK" + CHR(13) + CHR(10), loc_cOut, 1)

CATCH TO loc_oErro
    STRTOFILE(CHR(13) + CHR(10) + "*** EXCECAO ***" + CHR(13) + CHR(10) + ;
        "Msg: "  + loc_oErro.Message + CHR(13) + CHR(10) + ;
        "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + CHR(10) + ;
        "Proc: "  + loc_oErro.Procedure + CHR(13) + CHR(10), loc_cOut, 1)
ENDTRY

QUIT
