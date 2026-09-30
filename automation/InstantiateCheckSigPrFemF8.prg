*==============================================================================
* InstantiateCheckSigPrFemF8.prg - Verificacao final (Fase 8) de FormSigPrFem
*
* Instancia o form carregando SO as dependencias dele (ConfigurarAmbiente()
* BLOQUEIA nesta maquina antes de qualquer form - ver
* feedback_configurarambiente_bloqueia_probe_de_form).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_sigprfem_f8.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
gnConnHandle = -1

LOCAL loc_cRes, loc_oForm, loc_oErro
loc_cRes = "FAIL"

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gb_4c_ValidandoUI = .T.

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigPrFemBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigPrFem.prg") ADDITIVE

    loc_oForm = CREATEOBJECT("FormSigPrFem")

    IF VARTYPE(loc_oForm) = "O"
        loc_cRes = "OK W=" + TRANSFORM(loc_oForm.Width) + " H=" + TRANSFORM(loc_oForm.Height)
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + ;
            "PEMSTATUS(cnt_4c_Sombra)=" + TRANSFORM(PEMSTATUS(loc_oForm, "cnt_4c_Sombra", 5)) + CHR(13) + CHR(10) + ;
            "PEMSTATUS(cnt_4c_Resultado)=" + TRANSFORM(PEMSTATUS(loc_oForm, "cnt_4c_Resultado", 5)) + CHR(13) + CHR(10) + ;
            "PEMSTATUS(cmd_4c_Processar)=" + TRANSFORM(PEMSTATUS(loc_oForm, "cmd_4c_Processar", 5)) + CHR(13) + CHR(10) + ;
            "PEMSTATUS(cmd_4c_Visualizar)=" + TRANSFORM(PEMSTATUS(loc_oForm, "cmd_4c_Visualizar", 5)) + CHR(13) + CHR(10) + ;
            "PEMSTATUS(cmd_4c_Imprimir)=" + TRANSFORM(PEMSTATUS(loc_oForm, "cmd_4c_Imprimir", 5)) + CHR(13) + CHR(10) + ;
            "PEMSTATUS(cmd_4c_Sair)=" + TRANSFORM(PEMSTATUS(loc_oForm, "cmd_4c_Sair", 5)) + CHR(13) + CHR(10) + ;
            "PEMSTATUS(txt_4c_Datai)=" + TRANSFORM(PEMSTATUS(loc_oForm, "txt_4c_Datai", 5)) + CHR(13) + CHR(10) + ;
            "PEMSTATUS(txt_4c_Dataf)=" + TRANSFORM(PEMSTATUS(loc_oForm, "txt_4c_Dataf", 5)) + CHR(13) + CHR(10) + ;
            "PEMSTATUS(txt_4c_Demonstrativo)=" + TRANSFORM(PEMSTATUS(loc_oForm, "txt_4c_Demonstrativo", 5)) + CHR(13) + CHR(10) + ;
            "this_oBusinessObject=" + VARTYPE(loc_oForm.this_oBusinessObject)
        loc_oForm.Release()
    ELSE
        loc_cRes = "FAIL VARTYPE=" + VARTYPE(loc_oForm)
    ENDIF

CATCH TO loc_oErro
    loc_cRes = "EXCEPTION: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    loc_cRes = loc_cRes + CHR(13) + CHR(10) + "DIALOGOS: " + FILETOSTR(gc_4c_ArquivoErroTeste)
ENDIF

STRTOFILE(loc_cRes, "C:\4c\automation\instantiate_sigprfem_f8_result.txt")
QUIT
