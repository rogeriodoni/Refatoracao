*==============================================================================
* BUSINESSBASE.PRG
* Classe base para objetos de negocio (Business Objects)
* Responsabilidade: validacoes, regras de negocio, orquestracao entre dados e UI
*==============================================================================

DEFINE CLASS BusinessBase AS Custom

    *-- Propriedades (nomenclatura: this_ + tipo)
    this_oDataAccess = .NULL.       && Objeto de acesso a dados
    this_cTabela = ""               && Nome da tabela principal
    this_cCampoChave = ""           && Nome do campo chave primaria
    this_lEmEdicao = .F.            && Indica se esta em modo de edicao
    this_lNovoRegistro = .F.        && Indica se e um novo registro
    this_lDadosAlterados = .F.      && Indica se houve alteracoes
    this_cMensagemErro = ""         && Mensagem de erro da ultima operacao
    this_lErroExibido = .F.         && .T. quando a falha JA foi mostrada ao usuario

    *-- Propriedades de dados (a serem sobrescritas pelas subclasses)
    * Cada subclasse deve definir suas propriedades especificas

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init(pcTabela)
        IF VARTYPE(pcTabela) = "C" AND !EMPTY(pcTabela)
            THIS.this_cTabela = ALLTRIM(pcTabela)

            * Instancia objeto de acesso a dados
            THIS.this_oDataAccess = CREATEOBJECT("DataAccess", THIS.this_cTabela)
        ENDIF

        * Inicializa em modo consulta
        THIS.this_lEmEdicao = .F.
        THIS.this_lNovoRegistro = .F.
        THIS.this_lDadosAlterados = .F.

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * NovoRegistro - Prepara para inclusao de novo registro
    *--------------------------------------------------------------------------
    PROCEDURE NovoRegistro()
        THIS.LimparDados()
        THIS.this_lEmEdicao = .T.
        THIS.this_lNovoRegistro = .T.
        THIS.this_lDadosAlterados = .F.

        * Hook para inicializacao de valores padrao nas subclasses
        THIS.InicializarValoresPadrao()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * EditarRegistro - Prepara para edicao de registro existente
    *--------------------------------------------------------------------------
    PROCEDURE EditarRegistro()
        IF THIS.this_lNovoRegistro
            THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + " registro para editar"
            RETURN .F.
        ENDIF

        THIS.this_lEmEdicao = .T.
        THIS.this_lDadosAlterados = .F.

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CancelarEdicao - Cancela edicao em andamento
    *--------------------------------------------------------------------------
    PROCEDURE CancelarEdicao()
        IF THIS.this_lNovoRegistro
            THIS.LimparDados()
        ENDIF

        THIS.this_lEmEdicao = .F.
        THIS.this_lNovoRegistro = .F.
        THIS.this_lDadosAlterados = .F.

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Salvar - Valida e salva dados (INSERT ou UPDATE)
    * Retorno: .T. se sucesso, .F. se erro
    *--------------------------------------------------------------------------
    PROCEDURE Salvar()
        LOCAL llResultado

        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.

        * Valida estado
        IF !THIS.this_lEmEdicao
            THIS.this_cMensagemErro = "N" + CHR(227) + "o est" + CHR(225) + " em modo de edi" + CHR(231) + CHR(227) + "o"
            THIS.ExibirFalha("Salvar")
            RETURN .F.
        ENDIF

        * Executa validacoes (metodo a ser implementado nas subclasses)
        IF !THIS.ValidarDados()
            * ValidarDados DEFINE a mensagem; quem EXIBE eh a linha abaixo
            THIS.ExibirFalha("Salvar")
            RETURN .F.
        ENDIF

        * Executa regras de negocio antes de salvar
        IF !THIS.AntesDeGravar()
            * AntesDeGravar DEFINE a mensagem; quem EXIBE eh a linha abaixo
            THIS.ExibirFalha("Salvar")
            RETURN .F.
        ENDIF

        * Salva no banco de dados
        llResultado = .F.

        TRY
            IF THIS.this_lNovoRegistro
                llResultado = THIS.Inserir()
            ELSE
                llResultado = THIS.Atualizar()
            ENDIF

            IF llResultado
                * Executa acoes pos-gravacao
                THIS.DepoisDeGravar()

                THIS.this_lEmEdicao = .F.
                THIS.this_lNovoRegistro = .F.
                THIS.this_lDadosAlterados = .F.
            ELSE
                * Inserir/Atualizar das subclasses exibem o proprio MsgErro com o
                * texto do SQL Server e nao preenchem this_cMensagemErro - nesse
                * caso so marcamos como exibido, para nao duplicar a mensagem.
                * Se a subclasse DEIXOU uma mensagem sem exibir (o stub da base
                * faz isso), exibimos aqui: falha nunca pode ser muda.
                IF EMPTY(ALLTRIM(NVL(THIS.this_cMensagemErro, "")))
                    THIS.this_lErroExibido = .T.
                ELSE
                    THIS.ExibirFalha("Salvar")
                ENDIF
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao salvar: " + loException.Message
            THIS.ExibirFalha("Salvar")
            llResultado = .F.
        ENDTRY

        RETURN llResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Excluir - Valida e exclui registro
    *--------------------------------------------------------------------------
    PROCEDURE Excluir()
        LOCAL llResultado
        llResultado = .F.

        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.

        * Valida estado
        IF THIS.this_lNovoRegistro
            THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + " registro para excluir"
            THIS.ExibirFalha("Excluir")
            RETURN .F.
        ENDIF

        * Executa validacoes antes de excluir
        IF !THIS.AntesDeExcluir()
            * AntesDeExcluir DEFINE a mensagem; quem EXIBE eh a linha abaixo
            THIS.ExibirFalha("Excluir")
            RETURN .F.
        ENDIF

        * Executa exclusao (metodo a ser implementado nas subclasses)
        IF THIS.ExecutarExclusao()
            THIS.DepoisDeExcluir()
            THIS.LimparDados()
            llResultado = .T.
        ELSE
            * ExecutarExclusao das subclasses exibe o proprio MsgErro e nao
            * preenche this_cMensagemErro - nesse caso so marcamos como exibido.
            * Se deixou mensagem sem exibir, exibimos aqui: falha nunca eh muda.
            IF EMPTY(ALLTRIM(NVL(THIS.this_cMensagemErro, "")))
                THIS.this_lErroExibido = .T.
            ELSE
                THIS.ExibirFalha("Excluir")
            ENDIF
        ENDIF

        RETURN llResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExibirFalha - Mostra ao usuario a falha da ultima operacao e marca
    * this_lErroExibido, para que o chamador nao repita a mensagem.
    *
    * Existe porque Salvar()/Excluir() devolviam .F. em SILENCIO nos caminhos de
    * validacao: apenas preenchiam this_cMensagemErro, e o form que fizesse
    * `IF oBO.Salvar()` sem ELSE deixava o usuario clicar Confirmar e nao ver
    * absolutamente nada. Era o caso de 249 sites em 107 forms do projeto
    * (Erro158). Centralizar aqui resolve todos de uma vez, no lugar certo:
    * quem sabe que a operacao falhou eh o BO.
    *
    * O form NAO precisa mais de ELSE. Se tiver um, deve guardar com
    * `IF !oBO.this_lErroExibido` para nao mostrar a mensagem duas vezes.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExibirFalha(par_cContexto)
        LOCAL loc_cMensagem, loc_cTitulo

        loc_cTitulo = IIF(VARTYPE(par_cContexto) = "C" AND !EMPTY(par_cContexto), ;
            par_cContexto, "Erro")

        loc_cMensagem = ALLTRIM(NVL(THIS.this_cMensagemErro, ""))
        IF EMPTY(loc_cMensagem)
            loc_cMensagem = "N" + CHR(227) + "o foi poss" + CHR(237) + "vel concluir a opera" + ;
                CHR(231) + CHR(227) + "o."
        ENDIF

        THIS.this_lErroExibido = .T.
        MsgErro(loc_cMensagem, loc_cTitulo)
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros (delega para DataAccess)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(pcFiltro, pcOrdenacao, pcCampos)
        IF ISNULL(THIS.this_oDataAccess)
            THIS.this_cMensagemErro = "Objeto de acesso a dados n" + CHR(227) + "o inicializado"
            RETURN .F.
        ENDIF

        LOCAL llResultado
        llResultado = THIS.this_oDataAccess.Buscar(pcFiltro, pcOrdenacao, pcCampos)

        IF !llResultado
            THIS.this_cMensagemErro = THIS.this_oDataAccess.ObterMensagemErro()
        ENDIF

        RETURN llResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega dados do cursor para as propriedades
    * Metodo a ser implementado nas subclasses
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(pcCursor)
        * Subclasses devem implementar este metodo
        * Exemplo:
        * THIS.nId = EVALUATE(pcCursor + ".id")
        * THIS.cNome = EVALUATE(pcCursor + ".nome")
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarComoAlterado - Marca que houve alteracao nos dados
    *--------------------------------------------------------------------------
    PROCEDURE MarcarComoAlterado()
        IF THIS.this_lEmEdicao
            THIS.this_lDadosAlterados = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * METODOS PROTEGIDOS (a serem implementados/sobrescritos nas subclasses)
    *--------------------------------------------------------------------------

    PROTECTED PROCEDURE LimparDados()
        * Subclasses devem limpar suas propriedades especificas
        THIS.this_cMensagemErro = ""
    ENDPROC

    PROTECTED PROCEDURE InicializarValoresPadrao()
        * Subclasses podem definir valores padrao para novos registros
    ENDPROC

    PROTECTED PROCEDURE ValidarDados()
        * Subclasses devem implementar suas validacoes especificas
        * Retornar .T. se valido, .F. se invalido
        * Definir THIS.this_cMensagemErro em caso de erro
        RETURN .T.
    ENDPROC

    PROTECTED PROCEDURE AntesDeGravar()
        * Hook para executar acoes antes de gravar
        * Retornar .T. para continuar, .F. para cancelar
        RETURN .T.
    ENDPROC

    PROTECTED PROCEDURE DepoisDeGravar()
        * Hook para executar acoes apos gravar com sucesso
    ENDPROC

    PROTECTED PROCEDURE AntesDeExcluir()
        * Hook para executar validacoes antes de excluir
        * Retornar .T. para continuar, .F. para cancelar
        RETURN .T.
    ENDPROC

    PROTECTED PROCEDURE DepoisDeExcluir()
        * Hook para executar acoes apos excluir com sucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao no log de auditoria
    * Parametros: par_cOperacao = "INSERT", "UPDATE" ou "DELETE"
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave

        * Obter chave primaria do registro
        loc_cChave = THIS.ObterChavePrimaria()

        IF EMPTY(loc_cChave)
            RETURN .F.
        ENDIF

        loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                   "VALUES (" + EscaparSQL(THIS.this_cTabela) + ", " + ;
                   EscaparSQL(par_cOperacao) + ", " + ;
                   EscaparSQL(loc_cChave) + ", " + ;
                   EscaparSQL(IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")) + ", GETDATE())"

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF
        SQLEXEC(gnConnHandle, loc_cSQL)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da chave primaria do registro atual
    * Cada BO deve implementar este metodo conforme sua chave
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        * Subclasses devem sobrescrever este metodo
        * Exemplo: RETURN THIS.this_cCodigo ou TRANSFORM(THIS.this_nId)
        RETURN ""
    ENDPROC

    PROTECTED PROCEDURE Inserir()
        * Subclasses devem implementar a logica de INSERT
        * Retornar .T. se sucesso, .F. se erro
        THIS.this_cMensagemErro = "M" + CHR(233) + "todo Inserir() n" + CHR(227) + "o implementado"
        RETURN .F.
    ENDPROC

    PROTECTED PROCEDURE Atualizar()
        * Subclasses devem implementar a logica de UPDATE
        * Retornar .T. se sucesso, .F. se erro
        THIS.this_cMensagemErro = "M" + CHR(233) + "todo Atualizar() n" + CHR(227) + "o implementado"
        RETURN .F.
    ENDPROC

    PROTECTED PROCEDURE ExecutarExclusao()
        * Subclasses devem implementar a logica de DELETE
        * Retornar .T. se sucesso, .F. se erro
        THIS.this_cMensagemErro = "M" + CHR(233) + "todo ExecutarExclusao() n" + CHR(227) + "o implementado"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * DESTROY - Destrutor
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF !ISNULL(THIS.this_oDataAccess)
            THIS.this_oDataAccess = .NULL.
        ENDIF
    ENDPROC

ENDDEFINE
