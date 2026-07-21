*==============================================================================
* SIGREBALBO.PRG
* Business Object para Relatorio de Balanco (SIGREBAL)
*
* Herda de: RelatorioBase
* Form associado: Formsigrebal.prg
* Relatorios FRX: SigReBal.frx (principal), SigReAcs.frx (consistencia)
*
* Filtros:
*   - Data final do balanco
*   - Codigo/descricao da moeda de referencia
*   - Codigo/descricao da empresa (vazio = todas)
*   - Opcao conta zerada (1=Sim, 2=Nao)
*   - Opcao tipo relatorio (1=Analitico, 2=Sintetico)
*   - Opcao cliente (1=Analitico, 2=Sintetico)
*   - Opcao analise consistencia (1=Sim, 2=Nao)
*   - Opcao cotacao (1=Fechamento, 2=Movimentacao)
*   - Opcao saldo conciliado (1=Sim, 2=Nao)
*==============================================================================

DEFINE CLASS sigrebalBO AS RelatorioBase

    *-- Filtros do formulario
    this_dDtFinal        = {}
    this_cCdMoeda        = ""
    this_cDsMoeda        = ""
    this_cCdEmpresa      = ""
    this_cDsEmpresa      = ""
    this_nContaz         = 1
    this_nTpRel          = 1
    this_nOptCli         = 1
    this_nOpAnCst        = 2
    this_nOptCotacao     = 1
    this_nOptConcilias   = 2

    *-- Controle interno de relatorio
    this_cArquivoFRX     = ""
    this_cArquivoAcsFRX  = ""
    this_cTitulo         = ""
    this_cCursorDados    = "cPlConta"    && Nome bate com FRX legado SigReBal (Create Cursor cPlconta)
    this_cMensagemErro   = ""

    *--------------------------------------------------------------------------
    * Init - Configura BO de relatorio de balanco
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cTabela      = "SigMvCcr"
            THIS.this_cCampoChave  = ""

            THIS.this_cArquivoFRX    = "SigReBal"
            THIS.this_cArquivoAcsFRX = "SigReAcs"
            THIS.this_cTitulo        = "Balan" + CHR(231) + "o"

            THIS.this_dDtFinal       = DATE()
            THIS.this_cCdMoeda       = ""
            THIS.this_cDsMoeda       = ""
            THIS.this_cCdEmpresa     = ""
            THIS.this_cDsEmpresa     = ""
            THIS.this_nContaz        = 1
            THIS.this_nTpRel         = 1
            THIS.this_nOptCli        = 1
            THIS.this_nOpAnCst       = 2
            THIS.this_nOptCotacao    = 1
            THIS.this_nOptConcilias  = 2

            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrebalBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        IF USED("cursor_4c_BalPam")
            USE IN cursor_4c_BalPam
        ENDIF
        IF USED("cursor_4c_BalCot")
            USE IN cursor_4c_BalCot
        ENDIF
        IF USED("cursor_4c_BalMoe")
            USE IN cursor_4c_BalMoe
        ENDIF
        IF USED("cursor_4c_BalGcr")
            USE IN cursor_4c_BalGcr
        ENDIF
        IF USED("cursor_4c_BalCss")
            USE IN cursor_4c_BalCss
        ENDIF
        IF USED("cursor_4c_BalCli")
            USE IN cursor_4c_BalCli
        ENDIF
        IF USED("cursor_4c_BalMvcr")
            USE IN cursor_4c_BalMvcr
        ENDIF
        IF USED("cursor_4c_BalTmpMccr")
            USE IN cursor_4c_BalTmpMccr
        ENDIF
        IF USED("cPlConta")
            USE IN cPlConta
        ENDIF
        IF USED("Consulta")
            USE IN Consulta
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarReferencias - Carrega cursores auxiliares do SQL Server
    * Equivalente aos CursorQuery() do Init legado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarReferencias()
        LOCAL loc_lSucesso, loc_nResult, loc_oErro
        loc_lSucesso = .T.
        TRY
            *-- SigCdPam - parametros padrao de clientes
            IF USED("cursor_4c_BalPam")
                USE IN cursor_4c_BalPam
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT GrPadClis FROM SigCdPam", "cursor_4c_BalPam")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao carregar SigCdPam"
                loc_lSucesso = .F.
            ENDIF
            *-- SigCdCot - cotacoes de moedas (indexado por moeda+data)
            IF USED("cursor_4c_BalCot")
                USE IN cursor_4c_BalCot
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT CMoes, Datas, Valos FROM SigCdCot", "cursor_4c_BalCot")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao carregar SigCdCot"
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_BalCot
            INDEX ON CMoes + DTOS(Datas) TAG CMoeData
            *-- SigCdMoe - moedas cadastradas
            IF USED("cursor_4c_BalMoe")
                USE IN cursor_4c_BalMoe
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT CMoes, Cotas FROM SigCdMoe", "cursor_4c_BalMoe")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao carregar SigCdMoe"
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_BalMoe
            INDEX ON CMoes TAG CMoes
            *-- SigCdGcr - grupos de conta corrente
            IF USED("cursor_4c_BalGcr")
                USE IN cursor_4c_BalGcr
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Codigos, Descrs, Classes FROM SigCdGcr", "cursor_4c_BalGcr")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao carregar SigCdGcr"
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_BalGcr
            INDEX ON Codigos TAG Codigos
            *-- SigCdCss - classes do sistema contabil (balanco)
            IF USED("cursor_4c_BalCss")
                USE IN cursor_4c_BalCss
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Classes, Descrs, Nivels, OpBalancos FROM SigCdCss", "cursor_4c_BalCss")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao carregar SigCdCss"
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_BalCss
            INDEX ON Classes TAG Classes
            *-- SigCdCli - clientes / contas correntes
            IF USED("cursor_4c_BalCli")
                USE IN cursor_4c_BalCli
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT IClis, Grupos, RClis, Concilias FROM SigCdCli", "cursor_4c_BalCli")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao carregar SigCdCli"
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_BalCli
            INDEX ON Grupos + IClis TAG GrCodigo
            INDEX ON IClis TAG IClis
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrebalBO.CarregarReferencias")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCambio - Retorna cotacao da moeda na data informada
    * Equivalente a fCarregarCambio() do sistema legado
    * Busca a cotacao mais recente <= par_dData para a moeda informada
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarCambio(par_cMoeda, par_dData)
        LOCAL loc_nCotacao, loc_cMoeda
        loc_nCotacao = 1
        loc_cMoeda   = ALLTRIM(par_cMoeda)
        IF USED("cursor_4c_BalCot") AND !EMPTY(loc_cMoeda) AND !EMPTY(par_dData)
            SELECT cursor_4c_BalCot
            SET ORDER TO CMoeData
            IF SEEK(loc_cMoeda + DTOS(par_dData))
                loc_nCotacao = cursor_4c_BalCot.Valos
            ELSE
                SKIP -1
                IF !BOF() AND ALLTRIM(cursor_4c_BalCot.CMoes) = loc_cMoeda AND ;
                   TTOD(cursor_4c_BalCot.Datas) <= par_dData
                    loc_nCotacao = cursor_4c_BalCot.Valos
                ENDIF
            ENDIF
        ENDIF
        RETURN IIF(loc_nCotacao = 0, 1, loc_nCotacao)
    ENDFUNC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa movimentos e monta cPlConta para o relatorio
    * Equivalente ao PROCEDURE processamento do sistema legado (SIGREBAL)
    * Cria cursores cPlConta (SigReBal.frx) e Consulta (SigReAcs.frx)
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_ldDtSaldo, loc_lcCdEmp, loc_lcDsEmp, loc_lcCdMoeda, loc_lcDsMoeda
        LOCAL loc_lnContaz, loc_lnOptRel, loc_lnOptCli, loc_lnOpAnCst
        LOCAL loc_lnOptCot, loc_lnOptConc
        LOCAL loc_lcEmpresa, loc_lcTitulo1s, loc_lcTitulo2s
        LOCAL loc_lnDecimals, loc_lcFixed, loc_lcEscape
        LOCAL loc_lnCot1, loc_lnCot2, loc_lnValors, loc_lnSaldos
        LOCAL loc_lnNivels, loc_lnConta1, loc_lcClasse2
        LOCAL loc_cContas, loc_cDcontas, loc_cOrds, loc_cPs, loc_cIps
        LOCAL loc_lcGrupos, loc_lcContas, loc_lcNopers
        LOCAL loc_nResult, loc_lcQuery, loc_lcDtSQL
        LOCAL ARRAY loc_laOrd(5), loc_laStrArea(5)
        LOCAL ARRAY loc_aFlds(1)

        loc_lSucesso   = .F.
        loc_lcEscape   = ""
        loc_lnDecimals = 0
        loc_lcFixed    = ""

        TRY
            IF !THIS.CarregarReferencias()
                THIS.this_cMensagemErro = "Erro ao carregar refer" + CHR(234) + "ncias"
            ELSE

            loc_ldDtSaldo  = THIS.this_dDtFinal
            loc_lcCdEmp    = ALLTRIM(THIS.this_cCdEmpresa)
            loc_lcDsEmp    = ALLTRIM(THIS.this_cDsEmpresa)
            loc_lcCdMoeda  = ALLTRIM(THIS.this_cCdMoeda)
            loc_lcDsMoeda  = ALLTRIM(THIS.this_cDsMoeda)
            loc_lnContaz   = THIS.this_nContaz
            loc_lnOptRel   = THIS.this_nTpRel
            loc_lnOptCli   = THIS.this_nOptCli
            loc_lnOpAnCst  = THIS.this_nOpAnCst
            loc_lnOptCot   = THIS.this_nOptCotacao
            loc_lnOptConc  = THIS.this_nOptConcilias

            loc_lcEmpresa  = go_4c_Sistema.cEmpresa
            loc_lcTitulo1s = "Balan" + CHR(231) + "o em " + ;
                             DTOC(loc_ldDtSaldo) + " - " + loc_lcDsMoeda
            loc_lcTitulo2s = IIF(!EMPTY(loc_lcCdEmp), ;
                             ALLTRIM(loc_lcCdEmp) + " - " + ALLTRIM(loc_lcDsEmp), ;
                             "TODAS AS EMPRESAS")

            loc_lcEscape   = SET("Escape")
            loc_lnDecimals = VAL(SET("Decimals"))
            loc_lcFixed    = SET("Fixed")
            SET ESCAPE OFF
            SET DECIMALS TO 2
            SET FIXED ON

            *-- Criar cursor de resultado (nome exato exigido por SigReBal.frx)
            IF USED("cPlConta")
                USE IN cPlConta
            ENDIF
            CREATE CURSOR cPlConta (cEmpresas C(40), cTitulo1s C(80), cTitulo2s C(80), ;
                                    cContas C(10), cDContas C(50), nSaldos N(16,2), ;
                                    cOrds C(50), cPs C(1), cIps C(1))
            INDEX ON cOrds TAG cOrds

            *-- Montar string de data limite para o WHERE SQL (fim do dia)
            loc_lcDtSQL = STR(YEAR(loc_ldDtSaldo), 4) + "-" + ;
                          RIGHT("0" + LTRIM(STR(MONTH(loc_ldDtSaldo))), 2) + "-" + ;
                          RIGHT("0" + LTRIM(STR(DAY(loc_ldDtSaldo))), 2) + " 23:59:59"

            *-- Carregar movimentos de conta corrente ate a data saldo
            IF USED("cursor_4c_BalMvcr")
                USE IN cursor_4c_BalMvcr
            ENDIF
            loc_lcQuery = "SELECT Emps, Datas, Opers, Grupos, Contas, Valors, Moedas, " + ;
                          "SValors, SMoedas, Cotacaos, Nopers, Saldos, cIdChaves, Hists, " + ;
                          "Hist2s, Concs, sOpers, sgrupos, scontas, scotacaos, SaldoCs, EmpCcs " + ;
                          "FROM SigMvCcr " + ;
                          "WHERE Datas <= " + EscaparSQL(loc_lcDtSQL) + " OR Datas IS NULL " + ;
                          "ORDER BY Datas, Opers, Grupos, Contas, Valors, " + ;
                          "Moedas, SValors, SMoedas, Cotacaos, Nopers, Saldos, cIdChaves"
            loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "cursor_4c_BalMvcr")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao carregar SigMvCcr"
                SET ESCAPE &loc_lcEscape.
                SET DECIMALS TO loc_lnDecimals
                SET FIXED &loc_lcFixed.
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_BalMvcr
            INDEX ON Datas TAG Datas

            *-- Criar cursor temporario de movimentos (mesma estrutura de cursor_4c_BalMvcr)
            IF USED("cursor_4c_BalTmpMccr")
                USE IN cursor_4c_BalTmpMccr
            ENDIF
            AFIELDS(loc_aFlds, "cursor_4c_BalMvcr")
            SET NULL ON
            CREATE CURSOR cursor_4c_BalTmpMccr FROM ARRAY loc_aFlds
            SET NULL OFF
            SELECT cursor_4c_BalTmpMccr
            INDEX ON Nopers TAG Nopers

            *-- Cotacao base da moeda de referencia na data do balanco
            loc_lnCot2 = THIS.CarregarCambio(loc_lcCdMoeda, loc_ldDtSaldo)

            *-- === LOOP PRINCIPAL: processar cada movimento ===
            SELECT cursor_4c_BalMvcr
            SET ORDER TO Datas
            GO TOP
            DO WHILE !EOF("cursor_4c_BalMvcr") AND ;
                     (ISNULL(cursor_4c_BalMvcr.Datas) OR ;
                      TTOD(cursor_4c_BalMvcr.Datas) <= loc_ldDtSaldo)

                *-- Filtrar por empresa se informada (checar EmpCcs primeiro, depois Emps)
                IF !EMPTY(loc_lcCdEmp)
                    IF IIF(!EMPTY(ALLTRIM(cursor_4c_BalMvcr.EmpCcs)), ;
                           ALLTRIM(cursor_4c_BalMvcr.EmpCcs) <> loc_lcCdEmp, ;
                           ALLTRIM(cursor_4c_BalMvcr.Emps) <> loc_lcCdEmp)
                        SELECT cursor_4c_BalMvcr
                        SKIP
                        LOOP
                    ENDIF
                ENDIF

                loc_lcGrupos = ALLTRIM(cursor_4c_BalMvcr.Grupos)
                loc_lcContas = ALLTRIM(cursor_4c_BalMvcr.Contas)

                *-- Calcular cotacao de conversao para a moeda de referencia
                IF (loc_lnOptCot = 1)
                    loc_lnCot1 = THIS.CarregarCambio(cursor_4c_BalMvcr.Moedas, loc_ldDtSaldo)
                ELSE
                    IF ALLTRIM(cursor_4c_BalMvcr.Moedas) <> ALLTRIM(cursor_4c_BalMvcr.SMoedas)
                        loc_lnCot1 = cursor_4c_BalMvcr.Cotacaos
                    ELSE
                        loc_lnCot1 = THIS.CarregarCambio(cursor_4c_BalMvcr.Moedas, ;
                                         TTOD(cursor_4c_BalMvcr.Datas))
                    ENDIF
                    loc_lnCot2 = THIS.CarregarCambio(loc_lcCdMoeda, ;
                                     TTOD(cursor_4c_BalMvcr.Datas))
                ENDIF

                *-- Determinar valor convertido com base em opcao de saldo conciliado
                SELECT cursor_4c_BalCli
                SET ORDER TO IClis
                SEEK loc_lcContas
                IF (loc_lnOptConc = 2) OR cursor_4c_BalCli.Concilias <> 1
                    IF ALLTRIM(cursor_4c_BalMvcr.SMoedas) = loc_lcCdMoeda AND loc_lnOptCot = 2
                        loc_lnValors = cursor_4c_BalMvcr.SValors
                    ELSE
                        loc_lnValors = (cursor_4c_BalMvcr.Valors * loc_lnCot1 / loc_lnCot2)
                    ENDIF
                ELSE
                    IF !cursor_4c_BalMvcr.Concs
                        SELECT cursor_4c_BalMvcr
                        SKIP
                        LOOP
                    ENDIF
                    IF ALLTRIM(cursor_4c_BalMvcr.SMoedas) = loc_lcCdMoeda AND loc_lnOptCot = 2
                        loc_lnValors = cursor_4c_BalMvcr.SValors
                    ELSE
                        loc_lnValors = (cursor_4c_BalMvcr.Valors * loc_lnCot1 / loc_lnCot2)
                    ENDIF
                ENDIF

                loc_lnSaldos = loc_lnValors * IIF(ALLTRIM(cursor_4c_BalMvcr.Opers) = "D", 1, -1)

                *-- Verificar se conta/grupo/classe pertencem ao balanco
                SELECT cursor_4c_BalCli
                SET ORDER TO IClis
                SEEK loc_lcContas
                IF ((loc_lnContaz = 1 OR !EMPTY(loc_lnSaldos)) AND ;
                    !EMPTY(loc_lcContas) AND FOUND() AND ;
                    !EMPTY(loc_lcGrupos))

                    SELECT cursor_4c_BalGcr
                    SET ORDER TO Codigos
                    SEEK loc_lcGrupos
                    IF FOUND() AND !EMPTY(ALLTRIM(cursor_4c_BalGcr.Classes))
                        SELECT cursor_4c_BalCss
                        SET ORDER TO Classes
                        SEEK PADR(ALLTRIM(cursor_4c_BalGcr.Classes), 1)
                        IF FOUND() AND cursor_4c_BalCss.OpBalancos = 1
                            SELECT cursor_4c_BalCss
                            SEEK cursor_4c_BalGcr.Classes
                            IF FOUND()
                                loc_lcClasse2 = PADR(ALLTRIM(cursor_4c_BalGcr.Classes), 10)
                                loc_lnNivels  = cursor_4c_BalCss.Nivels
                                FOR loc_lnConta1 = 1 TO loc_lnNivels
                                    loc_laOrd(loc_lnConta1)     = PADR(SUBSTR(loc_lcClasse2, 1, ;
                                        VAL(SUBSTR("124", loc_lnConta1, 1))), 10)
                                    loc_laStrArea(loc_lnConta1) = "cursor_4c_BalCss"
                                ENDFOR
                                loc_laOrd(loc_lnNivels + 1)     = PADR(ALLTRIM(cursor_4c_BalGcr.Codigos), 10)
                                loc_laOrd(loc_lnNivels + 2)     = PADR(ALLTRIM(cursor_4c_BalCli.IClis), 10)
                                loc_laStrArea(loc_lnNivels + 1) = "cursor_4c_BalGcr"
                                loc_laStrArea(loc_lnNivels + 2) = "cursor_4c_BalCli"
                                loc_cOrds = ""
                                FOR loc_lnConta1 = 1 TO (loc_lnNivels + 2)
                                    loc_cContas  = loc_laOrd(loc_lnConta1)
                                    IF (loc_lnConta1 <= loc_lnNivels)
                                        SELECT (loc_laStrArea(loc_lnConta1))
                                        SET ORDER TO Classes
                                        SEEK loc_cContas
                                    ENDIF
                                    loc_cOrds    = (loc_cOrds + loc_laOrd(loc_lnConta1))
                                    loc_cDcontas = EVALUATE(loc_laStrArea(loc_lnConta1) + ;
                                        IIF(loc_lnConta1 = (loc_lnNivels + 2), ".RClis", ".Descrs"))
                                    loc_cPs  = STR(IIF(loc_lnConta1 <= loc_lnNivels, ;
                                        loc_lnConta1, IIF(loc_lnConta1 = (loc_lnNivels + 1), 4, 5)), 1)
                                    loc_cIps = STR(loc_lnConta1, 1)
                                    SELECT cursor_4c_BalPam
                                    GO TOP
                                    IF ((cursor_4c_BalCli.Grupos = cursor_4c_BalPam.GrPadClis) AND ;
                                        (loc_lnOptCli = 1 OR loc_cPs <> "5")) OR ;
                                       ((loc_lnOptRel = 1 OR loc_cPs <> "5") AND ;
                                        (cursor_4c_BalCli.Grupos <> cursor_4c_BalPam.GrPadClis))
                                        SELECT cPlConta
                                        SET ORDER TO cOrds
                                        IF !SEEK(PADR(loc_cOrds, 50), "cPlConta", "cOrds")
                                            INSERT INTO cPlConta ;
                                                (cEmpresas, cTitulo1s, cTitulo2s, cContas, ;
                                                 cDContas, nSaldos, cOrds, cPs, cIps) ;
                                                VALUES (loc_lcEmpresa, loc_lcTitulo1s, ;
                                                loc_lcTitulo2s, loc_cContas, loc_cDcontas, ;
                                                0, PADR(loc_cOrds, 50), loc_cPs, loc_cIps)
                                            SELECT cPlConta
                                            SET ORDER TO cOrds
                                            SEEK PADR(loc_cOrds, 50)
                                        ENDIF
                                        REPLACE nSaldos WITH nSaldos + loc_lnSaldos IN cPlConta
                                        IF loc_lnConta1 = loc_lnNivels + 2 AND ;
                                           loc_lnContaz = 2 AND EMPTY(cPlConta.nSaldos)
                                            DELETE IN cPlConta
                                        ENDIF
                                    ENDIF
                                ENDFOR
                                *-- Registrar no cursor de analise de consistencia
                                loc_lcNopers = ALLTRIM(cursor_4c_BalMvcr.Nopers)
                                SELECT cursor_4c_BalTmpMccr
                                SET ORDER TO Nopers
                                IF !SEEK(loc_lcNopers)
                                    INSERT INTO cursor_4c_BalTmpMccr ;
                                        (Emps, Datas, Opers, Grupos, Contas, Valors, Moedas, ;
                                         SValors, SMoedas, Cotacaos, Nopers, Saldos, cIdChaves, ;
                                         Hists, Hist2s, Concs, sOpers, sgrupos, scontas, ;
                                         scotacaos, SaldoCs, EmpCcs) ;
                                        VALUES (cursor_4c_BalMvcr.Emps, cursor_4c_BalMvcr.Datas, ;
                                        cursor_4c_BalMvcr.Opers, cursor_4c_BalMvcr.Grupos, ;
                                        cursor_4c_BalMvcr.Contas, cursor_4c_BalMvcr.Valors, ;
                                        cursor_4c_BalMvcr.Moedas, cursor_4c_BalMvcr.SValors, ;
                                        cursor_4c_BalMvcr.SMoedas, cursor_4c_BalMvcr.Cotacaos, ;
                                        cursor_4c_BalMvcr.Nopers, 0, cursor_4c_BalMvcr.cIdChaves, ;
                                        cursor_4c_BalMvcr.Hists, cursor_4c_BalMvcr.Hist2s, ;
                                        cursor_4c_BalMvcr.Concs, cursor_4c_BalMvcr.sOpers, ;
                                        cursor_4c_BalMvcr.sgrupos, cursor_4c_BalMvcr.scontas, ;
                                        cursor_4c_BalMvcr.scotacaos, cursor_4c_BalMvcr.SaldoCs, ;
                                        cursor_4c_BalMvcr.EmpCcs)
                                ENDIF
                                REPLACE Saldos WITH Saldos + loc_lnSaldos IN cursor_4c_BalTmpMccr
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF

                SELECT cursor_4c_BalMvcr
                SKIP
            ENDDO

            *-- === LOOP ZERO-BALANCE: incluir contas cadastradas com saldo zero ===
            IF (loc_lnContaz = 1)
                *-- Varrer clientes para incluir contas zeradas
                SELECT cursor_4c_BalCli
                SET ORDER TO GrCodigo
                SCAN
                    IF !EMPTY(ALLTRIM(cursor_4c_BalCli.IClis)) AND ;
                       !EMPTY(ALLTRIM(cursor_4c_BalCli.Grupos))
                        SELECT cursor_4c_BalGcr
                        SET ORDER TO Codigos
                        SEEK ALLTRIM(cursor_4c_BalCli.Grupos)
                        IF FOUND() AND !EMPTY(ALLTRIM(cursor_4c_BalGcr.Classes))
                            SELECT cursor_4c_BalCss
                            SET ORDER TO Classes
                            SEEK PADR(ALLTRIM(cursor_4c_BalGcr.Classes), 1)
                            IF FOUND() AND cursor_4c_BalCss.OpBalancos = 1
                                SELECT cursor_4c_BalCss
                                SEEK cursor_4c_BalGcr.Classes
                                IF FOUND()
                                    loc_lcClasse2 = PADR(ALLTRIM(cursor_4c_BalGcr.Classes), 10)
                                    loc_lnNivels  = cursor_4c_BalCss.Nivels
                                    FOR loc_lnConta1 = 1 TO loc_lnNivels
                                        loc_laOrd(loc_lnConta1)     = PADR(SUBSTR(loc_lcClasse2, 1, ;
                                            VAL(SUBSTR("124", loc_lnConta1, 1))), 10)
                                        loc_laStrArea(loc_lnConta1) = "cursor_4c_BalCss"
                                    ENDFOR
                                    loc_laOrd(loc_lnNivels + 1)     = PADR(ALLTRIM(cursor_4c_BalGcr.Codigos), 10)
                                    loc_laOrd(loc_lnNivels + 2)     = PADR(ALLTRIM(cursor_4c_BalCli.IClis), 10)
                                    loc_laStrArea(loc_lnNivels + 1) = "cursor_4c_BalGcr"
                                    loc_laStrArea(loc_lnNivels + 2) = "cursor_4c_BalCli"
                                    loc_cOrds = ""
                                    FOR loc_lnConta1 = 1 TO (loc_lnNivels + 2)
                                        loc_cContas  = loc_laOrd(loc_lnConta1)
                                        IF (loc_lnConta1 <= loc_lnNivels)
                                            SELECT (loc_laStrArea(loc_lnConta1))
                                            SET ORDER TO Classes
                                            SEEK loc_cContas
                                        ENDIF
                                        loc_cOrds    = (loc_cOrds + loc_laOrd(loc_lnConta1))
                                        loc_cDcontas = EVALUATE(loc_laStrArea(loc_lnConta1) + ;
                                            IIF(loc_lnConta1 = (loc_lnNivels + 2), ".RClis", ".Descrs"))
                                        loc_cPs  = STR(IIF(loc_lnConta1 <= loc_lnNivels, ;
                                            loc_lnConta1, IIF(loc_lnConta1 = (loc_lnNivels + 1), 4, 5)), 1)
                                        loc_cIps = STR(loc_lnConta1, 1)
                                        SELECT cursor_4c_BalPam
                                        GO TOP
                                        IF ((cursor_4c_BalCli.Grupos = cursor_4c_BalPam.GrPadClis) AND ;
                                            (loc_lnOptCli = 1 OR loc_cPs <> "5")) OR ;
                                           ((loc_lnOptRel = 1 OR loc_cPs <> "5") AND ;
                                            (cursor_4c_BalCli.Grupos <> cursor_4c_BalPam.GrPadClis))
                                            SELECT cPlConta
                                            SET ORDER TO cOrds
                                            IF !SEEK(PADR(loc_cOrds, 50), "cPlConta", "cOrds")
                                                INSERT INTO cPlConta ;
                                                    (cEmpresas, cTitulo1s, cTitulo2s, cContas, ;
                                                     cDContas, nSaldos, cOrds, cPs, cIps) ;
                                                    VALUES (loc_lcEmpresa, loc_lcTitulo1s, ;
                                                    loc_lcTitulo2s, loc_cContas, loc_cDcontas, ;
                                                    0, PADR(loc_cOrds, 50), loc_cPs, loc_cIps)
                                            ENDIF
                                        ENDIF
                                        SELECT cursor_4c_BalCli
                                    ENDFOR
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDSCAN
                *-- Varrer grupos para incluir entradas de grupos/classes zerados
                SELECT cursor_4c_BalGcr
                SET ORDER TO Codigos
                SCAN
                    IF !EMPTY(ALLTRIM(cursor_4c_BalGcr.Codigos)) AND ;
                       !EMPTY(ALLTRIM(cursor_4c_BalGcr.Classes))
                        SELECT cursor_4c_BalCss
                        SET ORDER TO Classes
                        SEEK PADR(ALLTRIM(cursor_4c_BalGcr.Classes), 1)
                        IF FOUND() AND cursor_4c_BalCss.OpBalancos = 1
                            SELECT cursor_4c_BalCss
                            SEEK cursor_4c_BalGcr.Classes
                            IF FOUND()
                                loc_lcClasse2 = PADR(ALLTRIM(cursor_4c_BalGcr.Classes), 10)
                                loc_lnNivels  = cursor_4c_BalCss.Nivels
                                FOR loc_lnConta1 = 1 TO loc_lnNivels
                                    loc_laOrd(loc_lnConta1)     = PADR(SUBSTR(loc_lcClasse2, 1, ;
                                        VAL(SUBSTR("124", loc_lnConta1, 1))), 10)
                                    loc_laStrArea(loc_lnConta1) = "cursor_4c_BalCss"
                                ENDFOR
                                loc_laOrd(loc_lnNivels + 1)     = PADR(ALLTRIM(cursor_4c_BalGcr.Codigos), 10)
                                loc_laStrArea(loc_lnNivels + 1) = "cursor_4c_BalGcr"
                                loc_cOrds = ""
                                FOR loc_lnConta1 = 1 TO (loc_lnNivels + 1)
                                    loc_cContas  = loc_laOrd(loc_lnConta1)
                                    IF (loc_lnConta1 <= loc_lnNivels)
                                        SELECT (loc_laStrArea(loc_lnConta1))
                                        SET ORDER TO Classes
                                        SEEK loc_cContas
                                    ENDIF
                                    loc_cOrds    = (loc_cOrds + loc_laOrd(loc_lnConta1))
                                    loc_cDcontas = EVALUATE(loc_laStrArea(loc_lnConta1) + ;
                                        IIF(loc_lnConta1 = (loc_lnNivels + 2), ".RClis", ".Descrs"))
                                    loc_cPs  = STR(IIF(loc_lnConta1 <= loc_lnNivels, ;
                                        loc_lnConta1, IIF(loc_lnConta1 = (loc_lnNivels + 1), 4, 5)), 1)
                                    loc_cIps = STR(loc_lnConta1, 1)
                                    IF (loc_lnOptRel = 1 OR loc_cPs <> "5")
                                        SELECT cPlConta
                                        SET ORDER TO cOrds
                                        IF !SEEK(PADR(loc_cOrds, 50), "cPlConta", "cOrds")
                                            INSERT INTO cPlConta ;
                                                (cEmpresas, cTitulo1s, cTitulo2s, cContas, ;
                                                 cDContas, nSaldos, cOrds, cPs, cIps) ;
                                                VALUES (loc_lcEmpresa, loc_lcTitulo1s, ;
                                                loc_lcTitulo2s, loc_cContas, loc_cDcontas, ;
                                                0, PADR(loc_cOrds, 50), loc_cPs, loc_cIps)
                                        ENDIF
                                    ENDIF
                                    SELECT cursor_4c_BalGcr
                                ENDFOR
                            ENDIF
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

            *-- Criar cursor Consulta (nome exato exigido por SigReAcs.frx)
            IF USED("Consulta")
                USE IN Consulta
            ENDIF
            SELECT * FROM cursor_4c_BalTmpMccr ;
                WHERE ABS(Saldos) > 1 ;
                INTO CURSOR Consulta READWRITE

            *-- Fechar cursor de movimentos (dados ja processados)
            IF USED("cursor_4c_BalMvcr")
                USE IN cursor_4c_BalMvcr
            ENDIF

            *-- Ordenar cPlConta para apresentacao correta no relatorio
            SELECT cPlConta
            SET ORDER TO cOrds ASCENDING
            GO TOP

            SET ESCAPE &loc_lcEscape.
            SET DECIMALS TO loc_lnDecimals
            SET FIXED &loc_lcFixed.

            loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrebalBO.PrepararDados")
            IF !EMPTY(loc_lcEscape)
                SET ESCAPE &loc_lcEscape.
            ENDIF
            IF loc_lnDecimals > 0
                SET DECIMALS TO loc_lnDecimals
            ENDIF
            IF !EMPTY(loc_lcFixed)
                SET FIXED &loc_lcFixed.
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Preview do relatorio de balanco na tela
    * Equivalente ao PROCEDURE visualizacao do sistema legado
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro, loc_lcFrxPath
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + ;
                    "vel preparar os dados do relat" + CHR(243) + "rio.", ;
                    "Balan" + CHR(231) + "o")
            ELSE
                loc_lcFrxPath = ADDBS(gc_4c_CaminhoReports) + THIS.this_cArquivoFRX
                REPORT FORM (loc_lcFrxPath) PREVIEW NOCONSOLE
                IF THIS.this_nOpAnCst = 1 AND USED("Consulta")
                    SELECT Consulta
                    GO TOP
                    IF RECCOUNT() > 0
                        loc_lcFrxPath = ADDBS(gc_4c_CaminhoReports) + THIS.this_cArquivoAcsFRX
                        REPORT FORM (loc_lcFrxPath) PREVIEW NOCONSOLE
                    ENDIF
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrebalBO.Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime relatorio direto na impressora padrao
    * Equivalente ao PROCEDURE documento do sistema legado
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro, loc_lcFrxPath
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + ;
                    "vel preparar os dados do relat" + CHR(243) + "rio.", ;
                    "Balan" + CHR(231) + "o")
            ELSE
                loc_lcFrxPath = ADDBS(gc_4c_CaminhoReports) + THIS.this_cArquivoFRX
                REPORT FORM (loc_lcFrxPath) TO PRINTER NOCONSOLE
                IF THIS.this_nOpAnCst = 1 AND USED("Consulta")
                    SELECT Consulta
                    GO TOP
                    IF RECCOUNT() > 0
                        loc_lcFrxPath = ADDBS(gc_4c_CaminhoReports) + THIS.this_cArquivoAcsFRX
                        REPORT FORM (loc_lcFrxPath) TO PRINTER NOCONSOLE
                    ENDIF
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrebalBO.Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros do BO a partir de um cursor
    * Em BOs REPORT este metodo nao aplica operacao CRUD: os filtros sao
    * preenchidos via FormParaRelatorio() chamando atribuicoes diretas.
    * Mantemos a assinatura para compatibilidade com o contrato de BOs.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            *-- Mapeamento opcional caso o cursor possua os campos de filtro
            IF TYPE(par_cAliasCursor + ".DtFinal") = "D"
                THIS.this_dDtFinal = NVL(EVALUATE(par_cAliasCursor + ".DtFinal"), DATE())
            ENDIF
            IF TYPE(par_cAliasCursor + ".CMoes") = "C"
                THIS.this_cCdMoeda = NVL(EVALUATE(par_cAliasCursor + ".CMoes"), "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".DMoes") = "C"
                THIS.this_cDsMoeda = NVL(EVALUATE(par_cAliasCursor + ".DMoes"), "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".Emps") = "C"
                THIS.this_cCdEmpresa = NVL(EVALUATE(par_cAliasCursor + ".Emps"), "")
            ENDIF
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - BOs REPORT nao realizam INSERT em tabelas
    * Operacao nao se aplica: o relatorio apenas LE dados via PrepararDados().
    * Retorna .F. e registra mensagem para qualquer chamada acidental.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o de inser" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o se aplica a relat" + CHR(243) + "rios."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - BOs REPORT nao realizam UPDATE em tabelas
    * Operacao nao se aplica: o relatorio apenas LE dados via PrepararDados().
    * Retorna .F. e registra mensagem para qualquer chamada acidental.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o de atualiza" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o se aplica a relat" + CHR(243) + "rios."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - REPORT BO nao possui registro corrente unico
    * Retorna chave composta dos filtros (data+moeda+empresa) para auditoria.
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = DTOS(THIS.this_dDtFinal) + "|" + ;
                     ALLTRIM(THIS.this_cCdMoeda) + "|" + ;
                     ALLTRIM(THIS.this_cCdEmpresa)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra emissao de relatorio em LogAuditoria
    * Chamado por Visualizar/Imprimir/ImprimirComPrompt apos emissao bem-sucedida.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cChave, loc_cUsuario, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cChave   = THIS.ObterChavePrimaria()
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                               ALLTRIM(gc_4c_UsuarioLogado), "")
            loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SigMvCcr") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(loc_cUsuario) + ", GETDATE())"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirComPrompt - Imprime relatorio com dialogo de selecao de impressora
    * Equivalente ao PROCEDURE impressao do sistema legado
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirComPrompt()
        LOCAL loc_lSucesso, loc_oErro, loc_lcFrxPath
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + ;
                    "vel preparar os dados do relat" + CHR(243) + "rio.", ;
                    "Balan" + CHR(231) + "o")
            ELSE
                loc_lcFrxPath = ADDBS(gc_4c_CaminhoReports) + THIS.this_cArquivoFRX
                REPORT FORM (loc_lcFrxPath) TO PRINTER PROMPT NOCONSOLE
                IF THIS.this_nOpAnCst = 1 AND USED("Consulta")
                    SELECT Consulta
                    GO TOP
                    IF RECCOUNT() > 0
                        loc_lcFrxPath = ADDBS(gc_4c_CaminhoReports) + THIS.this_cArquivoAcsFRX
                        REPORT FORM (loc_lcFrxPath) TO PRINTER PROMPT NOCONSOLE
                    ENDIF
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrebalBO.ImprimirComPrompt")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
