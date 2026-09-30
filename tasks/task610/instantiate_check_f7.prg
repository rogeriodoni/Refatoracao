*-- Probe headless da Fase 7 de FormSigPrFem (eventos dos botoes).
*-- NAO chama ConfigurarAmbiente() (BLOQUEIA nesta maquina): carrega a mao so
*-- as dependencias deste form.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\tasks\task610\vfp_err_f7.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

#DEFINE ARQ_LOG "C:\4c\tasks\task610\instantiate_f7.txt"

LOCAL loc_oE, loc_oForm, loc_nI, loc_cBotoes

STRTOFILE("A: inicio" + CHR(13) + CHR(10), ARQ_LOG)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    STRTOFILE("B: config.prg OK" + CHR(13) + CHR(10), ARQ_LOG, 1)

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + ;
                 gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "fwprogressbar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigPrFemBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigPrFem.prg") ADDITIVE
    STRTOFILE("C: deps carregadas" + CHR(13) + CHR(10), ARQ_LOG, 1)

    loc_oForm = CREATEOBJECT("FormSigPrFem")
    IF VARTYPE(loc_oForm) != "O"
        STRTOFILE("D: NAO INSTANCIOU VARTYPE=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10), ARQ_LOG, 1)
    ELSE
        STRTOFILE("D: Init OK Width=" + TRANSFORM(loc_oForm.Width) + CHR(13) + CHR(10), ARQ_LOG, 1)

        *-- Os 4 handlers PRECISAM ser PUBLIC: BINDEVENT com metodo PROTECTED
        *-- falha em silencio, e o botao fica morto.
        STRTOFILE("E: HANDLERS" + ;
            " BtnProcessarClick="  + TRANSFORM(PEMSTATUS(loc_oForm, "BtnProcessarClick", 5)) + ;
            " BtnVisualizarClick=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnVisualizarClick", 5)) + ;
            " BtnImprimirClick="   + TRANSFORM(PEMSTATUS(loc_oForm, "BtnImprimirClick", 5)) + ;
            " BtnSairClick="       + TRANSFORM(PEMSTATUS(loc_oForm, "BtnSairClick", 5)) + CHR(13) + CHR(10), ARQ_LOG, 1)

        *-- BINDEVENT efetivo: AEVENTS tem 2 argumentos e o evento eh a coluna 3
        loc_cBotoes = ""
        LOCAL ARRAY loc_aEv[1, 5]
        loc_nI = AEVENTS(loc_aEv, loc_oForm.cmd_4c_Processar)
        loc_cBotoes = loc_cBotoes + " Processar=" + TRANSFORM(loc_nI)
        loc_nI = AEVENTS(loc_aEv, loc_oForm.cmd_4c_Visualizar)
        loc_cBotoes = loc_cBotoes + " Visualizar=" + TRANSFORM(loc_nI)
        loc_nI = AEVENTS(loc_aEv, loc_oForm.cmd_4c_Imprimir)
        loc_cBotoes = loc_cBotoes + " Imprimir=" + TRANSFORM(loc_nI)
        loc_nI = AEVENTS(loc_aEv, loc_oForm.cmd_4c_Sair)
        loc_cBotoes = loc_cBotoes + " Sair=" + TRANSFORM(loc_nI)
        STRTOFILE("F: BINDEVENTs" + loc_cBotoes + CHR(13) + CHR(10), ARQ_LOG, 1)

        *-- Metodos do BO chamados pelos handlers (regra #13: nome inexistente
        *-- so estoura em RUNTIME)
        STRTOFILE("G: BO" + ;
            " Processar=" + TRANSFORM(PEMSTATUS(loc_oForm.this_oBusinessObject, "Processar", 5)) + ;
            " Ouros=["    + ALLTRIM(loc_oForm.this_oBusinessObject.this_cOuros) + "]" + CHR(13) + CHR(10), ARQ_LOG, 1)

        *-- Validacao 1: Data Final vazia -> avisa e devolve o foco, SEM tocar no BO
        loc_oForm.txt_4c_Datai.Value         = DATE()
        loc_oForm.txt_4c_Dataf.Value         = {}
        loc_oForm.txt_4c_Demonstrativo.Value = ""
        loc_oForm.BtnProcessarClick()
        STRTOFILE("H: valida DataFinal vazia OK ResultadoPronto=" + ;
            TRANSFORM(loc_oForm.this_lResultadoPronto) + CHR(13) + CHR(10), ARQ_LOG, 1)

        *-- Validacao 2: Data Final < Data Inicial
        loc_oForm.txt_4c_Datai.Value = DATE()
        loc_oForm.txt_4c_Dataf.Value = DATE() - 10
        loc_oForm.BtnProcessarClick()
        STRTOFILE("I: valida DataFinal<Inicial OK" + CHR(13) + CHR(10), ARQ_LOG, 1)

        *-- Validacao 3: Configuracao vazia
        loc_oForm.txt_4c_Datai.Value         = DATE() - 10
        loc_oForm.txt_4c_Dataf.Value         = DATE()
        loc_oForm.txt_4c_Demonstrativo.Value = ""
        loc_oForm.BtnProcessarClick()
        STRTOFILE("J: valida Config vazia OK" + CHR(13) + CHR(10), ARQ_LOG, 1)

        *-- Video/Impressora ANTES de processar: o gate tem de barrar (o legado
        *-- fica mudo; aqui avisa). Se abrisse o preview, travaria o probe.
        loc_oForm.BtnVisualizarClick()
        STRTOFILE("K: BtnVisualizarClick sem processar OK (gate barrou)" + CHR(13) + CHR(10), ARQ_LOG, 1)
        loc_oForm.BtnImprimirClick()
        STRTOFILE("L: BtnImprimirClick sem processar OK (gate barrou)" + CHR(13) + CHR(10), ARQ_LOG, 1)

        *-- FRX que os dois botoes consomem
        STRTOFILE("M: FRX existe=" + ;
            TRANSFORM(FILE(FULLPATH(gc_4c_CaminhoReports + "SigPrFem.frx"))) + CHR(13) + CHR(10), ARQ_LOG, 1)

        loc_oForm.Release()
        STRTOFILE("N: Release OK" + CHR(13) + CHR(10), ARQ_LOG, 1)
    ENDIF
CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + " Linha:" + TRANSFORM(loc_oE.LineNo) + ;
              " Proc:" + loc_oE.Procedure + CHR(13) + CHR(10), ARQ_LOG, 1)
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE("DIALOGOS SUPRIMIDOS:" + CHR(13) + CHR(10) + ;
              FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10), ARQ_LOG, 1)
ENDIF

STRTOFILE("Z: fim" + CHR(13) + CHR(10), ARQ_LOG, 1)
QUIT
