SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)

LOCAL loc_cLog
loc_cLog = "C:\4c\tasks\task678\_probe_fase8_log.txt"
IF FILE(loc_cLog)
    DELETE FILE (loc_cLog)
ENDIF
STRTOFILE("inicio" + CHR(13) + CHR(10), loc_cLog, 0)

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI, gnConnHandle
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\tasks\task678\_probe_fase8_erros.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
gnConnHandle = 0

CD C:\4c\projeto\app\start
DO config.prg
STRTOFILE("config.prg OK - gcCaminhoBase=" + gcCaminhoBase + CHR(13) + CHR(10), loc_cLog, 1)

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
SET PROCEDURE TO (gcCaminhoClasses + "SigPrSndBO.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigPrSnd.prg") ADDITIVE
STRTOFILE("SET PROCEDURE OK" + CHR(13) + CHR(10), loc_cLog, 1)

LOCAL loc_oForm, loc_oErro, loc_lInstanciou
loc_lInstanciou = .F.

TRY
    loc_oForm = CREATEOBJECT("FormSigPrSnd")
    loc_lInstanciou = (VARTYPE(loc_oForm) = "O")
CATCH TO loc_oErro
    STRTOFILE("EXCEPTION ao instanciar: " + loc_oErro.Message + " linha=" + ;
        TRANSFORM(loc_oErro.LineNo) + " proc=" + loc_oErro.Procedure + CHR(13) + CHR(10), loc_cLog, 1)
ENDTRY

STRTOFILE("instanciou=" + TRANSFORM(loc_lInstanciou) + CHR(13) + CHR(10), loc_cLog, 1)

IF loc_lInstanciou
    STRTOFILE("tem cmd_4c_BtnExcel=" + TRANSFORM(PEMSTATUS(loc_oForm, "cmd_4c_BtnExcel", 5)) + CHR(13) + CHR(10), loc_cLog, 1)
    STRTOFILE("tem cmd_4c_Saida=" + TRANSFORM(PEMSTATUS(loc_oForm, "cmd_4c_Saida", 5)) + CHR(13) + CHR(10), loc_cLog, 1)
    STRTOFILE("BtnExcelClick existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnExcelClick", 5)) + ;
        "  protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnExcelClick", 2)) + CHR(13) + CHR(10), loc_cLog, 1)
    STRTOFILE("BtnSaidaClick existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnSaidaClick", 5)) + ;
        "  protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnSaidaClick", 2)) + CHR(13) + CHR(10), loc_cLog, 1)
    STRTOFILE("txt_4c_Qtdsen existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "txt_4c_Qtdsen", 5)) + CHR(13) + CHR(10), loc_cLog, 1)
    STRTOFILE("cursor_4c_Senhas USED (sessao propria)=" + TRANSFORM(USED("cursor_4c_Senhas")) + CHR(13) + CHR(10), loc_cLog, 1)

    *-- cursor com DataSession=2 so se enxerga de dentro da propria sessao do form
    LOCAL loc_nDSAnt
    loc_nDSAnt = SET("DATASESSION")
    SET DATASESSION TO (loc_oForm.DataSessionId)
    STRTOFILE("cursor_4c_Senhas USED (dentro do DataSession do form)=" + TRANSFORM(USED("cursor_4c_Senhas")) + CHR(13) + CHR(10), loc_cLog, 1)
    SET DATASESSION TO (loc_nDSAnt)

    *-- Release por ultimo (destroi o form)
    TRY
        loc_oForm.Release()
        STRTOFILE("Release OK" + CHR(13) + CHR(10), loc_cLog, 1)
    CATCH TO loc_oErro
        STRTOFILE("EXCEPTION ao Release: " + loc_oErro.Message + CHR(13) + CHR(10), loc_cLog, 1)
    ENDTRY
ENDIF

STRTOFILE("fim" + CHR(13) + CHR(10), loc_cLog, 1)
QUIT
