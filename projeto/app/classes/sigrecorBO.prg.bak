*==============================================================================
* SIGRECORBO.PRG
* Business Object para Relatorio de Comissao por Vendedor (filtro PenPag)
*
* Herda de RelatorioBase
* Tabela principal: SigCdCmm
*==============================================================================

DEFINE CLASS sigrecorBO AS RelatorioBase

    *-- Filtros: periodo
    this_dDtInicial   = {}
    this_dDtFinal     = {}

    *-- Filtros: moeda
    this_cCdMoeda     = ""
    this_cDsMoeda     = ""

    *-- Filtros: grupo de estoque/contabilidade
    this_cCdGrEstoque = ""
    this_cDsGrEstoque = ""

    *-- Filtros: conta de estoque/contabilidade
    this_cCdEstoque   = ""
    this_cDsEstoque   = ""

    *-- Opcoes do relatorio
    *-- this_nOptTipo: 1=Analitico  2=Sintetico  3=Resumo
    this_nOptTipo     = 1

    *-- this_nOptSNA: 1=Sim  2=Nao  3=Ambos  (default=3)
    this_nOptSNA      = 3

    *-- this_nOptQuebras: 1=Datas  2=Data+Movimentacao  3=Cliente
    this_nOptQuebras  = 1

    *-- this_nOptPenPag: 0=Nao  1=Sim (PenPag: pagamento em aberto)
    this_nOptPenPag   = 0

    *-- Cursores de saida do relatorio
    this_cCursorAnalitico = "cursor_4c_Analitico"
    this_cCursorCabecalho = "cursor_4c_Cabecalho"

    *--------------------------------------------------------------------------
    * Init - Inicializa BO do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdCmm"
        THIS.this_cCampoChave = "EmpDopNums"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave logica do relatorio (filtros aplicados)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ALLTRIM(THIS.this_cTabela) + "|" + ;
                     DTOS(THIS.this_dDtInicial) + "|" + ;
                     DTOS(THIS.this_dDtFinal) + "|" + ;
                     ALLTRIM(THIS.this_cCdMoeda) + "|" + ;
                     ALLTRIM(THIS.this_cCdGrEstoque) + "|" + ;
                     ALLTRIM(THIS.this_cCdEstoque) + "|" + ;
                     STR(THIS.this_nOptTipo, 1) + "|" + ;
                     STR(THIS.this_nOptSNA, 1) + "|" + ;
                     STR(THIS.this_nOptQuebras, 1) + "|" + ;
                     STR(THIS.this_nOptPenPag, 1)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros do relatorio a partir de cursor
    * Permite restaurar configuracao de filtros salva previamente.
    * par_cAliasCursor: alias do cursor com colunas DtInicial, DtFinal,
    *   CdMoeda, DsMoeda, CdGrEstoque, DsGrEstoque, CdEstoque, DsEstoque,
    *   OptTipo, OptSNA, OptQuebras, OptPenPag
    *--------------------------------------------------------------------------
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
                IF TYPE(loc_cAlias + ".OptTipo") = "N"
                    THIS.this_nOptTipo = EVALUATE(loc_cAlias + ".OptTipo")
                ENDIF
                IF TYPE(loc_cAlias + ".OptSNA") = "N"
                    THIS.this_nOptSNA = EVALUATE(loc_cAlias + ".OptSNA")
                ENDIF
                IF TYPE(loc_cAlias + ".OptQuebras") = "N"
                    THIS.this_nOptQuebras = EVALUATE(loc_cAlias + ".OptQuebras")
                ENDIF
                IF TYPE(loc_cAlias + ".OptPenPag") = "N"
                    THIS.this_nOptPenPag = EVALUATE(loc_cAlias + ".OptPenPag")
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

    *--------------------------------------------------------------------------
    * Inserir - Registra execucao do relatorio em LogAuditoria
    * Para relatorios, "Inserir" significa registrar nova execucao,
    * permitindo rastrear quem rodou qual relatorio e quando.
    *--------------------------------------------------------------------------
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
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Registra reexecucao do relatorio em LogAuditoria
    * Para relatorios, "Atualizar" significa registrar uma reexecucao
    * (usuario alterou filtros e gerou o relatorio novamente).
    *--------------------------------------------------------------------------
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
    ENDFUNC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa dados do relatorio de Comissao por Vendedor
    * Replica logica do procedimento 'processamento' do legado SIGRECOR
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lResultado, loc_lErroNoScan, loc_oErro
        LOCAL loc_nResult, loc_cSQL
        LOCAL loc_cMoeda, loc_nCot1, loc_nCot
        LOCAL loc_cGrupo, loc_cConta, loc_cCdMoeda, loc_cDsMoeda
        LOCAL loc_nTip, loc_nOpt, loc_nPenPag
        LOCAL loc_cNmEmpresa, loc_cNmTitulo
        LOCAL loc_cCta, loc_cNvends
        LOCAL loc_nReg, loc_nValA, loc_nValR
        LOCAL loc_nComiAtual, loc_cHistPat, loc_cEdn

        loc_lResultado  = .F.
        loc_lErroNoScan = .F.

        TRY
            loc_cMoeda   = "AU"
            loc_nCot1    = THIS.BuscarCotacao(loc_cMoeda, DATE())
            loc_cGrupo   = PADR(THIS.this_cCdGrEstoque, 10)
            loc_cConta   = PADR(THIS.this_cCdEstoque, 10)
            loc_cCdMoeda = ALLTRIM(THIS.this_cCdMoeda)
            loc_cDsMoeda = ALLTRIM(THIS.this_cDsMoeda)
            loc_nTip     = THIS.this_nOptTipo
            loc_nOpt     = THIS.this_nOptSNA
            loc_nPenPag  = THIS.this_nOptPenPag

            *-- Busca nome da empresa
            loc_cNmEmpresa = ""
            loc_cSQL = "SELECT razas FROM SigCdEmp" + ;
                       " WHERE cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp")
            IF loc_nResult > 0
                SELECT cursor_4c_Emp
                GO TOP
                IF !EOF()
                    loc_cNmEmpresa = ALLTRIM(razas)
                ENDIF
                USE IN cursor_4c_Emp
            ENDIF

            *-- Monta titulo do relatorio
            loc_cNmTitulo = "Comiss" + CHR(227) + "o em " + PROPER(loc_cDsMoeda) + ;
                            " de " + DTOC(THIS.this_dDtInicial) + ;
                            " " + CHR(224) + " " + DTOC(THIS.this_dDtFinal) + " - " + ;
                            IIF(loc_nTip = 1, "Anal" + CHR(237) + "tico", ;
                                IIF(loc_nTip = 2, "Sint" + CHR(233) + "tico", "Resumido")) + ;
                            " - Op" + CHR(231) + CHR(227) + "o: " + ;
                            IIF(loc_nOpt = 1, "Sim", ;
                                IIF(loc_nOpt = 2, "N" + CHR(227) + "o", "Ambos"))

            *-- Cursor cabecalho
            IF USED("cursor_4c_Cabecalho")
                USE IN cursor_4c_Cabecalho
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Cabecalho (NomeEmpresa C(80), Titulo C(80))
            SET NULL OFF
            INSERT INTO cursor_4c_Cabecalho (NomeEmpresa, Titulo) ;
                VALUES (loc_cNmEmpresa, loc_cNmTitulo)

            *-- Cursor analitico de saida
            IF USED("cursor_4c_Analitico")
                USE IN cursor_4c_Analitico
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Analitico ;
                (Vends C(10), NVends C(50), Comis N(9,4), Valos N(12,4), ;
                 Datas D(8), EmpDopNums C(29), ContaDs C(10), RClis C(40), ;
                 Notas C(6), Dopes C(20), VlBaixas N(12,4), moedas C(3), ;
                 VlPago N(12,4), VlComi N(12,4), VlPagoR N(12,4), VlComiR N(12,4))
            SET NULL OFF

            *-- Indice conforme tipo e quebra de relatorio
            DO CASE
                CASE (loc_nTip = 1)
                    IF THIS.this_nOptQuebras <> 3
                        INDEX ON Vends + DTOS(Datas) + EmpDopNums + moedas TAG VendDatas
                    ELSE
                        INDEX ON Vends + RClis + moedas TAG VendDatas
                    ENDIF
                CASE (loc_nTip = 2)
                    INDEX ON Vends + moedas TAG VendDatas
                OTHERWISE
                    INDEX ON Vends + DTOS(Datas) + Dopes + moedas TAG VendDatas
            ENDCASE

            *-- Query principal em SigCdCmm com filtros de periodo/grupo/conta/moeda
            loc_cSQL = "SELECT * FROM SigCdCmm" + ;
                       " WHERE datas BETWEEN " + FormatarDataSQL(THIS.this_dDtInicial) + ;
                       " AND " + FormatarDataSQL(THIS.this_dDtFinal)
            IF !EMPTY(ALLTRIM(loc_cGrupo))
                loc_cSQL = loc_cSQL + " AND grupos = " + EscaparSQL(loc_cGrupo)
            ENDIF
            IF !EMPTY(ALLTRIM(loc_cConta))
                loc_cSQL = loc_cSQL + " AND contas = " + EscaparSQL(loc_cConta)
            ENDIF
            IF !EMPTY(loc_cCdMoeda)
                loc_cSQL = loc_cSQL + " AND moedas = " + EscaparSQL(loc_cCdMoeda)
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cmm")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados de comiss" + CHR(227) + "o"
                loc_lErroNoScan = .T.
            ENDIF

            *-- SCAN principal: processa cada registro de comissao
            IF !loc_lErroNoScan
                SELECT cursor_4c_Cmm
                SCAN WHILE !loc_lErroNoScan

                    *-- Busca cabecalho do movimento correspondente
                    loc_cSQL = "SELECT Emps, Dopes, Datas, Numes, Notas, Valos," + ;
                               " GrVends, Vends, EmpDopNums, ContaDs FROM SigMvCab" + ;
                               " WHERE EmpDopNums = " + ;
                               EscaparSQL(ALLTRIM(cursor_4c_Cmm.EmpDopNums)) + ;
                               " ORDER BY Emps, Dopes, Datas, Numes, Notas," + ;
                               " Valos, GrVends, Vends, EmpDopNums, ContaDs"
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCab")
                    IF loc_nResult < 0
                        THIS.this_cMensagemErro = "Erro ao buscar SigMvCab"
                        loc_lErroNoScan = .T.
                        EXIT
                    ENDIF

                    IF !EOF("cursor_4c_MvCab")
                        SELECT cursor_4c_Analitico
                        APPEND BLANK

                        *-- Busca descricao para ContaDs do movimento
                        loc_cSQL = "SELECT RClis FROM SigCdCli WHERE IClis = " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_MvCab.ContaDs))
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cli1")
                        IF loc_nResult < 0
                            THIS.this_cMensagemErro = "Erro ao buscar SigCdCli (ContaDs)"
                            loc_lErroNoScan = .T.
                            EXIT
                        ENDIF
                        loc_cCta = ""
                        SELECT cursor_4c_Cli1
                        IF !EOF()
                            loc_cCta = ALLTRIM(RClis)
                        ENDIF
                        USE IN cursor_4c_Cli1

                        *-- Busca nome do vendedor via Contas da comissao
                        loc_cSQL = "SELECT RClis FROM SigCdCli WHERE IClis = " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Cmm.Contas))
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cli2")
                        IF loc_nResult < 0
                            THIS.this_cMensagemErro = "Erro ao buscar SigCdCli (Contas)"
                            loc_lErroNoScan = .T.
                            EXIT
                        ENDIF
                        loc_cNvends = ""
                        SELECT cursor_4c_Cli2
                        GO TOP
                        IF !EOF()
                            loc_cNvends = ALLTRIM(RClis)
                        ENDIF
                        USE IN cursor_4c_Cli2

                        SELECT cursor_4c_Analitico
                        REPLACE Vends  WITH cursor_4c_Cmm.Contas, ;
                                NVends WITH loc_cNvends IN cursor_4c_Analitico

                        *-- Verifica se operacao e estorno de comissao
                        loc_cSQL = "SELECT calcfecs FROM SigCdOpe WHERE dopes = " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Cmm.dopes))
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ope")
                        IF loc_nResult < 0
                            THIS.this_cMensagemErro = "Erro ao buscar SigCdOpe"
                            loc_lErroNoScan = .T.
                            EXIT
                        ENDIF
                        SELECT cursor_4c_Ope
                        IF !EOF() AND cursor_4c_Ope.calcfecs = 1
                            SELECT cursor_4c_Cmm
                            REPLACE bases     WITH -cursor_4c_Cmm.bases     IN cursor_4c_Cmm
                            REPLACE comissaos WITH -cursor_4c_Cmm.comissaos IN cursor_4c_Cmm
                        ENDIF
                        USE IN cursor_4c_Ope

                        *-- Processamento de PenPag (pagamento em aberto)
                        IF loc_nPenPag = 1
                            loc_nReg = RECNO("cursor_4c_Analitico")
                            SELECT cursor_4c_Analitico
                            LOCATE FOR EmpDopNums = cursor_4c_Cmm.EmpDopNums
                            IF !FOUND()
                                GO loc_nReg
                            ELSE
                                REPLACE VlComi WITH VlComi + VlPago IN cursor_4c_Analitico
                            ENDIF

                            *-- Busca valor ja pago ao vendedor via lancamentos
                            loc_cHistPat = ALLTRIM(cursor_4c_Cmm.emps) + ;
                                           ALLTRIM(cursor_4c_Cmm.dopes) + " " + ;
                                           ALLTRIM(STR(cursor_4c_Cmm.numes))
                            loc_cSQL = "SELECT b.acertos AS vlPago, a.cotacaos," + ;
                                       " a.moedas, b.moedas AS moepit" + ;
                                       " FROM sigmvCcr a, sigcdpit b" + ;
                                       " WHERE a.nopers = b.nopers" + ;
                                       " AND a.grupos = " + ;
                                       EscaparSQL(ALLTRIM(cursor_4c_Cmm.grupos)) + ;
                                       " AND a.contas = " + ;
                                       EscaparSQL(ALLTRIM(cursor_4c_Cmm.Contas)) + ;
                                       " AND b.grupos = " + ;
                                       EscaparSQL(ALLTRIM(cursor_4c_Cmm.grupos)) + ;
                                       " AND b.contas = " + ;
                                       EscaparSQL(ALLTRIM(cursor_4c_Cmm.Contas)) + ;
                                       " AND b.hists LIKE '" + loc_cHistPat + "%'"
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pag")
                            IF loc_nResult < 0
                                THIS.this_cMensagemErro = "Erro ao buscar pagamentos"
                                loc_lErroNoScan = .T.
                                EXIT
                            ENDIF

                            loc_nCot = THIS.BuscarCotacao(loc_cMoeda, DATE())

                            IF ALLTRIM(cursor_4c_Cmm.moedas) = loc_cMoeda
                                IF RECCOUNT("cursor_4c_Pag") = 0
                                    SELECT cursor_4c_Analitico
                                    REPLACE VlComi WITH VlComi + cursor_4c_Cmm.comissaos ;
                                            IN cursor_4c_Analitico
                                    REPLACE VlPago WITH 0.00 IN cursor_4c_Analitico
                                ELSE
                                    loc_nValA = 0.00
                                    SELECT cursor_4c_Pag
                                    SCAN
                                        loc_nValA = loc_nValA + ;
                                            IIF(ALLTRIM(cursor_4c_Pag.moedas) = loc_cMoeda, ;
                                                cursor_4c_Pag.vlPago, ;
                                                ROUND(cursor_4c_Pag.vlPago / ;
                                                      cursor_4c_Pag.cotacaos, 2))
                                    ENDSCAN
                                    SELECT cursor_4c_Analitico
                                    DO CASE
                                        CASE cursor_4c_Cmm.comissaos < 0
                                            REPLACE VlComi WITH VlComi + ;
                                                cursor_4c_Cmm.comissaos + loc_nValA ;
                                                IN cursor_4c_Analitico
                                            REPLACE VlPago WITH loc_nValA ;
                                                IN cursor_4c_Analitico
                                        CASE cursor_4c_Cmm.comissaos > 0
                                            REPLACE VlComi WITH VlComi + ;
                                                cursor_4c_Cmm.comissaos - loc_nValA ;
                                                IN cursor_4c_Analitico
                                            REPLACE VlPago WITH loc_nValA ;
                                                IN cursor_4c_Analitico
                                    ENDCASE
                                ENDIF
                            ELSE
                                IF RECCOUNT("cursor_4c_Pag") = 0
                                    SELECT cursor_4c_Analitico
                                    REPLACE VlComi WITH VlComi + ;
                                        ROUND(cursor_4c_Cmm.comissaos / loc_nCot, 2) ;
                                        IN cursor_4c_Analitico
                                    REPLACE VlPago WITH 0.00 IN cursor_4c_Analitico
                                ELSE
                                    loc_nValA = 0.00
                                    loc_nValR = 0.00
                                    SELECT cursor_4c_Pag
                                    SCAN
                                        loc_nValA = loc_nValA + ;
                                            IIF(ALLTRIM(cursor_4c_Pag.moedas) = loc_cMoeda, ;
                                                cursor_4c_Pag.vlPago, ;
                                                ROUND(cursor_4c_Pag.vlPago / ;
                                                      cursor_4c_Pag.cotacaos, 2))
                                        loc_nValR = loc_nValR + ;
                                            IIF(ALLTRIM(cursor_4c_Pag.moedas) = loc_cMoeda, ;
                                                ROUND(cursor_4c_Pag.vlPago * ;
                                                      cursor_4c_Pag.cotacaos, 2), ;
                                                cursor_4c_Pag.vlPago)
                                    ENDSCAN
                                    SELECT cursor_4c_Analitico
                                    DO CASE
                                        CASE cursor_4c_Cmm.comissaos < 0
                                            REPLACE VlComi WITH VlComi + ;
                                                ROUND((cursor_4c_Cmm.comissaos + ;
                                                       loc_nValR) / loc_nCot, 2) ;
                                                IN cursor_4c_Analitico
                                            REPLACE VlPago WITH loc_nValA ;
                                                IN cursor_4c_Analitico
                                        CASE cursor_4c_Cmm.comissaos > 0
                                            REPLACE VlComi WITH VlComi + ;
                                                ROUND((cursor_4c_Cmm.comissaos - ;
                                                       loc_nValR) / loc_nCot, 2) ;
                                                IN cursor_4c_Analitico
                                            REPLACE VlPago WITH loc_nValA ;
                                                IN cursor_4c_Analitico
                                    ENDCASE
                                ENDIF
                            ENDIF
                            IF USED("cursor_4c_Pag")
                                USE IN cursor_4c_Pag
                            ENDIF
                        ENDIF

                        *-- Preenche campos conforme tipo de relatorio
                        IF (loc_nTip = 1)
                            SELECT cursor_4c_Analitico
                            REPLACE Datas      WITH cursor_4c_MvCab.Datas, ;
                                    EmpDopNums WITH cursor_4c_MvCab.EmpDopNums, ;
                                    Notas      WITH cursor_4c_MvCab.Notas, ;
                                    ContaDs    WITH cursor_4c_MvCab.ContaDs, ;
                                    RClis      WITH loc_cCta IN cursor_4c_Analitico
                        ENDIF
                        IF (loc_nTip = 3)
                            SELECT cursor_4c_Analitico
                            REPLACE Datas WITH cursor_4c_MvCab.Datas, ;
                                    Dopes WITH cursor_4c_MvCab.Dopes IN cursor_4c_Analitico
                        ENDIF

                        IF USED("cursor_4c_MvCab")
                            USE IN cursor_4c_MvCab
                        ENDIF
                    ELSE
                        IF USED("cursor_4c_MvCab")
                            USE IN cursor_4c_MvCab
                        ENDIF
                    ENDIF

                    *-- Acumula valores base no cursor analitico (sempre executa)
                    loc_nComiAtual = cursor_4c_Cmm.comissaos
                    SELECT cursor_4c_Analitico
                    REPLACE valos    WITH valos + cursor_4c_Cmm.bases     IN cursor_4c_Analitico
                    REPLACE comis    WITH comis + loc_nComiAtual           IN cursor_4c_Analitico
                    REPLACE vlbaixas WITH vlbaixas + cursor_4c_Cmm.Baixas IN cursor_4c_Analitico
                    REPLACE moedas   WITH cursor_4c_Cmm.moedas            IN cursor_4c_Analitico
                    SELECT cursor_4c_Cmm

                ENDSCAN

                IF USED("cursor_4c_Cmm")
                    USE IN cursor_4c_Cmm
                ENDIF
            ENDIF

            *-- Pos-processamento tipo Analitico: busca numeros de NF nos subnivels
            IF !loc_lErroNoScan AND (loc_nTip = 1)
                SELECT cursor_4c_Analitico
                SET ORDER TO
                GO TOP
                SCAN WHILE !loc_lErroNoScan
                    loc_cSQL = "SELECT a.EmpDopNums, a.Codigos, a.Emps," + ;
                               " o.Dopes, RIGHT(a.Codigos, 6) AS Numes" + ;
                               " FROM SigMvPec a, SigMvCab b, SigCdOpe o" + ;
                               " WHERE a.EmpDopNums = b.EmpDopNums" + ;
                               " AND b.Dopes = o.Dopes" + ;
                               " AND a.EmpDopNums = " + ;
                               EscaparSQL(ALLTRIM(cursor_4c_Analitico.EmpDopNums)) + ;
                               " AND a.EmpDopNums NOT IN" + ;
                               " (SELECT n.EmpDopNums FROM SigMvNfi n" + ;
                               " WHERE n.EmpDopNums = " + ;
                               EscaparSQL(ALLTRIM(cursor_4c_Analitico.EmpDopNums)) + ")"
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Sub")
                    IF loc_nResult < 0
                        THIS.this_cMensagemErro = "Erro ao buscar SigMvPec"
                        loc_lErroNoScan = .T.
                        EXIT
                    ENDIF

                    SELECT cursor_4c_Sub
                    GO TOP
                    IF !EOF()
                        loc_cEdn = ALLTRIM(cursor_4c_Sub.Emps) + ;
                                   ALLTRIM(cursor_4c_Sub.Dopes) + ;
                                   STR(INT(VAL(ALLTRIM(cursor_4c_Sub.Numes))), 6)
                        loc_cSQL = "SELECT b.NFis, b.EmpDopNums FROM SigMvNfi b" + ;
                                   " WHERE b.EmpDopNums = " + EscaparSQL(loc_cEdn)
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NF")
                        IF loc_nResult < 0
                            THIS.this_cMensagemErro = "Erro ao buscar SigMvNfi"
                            loc_lErroNoScan = .T.
                            USE IN cursor_4c_Sub
                            EXIT
                        ENDIF
                        SELECT cursor_4c_NF
                        GO TOP
                        IF !EOF()
                            SELECT cursor_4c_Analitico
                            REPLACE EmpDopNums WITH cursor_4c_NF.EmpDopNums, ;
                                    Notas      WITH cursor_4c_NF.NFis IN cursor_4c_Analitico
                        ENDIF
                        IF USED("cursor_4c_NF")
                            USE IN cursor_4c_NF
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_Sub")
                        USE IN cursor_4c_Sub
                    ENDIF
                    SELECT cursor_4c_Analitico
                ENDSCAN
            ENDIF

            *-- Aplica filtros SNA (Sim/Nao/Ambos) e filtro PenPag
            IF !loc_lErroNoScan
                SELECT cursor_4c_Analitico
                DO CASE
                    CASE (loc_nOpt = 1)
                        DELETE FROM cursor_4c_Analitico WHERE EMPTY(Notas)
                    CASE (loc_nOpt = 2)
                        DELETE FROM cursor_4c_Analitico WHERE !EMPTY(Notas)
                ENDCASE

                IF loc_nPenPag = 1
                    DELETE FROM cursor_4c_Analitico WHERE VlComi = 0
                ENDIF

                SELECT cursor_4c_Analitico
                SET ORDER TO VendDatas
                GO TOP

                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lResultado, loc_cFrx, loc_cSep, loc_cPto, loc_oErro
        loc_lResultado = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cFrx = THIS.ObterFRXParaImprimir()
                loc_cSep = SET("Separator")
                loc_cPto = SET("Point")
                SET POINT TO ","
                SET SEPARATOR TO "."
                REPORT FORM (loc_cFrx) TO PRINTER NOCONSOLE
                SET POINT TO (loc_cPto)
                SET SEPARATOR TO (loc_cSep)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe preview do relatorio na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lResultado, loc_cFrx, loc_cSep, loc_cPto, loc_oErro
        loc_lResultado = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cFrx = THIS.ObterFRXParaVisualizar()
                loc_cSep = SET("Separator")
                loc_cPto = SET("Point")
                SET POINT TO ","
                SET SEPARATOR TO "."
                REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE
                SET POINT TO (loc_cPto)
                SET SEPARATOR TO (loc_cSep)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterFRXParaImprimir - Seleciona FRX conforme opcoes de impressao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterFRXParaImprimir()
        IF THIS.this_nOptPenPag = 1
            RETURN "SigReCr11"
        ENDIF
        DO CASE
            CASE THIS.this_nOptTipo = 1
                IF THIS.this_nOptQuebras = 1
                    RETURN "SigReCr1"
                ELSE
                    RETURN "SigReCr2"
                ENDIF
            CASE THIS.this_nOptTipo = 2
                RETURN "SigReCr3"
            OTHERWISE
                RETURN "SigReCr4"
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterFRXParaVisualizar - Seleciona FRX conforme opcoes de preview
    * (opcao de quebra 3 = SigReCr6, exclusivo para preview)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterFRXParaVisualizar()
        IF THIS.this_nOptPenPag = 1
            RETURN "SigReCr11"
        ENDIF
        DO CASE
            CASE THIS.this_nOptTipo = 1
                DO CASE
                    CASE THIS.this_nOptQuebras = 1
                        RETURN "SigReCr1"
                    CASE THIS.this_nOptQuebras = 2
                        RETURN "SigReCr2"
                    OTHERWISE
                        RETURN "SigReCr6"
                ENDCASE
            CASE THIS.this_nOptTipo = 2
                RETURN "SigReCr3"
            OTHERWISE
                RETURN "SigReCr4"
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarCotacao - Busca cotacao mais recente da moeda ate a data informada
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BuscarCotacao(par_cMoeda, par_dData)
        LOCAL loc_nResult, loc_nCotacao, loc_cSQL, loc_oErro
        loc_nCotacao = 1.00
        TRY
            loc_cSQL = "SELECT TOP 1 valos FROM SigCdCot" + ;
                       " WHERE cmoes = " + EscaparSQL(ALLTRIM(par_cMoeda)) + ;
                       " AND datas <= " + FormatarDataSQL(par_dData) + ;
                       " ORDER BY datas DESC, horas DESC"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CotBusca")
            IF loc_nResult > 0
                SELECT cursor_4c_CotBusca
                GO TOP
                IF !EOF()
                    loc_nCotacao = NVL(valos, 1.00)
                ENDIF
                USE IN cursor_4c_CotBusca
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_nCotacao
    ENDPROC

ENDDEFINE
