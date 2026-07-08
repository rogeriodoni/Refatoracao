*==============================================================================
* SIGREDTVBO.PRG
* Business Object para Demonstrativo de Conta Corrente (SigReDtv)
*
* Herda de RelatorioBase
* Tipos de relatorio:
*   Tipo 1 = Demonstrativo (SigReDtvP)
*   Tipo 2 = Mapa de Contas (SigReDtvM)
*
* FRXs utilizados:
*   SigReDt1 = Demonstrativo com Prevish+o/Orcamento
*   SigReDt2 = Demonstrativo Comparativo
*   SigReDt3 = Demonstrativo com Contrapartida
*   SigReDt4 = Demonstrativo Normal
*==============================================================================

DEFINE CLASS sigredtvBO AS RelatorioBase

    *-- Identificacao do tipo de relatorio (1=Demonstrativo, 2=Mapa de Contas)
    this_nTipo           = 1

    *-- Filtros de periodo
    this_dDtInicial      = {}
    this_dDtFinal        = {}

    *-- Filtro de moeda
    this_cCodMoeda       = ""
    this_cDesMoeda       = ""

    *-- Filtro de demonstrativo (Balancos)
    this_cDemonstrativo  = ""

    *-- Opcoes de tipo de data
    *   1=Emiss+ao  2=Lan+camento  3=Vencimento  4=Baixa  5=Configura+c+ao
    this_nTipoDatas      = 2

    *-- Filtro nota/sintetico
    *   1=Com NF  2=Sem NF  3=Todos
    this_nSnt            = 3

    *-- Tipo de cotacao para conversao de moeda
    *   1=Fechamento  2=Movimenta+c+ao
    this_nCotacao        = 2

    *-- Modo contrapartida
    *   1=Ocultar  2=Desmembrar
    this_nContrapartida  = 1

    *-- Modo comparativo
    *   1=N+ao  2=M+es Anterior  3=Ano Anterior
    this_nComparativo    = 1

    *-- Periodo comparativo (getComp1 / getComp2)
    this_dCompInicial    = {}
    this_dCompFinal      = {}

    *-- Flags de estado calculados em PrepararDados()
    this_lPrevisao       = .F.
    this_lComparativo    = .F.
    this_lContraPartida  = .F.

    *-- Cabecalho do relatorio (montado em PrepararDados)
    this_cTitulo         = ""
    this_cEmpresa        = ""

    *-- Filtro de empresas selecionadas para SQL IN (ex: "('001','002')")
    this_cFiltroEmpresas = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa Business Object de relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            *-- Relatorio nao tem tabela CRUD
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            *-- Valores padrao dos filtros (espelham os defaults do formulario original)
            THIS.this_dDtInicial     = DATE()
            THIS.this_dDtFinal       = DATE()
            THIS.this_cCodMoeda      = ""
            THIS.this_cDesMoeda      = ""
            THIS.this_cDemonstrativo = ""
            THIS.this_nTipoDatas     = 2
            THIS.this_nSnt           = 3
            THIS.this_nCotacao       = 2
            THIS.this_nContrapartida = 1
            THIS.this_nComparativo   = 1
            THIS.this_dCompInicial   = {}
            THIS.this_dCompFinal     = {}
            THIS.this_lPrevisao      = .F.
            THIS.this_lComparativo   = .F.
            THIS.this_lContraPartida = .F.
            THIS.this_cTitulo        = ""
            THIS.this_cEmpresa       = ""
            THIS.this_cFiltroEmpresas = ""
            THIS.this_nTipo          = 1

            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredtvBO.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarTipo - Define tipo do relatorio (1=Demonstrativo, 2=Mapa)
    * Chamado pelo Form antes de InicializarDados
    *--------------------------------------------------------------------------
    PROCEDURE ConfigurarTipo(par_nTipo)
        THIS.this_nTipo = IIF(par_nTipo = 2, 2, 1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterCaptionForm - Retorna caption do form conforme tipo
    *--------------------------------------------------------------------------
    PROCEDURE ObterCaptionForm()
        IF THIS.this_nTipo = 2
            RETURN "Mapa de Contas"
        ENDIF
        RETURN "Demonstrativo"
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Sem chave primaria para relatorios
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarDateTimeFim - Formata data final com hora 23:59:59 para SQL
    * Equivalente a fDtoSQL(date, '23:59:59') do sistema legado
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION FormatarDateTimeFim(par_dData)
        LOCAL loc_cData
        loc_cData = FormatarDataSQL(par_dData)
        IF loc_cData = "NULL"
            RETURN "NULL"
        ENDIF
        RETURN LEFT(loc_cData, LEN(loc_cData) - 1) + " 23:59:59'"
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterNomeFRX - Retorna caminho do FRX conforme modo do relatorio
    * SigReDt1 = Previsao/Orcamento
    * SigReDt2 = Comparativo
    * SigReDt3 = Contrapartida
    * SigReDt4 = Normal
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterNomeFRX()
        LOCAL loc_cArq
        IF THIS.this_lPrevisao
            loc_cArq = "SigReDt1.frx"
        ELSE
            IF THIS.this_lComparativo
                loc_cArq = "SigReDt2.frx"
            ELSE
                IF THIS.this_lContraPartida
                    loc_cArq = "SigReDt3.frx"
                ELSE
                    loc_cArq = "SigReDt4.frx"
                ENDIF
            ENDIF
        ENDIF
        RETURN ADDBS(gc_4c_CaminhoReports) + loc_cArq
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarCambio - Retorna cotacao da moeda na data informada
    * Equivalente a fCarregarCambio() do sistema legado
    * Busca a cotacao mais recente <= par_dData para a moeda informada
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarCambio(par_cMoeda, par_dData)
        LOCAL loc_nCotacao, loc_cMoeda
        loc_nCotacao = 1
        loc_cMoeda   = ALLTRIM(par_cMoeda)
        IF USED("crSigCdCot") AND !EMPTY(loc_cMoeda) AND !EMPTY(par_dData)
            SELECT crSigCdCot
            SET ORDER TO CMoeData
            IF SEEK(loc_cMoeda + DTOS(par_dData))
                loc_nCotacao = crSigCdCot.Valos
            ELSE
                SKIP -1
                IF !BOF() AND ALLTRIM(crSigCdCot.CMoes) = loc_cMoeda AND ;
                   TTOD(crSigCdCot.Datas) <= par_dData
                    loc_nCotacao = crSigCdCot.Valos
                ENDIF
            ENDIF
        ENDIF
        RETURN IIF(loc_nCotacao = 0, 1, loc_nCotacao)
    ENDFUNC

    *--------------------------------------------------------------------------
    * InicializarDados - Carrega cursores de referencia usados no relatorio
    * Chamado pelo Form.InicializarForm() apos criar o BO
    * Equivalente ao PROCEDURE Init do sistema legado (parte de carga de dados)
    *--------------------------------------------------------------------------
    PROCEDURE InicializarDados()
        LOCAL loc_lSucesso, loc_oErro, loc_cQuery, loc_nResult
        loc_lSucesso = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY
            *-- Cotacoes de moeda
            WAIT WINDOW "Aguarde!!! Carregando Cota" + CHR(231) + CHR(245) + "es..." NOWAIT
            loc_cQuery = "SELECT CMoes, Datas, Valos FROM SigCdCot"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crSigCdCot")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar SigCdCot"
                MsgErro(THIS.this_cMensagemErro, "sigredtvBO.InicializarDados")
                loc_lSucesso = .F.
            ENDIF
            SELECT crSigCdCot
            INDEX ON CMoes + DTOS(Datas) TAG CMoeData

            *-- Moedas
            WAIT WINDOW "Aguarde!!! Carregando Moedas..." NOWAIT
            loc_cQuery = "SELECT CMoes, Cotas FROM SigCdMoe"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crSigCdMoe")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar SigCdMoe"
                MsgErro(THIS.this_cMensagemErro, "sigredtvBO.InicializarDados")
                loc_lSucesso = .F.
            ENDIF
            SELECT crSigCdMoe
            INDEX ON CMoes TAG CMoes

            *-- Grupos de conta corrente
            WAIT WINDOW "Aguarde!!! Carregando Grupos..." NOWAIT
            loc_cQuery = "SELECT Codigos, Classes FROM SigCdGcr"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crSigCdGcr")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar SigCdGcr"
                MsgErro(THIS.this_cMensagemErro, "sigredtvBO.InicializarDados")
                loc_lSucesso = .F.
            ENDIF
            SELECT crSigCdGcr
            INDEX ON Codigos TAG Codigos

            *-- Configuracoes dos Mapas/Demonstrativos
            WAIT WINDOW "Aguarde!!! Carregando Configura" + CHR(231) + CHR(245) + "es dos Mapas..." NOWAIT
            loc_cQuery = "SELECT * FROM SigCdMrr"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crSigCdMrr")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar SigCdMrr"
                MsgErro(THIS.this_cMensagemErro, "sigredtvBO.InicializarDados")
                loc_lSucesso = .F.
            ENDIF
            SELECT crSigCdMrr
            INDEX ON Balancos TAG Balancos

            *-- Itens de configuracao do mapa
            loc_cQuery = "SELECT Ordems, Classes, Grupos, DescGrps, Fators, Operacaos, " + ;
                         "Analiticos, Balancos, TpRegs, Titulos, CPartidas, SubTot100s " + ;
                         "FROM SigCdMri " + ;
                         "ORDER BY Ordems, Classes, Grupos, DescGrps, Fators, Operacaos, " + ;
                         "Analiticos, Balancos, TpRegs, Titulos, CPartidas"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crSigCdMri")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar SigCdMri"
                MsgErro(THIS.this_cMensagemErro, "sigredtvBO.InicializarDados")
                loc_lSucesso = .F.
            ENDIF
            SELECT crSigCdMri
            INDEX ON Balancos + STR(Ordems, 3)            TAG Balancos
            INDEX ON Balancos + Grupos + STR(Ordems, 3)   TAG Grupos
            INDEX ON Balancos + DescGrps + STR(Ordems, 3) TAG DescGrps
            INDEX ON Classes + STR(Ordems, 3)             TAG Classes

            *-- Classes
            loc_cQuery = "SELECT Classes, Descrs, Nivels FROM SigCdCss"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crSigCdCss")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar SigCdCss"
                MsgErro(THIS.this_cMensagemErro, "sigredtvBO.InicializarDados")
                loc_lSucesso = .F.
            ENDIF
            SELECT crSigCdCss
            INDEX ON Classes TAG Classes

            *-- Conta de pagamento/recebimento (para tratamento de contrapartidas)
            loc_cQuery = "SELECT GrupoPags, ContaPags, GrupoRecs, ContaRecs FROM SigCdPam"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crSigCdPam")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar SigCdPam"
                MsgErro(THIS.this_cMensagemErro, "sigredtvBO.InicializarDados")
                loc_lSucesso = .F.
            ENDIF
            GO TOP IN crSigCdPam

            *-- Orcamentos/Previsoes (cabecalho)
            WAIT WINDOW "Aguarde !!! Carregando previs" + CHR(245) + "es..." NOWAIT
            loc_cQuery = "SELECT 0 AS Imps, cMes, cAno, cTitulo, Moeda " + ;
                         "FROM SigCdMrp GROUP BY cMes, cAno, cTitulo, Moeda"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crSigCdMrp")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar SigCdMrp"
                MsgErro(THIS.this_cMensagemErro, "sigredtvBO.InicializarDados")
                loc_lSucesso = .F.
            ENDIF
            SELECT crSigCdMrp
            INDEX ON cTitulo TAG cTitulo

            *-- Empresas
            IF !THIS.CarregarEmpresas()
                loc_lSucesso = .F.
            ENDIF

            *-- Orcamentos disponiveis para empresa selecionada
            THIS.DisponibilizarOrcamentos()

            WAIT CLEAR
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredtvBO.InicializarDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarEmpresas - Carrega cursor csSigCdEmp com lista de empresas
    * O Form liga grd_4c_Emps.RecordSource = 'csSigCdEmp'
    *--------------------------------------------------------------------------
    PROCEDURE CarregarEmpresas()
        LOCAL loc_lSucesso, loc_oErro, loc_cQuery, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_cQuery = "SELECT a.cemps, a.razas, 1 AS Imps " + ;
                         "FROM SigCdEmp a ORDER BY a.cemps"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "csSigCdEmp")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar SigCdEmp"
                MsgErro(THIS.this_cMensagemErro, "sigredtvBO.CarregarEmpresas")
                loc_lSucesso = .F.
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredtvBO.CarregarEmpresas")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * DisponibilizarOrcamentos - Atualiza crSigCdMrp para empresa selecionada
    * Chamado quando o usuario altera selecao de empresa no grid
    * Equivalente ao PROCEDURE disponib_orcs do sistema legado
    *--------------------------------------------------------------------------
    PROCEDURE DisponibilizarOrcamentos()
        LOCAL loc_lSucesso, loc_oErro, loc_cQuery, loc_nResult, loc_cEmpSel
        loc_lSucesso = .F.
        TRY
            IF !USED("csSigCdEmp")
                loc_lSucesso = .F.
            ENDIF

            *-- Verifica quantas empresas estao marcadas
            SELECT cEmps FROM csSigCdEmp WHERE Imps = 1 INTO CURSOR crQtdEmp READWRITE
            IF USED("crQtdEmp") AND RECCOUNT("crQtdEmp") = 1
                GO TOP IN crQtdEmp
                loc_cEmpSel = ALLTRIM(crQtdEmp.cEmps)
                loc_cQuery = "SELECT 0 AS Imps, cEmps, cMes, cAno, cTitulo, Moeda " + ;
                             "FROM SigCdMrp WHERE cEmps = " + EscaparSQL(loc_cEmpSel) + ;
                             " GROUP BY cEmps, cMes, cAno, cTitulo, Moeda"
            ELSE
                *-- Multiplas ou nenhuma empresa: nao exibe orcamentos
                loc_cQuery = "SELECT 0 AS Imps, cEmps, cMes, cAno, cTitulo, Moeda " + ;
                             "FROM SigCdMrp WHERE cEmps = '' " + ;
                             "GROUP BY cEmps, cMes, cAno, cTitulo, Moeda"
            ENDIF

            IF USED("crQtdEmp")
                USE IN crQtdEmp
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crSigCdMrp")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar orcamentos (SigCdMrp)"
                MsgErro(THIS.this_cMensagemErro, "sigredtvBO.DisponibilizarOrcamentos")
                loc_lSucesso = .F.
            ENDIF

            SELECT crSigCdMrp
            INDEX ON cTitulo TAG cTitulo
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredtvBO.DisponibilizarOrcamentos")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursor dbRelatorio para o REPORT FORM
    * Equivalente ao PROCEDURE processamento do sistema legado
    * Requer: csSigCdEmp, crSigCdMrp, crSigCdCot, crSigCdGcr, crSigCdMri,
    *         crSigCdCss, crSigCdMrr, crSigCdPam carregados por InicializarDados
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cMoe, loc_nSnt, loc_cDtIni, loc_cDtFim, loc_nTpDat
        LOCAL loc_cEpr, loc_cDpr, loc_cDmr, loc_nOpc, loc_llPep
        LOCAL loc_cNomeEmpresa, loc_cTitulo, loc_cEmpresa
        LOCAL loc_cPrevisao, loc_cOrcamento, loc_cMoedaOrc, loc_cOrcs
        LOCAL loc_cQuery, loc_nResult
        LOCAL loc_lnCot1, loc_lnCot2, loc_lnValors
        LOCAL loc_nDecimals, loc_cFixed, loc_cEscape
        LOCAL loc_lnNsegi, loc_lcCol
        LOCAL loc_lnRec1, loc_lnValor, loc_lnOperacao, loc_lndRecno
        LOCAL loc_lbFirst, loc_lnTotPrevisao, loc_lnVlrPrev
        LOCAL loc_lnTotOrcado, loc_lnTotReal, loc_lnTotOrcAux, loc_lnTotRealAux
        LOCAL loc_lnRecTroca, loc_lnPercFirstO, loc_lnPercFirstR, loc_lnOrdAux
        LOCAL loc_cConta, loc_lcEmps
        LOCAL loc_lnI, loc_cAlias
        PRIVATE pDtI, pDtF, pDcI, pDcF

        loc_lSucesso = .F.
        TRY
            *-- Filtros do formulario mapeados para variaveis locais
            loc_cMoe   = ALLTRIM(THIS.this_cCodMoeda)
            loc_nSnt   = THIS.this_nSnt
            loc_nTpDat = THIS.this_nTipoDatas
            loc_cDmr   = ALLTRIM(THIS.this_cDemonstrativo)
            loc_nOpc   = THIS.this_nComparativo

            *-- Datas para uso nos parametros SQL (?pDtI / ?pDtF binding)
            pDtI = THIS.this_dDtInicial
            pDtF = THIS.this_dDtFinal
            loc_cDtIni = FormatarDataSQL(THIS.this_dDtInicial)
            loc_cDtFim = THIS.FormatarDateTimeFim(THIS.this_dDtFinal)

            THIS.this_lPrevisao    = .F.
            THIS.this_lComparativo = .F.

            GO TOP IN csSigCdEmp

            *-- Monta lista de empresas selecionadas (IN clause para SQL)
            SELECT cEmps, Razas FROM csSigCdEmp WHERE Imps = 1 INTO CURSOR crAux READWRITE
            GO TOP IN crAux

            IF RECCOUNT("crAux") = 1
                *-- Uma empresa
                loc_cEpr = "('" + ALLTRIM(crAux.cEmps) + "')"
                loc_cDpr = ALLTRIM(crAux.cEmps) + " - " + ALLTRIM(crAux.Razas)
            ELSE
                IF RECCOUNT("crAux") = RECCOUNT("csSigCdEmp")
                    *-- Todas as empresas
                    loc_cEpr = ""
                    loc_cDpr = "Todas Empresas"
                ELSE
                    *-- Varias empresas
                    loc_cEpr = "("
                    loc_cDpr = "Empresas : "
                    SELECT crAux
                    SCAN
                        IF LEN(loc_cEpr) <> 1
                            loc_cEpr = loc_cEpr + ","
                        ENDIF
                        loc_cEpr = loc_cEpr + "'" + ALLTRIM(crAux.cEmps) + "'"
                        IF LEN(loc_cDpr) <> 11
                            loc_cDpr = loc_cDpr + ", "
                        ENDIF
                        loc_cDpr = loc_cDpr + ALLTRIM(crAux.cEmps)
                    ENDSCAN
                    loc_cEpr = loc_cEpr + ")"
                ENDIF
            ENDIF
            IF USED("crAux")
                USE IN crAux
            ENDIF

            *-- Salva filtro de empresas para uso pelo PrepararComparativo
            THIS.this_cFiltroEmpresas = loc_cEpr

            *-- Verifica se demonstrativo existe
            SELECT crSigCdMrr
            SET ORDER TO Balancos
            IF !SEEK(loc_cDmr, "crSigCdMrr", "Balancos")
                THIS.this_cMensagemErro = "Demonstrativo n" + CHR(227) + "o encontrado: " + loc_cDmr
                MsgErro(THIS.this_cMensagemErro, "sigredtvBO.PrepararDados")
                loc_lSucesso = .F.
            ENDIF
            loc_llPep = (crSigCdMrr.Mapas = 2)
            loc_lcCol = IIF(loc_nOpc = 2, "Mov M" + CHR(234) + "s Anterior", "Mov Ano Anterior")

            *-- Modo comparativo
            IF loc_nOpc > 1
                pDcI = THIS.this_dCompInicial
                pDcF = THIS.this_dCompFinal
                THIS.PrepararComparativo(loc_cEpr, loc_cMoe, ;
                    FormatarDataSQL(THIS.this_dCompInicial), ;
                    THIS.FormatarDateTimeFim(THIS.this_dCompFinal), ;
                    loc_llPep, loc_cDmr)
                THIS.this_lComparativo = .T.
            ENDIF

            *-- Nome da empresa (empresa logada)
            loc_cQuery = "SELECT cemps, razas FROM SigCdEmp WHERE cemps = " + ;
                         EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crSigCdEmp")
            IF loc_nResult > 0 AND !EOF("crSigCdEmp")
                loc_cNomeEmpresa = ALLTRIM(crSigCdEmp.Razas)
                IF USED("crSigCdEmp")
                    USE IN crSigCdEmp
                ENDIF
            ELSE
                loc_cNomeEmpresa = ""
                IF USED("crSigCdEmp")
                    USE IN crSigCdEmp
                ENDIF
            ENDIF

            *-- Titulo e empresa do relatorio
            SELECT crSigCdMrr
            SET ORDER TO Balancos
            SEEK loc_cDmr
            loc_cTitulo  = ALLTRIM(crSigCdMrr.Titulos) + " de " + ;
                           DTOC(THIS.this_dDtInicial) + " " + CHR(224) + " " + ;
                           DTOC(THIS.this_dDtFinal) + " em " + ALLTRIM(THIS.this_cDesMoeda)
            loc_cEmpresa = loc_cDpr

            *-- Verifica orcamentos selecionados
            SELECT crSigCdMrp
            LOCATE

            SELECT cTitulo FROM crSigCdMrp WHERE Imps = 1 INTO CURSOR crAux READWRITE
            loc_cPrevisao  = IIF(RECCOUNT("crAux") > 0, "S", "N")
            loc_cOrcamento = "Or" + CHR(231) + "amento : " + ;
                             IIF(RECCOUNT("crAux") = 1, ALLTRIM(crAux.cTitulo), "Acumulados")
            loc_cMoedaOrc  = ""

            IF loc_cPrevisao = "S"
                THIS.this_lPrevisao = .T.
                *-- Monta lista de chaves de orcamentos selecionados
                loc_cOrcs = ""
                SELECT crSigCdMrp
                GO TOP IN crSigCdMrp
                SCAN
                    IF crSigCdMrp.Imps = 1
                        loc_cMoedaOrc = crSigCdMrp.Moeda
                        IF !EMPTY(loc_cOrcs)
                            loc_cOrcs = loc_cOrcs + ","
                        ENDIF
                        loc_cOrcs = loc_cOrcs + CHR(39) + ;
                            PADR(ALLTRIM(crSigCdMrp.cEmps), 3) + ;
                            ALLTRIM(crSigCdMrp.cMes) + ;
                            ALLTRIM(crSigCdMrp.cAno) + ;
                            PADR(ALLTRIM(crSigCdMrp.cTitulo), 40) + ;
                            PADR(ALLTRIM(crSigCdMrp.Moeda), 3) + CHR(39)
                    ENDIF
                ENDSCAN
                loc_cOrcs = "(" + loc_cOrcs + ")"

                *-- Carrega previsoes consolidadas por grupo/conta
                loc_cQuery = "SELECT cGrupos, iClis, Sum(nValors) AS nValors " + ;
                             "FROM SigCdMrp " + ;
                             "WHERE cEmps+cMes+cAno+cTitulo+Moeda IN " + loc_cOrcs + ;
                             " GROUP BY cGrupos, iClis"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crPrevisao")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao carregar previs" + CHR(227) + "o (crPrevisao)"
                    MsgErro(THIS.this_cMensagemErro, "sigredtvBO.PrepararDados")
                    loc_lSucesso = .F.
                ENDIF
                SELECT crPrevisao
                INDEX ON cGrupos TAG PrevGrp
                INDEX ON iClis   TAG PrevCta
            ENDIF

            IF USED("crAux")
                USE IN crAux
            ENDIF

            *-- Cabecalho do relatorio
            THIS.this_cTitulo  = loc_cTitulo
            THIS.this_cEmpresa = loc_cNomeEmpresa

            IF USED("dbCabecalho")
                USE IN dbCabecalho
            ENDIF
            CREATE CURSOR dbCabecalho (NomeEmpresa C(80), Titulo C(80), ;
                Empresa C(80), Previsao C(1), Orcamento C(80), ;
                Comparativo C(20), Faixas L)
            INSERT INTO dbCabecalho (NomeEmpresa, Titulo, Empresa, ;
                Previsao, Orcamento, Comparativo, Faixas) ;
                VALUES (loc_cNomeEmpresa, loc_cTitulo, loc_cEmpresa, ;
                        loc_cPrevisao, loc_cOrcamento, loc_lcCol, ;
                        THIS.this_nContrapartida = 1)

            *-- Configuracoes de SET
            loc_cEscape   = SET("Escape")
            loc_nDecimals = SET("Decimals")
            loc_cFixed    = SET("Fixed")
            SET ESCAPE OFF
            SET DECIMALS TO 2
            SET FIXED ON

            IF USED("crSigMvCcr")
                USE IN crSigMvCcr
            ENDIF

            *-- ======================== SQL PRINCIPAL ========================
            *-- Busca movimentos de conta corrente com joins aos mapas/configs
            WAIT WINDOW "Aguarde!!! Selecionando Movimenta" + CHR(231) + CHR(245) + "es de Conta Corrente..." NOWAIT

            loc_cQuery = "SELECT DISTINCT a.Grupos, a.Contas, " + ;
                IIF(loc_nTpDat = 1, "a.DtEmis ", ;
                IIF(loc_nTpDat = 2, "a.Datas ", ;
                IIF(loc_nTpDat = 3, "a.Vencs ", ;
                IIF(loc_nTpDat = 4, ;
                    "case when f.Datarcs Is Null then h.Datarcs else f.Datarcs end ", ;
                    "Case When c.TpDatas = 1 Then a.DtEmis Else Case When c.TpDatas = 2 " + ;
                    "Then a.Datas Else Case When c.TpDatas in (0,3) Then a.Vencs " + ;
                    "Else case when f.Datarcs Is Null then h.Datarcs else f.Datarcs end " + ;
                    "End End End ")))) + ;
                "AS Datas, a.Valors, a.Svalors, a.Moedas, a.Smoedas, " + ;
                "a.Cotacaos, a.Scotacaos, a.Opers, a.Emps, a.Scontas, a.ContEms, a.cIdChaves, " + ;
                "case when Not e.Acertos Is Null then e.Acertos " + ;
                "else round((g.Acertos*((a.Valors/g.valos)*100)/100),2) end As Acertos, " + ;
                "case when e.Cotacaos Is Null then g.Cotacaos else e.Cotacaos end As CotAcertos, " + ;
                "c.TpDatas, a.EmpCcs " + ;
                "FROM SigMvCcr a " + ;
                "INNER JOIN SigCdMri c ON a.Grupos = c.Grupos " + ;
                "INNER JOIN SigCdGcr b ON a.Grupos = b.Codigos " + ;
                "INNER JOIN SigCdCss d ON b.Classes = d.Classes " + ;
                "LEFT JOIN SigCdPit e ON a.nOpers = e.nOpers AND a.Emps = e.EmpOs " + ;
                "LEFT JOIN SigCdPgr f ON e.Empdopnums = f.Empdopnums " + ;
                "LEFT JOIN SigCdPit g ON a.vOpers = (g.EmpOs + convert(varchar(9),g.nOpers)) " + ;
                "LEFT JOIN SigCdPgr h ON g.Empdopnums = h.Empdopnums " + ;
                "WHERE c.Balancos = " + EscaparSQL(loc_cDmr) + " AND " + ;
                IIF(loc_nTpDat = 1, "a.DtEmis BETWEEN " + loc_cDtIni + " AND " + loc_cDtFim + " ", ;
                IIF(loc_nTpDat = 2, "a.Datas BETWEEN " + loc_cDtIni + " AND " + loc_cDtFim + " ", ;
                IIF(loc_nTpDat = 3, "a.Vencs BETWEEN " + loc_cDtIni + " AND " + loc_cDtFim + " ", ;
                IIF(loc_nTpDat = 4, ;
                    "case when f.Datarcs Is Null then h.Datarcs else f.Datarcs end " + ;
                    "BETWEEN " + loc_cDtIni + " AND " + loc_cDtFim + " ", ;
                    "(Case When c.TpDatas = 1 And a.DtEmis BETWEEN " + loc_cDtIni + " AND " + loc_cDtFim + " Then 1 Else " + ;
                    "Case When c.TpDatas = 2 And a.Datas BETWEEN " + loc_cDtIni + " AND " + loc_cDtFim + " Then 1 Else " + ;
                    "Case When c.TpDatas in (0,3) And a.Vencs BETWEEN " + loc_cDtIni + " AND " + loc_cDtFim + " Then 1 Else " + ;
                    "Case When c.TpDatas = 4 And (f.datarcs BETWEEN " + loc_cDtIni + " AND " + loc_cDtFim + ;
                    " Or h.datarcs BETWEEN " + loc_cDtIni + " AND " + loc_cDtFim + ") Then 1 Else 0 End End End End) = 1 ")))) + ;
                IIF(EMPTY(loc_cEpr), "", ;
                    "AND (Case When a.EmpCcs <> '' And a.EmpCcs IN " + loc_cEpr + " Then 1 Else " + ;
                    "Case When a.EmpCcs = '' And a.Emps IN " + loc_cEpr + " Then 1 Else 0 End End) = 1 ") + ;
                IIF(loc_nSnt = 3, "", ;
                    IIF(loc_nSnt = 1, "AND Not a.NFs = '          ' ", "AND a.NFs = '          ' ")) + ;
                "ORDER BY a.Grupos, a.Contas, 3, a.Valors, a.Svalors, a.Moedas, a.Smoedas, " + ;
                "a.Cotacaos, a.Scotacaos, a.Opers, a.Emps, a.Scontas, a.cIdChaves"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "TmpBal1")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao selecionar movimentos (TmpBal1)"
                MsgErro(THIS.this_cMensagemErro, "sigredtvBO.PrepararDados")
                loc_lSucesso = .F.
            ENDIF
            WAIT CLEAR

            *-- Seleciona registros distintos de TmpBal1 ? cBal2
            SELECT DISTINCT Grupos, Contas, NVL(Datas, CTOT(SPACE(08))) AS Datas, ;
                Valors, Svalors, Moedas, Smoedas, Cotacaos, Scotacaos, Opers, ;
                IIF(!EMPTY(EmpCcs), EmpCcs, Emps) AS Emps, ;
                Scontas, ContEms, cIdChaves, TpDatas ;
              FROM TmpBal1 ;
              INTO CURSOR cBal2 READWRITE

            IF !USED("cBal2") OR RECCOUNT("cBal2") = 0
                *-- Sem dados
                SELECT cBal2
                GO TOP
                loc_lSucesso = .T.
            ENDIF

            *-- =================== PROCESSA cBal2 ===================
            *-- Monta cursor anal?tico (Ps='5') com contas individuais
            SELECT d.Ordems, b.Classes AS Classes, e.Descrs AS Desctpgcs, ;
                a.Grupos, d.DescGrps AS Ds_grupos, a.Contas, SPACE(50) AS Ds_contas, ;
                VAL(STR(a.Valors * IIF(a.Opers == "D", 1, -1), 16, 2)) * d.Fators / 100 AS Valors, ;
                a.Moedas, d.Operacaos, d.Analiticos, e.Nivels, e.Descrs AS DescClasse, ;
                "5" AS Ps, SPACE(10) AS cOrdBals, d.fators, 0000000000 AS dRecno, ;
                d.Titulos, IIF(loc_llPep, a.Emps, "   ") AS Emps, a.Scontas, a.ContEms, ;
                d.cpartidas, a.cIdChaves, 0000000000000.00 AS Previsao, ;
                0000.00 AS PercPrev, 0000.00 AS PercGrp, ;
                SPACE(50) AS Ds_SContas, SPACE(50) AS Ds_ContEms ;
              FROM cBal2 a, crSigCdGcr b, crSigCdMri d, crSigCdCss e ;
             WHERE d.Balancos == m.loc_cDmr AND d.Grupos == a.Grupos AND ;
                   !d.TpRegs == 2 AND !d.TpRegs == 3 AND ;
                   b.Codigos == a.Grupos AND e.Classes == b.Classes ;
             ORDER BY 1, 2, 4, 6 ;
              INTO CURSOR cBalCP READWRITE

            *-- Conversao de moeda em cBal2
            loc_lnCot2 = THIS.CarregarCambio(loc_cMoe, THIS.this_dDtFinal)
            loc_lnValors = 0

            SELECT cBal2
            SCAN
                SCATTER MEMVAR FIELDS Valors, Moedas
                IF loc_nTpDat = 4 OR (loc_nTpDat = 5 AND INLIST(cBal2.TpDatas, 4))
                    loc_lnValors = 0
                    m.Acertos    = 0
                    SELECT TmpBal1
                    SCAN FOR cIdChaves = cBal2.cIdChaves
                        IF Datas <> cBal2.Datas
                            LOOP
                        ENDIF
                        m.Acertos = NVL(TmpBal1.Acertos, 0)
                        IF !cBal2.Moedas = loc_cMoe
                            IF THIS.this_nCotacao = 1
                                loc_lnCot1 = THIS.CarregarCambio(cBal2.Moedas, THIS.this_dDtFinal)
                            ELSE
                                loc_lnCot1 = IIF(NVL(TmpBal1.CotAcertos, 0) <> 0, TmpBal1.CotAcertos, THIS.CarregarCambio(cBal2.Moedas, TTOD(cBal2.Datas)))
                                loc_lnCot2 = THIS.CarregarCambio(loc_cMoe, TTOD(cBal2.Datas))
                            ENDIF
                            m.Acertos = (NVL(TmpBal1.Acertos, 0) * loc_lnCot1 / loc_lnCot2)
                            m.Moedas  = loc_cMoe
                        ENDIF
                        loc_lnValors = loc_lnValors + m.Acertos
                    ENDSCAN
                ELSE
                    IF !cBal2.Moedas = loc_cMoe
                        IF THIS.this_nCotacao = 1
                            loc_lnCot1 = THIS.CarregarCambio(cBal2.Moedas, THIS.this_dDtFinal)
                        ELSE
                            loc_lnCot1 = IIF(cBal2.Cotacaos <> 0, cBal2.Cotacaos, THIS.CarregarCambio(cBal2.Moedas, TTOD(cBal2.Datas)))
                            loc_lnCot2 = THIS.CarregarCambio(loc_cMoe, TTOD(cBal2.Datas))
                        ENDIF
                        IF cBal2.Smoedas = loc_cMoe AND THIS.this_nCotacao = 2
                            m.Valors = cBal2.Svalors
                        ELSE
                            m.Valors = (cBal2.Valors * loc_lnCot1 / loc_lnCot2)
                        ENDIF
                    ENDIF
                ENDIF

                SELECT cBal2
                m.Moedas = loc_cMoe
                GATHER MEMVAR FIELDS Valors, Moedas

                SELECT cBalCP
                GO TOP IN cBalCP
                LOCATE FOR cIdChaves = cBal2.cIdChaves
                IF !EOF("cBalCP")
                    SELECT cBalCP
                    GATHER MEMVAR FIELDS Valors, Moedas
                ENDIF
            ENDSCAN

            *-- Cursor de grupos (Ps='3') - resumo por classe
            SELECT d.Ordems, d.Classes AS Classes, e.Descrs AS Desctpgcs, ;
                d.Grupos, d.DescGrps AS Ds_grupos, SPACE(10) AS Contas, ;
                SPACE(50) AS Ds_contas, ;
                VAL(STR(SUM(a.Valors * IIF(a.Opers == "D", 1, -1)), 16, 2)) * d.Fators / 100 AS Valor, ;
                a.Moedas, d.Operacaos, d.Analiticos, e.Nivels, e.Descrs AS DescClasse, ;
                "3" AS Ps, SPACE(10) AS cOrdBals, d.fators, 0000000000 AS dRecno, ;
                d.Titulos, IIF(loc_llPep, a.Emps, "   ") AS Emps, SPACE(10) AS Scontas, ;
                d.cpartidas, 0000000000000.00 AS Previsao, ;
                0000.00 AS PercPrev, 0000.00 AS PercGrp, ;
                SPACE(50) AS Ds_SContas, SPACE(50) AS Ds_ContEms, SPACE(10) AS ContEms ;
              FROM cBal2 a, crSigCdGcr b, crSigCdMri d, crSigCdCss e ;
             WHERE d.Balancos == m.loc_cDmr AND d.TpRegs == 3 AND ;
                   LEFT(b.Classes, LEN(ALLTRIM(d.Classes))) = ALLTRIM(d.Classes) AND ;
                   b.Codigos == a.Grupos AND e.Classes == d.Classes ;
             GROUP BY 1,2,3,4,5,6,7,9,10,11,12,13,14,15,16,17,18,19,20,21 ;
             ORDER BY 1, 2, 4, 6 ;
              INTO CURSOR cBal4

            *-- Cursor de contas (Ps='5') - contas individuais por grupo
            SELECT d.Ordems, b.Classes AS Classes, e.Descrs AS Desctpgcs, ;
                a.Grupos, d.DescGrps AS Ds_grupos, a.Contas, SPACE(50) AS Ds_contas, ;
                VAL(STR(SUM(a.Valors * IIF(a.Opers == "D", 1, -1)), 16, 2)) * d.Fators / 100 AS Valor, ;
                a.Moedas, d.Operacaos, d.Analiticos, e.Nivels, e.Descrs AS DescClasse, ;
                "5" AS Ps, SPACE(10) AS cOrdBals, d.fators, 0000000000 AS dRecno, ;
                d.Titulos, IIF(loc_llPep, a.Emps, "   ") AS Emps, SPACE(10) AS Scontas, ;
                d.cpartidas, 0000000000000.00 AS Previsao, ;
                0000.00 AS PercPrev, 0000.00 AS PercGrp, ;
                SPACE(50) AS Ds_SContas, SPACE(50) AS Ds_ContEms, SPACE(10) AS ContEms ;
              FROM cBal2 a, crSigCdGcr b, crSigCdMri d, crSigCdCss e ;
             WHERE d.Balancos == m.loc_cDmr AND d.Grupos == a.Grupos AND ;
                   !d.TpRegs == 2 AND !d.TpRegs == 3 AND ;
                   b.Codigos == a.Grupos AND e.Classes == b.Classes ;
             GROUP BY 1,2,3,4,5,6,7,9,10,11,12,13,14,15,16,17,18,19,20,21 ;
             ORDER BY 1, 2, 4, 6 ;
              INTO CURSOR cBal3

            *-- Cursor de contrapartidas (Ps='7') - detalhe por conta/scontas
            SELECT d.Ordems, b.Classes AS Classes, e.Descrs AS Desctpgcs, ;
                a.Grupos, d.DescGrps AS Ds_grupos, a.Contas, a.Scontas, ;
                SPACE(50) AS Ds_contas, ;
                VAL(STR(SUM(a.Valors * IIF(a.Opers == "D", 1, -1)), 16, 2)) * d.Fators / 100 AS Valor, ;
                a.Moedas, d.Operacaos, d.Analiticos, e.Nivels, e.Descrs AS DescClasse, ;
                "7" AS Ps, SPACE(10) AS cOrdBals, d.fators, 0000000000 AS dRecno, ;
                d.Titulos, a.Emps ;
              FROM cBal2 a, crSigCdGcr b, crSigCdMri d, crSigCdCss e ;
             WHERE d.Balancos == m.loc_cDmr AND d.Grupos == a.Grupos AND ;
                   !d.TpRegs == 2 AND !d.TpRegs == 3 AND ;
                   b.Codigos == a.Grupos AND e.Classes == b.Classes ;
             GROUP BY 1,2,3,4,5,6,7,8,10,11,12,13,14,15,16,17,18,19,20 ;
             ORDER BY 1, 2, 4, 6, 7 ;
              INTO CURSOR ContPart

            *-- Une cBal3 + cBal4 no cursor principal do relatorio
            SELECT a.* FROM cBal3 a ;
             UNION ;
            SELECT b.* FROM cBal4 b ;
              INTO CURSOR dbRelatorio READWRITE

            WAIT CLEAR

            *-- Busca descricao de cada conta em SigCdCli
            WAIT WINDOW "Aguarde!!! Analisando Registros..." NOWAIT
            SELECT dbRelatorio
            GO TOP
            SCAN
                loc_cConta = IIF(dbRelatorio.Ps = "7", dbRelatorio.sContas, dbRelatorio.Contas)
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cConta), ;
                    "TmpCli")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao buscar descri" + CHR(231) + CHR(227) + "o de conta (TmpCli)"
                    MsgErro(THIS.this_cMensagemErro, "sigredtvBO.PrepararDados")
                    loc_lSucesso = .F.
                ENDIF
                SELECT TmpCli
                GO TOP
                IF !EOF()
                    REPLACE Ds_Contas WITH TmpCli.RClis IN dbRelatorio
                ENDIF
                SELECT dbRelatorio
            ENDSCAN
            WAIT CLEAR

            IF !USED("dbRelatorio") OR RECCOUNT("dbRelatorio") = 0
                SELECT cBal2
                GO TOP
                loc_lSucesso = .T.
            ENDIF

            *-- Indexa dbRelatorio para processamento posterior
            SELECT dbRelatorio
            INDEX ON Ordems                                              TAG Ordems
            INDEX ON Grupos                                              TAG Grupos
            INDEX ON cOrdBals + STR(Ordems, 3)                          TAG cOrdBals
            INDEX ON PADR(ALLTRIM(Classes),10,"0")+Grupos+Ps+Contas+sContas TAG Classes
            INDEX ON STR(Ordems,3)+PADR(ALLTRIM(Classes),10,"0")+cOrdBals+Grupos+Ps+Contas+SContas TAG Classes2
            INDEX ON STR(Ordems, 3) + Ps + Grupos + Contas + SContas    TAG dRecno

            *-- Insere grupos/classes sem transacoes (de crSigCdMri)
            SELECT crSigCdMri
            SET ORDER TO "" IN crSigCdMri
            SCAN
                IF crSigCdMri.Balancos = loc_cDmr AND ;
                   (!SEEK(crSigCdMri.Grupos, "dbRelatorio", "Grupos") OR crSigCdMri.TpRegs = 2)
                    SEEK crSigCdMri.Grupos  ORDER TAG Codigos IN crSigCdGcr
                    SEEK crSigCdMri.Classes ORDER TAG Classes IN crSigCdCss
                    INSERT INTO dbRelatorio (Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
                        Contas, Ds_contas, Valor, Moedas, Operacaos, Analiticos, Nivels, ;
                        Ps, cOrdBals, Fators, DescClasse, Titulos) ;
                        VALUES (crSigCdMri.Ordems, PADR(crSigCdMri.Classes, 10), crSigCdCss.Descrs, ;
                            crSigCdMri.Grupos, crSigCdMri.DescGrps, SPACE(10), SPACE(40), ;
                            0, loc_cMoe, crSigCdMri.Operacaos, 2, crSigCdCss.Nivels, ;
                            IIF(crSigCdMri.TpRegs = 1, "5", "6"), ;
                            SPACE(10), crSigCdMri.Fators, crSigCdCss.Descrs, crSigCdMri.Titulos)
                ENDIF
            ENDSCAN

            SELECT crSigCdMri
            SET ORDER TO "" IN crSigCdMri
            GO TOP

            *-- Monta totais de grupos (Ps='4') para grupos analiticos
            SELECT dbRelatorio
            SET ORDER TO "" IN dbRelatorio
            GO TOP IN dbRelatorio
            DO WHILE !EOF("dbRelatorio")
                IF dbRelatorio.Ps = "5" AND dbRelatorio.Analiticos = 1
                    SCATTER MEMVAR FIELDS Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
                        Moedas, Operacaos, Analiticos, Nivels, cOrdBals, DescClasse
                    m.lnRec1    = RECNO("dbRelatorio")
                    m.Contas    = dbRelatorio.Grupos
                    m.Ds_contas = dbRelatorio.Ds_grupos
                    m.Valor     = 0
                    m.lnValor   = dbRelatorio.Valor
                    m.Ps        = "4"
                    m.Fators    = dbRelatorio.Fators
                    m.DescClasse = dbRelatorio.DescClasse
                    m.Titulos   = dbRelatorio.Titulos
                    IF !SEEK(PADR(ALLTRIM(m.Classes),10,"0")+PADR(m.Grupos,10)+m.Ps+PADR(m.Contas,10), ;
                             "dbRelatorio", "Classes")
                        INSERT INTO dbRelatorio (Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
                            Titulos, Contas, Ds_contas, Valor, Moedas, Operacaos, ;
                            Analiticos, Nivels, Ps, cOrdBals, Fators, DescClasse) ;
                            VALUES (m.Ordems, m.Classes, m.Desctpgcs, m.Grupos, m.Ds_grupos, ;
                                m.Titulos, m.Contas, m.Ds_contas, m.Valor, ;
                                loc_cMoe, m.Operacaos, m.Analiticos, m.Nivels, ;
                                m.Ps, m.cOrdBals, m.Fators, m.DescClasse)
                    ENDIF
                    m.Valor = (dbRelatorio.Valor + m.lnValor)
                    GATHER MEMVAR FIELDS Valor
                    GO m.lnRec1 IN dbRelatorio
                ENDIF
                SKIP IN dbRelatorio
            ENDDO

            *-- Processa contrapartidas (Ps='5' analitico com cpartidas=1)
            SELECT dbRelatorio
            SET ORDER TO Ordems IN dbRelatorio
            GO TOP
            DO WHILE !EOF("dbRelatorio")
                IF dbRelatorio.Ps = "5" AND dbRelatorio.Analiticos = 1 AND ;
                   dbRelatorio.Cpartidas = 1 AND EMPTY(dbRelatorio.Scontas)
                    THIS.this_lContraPartida = .T.
                    SCATTER MEMVAR FIELDS Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
                        Moedas, Operacaos, Analiticos, Nivels, cOrdBals, DescClasse, Contas
                    m.lnRec1 = RECNO("dbRelatorio")
                    SELECT ContPart
                    SCAN FOR Grupos + Contas = m.Grupos + m.Contas
                        m.sContas    = ContPart.sContas
                        m.Ds_contas  = ContPart.Ds_Contas
                        m.Valor      = ContPart.Valor
                        m.lnValor    = ContPart.Valor
                        m.Ps         = "5"
                        m.Fators     = ContPart.Fators
                        m.DescClasse = ContPart.DescClasse
                        m.Titulos    = ContPart.Titulos
                        INSERT INTO dbRelatorio (Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
                            Titulos, Contas, Ds_contas, Valor, Moedas, Operacaos, ;
                            Analiticos, Nivels, Ps, cOrdBals, Fators, DescClasse, sContas, Valor) ;
                            VALUES (m.Ordems, m.Classes, m.Desctpgcs, m.Grupos, m.Ds_grupos, ;
                                m.Titulos, m.Contas, m.Ds_contas, m.Valor, ;
                                loc_cMoe, m.Operacaos, m.Analiticos, m.Nivels, ;
                                m.Ps, m.cOrdBals, m.Fators, m.DescClasse, m.sContas, m.Valor)
                    ENDSCAN
                    SELECT dbRelatorio
                    GO m.lnRec1 IN dbRelatorio
                ENDIF
                SKIP IN dbRelatorio
            ENDDO

            *-- Calcula dRecno para ordenacao final
            SELECT dbRelatorio
            =SEEK("", "dbRelatorio", "Classes")

            SELECT dbRelatorio
            SCAN
                SELECT crSigCdMri
                IF !EMPTY(dbRelatorio.Grupos)
                    IF dbRelatorio.Grupos <> "SubTotal"
                        SET ORDER TO Grupos
                        SEEK loc_cDmr + dbRelatorio.Grupos
                    ELSE
                        SET ORDER TO DescGrps
                        SEEK loc_cDmr + dbRelatorio.Ds_Grupos
                    ENDIF
                ELSE
                    SET ORDER TO Classes
                    SEEK loc_cDmr + dbRelatorio.Classes
                ENDIF
                SELECT dbRelatorio
                IF Ps = "4"
                    loc_lndRecno = (RECNO("crSigCdMri") * 10)
                ELSE
                    loc_lndRecno = (RECNO("crSigCdMri") * 10) + 1
                ENDIF
                REPLACE dRecno WITH loc_lndRecno
            ENDSCAN

            *-- Calcula total geral
            SELECT dbRelatorio
            SET ORDER TO dRecno
            m.Valor = 0
            SCAN
                IF !EMPTY(Scontas)
                    LOOP
                ENDIF
                IF dbRelatorio.Ps = "6"
                    GATHER MEMVAR FIELDS Valor
                ENDIF
                m.Valor = (m.Valor + IIF(!INLIST(dbRelatorio.Ps, "4", "6"), ;
                    (dbRelatorio.Valor * IIF(dbRelatorio.Operacaos = "-", -1, 1)), 0))
            ENDSCAN

            *-- =================== CALCULOS DE PREVISAO ===================
            IF loc_cPrevisao = "S"
                loc_lnTotPrevisao = 0
                loc_lnVlrPrev     = 0
                loc_lnCot2 = THIS.CarregarCambio(loc_cMoe, THIS.this_dDtFinal)
                loc_lnCot1 = THIS.CarregarCambio(loc_cMoedaOrc, THIS.this_dDtFinal)

                SELECT dbRelatorio
                GO TOP
                SCAN
                    IF dbRelatorio.Ps = "5" AND !EMPTY(dbRelatorio.Contas)
                        IF SEEK(dbRelatorio.Contas, "crPrevisao", "PrevCta")
                            loc_lnVlrPrev = crPrevisao.nValors * (loc_lnCot1 / loc_lnCot2)
                            REPLACE Previsao WITH loc_lnVlrPrev IN dbRelatorio
                            loc_lnTotPrevisao = loc_lnTotPrevisao + loc_lnVlrPrev
                        ENDIF
                    ENDIF
                    IF (dbRelatorio.Ps = "4" OR (dbRelatorio.Ps = "5" AND dbRelatorio.Analiticos = 2)) AND ;
                       !EMPTY(dbRelatorio.Grupos)
                        IF SEEK(dbRelatorio.Grupos, "crPrevisao", "PrevGrp")
                            loc_lnVlrPrev = crPrevisao.nValors * (loc_lnCot1 / loc_lnCot2)
                            REPLACE Previsao WITH loc_lnVlrPrev IN dbRelatorio
                            loc_lnTotPrevisao = loc_lnTotPrevisao + loc_lnVlrPrev
                        ENDIF
                    ENDIF
                ENDSCAN

                SELECT dbRelatorio
                SET ORDER TO dRecno
                GO TOP

                *-- Inserir contas sem realizado
                SELECT iClis, nValors FROM crPrevisao ;
                    WHERE iClis NOT IN (SELECT Contas FROM dbRelatorio) ;
                    INTO CURSOR crAdicionar READWRITE
                SELECT crAdicionar
                GO TOP
                SCAN
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT Grupos, rClis FROM SigCdCli WHERE iClis = " + EscaparSQL(crAdicionar.iClis), ;
                        "crGrupoCta")
                    IF loc_nResult > 0
                        SELECT cGrupos FROM dbRelatorio WHERE Grupos = crGrupoCta.Grupos ;
                            INTO CURSOR crAux READWRITE
                        SELECT crAux
                        IF !EOF("crAux")
                            SELECT dbRelatorio
                            GO TOP
                            LOCATE FOR Grupos = crGrupoCta.Grupos
                            IF !EOF()
                                SCATTER MEMVAR MEMO
                                m.Contas    = crAdicionar.iClis
                                m.Ds_Contas = crGrupoCta.rClis
                                m.Valor     = 0
                                m.Ps        = "5"
                                m.dRecno    = m.dRecno + 1
                                m.Previsao  = crAdicionar.nValors
                                m.PercPrev  = 0
                                m.PercGrp   = 0
                                INSERT INTO dbRelatorio FROM MEMVAR
                            ENDIF
                        ENDIF
                        IF USED("crAux")
                            USE IN crAux
                        ENDIF
                        IF USED("crGrupoCta")
                            USE IN crGrupoCta
                        ENDIF
                    ENDIF
                ENDSCAN
                IF USED("crAdicionar")
                    USE IN crAdicionar
                ENDIF

                *-- Totais dos grupos apos insercao
                SELECT Ordems, Grupos, Ds_Grupos FROM dbRelatorio WHERE Ps = "6" ;
                    INTO CURSOR crAux READWRITE
                SELECT crAux
                SCAN
                    SELECT NVL(SUM(Previsao), 0) AS TotPrev FROM dbRelatorio ;
                        WHERE Ordems < crAux.Ordems AND Ps <> "6" ;
                        INTO CURSOR crTot READWRITE
                    SELECT crTot
                    IF crTot.TotPrev <> 0
                        UPDATE dbRelatorio SET Previsao = crTot.TotPrev ;
                            WHERE Ps = "6" AND Grupos = crAux.Grupos AND ;
                            Ds_Grupos = crAux.Ds_Grupos
                    ENDIF
                    IF USED("crTot")
                        USE IN crTot
                    ENDIF
                ENDSCAN
                IF USED("crAux")
                    USE IN crAux
                ENDIF

                *-- Subtotal 100% e calculos de percentuais
                loc_lnTotOrcado   = -1
                loc_lnTotReal     = -1
                loc_lnRecTroca    = 0
                loc_lnPercFirstO  = 0
                loc_lnPercFirstR  = 0
                loc_lbFirst       = .T.

                SELECT dbRelatorio
                GO TOP
                SCAN
                    IF dbRelatorio.Ps = "6"
                        SELECT crSigCdMri
                        SET ORDER TO Grupos
                        SEEK loc_cDmr + dbRelatorio.Grupos + STR(dbRelatorio.Ordems, 3)
                        IF PEMSTATUS(crSigCdMri, "SubTot100s", 5) AND crSigCdMri.SubTot100s = 1
                            loc_lnTotOrcado = dbRelatorio.Previsao
                            loc_lnTotReal   = dbRelatorio.Valor
                            loc_lnRecTroca  = RECNO("dbRelatorio")
                            REPLACE PercPrev WITH 100, PercGrp WITH 100 IN dbRelatorio
                            EXIT
                        ENDIF
                    ENDIF
                ENDSCAN

                loc_lnTotOrcAux  = loc_lnTotOrcado
                loc_lnTotRealAux = loc_lnTotReal

                SELECT dbRelatorio
                GO TOP
                SCAN
                    IF RECNO("dbRelatorio") = loc_lnRecTroca
                        loc_lnTotOrcado = loc_lnTotOrcAux
                        loc_lnTotReal   = loc_lnTotRealAux
                        GO TOP IN dbRelatorio
                        REPLACE PercPrev WITH loc_lnPercFirstO, ;
                                PercGrp  WITH loc_lnPercFirstR IN dbRelatorio
                        GO loc_lnRecTroca IN dbRelatorio
                    ENDIF

                    IF dbRelatorio.Ps = "3"
                        loc_cQuery = "SELECT Sum(a.nValors) AS TotPrev FROM SigCdMrp a " + ;
                            "INNER JOIN SigCdCli b ON b.iClis = a.iClis " + ;
                            "INNER JOIN SigCdGcr c ON c.Codigos = b.Grupos " + ;
                            "WHERE c.Classes = " + EscaparSQL(dbRelatorio.Classes) + ;
                            " AND a.cEmps+a.cMes+a.cAno+a.cTitulo+a.Moeda IN " + loc_cOrcs + ;
                            " UNION ALL " + ;
                            "SELECT Sum(a.nValors) AS TotPrev FROM SigCdMrp a " + ;
                            "INNER JOIN SigCdGcr g ON g.Codigos = a.cGrupos " + ;
                            "WHERE g.Classes = " + EscaparSQL(dbRelatorio.Classes) + ;
                            " AND a.cEmps+a.cMes+a.cAno+a.cTitulo+a.Moeda IN " + loc_cOrcs
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crTmpPrev")
                        IF loc_nResult > 0
                            SELECT SUM(NVL(TotPrev, 0)) AS TotPrev FROM crTmpPrev ;
                                INTO CURSOR crTotPrev READWRITE
                            REPLACE Previsao WITH crTotPrev.TotPrev IN dbRelatorio
                            IF USED("crTotPrev")
                                USE IN crTotPrev
                            ENDIF
                        ENDIF
                        IF USED("crTmpPrev")
                            USE IN crTmpPrev
                        ENDIF
                    ENDIF

                    IF dbRelatorio.Ps = "4"
                        SELECT NVL(SUM(a.Previsao), 0) AS TotPrev FROM dbRelatorio a ;
                            WHERE a.Ordems = dbRelatorio.Ordems AND ;
                                  a.Classes = dbRelatorio.Classes AND ;
                                  a.Grupos = dbRelatorio.Grupos AND ;
                                  a.Ps = "5" ;
                            INTO CURSOR crTotPrev READWRITE
                        SELECT crTotPrev
                        IF crTotPrev.TotPrev <> 0
                            REPLACE Previsao WITH Previsao + crTotPrev.TotPrev IN dbRelatorio
                        ENDIF
                        IF USED("crTotPrev")
                            USE IN crTotPrev
                        ENDIF
                    ENDIF

                    IF dbRelatorio.Ps = "5" AND dbRelatorio.Analiticos = 2
                        SELECT NVL(SUM(a.Previsao), 0) AS TotPrev, ;
                               SUM(a.Valor) AS TotReal FROM dbRelatorio a ;
                            WHERE a.Ordems = dbRelatorio.Ordems AND ;
                                  a.Classes = dbRelatorio.Classes AND ;
                                  a.Grupos = dbRelatorio.Grupos AND ;
                                  a.Ps = "5" ;
                            INTO CURSOR crTotPrev READWRITE
                        REPLACE PercGrp  WITH IIF(loc_lnTotReal <> 0, ;
                                    ROUND((ABS(crTotPrev.TotReal)/ABS(loc_lnTotReal))*100,2),0), ;
                                PercPrev WITH IIF(loc_lnTotOrcado <> 0, ;
                                    ROUND((ABS(crTotPrev.TotPrev)/ABS(loc_lnTotOrcado))*100,2),0) ;
                            IN dbRelatorio
                        IF USED("crTotPrev")
                            USE IN crTotPrev
                        ENDIF
                    ELSE
                        REPLACE PercGrp  WITH IIF(loc_lnTotReal <> 0, ;
                                    ROUND((ABS(Valor)/ABS(loc_lnTotReal))*100,2),0), ;
                                PercPrev WITH IIF(loc_lnTotOrcado <> 0, ;
                                    ROUND((ABS(Previsao)/ABS(loc_lnTotOrcado))*100,2),0) ;
                            IN dbRelatorio
                    ENDIF

                    IF dbRelatorio.Ps = "5"
                        loc_lnPercFirstO = loc_lnPercFirstO + dbRelatorio.PercPrev
                        loc_lnPercFirstR = loc_lnPercFirstR + dbRelatorio.PercGrp
                    ENDIF

                    IF loc_lbFirst
                        loc_lnTotOrcado = dbRelatorio.Previsao
                        loc_lnTotReal   = dbRelatorio.Valor
                        loc_lbFirst     = .F.
                    ENDIF
                ENDSCAN
            ENDIF

            *-- Atualiza percentuais maximos
            IF USED("dbRelatorio")
                UPDATE dbRelatorio SET PercPrev = MIN(PercPrev, 999.99) WHERE PercPrev <> 0
                UPDATE dbRelatorio SET PercGrp  = MIN(PercGrp, 999.99)  WHERE PercGrp <> 0
                GO TOP
            ENDIF

            *-- Relatorio por empresa: cria cursor Tempo agrupado
            IF loc_llPep AND USED("dbRelatorio")
                SELECT Emps AS Empresas, PROPER(Titulos) AS Titulos, ;
                       SUM(Valor) AS Valores ;
                  FROM dbRelatorio ;
                 WHERE Ps <> "4" ;
                 GROUP BY 1, 2 ;
                  INTO CURSOR Tempo
                SELECT Tempo
                IF RECCOUNT("Tempo") < 1
                    SELECT dbRelatorio
                    GO TOP
                ENDIF
            ELSE
                IF EMPTY(loc_cEpr) AND USED("dbRelatorio")
                    UPDATE dbRelatorio SET Emps = ""
                ENDIF
            ENDIF

            *-- =================== MODO COMPARATIVO ===================
            IF THIS.this_lComparativo
                SELECT * FROM dbRelatorio INTO CURSOR crTmp READWRITE
                IF USED("dbRelatorio")
                    USE IN dbRelatorio
                ENDIF
                SELECT a.*, a.Valor AS VlrComp, 000.00 AS VarComp ;
                  FROM crTmp a ;
                  INTO CURSOR dbRelatorio READWRITE
                IF USED("crTmp")
                    USE IN crTmp
                ENDIF

                SELECT dbRelatorio
                INDEX ON Ordems                                              TAG Ordems
                INDEX ON Grupos                                              TAG Grupos
                INDEX ON cOrdBals + STR(Ordems, 3)                          TAG cOrdBals
                INDEX ON PADR(ALLTRIM(Classes),10,"0")+Grupos+Ps+Contas+sContas TAG Classes
                INDEX ON STR(Ordems,3)+PADR(ALLTRIM(Classes),10,"0")+cOrdBals+Grupos+Ps+Contas+SContas TAG Classes2
                INDEX ON STR(Ordems,3)+Ps+Grupos+Contas+SContas             TAG dRecno
                SET ORDER TO dRecno

                SELECT dbCompara
                INDEX ON Classes + Grupos + ds_Grupos + Contas TAG skGroup

                SELECT dbRelatorio
                GO TOP IN dbRelatorio
                SCAN
                    IF SEEK(dbRelatorio.Classes+dbRelatorio.Grupos+ ;
                            dbRelatorio.ds_Grupos+dbRelatorio.Contas, ;
                            "dbCompara", "skGroup") AND dbCompara.Valor <> 0
                        REPLACE VlrComp WITH dbCompara.Valor IN dbRelatorio
                        REPLACE VarComp WITH ROUND(((Valor/VlrComp)-1)*100, 2) IN dbRelatorio
                    ELSE
                        REPLACE VlrComp WITH 0, VarComp WITH 0 IN dbRelatorio
                    ENDIF
                    IF dbRelatorio.VarComp = 0
                        IF dbRelatorio.Valor = 0 AND dbRelatorio.VlrComp > 0
                            REPLACE VarComp WITH -100 IN dbRelatorio
                        ELSE
                            IF dbRelatorio.Valor > 0 AND dbRelatorio.VlrComp = 0
                                REPLACE VarComp WITH 100 IN dbRelatorio
                            ENDIF
                        ENDIF
                    ENDIF
                ENDSCAN

                *-- Adiciona registros do comparativo que nao existem no atual
                SELECT * FROM dbCompara ;
                    WHERE Classes+Grupos+ds_Grupos+Contas NOT IN ;
                    (SELECT Classes+Grupos+ds_Grupos+Contas FROM dbRelatorio) ;
                    INTO CURSOR crAdiciona READWRITE
                SELECT crAdiciona
                SCAN
                    SCATTER MEMVAR MEMO
                    m.VlrComp = m.Valor
                    m.Valor   = 0
                    m.VarComp = 0
                    INSERT INTO dbRelatorio FROM MEMVAR
                ENDSCAN
                IF USED("crAdiciona")
                    USE IN crAdiciona
                ENDIF

                *-- Recalcula dRecno para novos registros
                SELECT dbRelatorio
                =SEEK("", "dbRelatorio", "Classes")
                SELECT dbRelatorio
                SCAN
                    SELECT crSigCdMri
                    IF !EMPTY(dbRelatorio.Grupos)
                        IF dbRelatorio.Grupos <> "SubTotal"
                            SET ORDER TO Grupos
                            SEEK loc_cDmr + dbRelatorio.Grupos
                        ELSE
                            SET ORDER TO DescGrps
                            SEEK loc_cDmr + dbRelatorio.Ds_Grupos
                        ENDIF
                    ELSE
                        SET ORDER TO Classes
                        SEEK loc_cDmr + dbRelatorio.Classes
                    ENDIF
                    SELECT dbRelatorio
                    IF Ps = "4"
                        loc_lndRecno = (RECNO("crSigCdMri") * 10)
                    ELSE
                        loc_lndRecno = (RECNO("crSigCdMri") * 10) + 1
                    ENDIF
                    REPLACE dRecno WITH loc_lndRecno
                ENDSCAN
                SELECT dbRelatorio
                SET ORDER TO dRecno
            ENDIF

            *-- Normaliza empresa no dbRelatorio
            loc_lcEmps = ""
            LOCAL loc_llEmps
            loc_llEmps = .F.
            SELECT csSigCdEmp
            SCAN
                IF Imps = 1
                    IF !loc_llEmps
                        loc_lcEmps = csSigCdEmp.cEmps
                        loc_llEmps = .T.
                    ELSE
                        loc_lcEmps = ""
                    ENDIF
                ENDIF
            ENDSCAN
            SELECT dbRelatorio
            REPLACE ALL Emps WITH loc_lcEmps FOR EMPTY(Emps)
            GO TOP

            *-- =================== CONTRAPARTIDA EXPANDIDA ===================
            IF THIS.this_nContrapartida = 2
                SELECT * FROM dbRelatorio WHERE 0 = 1 INTO CURSOR TmpRelat1 READWRITE
                SELECT dbRelatorio
                SCAN
                    SCATTER MEMVAR MEMO
                    SELECT cBalCP
                    SCAN FOR (cBalCP.Grupos = dbRelatorio.Grupos) AND ;
                              (cBalCP.Contas = dbRelatorio.Contas)
                        m.Valor   = cBalCP.Valors
                        m.Scontas = cBalCP.SContas
                        m.ContEms = cBalCP.ContEms
                        INSERT INTO TmpRelat1 FROM MEMVAR
                    ENDSCAN
                ENDSCAN

                SELECT TmpRelat1
                SCAN
                    SCATTER MEMVAR MEMO
                    INSERT INTO dbRelatorio FROM MEMVAR
                    IF !EMPTY(dbRelatorio.SContas)
                        loc_nResult = SQLEXEC(gnConnHandle, ;
                            "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + ;
                            EscaparSQL(dbRelatorio.SContas), "TmpCli")
                        IF loc_nResult > 0
                            SELECT TmpCli
                            GO TOP
                            IF !EOF()
                                REPLACE Ds_SContas WITH TmpCli.RClis IN dbRelatorio
                            ENDIF
                        ENDIF
                    ENDIF
                    IF !EMPTY(dbRelatorio.ContEms)
                        loc_nResult = SQLEXEC(gnConnHandle, ;
                            "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + ;
                            EscaparSQL(dbRelatorio.ContEms), "TmpCli")
                        IF loc_nResult > 0
                            SELECT TmpCli
                            GO TOP
                            IF !EOF()
                                REPLACE ds_ContEms WITH TmpCli.RClis IN dbRelatorio
                            ENDIF
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

            *-- Trata contas transit?rias de contrapartida (crSigCdPam)
            SELECT dbRelatorio
            SCAN
                IF INLIST(dbRelatorio.SContas, ;
                          ALLTRIM(crSigCdPam.ContaPags), ;
                          ALLTRIM(crSigCdPam.ContaRecs))
                    REPLACE SContas WITH Contas IN dbRelatorio
                ENDIF
            ENDSCAN

            *-- Busca descricao de SContas
            SELECT dbRelatorio
            SCAN
                IF !EMPTY(dbRelatorio.SContas)
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + ;
                        EscaparSQL(dbRelatorio.SContas), "TmpCli")
                    IF loc_nResult < 1
                        THIS.this_cMensagemErro = "Falha ao buscar descri" + CHR(231) + CHR(227) + "o de scontas"
                        MsgErro(THIS.this_cMensagemErro, "sigredtvBO.PrepararDados")
                        loc_lSucesso = .F.
                    ENDIF
                    SELECT TmpCli
                    GO TOP IN TmpCli
                    IF !EOF("TmpCli")
                        REPLACE Ds_SContas WITH TmpCli.RClis IN dbRelatorio
                    ENDIF
                ENDIF
            ENDSCAN

            SELECT dbRelatorio
            GO TOP

            *-- Restaura configuracoes de SET
            SET ESCAPE &loc_cEscape.
            SET DECIMALS TO m.loc_nDecimals
            SET FIXED &loc_cFixed.

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredtvBO.PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararComparativo - Monta cursor dbCompara para modo comparativo
    * Equivalente ao PROCEDURE proccomp do sistema legado
    * par_cEpr    = Empresas IN clause ex: "('001','002')"
    * par_cMoe    = Codigo da moeda
    * par_cDtIni  = Data inicial formatada para SQL
    * par_cDtFim  = Data final formatada para SQL (com 23:59:59)
    * par_lPep    = Relatorio por empresa (.T./.F.)
    * par_cDem    = Codigo do demonstrativo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararComparativo(par_cEpr, par_cMoe, par_cDtIni, par_cDtFim, par_lPep, par_cDem)
        LOCAL loc_lSucesso, loc_oErro, loc_cQuery, loc_nResult, loc_nTpDat
        LOCAL loc_lnCot1, loc_lnCot2, loc_cGroup, loc_lnRec1, loc_lnValor
        LOCAL loc_lnOperacao, loc_lndRecno, loc_lcClaAnt
        PRIVATE pDcI, pDcF

        loc_lSucesso = .F.
        TRY
            IF USED("crTmpMccr")
                USE IN crTmpMccr
            ENDIF

            WAIT WINDOW "Aguarde!!! Selecionando Movimenta" + CHR(231) + CHR(245) + "es do Comparativo..." NOWAIT

            loc_nTpDat = THIS.this_nTipoDatas
            pDcI = THIS.this_dCompInicial
            pDcF = THIS.this_dCompFinal

            *-- SQL para movimentos do periodo comparativo
            loc_cQuery = "SELECT a.Grupos, a.Contas, " + ;
                IIF(loc_nTpDat = 1, "a.DtEmis ", ;
                IIF(loc_nTpDat = 2, "a.Datas ", ;
                IIF(loc_nTpDat = 3, "a.Vencs ", ;
                IIF(loc_nTpDat = 4, ;
                    "case when f.Datarcs Is Null then h.Datarcs else f.Datarcs end ", ;
                    "Case When c.TpDatas = 1 Then a.DtEmis Else Case When c.TpDatas = 2 " + ;
                    "Then a.Datas Else Case When c.TpDatas in (0,3) Then a.Vencs " + ;
                    "Else case when f.Datarcs Is Null then h.Datarcs else f.Datarcs end " + ;
                    "End End End ")))) + ;
                "AS Datas, a.Valors, a.Svalors, a.Moedas, a.Smoedas, " + ;
                "a.Cotacaos, a.Scotacaos, a.Opers, a.Emps, a.Scontas, a.ContEms, a.cIdChaves, " + ;
                "e.Acertos, e.Cotacaos AS CotAcertos, c.TpDatas, a.EmpCcs " + ;
                "FROM SigMvCcr a " + ;
                "INNER JOIN SigCdMri c ON a.Grupos = c.Grupos " + ;
                "INNER JOIN SigCdGcr b ON a.Grupos = b.Codigos " + ;
                "LEFT JOIN SigCdPit e ON a.nOpers = e.nOpers AND a.Emps = e.EmpOs " + ;
                "LEFT JOIN SigCdPgr f ON e.Empdopnums = f.Empdopnums " + ;
                "INNER JOIN SigCdCss d ON b.Classes = d.Classes " + ;
                "WHERE c.Balancos = " + EscaparSQL(par_cDem) + " AND " + ;
                IIF(loc_nTpDat = 1, "a.DtEmis BETWEEN " + par_cDtIni + " AND " + par_cDtFim + " ", ;
                IIF(loc_nTpDat = 2, "a.Datas BETWEEN " + par_cDtIni + " AND " + par_cDtFim + " ", ;
                IIF(loc_nTpDat = 3, "a.Vencs BETWEEN " + par_cDtIni + " AND " + par_cDtFim + " ", ;
                IIF(loc_nTpDat = 4, ;
                    "case when f.Datarcs Is Null then h.Datarcs else f.Datarcs end " + ;
                    "BETWEEN " + par_cDtIni + " AND " + par_cDtFim + " ", ;
                    "(Case When c.TpDatas = 1 And a.DtEmis BETWEEN " + par_cDtIni + " AND " + par_cDtFim + " Then 1 Else " + ;
                    "Case When c.TpDatas = 2 And a.Datas BETWEEN " + par_cDtIni + " AND " + par_cDtFim + " Then 1 Else " + ;
                    "Case When c.TpDatas in (0,3) And a.Vencs BETWEEN " + par_cDtIni + " AND " + par_cDtFim + " Then 1 Else " + ;
                    "Case When c.TpDatas = 4 And f.datarcs BETWEEN " + par_cDtIni + " AND " + par_cDtFim + " Then 1 Else 0 " + ;
                    "End End End End) = 1 ")))) + ;
                IIF(EMPTY(par_cEpr), "", ;
                    "AND (Case When a.EmpCcs <> '' And a.EmpCcs IN " + par_cEpr + " Then 1 Else " + ;
                    "Case When a.EmpCcs = '' And a.Emps IN " + par_cEpr + " Then 1 Else 0 End End) = 1 ") + ;
                IIF(THIS.this_nSnt = 3, "", ;
                    IIF(THIS.this_nSnt = 1, "AND Not a.NFs = '          ' ", "AND a.NFs = '          ' ")) + ;
                "ORDER BY a.Grupos, a.Contas, 3, a.Valors, a.Svalors, a.Moedas, a.Smoedas, " + ;
                "a.Cotacaos, a.Scotacaos, a.Opers, a.Emps, a.Scontas, a.cIdChaves"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "TmpBalC")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao selecionar comparativo (TmpBalC)"
                MsgErro(THIS.this_cMensagemErro, "sigredtvBO.PrepararComparativo")
                loc_lSucesso = .F.
            ENDIF
            WAIT CLEAR

            *-- Distincts de TmpBalC ? cBalC
            SELECT DISTINCT Grupos, Contas, NVL(Datas, CTOT(SPACE(08))) AS Datas, ;
                Valors, Svalors, Moedas, Smoedas, Cotacaos, Scotacaos, Opers, ;
                IIF(!EMPTY(EmpCcs), EmpCcs, Emps) AS Emps, ;
                Scontas, ContEms, cIdChaves, TpDatas ;
              FROM TmpBalC ;
              INTO CURSOR cBalC READWRITE

            IF !USED("cBalC") OR RECCOUNT("cBalC") = 0
                SELECT cBalC
                GO TOP
                loc_lSucesso = .T.
            ENDIF

            *-- Conversao de moeda em cBalC
            loc_lnCot2 = THIS.CarregarCambio(par_cMoe, THIS.this_dCompFinal)

            SELECT cBalC
            SCAN
                SCATTER MEMVAR FIELDS Valors, Moedas
                IF loc_nTpDat = 4 OR (loc_nTpDat = 5 AND INLIST(cBalC.TpDatas, 4))
                    m.Valors  = 0
                    m.Acertos = 0
                    SELECT TmpBalC
                    SCAN FOR cIdChaves = cBalC.cIdChaves
                        m.Acertos = TmpBalC.Acertos
                        IF !cBalC.Moedas = par_cMoe
                            IF THIS.this_nCotacao = 1
                                loc_lnCot1 = THIS.CarregarCambio(cBalC.Moedas, THIS.this_dCompFinal)
                            ELSE
                                loc_lnCot1 = IIF(TmpBalC.CotAcertos <> 0, TmpBalC.CotAcertos, THIS.CarregarCambio(cBalC.Moedas, TTOD(cBalC.Datas)))
                                loc_lnCot2 = THIS.CarregarCambio(par_cMoe, TTOD(cBalC.Datas))
                            ENDIF
                            m.Acertos = (TmpBalC.Acertos * loc_lnCot1 / loc_lnCot2)
                            m.Moedas  = par_cMoe
                        ENDIF
                        m.Valors = m.Valors + m.Acertos
                    ENDSCAN
                ELSE
                    IF !cBalC.Moedas = par_cMoe
                        IF THIS.this_nCotacao = 1
                            loc_lnCot1 = THIS.CarregarCambio(cBalC.Moedas, THIS.this_dCompFinal)
                        ELSE
                            loc_lnCot1 = IIF(cBalC.Moedas <> cBalC.SMoedas, cBalC.Cotacaos, THIS.CarregarCambio(cBalC.Moedas, TTOD(cBalC.Datas)))
                            loc_lnCot2 = THIS.CarregarCambio(par_cMoe, TTOD(cBalC.Datas))
                        ENDIF
                        IF cBalC.Smoedas = par_cMoe AND THIS.this_nCotacao = 2
                            m.Valors = cBalC.Svalors
                        ELSE
                            m.Valors = (cBalC.Valors * loc_lnCot1 / loc_lnCot2)
                        ENDIF
                    ENDIF
                ENDIF
                SELECT cBalC
                m.Moedas = par_cMoe
                GATHER MEMVAR FIELDS Valors, Moedas
            ENDSCAN

            loc_cGroup = IIF(par_lPep, "19, 2", "2")

            *-- Cursor de grupos (Ps='3') do comparativo
            SELECT d.Ordems, d.Classes AS Classes, e.Descrs AS Desctpgcs, ;
                d.Grupos, d.DescGrps AS Ds_grupos, SPACE(10) AS Contas, ;
                SPACE(50) AS Ds_contas, ;
                VAL(STR(SUM(a.Valors * IIF(a.Opers == "D", 1, -1)), 16, 2)) * d.Fators / 100 AS Valor, ;
                a.Moedas, d.Operacaos, d.Analiticos, e.Nivels, e.Descrs AS DescClasse, ;
                "3" AS Ps, SPACE(10) AS cOrdBals, d.fators, 0000000000 AS dRecno, ;
                d.Titulos, IIF(par_lPep, a.Emps, "   ") AS Emps, SPACE(10) AS Scontas, ;
                d.cpartidas, 0000000000000.00 AS Previsao, ;
                0000.00 AS PercPrev, 0000.00 AS PercGrp ;
              FROM cBalC a, crSigCdGcr b, crSigCdMri d, crSigCdCss e ;
             WHERE d.Balancos == par_cDem AND d.TpRegs == 3 AND ;
                   LEFT(b.Classes, LEN(ALLTRIM(d.Classes))) = ALLTRIM(d.Classes) AND ;
                   b.Codigos == a.Grupos AND e.Classes == d.Classes ;
             GROUP BY 1,2,3,4,5,6,7,9,10,11,12,13,14,15,16,17,18,19,20,21 ;
             ORDER BY 1, 2, 4, 6 ;
              INTO CURSOR cBal4C

            *-- Cursor de contas (Ps='5') do comparativo
            SELECT d.Ordems, b.Classes AS Classes, e.Descrs AS Desctpgcs, ;
                a.Grupos, d.DescGrps AS Ds_grupos, a.Contas, SPACE(50) AS Ds_contas, ;
                VAL(STR(SUM(a.Valors * IIF(a.Opers == "D", 1, -1)), 16, 2)) * d.Fators / 100 AS Valor, ;
                a.Moedas, d.Operacaos, d.Analiticos, e.Nivels, e.Descrs AS DescClasse, ;
                "5" AS Ps, SPACE(10) AS cOrdBals, d.fators, 0000000000 AS dRecno, ;
                d.Titulos, IIF(par_lPep, a.Emps, "   ") AS Emps, SPACE(10) AS Scontas, ;
                d.cpartidas, 0000000000000.00 AS Previsao, ;
                0000.00 AS PercPrev, 0000.00 AS PercGrp ;
              FROM cBalC a, crSigCdGcr b, crSigCdMri d, crSigCdCss e ;
             WHERE d.Balancos == par_cDem AND d.Grupos == a.Grupos AND ;
                   !d.TpRegs == 2 AND !d.TpRegs == 3 AND ;
                   b.Codigos == a.Grupos AND e.Classes == b.Classes ;
             GROUP BY 1,2,3,4,5,6,7,9,10,11,12,13,14,15,16,17,18,19,20,21 ;
             ORDER BY 1, 2, 4, 6 ;
              INTO CURSOR cBal3C

            *-- Cursor de contrapartida do comparativo
            SELECT d.Ordems, b.Classes AS Classes, e.Descrs AS Desctpgcs, ;
                a.Grupos, d.DescGrps AS Ds_grupos, a.Contas, a.Scontas, ;
                SPACE(50) AS Ds_contas, ;
                VAL(STR(SUM(a.Valors * IIF(a.Opers == "D", 1, -1)), 16, 2)) * d.Fators / 100 AS Valor, ;
                a.Moedas, d.Operacaos, d.Analiticos, e.Nivels, e.Descrs AS DescClasse, ;
                "7" AS Ps, SPACE(10) AS cOrdBals, d.fators, 0000000000 AS dRecno, ;
                d.Titulos, a.Emps ;
              FROM cBalC a, crSigCdGcr b, crSigCdMri d, crSigCdCss e ;
             WHERE d.Balancos == par_cDem AND d.Grupos == a.Grupos AND ;
                   !d.TpRegs == 2 AND !d.TpRegs == 3 AND ;
                   b.Codigos == a.Grupos AND e.Classes == b.Classes ;
             GROUP BY 1,2,3,4,5,6,7,8,10,11,12,13,14,15,16,17,18,19,20 ;
             ORDER BY 1, 2, 4, 6, 7 ;
              INTO CURSOR ContPartC

            *-- Une cBal3C + cBal4C ? dbCompara
            SELECT a.* FROM cBal3C a ;
             UNION ;
            SELECT b.* FROM cBal4C b ;
              INTO CURSOR dbCompara READWRITE

            IF !USED("dbCompara") OR RECCOUNT("dbCompara") = 0
                SELECT cBalC
                GO TOP
                loc_lSucesso = .T.
            ENDIF

            *-- Busca descricao de contas em SigCdCli
            WAIT WINDOW "Aguarde!!! Analisando Registros do Comparativo..." NOWAIT
            SELECT dbCompara
            GO TOP
            SCAN
                loc_cQuery = "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + ;
                             EscaparSQL(IIF(dbCompara.Ps = "7", dbCompara.sContas, dbCompara.Contas))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "TmpCli")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao buscar descri" + CHR(231) + CHR(227) + "o (TmpCli) no comparativo"
                    MsgErro(THIS.this_cMensagemErro, "sigredtvBO.PrepararComparativo")
                    loc_lSucesso = .F.
                ENDIF
                SELECT TmpCli
                GO TOP
                IF !EOF()
                    REPLACE Ds_Contas WITH TmpCli.RClis IN dbCompara
                ENDIF
                SELECT dbCompara
            ENDSCAN
            WAIT CLEAR

            *-- Indexa dbCompara
            SELECT dbCompara
            INDEX ON Ordems                                              TAG Ordems
            INDEX ON Grupos                                              TAG Grupos
            INDEX ON cOrdBals + STR(Ordems, 3)                          TAG cOrdBals
            INDEX ON PADR(ALLTRIM(Classes),10,"0")+Grupos+Ps+Contas+sContas TAG Classes
            INDEX ON STR(Ordems,3)+PADR(ALLTRIM(Classes),10,"0")+cOrdBals+Grupos+Ps+Contas+SContas TAG Classes2
            INDEX ON STR(Ordems,3)+Ps+Grupos+Contas+SContas             TAG dRecno

            *-- Insere grupos/classes sem transacoes
            loc_lcClaAnt = SPACE(10)
            SELECT crSigCdMri
            SET ORDER TO "" IN crSigCdMri
            SCAN
                IF crSigCdMri.Balancos = par_cDem AND ;
                   (!SEEK(crSigCdMri.Grupos, "dbCompara", "Grupos") OR crSigCdMri.TpRegs = 2)
                    SEEK crSigCdMri.Grupos  ORDER TAG Codigos IN crSigCdGcr
                    SEEK crSigCdMri.Classes ORDER TAG Classes IN crSigCdCss
                    INSERT INTO dbCompara (Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
                        Contas, Ds_contas, Valor, Moedas, Operacaos, Analiticos, Nivels, ;
                        Ps, cOrdBals, Fators, DescClasse, Titulos) ;
                        VALUES (crSigCdMri.Ordems, PADR(crSigCdMri.Classes, 10), crSigCdCss.Descrs, ;
                            crSigCdMri.Grupos, crSigCdMri.DescGrps, SPACE(10), SPACE(40), ;
                            0, par_cMoe, crSigCdMri.Operacaos, 2, crSigCdCss.Nivels, ;
                            IIF(crSigCdMri.TpRegs = 1, "5", "6"), ;
                            SPACE(10), crSigCdMri.Fators, crSigCdCss.Descrs, crSigCdMri.Titulos)
                ENDIF
                SEEK crSigCdMri.Grupos + IIF(crSigCdMri.TpRegs = 1, "", CHR(255)) ORDER TAG Codigos IN crSigCdGcr
                loc_lcClaAnt = crSigCdGcr.Classes
            ENDSCAN

            SELECT crSigCdMri
            SET ORDER TO "" IN crSigCdMri
            GO TOP

            *-- Monta totais de grupos (Ps='4') no dbCompara
            SELECT dbCompara
            SET ORDER TO "" IN dbCompara
            GO TOP IN dbCompara
            m.Valor = 0
            DO WHILE !EOF("dbCompara")
                IF dbCompara.Ps = "5" AND dbCompara.Analiticos = 1
                    SCATTER MEMVAR FIELDS Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
                        Moedas, Operacaos, Analiticos, Nivels, cOrdBals, DescClasse
                    loc_lnRec1   = RECNO("dbCompara")
                    m.Contas     = dbCompara.Grupos
                    m.Ds_contas  = dbCompara.Ds_grupos
                    m.Valor      = 0
                    m.lnValor    = dbCompara.Valor
                    m.Ps         = "4"
                    m.Fators     = dbCompara.Fators
                    m.DescClasse = dbCompara.DescClasse
                    m.Titulos    = dbCompara.Titulos
                    IF !SEEK(PADR(ALLTRIM(m.Classes),10,"0")+PADR(m.Grupos,10)+m.Ps+PADR(m.Contas,10), ;
                             "dbCompara", "Classes")
                        INSERT INTO dbCompara (Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
                            Titulos, Contas, Ds_contas, Valor, Moedas, Operacaos, ;
                            Analiticos, Nivels, Ps, cOrdBals, Fators, DescClasse) ;
                            VALUES (m.Ordems, m.Classes, m.Desctpgcs, m.Grupos, m.Ds_grupos, ;
                                m.Titulos, m.Contas, m.Ds_contas, m.Valor, ;
                                par_cMoe, m.Operacaos, m.Analiticos, m.Nivels, ;
                                m.Ps, m.cOrdBals, m.Fators, m.DescClasse)
                    ENDIF
                    m.Valor = (dbCompara.Valor + m.lnValor)
                    GATHER MEMVAR FIELDS Valor
                    GO loc_lnRec1 IN dbCompara
                ENDIF
                SKIP IN dbCompara
            ENDDO

            *-- Processa contrapartidas do dbCompara
            SELECT dbCompara
            SET ORDER TO Ordems IN dbCompara
            GO TOP
            DO WHILE !EOF("dbCompara")
                IF dbCompara.Ps = "5" AND dbCompara.Analiticos = 1 AND ;
                   dbCompara.Cpartidas = 1 AND EMPTY(dbCompara.Scontas)
                    SCATTER MEMVAR FIELDS Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
                        Moedas, Operacaos, Analiticos, Nivels, cOrdBals, DescClasse, Contas
                    loc_lnRec1 = RECNO("dbCompara")
                    SELECT ContPartC
                    SCAN FOR Grupos + Contas = m.Grupos + m.Contas
                        m.sContas    = ContPartC.sContas
                        m.Ds_contas  = ContPartC.Ds_Contas
                        m.Valor      = ContPartC.Valor
                        m.lnValor    = ContPartC.Valor
                        m.Ps         = "5"
                        m.Fators     = ContPartC.Fators
                        m.DescClasse = ContPartC.DescClasse
                        m.Titulos    = ContPartC.Titulos
                        INSERT INTO dbCompara (Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
                            Titulos, Contas, Ds_contas, Valor, Moedas, Operacaos, ;
                            Analiticos, Nivels, Ps, cOrdBals, Fators, DescClasse, sContas, Valor) ;
                            VALUES (m.Ordems, m.Classes, m.Desctpgcs, m.Grupos, m.Ds_grupos, ;
                                m.Titulos, m.Contas, m.Ds_contas, m.Valor, ;
                                par_cMoe, m.Operacaos, m.Analiticos, m.Nivels, ;
                                m.Ps, m.cOrdBals, m.Fators, m.DescClasse, m.sContas, m.Valor)
                    ENDSCAN
                    SELECT dbCompara
                    GO loc_lnRec1 IN dbCompara
                ENDIF
                SKIP IN dbCompara
            ENDDO

            *-- Calcula dRecno do dbCompara
            SELECT dbCompara
            =SEEK("", "dbCompara", "Classes")
            SELECT dbCompara
            SCAN
                SELECT crSigCdMri
                IF !EMPTY(dbCompara.Grupos)
                    IF dbCompara.Grupos <> "SubTotal"
                        SET ORDER TO Grupos
                        SEEK par_cDem + dbCompara.Grupos
                    ELSE
                        SET ORDER TO DescGrps
                        SEEK par_cDem + dbCompara.Ds_Grupos
                    ENDIF
                ELSE
                    SET ORDER TO Classes
                    SEEK par_cDem + dbCompara.Classes
                ENDIF
                SELECT dbCompara
                IF Ps = "4"
                    loc_lndDecno = (RECNO("crSigCdMri") * 10)
                ELSE
                    loc_lndDecno = (RECNO("crSigCdMri") * 10) + 1
                ENDIF
                REPLACE dRecno WITH loc_lndDecno
            ENDSCAN

            *-- Calcula totais do dbCompara
            SELECT dbCompara
            SET ORDER TO dRecno
            m.Valor = 0
            SCAN
                IF !EMPTY(Scontas)
                    LOOP
                ENDIF
                IF dbCompara.Ps = "6"
                    GATHER MEMVAR FIELDS Valor
                ENDIF
                m.Valor = (m.Valor + IIF(!INLIST(dbCompara.Ps, "4", "6"), ;
                    (dbCompara.Valor * IIF(dbCompara.Operacaos = "-", -1, 1)), 0))
            ENDSCAN

            SELECT dbCompara
            SET ORDER TO dRecno
            GO TOP

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredtvBO.PrepararComparativo")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio na tela (PREVIEW)
    * Equivalente ao PROCEDURE visualizacao do sistema legado
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro, loc_cFRX
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + ;
                    "vel preparar os dados do relat" + CHR(243) + "rio.", ;
                    "Demonstrativo")
            ELSE
                IF USED("Tempo") AND THIS.this_lComparativo
                    *-- Relatorio por empresa em modo comparativo
                ELSE
                    loc_cFRX = THIS.ObterNomeFRX()
                    REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredtvBO.Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime relatorio com dialogo de impressora (PROMPT)
    * Equivalente ao PROCEDURE impressao do sistema legado
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro, loc_cFRX
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + ;
                    "vel preparar os dados do relat" + CHR(243) + "rio.", ;
                    "Demonstrativo")
            ELSE
                loc_cFRX = THIS.ObterNomeFRX()
                REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredtvBO.Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirDocumento - Imprime sem dialogo (direto na impressora padrao)
    * Equivalente ao PROCEDURE documento do sistema legado
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirDocumento()
        LOCAL loc_lSucesso, loc_oErro, loc_cFRX
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + ;
                    "vel preparar os dados do relat" + CHR(243) + "rio.", ;
                    "Demonstrativo")
            ELSE
                loc_cFRX = THIS.ObterNomeFRX()
                REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredtvBO.ImprimirDocumento")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Compatibilidade com contrato de BOs de relatorio
    * Para relatorios, os filtros sao preenchidos via atribuicoes diretas
    * chamadas pelo Form.FormParaRelatorio()
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            IF TYPE(par_cAliasCursor + ".DtInicial") = "D"
                THIS.this_dDtInicial = NVL(EVALUATE(par_cAliasCursor + ".DtInicial"), DATE())
            ENDIF
            IF TYPE(par_cAliasCursor + ".DtFinal") = "D"
                THIS.this_dDtFinal = NVL(EVALUATE(par_cAliasCursor + ".DtFinal"), DATE())
            ENDIF
            IF TYPE(par_cAliasCursor + ".CodMoeda") = "C"
                THIS.this_cCodMoeda = NVL(EVALUATE(par_cAliasCursor + ".CodMoeda"), "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".Demonstrativo") = "C"
                THIS.this_cDemonstrativo = NVL(EVALUATE(par_cAliasCursor + ".Demonstrativo"), "")
            ENDIF
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.this_oDataAccess = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE
