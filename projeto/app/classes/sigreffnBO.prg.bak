*==============================================================================
* SIGREFFNBO.PRG
* Business Object para Relatorio de Fluxo Financeiro - Sintetico (SIGREFFN)
*
* Herda de RelatorioBase
*
* Formulario de origem: sigreffn.SCX (frmrelatorio)
* Reports FRX: SigReFf1.frx (Diario/Mensal - sem totalizacao de contas)
*              SigReFf2.frx (Semanal/Quinzenal - sem totalizacao de contas)
*              SigReFf3.frx (com totalizacao de contas - Check1 marcado)
*
* Filtros:
*   - Periodo (data inicial / data final)
*   - Moeda de referencia (codigo + descricao + cotacao)
*   - Moeda de lancamento (codigo + descricao)
*   - Totaliza Contas (CheckBox)
*   - Conciliado (CheckBox)
*   - Opcao NF (1=Sim / 2=Nao / 3=Ambos)
*   - Tipo Impressao (1=Diario / 2=Semanal / 3=Quinzenal / 4=Mensal)
*   - Saldo (1=Anterior / 2=Na Data)
*   - Situacao (1=Baixados / 2=Em Aberto / 3=Todos)
*   - Listar Atrasos (1=Sim / 2=Nao)
*   - Considerar Atrasos (1=Sim / 2=Nao)
*   - Previsto (1=Sim / 2=Nao / 3=Ambos)
*   - Empresas selecionadas (cursor cEmp com campo ImpEmps)
*   - Disponibilidades selecionadas (cursor cDisp com campo ImpDisps)
*   - Operacoes de Titulos selecionadas (cursor crSigOpOpe com campo SeleOp)
*==============================================================================

