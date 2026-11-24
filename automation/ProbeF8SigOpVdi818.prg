*-- Instancia FormSigOpVdi carregando SO as dependencias dele, sem o
*-- ConfigurarAmbiente() completo (que BLOQUEIA nesta maquina, antes de
*-- qualquer form). Smoke test headless (task818, Fase 8).
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste = .T.
gnConnHandle = 0
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_sigopvdi818.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_oE
STRTOFILE("A: inicio" + CHR(13) + CHR(10), "C:\4c\automation\probe_sigopvdi818.txt")

TRY
    CD C:\4c\projeto\app\start
    DO config.prg          && define as globais gc_4c_Caminho* (nao bloqueia)
    gb_4c_ValidandoUI = .T. && DEPOIS de DO config.prg - config.prg redefine .F.
    STRTOFILE("B: config.prg OK" + CHR(13) + CHR(10), "C:\4c\automation\probe_sigopvdi818.txt", 1)

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigOpVdiBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpVdi.prg") ADDITIVE
    STRTOFILE("C: deps carregadas" + CHR(13) + CHR(10), "C:\4c\automation\probe_sigopvdi818.txt", 1)

    LOCAL loc_oForm, loc_oE2
    TRY
        loc_oForm = CREATEOBJECT("FormSigOpVdi")
        IF VARTYPE(loc_oForm) = "O"
            STRTOFILE("D: INSTANCIOU. BaseClass=" + loc_oForm.BaseClass + ;
                " PageCount=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.PageCount) + CHR(13) + CHR(10), ;
                "C:\4c\automation\probe_sigopvdi818.txt", 1)
            loc_oForm.Release()
        ELSE
            STRTOFILE("D: NAO INSTANCIOU (VARTYPE=" + VARTYPE(loc_oForm) + ")" + CHR(13) + CHR(10), ;
                "C:\4c\automation\probe_sigopvdi818.txt", 1)
        ENDIF
    CATCH TO loc_oE2
        STRTOFILE("D-EXCEPTION: " + loc_oE2.Message + " Linha:" + TRANSFORM(loc_oE2.LineNo) + ;
            " Proc:" + loc_oE2.Procedure + CHR(13) + CHR(10), "C:\4c\automation\probe_sigopvdi818.txt", 1)
    ENDTRY

CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + " Linha:" + TRANSFORM(loc_oE.LineNo) + ;
        " Proc:" + loc_oE.Procedure + CHR(13) + CHR(10), "C:\4c\automation\probe_sigopvdi818.txt", 1)
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE("DIALOGOS: " + FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10), "C:\4c\automation\probe_sigopvdi818.txt", 1)
ENDIF

STRTOFILE("Z: fim" + CHR(13) + CHR(10), "C:\4c\automation\probe_sigopvdi818.txt", 1)
QUIT
