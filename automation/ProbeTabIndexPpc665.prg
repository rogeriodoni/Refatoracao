*-- Mede a ORDEM DE TABULACAO real do FormSigPrPpc (task665, Fase 5).
*-- Carrega SO as dependencias do form: ConfigurarAmbiente() BLOQUEIA nesta
*-- maquina (memoria feedback_configurarambiente_bloqueia_probe_de_form).
*-- Par gb_4c_ModoTeste + gc_4c_ArquivoErroTeste obrigatorio, senao MsgErro
*-- cai num MESSAGEBOX real e o probe trava sem produzir arquivo.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_tabppc.txt"
gb_4c_ValidandoUI      = .T.

#DEFINE SAIDA "C:\4c\automation\probe_tabindex_ppc665.txt"

LOCAL loc_oE
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
STRTOFILE("A: inicio" + CHR(13) + CHR(10), SAIDA)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    STRTOFILE("B: config.prg OK" + CHR(13) + CHR(10), SAIDA, 1)

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigPrPpcBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigPrPpc.prg") ADDITIVE
    STRTOFILE("C: deps carregadas" + CHR(13) + CHR(10), SAIDA, 1)

    STRTOFILE(MedirTabOrder() + CHR(13) + CHR(10), SAIDA, 1)
CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + " Linha:" + TRANSFORM(loc_oE.LineNo) + ;
              " Proc:" + loc_oE.Procedure + CHR(13) + CHR(10), SAIDA, 1)
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE("DIALOGOS: " + FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10), SAIDA, 1)
ENDIF
STRTOFILE("Z: fim" + CHR(13) + CHR(10), SAIDA, 1)
QUIT

*------------------------------------------------------------------------------
* Instancia o form e lista os controles focalizaveis ordenados por TabIndex.
* Focalizavel = tem TabStop (Label/Container nao tem - nao param o Tab).
*------------------------------------------------------------------------------
FUNCTION MedirTabOrder()
    LOCAL loc_oForm, loc_cOut, loc_nI, loc_nJ, loc_oCtl, loc_nQtd
    LOCAL ARRAY loc_aFoco[50, 2]

    loc_oForm = CREATEOBJECT("FormSigPrPpc")
    IF VARTYPE(loc_oForm) != "O"
        RETURN "FALHA: nao instanciou (VARTYPE=" + VARTYPE(loc_oForm) + ")"
    ENDIF
    loc_cOut = "Init OK - ControlCount=" + TRANSFORM(loc_oForm.ControlCount) + CHR(13) + CHR(10)

    *-- Coleta os focalizaveis do nivel do Form (os campos moram direto em THIS)
    loc_nQtd = 0
    FOR loc_nI = 1 TO loc_oForm.ControlCount
        loc_oCtl = loc_oForm.Controls(loc_nI)
        IF PEMSTATUS(loc_oCtl, "TabIndex", 5)
            loc_nQtd = loc_nQtd + 1
            loc_aFoco[loc_nQtd, 1] = loc_oCtl.TabIndex
            loc_aFoco[loc_nQtd, 2] = loc_oCtl.Name + " (" + loc_oCtl.BaseClass + ;
                IIF(PEMSTATUS(loc_oCtl, "TabStop", 5), ", focalizavel", ", NAO focalizavel") + ")"
        ENDIF
    ENDFOR

    *-- Ordena por TabIndex (bubble simples: poucos controles)
    LOCAL loc_nTmp, loc_cTmp
    FOR loc_nI = 1 TO loc_nQtd - 1
        FOR loc_nJ = 1 TO loc_nQtd - loc_nI
            IF loc_aFoco[loc_nJ, 1] > loc_aFoco[loc_nJ + 1, 1]
                loc_nTmp = loc_aFoco[loc_nJ, 1]
                loc_cTmp = loc_aFoco[loc_nJ, 2]
                loc_aFoco[loc_nJ, 1] = loc_aFoco[loc_nJ + 1, 1]
                loc_aFoco[loc_nJ, 2] = loc_aFoco[loc_nJ + 1, 2]
                loc_aFoco[loc_nJ + 1, 1] = loc_nTmp
                loc_aFoco[loc_nJ + 1, 2] = loc_cTmp
            ENDIF
        ENDFOR
    ENDFOR

    loc_cOut = loc_cOut + "--- ORDEM DE TABULACAO (TabIndex crescente) ---" + CHR(13) + CHR(10)
    FOR loc_nI = 1 TO loc_nQtd
        loc_cOut = loc_cOut + PADL(TRANSFORM(loc_aFoco[loc_nI, 1]), 3) + " -> " + ;
                   loc_aFoco[loc_nI, 2] + CHR(13) + CHR(10)
    ENDFOR

    *-- Prova pontual: Label tem TabIndex mas nao tem TabStop
    loc_cOut = loc_cOut + "--- CHECK ---" + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "lbl TabStop existe? " + ;
               IIF(PEMSTATUS(loc_oForm.lbl_4c_LblGrupo, "TabStop", 5), "SIM", "NAO") + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "cmg TabStop existe? " + ;
               IIF(PEMSTATUS(loc_oForm.cmg_4c_Operacao, "TabStop", 5), "SIM", "NAO") + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "cmg FontName btn1 = [" + loc_oForm.cmg_4c_Operacao.Buttons(1).FontName + "]" + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "cmg Width x Height = " + TRANSFORM(loc_oForm.cmg_4c_Operacao.Width) + ;
               " x " + TRANSFORM(loc_oForm.cmg_4c_Operacao.Height) + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "btn2 ToolTipText = [" + loc_oForm.cmg_4c_Operacao.Buttons(2).ToolTipText + "]" + CHR(13) + CHR(10)

    loc_oForm.Release()
    RETURN loc_cOut
ENDFUNC
