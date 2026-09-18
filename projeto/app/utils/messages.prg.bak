*==============================================================================
* MESSAGES.PRG
* Mensagens padronizadas da aplicacao
* Centraliza todas as mensagens exibidas ao usuario
*==============================================================================

*------------------------------------------------------------------------------
* EscreverErroParaArquivo - Grava erro em arquivo para captura em modo teste
* Quando gb_4c_ModoTeste = .T., dialogs sao suprimidos e erros gravados em
* gc_4c_ArquivoErroTeste para que o pipeline de automacao capture o erro
* mesmo quando VFP trava (TIMEOUT) por causa de um dialog modal.
*
* Parametros: pcMensagem - texto da mensagem
*            pcTitulo - titulo/contexto (opcional)
* Retorno: .T. se gravou no arquivo (modo teste ativo)
*          .F. se modo teste inativo (chamador deve mostrar dialog)
*------------------------------------------------------------------------------
FUNCTION EscreverErroParaArquivo(pcMensagem, pcTitulo)
    LOCAL loc_nHandle, loc_cLinha, loc_cArquivo

    *-- Verificar se estamos em modo teste
    IF TYPE("gb_4c_ModoTeste") != "L"
        RETURN .F.
    ENDIF
    IF !gb_4c_ModoTeste
        RETURN .F.
    ENDIF

    *-- Verificar se arquivo de erro foi definido
    *-- Nota: VFP OR nao faz short-circuit, usar IFs aninhados
    IF TYPE("gc_4c_ArquivoErroTeste") != "C"
        RETURN .F.
    ENDIF
    IF EMPTY(gc_4c_ArquivoErroTeste)
        RETURN .F.
    ENDIF

    loc_cArquivo = gc_4c_ArquivoErroTeste

    *-- Montar linha de erro
    loc_cLinha = "[" + TTOC(DATETIME()) + "] "
    IF VARTYPE(pcTitulo) = "C" AND !EMPTY(pcTitulo)
        loc_cLinha = loc_cLinha + pcTitulo + ": "
    ENDIF
    IF VARTYPE(pcMensagem) = "C"
        loc_cLinha = loc_cLinha + pcMensagem
    ELSE
        loc_cLinha = loc_cLinha + "(mensagem nao-string)"
    ENDIF

    *-- Gravar no arquivo (append)
    IF FILE(loc_cArquivo)
        loc_nHandle = FOPEN(loc_cArquivo, 1)
    ELSE
        loc_nHandle = FCREATE(loc_cArquivo)
    ENDIF

    IF loc_nHandle > 0
        =FSEEK(loc_nHandle, 0, 2)
        =FPUTS(loc_nHandle, loc_cLinha)
        =FCLOSE(loc_nHandle)
    ENDIF

    *-- Tambem imprimir no console para vfp_output.txt
    ? "ERRO_TESTE: " + loc_cLinha

    RETURN .T.
ENDFUNC

*------------------------------------------------------------------------------
* MsgErro - Exibe mensagem de erro
* Parametros: pcMensagem - texto da mensagem
*            pcTitulo - titulo da janela (opcional)
*------------------------------------------------------------------------------
FUNCTION MsgErro(pcMensagem, pcTitulo)
    LOCAL lcTitulo

    lcTitulo = IIF(VARTYPE(pcTitulo) = "C" AND !EMPTY(pcTitulo), ;
                   pcTitulo, ;
                   "Erro")

    *-- Em modo teste, gravar no arquivo e NAO mostrar dialog
    IF EscreverErroParaArquivo(pcMensagem, lcTitulo)
        RETURN 0
    ENDIF

    RETURN MESSAGEBOX(pcMensagem, 16, lcTitulo)
ENDFUNC

*------------------------------------------------------------------------------
* MsgAviso - Exibe mensagem de aviso
* Parametros: pcMensagem - texto da mensagem
*            pcTitulo - titulo da janela (opcional)
*------------------------------------------------------------------------------
FUNCTION MsgAviso(pcMensagem, pcTitulo)
    LOCAL lcTitulo

    lcTitulo = IIF(VARTYPE(pcTitulo) = "C" AND !EMPTY(pcTitulo), ;
                   pcTitulo, ;
                   "Aten" + CHR(231) + CHR(227) + "o")

    *-- Em modo teste, gravar no arquivo e NAO mostrar dialog
    IF EscreverErroParaArquivo(pcMensagem, lcTitulo)
        RETURN 0
    ENDIF

    RETURN MESSAGEBOX(pcMensagem, 48, lcTitulo)
ENDFUNC

