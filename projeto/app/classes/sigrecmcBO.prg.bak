*==============================================================================
* SIGRECMCBO.PRG
* Business Object para Relatorio de Clientes que Mais/Menos/Nao Compram
* em Valores e Quantidades
*
* Herda de RelatorioBase
* Formulario original: SIGRECMC.SCX (frmrelatorio)
*==============================================================================

DEFINE CLASS sigrecmcBO AS RelatorioBase

    *-- Filtro: empresa
    this_cEmpresa    = ""
    this_cDEmpresa   = ""

    *-- Filtro: operacao/movimentacao (get_nm_operacao - MaxLength=20)
    this_cNmOperacao = ""

    *-- Filtro: periodo
    this_dDtInicial  = {}
    this_dDtFinal    = {}

    *-- Filtro: moeda (get_moeda MaxLength=3, get_moeda_desc MaxLength=15)
    this_cMoeda      = ""
    this_cMoedaDesc  = ""

    *-- Filtro: quantidades (numericos - Get_Qtde, Get_QtMin)
    this_nQtde       = 0
    this_nQtMin      = 0

    *-- Filtro: conta/estoque (getCdEstoque MaxLength=10, getDsEstoque MaxLength=40)
    this_cCdConta    = ""
    this_cDsConta    = ""

    *-- Filtro: vendedor (getCdVendedor MaxLength=10, getDsVendedor MaxLength=40)
    this_cCdVendedor = ""
    this_cDsVendedor = ""

    *-- Filtro: produto (get_cd_codigo MaxLength=14, get_ds_codigo MaxLength=40)
    this_cCdProduto  = ""
    this_cDsProduto  = ""

    *-- Opcoes de relatorio (option groups)
    *   this_nOrdem: 1=Mais Compram, 2=Menos Compram, 3=Nao Compram
    this_nOrdem      = 1
    *   this_nOptSelRel: 1=Valor, 2=Quantidade
    this_nOptSelRel  = 1
    *   this_nOptCompara: 1=Cliente, 2=Classificacao
    this_nOptCompara = 1
    *   this_nOptMovCad: 1=Movimentacao, 2=Cadastro
    this_nOptMovCad  = 1

    *-- Checkboxes (0=desmarcado, 1=marcado)
    this_nComparativo = 0
    this_nChkCidade   = 0
    this_nChkDadosCli = 0
    this_nChkValor    = 0

    *-- Dados auxiliares carregados pelo form no Init
    *   Moeda e grupo padrao vindos de SigCdPam
    this_cMoedaPadrao = ""
    this_cGrPadClis   = ""

    *-- Cabecalho do relatorio (preenchidos em PrepararDados)
    this_cNmEmpresa = ""
    this_cNmTitulo  = ""
    this_cNmPeriodo = ""
    *   "Valor" ou "Quantidade" - controlado por this_nOptSelRel
    this_cTipoRel   = ""

    *-- Cursor de saida dos dados processados
    this_cCursorDados = "cursor_4c_Dados"

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida filtros antes de gerar o relatorio
    * Equivale ao mchkvalid() legado
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFiltros()

        IF EMPTY(THIS.this_dDtInicial)
            THIS.this_cMensagemErro = "Data inicial inv" + CHR(225) + "lida !"
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_dDtFinal)
            THIS.this_cMensagemErro = "Data final inv" + CHR(225) + "lida !"
            RETURN .F.
        ENDIF

        IF THIS.this_dDtInicial > THIS.this_dDtFinal
            THIS.this_cMensagemErro = "Data inicial maior que data final !"
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_cMoeda) AND THIS.this_nOptSelRel = 1
            THIS.this_cMensagemErro = "Moeda Inv" + CHR(225) + "lida." + CHR(13) + ;
                "Informe o tipo de moeda"
            RETURN .F.
        ENDIF

        IF (YEAR(THIS.this_dDtFinal) - YEAR(THIS.this_dDtInicial)) > 5 AND ;
            THIS.this_nComparativo = 1
            THIS.this_cMensagemErro = "Intervalo m" + CHR(225) + "ximo de anos " + ;
                "para comparativo " + CHR(233) + " 6 !"
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDadosIniciais - Carrega SigCdPam, SigCdEmp e moeda padrao
    * Equivale ao Init() legado
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDadosIniciais()
        LOCAL loc_nResult

        IF USED("CrSigCdPam")
            USE IN CrSigCdPam
        ENDIF

        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT moedaps, GrPadClis FROM SigCdPam", "CrSigCdPam")
        IF loc_nResult < 1
            THIS.this_cMensagemErro = "Falha de Conex" + CHR(227) + "o ao carregar " + ;
                "par" + CHR(226) + "metros"
            RETURN .F.
        ENDIF

        SELECT CrSigCdPam
        GO TOP
        THIS.this_cMoedaPadrao = ALLTRIM(CrSigCdPam.moedaps)
        THIS.this_cGrPadClis   = ALLTRIM(CrSigCdPam.GrPadClis)
        THIS.this_cMoeda       = ALLTRIM(CrSigCdPam.moedaps)
        THIS.this_cEmpresa     = go_4c_Sistema.cCodEmpresa

        IF USED("CrSigCdEmp")
            USE IN CrSigCdEmp
        ENDIF

        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT cemps, razas FROM SigCdEmp WHERE cemps = " + ;
            EscaparSQL(go_4c_Sistema.cCodEmpresa), "CrSigCdEmp")
        IF loc_nResult < 1
            THIS.this_cMensagemErro = "Falha de Conex" + CHR(227) + "o ao carregar empresa"
            RETURN .F.
        ENDIF

        SELECT CrSigCdEmp
        GO TOP
        IF !EOF()
            THIS.this_cNmEmpresa = ALLTRIM(CrSigCdEmp.razas)
            THIS.this_cDEmpresa  = ALLTRIM(CrSigCdEmp.razas)
        ENDIF

        IF !EMPTY(THIS.this_cMoedaPadrao)
            IF USED("cursor_4c_MoePad")
                USE IN cursor_4c_MoePad
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT cmoes, dmoes FROM SigCdMoe WHERE cmoes = " + ;
                EscaparSQL(THIS.this_cMoedaPadrao), "cursor_4c_MoePad")
            IF loc_nResult > 0
                SELECT cursor_4c_MoePad
                GO TOP
                IF !EOF()
                    THIS.this_cMoedaDesc = ALLTRIM(cursor_4c_MoePad.dmoes)
                ENDIF
                USE IN cursor_4c_MoePad
            ENDIF
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarTiposOperacao - Carrega cursor CrSigCdTom para o grid do form
    * O form vincula seu grd_4c_Dados a este cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarTiposOperacao()
        LOCAL loc_nResult

        IF USED("CrSigCdTom")
            USE IN CrSigCdTom
        ENDIF

        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT 1 AS nMarca, codigos, " + ;
            "STR(codigos,2) + '-' + descrs AS Descri FROM SigCdTom", ;
            "CrSigCdTom")
        IF loc_nResult < 1
            THIS.this_cMensagemErro = "Falha ao carregar tipos de opera" + ;
                CHR(231) + CHR(227) + "o"
            RETURN .F.
        ENDIF

        SELECT CrSigCdTom
        INDEX ON codigos TAG codigos
        GO TOP
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * checaIBGE - Retorna codigo IBGE de um municipio/UF
    * Equivale ao checaibge() legado
    *--------------------------------------------------------------------------
    PROCEDURE checaIBGE(par_cMun, par_cUF)
        LOCAL loc_nRtC, loc_lcSQL, loc_nResult

        loc_nRtC = 9999999

        loc_lcSQL = "SELECT a.Codigos FROM SigCdMun a, SigCdUfs b " + ;
            "WHERE a.Descs = " + EscaparSQL(PADR(UPPER(par_cMun), 40)) + ;
            " AND a.UFIBGEs = b.UFIBGEs AND b.Estados = " + EscaparSQL(par_cUF)

        loc_nResult = SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_IBGE")
        IF loc_nResult < 1
            RETURN loc_nRtC
        ENDIF

        SELECT cursor_4c_IBGE
        GO TOP
        IF !EOF()
            loc_nRtC = INT(VAL(cursor_4c_IBGE.Codigos))
        ENDIF
        USE IN cursor_4c_IBGE

        RETURN loc_nRtC
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarCotacao - Retorna cotacao de uma moeda em determinada data
    * Tenta chamar fBuscarCotacao legado; retorna 1 se nao disponivel
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BuscarCotacao(par_cMoeda, par_dData)
        LOCAL loc_nCotacao
        loc_nCotacao = 1
        TRY
            loc_nCotacao = fBuscarCotacao(par_cMoeda, par_dData, gnConnHandle)
        CATCH
            loc_nCotacao = 1
        ENDTRY
        RETURN IIF(loc_nCotacao = 0, 1, loc_nCotacao)
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa processamento completo do relatorio
    * Traduz o processamento() legado (~760 linhas)
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso
        LOCAL loc_lcEmp, loc_lcNmOperacao, loc_ldDtInicial, loc_ldFinal
        LOCAL loc_lcMoeda, loc_lnOrdem, loc_lcCconta, loc_lcDconta
        LOCAL loc_lcCVendedor, loc_lcDVendedor, loc_lnQtde, loc_lnQtMin
        LOCAL loc_lcProduto, loc_lnOptComp, loc_lnOptMovCad
        LOCAL loc_lnCid, loc_lnDad, loc_lnVal, loc_lnCompa
        LOCAL loc_lcNmEmpresa, loc_lcNmTitulo, loc_lcNmPeriodo, loc_lcTipo
        LOCAL loc_ldtInicial, loc_ldtFinal
        LOCAL loc_lnAnox, loc_lcStrAno1, loc_lcSql, loc_lnQueryOk
        LOCAL loc_ln_ValTot, loc_lcConta, loc_lnCota1, loc_lnCota2
        LOCAL loc_lcTipoOpe, loc_lcCodigo, loc_lcNome
        LOCAL loc_lcClaCo, loc_lcCGrupo, loc_lcContaV, loc_lcNomeRep, loc_lcDclaco
        LOCAL loc_lBdOk, loc_lErroBD, loc_lnConta, loc_lnMax, loc_lcLista
        LOCAL loc_lcGrava, loc_lcCampo, loc_lcCompra, loc_lcTagVal, loc_lcTagQtd
        LOCAL loc_lcVend, x

        loc_lSucesso = .F.

        TRY
            * Copia filtros de THIS para locais
            loc_lcEmp        = ALLTRIM(THIS.this_cEmpresa)
            loc_lcNmOperacao = ALLTRIM(THIS.this_cNmOperacao)
            loc_ldDtInicial  = THIS.this_dDtInicial
            loc_ldFinal      = THIS.this_dDtFinal
            loc_lcMoeda      = ALLTRIM(THIS.this_cMoeda)
            loc_lnOrdem      = THIS.this_nOrdem
            loc_lcCconta     = ALLTRIM(THIS.this_cCdConta)
            loc_lcDconta     = ALLTRIM(THIS.this_cDsConta)
            loc_lcCVendedor  = ALLTRIM(THIS.this_cCdVendedor)
            loc_lcDVendedor  = ALLTRIM(THIS.this_cDsVendedor)
            loc_lnQtde       = THIS.this_nQtde
            loc_lnQtMin      = THIS.this_nQtMin
            loc_lcProduto    = ALLTRIM(THIS.this_cCdProduto)
            loc_lnOptComp    = THIS.this_nOptCompara
            loc_lnOptMovCad  = THIS.this_nOptMovCad
            loc_lnCid        = THIS.this_nChkCidade
            loc_lnDad        = THIS.this_nChkDadosCli
            loc_lnVal        = THIS.this_nChkValor
            loc_lnCompa      = THIS.this_nComparativo

            * Formata datas como DATETIME para binding ODBC via ?variavel
            loc_ldtInicial = EVALUATE([{^] + ;
                TRANSFORM((DTOS(MAX(loc_ldDtInicial, CTOD("01/01/1900"))) + ;
                "000000"), "@R 9999-99-99 99:99:99") + [}])
            loc_ldtFinal = EVALUATE([{^] + ;
                TRANSFORM((DTOS(MAX(loc_ldFinal, CTOD("01/01/1900"))) + ;
                "235959"), "@R 9999-99-99 99:99:99") + [}])

            * Dados da empresa (CrSigCdEmp carregado em CarregarDadosIniciais)
            IF USED("CrSigCdEmp")
                SELECT CrSigCdEmp
                GO TOP
                loc_lcNmEmpresa = IIF(!EMPTY(CrSigCdEmp.razas), ALLTRIM(CrSigCdEmp.razas), "")
            ELSE
                loc_lcNmEmpresa = THIS.this_cNmEmpresa
            ENDIF

            loc_lcNmTitulo = "Relat" + CHR(243) + "rio de Clientes que " + ;
                IIF(loc_lnOrdem = 1, "Mais", ;
                    IIF(loc_lnOrdem = 2, "Menos", "N" + CHR(227) + "o")) + ;
                " Compram " + PROPER(ALLTRIM(loc_lcNmOperacao) + " ")

            loc_lcNmPeriodo = "Per" + CHR(237) + "odo : " + ;
                DTOC(loc_ldDtInicial) + " " + CHR(224) + " " + DTOC(loc_ldFinal) + " " + ;
                IIF(EMPTY(loc_lcCconta), "", ;
                    "  \ Conta " + ALLTRIM(loc_lcCconta) + " " + ALLTRIM(loc_lcDconta)) + ;
                IIF(EMPTY(loc_lcCVendedor), "", ;
                    CHR(13) + "Vendedor " + ALLTRIM(loc_lcCVendedor) + ;
                    " " + ALLTRIM(loc_lcDVendedor)) + ;
                IIF(EMPTY(loc_lcProduto), "", " \ Produto: " + loc_lcProduto) + ;
                " \ Moeda: [" + loc_lcMoeda + "]"

            loc_lcTipo = IIF(THIS.this_nOptSelRel = 1, "Valor", "Quantidade")

            THIS.this_cNmEmpresa = loc_lcNmEmpresa
            THIS.this_cNmTitulo  = loc_lcNmTitulo
            THIS.this_cNmPeriodo = loc_lcNmPeriodo
            THIS.this_cTipoRel   = loc_lcTipo

            * Numero de anos do periodo (maximo 6)
            loc_lnAnox = MIN((YEAR(loc_ldFinal) - YEAR(loc_ldDtInicial)) + 1, 6)

            *-- Cursor de cabecalho para FRX
            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
            CREATE CURSOR CsCabecalho ( ;
                nm_empresa    C(80),  nm_titulo     C(254), nm_periodo    C(254), ;
                nm_tipo       C(10),  nm_Comparativo N(1),  nm_OptComp    N(1), ;
                nm_Ano1       C(14),  nm_ano2       C(14),  nm_ano3       C(14), ;
                nm_Ano4       C(14),  nm_ano5       C(14),  nm_ano6       C(14))

            INSERT INTO CsCabecalho ;
                (nm_empresa, nm_titulo, nm_periodo, nm_tipo, nm_Comparativo, nm_OptComp) ;
                VALUES (loc_lcNmEmpresa, loc_lcNmTitulo, loc_lcNmPeriodo, ;
                        loc_lcTipo, loc_lnCompa, loc_lnOptComp)

            loc_lcStrAno1 = ""
            SELECT CsCabecalho
            FOR x = 1 TO loc_lnAnox
                loc_lcStrAno1 = loc_lcStrAno1 + ;
                    TRANSFORM(YEAR(loc_ldDtInicial) + x - 1, "@L 9999")
                loc_lcGrava = "nm_ano" + ALLTRIM(STR(x, 2))
                REPLACE &loc_lcGrava. WITH PADC(STR(YEAR(loc_ldDtInicial) + x - 1, 4), 14)
            ENDFOR

            *-- Cursor de resultado principal (TmpResult compativel com FRX legado)
            IF USED("TmpResult")
                USE IN TmpResult
            ENDIF
            CREATE CURSOR TmpResult ( ;
                ordem     N(5),  ciclis    C(10),  crclis    C(50), ;
                nValcomp  N(12,2), nqtde   N(12,2), cunis    C(3), ;
                ncompras  N(6), ;
                nValAno1  N(12,2), nValAno2  N(12,2), nValAno3  N(12,2), ;
                nValAno4  N(12,2), nValAno5  N(12,2), nValAno6  N(12,2), ;
                nQtdAno1  N(12,2), nQtdAno2  N(12,2), nQtdAno3  N(12,2), ;
                nQtdAno4  N(12,2), nQtdAno5  N(12,2), nQtdAno6  N(12,2), ;
                nCompra1  N(5),  nCompra2  N(5),  nCompra3  N(5), ;
                nCompra4  N(5),  nCompra5  N(5),  nCompra6  N(5), ;
                clacos    C(10), ;
                ordem1    N(4),  ordem2    N(4),  ordem3    N(4), ;
                ordem4    N(4),  ordem5    N(4),  ordem6    N(4), ;
                cStrAno1s C(64), cTitulo1s C(64), cTitulo2s C(64), ;
                cTitulo3s C(64), cTitulo4s C(64), cEmpresas C(64), ;
                MaxOrdem  N(4),  Quebras   C(50))

            INDEX ON ciclis                   TAG iclis
            INDEX ON ciclis + cunis           TAG cunis
            INDEX ON Quebras + STR(ordem, 4)  TAG impressao
            INDEX ON nValComp                 TAG nValAsc ASCENDING
            INDEX ON nValComp                 TAG nValDes DESCENDING
            INDEX ON nQtde                    TAG nQtdAsc ASCENDING
            INDEX ON nQtde                    TAG nQtdDes DESCENDING
            INDEX ON nValAno1                 TAG nVal1
            INDEX ON nValAno2                 TAG nVal2
            INDEX ON nValAno3                 TAG nVal3
            INDEX ON nValAno4                 TAG nVal4
            INDEX ON nValAno5                 TAG nVal5
            INDEX ON nValAno6                 TAG nVal6
            INDEX ON nQtdAno1                 TAG nQtd1
            INDEX ON nQtdAno2                 TAG nQtd2
            INDEX ON nQtdAno3                 TAG nQtd3
            INDEX ON nQtdAno4                 TAG nQtd4
            INDEX ON nQtdAno5                 TAG nQtd5
            INDEX ON nQtdAno6                 TAG nQtd6

            loc_lBdOk = .T.

            * ================================================================
            * PROCESSAMENTO POR VALOR
            * ================================================================
            IF THIS.this_nOptSelRel = 1

                loc_lcSql = ;
                    "SELECT a.emps,a.dopes,a.numes,a.empdopnums,a.datas,a.valos," + ;
                    "a.contads,a.contaos," + ;
                    "b.tipoops,b.valpres,b.cmoes,b.caixas,b.copers,b.opers," + ;
                    "b.destinos,b.origems,a.vends " + ;
                    "FROM SigMvCab a, SigCdOpe b " + ;
                    "WHERE a.datas Between ?loc_ldtInicial And ?loc_ldtFinal " + ;
                    "AND a.dopes = b.dopes"
                IF !EMPTY(loc_lcEmp)
                    loc_lcSql = loc_lcSql + " AND a.emps = " + EscaparSQL(loc_lcEmp)
                ENDIF
                IF !EMPTY(loc_lcNmOperacao)
                    loc_lcSql = loc_lcSql + " AND a.dopes = " + EscaparSQL(loc_lcNmOperacao)
                ENDIF
                IF !EMPTY(loc_lcCconta)
                    loc_lcSql = loc_lcSql + ;
                        " AND (a.contaos = " + EscaparSQL(loc_lcCconta) + ;
                        " OR contads = " + EscaparSQL(loc_lcCconta) + ")"
                ENDIF

                IF USED("CrSigMvCab")
                    USE IN CrSigMvCab
                ENDIF
                loc_lnQueryOk = SQLEXEC(gnConnHandle, loc_lcSql, "CrSigMvCab")
                IF loc_lnQueryOk < 1
                    THIS.this_cMensagemErro = "Falha de Conex" + CHR(227) + "o ao " + ;
                        "carregar movimentos"
                    loc_lBdOk = .F.
                ENDIF

                *-- Agrega representantes de venda (SigMvEtv)
                IF loc_lBdOk AND !EMPTY(loc_lcCVendedor)
                    loc_lcSql = ;
                        "SELECT a.emps,a.dopes,a.numes,a.empdopnums,a.datas,a.valos," + ;
                        "a.contads,a.contaos," + ;
                        "b.tipoops,b.valpres,b.cmoes,b.caixas,b.copers,b.opers," + ;
                        "b.destinos,b.origems,e.contas as vends " + ;
                        "FROM SigMvCab a, SigCdOpe b, SigMvEtv e " + ;
                        "WHERE a.datas Between ?loc_ldtInicial And ?loc_ldtFinal " + ;
                        "AND a.dopes = b.dopes AND a.empdopnums = e.empdopnums"
                    IF !EMPTY(loc_lcEmp)
                        loc_lcSql = loc_lcSql + " AND a.emps = " + EscaparSQL(loc_lcEmp)
                    ENDIF
                    IF !EMPTY(loc_lcNmOperacao)
                        loc_lcSql = loc_lcSql + " AND a.dopes = " + EscaparSQL(loc_lcNmOperacao)
                    ENDIF
                    IF !EMPTY(loc_lcCconta)
                        loc_lcSql = loc_lcSql + ;
                            " AND (a.contaos = " + EscaparSQL(loc_lcCconta) + ;
                            " OR contads = " + EscaparSQL(loc_lcCconta) + ")"
                    ENDIF
                    IF USED("cursor_4c_VendX")
                        USE IN cursor_4c_VendX
                    ENDIF
                    loc_lnQueryOk = SQLEXEC(gnConnHandle, loc_lcSql, "cursor_4c_VendX")
                    IF loc_lnQueryOk > 0
                        SELECT cursor_4c_VendX
                        GO TOP
                        SCAN
                            SCATTER MEMVAR MEMO
                            INSERT INTO CrSigMvCab FROM MEMVAR
                        ENDSCAN
                        USE IN cursor_4c_VendX
                    ELSE
                        THIS.this_cMensagemErro = "Falha de Conex" + CHR(227) + ;
                            "o ao carregar representantes"
                        loc_lBdOk = .F.
                    ENDIF
                ENDIF

                *-- Lista de clientes para "Nao Compram"
                IF loc_lBdOk AND loc_lnOrdem = 3
                    IF USED("CrSigCdPam")
                        SELECT CrSigCdPam
                        GO TOP
                        loc_lcSql = "SELECT a.Iclis,a.Rclis,a.ContaVens," + ;
                            "b.Rclis as dVends FROM SigCdCli a " + ;
                            "LEFT JOIN SigCdCli b ON a.ContaVens = b.Iclis " + ;
                            "WHERE a.Grupos = " + EscaparSQL(ALLTRIM(THIS.this_cGrPadClis))
                    ELSE
                        loc_lcSql = "SELECT a.Iclis,a.Rclis,a.ContaVens," + ;
                            "b.Rclis as dVends FROM SigCdCli a " + ;
                            "LEFT JOIN SigCdCli b ON a.ContaVens = b.Iclis " + ;
                            "WHERE 1=1"
                    ENDIF
                    IF USED("TmpCliente")
                        USE IN TmpCliente
                    ENDIF
                    loc_lnQueryOk = SQLEXEC(gnConnHandle, loc_lcSql, "TmpCliente")
                    IF loc_lnQueryOk < 1
                        THIS.this_cMensagemErro = "Falha de Conex" + CHR(227) + ;
                            "o ao carregar clientes"
                        loc_lBdOk = .F.
                    ENDIF
                ENDIF

                *-- SCAN de movimentos de VALOR
                IF loc_lBdOk
                    loc_lErroBD = .F.
                    SELECT CrSigMvCab
                    GO TOP

                    SCAN WHILE !loc_lErroBD
                        *-- Checa tipo de operacao se sem filtro de operacao
                        IF EMPTY(loc_lcNmOperacao)
                            IF ISNULL(CrSigMvCab.TipoOps)
                                LOOP
                            ENDIF
                            loc_lcTipoOpe = ALLTRIM(CrSigMvCab.TipoOps)
                            IF USED("CrSigCdTom")
                                SELECT CrSigCdTom
                                GO TOP
                                =SEEK(loc_lcTipoOpe, "CrSigCdTom", "codigos")
                                IF EOF() OR CrSigCdTom.nMarca = 0
                                    SELECT CrSigMvCab
                                    LOOP
                                ENDIF
                            ENDIF
                        ENDIF

                        *-- Calcula valor total do movimento (com conversao de moeda)
                        loc_ln_ValTot = 0
                        IF INLIST(NVL(CrSigMvCab.valpres, 0), 1, 3)
                            *-- Soma itens do SigMvMov (tipo com detalhe de itens)
                            IF USED("TmpEstMo")
                                USE IN TmpEstMo
                            ENDIF
                            loc_lcSql = "SELECT emps,dopes,numes,valtots,moeds " + ;
                                "FROM SigMvMov " + ;
                                "WHERE emps = " + EscaparSQL(ALLTRIM(CrSigMvCab.emps)) + ;
                                " AND dopes = " + EscaparSQL(ALLTRIM(CrSigMvCab.dopes)) + ;
                                " AND numes = " + ALLTRIM(STR(CrSigMvCab.numes))
                            loc_lnQueryOk = SQLEXEC(gnConnHandle, loc_lcSql, "TmpEstMo")
                            IF loc_lnQueryOk < 1
                                loc_lErroBD = .T.
                            ELSE
                                SELECT TmpEstMo
                                GO TOP
                                IF !EOF()
                                    SCAN
                                        loc_lnCota1 = THIS.BuscarCotacao( ;
                                            ALLTRIM(TmpEstMo.moeds), CrSigMvCab.datas)
                                        loc_lnCota2 = THIS.BuscarCotacao( ;
                                            loc_lcMoeda, CrSigMvCab.datas)
                                        IF loc_lnCota2 <> 0
                                            loc_ln_ValTot = loc_ln_ValTot + ;
                                                TmpEstMo.valtots * (loc_lnCota1 / loc_lnCota2)
                                        ENDIF
                                    ENDSCAN
                                ELSE
                                    SELECT CrSigMvCab
                                    LOOP
                                ENDIF
                            ENDIF
                        ELSE
                            *-- Valor direto do cabecalho
                            IF !EMPTY(CrSigMvCab.cmoes)
                                loc_lnCota1 = THIS.BuscarCotacao( ;
                                    ALLTRIM(CrSigMvCab.cmoes), CrSigMvCab.datas)
                                loc_lnCota2 = THIS.BuscarCotacao( ;
                                    loc_lcMoeda, CrSigMvCab.datas)
                                IF loc_lnCota2 <> 0
                                    loc_ln_ValTot = CrSigMvCab.valos * ;
                                        (loc_lnCota1 / loc_lnCota2)
                                ENDIF
                            ELSE
                                loc_lnCota2 = THIS.BuscarCotacao( ;
                                    loc_lcMoeda, CrSigMvCab.datas)
                                IF loc_lnCota2 <> 0
                                    loc_ln_ValTot = CrSigMvCab.valos / loc_lnCota2
                                ENDIF
                            ENDIF

                            IF ISNULL(CrSigMvCab.caixas)
                                SELECT CrSigMvCab
                                LOOP
                            ENDIF

                            DO CASE
                                CASE CrSigMvCab.caixas = 1
                                    DO CASE
                                        CASE NVL(CrSigMvCab.copers, 0) = 1
                                            loc_ln_ValTot = ABS(loc_ln_ValTot)
                                        CASE NVL(CrSigMvCab.copers, 0) = 2
                                            loc_ln_ValTot = ABS(loc_ln_ValTot) * (-1)
                                        OTHERWISE
                                            SELECT CrSigMvCab
                                            LOOP
                                    ENDCASE
                                CASE CrSigMvCab.caixas <> 1
                                    DO CASE
                                        CASE NVL(CrSigMvCab.opers, 0) = 1
                                            loc_ln_ValTot = ABS(loc_ln_ValTot) * (-1)
                                        CASE NVL(CrSigMvCab.opers, 0) = 2
                                            loc_ln_ValTot = ABS(loc_ln_ValTot)
                                        CASE NVL(CrSigMvCab.opers, 0) = 3
                                            loc_ln_ValTot = 0
                                            IF USED("TprMvCabi")
                                                USE IN TprMvCabi
                                            ENDIF
                                            loc_lcSql = "SELECT emps,dopes,numes,totas " + ;
                                                "FROM SigMvItn WHERE empdopnums = " + ;
                                                EscaparSQL(ALLTRIM(CrSigMvCab.empdopnums))
                                            loc_lnQueryOk = SQLEXEC(gnConnHandle, ;
                                                loc_lcSql, "TprMvCabi")
                                            IF loc_lnQueryOk < 1
                                                loc_lErroBD = .T.
                                            ELSE
                                                SELECT TprMvCabi
                                                GO TOP
                                                IF !EOF()
                                                    SCAN
                                                        IF !EMPTY(CrSigMvCab.cmoes)
                                                            loc_lnCota1 = THIS.BuscarCotacao( ;
                                                                ALLTRIM(CrSigMvCab.cmoes), ;
                                                                CrSigMvCab.datas)
                                                            loc_lnCota2 = THIS.BuscarCotacao( ;
                                                                loc_lcMoeda, CrSigMvCab.datas)
                                                            IF loc_lnCota2 <> 0
                                                                loc_ln_ValTot = loc_ln_ValTot + ;
                                                                    TprMvCabi.totas * ;
                                                                    (loc_lnCota1 / loc_lnCota2)
                                                            ENDIF
                                                        ELSE
                                                            loc_lnCota2 = THIS.BuscarCotacao( ;
                                                                loc_lcMoeda, CrSigMvCab.datas)
                                                            IF loc_lnCota2 <> 0
                                                                loc_ln_ValTot = loc_ln_ValTot + ;
                                                                    TprMvCabi.totas / loc_lnCota2
                                                            ENDIF
                                                        ENDIF
                                                    ENDSCAN
                                                ELSE
                                                    SELECT CrSigMvCab
                                                    LOOP
                                                ENDIF
                                            ENDIF
                                        OTHERWISE
                                            SELECT CrSigMvCab
                                            LOOP
                                    ENDCASE
                            ENDCASE
                        ENDIF

                        IF loc_lErroBD
                            EXIT
                        ENDIF

                        SELECT CrSigMvCab
                        IF loc_lnOptMovCad = 1 AND ;
                            !EMPTY(loc_lcCVendedor) AND ;
                            CrSigMvCab.Vends # loc_lcCVendedor
                            LOOP
                        ENDIF

                        *-- Determina conta do cliente pelo tipo de operacao
                        DO CASE
                            CASE NVL(CrSigMvCab.caixas,0)=1 AND NVL(CrSigMvCab.copers,0)=1
                                loc_lcConta = ALLTRIM(CrSigMvCab.contads)
                            CASE NVL(CrSigMvCab.caixas,0)=1 AND NVL(CrSigMvCab.copers,0)=2
                                loc_lcConta = ALLTRIM(CrSigMvCab.contaos)
                            CASE NVL(CrSigMvCab.destinos, 0) = 1
                                loc_lcConta = ALLTRIM(CrSigMvCab.contads)
                            CASE NVL(CrSigMvCab.origems, 0) = 1
                                loc_lcConta = ALLTRIM(CrSigMvCab.contaos)
                            OTHERWISE
                                loc_lcConta = SPACE(10)
                        ENDCASE

                        IF USED("TmpCli")
                            USE IN TmpCli
                        ENDIF
                        loc_lcSql = "SELECT iclis,rclis,codigos,grupos," + ;
                            "contavens,cidas,estas,tabds FROM SigCdCli " + ;
                            "WHERE iclis = " + EscaparSQL(loc_lcConta)
                        loc_lnQueryOk = SQLEXEC(gnConnHandle, loc_lcSql, "TmpCli")
                        IF loc_lnQueryOk < 1
                            loc_lErroBD = .T.
                            EXIT
                        ENDIF

                        SELECT TmpCli
                        GO TOP
                        IF loc_lnOptMovCad=2 AND !EMPTY(loc_lcCVendedor) AND ;
                            TmpCli.ContaVens # loc_lcCVendedor
                            SELECT CrSigMvCab
                            LOOP
                        ENDIF

                        *-- Determina codigo e nome para agrupamento
                        IF loc_lnCid = 1
                            loc_lcCodigo = PADL(STR(THIS.checaIBGE( ;
                                ALLTRIM(TmpCli.Cidas), ALLTRIM(TmpCli.Estas)), 10), 10)
                            loc_lcNome   = "(" + ALLTRIM(TmpCli.Estas) + ") " + ;
                                ALLTRIM(TmpCli.Cidas)
                        ELSE
                            loc_lcCodigo = loc_lcConta
                            loc_lcNome   = ALLTRIM(TmpCli.rclis)
                            loc_lcClaCo  = ALLTRIM(TmpCli.codigos)
                            loc_lcCGrupo = ALLTRIM(TmpCli.grupos)
                            loc_lcContaV = IIF(loc_lnOptMovCad = 1, ;
                                ALLTRIM(CrSigMvCab.Vends), ALLTRIM(TmpCli.contavens))

                            IF USED("TmpClaCo")
                                USE IN TmpClaCo
                            ENDIF
                            loc_lcSql = "SELECT codigos,descs,grupos FROM SigCdClc " + ;
                                "WHERE codigos = " + EscaparSQL(loc_lcClaCo) + ;
                                " AND grupos = " + EscaparSQL(loc_lcCGrupo)
                            loc_lnQueryOk = SQLEXEC(gnConnHandle, loc_lcSql, "TmpClaCo")
                            IF loc_lnQueryOk < 1
                                loc_lErroBD = .T.
                                EXIT
                            ENDIF

                            IF USED("TmpCli")
                                USE IN TmpCli
                            ENDIF
                            loc_lcSql = "SELECT iclis,rclis FROM SigCdCli " + ;
                                "WHERE iclis = " + EscaparSQL(loc_lcContaV)
                            loc_lnQueryOk = SQLEXEC(gnConnHandle, loc_lcSql, "TmpCli")
                            IF loc_lnQueryOk < 1
                                loc_lErroBD = .T.
                                EXIT
                            ENDIF
                            SELECT TmpCli
                            GO TOP
                            loc_lcNomeRep = ALLTRIM(TmpCli.iclis) + " - " + ;
                                ALLTRIM(TmpCli.rclis)
                            SELECT TmpClaCo
                            GO TOP
                            loc_lcDclaco = ALLTRIM(TmpClaCo.codigos) + " - " + ;
                                ALLTRIM(TmpClaCo.descs)

                            IF USED("TmpCli")
                                USE IN TmpCli
                            ENDIF
                            loc_lcSql = "SELECT iclis,rclis,codigos,grupos,tabds " + ;
                                "FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_lcConta)
                            loc_lnQueryOk = SQLEXEC(gnConnHandle, loc_lcSql, "TmpCli")
                            IF loc_lnQueryOk < 1
                                loc_lErroBD = .T.
                                EXIT
                            ENDIF
                            SELECT TmpCli
                            GO TOP
                            loc_lcCGrupo = ALLTRIM(TmpCli.grupos)
                            loc_lcClaCo  = ALLTRIM(TmpCli.codigos)

                            IF loc_lnCompa = 1
                                IF loc_lnOptComp = 1
                                    loc_lcCodigo = loc_lcConta
                                    loc_lcNome   = ALLTRIM(TmpCli.rclis)
                                ELSE
                                    IF USED("TmpClaCo")
                                        USE IN TmpClaCo
                                    ENDIF
                                    loc_lcSql = "SELECT codigos,descs FROM SigCdClc " + ;
                                        "WHERE codigos = " + EscaparSQL(loc_lcClaCo) + ;
                                        " AND grupos = " + EscaparSQL(loc_lcCGrupo)
                                    loc_lnQueryOk = SQLEXEC(gnConnHandle, loc_lcSql, "TmpClaCo")
                                    IF loc_lnQueryOk < 1
                                        loc_lErroBD = .T.
                                        EXIT
                                    ENDIF
                                    SELECT TmpClaCo
                                    GO TOP
                                    loc_lcCodigo = ALLTRIM(TmpClaCo.codigos)
                                    loc_lcNome   = ALLTRIM(TmpClaCo.descs)
                                ENDIF
                            ENDIF
                        ENDIF

                        *-- Agrega no TmpResult
                        IF !EMPTY(loc_lcCodigo)
                            SELECT TmpResult
                            SET ORDER TO iclis
                            =SEEK(loc_lcCodigo, "TmpResult", "iclis")
                            IF EOF("TmpResult")
                                APPEND BLANK IN TmpResult
                                REPLACE ciclis WITH loc_lcCodigo, ;
                                        cRClis WITH loc_lcNome IN TmpResult
                                IF loc_lnCid = 0
                                    REPLACE Clacos WITH loc_lcClaCo, ;
                                        cTitulo1s WITH "Cliente : " + ;
                                            ALLTRIM(loc_lcCodigo) + " - " + ;
                                            ALLTRIM(loc_lcNome), ;
                                        cTitulo2s WITH "Representante: " + ;
                                            loc_lcNomeRep, ;
                                        cTitulo3s WITH "Tabela : " + ;
                                            ALLTRIM(TmpCli.tabds), ;
                                        cTitulo4s WITH "Classifica" + CHR(231) + ;
                                            CHR(227) + "o: " + loc_lcDclaco ;
                                        IN TmpResult
                                ENDIF
                            ENDIF

                            REPLACE TmpResult.nValComp WITH TmpResult.nValComp + loc_ln_ValTot
                            REPLACE TmpResult.nCompras WITH TmpResult.nCompras + 1

                            FOR x = 1 TO loc_lnAnox
                                IF YEAR(CrSigMvCab.datas) = (YEAR(loc_ldDtInicial) + x - 1)
                                    loc_lcGrava  = "nValAno" + STR(x, 1)
                                    loc_lcCompra = "nCompra" + STR(x, 1)
                                    REPLACE &loc_lcGrava.  WITH &loc_lcGrava.  + loc_ln_ValTot
                                    REPLACE &loc_lcCompra. WITH &loc_lcCompra. + 1
                                    EXIT
                                ENDIF
                            ENDFOR
                        ENDIF

                        SELECT CrSigMvCab
                    ENDSCAN && WHILE !loc_lErroBD

                    IF loc_lErroBD
                        THIS.this_cMensagemErro = "Falha de Conex" + CHR(227) + ;
                            "o ao processar movimentos de valor"
                        loc_lBdOk = .F.
                    ENDIF
                ENDIF && loc_lBdOk

            ELSE

            * ================================================================
            * PROCESSAMENTO POR QUANTIDADE
            * ================================================================

                loc_lcSql = ;
                    "SELECT a.contads,a.contaos,a.vends,b.emps,b.dopes,b.numes,b.cunis," + ;
                    "b.qtds,a.datas,c.tipoops,c.caixas,c.copers,c.destinos,c.origems " + ;
                    "FROM SigMvCab a, SigMvItn b, SigCdOpe c " + ;
                    "WHERE a.datas Between ?loc_ldtInicial And ?loc_ldtFinal"
                IF !EMPTY(loc_lcEmp)
                    loc_lcSql = loc_lcSql + " AND a.emps = " + EscaparSQL(loc_lcEmp)
                ENDIF
                IF !EMPTY(loc_lcNmOperacao)
                    loc_lcSql = loc_lcSql + " AND a.dopes = " + EscaparSQL(loc_lcNmOperacao)
                ENDIF
                IF !EMPTY(loc_lcCconta)
                    loc_lcSql = loc_lcSql + ;
                        " AND a.contads = " + EscaparSQL(loc_lcCconta) + ;
                        " AND a.contaos = " + EscaparSQL(loc_lcCconta)
                ENDIF
                loc_lcSql = loc_lcSql + " AND a.empdopnums = b.empdopnums"
                IF !EMPTY(loc_lcProduto)
                    loc_lcSql = loc_lcSql + " AND b.cpros = " + EscaparSQL(loc_lcProduto)
                ENDIF
                loc_lcSql = loc_lcSql + ;
                    " AND a.dopes = c.dopes ORDER BY a.emps,a.dopes,a.numes,b.cunis"

                IF USED("TmpQuant")
                    USE IN TmpQuant
                ENDIF
                loc_lnQueryOk = SQLEXEC(gnConnHandle, loc_lcSql, "TmpQuant")
                IF loc_lnQueryOk < 1
                    THIS.this_cMensagemErro = "Falha de Conex" + CHR(227) + "o ao " + ;
                        "carregar quantidades"
                    loc_lBdOk = .F.
                ENDIF

                *-- Agrega representantes de venda
                IF loc_lBdOk AND !EMPTY(loc_lcCVendedor)
                    loc_lcSql = ;
                        "SELECT a.contads,a.contaos,e.contas as vends," + ;
                        "b.emps,b.dopes,b.numes,b.cunis," + ;
                        "b.qtds,a.datas,c.tipoops,c.caixas,c.copers,c.destinos,c.origems " + ;
                        "FROM SigMvCab a, SigMvItn b, SigCdOpe c, SigMvEtv e " + ;
                        "WHERE a.datas Between ?loc_ldtInicial And ?loc_ldtFinal"
                    IF !EMPTY(loc_lcEmp)
                        loc_lcSql = loc_lcSql + " AND a.emps = " + EscaparSQL(loc_lcEmp)
                    ENDIF
                    IF !EMPTY(loc_lcNmOperacao)
                        loc_lcSql = loc_lcSql + " AND a.dopes = " + EscaparSQL(loc_lcNmOperacao)
                    ENDIF
                    IF !EMPTY(loc_lcCconta)
                        loc_lcSql = loc_lcSql + ;
                            " AND a.contads = " + EscaparSQL(loc_lcCconta) + ;
                            " AND a.contaos = " + EscaparSQL(loc_lcCconta)
                    ENDIF
                    loc_lcSql = loc_lcSql + ;
                        " AND a.empdopnums = b.empdopnums"
                    IF !EMPTY(loc_lcProduto)
                        loc_lcSql = loc_lcSql + " AND b.cpros = " + EscaparSQL(loc_lcProduto)
                    ENDIF
                    loc_lcSql = loc_lcSql + ;
                        " AND a.dopes = c.dopes AND a.empdopnums = e.empdopnums" + ;
                        " ORDER BY a.emps,a.dopes,a.numes,b.cunis"
                    IF USED("cursor_4c_VendX")
                        USE IN cursor_4c_VendX
                    ENDIF
                    loc_lnQueryOk = SQLEXEC(gnConnHandle, loc_lcSql, "cursor_4c_VendX")
                    IF loc_lnQueryOk > 0
                        SELECT cursor_4c_VendX
                        GO TOP
                        SCAN
                            SCATTER MEMVAR MEMO
                            INSERT INTO TmpQuant FROM MEMVAR
                        ENDSCAN
                        USE IN cursor_4c_VendX
                    ELSE
                        THIS.this_cMensagemErro = "Falha de Conex" + CHR(227) + ;
                            "o ao carregar representantes"
                        loc_lBdOk = .F.
                    ENDIF
                ENDIF

                *-- Lista de clientes para "Nao Compram"
                IF loc_lBdOk AND loc_lnOrdem = 3
                    IF USED("CrSigCdPam")
                        SELECT CrSigCdPam
                        GO TOP
                        loc_lcSql = "SELECT a.Iclis,a.Rclis,a.ContaVens," + ;
                            "b.Rclis as dVends FROM SigCdCli a " + ;
                            "LEFT JOIN SigCdCli b ON a.ContaVens = b.Iclis " + ;
                            "WHERE a.Grupos = " + EscaparSQL(ALLTRIM(THIS.this_cGrPadClis))
                    ELSE
                        loc_lcSql = "SELECT a.Iclis,a.Rclis,a.ContaVens," + ;
                            "b.Rclis as dVends FROM SigCdCli a " + ;
                            "LEFT JOIN SigCdCli b ON a.ContaVens = b.Iclis " + ;
                            "WHERE 1=1"
                    ENDIF
                    IF USED("TmpCliente")
                        USE IN TmpCliente
                    ENDIF
                    loc_lnQueryOk = SQLEXEC(gnConnHandle, loc_lcSql, "TmpCliente")
                    IF loc_lnQueryOk < 1
                        THIS.this_cMensagemErro = "Falha de Conex" + CHR(227) + ;
                            "o ao carregar clientes"
                        loc_lBdOk = .F.
                    ENDIF
                ENDIF

                *-- SCAN de movimentos de QUANTIDADE
                IF loc_lBdOk
                    loc_lErroBD = .F.
                    SELECT TmpQuant
                    GO TOP

                    SCAN WHILE !loc_lErroBD
                        *-- Checa tipo de operacao
                        IF EMPTY(loc_lcNmOperacao)
                            IF ISNULL(TmpQuant.TipoOps)
                                LOOP
                            ENDIF
                            loc_lcTipoOpe = ALLTRIM(TmpQuant.TipoOps)
                            IF USED("CrSigCdTom")
                                SELECT CrSigCdTom
                                GO TOP
                                =SEEK(loc_lcTipoOpe, "CrSigCdTom", "codigos")
                                IF EOF() OR CrSigCdTom.nMarca = 0
                                    SELECT TmpQuant
                                    LOOP
                                ENDIF
                            ENDIF
                            SELECT TmpQuant
                        ENDIF

                        IF ISNULL(TmpQuant.caixas)
                            LOOP
                        ENDIF

                        DO CASE
                            CASE TmpQuant.caixas=1 AND NVL(TmpQuant.copers,0)=1
                                loc_lcConta = ALLTRIM(TmpQuant.contads)
                            CASE TmpQuant.caixas=1 AND NVL(TmpQuant.copers,0)=2
                                loc_lcConta = ALLTRIM(TmpQuant.contaos)
                            CASE NVL(TmpQuant.destinos, 0) = 1
                                loc_lcConta = ALLTRIM(TmpQuant.contads)
                            CASE NVL(TmpQuant.origems, 0) = 1
                                loc_lcConta = ALLTRIM(TmpQuant.contaos)
                            OTHERWISE
                                loc_lcConta = SPACE(10)
                        ENDCASE

                        IF USED("TmpCli")
                            USE IN TmpCli
                        ENDIF
                        loc_lcSql = "SELECT iclis,rclis,codigos,grupos," + ;
                            "contavens,cidas,estas,tabds FROM SigCdCli " + ;
                            "WHERE iclis = " + EscaparSQL(loc_lcConta)
                        loc_lnQueryOk = SQLEXEC(gnConnHandle, loc_lcSql, "TmpCli")
                        IF loc_lnQueryOk < 1
                            loc_lErroBD = .T.
                            EXIT
                        ENDIF
                        SELECT TmpCli
                        GO TOP

                        IF loc_lnCid = 1
                            loc_lcCodigo = PADL(STR(THIS.checaIBGE( ;
                                ALLTRIM(TmpCli.Cidas), ALLTRIM(TmpCli.Estas)), 10), 10)
                            loc_lcNome   = "(" + ALLTRIM(TmpCli.Estas) + ") " + ;
                                ALLTRIM(TmpCli.Cidas)
                        ELSE
                            loc_lcCodigo = loc_lcConta
                            loc_lcNome   = ALLTRIM(TmpCli.rclis)
                            loc_lcClaCo  = ALLTRIM(TmpCli.codigos)
                            loc_lcCGrupo = ALLTRIM(TmpCli.grupos)
                            loc_lcContaV = IIF(loc_lnOptMovCad=1, ;
                                ALLTRIM(TmpQuant.Vends), ALLTRIM(TmpCli.contavens))

                            IF loc_lnOptMovCad=1 AND !EMPTY(loc_lcCVendedor) AND ;
                                TmpQuant.Vends # loc_lcCVendedor
                                SELECT TmpQuant
                                LOOP
                            ENDIF
                            IF loc_lnOptMovCad=2 AND !EMPTY(loc_lcCVendedor) AND ;
                                TmpCli.ContaVens # loc_lcCVendedor
                                SELECT TmpQuant
                                LOOP
                            ENDIF

                            IF USED("TmpClaCo")
                                USE IN TmpClaCo
                            ENDIF
                            loc_lcSql = "SELECT codigos,descs,grupos FROM SigCdClc " + ;
                                "WHERE codigos = " + EscaparSQL(loc_lcClaCo) + ;
                                " AND grupos = " + EscaparSQL(loc_lcCGrupo)
                            loc_lnQueryOk = SQLEXEC(gnConnHandle, loc_lcSql, "TmpClaCo")
                            IF loc_lnQueryOk < 1
                                loc_lErroBD = .T.
                                EXIT
                            ENDIF

                            IF USED("TmpCli")
                                USE IN TmpCli
                            ENDIF
                            loc_lcSql = "SELECT iclis,rclis FROM SigCdCli " + ;
                                "WHERE iclis = " + EscaparSQL(loc_lcContaV)
                            loc_lnQueryOk = SQLEXEC(gnConnHandle, loc_lcSql, "TmpCli")
                            IF loc_lnQueryOk < 1
                                loc_lErroBD = .T.
                                EXIT
                            ENDIF
                            SELECT TmpCli
                            GO TOP
                            loc_lcNomeRep = ALLTRIM(TmpCli.iclis) + " - " + ;
                                ALLTRIM(TmpCli.rclis)
                            SELECT TmpClaCo
                            GO TOP
                            loc_lcDclaco = ALLTRIM(TmpClaCo.codigos) + " - " + ;
                                ALLTRIM(TmpClaCo.descs)

                            IF USED("TmpCli")
                                USE IN TmpCli
                            ENDIF
                            loc_lcSql = "SELECT iclis,rclis,codigos,grupos,tabds " + ;
                                "FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_lcConta)
                            loc_lnQueryOk = SQLEXEC(gnConnHandle, loc_lcSql, "TmpCli")
                            IF loc_lnQueryOk < 1
                                loc_lErroBD = .T.
                                EXIT
                            ENDIF
                            SELECT TmpCli
                            GO TOP
                            loc_lcCGrupo = ALLTRIM(TmpCli.grupos)
                            loc_lcClaCo  = ALLTRIM(TmpCli.codigos)

                            IF loc_lnCompa = 1
                                IF loc_lnOptComp = 1
                                    loc_lcCodigo = loc_lcConta
                                    loc_lcNome   = ALLTRIM(TmpCli.rclis)
                                ELSE
                                    IF USED("TmpClaCo")
                                        USE IN TmpClaCo
                                    ENDIF
                                    loc_lcSql = "SELECT codigos,descs FROM SigCdClc " + ;
                                        "WHERE codigos = " + EscaparSQL(loc_lcClaCo) + ;
                                        " AND grupos = " + EscaparSQL(loc_lcCGrupo)
                                    loc_lnQueryOk = SQLEXEC(gnConnHandle, loc_lcSql, "TmpClaCo")
                                    IF loc_lnQueryOk < 1
                                        loc_lErroBD = .T.
                                        EXIT
                                    ENDIF
                                    SELECT TmpClaCo
                                    GO TOP
                                    loc_lcCodigo = ALLTRIM(TmpClaCo.codigos)
                                    loc_lcNome   = ALLTRIM(TmpClaCo.descs)
                                ENDIF
                            ENDIF
                        ENDIF

                        *-- Agrega quantidade no TmpResult
                        SELECT TmpQuant
                        IF TmpQuant.Qtds > 0 AND !EMPTY(loc_lcCodigo)
                            SELECT TmpResult
                            SET ORDER TO cunis
                            IF loc_lnCompa = 1
                                =SEEK(loc_lcCodigo, "TmpResult", "cunis")
                            ELSE
                                =SEEK(loc_lcCodigo + ALLTRIM(TmpQuant.cunis), "TmpResult", "cunis")
                            ENDIF

                            IF EOF("TmpResult")
                                APPEND BLANK IN TmpResult
                                REPLACE ciclis WITH loc_lcCodigo, ;
                                        cRClis WITH loc_lcNome, ;
                                        CUnis  WITH ALLTRIM(TmpQuant.CUnis) IN TmpResult
                                IF loc_lnCid = 0
                                    REPLACE Clacos WITH loc_lcClaCo, ;
                                        cTitulo1s WITH "Cliente : " + ;
                                            ALLTRIM(loc_lcCodigo) + " - " + ;
                                            ALLTRIM(loc_lcNome), ;
                                        cTitulo2s WITH "Representante: " + ;
                                            loc_lcNomeRep, ;
                                        cTitulo3s WITH "Tabela : " + ;
                                            ALLTRIM(TmpCli.tabds), ;
                                        cTitulo4s WITH "Classifica" + CHR(231) + ;
                                            CHR(227) + "o: " + loc_lcDclaco ;
                                        IN TmpResult
                                ENDIF
                            ENDIF

                            REPLACE TmpResult.nqtde WITH TmpResult.nqtde + TmpQuant.qtds

                            FOR x = 1 TO loc_lnAnox
                                IF YEAR(TmpQuant.datas) = (YEAR(loc_ldDtInicial) + x - 1)
                                    loc_lcGrava = "nQtdAno" + STR(x, 1)
                                    REPLACE &loc_lcGrava. WITH &loc_lcGrava. + TmpQuant.qtds
                                    EXIT
                                ENDIF
                            ENDFOR
                        ENDIF

                        SELECT TmpQuant
                    ENDSCAN && WHILE !loc_lErroBD

                    IF loc_lErroBD
                        THIS.this_cMensagemErro = "Falha de Conex" + CHR(227) + ;
                            "o ao processar quantidades"
                        loc_lBdOk = .F.
                    ENDIF
                ENDIF && loc_lBdOk

            ENDIF && this_nOptSelRel = 1 / ELSE

            * ================================================================
            * POS-PROCESSAMENTO: ORDENACAO E RANKING
            * ================================================================
            IF loc_lBdOk
                SELECT TmpResult
                GO TOP
                DELETE FOR EMPTY(ciclis) AND loc_lnOptComp = 2 AND loc_lnCompa = 1

                *-- Calcula ranking por ano (1 a 6)
                FOR x = 1 TO 6
                    loc_lcTagVal = "nVal" + STR(x, 1)
                    loc_lcTagQtd = "nQtd" + STR(x, 1)

                    IF loc_lnOrdem = 1  && Mais Compram
                        IF THIS.this_nOptSelRel = 1
                            SET ORDER TO TAG &loc_lcTagVal DESCENDING
                        ELSE
                            SET ORDER TO TAG &loc_lcTagQtd DESCENDING
                        ENDIF
                    ELSE  && Menos Compram
                        IF THIS.this_nOptSelRel = 1
                            SET ORDER TO TAG &loc_lcTagVal ASCENDING
                        ELSE
                            SET ORDER TO TAG &loc_lcTagQtd ASCENDING
                        ENDIF
                    ENDIF

                    loc_lnConta = 0
                    SELECT TmpResult
                    GO TOP
                    SCAN
                        loc_lnConta = loc_lnConta + 1
                        loc_lcGrava  = "TmpResult.Ordem" + STR(x, 1)
                        loc_lcTagVal = "nValAno" + STR(x, 1)
                        loc_lcTagQtd = "nQtdAno" + STR(x, 1)
                        REPLACE &loc_lcGrava. WITH loc_lnConta
                        IF (THIS.this_nOptSelRel = 1 AND &loc_lcTagVal. = 0) OR ;
                           (THIS.this_nOptSelRel = 2 AND &loc_lcTagQtd. = 0)
                            loc_lnConta = loc_lnConta - 1
                        ENDIF
                    ENDSCAN
                ENDFOR

                *-- MaxOrdem por registro
                SELECT TmpResult
                GO TOP
                SCAN
                    loc_lnMax = 0
                    loc_lnMax = MAX(loc_lnMax, TmpResult.ordem1)
                    loc_lnMax = MAX(loc_lnMax, TmpResult.ordem2)
                    loc_lnMax = MAX(loc_lnMax, TmpResult.ordem3)
                    loc_lnMax = MAX(loc_lnMax, TmpResult.ordem4)
                    loc_lnMax = MAX(loc_lnMax, TmpResult.ordem5)
                    loc_lnMax = MAX(loc_lnMax, TmpResult.ordem6)
                    REPLACE TmpResult.maxordem WITH loc_lnMax
                ENDSCAN

                *-- Ordem final global
                SELECT TmpResult
                IF loc_lnOrdem = 1  && Mais compram
                    IF THIS.this_nOptSelRel = 1
                        SET ORDER TO TAG nValDes
                    ELSE
                        SET ORDER TO TAG nQtdDes
                    ENDIF
                ELSE  && Menos compram
                    IF THIS.this_nOptSelRel = 1
                        SET ORDER TO TAG nValAsc
                    ELSE
                        SET ORDER TO TAG nQtdAsc
                    ENDIF
                ENDIF

                SELECT TmpResult
                loc_lnConta = 0
                SCAN
                    loc_lnConta = loc_lnConta + 1
                    REPLACE TmpResult.ordem     WITH loc_lnConta
                    REPLACE TmpResult.cStrAno1s WITH loc_lcStrAno1
                    REPLACE TmpResult.cEmpresas WITH loc_lcNmEmpresa
                ENDSCAN

                *-- Aplica filtro de valor/quantidade minimo
                IF loc_lnQtMin <> 0
                    IF THIS.this_nOptSelRel = 1
                        DELETE FOR TmpResult.nValComp < loc_lnQtMin
                    ELSE
                        DELETE FOR TmpResult.nqtde < loc_lnQtMin
                    ENDIF
                    GO TOP
                ENDIF

                *-- Aplica limite de quantidade de registros (exceto Nao Compram)
                IF loc_lnQtde <> 0 AND loc_lnOrdem <> 3
                    DELETE FOR TmpResult.ordem > loc_lnQtde
                ENDIF

                *-- "Nao Compram": substitui TmpResult pelos clientes ausentes
                IF loc_lnOrdem = 3
                    IF USED("cursor_4c_Selecao")
                        USE IN cursor_4c_Selecao
                    ENDIF
                    SELECT * FROM TmpCliente ;
                        WHERE Iclis NOT IN (SELECT cIclis FROM TmpResult) ;
                        ORDER BY ContaVens, Iclis ;
                        INTO CURSOR cursor_4c_Selecao READWRITE

                    IF !EMPTY(loc_lcCVendedor)
                        DELETE FROM cursor_4c_Selecao WHERE ContaVens <> loc_lcCVendedor
                    ENDIF

                    ZAP IN TmpResult
                    loc_lnConta = 0
                    SELECT cursor_4c_Selecao
                    GO TOP
                    loc_lcVend = SPACE(10)
                    SCAN
                        SCATTER MEMVAR
                        IF m.ContaVens <> loc_lcVend
                            loc_lnConta = 0
                            loc_lcVend  = m.ContaVens
                        ENDIF
                        loc_lnConta = loc_lnConta + 1
                        INSERT INTO TmpResult (Quebras, ciclis, cRclis, Ordem) ;
                            VALUES (m.ContaVens + " - " + NVL(m.Dvends, ""), ;
                                    m.Iclis, m.Rclis, loc_lnConta)
                    ENDSCAN

                    IF USED("cursor_4c_Selecao")
                        USE IN cursor_4c_Selecao
                    ENDIF
                ENDIF

                *-- "Dados do Cliente" (relatorio SigReCm3): amplia TmpResult com dados CLI
                IF loc_lnDad = 1 AND RECCOUNT("TmpResult") > 0
                    SELECT TmpResult
                    GO TOP
                    loc_lcLista = " AND iclis in ('"
                    SCAN
                        loc_lcLista = loc_lcLista + ALLTRIM(TmpResult.ciclis) + "',"
                    ENDSCAN
                    loc_lcLista = SUBSTR(loc_lcLista, 1, LEN(loc_lcLista) - 2) + ") "

                    IF !EMPTY(loc_lcLista)
                        IF USED("crCli")
                            USE IN crCli
                        ENDIF
                        loc_lnQueryOk = SQLEXEC(gnConnHandle, ;
                            "SELECT iclis,rclis,razaos,cidas,estas," + ;
                            "contato,emails,tel1s FROM SigCdCli WHERE 1=1 " + ;
                            loc_lcLista, "crCli")
                        IF loc_lnQueryOk > 0
                            SELECT a.*, b.* FROM TmpResult a, crCli b ;
                                WHERE a.ciclis = b.iclis ;
                                INTO CURSOR TmpResult READWRITE
                            IF USED("crCli")
                                USE IN crCli
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF

                *-- Ordena final por impressao
                SELECT TmpResult
                INDEX ON Quebras + STR(ordem, 4) TAG impressao
                SET ORDER TO impressao
                GO TOP

                loc_lSucesso = .T.
            ENDIF && loc_lBdOk
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime relatorio para a impressora
    * Seleciona FRX baseado em Comparativo e Dados do Cliente
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_cFRX, loc_cCaminho
        loc_lSucesso = .F.

        IF !THIS.PrepararDados()
            MsgErro(THIS.ObterMensagemErro(), "Erro ao preparar relat" + CHR(243) + "rio")
            RETURN .F.
        ENDIF

        TRY
            loc_cCaminho = gc_4c_CaminhoReports

            IF THIS.this_nComparativo = 1
                loc_cFRX = loc_cCaminho + "SigReCm2.frx"
            ELSE
                IF THIS.this_nChkDadosCli = 1
                    loc_cFRX = loc_cCaminho + "SigReCm3.frx"
                ELSE
                    loc_cFRX = loc_cCaminho + "SigReCm1.frx"
                ENDIF
            ENDIF

            IF FILE(loc_cFRX)
                REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
            ELSE
                MsgAviso("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                    "o encontrado: " + loc_cFRX, "Aviso")
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao imprimir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe preview do relatorio na tela
    * Seleciona FRX baseado em Comparativo e Dados do Cliente
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_cFRX, loc_cCaminho
        loc_lSucesso = .F.

        IF !THIS.PrepararDados()
            MsgErro(THIS.ObterMensagemErro(), "Erro ao preparar relat" + CHR(243) + "rio")
            RETURN .F.
        ENDIF

        TRY
            loc_cCaminho = gc_4c_CaminhoReports

            IF THIS.this_nComparativo = 1
                loc_cFRX = loc_cCaminho + "SigReCm2.frx"
            ELSE
                IF THIS.this_nChkDadosCli = 1
                    loc_cFRX = loc_cCaminho + "SigReCm3.frx"
                ELSE
                    loc_cFRX = loc_cCaminho + "SigReCm1.frx"
                ENDIF
            ENDIF

            IF FILE(loc_cFRX)
                REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
            ELSE
                MsgAviso("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                    "o encontrado: " + loc_cFRX, "Aviso")
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao visualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega valores de filtros a partir de cursor
    * Util para restaurar parametros salvos de execucao anterior do relatorio
    * Mapeia TODAS as colunas correspondentes aos filtros
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_aCampos, loc_nQtdCampos, loc_nIdx, loc_cNomeCampo

        loc_lSucesso = .F.

        IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor inv" + CHR(225) + "lido ou n" + ;
                CHR(227) + "o aberto: " + par_cAliasCursor
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)
            IF EOF()
                THIS.this_cMensagemErro = "Cursor vazio: " + par_cAliasCursor
                loc_lSucesso = .F.
            ENDIF

            *-- Coleta lista de campos disponiveis no cursor
            DIMENSION loc_aCampos[1]
            loc_nQtdCampos = AFIELDS(loc_aCampos, par_cAliasCursor)

            *-- Mapeia cada campo do cursor para a propriedade THIS.this_* correspondente
            FOR loc_nIdx = 1 TO loc_nQtdCampos
                loc_cNomeCampo = UPPER(ALLTRIM(loc_aCampos[loc_nIdx, 1]))

                DO CASE
                    CASE loc_cNomeCampo == "EMPRESA" OR loc_cNomeCampo == "EMPS" OR loc_cNomeCampo == "CEMPS"
                        THIS.this_cEmpresa = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "C")
                    CASE loc_cNomeCampo == "DEMPRESA" OR loc_cNomeCampo == "RAZAS"
                        THIS.this_cDEmpresa = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "C")
                    CASE loc_cNomeCampo == "NMOPERACAO" OR loc_cNomeCampo == "DOPES"
                        THIS.this_cNmOperacao = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "C")
                    CASE loc_cNomeCampo == "DTINICIAL" OR loc_cNomeCampo == "DATA_INI"
                        THIS.this_dDtInicial = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "D")
                    CASE loc_cNomeCampo == "DTFINAL" OR loc_cNomeCampo == "DATA_FIM"
                        THIS.this_dDtFinal = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "D")
                    CASE loc_cNomeCampo == "MOEDA" OR loc_cNomeCampo == "CMOES"
                        THIS.this_cMoeda = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "C")
                    CASE loc_cNomeCampo == "MOEDADESC" OR loc_cNomeCampo == "DMOES"
                        THIS.this_cMoedaDesc = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "C")
                    CASE loc_cNomeCampo == "QTDE"
                        THIS.this_nQtde = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "N")
                    CASE loc_cNomeCampo == "QTMIN"
                        THIS.this_nQtMin = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "N")
                    CASE loc_cNomeCampo == "CDCONTA" OR loc_cNomeCampo == "CDESTOQUE"
                        THIS.this_cCdConta = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "C")
                    CASE loc_cNomeCampo == "DSCONTA" OR loc_cNomeCampo == "DSESTOQUE"
                        THIS.this_cDsConta = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "C")
                    CASE loc_cNomeCampo == "CDVENDEDOR"
                        THIS.this_cCdVendedor = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "C")
                    CASE loc_cNomeCampo == "DSVENDEDOR"
                        THIS.this_cDsVendedor = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "C")
                    CASE loc_cNomeCampo == "CDPRODUTO" OR loc_cNomeCampo == "CPROS"
                        THIS.this_cCdProduto = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "C")
                    CASE loc_cNomeCampo == "DSPRODUTO" OR loc_cNomeCampo == "DPROS"
                        THIS.this_cDsProduto = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "C")
                    CASE loc_cNomeCampo == "ORDEM"
                        THIS.this_nOrdem = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "N")
                    CASE loc_cNomeCampo == "OPTSELREL"
                        THIS.this_nOptSelRel = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "N")
                    CASE loc_cNomeCampo == "OPTCOMPARA"
                        THIS.this_nOptCompara = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "N")
                    CASE loc_cNomeCampo == "OPTMOVCAD"
                        THIS.this_nOptMovCad = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "N")
                    CASE loc_cNomeCampo == "COMPARATIVO"
                        THIS.this_nComparativo = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "N")
                    CASE loc_cNomeCampo == "CHKCIDADE"
                        THIS.this_nChkCidade = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "N")
                    CASE loc_cNomeCampo == "CHKDADOSCLI"
                        THIS.this_nChkDadosCli = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "N")
                    CASE loc_cNomeCampo == "CHKVALOR"
                        THIS.this_nChkValor = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "N")
                ENDCASE
            ENDFOR

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar do cursor: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificador unico da execucao do relatorio
    * Para relatorios, a "chave" e a combinacao filtros + data de geracao
    * Usado para auditoria e log de execucao
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "SIGRECMC|" + ;
            ALLTRIM(THIS.this_cEmpresa) + "|" + ;
            DTOC(THIS.this_dDtInicial) + "|" + ;
            DTOC(THIS.this_dDtFinal) + "|" + ;
            ALLTRIM(STR(THIS.this_nOrdem)) + "|" + ;
            ALLTRIM(STR(THIS.this_nOptSelRel)) + "|" + ;
            ALLTRIM(THIS.this_cMoeda)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio na tabela LogAuditoria
    * Operacoes possiveis: VISUALIZAR, IMPRIMIR, EXPORTAR
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cChave, loc_cUsuario

        loc_lSucesso = .F.

        IF EMPTY(par_cOperacao)
            RETURN .F.
        ENDIF

        TRY
            loc_cChave   = THIS.ObterChavePrimaria()
            loc_cUsuario = IIF(VARTYPE(gc_4c_UsuarioLogado) = "C", ;
                ALLTRIM(gc_4c_UsuarioLogado), "SISTEMA")

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                "(Usuario, DataHora, Tabela, Operacao, ChaveRegistro, DadosNovos) " + ;
                "VALUES (" + ;
                EscaparSQL(loc_cUsuario) + ", " + ;
                "GETDATE(), " + ;
                EscaparSQL("SIGRECMC") + ", " + ;
                EscaparSQL(ALLTRIM(par_cOperacao)) + ", " + ;
                EscaparSQL(LEFT(loc_cChave, 100)) + ", " + ;
                EscaparSQL("Relat" + CHR(243) + "rio Clientes Mais/Menos/N" + ;
                    CHR(227) + "o Compram - " + ;
                    "Per" + CHR(237) + "odo: " + DTOC(THIS.this_dDtInicial) + ;
                    " a " + DTOC(THIS.this_dDtFinal)) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha ao registrar auditoria"
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro auditoria: " + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
