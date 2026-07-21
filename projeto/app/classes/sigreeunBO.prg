*==============================================================================
* SIGREEUNBO.PRG
* Business Object para Relatorio: Posicao de Estoque por Unidade
*
* Formulario original: SIGREEUN.SCX (frmrelatorio)
* Herda de: RelatorioBase
*
* Filtros do relatorio:
*   - Grupo de Estoque (get_cd_grestoque / get_ds_grestoque)
*   - Estoque        (get_cd_estoque   / get_ds_estoque)
*   - Unidade        (get_grupo        / get_grupo_desc)  -> SigCdUni (cunis/dunis)
*   - Data           (get_data)
*   - Moeda          (get_moeda        / get_moeda_desc)  -> SigCdMoe (cmoes/dmoes)
*   - Data Cotacao   (get_dt_cotacao)
*   - Imprimir Cotacao (opt_dados_cotacao, 1=Sim/2=Nao)
*   - Fator de Venda   (Opc_fator,       1=Sim/2=Nao)
*==============================================================================

DEFINE CLASS sigreeunBO AS RelatorioBase

    *-- Filtro: Grupo de Estoque (empgruests - parte grupo)
    this_cCdGrestoque  = ""
    this_cDsGrestoque  = ""

    *-- Filtro: Estoque (empgruests - parte estoque)
    this_cCdEstoque    = ""
    this_cDsEstoque    = ""

    *-- Filtro: Unidade de Produto (SigCdUni: cunis / dunis)
    this_cGrupo        = ""
    this_cGrupoDesc    = ""

    *-- Filtro: Data de referencia da posicao
    this_dData         = {}

    *-- Filtro: Moeda para conversao de valores (SigCdMoe: cmoes / dmoes)
    this_cMoeda        = ""
    this_cMoedaDesc    = ""

    *-- Filtro: Data da cotacao da moeda
    this_dDtCotacao    = {}

    *-- Filtro: Imprimir tabela de cotacoes? (1=Sim / 2=Nao)
    this_nDadosCotacao = 1

    *-- Filtro: Agrupar por fator de venda? (1=Sim / 2=Nao)
    this_nOpcFator     = 1

    *-- Controle interno (cursor consumido pelo FRX legado ? dbRelatorio eh o detail band)
    this_cCursorDados  = "dbRelatorio"

    *--------------------------------------------------------------------------
    * Init - Configura tabela principal e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "cpros"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Verifica campos obrigatorios antes do processamento
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFiltros()
        IF EMPTY(THIS.this_dData)
            THIS.this_cMensagemErro = "Data " + CHR(233) + " obrigat" + CHR(243) + "ria!"
            RETURN .F.
        ENDIF
        IF EMPTY(ALLTRIM(THIS.this_cMoeda))
            THIS.this_cMensagemErro = "Moeda " + CHR(233) + " obrigat" + CHR(243) + "ria!"
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_dDtCotacao)
            THIS.this_cMensagemErro = "Data da Cota" + CHR(231) + CHR(227) + "o " + ;
                CHR(233) + " obrigat" + CHR(243) + "ria!"
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarCotacao - Acumula taxa de cambio de uma moeda em TempMoe
    * Equivalente ao bloco Seek/Append Blank de TempMoe no processamento original
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarCotacao(par_cMoeda, par_dData)
        IF EMPTY(ALLTRIM(NVL(par_cMoeda, "")))
            RETURN
        ENDIF
        SELECT TempMoe
        SET ORDER TO cmoes
        IF !SEEK(par_cMoeda, "TempMoe", "cmoes")
            APPEND BLANK
            REPLACE TempMoe.cmoes   WITH par_cMoeda
            REPLACE TempMoe.cotacao WITH fBuscarCotacao(ALLTRIM(par_cMoeda), par_dData)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Prepara cursores para o relatorio de posicao de estoque
    *                 por unidade.
    * Equivalente ao metodo 'processamento' do form legado SIGREEUN.
    *
    * Cria cursores:
    *   dbCabecalho  (NomeEmpresa, Titulo, SubTitulo, Cabecalho) - lido pelo FRX
    *   dbRelatorio  (Detalhe)                                    - lido pelo FRX
    * Cursores intermediarios (sufixo Ru=com unidade, All=sem unidade):
    *   TempMoe    - cotacoes de moeda acumuladas
    *   dbRelat    - totais por unidade + fator de venda
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_lFalhou
        LOCAL loc_cNomeEmpresa, loc_cTitulo, loc_cSubTitulo, loc_cCabecalho
        LOCAL loc_lcGrupo, loc_lcEstoque, loc_lcUnid
        LOCAL loc_ldData, loc_lcMoeda, loc_lcDescMoeda, loc_ldDtCotacao
        LOCAL loc_lDadosCotacao, loc_lnFator
        LOCAL loc_llPosAtu
        LOCAL loc_lcGrEstIni, loc_lcGrEstFim, loc_lcEstIni, loc_lcEstFim
        LOCAL loc_lcEGEInis, loc_lcEGEFims
        LOCAL loc_cSQL
        LOCAL loc_lcCodPro, loc_lnValor, loc_lnCusto, loc_lnValFat
        LOCAL loc_lcFatVens, loc_lnSqtds
        LOCAL loc_nTotQtds, loc_nTotCusto, loc_nTotVenda
        LOCAL loc_cDetalhe, loc_cTotal
        LOCAL lcData

        loc_lSucesso = .F.
        loc_lFalhou  = .F.

        TRY
            *-- 1. Validar filtros obrigatorios
            IF !THIS.ValidarFiltros()
                loc_lFalhou = .T.
            ENDIF

            *-- 2. Inicializar variaveis e cursores
            IF !loc_lFalhou
                loc_lcGrupo       = ALLTRIM(THIS.this_cCdGrestoque)
                loc_lcEstoque     = ALLTRIM(THIS.this_cCdEstoque)
                loc_lcUnid        = ALLTRIM(THIS.this_cGrupo)
                loc_ldData        = THIS.this_dData
                loc_lcMoeda       = ALLTRIM(THIS.this_cMoeda)
                loc_lcDescMoeda   = ALLTRIM(THIS.this_cMoedaDesc)
                loc_ldDtCotacao   = THIS.this_dDtCotacao
                loc_lDadosCotacao = THIS.this_nDadosCotacao
                loc_lnFator       = THIS.this_nOpcFator
                loc_llPosAtu      = (loc_ldData = DATE())
                lcData            = fDtoSQL(loc_ldData, "23:59:59")

                *-- Buscar nome da empresa
                loc_cNomeEmpresa = ""
                IF SQLEXEC(gnConnHandle, ;
                    "SELECT razas FROM SigCdEmp WHERE cemps = " + ;
                    EscaparSQL(go_4c_Sistema.cCodEmpresa), ;
                    "cursor_4c_sigEmpReeun") > 0
                    SELECT cursor_4c_sigEmpReeun
                    IF !EOF()
                        loc_cNomeEmpresa = ALLTRIM(razas)
                    ENDIF
                    USE IN cursor_4c_sigEmpReeun
                ENDIF

                *-- Montar textos do relatorio
                loc_cTitulo    = "Posi" + CHR(231) + CHR(227) + ;
                    "o de Estoque p/ Unidade de Produto em " + DTOC(loc_ldData)
                loc_cSubTitulo = IIF(EMPTY(loc_lcMoeda), "", "Valores em " + loc_lcDescMoeda)

                loc_cCabecalho = PADC("Cod", 3, "_") + " "
                loc_cCabecalho = loc_cCabecalho + ;
                    PADC("Descri" + CHR(231) + CHR(227) + "o", 20, "_") + " "
                loc_cCabecalho = loc_cCabecalho + PADC("Fator de Venda", 14, "_") + " "
                loc_cCabecalho = loc_cCabecalho + PADC("Qtde.",          10, "_") + " "
                loc_cCabecalho = loc_cCabecalho + PADC("Vl.Custo",       17, "_") + " "
                loc_cCabecalho = loc_cCabecalho + PADC("Vl.Venda",       17, "_")

                *-- Cursor de cabecalho para o FRX (nome EXATO original: dbCabecalho)
                IF USED("dbCabecalho")
                    USE IN dbCabecalho
                ENDIF
                CREATE CURSOR dbCabecalho ;
                    (NomeEmpresa C(80), Titulo C(80), SubTitulo C(80), Cabecalho C(200))
                INSERT INTO dbCabecalho (NomeEmpresa, Titulo, SubTitulo, Cabecalho) ;
                    VALUES (loc_cNomeEmpresa, loc_cTitulo, loc_cSubTitulo, loc_cCabecalho)

                *-- Cursor de detalhes para o FRX (nome EXATO original: dbRelatorio)
                IF USED("dbRelatorio")
                    USE IN dbRelatorio
                ENDIF
                CREATE CURSOR dbRelatorio (Detalhe C(200))

                *-- Cursor de cotacoes acumuladas por moeda
                IF USED("TempMoe")
                    USE IN TempMoe
                ENDIF
                SET NULL ON
                CREATE CURSOR TempMoe (cmoes C(3), cotacao N(14,4))
                SET NULL OFF
                INDEX ON cmoes TAG cmoes

                *-- Cursor de totais por unidade + fator de venda
                IF USED("dbRelat")
                    USE IN dbRelat
                ENDIF
                SET NULL ON
                CREATE CURSOR dbRelat ;
                    (cunis C(3), dunis C(20), qtds N(10,3), ;
                     vends N(15,2), custs N(15,2), fatvens C(3))
                SET NULL OFF
                INDEX ON cunis + fatvens TAG cunis
                INDEX ON dunis + fatvens TAG descrs

                *-- Montar ranges de empgruests para filtros
                loc_lcGrEstIni = IIF(!EMPTY(loc_lcGrupo), ;
                    PADR(loc_lcGrupo, 10), SPACE(10))
                loc_lcGrEstFim = IIF(!EMPTY(loc_lcGrupo), ;
                    PADR(loc_lcGrupo, 10), REPLICATE(CHR(254), 10))
                loc_lcEstIni   = IIF(!EMPTY(loc_lcEstoque), ;
                    PADR(loc_lcEstoque, 10), SPACE(10))
                loc_lcEstFim   = IIF(!EMPTY(loc_lcEstoque), ;
                    PADR(loc_lcEstoque, 10), REPLICATE(CHR(254), 10))
                loc_lcEGEInis  = go_4c_Sistema.cCodEmpresa + loc_lcGrEstIni + loc_lcEstIni
                loc_lcEGEFims  = go_4c_Sistema.cCodEmpresa + loc_lcGrEstFim + loc_lcEstFim
            ENDIF

            *-- ==================================================================
            *-- CAMINHO 1: Com filtro de unidade (lcUnid preenchido)
            *-- ==================================================================
            IF !loc_lFalhou AND !EMPTY(loc_lcUnid)

                WAIT WINDOW "Aguarde! Selecionando Produtos..." NOWAIT

                loc_cSQL = "SELECT a.cpros, a.cunis, c.dunis, a.linhas, " + ;
                    "b.tpcustos, a.pesoms, a.pvens, a.moevs, " + ;
                    "a.fvendas, a.moepvs, a.custofs, a.moecusfs " + ;
                    "FROM SigCdPro a " + ;
                    "LEFT JOIN SigCdLin b ON b.linhas = a.linhas " + ;
                    "LEFT JOIN SigCdUni c ON c.cunis  = a.cunis " + ;
                    "WHERE a.cunis = " + EscaparSQL(loc_lcUnid)

                IF USED("cursor_4c_SigCdProRu")
                    USE IN cursor_4c_SigCdProRu
                ENDIF
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdProRu") < 1
                    THIS.this_cMensagemErro = "Erro ao consultar SigCdPro (unidade " + ;
                        loc_lcUnid + ")"
                    loc_lFalhou = .T.
                ENDIF

                IF !loc_lFalhou
                    SELECT cursor_4c_SigCdProRu
                    GO TOP
                    SCAN WHILE !loc_lFalhou
                        loc_lcCodPro = cursor_4c_SigCdProRu.cpros

                        IF USED("cursor_4c_TmpSaldoRu")
                            USE IN cursor_4c_TmpSaldoRu
                        ENDIF

                        IF loc_llPosAtu
                            *-- Posicao atual: buscar em SigMvEst
                            loc_cSQL = "SELECT sqtds FROM SigMvEst " + ;
                                "WHERE cpros = " + EscaparSQL(ALLTRIM(loc_lcCodPro)) + ;
                                " AND empgruests BETWEEN " + ;
                                EscaparSQL(loc_lcEGEInis) + ;
                                " AND " + EscaparSQL(loc_lcEGEFims)

                            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpSaldoRu") < 1
                                THIS.this_cMensagemErro = "Erro ao consultar SigMvEst"
                                loc_lFalhou = .T.
                                LOOP
                            ENDIF
                            SELECT cursor_4c_TmpSaldoRu
                            GO TOP
                            IF EOF() OR cursor_4c_TmpSaldoRu.sqtds = 0
                                SELECT cursor_4c_SigCdProRu
                                LOOP
                            ENDIF
                            loc_lnSqtds = cursor_4c_TmpSaldoRu.sqtds
                        ELSE
                            *-- Posicao historica: buscar em SigMvHst
                            loc_cSQL = "SELECT TOP 1 SQtds FROM SigMvHst " + ;
                                "WHERE CPros = " + EscaparSQL(ALLTRIM(loc_lcCodPro)) + ;
                                " AND EmpGruEsts BETWEEN " + ;
                                EscaparSQL(loc_lcEGEInis) + ;
                                " AND " + EscaparSQL(loc_lcEGEFims) + ;
                                " AND Datas <= ?lcData ORDER BY CIdChaves DESC"

                            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpSaldoRu") < 1
                                THIS.this_cMensagemErro = "Erro ao consultar SigMvHst (historico)"
                                loc_lFalhou = .T.
                                LOOP
                            ENDIF
                            SELECT cursor_4c_TmpSaldoRu
                            GO TOP
                            IF EOF() OR cursor_4c_TmpSaldoRu.SQtds = 0
                                SELECT cursor_4c_SigCdProRu
                                LOOP
                            ENDIF
                            loc_lnSqtds = cursor_4c_TmpSaldoRu.SQtds
                        ENDIF

                        *-- Calcular valor de venda convertido para moeda selecionada
                        loc_lnValor = cursor_4c_SigCdProRu.pvens * loc_lnSqtds
                        loc_lnValor = loc_lnValor * ;
                            fBuscarCotacao(cursor_4c_SigCdProRu.moevs, loc_ldData) / ;
                            fBuscarCotacao(loc_lcMoeda, loc_ldData)

                        *-- Calcular custo convertido (tipo 2 = pesoms * custofs)
                        loc_lnCusto = cursor_4c_SigCdProRu.custofs
                        IF NVL(cursor_4c_SigCdProRu.tpcustos, "") = "2"
                            loc_lnCusto = cursor_4c_SigCdProRu.pesoms * cursor_4c_SigCdProRu.custofs
                        ENDIF
                        loc_lnCusto = loc_lnCusto * loc_lnSqtds * ;
                            fBuscarCotacao(cursor_4c_SigCdProRu.moecusfs, loc_ldData) / ;
                            fBuscarCotacao(loc_lcMoeda, loc_ldData)

                        *-- Aplicar fator de venda
                        loc_lnValFat = IIF(cursor_4c_SigCdProRu.fvendas = 0, 1, ;
                            cursor_4c_SigCdProRu.fvendas * ;
                            fBuscarCotacao(cursor_4c_SigCdProRu.moepvs, loc_ldData))
                        loc_lnValor = loc_lnValor * loc_lnValFat

                        *-- Registrar cotacoes das moedas utilizadas
                        THIS.RegistrarCotacao(cursor_4c_SigCdProRu.moevs,    loc_ldData)
                        THIS.RegistrarCotacao(THIS.this_cMoeda,               loc_ldData)
                        THIS.RegistrarCotacao(cursor_4c_SigCdProRu.moecusfs, loc_ldData)
                        THIS.RegistrarCotacao(cursor_4c_SigCdProRu.moepvs,   loc_ldData)

                        *-- Fator de agrupamento por moeda do preco de venda
                        IF loc_lnFator = 1
                            loc_lcFatVens = cursor_4c_SigCdProRu.moepvs
                        ELSE
                            loc_lcFatVens = "   "
                        ENDIF

                        *-- Acumular totais por unidade em dbRelat
                        SELECT dbRelat
                        SET ORDER TO cunis
                        IF !SEEK(cursor_4c_SigCdProRu.cunis + loc_lcFatVens, ;
                                 "dbRelat", "cunis")
                            APPEND BLANK
                            REPLACE dbRelat.cunis   WITH cursor_4c_SigCdProRu.cunis
                            REPLACE dbRelat.fatvens WITH loc_lcFatVens
                            REPLACE dbRelat.dunis   WITH NVL(cursor_4c_SigCdProRu.dunis, "")
                        ENDIF
                        REPLACE dbRelat.qtds  WITH dbRelat.qtds  + loc_lnSqtds
                        REPLACE dbRelat.vends WITH dbRelat.vends + loc_lnValor
                        REPLACE dbRelat.custs WITH dbRelat.custs + loc_lnCusto

                        SELECT cursor_4c_SigCdProRu
                    ENDSCAN
                ENDIF

                WAIT CLEAR

                IF USED("cursor_4c_SigCdProRu")
                    USE IN cursor_4c_SigCdProRu
                ENDIF
                IF USED("cursor_4c_TmpSaldoRu")
                    USE IN cursor_4c_TmpSaldoRu
                ENDIF

            *-- ==================================================================
            *-- CAMINHO 2: Sem filtro de unidade (todos os produtos em estoque)
            *-- ==================================================================
            ELSE
                IF !loc_lFalhou

                WAIT WINDOW "Aguarde! Selecionando Produtos..." NOWAIT

                IF USED("cursor_4c_TmpSaldoAll")
                    USE IN cursor_4c_TmpSaldoAll
                ENDIF

                IF loc_llPosAtu
                    *-- Posicao atual: buscar todos os produtos em SigMvEst
                    loc_cSQL = "SELECT cpros, sqtds, cidchaves FROM SigMvEst " + ;
                        "WHERE empgruests BETWEEN " + ;
                        EscaparSQL(loc_lcEGEInis) + " AND " + EscaparSQL(loc_lcEGEFims) + ;
                        " GROUP BY cidchaves, cpros, sqtds"
                ELSE
                    *-- Posicao historica: buscar produtos distintos em SigMvHst
                    loc_cSQL = "SELECT cpros FROM SigMvHst " + ;
                        "WHERE empgruests BETWEEN " + ;
                        EscaparSQL(loc_lcEGEInis) + " AND " + EscaparSQL(loc_lcEGEFims) + ;
                        " GROUP BY cpros"
                ENDIF

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpSaldoAll") < 1
                    THIS.this_cMensagemErro = "Erro ao selecionar produtos em estoque"
                    loc_lFalhou = .T.
                ENDIF

                IF !loc_lFalhou
                    SELECT cursor_4c_TmpSaldoAll
                    GO TOP
                    IF !EOF()
                        SCAN WHILE !loc_lFalhou
                            loc_lcCodPro = cursor_4c_TmpSaldoAll.cpros

                            *-- Buscar dados do produto em SigCdPro
                            IF USED("cursor_4c_TmpProAll")
                                USE IN cursor_4c_TmpProAll
                            ENDIF
                            loc_cSQL = "SELECT a.cpros, a.cunis, c.dunis, a.linhas, " + ;
                                "b.tpcustos, a.pesoms, a.pvens, a.moevs, " + ;
                                "a.fvendas, a.moepvs, a.custofs, a.moecusfs " + ;
                                "FROM SigCdPro a " + ;
                                "LEFT JOIN SigCdLin b ON b.linhas = a.linhas " + ;
                                "LEFT JOIN SigCdUni c ON c.cunis  = a.cunis " + ;
                                "WHERE a.cpros = " + EscaparSQL(ALLTRIM(loc_lcCodPro))

                            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpProAll") < 1
                                THIS.this_cMensagemErro = "Erro ao buscar produto " + ;
                                    ALLTRIM(loc_lcCodPro)
                                loc_lFalhou = .T.
                                LOOP
                            ENDIF

                            SELECT cursor_4c_TmpProAll
                            GO TOP
                            IF EOF()
                                SELECT cursor_4c_TmpSaldoAll
                                LOOP
                            ENDIF

                            *-- Quantidade: atual de TmpSaldoAll ou historica de SigMvHst
                            IF loc_llPosAtu
                                loc_lnSqtds = cursor_4c_TmpSaldoAll.sqtds
                            ELSE
                                IF USED("cursor_4c_TmpHisAll")
                                    USE IN cursor_4c_TmpHisAll
                                ENDIF
                                loc_cSQL = "SELECT TOP 1 SQtds FROM SigMvHst " + ;
                                    "WHERE CPros = " + EscaparSQL(ALLTRIM(loc_lcCodPro)) + ;
                                    " AND EmpGruEsts BETWEEN " + ;
                                    EscaparSQL(loc_lcEGEInis) + ;
                                    " AND " + EscaparSQL(loc_lcEGEFims) + ;
                                    " AND datas <= ?lcData ORDER BY CIdChaves DESC"

                                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpHisAll") < 1
                                    THIS.this_cMensagemErro = "Erro ao consultar historico"
                                    loc_lFalhou = .T.
                                    LOOP
                                ENDIF
                                SELECT cursor_4c_TmpHisAll
                                GO TOP
                                IF EOF()
                                    SELECT cursor_4c_TmpSaldoAll
                                    LOOP
                                ENDIF
                                loc_lnSqtds = cursor_4c_TmpHisAll.SQtds
                            ENDIF

                            *-- Calcular valor de venda convertido
                            loc_lnValor = cursor_4c_TmpProAll.pvens * loc_lnSqtds
                            loc_lnValor = loc_lnValor * ;
                                fBuscarCotacao(cursor_4c_TmpProAll.moevs, loc_ldData) / ;
                                fBuscarCotacao(loc_lcMoeda, loc_ldData)

                            *-- Calcular custo convertido
                            loc_lnCusto = cursor_4c_TmpProAll.custofs
                            IF NVL(cursor_4c_TmpProAll.tpcustos, "") = "2"
                                loc_lnCusto = cursor_4c_TmpProAll.pesoms * cursor_4c_TmpProAll.custofs
                            ENDIF
                            loc_lnCusto = loc_lnCusto * loc_lnSqtds * ;
                                fBuscarCotacao(cursor_4c_TmpProAll.moecusfs, loc_ldData) / ;
                                fBuscarCotacao(loc_lcMoeda, loc_ldData)

                            *-- Aplicar fator de venda
                            loc_lnValFat = IIF(cursor_4c_TmpProAll.fvendas = 0, 1, ;
                                cursor_4c_TmpProAll.fvendas * ;
                                fBuscarCotacao(cursor_4c_TmpProAll.moepvs, loc_ldData))
                            loc_lnValor = loc_lnValor * loc_lnValFat

                            *-- Registrar cotacoes das moedas utilizadas
                            THIS.RegistrarCotacao(cursor_4c_TmpProAll.moevs,    loc_ldData)
                            THIS.RegistrarCotacao(THIS.this_cMoeda,              loc_ldData)
                            THIS.RegistrarCotacao(cursor_4c_TmpProAll.moecusfs, loc_ldData)
                            THIS.RegistrarCotacao(cursor_4c_TmpProAll.moepvs,   loc_ldData)

                            *-- Fator de agrupamento
                            IF loc_lnFator = 1
                                loc_lcFatVens = cursor_4c_TmpProAll.moepvs
                            ELSE
                                loc_lcFatVens = "   "
                            ENDIF

                            *-- Acumular em dbRelat
                            SELECT dbRelat
                            SET ORDER TO cunis
                            IF !SEEK(cursor_4c_TmpProAll.cunis + loc_lcFatVens, ;
                                     "dbRelat", "cunis")
                                APPEND BLANK
                                REPLACE dbRelat.cunis   WITH cursor_4c_TmpProAll.cunis
                                REPLACE dbRelat.fatvens WITH loc_lcFatVens
                                REPLACE dbRelat.dunis   WITH NVL(cursor_4c_TmpProAll.dunis, "")
                            ENDIF
                            REPLACE dbRelat.qtds  WITH dbRelat.qtds  + loc_lnSqtds
                            REPLACE dbRelat.vends WITH dbRelat.vends + loc_lnValor
                            REPLACE dbRelat.custs WITH dbRelat.custs + loc_lnCusto

                            SELECT cursor_4c_TmpSaldoAll
                        ENDSCAN
                    ENDIF
                ENDIF

                WAIT CLEAR

                IF USED("cursor_4c_TmpSaldoAll")
                    USE IN cursor_4c_TmpSaldoAll
                ENDIF
                IF USED("cursor_4c_TmpProAll")
                    USE IN cursor_4c_TmpProAll
                ENDIF
                IF USED("cursor_4c_TmpHisAll")
                    USE IN cursor_4c_TmpHisAll
                ENDIF

                ENDIF
            ENDIF

            *-- ==================================================================
            *-- FORMATACAO FINAL: dbRelat -> dbRelatorio
            *-- ==================================================================
            IF !loc_lFalhou

                loc_nTotQtds  = 0
                loc_nTotCusto = 0
                loc_nTotVenda = 0

                SELECT dbRelat
                GO TOP
                SCAN
                    loc_cDetalhe = PADR(dbRelat.cunis, 3) + " "
                    loc_cDetalhe = loc_cDetalhe + PADR(dbRelat.dunis, 20) + " "
                    loc_cDetalhe = loc_cDetalhe + PADC(dbRelat.fatvens, 14) + " "
                    loc_cDetalhe = loc_cDetalhe + ;
                        PADL(TRANSFORM(dbRelat.qtds,  "999999.999"), 10) + " "
                    loc_cDetalhe = loc_cDetalhe + ;
                        PADL(TRANSFORM(dbRelat.custs, "99,999,999,999.99"), 17) + " "
                    loc_cDetalhe = loc_cDetalhe + ;
                        PADL(TRANSFORM(dbRelat.vends, "99,999,999,999.99"), 17)
                    INSERT INTO dbRelatorio (Detalhe) VALUES (loc_cDetalhe)

                    loc_nTotQtds  = loc_nTotQtds  + dbRelat.qtds
                    loc_nTotCusto = loc_nTotCusto + dbRelat.custs
                    loc_nTotVenda = loc_nTotVenda + dbRelat.vends
                ENDSCAN

                *-- Linha separadora de totais
                loc_cTotal = SPACE(40) + ;
                    REPLICATE("_", 10) + " " + ;
                    REPLICATE("_", 17) + " " + ;
                    REPLICATE("_", 17) + " "
                INSERT INTO dbRelatorio (Detalhe) VALUES (loc_cTotal)

                *-- Linha de totais gerais
                loc_cTotal = PADL("Total : ", 40)
                loc_cTotal = loc_cTotal + ;
                    PADL(TRANSFORM(loc_nTotQtds,  "999999.999"), 10) + " "
                loc_cTotal = loc_cTotal + ;
                    PADL(TRANSFORM(loc_nTotCusto, "99,999,999,999.99"), 17) + " "
                loc_cTotal = loc_cTotal + ;
                    PADL(TRANSFORM(loc_nTotVenda, "99,999,999,999.99"), 17) + " "
                INSERT INTO dbRelatorio (Detalhe) VALUES (loc_cTotal)

                *-- Secao de cotacoes (se solicitado e com moeda preenchida)
                IF loc_lDadosCotacao = 1 AND !EMPTY(loc_lcMoeda)
                    SELECT TempMoe
                    GO TOP
                    IF !EOF()
                        INSERT INTO dbRelatorio (Detalhe) VALUES ("")
                        INSERT INTO dbRelatorio (Detalhe) VALUES ("")

                        loc_cDetalhe = "Cota" + CHR(231) + CHR(227) + ;
                            "es de " + DTOC(loc_ldDtCotacao)
                        INSERT INTO dbRelatorio (Detalhe) VALUES (loc_cDetalhe)
                        INSERT INTO dbRelatorio (Detalhe) VALUES ("")

                        loc_cDetalhe = PADC("Moeda", 5) + " " + ;
                            PADC("Cota" + CHR(231) + CHR(227) + "o", 14)
                        INSERT INTO dbRelatorio (Detalhe) VALUES (loc_cDetalhe)

                        loc_cDetalhe = REPLICATE("_", 5) + " " + REPLICATE("_", 14)
                        INSERT INTO dbRelatorio (Detalhe) VALUES (loc_cDetalhe)

                        SCAN
                            loc_cDetalhe = PADR(TempMoe.cmoes, 5) + " "
                            loc_cDetalhe = loc_cDetalhe + ;
                                PADL(TRANSFORM(TempMoe.cotacao, "999,999,999.99"), 14)
                            INSERT INTO dbRelatorio (Detalhe) VALUES (loc_cDetalhe)
                        ENDSCAN
                    ENDIF
                ENDIF

                SELECT dbRelatorio
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        WAIT CLEAR
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros do relatorio a partir de um cursor.
    *                    Usado quando se deseja restaurar uma configuracao
    *                    salva de filtros (ex: ultima execucao do relatorio).
    *
    * O cursor passado deve conter as colunas: cdgrestoque, dsgrestoque,
    * cdestoque, dsestoque, cunis, dunis, datafiltro, cmoes, dmoes,
    * dtcotacao, dadoscotacao, opcfator.
    *
    * Como relatorios nao tem registro fixo (sao parametrizados), este
    * metodo opera sobre o registro corrente do cursor de filtros salvos.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(NVL(par_cAliasCursor, "")))
            THIS.this_cMensagemErro = "Cursor de origem n" + CHR(227) + ;
                "o informado."
            RETURN .F.
        ENDIF

        IF !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor " + ALLTRIM(par_cAliasCursor) + ;
                " n" + CHR(227) + "o est" + CHR(225) + " aberto."
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)
            IF EOF()
                THIS.this_cMensagemErro = "Cursor " + ALLTRIM(par_cAliasCursor) + ;
                    " est" + CHR(225) + " vazio."
                loc_lSucesso = .F.
            ENDIF

            *-- Grupo de Estoque (campos cdgrestoque/dsgrestoque opcionais)
            IF TYPE("cdgrestoque") = "C"
                THIS.this_cCdGrestoque = TratarNulo(cdgrestoque, "C")
            ENDIF
            IF TYPE("dsgrestoque") = "C"
                THIS.this_cDsGrestoque = TratarNulo(dsgrestoque, "C")
            ENDIF

            *-- Estoque (cdestoque/dsestoque opcionais)
            IF TYPE("cdestoque") = "C"
                THIS.this_cCdEstoque = TratarNulo(cdestoque, "C")
            ENDIF
            IF TYPE("dsestoque") = "C"
                THIS.this_cDsEstoque = TratarNulo(dsestoque, "C")
            ENDIF

            *-- Unidade (cunis/dunis opcionais)
            IF TYPE("cunis") = "C"
                THIS.this_cGrupo     = TratarNulo(cunis, "C")
            ENDIF
            IF TYPE("dunis") = "C"
                THIS.this_cGrupoDesc = TratarNulo(dunis, "C")
            ENDIF

            *-- Data de referencia
            IF TYPE("datafiltro") = "D"
                THIS.this_dData = NVL(datafiltro, {})
            ENDIF

            *-- Moeda (cmoes/dmoes opcionais)
            IF TYPE("cmoes") = "C"
                THIS.this_cMoeda     = TratarNulo(cmoes, "C")
            ENDIF
            IF TYPE("dmoes") = "C"
                THIS.this_cMoedaDesc = TratarNulo(dmoes, "C")
            ENDIF

            *-- Data da cotacao
            IF TYPE("dtcotacao") = "D"
                THIS.this_dDtCotacao = NVL(dtcotacao, {})
            ENDIF

            *-- Opcoes numericas (1=Sim / 2=Nao)
            IF TYPE("dadoscotacao") = "N"
                THIS.this_nDadosCotacao = NVL(dadoscotacao, 1)
            ENDIF
            IF TYPE("opcfator") = "N"
                THIS.this_nOpcFator = NVL(opcfator, 1)
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar filtros do cursor: " + ;
                loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - BLOQUEADO: relatorio nao persiste dados
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: relat" + CHR(243) + ;
            "rios n" + CHR(227) + "o gravam registros."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - BLOQUEADO: relatorio nao persiste dados
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: relat" + CHR(243) + ;
            "rios n" + CHR(227) + "o alteram registros."
        RETURN .F.
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
    * Destroy - Fecha todos os cursores abertos pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("dbCabecalho")
            USE IN dbCabecalho
        ENDIF
        IF USED("dbRelatorio")
            USE IN dbRelatorio
        ENDIF
        IF USED("TempMoe")
            USE IN TempMoe
        ENDIF
        IF USED("dbRelat")
            USE IN dbRelat
        ENDIF
        IF USED("cursor_4c_sigEmpReeun")
            USE IN cursor_4c_sigEmpReeun
        ENDIF
        IF USED("cursor_4c_SigCdProRu")
            USE IN cursor_4c_SigCdProRu
        ENDIF
        IF USED("cursor_4c_TmpSaldoRu")
            USE IN cursor_4c_TmpSaldoRu
        ENDIF
        IF USED("cursor_4c_TmpSaldoAll")
            USE IN cursor_4c_TmpSaldoAll
        ENDIF
        IF USED("cursor_4c_TmpProAll")
            USE IN cursor_4c_TmpProAll
        ENDIF
        IF USED("cursor_4c_TmpHisAll")
            USE IN cursor_4c_TmpHisAll
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
