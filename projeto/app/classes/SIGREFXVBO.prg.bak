*==============================================================================
* SIGREFXVBO.PRG
* Business Object para Relatorio de Posicao de Estoque por Grupo/Faixa de Valor
* Herda de RelatorioBase
*
* Tabela principal: SigMvEst / SigMvHst (movimentos de estoque)
* Relatorio FRX: SigReFxv.frx
*
* Filtros:
*   - Posicao: Atual (SigMvEst) ou Retroativa (SigMvHst ate data informada)
*   - Moeda: codigo + descricao (SigCdMoe)
*   - Complemento Caracteristica: codigo do titulo da ficha (SigPrCpP)
*   - Grande Grupo: codigo + descricao (SigCdGpr.Codigos/Descs)
*   - Grupo de Produto: codigo + descricao (SigCdGrp.CGrus/DGrus) - opcional
*   - Grid de Estoques: pares Empresa/Grupo alimentados pelo usuario (cursor CsEstoque)
*==============================================================================

DEFINE CLASS SIGREFXVBO AS RelatorioBase

    *-- Filtro: tipo de periodo (1=Atual / 2=Retroativa - espelha OptRfEstoque.Value)
    this_nNrPeriodo     = 1

    *-- Filtro: data da posicao retroativa (usado quando this_nNrPeriodo = 2)
    this_dDataSaldo     = {}

    *-- Filtro: moeda (CMoes / DMoes de SigCdMoe)
    this_cCdMoeda       = ""
    this_cDsMoeda       = ""

    *-- Filtro: complemento caracteristica (Codigos de SigPrCpP)
    this_cFichaT        = ""

    *-- Filtro: grande grupo (Codigos / Descs de SigCdGpr)
    this_cGGrus         = ""
    this_cDGRus         = ""

    *-- Filtro: grupo de produto opcional (CGrus / DGrus de SigCdGrp)
    this_cCdGrupo       = ""
    this_cDsGrupo       = ""

    *-- Nome do cursor com pares Empresa/Grupo alimentados pelo grid do form
    *   O form mantem o cursor CsEstoque; PrepararDados() le a partir dele
    this_cCursorEstoque = "CsEstoque"

    *-- Nome do cursor de saida populado por PrepararDados()
    this_cCursorDados   = "CsRelatorio"

    *-- Caminho do arquivo FRX para REPORT FORM
    this_cArquivoFRX    = ""

    *-- Titulo do relatorio
    this_cTitulo        = ""

    *--------------------------------------------------------------------------
    * Init - Configura BO do relatorio de posicao de estoque
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvEst"
        THIS.this_cCampoChave = ""
        THIS.this_cArquivoFRX = gc_4c_CaminhoBase + "reports\SigReFxv.frx"
        THIS.this_cTitulo     = "Relat" + CHR(243) + "rio de Posi" + CHR(231) + CHR(227) + ;
                                 "o de Estoque por Grupo de Produto/Faixa de Valor"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa dados para o relatorio
    * Replica logica do procedimento "processamento" do form legado SIGREFXV
    * Popula cursores: csCabecalho, CsRelatorio (this_cCursorDados)
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nCotMoe
        LOCAL loc_cNmEmpresa, loc_cNmTitulo, loc_cNmPeriodo
        LOCAL loc_cGrupo, loc_cDsGrupo, loc_cGde, loc_cCarac
        LOCAL loc_cResp, loc_nPVen, loc_nCota, loc_cChaveBusca
        LOCAL loc_cAlias
        LOCAL pDat

        loc_lSucesso = .F.

        TRY
            *-- Validar parametros obrigatorios
            IF EMPTY(ALLTRIM(THIS.this_cCdMoeda))
                THIS.this_cMensagemErro = "Moeda " + CHR(233) + " obrigat" + CHR(243) + "ria!"
                MsgAviso(THIS.this_cMensagemErro)
            ELSE
            IF EMPTY(ALLTRIM(THIS.this_cGGrus))
                THIS.this_cMensagemErro = "Grande Grupo " + CHR(233) + " obrigat" + CHR(243) + "rio!"
                MsgAviso(THIS.this_cMensagemErro)
            ELSE
            IF !USED(THIS.this_cCursorEstoque)
                THIS.this_cMensagemErro = "Cursor de estoques n" + CHR(227) + "o dispon" + CHR(237) + "vel"
                MsgErro(THIS.this_cMensagemErro, "Erro")
            ELSE
            IF !THIS.ValidarGridEstoque()
                *-- ValidarGridEstoque ja exibe mensagem e define this_cMensagemErro
            ELSE
                *-- Inicializar variaveis locais de filtro
                loc_cGrupo   = ALLTRIM(THIS.this_cCdGrupo)
                loc_cDsGrupo = ALLTRIM(THIS.this_cDsGrupo)
                loc_cGde     = ALLTRIM(THIS.this_cGGrus)
                loc_cCarac   = ALLTRIM(THIS.this_cFichaT)

                *-- Obter cotacao da moeda de referencia
                loc_nCotMoe = fBuscarCotacao(THIS.this_cCdMoeda, DATE())
                IF loc_nCotMoe = 0
                    loc_nCotMoe = 1
                ENDIF

                *-- Obter nome da empresa atual
                loc_cNmEmpresa = ALLTRIM(go_4c_Sistema.cEmpresa)

                *-- Montar strings de titulo e periodo
                loc_cNmTitulo  = "Estoque Por Faixa de Pre" + CHR(231) + "o " + ;
                                 IIF(!EMPTY(loc_cGrupo), ;
                                     "Grupo:" + loc_cGrupo + "-" + loc_cDsGrupo, ;
                                     "")
                loc_cNmPeriodo = "Em " + ;
                                 IIF(THIS.this_nNrPeriodo = 1, ;
                                     DTOC(DATE()), DTOC(THIS.this_dDataSaldo)) + ;
                                 "  Moeda:" + THIS.this_cCdMoeda

                *-- Criar cursor csCabecalho para o FRX
                IF USED("csCabecalho")
                    USE IN csCabecalho
                ENDIF
                CREATE CURSOR csCabecalho ;
                    (nm_empresa C(80), nm_titulo C(80), nm_periodo C(80), cb_empresa C(80))
                INSERT INTO csCabecalho (nm_empresa, nm_titulo, nm_periodo, cb_empresa) ;
                       VALUES (loc_cNmEmpresa, loc_cNmTitulo, loc_cNmPeriodo, "")

                *-- Criar cursor CsRelatorio (nome exato referenciado pelo FRX)
                IF USED("CsRelatorio")
                    USE IN CsRelatorio
                ENDIF
                CREATE CURSOR CsRelatorio ;
                    (cTits C(20), cResps C(100), Cgrus C(3), ps N(2), cUnis C(3), ;
                     Descrs C(20), FaixaIs N(12,2), FaixaFs N(12,2), Pvens N(12,2), ;
                     Qtds N(12,3), Pesos N(12,3), TotQtds N(12,2), TotPesos N(12,3), ;
                     cUnips C(3))
                INDEX ON cResps + Cgrus + ;
                         STR(FaixaIs,12,2) + STR(FaixaFs,12,2) + ;
                         STR(Ps,2) + STR(Pvens,12,2) + ;
                         cUnis + cUnips TAG Quebra

                *-- Buscar faixas de preco em SigCdPpc/SigCdPpi
                IF USED("cursor_4c_TmpProP")
                    USE IN cursor_4c_TmpProP
                ENDIF
                loc_cSQL = "SELECT a.codigos, b.descrs, b.faixafs, b.faixais " + ;
                           "FROM SigCdPpc a, SigCdPpi b " + ;
                           "WHERE a.ngrupos = 1 AND a.cidchaves = b.fkchaves"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpProP") < 1
                    THIS.this_cMensagemErro = "Falha ao buscar faixas de pre" + ;
                                             CHR(231) + CHR(227) + "o (TmpProp)"
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                ELSE
                    SELECT cursor_4c_TmpProP
                    INDEX ON Codigos + STR(Faixais,12,2) + STR(FaixaFs,12,2) TAG Codigos

                    *-- Preparar datetime para posicao retroativa (?pDat em SQLEXEC)
                    pDat = fDtoSQL(THIS.this_dDataSaldo, "23:59:59")

                    *-- Loop pelos pares Empresa/Grupo do cursor CsEstoque
                    loc_lSucesso = .T.
                    loc_cAlias   = THIS.this_cCursorEstoque
                    SELECT (loc_cAlias)
                    SCAN
                        IF EMPTY(Grupos) AND EMPTY(Emps)
                            LOOP
                        ENDIF
                        SCATTER MEMVAR

                        *-- Montar SQL de movimentos (Atual ou Retroativo)
                        IF THIS.this_nNrPeriodo = 1
                            loc_cSQL = "SELECT a.Cpros, 'E' AS Opers, " + ;
                                       "SUM(a.Sqtds) AS Sqtds, SUM(a.sPesos) AS sPesos, " + ;
                                       "b.cUnis, b.pVens, b.Moevs, b.Cgrus, b.cUniPs " + ;
                                       "FROM SigMvEst a, SigCdPro b, SigCdGrp c " + ;
                                       "WHERE a.Grupos = " + EscaparSQL(m.Grupos) + ;
                                       IIF(EMPTY(m.Emps), "", ;
                                           " AND a.Emps = " + EscaparSQL(m.Emps)) + ;
                                       " AND a.Cpros = b.Cpros" + ;
                                       " AND a.Grupos = c.CGrus" + ;
                                       " AND c.Mercs = " + EscaparSQL(loc_cGde) + ;
                                       " GROUP BY a.Cpros, b.cUnis, b.pVens, " + ;
                                       "b.Moevs, b.Cgrus, b.cUniPs"
                        ELSE
                            loc_cSQL = "SELECT a.Cpros, a.Opers, " + ;
                                       "SUM(a.Qtds) AS Sqtds, SUM(a.Pesos) AS sPesos, " + ;
                                       "b.cUnis, b.pVens, b.Moevs, b.Cgrus, b.cUniPs " + ;
                                       "FROM SigMvHst a, SigCdPro b, SigCdGrp c " + ;
                                       "WHERE a.Grupos = " + EscaparSQL(m.Grupos) + ;
                                       " AND a.Datas <= ?pDat" + ;
                                       IIF(EMPTY(m.Emps), "", ;
                                           " AND a.Emps = " + EscaparSQL(m.Emps)) + ;
                                       " AND a.Cpros = b.Cpros" + ;
                                       " AND a.Grupos = c.CGrus" + ;
                                       " AND c.Mercs = " + EscaparSQL(loc_cGde) + ;
                                       " GROUP BY a.Cpros, a.Opers, b.cUnis, b.pVens, " + ;
                                       "b.Moevs, b.Cgrus, b.cUniPs"
                        ENDIF

                        IF USED("cursor_4c_TmpEst")
                            USE IN cursor_4c_TmpEst
                        ENDIF
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpEst") < 1
                            THIS.this_cMensagemErro = "Falha ao buscar movimentos de estoque (TmpEst)"
                            MsgErro(THIS.this_cMensagemErro, "Erro")
                            loc_lSucesso = .F.
                            EXIT
                        ENDIF

                        SELECT cursor_4c_TmpEst
                        SCAN
                            IF cursor_4c_TmpEst.Sqtds = 0 AND cursor_4c_TmpEst.sPesos = 0
                                LOOP
                            ENDIF
                            SCATTER MEMVAR

                            *-- Buscar caracteristica do produto em SigCdPft
                            IF USED("cursor_4c_TmpProft")
                                USE IN cursor_4c_TmpProft
                            ENDIF
                            loc_cSQL = "SELECT Resps FROM SigCdPft " + ;
                                       "WHERE cTits = " + EscaparSQL(PADR(ALLTRIM(loc_cCarac), 20)) + ;
                                       " AND Cpros = " + EscaparSQL(m.Cpros)
                            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpProft") < 1
                                THIS.this_cMensagemErro = "Falha ao buscar caracter" + ;
                                                         CHR(237) + "sticas (TmpProft)"
                                MsgErro(THIS.this_cMensagemErro, "Erro")
                                loc_lSucesso = .F.
                                EXIT
                            ENDIF

                            *-- Extrair resposta da caracteristica
                            SELECT cursor_4c_TmpProft
                            GO TOP
                            loc_cResp = ""
                            IF !EOF("cursor_4c_TmpProft")
                                loc_cResp = STRTRAN(cursor_4c_TmpProft.Resps, CHR(13), "")
                                loc_cResp = STRTRAN(loc_cResp, CHR(10), "")
                                loc_cResp = LEFT(loc_cResp, 100)
                            ENDIF
                            loc_cResp = PADR(IIF(EMPTY(loc_cResp), " ", loc_cResp), 100)

                            *-- Converter preco para moeda de referencia
                            loc_nPVen = m.pVens
                            IF m.Moevs <> THIS.this_cCdMoeda
                                loc_nCota = fBuscarCotacao(m.Moevs, DATE())
                                IF loc_nCota = 0
                                    loc_nCota = 1
                                ENDIF
                                loc_nPVen = ROUND(m.pVens * loc_nCota / loc_nCotMoe, 2)
                            ENDIF

                            *-- Localizar faixa de preco no TmpProP
                            SELECT cursor_4c_TmpProP
                            LOCATE FOR cursor_4c_TmpProP.Codigos = m.Cgrus AND ;
                                       BETWEEN(loc_nPVen, ;
                                               cursor_4c_TmpProP.FaixaIs, ;
                                               cursor_4c_TmpProP.FaixaFs)
                            IF !EOF("cursor_4c_TmpProP")
                                loc_cChaveBusca = loc_cResp + m.Cgrus + ;
                                                 STR(cursor_4c_TmpProP.Faixais, 12, 2) + ;
                                                 STR(cursor_4c_TmpProP.FaixaFs, 12, 2) + ;
                                                 STR(1, 2) + ;
                                                 STR(loc_nPVen, 12, 2) + ;
                                                 m.cUnis + m.cUniPs
                                SELECT CsRelatorio
                                IF !SEEK(loc_cChaveBusca)
                                    APPEND BLANK
                                    REPLACE cResps   WITH loc_cResp, ;
                                            Cgrus    WITH m.Cgrus, ;
                                            cUnis    WITH m.cUnis, ;
                                            Descrs   WITH cursor_4c_TmpProP.Descrs, ;
                                            FaixaIs  WITH cursor_4c_TmpProP.FaixaIs, ;
                                            FaixaFs  WITH cursor_4c_TmpProP.FaixaFs, ;
                                            Pvens    WITH loc_nPVen, ;
                                            cUnips   WITH m.cUniPs, ;
                                            ps       WITH 1, ;
                                            cTits    WITH loc_cCarac
                                ENDIF
                                REPLACE Qtds     WITH Qtds + ;
                                                     (m.Sqtds * IIF(m.Opers = "E", 1, -1)), ;
                                        Pesos    WITH Pesos + ;
                                                     (m.sPesos * IIF(m.Opers = "E", 1, -1)), ;
                                        TotQtds  WITH ROUND(Qtds * Pvens, 2), ;
                                        TotPesos WITH ROUND(Pesos * Pvens, 2)
                            ENDIF
                        ENDSCAN

                        IF !loc_lSucesso
                            EXIT
                        ENDIF
                    ENDSCAN

                    *-- Gerar linhas de subtotal e total geral via VFP UNION ALL local
                    IF loc_lSucesso AND RECCOUNT("CsRelatorio") > 0
                        SELECT cTits, cResps, Cgrus, 9 AS Ps, cUnis, ;
                               SPACE(20) AS Descrs, FaixaIs, FaixaFs, ;
                               0 AS Pvens, cUnips, ;
                               SUM(Qtds) AS Qtds, SUM(Pesos) AS Pesos, ;
                               SUM(TotQtds) AS TotQtds ;
                               FROM CsRelatorio ;
                               GROUP BY cTits, cResps, Cgrus, cUnis, FaixaIs, FaixaFs, cUnips ;
                        UNION ALL ;
                        SELECT cTits, REPLICATE(CHR(254), 100) AS cResps, ;
                               REPLICATE(CHR(254), 3) AS Cgrus, ;
                               9 AS Ps, cUnis, ;
                               PADR("Total Geral", 20) AS Descrs, ;
                               00000000.00 AS FaixaIs, 000000000.00 AS FaixaFs, ;
                               0 AS Pvens, cUnips, ;
                               SUM(Qtds) AS Qtds, SUM(Pesos) AS Pesos, ;
                               SUM(TotQtds) AS TotQtds ;
                               FROM CsRelatorio ;
                               GROUP BY cTits, cUnis, cUnips ;
                        INTO CURSOR cursor_4c_DbTotal

                        SELECT CsRelatorio
                        APPEND FROM DBF("cursor_4c_DbTotal")

                        IF USED("cursor_4c_DbTotal")
                            USE IN cursor_4c_DbTotal
                        ENDIF
                    ENDIF

                    IF loc_lSucesso
                        SELECT CsRelatorio
                        GO TOP
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF

                *-- Limpar cursores temporarios
                IF USED("cursor_4c_TmpProP")
                    USE IN cursor_4c_TmpProP
                ENDIF
                IF USED("cursor_4c_TmpEst")
                    USE IN cursor_4c_TmpEst
                ENDIF
                IF USED("cursor_4c_TmpProft")
                    USE IN cursor_4c_TmpProft
                ENDIF
            ENDIF
            ENDIF
            ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em PrepararDados")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGridEstoque - Verifica duplicidades e inconsistencias no CsEstoque
    * Retorna .T. se valido, .F. se ha problemas
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGridEstoque()
        LOCAL loc_lValido, loc_cGrupo, loc_cEmp, loc_cAlias

        loc_lValido  = .T.
        loc_cAlias   = THIS.this_cCursorEstoque

        IF !USED(loc_cAlias)
            RETURN .T.
        ENDIF

        IF USED("cursor_4c_ChecDados")
            USE IN cursor_4c_ChecDados
        ENDIF

        SELECT * FROM (m.loc_cAlias) INTO CURSOR cursor_4c_ChecDados READWRITE ;
               WHERE !EMPTY(Grupos) OR !EMPTY(Emps)

        IF RECCOUNT("cursor_4c_ChecDados") = 0
            IF USED("cursor_4c_ChecDados")
                USE IN cursor_4c_ChecDados
            ENDIF
            RETURN .T.
        ENDIF

        SELECT cursor_4c_ChecDados
        INDEX ON Grupos + Emps TAG Grupos
        GO TOP

        SCAN
            loc_cGrupo = cursor_4c_ChecDados.Grupos
            loc_cEmp   = cursor_4c_ChecDados.Emps
            SKIP
            IF !EOF("cursor_4c_ChecDados")
                IF cursor_4c_ChecDados.Grupos = loc_cGrupo AND ;
                   cursor_4c_ChecDados.Emps = loc_cEmp
                    THIS.this_cMensagemErro = "Inconsist" + CHR(234) + "ncia na grade de Estoque: " + ;
                                             ALLTRIM(loc_cEmp) + "/" + ALLTRIM(loc_cGrupo) + ;
                                             " est" + CHR(225) + " duplicado"
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                    loc_lValido = .F.
                    EXIT
                ENDIF
                IF ALLTRIM(loc_cEmp) = "" AND ;
                   cursor_4c_ChecDados.Grupos = loc_cGrupo
                    THIS.this_cMensagemErro = "Inconsist" + CHR(234) + ;
                                             "ncia na grade de Estoque: Grupo:" + ;
                                             ALLTRIM(loc_cGrupo) + ;
                                             " com empresa em branco " + ;
                                             "n" + CHR(227) + "o pode estar relacionado " + ;
                                             "com outra empresa"
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                    loc_lValido = .F.
                    EXIT
                ENDIF
                SKIP -1
            ENDIF
        ENDSCAN

        IF USED("cursor_4c_ChecDados")
            USE IN cursor_4c_ChecDados
        ENDIF
        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cArquivoFRX) PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao visualizar relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime com dialogo de selecao de impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cArquivoFRX) TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao imprimir relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirDireto - Prepara dados e imprime sem dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirDireto()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cArquivoFRX) TO PRINTER NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao imprimir relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro registrada
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Nao aplicavel a relatorios
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("CsRelatorio")
            USE IN CsRelatorio
        ENDIF
        IF USED("csCabecalho")
            USE IN csCabecalho
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
