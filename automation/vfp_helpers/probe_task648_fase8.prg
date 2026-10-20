*-- Fase 8 / task648: instanciacao OFFLINE do FormSIGOPBOL (dialogo MODAL de
*-- selecao de impressora de boleto). A maquina do pipeline nao alcanca o
*-- SQL Server, e o TestFormWrapper aborta antes de instanciar. Este harness
*-- pula a conexao (gnConnHandle = -1) e exercita o Init completo + a
*-- superficie que o legado tem.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe_task648_erros.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cOut, loc_oForm, loc_oErro
loc_cOut = ""

*-- ConfigurarAmbiente() BLOQUEIA nesta maquina (nunca retorna) e mata o probe
*-- por timeout ANTES do CREATEOBJECT. Carrega-se a mao so o que o form usa.
CD C:\4c\projeto\app\start
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
SET PROCEDURE TO (gcCaminhoClasses + "SIGOPBOLBO.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSIGOPBOL.prg") ADDITIVE
loc_cOut = loc_cOut + "CONFIG=OK" + CHR(13) + CHR(10)
STRTOFILE(loc_cOut, "C:\4c\automation\probe_task648_resultado.txt")

gnConnHandle = -1

*-- 15 = o pnTpBol que o unico caller legado passa (Do Form SigOpBol With ThisForm,15)
TRY
    loc_oForm = CREATEOBJECT("FormSIGOPBOL", 15)
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "CREATE_EXCEPTION=[" + loc_oErro.Message + ;
               " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
               " PROC=" + loc_oErro.Procedure + "]" + CHR(13) + CHR(10)
ENDTRY

loc_cOut = loc_cOut + "VARTYPE=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10)

IF VARTYPE(loc_oForm) = "O"
    loc_cOut = loc_cOut + "CLASSE="        + loc_oForm.Class + CHR(13) + CHR(10) + ;
               "BASECLASS="    + loc_oForm.BaseClass + CHR(13) + CHR(10) + ;
               "CAPTION=["     + loc_oForm.Caption + "]" + CHR(13) + CHR(10) + ;
               "WIDTHxHEIGHT=" + TRANSFORM(loc_oForm.Width) + "x" + TRANSFORM(loc_oForm.Height) + CHR(13) + CHR(10) + ;
               "WINDOWTYPE="   + TRANSFORM(loc_oForm.WindowType) + CHR(13) + CHR(10) + ;
               "TITLEBAR="     + TRANSFORM(loc_oForm.TitleBar) + CHR(13) + CHR(10) + ;
               "CLOSABLE="     + TRANSFORM(loc_oForm.Closable) + CHR(13) + CHR(10) + ;
               "DATASESSION="  + TRANSFORM(loc_oForm.DataSession) + CHR(13) + CHR(10)

    *-- Os 8 objetos do inventario do SCX legado
    loc_cOut = loc_cOut + ;
        "OBJ_SOMBRA="   + IIF(PEMSTATUS(loc_oForm, "cnt_4c_Sombra", 5), "SIM", "NAO") + CHR(13) + CHR(10) + ;
        "OBJ_OPT="      + IIF(PEMSTATUS(loc_oForm, "obj_4c_Opt_Impressora", 5), "SIM", "NAO") + CHR(13) + CHR(10) + ;
        "OBJ_LBLIMP="   + IIF(PEMSTATUS(loc_oForm, "lbl_4c_Lbl_Impressora", 5), "SIM", "NAO") + CHR(13) + CHR(10) + ;
        "OBJ_LBLERRO="  + IIF(PEMSTATUS(loc_oForm, "lbl_4c_Lbl_Erro", 5), "SIM", "NAO") + CHR(13) + CHR(10) + ;
        "OBJ_BTNREP="   + IIF(PEMSTATUS(loc_oForm, "obj_4c_BtnReport", 5), "SIM", "NAO") + CHR(13) + CHR(10)

    *-- Handler do botao de acao: existe E eh PUBLIC (BINDEVENT exige - regra #3)
    loc_cOut = loc_cOut + ;
        "HANDLER_EXISTE=" + IIF(PEMSTATUS(loc_oForm, "CmdImprimirClick", 5), "SIM", "NAO") + CHR(13) + CHR(10) + ;
        "HANDLER_PROTECTED=" + IIF(PEMSTATUS(loc_oForm, "CmdImprimirClick", 2), "SIM", "NAO") + CHR(13) + CHR(10)

    IF PEMSTATUS(loc_oForm, "cnt_4c_Sombra", 5)
        loc_cOut = loc_cOut + "TITULO_FAIXA=[" + ;
            ALLTRIM(loc_oForm.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption) + "]" + CHR(13) + CHR(10) + ;
            "FAIXA_BACKCOLOR=" + TRANSFORM(loc_oForm.cnt_4c_Sombra.BackColor) + CHR(13) + CHR(10)
    ENDIF

    *-- Sem banco nao ha impressora de boleto: o legado cai no ramo de ERRO
    *-- (Opt/Lbl_Impressora invisiveis, Lbl_Erro visivel com a mensagem)
    IF PEMSTATUS(loc_oForm, "lbl_4c_Lbl_Erro", 5)
        loc_cOut = loc_cOut + ;
            "ERRO_VISIBLE="  + TRANSFORM(loc_oForm.lbl_4c_Lbl_Erro.Visible) + CHR(13) + CHR(10) + ;
            "ERRO_CAPTION=[" + ALLTRIM(loc_oForm.lbl_4c_Lbl_Erro.Caption) + "]" + CHR(13) + CHR(10) + ;
            "OPT_VISIBLE="   + TRANSFORM(loc_oForm.obj_4c_Opt_Impressora.Visible) + CHR(13) + CHR(10) + ;
            "LBLIMP_VISIBLE=" + TRANSFORM(loc_oForm.lbl_4c_Lbl_Impressora.Visible) + CHR(13) + CHR(10)
    ENDIF

    loc_oForm.Release()
    loc_cOut = loc_cOut + "RELEASE=OK" + CHR(13) + CHR(10)
ENDIF

IF FILE(gc_4c_ArquivoErroTeste)
    loc_cOut = loc_cOut + "--- ERROS CAPTURADOS ---" + CHR(13) + CHR(10) + ;
               FILETOSTR(gc_4c_ArquivoErroTeste)
ELSE
    loc_cOut = loc_cOut + "ERROS_CAPTURADOS=NENHUM" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(loc_cOut, "C:\4c\automation\probe_task648_resultado.txt")
QUIT
