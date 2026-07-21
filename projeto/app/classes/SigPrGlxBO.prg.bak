*=============================================================================*
* SigPrGlxBO.prg - Business Object para Previa da Globalizacao
*=============================================================================*
* Herda de: BusinessBase
* Form associado: FormSigPrGlx.prg (forms\operacionais\)
* Descricao: Gerencia a previa da globalizacao de producao.
*            Opera sobre cursores temporarios passados pelo form pai
*            (TmpFinalg, TmpFinal, TmpSaldG, TmpFabr, TmpSaldU)
*            alem de cursores SQL criados em tempo de execucao.
*            Nao possui tabela SQL Server propria (opera em varias tabelas).
*=============================================================================*

DEFINE CLASS SigPrGlxBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Parametros recebidos do form pai via Init/ConfigurarParametros
    *--------------------------------------------------------------------------

    *-- Indica modo reserva automatica (nao produz OP, apenas reserva estoque)
    this_lReserva           = .F.

    *-- Indica modo de processamento automatico (sem confirmacao manual)
    this_lAutomatico        = .F.

    *-- Indica se o destino das OPs segue o destino do movimento origem
    this_lPorDestino        = .F.

    *-- Numero de emphasis (empresa) padrao para geracao de OP
    this_nEmphPdr           = 0

    *-- Numero da OP pre-definida (quando GlobAutos = 2 no parametro)
    this_nNumerodaop        = 0

    *-- Data de referencia para processamento (data da globalizacao)
    this_dData              = {}

    *-- Chave de assinatura unica para rastreio de registros gerados
    this_cSigKey            = ""

    *--------------------------------------------------------------------------
    * Controle de edicao inline nos grids de itens (Page1 e Page2)
    *--------------------------------------------------------------------------

    *-- Valor anterior antes de edicao em Column7/Column10 do GradeItens
    this_nOldValue          = 0

    *-- Valor anterior antes de edicao em Column5 do GradePedra (Page6)
    this_nAntValue          = 0

    *-- Flag de liberacao para edicao de coluna normalmente bloqueada (Column8)
    this_lLiberado          = .F.

    *--------------------------------------------------------------------------
    * Controle de exibicao e estado de botoes da UI
    *--------------------------------------------------------------------------

    *-- Controla visibilidade do botao Pedras (requisicao manual de material)
    this_lPedrasVisiveis    = .F.

    *-- Controla visibilidade do botao Disponivel
    this_lDisponivelVisivel = .F.

    *-- Controla visibilidade do botao SelEstoque (selecionar estoque por grupo)
    this_lSelEstoqueVisivel = .F.

    *--------------------------------------------------------------------------
    * Acumuladores de totais da pagina principal (Page1 - GradeItens)
    *--------------------------------------------------------------------------

    *-- Total de quantidade / saldo (coluna Saldo do TmpFinalg)
    this_nTotQtd            = 0

    *-- Total de estoque (coluna Estoque do TmpFinalg)
    this_nTotEst            = 0

    *-- Total a produzir / prazo (coluna Produzir do TmpFinalg)
    this_nTotPrz            = 0

    *-- Total de producao / fabrico (coluna Fabrs do TmpFinalg)
    this_nTotPrdc           = 0

    *-- Total de producao para estoque (coluna Produzir2 do TmpFinalg)
    this_nTotPrze           = 0

    *--------------------------------------------------------------------------
    * Acumuladores de totais da pagina de operacoes detalhadas (Page2)
    *--------------------------------------------------------------------------

    *-- Total de quantidade (Page2 - TmpFinal)
    this_nTotQtdP2          = 0

    *-- Total de estoque (Page2 - TmpFinal)
    this_nTotEstP2          = 0

    *-- Total a produzir (Page2 - TmpFinal)
    this_nTotPrzP2          = 0

    *-- Total de producao (Page2 - TmpFinal.Fabrs)
    this_nTotPrcP2          = 0

    *-- Quantidade selecionada de estoque para a referencia corrente (Tot_sEst)
    this_nTotSEst           = 0

    *-- Quantidade selecionada de producao para a referencia corrente (Tot_sPrc)
    this_nTotSPrc           = 0

    *--------------------------------------------------------------------------
    * Permissoes de acesso
    *--------------------------------------------------------------------------

    *-- Indica se usuario tem permissao para alterar prioridade (SIGPRGLO/PRIORIDADE)
    this_lPermitePrioridade = .F.

    *--------------------------------------------------------------------------
    * INIT - Inicializa BO sem tabela SQL propria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Le totais acumulados do cursor de itens
    *--------------------------------------------------------------------------
    * Para forms OPERACIONAIS este BO nao mapeia registro-a-registro:
    * recebe o alias do cursor de itens (TmpFinalg para Page1, TmpFinal para
    * Page2) e calcula os totais para exibir nos textboxes Tot_Qtd/Est/Prz/etc.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAlias, loc_nRecno, loc_nSaldo, loc_nEstoque
        LOCAL loc_nProduzir, loc_nFabrs, loc_nProduzir2
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            loc_cAlias = IIF(EMPTY(par_cAliasCursor), "TmpFinalg", par_cAliasCursor)

            IF !USED(loc_cAlias)
                loc_lSucesso = .F.
            ELSE
                SELECT (loc_cAlias)
                loc_nRecno = IIF(RECCOUNT() > 0, RECNO(), 0)

                loc_nSaldo     = 0
                loc_nEstoque   = 0
                loc_nProduzir  = 0
                loc_nFabrs     = 0
                loc_nProduzir2 = 0

                IF RECCOUNT() > 0
                    SUM Saldo, Estoque, Produzir, Fabrs ;
                        TO loc_nSaldo, loc_nEstoque, loc_nProduzir, loc_nFabrs

                    IF TYPE(loc_cAlias + ".Produzir2") != "U"
                        SUM Produzir2 TO loc_nProduzir2
                    ENDIF

                    IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT()
                        GO loc_nRecno
                    ENDIF
                ENDIF

                IF UPPER(loc_cAlias) = "TMPFINAL"
                    THIS.this_nTotQtdP2  = loc_nSaldo
                    THIS.this_nTotEstP2  = loc_nEstoque
                    THIS.this_nTotPrzP2  = loc_nProduzir
                    THIS.this_nTotPrcP2  = loc_nFabrs
                ELSE
                    THIS.this_nTotQtd  = loc_nSaldo
                    THIS.this_nTotEst  = loc_nEstoque
                    THIS.this_nTotPrz  = loc_nProduzir
                    THIS.this_nTotPrdc = loc_nFabrs
                    THIS.this_nTotPrze = loc_nProduzir2
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar totais do cursor: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave de rastreio da execucao (SigKey unica)
    *--------------------------------------------------------------------------
    * Cada execucao da previa gera uma SigKey por fGerUniqueKey no legado.
    * Enquanto o form nao a define, retorna string vazia. Usada para vincular
    * registros gerados (SigOpPic/SigCdNei/SigMvCab) na fase Processar.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cSigKey)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Registra execucao da globalizacao em LogAuditoria
    *--------------------------------------------------------------------------
    * OPERACIONAL: nao existe INSERT em tabela unica. O metodo delega para
    * RegistrarAuditoria com operacao "GLOBALIZACAO" (ou "RESERVA_AUTO"),
    * marcando que a previa foi confirmada. As gravacoes reais dos registros
    * (SigMvCab/SigOpPic/SigCdNei) ocorrem na fase Processar do form.
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_cOperacao

        loc_lSucesso = .F.

        TRY
            loc_cOperacao = IIF(THIS.this_lReserva, ;
                "RESERVA_AUTO_GLOBALIZACAO", ;
                "PREVIA_GLOBALIZACAO")

            THIS.RegistrarAuditoria(loc_cOperacao)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao registrar globalizacao: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Registra reprocessamento em LogAuditoria
    *--------------------------------------------------------------------------
    * Chamado quando o usuario reexecuta o Processar apos ajustar quantidades
    * (edicoes em GradeItens Column7/Column10). Registra evento no log.
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            THIS.RegistrarAuditoria("REPROCESSAMENTO_GLOBALIZACAO")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao registrar reprocessamento: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Insere entrada na tabela LogAuditoria
    *--------------------------------------------------------------------------
    * Grava operacao no log para rastreabilidade. Usa GETDATE() literal
    * (nao GETDATE()) para DataHora conforme feedback #35.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario, loc_cModulo
        LOCAL loc_nResultado, loc_oErro

        TRY
            loc_cChave   = THIS.ObterChavePrimaria()
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                gc_4c_UsuarioLogado, "SISTEMA")
            loc_cModulo  = "SigPrGlx"

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora, DadosNovos) " + ;
                "VALUES (" + ;
                EscaparSQL(loc_cModulo) + ", " + ;
                EscaparSQL(par_cOperacao) + ", " + ;
                EscaparSQL(loc_cChave) + ", " + ;
                EscaparSQL(loc_cUsuario) + ", " + ;
                "GETDATE(), " + ;
                EscaparSQL("SigKey=" + loc_cChave + ;
                    "; Reserva=" + IIF(THIS.this_lReserva, "S", "N") + ;
                    "; Automatico=" + IIF(THIS.this_lAutomatico, "S", "N") + ;
                    "; PorDestino=" + IIF(THIS.this_lPorDestino, "S", "N") + ;
                    "; NumeroOP=" + TRANSFORM(THIS.this_nNumerodaop)) + ;
                ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Falha ao gravar LogAuditoria para operacao " + ;
                    par_cOperacao, "Auditoria")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RegistrarAuditoria: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE
