*============================================================================
* SigPrCfnBO.prg - Business Object para Calculo de Juros (dialogo utilitario)
*
* Origem legado: SIGPRCFN.SCX ("Calculo de Juros")
* Sem tabela de persistencia - o form eh um dialogo modal de calculo em
* memoria, aberto via CREATEOBJECT com parametros (Valor Base, Tipo de
* Calculo, Juros ao Mes/Dia, Data Base, Data Final) e fechado com btnOK.
* Nao ha INSERT/UPDATE/DELETE no legado (comportamento.json: totalQueries=0,
* tabelasUsadas=[]).
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigPrCfnBO AS BusinessBase

    *==========================================================================
    * Propriedades de entrada - espelham os parametros do Init legado
    * Lparameters pVal, pTip, pJMe, pJDi, pDtB, pDtF
    *==========================================================================
    this_nValorBase   = 0     && Valor Base do calculo (getValorBase)
    this_nTipoCalculo = 1     && 1=Simples, 2=Composto (optCalculo.Value)
    this_nJurosMes    = 0     && Juros ao Mes, percentual (getJurosMes)
    this_nJurosDia    = 0     && Juros ao Dia, percentual - relevante so quando
                               && Juros ao Mes nao foi informado (getJurosDia)
    this_dDataBase    = {}    && Data Base do calculo (getDataBase)
    this_dDataFinal   = {}    && Data Final do calculo (getDataFinal)
    this_nDias        = 0     && Quantidade de dias entre Data Base e Data Final
                               && ou entre Data Base e o ultimo vencimento (getDias)
    this_nTipoDias    = 1     && 1=Corridos, 2=Uteis (optDias.Value)

    *==========================================================================
    * Vencimentos (parcelamento) - ate 10 datas (getvenc1..getvenc10)
    *==========================================================================
    this_dVenc1  = {}
    this_dVenc2  = {}
    this_dVenc3  = {}
    this_dVenc4  = {}
    this_dVenc5  = {}
    this_dVenc6  = {}
    this_dVenc7  = {}
    this_dVenc8  = {}
    this_dVenc9  = {}
    this_dVenc10 = {}

    *==========================================================================
    * Propriedades de saida - resultado do calculo (nao persistidas)
    *==========================================================================
    this_nValorJuros   = 0    && Valor de juros calculado (getValorJuros)
    this_nValorTotal   = 0    && Valor Base + Valor de Juros (getValorTotal)
    this_nValorParcela = 0    && Valor Total dividido pela quantidade de
                               && vencimentos preenchidos (GetValorpar)

    *==========================================================================
    * Cache de feriados (SigCdFer), usado no calculo de dias uteis
    * (optDias = 2). Formato "|AAAAMMDD|AAAAMMDD|..." evita um SELECT por
    * dia dentro do laco de calculo.
    *==========================================================================
    this_cFeriados           = ""
    this_lFeriadosCarregados = .F.

    *==========================================================================
    * Init - Business Object sem tabela de persistencia. Nao repassa nome de
    * tabela ao DODEFAULT() (BusinessBase.Init so cria o DataAccess quando
    * recebe um nome de tabela nao vazio).
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Decisao de design: este BO NAO sobrescreve CarregarDoCursor()/Inserir()/
    * Atualizar()/ExecutarExclusao()/ObterChavePrimaria(). O legado (PROCEDURE
    * calculos do SIGPRCFN.SCX) e um dialogo modal de calculo em memoria - abre
    * via CREATEOBJECT com parametros, calcula e fecha com btnOK.Click =
    * ThisForm.Release. Nao ha SELECT/INSERT/UPDATE/DELETE em lugar nenhum do
    * dump (comportamento.json: totalQueries=0, tabelasUsadas=[]). O
    * comportamento padrao herdado de BusinessBase (recusar a operacao) ja eh
    * o correto para este caso. A funcionalidade REAL do legado - o metodo
    * Calculos() - eh implementada abaixo, transcrita literalmente (formula,
    * sinal, guards e ordem identicos ao dump, conforme regra de negocio).
    *==========================================================================

    *==========================================================================
    * Calcular - Equivalente a PROCEDURE calculos do legado. Le as propriedades
    * de entrada (this_nValorBase, this_nTipoCalculo, this_nJurosMes,
    * this_nJurosDia, this_dDataBase, this_dDataFinal, this_nDias,
    * this_dVenc1..10) e grava this_nValorJuros/this_nValorTotal/
    * this_nValorParcela - e, quando ha vencimentos preenchidos, TAMBEM
    * this_nDias (efeito colateral identico ao legado: "If lnTotDia > 0 /
    * thisform.getDias.Value = lnTotDia").
    *
    * Formula TRANSCRITA do dump, sem "corrigir" nada (regra #17):
    *   Simples : Juros = Round(ValorBase * (JurosMes/100)  * (Dias/30), 2)
    *   Composto: Juros = Round(ValorBase * (((1+JurosDia/100)^Dias)-1), 2)
    * Cada vencimento preenchido REINICIA o acumulador na primeira parcela
    * encontrada (lnParc = 0 -> lnJuros = 0) e soma o juros daquela parcela
    * usando os dias entre a Data Base e o proprio vencimento - igual ao
    * legado, inclusive o "bug" de this_nDias ficar com os dias do ULTIMO
    * vencimento (nao a media, apesar do comentario morto no legado).
    *==========================================================================
    PROCEDURE Calcular()
        LOCAL loc_lResultado, loc_nJuros, loc_nParc, loc_nTotDia, loc_nDia, ;
              loc_nX, loc_dVenc
        loc_lResultado = .F.
        loc_nParc      = 0

        TRY
            IF EMPTY(THIS.this_nValorBase)  OR EMPTY(THIS.this_nJurosMes) OR ;
               EMPTY(THIS.this_nJurosDia)   OR EMPTY(THIS.this_dDataBase) OR ;
               EMPTY(THIS.this_dDataFinal)  OR EMPTY(THIS.this_nDias)

                THIS.this_nValorJuros = 0
                THIS.this_nValorTotal = 0
            ELSE
                IF THIS.this_nTipoCalculo = 1
                    *-- Juros Simples
                    loc_nJuros = ROUND(THIS.this_nValorBase * ;
                        (THIS.this_nJurosMes / 100) * (THIS.this_nDias / 30), 2)
                ELSE
                    *-- Juros Compostos
                    loc_nJuros = ROUND(THIS.this_nValorBase * ;
                        (((1 + THIS.this_nJurosDia / 100) ^ (THIS.this_nDias)) - 1), 2)
                ENDIF

                loc_nTotDia = 0
                loc_nParc   = 0

                FOR loc_nX = 1 TO 10
                    loc_dVenc = EVALUATE("THIS.this_dVenc" + ALLTRIM(STR(loc_nX)))

                    IF !EMPTY(loc_dVenc)
                        IF loc_nParc = 0
                            *-- quando calcula por parcelas, zera o calculo feito acima
                            loc_nJuros = 0
                        ENDIF

                        loc_nDia = loc_dVenc - THIS.this_dDataBase

                        IF THIS.this_nTipoCalculo = 1
                            loc_nJuros = loc_nJuros + ROUND(THIS.this_nValorBase * ;
                                (THIS.this_nJurosMes / 100) * (loc_nDia / 30), 2)
                        ELSE
                            loc_nJuros = loc_nJuros + ROUND(THIS.this_nValorBase * ;
                                (((1 + THIS.this_nJurosDia / 100) ^ (loc_nDia)) - 1), 2)
                        ENDIF

                        loc_nTotDia = loc_nDia
                        loc_nParc   = loc_nParc + 1
                    ENDIF
                ENDFOR

                IF loc_nTotDia > 0
                    THIS.this_nDias = loc_nTotDia
                ENDIF

                THIS.this_nValorJuros = loc_nJuros
                THIS.this_nValorTotal = THIS.this_nValorBase + loc_nJuros
            ENDIF

            *-- mena 11/12/2014 (legado): calcula valor de cada parcela
            THIS.this_nValorParcela = THIS.this_nValorTotal / IIF(loc_nParc <> 0, loc_nParc, 1)

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CalcularJurosDiaAPartirDoMes - Equivalente a getJurosMes.Valid do legado.
    * Recebe o Juros ao Mes recem-digitado e devolve o Juros ao Dia
    * correspondente (o Form grava o retorno em this_nJurosDia).
    *==========================================================================
    FUNCTION CalcularJurosDiaAPartirDoMes(par_nJurosMes)
        LOCAL loc_nJurosDia

        IF THIS.this_nTipoCalculo = 1
            *-- Juros Simples
            loc_nJurosDia = ROUND(par_nJurosMes / 30, 9)
        ELSE
            *-- Juros Compostos
            loc_nJurosDia = ROUND((((1 + par_nJurosMes / 100) ^ (1 / 30)) - 1) * 100, 9)
        ENDIF

        RETURN loc_nJurosDia
    ENDFUNC

    *==========================================================================
    * CalcularJurosMesAPartirDoDia - Equivalente a getJurosDia.Valid do legado.
    * Recebe o Juros ao Dia recem-digitado e devolve o Juros ao Mes
    * correspondente (o Form grava o retorno em this_nJurosMes).
    *==========================================================================
    FUNCTION CalcularJurosMesAPartirDoDia(par_nJurosDia)
        LOCAL loc_nJurosMes

        IF THIS.this_nTipoCalculo = 1
            *-- Juros Simples
            loc_nJurosMes = ROUND(par_nJurosDia * 30, 2)
        ELSE
            *-- Juros Compostos
            loc_nJurosMes = ROUND((((1 + par_nJurosDia / 100) ^ (30)) - 1) * 100, 2)
        ENDIF

        RETURN loc_nJurosMes
    ENDFUNC

    *==========================================================================
    * CalcularDiasEfetivos - Centraliza o bloco "dias uteis" repetido no
    * legado em getDataFinal.Valid/getDias.Valid/optDias.InteractiveChange:
    *   lnDia = <dias corridos ja calculados pelo Form>
    *   If (lnDia > 0) And optDias.Value = 2
    *       ...percorre par_dDataBase..par_dDataFinal subtraindo sabado,
    *          domingo e feriado (SigCdFer)...
    *   EndIf
    * par_nDiasBrutos eh o valor JA calculado pelo Form (diferenca de datas
    * ou o proprio valor digitado em getDias, conforme o handler de origem -
    * o legado usa a MESMA variavel lnDia nos tres lugares, so a origem dela
    * muda). This_nTipoDias = 2 equivale a optDias.Value = 2 (Uteis).
    *==========================================================================
    FUNCTION CalcularDiasEfetivos(par_dDataBase, par_dDataFinal, par_nDiasBrutos)
        LOCAL loc_nDias, loc_dAtual

        loc_nDias = par_nDiasBrutos

        IF loc_nDias > 0 AND THIS.this_nTipoDias = 2 AND ;
           !ISNULL(par_dDataBase) AND !EMPTY(par_dDataBase) AND ;
           !ISNULL(par_dDataFinal) AND !EMPTY(par_dDataFinal)

            THIS.CarregarFeriados()

            loc_dAtual = par_dDataBase
            DO WHILE loc_dAtual <= par_dDataFinal
                IF THIS.VerificarFeriado(loc_dAtual)
                    loc_nDias = loc_nDias - 1
                ENDIF
                loc_dAtual = loc_dAtual + 1
            ENDDO
        ENDIF

        RETURN loc_nDias
    ENDFUNC

    *==========================================================================
    * CarregarFeriados - Le SigCdFer uma unica vez para this_cFeriados
    * (string "|AAAAMMDD|..."), evitando um SELECT por dia dentro do laco.
    * Equivalente ao cache usado por fChkFeriado(ThisForm.poDataMgr, ...) do
    * legado.
    *==========================================================================
    PROTECTED PROCEDURE CarregarFeriados()
        LOCAL loc_cSQL, loc_nRet, loc_cLista, loc_cAliasAnt

        IF THIS.this_lFeriadosCarregados
            RETURN .T.
        ENDIF

        loc_cLista    = "|"
        loc_cAliasAnt = ALIAS()

        TRY
            IF USED("cursor_4c_FerLoad")
                USE IN cursor_4c_FerLoad
            ENDIF

            loc_cSQL = "SELECT DISTINCT datas FROM SigCdFer WHERE datas IS NOT NULL"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FerLoad")

            IF loc_nRet > 0 AND USED("cursor_4c_FerLoad")
                SELECT cursor_4c_FerLoad
                SCAN
                    IF !ISNULL(datas) AND !EMPTY(datas)
                        loc_cLista = loc_cLista + DTOS(ConverterParaData(datas)) + "|"
                    ENDIF
                ENDSCAN
                USE IN cursor_4c_FerLoad
            ENDIF

            THIS.this_cFeriados           = loc_cLista
            THIS.this_lFeriadosCarregados = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "CarregarFeriados")
        ENDTRY

        IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * VerificarFeriado - .T. se a data eh sabado, domingo ou feriado
    * (SigCdFer.datas). Equivalente a fChkFeriado(poDataMgr, ldDia, .T., .T.)
    * do legado (DOW: 1=Domingo, 7=Sabado no calendario padrao VFP9).
    *==========================================================================
    PROTECTED PROCEDURE VerificarFeriado(par_dData)
        LOCAL loc_nDow, loc_lNaoUtil

        loc_lNaoUtil = .F.
        loc_nDow     = DOW(par_dData)

        IF loc_nDow = 1 OR loc_nDow = 7
            loc_lNaoUtil = .T.
        ELSE
            loc_lNaoUtil = ("|" + DTOS(par_dData) + "|") $ THIS.this_cFeriados
        ENDIF

        RETURN loc_lNaoUtil
    ENDPROC

ENDDEFINE
