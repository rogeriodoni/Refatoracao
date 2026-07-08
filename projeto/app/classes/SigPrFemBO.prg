*==============================================================================
* SIGPRFEMBO.PRG
* Business Object: An" + CHR(225) + "lise de Produ" + CHR(231) + CHR(227) + "o
* Tipo: OPERACIONAL (sem tabela CRUD principal)
* Cursores de trabalho: Entradas, Saidas, Saldos, SaldoAnt, Falhas, TmpResumo
*==============================================================================

DEFINE CLASS SigPrFemBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Identificacao da entidade (OPERACIONAL - sem CRUD direto)
    *--------------------------------------------------------------------------
    this_cTabela      = ""
    this_cCampoChave  = ""

    *--------------------------------------------------------------------------
    * Parametros de entrada fornecidos pelo Form
    *--------------------------------------------------------------------------
    this_dDatai           = {}
    this_dDataf           = {}
    this_cDemonstrativo   = ""

    *--------------------------------------------------------------------------
    * Contexto de processamento (carregados em CarregarCursoresReferencia)
    *--------------------------------------------------------------------------
    this_cEmpresa     = ""
    this_cCodMat      = ""
    this_cDopeBals    = ""
    this_nNdFechas    = 0

    *--------------------------------------------------------------------------
    * Chave do demonstrativo selecionado
    *--------------------------------------------------------------------------
    this_cGruposDmo   = ""
    this_cContasDmo   = ""

    *--------------------------------------------------------------------------
    * Totalizadores: preenchidos por ProcessarAnalise() e lidos pelo Form
    *--------------------------------------------------------------------------
    this_nSaldoIni    = 0
    this_nSaldoaFun   = 0
    this_nTotalEntra  = 0
    this_nTotalSaida  = 0
    this_nPesagem     = 0
    this_nSaldoFunc   = 0
    this_nFalhaFunc   = 0

    *==========================================================================
    * INIT
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        loc_lResultado = DODEFAULT("")
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria
    *==========================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cDemonstrativo
    ENDPROC

    *==========================================================================
    * LimparDados
    *==========================================================================
    PROCEDURE LimparDados()
        THIS.this_dDatai           = {}
        THIS.this_dDataf           = {}
        THIS.this_cDemonstrativo   = ""
        THIS.this_cEmpresa         = ""
        THIS.this_cCodMat          = ""
        THIS.this_cDopeBals        = ""
        THIS.this_nNdFechas        = 0
        THIS.this_cGruposDmo       = ""
        THIS.this_cContasDmo       = ""
        THIS.this_nSaldoIni        = 0
        THIS.this_nSaldoaFun       = 0
        THIS.this_nTotalEntra      = 0
        THIS.this_nTotalSaida      = 0
        THIS.this_nPesagem         = 0
        THIS.this_nSaldoFunc       = 0
        THIS.this_nFalhaFunc       = 0
    ENDPROC

    *==========================================================================
    * CarregarCursoresReferencia - Carrega tabelas de referencia do SQL Server
    * Equivalente ao PROCEDURE Init do legado (CursorQuery calls)
    *==========================================================================
    PROCEDURE CarregarCursoresReferencia()
        LOCAL loc_lResultado, loc_oErro, loc_lOk
        loc_lResultado = .F.

        TRY
            loc_lOk = .T.

            * SigCdPam - Parametros do sistema (Ouros, DopeBals)
            IF USED("crSigCdPam")
                USE IN crSigCdPam
            ENDIF
            IF loc_lOk
                IF SQLEXEC(gnConnHandle, "SELECT Ouros, DopeBals FROM SigCdPam", "crSigCdPam") < 1
                    MsgErro("Falha ao carregar SigCdPam", "Erro de Conex" + CHR(227) + "o")
                    loc_lOk = .F.
                ELSE
                    SELECT crSigCdPam
                    GO TOP
                    THIS.this_cCodMat   = ALLTRIM(crSigCdPam.Ouros)
                    THIS.this_cDopeBals = ALLTRIM(crSigCdPam.DopeBals)
                ENDIF
            ENDIF

            * SigCdPac - Parametros de conta (ndFechas)
            IF USED("crSigCdPac")
                USE IN crSigCdPac
            ENDIF
            IF loc_lOk
                IF SQLEXEC(gnConnHandle, "SELECT ndFechas FROM SigCdPac", "crSigCdPac") < 1
                    MsgErro("Falha ao carregar SigCdPac", "Erro de Conex" + CHR(227) + "o")
                    loc_lOk = .F.
                ELSE
                    SELECT crSigCdPac
                    GO TOP
                    THIS.this_nNdFechas = crSigCdPac.ndFechas
                ENDIF
            ENDIF

            * SigCdOpe - Operacoes de estoque
            IF USED("crSigCdOpe")
                USE IN crSigCdOpe
            ENDIF
            IF loc_lOk
                IF SQLEXEC(gnConnHandle, "SELECT Dopes, Origems, EstOrigs, Destinos, EstDests, Opers FROM SigCdOpe", "crSigCdOpe") < 1
                    MsgErro("Falha ao carregar SigCdOpe", "Erro de Conex" + CHR(227) + "o")
                    loc_lOk = .F.
                ELSE
                    SELECT crSigCdOpe
                    INDEX ON Dopes TAG Dopes
                ENDIF
            ENDIF

            * SigCdOpd - Operacoes de producao
            IF USED("crSigCdOpd")
                USE IN crSigCdOpd
            ENDIF
            IF loc_lOk
                IF SQLEXEC(gnConnHandle, "SELECT Dopps, Origems, EstOrigs, Destinos, EstDests FROM SigCdOpd", "crSigCdOpd") < 1
                    MsgErro("Falha ao carregar SigCdOpd", "Erro de Conex" + CHR(227) + "o")
                    loc_lOk = .F.
                ELSE
                    SELECT crSigCdOpd
                    INDEX ON Dopps TAG Dopps
                ENDIF
            ENDIF

            * SigCdGcr - Grupos de controle de rastreamento
            IF USED("crSigCdGcr")
                USE IN crSigCdGcr
            ENDIF
            IF loc_lOk
                IF SQLEXEC(gnConnHandle, "SELECT Codigos, UnifBals, GerBals FROM SigCdGcr", "crSigCdGcr") < 1
                    MsgErro("Falha ao carregar SigCdGcr", "Erro de Conex" + CHR(227) + "o")
                    loc_lOk = .F.
                ELSE
                    SELECT crSigCdGcr
                    INDEX ON Codigos TAG Codigos
                ENDIF
            ENDIF

            * SigCdUni - Unidades de medida
            IF USED("crSigCdUni")
                USE IN crSigCdUni
            ENDIF
            IF loc_lOk
                IF SQLEXEC(gnConnHandle, "SELECT * FROM SigCdUni", "crSigCdUni") < 1
                    MsgErro("Falha ao carregar SigCdUni", "Erro de Conex" + CHR(227) + "o")
                    loc_lOk = .F.
                ELSE
                    SELECT crSigCdUni
                    INDEX ON CUnis TAG CUnis
                ENDIF
            ENDIF

            * SigCdGrp - Grupos de produto (LocalGru)
            IF USED("LocalGru")
                USE IN LocalGru
            ENDIF
            IF loc_lOk
                IF SQLEXEC(gnConnHandle, "SELECT * FROM SigCdGrp", "LocalGru") < 1
                    MsgErro("Falha ao carregar SigCdGrp", "Erro de Conex" + CHR(227) + "o")
                    loc_lOk = .F.
                ELSE
                    SELECT LocalGru
                    INDEX ON Cgrus TAG Cgrus
                ENDIF
            ENDIF

            * SigCdGpr - Grupos de produto raiz (LocalGgrp)
            IF USED("LocalGgrp")
                USE IN LocalGgrp
            ENDIF
            IF loc_lOk
                IF SQLEXEC(gnConnHandle, "SELECT * FROM SigCdGpr", "LocalGgrp") < 1
                    MsgErro("Falha ao carregar SigCdGpr", "Erro de Conex" + CHR(227) + "o")
                    loc_lOk = .F.
                ELSE
                    SELECT LocalGgrp
                    INDEX ON codigos TAG codigos
                ENDIF
            ENDIF

            IF loc_lOk
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em CarregarCursoresReferencia")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CriarCursoresTrabalho - Cria cursores de trabalho para processamento
    * Equivalente ao PROCEDURE Load do legado
    *==========================================================================
    PROCEDURE CriarCursoresTrabalho()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            SET NULL ON

            IF USED("Entradas")
                USE IN Entradas
            ENDIF
            CREATE CURSOR Entradas (Emps C(3), TpOps C(15), Qtde N(12,3))
            INDEX ON Emps + TpOps TAG TpOps

            IF USED("Saidas")
                USE IN Saidas
            ENDIF
            CREATE CURSOR Saidas (Emps C(3), TpOps C(15), Qtde N(12,3))
            INDEX ON Emps + TpOps TAG TpOps

            IF USED("Saldos")
                USE IN Saldos
            ENDIF
            CREATE CURSOR Saldos (Grupos C(10), Contas C(10), Qtde N(12,3), Emps C(3))
            INDEX ON Grupos TAG Grupos
            INDEX ON Grupos + Contas TAG GruConta

            IF USED("SaldoAnt")
                USE IN SaldoAnt
            ENDIF
            CREATE CURSOR SaldoAnt (Grupos C(10), Contas C(10), Qtde N(12,3), Emps C(3))
            INDEX ON Grupos TAG Grupos
            INDEX ON Grupos + Contas TAG GruConta

            IF USED("Falhas")
                USE IN Falhas
            ENDIF
            CREATE CURSOR Falhas (Grupos C(10), Contas C(10), Qtde N(12,3), ;
                                  Entra N(12,3), Saida N(12,3), Emps C(3))
            INDEX ON Grupos TAG Grupos
            INDEX ON Grupos + Contas TAG GruConta

            IF USED("TmpResumo")
                USE IN TmpResumo
            ENDIF
            CREATE CURSOR TmpResumo (Flag L, Flag2 L, Grupo C(10), Conta C(10), CMats C(14), CUnis C(3), ;
                PesoEnts N(12,3), QtdeEnts N(12,3), PesoSais N(12,3), QtdeSais N(12,3), ;
                Saldoi N(12,3), Pesagem N(12,3), FReal N(12,3), FAdmin N(12,3), Saldof N(12,3), ;
                PesoPEnts N(12,3), PesoPSais N(12,3), PfTrabs N(9,2), Flag3 L, Varias N(1), ;
                PesoFabre N(12,3), PesoFabrs N(12,3), cUniPs C(3), CodCors C(4), CodTams C(4), ;
                Visivel L, Agregas N(1))
            INDEX ON CMats + CodCors + CodTams TAG cpros
            INDEX ON Grupo + Conta + CMats + CodCors + CodTams TAG GrConMat FOR Visivel

            SET NULL OFF
            loc_lResultado = .T.

        CATCH TO loc_oErro
            SET NULL OFF
            MsgErro(loc_oErro.Message, "Erro em CriarCursoresTrabalho")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BuscarDemonstrativo - Lookup/validacao para o campo Demonstrativo
    * Retorna .T. se encontrou registro, .F. caso contrario
    *==========================================================================
    PROCEDURE BuscarDemonstrativo(par_cValor)
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            IF NOT EMPTY(par_cValor)
                IF USED("crSigPrDmoLkp")
                    USE IN crSigPrDmoLkp
                ENDIF
                IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Nome FROM SigPrDmo WHERE Nome = " + EscaparSQL(ALLTRIM(par_cValor)), "crSigPrDmoLkp") >= 1
                    SELECT crSigPrDmoLkp
                    GO TOP
                    IF NOT EOF()
                        loc_lResultado = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BuscarDemonstrativo")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ProcessarAnalise - Processamento principal da Analise de Producao
    * Equivalente ao PROCEDURE Click do botao Processar no legado
    * Popula: this_n* totalizadores + cursores TmpImp/Cabecalho para impressao
    *==========================================================================
    PROCEDURE ProcessarAnalise()
        LOCAL loc_lResultado, loc_oErro, loc_lOk
        LOCAL loc_lcEmp, loc_lcCodMat, loc_lcConfig, loc_lcChave, loc_lcQuery
        LOCAL loc_lnSaldoIni, loc_lnPesagem, loc_lnSaldoFunc, loc_lnSaldoaFun, loc_lnFalhaFunc
        LOCAL loc_lnTotalEntra, loc_lnTotalSaida
        LOCAL loc_loBarra
        PRIVATE pDat, pDtI, pDtF, pDatI

        loc_lResultado = .F.

        TRY
            loc_lcEmp    = go_4c_Sistema.cCodEmpresa
            loc_lcConfig = THIS.this_cDemonstrativo

            SELECT crSigCdPam
            GO TOP
            loc_lcCodMat = ALLTRIM(crSigCdPam.Ouros)

            * Validacoes
            IF EMPTY(THIS.this_dDataf)
                MsgAviso("A Data Final Deve Ser Informada!!!", "Valida" + CHR(231) + CHR(227) + "o")
            ELSE
                IF THIS.this_dDatai > THIS.this_dDataf
                    MsgAviso("A Data Final Deve Ser Maior Que a Data Inicial!!!", "Valida" + CHR(231) + CHR(227) + "o")
                ELSE
                    IF EMPTY(loc_lcConfig)
                        MsgAviso("A Configura" + CHR(231) + CHR(227) + "o Deve Ser Informada!!!", "Valida" + CHR(231) + CHR(227) + "o")
                    ELSE
                        * Limpa cursores de trabalho
                        ZAP IN Saldos
                        ZAP IN SaldoAnt
                        ZAP IN Falhas
                        ZAP IN Entradas
                        ZAP IN Saidas

                        loc_lOk = .T.

                        * Carrega configuracao do demonstrativo
                        IF USED("crSigPrDmo")
                            USE IN crSigPrDmo
                        ENDIF
                        IF loc_lOk
                            IF SQLEXEC(gnConnHandle, "SELECT Grupos, Contas FROM SigPrDmo WHERE Nome = " + EscaparSQL(loc_lcConfig), "crSigPrDmo") < 1
                                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (SigPrDmo)")
                                loc_lOk = .F.
                            ELSE
                                SELECT crSigPrDmo
                                GO TOP
                                THIS.this_cGruposDmo = ALLTRIM(crSigPrDmo.Grupos)
                                THIS.this_cContasDmo = ALLTRIM(crSigPrDmo.Contas)
                            ENDIF
                        ENDIF

                        loc_lcChave = loc_lcEmp + THIS.this_cGruposDmo + THIS.this_cContasDmo

                        * Saldo Inicial (historico ate dia anterior)
                        pDat = THIS.this_dDatai - 1
                        loc_lnSaldoIni = 0

                        IF loc_lOk
                            IF USED("crSigMvHst")
                                USE IN crSigMvHst
                            ENDIF
                            loc_lcQuery = "SELECT TOP 1 Sqtds FROM SigMvHst " + ;
                                          "WHERE EmpGruEsts = " + EscaparSQL(loc_lcChave) + " AND " + ;
                                          "CPros = " + EscaparSQL(loc_lcCodMat) + " AND " + ;
                                          "Datas <= ?pDat ORDER BY cIdChaves DESC"
                            IF SQLEXEC(gnConnHandle, loc_lcQuery, "crSigMvHst") < 1
                                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (crSigMvHst)")
                                loc_lOk = .F.
                            ELSE
                                SELECT crSigMvHst
                                GO TOP
                                IF NOT EOF()
                                    loc_lnSaldoIni = crSigMvHst.SQtds
                                ENDIF
                            ENDIF
                        ENDIF

                        * TmpPesag - configuracao de pesagem (Operas='P')
                        IF USED("TmpPesag")
                            USE IN TmpPesag
                        ENDIF
                        IF loc_lOk
                            loc_lcQuery = "SELECT Grupos, Contas, TpOps FROM SigCdDpr " + ;
                                          "WHERE Operas = 'P' AND Nome = " + EscaparSQL(loc_lcConfig)
                            IF SQLEXEC(gnConnHandle, loc_lcQuery, "TmpPesag") < 1
                                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (TmpPesag)")
                                loc_lOk = .F.
                            ELSE
                                SELECT TmpPesag
                                INDEX ON Grupos + Contas TAG GruConta
                            ENDIF
                        ENDIF

                        * TmpSaldo - configuracao de saldo c/funcionario (Operas='H')
                        IF USED("TmpSaldo")
                            USE IN TmpSaldo
                        ENDIF
                        IF loc_lOk
                            loc_lcQuery = "SELECT Grupos, Contas, TpOps FROM SigCdDpr " + ;
                                          "WHERE Operas = 'H' AND Nome = " + EscaparSQL(loc_lcConfig)
                            IF SQLEXEC(gnConnHandle, loc_lcQuery, "TmpSaldo") < 1
                                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (TmpSaldo)")
                                loc_lOk = .F.
                            ELSE
                                SELECT TmpSaldo
                                INDEX ON Grupos + Contas TAG GruConta
                            ENDIF
                        ENDIF

                        * TmpEntra - configuracao de entradas (Operas='E')
                        IF USED("TmpEntra")
                            USE IN TmpEntra
                        ENDIF
                        IF loc_lOk
                            loc_lcQuery = "SELECT Grupos, Contas, TpOps FROM SigCdDpr " + ;
                                          "WHERE Operas = 'E' AND Nome = " + EscaparSQL(loc_lcConfig)
                            IF SQLEXEC(gnConnHandle, loc_lcQuery, "TmpEntra") < 1
                                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (TmpEntra)")
                                loc_lOk = .F.
                            ELSE
                                SELECT TmpEntra
                                INDEX ON Grupos + Contas + TpOps TAG GruConTp
                            ENDIF
                        ENDIF

                        * TmpSaida - configuracao de saidas (Operas='S')
                        IF USED("TmpSaida")
                            USE IN TmpSaida
                        ENDIF
                        IF loc_lOk
                            loc_lcQuery = "SELECT Grupos, Contas, TpOps FROM SigCdDpr " + ;
                                          "WHERE Operas = 'S' AND Nome = " + EscaparSQL(loc_lcConfig)
                            IF SQLEXEC(gnConnHandle, loc_lcQuery, "TmpSaida") < 1
                                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (TmpSaida)")
                                loc_lOk = .F.
                            ELSE
                                SELECT TmpSaida
                                INDEX ON Grupos + Contas + TpOps TAG GruConTp
                            ENDIF
                        ENDIF

                        pDtI = THIS.this_dDatai
                        pDtF = CTOT(DTOC(THIS.this_dDataf) + " 23:59:59")

                        * TmpPro - todos os produtos
                        IF USED("TmpPro")
                            USE IN TmpPro
                        ENDIF
                        IF loc_lOk
                            loc_lcQuery = "SELECT CPros, DPros, CUnis, CGrus, Varias, Custofs, MoeCusfs, MatPrincs, cUniPs " + ;
                                          "FROM SigCdPro"
                            IF SQLEXEC(gnConnHandle, loc_lcQuery, "TmpPro") < 1
                                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (TmpPro)")
                                loc_lOk = .F.
                            ELSE
                                SELECT TmpPro
                                INDEX ON CPros TAG CPros
                            ENDIF
                        ENDIF

                        * crProducao - movimentos de producao no periodo
                        IF USED("crProducao")
                            USE IN crProducao
                        ENDIF
                        IF loc_lOk
                            loc_lcQuery = "SELECT a.Datas, a.Emps, a.Dopps, a.Numps, a.GrupoOs, a.ContaOs, " + ;
                                          "a.GrupoDs, a.ContaDs, a.cIdChaves, b.EmpDnps, b.Servicos, " + ;
                                          "b.CMats, b.TpOps, b.Qtds, b.Pesos, b.cIdChaves as ChaveB, b.Nops " + ;
                                          "FROM SigCdNec a, SigCdNei b " + ;
                                          "WHERE a.Emps = " + EscaparSQL(loc_lcEmp) + " AND " + ;
                                          "a.Datas BETWEEN ?pDtI AND ?pDtF AND " + ;
                                          "a.EmpDNPs = b.EmpDNPs " + ;
                                          "ORDER BY b.cIdChaves"
                            IF SQLEXEC(gnConnHandle, loc_lcQuery, "crProducao") < 1
                                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (crProducao)")
                                loc_lOk = .F.
                            ENDIF
                        ENDIF

                        * TmpOpi - itens de ordem de producao
                        IF USED("TmpOpi")
                            USE IN TmpOpi
                        ENDIF
                        IF loc_lOk
                            IF SQLEXEC(gnConnHandle, "SELECT CPros, Nops FROM SigOpPic", "TmpOpi") < 1
                                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (TmpOpi)")
                                loc_lOk = .F.
                            ELSE
                                SELECT TmpOpi
                                INDEX ON Nops TAG Nops
                            ENDIF
                        ENDIF

                        * crSigCdNei - itens de producao (Distinct, sem servicos)
                        IF loc_lOk
                            IF USED("crSigCdNei")
                                USE IN crSigCdNei
                            ENDIF
                            SELECT DISTINCT EmpDnps, Servicos, CMats, Pesos, ChaveB, TpOps, Qtds, Nops ;
                                   FROM crProducao ;
                                   WHERE NOT Servicos ;
                                   INTO CURSOR crSigCdNei READWRITE
                            SELECT crSigCdNei
                            INDEX ON EmpDnps TAG EmpDnps
                            SET ORDER TO EmpDnps
                        ENDIF

                        * crSigCdNec - cabecalhos de producao (Distinct)
                        IF loc_lOk
                            IF USED("crSigCdNec")
                                USE IN crSigCdNec
                            ENDIF
                            SELECT DISTINCT Datas, Emps, Dopps, Numps, GrupoOs, ContaOs, GrupoDs, ContaDs, cIdChaves ;
                                   FROM crProducao ;
                                   ORDER BY Datas, Emps, Dopps, Numps, GrupoOs, ContaOs, GrupoDs, ContaDs, cIdChaves ;
                                   INTO CURSOR crSigCdNec
                        ENDIF

                        * Processa movimentos de producao -> Entradas/Saidas
                        IF loc_lOk
                            LOCAL loc_llEOrigem, loc_llEDestino, loc_llSOrigem, loc_llSDestino
                            LOCAL loc_lcEdn, loc_lcMaterial, loc_lcChave1, loc_lcChave2
                            LOCAL loc_lOk2, loc_lcTemp, loc_lcAlias

                            SELECT crSigCdNec
                            loc_loBarra = CREATEOBJECT("fwprogressbar", "Processando Mov. Produ" + CHR(231) + CHR(227) + "o", RECCOUNT())
                            loc_loBarra.Show
                            SCAN
                                loc_loBarra.UpDate(.T.)

                                =SEEK(crSigCdNec.Dopps, "crSigCdOpd", "Dopps")

                                loc_llEOrigem  = .F.
                                loc_llEDestino = .F.
                                loc_llSOrigem  = .F.
                                loc_llSDestino = .F.

                                IF (crSigCdOpd.Origems = 1)
                                    IF (SEEK(crSigCdNec.GrupoOs + crSigCdNec.ContaOs, "TmpEntra") OR ;
                                        SEEK(crSigCdNec.GrupoOs + SPACE(10), "TmpEntra")) AND (crSigCdOpd.EstOrigs = 1)
                                        loc_llEOrigem = .T.
                                    ENDIF
                                    IF (SEEK(crSigCdNec.GrupoOs + crSigCdNec.ContaOs, "TmpSaida") OR ;
                                        SEEK(crSigCdNec.GrupoOs + SPACE(10), "TmpSaida")) AND (crSigCdOpd.EstOrigs = 2)
                                        loc_llSOrigem = .T.
                                    ENDIF
                                ENDIF

                                IF (crSigCdOpd.Destinos = 1)
                                    IF (SEEK(crSigCdNec.GrupoDs + crSigCdNec.ContaDs, "TmpEntra") OR ;
                                        SEEK(crSigCdNec.GrupoDs + SPACE(10), "TmpEntra")) AND (crSigCdOpd.EstDests = 1)
                                        loc_llEDestino = .T.
                                    ENDIF
                                    IF (SEEK(crSigCdNec.GrupoDs + crSigCdNec.ContaDs, "TmpSaida") OR ;
                                        SEEK(crSigCdNec.GrupoDs + SPACE(10), "TmpSaida")) AND (crSigCdOpd.EstDests = 2)
                                        loc_llSDestino = .T.
                                    ENDIF
                                ENDIF

                                IF NOT loc_llEOrigem AND NOT loc_llEDestino AND NOT loc_llSOrigem AND NOT loc_llSDestino
                                    LOOP
                                ENDIF

                                loc_lcEdn      = crSigCdNec.Emps + crSigCdNec.Dopps + STR(crSigCdNec.Numps, 10)
                                loc_lcMaterial = SPACE(14)

                                SELECT crSigCdNei
                                =SEEK(loc_lcEdn)
                                SCAN WHILE EmpDnps = loc_lcEdn
                                    loc_lcChave1 = crSigCdNec.GrupoOs + crSigCdNec.ContaOs + crSigCdNei.TpOps
                                    loc_lcChave2 = crSigCdNec.GrupoOs + SPACE(10) + crSigCdNei.TpOps

                                    =SEEK(crSigCdNec.GrupoOs, "crSigCdGcr", "Codigos")

                                    IF CrSigCdGcr.UnifBals = 4
                                        IF CrSigCdNei.Nops = 0
                                            loc_lcMaterial = CrSigCdNei.CMats
                                        ELSE
                                            =SEEK(CrSigCdNei.Nops, "TmpOpi", "Nops")
                                            =SEEK(TmpOpi.Cpros, "TmpPro", "Cpros")
                                            loc_lcMaterial = IIF(EMPTY(TmpPro.MatPrincs), crSigCdPam.Ouros, TmpPro.MatPrincs)
                                        ENDIF
                                        IF CrSigCdNei.CMats <> loc_lcMaterial
                                            LOOP
                                        ENDIF
                                    ELSE
                                        IF CrSigCdGcr.UnifBals = 3
                                            =SEEK(CrSigCdNei.Nops, "TmpOpi", "Nops")
                                            IF CrSigCdNei.Nops = 0
                                                loc_lcMaterial = CrSigCdNei.CMats
                                            ELSE
                                                =SEEK(TmpOpi.Cpros, "TmpPro", "Cpros")
                                                loc_lcMaterial = IIF(EMPTY(TmpPro.MatPrincs), crSigCdPam.Ouros, TmpPro.MatPrincs)
                                            ENDIF
                                        ELSE
                                            loc_lcMaterial = IIF(CrSigCdGcr.UnifBals = 1, crSigCdPam.Ouros, CrSigCdNei.CMats)
                                        ENDIF
                                    ENDIF

                                    loc_lOk2 = (loc_lcMaterial = loc_lcCodMat)

                                    IF (loc_llEOrigem OR loc_llSOrigem) AND loc_lOk2
                                        IF loc_llEOrigem
                                            loc_lcTemp  = "TmpEntra"
                                            loc_lcAlias = "Entradas"
                                        ELSE
                                            loc_lcTemp  = "TmpSaida"
                                            loc_lcAlias = "Saidas"
                                        ENDIF

                                        IF SEEK(loc_lcChave1, loc_lcTemp) OR SEEK(loc_lcChave2, loc_lcTemp)
                                            IF NOT SEEK(loc_lcEmp + &loc_lcTemp..TpOps, loc_lcAlias)
                                                INSERT INTO &loc_lcAlias. (TpOps) VALUES (&loc_lcTemp..TpOps)
                                            ENDIF
                                            IF (crSigCdNei.CMats = loc_lcCodMat AND crSigCdGcr.UnifBals = 1)
                                                REPLACE &loc_lcAlias..Qtde WITH &loc_lcAlias..Qtde + crSigCdNei.Qtds
                                            ELSE
                                                REPLACE &loc_lcAlias..Qtde WITH &loc_lcAlias..Qtde + crSigCdNei.Pesos
                                            ENDIF
                                            REPLACE &loc_lcAlias..Emps WITH loc_lcEmp
                                        ENDIF
                                    ENDIF

                                    loc_lcChave1 = crSigCdNec.GrupoDs + crSigCdNec.ContaDs + crSigCdNei.TpOps
                                    loc_lcChave2 = crSigCdNec.GrupoDs + SPACE(10) + crSigCdNei.TpOps

                                    =SEEK(crSigCdNec.GrupoDs, "crSigCdGcr", "Codigos")

                                    IF CrSigCdGcr.UnifBals = 4
                                        IF CrSigCdNei.Nops = 0
                                            loc_lcMaterial = CrSigCdNei.CMats
                                        ELSE
                                            =SEEK(CrSigCdNei.Nops, "TmpOpi", "Nops")
                                            =SEEK(TmpOpi.Cpros, "TmpPro", "Cpros")
                                            loc_lcMaterial = IIF(EMPTY(TmpPro.MatPrincs), crSigCdPam.Ouros, TmpPro.MatPrincs)
                                        ENDIF
                                        IF CrSigCdNei.CMats <> loc_lcMaterial
                                            LOOP
                                        ENDIF
                                    ELSE
                                        IF CrSigCdGcr.UnifBals = 3
                                            =SEEK(CrSigCdNei.Nops, "TmpOpi", "Nops")
                                            IF CrSigCdNei.Nops = 0
                                                loc_lcMaterial = CrSigCdNei.CMats
                                            ELSE
                                                =SEEK(TmpOpi.Cpros, "TmpPro", "Cpros")
                                                loc_lcMaterial = IIF(EMPTY(TmpPro.MatPrincs), crSigCdPam.Ouros, TmpPro.MatPrincs)
                                            ENDIF
                                        ELSE
                                            loc_lcMaterial = IIF(CrSigCdGcr.UnifBals = 1, crSigCdPam.Ouros, CrSigCdNei.CMats)
                                        ENDIF
                                    ENDIF

                                    loc_lOk2 = (loc_lcMaterial = loc_lcCodMat)

                                    IF (loc_llEDestino OR loc_llSDestino) AND loc_lOk2
                                        IF loc_llEDestino
                                            loc_lcTemp  = "TmpEntra"
                                            loc_lcAlias = "Entradas"
                                        ELSE
                                            loc_lcTemp  = "TmpSaida"
                                            loc_lcAlias = "Saidas"
                                        ENDIF

                                        IF SEEK(loc_lcChave1, loc_lcTemp) OR SEEK(loc_lcChave2, loc_lcTemp)
                                            IF NOT SEEK(loc_lcEmp + &loc_lcTemp..TpOps, loc_lcAlias)
                                                INSERT INTO &loc_lcAlias. (TpOps) VALUES (&loc_lcTemp..TpOps)
                                            ENDIF
                                            IF (crSigCdNei.CMats = loc_lcCodMat AND crSigCdGcr.UnifBals = 1)
                                                REPLACE &loc_lcAlias..Qtde WITH &loc_lcAlias..Qtde + crSigCdNei.Qtds
                                            ELSE
                                                REPLACE &loc_lcAlias..Qtde WITH &loc_lcAlias..Qtde + crSigCdNei.Pesos
                                            ENDIF
                                            REPLACE &loc_lcAlias..Emps WITH loc_lcEmp
                                        ENDIF
                                    ENDIF
                                ENDSCAN
                            ENDSCAN
                            loc_loBarra.Complete
                        ENDIF

                        * Movimentos de estoque (SigMvCab/SigMvItn) -> Entradas/Saidas
                        IF loc_lOk
                            IF USED("crEstoque")
                                USE IN crEstoque
                            ENDIF
                            loc_lcQuery = "SELECT a.Datas, a.Emps, a.EmpDs, a.Dopes, a.Numes, " + ;
                                          "a.GrupoOs, a.ContaOs, a.GrupoDs, a.ContaDs, a.cIdChaves, " + ;
                                          "b.EmpDopNums, b.CPros, b.Opers, b.Qtds, b.cIdChaves as ChaveB " + ;
                                          "FROM SigMvCab a, SigMvItn b " + ;
                                          "WHERE a.Datas BETWEEN ?pDtI AND ?pDtF AND " + ;
                                          "( a.Emps = " + EscaparSQL(loc_lcEmp) + " OR a.EmpDs = " + EscaparSQL(loc_lcEmp) + " ) AND " + ;
                                          "NOT a.Dopes = " + EscaparSQL(THIS.this_cDopeBals) + " AND " + ;
                                          "a.EmpDopNums = b.EmpDopNums " + ;
                                          "ORDER BY a.Datas, a.Emps, a.EmpDs, a.Dopes, a.Numes, " + ;
                                          "a.GrupoOs, a.ContaOs, a.GrupoDs, a.ContaDs, a.cIdChaves, " + ;
                                          "b.EmpDopNums, b.CPros, b.Opers, b.Qtds, b.cIdChaves"
                            IF SQLEXEC(gnConnHandle, loc_lcQuery, "crEstoque") < 1
                                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (crEstoque)")
                                loc_lOk = .F.
                            ENDIF
                        ENDIF

                        IF loc_lOk
                            IF USED("crSigMvItn")
                                USE IN crSigMvItn
                            ENDIF
                            SELECT DISTINCT EmpDopNums, CPros, Opers, Qtds, ChaveB ;
                                   FROM crEstoque ;
                                   ORDER BY EmpDopNums, CPros, Opers, Qtds, ChaveB ;
                                   INTO CURSOR crSigMvItn READWRITE
                            SELECT crSigMvItn
                            INDEX ON EmpDopNums TAG EmpDopNums
                            SET ORDER TO EmpDopNums

                            IF USED("crSigMvCab")
                                USE IN crSigMvCab
                            ENDIF
                            SELECT DISTINCT Datas, Emps, EmpDs, Dopes, Numes, GrupoOs, ContaOs, GrupoDs, ContaDs, cIdChaves ;
                                   FROM crEstoque ;
                                   ORDER BY Datas, Emps, EmpDs, Dopes, Numes, GrupoOs, ContaOs, GrupoDs, ContaDs, cIdChaves ;
                                   INTO CURSOR crSigMvCab
                        ENDIF

                        * Processa movimentos de estoque -> Entradas/Saidas
                        IF loc_lOk
                            LOCAL loc_lOriDes, loc_lcEdnS, loc_lGrupoo, loc_lContao
                            LOCAL loc_lGrupod, loc_lContad, loc_llSOrigem2, loc_llEDestino2
                            LOCAL loc_lcChave1S, loc_lcChave2S, loc_lcTpOp
                            LOCAL loc_lcAliasS, loc_lcTempS, loc_lcEmpS

                            SELECT crSigMvCab
                            loc_loBarra = CREATEOBJECT("fwprogressbar", "Processando Mov. de Estoque...", RECCOUNT())
                            loc_loBarra.Show
                            SCAN
                                loc_loBarra.Update(.T.)

                                =SEEK(crSigMvCab.Dopes, "crSigCdOpe", "Dopes")
                                loc_lOriDes = .F.

                                IF crSigMvCab.EmpDs = loc_lcEmp
                                    IF SEEK(crSigMvCab.GrupoDs + crSigMvCab.ContaDs, "TmpEntra")
                                        loc_lOriDes = .T.
                                    ENDIF
                                ELSE
                                    IF (SEEK(crSigMvCab.GrupoOs + crSigMvCab.ContaOs, "TmpEntra") OR ;
                                        SEEK(crSigMvCab.GrupoOs + crSigMvCab.ContaOs, "TmpSaida") OR ;
                                        SEEK(crSigMvCab.GrupoDs + crSigMvCab.ContaDs, "TmpEntra") OR ;
                                        SEEK(crSigMvCab.GrupoDs + crSigMvCab.ContaDs, "TmpSaida")) OR ;
                                       (SEEK(crSigMvCab.GrupoOs + SPACE(10), "TmpEntra") OR ;
                                        SEEK(crSigMvCab.GrupoOs + SPACE(10), "TmpSaida") OR ;
                                        SEEK(crSigMvCab.GrupoDs + SPACE(10), "TmpEntra") OR ;
                                        SEEK(crSigMvCab.GrupoDs + SPACE(10), "TmpSaida"))
                                        loc_lOriDes = .T.
                                    ENDIF
                                ENDIF

                                IF NOT loc_lOriDes
                                    LOOP
                                ENDIF

                                loc_lcEdnS = crSigMvCab.Emps + crSigMvCab.Dopes + STR(crSigMvCab.Numes, 6)

                                SELECT crSigMvItn
                                SEEK loc_lcEdnS
                                SCAN WHILE EmpDopNums = loc_lcEdnS
                                    loc_lGrupoo = SPACE(10)
                                    loc_lContao = SPACE(10)
                                    loc_lGrupod = SPACE(10)
                                    loc_lContad = SPACE(10)
                                    loc_llSOrigem2  = .F.
                                    loc_llEDestino2 = .F.

                                    IF (crSigCdOpe.EstOrigs = 4)
                                        IF (crSigMvItn.Opers = "S") AND (SEEK(crSigMvCab.GrupoOs + crSigMvCab.ContaOs, "TmpSaida") OR SEEK(crSigMvCab.GrupoOs + SPACE(10), "TmpSaida"))
                                            loc_llSOrigem2 = .T.
                                            loc_lGrupoo    = crSigMvCab.GrupoOs
                                            loc_lContao    = crSigMvCab.ContaOs
                                        ELSE
                                            IF (crSigMvItn.Opers = "E") AND (SEEK(crSigMvCab.GrupoDs + crSigMvCab.ContaDs, "TmpEntra") OR SEEK(crSigMvCab.GrupoDs + SPACE(10), "TmpEntra"))
                                                loc_llEDestino2 = .T.
                                                loc_lGrupod     = crSigMvCab.GrupoDs
                                                loc_lContad     = crSigMvCab.ContaDs
                                            ENDIF
                                        ENDIF
                                    ELSE
                                        IF (crSigCdOpe.Opers = 3)
                                            IF (crSigCdOpe.Origems = 1)
                                                IF (crSigMvItn.Opers = "S") AND (SEEK(crSigMvCab.GrupoOs + crSigMvCab.ContaOs, "TmpSaida") OR SEEK(crSigMvCab.GrupoOs + SPACE(10), "TmpSaida"))
                                                    loc_llSOrigem2 = .T.
                                                    loc_lGrupoo    = crSigMvCab.GrupoOs
                                                    loc_lContao    = crSigMvCab.ContaOs
                                                ELSE
                                                    IF (crSigMvItn.Opers = "E") AND (SEEK(crSigMvCab.GrupoOs + crSigMvCab.ContaOs, "TmpEntra") OR SEEK(crSigMvCab.GrupoOs + SPACE(10), "TmpEntra"))
                                                        loc_llEDestino2 = .T.
                                                        loc_lGrupod     = crSigMvCab.GrupoOs
                                                        loc_lContad     = crSigMvCab.ContaOs
                                                    ENDIF
                                                ENDIF
                                            ELSE
                                                IF (crSigCdOpe.Destinos = 1)
                                                    IF (crSigMvItn.Opers = "S") AND (SEEK(crSigMvCab.GrupoDs + crSigMvCab.ContaDs, "TmpSaida") OR SEEK(crSigMvCab.GrupoDs + SPACE(10), "TmpSaida"))
                                                        loc_llSOrigem2 = .T.
                                                        loc_lGrupoo    = crSigMvCab.GrupoDs
                                                        loc_lContao    = crSigMvCab.ContaDs
                                                    ELSE
                                                        IF (crSigMvItn.Opers = "E") AND (SEEK(crSigMvCab.GrupoOs + crSigMvCab.ContaOs, "TmpEntra") OR SEEK(crSigMvCab.GrupoOs + SPACE(10), "TmpEntra"))
                                                            loc_llEDestino2 = .T.
                                                            loc_lGrupod     = crSigMvCab.GrupoDs
                                                            loc_lContad     = crSigMvCab.ContaDs
                                                        ENDIF
                                                    ENDIF
                                                ENDIF
                                            ENDIF
                                        ELSE
                                            IF (crSigCdOpe.Origems = 1)
                                                IF (SEEK(crSigMvCab.GrupoOs + crSigMvCab.ContaOs, "TmpSaida") OR SEEK(crSigMvCab.GrupoOs + SPACE(10), "TmpSaida")) AND (crSigCdOpe.EstOrigs = 2)
                                                    loc_llSOrigem2 = .T.
                                                    loc_lGrupoo    = crSigMvCab.GrupoOs
                                                    loc_lContao    = crSigMvCab.ContaOs
                                                ELSE
                                                    IF (SEEK(crSigMvCab.GrupoOs + crSigMvCab.ContaOs, "TmpEntra") OR SEEK(crSigMvCab.GrupoOs + SPACE(10), "TmpEntra")) AND (crSigCdOpe.EstOrigs = 1)
                                                        loc_llEDestino2 = .T.
                                                        loc_lGrupod     = crSigMvCab.GrupoOs
                                                        loc_lContad     = crSigMvCab.ContaOs
                                                    ENDIF
                                                ENDIF
                                            ENDIF

                                            IF (crSigCdOpe.Destinos = 1)
                                                IF (SEEK(crSigMvCab.GrupoDs + crSigMvCab.ContaDs, "TmpSaida") OR SEEK(crSigMvCab.GrupoDs + SPACE(10), "TmpSaida")) AND (crSigCdOpe.EstDests = 2)
                                                    loc_llSOrigem2 = .T.
                                                    loc_lGrupoo    = crSigMvCab.GrupoDs
                                                    loc_lContao    = crSigMvCab.ContaDs
                                                ELSE
                                                    IF (SEEK(crSigMvCab.GrupoDs + crSigMvCab.ContaDs, "TmpEntra") OR SEEK(crSigMvCab.GrupoDs + SPACE(10), "TmpEntra")) AND (crSigCdOpe.EstDests = 1)
                                                        loc_llEDestino2 = .T.
                                                        loc_lGrupod     = crSigMvCab.GrupoDs
                                                        loc_lContad     = crSigMvCab.ContaDs
                                                    ENDIF
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                    ENDIF

                                    loc_lcChave1S = loc_lGrupoo + loc_lContao + SPACE(15)
                                    loc_lcChave2S = loc_lGrupoo + SPACE(10)  + SPACE(15)
                                    loc_lcTpOp    = PADR(LEFT(crSigMvCab.Dopes, 10), 15)

                                    =SEEK(loc_lGrupoo, "crSigCdGcr", "Codigos")
                                    =SEEK(crSigMvItn.Cpros, "TmpPro", "Cpros")

                                    IF INLIST(CrSigCdGcr.UnifBals, 3, 4)
                                        loc_lcMaterial = IIF(EMPTY(TmpPro.MatPrincs), crSigCdPam.Ouros, TmpPro.MatPrincs)
                                    ELSE
                                        =SEEK(TmpPro.Cgrus, "LocalGru", "Cgrus")
                                        loc_lcMaterial = IIF(crSigCdGcr.UnifBals = 1 AND LocalGru.nAgMts <> 1, crSigCdPam.Ouros, crSigMvItn.Cpros)
                                    ENDIF

                                    IF crSigCdGcr.UnifBals = 4 AND crSigMvItn.Cpros <> loc_lcMaterial
                                        loc_lcMaterial = crSigMvItn.Cpros
                                    ENDIF

                                    loc_lOk2 = (loc_lcMaterial = loc_lcCodMat)

                                    IF loc_llSOrigem2 AND loc_lOk2
                                        loc_lcTempS  = "TmpSaida"
                                        loc_lcAliasS = "Saidas"
                                        loc_lcEmpS   = IIF(EMPTY(crSigMvCab.EmpDs), crSigMvCab.Emps, crSigMvCab.EmpDs)

                                        IF SEEK(loc_lcChave1S, loc_lcTempS) OR SEEK(loc_lcChave2S, loc_lcTempS)
                                            IF NOT SEEK(loc_lcEmpS + loc_lcTpOp, loc_lcAliasS)
                                                SELECT (loc_lcAliasS)
                                                APPEND BLANK
                                                REPLACE TpOps WITH loc_lcTpOp, ;
                                                        Emps  WITH loc_lcEmpS
                                            ENDIF
                                            REPLACE &loc_lcAliasS..Qtde WITH &loc_lcAliasS..Qtde + crSigMvItn.Qtds
                                        ENDIF
                                    ENDIF

                                    loc_lcChave1S = loc_lGrupod + loc_lContad + SPACE(15)
                                    loc_lcChave2S = loc_lGrupod + SPACE(10)  + SPACE(15)

                                    =SEEK(loc_lGrupod, "crSigCdGcr", "Codigos")
                                    =SEEK(crSigMvItn.Cpros, "TmpPro", "Cpros")

                                    IF INLIST(CrSigCdGcr.UnifBals, 3, 4)
                                        loc_lcMaterial = IIF(EMPTY(TmpPro.MatPrincs), crSigCdPam.Ouros, TmpPro.MatPrincs)
                                    ELSE
                                        =SEEK(TmpPro.Cgrus, "LocalGru", "Cgrus")
                                        loc_lcMaterial = IIF(crSigCdGcr.UnifBals = 1 AND LocalGru.nAgMts <> 1, crSigCdPam.Ouros, crSigMvItn.Cpros)
                                    ENDIF

                                    IF crSigCdGcr.UnifBals = 4 AND crSigMvItn.Cpros <> loc_lcMaterial
                                        loc_lcMaterial = crSigMvItn.Cpros
                                    ENDIF

                                    loc_lOk2 = (loc_lcMaterial = loc_lcCodMat)

                                    IF loc_llEDestino2 AND loc_lOk2
                                        LOCAL loc_lcAliasE, loc_lcTempE, loc_lcEmpE
                                        loc_lcTempE  = "TmpEntra"
                                        loc_lcAliasE = "Entradas"
                                        loc_lcEmpE   = crSigMvCab.Emps

                                        IF SEEK(loc_lcChave1S, loc_lcTempE) OR SEEK(loc_lcChave2S, loc_lcTempE)
                                            IF NOT SEEK(loc_lcEmpE + loc_lcTpOp, loc_lcAliasE)
                                                SELECT (loc_lcAliasE)
                                                APPEND BLANK
                                                REPLACE TpOps WITH loc_lcTpOp, ;
                                                        Emps  WITH loc_lcEmpE
                                            ENDIF
                                            REPLACE &loc_lcAliasE..Qtde WITH &loc_lcAliasE..Qtde + crSigMvItn.Qtds
                                        ENDIF
                                    ENDIF
                                ENDSCAN
                            ENDSCAN
                            loc_loBarra.Complete
                        ENDIF

                        * Pesagens fisicas -> lnPesagem
                        loc_lnPesagem = 0
                        IF loc_lOk
                            SELECT TmpPesag
                            loc_loBarra = CREATEOBJECT("fwprogressbar", "Processando Pesagens", RECCOUNT())
                            loc_loBarra.Show
                            SCAN
                                IF NOT loc_lOk
                                    EXIT
                                ENDIF
                                loc_loBarra.UpDate(.T.)

                                pDatI = THIS.this_dDatai
                                pDat  = CTOT(DTOC(THIS.this_dDataf) + " 23:59:59")

                                IF USED("crSigCdPsc")
                                    USE IN crSigCdPsc
                                ENDIF
                                loc_lcQuery = "SELECT Datas, Codigos FROM SigCdPsc " + ;
                                              "WHERE Emps = " + EscaparSQL(loc_lcEmp) + " AND " + ;
                                              "Grupos = " + EscaparSQL(ALLTRIM(TmpPesag.Grupos)) + " AND " + ;
                                              "Contas = " + EscaparSQL(ALLTRIM(TmpPesag.Contas)) + " AND " + ;
                                              "Datas >= ?pDatI AND Datas <= ?pDat " + ;
                                              "ORDER BY Datas DESC, Codigos DESC"
                                IF SQLEXEC(gnConnHandle, loc_lcQuery, "crSigCdPsc") < 1
                                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (crSigCdPsc)")
                                    loc_lOk = .F.
                                ELSE
                                    SELECT crSigCdPsc
                                    GO TOP

                                    IF USED("crSigCdPsi")
                                        USE IN crSigCdPsi
                                    ENDIF
                                    loc_lcQuery = "SELECT CPros, Qtds FROM SigCdPsi " + ;
                                                  "WHERE Emps = " + EscaparSQL(loc_lcEmp) + " AND " + ;
                                                  "Codigos = " + STR(crSigCdPsc.Codigos, 6) + " AND " + ;
                                                  "CPros = " + EscaparSQL(loc_lcCodMat) + " " + ;
                                                  "ORDER BY CPros, Qtds"
                                    IF SQLEXEC(gnConnHandle, loc_lcQuery, "crSigCdPsi") >= 1
                                        SELECT crSigCdPsi
                                        SCAN
                                            loc_lnPesagem = loc_lnPesagem + crSigCdPsi.Qtds
                                        ENDSCAN
                                    ENDIF
                                ENDIF
                            ENDSCAN
                            loc_loBarra.Complete
                        ENDIF

                        * Saldo c/funcionario via PosBalanco -> Saldos/SaldoAnt
                        loc_lnSaldoFunc = 0
                        loc_lnSaldoaFun = 0
                        IF loc_lOk
                            SELECT TmpSaldo
                            loc_loBarra = CREATEOBJECT("fwprogressbar", "Processando Saldo c/funcion" + CHR(225) + "rio", RECCOUNT())
                            loc_loBarra.Show
                            SCAN
                                IF NOT loc_lOk
                                    EXIT
                                ENDIF
                                loc_loBarra.UpDate(.T.)

                                IF USED("crSigMvEst")
                                    USE IN crSigMvEst
                                ENDIF
                                loc_lcQuery = "SELECT Emps, Grupos, Estos, CPros FROM SigMvEst WHERE " + ;
                                              IIF(EMPTY(ALLTRIM(TmpSaldo.Contas)), ;
                                                  "Emps = " + EscaparSQL(loc_lcEmp) + " AND " + ;
                                                  "Grupos = " + EscaparSQL(ALLTRIM(TmpSaldo.Grupos)) + " ", ;
                                                  "EmpGruEsts = " + EscaparSQL(loc_lcEmp + ALLTRIM(TmpSaldo.Grupos) + ALLTRIM(TmpSaldo.Contas)) + " ") + ;
                                              "AND CPros = " + EscaparSQL(loc_lcCodMat)
                                IF SQLEXEC(gnConnHandle, loc_lcQuery, "crSigMvEst") < 1
                                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (crSigMvEst)")
                                    loc_lOk = .F.
                                ELSE
                                    SELECT crSigMvEst
                                    SCAN
                                        =SEEK(crSigMvEst.Grupos, "crSigCdGcr", "Codigos")
                                        IF (crSigMvEst.Cpros = loc_lcCodMat OR crSigCdGcr.UnifBals = 1)
                                            THIS.PosBalanco()
                                        ENDIF
                                    ENDSCAN
                                ENDIF
                            ENDSCAN
                            loc_loBarra.Complete
                        ENDIF

                        IF loc_lOk
                            IF USED("CsSelecao")
                                USE IN CsSelecao
                            ENDIF
                            SELECT [ ] AS Agrupar, SUM(qtde) AS Qtde FROM Saldos INTO CURSOR CsSelecao GROUP BY 1
                            loc_lnSaldoFunc = CsSelecao.Qtde

                            IF USED("CsSelecao")
                                USE IN CsSelecao
                            ENDIF
                            SELECT [ ] AS Agrupar, SUM(qtde) AS Qtde FROM SaldoAnt INTO CURSOR CsSelecao GROUP BY 1
                            loc_lnSaldoaFun = CsSelecao.Qtde
                        ENDIF

                        * Falhas dos funcionarios -> lnFalhaFunc + Falhas cursor
                        loc_lnFalhaFunc = 0
                        IF loc_lOk
                            SELECT TmpSaldo
                            loc_loBarra = CREATEOBJECT("fwprogressbar", "Processando Falha dos Funcion" + CHR(225) + "rios", RECCOUNT())
                            loc_loBarra.Show
                            SCAN
                                IF NOT loc_lOk
                                    EXIT
                                ENDIF
                                loc_loBarra.UpDate(.T.)

                                IF USED("crSigCdFcx")
                                    USE IN crSigCdFcx
                                ENDIF
                                loc_lcQuery = "SELECT b.cIdChaves, b.FReals, b.Entradas, b.Saldos, b.Saidas, b.Pesagems " + ;
                                              "FROM SigCdFcx a, SigOpCfe b " + ;
                                              "WHERE a.Datas BETWEEN ?pDtI AND ?pDtF AND " + ;
                                              "a.Emps = " + EscaparSQL(loc_lcEmp) + " AND " + ;
                                              "a.Grupos = " + EscaparSQL(ALLTRIM(TmpSaldo.Grupos)) + " " + ;
                                              IIF(ALLTRIM(TmpSaldo.Contas) = " " OR EMPTY(ALLTRIM(TmpSaldo.Contas)), "", ;
                                                  "AND a.Contas = " + EscaparSQL(ALLTRIM(TmpSaldo.Contas)) + " ") + ;
                                              "AND a.Emps = b.Emps AND " + ;
                                              "a.Codigos = b.Codigos AND " + ;
                                              "b.CPros = " + EscaparSQL(loc_lcCodMat) + " " + ;
                                              "ORDER BY b.cIdChaves, b.FReals, b.Entradas, b.Saldos, b.Saidas, b.Pesagems"
                                IF SQLEXEC(gnConnHandle, loc_lcQuery, "crSigCdFcx") < 1
                                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (crSigCdFcx)")
                                    loc_lOk = .F.
                                ELSE
                                    SELECT crSigCdFcx
                                    SCAN
                                        loc_lnFalhaFunc = loc_lnFalhaFunc + crSigCdFcx.FReals
                                        IF NOT SEEK(ALLTRIM(TmpSaldo.Grupos), "Falhas")
                                            INSERT INTO Falhas (Grupos, Contas, Emps) ;
                                                   VALUES (TmpSaldo.Grupos, TmpSaldo.Contas, loc_lcEmp)
                                        ENDIF
                                        REPLACE Qtde  WITH Falhas.Qtde  + crSigCdFcx.FReals, ;
                                                Entra WITH Falhas.Entra + crSigCdFcx.Entradas + crSigCdFcx.Saldos, ;
                                                Saida WITH Falhas.Saida + crSigCdFcx.Saidas   + crSigCdFcx.Pesagems IN Falhas
                                    ENDSCAN
                                ENDIF
                            ENDSCAN
                            loc_loBarra.Complete
                        ENDIF

                        * Calcula totalizadores
                        loc_lnTotalEntra = 0
                        loc_lnTotalSaida = 0
                        IF loc_lOk
                            SELECT Entradas
                            SUM Qtde TO loc_lnTotalEntra

                            SELECT Saidas
                            SUM Qtde TO loc_lnTotalSaida

                            * Armazena em propriedades do BO
                            THIS.this_nSaldoIni   = loc_lnSaldoIni
                            THIS.this_nSaldoaFun  = loc_lnSaldoaFun
                            THIS.this_nTotalEntra = loc_lnTotalEntra
                            THIS.this_nTotalSaida = loc_lnTotalSaida
                            THIS.this_nPesagem    = loc_lnPesagem
                            THIS.this_nSaldoFunc  = loc_lnSaldoFunc
                            THIS.this_nFalhaFunc  = loc_lnFalhaFunc
                            THIS.this_cEmpresa    = loc_lcEmp
                        ENDIF

                        * Cria cursores para impressao
                        IF loc_lOk
                            IF USED("TmpImprime2")
                                USE IN TmpImprime2
                            ENDIF
                            IF USED("TmpImprime")
                                USE IN TmpImprime
                            ENDIF

                            CREATE CURSOR TmpImprime2 (Linha2 N(3), Cabec2 L, Titulo2 C(40), Valor2 N(12,3), Traco2 L, Emps C(3))
                            CREATE CURSOR TmpImprime  (Linha N(3), Cabec L, Titulo C(80), Valor N(12,3), ;
                                                       Valor1 N(11,3), Traco L, Entrada N(12,3), Saida N(12,3), Falha L)

                            LOCAL loc_lnLinha, loc_lnLinha2, loc_lnX
                            loc_lnLinha = 1
                            INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) VALUES (loc_lnLinha, .F., "Saldo Inicial : ", loc_lnSaldoIni)
                            loc_lnLinha = loc_lnLinha + 1
                            INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) VALUES (loc_lnLinha, .F., "Saldo Ant c/Funcion" + CHR(225) + "rio : ", loc_lnSaldoaFun)
                            loc_lnLinha = loc_lnLinha + 1
                            INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) VALUES (loc_lnLinha, .F., "Entradas : ", loc_lnTotalEntra)
                            loc_lnLinha = loc_lnLinha + 1
                            INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) VALUES (loc_lnLinha, .F., "Total de Entradas : ", loc_lnSaldoIni + loc_lnTotalEntra + loc_lnSaldoaFun)
                            loc_lnLinha = loc_lnLinha + 1
                            INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) VALUES (loc_lnLinha, .F., "Sa" + CHR(237) + "das : ", loc_lnTotalSaida)
                            loc_lnLinha = loc_lnLinha + 1
                            INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) VALUES (loc_lnLinha, .F., "Saldo : ", loc_lnSaldoIni + loc_lnTotalEntra - loc_lnTotalSaida + loc_lnSaldoaFun)
                            loc_lnLinha = loc_lnLinha + 1
                            INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) VALUES (loc_lnLinha, .F., "Saldo com Funcion" + CHR(225) + "rios : ", loc_lnSaldoFunc)
                            loc_lnLinha = loc_lnLinha + 1
                            INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) VALUES (loc_lnLinha, .F., "Pesagem : ", loc_lnPesagem)
                            loc_lnLinha = loc_lnLinha + 1
                            INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) VALUES (loc_lnLinha, .F., "Total : ", loc_lnPesagem + loc_lnSaldoFunc)
                            loc_lnLinha = loc_lnLinha + 1
                            INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor, Traco) VALUES (loc_lnLinha, .F., "Falha dos Funcion" + CHR(225) + "rios : ", loc_lnFalhaFunc, .T.)
                            loc_lnLinha = loc_lnLinha + 1
                            INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor, Traco) VALUES (loc_lnLinha, .F., "Diferenca : ", ;
                                loc_lnSaldoIni + loc_lnTotalEntra - loc_lnTotalSaida + loc_lnSaldoaFun - loc_lnPesagem - loc_lnSaldoFunc - loc_lnFalhaFunc, .T.)

                            loc_lnLinha2 = 0
                            SELECT Entradas
                            GO TOP
                            IF NOT EOF()
                                loc_lnLinha2 = loc_lnLinha2 + 1
                                INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2) VALUES (loc_lnLinha2, .T., "Resumo de Entradas")
                                SELECT Entradas
                                SCAN
                                    loc_lnLinha2 = loc_lnLinha2 + 1
                                    INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2, Emps) ;
                                                 VALUES (loc_lnLinha2, .F., Entradas.TpOps, Entradas.Qtde, Entradas.Emps)
                                ENDSCAN
                                SELECT TmpImprime2
                                REPLACE Traco2 WITH .T. IN TmpImprime2
                            ENDIF

                            loc_lnLinha2 = loc_lnLinha2 + 1
                            INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2) VALUES (loc_lnLinha2, .F., " ", loc_lnTotalEntra)

                            SELECT Saidas
                            GO TOP
                            IF NOT EOF()
                                loc_lnLinha2 = loc_lnLinha2 + 1
                                INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2) VALUES (loc_lnLinha2, .T., "Resumo de Saidas")
                                SELECT Saidas
                                SCAN
                                    loc_lnLinha2 = loc_lnLinha2 + 1
                                    INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2, Emps) ;
                                                 VALUES (loc_lnLinha2, .F., IIF(EMPTY(Saidas.TpOps), "PRODUZIDO", Saidas.TpOps), Saidas.Qtde, Saidas.Emps)
                                ENDSCAN
                                SELECT TmpImprime2
                                REPLACE Traco2 WITH .T. IN TmpImprime2
                            ENDIF

                            loc_lnLinha2 = loc_lnLinha2 + 1
                            INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2) VALUES (loc_lnLinha2, .F., " ", loc_lnTotalSaida)

                            SELECT Saldos
                            GO TOP
                            IF NOT EOF()
                                loc_lnLinha2 = loc_lnLinha2 + 1
                                INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2) VALUES (loc_lnLinha2, .T., " ")
                                loc_lnLinha2 = loc_lnLinha2 + 1
                                INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2) VALUES (loc_lnLinha2, .T., "Saldos das Fases")
                                SELECT Saldos
                                SCAN
                                    loc_lnLinha2 = loc_lnLinha2 + 1
                                    INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2) VALUES (loc_lnLinha2, .F., Saldos.Grupos, Saldos.Qtde)
                                ENDSCAN
                                SELECT TmpImprime2
                                REPLACE Traco2 WITH .T. IN TmpImprime2
                            ENDIF

                            loc_lnLinha2 = loc_lnLinha2 + 1
                            INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2) VALUES (loc_lnLinha2, .F., " ", loc_lnSaldoFunc)

                            SELECT Falhas
                            GO TOP
                            IF NOT EOF()
                                loc_lnLinha = loc_lnLinha + 1
                                INSERT INTO TmpImprime (Linha, Cabec, Titulo) VALUES (loc_lnLinha, .T., PADC("Falhas das Fases", 70))
                                loc_lnLinha = loc_lnLinha + 1
                                INSERT INTO TmpImprime (Linha, Cabec, Titulo) VALUES (loc_lnLinha, .T., "Setor           Entrada      Saida      Falha Gr         %")

                                SELECT Falhas
                                SCAN
                                    loc_lnLinha = loc_lnLinha + 1
                                    loc_lnX = (Falhas.Qtde / IIF(Falhas.Saida = 0, 1, Falhas.Saida) * 100)
                                    INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor, Valor1, Entrada, Saida, Falha) ;
                                                 VALUES (loc_lnLinha, .F., Falhas.Grupos, Falhas.Qtde, loc_lnX, Falhas.Entra, Falhas.Saida, .T.)
                                ENDSCAN

                                LOCAL loc_lnQEnt, loc_lnQSai, loc_lnQFalha
                                SELECT Falhas
                                SUM Entra, Saida, Qtde TO loc_lnQEnt, loc_lnQSai, loc_lnQFalha
                                loc_lnX = (loc_lnQFalha / IIF(loc_lnQSai = 0, 1, loc_lnQSai) * 100)

                                SELECT TmpImprime
                                REPLACE Traco WITH .T. IN TmpImprime
                                loc_lnLinha = loc_lnLinha + 1
                                INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor, Valor1, Entrada, Saida, Falha) ;
                                             VALUES (loc_lnLinha, .F., " ", loc_lnQFalha, loc_lnX, loc_lnQEnt, loc_lnQSai, .T.)
                            ENDIF

                            * Mescla TmpImprime + TmpImprime2 em TmpImp para impressao
                            IF USED("TmpImp")
                                USE IN TmpImp
                            ENDIF
                            LOCAL loc_lcOrder
                            loc_lcOrder = "t1.Linha"
                            IF (loc_lnLinha2 > loc_lnLinha)
                                loc_lcOrder = "t2.Linha2"
                            ENDIF

                            SELECT T1.*, T2.* ;
                                   FROM TmpImprime T1 ;
                                   FULL JOIN TmpImprime2 T2 ;
                                   ON T1.Linha = T2.Linha2 ;
                                   INTO CURSOR TmpImp ;
                                   ORDER BY &loc_lcOrder.

                            * Cabecalho para o relatorio
                            IF USED("Cabecalho")
                                USE IN Cabecalho
                            ENDIF
                            CREATE CURSOR Cabecalho (pNomeEmpresa C(60), pRelTitulo C(60), pPeriodo C(60))
                            INSERT INTO Cabecalho (pNomeEmpresa, pRelTitulo, pPeriodo) ;
                                         VALUES (go_4c_Sistema.cEmpresa, ;
                                                 "An" + CHR(225) + "lise de Produ" + CHR(231) + CHR(227) + "o", ;
                                                 "Per" + CHR(237) + "odo : " + DTOC(THIS.this_dDatai) + " at" + CHR(233) + " " + DTOC(THIS.this_dDataf))

                            loc_lResultado = .T.
                        ENDIF  && loc_lOk (impressao)
                    ENDIF  && not empty config
                ENDIF  && dates OK
            ENDIF  && not empty dataf

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em ProcessarAnalise")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * PosBalanco - Calcula saldo de funcionario para conta/grupo atual
    * Chamado de ProcessarAnalise dentro de SCAN de crSigMvEst
    * Equivalente ao PROCEDURE posbalanco do legado
    *==========================================================================
    PROCEDURE PosBalanco()
        PRIVATE pDat, pNot
        LOCAL loc_Origem, loc_Destino, loc_Grupo, loc_Conta, loc_DatauBal
        LOCAL loc_Saldoi, loc_Saidas, loc_FalhaAdmitida
        LOCAL loc_ldDatai, loc_ldDataf, loc_lcEmp, loc_lcCodMat
        LOCAL loc_lnTrabalhado, loc_ldPrimBal, loc_lnCt, loc_lResultado
        LOCAL loc_lcSql, loc_lcQuery, loc_lcEdn, loc_oErro

        loc_lResultado = .F.

        TRY
            loc_ldDatai     = THIS.this_dDatai
            loc_ldDataf     = THIS.this_dDataf
            loc_lcEmp       = go_4c_Sistema.cCodEmpresa
            loc_lnTrabalhado = 0
            loc_ldPrimBal   = DATE()

            SELECT crSigCdPam
            GO TOP
            loc_lcCodMat = ALLTRIM(crSigCdPam.Ouros)

            * Verifica se cliente gera balancos
            loc_lcSql = "SELECT Rclis, GerBals, PagFals, RecFals FROM SigCdCli " + ;
                        "WHERE Iclis = " + EscaparSQL(ALLTRIM(crSigMvEst.Estos))
            IF USED("CrSigCdCli")
                USE IN CrSigCdCli
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_lcSql, "CrSigCdCli") < 1
                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (crsjcli)")
            ELSE
                =SEEK(crSigMvEst.Grupos, "crSigCdGcr", "Codigos")

                IF NOT (CrSigCdCli.GerBals <> 1 OR CrSigCdGcr.GerBals <> 1)

                    loc_lcSql = "SELECT Datas, codigos FROM SigCdFcx " + ;
                                "WHERE Emps = " + EscaparSQL(loc_lcEmp) + " AND " + ;
                                "Grupos = " + EscaparSQL(ALLTRIM(crSigMvEst.Grupos)) + " AND " + ;
                                "Contas = " + EscaparSQL(ALLTRIM(crSigMvEst.Estos))
                    IF USED("LocalFecha")
                        USE IN LocalFecha
                    ENDIF
                    IF SQLEXEC(gnConnHandle, loc_lcSql, "LocalFecha") < 1
                        MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (LocalFecha)")
                    ELSE
                        LOCAL loc_ldDataB, loc_ldDataL, loc_llFalse, loc_llTrue
                        LOCAL loc_lGrupo, loc_lConta, loc_lcCodCor, loc_lcCodTam
                        LOCAL loc_lcMat, loc_lcMaterial, loc_lcMatResFa

                        loc_llFalse = .F.
                        loc_llTrue  = .T.
                        loc_lGrupo  = crSigMvEst.Grupos
                        loc_lConta  = crSigMvEst.Estos
                        loc_lResultado = .T.

                        FOR loc_lnCt = 1 TO 2
                            SELECT TmpResumo
                            SET ORDER TO
                            ZAP
                            SET ORDER TO GrConMat

                            loc_ldDataB = IIF(loc_lnCt = 1, loc_ldDatai - 1, loc_ldDataf)
                            loc_ldDataL = IIF(loc_lnCt = 1, loc_ldDatai - 1, loc_ldDataf)

                            SELECT LocalFecha
                            INDEX ON DTOS(Datas) TAG Datas
                            SET ORDER TO Datas DESCENDING
                            SET NEAR ON
                            =SEEK(DTOS(loc_ldDataB))
                            SET NEAR OFF
                            IF Datas > loc_ldDataB
                                pDat = CTOD("01/01/1900")
                                LOCATE FOR .F.
                            ELSE
                                pDat = TTOD(LocalFecha.Datas) + CrSigCdPac.ndFechas
                            ENDIF
                            pNot        = .F.
                            loc_lGrupo  = crSigMvEst.Grupos
                            loc_lConta  = crSigMvEst.Estos
                            loc_lnTrabalhado   = 0
                            LOCAL loc_llTipoQ, loc_llGrvPrz
                            loc_llTipoQ  = .F.
                            loc_llGrvPrz = .F.
                            loc_lFalhaAdmitida = 0

                            * Movimentos de producao (SigCdNec/SigCdNei)
                            loc_lcQuery = "SELECT Datas, Dopps, GrupoOs, ContaOs, GrupoDs, ContaDs, " + ;
                                          "Emps, Numps, Obss, cIdChaves, EmpDnPs " + ;
                                          "FROM SigCdNec " + ;
                                          "WHERE Emps = " + EscaparSQL(loc_lcEmp) + " AND " + ;
                                          "Datas >= ?pDat AND " + ;
                                          "((GrupoDs = " + EscaparSQL(loc_lGrupo) + " AND ContaDs = " + EscaparSQL(loc_lConta) + " " + ;
                                          "AND (ProcdBal = ?loc_llFalse OR NumBalds<>" + STR(LocalFecha.codigos) + ")) " + ;
                                          "OR (GrupoOs = " + EscaparSQL(loc_lGrupo) + " AND ContaOs = " + EscaparSQL(loc_lConta) + " " + ;
                                          "AND (ProcBals = ?loc_llFalse OR NumBals<>" + STR(LocalFecha.Codigos) + "))) " + ;
                                          "ORDER BY Datas, Dopps, GrupoOs, ContaOs, GrupoDs, ContaDs, Emps, Numps, cIdChaves"
                            IF USED("LocalNens")
                                USE IN LocalNens
                            ENDIF
                            IF SQLEXEC(gnConnHandle, loc_lcQuery, "LocalNens") < 1
                                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (LocalNens)")
                                loc_lResultado = .F.
                                EXIT
                            ENDIF

                            loc_lcQuery = "SELECT b.EmpDNPs, b.CMats, b.CUnis, b.Nenvs, b.Pesos, b.Qtds, " + ;
                                          "b.TpOps, b.cIdChaves, b.Nops, b.Peso2s, b.CodCors, b.CodTams " + ;
                                          "FROM SigCdNec a, SigCdNei b " + ;
                                          "WHERE a.Emps = " + EscaparSQL(loc_lcEmp) + " AND " + ;
                                          "a.Datas >= ?pDat AND (a.GrupoDs = " + EscaparSQL(loc_lGrupo) + " OR a.GrupoOs = " + EscaparSQL(loc_lGrupo) + ") " + ;
                                          "AND (a.ContaDs = " + EscaparSQL(loc_lConta) + " OR a.ContaOs = " + EscaparSQL(loc_lConta) + ") AND " + ;
                                          "a.EmpDNPs = b.EmpDNPs AND " + ;
                                          "b.Servicos = ?pNot " + ;
                                          "ORDER BY b.EmpDNPs, b.CMats, b.CUnis, b.Nenvs, b.Pesos, b.Qtds, b.TpOps, b.cIdChaves, b.Nops"
                            IF USED("LocalNensI")
                                USE IN LocalNensI
                            ENDIF
                            IF SQLEXEC(gnConnHandle, loc_lcQuery, "LocalNensI") < 1
                                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (LocalNensI)")
                                loc_lResultado = .F.
                                EXIT
                            ENDIF
                            SELECT LocalNensI
                            INDEX ON EmpDNPs TAG EmpDNPs
                            SET ORDER TO EmpDNPs

                            LOCAL loc_loBarra6
                            SELECT LocalNens
                            loc_loBarra6 = CREATEOBJECT("fwprogressbar", "Processando Mov. de Produ" + CHR(231) + CHR(227) + "o...", RECCOUNT())
                            loc_loBarra6.Top = loc_loBarra6.Top + INT(loc_loBarra6.Height / 2)
                            loc_loBarra6.Show
                            SCAN
                                loc_loBarra6.UpDate(.T.)

                                IF DTOS(Datas) > DTOS(loc_ldDataL)
                                    LOOP
                                ENDIF

                                loc_lcEdn = LocalNens.Emps + LocalNens.Dopps + STR(LocalNens.Numps, 10)

                                =SEEK(LocalNens.Dopps, "crSigCdOpd", "Dopps")

                                loc_Origem   = .F.
                                loc_Destino  = .F.
                                LOCAL loc_lcMatPb
                                loc_lcMatPb  = SPACE(14)
                                loc_lcMatResFa = SPACE(14)

                                IF (crSigCdOpd.Origems = 1) AND (LocalNens.GrupoOs = loc_lGrupo) AND (LocalNens.ContaOs = loc_lConta) AND INLIST(crSigCdOpd.EstOrigs, 1, 2)
                                    loc_Origem = .T.
                                ENDIF

                                IF (crSigCdOpd.Destinos = 1) AND (LocalNens.GrupoDs = loc_lGrupo) AND (LocalNens.ContaDs = loc_lConta) AND INLIST(crSigCdOpd.EstDests, 1, 2)
                                    loc_Destino = .T.
                                ENDIF

                                IF NOT loc_Origem AND NOT loc_Destino
                                    LOOP
                                ENDIF

                                SELECT LocalNensI
                                SEEK loc_lcEdn
                                SCAN WHILE EmpDNPs = loc_lcEdn
                                    =SEEK(LocalNens.GrupoOs, "crSigCdGcr", "Codigos")

                                    IF CrSigCdGcr.UnifBals = 4
                                        IF LocalNensI.Nops = 0
                                            loc_lcMatPb = LocalNensI.CMats
                                        ELSE
                                            =SEEK(LocalNensI.Nops, "TmpOpi", "Nops")
                                            =SEEK(TmpOpi.Cpros, "TmpPro", "Cpros")
                                            loc_lcMatPb = IIF(EMPTY(TmpPro.MatPrincs), crSigCdPam.Ouros, TmpPro.MatPrincs)
                                        ENDIF
                                        IF LocalNensI.CMats <> loc_lcMatPb
                                            LOOP
                                        ENDIF
                                    ELSE
                                        IF CrSigCdGcr.UnifBals = 3
                                            =SEEK(LocalNensI.Nops, "TmpOpi", "Nops")
                                            IF LocalNensI.Nops = 0
                                                loc_lcMatPb = LocalNensI.CMats
                                            ELSE
                                                =SEEK(TmpOpi.Cpros, "TmpPro", "Cpros")
                                                loc_lcMatPb = IIF(EMPTY(TmpPro.MatPrincs), crSigCdPam.Ouros, TmpPro.MatPrincs)
                                            ENDIF
                                        ELSE
                                            loc_lcMatPb = IIF(CrSigCdGcr.UnifBals = 1, crSigCdPam.Ouros, LocalNensI.CMats)
                                        ENDIF
                                    ENDIF
                                    loc_lcMatResFa = loc_lcMatPb

                                    =SEEK(LocalNensI.CMats, "TmpPro", "CPros")
                                    =SEEK(TmpPro.Cgrus, "LocalGru", "Cgrus")
                                    =SEEK(LocalGru.Mercs, "LocalGgrp", "Codigos")

                                    loc_lcCodCor = PADR(IIF(INLIST(LocalGru.TipoEstos, 2, 4), LocalNensI.CodCors, " "), 4)
                                    loc_lcCodTam = PADR(IIF(INLIST(LocalGru.TipoEstos, 3, 4), LocalNensI.CodTams, " "), 4)

                                    IF loc_Origem
                                        IF NOT SEEK(LocalNens.GrupoOs + LocalNens.ContaOs + LocalNensI.CMats + loc_lcCodCor + loc_lcCodTam, "TmpResumo")
                                            INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams) ;
                                                         VALUES (LocalNens.GrupoOs, LocalNens.ContaOs, ;
                                                                 LocalNensI.CMats, TmpPro.CUnis, TmpPro.Varias, LocalGru.nAgMts, ;
                                                                 .T., loc_lcCodCor, loc_lcCodTam)
                                        ENDIF

                                        SELECT TmpResumo
                                        IF (crSigCdOpd.EstOrigs = 1)
                                            REPLACE PesoEnts  WITH PesoEnts  + LocalNensI.Pesos, ;
                                                    QtdeEnts  WITH QtdeEnts  + LocalNensI.Qtds, ;
                                                    PesoFabre WITH PesoFabre + LocalNensI.Peso2s
                                        ELSE
                                            REPLACE PesoSais WITH PesoSais + LocalNensI.Pesos, ;
                                                    QtdeSais WITH QtdeSais + LocalNensI.Qtds, ;
                                                    PesoFabrs WITH PesoFabrs + LocalNensI.Peso2s
                                        ENDIF
                                    ENDIF

                                    IF loc_Destino
                                        IF NOT SEEK(LocalNens.GrupoDs + LocalNens.ContaDs + LocalNensI.CMats + loc_lcCodCor + loc_lcCodTam, "TmpResumo")
                                            INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams) ;
                                                         VALUES (LocalNens.GrupoDs, LocalNens.ContaDs, LocalNensI.CMats, ;
                                                                 TmpPro.CUnis, TmpPro.Varias, LocalGru.nAgMts, .T., loc_lcCodCor, loc_lcCodTam)
                                        ENDIF

                                        SELECT TmpResumo
                                        IF (crSigCdOpd.EstDests = 1)
                                            REPLACE PesoEnts  WITH PesoEnts  + LocalNensI.Pesos, ;
                                                    QtdeEnts  WITH QtdeEnts  + LocalNensI.Qtds, ;
                                                    PesoFabre WITH PesoFabre + LocalNensI.Peso2s
                                        ELSE
                                            REPLACE PesoSais WITH PesoSais + LocalNensI.Pesos, ;
                                                    QtdeSais WITH QtdeSais + LocalNensI.Qtds, ;
                                                    PesoFabrs WITH PesoFabrs + LocalNensI.Peso2s
                                        ENDIF
                                    ENDIF

                                    =SEEK(TmpResumo.CMats, "TmpPro", "CPros")
                                    =SEEK(TmpPro.Cgrus, "LocalGru", "Cgrus")
                                    =SEEK(LocalGru.Mercs, "LocalGgrp", "Codigos")

                                    IF CrSigCdGcr.UnifBals = 3 AND LocalNensI.CMats <> loc_lcMatPb ;
                                        AND LocalGru.GruEstPs <> crSigMvEst.Grupos AND LocalGru.ConEstPs <> crSigMvEst.Estos
                                        =SEEK(loc_lcMatPb, "TmpPro", "CPros")
                                        =SEEK(TmpPro.Cgrus, "LocalGru", "CGrus")
                                        =SEEK(LocalGru.Mercs, "LocalGgrp", "Codigos")
                                        IF loc_Origem
                                            IF NOT SEEK(LocalNens.GrupoOs + LocalNens.ContaOs + loc_lcMatPb, "TmpResumo")
                                                INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Visivel) ;
                                                             VALUES (LocalNens.GrupoOs, LocalNens.ContaOs, ;
                                                                     loc_lcMatPb, TmpPro.CUnis, TmpPro.Varias, .T.)
                                            ENDIF
                                            SELECT TmpResumo
                                            IF (crSigCdOpd.EstOrigs = 1)
                                                REPLACE PesoEnts WITH PesoEnts + LocalNensI.Pesos, ;
                                                        QtdeEnts WITH QtdeEnts + LocalNensI.Pesos
                                            ELSE
                                                REPLACE PesoSais WITH PesoSais + LocalNensI.Pesos, ;
                                                        QtdeSais WITH QtdeSais + LocalNensI.Pesos
                                            ENDIF
                                        ENDIF

                                        IF loc_Destino
                                            IF NOT SEEK(LocalNens.GrupoDs + LocalNens.ContaDs + loc_lcMatPb, "TmpResumo")
                                                INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Visivel) ;
                                                             VALUES (LocalNens.GrupoDs, LocalNens.ContaDs, loc_lcMatPb, TmpPro.CUnis, TmpPro.Varias, .T.)
                                            ENDIF
                                            SELECT TmpResumo
                                            IF (crSigCdOpd.EstDests = 1)
                                                REPLACE PesoEnts WITH PesoEnts + LocalNensI.Pesos, ;
                                                        QtdeEnts WITH QtdeEnts + LocalNensI.Pesos
                                            ELSE
                                                REPLACE PesoSais WITH PesoSais + LocalNensI.Pesos, ;
                                                        QtdeSais WITH QtdeSais + LocalNensI.Pesos
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDSCAN
                            ENDSCAN
                            loc_loBarra6.Complete

                            IF NOT loc_lResultado
                                EXIT
                            ENDIF

                            * Movimentos de estoque (SigMvCab/SigMvItn/SigMvIts)
                            loc_lcQuery = "SELECT Datas, GrupoOs, ContaOs, GrupoDs, ContaDs, Emps, Dopes, Numes, Obses, CidChaves, EmpDs " + ;
                                          "FROM SigMvCab " + ;
                                          "WHERE (Emps = " + EscaparSQL(loc_lcEmp) + " OR EmpDs = " + EscaparSQL(loc_lcEmp) + ") AND " + ;
                                          "Datas >= ?pDat AND " + ;
                                          "( (GrupoDs = " + EscaparSQL(loc_lGrupo) + " AND ContaDs = " + EscaparSQL(loc_lConta) + " AND " + ;
                                          "(ProcdBal = ?loc_llFalse OR NumBalds<>" + STR(LocalFecha.codigos) + ")) " + ;
                                          "OR (GrupoOs = " + EscaparSQL(loc_lGrupo) + " AND ContaOs = " + EscaparSQL(loc_lConta) + " AND " + ;
                                          "(ProcBals = ?loc_llFalse OR NumBals<>" + STR(LocalFecha.Codigos) + ")) ) " + ;
                                          "ORDER BY Datas"
                            IF USED("LocalEest")
                                USE IN LocalEest
                            ENDIF
                            IF SQLEXEC(gnConnHandle, loc_lcQuery, "LocalEest") < 1
                                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (LocalEest)")
                                loc_lResultado = .F.
                                EXIT
                            ENDIF

                            loc_lcQuery = "SELECT b.EmpDopNums, b.Opers, b.CPros, b.CUnis, b.Qtds, b.Pesos, b.cItens " + ;
                                          "FROM SigMvCab a, SigMvItn b " + ;
                                          "WHERE (a.Emps = " + EscaparSQL(loc_lcEmp) + " OR a.Empds = " + EscaparSQL(loc_lcEmp) + ") AND " + ;
                                          "Datas >= ?pDat AND (GrupoDs = " + EscaparSQL(loc_lGrupo) + " Or GrupoOs = " + EscaparSQL(loc_lGrupo) + ") " + ;
                                          "AND (ContaDs = " + EscaparSQL(loc_lConta) + " Or ContaOs = " + EscaparSQL(loc_lConta) + ") AND " + ;
                                          "a.EmpDopNums = b.EmpDopNums " + ;
                                          "ORDER BY b.EmpDopNums, b.Opers, b.CPros, b.CUnis, b.Qtds, b.TpOps, b.cIdChaves, b.Nops"
                            IF USED("LocalEestI")
                                USE IN LocalEestI
                            ENDIF
                            IF SQLEXEC(gnConnHandle, loc_lcQuery, "LocalEestI") < 1
                                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (LocalEestI)")
                                loc_lResultado = .F.
                                EXIT
                            ENDIF
                            SELECT LocalEestI
                            INDEX ON EmpDopNums TAG EmpDopNums
                            SET ORDER TO EmpDopNums

                            loc_lcQuery = "SELECT b.EmpDopNums, b.CPros, b.Qtds, b.Pesos, b.CodCors, b.CodTams, b.Citens " + ;
                                          "FROM SigMvCab a, SigMvIts b " + ;
                                          "WHERE (a.Emps = " + EscaparSQL(loc_lcEmp) + " Or a.EmpDs = " + EscaparSQL(loc_lcEmp) + ") AND " + ;
                                          "Datas >= ?pDat AND (GrupoDs = " + EscaparSQL(loc_lGrupo) + " Or GrupoOs = " + EscaparSQL(loc_lGrupo) + ") " + ;
                                          "AND (ContaDs = " + EscaparSQL(loc_lConta) + " Or ContaOs = " + EscaparSQL(loc_lConta) + ") AND " + ;
                                          "a.EmpDopNums = b.EmpDopNums " + ;
                                          "ORDER BY b.EmpDopNums, b.CPros, b.codcors, b.codtams, b.citens"
                            IF USED("LocalEsti2")
                                USE IN LocalEsti2
                            ENDIF
                            IF SQLEXEC(gnConnHandle, loc_lcQuery, "LocalEsti2") < 1
                                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (LocalEsti2)")
                                loc_lResultado = .F.
                                EXIT
                            ENDIF
                            SELECT LocalEsti2
                            INDEX ON EmpDopNums + Cpros + STR(Citens, 4) TAG EmpDopNums
                            SET ORDER TO EmpDopNums

                            SELECT LocalEest
                            loc_loBarra6 = CREATEOBJECT("fwprogressbar", "Processando Mov. de Estoque", RECCOUNT("LocalEest"))
                            loc_loBarra6.Top = loc_loBarra6.Top + INT(loc_loBarra6.Height / 2)
                            loc_loBarra6.Show
                            SCAN
                                loc_loBarra6.Update(.T.)

                                IF DTOS(Datas) > DTOS(loc_ldDataL)
                                    LOOP
                                ENDIF

                                loc_lcEdn = LocalEest.Emps + LocalEest.Dopes + STR(LocalEest.Numes, 6)

                                =SEEK(LocalEest.Dopes, "crSigCdOpe", "Dopes")

                                LOCAL loc_lOrigem2, loc_lDestino2, loc_lChkOper
                                LOCAL loc_lGrupod2, loc_lContad2, loc_lOperacao
                                loc_lOrigem2  = .F.
                                loc_lDestino2 = .F.
                                loc_lChkOper  = .F.

                                IF LocalEest.Emps = loc_lcEmp
                                    IF (crSigCdOpe.EstOrigs = 4) OR (crSigCdOpe.Opers = 3)
                                        IF (crSigCdOpe.Origems = 1) AND (LocalEest.GrupoOs = loc_lGrupo) AND (LocalEest.ContaOs = loc_lConta)
                                            loc_lOrigem2 = .T.
                                        ELSE
                                            IF (crSigCdOpe.Destinos = 1) AND (LocalEest.GrupoDs = loc_lGrupo) AND (LocalEest.ContaDs = loc_lConta)
                                                loc_lDestino2 = .T.
                                            ENDIF
                                        ENDIF
                                    ELSE
                                        IF (crSigCdOpe.Origems = 1) AND (LocalEest.GrupoOs = loc_lGrupo) AND (LocalEest.ContaOs = loc_lConta)
                                            IF INLIST(crSigCdOpe.EstOrigs, 1, 2)
                                                loc_lOrigem2 = .T.
                                            ENDIF
                                        ENDIF
                                        IF (crSigCdOpe.Destinos = 1) AND (LocalEest.GrupoDs = loc_lGrupo) AND (LocalEest.ContaDs = loc_lConta)
                                            IF INLIST(crSigCdOpe.EstDests, 1, 2)
                                                loc_lDestino2 = .T.
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ELSE
                                    IF LocalEest.EmpDs = loc_lcEmp
                                        IF (crSigCdOpe.Destinos = 1) AND (LocalEest.GrupoDs = loc_lGrupo) AND (LocalEest.ContaDs = loc_lConta)
                                            IF INLIST(crSigCdOpe.EstDests, 1, 2)
                                                loc_lDestino2 = .T.
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF

                                IF NOT loc_lOrigem2 AND NOT loc_lDestino2
                                    LOOP
                                ENDIF

                                SELECT LocalEestI
                                SEEK loc_lcEdn
                                SCAN WHILE EmpDopNums = loc_lcEdn
                                    =SEEK(LocalEesti.Cpros, "TmpPro", "CPros")
                                    =SEEK(TmpPro.Cgrus, "LocalGru", "Cgrus")
                                    =SEEK(LocalGru.Mercs, "LocalGgrp", "Codigos")

                                    loc_lGrupod2   = SPACE(10)
                                    loc_lContad2   = SPACE(10)
                                    loc_lOperacao  = " "

                                    IF (crSigCdOpe.EstOrigs = 4)
                                        loc_lOrigem2  = .F.
                                        loc_lDestino2 = .F.

                                        IF (LocalEestI.Opers = "S") AND (LocalEest.GrupoOs = loc_lGrupo) AND (LocalEest.ContaOs = loc_lConta)
                                            loc_lOrigem2  = .T.
                                            loc_lOperacao = "S"
                                            loc_lGrupod2  = LocalEest.GrupoDs
                                            loc_lContad2  = LocalEest.ContaDs
                                        ELSE
                                            IF (LocalEestI.Opers = "E") AND (LocalEest.GrupoDs = loc_lGrupo) AND (LocalEest.ContaDs = loc_lConta)
                                                loc_lDestino2 = .T.
                                                loc_lOperacao = "E"
                                                loc_lGrupod2  = LocalEest.GrupoOs
                                                loc_lContad2  = LocalEest.ContaOs
                                            ENDIF
                                        ENDIF
                                    ELSE
                                        IF (crSigCdOpe.Opers = 3)
                                            IF (crSigCdOpe.Origems = 1)
                                                IF (LocalEestI.Opers = "S") AND (LocalEest.GrupoOs = loc_lGrupo) AND (LocalEest.ContaOs = loc_lConta)
                                                    loc_lOrigem2  = .T.
                                                    loc_lDestino2 = .F.
                                                    loc_lOperacao = "S"
                                                    loc_lGrupod2  = LocalEest.GrupoOs
                                                    loc_lContad2  = LocalEest.ContaOs
                                                ELSE
                                                    IF (LocalEestI.Opers = "E") AND (LocalEest.GrupoOs = loc_lGrupo) AND (LocalEest.ContaOs = loc_lConta)
                                                        loc_lOrigem2  = .F.
                                                        loc_lDestino2 = .T.
                                                        loc_lOperacao = "E"
                                                        loc_lGrupod2  = LocalEest.GrupoOs
                                                        loc_lContad2  = LocalEest.ContaOs
                                                    ENDIF
                                                ENDIF
                                            ELSE
                                                IF (crSigCdOpe.Destinos = 1)
                                                    IF (LocalEestI.Opers = "S") AND (LocalEest.GrupoDs = loc_lGrupo) AND (LocalEest.ContaDs = loc_lConta)
                                                        loc_lOrigem2  = .T.
                                                        loc_lOperacao = "S"
                                                        loc_lGrupod2  = LocalEest.GrupoDs
                                                        loc_lContad2  = LocalEest.ContaDs
                                                    ELSE
                                                        IF (LocalEestI.Opers = "E") AND (LocalEest.GrupoDs = loc_lGrupo) AND (LocalEest.ContaDs = loc_lConta)
                                                            loc_lDestino2 = .T.
                                                            loc_lOperacao = "E"
                                                            loc_lGrupod2  = LocalEest.GrupoDs
                                                            loc_lContad2  = LocalEest.ContaDs
                                                        ENDIF
                                                    ENDIF
                                                ENDIF
                                            ENDIF
                                        ELSE
                                            IF loc_lOrigem2 AND (crSigCdOpe.EstOrigs = 1)
                                                loc_lOperacao = "E"
                                                IF (crSigCdOpe.Destinos = 1) AND (crSigCdOpe.EstDests = 2)
                                                    loc_lGrupod2 = LocalEest.GrupoDs
                                                    loc_lContad2 = LocalEest.ContaDs
                                                ENDIF
                                            ELSE
                                                IF loc_lOrigem2 AND (crSigCdOpe.EstOrigs = 2)
                                                    loc_lOperacao = "S"
                                                    IF (crSigCdOpe.Destinos = 1) AND (crSigCdOpe.EstDests = 1)
                                                        loc_lGrupod2 = LocalEest.GrupoDs
                                                        loc_lContad2 = LocalEest.ContaDs
                                                    ENDIF
                                                ELSE
                                                    IF loc_lDestino2 AND (crSigCdOpe.EstDests = 1)
                                                        loc_lOperacao = "E"
                                                        IF (crSigCdOpe.Origems = 1) AND (crSigCdOpe.EstOrigs = 2)
                                                            loc_lGrupod2 = LocalEest.GrupoOs
                                                            loc_lContad2 = LocalEest.ContaOs
                                                        ENDIF
                                                    ELSE
                                                        IF loc_lDestino2 AND (crSigCdOpe.EstDests = 2)
                                                            loc_lOperacao = "S"
                                                            IF (crSigCdOpe.Origems = 1) AND (crSigCdOpe.EstOrigs = 1)
                                                                loc_lGrupod2 = LocalEest.GrupoOs
                                                                loc_lContad2 = LocalEest.ContaOs
                                                            ENDIF
                                                        ENDIF
                                                    ENDIF
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                    ENDIF

                                    IF INLIST(CrSigCdGcr.UnifBals, 3, 4)
                                        loc_lcMaterial = IIF(EMPTY(TmpPro.MatPrincs), crSigCdPam.Ouros, TmpPro.MatPrincs)
                                    ELSE
                                        loc_lcMaterial = IIF(CrSigCdGcr.UnifBals = 1, crSigCdPam.Ouros, LocalEesti.Cpros)
                                    ENDIF

                                    IF CrSigCdGcr.UnifBals = 4 AND LocalEestI.Cpros <> loc_lcMaterial
                                        LOOP
                                    ENDIF

                                    loc_lcMatResFa = loc_lcMaterial

                                    SELECT LocalEsti2
                                    SET ORDER TO EmpDopNums
                                    IF SEEK(LocalEesti.EmpDopNums + LocalEesti.Cpros + STR(LocalEesti.Citens, 4))
                                        LOCAL loc_lnQtde, loc_lnPeso2
                                        SCAN WHILE EmpDopNums + Cpros + STR(Citens, 4) = LocalEesti.EmpDopNums + LocalEesti.Cpros + STR(LocalEesti.Citens, 4)
                                            loc_lnQtde = LocalEsti2.Qtds
                                            loc_lnPeso2 = LocalEsti2.Pesos

                                            loc_lcCodCor = PADR(IIF(INLIST(LocalGru.TipoEstos, 2, 4), LocalEsti2.CodCors, " "), 4)
                                            loc_lcCodTam = PADR(IIF(INLIST(LocalGru.TipoEstos, 3, 4), LocalEsti2.CodTams, " "), 4)

                                            IF loc_lOrigem2
                                                IF NOT SEEK(loc_lGrupo + loc_lConta + LocalEsti2.CPros + loc_lcCodCor + loc_lcCodTam, "TmpResumo")
                                                    INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams) ;
                                                                 VALUES (loc_lGrupo, loc_lConta, LocalEestI.CPros, LocalEestI.CUnis, TmpPro.Varias, ;
                                                                         LocalGru.nAgMts, .T., loc_lcCodCor, loc_lcCodTam)
                                                ENDIF
                                                SELECT TmpResumo
                                                IF (loc_lOperacao = "E")
                                                    REPLACE QtdeEnts  WITH QtdeEnts  + LocalEsti2.Qtds, ;
                                                            PesoEnts  WITH PesoEnts  + loc_lnQtde, ;
                                                            PesoFabre WITH PesoFabre + loc_lnQtde
                                                ELSE
                                                    REPLACE QtdeSais  WITH QtdeSais  + LocalEsti2.Qtds, ;
                                                            PesoSais  WITH PesoSais  + loc_lnQtde, ;
                                                            PesoFabrs WITH PesoFabrs + loc_lnQtde
                                                ENDIF
                                            ENDIF

                                            IF loc_lDestino2
                                                IF NOT SEEK(loc_lGrupo + loc_lConta + LocalEsti2.CPros + loc_lcCodCor + loc_lcCodTam, "TmpResumo")
                                                    INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams) ;
                                                                 VALUES (loc_lGrupo, loc_lConta, LocalEestI.CPros, TmpPro.CUnis, TmpPro.Varias, ;
                                                                         LocalGru.nAgMts, .T., loc_lcCodCor, loc_lcCodTam)
                                                ENDIF
                                                SELECT TmpResumo
                                                IF (loc_lOperacao = "E")
                                                    REPLACE QtdeEnts  WITH QtdeEnts  + LocalEsti2.Qtds, ;
                                                            PesoEnts  WITH PesoEnts  + loc_lnQtde, ;
                                                            PesoFabre WITH PesoFabre + loc_lnQtde
                                                ELSE
                                                    REPLACE QtdeSais  WITH QtdeSais  + LocalEsti2.Qtds, ;
                                                            PesoSais  WITH PesoSais  + loc_lnQtde, ;
                                                            PesoFabrs WITH PesoFabrs + loc_lnQtde
                                                ENDIF
                                            ENDIF
                                        ENDSCAN
                                    ELSE
                                        loc_lnQtde  = LocalEesti.Qtds
                                        loc_lnPeso2 = LocalEesti.Pesos

                                        IF loc_lOrigem2
                                            IF NOT SEEK(loc_lGrupo + loc_lConta + LocalEestI.CPros, "TmpResumo")
                                                INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel) ;
                                                             VALUES (loc_lGrupo, loc_lConta, LocalEestI.CPros, LocalEestI.CUnis, TmpPro.Varias, LocalGru.nAgMts, .T.)
                                            ENDIF
                                            SELECT TmpResumo
                                            IF (loc_lOperacao = "E")
                                                REPLACE QtdeEnts  WITH QtdeEnts  + LocalEesti.Qtds, ;
                                                        PesoEnts  WITH PesoEnts  + loc_lnQtde, ;
                                                        PesoFabre WITH PesoFabre + loc_lnQtde
                                            ELSE
                                                REPLACE QtdeSais  WITH QtdeSais  + LocalEesti.Qtds, ;
                                                        PesoSais  WITH PesoSais  + loc_lnQtde, ;
                                                        PesoFabrs WITH PesoFabrs + loc_lnQtde
                                            ENDIF
                                        ENDIF

                                        IF loc_lDestino2
                                            IF NOT SEEK(loc_lGrupo + loc_lConta + LocalEestI.CPros, "TmpResumo")
                                                INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel) ;
                                                             VALUES (loc_lGrupo, loc_lConta, LocalEestI.CPros, TmpPro.CUnis, TmpPro.Varias, LocalGru.nAgMts, .T.)
                                            ENDIF
                                            SELECT TmpResumo
                                            IF (loc_lOperacao = "E")
                                                REPLACE QtdeEnts  WITH QtdeEnts  + LocalEesti.Qtds, ;
                                                        PesoEnts  WITH PesoEnts  + loc_lnQtde, ;
                                                        PesoFabre WITH PesoFabre + loc_lnQtde
                                            ELSE
                                                REPLACE QtdeSais  WITH QtdeSais  + LocalEesti.Qtds, ;
                                                        PesoSais  WITH PesoSais  + loc_lnQtde, ;
                                                        PesoFabrs WITH PesoFabrs + loc_lnQtde
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDSCAN
                            ENDSCAN
                            loc_loBarra6.Complete

                            * Marca registros processados do TmpResumo
                            SELECT TmpResumo
                            REPLACE Flag3 WITH .T. FOR Grupo + Conta = loc_lGrupo + loc_lConta

                            IF (CrSigCdGcr.UnifBals = 1)
                                loc_lcMat = crSigCdPam.Ouros
                                SELECT TmpResumo
                                IF NOT SEEK(loc_lGrupo + loc_lConta + loc_lcMat)
                                    APPEND BLANK
                                    REPLACE CMats   WITH loc_lcMat, ;
                                            Grupo   WITH loc_lGrupo, ;
                                            Conta   WITH loc_lConta, ;
                                            Visivel WITH .T.
                                ENDIF

                                SELECT [ ] AS Agrupar, SUM(PesoEnts) AS pEnts, SUM(PesoSais) AS pSais ;
                                       FROM TmpResumo ;
                                       WHERE Grupo + Conta = loc_lGrupo + loc_lConta AND Cmats <> loc_lcMat ;
                                             AND Varias <> 1 AND Agregas <> 1 ;
                                       INTO CURSOR csTotal GROUP BY 1
                                GO TOP IN csTotal

                                SELECT TmpResumo
                                =SEEK(loc_lGrupo + loc_lConta)
                                SCAN WHILE Grupo + Conta = loc_lGrupo + loc_lConta
                                    IF (CMats = loc_lcMat)
                                        REPLACE PesoEnts WITH PesoEnts + csTotal.pEnts
                                        REPLACE PesoSais WITH PesoSais + csTotal.pSais
                                        REPLACE QtdeEnts WITH QtdeEnts + csTotal.pEnts
                                        REPLACE QtdeSais WITH QtdeSais + csTotal.pSais
                                    ELSE
                                        IF Agregas <> 1
                                            REPLACE Visivel WITH .F., ;
                                                    Flag3   WITH .F.
                                        ENDIF
                                    ENDIF
                                ENDSCAN
                            ENDIF

                            * Busca saldo anterior (SigOpCfe)
                            loc_lcSql = "SELECT * FROM SigOpCfe WHERE Codigos = " + STR(LocalFecha.Codigos, 6) + ;
                                        " AND Emps = " + EscaparSQL(loc_lcEmp) + " ORDER BY Codigos, cpros"
                            IF USED("CrSaldoI")
                                USE IN CrSaldoI
                            ENDIF
                            IF SQLEXEC(gnConnHandle, loc_lcSql, "CrSaldoI") < 1
                                MsgErro("Favor reinicializar o processo.", "Falha na Conex" + CHR(227) + "o (CrSaldoI)")
                                loc_lResultado = .F.
                                EXIT
                            ENDIF

                            SELECT CrSaldoI
                            INDEX ON Cpros TAG Cpros

                            LOCAL loc_lnSaldoiPb, loc_lnSaidasPb, loc_lnPesagemPb, loc_lcCMatPb
                            loc_lcCMatPb = SPACE(14)

                            SELECT TmpResumo
                            SET ORDER TO GrConMat
                            =SEEK(loc_lGrupo + loc_lConta)
                            SCAN WHILE Grupo + Conta = loc_lGrupo + loc_lConta
                                STORE 0 TO loc_lnSaldoiPb, loc_lnSaidasPb, loc_lnPesagemPb

                                =SEEK(TmpResumo.CMats, "TmpPro", "CPros")
                                IF NOT loc_llTipoQ AND TmpResumo.CMats <> loc_lcCMatPb
                                    STORE 0 TO loc_lFalhaAdmitida
                                    loc_lcCMatPb = TmpResumo.CMats
                                ENDIF

                                SELECT CrSaldoI
                                =SEEK(TmpResumo.CMats)
                                loc_lnSaldoiPb = CrSaldoI.Pesagems

                                SELECT TmpResumo
                                REPLACE Saldoi  WITH loc_lnSaldoiPb, ;
                                        FReal   WITH loc_lnSaldoiPb + TmpResumo.QtdeEnts - TmpResumo.QtdeSais - TmpResumo.Pesagem, ;
                                        FAdmin  WITH loc_lFalhaAdmitida, ;
                                        Saldof  WITH loc_lnSaldoiPb + TmpResumo.QtdeEnts - TmpResumo.QtdeSais - TmpResumo.Pesagem - loc_lFalhaAdmitida, ;
                                        PfTrabs WITH IIF(loc_lnTrabalhado <> 0, (Saldof / loc_lnTrabalhado * 100), 0)

                                IF (TmpResumo.Saldof <> 0) AND (CrSigCdCli.PagFals = 1 OR CrSigCdCli.RecFals = 1)
                                    REPLACE Flag  WITH .T., ;
                                            Flag2 WITH (CrSigCdCli.PagFals = 1 OR CrSigCdCli.RecFals = 1) IN TmpResumo
                                ENDIF
                            ENDSCAN

                            SELECT CrSaldoI
                            loc_lcCMatPb = SPACE(14)
                            SCAN
                                IF CrSaldoI.Pesagems = 0
                                    LOOP
                                ENDIF
                                =SEEK(CrSaldoI.Cpros, "TmpPro", "CPros")
                                =SEEK(TmpPro.Cgrus, "LocalGru", "Cgrus")

                                loc_lnSaldoiPb = CrSaldoI.Pesagems

                                SELECT TmpResumo
                                LOCATE FOR Grupo + Conta + CMats = loc_lGrupo + loc_lConta + CrSaldoI.Cpros
                                IF EOF()
                                    INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel) ;
                                                 VALUES (loc_lGrupo, loc_lConta, CrSaldoI.Cpros, ;
                                                         TmpPro.CUnis, TmpPro.Varias, LocalGru.nAgMts, .T.)
                                    SELECT TmpResumo
                                    REPLACE Saldoi  WITH loc_lnSaldoiPb, ;
                                            FReal   WITH loc_lnSaldoiPb + TmpResumo.QtdeEnts - TmpResumo.QtdeSais - TmpResumo.Pesagem, ;
                                            FAdmin  WITH 0, ;
                                            Saldof  WITH loc_lnSaldoiPb + TmpResumo.QtdeEnts - TmpResumo.QtdeSais - TmpResumo.Pesagem - 0, ;
                                            PfTrabs WITH 0
                                ENDIF
                            ENDSCAN

                            * Insere em Saldos (lnCt=2) ou SaldoAnt (lnCt=1)
                            SELECT TmpResumo
                            =SEEK(loc_lGrupo + loc_lConta + loc_lcCodMat)
                            SCAN WHILE Grupo + Conta + CMats = (loc_lGrupo + loc_lConta + loc_lcCodMat)
                                IF loc_lnCt = 2
                                    IF NOT SEEK(loc_lGrupo, "Saldos")
                                        INSERT INTO Saldos (Grupos, Contas, Emps) VALUES (loc_lGrupo, loc_lConta, loc_lcEmp)
                                    ENDIF
                                    REPLACE Qtde WITH Qtde + TmpResumo.SaldoF IN Saldos
                                ELSE
                                    IF NOT SEEK(loc_lGrupo, "SaldoAnt")
                                        INSERT INTO SaldoAnt (Grupos, Contas, Emps) VALUES (loc_lGrupo, loc_lConta, loc_lcEmp)
                                    ENDIF
                                    REPLACE Qtde WITH Qtde + TmpResumo.SaldoF IN SaldoAnt
                                ENDIF
                            ENDSCAN
                        NEXT  && lnCt

                    ENDIF  && GerBals OK
                ENDIF  && CrSigCdCli loaded OK
            ENDIF  && CrSigCdCli loaded

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em PosBalanco")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega parametros do cursor (OPERACIONAL)
    * Diferente dos forms CRUD, aqui o cursor eh de PARAMETROS de execucao
    * (data inicial, data final, demonstrativo selecionado).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
                THIS.this_cMensagemErro = "Cursor n" + CHR(227) + "o dispon" + CHR(237) + "vel: " + par_cAliasCursor
                loc_lResultado = .F.
            ELSE
                SELECT (par_cAliasCursor)

                IF TYPE(par_cAliasCursor + ".Datai") != "U"
                    THIS.this_dDatai = IIF(VARTYPE(EVALUATE(par_cAliasCursor + ".Datai")) = "D", ;
                                           EVALUATE(par_cAliasCursor + ".Datai"), {})
                ENDIF

                IF TYPE(par_cAliasCursor + ".Dataf") != "U"
                    THIS.this_dDataf = IIF(VARTYPE(EVALUATE(par_cAliasCursor + ".Dataf")) = "D", ;
                                           EVALUATE(par_cAliasCursor + ".Dataf"), {})
                ENDIF

                IF TYPE(par_cAliasCursor + ".Demonstrativo") != "U"
                    THIS.this_cDemonstrativo = TratarNulo(EVALUATE(par_cAliasCursor + ".Demonstrativo"), "C")
                ENDIF

                IF TYPE(par_cAliasCursor + ".Empresa") != "U"
                    THIS.this_cEmpresa = TratarNulo(EVALUATE(par_cAliasCursor + ".Empresa"), "C")
                ELSE
                    THIS.this_cEmpresa = go_4c_Sistema.cCodEmpresa
                ENDIF

                IF TYPE(par_cAliasCursor + ".CodMat") != "U"
                    THIS.this_cCodMat = TratarNulo(EVALUATE(par_cAliasCursor + ".CodMat"), "C")
                ENDIF

                IF TYPE(par_cAliasCursor + ".DopeBals") != "U"
                    THIS.this_cDopeBals = TratarNulo(EVALUATE(par_cAliasCursor + ".DopeBals"), "C")
                ENDIF

                IF TYPE(par_cAliasCursor + ".NdFechas") != "U"
                    THIS.this_nNdFechas = TratarNulo(EVALUATE(par_cAliasCursor + ".NdFechas"), "N")
                ENDIF

                IF TYPE(par_cAliasCursor + ".GruposDmo") != "U"
                    THIS.this_cGruposDmo = TratarNulo(EVALUATE(par_cAliasCursor + ".GruposDmo"), "C")
                ENDIF

                IF TYPE(par_cAliasCursor + ".ContasDmo") != "U"
                    THIS.this_cContasDmo = TratarNulo(EVALUATE(par_cAliasCursor + ".ContasDmo"), "C")
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar do cursor: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir - OPERACIONAL nao possui INSERT direto (form de analise)
    * A "insercao" equivale a executar a analise e registrar auditoria.
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            IF EMPTY(THIS.this_cDemonstrativo)
                THIS.this_cMensagemErro = "Demonstrativo n" + CHR(227) + "o informado."
                loc_lResultado = .F.
            ELSE
                IF EMPTY(THIS.this_dDataf)
                    THIS.this_cMensagemErro = "Data final n" + CHR(227) + "o informada."
                    loc_lResultado = .F.
                ELSE
                    IF !EMPTY(THIS.this_dDatai) AND THIS.this_dDatai > THIS.this_dDataf
                        THIS.this_cMensagemErro = "Data final deve ser maior que a data inicial."
                        loc_lResultado = .F.
                    ELSE
                        loc_lResultado = THIS.ProcessarAnalise()

                        IF loc_lResultado
                            THIS.RegistrarAuditoria("EXECUCAO ANALISE PRODUCAO")
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro em Inserir: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Atualizar - OPERACIONAL nao possui UPDATE direto (form de analise)
    * "Atualizacao" equivale a reprocessar a analise com novos parametros.
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            IF EMPTY(THIS.this_cDemonstrativo)
                THIS.this_cMensagemErro = "Demonstrativo n" + CHR(227) + "o informado."
                loc_lResultado = .F.
            ELSE
                IF EMPTY(THIS.this_dDataf)
                    THIS.this_cMensagemErro = "Data final n" + CHR(227) + "o informada."
                    loc_lResultado = .F.
                ELSE
                    IF !EMPTY(THIS.this_dDatai) AND THIS.this_dDatai > THIS.this_dDataf
                        THIS.this_cMensagemErro = "Data final deve ser maior que a data inicial."
                        loc_lResultado = .F.
                    ELSE
                        loc_lResultado = THIS.ProcessarAnalise()

                        IF loc_lResultado
                            THIS.RegistrarAuditoria("REPROCESSAMENTO ANALISE PRODUCAO")
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro em Atualizar: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * RegistrarAuditoria - Override para OPERACIONAL
    * Registra execucao da analise em LogAuditoria (sem tabela CRUD principal).
    *==========================================================================
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cDetalhe, loc_oErro
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF gnConnHandle > 0
                loc_cChave = THIS.ObterChavePrimaria()

                loc_cDetalhe = "Demonstrativo=" + ALLTRIM(THIS.this_cDemonstrativo) + ;
                               " Datai=" + DTOC(THIS.this_dDatai) + ;
                               " Dataf=" + DTOC(THIS.this_dDataf) + ;
                               " Emp=" + ALLTRIM(THIS.this_cEmpresa)

                loc_cSQL = "INSERT INTO LogAuditoria " + ;
                           "(Usuario, DataHora, Operacao, Tabela, ChaveRegistro, DadosNovos) " + ;
                           "VALUES (" + ;
                           EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                           "GETDATE(), " + ;
                           EscaparSQL(par_cOperacao) + ", " + ;
                           EscaparSQL("SIGPRFEM") + ", " + ;
                           EscaparSQL(loc_cChave) + ", " + ;
                           EscaparSQL(loc_cDetalhe) + ")"

                IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            * Falha em auditoria nao deve interromper a operacao
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
