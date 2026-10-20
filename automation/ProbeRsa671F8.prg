*==============================================================================
* ProbeRsa671F8.prg - Instancia FormSigPrRsa headless (Fase 8 / task671) e
* exercita o que a fase acrescentou/consertou:
*   (1) escopo dos metodos do BO chamados DE FORA pelo form (regra #51) e dos
*       metodos de contrato do form (regra #3);
*   (2) deteccao da AUSENCIA de fRecalculaP: UMA medicao, sem dialogo por item
*       - era isso que travava o modo parametrizado (Fortyus.Exe);
*   (3) par Commit/Rollback inerte quando a conexao NAO esta em transacao
*       manual (gnConnHandle invalido no harness);
*   (4) hooks de contrato da Fase 8: FormParaBO/BOParaForm/LimparCampos/
*       HabilitarCampos/CarregarLista/AjustarBotoesPorModo/Btn*Click;
*   (5) BtnProcessarClick TERMINA e reporta UMA vez (nao fica em loop).
* NAO chama ConfigurarAmbiente() (nao retorna nesta maquina).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste, gnConnHandle
gnConnHandle           = 0
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_rsa671_f8.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cOut, loc_oForm, loc_oErro, loc_oBO, loc_nAntes, loc_lOk1, loc_lOk2
loc_cOut = "C:\4c\automation\probe_rsa671_f8_result.txt"
STRTOFILE("INICIO", loc_cOut)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gb_4c_ModoTeste   = .T.
    gb_4c_ValidandoUI = .T.

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
    SET PROCEDURE TO (gcCaminhoClasses + "SigPrRsaBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigPrRsa.prg") ADDITIVE
    STRTOFILE(CHR(13)+CHR(10)+"deps OK gnConnHandle=" + TRANSFORM(gnConnHandle), loc_cOut, 1)

    loc_oForm = CREATEOBJECT("FormSigPrRsa")
    STRTOFILE(CHR(13)+CHR(10)+"CREATEOBJECT=" + VARTYPE(loc_oForm), loc_cOut, 1)

    IF VARTYPE(loc_oForm) = "O"
        loc_oBO = loc_oForm.this_oBusinessObject

        *-- (1a) Escopo dos metodos do BO que o FORM chama de fora. PEMSTATUS
        *   atributo 2 = PROTECTED. Todos tem de sair .F. (regra #51): o
        *   PROTECTED de qualquer nivel da heranca ja bloquearia a chamada, e
        *   o erro apareceria so ao PROCESSAR, nunca na compilacao.
        STRTOFILE(CHR(13)+CHR(10)+"ESCOPO-BO prot: " + ;
            "BuscarFila=" + TRANSFORM(PEMSTATUS(loc_oBO,"BuscarFila",2)) + ;
            " CarregarDoCursor=" + TRANSFORM(PEMSTATUS(loc_oBO,"CarregarDoCursor",2)) + ;
            " ProcessarItem=" + TRANSFORM(PEMSTATUS(loc_oBO,"ProcessarItem",2)) + ;
            " VerificarMovimento=" + TRANSFORM(PEMSTATUS(loc_oBO,"VerificarMovimento",2)) + ;
            " Excluir=" + TRANSFORM(PEMSTATUS(loc_oBO,"Excluir",2)) + ;
            " MarcarEmProcessamento=" + TRANSFORM(PEMSTATUS(loc_oBO,"MarcarEmProcessamento",2)) + ;
            " DesfazerTransacao=" + TRANSFORM(PEMSTATUS(loc_oBO,"DesfazerTransacao",2)) + ;
            " ConfirmarTransacao=" + TRANSFORM(PEMSTATUS(loc_oBO,"ConfirmarTransacao",2)) + ;
            " GravarLog=" + TRANSFORM(PEMSTATUS(loc_oBO,"GravarLog",2)) + ;
            " IniciarLog=" + TRANSFORM(PEMSTATUS(loc_oBO,"IniciarLog",2)), loc_cOut, 1)

        *-- (1b) Escopo no FORM. Os chamados pelo TesteAutomatico de fora da
        *   classe tem de ser PUBLIC (.F.); os hooks herdados de FormBase
        *   continuam PROTECTED (.T.) porque o VFP9 nao deixa alargar escopo.
        STRTOFILE(CHR(13)+CHR(10)+"ESCOPO-FORM prot: " + ;
            "BtnProcessarClick=" + TRANSFORM(PEMSTATUS(loc_oForm,"BtnProcessarClick",2)) + ;
            " BtnEncerrarClick=" + TRANSFORM(PEMSTATUS(loc_oForm,"BtnEncerrarClick",2)) + ;
            " BtnBuscarClick=" + TRANSFORM(PEMSTATUS(loc_oForm,"BtnBuscarClick",2)) + ;
            " BtnSalvarClick=" + TRANSFORM(PEMSTATUS(loc_oForm,"BtnSalvarClick",2)) + ;
            " BtnCancelarClick=" + TRANSFORM(PEMSTATUS(loc_oForm,"BtnCancelarClick",2)) + ;
            " BtnIncluirClick=" + TRANSFORM(PEMSTATUS(loc_oForm,"BtnIncluirClick",2)) + ;
            " CarregarLista=" + TRANSFORM(PEMSTATUS(loc_oForm,"CarregarLista",2)) + ;
            " AjustarBotoesPorModo=" + TRANSFORM(PEMSTATUS(loc_oForm,"AjustarBotoesPorModo",2)) + ;
            " AlternarPagina=" + TRANSFORM(PEMSTATUS(loc_oForm,"AlternarPagina",2)) + ;
            " HabilitarCampos=" + TRANSFORM(PEMSTATUS(loc_oForm,"HabilitarCampos",2)) + ;
            " ValidarPrioridade=" + TRANSFORM(PEMSTATUS(loc_oForm,"ValidarPrioridade",2)) + ;
            " ReportarFalha=" + TRANSFORM(PEMSTATUS(loc_oForm,"ReportarFalhaProcessamento",2)) + ;
            " FormParaBO=" + TRANSFORM(PEMSTATUS(loc_oForm,"FormParaBO",2)) + ;
            " BOParaForm=" + TRANSFORM(PEMSTATUS(loc_oForm,"BOParaForm",2)) + ;
            " LimparCampos=" + TRANSFORM(PEMSTATUS(loc_oForm,"LimparCampos",2)), loc_cOut, 1)

        *-- (3) Transacao: handle invalido no harness -> par INERTE, sem
        *   excecao (SQLGETPROP com handle invalido DISPARA, dai a guarda).
        STRTOFILE(CHR(13)+CHR(10)+"TRANSACAO Manual=" + TRANSFORM(loc_oBO.this_lTransacaoManual) + ;
            " Confirmar=" + TRANSFORM(loc_oBO.ConfirmarTransacao()), loc_cOut, 1)
        loc_oBO.DesfazerTransacao()
        STRTOFILE(CHR(13)+CHR(10)+"DESFAZER chamada=OK (sem excecao)", loc_cOut, 1)

        *-- (2) AUSENCIA de fRecalculaP medida UMA vez.
        STRTOFILE(CHR(13)+CHR(10)+"RECALC antes Disponivel=" + ;
            TRANSFORM(loc_oBO.this_lRecalculoDisponivel), loc_cOut, 1)
        loc_lOk1 = loc_oBO.ProcessarItem()
        STRTOFILE(CHR(13)+CHR(10)+"RECALC 1a chamada ret=" + TRANSFORM(loc_lOk1) + ;
            " Disponivel=" + TRANSFORM(loc_oBO.this_lRecalculoDisponivel) + ;
            " Msg=[" + ALLTRIM(loc_oBO.this_cMensagemErro) + "]", loc_cOut, 1)
        *-- 2a chamada: tem de sair pela porta do gate, sem nova excecao
        loc_oBO.this_cMensagemErro = "SENTINELA"
        loc_lOk2 = loc_oBO.ProcessarItem()
        STRTOFILE(CHR(13)+CHR(10)+"RECALC 2a chamada ret=" + TRANSFORM(loc_lOk2) + ;
            " MsgIntacta=" + TRANSFORM(loc_oBO.this_cMensagemErro == "SENTINELA"), loc_cOut, 1)

        *-- (4) Hooks de contrato da Fase 8
        loc_oForm.txt_4c_Prioridade.Value = 1
        loc_oForm.ValidarPrioridade()
        STRTOFILE(CHR(13)+CHR(10)+"VALIDAR(1) Form=" + TRANSFORM(loc_oForm.this_nPrioridade) + ;
            " BO=" + TRANSFORM(loc_oBO.this_nPrioridade), loc_cOut, 1)

        *-- FormParaBO/BOParaForm/LimparCampos NAO sao chamados daqui de
        *-- proposito: FormBase.prg os declara PROTECTED e o VFP9 nao deixa a
        *-- subclasse ALARGAR o escopo herdado, entao de fora da classe eles
        *-- estouram "Property X is not found" ainda que PEMSTATUS(...,5)
        *-- devolva .T. (so verifica EXISTENCIA). O escopo deles ja foi medido
        *-- no bloco ESCOPO-FORM acima, e quem os exercita eh o proprio form,
        *-- por THIS. O que resta verificar aqui sao os metodos PUBLIC.
        loc_oForm.HabilitarCampos(.F.)
        STRTOFILE(CHR(13)+CHR(10)+"HABILITAR(.F.) ReadOnly=" + TRANSFORM(loc_oForm.txt_4c_Prioridade.ReadOnly) + ;
            " ProcessarEnabled=" + TRANSFORM(loc_oForm.cmd_4c_Processar.Enabled), loc_cOut, 1)
        loc_oForm.HabilitarCampos(.T.)
        STRTOFILE(CHR(13)+CHR(10)+"HABILITAR(.T.) ReadOnly=" + TRANSFORM(loc_oForm.txt_4c_Prioridade.ReadOnly) + ;
            " ProcessarEnabled=" + TRANSFORM(loc_oForm.cmd_4c_Processar.Enabled), loc_cOut, 1)

        STRTOFILE(CHR(13)+CHR(10)+"CONTRATO CarregarLista=" + TRANSFORM(loc_oForm.CarregarLista()) + ;
            " BtnBuscar=" + TRANSFORM(loc_oForm.BtnBuscarClick()) + ;
            " BtnSalvar=" + TRANSFORM(loc_oForm.BtnSalvarClick()) + ;
            " BtnCancelar=" + TRANSFORM(loc_oForm.BtnCancelarClick()) + ;
            " BtnIncluir=" + TRANSFORM(loc_oForm.BtnIncluirClick()), loc_cOut, 1)
        loc_oForm.AjustarBotoesPorModo()
        loc_oForm.AlternarPagina(1)
        STRTOFILE(CHR(13)+CHR(10)+"CONTRATO AjustarBotoes/AlternarPagina=OK", loc_cOut, 1)

        *-- ReportarFalhaProcessamento em modo PARAMETRIZADO: vai para o
        *   Fortyus.Log e NAO abre dialogo (um modal ali trava o lote).
        loc_oForm.this_lParametrizado = .T.
        IF FILE("Fortyus.Log")
            DELETE FILE "Fortyus.Log"
        ENDIF
        loc_oForm.ReportarFalhaProcessamento("TESTE-LOTE", .T.)
        loc_oForm.this_lParametrizado = .F.
        STRTOFILE(CHR(13)+CHR(10)+"REPORTAR-LOTE LogCriado=" + TRANSFORM(FILE("Fortyus.Log")) + ;
            " Conteudo=[" + IIF(FILE("Fortyus.Log"), ALLTRIM(CHRTRAN(FILETOSTR("Fortyus.Log"), CHR(13)+CHR(10), "  ")), "") + "]", loc_cOut, 1)

        *-- (5) BtnProcessarClick inteiro em modo INTERATIVO. Sem SQL Server o
        *   BuscarFila falha -> loc_lErroCnx -> UMA passada e sai. O script
        *   TERMINAR dentro do timeout eh a prova de que o loop nao fica
        *   girando nem trava num dialogo (em ModoTeste MsgErro grava em
        *   arquivo em vez de abrir caixa).
        loc_oForm.txt_4c_Prioridade.Value = 0
        loc_oForm.BtnProcessarClick()
        STRTOFILE(CHR(13)+CHR(10)+"PROCESSAR retornou ProcessarEnabled=" + ;
            TRANSFORM(loc_oForm.cmd_4c_Processar.Enabled) + ;
            " EncerrarEnabled=" + TRANSFORM(loc_oForm.cmd_4c_Encerrar.Enabled) + ;
            " Progresso=[" + ALLTRIM(loc_oForm.lbl_4c_Progresso.Caption) + "]", loc_cOut, 1)

        loc_oForm.Release()
        STRTOFILE(CHR(13)+CHR(10)+"RESULTADO=OK", loc_cOut, 1)
    ELSE
        STRTOFILE(CHR(13)+CHR(10)+"RESULTADO=FALHA_CREATEOBJECT", loc_cOut, 1)
    ENDIF

CATCH TO loc_oErro
    STRTOFILE(CHR(13)+CHR(10)+"EXCECAO: " + loc_oErro.Message + ;
              " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
              " PROC=" + loc_oErro.Procedure, loc_cOut, 1)
ENDTRY

QUIT
