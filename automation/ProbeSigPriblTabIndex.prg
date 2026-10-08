*==============================================================================
* ProbeSigPriblTabIndex.prg - Fase 5 do FormSIGPRIBL (task623).
* Prova que (a) o form INSTANCIA, (b) ConfigurarPaginaDados aplica o TabIndex
* transcrito do SCX e (c) as propriedades novas (Format "K", BorderColor,
* AutoSize/BorderStyle dos labels) existem nas classes e foram gravadas.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_pribl.txt"

LOCAL loc_oForm, loc_oErro, loc_cLog
loc_cLog = "C:\4c\automation\logs\probe_sigpribl_tabindex.txt"
IF FILE(loc_cLog)
    DELETE FILE (loc_cLog)
ENDIF

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
                 "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")      ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbuscaauxiliar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")         ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SIGPRIBLBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSIGPRIBL.prg") ADDITIVE
    PUBLIC gb_4c_ValidandoUI
    gb_4c_ValidandoUI = .T.
    STRTOFILE("0 SETUP OK" + CHR(13) + CHR(10), loc_cLog)
CATCH TO loc_oErro
    STRTOFILE("0 SETUP FALHOU: " + loc_oErro.Message + CHR(13) + CHR(10), loc_cLog)
ENDTRY

TRY
    loc_oForm = CREATEOBJECT("FormSIGPRIBL")
    IF VARTYPE(loc_oForm) = "O"
        STRTOFILE("1 INSTANCIOU OK  Caption=[" + loc_oForm.Caption + "]" + CHR(13) + CHR(10), loc_cLog, 1)

        *-- TabIndex efetivamente gravado
        STRTOFILE("2 TABINDEX  Label2=" + TRANSFORM(loc_oForm.lbl_4c_Label2.TabIndex) + ;
            "  FPags=" + TRANSFORM(loc_oForm.txt_4c_FPags.TabIndex) + ;
            "  Label3=" + TRANSFORM(loc_oForm.lbl_4c_Label3.TabIndex) + ;
            "  Locals=" + TRANSFORM(loc_oForm.txt_4c_Locals.TabIndex) + ;
            "  Label31=" + TRANSFORM(loc_oForm.lbl_4c_Label31.TabIndex) + ;
            "  TxtCds=" + TRANSFORM(loc_oForm.obj_4c_GetTxtCds.TabIndex) + ;
            "  LblAviso=" + TRANSFORM(loc_oForm.lbl_4c_LblAviso.TabIndex) + ;
            "  CmdG=" + TRANSFORM(loc_oForm.obj_4c_CmdGImprimir.TabIndex) + CHR(13) + CHR(10), loc_cLog, 1)

        *-- propriedades novas
        STRTOFILE("3 Locals.Format=[" + loc_oForm.txt_4c_Locals.Format + "]" + ;
            "  CmdG.BorderColor=" + TRANSFORM(loc_oForm.obj_4c_CmdGImprimir.BorderColor) + ;
            "  (esperado " + TRANSFORM(RGB(136,189,188)) + ")" + CHR(13) + CHR(10), loc_cLog, 1)

        STRTOFILE("4 LABELS AutoSize/BorderStyle/Width/Height" + ;
            "  Label2=" + TRANSFORM(loc_oForm.lbl_4c_Label2.AutoSize) + "/" + TRANSFORM(loc_oForm.lbl_4c_Label2.BorderStyle) + "/" + TRANSFORM(loc_oForm.lbl_4c_Label2.Width) + "/" + TRANSFORM(loc_oForm.lbl_4c_Label2.Height) + ;
            "  Label3=" + TRANSFORM(loc_oForm.lbl_4c_Label3.AutoSize) + "/" + TRANSFORM(loc_oForm.lbl_4c_Label3.BorderStyle) + "/" + TRANSFORM(loc_oForm.lbl_4c_Label3.Width) + "/" + TRANSFORM(loc_oForm.lbl_4c_Label3.Height) + ;
            "  Label31=" + TRANSFORM(loc_oForm.lbl_4c_Label31.AutoSize) + "/" + TRANSFORM(loc_oForm.lbl_4c_Label31.BorderStyle) + "/" + TRANSFORM(loc_oForm.lbl_4c_Label31.Width) + "/" + TRANSFORM(loc_oForm.lbl_4c_Label31.Height) + ;
            "  LblAviso=" + TRANSFORM(loc_oForm.lbl_4c_LblAviso.AutoSize) + "/" + TRANSFORM(loc_oForm.lbl_4c_LblAviso.BorderStyle) + "/" + TRANSFORM(loc_oForm.lbl_4c_LblAviso.Width) + "/" + TRANSFORM(loc_oForm.lbl_4c_LblAviso.Height) + CHR(13) + CHR(10), loc_cLog, 1)

        *-- metodos exigidos PUBLIC pela regra #3 (chamados de FORA da classe)
        STRTOFILE("5 PUBLIC CarregarLista=" + TRANSFORM(PEMSTATUS(loc_oForm, "CarregarLista", 5)) + ;
            "  AjustarBotoesPorModo=" + TRANSFORM(PEMSTATUS(loc_oForm, "AjustarBotoesPorModo", 5)) + ;
            "  ConfigurarPaginaDados=" + TRANSFORM(PEMSTATUS(loc_oForm, "ConfigurarPaginaDados", 5)) + CHR(13) + CHR(10), loc_cLog, 1)

        *-- chamada REAL de fora da classe (PEMSTATUS nao prova escopo)
        TRY
            loc_oForm.AjustarBotoesPorModo("LISTA")
            STRTOFILE("6 AjustarBotoesPorModo chamado de FORA: OK" + CHR(13) + CHR(10), loc_cLog, 1)
        CATCH TO loc_oErro
            STRTOFILE("6 AjustarBotoesPorModo FALHOU: " + loc_oErro.Message + CHR(13) + CHR(10), loc_cLog, 1)
        ENDTRY

        TRY
            loc_oForm.ConfigurarPaginaDados()
            STRTOFILE("7 ConfigurarPaginaDados chamado de FORA: OK" + CHR(13) + CHR(10), loc_cLog, 1)
        CATCH TO loc_oErro
            STRTOFILE("7 ConfigurarPaginaDados FALHOU: " + loc_oErro.Message + CHR(13) + CHR(10), loc_cLog, 1)
        ENDTRY

        loc_oForm.Release()
    ELSE
        STRTOFILE("1 INSTANCIOU FALHOU: VARTYPE=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10), loc_cLog, 1)
    ENDIF
CATCH TO loc_oErro
    STRTOFILE("1 EXCECAO: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
        " PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10), loc_cLog, 1)
ENDTRY

QUIT
