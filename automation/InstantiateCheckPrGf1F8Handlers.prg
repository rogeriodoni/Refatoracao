*==============================================================================
* InstantiateCheckPrGf1F8Handlers.prg
*
* Prova MEDINDO no VFP9 que a renomeacao dos handlers da Fase 8 esta completa:
*   1. BtnProcessarClick / BtnEncerrarClick existem e sao PUBLIC (chamada
*      EXTERNA funciona - PEMSTATUS devolve .T. ate para PROTECTED, entao a
*      unica prova valida eh chamar de fora, como o BINDEVENT faz);
*   2. os nomes ANTIGOS (Cmd*Click) nao respondem mais - nao sobrou call site;
*   3. AEVENTS mostra o Click dos DOIS Buttons ligado aos nomes NOVOS
*      (BINDEVENT com nome inexistente falharia em silencio e o botao ficaria
*      morto);
*   4. BtnEncerrarClick de fato fecha a tela.
*
* AEVENTS: 2 argumentos, e o evento eh a COLUNA 3 do array.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gc_4c_LogH
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_prgf1_f8h.txt"
gc_4c_LogH             = "C:\4c\automation\instantiate_prgf1_f8h_result.txt"

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
IF FILE(gc_4c_LogH)
    DELETE FILE (gc_4c_LogH)
ENDIF

LOCAL loc_oForm, loc_oErro, loc_nQtd, loc_nI, loc_cLig
LOCAL ARRAY laEv(1)

LogH("HANDLERS CHECK FormSigPrGf1 - inicio " + TTOC(DATETIME()))

TRY
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
    SET PROCEDURE TO (gcCaminhoClasses + "SigPrGf1BO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigPrGf1.prg") ADDITIVE
    LogH("0 SETUP: OK")
CATCH TO loc_oErro
    LogH("0 SETUP FALHOU: " + loc_oErro.Message)
ENDTRY

loc_oForm = .NULL.
TRY
    loc_oForm = CREATEOBJECT("FormSigPrGf1")
    LogH("1 INSTANCIA: VARTYPE=" + VARTYPE(loc_oForm))
CATCH TO loc_oErro
    LogH("1 INSTANCIA FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
ENDTRY

IF VARTYPE(loc_oForm) = "O"

    *-- 2. AEVENTS nos DOIS botoes: o Click esta ligado ao nome NOVO?
    TRY
        loc_cLig = ""
        loc_nQtd = AEVENTS(laEv, loc_oForm.obj_4c_CmdGprocessa.Buttons(1))
        FOR loc_nI = 1 TO loc_nQtd
            IF UPPER(ALLTRIM(laEv(loc_nI, 3))) == "CLICK"
                loc_cLig = loc_cLig + "B1->" + ALLTRIM(laEv(loc_nI, 4)) + " "
            ENDIF
        ENDFOR
        loc_nQtd = AEVENTS(laEv, loc_oForm.obj_4c_CmdGprocessa.Buttons(2))
        FOR loc_nI = 1 TO loc_nQtd
            IF UPPER(ALLTRIM(laEv(loc_nI, 3))) == "CLICK"
                loc_cLig = loc_cLig + "B2->" + ALLTRIM(laEv(loc_nI, 4))
            ENDIF
        ENDFOR
        LogH("2 AEVENTS Click: " + loc_cLig + "  [esperado BtnProcessarClick / BtnEncerrarClick]")
    CATCH TO loc_oErro
        LogH("2 AEVENTS FALHOU: " + loc_oErro.Message)
    ENDTRY

    *-- 3. nomes ANTIGOS nao respondem mais (chamada externa deve estourar)
    TRY
        loc_oForm.CmdProcessarClick()
        LogH("3 ANTIGO CmdProcessarClick AINDA RESPONDE - renomeacao incompleta")
    CATCH TO loc_oErro
        LogH("3 ANTIGO CmdProcessarClick recusado, como esperado: " + loc_oErro.Message)
    ENDTRY
    TRY
        loc_oForm.CmdEncerrarClick()
        LogH("3a ANTIGO CmdEncerrarClick AINDA RESPONDE - renomeacao incompleta")
    CATCH TO loc_oErro
        LogH("3a ANTIGO CmdEncerrarClick recusado, como esperado: " + loc_oErro.Message)
    ENDTRY

    *-- 4. BtnProcessarClick eh PUBLIC (chamada EXTERNA resolve o nome).
    *   Sem gnConnHandle o Processar do BO falha; o que se mede aqui eh que a
    *   CHAMADA resolve - "Property BTNPROCESSARCLICK is not found" seria o
    *   sintoma de metodo PROTECTED/ausente.
    TRY
        loc_oForm.BtnProcessarClick()
        LogH("4 BtnProcessarClick PUBLIC: chamada externa OK")
    CATCH TO loc_oErro
        LogH("4 BtnProcessarClick chamada externa ESTOUROU: " + loc_oErro.Message)
    ENDTRY

    *-- 5. BtnEncerrarClick eh PUBLIC e fecha a tela
    TRY
        loc_oForm.BtnEncerrarClick()
        LogH("5 BtnEncerrarClick chamado; form VARTYPE=" + VARTYPE(loc_oForm) + " [X = liberado]")
    CATCH TO loc_oErro
        LogH("5 BtnEncerrarClick ESTOUROU: " + loc_oErro.Message)
    ENDTRY
ENDIF

IF FILE(gc_4c_ArquivoErroTeste)
    LogH("DIALOGOS SUPRIMIDOS: " + FILETOSTR(gc_4c_ArquivoErroTeste))
ELSE
    LogH("DIALOGOS SUPRIMIDOS: nenhum")
ENDIF

LogH("FIM " + TTOC(DATETIME()))
QUIT

PROCEDURE LogH(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gc_4c_LogH, .T.)
ENDPROC
