*==============================================================================
* probar_form_fase4.prg - Prova que FormSIGOPNOP (Fase 4) INSTANCIA de verdade
* e que o conteudo dos containers + controles soltos existem.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcSaida, loForm, loErro, lcArqSaida
lcArqSaida = "C:\4c\tasks\task772\probar_form_fase4_resultado.txt"
lcSaida    = "M1 inicio" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcArqSaida)

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste         = .T.
gb_4c_ValidandoUI       = .T.
gc_4c_ArquivoErroTeste  = "C:\4c\tasks\task772\probar_form_fase4_erros.txt"

CD C:\4c\projeto\app\start
DO config.prg
ConfigurarAmbiente()

lcSaida = lcSaida + "M2 ambiente configurado" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcArqSaida)

GarantirClasse("FormSIGOPNOP")
lcSaida = lcSaida + "M3 GarantirClasse ok" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcArqSaida)

loForm = .NULL.
TRY
    loForm = CREATEOBJECT("FormSIGOPNOP")
    lcSaida = lcSaida + "CREATEOBJECT VARTYPE=" + VARTYPE(loForm) + CHR(13) + CHR(10)
CATCH TO loErro
    lcSaida = lcSaida + "EXCECAO: " + loErro.Message + ;
              " | Linha: " + TRANSFORM(loErro.LineNo) + ;
              " | Procedure: " + loErro.Procedure + CHR(13) + CHR(10)
ENDTRY
STRTOFILE(lcSaida, lcArqSaida)

