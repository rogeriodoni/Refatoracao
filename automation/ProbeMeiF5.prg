*==============================================================================
* ProbeMeiF5.prg - MEDE no VFP9 o resultado da Fase 5 de FormSIGPRMEI:
*   (a) o form INSTANCIA (Init completo, ConfigurarPaginaDados incluso)
*   (b) TabIndex transcrito do SCX chegou aos dois focalizaveis
*   (c) Left/FontName dos botoes batem com o SCX (grupo 345 + rel 5/80)
*   (d) cntSombra em 0,0 e Rotation dos labels do cabecalho
* NAO chama Show(): o form eh WindowType = 1 (modal) e travaria o headless.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gc_4c_LogProbe
PUBLIC gnConnHandle, gb_4c_ValidandoUI
*-- mesmo contrato de ValidarUIFidelity.prg:124 - gnConnHandle eh declarado em
*-- main.prg (NAO em config.prg), entao o harness tem de declarar por conta
gnConnHandle      = -1
gb_4c_ValidandoUI = .F.
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_probemeif5.txt"
gc_4c_LogProbe         = "C:\4c\automation\probe_mei_f5_result.txt"

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
IF FILE(gc_4c_LogProbe)
    DELETE FILE (gc_4c_LogProbe)
ENDIF

LOCAL loc_oForm, loc_oErro
LogProbe("PROBE FASE5 FormSIGPRMEI - inicio " + TTOC(DATETIME()))

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
                 "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SIGPRMEIBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSIGPRMEI.prg") ADDITIVE

    loc_oForm = CREATEOBJECT("FormSIGPRMEI")

    IF VARTYPE(loc_oForm) <> "O"
        LogProbe("FALHA: CREATEOBJECT devolveu " + VARTYPE(loc_oForm) + " (Init retornou .F.)")
    ELSE
        LogProbe("OK  instanciou  BaseClass=[" + loc_oForm.BaseClass + "]  Caption=[" + loc_oForm.Caption + "]")
        LogProbe("    Width=" + TRANSFORM(loc_oForm.Width) + "  Height=" + TRANSFORM(loc_oForm.Height) + ;
                 "  FontBold=" + TRANSFORM(loc_oForm.FontBold) + "  ControlCount=" + TRANSFORM(loc_oForm.ControlCount))
        LogProbe("")
        LogProbe("--- TabIndex (SCX Command1=2 < Command2=3 -> 1 < 2) ---")
        LogProbe("    btn_4c_Processar.TabIndex = " + TRANSFORM(loc_oForm.btn_4c_Processar.TabIndex))
        LogProbe("    btn_4c_Encerrar.TabIndex  = " + TRANSFORM(loc_oForm.btn_4c_Encerrar.TabIndex))
        LogProbe("")
        LogProbe("--- Botoes: Left/Top/FontName (SCX grupo Left=345 Top=-2) ---")
        LogProbe("    Processar Left=" + TRANSFORM(loc_oForm.btn_4c_Processar.Left) + ;
                 " Top=" + TRANSFORM(loc_oForm.btn_4c_Processar.Top) + ;
                 " FontName=[" + loc_oForm.btn_4c_Processar.FontName + "]" + ;
                 " Visible=" + TRANSFORM(loc_oForm.btn_4c_Processar.Visible))
        LogProbe("    Encerrar  Left=" + TRANSFORM(loc_oForm.btn_4c_Encerrar.Left) + ;
                 " Top=" + TRANSFORM(loc_oForm.btn_4c_Encerrar.Top) + ;
                 " FontName=[" + loc_oForm.btn_4c_Encerrar.FontName + "]" + ;
                 " Visible=" + TRANSFORM(loc_oForm.btn_4c_Encerrar.Visible))
        LogProbe("    Encerrar direita = " + TRANSFORM(loc_oForm.btn_4c_Encerrar.Left + loc_oForm.btn_4c_Encerrar.Width) + ;
                 "  (Form.Width=" + TRANSFORM(loc_oForm.Width) + ")")
        LogProbe("")
        LogProbe("--- Cabecalho (SCX cntSombra Top=0 Left=0) ---")
        LogProbe("    cnt_4c_Cabecalho Top=" + TRANSFORM(loc_oForm.cnt_4c_Cabecalho.Top) + ;
                 " Left=" + TRANSFORM(loc_oForm.cnt_4c_Cabecalho.Left) + ;
                 " Width=" + TRANSFORM(loc_oForm.cnt_4c_Cabecalho.Width) + ;
                 " Height=" + TRANSFORM(loc_oForm.cnt_4c_Cabecalho.Height))
        LogProbe("    lbl_4c_Sombra Rotation=" + TRANSFORM(loc_oForm.cnt_4c_Cabecalho.lbl_4c_Sombra.Rotation) + ;
                 " Caption=[" + loc_oForm.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption + "]")
        LogProbe("    lbl_4c_Titulo Rotation=" + TRANSFORM(loc_oForm.cnt_4c_Cabecalho.lbl_4c_Titulo.Rotation) + ;
                 " Caption=[" + loc_oForm.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption + "]")
        LogProbe("")
        LogProbe("--- Labels de rodape ---")
        LogProbe("    lbl_4c_Info   Left=" + TRANSFORM(loc_oForm.lbl_4c_Info.Left) + ;
                 " Top=" + TRANSFORM(loc_oForm.lbl_4c_Info.Top) + ;
                 " Caption=[" + loc_oForm.lbl_4c_Info.Caption + "]")
        LogProbe("    lbl_4c_Status Left=" + TRANSFORM(loc_oForm.lbl_4c_Status.Left) + ;
                 " Top=" + TRANSFORM(loc_oForm.lbl_4c_Status.Top) + ;
                 " Caption=[" + loc_oForm.lbl_4c_Status.Caption + "]")
        LogProbe("")
        LogProbe("--- Metodos que o harness chama de FORA (tem de ser PUBLIC) ---")
        loc_oForm.CarregarLista()
        LogProbe("    CarregarLista() .......... OK")
        loc_oForm.AlternarPagina(1)
        LogProbe("    AlternarPagina(1) ........ OK")
        loc_oForm.AjustarBotoesPorModo()
        LogProbe("    AjustarBotoesPorModo() ... OK")
        loc_oForm.BtnCancelarClick()
        LogProbe("    BtnCancelarClick() ....... OK")

        loc_oForm = .NULL.
        LogProbe("")
        LogProbe("FIM OK")
    ENDIF
CATCH TO loc_oErro
    LogProbe("EXCECAO: " + loc_oErro.Message + "  LN=" + TRANSFORM(loc_oErro.LineNo) + ;
             "  PROC=" + loc_oErro.Procedure)
ENDTRY

QUIT

PROCEDURE LogProbe(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gc_4c_LogProbe, 1)
ENDPROC
