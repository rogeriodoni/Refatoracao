*==============================================================================
* SigOpLbCBO.prg
*
* Business Object para Liberacao de Credito (SigOpLbC)
*
* Form OPERACIONAL de CONSULTA: exibe a composicao do limite de credito de
* uma conta no momento em que uma movimentacao esta sendo lancada, para que
* o operador decida pela liberacao. Nao grava nada - apenas consulta e
* calcula. Por isso NAO sobrescreve Inserir()/Atualizar()/ExecutarExclusao():
* o comportamento padrao herdado de BusinessBase ja eh o correto.
*
* Tabela principal: SigCdOpe (Dopes) - a operacao que disparou a liberacao
*
* Tabelas consultadas (nomes e colunas EXATOS do legado - PILAR 2):
*   SigCdOpe  Dopes, TipoOps, Nivels, LimCres, OpPends
*   SigClLcr  LimCres, Moedas, GruContas       (limite de credito da conta)
*   SigOpPed  Dopes, Tpagos, Tutils            (configuracao das operacoes a considerar)
*   SigMvCab  Emps, Numes, ValOs, GrupoOs, ContaOs, GrupoDs, ContaDs,
*             EmpDopNums, ChkPagos, ChkSubn, Utilizados, Dopes
*   SigMvItn  EmpDopNums, Dopes, Moedas, Qtds, QtBaixas, Units, ValRats
*   SigMvSlc  Grupos, Contas, Moedas, Saldos   (saldo de conta corrente)
*   SigCdCli  IClis, RClis                     (razao social do cliente)
*   SigChe    GrClis, IClis, Valors, Fpags, UMovs, Nums
*   SigCqChm  Nums
*   SigCdOpt  Operacaos, Tipos
*   SigOpFp   Fpags, ValPends
*   SigCdTom  Codigos, GerGdmis                (tipo de operacao)
*   SigCdPam  OpPends, ChqlCreds               (parametros do sistema)
*
* Herda de: BusinessBase
*
* FASE 1/8 - Propriedades e Init
* FASE 2/8 - Metodos de calculo (equivalente funcional ao CRUD, ja que o
*   BO eh somente-leitura): CalcularComposicaoLimite() eh o ponto de
*   entrada publico chamado pelo Form; os demais sao passos do Init do
*   legado, um a um, incluindo as duas queries que o legado SO executa
*   no passe de dados: LocalOpePd/CrTprMvCab/CrConserto2/lCredEesti
*   (grade de movimentacoes em aberto) e Pendencia/Cheques (totais).
*   CrTmpOpe (Select Dopes,OpPends From SigCdOpe) eh lida e indexada no
*   legado mas NUNCA referenciada depois - dead code confirmado por
*   busca no dump completo - omitida aqui por nao ter efeito observavel.
*   CarregarDoCursor() sobrescreve o metodo de BusinessBase e eh a FONTE
*   UNICA do mapeamento SigCdOpe -> propriedades, com guarda de EOF.
*==============================================================================

