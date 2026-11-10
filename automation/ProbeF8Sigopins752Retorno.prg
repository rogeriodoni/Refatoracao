*-- Probe Fase 8 (parte C) - fluxo SIGOPINF (pLista informado, pTipo AUSENTE):
*-- prova que this_cListaSelecionadas chega ao chamador no formato ",1,7," e que
*-- o form segue legivel depois do Confirmar (Hide, nao Release).
SET SAFETY OFF
SET RESOURCE OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_f8_752_probe_retorno_dialogs.txt"
gnConnHandle           = 0

LOCAL lcOut, loForm, loErro

lcOut = ""
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
SET PROCEDURE TO (gcCaminhoClasses + "SIGOPinsBO.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSIGOPins.prg") ADDITIVE

TRY
    *-- UM argumento so: pLista informado, pTipo AUSENTE = fluxo SIGOPINF
    loForm = CREATEOBJECT("FormSIGOPins", ",7,")

    IF VARTYPE(loForm) = "O"
        SELECT cursor_4c_Lista
        APPEND BLANK
        REPLACE selecao WITH 1, codigos WITH 7,  observas WITH "OBS SETE",  descrs WITH "SETE"
        APPEND BLANK
        REPLACE selecao WITH 0, codigos WITH 12, observas WITH "OBS DOZE",  descrs WITH "DOZE"
        APPEND BLANK
        REPLACE selecao WITH 1, codigos WITH 23, observas WITH "OBS VINTE", descrs WITH "VINTE"

        loForm.BtnConfirmarClick()

        lcOut = lcOut + "VARTYPE(loForm) pos-Confirmar = " + VARTYPE(loForm) + ;
            "   <-- O prova Hide() (nao Release)" + CHR(13) + CHR(10)
        lcOut = lcOut + "this_lConfirmado              = " + ;
            TRANSFORM(loForm.this_lConfirmado) + CHR(13) + CHR(10)
        lcOut = lcOut + "this_cListaSelecionadas       = [" + ;
            loForm.this_cListaSelecionadas + "]   <-- esperado [,7,23,]" + CHR(13) + CHR(10)
        lcOut = lcOut + "Form.Visible                  = " + ;
            TRANSFORM(loForm.Visible) + CHR(13) + CHR(10)

        *-- O CHAMADOR eh quem libera, apos ler
        loForm.Release()
        lcOut = lcOut + "VARTYPE(loForm) pos-Release   = " + VARTYPE(loForm) + ;
            "   <-- X prova que o chamador encerra o objeto" + CHR(13) + CHR(10)
        lcOut = lcOut + "cursor_4c_Lista aberto        = " + ;
            TRANSFORM(USED("cursor_4c_Lista")) + ;
            "   <-- .F. prova que o Destroy fechou os cursores" + CHR(13) + CHR(10)
    ENDIF
CATCH TO loErro
    lcOut = lcOut + "EXCECAO: " + loErro.Message + CHR(13) + CHR(10) + ;
        "Linha: " + TRANSFORM(loErro.LineNo) + CHR(13) + CHR(10) + ;
        "Procedure: " + loErro.Procedure + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(lcOut, "C:\4c\automation\_f8_752_probe_retorno.txt")
QUIT
