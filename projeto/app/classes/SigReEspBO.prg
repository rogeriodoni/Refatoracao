*==============================================================================
* SIGREEESPBO.PRG
* Business Object para Relatorio de Estatistica de Pedidos (SIGREESP)
* Herda de RelatorioBase
*
* Relatorios FRX: SigReEsp.frx (por movimentacao), SigReEs2.frx (por tipo)
*
* Filtros mapeados do form legado SIGREESP:
*   - Periodo (datas inicial/final + tipo: lancamento/entrega/alt/fechamento)
*   - Operacao/movimentacao (nome + numero PV)
*   - Tipo de operacao (codigo + descricao de SigCdTom)
*   - Conta (getCdEstoque/getDsEstoque - ContaDs/ContaOs de SigMvCab)
*   - Vendedor (getCdVendedor/getDsVendedor - Vends de SigMvCab)
*   - Cidade / Estado/UF
*   - Situacao dos pedidos (Encerrados/Abertos/Ambos)
*   - Opcao de impressao (Vendedor/Cidade/Data Encerramento)
*   - Ordem de exibicao (6 opcoes de cmbOrdem1)
*   - Tipo de analise (Analitico/Sintetico)
*   - Checkboxes: TpOpe, Itens, Indus, SemVals
*   - Moeda (get_cd_moeda/get_ds_moeda)
*   - Tipos de operacao selecionados no grid crOperacoes (SelImp/SelImp2/SelImp3)
*==============================================================================

