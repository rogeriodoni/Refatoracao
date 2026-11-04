SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado, gcLPgr
gb_4c_ModoTeste = .T.
gnConnHandle = 0
gc_4c_UsuarioLogado = "TESTE"
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_pgr.txt"
gcLPgr = "C:\4c\automation\probe_erro303_pgr.txt"
STRTOFILE("A: inicio" + CHR(13) + CHR(10), gcLPgr)
LOCAL loc_oE, loF
TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "pgrBO.prg") ADDITIVE
    *-- versao do GIT HEAD, ANTES do meu sweep
    SET PROCEDURE TO ("C:\Users\roger\AppData\Local\Temp\claude\C--4c\5c3d6e1b-73f7-4c38-8cb7-934e8d60a318\scratchpad\head303\Formpgr.prg") ADDITIVE
    LogPgr("B: deps carregadas (Formpgr do HEAD)")
    TRY
        loF = CREATEOBJECT("Formpgr")
        LogPgr("C: CREATEOBJECT (HEAD) -> " + VARTYPE(loF))
        IF VARTYPE(loF) = "O"
            loF.Release()
        ENDIF
    CATCH TO loc_oE
        LogPgr("C: CREATEOBJECT (HEAD) -> ERRO: " + loc_oE.Message)
    ENDTRY
CATCH TO loc_oE
    LogPgr("EXCEPTION: " + loc_oE.Message)
ENDTRY
STRTOFILE("Z: fim" + CHR(13) + CHR(10), gcLPgr, 1)
QUIT

PROCEDURE LogPgr(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcLPgr, 1)
ENDPROC
