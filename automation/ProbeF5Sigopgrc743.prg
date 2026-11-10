* ProbeF5Sigopgrc743.prg
* Prova a Fase 5 do FormSIGOPGRC: instancia o form (sem pai, sem Show - a tela
* eh WindowType = 1 e o Show BLOQUEIA) e le os observaveis dos dois objetos
* criados nesta fase (shp_4c_Shape2 e obj_4c_OleGrafico) mais os TabIndex
* efetivos de AjustarOrdemTabulacao.
* NAO chama ConfigurarAmbiente() - ela nao retorna nesta maquina.
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cOut, loc_oForm, loc_oErro, loc_nI
loc_cOut = "C:\4c\automation\probe_f5_sigopgrc743_resultado.txt"
STRTOFILE("[1] inicio" + CHR(13) + CHR(10), loc_cOut)

DO LOCFILE("C:\4c\projeto\app\start\config.prg")
STRTOFILE("[2] config.prg OK" + CHR(13) + CHR(10), loc_cOut, 1)

PUBLIC gnConnHandle, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI
gnConnHandle           = 0
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe_f5_sigopgrc743_dialogs.txt"
gb_4c_ValidandoUI      = .T.
STRTOFILE("", gc_4c_ArquivoErroTeste)

SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
             "," + gcCaminhoForms + "," + gcCaminhoIcones)
SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "SIGOPGRCBO.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSIGOPGRC.prg") ADDITIVE
STRTOFILE("[3] SET PROCEDURE OK" + CHR(13) + CHR(10), loc_cOut, 1)

loc_oForm = .NULL.
TRY
    loc_oForm = CREATEOBJECT("FormSIGOPGRC")
CATCH TO loc_oErro
    STRTOFILE("[X] CREATEOBJECT estourou: " + loc_oErro.Message + ;
        " LN=" + TRANSFORM(loc_oErro.LineNo) + CHR(13) + CHR(10), loc_cOut, 1)
ENDTRY

STRTOFILE("[4] VARTYPE(form) = " + VARTYPE(loc_oForm) + CHR(13) + CHR(10), loc_cOut, 1)

IF VARTYPE(loc_oForm) = "O"
    STRTOFILE("FORM BaseClass=" + loc_oForm.BaseClass + ;
        " Caption=[" + loc_oForm.Caption + "]" + ;
        " W=" + TRANSFORM(loc_oForm.Width) + " H=" + TRANSFORM(loc_oForm.Height) + ;
        " ControlCount=" + TRANSFORM(loc_oForm.ControlCount) + CHR(13) + CHR(10), loc_cOut, 1)

    *-- Ordem de CRIACAO (z-order) - o Shape tem de vir ANTES dos 2 botoes
    FOR loc_nI = 1 TO loc_oForm.ControlCount
        STRTOFILE("  filho " + TRANSFORM(loc_nI) + ": " + ;
            loc_oForm.Controls(loc_nI).Name + " (" + ;
            loc_oForm.Controls(loc_nI).BaseClass + ")" + CHR(13) + CHR(10), loc_cOut, 1)
    ENDFOR

    *-- shp_4c_Shape2
    IF PEMSTATUS(loc_oForm, "shp_4c_Shape2", 5)
        WITH loc_oForm.shp_4c_Shape2
            STRTOFILE("SHAPE    Top=" + TRANSFORM(.Top) + " Left=" + TRANSFORM(.Left) + ;
                " W=" + TRANSFORM(.Width) + " H=" + TRANSFORM(.Height) + ;
                " BackStyle=" + TRANSFORM(.BackStyle) + ;
                " BorderStyle=" + TRANSFORM(.BorderStyle) + ;
                " BorderColor=" + TRANSFORM(.BorderColor) + ;
                " Visible=" + TRANSFORM(.Visible) + ;
                " dir=" + TRANSFORM(.Left + .Width) + ;
                " baixo=" + TRANSFORM(.Top + .Height) + ;
                " temTabIndex=" + TRANSFORM(PEMSTATUS(loc_oForm.shp_4c_Shape2, "TabIndex", 5)) + ;
                CHR(13) + CHR(10), loc_cOut, 1)
        ENDWITH
    ELSE
        STRTOFILE("[X] shp_4c_Shape2 AUSENTE" + CHR(13) + CHR(10), loc_cOut, 1)
    ENDIF

    *-- obj_4c_OleGrafico
    IF PEMSTATUS(loc_oForm, "obj_4c_OleGrafico", 5)
        WITH loc_oForm.obj_4c_OleGrafico
            STRTOFILE("OLE      Top=" + TRANSFORM(.Top) + " Left=" + TRANSFORM(.Left) + ;
                " W=" + TRANSFORM(.Width) + " H=" + TRANSFORM(.Height) + ;
                " Enabled=" + TRANSFORM(.Enabled) + ;
                " AutoActivate=" + TRANSFORM(.AutoActivate) + ;
                " ControlSource=[" + TRANSFORM(.ControlSource) + "]" + ;
                " Visible=" + TRANSFORM(.Visible) + ;
                " BaseClass=" + .BaseClass + ;
                " dir=" + TRANSFORM(.Left + .Width) + ;
                " baixo=" + TRANSFORM(.Top + .Height) + ;
                CHR(13) + CHR(10), loc_cOut, 1)
        ENDWITH
    ELSE
        STRTOFILE("[X] obj_4c_OleGrafico AUSENTE" + CHR(13) + CHR(10), loc_cOut, 1)
    ENDIF

    *-- TabIndex efetivos (AjustarOrdemTabulacao): 1,2,3,4 e UNICOS
    STRTOFILE("TABINDEX cnt_4c_Sombra="     + TRANSFORM(loc_oForm.cnt_4c_Sombra.TabIndex) + ;
        " obj_4c_OleGrafico=" + TRANSFORM(loc_oForm.obj_4c_OleGrafico.TabIndex) + ;
        " cmd_4c_Sair="       + TRANSFORM(loc_oForm.cmd_4c_Sair.TabIndex) + ;
        " cmd_4c_Imprimir="   + TRANSFORM(loc_oForm.cmd_4c_Imprimir.TabIndex) + ;
        CHR(13) + CHR(10), loc_cOut, 1)

    *-- Nenhum controle pode ter sido recortado pelo form (regra #30)
    STRTOFILE("CABE? shape_dir<=800:" + ;
        TRANSFORM(loc_oForm.shp_4c_Shape2.Left + loc_oForm.shp_4c_Shape2.Width <= loc_oForm.Width) + ;
        " ole_dir<=800:" + ;
        TRANSFORM(loc_oForm.obj_4c_OleGrafico.Left + loc_oForm.obj_4c_OleGrafico.Width <= loc_oForm.Width) + ;
        " ole_baixo<=600:" + ;
        TRANSFORM(loc_oForm.obj_4c_OleGrafico.Top + loc_oForm.obj_4c_OleGrafico.Height <= loc_oForm.Height) + ;
        " ole_abaixo_da_faixa(Top>=80):" + ;
        TRANSFORM(loc_oForm.obj_4c_OleGrafico.Top >= 80) + ;
        CHR(13) + CHR(10), loc_cOut, 1)

    loc_oForm.Release()
    loc_oForm = .NULL.
ENDIF

STRTOFILE("[5] FIM" + CHR(13) + CHR(10), loc_cOut, 1)
QUIT
