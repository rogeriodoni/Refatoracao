*==============================================================================
* SigPrGlpBO.prg - Business Object para Pr&#233;via da Globaliza&#231;&#227;o / Reserva
* Herda de: BusinessBase
* Entidade: SigPrGlp
* Tabela principal: (OPERACIONAL - sem tabela CRUD &#250;nica)
*==============================================================================
DEFINE CLASS SigPrGlpBO AS BusinessBase

    *-- Identificacao da entidade (OPERACIONAL: sem tabela CRUD unica)
    this_cTabela     = ""
    this_cCampoChave = ""

    *-- Conexoes legadas (equivalentes a poDataMgr e poDataTmp do legado)
    this_oDataMgr = .NULL.
    this_oDataTmp = .NULL.

    *-- Flags de modo de operacao
    this_lReserva    = .F.    && .T. = Reserva Automatica; .F. = Globalizacao
    this_lAutomatico = .F.    && modo automatico de globalizacao

    *-- Parametros recebidos pelo Init do legado
    this_nNumerodaop = 0      && numero da ordem de producao (0 = gerar automatico)
    this_cEmphpdr    = ""     && empresa preferida para globalizacao
    this_cSigKey     = ""     && chave de assinatura (CrSigCdPac.sigKeys)

    *-- Referencia ao form pai (equivalente a ParentForm do legado)
    this_oParentForm = .NULL.

    *-- Rastreamento de valor anterior nas celulas do grid (validacao)
    this_nOldValue = 0        && valor antigo em GradeItens.Column6 (Produzir)
    this_nAntValue = 0        && valor anterior em GradePedra.Column5 (Cpro2s)

    *-- Totalizadores exibidos nos campos Tot_Qtd / Tot_Est / Tot_Prz
    this_nTotQtd = 0          && soma de TmpFinal.Saldo
    this_nTotEst = 0          && soma de TmpFinal.Estoque
    this_nTotPrz = 0          && soma de TmpFinal.Produzir

    *-- Estado dos botoes flutuantes (controles de visibilidade dos containers)
    this_lDisponiveisAberto = .F.    && Container2 visivel (GradeDisp por produto)
    this_lEstoquesAberto    = .F.    && Container5 visivel (GradeDisp por conta/grupo)
    this_lLinhasAberto      = .F.    && Container1 visivel (GradeLinhas)
    this_lRequisicoesAberto = .F.    && Container4 visivel (GradePedra)

    *-- Dados do registro corrente do GradeItens (produto em foco)
    this_cCPros    = ""    && codigo do produto atual
    this_cCodCors  = ""    && codigo da cor atual
    this_cCodTams  = ""    && codigo do tamanho atual
    this_cDopes    = ""    && operacao atual
    this_nNumes    = 0     && numero da OP atual
    this_nSaldo    = 0     && saldo pedido (TmpFinal.Saldo)
    this_nEstoque  = 0     && estoque disponivel (TmpFinal.Estoque)
    this_nProduzir = 0     && quantidade a produzir (TmpFinal.Produzir)
    this_cObsps    = ""    && observacao do item (TmpFinal.Obsps)
    this_cLinhas   = ""    && linha de producao (TmpFinal.Linhas)
    this_cReffs    = ""    && referencia (TmpFinal.Reffs)
    this_cNotas    = ""    && nota fiscal origem (TmpFinal.Notas)
    this_cGrupoDs  = ""    && grupo de destino (TmpFinal.GrupoDs)
    this_cContaDs  = ""    && conta de destino (TmpFinal.ContaDs)
    this_dDatas    = {}    && data da movimentacao (TmpFinal.Datas)
    this_cEmps     = ""    && empresa (TmpFinal.Emps)
    this_cCitens   = ""    && codigo do item (TmpFinal.Citens)
    this_cJobs     = ""    && job vinculado (TmpFinal.Jobs)

    *-- Dados do registro corrente do Container5/GradeDisp (disponibilidade por conta/grupo)
    this_cGrupoDisp = ""   && grupo no grid de disponibilidade (TmpDisp.Grupos)
    this_cEstoDisp  = ""   && estoque no grid de disponibilidade (TmpDisp.Estos)
    this_nPriorDisp = 0    && prioridade (TmpDisp.Priors)
    this_nDispsDisp = 0    && quantidade disponivel (TmpDisp.Disps)
    this_nUtilizarDisp = 0 && quantidade a utilizar (TmpDisp.Utilizar)
    this_cDscGrupo  = ""   && descricao do grupo (lookup SigCdGcr.Descrs)
    this_cDscConta  = ""   && descricao da conta (lookup SigCdCli.Rclis)

    *-- Dados do Container4/GradePedra (requisicoes de componentes adicionais)
    this_cCPros2    = ""   && codigo do produto pedra (SelPedra.Cpros)
    this_cDPros2    = ""   && descricao do produto pedra (SelPedra.Dpros)
    this_cCunis2    = ""   && unidade do produto pedra (SelPedra.Cunis)
    this_nQtds2     = 0    && quantidade pedra (SelPedra.Qtds)
    this_cCpro2s    = ""   && codigo secundario (SelPedra.Cpro2s)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
    *--------------------------------------------------------------------------
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
    *--------------------------------------------------------------------------
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAlias)
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAlias)
                THIS.this_cCPros    = EVALUATE(par_cAlias + ".Cpros")
                THIS.this_cCodCors  = EVALUATE(par_cAlias + ".CodCors")
                THIS.this_cCodTams  = EVALUATE(par_cAlias + ".CodTams")
                THIS.this_cDopes    = EVALUATE(par_cAlias + ".Dopes")
                THIS.this_nNumes    = EVALUATE(par_cAlias + ".Numes")
                THIS.this_nSaldo    = EVALUATE(par_cAlias + ".Saldo")
                THIS.this_nEstoque  = EVALUATE(par_cAlias + ".Estoque")
                THIS.this_nProduzir = EVALUATE(par_cAlias + ".Produzir")
                THIS.this_cObsps    = EVALUATE(par_cAlias + ".Obsps")
                THIS.this_cLinhas   = EVALUATE(par_cAlias + ".Linhas")
                THIS.this_cReffs    = EVALUATE(par_cAlias + ".Reffs")
                THIS.this_cNotas    = EVALUATE(par_cAlias + ".Notas")
                THIS.this_cGrupoDs  = EVALUATE(par_cAlias + ".GrupoDs")
                THIS.this_cContaDs  = EVALUATE(par_cAlias + ".ContaDs")
                THIS.this_dDatas    = EVALUATE(par_cAlias + ".Datas")
                THIS.this_cEmps     = EVALUATE(par_cAlias + ".Emps")
                THIS.this_cCitens   = EVALUATE(par_cAlias + ".Citens")
                THIS.this_cJobs     = EVALUATE(par_cAlias + ".Jobs")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE AtualizarTotais()
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_nRecno, loc_nSal, loc_nEst, loc_nPrz
        loc_lSucesso = .F.
        TRY
            SELECT TmpFinal
            loc_nRecno = RECNO()
            SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
            GO loc_nRecno
            THIS.this_nTotQtd = loc_nSal
            THIS.this_nTotEst = loc_nEst
            THIS.this_nTotPrz = loc_nPrz
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE AtualizarInfoItem(par_nColIndex)
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, 'TmpSaldo')
            SELECT TmpSaldG
            SET ORDER TO Cpros
            SET KEY TO TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams
            GO TOP
            THIS.this_nSaldo    = TmpSaldo.Saldo
            THIS.this_nEstoque  = TmpSaldo.Saldo - TmpSaldo.Disps
            THIS.this_nProduzir = TmpSaldo.Disps
            THIS.this_cCPros    = TmpFinal.Cpros
            THIS.this_cCodCors  = TmpFinal.CodCors
            THIS.this_cCodTams  = TmpFinal.CodTams
            THIS.CursorQuery('SigCdCli', 'TmpConta', 'Iclis', TmpSaldG.Estos, 'Rclis')
            THIS.CursorQuery('SigCdGcr', 'TmpGrupo', 'Codigos', TmpSaldG.Grupos, 'Descrs')
            THIS.this_cDscGrupo = IIF(USED('TmpGrupo') .AND. .NOT. EOF('TmpGrupo'), TmpGrupo.Descrs, "")
            THIS.this_cDscConta = IIF(USED('TmpConta') .AND. .NOT. EOF('TmpConta'), TmpConta.RClis, "")
            SELECT TmpFinal
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE AtualizarInfoDisponivelConta(par_nColIndex)
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.CursorQuery('SigCdCli', 'TmpConta', 'Iclis', TmpDisp.Estos, 'Rclis')
            THIS.CursorQuery('SigCdGcr', 'TmpGrupo', 'Codigos', TmpDisp.Grupos, 'Descrs')
            THIS.this_cDscGrupo = IIF(USED('TmpGrupo') .AND. .NOT. EOF('TmpGrupo'), TmpGrupo.Descrs, "")
            THIS.this_cDscConta = IIF(USED('TmpConta') .AND. .NOT. EOF('TmpConta'), TmpConta.RClis, "")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE AtualizarInfoContainer3(par_nColIndex)
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.CursorQuery('SigCdCli', 'TmpConta', 'Iclis', TmpSaldG.Estos, 'Rclis')
            THIS.CursorQuery('SigCdGcr', 'TmpGrupo', 'Codigos', TmpSaldG.Grupos, 'Descrs')
            THIS.this_cDscGrupo = IIF(USED('TmpGrupo') .AND. .NOT. EOF('TmpGrupo'), TmpGrupo.Descrs, "")
            THIS.this_cDscConta = IIF(USED('TmpConta') .AND. .NOT. EOF('TmpConta'), TmpConta.RClis, "")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ValidarProduzir(par_nNovoValor)
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_lAbort, loc_xBaixa
        loc_lSucesso = .T.
        loc_lAbort   = .F.
        TRY
            IF NOT SEEK(TmpFinal.Cpros, 'TmpSaldU', 'Cpros')
                INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
            ENDIF
            IF par_nNovoValor <> THIS.this_nOldValue .AND. TmpSaldU.KeySelm
                IF NOT MsgConfirma('Produto com Sele' + CHR(231) + CHR(227) + 'o Manual de estoque. ' + CHR(13) + ;
                    'O sistema ir' + CHR(225) + ' acionar o modo autom' + CHR(225) + 'tico. Deseja Continuar?')
                    loc_lAbort = .T.
                ENDIF
            ENDIF
            IF NOT loc_lAbort
                DO CASE
                    CASE par_nNovoValor = THIS.this_nOldValue
                        *-- nenhuma acao
                    CASE par_nNovoValor < 0
                        MsgAviso('A Quantidade a Produzir N' + CHR(227) + 'o Pode Ser Um Valor Negativo!!!', '')
                        loc_lAbort = .T.
                    CASE par_nNovoValor > TmpFinal.Saldo
                        MsgAviso('A Quantidade a Produzir N' + CHR(227) + 'o Pode Ser Maior Que a Quantidade Da Opera' + CHR(231) + CHR(227) + 'o!!!', '')
                        par_nNovoValor = TmpFinal.Saldo - TmpFinal.Estoque
                        loc_lAbort = .T.
                    CASE NOT SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, 'TmpSaldo') .AND. ;
                            (TmpFinal.Produzir <> TmpFinal.Saldo)
                        MsgAviso('N' + CHR(227) + 'o H' + CHR(225) + ' Saldo Dispon' + CHR(237) + 'vel Deste Produto No Estoque Para Reservar!!!', '')
                        par_nNovoValor = TmpFinal.Saldo
                        loc_lAbort = .T.
                    OTHERWISE
                        IF TmpSaldo.Disps + TmpFinal.Estoque >= TmpFinal.Saldo - par_nNovoValor
                            REPLACE TmpSaldo.Disps   WITH TmpSaldo.Disps + TmpFinal.Estoque - (TmpFinal.Saldo - TmpFinal.Produzir) IN TmpSaldo
                            REPLACE TmpFinal.Estoque WITH TmpFinal.Saldo - par_nNovoValor IN TmpFinal
                            REPLACE KeySelm WITH .F. IN TmpSaldU
                            SELECT TmpSaldo
                            loc_xBaixa = Saldo - Disps
                            SELECT TmpSaldG
                            SET ORDER TO Cpros
                            =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
                            REPLACE Disps WITH Saldo WHILE Cpros = TmpSaldo.Cpros AND CodCors = TmpSaldo.CodCors AND CodTams = TmpSaldo.CodTams
                            =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
                            SCAN WHILE Cpros = TmpSaldo.Cpros AND CodCors = TmpSaldo.CodCors AND CodTams = TmpSaldo.CodTams AND loc_xBaixa > 0
                                IF TmpSaldG.Disps >= loc_xBaixa
                                    REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - loc_xBaixa
                                    loc_xBaixa = 0
                                ELSE
                                    loc_xBaixa = loc_xBaixa - TmpSaldG.Disps
                                    REPLACE TmpSaldG.Disps WITH 0
                                ENDIF
                            ENDSCAN
                        ELSE
                            MsgAviso('N' + CHR(227) + 'o H' + CHR(225) + ' Saldo Dispon' + CHR(237) + 'vel Deste Produto No Estoque Para Reservar!!!', '')
                            par_nNovoValor = THIS.this_nOldValue
                            loc_lAbort = .T.
                        ENDIF
                ENDCASE
            ENDIF
            THIS.this_nProduzir = par_nNovoValor
            loc_lSucesso = NOT loc_lAbort
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BuscarDisponivel(par_cCpro, par_cCor)
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED('TmpDisp')
                USE IN TmpDisp
            ENDIF
            SELECT Cpros, CodCors, CodTams, Disps, 000000000.000 AS Utilizar ;
              FROM TmpSaldo ;
             WHERE Cpros = par_cCpro AND CodCors = par_cCor AND Disps > 0 ;
             ORDER BY Cpros, CodCors, CodTams ;
              INTO CURSOR TmpDisp READWRITE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BuscarPorLinhas()
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            SELECT Linhas, 0 AS Ordem, SUM(Saldo) AS Saldo, SUM(Estoque) AS Estoque, SUM(Produzir) AS Produzir ;
              FROM TmpFinal ;
             GROUP BY 1 ;
             UNION ALL ;
            SELECT PADR('TOTAIS', 10) AS Linhas, 1 AS Ordem, SUM(Saldo) AS Saldo, SUM(Estoque) AS Estoque, SUM(Produzir) AS Produzir ;
              FROM TmpFinal ;
             GROUP BY 1 ;
              INTO CURSOR TmpLinha ;
             ORDER BY 2, 1
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BuscarEstoqueDetalhado(par_cCpro, par_cCor, par_cTam)
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED('TmpDisp')
                USE IN TmpDisp
            ENDIF
            SELECT Priors, Grupos, Estos, Cpros, CodCors, CodTams, Disps, 000000000.000 AS Utilizar ;
              FROM TmpSaldG WHERE Cpros = par_cCpro AND CodCors = par_cCor AND CodTams = par_cTam AND Disps > 0 ;
              INTO CURSOR Resultado ORDER BY 1, 2, 3, 4
            SELECT 0
            USE DBF('Resultado') ALIAS TmpDisp AGAIN
            USE IN Resultado
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ConfirmarDisponivel()
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_nQtdUti, loc_nQtUtil
        loc_lSucesso = .F.
        TRY
            SELECT TmpDisp
            SUM Utilizar TO loc_nQtdUti
            IF loc_nQtdUti > 0
                SELECT TmpDisp
                SCAN
                    IF Utilizar = 0
                        LOOP
                    ENDIF
                    loc_nQtUtil = Utilizar
                    =SEEK(TmpDisp.CPros + TmpDisp.CodCors + TmpDisp.CodTams, 'TmpSaldo')
                    SELECT TmpFinal
                    REPLACE Produzir WITH Produzir - loc_nQtUtil IN TmpFinal
                    REPLACE Estoque  WITH TmpFinal.Saldo - Produzir IN TmpFinal
                    SELECT TmpSaldo
                    REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps - loc_nQtUtil
                    IF NOT SEEK(TmpFinal.Cpros, 'TmpSaldU', 'Cpros')
                        INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
                    ENDIF
                    REPLACE KeySelm WITH .T. IN TmpSaldU
                    SELECT TmpSaldG
                    SET ORDER TO Cpros
                    =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams + STR(TmpDisp.Priors, 2) + TmpDisp.Grupos + TmpDisp.Estos)
                    REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - loc_nQtUtil
                ENDSCAN
                =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, 'TmpSaldo')
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ConfirmarDisponivelSimples()
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_nQtdUti, loc_nQtUtil, loc_xBaixa, loc_xReser
        LOCAL loc_lcEdn, loc_lcQuery, loc_pQtd, loc_pAqt, loc_pIds
        LOCAL loc_lScanAbort
        loc_lSucesso = .F.
        TRY
            SELECT TmpFinal
            loc_nRegFinal = RECNO()
            SELECT TmpDisp
            SUM Utilizar TO loc_nQtdUti
            IF loc_nQtdUti > 0
                SELECT TmpFinal
                =AFIELDS(loc_aFldsFinal)
                CREATE CURSOR Temporario FROM ARRAY loc_aFldsFinal
                loc_lScanAbort = .F.
                SELECT TmpDisp
                SCAN
                    IF Utilizar = 0
                        LOOP
                    ENDIF
                    loc_nQtUtil = Utilizar
                    =SEEK(TmpDisp.CPros + TmpDisp.CodCors + TmpDisp.CodTams, 'TmpSaldo')
                    SELECT TmpFinal
                    SCATTER TO MEMVAR
                    SELECT Temporario
                    APPEND FROM ARRAY MEMVAR
                    REPLACE Saldo    WITH loc_nQtUtil, ;
                            CodTams  WITH TmpDisp.CodTams, ;
                            Estoque  WITH loc_nQtUtil, ;
                            Produzir WITH 0 IN Temporario
                    REPLACE Saldo    WITH TmpFinal.Saldo - loc_nQtUtil IN TmpFinal
                    REPLACE Produzir WITH TmpFinal.Produzir - loc_nQtUtil IN TmpFinal
                    REPLACE Disps    WITH TmpSaldo.Disps - loc_nQtUtil IN TmpSaldo
                    loc_xBaixa = TmpSaldo.Saldo - TmpSaldo.Disps
                    SELECT TmpSaldG
                    SET ORDER TO Cpros
                    =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
                    REPLACE Disps WITH Saldo WHILE Cpros = TmpSaldo.Cpros AND CodCors = TmpSaldo.CodCors AND CodTams = TmpSaldo.CodTams
                    =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
                    SCAN WHILE Cpros = TmpSaldo.Cpros AND CodCors = TmpSaldo.CodCors AND CodTams = TmpSaldo.CodTams AND loc_xBaixa > 0
                        IF TmpSaldG.Disps >= loc_xBaixa
                            REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - loc_xBaixa
                            loc_xBaixa = 0
                        ELSE
                            loc_xBaixa = loc_xBaixa - TmpSaldG.Disps
                            REPLACE TmpSaldG.Disps WITH 0
                        ENDIF
                    ENDSCAN
                    loc_lcEdn = TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes, 6)
                    loc_lcQuery = "SELECT * FROM SigMvIts WHERE EmpDopNums = '" + ALLTRIM(loc_lcEdn) + "'" + ;
                                  " AND CPros = '" + ALLTRIM(TmpFinal.Cpros) + "'"
                    IF SQLEXEC(gnConnHandle, loc_lcQuery, 'TempEsti2') < 1
                        MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (TempEsti2 - 3)")
                        loc_lScanAbort = .T.
                        EXIT
                    ENDIF
                    SELECT TempEsti2
                    SCAN
                        IF CItens <> TmpFinal.Citens
                            LOOP
                        ENDIF
                        IF CodCors = TmpFinal.CodCors AND CodTams = SPACE(4)
                            SCATTER TO MEMVAR
                            loc_pQtd = loc_nQtUtil
                            loc_pAqt = Qtds
                            loc_pIds = TempEsti2.cIdChaves
                            loc_lcQuery = "UPDATE SigMvIts SET CodTams = '" + ALLTRIM(TmpDisp.CodTams) + "'," + ;
                                          " Qtds = ?loc_pQtd, AQtds = ?loc_pAqt WHERE cIdChaves = ?loc_pIds"
                            IF SQLEXEC(gnConnHandle, loc_lcQuery) < 1
                                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Update - 9)")
                                loc_lScanAbort = .T.
                                EXIT
                            ENDIF
                            SELECT crSigMvIts
                            APPEND FROM ARRAY MEMVAR
                            REPLACE Qtds  WITH Qtds - loc_nQtUtil
                            REPLACE Aqtds WITH Qtds
                            REPLACE cIdChaves WITH fUniqueIds()
                            IF Qtds = 0
                                DELETE
                            ENDIF
                            EXIT
                        ENDIF
                    ENDSCAN
                    IF loc_lScanAbort
                        EXIT
                    ENDIF
                ENDSCAN
                IF NOT loc_lScanAbort
                    SELECT TmpFinal
                    IF TmpFinal.Saldo = 0
                        DELETE
                    ENDIF
                    SELECT TmpFinal
                    APPEND FROM DBF('Temporario')
                    GO loc_nRegFinal
                    =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, 'TmpSaldo')
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE GerarRelatorio()
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_lcQuery
        loc_lSucesso = .F.
        TRY
            SELECT Cpros, SPACE(50) AS DPros, CodCors, CodTams, Dopes, Numes, ;
                   Saldo, Estoque, Produzir, IIF(EMPTY(TmpFinal.Obsps), ' ', '*') AS ObsPs ;
              FROM TmpFinal ;
             ORDER BY Cpros, CodCors, CodTams, Dopes, Numes ;
              INTO CURSOR crImpressao READWRITE
            GO TOP IN crImpressao
            IF EOF('crImpressao')
                MsgAviso('N' + CHR(227) + 'o Existem Dados Para Impress' + CHR(227) + 'o do Relat' + CHR(243) + 'rio!!!', 'Aten' + CHR(231) + CHR(227) + 'o!!!')
            ELSE
                SELECT DISTINCT Cpros FROM crImpressao INTO CURSOR LocalProds
                SELECT LocalProds
                SCAN
                    loc_lcQuery = "SELECT CPros, DPros FROM SigCdPro WHERE Cpros = '" + ALLTRIM(LocalProds.CPros) + "'"
                    IF SQLEXEC(gnConnHandle, loc_lcQuery, 'LocalBus') > 0
                        GO TOP IN LocalBus
                        IF NOT EOF('LocalBus')
                            UPDATE crImpressao SET DPros = LocalBus.DPros WHERE CPros = LocalBus.CPros
                        ENDIF
                    ENDIF
                ENDSCAN
                SELECT crImpressao
                GO TOP IN crImpressao
                REPORT FORM SigReGlp PREVIEW NOCONSOLE
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE AtualizarPeso()
    *--------------------------------------------------------------------------
        LOCAL loc_cCompo, loc_nTotQtd, loc_lcQuery, loc_lnFator
        loc_cCompo  = ALIAS()
        loc_nTotQtd = 0
        TRY
            IF crSigCdPam.AutComps <> 1
                SELECT (loc_cCompo)
                SCAN
                    SELECT crSigCdCom
                    GO TOP IN crSigCdCom
                    LOCATE FOR CGrus = &loc_cCompo..CGrus AND Custos = 1
                    IF NOT EOF('crSigCdCom')
                        loc_lcQuery = "SELECT a.cUnis, a.cUnips, b.BPesos" + ;
                                      " FROM SigCdPro a, SigCdGrp b" + ;
                                      " WHERE a.CPros = '" + ALLTRIM(&loc_cCompo..Mats) + "'" + ;
                                      " AND a.CGrus = b.CGrus"
                        IF SQLEXEC(gnConnHandle, loc_lcQuery, 'crSomaGru') < 1
                            MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (crSomaGru - 1)")
                        ELSE
                            GO TOP IN crSomaGru
                            IF INLIST(crSomaGru.BPesos, 1, 3)
                                loc_lcQuery = "SELECT Fators FROM SigCdUni WHERE Cunis = '" + ;
                                              ALLTRIM(IIF(CrSomaGru.BPesos = 1, CrSomaGru.Cunis, CrSomaGru.CUnips)) + "'"
                                IF SQLEXEC(gnConnHandle, loc_lcQuery, 'LocalUni') > 0
                                    loc_lnFator = IIF(LocalUni.Fators = 0, 1, LocalUni.Fators)
                                ELSE
                                    loc_lnFator = 1
                                ENDIF
                                SELECT (loc_cCompo)
                                loc_nTotQtd = loc_nTotQtd + IIF(CrSomaGru.BPesos = 1, &loc_cCompo..Qtds, &loc_cCompo..Pesos) * loc_lnFator
                            ENDIF
                        ENDIF
                    ENDIF
                ENDSCAN
                SELECT (loc_cCompo)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_nTotQtd
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE GravaHistorico()
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_nRegistro, loc_nReservado, loc_nInicio
        LOCAL loc_nRerSeq, loc_nIniSeq, loc_lcSql, loc_cNewOpe
        loc_lSucesso = .F.
        TRY
            SELECT Dopes, Estoqs, Origems, Destinos, EstOrigs, EstDests FROM CrSigCdOpe ;
             WHERE 0=1 INTO CURSOR LocalOpe READWRITE

            SELECT DISTINCT Dopes FROM CrSigMvHst INTO CURSOR SelOperacao
            SELECT SelOperacao
            SCAN
                loc_lcSql = "SELECT Dopes,Estoqs,Origems,Destinos,EstOrigs,EstDests FROM SigCdOpe" + ;
                            " WHERE Dopes = '" + ALLTRIM(SelOperacao.Dopes) + "'"
                IF SQLEXEC(gnConnHandle, loc_lcSql, 'xTmpOpe') > 0
                    SELECT LocalOpe
                    APPEND FROM DBF('xTmpOpe')
                ENDIF
            ENDSCAN
            SELECT LocalOpe
            INDEX ON Dopes TAG dopes

            SELECT SelOperacao
            SCAN
                loc_lcSql = "SELECT Dopps AS Dopes, 1 AS Estoqs, Origems, Destinos, EstOrigs, EstDests FROM SigCdOpd" + ;
                            " WHERE Dopps = '" + ALLTRIM(SelOperacao.Dopes) + "'"
                IF SQLEXEC(gnConnHandle, loc_lcSql, 'xTmpOpe') > 0
                    SELECT LocalOpe
                    APPEND FROM DBF('xTmpOpe')
                ENDIF
            ENDSCAN

            WAIT WINDOW 'Criando Chaves Prim' + CHR(225) + 'rias no Arquivo de Hist' + CHR(243) + 'rico ' NOWAIT
            SELECT crSigMvHst
            GO TOP
            loc_nRegistro  = RECCOUNT()
            loc_nReservado = 0
            DO WHILE loc_nReservado = 0 AND loc_nRegistro > 0
                loc_nReservado = fGerUniqueKey(DTOS(Datas), , , loc_nRegistro + 1)
            ENDDO
            loc_nInicio = loc_nReservado - loc_nRegistro

            loc_nRerSeq = 0
            DO WHILE loc_nRerSeq = 0 AND loc_nRegistro > 0
                loc_nRerSeq = fGerUniqueKey('HISTBAR', , , loc_nRegistro + 1)
            ENDDO
            loc_nIniSeq = loc_nRerSeq - loc_nRegistro

            SCAN
                loc_nInicio = loc_nInicio + 1
                loc_nIniSeq = loc_nIniSeq + 1
                loc_cNewOpe = CrSigMvHst.Opers
                REPLACE CidChaves WITH DTOS(Datas) + loc_cNewOpe + TRANSFORM(loc_nInicio, "@L 999999") + THIS.this_cSigKey, ;
                        Seqs      WITH loc_nIniSeq
                =fRecalculaP(crSigMvHst.Emps, crSigMvHst.Grupos, crSigMvHst.Estos, crSigMvHst.CPros, crSigMvHst.Datas, crSigMvHst.CodCors, crSigMvHst.CodTams)
                =fRecalculaC(crSigMvHst.Emps, crSigMvHst.CPros, crSigMvHst.Datas)
            ENDSCAN
            WAIT CLEAR
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Processar(par_dPrev, par_dGera)
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_llErro, loc_lTransAberta, loc_lScanAbort
        LOCAL loc__Dopp, loc__Nump, loc__Dope, loc__Seqs, loc__CPros, loc__Reff, loc__Cor, loc__Tam
        LOCAL loc__Prev, loc__DtGera, loc__TProd, loc__TPeso, loc__Clinha, loc__Nota
        LOCAL loc__GrupoD, loc__ContaD, loc__Numpe, loc__NopComp, loc__CidC, loc__lcIds
        LOCAL loc__QtdPrz, loc__QtdLim, loc__QtBaixar, loc__QtBaixado, loc__lnVezes
        LOCAL loc__lnQtdTb, loc__Qtdcpnt, loc__Units, loc__Moedas, loc__Baixa, loc__Pendente
        LOCAL loc_pEdn, loc_pItn, loc_pIds, loc_pQtd, loc_pId2, loc_pQt2, loc_pNop
        LOCAL loc__Peso, loc__NopComp2, loc__lcEdn, loc__lcQuery, loc__lcSql, loc__lcEds
        LOCAL loc__GrvEest, loc__Chave, loc__Chave2, loc__Citens, loc__Gpd, loc__Cpd
        LOCAL loc__Grupod, loc__Contad, loc__Numerec, loc_pDay, loc__Empr, loc__Usuar
        LOCAL loc__lcForn, loc__lnTotPed, loc__Citens2, loc__Dume, loc__lnQtdEmphs
        LOCAL loc__lcOperBusca, loc__lcCampo, loc__lnQtd, loc__lnTotReq, loc__lcCgru
        LOCAL loc__lnBaixa, loc__lnPeso, loc__lnPesMd, loc__ldDtEnt
        LOCAL loc__DopEntAu, loc__TpOp, loc__NumEntAu, loc__TPesoNei, loc__Gravou
        LOCAL loc__Oper, loc_xOper, loc__GrupoC, loc__ContaC, loc__QtBaixar2
        LOCAL loc__ChavBus, loc__llTemItem2, loc__GruMat
        LOCAL loc__NopI, loc__NopF, loc__Seq, loc__llTrue, loc__llFalse
        LOCAL loc__Inicio2, loc__DpTrf, loc__lcUpdate, loc__nTran
        LOCAL loc__GrpO, loc__CtaO, loc__GrpD, loc__CtaD, loc__DtGe, loc__Usuar2
        LOCAL loc__Qtde, loc__QtAnt, loc__PsAnt, loc__xBaixa2, loc__xReser

        loc_lSucesso   = .F.
        loc_llErro     = .F.
        loc_lTransAberta = .F.

        loc__Empr  = go_4c_Sistema.cCodEmpresa
        loc__Usuar = gc_4c_UsuarioLogado
        loc__Prev  = par_dPrev
        loc__DtGera = par_dGera
        loc_pDay   = DATETIME()

        TRY
            DO WHILE .T.

                *-- Criar cursores de trabalho
                THIS.CriarCursorTrabalho("SigOpPic",  "crSigOpPic")
                THIS.CriarCursorTrabalho("SigPdMvf",  "crSigPdMvf")
                THIS.CriarCursorTrabalho("SigCdNec",  "crSigCdNec")
                THIS.CriarCursorTrabalho("SigMvCab",  "crSigMvCab")
                THIS.CriarCursorTrabalho("SigMvHst",  "crSigMvHst")
                THIS.CriarCursorTrabalho("SigBxEst",  "crSigBxEst")
                THIS.CriarCursorTrabalho("SigMvItn",  "crSigMvItn")
                THIS.CriarCursorTrabalho("SigMvIts",  "crSigMvIts")
                THIS.CriarCursorTrabalho("SigCdNei",  "CrSigCdNei")

                SELECT * FROM CrSigCdNei WHERE 0=1 INTO CURSOR GrSigCdNei READWRITE

                *-- Obter operacao padrao
                THIS.CursorQuery('SigCdOpd', 'crSigCdOpd', 'Dopps', crSigCdPam.DoppPads)
                loc__Dopp = crSigCdPam.DoppPads
                loc__Dope = crSigCdPam.TransfRes
                loc__Nump = 0

                IF NOT THIS.this_lReserva
                    IF crSigCdPam.GlobAutos = 2 AND THIS.this_nNumerodaop > 0
                        loc__Nump = THIS.this_nNumerodaop
                    ELSE
                        loc__Nump = fGerUniqueKey(loc__Dopp)
                    ENDIF

                    loc__lcSql = "SELECT Numps FROM SigOpPic WHERE Numps = " + ALLTRIM(STR(loc__Nump))
                    IF SQLEXEC(gnConnHandle, loc__lcSql, 'TmpOpi') < 1
                        MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (TmpOpi)")
                        loc_llErro = .T.
                        EXIT
                    ENDIF
                    IF RECCOUNT('TmpOpi') > 0
                        MsgAviso('N' + CHR(250) + 'mero de Op j' + CHR(225) + ' existe. Favor Corrigir!!!', '')
                        loc_llErro = .T.
                        EXIT
                    ENDIF
                ENDIF

                loc__Seqs   = 0
                loc__CPros  = ''
                loc__Reff   = SPACE(15)
                loc__Cor    = SPACE(4)
                loc__Tam    = SPACE(2)
                loc__TProd  = 0
                loc__TPeso  = 0
                loc__Clinha = SPACE(10)
                loc__Nota   = SPACE(6)
                loc__GrupoD = SPACE(10)
                loc__ContaD = SPACE(10)
                loc__Numpe  = (loc__Nump * 10000) + 1

                CREATE CURSOR TmpEmpH (Grupos c(10), Contas c(10), cGrus c(3), cMats c(14), Qtds n(12,3), QtdReqs n(12,3), ;
                                       QtdEsts n(12,3), QtdMins n(12,3), QtdPedcs n(12,3), QtdComps n(12,3), QtdEmphs n(12,3), ;
                                       QtdGReqs n(12,3), Cpro2s c(10), Pesos n(12,3))
                INDEX ON CGrus + CMats TAG GruMat
                INDEX ON CMats + Cpro2s TAG CMats

                CREATE CURSOR TmpPedra (Grupos c(10), Contas c(10), cGrus c(3), cMats c(14), Qtds n(12,3), QtdReqs n(12,3), ;
                                        QtdEsts n(12,3), QtdMins n(12,3), QtdPedcs n(12,3), QtdComps n(12,3), QtdEmphs n(12,3), ;
                                        QtdGReqs n(12,3), Pesos n(12,3))
                INDEX ON CGrus + CMats TAG GruMat
                INDEX ON CMats TAG CMats
                INDEX ON CMats + Grupos + Contas TAG MatGruCon

                CREATE CURSOR TmpMatPrz (cMats c(14), Qtds n(12,3), Pesos n(12,3), PrazoEnts D, QtBaixas n(12,3))
                INDEX ON DTOC(PrazoEnts) + CMats TAG MatPrazo DESCENDING

                loc__DopePed = crSigCdPac.OpPdCompra
                THIS.CursorQuery('SigCdOpe', 'TmpOpePed', 'Dopes', loc__DopePed)
                THIS.CursorQuery('SigMvIts', 'crTplMvIts', 'cIdChaves', fUniqueIds())
                SELECT crTplMvIts
                INDEX ON Cpros TAG Cpros
                THIS.CursorQuery('SigMvItn', 'crTpmMvItn', 'cIdChaves', fUniqueIds())
                SELECT crTpmMvItn
                INDEX ON Cpros TAG Cpros

                SQLEXEC(gnConnHandle, "BEGIN TRAN")
                loc_lTransAberta = .T.

                IF NOT THIS.this_lReserva
                    SELECT TmpFinal
                    INDEX ON Linhas + Reffs + Cpros + Notas + CodCors + CodTams + GrupoDs + ContaDs TAG Cpros
                    SET ORDER TO Cpros
                    GO TOP
                    DO WHILE NOT EOF('TmpFinal')
                        IF TmpFinal.Produzir <> 0
                            THIS.CursorQuery('SigCdPro', 'crSigCdPro', 'CPros', TmpFinal.CPros)
                            THIS.CursorQuery('SigCdLin', 'CrSigCdLin', 'Linhas', TmpFinal.Linhas)
                            THIS.CursorQuery('SigCdGrp', 'CrSigCdGrp', 'CGrus', CrSigCdPro.Cgrus, 'Mercs,GeraTubs')
                            THIS.CursorQuery('SigCdGpr', 'CrSigCdGpr', 'Codigos', CrSigCdGrp.Mercs, 'MatPrincs,cpqtds')
                            IF EMPTY(crSigCdPac.OpPdCompra) OR (!EMPTY(crSigCdPac.OpPdCompra) AND crSigCdPro.FabrProPrs = 1)
                                loc__lcMat = IIF(!EMPTY(crSigCdPro.MatPrincs), CrSigCdPro.MatPrincs, ;
                                             IIF(!EMPTY(CrSigCdGpr.MatPrincs), CrSigCdGpr.MatPrincs, crSigCdPam.Ouros))
                                loc__QtdPrz   = TmpFinal.Produzir
                                loc__QtdLim   = IIF(CrSigCdLin.QtPcs = 0, TmpFinal.Produzir, CrSigCdLin.QtPcs)
                                loc__QtBaixar = TmpFinal.Produzir
                                loc__lnVezes  = 0
                                DO WHILE loc__QtBaixar > 0
                                    loc__lnVezes = loc__lnVezes + 1
                                    IF loc__QtBaixar < loc__QtdLim
                                        loc__QtBaixado = loc__QtBaixar
                                        loc__QtBaixar  = 0
                                    ELSE
                                        loc__QtBaixar  = loc__QtBaixar - loc__QtdLim
                                        loc__QtBaixado = loc__QtdLim
                                    ENDIF
                                    IF (loc__Clinha + loc__Reff + loc__CPros + loc__Nota + loc__Cor + loc__GrupoD + loc__ContaD <> ;
                                        TmpFinal.Linhas + TmpFinal.Reffs + TmpFinal.CPros + TmpFinal.Notas + ;
                                        TmpFinal.CodCors + TmpFinal.GrupoDs + TmpFinal.ContaDs) OR loc__lnVezes > 1
                                        loc__Clinha  = TmpFinal.Linhas
                                        loc__CPros   = TmpFinal.CPros
                                        loc__Cor     = TmpFinal.CodCors
                                        loc__Tam     = TmpFinal.CodTams
                                        loc__Reff    = TmpFinal.Reffs
                                        loc__GrupoD  = TmpFinal.GrupoDs
                                        loc__ContaD  = TmpFinal.ContaDs
                                        loc__Seqs    = loc__Seqs + 1
                                        loc__Nota    = TmpFinal.Notas
                                        loc__NopComp = (loc__Nump * 10000) + loc__Seqs
                                        loc__CidC    = DTOS(loc__DtGera) + TRANSFORM(fGerUniqueKey(DTOS(loc__DtGera)), "@L 999999") + THIS.this_cSigKey
                                        INSERT INTO crSigPdMvf (Emps, Dopps, Numps, Datars, Datas, Usuars, Grupoos, Contaos, Grupods, Contads, ;
                                                               Nops, CodPds, Unids, Pesos, Qtds, Ordems, cIdChaves, EmpDopNums, EmpDNps) ;
                                                       VALUES (loc__Empr, loc__Dopp, loc__NopComp, DATETIME(), loc__DtGera, loc__Usuar, ;
                                                               crSigCdOpd.GruOrigs, crSigCdOpd.ConOrigs, loc__GrupoD, loc__ContaD, loc__NopComp, ;
                                                               loc__CPros, crSigCdPro.CUnis, IIF(DbParam.OpZers=1,0,loc__TPeso), loc__TProd, 1, ;
                                                               loc__CidC, loc__Empr + SPACE(20) + STR(0,6), loc__Empr + loc__Dopp + STR(loc__NopComp,10))
                                        loc__lcIds = DTOS(loc__DtGera) + TRANSFORM(fGerUniqueKey(DTOS(loc__DtGera)), '@L 999999') + THIS.this_cSigKey
                                        INSERT INTO crSigCdNec (Emps, Dopps, Numps, Datars, Datas, Usuars, TotPesos, Grupoos, ;
                                                               Contaos, Grupods, Contads, cIdChaves, EmpDNps, Jobs) ;
                                                       VALUES (loc__Empr, loc__Dopp, loc__NopComp, DATETIME(), loc__DtGera, loc__Usuar, ;
                                                               loc__TPeso, crSigCdOpd.GruOrigs, crSigCdOpd.ConOrigs, loc__GrupoD, loc__ContaD, ;
                                                               loc__lcIds, loc__Empr + loc__Dopp + STR(loc__NopComp,10), TmpFinal.Jobs)
                                        INSERT INTO GrSigCdNei (Emps, Dopps, Numps, Nops, Nenvs, Cmats, Cdescs, ;
                                                              cUnis, Pesos, Qtds, TpOps, EmpDNps, cIdChaves) ;
                                                      VALUES (loc__Empr, loc__Dopp, loc__NopComp, loc__NopComp, loc__NopComp, loc__lcMat, ;
                                                              crSigCdPro.Dpros, crSigCdPro.Cunis, ;
                                                              IIF(CrSigCdGpr.cpqtds=1,loc__TProd,loc__TPeso), ;
                                                              IIF(CrSigCdGpr.cpqtds=1,loc__TProd,loc__TPeso), ;
                                                              crSigCdPam.TpOpEntAus, loc__Empr + loc__Dopp + STR(loc__NopComp,10), fUniqueIds())
                                        loc__TProd = 0
                                        loc__TPeso = 0
                                    ENDIF
                                    loc__NopComp = (loc__Nump * 10000) + loc__Seqs
                                    IF crSigCdGrp.GeraTubs <> 2
                                        loc__lnQtdTb = crSigCdPro.QtdCpnts
                                    ELSE
                                        loc__lcQuery = "SELECT SUM(qtds) AS total FROM SigPrMtz WHERE Cpros = '" + ALLTRIM(TmpFinal.CPros) + "'"
                                        IF SQLEXEC(gnConnHandle, loc__lcQuery, 'crSigPrMtz') < 1
                                            MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (crSigPrMtz)")
                                            loc_llErro = .T.
                                        ELSE
                                            SELECT crSigPrMtz
                                            loc__lnQtdTb = crSigPrMtz.Total
                                        ENDIF
                                    ENDIF
                                    IF loc_llErro
                                        EXIT
                                    ENDIF
                                    loc__Qtdcpnt = NVL(loc__lnQtdTb, 0) * loc__QtBaixado
                                    loc__Units   = 0
                                    loc__Moedas  = SPACE(3)
                                    loc__lcQuery = "SELECT * FROM SigMvItn" + ;
                                                  " WHERE EmpDopNums = '" + ALLTRIM(TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes,6)) + "'" + ;
                                                  " AND CPros = '" + ALLTRIM(TmpFinal.Cpros) + "'"
                                    IF SQLEXEC(gnConnHandle, loc__lcQuery, 'TempEestI') < 1
                                        MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (TempEestI)")
                                        loc_llErro = .T.
                                        EXIT
                                    ENDIF
                                    SELECT TempEestI
                                    SCAN
                                        IF Citens = TmpFinal.Citens
                                            loc__Units  = TempEestI.Units
                                            loc__Moedas = TempEestI.Moedas
                                            EXIT
                                        ENDIF
                                    ENDSCAN
                                    INSERT INTO crSigOpPic (Emps, Dopps, Numps, Nops, Dopes, Numes, Dataes, Dataps, Obss, Qtds, Cpros, ;
                                                          DtGeras, CodCors, CodTams, Pesos, QtdCpnts, Units, Moedas, cIdChaves, ;
                                                          EmpDopNums, EmpDNps, Notas, Empds, EmpDopNops, Dpros, CodTgOps, Citens) ;
                                                  VALUES (loc__Empr, loc__Dopp, loc__Nump, loc__NopComp, TmpFinal.Dopes, TmpFinal.Numes, loc__Prev, ;
                                                          TmpFinal.Datas, TmpFinal.Obsps, loc__QtBaixado, loc__CPros, loc__DtGera, ;
                                                          TmpFinal.CodCors, TmpFinal.CodTams, loc__QtBaixado * TmpFinal.Peso, ;
                                                          loc__Qtdcpnt, loc__Units, loc__Moedas, fUniqueIds(), ;
                                                          TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes,6), ;
                                                          loc__Empr + loc__Dopp + STR(loc__Nump,10), TmpFinal.Notas, TmpFinal.Emps, ;
                                                          loc__Empr + loc__Dopp + STR(loc__NopComp,10), TmpFinal.Dpros, DbParam.CodTgOps, TmpFinal.CItens)
                                    SELECT TempEestI
                                    loc__Baixa = loc__QtBaixado
                                    loc_lScanAbort = .F.
                                    SCAN WHILE loc__Baixa > 0
                                        loc_pEdn = TempEestI.Emps + TempEestI.Dopes + STR(TempEestI.Numes, 6)
                                        loc_pItn = TempEestI.Citens
                                        loc_pIds = TempEestI.cIdChaves
                                        IF TempEestI.Qtds - TempEestI.QtBaixas - TempEestI.QtProds <> 0
                                            loc__lcQuery = "SELECT * FROM SigMvIts WHERE EmpDopNums = '" + ALLTRIM(loc_pEdn) + "' AND CItens = ?loc_pItn"
                                            IF SQLEXEC(gnConnHandle, loc__lcQuery, 'TempEsti2') < 1
                                                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (TempEsti2 - 1)")
                                                loc_lScanAbort = .T.
                                                EXIT
                                            ENDIF
                                            SELECT TempEsti2
                                            GO TOP
                                            IF EOF('TempEsti2')
                                                loc__Pendente = TempEestI.Qtds - TempEestI.QtBaixas - TempEestI.QtProds
                                                IF loc__Pendente > loc__Baixa
                                                    loc_pQtd   = TempEestI.QtProds + loc__Baixa
                                                    loc__Baixa = 0
                                                ELSE
                                                    loc_pQtd   = TempEestI.QtProds + loc__Pendente
                                                    loc__Baixa = loc__Baixa - loc__Pendente
                                                ENDIF
                                                loc__lcQuery = "UPDATE SigMvItn SET DtAlts = ?loc_pDay, QtProds = ?loc_pQtd WHERE cIdChaves = ?loc_pIds"
                                                IF SQLEXEC(gnConnHandle, loc__lcQuery) < 1
                                                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Update - 1)")
                                                    loc_lScanAbort = .T.
                                                    EXIT
                                                ENDIF
                                            ELSE
                                                SELECT TempEsti2
                                                loc_lScanAbort = .F.
                                                SCAN WHILE loc__Baixa > 0
                                                    loc_pId2 = TempEsti2.cIdChaves
                                                    loc__Pendente = TempEsti2.Qtds - TempEsti2.QtBaixas - TempEsti2.QtProds
                                                    IF loc__Pendente <> 0
                                                        IF loc__Pendente > loc__Baixa
                                                            loc_pQtd   = TempEestI.QtProds + loc__Baixa
                                                            loc_pQt2   = TempEsti2.QtProds + loc__Baixa
                                                            loc__Baixa = 0
                                                        ELSE
                                                            loc_pQtd   = TempEestI.QtProds + loc__Pendente
                                                            loc_pQt2   = TempEsti2.QtProds + loc__Pendente
                                                            loc__Baixa = loc__Baixa - loc__Pendente
                                                        ENDIF
                                                        loc__lcQuery = "UPDATE SigMvItn SET DtAlts = ?loc_pDay, QtProds = ?loc_pQtd WHERE cIdChaves = ?loc_pIds"
                                                        IF SQLEXEC(gnConnHandle, loc__lcQuery) < 1
                                                            MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Update - 2)")
                                                            loc_lScanAbort = .T.
                                                            EXIT
                                                        ENDIF
                                                        loc__lcQuery = "UPDATE SigMvIts SET QtProds = ?loc_pQt2 WHERE cIdChaves = ?loc_pId2"
                                                        IF SQLEXEC(gnConnHandle, loc__lcQuery) < 1
                                                            MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Update - 3)")
                                                            loc_lScanAbort = .T.
                                                            EXIT
                                                        ENDIF
                                                    ENDIF
                                                ENDSCAN
                                            ENDIF
                                        ENDIF
                                        IF loc_lScanAbort
                                            EXIT
                                        ENDIF
                                    ENDSCAN
                                    IF loc_lScanAbort
                                        loc_llErro = .T.
                                        EXIT
                                    ENDIF
                                    loc_pNop = loc__Nump
                                    loc__lcQuery = "UPDATE SigMvCab SET Nops = ?loc_pNop, DtAlts = ?loc_pDay" + ;
                                                  " WHERE EmpDopNums = '" + ALLTRIM(TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes,6)) + "'"
                                    IF SQLEXEC(gnConnHandle, loc__lcQuery) < 1
                                        MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Update - 4)")
                                        loc_llErro = .T.
                                        EXIT
                                    ENDIF
                                    loc__lcEdn = TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes, 6)
                                    loc__lcQuery = "SELECT a.*, b.cgrus FROM SigSubMv a INNER JOIN SigCdPro b ON a.mats=b.cpros" + ;
                                                  " WHERE a.empdopnums = ?loc__lcEdn AND a.cpros = ?TmpFinal.CPros AND a.citem2 = ?TmpFinal.citens"
                                    IF SQLEXEC(gnConnHandle, loc__lcQuery, 'LocalCompo') < 1
                                        MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (LocalCompo)")
                                        loc_llErro = .T.
                                        EXIT
                                    ENDIF
                                    IF crSigCdPam.AutComps <> 1 AND RECCOUNT('LocalCompo') > 0
                                        SELECT LocalCompo
                                        loc__npesocmp = THIS.AtualizarPeso()
                                        loc__TProd = loc__TProd + loc__QtBaixado
                                        loc__TPeso = loc__TPeso + (loc__QtBaixado * loc__npesocmp)
                                        SELECT crSigOpPic
                                        REPLACE Pesos WITH loc__QtBaixado * loc__npesocmp
                                    ELSE
                                        loc__TProd = loc__TProd + loc__QtBaixado
                                        loc__TPeso = loc__TPeso + (loc__QtBaixado * TmpFinal.Peso)
                                    ENDIF
                                    SELECT crSigPdMvf
                                    REPLACE Pesos WITH IIF(DbParam.OpZers=1,0,loc__TPeso), Qtds WITH loc__TProd
                                    SELECT GrSigCdNei
                                    REPLACE Pesos WITH IIF(CrSigCdGpr.cpqtds=1,loc__TProd,loc__TPeso), ;
                                            Qtds  WITH IIF(CrSigCdGpr.cpqtds=1,loc__TProd,loc__TPeso) IN GrSigCdNei
                                    SELECT crSigCdNec
                                    REPLACE TotPesos WITH loc__TPeso
                                    IF THIS.this_lAutomatico
                                        REPLACE Autos WITH .T.
                                    ENDIF
                                ENDDO
                                IF loc_llErro
                                    EXIT
                                ENDIF
                            ELSE
                                loc__lcForn  = IIF(!EMPTY(crSigCdPro.Ifors), crSigCdPro.Ifors, TmpOpePed.ConOrigs)
                                loc__lnTotPed = TmpFinal.Produzir
                                SELECT crSigMvCab
                                GO TOP
                                LOCATE FOR Dopes = crSigCdPac.OpPdCompra AND ContaDs = loc__lcForn
                                IF !EOF()
                                    loc__Dume = crSigMvCab.Numes
                                    SELECT MAX(Citens) AS Citens FROM crTpmMvItn WHERE Emps = loc__Empr AND Dopes = loc__DopePed AND Numes = loc__Dume INTO CURSOR TmpUltItn
                                    loc__Citens2 = NVL(TmpUltItn.Citens, 0) + 1
                                ELSE
                                    loc__Citens2 = 9999
                                ENDIF
                                IF loc__Citens2 >= 9999
                                    loc__Citens2 = 1
                                    loc__Dume = fGerUniqueKey(loc__Empr + loc__DopePed)
                                    INSERT INTO crSigMvCab (Emps, Dopes, Numes, MascNum, Datas, Datars, Usuars, Grupoos, Contaos, ;
                                                           Grupods, Contads, Nops, Obses, Empdopnums, cIdChaves, DtAlts) ;
                                                   VALUES (loc__Empr, loc__DopePed, loc__Dume, ALLTRIM(fGerMascara(loc__Dume)), ;
                                                           loc__DtGera, DATETIME(), loc__Usuar, ;
                                                           TmpOpePed.GruOrigs, loc__lcForn, TmpOpePed.GruDests, TmpOpePed.ConDests, ;
                                                           loc__Nump, '[ OP: ' + STR(loc__Nump) + '] ', ;
                                                           loc__Empr + loc__DopePed + STR(loc__Dume,6), fUniqueIds(), DATETIME())
                                ENDIF
                                INSERT INTO crTpmMvItn (Emps, Dopes, Numes, CPros, Qtds, Cunis, DPros, Opers, Citens, Pesos, cUniPs, Obs) ;
                                            VALUES (loc__Empr, loc__DopePed, loc__Dume, TmpFinal.Cpros, loc__lnTotPed, crSigCdPro.Cunis, ;
                                                    crSigCdPro.Dpros, 'E', loc__Citens2, CrSigCdPro.PesoMs, CrSigCdPro.cUniPs, TmpFinal.Obsps)
                                IF !EMPTY(TmpFinal.CodCors) OR !EMPTY(TmpFinal.CodTams)
                                    INSERT INTO crTplMvIts (cItens, Emps, Dopes, Numes, CPros, Qtds, Pesos, CodCors, CodTams, QtdEmbs) ;
                                                    VALUES (loc__Citens2, loc__Empr, loc__DopePed, loc__Dume, TmpFinal.CPros, loc__lnTotPed, ;
                                                            CrSigCdPro.PesoMs, TmpFinal.CodCors, TmpFinal.CodTams, 1)
                                ENDIF
                                loc_pNop = loc__Nump
                                loc__lcQuery = "UPDATE SigMvCab SET Nops = ?loc_pNop, DtAlts = ?loc_pDay" + ;
                                              " WHERE EmpDopNums = '" + ALLTRIM(TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes,6)) + "'"
                                IF SQLEXEC(gnConnHandle, loc__lcQuery) < 1
                                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Update - 4.1)")
                                    loc_llErro = .T.
                                ENDIF
                            ENDIF
                        ENDIF
                        IF loc_llErro
                            EXIT
                        ENDIF
                        SELECT TmpFinal
                        SKIP
                    ENDDO
                ENDIF
                IF loc_llErro
                    EXIT
                ENDIF

                *-- Calcular reservas de estoque
                SELECT TmpSaldG
                SET ORDER TO
                REPLACE ALL Reservs WITH Saldo - Disps

                CREATE CURSOR TmpEstoque (EmpDs c(3), Cpros c(14), CodCors c(4), CodTams c(4), Emps c(3), Dopes c(20), Numes n(6), Grupos c(10), Estos c(10), Estoque n(12,3))
                INDEX ON EmpDs + Grupos + Estos + Emps + Dopes + STR(Numes,6) TAG EmpDopNum

                SELECT TmpFinal
                SET ORDER TO
                loc_lScanAbort = .F.
                SCAN
                    THIS.CursorQuery('SigCdPro', 'crSigCdPro', 'CPros', TmpFinal.CPros, 'FabrProPrs')
                    SELECT TmpFinal
                    IF TmpFinal.Estoque # 0 AND IIF(!EMPTY(crSigCdPac.OpPdCompra) AND crSigCdPro.FabrProPrs # 1, .F., .T.)
                        loc__xBaixa2 = TmpFinal.Estoque
                        SELECT TmpSaldG
                        SET ORDER TO Cpros
                        =SEEK(TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams)
                        SCAN WHILE Cpros = TmpFinal.Cpros AND CodCors = TmpFinal.CodCors AND CodTams = TmpFinal.CodTams AND loc__xBaixa2 > 0
                            IF TmpSaldG.Reservs >= loc__xBaixa2
                                REPLACE TmpSaldG.Reservs WITH TmpSaldG.Reservs - loc__xBaixa2 IN TmpSaldG
                                INSERT INTO TmpEstoque (Cpros, CodCors, CodTams, Emps, Dopes, Numes, Grupos, Estos, Estoque, EmpDs) VALUES ;
                                    (TmpFinal.Cpros, TmpFinal.CodCors, TmpFinal.CodTams, TmpFinal.Emps, TmpFinal.Dopes, TmpFinal.Numes, ;
                                     TmpSaldG.Grupos, TmpSaldG.Estos, loc__xBaixa2, TmpSaldG.Emps)
                                loc__xBaixa2 = 0
                            ELSE
                                IF TmpSaldG.Reservs > 0 OR TmpFinal.Estoque = TmpFinal.Saldo
                                    loc__xBaixa2 = loc__xBaixa2 - TmpSaldG.Reservs
                                    loc__xReser = IIF(TmpFinal.Estoque = TmpFinal.Saldo, loc__xBaixa2, TmpSaldG.Reservs)
                                    INSERT INTO TmpEstoque (Cpros, CodCors, CodTams, Emps, Dopes, Numes, Grupos, Estos, Estoque, EmpDs) VALUES ;
                                        (TmpFinal.Cpros, TmpFinal.CodCors, TmpFinal.CodTams, TmpFinal.Emps, TmpFinal.Dopes, TmpFinal.Numes, ;
                                         TmpSaldG.Grupos, TmpSaldG.Estos, loc__xReser, TmpSaldG.Emps)
                                    REPLACE TmpSaldG.Reservs WITH 0 IN TmpSaldG
                                ENDIF
                            ENDIF
                        ENDSCAN
                    ENDIF
                    IF !EMPTY(crSigCdPac.OpPdCompra) AND crSigCdPro.FabrProPrs # 1
                        INSERT INTO TmpEstoque (Cpros, CodCors, CodTams, Emps, Dopes, Numes, Grupos, Estos, Estoque, EmpDs) VALUES ;
                            (TmpFinal.Cpros, TmpFinal.CodCors, TmpFinal.CodTams, TmpFinal.Emps, TmpFinal.Dopes, TmpFinal.Numes, ;
                             '', '', TmpFinal.Qtds, TmpFinal.Emps)
                    ENDIF
                    SELECT TmpFinal
                ENDSCAN

                loc__GrvEest = .F.
                loc__Chave   = SPACE(30)
                loc__Chave2  = SPACE(22)
                loc__Citens  = 1
                SELECT TmpEstoque
                SET ORDER TO EmpDopNum
                loc_lScanAbort = .F.
                SCAN
                    THIS.CursorQuery('SigCdPro', 'crSigCdPro', 'CPros', TmpEstoque.CPros)
                    THIS.CursorQuery('SigCdGrp', 'crSigCdGrp', 'CGrus', crSigCdPro.CGrus)
                    SELECT TmpEstoque
                    IF (EmpDs + Grupos + Estos <> loc__Chave2) OR (Emps + Dopes + STR(Numes,6) <> loc__Chave)
                        IF EmpDs + Grupos + Estos <> loc__Chave2
                            loc__GrvEest = .F.
                        ENDIF
                        loc__Chave2 = EmpDs + Grupos + Estos
                        loc__Chave  = Emps + Dopes + STR(Numes, 6)
                        loc__lcEdn  = TmpEstoque.Emps + TmpEstoque.Dopes + STR(TmpEstoque.Numes, 6)
                        loc_pNop    = loc__Nump
                        loc__lcQuery = "UPDATE SigMvCab SET Nops = ?loc_pNop, DtAlts = ?loc_pDay WHERE EmpDopNums = '" + ALLTRIM(loc__lcEdn) + "'"
                        IF SQLEXEC(gnConnHandle, loc__lcQuery) < 1
                            MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Update - 5)")
                            loc_lScanAbort = .T.
                            EXIT
                        ENDIF
                        THIS.CursorQuery('SigCdOpe',  'crSigCdOpe',  'Dopes', TmpEstoque.Dopes)
                        THIS.CursorQuery('SigMvCab', 'TempEest', 'EmpDopNums', loc__lcEdn)
                        IF crSigCdOpe.Globalizas = 1
                            loc__Gpd = TempEest.Grupoos
                            loc__Cpd = TempEest.Contaos
                        ELSE
                            loc__Gpd = TempEest.Grupods
                            loc__Cpd = TempEest.Contads
                        ENDIF
                        IF NOT EMPTY(crSigCdPam.GruReservs)
                            loc__Gpd = crSigCdPam.GruReservs
                        ENDIF
                        IF NOT EMPTY(crSigCdPam.ConReservs)
                            loc__Cpd = crSigCdPam.ConReservs
                        ENDIF
                        IF (crSigCdPam.AgrupEmph = 2 AND NOT EMPTY(crSigCdPam.GruReservs) AND NOT loc__GrvEest) OR (crSigCdPam.AgrupEmph <> 2)
                            loc__Numerec = fGerUniqueKey(TmpEstoque.EmpDs + loc__Dope)
                            loc__Citens  = 1
                            INSERT INTO crSigMvCab (Emps, Dopes, Numes, MascNum, Datas, Datars, Usuars, Grupoos, Contaos, ;
                                                   Grupods, Contads, Nops, Obses, cIdChaves, Dtalts, EmpDopNums, EmpDs) ;
                                           VALUES (TmpEstoque.EmpDs, loc__Dope, loc__Numerec, ALLTRIM(fGerMascara(loc__Numerec)), ;
                                                   loc__DtGera, DATETIME(), loc__Usuar, ;
                                                   TmpEstoque.Grupos, TmpEstoque.Estos, loc__Gpd, loc__Cpd, loc__Nump, ;
                                                   IIF(THIS.this_lReserva, '[ Reserva Autom' + CHR(225) + 'tica ]', ;
                                                       '[ OP: ' + STR(loc__Nump) + '] ') + loc__Chave, ;
                                                   fUniqueIds(), DATETIME(), TmpEstoque.EmpDs + loc__Dope + STR(loc__Numerec,6), loc__Empr)
                            loc__GrvEest = .T.
                        ELSE
                            loc__lcEdn  = TmpEstoque.Emps + loc__Dope + STR(loc__Numerec, 6)
                            THIS.CursorQuery('SigMvCab', 'TempEest', 'EmpDopNums', loc__lcEdn)
                            loc_pNop = TempEest.Obses + ' / ' + loc__Chave
                            loc__lcQuery = "UPDATE SigMvCab SET Obses = ?loc_pNop, DtAlts = ?loc_pDay WHERE EmpDopNums = '" + ALLTRIM(loc__lcEdn) + "'"
                            IF SQLEXEC(gnConnHandle, loc__lcQuery) < 1
                                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Update - 6)")
                                loc_lScanAbort = .T.
                                EXIT
                            ENDIF
                        ENDIF
                    ENDIF
                    INSERT INTO crTpmMvItn (Emps, Dopes, Numes, CPros, Qtds, Cunis, DPros, Opers, cItens) ;
                                VALUES (TmpEstoque.EmpDs, loc__Dope, loc__Numerec, TmpEstoque.CPros, TmpEstoque.Estoque, ;
                                        crSigCdPro.Cunis, crSigCdPro.Dpros, 'S', loc__Citens)
                    IF crSigCdGrp.TipoEstos > 1
                        INSERT INTO crTplMvIts (cItens, Emps, Dopes, Numes, CPros, Qtds, CodCors, CodTams, QtdEmbs) ;
                                        VALUES (loc__Citens, TmpEstoque.EmpDs, loc__Dope, loc__Numerec, TmpEstoque.CPros, ;
                                                TmpEstoque.Estoque, TmpEstoque.CodCors, TmpEstoque.CodTams, 1)
                    ENDIF
                    loc__Citens = loc__Citens + 1
                    THIS.CursorQuery('SigCdOpe', 'crSigCdOpe', 'Dopes', loc__Dope)
                    IF crSigCdOpe.Estoqs = 1
                        loc_pCidC = ' '
                        loc_pSeq  = 0
                        INSERT INTO crSigMvHst (Usuars, Datas, Datars, Emps, Dopes, Numes, Empos, Cpros, Qtds, Opers, Grupos, ;
                                              Estos, CodCors, CodTams, EmpDopNums, EmpGruEsts, OriDopNums, cIdChaves, Seqs) ;
                                      VALUES (loc__Usuar, loc__DtGera, DATETIME(), TmpEstoque.EmpDs, loc__Dope, loc__Numerec, ;
                                              loc__Empr, TmpEstoque.CPros, TmpEstoque.Estoque, 'S', TmpEstoque.Grupos, ;
                                              TmpEstoque.Estos, TmpEstoque.CodCors, TmpEstoque.CodTams, ;
                                              TmpEstoque.EmpDs + loc__Dope + STR(loc__Numerec,6), ;
                                              TmpEstoque.EmpDs + TmpEstoque.Grupos + TmpEstoque.Estos, ;
                                              TmpEstoque.EmpDs + loc__Dope + STR(loc__Numerec,6), fUniqueIds(), loc_pSeq)
                        loc_pCidC = ' '
                        loc_pSeq  = 0
                        INSERT INTO crSigMvHst (Usuars, Datas, Datars, Emps, Dopes, Numes, Empos, Cpros, Qtds, Opers, Grupos, ;
                                              Estos, CodCors, CodTams, EmpDopNums, EmpGruEsts, OriDopNums, cIdChaves, Seqs) ;
                                      VALUES (loc__Usuar, loc__DtGera, DATETIME(), loc__Empr, loc__Dope, loc__Numerec, ;
                                              loc__Empr, TmpEstoque.CPros, TmpEstoque.Estoque, 'E', loc__Gpd, loc__Cpd, ;
                                              TmpEstoque.CodCors, TmpEstoque.CodTams, ;
                                              loc__Empr + loc__Dope + STR(loc__Numerec,6), ;
                                              loc__Empr + loc__Gpd + loc__Cpd, ;
                                              TmpEstoque.EmpDs + loc__Dope + STR(loc__Numerec,6), fUniqueIds(), loc_pSeq)
                    ENDIF
                    loc__QtBaixar  = TmpEstoque.Estoque
                    loc__ChavBus   = TmpEstoque.Emps + TmpEstoque.Dopes + STR(TmpEstoque.Numes,6) + TmpEstoque.Cpros
                    loc__lcQuery   = "SELECT * FROM SigMvIts WHERE EmpDopNums = '" + ;
                                     ALLTRIM(TmpEstoque.Emps + TmpEstoque.Dopes + STR(TmpEstoque.Numes,6)) + ;
                                     "' AND CPros = '" + ALLTRIM(TmpEstoque.Cpros) + "'"
                    IF SQLEXEC(gnConnHandle, loc__lcQuery, 'TempEsti2') < 1
                        MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (TempEsti2 - 2)")
                        loc_lScanAbort = .T.
                        EXIT
                    ENDIF
                    GO TOP IN TempEsti2
                    loc__llTemItem2 = NOT EOF('TempEsti2')
                    loc__lcQuery    = "SELECT * FROM SigMvItn WHERE EmpDopNums = '" + ;
                                      ALLTRIM(TmpEstoque.Emps + TmpEstoque.Dopes + STR(TmpEstoque.Numes,6)) + ;
                                      "' AND CPros = '" + ALLTRIM(TmpEstoque.Cpros) + "'"
                    IF SQLEXEC(gnConnHandle, loc__lcQuery, 'TempEestI') < 1
                        MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (TempEestI)")
                        loc_lScanAbort = .T.
                        EXIT
                    ENDIF
                    SELECT TempEestI
                    SCAN WHILE loc__QtBaixar > 0
                        loc_pIds = TempEestI.cIdChaves
                        IF TempEestI.QtProds + loc__QtBaixar <= TempEestI.Qtds
                            loc_pQtd       = TempEestI.QtProds + loc__QtBaixar
                            loc__QtBaixado = loc__QtBaixar
                            loc__QtBaixar  = 0
                        ELSE
                            loc__QtBaixar  = loc__QtBaixar - (TempEestI.Qtds - TempEestI.QtProds)
                            loc__QtBaixado = TempEestI.Qtds - TempEestI.QtProds
                            loc_pQtd       = TempEestI.Qtds
                        ENDIF
                        loc__lcQuery = "UPDATE SigMvItn SET QtProds = ?loc_pQtd," + ;
                                       IIF(THIS.this_lReserva, " QtReservas = ?loc_pQtd,", " QtReservas = ?loc__QtBaixado,") + ;
                                       " DtAlts = ?loc_pDay WHERE cIdChaves = ?loc_pIds"
                        IF SQLEXEC(gnConnHandle, loc__lcQuery) < 1
                            MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Update - 7)")
                            loc_lScanAbort = .T.
                            EXIT
                        ENDIF
                        IF NOT loc__llTemItem2
                            INSERT INTO crSigBxEst (Emps, Dopes, Numes, CItens, Cpros, Datas, Empbs, Dopebs, ;
                                                    Numebs, Qtdfs, CidChaves, EmpDopNums, EmpDopNumb) ;
                                            VALUES (loc__Empr, loc__Dope, loc__Numerec, TempEestI.CItens, TempEestI.Cpros, ;
                                                    loc__DtGera, TempEestI.Emps, TempEestI.Dopes, TempEestI.Numes, ;
                                                    loc__QtBaixado, fUniqueIds(), loc__Empr + loc__Dope + STR(loc__Numerec,6), ;
                                                    TempEestI.Emps + TempEestI.Dopes + STR(TempEestI.Numes,6))
                        ENDIF
                    ENDSCAN
                    IF loc_lScanAbort
                        EXIT
                    ENDIF
                    loc__QtBaixar = TmpEstoque.Estoque
                    SELECT TempEsti2
                    SCAN WHILE loc__QtBaixar > 0
                        IF CodCors <> TmpEstoque.CodCors OR CodTams <> TmpEstoque.CodTams
                            LOOP
                        ENDIF
                        loc_pIds = TempEsti2.cIdChaves
                        IF TempEsti2.QtProds + loc__QtBaixar <= TempEsti2.Qtds
                            loc_pQtd       = TempEsti2.QtProds + loc__QtBaixar
                            loc__QtBaixado = loc__QtBaixar
                            loc__QtBaixar  = 0
                        ELSE
                            loc__QtBaixar  = loc__QtBaixar - (TempEsti2.Qtds - TempEsti2.QtProds)
                            loc__QtBaixado = TempEsti2.Qtds - TempEsti2.QtProds
                            loc_pQtd       = TempEsti2.Qtds
                        ENDIF
                        loc__lcQuery = "UPDATE SigMvIts SET QtProds = ?loc_pQtd," + ;
                                       IIF(THIS.this_lReserva, " QtReservas = ?loc_pQtd,", " QtReservas = ?loc__QtBaixado,") + ;
                                       " DtAlts = ?loc_pDay WHERE cIdChaves = ?loc_pIds"
                        IF SQLEXEC(gnConnHandle, loc__lcQuery) < 1
                            MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Update - 8)")
                            loc_lScanAbort = .T.
                            EXIT
                        ENDIF
                        INSERT INTO crSigBxEst (Emps, Dopes, Numes, CItens, Cpros, Datas, Empbs, Dopebs, Numebs, ;
                                                Qtdfs, CodCors, CodTams, cIdChaves, EmpDopNums, EmpDopNumb) ;
                                        VALUES (loc__Empr, loc__Dope, loc__Numerec, TempEsti2.CItens, TempEsti2.Cpros, ;
                                                loc__DtGera, TempEsti2.Emps, TempEsti2.Dopes, TempEsti2.Numes, ;
                                                loc__QtBaixado, TempEsti2.CodCors, TempEsti2.CodTams, fUniqueIds(), ;
                                                loc__Empr + loc__Dope + STR(loc__Numerec,6), ;
                                                TempEsti2.Emps + TempEsti2.Dopes + STR(TempEsti2.Numes,6))
                    ENDSCAN
                    IF loc_lScanAbort
                        EXIT
                    ENDIF
                    SELECT TmpEstoque
                ENDSCAN
                IF loc_lScanAbort
                    loc_llErro = .T.
                    EXIT
                ENDIF

                *-- Secao de Empenhamento / Requisicao de componentes
                IF NOT EMPTY(crSigCdPam.DopEmphs) AND NOT EMPTY(crSigCdPam.DopReqcs) AND ;
                   NOT EMPTY(crSigCdPam.DopPedcs) AND NOT THIS.this_lReserva AND THIS.this_cEmphpdr
                    SELECT SelPedra
                    SCAN
                        IF EMPTY(Cpros) OR Qtds <= 0
                            LOOP
                        ENDIF
                        THIS.CursorQuery('SigCdPro', 'crSigCdPro', 'CPros', SelPedra.Cpros)
                        THIS.CursorQuery('SigCdUni', 'crSigCdUni', 'CUnis', crSigCdPro.CUnis)
                        THIS.CursorQuery('SigCdGrp', 'crSigCdGrp', 'CGrus', crSigCdPro.CGrus)
                        IF crSigCdGrp.CEstoqs = 1 AND NOT EMPTY(crSigCdGrp.GruEstps) AND NOT EMPTY(crSigCdGrp.ConEstps)
                            loc__lnQtde = SelPedra.Qtds
                            SELECT TmpPedra
                            IF NOT SEEK(SelPedra.Cpros)
                                INSERT INTO TmpPedra (Grupos, Contas, cGrus, cMats, QtdMins) ;
                                               VALUES (crSigCdGrp.GruEstps, crSigCdGrp.ConEstps, ;
                                                       crSigCdPro.CGrus, SelPedra.cpros, crSigCdPro.QMins)
                            ENDIF
                            REPLACE Qtds WITH Qtds + loc__lnQtde
                            SELECT TmpMatPrz
                            IF NOT SEEK(DTOC(DATE()) + SelPedra.Cpros)
                                INSERT INTO TmpMatPrz (cMats, PrazoEnts) VALUES (SelPedra.cpros, DATE())
                            ENDIF
                            REPLACE Qtds WITH Qtds + loc__lnQtde
                            SELECT TmpEmpH
                            IF NOT SEEK(SelPedra.Cpros + SelPedra.Cpro2s)
                                INSERT INTO TmpEmpH (Grupos, Contas, cGrus, cMats, QtdMins, Cpro2s) ;
                                               VALUES (crSigCdGrp.GruEstps, crSigCdGrp.ConEstps, ;
                                                       crSigCdPro.CGrus, SelPedra.cpros, crSigCdPro.QMins, SelPedra.Cpro2s)
                            ENDIF
                            REPLACE Qtds WITH Qtds + loc__lnQtde
                        ENDIF
                        SELECT SelPedra
                    ENDSCAN

                    SELECT TmpFinal
                    SET ORDER TO Cpros
                    loc_lScanAbort = .F.
                    SCAN
                        IF TmpFinal.Produzir = 0
                            LOOP
                        ENDIF
                        loc__lcSql = "SELECT GerEmphs FROM SigOpCdc WHERE Dopes = '" + ALLTRIM(TmpFinal.Dopes) + "'"
                        IF SQLEXEC(gnConnHandle, loc__lcSql, 'TmpDcOpe') < 1 OR TmpDcOpe.GerEmphs <> 1
                            LOOP
                        ENDIF
                        loc__lcEdn = TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes, 6)
                        lcBusca = fBuscarCompos(loc__lcEdn, TmpFinal.Cpros, TmpFinal.citens, '')
                        IF !EMPTY(lcBusca)
                            SELECT * FROM &lcBusca. INTO CURSOR crSigPrCpo READWRITE
                        ENDIF
                        SELECT crSigPrCpo
                        SCAN
                            THIS.CursorQuery('SigCdPro', 'crSigCdPro', 'CPros', crSigPrCpo.Mats)
                            THIS.CursorQuery('SigCdUni', 'crSigCdUni', 'CUnis', crSigCdPro.CUnis)
                            THIS.CursorQuery('SigCdGrp', 'crSigCdGrp', 'CGrus', crSigCdPro.CGrus)
                            IF crSigCdGrp.CEstoqs = 1 AND NOT EMPTY(crSigCdGrp.GruEstps) AND NOT EMPTY(crSigCdGrp.ConEstps)
                                loc__lnQtde = TmpFinal.Produzir * crSigPrCpo.Qtds
                                loc__lnPeso = TmpFinal.Produzir * CrSigPrCpo.Pesos
                                SELECT TmpPedra
                                IF NOT SEEK(crSigPrCpo.Mats)
                                    INSERT INTO TmpPedra (Grupos, Contas, cGrus, cMats, QtdMins) ;
                                                   VALUES (crSigCdGrp.GruEstps, crSigCdGrp.ConEstps, ;
                                                           crSigCdPro.CGrus, crSigPrCpo.Mats, crSigCdPro.QMins)
                                ENDIF
                                REPLACE Qtds  WITH Qtds + loc__lnQtde, Pesos WITH Pesos + loc__lnPeso
                                SELECT TmpMatPrz
                                loc__ldDtEnt = IIF(crSigCdPac.AgrupReqs = 1, NVL(TmpFinal.Entregas, CTOD('')), DATE())
                                IF NOT SEEK(DTOC(loc__ldDtEnt) + crSigPrCpo.Mats)
                                    INSERT INTO TmpMatPrz (cMats, PrazoEnts) VALUES (crSigPrCpo.Mats, loc__ldDtEnt)
                                ENDIF
                                REPLACE Qtds WITH Qtds + loc__lnQtde, Pesos WITH Pesos + loc__lnPeso
                                SELECT TmpEmpH
                                IF NOT SEEK(CrSigPrCpo.Mats + CrSigPrCpo.Cpros)
                                    INSERT INTO TmpEmpH (Grupos, Contas, cGrus, cMats, QtdMins, Cpro2s) ;
                                                   VALUES (crSigCdGrp.GruEstps, crSigCdGrp.ConEstps, ;
                                                           crSigCdPro.CGrus, crSigPrCpo.Mats, crSigCdPro.QMins, CrSigPrCpo.Cpros)
                                ENDIF
                                REPLACE Qtds WITH Qtds + loc__lnQtde, Pesos WITH Pesos + loc__lnPeso
                            ENDIF
                        ENDSCAN
                        SELECT TmpFinal
                    ENDSCAN

                    loc__llFalse = .F.
                    LOCAL loc_xFor
                    FOR loc_xFor = 1 TO 5
                        loc__lcOperBusca = IIF(loc_xFor = 1, crSigCdPam.DopEmphs, ;
                                           IIF(loc_xFor = 2, crSigCdPam.DopReqcs, ;
                                           IIF(loc_xFor = 3, crSigCdPam.DopPedcs, ;
                                           IIF(loc_xFor = 4, crSigCdPam.DopComps, crSigCdPam.DopTrfCps))))
                        loc__lcCampo = 'Qtd' + IIF(loc_xFor = 1, 'Emphs', IIF(loc_xFor = 2, 'Reqs', IIF(loc_xFor = 3, 'Pedcs', 'Comps')))
                        IF EMPTY(loc__lcOperBusca)
                            LOOP
                        ENDIF
                        loc__lcEds = loc__Empr + loc__lcOperBusca
                        loc__lcQuery = "SELECT * FROM SigMvCab WHERE EmpDopNums BETWEEN '" + loc__lcEds + "     0' AND '" + loc__lcEds + "999999' AND ChkSubn = ?loc__llFalse"
                        IF SQLEXEC(gnConnHandle, loc__lcQuery, 'TempEest') < 1
                            MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (TempEest)")
                            loc_llErro = .T.
                            EXIT
                        ENDIF
                        SELECT TempEest
                        SCAN
                            loc__lcEdn = TempEest.Emps + TempEest.Dopes + STR(TempEest.Numes, 6)
                            THIS.CursorQuery('SigMvItn', 'TempEestI', 'EmpDopNums', loc__lcEdn)
                            SELECT TempEestI
                            SCAN
                                IF Qtds - QtBaixas > 0
                                    SELECT TmpPedra
                                    IF SEEK(TempEestI.Cpros)
                                        REPLACE &loc__lcCampo. WITH &loc__lcCampo. + (TempEestI.Qtds - TempEestI.QtBaixas)
                                    ENDIF
                                ENDIF
                            ENDSCAN
                            SELECT TempEest
                        ENDSCAN
                        IF loc_llErro
                            EXIT
                        ENDIF
                    NEXT
                    IF loc_llErro
                        EXIT
                    ENDIF

                    loc__lcQuery = "SELECT b.* FROM SigMvEst b WHERE NOT b.Sqtds = 0 AND" + ;
                                   " b.Grupos + b.Estos IN (SELECT GruEstps + ConEstPs AS Contas FROM SigCdGrp" + ;
                                   " WHERE NOT GruEstPs = '" + SPACE(10) + "' AND NOT ConEstPs = '" + SPACE(10) + "' GROUP BY GruEstPs, ConEstPs)"
                    IF SQLEXEC(gnConnHandle, loc__lcQuery, 'pEstoque') < 1
                        MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (pEstoque)")
                        loc_llErro = .T.
                        EXIT
                    ENDIF
                    GO TOP IN pEstoque
                    SELECT pEstoque
                    SCAN
                        SELECT TmpPedra
                        IF SEEK(pEstoque.Cpros + pEstoque.Grupos + pEstoque.Estos, 'TmpPedra', 'MatGruCon')
                            REPLACE QtdEsts WITH QtdEsts + pEstoque.Sqtds
                        ENDIF
                        SELECT pEstoque
                    ENDSCAN

                    *-- Gerar Empenhos
                    SELECT TmpEmpH
                    SET ORDER TO GruMat
                    GO TOP
                    loc__lcCgru = CGrus
                    loc__Citens = 9999
                    loc_lScanAbort = .F.
                    SCAN
                        THIS.CursorQuery('SigCdPro', 'crSigCdPro', 'CPros', TmpEmpH.CMats)
                        IF TmpEmpH.CGrus <> loc__lcCgru
                            loc__Citens  = 9999
                            loc__lcCgru  = TmpEmpH.CGrus
                        ENDIF
                        IF loc__Citens >= 9999
                            loc__Citens = 1
                            loc__Dope   = crSigCdPam.DopEmphs
                            loc__Numerec = fGerUniqueKey(loc__Empr + loc__Dope)
                            INSERT INTO crSigMvCab (Emps, Dopes, Numes, MascNum, Datas, Datars, Usuars, Grupoos, ;
                                                   Contaos, Nops, Obses, EmpDopNums, cIdChaves, DtAlts) ;
                                           VALUES (loc__Empr, loc__Dope, loc__Numerec, ALLTRIM(fGerMascara(loc__Numerec)), ;
                                                   loc__DtGera, DATETIME(), loc__Usuar, ;
                                                   TmpEmpH.Grupos, TmpEmpH.Contas, loc__Nump, ;
                                                   '[ OP: ' + STR(loc__Nump) + '] ', ;
                                                   loc__Empr + loc__Dope + STR(loc__Numerec,6), fUniqueIds(), DATETIME())
                        ENDIF
                        INSERT INTO crTpmMvItn (Emps, Dopes, Numes, CPros, Qtds, Cunis, DPros, Opers, Citens, cPro2s, Pesos, cUnips) ;
                                    VALUES (loc__Empr, loc__Dope, loc__Numerec, TmpEmpH.cMats, TmpEmpH.Qtds, crSigCdPro.Cunis, ;
                                            crSigCdPro.Dpros, 'S', loc__Citens, TmpEmpH.Cpro2s, TmpEmpH.Pesos, CrSigCdPro.cUniPs)
                        loc__Citens = loc__Citens + 1
                    ENDSCAN

                    *-- Gerar Requisicoes
                    SELECT TmpPedra
                    loc_lScanAbort = .F.
                    SCAN
                        loc__Dope = crSigCdPam.DopReqcs
                        THIS.CursorQuery('SigOpCdd', 'crSigOpCdd', 'Dopes', loc__Dope, 'ChkResComp')
                        THIS.CursorQuery('SigOpCdc', 'crSigOpCdc', 'Dopes', loc__Dope, 'verests')
                        IF crSigOpCdc.verests <> 2
                            loc__lnQtdEmphs = 0
                            loc__lcQuery = "SELECT ISNULL(SUM(qtds),0) - ISNULL(SUM(qtbaixas),0) AS Qtds FROM SigMvItn WHERE empdopnums IN(" + ;
                                           " SELECT empdopnums FROM SigMvCab WHERE empdopnums IN(" + ;
                                           " SELECT DISTINCT EmpDopNums FROM SigBxEst WHERE dopebs = '" + ALLTRIM(loc__Dope) + "'" + ;
                                           " AND cpros = '" + ALLTRIM(TmpPedra.CMats) + "' AND qtdes > 0 ) AND chksubn = 0)" + ;
                                           " AND cpros = '" + ALLTRIM(TmpPedra.CMats) + "' AND chksubn = 0"
                            IF SQLEXEC(gnConnHandle, loc__lcQuery, 'pQtdsReq') < 1
                                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (pQtdsReq)")
                                loc_lScanAbort = .T.
                                EXIT
                            ENDIF
                            loc__lnQtdEmphs = IIF(pQtdsReq.Qtds > 0, pQtdsReq.Qtds, 0)
                            IF crSigOpCdd.ChkResComp <> 1
                                loc__lnQtd = TmpPedra.Qtds - (TmpPedra.QtdEsts - TmpPedra.QtdMins + TmpPedra.QtdReqs + TmpPedra.QtdPedcs + TmpPedra.QtdComps - TmpPedra.QtdEmphs + loc__lnQtdEmphs)
                            ELSE
                                loc__lnQtd = TmpPedra.Qtds - TmpPedra.QtdEsts
                            ENDIF
                            IF loc__lnQtd > 0
                                REPLACE QtdGReqs WITH loc__lnQtd IN TmpPedra
                            ENDIF
                        ELSE
                            REPLACE QtdGReqs WITH Qtds IN TmpPedra
                        ENDIF
                    ENDSCAN
                    IF loc_lScanAbort
                        loc_llErro = .T.
                        EXIT
                    ENDIF

                    SELECT TmpPedra
                    SET ORDER TO GruMat
                    GO TOP
                    loc__lcCgru = CGrus
                    THIS.CursorQuery('SigCdPro', 'crTmpPro', 'CPros', TmpPedra.CMats, 'ifors')
                    loc__lcForn = crTmpPro.Ifors
                    loc__Citens = 9999
                    loc_lScanAbort = .F.
                    SCAN
                        IF QtdGreqs <= 0
                            LOOP
                        ENDIF
                        loc__lnTotReq = TmpPedra.QtdGreqs
                        THIS.CursorQuery('SigCdPro', 'crSigCdPro', 'CPros', TmpPedra.CMats)
                        THIS.CursorQuery('SigCdUni', 'LocalUni', 'CUnis', crSigCdPro.CUniPs, 'Fators')
                        DO WHILE loc__lnTotReq > 0
                            SELECT TmpMatPrz
                            SCAN FOR CMats = TmpPedra.CMats
                                IF Qtds - QtBaixas > 0
                                    EXIT
                                ENDIF
                            ENDSCAN
                            loc__lnBaixa   = IIF(TmpMatPrz.Qtds > TmpMatPrz.QtBaixas AND loc__lnTotReq >= TmpMatPrz.Qtds, ;
                                             (TmpMatPrz.Qtds - TmpMatPrz.QtBaixas), loc__lnTotReq)
                            loc__lnTotReq  = loc__lnTotReq - loc__lnBaixa
                            REPLACE TmpMatPrz.QtBaixas WITH TmpMatPrz.QtBaixas + loc__lnBaixa IN TmpMatPrz
                            SELECT crSigMvCab
                            GO TOP
                            LOCATE FOR Dopes = crSigCdPam.DopReqcs AND PrazoEnts = IIF(EMPTY(TmpMatPrz.PrazoEnts), DATE(), TmpMatPrz.PrazoEnts) AND ContaDs = crSigCdPro.Ifors
                            IF !EOF()
                                loc__Dope    = crSigMvCab.Dopes
                                loc__Numerec = crSigMvCab.Numes
                                SELECT MAX(Citens) AS Citens FROM crTpmMvItn WHERE Emps = loc__Empr AND Dopes = loc__Dope AND Numes = loc__Numerec INTO CURSOR TmpUltItn
                                loc__Citens = NVL(TmpUltItn.Citens, 0) + 1
                            ELSE
                                loc__Citens = 9999
                                loc__lcCgru = TmpPedra.CGrus
                                loc__lcForn = crSigCdPro.Ifors
                            ENDIF
                            IF loc__Citens >= 9999
                                loc__Citens  = 1
                                loc__Dope    = crSigCdPam.DopReqcs
                                loc__Numerec = fGerUniqueKey(loc__Empr + loc__Dope)
                                THIS.CursorQuery('SigCdOpe', 'crSigCdOpe', 'Dopes', loc__Dope)
                                loc__lcForn = IIF(!EMPTY(loc__lcForn), loc__lcForn, crSigCdOpe.ConOrigs)
                                INSERT INTO crSigMvCab (Emps, Dopes, Numes, MascNum, Datas, Datars, Usuars, Grupoos, Contaos, ;
                                                       Grupods, Contads, Nops, Obses, Empdopnums, cIdChaves, DtAlts, PrazoEnts) ;
                                               VALUES (loc__Empr, loc__Dope, loc__Numerec, ALLTRIM(fGerMascara(loc__Numerec)), ;
                                                       loc__DtGera, DATETIME(), loc__Usuar, ;
                                                       crSigCdOpe.GruOrigs, loc__lcForn, crSigCdOpe.GruDests, crSigCdOpe.ConDests, ;
                                                       loc__Nump, '[ OP: ' + STR(loc__Nump) + '] ', ;
                                                       loc__Empr + loc__Dope + STR(loc__Numerec,6), fUniqueIds(), DATETIME(), TmpMatPrz.PrazoEnts)
                            ENDIF
                            loc__lnPesMd = IIF(TmpPedra.Pesos = 0, 0, IIF(INLIST(LocalUni.Fators,0,1), ;
                                           TmpPedra.Qtds / TmpPedra.Pesos, TmpPedra.Pesos / TmpPedra.Qtds))
                            loc__lnPeso  = IIF(INLIST(LocalUni.Fators,0,1), TmpPedra.Pesos, ROUND(loc__lnBaixa * loc__lnPesMd, 3))
                            INSERT INTO crTpmMvItn (Emps, Dopes, Numes, CPros, Qtds, Cunis, DPros, Opers, Citens, Pesos, cUniPs) ;
                                        VALUES (loc__Empr, loc__Dope, loc__Numerec, TmpPedra.cMats, loc__lnBaixa, crSigCdPro.Cunis, ;
                                                crSigCdPro.Dpros, 'S', loc__Citens, loc__lnPeso, CrSigCdPro.cUniPs)
                            loc__Citens = loc__Citens + 1
                        ENDDO
                    ENDSCAN
                    IF loc_lScanAbort
                        loc_llErro = .T.
                        EXIT
                    ENDIF
                ENDIF && empenhamento

                *-- Transferir crTpmMvItn -> crSigMvItn
                SELECT crTpmMvItn
                SCAN
                    INSERT INTO crSigMvItn (Emps, Dopes, Numes, CPros, Qtds, Cunis, DPros, Opers, Citens, ;
                                            EmpDopNums, CidChaves, DtAlts, cpro2s, Pesos, cUniPs, Obs) ;
                                    VALUES (crTpmMvItn.Emps, crTpmMvItn.Dopes, crTpmMvItn.Numes, crTpmMvItn.CPros, crTpmMvItn.Qtds, ;
                                            crTpmMvItn.Cunis, crTpmMvItn.Dpros, crTpmMvItn.Opers, crTpmMvItn.Citens, ;
                                            crTpmMvItn.Emps + crTpmMvItn.Dopes + STR(crTpmMvItn.Numes,6), ;
                                            fUniqueIds(), DATETIME(), crTpmMvItn.Cpro2s, crTpmMvItn.Pesos, crTpmMvItn.cUniPs, crTpmMvItn.Obs)
                ENDSCAN

                *-- Transferir crTplMvIts -> crSigMvIts
                SELECT crTplMvIts
                SCAN
                    INSERT INTO crSigMvIts (cItens, Emps, Dopes, Numes, CPros, Qtds, CodCors, CodTams, CidChaves, EmpDopNums, QtdEmbs) ;
                                   VALUES (crTplMvIts.Citens, crTplMvIts.Emps, crTplMvIts.Dopes, crTplMvIts.Numes, crTplMvIts.CPros, ;
                                           crTplMvIts.Qtds, crTplMvIts.CodCors, crTplMvIts.CodTams, fUniqueIds(), ;
                                           crTplMvIts.Emps + crTplMvIts.Dopes + STR(crTplMvIts.Numes,6), 1)
                ENDSCAN

                *-- Secao DopEntAu
                loc__DopEntAu = crSigCdPam.DopEntAus
                loc__TpOp     = crSigCdPam.TpOpEntAus
                IF !EMPTY(loc__DopEntAu) AND !EMPTY(loc__TpOp) AND DbParam.EntPes = 1
                    SELECT CrSigCdNec
                    INDEX ON EmpDnPs TAG EmpDnPs
                    INDEX ON Dopps + GrupoOs + ContaOs + GrupoDs + ContaDs TAG DopEntAu
                    SELECT GrSigCdNei
                    LOCATE FOR .F.
                    =THIS.CursorQuery('SigCdOpd', 'CrSigCdOpd', 'Dopps', loc__DopEntAu, 'Dopps,GruOrigs,ConOrigs,GruDests,ConDests,Origems,Destinos,EstOrigs,EstDests')
                    IF NOT EMPTY(CrSigCdOpd.GruDests) AND NOT EMPTY(CrSigCdOpd.ConDests)
                        loc__GrupoC  = CrSigCdOpd.GruOrigs
                        loc__ContaC  = CrSigCdOpd.ConOrigs
                        loc__Grupod  = CrSigCdOpd.GruDests
                        loc__Contad  = CrSigCdOpd.ConDests
                        loc__NumEntAu = fGerUniqueKey(loc__DopEntAu)
                        SELECT CMats, CDescs, cUnis, TpOps, Nops, Nenvs, SUM(Pesos) AS Pesos, SUM(Qtds) AS Qtds, SUM(Peso2s) AS Peso2s ;
                          FROM GrSigCdNei INTO CURSOR TmpNensi GROUP BY 1,2,3,4,5,6
                        SELECT TmpNensi
                        loc__TPesoNei = 0
                        loc__Gravou   = .F.
                        SCAN
                            loc__Gravou = .T.
                            loc__lcMat  = TmpNensi.CMats
                            THIS.CursorQuery('SigCdPro', 'CrSigCdPro', 'Cpros', loc__lcMat, 'Cpros,Dpros,Cunis,MatPrincs')
                            INSERT INTO crSigCdNei (Emps, Dopps, Numps, Cmats, Cdescs, cUnis, Pesos, Qtds, TpOps, EmpDNps, ;
                                                    cIdChaves, Peso2s, Nenvs, Nops) ;
                                          VALUES (loc__Empr, loc__DopEntAu, loc__NumEntAu, TmpNensi.CMats, TmpNensi.CDescs, ;
                                                  TmpNensi.Cunis, TmpNensi.Pesos, TmpNensi.Qtds, crSigCdPam.TpOpEntAus, ;
                                                  loc__Empr + loc__DopEntAu + STR(loc__NumEntAu,10), fUniqueIds(), TmpNensi.Peso2s, ;
                                                  TmpNensi.Nenvs, TmpNensi.Nops)
                            loc__TPesoNei = loc__TPesoNei + TmpNensi.Pesos
                            loc__Qtde = TmpNensi.Qtds
                            loc__Peso = TmpNensi.Peso2s
                            IF crSigCdOpd.Origems = 1 AND INLIST(crSigCdOpd.EstOrigs, 1, 2)
                                loc__Oper = IIF(crSigCdOpd.EstOrigs = 1, 'E', 'S')
                                loc_pCidC = ' '
                                loc_pSeq  = 0
                                INSERT INTO crSigMvHst (Empos, Emps, Dopes, Numes, Datars, Datas, DtAudits, Grupos, Estos, Cpros, Opers, Qtds, ;
                                                        cidChaves, empdopnums, empgruests, OriDopNums, Seqs, Pesos) ;
                                        VALUES (loc__Empr, loc__Empr, loc__DopEntAu, loc__NumEntAu, DATE(), DATE(), .NULL., ;
                                                loc__GrupoC, loc__ContaC, loc__lcMat, loc__Oper, loc__Qtde, loc_pCidC, ;
                                                loc__Empr + loc__DopEntAu + STR(loc__NumEntAu,6), ;
                                                loc__Empr + loc__GrupoC + loc__ContaC, ;
                                                loc__Empr + loc__DopEntAu + STR(loc__NumEntAu,6), loc_pSeq, loc__Peso)
                                =fRecalculaP(crSigMvHst.Emps, crSigMvHst.Grupos, crSigMvHst.Estos, crSigMvHst.CPros, crSigMvHst.Datas, CrSigMvHst.CodCors, CrSigMvHst.CodTams)
                                =fRecalculaC(crSigMvHst.Emps, crSigMvHst.CPros, crSigMvHst.Datas)
                            ENDIF
                            IF crSigCdOpd.Destinos = 1 AND INLIST(crSigCdOpd.EstDests, 1, 2)
                                loc__Oper = IIF(crSigCdOpd.EstDests = 1, 'E', 'S')
                                loc_pCidC = ' '
                                loc_pSeq  = 0
                                INSERT INTO crSigMvHst (Empos, Emps, Dopes, Numes, Datars, Datas, DtAudits, Grupos, Estos, Cpros, Opers, Qtds, ;
                                                        cidchaves, empdopnums, empgruests, OriDopNums, Seqs, Pesos) ;
                                        VALUES (loc__Empr, loc__Empr, loc__DopEntAu, loc__NumEntAu, DATE(), DATE(), .NULL., ;
                                                loc__Grupod, loc__Contad, loc__lcMat, loc__Oper, loc__Qtde, loc_pCidC, ;
                                                loc__Empr + loc__DopEntAu + STR(loc__NumEntAu,6), ;
                                                loc__Empr + loc__Grupod + loc__Contad, ;
                                                loc__Empr + loc__DopEntAu + STR(loc__NumEntAu,6), loc_pSeq, loc__Peso)
                                =fRecalculaP(crSigMvHst.Emps, crSigMvHst.Grupos, crSigMvHst.Estos, crSigMvHst.CPros, crSigMvHst.Datas, CrSigMvHst.CodCors, CrSigMvHst.CodTams)
                                =fRecalculaC(crSigMvHst.Emps, crSigMvHst.CPros, crSigMvHst.Datas)
                            ENDIF
                        ENDSCAN
                        IF loc__Gravou
                            loc__lcIds = DTOS(DATE()) + TRANSFORM(fGerUniqueKey(DTOS(DATE())), '@L 999999') + THIS.this_cSigKey
                            INSERT INTO crSigCdNec (Emps, Dopps, Numps, Datars, Datas, Usuars, Grupoos, Contaos, ;
                                                 Grupods, Contads, TotPesos, Nops, cIdChaves, EmpDNps) ;
                                         VALUES (loc__Empr, loc__DopEntAu, loc__NumEntAu, DATETIME(), DATETIME(), loc__Usuar, ;
                                                 loc__GrupoC, loc__ContaC, loc__Grupod, loc__Contad, ;
                                                 loc__TPesoNei, loc__Nump, loc__lcIds, loc__Empr + loc__DopEntAu + STR(loc__NumEntAu,10))
                        ENDIF
                    ELSE
                        SELECT * FROM GrSigCdNei INTO CURSOR TmpNensi ORDER BY EmpDnPs, Nops
                        loc__lnPeso   = 0
                        loc__TPesoNei = 0
                        SELECT TmpNensi
                        loc_lScanAbort = .F.
                        SCAN
                            loc__nEnv = nEnvs
                            =SEEK(TmpNensi.EmpDnPs, 'CrSigCdNec', 'EmpDnPs')
                            loc__GrupoC = CrSigCdNec.GrupoOs
                            loc__ContaC = CrSigCdNec.ContaOs
                            loc__Grupod = IIF(!EMPTY(CrSigCdOpd.GruDests), CrSigCdOpd.GruDests, CrSigCdNec.GrupoDs)
                            loc__Contad = CrSigCdNec.ContaDs
                            IF NOT SEEK(loc__DopEntAu + loc__GrupoC + loc__ContaC + loc__Grupod + loc__Contad, 'CrSigCdNec', 'DopEntAu')
                                loc__NumEntAu = fGerUniqueKey(loc__DopEntAu)
                                loc__lcIds = DTOS(DATE()) + TRANSFORM(fGerUniqueKey(DTOS(DATE())), '@L 999999') + THIS.this_cSigKey
                                INSERT INTO crSigCdNec (Emps, Dopps, Numps, Datars, Datas, Usuars, Grupoos, Contaos, ;
                                                     Grupods, Contads, TotPesos, Nops, cIdChaves, EmpDNps, Docus) ;
                                             VALUES (loc__Empr, loc__DopEntAu, loc__NumEntAu, DATETIME(), DATETIME(), loc__Usuar, ;
                                                     loc__GrupoC, loc__ContaC, loc__Grupod, loc__Contad, ;
                                                     loc__TPesoNei, loc__Nump, loc__lcIds, ;
                                                     loc__Empr + loc__DopEntAu + STR(loc__NumEntAu,10), STR(loc__Nump))
                                loc__lnPeso   = 0
                                loc__TPesoNei = 0
                            ENDIF
                            SELECT TmpNensi
                            loc__Qtde = Qtds
                            loc__Peso = Peso2s
                            loc__lcMat = CMats
                            loc__TPesoNei = loc__TPesoNei + Pesos
                            THIS.CursorQuery('SigCdPro', 'CrSigCdPro', 'Cpros', loc__lcMat, 'Cpros,Dpros,Cunis,MatPrincs')
                            INSERT INTO crSigCdNei (Emps, Dopps, Numps, Cmats, Cdescs, cUnis, Pesos, Qtds, TpOps, EmpDNps, cIdChaves, nenvs, Peso2s, Nops) ;
                                          VALUES (loc__Empr, loc__DopEntAu, loc__NumEntAu, loc__lcMat, crSigCdPro.Dpros, crSigCdPro.Cunis, ;
                                                  TmpNensi.Pesos, TmpNensi.Qtds, crSigCdPam.TpOpEntAus, ;
                                                  loc__Empr + loc__DopEntAu + STR(loc__NumEntAu,10), fUniqueIds(), loc__nEnv, TmpNensi.Peso2s, TmpNensi.Nops)
                            IF crSigCdOpd.Origems = 1 AND INLIST(crSigCdOpd.EstOrigs, 1, 2)
                                loc__Oper = IIF(crSigCdOpd.EstOrigs = 1, 'E', 'S')
                                loc_pCidC = ' '
                                loc_pSeq  = 0
                                INSERT INTO crSigMvHst (Empos, Emps, Dopes, Numes, Datars, Datas, DtAudits, Grupos, Estos, Cpros, Opers, Qtds, ;
                                                        cidChaves, empdopnums, empgruests, OriDopNums, Seqs, Pesos) ;
                                        VALUES (loc__Empr, loc__Empr, loc__DopEntAu, loc__NumEntAu, DATE(), DATE(), .NULL., ;
                                                loc__GrupoC, loc__ContaC, loc__lcMat, loc__Oper, loc__Qtde, loc_pCidC, ;
                                                loc__Empr + loc__DopEntAu + STR(loc__NumEntAu,6), ;
                                                loc__Empr + loc__GrupoC + loc__ContaC, ;
                                                loc__Empr + loc__DopEntAu + STR(loc__NumEntAu,6), loc_pSeq, loc__Peso)
                                =fRecalculaP(crSigMvHst.Emps, crSigMvHst.Grupos, crSigMvHst.Estos, crSigMvHst.CPros, crSigMvHst.Datas, CrSigMvHst.CodCors, CrSigMvHst.CodTams)
                                =fRecalculaC(crSigMvHst.Emps, crSigMvHst.CPros, crSigMvHst.Datas)
                            ENDIF
                            IF crSigCdOpd.Destinos = 1 AND INLIST(crSigCdOpd.EstDests, 1, 2)
                                loc__Oper = IIF(crSigCdOpd.EstDests = 1, 'E', 'S')
                                loc_pCidC = ' '
                                loc_pSeq  = 0
                                INSERT INTO crSigMvHst (Empos, Emps, Dopes, Numes, Datars, Datas, DtAudits, Grupos, Estos, Cpros, Opers, Qtds, ;
                                                        cidchaves, empdopnums, empgruests, OriDopNums, Seqs, Pesos) ;
                                        VALUES (loc__Empr, loc__Empr, loc__DopEntAu, loc__NumEntAu, DATE(), DATE(), .NULL., ;
                                                loc__Grupod, loc__Contad, loc__lcMat, loc__Oper, loc__Qtde, loc_pCidC, ;
                                                loc__Empr + loc__DopEntAu + STR(loc__NumEntAu,6), ;
                                                loc__Empr + loc__Grupod + loc__Contad, ;
                                                loc__Empr + loc__DopEntAu + STR(loc__NumEntAu,6), loc_pSeq, loc__Peso)
                                =fRecalculaP(crSigMvHst.Emps, crSigMvHst.Grupos, crSigMvHst.Estos, crSigMvHst.CPros, crSigMvHst.Datas, CrSigMvHst.CodCors, CrSigMvHst.CodTams)
                                =fRecalculaC(crSigMvHst.Emps, crSigMvHst.CPros, crSigMvHst.Datas)
                            ENDIF
                        ENDSCAN
                    ENDIF
                ENDIF && DopEntAu

                *-- Gravar historico
                SELECT crSigMvHst
                GO TOP
                THIS.GravaHistorico()

                *-- Gravar todos os cursores no servidor (Transacao 1)
                IF NOT THIS.GravarCursorNoServidor('crSigOpPic', 'SigOpPic')
                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Update - crSigOpPic)")
                    loc_llErro = .T.
                    EXIT
                ENDIF
                IF NOT THIS.GravarCursorNoServidor('crSigPdMvf', 'SigPdMvf')
                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Update - crSigPdMvf)")
                    loc_llErro = .T.
                    EXIT
                ENDIF
                IF NOT THIS.GravarCursorNoServidor('crSigCdNec', 'SigCdNec')
                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Update - crSigCdNec)")
                    loc_llErro = .T.
                    EXIT
                ENDIF
                IF NOT THIS.GravarCursorNoServidor('CrSigCdNei', 'SigCdNei')
                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Update - crSigCdNei)")
                    loc_llErro = .T.
                    EXIT
                ENDIF
                IF NOT THIS.GravarCursorNoServidor('crSigMvCab', 'SigMvCab')
                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Update - crSigMvCab)")
                    loc_llErro = .T.
                    EXIT
                ENDIF
                IF NOT THIS.GravarCursorNoServidor('crSigMvHst', 'SigMvHst')
                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Update - crSigMvHst)")
                    loc_llErro = .T.
                    EXIT
                ENDIF
                IF NOT THIS.GravarCursorNoServidor('crSigBxEst', 'SigBxEst')
                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Update - crSigBxEst)")
                    loc_llErro = .T.
                    EXIT
                ENDIF
                IF NOT THIS.GravarCursorNoServidor('crSigMvItn', 'SigMvItn')
                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Update - crSigMvItn)")
                    loc_llErro = .T.
                    EXIT
                ENDIF
                IF NOT THIS.GravarCursorNoServidor('crSigMvIts', 'SigMvIts')
                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Update - crSigMvIts)")
                    loc_llErro = .T.
                    EXIT
                ENDIF
                IF NOT fRecalculaP(.T.)
                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (SigOpClP)")
                    loc_llErro = .T.
                    EXIT
                ENDIF
                IF NOT fRecalculaC(.T., .F., .F.)
                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (SigOpClC)")
                    loc_llErro = .T.
                    EXIT
                ENDIF
                IF SQLEXEC(gnConnHandle, "COMMIT TRAN") < 1
                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Commit)")
                    loc_llErro = .T.
                    EXIT
                ENDIF
                loc_lTransAberta = .F.

                *-- Abrir SigReGli se nao for automatico nem reserva
                IF NOT THIS.this_lReserva AND NOT THIS.this_lAutomatico
                    DO FORM SigReGli WITH loc__Nump, THIS.this_oParentForm
                ENDIF

                *-- Secao de globalizacao automatica
                IF THIS.this_lAutomatico
                    loc__lcSql = "SELECT Dopps FROM SigCdOpd WHERE Autos = 1"
                    IF SQLEXEC(gnConnHandle, loc__lcSql, 'CrSigCdOpd') < 1 OR RECCOUNT('CrSigCdOpd') = 0
                        MsgErro('Nenhuma Opera' + CHR(231) + CHR(227) + 'o de Produ' + CHR(231) + CHR(227) + 'o definida como autom' + CHR(225) + 'tica de Movimento!!!', 'Excluir Globaliza' + CHR(231) + CHR(227) + 'o')
                        loc_llErro = .T.
                        EXIT
                    ENDIF
                    IF RECCOUNT('CrSigCdOpd') > 1
                        MsgErro('Mais de Uma Opera' + CHR(231) + CHR(227) + 'o de Produ' + CHR(231) + CHR(227) + 'o definida como autom' + CHR(225) + 'tica de Movimento!!!', 'Excluir Globaliza' + CHR(231) + CHR(227) + 'o')
                        loc_llErro = .T.
                        EXIT
                    ENDIF
                    loc__lcSql = "SELECT Dopps FROM SigCdOpd WHERE Autos = 2"
                    IF SQLEXEC(gnConnHandle, loc__lcSql, 'CrTmpOpp') < 1 OR RECCOUNT('CrTmpOpp') = 0
                        MsgErro('Nenhuma Opera' + CHR(231) + CHR(227) + 'o de Produ' + CHR(231) + CHR(227) + 'o definida como autom' + CHR(225) + 'tica de Encerramento!!!', 'Excluir Globaliza' + CHR(231) + CHR(227) + 'o')
                        loc_llErro = .T.
                        EXIT
                    ENDIF
                    IF RECCOUNT('CrTmpOpp') > 1
                        MsgErro('Mais de Uma Opera' + CHR(231) + CHR(227) + 'o de Produ' + CHR(231) + CHR(227) + 'o definida como autom' + CHR(225) + 'tica de Encerramento!!!', 'Excluir Globaliza' + CHR(231) + CHR(227) + 'o')
                        loc_llErro = .T.
                        EXIT
                    ENDIF
                    loc__DpTrf = CrTmpOpp.Dopps

                    *-- Recriar cursores para automatico
                    THIS.CriarCursorTrabalho("SigPdMvf",  "crSigPdMvf")
                    SELECT crSigPdMvf
                    INDEX ON nTrans TAG nTrans
                    THIS.CriarCursorTrabalho("SigCdNec",  "crSigCdNec")
                    SELECT crSigCdNec
                    INDEX ON Grupoos + ContaOs + GrupoDs + ContaDs + DTOS(Datas) + STR(nAceites,10) TAG Gravacao
                    THIS.CriarCursorTrabalho("SigCdNei",  "CrSigCdNei")
                    SELECT CrSigCdNei
                    INDEX ON nTrans TAG nTrans
                    THIS.CriarCursorTrabalho("SigMvHst",  "crSigMvHst")

                    LOCAL loc_aFldsCdNei(1)
                    =AFIELDS(loc_aFldsCdNei, 'CrSigCdNei')
                    CREATE CURSOR xNensi FROM ARRAY loc_aFldsCdNei

                    loc__lcSql = "SELECT * FROM SigCdLnf"
                    IF SQLEXEC(gnConnHandle, loc__lcSql, 'TmpLinf') < 1
                        loc_llErro = .T.
                        EXIT
                    ENDIF
                    SELECT TmpLinF
                    INDEX ON Linhas + STR(Ordems,2) TAG Linhas

                    loc__NopI = (loc__Nump * 10000) + 1
                    loc__NopF = (loc__Nump * 10000) + 9999
                    loc__Seq  = 1
                    loc__llTrue = .T.

                    loc__lcSql = "SELECT a.Cpros, a.Nops, b.Linhas, b.cUnis, a.EmpdopNops, a.CodTams," + ;
                                 " sum(a.Qtds) AS Qtds, Sum(a.Pesos) AS Pesos FROM SigOpPic a, SigCdPro b" + ;
                                 " WHERE a.Nops BETWEEN ?loc__NopI AND ?loc__NopF AND a.cpros = b.cpros" + ;
                                 " GROUP BY a.Cpros, a.Nops, b.Linhas, b.Cunis, a.EmpDopNops, a.CodTams"
                    IF SQLEXEC(gnConnHandle, loc__lcSql, 'TmpOpi') < 1
                        loc_llErro = .T.
                        EXIT
                    ENDIF
                    SELECT TmpOpi
                    INDEX ON Nops TAG Nops
                    INDEX ON Linhas + Cpros TAG Linha

                    loc_lScanAbort = .F.
                    SCAN
                        loc__lcSql = "SELECT a.Mats, a.Qtds, b.cunis, b.Pesoms, b.Cgrus, b.dpros, c.Fators, b.Varias, d.Mercs" + ;
                                     " FROM SigSubMv a, SigCdPro b, SigCdUni c, SigCdGrp d" + ;
                                     " WHERE a.empdopnums = '" + ALLTRIM(TmpOpi.EmpDopNums) + ;
                                     "' AND a.Cpros = '" + ALLTRIM(TmpOpi.Cpros) + ;
                                     "' AND a.citem2 = " + ALLTRIM(STR(TmpOpi.Citens)) + ;
                                     " AND a.mats = b.Cpros AND b.Cunis = c.Cunis AND b.Cgrus = d.Cgrus"
                        IF SQLEXEC(gnConnHandle, loc__lcSql, 'TmpCompo') < 1 OR RECCOUNT('TmpCompo') = 0
                            loc__lcSql = "SELECT a.Mats, b.cunis, b.Pesoms, b.Cgrus, b.dpros, c.Fators, b.Varias, d.Mercs," + ;
                                         " CASE WHEN e.Qtds IS NULL THEN a.Qtds ELSE e.Qtds END AS Qtds" + ;
                                         " FROM SigPrCpo a INNER JOIN SigCdPro b ON a.mats = b.Cpros" + ;
                                         " INNER JOIN SigCdUni c ON b.Cunis = c.Cunis" + ;
                                         " INNER JOIN SigCdGrp d ON b.Cgrus = d.Cgrus" + ;
                                         " LEFT JOIN SigSubCp e ON a.mats = e.Mats AND e.CodTams = '" + ALLTRIM(TmpOpi.CodTams) + "'" + ;
                                         " WHERE a.Cpros = '" + ALLTRIM(TmpOpi.Cpros) + "' AND a.mats = b.Cpros"
                            IF SQLEXEC(gnConnHandle, loc__lcSql, 'TmpCompo') < 1
                                loc_lScanAbort = .T.
                                EXIT
                            ENDIF
                        ENDIF
                        SELECT xNensi
                        ZAP
                        SELECT TmpLinF
                        IF NOT SEEK(TmpOpi.Linhas)
                            MsgAviso('Linha :' + ALLTRIM(TmpOpi.Linhas) + ' do Produto: ' + ALLTRIM(TmpOpi.Cpros) + ' nao Cadastrada!!!', '')
                            LOOP
                        ENDIF
                        loc__GrpO  = Grupos
                        loc__CtaO  = Contas
                        loc__DtGe  = loc__DtGera + TmpLinF.nDias
                        loc__Usuar2 = IIF(EMPTY(TmpLinF.Usuars), loc__Usuar, TmpLinF.Usuars)
                        IF DOW(loc__DtGe) = 7
                            loc__DtGe = loc__DtGe + 2
                        ELSE
                            IF DOW(loc__DtGe) = 1
                                loc__DtGe = loc__DtGe + 1
                            ENDIF
                        ENDIF
                        SKIP
                        SCAN WHILE Linhas = TmpOpi.Linhas
                            loc__GrpD = TmpLinF.Grupos
                            loc__CtaD = TmpLinF.Contas
                            SELECT CrSigCdNec
                            IF NOT SEEK(loc__GrpO + loc__CtaO + loc__GrpD + loc__CtaD + DTOS(loc__DtGe) + STR(TmpLinF.Ordems,10))
                                APPEND BLANK
                                REPLACE GrupoOs WITH loc__GrpO, ContaOs WITH loc__CtaO, GrupoDs WITH loc__GrpD, ;
                                        ContaDs WITH loc__CtaD, Datas WITH loc__DtGe, Dopps WITH CrSigCdOpd.Dopps, ;
                                        nTrans WITH loc__Seq, Usuars WITH loc__Usuar2, nAceites WITH TmpLinF.Ordems
                                loc__Seq = loc__Seq + 1
                            ENDIF
                            INSERT INTO CrSigPdMvf (Grupoos, Contaos, Grupods, Contads, NOps, NEnvs, Codpds, Unids, Pesos, Qtds, Ordems, nTrans, Usuars) ;
                                       VALUES (loc__GrpO, loc__CtaO, loc__GrpD, loc__CtaD, TmpOpi.Nops, TmpOpi.Nops, TmpOpi.Cpros, TmpOpi.Cunis, ;
                                               TmpOpi.Pesos, TmpOpi.Qtds, TmpLinF.Ordems, CrSigCdNec.nTrans, loc__Usuar2)
                            IF NOT EMPTY(TmpLinF.CGrus) OR NOT EMPTY(TmpLinF.Mercs)
                                SELECT TmpCompo
                                SCAN
                                    IF (CGrus = TmpLinF.CGrus AND NOT EMPTY(TmpLinF.CGrus)) OR ;
                                       (Mercs = TmpLinF.Mercs AND NOT EMPTY(TmpLinF.Mercs))
                                        IF TmpCompo.Varias = 1 AND TmpOpi.Cpros <> crSigCdPam.Ouros
                                            loc__QtAnt = TmpOpi.Pesos
                                            loc__PsAnt = TmpOpi.Pesos
                                        ELSE
                                            loc__QtAnt = TmpCompo.Qtds * TmpOpi.Qtds
                                            loc__PsAnt = IIF(TmpCompo.Fators <> 0, loc__QtAnt * TmpCompo.Fators, TmpCompo.Pesoms * TmpOpi.Qtds)
                                        ENDIF
                                        INSERT INTO xNensi (Nops, NEnvs, CMats, CDescs, CUnis, CGrus, Qtds, Pesos) ;
                                                    VALUES (TmpOpi.Nops, TmpOpi.Nops, TmpCompo.Mats, TmpCompo.Dpros, TmpCompo.CUnis, ;
                                                            TmpCompo.CGrus, loc__QtAnt, loc__PsAnt)
                                    ENDIF
                                ENDSCAN
                            ENDIF
                            SELECT xNensi
                            SCAN
                                SCATTER MEMVAR
                                INSERT INTO CrSigCdNei FROM MEMVAR
                                REPLACE nTrans WITH CrSigCdNec.nTrans IN CrSigCdNei
                            ENDSCAN
                            SELECT TmpLinF
                            loc__GrpO = Grupos
                            loc__CtaO = Contas
                            loc__DtGe = loc__DtGe + TmpLinF.nDias
                            IF DOW(loc__DtGe) = 7
                                loc__DtGe = loc__DtGe + 2
                            ELSE
                                IF DOW(loc__DtGe) = 1
                                    loc__DtGe = loc__DtGe + 1
                                ENDIF
                            ENDIF
                        ENDSCAN
                        loc__GrpD = crSigCdPam.GruConfs
                        loc__CtaD = crSigCdPam.ConConfs
                        SELECT CrSigCdNec
                        IF NOT SEEK(loc__GrpO + loc__CtaO + loc__GrpD + loc__CtaD + DTOS(loc__DtGe) + STR(99,10))
                            APPEND BLANK
                            REPLACE GrupoOs WITH loc__GrpO, ContaOs WITH loc__CtaO, GrupoDs WITH loc__GrpD, ;
                                    ContaDs WITH loc__CtaD, Datas WITH loc__DtGe, Dopps WITH loc__DpTrf, ;
                                    Usuars WITH loc__Usuar, nTrans WITH loc__Seq, nAceites WITH 99
                            loc__Seq = loc__Seq + 1
                        ENDIF
                        INSERT INTO CrSigPdMvf (Grupoos, Contaos, Grupods, Contads, NOps, NEnvs, Codpds, Unids, Pesos, Qtds, Ordems, nTrans, Usuars) ;
                                   VALUES (loc__GrpO, loc__CtaO, loc__GrpD, loc__CtaD, TmpOpi.Nops, TmpOpi.Nops, TmpOpi.Cpros, TmpOpi.Cunis, ;
                                           TmpOpi.Pesos, TmpOpi.Qtds, TmpLinF.Ordems, CrSigCdNec.nTrans, loc__Usuar)
                        SELECT xNensi
                        SCAN
                            SCATTER MEMVAR
                            INSERT INTO CrSigCdNei FROM MEMVAR
                            REPLACE nTrans WITH CrSigCdNec.nTrans IN CrSigCdNei
                        ENDSCAN
                        SELECT TmpOpi
                    ENDSCAN
                    IF loc_lScanAbort
                        loc_llErro = .T.
                        EXIT
                    ENDIF

                    SELECT CrSigCdNec
                    INDEX ON DTOS(Datas) + STR(nAceites,10) TAG Datas
                    loc_lScanAbort = .F.
                    SCAN
                        loc__nTran  = CrSigCdNec.nTrans
                        loc__Inicio2 = fGerUniqueKey(ALLTRIM(CrSigCdNec.Dopps) + loc__Empr)
                        loc__lcIds  = DTOS(CrSigCdNec.Datas) + TRANSFORM(fGerUniqueKey(DTOS(CrSigCdNec.Datas)), '@L 999999') + THIS.this_cSigKey
                        REPLACE Emps WITH loc__Empr, Numps WITH loc__Inicio2, Datars WITH DATETIME(), Nops WITH loc__NopI, ;
                                Autos WITH .T., CidChaves WITH loc__lcIds, ;
                                EmpDnPs WITH loc__Empr + CrSigCdNec.Dopps + STR(loc__Inicio2,10) IN CrSigCdNec
                        SELECT crSigPdMvf
                        =SEEK(loc__nTran)
                        SCAN WHILE nTrans = loc__nTran
                            REPLACE Emps WITH loc__Empr, Dopps WITH CrSigCdNec.Dopps, Numps WITH loc__Inicio2, ;
                                    Usuars WITH CrSigCdNec.Usuars, Datars WITH DATETIME(), Datas WITH CrSigCdNec.Datas, ;
                                    CidChaves WITH DTOS(CrSigCdNec.Datas) + TRANSFORM(fGerUniqueKey(DTOS(CrSigCdNec.Datas)), "@L 999999") + THIS.this_cSigKey, ;
                                    EmpDnPs WITH loc__Empr + CrSigCdNec.Dopps + STR(loc__Inicio2,10)
                        ENDSCAN
                        loc__lcSql = "SELECT * FROM SigCdOpd WHERE Dopps = '" + ALLTRIM(CrSigCdNec.Dopps) + "'"
                        IF SQLEXEC(gnConnHandle, loc__lcSql, 'CrSigCdOpd') < 1
                            loc_lScanAbort = .T.
                            EXIT
                        ENDIF
                        SELECT CrSigCdNei
                        =SEEK(loc__nTran)
                        SCAN WHILE nTrans = loc__nTran
                            REPLACE Emps WITH loc__Empr, Dopps WITH CrSigCdNec.Dopps, Numps WITH loc__Inicio2, ;
                                    CidChaves WITH fUniqueIds(), EmpDnPs WITH loc__Empr + CrSigCdNec.Dopps + STR(loc__Inicio2,10)
                            loc__lcSql = "SELECT Cgrus FROM SigCdPro WHERE Cpros = '" + ALLTRIM(CrSigCdNei.CMats) + "'"
                            IF SQLEXEC(gnConnHandle, loc__lcSql, 'LocalPro') < 1
                                loc_lScanAbort = .T.
                                EXIT
                            ENDIF
                            loc__lcSql = "SELECT cEstoqs FROM SigCdGrp WHERE Cgrus = '" + ALLTRIM(LocalPro.Cgrus) + "'"
                            IF SQLEXEC(gnConnHandle, loc__lcSql, 'LocalGru') < 1
                                loc_lScanAbort = .T.
                                EXIT
                            ENDIF
                            IF INLIST(crSigCdOpd.EstOrigs, 1, 2) AND (crSigCdOpd.BxOEsts = 2) AND (LocalGru.CEstoqs = 1)
                                loc__Oper = IIF(crSigCdOpd.EstOrigs = 1, 'E', 'S')
                                loc__lcIds = DTOS(CrSigCdNec.Datas) + loc__Oper + TRANSFORM(fGerUniqueKey(DTOS(CrSigCdNec.Datas)), "@L 999999") + THIS.this_cSigKey
                                loc_pSeq = 0
                                INSERT INTO crSigMvHst (Usuars, Datars, Emps, Opers, Dopes, Numes, Datas, CPros, Empos, Qtds, Grupos, ;
                                                      Estos, cIdChaves, EmpDopNums, EmpGruEsts, DtAlts, OriDopNums, Seqs) ;
                                              VALUES (CrSigCdNec.Usuars, DATETIME(), loc__Empr, loc__Oper, CrSigCdNec.Dopps, ;
                                                      CrSigCdNei.Numps, CrSigCdNec.Datas, CrSigCdNei.CMats, loc__Empr, CrSigCdNei.Qtds, ;
                                                      CrSigCdNec.Grupoos, CrSigCdNec.Contaos, loc__lcIds, ;
                                                      loc__Empr + CrSigCdNec.Dopps + STR(CrSigCdNei.Numps,6), ;
                                                      loc__Empr + CrSigCdNec.Grupoos + CrSigCdNec.Contaos, ;
                                                      DATETIME(), loc__Empr + CrSigCdNec.Dopps + STR(CrSigCdNei.Numps,6), loc_pSeq)
                                =fRecalculaP(crSigMvHst.Emps, crSigMvHst.Grupos, crSigMvHst.Estos, crSigMvHst.CPros, crSigMvHst.Datas, crSigMvHst.CodCors, crSigMvHst.CodTams)
                                =fRecalculaC(crSigMvHst.Emps, crSigMvHst.CPros, crSigMvHst.Datas)
                            ENDIF
                            IF INLIST(crSigCdOpd.EstDests, 1, 2) AND (crSigCdOpd.BxDEsts = 2) AND (LocalGru.CEstoqs = 1)
                                loc__Oper = IIF(crSigCdOpd.EstDests = 1, 'E', 'S')
                                loc__lcIds = DTOS(CrSigCdNec.Datas) + loc__Oper + TRANSFORM(fGerUniqueKey(DTOS(CrSigCdNec.Datas)), "@L 999999") + THIS.this_cSigKey
                                loc_pSeq = 0
                                INSERT INTO crSigMvHst (Usuars, Datars, Emps, Opers, Dopes, Numes, Datas, CPros, Empos, Qtds, Grupos, ;
                                                      Estos, cIdChaves, EmpDopNums, EmpGruEsts, DtAlts, OriDopNums, Seqs) ;
                                              VALUES (CrSigCdNec.Usuars, DATETIME(), loc__Empr, loc__Oper, CrSigCdNec.Dopps, ;
                                                      CrSigCdNei.Numps, CrSigCdNec.Datas, CrSigCdNei.CMats, loc__Empr, CrSigCdNei.Qtds, ;
                                                      CrSigCdNec.Grupods, CrSigCdNec.Contads, loc__lcIds, ;
                                                      loc__Empr + CrSigCdNec.Dopps + STR(CrSigCdNei.Numps,6), ;
                                                      loc__Empr + CrSigCdNec.Grupods + CrSigCdNec.Contads, ;
                                                      DATETIME(), loc__Empr + CrSigCdNec.Dopps + STR(CrSigCdNei.Numps,6), loc_pSeq)
                                =fRecalculaP(crSigMvHst.Emps, crSigMvHst.Grupos, crSigMvHst.Estos, crSigMvHst.CPros, crSigMvHst.Datas, crSigMvHst.CodCors, crSigMvHst.CodTams)
                                =fRecalculaC(crSigMvHst.Emps, crSigMvHst.CPros, crSigMvHst.Datas)
                            ENDIF
                            IF INLIST(crSigCdOpd.EstDests, 1, 2) AND crSigCdOpd.BxDEsts = 1
                                SELECT DISTINCT b.Nops, b.Cpros, b.Qtds ;
                                  FROM CrSigCdNei a, TmpOpi b ;
                                 WHERE a.nTrans = loc__nTran AND a.Nops = b.Nops ;
                                  INTO CURSOR TmpHis
                                loc__Oper = IIF(crSigCdOpd.EstDests = 1, 'E', 'S')
                                SELECT TmpHis
                                SCAN
                                    loc__lcIds = DTOS(CrSigCdNec.Datas) + loc__Oper + TRANSFORM(fGerUniqueKey(DTOS(CrSigCdNec.Datas)), "@L 999999") + THIS.this_cSigKey
                                    loc_pSeq = 0
                                    INSERT INTO crSigMvHst (Usuars, Datars, Emps, Opers, Dopes, Numes, Datas, CPros, Empos, Qtds, ;
                                                          Grupos, Estos, cIdChaves, EmpDopNums, EmpGruEsts, DtAlts, OriDopNums, Seqs) ;
                                                  VALUES (CrSigCdNec.Usuars, DATETIME(), loc__Empr, loc__Oper, CrSigCdNec.Dopps, ;
                                                          CrSigCdNec.Numps, CrSigCdNec.Datas, TmpHis.CPros, loc__Empr, TmpHis.Qtds, ;
                                                          CrSigCdNec.Grupods, CrSigCdNec.Contads, loc__lcIds, ;
                                                          loc__Empr + CrSigCdNec.Dopps + STR(CrSigCdNec.Numps,6), ;
                                                          loc__Empr + CrSigCdNec.Grupods + CrSigCdNec.Contads, ;
                                                          DATETIME(), loc__Empr + CrSigCdNec.Dopps + STR(CrSigCdNec.Numps,6), loc_pSeq)
                                    =fRecalculaP(crSigMvHst.Emps, crSigMvHst.Grupos, crSigMvHst.Estos, crSigMvHst.CPros, crSigMvHst.Datas, crSigMvHst.CodCors, crSigMvHst.CodTams)
                                    =fRecalculaC(crSigMvHst.Emps, crSigMvHst.CPros, crSigMvHst.Datas)
                                ENDSCAN
                            ENDIF
                            SELECT CrSigCdNei
                        ENDSCAN
                        IF loc_lScanAbort
                            EXIT
                        ENDIF
                        SELECT CrSigCdNec
                    ENDSCAN
                    IF loc_lScanAbort
                        loc_llErro = .T.
                        EXIT
                    ENDIF

                    *-- Marcar necessidades originais como subcontratadas
                    loc_lScanAbort = .F.
                    SELECT TmpOpi
                    SCAN
                        loc__lcSql = "SELECT CidChaves FROM SigCdNec WHERE EmpDnPs = '" + ALLTRIM(TmpOpi.EmpDopNops) + "'"
                        IF SQLEXEC(gnConnHandle, loc__lcSql, 'LocalNens') < 1
                            loc_lScanAbort = .T.
                            EXIT
                        ENDIF
                        SELECT LocalNens
                        SCAN
                            loc__lcUpdate = "UPDATE SigCdNec SET ChkSubn = ?loc__llTrue WHERE cidChaves = '" + ALLTRIM(LocalNens.CidChaves) + "'"
                            IF SQLEXEC(gnConnHandle, loc__lcUpdate) < 1
                                loc_lScanAbort = .T.
                                EXIT
                            ENDIF
                        ENDSCAN
                        IF loc_lScanAbort
                            EXIT
                        ENDIF
                        SELECT TmpOpi
                    ENDSCAN
                    IF loc_lScanAbort
                        loc_llErro = .T.
                        EXIT
                    ENDIF

                    *-- Commit transacao 2 (automatico)
                    SQLEXEC(gnConnHandle, "BEGIN TRAN")
                    loc_lTransAberta = .T.
                    IF NOT THIS.GravarCursorNoServidor('crSigPdMvf', 'SigPdMvf')
                        loc_llErro = .T.
                        EXIT
                    ENDIF
                    IF NOT THIS.GravarCursorNoServidor('crSigCdNec', 'SigCdNec')
                        loc_llErro = .T.
                        EXIT
                    ENDIF
                    IF NOT THIS.GravarCursorNoServidor('crSigMvHst', 'SigMvHst')
                        loc_llErro = .T.
                        EXIT
                    ENDIF
                    IF NOT THIS.GravarCursorNoServidor('CrSigCdNei', 'SigCdNei')
                        loc_llErro = .T.
                        EXIT
                    ENDIF
                    IF NOT fRecalculaP(.T.)
                        loc_llErro = .T.
                        EXIT
                    ENDIF
                    IF NOT fRecalculaC(.T., .F., .F.)
                        loc_llErro = .T.
                        EXIT
                    ENDIF
                    IF SQLEXEC(gnConnHandle, "COMMIT TRAN") < 1
                        MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Commit)")
                        loc_llErro = .T.
                        EXIT
                    ENDIF
                    loc_lTransAberta = .F.
                    DO FORM SigReGli WITH loc__Nump, THIS.this_oParentForm
                ENDIF && automatico

                loc_lSucesso = NOT loc_llErro
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF NOT loc_lSucesso AND loc_lTransAberta
            SQLEXEC(gnConnHandle, "ROLLBACK TRAN")
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CursorQuery(par_cTabela, par_cCursor, par_cCampo, par_xValor, par_cCampos)
    *--------------------------------------------------------------------------
        LOCAL loc_lcCampos, loc_lcQuery, loc_lcValor
        loc_lcCampos = IIF(PCOUNT() < 5 OR EMPTY(par_cCampos), "*", par_cCampos)
        loc_lcValor  = ALLTRIM(TRANSFORM(par_xValor))
        loc_lcQuery  = "SELECT " + loc_lcCampos + " FROM " + par_cTabela + ;
                       " WHERE " + par_cCampo + " = " + EscaparSQL(loc_lcValor)
        IF SQLEXEC(gnConnHandle, loc_lcQuery, par_cCursor) < 1
            SQLEXEC(gnConnHandle, "SELECT " + loc_lcCampos + " FROM " + par_cTabela + " WHERE 0=1", par_cCursor)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarCursorTrabalho(par_cTabela, par_cCursor)
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_nFlds
        LOCAL ARRAY loc_aFlds(1)
        loc_lSucesso = .F.
        TRY
            IF USED(par_cCursor)
                USE IN (par_cCursor)
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT TOP 0 * FROM " + par_cTabela, "xCrTmp4c_") > 0
                loc_nFlds = AFIELDS(loc_aFlds, "xCrTmp4c_")
                USE IN xCrTmp4c_
                CREATE CURSOR (par_cCursor) FROM ARRAY loc_aFlds
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao criar cursor de trabalho para " + par_cTabela, "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GravarCursorNoServidor(par_cCursor, par_cTabela)
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_nFlds, loc_i, loc_lcFields, loc_lcValues, loc_lcInsert
        LOCAL loc_xVal, loc_cTipo
        LOCAL ARRAY loc_aFlds(1)
        loc_lSucesso = .T.
        TRY
            IF USED(par_cCursor) AND RECCOUNT(par_cCursor) > 0
                loc_nFlds = AFIELDS(loc_aFlds, par_cCursor)
                loc_lcFields = ""
                FOR loc_i = 1 TO loc_nFlds
                    IF loc_i > 1
                        loc_lcFields = loc_lcFields + ","
                    ENDIF
                    loc_lcFields = loc_lcFields + loc_aFlds(loc_i, 1)
                ENDFOR
                GO TOP IN (par_cCursor)
                SCAN IN &par_cCursor
                    loc_lcValues = ""
                    FOR loc_i = 1 TO loc_nFlds
                        IF loc_i > 1
                            loc_lcValues = loc_lcValues + ","
                        ENDIF
                        loc_xVal  = EVALUATE(par_cCursor + "." + loc_aFlds(loc_i, 1))
                        loc_cTipo = loc_aFlds(loc_i, 2)
                        DO CASE
                            CASE ISNULL(loc_xVal)
                                loc_lcValues = loc_lcValues + "NULL"
                            CASE loc_cTipo $ "CM"
                                loc_lcValues = loc_lcValues + EscaparSQL(ALLTRIM(loc_xVal))
                            CASE loc_cTipo = "N"
                                loc_lcValues = loc_lcValues + ALLTRIM(STR(loc_xVal, 20, 6))
                            CASE loc_cTipo = "D"
                                IF EMPTY(loc_xVal)
                                    loc_lcValues = loc_lcValues + "NULL"
                                ELSE
                                    loc_lcValues = loc_lcValues + FormatarDataSQL(loc_xVal)
                                ENDIF
                            CASE loc_cTipo = "T"
                                IF EMPTY(loc_xVal)
                                    loc_lcValues = loc_lcValues + "NULL"
                                ELSE
                                    loc_lcValues = loc_lcValues + "'" + TTOC(loc_xVal, 3) + "'"
                                ENDIF
                            CASE loc_cTipo = "L"
                                loc_lcValues = loc_lcValues + IIF(loc_xVal, "1", "0")
                            OTHERWISE
                                loc_lcValues = loc_lcValues + "NULL"
                        ENDCASE
                    ENDFOR
                    loc_lcInsert = "INSERT INTO " + par_cTabela + " (" + loc_lcFields + ") VALUES (" + loc_lcValues + ")"
                    IF SQLEXEC(gnConnHandle, loc_lcInsert) < 1
                        loc_lSucesso = .F.
                        EXIT
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
