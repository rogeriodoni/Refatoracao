*-- Probe Fase 8 (parte B) - prova que FormParaBO() roda no caminho de confirmar:
*-- muda o chk_4c_Pular na TELA, aciona BtnConfirmarClick e le a property do BO.
SET SAFETY OFF
SET RESOURCE OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_f8_752_probe_confirmar_dialogs.txt"
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
    loForm = CREATEOBJECT("FormSIGOPins", "", "GRP", "Finalidades do Grupo")

    IF VARTYPE(loForm) = "O"
        *-- Estado do cursor do CHAMADOR que o fluxo GRP precisa. Criado aqui
        *-- porque num uso real ele chega aberto do formulario que abriu a tela.
        CREATE CURSOR crSigOpFnl (operacao C(3), codigos N(3,0), ;
            codutil C(10), cidchaves C(20), empdopnums C(29))
        CREATE CURSOR crSigCdGrp (cgrus C(3))
        INSERT INTO crSigCdGrp (cgrus) VALUES ("001")

        *-- Uma observacao marcada, para o Scan do legado ter o que gravar
        SELECT cursor_4c_Lista
        APPEND BLANK
        REPLACE selecao WITH 1, codigos WITH 7, ;
                observas WITH "OBS SETE", descrs WITH "OBS SETE"

        lcOut = lcOut + "--- ANTES ---" + CHR(13) + CHR(10)
        lcOut = lcOut + "chkPular(tela)      = " + ;
            TRANSFORM(loForm.chk_4c_Pular.Value) + CHR(13) + CHR(10)
        lcOut = lcOut + "BO.this_lPularLinhas= " + ;
            TRANSFORM(loForm.this_oBusinessObject.this_lPularLinhas) + CHR(13) + CHR(10)

        *-- O usuario DESMARCA "Pular Linhas" na tela
        loForm.chk_4c_Pular.Value = .F.

        loForm.BtnConfirmarClick()

        lcOut = lcOut + "--- DEPOIS do BtnConfirmarClick ---" + CHR(13) + CHR(10)
        lcOut = lcOut + "chkPular(tela)      = " + ;
            TRANSFORM(loForm.chk_4c_Pular.Value) + CHR(13) + CHR(10)
        lcOut = lcOut + "BO.this_lPularLinhas= " + ;
            TRANSFORM(loForm.this_oBusinessObject.this_lPularLinhas) + ;
            "   <-- .F. prova que FormParaBO() rodou" + CHR(13) + CHR(10)
        lcOut = lcOut + "Form.this_lConfirmado  = " + ;
            TRANSFORM(loForm.this_lConfirmado) + CHR(13) + CHR(10)
        lcOut = lcOut + "Form.this_cListaSelec  = [" + ;
            loForm.this_cListaSelecionadas + "]" + CHR(13) + CHR(10)
        lcOut = lcOut + "BO.this_cMensagemFalha = [" + ;
            loForm.this_oBusinessObject.this_cMensagemFalha + "]" + CHR(13) + CHR(10)
        lcOut = lcOut + "crSigOpFnl RECCOUNT    = " + ;
            TRANSFORM(RECCOUNT("crSigOpFnl")) + CHR(13) + CHR(10)
    ENDIF
CATCH TO loErro
    lcOut = lcOut + "EXCECAO: " + loErro.Message + CHR(13) + CHR(10) + ;
        "Linha: " + TRANSFORM(loErro.LineNo) + CHR(13) + CHR(10) + ;
        "Procedure: " + loErro.Procedure + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(lcOut, "C:\4c\automation\_f8_752_probe_confirmar.txt")
QUIT