DEFINE CLASS SigOpLbCBO AS BusinessBase

    *==========================================================================
    * PARAMETROS DE ENTRADA
    * O legado recebe Init(loForm, Operacao, loForm2); loForm/loForm2 sao
    * referencias de UI e ficam no Form. Ao BO interessa apenas a operacao.
    *==========================================================================

    this_cOperacao = ""                 && par Operacao - SigCdOpe.Dopes char(20)

    *==========================================================================
    * SigCdOpe - cursor lCredOpe do legado
    * Select Dopes, TipoOps, Nivels, LimCres From SigCdOpe Where Dopes = <op>
    *==========================================================================

    this_cDopes    = ""                 && SigCdOpe.Dopes   char(20)
    this_nTipoOps  = 0                  && SigCdOpe.TipoOps numeric(2,0) - legado Tipoop
    this_cNivels   = ""                 && SigCdOpe.Nivels  char(20)     - legado _Nivel
    this_nLimCres  = 0                  && SigCdOpe.LimCres numeric(1,0) - 1 = usa ORIGEM, senao DESTINO

    *==========================================================================
    * Cabecalho da movimentacao em lancamento (cursor TprMvCab do legado)
    * O lado lido (origem x destino) depende de SigCdOpe.LimCres.
    *==========================================================================

    this_cEmps             = ""         && SigMvCab.Emps    char(3)
    this_nNumes            = 0          && SigMvCab.Numes   numeric(6,0)
    this_nValorMovimento   = 0          && SigMvCab.ValOs   numeric(11,2) - base do legado _Pendente
    this_cGrupo            = ""         && legado _Grupo  - GrupoOs ou GrupoDs  char(10)
    this_cConta            = ""         && legado _Conta  - ContaOs ou ContaDs  char(10)
    this_cCampoGrupoSQL    = ""         && legado _mgrupo - "a.grupoos" / "a.grupods"
    this_cCampoContaSQL    = ""         && legado _mconta - "a.contaos" / "a.contads"

    *-- legado _ChvLCred: Emps(3) + Nivels(20) + Str(Numes,6) = char(29)
    *-- Chave POSICIONAL: montar com PADR, NUNCA com ALLTRIM nas partes,
    *-- senao o WHERE nao casa e a consulta devolve ZERO linhas em silencio.
    this_cChaveLimiteCredito = ""       && SigMvCab.EmpDopNums char(29) a EXCLUIR da pendencia

    *==========================================================================
    * SigClLcr - limite de credito da conta (cursor CrSigClLcr do legado)
    * CursorQuery('SigClLcr','CrSigClLcr','GruContas', _Grupo + _Conta)
    *==========================================================================

    this_nLimiteCredito = 0             && SigClLcr.LimCres   numeric(10,2)
    this_cMoeda         = ""            && SigClLcr.Moedas    char(3) - moeda de CONVERSAO de tudo
    this_cGruContas     = ""            && SigClLcr.GruContas char(20) - _Grupo + _Conta

    *==========================================================================
    * SigCdCli - identificacao do cliente (cursor CrTmpCli do legado)
    *==========================================================================

    this_cRazaoCliente   = ""           && SigCdCli.RClis char(50)
    this_cDescricaoConta = ""           && legado: _Conta + " " + Alltrim(RClis) - caption get_nconta

    *==========================================================================
    * SigCdTom - tipo de operacao (cursor LocalTOpe do legado)
    * CursorQuery('SigCdTom','LocalTOpe','Codigos', TipoOp)
    *==========================================================================

    this_nGerGdmis = 0                  && SigCdTom.GerGdmis numeric(1,0) - 3 = abate pendencias/cheques

    *==========================================================================
    * SigCdPam - parametros do sistema (cursor crSigCdPam do legado)
    *==========================================================================

    this_nOpPendsParam     = 0          && SigCdPam.OpPends   numeric(2,0) - TipoOps que conta como pendencia
    this_lChqLimiteCredito = .F.        && SigCdPam.ChqlCreds bit - cheque sempre abate o limite

    *==========================================================================
    * VALORES CALCULADOS - todos convertidos para this_cMoeda (SigClLcr.Moedas)
    * Nomes do legado preservados em comentario para rastrear cada formula.
    *==========================================================================

    this_nCotacao            = 0        && fBuscarCotacao(this_cMoeda, Date()) - get_cotacao
    this_nSaldoContaCorrente = 0        && legado _Saldocc  - SUM de SigMvSlc.Saldos convertido
    this_nTotalCheques       = 0        && legado _chequec  - cheques que NAO sao valor pendente
    this_nChequesPendentes   = 0        && legado _chequep  - cheques cuja forma de pagamento fica em aberto
    this_nPendente           = 0        && legado _Pendente - ValOs desta movimentacao, convertido
    this_nPendenteOutros     = 0        && legado _PendOutr - SUM das OUTRAS movimentacoes em aberto
    this_nSaldoDisponivel    = 0        && legado _SaldoFinal - resultado exibido em get_disponivel

    *==========================================================================
    * CURSORES
    * cursor_4c_Operacoes eh o cursor da GRADE (DbOpera do legado), criado
    * no Load com "Create Cursor DbOpera (dopes c(20), totas n(12,2))".
    * A estrutura e a ORDEM das colunas tem de ser identicas em CADA lugar
    * que recriar o cursor, e os ControlSource da grade usam estes nomes.
    *==========================================================================

    this_cCursorOperacoes    = "cursor_4c_Operacoes"        && DbOpera     - GRADE (Dopes, Totas)
    this_cCursorCredOpe      = "cursor_4c_CredOpe"          && lCredOpe
    this_cCursorLimiteConta  = "cursor_4c_LimiteConta"      && CrSigClLcr
    this_cCursorOpePendente  = "cursor_4c_OpePendente"      && LocalOpePd
    this_cCursorTipoOpePend  = "cursor_4c_TipoOpePend"      && CrTmpOpe
    this_cCursorMovCabecalho = "cursor_4c_MovCabecalho"     && CrTprMvCab
    this_cCursorMovFiltrado  = "cursor_4c_MovFiltrado"      && CrConserto2
    this_cCursorItensMov     = "cursor_4c_ItensMov"         && lCredEesti
    this_cCursorCliente      = "cursor_4c_Cliente"          && CrTmpCli
    this_cCursorSaldoConta   = "cursor_4c_SaldoConta"       && CrTmpSccr
    this_cCursorCheques      = "cursor_4c_Cheques"          && Cheques
    this_cCursorFormaPagto   = "cursor_4c_FormaPagto"       && CrSigOpFp
    this_cCursorPendencia    = "cursor_4c_Pendencia"        && Pendencia
    this_cCursorTipoOperacao = "cursor_4c_TipoOperacao"     && LocalTOpe
    this_cCursorParametros   = "cursor_4c_Parametros"       && crSigCdPam

    *==========================================================================
    * ESTADO
    * O Init do legado tem dois desfechos de recusa DIFERENTES, e o Form
    * precisa distinguir: Return(.F.) por falha de conexao (com a mensagem
    * "Favor reinicializar o processo") e Return simples quando Grupo ou
    * Conta estao vazios (sem mensagem alguma - nada a liberar).
    *==========================================================================

    this_lDadosCarregados = .F.         && .T. quando a composicao foi calculada
    this_lFalhaConexao    = .F.         && .T. quando algum SQLEXEC falhou
    this_lContaIndefinida = .F.         && .T. quando Grupo ou Conta vazio (legado: Return sem msg)

    *==========================================================================
    * Init - Inicializa Business Object
    *
    * Nenhuma consulta roda aqui: o legado faz tudo no Init do FORM, depois
    * de receber a operacao e o cursor do cabecalho da movimentacao. O Form
    * chama os metodos de carga apos informar this_cOperacao.
    *
    * RETURN apenas FORA do TRY/CATCH - dentro do bloco so a flag
    * loc_lSucesso eh movimentada.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigCdOpe"
            THIS.this_cCampoChave = "Dopes"

            *-- Estado inicial explicito: a instancia pode ser reaproveitada
            *-- pelo Form entre duas liberacoes, e flag de sessao anterior
            *-- ligada faria a tela exibir a composicao do movimento antigo.
            THIS.this_lDadosCarregados = .F.
            THIS.this_lFalhaConexao    = .F.
            THIS.this_lContaIndefinida = .F.

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inicializar SigOpLbCBO:" + CHR(13) + ;
                loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * FASE 2/8 - METODOS DE CALCULO
    *==========================================================================

    *--------------------------------------------------------------------------
    * CalcularComposicaoLimite - Calcula a composicao do limite de credito da
    * conta envolvida numa movimentacao, para a tela decidir pela liberacao.
    *
    * Espelha o Init(loForm, Operacao, loForm2) do legado: loForm/loForm2 sao
    * referencias de tela e ficam com o Form; aqui chegam so a operacao e os
    * campos do cabecalho da movimentacao em lancamento (legado: cursor
    * TprMvCab, selecionado pelo form CHAMADOR antes de abrir esta tela).
    *
    * Retorna .T. quando a composicao foi calculada com sucesso. Retorna .F.
    * em dois casos que o Form tem de distinguir - this_lFalhaConexao (legado:
    * Return(.F.) com MessageBox "Favor reinicializar o processo") e
    * this_lContaIndefinida (legado: Return simples, SEM mensagem, quando
    * Grupo ou Conta do lado considerado estao vazios).
    *--------------------------------------------------------------------------
    PROCEDURE CalcularComposicaoLimite(par_cOperacao, par_cEmps, par_nNumes, ;
            par_nValOs, par_cGrupoOs, par_cContaOs, par_cGrupoDs, par_cContaDs)

        LOCAL loc_lSucesso

        THIS.this_lDadosCarregados = .F.
        THIS.this_lFalhaConexao    = .F.
        THIS.this_lContaIndefinida = .F.

        THIS.this_cOperacao = TratarNulo(par_cOperacao, "")

        loc_lSucesso = THIS.CarregarOperacao()

        IF loc_lSucesso
            THIS.DefinirLadoMovimento(par_cEmps, par_nNumes, par_nValOs, ;
                par_cGrupoOs, par_cContaOs, par_cGrupoDs, par_cContaDs)

            IF EMPTY(THIS.this_cGrupo) OR EMPTY(THIS.this_cConta)
                *-- legado: "If IsEmpty(_Grupo) Or IsEmpty(_Conta) / Return" -
                *-- sem mensagem, nada a liberar (conta nao se aplica a este lado)
                THIS.this_lContaIndefinida = .T.
                loc_lSucesso = .F.
            ELSE
                *-- legado: _ChvLCred = TprMvCab.Emps + _Nivel + Str(TprMvCab.Numes,6)
                *-- Chave POSICIONAL (regra #42): PADR explicito nas partes,
                *-- NUNCA ALLTRIM - senao o WHERE de CalcularPendencias() nao
                *-- casa e a consulta devolve zero linhas em silencio.
                THIS.this_cChaveLimiteCredito = PADR(THIS.this_cEmps, 3) + ;
                    PADR(THIS.this_cNivels, 20) + STR(THIS.this_nNumes, 6)
            ENDIF
        ENDIF

        IF loc_lSucesso
            loc_lSucesso = THIS.CarregarLimiteCredito()
        ENDIF

        IF loc_lSucesso
            loc_lSucesso = THIS.CarregarMovimentosPendentes()
        ENDIF

        IF loc_lSucesso
            loc_lSucesso = THIS.CarregarCliente()
        ENDIF

        IF loc_lSucesso
            *-- legado: ThisForm.get_nconta.Caption = _Conta + ' ' + Alltrim(lcRazao)
            THIS.this_cDescricaoConta = ALLTRIM(THIS.this_cConta) + " " + ;
                ALLTRIM(THIS.this_cRazaoCliente)
            loc_lSucesso = THIS.CalcularSaldoContaCorrente()
        ENDIF

        IF loc_lSucesso
            loc_lSucesso = THIS.CalcularCheques()
        ENDIF

        IF loc_lSucesso
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
            THIS.this_lDadosCarregados = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOperacao - legado:
    *   lcSql = Select Dopes,TipoOps,Nivels,LimCres From SigCdOpe Where Dopes=<op>
    *   If Sqlexecute(lcsql,'lCredOpe') < 1 -> MessageBox + Return(.F.)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarOperacao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Dopes, TipoOps, Nivels, LimCres FROM SigCdOpe " + ;
                "WHERE Dopes = " + EscaparSQL(THIS.this_cOperacao)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorCredOpe)

            *-- legado: "If ...Sqlexecute(lcsql,'lCredOpe') < 1". No Fortyus o
            *-- retorno eh a CONTAGEM de linhas, logo ZERO linha tambem cai na
            *-- recusa. O SQLEXEC do VFP9 devolve 1 por result set e NAO conta
            *-- linhas: a ausencia de registro eh detectada pela guarda de EOF
            *-- de CarregarDoCursor, que devolve .F. - sem ela a leitura em EOF
            *-- entregaria branco/zero e o calculo seguiria com limite 0 e o
            *-- lado da conta errado, sem erro nenhum na tela.
            IF loc_nResultado < 1
                loc_lSucesso = .F.
            ELSE
                *-- Mapeamento SigCdOpe -> propriedades em FONTE UNICA
                loc_lSucesso = THIS.CarregarDoCursor(THIS.this_cCursorCredOpe)
            ENDIF

            IF !loc_lSucesso
                THIS.this_lFalhaConexao = .T.
                THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                    "Falha na conexao (lCredOpe)"
                MsgErro(THIS.this_cMensagemErro, "Falha na Conexao")
            ENDIF

            IF USED(THIS.this_cCursorCredOpe)
                USE IN (THIS.this_cCursorCredOpe)
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
    * CarregarDoCursor - FONTE UNICA do mapeamento da tabela principal
    * (SigCdOpe) para as propriedades do BO.
    *
    * Sobrescreve o metodo homonimo de BusinessBase, que eh PUBLIC: marcar a
    * sobrescrita como PROTECTED a tornaria inalcancavel de fora, porque
    * PROTECTED em QUALQUER nivel da heranca vence (regra #51).
    *
    * Colunas EXATAS de SigCdOpe (conferidas em docs/schema.sql):
    *   dopes   char(20)        tipoops numeric(2,0)
    *   nivels  char(20)        limcres numeric(1,0)
    *
    * Devolve .F. quando NAO ha registro corrente para ler - alias fechado,
    * cursor vazio ou em EOF. Essa guarda eh o que traduz o "< 1" do legado:
    * no Fortyus o Sqlexecute devolvia a CONTAGEM de linhas, enquanto o
    * SQLEXEC do VFP9 devolve 1 por result set e nao distingue zero linha.
    * Sem a guarda, a leitura em EOF entrega branco/zero sem erro algum.
    *
    * Sem par_cAliasCursor, assume o cursor da propria consulta de operacao
    * (this_cCursorCredOpe), que eh o unico chamador interno.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias

        loc_lSucesso = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor)
            loc_cAlias = ALLTRIM(par_cAliasCursor)
        ELSE
            loc_cAlias = THIS.this_cCursorCredOpe
        ENDIF

        TRY
            IF USED(loc_cAlias)
                SELECT (loc_cAlias)

                IF RECCOUNT(loc_cAlias) > 0 AND !EOF(loc_cAlias)
                    *-- TYPE() eh a forma valida de testar existencia de campo
                    *-- em CURSOR (PEMSTATUS exige objeto e estoura recebendo
                    *-- alias). Necessario porque BusinessBase.Buscar aceita a
                    *-- lista de campos em pcCampos, logo o alias pode chegar
                    *-- mais estreito que o SELECT de CarregarOperacao().
                    IF TYPE(loc_cAlias + ".Dopes") != "U"
                        THIS.this_cDopes = TratarNulo(Dopes, "")
                    ENDIF

                    IF TYPE(loc_cAlias + ".TipoOps") != "U"
                        THIS.this_nTipoOps = TratarNulo(TipoOps, 0)
                    ENDIF

                    IF TYPE(loc_cAlias + ".Nivels") != "U"
                        *-- legado _Nivel: entra na chave posicional
                        *-- EmpDopNums = Emps(3) + Nivels(20) + Str(Numes,6)
                        THIS.this_cNivels = TratarNulo(Nivels, "")
                    ENDIF

                    IF TYPE(loc_cAlias + ".LimCres") != "U"
                        *-- numeric(1,0): 1 = considerar o lado ORIGEM do
                        *-- movimento; qualquer outro valor = lado DESTINO.
                        THIS.this_nLimCres = TratarNulo(LimCres, 0)
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar do cursor [" + loc_cAlias + "]:" + ;
                CHR(13) + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "SigOpLbCBO.CarregarDoCursor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * DefinirLadoMovimento - legado:
    *   Select TprMvCab
    *   If lCredOpe.limcres = 1
    *       _Grupo=grupoos / _Conta=Contaos / _mgrupo='a.grupoos' / _mconta='a.contaos'
    *   Else
    *       _Grupo=grupods / _Conta=Contads / _mgrupo='a.grupods' / _mconta='a.contads'
    *   EndIf
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE DefinirLadoMovimento(par_cEmps, par_nNumes, par_nValOs, ;
            par_cGrupoOs, par_cContaOs, par_cGrupoDs, par_cContaDs)

        THIS.this_cEmps           = TratarNulo(par_cEmps, "")
        THIS.this_nNumes          = TratarNulo(par_nNumes, 0)
        THIS.this_nValorMovimento = TratarNulo(par_nValOs, 0)

        IF THIS.this_nLimCres = 1
            THIS.this_cGrupo         = TratarNulo(par_cGrupoOs, "")
            THIS.this_cConta         = TratarNulo(par_cContaOs, "")
            THIS.this_cCampoGrupoSQL = "a.grupoos"
            THIS.this_cCampoContaSQL = "a.contaos"
        ELSE
            THIS.this_cGrupo         = TratarNulo(par_cGrupoDs, "")
            THIS.this_cConta         = TratarNulo(par_cContaDs, "")
            THIS.this_cCampoGrupoSQL = "a.grupods"
            THIS.this_cCampoContaSQL = "a.contads"
        ENDIF

        *-- SigClLcr.GruContas char(20) = Grupos char(10) + Contas char(10)
        THIS.this_cGruContas = PADR(THIS.this_cGrupo, 10) + PADR(THIS.this_cConta, 10)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLimiteCredito - legado:
    *   CursorQuery('SigClLcr','CrSigClLcr','GruContas',_Grupo+_Conta)
    * Sem guarda de falha no legado (API diferente do Sqlexecute): zero
    * linha nao eh erro, so zera o limite e segue (conta sem limite cadastrado).
    *
    * Este metodo eh a FONTE UNICA das tres leituras que o legado faz do
    * CrSigClLcr para a tela, e as tres andam JUNTAS (linhas 886-887 do dump):
    *
    *   ThisForm.get_limcred.Value = crSigClLcr.limcres        -> this_nLimiteCredito
    *   ThisForm.get_moeda.Value   = crSigClLcr.moedas         -> this_cMoeda
    *   ThisForm.get_cotacao.Value = fBuscarCotacao(crSigClLcr.moedas, date())
    *                                                          -> this_nCotacao
    *
    * A cotacao vem de fBuscarCotacao() (utils\functions.prg), que eh o mesmo
    * helper que o legado usa e que JA esta portado - nao reimplementar aqui
    * (regra #13). Ele devolve 1.0 para moeda vazia ou "R$", exatamente o que
    * o legado exibe quando a conta nao tem limite cadastrado, por isso a
    * chamada fica FORA do IF de RECCOUNT: o legado tambem le
    * crSigClLcr.moedas sem testar EOF e cai no mesmo 1.0.
    *
    * A cotacao eh so EXIBICAO (campo "Cambio :"): as conversoes de valor
    * chamam fBuscarCotacao() no ponto de uso, como o legado, porque cada uma
    * converte de uma moeda de ORIGEM diferente - guardar uma taxa so aqui e
    * reaproveita-la nos calculos trocaria o divisor e alteraria valor
    * gravado/exibido (regra #17).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarLimiteCredito()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT LimCres, Moedas FROM SigClLcr " + ;
                "WHERE GruContas = " + EscaparSQL(THIS.this_cGruContas)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorLimiteConta)

            IF loc_nResultado < 0
                THIS.this_lFalhaConexao = .T.
                THIS.this_cMensagemErro = "Erro ao carregar limite de cr" + CHR(233) + "dito."
                MsgErro(THIS.this_cMensagemErro, "Erro")
            ELSE
                IF loc_nResultado > 0 AND RECCOUNT(THIS.this_cCursorLimiteConta) > 0
                    SELECT (THIS.this_cCursorLimiteConta)
                    THIS.this_nLimiteCredito = TratarNulo(LimCres, 0)
                    THIS.this_cMoeda         = TratarNulo(Moedas, "")
                ELSE
                    THIS.this_nLimiteCredito = 0
                    THIS.this_cMoeda         = ""
                ENDIF

                *-- legado: ThisForm.get_cotacao.Value =
                *--             fBuscarCotacao( crSigClLcr.moedas, date() )
                THIS.this_nCotacao = fBuscarCotacao(THIS.this_cMoeda, DATE(), gnConnHandle)

                loc_lSucesso = .T.
            ENDIF

            IF USED(THIS.this_cCursorLimiteConta)
                USE IN (THIS.this_cCursorLimiteConta)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_lFalhaConexao = .T.
            THIS.this_cMensagemErro = "Erro ao carregar limite de cr" + CHR(233) + "dito:" + ;
                CHR(13) + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarMovimentosPendentes - popula cursor_4c_Operacoes (DbOpera do
    * legado - a GRADE da tela) com o total, por operacao em aberto, convertido
    * para a moeda do limite de credito.
    *
    * Legado (sequencia completa):
    *   1) Select * From SigOpPed -> LocalOpePd (Sqlexecute < 1 = falha)
    *   2) Reccount('LocalOpePd') > 0 ->
    *      a) Union all SigMvCab+SigOpPed pelos dois lados da conta -> CrTprMvCab
    *      b) CrConserto2 = EmpDopNums dos registros de CrTprMvCab cujo Dopes
    *         bate em LocalOpePd nas condicoes Tpagos/ChkPagos e Tutils/Utilizados
    *      c) Para cada EmpDopNums de CrConserto2: soma os itens do movimento
    *         por moeda (SigMvItn) e converte para this_cMoeda, acumulando em DbOpera
    *
    * (b) eh SCAN+LOCATE, nao SELECT declarativo: ChkPagos vem de coluna BIT,
    * e um IIF/OR dentro de um SELECT avalia os dois lados da expressao - se o
    * driver entregar Numerico em vez de Logico, estoura "Operator/operand
    * type mismatch". THIS.BitParaLogico() normaliza ANTES da comparacao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarMovimentosPendentes()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        LOCAL loc_cDopes, loc_lChkPagos, loc_nUtilizados, loc_cEmpDopNums
        LOCAL loc_nTpagos, loc_nTutils, loc_lCondPagos, loc_lCondUtils, loc_lIncluir
        LOCAL loc_cDopesItem, loc_nTotaOrigem, loc_cMoedaOrigem, loc_nConv

        loc_lSucesso = .F.

        TRY
            *-- cursor_4c_Operacoes (DbOpera legado) - estrutura fixa (regra
            *-- #42): a ordem das colunas tem de ser identica em todo lugar
            *-- que recriar o cursor, e a Grade da Lista usa estes nomes.
            IF !USED(THIS.this_cCursorOperacoes)
                CREATE CURSOR (THIS.this_cCursorOperacoes) (dopes C(20), totas N(12,2))
            ELSE
                SELECT (THIS.this_cCursorOperacoes)
                ZAP
            ENDIF
            SELECT (THIS.this_cCursorOperacoes)
            INDEX ON dopes TAG dopes

            *-- SigOpPed - operacoes configuradas a considerar (LocalOpePd legado)
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
                *-- (Debito e Credito) - colunas EXPLICITAS, exigido em UNION ALL
                loc_cSQL = "SELECT a.Dopes, a.EmpDopNums, a.ChkPagos, a.ChkSubn, a.Utilizados " + ;
                    "FROM SigMvCab a, SigOpPed b " + ;
                    "WHERE a.ContaDs = " + EscaparSQL(THIS.this_cConta) + ;
                    " AND a.Dopes = b.Dopes " + ;
                    "UNION ALL " + ;
                    "SELECT a.Dopes, a.EmpDopNums, a.ChkPagos, a.ChkSubn, a.Utilizados " + ;
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
                    *-- CrConserto2 do legado: EmpDopNums dos movimentos que
                    *-- casam nas condicoes Tpagos/ChkPagos e Tutils/Utilizados
                    IF USED(THIS.this_cCursorMovFiltrado)
                        USE IN (THIS.this_cCursorMovFiltrado)
                    ENDIF
                    CREATE CURSOR (THIS.this_cCursorMovFiltrado) (empdopnums C(29))

                    SELECT (THIS.this_cCursorMovCabecalho)
                    SCAN
                        loc_cDopes      = Dopes
                        loc_lChkPagos   = THIS.BitParaLogico(ChkPagos)
                        loc_nUtilizados = TratarNulo(Utilizados, 0)
                        loc_cEmpDopNums = EmpDopNums
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
                            REPLACE empdopnums WITH loc_cEmpDopNums
                        ENDIF

                        SELECT (THIS.this_cCursorMovCabecalho)
                    ENDSCAN

                    *-- lCredEesti do legado: por EmpDopNums filtrado, soma o
                    *-- total dos itens por moeda e converte para this_cMoeda
                    SELECT (THIS.this_cCursorMovFiltrado)
                    SCAN
                        loc_cEmpDopNums = empdopnums

                        loc_cSQL = "SELECT Dopes, Moedas, " + ;
                            "SUM((Qtds - QtBaixas) * (Units + ValRats)) AS Totas " + ;
                            "FROM SigMvItn " + ;
                            "WHERE EmpDopNums = " + EscaparSQL(loc_cEmpDopNums) + ;
                            " GROUP BY Dopes, Moedas"

                        IF SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorItensMov) > 0
                            SELECT (THIS.this_cCursorItensMov)
                            SCAN
                                loc_cDopesItem   = Dopes
                                loc_nTotaOrigem  = TratarNulo(Totas, 0)
                                loc_cMoedaOrigem = TratarNulo(Moedas, "")

                                SELECT (THIS.this_cCursorOperacoes)
                                IF !SEEK(loc_cDopesItem, THIS.this_cCursorOperacoes, "dopes")
                                    APPEND BLANK
                                    REPLACE dopes WITH loc_cDopesItem
                                ENDIF

                                loc_nConv = ROUND(loc_nTotaOrigem * ;
                                    fBuscarCotacao(loc_cMoedaOrigem, DATE()) / ;
                                    fBuscarCotacao(THIS.this_cMoeda, DATE()), 2)
                                REPLACE totas WITH totas + loc_nConv

                                SELECT (THIS.this_cCursorItensMov)
                            ENDSCAN
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
    *   If Sqlexecute(lcSql,'CrTmpCli') < 1 -> MessageBox + Return(.F.)
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
                THIS.this_cRazaoCliente = TratarNulo(RClis, "")
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
    *   CursorQuery('SigMvSlc','CrTmpSccr',@LaCampo)  -- Grupos=_Grupo, Contas=_Conta
    *   Scan: _Saldocc += Round(Saldos * cotacao(moedas)/cotacao(crSigClLcr.moedas),2)
    * Sem guarda de falha no legado: zero linha eh estado valido (conta sem
    * movimento de C/C) e nao interrompe o calculo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CalcularSaldoContaCorrente()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nConv

        loc_lSucesso = .F.
        THIS.this_nSaldoContaCorrente = 0

        TRY
            loc_cSQL = "SELECT Moedas, Saldos FROM SigMvSlc " + ;
                "WHERE Grupos = " + EscaparSQL(THIS.this_cGrupo) + ;
                " AND Contas = " + EscaparSQL(THIS.this_cConta)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorSaldoConta)

            IF loc_nResultado < 0
                THIS.this_lFalhaConexao = .T.
                THIS.this_cMensagemErro = "Erro ao calcular saldo de conta corrente."
                MsgErro(THIS.this_cMensagemErro, "Erro")
            ELSE
                IF loc_nResultado > 0
                    SELECT (THIS.this_cCursorSaldoConta)
                    SCAN
                        loc_nConv = ROUND(TratarNulo(Saldos, 0) * ;
                            fBuscarCotacao(Moedas, DATE()) / ;
                            fBuscarCotacao(THIS.this_cMoeda, DATE()), 2)
                        THIS.this_nSaldoContaCorrente = THIS.this_nSaldoContaCorrente + loc_nConv
                    ENDSCAN
                ENDIF
                loc_lSucesso = .T.
            ENDIF

            IF USED(THIS.this_cCursorSaldoConta)
                USE IN (THIS.this_cCursorSaldoConta)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao calcular saldo de conta corrente:" + ;
                CHR(13) + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CalcularCheques - legado:
    *   lcQuery = cheques em aberto (SigCqChm+SigChe+SigCdOpt, tipos='DB') -> Cheques
    *   If Sqlexecute(lcQuery,'Cheques') < 1 -> MessageBox + Return .f.
    *   Scan Cheques:
    *       If IsEmpty(fpags)
    *           _chequep = _chequec + valors   && transcrito LITERAL - ver nota abaixo
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
                        *-- Transcrito LITERALMENTE do legado (regra CLAUDE.md
                        *-- #17 - formula de calculo eh regra de negocio, nao se
                        *-- reescreve): a linha original soma ao acumulador de
                        *-- CHEQUES (os que nao ficam em aberto) mas atribui ao acumulador oposto.
                        *-- Preservado mesmo parecendo invertido.
                        loc_nChequeP = loc_nChequeC + loc_nValors
                    ELSE
                        loc_cSQL = "SELECT ValPends FROM SigOpFp WHERE Fpags = " + ;
                            EscaparSQL(loc_cFpags)

                        IF SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorFormaPagto) > 0
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
    * Sem guarda de falha no legado: zero linha so zera GerGdmis e segue.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarTipoOperacao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Codigos, GerGdmis FROM SigCdTom " + ;
                "WHERE Codigos = " + FormatarNumeroSQL(THIS.this_nTipoOps, 0)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorTipoOperacao)

            IF loc_nResultado < 0
                THIS.this_lFalhaConexao = .T.
                THIS.this_cMensagemErro = "Erro ao carregar tipo de opera" + CHR(231) + CHR(227) + "o."
                MsgErro(THIS.this_cMensagemErro, "Erro")
            ELSE
                IF loc_nResultado > 0 AND RECCOUNT(THIS.this_cCursorTipoOperacao) > 0
                    SELECT (THIS.this_cCursorTipoOperacao)
                    THIS.this_nGerGdmis = TratarNulo(GerGdmis, 0)
                ELSE
                    THIS.this_nGerGdmis = 0
                ENDIF
                loc_lSucesso = .T.
            ENDIF

            IF USED(THIS.this_cCursorTipoOperacao)
                USE IN (THIS.this_cCursorTipoOperacao)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar tipo de opera" + CHR(231) + CHR(227) + "o:" + ;
                CHR(13) + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametrosSistema - cursor crSigCdPam do legado (SigCdPam eh
    * tabela de UMA linha - parametros gerais). Sem guarda de falha no
    * legado: zero linha so zera os parametros e segue.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarParametrosSistema()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT OpPends, ChqlCreds FROM SigCdPam"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorParametros)

            IF loc_nResultado < 0
                THIS.this_lFalhaConexao = .T.
                THIS.this_cMensagemErro = "Erro ao carregar parametros do sistema."
                MsgErro(THIS.this_cMensagemErro, "Erro")
            ELSE
                IF loc_nResultado > 0 AND RECCOUNT(THIS.this_cCursorParametros) > 0
                    SELECT (THIS.this_cCursorParametros)
                    THIS.this_nOpPendsParam     = TratarNulo(OpPends, 0)
                    THIS.this_lChqLimiteCredito = THIS.BitParaLogico(ChqlCreds)
                ELSE
                    THIS.this_nOpPendsParam     = 0
                    THIS.this_lChqLimiteCredito = .F.
                ENDIF
                loc_lSucesso = .T.
            ENDIF

            IF USED(THIS.this_cCursorParametros)
                USE IN (THIS.this_cCursorParametros)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar parametros do sistema:" + ;
                CHR(13) + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CalcularPendencias - legado:
    *   _Pendente = Round(TprMvCab.valos / cotacao(crSigClLcr.moedas), 2)
    *   _PendOutr = 0
    *   lcQuery = Soma por Dopes/Moedas de SigMvCab+SigMvItn+SigCdOpe, no lado
    *             <mgrupo>/<mconta>, excluindo a chave desta movimentacao
    *             (EmpDopNums <> _chvLCred), filtrado por c.Tipoops=OpPends -> Pendencia
    *   If Sqlexecute(lcQuery,'Pendencia') < 1 -> MessageBox + Return .f.
    *   Scan Pendencia: _PendOutr += Round(totas * cotacao(moedas)/cotacao(crSigClLcr.moedas),2)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CalcularPendencias()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nConv

        loc_lSucesso = .F.

        TRY
            THIS.this_nPendente = ROUND(THIS.this_nValorMovimento / ;
                fBuscarCotacao(THIS.this_cMoeda, DATE()), 2)
            THIS.this_nPendenteOutros = 0

            loc_cSQL = "SELECT SUM((b.Qtds - b.QtBaixas) * b.Units) AS Totas, b.Moedas, a.Dopes " + ;
                "FROM SigMvCab a, SigMvItn b, SigCdOpe c " + ;
                "WHERE " + THIS.this_cCampoGrupoSQL + " = " + EscaparSQL(THIS.this_cGrupo) + ;
                " AND " + THIS.this_cCampoContaSQL + " = " + EscaparSQL(THIS.this_cConta) + ;
                " AND a.EmpDopNums <> " + EscaparSQL(THIS.this_cChaveLimiteCredito) + ;
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
            THIS.this_nSaldoContaCorrente - loc_nAbateCheques
    ENDPROC

    *--------------------------------------------------------------------------
    * BitParaLogico - Normaliza coluna BIT do SQL Server para Logico. O driver
    * entrega ora Logico (.T./.F.) ora Numerico (0/1) conforme o ponto da
    * query - testar o VARTYPE numa VARIAVEL LOCAL, nunca dentro de IIF/OR
    * no meio de um SELECT (os dois lados da expressao sempre avaliam, e o
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
    * ObterChavePrimaria - Dopes da operacao (SigCdOpe). Este BO eh somente-
    * leitura (ver cabecalho do arquivo) e RegistrarAuditoria/Inserir/
    * Atualizar/ExecutarExclusao nunca rodam aqui - sobrescrito so pela
    * convencao do projeto (CLAUDE.md - Audit System).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cDopes
    ENDPROC

ENDDEFINE
