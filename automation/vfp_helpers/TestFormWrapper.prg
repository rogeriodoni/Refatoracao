*==============================================================================
* TestFormWrapper.prg
*
* PROPOSITO: Wrapper para testar formularios migrados automaticamente
*            Captura erros, testa botoes, salva log estruturado
*
* CHAMADA:   VFP.EXE -C extract.fpw (config.fpw define variaveis)
*            OU: DO TestFormWrapper WITH "FormCor", "C:\4c\tasks\task001\logs\test.log"
*
* RETORNO:   0 = Sucesso (form abriu e botoes funcionaram)
*            1 = Erro ao criar objeto
*            2 = Erro ao mostrar form
*            3 = Erro ao clicar botoes
*
* AUTOR:     Sistema de Migracao Automatizada
* DATA:      2026-01-22
*==============================================================================

LPARAMETERS par_cFormClass, par_cLogFile

*-- Variaveis PUBLICAS para o tratamento de erros (acessiveis nas procedures)
PUBLIC gp_cLogFile, gp_cInicioTeste, gp_lSucesso, gp_nErros, gp_aErros
gp_cLogFile = ""
gp_cInicioTeste = DATETIME()
gp_lSucesso = .T.
gp_nErros = 0
PUBLIC ARRAY gp_aErros[1]

*-- MODO TESTE: Suprimir dialogs (MostrarErro, MsgErro, etc.) para evitar TIMEOUT
*-- Erros sao gravados em gc_4c_ArquivoErroTeste ao inves de mostrar dialog modal
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = ""  && Sera definido apos validar par_cLogFile

LOCAL loc_oForm, loc_cErroMsg, loc_nReturnCode
LOCAL loc_i
LOCAL loc_cLogContent, loc_cInicioTeste, loc_cLogDir

loc_nReturnCode = 0
loc_cInicioTeste = DATETIME()

*-- Le variaveis de ambiente do config.fpw (se nao foram passadas como parametro)
IF EMPTY(par_cFormClass) AND TYPE("_FORM_CLASS") = "C"
    par_cFormClass = _FORM_CLASS
ENDIF

IF EMPTY(par_cLogFile) AND TYPE("_LOG_FILE") = "C"
    par_cLogFile = _LOG_FILE
ENDIF

*-- Validacao de parametros
IF EMPTY(par_cFormClass) OR EMPTY(par_cLogFile)
    ? "ERRO: Parametros invalidos"
    ? "USO: DO TestFormWrapper WITH 'FormCor', 'C:\path\to\log.txt'"
    RETURN 99
ENDIF

*-- Atribui arquivo de log a variavel publica (para acesso nas procedures)
gp_cLogFile = par_cLogFile

*-- Cria diretorio de log se nao existir
loc_cLogDir = JUSTPATH(par_cLogFile)
IF !DIRECTORY(loc_cLogDir)
    MD (loc_cLogDir)
ENDIF

*-- Define arquivo de erro para modo teste (no diretorio PAI do logs/)
*-- Ex: se log = C:\4c\tasks\task031\logs\06_testForm.log
*--     erro = C:\4c\tasks\task031\vfp_error_details.txt
LOCAL loc_cTaskDir
loc_cTaskDir = JUSTPATH(loc_cLogDir)
IF loc_cTaskDir == loc_cLogDir
    *-- Fallback: usar mesmo diretorio do log
    loc_cTaskDir = loc_cLogDir
ENDIF
gc_4c_ArquivoErroTeste = ADDBS(loc_cTaskDir) + "vfp_error_details.txt"
*-- Limpar arquivo anterior se existir
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

*-- Configura tratamento de erros detalhado
*-- Captura: numero do erro, mensagem, linha, programa (usa variaveis publicas)
ON ERROR DO CapturaErro WITH ERROR(), MESSAGE(), LINENO(), PROGRAM()

*-- Log inicial
LOG_Escrever("=== TESTE DE FORMULARIO ===")
LOG_Escrever("Classe: " + par_cFormClass)
LOG_Escrever("Inicio: " + TTOC(loc_cInicioTeste))
LOG_Escrever("")

*------------------------------------------------------------------------
* ETAPA 1: Carregar dependencias e conectar ao banco
*------------------------------------------------------------------------
LOG_Escrever("[ETAPA 1] Carregando dependencias...")

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    *-- CRITICO: Chamar ConfigurarAmbiente para carregar SET PROCEDURE
    ConfigurarAmbiente()
    LOG_Escrever("OK - Dependencias carregadas")
