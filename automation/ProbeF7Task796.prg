*==============================================================================
* ProbeF7Task796.prg - Prova da Fase 7 de FormSigOpRob (task796)
*
* A Fase 7 e' "eventos principais". Num dialogo cuja unica acao e' FECHAR, os
* eventos principais sao os CAMINHOS DE SAIDA - e e' isso que este probe mede,
* na CLASSE REAL (nao numa maquete), com o form de fato exibido:
*
*   1. COMPILE do BO e do Form (FXP presente / ERR ausente)
*   2. QueryUnload existe, e' PUBLIC e nao e' PROTECTED
*   3. Caminho ENCERRAR  - Click do botao interno, ligado por BINDEVENT
*   4. Caminho ESC       - Cancel = .T. no botao interno
*   5. Caminho ALT+F4    - WM_CLOSE -> QueryUnload + NODEFAULT
*
* Nos tres caminhos a exigencia e' a MESMA: o form pai volta a Enabled = .T.,
* a janela fica invisivel, o OBJETO CONTINUA VIVO (quem destroi e' o chamador)
* e o Release() do chamador roda sem erro.
*
* O Timer e' adicionado em RUNTIME a instancia (a classe nao tem Timer): e' o
* unico jeito de acionar um caminho de saida enquanto o Show() de um form MODAL
* bloqueia a execucao. Nao altera a classe.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste, gc_4c_Out
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_f7_task796.txt"
gc_4c_Out              = "C:\4c\automation\probe_f7_task796.txt"

LOCAL loc_oErro, loc_cFrm, loc_cBO, loc_nI, loc_cCaminho
LOCAL ARRAY loc_aCasos[3]
loc_aCasos[1] = "ENCERRAR"
loc_aCasos[2] = "ESC"
loc_aCasos[3] = "ALTF4"

STRTOFILE("INICIO" + CHR(13) + CHR(10), gc_4c_Out)

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
    DO LogP WITH "== 1. COMPILE =="
    DO LogP WITH "BO  FXP=" + IIF(FILE(FORCEEXT(loc_cBO, "fxp")), "SIM", "NAO") + ;
        " ERR=" + IIF(FILE(FORCEEXT(loc_cBO, "err")), "SIM", "NAO")
    DO LogP WITH "FRM FXP=" + IIF(FILE(FORCEEXT(loc_cFrm, "fxp")), "SIM", "NAO") + ;
        " ERR=" + IIF(FILE(FORCEEXT(loc_cFrm, "err")), "SIM", "NAO")
    IF FILE(FORCEEXT(loc_cFrm, "err"))
        DO LogP WITH FILETOSTR(FORCEEXT(loc_cFrm, "err"))
    ENDIF

    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (loc_cBO)  ADDITIVE
    SET PROCEDURE TO (loc_cFrm) ADDITIVE

    *-- (2) escopo do QueryUnload -------------------------------------------
    DO LogP WITH ""
    DO LogP WITH "== 2. ESCOPO (protected tem de ser .F.) =="
    DO MedirEscopo

    *-- (3..5) os tres caminhos de saida ------------------------------------
    FOR loc_nI = 1 TO 3
        loc_cCaminho = loc_aCasos[loc_nI]
        DO LogP WITH ""
        DO LogP WITH "== CAMINHO DE SAIDA: " + loc_cCaminho + " =="
        DO MedirCaminho WITH loc_cCaminho
    ENDFOR

    DO LogP WITH ""
    DO LogP WITH "FIM OK"
CATCH TO loc_oErro
    DO LogP WITH "ERRO NAO TRATADO: " + loc_oErro.Message + ;
        " / linha " + TRANSFORM(loc_oErro.LineNo) + ;
        " / proc " + loc_oErro.Procedure
ENDTRY

QUIT

*------------------------------------------------------------------------------
PROCEDURE LogP
    LPARAMETERS par_cTexto
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gc_4c_Out, 1)
ENDPROC

