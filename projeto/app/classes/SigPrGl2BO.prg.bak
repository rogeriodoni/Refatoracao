*==============================================================================
* SIGPRGL2BO.PRG
* Business Object para Operacoes Selecionadas (SIGPRGL2)
* Herda de BusinessBase
* Processa operacoes selecionadas e gera OPs
*==============================================================================

DEFINE CLASS SigPrGl2BO AS BusinessBase

    *-- Conexao e sessao
    this_oConexao    = .NULL.   && poDataMgr - conexao principal
    this_oConexao2   = .NULL.   && poDataMgr2 - conexao para update/commit
    this_oFormPai    = .NULL.   && referencia ao form pai

    *-- Parametros recebidos na abertura
    this_lReserva      = .F.    && reserva automatica
    this_nEmphPdr      = 0      && empresa padrao do gerente
    this_lAutomatico   = .F.    && processamento automatico
    this_nNumeroDaOp   = 0      && numero da OP a gerar
    this_cPorDestino   = ""     && por destino (de PorDestino do form pai)

    *-- Estado de ordenacao do grid de operacoes
    this_cOrdConta = ""         && 'EMPDOPNUM' ou 'ENTREGA'

    *-- Estado do processamento
    this_lProcessado              = .F.   && .T. apos Processar executado com sucesso
    this_nContadorSelecionadas    = 0     && qtd de operacoes com Flag=.T.

    *-- Dados do registro corrente do TmpCabec
    this_lFlag     = .F.   && checkbox de selecao
    this_cEmps     = ""    && empresa
    this_cDopes    = ""    && tipo de operacao
    this_nNumes    = 0     && numero da operacao
    this_dDatas    = {}    && data de emissao
    this_dEntregas = {}    && data de entrega
    this_nPeso     = 0     && peso total
    this_cContav   = ""    && codigo do responsavel
    this_cConta    = ""    && codigo do cliente
    this_cDConta   = ""    && descricao do cliente
    this_cObs      = ""    && observacao da operacao
    this_cNotas    = ""    && documento fiscal
    this_cJobs     = ""    && codigo do JOB
    this_cGrupoDs  = ""    && grupo de destino
    this_cContaDs  = ""    && conta de destino

    *--------------------------------------------------------------------------
    * INIT
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            THIS.this_cTabela     = "SigMvCab"
            THIS.this_cCampoChave = "EmpDopNums"

            THIS.this_lEmEdicao       = .F.
            THIS.this_lNovoRegistro   = .F.
            THIS.this_lDadosAlterados = .F.
            THIS.this_lProcessado     = .F.
            THIS.this_cMensagemErro   = ""

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SigPrGl2BO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContexto - recebe parametros do form pai
    *--------------------------------------------------------------------------
    PROCEDURE ConfigurarContexto(par_oFormPai, par_oConexao, par_oConexao2, ;
                                  par_lReserva, par_nEmphPdr, par_lAutomatico, ;
                                  par_nNumeroDaOp, par_cPorDestino)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            THIS.this_oFormPai    = par_oFormPai
            THIS.this_oConexao    = par_oConexao
            THIS.this_oConexao2   = par_oConexao2
            THIS.this_lReserva    = IIF(VARTYPE(par_lReserva)    = "L", par_lReserva,    .F.)
            THIS.this_nEmphPdr    = IIF(VARTYPE(par_nEmphPdr)    = "N", par_nEmphPdr,    0)
            THIS.this_lAutomatico = IIF(VARTYPE(par_lAutomatico) = "L", par_lAutomatico, .F.)
            THIS.this_nNumeroDaOp = IIF(VARTYPE(par_nNumeroDaOp) = "N", par_nNumeroDaOp, 0)
            THIS.this_cPorDestino = IIF(VARTYPE(par_cPorDestino) = "C", ALLTRIM(par_cPorDestino), "")

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SigPrGl2BO.ConfigurarContexto")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * OrdenarGrade - aplica ordenacao em TmpCabec
    *--------------------------------------------------------------------------
    PROCEDURE OrdenarGrade()
        LOCAL loc_lSucesso, loc_cOrdConta

        loc_lSucesso  = .F.

        TRY
            loc_cOrdConta = UPPER(IIF(VARTYPE(THIS.this_cOrdConta) = "C", THIS.this_cOrdConta, ""))

            IF USED("TmpCabec")
                SELECT TmpCabec
                IF !EMPTY(loc_cOrdConta) AND INLIST(loc_cOrdConta, "ENTREGA", "EMPDOPNUM")
                    SET ORDER TO &loc_cOrdConta.
                ELSE
                    SET ORDER TO EmpDopNum
                    THIS.this_cOrdConta = UPPER(ORDER("TmpCabec"))
                ENDIF
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SigPrGl2BO.OrdenarGrade")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * DefinirOrdemMovimentacao - ordena TmpCabec por EmpDopNum
    *--------------------------------------------------------------------------
    PROCEDURE DefinirOrdemMovimentacao()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF USED("TmpCabec") AND UPPER(ORDER("TmpCabec")) <> "EMPDOPNUM"
                SELECT TmpCabec
                SET ORDER TO EmpDopNum
                GO TOP
                THIS.this_cOrdConta = UPPER(ORDER("TmpCabec"))
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SigPrGl2BO.DefinirOrdemMovimentacao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * DefinirOrdemEntrega - ordena TmpCabec por Entrega
    *--------------------------------------------------------------------------
    PROCEDURE DefinirOrdemEntrega()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF USED("TmpCabec") AND UPPER(ORDER("TmpCabec")) <> "ENTREGA"
                SELECT TmpCabec
                SET ORDER TO Entrega
                GO TOP
                THIS.this_cOrdConta = UPPER(ORDER("TmpCabec"))
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SigPrGl2BO.DefinirOrdemEntrega")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SincronizarItens - filtra TmpItens para o registro corrente de TmpCabec
    *--------------------------------------------------------------------------
    PROCEDURE SincronizarItens()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF USED("TmpItens") AND USED("TmpCabec") AND !EOF("TmpCabec")
                SELECT TmpItens
                SET ORDER TO EmpDopNum
                SET KEY TO TmpCabec.Emps + TmpCabec.Dopes + STR(TmpCabec.Numes, 6)
                GO TOP
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SigPrGl2BO.SincronizarItens")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SelecionarTodos - marca Flag=.T. em todos os registros de TmpCabec
    *--------------------------------------------------------------------------
    PROCEDURE SelecionarTodos()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF USED("TmpCabec")
                REPLACE ALL Flag WITH .T. IN TmpCabec
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SigPrGl2BO.SelecionarTodos")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarTodos - marca Flag=.F. em todos os registros de TmpCabec
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarTodos()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF USED("TmpCabec")
                REPLACE ALL Flag WITH .F. IN TmpCabec
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SigPrGl2BO.DesmarcarTodos")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarSelecao - verifica operacoes selecionadas (Flag=.T.) e mesmo JOB
    * Retorna .T. se valido; .F. com mensagem em this_cMensagemErro
    *--------------------------------------------------------------------------
    PROCEDURE ValidarSelecao()
        LOCAL loc_lSucesso, loc_nContador, loc_cJob

        loc_lSucesso = .F.
        THIS.this_cMensagemErro        = ""
        THIS.this_nContadorSelecionadas = 0

        TRY
            IF !USED("TmpCabec")
                THIS.this_cMensagemErro = "Cursor TmpCabec n" + CHR(227) + "o est" + CHR(225) + ;
                                          " dispon" + CHR(237) + "vel"
                loc_lSucesso = .F.
            ENDIF

            SELECT TmpCabec
            SET ORDER TO EmpDopNum

            loc_nContador = 0
            GO TOP
            loc_cJob = TmpCabec.Jobs

            SCAN FOR Flag
                loc_nContador = loc_nContador + 1
                IF loc_cJob <> TmpCabec.Jobs
                    THIS.this_cMensagemErro = "N" + CHR(227) + "o " + CHR(233) + ;
                        " permitido gerar OPs de opera" + CHR(231) + CHR(245) + ;
                        "es com Jobs diferentes."
                    loc_lSucesso = .F.
                ENDIF
            ENDSCAN

            THIS.this_nContadorSelecionadas = loc_nContador

            IF loc_nContador = 0
                THIS.this_cMensagemErro = "Nenhuma Opera" + CHR(231) + CHR(227) + "o Foi Selecionada!!!"
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SigPrGl2BO.ValidarSelecao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarOperacoes - logica principal do botao Processar
    * Calcula estoque disponivel, monta TmpFinal, abre form de continuidade
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarOperacoes()
        LOCAL loc_lSucesso, loc_cCidQuerys, loc_cQuery
        LOCAL loc_pEdI, loc_pEdF, loc_pItn
        LOCAL loc_nEstoque, loc_nProduzir, loc_nSaldo, loc_xBaixa

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""
        THIS.this_lProcessado   = .F.

        TRY
            *-- 1. Validar selecao
            IF !THIS.ValidarSelecao()
                loc_lSucesso = .F.
            ENDIF

            *-- 2. IDs unicos para cursores temporarios no SQL Server
            loc_cCidQuerys = fUniqueIds()

            *-- 3. Carregar centros de estoque (SigCdCeg sem tipo 1)
            loc_cQuery = "Select * From SigCdCeg Where TpCads <> 1"
            IF SQLEXEC(gnConnHandle, loc_cQuery, "TmpCeg") < 1
                MsgErro("Favor Reinicializar o Processo!!!", ;
                        "Falha na Conex" + CHR(227) + "o (TmpCeg)")
                loc_lSucesso = .F.
            ENDIF

            *-- 4. Popular CrSigTempd com dados de prioridade de estoque
            IF USED("CrSigTempd")
                USE IN CrSigTempd
            ENDIF
            SET NULL ON
            CREATE CURSOR CrSigTempd (Grupos C(10), Contas C(10), CodObs N(3,0), ;
                                      Emps C(3), CidChaves C(64), CidQuerys C(20))
            SET NULL OFF

            SELECT TmpCeg
            IF RECCOUNT() > 0
                SCAN
                    SELECT CrSigTempd
                    APPEND BLANK
                    REPLACE Grupos    WITH TmpCeg.Grupos, ;
                            Contas    WITH TmpCeg.Contas, ;
                            CodObs    WITH TmpCeg.Priors, ;
                            Emps      WITH TmpCeg.Emps, ;
                            CidChaves WITH fUniqueIds(), ;
                            CidQuerys WITH loc_cCidQuerys
                ENDSCAN
            ELSE
                SELECT CrSigTempd
                APPEND BLANK
                REPLACE Grupos    WITH crSigCdPam.GrupoEsts, ;
                        Contas    WITH crSigCdPam.ContaEsts, ;
                        CodObs    WITH 1, ;
                        Emps      WITH go_4c_Sistema.cCodEmpresa, ;
                        CidChaves WITH fUniqueIds(), ;
                        CidQuerys WITH loc_cCidQuerys
            ENDIF

            *-- 5. Persistir CrSigTempd no SQL Server
            SELECT CrSigTempd
            SCAN
                loc_cQuery = "INSERT INTO SigTempd (Grupos, Contas, CodObs, Emps, " + ;
                             "CidChaves, CidQuerys, Dpros) VALUES (" + ;
                             EscaparSQL(CrSigTempd.Grupos)    + ", " + ;
                             EscaparSQL(CrSigTempd.Contas)    + ", " + ;
                             FormatarNumeroSQL(CrSigTempd.CodObs, 0) + ", " + ;
                             EscaparSQL(CrSigTempd.Emps)      + ", " + ;
                             EscaparSQL(CrSigTempd.CidChaves) + ", " + ;
                             EscaparSQL(CrSigTempd.CidQuerys) + ", " + ;
                             "' ')"
                IF SQLEXEC(gnConnHandle, loc_cQuery) < 1
                    MsgErro("Favor reinicializar o processo.", ;
                            "Falha ao persistir SigTempd")
                    loc_lSucesso = .F.
                ENDIF
            ENDSCAN

            *-- 6. Carregar estoque disponivel (SigMvEst + SigTempd - UNION)
            loc_cQuery = "Select a.*, b.CodObs as Priors From SigMvEst a, SigTempd b " + ;
                         "Where a.Grupos = b.Grupos And a.Estos = b.Contas And " + ;
                               "a.Emps = b.Emps And a.Sqtds > 0 " + ;
                         "Union " + ;
                         "Select a.*, b.CodObs as Priors From SigMvEst a, SigTempd b " + ;
                         "Where a.Grupos = b.Grupos And b.Contas = '' And " + ;
                               "a.Emps = b.Emps And a.Sqtds > 0"

            IF USED("TmpEstoque")
                USE IN TmpEstoque
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cQuery, "TmpEstoque") < 1
                MsgErro("Favor Reinicializar o Processo!!!", ;
                        "Falha na Conex" + CHR(227) + "o (TmpEstoque)")
                loc_lSucesso = .F.
            ENDIF

            *-- Limpar registro temporario no SQL Server
            SQLEXEC(gnConnHandle, "DELETE FROM SigTempD WHERE CidQuerys = " + EscaparSQL(loc_cCidQuerys))

            *-- 7. Criar cursores de saldo disponivel
            SET NULL ON
            CREATE CURSOR TmpSaldo (CPros C(14), CodCors C(4), CodTams C(4), ;
                                    Saldo N(12,3), Disps N(12,3), Fabrs N(12,3), DispFs N(12,3))
            INDEX ON CPros + CodCors + CodTams TAG CPros
            SET NULL OFF

            SET NULL ON
            CREATE CURSOR TmpSaldg (Emps C(3), Grupos C(10), Estos C(10), CPros C(14), ;
                                    CodCors C(4), CodTams C(4), Saldo N(12,3), Disps N(12,3), ;
                                    Priors N(2,0), Reservs N(12,3))
            INDEX ON CPros + CodCors + CodTams + STR(Priors, 2) + Grupos + Estos + Emps TAG CPros
            INDEX ON Emps + Grupos + Estos + CPros + CodCors + CodTams TAG GruEstPro
            SET NULL OFF

            *-- 8. Consolidar estoques por produto/cor/tam em TmpSaldo e TmpSaldg
            SELECT TmpEstoque
            SCAN
                SELECT TmpSaldo
                IF !SEEK(TmpEstoque.CPros + TmpEstoque.CodCors + TmpEstoque.CodTams)
                    INSERT INTO TmpSaldo (CPros, CodCors, CodTams, Saldo, Disps) ;
                               VALUES   (TmpEstoque.CPros, TmpEstoque.CodCors, ;
                                         TmpEstoque.CodTams, 0, 0)
                ENDIF
                REPLACE Saldo WITH Saldo + TmpEstoque.Sqtds, ;
                        Disps WITH Disps + TmpEstoque.Sqtds IN TmpSaldo

                INSERT INTO TmpSaldg (Grupos, Estos, CPros, CodCors, CodTams, ;
                                      Saldo, Disps, Priors, Emps) ;
                           VALUES    (TmpEstoque.Grupos, TmpEstoque.Estos, ;
                                      TmpEstoque.CPros, TmpEstoque.CodCors, TmpEstoque.CodTams, ;
                                      TmpEstoque.Sqtds, TmpEstoque.Sqtds, ;
                                      TmpEstoque.Priors, TmpEstoque.Emps)
            ENDSCAN

            *-- 9. Carregar operacao de transferencia de reservas (SigCdOpe)
            IF USED("crSigCdOpe")
                USE IN crSigCdOpe
            ENDIF
            SQLEXEC(gnConnHandle, "SELECT * FROM SigCdOpe WHERE Dopes = " + ;
                    EscaparSQL(crSigCdPam.TransfRes), "crSigCdOpe")

            *-- 10. Descontar estoques ja reservados em andamento
            IF !EMPTY(crSigCdPam.TransfRes) AND !EOF("crSigCdOpe") AND (crSigCdOpe.Estoqs <> 1)
                loc_pEdI = go_4c_Sistema.cCodEmpresa + crSigCdPam.TransfRes + STR(0, 6)
                loc_pEdF = go_4c_Sistema.cCodEmpresa + crSigCdPam.TransfRes + STR(999999, 6)

                loc_cQuery = "Select EmpDopNums, GrupoOs, ContaOs, Emps, Dopes, Numes " + ;
                             "From SigMvCab " + ;
                             "Where EmpDopNums Between " + EscaparSQL(loc_pEdI) + ;
                             " And " + EscaparSQL(loc_pEdF) + ;
                             " Order By EmpDopNums"

                IF USED("TempEest")
                    USE IN TempEest
                ENDIF
                IF SQLEXEC(gnConnHandle, loc_cQuery, "TempEest") < 1
                    MsgErro("Favor Reinicializar o Processo!!!", ;
                            "Falha na Conex" + CHR(227) + "o (TempEest)")
                    loc_lSucesso = .F.
                ENDIF

                SELECT TempEest
                SCAN
                    loc_cEdn = TempEest.EmpDopNums
                    IF USED("TempEestI")
                        USE IN TempEestI
                    ENDIF
                    SQLEXEC(gnConnHandle, "SELECT * FROM SigMvItn WHERE EmpDopNums = " + ;
                            EscaparSQL(loc_cEdn), "TempEestI")

                    SELECT TempEestI
                    SCAN
                        IF (Qtds - QtBaixas > 0)
                            loc_pItn = TempEestI.CItens

                            loc_cQuery = "Select * " + ;
                                         "From SigMvIts " + ;
                                         "Where EmpDopNums = " + EscaparSQL(loc_cEdn) + ;
                                         " And CItens = " + FormatarNumeroSQL(loc_pItn, 0)

                            IF USED("TempEsti2")
                                USE IN TempEsti2
                            ENDIF
                            IF SQLEXEC(gnConnHandle, loc_cQuery, "TempEsti2") < 1
                                MsgErro("Favor Reinicializar o Processo!!!", ;
                                        "Falha na Conex" + CHR(227) + "o (TempEsti2)")
                                loc_lSucesso = .F.
                            ENDIF

                            SELECT TempEsti2
                            GO TOP

                            IF EOF("TempEsti2")
                                SELECT TmpSaldo
                                IF !SEEK(TempEestI.CPros)
                                    INSERT INTO TmpSaldo (CPros) VALUES (TempEestI.CPros)
                                ENDIF
                                REPLACE Saldo WITH Saldo - (TempEestI.Qtds - TempEestI.QtBaixas), ;
                                        Disps WITH Disps - (TempEestI.Qtds - TempEestI.QtBaixas)

                                SELECT TmpSaldg
                                SET ORDER TO GruEstPro
                                IF !SEEK(TempEest.Emps + TempEest.GrupoOs + ;
                                         TempEest.ContaOs + TempEestI.CPros)
                                    INSERT INTO TmpSaldg (Emps, Grupos, Estos, CPros, Priors) ;
                                               VALUES   (TempEest.Emps, TempEest.GrupoOs, ;
                                                         TempEest.ContaOs, TempEestI.CPros, 99)
                                ENDIF
                                REPLACE Saldo WITH Saldo - (TempEestI.Qtds - TempEestI.QtBaixas), ;
                                        Disps WITH Disps - (TempEestI.Qtds - TempEestI.QtBaixas)
                            ELSE
                                SELECT TempEsti2
                                SCAN
                                    loc_nSaldo = TempEsti2.Qtds - TempEsti2.QtBaixas

                                    SELECT TmpSaldo
                                    IF !SEEK(TempEsti2.CPros + TempEsti2.CodCors + TempEsti2.CodTams)
                                        INSERT INTO TmpSaldo (CPros, CodCors, CodTams) ;
                                                   VALUES   (TempEsti2.CPros, ;
                                                             TempEsti2.CodCors, TempEsti2.CodTams)
                                    ENDIF
                                    REPLACE Saldo WITH Saldo - loc_nSaldo, ;
                                            Disps WITH Disps - loc_nSaldo

                                    SELECT TmpSaldg
                                    SET ORDER TO GruEstPro
                                    IF !SEEK(TempEest.Emps + TempEest.GrupoOs + ;
                                             TempEest.ContaOs + TempEsti2.CPros + ;
                                             TempEsti2.CodCors + TempEsti2.CodTams)
                                        INSERT INTO TmpSaldg (Emps, Grupos, Estos, ;
                                                              CPros, CodCors, CodTams, Priors) ;
                                                   VALUES   (TempEest.Emps, TempEest.GrupoOs, ;
                                                             TempEest.ContaOs, TempEsti2.CPros, ;
                                                             TempEsti2.CodCors, TempEsti2.CodTams, 99)
                                    ENDIF
                                    REPLACE Saldo WITH Saldo - loc_nSaldo, ;
                                            Disps WITH Disps - loc_nSaldo
                                ENDSCAN
                            ENDIF
                        ENDIF
                    ENDSCAN
                ENDSCAN
            ENDIF

            *-- 11. Montar TmpFinal com itens das operacoes selecionadas
            SET NULL ON
            CREATE CURSOR TmpFinal (Emps C(3), Dopes C(20), Numes N(6,0), CPros C(14), ;
                                    Qtds N(10,3), Peso N(9,3), Saldo N(10,3), ;
                                    Estoque N(10,3), Produzir N(10,3), ;
                                    Obs M NULL, Obsps M NULL, ;
                                    Datas D NULL, Entregas D NULL, ;
                                    CodCors C(4), CodTams C(4), Linhas C(10), ;
                                    Citens N(10,0), Reffs C(40), Notas C(6), ;
                                    Dpros C(40), GrupoDs C(10), ContaDs C(10), ;
                                    KeySelM L, Fabrs N(10,3), KeyPdes L, Jobs C(10))
            INDEX ON CPros + CodCors + CodTams TAG CPros
            SET NULL OFF

            SELECT TmpItens
            SET KEY TO
            SET ORDER TO CPros

            SCAN
                SELECT TmpCabec
                SEEK TmpItens.Emps + TmpItens.Dopes + STR(TmpItens.Numes, 6)
                IF !Flag
                    LOOP
                ENDIF

                SELECT TmpOper
                SEEK TmpItens.Dopes

                SELECT TmpItens
                IF (Saldo > 0)
                    loc_nEstoque  = 0
                    loc_nProduzir = 0

                    IF (TmpOper.ChkObs <> 1 AND !EMPTY(TmpItens.Obs)) OR ;
                       !SEEK(TmpItens.CPros + TmpItens.CodCors + TmpItens.CodTams, "TmpSaldo") OR ;
                       EMPTY(crSigCdPam.TransfRes) OR ;
                       (TmpOper.Reservas = 2 AND !THIS.this_lReserva) OR ;
                       TmpSaldo.Disps < 0
                        loc_nProduzir = TmpItens.Saldo
                    ELSE
                        =SEEK(TmpItens.CPros + TmpItens.CodCors + TmpItens.CodTams, "TmpSaldo")
                        loc_nEstoque = TmpSaldo.Disps
                        IF (TmpSaldo.Disps >= TmpItens.Saldo)
                            REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps - TmpItens.Saldo
                        ELSE
                            loc_nProduzir = TmpItens.Saldo - TmpSaldo.Disps
                            REPLACE TmpSaldo.Disps WITH 0
                        ENDIF
                    ENDIF

                    IF USED("crSigCdPro")
                        USE IN crSigCdPro
                    ENDIF
                    SQLEXEC(gnConnHandle, "SELECT * FROM SigCdPro WHERE CPros = " + ;
                            EscaparSQL(TmpItens.CPros), "crSigCdPro")

                    INSERT INTO TmpFinal (Emps, Dopes, Numes, CPros, Qtds, Peso, Saldo, ;
                                          Estoque, Produzir, Obsps, Obs, Datas, Entregas, ;
                                          CodCors, CodTams, Linhas, Citens, Reffs, Notas, ;
                                          Dpros, GrupoDs, ContaDs, Jobs) ;
                               VALUES   (TmpItens.Emps, TmpItens.Dopes, TmpItens.Numes, ;
                                          TmpItens.CPros, TmpItens.Qtds, TmpItens.Peso, ;
                                          TmpItens.Saldo, TmpItens.Saldo - loc_nProduzir, ;
                                          loc_nProduzir, NVL(TmpItens.Obs, ""), ;
                                          NVL(TmpCabec.Obs, ""), ;
                                          NVL(TmpCabec.Datas, CTOD("")), ;
                                          NVL(TmpCabec.Entregas, CTOD("")), ;
                                          TmpItens.CodCors, TmpItens.CodTams, ;
                                          TmpItens.Linhas, TmpItens.CItens, ;
                                          crSigCdPro.Reffs, TmpItens.Notas, ;
                                          TmpItens.Dpros, TmpCabec.GrupoDs, ;
                                          TmpCabec.ContaDs, TmpCabec.Jobs)
                ENDIF
            ENDSCAN

            *-- 12. Distribuir diferenca de saldo entre grupos (TmpSaldg)
            SELECT TmpSaldo
            SCAN
                IF Saldo # Disps
                    loc_xBaixa = Saldo - Disps
                    SELECT TmpSaldg
                    SET ORDER TO CPros
                    =SEEK(TmpSaldo.CPros + TmpSaldo.CodCors + TmpSaldo.CodTams)
                    SCAN WHILE CPros = TmpSaldo.CPros AND CodCors = TmpSaldo.CodCors AND ;
                               CodTams = TmpSaldo.CodTams AND loc_xBaixa > 0
                        IF TmpSaldg.Disps >= loc_xBaixa
                            REPLACE TmpSaldg.Disps WITH TmpSaldg.Disps - loc_xBaixa
                            loc_xBaixa = 0
                        ELSE
                            loc_xBaixa = loc_xBaixa - TmpSaldg.Disps
                            REPLACE TmpSaldg.Disps WITH 0
                        ENDIF
                    ENDSCAN
                ENDIF
            ENDSCAN

            *-- 13. Se DopEsts configurado: calcular estoque em fabricacao
            IF !EMPTY(crSigCdPac.DopEsts)
                THIS.ProcessarFabrico(loc_cCidQuerys)
            ENDIF

            *-- 14. Restaurar filtro de TmpItens para sincronismo com TmpCabec
            SELECT TmpItens
            SET ORDER TO EmpDopNum
            SET KEY TO TmpCabec.Emps + TmpCabec.Dopes + STR(TmpCabec.Numes, 6)
            GO TOP

            THIS.this_lProcessado = .T.
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SigPrGl2BO.ProcessarOperacoes")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarFabrico - calcula estoque em fabricacao e monta TmpFinalG
    * Chamado internamente por ProcessarOperacoes quando DopEsts nao vazio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarFabrico(par_cCidQuerys)
        LOCAL loc_lSucesso, loc_cSql, loc_llFalse, loc_llData
        LOCAL loc_nEstoque, loc_nProduzir, loc_xBaixa, loc_cEdn

        loc_lSucesso = .F.
        loc_llFalse  = .F.

        TRY
            SET NULL ON
            CREATE CURSOR TmpFabr (Priors N(2,0), Nops N(10,0), Fases C(10), ;
                                   CPros C(14), CodCors C(4), CodTams C(4), ;
                                   Qtds N(10,3), Disps N(12,3), Reservs N(12,3))
            INDEX ON CPros + CodCors + CodTams + STR(Priors, 2) + STR(Nops, 10) TAG CPros
            SET NULL OFF

            loc_cSql = "Select a.Nops, a.Cpros, a.CodCors, a.CodTams, sum(a.Qtds) as Qtds " + ;
                       "From SigOpPic a, SigCdNec b " + ;
                       "Where a.Dopes = " + EscaparSQL(crSigCdPac.DopEsts) + ;
                       " And a.EmpDopNops = b.EmpDnps And b.Chksubn = 0" + ;
                       " And a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       " group by a.Nops, a.Cpros, a.CodCors, a.CodTams"

            IF USED("TmpOpi")
                USE IN TmpOpi
            ENDIF
            SQLEXEC(gnConnHandle, loc_cSql, "TmpOpi")

            SELECT TmpOpi
            SCAN
                SELECT TmpSaldo
                IF !SEEK(TmpOpi.CPros + TmpOpi.CodCors + TmpOpi.CodTams)
                    INSERT INTO TmpSaldo (CPros, CodCors, CodTams) ;
                               VALUES   (TmpOpi.CPros, TmpOpi.CodCors, TmpOpi.CodTams)
                ENDIF
                REPLACE Fabrs  WITH Fabrs  + TmpOpi.Qtds, ;
                        DispFs WITH DispFs + TmpOpi.Qtds IN TmpSaldo

                INSERT INTO TmpFabr (Nops, CPros, CodCors, CodTams, Qtds, Priors) ;
                           VALUES   (TmpOpi.Nops, TmpOpi.CPros, TmpOpi.CodCors, ;
                                     TmpOpi.CodTams, TmpOpi.Qtds, 0)

                loc_cSql = "Select GrupoDs From SigPdMvf Where Nops = " + ;
                           TRANSFORM(TmpOpi.Nops) + " Order by CidChaves Desc"
                IF USED("TmpMfas")
                    USE IN TmpMfas
                ENDIF
                SQLEXEC(gnConnHandle, loc_cSql, "TmpMfas")

                SELECT TmpMfas
                GO TOP
                REPLACE Fases WITH TmpMfas.GrupoDs IN TmpFabr

                loc_nEstoque  = 0
                loc_nProduzir = 0

                IF SEEK(TmpOpi.CPros + TmpOpi.CodCors + TmpOpi.CodTams, "TmpFinal", "CPros")
                    IF TmpSaldo.Fabrs >= TmpFinal.Produzir
                        loc_nEstoque  = TmpFinal.Produzir
                        loc_nProduzir = 0
                        REPLACE TmpSaldo.DispFs WITH TmpSaldo.DispFs - TmpFinal.Produzir IN TmpSaldo
                    ELSE
                        loc_nEstoque  = TmpSaldo.Fabrs
                        loc_nProduzir = TmpFinal.Produzir - TmpSaldo.Fabrs
                        REPLACE DispFs WITH 0 IN TmpSaldo
                    ENDIF
                    REPLACE Produzir WITH loc_nProduzir, ;
                            Fabrs    WITH loc_nEstoque IN TmpFinal
                ENDIF
            ENDSCAN

            *-- Distribuir fabricacao por grupo (TmpFabr)
            SELECT TmpSaldo
            SCAN
                IF Fabrs # DispFs
                    loc_xBaixa = Fabrs - DispFs
                    SELECT TmpFabr
                    SET ORDER TO CPros
                    =SEEK(TmpSaldo.CPros + TmpSaldo.CodCors + TmpSaldo.CodTams)
                    SCAN WHILE CPros = TmpSaldo.CPros AND CodCors = TmpSaldo.CodCors AND ;
                               CodTams = TmpSaldo.CodTams AND loc_xBaixa > 0
                        IF (TmpFabr.Qtds - TmpFabr.Disps) >= loc_xBaixa
                            REPLACE TmpFabr.Disps WITH TmpFabr.Disps + loc_xBaixa IN TmpFabr
                            loc_xBaixa = 0
                        ELSE
                            loc_xBaixa = loc_xBaixa - (TmpFabr.Qtds - TmpFabr.Disps)
                            REPLACE TmpFabr.Disps WITH Qtds IN TmpFabr
                        ENDIF
                    ENDSCAN
                ENDIF
            ENDSCAN

            *-- Montar TmpFinalG (agrupado por produto/cor/tam)
            SET NULL ON
            CREATE CURSOR TmpFinalG (Flag C(1), CPros C(14), CodCors C(4), CodTams C(4), ;
                                     Linhas C(10), Qtds N(10,3), Saldo N(10,3), ;
                                     Estoque N(10,3), Produzir N(10,3), Fabrs N(10,3), ;
                                     Produzir2 N(10,3), TotVenda N(10,3), QtdMins N(10,3), ;
                                     KeySelM L, KeySelMP L, UsuLibs C(10))
            INDEX ON CPros + CodCors + CodTams TAG CPros
            SET NULL OFF

            SELECT CPros, CodCors, CodTams, Linhas, ;
                   SUM(Qtds)     AS Qtds, ;
                   SUM(Saldo)    AS Saldo, ;
                   SUM(Estoque)  AS Estoque, ;
                   SUM(Produzir) AS Produzir, ;
                   SUM(Fabrs)    AS Fabrs ;
            FROM TmpFinal ;
            INTO CURSOR Selecao ;
            GROUP BY CPros, CodCors, CodTams, Linhas

            *-- Historico de vendas (se nMeses configurado)
            IF crSigCdPac.nMeses > 0
                loc_llData = GOMONTH(DATE(), -crSigCdPac.nMeses)

                loc_cSql = "Select a.cpros, a.qtds, b.Caixas, b.copers, b.opers, a.opers " + ;
                           "From SigMvItn a, SigCdOpe b, SigMvCab c " + ;
                           "Where a.EmpDopNums = c.EmpDopNums And a.Emps = " + ;
                           EscaparSQL(go_4c_Sistema.cCodEmpresa) + " And c.datas >= " + ;
                           FormatarDataSQL(loc_llData) + ;
                           " And a.dopes = b.dopes and b.tipoops in(4,5)"

                IF USED("LocalEest")
                    USE IN LocalEest
                ENDIF
                SQLEXEC(gnConnHandle, loc_cSql, "LocalEest")

                SELECT CPros, ;
                       SUM(Qtds * IIF((Caixas = 1 AND copers = 1) OR ;
                                      (Caixas <> 1 AND Opers = 1) OR ;
                                      (Caixas <> 1 AND Opers = 3), 1, -1)) AS Qtds ;
                FROM LocalEest ;
                GROUP BY CPros ;
                INTO CURSOR Vendas READWRITE

                SELECT Vendas
                INDEX ON CPros TAG CPros
            ENDIF

            *-- Popular TmpFinalG
            SELECT TmpFinalG
            SCATTER MEMVAR BLANK

            SELECT Selecao
            SCAN
                SCATTER MEMVAR
                m.flag = "+"

                loc_cSql = "Select QtMinFabs From SigCdPro Where Cpros = " + EscaparSQL(Selecao.CPros)
                IF USED("CrSigCdPro")
                    USE IN CrSigCdPro
                ENDIF
                SQLEXEC(gnConnHandle, loc_cSql, "CrSigCdPro")

                m.QtdMins = 0
                IF (crSigCdPac.GerPcps = 2 AND !THIS.this_lReserva) OR ;
                   (crSigCdPac.GerPcps <> 2 AND THIS.this_lReserva)
                    m.QtdMins = crSigCdPro.QtMinFabs
                ENDIF

                IF USED("Vendas") AND SEEK(m.CPros, "Vendas", "CPros")
                    m.TotVenda = Vendas.Qtds
                ELSE
                    m.TotVenda = 0
                ENDIF

                m.Produzir2 = IIF(m.QtdMins > 0 AND m.Produzir > 0 AND ;
                                  m.Produzir < m.QtdMins, ;
                                  m.QtdMins - m.Produzir, 0)

                SELECT TmpFinalG
                APPEND BLANK
                GATHER MEMVAR
            ENDSCAN

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SigPrGl2BO.ProcessarFabrico")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - popula propriedades do BO com o registro corrente
    * par_cAliasCursor: alias do cursor fonte (TmpCabec)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_lFlag     = NVL(Flag,     .F.)
                THIS.this_cEmps     = ALLTRIM(NVL(Emps,     ""))
                THIS.this_cDopes    = ALLTRIM(NVL(Dopes,    ""))
                THIS.this_nNumes    = NVL(Numes,    0)
                THIS.this_dDatas    = NVL(Datas,    {})
                THIS.this_dEntregas = NVL(Entregas, {})
                THIS.this_nPeso     = NVL(Peso,     0)
                THIS.this_cContav   = ALLTRIM(NVL(Contav,   ""))
                THIS.this_cConta    = ALLTRIM(NVL(Conta,    ""))
                THIS.this_cDConta   = ALLTRIM(NVL(DConta,   ""))
                THIS.this_cObs      = NVL(Obs,      "")
                THIS.this_cNotas    = ALLTRIM(NVL(Notas,    ""))
                THIS.this_cJobs     = ALLTRIM(NVL(Jobs,     ""))
                THIS.this_cGrupoDs  = ALLTRIM(NVL(GrupoDs,  ""))
                THIS.this_cContaDs  = ALLTRIM(NVL(ContaDs,  ""))
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SigPrGl2BO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - retorna chave no formato EmpDopNum (C(29))
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cEmps) + ;
               ALLTRIM(THIS.this_cDopes) + ;
               STR(THIS.this_nNumes, 6)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigMvCab com as propriedades correntes
    * Executa auditoria apos gravacao bem-sucedida
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResultado

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            loc_cChave = ALLTRIM(THIS.this_cEmps) + ALLTRIM(THIS.this_cDopes) + ;
                         STR(THIS.this_nNumes, 6)

            loc_cSQL = "INSERT INTO SigMvCab (" + ;
                       "Emps, Dopes, Numes, EmpDopNums, " + ;
                       "Datas, PrazoEnts, PbRus, " + ;
                       "Vends, IClis, NEmps, " + ;
                       "Notas, Jobs, GrupoDs, ContaDs, Obses" + ;
                       ") VALUES (" + ;
                       EscaparSQL(THIS.this_cEmps) + ", " + ;
                       EscaparSQL(THIS.this_cDopes) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumes, 0) + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                       FormatarDataSQL(THIS.this_dEntregas) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPeso, 3) + ", " + ;
                       EscaparSQL(THIS.this_cContav) + ", " + ;
                       EscaparSQL(THIS.this_cConta) + ", " + ;
                       EscaparSQL(THIS.this_cDConta) + ", " + ;
                       EscaparSQL(THIS.this_cNotas) + ", " + ;
                       EscaparSQL(THIS.this_cJobs) + ", " + ;
                       EscaparSQL(THIS.this_cGrupoDs) + ", " + ;
                       EscaparSQL(THIS.this_cContaDs) + ", " + ;
                       EscaparSQL(THIS.this_cObs) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado > 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao inserir registro em SigMvCab"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro em Inserir: " + loc_oErro.Message + ;
                                       " LN=" + TRANSFORM(loc_oErro.LineNo)
            MsgErro(THIS.this_cMensagemErro, "Erro SigPrGl2BO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigMvCab com as propriedades correntes
    * Executa auditoria apos gravacao bem-sucedida
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResultado

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            loc_cChave = ALLTRIM(THIS.this_cEmps) + ALLTRIM(THIS.this_cDopes) + ;
                         STR(THIS.this_nNumes, 6)

            loc_cSQL = "UPDATE SigMvCab SET " + ;
                       "Datas = "     + FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                       "PrazoEnts = " + FormatarDataSQL(THIS.this_dEntregas) + ", " + ;
                       "PbRus = "     + FormatarNumeroSQL(THIS.this_nPeso, 3) + ", " + ;
                       "Vends = "     + EscaparSQL(THIS.this_cContav) + ", " + ;
                       "IClis = "     + EscaparSQL(THIS.this_cConta) + ", " + ;
                       "NEmps = "     + EscaparSQL(THIS.this_cDConta) + ", " + ;
                       "Notas = "     + EscaparSQL(THIS.this_cNotas) + ", " + ;
                       "Jobs = "      + EscaparSQL(THIS.this_cJobs) + ", " + ;
                       "GrupoDs = "   + EscaparSQL(THIS.this_cGrupoDs) + ", " + ;
                       "ContaDs = "   + EscaparSQL(THIS.this_cContaDs) + ", " + ;
                       "Obses = "     + EscaparSQL(THIS.this_cObs) + ", " + ;
                       "DtAlts = GETDATE() " + ;
                       "WHERE EmpDopNums = " + EscaparSQL(loc_cChave)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao atualizar registro em SigMvCab"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro em Atualizar: " + loc_oErro.Message + ;
                                       " LN=" + TRANSFORM(loc_oErro.LineNo)
            MsgErro(THIS.this_cMensagemErro, "Erro SigPrGl2BO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigMvCab pela chave EmpDopNums
    * Executa auditoria apos exclusao bem-sucedida
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResultado

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            loc_cChave = ALLTRIM(THIS.this_cEmps) + ALLTRIM(THIS.this_cDopes) + ;
                         STR(THIS.this_nNumes, 6)

            THIS.RegistrarAuditoria("DELETE")

            loc_cSQL = "DELETE FROM SigMvCab " + ;
                       "WHERE EmpDopNums = " + EscaparSQL(loc_cChave)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao excluir registro em SigMvCab"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro em ExecutarExclusao: " + loc_oErro.Message + ;
                                       " LN=" + TRANSFORM(loc_oErro.LineNo)
            MsgErro(THIS.this_cMensagemErro, "Erro SigPrGl2BO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * EncerrarForm - libera referencia ao form pai e restaura Enabled
    *--------------------------------------------------------------------------
    PROCEDURE EncerrarForm()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oFormPai) = "O" AND !ISNULL(THIS.this_oFormPai)
                THIS.this_oFormPai.Enabled = .T.
            ENDIF
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SigPrGl2BO.EncerrarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - limpa referencias ao destruir o BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.this_oConexao  = .NULL.
        THIS.this_oConexao2 = .NULL.
        THIS.this_oFormPai  = .NULL.
    ENDPROC

ENDDEFINE
