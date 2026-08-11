*==============================================================================
* SIGREAGVBO.PRG
* Business Object - Relatorio de Acompanhamento Por Grupo de Venda
*
* Form origem : SIGREAGV.SCX (frmrelatorio)
* Herda de   : RelatorioBase
* Arquivo FRX: SigReAgv.frx
*
* Filtros do formulario:
*   - Grupo de Venda (Colecoes + Descs) -> SigCdCol
*   - Moeda de Venda (CMoes + DMoes)    -> SigCdMoe
*==============================================================================

DEFINE CLASS SIGREAGVBO AS RelatorioBase

    *-- Filtros do formulario
    this_cColecoes     = ""    && Codigo Grupo de Venda  (C10) - SigCdCol.Colecoes
    this_cDescs        = ""    && Descricao Grupo Venda  (C40) - SigCdCol.Descs
    this_cCMoes        = ""    && Codigo Moeda de Venda  (C03) - SigCdMoe.CMoes
    this_cDMoes        = ""    && Descricao Moeda Venda  (C15) - SigCdMoe.DMoes

    *-- Configuracao do relatorio
    this_cArquivoFRX   = ""    && Caminho completo do arquivo .frx
    this_cTitulo       = ""    && Titulo principal do relatorio
    this_cSubTitulo    = ""    && Sub-titulo (Grupo de Venda selecionado)
    this_cCursorDados  = "crImprimir"    && Cursor principal para REPORT FORM (nome bate com FRX legado)

    *--------------------------------------------------------------------------
    * Init - Configura metadados do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        THIS.this_cTitulo     = "Acompanhamento Por Grupo de Venda"
        THIS.this_cArquivoFRX = gc_4c_CaminhoReports + "SigReAgv.frx"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem do ultimo erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa todo o processamento do relatorio
    * Replica a PROCEDURE processamento do SIGREAGV.SCX original
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_lMostrouErro, loc_oErro
        LOCAL loc_lcCol, loc_lcDol, loc_lcMoe
        LOCAL loc_lcTit, loc_lcSub, loc_lcCep
        LOCAL loc_lcQuery, loc_lcGrv
        LOCAL loc_lnCnt, loc_lnZer, loc_lnSal
        LOCAL loc_ldDat, loc_lcDtI, loc_lcDtF
        LOCAL loc_nResult, loc_nTaxa

        loc_lSucesso     = .F.
        loc_lMostrouErro = .F.

        TRY
            DO WHILE .T.

                *-- Apanha filtros selecionados no formulario
                loc_lcCol = PADR(THIS.this_cColecoes, 10)
                loc_lcDol = PADR(THIS.this_cDescs,    40)
                loc_lcMoe = PADR(THIS.this_cCMoes,    3)

                *-- Titulo e sub-titulo para o cabecalho do relatorio
                loc_lcTit = THIS.this_cTitulo
                IF EMPTY(loc_lcCol)
                    loc_lcSub = "Grupo de Venda : Geral"
                ELSE
                    loc_lcSub = "Grupo de Venda : " + ALLTRIM(loc_lcCol) + " - " + ALLTRIM(loc_lcDol)
                ENDIF
                THIS.this_cSubTitulo = loc_lcSub

                *-- Cabecalho com dados da empresa
                loc_lcCep = ALLTRIM(go_4c_Sistema.cCodEmpresa) + " - " + ALLTRIM(go_4c_Sistema.cEmpresa)

                IF USED("crCabecalho")
                    USE IN crCabecalho
                ENDIF
                CREATE CURSOR crCabecalho (Empresa C(80), Titulo C(80), SubTitulo C(80))
                INSERT INTO crCabecalho (Empresa, Titulo, SubTitulo) ;
                    VALUES (loc_lcCep, loc_lcTit, loc_lcSub)

                IF USED("crOrdenados")
                    USE IN crOrdenados
                ENDIF
                CREATE CURSOR crOrdenados (Colecoes C(10), CPros C(14), PrecoMedio N(16,2), ;
                                           DtIncs D(8), Moevs C(3), Promos C(25), ;
                                           Ordem C(10), QtdMedia N(16,2))

                *-- Busca tipos de operacao (entrada=2 ou saida=1)
                loc_lcQuery = "SELECT a.Dopes, a.TipoOps, t.GerGdmis " + ;
                              "FROM SigCdOpe a, SigCdTom t " + ;
                              "WHERE a.TipoOps = t.Codigos " + ;
                              "AND t.GerGdmis IN (1, 2) " + ;
                              "ORDER BY a.Dopes, a.TipoOps"
                loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigCdOpe")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao buscar opera" + CHR(231) + CHR(245) + "es (crSigCdOpe)"
                    EXIT
                ENDIF

                *-- Busca grupos de produtos nao considerados para media de preco de colecoes
                loc_lcQuery = "SELECT a.Promos, a.CPros, MIN(a.Datas) AS Datas " + ;
                              "FROM SigPrPmi a, SigPrPmc b " + ;
                              "WHERE a.Promos = b.Promos " + ;
                              "AND NOT b.Cods = '   ' " + ;
                              "GROUP BY a.Promos, a.CPros"
                loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigPrPmi")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao buscar promo" + CHR(231) + CHR(245) + "es (crSigPrPmi)"
                    EXIT
                ENDIF
                SELECT crSigPrPmi
                INDEX ON CPros TAG CPros

                *-- Busca produtos com grupo de venda e preco de venda definidos
                loc_lcQuery = "SELECT a.Colecoes, a.CPros, a.CGrus, a.PVens, a.Moevs, " + ;
                              "a.DtIncs, a.PVens AS QtdMedia " + ;
                              "FROM SigCdPro a " + ;
                              "WHERE NOT a.Colecoes = '          ' " + ;
                              "AND NOT a.PVens = 0 " + ;
                              "ORDER BY a.Colecoes, a.CPros, a.CGrus, a.PVens, a.Moevs, a.DtIncs"
                loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigCdPro")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao buscar produtos (crSigCdPro)"
                    EXIT
                ENDIF

                *-- Quantidade de produtos por grupo de venda
                SELECT Colecoes, SUM(1) AS QtdMedia ;
                  FROM crSigCdPro ;
                 GROUP BY Colecoes ;
                  INTO CURSOR crQtdMedia
                SELECT crQtdMedia
                INDEX ON Colecoes TAG Colecoes

                *-- Menor data de cadastro por grupo de venda
                SELECT Colecoes, MIN(TTOD(NVL(DtIncs, CTOT("")))) AS DtIncs ;
                  FROM crSigCdPro ;
                 GROUP BY Colecoes ;
                  INTO CURSOR crDtIncs
                SELECT crDtIncs
                INDEX ON Colecoes TAG Colecoes

                *-- Converte preco de venda para Real e atualiza data/qtd do grupo
                WAIT WINDOW "Processando Pre" + CHR(231) + "o de Venda dos Produtos..." NOWAIT
                SELECT crSigCdPro
                SCAN
                    loc_nTaxa = THIS.BuscarCotacao(crSigCdPro.Moevs)
                    REPLACE PVens WITH PVens * loc_nTaxa IN crSigCdPro

                    IF SEEK(crSigCdPro.Colecoes, "crQtdMedia", "Colecoes")
                        REPLACE QtdMedia WITH crQtdMedia.QtdMedia IN crSigCdPro
                    ELSE
                        REPLACE QtdMedia WITH 0 IN crSigCdPro
                    ENDIF

                    IF SEEK(crSigCdPro.Colecoes, "crDtIncs", "Colecoes")
                        REPLACE DtIncs WITH crDtIncs.DtIncs IN crSigCdPro
                    ENDIF
                ENDSCAN
                WAIT CLEAR

                *-- Calcula preco medio por grupo de venda
                SELECT Colecoes, AVG(PVens) AS PVens ;
                  FROM crSigCdPro ;
                 GROUP BY Colecoes ;
                  INTO CURSOR crMedias
                SELECT crMedias
                INDEX ON Colecoes TAG Colecoes

                *-- Monta cursor com preco medio por produto/grupo
                SELECT DISTINCT a.Colecoes, a.CPros, b.PVens AS PrecoMedio, ;
                       a.DtIncs, a.Moevs, a.QtdMedia ;
                  FROM crSigCdPro a, crMedias b ;
                 WHERE a.Colecoes = b.Colecoes ;
                 ORDER BY a.Colecoes, a.CPros, b.PVens, a.DtIncs, a.Moevs ;
                  INTO CURSOR crGrupos

                *-- Para cada produto: busca historico de precos e promocoes
                WAIT WINDOW "Processando Hist" + CHR(243) + "rico dos Produtos..." NOWAIT
                SELECT crGrupos
                SCAN
                    loc_lcCol = PADR(STRTRAN(crGrupos.Colecoes, ['], []), 10)

                    loc_lcQuery = "SELECT Moevs, MIN(DataAlts) AS DataAlts " + ;
                                  "FROM SigCdPrc " + ;
                                  "WHERE CPros = " + EscaparSQL(crGrupos.CPros) + ;
                                  " AND Colecoes = " + EscaparSQL(loc_lcCol) + ;
                                  " GROUP BY Moevs " + ;
                                  "ORDER BY DataAlts, Moevs"
                    loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigCdPrc")
                    IF loc_nResult < 1
                        THIS.this_cMensagemErro = "Erro hist" + CHR(243) + "rico pre" + CHR(231) + "os (crSigCdPrc)"
                        EXIT
                    ENDIF

                    SELECT crSigCdPrc
                    GO TOP
                    IF !EOF("crSigCdPrc")
                        loc_lnCnt = 0
                        SCAN
                            loc_lnCnt = loc_lnCnt + 1
                            INSERT INTO crOrdenados ;
                                (Colecoes, CPros, PrecoMedio, QtdMedia, DtIncs, Moevs, Ordem) ;
                                VALUES (loc_lcCol, crGrupos.CPros, crGrupos.PrecoMedio, ;
                                        crGrupos.QtdMedia, NVL(crSigCdPrc.DataAlts, {}), ;
                                        crSigCdPrc.Moevs, ALLTRIM(STR(loc_lnCnt, 6)))
                        ENDSCAN
                    ELSE
                        INSERT INTO crOrdenados ;
                            (Colecoes, CPros, PrecoMedio, QtdMedia, DtIncs, Moevs, Ordem) ;
                            VALUES (loc_lcCol, crGrupos.CPros, crGrupos.PrecoMedio, ;
                                    crGrupos.QtdMedia, NVL(crGrupos.DtIncs, {}), ;
                                    crGrupos.Moevs, "1")
                    ENDIF
                    IF USED("crSigCdPrc")
                        USE IN crSigCdPrc
                    ENDIF

                    *-- Promocoes do produto
                    SELECT Promos, MIN(Datas) AS Datas ;
                      FROM crSigPrPmi ;
                     WHERE CPros = crGrupos.CPros ;
                     GROUP BY Promos ;
                     ORDER BY 2, 1 ;
                      INTO CURSOR crPromos
                    SELECT crPromos
                    GO TOP
                    IF !EOF("crPromos")
                        loc_lnCnt = 0
                        SCAN
                            loc_lnCnt = loc_lnCnt + 1
                            INSERT INTO crOrdenados ;
                                (Colecoes, CPros, PrecoMedio, QtdMedia, DtIncs, Promos, Ordem) ;
                                VALUES (loc_lcCol, crGrupos.CPros, crGrupos.PrecoMedio, ;
                                        crGrupos.QtdMedia, NVL(crPromos.Datas, {}), ;
                                        crPromos.Promos, ALLTRIM(STR(loc_lnCnt, 6)) + "A")
                        ENDSCAN
                    ENDIF
                    IF USED("crPromos")
                        USE IN crPromos
                    ENDIF
                ENDSCAN
                WAIT CLEAR

                IF !EMPTY(THIS.this_cMensagemErro)
                    EXIT
                ENDIF

                *-- Agrega crOrdenados em dois passos (como o original)
                SELECT Colecoes, PrecoMedio, ;
                       MAX(QtdMedia) AS QtdMedia, ;
                       MAX(IIF(ALLTRIM(Moevs) = ALLTRIM(loc_lcMoe), Moevs, "   ")) AS Moevs, ;
                       Promos, MAX(Ordem) AS Ordem, MIN(DtIncs) AS DtIncs ;
                  FROM crOrdenados ;
                 GROUP BY Colecoes, PrecoMedio, Moevs, Promos ;
                  INTO CURSOR crGroupImp1

                SELECT Colecoes, PrecoMedio, ;
                       MAX(QtdMedia) AS QtdMedia, Moevs, Promos, ;
                       MAX(Ordem) AS Ordem, MIN(DtIncs) AS DtIncs ;
                  FROM crGroupImp1 ;
                 GROUP BY Colecoes, PrecoMedio, Moevs, Promos ;
                  INTO CURSOR crGroupImp2

                loc_lnZer = 0
                IF USED(THIS.this_cCursorDados)
                    USE IN (THIS.this_cCursorDados)
                ENDIF
                SELECT Colecoes, PrecoMedio, ;
                       MAX(QtdMedia) AS QtdMedia, MAX(Moevs) AS Moevs, Promos, ;
                       MAX(Ordem) AS Ordem, MAX(DtIncs) AS DtIncs, ;
                       MAX(DtIncs) AS DtInicial, MAX(DtIncs) AS DtFinal, ;
                       loc_lnZer AS SaldoIni, loc_lnZer AS Compras, ;
                       loc_lnZer AS Vendas,   loc_lnZer AS SaldoFin, ;
                       loc_lnZer AS Percentual ;
                  FROM crGroupImp2 ;
                 GROUP BY Colecoes, PrecoMedio, Promos, DtIncs ;
                  INTO CURSOR crImprimir READWRITE

                SELECT crImprimir
                INDEX ON Colecoes + DTOS(DtIncs) + Ordem TAG Colecoes

                *-- Define intervalos de datas por grupo de venda
                loc_lcGrv = SPACE(10)
                SELECT crImprimir
                SCAN
                    IF (loc_lcGrv <> crImprimir.Colecoes)
                        loc_lcGrv = crImprimir.Colecoes
                        REPLACE DtInicial WITH CTOD("01/01/1900") IN crImprimir
                        REPLACE DtFinal   WITH DATE()              IN crImprimir
                        loc_ldDat = crImprimir.DtFinal
                    ELSE
                        SKIP -1
                        REPLACE DtFinal WITH IIF(EMPTY(DtIncs), CTOD("01/01/1900"), DtIncs) IN crImprimir
                        loc_ldDat = crImprimir.DtFinal
                        SKIP +1
                        REPLACE DtInicial WITH loc_ldDat IN crImprimir
                        REPLACE DtFinal   WITH DATE()    IN crImprimir
                        loc_ldDat = crImprimir.DtFinal
                    ENDIF
                ENDSCAN

                *-- Busca todas as movimentacoes de produtos
                WAIT WINDOW "Aguarde!!! Selecionando Movimenta" + CHR(231) + CHR(245) + "es..." NOWAIT
                loc_lcQuery = "SELECT a.TipoOps, b.Datas, c.CPros, c.Qtds, c.Opers, t.GerGdmis " + ;
                              "FROM SigCdOpe a, SigMvCab b, SigMvItn c, SigCdTom t " + ;
                              "WHERE a.Dopes = b.Dopes " + ;
                              "AND b.EmpDopNums = c.EmpDopNums " + ;
                              "AND a.TipoOps = t.Codigos " + ;
                              "AND t.GerGdmis IN (1, 2)"
                loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crMovGeral")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao buscar movimenta" + CHR(231) + CHR(245) + "es (crMovGeral)"
                    WAIT CLEAR
                    EXIT
                ENDIF
                WAIT CLEAR

                SELECT DISTINCT TTOD(Datas) AS Datas, CPros, ;
                       VAL(STR(IIF(GerGdmis = 2, IIF(Opers = "E", Qtds, Qtds * -1), 0), 16, 2)) AS Compras, ;
                       VAL(STR(IIF(GerGdmis = 1, IIF(Opers = "S", Qtds, Qtds * -1), 0), 16, 2)) AS Vendas ;
                  FROM crMovGeral ;
                  INTO CURSOR crMovimento READWRITE

                SELECT crMovimento
                INDEX ON CPros + DTOS(Datas) TAG ProDat

                *-- Acumula compras e vendas por produto/periodo em crImprimir
                WAIT WINDOW "Processando Movimenta" + CHR(231) + CHR(227) + "o dos Produtos..." NOWAIT
                SELECT crImprimir
                SCAN
                    loc_lcDtI = DTOS(crImprimir.DtInicial)
                    loc_lcDtF = DTOS(crImprimir.DtFinal)

                    SELECT CPros ;
                      FROM crSigCdPro ;
                     WHERE Colecoes = crImprimir.Colecoes ;
                     ORDER BY CPros ;
                      INTO CURSOR crProdutos
                    SELECT crProdutos
                    SCAN
                        SELECT "" AS Agrupar, SUM(Compras) AS Compras, SUM(Vendas) AS Vendas ;
                          FROM crMovimento ;
                         WHERE CPros + DTOS(Datas) BETWEEN ;
                               crProdutos.CPros + loc_lcDtI AND crProdutos.CPros + loc_lcDtF ;
                         GROUP BY 1 ;
                          INTO CURSOR crValores
                        GO TOP IN crValores
                        IF !EOF("crValores")
                            REPLACE Compras WITH Compras + crValores.Compras, ;
                                    Vendas  WITH Vendas  + crValores.Vendas  IN crImprimir
                        ENDIF
                        IF USED("crValores")
                            USE IN crValores
                        ENDIF
                    ENDSCAN
                    IF USED("crProdutos")
                        USE IN crProdutos
                    ENDIF
                ENDSCAN
                WAIT CLEAR

                *-- Calcula saldo inicial, final e percentual por grupo
                loc_lcGrv = SPACE(10)
                SELECT crImprimir
                SCAN
                    IF (loc_lcGrv <> crImprimir.Colecoes)
                        loc_lcGrv = crImprimir.Colecoes
                        REPLACE SaldoFin   WITH Compras - Vendas IN crImprimir
                        REPLACE Percentual WITH IIF(Vendas = 0, 0, ;
                            IIF(SaldoIni + Compras = 0, 100, ;
                                (Vendas / (SaldoIni + Compras)) * 100)) IN crImprimir
                    ELSE
                        SKIP -1
                        loc_lnSal = crImprimir.SaldoFin
                        SKIP +1
                        REPLACE SaldoIni WITH loc_lnSal, ;
                                SaldoFin WITH loc_lnSal + (Compras - Vendas) IN crImprimir
                        REPLACE Percentual WITH IIF(Vendas = 0, 0, ;
                            IIF(SaldoIni + Compras = 0, 100, ;
                                (Vendas / (SaldoIni + Compras)) * 100)) IN crImprimir
                    ENDIF
                ENDSCAN

                SELECT crImprimir
                GO TOP

                loc_lSucesso = .T.
                EXIT
            ENDDO

        CATCH TO loc_oErro
            WAIT CLEAR
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Preparar Dados do Relat" + CHR(243) + "rio")
            loc_lMostrouErro = .T.
        ENDTRY

        *-- Limpa cursores temporarios
        IF USED("crSigCdOpe")
            USE IN crSigCdOpe
        ENDIF
        IF USED("crSigPrPmi")
            USE IN crSigPrPmi
        ENDIF
        IF USED("crSigCdPro")
            USE IN crSigCdPro
        ENDIF
        IF USED("crQtdMedia")
            USE IN crQtdMedia
        ENDIF
        IF USED("crDtIncs")
            USE IN crDtIncs
        ENDIF
        IF USED("crMedias")
            USE IN crMedias
        ENDIF
        IF USED("crGrupos")
            USE IN crGrupos
        ENDIF
        IF USED("crOrdenados")
            USE IN crOrdenados
        ENDIF
        IF USED("crGroupImp1")
            USE IN crGroupImp1
        ENDIF
        IF USED("crGroupImp2")
            USE IN crGroupImp2
        ENDIF
        IF USED("crMovGeral")
            USE IN crMovGeral
        ENDIF
        IF USED("crMovimento")
            USE IN crMovimento
        ENDIF

        IF !loc_lSucesso AND !loc_lMostrouErro AND !EMPTY(THIS.this_cMensagemErro)
            MsgErro(THIS.this_cMensagemErro, "Relat" + CHR(243) + "rio")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime diretamente na impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cArquivoFRX) TO PRINTER PROMPT NOCONSOLE
                THIS.RegistrarAuditoria("IMPRIMIR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Imprimir Relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cArquivoFRX) PREVIEW NOCONSOLE
                THIS.RegistrarAuditoria("VISUALIZAR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Visualizar Relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarExcel - Prepara dados e gera documento (imprime para arquivo)
    *--------------------------------------------------------------------------
    PROCEDURE GerarExcel()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cArquivoFRX) TO PRINTER NOCONSOLE
                THIS.RegistrarAuditoria("EXPORTAR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Gerar Documento do Relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio na tabela LogAuditoria
    * Para REPORT BOs, a chave do registro contem o codigo do grupo+moeda filtrado
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cChave = THIS.ObterChavePrimaria()
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                               gc_4c_UsuarioLogado, "SISTEMA")

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SIGREAGV") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(loc_cUsuario) + ", GETDATE())"

            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            *-- Falha em audit nao deve impedir geracao do relatorio
            THIS.this_cMensagemErro = "Aviso: falha ao registrar auditoria - " + ;
                                       loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarCotacao - Busca taxa de cambio da moeda em relacao ao Real
    * Substitui fBuscarCotacao() do sistema legado
    * Tabela: SigCdCot (cmoes, datas, valos)
    * Retorna 1.0 se moeda nao encontrada (fallback seguro)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarCotacao(par_cMoeda)
        LOCAL loc_nTaxa, loc_cSQL, loc_nResult, loc_cMoeda

        loc_nTaxa  = 1.0
        loc_cMoeda = ALLTRIM(par_cMoeda)

        IF EMPTY(loc_cMoeda) OR loc_cMoeda = "R"
            RETURN loc_nTaxa
        ENDIF

        loc_cSQL = "SELECT TOP 1 valos FROM SigCdCot " + ;
                   "WHERE cmoes = " + EscaparSQL(loc_cMoeda) + ;
                   " AND datas <= GETDATE() " + ;
                   "ORDER BY datas DESC, horas DESC"
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CotAgv")
        IF loc_nResult > 0 AND !EOF("cursor_4c_CotAgv")
            SELECT cursor_4c_CotAgv
            IF NVL(valos, 0) > 0
                loc_nTaxa = valos
            ENDIF
        ENDIF

        IF USED("cursor_4c_CotAgv")
            USE IN cursor_4c_CotAgv
        ENDIF

        RETURN loc_nTaxa
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificador da execucao do relatorio
    * Combina filtros selecionados (Grupo de Venda + Moeda) como chave de auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave, loc_cCol, loc_cMoe
        loc_cCol = ALLTRIM(THIS.this_cColecoes)
        loc_cMoe = ALLTRIM(THIS.this_cCMoes)

        loc_cChave = IIF(EMPTY(loc_cCol), "GERAL", loc_cCol)
        IF !EMPTY(loc_cMoe)
            loc_cChave = loc_cChave + "/" + loc_cMoe
        ENDIF
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("crCabecalho")
            USE IN crCabecalho
        ENDIF
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