DEFINE CLASS SigReEspBO AS RelatorioBase

    this_cTabela        = ""
    this_cCampoChave    = ""
    this_cMensagemErro  = ""

    *-- Filtro: periodo
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Tipo de periodo (Opt_nr_periodo: 1=Lancamento 2=Entrega 3=Ult.Alteracao 4=Fechamento)
    this_nPeriodo       = 1

    *-- Filtro: operacao/movimentacao (get_nm_operacao)
    this_cNmOperacao    = ""

    *-- Filtro: numero do PV (Get_Numero)
    this_nNumero        = 0

    *-- Filtro: tipo de operacao (getCdTpOpe / getDsTpOpe - SigCdTom)
    this_nCdTpOpe       = 0
    this_cDsTpOpe       = ""

    *-- Filtro: conta (getCdEstoque / getDsEstoque - ContaDs/ContaOs de SigMvCab)
    this_cCdConta       = ""
    this_cDsConta       = ""

    *-- Filtro: vendedor (getCdVendedor / getDsVendedor - Vends de SigMvCab)
    this_cCdVendedor    = ""
    this_cDsVendedor    = ""

    *-- Filtro: cidade / estado/UF
    this_cCidade        = ""
    this_cEstado        = ""

    *-- Situacao dos pedidos (opt_filtro: 1=Encerrados 2=Abertos 3=Ambos)
    this_nFiltro        = 3

    *-- Opcao de impressao (Opc_Imp: 1=Vendedor 2=Cidade 3=Data Encerramento)
    this_nOpcImp        = 1

    *-- Ordem de exibicao (cmbOrdem1 ListIndex)
    *   1=Cliente 2=Digitacao 3=Entrega 4=Vendedor+Digitacao 5=Vendedor+Entrega 6=Vendedor+Cliente
    this_nOrdem         = 1

    *-- Tipo de analise (optAnaSin: 1=Analitico 2=Sintetico)
    this_nAnaSin        = 2

    *-- Checkboxes convertidos a logico pelo form (chkXxx.Value = 1)
    this_lTpOpe         = .F.
    this_lItens         = .F.
    this_lIndus         = .F.
    this_lSemVals       = .F.

    *-- Filtro: moeda (get_cd_moeda / get_ds_moeda - SigCdMoe)
    this_cCdMoeda       = ""
    this_cDsMoeda       = ""

    *-- Listas de tipos de operacao selecionados no grid crOperacoes
    *   Geradas pelo Form em FormParaRelatorio() escaneando crOperacoes
    *   Formato: "(cod1,cod2,...) " ou "" quando nenhum selecionado
    *   Usadas em SQL: "d.TipoOps IN this_cTpOpeM"
    this_cTpOpeM        = ""
    this_cTpOpeE        = ""
    this_cTpOpeC        = ""

    *-- Cursor de saida populado por PrepararDados()
    this_cCursorDados   = "csRelatorio"

    *--------------------------------------------------------------------------
    * Init - Configura BO do relatorio de estatistica de pedidos
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa estatistica de pedidos (equivalente a PROCEDURE processamento)
    * Popula cursor csRelatorio com os dados calculados para o relatorio
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_lnResult
        LOCAL loc_lcNmOperacao, loc_lnNrPeriodo, loc_ldDtInicial, loc_ldDtFinal
        LOCAL loc_lcCVendedor, loc_lcDVendedor, loc_lcCconta, loc_lcDconta
        LOCAL loc_lnOrdem, loc_lnOpcao, loc_lcCidade, loc_lcEstado
        LOCAL loc_lnOpcImp, loc_lnTpOpe, loc_llTpOpe, loc_lcMoeda, loc_llIndus
        LOCAL loc_lcTpOpeM, loc_lcTpOpeE, loc_lcTpOpeC
        LOCAL loc_lcNmEmpresa, loc_lcNmTitulo, loc_lcNmPeriodo
        LOCAL loc_lcQuery, loc_lcEscape, loc_lnDecimals, loc_lcFixed
        LOCAL loc_lcEdn, loc_lnReg, loc_lnValors
        LOCAL loc_lnCotaOpera, loc_lnCotaVenda, loc_lnVenda
        LOCAL loc_lnOp, loc_lnTotMov, loc_lnCItem, loc_llInseriu, loc_lnFiltro
        LOCAL loc_lnCodigo, loc_lcSql
        LOCAL loc_lnDtdPDf_Expr, loc_lnOrdeBy_Expr
        LOCAL loc_lScanOk1, loc_lScanOk2
        LOCAL loc_nI, loc_cCursor, loc_aCursores
        PRIVATE pDtI, pDtF, pTru, lnNumes

        loc_lSucesso = .F.

        TRY
            * Ler propriedades do BO
            loc_lcNmOperacao = ALLTRIM(THIS.this_cNmOperacao)
            loc_lnNrPeriodo  = THIS.this_nPeriodo
            loc_ldDtInicial  = THIS.this_dDtInicial
            loc_ldDtFinal    = THIS.this_dDtFinal
            loc_lcCVendedor  = ALLTRIM(THIS.this_cCdVendedor)
            loc_lcDVendedor  = ALLTRIM(THIS.this_cDsVendedor)
            loc_lcCconta     = ALLTRIM(THIS.this_cCdConta)
            loc_lcDconta     = ALLTRIM(THIS.this_cDsConta)
            loc_lnOrdem      = THIS.this_nOrdem
            loc_lnOpcao      = THIS.this_nFiltro
            loc_lcCidade     = ALLTRIM(THIS.this_cCidade)
            loc_lcEstado     = ALLTRIM(THIS.this_cEstado)
            loc_lnOpcImp     = THIS.this_nOpcImp
            loc_lnTpOpe      = THIS.this_nCdTpOpe
            lnNumes          = THIS.this_nNumero
            loc_llTpOpe      = THIS.this_lTpOpe
            loc_lcMoeda      = ALLTRIM(THIS.this_cCdMoeda)
            loc_llIndus      = THIS.this_lIndus
            loc_lcTpOpeM     = THIS.this_cTpOpeM
            loc_lcTpOpeE     = THIS.this_cTpOpeE
            loc_lcTpOpeC     = THIS.this_cTpOpeC

            * Parametros de data para parameterizacao SQL (?pDtI, ?pDtF)
            pDtI = DATETIME(YEAR(loc_ldDtInicial), MONTH(loc_ldDtInicial), DAY(loc_ldDtInicial), 0, 0, 0)
            pDtF = DATETIME(YEAR(loc_ldDtFinal), MONTH(loc_ldDtFinal), DAY(loc_ldDtFinal), 23, 59, 59)
            pTru = .T.

            * Fecha cursores anteriores
            DIMENSION loc_aCursores(18)
            loc_aCursores(1)  = "crSigCdOpe"
            loc_aCursores(2)  = "crSigCdEmp"
            loc_aCursores(3)  = "crSigCdPam"
            loc_aCursores(4)  = "csRelatorio"
            loc_aCursores(5)  = "csCabecalho"
            loc_aCursores(6)  = "ResPed"
            loc_aCursores(7)  = "ResPed1"
            loc_aCursores(8)  = "TotPed"
            loc_aCursores(9)  = "Fabricado"
            loc_aCursores(10) = "TmpFab"
            loc_aCursores(11) = "csQtde"
            loc_aCursores(12) = "CrxOpe"
            loc_aCursores(13) = "CrTmpMov"
            loc_aCursores(14) = "crSigBxEst"
            loc_aCursores(15) = "csTotal"
            loc_aCursores(16) = "csTotal2"
            loc_aCursores(17) = "TmpTotal"
            loc_aCursores(18) = "TmpEmpenho"
            FOR loc_nI = 1 TO ALEN(loc_aCursores)
                loc_cCursor = loc_aCursores[loc_nI]
                IF USED(loc_cCursor)
                    USE IN (loc_cCursor)
                ENDIF
            ENDFOR

            * Carrega operacoes (join SigCdOpe x SigOpCdc)
            loc_lnResult = SQLEXEC(gnConnHandle, ;
                "SELECT a.Dopes, a.Abrevs, a.Globalizas, a.Servicos, b.CarCompos " + ;
                "FROM SigCdOpe a INNER JOIN SigOpCdc b ON a.Dopes = b.Dopes", ;
                "crSigCdOpe")
            IF loc_lnResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar opera" + CHR(231) + CHR(245) + "es (crSigCdOpe)"
                loc_lSucesso = .F.
            ENDIF

            * Razao social da empresa
            loc_lnResult = SQLEXEC(gnConnHandle, ;
                "SELECT Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa), ;
                "crSigCdEmp")
            IF loc_lnResult >= 1 AND USED("crSigCdEmp") AND !EOF("crSigCdEmp")
                loc_lcNmEmpresa = ALLTRIM(crSigCdEmp.Razas)
            ELSE
                loc_lcNmEmpresa = ""
            ENDIF

            * Parametros da empresa (TransfRes para identificar operacao de reserva)
            SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 TransfRes FROM SigCdPam", ;
                "crSigCdPam")

            * Monta titulo do relatorio
            loc_lcNmTitulo = "An" + CHR(225) + "lise de Pedidos : " + ;
                IIF(EMPTY(loc_lcNmOperacao), ALLTRIM(THIS.this_cDsTpOpe), PROPER(loc_lcNmOperacao))
            loc_lcNmPeriodo = "Per" + CHR(237) + "odo de " + ;
                IIF(loc_lnNrPeriodo=1, "Lan" + CHR(231) + "amento", ;
                    IIF(loc_lnNrPeriodo=2, "Entrega", ;
                        IIF(loc_lnNrPeriodo=3, CHR(218) + "lt. Altera" + CHR(231) + CHR(227) + "o", ;
                            "Fechamento"))) + " : " + ;
                DTOC(loc_ldDtInicial) + " " + CHR(224) + " " + DTOC(loc_ldDtFinal) + " - " + ;
                IIF(EMPTY(loc_lcCconta), "", CHR(13) + "Conta " + loc_lcCconta + " " + loc_lcDconta) + ;
                IIF(EMPTY(loc_lcCVendedor), "", CHR(13) + "Vendedor " + loc_lcCVendedor + " " + loc_lcDVendedor) + ;
                IIF(EMPTY(loc_lcMoeda), "", CHR(13) + " Moeda " + loc_lcMoeda) + ;
                IIF(EMPTY(loc_lcCidade) AND EMPTY(loc_lcEstado), "", CHR(13) + ;
                    IIF(EMPTY(loc_lcCidade), "", "Cidade ") + loc_lcCidade + ;
                    IIF(EMPTY(loc_lcEstado), "", " Uf ") + loc_lcEstado)

            * Cursor de cabecalho para o relatorio
            CREATE CURSOR csCabecalho (nm_empresa C(80), nm_titulo C(254), nm_periodo C(254), ;
                                        mostrar N(1), cidade L, ImpVals L)
            INSERT INTO csCabecalho (nm_empresa, nm_titulo, nm_periodo, mostrar, cidade, ImpVals) ;
                VALUES (loc_lcNmEmpresa, loc_lcNmTitulo, loc_lcNmPeriodo, ;
                        loc_lnOpcImp, (loc_lnOpcImp = 2), EMPTY(loc_lcMoeda))

            * Salva e configura SETs
            loc_lcEscape   = SET("Escape")
            loc_lnDecimals = SET("Decimals")
            loc_lcFixed    = SET("Fixed")
            SET ESCAPE OFF
            SET DECIMALS TO 2
            SET FIXED ON

            * Localiza operacao no cursor de referencias
            SELECT crSigCdOpe
            GO TOP
            LOCATE FOR Dopes = loc_lcNmOperacao

            * Monta query principal contra SigMvCab / SigMvItn / SigCdCli / SigCdOpe
            loc_lcQuery = [Select a.Emps, a.Dopes, a.Numes, c.Iclis, c.Rclis, c.Cidas, c.Estas, ] + ;
                          [a.Qtds, b.Utilizados, a.QtBaixas, a.QtReservas, b.Nops, b.Vends, ] + ;
                          [b.Datas, b.PrazoEnts, b.DtFechas ] + ;
                          [From SigMvCab b, SigMvItn a, SigCdCli c, SigCdOpe o ] + ;
                          [Where b.EmpDopNums = a.EmpDopNums And ] + ;
                          IIF(EMPTY(loc_lcNmOperacao), [o.TipoOps = ] + STR(loc_lnTpOpe), ;
                              [b.Dopes = '] + loc_lcNmOperacao + [' ]) + [ And ] + ;
                          IIF(lnNumes = 0, [], [b.Numes = ?lnNumes And ]) + ;
                          IIF(loc_lnNrPeriodo=1, [b.Datas], ;
                              IIF(loc_lnNrPeriodo=2, [b.PrazoEnts], ;
                                  IIF(loc_lnNrPeriodo=3, [b.Datars], [b.DtFechas]))) + ;
                          [ BetWeen ?pDtI And ?pDtF And ] + ;
                          IIF(EMPTY(loc_lcCconta), [], ;
                              [(b.ContaDs = '] + loc_lcCconta + [' Or b.ContaOs = '] + loc_lcCconta + [') And ]) + ;
                          IIF(EMPTY(loc_lcCVendedor), [], [b.Vends = '] + loc_lcCVendedor + [' And ]) + ;
                          [b.Dopes = o.Dopes And ] + ;
                          IIF(crSigCdOpe.globalizas = 1 OR crSigCdOpe.Servicos = 1, ;
                              [b.ContaOs = c.Iclis And ], [b.ContaDs = c.Iclis And ]) + ;
                          IIF(crSigCdOpe.CarCompos = 5, [a.Citem2 = 0 And ], []) + ;
                          IIF(EMPTY(loc_lcCidade), [], [c.Cidas = '] + PADR(loc_lcCidade, 30) + [' And ]) + ;
                          IIF(EMPTY(loc_lcEstado), [], [c.Estas = '] + PADR(loc_lcEstado, 02) + [' And ]) + ;
                          [c.GruProds = '] + SPACE(10) + [' ] + ;
                          IIF(loc_llIndus, [And b.Nops <> 0], [])

            IF SQLEXEC(gnConnHandle, loc_lcQuery, "ResPed1") < 1
                THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (ResPed1)"
                SET ESCAPE &loc_lcEscape.
                SET DECIMALS TO (loc_lnDecimals)
                SET FIXED &loc_lcFixed.
                loc_lSucesso = .F.
            ENDIF

            * Agrega ResPed1 -> ResPed com GROUP BY
            SELECT a.Emps, a.Dopes, a.Numes, a.Iclis, a.Rclis, a.Cidas, a.Estas, a.Utilizados, a.Nops, ;
                a.Vends, NVL(TTOD(a.Datas), {}) AS Datas, ;
                NVL(TTOD(IIF(EMPTY(a.PrazoEnts), a.Datas, a.PrazoEnts)), {}) AS DtEnts, ;
                NVL(TTOD(a.DtFechas), {}) AS DataEps, ;
                a.Emps + '-' + b.Abrevs + ':' + STR(a.Numes, 6) AS Abrevs, ;
                SUM(a.Qtds) AS Qtds, SUM(a.QtBaixas) AS QtdBs, ;
                SUM(IIF(a.Utilizados=1, a.Qtds, a.QtReservas)) AS QtdNps ;
              FROM ResPed1 a, CrSigCdOpe b ;
              WHERE a.Dopes = b.Dopes ;
             GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14 ;
             INTO CURSOR ResPed

            * Total por pedido para calculo de percentuais
            SELECT Emps + Dopes + STR(Numes,6) AS EmpDopNums, SUM(Qtds) AS Qtds ;
              FROM ResPed INTO CURSOR TotPed GROUP BY 1
            SELECT TotPed
            INDEX ON EmpDopNums TAG EmpDopNums

            * Cursor Fabricado: quantidade produzida por pedido
            CREATE CURSOR Fabricado (Emps C(3), Dopes C(20), Numes N(6), Qtds N(10,3), QtdCancs N(12,3))
            INDEX ON Emps + Dopes + STR(Numes, 6) TAG EmpDopNum

            SELECT DISTINCT Emps, Dopes, Numes FROM ResPed INTO CURSOR TmpFab

            * Calcula Fabricado: loop por pedido
            loc_lScanOk1 = .T.
            SELECT TmpFab
            SCAN WHILE loc_lScanOk1
                LOCAL loc_Tqtd, loc_xQtd, loc_lnQtdCanc, loc_QtdTot
                loc_lcEdn = TmpFab.Emps + TmpFab.Dopes + STR(TmpFab.Numes, 6)

                loc_lcQuery = [Select a.EmpdopNums, b.chksubn, b.Lccs, Sum(a.Qtds) as Qtds ] + ;
                              [From SigOpPic a, SigCdNec b ] + ;
                              [Where a.EmpDopNums = '] + loc_lcEdn + [' And ] + ;
                              [a.EmpDopNops = b.EmpDNps ] + ;
                              [Group by a.EmpdopNums, b.ChkSubn, b.Lccs]

                IF SQLEXEC(gnConnHandle, loc_lcQuery, "csQtde") < 1
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (csQtde-fab)"
                    loc_lSucesso = .F.
                    loc_lScanOk1 = .F.
                    EXIT
                ENDIF

                SELECT csQtde
                SUM Qtds TO loc_Tqtd
                SUM Qtds TO loc_xQtd FOR ChkSubn
                SUM Qtds TO loc_lnQtdCanc FOR ChkSubn AND Lccs

                SELECT TotPed
                =SEEK(loc_lcEdn)
                loc_QtdTot = loc_xQtd

                IF loc_QtdTot > 0
                    IF !SEEK(loc_lcEdn, "Fabricado", "EmpDopNum")
                        INSERT INTO Fabricado (Emps, Dopes, Numes) ;
                            VALUES (TmpFab.Emps, TmpFab.Dopes, TmpFab.Numes)
                    ENDIF
                    REPLACE Qtds WITH loc_QtdTot, QtdCancs WITH loc_lnQtdCanc IN Fabricado
                ENDIF
            ENDSCAN

            IF !loc_lSucesso
                SET ESCAPE &loc_lcEscape.
                SET DECIMALS TO (loc_lnDecimals)
                SET FIXED &loc_lcFixed.
                loc_lSucesso = .F.
            ENDIF

            * Cria cursor principal do relatorio
            CREATE CURSOR csRelatorio (Tipos C(1), Iclis C(10), Rclis C(40), Emps C(3), Dopes C(20), ;
                            Numes N(6), Datas D, DtEnts D, Qtds N(12,2), Qtdfs N(12,2), ;
                            PQtdes N(12,2), Vends C(10), Lts N(10), Ltis N(10), DtEncs D, Nops N(10), ;
                            Qps N(10), Qpes N(10), Pecs N(12,2), Qtdpcs N(12,2), QtdPces N(12,2), ;
                            Mltes N(12,2), Qltis N(10), Pltis N(12,2), Mltis N(12,2), Abrevs C(15), ;
                            Utilizados N(2), cidas C(30), Estas C(2), Cpros C(14), Valors N(12,2), ;
                            Citens N(10), QtdCancs N(12,2), QtReservas N(12,2), QtdMovs N(12,2), ;
                            QtdMovPds N(12,2), QtProds N(12,2), QtdPdProds N(12,2), ValUnits N(12,4), ;
                            PProds N(12,2), PMovPds N(12,2), PMovs N(12,2), ValMovs N(12,2), ;
                            ValMovPds N(12,2), ValProds N(12,2), PValProds N(12,2), ;
                            PValMovPds N(12,2), PValMovs N(12,2))

            * Define expressao de ordenacao (macro substituicao no INDEX ON)
            loc_lnOrdeBy_Expr = IIF(loc_lnOrdem=1, '+Iclis', ;
                                    IIF(loc_lnOrdem=2, '+Dtos(Datas)', ;
                                        IIF(loc_lnOrdem=3, '+Dtos(DtEnts)', ;
                                            IIF(loc_lnOrdem=4, '+Vends+Dtos(Datas)', ;
                                                IIF(loc_lnOrdem=5, '+Vends+Dtos(DtEnts)', '+vends+Iclis')))))
            INDEX ON &loc_lnOrdeBy_Expr. + Emps + Dopes + STR(Numes,6) + Tipos TAG Pedido

            * Loop principal: processa cada pedido de ResPed -> csRelatorio
            loc_lScanOk2 = .T.
            SELECT ResPed
            SCAN WHILE loc_lScanOk2
                SCATTER MEMVAR
                loc_lcEdn = m.Emps + m.Dopes + STR(m.Numes, 6)

                SELECT Fabricado
                SEEK loc_lcEdn
                m.QtdFs    = Fabricado.Qtds + m.QtdNps
                m.QtdCancs = Fabricado.QtdCancs
                m.QtReservas = m.QtdNps

                IF (m.Qtds - m.QtdBs = 0)
                    m.QtdFs = m.Qtds
                    IF EMPTY(m.DataEps)
                        loc_lnResult = SQLEXEC(gnConnHandle, ;
                            "SELECT Datas FROM SigBxEst WHERE EmpDopNumB = " + EscaparSQL(loc_lcEdn), ;
                            "crSigBxEst")
                        IF loc_lnResult >= 1 AND USED("crSigBxEst")
                            SELECT crSigBxEst
                            SCAN
                                LOCAL loc_lDtBx
                                loc_lDtBx = NVL(TTOD(crSigBxEst.Datas), CTOD(""))
                                m.DataEps = IIF(loc_lDtBx > m.DataEps, loc_lDtBx, m.DataEps)
                            ENDSCAN
                        ENDIF
                    ENDIF
                ENDIF

                m.DtEncs = IIF(m.Utilizados = 1 OR m.Qtds - m.QtdNps <= 0 OR ;
                              (m.Qtds - m.QtdBs = 0 AND m.Nops = 0 AND m.Utilizados = 0), ;
                               m.Datas, IIF(EMPTY(m.Dataeps), DATE(), m.Dataeps))
                m.Pqtdes = IIF(m.Qtds <> 0, (m.QtdFs / m.Qtds * 100), 0)
                m.Lts    = m.DtEncs - m.Datas
                m.Ltis   = IIF(!EMPTY(m.DataEps), (m.DataEps - m.DtEnts), (m.DtEncs - m.DtEnts))
                m.Ltis   = IIF(m.Ltis < 0, 0, m.Ltis)
                m.Tipos  = '1'
                m.Valors = 0
                m.Cpros  = ''

                * Cotacao da moeda (1 = sem conversao)
                loc_lnCotaOpera = 1
                IF !EMPTY(loc_lcMoeda)
                    TRY
                        loc_lnCotaOpera = fBuscarCotacao(loc_lcMoeda, ResPed.Datas, gnConnHandle)
                        IF loc_lnCotaOpera <= 0
                            loc_lnCotaOpera = 1
                        ENDIF
                    CATCH
                        loc_lnCotaOpera = 1
                    ENDTRY
                ENDIF

                loc_lnFiltro = IIF(m.Qtds - m.Qtdfs <= 0, 1, 2)

                IF (loc_lnOpcao = loc_lnFiltro) OR (loc_lnOpcao = 3)
                    SELECT csRelatorio
                    APPEND BLANK
                    GATHER MEMVAR

                    IF THIS.this_nAnaSin = 1 OR loc_llTpOpe
                        loc_lcQuery = [Select itn_sub.Emps, itn_sub.Dopes, itn_sub.Numes, itn_sub.EmpdopNums, itn_sub.Citens, itn_sub.Cpros, itn_sub.moedas, ] + ;
                                      [b.chksubn, b.Lccs, a.Nops, itn_sub.CodCors, itn_sub.CodTams, ] + ;
                                      [itn_sub.QtReservas, itn_sub.QtProds, a.Qtds as QtdOps, itn_sub.Totas as Totas, itn_sub.TotItens from ] + ;
                                      [(Select c.Emps, c.Dopes, c.Numes, c.EmpdopNums, c.Citens, c.Cpros, c.moedas, ] + ;
                                      [Case When d.CodCors is not null Then d.CodCors Else space(4) End as CodCors, ] + ;
                                      [Case When d.CodTams is not null Then d.CodTams Else space(4) End as CodTams, ] + ;
                                      [d.QtReservas, c.Qtds as TotItens, c.Totas, ] + ;
                                      [Case When d.Qtds is not null Then d.Qtds Else c.Qtds End as QtProds ] + ;
                                      [From SigMvItn c Left Join SigMvIts d On c.EmpDopNums = d.EmpDopNums And c.Citens = d.Citens ] + ;
                                      [Where c.EmpDopNums = '] + loc_lcEdn + [' ) itn_sub ] + ;
                                      [left Join SigOpPic a On a.EmpDopNums = itn_sub.EmpDopNums And a.Cpros = itn_sub.Cpros And a.Citens = itn_sub.Citens And a.CodCors = itn_sub.CodCors ] + ;
                                      [And a.CodTams = itn_sub.CodTams ] + ;
                                      [Left Join SigCdNec b On a.EmpDopNops = b.EmpDNps ] + ;
                                      [Where itn_sub.EmpDopNums = '] + loc_lcEdn + ['] + ;
                                      [Order by itn_sub.Emps, itn_sub.Dopes, itn_sub.Numes, itn_sub.EmpdopNums, itn_sub.Citens, itn_sub.Cpros, a.Nops]

                        IF SQLEXEC(gnConnHandle, loc_lcQuery, "csQtde") < 1
                            THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (csQtde-ped)"
                            loc_lSucesso = .F.
                            loc_lScanOk2 = .F.
                            EXIT
                        ENDIF

                        SELECT Emps, Dopes, Numes, EmpdopNums, Citens, Cpros, ;
                            NVL(chksubn, .T.) AS chksubn, NVL(Lccs, .F.) AS Lccs, ;
                            NVL(Nops, 0) AS Nops, moedas, ;
                            NVL(QtReservas, 0) AS QtReservas, NVL(QtProds, 0) AS QtProds, ;
                            NVL(QtdOps, 0) AS QtdOps, Totas, TotItens, CodCors, CodTams ;
                            FROM csQtde INTO CURSOR csQtde

                        loc_lnOp    = 0
                        loc_lnTotMov = 0
                        loc_lnCItem  = 0

                        SELECT csQtde
                        SCAN
                            IF !((THIS.this_lItens AND csQtde.chksubn) OR ;
                                 (csQtde.Nops <> 0 AND csQtde.QtdOps = 0))
                                loc_llInseriu = .F.
                                SELECT csRelatorio
                                GO TOP
                                LOCATE FOR Emps = csQtde.Emps AND Dopes = csQtde.Dopes AND ;
                                           Numes = csQtde.Numes AND Cpros = csQtde.Cpros AND ;
                                           Citens = csQtde.Citens AND ;
                                           IIF(loc_llTpOpe OR csQtde.Nops = 0, .T., Nops = csQtde.Nops)

                                IF !EOF()
                                    REPLACE Qtds WITH Qtds + IIF(!EMPTY(csQtde.Nops), ;
                                                csQtde.QtReservas + csQtde.QtdOps, csQtde.Qtprods)
                                    REPLACE QtdPdProds WITH QtdPdProds + csQtde.QtdOps
                                    REPLACE QtReservas WITH QtReservas + csQtde.QtReservas
                                    REPLACE Pqtdes WITH Pqtdes + ;
                                                IIF(csQtde.chksubn, csQtde.QtReservas + csQtde.QtdOps, csQtde.QtReservas)
                                    REPLACE QtProds WITH QtProds + IIF(!csQtde.chksubn, csQtde.QtdOps, 0)
                                    REPLACE QtdCancs WITH QtdCancs + IIF(csQtde.Lccs, csQtde.QtdOps, 0)
                                    REPLACE QtdMovPds WITH QtdMovPds + ;
                                                IIF(csQtde.chksubn AND !csQtde.Lccs, csQtde.QtdOps, 0) + ;
                                                csQtde.QtReservas
                                    IF !loc_llTpOpe
                                        loc_lnVenda = (csQtde.Totas / csQtde.TotItens) * ;
                                                       IIF(m.Qtds = 0, m.QtReservas, m.Qtds)
                                        IF !EMPTY(loc_lcMoeda) AND ;
                                           ALLTRIM(loc_lcMoeda) <> ALLTRIM(csQtde.Moedas)
                                            TRY
                                                loc_lnCotaVenda = fBuscarCotacao(csQtde.Moedas, ;
                                                                     ResPed.Datas, gnConnHandle)
                                                IF loc_lnCotaVenda > 0 AND loc_lnCotaOpera > 0
                                                    loc_lnVenda = loc_lnVenda * loc_lnCotaVenda / ;
                                                                  loc_lnCotaOpera
                                                ENDIF
                                            CATCH
                                            ENDTRY
                                        ENDIF
                                        REPLACE Valors WITH loc_lnVenda
                                    ENDIF
                                ELSE
                                    m.tipos     = '2'
                                    m.Cpros     = csQtde.Cpros
                                    m.Qtds      = IIF(!EMPTY(csQtde.Nops), ;
                                                      csQtde.QtReservas + csQtde.QtdOps, ;
                                                      csQtde.Qtprods)
                                    m.QtdPdProds = csQtde.QtdOps
                                    m.QtReservas = csQtde.QtReservas
                                    m.Pqtdes     = IIF(csQtde.chksubn, ;
                                                       csQtde.QtReservas + csQtde.QtdOps, ;
                                                       csQtde.QtReservas)
                                    m.QtProds    = IIF(!csQtde.chksubn, ABS(csQtde.QtdOps), 0)
                                    m.QtdMovPds  = IIF(csQtde.chksubn AND !csQtde.Lccs, ;
                                                       csQtde.QtdOps, 0) + csQtde.QtReservas
                                    m.Nops       = csQtde.Nops
                                    m.Lts        = 0
                                    m.Ltis       = 0
                                    loc_lnVenda  = IIF(loc_llTpOpe, csQtde.Totas, ;
                                                       (csQtde.Totas / csQtde.TotItens) * ;
                                                       IIF(m.Qtds = 0, m.QtReservas, m.Qtds))
                                    IF !EMPTY(loc_lcMoeda) AND ;
                                       ALLTRIM(loc_lcMoeda) <> ALLTRIM(csQtde.Moedas)
                                        TRY
                                            loc_lnCotaVenda = fBuscarCotacao(csQtde.Moedas, ;
                                                                 ResPed.Datas, gnConnHandle)
                                            IF loc_lnCotaVenda > 0 AND loc_lnCotaOpera > 0
                                                loc_lnVenda = loc_lnVenda * loc_lnCotaVenda / ;
                                                              loc_lnCotaOpera
                                            ENDIF
                                        CATCH
                                        ENDTRY
                                    ENDIF
                                    m.Valors    = loc_lnVenda
                                    m.ValUnits  = IIF(csQtde.TotItens <> 0, ;
                                                      m.Valors / csQtde.TotItens, 0)
                                    m.QtdCancs  = IIF(csQtde.Lccs, csQtde.QtdOps, 0)
                                    m.Citens    = csQtde.Citens
                                    SELECT csRelatorio
                                    APPEND BLANK
                                    GATHER MEMVAR
                                    loc_llInseriu = .T.
                                ENDIF

                                * Movimentacoes por tipo de operacao (quando llTpOpe ativo)
                                IF loc_llTpOpe
                                    IF csQtde.Nops <> 0 AND csQtde.chksubn AND !csQtde.Lccs
                                        IF (loc_lnOp <> csQtde.Nops AND loc_lnCItem <> csQtde.Citens) OR ;
                                           (loc_lnOp <> csQtde.Nops AND loc_lnCItem = csQtde.Citens)
                                            loc_lcSql = [Select a.Cpros, Sum(a.Qtds) as QtMovs from SigOpEtq a Inner Join ] + ;
                                                        [(Select top 1 pd.Emps, pd.Dopps, pd.Numps, pd.EmpDNps, pd.Codpds from SigPdMvf pd ] + ;
                                                        [Inner Join SigOpPic b On pd.Nops = b.Nops where b.Nops = ?csQtde.Nops And b.Empdopnums = ?loc_lcEdn ] + ;
                                                        [And b.Citens = ?csQtde.Citens And b.CodCors = ?csQtde.CodCors And b.CodTams = ?csQtde.CodTams ] + ;
                                                        [order by pd.cidchaves desc) b ] + ;
                                                        [On a.Emps = b.Emps And a.Dopes = b.Dopps And a.Numes = b.Numps ] + ;
                                                        [And a.EmpOs+a.DopeOs+str(a.NumeOs,6) = ?loc_lcEdn And a.Nops = ?csQtde.Nops ] + ;
                                                        [Inner Join SigMvHst c On a.Cbars = c.Codbarras ] + ;
                                                        [Inner Join SigCdOpe d On c.Dopes = d.Dopes And d.TipoOps in ] + ;
                                                        loc_lcTpOpeM + [Group By a.Cpros]
                                            IF SQLEXEC(gnConnHandle, loc_lcSql, "CrTmpMov") >= 1 ;
                                               AND USED("CrTmpMov") AND !EOF("CrTmpMov")
                                                loc_lnOp     = csQtde.Nops
                                                loc_lnCItem  = csQtde.Citens
                                                loc_lnTotMov = CrTmpMov.QtMovs
                                            ELSE
                                                loc_lnTotMov = 0
                                            ENDIF
                                        ENDIF

                                        IF loc_lnTotMov + csQtde.QtReservas <= csQtde.QtProds
                                            REPLACE QtdMovPds WITH QtdMovPds - loc_lnTotMov IN csRelatorio
                                            REPLACE QtdMovs WITH QtdMovs + loc_lnTotMov IN csRelatorio
                                            loc_lnTotMov = 0
                                        ELSE
                                            loc_lnTotMov = loc_lnTotMov - csQtde.QtProds
                                            REPLACE QtdMovPds WITH QtdMovPds - csQtde.QtProds IN csRelatorio
                                            REPLACE QtdMovs WITH QtdMovs + csQtde.QtProds IN csRelatorio
                                        ENDIF
                                    ENDIF

                                    IF loc_llInseriu AND csQtde.QtReservas > 0
                                        IF USED("crSigCdPam") AND !EOF("crSigCdPam")
                                            loc_lcQuery = [Select b.nDopes, a.Numes From SigMvCab a ] + ;
                                                          [Inner Join SigCdOpe b On a.Dopes = b.Dopes ] + ;
                                                          [Where a.Dopes = '] + crSigCdPam.TransfRes + ;
                                                          [' And a.Nops = ?ResPed.Nops And ] + ;
                                                          [(a.ContaOs = ?ResPed.Iclis Or a.ContaDs = ?ResPed.Iclis)]
                                            IF SQLEXEC(gnConnHandle, loc_lcQuery, "CrxOpe") >= 1 ;
                                               AND USED("CrxOpe") AND !EOF("CrxOpe")
                                                loc_lnCodigo = (CrxOpe.nDopes * 1000000) + CrxOpe.Numes

                                                IF !EMPTY(loc_lcTpOpeE)
                                                    loc_lcQuery = [Select sub.Cpros, count(ope2.Dopes) as QtMovs from ] + ;
                                                                  [(Select d.cpros, d.codbarras, d.Qtds ] + ;
                                                                  [From SigMvPec pec, SigMvCab b, SigCdOpe c, SigMvItn d ] + ;
                                                                  [Where pec.Codigos = ] + STR(loc_lnCodigo) + [ And ] + ;
                                                                  [pec.EmpDopnums = b.EmpDopNums And ] + ;
                                                                  [pec.EmpSubns = '] + go_4c_Sistema.cCodEmpresa + [' And ] + ;
                                                                  [b.Dopes = c.Dopes And c.TipoOps in ] + loc_lcTpOpeE + [ And ] + ;
                                                                  [b.EmpDopNums = d.EmpDopNums And d.Cpros = ?csQtde.Cpros ] + ;
                                                                  [Union All ] + ;
                                                                  [Select d.cpros, d.codbarras, d.Qtds ] + ;
                                                                  [From SigOpDev dev, SigMvCab b, SigCdOpe c, SigMvItn d ] + ;
                                                                  [Where dev.Codigos = ] + STR(loc_lnCodigo) + [ And ] + ;
                                                                  [dev.EmpDopnums = b.EmpDopNums And ] + ;
                                                                  [b.Dopes = c.Dopes And c.TipoOps in ] + loc_lcTpOpeE + [ And ] + ;
                                                                  [b.EmpDopNums = d.EmpDopNums And d.Cpros = ?csQtde.Cpros) sub ] + ;
                                                                  [Inner Join SigMvHst b On sub.codbarras = b.Codbarras ] + ;
                                                                  [Left Join SigCdOpe ope2 On b.Dopes = ope2.Dopes And ope2.TipoOps in ] + ;
                                                                  loc_lcTpOpeM + [ Group By sub.Cpros ]
                                                    IF SQLEXEC(gnConnHandle, loc_lcQuery, "TmpEmpenho") >= 1
                                                        SELECT NVL(QtMovs, 0) AS QtMovs FROM TmpEmpenho ;
                                                            INTO CURSOR TmpEmpenho
                                                        REPLACE QtdMovPds WITH QtdMovPds - TmpEmpenho.QtMovs ;
                                                            IN csRelatorio
                                                        REPLACE QtdMovs WITH QtdMovs + TmpEmpenho.QtMovs ;
                                                            IN csRelatorio
                                                    ENDIF
                                                ENDIF

                                                IF !EMPTY(loc_lcTpOpeC)
                                                    loc_lcQuery = [Select sub.Cpros, Sum(sub.Qtds) as QtMovs from ] + ;
                                                                  [(Select d.cpros, d.codbarras, d.Qtds ] + ;
                                                                  [From SigMvPec pec, SigMvCab b, SigCdOpe c, SigMvItn d ] + ;
                                                                  [Where pec.Codigos = ] + STR(loc_lnCodigo) + [ And ] + ;
                                                                  [pec.EmpDopnums = b.EmpDopNums And ] + ;
                                                                  [pec.EmpSubns = '] + go_4c_Sistema.cCodEmpresa + [' And ] + ;
                                                                  [b.Dopes = c.Dopes And c.TipoOps in ] + loc_lcTpOpeC + [ And ] + ;
                                                                  [b.EmpDopNums = d.EmpDopNums And d.Cpros = ?csQtde.Cpros ] + ;
                                                                  [Union All ] + ;
                                                                  [Select d.cpros, d.codbarras, d.Qtds ] + ;
                                                                  [From SigOpDev dev, SigMvCab b, SigCdOpe c, SigMvItn d ] + ;
                                                                  [Where dev.Codigos = ] + STR(loc_lnCodigo) + [ And ] + ;
                                                                  [dev.EmpDopnums = b.EmpDopNums And ] + ;
                                                                  [b.Dopes = c.Dopes And c.TipoOps in ] + loc_lcTpOpeC + [ And ] + ;
                                                                  [b.EmpDopNums = d.EmpDopNums And d.Cpros = ?csQtde.Cpros) sub ] + ;
                                                                  [Group By sub.Cpros ]
                                                    IF SQLEXEC(gnConnHandle, loc_lcQuery, "TmpEmpenho") >= 1
                                                        SELECT NVL(QtMovs, 0) AS QtMovs FROM TmpEmpenho ;
                                                            INTO CURSOR TmpEmpenho
                                                        REPLACE QtdMovPds WITH QtdMovPds - TmpEmpenho.QtMovs ;
                                                            IN csRelatorio
                                                        REPLACE QtdCancs WITH QtdCancs + TmpEmpenho.QtMovs ;
                                                            IN csRelatorio
                                                    ENDIF
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF

                                * Totaliza cabecalho do pedido (linha Tipos='1') com acumulados de itens (Tipos='2')
                                SELECT csRelatorio
                                loc_lnReg = RECNO()
                                SELECT SUM(Qtds) AS Qtds, SUM(QtReservas) AS QtReservas, ;
                                    SUM(QtdCancs) AS QtdCancs, SUM(QtProds) AS QtProds, ;
                                    SUM(QtdMovPds) AS QtdMovPds, SUM(QtdMovs) AS QtdMovs, ;
                                    SUM(QtdPdProds) AS QtdPdProds, SUM(Valors) AS Valors, ;
                                    SUM(NVL(QtProds * ValUnits, 0)) AS TotProds, ;
                                    SUM(NVL(QtdMovPds * ValUnits, 0)) AS TotMovPds, ;
                                    SUM(NVL(QtdMovs * ValUnits, 0)) AS TotMovs ;
                                    FROM csRelatorio ;
                                    WHERE Emps + Dopes + STR(Numes,6) = loc_lcEdn AND Tipos = '2' ;
                                    INTO CURSOR TmpTotal

                                SELECT csRelatorio
                                GO TOP
                                LOCATE FOR Emps + Dopes + STR(Numes,6) = loc_lcEdn AND Tipos = '1'
                                IF !EOF()
                                    LOCAL loc_lnQtds
                                    loc_lnQtds = NVL(TmpTotal.Qtds, 0)
                                    LOCAL loc_lnVs
                                    loc_lnVs = NVL(TmpTotal.Valors, 0)
                                    REPLACE Qtds WITH loc_lnQtds, ;
                                        QtReservas WITH NVL(TmpTotal.QtReservas, 0), ;
                                        QtdCancs WITH NVL(TmpTotal.QtdCancs, 0), ;
                                        QtProds WITH NVL(TmpTotal.QtProds, 0), ;
                                        QtdMovPds WITH NVL(TmpTotal.QtdMovPds, 0), ;
                                        QtdMovs WITH NVL(TmpTotal.QtdMovs, 0), ;
                                        QtdPdProds WITH NVL(TmpTotal.QtdPdProds, 0), ;
                                        Valors WITH loc_lnVs, ;
                                        PProds WITH IIF(loc_lnQtds<>0, ;
                                            (NVL(TmpTotal.QtProds,0)/loc_lnQtds)*100, 0), ;
                                        PMovPds WITH IIF(loc_lnQtds<>0, ;
                                            (NVL(TmpTotal.QtdMovPds,0)/loc_lnQtds)*100, 0), ;
                                        PMovs WITH IIF(loc_lnQtds<>0, ;
                                            (NVL(TmpTotal.QtdMovs,0)/loc_lnQtds)*100, 0)
                                    REPLACE PValProds WITH IIF(loc_lnVs<>0, ;
                                                (NVL(TmpTotal.TotProds,0)/loc_lnVs)*100, 0), ;
                                        PValMovPds WITH IIF(loc_lnVs<>0, ;
                                                (NVL(TmpTotal.TotMovPds,0)/loc_lnVs)*100, 0), ;
                                        PValMovs WITH IIF(loc_lnVs<>0, ;
                                                (NVL(TmpTotal.TotMovs,0)/loc_lnVs)*100, 0), ;
                                        ValProds WITH NVL(TmpTotal.TotProds, 0), ;
                                        ValMovPds WITH NVL(TmpTotal.TotMovPds, 0), ;
                                        ValMovs WITH NVL(TmpTotal.TotMovs, 0)
                                ENDIF
                                GO (loc_lnReg)
                            ENDIF
                        ENDSCAN
                    ENDIF
                ENDIF
            ENDSCAN

            IF !loc_lSucesso
                SET ESCAPE &loc_lcEscape.
                SET DECIMALS TO (loc_lnDecimals)
                SET FIXED &loc_lcFixed.
                loc_lSucesso = .F.
            ENDIF

            * Linha de totais gerais
            SELECT csRelatorio
            IF !EOF()
                SELECT '5' AS Tipos, SUM(1) AS Qps, ;
                        SUM(IIF(Qtds - Qtdfs <= 0, 1, 0)) AS Qpes, ;
                        SUM(Qtds) AS QtdPcs, SUM(QtdFs) AS QtdPces, ;
                        SUM(IIF(Qtds - Qtdfs <= 0 AND Utilizados = 0, Lts, 0)) AS Lts, ;
                        SUM(IIF(Ltis > 0, 1, 0)) AS Qltis, SUM(Ltis) AS Ltis, ;
                        SUM(IIF(Qtds - Qtdfs <= 0 AND Utilizados = 0, 1, 0)) AS Qmpes, ;
                        SUM(QtdCancs) AS QtdCancs ;
                   FROM csRelatorio WHERE tipos <> '2' ;
                   INTO CURSOR csTotal GROUP BY 1

                SELECT csRelatorio
                GO TOP
                SUM Valors FOR tipos = '2' TO loc_lnValors

                SELECT csRelatorio
                GO BOTTOM
                SCATTER MEMVAR
                m.cpros      = ''
                m.Valors     = loc_lnValors
                m.Qtds       = 0
                m.Pqtdes     = 0
                m.Nops       = 0
                m.Ltis       = 0
                m.QtProds    = 0
                m.QtReservas = 0
                m.QtdCancs   = 0
                m.QtdMovs    = 0
                m.QtdMovPds  = 0

                SELECT csTotal
                SCATTER MEMVAR
                m.Pecs  = IIF(m.Qps  = 0, 0, (m.Qpes / m.Qps * 100))
                m.Ltes  = IIF(m.Qps  = 0, 0, (m.Lts  / m.Qps * 100))
                m.Pltis = IIF(m.Qpes = 0, 0, (m.Qltis / m.Qpes * 100))
                m.MlTes = IIF(m.Qmpes = 0, 0, (m.Lts / m.Qmpes))
                m.Mltis = IIF(m.Qltis = 0, 0, (m.Ltis / m.Qltis))

                IF THIS.this_nAnaSin = 1 OR loc_llTpOpe
                    SELECT SUM(NVL(Valors, 0)) AS TotUnits, ;
                        SUM(NVL(QtProds * ValUnits, 0)) AS ValProds, ;
                        SUM(NVL(QtdMovPds * ValUnits, 0)) AS ValMovPds, ;
                        SUM(NVL(QtdMovs * ValUnits, 0)) AS ValMovs, ;
                        SUM(Qtds) AS Qtds, SUM(QtProds) AS QtProds, ;
                        SUM(QtdMovPds) AS QtdMovPds, SUM(QtdMovs) AS QtdMovs ;
                        FROM csRelatorio WHERE tipos = '2' INTO CURSOR csTotal2

                    m.ValProds   = csTotal2.ValProds
                    m.ValMovPds  = csTotal2.ValMovPds
                    m.ValMovs    = csTotal2.ValMovs
                    m.PValProds  = IIF(csTotal2.TotUnits<>0, ;
                                       (csTotal2.ValProds / csTotal2.TotUnits) * 100, 0)
                    m.PValMovPds = IIF(csTotal2.TotUnits<>0, ;
                                       (csTotal2.ValMovPds / csTotal2.TotUnits) * 100, 0)
                    m.PValMovs   = IIF(csTotal2.TotUnits<>0, ;
                                       (csTotal2.ValMovs / csTotal2.TotUnits) * 100, 0)
                    m.QtProds    = csTotal2.QtProds
                    m.QtdMovPds  = csTotal2.QtdMovPds
                    m.QtdMovs    = csTotal2.QtdMovs
                    m.PProds     = IIF(csTotal2.Qtds<>0, ;
                                       (csTotal2.QtProds / csTotal2.Qtds) * 100, 0)
                    m.PMovPds    = IIF(csTotal2.Qtds<>0, ;
                                       (csTotal2.QtdMovPds / csTotal2.Qtds) * 100, 0)
                    m.PMovs      = IIF(csTotal2.Qtds<>0, ;
                                       (csTotal2.QtdMovs / csTotal2.Qtds) * 100, 0)
                ENDIF

                SELECT csRelatorio
                APPEND BLANK
                GATHER MEMVAR

                IF THIS.this_nAnaSin = 2 AND loc_llTpOpe
                    DELETE FROM csRelatorio WHERE Tipos = '2'
                ENDIF
            ENDIF

            SET ESCAPE &loc_lcEscape.
            SET DECIMALS TO (loc_lnDecimals)
            SET FIXED &loc_lcFixed.

            SELECT csRelatorio
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao processar relat" + CHR(243) + "rio")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime o relatorio na impressora
    *--------------------------------------------------------------------------
    *-- ============================================================
    *-- PROCEDURE ExecutarReportForm (Pattern #117 / #123)
    *-- Executa REPORT FORM apenas se o FRX existir; caso contrario,
    *-- exibe MostrarErro descritivo com o path faltante.
    *-- Isola SET POINT/SEPARATOR/REPORTBEHAVIOR durante o REPORT FORM
    *-- porque FRXs legados Fortyus (VFP6/7/8) foram desenhados com
    *-- POINT="." + REPORTBEHAVIOR 80. Sem isolamento o modo 90 remede
    *-- fontes em runtime e mostra asteriscos em campos numericos.
    *-- par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
    *-- par_cCursorDados: opcional. Se informado e cursor estiver vazio,
    *--   mostra MsgAviso e retorna .F. sem abrir preview vazio.
    *-- ============================================================
    PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
        LOCAL loc_cFRX
        loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")

        IF NOT FILE(loc_cFRX)
            MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
                loc_cFRX + CHR(13) + CHR(13) + ;
                "O FRX legado ainda n" + CHR(227) + "o foi portado para o novo sistema.", "Erro")
            RETURN .F.
        ENDIF

        *-- Guard cursor vazio: evita preview em branco / impressao vazia (Erro30)
        IF VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)
            IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
                MsgAviso("Nenhum registro encontrado com os filtros informados.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF
        ENDIF

        *-- Isolamento de locale + modo de renderizacao (Erro28)
        LOCAL loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig
        loc_cPointOrig    = SET("POINT")
        loc_cSepOrig      = SET("SEPARATOR")
        loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
        SET POINT TO "."
        SET SEPARATOR TO ","
        SET REPORTBEHAVIOR 80

        DO CASE
            CASE par_cModo == "PREVIEW"
                REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
            CASE par_cModo == "PRINTER_PROMPT"
                REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
            CASE par_cModo == "PRINTER"
                REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
        ENDCASE

        SET POINT TO (loc_cPointOrig)
        SET SEPARATOR TO (loc_cSepOrig)
        SET REPORTBEHAVIOR (loc_nBehaviorOrig)

        RETURN .T.
    ENDPROC

    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF THIS.this_lTpOpe
                    THIS.ExecutarReportForm("SigReEs2", "PRINTER", THIS.this_cCursorDados)
                ELSE
                    THIS.ExecutarReportForm("SigReEsp", "PRINTER", THIS.this_cCursorDados)
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirComPrompt - Prepara dados e imprime com dialogo de selecao de impressora
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirComPrompt()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF THIS.this_lTpOpe
                    THIS.ExecutarReportForm("SigReEs2", "PRINTER_PROMPT", THIS.this_cCursorDados)
                ELSE
                    THIS.ExecutarReportForm("SigReEsp", "PRINTER_PROMPT", THIS.this_cCursorDados)
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF THIS.this_lTpOpe
                    THIS.ExecutarReportForm("SigReEs2", "PREVIEW", THIS.this_cCursorDados)
                ELSE
                    THIS.ExecutarReportForm("SigReEsp", "PREVIEW", THIS.this_cCursorDados)
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros do BO a partir de um cursor de presets
    * Permite que o Form restaure os ultimos filtros usados (csUserCfg)
    * Mapeia TODAS as propriedades this_* a partir das colunas do cursor.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor de presets n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)

            *-- Periodo (datas + tipo de periodo)
            IF TYPE(par_cAliasCursor + ".DtInicial") != "U"
                THIS.this_dDtInicial = NVL(EVALUATE(par_cAliasCursor + ".DtInicial"), DATE())
            ENDIF
            IF TYPE(par_cAliasCursor + ".DtFinal") != "U"
                THIS.this_dDtFinal = NVL(EVALUATE(par_cAliasCursor + ".DtFinal"), DATE())
            ENDIF
            IF TYPE(par_cAliasCursor + ".Periodo") != "U"
                THIS.this_nPeriodo = NVL(EVALUATE(par_cAliasCursor + ".Periodo"), 1)
            ENDIF

            *-- Operacao / movimentacao
            IF TYPE(par_cAliasCursor + ".NmOperacao") != "U"
                THIS.this_cNmOperacao = ALLTRIM(NVL(EVALUATE(par_cAliasCursor + ".NmOperacao"), ""))
            ENDIF
            IF TYPE(par_cAliasCursor + ".Numero") != "U"
                THIS.this_nNumero = NVL(EVALUATE(par_cAliasCursor + ".Numero"), 0)
            ENDIF

            *-- Tipo de operacao (SigCdTom)
            IF TYPE(par_cAliasCursor + ".CdTpOpe") != "U"
                THIS.this_nCdTpOpe = NVL(EVALUATE(par_cAliasCursor + ".CdTpOpe"), 0)
            ENDIF
            IF TYPE(par_cAliasCursor + ".DsTpOpe") != "U"
                THIS.this_cDsTpOpe = ALLTRIM(NVL(EVALUATE(par_cAliasCursor + ".DsTpOpe"), ""))
            ENDIF

            *-- Conta (ContaDs/ContaOs)
            IF TYPE(par_cAliasCursor + ".CdConta") != "U"
                THIS.this_cCdConta = ALLTRIM(NVL(EVALUATE(par_cAliasCursor + ".CdConta"), ""))
            ENDIF
            IF TYPE(par_cAliasCursor + ".DsConta") != "U"
                THIS.this_cDsConta = ALLTRIM(NVL(EVALUATE(par_cAliasCursor + ".DsConta"), ""))
            ENDIF

            *-- Vendedor (Vends)
            IF TYPE(par_cAliasCursor + ".CdVendedor") != "U"
                THIS.this_cCdVendedor = ALLTRIM(NVL(EVALUATE(par_cAliasCursor + ".CdVendedor"), ""))
            ENDIF
            IF TYPE(par_cAliasCursor + ".DsVendedor") != "U"
                THIS.this_cDsVendedor = ALLTRIM(NVL(EVALUATE(par_cAliasCursor + ".DsVendedor"), ""))
            ENDIF

            *-- Cidade / Estado
            IF TYPE(par_cAliasCursor + ".Cidade") != "U"
                THIS.this_cCidade = ALLTRIM(NVL(EVALUATE(par_cAliasCursor + ".Cidade"), ""))
            ENDIF
            IF TYPE(par_cAliasCursor + ".Estado") != "U"
                THIS.this_cEstado = ALLTRIM(NVL(EVALUATE(par_cAliasCursor + ".Estado"), ""))
            ENDIF

            *-- Opcoes / situacao
            IF TYPE(par_cAliasCursor + ".Filtro") != "U"
                THIS.this_nFiltro = NVL(EVALUATE(par_cAliasCursor + ".Filtro"), 3)
            ENDIF
            IF TYPE(par_cAliasCursor + ".OpcImp") != "U"
                THIS.this_nOpcImp = NVL(EVALUATE(par_cAliasCursor + ".OpcImp"), 1)
            ENDIF
            IF TYPE(par_cAliasCursor + ".Ordem") != "U"
                THIS.this_nOrdem = NVL(EVALUATE(par_cAliasCursor + ".Ordem"), 1)
            ENDIF
            IF TYPE(par_cAliasCursor + ".AnaSin") != "U"
                THIS.this_nAnaSin = NVL(EVALUATE(par_cAliasCursor + ".AnaSin"), 2)
            ENDIF

            *-- Checkboxes (BIT do SQL Server -> LOGICAL)
            IF TYPE(par_cAliasCursor + ".TpOpe") != "U"
                THIS.this_lTpOpe = NVL(EVALUATE(par_cAliasCursor + ".TpOpe"), .F.)
            ENDIF
            IF TYPE(par_cAliasCursor + ".Itens") != "U"
                THIS.this_lItens = NVL(EVALUATE(par_cAliasCursor + ".Itens"), .F.)
            ENDIF
            IF TYPE(par_cAliasCursor + ".Indus") != "U"
                THIS.this_lIndus = NVL(EVALUATE(par_cAliasCursor + ".Indus"), .F.)
            ENDIF
            IF TYPE(par_cAliasCursor + ".SemVals") != "U"
                THIS.this_lSemVals = NVL(EVALUATE(par_cAliasCursor + ".SemVals"), .F.)
            ENDIF

            *-- Moeda (SigCdMoe)
            IF TYPE(par_cAliasCursor + ".CdMoeda") != "U"
                THIS.this_cCdMoeda = ALLTRIM(NVL(EVALUATE(par_cAliasCursor + ".CdMoeda"), ""))
            ENDIF
            IF TYPE(par_cAliasCursor + ".DsMoeda") != "U"
                THIS.this_cDsMoeda = ALLTRIM(NVL(EVALUATE(par_cAliasCursor + ".DsMoeda"), ""))
            ENDIF

            *-- Listas de tipos de operacao do grid (formato "(cod1,cod2,...)")
            IF TYPE(par_cAliasCursor + ".TpOpeM") != "U"
                THIS.this_cTpOpeM = NVL(EVALUATE(par_cAliasCursor + ".TpOpeM"), "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".TpOpeE") != "U"
                THIS.this_cTpOpeE = NVL(EVALUATE(par_cAliasCursor + ".TpOpeE"), "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".TpOpeC") != "U"
                THIS.this_cTpOpeC = NVL(EVALUATE(par_cAliasCursor + ".TpOpeC"), "")
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar cursor de presets: " + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Operacao CRUD nao aplicavel a BO de relatorio
    * RelatorioBase nao tem tabela transacional (this_cTabela = "")
    * Para gerar/imprimir o relatorio use Imprimir(), ImprimirComPrompt() ou Visualizar()
    * Mantido por compatibilidade com a interface generica do pipeline
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "BO de relat" + CHR(243) + "rio n" + CHR(227) + ;
            "o suporta opera" + CHR(231) + CHR(245) + "es CRUD. " + ;
            "Use Imprimir(), ImprimirComPrompt() ou Visualizar()."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Operacao CRUD nao aplicavel a BO de relatorio
    * RelatorioBase nao tem tabela transacional (this_cTabela = "")
    * Para gerar/imprimir o relatorio use Imprimir(), ImprimirComPrompt() ou Visualizar()
    * Mantido por compatibilidade com a interface generica do pipeline
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "BO de relat" + CHR(243) + "rio n" + CHR(227) + ;
            "o suporta opera" + CHR(231) + CHR(245) + "es CRUD. " + ;
            "Use Imprimir(), ImprimirComPrompt() ou Visualizar()."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio na LogAuditoria
    * Loga parametros usados (periodo, filtros principais) para rastreabilidade
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cDescricao, loc_cUsuario, loc_cOperacao
        loc_lSucesso = .F.

        TRY
            loc_cOperacao = IIF(EMPTY(par_cOperacao), "REPORT", ALLTRIM(par_cOperacao))
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                               ALLTRIM(gc_4c_UsuarioLogado), "SYSTEM")

            *-- Monta descricao com filtros usados na execucao
            loc_cDescricao = "Relat" + CHR(243) + "rio: SigReEsp"
            IF !EMPTY(THIS.this_cNmOperacao)
                loc_cDescricao = loc_cDescricao + " | Opera" + CHR(231) + CHR(227) + "o=" + ;
                                 ALLTRIM(THIS.this_cNmOperacao)
            ENDIF
            IF THIS.this_nNumero > 0
                loc_cDescricao = loc_cDescricao + " | PV=" + TRANSFORM(THIS.this_nNumero)
            ENDIF
            IF !EMPTY(THIS.this_dDtInicial) AND !EMPTY(THIS.this_dDtFinal)
                loc_cDescricao = loc_cDescricao + " | Per" + CHR(237) + "odo=" + ;
                                 DTOC(THIS.this_dDtInicial) + " a " + DTOC(THIS.this_dDtFinal)
            ENDIF
            IF !EMPTY(THIS.this_cCdVendedor)
                loc_cDescricao = loc_cDescricao + " | Vend=" + ALLTRIM(THIS.this_cCdVendedor)
            ENDIF
            IF !EMPTY(THIS.this_cCdConta)
                loc_cDescricao = loc_cDescricao + " | Conta=" + ALLTRIM(THIS.this_cCdConta)
            ENDIF
            IF !EMPTY(THIS.this_cCdMoeda)
                loc_cDescricao = loc_cDescricao + " | Moeda=" + ALLTRIM(THIS.this_cCdMoeda)
            ENDIF

            *-- Trunca para o tamanho da coluna Descricao (VARCHAR(500))
            IF LEN(loc_cDescricao) > 500
                loc_cDescricao = LEFT(loc_cDescricao, 500)
            ENDIF

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Usuario, DataHora, Tabela, Operacao, ChaveRegistro, DadosNovos) " + ;
                       "VALUES (" + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL("SigReEsp") + ", " + ;
                       EscaparSQL(loc_cOperacao) + ", " + ;
                       EscaparSQL("") + ", " + ;
                       EscaparSQL(loc_cDescricao) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                loc_lSucesso = .T.
            ENDIF
        CATCH
            *-- Falha de auditoria NAO bloqueia execucao do relatorio
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha cursores criados pelo BO durante PrepararDados
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_aCursores, loc_nI, loc_cCursor
        DIMENSION loc_aCursores(14)
        loc_aCursores(1)  = "csRelatorio"
        loc_aCursores(2)  = "CsCabecalho"
        loc_aCursores(3)  = "ResPed"
        loc_aCursores(4)  = "ResPed1"
        loc_aCursores(5)  = "TotPed"
        loc_aCursores(6)  = "Fabricado"
        loc_aCursores(7)  = "TmpFab"
        loc_aCursores(8)  = "crSigCdOpe"
        loc_aCursores(9)  = "crSigCdEmp"
        loc_aCursores(10) = "crSigCdPam"
        loc_aCursores(11) = "csQtde"
        loc_aCursores(12) = "CrxOpe"
        loc_aCursores(13) = "CrTmpMov"
        loc_aCursores(14) = "crSigBxEst"
        FOR loc_nI = 1 TO ALEN(loc_aCursores)
            loc_cCursor = loc_aCursores[loc_nI]
            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF
        ENDFOR
        DODEFAULT()
    ENDPROC

ENDDEFINE
