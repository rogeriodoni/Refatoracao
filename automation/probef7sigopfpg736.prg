*==============================================================================
* probef7sigopfpg736.prg - Exercita em RUNTIME a Fase 7 do FormSigOpFpg
* (task736): os 5 handlers de Click (CmdApagaClick/CmdOkClick/
* CmdCancelaClick/CmdConfirmaCartaoClick/CmdAlteraCotacaoClick), os BINDEVENT
* que os ligam e os tres metodos do legado que eles acionam
* (MostrarObservacao/CartaoCredito/FecharDialogo).
*
* Setup conforme a receita medida nesta maquina: NAO chamar
* ConfigurarAmbiente() - DO config.prg + SET PATH + SET PROCEDURE a mao.
* gb_4c_ModoTeste + gc_4c_ArquivoErroTeste SEMPRE em par, senao MsgAviso cai
* num MESSAGEBOX real e o processo trava sem produzir resultado.
*
* Script auxiliar de pipeline: SET SAFETY OFF + SET RESOURCE OFF (regra #6).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_m736\probe_f7_dialogs.txt"
gnConnHandle           = 0

LOCAL loc_cLog, loc_cOut
loc_cLog = "C:\4c\automation\_m736\probe_f7_sigopfpg.txt"
loc_cOut = "=== PROBE Fase 7 - FormSigOpFpg (task736) ===" + CHR(13) + CHR(10)

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

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
SET PROCEDURE TO (gcCaminhoClasses + "SigOpFpgBO.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpFpg.prg") ADDITIVE

loc_cOut = loc_cOut + "[1] Setup concluido" + CHR(13) + CHR(10)
STRTOFILE(loc_cOut, loc_cLog)

LOCAL loc_oForm, loc_oErro, loc_nI, loc_cNome, loc_nQtd
LOCAL ARRAY laEv[1, 5]

TRY
    loc_oForm = CREATEOBJECT("FormSigOpFpg", .NULL., 0, .F.)
CATCH TO loc_oErro
    loc_oForm = .NULL.
    loc_cOut = loc_cOut + "[2] FALHA no CREATEOBJECT: " + loc_oErro.Message + ;
        " | Linha " + TRANSFORM(loc_oErro.LineNo) + ;
        " | Proc " + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY
STRTOFILE(loc_cOut, loc_cLog)

IF VARTYPE(loc_oForm) = "O"
    loc_cOut = loc_cOut + "[2] Form instanciado OK" + CHR(13) + CHR(10)
    STRTOFILE(loc_cOut, loc_cLog)

    *-- [3] Os 5 handlers existem e sao PUBLIC (atributo 2 = PROTECTED)
    FOR loc_nI = 1 TO 7
        loc_cNome = ICASE(loc_nI = 1, "CmdApagaClick", ;
                          loc_nI = 2, "CmdOkClick", ;
                          loc_nI = 3, "CmdCancelaClick", ;
                          loc_nI = 4, "CmdConfirmaCartaoClick", ;
                          loc_nI = 5, "CmdAlteraCotacaoClick", ;
                          loc_nI = 6, "MostrarObservacao", ;
                          "CartaoCredito")

        loc_cOut = loc_cOut + "[3] " + PADR(loc_cNome, 24) + ;
            " existe=" + TRANSFORM(PEMSTATUS(loc_oForm, loc_cNome, 5)) + ;
            " protected=" + TRANSFORM(PEMSTATUS(loc_oForm, loc_cNome, 2)) + ;
            CHR(13) + CHR(10)
    ENDFOR
    STRTOFILE(loc_cOut, loc_cLog)

    *-- [4] BINDEVENT: cada botao tem o Click ligado ao form
    loc_nQtd = AEVENTS(laEv, loc_oForm.cmd_4c_Apaga)
    loc_cOut = loc_cOut + "[4] binds de cmd_4c_Apaga=" + TRANSFORM(loc_nQtd) + ;
        IIF(loc_nQtd > 0, " -> " + laEv[1, 3] + "/" + laEv[1, 4], "") + CHR(13) + CHR(10)

    loc_nQtd = AEVENTS(laEv, loc_oForm.cmd_4c_Ok)
    loc_cOut = loc_cOut + "[4] binds de cmd_4c_Ok=" + TRANSFORM(loc_nQtd) + ;
        IIF(loc_nQtd > 0, " -> " + laEv[1, 3] + "/" + laEv[1, 4], "") + CHR(13) + CHR(10)

    loc_nQtd = AEVENTS(laEv, loc_oForm.cmd_4c_Cancela)
    loc_cOut = loc_cOut + "[4] binds de cmd_4c_Cancela=" + TRANSFORM(loc_nQtd) + ;
        IIF(loc_nQtd > 0, " -> " + laEv[1, 3] + "/" + laEv[1, 4], "") + CHR(13) + CHR(10)

    loc_nQtd = AEVENTS(laEv, loc_oForm.cmd_4c_Alteracotacao)
    loc_cOut = loc_cOut + "[4] binds de cmd_4c_Alteracotacao=" + TRANSFORM(loc_nQtd) + ;
        IIF(loc_nQtd > 0, " -> " + laEv[1, 3] + "/" + laEv[1, 4], "") + CHR(13) + CHR(10)

    loc_nQtd = AEVENTS(laEv, loc_oForm.cnt_4c_CCred.cmd_4c_Confirma)
    loc_cOut = loc_cOut + "[4] binds de cmd_4c_Confirma=" + TRANSFORM(loc_nQtd) + ;
        IIF(loc_nQtd > 0, " -> " + laEv[1, 3] + "/" + laEv[1, 4], "") + CHR(13) + CHR(10)
    STRTOFILE(loc_cOut, loc_cLog)

    *-- [5] MostrarObservacao sem conexao: os 4 paineis ficam recolhidos
    loc_oForm.MostrarObservacao()
    loc_cOut = loc_cOut + "[5] apos MostrarObservacao: ChequeFP=" + ;
        TRANSFORM(loc_oForm.cnt_4c_ChequeFP.Visible) + ;
        " CarneFP=" + TRANSFORM(loc_oForm.cnt_4c_CarneFP.Visible) + ;
        " OutrosFP=" + TRANSFORM(loc_oForm.cnt_4c_OutrosFP.Visible) + ;
        " CCredFP=" + TRANSFORM(loc_oForm.cnt_4c_CCredFP.Visible) + ;
        " GetObs=" + TRANSFORM(loc_oForm.obj_4c_GetObs.Visible) + CHR(13) + CHR(10)
    STRTOFILE(loc_cOut, loc_cLog)

    *-- [6] CartaoCredito(.T.) abre o painel e desabilita o resto;
    *--     CartaoCredito(.F.) inverte (mcartaocred do legado)
    loc_oForm.CartaoCredito(.T.)
    loc_cOut = loc_cOut + "[6] CartaoCredito(.T.): CCred.Visible=" + ;
        TRANSFORM(loc_oForm.cnt_4c_CCred.Visible) + ;
        " CCred.Enabled=" + TRANSFORM(loc_oForm.cnt_4c_CCred.Enabled) + ;
        " grade.Enabled=" + TRANSFORM(loc_oForm.grd_4c_Dados.Enabled) + ;
        " Ok.Enabled=" + TRANSFORM(loc_oForm.cmd_4c_Ok.Enabled) + CHR(13) + CHR(10)

    loc_oForm.CartaoCredito(.F.)
    loc_cOut = loc_cOut + "[6] CartaoCredito(.F.): CCred.Visible=" + ;
        TRANSFORM(loc_oForm.cnt_4c_CCred.Visible) + ;
        " CCred.Enabled=" + TRANSFORM(loc_oForm.cnt_4c_CCred.Enabled) + ;
        " grade.Enabled=" + TRANSFORM(loc_oForm.grd_4c_Dados.Enabled) + ;
        " Ok.Enabled=" + TRANSFORM(loc_oForm.cmd_4c_Ok.Enabled) + CHR(13) + CHR(10)
    STRTOFILE(loc_cOut, loc_cLog)

    *-- [7] CmdApagaClick fora de INSERIR/ALTERAR: guarda de modo recusa
    loc_cOut = loc_cOut + "[7] modo=[" + loc_oForm.this_cOpEscolha + "] " + ;
        "CmdApagaClick=" + TRANSFORM(loc_oForm.CmdApagaClick()) + CHR(13) + CHR(10)
    STRTOFILE(loc_cOut, loc_cLog)

    *-- [8] Em INSERIR: popula a grade, ZAP pelo Apagar (SAFETY da sessao
    *--     privada) e confere que o cursor ficou vazio sem travar.
    *--     cursor_4c_Dados vive na datasession PRIVADA do form (DataSession=2)
    *--     e nao eh visivel da sessao 1 - sem o SET DATASESSION o SELECT
    *--     estoura "Alias not found" e o processo pendura num Program Error.
    loc_oForm.this_cOpEscolha = "INSERIR"
    SET DATASESSION TO loc_oForm.DataSessionId
    loc_cOut = loc_cOut + "[8] datasession do form=" + ;
        TRANSFORM(loc_oForm.DataSessionId) + " SAFETY=" + SET("SAFETY") + ;
        " cursor usado=" + TRANSFORM(USED("cursor_4c_Dados")) + CHR(13) + CHR(10)
    STRTOFILE(loc_cOut, loc_cLog)

    SELECT cursor_4c_Dados
    APPEND BLANK
    REPLACE FPags WITH "001", Valos WITH 100.00, Vencs WITH DATE() IN cursor_4c_Dados
    APPEND BLANK IN cursor_4c_Dados
    REPLACE FPags WITH "002", Valos WITH 50.00 IN cursor_4c_Dados
    loc_oForm.CarregarDados()
    loc_cOut = loc_cOut + "[8] cursor antes do Apagar: reccount=" + ;
        TRANSFORM(RECCOUNT("cursor_4c_Dados")) + CHR(13) + CHR(10)
    STRTOFILE(loc_cOut, loc_cLog)

    *-- [9] CmdOkClick com linha sem vencimento: recusa e NAO fecha
    loc_cOut = loc_cOut + "[9] CmdOkClick (linha 002 sem Vencs)=" + ;
        TRANSFORM(loc_oForm.CmdOkClick()) + ;
        " confirmado=" + TRANSFORM(loc_oForm.this_lConfirmado) + ;
        " recno=" + TRANSFORM(RECNO("cursor_4c_Dados")) + CHR(13) + CHR(10)
    STRTOFILE(loc_cOut, loc_cLog)

    *-- [10] Preenche o vencimento que faltava: CmdOkClick aprova e fecha
    REPLACE Vencs WITH DATE() + 30 IN cursor_4c_Dados
    loc_cOut = loc_cOut + "[10] CmdOkClick (vencimentos ok)=" + ;
        TRANSFORM(loc_oForm.CmdOkClick()) + ;
        " confirmado=" + TRANSFORM(loc_oForm.this_lConfirmado) + ;
        " form vivo=" + TRANSFORM(VARTYPE(loc_oForm) = "O") + CHR(13) + CHR(10)
    STRTOFILE(loc_cOut, loc_cLog)

    *-- [11] Apagar em INSERIR: ZAP + campos zerados + foco
    loc_cOut = loc_cOut + "[11] CmdApagaClick=" + ;
        TRANSFORM(loc_oForm.CmdApagaClick()) + ;
        " reccount=" + TRANSFORM(RECCOUNT("cursor_4c_Dados")) + ;
        " TotForma=" + TRANSFORM(loc_oForm.txt_4c_TotForma.Value) + ;
        " Fpg=[" + ALLTRIM(loc_oForm.txt_4c_Fpg.Value) + "]" + ;
        " Npar=" + TRANSFORM(loc_oForm.txt_4c_Npar.Value) + ;
        " SAFETY=" + SET("SAFETY") + CHR(13) + CHR(10)
    STRTOFILE(loc_cOut, loc_cLog)

    *-- [12] When do botao de cotacao (PodeAlterarCotacao) e o Click, que
    *--      com o When .F. nem abre o dialogo
    loc_cOut = loc_cOut + "[12] PodeAlterarCotacao (Fpg vazio)=" + ;
        TRANSFORM(loc_oForm.PodeAlterarCotacao()) + ;
        " CmdAlteraCotacaoClick=" + TRANSFORM(loc_oForm.CmdAlteraCotacaoClick()) + ;
        CHR(13) + CHR(10)

    loc_oForm.txt_4c_Fpg.Value = "001"
    loc_cOut = loc_cOut + "[12] PodeAlterarCotacao (Fpg=001, INSERIR)=" + ;
        TRANSFORM(loc_oForm.PodeAlterarCotacao()) + CHR(13) + CHR(10)
    loc_oForm.txt_4c_Fpg.Value = ""
    STRTOFILE(loc_cOut, loc_cLog)

    *-- [13] CmdConfirmaCartaoClick fecha o painel sem erro
    loc_oForm.CartaoCredito(.T.)
    loc_cOut = loc_cOut + "[13] CmdConfirmaCartaoClick=" + ;
        TRANSFORM(loc_oForm.CmdConfirmaCartaoClick()) + ;
        " CCred.Visible=" + TRANSFORM(loc_oForm.cnt_4c_CCred.Visible) + ;
        " Ok.Enabled=" + TRANSFORM(loc_oForm.cmd_4c_Ok.Enabled) + CHR(13) + CHR(10)
    STRTOFILE(loc_cOut, loc_cLog)

    *-- [14] Cancelar: this_lConfirmado volta a .F. e o objeto sobrevive
    loc_cOut = loc_cOut + "[14] CmdCancelaClick=" + ;
        TRANSFORM(loc_oForm.CmdCancelaClick()) + ;
        " confirmado=" + TRANSFORM(loc_oForm.this_lConfirmado) + ;
        " form vivo=" + TRANSFORM(VARTYPE(loc_oForm) = "O") + CHR(13) + CHR(10)
    STRTOFILE(loc_cOut, loc_cLog)

    SET DATASESSION TO 1

    loc_oForm.Release()
    loc_oForm = .NULL.
    loc_cOut = loc_cOut + "[15] Form liberado - FIM" + CHR(13) + CHR(10)
ELSE
    loc_cOut = loc_cOut + "[2] Form NAO instanciado" + CHR(13) + CHR(10)
ENDIF

IF FILE(gc_4c_ArquivoErroTeste)
    loc_cOut = loc_cOut + "--- DIALOGS CAPTURADOS ---" + CHR(13) + CHR(10) + ;
        FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10)
ELSE
    loc_cOut = loc_cOut + "--- NENHUM DIALOGO CAPTURADO ---" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(loc_cOut, loc_cLog)

QUIT
