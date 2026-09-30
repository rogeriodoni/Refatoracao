*-- Probe headless da Fase 8 de FormSigPrFem (eventos auxiliares e consolidacao).
*-- NAO chama ConfigurarAmbiente() (BLOQUEIA nesta maquina): carrega a mao so
*-- as dependencias deste form.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\tasks\task610\vfp_err_f8.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

#DEFINE ARQ_LOG "C:\4c\tasks\task610\instantiate_f8.txt"

LOCAL loc_oE, loc_oForm, loc_nI, loc_cTxt, loc_cCnt, loc_lOK

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

        *-- (1) When -> Return .F. dos 10 totalizadores = .TabStop = .F.
        loc_cTxt = ""
        loc_lOK  = .T.
        FOR loc_nI = 1 TO 10
            loc_cCnt = GETWORDNUM("txt_4c_Saldoi txt_4c_SaldoAnt txt_4c_Entradas " + ;
                "txt_4c_TEntradas txt_4c_Saidas txt_4c_Pesagem txt_4c_Saldo " + ;
                "txt_4c_SaldoFunc txt_4c_FalhaFunc txt_4c_SaldoT", loc_nI)
            IF EVALUATE("loc_oForm.cnt_4c_Resultado.cnt_4c_Resumo." + loc_cCnt + ".TabStop")
                loc_lOK  = .F.
                loc_cTxt = loc_cTxt + " " + loc_cCnt + "=TABSTOP_LIGADO"
            ENDIF
        ENDFOR
        STRTOFILE("E: TabStop=.F. nos 10 totalizadores: " + TRANSFORM(loc_lOK) + loc_cTxt + CHR(13) + CHR(10), ARQ_LOG, 1)

        *-- (2) Metodos novos existem
        STRTOFILE("F: METODOS" + ;
            " HabilitarCampos=" + TRANSFORM(PEMSTATUS(loc_oForm, "HabilitarCampos", 5)) + ;
            " LimparResultado=" + TRANSFORM(PEMSTATUS(loc_oForm, "LimparResultado", 5)) + ;
            " this_lProcessando=" + TRANSFORM(PEMSTATUS(loc_oForm, "this_lProcessando", 5)) + CHR(13) + CHR(10), ARQ_LOG, 1)

        *-- (3) LimparResultado zera totais / esconde detalhes
        loc_oForm.cnt_4c_Resultado.cnt_4c_Resumo.txt_4c_SaldoT.Value = 777
        loc_oForm.cnt_4c_Resultado.Visible = .T.
        loc_oForm.cnt_4c_Resultado.cnt_4c_Detalhe3.Visible = .T.
        loc_oForm.this_lResultadoPronto = .T.
        loc_oForm.LimparResultado()
        STRTOFILE("G: LimparResultado SaldoT=" + TRANSFORM(loc_oForm.cnt_4c_Resultado.cnt_4c_Resumo.txt_4c_SaldoT.Value) + ;
            " Resultado.Visible=" + TRANSFORM(loc_oForm.cnt_4c_Resultado.Visible) + ;
            " Detalhe3.Visible="  + TRANSFORM(loc_oForm.cnt_4c_Resultado.cnt_4c_Detalhe3.Visible) + ;
            " Pronto=" + TRANSFORM(loc_oForm.this_lResultadoPronto) + CHR(13) + CHR(10), ARQ_LOG, 1)

        *-- (4) HabilitarCampos liga/desliga os 3 filtros + 4 botoes
        loc_oForm.HabilitarCampos(.F.)
        STRTOFILE("H: OFF Datai=" + TRANSFORM(loc_oForm.txt_4c_Datai.Enabled) + ;
            " Demo=" + TRANSFORM(loc_oForm.txt_4c_Demonstrativo.Enabled) + ;
            " Processar=" + TRANSFORM(loc_oForm.cmd_4c_Processar.Enabled) + ;
            " Sair=" + TRANSFORM(loc_oForm.cmd_4c_Sair.Enabled) + CHR(13) + CHR(10), ARQ_LOG, 1)
        loc_oForm.HabilitarCampos(.T.)
        STRTOFILE("I: ON  Datai=" + TRANSFORM(loc_oForm.txt_4c_Datai.Enabled) + ;
            " Demo=" + TRANSFORM(loc_oForm.txt_4c_Demonstrativo.Enabled) + ;
            " Processar=" + TRANSFORM(loc_oForm.cmd_4c_Processar.Enabled) + ;
            " Sair=" + TRANSFORM(loc_oForm.cmd_4c_Sair.Enabled) + CHR(13) + CHR(10), ARQ_LOG, 1)

        *-- (5) Guard de reentrancia: com a flag ligada, BtnProcessarClick
        *--     tem de sair SEM tocar em nada (Datai continua habilitado).
        loc_oForm.this_lProcessando = .T.
        loc_oForm.BtnProcessarClick()
        STRTOFILE("J: reentrancia barrada (Datai continua ON)=" + ;
            TRANSFORM(loc_oForm.txt_4c_Datai.Enabled) + CHR(13) + CHR(10), ARQ_LOG, 1)
        loc_oForm.this_lProcessando = .F.

        *-- (6) Caminho de ERRO repoe a tela: BO nulo faz BtnProcessarClick
        *--     cair no RETURN de guarda ANTES do TRY, com filtros validos
        loc_oForm.txt_4c_Datai.Value         = DATE() - 30
        loc_oForm.txt_4c_Dataf.Value         = DATE()
        loc_oForm.txt_4c_Demonstrativo.Value = "TESTE"
        loc_oForm.BtnProcessarClick()
        STRTOFILE("K: apos Processar (SQL indisponivel) - Datai=" + ;
            TRANSFORM(loc_oForm.txt_4c_Datai.Enabled) + ;
            " Processar=" + TRANSFORM(loc_oForm.cmd_4c_Processar.Enabled) + ;
            " Sair=" + TRANSFORM(loc_oForm.cmd_4c_Sair.Enabled) + ;
            " Processando=" + TRANSFORM(loc_oForm.this_lProcessando) + ;
            " Mouse=" + TRANSFORM(loc_oForm.MousePointer) + CHR(13) + CHR(10), ARQ_LOG, 1)

        loc_oForm.Release()
        STRTOFILE("L: Release OK" + CHR(13) + CHR(10), ARQ_LOG, 1)
    ENDIF
CATCH TO loc_oE
    STRTOFILE("ERRO: " + loc_oE.Message + " | LN=" + TRANSFORM(loc_oE.LineNo) + ;
              " | PROC=" + loc_oE.Procedure + CHR(13) + CHR(10), ARQ_LOG, 1)
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE("DIALOGOS SUPRIMIDOS:" + CHR(13) + CHR(10) + FILETOSTR(gc_4c_ArquivoErroTeste), ARQ_LOG, 1)
ENDIF
STRTOFILE(CHR(13) + CHR(10) + "Z: fim" + CHR(13) + CHR(10), ARQ_LOG, 1)
QUIT