CATCH TO loEx
    LOG_Escrever("ERRO - Falha ao carregar config.prg:")
    LOG_Escrever("       Mensagem: " + loEx.Message)
    LOG_Escrever("       Codigo: " + TRANSFORM(loEx.ErrorNo))
    LOG_Escrever("       Linha: " + TRANSFORM(loEx.LineNo))
    LOG_Escrever("       Procedure: " + loEx.Procedure)
    loc_nReturnCode = 1
    gp_lSucesso = .F.
ENDTRY

IF !gp_lSucesso
    LOG_Finalizar(loc_nReturnCode, gp_aErros, gp_nErros)
    RETURN loc_nReturnCode
ENDIF

*------------------------------------------------------------------------
* ETAPA 1B: Conectar ao banco de dados
*------------------------------------------------------------------------
LOG_Escrever("")
LOG_Escrever("[ETAPA 1B] Conectando ao banco de dados...")

TRY
    PUBLIC gnConnHandle
    gnConnHandle = 0

    LOCAL loc_cStringConexao
    loc_cStringConexao = ObterStringConexao()

    gnConnHandle = SQLSTRINGCONNECT(loc_cStringConexao)

    IF gnConnHandle < 0
        LOCAL ARRAY loc_aErroSQL[1]
        AERROR(loc_aErroSQL)
        LOG_Escrever("ERRO - Falha na conexao SQL:")
        LOG_Escrever("       Codigo: " + TRANSFORM(loc_aErroSQL[1]))
        LOG_Escrever("       Mensagem: " + TRANSFORM(loc_aErroSQL[2]))
        loc_nReturnCode = 1
        gp_lSucesso = .F.
    ELSE
        SQLSETPROP(gnConnHandle, "QueryTimeOut", 60)
        LOG_Escrever("OK - Conectado ao banco (Handle: " + TRANSFORM(gnConnHandle) + ")")
    ENDIF
CATCH TO loEx
    LOG_Escrever("ERRO - Excecao ao conectar ao banco:")
    LOG_Escrever("       Mensagem: " + loEx.Message)
    LOG_Escrever("       Codigo: " + TRANSFORM(loEx.ErrorNo))
    LOG_Escrever("       Linha: " + TRANSFORM(loEx.LineNo))
    loc_nReturnCode = 1
    gp_lSucesso = .F.
ENDTRY

IF !gp_lSucesso
    LOG_Finalizar(loc_nReturnCode, gp_aErros, gp_nErros)
    RETURN loc_nReturnCode
ENDIF

*------------------------------------------------------------------------
* ETAPA 2: Criar objeto do formulario
*------------------------------------------------------------------------
LOG_Escrever("")
LOG_Escrever("[ETAPA 2] Criando objeto do formulario...")

TRY
    loc_oForm = CREATEOBJECT(par_cFormClass)

    IF ISNULL(loc_oForm) OR TYPE("loc_oForm") # "O"
        LOG_Escrever("ERRO - CREATEOBJECT retornou NULL ou tipo invalido")
        loc_nReturnCode = 1
        gp_lSucesso = .F.
    ELSE
        LOG_Escrever("OK - Objeto criado com sucesso")
        LOG_Escrever("     Tipo: " + TYPE("loc_oForm"))
        LOG_Escrever("     Classe: " + loc_oForm.Class)
    ENDIF

CATCH TO loEx
    LOG_Escrever("ERRO - Excecao ao criar objeto:")
    LOG_Escrever("     Mensagem: " + loEx.Message)
    LOG_Escrever("     Codigo: " + TRANSFORM(loEx.ErrorNo))
    LOG_Escrever("     Linha: " + TRANSFORM(loEx.LineNo))
    loc_nReturnCode = 1
    gp_lSucesso = .F.
ENDTRY

IF !gp_lSucesso
    LOG_Finalizar(loc_nReturnCode, gp_aErros, gp_nErros)
    RETURN loc_nReturnCode
ENDIF

*------------------------------------------------------------------------
* ETAPA 3: Mostrar formulario (nao-modal para poder testar)
*------------------------------------------------------------------------
LOG_Escrever("")
LOG_Escrever("[ETAPA 3] Mostrando formulario (nao-modal)...")

TRY
    loc_oForm.WindowType = 0  && Modeless
    loc_oForm.Show()

    DOEVENTS  && Processa eventos pendentes

    IF loc_oForm.Visible
        LOG_Escrever("OK - Formulario visivel")
        LOG_Escrever("     Width: " + TRANSFORM(loc_oForm.Width))
        LOG_Escrever("     Height: " + TRANSFORM(loc_oForm.Height))
    ELSE
        LOG_Escrever("ERRO - Formulario nao ficou visivel")
        loc_nReturnCode = 2
        gp_lSucesso = .F.
    ENDIF

CATCH TO loEx
    LOG_Escrever("ERRO - Excecao ao mostrar formulario:")
    LOG_Escrever("     Mensagem: " + loEx.Message)
    loc_nReturnCode = 2
    gp_lSucesso = .F.