*------------------------------------------------------------------------------
PROCEDURE MedirEscopo
    LOCAL loc_oF, loc_oE, loc_nI, loc_cM
    LOCAL ARRAY loc_aM[3]
    loc_aM[1] = "QueryUnload"
    loc_aM[2] = "FecharDialogo"
    loc_aM[3] = "CmdSairClick"
    TRY
        loc_oF = CREATEOBJECT("FormSigOpRob", "Escopo", "x", .NULL.)
        IF VARTYPE(loc_oF) = "O"
            FOR loc_nI = 1 TO 3
                loc_cM = loc_aM[loc_nI]
                DO LogP WITH PADR(loc_cM, 16) + ;
                    "existe=" + TRANSFORM(PEMSTATUS(loc_oF, loc_cM, 5)) + ;
                    " protected=" + TRANSFORM(PEMSTATUS(loc_oF, loc_cM, 2))
            ENDFOR
            loc_oF.Release()
        ELSE
            DO LogP WITH "CREATEOBJECT devolveu " + VARTYPE(loc_oF)
        ENDIF
    CATCH TO loc_oE
        DO LogP WITH "ERRO no escopo: " + loc_oE.Message
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
PROCEDURE MedirCaminho
    LPARAMETERS par_cCaminho
    LOCAL loc_oPai, loc_oDlg, loc_oE

    TRY
        loc_oPai = CREATEOBJECT("FrmPaiProbe")

        *-- o pai se DESABILITA antes de abrir, como o legado faz
        loc_oPai.Enabled = .F.
        DO LogP WITH "  ANTES  pai.Enabled=" + TRANSFORM(loc_oPai.Enabled)

        loc_oDlg = CREATEOBJECT("FormSigOpRob", "Historico", ;
            "texto de teste do caminho " + par_cCaminho, loc_oPai)

        IF VARTYPE(loc_oDlg) != "O"
            DO LogP WITH "  CREATEOBJECT devolveu " + VARTYPE(loc_oDlg)
        ELSE
            loc_oDlg.AddObject("tmr_probe", "TmrSaidaProbe")
            loc_oDlg.tmr_probe.cCaminho = par_cCaminho
            loc_oDlg.tmr_probe.Enabled  = .T.

            loc_oDlg.Show()

            DO LogP WITH "  Show() devolveu"
            DO LogP WITH "  DEPOIS pai.Enabled=" + TRANSFORM(loc_oPai.Enabled) + ;
                " dlg VARTYPE=" + VARTYPE(loc_oDlg) + ;
                IIF(VARTYPE(loc_oDlg) = "O", " dlg.Visible=" + TRANSFORM(loc_oDlg.Visible), "")
            IF VARTYPE(loc_oDlg) = "O"
                loc_oDlg.Release()
                DO LogP WITH "  Release() do chamador: OK"
            ELSE
                DO LogP WITH "  Release() do chamador: NAO EXECUTAVEL (objeto morto)"
            ENDIF
        ENDIF
        IF VARTYPE(loc_oPai) = "O"
            loc_oPai.Release()
        ENDIF
    CATCH TO loc_oE
        DO LogP WITH "  *** ERRO: " + loc_oE.Message + ;
            " / linha " + TRANSFORM(loc_oE.LineNo) + " / proc " + loc_oE.Procedure
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
DEFINE CLASS FrmPaiProbe AS Form
    Width      = 200
    Height     = 100
    WindowType = 0
    Name       = "frmpaiprobe"
ENDDEFINE

*-- aciona UMA vez o caminho de saida escolhido
DEFINE CLASS TmrSaidaProbe AS Timer
    Interval  = 1200
    Enabled   = .F.
    cCaminho  = ""

    PROCEDURE Timer
        THIS.Enabled = .F.
        DO CASE
        CASE THIS.cCaminho = "ENCERRAR"
            THISFORM.cmg_4c_Commandgroup1.Buttons(1).Click()
        CASE THIS.cCaminho = "ESC"
            KEYBOARD "{ESC}" PLAIN
        CASE THIS.cCaminho = "ALTF4"
            DECLARE INTEGER SendMessage IN user32 ;
                INTEGER hWnd, INTEGER Msg, INTEGER wParam, INTEGER lParam
            SendMessage(THISFORM.HWnd, 0x0010, 0, 0)
        ENDCASE
    ENDPROC
ENDDEFINE