DEFINE CLASS sigreffnBO AS RelatorioBase

    *-- Filtros de periodo
    this_dDtInicial         = {}
    this_dDtFinal           = {}

    *-- Filtros de moeda de referencia (conversao de valores)
    this_cCdMoeda           = ""
    this_cDsMoeda           = ""
    this_nVlCotacao         = 0

    *-- Filtros de moeda de lancamento (filtro nos titulos)
    this_cCdMoedl           = ""
    this_cDsMoedl           = ""

    *-- CheckBoxes
    this_nTotalizaContas    = 0  && 0=Desmarcado 1=Marcado
    this_nConciliado        = 0  && 0=Desmarcado 1=Marcado

    *-- Opcoes de filtro - OptionGroups (espelham .Value do form legado)
    this_nOpcao             = 3  && Opt_Opcao:       1=Sim(com NF) 2=Nao(sem NF) 3=Ambos
    this_nTipoImp           = 1  && opt_tipo:        1=Diario 2=Semanal 3=Quinzenal 4=Mensal
    this_nSaldo             = 1  && OptSaldo:        1=Anterior 2=Na Data
    this_nSitua             = 2  && opt_situa:       1=Baixados 2=Pendentes 3=Todos
    this_nListaAtra         = 1  && opt_Lista_Atra:  1=Sim 2=Nao
    this_nConsidAtra        = 2  && Opt_Consid_Atra: 1=Sim 2=Nao
    this_nPrev              = 3  && OptPrev:         1=Sim(previsto) 2=Nao 3=Ambos

    *-- Chave unica de processamento para SigTempR
    *   Populada em PrepararDados() via fUniqueIds()
    this_cChaveQuery        = ""

    *-- Nome do cursor de dados gerado por PrepararDados()
    this_cCursorDados       = "cursor_4c_Dados"

    *-- Mensagem de erro
    this_cMensagemErro      = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO do relatorio de Fluxo Financeiro
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
    * ObterMensagemErro - Retorna a mensagem de erro mais recente
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarCursoresAuxiliares - Carrega cursores de referencia para os grids do form
    * Equivalente ao Init() do legado: crSigOpOpe, cEmp, cDisp, crSigCdPag, crSigCdRec, etc.
    *--------------------------------------------------------------------------
    PROCEDURE InicializarCursoresAuxiliares()
        LOCAL loc_lSucesso, loc_lnResult
        loc_lSucesso = .F.
        TRY
            *-- Opera??es de T?tulo (SigOpOpe -> crSigOpOpe)
            loc_lnResult = SQLEXEC(gnConnHandle, ;
                "SELECT Dopes, Opers, RealPrevs, OpeCancs FROM SigOpOpe", ;
                "cursor_4c_TmpSigOpOpe")
            IF loc_lnResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar opera" + CHR(231) + CHR(245) + "es de t" + CHR(237) + "tulo"
                loc_lSucesso = .F.
            ENDIF
            SELECT .F. AS SeleOp, Dopes, RealPrevs, Opers ;
              FROM cursor_4c_TmpSigOpOpe ;
             WHERE OpeCancs <> 1 ;
             ORDER BY Dopes ;
              INTO CURSOR crSigOpOpe READWRITE
            IF USED("cursor_4c_TmpSigOpOpe")
                USE IN cursor_4c_TmpSigOpOpe
            ENDIF
            SELECT crSigOpOpe
            INDEX ON Dopes TAG Dopes
            INDEX ON TRANSFORM(SeleOp, "@!") + Dopes TAG SeleOp
            SET ORDER TO Dopes
            GO TOP

            *-- Empresas (SigCdEmp -> cEmp)
            loc_lnResult = SQLEXEC(gnConnHandle, ;
                "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Razas", ;
                "cursor_4c_TmpSigCdEmp")
            IF loc_lnResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar empresas"
                loc_lSucesso = .F.
            ENDIF
            SELECT .F. AS ImpEmps, Cemps, Razas ;
              FROM cursor_4c_TmpSigCdEmp ;
              INTO CURSOR cEmp READWRITE
            IF USED("cursor_4c_TmpSigCdEmp")
                USE IN cursor_4c_TmpSigCdEmp
            ENDIF
            SELECT cEmp
            INDEX ON Cemps TAG Cemps
            INDEX ON TRANSFORM(ImpEmps, "@!") + Cemps TAG ImpEmps
            SET ORDER TO Cemps
            *-- Marca empresa corrente automaticamente
            IF SEEK(ALLTRIM(go_4c_Sistema.cCodEmpresa), "cEmp", "Cemps")
                LOCAL loc_ImpEmps
                loc_ImpEmps = .T.
                GATHER MEMVAR FIELDS ImpEmps
            ENDIF

            *-- Disponibilidades (SigCdDis -> cDisp) - todas marcadas por default
            loc_lnResult = SQLEXEC(gnConnHandle, ;
                "SELECT Grupos, Contas, Tipos FROM SigCdDis WHERE Tipos IN (0,1) ORDER BY Grupos", ;
                "cursor_4c_TmpSigCdDis")
            IF loc_lnResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar disponibilidades"
                loc_lSucesso = .F.
            ENDIF
            SELECT .T. AS ImpDisps, Grupos, Contas ;
              FROM cursor_4c_TmpSigCdDis ;
              INTO CURSOR cDisp READWRITE
            IF USED("cursor_4c_TmpSigCdDis")
                USE IN cursor_4c_TmpSigCdDis
            ENDIF
            SELECT cDisp
            INDEX ON Grupos + Contas TAG Grupos
            INDEX ON TRANSFORM(ImpDisps, "@!") + Grupos + Contas TAG ImpDisps
            SET ORDER TO Grupos

            *-- Grupos de Pagamento (SigCdPag -> crSigCdPag)
            loc_lnResult = SQLEXEC(gnConnHandle, "SELECT Grupos, RelPrevs FROM SigCdPag", "crSigCdPag")
            IF loc_lnResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar grupos de pagamento"
                loc_lSucesso = .F.
            ENDIF
            SELECT crSigCdPag
            INDEX ON Grupos TAG Grupos

            *-- Grupos de Recebimento (SigCdRec -> crSigCdRec)
            loc_lnResult = SQLEXEC(gnConnHandle, "SELECT Grupos FROM SigCdRec", "crSigCdRec")
            IF loc_lnResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar grupos de recebimento"
                loc_lSucesso = .F.
            ENDIF
            SELECT crSigCdRec
            INDEX ON Grupos TAG Grupos

            *-- Moedas (SigCdMoe -> crSigCdMoe)
            loc_lnResult = SQLEXEC(gnConnHandle, "SELECT CMoes, DMoes, Cotas FROM SigCdMoe", "crSigCdMoe")
            IF loc_lnResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar moedas"
                loc_lSucesso = .F.
            ENDIF
            SELECT crSigCdMoe
            INDEX ON CMoes TAG CMoes

            *-- Cota??es de Moeda (SigCdCot -> crSigCdCot)
            loc_lnResult = SQLEXEC(gnConnHandle, ;
                "SELECT CMoes, Datas, Valos FROM SigCdCot", "crSigCdCot")
            IF loc_lnResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar cota" + CHR(231) + CHR(245) + "es"
                loc_lSucesso = .F.
            ENDIF
            SELECT crSigCdCot
            INDEX ON CMoes + DTOS(Datas) TAG CMoeData

            *-- Moeda padr?o (SigCdPam) - define valores default do form
            loc_lnResult = SQLEXEC(gnConnHandle, "SELECT TOP 1 MoedaPs FROM SigCdPam", "crSigCdPam")
            IF loc_lnResult > 0 AND !EOF("crSigCdPam")
                THIS.this_cCdMoeda   = ALLTRIM(crSigCdPam.MoedaPs)
                THIS.this_dDtInicial = DATE()
                THIS.this_dDtFinal   = DATE()
                *-- Descri??o da moeda padr?o
                IF USED("crSigCdMoe") AND SEEK(ALLTRIM(crSigCdPam.MoedaPs), "crSigCdMoe", "CMoes")
                    THIS.this_cDsMoeda = ALLTRIM(crSigCdMoe.DMoes)
                ENDIF
                *-- Cota??o atual da moeda padr?o
                THIS.this_nVlCotacao = THIS.BuscarCotacaoAtual(ALLTRIM(crSigCdPam.MoedaPs))
            ENDIF
            IF USED("crSigCdPam")
                USE IN crSigCdPam
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro em InicializarCursoresAuxiliares")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa todo o processamento do fluxo financeiro
    * Equivalente ao m?todo Procedure (729 linhas) do legado SIGREFFN
    * Cria cursors: csRelatorio, csCabecalho, crRel (semanal/quinzenal)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso
        LOCAL loc_ldDtInicial, loc_ldDtFinal, loc_lcCdMoeda, loc_lcDsMoeda
        LOCAL loc_lnVlCotacao, loc_lnSaldos, loc_llImprime, loc_llConc
        LOCAL loc_lnOpcao, loc_lcMoeLanc, loc_lnTipoImp, loc_lnConsAtra
        LOCAL loc_lnNrSitua, loc_lnListaAtra, loc_lnNrPrev
        LOCAL loc_lcNmEmpresa, loc_lcNmTitulo, loc_lcNmPeriodo
        LOCAL loc_lcCbEmpresa, loc_lcCbMoeda, loc_lcCbMoeRef
        LOCAL loc_lcQuery, loc_ldDtAux, loc_lnResult
        LOCAL loc_lnSaldo, loc_lnVlSaldoTotal, loc_lnTotAtrasos
        LOCAL loc_pKey, loc_llPrevs
        LOCAL loc_lnCtReferencia, loc_lnVlConvertido
        LOCAL loc_ldVencimento, loc_lnPagamentos, loc_lnRecebimentos
        LOCAL loc_lnDoDia, loc_lnAcumulado, loc_lnPrevPag, loc_lnPrevRec
        LOCAL loc_i, loc_lcCursor, loc_lnIdx
        LOCAL loc_dSaldoData, loc_pGcm, loc_pDat, loc_pDtI, loc_pDtF
        LOCAL loc_pDop, loc_pRea, loc_pIds

        loc_lSucesso = .F.
        TRY
            *-- Mapear propriedades para vari?veis locais
            loc_ldDtInicial  = THIS.this_dDtInicial
            loc_ldDtFinal    = THIS.this_dDtFinal
            loc_lcCdMoeda    = THIS.this_cCdMoeda
            loc_lcDsMoeda    = THIS.this_cDsMoeda
            loc_lnVlCotacao  = THIS.this_nVlCotacao
            loc_lnSaldos     = THIS.this_nSaldo
            loc_llImprime    = (THIS.this_nTotalizaContas = 1)
            loc_llConc       = (THIS.this_nConciliado = 1)
            loc_lnOpcao      = THIS.this_nOpcao
            loc_lcMoeLanc    = THIS.this_cCdMoedl
            loc_lnTipoImp    = THIS.this_nTipoImp
            loc_lnConsAtra   = THIS.this_nConsidAtra
            loc_lnNrSitua    = THIS.this_nSitua
            loc_lnListaAtra  = THIS.this_nListaAtra
            loc_lnNrPrev     = THIS.this_nPrev

            IF EMPTY(loc_ldDtFinal)
                THIS.this_cMensagemErro = "Data final " + CHR(233) + " obrigat" + CHR(243) + "ria"
                loc_lSucesso = .F.
            ENDIF
            IF EMPTY(loc_lcCdMoeda)
                THIS.this_cMensagemErro = "Moeda de refer" + CHR(234) + "ncia " + CHR(233) + " obrigat" + CHR(243) + "ria"
                loc_lSucesso = .F.
            ENDIF
            IF loc_lnVlCotacao = 0
                loc_lnVlCotacao = 1
            ENDIF

            *-- Nome da empresa corrente
            loc_lcNmEmpresa = ""
            IF USED("cEmp") AND SEEK(ALLTRIM(go_4c_Sistema.cCodEmpresa), "cEmp", "Cemps")
                loc_lcNmEmpresa = ALLTRIM(cEmp.Razas)
            ENDIF

            *-- Strings do cabe?alho
            loc_lcNmTitulo  = "Fluxo Financeiro" + IIF(loc_llConc, " - (Conciliado)", "")
            loc_lcNmPeriodo = "Per" + CHR(237) + "odo: " + DTOC(loc_ldDtInicial) + ;
                              " " + CHR(224) + " " + DTOC(loc_ldDtFinal)
            loc_lcCbEmpresa = ""
            loc_lcCbMoeda   = "Moeda: " + ALLTRIM(loc_lcCdMoeda) + " - " + ;
                              PROPER(ALLTRIM(loc_lcDsMoeda)) + " / " + ;
                              "Cota" + CHR(231) + CHR(227) + "o: " + ;
                              ALLTRIM(TRANSFORM(loc_lnVlCotacao, "999,999.99"))
            loc_lcCbMoeRef  = loc_lcCdMoeda
            IF loc_lnNrSitua <> 3
                loc_lcCbEmpresa = loc_lcCbEmpresa + "   Situa" + CHR(231) + CHR(227) + "o: " + ;
                                  IIF(loc_lnNrSitua = 1, "Baixados", "Pendentes")
            ENDIF

            *-- Cursor de per?odos (semanal/quinzenal)
            CREATE CURSOR crPeriodos (dFinal d(8))
            IF loc_lnTipoImp = 2 OR loc_lnTipoImp = 3
                loc_ldDtAux = loc_ldDtInicial
                IF loc_lnTipoImp = 2
                    DO WHILE loc_ldDtAux <= loc_ldDtFinal
                        INSERT INTO crPeriodos VALUES (THIS.GoDayOfWeek(loc_ldDtAux, 7))
                        loc_ldDtAux = loc_ldDtAux + 7
                    ENDDO
                ELSE
                    loc_ldDtAux = IIF(DAY(loc_ldDtInicial) > 15, ;
                        GOMONTH(loc_ldDtInicial, 1) - DAY(loc_ldDtInicial), ;
                        CTOD("15" + RIGHT(DTOC(loc_ldDtInicial), 8)))
                    DO WHILE loc_ldDtAux <= loc_ldDtFinal
                        INSERT INTO crPeriodos VALUES (loc_ldDtAux)
                        loc_ldDtAux = loc_ldDtAux + IIF(DAY(loc_ldDtAux) = 1, 16, 1)
                        loc_ldDtAux = IIF(DAY(loc_ldDtAux) > 15, ;
                            GOMONTH(loc_ldDtAux, 1) - DAY(loc_ldDtAux), ;
                            CTOD("15" + RIGHT(DTOC(loc_ldDtAux), 8)))
                    ENDDO
                ENDIF
                IF crPeriodos.dFinal < loc_ldDtFinal
                    INSERT INTO crPeriodos VALUES (loc_ldDtFinal)
                ENDIF
                IF crPeriodos.dFinal > loc_ldDtFinal
                    REPLACE dFinal WITH loc_ldDtFinal IN crPeriodos
                ENDIF
            ENDIF

            *-- Cursor de resultado
            CREATE CURSOR csRelatorio (Grupos c(10), Contas c(10), Saldos n(12,2), ;
                Moedas c(3), vl_Convertido n(12,2), vl_Cotacao n(9,2), Vencs c(10), ;
                Pags n(12,2), Recs n(12,2), do_Dia n(12,2), Acumulado n(12,2), ;
                Saldo n(12,2), Fase n(1,0), DsContas c(50), PrevPags n(12,2), PrevRecs n(12,2))
            IF loc_llImprime
                INDEX ON STR(Fase, 1) + Contas TAG Fase
            ELSE
                INDEX ON STR(Fase, 1) + Grupos + Contas TAG Fase
            ENDIF

            *-- Cursor de cabe?alho para o relat?rio
            CREATE CURSOR csCabecalho (nm_empresa c(80), nm_titulo c(80), nm_periodo c(80), ;
                cb_empresa c(80), cb_moeda c(80), cb_moe_ref c(3), ConsidAtra n(1))
            INSERT INTO csCabecalho (nm_empresa, nm_titulo, nm_periodo, cb_empresa, ;
                cb_moeda, cb_moe_ref, ConsidAtra) ;
                VALUES (loc_lcNmEmpresa, loc_lcNmTitulo, loc_lcNmPeriodo, ;
                    loc_lcCbEmpresa, loc_lcCbMoeda, loc_lcCbMoeRef, loc_lnConsAtra)

            *-- Chave ?nica para namespacing em SigTempR
            loc_pKey      = SYS(2015)
            THIS.this_cChaveQuery = loc_pKey
            loc_llPrevs   = .F.

            *-- Inserir opera??es selecionadas em SigTempR (SQL Server)
            WAIT WINDOW "Atualizando Arquivo Tempor" + CHR(225) + "rio..." NOWAIT
            SELECT crSigOpOpe
            GO TOP
            SCAN
                IF crSigOpOpe.SeleOp
                    loc_pDop = ALLTRIM(crSigOpOpe.Dopes)
                    loc_pRea = crSigOpOpe.RealPrevs
                    loc_pIds = SYS(2015)
                    IF crSigOpOpe.RealPrevs = 2
                        loc_llPrevs = .T.
                    ENDIF
                    loc_lcQuery = "INSERT INTO SigTempR (Dopes, ValPres, cIdQuerys, cIdChaves) " + ;
                                  "VALUES ('" + loc_pDop + "'," + ;
                                  TRANSFORM(loc_pRea) + ",'" + ALLTRIM(loc_pKey) + ;
                                  "','" + ALLTRIM(loc_pIds) + "')"
                    loc_lnResult = SQLEXEC(gnConnHandle, loc_lcQuery)
                    IF loc_lnResult < 1
                        THIS.this_cMensagemErro = "Falha ao inserir em SigTempR - " + loc_pDop
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF
            ENDSCAN

            *-- Par?metros de data para as queries
            loc_pDtI = "'" + STR(YEAR(loc_ldDtInicial), 4) + "-" + ;
                       PADL(STR(MONTH(loc_ldDtInicial), 2), 2, "0") + "-" + ;
                       PADL(STR(DAY(loc_ldDtInicial), 2), 2, "0") + "'"
            loc_pDtF = "'" + STR(YEAR(loc_ldDtFinal), 4) + "-" + ;
                       PADL(STR(MONTH(loc_ldDtFinal), 2), 2, "0") + "-" + ;
                       PADL(STR(DAY(loc_ldDtFinal), 2), 2, "0") + " 23:59:59'"

            *-- Buscar contas com movimentos (SigMvSlc) cruzando com disponibilidades
            IF !EMPTY(loc_lcMoeLanc)
                loc_lcQuery = "SELECT a.Grupos, a.Contas, a.Moedas, b.cContabs " + ;
                              "FROM SigMvSlc a INNER JOIN SigCdCli b ON b.iClis = a.Contas " + ;
                              "WHERE a.Moedas = '" + ALLTRIM(loc_lcMoeLanc) + "' " + ;
                              "ORDER BY a.Grupos, a.Contas, a.Moedas"
            ELSE
                loc_lcQuery = "SELECT a.Grupos, a.Contas, a.Moedas, b.cContabs " + ;
                              "FROM SigMvSlc a INNER JOIN SigCdCli b ON b.iClis = a.Contas " + ;
                              "ORDER BY a.Grupos, a.Contas, a.Moedas"
            ENDIF
            loc_lnResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigMvSlc")
            IF loc_lnResult < 1
                THIS.this_cMensagemErro = "Erro ao consultar SigMvSlc"
                loc_lSucesso = .F.
            ENDIF

            *-- Cursor tempor?rio: contas filtradas pelas disponibilidades selecionadas
            SELECT a.Grupos, a.Contas, 0.00 AS Saldos, a.Moedas, 1 AS Fase, cContabs, ;
                   a.Grupos + a.Contas + a.Moedas AS GruConMoes ;
              FROM crSigMvSlc a, cDisp b ;
             WHERE b.Grupos + b.Contas = a.Grupos + a.Contas ;
               AND b.ImpDisps ;
             ORDER BY a.Grupos, a.Contas ;
              INTO CURSOR csTemporario READWRITE
            IF USED("crSigMvSlc")
                USE IN crSigMvSlc
            ENDIF

            *-- Calcular saldo inicial de cada conta
            SELECT csTemporario
            GO TOP
            SCAN
                loc_lnSaldo  = 0
                loc_pGcm     = csTemporario.GruConMoes
                loc_dSaldoData = loc_ldDtInicial - IIF(loc_lnSaldos = 1, 1, 0)
                loc_pDat = "'" + STR(YEAR(loc_dSaldoData), 4) + "-" + ;
                           PADL(STR(MONTH(loc_dSaldoData), 2), 2, "0") + "-" + ;
                           PADL(STR(DAY(loc_dSaldoData), 2), 2, "0") + " 23:59:59'"
                IF !EMPTY(loc_lcMoeLanc)
                    loc_lcQuery = "SELECT TOP 1 Nfs, SaldoCs, Saldos, cIdChaves " + ;
                                  "FROM SigMvCcr " + ;
                                  "WHERE GruConMoes = '" + ALLTRIM(loc_pGcm) + "'" + ;
                                  " AND Moedas = '" + ALLTRIM(loc_lcMoeLanc) + "'" + ;
                                  " AND Datas <= " + loc_pDat + ;
                                  " ORDER BY GruConMoes ASC, cIdChaves DESC"
                ELSE
                    loc_lcQuery = "SELECT TOP 1 Nfs, SaldoCs, Saldos, cIdChaves " + ;
                                  "FROM SigMvCcr " + ;
                                  "WHERE GruConMoes = '" + ALLTRIM(loc_pGcm) + "'" + ;
                                  " AND Datas <= " + loc_pDat + ;
                                  " ORDER BY GruConMoes ASC, cIdChaves DESC"
                ENDIF
                loc_lnResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigMvCcr")
                IF loc_lnResult < 1
                    THIS.this_cMensagemErro = "Erro ao consultar SigMvCcr (saldo inicial)"
                    loc_lSucesso = .F.
                ENDIF
                SELECT crSigMvCcr
                GO TOP
                IF !EOF("crSigMvCcr") AND ;
                   IIF(loc_lnOpcao <> 3, ;
                       IIF(loc_lnOpcao = 1, !EMPTY(csTemporario.cContabs), ;
                           EMPTY(csTemporario.cContabs)), .T.)
                    loc_lnSaldo = IIF(loc_llConc, crSigMvCcr.Saldocs, crSigMvCcr.Saldos)
                    REPLACE Saldos WITH loc_lnSaldo IN csTemporario
                ENDIF
                IF USED("crSigMvCcr")
                    USE IN crSigMvCcr
                ENDIF
            ENDSCAN

            SELECT csTemporario
            DELETE FROM csTemporario WHERE Saldos = 0
            GO TOP

            *-- Acumular saldo total e popular csRelatorio com saldos iniciais
            loc_lnVlSaldoTotal = 0
            SELECT csTemporario
            GO TOP
            SCAN
                SCATTER MEMVAR
                INSERT INTO csRelatorio FROM MEMVAR
                loc_lnCtReferencia = THIS.BuscarCambio(csRelatorio.Moedas)
                loc_lnCtReferencia = IIF(loc_lnCtReferencia = 0, 1, loc_lnCtReferencia)
                loc_lnVlConvertido = (csRelatorio.Saldos * loc_lnCtReferencia / loc_lnVlCotacao)
                REPLACE vl_Convertido WITH loc_lnVlConvertido, ;
                        vl_Cotacao    WITH loc_lnVlCotacao IN csRelatorio
                loc_lnVlSaldoTotal = loc_lnVlSaldoTotal + loc_lnVlConvertido
            ENDSCAN
            IF USED("csTemporario")
                USE IN csTemporario
            ENDIF

            *-- Processamento de atrasos (t?tulos vencidos antes do per?odo)
            loc_lnTotAtrasos = 0
            IF loc_lnListaAtra = 1
                WAIT WINDOW "Processando Atrasos (1)..." NOWAIT
                *-- Atrasos de SigMvCcr (com opera??es de t?tulo vinculadas)
                loc_lcQuery = "SELECT a.Grupos, a.Emps, a.DopCs, a.Opers, " + ;
                              "a.Moedas, a.Valors, a.ValPags, a.Nfs " + ;
                              "FROM SigMvCcr a, SigTempR b " + ;
                              "WHERE a.Vencs < " + loc_pDtI + ;
                              IIF(!EMPTY(loc_lcMoeLanc), " AND a.Moedas = '" + ALLTRIM(loc_lcMoeLanc) + "'", "") + ;
                              " AND a.TitCancs <> 1" + ;
                              IIF(loc_lnNrPrev = 1, " AND b.ValPres = 2", ;
                                  IIF(loc_lnNrPrev = 2, " AND b.ValPres <> 2", "")) + ;
                              " AND (a.Valors - a.ValPags) > 0" + ;
                              " AND a.DopCs = b.Dopes AND b.CIdQuerys = '" + ALLTRIM(loc_pKey) + "'" + ;
                              " ORDER BY a.Emps, a.Grupos, a.Contas, a.Moedas, a.cIdChaves, a.Vencs, a.Dopcs"
                loc_lnResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigMvCcr")
                IF loc_lnResult < 1
                    THIS.this_cMensagemErro = "Erro ao consultar atrasos de SigMvCcr"
                    loc_lSucesso = .F.
                ENDIF
                SELECT csRelatorio
                APPEND BLANK
                SELECT crSigMvCcr
                SCAN
                    IF (SEEK(Emps, "cEmp", "CEmps") AND cEmp.ImpEmps) AND ;
                       (DopCs = SPACE(20) OR (SEEK(DopCs, "crSigOpOpe", "Dopes") AND crSigOpOpe.SeleOp)) AND ;
                       ((loc_lnOpcao = 1 AND !EMPTY(crSigMvCcr.Nfs)) OR ;
                        (loc_lnOpcao = 2 AND EMPTY(crSigMvCcr.Nfs)) OR ;
                        (loc_lnOpcao = 3))
                        IF !EMPTY(crSigMvCcr.Grupos) AND ;
                           SEEK(crSigMvCcr.Grupos, "crSigCdPag", "Grupos") AND ;
                           (crSigMvCcr.Opers = "C")
                            REPLACE Pags WITH Pags + (crSigMvCcr.Valors - crSigMvCcr.ValPags), ;
                                    Fase WITH 2 IN csRelatorio
                            loc_lnTotAtrasos = loc_lnTotAtrasos - (crSigMvCcr.Valors - crSigMvCcr.ValPags)
                        ENDIF
                        IF !EMPTY(crSigMvCcr.Grupos) AND ;
                           SEEK(crSigMvCcr.Grupos, "crSigCdRec", "Grupos") AND ;
                           (crSigMvCcr.Opers = "D")
                            REPLACE Recs WITH Recs + (crSigMvCcr.Valors - crSigMvCcr.ValPags), ;
                                    Fase WITH 2 IN csRelatorio
                            loc_lnTotAtrasos = loc_lnTotAtrasos + (crSigMvCcr.Valors - crSigMvCcr.ValPags)
                        ENDIF
                    ENDIF
                ENDSCAN
                IF USED("crSigMvCcr")
                    USE IN crSigMvCcr
                ENDIF

                *-- Atrasos de SigMvCab (opera??es previstas vencidas)
                WAIT WINDOW "Processando Atrasos (2)..." NOWAIT
                loc_lcQuery = "SELECT b.cMoes, c.MoedaPs, b.Opers, b.DigItens, " + ;
                              "a.Emps, a.Dopes, a.Numes, a.Valos, d.Valos AS VlParc, " + ;
                              "d.vpags, a.TpFats, a.ChkPagos, a.ValInis, a.Vars, e.nFlxCaixa " + ;
                              "FROM SigMvCab a " + ;
                              "INNER JOIN SigCdOpe b ON b.Dopes = a.Dopes " + ;
                              "INNER JOIN SigCdPam c ON 1 = 1 " + ;
                              "INNER JOIN SigMvPar d ON d.EmpDopNums = a.EmpDopNums " + ;
                              "INNER JOIN SigCdTom e ON e.Codigos = b.TipoOps " + ;
                              "LEFT JOIN SigOpFpo o ON o.Dopes = d.Dopes AND o.fPags = d.fPags " + ;
                              "WHERE d.Vencs < " + loc_pDtI + ;
                              " AND (o.Contabs <> 1)" + ;
                              " AND (e.nFlxCaixa <> 3 AND e.nFlxCaixa <> 0) AND a.ChkSubN = 0 " + ;
                              "ORDER BY a.Emps"
                loc_lnResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigMvCab")
                IF loc_lnResult < 1
                    THIS.this_cMensagemErro = "Erro ao consultar SigMvCab (atrasos)"
                    loc_lSucesso = .F.
                ENDIF
                SELECT crSigMvCab
                SCAN
                    IF (crSigMvCab.nFlxCaixa = 2) AND !crSigMvCab.ChkPagos
                        LOOP
                    ENDIF
                    LOCAL loc_sMoedas, loc_sOpers, loc_sValors, loc_sEmps
                    loc_sMoedas = IIF(!EMPTY(ALLTRIM(NVL(crSigMvCab.cMoes, ""))), ;
                        ALLTRIM(crSigMvCab.cMoes), ALLTRIM(crSigMvCab.MoedaPs))
                    IF !EMPTY(loc_lcMoeLanc) AND (loc_lcMoeLanc <> loc_sMoedas)
                        LOOP
                    ENDIF
                    loc_sOpers = IIF(crSigMvCab.Opers = 1, "C", "D")
                    IF crSigMvCab.DigItens <> 2
                        loc_sValors = ROUND((crSigMvCab.VlParc - crSigMvCab.VPags) * crSigMvCab.Vars, 2)
                    ELSE
                        loc_sValors = ROUND((crSigMvCab.VlParc - crSigMvCab.VPags), 2)
                    ENDIF
                    loc_sEmps = crSigMvCab.Emps
                    *-- Aplicar fator NF se necess?rio
                    loc_lnResult = SQLEXEC(gnConnHandle, ;
                        "SELECT TOP 1 pValors FROM SigCdTif WHERE Codigos = '" + ;
                        ALLTRIM(crSigMvCab.TpFats) + "'", "cursor_4c_Tif")
                    IF loc_lnResult > 0 AND !EOF("cursor_4c_Tif") AND (loc_lnOpcao <> 3)
                        IF loc_lnOpcao = 2
                            loc_sValors = ROUND(loc_sValors * (cursor_4c_Tif.pValors / 100), 2)
                        ELSE
                            loc_sValors = loc_sValors - ROUND(loc_sValors * (cursor_4c_Tif.pValors / 100), 2)
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_Tif")
                        USE IN cursor_4c_Tif
                    ENDIF
                    IF SEEK(loc_sEmps, "cEmp", "CEmps") AND cEmp.ImpEmps
                        REPLACE Pags WITH Pags + IIF(loc_sOpers = "C", loc_sValors, 0), ;
                                Recs WITH Recs + IIF(loc_sOpers = "D", loc_sValors, 0), ;
                                Fase WITH 2 IN csRelatorio
                        IF loc_sOpers = "C"
                            loc_lnTotAtrasos = loc_lnTotAtrasos - loc_sValors
                        ELSE
                            loc_lnTotAtrasos = loc_lnTotAtrasos + loc_sValors
                        ENDIF
                    ENDIF
                ENDSCAN
                IF USED("crSigMvCab")
                    USE IN crSigMvCab
                ENDIF
            ENDIF

            *-- Cursor para movimentos do per?odo
            CREATE CURSOR csTemporariox (Vencs d, Grupos c(10), Contas c(10), ;
                Opers c(1), Moedas c(3), Valors n(12,2), Tipo c(1))

            *-- Query 1: movimentos com opera??o de t?tulo vinculada
            WAIT WINDOW "Processando Hist" + CHR(243) + "rico - (Realizado)..." NOWAIT
            IF EMPTY(loc_ldDtInicial)
                loc_lcQuery = "SELECT a.Vencs, a.Emps, a.Dopcs, a.Grupos, a.Contas, " + ;
                              "a.Opers, a.Moedas, a.Valors, a.ValPags, a.Nfs, a.cIdChaves " + ;
                              "FROM SigMvCcr a, SigTempR b " + ;
                              "WHERE (a.Vencs <= " + loc_pDtF + " OR a.Vencs IS NULL)" + ;
                              IIF(!EMPTY(loc_lcMoeLanc), " AND a.Moedas = '" + ALLTRIM(loc_lcMoeLanc) + "'", "") + ;
                              " AND a.TitCancs <> 1" + ;
                              IIF(loc_lnNrPrev = 1, " AND b.ValPres = 2", ;
                                  IIF(loc_lnNrPrev = 2, " AND b.ValPres <> 2", "")) + ;
                              " AND a.DopCs = b.Dopes AND b.CIdQuerys = '" + ALLTRIM(loc_pKey) + "'" + ;
                              " ORDER BY a.Emps, a.Grupos, a.Contas, a.Moedas, a.cIdChaves, " + ;
                              "a.Vencs, a.Dopcs, a.Opers, a.Valors, a.ValPags, a.Nfs"
            ELSE
                loc_lcQuery = "SELECT a.Vencs, a.Emps, a.Dopcs, a.Grupos, a.Contas, " + ;
                              "a.Opers, a.Moedas, a.Valors, a.ValPags, a.Nfs, a.cIdChaves " + ;
                              "FROM SigMvCcr a, SigTempR b " + ;
                              "WHERE a.Vencs BETWEEN " + loc_pDtI + " AND " + loc_pDtF + ;
                              IIF(!EMPTY(loc_lcMoeLanc), " AND a.Moedas = '" + ALLTRIM(loc_lcMoeLanc) + "'", "") + ;
                              " AND a.TitCancs <> 1" + ;
                              IIF(loc_lnNrPrev = 1, " AND b.ValPres = 2", ;
                                  IIF(loc_lnNrPrev = 2, " AND b.ValPres <> 2", "")) + ;
                              " AND a.DopCs = b.Dopes AND b.CIdQuerys = '" + ALLTRIM(loc_pKey) + "'" + ;
                              " ORDER BY a.Emps, a.Grupos, a.Contas, a.Moedas, a.cIdChaves, " + ;
                              "a.Vencs, a.Dopcs, a.Opers, a.Valors, a.ValPags, a.Nfs"
            ENDIF
            loc_lnResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crDados1")
            IF loc_lnResult < 1
                THIS.this_cMensagemErro = "Erro ao consultar SigMvCcr (realizado - com ope)"
                loc_lSucesso = .F.
            ENDIF

            *-- Query 2: movimentos sem opera??o de t?tulo (DopCs = espacos)
            IF EMPTY(loc_ldDtInicial)
                loc_lcQuery = "SELECT a.Vencs, a.Emps, a.Dopcs, a.Grupos, a.Contas, " + ;
                              "a.Opers, a.Moedas, a.Valors, a.ValPags, a.Nfs, a.cIdChaves " + ;
                              "FROM SigMvCcr a " + ;
                              "WHERE (a.Vencs <= " + loc_pDtF + " OR a.Vencs IS NULL)" + ;
                              IIF(!EMPTY(loc_lcMoeLanc), " AND a.Moedas = '" + ALLTRIM(loc_lcMoeLanc) + "'", "") + ;
                              " AND a.TitCancs <> 1 AND a.DopCs = '" + SPACE(20) + "'" + ;
                              " ORDER BY a.Emps, a.Grupos, a.Contas, a.Moedas, a.cIdChaves, " + ;
                              "a.Vencs, a.Dopcs, a.Opers, a.Valors, a.ValPags, a.Nfs"
            ELSE
                loc_lcQuery = "SELECT a.Vencs, a.Emps, a.Dopcs, a.Grupos, a.Contas, " + ;
                              "a.Opers, a.Moedas, a.Valors, a.ValPags, a.Nfs, a.cIdChaves " + ;
                              "FROM SigMvCcr a " + ;
                              "WHERE a.Vencs BETWEEN " + loc_pDtI + " AND " + loc_pDtF + ;
                              IIF(!EMPTY(loc_lcMoeLanc), " AND a.Moedas = '" + ALLTRIM(loc_lcMoeLanc) + "'", "") + ;
                              " AND a.TitCancs <> 1 AND a.DopCs = '" + SPACE(20) + "'" + ;
                              " ORDER BY a.Emps, a.Grupos, a.Contas, a.Moedas, a.cIdChaves, " + ;
                              "a.Vencs, a.Dopcs, a.Opers, a.Valors, a.ValPags, a.Nfs"
            ENDIF
            loc_lnResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crDados2")
            IF loc_lnResult < 1
                THIS.this_cMensagemErro = "Erro ao consultar SigMvCcr (realizado - sem ope)"
                loc_lSucesso = .F.
            ENDIF

            SELECT * FROM crDados1 ;
            UNION ALL ;
            SELECT * FROM crDados2 ;
            INTO CURSOR crSigMvCcr
            IF USED("crDados1")
                USE IN crDados1
            ENDIF
            IF USED("crDados2")
                USE IN crDados2
            ENDIF

            *-- Processar hist?rico realizado
            SELECT crSigMvCcr
            SCAN
                IF (SEEK(Emps, "cEmp", "CEmps") AND cEmp.ImpEmps) AND ;
                   (DopCs = SPACE(20) OR (SEEK(DopCs, "crSigOpOpe", "Dopes") AND crSigOpOpe.SeleOp)) AND ;
                   ((loc_lnOpcao = 1 AND !EMPTY(crSigMvCcr.Nfs)) OR ;
                    (loc_lnOpcao = 2 AND EMPTY(crSigMvCcr.Nfs)) OR ;
                    (loc_lnOpcao = 3))
                    LOCAL loc_lnValorR, loc_lcTipoR
                    loc_lnValorR = crSigMvCcr.Valors
                    IF loc_lnNrSitua <> 3
                        loc_lnValorR = IIF(loc_lnNrSitua = 1, crSigMvCcr.ValPags, ;
                            (crSigMvCcr.Valors - crSigMvCcr.ValPags))
                    ENDIF
                    loc_lcTipoR = IIF(DopCs = SPACE(20) OR crSigOpOpe.RealPrevs <> 2, "", "T")
                    INSERT INTO csTemporariox (Vencs, Grupos, Contas, Opers, Moedas, Valors, Tipo) ;
                        VALUES (crSigMvCcr.Vencs, crSigMvCcr.Grupos, crSigMvCcr.Contas, ;
                                crSigMvCcr.Opers, crSigMvCcr.Moedas, loc_lnValorR, loc_lcTipoR)
                ENDIF
            ENDSCAN
            IF USED("crSigMvCcr")
                USE IN crSigMvCcr
            ENDIF

            *-- Processar previs?es de SigMvCab (opera??es previstas no per?odo)
            WAIT WINDOW "Processando Hist" + CHR(243) + "rico - (Previsto)..." NOWAIT
            IF EMPTY(loc_ldDtInicial)
                loc_lcQuery = "SELECT b.cMoes, c.MoedaPs, d.Vencs, b.Opers, b.DigItens, " + ;
                              "a.grupoos, a.contaos, a.grupods, a.contads, a.Dopes, " + ;
                              "a.Valos, d.Valos AS VlParc, d.vpags, a.Emps, " + ;
                              "a.TpFats, a.ChkPagos, a.ValInis, a.Vars, e.nFlxCaixa " + ;
                              "FROM SigMvCab a INNER JOIN SigCdOpe b ON b.Dopes = a.Dopes " + ;
                              "INNER JOIN SigCdPam c ON 1 = 1 " + ;
                              "INNER JOIN SigMvPar d ON d.EmpDopNums = a.EmpDopNums " + ;
                              "INNER JOIN SigCdTom e ON e.Codigos = b.TipoOps " + ;
                              "LEFT JOIN SigOpFpo o ON o.Dopes = d.Dopes AND o.fPags = d.fPags " + ;
                              "WHERE (d.Vencs <= " + loc_pDtF + " OR d.Vencs IS NULL)" + ;
                              " AND (o.Contabs <> 1)" + ;
                              " AND (e.nFlxCaixa <> 3 AND e.nFlxCaixa <> 0) AND a.ChkSubN = 0 " + ;
                              "ORDER BY a.Emps"
            ELSE
                loc_lcQuery = "SELECT b.cMoes, c.MoedaPs, d.Vencs, b.Opers, b.DigItens, " + ;
                              "a.grupoos, a.contaos, a.grupods, a.contads, a.Dopes, " + ;
                              "a.Valos, d.Valos AS VlParc, d.vpags, a.Emps, " + ;
                              "a.TpFats, a.ChkPagos, a.ValInis, a.Vars, e.nFlxCaixa " + ;
                              "FROM SigMvCab a INNER JOIN SigCdOpe b ON b.Dopes = a.Dopes " + ;
                              "INNER JOIN SigCdPam c ON 1 = 1 " + ;
                              "INNER JOIN SigMvPar d ON d.EmpDopNums = a.EmpDopNums " + ;
                              "INNER JOIN SigCdTom e ON e.Codigos = b.TipoOps " + ;
                              "LEFT JOIN SigOpFpo o ON o.Dopes = d.Dopes AND o.fPags = d.fPags " + ;
                              "WHERE d.Vencs BETWEEN " + loc_pDtI + " AND " + loc_pDtF + ;
                              " AND (o.Contabs <> 1)" + ;
                              " AND (e.nFlxCaixa <> 3 AND e.nFlxCaixa <> 0) AND a.ChkSubN = 0 " + ;
                              "ORDER BY a.Emps"
            ENDIF
            loc_lnResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigMvCab")
            IF loc_lnResult < 1
                THIS.this_cMensagemErro = "Erro ao consultar SigMvCab (previsto)"
                loc_lSucesso = .F.
            ENDIF
            SELECT crSigMvCab
            SCAN
                IF (crSigMvCab.nFlxCaixa = 2) AND !crSigMvCab.ChkPagos
                    LOOP
                ENDIF
                LOCAL loc_pMoedas, loc_pVencs, loc_pOpers, loc_pGrupos, loc_pContas
                LOCAL loc_pValors, loc_pEmps
                loc_pMoedas = IIF(!EMPTY(ALLTRIM(NVL(crSigMvCab.cMoes, ""))), ;
                    ALLTRIM(crSigMvCab.cMoes), ALLTRIM(crSigMvCab.MoedaPs))
                IF !EMPTY(loc_lcMoeLanc) AND (loc_lcMoeLanc <> loc_pMoedas)
                    LOOP
                ENDIF
                loc_pVencs  = crSigMvCab.Vencs
                loc_pOpers  = IIF(crSigMvCab.Opers = 1, "C", "D")
                loc_pGrupos = IIF(crSigMvCab.Opers = 1, crSigMvCab.Grupoos, crSigMvCab.Grupods)
                loc_pContas = IIF(crSigMvCab.Opers = 1, crSigMvCab.Contaos, crSigMvCab.Contads)
                IF crSigMvCab.DigItens <> 2
                    loc_pValors = crSigMvCab.VlParc
                    IF loc_lnNrSitua <> 3
                        loc_pValors = IIF(loc_lnNrSitua = 1, ;
                            ROUND(crSigMvCab.VPags * crSigMvCab.Vars, 2), ;
                            ROUND((crSigMvCab.VlParc - crSigMvCab.VPags) * crSigMvCab.Vars, 2))
                    ENDIF
                ELSE
                    loc_pValors = crSigMvCab.VlParc
                    IF loc_lnNrSitua <> 3
                        loc_pValors = IIF(loc_lnNrSitua = 1, crSigMvCab.VPags, ;
                            ROUND((crSigMvCab.VlParc - crSigMvCab.VPags), 2))
                    ENDIF
                ENDIF
                loc_pEmps = crSigMvCab.Emps
                *-- Fator NF
                loc_lnResult = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 pValors FROM SigCdTif WHERE Codigos = '" + ;
                    ALLTRIM(crSigMvCab.TpFats) + "'", "cursor_4c_Tif2")
                IF loc_lnResult > 0 AND !EOF("cursor_4c_Tif2") AND (loc_lnOpcao <> 3)
                    IF loc_lnOpcao = 2
                        loc_pValors = ROUND(loc_pValors * (cursor_4c_Tif2.pValors / 100), 2)
                    ELSE
                        loc_pValors = loc_pValors - ROUND(loc_pValors * (cursor_4c_Tif2.pValors / 100), 2)
                    ENDIF
                ENDIF
                IF USED("cursor_4c_Tif2")
                    USE IN cursor_4c_Tif2
                ENDIF
                IF SEEK(loc_pEmps, "cEmp", "CEmps") AND cEmp.ImpEmps AND (loc_pValors > 0)
                    INSERT INTO csTemporariox (Vencs, Grupos, Contas, Opers, Moedas, Valors, Tipo) ;
                        VALUES (loc_pVencs, loc_pGrupos, loc_pContas, loc_pOpers, ;
                                loc_pMoedas, loc_pValors, "P")
                ENDIF
            ENDSCAN
            IF USED("crSigMvCab")
                USE IN crSigMvCab
            ENDIF

            *-- Processar previs?es de SigMvCpv (se houver opera??es com RealPrevs=2)
            IF loc_llPrevs
                WAIT WINDOW "Processando Hist" + CHR(243) + "rico - (Previsto CPV)..." NOWAIT
                IF EMPTY(loc_ldDtInicial)
                    loc_lcQuery = "SELECT a.Vencs, a.Emps, a.Dopcs, a.Grupos, a.Contas, " + ;
                                  "a.Opers, a.Moedas, a.Valors, a.ValPags, a.Nfs, a.cIdChaves " + ;
                                  "FROM SigMvCpv a, SigTempR b " + ;
                                  "WHERE (a.Vencs <= " + loc_pDtF + " OR a.Vencs IS NULL)" + ;
                                  IIF(!EMPTY(loc_lcMoeLanc), " AND a.Moedas = '" + ALLTRIM(loc_lcMoeLanc) + "'", "") + ;
                                  " AND a.DopCs = b.Dopes AND b.ValPres = 2" + ;
                                  " AND b.CIdQuerys = '" + ALLTRIM(loc_pKey) + "'" + ;
                                  " ORDER BY a.Emps, a.Grupos, a.Contas, a.Moedas, a.cIdChaves, " + ;
                                  "a.Dopcs, a.Opers, a.Valors, a.ValPags, a.Nfs"
                ELSE
                    loc_lcQuery = "SELECT a.Vencs, a.Emps, a.Dopcs, a.Grupos, a.Contas, " + ;
                                  "a.Opers, a.Moedas, a.Valors, a.ValPags, a.Nfs, a.cIdChaves " + ;
                                  "FROM SigMvCpv a, SigTempR b " + ;
                                  "WHERE a.Vencs BETWEEN " + loc_pDtI + " AND " + loc_pDtF + ;
                                  IIF(!EMPTY(loc_lcMoeLanc), " AND a.Moedas = '" + ALLTRIM(loc_lcMoeLanc) + "'", "") + ;
                                  " AND a.DopCs = b.Dopes AND b.ValPres = 2" + ;
                                  " AND b.CIdQuerys = '" + ALLTRIM(loc_pKey) + "'" + ;
                                  " ORDER BY a.Emps, a.Grupos, a.Contas, a.Moedas, a.cIdChaves, " + ;
                                  "a.Dopcs, a.Opers, a.Valors, a.ValPags, a.Nfs"
                ENDIF
                loc_lnResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crDados1")
                IF loc_lnResult < 1
                    THIS.this_cMensagemErro = "Erro ao consultar SigMvCpv (1)"
                    loc_lSucesso = .F.
                ENDIF
                IF EMPTY(loc_ldDtInicial)
                    loc_lcQuery = "SELECT a.Vencs, a.Emps, a.Dopcs, a.Grupos, a.Contas, " + ;
                                  "a.Opers, a.Moedas, a.Valors, a.ValPags, a.Nfs, a.cIdChaves " + ;
                                  "FROM SigMvCpv a " + ;
                                  "WHERE (a.Vencs <= " + loc_pDtF + " OR a.Vencs IS NULL)" + ;
                                  IIF(!EMPTY(loc_lcMoeLanc), " AND a.Moedas = '" + ALLTRIM(loc_lcMoeLanc) + "'", "") + ;
                                  " AND a.DopCs = '" + SPACE(20) + "'" + ;
                                  " ORDER BY a.Emps, a.Grupos, a.Contas, a.Moedas, a.cIdChaves, " + ;
                                  "a.Dopcs, a.Opers, a.Valors, a.ValPags, a.Nfs"
                ELSE
                    loc_lcQuery = "SELECT a.Vencs, a.Emps, a.Dopcs, a.Grupos, a.Contas, " + ;
                                  "a.Opers, a.Moedas, a.Valors, a.ValPags, a.Nfs, a.cIdChaves " + ;
                                  "FROM SigMvCpv a " + ;
                                  "WHERE a.Vencs BETWEEN " + loc_pDtI + " AND " + loc_pDtF + ;
                                  IIF(!EMPTY(loc_lcMoeLanc), " AND a.Moedas = '" + ALLTRIM(loc_lcMoeLanc) + "'", "") + ;
                                  " AND a.DopCs = '" + SPACE(20) + "'" + ;
                                  " ORDER BY a.Emps, a.Grupos, a.Contas, a.Moedas, a.cIdChaves, " + ;
                                  "a.Dopcs, a.Opers, a.Valors, a.ValPags, a.Nfs"
                ENDIF
                loc_lnResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crDados2")
                IF loc_lnResult < 1
                    THIS.this_cMensagemErro = "Erro ao consultar SigMvCpv (2)"
                    loc_lSucesso = .F.
                ENDIF
                SELECT * FROM crDados1 ;
                UNION ALL ;
                SELECT * FROM crDados2 ;
                INTO CURSOR crSigMvCpv
                IF USED("crDados1")
                    USE IN crDados1
                ENDIF
                IF USED("crDados2")
                    USE IN crDados2
                ENDIF
                SELECT crSigMvCpv
                SCAN
                    IF (SEEK(Emps, "cEmp", "CEmps") AND cEmp.ImpEmps) AND ;
                       (DopCs = SPACE(20) OR (SEEK(DopCs, "crSigOpOpe", "Dopes") AND crSigOpOpe.SeleOp)) AND ;
                       ((loc_lnOpcao = 1 AND !EMPTY(crSigMvCpv.Nfs)) OR ;
                        (loc_lnOpcao = 2 AND EMPTY(crSigMvCpv.Nfs)) OR ;
                        (loc_lnOpcao = 3))
                        LOCAL loc_lnValorPV, loc_lcTipoPV
                        loc_lnValorPV = crSigMvCpv.Valors
                        IF loc_lnNrSitua <> 3
                            loc_lnValorPV = IIF(loc_lnNrSitua = 1, crSigMvCpv.ValPags, ;
                                (crSigMvCpv.Valors - crSigMvCpv.ValPags))
                        ENDIF
                        loc_lcTipoPV = IIF(DopCs = SPACE(20) OR crSigOpOpe.RealPrevs <> 2, "", "T")
                        INSERT INTO csTemporariox (Vencs, Grupos, Contas, Opers, Moedas, Valors, Tipo) ;
                            VALUES (crSigMvCpv.Vencs, crSigMvCpv.Grupos, crSigMvCpv.Contas, ;
                                    crSigMvCpv.Opers, crSigMvCpv.Moedas, ;
                                    crSigMvCpv.Valors - crSigMvCpv.ValPags, loc_lcTipoPV)
                    ENDIF
                ENDSCAN
                IF USED("crSigMvCpv")
                    USE IN crSigMvCpv
                ENDIF
            ENDIF

            *-- Acumular hist?rico por per?odo
            WAIT WINDOW "Acumulando Hist" + CHR(243) + "rico..." NOWAIT

            IF !loc_llImprime
                *-- Modo: Di?rio / Semanal / Quinzenal / Mensal
                SELECT Vencs, Grupos, Opers, Moedas, Tipo, SUM(Valors) AS Valors ;
                  FROM csTemporariox ;
                 GROUP BY Vencs, Grupos, Opers, Moedas, Tipo ;
                  INTO CURSOR csTemporario
                SELECT csTemporario
                GO TOP
                GO TOP IN crPeriodos
                loc_ldVencimento   = IIF(loc_lnTipoImp = 1, DTOC(csTemporario.Vencs), ;
                                         SUBSTR(DTOC(csTemporario.Vencs), 4, 7))
                IF loc_lnTipoImp = 2 OR loc_lnTipoImp = 3
                    loc_ldVencimento = DTOC(crPeriodos.dFinal)
                ENDIF
                loc_lnPagamentos   = 0
                loc_lnRecebimentos = 0
                loc_lnDoDia        = 0
                loc_lnAcumulado    = IIF(loc_lnConsAtra = 1, loc_lnTotAtrasos, 0)
                loc_lnSaldo        = loc_lnVlSaldoTotal + IIF(loc_lnConsAtra = 1, loc_lnTotAtrasos, 0)
                loc_lnPrevPag      = 0
                loc_lnPrevRec      = 0
                SCAN
                    IF IIF(loc_lnTipoImp <> 2 AND loc_lnTipoImp <> 3, ;
                        (loc_ldVencimento <> IIF(loc_lnTipoImp = 1, DTOC(csTemporario.Vencs), ;
                            SUBSTR(DTOC(csTemporario.Vencs), 4, 7))), ;
                        csTemporario.Vencs > crPeriodos.dFinal)
                        loc_lnDoDia     = (loc_lnRecebimentos - loc_lnPagamentos) + (loc_lnPrevRec - loc_lnPrevPag)
                        loc_lnAcumulado = loc_lnAcumulado + loc_lnDoDia
                        loc_lnSaldo     = loc_lnSaldo + loc_lnDoDia
                        INSERT INTO csRelatorio (Vencs, Pags, Recs, do_Dia, Acumulado, Saldo, Fase, PrevPags, PrevRecs) ;
                            VALUES (loc_ldVencimento, loc_lnPagamentos, loc_lnRecebimentos, ;
                                    loc_lnDoDia, loc_lnAcumulado, loc_lnSaldo, 2, loc_lnPrevPag, loc_lnPrevRec)
                        loc_ldVencimento = IIF(loc_lnTipoImp = 1, DTOC(csTemporario.Vencs), ;
                            SUBSTR(DTOC(csTemporario.Vencs), 4, 7))
                        IF !EOF("crPeriodos")
                            SKIP +1 IN crPeriodos
                        ENDIF
                        IF loc_lnTipoImp = 2 OR loc_lnTipoImp = 3
                            loc_ldVencimento = DTOC(crPeriodos.dFinal)
                        ENDIF
                        loc_lnPagamentos   = 0
                        loc_lnRecebimentos = 0
                        loc_lnPrevPag      = 0
                        loc_lnPrevRec      = 0
                    ENDIF
                    loc_lnCtReferencia = THIS.BuscarCambio(csTemporario.Moedas)
                    loc_lnCtReferencia = IIF(loc_lnCtReferencia = 0, 1, loc_lnCtReferencia)
                    loc_lnVlConvertido = (csTemporario.Valors * loc_lnCtReferencia / loc_lnVlCotacao)
                    IF !INLIST(csTemporario.Tipo, "P", "T")
                        IF !EMPTY(csTemporario.Grupos) AND ;
                           SEEK(csTemporario.Grupos, "crSigCdPag", "Grupos") AND ;
                           (csTemporario.Opers = "C") AND (crSigCdPag.RelPrevs <> 2)
                            loc_lnPagamentos = loc_lnPagamentos + loc_lnVlConvertido
                        ENDIF
                        IF !EMPTY(csTemporario.Grupos) AND ;
                           SEEK(csTemporario.Grupos, "crSigCdRec", "Grupos") AND ;
                           (csTemporario.Opers = "D")
                            loc_lnRecebimentos = loc_lnRecebimentos + loc_lnVlConvertido
                        ENDIF
                    ELSE
                        IF (csTemporario.Opers = "C") AND ;
                           !EMPTY(csTemporario.Grupos) AND ;
                           SEEK(csTemporario.Grupos, "crSigCdPag", "Grupos")
                            loc_lnPrevPag = loc_lnPrevPag + loc_lnVlConvertido
                        ELSE
                            IF !EMPTY(csTemporario.Grupos) AND ;
                               SEEK(csTemporario.Grupos, "crSigCdRec", "Grupos") AND ;
                               (csTemporario.Opers = "D")
                                loc_lnPrevRec = loc_lnPrevRec + loc_lnVlConvertido
                            ENDIF
                        ENDIF
                    ENDIF
                ENDSCAN
                *-- ?ltimo per?odo
                loc_lnDoDia     = (loc_lnRecebimentos - loc_lnPagamentos) + (loc_lnPrevRec - loc_lnPrevPag)
                loc_lnAcumulado = loc_lnAcumulado + loc_lnDoDia
                loc_lnSaldo     = loc_lnSaldo + loc_lnDoDia
                IF (!EMPTY(loc_lnAcumulado) OR !EMPTY(loc_lnSaldo))
                    INSERT INTO csRelatorio (Vencs, Pags, Recs, do_Dia, Acumulado, Saldo, Fase, PrevPags, PrevRecs) ;
                        VALUES (loc_ldVencimento, loc_lnPagamentos, loc_lnRecebimentos, ;
                                loc_lnDoDia, loc_lnAcumulado, loc_lnSaldo, 2, loc_lnPrevPag, loc_lnPrevRec)
                ENDIF
                IF USED("csTemporario")
                    USE IN csTemporario
                ENDIF

                *-- Construir tabela pivot semanal/quinzenal (crRel)
                IF loc_lnTipoImp = 2 OR loc_lnTipoImp = 3
                    loc_lcCursor = [CREATE CURSOR crRel( Tipo c(10), ]
                    FOR loc_i = 1 TO 8
                        loc_lcCursor = loc_lcCursor + ;
                            [dData] + ALLTRIM(STR(loc_i)) + [ c(10),] + ;
                            [nSaldoIni] + ALLTRIM(STR(loc_i)) + [ n(12,2),] + ;
                            [nRecEst] + ALLTRIM(STR(loc_i)) + [ n(12,2),] + ;
                            [nRecConf] + ALLTRIM(STR(loc_i)) + [ n(12,2),] + ;
                            [nPagEst] + ALLTRIM(STR(loc_i)) + [ n(12,2),] + ;
                            [nPagConf] + ALLTRIM(STR(loc_i)) + [ n(12,2),] + ;
                            [nSaldoFin] + ALLTRIM(STR(loc_i)) + [ n(12,2)] + ;
                            IIF(loc_i <> 8, [,], [)])
                    NEXT loc_i
                    &loc_lcCursor
                    loc_lnIdx = 1
                    SELECT * FROM csRelatorio WHERE Fase = 2 AND !EMPTY(Vencs) INTO CURSOR crAux
                    SELECT crAux
                    APPEND BLANK IN crRel
                    REPLACE Tipo WITH IIF(loc_lnTipoImp = 2, "Semana", "Quinzena") IN crRel
                    GO TOP IN crAux
                    SCAN
                        LOCAL loc_lcFld
                        loc_lcFld = ALLTRIM(STR(loc_lnIdx))
                        REPLACE ("dData"     + loc_lcFld) WITH crAux.Vencs, ;
                                ("nSaldoIni" + loc_lcFld) WITH (crAux.Saldo - crAux.do_Dia), ;
                                ("nRecEst"   + loc_lcFld) WITH crAux.PrevRecs, ;
                                ("nRecConf"  + loc_lcFld) WITH crAux.Recs, ;
                                ("nPagEst"   + loc_lcFld) WITH crAux.PrevPags, ;
                                ("nPagConf"  + loc_lcFld) WITH crAux.Pags, ;
                                ("nSaldoFin" + loc_lcFld) WITH crAux.Saldo IN crRel
                        loc_lnIdx = loc_lnIdx + 1
                    ENDSCAN
                    IF USED("crAux")
                        USE IN crAux
                    ENDIF
                ENDIF
            ELSE
                *-- Modo: Totaliza Contas (llImprime = .T.)
                SELECT Vencs, MAX(Grupos) AS Grupos, Contas, Opers, Moedas, SUM(Valors) AS Valors ;
                  FROM csTemporariox ;
                 GROUP BY 1, 3, 4, 5 ;
                  INTO CURSOR csTemporario
                SELECT MAX(Vencs) AS Vencs, Grupos, Contas, Opers, MAX(Moedas) AS Moedas, SUM(Valors) AS Valors ;
                  FROM csTemporario ;
                 GROUP BY 2, 3, 4 ;
                 ORDER BY 3 ;
                  INTO CURSOR csTemporarioAcc
                IF USED("csTemporario")
                    USE IN csTemporario
                ENDIF
                loc_lnSaldo = loc_lnVlSaldoTotal
                SELECT csTemporarioAcc
                SCAN
                    loc_lnPagamentos   = 0
                    loc_lnRecebimentos = 0
                    loc_lnCtReferencia = THIS.BuscarCambio(csTemporarioAcc.Moedas)
                    loc_lnCtReferencia = IIF(loc_lnCtReferencia = 0, 1, loc_lnCtReferencia)
                    loc_lnVlConvertido = (csTemporarioAcc.Valors * loc_lnCtReferencia / loc_lnVlCotacao)
                    *-- Buscar descri??o do cliente
                    LOCAL loc_lcRClis
                    loc_lcRClis = ""
                    loc_lnResult = SQLEXEC(gnConnHandle, ;
                        "SELECT TOP 1 RClis FROM SigCdCli WHERE iClis = " + ;
                        TRANSFORM(csTemporarioAcc.Contas), "cursor_4c_CliQ")
                    IF loc_lnResult > 0 AND !EOF("cursor_4c_CliQ")
                        loc_lcRClis = ALLTRIM(cursor_4c_CliQ.RClis)
                    ENDIF
                    IF USED("cursor_4c_CliQ")
                        USE IN cursor_4c_CliQ
                    ENDIF
                    IF !EMPTY(csTemporarioAcc.Grupos) AND ;
                       SEEK(csTemporarioAcc.Grupos, "crSigCdPag", "Grupos") AND ;
                       (csTemporarioAcc.Opers = "C") AND (crSigCdPag.RelPrevs <> 2)
                        loc_lnPagamentos = loc_lnVlConvertido
                    ENDIF
                    IF !EMPTY(csTemporarioAcc.Grupos) AND ;
                       SEEK(csTemporarioAcc.Grupos, "crSigCdRec", "Grupos") AND ;
                       (csTemporarioAcc.Opers = "D")
                        loc_lnRecebimentos = loc_lnVlConvertido
                    ENDIF
                    loc_lnSaldo = loc_lnSaldo + (loc_lnRecebimentos - loc_lnPagamentos)
                    INSERT INTO csRelatorio (Contas, Pags, Recs, Saldo, Fase, DsContas) ;
                        VALUES (csTemporarioAcc.Contas, loc_lnPagamentos, loc_lnRecebimentos, ;
                                loc_lnSaldo, 2, loc_lcRClis)
                ENDSCAN
                IF USED("csTemporarioAcc")
                    USE IN csTemporarioAcc
                ENDIF
            ENDIF

            IF USED("csTemporariox")
                USE IN csTemporariox
            ENDIF

            *-- Posicionar cursor de resultado para o relat?rio
            IF loc_lnTipoImp = 2 OR loc_lnTipoImp = 3
                SELECT crRel
            ELSE
                SELECT csRelatorio
                SET ORDER TO Fase
            ENDIF
            GO TOP

            *-- Limpeza em SigTempR
            THIS.LimparSigTempR(loc_pKey)
            WAIT CLEAR

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro em PrepararDados")
            *-- Tentar limpar SigTempR mesmo com erro
            IF !EMPTY(THIS.this_cChaveQuery)
                THIS.LimparSigTempR(THIS.this_cChaveQuery)
            ENDIF
            WAIT CLEAR
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarCambio - Retorna taxa de cambio de uma moeda na data atual
    * Substitui fBuscarCambio() do legado
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION BuscarCambio(par_cMoeda)
        LOCAL loc_nCotacao, loc_lnResult
        loc_nCotacao = 1
        IF EMPTY(ALLTRIM(par_cMoeda))
            RETURN loc_nCotacao
        ENDIF
        TRY
            *-- Tenta buscar no cursor crSigCdCot (carregado pelo InicializarCursoresAuxiliares)
            IF USED("crSigCdCot") AND ;
               SEEK(ALLTRIM(par_cMoeda) + DTOS(DATE()), "crSigCdCot", "CMoeData")
                IF crSigCdCot.Valos > 0
                    loc_nCotacao = crSigCdCot.Valos
                ENDIF
            ELSE
                *-- Fallback: cota??o padr?o em SigCdMoe
                IF USED("crSigCdMoe") AND SEEK(ALLTRIM(par_cMoeda), "crSigCdMoe", "CMoes")
                    IF crSigCdMoe.Cotas > 0
                        loc_nCotacao = crSigCdMoe.Cotas
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            *-- Ignorar: retorna 1 (neutro)
        ENDTRY
        RETURN loc_nCotacao
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarCotacaoAtual - Retorna cota??o atual de uma moeda (para inicializa??o do form)
    * Substitui fBuscarCotacao() do legado
    *--------------------------------------------------------------------------
    FUNCTION BuscarCotacaoAtual(par_cMoeda)
        LOCAL loc_nCotacao, loc_lnResult
        loc_nCotacao = 1
        IF EMPTY(ALLTRIM(par_cMoeda))
            RETURN loc_nCotacao
        ENDIF
        TRY
            *-- Tenta buscar no cursor crSigCdCot (carregado pelo InicializarCursoresAuxiliares)
            IF USED("crSigCdCot") AND ;
               SEEK(ALLTRIM(par_cMoeda) + DTOS(DATE()), "crSigCdCot", "CMoeData")
                IF crSigCdCot.Valos > 0
                    loc_nCotacao = crSigCdCot.Valos
                ENDIF
            ELSE
                *-- Fallback: cota??o padr?o em SigCdMoe
                IF USED("crSigCdMoe") AND SEEK(ALLTRIM(par_cMoeda), "crSigCdMoe", "CMoes")
                    IF crSigCdMoe.Cotas > 0
                        loc_nCotacao = crSigCdMoe.Cotas
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            *-- Ignorar: retorna 1
        ENDTRY
        RETURN loc_nCotacao
    ENDFUNC

    *--------------------------------------------------------------------------
    * GoDayOfWeek - Retorna data ajustada para o dia-da-semana especificado
    * Equivalente a GoDayOfWeek() do legado (metodo do form original)
    * par_nDia: 1=Dom 2=Seg 3=Ter 4=Qua 5=Qui 6=Sex 7=Sab
    *--------------------------------------------------------------------------
    FUNCTION GoDayOfWeek(par_dData, par_nDia)
        LOCAL loc_dRet
        loc_dRet = par_dData
        IF DOW(loc_dRet) <> par_nDia
            IF DOW(par_dData) < par_nDia
                DO WHILE DOW(loc_dRet) < par_nDia
                    loc_dRet = loc_dRet + 1
                ENDDO
            ELSE
                DO WHILE DOW(loc_dRet) > par_nDia
                    loc_dRet = loc_dRet - 1
                ENDDO
            ENDIF
        ENDIF
        RETURN loc_dRet
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimparSigTempR - Remove registros de query da tabela SigTempR
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparSigTempR(par_cChave)
        LOCAL loc_lnResult
        TRY
            IF !EMPTY(ALLTRIM(par_cChave))
                loc_lnResult = SQLEXEC(gnConnHandle, ;
                    "DELETE FROM SigTempR WHERE cIdQuerys = '" + ALLTRIM(par_cChave) + "'")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao limpar SigTempR")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterCaminhoFRX - Retorna caminho do FRX conforme op??es do relat?rio
    *--------------------------------------------------------------------------
    PROCEDURE ObterCaminhoFRX()
        LOCAL loc_cPath
        IF THIS.this_nTotalizaContas = 1
            loc_cPath = gc_4c_CaminhoReports + "SigReFf3.frx"
        ELSE
            IF THIS.this_nTipoImp = 2 OR THIS.this_nTipoImp = 3
                loc_cPath = gc_4c_CaminhoReports + "SigReFf1.frx"
            ELSE
                loc_cPath = gc_4c_CaminhoReports + "SigReFf2.frx"
            ENDIF
        ENDIF
        RETURN loc_cPath
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nTotalizaContas = 1
                    IF USED("csRelatorio")
                        SELECT csRelatorio
                        GO TOP
                    ENDIF
                ELSE
                    IF (THIS.this_nTipoImp = 2 OR THIS.this_nTipoImp = 3) AND USED("crRel")
                        SELECT crRel
                        GO TOP
                    ELSE
                        IF USED("csRelatorio")
                        SELECT csRelatorio
                        GO TOP
                        ENDIF
                    ENDIF
                ENDIF
                REPORT FORM (THIS.ObterCaminhoFRX()) PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffnBO.Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia para impressora com dialogo
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nTotalizaContas = 1
                    IF USED("csRelatorio")
                        SELECT csRelatorio
                        GO TOP
                    ENDIF
                ELSE
                    IF (THIS.this_nTipoImp = 2 OR THIS.this_nTipoImp = 3) AND USED("crRel")
                        SELECT crRel
                        GO TOP
                    ELSE
                        IF USED("csRelatorio")
                        SELECT csRelatorio
                        GO TOP
                        ENDIF
                    ENDIF
                ENDIF
                REPORT FORM (THIS.ObterCaminhoFRX()) TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffnBO.Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarDocumentoExcel - Exporta dados para XLS
    * Semanal/Quinzenal: usa pivot crRel; demais: exporta csRelatorio
    *--------------------------------------------------------------------------
    PROCEDURE GerarDocumentoExcel()
        LOCAL loc_lSucesso, loc_cArquivo
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cArquivo = gc_4c_CaminhoBase + "FluxoFinanceiroSintetico.xls"
                IF (THIS.this_nTipoImp = 2 OR THIS.this_nTipoImp = 3) AND USED("crRel")
                    SELECT ' ' AS Titulo, dData1 AS Coluna1, dData2 AS Coluna2, ;
                           dData3 AS Coluna3, dData4 AS Coluna4, dData5 AS Coluna5, ;
                           dData6 AS Coluna6, dData7 AS Coluna7, dData8 AS Coluna8 ;
                      FROM crRel ;
                    UNION ALL ;
                    SELECT 'Saldo no in' + CHR(237) + 'cio da ' + Tipo AS Titulo, ;
                           STR(nSaldoIni1,12,2), STR(nSaldoIni2,12,2), STR(nSaldoIni3,12,2), ;
                           STR(nSaldoIni4,12,2), STR(nSaldoIni5,12,2), STR(nSaldoIni6,12,2), ;
                           STR(nSaldoIni7,12,2), STR(nSaldoIni8,12,2) FROM crRel ;
                    UNION ALL ;
                    SELECT 'Recebimentos estimados' AS Titulo, ;
                           STR(nRecEst1,12,2), STR(nRecEst2,12,2), STR(nRecEst3,12,2), ;
                           STR(nRecEst4,12,2), STR(nRecEst5,12,2), STR(nRecEst6,12,2), ;
                           STR(nRecEst7,12,2), STR(nRecEst8,12,2) FROM crRel ;
                    UNION ALL ;
                    SELECT 'Recebimentos confirmados' AS Titulo, ;
                           STR(nRecConf1,12,2), STR(nRecConf2,12,2), STR(nRecConf3,12,2), ;
                           STR(nRecConf4,12,2), STR(nRecConf5,12,2), STR(nRecConf6,12,2), ;
                           STR(nRecConf7,12,2), STR(nRecConf8,12,2) FROM crRel ;
                    UNION ALL ;
                    SELECT 'Pagamentos estimados' AS Titulo, ;
                           STR(nPagEst1,12,2), STR(nPagEst2,12,2), STR(nPagEst3,12,2), ;
                           STR(nPagEst4,12,2), STR(nPagEst5,12,2), STR(nPagEst6,12,2), ;
                           STR(nPagEst7,12,2), STR(nPagEst8,12,2) FROM crRel ;
                    UNION ALL ;
                    SELECT 'Pagamentos confirmados' AS Titulo, ;
                           STR(nPagConf1,12,2), STR(nPagConf2,12,2), STR(nPagConf3,12,2), ;
                           STR(nPagConf4,12,2), STR(nPagConf5,12,2), STR(nPagConf6,12,2), ;
                           STR(nPagConf7,12,2), STR(nPagConf8,12,2) FROM crRel ;
                    UNION ALL ;
                    SELECT 'Saldo no final da ' + Tipo AS Titulo, ;
                           STR(nSaldoFin1,12,2), STR(nSaldoFin2,12,2), STR(nSaldoFin3,12,2), ;
                           STR(nSaldoFin4,12,2), STR(nSaldoFin5,12,2), STR(nSaldoFin6,12,2), ;
                           STR(nSaldoFin7,12,2), STR(nSaldoFin8,12,2) FROM crRel ;
                      INTO CURSOR cursor_4c_ExcelExp
                    SELECT cursor_4c_ExcelExp
                    COPY TO (loc_cArquivo) TYPE XLS
                    IF USED("cursor_4c_ExcelExp")
                        USE IN cursor_4c_ExcelExp
                    ENDIF
                ELSE
                    IF USED("csRelatorio")
                        SELECT csRelatorio
                        COPY TO (loc_cArquivo) TYPE XLS
                    ENDIF
                ENDIF
                MsgInfo("Arquivo exportado com sucesso:" + CHR(13) + loc_cArquivo, "Excel")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffnBO.GerarDocumentoExcel")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarEmpresas - Marca todas as empresas para impressao
    *--------------------------------------------------------------------------
    PROCEDURE MarcarEmpresas()
        LOCAL loc_oErro
        TRY
            IF USED("cEmp")
                SELECT cEmp
                SCAN
                    REPLACE ImpEmps WITH .T.
                ENDSCAN
                GO TOP IN cEmp
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffnBO.MarcarEmpresas")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarEmpresas - Desmarca todas as empresas
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarEmpresas()
        LOCAL loc_oErro
        TRY
            IF USED("cEmp")
                SELECT cEmp
                SCAN
                    REPLACE ImpEmps WITH .F.
                ENDSCAN
                GO TOP IN cEmp
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffnBO.DesmarcarEmpresas")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarDisponibilidades - Marca todas as disponibilidades para impressao
    *--------------------------------------------------------------------------
    PROCEDURE MarcarDisponibilidades()
        LOCAL loc_oErro
        TRY
            IF USED("cDisp")
                SELECT cDisp
                SCAN
                    REPLACE ImpDisps WITH .T.
                ENDSCAN
                GO TOP IN cDisp
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffnBO.MarcarDisponibilidades")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarDisponibilidades - Desmarca todas as disponibilidades
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarDisponibilidades()
        LOCAL loc_oErro
        TRY
            IF USED("cDisp")
                SELECT cDisp
                SCAN
                    REPLACE ImpDisps WITH .F.
                ENDSCAN
                GO TOP IN cDisp
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffnBO.DesmarcarDisponibilidades")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarOperacoes - Marca todas as operacoes de titulos para impressao
    *--------------------------------------------------------------------------
    PROCEDURE MarcarOperacoes()
        LOCAL loc_oErro
        TRY
            IF USED("crSigOpOpe")
                SELECT crSigOpOpe
                SCAN
                    REPLACE SeleOp WITH .T.
                ENDSCAN
                GO TOP IN crSigOpOpe
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffnBO.MarcarOperacoes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarOperacoes - Desmarca todas as operacoes de titulos
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarOperacoes()
        LOCAL loc_oErro
        TRY
            IF USED("crSigOpOpe")
                SELECT crSigOpOpe
                SCAN
                    REPLACE SeleOp WITH .F.
                ENDSCAN
                GO TOP IN crSigOpOpe
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffnBO.DesmarcarOperacoes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        *-- Limpeza dos cursores carregados pelo InicializarCursoresAuxiliares
        IF USED("crSigOpOpe")
            USE IN crSigOpOpe
        ENDIF
        IF USED("cEmp")
            USE IN cEmp
        ENDIF
        IF USED("cDisp")
            USE IN cDisp
        ENDIF
        IF USED("crSigCdPag")
            USE IN crSigCdPag
        ENDIF
        IF USED("crSigCdRec")
            USE IN crSigCdRec
        ENDIF
        IF USED("crSigCdMoe")
            USE IN crSigCdMoe
        ENDIF
        IF USED("crSigCdCot")
            USE IN crSigCdCot
        ENDIF
        *-- Limpeza em SigTempR ao destruir o objeto
        IF !EMPTY(THIS.this_cChaveQuery)
            THIS.LimparSigTempR(THIS.this_cChaveQuery)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
