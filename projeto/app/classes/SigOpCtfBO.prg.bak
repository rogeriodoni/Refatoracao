*============================================================================
* SigOpCtfBO.prg - Business Object para Cancelamento de SiTef
*
* Tabela de referencia : SigCdEmp (PK: cemps char(3))
* Form OPERACIONAL     : FormSigOpCtf - cancelamento de transacao TEF
*                        (comunicacao com CliSiTef32I.DLL via protocolo
*                        interativo SiTef; formatos IntPos.001/IntPos.STS)
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigOpCtfBO AS BusinessBase

    *==========================================================================
    * Propriedades da entidade SigCdEmp (dados da empresa usados na integracao
    * com o SiTef - endereco do terminal e identificacao da empresa)
    *==========================================================================
    this_cCodEmpresa      = ""    && char(3)  - SigCdEmp.cemps (PK)
    this_nCodEmpresaNum   = 0     && numeric(3,0) - SigCdEmp.nemps
    this_cRazaoSocial     = ""    && char(40) - SigCdEmp.razas
    this_cCodEmpresaSiTef = ""    && char(3)  - SigCdEmp.cempsitefs

    *==========================================================================
    * Propriedades da transacao de cancelamento (parametros recebidos pelo
    * form na abertura - par_cEndSiTef/par_cIdTerminal/... do Init legado)
    *==========================================================================
    this_cEndSiTef   = ""    && Endereco do servidor SiTef
    this_cIdTerminal = ""    && Codigo do estabelecimento/terminal
    this_nValorPago  = 0     && Valor da transacao a cancelar
    this_cTipoPgto   = ""    && "D"=Debito, "C"=Credito
    this_dDataTrans  = {}    && Data da transacao original
    this_cNsu        = ""    && NSU da transacao original
    this_cCartao     = ""    && "S" = exige digitacao da validade do cartao
    this_lImpressora = .F.   && .T. quando o caixa possui impressora fiscal
    this_cCodEstabs  = ""    && Codigo alternativo do estabelecimento (PDV)
    this_lCancelado  = .T.   && Espelha llCancel do legado (.T. = nao cancelado)

    *==========================================================================
    * Mensagem de retorno do protocolo SiTef (ultima falha reportada)
    *==========================================================================
    this_cMensagemSiTef = ""

    *==========================================================================
    * Estado do protocolo interativo (migrado das variaveis PUBLIC do legado:
    * ProximoComando, TipoCampo, TamanhoMinimo, TamanhoMaximo, Buffer,
    * lnContinua). Centralizado aqui porque ContinuarSiTef() precisa passar
    * os quatro primeiros POR REFERENCIA para a DLL, e VFP9 nao garante
    * passagem por referencia de property de objeto direto para DLL externa
    * (mesmo criterio de sigprdftBO.ContinuarSiTef).
    *==========================================================================
    this_nProximoComando = 0
    this_nTipoCampo      = 0
    this_nTamanhoMinimo  = 0
    this_nTamanhoMaximo  = 0
    this_cBuffer          = SPACE(2000)
    this_nContinua        = 0

    *==========================================================================
    * Identificacao do terminal SiTef (migrado do bloco de Init legado que
    * monta lsIdTerminal/lcIdTerminal a partir de SigCdEmp/SigFiMpF).
    *   this_cLojaSiTef          <- lsIdTerminal (2o arg de
    *                               ConfiguraIntSiTefInterativo - "lsLoja")
    *   this_cIdTerminalCompleto <- lcIdTerminal (3o arg - "lsTerminal")
    *   this_cCaixaSiTef         <- crSigFiMpF.Cncaixas (ver CarregarCaixaSiTef)
    *==========================================================================
    this_cLojaSiTef          = ""
    this_cIdTerminalCompleto = ""
    this_cCaixaSiTef         = ""

    *==========================================================================
    * Campos DIGITAVEIS do dialogo, transportados por
    * FormSigOpCtf.FormParaBO() / devolvidos por BOParaForm().
    *
    * O legado le This.Value DENTRO de cada LostFocus e monta o buffer ali
    * mesmo, repetindo a expressao quatro vezes:
    *     SENHA.LostFocus      Buffer = Alltrim(this.Value) + Replicate(Chr(0), 2000 - Len(Alltrim(this.Value)))
    *     GetDigitos.LostFocus Buffer = ALLTRIM(This.Value) + REPLICATE(CHR(0), 1996)
    *     GetCartao.LostFocus  Buffer = ALLTRIM(This.Value) + REPLICATE(CHR(0), 2000-LEN(ALLTRIM(This.Value)))
    *     GetCodSeg.LostFocus  Buffer = Alltrim(This.Value) + REPLICATE(CHR(0), 2000-LEN(Alltrim(This.Value)))
    *
    * Guardar o valor digitado aqui NAO acrescenta uma 2a via de transporte:
    * ele continua tendo UM caminho (campo -> BO -> this_cBuffer -> DLL), com
    * a diferenca de que a montagem do buffer passa a existir num lugar so
    * (MontarBufferSiTef) em vez de quatro copias da mesma expressao.
    *==========================================================================
    this_cSenhaSupervisor = ""   && SENHA.Value      - senha do supervisor
    this_cUltimosDigitos  = ""   && GetDigitos.Value - 4 ultimos digitos / validade
    this_cNumeroCartao    = ""   && GetCartao.Value  - numero do cartao
    this_cCodSeguranca    = ""   && GetCodSeg.Value  - codigo de seguranca

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdEmp"
            THIS.this_cCampoChave = "cemps"
            THIS.DeclararFuncoesSiTef()
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * DeclararFuncoesSiTef - DECLARE-DLL das 3 funcoes do protocolo interativo
    * (migrado de SIGOPCTF.Load - este form NAO declara
    * FinalizaTransacaoSiTefInterativo, ao contrario de SIGPRDFT/SIGPRTFH:
    * cancelamento nunca finaliza uma venda, so desfaz). Redeclarar a mesma
    * assinatura eh inofensivo em VFP9; a falha real (DLL ausente) so
    * aparece quando a funcao eh CHAMADA, nao na declaracao - por isso o TRY
    * aqui eh so para nao derrubar InicializarForm em maquina sem o
    * CliSiTef32I.DLL (mesmo criterio de sigprdftBO.DeclararFuncoesSiTef).
    *==========================================================================
    PROTECTED PROCEDURE DeclararFuncoesSiTef()
        LOCAL loc_oErro

        TRY
            DECLARE INTEGER ConfiguraIntSiTefInterativo IN "CliSiTef32I.DLL" ;
                STRING lsEndereco, STRING lsLoja, STRING lsTerminal, INTEGER lnReservado

            DECLARE INTEGER IniciaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                INTEGER lnModalidade, STRING lsValor, STRING lsCupom, STRING lsData, ;
                STRING lsHorario, STRING lsOperador, STRING lsRestricao

            DECLARE INTEGER ContinuaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                INTEGER @lnComando, INTEGER @lnTipo, INTEGER @lnMinimo, INTEGER @lnMaximo, ;
                STRING @lsBuffer, INTEGER lnTamanho, INTEGER lnResultado
        CATCH TO loc_oErro
            *-- DLL nao presente nesta maquina (dev/pipeline sem PIN-pad
            *-- SiTef) - a chamada real avisa o usuario via ConectarSiTef.
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarCaixaSiTef - Migrado do trecho do Init legado que le
    * crSigFiMpF.Cncaixas (cursor global do Framework, nunca populado em
    * nenhum ponto do dump deste form - mesma categoria de dependencia
    * ausente tratada em sigprdftBO.CarregarParametrosOperacao). Em vez de
    * depender de cursor global nao documentado, consulta SIGFIMPF pela
    * empresa corrente com o MESMO fallback "melhor esforco" do sibling:
    * sem registro, this_cCaixaSiTef fica "000000" (igual ao TRANSFORM(VAL(
    * ""),"@L 999999") que o legado produziria com o cursor vazio).
    *==========================================================================
    FUNCTION CarregarCaixaSiTef()
        LOCAL loc_oErro

        THIS.this_cCaixaSiTef = "000000"

        TRY
            IF USED("cursor_4c_SigFiMpF")
                USE IN cursor_4c_SigFiMpF
            ENDIF

            SQLEXEC(gnConnHandle, ;
                "SELECT cncaixas FROM SIGFIMPF WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa), ;
                "cursor_4c_SigFiMpF")

            IF USED("cursor_4c_SigFiMpF") AND !EOF("cursor_4c_SigFiMpF")
                THIS.this_cCaixaSiTef = TRANSFORM(VAL(TratarNulo(cursor_4c_SigFiMpF.cncaixas, "0")), "@L 999999")
            ENDIF

            IF USED("cursor_4c_SigFiMpF")
                USE IN cursor_4c_SigFiMpF
            ENDIF
        CATCH TO loc_oErro
            *-- Sem a tabela/registro, segue com o fallback "000000" acima -
            *-- mesmo desfecho pratico do legado quando crSigFiMpF esta vazio.
        ENDTRY

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * MontarIdentificacaoTerminal - Migrado de SIGOPCTF.Init:
    *     If Empty(pcCodEstabs)
    *         lsIdTerminal="00000"+_Empr
    *     Else
    *         lsIdTerminal=pcCodEstabs
    *     EndIf
    *     lcIdTerminal=fConverteStr(CrSigCdEmp.nEmps)+TRANSFORM(VAL(
    *         crSigFiMpF.Cncaixas),"@L 999999")
    *
    * _Empr e o global LEGACY -> go_4c_Sistema.cCodEmpresa (CLAUDE.md:
    * "_EMPR: NEVER use"). nEmps vem de CarregarPorCodigo (this_nCodEmpresaNum);
    * Cncaixas ja foi resolvido e formatado em CarregarCaixaSiTef
    * (this_cCaixaSiTef), entao aqui so concatena - sem repetir o TRANSFORM.
    *==========================================================================
    PROCEDURE MontarIdentificacaoTerminal(par_cCodEstabs)
        IF VARTYPE(par_cCodEstabs) = "C" AND !EMPTY(par_cCodEstabs)
            THIS.this_cLojaSiTef = par_cCodEstabs
        ELSE
            THIS.this_cLojaSiTef = "00000" + ALLTRIM(go_4c_Sistema.cCodEmpresa)
        ENDIF

        THIS.this_cIdTerminalCompleto = fConvertestr(THIS.this_nCodEmpresaNum) + THIS.this_cCaixaSiTef
    ENDPROC

    *==========================================================================
    * ConectarSiTef - Migrado de SIGOPCTF.Init:
    *     IF ConfiguraIntSiTefInterativo(lsEndSitef,lsIdTerminal,lcIdTerminal,0) <> 0
    * Retorna .T. se a comunicacao com o servidor SiTef foi estabelecida.
    *==========================================================================
    FUNCTION ConectarSiTef()
        LOCAL loc_nRetorno

        loc_nRetorno = ConfiguraIntSiTefInterativo(ALLTRIM(THIS.this_cEndSiTef), ;
            THIS.this_cLojaSiTef, THIS.this_cIdTerminalCompleto, 0)

        RETURN (loc_nRetorno = 0)
    ENDFUNC

    *==========================================================================
    * IniciarSiTef - Migrado de SIGOPCTF.Init:
    *     IF IniciaFuncaoSiTefInterativo(200, lcValPago, "1", lcData, lcHora,
    *         TRANSFORM(VAL(IdTerminal),"@L 999"), "") <> 10000
    *
    * Modalidade (200) e Cupom ("1") sao LITERAIS no legado - nao existe
    * property de cupom em SIGOPCTF (diferente de SIGPRDFT/SIGPRTFH), por
    * isso ficam fixos aqui, nao parametrizados. IdTerminal (6o argumento,
    * "lsOperador") e o PARAMETRO CRU recebido no Init do form (par_cIdTerminal
    * -> this_cIdTerminal), NAO o lsIdTerminal/lcIdTerminal computados acima -
    * dois campos homonimos no legado com fontes diferentes, transcritos tal
    * como estao.
    *==========================================================================
    FUNCTION IniciarSiTef(par_cValor, par_cData, par_cHora)
        LOCAL loc_nRetorno

        loc_nRetorno = IniciaFuncaoSiTefInterativo(200, par_cValor, "1", par_cData, ;
            par_cHora, TRANSFORM(VAL(THIS.this_cIdTerminal), "@L 999"), "")

        RETURN (loc_nRetorno = 10000)
    ENDFUNC

    *==========================================================================
    * ContinuarSiTef - Migrado das chamadas ContinuaFuncaoSiTefInterativo
    * espalhadas pelo legado (SENHA/GetDigitos/GetCartao/GetCodSeg GotFocus/
    * LostFocus, SAIDA.CANCELA.Click). Centraliza a chamada por referencia
    * (LOCAL -> DLL -> THIS.this_n*/this_cBuffer) - mesmo criterio de
    * sigprdftBO.ContinuarSiTef.
    *==========================================================================
    FUNCTION ContinuarSiTef(par_nContinua)
        LOCAL loc_nProximoComando, loc_nTipoCampo, loc_nTamanhoMinimo, ;
              loc_nTamanhoMaximo, loc_cBuffer, loc_nRetorno

        loc_nProximoComando = THIS.this_nProximoComando
        loc_nTipoCampo      = THIS.this_nTipoCampo
        loc_nTamanhoMinimo  = THIS.this_nTamanhoMinimo
        loc_nTamanhoMaximo  = THIS.this_nTamanhoMaximo
        loc_cBuffer         = IIF(EMPTY(THIS.this_cBuffer), SPACE(2000), THIS.this_cBuffer)

        loc_nRetorno = ContinuaFuncaoSiTefInterativo(@loc_nProximoComando, @loc_nTipoCampo, ;
            @loc_nTamanhoMinimo, @loc_nTamanhoMaximo, @loc_cBuffer, LEN(loc_cBuffer), par_nContinua)

        THIS.this_nProximoComando = loc_nProximoComando
        THIS.this_nTipoCampo      = loc_nTipoCampo
        THIS.this_nTamanhoMinimo  = loc_nTamanhoMinimo
        THIS.this_nTamanhoMaximo  = loc_nTamanhoMaximo
        THIS.this_cBuffer         = loc_cBuffer

        RETURN loc_nRetorno
    ENDFUNC

    *==========================================================================
    * MontarBufferSiTef - carrega this_cBuffer com o valor digitado pelo
    * usuario, completado com CHR(0) ate o tamanho que
    * ContinuaFuncaoSiTefInterativo espera.
    *
    * Transcrito do legado, que repete a MESMA expressao em cada LostFocus
    * (ver o bloco de properties this_cSenhaSupervisor..this_cCodSeguranca).
    * par_nComplemento existe para preservar a segunda forma, LITERAL, do
    * GetDigitos.LostFocus - "REPLICATE(CHR(0), 1996)" - em vez de recalcular
    * 2000 - LEN(): 1996 = 2000 - 4 porque GetDigitos.Valid so aceita 4
    * caracteres, entao as duas formas coincidem no caminho normal, mas
    * transcrever a do legado evita divergir se o campo chegar com outro
    * tamanho (regra CLAUDE.md #17 - transcrever, nunca reescrever).
    * Omitido, usa 2000 - LEN(ALLTRIM(valor)), como nos outros tres campos.
    *==========================================================================
    FUNCTION MontarBufferSiTef(par_cValor, par_nComplemento)
        LOCAL loc_cValor, loc_nComplemento

        loc_cValor = IIF(VARTYPE(par_cValor) = "C", ALLTRIM(par_cValor), ;
            ALLTRIM(TRANSFORM(par_cValor)))

        IF VARTYPE(par_nComplemento) = "N" AND par_nComplemento > 0
            loc_nComplemento = par_nComplemento
        ELSE
            loc_nComplemento = 2000 - LEN(loc_cValor)
        ENDIF

        IF loc_nComplemento < 0
            loc_nComplemento = 0
        ENDIF

        THIS.this_cBuffer = loc_cValor + REPLICATE(CHR(0), loc_nComplemento)

        RETURN THIS.this_cBuffer
    ENDFUNC

    *==========================================================================
    * NOTA DE ARQUITETURA - SOMENTE LEITURA (SigCdEmp)
    *
    * O dump do legado (tasks\task716\SigOpCtf_form_codigo_fonte.txt) faz UMA
    * UNICA operacao de banco, dentro do Init:
    *
    *     .poDatamgr = CreateObject('fSqlConector', ThisForm.Name)
    *     .AddCursor('SigCdEmp','cEmps','crSigCdEmp','cEmps',.f.,
    *         [Select * From SigCdEmp Where cEmps = ?_Empr])
    *     .Requery('crSigCdEmp')
    *     lsEmp = fConverteStr(CrSigCdEmp.nEmps)
    *
    * Um SELECT, usado so para obter o numero da empresa (nEmps) e montar o
    * IdTerminal exigido pelo protocolo SiTef (ConfiguraIntSiTefInterativo).
    * Em NENHUM metodo do dump - Init, Load, Unload, MontaRetorno,
    * RetornoFalha, nem nos handlers de GetValor/Text2/GetDigitos/SENHA/
    * GetCartao/GetCodSeg - ha INSERT, UPDATE, DELETE ou TABLEUPDATE sobre
    * SigCdEmp. A tela cancela uma transacao de cartao via DLL
    * (CliSiTef32I.DLL) e grava arquivos LOCAIS (C:\client\Resp\IntPos.001 e
    * IntPos.STS), nunca grava no banco de dados.
    *
    * Por isso:
    *   - Inserir(), Atualizar() e ExecutarExclusao() NAO sao sobrescritos
    *     aqui - o comportamento herdado de BusinessBase (recusar a operacao
    *     e deixar o motivo em this_cMensagemErro, reportado pelo
    *     ExibirFalha de Salvar()/Excluir()) ja eh o correto. Sobrescrever
    *     exigiria inventar uma lista de colunas de gravacao que o legado
    *     nunca grava, o que a regra #22 do CLAUDE.md proibe;
    *   - RegistrarAuditoria() tambem fica herdado e nunca eh chamado por
    *     este BO: sem Inserir()/Atualizar() proprios nao ha operacao de
    *     escrita para auditar, e forcar uma linha em LogAuditoria aqui
    *     registraria uma gravacao que nunca aconteceu;
    *   - CarregarPorCodigo() e CarregarDoCursor() SAO implementados abaixo,
    *     porque reproduzem fielmente a UNICA leitura que o legado faz.
    *==========================================================================

    *==========================================================================
    * CarregarPorCodigo - Carrega os dados da empresa (SigCdEmp) usados na
    * montagem do protocolo SiTef, pelo codigo informado (cemps).
    *
    * Legado (Init): AddCursor('SigCdEmp','cEmps','crSigCdEmp','cEmps',.f.,
    * [Select * From SigCdEmp Where cEmps = ?_Empr]) + Requery('crSigCdEmp').
    *
    * par_cCodEmpresa: codigo da empresa (SigCdEmp.cemps). Quando omitido ou
    * vazio, usa go_4c_Sistema.cCodEmpresa - equivalente ao _Empr do legado
    * (CLAUDE.md: "_EMPR: LEGACY - NEVER use -> go_4c_Sistema.cCodEmpresa").
    *
    * Retorno: .T. se encontrou e carregou o registro, .F. caso contrario
    * (this_cMensagemErro fica preenchido com o motivo).
    *==========================================================================
    FUNCTION CarregarPorCodigo(par_cCodEmpresa)
        LOCAL loc_cCodigo, loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF VARTYPE(par_cCodEmpresa) = "C" AND !EMPTY(ALLTRIM(par_cCodEmpresa))
                loc_cCodigo = ALLTRIM(par_cCodEmpresa)
            ELSE
                loc_cCodigo = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            ENDIF

            IF EMPTY(loc_cCodigo)
                THIS.this_cMensagemErro = "C" + CHR(243) + "digo de empresa n" + CHR(227) + "o informado."
            ELSE
                loc_cSQL = "SELECT cemps, nemps, razas, cempsitefs" + ;
                           " FROM SigCdEmp" + ;
                           " WHERE cemps = " + EscaparSQL(loc_cCodigo)

                IF USED("cursor_4c_Empresa")
                    IF CURSORGETPROP("Buffering", "cursor_4c_Empresa") > 1
                        TABLEREVERT(.T., "cursor_4c_Empresa")
                    ENDIF
                    USE IN cursor_4c_Empresa
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Empresa")

                IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Empresa") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Empresa")
                ELSE
                    THIS.this_cMensagemErro = "Empresa " + loc_cCodigo + " n" + CHR(227) + ;
                        "o encontrada em SigCdEmp." + CHR(13) + CapturarErroSQL()
                ENDIF

                IF USED("cursor_4c_Empresa")
                    USE IN cursor_4c_Empresa
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro em SigOpCtfBO.CarregarPorCodigo: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Popula this_cCodEmpresa/this_nCodEmpresaNum/
    * this_cRazaoSocial/this_cCodEmpresaSiTef a partir do cursor aberto por
    * CarregarPorCodigo.
    *
    * SELECT (par_cAliasCursor) antes de acessar os campos - NUNCA
    * "campo" (FORMCOR_LICOES_APRENDIDAS.md, Problema 9: essa
    * sintaxe nao existe em VFP9 e estoura "Function name is missing )").
    *
    * PROTECTED: so eh usado internamente por CarregarPorCodigo. O ponto de
    * entrada PUBLIC para o Form eh CarregarPorCodigo (regra #51 do
    * CLAUDE.md - metodo chamado de fora nunca pode ser PROTECTED).
    *==========================================================================
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodEmpresa      = TratarNulo(cemps, "")
            THIS.this_nCodEmpresaNum   = TratarNulo(nemps, 0)
            THIS.this_cRazaoSocial     = TratarNulo(razas, "")
            THIS.this_cCodEmpresaSiTef = TratarNulo(cempsitefs, "")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ObterChavePrimaria - Chave da entidade de referencia (SigCdEmp.cemps),
    * usada so se algum dia RegistrarAuditoria() for acionado por uma
    * subclasse futura. PROTECTED: nunca chamado de fora (regra #51).
    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodEmpresa
    ENDFUNC

ENDDEFINE