ENDTRY

IF !gp_lSucesso
    LOG_Finalizar(loc_nReturnCode, gp_aErros, gp_nErros)
    IF TYPE("loc_oForm") = "O" AND !ISNULL(loc_oForm)
        loc_oForm.Release()
    ENDIF
    RETURN loc_nReturnCode
ENDIF

*------------------------------------------------------------------------
* ETAPA 4: Testar botoes principais (simular cliques)
*------------------------------------------------------------------------
LOG_Escrever("")
LOG_Escrever("[ETAPA 4] Testando botoes principais...")

*-- Lista de botoes comuns para testar (PageFrame -> Page1 -> Container)
LOCAL loc_aBotoes[5, 2]
loc_aBotoes[1, 1] = "pgf_4c_Principal.Page1.cnt_4c_Botoes.cmd_4c_Incluir"
loc_aBotoes[1, 2] = "Incluir"
loc_aBotoes[2, 1] = "pgf_4c_Principal.Page1.cnt_4c_Botoes.cmd_4c_Alterar"
loc_aBotoes[2, 2] = "Alterar"
loc_aBotoes[3, 1] = "pgf_4c_Principal.Page1.cnt_4c_Botoes.cmd_4c_Visualizar"
loc_aBotoes[3, 2] = "Visualizar"
loc_aBotoes[4, 1] = "pgf_4c_Principal.Page1.cnt_4c_Botoes.cmd_4c_Excluir"
loc_aBotoes[4, 2] = "Excluir"
loc_aBotoes[5, 1] = "pgf_4c_Principal.Page1.cnt_4c_Botoes.cmd_4c_Pesquisar"
loc_aBotoes[5, 2] = "Pesquisar"

LOCAL loc_nBotoesTeste, loc_nBotoesOK, loc_cPathBotao, loc_oBotao
loc_nBotoesTeste = 0
loc_nBotoesOK = 0

FOR loc_i = 1 TO ALEN(loc_aBotoes, 1)
    loc_cPathBotao = loc_aBotoes[loc_i, 1]

    TRY
        *-- Verifica se botao existe
        loc_oBotao = EVALUATE("loc_oForm." + loc_cPathBotao)

        IF TYPE("loc_oBotao") = "O" AND !ISNULL(loc_oBotao)
            loc_nBotoesTeste = loc_nBotoesTeste + 1

            LOG_Escrever("  [" + loc_aBotoes[loc_i, 2] + "] Testando...")

            *-- Simula clique
            loc_oBotao.Click()

            DOEVENTS  && Processa eventos

            *-- Se chegou aqui, clique nao gerou erro
            LOG_Escrever("  [" + loc_aBotoes[loc_i, 2] + "] OK - Clique executado sem erro")
            loc_nBotoesOK = loc_nBotoesOK + 1

            *-- Se abriu algum form modal, fecha
            IF WEXIST(WONTOP()) AND WONTOP() # loc_oForm.Name
                KEYBOARD "{ESC}"  && Fecha janela modal
                DOEVENTS
            ENDIF
        ENDIF

    CATCH TO loEx
        LOG_Escrever("  [" + loc_aBotoes[loc_i, 2] + "] ERRO:")
        LOG_Escrever("       Mensagem: " + loEx.Message)
        LOG_Escrever("       Codigo: " + TRANSFORM(loEx.ErrorNo))
        loc_nReturnCode = 3
        gp_lSucesso = .F.
    ENDTRY
ENDFOR

LOG_Escrever("")
LOG_Escrever("Resumo dos testes de botoes:")
LOG_Escrever("  Botoes testados: " + TRANSFORM(loc_nBotoesTeste))
LOG_Escrever("  Botoes OK: " + TRANSFORM(loc_nBotoesOK))
LOG_Escrever("  Botoes com erro: " + TRANSFORM(loc_nBotoesTeste - loc_nBotoesOK))

IF loc_nBotoesTeste = 0
    LOG_Escrever("")
    LOG_Escrever("AVISO: Nenhum botao foi encontrado para testar")
    LOG_Escrever("       Verifique se a estrutura do form segue o padrao:")
    LOG_Escrever("       pgf_4c_Principal.Page1.cnt_4c_Botoes.cmd_4c_*")
ENDIF

*------------------------------------------------------------------------
* ETAPA 5: Fechar formulario
*------------------------------------------------------------------------
LOG_Escrever("")
LOG_Escrever("[ETAPA 5] Fechando formulario...")

TRY
    loc_oForm.Release()
    LOG_Escrever("OK - Formulario fechado")
CATCH TO loEx
    LOG_Escrever("ERRO - Falha ao fechar formulario: " + loEx.Message)
