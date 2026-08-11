*==============================================================================
* SIGRECOPBO.PRG
* Business Object para Relatorio de Comissoes por Recebimento
* Herda de: RelatorioBase
*
* Filtros:
*   - Periodo (data inicial / data final)
*   - Empresa (codigo + descricao)
*   - Grupo de Estoque / Conta de Vendedor (codigo + descricao)
*   - Conta / Vendedor (codigo + descricao)
*   - Moeda (codigo + descricao) + opcao Unificar/Filtrar
*   - Selecao (Todos / Pagos / Nao Pagos)
*   - Tipo (Analitico / Sintetico / Resumido / Analitico por parcelas)
*   - Movimento (Ambas / Entradas / Saidas)
*   - Saldo (Sim / Nao)
*   - % Comissao (checkbox)
*==============================================================================

DEFINE CLASS sigrecopBO AS RelatorioBase

    *-- Propriedades base (RelatorioBase)
    this_cTabela     = "SigMvCcr"
    this_cCampoChave = ""

    *--------------------------------------------------------------------------
    * FILTROS DO RELATORIO
    *--------------------------------------------------------------------------

    *-- Periodo
    this_dDtInicial  = {}
    this_dDtFinal    = {}

    *-- Empresa (CHAR(3) codigo + CHAR(40) descricao)
    this_cCdEmpresa  = ""
    this_cDsEmpresa  = ""

    *-- Grupo de Estoque / Conta de Vendedor (CHAR(10) codigo + CHAR(20) descricao)
    this_cCdGrEstoque = ""
    this_cDsGrEstoque = ""

    *-- Conta / Vendedor (CHAR(10) codigo + CHAR(40) descricao)
    this_cCdEstoque   = ""
    this_cDsEstoque   = ""

    *-- Moeda (CHAR(3) codigo + CHAR(15) descricao)
    this_cCdMoeda     = ""
    this_cDsMoeda     = ""

    *-- Opcao Moeda: 1=Unificar 2=Filtrar
    this_nUnifica     = 1

    *-- Selecao (optQuebras): 1=Todos 2=Pagos 3=Nao Pagos
    this_nQuebras     = 1

    *-- Tipo (optTipo): 1=Analitico 2=Sintetico 3=Resumido 4=Analitico por parcelas
    this_nTipo        = 1

    *-- Movimento (optMovs): 1=Ambas 2=Entradas 3=Saidas
    this_nMovs        = 1

    *-- Saldo (OptSaldo): 1=Sim 2=Nao (default 2 conforme original)
    this_nSaldo       = 2

    *-- % Comissao (chkPComis): 0=nao exibir 1=exibir (default 1 conforme original)
    this_nPComis      = 1

    *--------------------------------------------------------------------------
    * DADOS DO CABECALHO DO RELATORIO (preenchidos em PrepararDados)
    *--------------------------------------------------------------------------
    this_cNmEmpresa   = ""
    this_cTitulo      = ""

    *==========================================================================
    * Init - Construtor
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            THIS.this_cTabela     = "SigMvCcr"
            THIS.this_cCampoChave = ""

            THIS.this_dDtInicial   = DATE()
            THIS.this_dDtFinal     = DATE()

            THIS.this_cCdEmpresa   = ""
            THIS.this_cDsEmpresa   = ""

            THIS.this_cCdGrEstoque = ""
            THIS.this_cDsGrEstoque = ""

            THIS.this_cCdEstoque   = ""
            THIS.this_cDsEstoque   = ""

            THIS.this_cCdMoeda     = ""
            THIS.this_cDsMoeda     = ""

            THIS.this_nUnifica     = 1
            THIS.this_nQuebras     = 1
            THIS.this_nTipo        = 1
            THIS.this_nMovs        = 1
            THIS.this_nSaldo       = 2
            THIS.this_nPComis      = 1

            THIS.this_cNmEmpresa   = ""
            THIS.this_cTitulo      = ""

            loc_lSucesso = DODEFAULT()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarCursoresBase - Carrega cursores de referencia do SQL Server
    * Necessario para BuscarCotacao e conversoes de cambio no processamento
    *==========================================================================
    PROTECTED PROCEDURE CarregarCursoresBase()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_oErr, loc_lFalhou

        loc_lSucesso = .F.
        loc_lFalhou  = .F.

        TRY
            *-- SigCdEmp (nome da empresa)
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

            *-- SigCdMoe (cadastro de moedas - equivalencia e substituicao)
            IF !loc_lFalhou
                IF USED("crSigCdMoe")
                    USE IN crSigCdMoe
                ENDIF
                loc_cSQL = "SELECT cmoes, dmoes, moeqs, qtdeqs FROM SigCdMoe ORDER BY cmoes"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdMoe")
                IF loc_nResult < 1
                    loc_lFalhou = .T.
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdMoe"
                    MsgErro("Falha ao carregar SigCdMoe", "Erro")
                ELSE
                    SELECT crSigCdMoe
                    INDEX ON PADR(cmoes, 3) TAG cmoes
                ENDIF
            ENDIF

            *-- SigCdCot (cotacoes de moeda - indexado por moeda+data)
            IF !loc_lFalhou
                IF USED("crSigCdCot")
                    USE IN crSigCdCot
                ENDIF
                loc_cSQL = "SELECT cmoes, datas, valos FROM SigCdCot ORDER BY cmoes, datas"
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

            *-- SigCdPam (moeda padrao do sistema - fallback quando MoeTots vazio)
            IF !loc_lFalhou
                IF USED("crSigCdPam")
                    USE IN crSigCdPam
                ENDIF
                loc_cSQL = "SELECT TOP 1 moedaps FROM SigCdPam"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdPam")
                IF loc_nResult < 1
                    CREATE CURSOR crSigCdPam (moedaps c(3))
                    INSERT INTO crSigCdPam VALUES ("R  ")
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
    * BuscarCotacao - Retorna cotacao de moeda em determinada data
    * Equivale a fBuscarCotacao() do framework legado
    * Usa crSigCdCot indexado por CMOEDATA = PADR(cmoes,3)+DTOS(datas)
    *==========================================================================
    FUNCTION BuscarCotacao(par_cMoeda, par_dData)
        LOCAL loc_nValor, loc_oErr

        loc_nValor = 1

        TRY
            IF USED("crSigCdCot") AND !EMPTY(par_cMoeda) AND !EMPTY(par_dData)
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
    * PrepararDados - Processa dados para o relatorio de comissoes por recebimento
    * Reproduz a logica do PROCEDURE processamento do legado SIGRECOP (1018 linhas)
    * Gera crAnalitico e dbcabecalho para uso pelos FRX SigReCr8/SigReCr7/SigReCr9
    *==========================================================================
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErr
        LOCAL loc_dDtI, loc_dDtF, loc_cCdMoeda, loc_cDsMoeda
        LOCAL loc_cGrupo, loc_cConta, loc_nPagos, loc_nTipo
        LOCAL loc_lMoeUni, loc_cEmp, loc_nMov
        LOCAL loc_cDtISQL, loc_cDtFSQL
        LOCAL loc_cNmEmpresa, loc_cMoeDefPam, loc_cNmTitulo
        LOCAL loc_cSQL, loc_nResult
        LOCAL loc_cMoeU, loc_nEqv, loc_nMdU, loc_nMdU2, loc_nMdc, loc_cMoe
        LOCAL loc_nVal, loc_nValIni, loc_nValBai, loc_nValPag
        LOCAL loc_nPComi, loc_nPPag, loc_nPBai, loc_nReg
        LOCAL loc_nTotComMov, loc_nTotComMovOri
        LOCAL loc_nVlComi, loc_nVlComiOri, loc_nVlBase, loc_nVlBaixa
        LOCAL loc_cCta, loc_cNvends, loc_nParc
        LOCAL loc_nTotaliza, loc_nTotaLinha
        LOCAL loc_nValAcerto, loc_nValParOri
        LOCAL loc_dDatSaldo, loc_cDatSaldoSQL, loc_cPGcm

        loc_lSucesso = .F.

        *-- Validacoes fora do TRY (RETURN .F. permitido aqui)
        IF EMPTY(THIS.this_dDtInicial) OR EMPTY(THIS.this_dDtFinal)
            THIS.this_cMensagemErro = "Informe o per" + CHR(237) + "odo."
            RETURN .F.
        ENDIF
        IF THIS.this_dDtInicial > THIS.this_dDtFinal
            THIS.this_cMensagemErro = "Data inicial maior que data final."
            RETURN .F.
        ENDIF
        IF !THIS.CarregarCursoresBase()
            RETURN .F.
        ENDIF

        TRY
            DO WHILE .T.

                *-- Captura filtros das propriedades
                loc_dDtI     = THIS.this_dDtInicial
                loc_dDtF     = THIS.this_dDtFinal
                loc_cCdMoeda = ALLTRIM(THIS.this_cCdMoeda)
                loc_cDsMoeda = ALLTRIM(THIS.this_cDsMoeda)
                loc_cGrupo   = PADR(ALLTRIM(THIS.this_cCdGrEstoque), 10)
                loc_cConta   = PADR(ALLTRIM(THIS.this_cCdEstoque), 10)
                loc_nPagos   = THIS.this_nQuebras
                loc_nTipo    = THIS.this_nTipo
                loc_lMoeUni  = (THIS.this_nUnifica = 1)
                loc_cEmp     = ALLTRIM(THIS.this_cCdEmpresa)
                loc_nMov     = THIS.this_nMovs

                *-- Formata datas para SQL Server
                loc_cDtISQL = FormatarDataSQL(loc_dDtI)
                loc_cDtFSQL = "'" + PADL(YEAR(loc_dDtF), 4, "0") + "-" + ;
                              PADL(MONTH(loc_dDtF), 2, "0") + "-" + ;
                              PADL(DAY(loc_dDtF), 2, "0") + " 23:59:59'"

                *-- Obter nome da empresa de crSigCdEmp
                loc_cNmEmpresa = ""
                SELECT crSigCdEmp
                GO TOP
                IF !EOF()
                    loc_cNmEmpresa = ALLTRIM(crSigCdEmp.razas)
                ENDIF
                THIS.this_cNmEmpresa = loc_cNmEmpresa

                *-- Obter moeda padrao de crSigCdPam (fallback quando MoeTots vazio)
                loc_cMoeDefPam = "R  "
                IF USED("crSigCdPam")
                    SELECT crSigCdPam
                    GO TOP
                    IF !EOF()
                        loc_cMoeDefPam = crSigCdPam.moedaps
                    ENDIF
                ENDIF

                *-- Titulo do relatorio (CHR() para acentos - sem literais acentuados)
                loc_cNmTitulo = "Comiss" + CHR(227) + "o " + ;
                    IIF(!EMPTY(loc_cCdMoeda), ;
                        " - Moeda " + IIF(loc_lMoeUni, ;
                            "Unificada : ", "Filtrada : ") + PROPER(loc_cDsMoeda), ;
                        "") + ;
                    " - " + DTOC(loc_dDtI) + " " + CHR(224) + " " + DTOC(loc_dDtF) + ;
                    IIF(EMPTY(loc_cEmp) OR (loc_nTipo = 4), ;
                        "", " - Empresa : " + loc_cEmp) + ;
                    IIF(loc_nTipo = 4, CHR(13), " - ") + ;
                    "Tipo : " + IIF(loc_nTipo = 1, "Anal" + CHR(237) + "tico", ;
                        IIF(loc_nTipo = 2, "Sint" + CHR(233) + "tico", ;
                            IIF(loc_nTipo = 3, "Resumido", ;
                                "Anal" + CHR(237) + "tico por parcelas"))) + ;
                    IIF(loc_nMov = 2, " - Entradas", ;
                        IIF(loc_nMov = 3, " - Sa" + CHR(237) + "das", ""))
                THIS.this_cTitulo = loc_cNmTitulo

                *-- Cursor dbcabecalho para os FRX
                IF USED("dbcabecalho")
                    USE IN dbcabecalho
                ENDIF
                CREATE CURSOR dbcabecalho (NomeEmpresa c(80), Titulo m(4), PerComis l)
                INSERT INTO dbcabecalho (NomeEmpresa, Titulo, PerComis) ;
                    VALUES (loc_cNmEmpresa, loc_cNmTitulo, (THIS.this_nPComis = 1))

                *-- Cursor crAnalitico (acumulador principal de comissoes)
                IF USED("crAnalitico")
                    USE IN crAnalitico
                ENDIF
                CREATE CURSOR crAnalitico ;
                    (Vends c(10), NVends c(50), VlComis n(9,4), Valos n(12,4), ;
                     Datas d, EmpDopNums c(29), ContaDs c(10), RClis c(40), ;
                     Notas c(6), Dopes c(20), VlBaixas n(12,4), moedas c(3), ;
                     DataRec d, Linhas c(10), Tabds c(10), DopReceb c(26), ;
                     MoedaRec c(3), ValPags n(12,4), lDivs l, PRecs n(5,2), ;
                     OrdCopChs n(3,0), Acertos n(12,4), MoeAcertos c(3), ;
                     ValTots n(12,4), MoeTots c(3), ValInis n(12,4), ;
                     Titulos c(10), PComis n(5,2))
                INDEX ON Vends + DTOS(Datas) + DopReceb + EmpDopNums + ;
                    STR(OrdCopChs, 3) + Linhas TAG VendDatas

                *-- Query principal: SigMvCcr x SigCdPit x SigMvCab x SigMvPar x SigCdOpe
                IF USED("cursor_4c_MovCcr")
                    USE IN cursor_4c_MovCcr
                ENDIF
                loc_cSQL = "SELECT a.cidchaves, b.opers, b.Acertos, b.Moedas AS MoeAcertos, " + ;
                    "a.empdopnums AS EmpDopReceb, a.datas AS DataRec, a.grupos, a.contas, " + ;
                    "a.pagos, a.valors, a.valpags, a.moedas AS MoedaRec, c.EmpDopNums, " + ;
                    "e.tabds, c.Contas AS ContaCli, e.Datas, e.Notas, b.OrdCopChs, " + ;
                    "e.Valos, o.CMoes AS MoeTots, e.ValInis, c.Titulos, f.CotFpgs, a.IntConts " + ;
                    "FROM sigmvccr a " + ;
                    "INNER JOIN sigcdpit b ON a.empdopnums = b.empdopnums AND a.Sopers = b.opers " + ;
                    "INNER JOIN sigmvccr c ON b.nopers = c.nopers AND c.opers = b.opers " + ;
                    " AND c.Emps = b.EmpOs " + ;
                    "INNER JOIN sigmvcab e ON e.empdopnums = c.empdopnums " + ;
                    " AND (e.vends = a.contas OR e.resps = a.contas) " + ;
                    "INNER JOIN SigMvPar f ON b.Nopers = f.Nopers AND c.Emps = f.Emps " + ;
                    "LEFT JOIN sigcdope o ON o.Dopes = e.Dopes " + ;
                    "WHERE a.datas BETWEEN " + loc_cDtISQL + " AND " + loc_cDtFSQL + ;
                    " AND a.tipos = 'X' AND a.dopes = 'RECEBIMENTO'" + ;
                    IIF(loc_nPagos = 1, "", ;
                        IIF(loc_nPagos = 2, " AND a.Pagos = 0", " AND a.Pagos = 1")) + ;
                    IIF(EMPTY(loc_cEmp), "", " AND c.Emps = " + EscaparSQL(loc_cEmp)) + ;
                    IIF(EMPTY(ALLTRIM(loc_cGrupo)), "", ;
                        " AND a.grupos = " + EscaparSQL(loc_cGrupo)) + ;
                    IIF(loc_nMov = 2, " AND o.COpers = 1", ;
                        IIF(loc_nMov = 3, " AND o.COpers = 2", ""))

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MovCcr")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + "o (cursor_4c_MovCcr)"
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                    EXIT
                ENDIF

                *-- cursor_4c_TmpVende: EmpDopNums x Contas para deteccao de divisao
                IF USED("cursor_4c_TmpVende")
                    USE IN cursor_4c_TmpVende
                ENDIF
                SELECT cursor_4c_MovCcr
                GO TOP
                IF !EOF("cursor_4c_MovCcr")
                    SELECT EmpDopNums, Contas FROM cursor_4c_MovCcr ;
                        INTO CURSOR cursor_4c_TmpVende READWRITE
                ELSE
                    SET NULL ON
                    CREATE CURSOR cursor_4c_TmpVende (EmpDopNums c(29), Contas c(10))
                    SET NULL OFF
                ENDIF

                *-- Filtrar cursor_4c_MovCcr por conta especifica (se informada)
                IF !EMPTY(ALLTRIM(loc_cConta))
                    SELECT * FROM cursor_4c_MovCcr ;
                        WHERE Contas = m.loc_cConta ;
                        INTO CURSOR cursor_4c_MovCcr READWRITE
                ENDIF

                *-- Query de comissoes (SigCdCmm) filtrado pelos EmpDopNums relevantes
                IF USED("cursor_4c_CdCmm")
                    USE IN cursor_4c_CdCmm
                ENDIF
                loc_cSQL = "SELECT a.* FROM SigCdCmm a " + ;
                    "INNER JOIN (" + ;
                    "SELECT DISTINCT c.EmpDopNums " + ;
                    "FROM SigMvCcr a " + ;
                    "INNER JOIN SigCdPit b ON a.EmpDopNums = b.EmpDopNums AND a.Sopers = b.opers " + ;
                    "INNER JOIN SigMvCcr c ON b.Nopers = c.Nopers AND c.Opers = b.Opers " + ;
                    "WHERE a.datas BETWEEN " + loc_cDtISQL + " AND " + loc_cDtFSQL + ;
                    " AND a.tipos = 'X' AND a.dopes = 'RECEBIMENTO'" + ;
                    IIF(loc_nPagos = 1, "", ;
                        IIF(loc_nPagos = 2, " AND a.Pagos = 0", " AND a.Pagos = 1")) + ;
                    IIF(EMPTY(ALLTRIM(loc_cGrupo)), "", ;
                        " AND a.grupos = " + EscaparSQL(loc_cGrupo)) + ;
                    ") b ON a.EmpDopNums = b.EmpDopNums " + ;
                    "WHERE 0 = 0" + ;
                    IIF(EMPTY(loc_cEmp), "", " AND a.Emps = " + EscaparSQL(loc_cEmp)) + ;
                    IIF(!EMPTY(loc_cCdMoeda) AND !loc_lMoeUni, ;
                        " AND a.Moedas = " + EscaparSQL(loc_cCdMoeda), "")

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CdCmm")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + "o (cursor_4c_CdCmm)"
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                    EXIT
                ENDIF

                *-- Intersecao: manter apenas registros de cursor_4c_MovCcr
                *-- que tem correspondencia em cursor_4c_CdCmm por EmpDopNums+IntConts
                SELECT a.* FROM cursor_4c_MovCcr a ;
                    INNER JOIN cursor_4c_CdCmm b ;
                    ON a.EmpDopNums = b.EmpDopNums AND a.IntConts = b.IntConts ;
                    INTO CURSOR cursor_4c_MovCcr READWRITE

                *-- Agregar cursor_4c_MovCcr de acordo com o tipo de relatorio
                IF INLIST(loc_nTipo, 1, 2, 3)
                    SELECT EmpDopReceb, DataRec, MoedaRec, EmpDopNums, Opers, ;
                           SUM(Acertos) AS Acertos, MoeAcertos, Grupos, Contas, ;
                           MAX(Valors) AS Comissaos, MAX(Valpags) AS ValPags, ;
                           Tabds, ContaCli, Datas, Notas, Valos, MoeTots, ValInis, ;
                           CotFpgs, SPACE(10) AS Linhas, ;
                           SPACE(3) AS Moedas, SPACE(10) AS Titulos ;
                           FROM cursor_4c_MovCcr a ;
                           GROUP BY EmpDopReceb, DataRec, MoedaRec, EmpDopNums, Opers, ;
                               MoeAcertos, Grupos, Contas, Tabds, ContaCli, Datas, Notas, ;
                               Valos, MoeTots, ValInis, CotFpgs ;
                           ORDER BY EmpDopReceb, DataRec, MoedaRec, EmpDopNums, Opers ;
                           INTO CURSOR cursor_4c_MovCcr READWRITE
                ELSE
                    SELECT EmpDopReceb, DataRec, MoedaRec, EmpDopNums, Opers, ;
                           Acertos, MoeAcertos, Grupos, Contas, ;
                           SUM(Valors) AS Comissaos, ValPags, Tabds, ContaCli, ;
                           Datas, Notas, Valos, MoeTots, ValInis, Titulos, ;
                           CotFpgs, SPACE(10) AS Linhas ;
                           FROM cursor_4c_MovCcr a ;
                           GROUP BY EmpDopReceb, DataRec, MoedaRec, EmpDopNums, Opers, ;
                               Acertos, MoeAcertos, Grupos, Contas, ValPags, Tabds, ;
                               ContaCli, Datas, Notas, Valos, MoeTots, ValInis, Titulos, ;
                               CotFpgs ;
                           ORDER BY EmpDopReceb, DataRec, MoedaRec, EmpDopNums, Opers ;
                           INTO CURSOR cursor_4c_MovCcr READWRITE
                ENDIF

                *=== SCAN PRINCIPAL: percorre cursor_4c_MovCcr ================
                SELECT cursor_4c_MovCcr
                GO TOP

                SCAN

                    *-- Verificar se ha comissoes em cursor_4c_CdCmm para este EmpDopNums
                    SELECT cursor_4c_CdCmm
                    GO TOP
                    LOCATE FOR EmpDopNums = cursor_4c_MovCcr.EmpDopNums
                    IF EOF()
                        SELECT cursor_4c_MovCcr
                        LOOP
                    ENDIF

                    *-- Adicionar linha em branco ao crAnalitico
                    SELECT crAnalitico
                    APPEND BLANK

                    *-- Buscar cotacoes por movimento (SigMvMov)
                    IF USED("cursor_4c_CotMov")
                        USE IN cursor_4c_CotMov
                    ENDIF
                    loc_cSQL = "SELECT Moeds, Moevals FROM SigMvMov " + ;
                               "WHERE EmpDopNums = " + ;
                               EscaparSQL(cursor_4c_MovCcr.EmpDopNums) + ;
                               " AND Moevals <> 0"
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CotMov")
                    IF loc_nResult < 1
                        SET NULL ON
                        CREATE CURSOR cursor_4c_CotMov (Moeds c(3), Moevals n(14,4))
                        SET NULL OFF
                    ENDIF

                    *-- Buscar nome do cliente (ContaCli)
                    loc_cCta = ""
                    IF USED("cursor_4c_LocalCli")
                        USE IN cursor_4c_LocalCli
                    ENDIF
                    loc_cSQL = "SELECT RClis FROM SigCdCli " + ;
                               "WHERE IClis = " + EscaparSQL(cursor_4c_MovCcr.ContaCli)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalCli")
                    IF loc_nResult > 0
                        SELECT cursor_4c_LocalCli
                        GO TOP
                        IF !EOF()
                            loc_cCta = ALLTRIM(cursor_4c_LocalCli.RClis)
                        ENDIF
                        USE IN cursor_4c_LocalCli
                    ENDIF

                    *-- Buscar nome do vendedor (Contas)
                    loc_cNvends = ""
                    IF USED("cursor_4c_LocalCli")
                        USE IN cursor_4c_LocalCli
                    ENDIF
                    loc_cSQL = "SELECT RClis FROM SigCdCli " + ;
                               "WHERE IClis = " + EscaparSQL(cursor_4c_MovCcr.Contas)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalCli")
                    IF loc_nResult > 0
                        SELECT cursor_4c_LocalCli
                        GO TOP
                        IF !EOF()
                            loc_cNvends = ALLTRIM(cursor_4c_LocalCli.RClis)
                        ENDIF
                        USE IN cursor_4c_LocalCli
                    ENDIF

                    *-- Preencher identificacao do vendedor em crAnalitico
                    REPLACE Vends  WITH cursor_4c_MovCcr.Contas, ;
                            NVends WITH loc_cNvends ;
                            IN crAnalitico

                    *-- Detectar divisao de comissao entre multiplos vendedores
                    SELECT cursor_4c_TmpVende
                    GO TOP
                    LOCATE FOR EmpDopNums = cursor_4c_MovCcr.EmpDopNums ;
                               AND Contas <> cursor_4c_MovCcr.Contas
                    IF !EOF()
                        REPLACE lDivs WITH .T. IN crAnalitico
                    ENDIF

                    *-- Preencher campos de identificacao da movimentacao
                    loc_nParc = AT("/", cursor_4c_MovCcr.Titulos)
                    REPLACE Datas       WITH cursor_4c_MovCcr.Datas, ;
                            EmpDopNums  WITH cursor_4c_MovCcr.EmpDopNums, ;
                            Notas       WITH cursor_4c_MovCcr.Notas, ;
                            ContaDs     WITH cursor_4c_MovCcr.ContaCli, ;
                            RClis       WITH loc_cCta, ;
                            DataRec     WITH cursor_4c_MovCcr.DataRec, ;
                            OrdCopChs   WITH 1, ;
                            Titulos     WITH IIF(loc_nParc > 0, ;
                                                SUBSTR(cursor_4c_MovCcr.Titulos, loc_nParc + 1), "1"), ;
                            Tabds       WITH cursor_4c_MovCcr.Tabds, ;
                            DopReceb    WITH SUBSTR(cursor_4c_MovCcr.EmpDopReceb, 4, 26) ;
                            IN crAnalitico

                    *-- Aplicar sinal C/D nos valores
                    REPLACE ValTots   WITH IIF(cursor_4c_MovCcr.Opers = "C", -1, 1) * ;
                                           cursor_4c_MovCcr.Valos, ;
                            ValInis   WITH IIF(cursor_4c_MovCcr.Opers = "C", -1, 1) * ;
                                           cursor_4c_MovCcr.ValInis, ;
                            Acertos   WITH IIF(cursor_4c_MovCcr.Opers = "C", -1, 1) * ;
                                           cursor_4c_MovCcr.Acertos, ;
                            VlBaixas  WITH IIF(cursor_4c_MovCcr.Opers = "C", -1, 1) * ;
                                           cursor_4c_MovCcr.Comissaos, ;
                            ValPags   WITH IIF(cursor_4c_MovCcr.Opers = "C", -1, 1) * ;
                                           cursor_4c_MovCcr.ValPags, ;
                            MoeAcertos WITH cursor_4c_MovCcr.MoeAcertos, ;
                            MoedaRec  WITH cursor_4c_MovCcr.MoedaRec ;
                            IN crAnalitico

                    *-- Determinar moeda unificada e cotacao loc_nMdU
                    loc_cMoeU = loc_cCdMoeda
                    loc_nEqv  = 1
                    IF SEEK(PADR(ALLTRIM(loc_cCdMoeda), 3), "crSigCdMoe", "cmoes")
                        IF !EMPTY(crSigCdMoe.moeqs)
                            loc_cMoeU = crSigCdMoe.moeqs
                            loc_nEqv  = IIF(crSigCdMoe.qtdeqs = 0, 1, crSigCdMoe.qtdeqs)
                        ENDIF
                    ENDIF
                    loc_nMdU = THIS.BuscarCotacao(loc_cMoeU, cursor_4c_MovCcr.Datas) * loc_nEqv

                    *-- Converter loc_nVal e loc_nValIni para moeda unificada
                    loc_nVal    = cursor_4c_MovCcr.Valos
                    loc_nValIni = cursor_4c_MovCcr.ValInis
                    loc_cMoe    = IIF(EMPTY(cursor_4c_MovCcr.MoeTots), ;
                                      loc_cMoeDefPam, cursor_4c_MovCcr.MoeTots)
                    IF loc_cMoe <> PADR(loc_cMoeU, 3)
                        loc_nEqv = 1
                        IF SEEK(PADR(ALLTRIM(loc_cMoe), 3), "crSigCdMoe", "cmoes")
                            IF !EMPTY(crSigCdMoe.moeqs)
                                loc_cMoe = crSigCdMoe.moeqs
                                loc_nEqv = IIF(crSigCdMoe.qtdeqs = 0, 1, crSigCdMoe.qtdeqs)
                            ENDIF
                        ENDIF

                        SELECT cursor_4c_CotMov
                        GO TOP
                        LOCATE FOR Moeds = PADR(loc_cMoe, 3)
                        loc_nMdc = IIF(!EOF("cursor_4c_CotMov") AND ;
                                       !EMPTY(cursor_4c_CotMov.Moevals), ;
                                       cursor_4c_CotMov.Moevals, ;
                                       THIS.BuscarCotacao(loc_cMoe, cursor_4c_MovCcr.Datas) * loc_nEqv)

                        SELECT cursor_4c_CotMov
                        GO TOP
                        LOCATE FOR Moeds = PADR(loc_cCdMoeda, 3)
                        loc_nMdU2 = IIF(!EOF("cursor_4c_CotMov") AND ;
                                        !EMPTY(cursor_4c_CotMov.Moevals), ;
                                        cursor_4c_CotMov.Moevals, ;
                                        THIS.BuscarCotacao(loc_cCdMoeda, ;
                                            cursor_4c_MovCcr.Datas) * loc_nEqv)

                        IF loc_nMdU2 <> 0
                            loc_nVal    = (loc_nVal * loc_nMdc) / loc_nMdU2
                            loc_nValIni = (loc_nValIni * loc_nMdc) / loc_nMdU2
                        ENDIF
                    ENDIF

                    *-- Converter loc_nValBai e loc_nValPag para moeda unificada
                    loc_nValBai = cursor_4c_MovCcr.Comissaos
                    loc_nValPag = cursor_4c_MovCcr.Valpags
                    IF cursor_4c_MovCcr.MoedaRec <> PADR(loc_cMoeU, 3)
                        loc_nEqv = 1
                        loc_cMoe = cursor_4c_MovCcr.MoedaRec
                        IF SEEK(PADR(ALLTRIM(cursor_4c_MovCcr.MoedaRec), 3), "crSigCdMoe", "cmoes")
                            IF !EMPTY(crSigCdMoe.moeqs)
                                loc_cMoe = crSigCdMoe.moeqs
                                loc_nEqv = IIF(crSigCdMoe.qtdeqs = 0, 1, crSigCdMoe.qtdeqs)
                            ENDIF
                        ENDIF
                        loc_nMdc = THIS.BuscarCotacao(loc_cMoe, cursor_4c_MovCcr.Datas) * loc_nEqv
                        IF loc_nMdU <> 0
                            loc_nValBai = (loc_nValBai * loc_nMdc) / loc_nMdU
                            loc_nValPag = (loc_nValPag * loc_nMdc) / loc_nMdU
                        ENDIF
                    ENDIF

                    *-- Converter Acertos (loc_nValAcerto e loc_nValParOri)
                    loc_nValAcerto = cursor_4c_MovCcr.Acertos
                    loc_nValParOri = cursor_4c_MovCcr.Acertos
                    IF cursor_4c_MovCcr.MoeAcertos <> PADR(loc_cMoeU, 3)
                        loc_nEqv = 1
                        loc_cMoe = cursor_4c_MovCcr.MoeAcertos
                        IF SEEK(PADR(ALLTRIM(cursor_4c_MovCcr.MoeAcertos), 3), ;
                                "crSigCdMoe", "cmoes")
                            IF !EMPTY(crSigCdMoe.moeqs)
                                loc_cMoe = crSigCdMoe.moeqs
                                loc_nEqv = IIF(crSigCdMoe.qtdeqs = 0, 1, crSigCdMoe.qtdeqs)
                            ENDIF
                        ENDIF
                        loc_nMdc = THIS.BuscarCotacao(loc_cMoe, cursor_4c_MovCcr.Datas) * loc_nEqv
                        IF loc_nMdU <> 0
                            loc_nValAcerto = (loc_nValAcerto * loc_nMdc) / loc_nMdU
                        ENDIF

                        SELECT cursor_4c_CotMov
                        GO TOP
                        LOCATE FOR Moeds = PADR(loc_cMoeU, 3)
                        loc_nMdU2 = IIF(!EOF("cursor_4c_CotMov") AND ;
                                        !EMPTY(cursor_4c_CotMov.Moevals), ;
                                        cursor_4c_CotMov.Moevals, ;
                                        THIS.BuscarCotacao(loc_cMoeU, ;
                                            cursor_4c_MovCcr.Datas) * loc_nEqv)
                        IF loc_nMdU2 <> 0
                            loc_nValParOri = (loc_nValParOri * ;
                                cursor_4c_MovCcr.CotFpgs) / loc_nMdU2
                        ENDIF
                    ENDIF

                    *-- Calcular percentuais
                    loc_nPComi = IIF(loc_nVal = 0, 0, loc_nValParOri / loc_nVal)
                    loc_nPPag  = IIF(loc_nValBai = 0, 0, loc_nValPag / loc_nValBai)
                    loc_nPBai  = IIF(loc_nValIni = 0, 0, ;
                                     ROUND((loc_nValBai / loc_nValIni) * 100, 2))
                    REPLACE PRecs WITH loc_nPBai IN crAnalitico

                    *-- Conversao para moeda unificada quando opcao = Unificar
                    IF !EMPTY(loc_cCdMoeda) AND loc_lMoeUni
                        REPLACE ValTots    WITH IIF(cursor_4c_MovCcr.Opers = "C", -1, 1) * ;
                                                loc_nVal, ;
                                ValInis    WITH IIF(cursor_4c_MovCcr.Opers = "C", -1, 1) * ;
                                                loc_nValIni, ;
                                Acertos    WITH IIF(cursor_4c_MovCcr.Opers = "C", -1, 1) * ;
                                                loc_nValAcerto, ;
                                VlBaixas   WITH IIF(cursor_4c_MovCcr.Opers = "C", -1, 1) * ;
                                                loc_nValBai, ;
                                ValPags    WITH IIF(cursor_4c_MovCcr.Opers = "C", -1, 1) * ;
                                                loc_nValPag, ;
                                MoeAcertos WITH loc_cMoeU, ;
                                Moedas     WITH loc_cMoeU, ;
                                MoedaRec   WITH loc_cMoeU ;
                                IN crAnalitico
                    ENDIF

                    *-- Capturar estado do crAnalitico para os totalizadores
                    SELECT crAnalitico
                    SCATTER MEMO MEMVAR
                    loc_nReg = RECNO()

                    loc_nTotComMov    = 0
                    loc_nTotComMovOri = 0

                    *=== SCAN INTERNO: cursor_4c_CdCmm (linhas de comissao) ===
                    SELECT cursor_4c_CdCmm
                    GO TOP
                    SCAN FOR EmpDopNums = cursor_4c_MovCcr.EmpDopNums ;
                             AND Contas = cursor_4c_MovCcr.Contas

                        loc_nVlComiOri = cursor_4c_CdCmm.Comissaos
                        loc_nVlComi    = cursor_4c_CdCmm.Comissaos
                        loc_nVlBase    = cursor_4c_CdCmm.Bases
                        loc_nVlBaixa   = ROUND(cursor_4c_CdCmm.Comissaos * loc_nPComi, 4)

                        *-- Converter VlComi para moeda unificada
                        IF cursor_4c_CdCmm.Moedas <> PADR(loc_cMoeU, 3)
                            loc_nEqv = 1
                            loc_cMoe = cursor_4c_CdCmm.Moedas
                            IF SEEK(PADR(ALLTRIM(cursor_4c_CdCmm.Moedas), 3), ;
                                    "crSigCdMoe", "cmoes")
                                IF !EMPTY(crSigCdMoe.moeqs)
                                    loc_cMoe = crSigCdMoe.moeqs
                                    loc_nEqv = IIF(crSigCdMoe.qtdeqs = 0, 1, ;
                                                   crSigCdMoe.qtdeqs)
                                ENDIF
                            ENDIF
                            loc_nMdc = THIS.BuscarCotacao(loc_cMoe, ;
                                cursor_4c_MovCcr.DataRec) * loc_nEqv
                            IF loc_nMdU <> 0
                                loc_nVlComi   = (loc_nVlComi * loc_nMdc) / loc_nMdU
                                loc_nVlBase   = (loc_nVlBase * loc_nMdc) / loc_nMdU
                                loc_nVlBaixa  = (loc_nVlBaixa * loc_nMdc) / loc_nMdU
                            ENDIF

                            SELECT cursor_4c_CotMov
                            GO TOP
                            LOCATE FOR Moeds = PADR(loc_cMoe, 3)
                            loc_nMdc = IIF(!EOF("cursor_4c_CotMov") AND ;
                                           !EMPTY(cursor_4c_CotMov.Moevals), ;
                                           cursor_4c_CotMov.Moevals, ;
                                           THIS.BuscarCotacao(loc_cMoe, ;
                                               cursor_4c_MovCcr.Datas) * loc_nEqv)

                            SELECT cursor_4c_CotMov
                            GO TOP
                            LOCATE FOR Moeds = PADR(loc_cCdMoeda, 3)
                            loc_nMdU2 = IIF(!EOF("cursor_4c_CotMov") AND ;
                                            !EMPTY(cursor_4c_CotMov.Moevals), ;
                                            cursor_4c_CotMov.Moevals, ;
                                            THIS.BuscarCotacao(loc_cCdMoeda, ;
                                                cursor_4c_MovCcr.Datas) * loc_nEqv)
                            IF loc_nMdU2 <> 0
                                loc_nVlComiOri = (cursor_4c_CdCmm.Comissaos * ;
                                    loc_nMdc) / loc_nMdU2
                            ENDIF
                        ENDIF

                        loc_nTotComMov    = loc_nTotComMov + loc_nVlComi
                        loc_nTotComMovOri = loc_nTotComMovOri + loc_nVlComiOri

                        *-- Tipo 1: Analitico - uma linha por comissao da movimentacao
                        IF loc_nTipo = 1
                            SELECT crAnalitico
                            GO TOP
                            LOCATE FOR DopReceb = ;
                                SUBSTR(cursor_4c_MovCcr.EmpDopReceb, 4, 26) ;
                                AND EmpDopNums = cursor_4c_MovCcr.EmpDopNums ;
                                AND Vends = cursor_4c_MovCcr.Contas ;
                                AND (Linhas = cursor_4c_CdCmm.Linhas ;
                                     OR Linhas = SPACE(10))
                            IF EOF()
                                INSERT INTO crAnalitico FROM MEMVAR
                            ENDIF

                            loc_nPBai = IIF(loc_nVlBase = 0, 0, ;
                                ROUND(((loc_nVlComi / loc_nVlBase) * loc_nPComi) * 100, 2))
                            loc_nVlComi    = IIF(!EMPTY(loc_cCdMoeda) AND loc_lMoeUni, ;
                                                  loc_nVlComi, cursor_4c_CdCmm.Comissaos)
                            loc_nVlComiOri = IIF(!EMPTY(loc_cCdMoeda) AND loc_lMoeUni, ;
                                                  loc_nVlComiOri, cursor_4c_CdCmm.Comissaos)
                            loc_nVlBaixa   = IIF(!EMPTY(loc_cCdMoeda) AND loc_lMoeUni, ;
                                                  loc_nVlBaixa, ;
                                                  ROUND(cursor_4c_CdCmm.Comissaos * loc_nPComi, 4))

                            REPLACE Linhas     WITH cursor_4c_CdCmm.Linhas, ;
                                    MoeAcertos WITH cursor_4c_CdCmm.Moedas, ;
                                    Moedas     WITH cursor_4c_CdCmm.Moedas, ;
                                    MoedaRec   WITH cursor_4c_CdCmm.Moedas, ;
                                    VlComis    WITH IIF(cursor_4c_MovCcr.Opers = "C", ;
                                                       -1, 1) * loc_nVlComiOri, ;
                                    PComis     WITH cursor_4c_CdCmm.Percs, ;
                                    VlBaixas   WITH IIF(cursor_4c_MovCcr.Opers = "C", ;
                                                       -1, 1) * ROUND(loc_nVlBaixa, 2), ;
                                    PRecs      WITH loc_nPBai, ;
                                    ValPags    WITH IIF(cursor_4c_MovCcr.Opers = "C", ;
                                                       -1, 1) * ;
                                                   ROUND(loc_nVlBaixa * loc_nPPag, 2) ;
                                    IN crAnalitico

                            IF !EMPTY(loc_cCdMoeda) AND loc_lMoeUni
                                REPLACE Moedas     WITH loc_cMoeU, ;
                                        MoeAcertos WITH loc_cMoeU, ;
                                        MoedaRec   WITH loc_cMoeU ;
                                        IN crAnalitico
                            ENDIF

                            *-- Totalizador por linha de producao
                            SELECT crAnalitico
                            SCATTER MEMO MEMVAR

                            SELECT crAnalitico
                            GO TOP
                            COUNT FOR EmpDopNums = cursor_4c_MovCcr.EmpDopNums ;
                                      AND Vends = cursor_4c_MovCcr.Contas ;
                                      TO loc_nTotaliza

                            SELECT crAnalitico
                            GO TOP
                            COUNT FOR EmpDopNums = cursor_4c_MovCcr.EmpDopNums ;
                                      AND Vends = cursor_4c_MovCcr.Contas ;
                                      AND Linhas = cursor_4c_CdCmm.Linhas ;
                                      TO loc_nTotaLinha

                            GO TOP
                            LOCATE FOR EmpDopNums = REPLICATE("Z", 29) ;
                                       AND Vends = m.Vends ;
                                       AND Linhas = m.Linhas ;
                                       AND Moedas = m.Moedas ;
                                       AND MoedaRec = m.MoedaRec
                            IF EOF()
                                INSERT INTO crAnalitico (Vends, Datas, Linhas, ;
                                    EmpDopNums, Moedas, MoedaRec) ;
                                    VALUES (m.Vends, DATE(9999, 12, 31), m.Linhas, ;
                                            REPLICATE("Z", 29), m.moedas, m.MoedaRec)
                            ENDIF
                            IF loc_nTotaliza = 1
                                REPLACE VlComis WITH VlComis + m.VlComis IN crAnalitico
                            ENDIF
                            REPLACE VlBaixas WITH VlBaixas + m.VlBaixas, ;
                                    ValPags  WITH ValPags + m.ValPags ;
                                    IN crAnalitico

                            *-- Totalizador por moedas
                            SELECT crAnalitico
                            GO TOP
                            LOCATE FOR EmpDopNums = REPLICATE("Z", 29) ;
                                       AND Vends = m.Vends ;
                                       AND Linhas = REPLICATE("Z", 10) ;
                                       AND Moedas = m.moedas ;
                                       AND MoedaRec = m.MoedaRec
                            IF EOF()
                                INSERT INTO crAnalitico (Vends, Datas, Linhas, ;
                                    EmpDopNums, Moedas, MoedaRec, MoeAcertos) ;
                                    VALUES (m.Vends, DATE(9999, 12, 31), ;
                                            REPLICATE("Z", 10), REPLICATE("Z", 29), ;
                                            m.moedas, m.MoedaRec, m.MoeAcertos)
                            ENDIF
                            IF loc_nTotaliza = 1
                                REPLACE ValInis WITH ValInis + m.ValInis IN crAnalitico
                            ENDIF
                            IF loc_nTotaLinha = 1
                                REPLACE VlComis WITH VlComis + m.VlComis IN crAnalitico
                            ENDIF
                            REPLACE VlBaixas WITH VlBaixas + m.VlBaixas, ;
                                    ValPags  WITH ValPags + m.ValPags, ;
                                    Acertos  WITH Acertos + m.Acertos ;
                                    IN crAnalitico
                        ENDIF

                        SELECT cursor_4c_CdCmm
                    ENDSCAN
                    *=== FIM SCAN INTERNO =====================================

                    *-- Tipo 2: Sintetico - uma linha totalizando a comissao
                    IF loc_nTipo = 2
                        SELECT crAnalitico
                        GO (loc_nReg)
                        REPLACE VlComis WITH IIF(cursor_4c_MovCcr.Opers = "C", -1, 1) * ;
                                             loc_nTotComMovOri, ;
                                PComis  WITH IIF(loc_nValIni = 0, 0, ;
                                               (loc_nTotComMovOri / loc_nValIni) * 100), ;
                                ValPags WITH IIF(cursor_4c_MovCcr.Opers = "C", -1, 1) * ;
                                             loc_nTotComMov * loc_nPComi * loc_nPPag ;
                                IN crAnalitico

                        SCATTER MEMO MEMVAR

                        SELECT crAnalitico
                        GO TOP
                        COUNT FOR EmpDopNums = cursor_4c_MovCcr.EmpDopNums ;
                                  AND Vends = cursor_4c_MovCcr.Contas ;
                                  TO loc_nTotaliza

                        GO TOP
                        LOCATE FOR EmpDopNums = REPLICATE("Z", 29) ;
                                   AND Vends = m.Vends ;
                                   AND Linhas = REPLICATE("Z", 10) ;
                                   AND Moedas = m.moedas ;
                                   AND MoedaRec = m.MoedaRec
                        IF EOF()
                            INSERT INTO crAnalitico (Vends, Datas, Linhas, ;
                                EmpDopNums, Moedas, MoedaRec, MoeAcertos) ;
                                VALUES (m.Vends, DATE(9999, 12, 31), ;
                                        REPLICATE("Z", 10), REPLICATE("Z", 29), ;
                                        m.moedas, m.MoedaRec, m.MoeAcertos)
                        ENDIF
                        IF loc_nTotaliza = 1
                            REPLACE ValInis WITH ValInis + m.ValInis, ;
                                    VlComis WITH VlComis + m.VlComis ;
                                    IN crAnalitico
                        ENDIF
                        REPLACE VlBaixas WITH VlBaixas + m.VlBaixas, ;
                                ValPags  WITH ValPags + m.ValPags, ;
                                Acertos  WITH Acertos + m.Acertos ;
                                IN crAnalitico
                    ENDIF

                    *-- Tipo 4: Analitico por parcelas
                    IF loc_nTipo = 4
                        SELECT crAnalitico
                        GO (loc_nReg)
                        REPLACE VlComis  WITH IIF(cursor_4c_MovCcr.Opers = "C", -1, 1) * ;
                                              loc_nTotComMovOri, ;
                                PComis   WITH IIF(loc_nVal = 0, 0, ;
                                               ROUND((loc_nTotComMovOri / loc_nVal) * 100, 2)), ;
                                VlBaixas WITH IIF(cursor_4c_MovCcr.Opers = "C", -1, 1) * ;
                                              ROUND(loc_nTotComMov * loc_nPComi, 2), ;
                                ValPags  WITH IIF(cursor_4c_MovCcr.Opers = "C", -1, 1) * ;
                                              ROUND(loc_nTotComMov * loc_nPPag, 2) ;
                                IN crAnalitico

                        SCATTER MEMO MEMVAR

                        SELECT crAnalitico
                        GO TOP
                        LOCATE FOR EmpDopNums = REPLICATE("Z", 29) ;
                                   AND Vends = m.Vends ;
                                   AND Linhas = REPLICATE("Z", 10) ;
                                   AND Moedas = m.moedas ;
                                   AND MoedaRec = m.MoedaRec
                        IF EOF()
                            INSERT INTO crAnalitico (Vends, Datas, Linhas, ;
                                EmpDopNums, Moedas, MoedaRec, MoeAcertos, ;
                                ValInis, VlComis) ;
                                VALUES (m.Vends, DATE(9999, 12, 31), ;
                                        REPLICATE("Z", 10), REPLICATE("Z", 29), ;
                                        m.moedas, m.MoedaRec, m.MoeAcertos, ;
                                        m.ValInis, m.VlComis)
                        ENDIF
                        REPLACE VlBaixas WITH VlBaixas + m.VlBaixas, ;
                                ValPags  WITH ValPags + m.ValPags, ;
                                Acertos  WITH Acertos + m.Acertos ;
                                IN crAnalitico
                    ENDIF

                    SELECT cursor_4c_MovCcr
                ENDSCAN
                *=== FIM SCAN PRINCIPAL ========================================

                *-- Saldo anterior (optSaldo = 1)
                SELECT crAnalitico
                IF THIS.this_nSaldo = 1 AND RECCOUNT("crAnalitico") > 0

                    IF USED("cursor_4c_TmpMoe")
                        USE IN cursor_4c_TmpMoe
                    ENDIF
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT Cmoes FROM SigCdMoe", "cursor_4c_TmpMoe")
                    IF loc_nResult < 1
                        MsgErro("Falha na Conex" + CHR(227) + "o (cursor_4c_TmpMoe)", "Erro")
                        EXIT
                    ENDIF
                    IF !EMPTY(loc_cCdMoeda)
                        DELETE FROM cursor_4c_TmpMoe WHERE Cmoes <> loc_cCdMoeda
                    ENDIF

                    IF USED("cursor_4c_TmpVendeD")
                        USE IN cursor_4c_TmpVendeD
                    ENDIF
                    SELECT DISTINCT Contas FROM cursor_4c_TmpVende ;
                        INTO CURSOR cursor_4c_TmpVendeD READWRITE

                    loc_dDatSaldo    = loc_dDtI - 1
                    loc_cDatSaldoSQL = "'" + PADL(YEAR(loc_dDatSaldo), 4, "0") + "-" + ;
                                       PADL(MONTH(loc_dDatSaldo), 2, "0") + "-" + ;
                                       PADL(DAY(loc_dDatSaldo), 2, "0") + " 23:59:59'"

                    SELECT cursor_4c_TmpVendeD
                    GO TOP
                    SCAN
                        IF !EMPTY(ALLTRIM(loc_cConta)) AND ;
                           cursor_4c_TmpVendeD.Contas <> loc_cConta
                            LOOP
                        ENDIF

                        IF USED("cursor_4c_TmpCli")
                            USE IN cursor_4c_TmpCli
                        ENDIF
                        loc_cSQL = "SELECT Grupos FROM SigCdCli " + ;
                                   "WHERE Iclis = " + ;
                                   EscaparSQL(cursor_4c_TmpVendeD.Contas)
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCli")
                        IF loc_nResult < 1
                            MsgErro("Falha na Conex" + CHR(227) + "o (cursor_4c_TmpCli)", "Erro")
                            SELECT cursor_4c_TmpVendeD
                            LOOP
                        ENDIF

                        SELECT cursor_4c_TmpMoe
                        GO TOP
                        SCAN
                            SELECT cursor_4c_TmpCli
                            GO TOP
                            loc_cPGcm = IIF(!EOF("cursor_4c_TmpCli"), ;
                                            ALLTRIM(cursor_4c_TmpCli.Grupos), "") + ;
                                        ALLTRIM(cursor_4c_TmpVendeD.Contas) + ;
                                        ALLTRIM(cursor_4c_TmpMoe.Cmoes)

                            IF USED("cursor_4c_SaldoCcr")
                                USE IN cursor_4c_SaldoCcr
                            ENDIF
                            loc_cSQL = "SELECT TOP 1 Nfs, SaldoCs, Saldos, cIdChaves " + ;
                                       "FROM SigMvCcr " + ;
                                       "WHERE GruConMoes = " + EscaparSQL(loc_cPGcm) + ;
                                       " AND Datas <= " + loc_cDatSaldoSQL + ;
                                       " ORDER BY GruConMoes ASC, cIdChaves DESC"
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SaldoCcr")
                            IF loc_nResult > 0
                                SELECT cursor_4c_SaldoCcr
                                GO TOP
                                IF !EOF()
                                    INSERT INTO crAnalitico ;
                                        (Vends, DataRec, VlBaixas, EmpDopNums, Moedas) ;
                                        VALUES (cursor_4c_TmpVendeD.Contas, ;
                                                loc_dDatSaldo, ;
                                                cursor_4c_SaldoCcr.Saldos, ;
                                                "   Saldo Anterior", ;
                                                cursor_4c_TmpMoe.Cmoes)
                                ENDIF
                                USE IN cursor_4c_SaldoCcr
                            ENDIF

                            SELECT cursor_4c_TmpMoe
                        ENDSCAN
                        SELECT cursor_4c_TmpVendeD
                    ENDSCAN
                ENDIF

                *-- Ordenar crAnalitico pelo indice VendDatas
                SELECT crAnalitico
                SET ORDER TO VendDatas
                GO TOP IN crAnalitico

                loc_lSucesso = .T.
                EXIT
            ENDDO

        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "PrepararDados")
        ENDTRY

        RETURN loc_lSucesso
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
                    CASE INLIST(THIS.this_nTipo, 1, 2)
                        REPORT FORM (gc_4c_CaminhoReports + "SigReCr8") ;
                               TO PRINTER PROMPT NOCONSOLE
                    CASE THIS.this_nTipo = 3
                        REPORT FORM (gc_4c_CaminhoReports + "SigReCr7") ;
                               TO PRINTER PROMPT NOCONSOLE
                    OTHERWISE
                        REPORT FORM (gc_4c_CaminhoReports + "SigReCr9") ;
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
                    CASE INLIST(THIS.this_nTipo, 1, 2)
                        REPORT FORM (gc_4c_CaminhoReports + "SigReCr8") ;
                               PREVIEW NOCONSOLE
                    CASE THIS.this_nTipo = 3
                        REPORT FORM (gc_4c_CaminhoReports + "SigReCr7") ;
                               PREVIEW NOCONSOLE
                    OTHERWISE
                        REPORT FORM (gc_4c_CaminhoReports + "SigReCr9") ;
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
    * ObterChavePrimaria - Retorna chave logica do relatorio
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ALLTRIM(THIS.this_cTabela) + "|" + ;
                     DTOS(THIS.this_dDtInicial) + "|" + ;
                     DTOS(THIS.this_dDtFinal) + "|" + ;
                     ALLTRIM(THIS.this_cCdMoeda) + "|" + ;
                     STR(THIS.this_nTipo, 1)
        RETURN loc_cChave
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega filtros do relatorio a partir de um cursor de
    * parametros (uso opcional para restaurar configuracao salva pelo usuario)
    * par_cAliasCursor: alias do cursor com colunas DtInicial, DtFinal,
    *   CdEmpresa, DsEmpresa, CdGrEstoque, DsGrEstoque, CdEstoque, DsEstoque,
    *   CdMoeda, DsMoeda, Unifica, Quebras, Tipo, Movs, Saldo, PComis
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
                IF TYPE(loc_cAlias + ".CdEmpresa") = "C"
                    THIS.this_cCdEmpresa = EVALUATE(loc_cAlias + ".CdEmpresa")
                ENDIF
                IF TYPE(loc_cAlias + ".DsEmpresa") = "C"
                    THIS.this_cDsEmpresa = EVALUATE(loc_cAlias + ".DsEmpresa")
                ENDIF
                IF TYPE(loc_cAlias + ".CdGrEstoque") = "C"
                    THIS.this_cCdGrEstoque = EVALUATE(loc_cAlias + ".CdGrEstoque")
                ENDIF
                IF TYPE(loc_cAlias + ".DsGrEstoque") = "C"
                    THIS.this_cDsGrEstoque = EVALUATE(loc_cAlias + ".DsGrEstoque")
                ENDIF
                IF TYPE(loc_cAlias + ".CdEstoque") = "C"
                    THIS.this_cCdEstoque = EVALUATE(loc_cAlias + ".CdEstoque")
                ENDIF
                IF TYPE(loc_cAlias + ".DsEstoque") = "C"
                    THIS.this_cDsEstoque = EVALUATE(loc_cAlias + ".DsEstoque")
                ENDIF
                IF TYPE(loc_cAlias + ".CdMoeda") = "C"
                    THIS.this_cCdMoeda = EVALUATE(loc_cAlias + ".CdMoeda")
                ENDIF
                IF TYPE(loc_cAlias + ".DsMoeda") = "C"
                    THIS.this_cDsMoeda = EVALUATE(loc_cAlias + ".DsMoeda")
                ENDIF
                IF TYPE(loc_cAlias + ".Unifica") = "N"
                    THIS.this_nUnifica = EVALUATE(loc_cAlias + ".Unifica")
                ENDIF
                IF TYPE(loc_cAlias + ".Quebras") = "N"
                    THIS.this_nQuebras = EVALUATE(loc_cAlias + ".Quebras")
                ENDIF
                IF TYPE(loc_cAlias + ".Tipo") = "N"
                    THIS.this_nTipo = EVALUATE(loc_cAlias + ".Tipo")
                ENDIF
                IF TYPE(loc_cAlias + ".Movs") = "N"
                    THIS.this_nMovs = EVALUATE(loc_cAlias + ".Movs")
                ENDIF
                IF TYPE(loc_cAlias + ".Saldo") = "N"
                    THIS.this_nSaldo = EVALUATE(loc_cAlias + ".Saldo")
                ENDIF
                IF TYPE(loc_cAlias + ".PComis") = "N"
                    THIS.this_nPComis = EVALUATE(loc_cAlias + ".PComis")
                ENDIF
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
        LOCAL loc_aCursores, loc_nI, loc_cCursor

        loc_aCursores = ;
            "crAnalitico,dbcabecalho,crSigCdEmp,crSigCdMoe,crSigCdCot,crSigCdPam," + ;
            "cursor_4c_MovCcr,cursor_4c_CdCmm,cursor_4c_TmpVende,cursor_4c_TmpVendeD," + ;
            "cursor_4c_CotMov,cursor_4c_LocalCli,cursor_4c_TmpMoe,cursor_4c_TmpCli," + ;
            "cursor_4c_SaldoCcr"

        FOR loc_nI = 1 TO GETWORDCOUNT(loc_aCursores, ",")
            loc_cCursor = GETWORDNUM(loc_aCursores, loc_nI, ",")
            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF
        ENDFOR

        DODEFAULT()
    ENDPROC

ENDDEFINE
