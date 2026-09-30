*==============================================================================
* SIGPRDFTBO.PRG
* Business Object - Integracao com terminal SiTef (pagamento em cartao de debito)
* Origem: SIGPRDFT.scx (form legado, sem tabela propria - integracao com DLL SiTef)
*==============================================================================

DEFINE CLASS sigprdftBO AS BusinessBase

    *-- Parametros de entrada recebidos do form/tela chamadora (Init original)
    this_cEndSiTef = ""             && Endereco do servidor SiTef (EndSiTef)
    this_nValPago = 0               && Valor a ser pago na transacao (ValPago)
    this_cCupom = ""                && Numero do cupom fiscal (Cupom)
    this_cCaixa = ""                && Identificacao do caixa/PDV (Caixa)
    this_cDebCred = ""              && Indicador Debito/Credito (DebCred)
    this_cTipPagto = ""             && Tipo de pagamento (TipPagto)
    this_nNumParcs = 0              && Numero de parcelas informado na chamada (NumParcs)
    this_cIdent = ""                && Identificador da transacao (lcIdent)
    this_cOpers = ""                && Operador responsavel (pcOpers)

    *-- Campos digitados na tela (mapeados dos controles GetValor/GetDigitos/GetCartao/etc)
    this_nValor = 0                 && GetValor.Value - valor da transacao
    this_cDigitos = ""              && GetDigitos.Value - 4 ultimos digitos do cartao
    this_cCartao = ""               && GetCartao.Value - numero do cartao lido/digitado
    this_cBandeira = "00000"        && ThisForm.pcBandeira - bandeira do cartao
    this_nTipoVenda = 1             && Optiongroup1.Value - 1=A Vista, 2=Parcelado
    this_nParcelas = 0              && Text1.Value - numero de parcelas
    this_dDataParc = {}             && GetDatas.Value - data da 1a parcela/vencimento

    *-- Dados de retorno da transacao TEF (preenchidos apos comunicacao com o PIN-PAD)
    this_cTipoTransacao = ""        && lsTipTran - tipo de transacao retornado pelo SiTef
    this_cDataHoraTef = ""          && lsDataHora - data/hora da transacao no SiTef
    this_cCupomTef = ""             && lsCupom - cupom retornado pelo SiTef
    this_cCartaoTef = ""            && lsCartao - numero de cartao mascarado retornado
    this_cNsu = ""                  && lsNsu - Numero Sequencial Unico da transacao
    this_cAutorizacao = ""          && lsAutoriza - codigo de autorizacao
    this_cFinalizacao = ""          && lsFinaliza - codigo de finalizacao da transacao
    this_cMensagemRetorno = ""      && MenRet - mensagem de retorno do SiTef

    *-- Controle de fluxo/protocolo SiTef
    this_nProximoComando = 0        && ProximoComando - protocolo ContinuaFuncaoSiTefInterativo
    this_nTipoCampo = 0             && TipoCampo
    this_nTamanhoMinimo = 0         && TamanhoMinimo
    this_nTamanhoMaximo = 0         && TamanhoMaximo
    this_cBuffer = ""               && Buffer - buffer de comunicacao com o SiTef
    this_nContinua = 0              && lnContinua
    this_lCancela = .F.             && llCancela - indica cancelamento da operacao
    this_lAbandona = .F.            && ThisForm.abandona - indica abandono da tela
    this_lKeyEsc = .T.              && ThisForm.pckeyesc - habilita ESC para cancelar
    this_lTransacaoOk = .F.         && Indica se a transacao foi concluida com sucesso

    *-- Parametros consultados na operacao de pagamento (SigOpFp/sigcdemp/SIGFIMPF)
    this_lOpFpCartao = .F.          && SigOpFp.lcartao = "S" - forma aceita cartao
    this_lOpFpSaque = .F.           && SigOpFp.lsaque = "S" - permite saque
    this_cOpFpTcdc = "N"            && SigOpFp.tcdc - indica consulta CDC
    this_lOpFpGarantias = .F.       && SigOpFp.garantias = "S"
    this_nOpFpDias = 0              && SigOpFp.dias
    this_nOpFpMesFec = 0            && SigOpFp.mesfec
    this_cIdTerminal = ""           && Empresa+caixa enviado ao SiTef (ConfiguraInt*)

    *-- Estado auxiliar do protocolo (migrado de variaveis PUBLIC/PRIVATE do form legado)
    this_lDataConfirmada = .F.      && DCD - .T. apos ProximoComando=21 confirmar data
    this_cCartaoAux = ""            && ThisForm.lsCartao (legado) - Left(Buffer,5) em TipoCampo=131
    this_cValorSaque = "0,00"       && lcSaque - valor de saque (sub-dialogo SigCsTef nao portado)

    *--------------------------------------------------------------------------
    * INIT - Construtor
    * Este BO nao possui tabela propria: eh uma integracao com o terminal SiTef
    * (DLL CliSiTef32I.DLL), portanto this_cTabela/this_cCampoChave ficam vazios.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela = ""
        THIS.this_cCampoChave = ""

        THIS.DeclararFuncoesSiTef()

        RETURN .T.
    ENDPROC

    *==========================================================================
    * DeclararFuncoesSiTef - DECLARE-DLL das 4 funcoes do protocolo interativo
    * (migrado de SIGPRDFT.Load). Redeclarar a mesma assinatura eh inofensivo
    * em VFP9; a falha real (DLL ausente) so aparece quando a funcao eh
    * CHAMADA, nao na declaracao - por isso o TRY aqui eh so para nao derrubar
    * InicializarForm em maquina de desenvolvimento sem o CliSiTef32I.DLL.
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

            DECLARE INTEGER FinalizaTransacaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                INTEGER lnConfirma, STRING lsCupom, STRING lsData, STRING lsHorario
        CATCH TO loc_oErro
            *-- DLL nao presente nesta maquina (dev/teste sem PIN-pad SiTef) -
            *-- as chamadas reais avisam o usuario via ConectarSiTef/IniciarSiTef.
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarParametrosOperacao - Migrado de SIGPRDFT.Init (blocos
    * SqlExecute crSigOpFp/crSigCdEmp) + GotFocus (lcIdTerminal). Le a forma de
    * pagamento (SigOpFp) pelo codigo recebido em this_cOpers e monta o
    * identificador de terminal (empresa+caixa) usado por ConectarSiTef.
    *==========================================================================
    FUNCTION CarregarParametrosOperacao()
        LOCAL loc_lSucesso, loc_oErro, loc_nEmpresa

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_SigOpFp")
                USE IN cursor_4c_SigOpFp
            ENDIF
            SQLEXEC(gnConnHandle, ;
                "SELECT lcartao, lsaque, tcdc, garantias, dias, mesfec FROM SigOpFp " + ;
                "WHERE fpags = " + EscaparSQL(THIS.this_cOpers), ;
                "cursor_4c_SigOpFp")

            IF USED("cursor_4c_SigOpFp") AND !EOF("cursor_4c_SigOpFp")
                THIS.this_lOpFpCartao    = (TratarNulo(cursor_4c_SigOpFp.lcartao, "N") = "S")
                THIS.this_lOpFpSaque     = (TratarNulo(cursor_4c_SigOpFp.lsaque, "N") = "S")
                THIS.this_cOpFpTcdc      = TratarNulo(cursor_4c_SigOpFp.tcdc, "N")
                THIS.this_lOpFpGarantias = (TratarNulo(cursor_4c_SigOpFp.garantias, "N") = "S")
                THIS.this_nOpFpDias      = TratarNulo(cursor_4c_SigOpFp.dias, 0)
                THIS.this_nOpFpMesFec    = TratarNulo(cursor_4c_SigOpFp.mesfec, 0)
                loc_lSucesso = .T.
            ENDIF
            IF USED("cursor_4c_SigOpFp")
                USE IN cursor_4c_SigOpFp
            ENDIF

            IF loc_lSucesso
                *-- sigcdemp.codemps (numeric) equivale ao SigCdEmp.nEmps legado;
                *-- sigcdemp.cemps (char) eh a chave usada no filtro por empresa.
                IF USED("cursor_4c_SigCdEmpTef")
                    USE IN cursor_4c_SigCdEmpTef
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT codemps FROM sigcdemp WHERE cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa), ;
                    "cursor_4c_SigCdEmpTef")

                loc_nEmpresa = 0
                IF USED("cursor_4c_SigCdEmpTef") AND !EOF("cursor_4c_SigCdEmpTef")
                    loc_nEmpresa = TratarNulo(cursor_4c_SigCdEmpTef.codemps, 0)
                ENDIF
                IF USED("cursor_4c_SigCdEmpTef")
                    USE IN cursor_4c_SigCdEmpTef
                ENDIF

                *-- SIGFIMPF.cncaixas (caixa/PDV corrente) - SigFiMpF legado nao
                *-- tem equivalente de "caixa aberto" nesta migracao; melhor
                *-- esforco: 1o registro da empresa. Sem match, terminal fecha
                *-- com "000000" (mesmo fallback do legado quando nao localizado).
                IF USED("cursor_4c_SIGFIMPF")
                    USE IN cursor_4c_SIGFIMPF
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT cncaixas FROM SIGFIMPF WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa), ;
                    "cursor_4c_SIGFIMPF")

                IF USED("cursor_4c_SIGFIMPF") AND !EOF("cursor_4c_SIGFIMPF")
                    THIS.this_cIdTerminal = PADL(ALLTRIM(STR(loc_nEmpresa, 5)), 5, "0") + ;
                        TRANSFORM(VAL(TratarNulo(cursor_4c_SIGFIMPF.cncaixas, "0")), "@L 999999")
                ELSE
                    THIS.this_cIdTerminal = PADL(ALLTRIM(STR(loc_nEmpresa, 5)), 5, "0") + "000000"
                ENDIF
                IF USED("cursor_4c_SIGFIMPF")
                    USE IN cursor_4c_SIGFIMPF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao carregar parametros da operacao")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ConectarSiTef - Migrado de SIGPRDFT.GetDigitos.GotFocus (bloco
    * ConfiguraIntSiTefInterativo). Retorna .T. se a comunicacao com o
    * servidor SiTef foi estabelecida.
    *==========================================================================
    FUNCTION ConectarSiTef()
        LOCAL loc_nRetorno

        IF EMPTY(THIS.this_cIdTerminal)
            THIS.this_cIdTerminal = "00000000000"
        ENDIF

        loc_nRetorno = ConfiguraIntSiTefInterativo(ALLTRIM(THIS.this_cEndSiTef), ;
            THIS.this_cIdTerminal, THIS.this_cIdTerminal, 0)

        RETURN (loc_nRetorno = 0)
    ENDFUNC

    *==========================================================================
    * IniciarSiTef - Migrado de SIGPRDFT.GetDigitos.GotFocus (bloco
    * IniciaFuncaoSiTefInterativo). par_nModalidade=0 eh a unica modalidade
    * usada pelo legado (cartao de debito/credito).
    *==========================================================================
    FUNCTION IniciarSiTef(par_nModalidade, par_cValor, par_cCupom, par_cData, par_cHora)
        LOCAL loc_nRetorno

        loc_nRetorno = IniciaFuncaoSiTefInterativo(par_nModalidade, par_cValor, par_cCupom, ;
            par_cData, par_cHora, THIS.this_cCaixa, "")

        RETURN (loc_nRetorno = 10000)
    ENDFUNC

    *==========================================================================
    * ContinuarSiTef - Migrado das chamadas ContinuaFuncaoSiTefInterativo
    * espalhadas pelo legado (GetDigitos.Valid/GotFocus, GetDatas.Valid/
    * GotFocus, Text1.Valid, SAIDA.CANCELA.Click). Centraliza a chamada por
    * referencia (LOCAL -> DLL -> THIS.this_n*/this_cBuffer) porque VFP9 nao
    * garante passagem por referencia de property de objeto para DLL externa.
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
    * FinalizarSiTef - Migrado de SIGPRDFT.GetDatas.Valid (bloco
    * FinalizaTransacaoSiTefInterativo, disparado ao cancelar via senha de
    * supervisor - FormSIGPRSTF).
    *==========================================================================
    FUNCTION FinalizarSiTef(par_nConfirma, par_cCupom, par_cData, par_cHora)
        RETURN FinalizaTransacaoSiTefInterativo(par_nConfirma, par_cCupom, par_cData, par_cHora)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - SIGPRDFT nao tem cursor nem tabela propria. Os dados
    * digitados na tela (Valor, Digitos, Cartao, TipoVenda, Parcelas, Data)
    * sao atribuidos diretamente as properties this_n*/this_c*/this_d* pelo
    * proprio Form (FormParaBO/BOParaForm), e o retorno da transacao TEF
    * (Nsu/Autorizacao/Finalizacao/etc) vem do protocolo ContinuaFuncaoSiTef
    * Interativo via DLL, nao de um SELECT. Nao ha cursor de banco a
    * percorrer aqui - o comportamento padrao herdado de BusinessBase
    * (no-op, RETURN .T.) ja eh o correto.
    *==========================================================================

    *==========================================================================
    * ObterChavePrimaria - SIGPRDFT nao grava registro nenhum (integracao com
    * o terminal SiTef via CliSiTef32I.DLL - CREATE CURSOR crSiTef eh apenas
    * o buffer de instrucoes do protocolo TEF, nunca persistido no SQL
    * Server). Nao existe chave primaria porque nao existe tabela; retornar
    * vazio mantem RegistrarAuditoria() inofensivo (ela ja aborta quando a
    * chave vem vazia - ver BusinessBase.RegistrarAuditoria).
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *==========================================================================
    * Inserir/Atualizar/ExecutarExclusao: SIGPRDFT eh um dialogo de captura de
    * pagamento em cartao (SIGPRDFT.scx), sem AddCursor, sem tabela e sem SQL
    * de persistencia associados no legado (ver comportamento.json: as unicas
    * queries SQL sao INSERT INTO crSiTef, um cursor LOCAL de memoria usado
    * so para montar o buffer do protocolo ContinuaFuncaoSiTefInterativo, e
    * nunca chega a SQLEXEC/SQL Server). O comportamento padrao herdado de
    * BusinessBase (recusar a operacao) ja eh o correto - nao ha necessidade
    * de sobrescrever esses tres metodos aqui, e RegistrarAuditoria() nunca
    * roda porque Inserir/Atualizar/ExecutarExclusao nunca sao chamados.
    *==========================================================================

ENDDEFINE