ENDTRY

*------------------------------------------------------------------------
* ETAPA 6: Desconectar do banco
*------------------------------------------------------------------------
LOG_Escrever("")
LOG_Escrever("[ETAPA 6] Desconectando do banco...")

TRY
    IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
        SQLDISCONNECT(gnConnHandle)
        gnConnHandle = 0
        LOG_Escrever("OK - Desconectado do banco")
    ELSE
        LOG_Escrever("INFO - Nao havia conexao ativa")
    ENDIF
CATCH TO loEx
    LOG_Escrever("ERRO - Falha ao desconectar: " + loEx.Message)
ENDTRY

*------------------------------------------------------------------------
* FINALIZACAO
*------------------------------------------------------------------------
LOG_Finalizar(loc_nReturnCode, gp_aErros, gp_nErros)

ON ERROR  && Remove tratamento de erros

RETURN loc_nReturnCode

*==============================================================================
* FUNCOES AUXILIARES
*==============================================================================

*------------------------------------------------------------------------------
* LOG_Escrever - Escreve linha no log
*------------------------------------------------------------------------------
PROCEDURE LOG_Escrever(par_cLinha)
    LOCAL loc_nHandle

    IF EMPTY(gp_cLogFile)
        RETURN
    ENDIF

    *-- Mostra no console tambem (para debug)
    ? par_cLinha

    *-- Escreve no arquivo (append mode)
    IF FILE(gp_cLogFile)
        loc_nHandle = FOPEN(gp_cLogFile, 1)  && Abre para escrita
    ELSE
        loc_nHandle = FCREATE(gp_cLogFile)   && Cria novo arquivo
    ENDIF

    IF loc_nHandle > 0
        =FSEEK(loc_nHandle, 0, 2)  && Vai para o final do arquivo
        =FPUTS(loc_nHandle, par_cLinha)
        =FCLOSE(loc_nHandle)
    ENDIF
ENDPROC

*------------------------------------------------------------------------------
* CapturaErro - Captura erros via ON ERROR com detalhes
* Usa variaveis publicas: gp_lSucesso, gp_nErros, gp_aErros
*------------------------------------------------------------------------------
PROCEDURE CapturaErro(par_nErroNum, par_cErroMsg, par_nLinha, par_cPrograma)

    gp_lSucesso = .F.
    gp_nErros = gp_nErros + 1
    DIMENSION gp_aErros[gp_nErros]

    LOCAL loc_cDetalhe
    loc_cDetalhe = "Erro #" + TRANSFORM(par_nErroNum) + ;
                   " | Linha: " + TRANSFORM(par_nLinha) + ;
                   " | Programa: " + par_cPrograma + ;
                   " | " + par_cErroMsg

    gp_aErros[gp_nErros] = loc_cDetalhe

    *-- Log imediato do erro
    LOG_Escrever("*** ON ERROR: " + loc_cDetalhe)
ENDPROC

*------------------------------------------------------------------------------
* LOG_Finalizar - Escreve resumo final e erros
*------------------------------------------------------------------------------
PROCEDURE LOG_Finalizar(par_nReturnCode, par_aErros, par_nErros)
    LOCAL loc_cFimTeste, loc_nDuracao, loc_i

    loc_cFimTeste = DATETIME()
    loc_nDuracao = loc_cFimTeste - gp_cInicioTeste

    LOG_Escrever("")
    LOG_Escrever("=== RESULTADO DO TESTE ===")
    LOG_Escrever("Fim: " + TTOC(loc_cFimTeste))
    LOG_Escrever("Duracao: " + TRANSFORM(loc_nDuracao) + " segundos")
    LOG_Escrever("Return Code: " + TRANSFORM(par_nReturnCode))

    DO CASE
        CASE par_nReturnCode = 0
            LOG_Escrever("Status: SUCESSO")
        CASE par_nReturnCode = 1
            LOG_Escrever("Status: ERRO AO CRIAR OBJETO")
        CASE par_nReturnCode = 2
            LOG_Escrever("Status: ERRO AO MOSTRAR FORM")
        CASE par_nReturnCode = 3
            LOG_Escrever("Status: ERRO AO CLICAR BOTOES")
        OTHERWISE
            LOG_Escrever("Status: ERRO DESCONHECIDO")
    ENDCASE

    IF par_nErros > 0
        LOG_Escrever("")
        LOG_Escrever("=== ERROS CAPTURADOS (ON ERROR) ===")
        FOR loc_i = 1 TO par_nErros
            LOG_Escrever("[" + TRANSFORM(loc_i) + "] " + par_aErros[loc_i])
        ENDFOR
    ENDIF

    LOG_Escrever("")
    LOG_Escrever("===========================")
ENDPROC
