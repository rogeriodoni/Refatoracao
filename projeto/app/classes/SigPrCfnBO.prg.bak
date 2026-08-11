*******************************************************************************
* SigPrCfnBO.prg - Business Object: Calculo de Juros
* Herda de BusinessBase
* Form OPERACIONAL - sem tabela BD (calculo puro)
* Migrado de: SigPrCfn.SCX
*******************************************************************************

DEFINE CLASS SigPrCfnBO AS BusinessBase

    *-- Sem tabela BD: form de calculo puro
    this_cTabela     = ""
    this_cCampoChave = ""

    *-- Entradas do calculo
    this_nValorBase    = 0    && Valor Base (positivo)
    this_nTipoCalculo  = 1    && 1=Simples, 2=Composto
    this_nJurosMes     = 0    && Juros ao Mes (%)
    this_nJurosDia     = 0    && Juros ao Dia (%)
    this_dDataBase     = {}   && Data Base do calculo
    this_dDataFinal    = {}   && Data Final do calculo
    this_nDias         = 0    && Numero de dias entre DataBase e DataFinal
    this_nTipoDias     = 1    && 1=Corridos, 2=Uteis

    *-- Vencimentos (ate 10 parcelas)
    this_dVenc1        = {}
    this_dVenc2        = {}
    this_dVenc3        = {}
    this_dVenc4        = {}
    this_dVenc5        = {}
    this_dVenc6        = {}
    this_dVenc7        = {}
    this_dVenc8        = {}
    this_dVenc9        = {}
    this_dVenc10       = {}

    *-- Resultados do calculo
    this_nValorJuros   = 0    && Valor dos juros calculados
    this_nValorTotal   = 0    && Valor Total (Base + Juros)
    this_nValorParcela = 0    && Valor de cada parcela

    *---------------------------------------------------------------------------
    PROCEDURE Init()
    *---------------------------------------------------------------------------
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
        THIS.LimparPropriedades()
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE LimparPropriedades()
    *---------------------------------------------------------------------------
        THIS.this_nValorBase    = 0
        THIS.this_nTipoCalculo  = 1
        THIS.this_nJurosMes     = 0
        THIS.this_nJurosDia     = 0
        THIS.this_dDataBase     = {}
        THIS.this_dDataFinal    = {}
        THIS.this_nDias         = 0
        THIS.this_nTipoDias     = 1
        THIS.this_dVenc1        = {}
        THIS.this_dVenc2        = {}
        THIS.this_dVenc3        = {}
        THIS.this_dVenc4        = {}
        THIS.this_dVenc5        = {}
        THIS.this_dVenc6        = {}
        THIS.this_dVenc7        = {}
        THIS.this_dVenc8        = {}
        THIS.this_dVenc9        = {}
        THIS.this_dVenc10       = {}
        THIS.this_nValorJuros   = 0
        THIS.this_nValorTotal   = 0
        THIS.this_nValorParcela = 0
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
    *---------------------------------------------------------------------------
        RETURN ""
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
    *---------------------------------------------------------------------------
        IF THIS.this_nValorBase < 0
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *---------------------------------------------------------------------------
    * InicializarComParametros - Popula propriedades a partir dos parametros
    * recebidos pelo form (equivalente ao Init do legado com LPARAMETERS)
    *---------------------------------------------------------------------------
    PROCEDURE InicializarComParametros(par_nValor, par_nTipo, par_nJurosMes, par_nJurosDia, par_dDataBase, par_dDataFinal)
        THIS.LimparPropriedades()

        IF VARTYPE(par_nValor) = "N" AND par_nValor > 0
            THIS.this_nValorBase = par_nValor
        ENDIF

        IF VARTYPE(par_nTipo) = "N" AND INLIST(par_nTipo, 1, 2)
            THIS.this_nTipoCalculo = par_nTipo
        ELSE
            THIS.this_nTipoCalculo = 1
        ENDIF

        IF VARTYPE(par_nJurosMes) = "N" AND par_nJurosMes > 0
            THIS.this_nJurosMes = par_nJurosMes
            THIS.this_nJurosDia = THIS.CalcularJurosDia(par_nJurosMes)
        ELSE
            IF VARTYPE(par_nJurosDia) = "N" AND par_nJurosDia > 0
            THIS.this_nJurosDia = par_nJurosDia
            THIS.this_nJurosMes = THIS.CalcularJurosMes(par_nJurosDia)
            ENDIF
        ENDIF

        IF VARTYPE(par_dDataBase) = "D"
            THIS.this_dDataBase = par_dDataBase
        ENDIF

        IF VARTYPE(par_dDataFinal) = "D"
            THIS.this_dDataFinal = par_dDataFinal
        ELSE
            IF !EMPTY(THIS.this_dDataBase)
            THIS.this_dDataFinal = DATE()
            ENDIF
        ENDIF

        IF !EMPTY(THIS.this_dDataBase) AND !EMPTY(THIS.this_dDataFinal)
            THIS.this_nDias = THIS.this_dDataFinal - THIS.this_dDataBase
        ENDIF
    ENDPROC

    *---------------------------------------------------------------------------
    * Calcular - Logica central de calculo de juros (equivalente a calculos()
    * do legado). Usa propriedades this_* como entrada e atualiza os resultados.
    *---------------------------------------------------------------------------
    PROCEDURE Calcular()
        LOCAL loc_nJuros, loc_nParc, loc_nTotDia, loc_x, loc_dVenc, loc_nDia
        LOCAL ARRAY loc_aVenc[10]

        loc_nJuros  = 0
        loc_nParc   = 0
        loc_nTotDia = 0

        *-- Sem dados minimos: zerar resultados
        IF EMPTY(THIS.this_nValorBase)  OR ;
           EMPTY(THIS.this_nJurosMes)   OR ;
           EMPTY(THIS.this_nJurosDia)   OR ;
           EMPTY(THIS.this_dDataBase)   OR ;
           EMPTY(THIS.this_dDataFinal)  OR ;
           EMPTY(THIS.this_nDias)
            THIS.this_nValorJuros   = 0
            THIS.this_nValorTotal   = 0
            THIS.this_nValorParcela = 0
            RETURN .T.
        ENDIF

        *-- Calculo base (sem vencimentos)
        IF THIS.this_nTipoCalculo = 1
            *-- Juros Simples
            loc_nJuros = ROUND(THIS.this_nValorBase * ;
                               (THIS.this_nJurosMes / 100) * ;
                               (THIS.this_nDias / 30), 2)
        ELSE
            *-- Juros Compostos
            loc_nJuros = ROUND(THIS.this_nValorBase * ;
                               (((1 + THIS.this_nJurosDia / 100) ^ ;
                               THIS.this_nDias) - 1), 2)
        ENDIF

        *-- Iterar vencimentos (ate 10 parcelas)
        loc_aVenc[1]  = THIS.this_dVenc1
        loc_aVenc[2]  = THIS.this_dVenc2
        loc_aVenc[3]  = THIS.this_dVenc3
        loc_aVenc[4]  = THIS.this_dVenc4
        loc_aVenc[5]  = THIS.this_dVenc5
        loc_aVenc[6]  = THIS.this_dVenc6
        loc_aVenc[7]  = THIS.this_dVenc7
        loc_aVenc[8]  = THIS.this_dVenc8
        loc_aVenc[9]  = THIS.this_dVenc9
        loc_aVenc[10] = THIS.this_dVenc10

        FOR loc_x = 1 TO 10
            loc_dVenc = loc_aVenc[loc_x]
            IF !EMPTY(loc_dVenc)
                IF loc_nParc = 0
                    *-- Primeira parcela encontrada: zerar calculo base
                    loc_nJuros = 0
                ENDIF
                loc_nDia = loc_dVenc - THIS.this_dDataBase
                IF THIS.this_nTipoCalculo = 1
                    *-- Juros Simples por parcela
                    loc_nJuros = loc_nJuros + ROUND(THIS.this_nValorBase * ;
                                                    (THIS.this_nJurosMes / 100) * ;
                                                    (loc_nDia / 30), 2)
                ELSE
                    *-- Juros Compostos por parcela
                    loc_nJuros = loc_nJuros + ROUND(THIS.this_nValorBase * ;
                                                    (((1 + THIS.this_nJurosDia / 100) ^ ;
                                                    loc_nDia) - 1), 2)
                ENDIF
                loc_nTotDia = loc_nDia
                loc_nParc   = loc_nParc + 1
            ENDIF
        ENDFOR

        IF loc_nTotDia > 0
            THIS.this_nDias = loc_nTotDia
        ENDIF

        THIS.this_nValorJuros   = loc_nJuros
        THIS.this_nValorTotal   = THIS.this_nValorBase + loc_nJuros
        THIS.this_nValorParcela = THIS.this_nValorTotal / IIF(loc_nParc <> 0, loc_nParc, 1)

        RETURN .T.
    ENDPROC

    *---------------------------------------------------------------------------
    * CalcularJurosDia - Converte juros mensais em diarios
    * Atualiza this_nJurosDia e retorna o valor calculado
    *---------------------------------------------------------------------------
    PROCEDURE CalcularJurosDia(par_nJurosMes)
        LOCAL loc_nJurosDia

        IF THIS.this_nTipoCalculo = 1
            *-- Juros Simples: dividir por 30
            loc_nJurosDia = ROUND(par_nJurosMes / 30, 9)
        ELSE
            *-- Juros Compostos: formula de equivalencia
            loc_nJurosDia = ROUND((((1 + par_nJurosMes / 100) ^ (1/30)) - 1) * 100, 9)
        ENDIF

        THIS.this_nJurosDia = loc_nJurosDia
        RETURN loc_nJurosDia
    ENDPROC

    *---------------------------------------------------------------------------
    * CalcularJurosMes - Converte juros diarios em mensais
    * Atualiza this_nJurosMes e retorna o valor calculado
    *---------------------------------------------------------------------------
    PROCEDURE CalcularJurosMes(par_nJurosDia)
        LOCAL loc_nJurosMes

        IF THIS.this_nTipoCalculo = 1
            *-- Juros Simples: multiplicar por 30
            loc_nJurosMes = ROUND(par_nJurosDia * 30, 2)
        ELSE
            *-- Juros Compostos: formula de equivalencia
            loc_nJurosMes = ROUND((((1 + par_nJurosDia / 100) ^ 30) - 1) * 100, 2)
        ENDIF

        THIS.this_nJurosMes = loc_nJurosMes
        RETURN loc_nJurosMes
    ENDPROC

    *---------------------------------------------------------------------------
    * AjustarDiasUteis - Conta dias uteis entre duas datas (exclui fins de
    * semana e feriados cadastrados em SigCdFer). Atualiza this_nDias.
    * Equivalente ao bloco fChkFeriado do legado em getDataFinal.Valid/
    * getDias.Valid/optDias.InteractiveChange.
    *---------------------------------------------------------------------------
    PROCEDURE AjustarDiasUteis(par_dDataBase, par_dDataFinal)
        LOCAL loc_nDias, loc_dAtual

        loc_nDias  = par_dDataFinal - par_dDataBase
        loc_dAtual = par_dDataBase

        DO WHILE loc_dAtual <= par_dDataFinal
            IF THIS.VerificarFeriado(loc_dAtual)
                loc_nDias = loc_nDias - 1
            ENDIF
            loc_dAtual = loc_dAtual + 1
        ENDDO

        THIS.this_nDias = loc_nDias
        RETURN loc_nDias
    ENDPROC

    *---------------------------------------------------------------------------
    * VerificarFeriado - Retorna .T. se a data e fim de semana ou feriado
    * cadastrado em SigCdFer (equivalente a fChkFeriado do legado).
    *---------------------------------------------------------------------------
    PROCEDURE VerificarFeriado(par_dData)
        LOCAL loc_nDow, loc_lNaoUtil, loc_cSQL, loc_nRet

        *-- Verificar fim de semana (DOW: Domingo=1, Sabado=7)
        loc_nDow = DOW(par_dData)
        IF loc_nDow = 1 OR loc_nDow = 7
            RETURN .T.
        ENDIF

        *-- Verificar feriado cadastrado no banco
        loc_lNaoUtil = .F.
        loc_cSQL = "SELECT COUNT(*) AS nFeriado FROM SigCdFer " + ;
                   "WHERE CAST(datas AS DATE) = CAST(" + FormatarDataSQL(par_dData) + " AS DATE)"

        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FerCheck")
        IF loc_nRet > 0 AND USED("cursor_4c_FerCheck")
            SELECT cursor_4c_FerCheck
            IF NVL(nFeriado, 0) > 0
                loc_lNaoUtil = .T.
            ENDIF
            USE IN cursor_4c_FerCheck
        ENDIF

        RETURN loc_lNaoUtil
    ENDPROC

    *---------------------------------------------------------------------------
    * ValidarValorBase - Valida que o valor base e positivo
    *---------------------------------------------------------------------------
    PROCEDURE ValidarValorBase(par_nValor)
        IF par_nValor < 0
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *---------------------------------------------------------------------------
    * ValidarDatas - Valida que DataBase nao e maior que DataFinal
    *---------------------------------------------------------------------------
    PROCEDURE ValidarDatas(par_dDataBase, par_dDataFinal)
        IF !EMPTY(par_dDataBase) AND !EMPTY(par_dDataFinal)
            IF par_dDataBase > par_dDataFinal
                RETURN .F.
            ENDIF
        ENDIF
        RETURN .T.
    ENDPROC

    *---------------------------------------------------------------------------
    * ValidarDataVencimento - Valida que data de vencimento nao e anterior
    * a DataBase
    *---------------------------------------------------------------------------
    PROCEDURE ValidarDataVencimento(par_dVenc, par_dDataBase)
        IF !EMPTY(par_dDataBase) AND !EMPTY(par_dVenc)
            IF par_dVenc < par_dDataBase
                RETURN .F.
            ENDIF
        ENDIF
        RETURN .T.
    ENDPROC

    *---------------------------------------------------------------------------
    * CarregarDoCursor - Popula propriedades de entrada do calculo a partir
    * de cursor (usado quando o form eh chamado por outra rotina que ja tem
    * os parametros num cursor VFP). Mapeamento por campos que existirem.
    *---------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        IF VARTYPE(par_cAliasCursor) != "C" OR EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor n" + CHR(227) + "o encontrado: " + TRANSFORM(par_cAliasCursor)
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)

            IF TYPE(par_cAliasCursor + ".ValorBase") != "U"
                THIS.this_nValorBase = NVL(EVALUATE(par_cAliasCursor + ".ValorBase"), 0)
            ENDIF
            IF TYPE(par_cAliasCursor + ".TipoCalculo") != "U"
                THIS.this_nTipoCalculo = NVL(EVALUATE(par_cAliasCursor + ".TipoCalculo"), 1)
            ENDIF
            IF TYPE(par_cAliasCursor + ".JurosMes") != "U"
                THIS.this_nJurosMes = NVL(EVALUATE(par_cAliasCursor + ".JurosMes"), 0)
            ENDIF
            IF TYPE(par_cAliasCursor + ".JurosDia") != "U"
                THIS.this_nJurosDia = NVL(EVALUATE(par_cAliasCursor + ".JurosDia"), 0)
            ENDIF
            IF TYPE(par_cAliasCursor + ".DataBase") != "U"
                THIS.this_dDataBase = NVL(EVALUATE(par_cAliasCursor + ".DataBase"), {})
            ENDIF
            IF TYPE(par_cAliasCursor + ".DataFinal") != "U"
                THIS.this_dDataFinal = NVL(EVALUATE(par_cAliasCursor + ".DataFinal"), {})
            ENDIF
            IF TYPE(par_cAliasCursor + ".Dias") != "U"
                THIS.this_nDias = NVL(EVALUATE(par_cAliasCursor + ".Dias"), 0)
            ENDIF
            IF TYPE(par_cAliasCursor + ".TipoDias") != "U"
                THIS.this_nTipoDias = NVL(EVALUATE(par_cAliasCursor + ".TipoDias"), 1)
            ENDIF

            IF !EMPTY(THIS.this_dDataBase) AND !EMPTY(THIS.this_dDataFinal) AND THIS.this_nDias = 0
                THIS.this_nDias = THIS.this_dDataFinal - THIS.this_dDataBase
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar cursor: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * Inserir - Sobrescreve BusinessBase.Inserir()
    * Form OPERACIONAL de calculo puro (this_cTabela vazio): nao persiste
    * dados em tabela CRUD. Executa o calculo e retorna resultado.
    * Chamada via BusinessBase.Salvar() apos ValidarDados().
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso

        loc_lSucesso = THIS.Calcular()

        IF !loc_lSucesso
            THIS.this_cMensagemErro = "Falha ao executar c" + CHR(225) + "lculo de juros"
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * Atualizar - Sobrescreve BusinessBase.Atualizar()
    * Form OPERACIONAL de calculo puro: recalcula com parametros correntes.
    * Chamada via BusinessBase.Salvar() em modo edicao apos ValidarDados().
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso

        loc_lSucesso = THIS.Calcular()

        IF !loc_lSucesso
            THIS.this_cMensagemErro = "Falha ao recalcular juros"
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * RegistrarAuditoria - Sobrescreve BusinessBase.RegistrarAuditoria()
    * Como o form nao tem tabela associada (this_cTabela vazio), registra no
    * LogAuditoria a operacao de calculo com resumo dos parametros usados.
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cResumo, loc_cUsuario, loc_nRet

        loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")

        loc_cResumo = "VB=" + TRANSFORM(THIS.this_nValorBase, "@Z 999999999.99") + ;
                      "|TC=" + TRANSFORM(THIS.this_nTipoCalculo) + ;
                      "|JM=" + TRANSFORM(THIS.this_nJurosMes, "@Z 999.999999") + ;
                      "|D=" + TRANSFORM(THIS.this_nDias) + ;
                      "|VJ=" + TRANSFORM(THIS.this_nValorJuros, "@Z 999999999.99")

        loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                   "VALUES (" + EscaparSQL("SigPrCfn") + ", " + ;
                   EscaparSQL(par_cOperacao) + ", " + ;
                   EscaparSQL(LEFT(loc_cResumo, 100)) + ", " + ;
                   EscaparSQL(loc_cUsuario) + ", GETDATE())"

        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
        RETURN (loc_nRet > 0)
    ENDPROC

ENDDEFINE
