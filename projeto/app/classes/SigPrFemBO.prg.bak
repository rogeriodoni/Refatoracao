*============================================================================
* SigPrFemBO.prg - Business Object para Analise de Producao (SIGPRFEM)
*
* Form OPERACIONAL (SIGPRFEM / FormSigPrFem): processa, num periodo
* informado pelo usuario (Get_Datai/Get_Dataf) e numa configuracao de
* demonstrativo (Get_Demonstrativo -> SigPrDmo.Nome), o balanco de
* funcionarios de um Grupo/Conta - saldo inicial, entradas, saidas,
* pesagem fisica e falhas - e exibe o resultado nos 5 grids/resumo da
* Page "Resultado" (Detalhe/detalhe2/detalhe3/detalhe4/detalhe5).
*
* NAO ha tabela de cadastro associada - o form eh de processamento/
* relatorio (nao-CRUD): o comportamento padrao herdado de BusinessBase
* (recusar Inserir/Atualizar/ExecutarExclusao) ja eh o correto para
* esta entidade.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigPrFemBO AS BusinessBase

    *==========================================================================
    * Filtros de processamento (SIGPRFEM.Get_Datai / Get_Dataf / Get_Demonstrativo)
    *==========================================================================
    this_dDataInicial   = {}         && Get_Datai.Value          - inicio do periodo analisado
    this_dDataFinal     = {}         && Get_Dataf.Value          - fim do periodo analisado
    this_cDemonstrativo = SPACE(20)  && Get_Demonstrativo.Value  - SigPrDmo.Nome (config. Grupos/Contas)

    *==========================================================================
    * Parametros do sistema (SigCdPam), carregados uma unica vez no Init -
    * equivalente ao CursorQuery('SigCdPam','crSigCdPam',...,'Ouros, DopeBals')
    * do Init() legado
    *==========================================================================
    this_cOuros    = SPACE(14)  && SigCdPam.ouros    - codigo do material "ouro" (referencia de saldo)
    this_cDopeBals = SPACE(20)  && SigCdPam.dopebals - operacao padrao usada no balanco

    *==========================================================================
    * Resultados do processamento (Page Resultado.Resumo) - preenchidos apos
    * Processar() e espelhados nos TextBox ReadOnly Get_Saldoi/Get_Entradas/
    * Get_TEntradas/Get_Saidas/Get_Saldo/Get_SaldoAnt/Get_SaldoFunc/
    * Get_Pesagem/Get_SaldoT/Get_FalhaFunc
    *==========================================================================
    this_nSaldoInicial       = 0  && Get_Saldoi.Value    - saldo com funcionarios antes do periodo
    this_nEntradas           = 0  && Get_Entradas.Value  - entradas no periodo
    this_nTotalEntradas      = 0  && Get_TEntradas.Value - sub-total entradas (saldo inicial + entradas)
    this_nSaidas             = 0  && Get_Saidas.Value    - saidas no periodo
    this_nSaldo              = 0  && Get_Saldo.Value     - saldo (total entradas - saidas)
    this_nSaldoAnterior      = 0  && Get_SaldoAnt.Value  - saldo funcionarios ant. ao periodo
    this_nSaldoFuncionarios  = 0  && Get_SaldoFunc.Value - saldo final com funcionarios (saldo + saldo anterior)
    this_nPesagem            = 0  && Get_Pesagem.Value   - pesagem fisica
    this_nSaldoTotal         = 0  && Get_SaldoT.Value    - total (saldo com funcionarios + pesagem)
    this_nFalhaFuncionarios  = 0  && Get_FalhaFunc.Value - falha de funcionarios no periodo

    *==========================================================================
    * Referencia ao form para o feedback de progresso - equivale ao
    * loBarra = CreateObject('fwprogressbar', ...) + loBarra.Update(.T.) que
    * o legado repete dentro do Scan de Processar.Click. Fica .NULL. quando
    * o BO eh usado sem interface (o processamento nao depende dela).
    *==========================================================================
    this_oFormUI = .NULL.

    *==========================================================================
    * Init - Nao ha tabela/chave primaria (form de processamento, nao-CRUD):
    * carrega apenas os parametros do sistema usados no calculo do balanco
    * (SigCdPam.ouros/dopebals)
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0

                IF USED("cursor_4c_SigCdPam")
                    USE IN cursor_4c_SigCdPam
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT ouros, dopebals FROM SigCdPam", ;
                    "cursor_4c_SigCdPam")
                IF USED("cursor_4c_SigCdPam") AND !EOF("cursor_4c_SigCdPam")
                    THIS.this_cOuros    = PADR(TratarNulo(cursor_4c_SigCdPam.ouros, ""), 14)
                    THIS.this_cDopeBals = PADR(TratarNulo(cursor_4c_SigCdPam.dopebals, ""), 20)
                ENDIF
                IF USED("cursor_4c_SigCdPam")
                    USE IN cursor_4c_SigCdPam
                ENDIF

                *-- Cursores de referencia carregados UMA UNICA VEZ (equivalente ao
                *-- With ThisForm / .poDataMgr.CursorQuery(...) do PROCEDURE Init
                *-- legado) - usados tanto por Processar() quanto por PosBalanco().
                IF USED("cursor_4c_CdPac")
                    USE IN cursor_4c_CdPac
                ENDIF
                SQLEXEC(gnConnHandle, "SELECT ndfechas FROM SigCdPac", "cursor_4c_CdPac")

                IF USED("cursor_4c_CdOpe")
                    USE IN cursor_4c_CdOpe
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT dopes, origems, estorigs, destinos, estdests, opers FROM SigCdOpe", ;
                    "cursor_4c_CdOpe")
                IF USED("cursor_4c_CdOpe")
                    SELECT cursor_4c_CdOpe
                    INDEX ON dopes TAG dopes
                ENDIF

                IF USED("cursor_4c_CdOpd")
                    USE IN cursor_4c_CdOpd
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT dopps, origems, estorigs, destinos, estdests FROM SigCdOpd", ;
                    "cursor_4c_CdOpd")
                IF USED("cursor_4c_CdOpd")
                    SELECT cursor_4c_CdOpd
                    INDEX ON dopps TAG dopps
                ENDIF

                IF USED("cursor_4c_CdGcr")
                    USE IN cursor_4c_CdGcr
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT codigos, unifbals, gerbals FROM SigCdGcr", ;
                    "cursor_4c_CdGcr")
                IF USED("cursor_4c_CdGcr")
                    SELECT cursor_4c_CdGcr
                    INDEX ON codigos TAG codigos
                ENDIF

                IF USED("cursor_4c_CdUni")
                    USE IN cursor_4c_CdUni
                ENDIF
                SQLEXEC(gnConnHandle, "SELECT cunis FROM SigCdUni", "cursor_4c_CdUni")
                IF USED("cursor_4c_CdUni")
                    SELECT cursor_4c_CdUni
                    INDEX ON cunis TAG cunis
                ENDIF

                *-- LocalGru do legado (SigCdGrp) - so as colunas usadas em
                *-- PosBalanco/Processar (TipoEstos/nAgMts/GruEstPs/ConEstPs/Mercs)
                IF USED("cursor_4c_Grp")
                    USE IN cursor_4c_Grp
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT cgrus, tipoestos, nagmts, gruestps, conestps, mercs FROM SigCdGrp", ;
                    "cursor_4c_Grp")
                IF USED("cursor_4c_Grp")
                    SELECT cursor_4c_Grp
                    INDEX ON cgrus TAG cgrus
                ENDIF

                *-- LocalGgrp do legado (SigCdGpr) - usado so como existencia
                *-- (Seek por Codigos), sem leitura de outras colunas
                IF USED("cursor_4c_Gpr")
                    USE IN cursor_4c_Gpr
                ENDIF
                SQLEXEC(gnConnHandle, "SELECT codigos FROM SigCdGpr", "cursor_4c_Gpr")
                IF USED("cursor_4c_Gpr")
                    SELECT cursor_4c_Gpr
                    INDEX ON codigos TAG codigos
                ENDIF

            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Decisao de projeto (Fase 2 - BO somente-leitura, sem tabela de cadastro):
    * este BO NAO sobrescreve CarregarDoCursor(), Inserir(), Atualizar() nem
    * ExecutarExclusao() - o comportamento herdado de BusinessBase para esses
    * quatro metodos (recusar a operacao) ja eh o correto para esta entidade.
    *
    * SIGPRFEM eh form de processamento/analise: nao ha registro unico de
    * cadastro para carregar (CarregarDoCursor) nem tabela propria para gravar
    * (Inserir/Atualizar). No codigo original (PROCEDURE posbalanco), toda
    * gravacao (Insert Into / Replace) tem como alvo cursor LOCAL criado no
    * proprio metodo - TmpResumo, Saldos, SaldoAnt, CrSaldoI, LocalFecha,
    * LocalNens, LocalNensI, LocalEest, LocalEestI, LocalEsti2, LocalGru,
    * LocalGgrp, csTotal - nunca uma tabela remota do SQL Server; o legado
    * tambem nunca chama TableUpdate() nem AddCursor() bufferizado sobre
    * tabela remota. Por isso ObterChavePrimaria() tambem mantem o retorno
    * herdado (vazio) e RegistrarAuditoria() nunca eh acionada por este BO.
    *
    * O calculo de balanco (equivalente ao PROCEDURE posbalanco do legado) e
    * a orquestracao do botao Processar sao implementados em metodo de
    * negocio proprio deste BO nas fases seguintes do pipeline.
    *==========================================================================


    *==========================================================================
    * Processar - ponto de entrada do botao Processar (SIGPRFEM.Processar.Click)
    *
    * Recebe os tres filtros da tela ja validados pelo form (o legado valida
    * dentro do proprio Click, com SetFocus - isso fica no form, que eh quem
    * tem os controles) e devolve .T. quando o processamento terminou e os
    * cursores de resultado / as properties this_n* estao prontos para a tela.
    *
    * O corpo fica em ExecutarProcessamento(), FORA de TRY/CATCH, porque o
    * legado aborta o processo com "Return 0" em CADA falha de conexao (15
    * pontos) e RETURN nao pode existir dentro de TRY/CATCH (regra #1). O
    * TRY/CATCH que protege a chamada mora AQUI.
    *==========================================================================
    FUNCTION Processar(par_dDataInicial, par_dDataFinal, par_cDemonstrativo)
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        THIS.this_dDataInicial   = ConverterParaData(par_dDataInicial)
        THIS.this_dDataFinal     = ConverterParaData(par_dDataFinal)
        THIS.this_cDemonstrativo = ALLTRIM(TratarNulo(par_cDemonstrativo, ""))

        TRY
            loc_lResultado = THIS.ExecutarProcessamento()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigPrFemBO.Processar")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * ExecutarProcessamento - transcricao do corpo de SIGPRFEM.Processar.Click
    *
    * Sem TRY/CATCH de proposito (ver Processar acima): cada falha de conexao
    * do legado eh um "Return 0" imediato, e trocar os 15 por flag + IF
    * aninhado mudaria o ponto de aborto.
    *
    * Equivalencias de nome (PILAR 3 - o legado usa cursores globais):
    *   _Empr               -> go_4c_Sistema.cCodEmpresa
    *   crSigCdPam.Ouros    -> THIS.this_cOuros      (lido no Init)
    *   crSigCdPam.DopeBals -> THIS.this_cDopeBals
    *   crSigCdOpd/Ope/Gcr/Pac/Uni -> cursor_4c_CdOpd/CdOpe/CdGcr/CdPac/CdUni
    *   LocalGru / LocalGgrp       -> cursor_4c_Grp  / cursor_4c_Gpr
    *   TmpEntra/TmpSaida/TmpPesag/TmpSaldo/TmpPro/TmpOpi ->
    *       cursor_4c_Entra/Saida/Pesag/Saldo/Pro/Opi
    *   Entradas/Saidas/Saldos/SaldoAnt/Falhas/TmpResumo ->
    *       cursor_4c_Entradas/Saidas/Saldos/SaldoAnt/Falhas/Resumo
    *       (criados pelo form em CriarCursoresResultado)
    *==========================================================================
    PROTECTED FUNCTION ExecutarProcessamento()
        LOCAL loc_cEmpresa, loc_cCodMat, loc_cConfig, loc_cChave, loc_cQuery
        LOCAL loc_dDataI, loc_dDataF, loc_cPDat, loc_cPDtI, loc_cPDtF
        LOCAL loc_nSaldoIni, loc_nPesagem, loc_nSaldoFunc, loc_nSaldoaFun
        LOCAL loc_nFalhaFunc, loc_nTotalEntra, loc_nTotalSaida
        LOCAL loc_cEdn, loc_cChave1, loc_cChave2, loc_cTpOp, loc_cMaterial
        LOCAL loc_cTemp, loc_cAlias, loc_cEmpMov, loc_lOk
        LOCAL loc_lEOrigem, loc_lEDestino, loc_lSOrigem, loc_lSDestino, loc_lOriDes
        LOCAL loc_cGrupoO, loc_cContaO, loc_cGrupoD, loc_cContaD
        LOCAL loc_oBarra

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            MsgErro("Sem conex" + CHR(227) + "o com o banco de dados.", ;
                    "Falha na Conex" + CHR(227) + "o")
            RETURN .F.
        ENDIF

        loc_dDataI   = THIS.this_dDataInicial
        loc_dDataF   = THIS.this_dDataFinal
        loc_cConfig  = THIS.this_cDemonstrativo
        loc_cEmpresa = go_4c_Sistema.cCodEmpresa
        loc_cCodMat  = THIS.this_cOuros

        *-- Legado: Zap In Saldos / SaldoAnt / Falhas / Entradas / Saidas
        THIS.LimparCursoresResultado()

        *-- Legado: CursorQuery('SigPrDmo', ..., 'Nome', lcConfig, 'Grupos, Contas')
        loc_cQuery = "SELECT grupos, contas FROM SigPrDmo WHERE nome = " + EscaparSQL(loc_cConfig)
        IF !THIS.ExecutarConsulta(loc_cQuery, "cursor_4c_PrDmo", "crSigPrDmo")
            RETURN .F.
        ENDIF
        IF EOF("cursor_4c_PrDmo")
            MsgAviso("Configura" + CHR(231) + CHR(227) + "o [" + loc_cConfig + ;
                     "] n" + CHR(227) + "o encontrada.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        loc_cChave = loc_cEmpresa + cursor_4c_PrDmo.grupos + cursor_4c_PrDmo.contas

        *======================================================================
        * Saldo inicial - ultimo historico ate a vespera da data inicial
        *======================================================================
        loc_cPDat = FormatarDataSQL(fDtoSQL(loc_dDataI - 1))

        loc_cQuery = "SELECT TOP 1 sqtds FROM SigMvHst" + ;
                     " WHERE empgruests = " + EscaparSQL(loc_cChave) + ;
                     " AND cpros = " + EscaparSQL(loc_cCodMat) + ;
                     " AND datas <= " + loc_cPDat + ;
                     " ORDER BY cidchaves DESC"
        IF !THIS.ExecutarConsulta(loc_cQuery, "cursor_4c_MvHst", "crSigMvHst")
            RETURN .F.
        ENDIF

        loc_nSaldoIni = 0
        IF !EOF("cursor_4c_MvHst")
            loc_nSaldoIni = TratarNulo(cursor_4c_MvHst.sqtds, 0)
        ENDIF

        *======================================================================
        * Configuracao do demonstrativo (SigCdDpr):
        *   Operas = 'P' Pesagem | 'H' Saldo c/funcionario | 'E' Entrada | 'S' Saida
        *======================================================================
        loc_cQuery = "SELECT grupos, contas, tpops FROM SigCdDpr" + ;
                     " WHERE operas = 'P' AND nome = " + EscaparSQL(loc_cConfig)
        IF !THIS.ExecutarConsulta(loc_cQuery, "cursor_4c_Pesag", "TmpPesag")
            RETURN .F.
        ENDIF
        SELECT cursor_4c_Pesag
        INDEX ON grupos + contas TAG GruConta

        loc_cQuery = "SELECT grupos, contas, tpops FROM SigCdDpr" + ;
                     " WHERE operas = 'H' AND nome = " + EscaparSQL(loc_cConfig)
        IF !THIS.ExecutarConsulta(loc_cQuery, "cursor_4c_Saldo", "TmpSaldo")
            RETURN .F.
        ENDIF
        SELECT cursor_4c_Saldo
        INDEX ON grupos + contas TAG GruConta

        loc_cQuery = "SELECT grupos, contas, tpops FROM SigCdDpr" + ;
                     " WHERE operas = 'E' AND nome = " + EscaparSQL(loc_cConfig)
        IF !THIS.ExecutarConsulta(loc_cQuery, "cursor_4c_Entra", "TmpEntra")
            RETURN .F.
        ENDIF
        SELECT cursor_4c_Entra
        INDEX ON grupos + contas + tpops TAG GruConTp

        loc_cQuery = "SELECT grupos, contas, tpops FROM SigCdDpr" + ;
                     " WHERE operas = 'S' AND nome = " + EscaparSQL(loc_cConfig)
        IF !THIS.ExecutarConsulta(loc_cQuery, "cursor_4c_Saida", "TmpSaida")
            RETURN .F.
        ENDIF
        SELECT cursor_4c_Saida
        INDEX ON grupos + contas + tpops TAG GruConTp

        loc_cPDtI = FormatarDataSQL(fDtoSQL(loc_dDataI))
        loc_cPDtF = FormatarDataSQL(fDtoSQL(loc_dDataF, "23:59:59"))

        *-- Cadastro de produtos (usado tambem por PosBalanco)
        loc_cQuery = "SELECT cpros, dpros, cunis, cgrus, varias, custofs," + ;
                     " moecusfs, matprincs, cunips FROM SigCdPro"
        IF !THIS.ExecutarConsulta(loc_cQuery, "cursor_4c_Pro", "TmpPro")
            RETURN .F.
        ENDIF
        SELECT cursor_4c_Pro
        INDEX ON cpros TAG cpros

        *======================================================================
        * Movimento de PRODUCAO do periodo (SigCdNec + SigCdNei)
        *======================================================================
        loc_cQuery = "SELECT a.datas, a.emps, a.dopps, a.numps, a.grupoos, a.contaos," + ;
                     " a.grupods, a.contads, a.cidchaves, b.empdnps, b.servicos," + ;
                     " b.cmats, b.tpops, b.qtds, b.pesos, b.cidchaves AS chaveb, b.nops" + ;
                     " FROM SigCdNec a, SigCdNei b" + ;
                     " WHERE a.emps = " + EscaparSQL(loc_cEmpresa) + ;
                     " AND a.datas BETWEEN " + loc_cPDtI + " AND " + loc_cPDtF + ;
                     " AND a.empdnps = b.empdnps" + ;
                     " ORDER BY b.cidchaves"
        IF !THIS.ExecutarConsulta(loc_cQuery, "cursor_4c_Producao", "crProducao")
            RETURN .F.
        ENDIF

        loc_cQuery = "SELECT cpros, nops FROM SigOpPic"
        IF !THIS.ExecutarConsulta(loc_cQuery, "cursor_4c_Opi", "TmpOpi")
            RETURN .F.
        ENDIF
        SELECT cursor_4c_Opi
        INDEX ON nops TAG nops

        SELECT DISTINCT empdnps, servicos, cmats, pesos, chaveb, tpops, qtds, nops ;
          FROM cursor_4c_Producao ;
         WHERE NOT servicos ;
          INTO CURSOR cursor_4c_CdNei READWRITE
        SELECT cursor_4c_CdNei
        INDEX ON empdnps TAG empdnps
        SET ORDER TO empdnps

        SELECT DISTINCT datas, emps, dopps, numps, grupoos, contaos, grupods, contads, cidchaves ;
          FROM cursor_4c_Producao ;
         ORDER BY datas, emps, dopps, numps, grupoos, contaos, grupods, contads, cidchaves ;
          INTO CURSOR cursor_4c_CdNec

        SELECT cursor_4c_CdNec
        loc_oBarra = THIS.CriarBarra("Processando Mov. Produ" + CHR(231) + CHR(227) + "o", RECCOUNT())
        SCAN
            THIS.AtualizarBarra(loc_oBarra)

            = SEEK(cursor_4c_CdNec.dopps, "cursor_4c_CdOpd", "dopps")

            loc_lEOrigem  = .F.
            loc_lEDestino = .F.
            loc_lSOrigem  = .F.
            loc_lSDestino = .F.

            IF cursor_4c_CdOpd.origems = 1
                IF (SEEK(cursor_4c_CdNec.grupoos + cursor_4c_CdNec.contaos, "cursor_4c_Entra") OR ;
                    SEEK(cursor_4c_CdNec.grupoos + SPACE(10), "cursor_4c_Entra")) AND ;
                   cursor_4c_CdOpd.estorigs = 1
                    loc_lEOrigem = .T.
                ENDIF
                IF (SEEK(cursor_4c_CdNec.grupoos + cursor_4c_CdNec.contaos, "cursor_4c_Saida") OR ;
                    SEEK(cursor_4c_CdNec.grupoos + SPACE(10), "cursor_4c_Saida")) AND ;
                   cursor_4c_CdOpd.estorigs = 2
                    loc_lSOrigem = .T.
                ENDIF
            ENDIF

            IF cursor_4c_CdOpd.destinos = 1
                IF (SEEK(cursor_4c_CdNec.grupods + cursor_4c_CdNec.contads, "cursor_4c_Entra") OR ;
                    SEEK(cursor_4c_CdNec.grupods + SPACE(10), "cursor_4c_Entra")) AND ;
                   cursor_4c_CdOpd.estdests = 1
                    loc_lEDestino = .T.
                ENDIF
                *-- Legado (nota de 18/10/11 no SCX): aqui era llEDestino e estava errado
                IF (SEEK(cursor_4c_CdNec.grupods + cursor_4c_CdNec.contads, "cursor_4c_Saida") OR ;
                    SEEK(cursor_4c_CdNec.grupods + SPACE(10), "cursor_4c_Saida")) AND ;
                   cursor_4c_CdOpd.estdests = 2
                    loc_lSDestino = .T.
                ENDIF
            ENDIF

            IF !loc_lEOrigem AND !loc_lEDestino AND !loc_lSOrigem AND !loc_lSDestino
                LOOP
            ENDIF

            loc_cEdn = cursor_4c_CdNec.emps + cursor_4c_CdNec.dopps + STR(cursor_4c_CdNec.numps, 10)

            SELECT cursor_4c_CdNei
            = SEEK(loc_cEdn)
            SCAN WHILE empdnps = loc_cEdn
                *-- ---------- lado ORIGEM ----------
                loc_cChave1 = cursor_4c_CdNec.grupoos + cursor_4c_CdNec.contaos + cursor_4c_CdNei.tpops
                loc_cChave2 = cursor_4c_CdNec.grupoos + SPACE(10) + cursor_4c_CdNei.tpops

                = SEEK(cursor_4c_CdNec.grupoos, "cursor_4c_CdGcr", "codigos")

                loc_cMaterial = THIS.ResolverMaterialProducao()
                IF cursor_4c_CdGcr.unifbals = 4 AND cursor_4c_CdNei.cmats <> loc_cMaterial
                    LOOP
                ENDIF

                loc_lOk = (loc_cMaterial = loc_cCodMat)

                IF (loc_lEOrigem OR loc_lSOrigem) AND loc_lOk
                    IF loc_lEOrigem
                        loc_cTemp  = "cursor_4c_Entra"
                        loc_cAlias = "cursor_4c_Entradas"
                    ELSE
                        loc_cTemp  = "cursor_4c_Saida"
                        loc_cAlias = "cursor_4c_Saidas"
                    ENDIF

                    IF SEEK(loc_cChave1, loc_cTemp) OR SEEK(loc_cChave2, loc_cTemp)
                        IF !SEEK(loc_cEmpresa + &loc_cTemp..tpops, loc_cAlias)
                            INSERT INTO &loc_cAlias. (TpOps) VALUES (&loc_cTemp..tpops)
                        ENDIF

                        IF cursor_4c_CdNei.cmats = loc_cCodMat AND cursor_4c_CdGcr.unifbals = 1
                            REPLACE &loc_cAlias..Qtde WITH &loc_cAlias..Qtde + cursor_4c_CdNei.qtds
                        ELSE
                            REPLACE &loc_cAlias..Qtde WITH &loc_cAlias..Qtde + cursor_4c_CdNei.pesos
                        ENDIF

                        REPLACE &loc_cAlias..Emps WITH loc_cEmpresa
                    ENDIF
                ENDIF

                *-- ---------- lado DESTINO ----------
                loc_cChave1 = cursor_4c_CdNec.grupods + cursor_4c_CdNec.contads + cursor_4c_CdNei.tpops
                loc_cChave2 = cursor_4c_CdNec.grupods + SPACE(10) + cursor_4c_CdNei.tpops

                = SEEK(cursor_4c_CdNec.grupods, "cursor_4c_CdGcr", "codigos")

                loc_cMaterial = THIS.ResolverMaterialProducao()
                IF cursor_4c_CdGcr.unifbals = 4 AND cursor_4c_CdNei.cmats <> loc_cMaterial
                    LOOP
                ENDIF

                loc_lOk = (loc_cMaterial = loc_cCodMat)

                IF (loc_lEDestino OR loc_lSDestino) AND loc_lOk
                    IF loc_lEDestino
                        loc_cTemp  = "cursor_4c_Entra"
                        loc_cAlias = "cursor_4c_Entradas"
                    ELSE
                        loc_cTemp  = "cursor_4c_Saida"
                        loc_cAlias = "cursor_4c_Saidas"
                    ENDIF

                    IF SEEK(loc_cChave1, loc_cTemp) OR SEEK(loc_cChave2, loc_cTemp)
                        IF !SEEK(loc_cEmpresa + &loc_cTemp..tpops, loc_cAlias)
                            INSERT INTO &loc_cAlias. (TpOps) VALUES (&loc_cTemp..tpops)
                        ENDIF

                        IF cursor_4c_CdNei.cmats = loc_cCodMat AND cursor_4c_CdGcr.unifbals = 1
                            REPLACE &loc_cAlias..Qtde WITH &loc_cAlias..Qtde + cursor_4c_CdNei.qtds
                        ELSE
                            REPLACE &loc_cAlias..Qtde WITH &loc_cAlias..Qtde + cursor_4c_CdNei.pesos
                        ENDIF

                        REPLACE &loc_cAlias..Emps WITH loc_cEmpresa
                    ENDIF
                ENDIF

                SELECT cursor_4c_CdNei
            ENDSCAN

            SELECT cursor_4c_CdNec
        ENDSCAN
        THIS.EncerrarBarra(loc_oBarra)

        *======================================================================
        * Movimento de ESTOQUE do periodo (SigMvCab + SigMvItn)
        *======================================================================
        loc_cQuery = "SELECT a.datas, a.emps, a.empds, a.dopes, a.numes, a.grupoos, a.contaos," + ;
                     " a.grupods, a.contads, a.cidchaves, b.empdopnums, b.cpros, b.opers," + ;
                     " b.qtds, b.cidchaves AS chaveb" + ;
                     " FROM SigMvCab a, SigMvItn b" + ;
                     " WHERE a.datas BETWEEN " + loc_cPDtI + " AND " + loc_cPDtF + ;
                     " AND (a.emps = " + EscaparSQL(loc_cEmpresa) + ;
                     " OR a.empds = " + EscaparSQL(loc_cEmpresa) + ")" + ;
                     " AND NOT a.dopes = " + EscaparSQL(THIS.this_cDopeBals) + ;
                     " AND a.empdopnums = b.empdopnums" + ;
                     " ORDER BY a.datas, a.emps, a.empds, a.dopes, a.numes, a.grupoos," + ;
                     " a.contaos, a.grupods, a.contads, a.cidchaves, b.empdopnums," + ;
                     " b.cpros, b.opers, b.qtds, b.cidchaves"
        IF !THIS.ExecutarConsulta(loc_cQuery, "cursor_4c_Estoque", "crEstoque")
            RETURN .F.
        ENDIF

        SELECT DISTINCT empdopnums, cpros, opers, qtds, chaveb ;
          FROM cursor_4c_Estoque ;
         ORDER BY empdopnums, cpros, opers, qtds, chaveb ;
          INTO CURSOR cursor_4c_MvItn READWRITE
        SELECT cursor_4c_MvItn
        INDEX ON empdopnums TAG empdopnums
        SET ORDER TO empdopnums

        SELECT DISTINCT datas, emps, empds, dopes, numes, grupoos, contaos, grupods, contads, cidchaves ;
          FROM cursor_4c_Estoque ;
         ORDER BY datas, emps, empds, dopes, numes, grupoos, contaos, grupods, contads, cidchaves ;
          INTO CURSOR cursor_4c_MvCab

        SELECT cursor_4c_MvCab
        loc_oBarra = THIS.CriarBarra("Processando Mov. de Estoque...", RECCOUNT())
        SCAN
            THIS.AtualizarBarra(loc_oBarra)

            = SEEK(cursor_4c_MvCab.dopes, "cursor_4c_CdOpe", "dopes")
            loc_lOriDes = .F.

            IF cursor_4c_MvCab.empds = loc_cEmpresa
                IF SEEK(cursor_4c_MvCab.grupods + cursor_4c_MvCab.contads, "cursor_4c_Entra")
                    loc_lOriDes = .T.
                ENDIF
            ELSE
                IF (SEEK(cursor_4c_MvCab.grupoos + cursor_4c_MvCab.contaos, "cursor_4c_Entra") OR ;
                    SEEK(cursor_4c_MvCab.grupoos + cursor_4c_MvCab.contaos, "cursor_4c_Saida") OR ;
                    SEEK(cursor_4c_MvCab.grupods + cursor_4c_MvCab.contads, "cursor_4c_Entra") OR ;
                    SEEK(cursor_4c_MvCab.grupods + cursor_4c_MvCab.contads, "cursor_4c_Saida")) OR ;
                   (SEEK(cursor_4c_MvCab.grupoos + SPACE(10), "cursor_4c_Entra") OR ;
                    SEEK(cursor_4c_MvCab.grupoos + SPACE(10), "cursor_4c_Saida") OR ;
                    SEEK(cursor_4c_MvCab.grupods + SPACE(10), "cursor_4c_Entra") OR ;
                    SEEK(cursor_4c_MvCab.grupods + SPACE(10), "cursor_4c_Saida"))
                    loc_lOriDes = .T.
                ENDIF
            ENDIF

            IF !loc_lOriDes
                LOOP
            ENDIF

            loc_cEdn = cursor_4c_MvCab.emps + cursor_4c_MvCab.dopes + STR(cursor_4c_MvCab.numes, 6)

            SELECT cursor_4c_MvItn
            SEEK loc_cEdn
            SCAN WHILE empdopnums = loc_cEdn
                loc_cGrupoO = SPACE(10)
                loc_cContaO = SPACE(10)
                loc_cGrupoD = SPACE(10)
                loc_cContaD = SPACE(10)

                loc_lSOrigem  = .F.
                loc_lEDestino = .F.

                IF cursor_4c_CdOpe.estorigs = 4
                    IF cursor_4c_MvItn.opers = "S" AND ;
                       (SEEK(cursor_4c_MvCab.grupoos + cursor_4c_MvCab.contaos, "cursor_4c_Saida") OR ;
                        SEEK(cursor_4c_MvCab.grupoos + SPACE(10), "cursor_4c_Saida"))
                        loc_lSOrigem = .T.
                        loc_cGrupoO  = cursor_4c_MvCab.grupoos
                        loc_cContaO  = cursor_4c_MvCab.contaos
                    ELSE
                        IF cursor_4c_MvItn.opers = "E" AND ;
                           (SEEK(cursor_4c_MvCab.grupods + cursor_4c_MvCab.contads, "cursor_4c_Entra") OR ;
                            SEEK(cursor_4c_MvCab.grupods + SPACE(10), "cursor_4c_Entra"))
                            loc_lEDestino = .T.
                            loc_cGrupoD   = cursor_4c_MvCab.grupods
                            loc_cContaD   = cursor_4c_MvCab.contads
                        ENDIF
                    ENDIF
                ELSE
                    IF cursor_4c_CdOpe.opers = 3
                        IF cursor_4c_CdOpe.origems = 1
                            IF cursor_4c_MvItn.opers = "S" AND ;
                               (SEEK(cursor_4c_MvCab.grupoos + cursor_4c_MvCab.contaos, "cursor_4c_Saida") OR ;
                                SEEK(cursor_4c_MvCab.grupoos + SPACE(10), "cursor_4c_Saida"))
                                loc_lSOrigem = .T.
                                loc_cGrupoO  = cursor_4c_MvCab.grupoos
                                loc_cContaO  = cursor_4c_MvCab.contaos
                            ELSE
                                IF cursor_4c_MvItn.opers = "E" AND ;
                                   (SEEK(cursor_4c_MvCab.grupoos + cursor_4c_MvCab.contaos, "cursor_4c_Entra") OR ;
                                    SEEK(cursor_4c_MvCab.grupoos + SPACE(10), "cursor_4c_Entra"))
                                    loc_lEDestino = .T.
                                    loc_cGrupoD   = cursor_4c_MvCab.grupoos
                                    loc_cContaD   = cursor_4c_MvCab.contaos
                                ENDIF
                            ENDIF
                        ELSE
                            IF cursor_4c_CdOpe.destinos = 1
                                IF cursor_4c_MvItn.opers = "S" AND ;
                                   (SEEK(cursor_4c_MvCab.grupods + cursor_4c_MvCab.contads, "cursor_4c_Saida") OR ;
                                    SEEK(cursor_4c_MvCab.grupods + SPACE(10), "cursor_4c_Saida"))
                                    loc_lSOrigem = .T.
                                    loc_cGrupoO  = cursor_4c_MvCab.grupods
                                    loc_cContaO  = cursor_4c_MvCab.contads
                                ELSE
                                    IF cursor_4c_MvItn.opers = "E" AND ;
                                       (SEEK(cursor_4c_MvCab.grupoos + cursor_4c_MvCab.contaos, "cursor_4c_Entra") OR ;
                                        SEEK(cursor_4c_MvCab.grupoos + SPACE(10), "cursor_4c_Entra"))
                                        loc_lEDestino = .T.
                                        loc_cGrupoD   = cursor_4c_MvCab.grupods
                                        loc_cContaD   = cursor_4c_MvCab.contads
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ELSE
                        IF cursor_4c_CdOpe.origems = 1
                            IF (SEEK(cursor_4c_MvCab.grupoos + cursor_4c_MvCab.contaos, "cursor_4c_Saida") OR ;
                                SEEK(cursor_4c_MvCab.grupoos + SPACE(10), "cursor_4c_Saida")) AND ;
                               cursor_4c_CdOpe.estorigs = 2
                                loc_lSOrigem = .T.
                                loc_cGrupoO  = cursor_4c_MvCab.grupoos
                                loc_cContaO  = cursor_4c_MvCab.contaos
                            ELSE
                                IF (SEEK(cursor_4c_MvCab.grupoos + cursor_4c_MvCab.contaos, "cursor_4c_Entra") OR ;
                                    SEEK(cursor_4c_MvCab.grupoos + SPACE(10), "cursor_4c_Entra")) AND ;
                                   cursor_4c_CdOpe.estorigs = 1
                                    loc_lEDestino = .T.
                                    loc_cGrupoD   = cursor_4c_MvCab.grupoos
                                    loc_cContaD   = cursor_4c_MvCab.contaos
                                ENDIF
                            ENDIF
                        ENDIF

                        IF cursor_4c_CdOpe.destinos = 1
                            IF (SEEK(cursor_4c_MvCab.grupods + cursor_4c_MvCab.contads, "cursor_4c_Saida") OR ;
                                SEEK(cursor_4c_MvCab.grupods + SPACE(10), "cursor_4c_Saida")) AND ;
                               cursor_4c_CdOpe.estdests = 2
                                loc_lSOrigem = .T.
                                loc_cGrupoO  = cursor_4c_MvCab.grupods
                                loc_cContaO  = cursor_4c_MvCab.contads
                            ELSE
                                IF (SEEK(cursor_4c_MvCab.grupods + cursor_4c_MvCab.contads, "cursor_4c_Entra") OR ;
                                    SEEK(cursor_4c_MvCab.grupods + SPACE(10), "cursor_4c_Entra")) AND ;
                                   cursor_4c_CdOpe.estdests = 1
                                    loc_lEDestino = .T.
                                    loc_cGrupoD   = cursor_4c_MvCab.grupods
                                    loc_cContaD   = cursor_4c_MvCab.contads
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF

                loc_cTpOp = PADR(LEFT(cursor_4c_MvCab.dopes, 10), 15)

                *-- ---------- lado SAIDA (origem) ----------
                loc_cChave1 = loc_cGrupoO + loc_cContaO + SPACE(15)
                loc_cChave2 = loc_cGrupoO + SPACE(10) + SPACE(15)

                = SEEK(loc_cGrupoO, "cursor_4c_CdGcr", "codigos")
                = SEEK(cursor_4c_MvItn.cpros, "cursor_4c_Pro", "cpros")

                loc_cMaterial = THIS.ResolverMaterialEstoque()
                loc_lOk       = (loc_cMaterial = loc_cCodMat)

                IF loc_lSOrigem AND loc_lOk
                    loc_cTemp   = "cursor_4c_Saida"
                    loc_cAlias  = "cursor_4c_Saidas"
                    loc_cEmpMov = IIF(EMPTY(cursor_4c_MvCab.empds), ;
                                      cursor_4c_MvCab.emps, cursor_4c_MvCab.empds)

                    IF SEEK(loc_cChave1, loc_cTemp) OR SEEK(loc_cChave2, loc_cTemp)
                        IF !SEEK(loc_cEmpMov + loc_cTpOp, loc_cAlias)
                            SELECT (loc_cAlias)
                            APPEND BLANK
                            REPLACE TpOps WITH loc_cTpOp, ;
                                    Emps  WITH loc_cEmpMov
                        ENDIF
                        REPLACE &loc_cAlias..Qtde WITH &loc_cAlias..Qtde + cursor_4c_MvItn.qtds
                    ENDIF
                ENDIF

                *-- ---------- lado ENTRADA (destino) ----------
                loc_cChave1 = loc_cGrupoD + loc_cContaD + SPACE(15)
                loc_cChave2 = loc_cGrupoD + SPACE(10) + SPACE(15)

                = SEEK(loc_cGrupoD, "cursor_4c_CdGcr", "codigos")
                = SEEK(cursor_4c_MvItn.cpros, "cursor_4c_Pro", "cpros")

                loc_cMaterial = THIS.ResolverMaterialEstoque()
                loc_lOk       = (loc_cMaterial = loc_cCodMat)

                IF loc_lEDestino AND loc_lOk
                    loc_cTemp   = "cursor_4c_Entra"
                    loc_cAlias  = "cursor_4c_Entradas"
                    loc_cEmpMov = cursor_4c_MvCab.emps

                    IF SEEK(loc_cChave1, loc_cTemp) OR SEEK(loc_cChave2, loc_cTemp)
                        IF !SEEK(loc_cEmpMov + loc_cTpOp, loc_cAlias)
                            SELECT (loc_cAlias)
                            APPEND BLANK
                            REPLACE TpOps WITH loc_cTpOp, ;
                                    Emps  WITH loc_cEmpMov
                        ENDIF
                        REPLACE &loc_cAlias..Qtde WITH &loc_cAlias..Qtde + cursor_4c_MvItn.qtds
                    ENDIF
                ENDIF

                SELECT cursor_4c_MvItn
            ENDSCAN

            SELECT cursor_4c_MvCab
        ENDSCAN
        THIS.EncerrarBarra(loc_oBarra)

        *======================================================================
        * Pesagem fisica do periodo (SigCdPsc + SigCdPsi)
        *======================================================================
        loc_nPesagem = 0

        SELECT cursor_4c_Pesag
        loc_oBarra = THIS.CriarBarra("Processando Pesagens", RECCOUNT())
        SCAN
            THIS.AtualizarBarra(loc_oBarra)

            loc_cQuery = "SELECT datas, codigos FROM SigCdPsc" + ;
                         " WHERE emps = " + EscaparSQL(loc_cEmpresa) + ;
                         " AND grupos = " + EscaparSQL(cursor_4c_Pesag.grupos) + ;
                         " AND contas = " + EscaparSQL(cursor_4c_Pesag.contas) + ;
                         " AND datas >= " + loc_cPDtI + ;
                         " AND datas <= " + loc_cPDtF + ;
                         " ORDER BY datas DESC, codigos DESC"
            IF !THIS.ExecutarConsulta(loc_cQuery, "cursor_4c_CdPsc", "crSigCdPsc")
                RETURN .F.
            ENDIF

            SELECT cursor_4c_CdPsc
            GO TOP

            loc_cQuery = "SELECT cpros, qtds FROM SigCdPsi" + ;
                         " WHERE emps = " + EscaparSQL(loc_cEmpresa) + ;
                         " AND codigos = " + ;
                         FormatarNumeroSQL(TratarNulo(cursor_4c_CdPsc.codigos, 0), 0) + ;
                         " AND cpros = " + EscaparSQL(loc_cCodMat) + ;
                         " ORDER BY cpros, qtds"
            IF !THIS.ExecutarConsulta(loc_cQuery, "cursor_4c_CdPsi", "crSigCdPsi")
                RETURN .F.
            ENDIF

            SELECT cursor_4c_CdPsi
            SCAN
                loc_nPesagem = loc_nPesagem + TratarNulo(cursor_4c_CdPsi.qtds, 0)
            ENDSCAN

            SELECT cursor_4c_Pesag
        ENDSCAN
        THIS.EncerrarBarra(loc_oBarra)

        *======================================================================
        * Saldo com funcionarios (SigMvEst -> PosBalanco por Grupo/Conta)
        *======================================================================
        loc_nSaldoFunc = 0
        loc_nSaldoaFun = 0

        SELECT cursor_4c_Saldo
        loc_oBarra = THIS.CriarBarra("Processando Saldo c/funcion" + CHR(225) + "rio", RECCOUNT())
        SCAN
            THIS.AtualizarBarra(loc_oBarra)

            loc_cQuery = "SELECT emps, grupos, estos, cpros FROM SigMvEst WHERE " + ;
                IIF(EMPTY(cursor_4c_Saldo.contas), ;
                    "emps = " + EscaparSQL(loc_cEmpresa) + ;
                    " AND grupos = " + EscaparSQL(cursor_4c_Saldo.grupos), ;
                    "empgruests = " + ;
                    EscaparSQL(loc_cEmpresa + cursor_4c_Saldo.grupos + cursor_4c_Saldo.contas)) + ;
                " AND cpros = " + EscaparSQL(loc_cCodMat)

            IF !THIS.ExecutarConsulta(loc_cQuery, "cursor_4c_MvEst", "crSigMvEst")
                RETURN .F.
            ENDIF

            SELECT cursor_4c_MvEst
            SCAN
                = SEEK(cursor_4c_MvEst.grupos, "cursor_4c_CdGcr", "codigos")
                loc_lOk = (cursor_4c_MvEst.cpros = loc_cCodMat OR cursor_4c_CdGcr.unifbals = 1)
                IF !loc_lOk
                    LOOP
                ENDIF

                IF !THIS.PosBalanco()
                    RETURN .F.
                ENDIF

                SELECT cursor_4c_MvEst
            ENDSCAN

            SELECT cursor_4c_Saldo
        ENDSCAN
        THIS.EncerrarBarra(loc_oBarra)

        SELECT " " AS Agrupar, SUM(Qtde) AS Qtde ;
          FROM cursor_4c_Saldos INTO CURSOR cursor_4c_Selecao GROUP BY 1
        loc_nSaldoFunc = TratarNulo(cursor_4c_Selecao.Qtde, 0)

        SELECT " " AS Agrupar, SUM(Qtde) AS Qtde ;
          FROM cursor_4c_SaldoAnt INTO CURSOR cursor_4c_Selecao GROUP BY 1
        loc_nSaldoaFun = TratarNulo(cursor_4c_Selecao.Qtde, 0)

        *======================================================================
        * Falha dos funcionarios no periodo (SigCdFcx + SigOpCfe)
        *======================================================================
        loc_nFalhaFunc = 0

        SELECT cursor_4c_Saldo
        loc_oBarra = THIS.CriarBarra("Processando Falha dos Funcionarios", RECCOUNT())
        SCAN
            THIS.AtualizarBarra(loc_oBarra)

            loc_cQuery = "SELECT b.cidchaves, b.freals, b.entradas, b.saldos, b.saidas, b.pesagems" + ;
                         " FROM SigCdFcx a, SigOpCfe b" + ;
                         " WHERE a.datas BETWEEN " + loc_cPDtI + " AND " + loc_cPDtF + ;
                         " AND a.emps = " + EscaparSQL(loc_cEmpresa) + ;
                         " AND a.grupos = " + EscaparSQL(cursor_4c_Saldo.grupos) + ;
                         IIF(EMPTY(cursor_4c_Saldo.contas), " ", ;
                             " AND a.contas = " + EscaparSQL(cursor_4c_Saldo.contas)) + ;
                         " AND a.emps = b.emps" + ;
                         " AND a.codigos = b.codigos" + ;
                         " AND b.cpros = " + EscaparSQL(loc_cCodMat) + ;
                         " ORDER BY b.cidchaves, b.freals, b.entradas, b.saldos, b.saidas, b.pesagems"
            IF !THIS.ExecutarConsulta(loc_cQuery, "cursor_4c_CdFcx", "crSigCdFcx")
                RETURN .F.
            ENDIF

            SELECT cursor_4c_CdFcx
            SCAN
                loc_nFalhaFunc = loc_nFalhaFunc + TratarNulo(cursor_4c_CdFcx.freals, 0)

                IF !SEEK(cursor_4c_Saldo.grupos, "cursor_4c_Falhas")
                    INSERT INTO cursor_4c_Falhas (Grupos, Contas, Emps) ;
                         VALUES (cursor_4c_Saldo.grupos, cursor_4c_Saldo.contas, loc_cEmpresa)
                ENDIF

                REPLACE Qtde  WITH cursor_4c_Falhas.Qtde + TratarNulo(cursor_4c_CdFcx.freals, 0), ;
                        Entra WITH cursor_4c_Falhas.Entra + TratarNulo(cursor_4c_CdFcx.entradas, 0) + ;
                                   TratarNulo(cursor_4c_CdFcx.saldos, 0), ;
                        Saida WITH cursor_4c_Falhas.Saida + TratarNulo(cursor_4c_CdFcx.saidas, 0) + ;
                                   TratarNulo(cursor_4c_CdFcx.pesagems, 0) ;
                     IN cursor_4c_Falhas

                SELECT cursor_4c_CdFcx
            ENDSCAN

            SELECT cursor_4c_Saldo
        ENDSCAN
        THIS.EncerrarBarra(loc_oBarra)

        *======================================================================
        * Totalizadores - FONTE UNICA: quem calcula eh o BO, o form so espelha
        *======================================================================
        loc_nTotalEntra = 0
        loc_nTotalSaida = 0

        SELECT cursor_4c_Entradas
        SUM Qtde TO loc_nTotalEntra

        SELECT cursor_4c_Saidas
        SUM Qtde TO loc_nTotalSaida

        THIS.this_nSaldoInicial      = loc_nSaldoIni
        THIS.this_nSaldoAnterior     = loc_nSaldoaFun
        THIS.this_nEntradas          = loc_nTotalEntra
        THIS.this_nTotalEntradas     = loc_nSaldoIni + loc_nTotalEntra + loc_nSaldoaFun
        THIS.this_nSaidas            = loc_nTotalSaida
        THIS.this_nPesagem           = loc_nPesagem
        THIS.this_nSaldo             = loc_nSaldoIni + loc_nTotalEntra - loc_nTotalSaida + loc_nSaldoaFun
        THIS.this_nSaldoFuncionarios = loc_nSaldoFunc
        THIS.this_nFalhaFuncionarios = loc_nFalhaFunc
        THIS.this_nSaldoTotal        = loc_nPesagem + loc_nSaldoFunc

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * PosBalanco - transcricao de SIGPRFEM.PROCEDURE posbalanco
    *
    * Roda UMA vez por linha de cursor_4c_MvEst (Grupo/Conta do demonstrativo)
    * e acumula, no cursor_4c_SaldoAnt (lnCt = 1, posicao na vespera da data
    * inicial) e no cursor_4c_Saldos (lnCt = 2, posicao na data final), o saldo
    * final de material daquele Grupo/Conta.
    *
    * Sem TRY/CATCH: o legado aborta com "Return 0" em cada falha de conexao
    * (7 pontos) e RETURN nao pode existir dentro de TRY/CATCH (regra #1) - o
    * TRY/CATCH que cobre toda a cadeia mora em Processar().
    *==========================================================================
    PROTECTED FUNCTION PosBalanco()
        LOCAL loc_cEmpresa, loc_cCodMat, loc_cQuery, loc_nCt
        LOCAL loc_dDataB, loc_dDataL, loc_cPDat, loc_cGrupo, loc_cConta
        LOCAL loc_lOrigem, loc_lDestino, loc_cMaterial, loc_cOperacao
        LOCAL loc_cGrupoD, loc_cContaD, loc_cEdn, loc_cCodCor, loc_cCodTam
        LOCAL loc_nQtde, loc_nTrabalhado, loc_nFalhaAdmitida, loc_nSaldoi
        LOCAL loc_cMat, loc_cMatAnt, loc_lTipoQ, loc_oBarra, loc_cChaveIt

        loc_cEmpresa    = go_4c_Sistema.cCodEmpresa
        loc_cCodMat     = THIS.this_cOuros
        loc_nTrabalhado = 0

        *-- Cliente/conta do saldo: so gera balanco quando a conta E o grupo de
        *-- conta estao marcados como "gera balanco" (GerBals = 1)
        loc_cQuery = "SELECT rclis, gerbals, pagfals, recfals FROM SigCdCli" + ;
                     " WHERE iclis = " + EscaparSQL(cursor_4c_MvEst.estos)
        IF !THIS.ExecutarConsulta(loc_cQuery, "cursor_4c_CdCli", "crsjcli")
            RETURN .F.
        ENDIF

        = SEEK(cursor_4c_MvEst.grupos, "cursor_4c_CdGcr", "codigos")

        IF TratarNulo(cursor_4c_CdCli.gerbals, 0) <> 1 OR ;
           TratarNulo(cursor_4c_CdGcr.gerbals, 0) <> 1
            RETURN .T.
        ENDIF

        *-- Fechamentos de balanco ja realizados para este Grupo/Conta
        loc_cQuery = "SELECT datas, codigos FROM SigCdFcx" + ;
                     " WHERE emps = " + EscaparSQL(loc_cEmpresa) + ;
                     " AND grupos = " + EscaparSQL(cursor_4c_MvEst.grupos) + ;
                     " AND contas = " + EscaparSQL(cursor_4c_MvEst.estos)
        IF !THIS.ExecutarConsulta(loc_cQuery, "cursor_4c_Fecha", "LocalFecha")
            RETURN .F.
        ENDIF

        *-- lnCt = 1 -> posicao ANTERIOR ao periodo | lnCt = 2 -> posicao FINAL
        FOR loc_nCt = 1 TO 2

            SELECT cursor_4c_Resumo
            SET ORDER TO
            THIS.ZaparCursor("cursor_4c_Resumo")
            SET ORDER TO GrConMat

            loc_dDataB = IIF(loc_nCt = 1, THIS.this_dDataInicial - 1, THIS.this_dDataFinal)
            loc_dDataL = IIF(loc_nCt = 1, THIS.this_dDataInicial - 1, THIS.this_dDataFinal)

            SELECT cursor_4c_Fecha
            INDEX ON DTOS(datas) TAG Datas
            SET ORDER TO Datas DESCENDING
            SET NEAR ON
            = SEEK(DTOS(loc_dDataB))
            SET NEAR OFF
            IF cursor_4c_Fecha.datas > loc_dDataB
                *-- Nenhum fechamento anterior: parte do inicio dos tempos e
                *-- deixa o cursor em EOF (LocalFecha.Codigos = 0)
                loc_cPDat = FormatarDataSQL(CTOD("01/01/1900"))
                LOCATE FOR .F.
            ELSE
                loc_cPDat = FormatarDataSQL(fDtoSQL(ConverterParaData(cursor_4c_Fecha.datas) + ;
                                            TratarNulo(cursor_4c_CdPac.ndfechas, 0)))
            ENDIF

            loc_cGrupo         = cursor_4c_MvEst.grupos
            loc_cConta         = cursor_4c_MvEst.estos
            loc_nFalhaAdmitida = 0
            loc_lTipoQ         = .F.

            *==================================================================
            * PRODUCAO desde o ultimo fechamento (SigCdNec + SigCdNei)
            *==================================================================
            loc_cQuery = "SELECT datas, dopps, grupoos, contaos, grupods, contads," + ;
                         " emps, numps, obss, cidchaves, empdnps FROM SigCdNec" + ;
                         " WHERE emps = " + EscaparSQL(loc_cEmpresa) + ;
                         " AND datas >= " + loc_cPDat + ;
                         " AND ((grupods = " + EscaparSQL(loc_cGrupo) + ;
                         " AND contads = " + EscaparSQL(loc_cConta) + ;
                         " AND (procdbal = 0 OR numbalds <> " + ;
                         FormatarNumeroSQL(TratarNulo(cursor_4c_Fecha.codigos, 0), 0) + "))" + ;
                         " OR (grupoos = " + EscaparSQL(loc_cGrupo) + ;
                         " AND contaos = " + EscaparSQL(loc_cConta) + ;
                         " AND (procbals = 0 OR numbals <> " + ;
                         FormatarNumeroSQL(TratarNulo(cursor_4c_Fecha.codigos, 0), 0) + ")))" + ;
                         " ORDER BY datas, dopps, grupoos, contaos, grupods, contads," + ;
                         " emps, numps, cidchaves"
            IF !THIS.ExecutarConsulta(loc_cQuery, "cursor_4c_Nens", "LocalNens")
                RETURN .F.
            ENDIF

            loc_cQuery = "SELECT b.empdnps, b.cmats, b.cunis, b.nenvs, b.pesos, b.qtds," + ;
                         " b.tpops, b.cidchaves, b.nops, b.peso2s, b.codcors, b.codtams" + ;
                         " FROM SigCdNec a, SigCdNei b" + ;
                         " WHERE a.emps = " + EscaparSQL(loc_cEmpresa) + ;
                         " AND a.datas >= " + loc_cPDat + ;
                         " AND (a.grupods = " + EscaparSQL(loc_cGrupo) + ;
                         " OR a.grupoos = " + EscaparSQL(loc_cGrupo) + ")" + ;
                         " AND (a.contads = " + EscaparSQL(loc_cConta) + ;
                         " OR a.contaos = " + EscaparSQL(loc_cConta) + ")" + ;
                         " AND a.empdnps = b.empdnps" + ;
                         " AND b.servicos = 0" + ;
                         " ORDER BY b.empdnps, b.cmats, b.cunis, b.nenvs, b.pesos," + ;
                         " b.qtds, b.tpops, b.cidchaves, b.nops"
            IF !THIS.ExecutarConsulta(loc_cQuery, "cursor_4c_NensI", "LocalNensI")
                RETURN .F.
            ENDIF
            SELECT cursor_4c_NensI
            INDEX ON empdnps TAG empdnps
            SET ORDER TO empdnps

            SELECT cursor_4c_Nens
            loc_oBarra = THIS.CriarBarra("Processando Mov. de Produ" + CHR(231) + CHR(227) + "o...", ;
                                         RECCOUNT(), .T.)
            SCAN
                THIS.AtualizarBarra(loc_oBarra)

                IF DTOS(cursor_4c_Nens.datas) > DTOS(loc_dDataL)
                    LOOP
                ENDIF

                loc_cEdn = cursor_4c_Nens.emps + cursor_4c_Nens.dopps + ;
                           STR(cursor_4c_Nens.numps, 10)

                = SEEK(cursor_4c_Nens.dopps, "cursor_4c_CdOpd", "dopps")

                loc_lOrigem   = .F.
                loc_lDestino  = .F.
                loc_cMaterial = SPACE(14)

                IF cursor_4c_CdOpd.origems = 1 AND cursor_4c_Nens.grupoos = loc_cGrupo AND ;
                   cursor_4c_Nens.contaos = loc_cConta AND INLIST(cursor_4c_CdOpd.estorigs, 1, 2)
                    loc_lOrigem = .T.
                ENDIF

                IF cursor_4c_CdOpd.destinos = 1 AND cursor_4c_Nens.grupods = loc_cGrupo AND ;
                   cursor_4c_Nens.contads = loc_cConta AND INLIST(cursor_4c_CdOpd.estdests, 1, 2)
                    loc_lDestino = .T.
                ENDIF

                IF !loc_lOrigem AND !loc_lDestino
                    LOOP
                ENDIF

                SELECT cursor_4c_NensI
                SEEK loc_cEdn
                SCAN WHILE empdnps = loc_cEdn

                    loc_cMaterial = THIS.ResolverMaterialNensI()
                    IF cursor_4c_CdGcr.unifbals = 4 AND cursor_4c_NensI.cmats <> loc_cMaterial
                        LOOP
                    ENDIF

                    = SEEK(cursor_4c_NensI.cmats, "cursor_4c_Pro", "cpros")
                    = SEEK(cursor_4c_Pro.cgrus, "cursor_4c_Grp", "cgrus")
                    = SEEK(cursor_4c_Grp.mercs, "cursor_4c_Gpr", "codigos")

                    loc_cCodCor = PADR(IIF(INLIST(cursor_4c_Grp.tipoestos, 2, 4), ;
                                           cursor_4c_NensI.codcors, " "), 4)
                    loc_cCodTam = PADR(IIF(INLIST(cursor_4c_Grp.tipoestos, 3, 4), ;
                                           cursor_4c_NensI.codtams, " "), 4)

                    IF loc_lOrigem
                        IF !SEEK(cursor_4c_Nens.grupoos + cursor_4c_Nens.contaos + ;
                                 cursor_4c_NensI.cmats + loc_cCodCor + loc_cCodTam, "cursor_4c_Resumo")
                            INSERT INTO cursor_4c_Resumo ;
                                   (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams) ;
                            VALUES (cursor_4c_Nens.grupoos, cursor_4c_Nens.contaos, ;
                                    cursor_4c_NensI.cmats, cursor_4c_Pro.cunis, cursor_4c_Pro.varias, ;
                                    cursor_4c_Grp.nagmts, .T., loc_cCodCor, loc_cCodTam)
                        ENDIF

                        SELECT cursor_4c_Resumo
                        IF cursor_4c_CdOpd.estorigs = 1
                            REPLACE PesoEnts  WITH PesoEnts + cursor_4c_NensI.pesos, ;
                                    QtdeEnts  WITH QtdeEnts + cursor_4c_NensI.qtds, ;
                                    PesoFabre WITH PesoFabre + cursor_4c_NensI.peso2s
                        ELSE
                            REPLACE PesoSais  WITH PesoSais + cursor_4c_NensI.pesos, ;
                                    QtdeSais  WITH QtdeSais + cursor_4c_NensI.qtds, ;
                                    PesoFabrs WITH PesoFabrs + cursor_4c_NensI.peso2s
                        ENDIF
                    ENDIF

                    IF loc_lDestino
                        IF !SEEK(cursor_4c_Nens.grupods + cursor_4c_Nens.contads + ;
                                 cursor_4c_NensI.cmats + loc_cCodCor + loc_cCodTam, "cursor_4c_Resumo")
                            INSERT INTO cursor_4c_Resumo ;
                                   (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams) ;
                            VALUES (cursor_4c_Nens.grupods, cursor_4c_Nens.contads, ;
                                    cursor_4c_NensI.cmats, cursor_4c_Pro.cunis, cursor_4c_Pro.varias, ;
                                    cursor_4c_Grp.nagmts, .T., loc_cCodCor, loc_cCodTam)
                        ENDIF

                        SELECT cursor_4c_Resumo
                        IF cursor_4c_CdOpd.estdests = 1
                            REPLACE PesoEnts  WITH PesoEnts + cursor_4c_NensI.pesos, ;
                                    QtdeEnts  WITH QtdeEnts + cursor_4c_NensI.qtds, ;
                                    PesoFabre WITH PesoFabre + cursor_4c_NensI.peso2s
                        ELSE
                            REPLACE PesoSais  WITH PesoSais + cursor_4c_NensI.pesos, ;
                                    QtdeSais  WITH QtdeSais + cursor_4c_NensI.qtds, ;
                                    PesoFabrs WITH PesoFabrs + cursor_4c_NensI.peso2s
                        ENDIF
                    ENDIF

                    = SEEK(cursor_4c_Resumo.CMats, "cursor_4c_Pro", "cpros")
                    = SEEK(cursor_4c_Pro.cgrus, "cursor_4c_Grp", "cgrus")
                    = SEEK(cursor_4c_Grp.mercs, "cursor_4c_Gpr", "codigos")

                    *-- UnifBals = 3: o material efetivo difere do apontado e o
                    *-- grupo/conta de estoque padrao nao eh o que esta sendo
                    *-- balanceado -> acumula tambem na linha do material efetivo
                    IF cursor_4c_CdGcr.unifbals = 3 AND cursor_4c_NensI.cmats <> loc_cMaterial ;
                       AND cursor_4c_Grp.gruestps <> cursor_4c_MvEst.grupos ;
                       AND cursor_4c_Grp.conestps <> cursor_4c_MvEst.estos

                        = SEEK(loc_cMaterial, "cursor_4c_Pro", "cpros")
                        = SEEK(cursor_4c_Pro.cgrus, "cursor_4c_Grp", "cgrus")
                        = SEEK(cursor_4c_Grp.mercs, "cursor_4c_Gpr", "codigos")

                        IF loc_lOrigem
                            IF !SEEK(cursor_4c_Nens.grupoos + cursor_4c_Nens.contaos + ;
                                     loc_cMaterial, "cursor_4c_Resumo")
                                INSERT INTO cursor_4c_Resumo ;
                                       (Grupo, Conta, CMats, CUnis, Varias, Visivel) ;
                                VALUES (cursor_4c_Nens.grupoos, cursor_4c_Nens.contaos, ;
                                        loc_cMaterial, cursor_4c_Pro.cunis, cursor_4c_Pro.varias, .T.)
                            ENDIF
                            SELECT cursor_4c_Resumo
                            IF cursor_4c_CdOpd.estorigs = 1
                                REPLACE PesoEnts WITH PesoEnts + cursor_4c_NensI.pesos, ;
                                        QtdeEnts WITH QtdeEnts + cursor_4c_NensI.pesos
                            ELSE
                                REPLACE PesoSais WITH PesoSais + cursor_4c_NensI.pesos, ;
                                        QtdeSais WITH QtdeSais + cursor_4c_NensI.pesos
                            ENDIF
                        ENDIF

                        IF loc_lDestino
                            IF !SEEK(cursor_4c_Nens.grupods + cursor_4c_Nens.contads + ;
                                     loc_cMaterial, "cursor_4c_Resumo")
                                INSERT INTO cursor_4c_Resumo ;
                                       (Grupo, Conta, CMats, CUnis, Varias, Visivel) ;
                                VALUES (cursor_4c_Nens.grupods, cursor_4c_Nens.contads, ;
                                        loc_cMaterial, cursor_4c_Pro.cunis, cursor_4c_Pro.varias, .T.)
                            ENDIF
                            SELECT cursor_4c_Resumo
                            IF cursor_4c_CdOpd.estdests = 1
                                REPLACE PesoEnts WITH PesoEnts + cursor_4c_NensI.pesos, ;
                                        QtdeEnts WITH QtdeEnts + cursor_4c_NensI.pesos
                            ELSE
                                REPLACE PesoSais WITH PesoSais + cursor_4c_NensI.pesos, ;
                                        QtdeSais WITH QtdeSais + cursor_4c_NensI.pesos
                            ENDIF
                        ENDIF
                    ENDIF

                    SELECT cursor_4c_NensI
                ENDSCAN

                SELECT cursor_4c_Nens
            ENDSCAN
            THIS.EncerrarBarra(loc_oBarra)

            *==================================================================
            * ESTOQUE desde o ultimo fechamento (SigMvCab + SigMvItn/SigMvIts)
            *==================================================================
            loc_cQuery = "SELECT datas, grupoos, contaos, grupods, contads, emps," + ;
                         " dopes, numes, obses, cidchaves, empds FROM SigMvCab" + ;
                         " WHERE (emps = " + EscaparSQL(loc_cEmpresa) + ;
                         " OR empds = " + EscaparSQL(loc_cEmpresa) + ")" + ;
                         " AND datas >= " + loc_cPDat + ;
                         " AND ((grupods = " + EscaparSQL(loc_cGrupo) + ;
                         " AND contads = " + EscaparSQL(loc_cConta) + ;
                         " AND (procdbal = 0 OR numbalds <> " + ;
                         FormatarNumeroSQL(TratarNulo(cursor_4c_Fecha.codigos, 0), 0) + "))" + ;
                         " OR (grupoos = " + EscaparSQL(loc_cGrupo) + ;
                         " AND contaos = " + EscaparSQL(loc_cConta) + ;
                         " AND (procbals = 0 OR numbals <> " + ;
                         FormatarNumeroSQL(TratarNulo(cursor_4c_Fecha.codigos, 0), 0) + ")))" + ;
                         " ORDER BY datas"
            IF !THIS.ExecutarConsulta(loc_cQuery, "cursor_4c_Eest", "LocalEest")
                RETURN .F.
            ENDIF

            loc_cQuery = "SELECT b.empdopnums, b.opers, b.cpros, b.cunis, b.qtds," + ;
                         " b.pesos, b.citens FROM SigMvCab a, SigMvItn b" + ;
                         " WHERE (a.emps = " + EscaparSQL(loc_cEmpresa) + ;
                         " OR a.empds = " + EscaparSQL(loc_cEmpresa) + ")" + ;
                         " AND a.datas >= " + loc_cPDat + ;
                         " AND (a.grupods = " + EscaparSQL(loc_cGrupo) + ;
                         " OR a.grupoos = " + EscaparSQL(loc_cGrupo) + ")" + ;
                         " AND (a.contads = " + EscaparSQL(loc_cConta) + ;
                         " OR a.contaos = " + EscaparSQL(loc_cConta) + ")" + ;
                         " AND a.empdopnums = b.empdopnums" + ;
                         " ORDER BY b.empdopnums, b.opers, b.cpros, b.cunis, b.qtds"
            IF !THIS.ExecutarConsulta(loc_cQuery, "cursor_4c_EestI", "LocalEestI")
                RETURN .F.
            ENDIF
            SELECT cursor_4c_EestI
            INDEX ON empdopnums TAG empdopnums
            SET ORDER TO empdopnums

            loc_cQuery = "SELECT b.empdopnums, b.cpros, b.qtds, b.pesos, b.codcors," + ;
                         " b.codtams, b.citens FROM SigMvCab a, SigMvIts b" + ;
                         " WHERE (a.emps = " + EscaparSQL(loc_cEmpresa) + ;
                         " OR a.empds = " + EscaparSQL(loc_cEmpresa) + ")" + ;
                         " AND a.datas >= " + loc_cPDat + ;
                         " AND (a.grupods = " + EscaparSQL(loc_cGrupo) + ;
                         " OR a.grupoos = " + EscaparSQL(loc_cGrupo) + ")" + ;
                         " AND (a.contads = " + EscaparSQL(loc_cConta) + ;
                         " OR a.contaos = " + EscaparSQL(loc_cConta) + ")" + ;
                         " AND a.empdopnums = b.empdopnums" + ;
                         " ORDER BY b.empdopnums, b.cpros, b.codcors, b.codtams, b.citens"
            IF !THIS.ExecutarConsulta(loc_cQuery, "cursor_4c_Esti2", "LocalEsti2")
                RETURN .F.
            ENDIF
            SELECT cursor_4c_Esti2
            INDEX ON empdopnums + cpros + STR(citens, 4) TAG empdopnums
            SET ORDER TO empdopnums

            SELECT cursor_4c_Eest
            loc_oBarra = THIS.CriarBarra("Processando Mov. de Estoque", ;
                                         RECCOUNT("cursor_4c_Eest"), .T.)
            SCAN
                THIS.AtualizarBarra(loc_oBarra)

                IF DTOS(cursor_4c_Eest.datas) > DTOS(loc_dDataL)
                    LOOP
                ENDIF

                loc_cEdn = cursor_4c_Eest.emps + cursor_4c_Eest.dopes + ;
                           STR(cursor_4c_Eest.numes, 6)

                = SEEK(cursor_4c_Eest.dopes, "cursor_4c_CdOpe", "dopes")

                loc_lOrigem  = .F.
                loc_lDestino = .F.

                IF cursor_4c_Eest.emps = loc_cEmpresa
                    IF cursor_4c_CdOpe.estorigs = 4 OR cursor_4c_CdOpe.opers = 3
                        IF cursor_4c_CdOpe.origems = 1 AND cursor_4c_Eest.grupoos = loc_cGrupo ;
                           AND cursor_4c_Eest.contaos = loc_cConta
                            loc_lOrigem = .T.
                        ELSE
                            IF cursor_4c_CdOpe.destinos = 1 AND cursor_4c_Eest.grupods = loc_cGrupo ;
                               AND cursor_4c_Eest.contads = loc_cConta
                                loc_lDestino = .T.
                            ENDIF
                        ENDIF
                    ELSE
                        IF cursor_4c_CdOpe.origems = 1 AND cursor_4c_Eest.grupoos = loc_cGrupo ;
                           AND cursor_4c_Eest.contaos = loc_cConta
                            IF INLIST(cursor_4c_CdOpe.estorigs, 1, 2)
                                loc_lOrigem = .T.
                            ENDIF
                        ENDIF

                        IF cursor_4c_CdOpe.destinos = 1 AND cursor_4c_Eest.grupods = loc_cGrupo ;
                           AND cursor_4c_Eest.contads = loc_cConta
                            IF INLIST(cursor_4c_CdOpe.estdests, 1, 2)
                                loc_lDestino = .T.
                            ENDIF
                        ENDIF
                    ENDIF
                ELSE
                    IF cursor_4c_Eest.empds = loc_cEmpresa
                        IF cursor_4c_CdOpe.destinos = 1 AND cursor_4c_Eest.grupods = loc_cGrupo ;
                           AND cursor_4c_Eest.contads = loc_cConta
                            IF INLIST(cursor_4c_CdOpe.estdests, 1, 2)
                                loc_lDestino = .T.
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF

                IF !loc_lOrigem AND !loc_lDestino
                    LOOP
                ENDIF

                SELECT cursor_4c_EestI
                SEEK loc_cEdn
                SCAN WHILE empdopnums = loc_cEdn
                    = SEEK(cursor_4c_EestI.cpros, "cursor_4c_Pro", "cpros")
                    = SEEK(cursor_4c_Pro.cgrus, "cursor_4c_Grp", "cgrus")
                    = SEEK(cursor_4c_Grp.mercs, "cursor_4c_Gpr", "codigos")

                    loc_cGrupoD   = SPACE(10)
                    loc_cContaD   = SPACE(10)
                    loc_cOperacao = " "

                    IF cursor_4c_CdOpe.estorigs = 4
                        loc_lOrigem  = .F.
                        loc_lDestino = .F.

                        IF cursor_4c_EestI.opers = "S" AND cursor_4c_Eest.grupoos = loc_cGrupo ;
                           AND cursor_4c_Eest.contaos = loc_cConta
                            loc_lOrigem   = .T.
                            loc_cOperacao = "S"
                            loc_cGrupoD   = cursor_4c_Eest.grupods
                            loc_cContaD   = cursor_4c_Eest.contads
                        ELSE
                            IF cursor_4c_EestI.opers = "E" AND cursor_4c_Eest.grupods = loc_cGrupo ;
                               AND cursor_4c_Eest.contads = loc_cConta
                                loc_lDestino  = .T.
                                loc_cOperacao = "E"
                                loc_cGrupoD   = cursor_4c_Eest.grupoos
                                loc_cContaD   = cursor_4c_Eest.contaos
                            ENDIF
                        ENDIF
                    ELSE
                        IF cursor_4c_CdOpe.opers = 3
                            IF cursor_4c_CdOpe.origems = 1
                                IF cursor_4c_EestI.opers = "S" AND cursor_4c_Eest.grupoos = loc_cGrupo ;
                                   AND cursor_4c_Eest.contaos = loc_cConta
                                    loc_lOrigem   = .T.
                                    loc_lDestino  = .F.
                                    loc_cOperacao = "S"
                                    loc_cGrupoD   = cursor_4c_Eest.grupoos
                                    loc_cContaD   = cursor_4c_Eest.contaos
                                ELSE
                                    IF cursor_4c_EestI.opers = "E" AND cursor_4c_Eest.grupoos = loc_cGrupo ;
                                       AND cursor_4c_Eest.contaos = loc_cConta
                                        loc_lOrigem   = .F.
                                        loc_lDestino  = .T.
                                        loc_cOperacao = "E"
                                        loc_cGrupoD   = cursor_4c_Eest.grupoos
                                        loc_cContaD   = cursor_4c_Eest.contaos
                                    ENDIF
                                ENDIF
                            ELSE
                                IF cursor_4c_CdOpe.destinos = 1
                                    IF cursor_4c_EestI.opers = "S" AND cursor_4c_Eest.grupods = loc_cGrupo ;
                                       AND cursor_4c_Eest.contads = loc_cConta
                                        loc_lOrigem   = .T.
                                        loc_cOperacao = "S"
                                        loc_cGrupoD   = cursor_4c_Eest.grupods
                                        loc_cContaD   = cursor_4c_Eest.contads
                                    ELSE
                                        IF cursor_4c_EestI.opers = "E" AND cursor_4c_Eest.grupods = loc_cGrupo ;
                                           AND cursor_4c_Eest.contads = loc_cConta
                                            loc_lDestino  = .T.
                                            loc_cOperacao = "E"
                                            loc_cGrupoD   = cursor_4c_Eest.grupods
                                            loc_cContaD   = cursor_4c_Eest.contads
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ELSE
                            IF loc_lOrigem AND cursor_4c_CdOpe.estorigs = 1
                                loc_cOperacao = "E"
                                IF cursor_4c_CdOpe.destinos = 1 AND cursor_4c_CdOpe.estdests = 2
                                    loc_cGrupoD = cursor_4c_Eest.grupods
                                    loc_cContaD = cursor_4c_Eest.contads
                                ENDIF
                            ELSE
                                IF loc_lOrigem AND cursor_4c_CdOpe.estorigs = 2
                                    loc_cOperacao = "S"
                                    IF cursor_4c_CdOpe.destinos = 1 AND cursor_4c_CdOpe.estdests = 1
                                        loc_cGrupoD = cursor_4c_Eest.grupods
                                        loc_cContaD = cursor_4c_Eest.contads
                                    ENDIF
                                ELSE
                                    IF loc_lDestino AND cursor_4c_CdOpe.estdests = 1
                                        loc_cOperacao = "E"
                                        IF cursor_4c_CdOpe.origems = 1 AND cursor_4c_CdOpe.estorigs = 2
                                            loc_cGrupoD = cursor_4c_Eest.grupoos
                                            loc_cContaD = cursor_4c_Eest.contaos
                                        ENDIF
                                    ELSE
                                        IF loc_lDestino AND cursor_4c_CdOpe.estdests = 2
                                            loc_cOperacao = "S"
                                            IF cursor_4c_CdOpe.origems = 1 AND cursor_4c_CdOpe.estorigs = 1
                                                loc_cGrupoD = cursor_4c_Eest.grupoos
                                                loc_cContaD = cursor_4c_Eest.contaos
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF

                    IF INLIST(cursor_4c_CdGcr.unifbals, 3, 4)
                        loc_cMaterial = IIF(EMPTY(cursor_4c_Pro.matprincs), ;
                                            THIS.this_cOuros, cursor_4c_Pro.matprincs)
                    ELSE
                        loc_cMaterial = IIF(cursor_4c_CdGcr.unifbals = 1, ;
                                            THIS.this_cOuros, cursor_4c_EestI.cpros)
                    ENDIF

                    IF cursor_4c_CdGcr.unifbals = 4 AND cursor_4c_EestI.cpros <> loc_cMaterial
                        LOOP
                    ENDIF

                    = SEEK(cursor_4c_Pro.cunis, "cursor_4c_CdUni", "cunis")

                    loc_cChaveIt = cursor_4c_EestI.empdopnums + cursor_4c_EestI.cpros + ;
                                   STR(cursor_4c_EestI.citens, 4)

                    SELECT cursor_4c_Esti2
                    SET ORDER TO empdopnums
                    IF SEEK(loc_cChaveIt)
                        SCAN WHILE empdopnums + cpros + STR(citens, 4) = loc_cChaveIt
                            loc_nQtde = cursor_4c_Esti2.qtds

                            loc_cCodCor = PADR(IIF(INLIST(cursor_4c_Grp.tipoestos, 2, 4), ;
                                                   cursor_4c_Esti2.codcors, " "), 4)
                            loc_cCodTam = PADR(IIF(INLIST(cursor_4c_Grp.tipoestos, 3, 4), ;
                                                   cursor_4c_Esti2.codtams, " "), 4)

                            IF loc_lOrigem
                                IF !SEEK(loc_cGrupo + loc_cConta + cursor_4c_Esti2.cpros + ;
                                         loc_cCodCor + loc_cCodTam, "cursor_4c_Resumo")
                                    INSERT INTO cursor_4c_Resumo ;
                                           (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams) ;
                                    VALUES (loc_cGrupo, loc_cConta, cursor_4c_EestI.cpros, ;
                                            cursor_4c_EestI.cunis, cursor_4c_Pro.varias, ;
                                            cursor_4c_Grp.nagmts, .T., loc_cCodCor, loc_cCodTam)
                                ENDIF

                                SELECT cursor_4c_Resumo
                                IF loc_cOperacao = "E"
                                    REPLACE QtdeEnts  WITH QtdeEnts + cursor_4c_Esti2.qtds, ;
                                            PesoEnts  WITH PesoEnts + loc_nQtde, ;
                                            PesoFabre WITH PesoFabre + loc_nQtde
                                ELSE
                                    REPLACE QtdeSais  WITH QtdeSais + cursor_4c_Esti2.qtds, ;
                                            PesoSais  WITH PesoSais + loc_nQtde, ;
                                            PesoFabrs WITH PesoFabrs + loc_nQtde
                                ENDIF
                            ENDIF

                            IF loc_lDestino
                                IF !SEEK(loc_cGrupo + loc_cConta + cursor_4c_Esti2.cpros + ;
                                         loc_cCodCor + loc_cCodTam, "cursor_4c_Resumo")
                                    INSERT INTO cursor_4c_Resumo ;
                                           (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams) ;
                                    VALUES (loc_cGrupo, loc_cConta, cursor_4c_EestI.cpros, ;
                                            cursor_4c_Pro.cunis, cursor_4c_Pro.varias, ;
                                            cursor_4c_Grp.nagmts, .T., loc_cCodCor, loc_cCodTam)
                                ENDIF

                                SELECT cursor_4c_Resumo
                                IF loc_cOperacao = "E"
                                    REPLACE QtdeEnts  WITH QtdeEnts + cursor_4c_Esti2.qtds, ;
                                            PesoEnts  WITH PesoEnts + loc_nQtde, ;
                                            PesoFabre WITH PesoFabre + loc_nQtde
                                ELSE
                                    REPLACE QtdeSais  WITH QtdeSais + cursor_4c_Esti2.qtds, ;
                                            PesoSais  WITH PesoSais + loc_nQtde, ;
                                            PesoFabrs WITH PesoFabrs + loc_nQtde
                                ENDIF
                            ENDIF

                            SELECT cursor_4c_Esti2
                        ENDSCAN
                    ELSE
                        loc_nQtde = cursor_4c_EestI.qtds

                        IF loc_lOrigem
                            IF !SEEK(loc_cGrupo + loc_cConta + cursor_4c_EestI.cpros, "cursor_4c_Resumo")
                                INSERT INTO cursor_4c_Resumo ;
                                       (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel) ;
                                VALUES (loc_cGrupo, loc_cConta, cursor_4c_EestI.cpros, ;
                                        cursor_4c_EestI.cunis, cursor_4c_Pro.varias, ;
                                        cursor_4c_Grp.nagmts, .T.)
                            ENDIF

                            SELECT cursor_4c_Resumo
                            IF loc_cOperacao = "E"
                                REPLACE QtdeEnts  WITH QtdeEnts + cursor_4c_EestI.qtds, ;
                                        PesoEnts  WITH PesoEnts + loc_nQtde, ;
                                        PesoFabre WITH PesoFabre + loc_nQtde
                            ELSE
                                REPLACE QtdeSais  WITH QtdeSais + cursor_4c_EestI.qtds, ;
                                        PesoSais  WITH PesoSais + loc_nQtde, ;
                                        PesoFabrs WITH PesoFabrs + loc_nQtde
                            ENDIF
                        ENDIF

                        IF loc_lDestino
                            IF !SEEK(loc_cGrupo + loc_cConta + cursor_4c_EestI.cpros, "cursor_4c_Resumo")
                                INSERT INTO cursor_4c_Resumo ;
                                       (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel) ;
                                VALUES (loc_cGrupo, loc_cConta, cursor_4c_EestI.cpros, ;
                                        cursor_4c_Pro.cunis, cursor_4c_Pro.varias, ;
                                        cursor_4c_Grp.nagmts, .T.)
                            ENDIF

                            SELECT cursor_4c_Resumo
                            IF loc_cOperacao = "E"
                                REPLACE QtdeEnts  WITH QtdeEnts + cursor_4c_EestI.qtds, ;
                                        PesoEnts  WITH PesoEnts + loc_nQtde, ;
                                        PesoFabre WITH PesoFabre + loc_nQtde
                            ELSE
                                REPLACE QtdeSais  WITH QtdeSais + cursor_4c_EestI.qtds, ;
                                        PesoSais  WITH PesoSais + loc_nQtde, ;
                                        PesoFabrs WITH PesoFabrs + loc_nQtde
                            ENDIF
                        ENDIF
                    ENDIF

                    SELECT cursor_4c_EestI
                ENDSCAN

                SELECT cursor_4c_Eest
            ENDSCAN
            THIS.EncerrarBarra(loc_oBarra)

            SELECT cursor_4c_Resumo
            REPLACE Flag3 WITH .T. FOR Grupo + Conta = loc_cGrupo + loc_cConta

            *-- UnifBals = 1: consolida todos os materiais nao-agregados na
            *-- linha do material padrao (ouro) e esconde as demais
            IF cursor_4c_CdGcr.unifbals = 1
                loc_cMat = THIS.this_cOuros

                SELECT cursor_4c_Resumo
                IF !SEEK(loc_cGrupo + loc_cConta + loc_cMat)
                    APPEND BLANK
                    REPLACE CMats   WITH loc_cMat, ;
                            Grupo   WITH loc_cGrupo, ;
                            Conta   WITH loc_cConta, ;
                            Visivel WITH .T.
                ENDIF

                SELECT " " AS Agrupar, SUM(PesoEnts) AS pEnts, SUM(PesoSais) AS pSais ;
                  FROM cursor_4c_Resumo ;
                 WHERE Grupo + Conta = loc_cGrupo + loc_cConta ;
                   AND CMats <> loc_cMat AND Varias <> 1 AND Agregas <> 1 ;
                  INTO CURSOR cursor_4c_Total GROUP BY 1
                GO TOP IN cursor_4c_Total

                SELECT cursor_4c_Resumo
                = SEEK(loc_cGrupo + loc_cConta)
                SCAN WHILE Grupo + Conta = loc_cGrupo + loc_cConta
                    IF CMats = loc_cMat
                        REPLACE PesoEnts WITH PesoEnts + cursor_4c_Total.pEnts
                        REPLACE PesoSais WITH PesoSais + cursor_4c_Total.pSais
                        REPLACE QtdeEnts WITH QtdeEnts + cursor_4c_Total.pEnts
                        REPLACE QtdeSais WITH QtdeSais + cursor_4c_Total.pSais
                    ELSE
                        IF Agregas <> 1
                            REPLACE Visivel WITH .F., ;
                                    Flag3   WITH .F.
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

            *==================================================================
            * Saldo anterior gravado no fechamento (SigOpCfe)
            *==================================================================
            loc_cQuery = "SELECT * FROM SigOpCfe" + ;
                         " WHERE codigos = " + ;
                         FormatarNumeroSQL(TratarNulo(cursor_4c_Fecha.codigos, 0), 0) + ;
                         " AND emps = " + EscaparSQL(loc_cEmpresa) + ;
                         " ORDER BY codigos, cpros"
            IF !THIS.ExecutarConsulta(loc_cQuery, "cursor_4c_SaldoI", "CrSaldoI")
                RETURN .F.
            ENDIF

            SELECT cursor_4c_SaldoI
            INDEX ON cpros TAG cpros

            SELECT cursor_4c_Resumo
            loc_cMatAnt = SPACE(14)
            SET ORDER TO GrConMat
            = SEEK(loc_cGrupo + loc_cConta)
            SCAN WHILE Grupo + Conta = loc_cGrupo + loc_cConta
                STORE 0 TO loc_nSaldoi

                = SEEK(cursor_4c_Resumo.CMats, "cursor_4c_Pro", "cpros")
                IF !loc_lTipoQ AND cursor_4c_Resumo.CMats <> loc_cMatAnt
                    STORE 0 TO loc_nFalhaAdmitida
                    loc_cMatAnt = cursor_4c_Resumo.CMats
                ENDIF

                SELECT cursor_4c_SaldoI
                = SEEK(cursor_4c_Resumo.CMats)
                loc_nSaldoi = TratarNulo(cursor_4c_SaldoI.pesagems, 0)

                SELECT cursor_4c_Resumo
                REPLACE Saldoi  WITH loc_nSaldoi, ;
                        FReal   WITH loc_nSaldoi + cursor_4c_Resumo.QtdeEnts - ;
                                     cursor_4c_Resumo.QtdeSais - cursor_4c_Resumo.Pesagem, ;
                        FAdmin  WITH loc_nFalhaAdmitida, ;
                        Saldof  WITH loc_nSaldoi + cursor_4c_Resumo.QtdeEnts - ;
                                     cursor_4c_Resumo.QtdeSais - cursor_4c_Resumo.Pesagem - ;
                                     loc_nFalhaAdmitida, ;
                        PfTrabs WITH IIF(loc_nTrabalhado <> 0, ;
                                         (Saldof / loc_nTrabalhado * 100), 0)

                IF cursor_4c_Resumo.Saldof <> 0 AND ;
                   (TratarNulo(cursor_4c_CdCli.pagfals, 0) = 1 OR ;
                    TratarNulo(cursor_4c_CdCli.recfals, 0) = 1)
                    REPLACE Flag  WITH .T., ;
                            Flag2 WITH (TratarNulo(cursor_4c_CdCli.pagfals, 0) = 1 OR ;
                                        TratarNulo(cursor_4c_CdCli.recfals, 0) = 1) ;
                         IN cursor_4c_Resumo
                ENDIF
            ENDSCAN

            *-- Materiais que so aparecem no fechamento anterior (sem movimento
            *-- no periodo) tambem entram no resumo
            SELECT cursor_4c_SaldoI
            loc_cMatAnt = SPACE(14)
            SCAN
                IF TratarNulo(cursor_4c_SaldoI.pesagems, 0) = 0
                    LOOP
                ENDIF
                = SEEK(cursor_4c_SaldoI.cpros, "cursor_4c_Pro", "cpros")
                = SEEK(cursor_4c_Pro.cgrus, "cursor_4c_Grp", "cgrus")

                loc_nSaldoi = TratarNulo(cursor_4c_SaldoI.pesagems, 0)

                SELECT cursor_4c_Resumo
                LOCATE FOR Grupo + Conta + CMats = loc_cGrupo + loc_cConta + cursor_4c_SaldoI.cpros
                IF EOF()
                    INSERT INTO cursor_4c_Resumo ;
                           (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel) ;
                    VALUES (cursor_4c_Nens.grupoos, cursor_4c_Nens.contaos, ;
                            cursor_4c_SaldoI.cpros, cursor_4c_Pro.cunis, ;
                            cursor_4c_Pro.varias, cursor_4c_Grp.nagmts, .T.)

                    SELECT cursor_4c_Resumo
                    REPLACE Saldoi  WITH loc_nSaldoi, ;
                            FReal   WITH loc_nSaldoi + cursor_4c_Resumo.QtdeEnts - ;
                                         cursor_4c_Resumo.QtdeSais - cursor_4c_Resumo.Pesagem, ;
                            FAdmin  WITH 0, ;
                            Saldof  WITH loc_nSaldoi + cursor_4c_Resumo.QtdeEnts - ;
                                         cursor_4c_Resumo.QtdeSais - cursor_4c_Resumo.Pesagem - 0, ;
                            PfTrabs WITH 0
                ENDIF

                SELECT cursor_4c_SaldoI
            ENDSCAN

            *-- Acumula o saldo final do material analisado na grade do periodo
            *-- (lnCt = 2) ou na grade do saldo anterior (lnCt = 1)
            SELECT cursor_4c_Resumo
            = SEEK(loc_cGrupo + loc_cConta + loc_cCodMat)
            SCAN WHILE Grupo + Conta + CMats = loc_cGrupo + loc_cConta + loc_cCodMat
                IF loc_nCt = 2
                    IF !SEEK(loc_cGrupo, "cursor_4c_Saldos")
                        INSERT INTO cursor_4c_Saldos (Grupos, Contas, Emps) ;
                             VALUES (loc_cGrupo, loc_cConta, loc_cEmpresa)
                    ENDIF
                    REPLACE Qtde WITH cursor_4c_Saldos.Qtde + cursor_4c_Resumo.Saldof ;
                         IN cursor_4c_Saldos
                ELSE
                    IF !SEEK(loc_cGrupo, "cursor_4c_SaldoAnt")
                        INSERT INTO cursor_4c_SaldoAnt (Grupos, Contas, Emps) ;
                             VALUES (loc_cGrupo, loc_cConta, loc_cEmpresa)
                    ENDIF
                    REPLACE Qtde WITH cursor_4c_SaldoAnt.Qtde + cursor_4c_Resumo.Saldof ;
                         IN cursor_4c_SaldoAnt
                ENDIF

                SELECT cursor_4c_Resumo
            ENDSCAN
        ENDFOR

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * ResolverMaterialProducao - bloco "_Material" do Scan de producao do
    * Processar.Click legado. Le cursor_4c_CdGcr (ja posicionado no grupo pelo
    * chamador) + cursor_4c_CdNei/cursor_4c_Opi/cursor_4c_Pro.
    *
    * O chamador continua responsavel pelo "If cMats <> _Material / Loop" que
    * o legado faz logo depois - ele eh um LOOP do Scan do chamador e nao pode
    * viajar para dentro deste metodo.
    *==========================================================================
    PROTECTED FUNCTION ResolverMaterialProducao()
        LOCAL loc_cMaterial
        loc_cMaterial = SPACE(14)

        IF cursor_4c_CdGcr.unifbals = 4
            IF cursor_4c_CdNei.nops = 0
                loc_cMaterial = cursor_4c_CdNei.cmats
            ELSE
                = SEEK(cursor_4c_CdNei.nops, "cursor_4c_Opi", "nops")
                = SEEK(cursor_4c_Opi.cpros, "cursor_4c_Pro", "cpros")
                loc_cMaterial = IIF(EMPTY(cursor_4c_Pro.matprincs), ;
                                    THIS.this_cOuros, cursor_4c_Pro.matprincs)
            ENDIF
        ELSE
            IF cursor_4c_CdGcr.unifbals = 3
                = SEEK(cursor_4c_CdNei.nops, "cursor_4c_Opi", "nops")
                IF cursor_4c_CdNei.nops = 0
                    loc_cMaterial = cursor_4c_CdNei.cmats
                ELSE
                    = SEEK(cursor_4c_Opi.cpros, "cursor_4c_Pro", "cpros")
                    loc_cMaterial = IIF(EMPTY(cursor_4c_Pro.matprincs), ;
                                        THIS.this_cOuros, cursor_4c_Pro.matprincs)
                ENDIF
            ELSE
                loc_cMaterial = IIF(cursor_4c_CdGcr.unifbals = 1, ;
                                    THIS.this_cOuros, cursor_4c_CdNei.cmats)
            ENDIF
        ENDIF

        RETURN loc_cMaterial
    ENDFUNC

    *==========================================================================
    * ResolverMaterialEstoque - bloco "*** tiago" do Scan de estoque do
    * Processar.Click legado. Pressupoe cursor_4c_CdGcr posicionado no grupo e
    * cursor_4c_Pro posicionado no produto do item (o chamador faz os dois
    * SEEK, como no legado).
    *==========================================================================
    PROTECTED FUNCTION ResolverMaterialEstoque()
        LOCAL loc_cMaterial

        IF INLIST(cursor_4c_CdGcr.unifbals, 3, 4)
            loc_cMaterial = IIF(EMPTY(cursor_4c_Pro.matprincs), ;
                                THIS.this_cOuros, cursor_4c_Pro.matprincs)
        ELSE
            = SEEK(cursor_4c_Pro.cgrus, "cursor_4c_Grp", "cgrus")
            loc_cMaterial = IIF(cursor_4c_CdGcr.unifbals = 1 AND cursor_4c_Grp.nagmts <> 1, ;
                                THIS.this_cOuros, cursor_4c_MvItn.cpros)
        ENDIF

        IF cursor_4c_CdGcr.unifbals = 4 AND cursor_4c_MvItn.cpros <> loc_cMaterial
            loc_cMaterial = cursor_4c_MvItn.cpros
        ENDIF

        RETURN loc_cMaterial
    ENDFUNC

    *==========================================================================
    * ResolverMaterialNensI - bloco "_Material" do Scan de producao do
    * PROCEDURE posbalanco legado. Diferenca para ResolverMaterialProducao: o
    * cursor de itens eh cursor_4c_NensI (do PosBalanco) e a consulta ao
    * SigOpPic eh pontual por Nops, nao o cursor inteiro.
    *
    * O legado reaproveita o alias 'TmpOpi' para essa consulta pontual,
    * destruindo o indice do cursor carregado em Processar. Aqui a consulta vai
    * para um alias PROPRIO (cursor_4c_OpiPb): o resultado eh o mesmo - quando
    * PosBalanco roda, o Scan de producao de Processar ja terminou - e o cursor
    * indexado continua intacto.
    *==========================================================================
    PROTECTED FUNCTION ResolverMaterialNensI()
        LOCAL loc_cMaterial, loc_cQuery
        loc_cMaterial = SPACE(14)

        IF cursor_4c_CdGcr.unifbals = 4
            IF cursor_4c_NensI.nops = 0
                loc_cMaterial = cursor_4c_NensI.cmats
            ELSE
                loc_cQuery = "SELECT cpros FROM SigOpPic WHERE nops = " + ;
                             FormatarNumeroSQL(TratarNulo(cursor_4c_NensI.nops, 0), 0)
                = THIS.ExecutarConsulta(loc_cQuery, "cursor_4c_OpiPb", "TmpOpi")
                = SEEK(cursor_4c_OpiPb.cpros, "cursor_4c_Pro", "cpros")
                loc_cMaterial = IIF(EMPTY(cursor_4c_Pro.matprincs), ;
                                    THIS.this_cOuros, cursor_4c_Pro.matprincs)
            ENDIF
        ELSE
            IF cursor_4c_CdGcr.unifbals = 3
                loc_cQuery = "SELECT cpros FROM SigOpPic WHERE nops = " + ;
                             FormatarNumeroSQL(TratarNulo(cursor_4c_NensI.nops, 0), 0)
                = THIS.ExecutarConsulta(loc_cQuery, "cursor_4c_OpiPb", "TmpOpi")
                IF cursor_4c_NensI.nops = 0
                    loc_cMaterial = cursor_4c_NensI.cmats
                ELSE
                    = SEEK(cursor_4c_OpiPb.cpros, "cursor_4c_Pro", "cpros")
                    loc_cMaterial = IIF(EMPTY(cursor_4c_Pro.matprincs), ;
                                        THIS.this_cOuros, cursor_4c_Pro.matprincs)
                ENDIF
            ELSE
                loc_cMaterial = IIF(cursor_4c_CdGcr.unifbals = 1, ;
                                    THIS.this_cOuros, cursor_4c_NensI.cmats)
            ENDIF
        ENDIF

        RETURN loc_cMaterial
    ENDFUNC

    *==========================================================================
    * ExecutarConsulta - SQLEXEC + a mensagem de aborto do legado
    *
    * O legado repete 15 vezes o par:
    *   If (ThisForm.poDataMgr.SqlExecute(lcQuery, '<alias>') < 1)
    *       =MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na
    *                    Conexao (<alias>)') / Return 0
    * par_cAliasLegado preserva o nome do cursor do legado NA MENSAGEM, para o
    * usuario continuar vendo o mesmo texto que via antes (PILAR 1).
    *
    * Fecha o alias antes de reexecutar: sem isso o segundo SQLEXEC sobre um
    * cursor que ainda tem edicao no buffer falha com "Table buffer contains
    * uncommitted changes".
    *==========================================================================
    PROTECTED FUNCTION ExecutarConsulta(par_cQuery, par_cCursor, par_cAliasLegado)
        LOCAL loc_nResultado

        IF USED(par_cCursor)
            TABLEREVERT(.T., par_cCursor)
            USE IN (par_cCursor)
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, par_cQuery, par_cCursor)

        IF loc_nResultado < 1
            MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CHR(13) + ;
                    CapturarErroSQL(), ;
                    "Falha na Conex" + CHR(227) + "o (" + par_cAliasLegado + ")")
            RETURN .F.
        ENDIF

        SELECT (par_cCursor)
        GO TOP

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * LimparCursoresResultado - "Zap In Saldos / SaldoAnt / Falhas / Entradas /
    * Saidas" do inicio de Processar.Click.
    *
    * ZAP (e nao USE IN + CREATE CURSOR) de proposito: fechar e recriar o alias
    * derrubaria o RecordSource/ControlSource que as grades do Resultado ja
    * receberam, e a grade ficaria vazia com o cursor cheio.
    *==========================================================================
    PROTECTED PROCEDURE LimparCursoresResultado()
        THIS.ZaparCursor("cursor_4c_Saldos")
        THIS.ZaparCursor("cursor_4c_SaldoAnt")
        THIS.ZaparCursor("cursor_4c_Falhas")
        THIS.ZaparCursor("cursor_4c_Entradas")
        THIS.ZaparCursor("cursor_4c_Saidas")
    ENDPROC

    *==========================================================================
    * ZaparCursor - ZAP com SET SAFETY desligado
    *
    * SET SAFETY eh ESCOPADO POR DATA SESSION: o form eh DataSession = 2
    * (privada) e nasce com SAFETY ON, mesmo com o SET SAFETY OFF do main.prg.
    * Com SAFETY ON o ZAP abre o dialogo modal "Zap ... Are you sure?" e a tela
    * CONGELA esperando um clique que ninguem ve.
    *==========================================================================
    PROTECTED PROCEDURE ZaparCursor(par_cCursor)
        LOCAL loc_cSafety, loc_cAliasAnterior

        IF !USED(par_cCursor)
            RETURN
        ENDIF

        loc_cAliasAnterior = ALIAS()
        loc_cSafety        = SET("SAFETY")

        SET SAFETY OFF
        SELECT (par_cCursor)
        ZAP
        IF loc_cSafety = "ON"
            SET SAFETY ON
        ENDIF

        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF
    ENDPROC

    *==========================================================================
    * CriarBarra / AtualizarBarra / EncerrarBarra - feedback de progresso
    *
    * Equivale ao loBarra = CreateObject('fwprogressbar', <titulo>, Reccount())
    * + .Show / .UpDate(.t.) / .Complete que o legado repete nos 6 Scan longos.
    * par_lDeslocar reproduz o "loBarrap.Top = loBarrap.Top + Int(Height/2)" que
    * o legado usa nas barras internas do PosBalanco, para nao cobrir a de fora.
    *
    * Em modo de teste (gb_4c_ModoTeste) nao cria janela nenhuma: o pipeline
    * roda sem supervisao e barra de progresso nao pode segurar a execucao.
    *==========================================================================
    PROTECTED FUNCTION CriarBarra(par_cTitulo, par_nTotal, par_lDeslocar)
        LOCAL loc_oBarra, loc_oErro
        loc_oBarra = .NULL.

        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN .NULL.
        ENDIF

        TRY
            loc_oBarra = CREATEOBJECT("fwprogressbar", par_cTitulo, par_nTotal)
            IF VARTYPE(loc_oBarra) = "O"
                IF VARTYPE(par_lDeslocar) = "L" AND par_lDeslocar
                    loc_oBarra.Top = loc_oBarra.Top + INT(loc_oBarra.Height / 2)
                ENDIF
                loc_oBarra.Show()
            ENDIF
        CATCH TO loc_oErro
            *-- Sem barra o processamento continua: ela eh so feedback visual
            loc_oBarra = .NULL.
        ENDTRY

        RETURN loc_oBarra
    ENDFUNC

    PROTECTED PROCEDURE AtualizarBarra(par_oBarra)
        IF VARTYPE(par_oBarra) = "O"
            par_oBarra.Update(.T.)
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE EncerrarBarra(par_oBarra)
        IF VARTYPE(par_oBarra) = "O"
            par_oBarra.Complete(.T.)
            par_oBarra.Release()
        ENDIF
    ENDPROC

ENDDEFINE
