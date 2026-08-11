*==============================================================================
* SIGRECOMBO.PRG
* Business Object para Relatorio de Comissao
* Herda de: RelatorioBase
*
* Filtros:
*   - Periodo (data inicial / data final)
*   - Moeda (codigo + descricao)
*   - Vendedor
*   - Tipo (Analitico / Sintetico / Resumo / Analise Medias)
*   - Opcao  (Sim / Nao / Ambos - titulos dinamicos de SigCdPac)
*   - Quebra (Datas / Datas + Operacoes)
*   - Valor Base (Itens / Movimentacao / Movimentacao S/ST)
*   - Ordem  (so visivel/usavel quando tipo=4)
*==============================================================================

DEFINE CLASS sigrecomBO AS RelatorioBase

    *-- Propriedades base (RelatorioBase)
    this_cTabela     = "SigMvCab"
    this_cCampoChave = ""

    *--------------------------------------------------------------------------
    * FILTROS DO RELATORIO
    *--------------------------------------------------------------------------

    *-- Periodo
    this_dDtInicial  = {}
    this_dDtFinal    = {}

    *-- Moeda (codigo CHAR(3) + descricao CHAR(15))
    this_cCdMoeda    = ""
    this_cDsMoeda    = ""

    *-- Vendedor (CHAR(10), habilitado conforme fChecaAcesso)
    this_cVendedor   = ""

    *-- Tipo: 1=Analitico 2=Sintetico 3=Resumo 4=Analise Medias
    this_nTipo       = 1

    *-- Opcao: 1=Sim 2=Nao 3=Ambos (titulos dinamicos de SigCdPac)
    this_nNrOpcao    = 3

    *-- Quebra: 1=Datas 2=Datas+Operacoes
    this_nQuebra     = 1

    *-- Valor Base: 1=Itens 2=Movimentacao 3=Movimentacao S/ST
    this_nBase       = 1

    *-- Ordem (so usado quando tipo=4):
    *   1=Vendedor 2=Qtde Pecas 3=Media Pecas
    *   4=Qtde Opers 5=Media Opers 6=Comissao
    this_nOrdem      = 1

    *--------------------------------------------------------------------------
    * CAPTIONS DINAMICOS DAS OPCOES (carregados de SigCdPac em InicializarForm)
    *--------------------------------------------------------------------------
    this_cTitOpcS    = ""
    this_cTitOpcN    = ""
    this_cTitOpcA    = ""

    *--------------------------------------------------------------------------
    * CONTROLE DE ACESSO
    *--------------------------------------------------------------------------
    *-- .T. se o usuario tem permissao para filtrar por vendedor (fChecaAcesso)
    this_lVendedorEnabled = .T.

    *--------------------------------------------------------------------------
    * DADOS DO CABECALHO DO RELATORIO (preenchidos em PrepararDados)
    *--------------------------------------------------------------------------
    this_cNmEmpresa  = ""
    this_cTitulo     = ""

    *--------------------------------------------------------------------------
    * CONTROLE DE VISIBILIDADE
    *--------------------------------------------------------------------------
    *-- say7 e optOrdem ficam ocultos exceto quando this_nTipo = 4
    this_lExibeOrdem   = .F.

    *-- Taxa mensal JM (armazenada para acesso dos helpers de calculo)
    this_lnTaxaMensal  = 0

    *==========================================================================
    * Init - Construtor
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            THIS.this_cTabela     = "SigMvCab"
            THIS.this_cCampoChave = ""

            THIS.this_dDtInicial  = DATE()
            THIS.this_dDtFinal    = DATE()
            THIS.this_cCdMoeda    = "R  "
            THIS.this_cDsMoeda    = ""
            THIS.this_cVendedor   = ""
            THIS.this_nTipo       = 1
            THIS.this_nNrOpcao    = 3
            THIS.this_nQuebra     = 1
            THIS.this_nBase       = 1
            THIS.this_nOrdem      = 1

            *-- Captions padrao (serao sobrescritos com dados de SigCdPac no Form)
            THIS.this_cTitOpcS    = "Sim"
            THIS.this_cTitOpcN    = "N" + CHR(227) + "o"
            THIS.this_cTitOpcA    = "Ambos"

            THIS.this_lVendedorEnabled = .T.
            THIS.this_lExibeOrdem      = .F.
            THIS.this_lnTaxaMensal     = 0

            THIS.this_cNmEmpresa  = ""
            THIS.this_cTitulo     = ""

            loc_lSucesso = DODEFAULT()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * PrepararDados - Processa dados para impressao/visualizacao do relatorio
    * Equivale ao metodo 'processamento' do form legado SIGRECOM
    *==========================================================================
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErr
        LOCAL loc_ldDtI, loc_ldDtF, loc_lcCdMoeda, loc_lcDsMoeda
        LOCAL loc_lnNrOpcao, loc_lnTip, loc_lnBas
        LOCAL loc_lcNmEmpresa, loc_lcNmTitulo
        LOCAL loc_lcJm, loc_lnTm, loc_nResult, loc_cSQL, loc_lcEdn, loc_lnOrdem

        loc_lSucesso = .F.

        *-- Captura filtros das propriedades
        loc_ldDtI     = THIS.this_dDtInicial
        loc_ldDtF     = THIS.this_dDtFinal
        loc_lcCdMoeda = THIS.this_cCdMoeda
        loc_lcDsMoeda = ALLTRIM(THIS.this_cDsMoeda)
        loc_lnNrOpcao = THIS.this_nNrOpcao
        loc_lnTip     = THIS.this_nTipo
        loc_lnBas     = THIS.this_nBase

        *-- Validacoes (fora do TRY - RETURN .F. permitido aqui)
        IF EMPTY(loc_ldDtI) OR EMPTY(loc_ldDtF)
            THIS.this_cMensagemErro = "Informe o per" + CHR(237) + "odo."
            RETURN .F.
        ENDIF
        IF loc_ldDtI > loc_ldDtF
            THIS.this_cMensagemErro = "Data inicial maior que data final."
            RETURN .F.
        ENDIF
        IF !THIS.CarregarCursoresBase()
            RETURN .F.
        ENDIF

        TRY
            *-- Nome da empresa
            loc_lcNmEmpresa = ""
            SELECT crSigCdEmp
            GO TOP
            IF !EOF()
                loc_lcNmEmpresa = ALLTRIM(crSigCdEmp.razas)
            ENDIF

            *-- Titulo do relatorio
            loc_lcNmTitulo = "Comiss" + CHR(227) + "o em " + ;
                             PROPER(loc_lcDsMoeda) + ;
                             " de " + DTOC(loc_ldDtI) + ;
                             " " + CHR(224) + " " + DTOC(loc_ldDtF) + " - " + ;
                             IIF(loc_lnTip = 1, "Anal" + CHR(237) + "tico", ;
                                 IIF(loc_lnTip = 2, "Sint" + CHR(233) + "tico", ;
                                     IIF(loc_lnTip = 3, "Resumido", ;
                                         "An" + CHR(225) + "lise de M" + CHR(233) + "dias"))) + ;
                             " - " + ;
                             IIF(loc_lnBas = 1, "Base Itens", ;
                                 "Base Movimenta" + CHR(231) + CHR(227) + "o")

            *-- Cursor dbcabecalho (referenciado pelos FRX)
            IF USED("dbcabecalho")
                USE IN dbcabecalho
            ENDIF
            CREATE CURSOR dbcabecalho (NomeEmpresa c(80), Titulo c(80))
            INSERT INTO dbcabecalho (NomeEmpresa, Titulo) VALUES (loc_lcNmEmpresa, loc_lcNmTitulo)
            THIS.this_cNmEmpresa = loc_lcNmEmpresa
            THIS.this_cTitulo    = loc_lcNmTitulo

            *-- Taxa mensal JM para calculo de valor a vista
            loc_lcJm = "JM "
            loc_lnTm = THIS.BuscarCambio({}, loc_ldDtF, SPACE(3), loc_lcJm)
            THIS.this_lnTaxaMensal = loc_lnTm

            *-- Cursor Parcela (schema de SigMvPar + colunas de acumulacao)
            IF USED("Parcela")
                USE IN Parcela
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 0 a.cotfpgs, a.Empdopnums, a.dopes, " + ;
                "a.fpags, a.moefpgs, a.valos, a.datas, a.vencs, " + ;
                "CAST(a.valos AS DECIMAL(14,4)) AS ValoAvs, " + ;
                "CAST(a.valos AS DECIMAL(14,4)) AS Devols, " + ;
                "CAST('' AS VARCHAR(6)) AS Tipo " + ;
                "FROM SigMvPar a WHERE 1=0", "Parcela")
            IF loc_nResult < 1
                CREATE CURSOR Parcela ;
                    (cotfpgs n(14,4), Empdopnums c(29), dopes c(20), ;
                     fpags c(6), moefpgs c(3), valos n(14,4), ;
                     datas d, vencs d, ValoAvs n(14,4), Devols n(14,4), Tipo c(6))
            ENDIF
            SELECT Parcela
            INDEX ON Tipo + fpags TAG Tipo
            INDEX ON fpags TAG fpags

            *-- Cursor crAnalitico (acumulador de comissoes por vendedor)
            IF USED("crAnalitico")
                USE IN crAnalitico
            ENDIF
            CREATE CURSOR crAnalitico ;
                (Vends c(10), NVends c(50), Comis n(9,4), Valos n(12,4), ;
                 Datas d, EmpDopNums c(29), ContaDs c(10), RClis c(40), ;
                 Notas c(6), Dopes c(20))
            DO CASE
                CASE (loc_lnTip = 1 OR loc_lnTip = 4)
                    INDEX ON Vends + DTOS(Datas) + EmpDopNums TAG VendDatas
                CASE (loc_lnTip = 2)
                    INDEX ON Vends TAG VendDatas
                OTHERWISE
                    INDEX ON Vends + DTOS(Datas) + Dopes TAG VendDatas
            ENDCASE

            *== LOOP 1: Operacoes de venda (vendas=1) ==
            SELECT crSigCdOpe
            SET ORDER TO ordes
            GO TOP
            SCAN FOR crSigCdOpe.vendas = 1 AND crSigCdOpe.calcfecs <> 1
                THIS.SelecionaEest()
                SELECT crSigMvCab
                SCAN
                    IF (loc_lnNrOpcao = 1 AND EMPTY(crSigMvCab.notas)) OR ;
                       (loc_lnNrOpcao = 2 AND !EMPTY(crSigMvCab.notas))
                        LOOP
                    ENDIF
                    IF loc_lnBas = 1
                        THIS.CalcBase(1)
                    ELSE
                        THIS.SelecionaPar(1)
                    ENDIF
                    SELECT crSigMvCab
                ENDSCAN
                SELECT crSigCdOpe
            ENDSCAN

            *== LOOP 2: Caixas entrada (caixas=1, copers=1, nao-venda) ==
            SELECT crSigCdOpe
            SET ORDER TO ordes
            GO TOP
            SCAN FOR crSigCdOpe.caixas = 1 AND crSigCdOpe.copers = 1 AND ;
                     crSigCdOpe.vendas <> 1 AND crSigCdOpe.calcfecs <> 1
                THIS.SelecionaEest()
                SELECT crSigMvCab
                SCAN
                    IF (loc_lnNrOpcao = 1 AND EMPTY(crSigMvCab.notas)) OR ;
                       (loc_lnNrOpcao = 2 AND !EMPTY(crSigMvCab.notas))
                        LOOP
                    ENDIF
                    IF loc_lnBas = 1
                        THIS.CalcBase(1)
                    ELSE
                        THIS.SelecionaPar(1)
                    ENDIF
                    SELECT crSigMvCab
                ENDSCAN
                SELECT crSigCdOpe
            ENDSCAN

            *== LOOP 3: Caixas saidas (caixas=1, copers=2, nao-venda, subtrair) ==
            SELECT crSigCdOpe
            SET ORDER TO ordes
            GO TOP
            SCAN FOR crSigCdOpe.caixas = 1 AND crSigCdOpe.copers = 2 AND ;
                     crSigCdOpe.vendas <> 1 AND crSigCdOpe.calcfecs <> 1
                THIS.SelecionaEest()
                SELECT crSigMvCab
                SCAN
                    IF (loc_lnNrOpcao = 1 AND EMPTY(crSigMvCab.notas)) OR ;
                       (loc_lnNrOpcao = 2 AND !EMPTY(crSigMvCab.notas))
                        LOOP
                    ENDIF
                    IF loc_lnBas = 1
                        THIS.CalcBase(-1)
                    ELSE
                        THIS.SelecionaPar(-1)
                    ENDIF
                    SELECT crSigMvCab
                ENDSCAN
                SELECT crSigCdOpe
            ENDSCAN

            *== LOOP 4: calcfecs saidas (copers=2, calcfecs=1, subtrair) ==
            SELECT crSigCdOpe
            SET ORDER TO ordes
            GO TOP
            SCAN FOR crSigCdOpe.copers = 2 AND crSigCdOpe.calcfecs = 1
                THIS.SelecionaEest()
                SELECT crSigMvCab
                SCAN
                    IF (loc_lnNrOpcao = 1 AND EMPTY(crSigMvCab.notas)) OR ;
                       (loc_lnNrOpcao = 2 AND !EMPTY(crSigMvCab.notas))
                        LOOP
                    ENDIF
                    IF loc_lnBas = 1
                        THIS.CalcBase(-1)
                    ELSE
                        THIS.SelecionaPar(-1)
                    ENDIF
                    SELECT crSigMvCab
                ENDSCAN
                SELECT crSigCdOpe
            ENDSCAN

            *== POS-PROCESSAMENTO: Tipo=1 - Substitui EmpDopNums pela NF ==
            IF loc_lnTip = 1
                SELECT crAnalitico
                SET ORDER TO
                SCAN
                    IF USED("LocalSub")
                        USE IN LocalSub
                    ENDIF
                    loc_cSQL = ;
                        "SELECT a.EmpDopNums, a.Codigos, a.Emps, " + ;
                        "o.Dopes, RIGHT(a.Codigos, 6) AS Numes " + ;
                        "FROM SigMvPec a, SigMvCab b, SigCdOpe o " + ;
                        "WHERE a.EmpDopNums = b.EmpDopNums " + ;
                        "AND LEFT(a.Codigos, 3) = o.NDopes " + ;
                        "AND a.EmpDopNums = '" + ALLTRIM(crAnalitico.EmpDopNums) + "' " + ;
                        "AND a.EmpDopNums NOT IN (" + ;
                        "SELECT n.EmpDopNums FROM SigMvNfi n " + ;
                        "WHERE n.EmpDopNums = '" + ALLTRIM(crAnalitico.EmpDopNums) + "')"
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "LocalSub") >= 1
                        SELECT LocalSub
                        GO TOP IN LocalSub
                        IF !EOF("LocalSub")
                            loc_lcEdn = ALLTRIM(LocalSub.Emps) + ;
                                        ALLTRIM(LocalSub.Dopes) + ;
                                        STR(INT(VAL(ALLTRIM(LocalSub.Numes))), 6)
                            IF USED("LocalNF")
                                USE IN LocalNF
                            ENDIF
                            loc_cSQL = ;
                                "SELECT b.NFis, b.EmpDopNums " + ;
                                "FROM SigMvNfi b " + ;
                                "WHERE b.EmpDopNums = " + EscaparSQL(loc_lcEdn)
                            IF SQLEXEC(gnConnHandle, loc_cSQL, "LocalNF") >= 1
                                SELECT LocalNF
                                GO TOP IN LocalNF
                                IF !EOF("LocalNF")
                                    REPLACE EmpDopNums WITH LocalNF.EmpDopNums, ;
                                            Notas      WITH LocalNF.NFis ;
                                            IN crAnalitico
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                    SELECT crAnalitico
                ENDSCAN
            ENDIF

            *== POS-PROCESSAMENTO: Tipo=4 - Analise de Medias ==
            IF loc_lnTip = 4
                loc_lnOrdem = THIS.this_nOrdem

                IF USED("crMedia")
                    USE IN crMedia
                ENDIF
                SELECT *, 0.000 AS qtds FROM crAnalitico INTO CURSOR crMedia READWRITE
                SELECT crMedia
                SET ORDER TO
                SCAN
                    IF USED("LocalItn")
                        USE IN LocalItn
                    ENDIF
                    loc_cSQL = "SELECT SUM(qtds) AS Qtds FROM SigMvItn " + ;
                               "WHERE EmpDopNums = '" + ;
                               ALLTRIM(crMedia.EmpDopNums) + "' " + ;
                               "GROUP BY EmpDopNums"
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "LocalItn") >= 1
                        SELECT LocalItn
                        GO TOP IN LocalItn
                        IF !EOF("LocalItn")
                            REPLACE Qtds WITH LocalItn.Qtds IN crMedia
                        ENDIF
                    ENDIF
                    SELECT crMedia
                ENDSCAN

                *-- Agrupar por vendedor
                IF USED("cursor_4c_MedAgr")
                    USE IN cursor_4c_MedAgr
                ENDIF
                SELECT Vends, SUM(valos) AS valos, ;
                       COUNT(EmpDopNums) AS Vendas, ;
                       SUM(Qtds) AS Qtds, SUM(comis) AS comis ;
                       FROM crMedia ;
                       GROUP BY Vends ;
                       INTO CURSOR cursor_4c_MedAgr READWRITE

                *-- Calcular medias e ordenar pela opcao escolhida (coluna numerica)
                IF USED("crMedia")
                    USE IN crMedia
                ENDIF
                DO CASE
                    CASE loc_lnOrdem = 1
                        SELECT Vends, Qtds, ;
                               IIF(Qtds = 0, 0.0, valos / Qtds) AS MediaPecas, ;
                               Vendas, ;
                               IIF(Vendas = 0, 0.0, valos / Vendas) AS MediaOpers, ;
                               comis, valos ;
                               FROM cursor_4c_MedAgr ORDER BY 1 ;
                               INTO CURSOR crMedia READWRITE
                    CASE loc_lnOrdem = 2
                        SELECT Vends, Qtds, ;
                               IIF(Qtds = 0, 0.0, valos / Qtds) AS MediaPecas, ;
                               Vendas, ;
                               IIF(Vendas = 0, 0.0, valos / Vendas) AS MediaOpers, ;
                               comis, valos ;
                               FROM cursor_4c_MedAgr ORDER BY 2 ;
                               INTO CURSOR crMedia READWRITE
                    CASE loc_lnOrdem = 3
                        SELECT Vends, Qtds, ;
                               IIF(Qtds = 0, 0.0, valos / Qtds) AS MediaPecas, ;
                               Vendas, ;
                               IIF(Vendas = 0, 0.0, valos / Vendas) AS MediaOpers, ;
                               comis, valos ;
                               FROM cursor_4c_MedAgr ORDER BY 3 ;
                               INTO CURSOR crMedia READWRITE
                    CASE loc_lnOrdem = 4
                        SELECT Vends, Qtds, ;
                               IIF(Qtds = 0, 0.0, valos / Qtds) AS MediaPecas, ;
                               Vendas, ;
                               IIF(Vendas = 0, 0.0, valos / Vendas) AS MediaOpers, ;
                               comis, valos ;
                               FROM cursor_4c_MedAgr ORDER BY 4 ;
                               INTO CURSOR crMedia READWRITE
                    CASE loc_lnOrdem = 5
                        SELECT Vends, Qtds, ;
                               IIF(Qtds = 0, 0.0, valos / Qtds) AS MediaPecas, ;
                               Vendas, ;
                               IIF(Vendas = 0, 0.0, valos / Vendas) AS MediaOpers, ;
                               comis, valos ;
                               FROM cursor_4c_MedAgr ORDER BY 5 ;
                               INTO CURSOR crMedia READWRITE
                    OTHERWISE
                        SELECT Vends, Qtds, ;
                               IIF(Qtds = 0, 0.0, valos / Qtds) AS MediaPecas, ;
                               Vendas, ;
                               IIF(Vendas = 0, 0.0, valos / Vendas) AS MediaOpers, ;
                               comis, valos ;
                               FROM cursor_4c_MedAgr ORDER BY 6 ;
                               INTO CURSOR crMedia READWRITE
                ENDCASE

                IF USED("cursor_4c_MedAgr")
                    USE IN cursor_4c_MedAgr
                ENDIF
                SELECT crMedia
                GO TOP

            ELSE
                SELECT crAnalitico
                SET ORDER TO VendDatas
                GO TOP IN crAnalitico
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * SelecionaEest - Seleciona SigMvCab para a operacao atual (crSigCdOpe)
    * Equivale ao metodo 'selecionaeest' do form legado SIGRECOM
    *==========================================================================
    PROCEDURE SelecionaEest()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_lcVend

        loc_lSucesso = .F.
        loc_lcVend   = ALLTRIM(THIS.this_cVendedor)

        loc_cSQL = ;
            "SELECT Emps, Dopes, Datas, Numes, Notas, Valos, " + ;
            "GrVends, Vends, EmpDopNums, ContaDs " + ;
            "FROM SigMvCab " + ;
            "WHERE EmpDopNums BETWEEN '" + ;
            go_4c_Sistema.cCodEmpresa + crSigCdOpe.Dopes + STR(0, 6) + ;
            "' AND '" + ;
            go_4c_Sistema.cCodEmpresa + crSigCdOpe.Dopes + STR(999999, 6) + "' " + ;
            "AND Datas BETWEEN " + FormatarDataSQL(THIS.this_dDtInicial) + ;
            " AND " + FormatarDataSQL(THIS.this_dDtFinal) + ;
            IIF(EMPTY(loc_lcVend), "", " AND Vends = " + EscaparSQL(loc_lcVend)) + ;
            " ORDER BY Emps, Dopes, Datas, Numes, Notas, " + ;
            "Valos, GrVends, Vends, EmpDopNums, ContaDs"

        IF USED("crSigMvCab")
            USE IN crSigMvCab
        ENDIF

        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigMvCab")
        IF loc_nResult < 1
            MsgErro("Falha na Conex" + CHR(227) + "o (crSigMvCab)", "Erro")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CalcBase - Calcula comissao com base nos itens de venda (Base = Itens)
    * Equivale ao metodo 'calcbase' do form legado SIGRECOM
    * par_nMlt: +1 (entrada) ou -1 (saida/devolucao)
    *==========================================================================
    PROCEDURE CalcBase(par_nMlt)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_lcMoe, loc_lnTip, loc_lcDop
        LOCAL loc_lcNvends, loc_lnComFPag, loc_lnCot, loc_lnComi
        LOCAL loc_lnCotMoeV, loc_lnCotMoePag, loc_lcCta, loc_lcEdn

        loc_lSucesso = .T.
        loc_lcMoe    = THIS.this_cCdMoeda
        loc_lnTip    = THIS.this_nTipo

        IF crSigCdOpe.CComis <> 1
            RETURN .T.
        ENDIF

        *-- Totais de itens por moeda, excluindo servicos
        loc_cSQL = ;
            "SELECT a.MoeVs, SUM(a.Totas + a.ValRats) AS Valos " + ;
            "FROM SigMvItn a, SigCdPro b, SigCdGrp c " + ;
            "WHERE a.EmpDopNums = '" + ALLTRIM(crSigMvCab.EmpDopNums) + "' " + ;
            "AND a.CPros = b.CPros " + ;
            "AND b.CGrus = c.CGrus " + ;
            "GROUP BY a.MoeVs " + ;
            "ORDER BY a.MoeVs"

        IF USED("LocalItens")
            USE IN LocalItens
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "LocalItens")
        IF loc_nResult < 1
            MsgErro("Falha na Conex" + CHR(227) + "o (LocalItens)", "Erro")
            RETURN .F.
        ENDIF

        SELECT LocalItens
        SCAN
            *-- Verifica/recarrega dados do vendedor (cache por IClis+Grupos)
            IF !USED("crSigCdCli") OR ;
               (USED("crSigCdCli") AND ;
                (crSigCdCli.IClis + crSigCdCli.Grupos <> ;
                 PADR(crSigMvCab.Vends, 10) + PADR(crSigMvCab.Grvends, 10)))

                loc_cSQL = ;
                    "SELECT Grupos, IClis, RClis, Comis, CCargs " + ;
                    "FROM SigCdCli " + ;
                    "WHERE IClis = '" + PADR(crSigMvCab.Vends, 10) + "' " + ;
                    "AND Grupos = '" + PADR(crSigMvCab.Grvends, 10) + "' " + ;
                    "ORDER BY Grupos, IClis, RClis, Comis, CCargs"

                IF USED("crSigCdCli")
                    USE IN crSigCdCli
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCli")
                IF loc_nResult < 1
                    MsgErro("Falha na Conex" + CHR(227) + "o (crSigCdCli)", "Erro")
                    RETURN .F.
                ENDIF
                GO TOP IN crSigCdCli
            ENDIF

            loc_lcNvends  = ALLTRIM(crSigCdCli.Rclis)
            loc_lnComFPag = crSigCdCli.Comis

            *-- Se usa encargos, substitui comissao pela tabela de encargos
            IF crSigCdOpe.ComCargs = 1
                SELECT crSigCdCrg
                SEEK crSigCdCli.CCargs
                IF !EOF()
                    loc_lnComFPag = crSigCdCrg.Comis
                ENDIF
            ENDIF

            *-- Posiciona crAnalitico para o vendedor/data/operacao atual
            SELECT crAnalitico
            SET ORDER TO VendDatas
            loc_lcDop = crSigMvCab.Dopes

            DO CASE
                CASE (loc_lnTip = 1 OR loc_lnTip = 4)
                    SEEK crSigMvCab.Vends + DTOS(crSigMvCab.Datas) + crSigMvCab.EmpDopNums
                CASE (loc_lnTip = 2)
                    SEEK crSigMvCab.Vends
                OTHERWISE
                    *-- Tipo 3: apanha NF do subnivel
                    IF USED("LocalSub")
                        USE IN LocalSub
                    ENDIF
                    loc_cSQL = ;
                        "SELECT a.EmpDopNums, a.Codigos, a.Emps, " + ;
                        "o.Dopes, RIGHT(a.Codigos, 6) AS Numes " + ;
                        "FROM SigMvPec a, SigMvCab b, SigCdOpe o " + ;
                        "WHERE a.EmpDopNums = b.EmpDopNums " + ;
                        "AND LEFT(a.Codigos, 3) = o.NDopes " + ;
                        "AND a.EmpDopNums = '" + ALLTRIM(crSigMvCab.EmpDopNums) + "' " + ;
                        "AND a.EmpDopNums NOT IN (" + ;
                        "SELECT n.EmpDopNums FROM SigMvNfi n " + ;
                        "WHERE n.EmpDopNums = '" + ALLTRIM(crSigMvCab.EmpDopNums) + "')"
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "LocalSub") >= 1
                        SELECT LocalSub
                        GO TOP IN LocalSub
                        IF !EOF("LocalSub")
                            loc_lcEdn = ALLTRIM(LocalSub.Emps) + ;
                                        ALLTRIM(LocalSub.Dopes) + ;
                                        STR(INT(VAL(ALLTRIM(LocalSub.Numes))), 6)
                            IF USED("LocalNF")
                                USE IN LocalNF
                            ENDIF
                            loc_cSQL = ;
                                "SELECT b.NFis, b.EmpDopNums " + ;
                                "FROM SigMvNfi b " + ;
                                "WHERE b.EmpDopNums = " + EscaparSQL(loc_lcEdn)
                            IF SQLEXEC(gnConnHandle, loc_cSQL, "LocalNF") >= 1
                                SELECT LocalNF
                                GO TOP IN LocalNF
                                IF !EOF("LocalNF")
                                    loc_lcDop = LocalSub.Dopes
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                    SELECT crAnalitico
                    SEEK crSigMvCab.Vends + DTOS(crSigMvCab.Datas) + loc_lcDop
            ENDCASE

            *-- Adiciona novo registro se nao encontrado
            IF EOF("crAnalitico")
                APPEND BLANK IN crAnalitico

                IF USED("LocalCli")
                    USE IN LocalCli
                ENDIF
                loc_lcCta = ""
                loc_cSQL = "SELECT RClis FROM SigCdCli " + ;
                           "WHERE IClis = '" + ALLTRIM(crSigMvCab.ContaDs) + "'"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "LocalCli") >= 1
                    SELECT LocalCli
                    GO TOP
                    IF !EOF("LocalCli")
                        loc_lcCta = ALLTRIM(LocalCli.RClis)
                    ENDIF
                ENDIF

                REPLACE Vends  WITH crSigMvCab.Vends, ;
                        NVends WITH loc_lcNvends ;
                        IN crAnalitico

                IF (loc_lnTip = 1 OR loc_lnTip = 4)
                    REPLACE Datas      WITH crSigMvCab.Datas, ;
                            EmpDopNums WITH crSigMvCab.EmpDopNums, ;
                            Notas      WITH crSigMvCab.Notas, ;
                            ContaDs    WITH crSigMvCab.ContaDs, ;
                            RClis      WITH loc_lcCta ;
                            IN crAnalitico
                ENDIF

                IF (loc_lnTip = 3)
                    REPLACE Datas WITH crSigMvCab.Datas, ;
                            Dopes WITH loc_lcDop ;
                            IN crAnalitico
                ENDIF
            ENDIF

            *-- Calcula conversao de moeda e acumula comissao
            loc_lnCot = 1
            IF crSigCdOpe.Cmoes <> LocalItens.MoeVs
                loc_lnCotMoeV   = THIS.BuscarCotacao(ALLTRIM(LocalItens.MoeVs), crSigMvCab.Datas)
                loc_lnCotMoePag = THIS.BuscarCotacao(ALLTRIM(loc_lcMoe), crSigMvCab.Datas)
                IF loc_lnCotMoePag <> 0
                    loc_lnCot = loc_lnCotMoeV / loc_lnCotMoePag
                ENDIF
            ENDIF

            loc_lnComi = ((LocalItens.Valos * loc_lnCot) / 100) * loc_lnComFPag
            REPLACE Valos WITH Valos + ((LocalItens.Valos * loc_lnCot) * par_nMlt), ;
                    Comis WITH Comis + (loc_lnComi * par_nMlt) ;
                    IN crAnalitico

            SELECT LocalItens
        ENDSCAN

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * SelecionaPar - Calcula comissao com base nas parcelas (Base = Movimentacao)
    * Equivale ao metodo 'selecionapar' do form legado SIGRECOM
    * par_nMlt: +1 (entrada) ou -1 (saida/devolucao)
    *==========================================================================
    PROCEDURE SelecionaPar(par_nMlt)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_lcCdMoeda, loc_lnTip, loc_lnBas
        LOCAL loc_lnIcmss, loc_lnPar, loc_lnTm
        LOCAL loc_lnVpar, loc_lnVparav, loc_lnDt, loc_lnTd
        LOCAL loc_lnDesconto, loc_lnPorc
        LOCAL loc_lcNvends, loc_lnComFPag
        LOCAL loc_lcDop, loc_lcEdn, loc_lcCta
        LOCAL loc_lnCotFpg, loc_lnCotMoe, loc_lnCotFpg2, loc_lnCotMoeDt, loc_lnComi

        loc_lSucesso  = .T.
        loc_lcCdMoeda = THIS.this_cCdMoeda
        loc_lnTip     = THIS.this_nTipo
        loc_lnBas     = THIS.this_nBase
        loc_lnIcmss   = 0

        *-- Taxa mensal JM para calculo de valor a vista
        loc_lnTm = THIS.BuscarCambio({}, THIS.this_dDtFinal, SPACE(3), "JM ")

        *-- Parcelas do movimento atual, com troco negativo
        loc_cSQL = ;
            "SELECT a.cotfpgs, a.Empdopnums, a.dopes, a.fpags, " + ;
            "a.moefpgs, " + ;
            "CASE WHEN b.trocos = 1 THEN -a.valos ELSE a.valos END AS valos, " + ;
            "a.datas, a.vencs " + ;
            "FROM SigMvPar a, SigOpFp b " + ;
            "WHERE a.Empdopnums = '" + ;
            go_4c_Sistema.cCodEmpresa + ;
            crSigMvCab.Dopes + STR(crSigMvCab.Numes, 6) + "' " + ;
            "AND a.FPags = b.FPags " + ;
            "ORDER BY a.Empdopnums, a.dopes, a.fpags, " + ;
            "a.moefpgs, valos, a.datas, a.vencs"

        IF USED("crSigMvPar")
            USE IN crSigMvPar
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigMvPar")
        IF loc_nResult < 1
            MsgErro("Falha na Conex" + CHR(227) + "o (crSigMvPar)", "Erro")
            RETURN .F.
        ENDIF

        *-- Busca ICMSS se base for Movimentacao S/ST
        IF loc_lnBas = 3
            IF USED("crNfi")
                USE IN crNfi
            ENDIF
            loc_cSQL = "SELECT a.icmss FROM SigMvNfi a " + ;
                       "WHERE a.Empdopnums = '" + ;
                       ALLTRIM(crSigMvCab.EmpDopNums) + "'"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crNfi") >= 1
                SELECT crNfi
                GO TOP
                IF !EOF()
                    loc_lnIcmss = crNfi.icmss
                ENDIF
            ENDIF
            loc_lnPar   = RECCOUNT("crSigMvPar")
            loc_lnIcmss = loc_lnIcmss / IIF(loc_lnPar = 0, 1, loc_lnPar)
        ENDIF

        *-- Processa cada parcela
        SELECT crSigMvPar
        SCAN
            *-- Localiza ou cria entrada na Parcela (por fpags)
            SELECT Parcela
            SET ORDER TO fpags
            SEEK crSigMvPar.fpags
            IF EOF()
                APPEND BLANK
                REPLACE fpags WITH crSigMvPar.fpags IN Parcela
            ENDIF

            *-- Calcula valor na moeda de destino
            loc_lnCotFpg = THIS.BuscarCotacao(ALLTRIM(crSigMvPar.moefpgs), DATE())
            loc_lnCotMoe = THIS.BuscarCotacao(ALLTRIM(loc_lcCdMoeda), DATE())
            IF loc_lnCotMoe <> 0
                loc_lnVpar = crSigMvPar.valos * loc_lnCotFpg / loc_lnCotMoe
            ELSE
                loc_lnVpar = crSigMvPar.valos
            ENDIF

            *-- Ajusta sinal conforme tipo de operacao da parcela
            IF SEEK(crSigMvPar.dopes, "crSigCdOpe", "dopes")
                IF crSigCdOpe.copers = 2
                    loc_lnVpar = loc_lnVpar * (-1)
                ENDIF
            ENDIF

            *-- Acumula na Parcela (entradas vs devolu??es)
            IF par_nMlt > 0
                REPLACE valos  WITH valos  + loc_lnVpar IN Parcela
            ELSE
                REPLACE Devols WITH Devols + loc_lnVpar IN Parcela
            ENDIF

            *-- Calculo do valor a vista por antecipacao de pagamento
            loc_lnVparav = loc_lnVpar
            loc_lnDt     = crSigMvPar.datas - crSigMvPar.vencs
            IF loc_lnDt < 0
                IF loc_lnTm <> 0
                    loc_lnTd = ((1 + loc_lnTm / 100) ^ (1 / 30) - 1) * 100
                    loc_lnTd = INT(loc_lnTd * 100 + 0.5) / 100
                ELSE
                    loc_lnTd = 0
                ENDIF
                IF loc_lnTd <> 0
                    loc_lnDesconto = (1 + loc_lnTd / 100) ^ (-1 * loc_lnDt)
                    loc_lnPorc     = (1 - 1 / loc_lnDesconto) * 100
                    loc_lnPorc     = INT(loc_lnPorc * 100 + 0.5) / 100
                    loc_lnVparav   = loc_lnVpar * (1 - (loc_lnPorc / 100))
                    loc_lnVparav   = INT(loc_lnVparav * 100 + 0.5) / 100
                ENDIF
            ENDIF

            *-- Desconto adicional da forma de pagamento
            SELECT crSigOpFp
            SEEK crSigMvPar.FPags
            IF !EOF() AND !EMPTY(crSigOpFp.Descs)
                loc_lnVparav = loc_lnVparav - loc_lnVparav * crSigOpFp.Descs / 100
            ENDIF

            *-- Acumula valor a vista e classifica tipo na Parcela
            SELECT Parcela
            IF par_nMlt > 0
                REPLACE ValoAvs WITH ValoAvs + loc_lnVparav IN Parcela
            ELSE
                REPLACE ValoAvs WITH ValoAvs - loc_lnVparav IN Parcela
            ENDIF
            IF USED("crSigOpFp") AND !EOF("crSigOpFp")
                REPLACE Tipo WITH THIS.VerTpPag(crSigOpFp.Infos) IN Parcela
            ENDIF

            *-- Calcula comissao se operacao configurada para tal
            IF crSigCdOpe.ccomis = 1
                loc_cSQL = ;
                    "SELECT Grupos, IClis, RClis, Comis, CCargs " + ;
                    "FROM SigCdCli " + ;
                    "WHERE IClis = '" + PADR(crSigMvCab.Vends, 10) + "' " + ;
                    "AND Grupos = '" + PADR(crSigMvCab.Grvends, 10) + "' " + ;
                    "ORDER BY Grupos, IClis, RClis, Comis, CCargs"

                IF USED("crSigCdCli")
                    USE IN crSigCdCli
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCli")
                IF loc_nResult < 1
                    MsgErro("Falha na Conex" + CHR(227) + "o (crSigCdCli)", "Erro")
                    RETURN .F.
                ENDIF
                SELECT crSigCdCli
                GO TOP

                IF !EMPTY(crSigCdCli.Comis)
                    loc_lnComFPag = crSigCdCli.Comis
                ELSE
                    *-- Usa comissao da forma de pagamento
                    SELECT crSigOpFp
                    SEEK crSigMvPar.FPags
                    loc_lnComFPag = IIF(EOF("crSigOpFp"), 0, crSigOpFp.fpcomiss)
                    SELECT crSigCdCli
                ENDIF

                loc_lcNvends = ALLTRIM(crSigCdCli.Rclis)

                IF crSigCdOpe.ComCargs = 1
                    SELECT crSigCdCrg
                    SEEK crSigCdCli.CCargs
                    IF !EOF()
                        loc_lnComFPag = crSigCdCrg.Comis
                    ENDIF
                ENDIF

                *-- Posiciona crAnalitico
                SELECT crAnalitico
                SET ORDER TO VendDatas
                loc_lcDop = crSigMvCab.Dopes

                DO CASE
                    CASE (loc_lnTip = 1 OR loc_lnTip = 4)
                        SEEK crSigMvCab.Vends + DTOS(crSigMvCab.Datas) + crSigMvCab.EmpDopNums
                    CASE (loc_lnTip = 2)
                        SEEK crSigMvCab.Vends
                    OTHERWISE
                        IF USED("LocalSub")
                            USE IN LocalSub
                        ENDIF
                        loc_cSQL = ;
                            "SELECT a.EmpDopNums, a.Codigos, a.Emps, " + ;
                            "o.Dopes, RIGHT(a.Codigos, 6) AS Numes " + ;
                            "FROM SigMvPec a, SigMvCab b, SigCdOpe o " + ;
                            "WHERE a.EmpDopNums = b.EmpDopNums " + ;
                            "AND LEFT(a.Codigos, 3) = o.NDopes " + ;
                            "AND a.EmpDopNums = '" + ALLTRIM(crSigMvCab.EmpDopNums) + "' " + ;
                            "AND a.EmpDopNums NOT IN (" + ;
                            "SELECT n.EmpDopNums FROM SigMvNfi n " + ;
                            "WHERE n.EmpDopNums = '" + ALLTRIM(crSigMvCab.EmpDopNums) + "')"
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "LocalSub") >= 1
                            SELECT LocalSub
                            GO TOP IN LocalSub
                            IF !EOF("LocalSub")
                                loc_lcEdn = ALLTRIM(LocalSub.Emps) + ;
                                            ALLTRIM(LocalSub.Dopes) + ;
                                            STR(INT(VAL(ALLTRIM(LocalSub.Numes))), 6)
                                IF USED("LocalNF")
                                    USE IN LocalNF
                                ENDIF
                                loc_cSQL = ;
                                    "SELECT b.NFis, b.EmpDopNums " + ;
                                    "FROM SigMvNfi b " + ;
                                    "WHERE b.EmpDopNums = " + EscaparSQL(loc_lcEdn)
                                IF SQLEXEC(gnConnHandle, loc_cSQL, "LocalNF") >= 1
                                    SELECT LocalNF
                                    GO TOP IN LocalNF
                                    IF !EOF("LocalNF")
                                        loc_lcDop = LocalSub.Dopes
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                        SELECT crAnalitico
                        SEEK crSigMvCab.Vends + DTOS(crSigMvCab.Datas) + loc_lcDop
                ENDCASE

                IF EOF("crAnalitico")
                    APPEND BLANK IN crAnalitico

                    IF USED("LocalCli")
                        USE IN LocalCli
                    ENDIF
                    loc_lcCta = ""
                    loc_cSQL = "SELECT RClis FROM SigCdCli " + ;
                               "WHERE IClis = '" + ALLTRIM(crSigMvCab.ContaDs) + "'"
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "LocalCli") >= 1
                        SELECT LocalCli
                        GO TOP
                        IF !EOF("LocalCli")
                            loc_lcCta = ALLTRIM(LocalCli.RClis)
                        ENDIF
                    ENDIF

                    REPLACE Vends  WITH crSigMvCab.Vends, ;
                            NVends WITH loc_lcNvends ;
                            IN crAnalitico

                    IF (loc_lnTip = 1 OR loc_lnTip = 4)
                        REPLACE Datas      WITH crSigMvCab.Datas, ;
                                EmpDopNums WITH crSigMvCab.EmpDopNums, ;
                                Notas      WITH crSigMvCab.Notas, ;
                                ContaDs    WITH crSigMvCab.ContaDs, ;
                                RClis      WITH loc_lcCta ;
                                IN crAnalitico
                    ENDIF

                    IF (loc_lnTip = 3)
                        REPLACE Datas WITH crSigMvCab.Datas, ;
                                Dopes WITH loc_lcDop ;
                                IN crAnalitico
                    ENDIF
                ENDIF

                *-- Calcula comissao usando cotacao da parcela
                loc_lnCotFpg2  = IIF(crSigMvPar.cotfpgs <> 0, crSigMvPar.cotfpgs, ;
                                     THIS.BuscarCotacao(ALLTRIM(crSigMvPar.moefpgs), ;
                                                        crSigMvCab.Datas))
                loc_lnCotMoeDt = THIS.BuscarCotacao(ALLTRIM(loc_lcCdMoeda), crSigMvCab.Datas)

                IF loc_lnCotMoeDt <> 0
                    loc_lnComi = (crSigMvPar.valos - loc_lnIcmss) * ;
                                 loc_lnCotFpg2 / loc_lnCotMoeDt / 100 * loc_lnComFPag
                    REPLACE Valos WITH Valos - loc_lnIcmss + ;
                            ((crSigMvPar.valos * loc_lnCotFpg2 / loc_lnCotMoeDt) * par_nMlt), ;
                            Comis WITH Comis + (loc_lnComi * par_nMlt) ;
                            IN crAnalitico
                ENDIF
            ENDIF

            SELECT crSigMvPar
        ENDSCAN

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarCursoresBase - Carrega cursores de referencia para o processamento
    * Equivale aos AddCursor/ReQuery do Init() do form legado SIGRECOM
    *==========================================================================
    PROCEDURE CarregarCursoresBase()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_oErr, loc_lFalhou

        loc_lSucesso = .F.
        loc_lFalhou  = .F.

        TRY
            *-- SigCdOpe (operacoes de venda/caixa)
            IF !loc_lFalhou
                IF USED("crSigCdOpe")
                    USE IN crSigCdOpe
                ENDIF
                loc_cSQL = ;
                    "SELECT ordes, dopes, cmoes, copers, ccomis, comcargs, " + ;
                    "vendas, calcfecs, relfechas, caixas, ndopes " + ;
                    "FROM SigCdOpe " + ;
                    "ORDER BY ordes"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdOpe")
                IF loc_nResult < 1
                    loc_lFalhou = .T.
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdOpe"
                    MsgErro("Falha ao carregar SigCdOpe", "Erro")
                ELSE
                    SELECT crSigCdOpe
                    INDEX ON ordes TAG ordes
                    INDEX ON dopes TAG dopes
                ENDIF
            ENDIF

            *-- SigCdEmp (dados da empresa)
            IF !loc_lFalhou
                IF USED("crSigCdEmp")
                    USE IN crSigCdEmp
                ENDIF
                loc_cSQL = "SELECT cemps, razas FROM SigCdEmp " + ;
                           "WHERE cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdEmp")
                IF loc_nResult < 1
                    loc_lFalhou = .T.
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdEmp"
                    MsgErro("Falha ao carregar SigCdEmp", "Erro")
                ENDIF
            ENDIF

            *-- SigCdMoe (cadastro de moedas)
            IF !loc_lFalhou
                IF USED("crSigCdMoe")
                    USE IN crSigCdMoe
                ENDIF
                loc_cSQL = ;
                    "SELECT cmoes, dmoes, cotas, datatrans, fmults, nordrels, " + ;
                    "disfpres, valadics, grumoes, moeqs, qtdeqs, submoes " + ;
                    "FROM SigCdMoe " + ;
                    "ORDER BY cmoes"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdMoe")
                IF loc_nResult < 1
                    loc_lFalhou = .T.
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdMoe"
                    MsgErro("Falha ao carregar SigCdMoe", "Erro")
                ELSE
                    SELECT crSigCdMoe
                    INDEX ON cmoes TAG cmoes
                    INDEX ON dmoes TAG dmoes
                ENDIF
            ENDIF

            *-- SigCdCot (cotacoes de moeda - indexado por moeda+data)
            IF !loc_lFalhou
                IF USED("crSigCdCot")
                    USE IN crSigCdCot
                ENDIF
                loc_cSQL = ;
                    "SELECT cmoes, datas, horas, valos, cidchaves, usuars, dtalts " + ;
                    "FROM SigCdCot " + ;
                    "ORDER BY cmoes, datas"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCot")
                IF loc_nResult < 1
                    loc_lFalhou = .T.
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdCot"
                    MsgErro("Falha ao carregar SigCdCot", "Erro")
                ELSE
                    SELECT crSigCdCot
                    INDEX ON PADR(cmoes, 3) + DTOS(datas) TAG CMOEDATA
                ENDIF
            ENDIF

            *-- SigOpFp (formas de pagamento)
            IF !loc_lFalhou
                IF USED("crSigOpFp")
                    USE IN crSigOpFp
                ENDIF
                loc_cSQL = ;
                    "SELECT Fpags, Descs, Infos, FPComiss, trocos " + ;
                    "FROM SigOpFp " + ;
                    "ORDER BY Fpags"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigOpFp")
                IF loc_nResult < 1
                    loc_lFalhou = .T.
                    THIS.this_cMensagemErro = "Falha ao carregar SigOpFp"
                    MsgErro("Falha ao carregar SigOpFp", "Erro")
                ELSE
                    SELECT crSigOpFp
                    INDEX ON FPags TAG FPags
                ENDIF
            ENDIF

            *-- SigCdCrg (tabela de encargos/cargas de comissao)
            IF !loc_lFalhou
                IF USED("crSigCdCrg")
                    USE IN crSigCdCrg
                ENDIF
                loc_cSQL = "SELECT CCargs, Comis FROM SigCdCrg ORDER BY CCargs"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCrg")
                IF loc_nResult < 1
                    loc_lFalhou = .T.
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdCrg"
                    MsgErro("Falha ao carregar SigCdCrg", "Erro")
                ELSE
                    SELECT crSigCdCrg
                    INDEX ON CCargs TAG CCargs
                ENDIF
            ENDIF

            IF !loc_lFalhou
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "CarregarCursoresBase")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarCaptionsOpcao - Carrega titulos dinamicos de opt_nr_opcao
    * Le SigCdPac e seta this_cTitOpcS / this_cTitOpcN / this_cTitOpcA
    *==========================================================================
    PROCEDURE CarregarCaptionsOpcao()
        LOCAL loc_cSQL, loc_nResult, loc_oErr

        TRY
            loc_cSQL = "SELECT TitOpcS, TitOpcN, TitOpcA FROM SigCdPac"
            IF USED("cursor_4c_CdPac")
                USE IN cursor_4c_CdPac
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CdPac")
            IF loc_nResult >= 1
                SELECT cursor_4c_CdPac
                GO TOP
                IF !EOF()
                    IF !EMPTY(cursor_4c_CdPac.TitOpcS)
                        THIS.this_cTitOpcS = ALLTRIM(cursor_4c_CdPac.TitOpcS)
                    ENDIF
                    IF !EMPTY(cursor_4c_CdPac.TitOpcN)
                        THIS.this_cTitOpcN = ALLTRIM(cursor_4c_CdPac.TitOpcN)
                    ENDIF
                    IF !EMPTY(cursor_4c_CdPac.TitOpcA)
                        THIS.this_cTitOpcA = ALLTRIM(cursor_4c_CdPac.TitOpcA)
                    ENDIF
                ENDIF
                USE IN cursor_4c_CdPac
            ENDIF
        CATCH TO loc_oErr
            MsgErro(loc_oErr.Message, "CarregarCaptionsOpcao")
        ENDTRY

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarMoedaPadrao - Retorna descricao de uma moeda pelo codigo
    * par_cCdMoeda: codigo da moeda (ex: 'R  ')
    *==========================================================================
    FUNCTION CarregarMoedaPadrao(par_cCdMoeda)
        LOCAL loc_cDesc, loc_cSQL, loc_nResult, loc_oErr

        loc_cDesc = ""

        TRY
            loc_cSQL = "SELECT DMoes FROM SigCdMoe " + ;
                       "WHERE cmoes = " + EscaparSQL(PADR(ALLTRIM(par_cCdMoeda), 3))
            IF USED("cursor_4c_MoeDsc")
                USE IN cursor_4c_MoeDsc
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeDsc")
            IF loc_nResult >= 1
                SELECT cursor_4c_MoeDsc
                GO TOP
                IF !EOF()
                    loc_cDesc = ALLTRIM(cursor_4c_MoeDsc.DMoes)
                ENDIF
                USE IN cursor_4c_MoeDsc
            ENDIF
        CATCH TO loc_oErr
            MsgErro(loc_oErr.Message, "CarregarMoedaPadrao")
        ENDTRY

        RETURN loc_cDesc
    ENDPROC

    *==========================================================================
    * BuscarCotacao - Retorna cotacao de moeda em determinada data
    * Equivale a fBuscarCotacao() do framework legado
    * Usa crSigCdCot (indexado por CMOEDATA = PADR(cmoes,3)+DTOS(datas))
    *==========================================================================
    FUNCTION BuscarCotacao(par_cMoeda, par_dData)
        LOCAL loc_nValor, loc_oErr

        loc_nValor = 1

        TRY
            IF USED("crSigCdCot") AND !EMPTY(par_cMoeda)
                SELECT crSigCdCot
                SET ORDER TO CMOEDATA
                SET NEAR ON
                IF SEEK(PADR(ALLTRIM(par_cMoeda), 3) + DTOS(par_dData))
                    IF crSigCdCot.valos <> 0
                        loc_nValor = crSigCdCot.valos
                    ENDIF
                ENDIF
                SET NEAR OFF
            ENDIF
        CATCH TO loc_oErr
            loc_nValor = 1
        ENDTRY

        RETURN loc_nValor
    ENDPROC

    *==========================================================================
    * BuscarCambio - Retorna taxa especial de cambio (ex: JM = taxa mensal)
    * Equivale a fBuscarCambio() do framework legado
    * par_dIgnorado: data ignorada (compatibilidade com assinatura original)
    * par_dData:     data de referencia para busca
    * par_cEspaco:   parametro auxiliar (geralmente SPACE(3))
    * par_cTipo:     codigo da taxa (ex: 'JM ')
    *==========================================================================
    FUNCTION BuscarCambio(par_dIgnorado, par_dData, par_cEspaco, par_cTipo)
        LOCAL loc_nTaxa, loc_oErr

        loc_nTaxa = 0

        TRY
            IF USED("crSigCdCot") AND !EMPTY(par_cTipo)
                SELECT crSigCdCot
                SET ORDER TO CMOEDATA
                SET NEAR ON
                IF SEEK(PADR(ALLTRIM(par_cTipo), 3) + DTOS(par_dData))
                    loc_nTaxa = crSigCdCot.valos
                ENDIF
                SET NEAR OFF
            ENDIF
        CATCH TO loc_oErr
            loc_nTaxa = 0
        ENDTRY

        RETURN loc_nTaxa
    ENDPROC

    *==========================================================================
    * VerTpPag - Classifica tipo de pagamento pelo campo Infos de SigOpFp
    * Equivale a fVerTpPag() do framework legado
    *==========================================================================
    FUNCTION VerTpPag(par_cInfos)
        RETURN PADR(ALLTRIM(par_cInfos), 6)
    ENDPROC

    *==========================================================================
    * Imprimir - Executa PrepararDados e envia relatorio para impressora
    *==========================================================================
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_lcSep, loc_lcPto, loc_oErr

        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.PrepararDados()
            IF loc_lSucesso
                loc_lcSep = SET("Separator")
                loc_lcPto = SET("Point")
                SET POINT TO ","
                SET SEPARATOR TO "."

                DO CASE
                    CASE THIS.this_nTipo = 1
                        IF THIS.this_nQuebra = 1
                            REPORT FORM (gc_4c_CaminhoReports + "SigReCo1") ;
                                   TO PRINTER PROMPT NOCONSOLE
                        ELSE
                            REPORT FORM (gc_4c_CaminhoReports + "SigReCo2") ;
                                   TO PRINTER PROMPT NOCONSOLE
                        ENDIF
                    CASE THIS.this_nTipo = 2
                        REPORT FORM (gc_4c_CaminhoReports + "SigReCo3") ;
                               TO PRINTER PROMPT NOCONSOLE
                    CASE THIS.this_nTipo = 4
                        REPORT FORM (gc_4c_CaminhoReports + "SigReCo5") ;
                               TO PRINTER PROMPT NOCONSOLE
                    OTHERWISE
                        REPORT FORM (gc_4c_CaminhoReports + "SigReCo4") ;
                               TO PRINTER PROMPT NOCONSOLE
                ENDCASE

                SET POINT TO (loc_lcPto)
                SET SEPARATOR TO (loc_lcSep)
            ENDIF

        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "Imprimir")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Visualizar - Executa PrepararDados e exibe preview do relatorio
    *==========================================================================
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_lcSep, loc_lcPto, loc_oErr

        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.PrepararDados()
            IF loc_lSucesso
                loc_lcSep = SET("Separator")
                loc_lcPto = SET("Point")
                SET POINT TO ","
                SET SEPARATOR TO "."

                DO CASE
                    CASE THIS.this_nTipo = 1
                        IF THIS.this_nQuebra = 1
                            REPORT FORM (gc_4c_CaminhoReports + "SigReCo1") ;
                                   PREVIEW NOCONSOLE
                        ELSE
                            REPORT FORM (gc_4c_CaminhoReports + "SigReCo2") ;
                                   PREVIEW NOCONSOLE
                        ENDIF
                    CASE THIS.this_nTipo = 2
                        REPORT FORM (gc_4c_CaminhoReports + "SigReCo3") ;
                               PREVIEW NOCONSOLE
                    CASE THIS.this_nTipo = 4
                        REPORT FORM (gc_4c_CaminhoReports + "SigReCo5") ;
                               PREVIEW NOCONSOLE
                    OTHERWISE
                        REPORT FORM (gc_4c_CaminhoReports + "SigReCo4") ;
                               PREVIEW NOCONSOLE
                ENDCASE

                SET POINT TO (loc_lcPto)
                SET SEPARATOR TO (loc_lcSep)
            ENDIF

        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "Visualizar")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterMensagemErro - Retorna mensagem de erro do ultimo processamento
    *==========================================================================
    FUNCTION ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave logica do relatorio (tabela+periodo)
    * Usada por RegistrarAuditoria para identificar a execucao do relatorio
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ALLTRIM(THIS.this_cTabela) + "|" + ;
                     DTOS(THIS.this_dDtInicial) + "|" + ;
                     DTOS(THIS.this_dDtFinal) + "|" + ;
                     ALLTRIM(THIS.this_cCdMoeda) + "|" + ;
                     "TIPO" + TRANSFORM(THIS.this_nTipo)
        RETURN loc_cChave
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega filtros do relatorio a partir de um cursor de
    * parametros (uso opcional para restaurar configuracao salva pelo usuario)
    * par_cAliasCursor: alias do cursor com colunas DtInicial, DtFinal, CdMoeda,
    *                   Vendedor, Tipo, NrOpcao, Quebra, Base, Ordem
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErr, loc_cAlias

        loc_lSucesso = .F.

        IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor de par" + CHR(226) + "metros n" + ;
                                      CHR(227) + "o dispon" + CHR(237) + "vel: " + ;
                                      TRANSFORM(par_cAliasCursor)
            RETURN .F.
        ENDIF

        loc_cAlias = par_cAliasCursor

        TRY
            SELECT (loc_cAlias)
            IF !EOF()
                IF TYPE(loc_cAlias + ".DtInicial") = "D"
                    THIS.this_dDtInicial = EVALUATE(loc_cAlias + ".DtInicial")
                ENDIF
                IF TYPE(loc_cAlias + ".DtFinal") = "D"
                    THIS.this_dDtFinal = EVALUATE(loc_cAlias + ".DtFinal")
                ENDIF
                IF TYPE(loc_cAlias + ".CdMoeda") = "C"
                    THIS.this_cCdMoeda = EVALUATE(loc_cAlias + ".CdMoeda")
                ENDIF
                IF TYPE(loc_cAlias + ".DsMoeda") = "C"
                    THIS.this_cDsMoeda = EVALUATE(loc_cAlias + ".DsMoeda")
                ENDIF
                IF TYPE(loc_cAlias + ".Vendedor") = "C"
                    THIS.this_cVendedor = EVALUATE(loc_cAlias + ".Vendedor")
                ENDIF
                IF TYPE(loc_cAlias + ".Tipo") = "N"
                    THIS.this_nTipo = EVALUATE(loc_cAlias + ".Tipo")
                ENDIF
                IF TYPE(loc_cAlias + ".NrOpcao") = "N"
                    THIS.this_nNrOpcao = EVALUATE(loc_cAlias + ".NrOpcao")
                ENDIF
                IF TYPE(loc_cAlias + ".Quebra") = "N"
                    THIS.this_nQuebra = EVALUATE(loc_cAlias + ".Quebra")
                ENDIF
                IF TYPE(loc_cAlias + ".Base") = "N"
                    THIS.this_nBase = EVALUATE(loc_cAlias + ".Base")
                ENDIF
                IF TYPE(loc_cAlias + ".Ordem") = "N"
                    THIS.this_nOrdem = EVALUATE(loc_cAlias + ".Ordem")
                ENDIF
                THIS.this_lExibeOrdem = (THIS.this_nTipo = 4)
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Cursor de par" + CHR(226) + ;
                                          "metros vazio"
            ENDIF
        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Registra execucao do relatorio em LogAuditoria
    * Para relatorios, "Inserir" significa registrar uma nova execucao,
    * permitindo rastreamento de quem rodou qual relatorio e quando
    *==========================================================================
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_oErr

        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.RegistrarAuditoria("REPORT_RUN")
            IF !loc_lSucesso
                THIS.this_cMensagemErro = "Falha ao registrar execu" + ;
                                          CHR(231) + CHR(227) + "o do relat" + ;
                                          CHR(243) + "rio em LogAuditoria"
            ENDIF
        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "Inserir")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Registra reexecucao do relatorio em LogAuditoria
    * Para relatorios, "Atualizar" significa registrar uma reexecucao
    * (ex: usuario alterou filtros e gerou novamente)
    *==========================================================================
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_oErr

        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.RegistrarAuditoria("REPORT_RERUN")
            IF !loc_lSucesso
                THIS.this_cMensagemErro = "Falha ao registrar reexecu" + ;
                                          CHR(231) + CHR(227) + "o do relat" + ;
                                          CHR(243) + "rio em LogAuditoria"
            ENDIF
        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "Atualizar")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * RegistrarAuditoria - Registra operacao do relatorio em LogAuditoria
    * par_cOperacao: "REPORT_RUN", "REPORT_RERUN", "REPORT_PREVIEW", etc.
    *==========================================================================
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cChave, loc_cUsuario, loc_cSQL, loc_nResult, loc_oErr

        loc_lSucesso = .F.

        TRY
            loc_cChave = THIS.ObterChavePrimaria()

            IF EMPTY(loc_cChave)
                THIS.this_cMensagemErro = "Chave de auditoria vazia"
                loc_lSucesso = .F.
            ENDIF

            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                               gc_4c_UsuarioLogado, "SISTEMA")

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cTabela)) + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       "GETDATE())"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)

            IF !loc_lSucesso
                THIS.this_cMensagemErro = "SQLEXEC falhou ao inserir em LogAuditoria"
            ENDIF

        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Destroy - Fecha cursores abertos e limpa recursos
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_aCursores(13), loc_nI
        loc_aCursores(1)  = "crSigCdOpe"
        loc_aCursores(2)  = "crSigCdEmp"
        loc_aCursores(3)  = "crSigCdMoe"
        loc_aCursores(4)  = "crSigCdCot"
        loc_aCursores(5)  = "crSigOpFp"
        loc_aCursores(6)  = "crSigCdCrg"
        loc_aCursores(7)  = "crAnalitico"
        loc_aCursores(8)  = "Parcela"
        loc_aCursores(9)  = "dbcabecalho"
        loc_aCursores(10) = "crMedia"
        loc_aCursores(11) = "crSigMvCab"
        loc_aCursores(12) = "crSigMvPar"
        loc_aCursores(13) = "crSigCdCli"
        FOR loc_nI = 1 TO 13
            IF USED(loc_aCursores(loc_nI))
                USE IN (loc_aCursores(loc_nI))
            ENDIF
        NEXT
        DODEFAULT()
    ENDPROC

ENDDEFINE