*------------------------------------------------------------------------------
* MsgInfo - Exibe mensagem informativa
* Parametros: pcMensagem - texto da mensagem
*            pcTitulo - titulo da janela (opcional)
*------------------------------------------------------------------------------
FUNCTION MsgInfo(pcMensagem, pcTitulo)
    LOCAL lcTitulo

    lcTitulo = IIF(VARTYPE(pcTitulo) = "C" AND !EMPTY(pcTitulo), ;
                   pcTitulo, ;
                   "Informa" + CHR(231) + CHR(227) + "o")

    *-- Em modo teste, gravar no arquivo e NAO mostrar dialog
    IF EscreverErroParaArquivo(pcMensagem, lcTitulo)
        RETURN 0
    ENDIF

    RETURN MESSAGEBOX(pcMensagem, 64, lcTitulo)
ENDFUNC

*------------------------------------------------------------------------------
* MsgSucesso - Exibe mensagem de sucesso
* Parametros: pcMensagem - texto da mensagem
*            pcTitulo - titulo da janela (opcional)
*------------------------------------------------------------------------------
FUNCTION MsgSucesso(pcMensagem, pcTitulo)
    LOCAL lcTitulo

    lcTitulo = IIF(VARTYPE(pcTitulo) = "C" AND !EMPTY(pcTitulo), ;
                   pcTitulo, ;
                   "Sucesso")

    *-- Em modo teste, gravar no arquivo e NAO mostrar dialog
    IF EscreverErroParaArquivo(pcMensagem, lcTitulo)
        RETURN 0
    ENDIF

    RETURN MESSAGEBOX(pcMensagem, 64, lcTitulo)
ENDFUNC

*------------------------------------------------------------------------------
* MsgConfirma - Exibe mensagem de confirmacao (Sim/Nao)
* Parametros: pcMensagem - texto da mensagem
*            pcTitulo - titulo da janela (opcional)
* Retorno: .T. se Sim, .F. se Nao
*------------------------------------------------------------------------------
FUNCTION MsgConfirma(pcMensagem, pcTitulo)
    LOCAL lcTitulo, lnResposta

    lcTitulo = IIF(VARTYPE(pcTitulo) = "C" AND !EMPTY(pcTitulo), ;
                   pcTitulo, ;
                   "Confirma" + CHR(231) + CHR(227) + "o")

    *-- Em modo teste, gravar no arquivo e retornar .F. (nao confirma)
    IF EscreverErroParaArquivo(pcMensagem, lcTitulo)
        RETURN .F.
    ENDIF

    lnResposta = MESSAGEBOX(pcMensagem, 36, lcTitulo)

    RETURN lnResposta = 6  && 6 = Sim
ENDFUNC

*------------------------------------------------------------------------------
* MsgConfirmaExclusao - Mensagem padrao para confirmar exclusao
* Retorno: .T. se confirmou, .F. se cancelou
*------------------------------------------------------------------------------
FUNCTION MsgConfirmaExclusao()
    RETURN MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", "Confirma" + CHR(231) + CHR(227) + "o de Exclus" + CHR(227) + "o")
ENDFUNC

*------------------------------------------------------------------------------
* MsgConfirmaSaida - Mensagem padrao para confirmar saida
* Retorno: .T. se confirmou, .F. se cancelou
*------------------------------------------------------------------------------
FUNCTION MsgConfirmaSaida()
    RETURN MsgConfirma("H" + CHR(225) + " altera" + CHR(231) + CHR(245) + "es n" + CHR(227) + "o salvas. Deseja sair sem salvar?", "Confirmar Sa" + CHR(237) + "da")
ENDFUNC

*------------------------------------------------------------------------------
* MsgSalvoSucesso - Mensagem padrao de registro salvo com sucesso
*------------------------------------------------------------------------------
FUNCTION MsgSalvoSucesso()
    RETURN MsgSucesso("Registro salvo com sucesso!")
ENDFUNC

*------------------------------------------------------------------------------
* MsgExcluidoSucesso - Mensagem padrao de registro excluido com sucesso
*------------------------------------------------------------------------------
FUNCTION MsgExcluidoSucesso()
    RETURN MsgSucesso("Registro exclu" + CHR(237) + "do com sucesso!")
ENDFUNC

*------------------------------------------------------------------------------
* MsgCampoObrigatorio - Mensagem de campo obrigatorio nao preenchido
* Parametros: pcCampo - nome do campo
*------------------------------------------------------------------------------
FUNCTION MsgCampoObrigatorio(pcCampo)
    LOCAL lcMensagem

    lcMensagem = "O campo '" + pcCampo + "' " + CHR(233) + " obrigat" + CHR(243) + "rio e deve ser preenchido."

    RETURN MsgAviso(lcMensagem, "Campo Obrigat" + CHR(243) + "rio")
