*------------------------------------------------------------------------------
* sigprccpBO.prg - Business Object: Recalculo de Precos
* Entidade  : sigprccp
* Tabela    : SigPrCpo (composicao de preco / producao)
* Tipo      : OPERACIONAL
* Task 262  - Migracao SIGPRCCP
* Fase 1/8  - Propriedades e Init
*------------------------------------------------------------------------------
DEFINE CLASS sigprccpBO AS BusinessBase

    *-- Configuracao base
    this_cTabela            = "SigPrCpo"
    this_cCampoChave        = "cIdChaves"

    *-- Controle de execucao
    this_lAutomatico        = .F.
    this_cEmpresa           = ""

    *-- Cursor principal do grid de produtos
    *-- CREATE CURSOR cursor_4c_Produtos (lMarca N(1), CPros C(14), DPros C(40),
    *--   ValAnt N(14,2), ValAtu N(14,2), CustoAfs N(12,4), CustoFs N(12,4),
    *--   PVarias N(8,2), CVarias N(8,2))
    this_cCursorProdutos    = "cursor_4c_Produtos"

    *-- =========================================================
    *-- FILTROS - Fornecedor (SigCdCli.IClis / RClis)
    *-- =========================================================
    this_cCFornecs          = ""
    this_cDFornecs          = ""

    *-- =========================================================
    *-- FILTROS - Grande Grupo (ini/fim) -> SigCdGpr.Codigos / SigCdPro.Mercs
    *-- =========================================================
    this_cMercI             = ""
    this_cMercF             = ""

    *-- =========================================================
    *-- FILTROS - Grupo (ini/fim) -> SigCdGrp.CGrus
    *-- =========================================================
    this_cCGrui             = ""
    this_cCGruf             = ""

    *-- =========================================================
    *-- FILTROS - Subgrupo (ini/fim) -> SigCdPsg.Codigos (MaxLength=6)
    *-- =========================================================
    this_cSGruI             = ""
    this_cSGruF             = ""

    *-- =========================================================
    *-- FILTROS - Unidade (ini/fim) -> SigCdUni.CUnis (MaxLength=3)
    *-- =========================================================
    this_cCUniI             = ""
    this_cCUnif             = ""

    *-- =========================================================
    *-- FILTROS - Linha (ini/fim) -> SigCdLin.Linhas
    *-- =========================================================
    this_cLini              = ""
    this_cLinf              = ""

    *-- =========================================================
    *-- FILTROS - Colecao (ini/fim) -> SigCdCol.Colecoes
    *-- =========================================================
    this_cColi              = ""
    this_cColf              = ""

    *-- =========================================================
    *-- FILTROS - Moeda (ini/fim) -> SigCdMoe.CMoes (MaxLength=3)
    *-- =========================================================
    this_cMoedai            = ""
    this_cMoedaf            = ""

    *-- =========================================================
    *-- FILTROS - Markup numerico (ini/fim) -> SigCdPro.Margems
    *-- =========================================================
    this_nMrki              = 0
    this_nMrkf              = 0

    *-- =========================================================
    *-- FILTROS - Encargo percentual (ini/fim) -> SigCdPro.Encargos
    *-- =========================================================
    this_nEnci              = 0
    this_nEncf              = 0

    *-- =========================================================
    *-- FILTROS - Variacao minima exibida no grid (%)
    *-- Produtos com PVarias < nVariacao sao excluidos do resultado
    *-- =========================================================
    this_nVariacao          = 0

    *-- =========================================================
    *-- FILTROS - Feitio/MKP base -> SigPrFti.Cods (MaxLength=2)
    *-- =========================================================
    this_cFeitio            = ""

    *-- =========================================================
    *-- FILTROS - Situacao do produto (1=Todos, 2=Ativos, 3=Inativos)
    *-- Mapeia Opc_situacao.Value -> SigCdPro.Situas
    *-- =========================================================
    this_nOpcSituacao       = 1

    *-- =========================================================
    *-- FILTROS - Tipo de moeda para calculo (1=Ideal/Moedas, 2=Venda/Moevs)
    *-- Mapeia fwoption1.Value
    *-- =========================================================
    this_nOpcMoedaTp        = 1

    *-- =========================================================
    *-- FILTROS - Compra (1=Comprar, 2=Nao Comprar, 3=Todos)
    *-- Mapeia Opc_Compra.Value -> SigCdPro.ForaLinha
    *-- =========================================================
    this_nOpcCompra         = 3

    *-- =========================================================
    *-- PARAMETROS DE PROCESSAMENTO
    *-- =========================================================

    *-- Tipo de recalculo (1-8):
    *-- 1=Composicao, 2=Custo Venda, 3=Ambos, 4=Peso Componentes,
    *-- 5=Cambio, 6=Cambio (Inteiros), 7=Markup Custo, 8=Markup Venda
    *-- Mapeia Opc_Recalc.Value -> SigCdCcp.opcrecalc
    this_nOpcRecalc         = 1

    *-- Reajuste percentual aplicado ao preco (%) -> Get_Reajuste
    *-- SigCdCcp.reajuste
    this_nReajuste          = 0

    *-- Novo encargo percentual -> get_Encargo
    *-- SigCdCcp.encargo
    this_nEncargo           = 0

    *-- Novo markup percentual -> GetnMrk
    *-- SigCdCcp.nmrk
    this_nNMrk              = 0

    *-- Atualiza valor de venda (1=Sim, 2=Nao) -> Opc_pven (default=2=Nao)
    *-- SigCdCcp.opcpven
    this_nOpcPven           = 2

    *-- Novo codigo de feitio/MKP (MaxLength=2) -> getNewMkp
    *-- SigCdCcp.newmkp | Obrigatorio quando nOpcRecalc IN (7,8)
    this_cNewMkp            = ""

    *-- Chave primaria da configuracao carregada em SigCdCcp.cIdChaves
    *-- Preenchida por CarregarDoCursor / Inserir. Vazia quando a configuracao
    *-- ainda nao foi persistida (recalculo pontual sem salvar).
    this_cIdChaves          = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = DODEFAULT()

            IF loc_lSucesso
                THIS.this_cTabela     = "SigPrCpo"
                THIS.this_cCampoChave = "cIdChaves"
                THIS.this_cEmpresa    = go_4c_Sistema.cCodEmpresa
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
    *-- Retorna cIdChaves da configuracao SigCdCcp corrente ou string vazia.
    *--------------------------------------------------------------------------
        RETURN ALLTRIM(THIS.this_cIdChaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION AgregarFiltroRange(par_cWhere, par_cCampo, par_cInicio, par_cFinal)
    *--------------------------------------------------------------------------
        LOCAL loc_cResultado
        loc_cResultado = par_cWhere

        IF !EMPTY(par_cInicio) OR !EMPTY(par_cFinal)
            IF !EMPTY(ALLTRIM(loc_cResultado))
                loc_cResultado = loc_cResultado + " And "
            ENDIF
            IF EMPTY(par_cInicio)
                loc_cResultado = loc_cResultado + par_cCampo + " <= '" + par_cFinal + "'"
            ELSE
                IF EMPTY(par_cFinal)
                    loc_cResultado = loc_cResultado + par_cCampo + " >= '" + par_cInicio + "'"
                ELSE
                    loc_cResultado = loc_cResultado + par_cCampo + ;
                        " Between '" + par_cInicio + "' And '" + par_cFinal + "'"
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_cResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    PROCEDURE InicializarCursores()
    *-- Carrega lookups e cria cursores de trabalho. Chamado pelo Form.Init().
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF gnConnHandle <= 0
                MsgErro("Sem conex" + CHR(227) + "o com o banco de dados.", "Erro sigprccpBO")
                IF USED(THIS.this_cCursorProdutos)
                    USE IN (THIS.this_cCursorProdutos)
                ENDIF
                SET NULL ON
                CREATE CURSOR cursor_4c_Produtos ;
                    (lMarca N(1) NULL, CPros C(14) NULL, DPros C(40) NULL, ;
                    ValAnt N(14,2) NULL, ValAtu N(14,2) NULL, ;
                    CustoAfs N(12,4) NULL, CustoFs N(12,4) NULL, ;
                    PVarias N(8,2) NULL, CVarias N(8,2) NULL)
                SET NULL OFF
                INDEX ON CPros TAG CPros
                SELECT cursor_4c_Produtos
                GO TOP
                loc_lSucesso = .T.
            ELSE
                loc_lSucesso = .T.

                IF USED("crSigCdMoe")
                    USE IN crSigCdMoe
                ENDIF
                IF SQLEXEC(gnConnHandle, "SELECT * FROM SigCdMoe", "crSigCdMoe") < 1
                    MsgErro("Falha ao carregar SigCdMoe.", "Erro sigprccpBO.InicializarCursores")
                    loc_lSucesso = .F.
                ELSE
                    SELECT crSigCdMoe
                    INDEX ON CMoes TAG CMoes
                    INDEX ON DMoes TAG DMoes
                    GO TOP
                ENDIF

                IF loc_lSucesso
                    IF USED("crSigCdCot")
                        USE IN crSigCdCot
                    ENDIF
                    IF SQLEXEC(gnConnHandle, "SELECT * FROM SigCdCot", "crSigCdCot") < 1
                        MsgErro("Falha ao carregar SigCdCot.", "Erro sigprccpBO.InicializarCursores")
                        loc_lSucesso = .F.
                    ELSE
                        SELECT crSigCdCot
                        INDEX ON CMoes + DTOS(Datas) + Horas TAG Cotacaos
                        INDEX ON CMoes + DTOS(Datas) TAG CMoeData
                        GO TOP
                    ENDIF
                ENDIF

                IF loc_lSucesso
                    IF USED("crSigCdGrp")
                        USE IN crSigCdGrp
                    ENDIF
                    IF SQLEXEC(gnConnHandle, "SELECT * FROM SigCdGrp", "crSigCdGrp") < 1
                        MsgErro("Falha ao carregar SigCdGrp.", "Erro sigprccpBO.InicializarCursores")
                        loc_lSucesso = .F.
                    ELSE
                        SELECT crSigCdGrp
                        INDEX ON CGrus TAG CGrus
                        GO TOP
                    ENDIF
                ENDIF

                IF loc_lSucesso
                    IF USED("crSigCdUni")
                        USE IN crSigCdUni
                    ENDIF
                    IF SQLEXEC(gnConnHandle, "SELECT * FROM SigCdUni", "crSigCdUni") < 1
                        MsgErro("Falha ao carregar SigCdUni.", "Erro sigprccpBO.InicializarCursores")
                        loc_lSucesso = .F.
                    ELSE
                        SELECT crSigCdUni
                        INDEX ON CUnis TAG CUnis
                        GO TOP
                    ENDIF
                ENDIF

                IF loc_lSucesso
                    IF USED("crSigCdPam")
                        USE IN crSigCdPam
                    ENDIF
                    IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Arreds FROM SigCdPam", ;
                        "crSigCdPam") < 1
                        MsgErro("Falha ao carregar SigCdPam.", "Erro sigprccpBO.InicializarCursores")
                        loc_lSucesso = .F.
                    ELSE
                        SELECT crSigCdPam
                        GO TOP
                    ENDIF
                ENDIF

                IF loc_lSucesso
                    IF USED("crSigCdPaC")
                        USE IN crSigCdPaC
                    ENDIF
                    IF SQLEXEC(gnConnHandle, ;
                        "SELECT TOP 1 CalcCusts, nChkSubGrs FROM SigCdPaC", ;
                        "crSigCdPaC") < 1
                        MsgErro("Falha ao carregar SigCdPaC.", "Erro sigprccpBO.InicializarCursores")
                        loc_lSucesso = .F.
                    ELSE
                        SELECT crSigCdPaC
                        GO TOP
                    ENDIF
                ENDIF

                IF loc_lSucesso
                    IF USED(THIS.this_cCursorProdutos)
                        USE IN (THIS.this_cCursorProdutos)
                    ENDIF
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Produtos ;
                        (lMarca N(1) NULL, CPros C(14) NULL, DPros C(40) NULL, ;
                        ValAnt N(14,2) NULL, ValAtu N(14,2) NULL, ;
                        CustoAfs N(12,4) NULL, CustoFs N(12,4) NULL, ;
                        PVarias N(8,2) NULL, CVarias N(8,2) NULL)
                    SET NULL OFF
                    INDEX ON CPros TAG CPros
                    SELECT cursor_4c_Produtos
                    SET ORDER TO
                    GO TOP
                ENDIF

                IF loc_lSucesso
                    IF USED("loc_TmpPrCpoSQL")
                        USE IN loc_TmpPrCpoSQL
                    ENDIF
                    IF USED("TmpPrCpo")
                        USE IN TmpPrCpo
                    ENDIF
                    IF SQLEXEC(gnConnHandle, "SELECT * FROM SigPrCpo WHERE 1=0", ;
                        "loc_TmpPrCpoSQL") > 0
                        SELECT * FROM loc_TmpPrCpoSQL ;
                            INTO CURSOR TmpPrCpo READWRITE NOFILTER
                        USE IN loc_TmpPrCpoSQL
                        SELECT TmpPrCpo
                        INDEX ON CPros TAG CPros
                        GO TOP
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro sigprccpBO.InicializarCursores")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *-- Mapeia campos de SigCdCcp (linha corrente) para propriedades this_*
    *--------------------------------------------------------------------------
        LOCAL loc_oErro

        TRY
            SELECT (par_cAliasCursor)
            IF TYPE(par_cAliasCursor + ".cIdChaves") != "U"
                THIS.this_cIdChaves = NVL(ALLTRIM(cIdChaves), "")
            ENDIF
            THIS.this_cCFornecs    = NVL(ALLTRIM(cfornecs),  "")
            THIS.this_cMercI       = NVL(ALLTRIM(merci),     "")
            THIS.this_cMercF       = NVL(ALLTRIM(mercf),     "")
            THIS.this_cCGrui       = NVL(ALLTRIM(cgrui),     "")
            THIS.this_cCGruf       = NVL(ALLTRIM(cgruf),     "")
            THIS.this_cSGruI       = NVL(ALLTRIM(sgrui),     "")
            THIS.this_cSGruF       = NVL(ALLTRIM(sgruf),     "")
            THIS.this_cCUniI       = NVL(ALLTRIM(cunii),     "")
            THIS.this_cCUnif       = NVL(ALLTRIM(cunif),     "")
            THIS.this_cLini        = NVL(ALLTRIM(lini),      "")
            THIS.this_cLinf        = NVL(ALLTRIM(linf),      "")
            THIS.this_cColi        = NVL(ALLTRIM(coli),      "")
            THIS.this_cColf        = NVL(ALLTRIM(colf),      "")
            THIS.this_cMoedai      = NVL(ALLTRIM(moedai),    "")
            THIS.this_cMoedaf      = NVL(ALLTRIM(moedaf),    "")
            THIS.this_nOpcMoedaTp  = NVL(opcmoedatp,         1)
            THIS.this_nMrki        = NVL(mrki,                0)
            THIS.this_nMrkf        = NVL(mrkf,                0)
            THIS.this_nEnci        = NVL(enci,                0)
            THIS.this_nEncf        = NVL(encf,                0)
            THIS.this_nVariacao    = NVL(variacao,            0)
            THIS.this_cFeitio      = NVL(ALLTRIM(feitio),    "")
            THIS.this_nOpcSituacao = NVL(opcsit,              1)
            THIS.this_nOpcRecalc   = NVL(opcrecalc,           1)
            THIS.this_nReajuste    = NVL(reajuste,            0)
            THIS.this_nEncargo     = NVL(encargo,             0)
            THIS.this_nNMrk        = NVL(nmrk,                0)
            THIS.this_nOpcPven     = NVL(opcpven,             2)
            THIS.this_cNewMkp      = NVL(ALLTRIM(newmkp),    "")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro sigprccpBO.CarregarDoCursor")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Processar()
    *-- Recalcula precos conforme this_nOpcRecalc e filtros. Popula cursor_4c_Produtos.
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_llOk
        LOCAL loc_lcMercI, loc_lcMercF, loc_lcGrui, loc_lcGruf
        LOCAL loc_lcSGruI, loc_lcSGruF, loc_lcCunii, loc_lcCUnif
        LOCAL loc_lcLini, loc_lcLinf, loc_lcColi, loc_lcColf
        LOCAL loc_lcMoedai, loc_lcMoedaf
        LOCAL loc_lnMrki, loc_lnMrkf, loc_lnEncI, loc_lnEncF
        LOCAL loc_lnArred, loc_lnPvenda, loc_lnReajuste, loc_lnMarkup
        LOCAL loc_lnEncarg, loc_lnTpRecal, loc_lcFeitio, loc_lnOpcaoM
        LOCAL loc_lnOpcComp, loc_lcIfors, loc_lcFtiNew
        LOCAL loc_lcWhere, loc_lcQuery, loc_lcSql
        LOCAL loc_loBarra, loc_pPro, loc_llAtu, loc_lnMtl, loc_lnVal
        LOCAL loc_cMoedas, loc_nQtdeqs
        LOCAL loc_Moec, loc_Moep, loc_Moepc, loc_Moecf, loc_Moedac
        LOCAL loc_Moem, loc_Moeft, loc_Moev, loc_MoecF, loc_MoepF, loc_MoepV
        LOCAL loc_lnTQtde, loc_lnTotal, loc_lnTFtio
        LOCAL loc_lnTotCv, loc_lnTotpCv, loc_lnTotEstM
        LOCAL loc_MarkCus, loc_MarkVen, loc_cFtioV, loc_Valgr
        LOCAL loc_llOkMat, loc_lnCotId, loc_lnCotVd, loc_lnPven, loc_lnVlVen
        LOCAL loc_Custo, loc_fPeso, loc_Fator, loc_Feitio, loc_FeitioC
        LOCAL loc_Ideal, loc_IdealCv, loc_Custof, loc_MarkCv, loc_MarkUpa
        LOCAL loc_vacm, loc_vFt, loc_vcoef, loc_vadic, loc_Coef, loc_lnCnt
        LOCAL loc_FatArred, loc_Soma, loc_CotMcf, loc_CotMpv, loc_cUniPeso, loc_lnFator

        loc_lSucesso = .F.
        loc_llOk     = .T.

        TRY
            loc_lcMercI    = ALLTRIM(THIS.this_cMercI)
            loc_lcMercF    = ALLTRIM(THIS.this_cMercF)
            loc_lcGrui     = ALLTRIM(THIS.this_cCGrui)
            loc_lcGruf     = ALLTRIM(THIS.this_cCGruf)
            loc_lcSGruI    = ALLTRIM(THIS.this_cSGruI)
            loc_lcSGruF    = ALLTRIM(THIS.this_cSGruF)
            loc_lcCunii    = ALLTRIM(THIS.this_cCUniI)
            loc_lcCUnif    = ALLTRIM(THIS.this_cCUnif)
            loc_lcLini     = ALLTRIM(THIS.this_cLini)
            loc_lcLinf     = ALLTRIM(THIS.this_cLinf)
            loc_lcColi     = ALLTRIM(THIS.this_cColi)
            loc_lcColf     = ALLTRIM(THIS.this_cColf)
            loc_lcMoedai   = ALLTRIM(THIS.this_cMoedai)
            loc_lcMoedaf   = ALLTRIM(THIS.this_cMoedaf)
            loc_lnMrki     = THIS.this_nMrki
            loc_lnMrkf     = THIS.this_nMrkf
            loc_lnEncI     = THIS.this_nEnci
            loc_lnEncF     = THIS.this_nEncf
            loc_lnPvenda   = THIS.this_nOpcPven
            loc_lnReajuste = 1 + (THIS.this_nReajuste / 100)
            loc_lnMarkup   = THIS.this_nNMrk
            loc_lnEncarg   = THIS.this_nEncargo
            loc_lnTpRecal  = THIS.this_nOpcRecalc
            loc_lcFeitio   = ALLTRIM(THIS.this_cFeitio)
            loc_lnOpcaoM   = THIS.this_nOpcMoedaTp
            loc_lnOpcComp  = THIS.this_nOpcCompra
            loc_lcIfors    = ALLTRIM(THIS.this_cCFornecs)
            loc_lcFtiNew   = ALLTRIM(THIS.this_cNewMkp)

            loc_lnArred = 1
            IF USED("crSigCdPam")
                SELECT crSigCdPam
                GO TOP
                IF !EOF("crSigCdPam")
                    loc_lnArred = IIF(crSigCdPam.Arreds = 0, 1, crSigCdPam.Arreds)
                ENDIF
            ENDIF

            IF INLIST(loc_lnTpRecal, 7, 8) AND EMPTY(loc_lcFtiNew)
                IF !THIS.this_lAutomatico
                    MsgAviso("Favor Informar o Novo C" + CHR(243) + "digo do MKP!!!", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                ENDIF
                loc_llOk = .F.
            ENDIF

            IF loc_llOk
                *-- Montar WHERE para SigCdPro
                loc_lcWhere = " "
                loc_lcWhere = THIS.AgregarFiltroRange(loc_lcWhere, "CGrus",    loc_lcGrui,  loc_lcGruf)
                loc_lcWhere = THIS.AgregarFiltroRange(loc_lcWhere, "Cunis",    loc_lcCunii, loc_lcCUnif)
                loc_lcWhere = THIS.AgregarFiltroRange(loc_lcWhere, "Linhas",   loc_lcLini,  loc_lcLinf)
                loc_lcWhere = THIS.AgregarFiltroRange(loc_lcWhere, "Colecoes", loc_lcColi,  loc_lcColf)
                IF loc_lnOpcaoM = 2
                    loc_lcWhere = THIS.AgregarFiltroRange(loc_lcWhere, "Moevs",  loc_lcMoedai, loc_lcMoedaf)
                ELSE
                    loc_lcWhere = THIS.AgregarFiltroRange(loc_lcWhere, "Moedas", loc_lcMoedai, loc_lcMoedaf)
                ENDIF
                loc_lcWhere = THIS.AgregarFiltroRange(loc_lcWhere, "SGrus", loc_lcSGruI, loc_lcSGruF)
                loc_lcWhere = THIS.AgregarFiltroRange(loc_lcWhere, "Mercs", loc_lcMercI, loc_lcMercF)

                loc_lcWhere = ALLTRIM(loc_lcWhere)
                IF EMPTY(loc_lcWhere)
                    loc_lcWhere = " 1=1 "
                ENDIF

                DO CASE
                CASE THIS.this_nOpcSituacao = 1
                    loc_lcWhere = loc_lcWhere + " And Situas = 1"
                CASE THIS.this_nOpcSituacao = 2
                    loc_lcWhere = loc_lcWhere + " And Situas = 2"
                ENDCASE

                IF !EMPTY(loc_lcIfors)
                    loc_lcWhere = loc_lcWhere + " And Ifors = " + EscaparSQL(loc_lcIfors)
                ENDIF

                IF INLIST(loc_lnOpcComp, 1, 2)
                    loc_lcWhere = loc_lcWhere + ;
                        " And ForaLinha = " + IIF(loc_lnOpcComp = 1, "0", "1")
                ENDIF

                loc_lcQuery = "Select * From SigCdPro Where " + loc_lcWhere
                IF loc_lnMrki > 0
                    loc_lcQuery = loc_lcQuery + ;
                        " And Margems Between " + FormatarNumeroSQL(loc_lnMrki) + ;
                        " And " + FormatarNumeroSQL(loc_lnMrkf)
                ENDIF
                IF loc_lnEncI > 0
                    loc_lcQuery = loc_lcQuery + ;
                        " And Encargos Between " + FormatarNumeroSQL(loc_lnEncI) + ;
                        " And " + FormatarNumeroSQL(loc_lnEncF)
                ENDIF
                IF !EMPTY(loc_lcFeitio)
                    loc_lcQuery = loc_lcQuery + ;
                        " And ( cFtios = '" + loc_lcFeitio + ;
                        "' Or cFtioCs = '" + loc_lcFeitio + "' )"
                ENDIF

                IF USED("crSigCdProSQL")
                    USE IN crSigCdProSQL
                ENDIF
                IF USED("crSigCdPro")
                    USE IN crSigCdPro
                ENDIF
                IF SQLEXEC(gnConnHandle, loc_lcQuery, "crSigCdProSQL") < 1
                    IF !THIS.this_lAutomatico
                        MsgErro("Favor Reinicializar o Processo!!!", ;
                            "Falha na Conex" + CHR(227) + "o (SigCdPro)")
                    ENDIF
                    loc_llOk = .F.
                ELSE
                    SELECT * FROM crSigCdProSQL INTO CURSOR crSigCdPro READWRITE NOFILTER
                    USE IN crSigCdProSQL
                    SELECT crSigCdPro
                    INDEX ON CPros TAG CPros
                ENDIF
            ENDIF

            IF loc_llOk
                IF USED("TmpPrCpo")
                    ZAP IN TmpPrCpo
                ENDIF

                IF USED("CrSigPrFti")
                    USE IN CrSigPrFti
                ENDIF
                IF SQLEXEC(gnConnHandle, "SELECT * FROM SigPrFti", "CrSigPrFti") < 1
                    IF !THIS.this_lAutomatico
                        MsgErro("Favor Reinicializar o Processo!!!", "Falha (CrSigPrFti)")
                    ENDIF
                    loc_llOk = .F.
                ELSE
                    SELECT CrSigPrFti
                    INDEX ON Cods TAG Cods
                ENDIF
            ENDIF

            IF loc_llOk
                IF USED("CrSigPrFtiG")
                    USE IN CrSigPrFtiG
                ENDIF
                loc_lcQuery = "Select a.*, b.Dgrus From SigPrFto a, SigCdGrp b " + ;
                    "Where a.Cgrus = b.Cgrus And a.Cgrus <> ' '"
                IF SQLEXEC(gnConnHandle, loc_lcQuery, "CrSigPrFtiG") < 1
                    IF !THIS.this_lAutomatico
                        MsgErro("Favor Reinicializar o Processo!!!", "Falha (CrSigPrFtiG)")
                    ENDIF
                    loc_llOk = .F.
                ELSE
                    SELECT CrSigPrFtiG
                    INDEX ON Cods TAG Cods
                ENDIF
            ENDIF

            IF loc_llOk
                IF USED("CrSigPrFtiP")
                    USE IN CrSigPrFtiP
                ENDIF
                loc_lcQuery = "Select a.*, b.Dpros From SigPrFto a, SigCdPro b " + ;
                    "Where a.Cpros = b.Cpros And a.CGrus = ' '"
                IF SQLEXEC(gnConnHandle, loc_lcQuery, "CrSigPrFtiP") < 1
                    IF !THIS.this_lAutomatico
                        MsgErro("Favor Reinicializar o Processo!!!", "Falha (CrSigPrFtiP)")
                    ENDIF
                    loc_llOk = .F.
                ELSE
                    SELECT CrSigPrFtiP
                    INDEX ON Cods TAG Cods
                ENDIF
            ENDIF

            IF loc_llOk
                IF USED("TotGrupo")
                    USE IN TotGrupo
                ENDIF
                CREATE CURSOR TotGrupo (Grupo C(3), Cpros C(14), ValGrupo N(12,3), Moeda C(3))
                INDEX ON Grupo + Cpros + Moeda TAG GruMoe

                IF USED("cursor_4c_Produtos")
                    ZAP IN cursor_4c_Produtos
                ENDIF
            ENDIF

            *-- === BRANCH 1: Recalculo de Pesos de Componentes (opcao 4) ===
            IF loc_llOk AND loc_lnTpRecal = 4
                SELECT crSigCdPro
                loc_loBarra = CREATEOBJECT("fwProgressBar", ;
                    "Recalculando Pesos de Componentes...", RECCOUNT("crSigCdPro"))
                loc_loBarra.Show

                SCAN
                    loc_loBarra.Update(.T.)
                    loc_pPro = ALLTRIM(crSigCdPro.CPros)

                    IF USED("TmpCompo")
                        USE IN TmpCompo
                    ENDIF
                    loc_lcQuery = "SELECT * FROM SigPrCpo WHERE CPros = " + EscaparSQL(loc_pPro)
                    IF SQLEXEC(gnConnHandle, loc_lcQuery, "TmpCompo") < 1
                        IF !THIS.this_lAutomatico
                            MsgErro("Favor Reinicializar o Processo!!!", "Falha (TmpCompo)")
                        ENDIF
                        loc_llOk = .F.
                        EXIT
                    ENDIF

                    loc_llAtu = .F.

                    SELECT TmpCompo
                    SCAN
                        loc_lnMtl = 1
                        IF !EMPTY(ALLTRIM(TmpCompo.Mats))
                            IF USED("LocalProCp")
                                USE IN LocalProCp
                            ENDIF
                            loc_lcQuery = "Select a.PesoMs, b.CfgGerGprs " + ;
                                "From SigCdPro a, SigCdGrp b " + ;
                                "Where a.CPros = '" + ALLTRIM(TmpCompo.Mats) + ;
                                "' And a.CGrus = b.CGrus"
                            IF SQLEXEC(gnConnHandle, loc_lcQuery, "LocalProCp") < 1
                                IF !THIS.this_lAutomatico
                                    MsgErro("Favor Reinicializar o Processo!!!", "Falha (LocalProCp)")
                                ENDIF
                                loc_llOk = .F.
                                EXIT
                            ENDIF
                            GO TOP IN LocalProCp
                            IF !EOF("LocalProCp") AND (LocalProCp.PesoMs > 0) AND ;
                                (INT(VAL(SUBSTR(LocalProCp.CfgGerGprs, 9, 1))) > 1)

                                IF INT(VAL(SUBSTR(LocalProCp.CfgGerGprs, 9, 1))) = 2
                                    IF !EMPTY(ALLTRIM(TmpCompo.UniCompos))
                                        IF !EMPTY(ALLTRIM(TmpCompo.CUniPs)) AND (TmpCompo.Pesos > 0)
                                            loc_lnMtl = TmpCompo.Pesos
                                        ENDIF
                                        loc_lnVal = LocalProCp.PesoMs * loc_lnMtl
                                        loc_lcSql = "Update SigPrCpo Set Qtds = " + ;
                                            FormatarNumeroSQL(loc_lnVal) + ;
                                            " Where cIdChaves = '" + ;
                                            ALLTRIM(TmpCompo.cIdChaves) + "'"
                                        IF SQLEXEC(gnConnHandle, loc_lcSql) < 1
                                            IF !THIS.this_lAutomatico
                                                MsgErro("Falha ao atualizar Qtds em SigPrCpo.", ;
                                                    "Erro sigprccpBO.Processar")
                                            ENDIF
                                            loc_llOk = .F.
                                            EXIT
                                        ENDIF
                                        loc_llAtu = .T.
                                    ENDIF
                                ELSE
                                    IF !EMPTY(ALLTRIM(TmpCompo.CUniPs))
                                        IF !EMPTY(ALLTRIM(TmpCompo.UniCompos)) AND (TmpCompo.Qtds > 0)
                                            loc_lnMtl = TmpCompo.Qtds
                                        ENDIF
                                        loc_lnVal = LocalProCp.PesoMs * loc_lnMtl
                                        loc_lcSql = "Update SigPrCpo Set Pesos = " + ;
                                            FormatarNumeroSQL(loc_lnVal) + ;
                                            " Where cIdChaves = '" + ;
                                            ALLTRIM(TmpCompo.cIdChaves) + "'"
                                        IF SQLEXEC(gnConnHandle, loc_lcSql) < 1
                                            IF !THIS.this_lAutomatico
                                                MsgErro("Falha ao atualizar Pesos em SigPrCpo.", ;
                                                    "Erro sigprccpBO.Processar")
                                            ENDIF
                                            loc_llOk = .F.
                                            EXIT
                                        ENDIF
                                        loc_llAtu = .T.
                                    ENDIF
                                ENDIF
                                IF USED("LocalProCp")
                                    USE IN LocalProCp
                                ENDIF
                            ENDIF
                        ENDIF
                        IF !loc_llOk
                            EXIT
                        ENDIF
                    ENDSCAN

                    IF !loc_llOk
                        EXIT
                    ENDIF

                    IF loc_llAtu
                        INSERT INTO cursor_4c_Produtos (CPros, DPros) ;
                            VALUES (crSigCdPro.CPros, crSigCdPro.DPros)
                    ENDIF
                    IF USED("TmpCompo")
                        USE IN TmpCompo
                    ENDIF
                    SELECT crSigCdPro
                ENDSCAN

                loc_loBarra.Complete(.T.)
            ENDIF

            *-- === BRANCH 2: Recalculo Composicao/Preco (opcoes 1,2,3,5,6,7,8) ===
            IF loc_llOk AND loc_lnTpRecal <> 4
                SELECT crSigCdPro
                loc_loBarra = CREATEOBJECT("fwprogressbar", ;
                    "Recalculando Produtos...", RECCOUNT("crSigCdPro"))
                loc_loBarra.Show

                SCAN
                    loc_pPro = ALLTRIM(crSigCdPro.CPros)

                    IF EMPTY(ALLTRIM(crSigCdPro.Moedas))
                        REPLACE Moedas WITH crSigCdPro.Moecs IN crSigCdPro
                    ENDIF

                    IF USED("crSigPrCpoSQL")
                        USE IN crSigPrCpoSQL
                    ENDIF
                    IF USED("crSigPrCpo")
                        USE IN crSigPrCpo
                    ENDIF
                    loc_lcSql = "SELECT * FROM SigPrCpo WHERE Cpros = " + EscaparSQL(loc_pPro)
                    IF SQLEXEC(gnConnHandle, loc_lcSql, "crSigPrCpoSQL") < 1
                        IF !THIS.this_lAutomatico
                            MsgErro("Favor Reinicializar o Processo!!!", "Falha (CrSigPrCpo)")
                        ENDIF
                        loc_llOk = .F.
                        EXIT
                    ENDIF
                    SELECT * FROM crSigPrCpoSQL INTO CURSOR crSigPrCpo READWRITE NOFILTER
                    USE IN crSigPrCpoSQL
                    SELECT crSigPrCpo
                    INDEX ON CPros TAG CPros
                    GO TOP

                    INSERT INTO cursor_4c_Produtos (CPros, DPros, ValAnt, CustoAfs) ;
                        VALUES (crSigCdPro.CPros, crSigCdPro.DPros, ;
                            crSigCdPro.Pvens, crSigCdPro.CustoFs)

                    SELECT crSigCdPro

                    loc_cMoedas = ALLTRIM(crSigCdPro.Moecs)
                    loc_nQtdeqs = 1
                    IF SEEK(loc_cMoedas, "crSigCdMoe", "CMoes") AND !EMPTY(ALLTRIM(crSigCdMoe.Moeqs))
                        loc_cMoedas = ALLTRIM(crSigCdMoe.Moeqs)
                        loc_nQtdeqs = IIF(crSigCdMoe.Qtdeqs = 0, 1, crSigCdMoe.Qtdeqs)
                    ENDIF
                    loc_Moec = fCarregarCambio(loc_cMoedas, DATE()) * loc_nQtdeqs

                    loc_cMoedas = ALLTRIM(crSigCdPro.Moepcs)
                    loc_nQtdeqs = 1
                    IF SEEK(loc_cMoedas, "crSigCdMoe", "CMoes") AND !EMPTY(ALLTRIM(crSigCdMoe.Moeqs))
                        loc_cMoedas = ALLTRIM(crSigCdMoe.Moeqs)
                        loc_nQtdeqs = IIF(crSigCdMoe.Qtdeqs = 0, 1, crSigCdMoe.Qtdeqs)
                    ENDIF
                    loc_Moepc = fCarregarCambio(loc_cMoedas, DATE()) * loc_nQtdeqs

                    loc_cMoedas = ALLTRIM(crSigCdPro.Moedas)
                    loc_nQtdeqs = 1
                    IF SEEK(loc_cMoedas, "crSigCdMoe", "CMoes") AND !EMPTY(ALLTRIM(crSigCdMoe.Moeqs))
                        loc_cMoedas = ALLTRIM(crSigCdMoe.Moeqs)
                        loc_nQtdeqs = IIF(crSigCdMoe.Qtdeqs = 0, 1, crSigCdMoe.Qtdeqs)
                    ENDIF
                    loc_Moedac = fCarregarCambio(loc_cMoedas, DATETIME()) * loc_nQtdeqs

                    =SEEK(crSigCdPro.CGrus, "crSigCdGrp", "CGrus")
                    STORE 0 TO loc_lnTQtde, loc_lnTotal, loc_lnTFtio
                    STORE 0 TO loc_lnTotCv, loc_lnTotpCv, loc_lnTotEstM
                    SELECT TotGrupo
                    ZAP

                    *-- Processar componentes de composicao
                    SELECT crSigPrCpo
                    =SEEK(loc_pPro)
                    SCAN WHILE ALLTRIM(crSigPrCpo.CPros) = loc_pPro
                        IF EMPTY(ALLTRIM(crSigPrCpo.Mats))
                            LOOP
                        ENDIF

                        loc_llOkMat = .T.
                        IF USED("crMatPrinc")
                            USE IN crMatPrinc
                        ENDIF
                        loc_lcQuery = "Select Distinct Matprincs From SigCdPro " + ;
                            "Where MatPrincs <> Space(14) and MatPrincs = '" + ;
                            ALLTRIM(crSigPrCpo.Mats) + "'"
                        IF SQLEXEC(gnConnHandle, loc_lcQuery, "crMatPrinc") < 1
                            IF !THIS.this_lAutomatico
                                MsgErro("Favor Reinicializar o Processo!!!", "Falha (crMatPrinc)")
                            ENDIF
                            loc_llOk = .F.
                            EXIT
                        ENDIF
                        SELECT crMatPrinc
                        IF RECCOUNT("crMatPrinc") >= 1
                            loc_llOkMat = .F.
                        ENDIF
                        USE IN crMatPrinc

                        IF loc_llOkMat
                            IF USED("CrCompoPro")
                                USE IN CrCompoPro
                            ENDIF
                            loc_lcSql = "Select Custofs, MoeCusfs, Cunis, Cgrus, " + ;
                                "Moevs, cUniPs, pVens From SigCdPro Where Cpros = '" + ;
                                ALLTRIM(crSigPrCpo.Mats) + "'"
                            IF SQLEXEC(gnConnHandle, loc_lcSql, "CrCompoPro") < 1
                                IF !THIS.this_lAutomatico
                                    MsgErro("Favor Reinicializar o Processo!!!", "Falha (CrCompoPro)")
                                ENDIF
                                loc_llOk = .F.
                                EXIT
                            ENDIF

                            =SEEK(crSigPrCpo.CGrus, "crSigCdGrp", "CGrus")

                            IF !EOF("CrCompoPro") AND (loc_lnTpRecal <> 2)
                                IF crSigCdGrp.pvCompos = 2
                                    REPLACE PCompos WITH CrCompoPro.Pvens, ;
                                        Moeds   WITH CrCompoPro.Moevs IN crSigPrCpo
                                ELSE
                                    REPLACE PCompos WITH CrCompoPro.CustoFs, ;
                                        Moeds   WITH CrCompoPro.MoeCusfs IN crSigPrCpo
                                ENDIF
                                REPLACE UniCompos WITH CrCompoPro.Cunis, ;
                                    CUniPs    WITH CrCompoPro.CUniPs, ;
                                    Cgrus     WITH CrCompoPro.Cgrus, ;
                                    DtMovs    WITH DATETIME() IN crSigPrCpo
                            ENDIF

                            loc_Valgr = crSigPrCpo.PCompos * ;
                                IIF(crSigCdGrp.chkInstalas = 2, crSigPrCpo.Pesos, crSigPrCpo.Qtds)

                            SELECT TotGrupo
                            SET ORDER TO GruMoe
                            IF !SEEK(ALLTRIM(crSigPrCpo.CGrus) + ALLTRIM(crSigPrCpo.CPros) + ;
                                ALLTRIM(crSigPrCpo.Moeds))
                                INSERT INTO TotGrupo (Grupo, Cpros, Moeda) ;
                                    VALUES (crSigPrCpo.CGrus, crSigPrCpo.Mats, crSigPrCpo.Moeds)
                            ENDIF
                            REPLACE ValGrupo WITH ValGrupo + loc_Valgr IN TotGrupo

                            loc_cMoedas = ALLTRIM(crSigPrCpo.Moeds)
                            loc_nQtdeqs = 1
                            IF SEEK(loc_cMoedas, "crSigCdMoe", "CMoes") AND !EMPTY(ALLTRIM(crSigCdMoe.Moeqs))
                                loc_cMoedas = ALLTRIM(crSigCdMoe.Moeqs)
                                loc_nQtdeqs = IIF(crSigCdMoe.Qtdeqs = 0, 1, crSigCdMoe.Qtdeqs)
                            ENDIF
                            loc_Moem = fCarregarCambio(loc_cMoedas, DATETIME()) * loc_nQtdeqs

                            loc_cMoedas = ALLTRIM(CrCompoPro.Moevs)
                            loc_nQtdeqs = 1
                            IF SEEK(loc_cMoedas, "crSigCdMoe", "CMoes") AND !EMPTY(ALLTRIM(crSigCdMoe.Moeqs))
                                loc_cMoedas = ALLTRIM(crSigCdMoe.Moeqs)
                                loc_nQtdeqs = IIF(crSigCdMoe.Qtdeqs = 0, 1, crSigCdMoe.Qtdeqs)
                            ENDIF
                            loc_Moev = fCarregarCambio(loc_cMoedas, DATETIME()) * loc_nQtdeqs

                            IF EMPTY(ALLTRIM(crSigPrCpo.Moeds))
                                SELECT crSigPrCpo
                                LOOP
                            ENDIF

                            IF loc_lnTpRecal <> 1
                                =SEEK(ALLTRIM(crSigPrCpo.UniCompos), "crSigCdUni", "CUnis")
                                =SEEK(crSigPrCpo.CGrus, "crSigCdGrp", "CGrus")

                                IF crSigCdGrp.PCustVens <> 0
                                    REPLACE VlrCvs WITH ;
                                        ROUND(crSigPrCpo.PCompos * (1 + (crSigCdGrp.PCustVens / 100)), 3) ;
                                        IN crSigPrCpo
                                ELSE
                                    REPLACE VlrCvs WITH crSigPrCpo.PCompos IN crSigPrCpo
                                ENDIF

                                IF crSigCdUni.PCustVens <> 0
                                    REPLACE QtdCvs WITH ;
                                        ROUND(crSigPrCpo.Qtds * (1 + (crSigCdUni.PCustVens / 100)), 3) ;
                                        IN crSigPrCpo
                                ELSE
                                    REPLACE QtdCvs WITH crSigPrCpo.Qtds IN crSigPrCpo
                                ENDIF

                                IF ALLTRIM(crSigPrCpo.Moeds) <> ALLTRIM(CrCompoPro.Moevs)
                                    loc_cMoedas = ALLTRIM(crSigPrCpo.Moeds)
                                    loc_nQtdeqs = 1
                                    IF SEEK(loc_cMoedas, "crSigCdMoe", "CMoes") AND !EMPTY(ALLTRIM(crSigCdMoe.Moeqs))
                                        loc_cMoedas = ALLTRIM(crSigCdMoe.Moeqs)
                                        loc_nQtdeqs = IIF(crSigCdMoe.Qtdeqs = 0, 1, crSigCdMoe.Qtdeqs)
                                    ENDIF
                                    loc_CotMcf = fCarregarCambio(loc_cMoedas, DATETIME()) * loc_nQtdeqs

                                    loc_cMoedas = ALLTRIM(CrCompoPro.Moevs)
                                    loc_nQtdeqs = 1
                                    IF SEEK(loc_cMoedas, "crSigCdMoe", "CMoes") AND !EMPTY(ALLTRIM(crSigCdMoe.Moeqs))
                                        loc_cMoedas = ALLTRIM(crSigCdMoe.Moeqs)
                                        loc_nQtdeqs = IIF(crSigCdMoe.Qtdeqs = 0, 1, crSigCdMoe.Qtdeqs)
                                    ENDIF
                                    loc_CotMpv = fCarregarCambio(loc_cMoedas, DATETIME()) * loc_nQtdeqs
                                    loc_MarkCv = ROUND(IIF(crSigPrCpo.VlrCvs = 0, 0, ;
                                        (CrCompoPro.Pvens * loc_CotMpv / loc_CotMcf) / ;
                                        crSigPrCpo.VlrCvs), 6)
                                ELSE
                                    loc_MarkCv = ROUND(IIF(crSigPrCpo.VlrCvs = 0, 0, ;
                                        CrCompoPro.Pvens / crSigPrCpo.VlrCvs), 6)
                                ENDIF

                                REPLACE MarkCvs WITH loc_MarkCv, ;
                                    DtMovs  WITH DATETIME(), ;
                                    VlrPvs  WITH CrCompoPro.Pvens IN crSigPrCpo

                                loc_lnTotCv  = loc_lnTotCv  + ;
                                    ((crSigPrCpo.VlrCvs * crSigPrCpo.QtdCvs) * loc_Moem / loc_Moec)
                                loc_lnTotpCv = loc_lnTotpCv + ;
                                    ((crSigPrCpo.VlrPvs * crSigPrCpo.QtdCvs) * loc_Moev / loc_Moedac)
                            ENDIF
                        ELSE
                            loc_cMoedas = ALLTRIM(crSigPrCpo.Moeds)
                            loc_nQtdeqs = 1
                            IF SEEK(loc_cMoedas, "crSigCdMoe", "CMoes") AND !EMPTY(ALLTRIM(crSigCdMoe.Moeqs))
                                loc_cMoedas = ALLTRIM(crSigCdMoe.Moeqs)
                                loc_nQtdeqs = IIF(crSigCdMoe.Qtdeqs = 0, 1, crSigCdMoe.Qtdeqs)
                            ENDIF
                            loc_Moem = fCarregarCambio(loc_cMoedas, DATETIME()) * loc_nQtdeqs
                        ENDIF

                        IF loc_lnTpRecal <> 2
                            =SEEK(crSigPrCpo.CGrus, "crSigCdGrp", "CGrus")
                            IF INLIST(crSigCdGrp.BPesos, 1, 3)
                                loc_cUniPeso = ""
                                IF USED("CrCompoPro")
                                    loc_cUniPeso = IIF(crSigCdGrp.BPesos = 1, ;
                                        ALLTRIM(CrCompoPro.Cunis), ALLTRIM(CrCompoPro.CUniPs))
                                ENDIF
                                =SEEK(loc_cUniPeso, "crSigCdUni", "CUnis")
                                loc_lnFator = IIF(crSigCdUni.Fators = 0, 1, crSigCdUni.Fators)
                                SELECT crSigPrCpo
                                loc_lnTQtde = loc_lnTQtde + ;
                                    (IIF(crSigCdGrp.BPesos = 1, crSigPrCpo.Qtds, crSigPrCpo.Pesos) * ;
                                    loc_lnFator)
                            ENDIF
                            IF crSigCdGrp.AtuComps <> 2
                                loc_lnTotal = loc_lnTotal + ;
                                    (crSigPrCpo.PCompos * ;
                                    IIF(crSigCdGrp.chkInstalas = 2, crSigPrCpo.Pesos, crSigPrCpo.Qtds)) * ;
                                    loc_Moem / loc_Moec
                            ENDIF
                        ENDIF

                        IF crSigCdGrp.cvestims = 1
                            loc_lnTotEstM = loc_lnTotEstM + ;
                                (crSigPrCpo.PCompos * crSigPrCpo.Qtds) * loc_Moem / loc_Moedac
                        ENDIF

                        IF !loc_llOk
                            EXIT
                        ENDIF
                        SELECT crSigPrCpo
                    ENDSCAN

                    IF !loc_llOk
                        EXIT
                    ENDIF

                    SELECT crSigCdPro
                    loc_MarkCus = ALLTRIM(crSigCdPro.cftiocs)
                    loc_MarkVen = ALLTRIM(crSigCdPro.cftios)

                    IF INLIST(loc_lnTpRecal, 7, 8)
                        IF loc_lnTpRecal = 7 AND !EMPTY(loc_lcFtiNew)
                            loc_MarkCus = loc_lcFtiNew
                        ENDIF
                        IF loc_lnTpRecal = 8 AND !EMPTY(loc_lcFtiNew)
                            loc_MarkVen = loc_lcFtiNew
                        ENDIF
                        REPLACE cftiocs WITH loc_MarkCus, cftios WITH loc_MarkVen IN crSigCdPro
                    ENDIF

                    SELECT crSigPrCpo
                    GO TOP
                    SCAN
                        SCATTER MEMVAR MEMO
                        SELECT TmpPrCpo
                        APPEND BLANK
                        GATHER MEMVAR MEMO
                        SELECT crSigPrCpo
                    ENDSCAN

                    IF USED("LocalTGrupo")
                        USE IN LocalTGrupo
                    ENDIF
                    SELECT CGrus AS Grupo, Mats AS CPros, dCompos AS Dgrus, Moeds AS Moeda, ;
                        Pesos, Qtds, PCompos, 0000000000.000 AS ValGrupo, OrdTs ;
                        FROM crSigPrCpo ;
                        ORDER BY 1, 2, 3 ;
                        INTO CURSOR LocalTGrupo READWRITE
                    UPDATE LocalTGrupo SET ValGrupo = ;
                        IIF(crSigCdGrp.chkInstalas = 2, Pesos, Qtds) * PCompos

                    *-- Feitio de custo (MarkCus)
                    IF !EMPTY(loc_MarkCus)
                        IF USED("TmpFtio")
                            USE IN TmpFtio
                        ENDIF
                        SQLEXEC(gnConnHandle, ;
                            "Select * From SigPrFti Where Cods = " + EscaparSQL(loc_MarkCus), "TmpFtio")
                        SELECT TmpFtio
                        IF RECCOUNT() > 0 AND TmpFtio.Acrescs = 0 AND TmpFtio.Valors = 0 AND ;
                            loc_lnTpRecal <> 2

                            IF USED("TmpFtioC")
                                USE IN TmpFtioC
                            ENDIF
                            loc_lcSql = "Select a.*, IsNull(b.Dgrus,'') as Dgrus " + ;
                                "From SigPrFto a Left Join SigCdGrp b on a.Cgrus = b.Cgrus " + ;
                                "Where a.Cods = '" + loc_MarkCus + ;
                                "' And (a.Cgrus <> ' ' OR a.Ordem <> 0) Order by a.Cods"
                            SQLEXEC(gnConnHandle, loc_lcSql, "TmpFtioC")

                            loc_lnCnt = 1
                            loc_vacm  = 0
                            loc_vFt   = 0

                            IF TmpFtio.AplsCus <> 1
                                SELECT LocalTGrupo
                                SCAN
                                    SELECT TmpFtioC
                                    LOCATE FOR ALLTRIM(CGrus) = ALLTRIM(LocalTGrupo.Grupo) AND ;
                                        ALLTRIM(CPros) = ALLTRIM(LocalTGrupo.CPros)
                                    IF EOF("TmpFtioC")
                                        LOCATE FOR ALLTRIM(CGrus) = ALLTRIM(LocalTGrupo.Grupo) AND EMPTY(CPros)
                                    ENDIF
                                    IF EOF("TmpFtioC")
                                        LOCATE FOR Ordem = LocalTGrupo.OrdTs AND EMPTY(CPros)
                                    ENDIF
                                    IF !EOF("TmpFtioC")
                                        loc_Coef = TmpFtioC.Coefs
                                        IF EOF()
                                            loc_Coef = 1
                                        ENDIF
                                        loc_MoecF = 1
                                        loc_MoepF = 1
                                        IF ALLTRIM(TmpFtio.Moedas) <> ALLTRIM(LocalTGrupo.Moeda)
                                            loc_cMoedas = ALLTRIM(TmpFtio.Moedas)
                                            loc_nQtdeqs = 1
                                            IF SEEK(loc_cMoedas, "crSigCdMoe", "CMoes") AND ;
                                                !EMPTY(ALLTRIM(crSigCdMoe.Moeqs))
                                                loc_cMoedas = ALLTRIM(crSigCdMoe.Moeqs)
                                                loc_nQtdeqs = IIF(crSigCdMoe.Qtdeqs = 0, 1, crSigCdMoe.Qtdeqs)
                                            ENDIF
                                            loc_MoecF = fBuscarCotacao(loc_cMoedas, DATETIME(), gnConnHandle) * loc_nQtdeqs

                                            loc_cMoedas = ALLTRIM(LocalTGrupo.Moeda)
                                            loc_nQtdeqs = 1
                                            IF SEEK(loc_cMoedas, "crSigCdMoe", "CMoes") AND ;
                                                !EMPTY(ALLTRIM(crSigCdMoe.Moeqs))
                                                loc_cMoedas = ALLTRIM(crSigCdMoe.Moeqs)
                                                loc_nQtdeqs = IIF(crSigCdMoe.Qtdeqs = 0, 1, crSigCdMoe.Qtdeqs)
                                            ENDIF
                                            loc_MoepF = fBuscarCotacao(loc_cMoedas, DATETIME(), gnConnHandle) * loc_nQtdeqs
                                        ENDIF
                                        loc_vcoef = ROUND(LocalTGrupo.ValGrupo * loc_MoepF / loc_MoecF, 3)
                                        loc_vadic = ROUND((loc_vcoef * loc_Coef) - loc_vcoef, 3)
                                        loc_vacm  = loc_vacm + loc_vcoef + loc_vadic
                                        loc_vFt   = loc_vFt  + loc_vadic
                                        loc_lnCnt = loc_lnCnt + 1
                                    ENDIF
                                    SELECT LocalTGrupo
                                ENDSCAN
                            ELSE
                                SELECT crSigCdPro
                                loc_vacm  = crSigCdPro.PCuss
                                loc_lnCnt = loc_lnCnt + 1
                            ENDIF

                            IF USED("TmpFtioC")
                                USE IN TmpFtioC
                            ENDIF
                            loc_lcSql = "Select a.*, b.Dpros From SigPrFto a, SigCdPro b " + ;
                                "Where a.Cods = '" + loc_MarkCus + ;
                                "' And a.Cpros = b.Cpros And a.Cgrus = Space(3) " + ;
                                "And a.Ordem = 0 Order by a.Seqs"
                            SQLEXEC(gnConnHandle, loc_lcSql, "TmpFtioC")

                            SELECT TmpFtioC
                            SCAN
                                loc_vcoef = loc_vacm
                                IF TmpFtio.DivMults = 1
                                    loc_vadic = ROUND((loc_vcoef * TmpFtioC.Coefs) - loc_vcoef, 3)
                                ELSE
                                    loc_vadic = ROUND((loc_vcoef / (1 - (TmpFtioC.Coefs / 100))) - loc_vcoef, 3)
                                ENDIF
                                loc_vacm  = loc_vacm + loc_vadic
                                loc_vFt   = loc_vFt  + loc_vadic
                                loc_lnCnt = loc_lnCnt + 1
                            ENDSCAN

                            SELECT crSigCdPro
                            REPLACE pftiocs WITH loc_vFt IN crSigCdPro

                            IF USED("TmpFtioC")
                                USE IN TmpFtioC
                            ENDIF
                        ENDIF
                        IF USED("TmpFtio")
                            USE IN TmpFtio
                        ENDIF
                    ENDIF

                    *-- Feitio de venda (MarkVen)
                    loc_MarkVen = ALLTRIM(crSigCdPro.cftios)
                    =SEEK(loc_MarkVen, "CrSigPrFti", "Cods")

                    IF !EOF("CrSigPrFti") AND (loc_lnTpRecal <> 2)
                        IF CrSigPrFti.Acrescs = 0 AND CrSigPrFti.Valors = 0
                            loc_cMoedas = ALLTRIM(CrSigPrFti.Moedas)
                            loc_nQtdeqs = 1
                            IF SEEK(loc_cMoedas, "crSigCdMoe", "CMoes") AND !EMPTY(ALLTRIM(crSigCdMoe.Moeqs))
                                loc_cMoedas = ALLTRIM(crSigCdMoe.Moeqs)
                                loc_nQtdeqs = IIF(crSigCdMoe.Qtdeqs = 0, 1, crSigCdMoe.Qtdeqs)
                            ENDIF
                            loc_Moec = fBuscarCotacao(loc_cMoedas, DATETIME(), gnConnHandle) * loc_nQtdeqs

                            SELECT CrSigPrFtiG
                            SET ORDER TO Cods
                            SET KEY TO loc_MarkVen

                            loc_vacm = 0
                            loc_vFt  = 0

                            SELECT TotGrupo
                            SCAN
                                SELECT CrSigPrFtiG
                                LOCATE FOR ALLTRIM(CGrus) = ALLTRIM(TotGrupo.Grupo) AND ;
                                    ALLTRIM(CPros) = ALLTRIM(TotGrupo.CPros)
                                IF EOF("CrSigPrFtiG")
                                    LOCATE FOR ALLTRIM(CGrus) = ALLTRIM(TotGrupo.Grupo)
                                ENDIF
                                loc_Coef = CrSigPrFtiG.Coefs
                                IF EOF()
                                    loc_Coef = 1
                                ENDIF
                                loc_MoepV = 1
                                IF ALLTRIM(CrSigPrFti.Moedas) <> ALLTRIM(TotGrupo.Moeda)
                                    loc_cMoedas = ALLTRIM(TotGrupo.Moeda)
                                    loc_nQtdeqs = 1
                                    IF SEEK(loc_cMoedas, "crSigCdMoe", "CMoes") AND ;
                                        !EMPTY(ALLTRIM(crSigCdMoe.Moeqs))
                                        loc_cMoedas = ALLTRIM(crSigCdMoe.Moeqs)
                                        loc_nQtdeqs = IIF(crSigCdMoe.Qtdeqs = 0, 1, crSigCdMoe.Qtdeqs)
                                    ENDIF
                                    loc_MoepV = fBuscarCotacao(loc_cMoedas, DATETIME(), gnConnHandle) * loc_nQtdeqs
                                    loc_vcoef = ROUND(TotGrupo.ValGrupo * loc_MoepV / loc_Moec, 3)
                                ELSE
                                    loc_vcoef = TotGrupo.ValGrupo
                                ENDIF
                                loc_vadic = ROUND((loc_vcoef * loc_Coef) - loc_vcoef, 3)
                                loc_vacm  = loc_vacm + loc_vcoef + loc_vadic
                                loc_vFt   = loc_vFt  + loc_vadic
                                SELECT TotGrupo
                            ENDSCAN

                            SELECT CrSigPrFtiP
                            SET ORDER TO Cods
                            SET KEY TO loc_MarkVen
                            SCAN
                                loc_vcoef = loc_vacm
                                IF CrSigPrFti.DivMults = 1
                                    loc_vadic = ROUND((loc_vcoef * CrSigPrFtiP.Coefs) - loc_vcoef, 3)
                                ELSE
                                    loc_vadic = ROUND((loc_vcoef / (1 - (CrSigPrFtiP.Coefs / 100))) - loc_vcoef, 3)
                                ENDIF
                                loc_vacm = loc_vacm + loc_vadic
                                loc_vFt  = loc_vFt  + loc_vadic
                            ENDSCAN

                            SELECT crSigCdPro
                            REPLACE pftios  WITH loc_vFt, ;
                                mFtios  WITH CrSigPrFti.Moedas, ;
                                Moedas  WITH IIF(EMPTY(ALLTRIM(crSigCdPro.Moedas)), ;
                                    CrSigPrFti.Moedas, crSigCdPro.Moedas) IN crSigCdPro

                            SET KEY TO IN CrSigPrFtiG
                            SET KEY TO IN CrSigPrFtiP
                        ELSE
                            loc_lnTFtio = CrSigPrFti.Valors * crSigCdPro.PesoMs
                            REPLACE mFtios WITH CrSigPrFti.Moedas, ;
                                pftios WITH loc_lnTFtio IN crSigCdPro
                        ENDIF
                    ENDIF

                    IF loc_lnTQtde <> 0
                        SELECT crSigCdPro
                        REPLACE PesoMs WITH loc_lnTQtde IN crSigCdPro
                    ENDIF
                    IF loc_lnTotal <> 0
                        SELECT crSigCdPro
                        REPLACE PCuss WITH loc_lnTotal IN crSigCdPro
                    ENDIF

                    IF loc_lnTpRecal <> 2
                        SELECT crSigCdPro
                        IF loc_lnMarkup > 0
                            REPLACE Margems WITH loc_lnMarkup IN crSigCdPro
                        ELSE
                            REPLACE Margems WITH Margems * loc_lnReajuste IN crSigCdPro
                        ENDIF
                        IF loc_lnEncarg <> 0
                            REPLACE Encargos WITH loc_lnEncarg IN crSigCdPro
                        ENDIF
                    ENDIF

                    SELECT crSigCdPro
                    loc_Custo   = crSigCdPro.PCuss
                    loc_fPeso   = crSigCdPro.PesoMs * crSigCdPro.Fcustos
                    loc_Fator   = crSigCdPro.Margems
                    loc_Feitio  = crSigCdPro.pftios
                    loc_FeitioC = crSigCdPro.pftiocs
                    loc_cFtioV  = ALLTRIM(crSigCdPro.cftios)

                    =SEEK(crSigCdPro.CGrus, "crSigCdGrp", "CGrus")

                    IF USED("CrFtio")
                        USE IN CrFtio
                    ENDIF
                    SQLEXEC(gnConnHandle, "SELECT * FROM SigPrFti WHERE Cods = '" + ;
                        loc_cFtioV + "'", "CrFtio")
                    GO TOP IN CrFtio

                    loc_cMoedas = ALLTRIM(crSigCdPro.Moecs)
                    loc_nQtdeqs = 1
                    IF SEEK(loc_cMoedas, "crSigCdMoe", "CMoes") AND !EMPTY(ALLTRIM(crSigCdMoe.Moeqs))
                        loc_cMoedas = ALLTRIM(crSigCdMoe.Moeqs)
                        loc_nQtdeqs = IIF(crSigCdMoe.Qtdeqs = 0, 1, crSigCdMoe.Qtdeqs)
                    ENDIF
                    loc_Moec = fCarregarCambio(loc_cMoedas, DATE()) * loc_nQtdeqs

                    loc_cMoedas = ALLTRIM(crSigCdPro.Moepcs)
                    loc_nQtdeqs = 1
                    IF SEEK(loc_cMoedas, "crSigCdMoe", "CMoes") AND !EMPTY(ALLTRIM(crSigCdMoe.Moeqs))
                        loc_cMoedas = ALLTRIM(crSigCdMoe.Moeqs)
                        loc_nQtdeqs = IIF(crSigCdMoe.Qtdeqs = 0, 1, crSigCdMoe.Qtdeqs)
                    ENDIF
                    loc_Moep = fCarregarCambio(loc_cMoedas, DATE()) * loc_nQtdeqs

                    loc_cMoedas = ALLTRIM(crSigCdPro.Moevs)
                    loc_nQtdeqs = 1
                    IF SEEK(loc_cMoedas, "crSigCdMoe", "CMoes") AND !EMPTY(ALLTRIM(crSigCdMoe.Moeqs))
                        loc_cMoedas = ALLTRIM(crSigCdMoe.Moeqs)
                        loc_nQtdeqs = IIF(crSigCdMoe.Qtdeqs = 0, 1, crSigCdMoe.Qtdeqs)
                    ENDIF
                    loc_Moev = fCarregarCambio(loc_cMoedas, DATE()) * loc_nQtdeqs

                    loc_cMoedas = ALLTRIM(crSigCdPro.MoeCusfs)
                    loc_nQtdeqs = 1
                    IF SEEK(loc_cMoedas, "crSigCdMoe", "CMoes") AND !EMPTY(ALLTRIM(crSigCdMoe.Moeqs))
                        loc_cMoedas = ALLTRIM(crSigCdMoe.Moeqs)
                        loc_nQtdeqs = IIF(crSigCdMoe.Qtdeqs = 0, 1, crSigCdMoe.Qtdeqs)
                    ENDIF
                    loc_Moecf = fCarregarCambio(loc_cMoedas, DATE()) * loc_nQtdeqs

                    loc_cMoedas = ALLTRIM(crSigCdPro.Moedas)
                    loc_nQtdeqs = 1
                    IF SEEK(loc_cMoedas, "crSigCdMoe", "CMoes") AND !EMPTY(ALLTRIM(crSigCdMoe.Moeqs))
                        loc_cMoedas = ALLTRIM(crSigCdMoe.Moeqs)
                        loc_nQtdeqs = IIF(crSigCdMoe.Qtdeqs = 0, 1, crSigCdMoe.Qtdeqs)
                    ENDIF
                    loc_Moedac = fCarregarCambio(loc_cMoedas, DATE()) * loc_nQtdeqs

                    loc_cMoedas = ALLTRIM(crSigCdPro.mFtios)
                    loc_nQtdeqs = 1
                    IF SEEK(loc_cMoedas, "crSigCdMoe", "CMoes") AND !EMPTY(ALLTRIM(crSigCdMoe.Moeqs))
                        loc_cMoedas = ALLTRIM(crSigCdMoe.Moeqs)
                        loc_nQtdeqs = IIF(crSigCdMoe.Qtdeqs = 0, 1, crSigCdMoe.Qtdeqs)
                    ENDIF
                    loc_Moeft = fCarregarCambio(loc_cMoedas, DATE()) * loc_nQtdeqs

                    loc_MarkCv = ROUND(IIF(loc_lnTotCv = 0, 0, loc_lnTotpCv / loc_lnTotCv), 6)

                    IF ALLTRIM(crSigCdPro.mFtios) <> ALLTRIM(crSigCdPro.MoeCusfs)
                        loc_Feitio = loc_Feitio * loc_Moeft / loc_Moecf
                    ENDIF
                    IF ALLTRIM(crSigCdPro.Moepcs) <> ALLTRIM(crSigCdPro.MoeCusfs)
                        loc_FeitioC = loc_FeitioC * loc_Moep / loc_Moecf
                    ENDIF
                    IF ALLTRIM(crSigCdPro.Moecs) <> ALLTRIM(crSigCdPro.MoeCusfs)
                        loc_Custof = loc_Custo * loc_Moec / loc_Moecf
                    ELSE
                        loc_Custof = loc_Custo
                    ENDIF
                    loc_Custof = loc_Custof + loc_FeitioC

                    SELECT crSigCdPaC
                    GO TOP
                    IF crSigCdPaC.CalcCusts = 2
                        IF ALLTRIM(crSigCdPro.Moepcs) <> ALLTRIM(crSigCdPro.MoeCusfs)
                            loc_Custof = loc_Custof * ;
                                IIF(crSigCdPro.Fcustos = 0, 1, crSigCdPro.Fcustos * loc_Moep / loc_Moecf)
                        ELSE
                            loc_Custof = loc_Custof * IIF(crSigCdPro.Fcustos = 0, 1, crSigCdPro.Fcustos)
                        ENDIF
                    ELSE
                        IF ALLTRIM(crSigCdPro.Moepcs) <> ALLTRIM(crSigCdPro.MoeCusfs)
                            loc_Custof = loc_Custof + (loc_fPeso * loc_Moep / loc_Moecf)
                        ELSE
                            loc_Custof = loc_Custof + loc_fPeso
                        ENDIF
                    ENDIF

                    IF !EMPTY(loc_cFtioV) AND !EOF("CrFtio") AND ;
                        CrFtio.Acrescs = 0 AND CrFtio.Valors = 0
                        loc_Fator = 0
                    ENDIF

                    IF ALLTRIM(crSigCdPro.MoeCusfs) <> ALLTRIM(crSigCdPro.Moedas)
                        loc_Ideal = (loc_Custof + loc_Feitio) * loc_Moecf / loc_Moedac * ;
                            IIF(loc_Fator = 0, 1, loc_Fator)
                    ELSE
                        loc_Ideal = (loc_Custof + loc_Feitio) * IIF(loc_Fator = 0, 1, loc_Fator)
                    ENDIF

                    =SEEK(loc_cFtioV, "CrSigPrFti", "Cods")
                    IF !EMPTY(loc_cFtioV) AND !EOF("CrSigPrFti") AND ;
                        CrSigPrFti.Acrescs = 0 AND CrSigPrFti.Valors = 0
                        SELECT crSigCdPro
                        REPLACE Margems WITH ;
                            IIF(loc_Custof = 0, 0, ROUND(loc_Ideal / loc_Custof, 6)) IN crSigCdPro
                    ENDIF

                    SELECT crSigCdGrp
                    IF crSigCdGrp.TpCalcPs = 4
                        SELECT crSigCdPro
                        loc_IdealCv = crSigCdPro.MarkupA * loc_Custo
                    ELSE
                        loc_IdealCv = loc_Ideal
                    ENDIF

                    SELECT crSigCdGrp
                    IF !EOF("crSigCdGrp") AND crSigCdGrp.Arredcs <> 0 AND crSigCdGrp.TpCalcPs <> 2
                        loc_FatArred = crSigCdGrp.Arredcs
                        loc_Soma = loc_FatArred
                        DO WHILE loc_Soma < loc_IdealCv
                            loc_Soma = loc_Soma + loc_FatArred
                        ENDDO
                        loc_IdealCv = loc_Soma
                        loc_IdealCv = fArredondamento(loc_IdealCv, gnConnHandle)
                        loc_Ideal   = IIF(!EMPTY(loc_IdealCv), loc_IdealCv, loc_Ideal)
                    ENDIF

                    SELECT crSigCdPro
                    IF loc_lnTpRecal <> 2
                        REPLACE CustoFs  WITH loc_Custof, ;
                            Pvideals WITH loc_Ideal, ;
                            Pvens    WITH IIF(loc_lnPvenda = 1, ;
                                loc_Ideal / IIF(Encargos <> 0, Encargos, 1), Pvens) IN crSigCdPro
                        IF loc_lnTotEstM > 0
                            REPLACE Valors WITH loc_lnTotEstM IN crSigCdPro
                        ENDIF
                    ENDIF

                    loc_MarkUpa = IIF(crSigCdPro.CustoFs = 0, 0, ;
                        ROUND((crSigCdPro.Pvens * loc_Moev) / (crSigCdPro.CustoFs * loc_Moecf), 3))
                    REPLACE MarkupA WITH loc_MarkUpa IN crSigCdPro

                    IF INLIST(loc_lnTpRecal, 5, 6)
                        loc_lnCotId = fBuscarCotacao(ALLTRIM(crSigCdPro.Moedas), DATETIME(), gnConnHandle)
                        loc_lnCotVd = fBuscarCotacao(ALLTRIM(crSigCdPro.Moevs),  DATETIME(), gnConnHandle)
                        loc_lnPven  = crSigCdPro.Pvideals * loc_lnCotId / ;
                            IIF(loc_lnCotVd = 0, 1, loc_lnCotVd)
                        loc_lnVlVen = loc_lnPven / ;
                            IIF(crSigCdPro.Encargos <> 0, crSigCdPro.Encargos, 1)
                        IF loc_lnTpRecal = 6
                            loc_lnPven  = INT(crSigCdPro.Pvideals * loc_lnCotId / ;
                                IIF(loc_lnCotVd = 0, 1, loc_lnCotVd))
                            loc_lnVlVen = INT(loc_lnPven / ;
                                IIF(crSigCdPro.Encargos <> 0, crSigCdPro.Encargos, 1))
                        ENDIF
                        SELECT crSigCdPro
                        REPLACE Pvens WITH loc_lnVlVen IN crSigCdPro
                    ENDIF

                    SELECT cursor_4c_Produtos
                    REPLACE ValAtu  WITH crSigCdPro.Pvens, ;
                        CustoFs WITH crSigCdPro.CustoFs IN cursor_4c_Produtos
                    REPLACE PVarias WITH IIF(cursor_4c_Produtos.ValAnt = 0, 0, ;
                        (((cursor_4c_Produtos.ValAtu / cursor_4c_Produtos.ValAnt) - 1) * 100)) ;
                        IN cursor_4c_Produtos
                    REPLACE CVarias WITH IIF(cursor_4c_Produtos.CustoAfs = 0, 0, ;
                        (((cursor_4c_Produtos.CustoFs / cursor_4c_Produtos.CustoAfs) - 1) * 100)) ;
                        IN cursor_4c_Produtos

                    IF USED("CrFtio")
                        USE IN CrFtio
                    ENDIF
                    IF USED("LocalTGrupo")
                        USE IN LocalTGrupo
                    ENDIF

                    loc_loBarra.Update(.T.)

                    IF !loc_llOk
                        EXIT
                    ENDIF
                    SELECT crSigCdPro
                ENDSCAN

                loc_loBarra.Complete(.T.)
            ENDIF

            IF loc_llOk
                SELECT cursor_4c_Produtos
                SET ORDER TO CPros
                GO TOP
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro sigprccpBO.Processar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE AtualizarPrecos(par_lImpEtiq)
    *-- Grava recalculo no SQL Server (transacao). par_lImpEtiq: .T. = marcar etiquetas.
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_llOk, loc_lTransacaoAtiva
        LOCAL loc_lcCPros, loc_lcHora, loc_lcIdChaves, loc_lcOrigem
        LOCAL loc_cSQL, loc_lnResult, loc_cSetClauses

        loc_lSucesso       = .F.
        loc_llOk           = .T.
        loc_lTransacaoAtiva = .F.

        IF EMPTY(par_lImpEtiq)
            par_lImpEtiq = .F.
        ENDIF

        TRY
            IF !THIS.this_lAutomatico
                IF !MsgConfirma("Atualiza ???", "Altera" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "os")
                    loc_lSucesso = .F.
                ELSE
                    loc_llOk = .T.
                ENDIF
            ENDIF

            IF loc_llOk
                IF USED("cursor_4c_CsProdutos")
                    USE IN cursor_4c_CsProdutos
                ENDIF
                SELECT * FROM cursor_4c_Produtos WHERE lMarca = 1 ORDER BY CPros ;
                    INTO CURSOR cursor_4c_CsProdutos READWRITE NOFILTER

                SELECT cursor_4c_CsProdutos
                GO TOP
                IF EOF("cursor_4c_CsProdutos")
                    IF !THIS.this_lAutomatico
                        MsgAviso("Nenhum Produto Selecionado !!!", ;
                            "Sele" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria")
                    ENDIF
                    USE IN cursor_4c_CsProdutos
                    loc_llOk = .F.
                ENDIF
            ENDIF

            IF loc_llOk
                IF SQLEXEC(gnConnHandle, "BEGIN TRANSACTION") < 1
                    MsgErro("Falha ao iniciar transa" + CHR(231) + CHR(227) + "o.", ;
                        "Erro sigprccpBO.AtualizarPrecos")
                    loc_llOk = .F.
                ELSE
                    loc_lTransacaoAtiva = .T.
                ENDIF
            ENDIF

            IF loc_llOk
                LOCAL loc_loBarra
                loc_loBarra = CREATEOBJECT("fwprogressbar", ;
                    "Atualizando os Pre" + CHR(231) + "os...", RECCOUNT("cursor_4c_CsProdutos"))
                loc_loBarra.Show

                SELECT cursor_4c_CsProdutos
                GO TOP
                SCAN
                    loc_loBarra.Update(.T., "Produto: " + ALLTRIM(cursor_4c_CsProdutos.CPros))
                    loc_lcCPros = ALLTRIM(cursor_4c_CsProdutos.CPros)

                    IF !SEEK(loc_lcCPros, "crSigCdPro", "CPros")
                        SELECT cursor_4c_CsProdutos
                        LOOP
                    ENDIF

                    *-- Arquivar historico em SigCdPrc (INSERT SELECT FROM SigCdPro)
                    loc_lcIdChaves = LEFT(fUniqueIds(), 20)
                    loc_lcHora     = SUBSTR(TTOC(DATETIME()), 12, 8)
                    loc_lcOrigem   = LEFT(TTOC(DATETIME()) + " SigPrCcp", 30)

                    loc_cSQL = "INSERT INTO SigCdPrc (" + ;
                        "cidchaves, dataalts, horaalts, usuaalts, origem, " + ;
                        "matprincs, dtcomps, cbars, cgrus, clfiscals, colecoes, comis, " + ;
                        "cpros, cunis, custofs, cvens, datas, datatrans, dpros, dtfilms, " + ;
                        "fcustos, flagctabs, fvendas, icms, ifors, linhas, locals, margems, " + ;
                        "moecs, moecusfs, moedas, moepcs, moepvs, moevs, notas, obspeds, " + ;
                        "obspes, origmercs, pcuss, pesoms, pvens, pvideals, qmins, reffs, " + ;
                        "sittricms, tcomps, tipos, transps, valors, varias, situas, dtincs, " + ;
                        "sgrus, metals, teors, cftios, codservs, mftios, pftios, codcors, " + ;
                        "codtams, compos, montadescs, digimaxs, ordcompos, ean13, cproeqs, " + ;
                        "qtdcpnts, impetiqs, chkfunds, casas, mercs, pesobs, tamhs, tamls, " + ;
                        "tamps, tptribs, volumes, ipis, dpro2s, encoms, codacbs, cravcers, " + ;
                        "cunips, obsetqs, ultcomps, vultcomps, multcomps, markupa, tinsts, " + ;
                        "cclass, nivelqs, cftiocs, pftiocs, usuincs, diasinas, idecpros, " + ;
                        "fabrproprs, qtminfabs, tents, codfinp, codmatp, consigs, ltminsv, " + ;
                        "status, aliqipis, codgarras, descecfs, encargos, idpro, nidentfixa, " + ;
                        "pesobris, pesometal, pesopdrs, extipi, iats, dtsituas, conjunts) " + ;
                        "SELECT " + ;
                        EscaparSQL(loc_lcIdChaves) + ", GETDATE(), " + ;
                        EscaparSQL(loc_lcHora) + ", " + ;
                        EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)) + ", " + ;
                        EscaparSQL(loc_lcOrigem) + ", " + ;
                        "matprincs, dtcomps, cbars, cgrus, clfiscals, colecoes, comis, " + ;
                        "cpros, cunis, custofs, cvens, datas, datatrans, dpros, dtfilms, " + ;
                        "fcustos, flagctabs, fvendas, icms, ifors, linhas, locals, margems, " + ;
                        "moecs, moecusfs, moedas, moepcs, moepvs, moevs, notas, obspeds, " + ;
                        "obspes, origmercs, pcuss, pesoms, pvens, pvideals, qmins, reffs, " + ;
                        "sittricms, tcomps, tipos, transps, valors, varias, situas, dtincs, " + ;
                        "sgrus, metals, teors, cftios, codservs, mftios, pftios, codcors, " + ;
                        "codtams, compos, montadescs, digimaxs, ordcompos, ean13, cproeqs, " + ;
                        "qtdcpnts, impetiqs, chkfunds, casas, mercs, pesobs, tamhs, tamls, " + ;
                        "tamps, tptribs, volumes, ipis, dpro2s, encoms, codacbs, cravcers, " + ;
                        "cunips, obsetqs, ultcomps, vultcomps, multcomps, markupa, tinsts, " + ;
                        "cclass, nivelqs, cftiocs, pftiocs, usuincs, diasinas, idecpros, " + ;
                        "fabrproprs, qtminfabs, tents, codfinp, codmatp, consigs, ltminsv, " + ;
                        "status, aliqipis, codgarras, descecfs, encargos, idpro, nidentfixa, " + ;
                        "pesobris, pesometal, pesopdrs, extipi, iats, dtsituas, conjunts " + ;
                        "FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_lcCPros)
                    loc_lnResult = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_lnResult < 1
                        MsgErro("Falha ao arquivar hist" + CHR(243) + "rico em SigCdPrc: " + loc_lcCPros, ;
                            "Erro sigprccpBO.AtualizarPrecos")
                        SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                        loc_lTransacaoAtiva = .F.
                        loc_llOk = .F.
                    ENDIF

                    *-- Arquivar composicao em SigPrCp2
                    IF loc_llOk
                        IF USED("cursor_4c_TmpCompo")
                            USE IN cursor_4c_TmpCompo
                        ENDIF
                        loc_cSQL = "SELECT * FROM SigPrCpo WHERE CPros = " + EscaparSQL(loc_lcCPros)
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCompo") > 0
                            SELECT cursor_4c_TmpCompo
                            GO TOP
                            SCAN
                                loc_lcIdChaves = LEFT(fUniqueIds(), 20)
                                loc_lcHora     = SUBSTR(TTOC(DATETIME()), 12, 8)
                                loc_cSQL = "INSERT INTO SigPrCp2 (" + ;
                                    "cidchaves, dataalts, horaalts, usuaalts, " + ;
                                    "cats, cgrus, cpros, datatrans, dcompos, dscgrp, etiqs, " + ;
                                    "grupos, mats, moeds, obscompos, ordems, pcompos, qtds, " + ;
                                    "qtscons, unicompos, compos, ordcompos, qtdcvs, vlrcvs, " + ;
                                    "dtmovs, cunips, markcvs, pesos, totas, tpalts, vlrpvs, " + ;
                                    "ordts, tipos, matriz, obsofs) VALUES (" + ;
                                    EscaparSQL(loc_lcIdChaves) + ", GETDATE(), " + ;
                                    EscaparSQL(loc_lcHora) + ", " + ;
                                    EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)) + ", " + ;
                                    EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.cats))      + ", " + ;
                                    EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.cgrus))     + ", " + ;
                                    EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.cpros))     + ", " + ;
                                    "NULL, " + ;
                                    EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.dcompos))   + ", " + ;
                                    EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.dscgrp))    + ", " + ;
                                    EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.etiqs))     + ", " + ;
                                    EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.grupos))    + ", " + ;
                                    EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.mats))      + ", " + ;
                                    EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.moeds))     + ", " + ;
                                    EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.obscompos)) + ", " + ;
                                    FormatarNumeroSQL(cursor_4c_TmpCompo.ordems)    + ", " + ;
                                    FormatarNumeroSQL(cursor_4c_TmpCompo.pcompos)   + ", " + ;
                                    FormatarNumeroSQL(cursor_4c_TmpCompo.qtds)      + ", " + ;
                                    FormatarNumeroSQL(cursor_4c_TmpCompo.qtscons)   + ", " + ;
                                    EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.unicompos)) + ", " + ;
                                    EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.compos))   + ", " + ;
                                    FormatarNumeroSQL(cursor_4c_TmpCompo.ordcompos) + ", " + ;
                                    FormatarNumeroSQL(cursor_4c_TmpCompo.qtdcvs)    + ", " + ;
                                    FormatarNumeroSQL(cursor_4c_TmpCompo.vlrcvs)    + ", " + ;
                                    "GETDATE(), " + ;
                                    EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.cunips))    + ", " + ;
                                    FormatarNumeroSQL(cursor_4c_TmpCompo.markcvs)   + ", " + ;
                                    FormatarNumeroSQL(cursor_4c_TmpCompo.pesos)     + ", " + ;
                                    FormatarNumeroSQL(cursor_4c_TmpCompo.totas)     + ", " + ;
                                    FormatarNumeroSQL(cursor_4c_TmpCompo.tpalts)    + ", " + ;
                                    FormatarNumeroSQL(cursor_4c_TmpCompo.vlrpvs)    + ", " + ;
                                    FormatarNumeroSQL(cursor_4c_TmpCompo.ordts)     + ", " + ;
                                    EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.tipos))    + ", " + ;
                                    EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.matriz))   + ", " + ;
                                    EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.obsofs))   + ")"
                                loc_lnResult = SQLEXEC(gnConnHandle, loc_cSQL)
                                IF loc_lnResult < 1
                                    MsgErro("Falha ao arquivar SigPrCp2: " + loc_lcCPros, ;
                                        "Erro sigprccpBO.AtualizarPrecos")
                                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                    loc_lTransacaoAtiva = .F.
                                    loc_llOk = .F.
                                    EXIT
                                ENDIF
                                SELECT cursor_4c_TmpCompo
                            ENDSCAN
                            USE IN cursor_4c_TmpCompo
                        ENDIF
                    ENDIF

                    *-- Remover tabela de reticencia de precos
                    IF loc_llOk
                        SQLEXEC(gnConnHandle, ;
                            "DELETE FROM SigPrPrt WHERE CPros = " + EscaparSQL(loc_lcCPros))
                    ENDIF

                    *-- Subgrupo por faixa de preco (se configurado)
                    IF loc_llOk AND USED("crSigCdPaC") AND !EOF("crSigCdPaC") AND ;
                        crSigCdPaC.nChkSubGrs = 1
                        IF USED("cursor_4c_SigCdPsg")
                            USE IN cursor_4c_SigCdPsg
                        ENDIF
                        loc_cSQL = "SELECT * FROM SigCdPsg WHERE CGrus = " + ;
                            EscaparSQL(ALLTRIM(crSigCdPro.cGrus)) + ;
                            " ORDER BY nFaixaFins"
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPsg") > 0
                            LOCAL loc_lnPVens
                            loc_lnPVens = IIF(crSigCdPro.Pvens = 0, crSigCdPro.pvideals, crSigCdPro.Pvens)
                            SELECT cursor_4c_SigCdPsg
                            LOCATE FOR nFaixaFins >= loc_lnPVens
                            IF !EOF("cursor_4c_SigCdPsg")
                                SQLEXEC(gnConnHandle, ;
                                    "UPDATE SigCdPro SET sGrus = " + ;
                                    EscaparSQL(ALLTRIM(cursor_4c_SigCdPsg.Codigos)) + ;
                                    " WHERE cpros = " + EscaparSQL(loc_lcCPros))
                            ENDIF
                            USE IN cursor_4c_SigCdPsg
                        ENDIF
                    ENDIF

                    *-- Atualizar SigCdPro com precos recalculados
                    IF loc_llOk AND SEEK(loc_lcCPros, "crSigCdPro", "CPros")
                        loc_lcHora = SUBSTR(TTOC(DATETIME()), 12, 8)
                        loc_cSetClauses = ;
                            "CustoFs   = " + FormatarNumeroSQL(crSigCdPro.CustoFs)    + ", " + ;
                            "Pvideals  = " + FormatarNumeroSQL(crSigCdPro.Pvideals)   + ", " + ;
                            "Pvens     = " + FormatarNumeroSQL(crSigCdPro.Pvens)      + ", " + ;
                            "Margems   = " + FormatarNumeroSQL(crSigCdPro.Margems)    + ", " + ;
                            "Encargos  = " + FormatarNumeroSQL(crSigCdPro.Encargos)   + ", " + ;
                            "PesoMs    = " + FormatarNumeroSQL(crSigCdPro.PesoMs)     + ", " + ;
                            "PCuss     = " + FormatarNumeroSQL(crSigCdPro.PCuss)      + ", " + ;
                            "pftios    = " + FormatarNumeroSQL(crSigCdPro.pftios)     + ", " + ;
                            "mFtios    = " + EscaparSQL(ALLTRIM(crSigCdPro.mFtios))   + ", " + ;
                            "Moedas    = " + EscaparSQL(ALLTRIM(crSigCdPro.Moedas))   + ", " + ;
                            "pftiocs   = " + FormatarNumeroSQL(crSigCdPro.pftiocs)    + ", " + ;
                            "cftiocs   = " + EscaparSQL(ALLTRIM(crSigCdPro.cftiocs))  + ", " + ;
                            "cftios    = " + EscaparSQL(ALLTRIM(crSigCdPro.cftios))   + ", " + ;
                            "MarkupA   = " + FormatarNumeroSQL(crSigCdPro.MarkupA)    + ", " + ;
                            "Valors    = " + FormatarNumeroSQL(crSigCdPro.Valors)     + ", " + ;
                            "ImpEtiqs  = " + IIF(par_lImpEtiq, "1", "0")              + ", " + ;
                            "DataAlts  = GETDATE(), " + ;
                            "HoraAlts  = " + EscaparSQL(loc_lcHora) + ", " + ;
                            "UsuaAlts  = " + EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10))

                        loc_cSQL = "UPDATE SigCdPro SET " + loc_cSetClauses + ;
                            " WHERE CPros = " + EscaparSQL(loc_lcCPros)
                        loc_lnResult = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_lnResult < 1
                            MsgErro("Falha ao atualizar SigCdPro: " + loc_lcCPros, ;
                                "Erro sigprccpBO.AtualizarPrecos")
                            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                            loc_lTransacaoAtiva = .F.
                            loc_llOk = .F.
                        ENDIF
                    ENDIF

                    *-- Atualizar composicao em SigPrCpo (TmpPrCpo -> UPDATE)
                    IF loc_llOk AND USED("TmpPrCpo") AND SEEK(loc_lcCPros, "TmpPrCpo", "CPros")
                        SCAN WHILE ALLTRIM(TmpPrCpo.CPros) = loc_lcCPros
                            loc_cSQL = "UPDATE SigPrCpo SET " + ;
                                "PCompos   = " + FormatarNumeroSQL(TmpPrCpo.PCompos)  + ", " + ;
                                "Moeds     = " + EscaparSQL(ALLTRIM(TmpPrCpo.Moeds))  + ", " + ;
                                "UniCompos = " + EscaparSQL(ALLTRIM(TmpPrCpo.UniCompos)) + ", " + ;
                                "CUniPs    = " + EscaparSQL(ALLTRIM(TmpPrCpo.CUniPs)) + ", " + ;
                                "Cgrus     = " + EscaparSQL(ALLTRIM(TmpPrCpo.Cgrus))  + ", " + ;
                                "DtMovs    = GETDATE(), " + ;
                                "VlrCvs    = " + FormatarNumeroSQL(TmpPrCpo.VlrCvs)   + ", " + ;
                                "QtdCvs    = " + FormatarNumeroSQL(TmpPrCpo.QtdCvs)   + ", " + ;
                                "MarkCvs   = " + FormatarNumeroSQL(TmpPrCpo.MarkCvs)  + ", " + ;
                                "VlrPvs    = " + FormatarNumeroSQL(TmpPrCpo.VlrPvs)   + ;
                                " WHERE cIdChaves = " + EscaparSQL(ALLTRIM(TmpPrCpo.cIdChaves))
                            loc_lnResult = SQLEXEC(gnConnHandle, loc_cSQL)
                            IF loc_lnResult < 1
                                MsgErro("Falha ao atualizar SigPrCpo: " + loc_lcCPros, ;
                                    "Erro sigprccpBO.AtualizarPrecos")
                                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                loc_lTransacaoAtiva = .F.
                                loc_llOk = .F.
                                EXIT
                            ENDIF
                        ENDSCAN
                    ENDIF

                    IF !loc_llOk
                        EXIT
                    ENDIF
                    SELECT cursor_4c_CsProdutos
                ENDSCAN

                loc_loBarra.Complete(.T.)
            ENDIF

            IF loc_llOk
                IF SQLEXEC(gnConnHandle, "COMMIT TRANSACTION") >= 0
                    loc_lTransacaoAtiva = .F.
                    IF !THIS.this_lAutomatico
                        MsgInfo("Processamento Finalizado com Sucesso !!!")
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                    loc_lTransacaoAtiva = .F.
                    MsgErro("Falha ao confirmar transa" + CHR(231) + CHR(227) + "o.", ;
                        "Erro sigprccpBO.AtualizarPrecos")
                ENDIF
            ELSE
                IF loc_lTransacaoAtiva
                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                    loc_lTransacaoAtiva = .F.
                ENDIF
                IF !THIS.this_lAutomatico
                    MsgErro("Falha na atualiza" + CHR(231) + CHR(227) + "o. Reinicie o Processo !!!", ;
                        "Arquivo com falha")
                ENDIF
            ENDIF

            IF USED("cursor_4c_CsProdutos")
                USE IN cursor_4c_CsProdutos
            ENDIF

            IF USED("cursor_4c_Produtos")
                ZAP IN cursor_4c_Produtos
            ENDIF

        CATCH TO loc_oErro
            IF loc_lTransacaoAtiva
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            ENDIF
            IF USED("cursor_4c_CsProdutos")
                USE IN cursor_4c_CsProdutos
            ENDIF
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro sigprccpBO.AtualizarPrecos")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ProcessaAutomatico()
    *-- Executa recalculo automatico para cada config ativa em SigCdCcp
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_lcQuery, loc_lnVaria

        loc_lSucesso = .F.

        TRY
            THIS.this_lAutomatico = .T.

            IF USED("cursor_4c_Produtos")
                ZAP IN cursor_4c_Produtos
            ENDIF

            loc_lcQuery = "SELECT * FROM SigCdCcp WHERE Inativas <> 1"
            IF USED("crSigCdCcp")
                USE IN crSigCdCcp
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_lcQuery, "crSigCdCcp") < 1
                MsgErro("Favor Reinicializar o Processo!!!", ;
                    "Falha na Conex" + CHR(227) + "o (crSigCdCcp)")
            ELSE
                SELECT crSigCdCcp
                GO TOP
                SCAN
                    IF USED("cursor_4c_Produtos")
                        ZAP IN cursor_4c_Produtos
                    ENDIF

                    SELECT crSigCdCcp
                    THIS.CarregarDoCursor("crSigCdCcp")

                    IF THIS.Processar()
                        SELECT cursor_4c_Produtos
                        loc_lnVaria = THIS.this_nVariacao
                        IF loc_lnVaria > 0
                            DELETE FOR PVarias < loc_lnVaria
                        ENDIF
                        IF loc_lnVaria < 0
                            DELETE FOR PVarias > loc_lnVaria
                        ENDIF
                        SET ORDER TO CPros
                        GO TOP

                        IF !THIS.AtualizarPrecos(.F.)
                            EXIT
                        ENDIF
                    ENDIF

                    SELECT crSigCdCcp
                ENDSCAN

                USE IN crSigCdCcp
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro sigprccpBO.ProcessaAutomatico")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
    *-- Persiste a configuracao corrente em SigCdCcp (modo automatico).
    *-- Gera cIdChaves via fUniqueIds() quando ainda nao ha chave carregada.
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cChave, loc_cEmpresa
        loc_lSucesso = .F.

        TRY
            IF gnConnHandle <= 0
                MsgErro("Sem conex" + CHR(227) + "o com o banco de dados.", ;
                    "Erro sigprccpBO.Inserir")
            ELSE
                IF EMPTY(THIS.this_cIdChaves)
                    IF TYPE("fUniqueIds") = "U"
                        loc_cChave = SYS(2015)
                    ELSE
                        loc_cChave = fUniqueIds()
                    ENDIF
                    THIS.this_cIdChaves = LEFT(ALLTRIM(loc_cChave), 20)
                ENDIF

                loc_cEmpresa = ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))
                IF EMPTY(loc_cEmpresa)
                    loc_cEmpresa = ALLTRIM(THIS.this_cEmpresa)
                ENDIF

                loc_cSQL = "INSERT INTO SigCdCcp (" + ;
                    "cIdChaves, codigo, Inativas, " + ;
                    "cfornecs, merci, mercf, cgrui, cgruf, sgrui, sgruf, " + ;
                    "cunii, cunif, lini, linf, coli, colf, " + ;
                    "moedai, moedaf, opcmoedatp, " + ;
                    "mrki, mrkf, enci, encf, variacao, feitio, " + ;
                    "opcsit, opcrecalc, reajuste, encargo, nmrk, opcpven, newmkp" + ;
                    ") VALUES (" + ;
                    EscaparSQL(THIS.this_cIdChaves) + ", " + ;
                    EscaparSQL(loc_cEmpresa) + ", " + ;
                    "0, " + ;
                    EscaparSQL(THIS.this_cCFornecs) + ", " + ;
                    EscaparSQL(THIS.this_cMercI) + ", " + ;
                    EscaparSQL(THIS.this_cMercF) + ", " + ;
                    EscaparSQL(THIS.this_cCGrui) + ", " + ;
                    EscaparSQL(THIS.this_cCGruf) + ", " + ;
                    EscaparSQL(THIS.this_cSGruI) + ", " + ;
                    EscaparSQL(THIS.this_cSGruF) + ", " + ;
                    EscaparSQL(THIS.this_cCUniI) + ", " + ;
                    EscaparSQL(THIS.this_cCUnif) + ", " + ;
                    EscaparSQL(THIS.this_cLini) + ", " + ;
                    EscaparSQL(THIS.this_cLinf) + ", " + ;
                    EscaparSQL(THIS.this_cColi) + ", " + ;
                    EscaparSQL(THIS.this_cColf) + ", " + ;
                    EscaparSQL(THIS.this_cMoedai) + ", " + ;
                    EscaparSQL(THIS.this_cMoedaf) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nOpcMoedaTp, 0) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nMrki, 2) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nMrkf, 2) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nEnci, 2) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nEncf, 2) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nVariacao, 2) + ", " + ;
                    EscaparSQL(THIS.this_cFeitio) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nOpcSituacao, 0) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nOpcRecalc, 0) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nReajuste, 2) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nEncargo, 2) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nNMrk, 2) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nOpcPven, 0) + ", " + ;
                    EscaparSQL(THIS.this_cNewMkp) + ")"

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                    MsgErro("Falha ao inserir configura" + CHR(231) + CHR(227) + ;
                        "o em SigCdCcp.", "Erro sigprccpBO.Inserir")
                ELSE
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro sigprccpBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
    *-- Atualiza a configuracao SigCdCcp identificada por this_cIdChaves.
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        loc_lSucesso = .F.

        TRY
            IF gnConnHandle <= 0
                MsgErro("Sem conex" + CHR(227) + "o com o banco de dados.", ;
                    "Erro sigprccpBO.Atualizar")
            ELSE
                IF EMPTY(THIS.this_cIdChaves)
                    MsgAviso("Configura" + CHR(231) + CHR(227) + ;
                        "o sem chave: use Inserir para gravar uma nova.", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    loc_cSQL = "UPDATE SigCdCcp SET " + ;
                        "cfornecs = "   + EscaparSQL(THIS.this_cCFornecs) + ", " + ;
                        "merci = "      + EscaparSQL(THIS.this_cMercI) + ", " + ;
                        "mercf = "      + EscaparSQL(THIS.this_cMercF) + ", " + ;
                        "cgrui = "      + EscaparSQL(THIS.this_cCGrui) + ", " + ;
                        "cgruf = "      + EscaparSQL(THIS.this_cCGruf) + ", " + ;
                        "sgrui = "      + EscaparSQL(THIS.this_cSGruI) + ", " + ;
                        "sgruf = "      + EscaparSQL(THIS.this_cSGruF) + ", " + ;
                        "cunii = "      + EscaparSQL(THIS.this_cCUniI) + ", " + ;
                        "cunif = "      + EscaparSQL(THIS.this_cCUnif) + ", " + ;
                        "lini = "       + EscaparSQL(THIS.this_cLini) + ", " + ;
                        "linf = "       + EscaparSQL(THIS.this_cLinf) + ", " + ;
                        "coli = "       + EscaparSQL(THIS.this_cColi) + ", " + ;
                        "colf = "       + EscaparSQL(THIS.this_cColf) + ", " + ;
                        "moedai = "     + EscaparSQL(THIS.this_cMoedai) + ", " + ;
                        "moedaf = "     + EscaparSQL(THIS.this_cMoedaf) + ", " + ;
                        "opcmoedatp = " + FormatarNumeroSQL(THIS.this_nOpcMoedaTp, 0) + ", " + ;
                        "mrki = "       + FormatarNumeroSQL(THIS.this_nMrki, 2) + ", " + ;
                        "mrkf = "       + FormatarNumeroSQL(THIS.this_nMrkf, 2) + ", " + ;
                        "enci = "       + FormatarNumeroSQL(THIS.this_nEnci, 2) + ", " + ;
                        "encf = "       + FormatarNumeroSQL(THIS.this_nEncf, 2) + ", " + ;
                        "variacao = "   + FormatarNumeroSQL(THIS.this_nVariacao, 2) + ", " + ;
                        "feitio = "     + EscaparSQL(THIS.this_cFeitio) + ", " + ;
                        "opcsit = "     + FormatarNumeroSQL(THIS.this_nOpcSituacao, 0) + ", " + ;
                        "opcrecalc = "  + FormatarNumeroSQL(THIS.this_nOpcRecalc, 0) + ", " + ;
                        "reajuste = "   + FormatarNumeroSQL(THIS.this_nReajuste, 2) + ", " + ;
                        "encargo = "    + FormatarNumeroSQL(THIS.this_nEncargo, 2) + ", " + ;
                        "nmrk = "       + FormatarNumeroSQL(THIS.this_nNMrk, 2) + ", " + ;
                        "opcpven = "    + FormatarNumeroSQL(THIS.this_nOpcPven, 0) + ", " + ;
                        "newmkp = "     + EscaparSQL(THIS.this_cNewMkp) + " " + ;
                        "WHERE cIdChaves = " + EscaparSQL(THIS.this_cIdChaves)

                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                        MsgErro("Falha ao atualizar configura" + CHR(231) + ;
                            CHR(227) + "o em SigCdCcp.", "Erro sigprccpBO.Atualizar")
                    ELSE
                        THIS.RegistrarAuditoria("UPDATE")
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro sigprccpBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
    *-- Registra a operacao em LogAuditoria (INSERT/UPDATE/DELETE/PROCESS).
    *--------------------------------------------------------------------------
        LOCAL loc_oErro, loc_cSQL, loc_cUsuario, loc_cEmpresa, loc_cChave

        TRY
            IF gnConnHandle > 0
                loc_cUsuario = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
                loc_cEmpresa = ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))
                IF EMPTY(loc_cEmpresa)
                    loc_cEmpresa = ALLTRIM(THIS.this_cEmpresa)
                ENDIF
                loc_cChave = THIS.ObterChavePrimaria()

                loc_cSQL = "INSERT INTO LogAuditoria " + ;
                    "(DataHora, Usuario, Tabela, Operacao, ChaveRegistro) " + ;
                    "VALUES (GETDATE(), " + ;
                    EscaparSQL(loc_cUsuario) + ", " + ;
                    EscaparSQL("SigCdCcp") + ", " + ;
                    EscaparSQL(par_cOperacao) + ", " + ;
                    EscaparSQL(loc_cChave) + ")"

                =SQLEXEC(gnConnHandle, loc_cSQL)
            ENDIF
        CATCH TO loc_oErro
            *-- Auditoria nao deve interromper fluxo principal
        ENDTRY
    ENDPROC

ENDDEFINE
