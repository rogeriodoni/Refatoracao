* ProbeF4SigOpVda817.prg
* Instancia FormSigOpVda (Fase 4) e grava o estado da grade + botoes num TXT.
* NAO roda config.prg: o SQL Server do ambiente nao esta acessivel nesta
* maquina. Nesta fase InicializarForm nao faz SQL nenhum (so monta a casca
* visual), entao nao precisa de gb_4c_ValidandoUI/gnConnHandle para nao
* travar.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gc_4c_CaminhoFramework, gc_4c_CaminhoIcones, gc_4c_ArquivoErroTeste
gc_4c_CaminhoFramework = "C:\4c\Framework\"
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gc_4c_ArquivoErroTeste = "C:\4c\automation\_erro_f4_sigopvda817.txt"

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cSaida, loc_oForm, loc_oErro, loc_oGrid
loc_cSaida = ""

TRY
    SET PROCEDURE TO "C:\4c\projeto\app\utils\messages.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\utils\functions.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\dataaccess.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\businessbase.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\formbase.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\SigOpVdaBO.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\FormSigOpVda.prg" ADDITIVE

    loc_oForm = CREATEOBJECT("FormSigOpVda")

    IF VARTYPE(loc_oForm) = "O"
        loc_cSaida = "OK: FormSigOpVda instanciado" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "ControlCount=[" + TRANSFORM(loc_oForm.ControlCount) + "]" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "cursor_4c_Operacoes USED=[" + TRANSFORM(USED("cursor_4c_Operacoes")) + "]" + CHR(13) + CHR(10)

        IF PEMSTATUS(loc_oForm, "cnt_4c_Grade", 5)
            loc_cSaida = loc_cSaida + "cnt_4c_Grade: Visible=[" + TRANSFORM(loc_oForm.cnt_4c_Grade.Visible) + ;
                "] Top=[" + TRANSFORM(loc_oForm.cnt_4c_Grade.Top) + ;
                "] Left=[" + TRANSFORM(loc_oForm.cnt_4c_Grade.Left) + ;
                "] Width=[" + TRANSFORM(loc_oForm.cnt_4c_Grade.Width) + ;
                "] Height=[" + TRANSFORM(loc_oForm.cnt_4c_Grade.Height) + "]" + CHR(13) + CHR(10)

            IF PEMSTATUS(loc_oForm.cnt_4c_Grade, "grd_4c_Dados", 5)
                loc_oGrid = loc_oForm.cnt_4c_Grade.grd_4c_Dados
                loc_cSaida = loc_cSaida + "grd_4c_Dados: Visible=[" + TRANSFORM(loc_oGrid.Visible) + ;
                    "] ColumnCount=[" + TRANSFORM(loc_oGrid.ColumnCount) + ;
                    "] RecordSource=[" + loc_oGrid.RecordSource + "]" + CHR(13) + CHR(10)

                loc_cSaida = loc_cSaida + "Column1 (SelImp): Width=[" + TRANSFORM(loc_oGrid.Column1.Width) + ;
                    "] ReadOnly=[" + TRANSFORM(loc_oGrid.Column1.ReadOnly) + ;
                    "] CurrentControl=[" + loc_oGrid.Column1.CurrentControl + ;
                    "] Check1.Visible=[" + TRANSFORM(loc_oGrid.Column1.Check1.Visible) + ;
                    "] ControlSource=[" + loc_oGrid.Column1.ControlSource + "]" + CHR(13) + CHR(10)

                loc_cSaida = loc_cSaida + "Column2 (Data): Width=[" + TRANSFORM(loc_oGrid.Column2.Width) + ;
                    "] ReadOnly=[" + TRANSFORM(loc_oGrid.Column2.ReadOnly) + ;
                    "] Header=[" + loc_oGrid.Column2.Header1.Caption + ;
                    "] ControlSource=[" + loc_oGrid.Column2.ControlSource + "]" + CHR(13) + CHR(10)

                loc_cSaida = loc_cSaida + "Column7 (Parcelas): Header=[" + loc_oGrid.Column7.Header1.Caption + ;
                    "] ControlSource=[" + loc_oGrid.Column7.ControlSource + "]" + CHR(13) + CHR(10)

                loc_cSaida = loc_cSaida + "Column13 (Codigo): Header=[" + loc_oGrid.Column13.Header1.Caption + ;
                    "] ControlSource=[" + loc_oGrid.Column13.ControlSource + "]" + CHR(13) + CHR(10)
            ELSE
                loc_cSaida = loc_cSaida + "FALHA: grd_4c_Dados nao existe" + CHR(13) + CHR(10)
            ENDIF
        ELSE
            loc_cSaida = loc_cSaida + "FALHA: cnt_4c_Grade nao existe" + CHR(13) + CHR(10)
        ENDIF

        IF PEMSTATUS(loc_oForm, "obj_4c_CmdBtnGrade", 5)
            loc_cSaida = loc_cSaida + "obj_4c_CmdBtnGrade: Visible=[" + TRANSFORM(loc_oForm.obj_4c_CmdBtnGrade.Visible) + ;
                "] ButtonCount=[" + TRANSFORM(loc_oForm.obj_4c_CmdBtnGrade.ButtonCount) + ;
                "] Left=[" + TRANSFORM(loc_oForm.obj_4c_CmdBtnGrade.Left) + ;
                "] Buttons(1).ToolTipText=[" + loc_oForm.obj_4c_CmdBtnGrade.Buttons(1).ToolTipText + "]" + CHR(13) + CHR(10)
        ELSE
            loc_cSaida = loc_cSaida + "FALHA: obj_4c_CmdBtnGrade nao existe" + CHR(13) + CHR(10)
        ENDIF

        IF PEMSTATUS(loc_oForm, "obj_4c_CmdBtnForm", 5)
            loc_cSaida = loc_cSaida + "obj_4c_CmdBtnForm: Visible=[" + TRANSFORM(loc_oForm.obj_4c_CmdBtnForm.Visible) + ;
                "] ButtonCount=[" + TRANSFORM(loc_oForm.obj_4c_CmdBtnForm.ButtonCount) + ;
                "] Left=[" + TRANSFORM(loc_oForm.obj_4c_CmdBtnForm.Left) + ;
                "] Buttons(3).Caption=[" + loc_oForm.obj_4c_CmdBtnForm.Buttons(3).Caption + "]" + CHR(13) + CHR(10)
        ELSE
            loc_cSaida = loc_cSaida + "FALHA: obj_4c_CmdBtnForm nao existe" + CHR(13) + CHR(10)
        ENDIF

        IF PEMSTATUS(loc_oForm, "cmd_4c_CmdSelecionar", 5)
            loc_cSaida = loc_cSaida + "cmd_4c_CmdSelecionar: Visible=[" + TRANSFORM(loc_oForm.cmd_4c_CmdSelecionar.Visible) + ;
                "] Left=[" + TRANSFORM(loc_oForm.cmd_4c_CmdSelecionar.Left) + ;
                "] Caption=[" + loc_oForm.cmd_4c_CmdSelecionar.Caption + ;
                "] Themes=[" + TRANSFORM(loc_oForm.cmd_4c_CmdSelecionar.Themes) + "]" + CHR(13) + CHR(10)
        ELSE
            loc_cSaida = loc_cSaida + "FALHA: cmd_4c_CmdSelecionar nao existe" + CHR(13) + CHR(10)
        ENDIF

        loc_oForm.Release()
    ELSE
        loc_cSaida = "FALHA: CREATEOBJECT devolveu " + VARTYPE(loc_oForm) + CHR(13) + CHR(10)
    ENDIF
CATCH TO loc_oErro
    loc_cSaida = loc_cSaida + "ERRO: " + loc_oErro.Message + " | LN=" + ;
        TRANSFORM(loc_oErro.LineNo) + " | PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(loc_cSaida, "C:\4c\automation\probe_f4_sigopvda817.txt")

QUIT
