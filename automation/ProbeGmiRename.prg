*==============================================================================
* ProbeGmiRename.prg - prova que FormSigPrGmi INSTANCIA depois da renomeacao
* cmd_4c_Cancela -> cmd_4c_Encerrar / BtnCancelaClick -> BtnEncerrarClick.
* Grava CHECKPOINT a cada etapa com STRTOFILE (grava e fecha na hora, logo
* sobrevive a morte do processo e localiza onde travou).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe_gmi_dialogos.txt"

LOCAL lcOut, loc_oForm, loc_oErro
lcOut = "C:\4c\automation\probe_gmi_rename.txt"
STRTOFILE("CP1 inicio" + CHR(13) + CHR(10), lcOut)

CD C:\4c\projeto\app\start
DO config.prg
STRTOFILE("CP2 config ok" + CHR(13) + CHR(10), lcOut, 1)

SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + ;
             gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + ;
             gc_4c_CaminhoIcones)
SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "FormErro.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "SigPrGmiBO.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\FormSigPrGmi.prg") ADDITIVE
gb_4c_ValidandoUI = .T.
STRTOFILE("CP3 procedures ok" + CHR(13) + CHR(10), lcOut, 1)

TRY
    loc_oForm = CREATEOBJECT("FormSigPrGmi")
    STRTOFILE("CP4 CREATEOBJECT VARTYPE=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10), lcOut, 1)

    IF VARTYPE(loc_oForm) = "O"
        STRTOFILE("ControlCount=" + TRANSFORM(loc_oForm.ControlCount) + CHR(13) + CHR(10), lcOut, 1)
        STRTOFILE("cmd_4c_Encerrar existe=" + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "cmd_4c_Encerrar", 5)) + CHR(13) + CHR(10), lcOut, 1)
        STRTOFILE("cmd_4c_Cancela  REMOVIDO=" + ;
            TRANSFORM(!PEMSTATUS(loc_oForm, "cmd_4c_Cancela", 5)) + CHR(13) + CHR(10), lcOut, 1)
        STRTOFILE("Caption Encerrar=[" + loc_oForm.cmd_4c_Encerrar.Caption + "]" + CHR(13) + CHR(10), lcOut, 1)
        STRTOFILE("cmd_4c_Processa existe=" + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "cmd_4c_Processa", 5)) + CHR(13) + CHR(10), lcOut, 1)

        *-- BINDEVENT vivo: AEVENTS recebe 2 ARGUMENTOS e o evento vem na COLUNA 3
        LOCAL ARRAY laEv[1, 5]
        LOCAL lnEv, lnI, lcEv
        lcEv = ""
        lnEv = AEVENTS(laEv, 0)
        FOR lnI = 1 TO lnEv
            IF VARTYPE(laEv[lnI, 1]) = "O" AND UPPER(ALLTRIM(laEv[lnI, 3])) == "CLICK"
                lcEv = lcEv + ALLTRIM(laEv[lnI, 1].Name) + "->" + ALLTRIM(laEv[lnI, 4]) + " "
            ENDIF
        ENDFOR
        STRTOFILE("BINDEVENT Click: " + lcEv + CHR(13) + CHR(10), lcOut, 1)

        *-- handler alcancavel de FORA da classe (PEMSTATUS nao prova escopo)
        loc_oForm.BtnEncerrarClick()
        STRTOFILE("BtnEncerrarClick alcancavel de fora = .T." + CHR(13) + CHR(10), lcOut, 1)
    ENDIF
CATCH TO loc_oErro
    STRTOFILE("ERRO: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
        " PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10), lcOut, 1)
ENDTRY

STRTOFILE("CP5 fim" + CHR(13) + CHR(10), lcOut, 1)
QUIT
