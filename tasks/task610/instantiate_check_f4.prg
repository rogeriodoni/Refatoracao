*-- Probe headless da Fase 4 de FormSigPrFem.
*-- NAO chama ConfigurarAmbiente() (BLOQUEIA nesta maquina, antes de qualquer
*-- form): carrega a mao so as dependencias deste form.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\tasks\task610\vfp_err_f4.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

#DEFINE ARQ_LOG "C:\4c\tasks\task610\instantiate_f4.txt"

LOCAL loc_oE, loc_oForm, loc_oBO, loc_oRes, loc_oG

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
        STRTOFILE("D: Init OK" + ;
            " Width="     + TRANSFORM(loc_oForm.Width) + ;
            " Height="    + TRANSFORM(loc_oForm.Height) + ;
            " BaseClass=" + loc_oForm.BaseClass + ;
            " Caption=["  + loc_oForm.Caption + "]" + CHR(13) + CHR(10), ARQ_LOG, 1)

        STRTOFILE("E: BOTOES" + ;
            " Visualizar=" + TRANSFORM(PEMSTATUS(loc_oForm, "cmd_4c_Visualizar", 5)) + ;
            " Imprimir="   + TRANSFORM(PEMSTATUS(loc_oForm, "cmd_4c_Imprimir", 5)) + ;
            " Processar="  + TRANSFORM(PEMSTATUS(loc_oForm, "cmd_4c_Processar", 5)) + ;
            " Sair="       + TRANSFORM(PEMSTATUS(loc_oForm, "cmd_4c_Sair", 5)) + ;
            " Shape1="     + TRANSFORM(PEMSTATUS(loc_oForm, "shp_4c_Shape1", 5)) + ;
            " Shape2="     + TRANSFORM(PEMSTATUS(loc_oForm, "shp_4c_Shape2", 5)) + CHR(13) + CHR(10), ARQ_LOG, 1)

        STRTOFILE("F: SAIR Left=" + TRANSFORM(loc_oForm.cmd_4c_Sair.Left) + ;
            " Top="     + TRANSFORM(loc_oForm.cmd_4c_Sair.Top) + ;
            " W="       + TRANSFORM(loc_oForm.cmd_4c_Sair.Width) + ;
            " Cancel="  + TRANSFORM(loc_oForm.cmd_4c_Sair.Cancel) + ;
            " Visible=" + TRANSFORM(loc_oForm.cmd_4c_Sair.Visible) + ;
            " Cap=["    + ALLTRIM(loc_oForm.cmd_4c_Sair.Caption) + "]" + ;
            " PicOK="   + TRANSFORM(FILE(loc_oForm.cmd_4c_Sair.Picture)) + CHR(13) + CHR(10), ARQ_LOG, 1)

        STRTOFILE("G: PICTURES Video=" + TRANSFORM(FILE(loc_oForm.cmd_4c_Visualizar.Picture)) + ;
            " Impr=" + TRANSFORM(FILE(loc_oForm.cmd_4c_Imprimir.Picture)) + ;
            " Proc=" + TRANSFORM(FILE(loc_oForm.cmd_4c_Processar.Picture)) + ;
            " VideoCap=[" + ALLTRIM(loc_oForm.cmd_4c_Visualizar.Caption) + "]" + ;
            " ImprCap=["  + ALLTRIM(loc_oForm.cmd_4c_Imprimir.Caption) + "]" + CHR(13) + CHR(10), ARQ_LOG, 1)

        *-- Cursores da Fase 4 vivem na datasession PRIVADA do form
        SET DATASESSION TO loc_oForm.DataSessionId

        STRTOFILE("H: CURSORES" + ;
            " SaldoAnt=" + TRANSFORM(USED("cursor_4c_SaldoAnt")) + ;
            " Entradas=" + TRANSFORM(USED("cursor_4c_Entradas")) + ;
            " Saidas="   + TRANSFORM(USED("cursor_4c_Saidas")) + ;
            " Saldos="   + TRANSFORM(USED("cursor_4c_Saldos")) + ;
            " Falhas="   + TRANSFORM(USED("cursor_4c_Falhas")) + ;
            " Resumo="   + TRANSFORM(USED("cursor_4c_Resumo")) + CHR(13) + CHR(10), ARQ_LOG, 1)

        STRTOFILE("I: GRIDS ColCount=" + ;
            TRANSFORM(loc_oForm.cnt_4c_Resultado.cnt_4c_Detalhe.grd_4c_Dados.ColumnCount) + ;
            " Resultado.Visible=" + TRANSFORM(loc_oForm.cnt_4c_Resultado.Visible) + ;
            " Detalhe.Visible="   + TRANSFORM(loc_oForm.cnt_4c_Resultado.cnt_4c_Detalhe.Visible) + ;
            " Resumo.Visible="    + TRANSFORM(loc_oForm.cnt_4c_Resultado.cnt_4c_Resumo.Visible) + CHR(13) + CHR(10), ARQ_LOG, 1)

        *-- Totais: o BO calcula, o form espelha
        loc_oBO = loc_oForm.this_oBusinessObject
        loc_oBO.this_nSaldoInicial      = 11.111
        loc_oBO.this_nSaldoAnterior     = 22.222
        loc_oBO.this_nEntradas          = 33.333
        loc_oBO.this_nTotalEntradas     = 44.444
        loc_oBO.this_nSaidas            = 55.555
        loc_oBO.this_nPesagem           = 66.666
        loc_oBO.this_nSaldo             = 77.777
        loc_oBO.this_nSaldoFuncionarios = 88.888
        loc_oBO.this_nFalhaFuncionarios = 99.999
        loc_oBO.this_nSaldoTotal        = 12.345

        *-- Popular os cursores como o processamento faz
        SELECT cursor_4c_SaldoAnt
        APPEND BLANK
        REPLACE Grupos WITH "GRU1", Contas WITH "CTA1", Qtde WITH 10.500, Emps WITH "001"
        STRTOFILE("J1: SaldoAnt populado" + CHR(13) + CHR(10), ARQ_LOG, 1)

        SELECT cursor_4c_Entradas
        APPEND BLANK
        REPLACE Emps WITH "001", TpOps WITH "ENTRADA", Qtde WITH 20.250
        STRTOFILE("J2: Entradas populado" + CHR(13) + CHR(10), ARQ_LOG, 1)

        SELECT cursor_4c_Saidas
        APPEND BLANK
        REPLACE Emps WITH "001", TpOps WITH "SAIDA", Qtde WITH 5.125
        STRTOFILE("J3: Saidas populado" + CHR(13) + CHR(10), ARQ_LOG, 1)

        SELECT cursor_4c_Saldos
        APPEND BLANK
        REPLACE Grupos WITH "GRU2", Contas WITH "CTA2", Qtde WITH 30.750, Emps WITH "001"
        STRTOFILE("J4: Saldos populado" + CHR(13) + CHR(10), ARQ_LOG, 1)

        SELECT cursor_4c_Falhas
        APPEND BLANK
        REPLACE Grupos WITH "GRU3", Contas WITH "CTA3", Qtde WITH 1.500, Emps WITH "001"
        REPLACE Entra WITH 2.000, Saida WITH 3.000
        STRTOFILE("J5: Falhas populado" + CHR(13) + CHR(10), ARQ_LOG, 1)
        STRTOFILE("J: cursores populados" + ;
            " SaldoAnt=" + TRANSFORM(RECCOUNT("cursor_4c_SaldoAnt")) + ;
            " Entradas=" + TRANSFORM(RECCOUNT("cursor_4c_Entradas")) + ;
            " Falhas="   + TRANSFORM(RECCOUNT("cursor_4c_Falhas")) + CHR(13) + CHR(10), ARQ_LOG, 1)

        IF loc_oForm.CarregarDados()
            STRTOFILE("K: CarregarDados OK Resultado.Visible=" + ;
                TRANSFORM(loc_oForm.cnt_4c_Resultado.Visible) + CHR(13) + CHR(10), ARQ_LOG, 1)
        ELSE
            STRTOFILE("K: CarregarDados FALHOU" + CHR(13) + CHR(10), ARQ_LOG, 1)
        ENDIF

        loc_oG = loc_oForm.cnt_4c_Resultado.cnt_4c_Detalhe.grd_4c_Dados
        STRTOFILE("L: BIND Detalhe RS=[" + loc_oG.RecordSource + "]" + ;
            " C1=[" + loc_oG.Column1.ControlSource + "]" + ;
            " H1=[" + loc_oG.Column1.Header1.Caption + "]" + ;
            " H2=[" + loc_oG.Column2.Header1.Caption + "]" + ;
            " H3=[" + loc_oG.Column3.Header1.Caption + "]" + ;
            " W=" + TRANSFORM(loc_oG.Column1.Width) + "/" + ;
                    TRANSFORM(loc_oG.Column2.Width) + "/" + ;
                    TRANSFORM(loc_oG.Column3.Width) + CHR(13) + CHR(10), ARQ_LOG, 1)

        loc_oG = loc_oForm.cnt_4c_Resultado.cnt_4c_Detalhe2.grd_4c_Dados
        STRTOFILE("M: BIND Detalhe2 RS=[" + loc_oG.RecordSource + "]" + ;
            " C1=[" + loc_oG.Column1.ControlSource + "]" + ;
            " H1=[" + loc_oG.Column1.Header1.Caption + "]" + CHR(13) + CHR(10), ARQ_LOG, 1)

        loc_oG = loc_oForm.cnt_4c_Resultado.cnt_4c_Detalhe5.grd_4c_Dados
        STRTOFILE("N: BIND Detalhe5 RS=[" + loc_oG.RecordSource + "]" + ;
            " H1=[" + loc_oG.Column1.Header1.Caption + "]" + ;
            " H2=[" + loc_oG.Column2.Header1.Caption + "]" + ;
            " H3=[" + loc_oG.Column3.Header1.Caption + "]" + ;
            " Visible=" + TRANSFORM(loc_oForm.cnt_4c_Resultado.cnt_4c_Detalhe5.Visible) + CHR(13) + CHR(10), ARQ_LOG, 1)

        loc_oRes = loc_oForm.cnt_4c_Resultado.cnt_4c_Resumo
        STRTOFILE("O: RESUMO Saldoi=" + TRANSFORM(loc_oRes.txt_4c_Saldoi.Value) + ;
            " SaldoAnt="  + TRANSFORM(loc_oRes.txt_4c_SaldoAnt.Value) + ;
            " Entradas="  + TRANSFORM(loc_oRes.txt_4c_Entradas.Value) + ;
            " TEntradas=" + TRANSFORM(loc_oRes.txt_4c_TEntradas.Value) + ;
            " Saidas="    + TRANSFORM(loc_oRes.txt_4c_Saidas.Value) + ;
            " Pesagem="   + TRANSFORM(loc_oRes.txt_4c_Pesagem.Value) + ;
            " Saldo="     + TRANSFORM(loc_oRes.txt_4c_Saldo.Value) + ;
            " SaldoFunc=" + TRANSFORM(loc_oRes.txt_4c_SaldoFunc.Value) + ;
            " FalhaFunc=" + TRANSFORM(loc_oRes.txt_4c_FalhaFunc.Value) + ;
            " SaldoT="    + TRANSFORM(loc_oRes.txt_4c_SaldoT.Value) + CHR(13) + CHR(10), ARQ_LOG, 1)

        SET DATASESSION TO 1
        loc_oForm.Release()
        STRTOFILE("P: Release OK" + CHR(13) + CHR(10), ARQ_LOG, 1)
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
