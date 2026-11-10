*====================================================================
* SigOpLrCBO.prg
*
* Business Object para SigOpLrC (Liberacao de Credito)
*
* Form OPERACIONAL: dialogo MODAL chamado por outro form (ex.: Caixa)
* para validar/exibir limite de credito, saldo em C/C, cheques e
* pendencias de uma Conta (Origem e/ou Destino) de um movimento, antes
* de autorizar a gravacao do movimento. NAO existe tabela propria -
* este BO consolida leituras de SigCdOpe, SigClLcr, SigCdCli, SigCdCst,
* SigMvCab/SigMvItn, SigMvSlc, SigChe/SigCqChm/SigCdOpt e SigCdTom,
* todas feitas pelo DataMgr do form PAI (ThisForm.ParentForm.PoDataMgr).
*
* Tabela: (nenhuma tabela propria - BO de consolidacao/calculo)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigOpLrCBO AS BusinessBase

    *-- Parametros recebidos do form pai (Init do dialogo legado)
    this_cOperacao          = ""    && Operacao / Dopes - codigo da operacao (SigCdOpe.Dopes)
    this_nOriDes            = 0     && OriDes - 0=indefinido, 1=Origem, 2=Destino (lado fixo)
    this_nClickOriDes       = 0     && ClickOriDes - lado escolhido pelo clique do usuario (0/1/2)
    this_lRetorno           = .T.   && Retorno - .F. quando a movimentacao deve ser BLOQUEADA

    *-- Dados de SigCdOpe (LocalOpe) para a Operacao informada
    this_cDopes             = ""    && SigCdOpe.Dopes char(20) - PK
    this_nTipoOp            = 0     && SigCdOpe.TipoOps
    this_cNivel             = ""    && SigCdOpe.Nivels - usado na chave EmpDopNums do proprio movimento
    this_nTipoLimCredito    = 0     && SigCdOpe.LimCres - lado(s) sujeitos a limite de credito (1,2,3,5,6)
    this_nObsOrigs          = 0     && SigCdOpe.ObsOrigs - exibe observacao da conta Origem
    this_nObsDests          = 0     && SigCdOpe.ObsDests - exibe observacao da conta Destino
    this_nExibSits          = 0     && SigCdOpe.ExibSits - exibe situacao da conta (1=Destino / 3=Origem)

    *-- Grupo/Conta efetivamente em analise (origem ou destino, conforme regras)
    this_cGrupoOrigem       = ""    && TprMvCab.grupoos (cursor do movimento, mantido pelo form pai)
    this_cContaOrigem       = ""    && TprMvCab.Contaos
    this_cGrupoDestino      = ""    && TprMvCab.grupods
    this_cContaDestino      = ""    && TprMvCab.Contads
    this_cGrupo             = ""    && Grupo da conta efetivamente analisada nesta chamada
    this_cConta             = ""    && Conta (Iclis) efetivamente analisada nesta chamada
    this_cGrupoCC           = ""    && Grupo usado na consulta de saldo em C/C (SigMvSlc)
    this_cRazaoConta        = ""    && SigCdCli.Rclis - razao social/nome da conta analisada
    this_cChaveLimCredito   = ""    && Emps + Nivel + Str(Numes,6) - exclui o proprio movimento do calculo de pendencias

    *-- Valores de credito/saldo exibidos no bloco "Container1"
    this_nLimiteCredito     = 0     && SigClLcr.limcres - limite de credito cadastrado da conta
    this_cMoeda             = ""    && SigClLcr.moedas - moeda do limite de credito
    this_nCotacao           = 0     && cotacao da moeda do limite na data corrente
    this_nSaldoCC           = 0     && saldo em Conta Corrente, convertido para a moeda do limite (SigMvSlc)
    this_nTotalCheques      = 0     && total de cheques a debito (nao pendentes) convertido p/ moeda do limite
    this_nChequesPendentes  = 0     && total de cheques pendentes de compensacao convertido p/ moeda do limite
    this_nPendente          = 0     && valor pendente do PROPRIO movimento, convertido p/ moeda do limite
    this_nPendenteOutros    = 0     && total pendente de OUTRAS operacoes do mesmo tipo (SigCdPam.Oppends)
    this_nSaldoDisponivel   = 0     && limite - pendencias - saldo C/C - cheques (conforme regras de LocalTOpe/SigCdPam)

    *-- Observacao da conta (bloco "Container2")
    this_cObsCliente        = ""    && SigCdCli.Obs - observacao cadastrada da conta

    *-- Situacao da conta (bloco "Container3")
    this_cSituacaoCod       = ""    && SigCdCli.Situas - codigo da situacao cadastral da conta
    this_cDescrSituacao     = ""    && SigCdCst.Descrs / Descr2s - descricao da situacao
    this_nValorUltimaCompra = 0     && SigCdCli.VultComps - valor da ultima compra
    this_dUltimaCompra      = {}    && SigCdCli.UltComps - data da ultima compra
    this_dNascimento        = {}    && SigCdCli.Nascs - data de nascimento
    this_cCodigoCliente     = ""    && SigCdCli.Codigos - codigo auxiliar do cliente
    this_dDtnCons           = {}    && SigCdCli.DtnCons
    this_dDtCasas           = {}    && SigCdCli.DtCasas
    this_nDispMovs          = 0     && SigCdCst.DispMovs - indica se a situacao permite exibir bloqueios
    this_nBlqMovs           = 0     && SigCdCst.BlqMovs - bloqueia toda movimentacao
    this_nBlqDescs          = 0     && SigCdCst.BlqDescs - bloqueia movimento com desconto (ValVars < 0)
    this_cMsgBloqueio       = ""    && mensagem de bloqueio exibida (Lb_msg5)
    this_lMsgBloqueioVisivel = .F.  && .T. quando ha mensagem de bloqueio a exibir

    *-- Flags de visibilidade dos containers (replicam Container1/2/3.Visible do legado)
    this_lContainer1Visivel = .F.   && bloco de limite/saldo/pendencias
    this_lContainer2Visivel = .F.   && bloco de observacao da conta
    this_lContainer3Visivel = .F.   && bloco de situacao da conta

    *-- Flags de habilitacao dos CheckBox de escolha de lado (Sit_Origem/Sit_Destino)
    this_lSitOrigemHabilitado  = .T.
    this_lSitDestinoHabilitado = .T.

    *-- Cabecalho do movimento em lancamento (legado: TprMvCab, cursor
    *-- compartilhado pelo form CHAMADOR via DataSession - aqui chega
    *-- como PARAMETRO de alias, lido na posicao corrente)
    this_cEmpsMovimento    = ""    && SigMvCab.Emps    char(3)
    this_nNumesMovimento   = 0     && SigMvCab.Numes   numeric(6,0)
    this_nValorMovimento   = 0     && SigMvCab.Valos   - legado _Pendente antes da conversao
    this_nValVarsMovimento = 0     && SigMvCab.ValVars - usado no bloqueio por desconto (Container3)

    *-- SigCdTom (LocalTOpe do legado) e SigCdPam (crSigCdPam do legado)
    this_nGerGdmis         = 0     && SigCdTom.GerGdmis  numeric(1,0) - 3 = abate pendencias/cheques
    this_nOpPendsParam     = 0     && SigCdPam.OpPends   numeric(2,0) - TipoOps que conta como pendencia
    this_lChqLimiteCredito = .F.   && SigCdPam.ChqlCreds bit - cheque sempre abate o limite

    *-- legado: ThisForm.get_nconta.Caption = _Conta + ' ' + Alltrim(lcRazao)
    this_cDescricaoConta = ""

    this_lFalhaConexao = .F.       && .T. quando algum SQLEXEC falhou (legado: "Favor reinicializar o processo")

    *-- Cursores de trabalho. A estrutura/ORDEM de cursor_4c_Operacoes tem
    *-- de ser identica em TODO lugar que recriar o cursor (regra #42) -
    *-- a grade da tela usa estes nomes de coluna.
    this_cCursorOperacoes    = "cursor_4c_Operacoes"     && DbOpera     - GRADE (Dopes, Totas)
    this_cCursorOperacao     = "cursor_4c_Operacao"      && LocalOpe
    this_cCursorLimiteConta  = "cursor_4c_LimiteConta"   && CrSigClLcr
    this_cCursorOpePendente  = "cursor_4c_OpePendente"   && LocalOpePd
    this_cCursorMovCabecalho = "cursor_4c_MovCabecalho"  && CrTprMvCab
    this_cCursorMovFiltrado  = "cursor_4c_MovFiltrado"   && CrConserto2
    this_cCursorItensMov     = "cursor_4c_ItensMov"      && lCredEesti
    this_cCursorCliente      = "cursor_4c_Cliente"       && CrTmpCli
    this_cCursorSaldoConta   = "cursor_4c_SaldoConta"    && CrTmpSccr
    this_cCursorCheques      = "cursor_4c_Cheques"       && Cheques
    this_cCursorFormaPagto   = "cursor_4c_FormaPagto"    && CrSigOpFp
    this_cCursorPendencia    = "cursor_4c_Pendencia"     && Pendencia
    this_cCursorTipoOperacao = "cursor_4c_TipoOperacao"  && LocalTOpe
    this_cCursorParametros   = "cursor_4c_Parametros"    && crSigCdPam
    this_cCursorSituacao     = "cursor_4c_Situacao"      && CrTmpScli

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()

            *-- Tabela "principal" apenas para efeito de ObterChavePrimaria/
            *-- convencao de auditoria (CLAUDE.md - Audit System): este BO
            *-- eh de CONSULTA/CALCULO, nunca grava - ver nota em Inserir().
            THIS.this_cTabela     = "SigCdOpe"
            THIS.this_cCampoChave = "Dopes"

            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigOpLrCBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * METODOS DE CALCULO (equivalente funcional ao CRUD: este BO eh
    * somente-leitura, ver nota acima e em Inserir()/Atualizar()).
    *
    * Entrada publica: IniciarOperacao() uma vez por abertura do dialogo,
    * Processar() a cada reavaliacao (abertura inicial e cada clique nos
    * CheckBox Sit_Origem/Sit_Destino que o Form delega mudando
    * this_nClickOriDes). Replica literalmente o PROCEDURE processa do
    * legado, decomposto em metodos menores.
    *====================================================================

    *--------------------------------------------------------------------------
    * IniciarOperacao - legado: PROCEDURE Init (do FORM legado)
    *   lparameters loForm,pOperacao, pOriDes, loForm2
    *   ThisForm.OriDes = Iif(Type('pOriDes')='N',pOriDes,0)
    *   ThisForm.ClickOriDes = 0
    *   ThisForm.Operacao = pOperacao
    *   ThisForm.Retorno = .t.
    *   If ThisForm.OriDes = 0 -> habilita os dois CheckBox
    *
    * par_cAliasMovCab eh o alias do cursor com o cabecalho do movimento em
    * lancamento (legado: TprMvCab, populado pelo form CHAMADOR antes de
    * abrir este dialogo - aqui chega como parametro em vez de DataSession
    * compartilhada).
    *--------------------------------------------------------------------------
    PROCEDURE IniciarOperacao(par_cOperacao, par_nOriDes, par_cAliasMovCab)
        LOCAL loc_lSucesso

        THIS.this_lFalhaConexao      = .F.
        THIS.this_cOperacao          = TratarNulo(par_cOperacao, "")
        THIS.this_nOriDes            = TratarNulo(par_nOriDes, 0)
        THIS.this_nClickOriDes       = 0
        THIS.this_lRetorno           = .T.
        THIS.this_lContainer1Visivel = .F.
        THIS.this_lContainer2Visivel = .F.
        THIS.this_lContainer3Visivel = .F.

        IF THIS.this_nOriDes = 0
            THIS.this_lSitOrigemHabilitado  = .T.
            THIS.this_lSitDestinoHabilitado = .T.
        ENDIF

        loc_lSucesso = THIS.CarregarOperacao()

        IF loc_lSucesso
            loc_lSucesso = THIS.LerCabecalhoMovimento(par_cAliasMovCab)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOperacao - legado:
    *   lcSql = Select Dopes,TipoOps,Nivels,LimCres,ObsOrigs,ObsDests,ExibSits
    *           From SigCdOpe Where Dopes = <op>
    *   If ...Sqlexecute(lcsql,'LocalOpe') < 1 -> MessageBox + Return(.F.)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarOperacao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Dopes, TipoOps, Nivels, LimCres, ObsOrigs, ObsDests, ExibSits " + ;
                "FROM SigCdOpe WHERE Dopes = " + EscaparSQL(THIS.this_cOperacao)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorOperacao)

            *-- legado: "< 1" - o Sqlexecute do Fortyus devolvia a CONTAGEM de
            *-- linhas; o SQLEXEC do VFP9 devolve 1 por result set, entao a
            *-- ausencia de registro eh pega pela guarda de EOF dentro de
            *-- CarregarDoCursor (fonte unica do mapeamento).
            IF loc_nResultado < 1
                THIS.this_lFalhaConexao = .T.
                THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                    "Falha na conexao (LocalOpe)"
                MsgErro(THIS.this_cMensagemErro, "Falha na Conexao")
            ELSE
                loc_lSucesso = THIS.CarregarDoCursor(THIS.this_cCursorOperacao)
            ENDIF

            IF USED(THIS.this_cCursorOperacao)
                USE IN (THIS.this_cCursorOperacao)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_lFalhaConexao = .T.
            THIS.this_cMensagemErro = "Erro ao carregar opera" + CHR(231) + CHR(227) + "o:" + ;
                CHR(13) + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - FONTE UNICA do mapeamento de SigCdOpe para as
    * propriedades do BO. Sobrescreve o metodo homonimo de BusinessBase,
    * que eh PUBLIC - marcar como PROTECTED o tornaria inalcancavel de
    * fora (regra #51: PROTECTED em QUALQUER nivel da heranca vence).
    *
    * Devolve .F. quando NAO ha registro corrente para ler (alias fechado,
    * cursor vazio ou em EOF) - equivalente ao "< 1" do legado, que no
    * Fortyus media CONTAGEM de linhas.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias

        loc_lSucesso = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor)
            loc_cAlias = ALLTRIM(par_cAliasCursor)
        ELSE
            loc_cAlias = THIS.this_cCursorOperacao
        ENDIF

        TRY
            IF USED(loc_cAlias)
                SELECT (loc_cAlias)

                IF RECCOUNT(loc_cAlias) > 0 AND !EOF(loc_cAlias)
                    IF TYPE(loc_cAlias + ".Dopes") != "U"
                        THIS.this_cDopes = TratarNulo(Dopes, "")
                    ENDIF
                    IF TYPE(loc_cAlias + ".TipoOps") != "U"
                        THIS.this_nTipoOp = TratarNulo(TipoOps, 0)
                    ENDIF
                    IF TYPE(loc_cAlias + ".Nivels") != "U"
                        *-- entra na chave posicional EmpDopNums (regra #42)
                        THIS.this_cNivel = TratarNulo(Nivels, "")
                    ENDIF
                    IF TYPE(loc_cAlias + ".LimCres") != "U"
                        THIS.this_nTipoLimCredito = TratarNulo(LimCres, 0)
                    ENDIF
                    IF TYPE(loc_cAlias + ".ObsOrigs") != "U"
                        THIS.this_nObsOrigs = TratarNulo(ObsOrigs, 0)
                    ENDIF
                    IF TYPE(loc_cAlias + ".ObsDests") != "U"
                        THIS.this_nObsDests = TratarNulo(ObsDests, 0)
                    ENDIF
                    IF TYPE(loc_cAlias + ".ExibSits") != "U"
                        THIS.this_nExibSits = TratarNulo(ExibSits, 0)
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar do cursor [" + loc_cAlias + "]:" + ;
                CHR(13) + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "SigOpLrCBO.CarregarDoCursor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LerCabecalhoMovimento - legado:
    *   _GrupoO = TprMvCab.grupoos / _ContaO = TprMvCab.Contaos
    *   _GrupoD = TprMvCab.grupods / _ContaD = TprMvCab.Contads
    * Le o registro CORRENTE do alias informado - quem abre este dialogo
    * posiciona o cursor no movimento em lancamento antes de chamar.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LerCabecalhoMovimento(par_cAliasMovCab)
        LOCAL loc_cAlias, loc_lSucesso

        loc_lSucesso = .F.

        IF VARTYPE(par_cAliasMovCab) = "C" AND !EMPTY(par_cAliasMovCab) AND USED(par_cAliasMovCab)
            loc_cAlias = ALLTRIM(par_cAliasMovCab)

            TRY
                SELECT (loc_cAlias)
                IF !EOF(loc_cAlias)
                    THIS.this_cEmpsMovimento    = TratarNulo(Emps, "")
                    THIS.this_nNumesMovimento   = TratarNulo(Numes, 0)
                    THIS.this_nValorMovimento   = TratarNulo(Valos, 0)
                    THIS.this_nValVarsMovimento = TratarNulo(ValVars, 0)
                    THIS.this_cGrupoOrigem      = TratarNulo(GrupoOs, "")
                    THIS.this_cContaOrigem      = TratarNulo(ContaOs, "")
                    THIS.this_cGrupoDestino     = TratarNulo(GrupoDs, "")
                    THIS.this_cContaDestino     = TratarNulo(ContaDs, "")
                    loc_lSucesso = .T.
                ENDIF
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = "Erro ao ler cabe" + CHR(231) + "alho do movimento:" + ;
                    CHR(13) + loc_oErro.Message
                MsgErro(THIS.this_cMensagemErro, "Erro")
                loc_lSucesso = .F.
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * EstaVendoOrigem/EstaVendoDestino - fatoram a expressao booleana que o
    * legado repete literalmente TRES vezes (Container1/Container2/Container3):
    *   (InList(OriDes,0,1) And ClickOriDes=0) Or ClickOriDes=1   -> Origem
    *   (InList(OriDes,0,2) And ClickOriDes=0) Or ClickOriDes=2   -> Destino
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE EstaVendoOrigem()
        RETURN (INLIST(THIS.this_nOriDes, 0, 1) AND THIS.this_nClickOriDes = 0) OR ;
            THIS.this_nClickOriDes = 1
    ENDPROC

    PROTECTED PROCEDURE EstaVendoDestino()
        RETURN (INLIST(THIS.this_nOriDes, 0, 2) AND THIS.this_nClickOriDes = 0) OR ;
            THIS.this_nClickOriDes = 2
    ENDPROC

    *--------------------------------------------------------------------------
    * DeterminarLadoConta - legado:
    *   Select TprMvCab
    *   Do Case
    *     Case OriDes=1 Or ClickOriDes=1 -> _Grupo=grupoos/_Conta=Contaos, habilita Sit_Origem
    *     Case OriDes=2 Or ClickOriDes=2 -> _Grupo=grupods/_Conta=Contads, habilita Sit_Destino
    *     Otherwise -> decide pelo LimCres da operacao (1,3,5=Origem / 2,3,6=Destino / senao vazio)
    *   EndCase
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE DeterminarLadoConta()
        DO CASE
        CASE THIS.this_nOriDes = 1 OR THIS.this_nClickOriDes = 1
            THIS.this_cGrupo = THIS.this_cGrupoOrigem
            THIS.this_cConta = THIS.this_cContaOrigem
            THIS.this_lSitOrigemHabilitado = .T.

        CASE THIS.this_nOriDes = 2 OR THIS.this_nClickOriDes = 2
            THIS.this_cGrupo = THIS.this_cGrupoDestino
            THIS.this_cConta = THIS.this_cContaDestino
            THIS.this_lSitDestinoHabilitado = .T.

        OTHERWISE
            IF INLIST(THIS.this_nTipoLimCredito, 1, 3, 5)
                THIS.this_cGrupo = THIS.this_cGrupoOrigem
                THIS.this_cConta = THIS.this_cContaOrigem
            ELSE
                IF INLIST(THIS.this_nTipoLimCredito, 2, 3, 6)
                    THIS.this_cGrupo = THIS.this_cGrupoDestino
                    THIS.this_cConta = THIS.this_cContaDestino
                ELSE
                    THIS.this_cGrupo = " "
                    THIS.this_cConta = " "
                ENDIF
            ENDIF
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * PrecisaCalcularLimite/PrecisaExibirObservacao/PrecisaExibirSituacao -
    * guardas que cercam cada bloco do legado (Container1/2/3). Ver nota em
    * EstaVendoOrigem/EstaVendoDestino.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrecisaCalcularLimite()
        RETURN (INLIST(THIS.this_nTipoLimCredito, 1, 3, 5) AND THIS.EstaVendoOrigem()) OR ;
            (INLIST(THIS.this_nTipoLimCredito, 2, 3, 6) AND THIS.EstaVendoDestino())
    ENDPROC

    PROTECTED PROCEDURE PrecisaExibirObservacao()
        RETURN (THIS.EstaVendoOrigem() AND THIS.this_nObsOrigs = 1) OR ;
            (THIS.EstaVendoDestino() AND THIS.this_nObsDests = 1)
    ENDPROC

    PROTECTED PROCEDURE PrecisaExibirSituacao()
        RETURN (THIS.EstaVendoOrigem() AND THIS.this_nExibSits = 3) OR ;
            (THIS.EstaVendoDestino() AND THIS.this_nExibSits = 1)
    ENDPROC

    *--------------------------------------------------------------------------
    * Processar - legado: PROCEDURE processa (metodo do FORM legado).
    * Reavalia a composicao de credito/observacao/situacao para o lado da
    * conta atualmente em foco (this_nOriDes/this_nClickOriDes). Chamado
    * uma vez na abertura do dialogo e de novo a cada clique nos CheckBox
    * Sit_Origem/Sit_Destino (o Form muda this_nClickOriDes antes de chamar).
    *
    * Retorna .T. quando algum dos tres containers foi ativado (legado:
    * llAtvCnt) - o Form usa isso para decidir se tenta o lado oposto
    * (Init do legado) ou se clica no CheckBox irmao (Click dos CheckBox).
    * Retorna .F. tambem quando a falha foi de CONEXAO - ver
    * this_lFalhaConexao, que distingue os dois casos de recusa.
    *--------------------------------------------------------------------------
    PROCEDURE Processar()
        LOCAL loc_lAtivouContainer, loc_lSucesso

        loc_lAtivouContainer = .F.

        THIS.this_lContainer1Visivel = .F.
        THIS.this_lContainer2Visivel = .F.
        THIS.this_lContainer3Visivel = .F.

        IF THIS.this_nOriDes > 0
            THIS.this_lSitDestinoHabilitado = .F.
            THIS.this_lSitOrigemHabilitado  = .F.
        ENDIF

        THIS.this_lRetorno = .T.

        THIS.DeterminarLadoConta()

        IF THIS.PrecisaCalcularLimite()
            THIS.this_lContainer1Visivel = .T.
            loc_lAtivouContainer = .T.

            loc_lSucesso = THIS.CalcularComposicaoLimite()
            IF !loc_lSucesso
                RETURN .F.
            ENDIF
        ENDIF

        IF THIS.PrecisaExibirObservacao()
            IF THIS.CarregarObservacaoConta()
                loc_lAtivouContainer = .T.
            ENDIF
        ENDIF

        IF THIS.PrecisaExibirSituacao()
            IF THIS.CarregarSituacaoConta()
                loc_lAtivouContainer = .T.
            ENDIF
        ENDIF

        RETURN loc_lAtivouContainer
    ENDPROC

    *--------------------------------------------------------------------------
    * CalcularComposicaoLimite - bloco "Container1" do legado: limite de
    * credito, movimentos em aberto (grade), saldo em C/C, cheques e
    * pendencias de outras operacoes, convertidos para this_cMoeda.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CalcularComposicaoLimite()
        LOCAL loc_lSucesso

        loc_lSucesso = THIS.CarregarLimiteCredito()

        IF loc_lSucesso
            loc_lSucesso = THIS.CarregarMovimentosPendentes()
        ENDIF

        IF loc_lSucesso
            loc_lSucesso = THIS.CarregarCliente()
        ENDIF

        IF loc_lSucesso
            *-- legado: ThisForm.get_nconta.Caption = _Conta + ' '+Alltrim(lcRazao)
            THIS.this_cDescricaoConta = ALLTRIM(THIS.this_cConta) + " " + ;
                ALLTRIM(THIS.this_cRazaoConta)
            THIS.CalcularSaldoContaCorrente()
        ENDIF

        IF loc_lSucesso
            loc_lSucesso = THIS.CalcularCheques()
        ENDIF

        IF loc_lSucesso
            *-- legado: _ChvLCred = TprMvCab.Emps + _Nivel + Str(TprMvCab.Numes,6)
            *-- Chave POSICIONAL (regra #42): PADR explicito, NUNCA ALLTRIM
            *-- nas partes - senao CalcularPendencias() nao casa o WHERE e a
            *-- consulta devolve zero linha em silencio.
            THIS.this_cChaveLimCredito = PADR(THIS.this_cEmpsMovimento, 3) + ;
                PADR(THIS.this_cNivel, 20) + STR(THIS.this_nNumesMovimento, 6)

            loc_lSucesso = THIS.CarregarTipoOperacao()
        ENDIF

        IF loc_lSucesso
            loc_lSucesso = THIS.CarregarParametrosSistema()
        ENDIF

        IF loc_lSucesso
            loc_lSucesso = THIS.CalcularPendencias()
        ENDIF

        IF loc_lSucesso
            THIS.CalcularSaldoDisponivel()
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLimiteCredito - legado:
    *   CursorQuery('SigClLcr','CrSigClLcr','GruContas',_Grupo+_Conta)
    *   ThisForm.get_limcred.Value = crSigClLcr.limcres
    *   ThisForm.get_moeda.Value   = crSigClLcr.moedas
    *   ThisForm.get_cotacao.Value = fBuscarCotacao(crSigClLcr.moedas,date())
    * Sem guarda de falha no legado - zero linha so zera o limite (conta
    * sem limite cadastrado) e segue.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarLimiteCredito()
        LOCAL loc_cSQL, loc_cGruContas

        *-- SigClLcr.GruContas char(20) = Grupos char(10) + Contas char(10) -
        *-- chave POSICIONAL (regra #42): PADR explicito, nunca ALLTRIM.
        loc_cGruContas = PADR(THIS.this_cGrupo, 10) + PADR(THIS.this_cConta, 10)

        TRY
            loc_cSQL = "SELECT LimCres, Moedas FROM SigClLcr WHERE GruContas = " + ;
                EscaparSQL(loc_cGruContas)

            SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorLimiteConta)

            IF USED(THIS.this_cCursorLimiteConta) AND RECCOUNT(THIS.this_cCursorLimiteConta) > 0
                SELECT (THIS.this_cCursorLimiteConta)
                THIS.this_nLimiteCredito = TratarNulo(LimCres, 0)
                THIS.this_cMoeda         = TratarNulo(Moedas, "")
            ELSE
                THIS.this_nLimiteCredito = 0
                THIS.this_cMoeda         = ""
            ENDIF

            *-- fBuscarCotacao (utils\functions.prg) JA esta portado - nao
            *-- reimplementar (regra #13). Devolve 1.0 para moeda vazia.
            THIS.this_nCotacao = fBuscarCotacao(THIS.this_cMoeda, DATE(), gnConnHandle)

            IF USED(THIS.this_cCursorLimiteConta)
                USE IN (THIS.this_cCursorLimiteConta)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar limite de cr" + CHR(233) + "dito:" + ;
                CHR(13) + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarMovimentosPendentes - popula cursor_4c_Operacoes (DbOpera do
    * legado - a GRADE de movimentacoes em aberto) com o total, por operacao
    * em aberto, convertido para this_cMoeda.
    *
    * Legado (sequencia completa):
    *   1) Select * From SigOpPed -> LocalOpePd (Sqlexecute < 1 = falha)
    *   2) Union all SigMvCab+SigOpPed pelos dois lados da conta -> CrTprMvCab
    *   3) SCAN+filtro (Tpagos/ChkPagos e Tutils/Utilizados) -> CrConserto2
    *      (no legado o filtro eh um IIF dentro do WHERE comparando coluna
    *      BIT; aqui refeito em VFP com THIS.BitParaLogico() ANTES da
    *      comparacao, porque IIF/OR no meio de um SELECT avalia os dois
    *      lados e um driver que entregue Numerico estoura "Operator/
    *      operand type mismatch")
    *   4) Para cada linha de CrConserto2: soma os itens do movimento por
    *      moeda (SigMvItn) e converte - SEM item, soma o Valos CRU (sem
    *      conversao de moeda) quando ChkSubn eh falso (transcrito literal,
    *      regra #17 - parece inconsistente mas eh o que o legado faz)
    *
    * CrTmpOpe (Select Dopes,OpPends From SigCdOpe) eh lido e indexado no
    * legado mas NUNCA referenciado depois - dead code confirmado por
    * busca no dump completo - omitido aqui por nao ter efeito observavel
    * (mesmo achado documentado em SigOpLbCBO.prg).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarMovimentosPendentes()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        LOCAL loc_cDopes, loc_lChkPagos, loc_nUtilizados, loc_cEmpDopNums, loc_nValos, loc_lChkSubn
        LOCAL loc_nTpagos, loc_nTutils, loc_lCondPagos, loc_lCondUtils, loc_lIncluir
        LOCAL loc_cDopesItem, loc_nValosItem, loc_lChkSubnItem, loc_nResultadoItn
        LOCAL loc_cDopesLinha, loc_nTotaOrigem, loc_cMoedaOrigem, loc_nConv

        loc_lSucesso = .F.

        TRY
            IF !USED(THIS.this_cCursorOperacoes)
                CREATE CURSOR (THIS.this_cCursorOperacoes) (dopes C(20), totas N(12,2))
            ELSE
                SELECT (THIS.this_cCursorOperacoes)
                ZAP
            ENDIF
            SELECT (THIS.this_cCursorOperacoes)
            INDEX ON dopes TAG dopes

            *-- SigOpPed - operacoes configuradas a considerar (LocalOpePd do legado)
            loc_cSQL = "SELECT * FROM SigOpPed"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorOpePendente)

            IF loc_nResultado < 1
                THIS.this_lFalhaConexao = .T.
                THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                    "Falha na conexao (LocalOpePd)"
                MsgErro(THIS.this_cMensagemErro, "Falha na Conexao")
            ELSE
                SELECT (THIS.this_cCursorOpePendente)
                INDEX ON dopes TAG dopes

                *-- SigMvCab + SigOpPed: movimentos da conta nos dois lados
                *-- (colunas EXPLICITAS, exigido em UNION ALL)
                loc_cSQL = "SELECT a.Dopes, a.EmpDopNums, a.ChkPagos, a.ChkSubn, a.Utilizados, a.Valos " + ;
                    "FROM SigMvCab a, SigOpPed b " + ;
                    "WHERE a.ContaDs = " + EscaparSQL(THIS.this_cConta) + ;
                    " AND a.Dopes = b.Dopes " + ;
                    "UNION ALL " + ;
                    "SELECT a.Dopes, a.EmpDopNums, a.ChkPagos, a.ChkSubn, a.Utilizados, a.Valos " + ;
                    "FROM SigMvCab a, SigOpPed b " + ;
                    "WHERE a.ContaOs = " + EscaparSQL(THIS.this_cConta) + ;
                    " AND a.ContaDs <> " + EscaparSQL(THIS.this_cConta) + ;
                    " AND a.Dopes = b.Dopes"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorMovCabecalho)

                IF loc_nResultado < 1
                    THIS.this_lFalhaConexao = .T.
                    THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                        "Falha na conexao (CrTprMvCab)"
                    MsgErro(THIS.this_cMensagemErro, "Falha na Conexao")
                ELSE
                    IF USED(THIS.this_cCursorMovFiltrado)
                        USE IN (THIS.this_cCursorMovFiltrado)
                    ENDIF
                    CREATE CURSOR (THIS.this_cCursorMovFiltrado) ;
                        (dopes C(20), empdopnums C(29), valos N(11,2), chksubn L)

                    SELECT (THIS.this_cCursorMovCabecalho)
                    SCAN
                        loc_cDopes      = Dopes
                        loc_lChkPagos   = THIS.BitParaLogico(ChkPagos)
                        loc_nUtilizados = TratarNulo(Utilizados, 0)
                        loc_cEmpDopNums = EmpDopNums
                        loc_nValos      = TratarNulo(Valos, 0)
                        loc_lChkSubn    = THIS.BitParaLogico(ChkSubn)
                        loc_lIncluir    = .F.

                        SELECT (THIS.this_cCursorOpePendente)
                        IF SEEK(loc_cDopes, THIS.this_cCursorOpePendente, "dopes")
                            loc_nTpagos = TratarNulo(Tpagos, 0)
                            loc_nTutils = TratarNulo(Tutils, 0)

                            DO CASE
                            CASE loc_nTpagos = 1
                                loc_lCondPagos = loc_lChkPagos
                            CASE loc_nTpagos = 2
                                loc_lCondPagos = !loc_lChkPagos
                            OTHERWISE
                                loc_lCondPagos = .T.
                            ENDCASE

                            DO CASE
                            CASE loc_nTutils = 1
                                loc_lCondUtils = (loc_nUtilizados = 1)
                            CASE loc_nTutils = 2
                                loc_lCondUtils = (loc_nUtilizados = 0)
                            OTHERWISE
                                loc_lCondUtils = .T.
                            ENDCASE

                            loc_lIncluir = loc_lCondPagos AND loc_lCondUtils
                        ENDIF

                        IF loc_lIncluir
                            SELECT (THIS.this_cCursorMovFiltrado)
                            APPEND BLANK
                            REPLACE dopes WITH loc_cDopes, ;
                                empdopnums WITH loc_cEmpDopNums, ;
                                valos WITH loc_nValos, ;
                                chksubn WITH loc_lChkSubn
                        ENDIF

                        SELECT (THIS.this_cCursorMovCabecalho)
                    ENDSCAN

                    SELECT (THIS.this_cCursorMovFiltrado)
                    SCAN
                        loc_cDopesItem   = dopes
                        loc_cEmpDopNums  = empdopnums
                        loc_nValosItem   = valos
                        loc_lChkSubnItem = chksubn

                        loc_cSQL = "SELECT Dopes, Moedas, " + ;
                            "SUM((Qtds - QtBaixas) * (Units + ValRats)) AS Totas " + ;
                            "FROM SigMvItn " + ;
                            "WHERE EmpDopNums = " + EscaparSQL(loc_cEmpDopNums) + ;
                            " GROUP BY Dopes, Moedas"

                        loc_nResultadoItn = 0
                        IF SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorItensMov) > 0 ;
                                AND USED(THIS.this_cCursorItensMov)
                            loc_nResultadoItn = RECCOUNT(THIS.this_cCursorItensMov)
                        ENDIF

                        IF loc_nResultadoItn > 0
                            SELECT (THIS.this_cCursorItensMov)
                            SCAN
                                loc_cDopesLinha  = Dopes
                                loc_nTotaOrigem  = TratarNulo(Totas, 0)
                                loc_cMoedaOrigem = TratarNulo(Moedas, "")

                                SELECT (THIS.this_cCursorOperacoes)
                                IF !SEEK(loc_cDopesLinha, THIS.this_cCursorOperacoes, "dopes")
                                    APPEND BLANK
                                    REPLACE dopes WITH loc_cDopesLinha
                                ENDIF

                                loc_nConv = ROUND(loc_nTotaOrigem * ;
                                    fBuscarCotacao(loc_cMoedaOrigem, DATE()) / ;
                                    fBuscarCotacao(THIS.this_cMoeda, DATE()), 2)
                                REPLACE totas WITH totas + loc_nConv

                                SELECT (THIS.this_cCursorItensMov)
                            ENDSCAN
                        ELSE
                            *-- legado: Else / If Not CrConserto2.ChkSubn - sem
                            *-- SigMvItn, acumula o Valos CRU, SEM conversao de
                            *-- moeda (transcrito literal - regra #17)
                            IF !loc_lChkSubnItem
                                SELECT (THIS.this_cCursorOperacoes)
                                IF !SEEK(loc_cDopesItem, THIS.this_cCursorOperacoes, "dopes")
                                    APPEND BLANK
                                    REPLACE dopes WITH loc_cDopesItem
                                ENDIF
                                REPLACE totas WITH totas + loc_nValosItem
                            ENDIF
                        ENDIF

                        IF USED(THIS.this_cCursorItensMov)
                            USE IN (THIS.this_cCursorItensMov)
                        ENDIF

                        SELECT (THIS.this_cCursorMovFiltrado)
                    ENDSCAN

                    loc_lSucesso = .T.
                ENDIF
            ENDIF

            SELECT (THIS.this_cCursorOperacoes)
            GO TOP

            IF USED(THIS.this_cCursorOpePendente)
                USE IN (THIS.this_cCursorOpePendente)
            ENDIF
            IF USED(THIS.this_cCursorMovCabecalho)
                USE IN (THIS.this_cCursorMovCabecalho)
            ENDIF
            IF USED(THIS.this_cCursorMovFiltrado)
                USE IN (THIS.this_cCursorMovFiltrado)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar movimentos pendentes:" + ;
                CHR(13) + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCliente - legado:
    *   lcSql = Select Rclis From SigCdCli where Iclis = '<Conta>'
    *   If ...Sqlexecute(lcSql,'CrTmpCli') < 1 -> MessageBox + Return(.F.)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarCliente()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT RClis FROM SigCdCli WHERE IClis = " + ;
                EscaparSQL(THIS.this_cConta)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorCliente)

            IF loc_nResultado < 1
                THIS.this_lFalhaConexao = .T.
                THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                    "Falha na conexao (CrTmpCli)"
                MsgErro(THIS.this_cMensagemErro, "Falha na Conexao")
            ELSE
                SELECT (THIS.this_cCursorCliente)
                THIS.this_cRazaoConta = TratarNulo(RClis, "")
                loc_lSucesso = .T.
            ENDIF

            IF USED(THIS.this_cCursorCliente)
                USE IN (THIS.this_cCursorCliente)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_lFalhaConexao = .T.
            THIS.this_cMensagemErro = "Erro ao carregar cliente:" + CHR(13) + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CalcularSaldoContaCorrente - legado:
    *   CursorQuery('SigMvSlc','CrTmpSccr',@LaCampo)  -- Grupos=_GrupoCc, Contas=_Conta
    *   Scan: _Saldocc += Round(Saldos * cotacao(moedas)/cotacao(crSigClLcr.moedas),2)
    * Sem guarda de falha no legado - zero linha eh estado valido (conta
    * sem movimento de C/C).
    *
    * _GrupoCc do legado so difere de _Grupo quando "Reccount('LocFpg') > 0
    * And .f." - o ".f." hardcoded (comentario do legado: "desabilitado
    * para ajuste no adiantamento a fornecedores") torna esse ramo morto;
    * _GrupoCc fica sempre = _Grupo (mesmo achado documentado em SigOpLbCBO).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CalcularSaldoContaCorrente()
        LOCAL loc_cSQL, loc_nConv

        THIS.this_nSaldoCC = 0
        THIS.this_cGrupoCC = THIS.this_cGrupo

        TRY
            loc_cSQL = "SELECT Moedas, Saldos FROM SigMvSlc " + ;
                "WHERE Grupos = " + EscaparSQL(THIS.this_cGrupoCC) + ;
                " AND Contas = " + EscaparSQL(THIS.this_cConta)

            SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorSaldoConta)

            IF USED(THIS.this_cCursorSaldoConta) AND RECCOUNT(THIS.this_cCursorSaldoConta) > 0
                SELECT (THIS.this_cCursorSaldoConta)
                SCAN
                    loc_nConv = ROUND(TratarNulo(Saldos, 0) * ;
                        fBuscarCotacao(Moedas, DATE()) / ;
                        fBuscarCotacao(THIS.this_cMoeda, DATE()), 2)
                    THIS.this_nSaldoCC = THIS.this_nSaldoCC + loc_nConv
                ENDSCAN
            ENDIF

            IF USED(THIS.this_cCursorSaldoConta)
                USE IN (THIS.this_cCursorSaldoConta)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao calcular saldo de conta corrente:" + ;
                CHR(13) + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CalcularCheques - legado:
    *   lcQuery = cheques em aberto (SigCqChm+SigChe+SigCdOpt, tipos='DB') -> Cheques
    *   If ...Sqlexecute(lcQuery,'Cheques') < 1 -> MessageBox + Return .f.
    *   Scan Cheques:
    *       If IsEmpty(fpags)
    *           _chequep = _chequec + valors   && transcrito LITERAL (ver nota)
    *       Else
    *           CursorQuery('SigOpFp','CrSigOpFp','Fpags',Cheques.Fpags)
    *           If crSigOpFp.valpends # 1 -> _chequec += valors  Else _chequep += valors
    *       EndIf
    *   _Chequec = Round(_chequec / cotacao(crSigClLcr.moedas), 2)
    *   _Chequep = Round(_chequep / cotacao(crSigClLcr.moedas), 2)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CalcularCheques()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        LOCAL loc_nChequeC, loc_nChequeP, loc_cFpags, loc_nValors, loc_nValPends

        loc_lSucesso = .F.
        loc_nChequeC = 0
        loc_nChequeP = 0

        TRY
            loc_cSQL = "SELECT b.GrClis, b.IClis, SUM(b.Valors) AS Valors, b.Fpags " + ;
                "FROM SigCqChm a, SigChe b, SigCdOpt c " + ;
                "WHERE b.GrClis = " + EscaparSQL(THIS.this_cGrupo) + ;
                " AND b.IClis = " + EscaparSQL(THIS.this_cConta) + ;
                " AND b.Umovs = c.Operacaos AND c.Tipos = " + EscaparSQL("DB") + ;
                " AND a.Nums = b.Nums " + ;
                "GROUP BY b.GrClis, b.IClis, b.Fpags"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorCheques)

            IF loc_nResultado < 1
                THIS.this_lFalhaConexao = .T.
                THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                    "Falha na conexao (cheques)"
                MsgErro(THIS.this_cMensagemErro, "Falha na Conexao")
            ELSE
                SELECT (THIS.this_cCursorCheques)
                SCAN
                    loc_cFpags  = TratarNulo(Fpags, "")
                    loc_nValors = TratarNulo(Valors, 0)

                    IF EMPTY(loc_cFpags)
                        *-- Transcrito LITERALMENTE do legado (regra #17 - a
                        *-- formula eh regra de negocio, nao se reescreve):
                        *-- a linha soma ao acumulador de CHEQUES normais mas
                        *-- atribui ao acumulador que fica EM ABERTO. Preservado
                        *-- mesmo parecendo invertido.
                        loc_nChequeP = loc_nChequeC + loc_nValors
                    ELSE
                        loc_cSQL = "SELECT ValPends FROM SigOpFp WHERE Fpags = " + ;
                            EscaparSQL(loc_cFpags)

                        IF SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorFormaPagto) > 0 ;
                                AND USED(THIS.this_cCursorFormaPagto)
                            SELECT (THIS.this_cCursorFormaPagto)
                            loc_nValPends = TratarNulo(ValPends, 0)
                        ELSE
                            loc_nValPends = 0
                        ENDIF

                        IF USED(THIS.this_cCursorFormaPagto)
                            USE IN (THIS.this_cCursorFormaPagto)
                        ENDIF

                        IF loc_nValPends != 1
                            loc_nChequeC = loc_nChequeC + loc_nValors
                        ELSE
                            loc_nChequeP = loc_nChequeP + loc_nValors
                        ENDIF
                    ENDIF

                    SELECT (THIS.this_cCursorCheques)
                ENDSCAN

                loc_lSucesso = .T.
            ENDIF

            IF USED(THIS.this_cCursorCheques)
                USE IN (THIS.this_cCursorCheques)
            ENDIF

            THIS.this_nTotalCheques     = ROUND(loc_nChequeC / fBuscarCotacao(THIS.this_cMoeda, DATE()), 2)
            THIS.this_nChequesPendentes = ROUND(loc_nChequeP / fBuscarCotacao(THIS.this_cMoeda, DATE()), 2)
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao calcular cheques:" + CHR(13) + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarTipoOperacao - legado:
    *   CursorQuery('SigCdTom','LocalTOpe','Codigos',TipoOp)
    * Sem guarda de falha no legado - zero linha so zera GerGdmis e segue.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarTipoOperacao()
        LOCAL loc_cSQL

        TRY
            loc_cSQL = "SELECT Codigos, GerGdmis FROM SigCdTom " + ;
                "WHERE Codigos = " + FormatarNumeroSQL(THIS.this_nTipoOp, 0)

            SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorTipoOperacao)

            IF USED(THIS.this_cCursorTipoOperacao) AND RECCOUNT(THIS.this_cCursorTipoOperacao) > 0
                SELECT (THIS.this_cCursorTipoOperacao)
                THIS.this_nGerGdmis = TratarNulo(GerGdmis, 0)
            ELSE
                THIS.this_nGerGdmis = 0
            ENDIF

            IF USED(THIS.this_cCursorTipoOperacao)
                USE IN (THIS.this_cCursorTipoOperacao)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar tipo de opera" + CHR(231) + CHR(227) + "o:" + ;
                CHR(13) + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametrosSistema - cursor crSigCdPam do legado (SigCdPam eh
    * tabela de UMA linha). Sem guarda de falha no legado - zero linha so
    * zera os parametros e segue.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarParametrosSistema()
        LOCAL loc_cSQL

        TRY
            loc_cSQL = "SELECT OpPends, ChqlCreds FROM SigCdPam"

            SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorParametros)

            IF USED(THIS.this_cCursorParametros) AND RECCOUNT(THIS.this_cCursorParametros) > 0
                SELECT (THIS.this_cCursorParametros)
                THIS.this_nOpPendsParam     = TratarNulo(OpPends, 0)
                THIS.this_lChqLimiteCredito = THIS.BitParaLogico(ChqlCreds)
            ELSE
                THIS.this_nOpPendsParam     = 0
                THIS.this_lChqLimiteCredito = .F.
            ENDIF

            IF USED(THIS.this_cCursorParametros)
                USE IN (THIS.this_cCursorParametros)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar parametros do sistema:" + ;
                CHR(13) + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CalcularPendencias - legado:
    *   _Pendente = Round(TprMvCab.valos / cotacao(crSigClLcr.moedas), 2)
    *   _PendOutr = 0
    *   lcQuery = soma por Dopes/Moedas de SigMvCab+SigMvItn+SigCdOpe, no
    *             lado definido por LimCres (1,3,5=Origem / senao Destino -
    *             a MESMA membresia da faixa de Container1, NAO o lado
    *             efetivamente em tela), excluindo a chave desta
    *             movimentacao (EmpDopNums <> _chvLCred), filtrado por
    *             c.Tipoops = Str(CrSigCdPam.Oppends,2) -> Pendencia
    *   If ...Sqlexecute(lcQuery,'Pendencia') < 1 -> MessageBox + Return .f.
    *   Scan Pendencia: _PendOutr += Round(totas*cotacao(moedas)/cotacao(crSigClLcr.moedas),2)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CalcularPendencias()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nConv
        LOCAL loc_cCampoGrupoSQL, loc_cCampoContaSQL

        loc_lSucesso = .F.

        TRY
            THIS.this_nPendente = ROUND(THIS.this_nValorMovimento / ;
                fBuscarCotacao(THIS.this_cMoeda, DATE()), 2)
            THIS.this_nPendenteOutros = 0

            IF INLIST(THIS.this_nTipoLimCredito, 1, 3, 5)
                loc_cCampoGrupoSQL = "a.Grupoos"
                loc_cCampoContaSQL = "a.Contaos"
            ELSE
                loc_cCampoGrupoSQL = "a.Grupods"
                loc_cCampoContaSQL = "a.Contads"
            ENDIF

            loc_cSQL = "SELECT SUM((b.Qtds - b.QtBaixas) * b.Units) AS Totas, b.Moedas, a.Dopes " + ;
                "FROM SigMvCab a, SigMvItn b, SigCdOpe c " + ;
                "WHERE " + loc_cCampoGrupoSQL + " = " + EscaparSQL(THIS.this_cGrupo) + ;
                " AND " + loc_cCampoContaSQL + " = " + EscaparSQL(THIS.this_cConta) + ;
                " AND a.EmpDopNums <> " + EscaparSQL(THIS.this_cChaveLimCredito) + ;
                " AND a.EmpDopNums = b.EmpDopNums AND a.Dopes = c.Dopes " + ;
                " AND c.TipoOps = " + FormatarNumeroSQL(THIS.this_nOpPendsParam, 0) + ;
                " GROUP BY b.Moedas, a.Dopes"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorPendencia)

            IF loc_nResultado < 1
                THIS.this_lFalhaConexao = .T.
                THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                    "Falha na conexao (Pendencia)"
                MsgErro(THIS.this_cMensagemErro, "Falha na Conexao")
            ELSE
                SELECT (THIS.this_cCursorPendencia)
                SCAN
                    loc_nConv = ROUND(TratarNulo(Totas, 0) * fBuscarCotacao(Moedas, DATE()) / ;
                        fBuscarCotacao(THIS.this_cMoeda, DATE()), 2)
                    THIS.this_nPendenteOutros = THIS.this_nPendenteOutros + loc_nConv
                ENDSCAN

                loc_lSucesso = .T.
            ENDIF

            IF USED(THIS.this_cCursorPendencia)
                USE IN (THIS.this_cCursorPendencia)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao calcular pendencias:" + CHR(13) + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CalcularSaldoDisponivel - legado:
    *   _SaldoFinal = crSigClLcr.limcres
    *       - Iif(LocalTOpe.GerGdmis=3,(_Pendente + _PendOutr),0)
    *       - _Saldocc
    *       - Iif(LocalTOpe.GerGdmis=3 Or crSigCdPam.ChqlCreds,_Chequec,0)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CalcularSaldoDisponivel()
        LOCAL loc_nAbatePendencia, loc_nAbateCheques

        loc_nAbatePendencia = IIF(THIS.this_nGerGdmis = 3, ;
            (THIS.this_nPendente + THIS.this_nPendenteOutros), 0)

        loc_nAbateCheques = IIF(THIS.this_nGerGdmis = 3 OR THIS.this_lChqLimiteCredito, ;
            THIS.this_nTotalCheques, 0)

        THIS.this_nSaldoDisponivel = THIS.this_nLimiteCredito - loc_nAbatePendencia - ;
            THIS.this_nSaldoCC - loc_nAbateCheques
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarObservacaoConta - bloco "Container2" do legado. A conta
    * consultada (Origem x Destino) decide pela MESMA condicao de
    * PrecisaExibirObservacao() - ver nota em EstaVendoOrigem/EstaVendoDestino.
    * O caption exibido pelo Form usa this_cConta (o lado GERAL em foco),
    * nao necessariamente a mesma conta usada nesta consulta - fiel ao
    * legado (ThisForm.Container2.Get_nconta.Caption = _Conta).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarObservacaoConta()
        LOCAL loc_cConta, loc_cSQL, loc_lAtivou

        loc_lAtivou = .F.

        IF THIS.EstaVendoOrigem() AND THIS.this_nObsOrigs = 1
            loc_cConta = THIS.this_cContaOrigem
        ELSE
            loc_cConta = THIS.this_cContaDestino
        ENDIF

        TRY
            loc_cSQL = "SELECT Obs, Situas, VultComps, UltComps, Nascs, Codigos " + ;
                "FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cConta)

            SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorCliente)

            IF USED(THIS.this_cCursorCliente) AND RECCOUNT(THIS.this_cCursorCliente) > 0
                SELECT (THIS.this_cCursorCliente)
                IF !EMPTY(TratarNulo(Obs, ""))
                    THIS.this_cObsCliente        = TratarNulo(Obs, "")
                    THIS.this_lContainer2Visivel = .T.
                    loc_lAtivou = .T.
                ENDIF
            ENDIF

            IF USED(THIS.this_cCursorCliente)
                USE IN (THIS.this_cCursorCliente)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar observa" + CHR(231) + CHR(227) + "o da conta:" + ;
                CHR(13) + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lAtivou = .F.
        ENDTRY

        RETURN loc_lAtivou
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarSituacaoConta - bloco "Container3" do legado: situacao
    * cadastral da conta (SigCdCli/SigCdCst) e, quando this_nOriDes > 0
    * (lado FIXO, nao dialogo livre), o bloqueio de movimentacao/desconto
    * que zera this_lRetorno - o Form usa isso para RECUSAR a gravacao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarSituacaoConta()
        LOCAL loc_cConta, loc_cSQL, loc_lAtivou, loc_cDescrSit

        loc_lAtivou = .F.

        IF THIS.EstaVendoOrigem() AND THIS.this_nExibSits = 3
            loc_cConta = THIS.this_cContaOrigem
        ELSE
            loc_cConta = THIS.this_cContaDestino
        ENDIF

        TRY
            loc_cSQL = "SELECT Obs, Situas, VultComps, UltComps, Nascs, Codigos, DtnCons, DtCasas " + ;
                "FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cConta)

            SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorCliente)

            IF USED(THIS.this_cCursorCliente) AND RECCOUNT(THIS.this_cCursorCliente) > 0
                SELECT (THIS.this_cCursorCliente)
                THIS.this_cSituacaoCod       = TratarNulo(Situas, "")
                THIS.this_nValorUltimaCompra = TratarNulo(VultComps, 0)
                THIS.this_dUltimaCompra      = TratarNulo(UltComps, {})
                THIS.this_dNascimento        = TratarNulo(Nascs, {})
                THIS.this_cCodigoCliente     = TratarNulo(Codigos, "")
                THIS.this_dDtnCons           = TratarNulo(DtnCons, {})
                THIS.this_dDtCasas           = TratarNulo(DtCasas, {})
            ENDIF

            IF USED(THIS.this_cCursorCliente)
                USE IN (THIS.this_cCursorCliente)
            ENDIF

            loc_cSQL = "SELECT Codigos, DispMovs, BlqMovs, BlqDescs, Descrs, Descr2s " + ;
                "FROM SigCdCst WHERE Codigos = " + EscaparSQL(THIS.this_cSituacaoCod)

            SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorSituacao)

            IF USED(THIS.this_cCursorSituacao) AND RECCOUNT(THIS.this_cCursorSituacao) > 0
                SELECT (THIS.this_cCursorSituacao)
                THIS.this_nDispMovs = TratarNulo(DispMovs, 0)
                THIS.this_nBlqMovs  = TratarNulo(BlqMovs, 0)
                THIS.this_nBlqDescs = TratarNulo(BlqDescs, 0)

                IF THIS.this_nDispMovs = 1 AND !EMPTY(THIS.this_cConta)
                    loc_cDescrSit = IIF(EMPTY(TratarNulo(Descr2s, "")), ;
                        TratarNulo(Descrs, ""), TratarNulo(Descr2s, ""))

                    THIS.this_cDescrSituacao     = loc_cDescrSit
                    THIS.this_lContainer3Visivel = .T.
                    loc_lAtivou = .T.

                    THIS.this_cMsgBloqueio        = ""
                    THIS.this_lMsgBloqueioVisivel = .F.

                    IF THIS.this_nOriDes > 0
                        IF THIS.this_nBlqMovs = 1
                            THIS.this_lMsgBloqueioVisivel = .T.
                            THIS.this_cMsgBloqueio = "Movimenta" + CHR(231) + CHR(227) + ;
                                "o Bloqueada pela Situacao da Conta"
                            THIS.this_lRetorno = .F.
                        ELSE
                            IF THIS.this_nValVarsMovimento < 0 AND THIS.this_nBlqDescs = 1
                                THIS.this_lMsgBloqueioVisivel = .T.
                                THIS.this_cMsgBloqueio = "Desconto Bloqueado Pela Situa" + ;
                                    CHR(231) + CHR(227) + "o da Conta"
                                THIS.this_lRetorno = .F.
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            IF USED(THIS.this_cCursorSituacao)
                USE IN (THIS.this_cCursorSituacao)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar situa" + CHR(231) + CHR(227) + "o da conta:" + ;
                CHR(13) + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lAtivou = .F.
        ENDTRY

        RETURN loc_lAtivou
    ENDPROC

    *--------------------------------------------------------------------------
    * BitParaLogico - Normaliza coluna BIT do SQL Server para Logico. O
    * driver entrega ora Logico (.T./.F.) ora Numerico (0/1) conforme o
    * ponto da query - testar o VARTYPE numa VARIAVEL LOCAL, nunca dentro
    * de IIF/OR no meio de um SELECT (os dois lados sempre avaliam, e o
    * lado "errado" estoura "Operator/operand type mismatch").
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BitParaLogico(par_uValor)
        LOCAL loc_lRetorno

        DO CASE
        CASE VARTYPE(par_uValor) = "L"
            loc_lRetorno = par_uValor
        CASE VARTYPE(par_uValor) = "N"
            loc_lRetorno = (par_uValor = 1)
        OTHERWISE
            loc_lRetorno = .F.
        ENDCASE

        RETURN loc_lRetorno
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Dopes da operacao (SigCdOpe). Este BO eh
    * somente-leitura: consolida consultas de varias tabelas para decidir
    * se uma movimentacao pode ser liberada, mas nunca grava nada (o
    * legado nao tem Insert/Update/Delete em lugar nenhum do Processa()).
    * Por isso NAO sobrescreve Inserir()/Atualizar()/ExecutarExclusao() -
    * o comportamento herdado de BusinessBase (recusar a operacao) ja eh o
    * correto. Sobrescrito aqui so pela convencao do projeto (CLAUDE.md -
    * Audit System), mesmo que RegistrarAuditoria nunca seja chamado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cDopes
    ENDPROC

ENDDEFINE