ENDFUNC

*------------------------------------------------------------------------------
* MsgCampoInvalido - Mensagem de campo com valor invalido
* Parametros: pcCampo - nome do campo
*            pcMotivo - motivo da invalidez (opcional)
*------------------------------------------------------------------------------
FUNCTION MsgCampoInvalido(pcCampo, pcMotivo)
    LOCAL lcMensagem

    lcMensagem = "O campo '" + pcCampo + "' est" + CHR(225) + " com valor inv" + CHR(225) + "lido."

    IF VARTYPE(pcMotivo) = "C" AND !EMPTY(pcMotivo)
        lcMensagem = lcMensagem + CHR(13) + pcMotivo
    ENDIF

    RETURN MsgAviso(lcMensagem, "Campo Inv" + CHR(225) + "lido")
ENDFUNC

*------------------------------------------------------------------------------
* MsgNenhumRegistro - Mensagem informando que nao ha registros
*------------------------------------------------------------------------------
FUNCTION MsgNenhumRegistro()
    RETURN MsgInfo("Nenhum registro encontrado.", "Sem Registros")
ENDFUNC

*------------------------------------------------------------------------------
* MsgErroConexao - Mensagem de erro de conexao com banco
*------------------------------------------------------------------------------
FUNCTION MsgErroConexao()
    RETURN MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel conectar ao banco de dados." + CHR(13) + ;
                   "Verifique a conex" + CHR(227) + "o e tente novamente.", ;
                   "Erro de Conex" + CHR(227) + "o")
ENDFUNC

*------------------------------------------------------------------------------
* MsgErroSQL - Mensagem de erro SQL generica
* Parametros: pcDetalhes - detalhes do erro (opcional)
*------------------------------------------------------------------------------
FUNCTION MsgErroSQL(pcDetalhes)
    LOCAL lcMensagem

    lcMensagem = "Ocorreu um erro ao executar opera" + CHR(231) + CHR(227) + "o no banco de dados."

    IF VARTYPE(pcDetalhes) = "C" AND !EMPTY(pcDetalhes)
        lcMensagem = lcMensagem + CHR(13) + CHR(13) + "Detalhes:" + CHR(13) + pcDetalhes
    ENDIF

    RETURN MsgErro(lcMensagem, "Erro SQL")
ENDFUNC

*------------------------------------------------------------------------------
* MsgOperacaoCancelada - Mensagem informando operacao cancelada
*------------------------------------------------------------------------------
FUNCTION MsgOperacaoCancelada()
    RETURN MsgInfo("Opera" + CHR(231) + CHR(227) + "o cancelada pelo usu" + CHR(225) + "rio.", "Cancelado")
ENDFUNC

*------------------------------------------------------------------------------
* MsgRegistroEmUso - Mensagem informando que registro esta em uso
*------------------------------------------------------------------------------
FUNCTION MsgRegistroEmUso()
    RETURN MsgAviso("Este registro est" + CHR(225) + " sendo utilizado e n" + CHR(227) + "o pode ser exclu" + CHR(237) + "do.", ;
                    "Registro em Uso")
ENDFUNC

*------------------------------------------------------------------------------
* MsgDuplicado - Mensagem informando registro duplicado
* Parametros: pcCampo - nome do campo duplicado (opcional)
*------------------------------------------------------------------------------
FUNCTION MsgDuplicado(pcCampo)
    LOCAL lcMensagem

    IF VARTYPE(pcCampo) = "C" AND !EMPTY(pcCampo)
        lcMensagem = "J" + CHR(225) + " existe um registro com este valor no campo '" + pcCampo + "'."
    ELSE
        lcMensagem = "J" + CHR(225) + " existe um registro com estes dados."
    ENDIF

    RETURN MsgAviso(lcMensagem, "Registro Duplicado")
ENDFUNC

*------------------------------------------------------------------------------
* MsgProcessando - Exibe mensagem de processamento
* Parametros: pcMensagem - mensagem a exibir (opcional)
* Nota: usar com WAIT WINDOW NOWAIT
*------------------------------------------------------------------------------
FUNCTION MsgProcessando(pcMensagem)
    LOCAL lcMensagem

    lcMensagem = IIF(VARTYPE(pcMensagem) = "C" AND !EMPTY(pcMensagem), ;
                     pcMensagem, ;
                     "Processando, aguarde...")

    WAIT WINDOW lcMensagem NOWAIT
ENDFUNC

*------------------------------------------------------------------------------
* MsgLimparProcessamento - Limpa mensagem de processamento
*------------------------------------------------------------------------------
FUNCTION MsgLimparProcessamento()
    WAIT CLEAR
ENDFUNC