IF VARTYPE(loForm) = "O"
    lcSaida = lcSaida + "Caption=[" + loForm.Caption + "]" + CHR(13) + CHR(10)
    lcSaida = lcSaida + "ControlCount=" + TRANSFORM(loForm.ControlCount) + CHR(13) + CHR(10)

    *-- Container1: TreeView (pode estar ausente - OCX nao registrado) + labels + textboxes
    IF PEMSTATUS(loForm, "cnt_4c_Container1", 5)
        WITH loForm.cnt_4c_Container1
            lcSaida = lcSaida + "Container1.ControlCount=" + TRANSFORM(.ControlCount) + CHR(13) + CHR(10)
            lcSaida = lcSaida + "obj_4c_TreeView presente=" + TRANSFORM(PEMSTATUS(loForm.cnt_4c_Container1, "obj_4c_TreeView", 5)) + CHR(13) + CHR(10)
            IF PEMSTATUS(.lbl_4c_Label3, "Caption", 5)
                lcSaida = lcSaida + "lbl_4c_Label3.Caption=[" + .lbl_4c_Label3.Caption + "] Visible=" + TRANSFORM(.lbl_4c_Label3.Visible) + CHR(13) + CHR(10)
            ENDIF
            IF PEMSTATUS(.lbl_4c_Label1, "Caption", 5)
                lcSaida = lcSaida + "lbl_4c_Label1.Caption=[" + .lbl_4c_Label1.Caption + "] Visible=" + TRANSFORM(.lbl_4c_Label1.Visible) + CHR(13) + CHR(10)
            ENDIF
            IF PEMSTATUS(.txt_4c_OP, "Value", 5)
                lcSaida = lcSaida + "txt_4c_OP.Value=" + TRANSFORM(.txt_4c_OP.Value) + " Visible=" + TRANSFORM(.txt_4c_OP.Visible) + " Enabled=" + TRANSFORM(.txt_4c_OP.Enabled) + CHR(13) + CHR(10)
            ELSE
                lcSaida = lcSaida + "txt_4c_OP: AUSENTE" + CHR(13) + CHR(10)
            ENDIF
            IF PEMSTATUS(.txt_4c_Envelope, "Value", 5)
                lcSaida = lcSaida + "txt_4c_Envelope.Value=" + TRANSFORM(.txt_4c_Envelope.Value) + " Visible=" + TRANSFORM(.txt_4c_Envelope.Visible) + CHR(13) + CHR(10)
            ELSE
                lcSaida = lcSaida + "txt_4c_Envelope: AUSENTE" + CHR(13) + CHR(10)
            ENDIF
        ENDWITH
    ELSE
        lcSaida = lcSaida + "cnt_4c_Container1: AUSENTE" + CHR(13) + CHR(10)
    ENDIF

    *-- Container2: deve continuar invisivel (painel AGUARDE), mas com filhos visiveis
    IF PEMSTATUS(loForm, "cnt_4c_Container2", 5)
        WITH loForm.cnt_4c_Container2
            lcSaida = lcSaida + "Container2.Visible=" + TRANSFORM(.Visible) + " ControlCount=" + TRANSFORM(.ControlCount) + CHR(13) + CHR(10)
            IF PEMSTATUS(.lbl_4c_Label1, "Caption", 5)
                lcSaida = lcSaida + "Container2.lbl_4c_Label1.Caption=[" + .lbl_4c_Label1.Caption + "] Visible=" + TRANSFORM(.lbl_4c_Label1.Visible) + CHR(13) + CHR(10)
            ENDIF
            IF PEMSTATUS(.lbl_4c_Label2, "Caption", 5)
                lcSaida = lcSaida + "Container2.lbl_4c_Label2.Caption=[" + .lbl_4c_Label2.Caption + "] Visible=" + TRANSFORM(.lbl_4c_Label2.Visible) + CHR(13) + CHR(10)
            ENDIF
        ENDWITH
    ELSE
        lcSaida = lcSaida + "cnt_4c_Container2: AUSENTE" + CHR(13) + CHR(10)
    ENDIF

    *-- Controles soltos na Form
    IF PEMSTATUS(loForm, "cmg_4c_Commandgroup1", 5)
        lcSaida = lcSaida + "cmg_4c_Commandgroup1.ButtonCount=" + TRANSFORM(loForm.cmg_4c_Commandgroup1.ButtonCount) + ;
                  " Buttons(1).Caption=[" + loForm.cmg_4c_Commandgroup1.Buttons(1).Caption + "]" + ;
                  " Visible=" + TRANSFORM(loForm.cmg_4c_Commandgroup1.Visible) + CHR(13) + CHR(10)
    ELSE
        lcSaida = lcSaida + "cmg_4c_Commandgroup1: AUSENTE" + CHR(13) + CHR(10)
    ENDIF

    IF PEMSTATUS(loForm, "cmd_4c_Fwbtng1", 5)
        lcSaida = lcSaida + "cmd_4c_Fwbtng1.ToolTipText=[" + loForm.cmd_4c_Fwbtng1.ToolTipText + "] Visible=" + TRANSFORM(loForm.cmd_4c_Fwbtng1.Visible) + CHR(13) + CHR(10)
    ELSE
        lcSaida = lcSaida + "cmd_4c_Fwbtng1: AUSENTE" + CHR(13) + CHR(10)
    ENDIF

    IF PEMSTATUS(loForm, "cmd_4c_Fwbtng2", 5)
        lcSaida = lcSaida + "cmd_4c_Fwbtng2.ToolTipText=[" + loForm.cmd_4c_Fwbtng2.ToolTipText + "] Visible=" + TRANSFORM(loForm.cmd_4c_Fwbtng2.Visible) + CHR(13) + CHR(10)
    ELSE
        lcSaida = lcSaida + "cmd_4c_Fwbtng2: AUSENTE" + CHR(13) + CHR(10)
    ENDIF

    IF PEMSTATUS(loForm, "img_4c_Imagem", 5)
        lcSaida = lcSaida + "img_4c_Imagem.Visible=" + TRANSFORM(loForm.img_4c_Imagem.Visible) + " (esperado .F.)" + CHR(13) + CHR(10)
    ELSE
        lcSaida = lcSaida + "img_4c_Imagem: AUSENTE" + CHR(13) + CHR(10)
    ENDIF

    lcSaida = lcSaida + "BO VARTYPE=" + VARTYPE(loForm.this_oBusinessObject) + CHR(13) + CHR(10)
    lcSaida = lcSaida + "RESULTADO=INSTANCIOU" + CHR(13) + CHR(10)
    loForm.Release()
ELSE
    lcSaida = lcSaida + "RESULTADO=NAO INSTANCIOU" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(lcSaida, lcArqSaida)
QUIT
