*-- Instancia Formsigprcpd carregando SO as dependencias dele, sem
*-- ConfigurarAmbiente() completo (bloqueia nesta maquina - ver
*-- feedback_configurarambiente_bloqueia_probe_de_form).
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_sigprcpdmin.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
LOCAL loc_oE, loc_oForm
STRTOFILE("A: inicio" + CHR(13)+CHR(10), "C:\4c\automation\probe_sigprcpdmin.txt")
TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    STRTOFILE("B: config.prg OK" + CHR(13)+CHR(10), "C:\4c\automation\probe_sigprcpdmin.txt", 1)

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "sigprcpdBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\Formsigprcpd.prg") ADDITIVE
    STRTOFILE("C: deps carregadas" + CHR(13)+CHR(10), "C:\4c\automation\probe_sigprcpdmin.txt", 1)

    loc_oForm = CREATEOBJECT("Formsigprcpd", "", "", DATE(), 0)
    IF VARTYPE(loc_oForm) = "O"
        STRTOFILE("D: instanciou OK W=" + TRANSFORM(loc_oForm.Width) + " H=" + TRANSFORM(loc_oForm.Height) + CHR(13)+CHR(10), "C:\4c\automation\probe_sigprcpdmin.txt", 1)
        STRTOFILE("E: PEMSTATUS(grd_4c_Dados)=" + TRANSFORM(PEMSTATUS(loc_oForm, "grd_4c_Dados", 5)) + ;
                  " PEMSTATUS(cmd_4c_Sair)=" + TRANSFORM(PEMSTATUS(loc_oForm, "cmd_4c_Sair", 5)) + ;
                  " PEMSTATUS(cnt_4c_Cabecalho)=" + TRANSFORM(PEMSTATUS(loc_oForm, "cnt_4c_Cabecalho", 5)) + CHR(13)+CHR(10), ;
                  "C:\4c\automation\probe_sigprcpdmin.txt", 1)
        loc_oForm.Release()
    ELSE
        STRTOFILE("D: NAO INSTANCIOU VARTYPE=" + VARTYPE(loc_oForm) + CHR(13)+CHR(10), "C:\4c\automation\probe_sigprcpdmin.txt", 1)
    ENDIF
CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + " Linha:" + TRANSFORM(loc_oE.LineNo) + ;
              " Proc:" + loc_oE.Procedure + CHR(13)+CHR(10), "C:\4c\automation\probe_sigprcpdmin.txt", 1)
ENDTRY
IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE("DIALOGOS: " + FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13)+CHR(10), "C:\4c\automation\probe_sigprcpdmin.txt", 1)
ENDIF
STRTOFILE("Z: fim" + CHR(13)+CHR(10), "C:\4c\automation\probe_sigprcpdmin.txt", 1)
QUIT
